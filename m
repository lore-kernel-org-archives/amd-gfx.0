From: Pravin Shedge <pravin.shedge4linux@gmail.com>
Subject: [PATCH 04/45] gpu: drm: remove duplicate includes
Date: Sat, 16 Dec 2017 17:24:52 +0530
Message-ID: <1513425292-6510-1-git-send-email-pravin.shedge4linux@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: alexander.deucher@amd.com, christian.koenig@amd.com, airlied@linux.ie, oded.gabbay@gmail.com, architt@codeaurora.org, a.hajda@samsung.com, Laurent.pinchart@ideasonboard.com, daniel.vetter@intel.com, jani.nikula@linux.intel.com, seanpaul@chromium.org, joonas.lahtinen@linux.intel.com, rodrigo.vivi@intel.com, bskeggs@redhat.com, thierry.reding@gmail.com, amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org, nouveau@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc: pravin.shedge4linux@gmail.com
List-Id: amd-gfx.lists.freedesktop.org

These duplicate includes have been found with scripts/checkincludes.pl but
they have been removed manually to avoid removing false positives.

Signed-off-by: Pravin Shedge <pravin.shedge4linux@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c                     | 1 -
 drivers/gpu/drm/amd/amdgpu/mxgpu_vi.c                     | 1 -
 drivers/gpu/drm/amd/amdgpu/vce_v3_0.c                     | 1 -
 drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager_vi.c  | 1 -
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c         | 3 ---
 drivers/gpu/drm/amd/display/dc/dce80/dce80_resource.c     | 1 -
 drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c | 1 -
 drivers/gpu/drm/amd/powerplay/smumgr/polaris10_smumgr.c   | 1 -
 drivers/gpu/drm/amd/powerplay/smumgr/rv_smumgr.c          | 1 -
 drivers/gpu/drm/bridge/panel.c                            | 1 -
 drivers/gpu/drm/drm_drv.c                                 | 1 -
 drivers/gpu/drm/i915/intel_dsi_vbt.c                      | 1 -
 drivers/gpu/drm/nouveau/nvkm/subdev/bus/nv04.c            | 2 --
 drivers/gpu/drm/panel/panel-raspberrypi-touchscreen.c     | 1 -
 14 files changed, 17 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
index 9ecdf62..7fd0599 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
@@ -44,7 +44,6 @@
 #include "gca/gfx_8_0_d.h"
 #include "gca/gfx_8_0_enum.h"
 #include "gca/gfx_8_0_sh_mask.h"
-#include "gca/gfx_8_0_enum.h"
 
 #include "dce/dce_10_0_d.h"
 #include "dce/dce_10_0_sh_mask.h"
diff --git a/drivers/gpu/drm/amd/amdgpu/mxgpu_vi.c b/drivers/gpu/drm/amd/amdgpu/mxgpu_vi.c
index c25a831..aad4134 100644
--- a/drivers/gpu/drm/amd/amdgpu/mxgpu_vi.c
+++ b/drivers/gpu/drm/amd/amdgpu/mxgpu_vi.c
@@ -37,7 +37,6 @@
 #include "gmc/gmc_8_2_sh_mask.h"
 #include "oss/oss_3_0_d.h"
 #include "oss/oss_3_0_sh_mask.h"
-#include "gca/gfx_8_0_sh_mask.h"
 #include "dce/dce_10_0_d.h"
 #include "dce/dce_10_0_sh_mask.h"
 #include "smu/smu_7_1_3_d.h"
diff --git a/drivers/gpu/drm/amd/amdgpu/vce_v3_0.c b/drivers/gpu/drm/amd/amdgpu/vce_v3_0.c
index cf81065..b526623 100644
--- a/drivers/gpu/drm/amd/amdgpu/vce_v3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vce_v3_0.c
@@ -34,7 +34,6 @@
 #include "vce/vce_3_0_sh_mask.h"
 #include "oss/oss_3_0_d.h"
 #include "oss/oss_3_0_sh_mask.h"
-#include "gca/gfx_8_0_d.h"
 #include "smu/smu_7_1_2_d.h"
 #include "smu/smu_7_1_2_sh_mask.h"
 #include "gca/gfx_8_0_d.h"
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager_vi.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager_vi.c
index 2fbce57..8266a3f 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager_vi.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager_vi.c
@@ -24,7 +24,6 @@
 #include "kfd_device_queue_manager.h"
 #include "gca/gfx_8_0_enum.h"
 #include "gca/gfx_8_0_sh_mask.h"
