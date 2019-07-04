From: "Wang, Kevin(Yang)" <Kevin1.Wang-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH] drm/amd/powerplay: add baco smu reset function for smu11
Date: Thu, 4 Jul 2019 03:13:11 +0000
Message-ID: <MN2PR12MB3296575FE79BC02F2E406C64A2FA0@MN2PR12MB3296.namprd12.prod.outlook.com>
References: <20190703030931.27890-1-kevin1.wang@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0381774601=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20190703030931.27890-1-kevin1.wang-5C7GfCeVMHo@public.gmane.org>
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
Cc: "Xiao, Jack" <Jack.Xiao-5C7GfCeVMHo@public.gmane.org>, "Huang, Ray" <Ray.Huang-5C7GfCeVMHo@public.gmane.org>, "Feng,
 Kenneth" <Kenneth.Feng-5C7GfCeVMHo@public.gmane.org>, "Quan, Evan" <Evan.Quan-5C7GfCeVMHo@public.gmane.org>, "Zhang,
 Hawking" <Hawking.Zhang-5C7GfCeVMHo@public.gmane.org>

--===============0381774601==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_MN2PR12MB3296575FE79BC02F2E406C64A2FA0MN2PR12MB3296namp_"

--_000_MN2PR12MB3296575FE79BC02F2E406C64A2FA0MN2PR12MB3296namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

ping...,

which one can help me review this patch.

thanks.


Best Regards,

Kevin

________________________________
From: Wang, Kevin(Yang)
Sent: Wednesday, July 3, 2019 11:09:45 AM
To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Cc: Zhang, Hawking; Xiao, Jack; Huang, Ray; Wang, Kevin(Yang)
Subject: [PATCH] drm/amd/powerplay: add baco smu reset function for smu11

add baco reset support for smu11.
it can help gpu do asic reset when gpu recovery.

Change-Id: I7714ed03ad87c13e93ca1a7e6aef81eba14667c8
Signed-off-by: Kevin Wang <kevin1.wang-5C7GfCeVMHo@public.gmane.org>
---
 drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c        |  6 +-
 drivers/gpu/drm/amd/amdgpu/nv.c               |  9 +-
 drivers/gpu/drm/amd/powerplay/amdgpu_smu.c    | 14 +++
 .../gpu/drm/amd/powerplay/inc/amdgpu_smu.h    | 26 ++++++
 drivers/gpu/drm/amd/powerplay/inc/smu_v11_0.h |  8 ++
 drivers/gpu/drm/amd/powerplay/navi10_ppt.c    |  8 ++
 drivers/gpu/drm/amd/powerplay/smu_v11_0.c     | 91 +++++++++++++++++++
 7 files changed, 159 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c b/drivers/gpu/drm/amd/a=
