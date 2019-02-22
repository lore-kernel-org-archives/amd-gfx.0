From: "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH] drm/amd/display: don't call dm_pp_ function from an fpu
 block
Date: Fri, 22 Feb 2019 17:31:34 +0000
Message-ID: <BN6PR12MB1809380DCD0FDADBA9F6D286F77F0@BN6PR12MB1809.namprd12.prod.outlook.com>
References: <20190222153906.661-1-harry.wentland@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1650784972=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20190222153906.661-1-harry.wentland-5C7GfCeVMHo@public.gmane.org>
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
To: "Wentland, Harry" <Harry.Wentland-5C7GfCeVMHo@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
Cc: "robdclark-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" <robdclark-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "stable-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <stable-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

--===============1650784972==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_BN6PR12MB1809380DCD0FDADBA9F6D286F77F0BN6PR12MB1809namp_"

--_000_BN6PR12MB1809380DCD0FDADBA9F6D286F77F0BN6PR12MB1809namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Acked-by: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>
________________________________
From: amd-gfx <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org> on behalf of Harry We=
ntland <harry.wentland-5C7GfCeVMHo@public.gmane.org>
Sent: Friday, February 22, 2019 10:39 AM
To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Cc: robdclark-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org; Wentland, Harry; stable-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Subject: [PATCH] drm/amd/display: don't call dm_pp_ function from an fpu bl=
ock

Powerplay functions called from dm_pp_* functions tend to do a
mutex_lock which isn't safe to do inside a kernel_fpu_begin/end block as
those will disable/enable preemption.

Rearrange the dm_pp_get_clock_levels_by_type_with_voltage calls to make
sure they happen outside of kernel_fpu_begin/end.

Cc: stable-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Signed-off-by: Harry Wentland <harry.wentland-5C7GfCeVMHo@public.gmane.org>
---
 drivers/gpu/drm/amd/display/dc/calcs/dcn_calcs.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/calcs/dcn_calcs.c b/drivers/gpu=
/drm/amd/display/dc/calcs/dcn_calcs.c
index 2a807b9f77f7..5955634f6e27 100644
--- a/drivers/gpu/drm/amd/display/dc/calcs/dcn_calcs.c
+++ b/drivers/gpu/drm/amd/display/dc/calcs/dcn_calcs.c
@@ -1348,12 +1348,12 @@ void dcn_bw_update_from_pplib(struct dc *dc)
         struct dm_pp_clock_levels_with_voltage fclks =3D {0}, dcfclks =3D =
{0};
         bool res;

-       kernel_fpu_begin();
-
         /* TODO: This is not the proper way to obtain fabric_and_dram_band=
width, should be min(fclk, memclk) */
         res =3D dm_pp_get_clock_levels_by_type_with_voltage(
                         ctx, DM_PP_CLOCK_TYPE_FCLK, &fclks);

+       kernel_fpu_begin();
+
         if (res)
                 res =3D verify_clock_values(&fclks);

@@ -1372,9 +1372,13 @@ void dcn_bw_update_from_pplib(struct dc *dc)
         } else
                 BREAK_TO_DEBUGGER();

+       kernel_fpu_end();
+
         res =3D dm_pp_get_clock_levels_by_type_with_voltage(
                         ctx, DM_PP_CLOCK_TYPE_DCFCLK, &dcfclks);

+       kernel_fpu_begin();
+
         if (res)
                 res =3D verify_clock_values(&dcfclks);

--
2.19.1

_______________________________________________
amd-gfx mailing list
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--_000_BN6PR12MB1809380DCD0FDADBA9F6D286F77F0BN6PR12MB1809namp_
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
Acked-by: Alex Deucher &lt;alexander.deucher-5C7GfCeVMHo@public.gmane.org&gt;<br>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> amd-gfx &lt;amd-gfx-b=
ounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org&gt; on behalf of Harry Wentland &lt;harry.went=
land-5C7GfCeVMHo@public.gmane.org&gt;<br>
<b>Sent:</b> Friday, February 22, 2019 10:39 AM<br>
<b>To:</b> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
<b>Cc:</b> robdclark-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org; Wentland, Harry; stable-u79uwXL29TY76Z2rM5mHXA@public.gmane.org<br>
<b>Subject:</b> [PATCH] drm/amd/display: don't call dm_pp_ function from an=
 fpu block</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">Powerplay functions called from dm_pp_* functions =
tend to do a<br>
mutex_lock which isn't safe to do inside a kernel_fpu_begin/end block as<br=
>
those will disable/enable preemption.<br>
<br>
Rearrange the dm_pp_get_clock_levels_by_type_with_voltage calls to make<br>
sure they happen outside of kernel_fpu_begin/end.<br>
<br>
Cc: stable-u79uwXL29TY76Z2rM5mHXA@public.gmane.org<br>
Signed-off-by: Harry Wentland &lt;harry.wentland-5C7GfCeVMHo@public.gmane.org&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/display/dc/calcs/dcn_calcs.c | 8 &#43;&#43;&#43;&=
#43;&#43;&#43;--<br>
&nbsp;1 file changed, 6 insertions(&#43;), 2 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/display/dc/calcs/dcn_calcs.c b/drivers/gpu=
/drm/amd/display/dc/calcs/dcn_calcs.c<br>
index 2a807b9f77f7..5955634f6e27 100644<br>
--- a/drivers/gpu/drm/amd/display/dc/calcs/dcn_calcs.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/display/dc/calcs/dcn_calcs.c<br>
@@ -1348,12 &#43;1348,12 @@ void dcn_bw_update_from_pplib(struct dc *dc)<br=
>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct dm_pp_clock_levels_=
with_voltage fclks =3D {0}, dcfclks =3D {0};<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool res;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kernel_fpu_begin();<br>
-<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* TODO: This is not the p=
roper way to obtain fabric_and_dram_bandwidth, should be min(fclk, memclk) =
*/<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; res =3D dm_pp_get_clock_le=
vels_by_type_with_voltage(<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ctx, =
DM_PP_CLOCK_TYPE_FCLK, &amp;fclks);<br>
&nbsp;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kernel_fpu_begin();<br>
&#43;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (res)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; res =3D verify_clock_values(&amp;fclks);<br>
&nbsp;<br>
@@ -1372,9 &#43;1372,13 @@ void dcn_bw_update_from_pplib(struct dc *dc)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; BREAK_TO_DEBUGGER();<br>
&nbsp;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kernel_fpu_end();<br>
&#43;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; res =3D dm_pp_get_clock_le=
vels_by_type_with_voltage(<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ctx, =
DM_PP_CLOCK_TYPE_DCFCLK, &amp;dcfclks);<br>
&nbsp;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kernel_fpu_begin();<br>
&#43;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (res)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; res =3D verify_clock_values(&amp;dcfclks);<br>
&nbsp;<br>
-- <br>
2.19.1<br>
<br>
_______________________________________________<br>
amd-gfx mailing list<br>
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
<a href=3D"https://lists.freedesktop.org/mailman/listinfo/amd-gfx">https://=
lists.freedesktop.org/mailman/listinfo/amd-gfx</a></div>
</span></font></div>
</body>
</html>

--_000_BN6PR12MB1809380DCD0FDADBA9F6D286F77F0BN6PR12MB1809namp_--

--===============1650784972==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4

--===============1650784972==--
