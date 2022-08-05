Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53573C00140
	for <amd-gfx@archiver.kernel.org>; Fri,  5 Aug 2022 18:00:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 588C4B92CB;
	Fri,  5 Aug 2022 18:00:01 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1anam02on2064.outbound.protection.outlook.com [40.107.96.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BDA3BB9246
 for <amd-gfx@lists.freedesktop.org>; Fri,  5 Aug 2022 17:59:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E5HKI4Zlr/NMAlugn5emuJBqNBnh4kMfjesH0m8EVgy9e+Qc3PVzD/EkmKsehVtDawmHAj1gX8B0dW1fF7u20dA5cTf4QVzQOT11c6xWUR9+C4MTn8cVCB+MUwusAcRBo/BQXuxvn28IBBvraijVqNpuE8TJHx+EaE6Rsm06VqS+vfQY+w5fmy/tFh31UTWsSWHHwh34YvnDL0/iFbimZVXpc6ri5B6pP7vZcjnInDVoCpKqX9mxPtPOAGmMd39lcwEHyjR7DtD6TaoC9Fc6j/nWsfexaJumZFdoEjvzqWXzTMl+XgPsA/CRZ3qCrUYY2nRjFl4ErX/Kt4HsRU3c2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bYLfjpDthsMdGQYnh48u4ihC0BTFyuIVAElX6gDj88Q=;
 b=YDWKrtrX6qCizo3PKIel1tkD2QMoPe9ACaGgbhgwVigTl9/pSgnKOgIInlOIEnhbeGD4wwPbDr8pyCzDNDwQxQl9gX8hKM7MVafOFG8DLn36CEzZ2lCCBbCJV/Ohy8dVUmweLSmi2Ap/ftSioNj+Io3eRLEpVMh+35N20R1Gu+iTkfKbY4p8WmdZa9IDov8jSvOayf3ECwnbIpKWo5CvUMLIGW9uA1NUd9zVJAtOOweP2K7fEuNY8Xcx3Tex+YHg6XIZMBWDXb65RloAd3ZRbJ05jZd4kWaLV/lbpTcZ5H7OLGKW87AbswkyxK3w8uZWbOuWh/VSFVNeVuhywni8GQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bYLfjpDthsMdGQYnh48u4ihC0BTFyuIVAElX6gDj88Q=;
 b=U1d3fTiTIMkkl/LFiBK+g9waf9eDHL2il5fEFvWbXPhnxkikC1xCOmV9RspCy3Dvbsydy3eNt98MpvEESnwDuY9OWFuQCTKcKxJYtM309dgtRzZtZb8VsHtwEvQrvPXildkOw6wiQS4Cf8gKKI6ZQr9vE8Zkgy5iFXrwj44Mdts=
Received: from BN9PR03CA0183.namprd03.prod.outlook.com (2603:10b6:408:f9::8)
 by BN8PR12MB3313.namprd12.prod.outlook.com (2603:10b6:408:65::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.14; Fri, 5 Aug
 2022 17:59:48 +0000
Received: from BN8NAM11FT030.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:f9:cafe::5f) by BN9PR03CA0183.outlook.office365.com
 (2603:10b6:408:f9::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5482.16 via Frontend
 Transport; Fri, 5 Aug 2022 17:59:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN8NAM11FT030.mail.protection.outlook.com (10.13.177.146) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5504.14 via Frontend Transport; Fri, 5 Aug 2022 17:59:48 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Fri, 5 Aug
 2022 12:59:48 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Fri, 5 Aug
 2022 10:59:47 -0700
Received: from tom-HP.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.28 via Frontend
 Transport; Fri, 5 Aug 2022 12:59:42 -0500
From: Tom Chung <chiahsuan.chung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 11/32] drm/amd/display: Add 16 lines margin for SubVP
Date: Sat, 6 Aug 2022 01:58:05 +0800
Message-ID: <20220805175826.2992171-12-chiahsuan.chung@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220805175826.2992171-1-chiahsuan.chung@amd.com>
References: <20220805175826.2992171-1-chiahsuan.chung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b3ec51a7-e234-433f-b55e-08da770c49d0
X-MS-TrafficTypeDiagnostic: BN8PR12MB3313:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yTUs8LZqSqDRDITGGbFedokfSeUiExrJoDd3t7dfhvK0+d+bIuK8LhFf3l1kuMY4lBNwtR9rPkyRA7kcNh35qST+tWqwiQcr/cqCp8I1pMRjS5ZqZt72Q6sJyyARrMF9hJMMEgL6JvoosP6mriUwBtg/wmT8O7udBTLcYWQypHZBEjZfHwVAUSuiFJ0yHn19p/h2SeA0WRDyh6eP5j6dIeY8UAfley14Df6aqyPXcv0D2KD9YePotyf11kaMz1bQx0UPjQxXhUy3reDt0x1XUgZL9dK5cFv2NPHN7zngL6JM0enXEv503XpoywGHCwVOnv6K5tTpqG4e0WnFpdkHsFitAzb7fqxqyzXWzGuCCkMDOAMMUDfagmjMuicVChePnOKV/+0Zwxm1W2SUnRvoxpH+ZkKNMREXvb1CtryHEe50Eawfb7CH4wgtEZZSiGaHXoURnAJwvZLuIyWAnQ82LaNlwjMd24CeDqc7+WNvLaOfk0MM7hvc3r/xZr6lH2ml/0zhe7FUdTFixG7oYI+8ma+IxAlFkScxpU/2RwDcLYFP0nIoS2FoALoQptFs3Bn6Py+Uyth5ytxPGFHnBnEZxXp5eU0MGmP0bzBwRTbky3jLYgZ55tPNE57HCdHn7rjFvAQ0eXf4Vb/hpL3m6576szlfC/fMDNUfP/SSWS7AxfkCtzYXinFQitxZsRt9kOyODUJKiQPce5r8cU/xFAMwKUtiYt6n2+tHMLr82D90ODPQcMAijUNW5msKRjtixOeUyl8EoXScW68DYHtpTt6QSyZueRgSIUFeeXbD89ja51GJuLAIrLGZFTTL/YNdir65EKrgTIN1zDnjTt/34tY1Yg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(136003)(346002)(39860400002)(376002)(396003)(46966006)(36840700001)(40470700004)(478600001)(6666004)(26005)(7696005)(41300700001)(82310400005)(5660300002)(40480700001)(2906002)(36756003)(70586007)(86362001)(54906003)(316002)(6916009)(356005)(81166007)(47076005)(336012)(426003)(2616005)(82740400003)(1076003)(186003)(8936002)(70206006)(8676002)(4326008)(36860700001)(83380400001)(40460700003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2022 17:59:48.7292 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b3ec51a7-e234-433f-b55e-08da770c49d0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT030.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB3313
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
Cc: stylon.wang@amd.com, Tom Chung <chiahsuan.chung@amd.com>,
 Sunpeng.Li@amd.com, Harry.Wentland@amd.com, qingqing.zhuo@amd.com,
 Rodrigo.Siqueira@amd.com, roman.li@amd.com, solomon.chiu@amd.com,
 Aurabindo.Pillai@amd.com, Alvin Lee <alvin.lee2@amd.com>, wayne.lin@amd.com,
 Jun Lei <Jun.Lei@amd.com>, Bhawanpreet.Lakha@amd.com,
 agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Alvin Lee <alvin.lee2@amd.com>

[Description]
SUBVP_START_LINE must be aligned to 2 swaths, so add
16 lines of margin so the start line can be adjusted by
up to 16 lines for alignment purposes in FW.

Reviewed-by: Jun Lei <Jun.Lei@amd.com>
Reviewed-by: Jun Lei <Jun.Lei@amd.com>
Acked-by: Tom Chung <chiahsuan.chung@amd.com>
Signed-off-by: Alvin Lee <alvin.lee2@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc.h                     | 1 +
 drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c            | 4 ++--
 drivers/gpu/drm/amd/display/dc/dcn32/dcn32_optc.c       | 2 +-
 drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c   | 1 +
 drivers/gpu/drm/amd/display/dc/dcn321/dcn321_resource.c | 1 +
 drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c    | 5 ++++-
 6 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index d73e68c2fd51..f2accacae85b 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -213,6 +213,7 @@ struct dc_caps {
 	uint32_t cache_num_ways;
 	uint16_t subvp_fw_processing_delay_us;
 	uint16_t subvp_prefetch_end_to_mall_start_us;
+	uint8_t subvp_swath_height_margin_lines; // subvp start line must be aligned to 2 x swath height	
 	uint16_t subvp_pstate_allow_width_us;
 	uint16_t subvp_vertical_int_margin_us;
 	bool seamless_odm;
diff --git a/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c b/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
index ffa1c0148330..759d54843eff 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
+++ b/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
@@ -275,8 +275,7 @@ void dc_dmub_srv_set_drr_manual_trigger_cmd(struct dc *dc, uint32_t tg_inst)
 	union dmub_rb_cmd cmd = { 0 };
 
 	cmd.drr_update.header.type = DMUB_CMD__FW_ASSISTED_MCLK_SWITCH;
-	// TODO: Uncomment once FW headers are promoted
-	//cmd.drr_update.header.sub_type = DMUB_CMD__FAMS_SET_MANUAL_TRIGGER;
+	cmd.drr_update.header.sub_type = DMUB_CMD__FAMS_SET_MANUAL_TRIGGER;
 	cmd.drr_update.dmub_optc_state_req.tg_inst = tg_inst;
 
 	cmd.drr_update.header.payload_bytes = sizeof(cmd.drr_update) - sizeof(cmd.drr_update.header);
@@ -611,6 +610,7 @@ static void populate_subvp_cmd_pipe_info(struct dc *dc,
 			main_timing->v_total - main_timing->v_front_porch - main_timing->v_addressable;
 	pipe_data->pipe_config.subvp_data.mall_region_lines = phantom_timing->v_addressable;
 	pipe_data->pipe_config.subvp_data.main_pipe_index = subvp_pipe->pipe_idx;
+	pipe_data->pipe_config.subvp_data.is_drr = subvp_pipe->stream->ignore_msa_timing_param;	
 
 	// Prefetch lines is equal to VACTIVE + BP + VSYNC
 	pipe_data->pipe_config.subvp_data.prefetch_lines =
diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_optc.c b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_optc.c
index 992e56c6907e..9861be1dc063 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_optc.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_optc.c
@@ -282,7 +282,7 @@ static struct timing_generator_funcs dcn32_tg_funcs = {
 		.lock_doublebuffer_disable = optc3_lock_doublebuffer_disable,
 		.enable_optc_clock = optc1_enable_optc_clock,
 		.set_vrr_m_const = optc3_set_vrr_m_const,
-		.set_drr = optc31_set_drr, // TODO: Update to optc32_set_drr once FW headers are promoted
+		.set_drr = optc32_set_drr,
 		.get_last_used_drr_vtotal = optc2_get_last_used_drr_vtotal,
 		.set_vtotal_min_max = optc3_set_vtotal_min_max,
 		.set_static_screen_control = optc1_set_static_screen_control,
diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c
index 9a26d24b579f..96076d633273 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c
@@ -2051,6 +2051,7 @@ static bool dcn32_resource_construct(
 	dc->caps.max_cab_allocation_bytes = 67108864; // 64MB = 1024 * 1024 * 64
 	dc->caps.subvp_fw_processing_delay_us = 15;
 	dc->caps.subvp_prefetch_end_to_mall_start_us = 15;
+	dc->caps.subvp_swath_height_margin_lines = 16;
 	dc->caps.subvp_pstate_allow_width_us = 20;
 	dc->caps.subvp_vertical_int_margin_us = 30;
 
diff --git a/drivers/gpu/drm/amd/display/dc/dcn321/dcn321_resource.c b/drivers/gpu/drm/amd/display/dc/dcn321/dcn321_resource.c
index 8157e40d2c7e..f627b494737a 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn321/dcn321_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn321/dcn321_resource.c
@@ -1662,6 +1662,7 @@ static bool dcn321_resource_construct(
 	dc->caps.max_cab_allocation_bytes = 33554432; // 32MB = 1024 * 1024 * 32
 	dc->caps.subvp_fw_processing_delay_us = 15;
 	dc->caps.subvp_prefetch_end_to_mall_start_us = 15;
+	dc->caps.subvp_swath_height_margin_lines = 16;
 	dc->caps.subvp_pstate_allow_width_us = 20;
 
 	dc->caps.max_slave_planes = 1;
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c b/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
index f8023cfe79f8..988e28a8e90e 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
@@ -473,8 +473,11 @@ void dcn32_set_phantom_stream_timing(struct dc *dc,
 
 	// DML calculation for MALL region doesn't take into account FW delay
 	// and required pstate allow width for multi-display cases
+	/* Add 16 lines margin to the MALL REGION because SUB_VP_START_LINE must be aligned
+	 * to 2 swaths (i.e. 16 lines)
+	 */
 	phantom_vactive = get_subviewport_lines_needed_in_mall(&context->bw_ctx.dml, pipes, pipe_cnt, pipe_idx) +
-				pstate_width_fw_delay_lines;
+				pstate_width_fw_delay_lines + dc->caps.subvp_swath_height_margin_lines;
 
 	// For backporch of phantom pipe, use vstartup of the main pipe
 	phantom_bp = get_vstartup(&context->bw_ctx.dml, pipes, pipe_cnt, pipe_idx);
-- 
2.25.1