mdgpu/gmc_v10_0.c
index b41169261f7d..45dd22a1ef77 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
@@ -244,8 +244,10 @@ static void gmc_v10_0_flush_gpu_tlb(struct amdgpu_devi=
ce *adev,
         mutex_lock(&adev->mman.gtt_window_lock);

         gmc_v10_0_flush_vm_hub(adev, vmid, AMDGPU_MMHUB, 0);
-       if (!adev->mman.buffer_funcs_enabled || !adev->ib_pool_ready ||
-           adev->asic_type !=3D CHIP_NAVI10) {
+       if (!adev->mman.buffer_funcs_enabled ||
+           !adev->ib_pool_ready ||
+           adev->asic_type !=3D CHIP_NAVI10 ||
+           adev->in_gpu_reset) {
                 gmc_v10_0_flush_vm_hub(adev, vmid, AMDGPU_GFXHUB, 0);
                 mutex_unlock(&adev->mman.gtt_window_lock);
                 return;
diff --git a/drivers/gpu/drm/amd/amdgpu/nv.c b/drivers/gpu/drm/amd/amdgpu/n=
v.c
index 8f605417b40a..cc5d06718e4c 100644
--- a/drivers/gpu/drm/amd/amdgpu/nv.c
+++ b/drivers/gpu/drm/amd/amdgpu/nv.c
@@ -31,6 +31,7 @@
 #include "amdgpu_vce.h"
 #include "amdgpu_ucode.h"
 #include "amdgpu_psp.h"
+#include "amdgpu_smu.h"
 #include "atom.h"
 #include "amd_pcie.h"

@@ -266,8 +267,14 @@ static int nv_asic_reset(struct amdgpu_device *adev)

         amdgpu_atombios_scratch_regs_engine_hung(adev, false);
 #endif
+       int ret =3D 0;
+       struct smu_context *smu =3D &adev->smu;

-       return 0;
+       if (smu_baco_is_support(smu)) {
+               ret =3D smu_baco_reset(smu);
+       }
+
+       return ret;
 }

 static int nv_set_uvd_clocks(struct amdgpu_device *adev, u32 vclk, u32 dcl=
k)
diff --git a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c b/drivers/gpu/drm/a=
md/powerplay/amdgpu_smu.c
index b28a923f998d..fc416c686151 100644
--- a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
@@ -633,6 +633,11 @@ static int smu_sw_init(void *handle)
         bitmap_zero(smu->smu_feature.supported, SMU_FEATURE_MAX);
         bitmap_zero(smu->smu_feature.enabled, SMU_FEATURE_MAX);
         bitmap_zero(smu->smu_feature.allowed, SMU_FEATURE_MAX);
+
+       mutex_init(&smu->smu_baco.mutex);
+       smu->smu_baco.state =3D SMU_BACO_STATE_EXIT;
+       smu->smu_baco.platform_support =3D false;
+
         smu->watermarks_bitmap =3D 0;
         smu->power_profile_mode =3D PP_SMC_POWER_PROFILE_BOOTUP_DEFAULT;
         smu->default_power_profile_mode =3D PP_SMC_POWER_PROFILE_BOOTUP_DE=
FAULT;
@@ -1057,11 +1062,20 @@ static int smu_suspend(void *handle)
         int ret;
         struct amdgpu_device *adev =3D (struct amdgpu_device *)handle;
         struct smu_context *smu =3D &adev->smu;
+       bool baco_feature_is_enabled =3D smu_feature_is_enabled(smu, SMU_FE=
ATURE_BACO_BIT);

         ret =3D smu_system_features_control(smu, false);
         if (ret)
                 return ret;

+       if (adev->in_gpu_reset && baco_feature_is_enabled) {
+               ret =3D smu_feature_set_enabled(smu, SMU_FEATURE_BACO_BIT, =
true);
+               if (ret) {
+                       pr_warn("set BACO feature enabled failed, return %d=
\n", ret);
+                       return ret;
+               }
+       }
+
         smu->watermarks_bitmap &=3D ~(WATERMARKS_LOADED);

         if (adev->asic_type >=3D CHIP_NAVI10 &&
diff --git a/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h b/drivers/gpu/d=
rm/amd/powerplay/inc/amdgpu_smu.h
index 2818df46481c..c97324ef7db2 100644
--- a/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h
+++ b/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h
@@ -241,6 +241,7 @@ enum smu_message_type
         SMU_MSG_PowerUpJpeg,
         SMU_MSG_PowerDownJpeg,
         SMU_MSG_BacoAudioD3PME,
+       SMU_MSG_ArmD3,
         SMU_MSG_MAX_COUNT,
 };

@@ -489,6 +490,19 @@ struct mclock_latency_table {
         struct mclk_latency_entries  entries[MAX_REGULAR_DPM_NUM];
 };

+enum smu_baco_state
+{
+       SMU_BACO_STATE_ENTER =3D 0,
+       SMU_BACO_STATE_EXIT,
+};
+
+struct smu_baco_context
+{
+       struct mutex mutex;
+       uint32_t state;
+       bool platform_support;
+};
+
 #define WORKLOAD_POLICY_MAX 7
 struct smu_context
 {
@@ -505,6 +519,7 @@ struct smu_context
         struct smu_power_context        smu_power;
         struct smu_feature              smu_feature;
         struct amd_pp_display_configuration  *display_config;
+       struct smu_baco_context         smu_baco;
         void *od_settings;

         uint32_t pstate_sclk;
@@ -680,6 +695,11 @@ struct smu_funcs
         int (*register_irq_handler)(struct smu_context *smu);
         int (*set_azalia_d3_pme)(struct smu_context *smu);
         int (*get_max_sustainable_clocks_by_dc)(struct smu_context *smu, s=
truct pp_smu_nv_clock_table *max_clocks);
+       bool (*baco_is_support)(struct smu_context *smu);
+       enum smu_baco_state (*baco_get_state)(struct smu_context *smu);
+       int (*baco_set_state)(struct smu_context *smu, enum smu_baco_state =
state);
+       int (*baco_reset)(struct smu_context *smu);
+
 };

 #define smu_init_microcode(smu) \
@@ -892,6 +912,12 @@ struct smu_funcs
         ((smu)->funcs->get_max_sustainable_clocks_by_dc ? (smu)->funcs->ge=
t_max_sustainable_clocks_by_dc((smu), (max_clocks)) : 0)
 #define smu_get_uclk_dpm_states(smu, clocks_in_khz, num_states) \
         ((smu)->ppt_funcs->get_uclk_dpm_states ? (smu)->ppt_funcs->get_ucl=
k_dpm_states((smu), (clocks_in_khz), (num_states)) : 0)
+#define smu_baco_is_support(smu) \
+       ((smu)->funcs->baco_is_support? (smu)->funcs->baco_is_support((smu)=
) : false)
+#define smu_baco_get_state(smu, state) \
+       ((smu)->funcs->baco_get_state? (smu)->funcs->baco_get_state((smu), =
(state)) : 0)
+#define smu_baco_reset(smu) \
+       ((smu)->funcs->baco_reset? (smu)->funcs->baco_reset((smu)) : 0)

 extern int smu_get_atom_data_table(struct smu_context *smu, uint32_t table=
,
                                    uint16_t *size, uint8_t *frev, uint8_t =
*crev,
diff --git a/drivers/gpu/drm/amd/powerplay/inc/smu_v11_0.h b/drivers/gpu/dr=
m/amd/powerplay/inc/smu_v11_0.h
index d93cd76269b4..2fff4b16cb4e 100644
--- a/drivers/gpu/drm/amd/powerplay/inc/smu_v11_0.h
+++ b/drivers/gpu/drm/amd/powerplay/inc/smu_v11_0.h
@@ -105,6 +105,14 @@ struct smu_11_0_power_context {
         enum smu_11_0_power_state power_state;
 };

+enum smu_v11_0_baco_seq {
+       BACO_SEQ_BACO =3D 0,
+       BACO_SEQ_MSR,
+       BACO_SEQ_BAMACO,
+       BACO_SEQ_ULPS,
+       BACO_SEQ_COUNT,
+};
+
 void smu_v11_0_set_smu_funcs(struct smu_context *smu);

 #endif
diff --git a/drivers/gpu/drm/amd/powerplay/navi10_ppt.c b/drivers/gpu/drm/a=
md/powerplay/navi10_ppt.c
index 373aeba44f16..7574a02350c6 100644
--- a/drivers/gpu/drm/amd/powerplay/navi10_ppt.c
+++ b/drivers/gpu/drm/amd/powerplay/navi10_ppt.c
@@ -115,6 +115,7 @@ static int navi10_message_map[SMU_MSG_MAX_COUNT] =3D {
         MSG_MAP(PowerUpJpeg,            PPSMC_MSG_PowerUpJpeg),
         MSG_MAP(PowerDownJpeg,          PPSMC_MSG_PowerDownJpeg),
         MSG_MAP(BacoAudioD3PME,         PPSMC_MSG_BacoAudioD3PME),
+       MSG_MAP(ArmD3,                  PPSMC_MSG_ArmD3),
 };

 static int navi10_clk_map[SMU_CLK_COUNT] =3D {
@@ -478,6 +479,7 @@ static int navi10_store_powerplay_table(struct smu_cont=
ext *smu)
 {
         struct smu_11_0_powerplay_table *powerplay_table =3D NULL;
         struct smu_table_context *table_context =3D &smu->smu_table;
+       struct smu_baco_context *smu_baco =3D &smu->smu_baco;

         if (!table_context->power_play_table)
                 return -EINVAL;
@@ -489,6 +491,12 @@ static int navi10_store_powerplay_table(struct smu_con=
text *smu)

         table_context->thermal_controller_type =3D powerplay_table->therma=
l_controller_type;

+       mutex_lock(&smu_baco->mutex);
+       if (powerplay_table->platform_caps & SMU_11_0_PP_PLATFORM_CAP_BACO =
||
+           powerplay_table->platform_caps & SMU_11_0_PP_PLATFORM_CAP_MACO)
+               smu_baco->platform_support =3D true;
+       mutex_unlock(&smu_baco->mutex);
+
         return 0;
 }

diff --git a/drivers/gpu/drm/amd/powerplay/smu_v11_0.c b/drivers/gpu/drm/am=
d/powerplay/smu_v11_0.c
index ff047abd8d92..c6795de7177f 100644
--- a/drivers/gpu/drm/amd/powerplay/smu_v11_0.c
+++ b/drivers/gpu/drm/amd/powerplay/smu_v11_0.c
@@ -37,6 +37,7 @@
 #include "asic_reg/mp/mp_11_0_offset.h"
 #include "asic_reg/mp/mp_11_0_sh_mask.h"
 #include "asic_reg/nbio/nbio_7_4_offset.h"
+#include "asic_reg/nbio/nbio_7_4_sh_mask.h"
 #include "asic_reg/smuio/smuio_11_0_0_offset.h"
 #include "asic_reg/smuio/smuio_11_0_0_sh_mask.h"

@@ -1637,6 +1638,92 @@ static int smu_v11_0_set_azalia_d3_pme(struct smu_co=
ntext *smu)
         return ret;
 }

+static int smu_v11_0_baco_set_armd3_sequence(struct smu_context *smu, enum=
 smu_v11_0_baco_seq baco_seq)
+{
+       return smu_send_smc_msg_with_param(smu, SMU_MSG_ArmD3, baco_seq);
+}
+
+static bool smu_v11_0_baco_is_support(struct smu_context *smu)
+{
+       struct amdgpu_device *adev =3D smu->adev;
+       struct smu_baco_context *smu_baco =3D &smu->smu_baco;
+       uint32_t val;
+       bool baco_support;
+
+       mutex_lock(&smu_baco->mutex);
+       baco_support =3D smu_baco->platform_support;
+       mutex_unlock(&smu_baco->mutex);
+
+       if (!baco_support)
+               return false;
+
+       if (!smu_feature_is_enabled(smu, SMU_FEATURE_BACO_BIT))
+               return false;
+
+       val =3D RREG32_SOC15(NBIO, 0, mmRCC_BIF_STRAP0);
+       if (val & RCC_BIF_STRAP0__STRAP_PX_CAPABLE_MASK)
+               return true;
+
+       return false;
+}
+
+static enum smu_baco_state smu_v11_0_baco_get_state(struct smu_context *sm=
u)
+{
+       struct smu_baco_context *smu_baco =3D &smu->smu_baco;
+       enum smu_baco_state baco_state =3D SMU_BACO_STATE_EXIT;
+
+       mutex_lock(&smu_baco->mutex);
+       baco_state =3D smu_baco->state;
+       mutex_unlock(&smu_baco->mutex);
+
+       return baco_state;
+}
+
+static int smu_v11_0_baco_set_state(struct smu_context *smu, enum smu_baco=
_state state)
+{
+
+       struct smu_baco_context *smu_baco =3D &smu->smu_baco;
+       int ret =3D 0;
+
+       if (smu_v11_0_baco_get_state(smu) =3D=3D state)
+               return 0;
+
+       mutex_lock(&smu_baco->mutex);
+
+       if (state =3D=3D SMU_BACO_STATE_ENTER)
+               ret =3D smu_send_smc_msg_with_param(smu, SMU_MSG_EnterBaco,=
 BACO_SEQ_BACO);
+       else
+               ret =3D smu_send_smc_msg(smu, SMU_MSG_ExitBaco);
+       if (ret)
+               goto out;
+
+       smu_baco->state =3D state;
+out:
+       mutex_unlock(&smu_baco->mutex);
+       return ret;
+}
+
+static int smu_v11_0_baco_reset(struct smu_context *smu)
+{
+       int ret =3D 0;
+
+       ret =3D smu_v11_0_baco_set_armd3_sequence(smu, BACO_SEQ_BACO);
+       if (ret)
+               return ret;
+
+       ret =3D smu_v11_0_baco_set_state(smu, SMU_BACO_STATE_ENTER);
+       if (ret)
+               return ret;
+
+       msleep(10);
+
+       ret =3D smu_v11_0_baco_set_state(smu, SMU_BACO_STATE_EXIT);
+       if (ret)
+               return ret;
+
+       return ret;
+}
+
 static const struct smu_funcs smu_v11_0_funcs =3D {
         .init_microcode =3D smu_v11_0_init_microcode,
         .load_microcode =3D smu_v11_0_load_microcode,
@@ -1685,6 +1772,10 @@ static const struct smu_funcs smu_v11_0_funcs =3D {
         .register_irq_handler =3D smu_v11_0_register_irq_handler,
         .set_azalia_d3_pme =3D smu_v11_0_set_azalia_d3_pme,
         .get_max_sustainable_clocks_by_dc =3D smu_v11_0_get_max_sustainabl=
e_clocks_by_dc,
+       .baco_is_support=3D smu_v11_0_baco_is_support,
+       .baco_get_state =3D smu_v11_0_baco_get_state,
+       .baco_set_state =3D smu_v11_0_baco_set_state,
+       .baco_reset =3D smu_v11_0_baco_reset,
 };

 void smu_v11_0_set_smu_funcs(struct smu_context *smu)
--
2.22.0


--_000_MN2PR12MB3296575FE79BC02F2E406C64A2FA0MN2PR12MB3296namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<style type=3D"text/css" style=3D"display:none;"><!-- P {margin-top:0;margi=
n-bottom:0;} --></style>
</head>
<body dir=3D"ltr">
<div id=3D"divtagdefaultwrapper" style=3D"font-size:12pt;color:#000000;font=
-family:Calibri,Helvetica,sans-serif;" dir=3D"ltr">
<p style=3D"margin-top:0;margin-bottom:0">ping...,</p>
<p style=3D"margin-top:0;margin-bottom:0">which one can help me review this=
 patch.</p>
<p style=3D"margin-top:0;margin-bottom:0">thanks.</p>
<p style=3D"margin-top:0;margin-bottom:0"><br>
</p>
<p style=3D"margin-top:0;margin-bottom:0">Best Regards,</p>
<p style=3D"margin-top:0;margin-bottom:0">Kevin</p>
</div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Wang, Kevin(Yang)<br>
<b>Sent:</b> Wednesday, July 3, 2019 11:09:45 AM<br>
<b>To:</b> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
<b>Cc:</b> Zhang, Hawking; Xiao, Jack; Huang, Ray; Wang, Kevin(Yang)<br>
<b>Subject:</b> [PATCH] drm/amd/powerplay: add baco smu reset function for =
smu11</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">add baco reset support for smu11.<br>
it can help gpu do asic reset when gpu recovery.<br>
<br>
Change-Id: I7714ed03ad87c13e93ca1a7e6aef81eba14667c8<br>
Signed-off-by: Kevin Wang &lt;kevin1.wang-5C7GfCeVMHo@public.gmane.org&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; |&nbsp; 6 &#43;-<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/nv.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp; 9 &#43;-<br>
&nbsp;drivers/gpu/drm/amd/powerplay/amdgpu_smu.c&nbsp;&nbsp;&nbsp; | 14 &#4=
3;&#43;&#43;<br>
&nbsp;.../gpu/drm/amd/powerplay/inc/amdgpu_smu.h&nbsp;&nbsp;&nbsp; | 26 &#4=
3;&#43;&#43;&#43;&#43;&#43;<br>
&nbsp;drivers/gpu/drm/amd/powerplay/inc/smu_v11_0.h |&nbsp; 8 &#43;&#43;<br=
>
&nbsp;drivers/gpu/drm/amd/powerplay/navi10_ppt.c&nbsp;&nbsp;&nbsp; |&nbsp; =
8 &#43;&#43;<br>
&nbsp;drivers/gpu/drm/amd/powerplay/smu_v11_0.c&nbsp;&nbsp;&nbsp;&nbsp; | 9=
1 &#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#4=
3;&#43;&#43;&#43;&#43;<br>
&nbsp;7 files changed, 159 insertions(&#43;), 3 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c b/drivers/gpu/drm/amd/a=
mdgpu/gmc_v10_0.c<br>
index b41169261f7d..45dd22a1ef77 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c<br>
@@ -244,8 &#43;244,10 @@ static void gmc_v10_0_flush_gpu_tlb(struct amdgpu_=
device *adev,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_lock(&amp;adev-&gt;m=
man.gtt_window_lock);<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gmc_v10_0_flush_vm_hub(ade=
v, vmid, AMDGPU_MMHUB, 0);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!adev-&gt;mman.buffer_funcs_enabl=
ed || !adev-&gt;ib_pool_ready ||<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;asic=
_type !=3D CHIP_NAVI10) {<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!adev-&gt;mman.buffer_funcs_e=
nabled ||<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; !adev-&gt=
;ib_pool_ready ||<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;=
asic_type !=3D CHIP_NAVI10 ||<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;=
in_gpu_reset) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; gmc_v10_0_flush_vm_hub(adev, vmid, AMDGPU_GFXHUB, 0);=
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; mutex_unlock(&amp;adev-&gt;mman.gtt_window_lock);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return;<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/nv.c b/drivers/gpu/drm/amd/amdgpu/n=
v.c<br>
index 8f605417b40a..cc5d06718e4c 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/nv.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/nv.c<br>
@@ -31,6 &#43;31,7 @@<br>
&nbsp;#include &quot;amdgpu_vce.h&quot;<br>
&nbsp;#include &quot;amdgpu_ucode.h&quot;<br>
&nbsp;#include &quot;amdgpu_psp.h&quot;<br>
&#43;#include &quot;amdgpu_smu.h&quot;<br>
&nbsp;#include &quot;atom.h&quot;<br>
&nbsp;#include &quot;amd_pcie.h&quot;<br>
&nbsp;<br>
@@ -266,8 &#43;267,14 @@ static int nv_asic_reset(struct amdgpu_device *ade=
v)<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_atombios_scratch_re=
gs_engine_hung(adev, false);<br>
&nbsp;#endif<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ret =3D 0;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct smu_context *smu =3D &amp;=
adev-&gt;smu;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (smu_baco_is_support(smu)) {<b=
r>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; ret =3D smu_baco_reset(smu);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret;<br>
&nbsp;}<br>
&nbsp;<br>
&nbsp;static int nv_set_uvd_clocks(struct amdgpu_device *adev, u32 vclk, u3=
2 dclk)<br>
diff --git a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c b/drivers/gpu/drm/a=
md/powerplay/amdgpu_smu.c<br>
index b28a923f998d..fc416c686151 100644<br>
--- a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c<br>
@@ -633,6 &#43;633,11 @@ static int smu_sw_init(void *handle)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bitmap_zero(smu-&gt;smu_fe=
ature.supported, SMU_FEATURE_MAX);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bitmap_zero(smu-&gt;smu_fe=
ature.enabled, SMU_FEATURE_MAX);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bitmap_zero(smu-&gt;smu_fe=
ature.allowed, SMU_FEATURE_MAX);<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_init(&amp;smu-&gt;smu_baco.=
mutex);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smu-&gt;smu_baco.state =3D SMU_BA=
CO_STATE_EXIT;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smu-&gt;smu_baco.platform_support=
 =3D false;<br>
&#43;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smu-&gt;watermarks_bitmap =
=3D 0;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smu-&gt;power_profile_mode=
 =3D PP_SMC_POWER_PROFILE_BOOTUP_DEFAULT;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smu-&gt;default_power_prof=
ile_mode =3D PP_SMC_POWER_PROFILE_BOOTUP_DEFAULT;<br>
@@ -1057,11 &#43;1062,20 @@ static int smu_suspend(void *handle)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ret;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev=
 =3D (struct amdgpu_device *)handle;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct smu_context *smu =
=3D &amp;adev-&gt;smu;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool baco_feature_is_enabled =3D =
smu_feature_is_enabled(smu, SMU_FEATURE_BACO_BIT);<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D smu_system_feature=
s_control(smu, false);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return ret;<br>
&nbsp;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;in_gpu_reset &amp;&a=
mp; baco_feature_is_enabled) {<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; ret =3D smu_feature_set_enabled(smu, SMU_FEATURE_BACO_BIT, t=
rue);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; if (ret) {<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pr_warn(&quo=
t;set BACO feature enabled failed, return %d\n&quot;, ret);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret;<=
br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; }<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&#43;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smu-&gt;watermarks_bitmap =
&amp;=3D ~(WATERMARKS_LOADED);<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;asic_type &gt=
;=3D CHIP_NAVI10 &amp;&amp;<br>
diff --git a/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h b/drivers/gpu/d=
rm/amd/powerplay/inc/amdgpu_smu.h<br>
index 2818df46481c..c97324ef7db2 100644<br>
--- a/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h<br>
@@ -241,6 &#43;241,7 @@ enum smu_message_type<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SMU_MSG_PowerUpJpeg,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SMU_MSG_PowerDownJpeg,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SMU_MSG_BacoAudioD3PME,<br=
>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SMU_MSG_ArmD3,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SMU_MSG_MAX_COUNT,<br>
&nbsp;};<br>
&nbsp;<br>
@@ -489,6 &#43;490,19 @@ struct mclock_latency_table {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct mclk_latency_entrie=
s&nbsp; entries[MAX_REGULAR_DPM_NUM];<br>
&nbsp;};<br>
&nbsp;<br>
&#43;enum smu_baco_state<br>
&#43;{<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SMU_BACO_STATE_ENTER =3D 0,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SMU_BACO_STATE_EXIT,<br>
&#43;};<br>
&#43;<br>
&#43;struct smu_baco_context<br>
&#43;{<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct mutex mutex;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t state;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool platform_support;<br>
&#43;};<br>
&#43;<br>
&nbsp;#define WORKLOAD_POLICY_MAX 7<br>
&nbsp;struct smu_context<br>
&nbsp;{<br>
@@ -505,6 &#43;519,7 @@ struct smu_context<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct smu_power_context&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smu_power;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct smu_feature&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smu_=
feature;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amd_pp_display_conf=
iguration&nbsp; *display_config;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct smu_baco_context&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smu_baco;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; void *od_settings;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t pstate_sclk;<br>
@@ -680,6 &#43;695,11 @@ struct smu_funcs<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int (*register_irq_handler=
)(struct smu_context *smu);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int (*set_azalia_d3_pme)(s=
truct smu_context *smu);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int (*get_max_sustainable_=
clocks_by_dc)(struct smu_context *smu, struct pp_smu_nv_clock_table *max_cl=
ocks);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool (*baco_is_support)(struct sm=
u_context *smu);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; enum smu_baco_state (*baco_get_st=
ate)(struct smu_context *smu);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int (*baco_set_state)(struct smu_=
context *smu, enum smu_baco_state state);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int (*baco_reset)(struct smu_cont=
ext *smu);<br>
&#43;<br>
&nbsp;};<br>
&nbsp;<br>
&nbsp;#define smu_init_microcode(smu) \<br>
@@ -892,6 &#43;912,12 @@ struct smu_funcs<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ((smu)-&gt;funcs-&gt;get_m=
ax_sustainable_clocks_by_dc ? (smu)-&gt;funcs-&gt;get_max_sustainable_clock=
s_by_dc((smu), (max_clocks)) : 0)<br>
&nbsp;#define smu_get_uclk_dpm_states(smu, clocks_in_khz, num_states) \<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ((smu)-&gt;ppt_funcs-&gt;g=
et_uclk_dpm_states ? (smu)-&gt;ppt_funcs-&gt;get_uclk_dpm_states((smu), (cl=
ocks_in_khz), (num_states)) : 0)<br>
&#43;#define smu_baco_is_support(smu) \<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ((smu)-&gt;funcs-&gt;baco_is_supp=
ort? (smu)-&gt;funcs-&gt;baco_is_support((smu)) : false)<br>
&#43;#define smu_baco_get_state(smu, state) \<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ((smu)-&gt;funcs-&gt;baco_get_sta=
te? (smu)-&gt;funcs-&gt;baco_get_state((smu), (state)) : 0)<br>
&#43;#define smu_baco_reset(smu) \<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ((smu)-&gt;funcs-&gt;baco_reset? =
(smu)-&gt;funcs-&gt;baco_reset((smu)) : 0)<br>
&nbsp;<br>
&nbsp;extern int smu_get_atom_data_table(struct smu_context *smu, uint32_t =
table,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint16_t *size=
, uint8_t *frev, uint8_t *crev,<br>
diff --git a/drivers/gpu/drm/amd/powerplay/inc/smu_v11_0.h b/drivers/gpu/dr=
m/amd/powerplay/inc/smu_v11_0.h<br>
index d93cd76269b4..2fff4b16cb4e 100644<br>
--- a/drivers/gpu/drm/amd/powerplay/inc/smu_v11_0.h<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/powerplay/inc/smu_v11_0.h<br>
@@ -105,6 &#43;105,14 @@ struct smu_11_0_power_context {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; enum smu_11_0_power_state =
power_state;<br>
&nbsp;};<br>
&nbsp;<br>
&#43;enum smu_v11_0_baco_seq {<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; BACO_SEQ_BACO =3D 0,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; BACO_SEQ_MSR,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; BACO_SEQ_BAMACO,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; BACO_SEQ_ULPS,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; BACO_SEQ_COUNT,<br>
&#43;};<br>
&#43;<br>
&nbsp;void smu_v11_0_set_smu_funcs(struct smu_context *smu);<br>
&nbsp;<br>
&nbsp;#endif<br>
diff --git a/drivers/gpu/drm/amd/powerplay/navi10_ppt.c b/drivers/gpu/drm/a=
md/powerplay/navi10_ppt.c<br>
index 373aeba44f16..7574a02350c6 100644<br>
--- a/drivers/gpu/drm/amd/powerplay/navi10_ppt.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/powerplay/navi10_ppt.c<br>
@@ -115,6 &#43;115,7 @@ static int navi10_message_map[SMU_MSG_MAX_COUNT] =
=3D {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; MSG_MAP(PowerUpJpeg,&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; PPSMC_MSG_Powe=
rUpJpeg),<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; MSG_MAP(PowerDownJpeg,&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; PPSMC_MSG_PowerDownJpeg)=
,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; MSG_MAP(BacoAudioD3PME,&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; PPSMC_MSG_BacoAudioD3PME),<br=
>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; MSG_MAP(ArmD3,&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp; PPSMC_MSG_ArmD3),<br>
&nbsp;};<br>
&nbsp;<br>
&nbsp;static int navi10_clk_map[SMU_CLK_COUNT] =3D {<br>
@@ -478,6 &#43;479,7 @@ static int navi10_store_powerplay_table(struct smu_=
context *smu)<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct smu_11_0_powerplay_=
table *powerplay_table =3D NULL;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct smu_table_context *=
table_context =3D &amp;smu-&gt;smu_table;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct smu_baco_context *smu_baco=
 =3D &amp;smu-&gt;smu_baco;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!table_context-&gt;pow=
