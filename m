From: =?UTF-8?Q?Kai_Wasserb=c3=a4ch?= <kai-1ZKVMVCtJ2dx9oSEVPI0kiST3g8Odh+X@public.gmane.org>
Subject: Re: [PATCH 00/12] DC Patches for Dec 7, 2016
Date: Thu, 8 Dec 2016 17:43:58 +0100
Message-ID: <537b4136-c619-248a-150c-a12fcae920e0@dev.carbon-project.org>
References: <20161208012624.8914-1-harry.wentland@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1962070459=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20161208012624.8914-1-harry.wentland-5C7GfCeVMHo@public.gmane.org>
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
To: Harry Wentland <harry.wentland-5C7GfCeVMHo@public.gmane.org>, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--===============1962070459==
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="b1f9e4UrE9Hisn8rAUte8qAOF93IHF0NL"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--b1f9e4UrE9Hisn8rAUte8qAOF93IHF0NL
Content-Type: multipart/mixed; boundary="BwpFMoihAMiab20xpuv23wpXa1r6tVqNS";
 protected-headers="v1"
From: =?UTF-8?Q?Kai_Wasserb=c3=a4ch?= <kai-1ZKVMVCtJ2dx9oSEVPI0kiST3g8Odh+X@public.gmane.org>
To: Harry Wentland <harry.wentland-5C7GfCeVMHo@public.gmane.org>, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Message-ID: <537b4136-c619-248a-150c-a12fcae920e0-1ZKVMVCtJ2dx9oSEVPI0kiST3g8Odh+X@public.gmane.org>
Subject: Re: [PATCH 00/12] DC Patches for Dec 7, 2016
References: <20161208012624.8914-1-harry.wentland-5C7GfCeVMHo@public.gmane.org>
In-Reply-To: <20161208012624.8914-1-harry.wentland-5C7GfCeVMHo@public.gmane.org>

--BwpFMoihAMiab20xpuv23wpXa1r6tVqNS
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

[Please CC me on all replies, I'm not subscribed to the list.]

Dear Harry,
I've sent a couple of questions/suggestions/notes on patches 2, 5, 10 and=
 12.
Since I'm not familiar with the module these comments are mostly
stylistic/understanding. But there's also a null pointer dereference ques=
tion in
there. ;-)
Apart from that I was wondering, if there is any recent tree containing a=
ll of
DAL/Display? The latest version I've seen is
<https://cgit.freedesktop.org/~agd5f/linux/log/?h=3Damd-staging-4.7>, but=
 that
doesn't seem to be based on a more recent 4.9/4.10? Is there a rebased ve=
rsion
available somewhere?

Thanks,
Kai


