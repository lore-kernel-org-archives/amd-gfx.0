From: "Wang, Kevin(Yang)" <Kevin1.Wang-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH] drm/amdgpu/powerplay: add new mapping for APCC_DFLL
 feature
Date: Tue, 17 Sep 2019 14:40:07 +0000
Message-ID: <MN2PR12MB32960DE06FEE0B6780B872A1A28F0@MN2PR12MB3296.namprd12.prod.outlook.com>
References: <20190917110431.12559-1-xiaojie.yuan@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0023318866=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20190917110431.12559-1-xiaojie.yuan-5C7GfCeVMHo@public.gmane.org>
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
To: "Yuan, Xiaojie" <Xiaojie.Yuan-5C7GfCeVMHo@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
Cc: "Quan, Evan" <Evan.Quan-5C7GfCeVMHo@public.gmane.org>, "Feng, Kenneth" <Kenneth.Feng-5C7GfCeVMHo@public.gmane.org>

--===============0023318866==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_MN2PR12MB32960DE06FEE0B6780B872A1A28F0MN2PR12MB3296namp_"

--_000_MN2PR12MB32960DE06FEE0B6780B872A1A28F0MN2PR12MB3296namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Reviewed-by: Kevin Wang <kevin1.wang-5C7GfCeVMHo@public.gmane.org>


________________________________
From: Yuan, Xiaojie <Xiaojie.Yuan-5C7GfCeVMHo@public.gmane.org>
Sent: Tuesday, September 17, 2019 7:04 PM
To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
Cc: Feng, Kenneth <Kenneth.Feng-5C7GfCeVMHo@public.gmane.org>; Quan, Evan <Evan.Quan-5C7GfCeVMHo@public.gmane.org>; W=
ang, Kevin(Yang) <Kevin1.Wang-5C7GfCeVMHo@public.gmane.org>; Yuan, Xiaojie <Xiaojie.Yuan-5C7GfCeVMHo@public.gmane.org=
>
Subject: [PATCH] drm/amdgpu/powerplay: add new mapping for APCC_DFLL featur=
e

Signed-off-by: Xiaojie Yuan <xiaojie.yuan-5C7GfCeVMHo@public.gmane.org>
---
 drivers/gpu/drm/amd/powerplay/inc/smu_types.h | 1 +
 drivers/gpu/drm/amd/powerplay/navi10_ppt.c    | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/powerplay/inc/smu_types.h b/drivers/gpu/dr=
