From: Stuart Longland <stuartl-3e+Fe6x+DsgJbe36r25VNhCuuivNXqWP@public.gmane.org>
Subject: Re: Fixing Direct firmware load for amdgpu/polaris12_mc.bin failed
 with error -2
Date: Mon, 24 Jul 2017 11:55:38 +1000
Message-ID: <e918c9db-116b-8045-36e4-5d9581575ad2@longlandclan.id.au>
References: <708ff3f0-8bd8-b2f9-b993-5bfdb97fa16d@longlandclan.id.au>
 <BN6PR12MB1652A30FBDA855022E317794F7A40@BN6PR12MB1652.namprd12.prod.outlook.com>
 <2837c5da-a62c-2f3f-5392-8be270adf8cd@longlandclan.id.au>
 <bc8f3c17-6152-4000-801c-9a3fc9e4044e@daenzer.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0720421063=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <bc8f3c17-6152-4000-801c-9a3fc9e4044e-otUistvHUpPR7s880joybQ@public.gmane.org>
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
To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--===============0720421063==
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="0BbGJogLwu1vALRfKkVrHRgot6mngowDC"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--0BbGJogLwu1vALRfKkVrHRgot6mngowDC
Content-Type: multipart/mixed; boundary="pvTBDcuOnkkVLDnHvgvXgijnfWOxaMwHE";
 protected-headers="v1"
From: Stuart Longland <stuartl-3e+Fe6x+DsgJbe36r25VNhCuuivNXqWP@public.gmane.org>
To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Message-ID: <e918c9db-116b-8045-36e4-5d9581575ad2-3e+Fe6x+DsgJbe36r25VNhCuuivNXqWP@public.gmane.org>
Subject: Re: Fixing Direct firmware load for amdgpu/polaris12_mc.bin failed
 with error -2
References: <708ff3f0-8bd8-b2f9-b993-5bfdb97fa16d-3e+Fe6x+DsgJbe36r25VNhCuuivNXqWP@public.gmane.org>
 <BN6PR12MB1652A30FBDA855022E317794F7A40-/b2+HYfkarQqUD6E6FAiowdYzm3356FpvxpqHgZTriW3zl9H0oFU5g@public.gmane.org>
 <2837c5da-a62c-2f3f-5392-8be270adf8cd-3e+Fe6x+DsgJbe36r25VNhCuuivNXqWP@public.gmane.org>
 <bc8f3c17-6152-4000-801c-9a3fc9e4044e-otUistvHUpPR7s880joybQ@public.gmane.org>
In-Reply-To: <bc8f3c17-6152-4000-801c-9a3fc9e4044e-otUistvHUpPR7s880joybQ@public.gmane.org>

--pvTBDcuOnkkVLDnHvgvXgijnfWOxaMwHE
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 24/07/17 11:02, Michel D=C3=A4nzer wrote:
>> Yeah, I don't use an initrd: I find it's too much of a pain to maintai=
n
>> one (had that situation years ago with a machine that needed one for
>> software/BIOS RAID), so I ensure the drivers needed for mounting / are=

>> baked into the kernel.
>>
> If you compile the amdgpu driver into the kernel as well (not
> recommended), you need to make sure all firmware files it needs for you=
r
> GPU(s) are included in the kernel as well.

Ahh okay, so it's a quirk of having it built into the kernel: it races
mounting /.  If I get a moment later today I'll try making `amdgpu` a
module and see how I go.

Many thanks.
Regards,
--=20
Stuart Longland (aka Redhatter, VK4MSL)

I haven't lost my mind...
  ...it's backed up on a tape somewhere.


--pvTBDcuOnkkVLDnHvgvXgijnfWOxaMwHE--

--0BbGJogLwu1vALRfKkVrHRgot6mngowDC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEvKEYefT5O+PbDe5y+VS7u3lI1UYFAll1U50ACgkQ+VS7u3lI
1UbNzBAAiJVDAsvLYxOc60JykYatrayREX/r+C4XSyBziTpdt6JEaU9l8MP3MofR
zwJJeK3rK6KNEBG9HhD2sOTxVfroDtzGLdfarv5sKpkf1KrhBbtlffmRb2qLKP1w
912OIEVVX4YC3uorQ7Tm4V2Tu7qynQCPeaoAj8Z3feTDUKP57auO5AbZOi8jq9nd
GdL7d8ECWN72PV2CdO2d0lpZiUuwjKoJ2N/TPDVcD0eBUSB0qHPGYfycIYyV/R1G
8J2X7TiYiDZH9gQCr2rVIN0gCx4mDS4pwAegDgAO+ikDhOWQLL+s45ixHA0btdau
tHnqCopqTIL6e+Wu0YCZPQNNMr1Wsp3Y560SdCY4ItVqAr9DZSxWUTfhhWbehh8W
H97SBjaCH2l0ThCYGFZJ4HAoKLM/NamPF0FyFZ8GQlNx2UWxt78ERDprPWugWDpx
4QxaZNdJrCVHQp6j6jSsqQ5QMtD8qe4jAXzZY7yT3mYpmUBEP36oGON0Wmwz+dyQ
qpGUmij7kzaBRd/xHrI5ZpvMT2zc7qZ1pjgR4Z8j/hz3wu56JaZ3Jm5+cwLAkmzH
n2kGo5SxGFCZ3xhlktBDsuBi1E4AENzqHOKtOCzM7x6l6JIrTkTsp5bluFcbULQl
IPynW9/5O9BmnJv0A/b9dv7DLhcFW0JUXP5g8PVoh8pWb/PY450=
=B/Tx
-----END PGP SIGNATURE-----

--0BbGJogLwu1vALRfKkVrHRgot6mngowDC--

--===============0720421063==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============0720421063==--
