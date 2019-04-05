class BranchComparison < ApplicationRecord
  has_many :branch_test_runs
  has_many :branches, through: :branch_test_runs

  # @param branch [Branch] the branch for which we collect the queries
  # @return [BranchTestRun] the branch test run with the collected queries
  def collect_branch_queries(branch)
    raise StandardError.new('branch queries already collected') if branch_test_runs.where(branch: branch).count > 0
    raise StandardError.new('already two branches') if branch_test_runs.count >= 2

    branch_test_run = branch_test_runs.create(branch: branch)

    branch_test_run.collect_queries(EXTERNAL_DATABASE[:name])

    return branch_test_run
  end

  # @param branch [Branch] the branch for which we want to find the additional queries
  # @return [Array[String]] queries which are in the passed branch, but not in the other one
  def additional_queries_for_branch(branch, remove_noise=true)
    branch_1_test_run = branch_test_runs.where(branch: branch).first
    branch_2_test_run = branch_test_runs.where.not(branch: branch).first

    additional_queries = branch_1_test_run.app_queries - branch_2_test_run.app_queries

    if remove_noise
      additional_queries.select! do |query|
        !query.query.include?('pg_temp') &&
            !query.query.include?('pg_namespace') &&
            !query.query.include?('schema_migrations') &&
            !query.query.include?('pg_advisory_unlock') &&
            !query.query.include?('pg_try_advisory_lock') &&
            !query.query.include?('ar_internal_metadata') &&
            (query.query =~ /^TRUNCATE|^ALTER|^DROP|^CREATE|^SAVEPOINT|^RELEASE/).nil?
      end
    end

    # try to also remove queries which are textually identical, in case they were missed using queryid
    additional_queries_text = additional_queries.map(&:query) - branch_2_test_run.app_queries.map(&:query)

    return additional_queries_text.sort
  end
end
