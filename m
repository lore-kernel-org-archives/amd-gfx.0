From: Edward O'Callaghan <funfunctor-dczkZgxz+BNUPWh3PAxdjQ@public.gmane.org>
Subject: Re: [PATCH v2 0/3] Allow ASYNC flip with atomic helpers.
Date: Tue, 17 Jan 2017 16:33:58 +1100
Message-ID: <0e0d3611-e946-ca60-4ae7-428c041824d0@folklore1984.net>
References: <1484630207-27366-1-git-send-email-Andrey.Grodzovsky@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1152322418=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1484630207-27366-1-git-send-email-Andrey.Grodzovsky-5C7GfCeVMHo@public.gmane.org>
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
To: Andrey Grodzovsky <Andrey.Grodzovsky-5C7GfCeVMHo@public.gmane.org>, dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Cc: nouveau-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org, gustavo-THi1TnShQwVAfugRpC6u6w@public.gmane.org, Alexander.Deucher-5C7GfCeVMHo@public.gmane.org, daniel.vetter-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, Harry.Wentland-5C7GfCeVMHo@public.gmane.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--===============1152322418==
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="ESuGES8LoQRrSK9AqmN4Kf4QQxgfkw1vq"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--ESuGES8LoQRrSK9AqmN4Kf4QQxgfkw1vq
Content-Type: multipart/mixed; boundary="uFJ51xnREPtbbdPVPMqahQ7SXC4Xe2rmJ";
 protected-headers="v1"
From: Edward O'Callaghan <funfunctor-dczkZgxz+BNUPWh3PAxdjQ@public.gmane.org>
To: Andrey Grodzovsky <Andrey.Grodzovsky-5C7GfCeVMHo@public.gmane.org>,
 dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Cc: nouveau-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org,
 laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org, gustavo-THi1TnShQwVAfugRpC6u6w@public.gmane.org,
 Alexander.Deucher-5C7GfCeVMHo@public.gmane.org, daniel.vetter-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, Harry.Wentland-5C7GfCeVMHo@public.gmane.org
Message-ID: <0e0d3611-e946-ca60-4ae7-428c041824d0-dczkZgxz+BNUPWh3PAxdjQ@public.gmane.org>
Subject: Re: [PATCH v2 0/3] Allow ASYNC flip with atomic helpers.
References: <1484630207-27366-1-git-send-email-Andrey.Grodzovsky-5C7GfCeVMHo@public.gmane.org>
In-Reply-To: <1484630207-27366-1-git-send-email-Andrey.Grodzovsky-5C7GfCeVMHo@public.gmane.org>

--uFJ51xnREPtbbdPVPMqahQ7SXC4Xe2rmJ
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

This series is,
Reviewed-by: Edward O'Callaghan <funfunctor-dczkZgxz+BNUPWh3PAxdjQ@public.gmane.org>

On 01/17/2017 04:16 PM, Andrey Grodzovsky wrote:
> This series is a folow-up on
> https://patchwork.kernel.org/patch/9501787/
>=20
> The first patch makes changes to atomic helpers to allow for=20
> drives with ASYNC flip support to use them.
> Patch 2 is to use this in AMDGPU/DC.
> Patch 3 is possible cleanup in nouveau/kms who seems to have to duplica=
te=20
> the helper as we did to support ASYNC flips.=20
>=20
> v2:=20
> Resend drm/atomic: Save flip flags in drm_plane_state since
> the original patch was incomplete.
> Squash 2 AMD changes into one to not break compilation.
>=20
> Andrey Grodzovsky (3):
>   drm/atomic: Save flip flags in drm_plane_state
>   drm/amd/display: Switch to using atomic_helper for flip.
>   drm/nouveau/kms/nv50: Switch to using atomic helper for flip.
>=20
>  drivers/gpu/drm/amd/amdgpu/amdgpu_mode.h           |  1 -
>  .../drm/amd/display/amdgpu_dm/amdgpu_dm_types.c    | 92 ++------------=
--------
>  drivers/gpu/drm/drm_atomic_helper.c                | 18 ++---
>  drivers/gpu/drm/nouveau/nv50_display.c             | 77 ++------------=
----
>  include/drm/drm_plane.h                            |  8 ++
>  5 files changed, 24 insertions(+), 172 deletions(-)
>=20


--uFJ51xnREPtbbdPVPMqahQ7SXC4Xe2rmJ--

--ESuGES8LoQRrSK9AqmN4Kf4QQxgfkw1vq
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJYfazGAAoJEP4bvbfZuWjbrLAP/jdlOlNI3eBjq0xSQMJ4kS22
UmWKyXFUV79Sp/93DmG7HLpf6tng0aZ6C95Van7eqyh+Yy7H7RVxTd1jQA7ZkRpC
kp1gL3XqERPddfEO6PBDPNs8krpTM263+hP+vTdsXaljCBI72fvbKGRG7Wbu2Bsy
rRnDbngQd1JKtBIy9e2+DSA8bU9H5DS5DY5/mRXFHZ/IBpa69vdYrXmaal2e3TS6
UfM32fp1jmqScSpNZndlAC59ozUP6Yqf8DLCLxbqca5hn9XDG8nEmANI5FdgTWIk
EWCVxG+DrepZEYYYdeD5SPK6fTskXkkwQoHJUItYYZaONGI5FFBbo2S1/I34gRJm
tt8Zf1JDeKFSBk8zBJr/Xloj/6wCsvr4uKM2dLwwSLDCnbFgistGCayK1u0Y9EQt
YUkNSPRyumizlS8r94hn+8i4XKDmjOO7RpNyn9F23B+Hywdqpwxq+NV9uOLmrUeL
ZlCGcO1bLhQ6jE4mj6ksAD+gcSnCyJKKl9ZskYOSezZw3npIyvi8E6e787a2ElXK
+NZ41RQhPScgpl+K6glu1Ez2mPOH9t3aWlaijj0Zw0+tPYj5Al/Qn6SVpTNNJAaj
9N2ZNwVMnPmw4DhA8dZrDaBq9vHQsUCOxuDi0Jf1xOTqyp/WnsyGKOih1qaaGLOW
9kBG4v4GBBzj0dpLVj25
=N+Xe
-----END PGP SIGNATURE-----

--ESuGES8LoQRrSK9AqmN4Kf4QQxgfkw1vq--

--===============1152322418==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============1152322418==--