er_play_table)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return -EINVAL;<br>
@@ -489,6 &#43;491,12 @@ static int navi10_store_powerplay_table(struct smu=
_context *smu)<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; table_context-&gt;thermal_=
controller_type =3D powerplay_table-&gt;thermal_controller_type;<br>
&nbsp;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_lock(&amp;smu_baco-&gt;mute=
x);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (powerplay_table-&gt;platform_=
caps &amp; SMU_11_0_PP_PLATFORM_CAP_BACO ||<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; powerplay=
_table-&gt;platform_caps &amp; SMU_11_0_PP_PLATFORM_CAP_MACO)<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; smu_baco-&gt;platform_support =3D true;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_unlock(&amp;smu_baco-&gt;mu=
tex);<br>
&#43;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&nbsp;}<br>
&nbsp;<br>
diff --git a/drivers/gpu/drm/amd/powerplay/smu_v11_0.c b/drivers/gpu/drm/am=
d/powerplay/smu_v11_0.c<br>
index ff047abd8d92..c6795de7177f 100644<br>
--- a/drivers/gpu/drm/amd/powerplay/smu_v11_0.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/powerplay/smu_v11_0.c<br>
@@ -37,6 &#43;37,7 @@<br>
&nbsp;#include &quot;asic_reg/mp/mp_11_0_offset.h&quot;<br>
&nbsp;#include &quot;asic_reg/mp/mp_11_0_sh_mask.h&quot;<br>
&nbsp;#include &quot;asic_reg/nbio/nbio_7_4_offset.h&quot;<br>
&#43;#include &quot;asic_reg/nbio/nbio_7_4_sh_mask.h&quot;<br>
&nbsp;#include &quot;asic_reg/smuio/smuio_11_0_0_offset.h&quot;<br>
&nbsp;#include &quot;asic_reg/smuio/smuio_11_0_0_sh_mask.h&quot;<br>
&nbsp;<br>
@@ -1637,6 &#43;1638,92 @@ static int smu_v11_0_set_azalia_d3_pme(struct sm=
u_context *smu)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret;<br>
&nbsp;}<br>
&nbsp;<br>
&#43;static int smu_v11_0_baco_set_armd3_sequence(struct smu_context *smu, =
enum smu_v11_0_baco_seq baco_seq)<br>
&#43;{<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return smu_send_smc_msg_with_para=
m(smu, SMU_MSG_ArmD3, baco_seq);<br>
&#43;}<br>
&#43;<br>
&#43;static bool smu_v11_0_baco_is_support(struct smu_context *smu)<br>
&#43;{<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev =3D sm=
u-&gt;adev;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct smu_baco_context *smu_baco=
 =3D &amp;smu-&gt;smu_baco;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t val;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool baco_support;<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_lock(&amp;smu_baco-&gt;mute=
x);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; baco_support =3D smu_baco-&gt;pla=
tform_support;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_unlock(&amp;smu_baco-&gt;mu=
tex);<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!baco_support)<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; return false;<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!smu_feature_is_enabled(smu, =
SMU_FEATURE_BACO_BIT))<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; return false;<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; val =3D RREG32_SOC15(NBIO, 0, mmR=
CC_BIF_STRAP0);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (val &amp; RCC_BIF_STRAP0__STR=
AP_PX_CAPABLE_MASK)<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; return true;<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return false;<br>
&#43;}<br>
&#43;<br>
&#43;static enum smu_baco_state smu_v11_0_baco_get_state(struct smu_context=
 *smu)<br>
