From: "Zhu, Rex" <Rex.Zhu-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH 2/2] drm/amd/powerplay: use soc15 common macros instead of
 vega10 specific
Date: Tue, 10 Apr 2018 05:27:06 +0000
Message-ID: <CY4PR12MB1687981C7066CC1F99DF3B46FBBE0@CY4PR12MB1687.namprd12.prod.outlook.com>
References: <1523335231-22245-1-git-send-email-evan.quan@amd.com>,
 <1523335231-22245-2-git-send-email-evan.quan@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1872829856=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1523335231-22245-2-git-send-email-evan.quan-5C7GfCeVMHo@public.gmane.org>
Content-Language: en-US
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/amd-gfx>,
 <mailto:amd-gfx-request-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
List-Help: <mailto:amd-gfx-request-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org?subject=subscribe>
Errors-To: amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Sender: "amd-gfx" <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
To: "Quan, Evan" <Evan.Quan-5C7GfCeVMHo@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

--===============1872829856==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_CY4PR12MB1687981C7066CC1F99DF3B46FBBE0CY4PR12MB1687namp_"

--_000_CY4PR12MB1687981C7066CC1F99DF3B46FBBE0CY4PR12MB1687namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Series is:

Reviewed-by: Rex Zhu <Rex.Zhu-5C7GfCeVMHo@public.gmane.org>


Best Regards

Rex



________________________________
From: Evan Quan <evan.quan-5C7GfCeVMHo@public.gmane.org>
Sent: Tuesday, April 10, 2018 12:40 PM
To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Cc: Zhu, Rex; Quan, Evan
Subject: [PATCH 2/2] drm/amd/powerplay: use soc15 common macros instead of =
vega10 specific

pp_soc15.h is vega10 specific. Update powerplay code to use soc15 common
macros defined in soc15_common.h.

Change-Id: I43c9a89e1a1f5d9a031465e2c2ba1525486aba9a
Signed-off-by: Evan Quan <evan.quan-5C7GfCeVMHo@public.gmane.org>
---
 drivers/gpu/drm/amd/powerplay/hwmgr/smu10_hwmgr.c  |   7 +-
 drivers/gpu/drm/amd/powerplay/hwmgr/vega10_hwmgr.c |  16 +--
 .../gpu/drm/amd/powerplay/hwmgr/vega10_powertune.c |  50 ++++------
 .../gpu/drm/amd/powerplay/hwmgr/vega10_thermal.c   | 107 ++++++++---------=
----
 drivers/gpu/drm/amd/powerplay/hwmgr/vega12_hwmgr.c |   1 -
 .../gpu/drm/amd/powerplay/hwmgr/vega12_thermal.c   |  37 +++----
 drivers/gpu/drm/amd/powerplay/inc/pp_soc15.h       |  52 ----------
 .../gpu/drm/amd/powerplay/smumgr/smu10_smumgr.c    |  37 +++----
 .../gpu/drm/amd/powerplay/smumgr/vega10_smumgr.c   |  50 ++++------
 .../gpu/drm/amd/powerplay/smumgr/vega12_smumgr.c   |  56 ++++-------
 10 files changed, 133 insertions(+), 280 deletions(-)
 delete mode 100644 drivers/gpu/drm/amd/powerplay/inc/pp_soc15.h

diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/smu10_hwmgr.c b/drivers/gp=
u/drm/amd/powerplay/hwmgr/smu10_hwmgr.c
index 055358b..6ba3b1f 100644
--- a/drivers/gpu/drm/amd/powerplay/hwmgr/smu10_hwmgr.c
+++ b/drivers/gpu/drm/amd/powerplay/hwmgr/smu10_hwmgr.c
@@ -34,7 +34,7 @@
 #include "rv_ppsmc.h"
 #include "smu10_hwmgr.h"
 #include "power_state.h"
-#include "pp_soc15.h"
+#include "soc15_common.h"

 #define SMU10_MAX_DEEPSLEEP_DIVIDER_ID     5
 #define SMU10_MINIMUM_ENGINE_CLOCK         800   /* 8Mhz, the low boundary=
 of engine clock allowed on this chip */
