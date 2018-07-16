From: "Zhu, Rex" <Rex.Zhu-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH 3/3] drm/amdgpu/pp: switch smu callback type for
 get_argument()
Date: Mon, 16 Jul 2018 15:51:09 +0000
Message-ID: <CY4PR12MB1687613EDDFEFDB4607E867AFB5D0@CY4PR12MB1687.namprd12.prod.outlook.com>
References: <20180712202306.26762-1-alexander.deucher@amd.com>,
 <20180712202306.26762-3-alexander.deucher@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1448867337=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20180712202306.26762-3-alexander.deucher-5C7GfCeVMHo@public.gmane.org>
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
To: "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>

--===============1448867337==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_CY4PR12MB1687613EDDFEFDB4607E867AFB5D0CY4PR12MB1687namp_"

--_000_CY4PR12MB1687613EDDFEFDB4607E867AFB5D0CY4PR12MB1687namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Series is:

Reviewed-by: Rex Zhu<rezhu-5C7GfCeVMHo@public.gmane.org<mailto:rezhu-5C7GfCeVMHo@public.gmane.org>>



Best Regards

Rex


?? Outlook for Android<https://aka.ms/ghei36>

________________________________
From: amd-gfx <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org> on behalf of Alex Deu=
cher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sent: Friday, July 13, 2018 4:23:06 AM
To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Cc: Deucher, Alexander
Subject: [PATCH 3/3] drm/amdgpu/pp: switch smu callback type for get_argume=
nt()

return a uint32_t rather than an int to properly reflect
what the function does.

Signed-off-by: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>
---
 drivers/gpu/drm/amd/powerplay/inc/hwmgr.h           | 2 +-
 drivers/gpu/drm/amd/powerplay/inc/smumgr.h          | 2 +-
 drivers/gpu/drm/amd/powerplay/smumgr/smu10_smumgr.c | 2 +-
 drivers/gpu/drm/amd/powerplay/smumgr/smu8_smumgr.c  | 4 ++--
 drivers/gpu/drm/amd/powerplay/smumgr/smu9_smumgr.c  | 2 +-
 drivers/gpu/drm/amd/powerplay/smumgr/smu9_smumgr.h  | 2 +-
 drivers/gpu/drm/amd/powerplay/smumgr/smumgr.c       | 2 +-
 7 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/powerplay/inc/hwmgr.h b/drivers/gpu/drm/am=
