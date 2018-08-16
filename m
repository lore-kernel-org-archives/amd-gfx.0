From: "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH] drm/amd/display: Fix bug use wrong pp interface
Date: Thu, 16 Aug 2018 03:54:19 +0000
Message-ID: <BN6PR12MB1809A7A1C222494983990651F73E0@BN6PR12MB1809.namprd12.prod.outlook.com>
References: <1534390959-11954-1-git-send-email-Rex.Zhu@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2037665938=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1534390959-11954-1-git-send-email-Rex.Zhu-5C7GfCeVMHo@public.gmane.org>
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
To: "Zhu, Rex" <Rex.Zhu-5C7GfCeVMHo@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, "Francis, David" <David.Francis-5C7GfCeVMHo@public.gmane.org>

--===============2037665938==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_BN6PR12MB1809A7A1C222494983990651F73E0BN6PR12MB1809namp_"

--_000_BN6PR12MB1809A7A1C222494983990651F73E0BN6PR12MB1809namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Acked-by: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>

________________________________
From: amd-gfx <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org> on behalf of Rex Zhu =
<Rex.Zhu-5C7GfCeVMHo@public.gmane.org>
Sent: Wednesday, August 15, 2018 11:42:39 PM
To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org; Francis, David
Cc: Zhu, Rex
Subject: [PATCH] drm/amd/display: Fix bug use wrong pp interface

Used wrong pp interface, the original interface is
exposed by dpm on SI and paritial CI.

Pointed out by Francis David <david.francis-5C7GfCeVMHo@public.gmane.org>

Signed-off-by: Rex Zhu <Rex.Zhu-5C7GfCeVMHo@public.gmane.org>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_pp_smu.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_pp_smu.c b/dri=
vers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_pp_smu.c
index e5c5b0a..85b72d459 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_pp_smu.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_pp_smu.c
@@ -480,12 +480,17 @@ void pp_rv_set_display_requirement(struct pp_smu *pp,
 {
         const struct dc_context *ctx =3D pp->dm;
         struct amdgpu_device *adev =3D ctx->driver_context;
+       void *pp_handle =3D adev->powerplay.pp_handle;
         const struct amd_pm_funcs *pp_funcs =3D adev->powerplay.pp_funcs;

-       if (!pp_funcs || !pp_funcs->display_configuration_changed)
+       if (!req || !pp_funcs || !pp_funcs->display_configuration_changed)
                 return;

-       amdgpu_dpm_display_configuration_changed(adev);
+       adev->pm.pm_display_cfg.min_dcef_deep_sleep_set_clk =3D req->min_de=
ep_sleep_dcefclk_mhz/10;
+       adev->pm.pm_display_cfg.min_dcef_set_clk =3D req->hard_min_dcefclk_=
khz/10;
+       adev->pm.pm_display_cfg.num_display =3D req->display_count;
+       adev->pm.pm_display_cfg.min_core_set_clock =3D req->hard_min_fclk_k=
hz/10;
+       pp_funcs->display_configuration_change(pp_handle, &adev->pm.pm_disp=
lay_cfg);
 }

 void pp_rv_set_wm_ranges(struct pp_smu *pp,
--
1.9.1

_______________________________________________
amd-gfx mailing list
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--_000_BN6PR12MB1809A7A1C222494983990651F73E0BN6PR12MB1809namp_
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
ounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org&gt; on behalf of Rex Zhu &lt;Rex.Zhu-5C7GfCeVMHo@public.gmane.org&g=
t;<br>
<b>Sent:</b> Wednesday, August 15, 2018 11:42:39 PM<br>
<b>To:</b> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org; Francis, David<br>
<b>Cc:</b> Zhu, Rex<br>
<b>Subject:</b> [PATCH] drm/amd/display: Fix bug use wrong pp interface</fo=
nt>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">Used wrong pp interface, the original interface is=
<br>
exposed by dpm on SI and paritial CI.<br>
<br>
Pointed out by Francis David &lt;david.francis-5C7GfCeVMHo@public.gmane.org&gt;<br>
<br>
Signed-off-by: Rex Zhu &lt;Rex.Zhu-5C7GfCeVMHo@public.gmane.org&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_pp_smu.c | 9 &#43;&#4=
3;&#43;&#43;&#43;&#43;&#43;--<br>
&nbsp;1 file changed, 7 insertions(&#43;), 2 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_pp_smu.c b/dri=
vers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_pp_smu.c<br>
index e5c5b0a..85b72d459 100644<br>
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_pp_smu.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_pp_smu.c<=
br>
@@ -480,12 &#43;480,17 @@ void pp_rv_set_display_requirement(struct pp_smu =
*pp,<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; const struct dc_context *c=
tx =3D pp-&gt;dm;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev=
 =3D ctx-&gt;driver_context;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; void *pp_handle =3D adev-&gt;powe=
rplay.pp_handle;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; const struct amd_pm_funcs =
*pp_funcs =3D adev-&gt;powerplay.pp_funcs;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!pp_funcs || !pp_funcs-&gt;displa=
y_configuration_changed)<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!req || !pp_funcs || !pp_func=
s-&gt;display_configuration_changed)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_dpm_display_configuration_chan=
ged(adev);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;pm.pm_display_cfg.min_dc=
ef_deep_sleep_set_clk =3D req-&gt;min_deep_sleep_dcefclk_mhz/10;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;pm.pm_display_cfg.min_dc=
ef_set_clk =3D req-&gt;hard_min_dcefclk_khz/10;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;pm.pm_display_cfg.num_di=
splay =3D req-&gt;display_count;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;pm.pm_display_cfg.min_co=
re_set_clock =3D req-&gt;hard_min_fclk_khz/10;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pp_funcs-&gt;display_configuratio=
n_change(pp_handle, &amp;adev-&gt;pm.pm_display_cfg);<br>
&nbsp;}<br>
&nbsp;<br>
&nbsp;void pp_rv_set_wm_ranges(struct pp_smu *pp,<br>
-- <br>
1.9.1<br>
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

--_000_BN6PR12MB1809A7A1C222494983990651F73E0BN6PR12MB1809namp_--

--===============2037665938==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============2037665938==--
