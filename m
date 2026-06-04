Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2EAC1CD6E78
	for <amd-gfx@archiver.kernel.org>; Thu,  4 Jun 2026 14:55:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 46C22112841;
	Thu,  4 Jun 2026 14:55:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="XOJLV+zh";
	dkim-atps=neutral
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012040.outbound.protection.outlook.com
 [40.107.200.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B1420112860
 for <amd-gfx@lists.freedesktop.org>; Thu,  4 Jun 2026 14:55:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lz6BAUby7e/a1e1PMqQqK33cM+ajFy210ZXzEWEtsl6wuXhVHlGizCuCGtRK7ZDd+SvolSsz/QT0aJ2t1UNP/wdyQnzxb3jQeI9FhRuEvJ5cJ4l5sntpPpz6fGxjzkbFViJIli8kVMbIvH83F38mpb3iCwPfTif+6dQUnwiDPDFkrRDyWP13C0BoSOvD9rfdMGtfVlFTY0X3gMkLutmfn61FYWInbwgca785SxF5vFt9SThj8vtIEotULrpmD03RzykJTA4rHDK53LneON40HIMqnZbhOIPXIay2jNVQJvYGDRFQKVxKky54TA6gxEHAltD9/X+cOoXqrT7CgXokhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GBLRTeLDUaT5aq3gm7bLlcEhCWF6uku76/ncddMLOwk=;
 b=f8M8f76HCg/Ed3UMScZoOapZshghPLIfSO5iDLIabwnXDalvD39flmkxbezO3BfEkarCndl0DgzkDFgxj6d18VZMGCtulmZs14S4+id5IrWsP1p4ZxS6JsDrCr/0TfPEt1QKD1Oqs84xaIYLv9qpeIBBnvXY82Ir4my+uaRJBkiQZCiGoJhQdbNDBIxn+wEiwNQYqgKXxWz9iKV2gZpx80eC4ALbB1K5tJtp/ajPlzrvivfblj9yzlLQH5n8+KU/FE3quSXgN5buFSE9suk7Q8kmLIXUKmcAP9KbmmrcUTmyj5kmZCziaBlToYvxpeg/lMJ2fbydKE2avXxIOaGTRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GBLRTeLDUaT5aq3gm7bLlcEhCWF6uku76/ncddMLOwk=;
 b=XOJLV+zho7nKes44UiyDbELdkPAbMbN0yRvlJlez3u6Upa8hd0J+w2t8LHr0ltZ01PpLm4h5MAeKvK8WfEkUlQJ9ZpSFfEcDDJEKnHFcteTpD2ZpqVQNtEnc0Lm+Q9yTiC+pY6LQ9rpb6LGW+pT72nJ/XCyN+FywOQCiZ91v1+Q=
Received: from BL1PR13CA0218.namprd13.prod.outlook.com (2603:10b6:208:2bf::13)
 by LV9PR12MB9760.namprd12.prod.outlook.com (2603:10b6:408:2f0::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.7; Thu, 4 Jun 2026
 14:54:58 +0000
Received: from BN1PEPF0000468E.namprd05.prod.outlook.com
 (2603:10b6:208:2bf:cafe::85) by BL1PR13CA0218.outlook.office365.com
 (2603:10b6:208:2bf::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.92.8 via Frontend Transport; Thu, 4
 Jun 2026 14:54:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN1PEPF0000468E.mail.protection.outlook.com (10.167.243.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.5 via Frontend Transport; Thu, 4 Jun 2026 14:54:56 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 4 Jun
 2026 09:54:46 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 4 Jun
 2026 09:54:46 -0500
Received: from aaurabin-tumbleweed.king-squeaker.ts.net (10.180.168.240) by
 satlexmb08.amd.com (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41
 via Frontend Transport; Thu, 4 Jun 2026 09:54:40 -0500
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Austin Zheng <austin.zheng@amd.com>, "Nicholas
 Kazlauskas" <nicholas.kazlauskas@amd.com>, Austin Zheng
 <Austin.Zheng@amd.com>
Subject: [PATCH 03/24] drm/amd/display: Deprecate DMUB register offload
 functionality
Date: Thu, 4 Jun 2026 10:51:57 -0400
Message-ID: <20260604145428.809959-4-aurabindo.pillai@amd.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260604145428.809959-1-aurabindo.pillai@amd.com>
References: <20260604145428.809959-1-aurabindo.pillai@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF0000468E:EE_|LV9PR12MB9760:EE_
X-MS-Office365-Filtering-Correlation-Id: 8f517dbf-f180-4c64-6f16-08dec2493e5a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700016|82310400026|376014|6133799003|18002099003|3023799007|11063799006|56012099006|22082099003;
X-Microsoft-Antispam-Message-Info: BLxqoI6OZl88f699XWzMVIiFm3NtwaF7ukN3KbofgmK66hbxa4B8l+tjEpqV5yzKX0B2PiJzR2TGa4WBn3iusozPzCwrsvmqiqadJsFxQNNOsd5UxgUJT6RhKpFhpAFC/GQsIDJeD9FbEPDshUiMvY6MJs10Wzv7AML4Hc4bBFxk+fYh8zYhnWmzkqqM3t1PdDC5KLJ1TNoroff17lOFcr0oGtpl1P/mFix3ckru+79AvsQans2yIPNlj/1Q+HHIJtAxUugZWFQ9yA8+461rvtBJQJ+lbTZI9PyQ1vj45RaI/3sJxQGUaJjYa1f86UE3k9l605UcGUkBR5wSynIcdeFK+Vq/2y4YjfO+TWk66vxwhJTvtpngj8IL8n4AoX7D5PPX+CPcRNAhrNgEYk9zjQh2qpto3cfv6JPniIkEt69F5I2xytKHXzEhay8ahjbtYKzhtQSuypCzhDYgk38DfpEkQ8dJKaiXz5yro68FE5darN/q6vUuswf6fao3kpKA26GhrUbH1EB+cMDg/FH2YBl7yL7FOiVkaFLzNyeH59vsf6TzkPV70He8BausGEy2PKJWDLNwaqTjQV5DsYOu4ZU439+agKQxTH2v8wjAc4yOlS2WruKjzvL50+4dtHMo7QikISbkC0T9dwvahZUo/WeEXvGeGMf+iIqRd0AHHTzXFcKLA9lisbCPtKVbrh5zHWifEjVdjyzKu6JoiPj1pEv2QbWPEbGkIBEcfCrjOxI=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700016)(82310400026)(376014)(6133799003)(18002099003)(3023799007)(11063799006)(56012099006)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: N8LS9D84gH+ARn8oZEe9RCoVsmEmSkwn8Q4rHkK+ZFKEWj9bvPv9Pg4ACACgXF4PRoLCotY2woYVH3gxJqxhIV1mweLh3ryALawhs4XFlWlFRBG/tl9pvTA4NMtlR7/dwPujEarUQIhQyLxZvxHwwhEf1Rd4wfQJ0Zy+y5+oei4WaTUwecRpsbFQnMVbNqk3IGhiEwEMlMUPnNzoQ/aZLf92HzcM4pAqqFXqizJ3zNUO+G8KElZzqsglK8Ba6iOvDtxCNiL/qATJzD4nRELXnmSj0fvl2tYhQG/puY99mjG+t0MXRzDNwyQd321picVRtIZ+olpMEDIgCyqGDac2vMCdBSbIFft3GFdnYn8WMyTaEt3g7QP+NJ/YkRpY8TFG3B8YNowAIouIZawZDbS7uzl6iJD3Ey7rtktyt4tIFJOod8lhZlKnRczn2sJKaNL8
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2026 14:54:56.7305 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f517dbf-f180-4c64-6f16-08dec2493e5a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF0000468E.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV9PR12MB9760
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

From: Austin Zheng <austin.zheng@amd.com>

[Why]
The DMUB register offload feature should no longer be used.
This was originally a debug feature for DCN21.
No longer applicable to the DMUB programming model.

[How]
Remove DMUB register offload infrastructure including helper
functions, structures, debug options, and register sequence macros.

Reviewed-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Signed-off-by: Austin Zheng <Austin.Zheng@amd.com>
Signed-off-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |   7 -
 drivers/gpu/drm/amd/display/dc/dc.h           |   3 -
 drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c  |  12 -
 drivers/gpu/drm/amd/display/dc/dc_dmub_srv.h  |   9 -
 drivers/gpu/drm/amd/display/dc/dc_helper.c    | 226 ------------------
 drivers/gpu/drm/amd/display/dc/dm_services.h  |   4 -
 .../amd/display/dc/dpp/dcn10/dcn10_dpp_cm.c   |   5 -
 .../amd/display/dc/hwss/dcn35/dcn35_hwseq.c   |   3 -
 .../gpu/drm/amd/display/dc/inc/reg_helper.h   |  19 --
 .../drm/amd/display/dc/mpc/dcn20/dcn20_mpc.c  |   4 -
 .../amd/display/dc/optc/dcn10/dcn10_optc.c    |   5 -
 .../amd/display/dc/optc/dcn20/dcn20_optc.c    |   5 -
 .../amd/display/dc/optc/dcn31/dcn31_optc.c    |   5 -
 .../amd/display/dc/optc/dcn314/dcn314_optc.c  |   5 -
 .../amd/display/dc/optc/dcn32/dcn32_optc.c    |   5 -
 .../amd/display/dc/optc/dcn35/dcn35_optc.c    |   5 -
 .../amd/display/dc/optc/dcn401/dcn401_optc.c  |   5 -
 .../dc/resource/dcn35/dcn35_resource.c        |   1 -
 .../dc/resource/dcn351/dcn351_resource.c      |   1 -
 .../dc/resource/dcn36/dcn36_resource.c        |   1 -
 20 files changed, 330 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 6c1e7e13f039..46993b5ae688 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -13913,13 +13913,6 @@ uint32_t dm_read_reg_func(const struct dc_context *ctx, uint32_t address,
 	}
 #endif
 
-	if (ctx->dmub_srv &&
-	    ctx->dmub_srv->reg_helper_offload.gather_in_progress &&
-	    !ctx->dmub_srv->reg_helper_offload.should_burst_write) {
-		ASSERT(false);
-		return 0;
-	}
-
 	amdgpu_dm_exit_ips_for_hw_access(ctx->dc);
 
 	value = cgs_read_register(ctx->cgs_device, address);
diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index 82d02ebbd829..d5d9d56fbcb8 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -1129,8 +1129,6 @@ struct dc_debug_options {
 	unsigned int force_fclk_khz;
 	bool enable_tri_buf;
 	bool ips_disallow_entry;
-	bool dmub_offload_enabled;
-	bool dmcub_emulation;
 	bool disable_idle_power_optimizations;
 	unsigned int mall_size_override;
 	unsigned int mall_additional_timer_percent;
@@ -1332,7 +1330,6 @@ struct dc_init_data {
 	enum dce_environment dce_environment;
 
 	struct dmub_offload_funcs *dmub_if;
-	struct dc_reg_helper_state *dmub_offload;
 
 	struct dc_config flags;
 	uint64_t log_mask;
diff --git a/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c b/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
index ea0210216d9e..66836b38d0e1 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
+++ b/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
@@ -518,9 +518,6 @@ void dc_dmub_srv_query_caps_cmd(struct dc_dmub_srv *dc_dmub_srv)
 {
 	union dmub_rb_cmd cmd = { 0 };
 
-	if (dc_dmub_srv->ctx->dc->debug.dmcub_emulation)
-		return;
-
 	memset(&cmd, 0, sizeof(cmd));
 
 	/* Prepare fw command */
@@ -1302,9 +1299,6 @@ bool dc_dmub_srv_is_hw_pwr_up(struct dc_dmub_srv *dc_dmub_srv, bool wait)
 	if (!dc_dmub_srv || !dc_dmub_srv->dmub)
 		return true;
 
-	if (dc_dmub_srv->ctx->dc->debug.dmcub_emulation)
-		return true;
-
 	dc_ctx = dc_dmub_srv->ctx;
 
 	if (wait) {
@@ -1345,9 +1339,6 @@ static void dc_dmub_srv_notify_idle(const struct dc *dc, bool allow_idle)
 	struct dc_dmub_srv *dc_dmub_srv;
 	union dmub_rb_cmd cmd = {0};
 
-	if (dc->debug.dmcub_emulation)
-		return;
-
 	if (!dc->ctx->dmub_srv || !dc->ctx->dmub_srv->dmub)
 		return;
 
@@ -1466,9 +1457,6 @@ static void dc_dmub_srv_exit_low_power_state(const struct dc *dc)
 	struct dc_dmub_srv *dc_dmub_srv;
 	uint32_t rcg_exit_count = 0, ips1_exit_count = 0, ips2_exit_count = 0, ips1z8_exit_count = 0;
 
-	if (dc->debug.dmcub_emulation)
-		return;
-
 	if (!dc->ctx->dmub_srv || !dc->ctx->dmub_srv->dmub)
 		return;
 
diff --git a/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.h b/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.h
index ebcaf49e5961..5d399e6a8345 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.h
@@ -37,17 +37,8 @@ struct dc_crtc_timing;
 struct dc_state;
 struct dc_surface_update;
 
-struct dc_reg_helper_state {
-	bool gather_in_progress;
-	uint32_t same_addr_count;
-	bool should_burst_write;
-	union dmub_rb_cmd cmd_data;
-	unsigned int reg_seq_count;
-};
-
 struct dc_dmub_srv {
 	struct dmub_srv *dmub;
-	struct dc_reg_helper_state reg_helper_offload;
 
 	struct dc_context *ctx;
 	void *dm;
diff --git a/drivers/gpu/drm/amd/display/dc/dc_helper.c b/drivers/gpu/drm/amd/display/dc/dc_helper.c
index 0e0165764a57..cc7fea613d9e 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_helper.c
+++ b/drivers/gpu/drm/amd/display/dc/dc_helper.c
@@ -39,53 +39,6 @@
 #define DC_LOGGER \
 	ctx->logger
 
-static inline void submit_dmub_read_modify_write(
-	struct dc_reg_helper_state *offload,
-	const struct dc_context *ctx)
-{
-	struct dmub_rb_cmd_read_modify_write *cmd_buf = &offload->cmd_data.read_modify_write;
-
-	offload->should_burst_write =
-			(offload->same_addr_count == (DMUB_READ_MODIFY_WRITE_SEQ__MAX - 1));
-	cmd_buf->header.payload_bytes =
-			sizeof(struct dmub_cmd_read_modify_write_sequence) * offload->reg_seq_count;
-
-	dc_wake_and_execute_dmub_cmd(ctx, &offload->cmd_data, DM_DMUB_WAIT_TYPE_NO_WAIT);
-
-	memset(cmd_buf, 0, sizeof(*cmd_buf));
-
-	offload->reg_seq_count = 0;
-	offload->same_addr_count = 0;
-}
-
-static inline void submit_dmub_burst_write(
-	struct dc_reg_helper_state *offload,
-	const struct dc_context *ctx)
-{
-	struct dmub_rb_cmd_burst_write *cmd_buf = &offload->cmd_data.burst_write;
-
-	cmd_buf->header.payload_bytes =
-			sizeof(uint32_t) * offload->reg_seq_count;
-
-	dc_wake_and_execute_dmub_cmd(ctx, &offload->cmd_data, DM_DMUB_WAIT_TYPE_NO_WAIT);
-
-	memset(cmd_buf, 0, sizeof(*cmd_buf));
-
-	offload->reg_seq_count = 0;
-}
-
-static inline void submit_dmub_reg_wait(
-		struct dc_reg_helper_state *offload,
-		const struct dc_context *ctx)
-{
-	struct dmub_rb_cmd_reg_wait *cmd_buf = &offload->cmd_data.reg_wait;
-
-	dc_wake_and_execute_dmub_cmd(ctx, &offload->cmd_data, DM_DMUB_WAIT_TYPE_NO_WAIT);
-
-	memset(cmd_buf, 0, sizeof(*cmd_buf));
-	offload->reg_seq_count = 0;
-}
-
 struct dc_reg_value_masks {
 	uint32_t value;
 	uint32_t mask;
@@ -127,98 +80,6 @@ static void set_reg_field_values(struct dc_reg_value_masks *field_value_mask,
 	}
 }
 
-static void dmub_flush_buffer_execute(
-		struct dc_reg_helper_state *offload,
-		const struct dc_context *ctx)
-{
-	submit_dmub_read_modify_write(offload, ctx);
-}
-
-static void dmub_flush_burst_write_buffer_execute(
-		struct dc_reg_helper_state *offload,
-		const struct dc_context *ctx)
-{
-	submit_dmub_burst_write(offload, ctx);
-}
-
-static bool dmub_reg_value_burst_set_pack(const struct dc_context *ctx, uint32_t addr,
-		uint32_t reg_val)
-{
-	struct dc_reg_helper_state *offload = &ctx->dmub_srv->reg_helper_offload;
-	struct dmub_rb_cmd_burst_write *cmd_buf = &offload->cmd_data.burst_write;
-
-	/* flush command if buffer is full */
-	if (offload->reg_seq_count == DMUB_BURST_WRITE_VALUES__MAX)
-		dmub_flush_burst_write_buffer_execute(offload, ctx);
-
-	if (offload->cmd_data.cmd_common.header.type == DMUB_CMD__REG_SEQ_BURST_WRITE &&
-			addr != cmd_buf->addr) {
-		dmub_flush_burst_write_buffer_execute(offload, ctx);
-		return false;
-	}
-
-	cmd_buf->header.type = DMUB_CMD__REG_SEQ_BURST_WRITE;
-	cmd_buf->header.sub_type = 0;
-	cmd_buf->addr = addr;
-	cmd_buf->write_values[offload->reg_seq_count] = reg_val;
-	offload->reg_seq_count++;
-
-	return true;
-}
-
-static uint32_t dmub_reg_value_pack(const struct dc_context *ctx, uint32_t addr,
-		struct dc_reg_value_masks *field_value_mask)
-{
-	struct dc_reg_helper_state *offload = &ctx->dmub_srv->reg_helper_offload;
-	struct dmub_rb_cmd_read_modify_write *cmd_buf = &offload->cmd_data.read_modify_write;
-	struct dmub_cmd_read_modify_write_sequence *seq;
-
-	/* flush command if buffer is full */
-	if (offload->cmd_data.cmd_common.header.type != DMUB_CMD__REG_SEQ_BURST_WRITE &&
-			offload->reg_seq_count == DMUB_READ_MODIFY_WRITE_SEQ__MAX)
-		dmub_flush_buffer_execute(offload, ctx);
-
-	if (offload->should_burst_write) {
-		if (dmub_reg_value_burst_set_pack(ctx, addr, field_value_mask->value))
-			return field_value_mask->value;
-		else
-			offload->should_burst_write = false;
-	}
-
-	/* pack commands */
-	cmd_buf->header.type = DMUB_CMD__REG_SEQ_READ_MODIFY_WRITE;
-	cmd_buf->header.sub_type = 0;
-	seq = &cmd_buf->seq[offload->reg_seq_count];
-
-	if (offload->reg_seq_count) {
-		if (cmd_buf->seq[offload->reg_seq_count - 1].addr == addr)
-			offload->same_addr_count++;
-		else
-			offload->same_addr_count = 0;
-	}
-
-	seq->addr = addr;
-	seq->modify_mask = field_value_mask->mask;
-	seq->modify_value = field_value_mask->value;
-	offload->reg_seq_count++;
-
-	return field_value_mask->value;
-}
-
-static void dmub_reg_wait_done_pack(const struct dc_context *ctx, uint32_t addr,
-		uint32_t mask, uint32_t shift, uint32_t condition_value, uint32_t time_out_us)
-{
-	struct dc_reg_helper_state *offload = &ctx->dmub_srv->reg_helper_offload;
-	struct dmub_rb_cmd_reg_wait *cmd_buf = &offload->cmd_data.reg_wait;
-
-	cmd_buf->header.type = DMUB_CMD__REG_REG_WAIT;
-	cmd_buf->header.sub_type = 0;
-	cmd_buf->reg_wait.addr = addr;
-	cmd_buf->reg_wait.condition_field_value = mask & (condition_value << shift);
-	cmd_buf->reg_wait.mask = mask;
-	cmd_buf->reg_wait.time_out_us = time_out_us;
-}
-
 uint32_t generic_reg_update_ex(const struct dc_context *ctx,
 		uint32_t addr, int n,
 		uint8_t shift1, uint32_t mask1, uint32_t field_value1,
@@ -235,11 +96,6 @@ uint32_t generic_reg_update_ex(const struct dc_context *ctx,
 
 	va_end(ap);
 
-	if (ctx->dmub_srv &&
-	    ctx->dmub_srv->reg_helper_offload.gather_in_progress)
-		return dmub_reg_value_pack(ctx, addr, &field_value_mask);
-		/* todo: return void so we can decouple code running in driver from register states */
-
 	/* mmio write directly */
 	reg_val = dm_read_reg(ctx, addr);
 	reg_val = (reg_val & ~field_value_mask.mask) | field_value_mask.value;
@@ -265,12 +121,6 @@ uint32_t generic_reg_set_ex(const struct dc_context *ctx,
 	/* mmio write directly */
 	reg_val = (reg_val & ~field_value_mask.mask) | field_value_mask.value;
 
-	if (ctx->dmub_srv &&
-	    ctx->dmub_srv->reg_helper_offload.gather_in_progress) {
-		return dmub_reg_value_burst_set_pack(ctx, addr, reg_val);
-		/* todo: return void so we can decouple code running in driver from register states */
-	}
-
 	dm_write_reg(ctx, addr, reg_val);
 	return reg_val;
 }
@@ -434,13 +284,6 @@ void generic_reg_wait(const struct dc_context *ctx,
 	uint32_t reg_val;
 	unsigned int i;
 
-	if (ctx->dmub_srv &&
-	    ctx->dmub_srv->reg_helper_offload.gather_in_progress) {
-		dmub_reg_wait_done_pack(ctx, addr, mask, shift, condition_value,
-				delay_between_poll_us * time_out_num_tries);
-		return;
-	}
-
 	/*
 	 * Something is terribly wrong if time out is > 3000ms.
 	 * 3000ms is the maximum time needed for SMU to pass values back.
@@ -491,12 +334,6 @@ uint32_t generic_read_indirect_reg(const struct dc_context *ctx,
 {
 	uint32_t value = 0;
 
-	// when reg read, there should not be any offload.
-	if (ctx->dmub_srv &&
-	    ctx->dmub_srv->reg_helper_offload.gather_in_progress) {
-		ASSERT(false);
-	}
-
 	dm_write_reg(ctx, addr_index, index);
 	value = dm_read_reg(ctx, addr_data);
 
@@ -624,69 +461,6 @@ uint32_t generic_indirect_reg_get_sync(const struct dc_context *ctx,
 	return value;
 }
 
-void reg_sequence_start_gather(const struct dc_context *ctx)
-{
-	/* if reg sequence is supported and enabled, set flag to
-	 * indicate we want to have REG_SET, REG_UPDATE macro build
-	 * reg sequence command buffer rather than MMIO directly.
-	 */
-
-	if (ctx->dmub_srv && ctx->dc->debug.dmub_offload_enabled) {
-		struct dc_reg_helper_state *offload =
-			&ctx->dmub_srv->reg_helper_offload;
-
-		/* caller sequence mismatch.  need to debug caller.  offload will not work!!! */
-		ASSERT(!offload->gather_in_progress);
-
-		offload->gather_in_progress = true;
-	}
-}
-
-void reg_sequence_start_execute(const struct dc_context *ctx)
-{
-	struct dc_reg_helper_state *offload;
-
-	if (!ctx->dmub_srv)
-		return;
-
-	offload = &ctx->dmub_srv->reg_helper_offload;
-
-	if (offload && offload->gather_in_progress) {
-		offload->gather_in_progress = false;
-		offload->should_burst_write = false;
-		switch (offload->cmd_data.cmd_common.header.type) {
-		case DMUB_CMD__REG_SEQ_READ_MODIFY_WRITE:
-			submit_dmub_read_modify_write(offload, ctx);
-			break;
-		case DMUB_CMD__REG_REG_WAIT:
-			submit_dmub_reg_wait(offload, ctx);
-			break;
-		case DMUB_CMD__REG_SEQ_BURST_WRITE:
-			submit_dmub_burst_write(offload, ctx);
-			break;
-		default:
-			return;
-		}
-	}
-}
-
-void reg_sequence_wait_done(const struct dc_context *ctx)
-{
-	/* callback to DM to poll for last submission done*/
-	struct dc_reg_helper_state *offload;
-
-	if (!ctx->dmub_srv)
-		return;
-
-	offload = &ctx->dmub_srv->reg_helper_offload;
-
-	if (offload &&
-	    ctx->dc->debug.dmub_offload_enabled &&
-	    !ctx->dc->debug.dmcub_emulation) {
-		dc_dmub_srv_wait_for_idle(ctx->dmub_srv, DM_DMUB_WAIT_TYPE_WAIT, NULL);
-	}
-}
-
 char *dce_version_to_string(const int version)
 {
 	switch (version) {
diff --git a/drivers/gpu/drm/amd/display/dc/dm_services.h b/drivers/gpu/drm/amd/display/dc/dm_services.h
index 8b062b011fc6..2cf4bcb03cb0 100644
--- a/drivers/gpu/drm/amd/display/dc/dm_services.h
+++ b/drivers/gpu/drm/amd/display/dc/dm_services.h
@@ -127,10 +127,6 @@ uint32_t generic_reg_update_ex(const struct dc_context *ctx,
 struct dc_dmub_srv *dc_dmub_srv_create(struct dc *dc, struct dmub_srv *dmub);
 void dc_dmub_srv_destroy(struct dc_dmub_srv **dmub_srv);
 
-void reg_sequence_start_gather(const struct dc_context *ctx);
-void reg_sequence_start_execute(const struct dc_context *ctx);
-void reg_sequence_wait_done(const struct dc_context *ctx);
-
 #define FD(reg_field)	reg_field ## __SHIFT, \
 						reg_field ## _MASK
 
diff --git a/drivers/gpu/drm/amd/display/dc/dpp/dcn10/dcn10_dpp_cm.c b/drivers/gpu/drm/amd/display/dc/dpp/dcn10/dcn10_dpp_cm.c
index 53b21adc6267..9788628cf0ad 100644
--- a/drivers/gpu/drm/amd/display/dc/dpp/dcn10/dcn10_dpp_cm.c
+++ b/drivers/gpu/drm/amd/display/dc/dpp/dcn10/dcn10_dpp_cm.c
@@ -397,8 +397,6 @@ void dpp1_cm_program_regamma_lut(struct dpp *dpp_base,
 	uint32_t i;
 	struct dcn10_dpp *dpp = TO_DCN10_DPP(dpp_base);
 
-	REG_SEQ_START();
-
 	for (i = 0 ; i < num; i++) {
 		REG_SET(CM_RGAM_LUT_DATA, 0, CM_RGAM_LUT_DATA, rgb[i].red_reg);
 		REG_SET(CM_RGAM_LUT_DATA, 0, CM_RGAM_LUT_DATA, rgb[i].green_reg);
@@ -408,9 +406,6 @@ void dpp1_cm_program_regamma_lut(struct dpp *dpp_base,
 		REG_SET(CM_RGAM_LUT_DATA, 0, CM_RGAM_LUT_DATA, rgb[i].delta_green_reg);
 		REG_SET(CM_RGAM_LUT_DATA, 0, CM_RGAM_LUT_DATA, rgb[i].delta_blue_reg);
 	}
-
-	REG_SEQ_SUBMIT();
-	REG_SEQ_WAIT_DONE();
 }
 
 void dpp1_cm_configure_regamma_lut(
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.c
index 8f9038fec0f7..01027d120cb0 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.c
@@ -581,9 +581,6 @@ void dcn35_power_down_on_boot(struct dc *dc)
 
 bool dcn35_apply_idle_power_optimizations(struct dc *dc, bool enable)
 {
-	if (dc->debug.dmcub_emulation)
-		return true;
-
 	if (enable) {
 		uint32_t num_active_edp = 0;
 		int i;
diff --git a/drivers/gpu/drm/amd/display/dc/inc/reg_helper.h b/drivers/gpu/drm/amd/display/dc/inc/reg_helper.h
index 7a1ecb8d986f..6d15ccdc7f87 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/reg_helper.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/reg_helper.h
@@ -536,23 +536,4 @@ uint32_t generic_indirect_reg_update_ex_sync(const struct dc_context *ctx,
 		uint8_t shift1, uint32_t mask1, uint32_t field_value1,
 		...);
 
-/* register offload macros
- *
- * instead of MMIO to register directly, in some cases we want
- * to gather register sequence and execute the register sequence
- * from another thread so we optimize time required for lengthy ops
- */
-
-/* start gathering register sequence */
-#define REG_SEQ_START() \
-	reg_sequence_start_gather(CTX)
-
-/* start execution of register sequence gathered since REG_SEQ_START */
-#define REG_SEQ_SUBMIT() \
-	reg_sequence_start_execute(CTX)
-
-/* wait for the last REG_SEQ_SUBMIT to finish */
-#define REG_SEQ_WAIT_DONE() \
-	reg_sequence_wait_done(CTX)
-
 #endif /* DRIVERS_GPU_DRM_AMD_DC_DEV_DC_INC_REG_HELPER_H_ */
diff --git a/drivers/gpu/drm/amd/display/dc/mpc/dcn20/dcn20_mpc.c b/drivers/gpu/drm/amd/display/dc/mpc/dcn20/dcn20_mpc.c
index fa600593f4c1..0e09d073ab29 100644
--- a/drivers/gpu/drm/amd/display/dc/mpc/dcn20/dcn20_mpc.c
+++ b/drivers/gpu/drm/amd/display/dc/mpc/dcn20/dcn20_mpc.c
@@ -380,7 +380,6 @@ static void mpc20_program_ogam_pwl(
 	struct dcn20_mpc *mpc20 = TO_DCN20_MPC(mpc);
 
 	PERF_TRACE();
-	REG_SEQ_START();
 
 	for (i = 0 ; i < num; i++) {
 		REG_SET(MPCC_OGAM_LUT_DATA[mpcc_id], 0, MPCC_OGAM_LUT_DATA, rgb[i].red_reg);
@@ -395,9 +394,6 @@ static void mpc20_program_ogam_pwl(
 				MPCC_OGAM_LUT_DATA, rgb[i].delta_blue_reg);
 	}
 
-	REG_SEQ_SUBMIT();
-	PERF_TRACE();
-	REG_SEQ_WAIT_DONE();
 	PERF_TRACE();
 }
 
diff --git a/drivers/gpu/drm/amd/display/dc/optc/dcn10/dcn10_optc.c b/drivers/gpu/drm/amd/display/dc/optc/dcn10/dcn10_optc.c
index e6426ccee2d8..cf8e22289d6a 100644
--- a/drivers/gpu/drm/amd/display/dc/optc/dcn10/dcn10_optc.c
+++ b/drivers/gpu/drm/amd/display/dc/optc/dcn10/dcn10_optc.c
@@ -539,16 +539,11 @@ static bool optc1_enable_crtc(struct timing_generator *optc)
 	REG_UPDATE(CONTROL,
 			VTG0_ENABLE, 1);
 
-	REG_SEQ_START();
-
 	/* Enable CRTC */
 	REG_UPDATE_2(OTG_CONTROL,
 			OTG_DISABLE_POINT_CNTL, 3,
 			OTG_MASTER_EN, 1);
 
-	REG_SEQ_SUBMIT();
-	REG_SEQ_WAIT_DONE();
-
 	return true;
 }
 
diff --git a/drivers/gpu/drm/amd/display/dc/optc/dcn20/dcn20_optc.c b/drivers/gpu/drm/amd/display/dc/optc/dcn20/dcn20_optc.c
index c558b1d633f3..73cc8a713556 100644
--- a/drivers/gpu/drm/amd/display/dc/optc/dcn20/dcn20_optc.c
+++ b/drivers/gpu/drm/amd/display/dc/optc/dcn20/dcn20_optc.c
@@ -63,16 +63,11 @@ bool optc2_enable_crtc(struct timing_generator *optc)
 	REG_UPDATE(CONTROL,
 			VTG0_ENABLE, 1);
 
-	REG_SEQ_START();
-
 	/* Enable CRTC */
 	REG_UPDATE_2(OTG_CONTROL,
 			OTG_DISABLE_POINT_CNTL, 3,
 			OTG_MASTER_EN, 1);
 
-	REG_SEQ_SUBMIT();
-	REG_SEQ_WAIT_DONE();
-
 	return true;
 }
 
diff --git a/drivers/gpu/drm/amd/display/dc/optc/dcn31/dcn31_optc.c b/drivers/gpu/drm/amd/display/dc/optc/dcn31/dcn31_optc.c
index 98aaa22ce81c..3ace83e1b50f 100644
--- a/drivers/gpu/drm/amd/display/dc/optc/dcn31/dcn31_optc.c
+++ b/drivers/gpu/drm/amd/display/dc/optc/dcn31/dcn31_optc.c
@@ -105,16 +105,11 @@ static bool optc31_enable_crtc(struct timing_generator *optc)
 	REG_UPDATE(CONTROL,
 			VTG0_ENABLE, 1);
 
-	REG_SEQ_START();
-
 	/* Enable CRTC */
 	REG_UPDATE_2(OTG_CONTROL,
 			OTG_DISABLE_POINT_CNTL, 2,
 			OTG_MASTER_EN, 1);
 
-	REG_SEQ_SUBMIT();
-	REG_SEQ_WAIT_DONE();
-
 	return true;
 }
 
diff --git a/drivers/gpu/drm/amd/display/dc/optc/dcn314/dcn314_optc.c b/drivers/gpu/drm/amd/display/dc/optc/dcn314/dcn314_optc.c
index a7cf34937b2f..7250478a5092 100644
--- a/drivers/gpu/drm/amd/display/dc/optc/dcn314/dcn314_optc.c
+++ b/drivers/gpu/drm/amd/display/dc/optc/dcn314/dcn314_optc.c
@@ -115,16 +115,11 @@ static bool optc314_enable_crtc(struct timing_generator *optc)
 	REG_UPDATE(CONTROL,
 			VTG0_ENABLE, 1);
 
-	REG_SEQ_START();
-
 	/* Enable CRTC */
 	REG_UPDATE_2(OTG_CONTROL,
 			OTG_DISABLE_POINT_CNTL, 2,
 			OTG_MASTER_EN, 1);
 
-	REG_SEQ_SUBMIT();
-	REG_SEQ_WAIT_DONE();
-
 	return true;
 }
 
diff --git a/drivers/gpu/drm/amd/display/dc/optc/dcn32/dcn32_optc.c b/drivers/gpu/drm/amd/display/dc/optc/dcn32/dcn32_optc.c
index 07895d5f4dfa..f9e05efcad98 100644
--- a/drivers/gpu/drm/amd/display/dc/optc/dcn32/dcn32_optc.c
+++ b/drivers/gpu/drm/amd/display/dc/optc/dcn32/dcn32_optc.c
@@ -155,16 +155,11 @@ static bool optc32_enable_crtc(struct timing_generator *optc)
 	REG_UPDATE(CONTROL,
 			VTG0_ENABLE, 1);
 
-	REG_SEQ_START();
-
 	/* Enable CRTC */
 	REG_UPDATE_2(OTG_CONTROL,
 			OTG_DISABLE_POINT_CNTL, 2,
 			OTG_MASTER_EN, 1);
 
-	REG_SEQ_SUBMIT();
-	REG_SEQ_WAIT_DONE();
-
 	return true;
 }
 
diff --git a/drivers/gpu/drm/amd/display/dc/optc/dcn35/dcn35_optc.c b/drivers/gpu/drm/amd/display/dc/optc/dcn35/dcn35_optc.c
index 62f45c156c32..9b7f9d5bbfb3 100644
--- a/drivers/gpu/drm/amd/display/dc/optc/dcn35/dcn35_optc.c
+++ b/drivers/gpu/drm/amd/display/dc/optc/dcn35/dcn35_optc.c
@@ -122,16 +122,11 @@ static bool optc35_enable_crtc(struct timing_generator *optc)
 	REG_UPDATE(CONTROL,
 			VTG0_ENABLE, 1);
 
-	REG_SEQ_START();
-
 	/* Enable CRTC */
 	REG_UPDATE_2(OTG_CONTROL,
 			OTG_DISABLE_POINT_CNTL, 2,
 			OTG_MASTER_EN, 1);
 
-	REG_SEQ_SUBMIT();
-	REG_SEQ_WAIT_DONE();
-
 	return true;
 }
 
diff --git a/drivers/gpu/drm/amd/display/dc/optc/dcn401/dcn401_optc.c b/drivers/gpu/drm/amd/display/dc/optc/dcn401/dcn401_optc.c
index a6d76f451cf8..5fcdd74eb4a0 100644
--- a/drivers/gpu/drm/amd/display/dc/optc/dcn401/dcn401_optc.c
+++ b/drivers/gpu/drm/amd/display/dc/optc/dcn401/dcn401_optc.c
@@ -189,16 +189,11 @@ bool optc401_enable_crtc(struct timing_generator *optc)
 	REG_UPDATE(CONTROL,
 			VTG0_ENABLE, 1);
 
-	REG_SEQ_START();
-
 	/* Enable CRTC */
 	REG_UPDATE_2(OTG_CONTROL,
 			OTG_DISABLE_POINT_CNTL, 2,
 			OTG_MASTER_EN, 1);
 
-	REG_SEQ_SUBMIT();
-	REG_SEQ_WAIT_DONE();
-
 	return true;
 }
 
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn35/dcn35_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn35/dcn35_resource.c
index ec92e8f7d173..baf00942b8f3 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn35/dcn35_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn35/dcn35_resource.c
@@ -819,7 +819,6 @@ static const struct dc_debug_options debug_defaults_drv = {
 	.enable_hpo_pg_support = false,
 	.enable_single_display_2to1_odm_policy = true,
 	.disable_idle_power_optimizations = false,
-	.dmcub_emulation = false,
 	.disable_boot_optimizations = false,
 	.disable_unbounded_requesting = false,
 	.disable_mem_low_power = false,
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn351/dcn351_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn351/dcn351_resource.c
index 4d2d26d64a56..75a0a3dc3052 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn351/dcn351_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn351/dcn351_resource.c
@@ -799,7 +799,6 @@ static const struct dc_debug_options debug_defaults_drv = {
 	.enable_hpo_pg_support = false,
 	.enable_single_display_2to1_odm_policy = true,
 	.disable_idle_power_optimizations = false,
-	.dmcub_emulation = false,
 	.disable_boot_optimizations = false,
 	.disable_unbounded_requesting = false,
 	.disable_mem_low_power = false,
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn36/dcn36_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn36/dcn36_resource.c
index 4bab31fa2b96..8e84abdff57a 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn36/dcn36_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn36/dcn36_resource.c
@@ -806,7 +806,6 @@ static const struct dc_debug_options debug_defaults_drv = {
 	.enable_hpo_pg_support = false,
 	.enable_single_display_2to1_odm_policy = true,
 	.disable_idle_power_optimizations = false,
-	.dmcub_emulation = false,
 	.disable_boot_optimizations = false,
 	.disable_unbounded_requesting = false,
 	.disable_mem_low_power = false,
-- 
2.54.0

