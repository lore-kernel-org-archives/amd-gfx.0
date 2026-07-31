Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C69EFC55172
	for <amd-gfx@archiver.kernel.org>; Fri, 31 Jul 2026 21:16:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 636D410F409;
	Fri, 31 Jul 2026 21:16:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="G5X5DAwP";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010003.outbound.protection.outlook.com [52.101.201.3])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 993D110F3E9
 for <amd-gfx@lists.freedesktop.org>; Fri, 31 Jul 2026 21:16:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=q7ZVwCE/sUMXXxe6qdGEsZHuI1sEOLWANgp9IAywfkw/NWYeqKt3iDiT1U48wybKM98A2tUb3DRaeAXaKb7e0gyu+4lEBX3vqfNLOO0Ci95IiMHIZ/NPa3A0H1AqC36wvaUpR6EVgZk2w3d4qZ3g24hqnqGLBX14UM/CzZHqBtWbfRnr5G9rcngulnyg9YYN5heRJFJscbHzhJJWQqjFsax1ubfmKSbE7QmYDrcih0c71VJsSiefRnV+8fHNIfdUnkl6V9r+wUN5jhyBzWYTfskvGQMlrnWPh4XLL+wJT2xkuXkmaWFgFz7to/e/2Paqss+yH45tcnvBmhdoDpyAWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DJGEXYVkjKAqqhWy6gXgHAf7bPK0mMRkrO/t9v2TokY=;
 b=EkLqLUQ4bw1FoPlohHF4SuuWFLL02XEYgg7hbG7S/7Ys7nfAPkLeYHb1RODLm9nwss6Ukuv7/hUjoNuRQkHoF+40L1dhjTPR02KOznpLN9v+QCI1QURDsGFJiW3JCzz7U1LfkDY4wISuRg8CIkQQclz1UFUEjI+GevmX4dGSt/NA5nT/m56GQu9rFvBJHkof1Qv5XCzBLFjozfccNALsUn60QNOUcfgZD9oTRZs1B8n4bbjcYN1SP/7aFNPw6PLt98pE80TbEu9NFMoY5wWQfZc0xotUnoL4Gyf9ljjW+j7UK7Ly7t10LSYFCEqfDCnSZzKSugvepnYYnGaGkRi2aw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DJGEXYVkjKAqqhWy6gXgHAf7bPK0mMRkrO/t9v2TokY=;
 b=G5X5DAwPrE180Hyla1Opxy04eQzvgLTAbVk54wiNTBdJIIo8SxNKsT6Lyvk985BuPBWBzquZI/7tYG/OG+s+M42cFV11Hdhxn80NvfhjFi96NAr7uy6+h5CXCI9YHtPjHQHtugpH2hESECndOggkQAhFlKj3dnNr1Sq/DY5p76c=
