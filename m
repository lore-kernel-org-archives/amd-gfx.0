From: "Francis, David" <David.Francis-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH] drm/amd: Add DMCU firmware loading on raven
Date: Fri, 7 Sep 2018 14:26:59 +0000
Message-ID: <DM3PR1201MB103921CD29A1AA63F57BC2D7EF000@DM3PR1201MB1039.namprd12.prod.outlook.com>
References: <20180907141656.10673-1-David.Francis@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1140013535=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20180907141656.10673-1-David.Francis-5C7GfCeVMHo@public.gmane.org>
Content-Language: en-CA
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

--===============1140013535==
Content-Language: en-CA
Content-Type: multipart/alternative;
	boundary="_000_DM3PR1201MB103921CD29A1AA63F57BC2D7EF000DM3PR1201MB1039_"

--_000_DM3PR1201MB103921CD29A1AA63F57BC2D7EF000DM3PR1201MB1039_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

This will cause amdgpu startup to fail if the firmware does not exist: this=
 should either wait until the firmware is available or not return an error =
value if -ENOENT is returned from request_firmware

________________________________
From: David Francis <David.Francis-5C7GfCeVMHo@public.gmane.org>
Sent: September 7, 2018 10:16:56 AM
To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Cc: Francis, David
Subject: [PATCH] drm/amd: Add DMCU firmware loading on raven

[Why]
DMCU (Display MicroController Unit) is an on-GPU microcontroller
in AMD graphics cards that is used in features for
embedded displays such as Panel Self-Refresh

DMCU is part of the DM IP block

[How]
DMCU is added as an option in the enum AMDGPU_UCODE_ID

DMCU needs two pieces of firmware - the initial eram and the
interrupt vectors.  These are treated as seperate pieces of
firmware and loaded by PSP

The loading occurs in the sw_init hook of DM

Signed-off-by: David Francis <David.Francis-5C7GfCeVMHo@public.gmane.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.h     |  2 +
 drivers/gpu/drm/amd/amdgpu/psp_v10_0.c        |  6 ++
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 93 +++++++++++++++++++
 3 files changed, 101 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.h b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_ucode.h
index b358e7519987..38d3af317aa2 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.h
@@ -196,6 +196,8 @@ enum AMDGPU_UCODE_ID {
         AMDGPU_UCODE_ID_UVD1,
         AMDGPU_UCODE_ID_VCE,
         AMDGPU_UCODE_ID_VCN,
+       AMDGPU_UCODE_ID_DMCU_ERAM,
+       AMDGPU_UCODE_ID_DMCU_INTV,
         AMDGPU_UCODE_ID_MAXIMUM,
 };