-#include "gca/gfx_8_0_enum.h"
 #include "oss/oss_3_0_sh_mask.h"
 
 static bool set_cache_memory_policy_vi(struct device_queue_manager *dqm,
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index f71fe6d..b825dcb 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -23,7 +23,6 @@
  *
  */
 
-#include "dm_services_types.h"
 #include "dc.h"
 #include "dc/inc/core_types.h"
 
@@ -66,8 +65,6 @@
 #include "soc15_common.h"
 #endif
 
-#include "modules/inc/mod_freesync.h"
-
 #include "i2caux_interface.h"
 
 /* basic init/fini API */
diff --git a/drivers/gpu/drm/amd/display/dc/dce80/dce80_resource.c b/drivers/gpu/drm/amd/display/dc/dce80/dce80_resource.c
index 9c18efd..3f55dbc 100644
--- a/drivers/gpu/drm/amd/display/dc/dce80/dce80_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dce80/dce80_resource.c
@@ -40,7 +40,6 @@
 #include "dce/dce_mem_input.h"
 #include "dce/dce_link_encoder.h"
 #include "dce/dce_stream_encoder.h"
-#include "dce/dce_mem_input.h"
 #include "dce/dce_ipp.h"
 #include "dce/dce_transform.h"
 #include "dce/dce_opp.h"
diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
index 961ad5c..8d5d4c2 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
@@ -39,7 +39,6 @@
 #include "ipp.h"
 #include "mpc.h"
 #include "reg_helper.h"
-#include "custom_float.h"
 #include "dcn10_hubp.h"
 
 #define CTX \
diff --git a/drivers/gpu/drm/amd/powerplay/smumgr/polaris10_smumgr.c b/drivers/gpu/drm/amd/powerplay/smumgr/polaris10_smumgr.c
index bd6be77..ebbe8a1 100644
--- a/drivers/gpu/drm/amd/powerplay/smumgr/polaris10_smumgr.c
+++ b/drivers/gpu/drm/amd/powerplay/smumgr/polaris10_smumgr.c
@@ -44,7 +44,6 @@
 
 #include "smu7_hwmgr.h"
 #include "hardwaremanager.h"
-#include "ppatomctrl.h"
 #include "atombios.h"
 #include "pppcielanes.h"
 
diff --git a/drivers/gpu/drm/amd/powerplay/smumgr/rv_smumgr.c b/drivers/gpu/drm/amd/powerplay/smumgr/rv_smumgr.c
index b98ade6..cd9c9b9 100644
--- a/drivers/gpu/drm/amd/powerplay/smumgr/rv_smumgr.c
+++ b/drivers/gpu/drm/amd/powerplay/smumgr/rv_smumgr.c
@@ -29,7 +29,6 @@
 #include "rv_ppsmc.h"
 #include "smu10_driver_if.h"
 #include "smu10.h"
-#include "ppatomctrl.h"
 #include "pp_debug.h"
 #include "smu_ucode_xfer_vi.h"
 #include "smu7_smumgr.h"
diff --git a/drivers/gpu/drm/bridge/panel.c b/drivers/gpu/drm/bridge/panel.c
index 6d99d4a..89e8d68 100644
--- a/drivers/gpu/drm/bridge/panel.c
+++ b/drivers/gpu/drm/bridge/panel.c
@@ -15,7 +15,6 @@
 #include <drm/drm_crtc_helper.h>
 #include <drm/drm_encoder.h>
 #include <drm/drm_modeset_helper_vtables.h>
-#include <drm/drm_panel.h>
 
 struct panel_bridge {
 	struct drm_bridge bridge;
diff --git a/drivers/gpu/drm/drm_drv.c b/drivers/gpu/drm/drm_drv.c
index a934fd5..11f2461 100644
--- a/drivers/gpu/drm/drm_drv.c
+++ b/drivers/gpu/drm/drm_drv.c
@@ -39,7 +39,6 @@
 #include "drm_crtc_internal.h"
 #include "drm_legacy.h"
 #include "drm_internal.h"
-#include "drm_crtc_internal.h"
 
 /*
  * drm_debug: Enable debug output.
diff --git a/drivers/gpu/drm/i915/intel_dsi_vbt.c b/drivers/gpu/drm/i915/intel_dsi_vbt.c
index 91c07b0..0d6e999 100644
--- a/drivers/gpu/drm/i915/intel_dsi_vbt.c
+++ b/drivers/gpu/drm/i915/intel_dsi_vbt.c
@@ -32,7 +32,6 @@
 #include <linux/slab.h>
 #include <video/mipi_display.h>
 #include <asm/intel-mid.h>
-#include <video/mipi_display.h>
 #include "i915_drv.h"
 #include "intel_drv.h"
 #include "intel_dsi.h"
diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/bus/nv04.c b/drivers/gpu/drm/nouveau/nvkm/subdev/bus/nv04.c
index c80b967..2b44ba5 100644
--- a/drivers/gpu/drm/nouveau/nvkm/subdev/bus/nv04.c
+++ b/drivers/gpu/drm/nouveau/nvkm/subdev/bus/nv04.c
@@ -26,8 +26,6 @@
 
 #include <subdev/gpio.h>
 
-#include <subdev/gpio.h>
-
 static void
 nv04_bus_intr(struct nvkm_bus *bus)
 {
diff --git a/drivers/gpu/drm/panel/panel-raspberrypi-touchscreen.c b/drivers/gpu/drm/panel/panel-raspberrypi-touchscreen.c
index 890fd6f..b9afb13 100644
--- a/drivers/gpu/drm/panel/panel-raspberrypi-touchscreen.c
+++ b/drivers/gpu/drm/panel/panel-raspberrypi-touchscreen.c
@@ -57,7 +57,6 @@
 #include <drm/drmP.h>
 #include <drm/drm_crtc.h>
 #include <drm/drm_mipi_dsi.h>
-#include <drm/drm_panel.h>
 
 #define RPI_DSI_DRIVER_NAME "rpi-ts-dsi"
 
-- 
2.7.4
