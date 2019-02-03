From: =?UTF-8?Q?Nils_Wallm=C3=A9nius?= <nils.wallmenius-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 05/35] drm/amd/display: Initialize stream_update to zero
Date: Sun, 3 Feb 2019 18:45:18 +0100
Message-ID: <CA+nq7DuzzBUUcYCVuwEuDUbyL_7V0khKk9c8ty9vTGXvq3s9Rg@mail.gmail.com>
References: <20190201152847.11151-1-Bhawanpreet.Lakha@amd.com>
 <20190201152847.11151-6-Bhawanpreet.Lakha@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0865560375=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20190201152847.11151-6-Bhawanpreet.Lakha-5C7GfCeVMHo@public.gmane.org>
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
To: Bhawanpreet Lakha <Bhawanpreet.Lakha-5C7GfCeVMHo@public.gmane.org>
Cc: Nicholas Kazlauskas <nicholas.kazlauskas-5C7GfCeVMHo@public.gmane.org>, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org

--===============0865560375==
Content-Type: multipart/alternative; boundary="0000000000002f069c058100f1cf"

--0000000000002f069c058100f1cf
Content-Type: text/plain; charset="UTF-8"

Hi,

Recently several locations initing structs to zero have been changed to use
memset [1]. Might want to do that here as well.

[1] https://lists.freedesktop.org/archives/amd-gfx/2019-February/031116.html

Regards
Nils

Den fre 1 feb. 2019 16:29 skrev Bhawanpreet Lakha <Bhawanpreet.Lakha-5C7GfCeVMHo@public.gmane.org
>:

