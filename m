From: "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH 2/2] drm/amd/powerplay: add sensor lock support for smu
Date: Thu, 26 Sep 2019 15:06:18 +0000
Message-ID: <BN6PR12MB180969DC3D8DCB2FBE655DB8F7860@BN6PR12MB1809.namprd12.prod.outlook.com>
References: <20190926085607.2510-1-kevin1.wang@amd.com>
 <20190926085607.2510-2-kevin1.wang@amd.com>,
 <MN2PR12MB334488D05D2FAEF84C6D550EE4860@MN2PR12MB3344.namprd12.prod.outlook.com>,
 <MN2PR12MB3296504F830A8D72700D11B1A2860@MN2PR12MB3296.namprd12.prod.outlook.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1215599947=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <MN2PR12MB3296504F830A8D72700D11B1A2860-rweVpJHSKTqAm9ToKNQgFgdYzm3356FpvxpqHgZTriW3zl9H0oFU5g@public.gmane.org>
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
To: "Wang, Kevin(Yang)" <Kevin1.Wang-5C7GfCeVMHo@public.gmane.org>, "Quan, Evan" <Evan.Quan-5C7GfCeVMHo@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
Cc: "Huang, Ray" <Ray.Huang-5C7GfCeVMHo@public.gmane.org>, "Feng, Kenneth" <Kenneth.Feng-5C7GfCeVMHo@public.gmane.org>

--===============1215599947==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_BN6PR12MB180969DC3D8DCB2FBE655DB8F7860BN6PR12MB1809namp_"

--_000_BN6PR12MB180969DC3D8DCB2FBE655DB8F7860BN6PR12MB1809namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Does the older powerplay code need a similar fix?

Alex
________________________________
From: amd-gfx <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org> on behalf of Wang, Ke=
vin(Yang) <Kevin1.Wang-5C7GfCeVMHo@public.gmane.org>
Sent: Thursday, September 26, 2019 9:06 AM
To: Quan, Evan <Evan.Quan-5C7GfCeVMHo@public.gmane.org>; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org <amd-gfx@=
lists.freedesktop.org>
Cc: Huang, Ray <Ray.Huang-5C7GfCeVMHo@public.gmane.org>; Feng, Kenneth <Kenneth.Feng-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH 2/2] drm/amd/powerplay: add sensor lock support for smu

sure, you are right, the origin design should be add this lock into these f=
unctions,
but only add these functions can't fix this issue.
eg:
"watch -n 0 /sys/kenel/debug/dri0/amdgpu_pm_info"
16 threads run this command will cause smu error.

so this is workaound fix about sensor interface.
in fact, the smu driver need more lock to protect smu resource.
but too many locks can easily lead to deadlocks in smu driver.
solve the problem temporarily first and optimize this part later

  1.  Message + Param =3D=3D> message param lock
  2.  Message + Message Result =3D=3D> message result lock
  3.  Message1 + Message2 =3D=3D> message pair lock (eg: SetFeatureLow and =
SetFeatureHigh)

Best Regars,
Kevin
________________________________
From: Quan, Evan <Evan.Quan-5C7GfCeVMHo@public.gmane.org>
Sent: Thursday, September 26, 2019 8:22 PM
To: Wang, Kevin(Yang) <Kevin1.Wang-5C7GfCeVMHo@public.gmane.org>; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org =
<amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
Cc: Huang, Ray <Ray.Huang-5C7GfCeVMHo@public.gmane.org>; Feng, Kenneth <Kenneth.Feng-5C7GfCeVMHo@public.gmane.org>; W=
ang, Kevin(Yang) <Kevin1.Wang-5C7GfCeVMHo@public.gmane.org>
Subject: RE: [PATCH 2/2] drm/amd/powerplay: add sensor lock support for smu

How about adding the mutex protection in smu_v11_0_send_msg_with_param and =
smu_v11_0_send_msg?
That seems able to simplify the code.

-----Original Message-----
From: amd-gfx <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org> On Behalf Of Wang, Ke=
vin(Yang)
Sent: Thursday, September 26, 2019 4:56 PM
To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Cc: Huang, Ray <Ray.Huang-5C7GfCeVMHo@public.gmane.org>; Feng, Kenneth <Kenneth.Feng-5C7GfCeVMHo@public.gmane.org>; W=
ang, Kevin(Yang) <Kevin1.Wang-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH 2/2] drm/amd/powerplay: add sensor lock support for smu

