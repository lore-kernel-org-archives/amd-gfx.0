From: Eric Anholt <eric@anholt.net>
Subject: [PATCH] drm/sched: Always trace the dependencies we wait on, to fix a race.
Date: Fri,  7 Dec 2018 11:16:53 -0800
Message-ID: <20181207191653.30118-1-eric@anholt.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org, christian.koenig@amd.com
Cc: linux-kernel@vger.kernel.org, Eric Anholt <eric@anholt.net>
List-Id: amd-gfx.lists.freedesktop.org

The entity->dependency can go away completely once we've called
drm_sched_entity_add_dependency_cb() (if the cb is called before we
get around to tracing).  The tracepoint is more useful if we trace
every dependency instead of just ones that get callbacks installed,
anyway, so just do that.

Fixes any easy-to-produce OOPS when tracing the scheduler on V3D with
"perf record -a -e gpu_scheduler:.\* glxgears" and DEBUG_SLAB enabled.

Signed-off-by: Eric Anholt <eric@anholt.net>
---
 drivers/gpu/drm/scheduler/sched_entity.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/scheduler/sched_entity.c b/drivers/gpu/drm/scheduler/sched_entity.c
index 4463d3826ecb..e2942c9a11a7 100644
--- a/drivers/gpu/drm/scheduler/sched_entity.c
+++ b/drivers/gpu/drm/scheduler/sched_entity.c
@@ -440,13 +440,10 @@ struct drm_sched_job *drm_sched_entity_pop_job(struct drm_sched_entity *entity)
 
 	while ((entity->dependency =
 			sched->ops->dependency(sched_job, entity))) {
+		trace_drm_sched_job_wait_dep(sched_job, entity->dependency);
 
-		if (drm_sched_entity_add_dependency_cb(entity)) {
-
-			trace_drm_sched_job_wait_dep(sched_job,
-						     entity->dependency);
+		if (drm_sched_entity_add_dependency_cb(entity))
 			return NULL;
-		}
 	}
 
 	/* skip jobs from entity that marked guilty */
-- 
2.20.0.rc1
