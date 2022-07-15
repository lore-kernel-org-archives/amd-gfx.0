Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D32E1C433EF
	for <amd-gfx@archiver.kernel.org>; Sat, 16 Jul 2022 14:43:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F150110FC28;
	Sat, 16 Jul 2022 14:37:36 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2059.outbound.protection.outlook.com [40.107.243.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DC1E610E1EA
 for <amd-gfx@lists.freedesktop.org>; Fri, 15 Jul 2022 18:17:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kWTXIFcYpXzkNokD+7/N+v7iyI59fLIxCWD/Ctk1ZpdO39BgDetew8cR4mQRWEv9Q764Upq5B1IcoCepdy3ZNqZiT0Mc5qv+cVgL572T+i7EngEHW4O+h7keg2Tpa4bfuKNGlL36QhKE0bsXQTNRzDB8mUF7HtGSf0lCpPCxhWpBy3FdYfvA+McOAUix8nghmXkv7xkA7RVzOxcQD0O3E/QzP/5dOUDlI+30L3iKLGetdmizlyXHIVB4CAAAak1b637hWQmZxAKBGClQldjh1YLItBjQbzCf/JUm7RaFPVw2vETRgdcu/4cvhKuvb8wjgCSvUJksufOKZXR/gvT0JA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uesMKJNoegovOASyI1CCxR/Te45UmuA+uek2K2epwWI=;
 b=VUaE/lznbV2kv2rY2qbXwiduiOfIGMhZP/5OFzID+AEqch/GKNH2OnT/PVqJ9L3SoftOQDRqrS79J3sdco2g1cRDquXbjaHP1cIQg1XJ3wb8apaRaKGd1i5Qi9FVJWeXeYO6HUUGaXky95ym59M5Zo1UOVTRsJdBCmuv1HatxMjFIu4d4XL0/XATK/U/dlNnxmL5zjXNQXBoTMBGqBX3MdJZKIpd1+DCwMoU+cU8R3qzo5lMorTr7bQgNc3+b/mi2KnhKhx33P+SZ111Dm5EfQoDGcDV0m2juNKxrQc3z0SMcMBro+4Vi3ZCjjBzf/OTdo+7BD5CYZyVNkaugB5D5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uesMKJNoegovOASyI1CCxR/Te45UmuA+uek2K2epwWI=;
 b=PGBzmS4gHfRjWjzS6OJnU7Wh6xFhi5jVcVIQU2C2/eVKVJ+1nb8U0iodx4L2myaokEAcxlwYXiPO3TMYvbFRxcscQCQcHCVTbCwPnV8Q+HLwv5HD/WFCxtCBPLUG+mQCxbaCDqWS1/bzfLXLOV9Edhtmw/pIHjenDV9Zd59j3is=
Received: from MW4P221CA0021.NAMP221.PROD.OUTLOOK.COM (2603:10b6:303:8b::26)
 by MWHPR12MB1181.namprd12.prod.outlook.com (2603:10b6:300:e::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.20; Fri, 15 Jul
 2022 18:17:52 +0000
Received: from CO1NAM11FT018.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8b:cafe::8a) by MW4P221CA0021.outlook.office365.com
 (2603:10b6:303:8b::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.15 via Frontend
 Transport; Fri, 15 Jul 2022 18:17:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1NAM11FT018.mail.protection.outlook.com (10.13.175.16) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5438.12 via Frontend Transport; Fri, 15 Jul 2022 18:17:52 +0000
Received: from SATLEXMB07.amd.com (10.181.41.45) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Fri, 15 Jul
 2022 13:17:51 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB07.amd.com
 (10.181.41.45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Fri, 15 Jul
 2022 11:17:50 -0700
Received: from arch-sec.hitronhub.home (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2375.28 via
 Frontend Transport; Fri, 15 Jul 2022 13:17:50 -0500
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 22/31] drm/amd/display: Move phanton stream to FPU code
Date: Fri, 15 Jul 2022 14:16:56 -0400
Message-ID: <20220715181705.1030401-23-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.37.0
In-Reply-To: <20220715181705.1030401-1-Rodrigo.Siqueira@amd.com>
References: <20220715181705.1030401-1-Rodrigo.Siqueira@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bc4b82b3-312a-4bbd-96b6-08da668e54e9
X-MS-TrafficTypeDiagnostic: MWHPR12MB1181:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eiQBbFuJsY2d9njgvkE6hGVuAyC1eOkJVlZGJ1Amz+7oVl0hmmXqLOjEzWfGLU2YuBhCq0dCwMcDik4qmcailhcQ5wCwCEhitstOptlk6HTAFU6oCa4YsOELKIDhIZUL/vsZv0lR1qvU1gYVu/QDWkI/9Ds0aVb7uCcZt6zdUpY6dP4fZTmYXSZA0OcP4nU/X4oNNkK2Fsxy9gNc3sfY8zWke3xphxPTHsq7ViRokcIaNbmUooU1Hc97+lBuhrVY00u02q1xgdZZmcNOLvaidUl40N4CPuWnwUpZdUHVYbjBFKyQY7dLPrCggmL46GF7kk0pfy+MpeyrnF2uG89xVD7BmfNYWxY9qY7fv/f+lyL0KKSNVh98YOugVhjLmLDhdwbhoRxpLicdws1brN0sk7rnHt4ceYwyKXXArWY4/1adKKtbzY2BFzs8CQ6LiarQiS9coAzCLtpVZUYPZawADwIIFzsXoheAnSr2Xv/weeVIKDMVIJlQkMBehrgsWCLbwGdigVSKUyN7KIZvKnYHs2teMniTAxQB3aWuJ2CtDO2hoo5ijrt57Iyt5LsVbShuEAxs7wvxIAFy6VLHYYoynidleA5vnaEBBkMuTvvlPHIXX4V1fE36SUzvrLKyVWl0/OoPWdXDQUVcBUYuvTrKlbJu0nQxkzctNfkg1e74TLBrGQPXDVMyAMke2bzadAH1W/r1tLfXXIdbf2VqzcQDhnMTABcPeVRqXjlouRyoaUArhhlYlcp+F+AVSgE9cxd/9pSgzLwGJBzUYCRsB9iGYS0YZ5Ma1zqFo8GMEL8ZnAUQO8H4zHaIv7PW0+ZUHLy9OAWFk04JL8r9ku6SJDiFvIndtBS1bxd74AOxrnKL00I=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(346002)(396003)(39860400002)(376002)(136003)(40470700004)(36840700001)(46966006)(86362001)(36756003)(426003)(40460700003)(47076005)(336012)(82740400003)(83380400001)(36860700001)(186003)(2616005)(1076003)(26005)(8936002)(5660300002)(41300700001)(478600001)(82310400005)(8676002)(4326008)(356005)(6916009)(54906003)(81166007)(70206006)(2906002)(316002)(70586007)(40480700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2022 18:17:52.0455 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bc4b82b3-312a-4bbd-96b6-08da668e54e9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT018.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1181
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
Cc: stylon.wang@amd.com, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com, roman.li@amd.com,
 solomon.chiu@amd.com, Aurabindo.Pillai@amd.com, wayne.lin@amd.com,
 Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This commit moves phanton FPU stream to dcn32_fpu file.

Reviewed-by: Harry Wentland <Harry.Wentland@amd.com>
Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Signed-off-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 .../drm/amd/display/dc/dcn32/dcn32_resource.c | 89 +------------------
 .../drm/amd/display/dc/dml/dcn32/dcn32_fpu.c  | 84 +++++++++++++++++
 .../drm/amd/display/dc/dml/dcn32/dcn32_fpu.h  |  8 ++
 3 files changed, 94 insertions(+), 87 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c
index 1c124231b00a..a1bf24ad0787 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c
@@ -1831,93 +1831,6 @@ static void dcn32_enable_phantom_plane(struct dc *dc,
 	}
 }
 
-/**
- * ***************************************************************************************
- * dcn32_set_phantom_stream_timing: Set timing params for the phantom stream
- *
- * Set timing params of the phantom stream based on calculated output from DML.
- * This function first gets the DML pipe index using the DC pipe index, then
- * calls into DML (get_subviewport_lines_needed_in_mall) to get the number of
- * lines required for SubVP MCLK switching and assigns to the phantom stream
- * accordingly.
- *
- * - The number of SubVP lines calculated in DML does not take into account
- * FW processing delays and required pstate allow width, so we must include
- * that separately.
- *
- * - Set phantom backporch = vstartup of main pipe
- *
- * @param [in] dc: current dc state
- * @param [in] context: new dc state
- * @param [in] ref_pipe: Main pipe for the phantom stream
- * @param [in] pipes: DML pipe params
- * @param [in] pipe_cnt: number of DML pipes
- * @param [in] dc_pipe_idx: DC pipe index for the main pipe (i.e. ref_pipe)
- *
- * @return: void
- *
- * ***************************************************************************************
- */
-static void dcn32_set_phantom_stream_timing(struct dc *dc,
-		struct dc_state *context,
-		struct pipe_ctx *ref_pipe,
-		struct dc_stream_state *phantom_stream,
-		display_e2e_pipe_params_st *pipes,
-		unsigned int pipe_cnt,
-		unsigned int dc_pipe_idx)
-{
-	unsigned int i, pipe_idx;
-	struct pipe_ctx *pipe;
-	uint32_t phantom_vactive, phantom_bp, pstate_width_fw_delay_lines;
-	unsigned int vlevel = context->bw_ctx.dml.vba.VoltageLevel;
-	unsigned int dcfclk = context->bw_ctx.dml.vba.DCFCLKState[vlevel][context->bw_ctx.dml.vba.maxMpcComb];
-	unsigned int socclk = context->bw_ctx.dml.vba.SOCCLKPerState[vlevel];
-
-	// Find DML pipe index (pipe_idx) using dc_pipe_idx
-	for (i = 0, pipe_idx = 0; i < dc->res_pool->pipe_count; i++) {
-		pipe = &context->res_ctx.pipe_ctx[i];
-
-		if (!pipe->stream)
-			continue;
-
-		if (i == dc_pipe_idx)
-			break;
-
-		pipe_idx++;
-	}
-
-	// Calculate lines required for pstate allow width and FW processing delays
-	pstate_width_fw_delay_lines = ((double)(dc->caps.subvp_fw_processing_delay_us +
-			dc->caps.subvp_pstate_allow_width_us) / 1000000) *
-			(ref_pipe->stream->timing.pix_clk_100hz * 100) /
-			(double)ref_pipe->stream->timing.h_total;
-
-	// Update clks_cfg for calling into recalculate
-	pipes[0].clks_cfg.voltage = vlevel;
-	pipes[0].clks_cfg.dcfclk_mhz = dcfclk;
-	pipes[0].clks_cfg.socclk_mhz = socclk;
-
-	// DML calculation for MALL region doesn't take into account FW delay
-	// and required pstate allow width for multi-display cases
-	phantom_vactive = get_subviewport_lines_needed_in_mall(&context->bw_ctx.dml, pipes, pipe_cnt, pipe_idx) +
-				pstate_width_fw_delay_lines;
-
-	// For backporch of phantom pipe, use vstartup of the main pipe
-	phantom_bp = get_vstartup(&context->bw_ctx.dml, pipes, pipe_cnt, pipe_idx);
-
-	phantom_stream->dst.y = 0;
-	phantom_stream->dst.height = phantom_vactive;
-	phantom_stream->src.y = 0;
-	phantom_stream->src.height = phantom_vactive;
-
-	phantom_stream->timing.v_addressable = phantom_vactive;
-	phantom_stream->timing.v_front_porch = 1;
-	phantom_stream->timing.v_total = phantom_stream->timing.v_addressable +
-						phantom_stream->timing.v_front_porch +
-						phantom_stream->timing.v_sync_width +
-						phantom_bp;
-}
-
 static struct dc_stream_state *dcn32_enable_phantom_stream(struct dc *dc,
 		struct dc_state *context,
 		display_e2e_pipe_params_st *pipes,
@@ -1939,7 +1852,9 @@ static struct dc_stream_state *dcn32_enable_phantom_stream(struct dc *dc,
 	memcpy(&phantom_stream->timing, &ref_pipe->stream->timing, sizeof(phantom_stream->timing));
 	memcpy(&phantom_stream->src, &ref_pipe->stream->src, sizeof(phantom_stream->src));
 	memcpy(&phantom_stream->dst, &ref_pipe->stream->dst, sizeof(phantom_stream->dst));
+	DC_FP_START();
 	dcn32_set_phantom_stream_timing(dc, context, ref_pipe, phantom_stream, pipes, pipe_cnt, dc_pipe_idx);
+	DC_FP_END();
 
 	dc_add_stream_to_ctx(dc, context, phantom_stream);
 	return phantom_stream;
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c b/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
index 4223a9a9dd45..74ccf453349c 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
@@ -377,3 +377,87 @@ void insert_entry_into_table_sorted(struct _vcs_dpi_voltage_scaling_st *table,
 	}
 }
 
+/**
+ * dcn32_set_phantom_stream_timing: Set timing params for the phantom stream
+ *
+ * Set timing params of the phantom stream based on calculated output from DML.
+ * This function first gets the DML pipe index using the DC pipe index, then
+ * calls into DML (get_subviewport_lines_needed_in_mall) to get the number of
+ * lines required for SubVP MCLK switching and assigns to the phantom stream
+ * accordingly.
+ *
+ * - The number of SubVP lines calculated in DML does not take into account
+ * FW processing delays and required pstate allow width, so we must include
+ * that separately.
+ *
+ * - Set phantom backporch = vstartup of main pipe
+ *
+ * @dc: current dc state
+ * @context: new dc state
+ * @ref_pipe: Main pipe for the phantom stream
+ * @pipes: DML pipe params
+ * @pipe_cnt: number of DML pipes
+ * @dc_pipe_idx: DC pipe index for the main pipe (i.e. ref_pipe)
+ */
+void dcn32_set_phantom_stream_timing(struct dc *dc,
+				     struct dc_state *context,
+				     struct pipe_ctx *ref_pipe,
+				     struct dc_stream_state *phantom_stream,
+				     display_e2e_pipe_params_st *pipes,
+				     unsigned int pipe_cnt,
+				     unsigned int dc_pipe_idx)
+{
+	unsigned int i, pipe_idx;
+	struct pipe_ctx *pipe;
+	uint32_t phantom_vactive, phantom_bp, pstate_width_fw_delay_lines;
+	unsigned int vlevel = context->bw_ctx.dml.vba.VoltageLevel;
+	unsigned int dcfclk = context->bw_ctx.dml.vba.DCFCLKState[vlevel][context->bw_ctx.dml.vba.maxMpcComb];
+	unsigned int socclk = context->bw_ctx.dml.vba.SOCCLKPerState[vlevel];
+
+	dc_assert_fp_enabled();
+
+	// Find DML pipe index (pipe_idx) using dc_pipe_idx
+	for (i = 0, pipe_idx = 0; i < dc->res_pool->pipe_count; i++) {
+		pipe = &context->res_ctx.pipe_ctx[i];
+
+		if (!pipe->stream)
+			continue;
+
+		if (i == dc_pipe_idx)
+			break;
+
+		pipe_idx++;
+	}
+
+	// Calculate lines required for pstate allow width and FW processing delays
+	pstate_width_fw_delay_lines = ((double)(dc->caps.subvp_fw_processing_delay_us +
+			dc->caps.subvp_pstate_allow_width_us) / 1000000) *
+			(ref_pipe->stream->timing.pix_clk_100hz * 100) /
+			(double)ref_pipe->stream->timing.h_total;
+
+	// Update clks_cfg for calling into recalculate
+	pipes[0].clks_cfg.voltage = vlevel;
+	pipes[0].clks_cfg.dcfclk_mhz = dcfclk;
+	pipes[0].clks_cfg.socclk_mhz = socclk;
+
+	// DML calculation for MALL region doesn't take into account FW delay
+	// and required pstate allow width for multi-display cases
+	phantom_vactive = get_subviewport_lines_needed_in_mall(&context->bw_ctx.dml, pipes, pipe_cnt, pipe_idx) +
+				pstate_width_fw_delay_lines;
+
+	// For backporch of phantom pipe, use vstartup of the main pipe
+	phantom_bp = get_vstartup(&context->bw_ctx.dml, pipes, pipe_cnt, pipe_idx);
+
+	phantom_stream->dst.y = 0;
+	phantom_stream->dst.height = phantom_vactive;
+	phantom_stream->src.y = 0;
+	phantom_stream->src.height = phantom_vactive;
+
+	phantom_stream->timing.v_addressable = phantom_vactive;
+	phantom_stream->timing.v_front_porch = 1;
+	phantom_stream->timing.v_total = phantom_stream->timing.v_addressable +
+						phantom_stream->timing.v_front_porch +
+						phantom_stream->timing.v_sync_width +
+						phantom_bp;
+}
+
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.h b/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.h
index 62cb0c1d462c..4abef908dca9 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.h
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.h
@@ -49,4 +49,12 @@ void insert_entry_into_table_sorted(struct _vcs_dpi_voltage_scaling_st *table,
 				    unsigned int *num_entries,
 				    struct _vcs_dpi_voltage_scaling_st *entry);
 
+void dcn32_set_phantom_stream_timing(struct dc *dc,
+				     struct dc_state *context,
+				     struct pipe_ctx *ref_pipe,
+				     struct dc_stream_state *phantom_stream,
+				     display_e2e_pipe_params_st *pipes,
+				     unsigned int pipe_cnt,
+				     unsigned int dc_pipe_idx);
+
 #endif
-- 
2.37.0

