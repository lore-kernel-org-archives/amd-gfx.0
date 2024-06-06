Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC428C27C55
	for <amd-gfx@archiver.kernel.org>; Thu,  6 Jun 2024 21:02:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1399C10EAA9;
	Thu,  6 Jun 2024 21:02:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ALWMIH27";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2079.outbound.protection.outlook.com [40.107.93.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A41DE10EAA9
 for <amd-gfx@lists.freedesktop.org>; Thu,  6 Jun 2024 21:02:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WR6r43hxca78nSfUg2ZjcBnXe8yh0vA59maLS6fQMSlQwNb1RT/0wxQcYfoHD6ahPPXooN9JXbfCU5F2bb+wBVPJrpM+hSqN/DoZev3vm3MvXfELYNrXJZTrSJV/MqCKac/mqlgGH5QoULD5hmB/VaB4rnWNSXRAoz6e2S1QkdcWFuxpyFHv80SQo3bH/jko07boQ+EW12B/5XREZUNR+ZphnIe3fUyK30ohykyyEaGqGwfhApHE7yxF78jtmZr/AmqBrlEwrh4JXSsjHzGqxiCJrAUDR5PbIAsgeHSG8YbfsaVnc6mcszQuWD+wmRhbFGJtq8wOVP22xtxhvGslfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vpXPlP5uxQvBmhMKKaxnlFAZ49LaKCyGJIcSzIDtAX4=;
 b=ckVPdoo4ZnOcd4g9SVzT8E0z2V+hwidtFtODe9d0ttVkpxKq72KXzcjpeNf0nEZg9EcFxXXHcFPUJjIwMCjF7jyBBdQ4Z+8Bq0gW65jQgWlFN9eOD0FeZRpXNgnpFw0SnyFbQKG5MYbDmBWXuzCBz8/qiIHR3rDlOfbP3nBV74xKvL907laeqb6V0zj+ifG2FweBQhYqWcFV+/FuzZ0TyTGuuPAVTPdqfYdZn0tE+ghT2V4/sjiIDC9jDfNKGpPfzNkNXWNCbNmRiuCBvhbmXJvCtJYWb1oKa7UV+Sr6KhDNmw9U9twqA73ENqohBWuRLlflVsRnQ1qa3nvYxQKX2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vpXPlP5uxQvBmhMKKaxnlFAZ49LaKCyGJIcSzIDtAX4=;
 b=ALWMIH27RKbHeaZX4/yFxWNJQyAC+M/mZFskPbuvh8X6jdZ2Zt/niJ/oJ8YGNqHo39OT53tVHovOfKwtwSv5+BBhevjhwFfOKT3VblbTK9Q7nkWalOEGHtAAh5E8YgA/wN7YwM9vgvxRj2raYMPyJPZhkpddlSSzqdQqujBzp0Q=
