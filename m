From: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel-otUistvHUpPR7s880joybQ@public.gmane.org>
Subject: Re: [PATCH xf86-video-amdgpu 1/3] modesetting: Record non-desktop
 kernel property at PreInit time
Date: Mon, 9 Jul 2018 18:20:46 +0200
Message-ID: <af4f8c39-0936-dc48-ad67-96b108463619@daenzer.net>
References: <20180709072652.9727-1-michel@daenzer.net>
 <87o9fg4c9i.fsf@keithp.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0043999577=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <87o9fg4c9i.fsf-aN4HjG94KOLQT0dZR+AlfA@public.gmane.org>
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
To: Keith Packard <keithp-aN4HjG94KOLQT0dZR+AlfA@public.gmane.org>
Cc: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--===============0043999577==
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="r54y7CPi6GKmNmM0D1HZsyg8oEIVdZaIe"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--r54y7CPi6GKmNmM0D1HZsyg8oEIVdZaIe
Content-Type: multipart/mixed; boundary="Fphls044lXTm6PmguCWJ9jkidhtq47BKd";
 protected-headers="v1"
From: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel-otUistvHUpPR7s880joybQ@public.gmane.org>
To: Keith Packard <keithp-aN4HjG94KOLQT0dZR+AlfA@public.gmane.org>
Cc: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Message-ID: <af4f8c39-0936-dc48-ad67-96b108463619-otUistvHUpPR7s880joybQ@public.gmane.org>
Subject: Re: [PATCH xf86-video-amdgpu 1/3] modesetting: Record non-desktop
 kernel property at PreInit time
References: <20180709072652.9727-1-michel-otUistvHUpPR7s880joybQ@public.gmane.org>
 <87o9fg4c9i.fsf-aN4HjG94KOLQT0dZR+AlfA@public.gmane.org>
In-Reply-To: <87o9fg4c9i.fsf-aN4HjG94KOLQT0dZR+AlfA@public.gmane.org>

--Fphls044lXTm6PmguCWJ9jkidhtq47BKd
Content-Type: text/plain; charset=utf-8
Content-Language: en-CA
Content-Transfer-Encoding: quoted-printable

On 2018-07-09 06:14 PM, Keith Packard wrote:
> Michel D=C3=A4nzer <michel-otUistvHUpPR7s880joybQ@public.gmane.org> writes:
>=20
>> From: Keith Packard <keithp-aN4HjG94KOLQT0dZR+AlfA@public.gmane.org>
>>
>> Save any value of the kernel non-desktop property in the xf86Output
>> structure to avoid non-desktop outputs in the default configuration.
>>
>> [Also bump randrproto requirement to a version that defines
>> RR_PROPERTY_NON_DESKTOP - ajax]
>>
>> Signed-off-by: Keith Packard <keithp-aN4HjG94KOLQT0dZR+AlfA@public.gmane.org>
>> (Ported from xserver commit b91c787c4cd2d20685db69426c539938c556128a)
>> Signed-off-by: Michel D=C3=A4nzer <michel.daenzer-5C7GfCeVMHo@public.gmane.org>
>=20
> Thanks for porting this and making it compile on older server versions;=

> I notice that you switched from xallocarray to calloc -- seems fine to
> me as it avoids some extra configure.ac goop.

Yep, didn't see the point of that, as ncrtc + noutput needs to be
explicitly checked for overflow anyway.


> For the series:
> Reviewed-by: Keith Packard <keithp-aN4HjG94KOLQT0dZR+AlfA@public.gmane.org>

Thanks!


--=20
Earthling Michel D=C3=A4nzer               |               http://www.amd=
=2Ecom
Libre software enthusiast             |             Mesa and X developer


--Fphls044lXTm6PmguCWJ9jkidhtq47BKd--

--r54y7CPi6GKmNmM0D1HZsyg8oEIVdZaIe
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EARECAB0WIQSwn681vpFFIZgJURRaga+OatuyAAUCW0OLZgAKCRBaga+Oatuy
ADyEAJ4xP5b0dVKvfBoC0rx+uDsc9BnUzQCffu/JYJuVUFoN3IetaYZDfZ3KD4M=
=8+Mq
-----END PGP SIGNATURE-----

--r54y7CPi6GKmNmM0D1HZsyg8oEIVdZaIe--

--===============0043999577==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============0043999577==--
