From: "Siqueira, Rodrigo" <Rodrigo.Siqueira-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH V3] drm: Add LTTPR defines for DP 1.4a
Date: Wed, 28 Aug 2019 19:52:37 +0000
Message-ID: <20190828195243.w6mq7gdv22ggums7@outlook.office365.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0395218578=="
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
 Harry" <Harry.Wentland-5C7GfCeVMHo@public.gmane.org>, Jani Nikula <jani.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>

--===============0395218578==
Content-Language: en-US
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ro3nrwqvskbcp3f7"

--ro3nrwqvskbcp3f7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

DP 1.4a specification defines Link Training Tunable PHY Repeater (LTTPR)
which is required to add support for systems with Thunderbolt or other
repeater devices.

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
Signed-off-by: Rodrigo Siqueira <Rodrigo.Siqueira-5C7GfCeVMHo@public.gmane.org>
Signed-off-by: Abdoulaye Berthe <Abdoulaye.Berthe-5C7GfCeVMHo@public.gmane.org>
---
 include/drm/drm_dp_helper.h | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/include/drm/drm_dp_helper.h b/include/drm/drm_dp_helper.h
index 8364502f92cf..67f9121d781d 100644
--- a/include/drm/drm_dp_helper.h
+++ b/include/drm/drm_dp_helper.h
@@ -989,6 +989,31 @@
 #define HDCP_2_2_DP_RXSTATUS_REAUTH_REQ(x)	((x) & BIT(3))
 #define HDCP_2_2_DP_RXSTATUS_LINK_FAILED(x)	((x) & BIT(4))
=20
+/* Link Training (LT)-tunable Physical Repeaters - DP 1.4a */
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
 /* DP 1.2 Sideband message defines */
 /* peer device type - DP 1.2a Table 2-92 */
 #define DP_PEER_DEVICE_NONE		0x0
--=20
2.23.0

--ro3nrwqvskbcp3f7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE4tZ+ii1mjMCMQbfkWJzP/comvP8FAl1m24sACgkQWJzP/com
vP/aoA/+LGE7FyxEQduYBR2iPb2SJJr315jEKVeI3GMmMAVpxlMAQnKGIoy4Ygsb
IDi8k2rlq1TSmAhvNKpU4OOTli9CsW+UVjKXJPYMko5bE3CHSoAh3RI5gocQrDnU
pRvKBCw6wtkhS3v8qooIChLLjRXPAMpBRfym5m92wOFyGOQMruW/rMzA+ydRAE7H
AzkfjykWDQsRfGI304t1TI4TF0x9o8EeV8xogwMEVSMvC08GhwGau2I/Z5PSBKoP
FThyQZwkADnHP3IxmEgKGWo+SkPouqcm2ZZPFAAmIa+7S8lFkvZRetfbVzf2pcLJ
K2sp8XexE9YVNXw7Fp00r/mM3Fa928Tils5I2fsTQJGz06Bo6TIiNV7l2Gc65/SX
BKrZxffyKRhGEMYrG3S3Y8uW1UA2wWgwTm6ehfs72S0vAam9dGfSLdMg36/ha2nh
ZMd8sie3++832LpuGWQ/1E4etsqNVFwIRaZMRp51HfQIqbw4PsmnC1DSCEpqvr6U
VVx7eD0aGhhnITZnLbLQ4XK3OTE+p1xf8HTdNS6lwXw9x4SC0PU8oQ/pPM/LbJU5
cviU8YtY10PTCI3GTHcXpzbiOsDR69FKrIHZQCOYyu4rzXP0ZbG/Mqt4bTRP/hoO
0GBtBuTZiRwDmH0aVnkh3fASTb2K0nWTWOrorvqMNt+Kh06K13A=
=JOmb
-----END PGP SIGNATURE-----

--ro3nrwqvskbcp3f7--

--===============0395218578==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4

--===============0395218578==--
