From: "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH v2] drm/amd/display: Fix bug use wrong pp interface
Date: Wed, 22 Aug 2018 13:59:34 +0000
Message-ID: <BN6PR12MB1809F60D652E7736D3B7E0F8F7300@BN6PR12MB1809.namprd12.prod.outlook.com>
References: <1534920079-11040-1-git-send-email-Rex.Zhu@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0549017089=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1534920079-11040-1-git-send-email-Rex.Zhu-5C7GfCeVMHo@public.gmane.org>
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
To: "Zhu, Rex" <Rex.Zhu-5C7GfCeVMHo@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, "Francis, David" <David.Francis-5C7GfCeVMHo@public.gmane.org>, "Wentland, Harry" <Harry.Wentland-5C7GfCeVMHo@public.gmane.org>

--===============0549017089==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_BN6PR12MB1809F60D652E7736D3B7E0F8F7300BN6PR12MB1809namp_"

--_000_BN6PR12MB1809F60D652E7736D3B7E0F8F7300BN6PR12MB1809namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Acked-by: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>

________________________________
From: amd-gfx <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org> on behalf of Rex Zhu =
<Rex.Zhu-5C7GfCeVMHo@public.gmane.org>
Sent: Wednesday, August 22, 2018 2:41:19 AM
To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org; Francis, David; Wentland, Harry
Cc: Zhu, Rex
Subject: [PATCH v2] drm/amd/display: Fix bug use wrong pp interface

Used wrong pp interface, the original interface is
exposed by dpm on SI and paritial CI.

Pointed out by Francis David <david.francis-5C7GfCeVMHo@public.gmane.org>

v2: dal only need to set min_dcefclk and min_fclk to smu.
    so use display_clock_voltage_request interface,
    instand of update all display configuration.

Acked-by: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>
Signed-off-by: Rex Zhu <Rex.Zhu-5C7GfCeVMHo@public.gmane.org>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_pp_smu.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_pp_smu.c b/dri=
vers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_pp_smu.c
index e5c5b0a..7811d60 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_pp_smu.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_pp_smu.c
@@ -480,12 +480,20 @@ void pp_rv_set_display_requirement(struct pp_smu *pp,
 {
         const struct dc_context *ctx =3D pp->dm;
         struct amdgpu_device *adev =3D ctx->driver_context;
+       void *pp_handle =3D adev->powerplay.pp_handle;
         const struct amd_pm_funcs *pp_funcs =3D adev->powerplay.pp_funcs;
+       struct pp_display_clock_request clock =3D {0};

-       if (!pp_funcs || !pp_funcs->display_configuration_changed)
+       if (!req || !pp_funcs || !pp_funcs->display_clock_voltage_request)
                 return;

-       amdgpu_dpm_display_configuration_changed(adev);
+       clock.clock_type =3D amd_pp_dcf_clock;
+       clock.clock_freq_in_khz =3D req->hard_min_dcefclk_khz;
+       pp_funcs->display_clock_voltage_request(pp_handle, &clock);
+
+       clock.clock_type =3D amd_pp_f_clock;
+       clock.clock_freq_in_khz =3D req->hard_min_fclk_khz;
+       pp_funcs->display_clock_voltage_request(pp_handle, &clock);
 }

 void pp_rv_set_wm_ranges(struct pp_smu *pp,
--
1.9.1

_______________________________________________
amd-gfx mailing list
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--_000_BN6PR12MB1809F60D652E7736D3B7E0F8F7300BN6PR12MB1809namp_
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
<p style=3D"margin-top:0;margin-bottom:0"><font size=3D"2"><span style=3D"f=
ont-size:11pt;">Acked-by: Alex Deucher &lt;alexander.deucher-5C7GfCeVMHo@public.gmane.org&gt;</s=
pan></font><br>
</p>
</div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> amd-gfx &lt;amd-gfx-b=
ounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org&gt; on behalf of Rex Zhu &lt;Rex.Zhu-5C7GfCeVMHo@public.gmane.org&g=
t;<br>
<b>Sent:</b> Wednesday, August 22, 2018 2:41:19 AM<br>
<b>To:</b> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org; Francis, David; Wentland, Harry<b=
r>
<b>Cc:</b> Zhu, Rex<br>
<b>Subject:</b> [PATCH v2] drm/amd/display: Fix bug use wrong pp interface<=
/font>
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
v2: dal only need to set min_dcefclk and min_fclk to smu.<br>
&nbsp;&nbsp;&nbsp; so use display_clock_voltage_request interface,<br>
&nbsp;&nbsp;&nbsp; instand of update all display configuration.<br>
<br>
Acked-by: Alex Deucher &lt;alexander.deucher-5C7GfCeVMHo@public.gmane.org&gt;<br>
Signed-off-by: Rex Zhu &lt;Rex.Zhu-5C7GfCeVMHo@public.gmane.org&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_pp_smu.c | 12 &#43;&#=
43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;--<br>
&nbsp;1 file changed, 10 insertions(&#43;), 2 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_pp_smu.c b/dri=
vers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_pp_smu.c<br>
index e5c5b0a..7811d60 100644<br>
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_pp_smu.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_pp_smu.c<=
br>
@@ -480,12 &#43;480,20 @@ void pp_rv_set_display_requirement(struct pp_smu =
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
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct pp_display_clock_request c=
lock =3D {0};<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!pp_funcs || !pp_funcs-&gt;displa=
y_configuration_changed)<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!req || !pp_funcs || !pp_func=
s-&gt;display_clock_voltage_request)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_dpm_display_configuration_chan=
ged(adev);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; clock.clock_type =3D amd_pp_dcf_c=
lock;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; clock.clock_freq_in_khz =3D req-&=
gt;hard_min_dcefclk_khz;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pp_funcs-&gt;display_clock_voltag=
e_request(pp_handle, &amp;clock);<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; clock.clock_type =3D amd_pp_f_clo=
ck;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; clock.clock_freq_in_khz =3D req-&=
gt;hard_min_fclk_khz;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pp_funcs-&gt;display_clock_voltag=
e_request(pp_handle, &amp;clock);<br>
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

--_000_BN6PR12MB1809F60D652E7736D3B7E0F8F7300BN6PR12MB1809namp_--

--===============0549017089==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============0549017089==--
