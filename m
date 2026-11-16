Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20C38606A31C
	for <amd-gfx@archiver.kernel.org>; Tue, 17 Nov 2026 17:14:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=wq3Bmdge
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B523210F829;
	Tue, 17 Nov 2026 17:14:37 +0000 (UTC)
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012050.outbound.protection.outlook.com [52.101.53.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1609110F830
 for <amd-gfx@lists.freedesktop.org>; Tue, 17 Nov 2026 17:14:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=val01QpfCwbgqfxcqBuak4MXwGfFPSK3ID4wM4//Bj9A1ju2dO4m9MNIT7N8MjnVS9hO0GXmrn1YhIccKMi1oO3l+ox7lr0btshrRs6zYY0sG6iI8FBxd9vqW7Ka4SwXvgzS+M3+ZHflJw+CPERqpsmOQyatyJ2qHouXSztusaEK6yjZ4q0hIfy9bm7tqILPVGamxPDY2zzhTuKlusBDVbi6BLWBQKKcezUTYzD7fmT1rf6RA6aDlq0zOtdclm8azqeg+vqdz2+KnjE0IzmUh2qj0YaZxCVDHN00rAzUrGGI7K3YKcd9Pm9gRkr8GZoAU6I4QYgbDpuMwCuzqfEb5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FKCWZ9sUY5L9AoiaLmp67yl+bgh3gwEXwm6IPitnxAI=;
 b=Fgp3cJTLOGR2uLAqc4aRrXewHNcGR+S8NYqmgYd87aauOdPXNPgsDDHAXC1sZ/0kOG1787r43q/A867lunnhNkXjwg0bVHU8g6GMmUlQjjUMyee5+/38KlJAiqlnJ6TXT/U4m7xtyCC7V65Jy8MUgi/aiXiJg8CUsE8+q8woHOQXA5Ui0UXvB+eWHs3gSbN9EBXiUBqdZF6TPDg90t0NQSrcdwWoG+y0gqEYxy1hQhxWYf4yRhVnrm29osIU4qq3SXFRMLNsqSPuVGGslnjTCSjy+nRuYkEPpNU+aGhoNYBinkYeR4kso6Z7JSnO1AWr5CTOqVapSUQGge08HJmXfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FKCWZ9sUY5L9AoiaLmp67yl+bgh3gwEXwm6IPitnxAI=;
 b=wq3BmdgeTvaf8hxH5/iOCq+05/639uaI8d6fUdZm+QxKNEU6/bEtuky92QcLhUeesiiHUfuZMe5HS2GUgJGHZD9AflOToIkI9miVcY6Lq3AxGpFAzklgkiEcNZPSr3dHkLLzFm4ErW6JrmvDDPTXBYuKQXh3vm9ZzVFlF5fHyYg=
Received: from BN0PR04CA0111.namprd04.prod.outlook.com (2603:10b6:408:ec::26)
 by CH1PR12MB9672.namprd12.prod.outlook.com (2603:10b6:610:2b0::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Tue, 17 Nov
 2026 17:14:22 +0000
Received: from BN1PEPF0001806F.namprd04.prod.outlook.com
 (2603:10b6:408:ec:cafe::99) by BN0PR04CA0111.outlook.office365.com
 (2603:10b6:408:ec::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.8 via Frontend Transport; Tue, 17
 Nov 2026 17:14:19 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN1PEPF0001806F.mail.protection.outlook.com (10.167.245.197) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Tue, 17 Nov 2026 17:14:19 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Tue, 17 Nov
 2026 11:14:15 -0600
Received: from james-Birman-PHX.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.57 via
 Frontend Transport; Tue, 17 Nov 2026 11:14:06 -0600
From: James Lin <PingLei.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Allen Pan <Allen.Pan@amd.com>, Charlene Liu
 <charlene.liu@amd.com>, James Lin <pinglei.lin@amd.com>
Subject: [PATCH 12/33] drm/amd/display: Always apply 0ppm pixel clock
 adjustment
Date: Tue, 17 Nov 2026 05:50:49 +0800
Message-ID: <20261116215641.2800595-13-PingLei.Lin@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261116215641.2800595-1-PingLei.Lin@amd.com>
References: <20261116215641.2800595-1-PingLei.Lin@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF0001806F:EE_|CH1PR12MB9672:EE_
X-MS-Office365-Filtering-Correlation-Id: eaf17bae-92cb-4f23-fae5-08df44ce377a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|23010399003|36860700016|1800799024|376014|22082099003|9063799003|18002099003|261009223027099003|3023799007|11063799006|56012099006|261102123227099003|261028144727099003|261026140227099003|261026121527099003|261021121427099003|261022105027099003|10067099003;
X-Microsoft-Antispam-Message-Info: fzkr+9E4jdiCiEW4pg3ODK7ZbXPVkLOH1OGhNqnU6J68yFgRTRKt/JHxe+L5E/1Jkb5p3ihtnXxZYhdJZp9Hh9u9g4Tg9GW3gzTuw/QnvtQJbJKWMugRagGusg+RgNQxWngsplW/8oHH44TT/M1735eZBuTbDxC1UR9GCt8dCemiNZSdGN/DljlErbGoXCL5F4zoFYox4Nlec7VgP0XUN2CtdsftLslBeQXC1AF0972SH8GCLAnomk1PFKkdkwpJQVNByAwkxQxjwZYaxBWnaRtyygKDYtpHJsa7BmK42jJHYxzms3aarn+WKd3djrR4tBxVyz6mA69VA4UvMkKHMJM1Tg9O3i033T/5mLAQbi8WW9Gh2uZl25UfHMs6qlAtGSStdVWLa6fR11vYscojc5WW9azPFPkUkb/W34K2iWq1YRxl8ZWQWxLGLlREB6FV2MjPbpUWnacAPSuGXtQ9LMTZk4pEip8yZ2RqQm05adnwnSlIjL5yuB7l1gmxsynBEYKp+rR2xR3mgh9YbX6vArwBJg42jYlKxaIrRrDuGb4ms1fBT7v/0rJpgoPnLsJYMX2Ec+PFh+1vBcnrfDKz98ScGNjV+go3qeYuWphwiMaYGGaWO+rrgDRh/d4+Allzn0psWpMnC+kyRgg2cEl54BoKVfR5pLFXUHpO6xYgnca38wiWwukdOOadmYULNslXexqkB7TcauAOMYCzXnhh6g==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(23010399003)(36860700016)(1800799024)(376014)(22082099003)(9063799003)(18002099003)(261009223027099003)(3023799007)(11063799006)(56012099006)(261102123227099003)(261028144727099003)(261026140227099003)(261026121527099003)(261021121427099003)(261022105027099003)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: gqb6j5dmvmgBMSa2WwUEezsAtqaiJ8AVaA9xhjvAnx8Dv4ydNvrtRGXmdTafu72Ka/+y5nWHy518d7irKIr2ai+Df0FUZd/iuNxeMut4bbBO/Xbi9WUd5Ea+cy9L1IsIpbfxpr/UbMg+7I4r18mavKLQmzSV573BOEFxKdDOS3FdE4nO6btzRoxrWNm20Br6aH02Qldtfc5aX4Ysk6qyP4ikPlzsUlMwqDvxxi4qrM0etGbrgBZUop4fIISwYIQR1xrzLtGLD2N0NJ+AwHFQo6m1QJ6WOIAb016tsLGFyPTypYU+0qRWlvKE5yDnufOQey7Yv1GyPvyapB8m8g1vkykTp1nvrbUbrlspQFGZh4kIdIBn09Cmpx/D8GWCBCQY6KWiFyqszgqmmmWsBKrl3Q7L38ahUP1u611dxZ5RicWQeVm37DH2h2zz0YFg8z2G
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2026 17:14:19.4162 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: eaf17bae-92cb-4f23-fae5-08df44ce377a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF0001806F.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PR12MB9672
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-17.7 required=3.0 tests=BAYES_00,DATE_IN_PAST_12_24,
	DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Allen Pan <Allen.Pan@amd.com>

[Why]
program_pix_clk() pairs with dcn3_get_pix_clk_dividers(), which did not
apply the video optimized pixel rate table. pll_settings and
requested_pix_clk_100hz then kept the rounded pixel clock, so audio was
set up for a different clock than the one the hardware runs.

[How]
program_pix_clk() pairs with dcn3_get_pix_clk_dividers(), which did not
apply the video optimized pixel rate table. pll_settings and
requested_pix_clk_100hz then kept the rounded pixel clock, so audio was
set up for a different clock than the one the hardware runs.

Cc: Charlene Liu <charlene.liu@amd.com>
Signed-off-by: Allen Pan <Allen.Pan@amd.com>
Signed-off-by: James Lin <pinglei.lin@amd.com>
---
 .../drm/amd/display/dc/dce/dce_clock_source.c | 25 +++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dce/dce_clock_source.c b/drivers/gpu/drm/amd/display/dc/dce/dce_clock_source.c
index 145c993342bd..298e28befdd6 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dce_clock_source.c
+++ b/drivers/gpu/drm/amd/display/dc/dce/dce_clock_source.c
@@ -1444,6 +1444,7 @@ static uint32_t dcn3_get_pix_clk_dividers(
 		struct pll_settings *pll_settings)
 {
 	unsigned long long actual_pix_clk_100Hz = pix_clk_params ? pix_clk_params->requested_pix_clk_100hz : 0;
+	const struct pixel_rate_range_table_entry *e;
 	struct dce110_clk_src *clk_src = TO_DCE110_CLK_SRC(cs);
 
 	if (pix_clk_params == NULL || pll_settings == NULL
@@ -1454,6 +1455,30 @@ static uint32_t dcn3_get_pix_clk_dividers(
 	}
 
 	memset(pll_settings, 0, sizeof(*pll_settings));
+	e = look_up_in_video_optimized_rate_tlb(pix_clk_params->requested_pix_clk_100hz / 10);
+
+	if (e) {
+		switch (e->target_pixel_rate_khz) {
+		//Do not modify (no need) for *1.001 rates
+		case 27000:
+		case 54000:
+		case 108000:
+			break;
+
+		default:
+			//Should override pll_settings->actual_pix_clk_100hz here when entry found in table to
+			//increase Pixel clock precision for one digit (in KHz units -> 100Hz unit that VBIOS
+			//accepts) for refresh rates like 59.94 / 29.97 Hz etc.
+			actual_pix_clk_100Hz = e->target_pixel_rate_khz;
+			actual_pix_clk_100Hz *= 10;
+			actual_pix_clk_100Hz *= e->mult_factor;
+			actual_pix_clk_100Hz = div_u64(actual_pix_clk_100Hz, e->div_factor);
+			pll_settings->actual_pix_clk_100hz = (unsigned int) actual_pix_clk_100Hz;
+			//Loop back so Audio will get same precisison for Audio DTO for Audio Wall clock
+			pix_clk_params->requested_pix_clk_100hz = (unsigned int) actual_pix_clk_100Hz;
+			break;
+		}
+	}
 	/* Adjust for HDMI Type A deep color */
 	if (pix_clk_params->signal_type == SIGNAL_TYPE_HDMI_TYPE_A) {
 		switch (pix_clk_params->color_depth) {
-- 
2.43.0

