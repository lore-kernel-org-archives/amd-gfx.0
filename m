From: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel-otUistvHUpPR7s880joybQ@public.gmane.org>
Subject: Re: Debugging modesetting problem
Date: Thu, 15 Mar 2018 10:20:04 +0100
Message-ID: <c10432fb-0110-73d5-0f77-0dc278dabb60@daenzer.net>
References: <3135989.9rTpBQRE1N@jona-m500>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1166693360=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <3135989.9rTpBQRE1N@jona-m500>
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
To: Jona Stubbe <gpg2025-ilhm+zE510QR3TpqV4T2kg@public.gmane.org>
Cc: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--===============1166693360==
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="GEjzQhN1P2iBJGpXLgbkOFDb49KvnzOFr"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--GEjzQhN1P2iBJGpXLgbkOFDb49KvnzOFr
Content-Type: multipart/mixed; boundary="AerSHsU7j1NMy8Lh0d7vYQMtuN0Y4I23j";
 protected-headers="v1"
From: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel-otUistvHUpPR7s880joybQ@public.gmane.org>
To: Jona Stubbe <gpg2025-ilhm+zE510QR3TpqV4T2kg@public.gmane.org>
Cc: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Message-ID: <c10432fb-0110-73d5-0f77-0dc278dabb60-otUistvHUpPR7s880joybQ@public.gmane.org>
Subject: Re: Debugging modesetting problem
References: <3135989.9rTpBQRE1N@jona-m500>
In-Reply-To: <3135989.9rTpBQRE1N@jona-m500>

--AerSHsU7j1NMy8Lh0d7vYQMtuN0Y4I23j
Content-Type: text/plain; charset=utf-8
Content-Language: en-CA
Content-Transfer-Encoding: quoted-printable

On 2018-03-15 12:52 AM, Jona Stubbe wrote:
> Hi AMD graphics developers,
>=20
> I've recently hit a modesetting problem: when I used the DisplayPort KV=
M=20
> switch that I got yesterday to connect my PC (running Arch Linux) to my=
 4K=20
> monitor, it only worked in 3 out of about 60 times of switching/replugg=
ing the=20
> cable (the BIOS always manages to put something onscreen, though).
> I've tried both graphics cards available to me right now: a Polaris (RX=
 480)=20
> and a Cayman (HD 6950/6970) and neither of them modesets properly and=20
> reliably.

With the Polaris card, does enabling DC help? (kernel >=3D 4.15,
CONFIG_DRM_AMD_DC=3Dy, amdgpu.dc=3D1 on the kernel command line)


> PS: if there is a shorter-latency way of asking this kind of question (=
like an=20
> IRC channel), I'd be interested too :)

There is #radeon on FreeNode.


--=20
Earthling Michel D=C3=A4nzer               |               http://www.amd=
=2Ecom
Libre software enthusiast             |             Mesa and X developer


--AerSHsU7j1NMy8Lh0d7vYQMtuN0Y4I23j--

--GEjzQhN1P2iBJGpXLgbkOFDb49KvnzOFr
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHEEARECADEWIQSwn681vpFFIZgJURRaga+OatuyAAUCWqo6xRMcbWljaGVsQGRh
ZW56ZXIubmV0AAoJEFqBr45q27IAYLsAn0Q4YAfFcnEq1zw/uqrnRW9Lav6dAJ0S
rmtS78d//4EiX9a5FmijwCH79A==
=j9W5
-----END PGP SIGNATURE-----

--GEjzQhN1P2iBJGpXLgbkOFDb49KvnzOFr--

--===============1166693360==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============1166693360==--
