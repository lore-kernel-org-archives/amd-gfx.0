Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D80E1C5B572
	for <amd-gfx@archiver.kernel.org>; Tue, 11 Aug 2026 15:51:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 732E910E333;
	Tue, 11 Aug 2026 15:51:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ZiU0fe7u";
	dkim-atps=neutral
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012014.outbound.protection.outlook.com [52.101.53.14])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8BAB310E333
 for <amd-gfx@lists.freedesktop.org>; Tue, 11 Aug 2026 15:51:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UaQI8OhlEJ35MDIitCvlmOdOvvFq2l74yvcbZqpbLhEw6K0o6f/C4jiP6wjd+Pz8LDKK6IlD7JJDMr83IU48G45usp2TXEbqYgoSI7w642yKKTKWcwCWQu1gowIJffnNhs2BEsG5m8uQbImPVSlTXXn2o1kEyfwAimwLK/79aiyiZOPXarbIJTYVsldksVlfAqqp4NiL59fDOO0tCysNosUsqx/LS46PREIL907ucNWL/UAGMimraqMEvTUrLjOAJjZ6YfsVBb7zKUnOnNNlJtk+VEM6m1DDq1iz+KF7FeoHHzFgQXyOMV9I7+G7YGR0y/gJz5dduTUqwlMsT49a5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P+mIhVx1PCIVdB2aEwqGAEu2PVQRO0WQ/HQ0cwz7Szc=;
 b=HCtLgOmKG0zgb7+2OyqrHZDl2ho09nMZHGouJN8Il6+HDTEo0DK1PwssMqfozemjfib9c3c/Ls+hYvMe41DOfxfIB0Z4RtBU6tHSZXJxCeptDF6QqyPq91hGCs5F61jGzmiiUxI2WM00y4uiOPdDoTcVlTfSx3pCzVyzVf18pykAWdcS1Jtm1LoJapscr8Y4LwHqc6xeI7T7gXOkMVWp/GDQIGKWN+7CEzT+j+FEet4VKUljk4rDlL7X+oJjDvjISsOdl9BrDvWdpV75e6c2gqtBHB9jYoD0C3Wj2zr0UQ89E9d5/aANu+aC3B6AvxInSRhLvG13QtpPPIMfIckSYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P+mIhVx1PCIVdB2aEwqGAEu2PVQRO0WQ/HQ0cwz7Szc=;
 b=ZiU0fe7uw16qi8jwGv5GRdRQA1qRgPjEkZRCbONxnGIEP7KPIA5hgxooza8BstbRl1d6p2jYT1HPRYagYCd7RPd1d5eQrMc++yvRmb8SXTxb85h2Z7P3FMOlbrur4jo89DeIcW83fuYup84YfajMXk+/S9Hgj8N9duOMTod+di8=
