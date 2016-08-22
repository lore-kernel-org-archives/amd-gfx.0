From: Edward O'Callaghan <funfunctor-dczkZgxz+BNUPWh3PAxdjQ@public.gmane.org>
Subject: Re: [PATCH drm/amdgpu] Fix indentation in
 dce_v8_0_audio_write_sad_regs()
Date: Mon, 22 Aug 2016 10:41:32 +1000
Message-ID: <c67885c8-c2dc-3628-75b2-800384a43a96@folklore1984.net>
References: <20160822003826.16418-1-alexandre.f.demers@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0806881378=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20160822003826.16418-1-alexandre.f.demers-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
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
--===============0806881378==
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="m0gDxGIPrKCDLGHt9jUHQOVqJBXQFtsec"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--m0gDxGIPrKCDLGHt9jUHQOVqJBXQFtsec
Content-Type: multipart/mixed; boundary="WEIlDc5NJKJv1HXfx3NvjT2cNfbOpTmdU"
From: Edward O'Callaghan <funfunctor-dczkZgxz+BNUPWh3PAxdjQ@public.gmane.org>
To: Alexandre Demers <alexandre.f.demers-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
 amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Message-ID: <c67885c8-c2dc-3628-75b2-800384a43a96-dczkZgxz+BNUPWh3PAxdjQ@public.gmane.org>
Subject: Re: [PATCH drm/amdgpu] Fix indentation in
 dce_v8_0_audio_write_sad_regs()
References: <20160822003826.16418-1-alexandre.f.demers-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
In-Reply-To: <20160822003826.16418-1-alexandre.f.demers-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>

--WEIlDc5NJKJv1HXfx3NvjT2cNfbOpTmdU
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable


On 08/22/2016 10:38 AM, Alexandre Demers wrote:
> Fixed indentation for readability.
>=20
> Signed-off-by: Alexandre Demers <alexandre.f.demers-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Reviewed-by: Edward O'Callaghan <funfunctor-dczkZgxz+BNUPWh3PAxdjQ@public.gmane.org>

> ---
>  drivers/gpu/drm/amd/amdgpu/dce_v8_0.c | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/amd/amdgpu/dce_v8_0.c b/drivers/gpu/drm/am=
d/amdgpu/dce_v8_0.c
> index 3ff1258..c7e5d5f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/dce_v8_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/dce_v8_0.c
> @@ -1501,13 +1501,13 @@ static void dce_v8_0_audio_write_sad_regs(struc=
t drm_encoder *encoder)
> =20
>  			if (sad->format =3D=3D eld_reg_to_type[i][1]) {
>  				if (sad->channels > max_channels) {
> -				value =3D (sad->channels <<
> -				 AZALIA_F0_CODEC_PIN_CONTROL_AUDIO_DESCRIPTOR0__MAX_CHANNELS__SHIF=
T) |
> -				(sad->byte2 <<
> -				 AZALIA_F0_CODEC_PIN_CONTROL_AUDIO_DESCRIPTOR0__DESCRIPTOR_BYTE_2_=
_SHIFT) |
> -				(sad->freq <<
> -				 AZALIA_F0_CODEC_PIN_CONTROL_AUDIO_DESCRIPTOR0__SUPPORTED_FREQUENC=
IES__SHIFT);
> -				max_channels =3D sad->channels;
> +					value =3D (sad->channels <<
> +						 AZALIA_F0_CODEC_PIN_CONTROL_AUDIO_DESCRIPTOR0__MAX_CHANNELS__SH=
IFT) |
> +					        (sad->byte2 <<
> +						 AZALIA_F0_CODEC_PIN_CONTROL_AUDIO_DESCRIPTOR0__DESCRIPTOR_BYTE_=
2__SHIFT) |
> +					        (sad->freq <<
> +						 AZALIA_F0_CODEC_PIN_CONTROL_AUDIO_DESCRIPTOR0__SUPPORTED_FREQUE=
NCIES__SHIFT);
> +					max_channels =3D sad->channels;
>  				}
> =20
>  				if (sad->format =3D=3D HDMI_AUDIO_CODING_TYPE_PCM)
>=20


--WEIlDc5NJKJv1HXfx3NvjT2cNfbOpTmdU--

--m0gDxGIPrKCDLGHt9jUHQOVqJBXQFtsec
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJXuko8AAoJEP4bvbfZuWjbeloQALAE7CZ0GobJu/UkOrk/XD+1
XERDeQZI1XrRFIpZYBV1iOjq3jjELrvh1mali18zMD0kw6WWuZHlmRQe1om5wq9y
3nMIBCS3ioYs4e5AXuScKZwtC9gY7RoMeVvtfQiaOJL1zBgWQwa8+jR7W1hDchLV
YBsC2U4qBtghPn3lR1rxIc02VjPqMIdGlklLqaTnTq/uN9eBXuzqBKzkBPmavp7c
hp8e3/R614j1tZRR5Gekq3E/TaH2pcluA5CJFZlN1Tuw0pZvGmX9iyCEX29B95XF
pcTsW/lXslF0668slHD3Yubv+1M2sWj+ks4/pevTDTrIflzxZxDWnuCDxiMBIsKW
ZkiqfDdrlH+mfOpyg30XvAAFYzFF/ZyQxwQwxm19TDdqfpdgmDCNzjG3CAvcHil9
KIp53k1YZm86WW92Y23sekye05Clw5W8XwyCygcJT3sJNh1ksbQREwgAvlA1Yvz+
n/2d09Fotm+U77w5Yd+4uxzJLaor7uHQqVM4Nf7nI4j9zOvcddrbfbjLcWdTMy7M
FOoM7KJpALqamt18WHMoWuximr0+en1nPHNBLHaKLy56k9OBjkX8ugKkq95ZG/Zo
KvufrpMuBHYxz8BCzFPzj/+d8vkRjbknGd7tEpK0F0herqMKew51lTPeHQfIzyuM
GPGYgTrcxYnTZVMLomAQ
=q8hk
-----END PGP SIGNATURE-----

--m0gDxGIPrKCDLGHt9jUHQOVqJBXQFtsec--

--===============0806881378==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============0806881378==--
