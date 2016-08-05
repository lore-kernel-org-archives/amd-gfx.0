From: Edward O'Callaghan <funfunctor-dczkZgxz+BNUPWh3PAxdjQ@public.gmane.org>
Subject: Re: [PATCH 00/19] shadow page table support V2
Date: Fri, 5 Aug 2016 20:12:25 +1000
Message-ID: <c7791adb-5265-8529-2858-f3784dc52f3e@folklore1984.net>
References: <1470389926-5719-1-git-send-email-David1.Zhou@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0851527228=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1470389926-5719-1-git-send-email-David1.Zhou-5C7GfCeVMHo@public.gmane.org>
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
To: Chunming Zhou <David1.Zhou-5C7GfCeVMHo@public.gmane.org>, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--===============0851527228==
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="cxwDwJAA67Bc61MdaCc5n0ftL04VSnejg"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--cxwDwJAA67Bc61MdaCc5n0ftL04VSnejg
Content-Type: multipart/mixed; boundary="FE2AfAs1LFAWswXAvcP2J7hJ6bjU0dV65"
From: Edward O'Callaghan <funfunctor-dczkZgxz+BNUPWh3PAxdjQ@public.gmane.org>
To: Chunming Zhou <David1.Zhou-5C7GfCeVMHo@public.gmane.org>, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Message-ID: <c7791adb-5265-8529-2858-f3784dc52f3e-dczkZgxz+BNUPWh3PAxdjQ@public.gmane.org>
Subject: Re: [PATCH 00/19] shadow page table support V2
References: <1470389926-5719-1-git-send-email-David1.Zhou-5C7GfCeVMHo@public.gmane.org>
In-Reply-To: <1470389926-5719-1-git-send-email-David1.Zhou-5C7GfCeVMHo@public.gmane.org>

--FE2AfAs1LFAWswXAvcP2J7hJ6bjU0dV65
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable



On 08/05/2016 07:38 PM, Chunming Zhou wrote:
> Since we cannot make sure VRAM is safe after gpu reset, page table back=
up
> is neccessary, shadow page table is sense way to recovery page talbe wh=
en
> gpu reset happens.

Hmm, bit of a nitpick but the following is perhaps a little better wordin=
g:

s/Since we cannot ensure VRAM is consistent after a GPU reset, page
table shadowing is necessary. Shadowed page tables are, in a sense, a
method to recover the consistent state of the page tables before the
reset occurred.


> We need to allocate GTT bo as the shadow of VRAM bo when creating page =
table,
> and make them same. After gpu reset, we will need to use SDMA to copy G=
TT bo
s/make them same/make them the same/

Hope this is helpful,
Kind Regards,
Edward.

> content to VRAM bo, then page table will be recoveried.=20
>=20
> V2:
> Shadow bo uses a shadow entity running on normal run queue, after gpu r=
eset,
> we need to wait for all shadow jobs finished first, then recovery page =
table from shadow.
>=20
> Chunming Zhou (19):
>   drm/amdgpu: add shadow bo support
>   drm/amdgpu: validate shadow as well when validating bo
>   drm/amdgpu: allocate shadow for pd/pt bo
>   drm/amdgpu: add shadow flag
>   drm/amdgpu: sync bo and shadow
>   drm/amdgpu: implement vm recovery function from shadow
>   drm/amdgpu: fix vm init error path
>   drm/amdgpu: add shadow_entity for shadow page table updates
>   drm/amdgpu: update pd shadow bo
>   drm/amdgpu: update pt shadow
>   drm/amd: add last fence in sched entity
>   drm/amdgpu: link all vm clients
>   drm/amdgpu: add vm_list_lock
>   drm/amd: add block entity function
>   drm/amdgpu: add shadow fence owner
>   drm/amd: block entity
>   drm/amdgpu: recover page tables after gpu reset
>   drm/amdgpu: add need backup function
>   drm/amdgpu: add backup condition for vm
>=20
>  drivers/gpu/drm/amd/amdgpu/amdgpu.h           |  25 +++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c        |  82 +++++---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c    |  88 ++++++++-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_object.c    | 104 +++++++++-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_object.h    |   5 +
>  drivers/gpu/drm/amd/amdgpu/amdgpu_sync.c      |   3 +
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c        | 270 ++++++++++++++++++=
+-------
>  drivers/gpu/drm/amd/scheduler/gpu_scheduler.c |  38 +++-
>  drivers/gpu/drm/amd/scheduler/gpu_scheduler.h |   5 +
>  include/uapi/drm/amdgpu_drm.h                 |   2 +
>  10 files changed, 519 insertions(+), 103 deletions(-)
>=20


--FE2AfAs1LFAWswXAvcP2J7hJ6bjU0dV65--

--cxwDwJAA67Bc61MdaCc5n0ftL04VSnejg
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJXpGaJAAoJEP4bvbfZuWjbENYP/jQv57ze14rHbn58Po3v3DKJ
kjcmdPhil0sCjeCjY0jPYEyMlhPTnvt78PvSIa4EmHpImLsvizhTVYoWTb4jiN1n
WbU5G2t7pVCdAEl1KFRYvjOdpzqMT0QnGgRl6w6ElUXv2QjNBE16LqpmYCOZ2Q+x
eAiO0buMozJeLKNhmvZy0C+ZHyO6WwtNXo3T7KT0+D9Rz/gLSst+yoe/GNJMSBBx
ekJ1POgJcFJHKk8143ld0S1ggSnhq6sx8izqWAY9reXDIVgKhkMWKsfge2y+6OF9
PnvVnzjSrFtAGx5ugojffVBkCdw/Lp26MtPT7W6vo1+r9eDqJv+roUEdSIHbOrLb
nj2LrgfeJfwN+exsV0wiKkmV9FJ9d64UdDqH+cyKN+VesuAyVup2YwNVlCokB8xV
ITnFJcMR9nZHRAfy8w6okDcp3Tzgjapxoz8I8M2Yhu0NarbHtAaWHI22a/sGw0UF
ap7TvkfAJ5LGIEA0slN1A4XeZxYawDwSVo/j54HCTPo8zQc7AxaJKhvBGqNnVtwy
v1ixOTgFJkdD6SziU8KWWgggyEUeQ/kPSOF/9Y3N41uobzPyb6IoEpVSOb/S5j5p
h6FT2vuBd89xtPETyjOlbhMz9rR+y86Zi1jaw5K+/dvRFBTcCzFEEPpHE0mOE7V0
wEwlEjAiibjiJKt9075B
=lqGC
-----END PGP SIGNATURE-----

--cxwDwJAA67Bc61MdaCc5n0ftL04VSnejg--

--===============0851527228==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============0851527228==--
