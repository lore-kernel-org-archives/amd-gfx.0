Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 361D0C433F5
	for <amd-gfx@archiver.kernel.org>; Fri, 26 Nov 2021 19:49:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E5ABD6E984;
	Fri, 26 Nov 2021 19:49:48 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam08on2070.outbound.protection.outlook.com [40.107.102.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 82ECA6E950
 for <amd-gfx@lists.freedesktop.org>; Fri, 26 Nov 2021 19:49:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k6JruZdDg7Kn5T8Y9g126dxRNGe3jEal3fNF5ToqAjHmD9lL0zys6tYMQSywflAHhmHaT0mrL+IcAC0ug1kL5daCjIG0XgAzQGn2ZJH7ucH6+kNf1Ly7gLzv3WxPh3hb8LOYmQK1zk9TCQRPcGYr4ympWi7TMLRL1udSN3dsZ/IFUiCg+MRUlRcmGdnx59UmPA0dJr5EiDVUU9QI6J3G4Q0SSXG8dsKPQKeB5gHQ+8kLUE7XTBmkv2utI1dNt7wlO3K6TZW4n7scMzx+j0Ow0VVH3oxeXUBUxlUi2oBK/Jk2HPmZMs4e1DJ4sLMdtK9Ro9CyLkUiB0zsaFuLitSG7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gqJOhEoLO3k/uthjk+8EUSCPR7VDlzYCiYVBZTzZEzc=;
 b=KiuSUaU+GSd1Pe+X7k6yjdTfS1BogNGkkXhUX3TlzYS9RpSqE52el5OBWfRADPjK7S0wxa/4QomSUfwV4yCqOs9OKx6s7VJczZ7tJdJk7dsaKIBoaz675I6W0IjU1NHg2wTRRALkZKnsuKm/JB9uKy6NMSt04iG3RUpAVh+E/TMH3ioheu7QJdFHVbU9QCFesC8wIeBvYeD6L+koHTUuGkkil8hYb6vXbW97T3RzpUeUoXnCKJMAXjv4NHy6UlrbHSyqKJ6xw514F5oTAdW3x6gZcW9uxAJYUwEB6yDcvppZEUsXPxji9M/pqhJu3wgfF6Z8u/Rb7zdDYC8EIq3o4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gqJOhEoLO3k/uthjk+8EUSCPR7VDlzYCiYVBZTzZEzc=;
 b=H5+TTZBjyusugt3TOurCS0rytA1Mny0ZheJAzuOGIWY1Rbnzc+RAIZkI1y16+kVY4EhE8gZ+BXvi0qCSVEjJDvfgA/W17z2HGKd2BBBYinT60IhVWbjeHEuijUtQsUq8KE6fUEVyuds2ZdQriAgykk4Z4UJkDKJiEEol4PlyArI=
Received: from BN6PR19CA0113.namprd19.prod.outlook.com (2603:10b6:404:a0::27)
 by MN2PR12MB3071.namprd12.prod.outlook.com (2603:10b6:208:cc::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.23; Fri, 26 Nov
 2021 19:49:40 +0000
Received: from BN8NAM11FT024.eop-nam11.prod.protection.outlook.com
 (2603:10b6:404:a0:cafe::8e) by BN6PR19CA0113.outlook.office365.com
 (2603:10b6:404:a0::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.22 via Frontend
 Transport; Fri, 26 Nov 2021 19:49:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT024.mail.protection.outlook.com (10.13.177.38) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4734.22 via Frontend Transport; Fri, 26 Nov 2021 19:49:39 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Fri, 26 Nov
 2021 13:49:35 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Fri, 26 Nov
 2021 11:49:34 -0800
Received: from blakha.ht.home (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.17 via Frontend
 Transport; Fri, 26 Nov 2021 13:49:33 -0600
From: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 08/16] drm/amd/display: Add work around for tunneled MST.
Date: Fri, 26 Nov 2021 14:49:14 -0500
Message-ID: <20211126194922.816835-9-Bhawanpreet.Lakha@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211126194922.816835-1-Bhawanpreet.Lakha@amd.com>
References: <20211126194922.816835-1-Bhawanpreet.Lakha@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5c281360-457b-41b8-d05c-08d9b115e292
X-MS-TrafficTypeDiagnostic: MN2PR12MB3071:
X-Microsoft-Antispam-PRVS: <MN2PR12MB3071F6C141DA753E65CE9DA3F9639@MN2PR12MB3071.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jP/yrHwgjiCI2NyatPYZy699hTpANGDJBb/WX8wFl8kia0I7w/Qz8gfpcXE8BPlUxMSUIhuX9PxJRilPGXqWGW5MkBJTX6WwjucgvQ4ISloLv9fyf2VZ9pHEGoKVYmOIKxibbfWTr0TCXRzPWiIkG5uIkDrVPIV1zFfSDgABqUgSeIkmh7KXGTqRdWQL4AtCXMxTN/w/oyzDHAg6qXfsGM5e0+20u882XBVzVJOcw8QtHy1PVQHS90T7QSDFcqVzzWKYXpmuaM883tM4MvztA3buVtaEVr/MsAWi/2msFSjf6AShP7G6KlEHy4neRtleGmfLltPIgNNq7VdI9gL2QAJpbloUg+Iwd2GCs76MWqw/mJ5S7tCY4ydO/dF7nhWnpS3t+11DUvXfJ61hvokkEZcbvGucNQVz5+sRyEJgfdVt+l0AR+gXD47XlS83pV+xKoVMA9sjUMaWa9ywCZvvWbcG1j2WvAMWEHTq85FcqRkpMjFcQkCCt2ooxr2zYmNY812giP5StTm1bJaBMCLg/2felIOaKQTm7SMS58yihofJ3mpmiOX+WmKYK82SkQvQEbRvpl/6s/HujY2/U+fzBDaBC4UXKzHA8Xn5Ps/oTVX6cO/g4jYOAUn30uK6msJ3JSJqW6D5UOM8z+ElHpRkeODTDhWUj4aWHTopLSyF2sCvDXR3raLKjvK1SLzBkLgOZbaDofSgA/1emxJq6yFPT+PzJep+VyyYswlM28/QglY=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(316002)(6916009)(36756003)(336012)(1076003)(4326008)(356005)(36860700001)(508600001)(5660300002)(70206006)(2616005)(54906003)(81166007)(426003)(83380400001)(47076005)(8936002)(8676002)(186003)(82310400004)(26005)(2906002)(6666004)(86362001)(70586007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2021 19:49:39.8630 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c281360-457b-41b8-d05c-08d9b115e292
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT024.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3071
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
Cc: stylon.wang@amd.com, Aric Cyr <Aric.Cyr@amd.com>, Jun Lei <Jun.Lei@amd.com>,
 solomon.chiu@amd.com, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com, roman.li@amd.com,
 Anson.Jacob@amd.com, Aurabindo.Pillai@amd.com,
 Jimmy Kizito <Jimmy.Kizito@amd.com>, wayne.lin@amd.com, mikita.lipski@amd.com,
 Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Jimmy Kizito <Jimmy.Kizito@amd.com>

[Why]
Certain USB4 docks do not seem to be able to handle disabling
DSC once it has been enabled on an MST stream. This can result
in blank displays.

[How]
As a work around, always enable DSC on docks exhibiting this issue. The
flag to indicate the use of DSC for MST streams on a USB4 dock is set
during detection of the dock and only cleared when the USB4 dock is
disconnected.

Reviewed-by: Jun Lei <Jun.Lei@amd.com>
Reviewed-by: Aric Cyr <Aric.Cyr@amd.com>
Acked-by: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
Signed-off-by: Jimmy Kizito <Jimmy.Kizito@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc_link.c | 16 +++++++++++++++
 .../gpu/drm/amd/display/dc/core/dc_resource.c | 20 +++++++++----------
 drivers/gpu/drm/amd/display/dc/dc.h           |  3 ++-
 drivers/gpu/drm/amd/display/dc/dc_link.h      |  2 ++
 4 files changed, 30 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link.c b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
index 3d08f8eba402..faa0bc308fc8 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
@@ -758,6 +758,18 @@ static bool detect_dp(struct dc_link *link,
 			dal_ddc_service_set_transaction_type(link->ddc,
 							     sink_caps->transaction_type);
 
+#if defined(CONFIG_DRM_AMD_DC_DCN)
+			/* Apply work around for tunneled MST on certain USB4 docks. Always use DSC if dock
+			 * reports DSC support.
+			 */
+			if (link->ep_type == DISPLAY_ENDPOINT_USB4_DPIA &&
+					link->type == dc_connection_mst_branch &&
+					link->dpcd_caps.branch_dev_id == DP_BRANCH_DEVICE_ID_90CC24 &&
+					link->dpcd_caps.dsc_caps.dsc_basic_caps.fields.dsc_support.DSC_SUPPORT &&
+					!link->dc->debug.dpia_debug.bits.disable_mst_dsc_work_around)
+				link->wa_flags.dpia_mst_dsc_always_on = true;
+#endif
+
 #if defined(CONFIG_DRM_AMD_DC_HDCP)
 			/* In case of fallback to SST when topology discovery below fails
 			 * HDCP caps will be querried again later by the upper layer (caller
@@ -1203,6 +1215,10 @@ static bool dc_link_detect_helper(struct dc_link *link,
 			LINK_INFO("link=%d, mst branch is now Disconnected\n",
 				  link->link_index);
 
+			/* Disable work around which keeps DSC on for tunneled MST on certain USB4 docks. */
+			if (link->ep_type == DISPLAY_ENDPOINT_USB4_DPIA)
+				link->wa_flags.dpia_mst_dsc_always_on = false;
+
 			dm_helpers_dp_mst_stop_top_mgr(link->ctx, link);
 
 			link->mst_stream_alloc_table.stream_count = 0;
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
index a2cf35a7ccaa..0da692c9a543 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
@@ -2258,16 +2258,6 @@ enum dc_status dc_validate_global_state(
 
 	if (!new_ctx)
 		return DC_ERROR_UNEXPECTED;
-#if defined(CONFIG_DRM_AMD_DC_DCN)
-
-	/*
-	 * Update link encoder to stream assignment.
-	 * TODO: Split out reason allocation from validation.
-	 */
-	if (dc->res_pool->funcs->link_encs_assign && fast_validate == false)
-		dc->res_pool->funcs->link_encs_assign(
-			dc, new_ctx, new_ctx->streams, new_ctx->stream_count);
-#endif
 
 	if (dc->res_pool->funcs->validate_global) {
 		result = dc->res_pool->funcs->validate_global(dc, new_ctx);
@@ -2319,6 +2309,16 @@ enum dc_status dc_validate_global_state(
 		if (!dc->res_pool->funcs->validate_bandwidth(dc, new_ctx, fast_validate))
 			result = DC_FAIL_BANDWIDTH_VALIDATE;
 
+#if defined(CONFIG_DRM_AMD_DC_DCN)
+	/*
+	 * Only update link encoder to stream assignment after bandwidth validation passed.
+	 * TODO: Split out assignment and validation.
+	 */
+	if (result == DC_OK && dc->res_pool->funcs->link_encs_assign && fast_validate == false)
+		dc->res_pool->funcs->link_encs_assign(
+			dc, new_ctx, new_ctx->streams, new_ctx->stream_count);
+#endif
+
 	return result;
 }
 
diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index 90baef199c12..1738556c9b59 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -510,7 +510,8 @@ union dpia_debug_options {
 		uint32_t disable_dpia:1;
 		uint32_t force_non_lttpr:1;
 		uint32_t extend_aux_rd_interval:1;
-		uint32_t reserved:29;
+		uint32_t disable_mst_dsc_work_around:1;
+		uint32_t reserved:28;
 	} bits;
 	uint32_t raw;
 };
diff --git a/drivers/gpu/drm/amd/display/dc/dc_link.h b/drivers/gpu/drm/amd/display/dc/dc_link.h
index d449e72a4e2a..30822aa33931 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_link.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_link.h
@@ -192,6 +192,8 @@ struct dc_link {
 		bool dp_skip_DID2;
 		bool dp_skip_reset_segment;
 		bool dp_mot_reset_segment;
+		/* Some USB4 docks do not handle turning off MST DSC once it has been enabled. */
+		bool dpia_mst_dsc_always_on;
 	} wa_flags;
 	struct link_mst_stream_allocation_table mst_stream_alloc_table;
 
-- 
2.25.1

