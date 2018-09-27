From: "Zhu, Rex" <Rex.Zhu-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH v2] drm/amd/pp: Export load_firmware interface
Date: Thu, 27 Sep 2018 14:09:29 +0000
Message-ID: <BYAPR12MB2775243258483D0EC9EA2E65FB140@BYAPR12MB2775.namprd12.prod.outlook.com>
References: <1538056543-23070-1-git-send-email-Rex.Zhu@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2082822779=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1538056543-23070-1-git-send-email-Rex.Zhu-5C7GfCeVMHo@public.gmane.org>
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
To: "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

--===============2082822779==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_BYAPR12MB2775243258483D0EC9EA2E65FB140BYAPR12MB2775namp_"

--_000_BYAPR12MB2775243258483D0EC9EA2E65FB140BYAPR12MB2775namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Sorry, Please ignore this patch.




Best Regards

Rex

________________________________
From: amd-gfx <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org> on behalf of Rex Zhu =
<Rex.Zhu-5C7GfCeVMHo@public.gmane.org>
Sent: Thursday, September 27, 2018 9:55 PM
To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Cc: Zhu, Rex
Subject: [PATCH v2] drm/amd/pp: Export load_firmware interface

Export this interface for the AMDGPU_FW_LOAD_SMU type.
gfx/sdma can request smu to load firmware.

Split the smu7/8_start_smu function into two functions
1. start_smu, used for load smu firmware in smu7/8 and
   check smu firmware version.
2. request_smu_load_fw, used for load other ip's firmware
   on smu7/8 and add firmware loading staus check.

v2: default fw loading type is via smu for VI, driver call smu
    to load all fw at the begin of hw init.

Signed-off-by: Rex Zhu <Rex.Zhu-5C7GfCeVMHo@public.gmane.org>
---
 drivers/gpu/drm/amd/amdgpu/vi.c                    | 16 ++++++
 drivers/gpu/drm/amd/powerplay/amd_powerplay.c      | 20 ++++----
 drivers/gpu/drm/amd/powerplay/smumgr/fiji_smumgr.c |  4 +-
 .../gpu/drm/amd/powerplay/smumgr/iceland_smumgr.c  | 25 ++++-----
 .../drm/amd/powerplay/smumgr/polaris10_smumgr.c    |  4 +-
 drivers/gpu/drm/amd/powerplay/smumgr/smu7_smumgr.c | 59 +++++-------------=
----
 drivers/gpu/drm/amd/powerplay/smumgr/smu7_smumgr.h |  3 +-
 drivers/gpu/drm/amd/powerplay/smumgr/smu8_smumgr.c | 46 ++++++++---------
 .../gpu/drm/amd/powerplay/smumgr/tonga_smumgr.c    | 12 ++++-
 .../gpu/drm/amd/powerplay/smumgr/vegam_smumgr.c    |  4 +-
 10 files changed, 86 insertions(+), 107 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/vi.c b/drivers/gpu/drm/amd/amdgpu/v=
i.c
index 88b57a5..3384a15 100644
--- a/drivers/gpu/drm/amd/amdgpu/vi.c
+++ b/drivers/gpu/drm/amd/amdgpu/vi.c
@@ -1222,6 +1222,16 @@ static int vi_common_hw_init(void *handle)
         /* enable the doorbell aperture */
         vi_enable_doorbell_aperture(adev, true);

+       if (adev->firmware.load_type =3D=3D AMDGPU_FW_LOAD_SMU) {
+               if (adev->powerplay.pp_funcs->load_firmware) {
+                       amdgpu_ucode_init_bo(adev);
+                       if (adev->powerplay.pp_funcs->load_firmware(adev->p=
owerplay.pp_handle)) {
+                               adev->firmware.load_type =3D AMDGPU_FW_LOAD=
_DIRECT;
+                               amdgpu_ucode_fini_bo(adev);
+                       }
+               }
+       }
+
         return 0;
 }

@@ -1235,6 +1245,12 @@ static int vi_common_hw_fini(void *handle)
         if (amdgpu_sriov_vf(adev))
                 xgpu_vi_mailbox_put_irq(adev);

+       if (adev->firmware.load_type =3D=3D AMDGPU_FW_LOAD_SMU) {
+               release_firmware(adev->pm.fw);
+               adev->pm.fw =3D NULL;
+               amdgpu_ucode_fini_bo(adev);
+       }
+
         return 0;
 }

diff --git a/drivers/gpu/drm/amd/powerplay/amd_powerplay.c b/drivers/gpu/dr=
m/amd/powerplay/amd_powerplay.c
index aff7c14..5dc8fb9 100644
--- a/drivers/gpu/drm/amd/powerplay/amd_powerplay.c
+++ b/drivers/gpu/drm/amd/powerplay/amd_powerplay.c
@@ -109,12 +109,6 @@ static int pp_sw_fini(void *handle)

         hwmgr_sw_fini(hwmgr);

-       if (adev->firmware.load_type =3D=3D AMDGPU_FW_LOAD_SMU) {
-               release_firmware(adev->pm.fw);
-               adev->pm.fw =3D NULL;
-               amdgpu_ucode_fini_bo(adev);
-       }
-
         return 0;
 }

@@ -124,9 +118,6 @@ static int pp_hw_init(void *handle)
         struct amdgpu_device *adev =3D handle;
         struct pp_hwmgr *hwmgr =3D adev->powerplay.pp_handle;

-       if (adev->firmware.load_type =3D=3D AMDGPU_FW_LOAD_SMU)
-               amdgpu_ucode_init_bo(adev);
-
         ret =3D hwmgr_hw_init(hwmgr);

         if (ret)
@@ -275,7 +266,16 @@ static int pp_set_clockgating_state(void *handle,

 static int pp_dpm_load_fw(void *handle)
 {
-       return 0;
+       struct pp_hwmgr *hwmgr =3D handle;
+       int ret =3D 0;
+
+       if (!hwmgr || !hwmgr->smumgr_funcs)
+               return -EINVAL;
+
+       if (hwmgr->smumgr_funcs->request_smu_load_fw)
+               ret =3D hwmgr->smumgr_funcs->request_smu_load_fw(hwmgr);
+
+       return ret;
 }

 static int pp_dpm_fw_loading_complete(void *handle)
diff --git a/drivers/gpu/drm/amd/powerplay/smumgr/fiji_smumgr.c b/drivers/g=
pu/drm/amd/powerplay/smumgr/fiji_smumgr.c
index b6b62a7..ffd7d78 100644
--- a/drivers/gpu/drm/amd/powerplay/smumgr/fiji_smumgr.c
+++ b/drivers/gpu/drm/amd/powerplay/smumgr/fiji_smumgr.c
@@ -310,8 +310,6 @@ static int fiji_start_smu(struct pp_hwmgr *hwmgr)
                         offsetof(SMU73_Firmware_Header, SoftRegisters),
                         &(priv->smu7_data.soft_regs_start), 0x40000);

-       result =3D smu7_request_smu_load_fw(hwmgr);
-
         return result;
 }

