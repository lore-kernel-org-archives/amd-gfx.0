From: "Siqueira, Rodrigo" <Rodrigo.Siqueira-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH] drm/amd/display: Modify display link stream setup
 sequence.
Date: Thu, 17 Oct 2019 14:34:38 +0000
Message-ID: <20191017143435.qncwbu7tawqyezw7@outlook.office365.com>
References: <DM6PR12MB346669D491903EB8D5D671919E6D0@DM6PR12MB3466.namprd12.prod.outlook.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1825230968=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <DM6PR12MB346669D491903EB8D5D671919E6D0-lmeGfMZKVrFD9+oK+SxdZAdYzm3356FpvxpqHgZTriW3zl9H0oFU5g@public.gmane.org>
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
To: "Liu, Zhan" <Zhan.Liu-5C7GfCeVMHo@public.gmane.org>
Cc: "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

--===============1825230968==
Content-Language: en-US
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="evzostl23fxpgfaa"

--evzostl23fxpgfaa
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Zhan,

I tested your patch, and it fixed the issue. I have some notes:

1. Your patch does not apply smoothly, try to rebase your branch (I
manually fix it for testing your patch).
2. In the commit message, I recommend you to describe the "pink" color
issue when using HDMI. It is going to make easy to understand the issue
that your patch is trying to fix.=20

Thanks

On 10/17, Liu, Zhan wrote:
> From: Zhan Liu <zhan.liu-5C7GfCeVMHo@public.gmane.org>
>=20
> [Why]
> When a specific kind of connector is detected,
> DC needs to set the attribute of the stream.
> This step needs to be done before enabling link,
> or some bugs (e.g. display won't light up)
> will be observed.
>=20
> [How]
> Setting the attribute of the stream first, then
> enabling stream.
>=20
> Signed-off-by: Zhan Liu <zhan.liu-5C7GfCeVMHo@public.gmane.org>
> ---
>  drivers/gpu/drm/amd/display/dc/core/dc_link.c | 20 +++++++++----------
>  1 file changed, 10 insertions(+), 10 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link.c b/drivers/gpu/=
drm/amd/display/dc/core/dc_link.c
> index fb18681b502b..713caab82837 100644
> --- a/drivers/gpu/drm/amd/display/dc/core/dc_link.c
> +++ b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
> @@ -2745,16 +2745,6 @@ void core_link_enable_stream(
>                         dc_is_virtual_signal(pipe_ctx->stream->signal))
>                 return;
>=20
> -       if (!dc_is_virtual_signal(pipe_ctx->stream->signal)) {
> -               stream->link->link_enc->funcs->setup(
> -                       stream->link->link_enc,
> -                       pipe_ctx->stream->signal);
> -               pipe_ctx->stream_res.stream_enc->funcs->setup_stereo_sync(
> -                       pipe_ctx->stream_res.stream_enc,
> -                       pipe_ctx->stream_res.tg->inst,
> -                       stream->timing.timing_3d_format !=3D TIMING_3D_FO=
RMAT_NONE);
> -       }
> -
>         if (dc_is_dp_signal(pipe_ctx->stream->signal))
>                 pipe_ctx->stream_res.stream_enc->funcs->dp_set_stream_att=
ribute(
>                         pipe_ctx->stream_res.stream_enc,
> @@ -2841,6 +2831,16 @@ void core_link_enable_stream(
>                                         CONTROLLER_DP_TEST_PATTERN_VIDEOM=
ODE,
>                                         COLOR_DEPTH_UNDEFINED);
>=20
> +               if (!dc_is_virtual_signal(pipe_ctx->stream->signal)) {
> +                       stream->link->link_enc->funcs->setup(
> +                               stream->link->link_enc,
> +                               pipe_ctx->stream->signal);
> +                       pipe_ctx->stream_res.stream_enc->funcs->setup_ste=
reo_sync(
> +                               pipe_ctx->stream_res.stream_enc,
> +                               pipe_ctx->stream_res.tg->inst,
> +                               stream->timing.timing_3d_format !=3D TIMI=
NG_3D_FORMAT_NONE);
> +               }
> +
>  #ifdef CONFIG_DRM_AMD_DC_DSC_SUPPORT
>                 if (pipe_ctx->stream->timing.flags.DSC) {
>                         if (dc_is_dp_signal(pipe_ctx->stream->signal) ||
> --
> 2.17.1
> _______________________________________________
> amd-gfx mailing list
> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--=20
Rodrigo Siqueira
Software Engineer, Advanced Micro Devices (AMD)
https://siqueira.tech

--evzostl23fxpgfaa
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE4tZ+ii1mjMCMQbfkWJzP/comvP8FAl2oe/sACgkQWJzP/com
vP9z2g/7Bewf93NmUOMsV+Msu8XBmkX2LPd2yd307G5+HH3fYy2HmSmjC+R/fVDg
H1Wb9oNymre6Ww83FJrDahGzN9uQEaIDgdNLM51hS2YlwbPZGK2dN9dd4HEjYT9/
9FnhuYKhgJ2yvjGXGmWcnzlVV/thTw65N88a/f585KZiW8TR8AkBymu+DHtZUNmB
xF1DGdZmlxzBOqu2eYKrcRrtO7deYWrCkCHGO/aTzORNtBWBKd+3eUoIPgsspV74
AwshcxesAVOPQETVBNBi9KZ74rQNT8TMX9V+mtuFjMF/ntDKyMpPTfw4yOpvWlID
ul9KlbzHMbryiBabq0uPM7BqXWV0jIzPI+/YaxHdluBc4DA9QCHFQJOxHrfsE6So
W6fEqhikibITN4WKOpjoioZNqzNzseD5CF+K4jFQMjBBpSZT0DpL5n767fonJqF6
YJsm+tSI3RAI/QGsK4A0+Cjrit8q4ltvd8miUGyO9zMfcs8etR6jMfSb8pb930e4
cBNueSuIYMUQfBHRC2wnBaZrRQoos9C/Y2HZtsZfQCP+HXzpRuSftMCkR4M77uw1
T9UuJABajiRVFKQb113Za636amPN1KsOobrY6jDvWJLEPfgrtAvOCFG7sEfsBy/z
IgvaH9/C0sl0uX9BUiJMMRu5U6VWqcY/BkFQrqPenHqrFnUVvqs=
=pQSp
-----END PGP SIGNATURE-----

--evzostl23fxpgfaa--

--===============1825230968==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4

--===============1825230968==--
