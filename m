Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3610DC25B74
	for <amd-gfx@archiver.kernel.org>; Thu, 16 May 2024 19:27:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 56E2C10ED9A;
	Thu, 16 May 2024 19:27:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="CEFfm1xO";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2076.outbound.protection.outlook.com [40.107.220.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ACA3610E413
 for <amd-gfx@lists.freedesktop.org>; Thu, 16 May 2024 19:26:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BIjiHyaxxVY51Fwrl/sqINaGskef8ZrY3mImSv7z8Ga5Qo3/8Qbg4/S6HnijgXXrR5dfod47/JyglhA0czMTfYJjh2wjIYYY3CK5PGAcwV4BtLZgQO1H2X8TeycRSIA8ZhoqcatidmfIw2RKS8InxT0pnAkfrZx/KhokamkdFB9/jDztOnMMGB5hNJq4dL2fU+edxyRydx/vzyto0lyxcjPLTK7ohA2320JrXXJYbniLwMTyNyUa72cAiOGrBF/cQ1aSsEhArTebp9KFNBjorZJNTeE+O6U2X9CkF6gOUjNM4d5DR8HedPRZhDk088BVnSr6Gi+C7SR6uay3yivwVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MPtYXMtDTBF/u2FjvVrQ+i3FT7PC7ytAhSY20crcNXA=;
 b=YOdfGj98rAAPa5/PKCmvxbtqYUaS/6nSwvLPc+oj0akLz8lO7oNp1J5Dba/YueDbctkfUaPi5t9y2RAH+kZIGt7pMmHKzWWldAcdciptiSDc0evJy3stOuTNcMSnqcSYhfLe08WckUyvjPbcMnR/fGDTKTgCvuKw87ZvlIGI8Nv4wQeT//ZnrG4YzBLbFL42DiBy7s+Z7ax0lUzRv18xGworFuiZoDAeNnNdW74OP/nBrfgXqPJ0gc7n0DfUGiOnLXa1AjL5fgVp+vqPHxV1K3l8xkNiZRnd3HK0QKrj1NR+zpSowBIcqSw30TlO/XHMVHbWXbKmBbQTCXawghYZHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MPtYXMtDTBF/u2FjvVrQ+i3FT7PC7ytAhSY20crcNXA=;
 b=CEFfm1xOOt0WSXTH47LxK5v96Mdj6MWn3myJXWJjjA3oORA34on0pWCxf5oYJke1RL1Pr8Hw4puRfZB01oUqhl3S7shaYTJRkTGf/vC9F89HGDa52KzWaIKLyfSiQkb3Owqmluyh/JTiZ9cF1n3dJvrRpndcsuJwzkUkabM6gp4=
Received: from MN2PR06CA0006.namprd06.prod.outlook.com (2603:10b6:208:23d::11)
 by IA1PR12MB8407.namprd12.prod.outlook.com (2603:10b6:208:3d9::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.55; Thu, 16 May
 2024 19:26:55 +0000
Received: from BN2PEPF000044A9.namprd04.prod.outlook.com
 (2603:10b6:208:23d:cafe::be) by MN2PR06CA0006.outlook.office365.com
 (2603:10b6:208:23d::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.26 via Frontend
 Transport; Thu, 16 May 2024 19:26:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF000044A9.mail.protection.outlook.com (10.167.243.103) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7587.21 via Frontend Transport; Thu, 16 May 2024 19:26:55 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 16 May
 2024 14:26:55 -0500
Received: from roman-vdev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Thu, 16 May 2024 14:26:54 -0500
From: <Roman.Li@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <jerry.zuo@amd.com>, George Shen <george.shen@amd.com>, Wenjing Liu
 <wenjing.liu@amd.com>
Subject: [PATCH 01/24] drm/amd/display: Move DSC functions from dc.c to
 dc_dsc.c
Date: Thu, 16 May 2024 15:26:24 -0400
Message-ID: <20240516192647.1522729-2-Roman.Li@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240516192647.1522729-1-Roman.Li@amd.com>
References: <20240516192647.1522729-1-Roman.Li@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: Roman.Li@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A9:EE_|IA1PR12MB8407:EE_
X-MS-Office365-Filtering-Correlation-Id: 31ffb2c3-e4a9-4791-2632-08dc75de25a8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|1800799015|376005|36860700004|82310400017; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?FuuOkfG2epKVDUdiDoHB3BqfNntybs65+HDew+A5SjD21SmSE2Al5Ub1nx5v?=
 =?us-ascii?Q?/jAnAJEzyHvHFT5yVdMW0C9d3howaSOq1nr72YfxXYm7IBHsrnsveMAKzoJ3?=
 =?us-ascii?Q?lhPHFjARKkcyAxAPA49AeKdnTVlbv0mXWDX3c94VxTm8AohHmndXlZNdkgdz?=
 =?us-ascii?Q?6vmEMVxatyV0t1z3y6XiqhXGJWa0WR5yX9477kQ0ZHdaBXFWbas7tJr4uuQX?=
 =?us-ascii?Q?On2ZNqKWIuf2djsxH5793ZX7elEWvyZL7GCKrFu07R7koWJMh8eiGD/njxVX?=
 =?us-ascii?Q?Blrq+YhIRbwEp7alWiCslsH1btBmy7ELQRqjFClQICxL3FeJVghYmn1t1rI6?=
 =?us-ascii?Q?725VfMYvrSwsILiiINjU7dmdOsjep8rqeoRV9SdJMqZub7dAxr8HYXSI6jnG?=
 =?us-ascii?Q?WDfFnnfQm6wvcmgxdUZhQ6yJSDzkX3wwnHFcRve8WKFdtG9BWSsn4/53bhnM?=
 =?us-ascii?Q?9+iKbjiqIOQZsEj5iSQ4yCqsstraXTRXul/DE2iEVReo55pnmYBGLJ4ouS38?=
 =?us-ascii?Q?7qZtBDl9+DOghmSUIZryfy9PD/4XSuTnofvFtCuPQ4uNNCi3LWMVUwhB98Uf?=
 =?us-ascii?Q?r2Y8yT+d+Rteu8MNeMkwJniq+ectIV9zZOTU/z6o1/DrHAwo6LHfEBdcXa8a?=
 =?us-ascii?Q?ruQ9ICbvcb5U0WMfCrNipCGjPQR1Ifibf8fUVSnSIKPkdqY8b6Z0DnumMyqy?=
 =?us-ascii?Q?9fc6eBLXF3pHQDSmp9ISXFmDm8mVwVMnM8OX1lQ0Ersh3GToO9/ecgvPnVC/?=
 =?us-ascii?Q?Rz8yiJ3DS3ArziVb68gKDDn8f5gQGC8HoAFojsAqkhYm+mpbli9ZpNd7zE4W?=
 =?us-ascii?Q?MubmtZobBnEt5/m3HfLBRy8IuINMu8UTVBhV4IGub2awrjbLrX427L7MLmnu?=
 =?us-ascii?Q?7UXYma2pHSbtwYeORTLpkGra97ZN9/OjcjN6L7moM3FC+nAKvK8O+9HakG51?=
 =?us-ascii?Q?ivvbE4TEXvjljYxBQGEERWdYi1hsHiPln3ztfRElyeJfU7B/AocseYy/Ne4T?=
 =?us-ascii?Q?sCn3VATWbFZINZhatzeqkgaVAYP1VG0QaLAO9zm8W5SSzw7HSvA1id+DLA7o?=
 =?us-ascii?Q?4keCOHlYSxRQwZU+KlxkGuxlIg+CI1yYM0zAVjpwY54H+4qiMWYqqdVJ3OK6?=
 =?us-ascii?Q?nEBUUvfo1BWw9N5X9ZlgYuCP01+gjrxqHhAps5/BWOPQCsOVPJaJgdxiOfhd?=
 =?us-ascii?Q?dHzcYtGfnG06YMKL7H9a0EjZW0iaiTwqKQ4ZbYkNoEvZaK1u9sglT3xVwlSQ?=
 =?us-ascii?Q?Oo/jbjjSumPL7PGF1qzpnQ+0AsUE2CAthghN1zBv7/nxjjB1gpBpW7AZCcJc?=
 =?us-ascii?Q?r5b9fiRBw4d+CQKi0isGothdd+JHFDoEE0FcCodOgv1EkbL2qWJPv3ZGY5+0?=
 =?us-ascii?Q?1gtUkYk+ATa7Dl91rivP25r7uPju?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(1800799015)(376005)(36860700004)(82310400017); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2024 19:26:55.4265 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 31ffb2c3-e4a9-4791-2632-08dc75de25a8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000044A9.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8407
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: George Shen <george.shen@amd.com>

Move dsc functions from dc.c to dc_dsc.c.

Co-Developed-by: George Shen <george.shen@amd.com>
Signed-off-by: Wenjing Liu <wenjing.liu@amd.com>
Reviewed-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc.c    | 99 ---------------------
 drivers/gpu/drm/amd/display/dc/dsc/dc_dsc.c | 96 ++++++++++++++++++++
 2 files changed, 96 insertions(+), 99 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index 0208b28517ac..6f534c2e76b7 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -5979,102 +5979,3 @@ struct dc_power_profile dc_get_power_profile_for_dc_state(const struct dc_state
 
 	return profile;
 }
-
-/* Need to account for padding due to pixel-to-symbol packing
- * for uncompressed 128b/132b streams.
- */
-static uint32_t apply_128b_132b_stream_overhead(
-	const struct dc_crtc_timing *timing, const uint32_t kbps)
-{
-	uint32_t total_kbps = kbps;
-#if defined(CONFIG_DRM_AMD_DC_FP)
-	if (dc_get_disable_128b_132b_stream_overhead())
-		return kbps;
-#endif
-
-	if (!timing->flags.DSC) {
-		struct fixed31_32 bpp;
-		struct fixed31_32 overhead_factor;
-
-		bpp = dc_fixpt_from_int(kbps);
-		bpp = dc_fixpt_div_int(bpp, timing->pix_clk_100hz / 10);
-
-		/* Symbols_per_HActive = HActive * bpp / (4 lanes * 32-bit symbol size)
-		 * Overhead_factor = ceil(Symbols_per_HActive) / Symbols_per_HActive
-		 */
-		overhead_factor = dc_fixpt_from_int(timing->h_addressable);
-		overhead_factor = dc_fixpt_mul(overhead_factor, bpp);
-		overhead_factor = dc_fixpt_div_int(overhead_factor, 128);
-		overhead_factor = dc_fixpt_div(
-			dc_fixpt_from_int(dc_fixpt_ceil(overhead_factor)),
-			overhead_factor);
-
-		total_kbps = dc_fixpt_ceil(
-			dc_fixpt_mul_int(overhead_factor, total_kbps));
-	}
-
-	return total_kbps;
-}
-
-uint32_t dc_bandwidth_in_kbps_from_timing(
-	const struct dc_crtc_timing *timing,
-	const enum dc_link_encoding_format link_encoding)
-{
-	uint32_t bits_per_channel = 0;
-	uint32_t kbps;
-
-#if defined(CONFIG_DRM_AMD_DC_FP)
-	if (timing->flags.DSC)
-		return dc_dsc_stream_bandwidth_in_kbps(timing,
-				timing->dsc_cfg.bits_per_pixel,
-				timing->dsc_cfg.num_slices_h,
-				timing->dsc_cfg.is_dp);
-#endif
-
-	switch (timing->display_color_depth) {
-	case COLOR_DEPTH_666:
-		bits_per_channel = 6;
-		break;
-	case COLOR_DEPTH_888:
-		bits_per_channel = 8;
-		break;
-	case COLOR_DEPTH_101010:
-		bits_per_channel = 10;
-		break;
-	case COLOR_DEPTH_121212:
-		bits_per_channel = 12;
-		break;
-	case COLOR_DEPTH_141414:
-		bits_per_channel = 14;
-		break;
-	case COLOR_DEPTH_161616:
-		bits_per_channel = 16;
-		break;
-	default:
-		ASSERT(bits_per_channel != 0);
-		bits_per_channel = 8;
-		break;
-	}
-
-	kbps = timing->pix_clk_100hz / 10;
-	kbps *= bits_per_channel;
-
-	if (timing->flags.Y_ONLY != 1) {
-		/*Only YOnly make reduce bandwidth by 1/3 compares to RGB*/
-		kbps *= 3;
-		if (timing->pixel_encoding == PIXEL_ENCODING_YCBCR420)
-			kbps /= 2;
-		else if (timing->pixel_encoding == PIXEL_ENCODING_YCBCR422)
-			kbps = kbps * 2 / 3;
-	}
-
-	if (link_encoding == DC_LINK_ENCODING_DP_128b_132b)
-		kbps = apply_128b_132b_stream_overhead(timing, kbps);
-
-	if (link_encoding == DC_LINK_ENCODING_HDMI_FRL &&
-			timing->vic == 0 && timing->hdmi_vic == 0 &&
-			timing->frl_uncompressed_video_bandwidth_in_kbps != 0)
-		kbps = timing->frl_uncompressed_video_bandwidth_in_kbps;
-
-	return kbps;
-}
diff --git a/drivers/gpu/drm/amd/display/dc/dsc/dc_dsc.c b/drivers/gpu/drm/amd/display/dc/dsc/dc_dsc.c
index dd7091628b3c..b9d10e95ef7a 100644
--- a/drivers/gpu/drm/amd/display/dc/dsc/dc_dsc.c
+++ b/drivers/gpu/drm/amd/display/dc/dsc/dc_dsc.c
@@ -49,6 +49,102 @@ static bool disable_128b_132b_stream_overhead;
 #define MIN(X, Y) ((X) < (Y) ? (X) : (Y))
 #endif
 
+/* Need to account for padding due to pixel-to-symbol packing
+ * for uncompressed 128b/132b streams.
+ */
+static uint32_t apply_128b_132b_stream_overhead(
+	const struct dc_crtc_timing *timing, const uint32_t kbps)
+{
+	uint32_t total_kbps = kbps;
+
+	if (disable_128b_132b_stream_overhead)
+		return kbps;
+
+	if (!timing->flags.DSC) {
+		struct fixed31_32 bpp;
+		struct fixed31_32 overhead_factor;
+
+		bpp = dc_fixpt_from_int(kbps);
+		bpp = dc_fixpt_div_int(bpp, timing->pix_clk_100hz / 10);
+
+		/* Symbols_per_HActive = HActive * bpp / (4 lanes * 32-bit symbol size)
+		 * Overhead_factor = ceil(Symbols_per_HActive) / Symbols_per_HActive
+		 */
+		overhead_factor = dc_fixpt_from_int(timing->h_addressable);
+		overhead_factor = dc_fixpt_mul(overhead_factor, bpp);
+		overhead_factor = dc_fixpt_div_int(overhead_factor, 128);
+		overhead_factor = dc_fixpt_div(
+			dc_fixpt_from_int(dc_fixpt_ceil(overhead_factor)),
+			overhead_factor);
+
+		total_kbps = dc_fixpt_ceil(
+			dc_fixpt_mul_int(overhead_factor, total_kbps));
+	}
+
+	return total_kbps;
+}
+
+uint32_t dc_bandwidth_in_kbps_from_timing(
+	const struct dc_crtc_timing *timing,
+	const enum dc_link_encoding_format link_encoding)
+{
+	uint32_t bits_per_channel = 0;
+	uint32_t kbps;
+
+	if (timing->flags.DSC)
+		return dc_dsc_stream_bandwidth_in_kbps(timing,
+				timing->dsc_cfg.bits_per_pixel,
+				timing->dsc_cfg.num_slices_h,
+				timing->dsc_cfg.is_dp);
+
+	switch (timing->display_color_depth) {
+	case COLOR_DEPTH_666:
+		bits_per_channel = 6;
+		break;
+	case COLOR_DEPTH_888:
+		bits_per_channel = 8;
+		break;
+	case COLOR_DEPTH_101010:
+		bits_per_channel = 10;
+		break;
+	case COLOR_DEPTH_121212:
+		bits_per_channel = 12;
+		break;
+	case COLOR_DEPTH_141414:
+		bits_per_channel = 14;
+		break;
+	case COLOR_DEPTH_161616:
+		bits_per_channel = 16;
+		break;
+	default:
+		ASSERT(bits_per_channel != 0);
+		bits_per_channel = 8;
+		break;
+	}
+
+	kbps = timing->pix_clk_100hz / 10;
+	kbps *= bits_per_channel;
+
+	if (timing->flags.Y_ONLY != 1) {
+		/*Only YOnly make reduce bandwidth by 1/3 compares to RGB*/
+		kbps *= 3;
+		if (timing->pixel_encoding == PIXEL_ENCODING_YCBCR420)
+			kbps /= 2;
+		else if (timing->pixel_encoding == PIXEL_ENCODING_YCBCR422)
+			kbps = kbps * 2 / 3;
+	}
+
+	if (link_encoding == DC_LINK_ENCODING_DP_128b_132b)
+		kbps = apply_128b_132b_stream_overhead(timing, kbps);
+
+	if (link_encoding == DC_LINK_ENCODING_HDMI_FRL &&
+			timing->vic == 0 && timing->hdmi_vic == 0 &&
+			timing->frl_uncompressed_video_bandwidth_in_kbps != 0)
+		kbps = timing->frl_uncompressed_video_bandwidth_in_kbps;
+
+	return kbps;
+}
+
 /* Forward Declerations */
 static bool decide_dsc_bandwidth_range(
 		const uint32_t min_bpp_x16,
-- 
2.34.1

