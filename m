From: "Wang, Kevin(Yang)" <Kevin1.Wang-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH] drm/amd/powerplay: update cached feature enablement
 status V2
Date: Fri, 23 Aug 2019 05:52:57 +0000
Message-ID: <MN2PR12MB32964C9C3DC3919188759C4EA2A40@MN2PR12MB3296.namprd12.prod.outlook.com>
References: <MN2PR12MB32969ABC3F90939200C01E64A2A40@MN2PR12MB3296.namprd12.prod.outlook.com>,
 <MN2PR12MB3344F4BCEB15A0A817B9A6A0E4A40@MN2PR12MB3344.namprd12.prod.outlook.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0155635703=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <MN2PR12MB3344F4BCEB15A0A817B9A6A0E4A40-rweVpJHSKToDMgCC8P//OwdYzm3356FpvxpqHgZTriW3zl9H0oFU5g@public.gmane.org>
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

--===============0155635703==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_MN2PR12MB32964C9C3DC3919188759C4EA2A40MN2PR12MB3296namp_"

--_000_MN2PR12MB32964C9C3DC3919188759C4EA2A40MN2PR12MB3296namp_
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable

a patch does only one thing.
in this patch,it will do 2 things:

  1.  fixed feature bitmap cached issue.
  2.  make api of smu_feature_update_enabled_state as static function.

for reason#2:
the driver has other apis which only used in amdgpu_smu.c, but it still dec=
laration in amdgpu_smu.h.
the intent is to make this a public API.
if you want to make it is a static function, please split it 2 patches. and=
 indicate the reason.

Best Regards,
Kevin
________________________________
From: Quan, Evan <Evan.Quan-5C7GfCeVMHo@public.gmane.org>
Sent: Friday, August 23, 2019 1:38 PM
To: Wang, Kevin(Yang) <Kevin1.Wang-5C7GfCeVMHo@public.gmane.org>; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org =
<amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
Subject: RE: [PATCH] drm/amd/powerplay: update cached feature enablement st=
atus V2


smu_feature_update_enable_state() is used only in amdgpu_smu.c.

As a common sense, these APIs should be declared as =91static=92.



Regards,

Evan

From: Wang, Kevin(Yang) <Kevin1.Wang-5C7GfCeVMHo@public.gmane.org>
Sent: Friday, August 23, 2019 1:30 PM
To: Quan, Evan <Evan.Quan-5C7GfCeVMHo@public.gmane.org>; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Subject: Re: [PATCH] drm/amd/powerplay: update cached feature enablement st=
atus V2



comment inline

________________________________

From: Quan, Evan <Evan.Quan-5C7GfCeVMHo@public.gmane.org<mailto:Evan.Quan-5C7GfCeVMHo@public.gmane.org>>
Sent: Friday, August 23, 2019 12:50 PM
To: Wang, Kevin(Yang) <Kevin1.Wang-5C7GfCeVMHo@public.gmane.org<mailto:Kevin1.Wang-5C7GfCeVMHo@public.gmane.org>>; am=
d-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org> <amd-gfx@=
lists.freedesktop.org<mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>>
Subject: RE: [PATCH] drm/amd/powerplay: update cached feature enablement st=
atus V2



Comment inline



From: Wang, Kevin(Yang) <Kevin1.Wang-5C7GfCeVMHo@public.gmane.org<mailto:Kevin1.Wang-5C7GfCeVMHo@public.gmane.org>>
Sent: Thursday, August 22, 2019 8:00 PM
To: Quan, Evan <Evan.Quan-5C7GfCeVMHo@public.gmane.org<mailto:Evan.Quan-5C7GfCeVMHo@public.gmane.org>>; amd-gfx@lists=
.freedesktop.org<mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
Subject: Re: [PATCH] drm/amd/powerplay: update cached feature enablement st=
atus V2



comment inline.

________________________________

From: amd-gfx <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<mailto:amd-gfx-bounces=
@lists.freedesktop.org>> on behalf of Evan Quan <evan.quan-5C7GfCeVMHo@public.gmane.org<mailto:e=
van.quan-5C7GfCeVMHo@public.gmane.org>>
Sent: Thursday, August 22, 2019 6:18 PM
To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org> <am=
d-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>>
Cc: Quan, Evan <Evan.Quan-5C7GfCeVMHo@public.gmane.org<mailto:Evan.Quan-5C7GfCeVMHo@public.gmane.org>>
Subject: [PATCH] drm/amd/powerplay: update cached feature enablement status=
 V2