m/amd/powerplay/inc/smu_types.h
index ab8c92a60fc4..12a1de55ce3c 100644
--- a/drivers/gpu/drm/amd/powerplay/inc/smu_types.h
+++ b/drivers/gpu/drm/amd/powerplay/inc/smu_types.h
@@ -252,6 +252,7 @@ enum smu_clk_type {
        __SMU_DUMMY_MAP(TEMP_DEPENDENT_VMIN),            \
        __SMU_DUMMY_MAP(MMHUB_PG),                       \
        __SMU_DUMMY_MAP(ATHUB_PG),                       \
+       __SMU_DUMMY_MAP(APCC_DFLL),                      \
        __SMU_DUMMY_MAP(WAFL_CG),

 #undef __SMU_DUMMY_MAP
diff --git a/drivers/gpu/drm/amd/powerplay/navi10_ppt.c b/drivers/gpu/drm/a=
md/powerplay/navi10_ppt.c
index 16634e657589..5a34d01f7f7c 100644
--- a/drivers/gpu/drm/amd/powerplay/navi10_ppt.c
+++ b/drivers/gpu/drm/amd/powerplay/navi10_ppt.c
@@ -176,6 +176,7 @@ static struct smu_11_0_cmn2aisc_mapping navi10_feature_=
mask_map[SMU_FEATURE_COUN
         FEA_MAP(TEMP_DEPENDENT_VMIN),
         FEA_MAP(MMHUB_PG),
         FEA_MAP(ATHUB_PG),
+       FEA_MAP(APCC_DFLL),
 };

 static struct smu_11_0_cmn2aisc_mapping navi10_table_map[SMU_TABLE_COUNT] =
=3D {
--
2.20.1


--_000_MN2PR12MB32960DE06FEE0B6780B872A1A28F0MN2PR12MB3296namp_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-8859-=
1">
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<div style=3D"margin: 0px; font-size: 12pt; font-family: Calibri, Arial, He=
lvetica, sans-serif; color: rgb(0, 0, 0);">
<div style=3D"margin: 0px; font-size: 12pt; font-family: Calibri, Arial, He=
lvetica, sans-serif">
Reviewed-by: Kevin Wang &lt;kevin1.wang-5C7GfCeVMHo@public.gmane.org&gt;</div>
<div style=3D"margin: 0px; font-size: 12pt; font-family: Calibri, Arial, He=
lvetica, sans-serif">
<br style=3D"font-size: 16px; background-color: rgb(255, 255, 255)">
</div>
<br>
</div>
</div>
<hr tabindex=3D"-1" style=3D"display:inline-block; width:98%">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" co=
lor=3D"#000000" style=3D"font-size:11pt"><b>From:</b> Yuan, Xiaojie &lt;Xia=
ojie.Yuan-5C7GfCeVMHo@public.gmane.org&gt;<br>
<b>Sent:</b> Tuesday, September 17, 2019 7:04 PM<br>
<b>To:</b> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org &lt;amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org&=
gt;<br>
<b>Cc:</b> Feng, Kenneth &lt;Kenneth.Feng-5C7GfCeVMHo@public.gmane.org&gt;; Quan, Evan &lt;Evan.=
Quan-5C7GfCeVMHo@public.gmane.org&gt;; Wang, Kevin(Yang) &lt;Kevin1.Wang-5C7GfCeVMHo@public.gmane.org&gt;; Yuan, Xiao=
jie &lt;Xiaojie.Yuan-5C7GfCeVMHo@public.gmane.org&gt;<br>
<b>Subject:</b> [PATCH] drm/amdgpu/powerplay: add new mapping for APCC_DFLL=
 feature</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt"=
>
<div class=3D"PlainText">Signed-off-by: Xiaojie Yuan &lt;xiaojie.yuan@amd.c=
om&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/powerplay/inc/smu_types.h | 1 &#43;<br>
&nbsp;drivers/gpu/drm/amd/powerplay/navi10_ppt.c&nbsp;&nbsp;&nbsp; | 1 &#43=
;<br>
&nbsp;2 files changed, 2 insertions(&#43;)<br>
<br>
diff --git a/drivers/gpu/drm/amd/powerplay/inc/smu_types.h b/drivers/gpu/dr=
m/amd/powerplay/inc/smu_types.h<br>
index ab8c92a60fc4..12a1de55ce3c 100644<br>
--- a/drivers/gpu/drm/amd/powerplay/inc/smu_types.h<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/powerplay/inc/smu_types.h<br>
@@ -252,6 &#43;252,7 @@ enum smu_clk_type {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; __SMU_DUMMY_MAP(TEMP_DEPENDENT_V=
MIN),&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; \<b=
r>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; __SMU_DUMMY_MAP(MMHUB_PG),&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; \<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; __SMU_DUMMY_MAP(ATHUB_PG),&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; \<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; __SMU_DUMMY_MAP(APCC_DFLL),&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; \<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; __SMU_DUMMY_MAP(WAFL_CG),<br>
&nbsp;<br>
&nbsp;#undef __SMU_DUMMY_MAP<br>
diff --git a/drivers/gpu/drm/amd/powerplay/navi10_ppt.c b/drivers/gpu/drm/a=
md/powerplay/navi10_ppt.c<br>
index 16634e657589..5a34d01f7f7c 100644<br>
--- a/drivers/gpu/drm/amd/powerplay/navi10_ppt.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/powerplay/navi10_ppt.c<br>
@@ -176,6 &#43;176,7 @@ static struct smu_11_0_cmn2aisc_mapping navi10_feat=
ure_mask_map[SMU_FEATURE_COUN<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; FEA_MAP(TEMP_DEPENDENT_VMI=
N),<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; FEA_MAP(MMHUB_PG),<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; FEA_MAP(ATHUB_PG),<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; FEA_MAP(APCC_DFLL),<br>
&nbsp;};<br>
&nbsp;<br>
&nbsp;static struct smu_11_0_cmn2aisc_mapping navi10_table_map[SMU_TABLE_CO=
UNT] =3D {<br>
-- <br>
2.20.1<br>
<br>
</div>
</span></font></div>
</body>
</html>

--_000_MN2PR12MB32960DE06FEE0B6780B872A1A28F0MN2PR12MB3296namp_--

--===============0023318866==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4

--===============0023318866==--
