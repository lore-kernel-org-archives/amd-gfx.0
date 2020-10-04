Return-Path: <SRS0=AA3p=DL=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C485C4363C
	for <amd-gfx@archiver.kernel.org>; Sun,  4 Oct 2020 17:19:43 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BB00D206B6
	for <amd-gfx@archiver.kernel.org>; Sun,  4 Oct 2020 17:19:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="QAlaZLTf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB00D206B6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 70A5A89E1D;
	Sun,  4 Oct 2020 17:19:42 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2060.outbound.protection.outlook.com [40.107.223.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 51D5D89E65
 for <amd-gfx@lists.freedesktop.org>; Sun,  4 Oct 2020 17:19:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kG1PwuzoBFQxnJjHn9fLEiKufFnkKIQz0JdgN5nDsxXGuhye6Xd2aNT/XBFY4Tk+rgzw3Dt625NdrA7Yd6R7iBFyoiU1J8vWBR9V8pJRKuwOPbKCrBP3zkvfH30tqEy5VwksmbzyBqDdaUOs/UzicQUrXmmpI+j/pR97+32v9OaqwYw0co+f9A3XXX+dLrzuGWzViC7pWJbsCIr4igVABDeIh8Qd4+fLSSxiGEyN0xfXv71sE/VpSGUBbvE86208hmIwceveyeyFhCAaCcVVpajUSq/UqHTzhEAkbZxg1HD5EbsGE1JIB5oMzRKCoYvFDjFPbPcR86kXilsCMdNbkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HUnYL+EFM4shUczgXw2SuE7P1yUWbKV5ztPjLctp2N8=;
 b=OCOM3I9KSWW0dvGcqNUNTxaAu9NwJESVOw9cn36vm8lcFzUpYdLP0WfPQM+GgtHF8ZGAzO5PZKPidKyvy3c0nCCDMvHrbf4gaokTA0Cywwozu8X66QdudXtntpD0vMFkNmMlVT0A9P6MpmJz/BUJ7g7b2lYCJWPs73d5Hqk4LdOpmfhPQ2wE+J/Wke0Bw+7f5PsVZZn+oGPRGD8P6zYBXI3dhDzDOSWftND5fiEa0x1d3bH3dbD4SR7hoyyMUOSdN/Qwu6+TsGenjubD8FsXa79JlKem1W9ZDy+lJB0Eomkw1agT+WnddPx7jeOD3nK3tPNgNnTJC7hQoIqR7og3vg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HUnYL+EFM4shUczgXw2SuE7P1yUWbKV5ztPjLctp2N8=;
 b=QAlaZLTfE3X6rh10cs9rfD8a8cv46prChXu96MZDVBg8//7XsXD+nu7V/XISXb5N4KbFD55/YmfMwmnyE87vFovLjQ47iLHHYUyD+htQ8lVIx+M/IwnotpPJF+z1kEBGRRneRiqW9+xN2L4PMnmVNlwhn33XbYwWduPLIdKugkQ=
Received: from MWHPR15CA0061.namprd15.prod.outlook.com (2603:10b6:301:4c::23)
 by BY5PR12MB3905.namprd12.prod.outlook.com (2603:10b6:a03:194::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3433.34; Sun, 4 Oct
 2020 17:19:36 +0000
Received: from CO1NAM11FT051.eop-nam11.prod.protection.outlook.com
 (2603:10b6:301:4c:cafe::ab) by MWHPR15CA0061.outlook.office365.com
 (2603:10b6:301:4c::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.25 via Frontend
 Transport; Sun, 4 Oct 2020 17:19:36 +0000
X-MS-Exchange-Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 CO1NAM11FT051.mail.protection.outlook.com (10.13.174.114) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3433.35 via Frontend Transport; Sun, 4 Oct 2020 17:19:36 +0000
Received: from SATLEXMB01.amd.com (10.181.40.142) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Sun, 4 Oct 2020
 12:19:35 -0500
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server id 15.1.1979.3 via Frontend
 Transport; Sun, 4 Oct 2020 12:19:29 -0500
From: Eryk Brol <eryk.brol@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 08/18] drm/amd/display: Block ABM in case of eDP ODM
Date: Sun, 4 Oct 2020 13:18:03 -0400
Message-ID: <20201004171813.7819-9-eryk.brol@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201004171813.7819-1-eryk.brol@amd.com>
References: <20201004171813.7819-1-eryk.brol@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d8d7105c-15a3-4c23-2962-08d86889ab25
X-MS-TrafficTypeDiagnostic: BY5PR12MB3905:
X-Microsoft-Antispam-PRVS: <BY5PR12MB39058D7B985F06B29C0F5071E50F0@BY5PR12MB3905.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:422;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lhPQ3XpzuSYwOAOed6z2nGxn79TTuubzdFU1MAhEPuEbtrqjU7oXT1Aj8gDDwX/lXLf6D+wnJv4cPs4EcOApJEq1ZWvyOdrPAlHOaZ94RZzCwdTpXjCb4HDBy/TfBfBDSUsc+TDxWMurN4HWvO8f56fM2x9jx8tDunSX5r4Y4mowpphgYrNNBl0mydFiBPmlj+6BJ69QUX5HYn4yOlYh84A9Ds2BN4f+dBafJntlmVX+3WrfxM93vb4PADufpWsWPyEhLCCzfNiV32Y7eqkIE9SP1z5vltJO0mSY/0NekeeN6TpBgbmlaUCwV9photBke2Sdckv/l83hqmG/Oj02O7ylcdWg53kGNRho5mHbAxL+iJe+Z5iiBGYdiaOLvE4T3O2Te5Svz/xstzdNO/AKiw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB02.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(376002)(136003)(346002)(39850400004)(396003)(46966005)(54906003)(82310400003)(86362001)(83380400001)(316002)(4326008)(1076003)(2616005)(26005)(186003)(44832011)(6916009)(5660300002)(36756003)(336012)(81166007)(8676002)(6666004)(356005)(478600001)(8936002)(47076004)(70206006)(70586007)(82740400003)(2906002)(426003);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2020 17:19:36.2133 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d8d7105c-15a3-4c23-2962-08d86889ab25
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT051.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB3905
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
Cc: Eric Yang <eric.yang2@amd.com>, Eryk
 Brol <eryk.brol@amd.com>, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 Qingqing.Zhuo@amd.com, Rodrigo.Siqueira@amd.com, Aurabindo.Pillai@amd.com,
 Yongqiang Sun <yongqiang.sun@amd.com>, Bhawanpreet.Lakha@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Yongqiang Sun <yongqiang.sun@amd.com>

[Why]
enable ODM on eDP panel with ABM will result in color difference
on the panel due to only one ABM module to set one pipe.

[How]
Block ABM in case of ODM enabled on eDP.

Signed-off-by: Yongqiang Sun <yongqiang.sun@amd.com>
Reviewed-by: Eric Yang <eric.yang2@amd.com>
Acked-by: Eryk Brol <eryk.brol@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc_stream.h        |  1 +
 .../gpu/drm/amd/display/dc/dcn21/dcn21_hwseq.c    | 15 +++++++++++++++
 .../gpu/drm/amd/display/dc/dcn21/dcn21_hwseq.h    |  2 ++
 drivers/gpu/drm/amd/display/dc/dcn21/dcn21_init.c |  1 +
 .../gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.c    |  3 +++
 drivers/gpu/drm/amd/display/dc/inc/hw_sequencer.h |  2 ++
 6 files changed, 24 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dc_stream.h b/drivers/gpu/drm/amd/display/dc/dc_stream.h
index c246af7c584b..0be1ec1e46ca 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_stream.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_stream.h
@@ -45,6 +45,7 @@ struct dc_stream_status {
 	int audio_inst;
 	struct timing_sync_info timing_sync_info;
 	struct dc_plane_state *plane_states[MAX_SURFACE_NUM];
+	bool is_abm_supported;
 };
 
 // TODO: References to this needs to be removed..
diff --git a/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_hwseq.c b/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_hwseq.c
index 01f1d3d9a639..1fa193078803 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_hwseq.c
@@ -223,3 +223,18 @@ bool dcn21_set_backlight_level(struct pipe_ctx *pipe_ctx,
 	return true;
 }
 
+bool dcn21_is_abm_supported(struct dc *dc,
+		struct dc_state *context, struct dc_stream_state *stream)
+{
+	int i;
+
+	for (i = 0; i < dc->res_pool->pipe_count; i++) {
+		struct pipe_ctx *pipe_ctx = &context->res_ctx.pipe_ctx[i];
+
+		if (pipe_ctx->stream == stream &&
+				(pipe_ctx->prev_odm_pipe == NULL && pipe_ctx->next_odm_pipe == NULL))
+			return true;
+	}
+	return false;
+}
+
diff --git a/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_hwseq.h b/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_hwseq.h
index 9e97747e57cd..9cee9bdb8de9 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_hwseq.h
+++ b/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_hwseq.h
@@ -52,5 +52,7 @@ void dcn21_set_abm_immediate_disable(struct pipe_ctx *pipe_ctx);
 bool dcn21_set_backlight_level(struct pipe_ctx *pipe_ctx,
 		uint32_t backlight_pwm_u16_16,
 		uint32_t frame_ramp);
+bool dcn21_is_abm_supported(struct dc *dc,
+		struct dc_state *context, struct dc_stream_state *stream);
 
 #endif /* __DC_HWSS_DCN21_H__ */
diff --git a/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_init.c b/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_init.c
index 2b7396c9fcb4..4ab29911508d 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_init.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_init.c
@@ -98,6 +98,7 @@ static const struct hw_sequencer_funcs dcn21_funcs = {
 #ifndef TRIM_FSFT
 	.optimize_timing_for_fsft = dcn20_optimize_timing_for_fsft,
 #endif
+	.is_abm_supported = dcn21_is_abm_supported,
 };
 
 static const struct hwseq_private_funcs dcn21_private_funcs = {
diff --git a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.c b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.c
index 2ace13878aaf..8eb8e13e1130 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.c
@@ -617,6 +617,9 @@ void dcn30_init_hw(struct dc *dc)
 	if (hws->funcs.enable_power_gating_plane)
 		hws->funcs.enable_power_gating_plane(dc->hwseq, true);
 
+	if (!dcb->funcs->is_accelerated_mode(dcb) && dc->res_pool->hubbub->funcs->init_watermarks)
+		dc->res_pool->hubbub->funcs->init_watermarks(dc->res_pool->hubbub);
+
 	if (dc->clk_mgr->funcs->notify_wm_ranges)
 		dc->clk_mgr->funcs->notify_wm_ranges(dc->clk_mgr);
 
diff --git a/drivers/gpu/drm/amd/display/dc/inc/hw_sequencer.h b/drivers/gpu/drm/amd/display/dc/inc/hw_sequencer.h
index 55c642950e91..e9ef782e63a8 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/hw_sequencer.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/hw_sequencer.h
@@ -223,6 +223,8 @@ struct hw_sequencer_funcs {
 	bool (*apply_idle_power_optimizations)(struct dc *dc, bool enable);
 #endif
 
+	bool (*is_abm_supported)(struct dc *dc,
+			struct dc_state *context, struct dc_stream_state *stream);
 };
 
 void color_space_to_black_color(
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