@@ -2643,7 +2641,7 @@ static int fiji_update_dpm_settings(struct pp_hwmgr *=
hwmgr,
         .smu_fini =3D &smu7_smu_fini,
         .start_smu =3D &fiji_start_smu,
         .check_fw_load_finish =3D &smu7_check_fw_load_finish,
-       .request_smu_load_fw =3D &smu7_reload_firmware,
+       .request_smu_load_fw =3D &smu7_request_smu_load_fw,
         .request_smu_load_specific_fw =3D NULL,
         .send_msg_to_smc =3D &smu7_send_msg_to_smc,
         .send_msg_to_smc_with_parameter =3D &smu7_send_msg_to_smc_with_par=
ameter,
diff --git a/drivers/gpu/drm/amd/powerplay/smumgr/iceland_smumgr.c b/driver=
s/gpu/drm/amd/powerplay/smumgr/iceland_smumgr.c
index 73aa368..68a4836 100644
--- a/drivers/gpu/drm/amd/powerplay/smumgr/iceland_smumgr.c
+++ b/drivers/gpu/drm/amd/powerplay/smumgr/iceland_smumgr.c
@@ -232,27 +232,24 @@ static int iceland_request_smu_load_specific_fw(struc=
t pp_hwmgr *hwmgr,

 static int iceland_start_smu(struct pp_hwmgr *hwmgr)
 {
-       int result;
-
-       result =3D iceland_smu_upload_firmware_image(hwmgr);
-       if (result)
-               return result;
-       result =3D iceland_smu_start_smc(hwmgr);
-       if (result)
-               return result;
+       struct iceland_smumgr *priv =3D hwmgr->smu_backend;
+       int result =3D 0;

         if (!smu7_is_smc_ram_running(hwmgr)) {
-               pr_info("smu not running, upload firmware again \n");
                 result =3D iceland_smu_upload_firmware_image(hwmgr);
                 if (result)
                         return result;

-               result =3D iceland_smu_start_smc(hwmgr);
-               if (result)
-                       return result;
+               iceland_smu_start_smc(hwmgr);
         }
+       /* Setup SoftRegsStart here for register lookup in case
+        * DummyBackEnd is used and ProcessFirmwareHeader is not executed
+        */

-       result =3D smu7_request_smu_load_fw(hwmgr);
+       smu7_read_smc_sram_dword(hwmgr,
+                       SMU71_FIRMWARE_HEADER_LOCATION +
+                       offsetof(SMU71_Firmware_Header, SoftRegisters),
+                       &(priv->smu7_data.soft_regs_start), 0x40000);

         return result;
 }
@@ -2662,7 +2659,7 @@ static bool iceland_is_dpm_running(struct pp_hwmgr *h=
wmgr)
         .smu_fini =3D &smu7_smu_fini,
         .start_smu =3D &iceland_start_smu,
         .check_fw_load_finish =3D &smu7_check_fw_load_finish,
-       .request_smu_load_fw =3D &smu7_reload_firmware,
+       .request_smu_load_fw =3D &smu7_request_smu_load_fw,
         .request_smu_load_specific_fw =3D &iceland_request_smu_load_specif=
ic_fw,
         .send_msg_to_smc =3D &smu7_send_msg_to_smc,
         .send_msg_to_smc_with_parameter =3D &smu7_send_msg_to_smc_with_par=
ameter,
diff --git a/drivers/gpu/drm/amd/powerplay/smumgr/polaris10_smumgr.c b/driv=
ers/gpu/drm/amd/powerplay/smumgr/polaris10_smumgr.c
index 872d382..2ad6ad9 100644
--- a/drivers/gpu/drm/amd/powerplay/smumgr/polaris10_smumgr.c
+++ b/drivers/gpu/drm/amd/powerplay/smumgr/polaris10_smumgr.c
@@ -313,8 +313,6 @@ static int polaris10_start_smu(struct pp_hwmgr *hwmgr)
         smu7_read_smc_sram_dword(hwmgr, SMU7_FIRMWARE_HEADER_LOCATION + of=
fsetof(SMU74_Firmware_Header, SoftRegisters),
                                         &(smu_data->smu7_data.soft_regs_st=
art), 0x40000);

-       result =3D smu7_request_smu_load_fw(hwmgr);
-
         return result;
 }

@@ -2478,7 +2476,7 @@ static int polaris10_update_dpm_settings(struct pp_hw=
mgr *hwmgr,
         .smu_fini =3D smu7_smu_fini,
         .start_smu =3D polaris10_start_smu,
         .check_fw_load_finish =3D smu7_check_fw_load_finish,
-       .request_smu_load_fw =3D smu7_reload_firmware,
+       .request_smu_load_fw =3D smu7_request_smu_load_fw,
         .request_smu_load_specific_fw =3D NULL,
         .send_msg_to_smc =3D smu7_send_msg_to_smc,
         .send_msg_to_smc_with_parameter =3D smu7_send_msg_to_smc_with_para=
meter,
diff --git a/drivers/gpu/drm/amd/powerplay/smumgr/smu7_smumgr.c b/drivers/g=
pu/drm/amd/powerplay/smumgr/smu7_smumgr.c
index 10eb967..edfb061 100644
--- a/drivers/gpu/drm/amd/powerplay/smumgr/smu7_smumgr.c
+++ b/drivers/gpu/drm/amd/powerplay/smumgr/smu7_smumgr.c
@@ -302,44 +302,6 @@ int smu7_write_smc_sram_dword(struct pp_hwmgr *hwmgr, =
uint32_t smc_addr, uint32_
         return 0;
 }

-/* Convert the firmware type to SMU type mask. For MEC, we need to check a=
ll MEC related type */
-
-static uint32_t smu7_get_mask_for_firmware_type(uint32_t fw_type)
-{
-       uint32_t result =3D 0;
-
-       switch (fw_type) {
-       case UCODE_ID_SDMA0:
-               result =3D UCODE_ID_SDMA0_MASK;
-               break;
-       case UCODE_ID_SDMA1:
-               result =3D UCODE_ID_SDMA1_MASK;
-               break;
-       case UCODE_ID_CP_CE:
-               result =3D UCODE_ID_CP_CE_MASK;
-               break;
-       case UCODE_ID_CP_PFP:
-               result =3D UCODE_ID_CP_PFP_MASK;
-               break;
-       case UCODE_ID_CP_ME:
-               result =3D UCODE_ID_CP_ME_MASK;
-               break;
-       case UCODE_ID_CP_MEC:
-       case UCODE_ID_CP_MEC_JT1:
-       case UCODE_ID_CP_MEC_JT2:
-               result =3D UCODE_ID_CP_MEC_MASK;
-               break;
-       case UCODE_ID_RLC_G:
-               result =3D UCODE_ID_RLC_G_MASK;
-               break;
-       default:
-               pr_info("UCode type is out of range! \n");
-               result =3D 0;
-       }
-
-       return result;
-}
-
 static int smu7_populate_single_firmware_entry(struct pp_hwmgr *hwmgr,
                                                 uint32_t fw_type,
                                                 struct SMU_Entry *entry)
@@ -381,6 +343,11 @@ int smu7_request_smu_load_fw(struct pp_hwmgr *hwmgr)
         uint32_t fw_to_load;
         int r =3D 0;

+       if (hwmgr->smumgr_funcs->start_smu(hwmgr)) {
+               pr_err("smu not running \n");
+               return -EINVAL;
+       }
+
         if (smu_data->soft_regs_start)
                 cgs_write_ind_register(hwmgr->device, CGS_IND_REG__SMC,
                                         smu_data->soft_regs_start + smum_g=
et_offsetof(hwmgr,
@@ -462,10 +429,13 @@ int smu7_request_smu_load_fw(struct pp_hwmgr *hwmgr)
         smu7_send_msg_to_smc_with_parameter(hwmgr, PPSMC_MSG_DRV_DRAM_ADDR=
_HI, upper_32_bits(smu_data->header_buffer.mc_addr));
         smu7_send_msg_to_smc_with_parameter(hwmgr, PPSMC_MSG_DRV_DRAM_ADDR=
_LO, lower_32_bits(smu_data->header_buffer.mc_addr));

-       if (smu7_send_msg_to_smc_with_parameter(hwmgr, PPSMC_MSG_LoadUcodes=
, fw_to_load))
-               pr_err("Fail to Request SMU Load uCode");
+       smu7_send_msg_to_smc_with_parameter(hwmgr, PPSMC_MSG_LoadUcodes, fw=
_to_load);

-       return r;
+       r =3D smu7_check_fw_load_finish(hwmgr, fw_to_load);
+       if (!r)
+               return 0;
+
+       pr_err("SMU load firmware failed\n");

 failed:
         kfree(smu_data->toc);
@@ -477,20 +447,15 @@ int smu7_request_smu_load_fw(struct pp_hwmgr *hwmgr)
 int smu7_check_fw_load_finish(struct pp_hwmgr *hwmgr, uint32_t fw_type)
 {
         struct smu7_smumgr *smu_data =3D (struct smu7_smumgr *)(hwmgr->smu=
_backend);
-       uint32_t fw_mask =3D smu7_get_mask_for_firmware_type(fw_type);
         uint32_t ret;

         ret =3D phm_wait_on_indirect_register(hwmgr, mmSMC_IND_INDEX_11,
                                         smu_data->soft_regs_start + smum_g=
et_offsetof(hwmgr,
                                         SMU_SoftRegisters, UcodeLoadStatus=
),
-                                       fw_mask, fw_mask);
+                                       fw_type, fw_type);
         return ret;
 }

-int smu7_reload_firmware(struct pp_hwmgr *hwmgr)
-{
-       return hwmgr->smumgr_funcs->start_smu(hwmgr);
-}

 static int smu7_upload_smc_firmware_data(struct pp_hwmgr *hwmgr, uint32_t =
length, uint32_t *src, uint32_t limit)
 {
diff --git a/drivers/gpu/drm/amd/powerplay/smumgr/smu7_smumgr.h b/drivers/g=
pu/drm/amd/powerplay/smumgr/smu7_smumgr.h
index 01f0538f..10c8ceb 100644
--- a/drivers/gpu/drm/amd/powerplay/smumgr/smu7_smumgr.h
+++ b/drivers/gpu/drm/amd/powerplay/smumgr/smu7_smumgr.h
@@ -73,9 +73,8 @@ int smu7_read_smc_sram_dword(struct pp_hwmgr *hwmgr, uint=
32_t smc_addr,
 int smu7_write_smc_sram_dword(struct pp_hwmgr *hwmgr, uint32_t smc_addr,
                                                 uint32_t value, uint32_t l=
imit);

-int smu7_request_smu_load_fw(struct pp_hwmgr *hwmgr);
 int smu7_check_fw_load_finish(struct pp_hwmgr *hwmgr, uint32_t fw_type);
-int smu7_reload_firmware(struct pp_hwmgr *hwmgr);
+int smu7_request_smu_load_fw(struct pp_hwmgr *hwmgr);
 int smu7_upload_smu_firmware_image(struct pp_hwmgr *hwmgr);
 int smu7_init(struct pp_hwmgr *hwmgr);
 int smu7_smu_fini(struct pp_hwmgr *hwmgr);
diff --git a/drivers/gpu/drm/amd/powerplay/smumgr/smu8_smumgr.c b/drivers/g=
pu/drm/amd/powerplay/smumgr/smu8_smumgr.c
index 7a4c425..90f5f30 100644
--- a/drivers/gpu/drm/amd/powerplay/smumgr/smu8_smumgr.c
+++ b/drivers/gpu/drm/amd/powerplay/smumgr/smu8_smumgr.c
@@ -658,6 +658,8 @@ static int smu8_request_smu_load_fw(struct pp_hwmgr *hw=
mgr)
 {
         struct smu8_smumgr *smu8_smu =3D hwmgr->smu_backend;
         uint32_t smc_address;
+       uint32_t fw_to_check =3D 0;
+       int ret;

         smu8_smu_populate_firmware_entries(hwmgr);

@@ -684,28 +686,9 @@ static int smu8_request_smu_load_fw(struct pp_hwmgr *h=
wmgr)
         smu8_send_msg_to_smc_with_parameter(hwmgr, PPSMC_MSG_ExecuteJob,
                                 smu8_smu->toc_entry_power_profiling_index)=
;

-       return smu8_send_msg_to_smc_with_parameter(hwmgr,
+       smu8_send_msg_to_smc_with_parameter(hwmgr,
                                         PPSMC_MSG_ExecuteJob,
                                         smu8_smu->toc_entry_initialize_ind=
ex);
-}
-
-static int smu8_start_smu(struct pp_hwmgr *hwmgr)
-{
-       int ret =3D 0;
-       uint32_t fw_to_check =3D 0;
-       struct amdgpu_device *adev =3D hwmgr->adev;
-
-       uint32_t index =3D SMN_MP1_SRAM_START_ADDR +
-                        SMU8_FIRMWARE_HEADER_LOCATION +
-                        offsetof(struct SMU8_Firmware_Header, Version);
-
-
-       if (hwmgr =3D=3D NULL || hwmgr->device =3D=3D NULL)
-               return -EINVAL;
-
-       cgs_write_register(hwmgr->device, mmMP0PUB_IND_INDEX, index);
-       hwmgr->smu_version =3D cgs_read_register(hwmgr->device, mmMP0PUB_IN=
D_DATA);
-       adev->pm.fw_version =3D hwmgr->smu_version >> 8;

         fw_to_check =3D UCODE_ID_RLC_G_MASK |
                         UCODE_ID_SDMA0_MASK |
@@ -719,8 +702,6 @@ static int smu8_start_smu(struct pp_hwmgr *hwmgr)
         if (hwmgr->chip_id =3D=3D CHIP_STONEY)
                 fw_to_check &=3D ~(UCODE_ID_SDMA1_MASK | UCODE_ID_CP_MEC_J=
T2_MASK);

-       smu8_request_smu_load_fw(hwmgr);
-
         ret =3D smu8_check_fw_load_finish(hwmgr, fw_to_check);
         if (ret) {
                 pr_err("SMU firmware load failed\n");
@@ -734,6 +715,25 @@ static int smu8_start_smu(struct pp_hwmgr *hwmgr)
         return ret;
 }

+static int smu8_start_smu(struct pp_hwmgr *hwmgr)
+{
+       struct amdgpu_device *adev =3D hwmgr->adev;
+
+       uint32_t index =3D SMN_MP1_SRAM_START_ADDR +
+                        SMU8_FIRMWARE_HEADER_LOCATION +
+                        offsetof(struct SMU8_Firmware_Header, Version);
+
+
+       if (hwmgr =3D=3D NULL || hwmgr->device =3D=3D NULL)
+               return -EINVAL;
+
+       cgs_write_register(hwmgr->device, mmMP0PUB_IND_INDEX, index);
+       hwmgr->smu_version =3D cgs_read_register(hwmgr->device, mmMP0PUB_IN=
D_DATA);
+       adev->pm.fw_version =3D hwmgr->smu_version >> 8;
+
+       return 0;
+}
+
 static int smu8_smu_init(struct pp_hwmgr *hwmgr)
 {
         int ret =3D 0;
@@ -876,7 +876,7 @@ static bool smu8_is_dpm_running(struct pp_hwmgr *hwmgr)
         .smu_fini =3D smu8_smu_fini,
         .start_smu =3D smu8_start_smu,
         .check_fw_load_finish =3D smu8_check_fw_load_finish,
-       .request_smu_load_fw =3D NULL,
+       .request_smu_load_fw =3D smu8_request_smu_load_fw,
         .request_smu_load_specific_fw =3D NULL,
         .get_argument =3D smu8_get_argument,
         .send_msg_to_smc =3D smu8_send_msg_to_smc,
diff --git a/drivers/gpu/drm/amd/powerplay/smumgr/tonga_smumgr.c b/drivers/=
gpu/drm/amd/powerplay/smumgr/tonga_smumgr.c
index ae8378e..d8f1ca2 100644
--- a/drivers/gpu/drm/amd/powerplay/smumgr/tonga_smumgr.c
+++ b/drivers/gpu/drm/amd/powerplay/smumgr/tonga_smumgr.c
@@ -192,7 +192,8 @@ static int tonga_start_in_non_protection_mode(struct pp=
_hwmgr *hwmgr)

 static int tonga_start_smu(struct pp_hwmgr *hwmgr)
 {
-       int result;
+       struct tonga_smumgr *priv =3D hwmgr->smu_backend;
+       int result =3D 0;

         /* Only start SMC if SMC RAM is not running */
         if (!smu7_is_smc_ram_running(hwmgr) && hwmgr->not_vf) {
@@ -209,7 +210,14 @@ static int tonga_start_smu(struct pp_hwmgr *hwmgr)
                 }
         }

-       result =3D smu7_request_smu_load_fw(hwmgr);
+       /* Setup SoftRegsStart here for register lookup in case
+        * DummyBackEnd is used and ProcessFirmwareHeader is not executed
+        */
+
+       smu7_read_smc_sram_dword(hwmgr,
+                       SMU72_FIRMWARE_HEADER_LOCATION +
+                       offsetof(SMU72_Firmware_Header, SoftRegisters),
+                       &(priv->smu7_data.soft_regs_start), 0x40000);

         return result;
 }
diff --git a/drivers/gpu/drm/amd/powerplay/smumgr/vegam_smumgr.c b/drivers/=
gpu/drm/amd/powerplay/smumgr/vegam_smumgr.c
index 3d415fa..71e376f 100644
--- a/drivers/gpu/drm/amd/powerplay/smumgr/vegam_smumgr.c
+++ b/drivers/gpu/drm/amd/powerplay/smumgr/vegam_smumgr.c
@@ -218,8 +218,6 @@ static int vegam_start_smu(struct pp_hwmgr *hwmgr)
                         &(smu_data->smu7_data.soft_regs_start),
                         0x40000);

-       result =3D smu7_request_smu_load_fw(hwmgr);
-
         return result;
 }

@@ -2280,7 +2278,7 @@ static int vegam_thermal_setup_fan_table(struct pp_hw=
mgr *hwmgr)
         .smu_fini =3D smu7_smu_fini,
         .start_smu =3D vegam_start_smu,
         .check_fw_load_finish =3D smu7_check_fw_load_finish,
-       .request_smu_load_fw =3D smu7_reload_firmware,
+       .request_smu_load_fw =3D smu7_request_smu_load_fw,
         .request_smu_load_specific_fw =3D NULL,
         .send_msg_to_smc =3D smu7_send_msg_to_smc,
         .send_msg_to_smc_with_parameter =3D smu7_send_msg_to_smc_with_para=
meter,
--
1.9.1

_______________________________________________
amd-gfx mailing list
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
amd-gfx Info Page - freedesktop.org<https://lists.freedesktop.org/mailman/l=
istinfo/amd-gfx>
lists.freedesktop.org
To see the collection of prior postings to the list, visit the amd-gfx Arch=
ives.. Using amd-gfx: To post a message to all the list members, send email=
 to amd-gfx-PD4FTy7X32lNgt0PjOBp9xlNPtJONSTn@public.gmane.org You can subscribe to the list, or change=
 your existing subscription, in the sections below.



--_000_BYAPR12MB2775243258483D0EC9EA2E65FB140BYAPR12MB2775namp_
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
<p style=3D"margin-top:0;margin-bottom:0">Sorry, Please ignore this patch.<=
/p>
<p style=3D"margin-top:0;margin-bottom:0"><br>
</p>
<p style=3D"margin-top:0;margin-bottom:0"><br>
</p>
<br>
<p style=3D"margin-top:0;margin-bottom:0">Best Regards</p>
<p style=3D"margin-top:0;margin-bottom:0">Rex<br>
</p>
<br>
<div style=3D"color: rgb(0, 0, 0);">
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font style=3D"font-size:11pt" color=
=3D"#000000" face=3D"Calibri, sans-serif"><b>From:</b> amd-gfx &lt;amd-gfx-=
bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org&gt; on behalf of Rex Zhu &lt;Rex.Zhu-5C7GfCeVMHo@public.gmane.org&=
gt;<br>
<b>Sent:</b> Thursday, September 27, 2018 9:55 PM<br>
<b>To:</b> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
<b>Cc:</b> Zhu, Rex<br>
<b>Subject:</b> [PATCH v2] drm/amd/pp: Export load_firmware interface</font=
>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">Export this interface for the AMDGPU_FW_LOAD_SMU t=
ype.<br>
gfx/sdma can request smu to load firmware.<br>
<br>
Split the smu7/8_start_smu function into two functions<br>
1. start_smu, used for load smu firmware in smu7/8 and<br>
&nbsp;&nbsp; check smu firmware version.<br>
2. request_smu_load_fw, used for load other ip's firmware<br>
&nbsp;&nbsp; on smu7/8 and add firmware loading staus check.<br>
<br>
v2: default fw loading type is via smu for VI, driver call smu<br>
&nbsp;&nbsp;&nbsp; to load all fw at the begin of hw init.<br>
<br>
Signed-off-by: Rex Zhu &lt;Rex.Zhu-5C7GfCeVMHo@public.gmane.org&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/vi.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; | 16 &#43;&#43;&#43;&#43;&#43;&#43;<br>
&nbsp;drivers/gpu/drm/amd/powerplay/amd_powerplay.c&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; | 20 &#43;&#43;&#43;&#43;----<br>
&nbsp;drivers/gpu/drm/amd/powerplay/smumgr/fiji_smumgr.c |&nbsp; 4 &#43;-<b=
r>
&nbsp;.../gpu/drm/amd/powerplay/smumgr/iceland_smumgr.c&nbsp; | 25 &#43;&#4=
3;&#43;&#43;-----<br>
&nbsp;.../drm/amd/powerplay/smumgr/polaris10_smumgr.c&nbsp;&nbsp;&nbsp; |&n=
bsp; 4 &#43;-<br>
&nbsp;drivers/gpu/drm/amd/powerplay/smumgr/smu7_smumgr.c | 59 &#43;&#43;&#4=
3;&#43;&#43;-----------------<br>
&nbsp;drivers/gpu/drm/amd/powerplay/smumgr/smu7_smumgr.h |&nbsp; 3 &#43;-<b=
r>
&nbsp;drivers/gpu/drm/amd/powerplay/smumgr/smu8_smumgr.c | 46 &#43;&#43;&#4=
3;&#43;&#43;&#43;&#43;&#43;---------<br>
&nbsp;.../gpu/drm/amd/powerplay/smumgr/tonga_smumgr.c&nbsp;&nbsp;&nbsp; | 1=
2 &#43;&#43;&#43;&#43;-<br>
&nbsp;.../gpu/drm/amd/powerplay/smumgr/vegam_smumgr.c&nbsp;&nbsp;&nbsp; |&n=
bsp; 4 &#43;-<br>
&nbsp;10 files changed, 86 insertions(&#43;), 107 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/vi.c b/drivers/gpu/drm/amd/amdgpu/v=
i.c<br>
index 88b57a5..3384a15 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/vi.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/vi.c<br>
@@ -1222,6 &#43;1222,16 @@ static int vi_common_hw_init(void *handle)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* enable the doorbell ape=
rture */<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; vi_enable_doorbell_apertur=
e(adev, true);<br>
&nbsp;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;firmware.load_type =
=3D=3D AMDGPU_FW_LOAD_SMU) {<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; if (adev-&gt;powerplay.pp_funcs-&gt;load_firmware) {<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_ucode=
_init_bo(adev);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt=
;powerplay.pp_funcs-&gt;load_firmware(adev-&gt;powerplay.pp_handle)) {<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;firmware.load_type =3D AMDGPU_=
FW_LOAD_DIRECT;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_ucode_fini_bo(adev);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; }<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&#43;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&nbsp;}<br>
&nbsp;<br>
@@ -1235,6 &#43;1245,12 @@ static int vi_common_hw_fini(void *handle)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_sriov_vf(adev))=
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; xgpu_vi_mailbox_put_irq(adev);<br>
&nbsp;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;firmware.load_type =
=3D=3D AMDGPU_FW_LOAD_SMU) {<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; release_firmware(adev-&gt;pm.fw);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; adev-&gt;pm.fw =3D NULL;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; amdgpu_ucode_fini_bo(adev);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&#43;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&nbsp;}<br>
&nbsp;<br>
diff --git a/drivers/gpu/drm/amd/powerplay/amd_powerplay.c b/drivers/gpu/dr=
m/amd/powerplay/amd_powerplay.c<br>
index aff7c14..5dc8fb9 100644<br>
--- a/drivers/gpu/drm/amd/powerplay/amd_powerplay.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/powerplay/amd_powerplay.c<br>
@@ -109,12 &#43;109,6 @@ static int pp_sw_fini(void *handle)<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; hwmgr_sw_fini(hwmgr);<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;firmware.load_type =3D=
=3D AMDGPU_FW_LOAD_SMU) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; release_firmware(adev-&gt;pm.fw);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; adev-&gt;pm.fw =3D NULL;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; amdgpu_ucode_fini_bo(adev);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
-<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&nbsp;}<br>
&nbsp;<br>
@@ -124,9 &#43;118,6 @@ static int pp_hw_init(void *handle)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev=
 =3D handle;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct pp_hwmgr *hwmgr =3D=
 adev-&gt;powerplay.pp_handle;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;firmware.load_type =3D=
=3D AMDGPU_FW_LOAD_SMU)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; amdgpu_ucode_init_bo(adev);<br>
-<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D hwmgr_hw_init(hwmg=
r);<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret)<br>
@@ -275,7 &#43;266,16 @@ static int pp_set_clockgating_state(void *handle,<=
br>
&nbsp;<br>
&nbsp;static int pp_dpm_load_fw(void *handle)<br>
&nbsp;{<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct pp_hwmgr *hwmgr =3D handle=
;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ret =3D 0;<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!hwmgr || !hwmgr-&gt;smumgr_f=
uncs)<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; return -EINVAL;<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (hwmgr-&gt;smumgr_funcs-&gt;re=
quest_smu_load_fw)<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; ret =3D hwmgr-&gt;smumgr_funcs-&gt;request_smu_load_fw(hwmgr=
);<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret;<br>
&nbsp;}<br>
&nbsp;<br>
&nbsp;static int pp_dpm_fw_loading_complete(void *handle)<br>
diff --git a/drivers/gpu/drm/amd/powerplay/smumgr/fiji_smumgr.c b/drivers/g=
pu/drm/amd/powerplay/smumgr/fiji_smumgr.c<br>
index b6b62a7..ffd7d78 100644<br>
--- a/drivers/gpu/drm/amd/powerplay/smumgr/fiji_smumgr.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/powerplay/smumgr/fiji_smumgr.c<br>
@@ -310,8 &#43;310,6 @@ static int fiji_start_smu(struct pp_hwmgr *hwmgr)<b=
r>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; offse=
tof(SMU73_Firmware_Header, SoftRegisters),<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp;=
(priv-&gt;smu7_data.soft_regs_start), 0x40000);<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; result =3D smu7_request_smu_load_fw(h=
wmgr);<br>
-<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return result;<br>
&nbsp;}<br>
&nbsp;<br>
@@ -2643,7 &#43;2641,7 @@ static int fiji_update_dpm_settings(struct pp_hwm=
gr *hwmgr,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .smu_fini =3D &amp;smu7_sm=
u_fini,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .start_smu =3D &amp;fiji_s=
tart_smu,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .check_fw_load_finish =3D =
&amp;smu7_check_fw_load_finish,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .request_smu_load_fw =3D &amp;smu7_re=
load_firmware,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .request_smu_load_fw =3D &amp;smu=
7_request_smu_load_fw,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .request_smu_load_specific=
_fw =3D NULL,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .send_msg_to_smc =3D &amp;=
smu7_send_msg_to_smc,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .send_msg_to_smc_with_para=
meter =3D &amp;smu7_send_msg_to_smc_with_parameter,<br>
diff --git a/drivers/gpu/drm/amd/powerplay/smumgr/iceland_smumgr.c b/driver=
s/gpu/drm/amd/powerplay/smumgr/iceland_smumgr.c<br>
index 73aa368..68a4836 100644<br>
--- a/drivers/gpu/drm/amd/powerplay/smumgr/iceland_smumgr.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/powerplay/smumgr/iceland_smumgr.c<br>
@@ -232,27 &#43;232,24 @@ static int iceland_request_smu_load_specific_fw(s=
truct pp_hwmgr *hwmgr,<br>
&nbsp;<br>
&nbsp;static int iceland_start_smu(struct pp_hwmgr *hwmgr)<br>
&nbsp;{<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int result;<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; result =3D iceland_smu_upload_firmwar=
e_image(hwmgr);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (result)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return result;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; result =3D iceland_smu_start_smc(hwmg=
r);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (result)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return result;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct iceland_smumgr *priv =3D h=
wmgr-&gt;smu_backend;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int result =3D 0;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!smu7_is_smc_ram_runni=
ng(hwmgr)) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; pr_info(&quot;smu not running, upload firmware again \n&quot;);<=
br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; result =3D iceland_smu_upload_firmware_image(hwmgr);<=
br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; if (result)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; retur=
n result;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; result =3D iceland_smu_start_smc(hwmgr);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (result)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return result;<b=
r>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; iceland_smu_start_smc(hwmgr);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Setup SoftRegsStart here for r=
egister lookup in case<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * DummyBackEnd is used and =
ProcessFirmwareHeader is not executed<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; result =3D smu7_request_smu_load_fw(h=
wmgr);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smu7_read_smc_sram_dword(hwmgr,<b=
r>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SMU71_FIRMWA=
RE_HEADER_LOCATION &#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; offsetof(SMU=
71_Firmware_Header, SoftRegisters),<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp;(priv-&=
gt;smu7_data.soft_regs_start), 0x40000);<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return result;<br>
&nbsp;}<br>
@@ -2662,7 &#43;2659,7 @@ static bool iceland_is_dpm_running(struct pp_hwmg=
r *hwmgr)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .smu_fini =3D &amp;smu7_sm=
u_fini,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .start_smu =3D &amp;icelan=
d_start_smu,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .check_fw_load_finish =3D =
&amp;smu7_check_fw_load_finish,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .request_smu_load_fw =3D &amp;smu7_re=
load_firmware,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .request_smu_load_fw =3D &amp;smu=
7_request_smu_load_fw,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .request_smu_load_specific=
_fw =3D &amp;iceland_request_smu_load_specific_fw,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .send_msg_to_smc =3D &amp;=
smu7_send_msg_to_smc,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .send_msg_to_smc_with_para=
meter =3D &amp;smu7_send_msg_to_smc_with_parameter,<br>
diff --git a/drivers/gpu/drm/amd/powerplay/smumgr/polaris10_smumgr.c b/driv=
ers/gpu/drm/amd/powerplay/smumgr/polaris10_smumgr.c<br>
index 872d382..2ad6ad9 100644<br>
--- a/drivers/gpu/drm/amd/powerplay/smumgr/polaris10_smumgr.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/powerplay/smumgr/polaris10_smumgr.c<b=
r>
@@ -313,8 &#43;313,6 @@ static int polaris10_start_smu(struct pp_hwmgr *hwm=
gr)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smu7_read_smc_sram_dword(h=
wmgr, SMU7_FIRMWARE_HEADER_LOCATION &#43; offsetof(SMU74_Firmware_Header, S=
oftRegisters),<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; &amp;(smu_data-&gt;smu7_data.soft_regs_start), 0x40000);<br=
>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; result =3D smu7_request_smu_load_fw(h=
wmgr);<br>
-<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return result;<br>
&nbsp;}<br>
&nbsp;<br>
@@ -2478,7 &#43;2476,7 @@ static int polaris10_update_dpm_settings(struct p=
p_hwmgr *hwmgr,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .smu_fini =3D smu7_smu_fin=
i,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .start_smu =3D polaris10_s=
tart_smu,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .check_fw_load_finish =3D =
smu7_check_fw_load_finish,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .request_smu_load_fw =3D smu7_reload_=
firmware,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .request_smu_load_fw =3D smu7_req=
uest_smu_load_fw,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .request_smu_load_specific=
_fw =3D NULL,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .send_msg_to_smc =3D smu7_=
send_msg_to_smc,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .send_msg_to_smc_with_para=
meter =3D smu7_send_msg_to_smc_with_parameter,<br>
diff --git a/drivers/gpu/drm/amd/powerplay/smumgr/smu7_smumgr.c b/drivers/g=
pu/drm/amd/powerplay/smumgr/smu7_smumgr.c<br>
index 10eb967..edfb061 100644<br>
--- a/drivers/gpu/drm/amd/powerplay/smumgr/smu7_smumgr.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/powerplay/smumgr/smu7_smumgr.c<br>
@@ -302,44 &#43;302,6 @@ int smu7_write_smc_sram_dword(struct pp_hwmgr *hwm=
gr, uint32_t smc_addr, uint32_<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&nbsp;}<br>
&nbsp;<br>
-/* Convert the firmware type to SMU type mask. For MEC, we need to check a=
ll MEC related type */<br>
-<br>
-static uint32_t smu7_get_mask_for_firmware_type(uint32_t fw_type)<br>
-{<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t result =3D 0;<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (fw_type) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case UCODE_ID_SDMA0:<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; result =3D UCODE_ID_SDMA0_MASK;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; break;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case UCODE_ID_SDMA1:<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; result =3D UCODE_ID_SDMA1_MASK;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; break;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case UCODE_ID_CP_CE:<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; result =3D UCODE_ID_CP_CE_MASK;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; break;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case UCODE_ID_CP_PFP:<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; result =3D UCODE_ID_CP_PFP_MASK;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; break;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case UCODE_ID_CP_ME:<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; result =3D UCODE_ID_CP_ME_MASK;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; break;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case UCODE_ID_CP_MEC:<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case UCODE_ID_CP_MEC_JT1:<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case UCODE_ID_CP_MEC_JT2:<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; result =3D UCODE_ID_CP_MEC_MASK;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; break;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case UCODE_ID_RLC_G:<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; result =3D UCODE_ID_RLC_G_MASK;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; break;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; default:<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; pr_info(&quot;UCode type is out of range! \n&quot;);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; result =3D 0;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return result;<br>
-}<br>
-<br>
&nbsp;static int smu7_populate_single_firmware_entry(struct pp_hwmgr *hwmgr=
,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t fw=
_type,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct SMU_=
Entry *entry)<br>
@@ -381,6 &#43;343,11 @@ int smu7_request_smu_load_fw(struct pp_hwmgr *hwmg=
r)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t fw_to_load;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int r =3D 0;<br>
&nbsp;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (hwmgr-&gt;smumgr_funcs-&gt;st=
art_smu(hwmgr)) {<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; pr_err(&quot;smu not running \n&quot;);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; return -EINVAL;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&#43;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (smu_data-&gt;soft_regs=
_start)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; cgs_write_ind_register(hwmgr-&gt;device, CGS_IND_REG_=
_SMC,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; smu_data-&gt;soft_regs_start &#43; smum_get_offsetof(hwmgr,=
<br>
@@ -462,10 &#43;429,13 @@ int smu7_request_smu_load_fw(struct pp_hwmgr *hwm=
gr)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smu7_send_msg_to_smc_with_=
parameter(hwmgr, PPSMC_MSG_DRV_DRAM_ADDR_HI, upper_32_bits(smu_data-&gt;hea=
der_buffer.mc_addr));<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smu7_send_msg_to_smc_with_=
parameter(hwmgr, PPSMC_MSG_DRV_DRAM_ADDR_LO, lower_32_bits(smu_data-&gt;hea=
der_buffer.mc_addr));<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (smu7_send_msg_to_smc_with_paramet=
er(hwmgr, PPSMC_MSG_LoadUcodes, fw_to_load))<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; pr_err(&quot;Fail to Request SMU Load uCode&quot;);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smu7_send_msg_to_smc_with_paramet=
er(hwmgr, PPSMC_MSG_LoadUcodes, fw_to_load);<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return r;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r =3D smu7_check_fw_load_finish(h=
wmgr, fw_to_load);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!r)<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; return 0;<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pr_err(&quot;SMU load firmware fa=
iled\n&quot;);<br>
&nbsp;<br>
&nbsp;failed:<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kfree(smu_data-&gt;toc);<b=
r>
@@ -477,20 &#43;447,15 @@ int smu7_request_smu_load_fw(struct pp_hwmgr *hwm=
gr)<br>
&nbsp;int smu7_check_fw_load_finish(struct pp_hwmgr *hwmgr, uint32_t fw_typ=
e)<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct smu7_smumgr *smu_da=
ta =3D (struct smu7_smumgr *)(hwmgr-&gt;smu_backend);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t fw_mask =3D smu7_get_mask_fo=
r_firmware_type(fw_type);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t ret;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D phm_wait_on_indire=
ct_register(hwmgr, mmSMC_IND_INDEX_11,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; smu_data-&gt;soft_regs_start &#43; smum_get_offsetof(hwmgr,=
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; SMU_SoftRegisters, UcodeLoadStatus),<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; fw_mask, fw_mask);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp; fw_type, fw_type);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret;<br>
&nbsp;}<br>
&nbsp;<br>
-int smu7_reload_firmware(struct pp_hwmgr *hwmgr)<br>
-{<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return hwmgr-&gt;smumgr_funcs-&gt;sta=
rt_smu(hwmgr);<br>
-}<br>
&nbsp;<br>
&nbsp;static int smu7_upload_smc_firmware_data(struct pp_hwmgr *hwmgr, uint=
32_t length, uint32_t *src, uint32_t limit)<br>
&nbsp;{<br>
diff --git a/drivers/gpu/drm/amd/powerplay/smumgr/smu7_smumgr.h b/drivers/g=
pu/drm/amd/powerplay/smumgr/smu7_smumgr.h<br>
index 01f0538f..10c8ceb 100644<br>
--- a/drivers/gpu/drm/amd/powerplay/smumgr/smu7_smumgr.h<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/powerplay/smumgr/smu7_smumgr.h<br>
@@ -73,9 &#43;73,8 @@ int smu7_read_smc_sram_dword(struct pp_hwmgr *hwmgr, =
uint32_t smc_addr,<br>
&nbsp;int smu7_write_smc_sram_dword(struct pp_hwmgr *hwmgr, uint32_t smc_ad=
dr,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t va=
lue, uint32_t limit);<br>
&nbsp;<br>
-int smu7_request_smu_load_fw(struct pp_hwmgr *hwmgr);<br>
&nbsp;int smu7_check_fw_load_finish(struct pp_hwmgr *hwmgr, uint32_t fw_typ=
e);<br>
-int smu7_reload_firmware(struct pp_hwmgr *hwmgr);<br>
&#43;int smu7_request_smu_load_fw(struct pp_hwmgr *hwmgr);<br>
&nbsp;int smu7_upload_smu_firmware_image(struct pp_hwmgr *hwmgr);<br>
&nbsp;int smu7_init(struct pp_hwmgr *hwmgr);<br>
&nbsp;int smu7_smu_fini(struct pp_hwmgr *hwmgr);<br>
diff --git a/drivers/gpu/drm/amd/powerplay/smumgr/smu8_smumgr.c b/drivers/g=
pu/drm/amd/powerplay/smumgr/smu8_smumgr.c<br>
index 7a4c425..90f5f30 100644<br>
--- a/drivers/gpu/drm/amd/powerplay/smumgr/smu8_smumgr.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/powerplay/smumgr/smu8_smumgr.c<br>
@@ -658,6 &#43;658,8 @@ static int smu8_request_smu_load_fw(struct pp_hwmgr=
 *hwmgr)<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct smu8_smumgr *smu8_s=
