From: "Siqueira, Rodrigo" <Rodrigo.Siqueira@amd.com>
Subject: [PATCH] drm/amdgpu: Initialize variable before use
Date: Mon, 30 Sep 2019 20:09:13 +0000
Message-ID: <20190930200902.inmjn264l6pxcdsq@outlook.office365.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0268369342=="
Return-path: <dri-devel-bounces@lists.freedesktop.org>
Content-Language: en-US
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc: "Li, Sun peng (Leo)" <Sunpeng.Li@amd.com>, "Kazlauskas,
 Nicholas" <Nicholas.Kazlauskas@amd.com>, David Airlie <airlied@linux.ie>, "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Koenig,
 Christian" <Christian.Koenig@amd.com>
List-Id: amd-gfx.lists.freedesktop.org

--===============0268369342==
Content-Language: en-US
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="txxk4cquvzk7uxl3"

--txxk4cquvzk7uxl3
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The 'debug_data' variable gets printed in debug statements without a
prior initialization in the function
hubbub1_verify_allow_pstate_change_high, as reported when building with
gcc 9.1.0:

warning: =E2=80=98debug_data=E2=80=99 may be used uninitialized in this fun=
ction [-Wmaybe-uninitialized]
  290 |  printk##once(KERN_##level "[" DRM_NAME "] " fmt, ##__VA_ARGS__)
      |  ^~~~~~
dc/dcn10/dcn10_hubbub.c:134:15: note: =E2=80=98debug_data=E2=80=99 was decl=
ared here
  134 |  unsigned int debug_data;

Note that initialize debug_data with 0, in this case, is safe because we
have a loop in a few lines below that will initialize this variable with
the proper value.

Signed-off-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hubbub.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hubbub.c b/drivers/=
gpu/drm/amd/display/dc/dcn10/dcn10_hubbub.c
index a780057e2dbc..b6967a7e6c7b 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hubbub.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hubbub.c
@@ -133,7 +133,7 @@ bool hubbub1_verify_allow_pstate_change_high(
 	static unsigned int max_sampled_pstate_wait_us; /* data collection */
 	static bool forced_pstate_allow; /* help with revert wa */
=20
-	unsigned int debug_data;
+	unsigned int debug_data =3D 0;
 	unsigned int i;
=20
 	if (forced_pstate_allow) {
--=20
2.23.0

--txxk4cquvzk7uxl3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE4tZ+ii1mjMCMQbfkWJzP/comvP8FAl2SYN4ACgkQWJzP/com
vP+ZZw//TKZ68EVv0YJGu9G+5mCRQGjtH1CmeD85MF3RHxVMdiHJun2AFJkz38aH
slGNn0FclGf7r9y7iYvI7yDwlBRBS3g+Dj/pkk9zfUZ2XpiEP02LrZiSEyVv9zF+
Y7NKhHp7nYMGwAVytlpRYglH20BlvthMGE9Rt42GTmdFDY8LYeTB/5J6Nl6R+/EZ
4uhOPTwcRffUK7TNqsBIuqnSUbrBt1ekpgm4baJeUKsPzx26q6bPO42AsX2JJhdJ
58TPbsN/8WvHfHdx/vL0/cJ9+aD6YeDhfTEm+nYJ42OIVcUmLEJqOA5Y54EWTPg7
yDA3KCNhnVNMXl00DDj9LyADEm8jMBniN729Arp01S9Ak6Aiw5xrpauEvyXScr4S
1uy+PpInyvDNcHT0i1GGRRycVvbCzQHCd4YYxL3TxCgemUIA9Wzj2vLw1UhZKp+s
gTDuAbghFwW9Nn+w3AXP1NT+VvBmP7FGNdEL7Q6Q1MN1X5w7Dy1oPz+wANeBPN71
ChGp6vF+9TLjCyx/u0Y3Hu+nnKlLDpnlPaVtUC31NhsgkbDgpJA5sHCSQVJjrKTy
cVKcGjpVBcSd0dzppxvhX9tShBcjnvvDjIuNLaxDFenla/aeubQt9GLiPMeAOxCu
Bv+g6gD9cRatgMWFEBc1VjZwlu0679U8Q+X07X2YrZtmdwv5aDo=
=oORu
-----END PGP SIGNATURE-----

--txxk4cquvzk7uxl3--

--===============0268369342==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KZHJpLWRldmVs
IG1haWxpbmcgbGlzdApkcmktZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlz
dHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vZHJpLWRldmVs

--===============0268369342==--
