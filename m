From: "Wang, Ken" <Ken.Wang-5C7GfCeVMHo@public.gmane.org>
Subject: Fw: [PATCH] drm/amdgpu: Add GPU reset functionality for Vega10
Date: Fri, 15 Sep 2017 06:58:42 +0000
Message-ID: <CY1PR12MB04747E37CAE70D12509984C98C6C0@CY1PR12MB0474.namprd12.prod.outlook.com>
References: <1505458655-27828-1-git-send-email-Ken.Wang@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1893325554=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1505458655-27828-1-git-send-email-Ken.Wang-5C7GfCeVMHo@public.gmane.org>
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

--===============1893325554==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_CY1PR12MB04747E37CAE70D12509984C98C6C0CY1PR12MB0474namp_"

--_000_CY1PR12MB04747E37CAE70D12509984C98C6C0CY1PR12MB0474namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable




________________________________
From: Ken.Wang-5C7GfCeVMHo@public.gmane.org <Ken.Wang-5C7GfCeVMHo@public.gmane.org>
Sent: Friday, September 15, 2017 14:57
To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Cc: Wang, Ken
Subject: [PATCH] drm/amdgpu: Add GPU reset functionality for Vega10

From: Ken Wang <Ken.Wang-5C7GfCeVMHo@public.gmane.org>

Signed-off-by: Ken Wang <Ken.Wang-5C7GfCeVMHo@public.gmane.org>
Change-Id: I6fd2c216a84747313f18db25a444be5ed43b4f4b
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c |  7 +++++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c    | 10 +++++++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h    |  3 +++
 drivers/gpu/drm/amd/amdgpu/psp_v10_0.c     |  7 ++++++
 drivers/gpu/drm/amd/amdgpu/psp_v10_0.h     |  2 ++
 drivers/gpu/drm/amd/amdgpu/psp_v3_1.c      | 36 ++++++++++++++++++++++++++=
-
 drivers/gpu/drm/amd/amdgpu/psp_v3_1.h      |  1 +
 drivers/gpu/drm/amd/amdgpu/soc15.c         | 39 ++++++++++++++++++++------=
----
 8 files changed, 89 insertions(+), 16 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_device.c
index fc1c5437..4196786 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -2883,7 +2883,7 @@ int amdgpu_gpu_reset(struct amdgpu_device *adev)
         int resched;
         bool need_full_reset, vram_lost =3D false;