d/powerplay/inc/hwmgr.h
index b3363f26039a..d3d96260f440 100644
--- a/drivers/gpu/drm/amd/powerplay/inc/hwmgr.h
+++ b/drivers/gpu/drm/amd/powerplay/inc/hwmgr.h
@@ -194,7 +194,7 @@ struct pp_smumgr_func {
         int (*request_smu_load_fw)(struct pp_hwmgr  *hwmgr);
         int (*request_smu_load_specific_fw)(struct pp_hwmgr  *hwmgr,
                                             uint32_t firmware);
-       int (*get_argument)(struct pp_hwmgr  *hwmgr);
+       uint32_t (*get_argument)(struct pp_hwmgr  *hwmgr);
         int (*send_msg_to_smc)(struct pp_hwmgr  *hwmgr, uint16_t msg);
         int (*send_msg_to_smc_with_parameter)(struct pp_hwmgr  *hwmgr,
                                           uint16_t msg, uint32_t parameter=
);
diff --git a/drivers/gpu/drm/amd/powerplay/inc/smumgr.h b/drivers/gpu/drm/a=
md/powerplay/inc/smumgr.h
index 89dfbf53c7e6..82550a8a3a3f 100644
--- a/drivers/gpu/drm/amd/powerplay/inc/smumgr.h
+++ b/drivers/gpu/drm/amd/powerplay/inc/smumgr.h
@@ -80,7 +80,7 @@ enum SMU10_TABLE_ID {
         SMU10_CLOCKTABLE,
 };

-extern int smum_get_argument(struct pp_hwmgr *hwmgr);
+extern uint32_t smum_get_argument(struct pp_hwmgr *hwmgr);

 extern int smum_download_powerplay_table(struct pp_hwmgr *hwmgr, void **ta=
ble);

diff --git a/drivers/gpu/drm/amd/powerplay/smumgr/smu10_smumgr.c b/drivers/=
gpu/drm/amd/powerplay/smumgr/smu10_smumgr.c
index 0a563f6fe9ea..bb07d43f3874 100644
--- a/drivers/gpu/drm/amd/powerplay/smumgr/smu10_smumgr.c
+++ b/drivers/gpu/drm/amd/powerplay/smumgr/smu10_smumgr.c
@@ -68,7 +68,7 @@ static int smu10_send_msg_to_smc_without_waiting(struct p=
p_hwmgr *hwmgr,
         return 0;
 }

-static int smu10_read_arg_from_smc(struct pp_hwmgr *hwmgr)
+static uint32_t smu10_read_arg_from_smc(struct pp_hwmgr *hwmgr)
 {
         struct amdgpu_device *adev =3D hwmgr->adev;

diff --git a/drivers/gpu/drm/amd/powerplay/smumgr/smu8_smumgr.c b/drivers/g=
pu/drm/amd/powerplay/smumgr/smu8_smumgr.c
index c861d3023474..f7e3bc22bb93 100644
--- a/drivers/gpu/drm/amd/powerplay/smumgr/smu8_smumgr.c
+++ b/drivers/gpu/drm/amd/powerplay/smumgr/smu8_smumgr.c
@@ -52,10 +52,10 @@ static const enum smu8_scratch_entry firmware_list[] =
=3D {
         SMU8_SCRATCH_ENTRY_UCODE_ID_RLC_G,
 };

-static int smu8_get_argument(struct pp_hwmgr *hwmgr)
+static uint32_t smu8_get_argument(struct pp_hwmgr *hwmgr)
 {
         if (hwmgr =3D=3D NULL || hwmgr->device =3D=3D NULL)
-               return -EINVAL;
+               return 0;

         return cgs_read_register(hwmgr->device,
                                         mmSMU_MP1_SRBM2P_ARG_0);
diff --git a/drivers/gpu/drm/amd/powerplay/smumgr/smu9_smumgr.c b/drivers/g=
pu/drm/amd/powerplay/smumgr/smu9_smumgr.c
index aad8f077f33c..079fc8e8f709 100644
--- a/drivers/gpu/drm/amd/powerplay/smumgr/smu9_smumgr.c
+++ b/drivers/gpu/drm/amd/powerplay/smumgr/smu9_smumgr.c
@@ -142,7 +142,7 @@ int smu9_send_msg_to_smc_with_parameter(struct pp_hwmgr=
 *hwmgr,
         return 0;
 }

-int smu9_get_argument(struct pp_hwmgr *hwmgr)
+uint32_t smu9_get_argument(struct pp_hwmgr *hwmgr)
 {
         struct amdgpu_device *adev =3D hwmgr->adev;

diff --git a/drivers/gpu/drm/amd/powerplay/smumgr/smu9_smumgr.h b/drivers/g=
pu/drm/amd/powerplay/smumgr/smu9_smumgr.h
index a8da2815bd89..1462279ca128 100644
--- a/drivers/gpu/drm/amd/powerplay/smumgr/smu9_smumgr.h
+++ b/drivers/gpu/drm/amd/powerplay/smumgr/smu9_smumgr.h
@@ -27,6 +27,6 @@ bool smu9_is_smc_ram_running(struct pp_hwmgr *hwmgr);
 int smu9_send_msg_to_smc(struct pp_hwmgr *hwmgr, uint16_t msg);
 int smu9_send_msg_to_smc_with_parameter(struct pp_hwmgr *hwmgr,
                                         uint16_t msg, uint32_t parameter);
-int smu9_get_argument(struct pp_hwmgr *hwmgr);
+uint32_t smu9_get_argument(struct pp_hwmgr *hwmgr);

 #endif
diff --git a/drivers/gpu/drm/amd/powerplay/smumgr/smumgr.c b/drivers/gpu/dr=
m/amd/powerplay/smumgr/smumgr.c
index c9837935f0f5..99d5e4f98f49 100644
--- a/drivers/gpu/drm/amd/powerplay/smumgr/smumgr.c
+++ b/drivers/gpu/drm/amd/powerplay/smumgr/smumgr.c
@@ -96,7 +96,7 @@ int smum_process_firmware_header(struct pp_hwmgr *hwmgr)
         return 0;
 }

-int smum_get_argument(struct pp_hwmgr *hwmgr)
+uint32_t smum_get_argument(struct pp_hwmgr *hwmgr)
 {
         if (NULL !=3D hwmgr->smumgr_funcs->get_argument)
                 return hwmgr->smumgr_funcs->get_argument(hwmgr);
--
2.13.6

_______________________________________________
amd-gfx mailing list
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--_000_CY4PR12MB1687613EDDFEFDB4607E867AFB5D0CY4PR12MB1687namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<meta name=3D"Generator" content=3D"Microsoft Exchange Server">
<!-- converted from text --><style><!-- .EmailQuote { margin-left: 1pt; pad=
ding-left: 4pt; border-left: #800000 2px solid; } --></style>
</head>
<body>
<div>
<div dir=3D"auto" style=3D"direction:ltr; margin:0; padding:0; font-family:=
sans-serif; font-size:11pt; color:black">
Series is:<br>
<br>
</div>
<div dir=3D"auto" style=3D"direction:ltr; margin:0; padding:0; font-family:=
sans-serif; font-size:11pt; color:black">
Reviewed-by: Rex Zhu&lt;<a href=3D"mailto:rezhu-5C7GfCeVMHo@public.gmane.org">rezhu-5C7GfCeVMHo@public.gmane.org</a>&=
gt;&nbsp;<br>
<br>
<br>
<br>
</div>
<div align=3D"left">
<div dir=3D"auto" style=3D"direction:ltr; margin:0; padding:0; font-family:=
sans-serif; font-size:11pt; color:black">
<font color=3D"#000000">Best Regards</font><br>
</div>
</div>
<div dir=3D"auto" style=3D"direction:ltr; margin:0; padding:0; font-family:=
sans-serif; font-size:11pt; color:black">
<br>
</div>
<div align=3D"left">
<div dir=3D"auto" style=3D"direction:ltr; margin:0; padding:0; font-family:=
sans-serif; font-size:11pt; color:black">
<font color=3D"#000000">Rex</font><br>
</div>
</div>
<div dir=3D"auto" style=3D"direction:ltr; margin:0; padding:0; font-family:=
sans-serif; font-size:11pt; color:black">
<br>
<br>
</div>
<div dir=3D"auto" style=3D"direction:ltr; margin:0; padding:0; font-family:=
sans-serif; font-size:11pt; color:black">
<div dir=3D"auto" style=3D"direction:ltr; margin:0; padding:0; font-family:=
sans-serif; font-size:11pt; color:black">
&#33719;&#21462; <a href=3D"https://aka.ms/ghei36">Outlook for Android</a><=
/div>
<br>
</div>
<hr tabindex=3D"-1" style=3D"display:inline-block; width:98%">
<div id=3D"x_divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" =
color=3D"#000000" style=3D"font-size:11pt"><b>From:</b> amd-gfx &lt;amd-gfx=
-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org&gt; on behalf of Alex Deucher &lt;alexdeuche=
r@gmail.com&gt;<br>
<b>Sent:</b> Friday, July 13, 2018 4:23:06 AM<br>
<b>To:</b> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
<b>Cc:</b> Deucher, Alexander<br>
<b>Subject:</b> [PATCH 3/3] drm/amdgpu/pp: switch smu callback type for get=
_argument()</font>
<div>&nbsp;</div>
</div>
</div>
<font size=3D"2"><span style=3D"font-size:11pt;">
<div class=3D"PlainText">return a uint32_t rather than an int to properly r=
eflect<br>
what the function does.<br>
<br>
Signed-off-by: Alex Deucher &lt;alexander.deucher-5C7GfCeVMHo@public.gmane.org&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/powerplay/inc/hwmgr.h&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; | 2 &#43;-<br>
&nbsp;drivers/gpu/drm/amd/powerplay/inc/smumgr.h&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; | 2 &#43;-<br>
&nbsp;drivers/gpu/drm/amd/powerplay/smumgr/smu10_smumgr.c | 2 &#43;-<br>
&nbsp;drivers/gpu/drm/amd/powerplay/smumgr/smu8_smumgr.c&nbsp; | 4 &#43;&#4=
3;--<br>
&nbsp;drivers/gpu/drm/amd/powerplay/smumgr/smu9_smumgr.c&nbsp; | 2 &#43;-<b=
r>
&nbsp;drivers/gpu/drm/amd/powerplay/smumgr/smu9_smumgr.h&nbsp; | 2 &#43;-<b=
r>
&nbsp;drivers/gpu/drm/amd/powerplay/smumgr/smumgr.c&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp; | 2 &#43;-<br>
&nbsp;7 files changed, 8 insertions(&#43;), 8 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/powerplay/inc/hwmgr.h b/drivers/gpu/drm/am=
d/powerplay/inc/hwmgr.h<br>
index b3363f26039a..d3d96260f440 100644<br>
--- a/drivers/gpu/drm/amd/powerplay/inc/hwmgr.h<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/powerplay/inc/hwmgr.h<br>
@@ -194,7 &#43;194,7 @@ struct pp_smumgr_func {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int (*request_smu_load_fw)=
(struct pp_hwmgr&nbsp; *hwmgr);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int (*request_smu_load_spe=
cific_fw)(struct pp_hwmgr&nbsp; *hwmgr,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t firmware);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int (*get_argument)(struct pp_hwmgr&n=
bsp; *hwmgr);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t (*get_argument)(struct p=
p_hwmgr&nbsp; *hwmgr);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int (*send_msg_to_smc)(str=
uct pp_hwmgr&nbsp; *hwmgr, uint16_t msg);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int (*send_msg_to_smc_with=
_parameter)(struct pp_hwmgr&nbsp; *hwmgr,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; uint16_t msg, uint32_t parameter);<br>
diff --git a/drivers/gpu/drm/amd/powerplay/inc/smumgr.h b/drivers/gpu/drm/a=
md/powerplay/inc/smumgr.h<br>
index 89dfbf53c7e6..82550a8a3a3f 100644<br>
--- a/drivers/gpu/drm/amd/powerplay/inc/smumgr.h<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/powerplay/inc/smumgr.h<br>
@@ -80,7 &#43;80,7 @@ enum SMU10_TABLE_ID {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SMU10_CLOCKTABLE,<br>
&nbsp;};<br>
&nbsp;<br>
-extern int smum_get_argument(struct pp_hwmgr *hwmgr);<br>
&#43;extern uint32_t smum_get_argument(struct pp_hwmgr *hwmgr);<br>
&nbsp;<br>
&nbsp;extern int smum_download_powerplay_table(struct pp_hwmgr *hwmgr, void=
 **table);<br>
&nbsp;<br>
diff --git a/drivers/gpu/drm/amd/powerplay/smumgr/smu10_smumgr.c b/drivers/=
gpu/drm/amd/powerplay/smumgr/smu10_smumgr.c<br>
index 0a563f6fe9ea..bb07d43f3874 100644<br>
--- a/drivers/gpu/drm/amd/powerplay/smumgr/smu10_smumgr.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/powerplay/smumgr/smu10_smumgr.c<br>
@@ -68,7 &#43;68,7 @@ static int smu10_send_msg_to_smc_without_waiting(stru=
ct pp_hwmgr *hwmgr,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&nbsp;}<br>
&nbsp;<br>
-static int smu10_read_arg_from_smc(struct pp_hwmgr *hwmgr)<br>
&#43;static uint32_t smu10_read_arg_from_smc(struct pp_hwmgr *hwmgr)<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev=
 =3D hwmgr-&gt;adev;<br>
&nbsp;<br>
diff --git a/drivers/gpu/drm/amd/powerplay/smumgr/smu8_smumgr.c b/drivers/g=
pu/drm/amd/powerplay/smumgr/smu8_smumgr.c<br>
index c861d3023474..f7e3bc22bb93 100644<br>
--- a/drivers/gpu/drm/amd/powerplay/smumgr/smu8_smumgr.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/powerplay/smumgr/smu8_smumgr.c<br>
@@ -52,10 &#43;52,10 @@ static const enum smu8_scratch_entry firmware_list[=
] =3D {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SMU8_SCRATCH_ENTRY_UCODE_I=
D_RLC_G,<br>
&nbsp;};<br>
&nbsp;<br>
-static int smu8_get_argument(struct pp_hwmgr *hwmgr)<br>
&#43;static uint32_t smu8_get_argument(struct pp_hwmgr *hwmgr)<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (hwmgr =3D=3D NULL || h=
wmgr-&gt;device =3D=3D NULL)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return -EINVAL;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; return 0;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return cgs_read_register(h=
wmgr-&gt;device,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; mmSMU_MP1_SRBM2P_ARG_0);<br>
diff --git a/drivers/gpu/drm/amd/powerplay/smumgr/smu9_smumgr.c b/drivers/g=
pu/drm/amd/powerplay/smumgr/smu9_smumgr.c<br>
index aad8f077f33c..079fc8e8f709 100644<br>
--- a/drivers/gpu/drm/amd/powerplay/smumgr/smu9_smumgr.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/powerplay/smumgr/smu9_smumgr.c<br>
@@ -142,7 &#43;142,7 @@ int smu9_send_msg_to_smc_with_parameter(struct pp_h=
wmgr *hwmgr,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&nbsp;}<br>
&nbsp;<br>
-int smu9_get_argument(struct pp_hwmgr *hwmgr)<br>
&#43;uint32_t smu9_get_argument(struct pp_hwmgr *hwmgr)<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev=
 =3D hwmgr-&gt;adev;<br>
&nbsp;<br>
diff --git a/drivers/gpu/drm/amd/powerplay/smumgr/smu9_smumgr.h b/drivers/g=
pu/drm/amd/powerplay/smumgr/smu9_smumgr.h<br>
index a8da2815bd89..1462279ca128 100644<br>
--- a/drivers/gpu/drm/amd/powerplay/smumgr/smu9_smumgr.h<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/powerplay/smumgr/smu9_smumgr.h<br>
@@ -27,6 &#43;27,6 @@ bool smu9_is_smc_ram_running(struct pp_hwmgr *hwmgr);=
<br>
&nbsp;int smu9_send_msg_to_smc(struct pp_hwmgr *hwmgr, uint16_t msg);<br>
&nbsp;int smu9_send_msg_to_smc_with_parameter(struct pp_hwmgr *hwmgr,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; uint16_t msg, uint32_t parameter);<br>
-int smu9_get_argument(struct pp_hwmgr *hwmgr);<br>
&#43;uint32_t smu9_get_argument(struct pp_hwmgr *hwmgr);<br>
&nbsp;<br>
&nbsp;#endif<br>
diff --git a/drivers/gpu/drm/amd/powerplay/smumgr/smumgr.c b/drivers/gpu/dr=
m/amd/powerplay/smumgr/smumgr.c<br>
index c9837935f0f5..99d5e4f98f49 100644<br>
--- a/drivers/gpu/drm/amd/powerplay/smumgr/smumgr.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/powerplay/smumgr/smumgr.c<br>
@@ -96,7 &#43;96,7 @@ int smum_process_firmware_header(struct pp_hwmgr *hwm=
gr)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&nbsp;}<br>
&nbsp;<br>
-int smum_get_argument(struct pp_hwmgr *hwmgr)<br>
&#43;uint32_t smum_get_argument(struct pp_hwmgr *hwmgr)<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (NULL !=3D hwmgr-&gt;sm=
umgr_funcs-&gt;get_argument)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return hwmgr-&gt;smumgr_funcs-&gt;get_argument(hwmgr)=
;<br>
-- <br>
2.13.6<br>
<br>
_______________________________________________<br>
amd-gfx mailing list<br>
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
<a href=3D"https://lists.freedesktop.org/mailman/listinfo/amd-gfx">https://=
lists.freedesktop.org/mailman/listinfo/amd-gfx</a><br>
</div>
</span></font>
</body>
</html>

--_000_CY4PR12MB1687613EDDFEFDB4607E867AFB5D0CY4PR12MB1687namp_--

--===============1448867337==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============1448867337==--