&#43;{<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct smu_baco_context *smu_baco=
 =3D &amp;smu-&gt;smu_baco;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; enum smu_baco_state baco_state =
=3D SMU_BACO_STATE_EXIT;<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_lock(&amp;smu_baco-&gt;mute=
x);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; baco_state =3D smu_baco-&gt;state=
;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_unlock(&amp;smu_baco-&gt;mu=
tex);<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return baco_state;<br>
&#43;}<br>
&#43;<br>
&#43;static int smu_v11_0_baco_set_state(struct smu_context *smu, enum smu_=
baco_state state)<br>
&#43;{<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct smu_baco_context *smu_baco=
 =3D &amp;smu-&gt;smu_baco;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ret =3D 0;<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (smu_v11_0_baco_get_state(smu)=
 =3D=3D state)<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; return 0;<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_lock(&amp;smu_baco-&gt;mute=
x);<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (state =3D=3D SMU_BACO_STATE_E=
NTER)<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; ret =3D smu_send_smc_msg_with_param(smu, SMU_MSG_EnterBaco, =
BACO_SEQ_BACO);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; else<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; ret =3D smu_send_smc_msg(smu, SMU_MSG_ExitBaco);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret)<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; goto out;<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smu_baco-&gt;state =3D state;<br>
&#43;out:<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_unlock(&amp;smu_baco-&gt;mu=
tex);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret;<br>
&#43;}<br>
&#43;<br>
&#43;static int smu_v11_0_baco_reset(struct smu_context *smu)<br>
&#43;{<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ret =3D 0;<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D smu_v11_0_baco_set_armd3_=
sequence(smu, BACO_SEQ_BACO);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret)<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; return ret;<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D smu_v11_0_baco_set_state(=
smu, SMU_BACO_STATE_ENTER);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret)<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; return ret;<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; msleep(10);<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D smu_v11_0_baco_set_state(=
smu, SMU_BACO_STATE_EXIT);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret)<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; return ret;<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret;<br>
&#43;}<br>
&#43;<br>
&nbsp;static const struct smu_funcs smu_v11_0_funcs =3D {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .init_microcode =3D smu_v1=
1_0_init_microcode,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .load_microcode =3D smu_v1=
1_0_load_microcode,<br>
@@ -1685,6 &#43;1772,10 @@ static const struct smu_funcs smu_v11_0_funcs =
=3D {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .register_irq_handler =3D =
smu_v11_0_register_irq_handler,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .set_azalia_d3_pme =3D smu=
_v11_0_set_azalia_d3_pme,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .get_max_sustainable_clock=
s_by_dc =3D smu_v11_0_get_max_sustainable_clocks_by_dc,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .baco_is_support=3D smu_v11_0_bac=
o_is_support,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .baco_get_state =3D smu_v11_0_bac=
o_get_state,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .baco_set_state =3D smu_v11_0_bac=
o_set_state,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .baco_reset =3D smu_v11_0_baco_re=
set,<br>
&nbsp;};<br>
&nbsp;<br>
&nbsp;void smu_v11_0_set_smu_funcs(struct smu_context *smu)<br>
-- <br>
2.22.0<br>
<br>
</div>
</span></font></div>
</body>
</html>

--_000_MN2PR12MB3296575FE79BC02F2E406C64A2FA0MN2PR12MB3296namp_--

--===============0381774601==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4

--===============0381774601==--
