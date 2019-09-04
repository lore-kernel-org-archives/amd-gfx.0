From: "Siqueira, Rodrigo" <Rodrigo.Siqueira-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH V4] drm: Add LTTPR defines for DP 1.4a
Date: Wed, 4 Sep 2019 19:02:18 +0000
Message-ID: <20190904190116.klyt2rjg3svswmot@outlook.office365.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1863908483=="
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
 Abdoulaye" <Abdoulaye.Berthe-5C7GfCeVMHo@public.gmane.org>, Manasi Navare <manasi.d.navare-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Daniel Vetter <daniel-/w4YWyX8dFk@public.gmane.org>, "Wentland, Harry" <Harry.Wentland-5C7GfCeVMHo@public.gmane.org>, =?iso-8859-1?Q?Ville_Syrj=E4l=E4?= <ville.syrjala-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>

--===============1863908483==
Content-Language: en-US
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="mxdoj3tukgzujy23"

--mxdoj3tukgzujy23
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

DP 1.4a specification defines Link Training Tunable PHY Repeater (LTTPR)
which is required to add support for systems with Thunderbolt or other
repeater devices.

Changes since V3:
- Replace spaces by tabs
Changes since V2:
- Drop the kernel-doc comment
- Reorder LTTPR according to register offset
Changes since V1:
- Adjusts registers names to be aligned with spec and the rest of the
  file
- Update spec comment from 1.4 to 1.4a

Cc: Abdoulaye Berthe <Abdoulaye.Berthe-5C7GfCeVMHo@public.gmane.org>
Cc: Harry Wentland <harry.wentland-5C7GfCeVMHo@public.gmane.org>
Cc: Leo Li <sunpeng.li-5C7GfCeVMHo@public.gmane.org>
Cc: Jani Nikula <jani.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Cc: Manasi Navare <manasi.d.navare-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: Ville Syrj=E4l=E4 <ville.syrjala-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Signed-off-by: Rodrigo Siqueira <Rodrigo.Siqueira-5C7GfCeVMHo@public.gmane.org>
Signed-off-by: Abdoulaye Berthe <Abdoulaye.Berthe-5C7GfCeVMHo@public.gmane.org>
Reviewed-by: Harry Wentland <Harry.Wentland-5C7GfCeVMHo@public.gmane.org>
---
 include/drm/drm_dp_helper.h | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/include/drm/drm_dp_helper.h b/include/drm/drm_dp_helper.h
index 8364502f92cf..5abed96a1cb1 100644
--- a/include/drm/drm_dp_helper.h
+++ b/include/drm/drm_dp_helper.h
@@ -966,6 +966,31 @@
 #define DP_HDCP_2_2_REG_STREAM_TYPE_OFFSET	0x69494
 #define DP_HDCP_2_2_REG_DBG_OFFSET		0x69518
=20
+/* Link Training (LT)-tunable Physical Repeaters - DP 1.4a */
+#define DP_LT_TUNABLE_PHY_REPEATER_FIELD_DATA_STRUCTURE_REV	0xf0000
+#define DP_MAX_LINK_RATE_PHY_REPEATER				0xf0001
+#define DP_PHY_REPEATER_CNT					0xf0002
+#define DP_PHY_REPEATER_MODE					0xf0003
+#define DP_MAX_LANE_COUNT_PHY_REPEATER				0xf0004
+#define DP_PHY_REPEATER_EXTENDED_WAIT_TIMEOUT			0xf0005
+#define DP_TRAINING_PATTERN_SET_PHY_REPEATER1			0xf0010
+#define DP_TRAINING_LANE0_SET_PHY_REPEATER1			0xf0011
+#define DP_TRAINING_LANE1_SET_PHY_REPEATER1			0xf0012
+#define DP_TRAINING_LANE2_SET_PHY_REPEATER1			0xf0013
+#define DP_TRAINING_LANE3_SET_PHY_REPEATER1			0xf0014
+#define DP_TRAINING_AUX_RD_INTERVAL_PHY_REPEATER1		0xf0020
+#define DP_TRANSMITTER_CAPABILITY_PHY_REPEATER1			0xf0021
+#define DP_LANE0_1_STATUS_PHY_REPEATER1				0xf0030
+#define DP_LANE2_3_STATUS_PHY_REPEATER1				0xf0031
+#define DP_LANE_ALIGN_STATUS_UPDATED_PHY_REPEATER1		0xf0032
+#define DP_ADJUST_REQUEST_LANE0_1_PHY_REPEATER1			0xf0033
+#define DP_ADJUST_REQUEST_LANE2_3_PHY_REPEATER1			0xf0034
+#define DP_SYMBOL_ERROR_COUNT_LANE0_PHY_REPEATER1		0xf0035
+#define DP_SYMBOL_ERROR_COUNT_LANE1_PHY_REPEATER1		0xf0037
+#define DP_SYMBOL_ERROR_COUNT_LANE2_PHY_REPEATER1		0xf0039
+#define DP_SYMBOL_ERROR_COUNT_LANE3_PHY_REPEATER1		0xf003b
+#define DP_FEC_STATUS_PHY_REPEATER1				0xf0290
+
 /* DP HDCP message start offsets in DPCD address space */
 #define DP_HDCP_2_2_AKE_INIT_OFFSET		DP_HDCP_2_2_REG_RTX_OFFSET
 #define DP_HDCP_2_2_AKE_SEND_CERT_OFFSET	DP_HDCP_2_2_REG_CERT_RX_OFFSET
--=20
2.23.0

--mxdoj3tukgzujy23
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE4tZ+ii1mjMCMQbfkWJzP/comvP8FAl1wCfwACgkQWJzP/com
vP9+Lg/+L5NfIqhhYrkraYXDvRGx4gaAEusVOCt0YD/c+StlaR5WUBkdEeMO6UBP
8T7NBxALJS6w29EwPU704eTXM/8E4ehMqOFiByFZ/sG5Yni7ovaWyoHLh/GMlMH/
LDd0hZD/x68deIJccoG6yfcmn8kBlhKfoYG+CzZPZgDlW5sln/1WGyM47K4qiBES
SoVq6NSDptCmdQNdp+3IAzQpD7QGkE0Zf7ebIADFRv0H0fJDUpJNH3vxBz4H3MkD
zcvhh4rt/uvFXu0umqQSnYs+5D969thb4GBmwWSqSiV0NcvO8BhQnQcTLE3XvI8/
iMyxWrRMkKhNeaeenGCTIOGrP0pmeV0OPGtDCXzsV/LtFre149vdEwTlMysUUIj5
5OXp+vdnu7AUJfQWzTVSKIgZhDaG6rJrj0EJbjDE8bObW30GGz01WPCbVcfUX3wJ
8zWs+o5cqMmgb9Ml6TpsI8UcB4GgxWcSxWC4x5tkIOpnLkK7mevZkh/h9H5v+B7W
9XVUBjVGss96EtIMHS8FiKWNRkFSpWX6cGOCKXCFXCpG22TAjcrshvhCcws/BRlS
PL52oKGTrj402+uoG4mrVE9fWdvcECyNsYjONvY+xOiwj1yFTT23NVAKMSOe9+OM
2pYzDsW/BmzIQL8MM8E0Tdav0157mWq/hiz81wg6k1Tt4BiqZzQ=
=2Svr
-----END PGP SIGNATURE-----

--mxdoj3tukgzujy23--

--===============1863908483==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4

--===============1863908483==--
