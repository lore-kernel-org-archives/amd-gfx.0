From: "Quan, Evan" <Evan.Quan-5C7GfCeVMHo@public.gmane.org>
Subject: RE: [PATCH] drm/amd/powerplay: correct confusing naming for
 smu_feature_set_enabled
Date: Tue, 23 Jul 2019 01:31:06 +0000
Message-ID: <MN2PR12MB3344EE018407810C0812ABBCE4C70@MN2PR12MB3344.namprd12.prod.outlook.com>
References: <20190722063426.19597-1-evan.quan@amd.com>
 <MN2PR12MB3296197F32A37621120B9709A2C40@MN2PR12MB3296.namprd12.prod.outlook.com>,
 <MN2PR12MB3344C65D72C585B8104DDF5CE4C40@MN2PR12MB3344.namprd12.prod.outlook.com>
 <MN2PR12MB3296FC663977D86111AB364FA2C40@MN2PR12MB3296.namprd12.prod.outlook.com>,
 <MN2PR12MB334479EDA123FEC9920F539DE4C40@MN2PR12MB3344.namprd12.prod.outlook.com>
 <MN2PR12MB32968DC2D03AD32F447A729AA2C40@MN2PR12MB3296.namprd12.prod.outlook.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0658438008=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <MN2PR12MB32968DC2D03AD32F447A729AA2C40-rweVpJHSKTqAm9ToKNQgFgdYzm3356FpvxpqHgZTriW3zl9H0oFU5g@public.gmane.org>
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
To: "Wang, Kevin(Yang)" <Kevin1.Wang-5C7GfCeVMHo@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

--===============0658438008==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_MN2PR12MB3344EE018407810C0812ABBCE4C70MN2PR12MB3344namp_"

--_000_MN2PR12MB3344EE018407810C0812ABBCE4C70MN2PR12MB3344namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

smu_feature_set_enabled() is refreshed to update the stored copy only becau=
se there do has the use case.
Another example is vega20_set_ppfeature_status() which needs also updating =
the stored feature masks only. That is missing now and is a bug.
I have noticed that for a while and do not have time to fix that yet.

A new API smu_enable_smc_feature() is provided if you want to enable the hw=
 feature also(plus updating stored copy). The naming is much more straightf=
orward.

I cannot see any problem with these changes and cannot understand why you a=
re so resistant to them.

Regards,
Evan
From: Wang, Kevin(Yang) <Kevin1.Wang-5C7GfCeVMHo@public.gmane.org>
Sent: Monday, July 22, 2019 9:21 PM
To: Quan, Evan <Evan.Quan-5C7GfCeVMHo@public.gmane.org>; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Subject: Re: [PATCH] drm/amd/powerplay: correct confusing naming for smu_fe=
ature_set_enabled


it seems this feature is specific feature on some asic in smc firmware.

why not create a specific function to handle this case,



the apis of smu_feature_is_enabled and smu_feature_set_enabled is public ap=
i for all smu asic.
how can you be sure that message must have the same logic on other asics in=
 SMC firwamre.

may be this case not work on other smu or other asic.


if you still do, it means that when developer use smu_feature_is_enabled ap=
i,

the user must know the message detail information in smc firmware.



sw-bitmap and smc firwmare bitmap must be same in smu driver.
if not, this sw-bitmap is meaningless.


Best Regards,

Kevin

________________________________
From: Quan, Evan <Evan.Quan-5C7GfCeVMHo@public.gmane.org<mailto:Evan.Quan-5C7GfCeVMHo@public.gmane.org>>
Sent: Monday, July 22, 2019 8:45:15 PM
To: Wang, Kevin(Yang) <Kevin1.Wang-5C7GfCeVMHo@public.gmane.org<mailto:Kevin1.Wang-5C7GfCeVMHo@public.gmane.org>>; am=
d-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org> <amd-gfx@=
lists.freedesktop.org<mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>>
Subject: RE: [PATCH] drm/amd/powerplay: correct confusing naming for smu_fe=
ature_set_enabled


The implementation of SMU_MSG_PowerDown[UP]Vcn (in smu fw) already includes=
 the identical hardware enablement/disablement of SMU_FEATURE_VCN_PG_BIT.

Thus after that, only update the bitmask is enough. This is done on purpose=
.



Regards,

Evan

From: Wang, Kevin(Yang) <Kevin1.Wang-5C7GfCeVMHo@public.gmane.org<mailto:Kevin1.Wang-5C7GfCeVMHo@public.gmane.org>>
Sent: Monday, July 22, 2019 4:11 PM
To: Quan, Evan <Evan.Quan-5C7GfCeVMHo@public.gmane.org<mailto:Evan.Quan-5C7GfCeVMHo@public.gmane.org>>; amd-gfx@lists=
.freedesktop.org<mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
Subject: Re: [PATCH] drm/amd/powerplay: correct confusing naming for smu_fe=
ature_set_enabled



in fact, the smu feature bitmap is cached of smc firmware hardware bitmap,

most of time, when driver want to check whether enable is available.

the driver should talk with smc to check featue enabled.

i think it is very low efficiency.

so the driver will provide a bitmap structure to store hardware feature sta=
tus.

every time, the driver update hardware feature state, also should be update=
 software bitmap to sync it.



if only update bitmap and don't set firmware feature enabled, the smu_featu=
re_is_enabeld is maybe not work correctly.



in your previous patch:

drm/amd/powerplay: correct Navi10 VCN powergate control.

after your patch,

the function smu_feature_is_enabled(smu, SMU_FEATURE_VCN_PG_BIT)

will retrun true, but in the firmware, this feature maybe is not enabled.



so the function smu_feature_is_enabled is not work well.



and smu_feature_is_supported  is full software feature, this is helper func=
tion to set allowed feature mask when smu power on,

but this function is not used in smu driver, i want to remove them long lon=
g ago.



Best Regards,
Kevin



________________________________

From: Quan, Evan <Evan.Quan-5C7GfCeVMHo@public.gmane.org<mailto:Evan.Quan-5C7GfCeVMHo@public.gmane.org>>
Sent: Monday, July 22, 2019 3:17:55 PM
To: Wang, Kevin(Yang) <Kevin1.Wang-5C7GfCeVMHo@public.gmane.org<mailto:Kevin1.Wang-5C7GfCeVMHo@public.gmane.org>>; am=
d-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org> <amd-gfx@=
lists.freedesktop.org<mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>>
Subject: RE: [PATCH] drm/amd/powerplay: correct confusing naming for smu_fe=
ature_set_enabled



