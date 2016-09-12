From: Edward O'Callaghan <funfunctor-dczkZgxz+BNUPWh3PAxdjQ@public.gmane.org>
Subject: Re: [PATCH 0/3] rename file name.
Date: Mon, 12 Sep 2016 18:36:13 +1000
Message-ID: <72421e99-8be2-9db4-7aa4-b5d3a7639a49@folklore1984.net>
References: <1473668574-20741-1-git-send-email-Rex.Zhu@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2012585538=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1473668574-20741-1-git-send-email-Rex.Zhu-5C7GfCeVMHo@public.gmane.org>
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
To: Rex Zhu <Rex.Zhu-5C7GfCeVMHo@public.gmane.org>, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--===============2012585538==
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="V5asBWeB4ui4UN7JuTQAWr3c235iB0Es4"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--V5asBWeB4ui4UN7JuTQAWr3c235iB0Es4
Content-Type: multipart/mixed; boundary="vO8cB3hFDCgob2JGOg2PSEJgeF85wv0A0";
 protected-headers="v1"
From: Edward O'Callaghan <funfunctor-dczkZgxz+BNUPWh3PAxdjQ@public.gmane.org>
To: Rex Zhu <Rex.Zhu-5C7GfCeVMHo@public.gmane.org>, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Message-ID: <72421e99-8be2-9db4-7aa4-b5d3a7639a49-dczkZgxz+BNUPWh3PAxdjQ@public.gmane.org>
Subject: Re: [PATCH 0/3] rename file name.
References: <1473668574-20741-1-git-send-email-Rex.Zhu-5C7GfCeVMHo@public.gmane.org>
In-Reply-To: <1473668574-20741-1-git-send-email-Rex.Zhu-5C7GfCeVMHo@public.gmane.org>

--vO8cB3hFDCgob2JGOg2PSEJgeF85wv0A0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

This series is,
Reviewed-by: Edward O'Callaghan <funfunctor-dczkZgxz+BNUPWh3PAxdjQ@public.gmane.org>

On 09/12/2016 06:22 PM, Rex Zhu wrote:
> As tonga/fiji/polaris10/11 use ppt table version 1.
> so rename tonga_processtable to process_pptables_v1_0=20
>=20
>=20
> Rex Zhu (3):
>   drm/amd/powerplay: rename tonga_processpptable* to
>     processpptable_v1_0*.
>   drm/amd/powerplay: add pp_table_version in hwmgr.
>   drm/amd/powerplay: add pptable point check before use it
>=20
>  drivers/gpu/drm/amd/powerplay/hwmgr/Makefile       |    2 +-
>  drivers/gpu/drm/amd/powerplay/hwmgr/fiji_hwmgr.c   |   10 +-
>  drivers/gpu/drm/amd/powerplay/hwmgr/hwmgr.c        |    4 +-
>  .../gpu/drm/amd/powerplay/hwmgr/polaris10_hwmgr.c  |   10 +-
>  drivers/gpu/drm/amd/powerplay/hwmgr/pptable_v1_0.h |  436 +++++++
>  .../amd/powerplay/hwmgr/process_pptables_v1_0.c    | 1326 ++++++++++++=
++++++++
>  .../amd/powerplay/hwmgr/process_pptables_v1_0.h    |   35 +
>  drivers/gpu/drm/amd/powerplay/hwmgr/tonga_hwmgr.c  |   10 +-
>  .../gpu/drm/amd/powerplay/hwmgr/tonga_pptable.h    |  436 -------
>  .../amd/powerplay/hwmgr/tonga_processpptables.c    | 1326 ------------=
--------
>  .../amd/powerplay/hwmgr/tonga_processpptables.h    |   35 -
>  drivers/gpu/drm/amd/powerplay/inc/hwmgr.h          |    8 +
>  12 files changed, 1824 insertions(+), 1814 deletions(-)
>  create mode 100644 drivers/gpu/drm/amd/powerplay/hwmgr/pptable_v1_0.h
>  create mode 100644 drivers/gpu/drm/amd/powerplay/hwmgr/process_pptable=
s_v1_0.c
>  create mode 100644 drivers/gpu/drm/amd/powerplay/hwmgr/process_pptable=
s_v1_0.h
>  delete mode 100644 drivers/gpu/drm/amd/powerplay/hwmgr/tonga_pptable.h=

>  delete mode 100644 drivers/gpu/drm/amd/powerplay/hwmgr/tonga_processpp=
tables.c
>  delete mode 100644 drivers/gpu/drm/amd/powerplay/hwmgr/tonga_processpp=
tables.h
>=20


--vO8cB3hFDCgob2JGOg2PSEJgeF85wv0A0--

--V5asBWeB4ui4UN7JuTQAWr3c235iB0Es4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJX1mkBAAoJEP4bvbfZuWjbqHUP/jWPj9emV74yxPYbibAfjQBq
kDPrZljGXhgAj1MRtxMVWVUYZZm4DSghAfTQjJ/hRIY7V2kLwnC/ZfIqZFJEQGNf
BtPJ6BB8gLVZ4Gs78lC+zI2XMCp0hwkHUXb6TWEzu/Bf3cTahyqL8XdZgstNAp2V
K7754dxPJPr++jy4drzr81vnAPLKhrNu6+zn/TaoXmgmIVmcgnHiYWDMXrTOYrKn
GhM4CcpGYiR9Fmn66Dx0vSmIWZtDDsy0dI2U0VzzjPVHL8F3Kjuhi+jDXIMh3QqS
ED9I2+ZVzd4D0DhwbuJkwnxnSxOAIjYTH9SWd1PKwrsuc/KssF7JwCrYlRQ4p375
uqLYpa3nO6gtgLLPdn9Iaaq8W1cG2jQwpVrFR8fuPZzjaph3c/PceQnZQuUDBtpw
1QdoYp/yrscnUOJ7FQOAh5GjU0TX2HM18quDqARqaOWgxwSAbAkJWQApYOXM95fg
gi+wDc528Hd1IV8Kpby4phA3nrlkdxy3AuqrkI0GPDDMCytTp8o7GrCRQlr/m+M3
gDmJvV05ZXswg92LNu56flacymb90kXxssJm71tGE1g7VuBrETLwd+SYwAPftxFN
xiY4xoKZYsJjhPpIndcStoZ/8tnZg0rqHCzelZcQDef9ahG6GUxrZuzBrFb6+CYS
2jktqnx5jR/XQSzeGGyb
=Yr3F
-----END PGP SIGNATURE-----

--V5asBWeB4ui4UN7JuTQAWr3c235iB0Es4--

--===============2012585538==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============2012585538==--
