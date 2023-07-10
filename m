Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30F16EB64DC
	for <amd-gfx@archiver.kernel.org>; Mon, 10 Jul 2023 19:27:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 16B2910E2C2;
	Mon, 10 Jul 2023 19:27:48 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2070.outbound.protection.outlook.com [40.107.243.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0A2A910E2C2
 for <amd-gfx@lists.freedesktop.org>; Mon, 10 Jul 2023 19:27:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aaDqFAfaO1kahgPyJV2aPsEAYOsOlxwFVOvdyof9WipLh2JhZRv6xveeUB7pztX+5YfNprJf3G/iCuVb3tOOMDJxIYD/t5wtD8wI2fPCg/cVKlVe0yrYdp1jCXHgVgLosQwp/Innc1l5iChuYmwcc3G3/+ax4S7PmBpKTjbgYDUeHXCbD8ReG1Wab8Fn6r67ydO4K5hXhvNb2UFC9d78BCweu4VFiJxETgQvc8XGjJKX6vP6XUVTHO3+y2laiqBqCBDDjlh0fkmCp3RLQdnsLBQG2yQA9l1NDjihs3ORXPNPZQYLtQT+NOff6mUdy3TcGksGvQ2gLal/B91c43sEfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fvm0rY9cBbPjH81+IyPacMvxBa49L7N4vunVA3dUVkw=;
 b=gjhbBJ34Fr+OxI4H7/c8g7/HjxUNg58lQy0GCrVgLzuOta+KJaaiLmpLhbUDtCddDck+tNiGYVb2GQwoJF99lWKnYluRdU03stKC19jqBdTGTX6qY8YS3/Ph5HUwoO7nvj13qV3uBMrEr2J39ix3fTKOk8rQqxuWSTwosNEq/8gpL4Fo/tfj4rqGZNfUrDMY5FXZZ+yhSIeXbpKl3iyfUED296Zbv11Afdh1+jtPeEQo/KET3aXGmUs3AZkm5NB1PvPmEeIJyT+6bmZj43Bi760IfXEUqVsIvLQKMbareXdhS4L3HJ3o8GCZ2t+8bpkacpO6tREYYYTV0m5fPvAsmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fvm0rY9cBbPjH81+IyPacMvxBa49L7N4vunVA3dUVkw=;
 b=HLRr3YatRTD1rzLEYDVpmqvVBCxj3GVWhF2jFxaCzyu6c3wl49Svxc+IkvF8F8BsBYQMsIAZH/oI+apOgvINBP2Qj1sqHV8cLKokMO9BN9CFndhwDm8iRYXUGTN1rSQhAzYV8Gp733sVfv+wgm3fFH08KeRXA44uaTWl1w4OSbA=
Received: from DS7PR03CA0129.namprd03.prod.outlook.com (2603:10b6:5:3b4::14)
 by CO6PR12MB5395.namprd12.prod.outlook.com (2603:10b6:303:13a::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.31; Mon, 10 Jul
 2023 19:27:39 +0000
Received: from DM6NAM11FT096.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3b4:cafe::8) by DS7PR03CA0129.outlook.office365.com
 (2603:10b6:5:3b4::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.30 via Frontend
 Transport; Mon, 10 Jul 2023 19:27:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT096.mail.protection.outlook.com (10.13.173.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6588.19 via Frontend Transport; Mon, 10 Jul 2023 19:27:39 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Mon, 10 Jul
 2023 14:27:39 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Mon, 10 Jul
 2023 14:27:38 -0500
Received: from blakha.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.23 via Frontend
 Transport; Mon, 10 Jul 2023 14:27:38 -0500
From: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <harry.wentland@amd.com>,
 <alexander.deucher@amd.com>
Subject: [PATCH 06/10] drm/amd/display: Add Replay supported/enabled checks
Date: Mon, 10 Jul 2023 15:27:29 -0400
Message-ID: <20230710192733.1344403-7-Bhawanpreet.Lakha@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230710192733.1344403-1-Bhawanpreet.Lakha@amd.com>
References: <20230615203930.1715722-1-Bhawanpreet.Lakha@amd.com>
 <20230710192733.1344403-1-Bhawanpreet.Lakha@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT096:EE_|CO6PR12MB5395:EE_
X-MS-Office365-Filtering-Correlation-Id: 5bf57eba-b7b5-4a65-02db-08db817bb968
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HT/00BosrGlt0HUtlI+6LS8fqL4hiF1fBAdXPHyxMleLtd3mKW6X9I/Aa4M/XQyYs38fqhpUCQGncefDUtz4yuq2qf0tCOMA5nP4ZZ3EZFW3THnX+Kr10mXgrvbOnKKWup3YQsSandmfj/N3OQQiEquCgQWkuhEWxCuQ/59hAyNQ7PHhnmPWDKVsowud4NrphPb3FmR2zYnvQpYCK6Sg7tjWiv04gUIYA7ij8XxDX8RzdMoIaVG8gjUsiQN7Af84CZrbsLic5j8J3wBTBr4uE1pHMstd+Tn8oj7aNcRX3QzqTv6QfVrlbZqAh+TN/lcxB1mr3S0Z4Bu2DsBCKpEbt4wCJsDR8llyuRyildOoVZmFjn1EtlyRM0lvthY6n2xjmhOHiYaVcRZL6YyYES7seeOxUxvjO+crtO1ktifrrtKKARXHNn3y/SiVtzku/rD6ELJe/jNxtga0Xpu9iiAflAu/+mloDDrWpK7fZpgGXLXlhEh1xzCTlXJo76g0rKFMbzRYvduMlcEEtHIgj68ncL5PTGZDdhIjuC5WSgZjhDbqlM848K6oZBpAZd9QipIw/pCaYbMc2PDIB1ZnKd+OcI5SjBbcb2YmpHLo6xyCDkqZ+OeZqkPwWuToEEDsM83miDV3P8nJxWLhYi23kvUnTkO1OLlNJofg3k4NlsepguxkAdkQri99WLrAd1RQ3HvuZM0JCBlZhnKfsalp24TZbDvgJJrJb9iZlEu3dgeABF8O8a7Wb+F+3MSMJmsgNT1+ocffOsBgcYzRctGfRt12Kw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(39860400002)(396003)(136003)(346002)(451199021)(40470700004)(46966006)(36840700001)(86362001)(5660300002)(8676002)(8936002)(41300700001)(316002)(82310400005)(2906002)(6636002)(4326008)(70586007)(70206006)(356005)(81166007)(82740400003)(110136005)(83380400001)(6666004)(7696005)(478600001)(36860700001)(1076003)(26005)(186003)(2616005)(47076005)(36756003)(40460700003)(40480700001)(336012)(426003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2023 19:27:39.3681 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5bf57eba-b7b5-4a65-02db-08db817bb968
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT096.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR12MB5395
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
Cc: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

- Add checks for Cursor update and dirty rects (sending updates to dmub)
- Add checks for dc_notify_vsync, and fbc and subvp

Signed-off-by: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc.c                    | 6 ++++++
 drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c                | 3 +++
 drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c | 6 ++++++
 3 files changed, 15 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index dd3a9d06c6e2..dccb49e27f35 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -3367,6 +3367,9 @@ static bool dc_dmub_should_send_dirty_rect_cmd(struct dc *dc, struct dc_stream_s
 			&& stream->ctx->dce_version >= DCN_VERSION_3_1)
 		return true;
 
+        if (stream->link->replay_settings.config.replay_supported)
+                return true;
+
 	return false;
 }
 
@@ -5116,6 +5119,9 @@ void dc_notify_vsync_int_state(struct dc *dc, struct dc_stream_state *stream, bo
 	if (link->psr_settings.psr_feature_enabled)
 		return;
 
+        if (link->replay_settings.replay_feature_enabled)
+                return;
+
 	/*find primary pipe associated with stream*/
 	for (i = 0; i < MAX_PIPES; i++) {
 		pipe = &dc->current_state->res_ctx.pipe_ctx[i];
diff --git a/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c b/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
index c52c40b16387..706c49e015f6 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
+++ b/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
@@ -894,6 +894,9 @@ static bool dc_dmub_should_update_cursor_data(struct pipe_ctx *pipe_ctx)
 		pipe_ctx->stream->ctx->dce_version >= DCN_VERSION_3_1)
 		return true;
 
+	if (pipe_ctx->stream->link->replay_settings.config.replay_supported)
+                return true;
+
 	return false;
 }
 
diff --git a/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c b/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c
index 6c9ca43d1040..16b53a4c5a42 100644
--- a/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c
+++ b/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c
@@ -1585,6 +1585,8 @@ static enum dc_status apply_single_controller_ctx_to_hw(
 	 */
 	if (pipe_ctx->stream->mall_stream_config.type != SUBVP_PHANTOM) {
 		pipe_ctx->stream->link->psr_settings.psr_feature_enabled = false;
+		printk("######  %s %d\n",__func__,__LINE__);
+		pipe_ctx->stream->link->replay_settings.replay_feature_enabled = false;
 	}
 	return DC_OK;
 }
@@ -2013,6 +2015,10 @@ static bool should_enable_fbc(struct dc *dc,
 	if (pipe_ctx->stream->link->psr_settings.psr_feature_enabled)
 		return false;
 
+	/* Replay should not be enabled */
+        if (pipe_ctx->stream->link->replay_settings.replay_feature_enabled)
+                return false;
+
 	/* Nothing to compress */
 	if (!pipe_ctx->plane_state)
 		return false;
-- 
2.25.1