> From: Nicholas Kazlauskas <nicholas.kazlauskas-5C7GfCeVMHo@public.gmane.org>
>
> [Why]
> The stream_update struct is left unitialized but DC will access
> its fields. This usually results in global state validation occur
> during any atomic commit with state->allow_modeset = true.
>
> [How]
> Initialize the struct to zero for every stream we check.
>
> Change-Id: Ib7f435cc2c045fc43496bea35d08a14ce8193c33
> Signed-off-by: Nicholas Kazlauskas <nicholas.kazlauskas-5C7GfCeVMHo@public.gmane.org>
> Reviewed-by: David Francis <David.Francis-5C7GfCeVMHo@public.gmane.org>
> Acked-by: Bhawanpreet Lakha <Bhawanpreet.Lakha-5C7GfCeVMHo@public.gmane.org>
> ---
>  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index d7e5391eb432..6550d00128dc 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -5868,7 +5868,6 @@ dm_determine_update_type_for_commit(struct dc *dc,
>
>         struct dc_surface_update *updates;
>         struct dc_plane_state *surface;
> -       struct dc_stream_update stream_update;
>         enum surface_update_type update_type = UPDATE_TYPE_FAST;
>
>         updates = kcalloc(MAX_SURFACES, sizeof(*updates), GFP_KERNEL);
> @@ -5882,6 +5881,8 @@ dm_determine_update_type_for_commit(struct dc *dc,
>         }
>
>         for_each_oldnew_crtc_in_state(state, crtc, old_crtc_state,
> new_crtc_state, i) {
> +               struct dc_stream_update stream_update = { 0 };
> +
>                 new_dm_crtc_state = to_dm_crtc_state(new_crtc_state);
>                 old_dm_crtc_state = to_dm_crtc_state(old_crtc_state);
>                 num_plane = 0;
> --
> 2.17.1
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
>

--0000000000002f069c058100f1cf
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto">Hi,<div dir=3D"auto"><br></div><div dir=3D"auto">Recently=
 several locations initing structs to zero have been changed to use memset =
[1]. Might want to do that here as well.</div><div dir=3D"auto"><br></div><=
div dir=3D"auto">[1]=C2=A0<a href=3D"https://lists.freedesktop.org/archives=
/amd-gfx/2019-February/031116.html">https://lists.freedesktop.org/archives/=
amd-gfx/2019-February/031116.html</a></div><div dir=3D"auto"><br></div><div=
 dir=3D"auto">Regards</div><div dir=3D"auto">Nils</div></div><br><div class=
=3D"gmail_quote"><div dir=3D"ltr">Den fre 1 feb. 2019 16:29 skrev Bhawanpre=
et Lakha &lt;<a href=3D"mailto:Bhawanpreet.Lakha-5C7GfCeVMHo@public.gmane.org">Bhawanpreet.Lakha=
@amd.com</a>&gt;:<br></div><blockquote class=3D"gmail_quote" style=3D"margi=
n:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">From: Nicholas Ka=
zlauskas &lt;<a href=3D"mailto:nicholas.kazlauskas-5C7GfCeVMHo@public.gmane.org" target=3D"_blan=
k" rel=3D"noreferrer">nicholas.kazlauskas-5C7GfCeVMHo@public.gmane.org</a>&gt;<br>
<br>
[Why]<br>
The stream_update struct is left unitialized but DC will access<br>
its fields. This usually results in global state validation occur<br>
during any atomic commit with state-&gt;allow_modeset =3D true.<br>
<br>
[How]<br>
Initialize the struct to zero for every stream we check.<br>
<br>
Change-Id: Ib7f435cc2c045fc43496bea35d08a14ce8193c33<br>
Signed-off-by: Nicholas Kazlauskas &lt;<a href=3D"mailto:nicholas.kazlauska=
s@amd.com" target=3D"_blank" rel=3D"noreferrer">nicholas.kazlauskas-5C7GfCeVMHo@public.gmane.org=
</a>&gt;<br>
Reviewed-by: David Francis &lt;<a href=3D"mailto:David.Francis-5C7GfCeVMHo@public.gmane.org" tar=
get=3D"_blank" rel=3D"noreferrer">David.Francis-5C7GfCeVMHo@public.gmane.org</a>&gt;<br>
Acked-by: Bhawanpreet Lakha &lt;<a href=3D"mailto:Bhawanpreet.Lakha-5C7GfCeVMHo@public.gmane.org=
" target=3D"_blank" rel=3D"noreferrer">Bhawanpreet.Lakha-5C7GfCeVMHo@public.gmane.org</a>&gt;<br=
>
---<br>
=C2=A0drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 3 ++-<br>
=C2=A01 file changed, 2 insertions(+), 1 deletion(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gp=
u/drm/amd/display/amdgpu_dm/amdgpu_dm.c<br>
index d7e5391eb432..6550d00128dc 100644<br>
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c<br>
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c<br>
@@ -5868,7 +5868,6 @@ dm_determine_update_type_for_commit(struct dc *dc,<br=
>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 struct dc_surface_update *updates;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 struct dc_plane_state *surface;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0struct dc_stream_update stream_update;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 enum surface_update_type update_type =3D UPDATE=
_TYPE_FAST;<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 updates =3D kcalloc(MAX_SURFACES, sizeof(*updat=
es), GFP_KERNEL);<br>
@@ -5882,6 +5881,8 @@ dm_determine_update_type_for_commit(struct dc *dc,<br=
>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 for_each_oldnew_crtc_in_state(state, crtc, old_=
crtc_state, new_crtc_state, i) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0struct dc_stream_up=
date stream_update =3D { 0 };<br>
+<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 new_dm_crtc_state =
=3D to_dm_crtc_state(new_crtc_state);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 old_dm_crtc_state =
=3D to_dm_crtc_state(old_crtc_state);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 num_plane =3D 0;<br=
>
-- <br>
2.17.1<br>
<br>
_______________________________________________<br>
amd-gfx mailing list<br>
<a href=3D"mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" target=3D"_blank" rel=3D"n=
oreferrer">amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a><br>
<a href=3D"https://lists.freedesktop.org/mailman/listinfo/amd-gfx" rel=3D"n=
oreferrer noreferrer" target=3D"_blank">https://lists.freedesktop.org/mailm=
an/listinfo/amd-gfx</a><br>
</blockquote></div>

--0000000000002f069c058100f1cf--

--===============0865560375==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============0865560375==--