Need to update in cache feature enablement status after pp_feature
settings. Another fix for the commit below:
drm/amd/powerplay: implment sysfs feature status function in smu

V2: update smu_feature_update_enable_state() and relates

Change-Id: I90e29b0d839df26825d5993212f6097c7ad4bebf

[kevin]: this information is not neccessary for public, please remove it.

git config gerrit.createchangeid=3Dfalse
Signed-off-by: Evan Quan <evan.quan-5C7GfCeVMHo@public.gmane.org<mailto:evan.quan-5C7GfCeVMHo@public.gmane.org>>
---
 drivers/gpu/drm/amd/powerplay/amdgpu_smu.c    | 104 +++++++++---------
 .../gpu/drm/amd/powerplay/inc/amdgpu_smu.h    |   1 -
 2 files changed, 52 insertions(+), 53 deletions(-)

diff --git a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c b/drivers/gpu/drm/a=
md/powerplay/amdgpu_smu.c
index 4df7fb6eaf3c..3e1cd5d9c29e 100644
--- a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
@@ -94,6 +94,55 @@ size_t smu_sys_get_pp_feature_mask(struct smu_context *s=
mu, char *buf)
         return size;
 }

+static int smu_feature_update_enable_state(struct smu_context *smu,
+                                          uint64_t feature_mask,
+                                          bool enabled)
+{
+       struct smu_feature *feature =3D &smu->smu_feature;
+       uint32_t feature_low =3D 0, feature_high =3D 0;
+       uint64_t feature_id;
+       int ret =3D 0;
+
+       if (!smu->pm_enabled)
+               return ret;
+
+       feature_low =3D (feature_mask >> 0 ) & 0xffffffff;
+       feature_high =3D (feature_mask >> 32) & 0xffffffff;
+
+       if (enabled) {
+               ret =3D smu_send_smc_msg_with_param(smu, SMU_MSG_EnableSmuF=
eaturesLow,
+                                                 feature_low);
+               if (ret)
+                       return ret;
+               ret =3D smu_send_smc_msg_with_param(smu, SMU_MSG_EnableSmuF=
eaturesHigh,
+                                                 feature_high);
+               if (ret)
+                       return ret;
+       } else {
+               ret =3D smu_send_smc_msg_with_param(smu, SMU_MSG_DisableSmu=
FeaturesLow,
+                                                 feature_low);
+               if (ret)
+                       return ret;
+               ret =3D smu_send_smc_msg_with_param(smu, SMU_MSG_DisableSmu=
FeaturesHigh,
+                                                 feature_high);
+               if (ret)
+                       return ret;
+       }
+
+       mutex_lock(&feature->mutex);
+       for (feature_id =3D 0; feature_id < 64; feature_id++) {
+               if (feature_mask & (1ULL << feature_id)) {
+                       if (enabled)
+                               test_and_set_bit(feature_id, feature->enabl=
ed);
+                       else
+                               test_and_clear_bit(feature_id, feature->ena=
bled);
+               }
+       }



//[kevin]: the code logic is a little redundant.

could you use bellow macro to replace that?

header : linux/bitmap.h

 *  bitmap_and(dst, src1, src2, nbits)          *dst =3D *src1 & *src2

 *  bitmap_or(dst, src1, src2, nbits)           *dst =3D *src1 | *src2

 *  bitmap_xor(dst, src1, src2, nbits)          *dst =3D *src1 ^ *src2

 *  bitmap_andnot(dst, src1, src2, nbits)       *dst =3D *src1 & ~(*src2)



+       mutex_unlock(&feature->mutex);
+
+       return ret;
+}
+



[Quan, Evan] updated in v3.

 int smu_sys_set_pp_feature_mask(struct smu_context *smu, uint64_t new_mask=
)
 {
         int ret =3D 0;
@@ -591,41 +640,7 @@ int smu_feature_init_dpm(struct smu_context *smu)

         return ret;
 }



[kevin]:

in this patch, i know you only want to fix not cached feature cache issue,

but in v2 patch,

the patch adjust the order of code functions, it seems that this is a brand=
 new function,

I don't think it is necessary,

could you just reflect the modified content in the patch, which can facilit=
ate us to trace problems and review.

thanks.