mu =3D hwmgr-&gt;smu_backend;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t smc_address;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t fw_to_check =3D 0;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ret;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smu8_smu_populate_firmware=
_entries(hwmgr);<br>
&nbsp;<br>
@@ -684,28 &#43;686,9 @@ static int smu8_request_smu_load_fw(struct pp_hwmg=
r *hwmgr)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smu8_send_msg_to_smc_with_=
parameter(hwmgr, PPSMC_MSG_ExecuteJob,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smu8_smu-&gt;toc_entry_power_pro=
filing_index);<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return smu8_send_msg_to_smc_with_para=
meter(hwmgr,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smu8_send_msg_to_smc_with_paramet=
er(hwmgr,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; PPSMC_MSG_ExecuteJob,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; smu8_smu-&gt;toc_entry_initialize_index);<br>
-}<br>
-<br>
-static int smu8_start_smu(struct pp_hwmgr *hwmgr)<br>
-{<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ret =3D 0;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t fw_to_check =3D 0;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev =3D hwmgr-=
&gt;adev;<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t index =3D SMN_MP1_SRAM_START=
_ADDR &#43;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SMU8_FIRMW=
ARE_HEADER_LOCATION &#43;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; offsetof(s=
truct SMU8_Firmware_Header, Version);<br>
-<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (hwmgr =3D=3D NULL || hwmgr-&gt;de=
vice =3D=3D NULL)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return -EINVAL;<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; cgs_write_register(hwmgr-&gt;device, =
mmMP0PUB_IND_INDEX, index);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; hwmgr-&gt;smu_version =3D cgs_read_re=
gister(hwmgr-&gt;device, mmMP0PUB_IND_DATA);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;pm.fw_version =3D hwmgr-&gt;=
smu_version &gt;&gt; 8;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; fw_to_check =3D UCODE_ID_R=
LC_G_MASK |<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; UCODE=
_ID_SDMA0_MASK |<br>
@@ -719,8 &#43;702,6 @@ static int smu8_start_smu(struct pp_hwmgr *hwmgr)<b=
r>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (hwmgr-&gt;chip_id =3D=
=3D CHIP_STONEY)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; fw_to_check &amp;=3D ~(UCODE_ID_SDMA1_MASK | UCODE_ID=
_CP_MEC_JT2_MASK);<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smu8_request_smu_load_fw(hwmgr);<br>
-<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D smu8_check_fw_load=
_finish(hwmgr, fw_to_check);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; pr_err(&quot;SMU firmware load failed\n&quot;);<br>
@@ -734,6 &#43;715,25 @@ static int smu8_start_smu(struct pp_hwmgr *hwmgr)<=
br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret;<br>
&nbsp;}<br>
&nbsp;<br>
&#43;static int smu8_start_smu(struct pp_hwmgr *hwmgr)<br>
&#43;{<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev =3D hw=
mgr-&gt;adev;<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t index =3D SMN_MP1_SRAM_S=
TART_ADDR &#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SMU8_F=
IRMWARE_HEADER_LOCATION &#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; offset=
of(struct SMU8_Firmware_Header, Version);<br>
&#43;<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (hwmgr =3D=3D NULL || hwmgr-&g=
t;device =3D=3D NULL)<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; return -EINVAL;<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; cgs_write_register(hwmgr-&gt;devi=
ce, mmMP0PUB_IND_INDEX, index);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; hwmgr-&gt;smu_version =3D cgs_rea=
d_register(hwmgr-&gt;device, mmMP0PUB_IND_DATA);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;pm.fw_version =3D hwmgr-=
&gt;smu_version &gt;&gt; 8;<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&#43;}<br>
&#43;<br>
&nbsp;static int smu8_smu_init(struct pp_hwmgr *hwmgr)<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ret =3D 0;<br>
@@ -876,7 &#43;876,7 @@ static bool smu8_is_dpm_running(struct pp_hwmgr *hw=
mgr)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .smu_fini =3D smu8_smu_fin=
i,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .start_smu =3D smu8_start_=
smu,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .check_fw_load_finish =3D =
smu8_check_fw_load_finish,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .request_smu_load_fw =3D NULL,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .request_smu_load_fw =3D smu8_req=
uest_smu_load_fw,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .request_smu_load_specific=
_fw =3D NULL,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .get_argument =3D smu8_get=
_argument,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .send_msg_to_smc =3D smu8_=
send_msg_to_smc,<br>
diff --git a/drivers/gpu/drm/amd/powerplay/smumgr/tonga_smumgr.c b/drivers/=
gpu/drm/amd/powerplay/smumgr/tonga_smumgr.c<br>
index ae8378e..d8f1ca2 100644<br>
--- a/drivers/gpu/drm/amd/powerplay/smumgr/tonga_smumgr.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/powerplay/smumgr/tonga_smumgr.c<br>
@@ -192,7 &#43;192,8 @@ static int tonga_start_in_non_protection_mode(struc=
t pp_hwmgr *hwmgr)<br>
&nbsp;<br>
&nbsp;static int tonga_start_smu(struct pp_hwmgr *hwmgr)<br>
&nbsp;{<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int result;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct tonga_smumgr *priv =3D hwm=
gr-&gt;smu_backend;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int result =3D 0;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Only start SMC if SMC R=
AM is not running */<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!smu7_is_smc_ram_runni=
ng(hwmgr) &amp;&amp; hwmgr-&gt;not_vf) {<br>
@@ -209,7 &#43;210,14 @@ static int tonga_start_smu(struct pp_hwmgr *hwmgr)=
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; result =3D smu7_request_smu_load_fw(h=
wmgr);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Setup SoftRegsStart here for r=
egister lookup in case<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * DummyBackEnd is used and =
ProcessFirmwareHeader is not executed<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smu7_read_smc_sram_dword(hwmgr,<b=
r>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SMU72_FIRMWA=
RE_HEADER_LOCATION &#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; offsetof(SMU=
72_Firmware_Header, SoftRegisters),<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp;(priv-&=
gt;smu7_data.soft_regs_start), 0x40000);<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return result;<br>
&nbsp;}<br>
diff --git a/drivers/gpu/drm/amd/powerplay/smumgr/vegam_smumgr.c b/drivers/=
gpu/drm/amd/powerplay/smumgr/vegam_smumgr.c<br>
index 3d415fa..71e376f 100644<br>
--- a/drivers/gpu/drm/amd/powerplay/smumgr/vegam_smumgr.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/powerplay/smumgr/vegam_smumgr.c<br>
@@ -218,8 &#43;218,6 @@ static int vegam_start_smu(struct pp_hwmgr *hwmgr)<=
br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp;=
(smu_data-&gt;smu7_data.soft_regs_start),<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x400=
00);<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; result =3D smu7_request_smu_load_fw(h=
wmgr);<br>
-<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return result;<br>
&nbsp;}<br>
&nbsp;<br>
@@ -2280,7 &#43;2278,7 @@ static int vegam_thermal_setup_fan_table(struct p=
p_hwmgr *hwmgr)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .smu_fini =3D smu7_smu_fin=
i,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .start_smu =3D vegam_start=
_smu,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .check_fw_load_finish =3D =
smu7_check_fw_load_finish,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .request_smu_load_fw =3D smu7_reload_=
firmware,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .request_smu_load_fw =3D smu7_req=
uest_smu_load_fw,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .request_smu_load_specific=
_fw =3D NULL,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .send_msg_to_smc =3D smu7_=
send_msg_to_smc,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .send_msg_to_smc_with_para=
meter =3D smu7_send_msg_to_smc_with_parameter,<br>
-- <br>
1.9.1<br>
<br>
_______________________________________________<br>
amd-gfx mailing list<br>
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
<a href=3D"https://lists.freedesktop.org/mailman/listinfo/amd-gfx" id=3D"LP=
lnk765884" class=3D"OWAAutoLink" previewremoved=3D"true">https://lists.free=
desktop.org/mailman/listinfo/amd-gfx</a>
<div id=3D"LPBorder_GT_15380573002800.7746271423568079" style=3D"margin-bot=
tom: 20px; overflow: auto; width: 100%; text-indent: 0px;">
<table id=3D"LPContainer_15380573002620.6615257615661329" style=3D"width: 9=
0%; background-color: rgb(255, 255, 255); position: relative; overflow: aut=
o; padding-top: 20px; padding-bottom: 20px; margin-top: 20px; border-top: 1=
px dotted rgb(200, 200, 200); border-bottom: 1px dotted rgb(200, 200, 200);=
" role=3D"presentation" cellspacing=3D"0">
<tbody>
<tr style=3D"border-spacing: 0px;" valign=3D"top">
<td id=3D"TextCell_15380573002800.8729728302113203" style=3D"vertical-align=
: top; position: relative; padding: 0px; display: table-cell;" colspan=3D"2=
">
<div id=3D"LPRemovePreviewContainer_15380573002800.6596419293200704"></div>
<div id=3D"LPTitle_15380573002800.6685421005742361" style=3D"top: 0px; colo=
r: rgb(0, 120, 215); font-weight: 400; font-size: 21px; font-family: &quot;=
wf_segoe-ui_light&quot;, &quot;Segoe UI Light&quot;, &quot;Segoe WP Light&q=
uot;, &quot;Segoe UI&quot;, &quot;Segoe WP&quot;, Tahoma, Arial, sans-serif=
; line-height: 21px;">
<a id=3D"LPUrlAnchor_15380573002800.5659310772379927" style=3D"text-decorat=
ion: none;" href=3D"https://lists.freedesktop.org/mailman/listinfo/amd-gfx"=
 target=3D"_blank">amd-gfx Info Page - freedesktop.org</a></div>
