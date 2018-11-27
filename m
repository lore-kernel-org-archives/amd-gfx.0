From: "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH] drm/amd/display: Fix compile error with ACPI disabled
Date: Tue, 27 Nov 2018 19:51:01 +0000
Message-ID: <BN6PR12MB180995C1CFFA868025741EA6F7D00@BN6PR12MB1809.namprd12.prod.outlook.com>
References: <20181127161814.14749-1-David.Francis@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1826665403=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20181127161814.14749-1-David.Francis-5C7GfCeVMHo@public.gmane.org>
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
To: "Francis, David" <David.Francis-5C7GfCeVMHo@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, "dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

--===============1826665403==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_BN6PR12MB180995C1CFFA868025741EA6F7D00BN6PR12MB1809namp_"

--_000_BN6PR12MB180995C1CFFA868025741EA6F7D00BN6PR12MB1809namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Acked-by: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>

________________________________
From: amd-gfx <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org> on behalf of David Fr=
ancis <David.Francis-5C7GfCeVMHo@public.gmane.org>
Sent: Tuesday, November 27, 2018 11:18:14 AM
To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org; dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Cc: Francis, David
Subject: [PATCH] drm/amd/display: Fix compile error with ACPI disabled

The fallback code for getting default backlight caps was using
the wrong variable name.  Fix it.

Fixes: https://lists.freedesktop.org/archives/dri-devel/2018-November/19775=
2.html
Signed-off-by: David Francis <David.Francis-5C7GfCeVMHo@public.gmane.org>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gp=
u/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 27df3ae945be..aa3f8200fa69 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -1615,8 +1615,8 @@ static void amdgpu_dm_update_backlight_caps(struct am=
dgpu_display_manager *dm)
                                 AMDGPU_DM_DEFAULT_MAX_BACKLIGHT;
         }
 #else
-       dm->backlight_min_input_signal =3D AMDGPU_DM_DEFAULT_MIN_BACKLIGHT;
-       dm->backlight_max_input_signal =3D AMDGPU_DM_DEFAULT_MAX_BACKLIGHT;
+       dm->backlight_caps.min_input_signal =3D AMDGPU_DM_DEFAULT_MIN_BACKL=
IGHT;
+       dm->backlight_caps.max_input_signal =3D AMDGPU_DM_DEFAULT_MAX_BACKL=
IGHT;
 #endif
 }

--
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--_000_BN6PR12MB180995C1CFFA868025741EA6F7D00BN6PR12MB1809namp_
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
<p style=3D"margin-top:0;margin-bottom:0">Acked-by: Alex Deucher &lt;alexan=
der.deucher-5C7GfCeVMHo@public.gmane.org&gt;<br>
</p>
</div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> amd-gfx &lt;amd-gfx-b=
ounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org&gt; on behalf of David Francis &lt;David.Franc=
is-5C7GfCeVMHo@public.gmane.org&gt;<br>
<b>Sent:</b> Tuesday, November 27, 2018 11:18:14 AM<br>
<b>To:</b> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org; dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<b=
r>
<b>Cc:</b> Francis, David<br>
<b>Subject:</b> [PATCH] drm/amd/display: Fix compile error with ACPI disabl=
ed</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">The fallback code for getting default backlight ca=
ps was using<br>
the wrong variable name.&nbsp; Fix it.<br>
<br>
Fixes: <a href=3D"https://lists.freedesktop.org/archives/dri-devel/2018-Nov=
ember/197752.html">
https://lists.freedesktop.org/archives/dri-devel/2018-November/197752.html<=
/a><br>
Signed-off-by: David Francis &lt;David.Francis-5C7GfCeVMHo@public.gmane.org&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 4 &#43;&#43;--<br=
>
&nbsp;1 file changed, 2 insertions(&#43;), 2 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gp=
u/drm/amd/display/amdgpu_dm/amdgpu_dm.c<br>
index 27df3ae945be..aa3f8200fa69 100644<br>
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c<br>
@@ -1615,8 &#43;1615,8 @@ static void amdgpu_dm_update_backlight_caps(struc=
t amdgpu_display_manager *dm)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMDGPU_DM_DEFAULT_MAX_BACKLIGHT;=
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;#else<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dm-&gt;backlight_min_input_signal =3D=
 AMDGPU_DM_DEFAULT_MIN_BACKLIGHT;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dm-&gt;backlight_max_input_signal =3D=
 AMDGPU_DM_DEFAULT_MAX_BACKLIGHT;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dm-&gt;backlight_caps.min_input_s=
ignal =3D AMDGPU_DM_DEFAULT_MIN_BACKLIGHT;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dm-&gt;backlight_caps.max_input_s=
ignal =3D AMDGPU_DM_DEFAULT_MAX_BACKLIGHT;<br>
&nbsp;#endif<br>
&nbsp;}<br>
&nbsp;<br>
-- <br>
2.17.1<br>
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

--_000_BN6PR12MB180995C1CFFA868025741EA6F7D00BN6PR12MB1809namp_--

--===============1826665403==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============1826665403==--
