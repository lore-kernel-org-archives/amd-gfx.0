From: Mike Lothian <mike-4+n8WJKc9ve9FHfhHBbuYA@public.gmane.org>
Subject: Re: [PATCH] drm/amd/display: Fix DCN build breakage
Date: Wed, 14 Mar 2018 01:01:17 +0000
Message-ID: <CAHbf0-Fg+jvDhNZW3biiCsEnsX7hEWDhtmidj0nRBGjYDxHABg@mail.gmail.com>
References: <20180313193140.27687-1-harry.wentland@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2027845240=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20180313193140.27687-1-harry.wentland-5C7GfCeVMHo@public.gmane.org>
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
To: Harry Wentland <harry.wentland-5C7GfCeVMHo@public.gmane.org>
Cc: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org

--===============2027845240==
Content-Type: multipart/alternative; boundary="94eb2c07571239b1f3056754eabc"

--94eb2c07571239b1f3056754eabc
Content-Type: text/plain; charset="UTF-8"

On Tue, 13 Mar 2018 at 19:32 Harry Wentland <harry.wentland-5C7GfCeVMHo@public.gmane.org> wrote:

> Fixes: 680acc64120c (drm/amd/display: Set disp clk in a safe way to avoid
> over high dpp clk.)
>
> Signed-off-by: Harry Wentland <harry.wentland-5C7GfCeVMHo@public.gmane.org>
> ---
>  drivers/gpu/drm/amd/display/dc/dce/dce_clocks.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/dce/dce_clocks.c
> b/drivers/gpu/drm/amd/display/dc/dce/dce_clocks.c
> index 76fc903515ba..78e6beb6cf26 100644
> --- a/drivers/gpu/drm/amd/display/dc/dce/dce_clocks.c
> +++ b/drivers/gpu/drm/amd/display/dc/dce/dce_clocks.c
> @@ -623,6 +623,7 @@ static bool dce_apply_clock_voltage_request(
>                 }
>         }
>         if (send_request) {
> +#if defined(CONFIG_DRM_AMD_DC_DCN1_0)
>                 if (clk->ctx->dce_version >= DCN_VERSION_1_0) {
>                         struct dc *core_dc = clk->ctx->dc;
>                         /*use dcfclk request voltage*/
> @@ -630,6 +631,7 @@ static bool dce_apply_clock_voltage_request(
>                         clock_voltage_req.clocks_in_khz =
>                                 dcn_find_dcfclk_suits_all(core_dc,
> &clk->cur_clocks_value);
>                 }
> +#endif
>                 dm_pp_apply_clock_for_voltage_request(
>                         clk->ctx, &clock_voltage_req);
>         }
> --
> 2.14.1
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx


Tested-by: Mike Lothian <mike-4+n8WJKc9ve9FHfhHBbuYA@public.gmane.org>

--94eb2c07571239b1f3056754eabc
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br><br><div class=3D"gmail_quote"><div dir=3D"ltr">On Tue=
, 13 Mar 2018 at 19:32 Harry Wentland &lt;<a href=3D"mailto:harry.wentland@=
amd.com">harry.wentland-5C7GfCeVMHo@public.gmane.org</a>&gt; wrote:<br></div><blockquote class=
=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padd=
ing-left:1ex">Fixes: 680acc64120c (drm/amd/display: Set disp clk in a safe =
way to avoid<br>
over high dpp clk.)<br>
<br>
Signed-off-by: Harry Wentland &lt;<a href=3D"mailto:harry.wentland-5C7GfCeVMHo@public.gmane.org"=
 target=3D"_blank">harry.wentland-5C7GfCeVMHo@public.gmane.org</a>&gt;<br>
---<br>
=C2=A0drivers/gpu/drm/amd/display/dc/dce/dce_clocks.c | 2 ++<br>
=C2=A01 file changed, 2 insertions(+)<br>
<br>
diff --git a/drivers/gpu/drm/amd/display/dc/dce/dce_clocks.c b/drivers/gpu/=
drm/amd/display/dc/dce/dce_clocks.c<br>
index 76fc903515ba..78e6beb6cf26 100644<br>
--- a/drivers/gpu/drm/amd/display/dc/dce/dce_clocks.c<br>
+++ b/drivers/gpu/drm/amd/display/dc/dce/dce_clocks.c<br>
@@ -623,6 +623,7 @@ static bool dce_apply_clock_voltage_request(<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (send_request) {<br>
+#if defined(CONFIG_DRM_AMD_DC_DCN1_0)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (clk-&gt;ctx-&gt=
;dce_version &gt;=3D DCN_VERSION_1_0) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 struct dc *core_dc =3D clk-&gt;ctx-&gt;dc;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 /*use dcfclk request voltage*/<br>
@@ -630,6 +631,7 @@ static bool dce_apply_clock_voltage_request(<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 clock_voltage_req.clocks_in_khz =3D<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 dcn_find_dcfclk_suits_all(core_dc, &=
amp;clk-&gt;cur_clocks_value);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+#endif<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 dm_pp_apply_clock_f=
or_voltage_request(<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 clk-&gt;ctx, &amp;clock_voltage_req);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
--<br>
2.14.1<br>
<br>
_______________________________________________<br>
amd-gfx mailing list<br>
<a href=3D"mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" target=3D"_blank">amd-gfx@=
lists.freedesktop.org</a><br>
<a href=3D"https://lists.freedesktop.org/mailman/listinfo/amd-gfx" rel=3D"n=
oreferrer" target=3D"_blank">https://lists.freedesktop.org/mailman/listinfo=
/amd-gfx</a></blockquote><div><br></div><div>Tested-by: Mike Lothian &lt;<a=
 href=3D"mailto:mike-4+n8WJKc9ve9FHfhHBbuYA@public.gmane.org">mike-4+n8WJKc9ve9FHfhHBbuYA@public.gmane.org</a>&gt;=C2=A0</div=
></div></div>

--94eb2c07571239b1f3056754eabc--

--===============2027845240==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============2027845240==--