Received: from SA9PR13CA0023.namprd13.prod.outlook.com (2603:10b6:806:21::28)
 by SJ0PR12MB7034.namprd12.prod.outlook.com (2603:10b6:a03:449::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.33; Thu, 6 Jun
 2024 21:02:23 +0000
Received: from SA2PEPF00001504.namprd04.prod.outlook.com
 (2603:10b6:806:21:cafe::e3) by SA9PR13CA0023.outlook.office365.com
 (2603:10b6:806:21::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.12 via Frontend
 Transport; Thu, 6 Jun 2024 21:02:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF00001504.mail.protection.outlook.com (10.167.242.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7633.15 via Frontend Transport; Thu, 6 Jun 2024 21:02:23 +0000
Received: from mkmmarleung05.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 6 Jun
 2024 16:02:15 -0500
From: Zaeem Mohamed <zaeem.mohamed@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <jerry.zuo@amd.com>, Michael Strauss <michael.strauss@amd.com>, George Shen
 <george.shen@amd.com>, Wenjing Liu <wenjing.liu@amd.com>, Zaeem Mohamed
 <zaeem.mohamed@amd.com>
Subject: [PATCH 18/67] drm/amd/display: Add fallback defaults for invalid
 LTTPR DPCD caps
Date: Thu, 6 Jun 2024 16:58:39 -0400
Message-ID: <20240606205928.4050859-19-zaeem.mohamed@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240606205928.4050859-1-zaeem.mohamed@amd.com>
References: <20240606205928.4050859-1-zaeem.mohamed@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00001504:EE_|SJ0PR12MB7034:EE_
X-MS-Office365-Filtering-Correlation-Id: 67f39776-47d6-4215-bb9a-08dc866bf685
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|376005|36860700004|1800799015|82310400017; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?+r/WmCxhrcmLGTH5ie72uYrIyP9nKfmH6TSfjmjV5g5SBEXJglDiJrE6/Xhb?=
 =?us-ascii?Q?98dr4Z8k3tajkf1teDpVEOpfVsX/dshvz1KlTkU/ZVU7BIYptJJ1VTUA70BZ?=
 =?us-ascii?Q?N/bLMYqeIuSObcxnwF4D3Bc4jUIazuEPPSeWKFf6YcVjj6oXOSou5A6yae4u?=
 =?us-ascii?Q?B+HhQ5+N1ZaeYrhnfJA/IC533h7eDNOr94vnbS8ybDJiz3rRDdu2l4D3cBJy?=
 =?us-ascii?Q?l2WMbu0YbnNZ+/luBbJ/R8nDEkSucjIh+Wahp+f6H/h8YHa//0DuYkTomguA?=
 =?us-ascii?Q?0dhPhTIjhhMCiMDbJ1Fv6oj6iiOaZE03jKNt/zwpBOSPmYwMBFqWQ9IhNLFN?=
 =?us-ascii?Q?SRFz/Dp0RzTvfy2w+TGJ0lbtlAAt6FCvsljo2OyRYqgDp5US0sZK68URJ9U+?=
 =?us-ascii?Q?5/xBZDKplqhZZhgCZJ64bH+GGaStUNRfBkbHY4J61h6SXGBefEOX71mlTGzv?=
 =?us-ascii?Q?E8rjmPfYDTidkcJ8lDCncpPvl0oDaDezlJfn0OPd54xeLLxINyMEAUSN1EFp?=
 =?us-ascii?Q?R8q/HnAGDcETR2YqdYRbVCfMwcuwQNX49fV58tbkp1TPAYGNyGmS7JLc+NhM?=
 =?us-ascii?Q?nPb3UBitRjV/d3Hm+OltLoUXfLXc81/Gb+/SwhQ2t+gSbA0T8i5iZthZ3T7A?=
 =?us-ascii?Q?OCYUXgQSwiI7ii18boBmZnobKCOU1p3sRgQ6YqMuTTcMJy4VB0APtDgMZLfC?=
 =?us-ascii?Q?sy+dbkl/Dk8dowexAoAKMb5bFMPrkmaLFIDZc3jzbZ++Kv1TfyHhlRbJ3DkT?=
 =?us-ascii?Q?qK2ttZq4EmbtrcJDH5Cd3RUICRtZ3/fcvT6UsjHC6ISFJ4jdMuKAjGDL10Ph?=
 =?us-ascii?Q?oTbzOT/2Mah7/SgH/cDQxQ0cpg4ZNj1s02/sxacuDaXIU5AJM7bQqj9+YjFh?=
 =?us-ascii?Q?JQDcpodjOapaOIPiJqcUmU3HLmarCO3dEGSOPTwuybXZcDMuuWN+kswY3qqs?=
 =?us-ascii?Q?mEvs3FG2go2c4tF/ldOHTynmKw1oRdpXvLWUlgQhABHSWPjN/NppfBLpf0bE?=
 =?us-ascii?Q?FohJZS6zpTA9oNB0Uu/bNyTztpvvyvsAb+wf+yQFe2e49vxZz+b4pMwP6qGx?=
 =?us-ascii?Q?PsHnYhiRYpA6EnIQwLKu7MagJ9kmctUNNoG3jBbw3sUNIeYfOPilNoZT6Ewy?=
 =?us-ascii?Q?TJqlEnzoLdqrvd2z2JjQ+QY9gh7P2q4mCpPOY7tSM6QWBf+fjTHmYvtVV79W?=
 =?us-ascii?Q?eya/qxkKTFwk9I8YkI3I88tT/0/F+7/DF5t2+Rx4radK7MTkhueiK1II3pFA?=
 =?us-ascii?Q?sl/ZNp0S7pLFlZYTwzLOdwXWGFb4ZZ5RKCeX94KYTgl8XadeYCVZkbaCUh93?=
 =?us-ascii?Q?M2HqeoWgQJRb82RmOAzwj381/YeQczGEEdvesN1K0AlkdwcPIf3rjzBkr0Ej?=
 =?us-ascii?Q?NTa3UfU0E472+Q5x0VXSf0WHHVzYC9s6BZG/tph9bfo2XmnCNw=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(376005)(36860700004)(1800799015)(82310400017); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2024 21:02:23.4568 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 67f39776-47d6-4215-bb9a-08dc866bf685
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00001504.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB7034
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

From: Michael Strauss <michael.strauss@amd.com>

[WHY]
Some sinks are observed to return invalid LTTPR revision and/or invalid
LTTPR link rate capabilities.

[HOW]
Assume any LTTPR which reports invalid max link rate supports HBR3.
Don't validate LTTPR DPCD revision in dp_is_lttpr_present check.

Reviewed-by: George Shen <george.shen@amd.com>
Reviewed-by: Wenjing Liu <wenjing.liu@amd.com>
Acked-by: Zaeem Mohamed <zaeem.mohamed@amd.com>
Signed-off-by: Michael Strauss <michael.strauss@amd.com>
---
 .../dc/link/protocols/link_dp_capability.c    | 19 ++++++++++++++++---
 1 file changed, 16 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_capability.c b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_capability.c
index 964abccebdc6..1ff9876e3ca3 100644
--- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_capability.c
+++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_capability.c
@@ -363,10 +363,10 @@ bool dp_is_128b_132b_signal(struct pipe_ctx *pipe_ctx)
 
 bool dp_is_lttpr_present(struct dc_link *link)
 {
+	/* Some sink devices report invalid LTTPR revision, so don't validate against that cap */
 	return (dp_parse_lttpr_repeater_count(link->dpcd_caps.lttpr_caps.phy_repeater_cnt) != 0 &&
 			link->dpcd_caps.lttpr_caps.max_lane_count > 0 &&
-			link->dpcd_caps.lttpr_caps.max_lane_count <= 4 &&
-			link->dpcd_caps.lttpr_caps.revision.raw >= 0x14);
+			link->dpcd_caps.lttpr_caps.max_lane_count <= 4);
 }
 
 /* in DP compliance test, DPR-120 may have
@@ -399,7 +399,20 @@ static enum dc_link_rate get_link_rate_from_max_link_bw(
 
 static enum dc_link_rate get_lttpr_max_link_rate(struct dc_link *link)
 {
-	enum dc_link_rate lttpr_max_link_rate = link->dpcd_caps.lttpr_caps.max_link_rate;
+
+	enum dc_link_rate lttpr_max_link_rate = LINK_RATE_UNKNOWN;
+
+	switch (link->dpcd_caps.lttpr_caps.max_link_rate) {
+	case LINK_RATE_LOW:
+	case LINK_RATE_HIGH:
+	case LINK_RATE_HIGH2:
+	case LINK_RATE_HIGH3:
+		lttpr_max_link_rate = link->dpcd_caps.lttpr_caps.max_link_rate;
+		break;
+	default:
+		// Assume all LTTPRs support up to HBR3 to improve misbehaving sink interop
+		lttpr_max_link_rate = LINK_RATE_HIGH3;
+	}
 
 	if (link->dpcd_caps.lttpr_caps.supported_128b_132b_rates.bits.UHBR20)
 		lttpr_max_link_rate = LINK_RATE_UHBR20;
-- 
2.34.1

