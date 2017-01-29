From: Edward O'Callaghan <funfunctor-dczkZgxz+BNUPWh3PAxdjQ@public.gmane.org>
Subject: Re: [PATCH libdrm 0/3] some -pro patches for integration
Date: Mon, 30 Jan 2017 09:51:29 +1100
Message-ID: <d25c24a2-e1d1-f8a8-f4e7-e91948f81e01@folklore1984.net>
References: <1485632972-4790-1-git-send-email-notasas@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0035203697=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1485632972-4790-1-git-send-email-notasas-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
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
To: Grazvydas Ignotas <notasas-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Cc: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, Alex Xie <AlexBin.Xie-5C7GfCeVMHo@public.gmane.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--===============0035203697==
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="iHnerqvU48eafvakIpdUHGd6rTJUXdhlS"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--iHnerqvU48eafvakIpdUHGd6rTJUXdhlS
Content-Type: multipart/mixed; boundary="Dx9aga9OiqNRO3Ho0THnahV4qRJJCXARs";
 protected-headers="v1"
From: Edward O'Callaghan <funfunctor-dczkZgxz+BNUPWh3PAxdjQ@public.gmane.org>
To: Grazvydas Ignotas <notasas-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Cc: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, Alex Xie <AlexBin.Xie-5C7GfCeVMHo@public.gmane.org>
Message-ID: <d25c24a2-e1d1-f8a8-f4e7-e91948f81e01-dczkZgxz+BNUPWh3PAxdjQ@public.gmane.org>
Subject: Re: [PATCH libdrm 0/3] some -pro patches for integration
References: <1485632972-4790-1-git-send-email-notasas-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
In-Reply-To: <1485632972-4790-1-git-send-email-notasas-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>

--Dx9aga9OiqNRO3Ho0THnahV4qRJJCXARs
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

This series is,
Reviewed-by: Edward O'Callaghan <funfunctor-dczkZgxz+BNUPWh3PAxdjQ@public.gmane.org>

On 01/29/2017 06:49 AM, Grazvydas Ignotas wrote:
> I've taken several patches from amdgpu-pro libdrm that look useful
> to me and I think can be applied already. The only things I did was
> rebasing, fixing some typos and dropping Change-Id.
>=20
> Alex Xie (3):
>   amdgpu: Free/uninit vamgr_32 in theoretically correct order
>   amdgpu: vamgr can be a struct instead of a pointer
>   amdgpu: vamgr_32 can be a struct instead of a pointer
>=20
>  amdgpu/amdgpu_device.c   | 24 +++++++-----------------
>  amdgpu/amdgpu_internal.h |  4 ++--
>  amdgpu/amdgpu_vamgr.c    |  6 +++---
>  3 files changed, 12 insertions(+), 22 deletions(-)
>=20


--Dx9aga9OiqNRO3Ho0THnahV4qRJJCXARs--

--iHnerqvU48eafvakIpdUHGd6rTJUXdhlS
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJYjnH4AAoJEP4bvbfZuWjbVzUQAJHZ/WjwuWpbQBL5tJ5YqHKl
zVJD6FnkDFpWYKNSpt2kfBzXUyeMzR0g6sKTiYA0MLdB8zQqed6R9XojjzB5vxFd
HAlxQ0GL8aiu7j3lzCtnuCimBYwcGwmQLR0UX8DNAXjToHF1aFPxvR+HpvJALeXQ
MoVYXh6WnASU3hO/HWUEgu5hlz23RBZHRNeKQrcsu7t5DUT6eA5dEQTE8lOz1CsJ
zmoPpW9NruLYbdZ/B8l6iVdoKEMHa14iNYSq4xXuw8xSBoC05hO9my2sp973lkK2
H1MZ73i9wh5ZFc7eZQTZrQvVzN54r013iqP5gE799vzHlBnHb8lCEKKKQsThNtEt
y6lIwd5MUjiohD2GN1Po7YAieqAn8GQlewPJoc22xohMF3EuQcSPyfhYWI6kMLDw
AiLIUmKNcYCkAGoh6TVeSfizOBQjRE/WoQ3HTNISt7SPyfzlfdnhcBDBkB174anQ
RJ0V5Bqb6FvD+wzEtJDB9n58n8F0OLH08ppcCnh4Bv+WOZATtvyQ0HWjYvP80v3K
uKX0NQTW3Mwn9+JiMB/24K2uIlpPC6ODmH784IaDtEXRtPqCnXonFYM7FlDEO2vw
p4HLwGXaEHb59agKPcwJ5V51/GaKsPF8Qgf0H7Ocq4VbOWd0UCroU763tzMNrGf/
sGj4/GUqoEBaW6wPZtDE
=Cwu2
-----END PGP SIGNATURE-----

--iHnerqvU48eafvakIpdUHGd6rTJUXdhlS--

--===============0035203697==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============0035203697==--