-       if (!amdgpu_check_soft_reset(adev)) {
+       if (!amdgpu_check_soft_reset(adev) && (adev->asic_type !=3D CHIP_VE=
GA10)) {
                 DRM_INFO("No hardware hang detected. Did some blocks stall=
?\n");
                 return 0;
         }
@@ -2910,6 +2910,10 @@ int amdgpu_gpu_reset(struct amdgpu_device *adev)

         need_full_reset =3D amdgpu_need_full_reset(adev);

+       /* no soft reset for vega10 right now*/
+       if (adev->asic_type =3D=3D CHIP_VEGA10)
+               need_full_reset =3D true;
+
         if (!need_full_reset) {
                 amdgpu_pre_soft_reset(adev);
                 r =3D amdgpu_soft_reset(adev);
@@ -2924,6 +2928,7 @@ int amdgpu_gpu_reset(struct amdgpu_device *adev)
                 r =3D amdgpu_suspend(adev);

 retry:
+
                 amdgpu_atombios_scratch_regs_save(adev);
                 r =3D amdgpu_asic_reset(adev);
                 amdgpu_atombios_scratch_regs_restore(adev);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_psp.c
index 8a1ee97..6942b89 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -62,6 +62,7 @@ static int psp_sw_init(void *handle)
                 psp->cmd_submit =3D psp_v3_1_cmd_submit;
                 psp->compare_sram_data =3D psp_v3_1_compare_sram_data;
                 psp->smu_reload_quirk =3D psp_v3_1_smu_reload_quirk;
+               psp->mode1_reset =3D psp_v3_1_mode1_reset;
                 break;
         case CHIP_RAVEN:
                 psp->init_microcode =3D psp_v10_0_init_microcode;
@@ -72,6 +73,7 @@ static int psp_sw_init(void *handle)
                 psp->ring_destroy =3D psp_v10_0_ring_destroy;
                 psp->cmd_submit =3D psp_v10_0_cmd_submit;
                 psp->compare_sram_data =3D psp_v10_0_compare_sram_data;
+               psp->mode1_reset =3D psp_v10_0_mode1_reset;
                 break;
         default:
                 return -EINVAL;
@@ -497,6 +499,12 @@ static int psp_resume(void *handle)
         return ret;
 }

+static int psp_reset(void* handle)
+{
+       struct amdgpu_device *adev =3D (struct amdgpu_device *)handle;
+       return psp_mode1_reset(&adev->psp);
+}
+
 static bool psp_check_fw_loading_status(struct amdgpu_device *adev,
                                         enum AMDGPU_UCODE_ID ucode_type)
 {
@@ -541,7 +549,7 @@ const struct amd_ip_funcs psp_ip_funcs =3D {
         .resume =3D psp_resume,
         .is_idle =3D NULL,
         .wait_for_idle =3D NULL,
-       .soft_reset =3D NULL,
+       .soft_reset =3D psp_reset,
         .set_clockgating_state =3D psp_set_clockgating_state,
         .set_powergating_state =3D psp_set_powergating_state,
 };
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_psp.h
index 1b7d12d..ce465455 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
@@ -76,6 +76,7 @@ struct psp_context
                                   struct amdgpu_firmware_info *ucode,
                                   enum AMDGPU_UCODE_ID ucode_type);
         bool (*smu_reload_quirk)(struct psp_context *psp);
+       int (*mode1_reset)(struct psp_context *psp);

         /* fence buffer */
         struct amdgpu_bo                 *fw_pri_bo;
@@ -139,6 +140,8 @@ struct amdgpu_psp_funcs {
                 ((psp)->bootloader_load_sos ? (psp)->bootloader_load_sos((=
psp)) : 0)
 #define psp_smu_reload_quirk(psp) \
                 ((psp)->smu_reload_quirk ? (psp)->smu_reload_quirk((psp)) =
: false)
+#define psp_mode1_reset(psp) \
+               ((psp)->mode1_reset ? (psp)->mode1_reset((psp)) : false)

 extern const struct amd_ip_funcs psp_ip_funcs;

diff --git a/drivers/gpu/drm/amd/amdgpu/psp_v10_0.c b/drivers/gpu/drm/amd/a=
mdgpu/psp_v10_0.c
index 6b324da..cbc43bb 100644
--- a/drivers/gpu/drm/amd/amdgpu/psp_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/psp_v10_0.c
@@ -406,3 +406,10 @@ bool psp_v10_0_compare_sram_data(struct psp_context *p=
sp,

         return true;
 }
+
+
+int psp_v10_0_mode1_reset(struct psp_context *psp)
+{
+       DRM_INFO("psp mode 1 reset not supported now! \n");
+       return -EINVAL;
+}
diff --git a/drivers/gpu/drm/amd/amdgpu/psp_v10_0.h b/drivers/gpu/drm/amd/a=
mdgpu/psp_v10_0.h
index 3af3ad1..451e830 100644
--- a/drivers/gpu/drm/amd/amdgpu/psp_v10_0.h
+++ b/drivers/gpu/drm/amd/amdgpu/psp_v10_0.h
@@ -45,4 +45,6 @@ extern int psp_v10_0_cmd_submit(struct psp_context *psp,
 extern bool psp_v10_0_compare_sram_data(struct psp_context *psp,
                                        struct amdgpu_firmware_info *ucode,
                                        enum AMDGPU_UCODE_ID ucode_type);
+
+extern int psp_v10_0_mode1_reset(struct psp_context *psp);
 #endif
diff --git a/drivers/gpu/drm/amd/amdgpu/psp_v3_1.c b/drivers/gpu/drm/amd/am=
dgpu/psp_v3_1.c
index eb73931..01a896e 100644
--- a/drivers/gpu/drm/amd/amdgpu/psp_v3_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/psp_v3_1.c
@@ -517,7 +517,7 @@ bool psp_v3_1_compare_sram_data(struct psp_context *psp=
,
                 ucode_size -=3D 4;
         }

-       return true;
+       return true;
 }

 bool psp_v3_1_smu_reload_quirk(struct psp_context *psp)
@@ -530,3 +530,37 @@ bool psp_v3_1_smu_reload_quirk(struct psp_context *psp=
)
         reg =3D RREG32_SOC15(NBIO, 0, mmPCIE_DATA2);
         return (reg & MP1_FIRMWARE_FLAGS__INTERRUPTS_ENABLED_MASK) ? true =
: false;
 }
+
+int psp_v3_1_mode1_reset(struct psp_context *psp)
+{
+       int ret;
+       uint32_t offset;
+       struct amdgpu_device *adev =3D psp->adev;
+
+       offset =3D SOC15_REG_OFFSET(MP0, 0, mmMP0_SMN_C2PMSG_64);
+
+       ret =3D psp_wait_for(psp, offset, 0x80000000, 0x8000FFFF, false);
+
+       if (ret) {
+               DRM_INFO("psp is not working correctly before mode1 reset!\=
n");
+               return -EINVAL;
+       }
+
+       /*send the mode 1 reset command*/
+       WREG32(offset, 0x70000);
+
+       mdelay(1000);
+
+       offset =3D SOC15_REG_OFFSET(MP0, 0, mmMP0_SMN_C2PMSG_33);
+
+       ret =3D psp_wait_for(psp, offset, 0x80000000, 0x80000000, false);
+
+       if (ret) {
+               DRM_INFO("psp mode 1 reset failed!\n");
+               return -EINVAL;
+       }
+
+       DRM_INFO("psp mode1 reset succeed \n");
+
+       return 0;
+}
diff --git a/drivers/gpu/drm/amd/amdgpu/psp_v3_1.h b/drivers/gpu/drm/amd/am=
dgpu/psp_v3_1.h
index 5af2231..b05dbad 100644
--- a/drivers/gpu/drm/amd/amdgpu/psp_v3_1.h
+++ b/drivers/gpu/drm/amd/amdgpu/psp_v3_1.h
@@ -53,4 +53,5 @@ extern bool psp_v3_1_compare_sram_data(struct psp_context=
 *psp,
                                        struct amdgpu_firmware_info *ucode,
                                        enum AMDGPU_UCODE_ID ucode_type);
 extern bool psp_v3_1_smu_reload_quirk(struct psp_context *psp);
+extern int psp_v3_1_mode1_reset(struct psp_context *psp);
 #endif
diff --git a/drivers/gpu/drm/amd/amdgpu/soc15.c b/drivers/gpu/drm/amd/amdgp=
u/soc15.c
index a74d616..190be09 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc15.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc15.c
@@ -407,18 +407,37 @@ static int soc15_read_register(struct amdgpu_device *=
adev, u32 se_num,
         return -EINVAL;
 }

-static void soc15_gpu_pci_config_reset(struct amdgpu_device *adev)
+static int soc15_asic_reset(struct amdgpu_device *adev)
 {
         u32 i;
+       u32 *pci_regs;
+
+       pci_regs =3D kmalloc(128 * sizeof(u32), GFP_KERNEL);
+
+       if (pci_regs =3D=3D NULL)
+               return -EINVAL;
+
+       amdgpu_atombios_scratch_regs_engine_hung(adev, true);

-       dev_info(adev->dev, "GPU pci config reset\n");
+       dev_info(adev->dev, "GPU reset\n");

         /* disable BM */
         pci_clear_master(adev->pdev);
-       /* reset */
-       amdgpu_pci_config_reset(adev);

-       udelay(100);
+       for (i =3D 0; i < 128; i++) {
+               pci_read_config_dword(adev->pdev, i*4, &pci_regs[i]);
+       }
+
+       for (i =3D 0; i < AMDGPU_MAX_IP_NUM; i++) {
+               if (adev->ip_blocks[i].version->type =3D=3D AMD_IP_BLOCK_TY=
PE_PSP){
+                       adev->ip_blocks[i].version->funcs->soft_reset((void=
 *)adev);
+                       break;
+               }
+       }
+
+       for (i =3D 0; i < 128; i++) {
+               pci_write_config_dword(adev->pdev, i*4, pci_regs[i]);
+       }

         /* wait for asic to come out of reset */
         for (i =3D 0; i < adev->usec_timeout; i++) {
@@ -430,16 +449,10 @@ static void soc15_gpu_pci_config_reset(struct amdgpu_=
device *adev)
                 udelay(1);
         }

-}
-
-static int soc15_asic_reset(struct amdgpu_device *adev)
-{
-       amdgpu_atombios_scratch_regs_engine_hung(adev, true);
-
-       soc15_gpu_pci_config_reset(adev);
-
         amdgpu_atombios_scratch_regs_engine_hung(adev, false);

+       kfree(pci_regs);
+
         return 0;
 }

--
2.7.4


--_000_CY1PR12MB04747E37CAE70D12509984C98C6C0CY1PR12MB0474namp_
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
<p><br>
</p>
<br>
<br>
<div style=3D"color: rgb(0, 0, 0);">
<div>
<hr tabindex=3D"-1" style=3D"display:inline-block; width:98%">
<div id=3D"x_divRplyFwdMsg" dir=3D"ltr"><font style=3D"font-size:11pt" face=
=3D"Calibri, sans-serif" color=3D"#000000"><b>From:</b> Ken.Wang-5C7GfCeVMHo@public.gmane.org &l=
t;Ken.Wang-5C7GfCeVMHo@public.gmane.org&gt;<br>
<b>Sent:</b> Friday, September 15, 2017 14:57<br>
<b>To:</b> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
<b>Cc:</b> Wang, Ken<br>
<b>Subject:</b> [PATCH] drm/amdgpu: Add GPU reset functionality for Vega10<=
/font>
<div>&nbsp;</div>
</div>
</div>
<font size=3D"2"><span style=3D"font-size:10pt;">
<div class=3D"PlainText">From: Ken Wang &lt;Ken.Wang-5C7GfCeVMHo@public.gmane.org&gt;<br>
<br>
Signed-off-by: Ken Wang &lt;Ken.Wang-5C7GfCeVMHo@public.gmane.org&gt;<br>
Change-Id: I6fd2c216a84747313f18db25a444be5ed43b4f4b<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_device.c |&nbsp; 7 &#43;&#43;&#43;&=
#43;&#43;-<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c&nbsp;&nbsp;&nbsp; | 10 &#43;&=
#43;&#43;&#43;&#43;&#43;&#43;-<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h&nbsp;&nbsp;&nbsp; |&nbsp; 3 &=
#43;&#43;&#43;<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/psp_v10_0.c&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp=
; 7 &#43;&#43;&#43;&#43;&#43;&#43;<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/psp_v10_0.h&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp=
; 2 &#43;&#43;<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/psp_v3_1.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |=
 36 &#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&=
#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;-<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/psp_v3_1.h&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |=
&nbsp; 1 &#43;<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/soc15.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; | 39 &#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&=
#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;----------<br>
&nbsp;8 files changed, 89 insertions(&#43;), 16 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_device.c<br>
index fc1c5437..4196786 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<br>
@@ -2883,7 &#43;2883,7 @@ int amdgpu_gpu_reset(struct amdgpu_device *adev)<=
br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int resched;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool need_full_reset, vram=
_lost =3D false;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!amdgpu_check_soft_reset(adev)) {=
<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!amdgpu_check_soft_reset(adev=
) &amp;&amp; (adev-&gt;asic_type !=3D CHIP_VEGA10)) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; DRM_INFO(&quot;No hardware hang detected. Did some bl=
ocks stall?\n&quot;);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return 0;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
@@ -2910,6 &#43;2910,10 @@ int amdgpu_gpu_reset(struct amdgpu_device *adev)=
<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; need_full_reset =3D amdgpu=
_need_full_reset(adev);<br>
&nbsp;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* no soft reset for vega10 right=
 now*/<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;asic_type =3D=3D CHI=
P_VEGA10)<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; need_full_reset =3D true;<br>
&#43;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!need_full_reset) {<br=
>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; amdgpu_pre_soft_reset(adev);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; r =3D amdgpu_soft_reset(adev);<br>
@@ -2924,6 &#43;2928,7 @@ int amdgpu_gpu_reset(struct amdgpu_device *adev)<=
br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; r =3D amdgpu_suspend(adev);<br>
&nbsp;<br>
&nbsp;retry:<br>
&#43;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; amdgpu_atombios_scratch_regs_save(adev);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; r =3D amdgpu_asic_reset(adev);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; amdgpu_atombios_scratch_regs_restore(adev);<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_psp.c<br>
index 8a1ee97..6942b89 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c<br>
@@ -62,6 &#43;62,7 @@ static int psp_sw_init(void *handle)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; psp-&gt;cmd_submit =3D psp_v3_1_cmd_submit;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; psp-&gt;compare_sram_data =3D psp_v3_1_compare_sram_d=
ata;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; psp-&gt;smu_reload_quirk =3D psp_v3_1_smu_reload_quir=
k;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; psp-&gt;mode1_reset =3D psp_v3_1_mode1_reset;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; break;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case CHIP_RAVEN:<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; psp-&gt;init_microcode =3D psp_v10_0_init_microcode;<=
br>
@@ -72,6 &#43;73,7 @@ static int psp_sw_init(void *handle)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; psp-&gt;ring_destroy =3D psp_v10_0_ring_destroy;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; psp-&gt;cmd_submit =3D psp_v10_0_cmd_submit;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; psp-&gt;compare_sram_data =3D psp_v10_0_compare_sram_=
data;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; psp-&gt;mode1_reset =3D psp_v10_0_mode1_reset;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; break;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; default:<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return -EINVAL;<br>
@@ -497,6 &#43;499,12 @@ static int psp_resume(void *handle)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret;<br>
&nbsp;}<br>
&nbsp;<br>
&#43;static int psp_reset(void* handle)<br>
&#43;{<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev =3D (s=
truct amdgpu_device *)handle;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return psp_mode1_reset(&amp;adev-=
&gt;psp);<br>
&#43;}<br>
&#43;<br>
&nbsp;static bool psp_check_fw_loading_status(struct amdgpu_device *adev,<b=
r>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; enum AMDGPU_UCODE_ID ucode_type)<br>
&nbsp;{<br>
@@ -541,7 &#43;549,7 @@ const struct amd_ip_funcs psp_ip_funcs =3D {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .resume =3D psp_resume,<br=
>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .is_idle =3D NULL,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .wait_for_idle =3D NULL,<b=
r>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .soft_reset =3D NULL,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .soft_reset =3D psp_reset,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .set_clockgating_state =3D=
 psp_set_clockgating_state,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .set_powergating_state =3D=
 psp_set_powergating_state,<br>
&nbsp;};<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_psp.h<br>
index 1b7d12d..ce465455 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h<br>
@@ -76,6 &#43;76,7 @@ struct psp_context<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_firmwa=
re_info *ucode,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; enum AMDGPU_UCODE_ID=
 ucode_type);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool (*smu_reload_quirk)(s=
truct psp_context *psp);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int (*mode1_reset)(struct psp_con=
text *psp);<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* fence buffer */<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_bo&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; *fw_pri_bo;<br>
@@ -139,6 &#43;140,8 @@ struct amdgpu_psp_funcs {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; ((psp)-&gt;bootloader_load_sos ? (psp)-&gt;bootloader=
_load_sos((psp)) : 0)<br>
&nbsp;#define psp_smu_reload_quirk(psp) \<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; ((psp)-&gt;smu_reload_quirk ? (psp)-&gt;smu_reload_qu=
irk((psp)) : false)<br>
&#43;#define psp_mode1_reset(psp) \<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; ((psp)-&gt;mode1_reset ? (psp)-&gt;mode1_reset((psp)) : fals=
e)<br>
&nbsp;<br>
&nbsp;extern const struct amd_ip_funcs psp_ip_funcs;<br>
&nbsp;<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/psp_v10_0.c b/drivers/gpu/drm/amd/a=
mdgpu/psp_v10_0.c<br>
index 6b324da..cbc43bb 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/psp_v10_0.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/psp_v10_0.c<br>
@@ -406,3 &#43;406,10 @@ bool psp_v10_0_compare_sram_data(struct psp_contex=
t *psp,<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return true;<br>
&nbsp;}<br>
&#43;<br>
&#43;<br>
&#43;int psp_v10_0_mode1_reset(struct psp_context *psp)<br>
&#43;{<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DRM_INFO(&quot;psp mode 1 reset n=
ot supported now! \n&quot;);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return -EINVAL;<br>
&#43;}<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/psp_v10_0.h b/drivers/gpu/drm/amd/a=
mdgpu/psp_v10_0.h<br>
index 3af3ad1..451e830 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/psp_v10_0.h<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/psp_v10_0.h<br>
@@ -45,4 &#43;45,6 @@ extern int psp_v10_0_cmd_submit(struct psp_context *p=
sp,<br>
&nbsp;extern bool psp_v10_0_compare_sram_data(struct psp_context *psp,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp; struct amdgpu_firmware_info *ucode,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp; enum AMDGPU_UCODE_ID ucode_type);<br>
&#43;<br>
&#43;extern int psp_v10_0_mode1_reset(struct psp_context *psp);<br>
&nbsp;#endif<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/psp_v3_1.c b/drivers/gpu/drm/amd/am=
dgpu/psp_v3_1.c<br>
index eb73931..01a896e 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/psp_v3_1.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/psp_v3_1.c<br>
@@ -517,7 &#43;517,7 @@ bool psp_v3_1_compare_sram_data(struct psp_context =
*psp,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; ucode_size -=3D 4;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return true;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return true; <br>
&nbsp;}<br>
&nbsp;<br>
&nbsp;bool psp_v3_1_smu_reload_quirk(struct psp_context *psp)<br>
@@ -530,3 &#43;530,37 @@ bool psp_v3_1_smu_reload_quirk(struct psp_context =
*psp)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; reg =3D RREG32_SOC15(NBIO,=
 0, mmPCIE_DATA2);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return (reg &amp; MP1_FIRM=
WARE_FLAGS__INTERRUPTS_ENABLED_MASK) ? true : false;<br>
&nbsp;}<br>
&#43;<br>
&#43;int psp_v3_1_mode1_reset(struct psp_context *psp)<br>
&#43;{<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ret;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t offset;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev =3D ps=
p-&gt;adev;<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; offset =3D SOC15_REG_OFFSET(MP0, =
0, mmMP0_SMN_C2PMSG_64);<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D psp_wait_for(psp, offset,=
 0x80000000, 0x8000FFFF, false);<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret) {<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; DRM_INFO(&quot;psp is not working correctly before mode1 res=
et!\n&quot;);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; return -EINVAL;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /*send the mode 1 reset command*/=
<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32(offset, 0x70000);<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mdelay(1000);<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; offset =3D SOC15_REG_OFFSET(MP0, =
0, mmMP0_SMN_C2PMSG_33);<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D psp_wait_for(psp, offset,=
 0x80000000, 0x80000000, false);<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret) {<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; DRM_INFO(&quot;psp mode 1 reset failed!\n&quot;);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; return -EINVAL;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DRM_INFO(&quot;psp mode1 reset su=
cceed \n&quot;);<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&#43;}<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/psp_v3_1.h b/drivers/gpu/drm/amd/am=
dgpu/psp_v3_1.h<br>
index 5af2231..b05dbad 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/psp_v3_1.h<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/psp_v3_1.h<br>
@@ -53,4 &#43;53,5 @@ extern bool psp_v3_1_compare_sram_data(struct psp_con=
text *psp,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp; struct amdgpu_firmware_info *ucode,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp; enum AMDGPU_UCODE_ID ucode_type);<br>
&nbsp;extern bool psp_v3_1_smu_reload_quirk(struct psp_context *psp);<br>
&#43;extern int psp_v3_1_mode1_reset(struct psp_context *psp);<br>
&nbsp;#endif<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/soc15.c b/drivers/gpu/drm/amd/amdgp=
u/soc15.c<br>
index a74d616..190be09 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/soc15.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/soc15.c<br>
@@ -407,18 &#43;407,37 @@ static int soc15_read_register(struct amdgpu_devi=
ce *adev, u32 se_num,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return -EINVAL;<br>
&nbsp;}<br>
&nbsp;<br>
-static void soc15_gpu_pci_config_reset(struct amdgpu_device *adev)<br>
&#43;static int soc15_asic_reset(struct amdgpu_device *adev)<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u32 i;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u32 *pci_regs;<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pci_regs =3D kmalloc(128 * sizeof=
(u32), GFP_KERNEL);<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (pci_regs =3D=3D NULL)<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; return -EINVAL;<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_atombios_scratch_regs_engi=
ne_hung(adev, true);<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dev_info(adev-&gt;dev, &quot;GPU pci =
config reset\n&quot;);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dev_info(adev-&gt;dev, &quot;GPU =
reset\n&quot;);<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* disable BM */<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pci_clear_master(adev-&gt;=
pdev);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* reset */<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_pci_config_reset(adev);<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; udelay(100);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (i =3D 0; i &lt; 128; i&#43;&=
#43;) {<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; pci_read_config_dword(adev-&gt;pdev, i*4, &amp;pci_regs[i]);=
<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (i =3D 0; i &lt; AMDGPU_MAX_I=
P_NUM; i&#43;&#43;) {<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; if (adev-&gt;ip_blocks[i].version-&gt;type =3D=3D AMD_IP_BLO=
CK_TYPE_PSP){<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;ip_=
blocks[i].version-&gt;funcs-&gt;soft_reset((void *)adev);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; }<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (i =3D 0; i &lt; 128; i&#43;&=
#43;) {<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; pci_write_config_dword(adev-&gt;pdev, i*4, pci_regs[i]);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* wait for asic to come o=
ut of reset */<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (i =3D 0; i &lt; adev-=
&gt;usec_timeout; i&#43;&#43;) {<br>
@@ -430,16 &#43;449,10 @@ static void soc15_gpu_pci_config_reset(struct amd=
gpu_device *adev)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; udelay(1);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
-}<br>
-<br>
-static int soc15_asic_reset(struct amdgpu_device *adev)<br>
-{<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_atombios_scratch_regs_engine_h=
ung(adev, true);<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; soc15_gpu_pci_config_reset(adev);<br>
-<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_atombios_scratch_re=
gs_engine_hung(adev, false);<br>
&nbsp;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kfree(pci_regs);<br>
&#43;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&nbsp;}<br>
&nbsp;<br>
-- <br>
2.7.4<br>
<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_CY1PR12MB04747E37CAE70D12509984C98C6C0CY1PR12MB0474namp_--

--===============1893325554==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============1893325554==--
