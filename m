Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D22CC41513
	for <amd-gfx@archiver.kernel.org>; Wed,  8 May 2024 17:19:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B0469112905;
	Wed,  8 May 2024 17:19:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="fgr2hf3X";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2045.outbound.protection.outlook.com [40.107.220.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 09B3C113127
 for <amd-gfx@lists.freedesktop.org>; Wed,  8 May 2024 17:19:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eRfWQMg3pi12xgltZX7sTABSwTkpDib1ZJx/OKvra5yKITL0D69mXXuBS5QiHvhaHbWEGZmIiPHafu2oPvf0w5NjqJwn2AImbwkVR2odhUde+wd5rgC46Eid8A3mYjXBfjAG1cW8Yj/jbp1TOw9L1t3cvjC/vYbnFqpi4oQuHxdIVHckAb7fiBgDC0CXRjTweD2PZwkJTrog7sJMm9WizjRhTcKiMUzwh86IDqEoUZ6fgK9j518t1/7JKFerXWK5vdKvt6Y5IGRxeYF7ednBHB1fxCbzAWQnQQvW6PpfA2L2C7rPHuS+1bjiXHY45HneEDYeRT4HMbFtUEg3n9l44A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8cf8HeWRk+24Y+uhEjfTRas3OUDU6zkN4DxUneBSZIk=;
 b=mVOA6+UZEp0YVNCF6lOrSy8sXZEUGFmRkCGG5D7noiwnux1lddACh+x37oRMvkggoLbwM2j1SDKazJINO7hhlan4Az+3TMR1h5iz+7ZPlI9qIQgx1miDckZW8HCrMAYsp0w0gJXGL7Hsg8jvhxl+YJlU2lC+qJg9GWgE+pvg8KNYF//q0obgUQLwzMzrTcvGCu2frvdkzWHACMAb1+F6SCvbm0PYWwdB+OQVYTSeTxk3BqHPsNd76UR6vQuD9VGu5c1rn5GibaLCmsisP6/lIDYVW0bBcdzE9s9tV85bEi0Nhupy6FFAKhuiizAzVQxs36CVjg6TpmUwS0VHNfyDsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8cf8HeWRk+24Y+uhEjfTRas3OUDU6zkN4DxUneBSZIk=;
 b=fgr2hf3XpLK2Bs68MtS4phv31FMcatpHmk+NWRfIfQy1lUYy1qdLBsv9Ksv25BtlWzIy+g+2E+VwYkTGgQkh0Wmgi2yDYHkBnv5rEv0DA68uz67zXzQwGzutQD58kd9vONB+cfMW3JeDK4BdiRBMUKsNAbA3wr/Y4P7XWb4Wa/4=
Received: from MN2PR03CA0006.namprd03.prod.outlook.com (2603:10b6:208:23a::11)
 by CYYPR12MB8856.namprd12.prod.outlook.com (2603:10b6:930:c0::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.45; Wed, 8 May
 2024 17:19:03 +0000
Received: from BN3PEPF0000B36E.namprd21.prod.outlook.com
 (2603:10b6:208:23a:cafe::21) by MN2PR03CA0006.outlook.office365.com
 (2603:10b6:208:23a::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.43 via Frontend
 Transport; Wed, 8 May 2024 17:19:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B36E.mail.protection.outlook.com (10.167.243.165) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7587.0 via Frontend Transport; Wed, 8 May 2024 17:19:03 +0000
Received: from dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 8 May
 2024 12:19:01 -0500
From: Alex Hung <alex.hung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <hersenxs.wu@amd.com>, <jerry.zuo@amd.com>, Ethan Bitnun <etbitnun@amd.com>,
 Alvin Lee <alvin.lee2@amd.com>, Alex Hung <alex.hung@amd.com>
Subject: [PATCH 18/20] drm/amd/display: Find max flickerless instant vtotal
 delta
Date: Wed, 8 May 2024 11:13:18 -0600
Message-ID: <20240508171320.3292065-19-alex.hung@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240508171320.3292065-1-alex.hung@amd.com>
References: <20240508171320.3292065-1-alex.hung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B36E:EE_|CYYPR12MB8856:EE_
X-MS-Office365-Filtering-Correlation-Id: 0db0dc9a-2a91-413a-e74c-08dc6f82f546
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|82310400017|1800799015|36860700004|376005; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?uMr9cB3ln8gdaqbrwzqt5oppCfTNhHtX0Ssdilqqe++j0y060Ik/X1znv/vS?=
 =?us-ascii?Q?ECp8ElaVa5jP39ogW8v0c9BtKK4g5IhlTQJFN5Ti0JTw/rceI6TKjJidoOJD?=
 =?us-ascii?Q?SixbUaUfkV8VsAj68aolacwEiC1lUiHFH6ZaaTQWkZUDTnQ2t7PUUjem59hv?=
 =?us-ascii?Q?j7U21++AEWkxDLH62HlLKHS0KMoh6LJE3MuQxs73/XJxLOxKEAe7DRyTrPcM?=
 =?us-ascii?Q?XNTCljttf60JJ49e3zLB8MJD8CFw9QwGoE8GjFY6XIdFyuQ0pRySkNiYpeTp?=
 =?us-ascii?Q?sExAmkEQaaBWrAZi73arXbX3MF9BRSawoQ9C/aLb4aoOIaZPRGKM5L7iBfmV?=
 =?us-ascii?Q?w8trkDlWipw1DLbcOH/881bFKfFh9tvNM8zp919qDhPIurkC872vhlx1i2yZ?=
 =?us-ascii?Q?/npDdNeUSMJ10d3oXCF2Nt9blZF+cifq5KUpY+RgFv65vDPni8vMwJt92cCH?=
 =?us-ascii?Q?Un+Pkl543sqntCDi+iG+Hm130EpxmWx92AzstoR0qr1cY4pmQdB9QCir5gdf?=
 =?us-ascii?Q?2nXfyGDlJquf0utZVied5Z4N/zeq9/gsvtlm0k9Ok1kjgZu9/BUN6iEwr227?=
 =?us-ascii?Q?kc/BcMQkJcebVVfRisX8ayoB6dI7j152ESAJZOAN4DhXQoy4T+NX4ttAKVWG?=
 =?us-ascii?Q?VotPb0HlKCG8JWgi7kBVsIDWufwvYF8WSLEkB990bx7l2Cae5+FLu9BybPgT?=
 =?us-ascii?Q?OHYzpYkUrjwcIokLosHKHUQvLdMhETMMNfintSRhTtEV7esKU2GcHH36AbVu?=
 =?us-ascii?Q?N+Sz66tu5FoJYZ81guB4cxTO6gqOsZ3JHZnYdRgnQDmqi8IZXywcj6Yb17Yd?=
 =?us-ascii?Q?NsCv9kygE8iusm+di7unEsRpIiqtYZkSRQgwfb8u6K9nT0qCZw26v8NZLUv9?=
 =?us-ascii?Q?+W+NH4Pe6xRD2Ie0KGYh36G2BIsT5vPF0bSNP24A5vnwVtIl74Lw+k5tZBjv?=
 =?us-ascii?Q?Hblmd6R9R5XayKKqmCdVViw8uNo27WbHYMKS58Rwpoyn2r2a5jchI/fMelZ0?=
 =?us-ascii?Q?RWwaXpe99qCPxMrl149ptPKXWTHkQwC4iz6ibL4CLJ0dGirStzyrc/nn0jZv?=
 =?us-ascii?Q?oGBQm3cBRRq0X2xl2gdUfw6d9wWB4hdvWjqS4MRAbpW52vpIOqOPLfgeJ4u1?=
 =?us-ascii?Q?LTthZmbZarxa0sFz85Icjsw7IGhZ0Wo1RdVaeMTts3uW337ruIRoRgsni5jB?=
 =?us-ascii?Q?oyKnAR5BMxtkFo8gbFTyvB/q8OGF21Qk93LySO3oYoFmj1BWC2oxpkttGjwf?=
 =?us-ascii?Q?XnLs0nZgBl5UqLiVlkB7h41TLx3AWqYSh108JFZEdrhFskK3KohmkxXWU2G+?=
 =?us-ascii?Q?9ZICLZRjgvuJsXRrX+qSNN18AdEKUsGmmy0X3csUJJa8G0NCtYuQWdfpEUvs?=
 =?us-ascii?Q?c2nAe9i5NiqDmhTnHAjM+t0HREw5?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(82310400017)(1800799015)(36860700004)(376005); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2024 17:19:03.0795 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0db0dc9a-2a91-413a-e74c-08dc6f82f546
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B36E.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8856
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

From: Ethan Bitnun <etbitnun@amd.com>

[WHAT & HOW]
 - Populate dml 2 callback with get_max_flickerless_instant_vtotal_increase
 - Use long long when necessary to prevent overflow
 - Add asic specific default values, currently disabled by
   default for every asic
 - Use the pre-existing debug option to protect the call to
   get_max_flickerless_instant_vtotal_increase

Reviewed-by: Alvin Lee <alvin.lee2@amd.com>
Acked-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Ethan Bitnun <etbitnun@amd.com>
---
 .../gpu/drm/amd/display/dc/core/dc_resource.c |  3 +
 .../gpu/drm/amd/display/dc/core/dc_stream.c   | 64 +++++++++++++++++--
 .../gpu/drm/amd/display/dc/dc_stream_priv.h   | 14 ++++
 .../display/dc/dcn32/dcn32_resource_helpers.c |  2 +-
 .../drm/amd/display/dc/dml2/dml2_wrapper.h    |  3 +
 5 files changed, 79 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
index 8a5cc8b80217..70c39eef99e5 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
@@ -43,6 +43,8 @@
 #include "link.h"
 #include "clk_mgr.h"
 #include "dc_state_priv.h"
+#include "dc_stream_priv.h"
+
 #include "virtual/virtual_link_hwss.h"
 #include "link/hwss/link_hwss_dio.h"
 #include "link/hwss/link_hwss_dpia.h"
@@ -5195,6 +5197,7 @@ void resource_init_common_dml2_callbacks(struct dc *dc, struct dml2_configuratio
 	dml2_options->callbacks.get_dpp_pipes_for_plane = &resource_get_dpp_pipes_for_plane;
 	dml2_options->callbacks.get_stream_status = &dc_state_get_stream_status;
 	dml2_options->callbacks.get_stream_from_id = &dc_state_get_stream_from_id;
+	dml2_options->callbacks.get_max_flickerless_instant_vtotal_increase = &dc_stream_get_max_flickerless_instant_vtotal_increase;
 
 	dml2_options->svp_pstate.callbacks.dc = dc;
 	dml2_options->svp_pstate.callbacks.add_phantom_plane = &dc_state_add_phantom_plane;
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_stream.c b/drivers/gpu/drm/amd/display/dc/core/dc_stream.c
index b5a89b587d86..de48084eac25 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_stream.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_stream.c
@@ -833,7 +833,7 @@ static int dc_stream_get_brightness_millinits_linear_interpolation (struct dc_st
 								     int index2,
 								     int refresh_hz)
 {
-	int slope = 0;
+	long long slope = 0;
 	if (stream->lumin_data.refresh_rate_hz[index2] != stream->lumin_data.refresh_rate_hz[index1]) {
 		slope = (stream->lumin_data.luminance_millinits[index2] - stream->lumin_data.luminance_millinits[index1]) /
 			    (stream->lumin_data.refresh_rate_hz[index2] - stream->lumin_data.refresh_rate_hz[index1]);
@@ -852,7 +852,7 @@ static int dc_stream_get_refresh_hz_linear_interpolation (struct dc_stream_state
 							   int index2,
 							   int brightness_millinits)
 {
-	int slope = 1;
+	long long slope = 1;
 	if (stream->lumin_data.refresh_rate_hz[index2] != stream->lumin_data.refresh_rate_hz[index1]) {
 		slope = (stream->lumin_data.luminance_millinits[index2] - stream->lumin_data.luminance_millinits[index1]) /
 				(stream->lumin_data.refresh_rate_hz[index2] - stream->lumin_data.refresh_rate_hz[index1]);
@@ -860,7 +860,7 @@ static int dc_stream_get_refresh_hz_linear_interpolation (struct dc_stream_state
 
 	int y_intercept = stream->lumin_data.luminance_millinits[index2] - slope * stream->lumin_data.refresh_rate_hz[index2];
 
-	return ((brightness_millinits - y_intercept) / slope);
+	return ((int)div64_s64((brightness_millinits - y_intercept), slope));
 }
 
 /*
@@ -884,8 +884,9 @@ static int dc_stream_get_brightness_millinits_from_refresh (struct dc_stream_sta
 }
 
 /*
- * Finds the lowest refresh rate that can be achieved
- * from starting_refresh_hz while staying within flicker criteria
+ * Finds the lowest/highest refresh rate (depending on search_for_max_increase)
+ * that can be achieved from starting_refresh_hz while staying
+ * within flicker criteria
  */
 static int dc_stream_calculate_flickerless_refresh_rate(struct dc_stream_state *stream,
 							 int current_brightness,
@@ -942,7 +943,7 @@ static int dc_stream_calculate_flickerless_refresh_rate(struct dc_stream_state *
 	}
 
 	if (search_for_max_increase)
-		return stream->lumin_data.refresh_rate_hz[LUMINANCE_DATA_TABLE_SIZE - 1];
+		return (int)div64_s64((long long)stream->timing.pix_clk_100hz*100, stream->timing.v_total*stream->timing.h_total);
 	else
 		return stream->lumin_data.refresh_rate_hz[0];
 }
@@ -982,6 +983,31 @@ static int dc_stream_get_max_delta_lumin_millinits(struct dc_stream_state *strea
 	return (max - min);
 }
 
+/*
+ * Determines the max flickerless instant vtotal delta for a stream.
+ * Determines vtotal increase/decrease based on the bool "increase"
+ */
+static unsigned int dc_stream_get_max_flickerless_instant_vtotal_delta(struct dc_stream_state *stream, bool is_gaming, bool increase)
+{
+	if (stream->timing.v_total * stream->timing.h_total == 0)
+		return 0;
+
+	int current_refresh_hz = (int)div64_s64((long long)stream->timing.pix_clk_100hz*100, stream->timing.v_total*stream->timing.h_total);
+
+	int safe_refresh_hz = dc_stream_calculate_flickerless_refresh_rate(stream,
+							 dc_stream_get_brightness_millinits_from_refresh(stream, current_refresh_hz),
+							 current_refresh_hz,
+							 is_gaming,
+							 increase);
+
+	int safe_refresh_v_total = (int)div64_s64((long long)stream->timing.pix_clk_100hz*100, safe_refresh_hz*stream->timing.h_total);
+
+	if (increase)
+		return ((stream->timing.v_total - safe_refresh_v_total) >= 0) ? (stream->timing.v_total - safe_refresh_v_total) : 0;
+
+	return ((safe_refresh_v_total - stream->timing.v_total) >= 0) ? (safe_refresh_v_total - stream->timing.v_total) : 0;
+}
+
 /*
  * Finds the highest refresh rate that can be achieved
  * from starting_refresh_hz while staying within flicker criteria
@@ -1038,3 +1064,29 @@ bool dc_stream_is_refresh_rate_range_flickerless(struct dc_stream_state *stream,
 
 	return (dl <= flicker_criteria_millinits);
 }
+
+/*
+ * Determines the max instant vtotal delta increase that can be applied without
+ * flickering for a given stream
+ */
+unsigned int dc_stream_get_max_flickerless_instant_vtotal_decrease(struct dc_stream_state *stream,
+									  bool is_gaming)
+{
+	if (!stream->lumin_data.is_valid)
+		return 0;
+
+	return dc_stream_get_max_flickerless_instant_vtotal_delta(stream, is_gaming, true);
+}
+
+/*
+ * Determines the max instant vtotal delta decrease that can be applied without
+ * flickering for a given stream
+ */
+unsigned int dc_stream_get_max_flickerless_instant_vtotal_increase(struct dc_stream_state *stream,
+									  bool is_gaming)
+{
+	if (!stream->lumin_data.is_valid)
+		return 0;
+
+	return dc_stream_get_max_flickerless_instant_vtotal_delta(stream, is_gaming, false);
+}
diff --git a/drivers/gpu/drm/amd/display/dc/dc_stream_priv.h b/drivers/gpu/drm/amd/display/dc/dc_stream_priv.h
index ea13804f7b14..ca37eac20986 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_stream_priv.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_stream_priv.h
@@ -58,4 +58,18 @@ bool dc_stream_is_refresh_rate_range_flickerless(struct dc_stream_state *stream,
 						  int hz2,
 						  bool is_gaming);
 
+/*
+ * Determines the max instant vtotal delta increase that can be applied without
+ * flickering for a given stream
+ */
+unsigned int dc_stream_get_max_flickerless_instant_vtotal_decrease(struct dc_stream_state *stream,
+									  bool is_gaming);
+
+/*
+ * Determines the max instant vtotal delta decrease that can be applied without
+ * flickering for a given stream
+ */
+unsigned int dc_stream_get_max_flickerless_instant_vtotal_increase(struct dc_stream_state *stream,
+									  bool is_gaming);
+
 #endif // _DC_STREAM_PRIV_H_
diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource_helpers.c b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource_helpers.c
index eba7bfc7e4af..d184105ce2b3 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource_helpers.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource_helpers.c
@@ -474,7 +474,7 @@ static bool is_refresh_rate_support_mclk_switch_using_fw_based_vblank_stretch(
 	if (refresh_rate_max_stretch_100hz < min_refresh_100hz)
 		return false;
 
-	if (fpo_candidate_stream->ctx->dc->config.enable_fpo_flicker_detection > 0 &&
+	if (fpo_candidate_stream->ctx->dc->config.enable_fpo_flicker_detection == 1 &&
 			!dc_stream_is_refresh_rate_range_flickerless(fpo_candidate_stream, (refresh_rate_max_stretch_100hz / 100), current_refresh_rate, false))
 		return false;
 
diff --git a/drivers/gpu/drm/amd/display/dc/dml2/dml2_wrapper.h b/drivers/gpu/drm/amd/display/dc/dml2/dml2_wrapper.h
index 4e4ed1678d91..dcb4e6f4d916 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2/dml2_wrapper.h
+++ b/drivers/gpu/drm/amd/display/dc/dml2/dml2_wrapper.h
@@ -104,6 +104,9 @@ struct dml2_dc_callbacks {
 		struct dc_state *state,
 		const struct dc_stream_state *stream);
 	struct dc_stream_state *(*get_stream_from_id)(const struct dc_state *state, unsigned int id);
+	unsigned int (*get_max_flickerless_instant_vtotal_increase)(
+			struct dc_stream_state *stream,
+			bool is_gaming);
 };
 
 struct dml2_dc_svp_callbacks {
-- 
2.34.1

