From: Alex Deucher <alexdeucher@gmail.com>
Subject: [PATCH 1/2] drm/radeon/si/dpm: fix phase shedding setup
Date: Tue, 27 Sep 2016 14:58:17 -0400
Message-ID: <1475002698-24318-1-git-send-email-alexander.deucher@amd.com>
Return-path: <stable-owner@vger.kernel.org>
Sender: stable-owner@vger.kernel.org
To: amd-gfx@lists.freedesktop.org
Cc: Alex Deucher <alexander.deucher@amd.com>, stable@vger.kernel.org
List-Id: amd-gfx.lists.freedesktop.org

Used the wrong index to setup the phase shedding mask.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Cc: stable@vger.kernel.org
---
 drivers/gpu/drm/radeon/si_dpm.c       | 2 +-
 drivers/gpu/drm/radeon/sislands_smc.h | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/radeon/si_dpm.c b/drivers/gpu/drm/radeon/si_dpm.c
index 1f78ec2..89bdf20 100644
--- a/drivers/gpu/drm/radeon/si_dpm.c
+++ b/drivers/gpu/drm/radeon/si_dpm.c
@@ -4112,7 +4112,7 @@ static int si_populate_smc_voltage_tables(struct radeon_device *rdev,
 							      &rdev->pm.dpm.dyn_state.phase_shedding_limits_table)) {
 				si_populate_smc_voltage_table(rdev, &si_pi->vddc_phase_shed_table, table);
 
-				table->phaseMaskTable.lowMask[SISLANDS_SMC_VOLTAGEMASK_VDDC] =
+				table->phaseMaskTable.lowMask[SISLANDS_SMC_VOLTAGEMASK_VDDC_PHASE_SHEDDING] =
 					cpu_to_be32(si_pi->vddc_phase_shed_table.mask_low);
 
 				si_write_smc_soft_register(rdev, SI_SMC_SOFT_REGISTER_phase_shedding_delay,
diff --git a/drivers/gpu/drm/radeon/sislands_smc.h b/drivers/gpu/drm/radeon/sislands_smc.h
index 3c77983..966e3a5 100644
--- a/drivers/gpu/drm/radeon/sislands_smc.h
+++ b/drivers/gpu/drm/radeon/sislands_smc.h
@@ -194,6 +194,7 @@ typedef struct SISLANDS_SMC_SWSTATE SISLANDS_SMC_SWSTATE;
 #define SISLANDS_SMC_VOLTAGEMASK_VDDC  0
 #define SISLANDS_SMC_VOLTAGEMASK_MVDD  1
 #define SISLANDS_SMC_VOLTAGEMASK_VDDCI 2
+#define SISLANDS_SMC_VOLTAGEMASK_VDDC_PHASE_SHEDDING 3
 #define SISLANDS_SMC_VOLTAGEMASK_MAX   4
 
 struct SISLANDS_SMC_VOLTAGEMASKTABLE
-- 
2.5.5