[Quan, Evan] Move the API before the place it=92s called. No problem here.



[kevin]: in this patch, you don't need to adjust function order in this fil=
e,

because the driver is already export this function in amdgpu_smu.h.

int smu_feature_update_enable_state(struct smu_context *smu, uint64_t featu=
re_mask, bool enabled);

and in this patch, it make it is static function, but the declaration secti=
on remains in the amdgpu_smu.h file.

so i don't want to you adjust the function order and make it is static funt=
ion in this patch.

except you have other reason for it.



-int smu_feature_update_enable_state(struct smu_context *smu, uint64_t feat=
ure_mask, bool enabled)
-{
-       uint32_t feature_low =3D 0, feature_high =3D 0;
-       int ret =3D 0;

-       if (!smu->pm_enabled)
-               return ret;
-
-       feature_low =3D (feature_mask >> 0 ) & 0xffffffff;
-       feature_high =3D (feature_mask >> 32) & 0xffffffff;
-
-       if (enabled) {
-               ret =3D smu_send_smc_msg_with_param(smu, SMU_MSG_EnableSmuF=
eaturesLow,
-                                                 feature_low);
-               if (ret)
-                       return ret;
-               ret =3D smu_send_smc_msg_with_param(smu, SMU_MSG_EnableSmuF=
eaturesHigh,
-                                                 feature_high);
-               if (ret)
-                       return ret;
-
-       } else {
-               ret =3D smu_send_smc_msg_with_param(smu, SMU_MSG_DisableSmu=
FeaturesLow,
-                                                 feature_low);
-               if (ret)
-                       return ret;
-               ret =3D smu_send_smc_msg_with_param(smu, SMU_MSG_DisableSmu=
FeaturesHigh,
-                                                 feature_high);
-               if (ret)
-                       return ret;
-
-       }
-
-       return ret;
-}

 int smu_feature_is_enabled(struct smu_context *smu, enum smu_feature_mask =
mask)
 {
@@ -651,8 +666,6 @@ int smu_feature_set_enabled(struct smu_context *smu, en=
um smu_feature_mask mask,
 {
         struct smu_feature *feature =3D &smu->smu_feature;
         int feature_id;
-       uint64_t feature_mask =3D 0;
-       int ret =3D 0;

         feature_id =3D smu_feature_get_index(smu, mask);
         if (feature_id < 0)
@@ -660,22 +673,9 @@ int smu_feature_set_enabled(struct smu_context *smu, e=
num smu_feature_mask mask,

         WARN_ON(feature_id > feature->feature_num);

-       feature_mask =3D 1ULL << feature_id;
-
-       mutex_lock(&feature->mutex);
-       ret =3D smu_feature_update_enable_state(smu, feature_mask, enable);
-       if (ret)
-               goto failed;
-
-       if (enable)
-               test_and_set_bit(feature_id, feature->enabled);
-       else
-               test_and_clear_bit(feature_id, feature->enabled);
-
-failed:
-       mutex_unlock(&feature->mutex);
-
-       return ret;
+       return smu_feature_update_enable_state(smu,
+                                              1ULL << feature_id,
+                                              enable);
 }

 int smu_feature_is_supported(struct smu_context *smu, enum smu_feature_mas=
k mask)
diff --git a/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h b/drivers/gpu/d=
rm/amd/powerplay/inc/amdgpu_smu.h
index e80c81552d29..fbf68fd42b93 100644
--- a/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h
+++ b/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h
@@ -807,7 +807,6 @@ enum amd_dpm_forced_level smu_get_performance_level(str=
uct smu_context *smu);
 int smu_force_performance_level(struct smu_context *smu, enum amd_dpm_forc=
ed_level level);
 int smu_set_display_count(struct smu_context *smu, uint32_t count);
 bool smu_clk_dpm_is_enabled(struct smu_context *smu, enum smu_clk_type clk=
_type);
-int smu_feature_update_enable_state(struct smu_context *smu, uint64_t feat=
ure_mask, bool enabled);
 const char *smu_get_message_name(struct smu_context *smu, enum smu_message=
_type type);
 const char *smu_get_feature_name(struct smu_context *smu, enum smu_feature=
_mask feature);
 size_t smu_sys_get_pp_feature_mask(struct smu_context *smu, char *buf);
--
2.23.0

_______________________________________________
amd-gfx mailing list
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--_000_MN2PR12MB32964C9C3DC3919188759C4EA2A40MN2PR12MB3296namp_
Content-Type: text/html; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3DWindows-1=
252">
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<span style=3D"color: rgb(0, 0, 0); font-family: Calibri, Arial, Helvetica,=
 sans-serif; font-size: 12pt;">a patch does only one thing.</span><br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
in this patch,it will do 2 things:</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<ol>
<li>fixed feature bitmap cached issue.</li><li>make api of smu_feature_upda=
te_enabled_state as static function.</li></ol>
<div>for reason#2:</div>
<div>the driver has other apis which only used in amdgpu_smu.c, but it stil=
l declaration in amdgpu_smu.h.</div>
<div><span>the intent is to make this a public API.</span></div>
<div>if you want to make it is a static function, please split it 2 patches=
. a<span>nd indicate the reason.<br>
</span></div>
<div><br>
</div>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Best Regards,<br>
Kevin</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Quan, Evan &lt;Evan.Q=
uan-5C7GfCeVMHo@public.gmane.org&gt;<br>
<b>Sent:</b> Friday, August 23, 2019 1:38 PM<br>
<b>To:</b> Wang, Kevin(Yang) &lt;Kevin1.Wang-5C7GfCeVMHo@public.gmane.org&gt;; amd-gfx-PD4FTy7X32mzQB+pC5nmwQ@public.gmane.org=
edesktop.org &lt;amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org&gt;<br>
<b>Subject:</b> RE: [PATCH] drm/amd/powerplay: update cached feature enable=
ment status V2</font>
<div>&nbsp;</div>
</div>
<style>
<!--
@font-face
	{font-family:SimSun}
@font-face
	{font-family:"Cambria Math"}
@font-face
	{font-family:Calibri}
@font-face
	{font-family:"Segoe UI"}
@font-face
	{font-family:SimSun}
p.x_MsoNormal, li.x_MsoNormal, div.x_MsoNormal
	{margin:0in;
	margin-bottom:.0001pt;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif}
a:link, span.x_MsoHyperlink
	{color:blue;
	text-decoration:underline}
a:visited, span.x_MsoHyperlinkFollowed
	{color:purple;
	text-decoration:underline}
p.x_msonormal0, li.x_msonormal0, div.x_msonormal0
	{margin:0in;
	margin-bottom:.0001pt;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif}
p.x_xmsonormal, li.x_xmsonormal, div.x_xmsonormal
	{margin:0in;
	margin-bottom:.0001pt;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif}
span.x_EmailStyle21
	{font-family:"Calibri",sans-serif;
	color:windowtext}
.x_MsoChpDefault
	{font-size:10.0pt}
@page WordSection1
	{margin:1.0in 1.25in 1.0in 1.25in}
div.x_WordSection1
	{}
-->
</style>
<div lang=3D"EN-US" link=3D"blue" vlink=3D"purple">
<div class=3D"x_WordSection1">
<p class=3D"x_MsoNormal">smu_feature_update_enable_state() is used only in =
amdgpu_smu.c.
</p>
<p class=3D"x_MsoNormal">As a common sense, these APIs should be declared a=
s =91static=92.</p>
<p class=3D"x_MsoNormal">&nbsp;</p>
<p class=3D"x_MsoNormal">Regards,</p>
<p class=3D"x_MsoNormal">Evan</p>
<div style=3D"border:none; border-left:solid blue 1.5pt; padding:0in 0in 0i=
n 4.0pt">
<div>
<div style=3D"border:none; border-top:solid #E1E1E1 1.0pt; padding:3.0pt 0i=
n 0in 0in">
<p class=3D"x_MsoNormal"><b>From:</b> Wang, Kevin(Yang) &lt;Kevin1.Wang@amd=
.com&gt; <br>
<b>Sent:</b> Friday, August 23, 2019 1:30 PM<br>
<b>To:</b> Quan, Evan &lt;Evan.Quan-5C7GfCeVMHo@public.gmane.org&gt;; amd-gfx-PD4FTy7X32lNgt0PjOBp9/rsn8yoX9R0@public.gmane.org=
org<br>
<b>Subject:</b> Re: [PATCH] drm/amd/powerplay: update cached feature enable=
ment status V2</p>
</div>
</div>
<p class=3D"x_MsoNormal">&nbsp;</p>
<div>
<p class=3D"x_MsoNormal"><span style=3D"font-size:12.0pt; color:black">comm=
ent inline</span></p>
</div>
<div class=3D"x_MsoNormal" align=3D"center" style=3D"text-align:center">
<hr size=3D"2" width=3D"98%" align=3D"center">
</div>
<div id=3D"x_divRplyFwdMsg">
<p class=3D"x_MsoNormal"><b><span style=3D"color:black">From:</span></b><sp=
an style=3D"color:black"> Quan, Evan &lt;<a href=3D"mailto:Evan.Quan-urvtwAKJhsc@public.gmane.org=
m">Evan.Quan-5C7GfCeVMHo@public.gmane.org</a>&gt;<br>
<b>Sent:</b> Friday, August 23, 2019 12:50 PM<br>
<b>To:</b> Wang, Kevin(Yang) &lt;<a href=3D"mailto:Kevin1.Wang-5C7GfCeVMHo@public.gmane.org">Kev=
in1.Wang-5C7GfCeVMHo@public.gmane.org</a>&gt;;
<a href=3D"mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">amd-gfx-PD4FTy7X32lNgt0PjOBp9/rsn8yoX9R0@public.gmane.org=
org</a> &lt;<a href=3D"mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">amd-gfx@lists.=
freedesktop.org</a>&gt;<br>
<b>Subject:</b> RE: [PATCH] drm/amd/powerplay: update cached feature enable=
ment status V2</span>
</p>
<div>
<p class=3D"x_MsoNormal">&nbsp;</p>
</div>
</div>
<div>
<div>
<p class=3D"x_xmsonormal">Comment inline</p>
<p class=3D"x_xmsonormal">&nbsp;</p>
<div style=3D"border:none; border-left:solid blue 1.5pt; padding:0in 0in 0i=
n 4.0pt">
<div>
<div style=3D"border:none; border-top:solid #E1E1E1 1.0pt; padding:3.0pt 0i=
n 0in 0in">
<p class=3D"x_xmsonormal"><b>From:</b> Wang, Kevin(Yang) &lt;<a href=3D"mai=
lto:Kevin1.Wang-5C7GfCeVMHo@public.gmane.org">Kevin1.Wang-5C7GfCeVMHo@public.gmane.org</a>&gt;
<br>
<b>Sent:</b> Thursday, August 22, 2019 8:00 PM<br>
<b>To:</b> Quan, Evan &lt;<a href=3D"mailto:Evan.Quan-5C7GfCeVMHo@public.gmane.org">Evan.Quan@am=
d.com</a>&gt;;
<a href=3D"mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">amd-gfx-PD4FTy7X32lNgt0PjOBp9/rsn8yoX9R0@public.gmane.org=
org</a><br>
<b>Subject:</b> Re: [PATCH] drm/amd/powerplay: update cached feature enable=
ment status V2</p>
</div>
</div>
<p class=3D"x_xmsonormal">&nbsp;</p>
<div>
<p class=3D"x_xmsonormal"><span style=3D"font-size:12.0pt; color:black">com=
ment inline.</span></p>
</div>
<div class=3D"x_MsoNormal" align=3D"center" style=3D"text-align:center">
<hr size=3D"2" width=3D"98%" align=3D"center">
</div>
<div id=3D"x_x_divRplyFwdMsg">
<p class=3D"x_xmsonormal"><b><span style=3D"color:black">From:</span></b><s=
pan style=3D"color:black"> amd-gfx &lt;<a href=3D"mailto:amd-gfx-bounces@li=
sts.freedesktop.org">amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a>&gt; on behal=
f of Evan Quan &lt;<a href=3D"mailto:evan.quan-5C7GfCeVMHo@public.gmane.org">evan.quan-5C7GfCeVMHo@public.gmane.org</=
a>&gt;<br>
<b>Sent:</b> Thursday, August 22, 2019 6:18 PM<br>
<b>To:</b> <a href=3D"mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">amd-gfx@lists.f=
reedesktop.org</a> &lt;<a href=3D"mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">amd=
-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a>&gt;<br>
<b>Cc:</b> Quan, Evan &lt;<a href=3D"mailto:Evan.Quan-5C7GfCeVMHo@public.gmane.org">Evan.Quan@am=
d.com</a>&gt;<br>
<b>Subject:</b> [PATCH] drm/amd/powerplay: update cached feature enablement=
 status V2</span>
</p>
<div>
<p class=3D"x_xmsonormal">&nbsp;</p>
</div>
</div>
<div>
<div>
<p class=3D"x_xmsonormal">Need to update in cache feature enablement status=
 after pp_feature<br>
settings. Another fix for the commit below:<br>
drm/amd/powerplay: implment sysfs feature status function in smu<br>
<br>
V2: update smu_feature_update_enable_state() and relates<br>
<br>
<b>Change-Id: I90e29b0d839df26825d5993212f6097c7ad4bebf&nbsp;</b></p>
</div>
<div>
<p class=3D"x_xmsonormal"><b>[kevin]: this information is not neccessary fo=
r public, please remove it.</b></p>
</div>
<div>
<p class=3D"x_xmsonormal"><b>git config gerrit.createchangeid=3Dfalse<br>
</b>Signed-off-by: Evan Quan &lt;<a href=3D"mailto:evan.quan-5C7GfCeVMHo@public.gmane.org">evan.=
quan-5C7GfCeVMHo@public.gmane.org</a>&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/powerplay/amdgpu_smu.c&nbsp;&nbsp;&nbsp; | 104 &#=
43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;---------<br>
&nbsp;.../gpu/drm/amd/powerplay/inc/amdgpu_smu.h&nbsp;&nbsp;&nbsp; |&nbsp;&=
nbsp; 1 -<br>
&nbsp;2 files changed, 52 insertions(&#43;), 53 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c b/drivers/gpu/drm/a=
md/powerplay/amdgpu_smu.c<br>
index 4df7fb6eaf3c..3e1cd5d9c29e 100644<br>
--- a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c<br>
@@ -94,6 &#43;94,55 @@ size_t smu_sys_get_pp_feature_mask(struct smu_contex=
t *smu, char *buf)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return size;<br>
&nbsp;}<br>
&nbsp;<br>
&#43;<b>static</b> int smu_feature_update_enable_state(struct smu_context *=
smu,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp; uint64_t feature_mask,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp; bool enabled)<br>
&#43;{<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct smu_feature *feature =3D &=
amp;smu-&gt;smu_feature;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t feature_low =3D 0, featu=
re_high =3D 0;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint64_t feature_id;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ret =3D 0;<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!smu-&gt;pm_enabled)<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; return ret;<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; feature_low =3D (feature_mask &gt=
;&gt; 0 ) &amp; 0xffffffff;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; feature_high =3D (feature_mask &g=
t;&gt; 32) &amp; 0xffffffff;<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (enabled) {<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; ret =3D smu_send_smc_msg_with_param(smu, SMU_MSG_EnableSmuFe=
aturesLow,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; featur=
e_low);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; if (ret)<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret;<=
br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; ret =3D smu_send_smc_msg_with_param(smu, SMU_MSG_EnableSmuFe=
aturesHigh,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; featur=
e_high);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; if (ret)<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret;<=
br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else {<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; ret =3D smu_send_smc_msg_with_param(smu, SMU_MSG_DisableSmuF=
eaturesLow,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; featur=
e_low);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; if (ret)<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret;<=
br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; ret =3D smu_send_smc_msg_with_param(smu, SMU_MSG_DisableSmuF=
eaturesHigh,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; featur=
e_high);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; if (ret)<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret;<=
br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_lock(&amp;feature-&gt;mutex=
);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (feature_id =3D 0; feature_id=
 &lt; 64; feature_id&#43;&#43;) {<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; if (feature_mask &amp; (1ULL &lt;&lt; feature_id)) {<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (enabled)=
<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; test_and_set_bit(feature_id, feature-&g=
t;enabled);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; else<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; test_and_clear_bit(feature_id, feature-=
&gt;enabled);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; }<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }</p>
</div>
<div>
<p class=3D"x_xmsonormal">&nbsp;</p>
</div>
<div>
<p class=3D"x_xmsonormal">//[kevin]: the code logic is a little redundant.<=
/p>
</div>
<div>
<p class=3D"x_xmsonormal">could you use bellow macro to replace that?</p>
</div>
<div>
<p class=3D"x_xmsonormal">header :&nbsp;<span style=3D"font-family:&quot;Se=
goe UI&quot;,sans-serif; color:black; background:white">linux/bitmap.h</spa=
n></p>
</div>
<div>
<p class=3D"x_xmsonormal">&nbsp;* &nbsp;bitmap_and(dst, src1, src2, nbits) =
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;*dst =3D *src1 &amp; *src2</p>
<div>
<p class=3D"x_xmsonormal">&nbsp;* &nbsp;<b>bitmap_or</b>(dst, src1, src2, n=
bits) &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; *dst =3D *src1 | *src2</p>
</div>
<div>
<p class=3D"x_xmsonormal">&nbsp;* &nbsp;bitmap_xor(dst, src1, src2, nbits) =
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;*dst =3D *src1 ^ *src2</p>
</div>
<p class=3D"x_xmsonormal">&nbsp;* &nbsp;<b>bitmap_andnot</b>(dst, src1, src=
2, nbits) &nbsp; &nbsp; &nbsp; *dst =3D *src1 &amp; ~(*src2)</p>
</div>
<div>
<p class=3D"x_xmsonormal">&nbsp;</p>
</div>
<div>
<p class=3D"x_xmsonormal">&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_u=
nlock(&amp;feature-&gt;mutex);<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret;<br>
&#43;}<br>
&#43;</p>
</div>
<div>
<p class=3D"x_xmsonormal">&nbsp;</p>
<p class=3D"x_xmsonormal"><b><i>[Quan, Evan] updated in v3.</i></b></p>
<p class=3D"x_xmsonormal"><br>
&nbsp;int smu_sys_set_pp_feature_mask(struct smu_context *smu, uint64_t new=
_mask)<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ret =3D 0;<br>
@@ -591,41 &#43;640,7 @@ int smu_feature_init_dpm(struct smu_context *smu)<=
br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret;<br>
&nbsp;}</p>
</div>
<div>
<p class=3D"x_xmsonormal">&nbsp;</p>
</div>
<div>
<p class=3D"x_xmsonormal">[kevin]:</p>
</div>
<div>
<p class=3D"x_xmsonormal">in this patch, i know you only want to fix not ca=
ched feature cache issue,</p>
</div>
<div>
<p class=3D"x_xmsonormal">but in v2 patch,</p>
</div>
<div>
<p class=3D"x_xmsonormal">the patch adjust the order of code functions, it =
seems that this is a brand new function,</p>
</div>
<div>
<p class=3D"x_xmsonormal">I don't think it is necessary,</p>
</div>
<div>
<p class=3D"x_xmsonormal">could you just reflect the <b>modified content</b=
> in the patch, which can facilitate us to trace
<b>problems </b>and <b>review</b>.</p>
</div>
<div>
<p class=3D"x_xmsonormal">thanks.</p>
<div>
<p class=3D"x_xmsonormal">&nbsp;</p>
<p class=3D"x_xmsonormal"><b><i>[Quan, Evan] Move the API before the place =
it=92s called. No problem here.</i></b></p>
<p class=3D"x_xmsonormal">&nbsp;</p>
<p class=3D"x_xmsonormal"><b><i>[kevin]: in this patch, you don't need to a=
djust function order in this file,</i></b></p>
<p class=3D"x_xmsonormal"><b><i>because the driver is already export this f=
unction in amdgpu_smu.h.</i></b></p>
<p class=3D"x_xmsonormal"><b><i>int smu_feature_update_enable_state(struct =
smu_context *smu, uint64_t feature_mask, bool enabled);</i></b></p>
<p class=3D"x_xmsonormal"><b><i>and in this patch, it make it is static fun=
ction, but&nbsp;the declaration section remains in the amdgpu_smu.h file.</=
i></b></p>
<p class=3D"x_xmsonormal"><b><i>so i don't want to you adjust the function =
order and make it is static funtion in this patch.</i></b></p>
<p class=3D"x_xmsonormal"><b><i>except you have other reason for it.</i></b=
></p>
<div>
<p class=3D"x_MsoNormal"><b><i>&nbsp;</i></b></p>
</div>
</div>
<p class=3D"x_xmsonormal">-int smu_feature_update_enable_state(struct smu_c=
ontext *smu, uint64_t feature_mask, bool enabled)<br>
-{<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t feature_low =3D 0, feature_h=
igh =3D 0;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ret =3D 0;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!smu-&gt;pm_enabled)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return ret;<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; feature_low =3D (feature_mask &gt;&gt=
; 0 ) &amp; 0xffffffff;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; feature_high =3D (feature_mask &gt;&g=
t; 32) &amp; 0xffffffff;<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (enabled) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; ret =3D smu_send_smc_msg_with_param(smu, SMU_MSG_EnableSmuFeatur=
esLow,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; feature_lo=
w);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (ret)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; ret =3D smu_send_smc_msg_with_param(smu, SMU_MSG_EnableSmuFeatur=
esHigh,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; feature_hi=
gh);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (ret)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret;<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; ret =3D smu_send_smc_msg_with_param(smu, SMU_MSG_DisableSmuFeatu=
resLow,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; feature_lo=
w);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (ret)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; ret =3D smu_send_smc_msg_with_param(smu, SMU_MSG_DisableSmuFeatu=
resHigh,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; feature_hi=
gh);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (ret)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret;<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret;<br>
-}<br>
&nbsp;<br>
&nbsp;int smu_feature_is_enabled(struct smu_context *smu, enum smu_feature_=
mask mask)<br>
&nbsp;{<br>
@@ -651,8 &#43;666,6 @@ int smu_feature_set_enabled(struct smu_context *smu=
, enum smu_feature_mask mask,<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct smu_feature *featur=
e =3D &amp;smu-&gt;smu_feature;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int feature_id;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint64_t feature_mask =3D 0;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ret =3D 0;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; feature_id =3D smu_feature=
_get_index(smu, mask);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (<span style=3D"font-fa=
mily:&quot;Arial&quot;,sans-serif">feature_id </span>&lt; 0)<br>
@@ -660,22 &#43;673,9 @@ int smu_feature_set_enabled(struct smu_context *sm=
u, enum smu_feature_mask mask,<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WARN_ON(feature_id &gt; fe=
ature-&gt;feature_num);<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; feature_mask =3D 1ULL &lt;&lt; featur=
e_id;<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_lock(&amp;feature-&gt;mutex);<b=
r>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D smu_feature_update_enable_sta=
te(smu, feature_mask, enable);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; goto failed;<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (enable)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; test_and_set_bit(feature_id, feature-&gt;enabled);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; else<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; test_and_clear_bit(feature_id, feature-&gt;enabled);<br>
-<br>
-failed:<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_unlock(&amp;feature-&gt;mutex);=
<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return smu_feature_update_enable_=
state(smu,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1ULL &lt;&lt; feature_id=
,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; enable);<br>
&nbsp;}<br>
&nbsp;<br>
&nbsp;int smu_feature_is_supported(struct smu_context *smu, enum smu_featur=
e_mask mask)<br>
diff --git a/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h b/drivers/gpu/d=
rm/amd/powerplay/inc/amdgpu_smu.h<br>
index e80c81552d29..fbf68fd42b93 100644<br>
--- a/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h<br>
@@ -807,7 &#43;807,6 @@ enum amd_dpm_forced_level smu_get_performance_level=
(struct smu_context *smu);<br>
&nbsp;int smu_force_performance_level(struct smu_context *smu, enum amd_dpm=
_forced_level level);<br>
&nbsp;int smu_set_display_count(struct smu_context *smu, uint32_t count);<b=
r>
&nbsp;bool smu_clk_dpm_is_enabled(struct smu_context *smu, enum smu_clk_typ=
e clk_type);<br>
-int smu_feature_update_enable_state(struct smu_context *smu, uint64_t feat=
ure_mask, bool enabled);<br>
&nbsp;const char *smu_get_message_name(struct smu_context *smu, enum smu_me=
ssage_type type);<br>
&nbsp;const char *smu_get_feature_name(struct smu_context *smu, enum smu_fe=
ature_mask feature);<br>
&nbsp;size_t smu_sys_get_pp_feature_mask(struct smu_context *smu, char *buf=
);<br>
-- <br>
2.23.0<br>
<br>
_______________________________________________<br>
amd-gfx mailing list<br>
<a href=3D"mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">amd-gfx-PD4FTy7X32lNgt0PjOBp9/rsn8yoX9R0@public.gmane.org=
org</a><br>
<a href=3D"https://lists.freedesktop.org/mailman/listinfo/amd-gfx">https://=
lists.freedesktop.org/mailman/listinfo/amd-gfx</a></p>
</div>
</div>
</div>
</div>
</div>
</div>
</div>
</div>
</body>
</html>

--_000_MN2PR12MB32964C9C3DC3919188759C4EA2A40MN2PR12MB3296namp_--

--===============0155635703==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4

--===============0155635703==--
