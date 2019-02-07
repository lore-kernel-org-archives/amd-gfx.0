From: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel-otUistvHUpPR7s880joybQ@public.gmane.org>
Subject: Re: BUG - unable to handle null pointer, bisected - drm/amd/display:
 add gpio lock/unlock
Date: Thu, 7 Feb 2019 16:32:57 +0100
Message-ID: <7284b267-cbcb-988f-f688-078f75f87a3d@daenzer.net>
References: <10341067.RRd0raRtKH@eclipse>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0512376869=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <10341067.RRd0raRtKH@eclipse>
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
To: soprwa-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, Chiawen Huang <chiawen.huang-5C7GfCeVMHo@public.gmane.org>
Cc: Tony Cheng <Tony.Cheng-5C7GfCeVMHo@public.gmane.org>, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--===============0512376869==
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="tqHsnCduHDxltBim5I3WEF006A6QcvcDm"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--tqHsnCduHDxltBim5I3WEF006A6QcvcDm
Content-Type: multipart/mixed; boundary="9vCQofcQP7xtGMa5KYAINB9gKKYsTW66U";
 protected-headers="v1"
From: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel-otUistvHUpPR7s880joybQ@public.gmane.org>
To: soprwa-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, Chiawen Huang <chiawen.huang-5C7GfCeVMHo@public.gmane.org>
Cc: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, Tony Cheng <Tony.Cheng-5C7GfCeVMHo@public.gmane.org>
Message-ID: <7284b267-cbcb-988f-f688-078f75f87a3d-otUistvHUpPR7s880joybQ@public.gmane.org>
Subject: Re: BUG - unable to handle null pointer, bisected - drm/amd/display:
 add gpio lock/unlock
References: <10341067.RRd0raRtKH@eclipse>
In-Reply-To: <10341067.RRd0raRtKH@eclipse>

--9vCQofcQP7xtGMa5KYAINB9gKKYsTW66U
Content-Type: text/plain; charset=utf-8
Content-Language: en-CA
Content-Transfer-Encoding: quoted-printable

On 2019-02-06 10:48 a.m., Przemek Socha wrote:
> Good morning,
>=20
> on my Lenovo G50-45 a6310 APU with R4 Mullins commit=20
> e261568f94d6c37ebb94d3c4b3f8a3085375dd9d is causing kernel Oops (unable=
 to=20
> handle NULL pointer).
> Cross-checked by reverting troublesome commit and machine without it is=
=20
> working fine.

Same for me with Tonga.


Chiawen / Tony / other DC developers, any ideas? If it cannot be fixed
quickly, let's revert this change for now.


--=20
Earthling Michel D=C3=A4nzer               |               http://www.amd=
=2Ecom
Libre software enthusiast             |             Mesa and X developer


--9vCQofcQP7xtGMa5KYAINB9gKKYsTW66U--

--tqHsnCduHDxltBim5I3WEF006A6QcvcDm
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EARECAB0WIQSwn681vpFFIZgJURRaga+OatuyAAUCXFxPtQAKCRBaga+Oatuy
AAf/AJ4yJJXPJyrAh65bf6gSa9XQJGUIDQCgr/Wih2//6BTs0O9I9N7rXnG9wRI=
=t9Kt
-----END PGP SIGNATURE-----

--tqHsnCduHDxltBim5I3WEF006A6QcvcDm--

--===============0512376869==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============0512376869==--