when multithreading access sysfs of amdgpu_pm_info at the sametime.
the swsmu driver cause smu firmware hang.

eg:
single thread access:
Message A + Param A =3D=3D> right
Message B + Param B =3D=3D> right
Message C + Param C =3D=3D> right
multithreading access:
Message A + Param B =3D=3D> error
Message B + Param A =3D=3D> error
Message C + Param C =3D=3D> right

the patch will add sensor lock(mutex) to avoid this error.

Signed-off-by: Kevin Wang <kevin1.wang-5C7GfCeVMHo@public.gmane.org>
---
 drivers/gpu/drm/amd/powerplay/amdgpu_smu.c     | 2 ++
 drivers/gpu/drm/amd/powerplay/arcturus_ppt.c   | 2 ++
 drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h | 1 +
 drivers/gpu/drm/amd/powerplay/navi10_ppt.c     | 2 ++
 drivers/gpu/drm/amd/powerplay/vega20_ppt.c     | 2 ++
 5 files changed, 9 insertions(+)

diff --git a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c b/drivers/gpu/drm/a=
md/powerplay/amdgpu_smu.c
index 23293e15636b..df510cb86da5 100644
--- a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
@@ -840,6 +840,8 @@ static int smu_sw_init(void *handle)
         smu->smu_baco.state =3D SMU_BACO_STATE_EXIT;
         smu->smu_baco.platform_support =3D false;

+       mutex_init(&smu->sensor_lock);
+
         smu->watermarks_bitmap =3D 0;
         smu->power_profile_mode =3D PP_SMC_POWER_PROFILE_BOOTUP_DEFAULT;
         smu->default_power_profile_mode =3D PP_SMC_POWER_PROFILE_BOOTUP_DE=
