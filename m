From: "Siqueira, Rodrigo" <Rodrigo.Siqueira-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH V5] drm: Add link training repeaters addresses
Date: Mon, 9 Sep 2019 21:21:47 +0000
Message-ID: <20190909212144.deeomlsqihwg4l3y@outlook.office365.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0556773304=="
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
 Abdoulaye" <Abdoulaye.Berthe-5C7GfCeVMHo@public.gmane.org>, Jani Nikula <jani.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Manasi Navare <manasi.d.navare-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "Wentland,
 Harry" <Harry.Wentland-5C7GfCeVMHo@public.gmane.org>, =?iso-8859-1?Q?Ville_Syrj=E4l=E4?= <ville.syrjala-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>

--===============0556773304==
Content-Language: en-US
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="vtwh2agsnzqxqrsu"

--vtwh2agsnzqxqrsu
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

DP 1.3 specification introduces the Link Training-tunable PHY Repeater,
and DP 1.4* supplemented it with new features. In the 1.4a spec, it was
introduced some innovations to make handy to add support for systems
with Thunderbolt or other repeater devices.

It is important to highlight that DP specification had some updates from
1.3 through 1.4a. In particular, DP 1.4 defines Repeater_FEC_CAPABILITY
at the address 0xf0004, and DP 1.4a redefined the address 0xf0004 to
DP_MAX_LANE_COUNT_PHY_REPEATER.

Changes since V4:
- Update commit message
- Fix misleading comments related to the spec version
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
 include/drm/drm_dp_helper.h | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/include/drm/drm_dp_helper.h b/include/drm/drm_dp_helper.h
index 7972b925a952..fddcd84601f8 100644
--- a/include/drm/drm_dp_helper.h
+++ b/include/drm/drm_dp_helper.h
@@ -966,6 +966,32 @@
 #define DP_HDCP_2_2_REG_STREAM_TYPE_OFFSET	0x69494
 #define DP_HDCP_2_2_REG_DBG_OFFSET		0x69518
=20
+/* Link Training (LT)-tunable PHY Repeaters */
+#define DP_LT_TUNABLE_PHY_REPEATER_FIELD_DATA_STRUCTURE_REV 0xf0000 /* 1.3=
 */
+#define DP_MAX_LINK_RATE_PHY_REPEATER			    0xf0001 /* 1.4a */
+#define DP_PHY_REPEATER_CNT				    0xf0002 /* 1.3 */
+#define DP_PHY_REPEATER_MODE				    0xf0003 /* 1.3 */
+#define DP_MAX_LANE_COUNT_PHY_REPEATER			    0xf0004 /* 1.4a */
+#define DP_Repeater_FEC_CAPABILITY			    0xf0004 /* 1.4 */
+#define DP_PHY_REPEATER_EXTENDED_WAIT_TIMEOUT		    0xf0005 /* 1.4a */
+#define DP_TRAINING_PATTERN_SET_PHY_REPEATER1		    0xf0010 /* 1.3 */
+#define DP_TRAINING_LANE0_SET_PHY_REPEATER1		    0xf0011 /* 1.3 */
+#define DP_TRAINING_LANE1_SET_PHY_REPEATER1		    0xf0012 /* 1.3 */
+#define DP_TRAINING_LANE2_SET_PHY_REPEATER1		    0xf0013 /* 1.3 */
+#define DP_TRAINING_LANE3_SET_PHY_REPEATER1		    0xf0014 /* 1.3 */
+#define DP_TRAINING_AUX_RD_INTERVAL_PHY_REPEATER1	    0xf0020 /* 1.4a */
+#define DP_TRANSMITTER_CAPABILITY_PHY_REPEATER1		    0xf0021 /* 1.4a */
+#define DP_LANE0_1_STATUS_PHY_REPEATER1			    0xf0030 /* 1.3 */
+#define DP_LANE2_3_STATUS_PHY_REPEATER1			    0xf0031 /* 1.3 */
+#define DP_LANE_ALIGN_STATUS_UPDATED_PHY_REPEATER1	    0xf0032 /* 1.3 */
+#define DP_ADJUST_REQUEST_LANE0_1_PHY_REPEATER1		    0xf0033 /* 1.3 */
+#define DP_ADJUST_REQUEST_LANE2_3_PHY_REPEATER1		    0xf0034 /* 1.3 */
+#define DP_SYMBOL_ERROR_COUNT_LANE0_PHY_REPEATER1	    0xf0035 /* 1.3 */
+#define DP_SYMBOL_ERROR_COUNT_LANE1_PHY_REPEATER1	    0xf0037 /* 1.3 */
+#define DP_SYMBOL_ERROR_COUNT_LANE2_PHY_REPEATER1	    0xf0039 /* 1.3 */
+#define DP_SYMBOL_ERROR_COUNT_LANE3_PHY_REPEATER1	    0xf003b /* 1.3 */
+#define DP_FEC_STATUS_PHY_REPEATER1			    0xf0290 /* 1.4 */
+
 /* DP HDCP message start offsets in DPCD address space */
 #define DP_HDCP_2_2_AKE_INIT_OFFSET		DP_HDCP_2_2_REG_RTX_OFFSET
 #define DP_HDCP_2_2_AKE_SEND_CERT_OFFSET	DP_HDCP_2_2_REG_CERT_RX_OFFSET
--=20
2.23.0

--vtwh2agsnzqxqrsu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE4tZ+ii1mjMCMQbfkWJzP/comvP8FAl12wmgACgkQWJzP/com
vP+9+BAAzKClvJnIEjwkJgu53Fy8h79hXaH+6kBSa27PUDMRlZcXNw9TpZB0lC3m
2N86P6ZME92weGZ6fksyaVnaskGcm4Lj+CncKXx/FxkBDl0pXECFAWqJWrxHwE7B
dqUBjfuBfpdES1f4FvtHpOMJ7NBAswsXgZ6E0Sq9lrH+oGHodlGLX6VTfj8j3aLa
hg2dySOn5p5YRGRmHN6Y/1cr2whLWfkECNLPIy7ZBKAFN+GhgHrRDt8cxs0hnHNQ
CoAqVM+AlhP7wealasg9/UtQpNNSpVJFdGEVuOI/w7pIGbJlXpt0vO9tDC662DyR
nt5s5W88Y5xGarnCPpwSLAyoHCtZZX8bzHZCDTmG8URkxh1dQWoUwHZSAxp/bV/9
fA73z7rbKC9iBV6G/veu5biOQwQvuF96QpESpr/E4k5WeDYlfs31RvAYYMpyA15Q
ELEST70hbyNG+bEY3OQ9QKXZ5POimafgMQqK78IfmQ5THCCB8aADr4iPk1qzTpyS
VgoanbxRJBd2Ja28Kdxvdn0FJjvgQD3FyBjtdhLvA5NEkZw+Ub7Y7XpNDunPmNfL
LQzqgptyFtDNHYK3Bx1FP0/Ht0V8aPr7SNuHg3Zubrs7aLEkhU+8jQY0TvTqoqwG
NUZhHxcFogltXGQ6hCKkp9XGRrfrd++0S54V2yvXF/KSWnbf1is=
=g5Dr
-----END PGP SIGNATURE-----

--vtwh2agsnzqxqrsu--

--===============0556773304==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4

--===============0556773304==--