<div id=3D"LPMetadata_15380573002800.27986444667919286" style=3D"margin: 10=
px 0px 16px; color: rgb(102, 102, 102); font-weight: 400; font-family: &quo=
t;wf_segoe-ui_normal&quot;, &quot;Segoe UI&quot;, &quot;Segoe WP&quot;, Tah=
oma, Arial, sans-serif; font-size: 14px; line-height: 14px;">
lists.freedesktop.org</div>
<div id=3D"LPDescription_15380573002800.6911916717608517" style=3D"display:=
 block; color: rgb(102, 102, 102); font-weight: 400; font-family: &quot;wf_=
segoe-ui_normal&quot;, &quot;Segoe UI&quot;, &quot;Segoe WP&quot;, Tahoma, =
Arial, sans-serif; font-size: 14px; line-height: 20px; max-height: 100px; o=
verflow: hidden;">
To see the collection of prior postings to the list, visit the amd-gfx Arch=
ives.. Using amd-gfx: To post a message to all the list members, send email=
 to amd-gfx-PD4FTy7X32lNgt0PjOBp9xlNPtJONSTn@public.gmane.org You can subscribe to the list, or change=
 your existing subscription, in
 the sections below.</div>
</td>
</tr>
</tbody>
</table>
</div>
<br>
</div>
</span></font></div>
</div>
</div>
</body>
</html>

--_000_BYAPR12MB2775243258483D0EC9EA2E65FB140BYAPR12MB2775namp_--

--===============2082822779==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============2082822779==--