FAULT;
diff --git a/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c b/drivers/gpu/drm=
/amd/powerplay/arcturus_ppt.c
index a047a7ec3698..b9b7b73354a0 100644
--- a/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c
+++ b/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c
@@ -1025,6 +1025,7 @@ static int arcturus_read_sensor(struct smu_context *s=
mu,
         if (!data || !size)
                 return -EINVAL;

+       mutex_lock(&smu->sensor_lock);
         switch (sensor) {
         case AMDGPU_PP_SENSOR_MAX_FAN_RPM:
                 *(uint32_t *)data =3D pptable->FanMaximumRpm; @@ -1051,6 +=
1052,7 @@ static int arcturus_read_sensor(struct smu_context *smu,
         default:
                 ret =3D smu_smc_read_sensor(smu, sensor, data, size);
         }
+       mutex_unlock(&smu->sensor_lock);

         return ret;
 }
diff --git a/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h b/drivers/gpu/d=
rm/amd/powerplay/inc/amdgpu_smu.h
index 5c898444ff97..bc4b73e0718e 100644
--- a/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h
+++ b/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h
@@ -350,6 +350,7 @@ struct smu_context
         const struct smu_funcs          *funcs;
         const struct pptable_funcs      *ppt_funcs;
         struct mutex                    mutex;
+       struct mutex                    sensor_lock;
         uint64_t pool_size;

         struct smu_table_context        smu_table;
diff --git a/drivers/gpu/drm/amd/powerplay/navi10_ppt.c b/drivers/gpu/drm/a=
md/powerplay/navi10_ppt.c
index db2e181ba45a..c0b640d8d9e1 100644
--- a/drivers/gpu/drm/amd/powerplay/navi10_ppt.c
+++ b/drivers/gpu/drm/amd/powerplay/navi10_ppt.c
@@ -1387,6 +1387,7 @@ static int navi10_read_sensor(struct smu_context *smu=
,
         if(!data || !size)
                 return -EINVAL;

+       mutex_lock(&smu->sensor_lock);
         switch (sensor) {
         case AMDGPU_PP_SENSOR_MAX_FAN_RPM:
                 *(uint32_t *)data =3D pptable->FanMaximumRpm; @@ -1410,6 +=
1411,7 @@ static int navi10_read_sensor(struct smu_context *smu,
         default:
                 ret =3D smu_smc_read_sensor(smu, sensor, data, size);
         }
+       mutex_unlock(&smu->sensor_lock);

         return ret;
 }
diff --git a/drivers/gpu/drm/amd/powerplay/vega20_ppt.c b/drivers/gpu/drm/a=
md/powerplay/vega20_ppt.c
index 9082da1578d1..f655ebd9ba22 100644
--- a/drivers/gpu/drm/amd/powerplay/vega20_ppt.c
+++ b/drivers/gpu/drm/amd/powerplay/vega20_ppt.c
@@ -3017,6 +3017,7 @@ static int vega20_read_sensor(struct smu_context *smu=
,
         if(!data || !size)
                 return -EINVAL;

+       mutex_lock(&smu->sensor_lock);
         switch (sensor) {
         case AMDGPU_PP_SENSOR_MAX_FAN_RPM:
                 *(uint32_t *)data =3D pptable->FanMaximumRpm; @@ -3042,6 +=
3043,7 @@ static int vega20_read_sensor(struct smu_context *smu,
         default:
                 ret =3D smu_smc_read_sensor(smu, sensor, data, size);
         }
+       mutex_unlock(&smu->sensor_lock);

         return ret;
 }
--
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--_000_BN6PR12MB180969DC3D8DCB2FBE655DB8F7860BN6PR12MB1809namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Does the older powerplay code need a similar fix?</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Alex<br>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> amd-gfx &lt;amd-gfx-b=
ounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org&gt; on behalf of Wang, Kevin(Yang) &lt;Kevin1.=
Wang-5C7GfCeVMHo@public.gmane.org&gt;<br>
<b>Sent:</b> Thursday, September 26, 2019 9:06 AM<br>
<b>To:</b> Quan, Evan &lt;Evan.Quan-5C7GfCeVMHo@public.gmane.org&gt;; amd-gfx-PD4FTy7X32lNgt0PjOBp9/rsn8yoX9R0@public.gmane.org=
org &lt;amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org&gt;<br>
<b>Cc:</b> Huang, Ray &lt;Ray.Huang-5C7GfCeVMHo@public.gmane.org&gt;; Feng, Kenneth &lt;Kenneth.=
Feng-5C7GfCeVMHo@public.gmane.org&gt;<br>
<b>Subject:</b> Re: [PATCH 2/2] drm/amd/powerplay: add sensor lock support =
for smu</font>
<div>&nbsp;</div>
</div>
<style type=3D"text/css" style=3D"display:none">
<!--
p
	{margin-top:0;
	margin-bottom:0}
-->
</style>
<div dir=3D"ltr">
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif; font-size:12p=
t; color:rgb(0,0,0)">
sure, you are right, the origin design should be add this lock into these f=
unctions,</div>
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif; font-size:12p=
t; color:rgb(0,0,0)">
but only add these functions can't fix this issue.</div>
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif; font-size:12p=
t; color:rgb(0,0,0)">
eg:</div>
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif; font-size:12p=
t; color:rgb(0,0,0)">
<span style=3D"margin:0px; font-size:12pt; font-family:Calibri,Arial,Helvet=
ica,sans-serif; background-color:rgb(255,255,255)"><i>&quot;watch -n 0 /sys=
/kenel/debug/dri0/amdgpu_pm_info&quot;</i></span><br>
</div>
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif; font-size:12p=
t; color:rgb(0,0,0)">
<span style=3D"margin:0px; font-size:12pt; font-family:Calibri,Arial,Helvet=
ica,sans-serif; background-color:rgb(255,255,255)"><i>16 threads run this c=
ommand will cause smu error.</i></span></div>
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif; font-size:12p=
t; color:rgb(0,0,0)">
<br>
</div>
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif; font-size:12p=
t; color:rgb(0,0,0)">
so this is workaound fix about sensor interface.<br>
</div>
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif; font-size:12p=
t; color:rgb(0,0,0)">
<span>in fact, the smu driver need more lock to protect smu resource.</span=
></div>
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif; font-size:12p=
t; color:rgb(0,0,0)">
<span><span>but too many locks can easily lead to deadlocks in smu driver.<=
br>
<span>solve the problem temporarily first and optimize this part later</spa=
n><br>
</span></span></div>
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif; font-size:12p=
t; color:rgb(0,0,0)">
<ol>
<li>Message &#43; Param =3D=3D&gt; message param lock</li><li>Message &#43;=
 Message Result =3D=3D&gt; message result lock</li><li>Message1 &#43; Messa=
ge2 =3D=3D&gt; message pair lock (eg: SetFeatureLow and SetFeatureHigh)</li=
></ol>
<div><br>
</div>
<div>Best Regars,<br>
Kevin</div>
</div>
<div id=3D"x_appendonsend"></div>
<hr tabindex=3D"-1" style=3D"display:inline-block; width:98%">
<div id=3D"x_divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" =
color=3D"#000000" style=3D"font-size:11pt"><b>From:</b> Quan, Evan &lt;Evan=
.Quan-5C7GfCeVMHo@public.gmane.org&gt;<br>
<b>Sent:</b> Thursday, September 26, 2019 8:22 PM<br>
<b>To:</b> Wang, Kevin(Yang) &lt;Kevin1.Wang-5C7GfCeVMHo@public.gmane.org&gt;; amd-gfx-PD4FTy7X32mzQB+pC5nmwQ@public.gmane.org=
edesktop.org &lt;amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org&gt;<br>
<b>Cc:</b> Huang, Ray &lt;Ray.Huang-5C7GfCeVMHo@public.gmane.org&gt;; Feng, Kenneth &lt;Kenneth.=
Feng-5C7GfCeVMHo@public.gmane.org&gt;; Wang, Kevin(Yang) &lt;Kevin1.Wang-5C7GfCeVMHo@public.gmane.org&gt;<br>
<b>Subject:</b> RE: [PATCH 2/2] drm/amd/powerplay: add sensor lock support =
for smu</font>
<div>&nbsp;</div>
</div>
<div class=3D"x_BodyFragment"><font size=3D"2"><span style=3D"font-size:11p=
t">
<div class=3D"x_PlainText">How about adding the mutex protection in smu_v11=
_0_send_msg_with_param and smu_v11_0_send_msg?<br>
That seems able to simplify the code.<br>
<br>
-----Original Message-----<br>
From: amd-gfx &lt;amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org&gt; On Behalf Of Wa=
ng, Kevin(Yang)<br>
Sent: Thursday, September 26, 2019 4:56 PM<br>
To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
Cc: Huang, Ray &lt;Ray.Huang-5C7GfCeVMHo@public.gmane.org&gt;; Feng, Kenneth &lt;Kenneth.Feng@am=
d.com&gt;; Wang, Kevin(Yang) &lt;Kevin1.Wang-5C7GfCeVMHo@public.gmane.org&gt;<br>
Subject: [PATCH 2/2] drm/amd/powerplay: add sensor lock support for smu<br>
<br>
when multithreading access sysfs of amdgpu_pm_info at the sametime.<br>
the swsmu driver cause smu firmware hang.<br>
<br>
eg:<br>
single thread access:<br>
Message A &#43; Param A =3D=3D&gt; right<br>
Message B &#43; Param B =3D=3D&gt; right<br>
Message C &#43; Param C =3D=3D&gt; right<br>
multithreading access:<br>
Message A &#43; Param B =3D=3D&gt; error<br>
Message B &#43; Param A =3D=3D&gt; error<br>
Message C &#43; Param C =3D=3D&gt; right<br>
<br>
the patch will add sensor lock(mutex) to avoid this error.<br>
<br>
Signed-off-by: Kevin Wang &lt;kevin1.wang-5C7GfCeVMHo@public.gmane.org&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/powerplay/amdgpu_smu.c&nbsp;&nbsp;&nbsp;&nbsp; | =
2 &#43;&#43;<br>
&nbsp;drivers/gpu/drm/amd/powerplay/arcturus_ppt.c&nbsp;&nbsp; | 2 &#43;&#4=
3;<br>
&nbsp;drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h | 1 &#43;<br>
&nbsp;drivers/gpu/drm/amd/powerplay/navi10_ppt.c&nbsp;&nbsp;&nbsp;&nbsp; | =
2 &#43;&#43;<br>
&nbsp;drivers/gpu/drm/amd/powerplay/vega20_ppt.c&nbsp;&nbsp;&nbsp;&nbsp; | =
2 &#43;&#43;<br>
&nbsp;5 files changed, 9 insertions(&#43;)<br>
<br>
diff --git a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c b/drivers/gpu/drm/a=
md/powerplay/amdgpu_smu.c<br>
index 23293e15636b..df510cb86da5 100644<br>
--- a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c<br>
@@ -840,6 &#43;840,8 @@ static int smu_sw_init(void *handle)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smu-&gt;smu_baco.state =3D=
 SMU_BACO_STATE_EXIT;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smu-&gt;smu_baco.platform_=
support =3D false;<br>
&nbsp;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_init(&amp;smu-&gt;sensor_lo=
ck);<br>
&#43;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smu-&gt;watermarks_bitmap =
=3D 0;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smu-&gt;power_profile_mode=
 =3D PP_SMC_POWER_PROFILE_BOOTUP_DEFAULT;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smu-&gt;default_power_prof=
ile_mode =3D PP_SMC_POWER_PROFILE_BOOTUP_DEFAULT;<br>
diff --git a/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c b/drivers/gpu/drm=
/amd/powerplay/arcturus_ppt.c<br>
index a047a7ec3698..b9b7b73354a0 100644<br>
--- a/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c<br>
@@ -1025,6 &#43;1025,7 @@ static int arcturus_read_sensor(struct smu_contex=
t *smu,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!data || !size)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return -EINVAL;<br>
&nbsp;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_lock(&amp;smu-&gt;sensor_lo=
ck);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (sensor) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case AMDGPU_PP_SENSOR_MAX_=
FAN_RPM:<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; *(uint32_t *)data =3D pptable-&gt;FanMaximumRpm; @@ -=
1051,6 &#43;1052,7 @@ static int arcturus_read_sensor(struct smu_context *s=
mu,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; default:<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; ret =3D smu_smc_read_sensor(smu, sensor, data, size);=
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_unlock(&amp;smu-&gt;sensor_=
lock);<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret;<br>
&nbsp;}<br>
diff --git a/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h b/drivers/gpu/d=
rm/amd/powerplay/inc/amdgpu_smu.h<br>
index 5c898444ff97..bc4b73e0718e 100644<br>
--- a/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h<br>
@@ -350,6 &#43;350,7 @@ struct smu_context<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; const struct smu_funcs&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *funcs;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; const struct pptable_funcs=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *ppt_funcs;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct mutex&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; mutex;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct mutex&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp; sensor_lock;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint64_t pool_size;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct smu_table_context&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smu_table;<br>
diff --git a/drivers/gpu/drm/amd/powerplay/navi10_ppt.c b/drivers/gpu/drm/a=
md/powerplay/navi10_ppt.c<br>
index db2e181ba45a..c0b640d8d9e1 100644<br>
--- a/drivers/gpu/drm/amd/powerplay/navi10_ppt.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/powerplay/navi10_ppt.c<br>
@@ -1387,6 &#43;1387,7 @@ static int navi10_read_sensor(struct smu_context =
*smu,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if(!data || !size)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return -EINVAL;<br>
&nbsp;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_lock(&amp;smu-&gt;sensor_lo=
ck);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (sensor) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case AMDGPU_PP_SENSOR_MAX_=
FAN_RPM:<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; *(uint32_t *)data =3D pptable-&gt;FanMaximumRpm; @@ -=
1410,6 &#43;1411,7 @@ static int navi10_read_sensor(struct smu_context *smu=
,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; default:<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; ret =3D smu_smc_read_sensor(smu, sensor, data, size);=
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_unlock(&amp;smu-&gt;sensor_=
lock);<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret;<br>
&nbsp;}<br>
diff --git a/drivers/gpu/drm/amd/powerplay/vega20_ppt.c b/drivers/gpu/drm/a=
md/powerplay/vega20_ppt.c<br>
index 9082da1578d1..f655ebd9ba22 100644<br>
--- a/drivers/gpu/drm/amd/powerplay/vega20_ppt.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/powerplay/vega20_ppt.c<br>
@@ -3017,6 &#43;3017,7 @@ static int vega20_read_sensor(struct smu_context =
*smu,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if(!data || !size)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return -EINVAL;<br>
&nbsp;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_lock(&amp;smu-&gt;sensor_lo=
ck);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (sensor) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case AMDGPU_PP_SENSOR_MAX_=
FAN_RPM:<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; *(uint32_t *)data =3D pptable-&gt;FanMaximumRpm; @@ -=
3042,6 &#43;3043,7 @@ static int vega20_read_sensor(struct smu_context *smu=
,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; default:<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; ret =3D smu_smc_read_sensor(smu, sensor, data, size);=
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_unlock(&amp;smu-&gt;sensor_=
lock);<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret;<br>
&nbsp;}<br>
--<br>
2.17.1<br>
<br>
_______________________________________________<br>
amd-gfx mailing list<br>
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
<a href=3D"https://lists.freedesktop.org/mailman/listinfo/amd-gfx">https://=
lists.freedesktop.org/mailman/listinfo/amd-gfx</a><br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_BN6PR12MB180969DC3D8DCB2FBE655DB8F7860BN6PR12MB1809namp_--

--===============1215599947==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4

--===============1215599947==--
