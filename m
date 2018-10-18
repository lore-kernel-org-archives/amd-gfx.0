From: "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH v2] drm/amd/pp: enable power limit increase in OD mode
Date: Thu, 18 Oct 2018 19:45:48 +0000
Message-ID: <BN6PR12MB180923088C40BA77658DC6E1F7F80@BN6PR12MB1809.namprd12.prod.outlook.com>
References: <CADnq5_PTpasw+7FdSBc__Oc8MU_n9W-qE0pJuxUGefrFkCw1zw@mail.gmail.com>,
 <1539891802-4011-1-git-send-email-Joseph.Greathouse@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1856947448=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1539891802-4011-1-git-send-email-Joseph.Greathouse-5C7GfCeVMHo@public.gmane.org>
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
To: "Greathouse, Joseph" <Joseph.Greathouse-5C7GfCeVMHo@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

--===============1856947448==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_BN6PR12MB180923088C40BA77658DC6E1F7F80BN6PR12MB1809namp_"

--_000_BN6PR12MB180923088C40BA77658DC6E1F7F80BN6PR12MB1809namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Reviewed-by: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>

________________________________
From: amd-gfx <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org> on behalf of Greathou=
se, Joseph <Joseph.Greathouse-5C7GfCeVMHo@public.gmane.org>
Sent: Thursday, October 18, 2018 3:44:39 PM
To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Cc: Greathouse, Joseph
Subject: [PATCH v2] drm/amd/pp: enable power limit increase in OD mode

OverDrive mode allows users to increase the maximum SCLK and MCLK
frequencies beyond the default on the GPU. However, this may not
results in large performance gains if the GPU then runs into its TDP
power limit. This patch adds the capability to increase the power
limit of a GPU above its default maximum.

This is only allowed when overdrive is enabled in the ppfeaturemask,
since this is an overdrive feature. The TDPODLimit value from the
VBIOS describes how how much higher the TDP should be allowed to go
over its default, in percentage.

v2: Moved dereference of hwmgr to after its validity check

Signed-off-by: Joseph Greathouse <Joseph.Greathouse-5C7GfCeVMHo@public.gmane.org>
---
 drivers/gpu/drm/amd/powerplay/amd_powerplay.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/powerplay/amd_powerplay.c b/drivers/gpu/dr=
