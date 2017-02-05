From: Edward O'Callaghan <funfunctor-dczkZgxz+BNUPWh3PAxdjQ@public.gmane.org>
Subject: Re: [RFC]: More robust build sys for UMR
Date: Mon, 6 Feb 2017 00:29:42 +1100
Message-ID: <7cba846c-4b94-3297-dc66-f494aebf0e3f@folklore1984.net>
References: <20170205045909.17616-1-funfunctor@folklore1984.net>
 <CY4PR12MB17682A4C6E095C68F9F29A44F7410@CY4PR12MB1768.namprd12.prod.outlook.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2132936232=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <CY4PR12MB17682A4C6E095C68F9F29A44F7410-rpdhrqHFk06yjjPBNVDk/QdYzm3356FpvxpqHgZTriW3zl9H0oFU5g@public.gmane.org>
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
To: "StDenis, Tom" <Tom.StDenis-5C7GfCeVMHo@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--===============2132936232==
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="KNqrXgusJCQfEuU2uktJUD8qka3Jdk0fL"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--KNqrXgusJCQfEuU2uktJUD8qka3Jdk0fL
Content-Type: multipart/mixed; boundary="aS9ub2ho6QV5god4qgwJxupLIHnsa2Dls";
 protected-headers="v1"
From: Edward O'Callaghan <funfunctor-dczkZgxz+BNUPWh3PAxdjQ@public.gmane.org>
To: "StDenis, Tom" <Tom.StDenis-5C7GfCeVMHo@public.gmane.org>,
 "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
Message-ID: <7cba846c-4b94-3297-dc66-f494aebf0e3f-dczkZgxz+BNUPWh3PAxdjQ@public.gmane.org>
Subject: Re: [RFC]: More robust build sys for UMR
References: <20170205045909.17616-1-funfunctor-dczkZgxz+BNUPWh3PAxdjQ@public.gmane.org>
 <CY4PR12MB17682A4C6E095C68F9F29A44F7410-rpdhrqHFk06yjjPBNVDk/QdYzm3356FpvxpqHgZTriW3zl9H0oFU5g@public.gmane.org>
In-Reply-To: <CY4PR12MB17682A4C6E095C68F9F29A44F7410-rpdhrqHFk06yjjPBNVDk/QdYzm3356FpvxpqHgZTriW3zl9H0oFU5g@public.gmane.org>

--aS9ub2ho6QV5god4qgwJxupLIHnsa2Dls
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable



On 02/05/2017 10:42 PM, StDenis, Tom wrote:
> Hi Edward,

Hey Tom,

>=20
>=20
> Well the patches apply and work but I'm not really sure what problem
> it's meant to solve =F0=9F=98=8A.  Building previously was actually sim=
pler with

So the idea here was to implement something a little more robust and
extensible. For example with a couple of extra lines cmake can produce
rpm's, deb's and tar's too as build by-products. I can add this
functionality if you wish? Additionally another couple of lines a unit
tests could be hooked in if that is useful?

Fundamentally the idea was to have a "proper" build system that can
be extensible enough not to get in the way while the community
elaborates on UMR some more with additional features. I was thinking
about looking at unifying other peoples radeon debug/re tooling together
into UMR to be the one-stop tool as my Sunday afternoon weekend project
you see :) .

> "make" as opposed to "mkdir build && cd build && cmake .. && make".
>

I just added that step because its nice to build out of tree, you don't
have to.

>=20
> On a BSD system (where this wouldn't really work without the
> corresponding debugfs entries) gmake could be used to build it provided=

> ncurses/pciaccess were around.

Well in truth I didn't test on the BSD's yet, however it helps give some
a good foundation so they could port it should they wish. I am assuming
so since they seem to be updating their graphics stack these days.

>=20
>=20
> If this legitimately makes it more stable to build on Linux systems the=
n
> I'm all for it.  Can anyone elaborate on where the simple make system
> would fail?

Well I hope so, that's why I RFC it. I expect this to work out the box
on all distributions right off the bat and I would be interested in
feedback for that.

>=20
> (I'm not saying NAK I'm simply asking for my own edification).

Sure sure, this only took me a hour to put together because of _my_ itch
so don't stress.

>=20
> Thanks,
> Tom

Kind Regards,
Edward.

>=20
> -----------------------------------------------------------------------=
-
> *From:* Edward O'Callaghan <funfunctor-dczkZgxz+BNUPWh3PAxdjQ@public.gmane.org>
> *Sent:* Saturday, February 4, 2017 23:59
> *To:* amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
> *Cc:* StDenis, Tom
> *Subject:* [RFC]: More robust build sys for UMR
> =20
> Keeping with the tradition of changing the build system on initial
> release, here we go again.. This follow series introduces the cmake
> build system that is intended to be a little more robust across
> various distros and presumably the BSD's also. The installation
> prefix is configurable in the usual cmake way:
>  `cmake -DCMAKE_INSTALL_PREFIX:PATH=3D/usr ..`
>=20
> Please kindly review,
>=20
> Edward O'Callaghan (4):
>  [PATCH 1/4] cmake_modules: Add libpciaccess finder
>  [PATCH 2/4] cmake: Initial build system
>  [PATCH 3/4] README: minor update for cmake buildsys
>  [PATCH 4/4] drop orginal Makefile && stub bin/ directory


--aS9ub2ho6QV5god4qgwJxupLIHnsa2Dls--

--KNqrXgusJCQfEuU2uktJUD8qka3Jdk0fL
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJYlyjGAAoJEP4bvbfZuWjbZ3QQAL/KaTX1od6EGO9vPNY+Zapn
V+NBP9lZs0GBCM9JiQUa6r8euWBLuiK0+Ct5szJZsRTG1RkgAzUfasZQStpoEnTA
V7Oyhrh6wkFZ/ELHZ1auiMX8hyMu0I5BF+bEoNRSSlfNDetf2R3iBczu/9P35Ep6
JbwzMOBd30twg5yPEMjasyBm+wB43qQ8QSbhvEg9wvelUBjnWJlikkesf4MrtSO1
7CzT7Ea6acE11hN4VTgx5guWo8+IER7qnI5AWDvyZRZB0ief3z15UkDNe1Uuss+K
G9XLXUA25oOjwadO2WxYiAJQnJttLi5MQeRe4UJw2l/ZC1DIpvEkmg0sIV3GrgPk
QoZYRZgVP/aeNHaqCqcQ5YDWmuJDrVFdkez77znd3YHX9jBDDECeV2Bm+XluJP1E
jEi68lAu6fHYZmDocLKY+0VMovY6e4Qg9eP4GzSx8RvWzHoEx39IHWe0BipGC8c5
3OFtg4urp5E+Hup4ySET1Netts4KRtLJKuMf3AU8vuCveLfG57UGw8sLl6ikjMTR
z9nVrKSUEHAysD6HVEl7VGy4SN4F0f4CQOECadUewsxKFiJtypJ55QeZVcMe8utL
GfXQUjr53W7th0P6yKzx8AQrdM61hvt85ycB0te93lI28K31z4WowvHsgn9p1xpD
L37M3m6b+ENxQixMhJ4e
=EoOH
-----END PGP SIGNATURE-----

--KNqrXgusJCQfEuU2uktJUD8qka3Jdk0fL--

--===============2132936232==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============2132936232==--
