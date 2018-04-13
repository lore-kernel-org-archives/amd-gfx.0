From: =?UTF-8?Q?Nils_Wallm=C3=A9nius?= <nils.wallmenius-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 10/21] drm/amd/display: Add back code to allow for
 rounding error
Date: Fri, 13 Apr 2018 05:05:17 +0000
Message-ID: <CA+nq7DsztJAA_yB53PmTCz0DNXqUs06n-o6VO0NjaoGsaYeMFg@mail.gmail.com>
References: <20180410211049.7825-1-harry.wentland@amd.com>
 <20180410211049.7825-11-harry.wentland@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0640413999=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20180410211049.7825-11-harry.wentland-5C7GfCeVMHo@public.gmane.org>
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
Cc: Anthony Koo <Anthony.Koo-5C7GfCeVMHo@public.gmane.org>, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org

--===============0640413999==
Content-Type: multipart/alternative; boundary="089e08223b9410e8720569b3d223"

--089e08223b9410e8720569b3d223
Content-Type: text/plain; charset="UTF-8"

Den tis 10 apr. 2018 23:11Harry Wentland <harry.wentland-5C7GfCeVMHo@public.gmane.org> skrev:

> From: Anthony Koo <Anthony.Koo-5C7GfCeVMHo@public.gmane.org>
>
> Signed-off-by: Anthony Koo <Anthony.Koo-5C7GfCeVMHo@public.gmane.org>
> Reviewed-by: Aric Cyr <Aric.Cyr-5C7GfCeVMHo@public.gmane.org>
> Acked-by: Harry Wentland <harry.wentland-5C7GfCeVMHo@public.gmane.org>
> ---
>  drivers/gpu/drm/amd/display/modules/freesync/freesync.c | 13 ++++++++++++-
>  1 file changed, 12 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/display/modules/freesync/freesync.c
> b/drivers/gpu/drm/amd/display/modules/freesync/freesync.c
> index 4887c888bbe7..abd5c9374eb3 100644
> --- a/drivers/gpu/drm/amd/display/modules/freesync/freesync.c
> +++ b/drivers/gpu/drm/amd/display/modules/freesync/freesync.c
> @@ -896,6 +896,17 @@ bool mod_freesync_is_valid_range(struct mod_freesync
> *mod_freesync,
>         unsigned long long nominal_field_rate_in_uhz =
>                         mod_freesync_calc_nominal_field_rate(stream);
>
> +       /* Allow for some rounding error of actual video timing by taking
> ceil.
> +        * For example, 144 Hz mode timing may actually be 143.xxx Hz when
> +        * calculated from pixel rate and vertical/horizontal totals, but
> +        * this should be allowed instead of blocking FreeSync.
> +        */
>

Hi, with this change the var names ending in *_in_uhz are a bit confusing,
also the integer division will not round up (take ceil) as seems to be the
intention from the above comment. Perhaps the comment needs to be improved?

BR
Nils


+       nominal_field_rate_in_uhz = div_u64(nominal_field_rate_in_uhz,
> 1000000);
> +       min_refresh_cap_in_uhz /= 1000000;
> +       max_refresh_cap_in_uhz /= 1000000;
> +       min_refresh_request_in_uhz /= 1000000;
> +       max_refresh_request_in_uhz /= 1000000;
> +
>         // Check nominal is within range
>         if (nominal_field_rate_in_uhz > max_refresh_cap_in_uhz ||
>                 nominal_field_rate_in_uhz < min_refresh_cap_in_uhz)
> @@ -921,7 +932,7 @@ bool mod_freesync_is_valid_range(struct mod_freesync
> *mod_freesync,
>
>         // For variable range, check for at least 10 Hz range
>         if ((max_refresh_request_in_uhz != min_refresh_request_in_uhz) &&
> -               (max_refresh_request_in_uhz - min_refresh_request_in_uhz <
> 10000000))
> +               (max_refresh_request_in_uhz - min_refresh_request_in_uhz <
> 10))
>                 return false;
>
>         return true;
> --
> 2.15.1
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
>

--089e08223b9410e8720569b3d223
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote"><div dir=3D"ltr">=
Den tis 10 apr. 2018 23:11Harry Wentland &lt;<a href=3D"mailto:harry.wentla=
nd-5C7GfCeVMHo@public.gmane.org">harry.wentland-5C7GfCeVMHo@public.gmane.org</a>&gt; skrev:<br></div><blockquote clas=
s=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;pad=
ding-left:1ex">From: Anthony Koo &lt;<a href=3D"mailto:Anthony.Koo-5C7GfCeVMHo@public.gmane.org"=
 target=3D"_blank" rel=3D"noreferrer">Anthony.Koo-5C7GfCeVMHo@public.gmane.org</a>&gt;<br>
<br>
Signed-off-by: Anthony Koo &lt;<a href=3D"mailto:Anthony.Koo-5C7GfCeVMHo@public.gmane.org" targe=
t=3D"_blank" rel=3D"noreferrer">Anthony.Koo-5C7GfCeVMHo@public.gmane.org</a>&gt;<br>
Reviewed-by: Aric Cyr &lt;<a href=3D"mailto:Aric.Cyr-5C7GfCeVMHo@public.gmane.org" target=3D"_bl=
ank" rel=3D"noreferrer">Aric.Cyr-5C7GfCeVMHo@public.gmane.org</a>&gt;<br>
Acked-by: Harry Wentland &lt;<a href=3D"mailto:harry.wentland-5C7GfCeVMHo@public.gmane.org" targ=
et=3D"_blank" rel=3D"noreferrer">harry.wentland-5C7GfCeVMHo@public.gmane.org</a>&gt;<br>
---<br>
=C2=A0drivers/gpu/drm/amd/display/modules/freesync/freesync.c | 13 ++++++++=
++++-<br>
=C2=A01 file changed, 12 insertions(+), 1 deletion(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/display/modules/freesync/freesync.c b/driv=
ers/gpu/drm/amd/display/modules/freesync/freesync.c<br>
index 4887c888bbe7..abd5c9374eb3 100644<br>
--- a/drivers/gpu/drm/amd/display/modules/freesync/freesync.c<br>
+++ b/drivers/gpu/drm/amd/display/modules/freesync/freesync.c<br>
@@ -896,6 +896,17 @@ bool mod_freesync_is_valid_range(struct mod_freesync *=
mod_freesync,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 unsigned long long nominal_field_rate_in_uhz =
=3D<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 mod_freesync_calc_nominal_field_rate(stream);<br>
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0/* Allow for some rounding error of actual vide=
o timing by taking ceil.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 * For example, 144 Hz mode timing may actually=
 be 143.xxx Hz when<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 * calculated from pixel rate and vertical/hori=
zontal totals, but<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 * this should be allowed instead of blocking F=
reeSync.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 */<br></blockquote></div></div><div dir=3D"aut=
o"><br></div><div dir=3D"auto">Hi, with this change the var names ending in=
 *_in_uhz are a bit confusing, also the integer division will not round up =
(take ceil) as seems to be the intention from the above comment. Perhaps th=
e comment needs to be improved?</div><div dir=3D"auto"><br></div><div dir=
=3D"auto">BR</div><div dir=3D"auto">Nils</div><div dir=3D"auto"><br></div><=
div dir=3D"auto"><br></div><div dir=3D"auto"><div class=3D"gmail_quote"><bl=
ockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #=
ccc solid;padding-left:1ex">
+=C2=A0 =C2=A0 =C2=A0 =C2=A0nominal_field_rate_in_uhz =3D div_u64(nominal_f=
ield_rate_in_uhz, 1000000);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0min_refresh_cap_in_uhz /=3D 1000000;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0max_refresh_cap_in_uhz /=3D 1000000;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0min_refresh_request_in_uhz /=3D 1000000;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0max_refresh_request_in_uhz /=3D 1000000;<br>
+<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 // Check nominal is within range<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (nominal_field_rate_in_uhz &gt; max_refresh_=
cap_in_uhz ||<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 nominal_field_rate_=
in_uhz &lt; min_refresh_cap_in_uhz)<br>
@@ -921,7 +932,7 @@ bool mod_freesync_is_valid_range(struct mod_freesync *m=
od_freesync,<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 // For variable range, check for at least 10 Hz=
 range<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 if ((max_refresh_request_in_uhz !=3D min_refres=
h_request_in_uhz) &amp;&amp;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(max_refresh_reques=
t_in_uhz - min_refresh_request_in_uhz &lt; 10000000))<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(max_refresh_reques=
t_in_uhz - min_refresh_request_in_uhz &lt; 10))<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return false;<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 return true;<br>
-- <br>
2.15.1<br>
<br>
_______________________________________________<br>
amd-gfx mailing list<br>
<a href=3D"mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" target=3D"_blank" rel=3D"n=
oreferrer">amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a><br>
<a href=3D"https://lists.freedesktop.org/mailman/listinfo/amd-gfx" rel=3D"n=
oreferrer noreferrer" target=3D"_blank">https://lists.freedesktop.org/mailm=
an/listinfo/amd-gfx</a><br>
</blockquote></div></div></div>

--089e08223b9410e8720569b3d223--

--===============0640413999==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============0640413999==--