Received: from CH0PR03CA0377.namprd03.prod.outlook.com (2603:10b6:610:119::31)
 by SA1PR12MB8641.namprd12.prod.outlook.com (2603:10b6:806:388::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.25; Tue, 11 Aug
 2026 15:51:02 +0000
Received: from CH2PEPF00000141.namprd02.prod.outlook.com
 (2603:10b6:610:119:cafe::97) by CH0PR03CA0377.outlook.office365.com
 (2603:10b6:610:119::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.315.12 via Frontend Transport; Tue,
 11 Aug 2026 15:51:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CH2PEPF00000141.mail.protection.outlook.com (10.167.244.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.315.6 via Frontend Transport; Tue, 11 Aug 2026 15:51:01 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 11 Aug
 2026 10:50:54 -0500
Received: from james-Birman-PHX.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.45 via
 Frontend Transport; Tue, 11 Aug 2026 10:50:46 -0500
From: James Lin <PingLei.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Karthi Kandasamy <karthi.kandasamy@amd.com>, "James
 Lin" <pinglei.lin@amd.com>
Subject: [PATCH 18/24] drm/amd/display: Skip eDP teardown while forced PSR is
 active
Date: Tue, 11 Aug 2026 05:28:52 +0800
Message-ID: <20260810213010.1703162-19-PingLei.Lin@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260810213010.1703162-1-PingLei.Lin@amd.com>
References: <20260810213010.1703162-1-PingLei.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF00000141:EE_|SA1PR12MB8641:EE_
X-MS-Office365-Filtering-Correlation-Id: 19ba0eec-a3a6-4e81-fe69-08def7c05815
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|23010399003|36860700016|18002099003|22082099003|10067099003|56012099006|11063799006|3023799007;
X-Microsoft-Antispam-Message-Info: hX1Q6tWFgTSV2RcyxSDgjDyfpKPvQPcVl8SEoVN0O6dklTk23agLYQZKXb+coPAeN6RcF7nd1uyyJ+20oU2Rdz+9E/Tc5kZn44l5+GMgiC9Tbc9mDaroNh/JM2uDJmloXzc6U5CVAHkEocaqqkShMS7vWPBdZs0ndsMk1B8ZFSNveVIyb3TC5reIth/diS6IGJl2O03RwqY7OR0yGRjMeiw1XYZ2/d4flUPoaPPIJlap1OYn1F5+ZA/4xzBwiu03uKu//csmAkHDFlFb8ublUORZQtkHUWnLRsiiqRT1ERyM4TID4TAAJjPOjhYEhsRbJ848hdP4kfNrOmv6VXdxSzY8HBTmsctW3QOSC7UcJzEhlPVSMGEKwHU2OQuabsVmo2MRDCEICe0I80HWNieUj8/UWHe3WLP5AwW6E4jM1KfMFIdZ8jUxel/UdAOGi3bdPqu9NIqgdkLz5TvmMgd3GYQAJ9XuBC294N72EuG/8MXCPK/eji+zCC7i9sgceu6nK1C4IH9frleUK/Kr4iw1uw+pHBU48GG5IvNzQ4FkN9UjIdBZcBQgXnLCQCEXuSbFJnQaAUw/sAGcnkDwiQQJQNc/O5+TmDP7qzi+2LfHTVkQ/maw2ZN6DAyd7Yqox/OTrVc0eFsFmRKW2KwlwOkW3CzB1IM22FyjlOVTz96kFJUOqd7jDPnpaq42xXaBxRinh8EUlxYRdrT3HivnYIuO6g==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(1800799024)(23010399003)(36860700016)(18002099003)(22082099003)(10067099003)(56012099006)(11063799006)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: n+AsENKZlyLfOeCmaMGAGvMbivBEATqTE5/AM2uIe85bwlHGJEhQqMRa+Is8Zk41A7aUGwh7yR0z+zo6SYkJ2zXfF6ccWBnT72WZD+iIis2Y+1f+yO9oO1vKVeQ5Qbg/0jcc+RopXAbPh1olbMChPBiS8AH0w98HtPkIq6tYTSrutIvG5Pg9GpCVBz4IjnoWK8hGSq+UN8JQzLJ1QoghNOFzx4dqSYdmmZFtI6PABeoXWcrZNNQqUXb7sEeeVPwafTwsm5g7GVOuDmjfywAz4auTpHlv3cEIdiG69HUI5OPHOR1uILSryNQF0Ha7V9Z6BHCI072gjonU6AdpyUHNOwMqHUE5cF2uho9u08ltmTYfYYsUqpi/4r0FTrVn6gZRaxa+BUlBEQz7snrgMmgiCnkOzfixdHqhqUASfgSHutk22RF/J4we8NqOaiYM9O5a
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2026 15:51:01.6245 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 19ba0eec-a3a6-4e81-fe69-08def7c05815
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF00000141.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8641
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

From: Karthi Kandasamy <karthi.kandasamy@amd.com>

[Why & How]
During the HDR<->SDR toggle when the eDP link is held in a forced PSR
(freeze) state,
the normal stream/link teardown re-programming the panel would blank the
frozen frame
and disrupt the freeze; to prevent this, gate the eDP teardown path,
keeping the link
and PSR/Replay state intact for the duration of the forced PSR hold.
The blank_stream and disable_link_output gates already exist.

Acked-by: Tom Chung <chiahsuan.chung@amd.com>
Signed-off-by: Karthi Kandasamy <karthi.kandasamy@amd.com>
Signed-off-by: James Lin <pinglei.lin@amd.com>
---
 .../amd/display/dc/hwss/dce110/dce110_hwseq.c |  7 +++++--
 .../amd/display/dc/hwss/dcn10/dcn10_hwseq.c   | 19 +++++++++++++------
 .../amd/display/dc/hwss/dcn20/dcn20_hwseq.c   | 17 ++++++++++++-----
 .../amd/display/dc/hwss/dcn314/dcn314_hwseq.c |  8 +++++---
 .../amd/display/dc/hwss/dcn32/dcn32_hwseq.c   |  7 +++++--
 .../amd/display/dc/hwss/dcn60/dcn60_hwseq.c   |  8 ++++++--
 6 files changed, 46 insertions(+), 20 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c
index 8b47cdeeb1fb..ff0c6e64c2b4 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c
@@ -3605,8 +3605,11 @@ void dce110_disable_link_output(struct dc_link *link,
 	else if (dmcu != NULL && dmcu->funcs->lock_phy)
 		dmcu->funcs->lock_phy(dmcu);
 
-	link_hwss->disable_link_output(link, link_res, signal);
-	link->phy_state.symclk_state = SYMCLK_OFF_TX_OFF;
+	if (!(signal == SIGNAL_TYPE_EDP &&
+			link->forced_psr_active)) {
+		link_hwss->disable_link_output(link, link_res, signal);
+		link->phy_state.symclk_state = SYMCLK_OFF_TX_OFF;
+	}
 	/*
 	 * Add the logic to extract BOTH power up and power down sequences
 	 * from enable/disable link output and only call edp panel control
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn10/dcn10_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn10/dcn10_hwseq.c
index 850639b6fd9b..2739f7acce98 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn10/dcn10_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn10/dcn10_hwseq.c
@@ -1346,7 +1346,12 @@ static void dcn10_reset_back_end_for_pipe(
 	 * screen only, the dpms_off would be true but
 	 * VBIOS lit up eDP, so check link status too.
 	 */
-	if (!pipe_ctx->stream->dpms_off || link->link_status.link_active)
+	if (link->connector_signal == SIGNAL_TYPE_EDP &&
+	    link->forced_psr_active) {
+		/* forced psr is active for seamless switch; skip dpms-off. */
+		if (pipe_ctx->stream_res.audio)
+			dc->hwss.disable_audio_stream(pipe_ctx);
+	} else if (!pipe_ctx->stream->dpms_off || link->link_status.link_active)
 		dc->link_srv->set_dpms_off(pipe_ctx);
 	else if (pipe_ctx->stream_res.audio)
 		dc->hwss.disable_audio_stream(pipe_ctx);
@@ -1370,13 +1375,15 @@ static void dcn10_reset_back_end_for_pipe(
 	 * parent pipe.
 	 */
 	if (pipe_ctx->top_pipe == NULL) {
+		if (!(link->connector_signal == SIGNAL_TYPE_EDP &&
+			link->forced_psr_active)) {
+			if (pipe_ctx->stream_res.abm)
+				dc->hwss.set_abm_immediate_disable(pipe_ctx);
 
-		if (pipe_ctx->stream_res.abm)
-			dc->hwss.set_abm_immediate_disable(pipe_ctx);
+			pipe_ctx->stream_res.tg->funcs->disable_crtc(pipe_ctx->stream_res.tg);
 
-		pipe_ctx->stream_res.tg->funcs->disable_crtc(pipe_ctx->stream_res.tg);
-
-		pipe_ctx->stream_res.tg->funcs->enable_optc_clock(pipe_ctx->stream_res.tg, false);
+			pipe_ctx->stream_res.tg->funcs->enable_optc_clock(pipe_ctx->stream_res.tg, false);
+		}
 		set_drr_and_clear_adjust_pending(pipe_ctx, pipe_ctx->stream, NULL);
 		if (dc_is_hdmi_tmds_signal(pipe_ctx->stream->signal))
 			pipe_ctx->stream->link->phy_state.symclk_ref_cnts.otg = 0;
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c
index 16bb6f678567..66e2a6eb41c0 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c
@@ -2849,7 +2849,12 @@ void dcn20_reset_back_end_for_pipe(
 	 * screen only, the dpms_off would be true but
 	 * VBIOS lit up eDP, so check link status too.
 	 */
-	if (!pipe_ctx->stream->dpms_off || link->link_status.link_active)
+	if (link->connector_signal == SIGNAL_TYPE_EDP &&
+	    link->forced_psr_active) {
+		/* forced psr is active for seamless switch; skip dpms-off. */
+		if (pipe_ctx->stream_res.audio)
+			dc->hwss.disable_audio_stream(pipe_ctx);
+	} else if (!pipe_ctx->stream->dpms_off || link->link_status.link_active)
 		dc->link_srv->set_dpms_off(pipe_ctx);
 	else if (pipe_ctx->stream_res.audio)
 		dc->hwss.disable_audio_stream(pipe_ctx);
@@ -2874,12 +2879,14 @@ void dcn20_reset_back_end_for_pipe(
 	 * parent pipe.
 	 */
 	if (pipe_ctx->top_pipe == NULL) {
+		if (!(link->connector_signal == SIGNAL_TYPE_EDP &&
+				link->forced_psr_active)) {
+			dc->hwss.set_abm_immediate_disable(pipe_ctx);
 
-		dc->hwss.set_abm_immediate_disable(pipe_ctx);
-
-		pipe_ctx->stream_res.tg->funcs->disable_crtc(pipe_ctx->stream_res.tg);
+			pipe_ctx->stream_res.tg->funcs->disable_crtc(pipe_ctx->stream_res.tg);
 
-		pipe_ctx->stream_res.tg->funcs->enable_optc_clock(pipe_ctx->stream_res.tg, false);
+			pipe_ctx->stream_res.tg->funcs->enable_optc_clock(pipe_ctx->stream_res.tg, false);
+		}
 		if (pipe_ctx->stream_res.tg->funcs->set_odm_bypass)
 			pipe_ctx->stream_res.tg->funcs->set_odm_bypass(
 					pipe_ctx->stream_res.tg, &pipe_ctx->stream->timing);
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn314/dcn314_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn314/dcn314_hwseq.c
index 6ddc678bacf9..56d41c6fa3ee 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn314/dcn314_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn314/dcn314_hwseq.c
@@ -517,9 +517,11 @@ void dcn314_disable_link_output(struct dc_link *link,
 		link->dc->hwss.edp_backlight_control(link, false);
 	else if (dmcu != NULL && dmcu->funcs->lock_phy)
 		dmcu->funcs->lock_phy(dmcu);
-
-	link_hwss->disable_link_output(link, link_res, signal);
-	link->phy_state.symclk_state = SYMCLK_OFF_TX_OFF;
+	if (!(signal == SIGNAL_TYPE_EDP &&
+		link->forced_psr_active)) {
+		link_hwss->disable_link_output(link, link_res, signal);
+		link->phy_state.symclk_state = SYMCLK_OFF_TX_OFF;
+	}
 	/*
 	 * Add the logic to extract BOTH power up and power down sequences
 	 * from enable/disable link output and only call edp panel control
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.c
index 51fd2b3fe106..e188796cf272 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.c
@@ -1432,8 +1432,11 @@ void dcn32_disable_link_output(struct dc_link *link,
 	else if (dmcu != NULL && dmcu->funcs->lock_phy)
 		dmcu->funcs->lock_phy(dmcu);
 
-	link_hwss->disable_link_output(link, link_res, signal);
-	link->phy_state.symclk_state = SYMCLK_OFF_TX_OFF;
+	if (!(signal == SIGNAL_TYPE_EDP &&
+		link->forced_psr_active)) {
+		link_hwss->disable_link_output(link, link_res, signal);
+		link->phy_state.symclk_state = SYMCLK_OFF_TX_OFF;
+	}
 	/*
 	 * Add the logic to extract BOTH power up and power down sequences
 	 * from enable/disable link output and only call edp panel control
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn60/dcn60_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn60/dcn60_hwseq.c
index b9a046584740..8ee9791b2c46 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn60/dcn60_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn60/dcn60_hwseq.c
@@ -291,7 +291,9 @@ enum dc_status dcn60_apply_single_controller_ctx_to_hw(
 			dc_is_virtual_signal(pipe_ctx->stream->signal)))
 			dc->link_srv->set_dsc_enable(pipe_ctx, true);
 	}
-	if (!stream->dpms_off)
+	if (!stream->dpms_off &&
+	    !(link->connector_signal == SIGNAL_TYPE_EDP &&
+	      link->forced_psr_active))
 		dc->link_srv->set_dpms_on(context, pipe_ctx);
 
 	/* DCN3.1 FPGA Workaround
@@ -310,7 +312,9 @@ enum dc_status dcn60_apply_single_controller_ctx_to_hw(
 	 * is constructed with the same sink). Make sure not to override
 	 * and link programming on the main.
 	 */
-	if (dc_state_get_pipe_subvp_type(context, pipe_ctx) != SUBVP_PHANTOM) {
+	if (dc_state_get_pipe_subvp_type(context, pipe_ctx) != SUBVP_PHANTOM &&
+	    !(link->connector_signal == SIGNAL_TYPE_EDP &&
+	      link->forced_psr_active)) {
 		pipe_ctx->stream->link->psr_settings.psr_feature_enabled = false;
 		pipe_ctx->stream->link->replay_settings.replay_feature_enabled = false;
 	}
-- 
2.43.0

