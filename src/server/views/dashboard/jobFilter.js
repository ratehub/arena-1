let safeEval = require('safe-eval');

function filterJobs(jobs, filter){
    let filteredJobs = [];
    for(let job of jobs){
        if (safeEval(filter, job) === true) {
            filteredJobs.push(job);
        }
    }

    return filteredJobs;
}

module.exports = filterJobs;