From: "Siqueira, Rodrigo" <Rodrigo.Siqueira-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH V2] drm: Add LTTPR defines for DP 1.4a
Date: Mon, 26 Aug 2019 15:29:22 +0000
Message-ID: <20190826152925.4x7mwhzxit353yww@outlook.office365.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1103829864=="
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
To: "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, "dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
Cc: "Li, Sun peng (Leo)" <Sunpeng.Li-5C7GfCeVMHo@public.gmane.org>, "Berthe,
 Abdoulaye" <Abdoulaye.Berthe-5C7GfCeVMHo@public.gmane.org>, "Wentland,
 Harry" <Harry.Wentland-5C7GfCeVMHo@public.gmane.org>

--===============1103829864==
Content-Language: en-US
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="mepy6fehghb3th64"

--mepy6fehghb3th64
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

DP 1.4a specification defines Link Training Tunable PHY Repeater (LTTPR)
which is required to add support for systems with Thunderbolt or other
repeater devices.

Changes since V1:
- Adjusts registers names to be aligned with spec and the rest of the
  file
- Update spec comment from 1.4 to 1.4a

Cc: Abdoulaye Berthe <Abdoulaye.Berthe-5C7GfCeVMHo@public.gmane.org>
Cc: Harry Wentland <harry.wentland-5C7GfCeVMHo@public.gmane.org>
Cc: Leo Li <sunpeng.li-5C7GfCeVMHo@public.gmane.org>
Signed-off-by: Rodrigo Siqueira <Rodrigo.Siqueira-5C7GfCeVMHo@public.gmane.org>
Signed-off-by: Abdoulaye Berthe <Abdoulaye.Berthe-5C7GfCeVMHo@public.gmane.org>
---
 include/drm/drm_dp_helper.h | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/include/drm/drm_dp_helper.h b/include/drm/drm_dp_helper.h
index 8364502f92cf..e8beb4e7e5da 100644
--- a/include/drm/drm_dp_helper.h
+++ b/include/drm/drm_dp_helper.h
@@ -134,6 +134,31 @@
 #define DP_SUPPORTED_LINK_RATES		    0x010 /* eDP 1.4 */
 # define DP_MAX_SUPPORTED_RATES		     8	    /* 16-bit little-endian */
=20
+/** Link Training (LT)-tunable Physical Repeaters - DP 1.4a **/
+#define DP_LT_TUNABLE_PHY_REPEATER_FIELD_DATA_STRUCTURE_REV 0xf0000
+#define DP_MAX_LINK_RATE_PHY_REPEATER                       0xf0001
+#define DP_PHY_REPEATER_CNT                                 0xf0002
+#define DP_PHY_REPEATER_MODE                                0xf0003
+#define DP_MAX_LANE_COUNT_PHY_REPEATER                      0xf0004
+#define DP_PHY_REPEATER_EXTENDED_WAIT_TIMEOUT               0xf0005
+#define DP_TRAINING_PATTERN_SET_PHY_REPEATER1               0xf0010
+#define DP_TRAINING_LANE0_SET_PHY_REPEATER1                 0xf0011
+#define DP_TRAINING_LANE1_SET_PHY_REPEATER1                 0xf0012
+#define DP_TRAINING_LANE2_SET_PHY_REPEATER1                 0xf0013
+#define DP_TRAINING_LANE3_SET_PHY_REPEATER1                 0xf0014
+#define DP_TRAINING_AUX_RD_INTERVAL_PHY_REPEATER1           0xf0020
+#define DP_TRANSMITTER_CAPABILITY_PHY_REPEATER1             0xf0021
+#define DP_LANE0_1_STATUS_PHY_REPEATER1                     0xf0030
+#define DP_LANE2_3_STATUS_PHY_REPEATER1                     0xf0031
+#define DP_LANE_ALIGN_STATUS_UPDATED_PHY_REPEATER1          0xf0032
+#define DP_ADJUST_REQUEST_LANE0_1_PHY_REPEATER1             0xf0033
+#define DP_ADJUST_REQUEST_LANE2_3_PHY_REPEATER1             0xf0034
+#define DP_SYMBOL_ERROR_COUNT_LANE0_PHY_REPEATER1           0xf0035
+#define DP_SYMBOL_ERROR_COUNT_LANE1_PHY_REPEATER1           0xf0037
+#define DP_SYMBOL_ERROR_COUNT_LANE2_PHY_REPEATER1           0xf0039
+#define DP_SYMBOL_ERROR_COUNT_LANE3_PHY_REPEATER1           0xf003b
+#define DP_FEC_STATUS_PHY_REPEATER1                         0xf0290
+
 /* Multiple stream transport */
 #define DP_FAUX_CAP			    0x020   /* 1.2 */
 # define DP_FAUX_CAP_1			    (1 << 0)
--=20
2.23.0

--mepy6fehghb3th64
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE4tZ+ii1mjMCMQbfkWJzP/comvP8FAl1j+tQACgkQWJzP/com
vP/X5hAAuy945amvZTEO7GL1f00ONJUknkj+mhWR8NzZJe+3c/NzmwJkOWRWFtN2
mdEoK9j7oAW+ERQ2QxPwKKtP1vsLkqfp8SQ6aBuhu3ABpnQUmROQMK8yTcMVw2FW
DA7UWsl8YD8CXJzvWbiNH4zgSkp4H/5xzTsmBLccceVxSaIxgASOzvugm9sxv9tu
Pp9fwmoK4+VGErMJy7fqgcRqC1r8otYmMGuEuoglJDFBE+/rjBdyKr39iSzWyZF4
ak3v/XSjE9wF+NbWl/karWEJAEBSZnsbd04g/lz6hC1C2f2SVnW/6xgzkqlTrLon
zKq1iWJ1sJFYmRSiG+xE2Y4ukHclGLAbnUc0+9OaO2wNpkcwoB5P77NAdtXdayNd
qZn+mZgpqwsFQeURuJIsngX8dIFPSTOKbGruPeMwwNhB4+HnfAo8OXHTZpcw26ON
Ep1DXdPJ81J2VlPPin/Rcp0wjg26iDU+YrMU1qOTwq4rgs8G+1S28DS8LvAfFKjX
1JX5Hu9cBfwFAMkBZuyP4z6vmnCmWG/MGsORuEl/4wJ8KukIWapAA/LNB/sGoE/w
lGNNCf4xOycP/tcdSJHztVDy66BNIxffI9XGKtHhoSwqe2YvF41LbJ1GxoAyzugz
b2WdoYQNk8/XgRZ9hHTOSFKnhS/RasBo7Hz9uBQN+mfqTK6ZKgs=
=6MQ1
-----END PGP SIGNATURE-----

--mepy6fehghb3th64--

--===============1103829864==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4

--===============1103829864==--