Harry Wentland wrote on 08.12.2016 02:26:
> * bunch of warning fixes
> * some bug fixes
> * more display_clock cleanup
>=20
> Andrey Grodzovsky (1):
>   drm/amd/display: Fix refcount over dc_sink.
>=20
> Arindam Nath (1):
>   drm/amd/display: remove DM_NOT_IMPL messages
>=20
> Ding Wang (1):
>   drm/amd/display: Temporarily blocking interlacing mode until it's
>     supported.
>=20
> Dmytro Laktyushkin (2):
>   drm/amd/display: moving remaining functionality from gpu to dce_clock=
s
>   drm/amd/display: fix up construction of scratch_val_ctx
>=20
> Harry Wentland (3):
>   drm/amd/display: Fix bunch of warnings in DC
>   drm/amd/display: Fix warning in freesync module
>   drm/amd/display: Fix warning. Set MAX_SURFACES to 3
>=20
> Tony Cheng (2):
>   drm/amd/display: fix indexing bug
>   drm/amd/display: avoid apply_clk_constraints for address update
>=20
> Zeyu Fan (2):
>   drm/amd/display: Fix bugs causing Hawaii and Bonaire not light up.
>   drm/amd/display: Fix hdmi not lighting up on Hawaii.
>=20
>  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c  |  20 +-
>  drivers/gpu/drm/amd/display/dc/Makefile            |   7 +-
>  .../dc/bios/dce110/command_table_helper_dce110.c   |   2 +-
>  .../dc/bios/dce112/command_table_helper_dce112.c   |   2 +-
>  .../gpu/drm/amd/display/dc/calcs/bandwidth_calcs.c |   2 +-
>  drivers/gpu/drm/amd/display/dc/core/dc.c           |  20 +-
>  drivers/gpu/drm/amd/display/dc/core/dc_resource.c  |   5 +-
>  drivers/gpu/drm/amd/display/dc/dc.h                |   2 +-
>  .../gpu/drm/amd/display/dc/dce/dce_clock_source.c  |   5 -
>  drivers/gpu/drm/amd/display/dc/dce/dce_clocks.c    | 142 +++++++++--
>  drivers/gpu/drm/amd/display/dc/dce/dce_clocks.h    |  36 ++-
>  .../gpu/drm/amd/display/dc/dce/dce_link_encoder.c  |   4 +-
>  drivers/gpu/drm/amd/display/dc/dce/dce_transform.c |   2 -
>  .../display/dc/dce110/dce110_timing_generator.c    |   4 +
>  .../drm/amd/display/dc/dce110/dce110_transform_v.c |   3 +-
>  drivers/gpu/drm/amd/display/dc/gpu/Makefile        |  21 --
>  .../display/dc/gpu/dce112/display_clock_dce112.c   | 277 -------------=
--------
>  .../display/dc/gpu/dce112/display_clock_dce112.h   |  79 ------
>  drivers/gpu/drm/amd/display/dc/gpu/divider_range.c | 127 ----------
>  drivers/gpu/drm/amd/display/dc/gpu/divider_range.h |  62 -----
>  drivers/gpu/drm/amd/display/dc/inc/core_types.h    |   4 +-
>  .../inc/hw/display_clock.h}                        |  27 +-
>  .../drm/amd/display/modules/freesync/freesync.c    |   3 +
>  23 files changed, 207 insertions(+), 649 deletions(-)
>  delete mode 100644 drivers/gpu/drm/amd/display/dc/gpu/Makefile
>  delete mode 100644 drivers/gpu/drm/amd/display/dc/gpu/dce112/display_c=
lock_dce112.c
>  delete mode 100644 drivers/gpu/drm/amd/display/dc/gpu/dce112/display_c=
lock_dce112.h
>  delete mode 100644 drivers/gpu/drm/amd/display/dc/gpu/divider_range.c
>  delete mode 100644 drivers/gpu/drm/amd/display/dc/gpu/divider_range.h
>  rename drivers/gpu/drm/amd/display/{include/display_clock_interface.h =
=3D> dc/inc/hw/display_clock.h} (75%)
>=20

--=20

Kai Wasserb=C3=A4ch (Kai Wasserbaech)

E-Mail: kai-1ZKVMVCtJ2dx9oSEVPI0kiST3g8Odh+X@public.gmane.org


--BwpFMoihAMiab20xpuv23wpXa1r6tVqNS--

--b1f9e4UrE9Hisn8rAUte8qAOF93IHF0NL
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAEBCgAdFiEEBgCWzvPI5zPlthWHownXbOHeWdIFAlhJjeIACgkQownXbOHe
WdKtFAv7BFY2yMR1XHTBE9+Fic+bcbNv0RSKGSBOezNvfY8XKF6k4TfYL0sEh8Hm
Zegh9xrLTBbDaDoVrkKlX8Zy0uWzY0d6ZApFroEBxDn9zJi84p3exhVW3MkJ/+LT
PkdK4BN/1YpGhzhSr3Ai30lhH4/IgH0trWQy8f6yFjj6OULYZrMHxR9vH/xPv2Mq
9MlQbqIOJB6rz82Q0jepDwZhw31zOe+HVmOWzMA87xmB08dropK864dL9By5Vaq7
1QRt0w6mSeAc5oyUZ+Kq/MlifDwAALrec2iNz2Ch4f6pmwqkOddXdZELVY+klln5
cdZZXLn74x+HKkTmkUl7q3MVRZ+WmVn5N4LBhR69TEQwryg46dZv0AXW3SDu4Fpd
dlT2Zdw9HKW1vZOwRQTer1FFiqPUH8T8eV1LVBsjMWA4x0FloPtrjYey06XYKad2
pbPjPlCGp39SFYop8QsZfXKWEQJ+2c8Y4ZLqu9I/zftx4rP3ODcM0iFZY2EsU7HG
ADxcUiyl
=0/vd
-----END PGP SIGNATURE-----

--b1f9e4UrE9Hisn8rAUte8qAOF93IHF0NL--

--===============1962070459==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============1962070459==--
