From: "Keith Packard" <keithp-aN4HjG94KOLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH xf86-video-amdgpu 1/3] modesetting: Record non-desktop
 kernel property at PreInit time
Date: Mon, 09 Jul 2018 09:14:33 -0700
Message-ID: <87o9fg4c9i.fsf@keithp.com>
References: <20180709072652.9727-1-michel@daenzer.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0423054653=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20180709072652.9727-1-michel-otUistvHUpPR7s880joybQ@public.gmane.org>
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
To: Michel =?utf-8?Q?D=C3=A4nzer?= <michel-otUistvHUpPR7s880joybQ@public.gmane.org>, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org

--===============0423054653==
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha256; protocol="application/pgp-signature"

--=-=-=
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Michel D=C3=A4nzer <michel-otUistvHUpPR7s880joybQ@public.gmane.org> writes:

> From: Keith Packard <keithp-aN4HjG94KOLQT0dZR+AlfA@public.gmane.org>
>
> Save any value of the kernel non-desktop property in the xf86Output
> structure to avoid non-desktop outputs in the default configuration.
>
> [Also bump randrproto requirement to a version that defines
> RR_PROPERTY_NON_DESKTOP - ajax]
>
> Signed-off-by: Keith Packard <keithp-aN4HjG94KOLQT0dZR+AlfA@public.gmane.org>
> (Ported from xserver commit b91c787c4cd2d20685db69426c539938c556128a)
> Signed-off-by: Michel D=C3=A4nzer <michel.daenzer-5C7GfCeVMHo@public.gmane.org>

Thanks for porting this and making it compile on older server versions;
I notice that you switched from xallocarray to calloc -- seems fine to
me as it avoids some extra configure.ac goop.

For the series:
Reviewed-by: Keith Packard <keithp-aN4HjG94KOLQT0dZR+AlfA@public.gmane.org>

=2D-=20
=2Dkeith

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEw4O3eCVWE9/bQJ2R2yIaaQAAABEFAltDiekACgkQ2yIaaQAA
ABEnoA/9HHCf24KtbHkxtpUihNcGExKaImqXW9sN//+PJBzFtHI+ePDU3lCL2kWH
Jgc59zR1Y91SELFMdJRylbdkLxKlvhzTQudtFq8RUMWte8iWIRamyCW9j5hy5vHP
yJ3qDhQZPYGDFkTTVTkcmf6MRb9sw87h2cuzcPK3Tv9UkWVAfHXRxOo1EzWmI1C4
BY155ZXAVNd7GV8sdVDXo5LwKJy2h6nPHgWKbOd2nPBxchty05L7zun3qHUU0LoG
U3RYrkgm+ezwUZ+o9BenZ0oKQLTwHl78pbiJpFL2zUlvWD34BPuFuw64ImbGuDiZ
ClzFNZZzukE7XDAmJdkQEAIBl7S3WQsQRh7L5bRf5/UMHQmgIDrMDk7HxEpuSpWA
mVa20cjFh96iHwLfQV2QqGwX8Xxtvpd3n9QrPFm6vFi5ChRy13ur6/dQXRqPDFp3
q6o012w1DD+S0PmBj5BmrbjulTvVg/+ZoZlBynjjSPNHdtcqFiWY66yMZuU5T9sS
zeTmircFoWMvCZ3pfeEoVF8xyGs/yosaX4oeMGVIBtHZo0n1yWd6Gexnn9m4p70+
OtDyqGtZUUtg9ohP6g3KgFT5Rusq3PTj3vdopG+3xqjGSQK+epDewjPIhlVdOJpI
IqJsurxAuu/Tx91+8LI/fl1/JbIrSn2Pcj6iFdn7rGq108lFyKk=
=Gt/4
-----END PGP SIGNATURE-----
--=-=-=--

--===============0423054653==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============0423054653==--
