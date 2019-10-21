From: "Siqueira, Rodrigo" <Rodrigo.Siqueira-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH] drm: Fix DSC throughput mode 0 mask definition
Date: Mon, 21 Oct 2019 15:03:53 +0000
Message-ID: <20191021150345.igdye4kv35nsk4ox@outlook.office365.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2048910262=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
Content-Language: en-US
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
To: "Wentland, Harry" <Harry.Wentland-5C7GfCeVMHo@public.gmane.org>, "Li, Sun peng (Leo)" <Sunpeng.Li-5C7GfCeVMHo@public.gmane.org>, "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>, "Cornij, Nikola" <Nikola.Cornij-5C7GfCeVMHo@public.gmane.org>, Jani Nikula <jani.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Manasi Navare <manasi.d.navare-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, =?iso-8859-1?Q?Ville_Syrj=E4l=E4?= <ville.syrjala-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Rodrigo Siqueira <rodrigosiqueiramelo-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

--===============2048910262==
Content-Language: en-US
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="y3lsl3gfam5s22oo"

--y3lsl3gfam5s22oo
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Commit d7cd0e05 introduced a change at DP_DSC_THROUGHPUT_MODE_0_170
which is not aligned with the spec. This commit replace 15 << 4 by
15 << 0 for DP_DSC_THROUGHPUT_MODE_0_170 in order to make it follow the
specification.

Cc: Harry Wentland <harry.wentland-5C7GfCeVMHo@public.gmane.org>
Cc: Leo Li <sunpeng.li-5C7GfCeVMHo@public.gmane.org>
Cc: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>
Cc: Nikola Cornij <nikola.cornij-5C7GfCeVMHo@public.gmane.org>
Cc: Jani Nikula <jani.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Cc: Manasi Navare <manasi.d.navare-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: Ville Syrj=E4l=E4 <ville.syrjala-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Fixes: d7cd0e053b1 (drm/amd/display: Add 170Mpix/sec DSC throughput support)
Signed-off-by: Rodrigo Siqueira <Rodrigo.Siqueira-5C7GfCeVMHo@public.gmane.org>
---
 include/drm/drm_dp_helper.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/drm/drm_dp_helper.h b/include/drm/drm_dp_helper.h
index cfadeeef8492..52024049c59e 100644
--- a/include/drm/drm_dp_helper.h
+++ b/include/drm/drm_dp_helper.h
@@ -306,7 +306,7 @@
 # define DP_DSC_THROUGHPUT_MODE_0_900       (12 << 0)
 # define DP_DSC_THROUGHPUT_MODE_0_950       (13 << 0)
 # define DP_DSC_THROUGHPUT_MODE_0_1000      (14 << 0)
-# define DP_DSC_THROUGHPUT_MODE_0_170       (15 << 4)
+# define DP_DSC_THROUGHPUT_MODE_0_170       (15 << 0) /* 1.4a */
 # define DP_DSC_THROUGHPUT_MODE_1_MASK      (0xf << 4)
 # define DP_DSC_THROUGHPUT_MODE_1_SHIFT     4
 # define DP_DSC_THROUGHPUT_MODE_1_UPSUPPORTED 0
--=20
2.23.0

--y3lsl3gfam5s22oo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE4tZ+ii1mjMCMQbfkWJzP/comvP8FAl2tyNEACgkQWJzP/com
vP+7wA//cJA8A/GTTnrSIvANq6DelaHl5FiGoVqMsqRuDQ7RoM4/s35wzkbUzvkk
5MHuMxuYCH4DN824/ZZ4hwahyjuojTSZZj++/olO3UbzOFoT9DmlpUUZ/74H5eCp
pP5f/r2snJQkA/++RK0R2vW7NvkGcnjSbl2S0SIYlC7FWhq86pur4y3KkRFJQs1O
LPL98M2q4uR7L4a80InBT786ZjlyAy2rEQAMHjc1/to20EE7/ZZwTS4ESZaHm3Os
QWsA6Lm2bYxtusgi2hG8FQvLRWQEeNYAM5/VOGFrIPP9Oa0cyaXreRfp/iBzW304
aTYA8uRnEs3Gc9kdUeCWkYi7YZ6m8X9zaWlNmMd1KZph6EyJfZZxFW9lCvLnuYdm
AmO0FjCidw5Ws41EGQDPtd5BtMDXtuaE5OG129keR67E8G0vbS/a5cuYwTJ94ORW
lyrcZNhDFx2dhwaZdh0BpDGgddKtEX18ZWlk7zPFkAUzczBzAlNX2VDRL2pez9tJ
3+fzN3VZGdW2xdgecq87h5iYb8+XydhdFbU8J3YJTfiuyboEYoRvtxoBBzzZ+C6t
gnJ8uFsVCeUoJaexOIgrVLwXJ0Hs3uXt6XWqglGho0nsNMbDzyTlHqTddaBfSf13
WiTB74/T/8Q9X7oaIKyGOL+yTFyUZ66pVPdedlrbK88P/9Rawa8=
=0dLe
-----END PGP SIGNATURE-----

--y3lsl3gfam5s22oo--

--===============2048910262==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4

--===============2048910262==--