I cannot get your point. What do you mean "pairs of functions"?

Yes, this patch does not bring real changes.

But this helps for future maintain and fit common logic.

1. As in my previous patch("drm/amd/powerplay: correct Navi10 VCN powergate=
 control" ),  "smu_feature_set_enabled(smu, SMU_FEATURE_VCN_PG_BIT, enable)=
;" was mistakenly used. I thought and expected smu_feature_set_enabled set =
the bitmask on only. I do not want it to enable or disable the feature.

2. smu_feature_set_enabled should in the same logic as smu_feature_set_supp=
orted. It updates only the saved bit mask. That's the expected behavior for=
 some APIs named as _set_enabled/supported.

3. The original callers who want feature enablement/disablement are updated=
 to use smu_enable_smc_feature(). I do not see any problem with that.



Regards,

Evan

From: Wang, Kevin(Yang) <Kevin1.Wang-5C7GfCeVMHo@public.gmane.org<mailto:Kevin1.Wang-5C7GfCeVMHo@public.gmane.org>>
Sent: Monday, July 22, 2019 3:00 PM
To: Quan, Evan <Evan.Quan-5C7GfCeVMHo@public.gmane.org<mailto:Evan.Quan-5C7GfCeVMHo@public.gmane.org>>; amd-gfx@lists=
.freedesktop.org<mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
Subject: Re: [PATCH] drm/amd/powerplay: correct confusing naming for smu_fe=
ature_set_enabled



before this patch, we have 4 apis to manage smu feature bits.

the patch add a new one in them, but it is not add any feature in smu.



before your patch:

smu_feature_is_enabled and smu_feature_set_enabled is pair of functions,

after your patch:

smu_feature_is_enabled and smu_enable_smc_feature is pair of functions;



so the driver don't have scenario needs to use smu_feature_set_enabeld,

do you agree it?



most of the time we update SMC feature, we must update software bitmap in s=
mu_feature structure.

if not, the smu_feature_is_enabled funciton is not work well.



extern int smu_feature_init_dpm(struct smu_context *smu);

extern int smu_feature_is_enabled(struct smu_context *smu,

  enum smu_feature_mask mask);

extern int smu_feature_set_enabled(struct smu_context *smu,

   enum smu_feature_mask mask, bool enable);

extern int smu_feature_is_supported(struct smu_context *smu,

    enum smu_feature_mask mask);

extern int smu_feature_set_supported(struct smu_context *smu,

     enum smu_feature_mask mask, bool enable);



Best Regards,
Kevin

________________________________

From: amd-gfx <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<mailto:amd-gfx-bounces=
@lists.freedesktop.org>> on behalf of Evan Quan <evan.quan-5C7GfCeVMHo@public.gmane.org<mailto:e=
van.quan-5C7GfCeVMHo@public.gmane.org>>
Sent: Monday, July 22, 2019 2:34:26 PM
To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org> <am=
d-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>>
Cc: Quan, Evan <Evan.Quan-5C7GfCeVMHo@public.gmane.org<mailto:Evan.Quan-5C7GfCeVMHo@public.gmane.org>>
Subject: [PATCH] drm/amd/powerplay: correct confusing naming for smu_featur=
e_set_enabled



It does more than updating the bitmask. In fact it enables also the
feature. That's confusing. As for this, a new API is added for the
feature enablement job. And smu_feature_set_enabled is updated to
setting the bitmask only(as smu_feature_set_supported).

Change-Id: I758e4461be34c0fcbdf19448e34180a5251926c4
Signed-off-by: Evan Quan <evan.quan-5C7GfCeVMHo@public.gmane.org<mailto:evan.quan-5C7GfCeVMHo@public.gmane.org>>
---
 drivers/gpu/drm/amd/powerplay/amdgpu_smu.c    | 29 +++++++++++++------
 .../gpu/drm/amd/powerplay/inc/amdgpu_smu.h    |  2 ++
 drivers/gpu/drm/amd/powerplay/smu_v11_0.c     |  2 +-
 drivers/gpu/drm/amd/powerplay/vega20_ppt.c    |  4 +--
 4 files changed, 25 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c b/drivers/gpu/drm/a=
md/powerplay/amdgpu_smu.c
index 4e18f33a1bab..9262883d4031 100644
--- a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
@@ -511,28 +511,39 @@ int smu_feature_set_enabled(struct smu_context *smu, =
enum smu_feature_mask mask,
 {
         struct smu_feature *feature =3D &smu->smu_feature;
         int feature_id;
-       int ret =3D 0;

         feature_id =3D smu_feature_get_index(smu, mask);
         if (feature_id < 0)
                 return -EINVAL;

-       WARN_ON(feature_id > feature->feature_num);
-
         mutex_lock(&feature->mutex);
-       ret =3D smu_feature_update_enable_state(smu, feature_id, enable);
-       if (ret)
-               goto failed;

         if (enable)
                 test_and_set_bit(feature_id, feature->enabled);
         else
                 test_and_clear_bit(feature_id, feature->enabled);

-failed:
         mutex_unlock(&feature->mutex);

-       return ret;
+       return 0;
+}
+
+int smu_enable_smc_feature(struct smu_context *smu,
+                          enum smu_feature_mask mask,
+                          bool enable)
+{
+       int feature_id;
+       int ret =3D 0;
+
+       feature_id =3D smu_feature_get_index(smu, mask);
+       if (feature_id < 0)
+               return -EINVAL;
+
+       ret =3D smu_feature_update_enable_state(smu, feature_id, enable);
+       if (ret)
+               return ret;
+
+       return smu_feature_set_enabled(smu, mask, enable);
 }

 int smu_feature_is_supported(struct smu_context *smu, enum smu_feature_mas=
k mask)
@@ -1186,7 +1197,7 @@ static int smu_suspend(void *handle)
                 return ret;

         if (adev->in_gpu_reset && baco_feature_is_enabled) {
-               ret =3D smu_feature_set_enabled(smu, SMU_FEATURE_BACO_BIT, =
true);
+               ret =3D smu_enable_smc_feature(smu, SMU_FEATURE_BACO_BIT, t=
rue);
                 if (ret) {
                         pr_warn("set BACO feature enabled failed, return %=
d\n", ret);
                         return ret;
diff --git a/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h b/drivers/gpu/d=
rm/amd/powerplay/inc/amdgpu_smu.h
index b702c9ee975f..267b879796f9 100644
--- a/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h
+++ b/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h
@@ -946,6 +946,8 @@ extern int smu_feature_is_enabled(struct smu_context *s=
mu,
                                   enum smu_feature_mask mask);
 extern int smu_feature_set_enabled(struct smu_context *smu,
                                    enum smu_feature_mask mask, bool enable=
);
+extern int smu_enable_smc_feature(struct smu_context *smu,
+                                  enum smu_feature_mask mask, bool enable)=
;
 extern int smu_feature_is_supported(struct smu_context *smu,
                                     enum smu_feature_mask mask);
 extern int smu_feature_set_supported(struct smu_context *smu,
diff --git a/drivers/gpu/drm/amd/powerplay/smu_v11_0.c b/drivers/gpu/drm/am=
d/powerplay/smu_v11_0.c
index e3a178403546..0f59d2178d01 100644
--- a/drivers/gpu/drm/amd/powerplay/smu_v11_0.c
+++ b/drivers/gpu/drm/amd/powerplay/smu_v11_0.c
@@ -1419,7 +1419,7 @@ smu_v11_0_smc_fan_control(struct smu_context *smu, bo=
ol start)
         if (smu_feature_is_supported(smu, SMU_FEATURE_FAN_CONTROL_BIT))
                 return 0;

-       ret =3D smu_feature_set_enabled(smu, SMU_FEATURE_FAN_CONTROL_BIT, s=
tart);
+       ret =3D smu_enable_smc_feature(smu, SMU_FEATURE_FAN_CONTROL_BIT, st=
art);
         if (ret)
                 pr_err("[%s]%s smc FAN CONTROL feature failed!",
                        __func__, (start ? "Start" : "Stop"));
diff --git a/drivers/gpu/drm/amd/powerplay/vega20_ppt.c b/drivers/gpu/drm/a=
md/powerplay/vega20_ppt.c
index 9ead36192787..536ff884ddca 100644
--- a/drivers/gpu/drm/amd/powerplay/vega20_ppt.c
+++ b/drivers/gpu/drm/amd/powerplay/vega20_ppt.c
@@ -2845,7 +2845,7 @@ static int vega20_dpm_set_uvd_enable(struct smu_conte=
xt *smu, bool enable)
         if (enable =3D=3D smu_feature_is_enabled(smu, SMU_FEATURE_DPM_UVD_=
BIT))
                 return 0;

-       return smu_feature_set_enabled(smu, SMU_FEATURE_DPM_UVD_BIT, enable=
);
+       return smu_enable_smc_feature(smu, SMU_FEATURE_DPM_UVD_BIT, enable)=
;
 }

 static int vega20_dpm_set_vce_enable(struct smu_context *smu, bool enable)
@@ -2856,7 +2856,7 @@ static int vega20_dpm_set_vce_enable(struct smu_conte=
xt *smu, bool enable)
         if (enable =3D=3D smu_feature_is_enabled(smu, SMU_FEATURE_DPM_VCE_=
BIT))
                 return 0;

-       return smu_feature_set_enabled(smu, SMU_FEATURE_DPM_VCE_BIT, enable=
);
+       return smu_enable_smc_feature(smu, SMU_FEATURE_DPM_VCE_BIT, enable)=
;
 }

 static int vega20_get_enabled_smc_features(struct smu_context *smu,
--
2.22.0

_______________________________________________
amd-gfx mailing list
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--_000_MN2PR12MB3344EE018407810C0812ABBCE4C70MN2PR12MB3344namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" xmlns:o=3D"urn:schemas-micr=
osoft-com:office:office" xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" xmlns=3D"http:=
//www.w3.org/TR/REC-html40">
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<meta name=3D"Generator" content=3D"Microsoft Word 15 (filtered medium)">
<!--[if !mso]><style>v\:* {behavior:url(#default#VML);}
o\:* {behavior:url(#default#VML);}
w\:* {behavior:url(#default#VML);}
.shape {behavior:url(#default#VML);}
</style><![endif]--><style><!--
/* Font Definitions */
@font-face
	{font-family:SimSun;
	panose-1:2 1 6 0 3 1 1 1 1 1;}
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
@font-face
	{font-family:SimSun;
	panose-1:2 1 6 0 3 1 1 1 1 1;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	margin-bottom:.0001pt;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:blue;
	text-decoration:underline;}
a:visited, span.MsoHyperlinkFollowed
	{mso-style-priority:99;
	color:purple;
	text-decoration:underline;}
p.msonormal0, li.msonormal0, div.msonormal0
	{mso-style-name:msonormal;
	margin:0in;
	margin-bottom:.0001pt;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
p.xmsonormal, li.xmsonormal, div.xmsonormal
	{mso-style-name:x_msonormal;
	margin:0in;
	margin-bottom:.0001pt;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
p.xmsonormal0, li.xmsonormal0, div.xmsonormal0
	{mso-style-name:x_msonormal0;
	margin:0in;
	margin-bottom:.0001pt;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
p.xxmsonormal, li.xxmsonormal, div.xxmsonormal
	{mso-style-name:x_xmsonormal;
	margin:0in;
	margin-bottom:.0001pt;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
p.xxmsonormal0, li.xxmsonormal0, div.xxmsonormal0
	{mso-style-name:x_xmsonormal0;
	margin:0in;
	margin-bottom:.0001pt;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
p.xxmsochpdefault, li.xxmsochpdefault, div.xxmsochpdefault
	{mso-style-name:x_xmsochpdefault;
	mso-margin-top-alt:auto;
	margin-right:0in;
	mso-margin-bottom-alt:auto;
	margin-left:0in;
	font-size:10.0pt;
	font-family:"Calibri",sans-serif;}
p.xmsochpdefault, li.xmsochpdefault, div.xmsochpdefault
	{mso-style-name:x_msochpdefault;
	mso-margin-top-alt:auto;
	margin-right:0in;
	mso-margin-bottom-alt:auto;
	margin-left:0in;
	font-size:10.0pt;
	font-family:"Calibri",sans-serif;}
span.xmsohyperlink
	{mso-style-name:x_msohyperlink;
	color:blue;
	text-decoration:underline;}
span.xmsohyperlinkfollowed
	{mso-style-name:x_msohyperlinkfollowed;
	color:purple;
	text-decoration:underline;}
span.xxmsohyperlink
	{mso-style-name:x_xmsohyperlink;
	color:blue;
	text-decoration:underline;}
span.xxmsohyperlinkfollowed
	{mso-style-name:x_xmsohyperlinkfollowed;
	color:purple;
	text-decoration:underline;}
span.xxemailstyle18
	{mso-style-name:x_xemailstyle18;
	font-family:"Calibri",sans-serif;
	color:windowtext;}
span.xemailstyle26
	{mso-style-name:x_emailstyle26;
	font-family:"Calibri",sans-serif;
	color:windowtext;}
span.EmailStyle32
	{mso-style-type:personal-reply;
	font-family:"Calibri",sans-serif;
	color:windowtext;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-size:10.0pt;}
@page WordSection1
	{size:8.5in 11.0in;
	margin:1.0in 1.25in 1.0in 1.25in;}
div.WordSection1
	{page:WordSection1;}
--></style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext=3D"edit">
<o:idmap v:ext=3D"edit" data=3D"1" />
</o:shapelayout></xml><![endif]-->
</head>
<body lang=3D"EN-US" link=3D"blue" vlink=3D"purple">
<div class=3D"WordSection1">
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black">smu_fea=
ture_set_enabled() is refreshed to update the stored copy only because ther=
e do has the use case.</span><o:p></o:p></p>
<p class=3D"MsoNormal">Another example is vega20_set_ppfeature_status() whi=
ch needs also updating the stored feature masks only. That is missing now a=
nd is a bug.
<o:p></o:p></p>
<p class=3D"MsoNormal">I have noticed that for a while and do not have time=
 to fix that yet.<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">A new API smu_enable_smc_feature() is provided if yo=
u want to enable the hw feature also(plus updating stored copy). The naming=
 is much more straightforward.
<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">I cannot see any problem with these changes and cann=
ot understand why you are so resistant to them.<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Regards,<o:p></o:p></p>
<p class=3D"MsoNormal">Evan<o:p></o:p></p>
<div style=3D"border:none;border-left:solid blue 1.5pt;padding:0in 0in 0in =
4.0pt">
<div>
<div style=3D"border:none;border-top:solid #E1E1E1 1.0pt;padding:3.0pt 0in =
0in 0in">
<p class=3D"MsoNormal"><b>From:</b> Wang, Kevin(Yang) &lt;Kevin1.Wang@amd.c=
om&gt; <br>
<b>Sent:</b> Monday, July 22, 2019 9:21 PM<br>
<b>To:</b> Quan, Evan &lt;Evan.Quan-5C7GfCeVMHo@public.gmane.org&gt;; amd-gfx-PD4FTy7X32lNgt0PjOBp9/rsn8yoX9R0@public.gmane.org=
org<br>
<b>Subject:</b> Re: [PATCH] drm/amd/powerplay: correct confusing naming for=
 smu_feature_set_enabled<o:p></o:p></p>
</div>
</div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<div id=3D"divtagdefaultwrapper">
<p><span style=3D"font-size:12.0pt;color:black">it seems this feature is sp=
ecific feature on some asic in smc firmware.<o:p></o:p></span></p>
<p><span style=3D"font-size:12.0pt;color:black">why not create a specific f=
unction to handle this case,<o:p></o:p></span></p>
<p><span style=3D"font-size:12.0pt;color:black"><o:p>&nbsp;</o:p></span></p=
>
<p><span style=3D"font-size:12.0pt;color:black">the apis of&nbsp;smu_featur=
e_is_enabled and smu_feature_set_enabled is public api for all smu asic.<br=
>
how can you be sure that message must have the same logic on other asics&nb=
sp;in SMC firwamre.<o:p></o:p></span></p>
<p><span style=3D"font-size:12.0pt;color:black">may be this case not work o=
n other smu or other asic.<o:p></o:p></span></p>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black"><o:p>&n=
bsp;</o:p></span></p>
</div>
<p><span style=3D"font-size:12.0pt;color:black">if you still do, it means t=
hat&nbsp;when developer use smu_feature_is_enabled api,<o:p></o:p></span></=
p>
<p><span style=3D"font-size:12.0pt;color:black">the user must know the mess=
age detail information in smc firmware.<o:p></o:p></span></p>
<p><span style=3D"font-size:12.0pt;color:black"><o:p>&nbsp;</o:p></span></p=
>
<p><span style=3D"font-size:12.0pt;color:black">sw-bitmap and smc firwmare =
bitmap must be same in smu driver.<o:p></o:p></span></p>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black">if not,=
&nbsp;this sw-bitmap is meaningless.<o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black"><o:p>&n=
bsp;</o:p></span></p>
</div>
<p><span style=3D"font-size:12.0pt;color:black">Best Regards,<o:p></o:p></s=
pan></p>
<p><span style=3D"font-size:12.0pt;color:black">Kevin<o:p></o:p></span></p>
</div>
<div class=3D"MsoNormal" align=3D"center" style=3D"text-align:center">
<hr size=3D"2" width=3D"98%" align=3D"center">
</div>
<div id=3D"divRplyFwdMsg">
<p class=3D"MsoNormal"><b><span style=3D"color:black">From:</span></b><span=
 style=3D"color:black"> Quan, Evan &lt;<a href=3D"mailto:Evan.Quan-5C7GfCeVMHo@public.gmane.org"=
>Evan.Quan-5C7GfCeVMHo@public.gmane.org</a>&gt;<br>
<b>Sent:</b> Monday, July 22, 2019 8:45:15 PM<br>
<b>To:</b> Wang, Kevin(Yang) &lt;<a href=3D"mailto:Kevin1.Wang-5C7GfCeVMHo@public.gmane.org">Kev=
in1.Wang-5C7GfCeVMHo@public.gmane.org</a>&gt;;
<a href=3D"mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">amd-gfx-PD4FTy7X32lNgt0PjOBp9/rsn8yoX9R0@public.gmane.org=
org</a> &lt;<a href=3D"mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">amd-gfx@lists.=
freedesktop.org</a>&gt;<br>
<b>Subject:</b> RE: [PATCH] drm/amd/powerplay: correct confusing naming for=
 smu_feature_set_enabled</span>
<o:p></o:p></p>
<div>
<p class=3D"MsoNormal">&nbsp;<o:p></o:p></p>
</div>
</div>
<div>
<div>
<p class=3D"xmsonormal">The implementation of SMU_MSG_PowerDown[UP]Vcn (in =
smu fw) already includes the identical hardware enablement/disablement of S=
MU_FEATURE_VCN_PG_BIT.<o:p></o:p></p>
<p class=3D"xmsonormal">Thus after that, only update the bitmask is enough.=
 This is done on purpose.<o:p></o:p></p>
<p class=3D"xmsonormal">&nbsp;<o:p></o:p></p>
<p class=3D"xmsonormal">Regards,<o:p></o:p></p>
<p class=3D"xmsonormal">Evan<o:p></o:p></p>
<div style=3D"border:none;border-left:solid blue 1.5pt;padding:0in 0in 0in =
4.0pt">
<div>
<div style=3D"border:none;border-top:solid #E1E1E1 1.0pt;padding:3.0pt 0in =
0in 0in">
<p class=3D"xmsonormal"><b>From:</b> Wang, Kevin(Yang) &lt;<a href=3D"mailt=
o:Kevin1.Wang-5C7GfCeVMHo@public.gmane.org">Kevin1.Wang-5C7GfCeVMHo@public.gmane.org</a>&gt;
<br>
<b>Sent:</b> Monday, July 22, 2019 4:11 PM<br>
<b>To:</b> Quan, Evan &lt;<a href=3D"mailto:Evan.Quan-5C7GfCeVMHo@public.gmane.org">Evan.Quan@am=
d.com</a>&gt;;
<a href=3D"mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">amd-gfx-PD4FTy7X32lNgt0PjOBp9/rsn8yoX9R0@public.gmane.org=
org</a><br>
<b>Subject:</b> Re: [PATCH] drm/amd/powerplay: correct confusing naming for=
 smu_feature_set_enabled<o:p></o:p></p>
</div>
</div>
<p class=3D"xmsonormal">&nbsp;<o:p></o:p></p>
<div id=3D"x_divtagdefaultwrapper">
<p><span style=3D"font-size:12.0pt;color:black">in fact, the smu feature bi=
tmap is cached of smc firmware hardware&nbsp;bitmap,</span><o:p></o:p></p>
<p><span style=3D"font-size:12.0pt;color:black">most of time, when driver w=
ant to check whether enable is available.</span><o:p></o:p></p>
<div>
<p class=3D"xmsonormal"><span style=3D"font-size:12.0pt;color:black">the dr=
iver should talk with smc to check featue enabled.&nbsp;</span><o:p></o:p><=
/p>
</div>
<div>
<p class=3D"xmsonormal"><span style=3D"font-size:12.0pt;color:black">i thin=
k it is very low efficiency.</span><o:p></o:p></p>
</div>
<p><span style=3D"font-size:12.0pt;color:black">so the driver will provide =
a bitmap structure to store hardware&nbsp;feature status.</span><o:p></o:p>=
</p>
<p><span style=3D"font-size:12.0pt;color:black">every time, the driver upda=
te hardware feature state, also should be update software bitmap to sync it=
.</span><o:p></o:p></p>
<p><span style=3D"font-size:12.0pt;color:black">&nbsp;</span><o:p></o:p></p=
>
<p><span style=3D"font-size:12.0pt;color:black">if only update bitmap and d=
on't set firmware feature enabled, the smu_feature_is_enabeld is maybe not =
work correctly.</span><o:p></o:p></p>
<p><span style=3D"font-size:12.0pt;color:black">&nbsp;</span><o:p></o:p></p=
>
<p><span style=3D"font-size:12.0pt;color:black">in your previous patch:</sp=
an><o:p></o:p></p>
<p><span style=3D"color:#212121">drm/amd/powerplay: correct Navi10 VCN powe=
rgate control.</span><o:p></o:p></p>
<p><span style=3D"font-size:12.0pt;color:black">after your patch,&nbsp;</sp=
an><o:p></o:p></p>
<p><span style=3D"font-size:12.0pt;color:black">the function&nbsp;smu_featu=
re_is_enabled(smu, SMU_FEATURE_VCN_PG_BIT)</span><o:p></o:p></p>
<p><span style=3D"font-size:12.0pt;color:black">will retrun true, but in th=
e firmware, this feature maybe is not enabled.</span><o:p></o:p></p>
<p><span style=3D"font-size:12.0pt;color:black">&nbsp;</span><o:p></o:p></p=
>
<p><span style=3D"font-size:12.0pt;color:black">so the function&nbsp;smu_fe=
ature_is_enabled is not work well.</span><o:p></o:p></p>
<p><span style=3D"font-size:12.0pt;color:black">&nbsp;</span><o:p></o:p></p=
>
<p><span style=3D"font-size:12.0pt;color:black">and smu_feature_is_supporte=
d&nbsp;&nbsp;is full software&nbsp;feature, this is helper function to set =
allowed feature mask when smu power on,</span><o:p></o:p></p>
<p><span style=3D"font-size:12.0pt;color:black">but this function is not us=
ed in smu driver,&nbsp;i want to remove them long long ago.</span><o:p></o:=
p></p>
<p><span style=3D"font-size:12.0pt;color:black">&nbsp;</span><o:p></o:p></p=
>
<p><span style=3D"font-size:12.0pt;color:black">Best Regards,<br>
Kevin</span><o:p></o:p></p>
<div>
<p class=3D"xmsonormal"><span style=3D"font-size:12.0pt;color:black">&nbsp;=
</span><o:p></o:p></p>
</div>
</div>
<div class=3D"MsoNormal" align=3D"center" style=3D"text-align:center">
<hr size=3D"2" width=3D"98%" align=3D"center">
</div>
<div id=3D"x_divRplyFwdMsg">
<p class=3D"xmsonormal"><b><span style=3D"color:black">From:</span></b><spa=
n style=3D"color:black"> Quan, Evan &lt;<a href=3D"mailto:Evan.Quan-5C7GfCeVMHo@public.gmane.org=
">Evan.Quan-5C7GfCeVMHo@public.gmane.org</a>&gt;<br>
<b>Sent:</b> Monday, July 22, 2019 3:17:55 PM<br>
<b>To:</b> Wang, Kevin(Yang) &lt;<a href=3D"mailto:Kevin1.Wang-5C7GfCeVMHo@public.gmane.org">Kev=
in1.Wang-5C7GfCeVMHo@public.gmane.org</a>&gt;;
<a href=3D"mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">amd-gfx-PD4FTy7X32lNgt0PjOBp9/rsn8yoX9R0@public.gmane.org=
org</a> &lt;<a href=3D"mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">amd-gfx@lists.=
freedesktop.org</a>&gt;<br>
<b>Subject:</b> RE: [PATCH] drm/amd/powerplay: correct confusing naming for=
 smu_feature_set_enabled</span>
<o:p></o:p></p>
<div>
<p class=3D"xmsonormal">&nbsp;<o:p></o:p></p>
</div>
</div>
<div>
<div>
<p class=3D"xxmsonormal">I cannot get your point. What do you mean &#8220;p=
airs of functions&#8221;?<o:p></o:p></p>
<p class=3D"xxmsonormal">Yes, this patch does not bring real changes.<o:p><=
/o:p></p>
<p class=3D"xxmsonormal">But this helps for future maintain and fit common =
logic.<o:p></o:p></p>
<p class=3D"xxmsonormal">1. As in my previous patch(&#8220;drm/amd/powerpla=
y: correct Navi10 VCN powergate control&#8221; ), &nbsp;&#8220;smu_feature_=
set_enabled(smu, SMU_FEATURE_VCN_PG_BIT, enable);&#8221; was mistakenly use=
d. I thought and expected smu_feature_set_enabled set the bitmask
 on only. I do not want it to enable or disable the feature.<o:p></o:p></p>
<p class=3D"xxmsonormal">2. smu_feature_set_enabled should in the same logi=
c as smu_feature_set_supported. It updates only the saved bit mask. That&#8=
217;s the expected behavior for some APIs named as _<i>set</i>_enabled/supp=
orted.<o:p></o:p></p>
<p class=3D"xxmsonormal">3. The original callers who want feature enablemen=
t/disablement are updated to use smu_enable_smc_feature(). I do not see any=
 problem with that.<o:p></o:p></p>
<p class=3D"xxmsonormal">&nbsp;<o:p></o:p></p>
<p class=3D"xxmsonormal">Regards,<o:p></o:p></p>
<p class=3D"xxmsonormal">Evan<o:p></o:p></p>
<div style=3D"border:none;border-left:solid blue 1.5pt;padding:0in 0in 0in =
4.0pt">
<div>
<div style=3D"border:none;border-top:solid #E1E1E1 1.0pt;padding:3.0pt 0in =
0in 0in">
<p class=3D"xxmsonormal"><b>From:</b> Wang, Kevin(Yang) &lt;<a href=3D"mail=
to:Kevin1.Wang-5C7GfCeVMHo@public.gmane.org">Kevin1.Wang-5C7GfCeVMHo@public.gmane.org</a>&gt;
<br>
<b>Sent:</b> Monday, July 22, 2019 3:00 PM<br>
<b>To:</b> Quan, Evan &lt;<a href=3D"mailto:Evan.Quan-5C7GfCeVMHo@public.gmane.org">Evan.Quan@am=
d.com</a>&gt;;
<a href=3D"mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">amd-gfx-PD4FTy7X32lNgt0PjOBp9/rsn8yoX9R0@public.gmane.org=
org</a><br>
<b>Subject:</b> Re: [PATCH] drm/amd/powerplay: correct confusing naming for=
 smu_feature_set_enabled<o:p></o:p></p>
</div>
</div>
<p class=3D"xxmsonormal">&nbsp;<o:p></o:p></p>
<div id=3D"x_x_divtagdefaultwrapper">
<p class=3D"xxmsonormal"><span style=3D"font-size:12.0pt;color:black">befor=
e this patch, we have 4 apis to manage smu feature bits.
</span><o:p></o:p></p>
<div>
<p class=3D"xxmsonormal"><span style=3D"font-size:12.0pt;color:black">the p=
atch add a new one in them, but it is not add any feature in smu.</span><o:=
p></o:p></p>
</div>
<div>
<p class=3D"xxmsonormal"><span style=3D"font-size:12.0pt;color:black">&nbsp=
;</span><o:p></o:p></p>
</div>
<div>
<p class=3D"xxmsonormal"><span style=3D"font-size:12.0pt;color:black">befor=
e your patch:</span><o:p></o:p></p>
</div>
<div>
<p class=3D"xxmsonormal"><span style=3D"font-size:12.0pt;color:black">smu_f=
eature_is_enabled and smu_feature_set_enabled is pair of functions,</span><=
o:p></o:p></p>
</div>
<div>
<p class=3D"xxmsonormal"><span style=3D"font-size:12.0pt;color:black">after=
 your patch:</span><o:p></o:p></p>
</div>
<div>
<p class=3D"xxmsonormal"><span style=3D"font-size:12.0pt;color:black">smu_f=
eature_is_enabled and smu_enable_smc_feature is pair of functions;</span><o=
:p></o:p></p>
</div>
<div>
<p class=3D"xxmsonormal"><span style=3D"font-size:12.0pt;color:black">&nbsp=
;</span><o:p></o:p></p>
</div>
<div>
<p class=3D"xxmsonormal"><span style=3D"font-size:12.0pt;color:black">so th=
e driver don't have&nbsp;scenario needs to use smu_feature_set_enabeld,&nbs=
p;</span><o:p></o:p></p>
</div>
<div>
<p class=3D"xxmsonormal"><span style=3D"font-size:12.0pt;color:black">do yo=
u agree it?</span><o:p></o:p></p>
</div>
<div>
<p class=3D"xxmsonormal"><span style=3D"font-size:12.0pt;color:black">&nbsp=
;</span><o:p></o:p></p>
</div>
<div>
<p class=3D"xxmsonormal"><span style=3D"font-size:12.0pt;color:black">most =
of the time we update SMC feature, we must update software bitmap in smu_fe=
ature structure.</span><o:p></o:p></p>
</div>
<div>
<p class=3D"xxmsonormal"><span style=3D"font-size:12.0pt;color:black">if no=
t, the smu_feature_is_enabled funciton is not work well.</span><o:p></o:p><=
/p>
</div>
<div>
<p class=3D"xxmsonormal"><span style=3D"font-size:12.0pt;color:black">&nbsp=
;</span><o:p></o:p></p>
</div>
<div>
<div>
<p class=3D"xxmsonormal"><span style=3D"font-size:9.0pt;color:black">extern=
 int smu_feature_init_dpm(struct smu_context *smu);</span><o:p></o:p></p>
</div>
<div>
<p class=3D"xxmsonormal"><span style=3D"font-size:9.0pt;color:black">extern=
 int smu_feature_is_enabled(struct smu_context *smu,</span><o:p></o:p></p>
</div>
<div>
<p class=3D"xxmsonormal"><span style=3D"font-size:9.0pt;color:black">&nbsp;=
 enum smu_feature_mask mask);</span><o:p></o:p></p>
</div>
<div>
<p class=3D"xxmsonormal"><span style=3D"font-size:9.0pt;color:black">extern=
 int smu_feature_set_enabled(struct smu_context *smu,</span><o:p></o:p></p>
</div>
<div>
<p class=3D"xxmsonormal"><span style=3D"font-size:9.0pt;color:black">&nbsp;=
 &nbsp;enum smu_feature_mask mask, bool enable);</span><o:p></o:p></p>
</div>
<div>
<p class=3D"xxmsonormal"><span style=3D"font-size:9.0pt;color:black">extern=
 int smu_feature_is_supported(struct smu_context *smu,</span><o:p></o:p></p=
>
</div>
<div>
<p class=3D"xxmsonormal"><span style=3D"font-size:9.0pt;color:black">&nbsp;=
 &nbsp; enum smu_feature_mask mask);</span><o:p></o:p></p>
</div>
<div>
<p class=3D"xxmsonormal"><span style=3D"font-size:9.0pt;color:black">extern=
 int smu_feature_set_supported(struct smu_context *smu,</span><o:p></o:p></=
p>
</div>
<div>
<p class=3D"xxmsonormal"><span style=3D"font-size:9.0pt;color:black">&nbsp;=
 &nbsp; &nbsp;enum smu_feature_mask mask, bool enable);</span><o:p></o:p></=
p>
</div>
<p class=3D"xxmsonormal"><span style=3D"font-size:12.0pt;color:black">&nbsp=
;</span><o:p></o:p></p>
</div>
<div>
<p class=3D"xxmsonormal"><span style=3D"font-size:12.0pt;color:black">Best =
Regards,<br>
Kevin</span><o:p></o:p></p>
</div>
</div>
<div class=3D"MsoNormal" align=3D"center" style=3D"text-align:center">
<hr size=3D"2" width=3D"98%" align=3D"center">
</div>
<div id=3D"x_x_divRplyFwdMsg">
<p class=3D"xxmsonormal"><b><span style=3D"color:black">From:</span></b><sp=
an style=3D"color:black"> amd-gfx &lt;</span><a href=3D"mailto:amd-gfx-boun=
ces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a><span s=
tyle=3D"color:black">&gt; on behalf of Evan Quan
 &lt;</span><a href=3D"mailto:evan.quan-5C7GfCeVMHo@public.gmane.org">evan.quan-5C7GfCeVMHo@public.gmane.org</a><span=
 style=3D"color:black">&gt;<br>
<b>Sent:</b> Monday, July 22, 2019 2:34:26 PM<br>
<b>To:</b> </span><a href=3D"mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">amd-gfx@=
lists.freedesktop.org</a><span style=3D"color:black"> &lt;</span><a href=3D=
"mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a><sp=
an style=3D"color:black">&gt;<br>
<b>Cc:</b> Quan, Evan &lt;</span><a href=3D"mailto:Evan.Quan-5C7GfCeVMHo@public.gmane.org">Evan.=
Quan-5C7GfCeVMHo@public.gmane.org</a><span style=3D"color:black">&gt;<br>
<b>Subject:</b> [PATCH] drm/amd/powerplay: correct confusing naming for smu=
_feature_set_enabled</span>
<o:p></o:p></p>
<div>
<p class=3D"xxmsonormal">&nbsp;<o:p></o:p></p>
</div>
</div>
<div>
<div>
<p class=3D"xxmsonormal">It does more than updating the bitmask. In fact it=
 enables also the<br>
feature. That's confusing. As for this, a new API is added for the<br>
feature enablement job. And smu_feature_set_enabled is updated to<br>
setting the bitmask only(as smu_feature_set_supported).<br>
<br>
Change-Id: I758e4461be34c0fcbdf19448e34180a5251926c4<br>
Signed-off-by: Evan Quan &lt;<a href=3D"mailto:evan.quan-5C7GfCeVMHo@public.gmane.org">evan.quan=
@amd.com</a>&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/powerplay/amdgpu_smu.c&nbsp;&nbsp;&nbsp; | 29 &#4=
3;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;------<br>
&nbsp;.../gpu/drm/amd/powerplay/inc/amdgpu_smu.h&nbsp;&nbsp;&nbsp; |&nbsp; =
2 &#43;&#43;<br>
&nbsp;drivers/gpu/drm/amd/powerplay/smu_v11_0.c&nbsp;&nbsp;&nbsp;&nbsp; |&n=
bsp; 2 &#43;-<br>
&nbsp;drivers/gpu/drm/amd/powerplay/vega20_ppt.c&nbsp;&nbsp;&nbsp; |&nbsp; =
4 &#43;--<br>
&nbsp;4 files changed, 25 insertions(&#43;), 12 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c b/drivers/gpu/drm/a=
md/powerplay/amdgpu_smu.c<br>
index 4e18f33a1bab..9262883d4031 100644<br>
--- a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c<br>
@@ -511,28 &#43;511,39 @@ int smu_feature_set_enabled(struct smu_context *s=
mu, enum smu_feature_mask mask,<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct smu_feature *featur=
e =3D &amp;smu-&gt;smu_feature;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int feature_id;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ret =3D 0;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; feature_id =3D smu_feature=
_get_index(smu, mask);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (feature_id &lt; 0)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return -EINVAL;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WARN_ON(feature_id &gt; feature-&gt;f=
eature_num);<br>
-<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_lock(&amp;feature-&g=
t;mutex);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D smu_feature_update_enable_sta=
te(smu, feature_id, enable);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; goto failed;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (enable)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; test_and_set_bit(feature_id, feature-&gt;enabled);<br=
>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; else<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; test_and_clear_bit(feature_id, feature-&gt;enabled);<=
br>
&nbsp;<br>
-failed:<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_unlock(&amp;feature-=
&gt;mutex);<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&#43;}<br>
&#43;<br>
&#43;int smu_enable_smc_feature(struct smu_context *smu,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp; enum smu_feature_mask mask,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp; bool enable)<br>
&#43;{<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int feature_id;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ret =3D 0;<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; feature_id =3D smu_feature_get_in=
dex(smu, mask);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (feature_id &lt; 0)<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; return -EINVAL;<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D smu_feature_update_enable=
_state(smu, feature_id, enable);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret)<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; return ret;<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return smu_feature_set_enabled(sm=
u, mask, enable);<br>
&nbsp;}<br>
&nbsp;<br>
&nbsp;int smu_feature_is_supported(struct smu_context *smu, enum smu_featur=
e_mask mask)<br>
@@ -1186,7 &#43;1197,7 @@ static int smu_suspend(void *handle)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return ret;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;in_gpu_reset =
&amp;&amp; baco_feature_is_enabled) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; ret =3D smu_feature_set_enabled(smu, SMU_FEATURE_BACO_BIT, true)=
;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; ret =3D smu_enable_smc_feature(smu, SMU_FEATURE_BACO_BIT, tr=
ue);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; if (ret) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pr_wa=
rn(&quot;set BACO feature enabled failed, return %d\n&quot;, ret);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; retur=
n ret;<br>
diff --git a/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h b/drivers/gpu/d=
rm/amd/powerplay/inc/amdgpu_smu.h<br>
index b702c9ee975f..267b879796f9 100644<br>
--- a/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h<br>
@@ -946,6 &#43;946,8 @@ extern int smu_feature_is_enabled(struct smu_contex=
t *smu,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; enum smu_feature_mas=
k mask);<br>
&nbsp;extern int smu_feature_set_enabled(struct smu_context *smu,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; enum smu_featu=
re_mask mask, bool enable);<br>
&#43;extern int smu_enable_smc_feature(struct smu_context *smu,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; enum smu_feature_mask=
 mask, bool enable);<br>
&nbsp;extern int smu_feature_is_supported(struct smu_context *smu,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; enum smu=
_feature_mask mask);<br>
&nbsp;extern int smu_feature_set_supported(struct smu_context *smu,<br>
diff --git a/drivers/gpu/drm/amd/powerplay/smu_v11_0.c b/drivers/gpu/drm/am=
d/powerplay/smu_v11_0.c<br>
index e3a178403546..0f59d2178d01 100644<br>
--- a/drivers/gpu/drm/amd/powerplay/smu_v11_0.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/powerplay/smu_v11_0.c<br>
@@ -1419,7 &#43;1419,7 @@ smu_v11_0_smc_fan_control(struct smu_context *smu=
, bool start)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (smu_feature_is_support=
ed(smu, SMU_FEATURE_FAN_CONTROL_BIT))<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return 0;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D smu_feature_set_enabled(smu, =
SMU_FEATURE_FAN_CONTROL_BIT, start);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D smu_enable_smc_feature(sm=
u, SMU_FEATURE_FAN_CONTROL_BIT, start);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; pr_err(&quot;[%s]%s smc FAN CONTROL feature failed!&q=
uot;,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; __func__, (=
start ? &quot;Start&quot; : &quot;Stop&quot;));<br>
diff --git a/drivers/gpu/drm/amd/powerplay/vega20_ppt.c b/drivers/gpu/drm/a=
md/powerplay/vega20_ppt.c<br>
index 9ead36192787..536ff884ddca 100644<br>
--- a/drivers/gpu/drm/amd/powerplay/vega20_ppt.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/powerplay/vega20_ppt.c<br>
@@ -2845,7 &#43;2845,7 @@ static int vega20_dpm_set_uvd_enable(struct smu_c=
ontext *smu, bool enable)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (enable =3D=3D smu_feat=
ure_is_enabled(smu, SMU_FEATURE_DPM_UVD_BIT))<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return 0;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return smu_feature_set_enabled(smu, S=
MU_FEATURE_DPM_UVD_BIT, enable);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return smu_enable_smc_feature(smu=
, SMU_FEATURE_DPM_UVD_BIT, enable);<br>
&nbsp;}<br>
&nbsp;<br>
&nbsp;static int vega20_dpm_set_vce_enable(struct smu_context *smu, bool en=
able)<br>
@@ -2856,7 &#43;2856,7 @@ static int vega20_dpm_set_vce_enable(struct smu_c=
ontext *smu, bool enable)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (enable =3D=3D smu_feat=
ure_is_enabled(smu, SMU_FEATURE_DPM_VCE_BIT))<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return 0;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return smu_feature_set_enabled(smu, S=
MU_FEATURE_DPM_VCE_BIT, enable);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return smu_enable_smc_feature(smu=
, SMU_FEATURE_DPM_VCE_BIT, enable);<br>
&nbsp;}<br>
&nbsp;<br>
&nbsp;static int vega20_get_enabled_smc_features(struct smu_context *smu,<b=
r>
-- <br>
2.22.0<br>
<br>
_______________________________________________<br>
amd-gfx mailing list<br>
<a href=3D"mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">amd-gfx-PD4FTy7X32lNgt0PjOBp9/rsn8yoX9R0@public.gmane.org=
org</a><br>
<a href=3D"https://lists.freedesktop.org/mailman/listinfo/amd-gfx">https://=
lists.freedesktop.org/mailman/listinfo/amd-gfx</a><o:p></o:p></p>
</div>
</div>
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

--_000_MN2PR12MB3344EE018407810C0812ABBCE4C70MN2PR12MB3344namp_--

--===============0658438008==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4

--===============0658438008==--