@@ -947,9 +947,8 @@ static int smu10_get_max_high_clocks(struct pp_hwmgr *h=
wmgr, struct amd_pp_simpl

 static int smu10_thermal_get_temperature(struct pp_hwmgr *hwmgr)
 {
-       uint32_t reg_offset =3D soc15_get_register_offset(THM_HWID, 0,
-                       mmTHM_TCON_CUR_TMP_BASE_IDX, mmTHM_TCON_CUR_TMP);
-       uint32_t reg_value =3D cgs_read_register(hwmgr->device, reg_offset)=
;
+       struct amdgpu_device *adev =3D hwmgr->adev;
+       uint32_t reg_value =3D RREG32_SOC15(THM, 0, mmTHM_TCON_CUR_TMP);
         int cur_temp =3D
                 (reg_value & THM_TCON_CUR_TMP__CUR_TEMP_MASK) >> THM_TCON_=
CUR_TMP__CUR_TEMP__SHIFT;

diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/vega10_hwmgr.c b/drivers/g=
pu/drm/amd/powerplay/hwmgr/vega10_hwmgr.c
index c9fb4b2..5fc2f20 100644
--- a/drivers/gpu/drm/amd/powerplay/hwmgr/vega10_hwmgr.c
+++ b/drivers/gpu/drm/amd/powerplay/hwmgr/vega10_hwmgr.c
@@ -36,7 +36,7 @@
 #include "smu9.h"
 #include "smu9_driver_if.h"
 #include "vega10_inc.h"
-#include "pp_soc15.h"
+#include "soc15_common.h"
 #include "pppcielanes.h"
 #include "vega10_hwmgr.h"
 #include "vega10_processpptables.h"
@@ -754,7 +754,6 @@ static int vega10_hwmgr_backend_init(struct pp_hwmgr *h=
wmgr)
         uint32_t config_telemetry =3D 0;
         struct pp_atomfwctrl_voltage_table vol_table;
         struct amdgpu_device *adev =3D hwmgr->adev;
-       uint32_t reg;

         data =3D kzalloc(sizeof(struct vega10_hwmgr), GFP_KERNEL);
         if (data =3D=3D NULL)
@@ -860,10 +859,7 @@ static int vega10_hwmgr_backend_init(struct pp_hwmgr *=
hwmgr)
                         advanceFanControlParameters.usFanPWMMinLimit *
                         hwmgr->thermal_controller.fanInfo.ulMaxRPM / 100;

-       reg =3D soc15_get_register_offset(DF_HWID, 0,
-                       mmDF_CS_AON0_DramBaseAddress0_BASE_IDX,
-                       mmDF_CS_AON0_DramBaseAddress0);
-       data->mem_channels =3D (cgs_read_register(hwmgr->device, reg) &
+       data->mem_channels =3D (RREG32_SOC15(DF, 0, mmDF_CS_AON0_DramBaseAd=
dress0) &
                         DF_CS_AON0_DramBaseAddress0__IntLvNumChan_MASK) >>
                         DF_CS_AON0_DramBaseAddress0__IntLvNumChan__SHIFT;
         PP_ASSERT_WITH_CODE(data->mem_channels < ARRAY_SIZE(channel_number=
),
@@ -3802,11 +3798,12 @@ static int vega10_get_gpu_power(struct pp_hwmgr *hw=
mgr,
 static int vega10_read_sensor(struct pp_hwmgr *hwmgr, int idx,
                               void *value, int *size)
 {
+       struct amdgpu_device *adev =3D hwmgr->adev;
         uint32_t sclk_idx, mclk_idx, activity_percent =3D 0;
         struct vega10_hwmgr *data =3D hwmgr->backend;
         struct vega10_dpm_table *dpm_table =3D &data->dpm_table;
         int ret =3D 0;
-       uint32_t reg, val_vid;
+       uint32_t val_vid;

         switch (idx) {
         case AMDGPU_PP_SENSOR_GFX_SCLK:
@@ -3856,10 +3853,7 @@ static int vega10_read_sensor(struct pp_hwmgr *hwmgr=
, int idx,
                 }
                 break;
         case AMDGPU_PP_SENSOR_VDDGFX:
-               reg =3D soc15_get_register_offset(SMUIO_HWID, 0,
-                       mmSMUSVI0_PLANE0_CURRENTVID_BASE_IDX,
-                       mmSMUSVI0_PLANE0_CURRENTVID);
-               val_vid =3D (cgs_read_register(hwmgr->device, reg) &
+               val_vid =3D (RREG32_SOC15(SMUIO, 0, mmSMUSVI0_PLANE0_CURREN=
TVID) &
                         SMUSVI0_PLANE0_CURRENTVID__CURRENT_SVI0_PLANE0_VID=
_MASK) >>
                         SMUSVI0_PLANE0_CURRENTVID__CURRENT_SVI0_PLANE0_VID=
__SHIFT;
                 *((uint32_t *)value) =3D (uint32_t)convert_to_vddc((uint8_=
t)val_vid);
diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/vega10_powertune.c b/drive=
rs/gpu/drm/amd/powerplay/hwmgr/vega10_powertune.c
index 203a691..a9efd855 100644
--- a/drivers/gpu/drm/amd/powerplay/hwmgr/vega10_powertune.c
+++ b/drivers/gpu/drm/amd/powerplay/hwmgr/vega10_powertune.c
@@ -27,7 +27,7 @@
 #include "vega10_ppsmc.h"
 #include "vega10_inc.h"
 #include "pp_debug.h"
-#include "pp_soc15.h"
+#include "soc15_common.h"

 static const struct vega10_didt_config_reg SEDiDtTuningCtrlConfig_Vega10[]=
 =3D
 {
@@ -888,36 +888,36 @@ static void vega10_didt_set_mask(struct pp_hwmgr *hwm=
gr, const bool enable)
         if (PP_CAP(PHM_PlatformCaps_DiDtEDCEnable)) {
                 if (PP_CAP(PHM_PlatformCaps_SQRamping)) {
                         data =3D cgs_read_ind_register(hwmgr->device, CGS_=
IND_REG__DIDT, ixDIDT_SQ_EDC_CTRL);
-                       data =3D CGS_REG_SET_FIELD(data, DIDT_SQ_EDC_CTRL, =
EDC_EN, en);
-                       data =3D CGS_REG_SET_FIELD(data, DIDT_SQ_EDC_CTRL, =
EDC_SW_RST, ~en);
+                       data =3D REG_SET_FIELD(data, DIDT_SQ_EDC_CTRL, EDC_=
EN, en);
+                       data =3D REG_SET_FIELD(data, DIDT_SQ_EDC_CTRL, EDC_=
SW_RST, ~en);
                         cgs_write_ind_register(hwmgr->device, CGS_IND_REG_=
_DIDT, ixDIDT_SQ_EDC_CTRL, data);
                 }

                 if (PP_CAP(PHM_PlatformCaps_DBRamping)) {
                         data =3D cgs_read_ind_register(hwmgr->device, CGS_=
IND_REG__DIDT, ixDIDT_DB_EDC_CTRL);
-                       data =3D CGS_REG_SET_FIELD(data, DIDT_DB_EDC_CTRL, =
EDC_EN, en);
-                       data =3D CGS_REG_SET_FIELD(data, DIDT_DB_EDC_CTRL, =
EDC_SW_RST, ~en);
+                       data =3D REG_SET_FIELD(data, DIDT_DB_EDC_CTRL, EDC_=
EN, en);
+                       data =3D REG_SET_FIELD(data, DIDT_DB_EDC_CTRL, EDC_=
SW_RST, ~en);
                         cgs_write_ind_register(hwmgr->device, CGS_IND_REG_=
_DIDT, ixDIDT_DB_EDC_CTRL, data);
                 }

                 if (PP_CAP(PHM_PlatformCaps_TDRamping)) {
                         data =3D cgs_read_ind_register(hwmgr->device, CGS_=
IND_REG__DIDT, ixDIDT_TD_EDC_CTRL);
-                       data =3D CGS_REG_SET_FIELD(data, DIDT_TD_EDC_CTRL, =
EDC_EN, en);
-                       data =3D CGS_REG_SET_FIELD(data, DIDT_TD_EDC_CTRL, =
EDC_SW_RST, ~en);
+                       data =3D REG_SET_FIELD(data, DIDT_TD_EDC_CTRL, EDC_=
EN, en);
+                       data =3D REG_SET_FIELD(data, DIDT_TD_EDC_CTRL, EDC_=
SW_RST, ~en);
                         cgs_write_ind_register(hwmgr->device, CGS_IND_REG_=
_DIDT, ixDIDT_TD_EDC_CTRL, data);
                 }

                 if (PP_CAP(PHM_PlatformCaps_TCPRamping)) {
                         data =3D cgs_read_ind_register(hwmgr->device, CGS_=
IND_REG__DIDT, ixDIDT_TCP_EDC_CTRL);
-                       data =3D CGS_REG_SET_FIELD(data, DIDT_TCP_EDC_CTRL,=
 EDC_EN, en);
-                       data =3D CGS_REG_SET_FIELD(data, DIDT_TCP_EDC_CTRL,=
 EDC_SW_RST, ~en);
+                       data =3D REG_SET_FIELD(data, DIDT_TCP_EDC_CTRL, EDC=
_EN, en);
+                       data =3D REG_SET_FIELD(data, DIDT_TCP_EDC_CTRL, EDC=
_SW_RST, ~en);
                         cgs_write_ind_register(hwmgr->device, CGS_IND_REG_=
_DIDT, ixDIDT_TCP_EDC_CTRL, data);
                 }

                 if (PP_CAP(PHM_PlatformCaps_DBRRamping)) {
                         data =3D cgs_read_ind_register(hwmgr->device, CGS_=
IND_REG__DIDT, ixDIDT_DBR_EDC_CTRL);
-                       data =3D CGS_REG_SET_FIELD(data, DIDT_DBR_EDC_CTRL,=
 EDC_EN, en);
-                       data =3D CGS_REG_SET_FIELD(data, DIDT_DBR_EDC_CTRL,=
 EDC_SW_RST, ~en);
+                       data =3D REG_SET_FIELD(data, DIDT_DBR_EDC_CTRL, EDC=
_EN, en);
+                       data =3D REG_SET_FIELD(data, DIDT_DBR_EDC_CTRL, EDC=
_SW_RST, ~en);
                         cgs_write_ind_register(hwmgr->device, CGS_IND_REG_=
_DIDT, ixDIDT_DBR_EDC_CTRL, data);
                 }
         }
@@ -933,17 +933,15 @@ static int vega10_enable_cac_driving_se_didt_config(s=
truct pp_hwmgr *hwmgr)
         struct amdgpu_device *adev =3D hwmgr->adev;
         int result;
         uint32_t num_se =3D 0, count, data;
-       uint32_t reg;

         num_se =3D adev->gfx.config.max_shader_engines;

         adev->gfx.rlc.funcs->enter_safe_mode(adev);

         mutex_lock(&adev->grbm_idx_mutex);
-       reg =3D soc15_get_register_offset(GC_HWID, 0, mmGRBM_GFX_INDEX_BASE=
_IDX, mmGRBM_GFX_INDEX);
         for (count =3D 0; count < num_se; count++) {
                 data =3D GRBM_GFX_INDEX__INSTANCE_BROADCAST_WRITES_MASK | =
GRBM_GFX_INDEX__SH_BROADCAST_WRITES_MASK | ( count << GRBM_GFX_INDEX__SE_IN=
DEX__SHIFT);
-               cgs_write_register(hwmgr->device, reg, data);
+               WREG32_SOC15(GC, 0, mmGRBM_GFX_INDEX, data);

                 result =3D  vega10_program_didt_config_registers(hwmgr, SE=
DiDtStallCtrlConfig_vega10, VEGA10_CONFIGREG_DIDT);
                 result |=3D vega10_program_didt_config_registers(hwmgr, SE=
DiDtStallPatternConfig_vega10, VEGA10_CONFIGREG_DIDT);
@@ -958,7 +956,7 @@ static int vega10_enable_cac_driving_se_didt_config(str=
uct pp_hwmgr *hwmgr)
                 if (0 !=3D result)
                         break;
         }
-       cgs_write_register(hwmgr->device, reg, 0xE0000000);
+       WREG32_SOC15(GC, 0, mmGRBM_GFX_INDEX, 0xE0000000);
         mutex_unlock(&adev->grbm_idx_mutex);

         vega10_didt_set_mask(hwmgr, true);
@@ -986,17 +984,15 @@ static int vega10_enable_psm_gc_didt_config(struct pp=
_hwmgr *hwmgr)
         struct amdgpu_device *adev =3D hwmgr->adev;
         int result;
         uint32_t num_se =3D 0, count, data;
-       uint32_t reg;

         num_se =3D adev->gfx.config.max_shader_engines;

         adev->gfx.rlc.funcs->enter_safe_mode(adev);

         mutex_lock(&adev->grbm_idx_mutex);
-       reg =3D soc15_get_register_offset(GC_HWID, 0, mmGRBM_GFX_INDEX_BASE=
_IDX, mmGRBM_GFX_INDEX);
         for (count =3D 0; count < num_se; count++) {
                 data =3D GRBM_GFX_INDEX__INSTANCE_BROADCAST_WRITES_MASK | =
GRBM_GFX_INDEX__SH_BROADCAST_WRITES_MASK | ( count << GRBM_GFX_INDEX__SE_IN=
DEX__SHIFT);
-               cgs_write_register(hwmgr->device, reg, data);
+               WREG32_SOC15(GC, 0, mmGRBM_GFX_INDEX, data);

                 result =3D vega10_program_didt_config_registers(hwmgr, SED=
iDtStallCtrlConfig_vega10, VEGA10_CONFIGREG_DIDT);
                 result |=3D vega10_program_didt_config_registers(hwmgr, SE=
DiDtStallPatternConfig_vega10, VEGA10_CONFIGREG_DIDT);
@@ -1005,7 +1001,7 @@ static int vega10_enable_psm_gc_didt_config(struct pp=
_hwmgr *hwmgr)
                 if (0 !=3D result)
                         break;
         }
-       cgs_write_register(hwmgr->device, reg, 0xE0000000);
+       WREG32_SOC15(GC, 0, mmGRBM_GFX_INDEX, 0xE0000000);
         mutex_unlock(&adev->grbm_idx_mutex);

         vega10_didt_set_mask(hwmgr, true);
@@ -1049,17 +1045,15 @@ static int vega10_enable_se_edc_config(struct pp_hw=
mgr *hwmgr)
         struct amdgpu_device *adev =3D hwmgr->adev;
         int result;
         uint32_t num_se =3D 0, count, data;
-       uint32_t reg;

         num_se =3D adev->gfx.config.max_shader_engines;

         adev->gfx.rlc.funcs->enter_safe_mode(adev);

         mutex_lock(&adev->grbm_idx_mutex);
-       reg =3D soc15_get_register_offset(GC_HWID, 0, mmGRBM_GFX_INDEX_BASE=
_IDX, mmGRBM_GFX_INDEX);
         for (count =3D 0; count < num_se; count++) {
                 data =3D GRBM_GFX_INDEX__INSTANCE_BROADCAST_WRITES_MASK | =
GRBM_GFX_INDEX__SH_BROADCAST_WRITES_MASK | ( count << GRBM_GFX_INDEX__SE_IN=
DEX__SHIFT);
-               cgs_write_register(hwmgr->device, reg, data);
+               WREG32_SOC15(GC, 0, mmGRBM_GFX_INDEX, data);
                 result =3D vega10_program_didt_config_registers(hwmgr, SED=
iDtWeightConfig_Vega10, VEGA10_CONFIGREG_DIDT);
                 result |=3D vega10_program_didt_config_registers(hwmgr, SE=
EDCStallPatternConfig_Vega10, VEGA10_CONFIGREG_DIDT);
                 result |=3D vega10_program_didt_config_registers(hwmgr, SE=
EDCStallDelayConfig_Vega10, VEGA10_CONFIGREG_DIDT);
@@ -1070,7 +1064,7 @@ static int vega10_enable_se_edc_config(struct pp_hwmg=
r *hwmgr)
                 if (0 !=3D result)
                         break;
         }
-       cgs_write_register(hwmgr->device, reg, 0xE0000000);
+       WREG32_SOC15(GC, 0, mmGRBM_GFX_INDEX, 0xE0000000);
         mutex_unlock(&adev->grbm_idx_mutex);

         vega10_didt_set_mask(hwmgr, true);
@@ -1099,7 +1093,6 @@ static int vega10_enable_psm_gc_edc_config(struct pp_=
hwmgr *hwmgr)
         int result;
         uint32_t num_se =3D 0;
         uint32_t count, data;
-       uint32_t reg;

         num_se =3D adev->gfx.config.max_shader_engines;

@@ -1108,10 +1101,9 @@ static int vega10_enable_psm_gc_edc_config(struct pp=
_hwmgr *hwmgr)
         vega10_program_gc_didt_config_registers(hwmgr, AvfsPSMResetConfig_=
vega10);

         mutex_lock(&adev->grbm_idx_mutex);
-       reg =3D soc15_get_register_offset(GC_HWID, 0, mmGRBM_GFX_INDEX_BASE=
_IDX, mmGRBM_GFX_INDEX);
         for (count =3D 0; count < num_se; count++) {
                 data =3D GRBM_GFX_INDEX__INSTANCE_BROADCAST_WRITES_MASK | =
GRBM_GFX_INDEX__SH_BROADCAST_WRITES_MASK | ( count << GRBM_GFX_INDEX__SE_IN=
DEX__SHIFT);
-               cgs_write_register(hwmgr->device, reg, data);
+               WREG32_SOC15(GC, 0, mmGRBM_GFX_INDEX, data);
                 result |=3D vega10_program_didt_config_registers(hwmgr, PS=
MSEEDCStallPatternConfig_Vega10, VEGA10_CONFIGREG_DIDT);
                 result |=3D vega10_program_didt_config_registers(hwmgr, PS=
MSEEDCStallDelayConfig_Vega10, VEGA10_CONFIGREG_DIDT);
                 result |=3D vega10_program_didt_config_registers(hwmgr, PS=
MSEEDCCtrlResetConfig_Vega10, VEGA10_CONFIGREG_DIDT);
@@ -1120,7 +1112,7 @@ static int vega10_enable_psm_gc_edc_config(struct pp_=
hwmgr *hwmgr)
                 if (0 !=3D result)
                         break;
         }
-       cgs_write_register(hwmgr->device, reg, 0xE0000000);
+       WREG32_SOC15(GC, 0, mmGRBM_GFX_INDEX, 0xE0000000);
         mutex_unlock(&adev->grbm_idx_mutex);

         vega10_didt_set_mask(hwmgr, true);
@@ -1165,14 +1157,12 @@ static int vega10_disable_psm_gc_edc_config(struct =
pp_hwmgr *hwmgr)
 static int vega10_enable_se_edc_force_stall_config(struct pp_hwmgr *hwmgr)
 {
         struct amdgpu_device *adev =3D hwmgr->adev;
-       uint32_t reg;
         int result;

         adev->gfx.rlc.funcs->enter_safe_mode(adev);

         mutex_lock(&adev->grbm_idx_mutex);
-       reg =3D soc15_get_register_offset(GC_HWID, 0, mmGRBM_GFX_INDEX_BASE=
_IDX, mmGRBM_GFX_INDEX);
-       cgs_write_register(hwmgr->device, reg, 0xE0000000);
+       WREG32_SOC15(GC, 0, mmGRBM_GFX_INDEX, 0xE0000000);
         mutex_unlock(&adev->grbm_idx_mutex);

         result =3D vega10_program_didt_config_registers(hwmgr, SEEDCForceS=
tallPatternConfig_Vega10, VEGA10_CONFIGREG_DIDT);
diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/vega10_thermal.c b/drivers=
/gpu/drm/amd/powerplay/hwmgr/vega10_thermal.c
index 9f18226..aa044c1 100644
--- a/drivers/gpu/drm/amd/powerplay/hwmgr/vega10_thermal.c
+++ b/drivers/gpu/drm/amd/powerplay/hwmgr/vega10_thermal.c
@@ -25,7 +25,7 @@
 #include "vega10_hwmgr.h"
 #include "vega10_ppsmc.h"
 #include "vega10_inc.h"
-#include "pp_soc15.h"
+#include "soc15_common.h"
 #include "pp_debug.h"

 static int vega10_get_current_rpm(struct pp_hwmgr *hwmgr, uint32_t *curren=
t_rpm)
@@ -89,6 +89,7 @@ int vega10_fan_ctrl_get_fan_speed_percent(struct pp_hwmgr=
 *hwmgr,

 int vega10_fan_ctrl_get_fan_speed_rpm(struct pp_hwmgr *hwmgr, uint32_t *sp=
eed)
 {
+       struct amdgpu_device *adev =3D hwmgr->adev;
         struct vega10_hwmgr *data =3D hwmgr->backend;
         uint32_t tach_period;
         uint32_t crystal_clock_freq;
@@ -100,10 +101,8 @@ int vega10_fan_ctrl_get_fan_speed_rpm(struct pp_hwmgr =
*hwmgr, uint32_t *speed)
         if (data->smu_features[GNLD_FAN_CONTROL].supported) {
                 result =3D vega10_get_current_rpm(hwmgr, speed);
         } else {
-               uint32_t reg =3D soc15_get_register_offset(THM_HWID, 0,
-                               mmCG_TACH_STATUS_BASE_IDX, mmCG_TACH_STATUS=
);
                 tach_period =3D
-                       CGS_REG_GET_FIELD(cgs_read_register(hwmgr->device, =
reg),
+                       REG_GET_FIELD(RREG32_SOC15(THM, 0, mmCG_TACH_STATUS=
),
                                           CG_TACH_STATUS,
                                           TACH_PERIOD);

@@ -127,26 +126,23 @@ int vega10_fan_ctrl_get_fan_speed_rpm(struct pp_hwmgr=
 *hwmgr, uint32_t *speed)
 */
 int vega10_fan_ctrl_set_static_mode(struct pp_hwmgr *hwmgr, uint32_t mode)
 {
-       uint32_t reg;
-
-       reg =3D soc15_get_register_offset(THM_HWID, 0,
-                       mmCG_FDO_CTRL2_BASE_IDX, mmCG_FDO_CTRL2);
+       struct amdgpu_device *adev =3D hwmgr->adev;

         if (hwmgr->fan_ctrl_is_in_default_mode) {
                 hwmgr->fan_ctrl_default_mode =3D
-                       CGS_REG_GET_FIELD(cgs_read_register(hwmgr->device, =
reg),
+                       REG_GET_FIELD(RREG32_SOC15(THM, 0, mmCG_FDO_CTRL2),
                                 CG_FDO_CTRL2, FDO_PWM_MODE);
                 hwmgr->tmin =3D
-                       CGS_REG_GET_FIELD(cgs_read_register(hwmgr->device, =
reg),
+                       REG_GET_FIELD(RREG32_SOC15(THM, 0, mmCG_FDO_CTRL2),
                                 CG_FDO_CTRL2, TMIN);
                 hwmgr->fan_ctrl_is_in_default_mode =3D false;
         }

-       cgs_write_register(hwmgr->device, reg,
-                       CGS_REG_SET_FIELD(cgs_read_register(hwmgr->device, =
reg),
+       WREG32_SOC15(THM, 0, mmCG_FDO_CTRL2,
+                       REG_SET_FIELD(RREG32_SOC15(THM, 0, mmCG_FDO_CTRL2),
                                 CG_FDO_CTRL2, TMIN, 0));
-       cgs_write_register(hwmgr->device, reg,
-                       CGS_REG_SET_FIELD(cgs_read_register(hwmgr->device, =
reg),
+       WREG32_SOC15(THM, 0, mmCG_FDO_CTRL2,
+                       REG_SET_FIELD(RREG32_SOC15(THM, 0, mmCG_FDO_CTRL2),
                                 CG_FDO_CTRL2, FDO_PWM_MODE, mode));

         return 0;
@@ -159,18 +155,15 @@ int vega10_fan_ctrl_set_static_mode(struct pp_hwmgr *=
hwmgr, uint32_t mode)
 */
 int vega10_fan_ctrl_set_default_mode(struct pp_hwmgr *hwmgr)
 {
-       uint32_t reg;
-
-       reg =3D soc15_get_register_offset(THM_HWID, 0,
-                       mmCG_FDO_CTRL2_BASE_IDX, mmCG_FDO_CTRL2);
+       struct amdgpu_device *adev =3D hwmgr->adev;

         if (!hwmgr->fan_ctrl_is_in_default_mode) {
-               cgs_write_register(hwmgr->device, reg,
-                       CGS_REG_SET_FIELD(cgs_read_register(hwmgr->device, =
reg),
+               WREG32_SOC15(THM, 0, mmCG_FDO_CTRL2,
+                       REG_SET_FIELD(RREG32_SOC15(THM, 0, mmCG_FDO_CTRL2),
                                 CG_FDO_CTRL2, FDO_PWM_MODE,
                                 hwmgr->fan_ctrl_default_mode));
-               cgs_write_register(hwmgr->device, reg,
-                       CGS_REG_SET_FIELD(cgs_read_register(hwmgr->device, =
reg),
+               WREG32_SOC15(THM, 0, mmCG_FDO_CTRL2,
+                       REG_SET_FIELD(RREG32_SOC15(THM, 0, mmCG_FDO_CTRL2),
                                 CG_FDO_CTRL2, TMIN,
                                 hwmgr->tmin << CG_FDO_CTRL2__TMIN__SHIFT))=
;
                 hwmgr->fan_ctrl_is_in_default_mode =3D true;
@@ -257,10 +250,10 @@ int vega10_fan_ctrl_stop_smc_fan_control(struct pp_hw=
mgr *hwmgr)
 int vega10_fan_ctrl_set_fan_speed_percent(struct pp_hwmgr *hwmgr,
                 uint32_t speed)
 {
+       struct amdgpu_device *adev =3D hwmgr->adev;
         uint32_t duty100;
         uint32_t duty;
         uint64_t tmp64;
-       uint32_t reg;

         if (hwmgr->thermal_controller.fanInfo.bNoFan)
                 return 0;
@@ -271,10 +264,7 @@ int vega10_fan_ctrl_set_fan_speed_percent(struct pp_hw=
mgr *hwmgr,
         if (PP_CAP(PHM_PlatformCaps_MicrocodeFanControl))
                 vega10_fan_ctrl_stop_smc_fan_control(hwmgr);

-       reg =3D soc15_get_register_offset(THM_HWID, 0,
-                       mmCG_FDO_CTRL1_BASE_IDX, mmCG_FDO_CTRL1);
-
-       duty100 =3D CGS_REG_GET_FIELD(cgs_read_register(hwmgr->device, reg)=
,
+       duty100 =3D REG_GET_FIELD(RREG32_SOC15(THM, 0, mmCG_FDO_CTRL1),
                                     CG_FDO_CTRL1, FMAX_DUTY100);

         if (duty100 =3D=3D 0)
@@ -284,10 +274,8 @@ int vega10_fan_ctrl_set_fan_speed_percent(struct pp_hw=
mgr *hwmgr,
         do_div(tmp64, 100);
         duty =3D (uint32_t)tmp64;

-       reg =3D soc15_get_register_offset(THM_HWID, 0,
-                       mmCG_FDO_CTRL0_BASE_IDX, mmCG_FDO_CTRL0);
-       cgs_write_register(hwmgr->device, reg,
-               CGS_REG_SET_FIELD(cgs_read_register(hwmgr->device, reg),
+       WREG32_SOC15(THM, 0, mmCG_FDO_CTRL0,
+               REG_SET_FIELD(RREG32_SOC15(THM, 0, mmCG_FDO_CTRL0),
                         CG_FDO_CTRL0, FDO_STATIC_DUTY, duty));

         return vega10_fan_ctrl_set_static_mode(hwmgr, FDO_PWM_MODE_STATIC)=
;
@@ -317,10 +305,10 @@ int vega10_fan_ctrl_reset_fan_speed_to_default(struct=
 pp_hwmgr *hwmgr)
 */
 int vega10_fan_ctrl_set_fan_speed_rpm(struct pp_hwmgr *hwmgr, uint32_t spe=
ed)
 {
+       struct amdgpu_device *adev =3D hwmgr->adev;
         uint32_t tach_period;
         uint32_t crystal_clock_freq;
         int result =3D 0;
-       uint32_t reg;

         if (hwmgr->thermal_controller.fanInfo.bNoFan ||
             (speed < hwmgr->thermal_controller.fanInfo.ulMinRPM) ||
@@ -333,10 +321,8 @@ int vega10_fan_ctrl_set_fan_speed_rpm(struct pp_hwmgr =
*hwmgr, uint32_t speed)
         if (!result) {
                 crystal_clock_freq =3D amdgpu_asic_get_xclk((struct amdgpu=
_device *)hwmgr->adev);
                 tach_period =3D 60 * crystal_clock_freq * 10000 / (8 * spe=
ed);
-               reg =3D soc15_get_register_offset(THM_HWID, 0,
-                               mmCG_TACH_STATUS_BASE_IDX, mmCG_TACH_STATUS=
);
-               cgs_write_register(hwmgr->device, reg,
-                               CGS_REG_SET_FIELD(cgs_read_register(hwmgr->=
device, reg),
+               WREG32_SOC15(THM, 0, mmCG_TACH_STATUS,
+                               REG_SET_FIELD(RREG32_SOC15(THM, 0, mmCG_TAC=
H_STATUS),
                                         CG_TACH_STATUS, TACH_PERIOD,
                                         tach_period));
         }
@@ -350,13 +336,10 @@ int vega10_fan_ctrl_set_fan_speed_rpm(struct pp_hwmgr=
 *hwmgr, uint32_t speed)
 */
 int vega10_thermal_get_temperature(struct pp_hwmgr *hwmgr)
 {
+       struct amdgpu_device *adev =3D hwmgr->adev;
         int temp;
-       uint32_t reg;

-       reg =3D soc15_get_register_offset(THM_HWID, 0,
-                       mmCG_MULT_THERMAL_STATUS_BASE_IDX,  mmCG_MULT_THERM=
AL_STATUS);
-
-       temp =3D cgs_read_register(hwmgr->device, reg);
+       temp =3D RREG32_SOC15(THM, 0, mmCG_MULT_THERMAL_STATUS);

         temp =3D (temp & CG_MULT_THERMAL_STATUS__CTF_TEMP_MASK) >>
                         CG_MULT_THERMAL_STATUS__CTF_TEMP__SHIFT;
@@ -379,11 +362,12 @@ int vega10_thermal_get_temperature(struct pp_hwmgr *h=
wmgr)
 static int vega10_thermal_set_temperature_range(struct pp_hwmgr *hwmgr,
                 struct PP_TemperatureRange *range)
 {
+       struct amdgpu_device *adev =3D hwmgr->adev;
         int low =3D VEGA10_THERMAL_MINIMUM_ALERT_TEMP *
                         PP_TEMPERATURE_UNITS_PER_CENTIGRADES;
         int high =3D VEGA10_THERMAL_MAXIMUM_ALERT_TEMP *
                         PP_TEMPERATURE_UNITS_PER_CENTIGRADES;
-       uint32_t val, reg;
+       uint32_t val;

         if (low < range->min)
                 low =3D range->min;
@@ -393,20 +377,17 @@ static int vega10_thermal_set_temperature_range(struc=
t pp_hwmgr *hwmgr,
         if (low > high)
                 return -EINVAL;

-       reg =3D soc15_get_register_offset(THM_HWID, 0,
-                       mmTHM_THERMAL_INT_CTRL_BASE_IDX, mmTHM_THERMAL_INT_=
CTRL);
-
-       val =3D cgs_read_register(hwmgr->device, reg);
+       val =3D RREG32_SOC15(THM, 0, mmTHM_THERMAL_INT_CTRL);

-       val =3D CGS_REG_SET_FIELD(val, THM_THERMAL_INT_CTRL, MAX_IH_CREDIT,=
 5);
-       val =3D CGS_REG_SET_FIELD(val, THM_THERMAL_INT_CTRL, THERM_IH_HW_EN=
A, 1);
-       val =3D CGS_REG_SET_FIELD(val, THM_THERMAL_INT_CTRL, DIG_THERM_INTH=
, (high / PP_TEMPERATURE_UNITS_PER_CENTIGRADES));
-       val =3D CGS_REG_SET_FIELD(val, THM_THERMAL_INT_CTRL, DIG_THERM_INTL=
, (low / PP_TEMPERATURE_UNITS_PER_CENTIGRADES));
+       val =3D REG_SET_FIELD(val, THM_THERMAL_INT_CTRL, MAX_IH_CREDIT, 5);
+       val =3D REG_SET_FIELD(val, THM_THERMAL_INT_CTRL, THERM_IH_HW_ENA, 1=
);
+       val =3D REG_SET_FIELD(val, THM_THERMAL_INT_CTRL, DIG_THERM_INTH, (h=
igh / PP_TEMPERATURE_UNITS_PER_CENTIGRADES));
+       val =3D REG_SET_FIELD(val, THM_THERMAL_INT_CTRL, DIG_THERM_INTL, (l=
ow / PP_TEMPERATURE_UNITS_PER_CENTIGRADES));
         val &=3D (~THM_THERMAL_INT_CTRL__THERM_TRIGGER_MASK_MASK) &
                         (~THM_THERMAL_INT_CTRL__THERM_INTH_MASK_MASK) &
                         (~THM_THERMAL_INT_CTRL__THERM_INTL_MASK_MASK);

-       cgs_write_register(hwmgr->device, reg, val);
+       WREG32_SOC15(THM, 0, mmTHM_THERMAL_INT_CTRL, val);

         return 0;
 }
@@ -418,21 +399,17 @@ static int vega10_thermal_set_temperature_range(struc=
t pp_hwmgr *hwmgr,
 */
 static int vega10_thermal_initialize(struct pp_hwmgr *hwmgr)
 {
-       uint32_t reg;
+       struct amdgpu_device *adev =3D hwmgr->adev;

         if (hwmgr->thermal_controller.fanInfo.ucTachometerPulsesPerRevolut=
ion) {
-               reg =3D soc15_get_register_offset(THM_HWID, 0,
-                               mmCG_TACH_CTRL_BASE_IDX, mmCG_TACH_CTRL);
-               cgs_write_register(hwmgr->device, reg,
-                       CGS_REG_SET_FIELD(cgs_read_register(hwmgr->device, =
reg),
+               WREG32_SOC15(THM, 0, mmCG_TACH_CTRL,
+                       REG_SET_FIELD(RREG32_SOC15(THM, 0, mmCG_TACH_CTRL),
                                 CG_TACH_CTRL, EDGE_PER_REV,
                                 hwmgr->thermal_controller.fanInfo.ucTachom=
eterPulsesPerRevolution - 1));
         }

-       reg =3D soc15_get_register_offset(THM_HWID, 0,
-                       mmCG_FDO_CTRL2_BASE_IDX, mmCG_FDO_CTRL2);
-       cgs_write_register(hwmgr->device, reg,
-               CGS_REG_SET_FIELD(cgs_read_register(hwmgr->device, reg),
+       WREG32_SOC15(THM, 0, mmCG_FDO_CTRL2,
+               REG_SET_FIELD(RREG32_SOC15(THM, 0, mmCG_FDO_CTRL2),
                         CG_FDO_CTRL2, TACH_PWM_RESP_RATE, 0x28));

         return 0;
@@ -445,9 +422,9 @@ static int vega10_thermal_initialize(struct pp_hwmgr *h=
wmgr)
 */
 static int vega10_thermal_enable_alert(struct pp_hwmgr *hwmgr)
 {
+       struct amdgpu_device *adev =3D hwmgr->adev;
         struct vega10_hwmgr *data =3D hwmgr->backend;
         uint32_t val =3D 0;
-       uint32_t reg;

         if (data->smu_features[GNLD_FW_CTF].supported) {
                 if (data->smu_features[GNLD_FW_CTF].enabled)
@@ -465,8 +442,7 @@ static int vega10_thermal_enable_alert(struct pp_hwmgr =
*hwmgr)
         val |=3D (1 << THM_THERMAL_INT_ENA__THERM_INTL_CLR__SHIFT);
         val |=3D (1 << THM_THERMAL_INT_ENA__THERM_TRIGGER_CLR__SHIFT);

-       reg =3D soc15_get_register_offset(THM_HWID, 0, mmTHM_THERMAL_INT_EN=
A_BASE_IDX, mmTHM_THERMAL_INT_ENA);
-       cgs_write_register(hwmgr->device, reg, val);
+       WREG32_SOC15(THM, 0, mmTHM_THERMAL_INT_ENA, val);

         return 0;
 }
@@ -477,8 +453,8 @@ static int vega10_thermal_enable_alert(struct pp_hwmgr =
*hwmgr)
 */
 int vega10_thermal_disable_alert(struct pp_hwmgr *hwmgr)
 {
+       struct amdgpu_device *adev =3D hwmgr->adev;
         struct vega10_hwmgr *data =3D hwmgr->backend;
-       uint32_t reg;

         if (data->smu_features[GNLD_FW_CTF].supported) {
                 if (!data->smu_features[GNLD_FW_CTF].enabled)
@@ -493,8 +469,7 @@ int vega10_thermal_disable_alert(struct pp_hwmgr *hwmgr=
)
                 data->smu_features[GNLD_FW_CTF].enabled =3D false;
         }

-       reg =3D soc15_get_register_offset(THM_HWID, 0, mmTHM_THERMAL_INT_EN=
A_BASE_IDX, mmTHM_THERMAL_INT_ENA);
-       cgs_write_register(hwmgr->device, reg, 0);
+       WREG32_SOC15(THM, 0, mmTHM_THERMAL_INT_ENA, 0);

         return 0;
 }
diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/vega12_hwmgr.c b/drivers/g=
pu/drm/amd/powerplay/hwmgr/vega12_hwmgr.c
index 6a85238..7dca75c 100644
--- a/drivers/gpu/drm/amd/powerplay/hwmgr/vega12_hwmgr.c
+++ b/drivers/gpu/drm/amd/powerplay/hwmgr/vega12_hwmgr.c
@@ -34,7 +34,6 @@
 #include "atomfirmware.h"
 #include "cgs_common.h"
 #include "vega12_inc.h"
-#include "pp_soc15.h"
 #include "pppcielanes.h"
 #include "vega12_hwmgr.h"
 #include "vega12_processpptables.h"
diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/vega12_thermal.c b/drivers=
/gpu/drm/amd/powerplay/hwmgr/vega12_thermal.c
index df0fa81..cfd9e6c 100644
--- a/drivers/gpu/drm/amd/powerplay/hwmgr/vega12_thermal.c
+++ b/drivers/gpu/drm/amd/powerplay/hwmgr/vega12_thermal.c
@@ -26,7 +26,7 @@
 #include "vega12_smumgr.h"
 #include "vega12_ppsmc.h"
 #include "vega12_inc.h"
-#include "pp_soc15.h"
+#include "soc15_common.h"
 #include "pp_debug.h"

 static int vega12_get_current_rpm(struct pp_hwmgr *hwmgr, uint32_t *curren=
t_rpm)
@@ -147,13 +147,10 @@ int vega12_fan_ctrl_reset_fan_speed_to_default(struct=
 pp_hwmgr *hwmgr)
 */
 int vega12_thermal_get_temperature(struct pp_hwmgr *hwmgr)
 {
+       struct amdgpu_device *adev =3D hwmgr->adev;
         int temp =3D 0;
-       uint32_t reg;

-       reg =3D soc15_get_register_offset(THM_HWID, 0,
-                       mmCG_MULT_THERMAL_STATUS_BASE_IDX,  mmCG_MULT_THERM=
AL_STATUS);
-
-       temp =3D cgs_read_register(hwmgr->device, reg);
+       temp =3D RREG32_SOC15(THM, 0, mmCG_MULT_THERMAL_STATUS);

         temp =3D (temp & CG_MULT_THERMAL_STATUS__CTF_TEMP_MASK) >>
                         CG_MULT_THERMAL_STATUS__CTF_TEMP__SHIFT;
@@ -175,11 +172,12 @@ int vega12_thermal_get_temperature(struct pp_hwmgr *h=
wmgr)
 static int vega12_thermal_set_temperature_range(struct pp_hwmgr *hwmgr,
                 struct PP_TemperatureRange *range)
 {
+       struct amdgpu_device *adev =3D hwmgr->adev;
         int low =3D VEGA12_THERMAL_MINIMUM_ALERT_TEMP *
                         PP_TEMPERATURE_UNITS_PER_CENTIGRADES;
         int high =3D VEGA12_THERMAL_MAXIMUM_ALERT_TEMP *
                         PP_TEMPERATURE_UNITS_PER_CENTIGRADES;
-       uint32_t val, reg;
+       uint32_t val;

         if (low < range->min)
                 low =3D range->min;
@@ -189,18 +187,15 @@ static int vega12_thermal_set_temperature_range(struc=
t pp_hwmgr *hwmgr,
         if (low > high)
                 return -EINVAL;

-       reg =3D soc15_get_register_offset(THM_HWID, 0,
-                       mmTHM_THERMAL_INT_CTRL_BASE_IDX, mmTHM_THERMAL_INT_=
CTRL);
-
-       val =3D cgs_read_register(hwmgr->device, reg);
+       val =3D RREG32_SOC15(THM, 0, mmTHM_THERMAL_INT_CTRL);

-       val =3D CGS_REG_SET_FIELD(val, THM_THERMAL_INT_CTRL, MAX_IH_CREDIT,=
 5);
-       val =3D CGS_REG_SET_FIELD(val, THM_THERMAL_INT_CTRL, THERM_IH_HW_EN=
A, 1);
-       val =3D CGS_REG_SET_FIELD(val, THM_THERMAL_INT_CTRL, DIG_THERM_INTH=
, (high / PP_TEMPERATURE_UNITS_PER_CENTIGRADES));
-       val =3D CGS_REG_SET_FIELD(val, THM_THERMAL_INT_CTRL, DIG_THERM_INTL=
, (low / PP_TEMPERATURE_UNITS_PER_CENTIGRADES));
+       val =3D REG_SET_FIELD(val, THM_THERMAL_INT_CTRL, MAX_IH_CREDIT, 5);
+       val =3D REG_SET_FIELD(val, THM_THERMAL_INT_CTRL, THERM_IH_HW_ENA, 1=
);
+       val =3D REG_SET_FIELD(val, THM_THERMAL_INT_CTRL, DIG_THERM_INTH, (h=
igh / PP_TEMPERATURE_UNITS_PER_CENTIGRADES));
+       val =3D REG_SET_FIELD(val, THM_THERMAL_INT_CTRL, DIG_THERM_INTL, (l=
ow / PP_TEMPERATURE_UNITS_PER_CENTIGRADES));
         val =3D val & (~THM_THERMAL_INT_CTRL__THERM_TRIGGER_MASK_MASK);

-       cgs_write_register(hwmgr->device, reg, val);
+       WREG32_SOC15(THM, 0, mmTHM_THERMAL_INT_CTRL, val);

         return 0;
 }
@@ -212,15 +207,14 @@ static int vega12_thermal_set_temperature_range(struc=
t pp_hwmgr *hwmgr,
 */
 static int vega12_thermal_enable_alert(struct pp_hwmgr *hwmgr)
 {
+       struct amdgpu_device *adev =3D hwmgr->adev;
         uint32_t val =3D 0;
-       uint32_t reg;

         val |=3D (1 << THM_THERMAL_INT_ENA__THERM_INTH_CLR__SHIFT);
         val |=3D (1 << THM_THERMAL_INT_ENA__THERM_INTL_CLR__SHIFT);
         val |=3D (1 << THM_THERMAL_INT_ENA__THERM_TRIGGER_CLR__SHIFT);

-       reg =3D soc15_get_register_offset(THM_HWID, 0, mmTHM_THERMAL_INT_EN=
A_BASE_IDX, mmTHM_THERMAL_INT_ENA);
-       cgs_write_register(hwmgr->device, reg, val);
+       WREG32_SOC15(THM, 0, mmTHM_THERMAL_INT_ENA, val);

         return 0;
 }
@@ -231,10 +225,9 @@ static int vega12_thermal_enable_alert(struct pp_hwmgr=
 *hwmgr)
 */
 int vega12_thermal_disable_alert(struct pp_hwmgr *hwmgr)
 {
-       uint32_t reg;
+       struct amdgpu_device *adev =3D hwmgr->adev;

-       reg =3D soc15_get_register_offset(THM_HWID, 0, mmTHM_THERMAL_INT_EN=
A_BASE_IDX, mmTHM_THERMAL_INT_ENA);
-       cgs_write_register(hwmgr->device, reg, 0);
+       WREG32_SOC15(THM, 0, mmTHM_THERMAL_INT_ENA, 0);

         return 0;
 }
diff --git a/drivers/gpu/drm/amd/powerplay/inc/pp_soc15.h b/drivers/gpu/drm=
/amd/powerplay/inc/pp_soc15.h
deleted file mode 100644
index 214f370..0000000
--- a/drivers/gpu/drm/amd/powerplay/inc/pp_soc15.h
+++ /dev/null
@@ -1,52 +0,0 @@
-/*
- * Copyright 2016 Advanced Micro Devices, Inc.
- *
- * Permission is hereby granted, free of charge, to any person obtaining a
- * copy of this software and associated documentation files (the "Software=
"),
- * to deal in the Software without restriction, including without limitati=
on
- * the rights to use, copy, modify, merge, publish, distribute, sublicense=
,
- * and/or sell copies of the Software, and to permit persons to whom the
- * Software is furnished to do so, subject to the following conditions:
- *
- * The above copyright notice and this permission notice shall be included=
 in
- * all copies or substantial portions of the Software.
- *
- * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS=
 OR
- * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY=
,
- * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHAL=
L
- * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES O=
R
- * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
- * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
- * OTHER DEALINGS IN THE SOFTWARE.
- *
- */
-#ifndef PP_SOC15_H
-#define PP_SOC15_H
-
-#include "soc15_hw_ip.h"
-#include "vega10_ip_offset.h"
-
-inline static uint32_t soc15_get_register_offset(
-               uint32_t hw_id,
-               uint32_t inst,
-               uint32_t segment,
-               uint32_t offset)
-{
-       uint32_t reg =3D 0;
-
-       if (hw_id =3D=3D THM_HWID)
-               reg =3D THM_BASE.instance[inst].segment[segment] + offset;
-       else if (hw_id =3D=3D NBIF_HWID)
-               reg =3D NBIF_BASE.instance[inst].segment[segment] + offset;
-       else if (hw_id =3D=3D MP1_HWID)
-               reg =3D MP1_BASE.instance[inst].segment[segment] + offset;
-       else if (hw_id =3D=3D DF_HWID)
-               reg =3D DF_BASE.instance[inst].segment[segment] + offset;
-       else if (hw_id =3D=3D GC_HWID)
-               reg =3D GC_BASE.instance[inst].segment[segment] + offset;
-       else if (hw_id =3D=3D SMUIO_HWID)
-               reg =3D SMUIO_BASE.instance[inst].segment[segment] + offset=
;
-       return reg;
-}
-
-#endif
diff --git a/drivers/gpu/drm/amd/powerplay/smumgr/smu10_smumgr.c b/drivers/=
gpu/drm/amd/powerplay/smumgr/smu10_smumgr.c
index bc53f2b..9adea72 100644
--- a/drivers/gpu/drm/amd/powerplay/smumgr/smu10_smumgr.c
+++ b/drivers/gpu/drm/amd/powerplay/smumgr/smu10_smumgr.c
@@ -23,7 +23,7 @@

 #include "smumgr.h"
 #include "smu10_inc.h"
-#include "pp_soc15.h"
+#include "soc15_common.h"
 #include "smu10_smumgr.h"
 #include "ppatomctrl.h"
 #include "rv_ppsmc.h"
@@ -49,48 +49,41 @@

 static uint32_t smu10_wait_for_response(struct pp_hwmgr *hwmgr)
 {
+       struct amdgpu_device *adev =3D hwmgr->adev;
         uint32_t reg;

-       reg =3D soc15_get_register_offset(MP1_HWID, 0,
-                       mmMP1_SMN_C2PMSG_90_BASE_IDX, mmMP1_SMN_C2PMSG_90);
+       reg =3D SOC15_REG_OFFSET(MP1, 0, mmMP1_SMN_C2PMSG_90);

         phm_wait_for_register_unequal(hwmgr, reg,
                         0, MP1_C2PMSG_90__CONTENT_MASK);

-       return cgs_read_register(hwmgr->device, reg);
+       return RREG32_SOC15(MP1, 0, mmMP1_SMN_C2PMSG_90);
 }

 static int smu10_send_msg_to_smc_without_waiting(struct pp_hwmgr *hwmgr,
                 uint16_t msg)
 {
-       uint32_t reg;
+       struct amdgpu_device *adev =3D hwmgr->adev;

-       reg =3D soc15_get_register_offset(MP1_HWID, 0,
-                       mmMP1_SMN_C2PMSG_66_BASE_IDX, mmMP1_SMN_C2PMSG_66);
-       cgs_write_register(hwmgr->device, reg, msg);
+       WREG32_SOC15(MP1, 0, mmMP1_SMN_C2PMSG_66, msg);

         return 0;
 }

 static int smu10_read_arg_from_smc(struct pp_hwmgr *hwmgr)
 {
-       uint32_t reg;
-
-       reg =3D soc15_get_register_offset(MP1_HWID, 0,
-                       mmMP1_SMN_C2PMSG_82_BASE_IDX, mmMP1_SMN_C2PMSG_82);
+       struct amdgpu_device *adev =3D hwmgr->adev;

-       return cgs_read_register(hwmgr->device, reg);
+       return RREG32_SOC15(MP1, 0, mmMP1_SMN_C2PMSG_82);
 }

 static int smu10_send_msg_to_smc(struct pp_hwmgr *hwmgr, uint16_t msg)
 {
-       uint32_t reg;
+       struct amdgpu_device *adev =3D hwmgr->adev;

         smu10_wait_for_response(hwmgr);

-       reg =3D soc15_get_register_offset(MP1_HWID, 0,
-                       mmMP1_SMN_C2PMSG_90_BASE_IDX, mmMP1_SMN_C2PMSG_90);
-       cgs_write_register(hwmgr->device, reg, 0);
+       WREG32_SOC15(MP1, 0, mmMP1_SMN_C2PMSG_90, 0);

         smu10_send_msg_to_smc_without_waiting(hwmgr, msg);

@@ -104,17 +97,13 @@ static int smu10_send_msg_to_smc(struct pp_hwmgr *hwmg=
r, uint16_t msg)
 static int smu10_send_msg_to_smc_with_parameter(struct pp_hwmgr *hwmgr,
                 uint16_t msg, uint32_t parameter)
 {
-       uint32_t reg;
+       struct amdgpu_device *adev =3D hwmgr->adev;

         smu10_wait_for_response(hwmgr);

-       reg =3D soc15_get_register_offset(MP1_HWID, 0,
-                       mmMP1_SMN_C2PMSG_90_BASE_IDX, mmMP1_SMN_C2PMSG_90);
-       cgs_write_register(hwmgr->device, reg, 0);
+       WREG32_SOC15(MP1, 0, mmMP1_SMN_C2PMSG_90, 0);

-       reg =3D soc15_get_register_offset(MP1_HWID, 0,
-                       mmMP1_SMN_C2PMSG_82_BASE_IDX, mmMP1_SMN_C2PMSG_82);
-       cgs_write_register(hwmgr->device, reg, parameter);
+       WREG32_SOC15(MP1, 0, mmMP1_SMN_C2PMSG_82, parameter);

         smu10_send_msg_to_smc_without_waiting(hwmgr, msg);

diff --git a/drivers/gpu/drm/amd/powerplay/smumgr/vega10_smumgr.c b/drivers=
/gpu/drm/amd/powerplay/smumgr/vega10_smumgr.c
index 4aafb04..14ac6d1 100644
--- a/drivers/gpu/drm/amd/powerplay/smumgr/vega10_smumgr.c
+++ b/drivers/gpu/drm/amd/powerplay/smumgr/vega10_smumgr.c
@@ -23,7 +23,7 @@

 #include "smumgr.h"
 #include "vega10_inc.h"
-#include "pp_soc15.h"
+#include "soc15_common.h"
 #include "vega10_smumgr.h"
 #include "vega10_hwmgr.h"
 #include "vega10_ppsmc.h"
@@ -54,18 +54,13 @@

 static bool vega10_is_smc_ram_running(struct pp_hwmgr *hwmgr)
 {
-       uint32_t mp1_fw_flags, reg;
-
-       reg =3D soc15_get_register_offset(NBIF_HWID, 0,
-                       mmPCIE_INDEX2_BASE_IDX, mmPCIE_INDEX2);
+       struct amdgpu_device *adev =3D hwmgr->adev;
+       uint32_t mp1_fw_flags;

-       cgs_write_register(hwmgr->device, reg,
+       WREG32_SOC15(NBIF, 0, mmPCIE_INDEX2,
                         (MP1_Public | (smnMP1_FIRMWARE_FLAGS & 0xffffffff)=
));

-       reg =3D soc15_get_register_offset(NBIF_HWID, 0,
-                       mmPCIE_DATA2_BASE_IDX, mmPCIE_DATA2);
-
-       mp1_fw_flags =3D cgs_read_register(hwmgr->device, reg);
+       mp1_fw_flags =3D RREG32_SOC15(NBIF, 0, mmPCIE_DATA2);

         if (mp1_fw_flags & MP1_FIRMWARE_FLAGS__INTERRUPTS_ENABLED_MASK)
                 return true;
@@ -81,11 +76,11 @@ static bool vega10_is_smc_ram_running(struct pp_hwmgr *=
hwmgr)
  */
 static uint32_t vega10_wait_for_response(struct pp_hwmgr *hwmgr)
 {
+       struct amdgpu_device *adev =3D hwmgr->adev;
         uint32_t reg;
         uint32_t ret;

-       reg =3D soc15_get_register_offset(MP1_HWID, 0,
-                       mmMP1_SMN_C2PMSG_90_BASE_IDX, mmMP1_SMN_C2PMSG_90);
+       reg =3D SOC15_REG_OFFSET(MP1, 0, mmMP1_SMN_C2PMSG_90);

         ret =3D phm_wait_for_register_unequal(hwmgr, reg,
                         0, MP1_C2PMSG_90__CONTENT_MASK);
@@ -93,7 +88,7 @@ static uint32_t vega10_wait_for_response(struct pp_hwmgr =
*hwmgr)
         if (ret)
                 pr_err("No response from smu\n");

-       return cgs_read_register(hwmgr->device, reg);
+       return RREG32_SOC15(MP1, 0, mmMP1_SMN_C2PMSG_90);
 }

 /*
@@ -105,11 +100,9 @@ static uint32_t vega10_wait_for_response(struct pp_hwm=
gr *hwmgr)
 static int vega10_send_msg_to_smc_without_waiting(struct pp_hwmgr *hwmgr,
                 uint16_t msg)
 {
-       uint32_t reg;
+       struct amdgpu_device *adev =3D hwmgr->adev;

-       reg =3D soc15_get_register_offset(MP1_HWID, 0,
-                       mmMP1_SMN_C2PMSG_66_BASE_IDX, mmMP1_SMN_C2PMSG_66);
-       cgs_write_register(hwmgr->device, reg, msg);
+       WREG32_SOC15(MP1, 0, mmMP1_SMN_C2PMSG_66, msg);

         return 0;
 }
@@ -122,14 +115,12 @@ static int vega10_send_msg_to_smc_without_waiting(str=
uct pp_hwmgr *hwmgr,
  */
 static int vega10_send_msg_to_smc(struct pp_hwmgr *hwmgr, uint16_t msg)
 {
-       uint32_t reg;
+       struct amdgpu_device *adev =3D hwmgr->adev;
         uint32_t ret;

         vega10_wait_for_response(hwmgr);

-       reg =3D soc15_get_register_offset(MP1_HWID, 0,
-                       mmMP1_SMN_C2PMSG_90_BASE_IDX, mmMP1_SMN_C2PMSG_90);
-       cgs_write_register(hwmgr->device, reg, 0);
+       WREG32_SOC15(MP1, 0, mmMP1_SMN_C2PMSG_90, 0);

         vega10_send_msg_to_smc_without_waiting(hwmgr, msg);

@@ -150,18 +141,14 @@ static int vega10_send_msg_to_smc(struct pp_hwmgr *hw=
mgr, uint16_t msg)
 static int vega10_send_msg_to_smc_with_parameter(struct pp_hwmgr *hwmgr,
                 uint16_t msg, uint32_t parameter)
 {
-       uint32_t reg;
+       struct amdgpu_device *adev =3D hwmgr->adev;
         uint32_t ret;

         vega10_wait_for_response(hwmgr);

-       reg =3D soc15_get_register_offset(MP1_HWID, 0,
-                       mmMP1_SMN_C2PMSG_90_BASE_IDX, mmMP1_SMN_C2PMSG_90);
-       cgs_write_register(hwmgr->device, reg, 0);
+       WREG32_SOC15(MP1, 0, mmMP1_SMN_C2PMSG_90, 0);

-       reg =3D soc15_get_register_offset(MP1_HWID, 0,
-                       mmMP1_SMN_C2PMSG_82_BASE_IDX, mmMP1_SMN_C2PMSG_82);
-       cgs_write_register(hwmgr->device, reg, parameter);
+       WREG32_SOC15(MP1, 0, mmMP1_SMN_C2PMSG_82, parameter);

         vega10_send_msg_to_smc_without_waiting(hwmgr, msg);

@@ -174,12 +161,9 @@ static int vega10_send_msg_to_smc_with_parameter(struc=
t pp_hwmgr *hwmgr,

 static int vega10_get_argument(struct pp_hwmgr *hwmgr)
 {
-       uint32_t reg;
-
-       reg =3D soc15_get_register_offset(MP1_HWID, 0,
-                       mmMP1_SMN_C2PMSG_82_BASE_IDX, mmMP1_SMN_C2PMSG_82);
+       struct amdgpu_device *adev =3D hwmgr->adev;

-       return cgs_read_register(hwmgr->device, reg);
+       return RREG32_SOC15(MP1, 0, mmMP1_SMN_C2PMSG_82);
 }

 static int vega10_copy_table_from_smc(struct pp_hwmgr *hwmgr,
diff --git a/drivers/gpu/drm/amd/powerplay/smumgr/vega12_smumgr.c b/drivers=
/gpu/drm/amd/powerplay/smumgr/vega12_smumgr.c
index 651a3f2..7d9b40e 100644
--- a/drivers/gpu/drm/amd/powerplay/smumgr/vega12_smumgr.c
+++ b/drivers/gpu/drm/amd/powerplay/smumgr/vega12_smumgr.c
@@ -23,7 +23,7 @@

 #include "smumgr.h"
 #include "vega12_inc.h"
-#include "pp_soc15.h"
+#include "soc15_common.h"
 #include "vega12_smumgr.h"
 #include "vega12_ppsmc.h"
 #include "vega12/smu9_driver_if.h"
@@ -44,18 +44,13 @@

 static bool vega12_is_smc_ram_running(struct pp_hwmgr *hwmgr)
 {
-       uint32_t mp1_fw_flags, reg;
+       struct amdgpu_device *adev =3D hwmgr->adev;
+       uint32_t mp1_fw_flags;

-       reg =3D soc15_get_register_offset(NBIF_HWID, 0,
-                       mmPCIE_INDEX2_BASE_IDX, mmPCIE_INDEX2);
-
-       cgs_write_register(hwmgr->device, reg,
+       WREG32_SOC15(NBIF, 0, mmPCIE_INDEX2,
                         (MP1_Public | (smnMP1_FIRMWARE_FLAGS & 0xffffffff)=
));

-       reg =3D soc15_get_register_offset(NBIF_HWID, 0,
-                       mmPCIE_DATA2_BASE_IDX, mmPCIE_DATA2);
-
-       mp1_fw_flags =3D cgs_read_register(hwmgr->device, reg);
+       mp1_fw_flags =3D RREG32_SOC15(NBIF, 0, mmPCIE_DATA2);

         if ((mp1_fw_flags & MP1_FIRMWARE_FLAGS__INTERRUPTS_ENABLED_MASK) >=
>
                                 MP1_FIRMWARE_FLAGS__INTERRUPTS_ENABLED__SH=
IFT)
@@ -72,15 +67,15 @@ static bool vega12_is_smc_ram_running(struct pp_hwmgr *=
hwmgr)
  */
 static uint32_t vega12_wait_for_response(struct pp_hwmgr *hwmgr)
 {
+       struct amdgpu_device *adev =3D hwmgr->adev;
         uint32_t reg;

-       reg =3D soc15_get_register_offset(MP1_HWID, 0,
-                       mmMP1_SMN_C2PMSG_90_BASE_IDX, mmMP1_SMN_C2PMSG_90);
+       reg =3D SOC15_REG_OFFSET(MP1, 0, mmMP1_SMN_C2PMSG_90);

         phm_wait_for_register_unequal(hwmgr, reg,
                         0, MP1_C2PMSG_90__CONTENT_MASK);

-       return cgs_read_register(hwmgr->device, reg);
+       return RREG32_SOC15(MP1, 0, mmMP1_SMN_C2PMSG_90);
 }

 /*
@@ -92,11 +87,9 @@ static uint32_t vega12_wait_for_response(struct pp_hwmgr=
 *hwmgr)
 int vega12_send_msg_to_smc_without_waiting(struct pp_hwmgr *hwmgr,
                 uint16_t msg)
 {
-       uint32_t reg;
+       struct amdgpu_device *adev =3D hwmgr->adev;

-       reg =3D soc15_get_register_offset(MP1_HWID, 0,
-                       mmMP1_SMN_C2PMSG_66_BASE_IDX, mmMP1_SMN_C2PMSG_66);
-       cgs_write_register(hwmgr->device, reg, msg);
+       WREG32_SOC15(MP1, 0, mmMP1_SMN_C2PMSG_66, msg);

         return 0;
 }
@@ -109,13 +102,11 @@ int vega12_send_msg_to_smc_without_waiting(struct pp_=
hwmgr *hwmgr,
  */
 int vega12_send_msg_to_smc(struct pp_hwmgr *hwmgr, uint16_t msg)
 {
-       uint32_t reg;
+       struct amdgpu_device *adev =3D hwmgr->adev;

         vega12_wait_for_response(hwmgr);

-       reg =3D soc15_get_register_offset(MP1_HWID, 0,
-                       mmMP1_SMN_C2PMSG_90_BASE_IDX, mmMP1_SMN_C2PMSG_90);
-       cgs_write_register(hwmgr->device, reg, 0);
+       WREG32_SOC15(MP1, 0, mmMP1_SMN_C2PMSG_90, 0);

         vega12_send_msg_to_smc_without_waiting(hwmgr, msg);

@@ -135,17 +126,13 @@ int vega12_send_msg_to_smc(struct pp_hwmgr *hwmgr, ui=
nt16_t msg)
 int vega12_send_msg_to_smc_with_parameter(struct pp_hwmgr *hwmgr,
                 uint16_t msg, uint32_t parameter)
 {
-       uint32_t reg;
+       struct amdgpu_device *adev =3D hwmgr->adev;

         vega12_wait_for_response(hwmgr);

-       reg =3D soc15_get_register_offset(MP1_HWID, 0,
-                       mmMP1_SMN_C2PMSG_90_BASE_IDX, mmMP1_SMN_C2PMSG_90);
-       cgs_write_register(hwmgr->device, reg, 0);
+       WREG32_SOC15(MP1, 0, mmMP1_SMN_C2PMSG_90, 0);

-       reg =3D soc15_get_register_offset(MP1_HWID, 0,
-                       mmMP1_SMN_C2PMSG_82_BASE_IDX, mmMP1_SMN_C2PMSG_82);
-       cgs_write_register(hwmgr->device, reg, parameter);
+       WREG32_SOC15(MP1, 0, mmMP1_SMN_C2PMSG_82, parameter);

         vega12_send_msg_to_smc_without_waiting(hwmgr, msg);

@@ -166,11 +153,9 @@ int vega12_send_msg_to_smc_with_parameter(struct pp_hw=
mgr *hwmgr,
 int vega12_send_msg_to_smc_with_parameter_without_waiting(
                 struct pp_hwmgr *hwmgr, uint16_t msg, uint32_t parameter)
 {
-       uint32_t reg;
+       struct amdgpu_device *adev =3D hwmgr->adev;

-       reg =3D soc15_get_register_offset(MP1_HWID, 0,
-                       mmMP1_SMN_C2PMSG_66_BASE_IDX, mmMP1_SMN_C2PMSG_66);
-       cgs_write_register(hwmgr->device, reg, parameter);
+       WREG32_SOC15(MP1, 0, mmMP1_SMN_C2PMSG_66, parameter);

         return vega12_send_msg_to_smc_without_waiting(hwmgr, msg);
 }
@@ -183,12 +168,9 @@ int vega12_send_msg_to_smc_with_parameter_without_wait=
ing(
  */
 int vega12_read_arg_from_smc(struct pp_hwmgr *hwmgr, uint32_t *arg)
 {
-       uint32_t reg;
-
-       reg =3D soc15_get_register_offset(MP1_HWID, 0,
-                       mmMP1_SMN_C2PMSG_82_BASE_IDX, mmMP1_SMN_C2PMSG_82);
+       struct amdgpu_device *adev =3D hwmgr->adev;

-       *arg =3D cgs_read_register(hwmgr->device, reg);
+       *arg =3D RREG32_SOC15(MP1, 0, mmMP1_SMN_C2PMSG_82);

         return 0;
 }
--
2.7.4


--_000_CY4PR12MB1687981C7066CC1F99DF3B46FBBE0CY4PR12MB1687namp_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-8859-=
1">
<style type=3D"text/css" style=3D"display:none;"><!-- P {margin-top:0;margi=
n-bottom:0;} --></style>
</head>
<body dir=3D"ltr">
<div id=3D"divtagdefaultwrapper" style=3D"font-size:12pt;color:#000000;font=
-family:Calibri,Helvetica,sans-serif;" dir=3D"ltr">
<p style=3D"margin-top:0;margin-bottom:0"></p>
<p class=3D"x_MsoNormal">Series is: </p>
<p class=3D"x_MsoNormal">Reviewed-by:&nbsp;<span>Rex Zhu &lt;Rex.Zhu-urvtwAKJhsc@public.gmane.org=
m&gt;</span></p>
<p class=3D"x_MsoNormal"><br>
</p>
<p class=3D"x_MsoNormal">Best Regards</p>
<p class=3D"x_MsoNormal">Rex<br>
</p>
<br>
<p></p>
<br>
<br>
<div style=3D"color: rgb(0, 0, 0);">
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font style=3D"font-size:11pt" color=
=3D"#000000" face=3D"Calibri, sans-serif"><b>From:</b> Evan Quan &lt;evan.q=
uan-5C7GfCeVMHo@public.gmane.org&gt;<br>
<b>Sent:</b> Tuesday, April 10, 2018 12:40 PM<br>
<b>To:</b> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
<b>Cc:</b> Zhu, Rex; Quan, Evan<br>
<b>Subject:</b> [PATCH 2/2] drm/amd/powerplay: use soc15 common macros inst=
ead of vega10 specific</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">pp_soc15.h is vega10 specific. Update powerplay co=
de to use soc15 common<br>
macros defined in soc15_common.h.<br>
<br>
Change-Id: I43c9a89e1a1f5d9a031465e2c2ba1525486aba9a<br>
Signed-off-by: Evan Quan &lt;evan.quan-5C7GfCeVMHo@public.gmane.org&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/powerplay/hwmgr/smu10_hwmgr.c&nbsp; |&nbsp;&nbsp;=
 7 &#43;-<br>
&nbsp;drivers/gpu/drm/amd/powerplay/hwmgr/vega10_hwmgr.c |&nbsp; 16 &#43;--=
<br>
&nbsp;.../gpu/drm/amd/powerplay/hwmgr/vega10_powertune.c |&nbsp; 50 &#43;&#=
43;&#43;&#43;------<br>
&nbsp;.../gpu/drm/amd/powerplay/hwmgr/vega10_thermal.c&nbsp;&nbsp; | 107 &#=
43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;-------------<br>
&nbsp;drivers/gpu/drm/amd/powerplay/hwmgr/vega12_hwmgr.c |&nbsp;&nbsp; 1 -<=
br>
&nbsp;.../gpu/drm/amd/powerplay/hwmgr/vega12_thermal.c&nbsp;&nbsp; |&nbsp; =
37 &#43;&#43;&#43;----<br>
&nbsp;drivers/gpu/drm/amd/powerplay/inc/pp_soc15.h&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; |&nbsp; 52 ----------<br>
&nbsp;.../gpu/drm/amd/powerplay/smumgr/smu10_smumgr.c&nbsp;&nbsp;&nbsp; |&n=
bsp; 37 &#43;&#43;&#43;----<br>
&nbsp;.../gpu/drm/amd/powerplay/smumgr/vega10_smumgr.c&nbsp;&nbsp; |&nbsp; =
50 &#43;&#43;&#43;&#43;------<br>
&nbsp;.../gpu/drm/amd/powerplay/smumgr/vega12_smumgr.c&nbsp;&nbsp; |&nbsp; =
56 &#43;&#43;&#43;&#43;-------<br>
&nbsp;10 files changed, 133 insertions(&#43;), 280 deletions(-)<br>
&nbsp;delete mode 100644 drivers/gpu/drm/amd/powerplay/inc/pp_soc15.h<br>
<br>
diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/smu10_hwmgr.c b/drivers/gp=
u/drm/amd/powerplay/hwmgr/smu10_hwmgr.c<br>
index 055358b..6ba3b1f 100644<br>
--- a/drivers/gpu/drm/amd/powerplay/hwmgr/smu10_hwmgr.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/powerplay/hwmgr/smu10_hwmgr.c<br>
@@ -34,7 &#43;34,7 @@<br>
&nbsp;#include &quot;rv_ppsmc.h&quot;<br>
&nbsp;#include &quot;smu10_hwmgr.h&quot;<br>
&nbsp;#include &quot;power_state.h&quot;<br>
-#include &quot;pp_soc15.h&quot;<br>
&#43;#include &quot;soc15_common.h&quot;<br>
&nbsp;<br>
&nbsp;#define SMU10_MAX_DEEPSLEEP_DIVIDER_ID&nbsp;&nbsp;&nbsp;&nbsp; 5<br>
&nbsp;#define SMU10_MINIMUM_ENGINE_CLOCK&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; 800&nbsp;&nbsp; /* 8Mhz, the low boundary of engine clock all=
owed on this chip */<br>
@@ -947,9 &#43;947,8 @@ static int smu10_get_max_high_clocks(struct pp_hwmg=
r *hwmgr, struct amd_pp_simpl<br>
&nbsp;<br>
&nbsp;static int smu10_thermal_get_temperature(struct pp_hwmgr *hwmgr)<br>
&nbsp;{<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t reg_offset =3D soc15_get_reg=
ister_offset(THM_HWID, 0,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mmTHM_TCON_CUR_T=
MP_BASE_IDX, mmTHM_TCON_CUR_TMP);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t reg_value =3D cgs_read_regis=
ter(hwmgr-&gt;device, reg_offset);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev =3D hw=
mgr-&gt;adev;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t reg_value =3D RREG32_SOC=
15(THM, 0, mmTHM_TCON_CUR_TMP);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int cur_temp =3D<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; (reg_value &amp; THM_TCON_CUR_TMP__CUR_TEMP_MASK) &gt=
;&gt; THM_TCON_CUR_TMP__CUR_TEMP__SHIFT;<br>
&nbsp;<br>
diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/vega10_hwmgr.c b/drivers/g=
pu/drm/amd/powerplay/hwmgr/vega10_hwmgr.c<br>
index c9fb4b2..5fc2f20 100644<br>
--- a/drivers/gpu/drm/amd/powerplay/hwmgr/vega10_hwmgr.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/powerplay/hwmgr/vega10_hwmgr.c<br>
@@ -36,7 &#43;36,7 @@<br>
&nbsp;#include &quot;smu9.h&quot;<br>
&nbsp;#include &quot;smu9_driver_if.h&quot;<br>
&nbsp;#include &quot;vega10_inc.h&quot;<br>
-#include &quot;pp_soc15.h&quot;<br>
&#43;#include &quot;soc15_common.h&quot;<br>
&nbsp;#include &quot;pppcielanes.h&quot;<br>
&nbsp;#include &quot;vega10_hwmgr.h&quot;<br>
&nbsp;#include &quot;vega10_processpptables.h&quot;<br>
@@ -754,7 &#43;754,6 @@ static int vega10_hwmgr_backend_init(struct pp_hwmg=
r *hwmgr)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t config_telemetry =
=3D 0;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct pp_atomfwctrl_volta=
ge_table vol_table;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev=
 =3D hwmgr-&gt;adev;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t reg;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; data =3D kzalloc(sizeof(st=
ruct vega10_hwmgr), GFP_KERNEL);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (data =3D=3D NULL)<br>
@@ -860,10 &#43;859,7 @@ static int vega10_hwmgr_backend_init(struct pp_hwm=
gr *hwmgr)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; advan=
ceFanControlParameters.usFanPWMMinLimit *<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; hwmgr=
-&gt;thermal_controller.fanInfo.ulMaxRPM / 100;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; reg =3D soc15_get_register_offset(DF_=
HWID, 0,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mmDF_CS_AON0_Dra=
mBaseAddress0_BASE_IDX,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mmDF_CS_AON0_Dra=
mBaseAddress0);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; data-&gt;mem_channels =3D (cgs_read_r=
egister(hwmgr-&gt;device, reg) &amp;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; data-&gt;mem_channels =3D (RREG32=
_SOC15(DF, 0, mmDF_CS_AON0_DramBaseAddress0) &amp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DF_CS=
_AON0_DramBaseAddress0__IntLvNumChan_MASK) &gt;&gt;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DF_CS=
_AON0_DramBaseAddress0__IntLvNumChan__SHIFT;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; PP_ASSERT_WITH_CODE(data-&=
gt;mem_channels &lt; ARRAY_SIZE(channel_number),<br>
@@ -3802,11 &#43;3798,12 @@ static int vega10_get_gpu_power(struct pp_hwmgr=
 *hwmgr,<br>
&nbsp;static int vega10_read_sensor(struct pp_hwmgr *hwmgr, int idx,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; void *value, int *size)<br>
&nbsp;{<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev =3D hw=
mgr-&gt;adev;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t sclk_idx, mclk_id=
x, activity_percent =3D 0;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct vega10_hwmgr *data =
=3D hwmgr-&gt;backend;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct vega10_dpm_table *d=
pm_table =3D &amp;data-&gt;dpm_table;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ret =3D 0;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t reg, val_vid;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t val_vid;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (idx) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case AMDGPU_PP_SENSOR_GFX_=
SCLK:<br>
@@ -3856,10 &#43;3853,7 @@ static int vega10_read_sensor(struct pp_hwmgr *h=
wmgr, int idx,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; break;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case AMDGPU_PP_SENSOR_VDDG=
FX:<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; reg =3D soc15_get_register_offset(SMUIO_HWID, 0,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mmSMUSVI0_PLANE0=
_CURRENTVID_BASE_IDX,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mmSMUSVI0_PLANE0=
_CURRENTVID);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; val_vid =3D (cgs_read_register(hwmgr-&gt;device, reg) &amp;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; val_vid =3D (RREG32_SOC15(SMUIO, 0, mmSMUSVI0_PLANE0_CURRENT=
VID) &amp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SMUSV=
I0_PLANE0_CURRENTVID__CURRENT_SVI0_PLANE0_VID_MASK) &gt;&gt;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SMUSV=
I0_PLANE0_CURRENTVID__CURRENT_SVI0_PLANE0_VID__SHIFT;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; *((uint32_t *)value) =3D (uint32_t)convert_to_vddc((u=
int8_t)val_vid);<br>
diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/vega10_powertune.c b/drive=
rs/gpu/drm/amd/powerplay/hwmgr/vega10_powertune.c<br>
index 203a691..a9efd855 100644<br>
--- a/drivers/gpu/drm/amd/powerplay/hwmgr/vega10_powertune.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/powerplay/hwmgr/vega10_powertune.c<br=
>
@@ -27,7 &#43;27,7 @@<br>
&nbsp;#include &quot;vega10_ppsmc.h&quot;<br>
&nbsp;#include &quot;vega10_inc.h&quot;<br>
&nbsp;#include &quot;pp_debug.h&quot;<br>
-#include &quot;pp_soc15.h&quot;<br>
&#43;#include &quot;soc15_common.h&quot;<br>
&nbsp;<br>
&nbsp;static const struct vega10_didt_config_reg SEDiDtTuningCtrlConfig_Veg=
a10[] =3D<br>
&nbsp;{<br>
@@ -888,36 &#43;888,36 @@ static void vega10_didt_set_mask(struct pp_hwmgr =
*hwmgr, const bool enable)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (PP_CAP(PHM_PlatformCap=
s_DiDtEDCEnable)) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; if (PP_CAP(PHM_PlatformCaps_SQRamping)) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; data =
=3D cgs_read_ind_register(hwmgr-&gt;device, CGS_IND_REG__DIDT, ixDIDT_SQ_ED=
C_CTRL);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; data =3D CGS_REG=
_SET_FIELD(data, DIDT_SQ_EDC_CTRL, EDC_EN, en);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; data =3D CGS_REG=
_SET_FIELD(data, DIDT_SQ_EDC_CTRL, EDC_SW_RST, ~en);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; data =3D REG=
_SET_FIELD(data, DIDT_SQ_EDC_CTRL, EDC_EN, en);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; data =3D REG=
_SET_FIELD(data, DIDT_SQ_EDC_CTRL, EDC_SW_RST, ~en);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; cgs_w=
rite_ind_register(hwmgr-&gt;device, CGS_IND_REG__DIDT, ixDIDT_SQ_EDC_CTRL, =
data);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; if (PP_CAP(PHM_PlatformCaps_DBRamping)) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; data =
=3D cgs_read_ind_register(hwmgr-&gt;device, CGS_IND_REG__DIDT, ixDIDT_DB_ED=
C_CTRL);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; data =3D CGS_REG=
_SET_FIELD(data, DIDT_DB_EDC_CTRL, EDC_EN, en);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; data =3D CGS_REG=
_SET_FIELD(data, DIDT_DB_EDC_CTRL, EDC_SW_RST, ~en);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; data =3D REG=
_SET_FIELD(data, DIDT_DB_EDC_CTRL, EDC_EN, en);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; data =3D REG=
_SET_FIELD(data, DIDT_DB_EDC_CTRL, EDC_SW_RST, ~en);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; cgs_w=
rite_ind_register(hwmgr-&gt;device, CGS_IND_REG__DIDT, ixDIDT_DB_EDC_CTRL, =
data);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; if (PP_CAP(PHM_PlatformCaps_TDRamping)) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; data =
=3D cgs_read_ind_register(hwmgr-&gt;device, CGS_IND_REG__DIDT, ixDIDT_TD_ED=
C_CTRL);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; data =3D CGS_REG=
_SET_FIELD(data, DIDT_TD_EDC_CTRL, EDC_EN, en);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; data =3D CGS_REG=
_SET_FIELD(data, DIDT_TD_EDC_CTRL, EDC_SW_RST, ~en);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; data =3D REG=
_SET_FIELD(data, DIDT_TD_EDC_CTRL, EDC_EN, en);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; data =3D REG=
_SET_FIELD(data, DIDT_TD_EDC_CTRL, EDC_SW_RST, ~en);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; cgs_w=
rite_ind_register(hwmgr-&gt;device, CGS_IND_REG__DIDT, ixDIDT_TD_EDC_CTRL, =
data);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; if (PP_CAP(PHM_PlatformCaps_TCPRamping)) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; data =
=3D cgs_read_ind_register(hwmgr-&gt;device, CGS_IND_REG__DIDT, ixDIDT_TCP_E=
DC_CTRL);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; data =3D CGS_REG=
_SET_FIELD(data, DIDT_TCP_EDC_CTRL, EDC_EN, en);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; data =3D CGS_REG=
_SET_FIELD(data, DIDT_TCP_EDC_CTRL, EDC_SW_RST, ~en);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; data =3D REG=
_SET_FIELD(data, DIDT_TCP_EDC_CTRL, EDC_EN, en);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; data =3D REG=
_SET_FIELD(data, DIDT_TCP_EDC_CTRL, EDC_SW_RST, ~en);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; cgs_w=
rite_ind_register(hwmgr-&gt;device, CGS_IND_REG__DIDT, ixDIDT_TCP_EDC_CTRL,=
 data);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; if (PP_CAP(PHM_PlatformCaps_DBRRamping)) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; data =
=3D cgs_read_ind_register(hwmgr-&gt;device, CGS_IND_REG__DIDT, ixDIDT_DBR_E=
DC_CTRL);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; data =3D CGS_REG=
_SET_FIELD(data, DIDT_DBR_EDC_CTRL, EDC_EN, en);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; data =3D CGS_REG=
_SET_FIELD(data, DIDT_DBR_EDC_CTRL, EDC_SW_RST, ~en);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; data =3D REG=
_SET_FIELD(data, DIDT_DBR_EDC_CTRL, EDC_EN, en);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; data =3D REG=
_SET_FIELD(data, DIDT_DBR_EDC_CTRL, EDC_SW_RST, ~en);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; cgs_w=
rite_ind_register(hwmgr-&gt;device, CGS_IND_REG__DIDT, ixDIDT_DBR_EDC_CTRL,=
 data);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
@@ -933,17 &#43;933,15 @@ static int vega10_enable_cac_driving_se_didt_conf=
ig(struct pp_hwmgr *hwmgr)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev=
 =3D hwmgr-&gt;adev;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int result;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t num_se =3D 0, cou=
nt, data;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t reg;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; num_se =3D adev-&gt;gfx.co=
nfig.max_shader_engines;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;gfx.rlc.funcs-&gt=
;enter_safe_mode(adev);<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_lock(&amp;adev-&gt;g=
rbm_idx_mutex);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; reg =3D soc15_get_register_offset(GC_=
HWID, 0, mmGRBM_GFX_INDEX_BASE_IDX, mmGRBM_GFX_INDEX);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (count =3D 0; count &l=
t; num_se; count&#43;&#43;) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; data =3D GRBM_GFX_INDEX__INSTANCE_BROADCAST_WRITES_MA=
SK | GRBM_GFX_INDEX__SH_BROADCAST_WRITES_MASK | ( count &lt;&lt; GRBM_GFX_I=
NDEX__SE_INDEX__SHIFT);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; cgs_write_register(hwmgr-&gt;device, reg, data);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; WREG32_SOC15(GC, 0, mmGRBM_GFX_INDEX, data);<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; result =3D&nbsp; vega10_program_didt_config_registers=
(hwmgr, SEDiDtStallCtrlConfig_vega10, VEGA10_CONFIGREG_DIDT);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; result |=3D vega10_program_didt_config_registers(hwmg=
r, SEDiDtStallPatternConfig_vega10, VEGA10_CONFIGREG_DIDT);<br>
@@ -958,7 &#43;956,7 @@ static int vega10_enable_cac_driving_se_didt_config=
(struct pp_hwmgr *hwmgr)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; if (0 !=3D result)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break=
;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; cgs_write_register(hwmgr-&gt;device, =
reg, 0xE0000000);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32_SOC15(GC, 0, mmGRBM_GFX_IN=
DEX, 0xE0000000);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_unlock(&amp;adev-&gt=
;grbm_idx_mutex);<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; vega10_didt_set_mask(hwmgr=
, true);<br>
@@ -986,17 &#43;984,15 @@ static int vega10_enable_psm_gc_didt_config(struc=
t pp_hwmgr *hwmgr)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev=
 =3D hwmgr-&gt;adev;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int result;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t num_se =3D 0, cou=
nt, data;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t reg;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; num_se =3D adev-&gt;gfx.co=
nfig.max_shader_engines;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;gfx.rlc.funcs-&gt=
;enter_safe_mode(adev);<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_lock(&amp;adev-&gt;g=
rbm_idx_mutex);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; reg =3D soc15_get_register_offset(GC_=
HWID, 0, mmGRBM_GFX_INDEX_BASE_IDX, mmGRBM_GFX_INDEX);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (count =3D 0; count &l=
t; num_se; count&#43;&#43;) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; data =3D GRBM_GFX_INDEX__INSTANCE_BROADCAST_WRITES_MA=
SK | GRBM_GFX_INDEX__SH_BROADCAST_WRITES_MASK | ( count &lt;&lt; GRBM_GFX_I=
NDEX__SE_INDEX__SHIFT);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; cgs_write_register(hwmgr-&gt;device, reg, data);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; WREG32_SOC15(GC, 0, mmGRBM_GFX_INDEX, data);<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; result =3D vega10_program_didt_config_registers(hwmgr=
, SEDiDtStallCtrlConfig_vega10, VEGA10_CONFIGREG_DIDT);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; result |=3D vega10_program_didt_config_registers(hwmg=
r, SEDiDtStallPatternConfig_vega10, VEGA10_CONFIGREG_DIDT);<br>
@@ -1005,7 &#43;1001,7 @@ static int vega10_enable_psm_gc_didt_config(struc=
t pp_hwmgr *hwmgr)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; if (0 !=3D result)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break=
;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; cgs_write_register(hwmgr-&gt;device, =
reg, 0xE0000000);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32_SOC15(GC, 0, mmGRBM_GFX_IN=
DEX, 0xE0000000);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_unlock(&amp;adev-&gt=
;grbm_idx_mutex);<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; vega10_didt_set_mask(hwmgr=
, true);<br>
@@ -1049,17 &#43;1045,15 @@ static int vega10_enable_se_edc_config(struct p=
p_hwmgr *hwmgr)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev=
 =3D hwmgr-&gt;adev;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int result;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t num_se =3D 0, cou=
nt, data;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t reg;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; num_se =3D adev-&gt;gfx.co=
nfig.max_shader_engines;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;gfx.rlc.funcs-&gt=
;enter_safe_mode(adev);<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_lock(&amp;adev-&gt;g=
rbm_idx_mutex);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; reg =3D soc15_get_register_offset(GC_=
HWID, 0, mmGRBM_GFX_INDEX_BASE_IDX, mmGRBM_GFX_INDEX);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (count =3D 0; count &l=
t; num_se; count&#43;&#43;) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; data =3D GRBM_GFX_INDEX__INSTANCE_BROADCAST_WRITES_MA=
SK | GRBM_GFX_INDEX__SH_BROADCAST_WRITES_MASK | ( count &lt;&lt; GRBM_GFX_I=
NDEX__SE_INDEX__SHIFT);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; cgs_write_register(hwmgr-&gt;device, reg, data);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; WREG32_SOC15(GC, 0, mmGRBM_GFX_INDEX, data);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; result =3D vega10_program_didt_config_registers(hwmgr=
, SEDiDtWeightConfig_Vega10, VEGA10_CONFIGREG_DIDT);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; result |=3D vega10_program_didt_config_registers(hwmg=
r, SEEDCStallPatternConfig_Vega10, VEGA10_CONFIGREG_DIDT);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; result |=3D vega10_program_didt_config_registers(hwmg=
r, SEEDCStallDelayConfig_Vega10, VEGA10_CONFIGREG_DIDT);<br>
@@ -1070,7 &#43;1064,7 @@ static int vega10_enable_se_edc_config(struct pp_=
hwmgr *hwmgr)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; if (0 !=3D result)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break=
;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; cgs_write_register(hwmgr-&gt;device, =
reg, 0xE0000000);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32_SOC15(GC, 0, mmGRBM_GFX_IN=
DEX, 0xE0000000);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_unlock(&amp;adev-&gt=
;grbm_idx_mutex);<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; vega10_didt_set_mask(hwmgr=
, true);<br>
@@ -1099,7 &#43;1093,6 @@ static int vega10_enable_psm_gc_edc_config(struct=
 pp_hwmgr *hwmgr)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int result;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t num_se =3D 0;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t count, data;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t reg;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; num_se =3D adev-&gt;gfx.co=
nfig.max_shader_engines;<br>
&nbsp;<br>
@@ -1108,10 &#43;1101,9 @@ static int vega10_enable_psm_gc_edc_config(struc=
t pp_hwmgr *hwmgr)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; vega10_program_gc_didt_con=
fig_registers(hwmgr, AvfsPSMResetConfig_vega10);<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_lock(&amp;adev-&gt;g=
rbm_idx_mutex);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; reg =3D soc15_get_register_offset(GC_=
HWID, 0, mmGRBM_GFX_INDEX_BASE_IDX, mmGRBM_GFX_INDEX);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (count =3D 0; count &l=
t; num_se; count&#43;&#43;) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; data =3D GRBM_GFX_INDEX__INSTANCE_BROADCAST_WRITES_MA=
SK | GRBM_GFX_INDEX__SH_BROADCAST_WRITES_MASK | ( count &lt;&lt; GRBM_GFX_I=
NDEX__SE_INDEX__SHIFT);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; cgs_write_register(hwmgr-&gt;device, reg, data);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; WREG32_SOC15(GC, 0, mmGRBM_GFX_INDEX, data);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; result |=3D vega10_program_didt_config_registers(hwmg=
r, PSMSEEDCStallPatternConfig_Vega10, VEGA10_CONFIGREG_DIDT);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; result |=3D vega10_program_didt_config_registers(hwmg=
r, PSMSEEDCStallDelayConfig_Vega10, VEGA10_CONFIGREG_DIDT);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; result |=3D vega10_program_didt_config_registers(hwmg=
r, PSMSEEDCCtrlResetConfig_Vega10, VEGA10_CONFIGREG_DIDT);<br>
@@ -1120,7 &#43;1112,7 @@ static int vega10_enable_psm_gc_edc_config(struct=
 pp_hwmgr *hwmgr)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; if (0 !=3D result)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break=
;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; cgs_write_register(hwmgr-&gt;device, =
reg, 0xE0000000);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32_SOC15(GC, 0, mmGRBM_GFX_IN=
DEX, 0xE0000000);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_unlock(&amp;adev-&gt=
;grbm_idx_mutex);<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; vega10_didt_set_mask(hwmgr=
, true);<br>
@@ -1165,14 &#43;1157,12 @@ static int vega10_disable_psm_gc_edc_config(str=
uct pp_hwmgr *hwmgr)<br>
&nbsp;static int vega10_enable_se_edc_force_stall_config(struct pp_hwmgr *h=
wmgr)<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev=
 =3D hwmgr-&gt;adev;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t reg;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int result;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;gfx.rlc.funcs-&gt=
;enter_safe_mode(adev);<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_lock(&amp;adev-&gt;g=
rbm_idx_mutex);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; reg =3D soc15_get_register_offset(GC_=
HWID, 0, mmGRBM_GFX_INDEX_BASE_IDX, mmGRBM_GFX_INDEX);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; cgs_write_register(hwmgr-&gt;device, =
reg, 0xE0000000);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32_SOC15(GC, 0, mmGRBM_GFX_IN=
DEX, 0xE0000000);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_unlock(&amp;adev-&gt=
;grbm_idx_mutex);<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; result =3D vega10_program_=
didt_config_registers(hwmgr, SEEDCForceStallPatternConfig_Vega10, VEGA10_CO=
NFIGREG_DIDT);<br>
diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/vega10_thermal.c b/drivers=
/gpu/drm/amd/powerplay/hwmgr/vega10_thermal.c<br>
index 9f18226..aa044c1 100644<br>
--- a/drivers/gpu/drm/amd/powerplay/hwmgr/vega10_thermal.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/powerplay/hwmgr/vega10_thermal.c<br>
@@ -25,7 &#43;25,7 @@<br>
&nbsp;#include &quot;vega10_hwmgr.h&quot;<br>
&nbsp;#include &quot;vega10_ppsmc.h&quot;<br>
&nbsp;#include &quot;vega10_inc.h&quot;<br>
-#include &quot;pp_soc15.h&quot;<br>
&#43;#include &quot;soc15_common.h&quot;<br>
&nbsp;#include &quot;pp_debug.h&quot;<br>
&nbsp;<br>
&nbsp;static int vega10_get_current_rpm(struct pp_hwmgr *hwmgr, uint32_t *c=
urrent_rpm)<br>
@@ -89,6 &#43;89,7 @@ int vega10_fan_ctrl_get_fan_speed_percent(struct pp_h=
wmgr *hwmgr,<br>
&nbsp;<br>
&nbsp;int vega10_fan_ctrl_get_fan_speed_rpm(struct pp_hwmgr *hwmgr, uint32_=
t *speed)<br>
&nbsp;{<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev =3D hw=
mgr-&gt;adev;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct vega10_hwmgr *data =
=3D hwmgr-&gt;backend;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t tach_period;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t crystal_clock_fre=
q;<br>
@@ -100,10 &#43;101,8 @@ int vega10_fan_ctrl_get_fan_speed_rpm(struct pp_hw=
mgr *hwmgr, uint32_t *speed)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (data-&gt;smu_features[=
GNLD_FAN_CONTROL].supported) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; result =3D vega10_get_current_rpm(hwmgr, speed);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; uint32_t reg =3D soc15_get_register_offset(THM_HWID, 0,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mmCG_TACH_STATUS_BASE_IDX, mmCG_TACH_STATUS=
);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; tach_period =3D<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; CGS_REG_GET_FIEL=
D(cgs_read_register(hwmgr-&gt;device, reg),<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; REG_GET_FIEL=
D(RREG32_SOC15(THM, 0, mmCG_TACH_STATUS),<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; CG_TACH_STATUS,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; TACH_PERIOD);<br>
&nbsp;<br>
@@ -127,26 &#43;126,23 @@ int vega10_fan_ctrl_get_fan_speed_rpm(struct pp_h=
wmgr *hwmgr, uint32_t *speed)<br>
&nbsp;*/<br>
&nbsp;int vega10_fan_ctrl_set_static_mode(struct pp_hwmgr *hwmgr, uint32_t =
mode)<br>
&nbsp;{<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t reg;<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; reg =3D soc15_get_register_offset(THM=
_HWID, 0,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mmCG_FDO_CTRL2_B=
ASE_IDX, mmCG_FDO_CTRL2);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev =3D hw=
mgr-&gt;adev;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (hwmgr-&gt;fan_ctrl_is_=
in_default_mode) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; hwmgr-&gt;fan_ctrl_default_mode =3D<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; CGS_REG_GET_FIEL=
D(cgs_read_register(hwmgr-&gt;device, reg),<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; REG_GET_FIEL=
D(RREG32_SOC15(THM, 0, mmCG_FDO_CTRL2),<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; CG_FDO_CTRL2, FDO_PWM_MODE);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; hwmgr-&gt;tmin =3D<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; CGS_REG_GET_FIEL=
D(cgs_read_register(hwmgr-&gt;device, reg),<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; REG_GET_FIEL=
D(RREG32_SOC15(THM, 0, mmCG_FDO_CTRL2),<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; CG_FDO_CTRL2, TMIN);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; hwmgr-&gt;fan_ctrl_is_in_default_mode =3D false;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; cgs_write_register(hwmgr-&gt;device, =
reg,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; CGS_REG_SET_FIEL=
D(cgs_read_register(hwmgr-&gt;device, reg),<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32_SOC15(THM, 0, mmCG_FDO_CTR=
L2,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; REG_SET_FIEL=
D(RREG32_SOC15(THM, 0, mmCG_FDO_CTRL2),<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; CG_FDO_CTRL2, TMIN, 0));<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; cgs_write_register(hwmgr-&gt;device, =
reg,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; CGS_REG_SET_FIEL=
D(cgs_read_register(hwmgr-&gt;device, reg),<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32_SOC15(THM, 0, mmCG_FDO_CTR=
L2,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; REG_SET_FIEL=
D(RREG32_SOC15(THM, 0, mmCG_FDO_CTRL2),<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; CG_FDO_CTRL2, FDO_PWM_MODE, mode=
));<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
@@ -159,18 &#43;155,15 @@ int vega10_fan_ctrl_set_static_mode(struct pp_hwm=
gr *hwmgr, uint32_t mode)<br>
&nbsp;*/<br>
&nbsp;int vega10_fan_ctrl_set_default_mode(struct pp_hwmgr *hwmgr)<br>
&nbsp;{<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t reg;<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; reg =3D soc15_get_register_offset(THM=
_HWID, 0,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mmCG_FDO_CTRL2_B=
ASE_IDX, mmCG_FDO_CTRL2);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev =3D hw=
mgr-&gt;adev;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!hwmgr-&gt;fan_ctrl_is=
_in_default_mode) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; cgs_write_register(hwmgr-&gt;device, reg,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; CGS_REG_SET_FIEL=
D(cgs_read_register(hwmgr-&gt;device, reg),<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; WREG32_SOC15(THM, 0, mmCG_FDO_CTRL2,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; REG_SET_FIEL=
D(RREG32_SOC15(THM, 0, mmCG_FDO_CTRL2),<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; CG_FDO_CTRL2, FDO_PWM_MODE,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; hwmgr-&gt;fan_ctrl_default_mode)=
);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; cgs_write_register(hwmgr-&gt;device, reg,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; CGS_REG_SET_FIEL=
D(cgs_read_register(hwmgr-&gt;device, reg),<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; WREG32_SOC15(THM, 0, mmCG_FDO_CTRL2,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; REG_SET_FIEL=
D(RREG32_SOC15(THM, 0, mmCG_FDO_CTRL2),<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; CG_FDO_CTRL2, TMIN,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; hwmgr-&gt;tmin &lt;&lt; CG_FDO_C=
TRL2__TMIN__SHIFT));<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; hwmgr-&gt;fan_ctrl_is_in_default_mode =3D true;<br>
@@ -257,10 &#43;250,10 @@ int vega10_fan_ctrl_stop_smc_fan_control(struct p=
p_hwmgr *hwmgr)<br>
&nbsp;int vega10_fan_ctrl_set_fan_speed_percent(struct pp_hwmgr *hwmgr,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; uint32_t speed)<br>
&nbsp;{<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev =3D hw=
mgr-&gt;adev;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t duty100;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t duty;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint64_t tmp64;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t reg;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (hwmgr-&gt;thermal_cont=
roller.fanInfo.bNoFan)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return 0;<br>
@@ -271,10 &#43;264,7 @@ int vega10_fan_ctrl_set_fan_speed_percent(struct p=
p_hwmgr *hwmgr,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (PP_CAP(PHM_PlatformCap=
s_MicrocodeFanControl))<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; vega10_fan_ctrl_stop_smc_fan_control(hwmgr);<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; reg =3D soc15_get_register_offset(THM=
_HWID, 0,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mmCG_FDO_CTRL1_B=
ASE_IDX, mmCG_FDO_CTRL1);<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; duty100 =3D CGS_REG_GET_FIELD(cgs_rea=
d_register(hwmgr-&gt;device, reg),<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; duty100 =3D REG_GET_FIELD(RREG32_=
SOC15(THM, 0, mmCG_FDO_CTRL1),<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; CG_FDO_C=
TRL1, FMAX_DUTY100);<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (duty100 =3D=3D 0)<br>
@@ -284,10 &#43;274,8 @@ int vega10_fan_ctrl_set_fan_speed_percent(struct p=
p_hwmgr *hwmgr,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; do_div(tmp64, 100);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; duty =3D (uint32_t)tmp64;<=
br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; reg =3D soc15_get_register_offset(THM=
_HWID, 0,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mmCG_FDO_CTRL0_B=
ASE_IDX, mmCG_FDO_CTRL0);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; cgs_write_register(hwmgr-&gt;device, =
reg,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; CGS_REG_SET_FIELD(cgs_read_register(hwmgr-&gt;device, reg),<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32_SOC15(THM, 0, mmCG_FDO_CTR=
L0,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; REG_SET_FIELD(RREG32_SOC15(THM, 0, mmCG_FDO_CTRL0),<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; CG_FD=
O_CTRL0, FDO_STATIC_DUTY, duty));<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return vega10_fan_ctrl_set=
_static_mode(hwmgr, FDO_PWM_MODE_STATIC);<br>
@@ -317,10 &#43;305,10 @@ int vega10_fan_ctrl_reset_fan_speed_to_default(st=
ruct pp_hwmgr *hwmgr)<br>
&nbsp;*/<br>
&nbsp;int vega10_fan_ctrl_set_fan_speed_rpm(struct pp_hwmgr *hwmgr, uint32_=
t speed)<br>
&nbsp;{<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev =3D hw=
mgr-&gt;adev;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t tach_period;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t crystal_clock_fre=
q;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int result =3D 0;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t reg;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (hwmgr-&gt;thermal_cont=
roller.fanInfo.bNoFan ||<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (s=
peed &lt; hwmgr-&gt;thermal_controller.fanInfo.ulMinRPM) ||<br>
@@ -333,10 &#43;321,8 @@ int vega10_fan_ctrl_set_fan_speed_rpm(struct pp_hw=
mgr *hwmgr, uint32_t speed)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!result) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; crystal_clock_freq =3D amdgpu_asic_get_xclk((struct a=
mdgpu_device *)hwmgr-&gt;adev);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; tach_period =3D 60 * crystal_clock_freq * 10000 / (8 =
* speed);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; reg =3D soc15_get_register_offset(THM_HWID, 0,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mmCG_TACH_STATUS_BASE_IDX, mmCG_TACH_STATUS=
);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; cgs_write_register(hwmgr-&gt;device, reg,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; CGS_REG_SET_FIELD(cgs_read_register(hwmgr-&=
gt;device, reg),<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; WREG32_SOC15(THM, 0, mmCG_TACH_STATUS,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; REG_SET_FIELD(RREG32_SOC15(THM, 0, mmCG=
_TACH_STATUS),<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; CG_TACH_STATUS, TACH_PERIOD,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; tach_period));<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
@@ -350,13 &#43;336,10 @@ int vega10_fan_ctrl_set_fan_speed_rpm(struct pp_h=
wmgr *hwmgr, uint32_t speed)<br>
&nbsp;*/<br>
&nbsp;int vega10_thermal_get_temperature(struct pp_hwmgr *hwmgr)<br>
&nbsp;{<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev =3D hw=
mgr-&gt;adev;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int temp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t reg;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; reg =3D soc15_get_register_offset(THM=
_HWID, 0,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mmCG_MULT_THERMA=
L_STATUS_BASE_IDX,&nbsp; mmCG_MULT_THERMAL_STATUS);<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; temp =3D cgs_read_register(hwmgr-&gt;=
device, reg);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; temp =3D RREG32_SOC15(THM, 0, mmC=
G_MULT_THERMAL_STATUS);<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; temp =3D (temp &amp; CG_MU=
LT_THERMAL_STATUS__CTF_TEMP_MASK) &gt;&gt;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; CG_MU=
LT_THERMAL_STATUS__CTF_TEMP__SHIFT;<br>
@@ -379,11 &#43;362,12 @@ int vega10_thermal_get_temperature(struct pp_hwmg=
r *hwmgr)<br>
&nbsp;static int vega10_thermal_set_temperature_range(struct pp_hwmgr *hwmg=
r,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; struct PP_TemperatureRange *range)<br>
&nbsp;{<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev =3D hw=
mgr-&gt;adev;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int low =3D VEGA10_THERMAL=
_MINIMUM_ALERT_TEMP *<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; PP_TE=
MPERATURE_UNITS_PER_CENTIGRADES;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int high =3D VEGA10_THERMA=
L_MAXIMUM_ALERT_TEMP *<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; PP_TE=
MPERATURE_UNITS_PER_CENTIGRADES;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t val, reg;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t val;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (low &lt; range-&gt;min=
)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; low =3D range-&gt;min;<br>
@@ -393,20 &#43;377,17 @@ static int vega10_thermal_set_temperature_range(s=
truct pp_hwmgr *hwmgr,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (low &gt; high)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return -EINVAL;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; reg =3D soc15_get_register_offset(THM=
_HWID, 0,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mmTHM_THERMAL_IN=
T_CTRL_BASE_IDX, mmTHM_THERMAL_INT_CTRL);<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; val =3D cgs_read_register(hwmgr-&gt;d=
evice, reg);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; val =3D RREG32_SOC15(THM, 0, mmTH=
M_THERMAL_INT_CTRL);<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; val =3D CGS_REG_SET_FIELD(val, THM_TH=
ERMAL_INT_CTRL, MAX_IH_CREDIT, 5);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; val =3D CGS_REG_SET_FIELD(val, THM_TH=
ERMAL_INT_CTRL, THERM_IH_HW_ENA, 1);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; val =3D CGS_REG_SET_FIELD(val, THM_TH=
ERMAL_INT_CTRL, DIG_THERM_INTH, (high / PP_TEMPERATURE_UNITS_PER_CENTIGRADE=
S));<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; val =3D CGS_REG_SET_FIELD(val, THM_TH=
ERMAL_INT_CTRL, DIG_THERM_INTL, (low / PP_TEMPERATURE_UNITS_PER_CENTIGRADES=
));<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; val =3D REG_SET_FIELD(val, THM_TH=
ERMAL_INT_CTRL, MAX_IH_CREDIT, 5);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; val =3D REG_SET_FIELD(val, THM_TH=
ERMAL_INT_CTRL, THERM_IH_HW_ENA, 1);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; val =3D REG_SET_FIELD(val, THM_TH=
ERMAL_INT_CTRL, DIG_THERM_INTH, (high / PP_TEMPERATURE_UNITS_PER_CENTIGRADE=
S));<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; val =3D REG_SET_FIELD(val, THM_TH=
ERMAL_INT_CTRL, DIG_THERM_INTL, (low / PP_TEMPERATURE_UNITS_PER_CENTIGRADES=
));<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; val &amp;=3D (~THM_THERMAL=
_INT_CTRL__THERM_TRIGGER_MASK_MASK) &amp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (~THM=
_THERMAL_INT_CTRL__THERM_INTH_MASK_MASK) &amp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (~THM=
_THERMAL_INT_CTRL__THERM_INTL_MASK_MASK);<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; cgs_write_register(hwmgr-&gt;device, =
reg, val);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32_SOC15(THM, 0, mmTHM_THERMA=
L_INT_CTRL, val);<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&nbsp;}<br>
@@ -418,21 &#43;399,17 @@ static int vega10_thermal_set_temperature_range(s=
truct pp_hwmgr *hwmgr,<br>
&nbsp;*/<br>
&nbsp;static int vega10_thermal_initialize(struct pp_hwmgr *hwmgr)<br>
&nbsp;{<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t reg;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev =3D hw=
mgr-&gt;adev;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (hwmgr-&gt;thermal_cont=
roller.fanInfo.ucTachometerPulsesPerRevolution) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; reg =3D soc15_get_register_offset(THM_HWID, 0,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mmCG_TACH_CTRL_BASE_IDX, mmCG_TACH_CTRL);<b=
r>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; cgs_write_register(hwmgr-&gt;device, reg,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; CGS_REG_SET_FIEL=
D(cgs_read_register(hwmgr-&gt;device, reg),<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; WREG32_SOC15(THM, 0, mmCG_TACH_CTRL,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; REG_SET_FIEL=
D(RREG32_SOC15(THM, 0, mmCG_TACH_CTRL),<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; CG_TACH_CTRL, EDGE_PER_REV,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; hwmgr-&gt;thermal_controller.fan=
Info.ucTachometerPulsesPerRevolution - 1));<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; reg =3D soc15_get_register_offset(THM=
_HWID, 0,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mmCG_FDO_CTRL2_B=
ASE_IDX, mmCG_FDO_CTRL2);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; cgs_write_register(hwmgr-&gt;device, =
reg,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; CGS_REG_SET_FIELD(cgs_read_register(hwmgr-&gt;device, reg),<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32_SOC15(THM, 0, mmCG_FDO_CTR=
L2,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; REG_SET_FIELD(RREG32_SOC15(THM, 0, mmCG_FDO_CTRL2),<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; CG_FD=
O_CTRL2, TACH_PWM_RESP_RATE, 0x28));<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
@@ -445,9 &#43;422,9 @@ static int vega10_thermal_initialize(struct pp_hwmg=
r *hwmgr)<br>
&nbsp;*/<br>
&nbsp;static int vega10_thermal_enable_alert(struct pp_hwmgr *hwmgr)<br>
&nbsp;{<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev =3D hw=
mgr-&gt;adev;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct vega10_hwmgr *data =
=3D hwmgr-&gt;backend;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t val =3D 0;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t reg;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (data-&gt;smu_features[=
GNLD_FW_CTF].supported) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; if (data-&gt;smu_features[GNLD_FW_CTF].enabled)<br>
@@ -465,8 &#43;442,7 @@ static int vega10_thermal_enable_alert(struct pp_hw=
mgr *hwmgr)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; val |=3D (1 &lt;&lt; THM_T=
HERMAL_INT_ENA__THERM_INTL_CLR__SHIFT);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; val |=3D (1 &lt;&lt; THM_T=
HERMAL_INT_ENA__THERM_TRIGGER_CLR__SHIFT);<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; reg =3D soc15_get_register_offset(THM=
_HWID, 0, mmTHM_THERMAL_INT_ENA_BASE_IDX, mmTHM_THERMAL_INT_ENA);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; cgs_write_register(hwmgr-&gt;device, =
reg, val);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32_SOC15(THM, 0, mmTHM_THERMA=
L_INT_ENA, val);<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&nbsp;}<br>
@@ -477,8 &#43;453,8 @@ static int vega10_thermal_enable_alert(struct pp_hw=
mgr *hwmgr)<br>
&nbsp;*/<br>
&nbsp;int vega10_thermal_disable_alert(struct pp_hwmgr *hwmgr)<br>
&nbsp;{<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev =3D hw=
mgr-&gt;adev;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct vega10_hwmgr *data =
=3D hwmgr-&gt;backend;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t reg;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (data-&gt;smu_features[=
GNLD_FW_CTF].supported) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; if (!data-&gt;smu_features[GNLD_FW_CTF].enabled)<br>
@@ -493,8 &#43;469,7 @@ int vega10_thermal_disable_alert(struct pp_hwmgr *h=
wmgr)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; data-&gt;smu_features[GNLD_FW_CTF].enabled =3D false;=
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; reg =3D soc15_get_register_offset(THM=
_HWID, 0, mmTHM_THERMAL_INT_ENA_BASE_IDX, mmTHM_THERMAL_INT_ENA);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; cgs_write_register(hwmgr-&gt;device, =
reg, 0);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32_SOC15(THM, 0, mmTHM_THERMA=
L_INT_ENA, 0);<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&nbsp;}<br>
diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/vega12_hwmgr.c b/drivers/g=
pu/drm/amd/powerplay/hwmgr/vega12_hwmgr.c<br>
index 6a85238..7dca75c 100644<br>
--- a/drivers/gpu/drm/amd/powerplay/hwmgr/vega12_hwmgr.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/powerplay/hwmgr/vega12_hwmgr.c<br>
@@ -34,7 &#43;34,6 @@<br>
&nbsp;#include &quot;atomfirmware.h&quot;<br>
&nbsp;#include &quot;cgs_common.h&quot;<br>
&nbsp;#include &quot;vega12_inc.h&quot;<br>
-#include &quot;pp_soc15.h&quot;<br>
&nbsp;#include &quot;pppcielanes.h&quot;<br>
&nbsp;#include &quot;vega12_hwmgr.h&quot;<br>
&nbsp;#include &quot;vega12_processpptables.h&quot;<br>
diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/vega12_thermal.c b/drivers=
/gpu/drm/amd/powerplay/hwmgr/vega12_thermal.c<br>
index df0fa81..cfd9e6c 100644<br>
--- a/drivers/gpu/drm/amd/powerplay/hwmgr/vega12_thermal.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/powerplay/hwmgr/vega12_thermal.c<br>
@@ -26,7 &#43;26,7 @@<br>
&nbsp;#include &quot;vega12_smumgr.h&quot;<br>
&nbsp;#include &quot;vega12_ppsmc.h&quot;<br>
&nbsp;#include &quot;vega12_inc.h&quot;<br>
-#include &quot;pp_soc15.h&quot;<br>
&#43;#include &quot;soc15_common.h&quot;<br>
&nbsp;#include &quot;pp_debug.h&quot;<br>
&nbsp;<br>
&nbsp;static int vega12_get_current_rpm(struct pp_hwmgr *hwmgr, uint32_t *c=
urrent_rpm)<br>
@@ -147,13 &#43;147,10 @@ int vega12_fan_ctrl_reset_fan_speed_to_default(st=
ruct pp_hwmgr *hwmgr)<br>
&nbsp;*/<br>
&nbsp;int vega12_thermal_get_temperature(struct pp_hwmgr *hwmgr)<br>
&nbsp;{<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev =3D hw=
mgr-&gt;adev;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int temp =3D 0;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t reg;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; reg =3D soc15_get_register_offset(THM=
_HWID, 0,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mmCG_MULT_THERMA=
L_STATUS_BASE_IDX,&nbsp; mmCG_MULT_THERMAL_STATUS);<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; temp =3D cgs_read_register(hwmgr-&gt;=
device, reg);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; temp =3D RREG32_SOC15(THM, 0, mmC=
G_MULT_THERMAL_STATUS);<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; temp =3D (temp &amp; CG_MU=
LT_THERMAL_STATUS__CTF_TEMP_MASK) &gt;&gt;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; CG_MU=
LT_THERMAL_STATUS__CTF_TEMP__SHIFT;<br>
@@ -175,11 &#43;172,12 @@ int vega12_thermal_get_temperature(struct pp_hwmg=
r *hwmgr)<br>
&nbsp;static int vega12_thermal_set_temperature_range(struct pp_hwmgr *hwmg=
r,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; struct PP_TemperatureRange *range)<br>
&nbsp;{<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev =3D hw=
mgr-&gt;adev;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int low =3D VEGA12_THERMAL=
_MINIMUM_ALERT_TEMP *<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; PP_TE=
MPERATURE_UNITS_PER_CENTIGRADES;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int high =3D VEGA12_THERMA=
L_MAXIMUM_ALERT_TEMP *<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; PP_TE=
MPERATURE_UNITS_PER_CENTIGRADES;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t val, reg;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t val;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (low &lt; range-&gt;min=
)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; low =3D range-&gt;min;<br>
@@ -189,18 &#43;187,15 @@ static int vega12_thermal_set_temperature_range(s=
truct pp_hwmgr *hwmgr,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (low &gt; high)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return -EINVAL;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; reg =3D soc15_get_register_offset(THM=
_HWID, 0,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mmTHM_THERMAL_IN=
T_CTRL_BASE_IDX, mmTHM_THERMAL_INT_CTRL);<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; val =3D cgs_read_register(hwmgr-&gt;d=
evice, reg);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; val =3D RREG32_SOC15(THM, 0, mmTH=
M_THERMAL_INT_CTRL);<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; val =3D CGS_REG_SET_FIELD(val, THM_TH=
ERMAL_INT_CTRL, MAX_IH_CREDIT, 5);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; val =3D CGS_REG_SET_FIELD(val, THM_TH=
ERMAL_INT_CTRL, THERM_IH_HW_ENA, 1);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; val =3D CGS_REG_SET_FIELD(val, THM_TH=
ERMAL_INT_CTRL, DIG_THERM_INTH, (high / PP_TEMPERATURE_UNITS_PER_CENTIGRADE=
S));<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; val =3D CGS_REG_SET_FIELD(val, THM_TH=
ERMAL_INT_CTRL, DIG_THERM_INTL, (low / PP_TEMPERATURE_UNITS_PER_CENTIGRADES=
));<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; val =3D REG_SET_FIELD(val, THM_TH=
ERMAL_INT_CTRL, MAX_IH_CREDIT, 5);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; val =3D REG_SET_FIELD(val, THM_TH=
ERMAL_INT_CTRL, THERM_IH_HW_ENA, 1);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; val =3D REG_SET_FIELD(val, THM_TH=
ERMAL_INT_CTRL, DIG_THERM_INTH, (high / PP_TEMPERATURE_UNITS_PER_CENTIGRADE=
S));<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; val =3D REG_SET_FIELD(val, THM_TH=
ERMAL_INT_CTRL, DIG_THERM_INTL, (low / PP_TEMPERATURE_UNITS_PER_CENTIGRADES=
));<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; val =3D val &amp; (~THM_TH=
ERMAL_INT_CTRL__THERM_TRIGGER_MASK_MASK);<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; cgs_write_register(hwmgr-&gt;device, =
reg, val);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32_SOC15(THM, 0, mmTHM_THERMA=
L_INT_CTRL, val);<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&nbsp;}<br>
@@ -212,15 &#43;207,14 @@ static int vega12_thermal_set_temperature_range(s=
truct pp_hwmgr *hwmgr,<br>
&nbsp;*/<br>
&nbsp;static int vega12_thermal_enable_alert(struct pp_hwmgr *hwmgr)<br>
&nbsp;{<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev =3D hw=
mgr-&gt;adev;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t val =3D 0;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t reg;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; val |=3D (1 &lt;&lt; THM_T=
HERMAL_INT_ENA__THERM_INTH_CLR__SHIFT);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; val |=3D (1 &lt;&lt; THM_T=
HERMAL_INT_ENA__THERM_INTL_CLR__SHIFT);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; val |=3D (1 &lt;&lt; THM_T=
HERMAL_INT_ENA__THERM_TRIGGER_CLR__SHIFT);<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; reg =3D soc15_get_register_offset(THM=
_HWID, 0, mmTHM_THERMAL_INT_ENA_BASE_IDX, mmTHM_THERMAL_INT_ENA);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; cgs_write_register(hwmgr-&gt;device, =
reg, val);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32_SOC15(THM, 0, mmTHM_THERMA=
L_INT_ENA, val);<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&nbsp;}<br>
@@ -231,10 &#43;225,9 @@ static int vega12_thermal_enable_alert(struct pp_h=
wmgr *hwmgr)<br>
&nbsp;*/<br>
&nbsp;int vega12_thermal_disable_alert(struct pp_hwmgr *hwmgr)<br>
&nbsp;{<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t reg;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev =3D hw=
mgr-&gt;adev;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; reg =3D soc15_get_register_offset(THM=
_HWID, 0, mmTHM_THERMAL_INT_ENA_BASE_IDX, mmTHM_THERMAL_INT_ENA);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; cgs_write_register(hwmgr-&gt;device, =
reg, 0);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32_SOC15(THM, 0, mmTHM_THERMA=
L_INT_ENA, 0);<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&nbsp;}<br>
diff --git a/drivers/gpu/drm/amd/powerplay/inc/pp_soc15.h b/drivers/gpu/drm=
/amd/powerplay/inc/pp_soc15.h<br>
deleted file mode 100644<br>
index 214f370..0000000<br>
--- a/drivers/gpu/drm/amd/powerplay/inc/pp_soc15.h<br>
&#43;&#43;&#43; /dev/null<br>
@@ -1,52 &#43;0,0 @@<br>
-/*<br>
- * Copyright 2016 Advanced Micro Devices, Inc.<br>
- *<br>
- * Permission is hereby granted, free of charge, to any person obtaining a=
<br>
- * copy of this software and associated documentation files (the &quot;Sof=
tware&quot;),<br>
- * to deal in the Software without restriction, including without limitati=
on<br>
- * the rights to use, copy, modify, merge, publish, distribute, sublicense=
,<br>
- * and/or sell copies of the Software, and to permit persons to whom the<b=
r>
- * Software is furnished to do so, subject to the following conditions:<br=
>
- *<br>
- * The above copyright notice and this permission notice shall be included=
 in<br>
- * all copies or substantial portions of the Software.<br>
- *<br>
- * THE SOFTWARE IS PROVIDED &quot;AS IS&quot;, WITHOUT WARRANTY OF ANY KIN=
D, EXPRESS OR<br>
- * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY=
,<br>
- * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.&nbsp; IN NO EVENT=
 SHALL<br>
- * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES O=
R<br>
- * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,<b=
r>
- * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR<b=
r>
- * OTHER DEALINGS IN THE SOFTWARE.<br>
- *<br>
- */<br>
-#ifndef PP_SOC15_H<br>
-#define PP_SOC15_H<br>
-<br>
-#include &quot;soc15_hw_ip.h&quot;<br>
-#include &quot;vega10_ip_offset.h&quot;<br>
-<br>
-inline static uint32_t soc15_get_register_offset(<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; uint32_t hw_id,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; uint32_t inst,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; uint32_t segment,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; uint32_t offset)<br>
-{<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t reg =3D 0;<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (hw_id =3D=3D THM_HWID)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; reg =3D THM_BASE.instance[inst].segment[segment] &#43; offset;<b=
r>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; else if (hw_id =3D=3D NBIF_HWID)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; reg =3D NBIF_BASE.instance[inst].segment[segment] &#43; offset;<=
br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; else if (hw_id =3D=3D MP1_HWID)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; reg =3D MP1_BASE.instance[inst].segment[segment] &#43; offset;<b=
r>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; else if (hw_id =3D=3D DF_HWID)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; reg =3D DF_BASE.instance[inst].segment[segment] &#43; offset;<br=
>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; else if (hw_id =3D=3D GC_HWID)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; reg =3D GC_BASE.instance[inst].segment[segment] &#43; offset;<br=
>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; else if (hw_id =3D=3D SMUIO_HWID)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; reg =3D SMUIO_BASE.instance[inst].segment[segment] &#43; offset;=
<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return reg;<br>
-}<br>
-<br>
-#endif<br>
diff --git a/drivers/gpu/drm/amd/powerplay/smumgr/smu10_smumgr.c b/drivers/=
gpu/drm/amd/powerplay/smumgr/smu10_smumgr.c<br>
index bc53f2b..9adea72 100644<br>
--- a/drivers/gpu/drm/amd/powerplay/smumgr/smu10_smumgr.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/powerplay/smumgr/smu10_smumgr.c<br>
@@ -23,7 &#43;23,7 @@<br>
&nbsp;<br>
&nbsp;#include &quot;smumgr.h&quot;<br>
&nbsp;#include &quot;smu10_inc.h&quot;<br>
-#include &quot;pp_soc15.h&quot;<br>
&#43;#include &quot;soc15_common.h&quot;<br>
&nbsp;#include &quot;smu10_smumgr.h&quot;<br>
&nbsp;#include &quot;ppatomctrl.h&quot;<br>
&nbsp;#include &quot;rv_ppsmc.h&quot;<br>
@@ -49,48 &#43;49,41 @@<br>
&nbsp;<br>
&nbsp;static uint32_t smu10_wait_for_response(struct pp_hwmgr *hwmgr)<br>
&nbsp;{<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev =3D hw=
mgr-&gt;adev;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t reg;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; reg =3D soc15_get_register_offset(MP1=
_HWID, 0,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mmMP1_SMN_C2PMSG=
_90_BASE_IDX, mmMP1_SMN_C2PMSG_90);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; reg =3D SOC15_REG_OFFSET(MP1, 0, =
mmMP1_SMN_C2PMSG_90);<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; phm_wait_for_register_uneq=
ual(hwmgr, reg,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0, MP=
1_C2PMSG_90__CONTENT_MASK);<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return cgs_read_register(hwmgr-&gt;de=
vice, reg);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return RREG32_SOC15(MP1, 0, mmMP1=
_SMN_C2PMSG_90);<br>
&nbsp;}<br>
&nbsp;<br>
&nbsp;static int smu10_send_msg_to_smc_without_waiting(struct pp_hwmgr *hwm=
gr,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; uint16_t msg)<br>
&nbsp;{<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t reg;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev =3D hw=
mgr-&gt;adev;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; reg =3D soc15_get_register_offset(MP1=
_HWID, 0,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mmMP1_SMN_C2PMSG=
_66_BASE_IDX, mmMP1_SMN_C2PMSG_66);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; cgs_write_register(hwmgr-&gt;device, =
reg, msg);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32_SOC15(MP1, 0, mmMP1_SMN_C2=
PMSG_66, msg);<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&nbsp;}<br>
&nbsp;<br>
&nbsp;static int smu10_read_arg_from_smc(struct pp_hwmgr *hwmgr)<br>
&nbsp;{<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t reg;<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; reg =3D soc15_get_register_offset(MP1=
_HWID, 0,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mmMP1_SMN_C2PMSG=
_82_BASE_IDX, mmMP1_SMN_C2PMSG_82);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev =3D hw=
mgr-&gt;adev;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return cgs_read_register(hwmgr-&gt;de=
vice, reg);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return RREG32_SOC15(MP1, 0, mmMP1=
_SMN_C2PMSG_82);<br>
&nbsp;}<br>
&nbsp;<br>
&nbsp;static int smu10_send_msg_to_smc(struct pp_hwmgr *hwmgr, uint16_t msg=
)<br>
&nbsp;{<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t reg;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev =3D hw=
mgr-&gt;adev;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smu10_wait_for_response(hw=
mgr);<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; reg =3D soc15_get_register_offset(MP1=
_HWID, 0,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mmMP1_SMN_C2PMSG=
_90_BASE_IDX, mmMP1_SMN_C2PMSG_90);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; cgs_write_register(hwmgr-&gt;device, =
reg, 0);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32_SOC15(MP1, 0, mmMP1_SMN_C2=
PMSG_90, 0);<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smu10_send_msg_to_smc_with=
out_waiting(hwmgr, msg);<br>
&nbsp;<br>
@@ -104,17 &#43;97,13 @@ static int smu10_send_msg_to_smc(struct pp_hwmgr *=
hwmgr, uint16_t msg)<br>
&nbsp;static int smu10_send_msg_to_smc_with_parameter(struct pp_hwmgr *hwmg=
r,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; uint16_t msg, uint32_t parameter)<br>
&nbsp;{<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t reg;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev =3D hw=
mgr-&gt;adev;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smu10_wait_for_response(hw=
mgr);<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; reg =3D soc15_get_register_offset(MP1=
_HWID, 0,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mmMP1_SMN_C2PMSG=
_90_BASE_IDX, mmMP1_SMN_C2PMSG_90);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; cgs_write_register(hwmgr-&gt;device, =
reg, 0);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32_SOC15(MP1, 0, mmMP1_SMN_C2=
PMSG_90, 0);<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; reg =3D soc15_get_register_offset(MP1=
_HWID, 0,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mmMP1_SMN_C2PMSG=
_82_BASE_IDX, mmMP1_SMN_C2PMSG_82);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; cgs_write_register(hwmgr-&gt;device, =
reg, parameter);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32_SOC15(MP1, 0, mmMP1_SMN_C2=
PMSG_82, parameter);<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smu10_send_msg_to_smc_with=
out_waiting(hwmgr, msg);<br>
&nbsp;<br>
diff --git a/drivers/gpu/drm/amd/powerplay/smumgr/vega10_smumgr.c b/drivers=
/gpu/drm/amd/powerplay/smumgr/vega10_smumgr.c<br>
index 4aafb04..14ac6d1 100644<br>
--- a/drivers/gpu/drm/amd/powerplay/smumgr/vega10_smumgr.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/powerplay/smumgr/vega10_smumgr.c<br>
@@ -23,7 &#43;23,7 @@<br>
&nbsp;<br>
&nbsp;#include &quot;smumgr.h&quot;<br>
&nbsp;#include &quot;vega10_inc.h&quot;<br>
-#include &quot;pp_soc15.h&quot;<br>
&#43;#include &quot;soc15_common.h&quot;<br>
&nbsp;#include &quot;vega10_smumgr.h&quot;<br>
&nbsp;#include &quot;vega10_hwmgr.h&quot;<br>
&nbsp;#include &quot;vega10_ppsmc.h&quot;<br>
@@ -54,18 &#43;54,13 @@<br>
&nbsp;<br>
&nbsp;static bool vega10_is_smc_ram_running(struct pp_hwmgr *hwmgr)<br>
&nbsp;{<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t mp1_fw_flags, reg;<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; reg =3D soc15_get_register_offset(NBI=
F_HWID, 0,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mmPCIE_INDEX2_BA=
SE_IDX, mmPCIE_INDEX2);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev =3D hw=
mgr-&gt;adev;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t mp1_fw_flags;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; cgs_write_register(hwmgr-&gt;device, =
reg,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32_SOC15(NBIF, 0, mmPCIE_INDE=
X2,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (MP1_=
Public | (smnMP1_FIRMWARE_FLAGS &amp; 0xffffffff)));<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; reg =3D soc15_get_register_offset(NBI=
F_HWID, 0,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mmPCIE_DATA2_BAS=
E_IDX, mmPCIE_DATA2);<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mp1_fw_flags =3D cgs_read_register(hw=
mgr-&gt;device, reg);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mp1_fw_flags =3D RREG32_SOC15(NBI=
F, 0, mmPCIE_DATA2);<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (mp1_fw_flags &amp; MP1=
_FIRMWARE_FLAGS__INTERRUPTS_ENABLED_MASK)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return true;<br>
@@ -81,11 &#43;76,11 @@ static bool vega10_is_smc_ram_running(struct pp_hwm=
gr *hwmgr)<br>
&nbsp; */<br>
&nbsp;static uint32_t vega10_wait_for_response(struct pp_hwmgr *hwmgr)<br>
&nbsp;{<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev =3D hw=
mgr-&gt;adev;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t reg;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t ret;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; reg =3D soc15_get_register_offset(MP1=
_HWID, 0,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mmMP1_SMN_C2PMSG=
_90_BASE_IDX, mmMP1_SMN_C2PMSG_90);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; reg =3D SOC15_REG_OFFSET(MP1, 0, =
mmMP1_SMN_C2PMSG_90);<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D phm_wait_for_regis=
ter_unequal(hwmgr, reg,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0, MP=
1_C2PMSG_90__CONTENT_MASK);<br>
@@ -93,7 &#43;88,7 @@ static uint32_t vega10_wait_for_response(struct pp_hw=
mgr *hwmgr)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; pr_err(&quot;No response from smu\n&quot;);<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return cgs_read_register(hwmgr-&gt;de=
vice, reg);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return RREG32_SOC15(MP1, 0, mmMP1=
_SMN_C2PMSG_90);<br>
&nbsp;}<br>
&nbsp;<br>
&nbsp;/*<br>
@@ -105,11 &#43;100,9 @@ static uint32_t vega10_wait_for_response(struct pp=
_hwmgr *hwmgr)<br>
&nbsp;static int vega10_send_msg_to_smc_without_waiting(struct pp_hwmgr *hw=
mgr,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; uint16_t msg)<br>
&nbsp;{<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t reg;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev =3D hw=
mgr-&gt;adev;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; reg =3D soc15_get_register_offset(MP1=
_HWID, 0,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mmMP1_SMN_C2PMSG=
_66_BASE_IDX, mmMP1_SMN_C2PMSG_66);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; cgs_write_register(hwmgr-&gt;device, =
reg, msg);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32_SOC15(MP1, 0, mmMP1_SMN_C2=
PMSG_66, msg);<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&nbsp;}<br>
@@ -122,14 &#43;115,12 @@ static int vega10_send_msg_to_smc_without_waiting=
(struct pp_hwmgr *hwmgr,<br>
&nbsp; */<br>
&nbsp;static int vega10_send_msg_to_smc(struct pp_hwmgr *hwmgr, uint16_t ms=
g)<br>
&nbsp;{<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t reg;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev =3D hw=
mgr-&gt;adev;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t ret;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; vega10_wait_for_response(h=
wmgr);<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; reg =3D soc15_get_register_offset(MP1=
_HWID, 0,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mmMP1_SMN_C2PMSG=
_90_BASE_IDX, mmMP1_SMN_C2PMSG_90);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; cgs_write_register(hwmgr-&gt;device, =
reg, 0);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32_SOC15(MP1, 0, mmMP1_SMN_C2=
PMSG_90, 0);<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; vega10_send_msg_to_smc_wit=
hout_waiting(hwmgr, msg);<br>
&nbsp;<br>
@@ -150,18 &#43;141,14 @@ static int vega10_send_msg_to_smc(struct pp_hwmgr=
 *hwmgr, uint16_t msg)<br>
&nbsp;static int vega10_send_msg_to_smc_with_parameter(struct pp_hwmgr *hwm=
gr,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; uint16_t msg, uint32_t parameter)<br>
&nbsp;{<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t reg;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev =3D hw=
mgr-&gt;adev;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t ret;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; vega10_wait_for_response(h=
wmgr);<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; reg =3D soc15_get_register_offset(MP1=
_HWID, 0,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mmMP1_SMN_C2PMSG=
_90_BASE_IDX, mmMP1_SMN_C2PMSG_90);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; cgs_write_register(hwmgr-&gt;device, =
reg, 0);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32_SOC15(MP1, 0, mmMP1_SMN_C2=
PMSG_90, 0);<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; reg =3D soc15_get_register_offset(MP1=
_HWID, 0,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mmMP1_SMN_C2PMSG=
_82_BASE_IDX, mmMP1_SMN_C2PMSG_82);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; cgs_write_register(hwmgr-&gt;device, =
reg, parameter);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32_SOC15(MP1, 0, mmMP1_SMN_C2=
PMSG_82, parameter);<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; vega10_send_msg_to_smc_wit=
hout_waiting(hwmgr, msg);<br>
&nbsp;<br>
@@ -174,12 &#43;161,9 @@ static int vega10_send_msg_to_smc_with_parameter(s=
truct pp_hwmgr *hwmgr,<br>
&nbsp;<br>
&nbsp;static int vega10_get_argument(struct pp_hwmgr *hwmgr)<br>
&nbsp;{<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t reg;<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; reg =3D soc15_get_register_offset(MP1=
_HWID, 0,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mmMP1_SMN_C2PMSG=
_82_BASE_IDX, mmMP1_SMN_C2PMSG_82);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev =3D hw=
mgr-&gt;adev;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return cgs_read_register(hwmgr-&gt;de=
vice, reg);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return RREG32_SOC15(MP1, 0, mmMP1=
_SMN_C2PMSG_82);<br>
&nbsp;}<br>
&nbsp;<br>
&nbsp;static int vega10_copy_table_from_smc(struct pp_hwmgr *hwmgr,<br>
diff --git a/drivers/gpu/drm/amd/powerplay/smumgr/vega12_smumgr.c b/drivers=
/gpu/drm/amd/powerplay/smumgr/vega12_smumgr.c<br>
index 651a3f2..7d9b40e 100644<br>
--- a/drivers/gpu/drm/amd/powerplay/smumgr/vega12_smumgr.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/powerplay/smumgr/vega12_smumgr.c<br>
@@ -23,7 &#43;23,7 @@<br>
&nbsp;<br>
&nbsp;#include &quot;smumgr.h&quot;<br>
&nbsp;#include &quot;vega12_inc.h&quot;<br>
-#include &quot;pp_soc15.h&quot;<br>
&#43;#include &quot;soc15_common.h&quot;<br>
&nbsp;#include &quot;vega12_smumgr.h&quot;<br>
&nbsp;#include &quot;vega12_ppsmc.h&quot;<br>
&nbsp;#include &quot;vega12/smu9_driver_if.h&quot;<br>
@@ -44,18 &#43;44,13 @@<br>
&nbsp;<br>
&nbsp;static bool vega12_is_smc_ram_running(struct pp_hwmgr *hwmgr)<br>
&nbsp;{<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t mp1_fw_flags, reg;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev =3D hw=
mgr-&gt;adev;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t mp1_fw_flags;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; reg =3D soc15_get_register_offset(NBI=
F_HWID, 0,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mmPCIE_INDEX2_BA=
SE_IDX, mmPCIE_INDEX2);<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; cgs_write_register(hwmgr-&gt;device, =
reg,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32_SOC15(NBIF, 0, mmPCIE_INDE=
X2,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (MP1_=
Public | (smnMP1_FIRMWARE_FLAGS &amp; 0xffffffff)));<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; reg =3D soc15_get_register_offset(NBI=
F_HWID, 0,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mmPCIE_DATA2_BAS=
E_IDX, mmPCIE_DATA2);<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mp1_fw_flags =3D cgs_read_register(hw=
mgr-&gt;device, reg);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mp1_fw_flags =3D RREG32_SOC15(NBI=
F, 0, mmPCIE_DATA2);<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if ((mp1_fw_flags &amp; MP=
1_FIRMWARE_FLAGS__INTERRUPTS_ENABLED_MASK) &gt;&gt;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; MP1_FIRMWARE_FLAGS__INTERRUPTS_E=
NABLED__SHIFT)<br>
@@ -72,15 &#43;67,15 @@ static bool vega12_is_smc_ram_running(struct pp_hwm=
gr *hwmgr)<br>
&nbsp; */<br>
&nbsp;static uint32_t vega12_wait_for_response(struct pp_hwmgr *hwmgr)<br>
&nbsp;{<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev =3D hw=
mgr-&gt;adev;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t reg;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; reg =3D soc15_get_register_offset(MP1=
_HWID, 0,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mmMP1_SMN_C2PMSG=
_90_BASE_IDX, mmMP1_SMN_C2PMSG_90);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; reg =3D SOC15_REG_OFFSET(MP1, 0, =
mmMP1_SMN_C2PMSG_90);<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; phm_wait_for_register_uneq=
ual(hwmgr, reg,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0, MP=
1_C2PMSG_90__CONTENT_MASK);<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return cgs_read_register(hwmgr-&gt;de=
vice, reg);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return RREG32_SOC15(MP1, 0, mmMP1=
_SMN_C2PMSG_90);<br>
&nbsp;}<br>
&nbsp;<br>
&nbsp;/*<br>
@@ -92,11 &#43;87,9 @@ static uint32_t vega12_wait_for_response(struct pp_h=
wmgr *hwmgr)<br>
&nbsp;int vega12_send_msg_to_smc_without_waiting(struct pp_hwmgr *hwmgr,<br=
>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; uint16_t msg)<br>
&nbsp;{<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t reg;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev =3D hw=
mgr-&gt;adev;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; reg =3D soc15_get_register_offset(MP1=
_HWID, 0,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mmMP1_SMN_C2PMSG=
_66_BASE_IDX, mmMP1_SMN_C2PMSG_66);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; cgs_write_register(hwmgr-&gt;device, =
reg, msg);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32_SOC15(MP1, 0, mmMP1_SMN_C2=
PMSG_66, msg);<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&nbsp;}<br>
@@ -109,13 &#43;102,11 @@ int vega12_send_msg_to_smc_without_waiting(struct=
 pp_hwmgr *hwmgr,<br>
&nbsp; */<br>
&nbsp;int vega12_send_msg_to_smc(struct pp_hwmgr *hwmgr, uint16_t msg)<br>
&nbsp;{<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t reg;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev =3D hw=
mgr-&gt;adev;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; vega12_wait_for_response(h=
wmgr);<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; reg =3D soc15_get_register_offset(MP1=
_HWID, 0,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mmMP1_SMN_C2PMSG=
_90_BASE_IDX, mmMP1_SMN_C2PMSG_90);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; cgs_write_register(hwmgr-&gt;device, =
reg, 0);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32_SOC15(MP1, 0, mmMP1_SMN_C2=
PMSG_90, 0);<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; vega12_send_msg_to_smc_wit=
hout_waiting(hwmgr, msg);<br>
&nbsp;<br>
@@ -135,17 &#43;126,13 @@ int vega12_send_msg_to_smc(struct pp_hwmgr *hwmgr=
, uint16_t msg)<br>
&nbsp;int vega12_send_msg_to_smc_with_parameter(struct pp_hwmgr *hwmgr,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; uint16_t msg, uint32_t parameter)<br>
&nbsp;{<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t reg;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev =3D hw=
mgr-&gt;adev;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; vega12_wait_for_response(h=
wmgr);<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; reg =3D soc15_get_register_offset(MP1=
_HWID, 0,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mmMP1_SMN_C2PMSG=
_90_BASE_IDX, mmMP1_SMN_C2PMSG_90);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; cgs_write_register(hwmgr-&gt;device, =
reg, 0);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32_SOC15(MP1, 0, mmMP1_SMN_C2=
PMSG_90, 0);<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; reg =3D soc15_get_register_offset(MP1=
_HWID, 0,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mmMP1_SMN_C2PMSG=
_82_BASE_IDX, mmMP1_SMN_C2PMSG_82);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; cgs_write_register(hwmgr-&gt;device, =
reg, parameter);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32_SOC15(MP1, 0, mmMP1_SMN_C2=
PMSG_82, parameter);<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; vega12_send_msg_to_smc_wit=
hout_waiting(hwmgr, msg);<br>
&nbsp;<br>
@@ -166,11 &#43;153,9 @@ int vega12_send_msg_to_smc_with_parameter(struct p=
p_hwmgr *hwmgr,<br>
&nbsp;int vega12_send_msg_to_smc_with_parameter_without_waiting(<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; struct pp_hwmgr *hwmgr, uint16_t msg, uint32_t parame=
ter)<br>
&nbsp;{<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t reg;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev =3D hw=
mgr-&gt;adev;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; reg =3D soc15_get_register_offset(MP1=
_HWID, 0,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mmMP1_SMN_C2PMSG=
_66_BASE_IDX, mmMP1_SMN_C2PMSG_66);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; cgs_write_register(hwmgr-&gt;device, =
reg, parameter);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32_SOC15(MP1, 0, mmMP1_SMN_C2=
PMSG_66, parameter);<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return vega12_send_msg_to_=
smc_without_waiting(hwmgr, msg);<br>
&nbsp;}<br>
@@ -183,12 &#43;168,9 @@ int vega12_send_msg_to_smc_with_parameter_without_=
waiting(<br>
&nbsp; */<br>
&nbsp;int vega12_read_arg_from_smc(struct pp_hwmgr *hwmgr, uint32_t *arg)<b=
r>
&nbsp;{<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t reg;<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; reg =3D soc15_get_register_offset(MP1=
_HWID, 0,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mmMP1_SMN_C2PMSG=
_82_BASE_IDX, mmMP1_SMN_C2PMSG_82);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev =3D hw=
mgr-&gt;adev;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *arg =3D cgs_read_register(hwmgr-&gt;=
device, reg);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *arg =3D RREG32_SOC15(MP1, 0, mmM=
P1_SMN_C2PMSG_82);<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&nbsp;}<br>
-- <br>
2.7.4<br>
<br>
</div>
</span></font></div>
</div>
</div>
</body>
</html>

--_000_CY4PR12MB1687981C7066CC1F99DF3B46FBBE0CY4PR12MB1687namp_--

--===============1872829856==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============1872829856==--
