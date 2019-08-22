From: "Siqueira, Rodrigo" <Rodrigo.Siqueira-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH] drm: Add LTTPR defines for DP 1.4
Date: Thu, 22 Aug 2019 22:46:12 +0000
Message-ID: <20190822224607.m73g3a2a23zww644@outlook.office365.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0546193834=="
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

--===============0546193834==
Content-Language: en-US
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="kkqc63twztjn7o6t"

--kkqc63twztjn7o6t
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

DP 1.4 specification defines Link Training Tunable PHY Repeater (LTTPR)
which is required to add support for systems with Thunderbolt or other
repeater devices.

Cc: Abdoulaye Berthe <Abdoulaye.Berthe-5C7GfCeVMHo@public.gmane.org>
Cc: Harry Wentland <harry.wentland-5C7GfCeVMHo@public.gmane.org>
Cc: Leo Li <sunpeng.li-5C7GfCeVMHo@public.gmane.org>
Signed-off-by: Rodrigo Siqueira <Rodrigo.Siqueira-5C7GfCeVMHo@public.gmane.org>
Signed-off-by: Abdoulaye Berthe <Abdoulaye.Berthe-5C7GfCeVMHo@public.gmane.org>
---
 include/drm/drm_dp_helper.h | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/include/drm/drm_dp_helper.h b/include/drm/drm_dp_helper.h
index 8364502f92cf..8336d960da7f 100644
--- a/include/drm/drm_dp_helper.h
+++ b/include/drm/drm_dp_helper.h
@@ -134,6 +134,32 @@
 #define DP_SUPPORTED_LINK_RATES		    0x010 /* eDP 1.4 */
 # define DP_MAX_SUPPORTED_RATES		     8	    /* 16-bit little-endian */
=20
+/** Link Training (LT)-tunable Physical Repeaters - DP 1.4 **/
+#define DP_LTTPR_REV                                  0xf0000
+#define DP_LTTPR_MAX_LINK_RATE                        0xf0001
+#define DP_LTTPR_REPEATER_CNT                         0xf0002
+#define DP_LTTPR_REPEATER_MODE                        0xf0003
+#define DP_LTTPR_MAX_LANE_CNT                         0xf0004
+#define DP_LTTPR_EXTENDED_WAIT_TIMEOUT                0xf0005
+#define DP_LTTPR_TRAINING_PATTERN_SET_REPEATER1       0xf0010
+#define DP_LTTPR_TRAINING_LANE0_SET_REPEATER1         0xf0011
+#define DP_LTTPR_TRAINING_LANE1_SET_REPEATER1         0xf0012
+#define DP_LTTPR_TRAINING_LANE2_SET_REPEATER1         0xf0013
+#define DP_LTTPR_TRAINING_LANE3_SET_REPEATER1         0xf0014
+#define DP_LTTPR_TRAINING_AUX_RD_INTERVAL_REPEATER1   0xf0020
+#define DP_LTTPR_TRANSMITTER_CAPABILITY_REPEATER1     0xf0021
+#define DP_LTTPR_LANE0_1_STATUS_REPEATER1             0xf0030
+#define DP_LTTPR_LANE2_3_STATUS_REPEATER1             0xf0031
+#define DP_LTTPR_LANE_ALIGN_STATUS_UPDATED_REPEATER1  0xf0032
+#define DP_LTTPR_ADJUST_REQUEST_LANE0_1_REPEATER1     0xf0033
+#define DP_LTTPR_ADJUST_REQUEST_LANE2_3_REPEATER1     0xf0034
+#define DP_LTTPR_SYMBOL_ERROR_COUNT_LANE0_REPEATER1   0xf0035
+#define DP_LTTPR_SYMBOL_ERROR_COUNT_LANE1_REPEATER1   0xf0037
+#define DP_LTTPR_SYMBOL_ERROR_COUNT_LANE2_REPEATER1   0xf0039
+#define DP_LTTPR_SYMBOL_ERROR_COUNT_LANE3_REPEATER1   0xf003b
+#define DP_REPEATER_CONFIGURATION_AND_STATUS_OFFSET   0x50
+#define DP_LTTPR_FEC_STATUS_REPEATER1                 0xf0290
+
 /* Multiple stream transport */
 #define DP_FAUX_CAP			    0x020   /* 1.2 */
 # define DP_FAUX_CAP_1			    (1 << 0)
--=20
2.23.0

--kkqc63twztjn7o6t
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE4tZ+ii1mjMCMQbfkWJzP/comvP8FAl1fGy8ACgkQWJzP/com
vP+a2BAAwfPB7FBqmETG+jBr4xesGSLNQ1cQU2VdDI6K/Xf0hn3CxkWsIHI9MBAF
bBqtKMB45t6oKFVMzOYv58f0l5K6RcS1HznrjrM2Njp2wyC89CA4jAsjz4zBCKja
MqNbJ4FEfSNrKrdk4tVZm6DCcmFRdQi+G/EmRoRuuz970fKFOWqjjfU537J2S1n2
kmQ7HPaJz19TaVZilw34uo+fJh2mq+BmsRIxrKwAR37hTf8GSmMnbLWflueoM+LX
v/3X20xLhOgeuQHN6t9s9O75AzuhE5xVou7iPXnHyPgXWeVaaiOQR8wxgBond0Ch
9n95SgoOdIzX/+yYD3nz+ggRVYLv2Z/wS9345lagI9UmOGsKoPCuH9KL2vEwF/WL
0ZE+byshobQL+ybysPb5a0K8nUsjJpprlCJW2cAOTGBl8n1AX5tprif/15pHSAox
goDQ/iVJ+JCmF1MeQuBPcP71pqCcUqHENBxp0Y1GNmNd/fONs7QC9uTg1i2FA2p0
IiERQLTm4lj4VaBfy4zlgFqdzn6DRjg0Al8YYm5wCyjO+GRL3C0yKb2Brq8P3CKS
If0LTuvNaryasqqyG8m366CYB3dqeLrdOwOazxjXLvanrI2WtO7Fm1VHLc3aNOUQ
kYYnEZHt2pGdBK1MXmUMs6UxU7dqeowoCLcClSi1/OJY2TbkdBE=
=raUH
-----END PGP SIGNATURE-----

--kkqc63twztjn7o6t--

--===============0546193834==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4

--===============0546193834==--
