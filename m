Return-Path: <SRS0=vXfK=NL=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18CEBC4338F
	for <amd-gfx@archiver.kernel.org>; Fri, 20 Aug 2021 23:30:06 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AE4FD61183
	for <amd-gfx@archiver.kernel.org>; Fri, 20 Aug 2021 23:30:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org AE4FD61183
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3DA456EB2D;
	Fri, 20 Aug 2021 23:30:05 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2058.outbound.protection.outlook.com [40.107.243.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3A4926EB2D
 for <amd-gfx@lists.freedesktop.org>; Fri, 20 Aug 2021 23:30:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Gzd7MwwJb1b1yYTejCzPPE8QRre9+xvyDiui+Slbv2ZS2l2m1wdpUUHA+MNXf3NWt9ycgGw6oV+siX+2A9InFWxF/5GGcpQY3GkbzRGGTA0stJwSx8yxRN3/2uFneW8UTQuOhaSDS2o0QM32V9qqX8gj0u2UVebCMaHEDZmpTV2JkV07Gwy45PEkWMEeSE9rKD6z3XSteTSl9Syu79BOk/IBIRIlzHdBtIBOTQfR251EEyR7Aj86/01+dvi6xYfSlWIXi0XF6nQD77I0CpUlSu3BW7NJlmesguF5n5cZ9Dd/AuQ5aXbMY/qdRIebEP/H82Xx90il7v9SsSxUklCSnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QC3RmP7+iWW7Jse0K2nv3uGFZ1cyL22khvHgJyDtoKs=;
 b=PCTTukVsi5d9Qmca8O2CLpMfH/NBdM5ZVsVdgEC3zgLemQknAPPjUh/AKBoegrEDj5Bn3xHL8i0m+/zxe2Aodp6GcRfULadHGtCYGgo7nxqp9/h9s4FP7Szmqw9gGogYiD3sUWwR9TTgvLTA+xnRqQVqVbg2qetwXOOGjSl5FWvJ6m6/xSsY+MwRItVLsWnU9Eog4A34he/Uv8CO14Bo3iqiceHEaCrOnKru97lNB/jSPTTK8QTMW1YR9dfw8kiyLPk0hHlx2qmA3S2MhUGz1awr0u5pWmqQo4sux+Gj0F4TQUzqRbE1oIYoorXNmOIGGhqNtbnWDfToNjJeeWxOWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QC3RmP7+iWW7Jse0K2nv3uGFZ1cyL22khvHgJyDtoKs=;
 b=16l2ZqUYzg8yVuqPK5kPs5DGvNE9sYzfSMJsGym92b+0v4wLSlPVRoBz+T/G55ixpVvw27NFDcuf2UQaivR/G9fcPEQ9pt9nYYa1JoQJQvzCwNdRq9Ow2c3Dzyg8voePMvb2NmDtpMx2qOIUeKvOxRzspi4WKFERZsInv6hVoro=
Received: from BN9PR03CA0485.namprd03.prod.outlook.com (2603:10b6:408:130::10)
 by MN2PR12MB3022.namprd12.prod.outlook.com (2603:10b6:208:ce::32)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.18; Fri, 20 Aug
 2021 23:15:38 +0000
Received: from BN8NAM11FT006.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:130:cafe::5) by BN9PR03CA0485.outlook.office365.com
 (2603:10b6:408:130::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19 via Frontend
 Transport; Fri, 20 Aug 2021 23:15:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT006.mail.protection.outlook.com (10.13.177.21) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4436.19 via Frontend Transport; Fri, 20 Aug 2021 23:15:38 +0000
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.12; Fri, 20 Aug
 2021 18:15:35 -0500
From: Qingqing Zhuo <qingqing.zhuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Bhawanpreet.Lakha@amd.com>, <Rodrigo.Siqueira@amd.com>,
 <Aurabindo.Pillai@amd.com>, <qingqing.zhuo@amd.com>, <mikita.lipski@amd.com>, 
 <roman.li@amd.com>, <Anson.Jacob@amd.com>, Michael Strauss
 <michael.strauss@amd.com>, Eric Yang <Eric.Yang2@amd.com>
Subject: [PATCH 03/10] drm/amd/display: Set min dcfclk if pipe count is 0
Date: Fri, 20 Aug 2021 19:15:13 -0400
Message-ID: <20210820231520.1243509-3-qingqing.zhuo@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210820231520.1243509-1-qingqing.zhuo@amd.com>
References: <20210820231520.1243509-1-qingqing.zhuo@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e3f38118-c4e2-4b4d-0f76-08d964306be2
X-MS-TrafficTypeDiagnostic: MN2PR12MB3022:
X-Microsoft-Antispam-PRVS: <MN2PR12MB30229FE563FDE0B2932846ECFBC19@MN2PR12MB3022.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xW2cjQYXjPBmI2kUVqKyWearkgNCARdfX99GkW87LQsEdUHZW8pNvjPtfDl0GjuJf+BS8AQNIFRMpcYIRwp0VulSHCnHHrCIVGvGpc7cuuUYqCYuVga9lkQaGX4Rk1MkXgLUzP+m10wp30rJzWsSz+WNdrbaJTwLu6Sn3yHARsBRGat3DzY8HHhFAh8y6jG752DozghKpj2n7a8+Wq17UEZtyFdThG8lSG/gz+RbTDK5Zo6bCMNWQLIF6mdk1iUas0AcUFxvw6m3W02hzyXd5cjlR0o2XEOfYIw28Svz7jL7OBiQ/vkH/2pNZD870UouVCIFLEqBwu3Rq/q4MtMFmi99QAKDC6JiK4n+vNexWcaRcEPviM03G5GLJcr0SVr4XlHPlqP8rRNelGUoNW4FmzdKi45u4pxitNArXjKjHbQaMMBTSvnH8B3/waQT+tSAKO0kUd7FwW46fm9dMHGou2tfUSvvsoZZDUYC6gRHLiy6psPg3ON7El5/EsyPYSIiiZc4LMr82Asca6pxwtFZ5F2AAVsKlVHaJJ01e9NujdwvBPfXzOSVqIewk2lpwFxwnsygpuOyLT2LCdez3qZQXgETtxwdeLqT2cWOEk7BfB7sGjdopGqr9o2Y9wc3A78wu5Zlm28A/fBvrF+aSiLUed85kNK8XOGgYL1d75B/8D38407qEzbqBrKi8ohJKl5Bo7icWSt/ztXVG+s3eSX98W+gS10IMsU0gjOH+vMF6h3rFU5Putok8PLYva+vj4yDs7skHNE8quHY78VIa5UlbQWY55H/nmh85W/gRe2Kv1A=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(39860400002)(376002)(396003)(136003)(346002)(36840700001)(46966006)(8676002)(426003)(336012)(44832011)(83380400001)(36860700001)(82740400003)(34020700004)(2906002)(6916009)(81166007)(70586007)(2616005)(478600001)(8936002)(26005)(356005)(86362001)(70206006)(82310400003)(316002)(16526019)(5660300002)(186003)(4326008)(6666004)(47076005)(54906003)(1076003)(36756003)(40753002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2021 23:15:38.0401 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e3f38118-c4e2-4b4d-0f76-08d964306be2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT006.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3022
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
Clocks don't get recalculated in 0 stream/0 pipe configs,
blocking S0i3 if dcfclk gets high enough

[HOW]
Create DCN31 copy of DCN30 bandwidth validation func which
doesn't entirely skip validation in 0 pipe scenarios

Override dcfclk to vlevel 0/min value during validation if pipe
count is 0

Reviewed-by: Eric Yang <Eric.Yang2@amd.com>
Acked-by: Qingqing Zhuo <qingqing.zhuo@amd.com>
Signed-off-by: Michael Strauss <michael.strauss@amd.com>
---
 .../drm/amd/display/dc/dcn30/dcn30_resource.c |  2 +-
 .../drm/amd/display/dc/dcn30/dcn30_resource.h |  7 +++
 .../drm/amd/display/dc/dcn31/dcn31_resource.c | 63 ++++++++++++++++++-
 3 files changed, 70 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c
index 28e15ebf2f43..1333f0541f1b 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c
@@ -1856,7 +1856,7 @@ static struct pipe_ctx *dcn30_find_split_pipe(
 	return pipe;
 }
 
-static noinline bool dcn30_internal_validate_bw(
+noinline bool dcn30_internal_validate_bw(
 		struct dc *dc,
 		struct dc_state *context,
 		display_e2e_pipe_params_st *pipes,
diff --git a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.h b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.h
index b754b89beadf..b92e4cc0232f 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.h
+++ b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.h
@@ -55,6 +55,13 @@ unsigned int dcn30_calc_max_scaled_time(
 
 bool dcn30_validate_bandwidth(struct dc *dc, struct dc_state *context,
 		bool fast_validate);
+bool dcn30_internal_validate_bw(
+		struct dc *dc,
+		struct dc_state *context,
+		display_e2e_pipe_params_st *pipes,
+		int *pipe_cnt_out,
+		int *vlevel_out,
+		bool fast_validate);
 void dcn30_calculate_wm_and_dlg(
 		struct dc *dc, struct dc_state *context,
 		display_e2e_pipe_params_st *pipes,
diff --git a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_resource.c b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_resource.c
index 3f92f27dac20..49563cfabdcd 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_resource.c
@@ -1647,6 +1647,15 @@ static void dcn31_calculate_wm_and_dlg_fp(
 	if (context->bw_ctx.dml.soc.min_dcfclk > dcfclk)
 		dcfclk = context->bw_ctx.dml.soc.min_dcfclk;
 
+	/* We don't recalculate clocks for 0 pipe configs, which can block
+	 * S0i3 as high clocks will block low power states
+	 * Override any clocks that can block S0i3 to min here
+	 */
+	if (pipe_cnt == 0) {
+		context->bw_ctx.bw.dcn.clk.dcfclk_khz = dcfclk; // always should be vlevel 0
+		return;
+	}
+
 	pipes[0].clks_cfg.voltage = vlevel;
 	pipes[0].clks_cfg.dcfclk_mhz = dcfclk;
 	pipes[0].clks_cfg.socclk_mhz = context->bw_ctx.dml.soc.clock_limits[vlevel].socclk_mhz;
@@ -1772,6 +1781,58 @@ static void dcn31_calculate_wm_and_dlg(
 	DC_FP_END();
 }
 
+bool dcn31_validate_bandwidth(struct dc *dc,
+		struct dc_state *context,
+		bool fast_validate)
+{
+	bool out = false;
+
+	BW_VAL_TRACE_SETUP();
+
+	int vlevel = 0;
+	int pipe_cnt = 0;
+	display_e2e_pipe_params_st *pipes = kzalloc(dc->res_pool->pipe_count * sizeof(display_e2e_pipe_params_st), GFP_KERNEL);
+	DC_LOGGER_INIT(dc->ctx->logger);
+
+	BW_VAL_TRACE_COUNT();
+
+	out = dcn30_internal_validate_bw(dc, context, pipes, &pipe_cnt, &vlevel, fast_validate);
+
+	// Disable fast_validate to set min dcfclk in alculate_wm_and_dlg
+	if (pipe_cnt == 0)
+		fast_validate = false;
+
+	if (!out)
+		goto validate_fail;
+
+	BW_VAL_TRACE_END_VOLTAGE_LEVEL();
+
+	if (fast_validate) {
+		BW_VAL_TRACE_SKIP(fast);
+		goto validate_out;
+	}
+
+	dc->res_pool->funcs->calculate_wm_and_dlg(dc, context, pipes, pipe_cnt, vlevel);
+
+	BW_VAL_TRACE_END_WATERMARKS();
+
+	goto validate_out;
+
+validate_fail:
+	DC_LOG_WARNING("Mode Validation Warning: %s failed alidation.\n",
+		dml_get_status_message(context->bw_ctx.dml.vba.ValidationStatus[context->bw_ctx.dml.vba.soc.num_states]));
+
+	BW_VAL_TRACE_SKIP(fail);
+	out = false;
+
+validate_out:
+	kfree(pipes);
+
+	BW_VAL_TRACE_FINISH();
+
+	return out;
+}
+
 static struct dc_cap_funcs cap_funcs = {
 	.get_dcc_compression_cap = dcn20_get_dcc_compression_cap
 };
@@ -1854,7 +1915,7 @@ static struct resource_funcs dcn31_res_pool_funcs = {
 	.link_encs_assign = link_enc_cfg_link_encs_assign,
 	.link_enc_unassign = link_enc_cfg_link_enc_unassign,
 	.panel_cntl_create = dcn31_panel_cntl_create,
-	.validate_bandwidth = dcn30_validate_bandwidth,
+	.validate_bandwidth = dcn31_validate_bandwidth,
 	.calculate_wm_and_dlg = dcn31_calculate_wm_and_dlg,
 	.update_soc_for_wm_a = dcn31_update_soc_for_wm_a,
 	.populate_dml_pipes = dcn31_populate_dml_pipes_from_context,
-- 
2.25.1

