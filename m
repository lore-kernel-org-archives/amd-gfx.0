From: Edward O'Callaghan <funfunctor-dczkZgxz+BNUPWh3PAxdjQ@public.gmane.org>
Subject: Re: [PATCH drm/amdgpu] Use correct mask in dce_v8_0_afmt_setmode()
 and fix comment typos.
Date: Mon, 22 Aug 2016 10:41:55 +1000
Message-ID: <73e7bbfa-45a7-1f1e-ae19-52a6461f4a9f@folklore1984.net>
References: <20160822003841.16476-1-alexandre.f.demers@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2133766256=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20160822003841.16476-1-alexandre.f.demers-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
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
To: Alexandre Demers <alexandre.f.demers-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--===============2133766256==
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="Po7dCMNJo8LpsNW3pGgSceJnu7HGlC658"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Po7dCMNJo8LpsNW3pGgSceJnu7HGlC658
Content-Type: multipart/mixed; boundary="B3cPM4xmoL4mH9e3Ba3OCS55OUNPDwt9p"
From: Edward O'Callaghan <funfunctor-dczkZgxz+BNUPWh3PAxdjQ@public.gmane.org>
To: Alexandre Demers <alexandre.f.demers-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
 amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Message-ID: <73e7bbfa-45a7-1f1e-ae19-52a6461f4a9f-dczkZgxz+BNUPWh3PAxdjQ@public.gmane.org>
Subject: Re: [PATCH drm/amdgpu] Use correct mask in dce_v8_0_afmt_setmode()
 and fix comment typos.
References: <20160822003841.16476-1-alexandre.f.demers-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
In-Reply-To: <20160822003841.16476-1-alexandre.f.demers-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>

--B3cPM4xmoL4mH9e3Ba3OCS55OUNPDwt9p
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable



On 08/22/2016 10:38 AM, Alexandre Demers wrote:
> We were using the same mask twice. Looking at radeon, it seems
> we should be using HDMI_AVI_INFO_CONT instead as the second mask.
>=20
> Being there, fix typos in comments and improved readability.
>=20
> I haven't looked at other DCEs, the mask may also be wrong for them.
>=20
> Signed-off-by: Alexandre Demers <alexandre.f.demers-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Reviewed-by: Edward O'Callaghan <funfunctor-dczkZgxz+BNUPWh3PAxdjQ@public.gmane.org>

> ---
>  drivers/gpu/drm/amd/amdgpu/dce_v8_0.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/amd/amdgpu/dce_v8_0.c b/drivers/gpu/drm/am=
d/amdgpu/dce_v8_0.c
> index c7e5d5f..e424ecc 100644
> --- a/drivers/gpu/drm/amd/amdgpu/dce_v8_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/dce_v8_0.c
> @@ -1693,6 +1693,7 @@ static void dce_v8_0_afmt_setmode(struct drm_enco=
der *encoder,
>  	/* Silent, r600_hdmi_enable will raise WARN for us */
>  	if (!dig->afmt->enabled)
>  		return;
> +
>  	offset =3D dig->afmt->offset;
> =20
>  	/* hdmi deep color mode general control packets setup, if bpc > 8 */
> @@ -1817,7 +1818,7 @@ static void dce_v8_0_afmt_setmode(struct drm_enco=
der *encoder,
> =20
>  	WREG32_OR(mmHDMI_INFOFRAME_CONTROL0 + offset,
>  		  HDMI_INFOFRAME_CONTROL0__HDMI_AVI_INFO_SEND_MASK | /* enable AVI i=
nfo frames */
> -		  HDMI_INFOFRAME_CONTROL0__HDMI_AVI_INFO_SEND_MASK); /* required for=
 audio info values to be updated */
> +		  HDMI_INFOFRAME_CONTROL0__HDMI_AVI_INFO_CONT_MASK); /* required for=
 audio info values to be updated */
> =20
>  	WREG32_P(mmHDMI_INFOFRAME_CONTROL1 + offset,
>  		 (2 << HDMI_INFOFRAME_CONTROL1__HDMI_AVI_INFO_LINE__SHIFT), /* anyth=
ing other than 0 */
> @@ -1826,13 +1827,13 @@ static void dce_v8_0_afmt_setmode(struct drm_en=
coder *encoder,
>  	WREG32_OR(mmAFMT_AUDIO_PACKET_CONTROL + offset,
>  		  AFMT_AUDIO_PACKET_CONTROL__AFMT_AUDIO_SAMPLE_SEND_MASK); /* send a=
udio packets */
> =20
> -	/* it's unknown what these bits do excatly, but it's indeed quite use=
ful for debugging */
> +	/* it's unknown what these bits do exactly, but it's indeed quite use=
ful for debugging */
>  	WREG32(mmAFMT_RAMP_CONTROL0 + offset, 0x00FFFFFF);
>  	WREG32(mmAFMT_RAMP_CONTROL1 + offset, 0x007FFFFF);
>  	WREG32(mmAFMT_RAMP_CONTROL2 + offset, 0x00000001);
>  	WREG32(mmAFMT_RAMP_CONTROL3 + offset, 0x00000001);
> =20
> -	/* enable audio after to setting up hw */
> +	/* enable audio after setting up hw */
>  	dce_v8_0_audio_enable(adev, dig->afmt->pin, true);
>  }
> =20
>=20


--B3cPM4xmoL4mH9e3Ba3OCS55OUNPDwt9p--

--Po7dCMNJo8LpsNW3pGgSceJnu7HGlC658
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJXukpTAAoJEP4bvbfZuWjbcKQQALsnvUdNf+aPO1W0qJ6QDVdX
uqfcmqmPQKuh+VhkIGXZ4FOymi9FChSPGO65KknhNREn7R9DGqrfaazyPK4gX+HT
aUrL+O4doMJXFLUu1ituOCYDXcDTmef4RJgt79HdDTxmZuidZOgJNKdnydUqUMo5
som41+5TI+q/KKyowI3FYB/XF49cN9PfHwJ9uL22u3qVVZn1/j1OH4YluEutUDo0
CfE81XlsIV3uHE/Q8mp9U4nH8khtbfTtCWefLJwwnFggJLKJhmsxf8u2z3GIcL3G
evDQ7gL0mtR/jw/QE+RR9EQUY4mIDlArUSO/ZZ95Go0tcJF6WnHamyLSuVkAzcW9
Jhi6gEylguJnSzMlAVvfWFicw1VcRU7rck4WDvdpZOrTcwsYznrRzFnVY05+VZDC
SZrRgLSYNZDF/6S1hi3/fjNN2zT4HZD4jFfJINbe7PvZHhs3OMJZ74JFkUzLKrC2
1sSEOprw1QwCbm3Z7IdzD1LZ1quoQTBoAyuyE6i4yOFo9+Jf7jgBc6A7mWcfXIY0
nSw/qLZHOnVDNZ0MfoRYKKL/1FVDA9k+1q8zLfjL67EJb35OG89YLV/0profTI7N
Jgnxgi494k3YnqD3220zbyDgSn5N/X9waH/ygjkj45cMaIHWENk4sf9Udk/Yy7BO
2twB22kVC4bRilUjXMY4
=aVwQ
-----END PGP SIGNATURE-----

--Po7dCMNJo8LpsNW3pGgSceJnu7HGlC658--

--===============2133766256==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============2133766256==--