diff --git a/drivers/gpu/drm/amd/amdgpu/psp_v10_0.c b/drivers/gpu/drm/amd/a=
mdgpu/psp_v10_0.c
index 02be34e72ed9..240dc8c85867 100644
--- a/drivers/gpu/drm/amd/amdgpu/psp_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/psp_v10_0.c
@@ -91,6 +91,12 @@ psp_v10_0_get_fw_type(struct amdgpu_firmware_info *ucode=
, enum psp_gfx_fw_type *
         case AMDGPU_UCODE_ID_VCN:
                 *type =3D GFX_FW_TYPE_VCN;
                 break;
+       case AMDGPU_UCODE_ID_DMCU_ERAM:
+               *type =3D GFX_FW_TYPE_DMCU_ERAM;
+               break;
+       case AMDGPU_UCODE_ID_DMCU_INTV:
+               *type =3D GFX_FW_TYPE_DMCU_ISR;
+               break;
         case AMDGPU_UCODE_ID_MAXIMUM:
         default:
                 return -EINVAL;
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gp=
u/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 5103eba75cb3..4619f624f346 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -30,6 +30,7 @@
 #include "vid.h"
 #include "amdgpu.h"
 #include "amdgpu_display.h"
+#include "amdgpu_ucode.h"
 #include "atom.h"
 #include "amdgpu_dm.h"
 #include "amdgpu_pm.h"
@@ -50,6 +51,7 @@
 #include <linux/version.h>
 #include <linux/types.h>
 #include <linux/pm_runtime.h>
+#include <linux/firmware.h>

 #include <drm/drmP.h>
 #include <drm/drm_atomic.h>
@@ -71,6 +73,12 @@

 #include "modules/inc/mod_freesync.h"

+#define FIRMWARE_RAVEN_DMCU_ERAM               "amdgpu/raven_dmcu_eram.bin=
"
+MODULE_FIRMWARE(FIRMWARE_RAVEN_DMCU_ERAM);
+
+#define FIRMWARE_RAVEN_DMCU_INTV               "amdgpu/raven_dmcu_intv.bin=
"
+MODULE_FIRMWARE(FIRMWARE_RAVEN_DMCU_INTV);
+
 /* basic init/fini API */
 static int amdgpu_dm_init(struct amdgpu_device *adev);
 static void amdgpu_dm_fini(struct amdgpu_device *adev);
@@ -516,6 +524,91 @@ static void amdgpu_dm_fini(struct amdgpu_device *adev)

 static int dm_sw_init(void *handle)
 {
+       const struct firmware *fw;
+       const char *fw_name_dmcu_eram;
+       const char *fw_name_dmcu_intv;
+       struct amdgpu_device *adev =3D (struct amdgpu_device *)handle;
+       int r;
+
+       switch(adev->asic_type) {
+       case CHIP_BONAIRE:
+       case CHIP_HAWAII:
+       case CHIP_KAVERI:
+       case CHIP_KABINI:
+       case CHIP_MULLINS:
+       case CHIP_TONGA:
+       case CHIP_FIJI:
+       case CHIP_CARRIZO:
+       case CHIP_STONEY:
+       case CHIP_POLARIS11:
+       case CHIP_POLARIS10:
+       case CHIP_POLARIS12:
+       case CHIP_VEGAM:
+       case CHIP_VEGA10:
+       case CHIP_VEGA12:
+       case CHIP_VEGA20:
+               return 0;
+       case CHIP_RAVEN:
+               fw_name_dmcu_eram =3D FIRMWARE_RAVEN_DMCU_ERAM;
+               fw_name_dmcu_intv =3D FIRMWARE_RAVEN_DMCU_INTV;
+               break;
+       default:
+               DRM_ERROR("Unsupported ASIC type: 0x%X\n", adev->asic_type)=
;
+               return -1;
+       }
+
+       r =3D request_firmware(&fw, fw_name_dmcu_eram, adev->dev);
+       if (r) {
+               dev_err(adev->dev, "amdgpu_dm: Can't load firmware \"%s\"\n=
",
+                       fw_name_dmcu_eram);
+               return r;
+       }
+
+       r =3D amdgpu_ucode_validate(fw);
+       if (r) {
+               dev_err(adev->dev, "amdgpu_dm: Can't validate firmware \"%s=
\"\n",
+                       fw_name_dmcu_eram);
+               release_firmware(fw);
+               fw =3D NULL;
+               return r;
+       }
+
+       if (adev->firmware.load_type =3D=3D AMDGPU_FW_LOAD_PSP) {
+               const struct common_firmware_header *hdr;
+               hdr =3D (const struct common_firmware_header *)fw->data;
+               adev->firmware.ucode[AMDGPU_UCODE_ID_DMCU_ERAM].ucode_id =
=3D AMDGPU_UCODE_ID_DMCU_ERAM;
+               adev->firmware.ucode[AMDGPU_UCODE_ID_DMCU_ERAM].fw =3D fw;
+               adev->firmware.fw_size +=3D
+                       ALIGN(le32_to_cpu(hdr->ucode_size_bytes), PAGE_SIZE=
);
+               DRM_INFO("PSP loading DMCU_ERAM firmware\n");
+       }
+
+       r =3D request_firmware(&fw, fw_name_dmcu_intv, adev->dev);
+       if (r) {
+               dev_err(adev->dev, "amdgpu_dm: Can't load firmware \"%s\"\n=
",
+                               fw_name_dmcu_intv);
+               return r;
+       }
+
+       r =3D amdgpu_ucode_validate(fw);
+       if (r) {
+               dev_err(adev->dev, "amdgpu_dm: Can't validate firmware \"%s=
\"\n",
+                               fw_name_dmcu_intv);
+               release_firmware(fw);
+               fw =3D NULL;
+               return r;
+       }
+
+       if (adev->firmware.load_type =3D=3D AMDGPU_FW_LOAD_PSP) {
+               const struct common_firmware_header *hdr;
+               hdr =3D (const struct common_firmware_header *)fw->data;
+               adev->firmware.ucode[AMDGPU_UCODE_ID_DMCU_INTV].ucode_id =
=3D AMDGPU_UCODE_ID_DMCU_INTV;
+               adev->firmware.ucode[AMDGPU_UCODE_ID_DMCU_INTV].fw =3D fw;
+               adev->firmware.fw_size +=3D
+                       ALIGN(le32_to_cpu(hdr->ucode_size_bytes), PAGE_SIZE=
);
+               DRM_INFO("PSP loading DMCU_INTV firmware\n");
+       }
+
         return 0;
 }

--
2.17.1


--_000_DM3PR1201MB103921CD29A1AA63F57BC2D7EF000DM3PR1201MB1039_
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
<p style=3D"margin-top:0;margin-bottom:0">This will cause amdgpu startup to=
 fail if the firmware does not exist: this should either wait until the&nbs=
p;firmware is available or not return an error value if -<span>ENOENT is re=
turned from request_firmware</span></p>
</div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> David Francis &lt;Dav=
id.Francis-5C7GfCeVMHo@public.gmane.org&gt;<br>
<b>Sent:</b> September 7, 2018 10:16:56 AM<br>
<b>To:</b> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
<b>Cc:</b> Francis, David<br>
<b>Subject:</b> [PATCH] drm/amd: Add DMCU firmware loading on raven</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">[Why]<br>
DMCU (Display MicroController Unit) is an on-GPU microcontroller<br>
in AMD graphics cards that is used in features for<br>
embedded displays such as Panel Self-Refresh<br>
<br>
DMCU is part of the DM IP block<br>
<br>
[How]<br>
DMCU is added as an option in the enum AMDGPU_UCODE_ID<br>
<br>
DMCU needs two pieces of firmware - the initial eram and the<br>
interrupt vectors.&nbsp; These are treated as seperate pieces of<br>
firmware and loaded by PSP<br>
<br>
The loading occurs in the sw_init hook of DM<br>
<br>
Signed-off-by: David Francis &lt;David.Francis-5C7GfCeVMHo@public.gmane.org&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.h&nbsp;&nbsp;&nbsp;&nbsp; |&n=
bsp; 2 &#43;<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/psp_v10_0.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; |&nbsp; 6 &#43;&#43;<br>
&nbsp;.../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 93 &#43;&#43;&#43;&#4=
3;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#4=
3;<br>
&nbsp;3 files changed, 101 insertions(&#43;)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.h b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_ucode.h<br>
index b358e7519987..38d3af317aa2 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.h<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.h<br>
@@ -196,6 &#43;196,8 @@ enum AMDGPU_UCODE_ID {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMDGPU_UCODE_ID_UVD1,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMDGPU_UCODE_ID_VCE,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMDGPU_UCODE_ID_VCN,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMDGPU_UCODE_ID_DMCU_ERAM,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMDGPU_UCODE_ID_DMCU_INTV,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMDGPU_UCODE_ID_MAXIMUM,<b=
r>
&nbsp;};<br>
&nbsp;<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/psp_v10_0.c b/drivers/gpu/drm/amd/a=
mdgpu/psp_v10_0.c<br>
index 02be34e72ed9..240dc8c85867 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/psp_v10_0.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/psp_v10_0.c<br>
@@ -91,6 &#43;91,12 @@ psp_v10_0_get_fw_type(struct amdgpu_firmware_info *u=
code, enum psp_gfx_fw_type *<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case AMDGPU_UCODE_ID_VCN:<=
br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; *type =3D GFX_FW_TYPE_VCN;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; break;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case AMDGPU_UCODE_ID_DMCU_ERAM:<b=
r>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; *type =3D GFX_FW_TYPE_DMCU_ERAM;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; break;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case AMDGPU_UCODE_ID_DMCU_INTV:<b=
r>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; *type =3D GFX_FW_TYPE_DMCU_ISR;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; break;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case AMDGPU_UCODE_ID_MAXIM=
UM:<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; default:<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return -EINVAL;<br>
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gp=
u/drm/amd/display/amdgpu_dm/amdgpu_dm.c<br>
index 5103eba75cb3..4619f624f346 100644<br>
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c<br>
@@ -30,6 &#43;30,7 @@<br>
&nbsp;#include &quot;vid.h&quot;<br>
&nbsp;#include &quot;amdgpu.h&quot;<br>
&nbsp;#include &quot;amdgpu_display.h&quot;<br>
&#43;#include &quot;amdgpu_ucode.h&quot;<br>
&nbsp;#include &quot;atom.h&quot;<br>
&nbsp;#include &quot;amdgpu_dm.h&quot;<br>
&nbsp;#include &quot;amdgpu_pm.h&quot;<br>
@@ -50,6 &#43;51,7 @@<br>
&nbsp;#include &lt;linux/version.h&gt;<br>
&nbsp;#include &lt;linux/types.h&gt;<br>
&nbsp;#include &lt;linux/pm_runtime.h&gt;<br>
&#43;#include &lt;linux/firmware.h&gt;<br>
&nbsp;<br>
&nbsp;#include &lt;drm/drmP.h&gt;<br>
&nbsp;#include &lt;drm/drm_atomic.h&gt;<br>
@@ -71,6 &#43;73,12 @@<br>
&nbsp;<br>
&nbsp;#include &quot;modules/inc/mod_freesync.h&quot;<br>
&nbsp;<br>
&#43;#define FIRMWARE_RAVEN_DMCU_ERAM&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;amdgpu/raven_dmcu_eram=
.bin&quot;<br>
&#43;MODULE_FIRMWARE(FIRMWARE_RAVEN_DMCU_ERAM);<br>
&#43;<br>
&#43;#define FIRMWARE_RAVEN_DMCU_INTV&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;amdgpu/raven_dmcu_intv=
.bin&quot;<br>
&#43;MODULE_FIRMWARE(FIRMWARE_RAVEN_DMCU_INTV);<br>
&#43;<br>
&nbsp;/* basic init/fini API */<br>
&nbsp;static int amdgpu_dm_init(struct amdgpu_device *adev);<br>
&nbsp;static void amdgpu_dm_fini(struct amdgpu_device *adev);<br>
@@ -516,6 &#43;524,91 @@ static void amdgpu_dm_fini(struct amdgpu_device *a=
dev)<br>
&nbsp;<br>
&nbsp;static int dm_sw_init(void *handle)<br>
&nbsp;{<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; const struct firmware *fw;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; const char *fw_name_dmcu_eram;<br=
>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; const char *fw_name_dmcu_intv;<br=
>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev =3D (s=
truct amdgpu_device *)handle;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int r;<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch(adev-&gt;asic_type) {<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case CHIP_BONAIRE:<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case CHIP_HAWAII:<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case CHIP_KAVERI:<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case CHIP_KABINI:<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case CHIP_MULLINS:<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case CHIP_TONGA:<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case CHIP_FIJI:<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case CHIP_CARRIZO:<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case CHIP_STONEY:<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case CHIP_POLARIS11:<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case CHIP_POLARIS10:<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case CHIP_POLARIS12:<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case CHIP_VEGAM:<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case CHIP_VEGA10:<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case CHIP_VEGA12:<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case CHIP_VEGA20:<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; return 0;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case CHIP_RAVEN:<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; fw_name_dmcu_eram =3D FIRMWARE_RAVEN_DMCU_ERAM;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; fw_name_dmcu_intv =3D FIRMWARE_RAVEN_DMCU_INTV;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; break;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; default:<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; DRM_ERROR(&quot;Unsupported ASIC type: 0x%X\n&quot;, adev-&g=
t;asic_type);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; return -1;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r =3D request_firmware(&amp;fw, f=
w_name_dmcu_eram, adev-&gt;dev);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (r) {<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; dev_err(adev-&gt;dev, &quot;amdgpu_dm: Can't load firmware \=
&quot;%s\&quot;\n&quot;,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; fw_name_dmcu=
_eram);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; return r;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r =3D amdgpu_ucode_validate(fw);<=
br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (r) {<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; dev_err(adev-&gt;dev, &quot;amdgpu_dm: Can't validate firmwa=
re \&quot;%s\&quot;\n&quot;,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; fw_name_dmcu=
_eram);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; release_firmware(fw);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; fw =3D NULL;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; return r;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;firmware.load_type =
=3D=3D AMDGPU_FW_LOAD_PSP) {<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; const struct common_firmware_header *hdr;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; hdr =3D (const struct common_firmware_header *)fw-&gt;data;<=
br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; adev-&gt;firmware.ucode[AMDGPU_UCODE_ID_DMCU_ERAM].ucode_id =
=3D AMDGPU_UCODE_ID_DMCU_ERAM;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; adev-&gt;firmware.ucode[AMDGPU_UCODE_ID_DMCU_ERAM].fw =3D fw=
;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; adev-&gt;firmware.fw_size &#43;=3D<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ALIGN(le32_t=
o_cpu(hdr-&gt;ucode_size_bytes), PAGE_SIZE);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; DRM_INFO(&quot;PSP loading DMCU_ERAM firmware\n&quot;);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r =3D request_firmware(&amp;fw, f=
w_name_dmcu_intv, adev-&gt;dev);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (r) {<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; dev_err(adev-&gt;dev, &quot;amdgpu_dm: Can't load firmware \=
&quot;%s\&quot;\n&quot;,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; fw_name_dmcu_intv);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; return r;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r =3D amdgpu_ucode_validate(fw);<=
br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (r) {<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; dev_err(adev-&gt;dev, &quot;amdgpu_dm: Can't validate firmwa=
re \&quot;%s\&quot;\n&quot;,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; fw_name_dmcu_intv);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; release_firmware(fw);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; fw =3D NULL;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; return r;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;firmware.load_type =
=3D=3D AMDGPU_FW_LOAD_PSP) {<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; const struct common_firmware_header *hdr;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; hdr =3D (const struct common_firmware_header *)fw-&gt;data;<=
br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; adev-&gt;firmware.ucode[AMDGPU_UCODE_ID_DMCU_INTV].ucode_id =
=3D AMDGPU_UCODE_ID_DMCU_INTV;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; adev-&gt;firmware.ucode[AMDGPU_UCODE_ID_DMCU_INTV].fw =3D fw=
;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; adev-&gt;firmware.fw_size &#43;=3D<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ALIGN(le32_t=
o_cpu(hdr-&gt;ucode_size_bytes), PAGE_SIZE);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; DRM_INFO(&quot;PSP loading DMCU_INTV firmware\n&quot;);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&#43;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&nbsp;}<br>
&nbsp;<br>
-- <br>
2.17.1<br>
<br>
</div>
</span></font></div>
</body>
</html>

--_000_DM3PR1201MB103921CD29A1AA63F57BC2D7EF000DM3PR1201MB1039_--

--===============1140013535==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============1140013535==--