m/amd/powerplay/amd_powerplay.c
index e8964ca..586f1ff 100644
--- a/drivers/gpu/drm/amd/powerplay/amd_powerplay.c
+++ b/drivers/gpu/drm/amd/powerplay/amd_powerplay.c
@@ -963,6 +963,7 @@ static int pp_dpm_switch_power_profile(void *handle,
 static int pp_set_power_limit(void *handle, uint32_t limit)
 {
         struct pp_hwmgr *hwmgr =3D handle;
+       uint32_t max_power_limit;

         if (!hwmgr || !hwmgr->pm_en)
                 return -EINVAL;
@@ -975,7 +976,13 @@ static int pp_set_power_limit(void *handle, uint32_t l=
imit)
         if (limit =3D=3D 0)
                 limit =3D hwmgr->default_power_limit;

-       if (limit > hwmgr->default_power_limit)
+       max_power_limit =3D hwmgr->default_power_limit;
+       if (hwmgr->od_enabled) {
+               max_power_limit *=3D (100 + hwmgr->platform_descriptor.TDPO=
DLimit);
+               max_power_limit /=3D 100;
+       }
+
+       if (limit > max_power_limit)
                 return -EINVAL;

         mutex_lock(&hwmgr->smu_lock);
@@ -994,8 +1001,13 @@ static int pp_get_power_limit(void *handle, uint32_t =
*limit, bool default_limit)

         mutex_lock(&hwmgr->smu_lock);

-       if (default_limit)
+       if (default_limit) {
                 *limit =3D hwmgr->default_power_limit;
+               if (hwmgr->od_enabled) {
+                       *limit *=3D (100 + hwmgr->platform_descriptor.TDPOD=
Limit);
+                       *limit /=3D 100;
+               }
+       }
         else
                 *limit =3D hwmgr->power_limit;

--
2.7.4

_______________________________________________
amd-gfx mailing list
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--_000_BN6PR12MB180923088C40BA77658DC6E1F7F80BN6PR12MB1809namp_
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
<p style=3D"margin-top:0;margin-bottom:0">Reviewed-by: Alex Deucher &lt;ale=
xander.deucher-5C7GfCeVMHo@public.gmane.org&gt;<br>
</p>
</div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> amd-gfx &lt;amd-gfx-b=
ounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org&gt; on behalf of Greathouse, Joseph &lt;Joseph=
.Greathouse-5C7GfCeVMHo@public.gmane.org&gt;<br>
<b>Sent:</b> Thursday, October 18, 2018 3:44:39 PM<br>
<b>To:</b> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
<b>Cc:</b> Greathouse, Joseph<br>
<b>Subject:</b> [PATCH v2] drm/amd/pp: enable power limit increase in OD mo=
de</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">OverDrive mode allows users to increase the maximu=
m SCLK and MCLK<br>
frequencies beyond the default on the GPU. However, this may not<br>
results in large performance gains if the GPU then runs into its TDP<br>
power limit. This patch adds the capability to increase the power<br>
limit of a GPU above its default maximum.<br>
<br>
This is only allowed when overdrive is enabled in the ppfeaturemask,<br>
since this is an overdrive feature. The TDPODLimit value from the<br>
VBIOS describes how how much higher the TDP should be allowed to go<br>
over its default, in percentage.<br>
<br>
v2: Moved dereference of hwmgr to after its validity check<br>
<br>
Signed-off-by: Joseph Greathouse &lt;Joseph.Greathouse-5C7GfCeVMHo@public.gmane.org&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/powerplay/amd_powerplay.c | 16 &#43;&#43;&#43;&#4=
3;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;--<br>
&nbsp;1 file changed, 14 insertions(&#43;), 2 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/powerplay/amd_powerplay.c b/drivers/gpu/dr=
m/amd/powerplay/amd_powerplay.c<br>
index e8964ca..586f1ff 100644<br>
--- a/drivers/gpu/drm/amd/powerplay/amd_powerplay.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/powerplay/amd_powerplay.c<br>
@@ -963,6 &#43;963,7 @@ static int pp_dpm_switch_power_profile(void *handle=
,<br>
&nbsp;static int pp_set_power_limit(void *handle, uint32_t limit)<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct pp_hwmgr *hwmgr =3D=
 handle;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t max_power_limit;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!hwmgr || !hwmgr-&gt;p=
m_en)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return -EINVAL;<br>
@@ -975,7 &#43;976,13 @@ static int pp_set_power_limit(void *handle, uint32=
_t limit)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (limit =3D=3D 0)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; limit =3D hwmgr-&gt;default_power_limit;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (limit &gt; hwmgr-&gt;default_powe=
r_limit)<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; max_power_limit =3D hwmgr-&gt;def=
ault_power_limit;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (hwmgr-&gt;od_enabled) {<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; max_power_limit *=3D (100 &#43; hwmgr-&gt;platform_descripto=
r.TDPODLimit);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; max_power_limit /=3D 100;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (limit &gt; max_power_limit)<b=
r>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return -EINVAL;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_lock(&amp;hwmgr-&gt;=
smu_lock);<br>
@@ -994,8 &#43;1001,13 @@ static int pp_get_power_limit(void *handle, uint3=
2_t *limit, bool default_limit)<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_lock(&amp;hwmgr-&gt;=
smu_lock);<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (default_limit)<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (default_limit) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; *limit =3D hwmgr-&gt;default_power_limit;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; if (hwmgr-&gt;od_enabled) {<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *limit *=3D =
(100 &#43; hwmgr-&gt;platform_descriptor.TDPODLimit);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *limit /=3D =
100;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; }<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; else<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; *limit =3D hwmgr-&gt;power_limit;<br>
&nbsp;<br>
-- <br>
2.7.4<br>
<br>
_______________________________________________<br>
amd-gfx mailing list<br>
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
<a href=3D"https://lists.freedesktop.org/mailman/listinfo/amd-gfx">https://=
lists.freedesktop.org/mailman/listinfo/amd-gfx</a><br>
</div>
</span></font></div>
</body>
</html>

--_000_BN6PR12MB180923088C40BA77658DC6E1F7F80BN6PR12MB1809namp_--

--===============1856947448==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============1856947448==--
