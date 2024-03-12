Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93F0BC54E66
	for <amd-gfx@archiver.kernel.org>; Tue, 12 Mar 2024 09:21:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2952711291B;
	Tue, 12 Mar 2024 09:21:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="5PEMQzpC";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2087.outbound.protection.outlook.com [40.107.93.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 84A6C11291B
 for <amd-gfx@lists.freedesktop.org>; Tue, 12 Mar 2024 09:21:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O5gMd/zSqQNDQOQ9LHrXaJD2j5gH8FTizhT0cN8yja5lUf008Xy9OCgj62Z21AzfIKndviyjGs7Jzmd8GhrDX6hgbjyTD0mVtg+uJkHLT2D6wuw4xms3piTZ2kV9q5lM+ijW4xeYCLmScC6PT9kpbffXt+tDtEw/NJevNIiG7V2tKgBb+x4HCY4oiFslqxkfYhuS3ctzof/scWjwg2CitV4fChoRqEAFqLrl40gflZ+NXtzDbQojZ2Pr0P2JlephFA6mUxz8fr4MG1kcNVxeBYNzHv/UinDmeEhZyKq31VeH0a6mVvFKQj4F9wW2wTsiCpbCSS3hjP0kKfD1mjnvcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h4+RoKx5kjInaAMUrDGgwcWTOgU+FA3u4vIK8VqzdPk=;
 b=HProW0DlAUPtdj2V8EuubfKDz/IPP2yXQuuFblcJmmfgHFklX79L4L2DqdznloGeqphNas1pnQZ2lkDbpCDJ1YIO+88MQh82l6Vuz3YSEsILabye8qemOmYII3msvvyr5JahLdZo1PGRQmzDgFv0fcygGK5/G42LB3xhgXBZ6I+gPVSdt10tD43RZ7DG4dhMQNK3+ga55BXNHBTjdbxQcO1o39Jn58zPOpqjor0Cb3vxE8IOuAOWzgOUF0a9/PG828Z5D8vUjkQw8sWi43nwWg5SsMUjVJLklrUCD6pCTgyRZJMzOpu0e2w45wVF89gCSwSkhuUi7sTO8bI+gQ8m2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h4+RoKx5kjInaAMUrDGgwcWTOgU+FA3u4vIK8VqzdPk=;
 b=5PEMQzpCYH0shs5o3H6rstrRriVUMAmZhV2xbXmRmc+Tq0E+ccJbmpDTOy6PMWXLw3pIIr8o/s9uoufEnt1fTUq0ju+vY3m0Ql3Ifl4j2gQpOOgDP0N4XFA0JZw4tdIBcZTarwi8W66UQRLjbfZeBBzuSMYJwNa3tTEXInGHrhU=
Received: from MW4P222CA0023.NAMP222.PROD.OUTLOOK.COM (2603:10b6:303:114::28)
 by SA3PR12MB7832.namprd12.prod.outlook.com (2603:10b6:806:31f::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.35; Tue, 12 Mar
 2024 09:21:26 +0000
Received: from CO1PEPF000044F5.namprd05.prod.outlook.com
 (2603:10b6:303:114:cafe::38) by MW4P222CA0023.outlook.office365.com
 (2603:10b6:303:114::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.36 via Frontend
 Transport; Tue, 12 Mar 2024 09:21:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044F5.mail.protection.outlook.com (10.167.241.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7386.12 via Frontend Transport; Tue, 12 Mar 2024 09:21:25 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 12 Mar
 2024 04:21:24 -0500
Received: from wayne-dev-lnx.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Tue, 12 Mar 2024 04:21:20 -0500
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <hersenxs.wu@amd.com>, <jerry.zuo@amd.com>, Alex Hung <alex.hung@amd.com>
Subject: [PATCH 05/43] drm/amd/display: Correct indentations and spaces
Date: Tue, 12 Mar 2024 17:19:58 +0800
Message-ID: <20240312092036.3283319-6-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20240312092036.3283319-1-Wayne.Lin@amd.com>
References: <20240312092036.3283319-1-Wayne.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: Wayne.Lin@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F5:EE_|SA3PR12MB7832:EE_
X-MS-Office365-Filtering-Correlation-Id: 09d6a28b-6075-45f8-80d5-08dc4275cac2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: I044R6w3fSkUoBjTzRPw5s+cDWsnHrBI1kOkO/pPlrbc2DOffoCO27MtVKkJ6cLacgHPXA/f2FBXhTUkphXVoq4CTwIRicb0s5b3/dQLYQ4gNfiYB2xKxpStdaagSVvtPOhKWp0C6Ew/vyFtaW2NNv/JGTF/cLJ9DAjM5rfMKzoaloed/zn5QcQQSRyMR6OCH7D7cEJXtbevS0kn0vhef3y7UwX1jpi6q7sYoiPEAwhrYm09zPJT7kcE9Quhd0KElRF6AkTd79/pzp2AStqtXim6Vkj4IBzKMEwGePPh1lA5zWU1kwt55h+0+Y4g8JI75cvLIsMxVG41W5E6C5RvmBMfuqLw7DO7JuBxMHNbULy6QHDk3zStEkd339xfWtB7aOh/iuLAHRW/y7v/gsq5bHP4i37R6SAav9cVjS5yltGqnLazBnb+8p30qKXe3TMviuNSBwbPosD/wn5hWenIsNFx+4uQC5zw4mZSQUj+EV+c2A9eqvIOzwJ3E8dyosId79tQFW9JicJW1nOCC9wbr+4EAgMkk5qgNUuWY3AjBiqo+2jGWC5CDda7QocN/Y7Io+GTDaTRj+8Cknd0mcwqyrXRs4yzsjkBl5ZKOtLWd9tzZ2qrPAprMs+iwIqT2Pc1aqZnn5G7gudOeJwtZlsmRYulkOzhBOevnkRKGbIUNJA5+bBJiTBW1h52dmJm4c1/f09viPrHA3iZ3a8YeCm3Jqg4VNQCiep4/CTabBxsMHgMZvBPXXY2As/OBTS7feDF
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(82310400014)(36860700004)(376005)(1800799015); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2024 09:21:25.8712 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 09d6a28b-6075-45f8-80d5-08dc4275cac2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044F5.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7832
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

From: Alex Hung <alex.hung@amd.com>

[Why & How]
This fixes indentations and adjust spaces for better readability and
code styles.

Acked-by: Wayne Lin <wayne.lin@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
---
 .../gpu/drm/amd/display/dc/bios/bios_parser.c |  1 +
 .../gpu/drm/amd/display/dc/clk_mgr/clk_mgr.c  | 15 ++++---
 .../display/dc/clk_mgr/dcn314/dcn314_smu.h    | 42 +++++++++----------
 .../gpu/drm/amd/display/dc/core/dc_resource.c |  3 +-
 drivers/gpu/drm/amd/display/dc/core/dc_stat.c |  2 +-
 5 files changed, 32 insertions(+), 31 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/bios/bios_parser.c b/drivers/gpu/drm/amd/display/dc/bios/bios_parser.c
index 6450853fea94..645a8991a830 100644
--- a/drivers/gpu/drm/amd/display/dc/bios/bios_parser.c
+++ b/drivers/gpu/drm/amd/display/dc/bios/bios_parser.c
@@ -1731,6 +1731,7 @@ static uint32_t get_ss_entry_number_from_internal_ss_info_tbl_v2_1(
 
 	return 0;
 }
+
 /**
  * get_ss_entry_number_from_internal_ss_info_tbl_V3_1
  * Get Number of SpreadSpectrum Entry from the ASIC_InternalSS_Info table of
diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/clk_mgr.c
index 9f0f25aee426..c1a5908b97c8 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/clk_mgr.c
@@ -329,15 +329,14 @@ struct clk_mgr *dc_clk_mgr_create(struct dc_context *ctx, struct pp_smu_funcs *p
 	}
 		break;
 	case AMDGPU_FAMILY_GC_11_0_0: {
-	    struct clk_mgr_internal *clk_mgr = kzalloc(sizeof(*clk_mgr), GFP_KERNEL);
-
-	    if (clk_mgr == NULL) {
-		BREAK_TO_DEBUGGER();
-		return NULL;
-	    }
+		struct clk_mgr_internal *clk_mgr = kzalloc(sizeof(*clk_mgr), GFP_KERNEL);
 
-	    dcn32_clk_mgr_construct(ctx, clk_mgr, pp_smu, dccg);
-	    return &clk_mgr->base;
+		if (clk_mgr == NULL) {
+			BREAK_TO_DEBUGGER();
+			return NULL;
+		}
+		dcn32_clk_mgr_construct(ctx, clk_mgr, pp_smu, dccg);
+		return &clk_mgr->base;
 	}
 
 	case AMDGPU_FAMILY_GC_11_0_1: {
diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn314/dcn314_smu.h b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn314/dcn314_smu.h
index 047d19ea919c..78ca1e5c5e9e 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn314/dcn314_smu.h
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn314/dcn314_smu.h
@@ -37,34 +37,34 @@ typedef enum {
 } WCK_RATIO_e;
 
 typedef struct {
-  uint32_t FClk;
-  uint32_t MemClk;
-  uint32_t Voltage;
-  uint8_t  WckRatio;
-  uint8_t  Spare[3];
+	uint32_t FClk;
+	uint32_t MemClk;
+	uint32_t Voltage;
+	uint8_t  WckRatio;
+	uint8_t  Spare[3];
 } DfPstateTable314_t;
 
 //Freq in MHz
 //Voltage in milli volts with 2 fractional bits
 typedef struct {
-  uint32_t DcfClocks[NUM_DCFCLK_DPM_LEVELS];
-  uint32_t DispClocks[NUM_DISPCLK_DPM_LEVELS];
-  uint32_t DppClocks[NUM_DPPCLK_DPM_LEVELS];
-  uint32_t SocClocks[NUM_SOCCLK_DPM_LEVELS];
-  uint32_t VClocks[NUM_VCN_DPM_LEVELS];
-  uint32_t DClocks[NUM_VCN_DPM_LEVELS];
-  uint32_t SocVoltage[NUM_SOC_VOLTAGE_LEVELS];
-  DfPstateTable314_t DfPstateTable[NUM_DF_PSTATE_LEVELS];
+	uint32_t DcfClocks[NUM_DCFCLK_DPM_LEVELS];
+	uint32_t DispClocks[NUM_DISPCLK_DPM_LEVELS];
+	uint32_t DppClocks[NUM_DPPCLK_DPM_LEVELS];
+	uint32_t SocClocks[NUM_SOCCLK_DPM_LEVELS];
+	uint32_t VClocks[NUM_VCN_DPM_LEVELS];
+	uint32_t DClocks[NUM_VCN_DPM_LEVELS];
+	uint32_t SocVoltage[NUM_SOC_VOLTAGE_LEVELS];
+	DfPstateTable314_t DfPstateTable[NUM_DF_PSTATE_LEVELS];
 
-  uint8_t  NumDcfClkLevelsEnabled;
-  uint8_t  NumDispClkLevelsEnabled; //Applies to both Dispclk and Dppclk
-  uint8_t  NumSocClkLevelsEnabled;
-  uint8_t  VcnClkLevelsEnabled;     //Applies to both Vclk and Dclk
-  uint8_t  NumDfPstatesEnabled;
-  uint8_t  spare[3];
+	uint8_t  NumDcfClkLevelsEnabled;
+	uint8_t  NumDispClkLevelsEnabled; //Applies to both Dispclk and Dppclk
+	uint8_t  NumSocClkLevelsEnabled;
+	uint8_t  VcnClkLevelsEnabled;     //Applies to both Vclk and Dclk
+	uint8_t  NumDfPstatesEnabled;
+	uint8_t  spare[3];
 
-  uint32_t MinGfxClk;
-  uint32_t MaxGfxClk;
+	uint32_t MinGfxClk;
+	uint32_t MaxGfxClk;
 } DpmClocks314_t;
 
 struct dcn314_watermarks {
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
index 798e6f7fa4e3..945ee57f1721 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
@@ -340,7 +340,7 @@ struct resource_pool *dc_create_resource_pool(struct dc  *dc,
 	return res_pool;
 }
 
-void dc_destroy_resource_pool(struct dc  *dc)
+void dc_destroy_resource_pool(struct dc *dc)
 {
 	if (dc) {
 		if (dc->res_pool)
@@ -1522,6 +1522,7 @@ bool resource_build_scaling_params(struct pipe_ctx *pipe_ctx)
 	struct dc_crtc_timing *timing = &pipe_ctx->stream->timing;
 	const struct rect odm_slice_rec = calculate_odm_slice_in_timing_active(pipe_ctx);
 	bool res = false;
+
 	DC_LOGGER_INIT(pipe_ctx->stream->ctx->logger);
 
 	/* Invalid input */
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_stat.c b/drivers/gpu/drm/amd/display/dc/core/dc_stat.c
index 5f6392ae31a6..cd6570a1e20e 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_stat.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_stat.c
@@ -61,7 +61,7 @@ void dc_stat_get_dmub_notification(const struct dc *dc, struct dmub_notification
 	/* For HPD/HPD RX, convert dpia port index into link index */
 	if (notify->type == DMUB_NOTIFICATION_HPD ||
 	    notify->type == DMUB_NOTIFICATION_HPD_IRQ ||
-		notify->type == DMUB_NOTIFICATION_DPIA_NOTIFICATION ||
+	    notify->type == DMUB_NOTIFICATION_DPIA_NOTIFICATION ||
 	    notify->type == DMUB_NOTIFICATION_SET_CONFIG_REPLY) {
 		notify->link_index =
 			get_link_index_from_dpia_port_index(dc, notify->link_index);
-- 
2.37.3