Received: from CH0PR03CA0217.namprd03.prod.outlook.com (2603:10b6:610:e7::12)
 by MW3PR12MB4380.namprd12.prod.outlook.com (2603:10b6:303:5a::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.16; Fri, 31 Jul
 2026 21:16:00 +0000
Received: from CH2PEPF0000013C.namprd02.prod.outlook.com
 (2603:10b6:610:e7:cafe::16) by CH0PR03CA0217.outlook.office365.com
 (2603:10b6:610:e7::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.270.16 via Frontend Transport; Fri,
 31 Jul 2026 21:16:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CH2PEPF0000013C.mail.protection.outlook.com (10.167.244.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.292.8 via Frontend Transport; Fri, 31 Jul 2026 21:16:00 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Fri, 31 Jul
 2026 16:16:00 -0500
Received: from roman-vdev.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Fri, 31 Jul 2026 16:15:59 -0500
From: <Roman.Li@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Taimur Hassan <Syed.Hassan@amd.com>
Subject: [PATCH 32/41] drm/amd/display: Add missing DMUB CACP and PR
 definitions
Date: Fri, 31 Jul 2026 17:12:53 -0400
Message-ID: <20260731211302.3040343-33-Roman.Li@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260731211302.3040343-1-Roman.Li@amd.com>
References: <20260731211302.3040343-1-Roman.Li@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000013C:EE_|MW3PR12MB4380:EE_
X-MS-Office365-Filtering-Correlation-Id: 8d7057b2-0308-47e8-23e8-08deef48ebc0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700016|23010399003|1800799024|56012099006|11063799006|10067099003|3023799007|6133799003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: 6OqUsmWWnys+hoz31XkJ55EG9QWBNWpgLodmwy8i+FofA/T7LugY0nbj1euI72pI6HT0kfW+94Tb74KlIotB9EVp3e99DY3w+1kF8L6/kEO3fDgRYn6yfCldlJjL/cSBhAXPYoODC0vI5ZqI1e8gwJm3vTlULgekw1FKfKxrwbpWvXhnTYMaiL57SMwwSPcVJ/R7u+ppNYpjJF+4Wnf/YeoyT3xyLrGwms9moNkHR++PrqmMRI9A1giyNQKRTEgTIGqV16WBrhq0AZk3fb5zxYgJebUZIilRRmAEg/+ve7P/JaqtfWJnwhj6CVqH3f/nbVXkmY36tqqCXU+ROXMZ25wkNQRh2faF90TmYnP7uI0TcT0+6LpcoFDUltu4h8OAkFMW2DqqvddAa2qBVeuEwQ4+6ik0C4SQZsESqHwi7hAY7nkf9+WKr+LbNAbQppm9yBgdVfy1zWMeM0KwGtXA+1SQuWjOHMx/ad+oqKVsctzpHI2i7WT7OnJ8OTT0/hVwqCVbXQqq+60+4yiALyAzGf76SN4sLkfILlQnsnIZ0Vii9i1/Fbo1S6esEZjHeHR9dywvOl6bxDq4eKZhDCjdMl7qBvyuJx/SnlBnTAj/x20u82WfC4i06rhtwNhSJF2ABwehpnti96niad4VQlWnY9Z4htX29qjjDqO92itOjUoEFq2ecWXOqou1ObSEdHyt9R/pTtdUnt9dGbYVPF1lHw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700016)(23010399003)(1800799024)(56012099006)(11063799006)(10067099003)(3023799007)(6133799003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: +X0gg2YoJYvgR1X8hkc2m3JYTlNVzvEF+rb5agJqdFYHrFPmNWAz0BbSXBD96Lqw04cHHG2TMX7RipRh8CvEnedrohIY+jXbdGq9C9qaU//hVJijjbwOmMvWkn6PjMJwhHe00OtyK8m/kgGBvdCMrRc4aCtt4LkTQqxYJqksCdGWgUanlqsvrlpkit08Hk3vS3bTfsRQYDa/zHbMKEc83M52vQVh+wYnRZhLrEhdBbB89x64Qi96CnkzFuduA7RymqMLMktd7YvVJL6/ebTpqjI8TclcMcxOsC3u95GfL3LHmXasWrCN1Kbzizo0XdEK3RFLqp1ErPWOL85KovB907jrXRpkXJ4bLjiijo2TI5w4wXxRch38bkfhuW9K+D53AScjQZCpVtSI4Mun+TRi6ycwgvcapDi1VIotTXj4in5PysP+A14TTJ7gr+g+TO49
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2026 21:16:00.4518 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d7057b2-0308-47e8-23e8-08deef48ebc0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF0000013C.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4380
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

From: Taimur Hassan <Syed.Hassan@amd.com>

[Why]
Should have been picked up in 0.1.69.0 promotion commit.

[How]
Add the missing DMUB command-header definitions in dmub_cmd.h:

1. DMUB_CMD__CACP_GET_ACE_CURVE_AREA command ID.
2. Request/response data and command structs.
3. PR runtime flag bit.

Signed-off-by: Taimur Hassan <Syed.Hassan@amd.com>
Signed-off-by: Roman Li <roman.li@amd.com>
Reviewed-by: Alex Hung <alex.hung@amd.com>
---
 .../gpu/drm/amd/display/dmub/inc/dmub_cmd.h   | 54 +++++++++++++++++++
 1 file changed, 54 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
index 44aefa3608ec..f0231f355fa7 100644
--- a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
+++ b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
@@ -6256,6 +6256,10 @@ enum dmub_cmd_cacp_type {
 	 * Get CACP Histogram
 	 */
 	DMUB_CMD__CACP_GET_HISTOGRAM = 7,
+	/**
+	 * Get ACE curve area for IGT test validation.
+	 */
+	DMUB_CMD__CACP_GET_ACE_CURVE_AREA = 8,
 };
 
 /**
@@ -6644,6 +6648,50 @@ struct dmub_rb_cmd_cacp_get_histogram {
 	uint8_t pad;
 };
 
+/**
+ * Data passed from driver to FW in a DMUB_CMD__CACP_GET_ACE_CURVE_AREA command.
+ */
+struct dmub_cmd_cacp_get_ace_curve_area_in {
+	/**
+	 * eDP panel instance (0-based).
+	 */
+	uint8_t panel_inst;
+	/**
+	 * Explicit padding to 4 byte boundary.
+	 */
+	uint8_t pad[3];
+};
+
+/**
+ * Data returned from FW in a DMUB_CMD__CACP_GET_ACE_CURVE_AREA command.
+ */
+struct dmub_cmd_cacp_get_ace_curve_area_out {
+	/**
+	 * Computed area under the ACE PWL curve (trapezoidal integration).
+	 * Lower value = stronger dimming (higher CACP level).
+	 * Directly comparable across levels.
+	 */
+	uint32_t area;
+};
+
+/**
+ * Definition of a DMUB_CMD__CACP_GET_ACE_CURVE_AREA command.
+ * Uses inline response pattern: input and output share the data union.
+ */
+struct dmub_rb_cmd_cacp_get_ace_curve_area {
+	/**
+	 * Command header.
+	 */
+	struct dmub_cmd_header header;
+	/**
+	 * Data union for input/output.
+	 */
+	union {
+		struct dmub_cmd_cacp_get_ace_curve_area_in in;
+		struct dmub_cmd_cacp_get_ace_curve_area_out out;
+	} data;
+};
+
 /**
  * Data passed from driver to FW in a DMUB_CMD__QUERY_FEATURE_CAPS command.
  */
@@ -7435,6 +7483,7 @@ struct dmub_rb_cmd_pr_copy_settings {
 union dmub_pr_runtime_flags {
 	struct {
 		uint32_t disable_abm_optimization : 1; // Disable ABM optimization for PR
+		uint32_t abm_periodic_ffu_allowed : 1; // DAL: scenario wants periodic ABM keep-alive FFU
 	} bitfields;
 	uint32_t u32All;
 };
@@ -7815,6 +7864,11 @@ union dmub_rb_cmd {
 	 */
 	struct dmub_rb_cmd_cacp_get_histogram cacp_get_histogram;
 
+	/**
+	 * Definition of a DMUB_CMD__CACP_GET_ACE_CURVE_AREA command.
+	 */
+	struct dmub_rb_cmd_cacp_get_ace_curve_area cacp_get_ace_curve_area;
+
 	/**
 	 * Definition of a DMUB_CMD__IDLE_OPT_DCN_NOTIFY_IDLE command.
 	 */
-- 
2.34.1

