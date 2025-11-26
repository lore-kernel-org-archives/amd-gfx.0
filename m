Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2659D111A7
	for <amd-gfx@archiver.kernel.org>; Wed, 26 Nov 2025 23:07:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7531E10E745;
	Wed, 26 Nov 2025 23:07:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="JD2ttXQd";
	dkim-atps=neutral
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010022.outbound.protection.outlook.com [52.101.61.22])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DCE1010E748
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 Nov 2025 23:06:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hQis8DGMCpUwHE2b652bAEe1MpSsKffjEeNCtUR9f2o1KvKe2YiBme4v2OAkrAsmZsHtZxeB4sRrK1sq/J1TbRHupYzUKhDpnT/lKp7em2VXqRopqjLLAFyxQX+JWcd1uTf6V6MNclJHZKZGUlp/g4g9O2hQl5+XBE/EyQ2fz79VVn3Dxk87OBO2vljlQwzWlNty5yPQr1aXMUu2UKHeWXP1WRd1iWmhhptcw5mp18zvlfJaPTb2VlMF8aWAM8CucFFl0+phDTUboDddzGnF5a4UtzPeaHApJx22KqUWGrAlXxTfDBDgzNuMnHHusG1pMHoU50XLSR9DN6qG17astQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XTr/qqmOLUTLr0PpVR4LWdTV/o0g2l9Zm9r8BPaS4gM=;
 b=R6eeozPWZpSap1oNXdsAXWC0Yr8uoVP1XYl7NsIzDJUYkX0bkL9LcyxHUWX/1d4JxtgerV2l6ou0PsaWqL2dRAJ0AvIKtvtXEYvKzaShFSKrM3s4itbkO/uOzeIerJYl1I+8xEeNh/wBuvrOGxXfX/3tuhG1sZ7pLIWVN2szCYjjjoPV4YCQET+OWXXeaF5HDcK3UEAYbtnjBNVgWZzAk15meFagSZHKekut2eWDbEv9a2wSl230TIWJVyTzKH7vy0FFi9aoM91Zdiz3AghKpdd61h5AkaLkWnzXEfADjbdqOx+mcbmojaGDbCYxy4wl12/McWSIszkVTltaoPLSAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XTr/qqmOLUTLr0PpVR4LWdTV/o0g2l9Zm9r8BPaS4gM=;
 b=JD2ttXQd3Nc5Leu34mDRUEartR470r4aVNEzXn8qBbt2rWGKv0aDnMbcDWu/OlEEZeVvpIKt1AL7l8fjnHvduW7LJizUAfrLVkCLwQLvfJVvPU8Hy4to5vHMzJQ5aIAX43la4z+33wIAwk5hs+7JEP8IBE6sGvEIJTR8PSJB8vs=
