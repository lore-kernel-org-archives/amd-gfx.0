From: Alex Deucher <alexdeucher@gmail.com>
Subject: [PATCH] drm/amd/powerplay: fix mclk not switching back after multi-head was disabled
Date: Mon, 19 Sep 2016 12:22:42 -0400
Message-ID: <1474302162-13007-1-git-send-email-alexander.deucher@amd.com>
Return-path: <stable-owner@vger.kernel.org>
Sender: stable-owner@vger.kernel.org
To: amd-gfx@lists.freedesktop.org
Cc: Rex Zhu <Rex.Zhu@amd.com>, Alex Deucher <alexander.deucher@amd.com>, stable@vger.kernel.org
List-Id: amd-gfx.lists.freedesktop.org

From: Rex Zhu <Rex.Zhu@amd.com>

Signed-off-by: Rex Zhu <Rex.Zhu@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Cc: stable@vger.kernel.org
---
 drivers/gpu/drm/amd/powerplay/eventmgr/eventactionchains.c | 2 ++
 drivers/gpu/drm/amd/powerplay/eventmgr/psm.c               | 3 ++-
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/powerplay/eventmgr/eventactionchains.c b/drivers/gpu/drm/amd/powerplay/eventmgr/eventactionchains.c
index 635fc4b..92b1178 100644
--- a/drivers/gpu/drm/amd/powerplay/eventmgr/eventactionchains.c
+++ b/drivers/gpu/drm/amd/powerplay/eventmgr/eventactionchains.c
@@ -262,6 +262,8 @@ static const pem_event_action * const display_config_change_event[] = {
 	unblock_adjust_power_state_tasks,
 	set_cpu_power_state,
 	notify_hw_power_source_tasks,
+	get_2d_performance_state_tasks,
+	set_performance_state_tasks,
 	/* updateDALConfigurationTasks,
 	variBrightDisplayConfigurationChangeTasks, */
 	adjust_power_state_tasks,
diff --git a/drivers/gpu/drm/amd/powerplay/eventmgr/psm.c b/drivers/gpu/drm/amd/powerplay/eventmgr/psm.c
index 1d1875a..4899088 100644
--- a/drivers/gpu/drm/amd/powerplay/eventmgr/psm.c
+++ b/drivers/gpu/drm/amd/powerplay/eventmgr/psm.c
@@ -101,11 +101,12 @@ int psm_adjust_power_state_dynamic(struct pp_eventmgr *eventmgr, bool skip)
 	if (requested == NULL)
 		return 0;
 
+	phm_apply_state_adjust_rules(hwmgr, requested, pcurrent);
+
 	if (pcurrent == NULL || (0 != phm_check_states_equal(hwmgr, &pcurrent->hardware, &requested->hardware, &equal)))
 		equal = false;
 
 	if (!equal || phm_check_smc_update_required_for_display_configuration(hwmgr)) {
-		phm_apply_state_adjust_rules(hwmgr, requested, pcurrent);
 		phm_set_power_state(hwmgr, &pcurrent->hardware, &requested->hardware);
 		memcpy(hwmgr->current_ps, hwmgr->request_ps, hwmgr->ps_size);
 	}
-- 
2.5.5