Received: from BL6PEPF00013DF9.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:22e:400:0:1001:0:c) by DS0PR12MB6416.namprd12.prod.outlook.com
 (2603:10b6:8:cb::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.11; Wed, 26 Nov
 2025 23:06:45 +0000
Received: from BL6PEPF00020E60.namprd04.prod.outlook.com
 (2a01:111:f403:f901::5) by BL6PEPF00013DF9.outlook.office365.com
 (2603:1036:903:4::4) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9343.10 via Frontend Transport; Wed,
 26 Nov 2025 23:06:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF00020E60.mail.protection.outlook.com (10.167.249.21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9366.7 via Frontend Transport; Wed, 26 Nov 2025 23:06:45 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Wed, 26 Nov
 2025 17:06:42 -0600
Received: from satlexmb08.amd.com (10.181.42.217) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 26 Nov
 2025 17:06:42 -0600
Received: from roman-vdev.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Wed, 26 Nov 2025 15:06:41 -0800
From: <Roman.Li@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, Navid Assadian <Navid.Assadian@amd.com>, Samson Tam
 <samson.tam@amd.com>
Subject: [PATCH 13/14] drm/amd/display - dc: Add configurable SPL namespace
 prefix
Date: Wed, 26 Nov 2025 18:06:13 -0500
Message-ID: <20251126230614.13409-14-Roman.Li@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251126230614.13409-1-Roman.Li@amd.com>
References: <20251126230614.13409-1-Roman.Li@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: Roman.Li@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E60:EE_|DS0PR12MB6416:EE_
X-MS-Office365-Filtering-Correlation-Id: 9f16adb0-e53f-4886-20e6-08de2d4078ab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?WmE3x77SNzT20gPn8bzwZrGWtpQzcaF3geEPP6hYDQR0Px27dwX/yvBFpAL6?=
 =?us-ascii?Q?kNIWVbHT69Dx2zGU1bvrm3HPr3Br6o3bFx/uqZgGs5obQTnz8W7COs1VwRQj?=
 =?us-ascii?Q?JrMr+JengOfAEKmwpHL3wyqhX0I1GxGqLYvMR2UuuDtdiCG0rwoF8g5Cykx2?=
 =?us-ascii?Q?eoBLYMGdc6q0YRGRZw7mj0Tc4dovQSOAitbsrrEgQRZcR5rsLxSokaM47fmZ?=
 =?us-ascii?Q?IEIseD9DlPcyoDHDcjt+KzafAbuQFo5uxkJoNr1kKGCxEpksBucFis4QXCQj?=
 =?us-ascii?Q?XR2+wf+VXkcGpsJeturexHgv2lcE9IIXivv56diALqQ/RIMs+m449TflzCmj?=
 =?us-ascii?Q?BxLFX3OUNDEbxyKH+uWtd9xC+WiZWFjXUE6E0SbzJwt1qCxysm0bgwFQXJa5?=
 =?us-ascii?Q?4Z/xl9lsFPblg4U6S9pgp4Z2BHSobBQqYu4DL051piV3wZ0cKEuCzGC8szn5?=
 =?us-ascii?Q?LBTyntzKT7Od02WKT/H3ZTluW+7vtt9GYBmReoUPTibNWlEuJLJPVcV7PeRX?=
 =?us-ascii?Q?Ku3+574Aq56vsyCyGh89PA97xMK8JvQcZ48WQ2p6ezXfzIwNnJJz8rvIi5pE?=
 =?us-ascii?Q?Cn142XPytmJsRx7XbdgDUAFuCJPnexEAGSZgbCBTP7XE9beFbnOhoUtlcwoy?=
 =?us-ascii?Q?5+l3hxI6JKMvQRsOslDMQwitTlZi09MPu+0pmfQcveanwOS4JP06o4DWJZTF?=
 =?us-ascii?Q?xA6M5+cIXeyRsk9nqZkiaaD9EPzILrZOYdhOSkX2+rLv2ddyW9xilIhg7zqv?=
 =?us-ascii?Q?gGtWk0QveD8kmRJu0xOEAFaeySFaVRsSwrb++pIv5MdJqGLKjQHAOseMTtEk?=
 =?us-ascii?Q?lryYVYKMK6OWJJeIvksjERUgPwHjFpgDRFrY3tvR+GwRoaBiaCOeAx1Z8L+B?=
 =?us-ascii?Q?SLhzY7L72vtv5Rr03SW2JdS8SnWBLczkZ8ysRKFbhSLpLIfgj0RPf3qc3seH?=
 =?us-ascii?Q?yyb/wATx5VCKTl1e+SZCk5y33JJOuL47LZFyWn4q+Iez2C1dCkupco5xza2X?=
 =?us-ascii?Q?V7lEXJuyk2TGuPZZGt0L8027RNUuRl5hPCk5Xl7u5kpDVa/HROedAuPf9sbB?=
 =?us-ascii?Q?w0aGloVoE1b3NPfcPXViPv+LeDjgsuRBsIAe48D7BvHdoqihPkBA0NgX0FzP?=
 =?us-ascii?Q?/m2W4tOOhCPWn7Ivn1FJdYumHxrGVjOldaKQ+Nzfv4+gf/1Fl1+pfcsaRWa8?=
 =?us-ascii?Q?rVZJCMUNabEE+82iN/ZHmBLiBIAn7EeBWKzskuUpCg9Qon3QWwHc6p0VHeFY?=
 =?us-ascii?Q?UoR47f4c2xeiF9eJBrYepMuwHU0BxnrZOdlli+y0C1BB3vGkEun+u9RSQ1WA?=
 =?us-ascii?Q?+sOglnh4o2bGdOMtKSiaBpSryOHfvcYCSKwavimjjaTCEQLtFMVtFRN7P6Ec?=
 =?us-ascii?Q?s+kagHtIcVx5hfDZYmxtXdwxrP+AFY0MvNxGdXqOE4YjY3nEcNYrCNXQT87S?=
 =?us-ascii?Q?sZTZDwmohrJWLOkILZLok/ts57n/V1nfBo5SkjEiMnwWPWAeGWJCPNLY3myD?=
 =?us-ascii?Q?XRjUNcorzPF/itB032T32W/20jLXuQw1hsIWiMtHrDBzlHQPaZGXdjJtyp4a?=
 =?us-ascii?Q?fzHHa6jaLYITj6EdRCw=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2025 23:06:45.8456 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f16adb0-e53f-4886-20e6-08de2d4078ab
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF00020E60.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6416
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

From: Navid Assadian <Navid.Assadian@amd.com>

[WHY]
SPL is a shared library that is used both in kernel and userspace.
When multiple libraries use SPL as statically linked, namespace
collision occur.

[HOW]
Create a configurable namespace prefix.
Add the prefix to all the public functions of the library to
distinguish between the SPL functions in each library.

Reviewed-by: Samson Tam <samson.tam@amd.com>
Signed-off-by: Navid Assadian <Navid.Assadian@amd.com>
---
 drivers/gpu/drm/amd/display/dc/sspl/dc_spl.c  | 186 +++++++++---------
 drivers/gpu/drm/amd/display/dc/sspl/dc_spl.h  |   8 -
 .../drm/amd/display/dc/sspl/dc_spl_filters.c  |   4 +-
 .../drm/amd/display/dc/sspl/dc_spl_filters.h  |   4 +-
 .../display/dc/sspl/dc_spl_isharp_filters.c   |  31 +--
 .../display/dc/sspl/dc_spl_isharp_filters.h   |  16 +-
 .../display/dc/sspl/dc_spl_scl_easf_filters.c | 155 ++++++++-------
 .../display/dc/sspl/dc_spl_scl_easf_filters.h |  37 ++--
 .../amd/display/dc/sspl/dc_spl_scl_filters.c  |  27 +--
 .../amd/display/dc/sspl/dc_spl_scl_filters.h  |   3 +-
 .../amd/display/dc/sspl/spl_custom_float.c    |  11 +-
 .../amd/display/dc/sspl/spl_custom_float.h    |   4 +-
 .../drm/amd/display/dc/sspl/spl_fixpt31_32.c  |  78 ++++----
 .../drm/amd/display/dc/sspl/spl_fixpt31_32.h  |  56 +++---
 .../drm/amd/display/dc/sspl/spl_os_types.h    |   9 +
 15 files changed, 328 insertions(+), 301 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/sspl/dc_spl.c b/drivers/gpu/drm/amd/display/dc/sspl/dc_spl.c
index 7a839984dbc0..f506ab70a307 100644
--- a/drivers/gpu/drm/amd/display/dc/sspl/dc_spl.c
+++ b/drivers/gpu/drm/amd/display/dc/sspl/dc_spl.c
@@ -7,7 +7,7 @@
 #include "dc_spl_isharp_filters.h"
 #include "spl_debug.h"
 
-#define IDENTITY_RATIO(ratio) (spl_fixpt_u3d19(ratio) == (1 << 19))
+#define IDENTITY_RATIO(ratio) (SPL_NAMESPACE(spl_fixpt_u3d19(ratio)) == (1 << 19))
 #define MIN_VIEWPORT_SIZE 12
 
 static bool spl_is_yuv420(enum spl_pixel_format format)
@@ -161,22 +161,24 @@ static struct spl_rect calculate_plane_rec_in_timing_active(
 	struct spl_fixed31_32 temp;
 
 
-	temp = spl_fixpt_from_fraction(rec_in->x * (long long)stream_dst->width,
-			stream_src->width);
+	temp = SPL_NAMESPACE(spl_fixpt_from_fraction(
+			rec_in->x * (long long)stream_dst->width,
+			stream_src->width));
 	rec_out.x = stream_dst->x + spl_fixpt_round(temp);
 
-	temp = spl_fixpt_from_fraction(
+	temp = SPL_NAMESPACE(spl_fixpt_from_fraction(
 			(rec_in->x + rec_in->width) * (long long)stream_dst->width,
-			stream_src->width);
+			stream_src->width));
 	rec_out.width = stream_dst->x + spl_fixpt_round(temp) - rec_out.x;
 
-	temp = spl_fixpt_from_fraction(rec_in->y * (long long)stream_dst->height,
-			stream_src->height);
+	temp = SPL_NAMESPACE(spl_fixpt_from_fraction(
+			rec_in->y * (long long)stream_dst->height,
+			stream_src->height));
 	rec_out.y = stream_dst->y + spl_fixpt_round(temp);
 
-	temp = spl_fixpt_from_fraction(
+	temp = SPL_NAMESPACE(spl_fixpt_from_fraction(
 			(rec_in->y + rec_in->height) * (long long)stream_dst->height,
-			stream_src->height);
+			stream_src->height));
 	rec_out.height = stream_dst->y + spl_fixpt_round(temp) - rec_out.y;
 
 	return rec_out;
@@ -442,12 +444,12 @@ static void spl_calculate_scaling_ratios(struct spl_in *spl_in,
 		spl_in->basic_in.rotation == SPL_ROTATION_ANGLE_270)
 		spl_swap(surf_src.height, surf_src.width);
 
-	spl_scratch->scl_data.ratios.horz = spl_fixpt_from_fraction(
+	spl_scratch->scl_data.ratios.horz = SPL_NAMESPACE(spl_fixpt_from_fraction(
 					surf_src.width,
-					spl_in->basic_in.dst_rect.width);
-	spl_scratch->scl_data.ratios.vert = spl_fixpt_from_fraction(
+					spl_in->basic_in.dst_rect.width));
+	spl_scratch->scl_data.ratios.vert = SPL_NAMESPACE(spl_fixpt_from_fraction(
 					surf_src.height,
-					spl_in->basic_in.dst_rect.height);
+					spl_in->basic_in.dst_rect.height));
 
 	if (spl_in->basic_out.view_format == SPL_VIEW_3D_SIDE_BY_SIDE)
 		spl_scratch->scl_data.ratios.horz.value *= 2;
@@ -480,14 +482,14 @@ static void spl_calculate_scaling_ratios(struct spl_in *spl_in,
 	 * that is output/input.  Currently we calculate input/output
 	 * Store 1/ratio in recip_ratio for those lookups
 	 */
-	spl_scratch->scl_data.recip_ratios.horz = spl_fixpt_recip(
-			spl_scratch->scl_data.ratios.horz);
-	spl_scratch->scl_data.recip_ratios.vert = spl_fixpt_recip(
-			spl_scratch->scl_data.ratios.vert);
-	spl_scratch->scl_data.recip_ratios.horz_c = spl_fixpt_recip(
-			spl_scratch->scl_data.ratios.horz_c);
-	spl_scratch->scl_data.recip_ratios.vert_c = spl_fixpt_recip(
-			spl_scratch->scl_data.ratios.vert_c);
+	spl_scratch->scl_data.recip_ratios.horz = SPL_NAMESPACE(spl_fixpt_recip(
+			spl_scratch->scl_data.ratios.horz));
+	spl_scratch->scl_data.recip_ratios.vert = SPL_NAMESPACE(spl_fixpt_recip(
+			spl_scratch->scl_data.ratios.vert));
+	spl_scratch->scl_data.recip_ratios.horz_c = SPL_NAMESPACE(spl_fixpt_recip(
+			spl_scratch->scl_data.ratios.horz_c));
+	spl_scratch->scl_data.recip_ratios.vert_c = SPL_NAMESPACE(spl_fixpt_recip(
+			spl_scratch->scl_data.ratios.vert_c));
 }
 
 /* Calculate Viewport size */
@@ -646,11 +648,11 @@ static void spl_calculate_inits_and_viewports(struct spl_in *spl_in,
 
 		switch (spl_in->basic_in.cositing) {
 		case CHROMA_COSITING_TOPLEFT:
-			init_adj_h = spl_fixpt_from_fraction(h_sign, 4);
-			init_adj_v = spl_fixpt_from_fraction(v_sign, 4);
+			init_adj_h = SPL_NAMESPACE(spl_fixpt_from_fraction(h_sign, 4));
+			init_adj_v = SPL_NAMESPACE(spl_fixpt_from_fraction(v_sign, 4));
 			break;
 		case CHROMA_COSITING_LEFT:
-			init_adj_h = spl_fixpt_from_fraction(h_sign, 4);
+			init_adj_h = SPL_NAMESPACE(spl_fixpt_from_fraction(h_sign, 4));
 			init_adj_v = spl_fixpt_zero;
 			break;
 		case CHROMA_COSITING_NONE:
@@ -939,16 +941,16 @@ static void spl_get_taps_non_adaptive_scaler(
 	 * Max downscale supported is 6.0x.  Add ASSERT to catch if go beyond that
 	 */
 	check_max_downscale = spl_fixpt_le(spl_scratch->scl_data.ratios.horz,
-		spl_fixpt_from_fraction(6, 1));
+		SPL_NAMESPACE(spl_fixpt_from_fraction(6, 1)));
 	SPL_ASSERT(check_max_downscale);
 	check_max_downscale = spl_fixpt_le(spl_scratch->scl_data.ratios.vert,
-		spl_fixpt_from_fraction(6, 1));
+		SPL_NAMESPACE(spl_fixpt_from_fraction(6, 1)));
 	SPL_ASSERT(check_max_downscale);
 	check_max_downscale = spl_fixpt_le(spl_scratch->scl_data.ratios.horz_c,
-		spl_fixpt_from_fraction(6, 1));
+		SPL_NAMESPACE(spl_fixpt_from_fraction(6, 1)));
 	SPL_ASSERT(check_max_downscale);
 	check_max_downscale = spl_fixpt_le(spl_scratch->scl_data.ratios.vert_c,
-		spl_fixpt_from_fraction(6, 1));
+		SPL_NAMESPACE(spl_fixpt_from_fraction(6, 1)));
 	SPL_ASSERT(check_max_downscale);
 
 
@@ -1194,35 +1196,39 @@ static void spl_set_manual_ratio_init_data(struct dscl_prog_data *dscl_prog_data
 {
 	struct spl_fixed31_32 bot;
 
-	dscl_prog_data->ratios.h_scale_ratio = spl_fixpt_u3d19(scl_data->ratios.horz) << 5;
-	dscl_prog_data->ratios.v_scale_ratio = spl_fixpt_u3d19(scl_data->ratios.vert) << 5;
-	dscl_prog_data->ratios.h_scale_ratio_c = spl_fixpt_u3d19(scl_data->ratios.horz_c) << 5;
-	dscl_prog_data->ratios.v_scale_ratio_c = spl_fixpt_u3d19(scl_data->ratios.vert_c) << 5;
+	dscl_prog_data->ratios.h_scale_ratio = SPL_NAMESPACE(spl_fixpt_u3d19(
+			scl_data->ratios.horz)) << 5;
+	dscl_prog_data->ratios.v_scale_ratio = SPL_NAMESPACE(spl_fixpt_u3d19(
+			scl_data->ratios.vert)) << 5;
+	dscl_prog_data->ratios.h_scale_ratio_c = SPL_NAMESPACE(spl_fixpt_u3d19(
+			scl_data->ratios.horz_c)) << 5;
+	dscl_prog_data->ratios.v_scale_ratio_c = SPL_NAMESPACE(spl_fixpt_u3d19(
+			scl_data->ratios.vert_c)) << 5;
 	/*
 	 * 0.24 format for fraction, first five bits zeroed
 	 */
 	dscl_prog_data->init.h_filter_init_frac =
-			spl_fixpt_u0d19(scl_data->inits.h) << 5;
+			SPL_NAMESPACE(spl_fixpt_u0d19(scl_data->inits.h)) << 5;
 	dscl_prog_data->init.h_filter_init_int =
 			spl_fixpt_floor(scl_data->inits.h);
 	dscl_prog_data->init.h_filter_init_frac_c =
-			spl_fixpt_u0d19(scl_data->inits.h_c) << 5;
+			SPL_NAMESPACE(spl_fixpt_u0d19(scl_data->inits.h_c)) << 5;
 	dscl_prog_data->init.h_filter_init_int_c =
 			spl_fixpt_floor(scl_data->inits.h_c);
 	dscl_prog_data->init.v_filter_init_frac =
-			spl_fixpt_u0d19(scl_data->inits.v) << 5;
+			SPL_NAMESPACE(spl_fixpt_u0d19(scl_data->inits.v)) << 5;
 	dscl_prog_data->init.v_filter_init_int =
 			spl_fixpt_floor(scl_data->inits.v);
 	dscl_prog_data->init.v_filter_init_frac_c =
-			spl_fixpt_u0d19(scl_data->inits.v_c) << 5;
+			SPL_NAMESPACE(spl_fixpt_u0d19(scl_data->inits.v_c)) << 5;
 	dscl_prog_data->init.v_filter_init_int_c =
 			spl_fixpt_floor(scl_data->inits.v_c);
 
 	bot = spl_fixpt_add(scl_data->inits.v, scl_data->ratios.vert);
-	dscl_prog_data->init.v_filter_init_bot_frac = spl_fixpt_u0d19(bot) << 5;
+	dscl_prog_data->init.v_filter_init_bot_frac = SPL_NAMESPACE(spl_fixpt_u0d19(bot)) << 5;
 	dscl_prog_data->init.v_filter_init_bot_int = spl_fixpt_floor(bot);
 	bot = spl_fixpt_add(scl_data->inits.v_c, scl_data->ratios.vert_c);
-	dscl_prog_data->init.v_filter_init_bot_frac_c = spl_fixpt_u0d19(bot) << 5;
+	dscl_prog_data->init.v_filter_init_bot_frac_c = SPL_NAMESPACE(spl_fixpt_u0d19(bot)) << 5;
 	dscl_prog_data->init.v_filter_init_bot_int_c = spl_fixpt_floor(bot);
 }
 
@@ -1270,7 +1276,7 @@ static void spl_set_dscl_prog_data(struct spl_in *spl_in, struct spl_scratch *sp
 	// Set viewport_c
 	dscl_prog_data->viewport_c = spl_scratch->scl_data.viewport_c;
 	// Set filters data
-	spl_set_filters_data(dscl_prog_data, data, enable_easf_v, enable_easf_h);
+	SPL_NAMESPACE(spl_set_filters_data(dscl_prog_data, data, enable_easf_v, enable_easf_h));
 }
 
 /* Calculate C0-C3 coefficients based on HDR_mult */
@@ -1286,28 +1292,31 @@ static void spl_calculate_c0_c3_hdr(struct dscl_prog_data *dscl_prog_data, uint3
 	else
 		hdr_multx100_int = 100; /* default for 80 nits otherwise */
 
-	hdr_mult = spl_fixpt_from_fraction((long long)hdr_multx100_int, 100LL);
-	c0_mult = spl_fixpt_from_fraction(2126LL, 10000LL);
-	c1_mult = spl_fixpt_from_fraction(7152LL, 10000LL);
-	c2_mult = spl_fixpt_from_fraction(722LL, 10000LL);
+	hdr_mult = SPL_NAMESPACE(spl_fixpt_from_fraction((long long)hdr_multx100_int, 100LL));
+	c0_mult = SPL_NAMESPACE(spl_fixpt_from_fraction(2126LL, 10000LL));
+	c1_mult = SPL_NAMESPACE(spl_fixpt_from_fraction(7152LL, 10000LL));
+	c2_mult = SPL_NAMESPACE(spl_fixpt_from_fraction(722LL, 10000LL));
 
-	c0_calc = spl_fixpt_mul(hdr_mult, spl_fixpt_mul(c0_mult, spl_fixpt_from_fraction(
-		16384LL, 125LL)));
-	c1_calc = spl_fixpt_mul(hdr_mult, spl_fixpt_mul(c1_mult, spl_fixpt_from_fraction(
-		16384LL, 125LL)));
-	c2_calc = spl_fixpt_mul(hdr_mult, spl_fixpt_mul(c2_mult, spl_fixpt_from_fraction(
-		16384LL, 125LL)));
+	c0_calc = SPL_NAMESPACE(spl_fixpt_mul(hdr_mult, SPL_NAMESPACE(spl_fixpt_mul(c0_mult,
+		SPL_NAMESPACE(spl_fixpt_from_fraction(16384LL, 125LL))))));
+	c1_calc = SPL_NAMESPACE(spl_fixpt_mul(hdr_mult, SPL_NAMESPACE(spl_fixpt_mul(c1_mult,
+		SPL_NAMESPACE(spl_fixpt_from_fraction(16384LL, 125LL))))));
+	c2_calc = SPL_NAMESPACE(spl_fixpt_mul(hdr_mult, SPL_NAMESPACE(spl_fixpt_mul(c2_mult,
+		SPL_NAMESPACE(spl_fixpt_from_fraction(16384LL, 125LL))))));
 
 	fmt.exponenta_bits = 5;
 	fmt.mantissa_bits = 10;
 	fmt.sign = true;
 
 	// fp1.5.10, C0 coefficient (LN_rec709:  HDR_MULT * 0.212600 * 2^14/125)
-	spl_convert_to_custom_float_format(c0_calc, &fmt, &dscl_prog_data->easf_matrix_c0);
+	SPL_NAMESPACE(spl_convert_to_custom_float_format(c0_calc, &fmt,
+		&dscl_prog_data->easf_matrix_c0));
 	// fp1.5.10, C1 coefficient (LN_rec709:  HDR_MULT * 0.715200 * 2^14/125)
-	spl_convert_to_custom_float_format(c1_calc, &fmt, &dscl_prog_data->easf_matrix_c1);
+	SPL_NAMESPACE(spl_convert_to_custom_float_format(c1_calc, &fmt,
+		&dscl_prog_data->easf_matrix_c1));
 	// fp1.5.10, C2 coefficient (LN_rec709:  HDR_MULT * 0.072200 * 2^14/125)
-	spl_convert_to_custom_float_format(c2_calc, &fmt, &dscl_prog_data->easf_matrix_c2);
+	SPL_NAMESPACE(spl_convert_to_custom_float_format(c2_calc, &fmt,
+		&dscl_prog_data->easf_matrix_c2));
 	dscl_prog_data->easf_matrix_c3 = 0x0; // fp1.5.10, C3 coefficient
 }
 
@@ -1325,48 +1334,48 @@ static void spl_set_easf_data(struct spl_scratch *spl_scratch, struct spl_out *s
 		dscl_prog_data->easf_v_bf1_en = 1;	// 1-bit, BF1 calculation enable, 0=disable, 1=enable
 		dscl_prog_data->easf_v_bf2_mode = 0xF;	// 4-bit, BF2 calculation mode
 		/* 2-bit, BF3 chroma mode correction calculation mode */
-		dscl_prog_data->easf_v_bf3_mode = spl_get_v_bf3_mode(
-			spl_scratch->scl_data.recip_ratios.vert);
+		dscl_prog_data->easf_v_bf3_mode = SPL_NAMESPACE(spl_get_v_bf3_mode(
+			spl_scratch->scl_data.recip_ratios.vert));
 		/* FP1.5.10 [ minCoef ]*/
 		dscl_prog_data->easf_v_ringest_3tap_dntilt_uptilt =
-			spl_get_3tap_dntilt_uptilt_offset(spl_scratch->scl_data.taps.v_taps,
-				spl_scratch->scl_data.recip_ratios.vert);
+			SPL_NAMESPACE(spl_get_3tap_dntilt_uptilt_offset(spl_scratch->scl_data.taps.v_taps,
+				spl_scratch->scl_data.recip_ratios.vert));
 		/* FP1.5.10 [ upTiltMaxVal ]*/
 		dscl_prog_data->easf_v_ringest_3tap_uptilt_max =
-			spl_get_3tap_uptilt_maxval(spl_scratch->scl_data.taps.v_taps,
-				spl_scratch->scl_data.recip_ratios.vert);
+			SPL_NAMESPACE(spl_get_3tap_uptilt_maxval(spl_scratch->scl_data.taps.v_taps,
+				spl_scratch->scl_data.recip_ratios.vert));
 		/* FP1.5.10 [ dnTiltSlope ]*/
 		dscl_prog_data->easf_v_ringest_3tap_dntilt_slope =
-			spl_get_3tap_dntilt_slope(spl_scratch->scl_data.taps.v_taps,
-				spl_scratch->scl_data.recip_ratios.vert);
+			SPL_NAMESPACE(spl_get_3tap_dntilt_slope(spl_scratch->scl_data.taps.v_taps,
+				spl_scratch->scl_data.recip_ratios.vert));
 		/* FP1.5.10 [ upTilt1Slope ]*/
 		dscl_prog_data->easf_v_ringest_3tap_uptilt1_slope =
-			spl_get_3tap_uptilt1_slope(spl_scratch->scl_data.taps.v_taps,
-				spl_scratch->scl_data.recip_ratios.vert);
+			SPL_NAMESPACE(spl_get_3tap_uptilt1_slope(spl_scratch->scl_data.taps.v_taps,
+				spl_scratch->scl_data.recip_ratios.vert));
 		/* FP1.5.10 [ upTilt2Slope ]*/
 		dscl_prog_data->easf_v_ringest_3tap_uptilt2_slope =
-			spl_get_3tap_uptilt2_slope(spl_scratch->scl_data.taps.v_taps,
-				spl_scratch->scl_data.recip_ratios.vert);
+			SPL_NAMESPACE(spl_get_3tap_uptilt2_slope(spl_scratch->scl_data.taps.v_taps,
+				spl_scratch->scl_data.recip_ratios.vert));
 		/* FP1.5.10 [ upTilt2Offset ]*/
 		dscl_prog_data->easf_v_ringest_3tap_uptilt2_offset =
-			spl_get_3tap_uptilt2_offset(spl_scratch->scl_data.taps.v_taps,
-				spl_scratch->scl_data.recip_ratios.vert);
+			SPL_NAMESPACE(spl_get_3tap_uptilt2_offset(spl_scratch->scl_data.taps.v_taps,
+				spl_scratch->scl_data.recip_ratios.vert));
 		/* FP1.5.10; (2.0) Ring reducer gain for 4 or 6-tap mode [H_REDUCER_GAIN4] */
 		dscl_prog_data->easf_v_ringest_eventap_reduceg1 =
-			spl_get_reducer_gain4(spl_scratch->scl_data.taps.v_taps,
-				spl_scratch->scl_data.recip_ratios.vert);
+			SPL_NAMESPACE(spl_get_reducer_gain4(spl_scratch->scl_data.taps.v_taps,
+				spl_scratch->scl_data.recip_ratios.vert));
 		/* FP1.5.10; (2.5) Ring reducer gain for 6-tap mode [V_REDUCER_GAIN6] */
 		dscl_prog_data->easf_v_ringest_eventap_reduceg2 =
-			spl_get_reducer_gain6(spl_scratch->scl_data.taps.v_taps,
-				spl_scratch->scl_data.recip_ratios.vert);
+			SPL_NAMESPACE(spl_get_reducer_gain6(spl_scratch->scl_data.taps.v_taps,
+				spl_scratch->scl_data.recip_ratios.vert));
 		/* FP1.5.10; (-0.135742) Ring gain for 6-tap set to -139/1024 */
 		dscl_prog_data->easf_v_ringest_eventap_gain1 =
-			spl_get_gainRing4(spl_scratch->scl_data.taps.v_taps,
-				spl_scratch->scl_data.recip_ratios.vert);
+			SPL_NAMESPACE(spl_get_gainRing4(spl_scratch->scl_data.taps.v_taps,
+				spl_scratch->scl_data.recip_ratios.vert));
 		/* FP1.5.10; (-0.024414) Ring gain for 6-tap set to -25/1024 */
 		dscl_prog_data->easf_v_ringest_eventap_gain2 =
-			spl_get_gainRing6(spl_scratch->scl_data.taps.v_taps,
-				spl_scratch->scl_data.recip_ratios.vert);
+			SPL_NAMESPACE(spl_get_gainRing6(spl_scratch->scl_data.taps.v_taps,
+				spl_scratch->scl_data.recip_ratios.vert));
 		dscl_prog_data->easf_v_bf_maxa = 63; //Vertical Max BF value A in U0.6 format.Selected if V_FCNTL == 0
 		dscl_prog_data->easf_v_bf_maxb = 63; //Vertical Max BF value A in U0.6 format.Selected if V_FCNTL == 1
 		dscl_prog_data->easf_v_bf_mina = 0;	//Vertical Min BF value A in U0.6 format.Selected if V_FCNTL == 0
@@ -1491,24 +1500,24 @@ static void spl_set_easf_data(struct spl_scratch *spl_scratch, struct spl_out *s
 		dscl_prog_data->easf_h_bf2_mode =
 			0xF;	// 4-bit, BF2 calculation mode
 		/* 2-bit, BF3 chroma mode correction calculation mode */
-		dscl_prog_data->easf_h_bf3_mode = spl_get_h_bf3_mode(
-			spl_scratch->scl_data.recip_ratios.horz);
+		dscl_prog_data->easf_h_bf3_mode = SPL_NAMESPACE(spl_get_h_bf3_mode(
+			spl_scratch->scl_data.recip_ratios.horz));
 		/* FP1.5.10; (2.0) Ring reducer gain for 4 or 6-tap mode [H_REDUCER_GAIN4] */
 		dscl_prog_data->easf_h_ringest_eventap_reduceg1 =
-			spl_get_reducer_gain4(spl_scratch->scl_data.taps.h_taps,
-				spl_scratch->scl_data.recip_ratios.horz);
+			SPL_NAMESPACE(spl_get_reducer_gain4(spl_scratch->scl_data.taps.h_taps,
+				spl_scratch->scl_data.recip_ratios.horz));
 		/* FP1.5.10; (2.5) Ring reducer gain for 6-tap mode [V_REDUCER_GAIN6] */
 		dscl_prog_data->easf_h_ringest_eventap_reduceg2 =
-			spl_get_reducer_gain6(spl_scratch->scl_data.taps.h_taps,
-				spl_scratch->scl_data.recip_ratios.horz);
+			SPL_NAMESPACE(spl_get_reducer_gain6(spl_scratch->scl_data.taps.h_taps,
+				spl_scratch->scl_data.recip_ratios.horz));
 		/* FP1.5.10; (-0.135742) Ring gain for 6-tap set to -139/1024 */
 		dscl_prog_data->easf_h_ringest_eventap_gain1 =
-			spl_get_gainRing4(spl_scratch->scl_data.taps.h_taps,
-				spl_scratch->scl_data.recip_ratios.horz);
+			SPL_NAMESPACE(spl_get_gainRing4(spl_scratch->scl_data.taps.h_taps,
+				spl_scratch->scl_data.recip_ratios.horz));
 		/* FP1.5.10; (-0.024414) Ring gain for 6-tap set to -25/1024 */
 		dscl_prog_data->easf_h_ringest_eventap_gain2 =
-			spl_get_gainRing6(spl_scratch->scl_data.taps.h_taps,
-				spl_scratch->scl_data.recip_ratios.horz);
+			SPL_NAMESPACE(spl_get_gainRing6(spl_scratch->scl_data.taps.h_taps,
+				spl_scratch->scl_data.recip_ratios.horz));
 		dscl_prog_data->easf_h_bf_maxa = 63; //Horz Max BF value A in U0.6 format.Selected if H_FCNTL==0
 		dscl_prog_data->easf_h_bf_maxb = 63; //Horz Max BF value B in U0.6 format.Selected if H_FCNTL==1
 		dscl_prog_data->easf_h_bf_mina = 0;	//Horz Min BF value B in U0.6 format.Selected if H_FCNTL==0
@@ -1689,9 +1698,9 @@ static void spl_set_isharp_data(struct dscl_prog_data *dscl_prog_data,
 		return;
 	}
 
-	spl_build_isharp_1dlut_from_reference_curve(ratio, setup, adp_sharpness,
-		scale_to_sharpness_policy);
-	memcpy(dscl_prog_data->isharp_delta, spl_get_pregen_filter_isharp_1D_lut(setup),
+	SPL_NAMESPACE(spl_build_isharp_1dlut_from_reference_curve(ratio, setup, adp_sharpness,
+		scale_to_sharpness_policy));
+	memcpy(dscl_prog_data->isharp_delta, SPL_NAMESPACE(spl_get_pregen_filter_isharp_1D_lut(setup)),
 		sizeof(uint32_t) * ISHARP_LUT_TABLE_SIZE);
 	dscl_prog_data->sharpness_level = adp_sharpness.sharpness_level;
 
@@ -1810,7 +1819,7 @@ static void spl_set_isharp_data(struct dscl_prog_data *dscl_prog_data,
 	}
 
 	// Set the values as per lookup table
-	spl_set_blur_scale_data(dscl_prog_data, data);
+	SPL_NAMESPACE(spl_set_blur_scale_data(dscl_prog_data, data));
 }
 
 /* Calculate recout, scaling ratio, and viewport, then get optimal number of taps */
@@ -1922,4 +1931,3 @@ bool SPL_NAMESPACE(spl_get_number_of_taps(struct spl_in *spl_in, struct spl_out
 	spl_set_taps_data(dscl_prog_data, data);
 	return res;
 }
-
diff --git a/drivers/gpu/drm/amd/display/dc/sspl/dc_spl.h b/drivers/gpu/drm/amd/display/dc/sspl/dc_spl.h
index d621c42a237e..f9503c368db5 100644
--- a/drivers/gpu/drm/amd/display/dc/sspl/dc_spl.h
+++ b/drivers/gpu/drm/amd/display/dc/sspl/dc_spl.h
@@ -9,14 +9,6 @@
 #define BLACK_OFFSET_RGB_Y 0x0
 #define BLACK_OFFSET_CBCR  0x8000
 
-#ifndef SPL_PFX_
-#define SPL_PFX_
-#endif
-
-#define SPL_EXPAND2(a, b)         a##b
-#define SPL_EXPAND(a, b)          SPL_EXPAND2(a, b)
-#define SPL_NAMESPACE(symbol)     SPL_EXPAND(SPL_PFX_, symbol)
-
 
 /* SPL interfaces */
 
diff --git a/drivers/gpu/drm/amd/display/dc/sspl/dc_spl_filters.c b/drivers/gpu/drm/amd/display/dc/sspl/dc_spl_filters.c
index 99238644e0a1..088aba3c00a1 100644
--- a/drivers/gpu/drm/amd/display/dc/sspl/dc_spl_filters.c
+++ b/drivers/gpu/drm/amd/display/dc/sspl/dc_spl_filters.c
@@ -4,8 +4,8 @@
 
 #include "dc_spl_filters.h"
 
-void convert_filter_s1_10_to_s1_12(const uint16_t *s1_10_filter,
-	uint16_t *s1_12_filter, int num_taps)
+void SPL_NAMESPACE(convert_filter_s1_10_to_s1_12(const uint16_t *s1_10_filter,
+	uint16_t *s1_12_filter, int num_taps))
 {
 	int num_entries = NUM_PHASES_COEFF * num_taps;
 	int i;
diff --git a/drivers/gpu/drm/amd/display/dc/sspl/dc_spl_filters.h b/drivers/gpu/drm/amd/display/dc/sspl/dc_spl_filters.h
index 20439cdbdb10..f3ee51c42bf2 100644
--- a/drivers/gpu/drm/amd/display/dc/sspl/dc_spl_filters.h
+++ b/drivers/gpu/drm/amd/display/dc/sspl/dc_spl_filters.h
@@ -9,7 +9,7 @@
 
 #define NUM_PHASES_COEFF 33
 
-void convert_filter_s1_10_to_s1_12(const uint16_t *s1_10_filter,
-	uint16_t *s1_12_filter, int num_taps);
+void SPL_NAMESPACE(convert_filter_s1_10_to_s1_12(const uint16_t *s1_10_filter,
+	uint16_t *s1_12_filter, int num_taps));
 
 #endif /* __DC_SPL_FILTERS_H__ */
diff --git a/drivers/gpu/drm/amd/display/dc/sspl/dc_spl_isharp_filters.c b/drivers/gpu/drm/amd/display/dc/sspl/dc_spl_isharp_filters.c
index 12acdd34e6a6..1d9edb89e47a 100644
--- a/drivers/gpu/drm/amd/display/dc/sspl/dc_spl_isharp_filters.c
+++ b/drivers/gpu/drm/amd/display/dc/sspl/dc_spl_isharp_filters.c
@@ -367,8 +367,8 @@ static unsigned int spl_calculate_sharpness_level_adj(struct spl_fixed31_32 rati
 	sharpness_level_down_adj = 0;
 	lookup_ptr = sharpness_level_adj;
 	while (j < NUM_SHARPNESS_ADJ_LEVELS) {
-		ratio_level = spl_fixpt_from_fraction(lookup_ptr->ratio_numer,
-			lookup_ptr->ratio_denom);
+		ratio_level = SPL_NAMESPACE(spl_fixpt_from_fraction(lookup_ptr->ratio_numer,
+			lookup_ptr->ratio_denom));
 		if (ratio.value >= ratio_level.value) {
 			sharpness_level_down_adj = lookup_ptr->level_down_adj;
 			break;
@@ -447,8 +447,9 @@ static unsigned int spl_calculate_sharpness_level(struct spl_fixed31_32 ratio,
 	return sharpness_level;
 }
 
-void spl_build_isharp_1dlut_from_reference_curve(struct spl_fixed31_32 ratio, enum system_setup setup,
-	struct adaptive_sharpness sharpness, enum scale_to_sharpness_policy scale_to_sharpness_policy)
+void SPL_NAMESPACE(spl_build_isharp_1dlut_from_reference_curve(
+	struct spl_fixed31_32 ratio, enum system_setup setup,
+	struct adaptive_sharpness sharpness, enum scale_to_sharpness_policy scale_to_sharpness_policy))
 {
 	uint8_t *byte_ptr_1dlut_src, *byte_ptr_1dlut_dst;
 	struct spl_fixed31_32 sharp_base, sharp_calc, sharp_level;
@@ -461,7 +462,7 @@ void spl_build_isharp_1dlut_from_reference_curve(struct spl_fixed31_32 ratio, en
 	unsigned int sharpnessX1000 = spl_calculate_sharpness_level(ratio,
 			sharpness.sharpness_level, setup,
 			sharpness.sharpness_range, scale_to_sharpness_policy);
-	sharp_level = spl_fixpt_from_fraction(sharpnessX1000, 1000);
+	sharp_level = SPL_NAMESPACE(spl_fixpt_from_fraction(sharpnessX1000, 1000));
 
 	/*
 	 * Check if pregen 1dlut table is already precalculated
@@ -486,10 +487,11 @@ void spl_build_isharp_1dlut_from_reference_curve(struct spl_fixed31_32 ratio, en
 	memset(byte_ptr_1dlut_dst, 0, size_1dlut);
 	for (j = 0; j < size_1dlut; j++) {
 		sharp_base = spl_fixpt_from_int((int)*byte_ptr_1dlut_src);
-		sharp_calc = spl_fixpt_mul(sharp_base, sharp_level);
+		sharp_calc = SPL_NAMESPACE(spl_fixpt_mul(sharp_base, sharp_level));
 		sharp_calc = spl_fixpt_div(sharp_calc, spl_fixpt_from_int(3));
 		sharp_calc = spl_fixpt_min(spl_fixpt_from_int(255), sharp_calc);
-		sharp_calc = spl_fixpt_add(sharp_calc, spl_fixpt_from_fraction(1, 2));
+		sharp_calc = spl_fixpt_add(sharp_calc,
+			SPL_NAMESPACE(spl_fixpt_from_fraction(1, 2)));
 		sharp_calc_int = spl_fixpt_floor(sharp_calc);
 		/* Clamp it at 0x7F so it doesn't wrap */
 		if (sharp_calc_int > 127)
@@ -506,12 +508,12 @@ void spl_build_isharp_1dlut_from_reference_curve(struct spl_fixed31_32 ratio, en
 	filter_isharp_1D_lut_pregen[setup].sharpness_denom = 1000;
 }
 
-uint32_t *spl_get_pregen_filter_isharp_1D_lut(enum system_setup setup)
+uint32_t *SPL_NAMESPACE(spl_get_pregen_filter_isharp_1D_lut(enum system_setup setup))
 {
 	return filter_isharp_1D_lut_pregen[setup].value;
 }
 
-const uint16_t *spl_dscl_get_blur_scale_coeffs_64p(int taps)
+const uint16_t *SPL_NAMESPACE(spl_dscl_get_blur_scale_coeffs_64p(int taps))
 {
 	if (taps == 3)
 		return filter_isharp_bs_3tap_64p_s1_12;
@@ -526,7 +528,7 @@ const uint16_t *spl_dscl_get_blur_scale_coeffs_64p(int taps)
 	}
 }
 
-const uint16_t *spl_dscl_get_blur_scale_coeffs_64p_s1_10(int taps)
+const uint16_t *SPL_NAMESPACE(spl_dscl_get_blur_scale_coeffs_64p_s1_10(int taps))
 {
 	if (taps == 3)
 		return filter_isharp_bs_3tap_64p;
@@ -541,13 +543,12 @@ const uint16_t *spl_dscl_get_blur_scale_coeffs_64p_s1_10(int taps)
 	}
 }
 
-void spl_set_blur_scale_data(struct dscl_prog_data *dscl_prog_data,
-		const struct spl_scaler_data *data)
+void SPL_NAMESPACE(spl_set_blur_scale_data(struct dscl_prog_data *dscl_prog_data,
+		const struct spl_scaler_data *data))
 {
 	dscl_prog_data->filter_blur_scale_h =
-		spl_dscl_get_blur_scale_coeffs_64p(data->taps.h_taps);
+		SPL_NAMESPACE(spl_dscl_get_blur_scale_coeffs_64p(data->taps.h_taps));
 
 	dscl_prog_data->filter_blur_scale_v =
-		spl_dscl_get_blur_scale_coeffs_64p(data->taps.v_taps);
+		SPL_NAMESPACE(spl_dscl_get_blur_scale_coeffs_64p(data->taps.v_taps));
 }
-
diff --git a/drivers/gpu/drm/amd/display/dc/sspl/dc_spl_isharp_filters.h b/drivers/gpu/drm/amd/display/dc/sspl/dc_spl_isharp_filters.h
index f5e3d3ecc913..d4082d4969e4 100644
--- a/drivers/gpu/drm/amd/display/dc/sspl/dc_spl_isharp_filters.h
+++ b/drivers/gpu/drm/amd/display/dc/sspl/dc_spl_isharp_filters.h
@@ -28,15 +28,17 @@ enum system_setup {
 	NUM_SHARPNESS_SETUPS
 };
 
-void spl_set_blur_scale_data(struct dscl_prog_data *dscl_prog_data,
-	const struct spl_scaler_data *data);
+void SPL_NAMESPACE(spl_set_blur_scale_data(struct dscl_prog_data *dscl_prog_data,
+	const struct spl_scaler_data *data));
 
-void spl_build_isharp_1dlut_from_reference_curve(struct spl_fixed31_32 ratio, enum system_setup setup,
-	struct adaptive_sharpness sharpness, enum scale_to_sharpness_policy scale_to_sharpness_policy);
-uint32_t *spl_get_pregen_filter_isharp_1D_lut(enum system_setup setup);
+void SPL_NAMESPACE(spl_build_isharp_1dlut_from_reference_curve(
+	struct spl_fixed31_32 ratio, enum system_setup setup,
+	struct adaptive_sharpness sharpness,
+	enum scale_to_sharpness_policy scale_to_sharpness_policy));
+uint32_t *SPL_NAMESPACE(spl_get_pregen_filter_isharp_1D_lut(enum system_setup setup));
 
 // public API
-const uint16_t *spl_dscl_get_blur_scale_coeffs_64p(int taps);
-const uint16_t *spl_dscl_get_blur_scale_coeffs_64p_s1_10(int taps);
+const uint16_t *SPL_NAMESPACE(spl_dscl_get_blur_scale_coeffs_64p(int taps));
+const uint16_t *SPL_NAMESPACE(spl_dscl_get_blur_scale_coeffs_64p_s1_10(int taps));
 
 #endif /* __DC_SPL_ISHARP_FILTERS_H__ */
diff --git a/drivers/gpu/drm/amd/display/dc/sspl/dc_spl_scl_easf_filters.c b/drivers/gpu/drm/amd/display/dc/sspl/dc_spl_scl_easf_filters.c
index 0d1bd81ff04a..de16ee586073 100644
--- a/drivers/gpu/drm/amd/display/dc/sspl/dc_spl_scl_easf_filters.c
+++ b/drivers/gpu/drm/amd/display/dc/sspl/dc_spl_scl_easf_filters.c
@@ -2194,19 +2194,19 @@ static struct scale_ratio_to_reg_value_lookup easf_3tap_uptilt2_offset_lookup[]
 
 static const uint16_t *spl_get_easf_filter_3tap_64p(struct spl_fixed31_32 ratio)
 {
-	if (ratio.value < spl_fixpt_from_fraction(3, 10).value)
+	if (ratio.value < SPL_NAMESPACE(spl_fixpt_from_fraction(3, 10)).value)
 		return easf_filter_3tap_64p_ratio_0_30_s1_12;
-	else if (ratio.value < spl_fixpt_from_fraction(4, 10).value)
+	else if (ratio.value < SPL_NAMESPACE(spl_fixpt_from_fraction(4, 10)).value)
 		return easf_filter_3tap_64p_ratio_0_40_s1_12;
-	else if (ratio.value < spl_fixpt_from_fraction(5, 10).value)
+	else if (ratio.value < SPL_NAMESPACE(spl_fixpt_from_fraction(5, 10)).value)
 		return easf_filter_3tap_64p_ratio_0_50_s1_12;
-	else if (ratio.value < spl_fixpt_from_fraction(6, 10).value)
+	else if (ratio.value < SPL_NAMESPACE(spl_fixpt_from_fraction(6, 10)).value)
 		return easf_filter_3tap_64p_ratio_0_60_s1_12;
-	else if (ratio.value < spl_fixpt_from_fraction(7, 10).value)
+	else if (ratio.value < SPL_NAMESPACE(spl_fixpt_from_fraction(7, 10)).value)
 		return easf_filter_3tap_64p_ratio_0_70_s1_12;
-	else if (ratio.value < spl_fixpt_from_fraction(8, 10).value)
+	else if (ratio.value < SPL_NAMESPACE(spl_fixpt_from_fraction(8, 10)).value)
 		return easf_filter_3tap_64p_ratio_0_80_s1_12;
-	else if (ratio.value < spl_fixpt_from_fraction(9, 10).value)
+	else if (ratio.value < SPL_NAMESPACE(spl_fixpt_from_fraction(9, 10)).value)
 		return easf_filter_3tap_64p_ratio_0_90_s1_12;
 	else
 		return easf_filter_3tap_64p_ratio_1_00_s1_12;
@@ -2214,19 +2214,19 @@ static const uint16_t *spl_get_easf_filter_3tap_64p(struct spl_fixed31_32 ratio)
 
 static const uint16_t *spl_get_easf_filter_4tap_64p(struct spl_fixed31_32 ratio)
 {
-	if (ratio.value < spl_fixpt_from_fraction(3, 10).value)
+	if (ratio.value < SPL_NAMESPACE(spl_fixpt_from_fraction(3, 10)).value)
 		return easf_filter_4tap_64p_ratio_0_30_s1_12;
-	else if (ratio.value < spl_fixpt_from_fraction(4, 10).value)
+	else if (ratio.value < SPL_NAMESPACE(spl_fixpt_from_fraction(4, 10)).value)
 		return easf_filter_4tap_64p_ratio_0_40_s1_12;
-	else if (ratio.value < spl_fixpt_from_fraction(5, 10).value)
+	else if (ratio.value < SPL_NAMESPACE(spl_fixpt_from_fraction(5, 10)).value)
 		return easf_filter_4tap_64p_ratio_0_50_s1_12;
-	else if (ratio.value < spl_fixpt_from_fraction(6, 10).value)
+	else if (ratio.value < SPL_NAMESPACE(spl_fixpt_from_fraction(6, 10)).value)
 		return easf_filter_4tap_64p_ratio_0_60_s1_12;
-	else if (ratio.value < spl_fixpt_from_fraction(7, 10).value)
+	else if (ratio.value < SPL_NAMESPACE(spl_fixpt_from_fraction(7, 10)).value)
 		return easf_filter_4tap_64p_ratio_0_70_s1_12;
-	else if (ratio.value < spl_fixpt_from_fraction(8, 10).value)
+	else if (ratio.value < SPL_NAMESPACE(spl_fixpt_from_fraction(8, 10)).value)
 		return easf_filter_4tap_64p_ratio_0_80_s1_12;
-	else if (ratio.value < spl_fixpt_from_fraction(9, 10).value)
+	else if (ratio.value < SPL_NAMESPACE(spl_fixpt_from_fraction(9, 10)).value)
 		return easf_filter_4tap_64p_ratio_0_90_s1_12;
 	else
 		return easf_filter_4tap_64p_ratio_1_00_s1_12;
@@ -2234,25 +2234,26 @@ static const uint16_t *spl_get_easf_filter_4tap_64p(struct spl_fixed31_32 ratio)
 
 static const uint16_t *spl_get_easf_filter_6tap_64p(struct spl_fixed31_32 ratio)
 {
-	if (ratio.value < spl_fixpt_from_fraction(3, 10).value)
+	if (ratio.value < SPL_NAMESPACE(spl_fixpt_from_fraction(3, 10)).value)
 		return easf_filter_6tap_64p_ratio_0_30_s1_12;
-	else if (ratio.value < spl_fixpt_from_fraction(4, 10).value)
+	else if (ratio.value < SPL_NAMESPACE(spl_fixpt_from_fraction(4, 10)).value)
 		return easf_filter_6tap_64p_ratio_0_40_s1_12;
-	else if (ratio.value < spl_fixpt_from_fraction(5, 10).value)
+	else if (ratio.value < SPL_NAMESPACE(spl_fixpt_from_fraction(5, 10)).value)
 		return easf_filter_6tap_64p_ratio_0_50_s1_12;
-	else if (ratio.value < spl_fixpt_from_fraction(6, 10).value)
+	else if (ratio.value < SPL_NAMESPACE(spl_fixpt_from_fraction(6, 10)).value)
 		return easf_filter_6tap_64p_ratio_0_60_s1_12;
-	else if (ratio.value < spl_fixpt_from_fraction(7, 10).value)
+	else if (ratio.value < SPL_NAMESPACE(spl_fixpt_from_fraction(7, 10)).value)
 		return easf_filter_6tap_64p_ratio_0_70_s1_12;
-	else if (ratio.value < spl_fixpt_from_fraction(8, 10).value)
+	else if (ratio.value < SPL_NAMESPACE(spl_fixpt_from_fraction(8, 10)).value)
 		return easf_filter_6tap_64p_ratio_0_80_s1_12;
-	else if (ratio.value < spl_fixpt_from_fraction(9, 10).value)
+	else if (ratio.value < SPL_NAMESPACE(spl_fixpt_from_fraction(9, 10)).value)
 		return easf_filter_6tap_64p_ratio_0_90_s1_12;
 	else
 		return easf_filter_6tap_64p_ratio_1_00_s1_12;
 }
 
-const uint16_t *spl_dscl_get_easf_filter_coeffs_64p(int taps, struct spl_fixed31_32 ratio)
+const uint16_t *SPL_NAMESPACE(spl_dscl_get_easf_filter_coeffs_64p(
+	int taps, struct spl_fixed31_32 ratio))
 {
 	if (taps == 6)
 		return spl_get_easf_filter_6tap_64p(ratio);
@@ -2269,19 +2270,19 @@ const uint16_t *spl_dscl_get_easf_filter_coeffs_64p(int taps, struct spl_fixed31
 
 static const uint16_t *spl_get_easf_filter_3tap_64p_s1_10(struct spl_fixed31_32 ratio)
 {
-	if (ratio.value < spl_fixpt_from_fraction(3, 10).value)
+	if (ratio.value < SPL_NAMESPACE(spl_fixpt_from_fraction(3, 10)).value)
 		return easf_filter_3tap_64p_ratio_0_30;
-	else if (ratio.value < spl_fixpt_from_fraction(4, 10).value)
+	else if (ratio.value < SPL_NAMESPACE(spl_fixpt_from_fraction(4, 10)).value)
 		return easf_filter_3tap_64p_ratio_0_40;
-	else if (ratio.value < spl_fixpt_from_fraction(5, 10).value)
+	else if (ratio.value < SPL_NAMESPACE(spl_fixpt_from_fraction(5, 10)).value)
 		return easf_filter_3tap_64p_ratio_0_50;
-	else if (ratio.value < spl_fixpt_from_fraction(6, 10).value)
+	else if (ratio.value < SPL_NAMESPACE(spl_fixpt_from_fraction(6, 10)).value)
 		return easf_filter_3tap_64p_ratio_0_60;
-	else if (ratio.value < spl_fixpt_from_fraction(7, 10).value)
+	else if (ratio.value < SPL_NAMESPACE(spl_fixpt_from_fraction(7, 10)).value)
 		return easf_filter_3tap_64p_ratio_0_70;
-	else if (ratio.value < spl_fixpt_from_fraction(8, 10).value)
+	else if (ratio.value < SPL_NAMESPACE(spl_fixpt_from_fraction(8, 10)).value)
 		return easf_filter_3tap_64p_ratio_0_80;
-	else if (ratio.value < spl_fixpt_from_fraction(9, 10).value)
+	else if (ratio.value < SPL_NAMESPACE(spl_fixpt_from_fraction(9, 10)).value)
 		return easf_filter_3tap_64p_ratio_0_90;
 	else
 		return easf_filter_3tap_64p_ratio_1_00;
@@ -2289,19 +2290,19 @@ static const uint16_t *spl_get_easf_filter_3tap_64p_s1_10(struct spl_fixed31_32
 
 static const uint16_t *spl_get_easf_filter_4tap_64p_s1_10(struct spl_fixed31_32 ratio)
 {
-	if (ratio.value < spl_fixpt_from_fraction(3, 10).value)
+	if (ratio.value < SPL_NAMESPACE(spl_fixpt_from_fraction(3, 10)).value)
 		return easf_filter_4tap_64p_ratio_0_30;
-	else if (ratio.value < spl_fixpt_from_fraction(4, 10).value)
+	else if (ratio.value < SPL_NAMESPACE(spl_fixpt_from_fraction(4, 10)).value)
 		return easf_filter_4tap_64p_ratio_0_40;
-	else if (ratio.value < spl_fixpt_from_fraction(5, 10).value)
+	else if (ratio.value < SPL_NAMESPACE(spl_fixpt_from_fraction(5, 10)).value)
 		return easf_filter_4tap_64p_ratio_0_50;
-	else if (ratio.value < spl_fixpt_from_fraction(6, 10).value)
+	else if (ratio.value < SPL_NAMESPACE(spl_fixpt_from_fraction(6, 10)).value)
 		return easf_filter_4tap_64p_ratio_0_60;
-	else if (ratio.value < spl_fixpt_from_fraction(7, 10).value)
+	else if (ratio.value < SPL_NAMESPACE(spl_fixpt_from_fraction(7, 10)).value)
 		return easf_filter_4tap_64p_ratio_0_70;
-	else if (ratio.value < spl_fixpt_from_fraction(8, 10).value)
+	else if (ratio.value < SPL_NAMESPACE(spl_fixpt_from_fraction(8, 10)).value)
 		return easf_filter_4tap_64p_ratio_0_80;
-	else if (ratio.value < spl_fixpt_from_fraction(9, 10).value)
+	else if (ratio.value < SPL_NAMESPACE(spl_fixpt_from_fraction(9, 10)).value)
 		return easf_filter_4tap_64p_ratio_0_90;
 	else
 		return easf_filter_4tap_64p_ratio_1_00;
@@ -2309,25 +2310,26 @@ static const uint16_t *spl_get_easf_filter_4tap_64p_s1_10(struct spl_fixed31_32
 
 static const uint16_t *spl_get_easf_filter_6tap_64p_s1_10(struct spl_fixed31_32 ratio)
 {
-	if (ratio.value < spl_fixpt_from_fraction(3, 10).value)
+	if (ratio.value < SPL_NAMESPACE(spl_fixpt_from_fraction(3, 10)).value)
 		return easf_filter_6tap_64p_ratio_0_30;
-	else if (ratio.value < spl_fixpt_from_fraction(4, 10).value)
+	else if (ratio.value < SPL_NAMESPACE(spl_fixpt_from_fraction(4, 10)).value)
 		return easf_filter_6tap_64p_ratio_0_40;
-	else if (ratio.value < spl_fixpt_from_fraction(5, 10).value)
+	else if (ratio.value < SPL_NAMESPACE(spl_fixpt_from_fraction(5, 10)).value)
 		return easf_filter_6tap_64p_ratio_0_50;
-	else if (ratio.value < spl_fixpt_from_fraction(6, 10).value)
+	else if (ratio.value < SPL_NAMESPACE(spl_fixpt_from_fraction(6, 10)).value)
 		return easf_filter_6tap_64p_ratio_0_60;
-	else if (ratio.value < spl_fixpt_from_fraction(7, 10).value)
+	else if (ratio.value < SPL_NAMESPACE(spl_fixpt_from_fraction(7, 10)).value)
 		return easf_filter_6tap_64p_ratio_0_70;
-	else if (ratio.value < spl_fixpt_from_fraction(8, 10).value)
+	else if (ratio.value < SPL_NAMESPACE(spl_fixpt_from_fraction(8, 10)).value)
 		return easf_filter_6tap_64p_ratio_0_80;
-	else if (ratio.value < spl_fixpt_from_fraction(9, 10).value)
+	else if (ratio.value < SPL_NAMESPACE(spl_fixpt_from_fraction(9, 10)).value)
 		return easf_filter_6tap_64p_ratio_0_90;
 	else
 		return easf_filter_6tap_64p_ratio_1_00;
 }
 
-const uint16_t *spl_dscl_get_easf_filter_coeffs_64p_s1_10(int taps, struct spl_fixed31_32 ratio)
+const uint16_t *SPL_NAMESPACE(spl_dscl_get_easf_filter_coeffs_64p_s1_10(
+	int taps, struct spl_fixed31_32 ratio))
 {
 	if (taps == 6)
 		return spl_get_easf_filter_6tap_64p_s1_10(ratio);
@@ -2342,39 +2344,39 @@ const uint16_t *spl_dscl_get_easf_filter_coeffs_64p_s1_10(int taps, struct spl_f
 	}
 }
 
-void spl_set_filters_data(struct dscl_prog_data *dscl_prog_data,
+void SPL_NAMESPACE(spl_set_filters_data(struct dscl_prog_data *dscl_prog_data,
 		const struct spl_scaler_data *data, bool enable_easf_v,
-		bool enable_easf_h)
+		bool enable_easf_h))
 {
 	/*
 	 * Old coefficients calculated scaling ratio = input / output
 	 * New coefficients are calculated based on = output / input
 	 */
 	if (enable_easf_h) {
-		dscl_prog_data->filter_h = spl_dscl_get_easf_filter_coeffs_64p(
-			data->taps.h_taps, data->recip_ratios.horz);
+		dscl_prog_data->filter_h = SPL_NAMESPACE(spl_dscl_get_easf_filter_coeffs_64p(
+			data->taps.h_taps, data->recip_ratios.horz));
 
-		dscl_prog_data->filter_h_c = spl_dscl_get_easf_filter_coeffs_64p(
-			data->taps.h_taps_c, data->recip_ratios.horz_c);
+		dscl_prog_data->filter_h_c = SPL_NAMESPACE(spl_dscl_get_easf_filter_coeffs_64p(
+			data->taps.h_taps_c, data->recip_ratios.horz_c));
 	} else {
-		dscl_prog_data->filter_h = spl_dscl_get_filter_coeffs_64p(
-			data->taps.h_taps, data->ratios.horz);
+		dscl_prog_data->filter_h = SPL_NAMESPACE(spl_dscl_get_filter_coeffs_64p(
+			data->taps.h_taps, data->ratios.horz));
 
-		dscl_prog_data->filter_h_c = spl_dscl_get_filter_coeffs_64p(
-			data->taps.h_taps_c, data->ratios.horz_c);
+		dscl_prog_data->filter_h_c = SPL_NAMESPACE(spl_dscl_get_filter_coeffs_64p(
+			data->taps.h_taps_c, data->ratios.horz_c));
 	}
 	if (enable_easf_v) {
-		dscl_prog_data->filter_v = spl_dscl_get_easf_filter_coeffs_64p(
-			data->taps.v_taps, data->recip_ratios.vert);
+		dscl_prog_data->filter_v = SPL_NAMESPACE(spl_dscl_get_easf_filter_coeffs_64p(
+			data->taps.v_taps, data->recip_ratios.vert));
 
-		dscl_prog_data->filter_v_c = spl_dscl_get_easf_filter_coeffs_64p(
-			data->taps.v_taps_c, data->recip_ratios.vert_c);
+		dscl_prog_data->filter_v_c = SPL_NAMESPACE(spl_dscl_get_easf_filter_coeffs_64p(
+			data->taps.v_taps_c, data->recip_ratios.vert_c));
 	} else {
-		dscl_prog_data->filter_v = spl_dscl_get_filter_coeffs_64p(
-			data->taps.v_taps, data->ratios.vert);
+		dscl_prog_data->filter_v = SPL_NAMESPACE(spl_dscl_get_filter_coeffs_64p(
+			data->taps.v_taps, data->ratios.vert));
 
-		dscl_prog_data->filter_v_c = spl_dscl_get_filter_coeffs_64p(
-			data->taps.v_taps_c, data->ratios.vert_c);
+		dscl_prog_data->filter_v_c = SPL_NAMESPACE(spl_dscl_get_filter_coeffs_64p(
+			data->taps.v_taps_c, data->ratios.vert_c));
 	}
 }
 
@@ -2395,9 +2397,9 @@ static uint32_t spl_easf_get_scale_ratio_to_reg_value(struct spl_fixed31_32 rati
 		if (lookup_table_index_ptr->numer < 0)
 			break;
 
-		if (ratio.value < spl_fixpt_from_fraction(
+		if (ratio.value < SPL_NAMESPACE(spl_fixpt_from_fraction(
 			lookup_table_index_ptr->numer,
-			lookup_table_index_ptr->denom).value) {
+			lookup_table_index_ptr->denom)).value) {
 			value = lookup_table_index_ptr->reg_value;
 			break;
 		}
@@ -2406,7 +2408,7 @@ static uint32_t spl_easf_get_scale_ratio_to_reg_value(struct spl_fixed31_32 rati
 	}
 	return value;
 }
-uint32_t spl_get_v_bf3_mode(struct spl_fixed31_32 ratio)
+uint32_t SPL_NAMESPACE(spl_get_v_bf3_mode(struct spl_fixed31_32 ratio))
 {
 	uint32_t value;
 	unsigned int num_entries = sizeof(easf_v_bf3_mode_lookup) /
@@ -2415,7 +2417,7 @@ uint32_t spl_get_v_bf3_mode(struct spl_fixed31_32 ratio)
 		easf_v_bf3_mode_lookup, num_entries);
 	return value;
 }
-uint32_t spl_get_h_bf3_mode(struct spl_fixed31_32 ratio)
+uint32_t SPL_NAMESPACE(spl_get_h_bf3_mode(struct spl_fixed31_32 ratio))
 {
 	uint32_t value;
 	unsigned int num_entries = sizeof(easf_h_bf3_mode_lookup) /
@@ -2424,7 +2426,7 @@ uint32_t spl_get_h_bf3_mode(struct spl_fixed31_32 ratio)
 		easf_h_bf3_mode_lookup, num_entries);
 	return value;
 }
-uint32_t spl_get_reducer_gain6(int taps, struct spl_fixed31_32 ratio)
+uint32_t SPL_NAMESPACE(spl_get_reducer_gain6(int taps, struct spl_fixed31_32 ratio))
 {
 	uint32_t value;
 	unsigned int num_entries;
@@ -2443,7 +2445,7 @@ uint32_t spl_get_reducer_gain6(int taps, struct spl_fixed31_32 ratio)
 		value = 0;
 	return value;
 }
-uint32_t spl_get_reducer_gain4(int taps, struct spl_fixed31_32 ratio)
+uint32_t SPL_NAMESPACE(spl_get_reducer_gain4(int taps, struct spl_fixed31_32 ratio))
 {
 	uint32_t value;
 	unsigned int num_entries;
@@ -2462,7 +2464,7 @@ uint32_t spl_get_reducer_gain4(int taps, struct spl_fixed31_32 ratio)
 		value = 0;
 	return value;
 }
-uint32_t spl_get_gainRing6(int taps, struct spl_fixed31_32 ratio)
+uint32_t SPL_NAMESPACE(spl_get_gainRing6(int taps, struct spl_fixed31_32 ratio))
 {
 	uint32_t value;
 	unsigned int num_entries;
@@ -2481,7 +2483,7 @@ uint32_t spl_get_gainRing6(int taps, struct spl_fixed31_32 ratio)
 		value = 0;
 	return value;
 }
-uint32_t spl_get_gainRing4(int taps, struct spl_fixed31_32 ratio)
+uint32_t SPL_NAMESPACE(spl_get_gainRing4(int taps, struct spl_fixed31_32 ratio))
 {
 	uint32_t value;
 	unsigned int num_entries;
@@ -2500,7 +2502,8 @@ uint32_t spl_get_gainRing4(int taps, struct spl_fixed31_32 ratio)
 		value = 0;
 	return value;
 }
-uint32_t spl_get_3tap_dntilt_uptilt_offset(int taps, struct spl_fixed31_32 ratio)
+uint32_t SPL_NAMESPACE(spl_get_3tap_dntilt_uptilt_offset(
+	int taps, struct spl_fixed31_32 ratio))
 {
 	uint32_t value;
 	unsigned int num_entries;
@@ -2514,7 +2517,7 @@ uint32_t spl_get_3tap_dntilt_uptilt_offset(int taps, struct spl_fixed31_32 ratio
 		value = 0;
 	return value;
 }
-uint32_t spl_get_3tap_uptilt_maxval(int taps, struct spl_fixed31_32 ratio)
+uint32_t SPL_NAMESPACE(spl_get_3tap_uptilt_maxval(int taps, struct spl_fixed31_32 ratio))
 {
 	uint32_t value;
 	unsigned int num_entries;
@@ -2528,7 +2531,7 @@ uint32_t spl_get_3tap_uptilt_maxval(int taps, struct spl_fixed31_32 ratio)
 		value = 0;
 	return value;
 }
-uint32_t spl_get_3tap_dntilt_slope(int taps, struct spl_fixed31_32 ratio)
+uint32_t SPL_NAMESPACE(spl_get_3tap_dntilt_slope(int taps, struct spl_fixed31_32 ratio))
 {
 	uint32_t value;
 	unsigned int num_entries;
@@ -2542,7 +2545,7 @@ uint32_t spl_get_3tap_dntilt_slope(int taps, struct spl_fixed31_32 ratio)
 		value = 0;
 	return value;
 }
-uint32_t spl_get_3tap_uptilt1_slope(int taps, struct spl_fixed31_32 ratio)
+uint32_t SPL_NAMESPACE(spl_get_3tap_uptilt1_slope(int taps, struct spl_fixed31_32 ratio))
 {
 	uint32_t value;
 	unsigned int num_entries;
@@ -2556,7 +2559,7 @@ uint32_t spl_get_3tap_uptilt1_slope(int taps, struct spl_fixed31_32 ratio)
 		value = 0;
 	return value;
 }
-uint32_t spl_get_3tap_uptilt2_slope(int taps, struct spl_fixed31_32 ratio)
+uint32_t SPL_NAMESPACE(spl_get_3tap_uptilt2_slope(int taps, struct spl_fixed31_32 ratio))
 {
 	uint32_t value;
 	unsigned int num_entries;
@@ -2570,7 +2573,7 @@ uint32_t spl_get_3tap_uptilt2_slope(int taps, struct spl_fixed31_32 ratio)
 		value = 0;
 	return value;
 }
-uint32_t spl_get_3tap_uptilt2_offset(int taps, struct spl_fixed31_32 ratio)
+uint32_t SPL_NAMESPACE(spl_get_3tap_uptilt2_offset(int taps, struct spl_fixed31_32 ratio))
 {
 	uint32_t value;
 	unsigned int num_entries;
diff --git a/drivers/gpu/drm/amd/display/dc/sspl/dc_spl_scl_easf_filters.h b/drivers/gpu/drm/amd/display/dc/sspl/dc_spl_scl_easf_filters.h
index 321ae22a04d4..ba1cdb8be417 100644
--- a/drivers/gpu/drm/amd/display/dc/sspl/dc_spl_scl_easf_filters.h
+++ b/drivers/gpu/drm/amd/display/dc/sspl/dc_spl_scl_easf_filters.h
@@ -13,25 +13,28 @@ struct scale_ratio_to_reg_value_lookup {
 	const uint32_t reg_value;
 };
 
-void spl_set_filters_data(struct dscl_prog_data *dscl_prog_data,
+void SPL_NAMESPACE(spl_set_filters_data(struct dscl_prog_data *dscl_prog_data,
 	const struct spl_scaler_data *data, bool enable_easf_v,
-	bool enable_easf_h);
-
-uint32_t spl_get_v_bf3_mode(struct spl_fixed31_32 ratio);
-uint32_t spl_get_h_bf3_mode(struct spl_fixed31_32 ratio);
-uint32_t spl_get_reducer_gain6(int taps, struct spl_fixed31_32 ratio);
-uint32_t spl_get_reducer_gain4(int taps, struct spl_fixed31_32 ratio);
-uint32_t spl_get_gainRing6(int taps, struct spl_fixed31_32 ratio);
-uint32_t spl_get_gainRing4(int taps, struct spl_fixed31_32 ratio);
-uint32_t spl_get_3tap_dntilt_uptilt_offset(int taps, struct spl_fixed31_32 ratio);
-uint32_t spl_get_3tap_uptilt_maxval(int taps, struct spl_fixed31_32 ratio);
-uint32_t spl_get_3tap_dntilt_slope(int taps, struct spl_fixed31_32 ratio);
-uint32_t spl_get_3tap_uptilt1_slope(int taps, struct spl_fixed31_32 ratio);
-uint32_t spl_get_3tap_uptilt2_slope(int taps, struct spl_fixed31_32 ratio);
-uint32_t spl_get_3tap_uptilt2_offset(int taps, struct spl_fixed31_32 ratio);
+	bool enable_easf_h));
+
+uint32_t SPL_NAMESPACE(spl_get_v_bf3_mode(struct spl_fixed31_32 ratio));
+uint32_t SPL_NAMESPACE(spl_get_h_bf3_mode(struct spl_fixed31_32 ratio));
+uint32_t SPL_NAMESPACE(spl_get_reducer_gain6(int taps, struct spl_fixed31_32 ratio));
+uint32_t SPL_NAMESPACE(spl_get_reducer_gain4(int taps, struct spl_fixed31_32 ratio));
+uint32_t SPL_NAMESPACE(spl_get_gainRing6(int taps, struct spl_fixed31_32 ratio));
+uint32_t SPL_NAMESPACE(spl_get_gainRing4(int taps, struct spl_fixed31_32 ratio));
+uint32_t SPL_NAMESPACE(spl_get_3tap_dntilt_uptilt_offset(
+	int taps, struct spl_fixed31_32 ratio));
+uint32_t SPL_NAMESPACE(spl_get_3tap_uptilt_maxval(int taps, struct spl_fixed31_32 ratio));
+uint32_t SPL_NAMESPACE(spl_get_3tap_dntilt_slope(int taps, struct spl_fixed31_32 ratio));
+uint32_t SPL_NAMESPACE(spl_get_3tap_uptilt1_slope(int taps, struct spl_fixed31_32 ratio));
+uint32_t SPL_NAMESPACE(spl_get_3tap_uptilt2_slope(int taps, struct spl_fixed31_32 ratio));
+uint32_t SPL_NAMESPACE(spl_get_3tap_uptilt2_offset(int taps, struct spl_fixed31_32 ratio));
 
 /* public API */
-const uint16_t *spl_dscl_get_easf_filter_coeffs_64p(int taps, struct spl_fixed31_32 ratio);
-const uint16_t *spl_dscl_get_easf_filter_coeffs_64p_s1_10(int taps, struct spl_fixed31_32 ratio);
+const uint16_t *SPL_NAMESPACE(spl_dscl_get_easf_filter_coeffs_64p(
+	int taps, struct spl_fixed31_32 ratio));
+const uint16_t *SPL_NAMESPACE(spl_dscl_get_easf_filter_coeffs_64p_s1_10(
+	int taps, struct spl_fixed31_32 ratio));
 
 #endif /* __DC_SPL_SCL_EASF_FILTERS_H__ */
diff --git a/drivers/gpu/drm/amd/display/dc/sspl/dc_spl_scl_filters.c b/drivers/gpu/drm/amd/display/dc/sspl/dc_spl_scl_filters.c
index 5e52bdf1ad44..2d73d0dce5ff 100644
--- a/drivers/gpu/drm/amd/display/dc/sspl/dc_spl_scl_filters.c
+++ b/drivers/gpu/drm/amd/display/dc/sspl/dc_spl_scl_filters.c
@@ -1134,9 +1134,9 @@ static const uint16_t *spl_get_filter_3tap_64p(struct spl_fixed31_32 ratio)
 {
 	if (ratio.value < spl_fixpt_one.value)
 		return filter_3tap_64p_upscale;
-	else if (ratio.value < spl_fixpt_from_fraction(4, 3).value)
+	else if (ratio.value < SPL_NAMESPACE(spl_fixpt_from_fraction(4, 3)).value)
 		return filter_3tap_64p_116;
-	else if (ratio.value < spl_fixpt_from_fraction(5, 3).value)
+	else if (ratio.value < SPL_NAMESPACE(spl_fixpt_from_fraction(5, 3)).value)
 		return filter_3tap_64p_149;
 	else
 		return filter_3tap_64p_183;
@@ -1146,9 +1146,9 @@ static const uint16_t *spl_get_filter_4tap_64p(struct spl_fixed31_32 ratio)
 {
 	if (ratio.value < spl_fixpt_one.value)
 		return filter_4tap_64p_upscale;
-	else if (ratio.value < spl_fixpt_from_fraction(4, 3).value)
+	else if (ratio.value < SPL_NAMESPACE(spl_fixpt_from_fraction(4, 3)).value)
 		return filter_4tap_64p_116;
-	else if (ratio.value < spl_fixpt_from_fraction(5, 3).value)
+	else if (ratio.value < SPL_NAMESPACE(spl_fixpt_from_fraction(5, 3)).value)
 		return filter_4tap_64p_149;
 	else
 		return filter_4tap_64p_183;
@@ -1158,9 +1158,9 @@ static const uint16_t *spl_get_filter_5tap_64p(struct spl_fixed31_32 ratio)
 {
 	if (ratio.value < spl_fixpt_one.value)
 		return filter_5tap_64p_upscale;
-	else if (ratio.value < spl_fixpt_from_fraction(4, 3).value)
+	else if (ratio.value < SPL_NAMESPACE(spl_fixpt_from_fraction(4, 3)).value)
 		return filter_5tap_64p_116;
-	else if (ratio.value < spl_fixpt_from_fraction(5, 3).value)
+	else if (ratio.value < SPL_NAMESPACE(spl_fixpt_from_fraction(5, 3)).value)
 		return filter_5tap_64p_149;
 	else
 		return filter_5tap_64p_183;
@@ -1170,9 +1170,9 @@ static const uint16_t *spl_get_filter_6tap_64p(struct spl_fixed31_32 ratio)
 {
 	if (ratio.value < spl_fixpt_one.value)
 		return filter_6tap_64p_upscale;
-	else if (ratio.value < spl_fixpt_from_fraction(4, 3).value)
+	else if (ratio.value < SPL_NAMESPACE(spl_fixpt_from_fraction(4, 3)).value)
 		return filter_6tap_64p_116;
-	else if (ratio.value < spl_fixpt_from_fraction(5, 3).value)
+	else if (ratio.value < SPL_NAMESPACE(spl_fixpt_from_fraction(5, 3)).value)
 		return filter_6tap_64p_149;
 	else
 		return filter_6tap_64p_183;
@@ -1182,9 +1182,9 @@ static const uint16_t *spl_get_filter_7tap_64p(struct spl_fixed31_32 ratio)
 {
 	if (ratio.value < spl_fixpt_one.value)
 		return filter_7tap_64p_upscale;
-	else if (ratio.value < spl_fixpt_from_fraction(4, 3).value)
+	else if (ratio.value < SPL_NAMESPACE(spl_fixpt_from_fraction(4, 3)).value)
 		return filter_7tap_64p_116;
-	else if (ratio.value < spl_fixpt_from_fraction(5, 3).value)
+	else if (ratio.value < SPL_NAMESPACE(spl_fixpt_from_fraction(5, 3)).value)
 		return filter_7tap_64p_149;
 	else
 		return filter_7tap_64p_183;
@@ -1194,9 +1194,9 @@ static const uint16_t *spl_get_filter_8tap_64p(struct spl_fixed31_32 ratio)
 {
 	if (ratio.value < spl_fixpt_one.value)
 		return filter_8tap_64p_upscale;
-	else if (ratio.value < spl_fixpt_from_fraction(4, 3).value)
+	else if (ratio.value < SPL_NAMESPACE(spl_fixpt_from_fraction(4, 3)).value)
 		return filter_8tap_64p_116;
-	else if (ratio.value < spl_fixpt_from_fraction(5, 3).value)
+	else if (ratio.value < SPL_NAMESPACE(spl_fixpt_from_fraction(5, 3)).value)
 		return filter_8tap_64p_149;
 	else
 		return filter_8tap_64p_183;
@@ -1207,7 +1207,8 @@ static const uint16_t *spl_get_filter_2tap_64p(void)
 	return filter_2tap_64p;
 }
 
-const uint16_t *spl_dscl_get_filter_coeffs_64p(int taps, struct spl_fixed31_32 ratio)
+const uint16_t *SPL_NAMESPACE(spl_dscl_get_filter_coeffs_64p(
+	int taps, struct spl_fixed31_32 ratio))
 {
 	if (taps == 8)
 		return spl_get_filter_8tap_64p(ratio);
diff --git a/drivers/gpu/drm/amd/display/dc/sspl/dc_spl_scl_filters.h b/drivers/gpu/drm/amd/display/dc/sspl/dc_spl_scl_filters.h
index c315a438d064..445d626863c2 100644
--- a/drivers/gpu/drm/amd/display/dc/sspl/dc_spl_scl_filters.h
+++ b/drivers/gpu/drm/amd/display/dc/sspl/dc_spl_scl_filters.h
@@ -8,6 +8,7 @@
 #include "dc_spl_types.h"
 
 /* public API */
-const uint16_t *spl_dscl_get_filter_coeffs_64p(int taps, struct spl_fixed31_32 ratio);
+const uint16_t *SPL_NAMESPACE(spl_dscl_get_filter_coeffs_64p(
+	int taps, struct spl_fixed31_32 ratio));
 
 #endif /* __DC_SPL_SCL_FILTERS_H__ */
diff --git a/drivers/gpu/drm/amd/display/dc/sspl/spl_custom_float.c b/drivers/gpu/drm/amd/display/dc/sspl/spl_custom_float.c
index be2f34d034c5..0700b3dbbda7 100644
--- a/drivers/gpu/drm/amd/display/dc/sspl/spl_custom_float.c
+++ b/drivers/gpu/drm/amd/display/dc/sspl/spl_custom_float.c
@@ -14,8 +14,8 @@ static bool spl_build_custom_float(struct spl_fixed31_32 value,
 	uint32_t exp_offset = (1 << (format->exponenta_bits - 1)) - 1;
 
 	const struct spl_fixed31_32 mantissa_constant_plus_max_fraction =
-		spl_fixpt_from_fraction((1LL << (format->mantissa_bits + 1)) - 1,
-				       1LL << format->mantissa_bits);
+		SPL_NAMESPACE(spl_fixpt_from_fraction((1LL << (format->mantissa_bits + 1)) - 1,
+				       1LL << format->mantissa_bits));
 
 	struct spl_fixed31_32 mantiss;
 
@@ -134,9 +134,10 @@ static bool spl_setup_custom_float(const struct spl_custom_float_format *format,
 	return true;
 }
 
-bool spl_convert_to_custom_float_format(struct spl_fixed31_32 value,
-				    const struct spl_custom_float_format *format,
-				    uint32_t *result)
+bool SPL_NAMESPACE(spl_convert_to_custom_float_format(
+	struct spl_fixed31_32 value,
+	const struct spl_custom_float_format *format,
+	uint32_t *result))
 {
 	uint32_t mantissa;
 	uint32_t exponenta;
diff --git a/drivers/gpu/drm/amd/display/dc/sspl/spl_custom_float.h b/drivers/gpu/drm/amd/display/dc/sspl/spl_custom_float.h
index cdc4e107b9de..f3fd8d30e638 100644
--- a/drivers/gpu/drm/amd/display/dc/sspl/spl_custom_float.h
+++ b/drivers/gpu/drm/amd/display/dc/sspl/spl_custom_float.h
@@ -21,9 +21,9 @@ struct spl_custom_float_value {
 	bool negative;
 };
 
-bool spl_convert_to_custom_float_format(
+bool SPL_NAMESPACE(spl_convert_to_custom_float_format(
 	struct spl_fixed31_32 value,
 	const struct spl_custom_float_format *format,
-	uint32_t *result);
+	uint32_t *result));
 
 #endif //SPL_CUSTOM_FLOAT_H_
diff --git a/drivers/gpu/drm/amd/display/dc/sspl/spl_fixpt31_32.c b/drivers/gpu/drm/amd/display/dc/sspl/spl_fixpt31_32.c
index ebf0287417e0..ff0bdc3c33c8 100644
--- a/drivers/gpu/drm/amd/display/dc/sspl/spl_fixpt31_32.c
+++ b/drivers/gpu/drm/amd/display/dc/sspl/spl_fixpt31_32.c
@@ -44,7 +44,8 @@ static inline unsigned long long spl_complete_integer_division_u64(
 #define GET_FRACTIONAL_PART(x) \
 	(FRACTIONAL_PART_MASK & (x))
 
-struct spl_fixed31_32 spl_fixpt_from_fraction(long long numerator, long long denominator)
+struct spl_fixed31_32 SPL_NAMESPACE(spl_fixpt_from_fraction(
+	long long numerator, long long denominator))
 {
 	struct spl_fixed31_32 res;
 
@@ -96,7 +97,8 @@ struct spl_fixed31_32 spl_fixpt_from_fraction(long long numerator, long long den
 	return res;
 }
 
-struct spl_fixed31_32 spl_fixpt_mul(struct spl_fixed31_32 arg1, struct spl_fixed31_32 arg2)
+struct spl_fixed31_32 SPL_NAMESPACE(spl_fixpt_mul(
+	struct spl_fixed31_32 arg1, struct spl_fixed31_32 arg2))
 {
 	struct spl_fixed31_32 res;
 
@@ -147,7 +149,7 @@ struct spl_fixed31_32 spl_fixpt_mul(struct spl_fixed31_32 arg1, struct spl_fixed
 	return res;
 }
 
-struct spl_fixed31_32 spl_fixpt_sqr(struct spl_fixed31_32 arg)
+struct spl_fixed31_32 SPL_NAMESPACE(spl_fixpt_sqr(struct spl_fixed31_32 arg))
 {
 	struct spl_fixed31_32 res;
 
@@ -187,19 +189,19 @@ struct spl_fixed31_32 spl_fixpt_sqr(struct spl_fixed31_32 arg)
 	return res;
 }
 
-struct spl_fixed31_32 spl_fixpt_recip(struct spl_fixed31_32 arg)
+struct spl_fixed31_32 SPL_NAMESPACE(spl_fixpt_recip(struct spl_fixed31_32 arg))
 {
 	/*
 	 * @note
 	 * Good idea to use Newton's method
 	 */
 
-	return spl_fixpt_from_fraction(
+	return SPL_NAMESPACE(spl_fixpt_from_fraction(
 		spl_fixpt_one.value,
-		arg.value);
+		arg.value));
 }
 
-struct spl_fixed31_32 spl_fixpt_sinc(struct spl_fixed31_32 arg)
+struct spl_fixed31_32 SPL_NAMESPACE(spl_fixpt_sinc(struct spl_fixed31_32 arg))
 {
 	struct spl_fixed31_32 square;
 
@@ -221,15 +223,15 @@ struct spl_fixed31_32 spl_fixpt_sinc(struct spl_fixed31_32 arg)
 					spl_fixpt_two_pi.value)));
 	}
 
-	square = spl_fixpt_sqr(arg_norm);
+	square = SPL_NAMESPACE(spl_fixpt_sqr(arg_norm));
 
 	do {
 		res = spl_fixpt_sub(
 			spl_fixpt_one,
 			spl_fixpt_div_int(
-				spl_fixpt_mul(
+				SPL_NAMESPACE(spl_fixpt_mul(
 					square,
-					res),
+					res)),
 				n * (n - 1)));
 
 		n -= 2;
@@ -237,24 +239,24 @@ struct spl_fixed31_32 spl_fixpt_sinc(struct spl_fixed31_32 arg)
 
 	if (arg.value != arg_norm.value)
 		res = spl_fixpt_div(
-			spl_fixpt_mul(res, arg_norm),
+			SPL_NAMESPACE(spl_fixpt_mul(res, arg_norm)),
 			arg);
 
 	return res;
 }
 
-struct spl_fixed31_32 spl_fixpt_sin(struct spl_fixed31_32 arg)
+struct spl_fixed31_32 SPL_NAMESPACE(spl_fixpt_sin(struct spl_fixed31_32 arg))
 {
-	return spl_fixpt_mul(
+	return SPL_NAMESPACE(spl_fixpt_mul(
 		arg,
-		spl_fixpt_sinc(arg));
+		SPL_NAMESPACE(spl_fixpt_sinc(arg))));
 }
 
-struct spl_fixed31_32 spl_fixpt_cos(struct spl_fixed31_32 arg)
+struct spl_fixed31_32 SPL_NAMESPACE(spl_fixpt_cos(struct spl_fixed31_32 arg))
 {
 	/* TODO implement argument normalization */
 
-	const struct spl_fixed31_32 square = spl_fixpt_sqr(arg);
+	const struct spl_fixed31_32 square = SPL_NAMESPACE(spl_fixpt_sqr(arg));
 
 	struct spl_fixed31_32 res = spl_fixpt_one;
 
@@ -264,9 +266,9 @@ struct spl_fixed31_32 spl_fixpt_cos(struct spl_fixed31_32 arg)
 		res = spl_fixpt_sub(
 			spl_fixpt_one,
 			spl_fixpt_div_int(
-				spl_fixpt_mul(
+				SPL_NAMESPACE(spl_fixpt_mul(
 					square,
-					res),
+					res)),
 				n * (n - 1)));
 
 		n -= 2;
@@ -286,9 +288,9 @@ static struct spl_fixed31_32 spl_fixed31_32_exp_from_taylor_series(struct spl_fi
 {
 	unsigned int n = 9;
 
-	struct spl_fixed31_32 res = spl_fixpt_from_fraction(
+	struct spl_fixed31_32 res = SPL_NAMESPACE(spl_fixpt_from_fraction(
 		n + 2,
-		n + 1);
+		n + 1));
 	/* TODO find correct res */
 
 	SPL_ASSERT(spl_fixpt_lt(arg, spl_fixpt_one));
@@ -297,20 +299,20 @@ static struct spl_fixed31_32 spl_fixed31_32_exp_from_taylor_series(struct spl_fi
 		res = spl_fixpt_add(
 			spl_fixpt_one,
 			spl_fixpt_div_int(
-				spl_fixpt_mul(
+				SPL_NAMESPACE(spl_fixpt_mul(
 					arg,
-					res),
+					res)),
 				n));
 	while (--n != 1);
 
 	return spl_fixpt_add(
 		spl_fixpt_one,
-		spl_fixpt_mul(
+		SPL_NAMESPACE(spl_fixpt_mul(
 			arg,
-			res));
+			res)));
 }
 
-struct spl_fixed31_32 spl_fixpt_exp(struct spl_fixed31_32 arg)
+struct spl_fixed31_32 SPL_NAMESPACE(spl_fixpt_exp(struct spl_fixed31_32 arg))
 {
 	/*
 	 * @brief
@@ -353,7 +355,7 @@ struct spl_fixed31_32 spl_fixpt_exp(struct spl_fixed31_32 arg)
 		return spl_fixpt_one;
 }
 
-struct spl_fixed31_32 spl_fixpt_log(struct spl_fixed31_32 arg)
+struct spl_fixed31_32 SPL_NAMESPACE(spl_fixpt_log(struct spl_fixed31_32 arg))
 {
 	struct spl_fixed31_32 res = spl_fixpt_neg(spl_fixpt_one);
 	/* TODO improve 1st estimation */
@@ -371,7 +373,7 @@ struct spl_fixed31_32 spl_fixpt_log(struct spl_fixed31_32 arg)
 				spl_fixpt_one),
 			spl_fixpt_div(
 				arg,
-				spl_fixpt_exp(res)));
+				SPL_NAMESPACE(spl_fixpt_exp(res))));
 
 		error = spl_fixpt_sub(
 			res,
@@ -427,37 +429,37 @@ static inline unsigned int spl_clamp_ux_dy(
 		return min_clamp;
 }
 
-unsigned int spl_fixpt_u4d19(struct spl_fixed31_32 arg)
+unsigned int SPL_NAMESPACE(spl_fixpt_u4d19(struct spl_fixed31_32 arg))
 {
 	return spl_ux_dy(arg.value, 4, 19);
 }
 
-unsigned int spl_fixpt_u3d19(struct spl_fixed31_32 arg)
+unsigned int SPL_NAMESPACE(spl_fixpt_u3d19(struct spl_fixed31_32 arg))
 {
 	return spl_ux_dy(arg.value, 3, 19);
 }
 
-unsigned int spl_fixpt_u2d19(struct spl_fixed31_32 arg)
+unsigned int SPL_NAMESPACE(spl_fixpt_u2d19(struct spl_fixed31_32 arg))
 {
 	return spl_ux_dy(arg.value, 2, 19);
 }
 
-unsigned int spl_fixpt_u0d19(struct spl_fixed31_32 arg)
+unsigned int SPL_NAMESPACE(spl_fixpt_u0d19(struct spl_fixed31_32 arg))
 {
 	return spl_ux_dy(arg.value, 0, 19);
 }
 
-unsigned int spl_fixpt_clamp_u0d14(struct spl_fixed31_32 arg)
+unsigned int SPL_NAMESPACE(spl_fixpt_clamp_u0d14(struct spl_fixed31_32 arg))
 {
 	return spl_clamp_ux_dy(arg.value, 0, 14, 1);
 }
 
-unsigned int spl_fixpt_clamp_u0d10(struct spl_fixed31_32 arg)
+unsigned int SPL_NAMESPACE(spl_fixpt_clamp_u0d10(struct spl_fixed31_32 arg))
 {
 	return spl_clamp_ux_dy(arg.value, 0, 10, 1);
 }
 
-int spl_fixpt_s4d19(struct spl_fixed31_32 arg)
+int SPL_NAMESPACE(spl_fixpt_s4d19(struct spl_fixed31_32 arg))
 {
 	if (arg.value < 0)
 		return -(int)spl_ux_dy(spl_fixpt_abs(arg).value, 4, 19);
@@ -465,9 +467,9 @@ int spl_fixpt_s4d19(struct spl_fixed31_32 arg)
 		return spl_ux_dy(arg.value, 4, 19);
 }
 
-struct spl_fixed31_32 spl_fixpt_from_ux_dy(unsigned int value,
+struct spl_fixed31_32 SPL_NAMESPACE(spl_fixpt_from_ux_dy(unsigned int value,
 	unsigned int integer_bits,
-	unsigned int fractional_bits)
+	unsigned int fractional_bits))
 {
 	struct spl_fixed31_32 fixpt_value = spl_fixpt_zero;
 	struct spl_fixed31_32 fixpt_int_value = spl_fixpt_zero;
@@ -481,10 +483,10 @@ struct spl_fixed31_32 spl_fixpt_from_ux_dy(unsigned int value,
 	return fixpt_value;
 }
 
-struct spl_fixed31_32 spl_fixpt_from_int_dy(unsigned int int_value,
+struct spl_fixed31_32 SPL_NAMESPACE(spl_fixpt_from_int_dy(unsigned int int_value,
 	unsigned int frac_value,
 	unsigned int integer_bits,
-	unsigned int fractional_bits)
+	unsigned int fractional_bits))
 {
 	struct spl_fixed31_32 fixpt_value = spl_fixpt_from_int(int_value);
 
diff --git a/drivers/gpu/drm/amd/display/dc/sspl/spl_fixpt31_32.h b/drivers/gpu/drm/amd/display/dc/sspl/spl_fixpt31_32.h
index 9f349ffe9148..b0e639d6e97d 100644
--- a/drivers/gpu/drm/amd/display/dc/sspl/spl_fixpt31_32.h
+++ b/drivers/gpu/drm/amd/display/dc/sspl/spl_fixpt31_32.h
@@ -60,7 +60,8 @@ static const struct spl_fixed31_32 spl_fixpt_one = { 0x100000000LL };
  * @brief
  * result = numerator / denominator
  */
-struct spl_fixed31_32 spl_fixpt_from_fraction(long long numerator, long long denominator);
+struct spl_fixed31_32 SPL_NAMESPACE(spl_fixpt_from_fraction(
+	long long numerator, long long denominator));
 
 /*
  * @brief
@@ -280,7 +281,8 @@ static inline struct spl_fixed31_32 spl_fixpt_sub_int(struct spl_fixed31_32 arg1
  * @brief
  * result = arg1 * arg2
  */
-struct spl_fixed31_32 spl_fixpt_mul(struct spl_fixed31_32 arg1, struct spl_fixed31_32 arg2);
+struct spl_fixed31_32 SPL_NAMESPACE(spl_fixpt_mul(
+	struct spl_fixed31_32 arg1, struct spl_fixed31_32 arg2));
 
 
 /*
@@ -289,14 +291,14 @@ struct spl_fixed31_32 spl_fixpt_mul(struct spl_fixed31_32 arg1, struct spl_fixed
  */
 static inline struct spl_fixed31_32 spl_fixpt_mul_int(struct spl_fixed31_32 arg1, int arg2)
 {
-	return spl_fixpt_mul(arg1, spl_fixpt_from_int(arg2));
+	return SPL_NAMESPACE(spl_fixpt_mul(arg1, spl_fixpt_from_int(arg2)));
 }
 
 /*
  * @brief
  * result = square(arg) := arg * arg
  */
-struct spl_fixed31_32 spl_fixpt_sqr(struct spl_fixed31_32 arg);
+struct spl_fixed31_32 SPL_NAMESPACE(spl_fixpt_sqr(struct spl_fixed31_32 arg));
 
 /*
  * @brief
@@ -304,7 +306,8 @@ struct spl_fixed31_32 spl_fixpt_sqr(struct spl_fixed31_32 arg);
  */
 static inline struct spl_fixed31_32 spl_fixpt_div_int(struct spl_fixed31_32 arg1, long long arg2)
 {
-	return spl_fixpt_from_fraction(arg1.value, spl_fixpt_from_int((int)arg2).value);
+	return SPL_NAMESPACE(spl_fixpt_from_fraction(arg1.value,
+		spl_fixpt_from_int((int)arg2).value));
 }
 
 /*
@@ -313,7 +316,7 @@ static inline struct spl_fixed31_32 spl_fixpt_div_int(struct spl_fixed31_32 arg1
  */
 static inline struct spl_fixed31_32 spl_fixpt_div(struct spl_fixed31_32 arg1, struct spl_fixed31_32 arg2)
 {
-	return spl_fixpt_from_fraction(arg1.value, arg2.value);
+	return SPL_NAMESPACE(spl_fixpt_from_fraction(arg1.value, arg2.value));
 }
 
 /*
@@ -328,7 +331,7 @@ static inline struct spl_fixed31_32 spl_fixpt_div(struct spl_fixed31_32 arg1, st
  * @note
  * No special actions taken in case argument is zero.
  */
-struct spl_fixed31_32 spl_fixpt_recip(struct spl_fixed31_32 arg);
+struct spl_fixed31_32 SPL_NAMESPACE(spl_fixpt_recip(struct spl_fixed31_32 arg));
 
 /*
  * @brief
@@ -343,7 +346,7 @@ struct spl_fixed31_32 spl_fixpt_recip(struct spl_fixed31_32 arg);
  * Argument specified in radians,
  * internally it's normalized to [-2pi...2pi] range.
  */
-struct spl_fixed31_32 spl_fixpt_sinc(struct spl_fixed31_32 arg);
+struct spl_fixed31_32 SPL_NAMESPACE(spl_fixpt_sinc(struct spl_fixed31_32 arg));
 
 /*
  * @brief
@@ -353,7 +356,7 @@ struct spl_fixed31_32 spl_fixpt_sinc(struct spl_fixed31_32 arg);
  * Argument specified in radians,
  * internally it's normalized to [-2pi...2pi] range.
  */
-struct spl_fixed31_32 spl_fixpt_sin(struct spl_fixed31_32 arg);
+struct spl_fixed31_32 SPL_NAMESPACE(spl_fixpt_sin(struct spl_fixed31_32 arg));
 
 /*
  * @brief
@@ -365,7 +368,7 @@ struct spl_fixed31_32 spl_fixpt_sin(struct spl_fixed31_32 arg);
  * passing arguments outside that range
  * will cause incorrect result!
  */
-struct spl_fixed31_32 spl_fixpt_cos(struct spl_fixed31_32 arg);
+struct spl_fixed31_32 SPL_NAMESPACE(spl_fixpt_cos(struct spl_fixed31_32 arg));
 
 /*
  * @brief
@@ -379,7 +382,7 @@ struct spl_fixed31_32 spl_fixpt_cos(struct spl_fixed31_32 arg);
  * @note
  * Currently, function is verified for abs(arg) <= 1.
  */
-struct spl_fixed31_32 spl_fixpt_exp(struct spl_fixed31_32 arg);
+struct spl_fixed31_32 SPL_NAMESPACE(spl_fixpt_exp(struct spl_fixed31_32 arg));
 
 /*
  * @brief
@@ -391,7 +394,7 @@ struct spl_fixed31_32 spl_fixpt_exp(struct spl_fixed31_32 arg);
  * Currently, no special actions taken
  * in case of invalid argument(s). Take care!
  */
-struct spl_fixed31_32 spl_fixpt_log(struct spl_fixed31_32 arg);
+struct spl_fixed31_32 SPL_NAMESPACE(spl_fixpt_log(struct spl_fixed31_32 arg));
 
 /*
  * @brief
@@ -410,10 +413,10 @@ static inline struct spl_fixed31_32 spl_fixpt_pow(struct spl_fixed31_32 arg1, st
 	if (arg1.value == 0)
 		return arg2.value == 0 ? spl_fixpt_one : spl_fixpt_zero;
 
-	return spl_fixpt_exp(
-		spl_fixpt_mul(
-			spl_fixpt_log(arg1),
-			arg2));
+	return SPL_NAMESPACE(spl_fixpt_exp(
+		SPL_NAMESPACE(spl_fixpt_mul(
+			SPL_NAMESPACE(spl_fixpt_log(arg1)),
+			arg2))));
 }
 
 /*
@@ -482,19 +485,19 @@ static inline int spl_fixpt_ceil(struct spl_fixed31_32 arg)
  * fractional
  */
 
-unsigned int spl_fixpt_u4d19(struct spl_fixed31_32 arg);
+unsigned int SPL_NAMESPACE(spl_fixpt_u4d19(struct spl_fixed31_32 arg));
 
-unsigned int spl_fixpt_u3d19(struct spl_fixed31_32 arg);
+unsigned int SPL_NAMESPACE(spl_fixpt_u3d19(struct spl_fixed31_32 arg));
 
-unsigned int spl_fixpt_u2d19(struct spl_fixed31_32 arg);
+unsigned int SPL_NAMESPACE(spl_fixpt_u2d19(struct spl_fixed31_32 arg));
 
-unsigned int spl_fixpt_u0d19(struct spl_fixed31_32 arg);
+unsigned int SPL_NAMESPACE(spl_fixpt_u0d19(struct spl_fixed31_32 arg));
 
-unsigned int spl_fixpt_clamp_u0d14(struct spl_fixed31_32 arg);
+unsigned int SPL_NAMESPACE(spl_fixpt_clamp_u0d14(struct spl_fixed31_32 arg));
 
-unsigned int spl_fixpt_clamp_u0d10(struct spl_fixed31_32 arg);
+unsigned int SPL_NAMESPACE(spl_fixpt_clamp_u0d10(struct spl_fixed31_32 arg));
 
-int spl_fixpt_s4d19(struct spl_fixed31_32 arg);
+int SPL_NAMESPACE(spl_fixpt_s4d19(struct spl_fixed31_32 arg));
 
 static inline struct spl_fixed31_32 spl_fixpt_truncate(struct spl_fixed31_32 arg, unsigned int frac_bits)
 {
@@ -513,10 +516,11 @@ static inline struct spl_fixed31_32 spl_fixpt_truncate(struct spl_fixed31_32 arg
 	return arg;
 }
 
-struct spl_fixed31_32 spl_fixpt_from_ux_dy(unsigned int value, unsigned int integer_bits, unsigned int fractional_bits);
-struct spl_fixed31_32 spl_fixpt_from_int_dy(unsigned int int_value,
+struct spl_fixed31_32 SPL_NAMESPACE(spl_fixpt_from_ux_dy(unsigned int value,
+		unsigned int integer_bits, unsigned int fractional_bits));
+struct spl_fixed31_32 SPL_NAMESPACE(spl_fixpt_from_int_dy(unsigned int int_value,
 		unsigned int frac_value,
 		unsigned int integer_bits,
-		unsigned int fractional_bits);
+		unsigned int fractional_bits));
 
 #endif
diff --git a/drivers/gpu/drm/amd/display/dc/sspl/spl_os_types.h b/drivers/gpu/drm/amd/display/dc/sspl/spl_os_types.h
index 2e6ba71960ac..ae2d24c856cf 100644
--- a/drivers/gpu/drm/amd/display/dc/sspl/spl_os_types.h
+++ b/drivers/gpu/drm/amd/display/dc/sspl/spl_os_types.h
@@ -53,4 +53,13 @@ static inline int64_t spl_div64_s64(int64_t dividend, int64_t divisor)
 #define spl_min(a, b)    (((a) < (b)) ? (a):(b))
 #endif
 
+/* SPL namespace macros */
+#ifndef SPL_PFX_
+#define SPL_PFX_
+#endif
+
+#define SPL_EXPAND2(a, b)         a##b
+#define SPL_EXPAND(a, b)          SPL_EXPAND2(a, b)
+#define SPL_NAMESPACE(symbol)     SPL_EXPAND(SPL_PFX_, symbol)
+
 #endif /* _SPL_OS_TYPES_H_ */
-- 
2.34.1

