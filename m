Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A042C9830E
	for <amd-gfx@archiver.kernel.org>; Thu, 24 Sep 2026 18:46:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A8C9E10F73C;
	Thu, 24 Sep 2026 18:46:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="3usdmYij";
	dkim-atps=neutral
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010048.outbound.protection.outlook.com [52.101.85.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E4C3510F729
 for <amd-gfx@lists.freedesktop.org>; Thu, 24 Sep 2026 18:46:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rIzK+8WR3ItjYJZc08+YUk5TmaM0WGl5oNbOmf1aIYQnpJOpJyesIRq1RkLEr9WS3z/1cC8V9q7vyriYyN8xNEgCXM/lGi5PZHOOapKHM1RyMFn8HTpgoVod/H1Bjap8p8kJTus+QGfqNgj0N2WCWevmrziIyNLTcMIE2iTSIXsheUHrFWDgYIczdNfajb1B1jjkmz0dCYcot/+HhU7BnnOMoCTUGdWrWC2oPX2O741ewCJqLUdNAT4mVcrNA+kcFyAUHGvHetzx8a0l4iiBei93mJU0vcLn2Li2xAZW9fXFEkuNEc4XXoUQ/s6g+qt90qz8Aq66b8doxNnmEVh3kA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=As656skv7C2FjUEFq3aETqYqv8TweCx8hRO5XnHIHY8=;
 b=wa0bIoYCMhe3DVFXvrMO6kSpRMsnj8IaQlkFQcquLtKG+OUx0u1Mx6WKRQ3/b92We/M/S4VxQTpWg9T8o25u77zE9lUoW+ScAhli6KzZXeKK6JV1A/Xcl/TxUKNlKi6c1g0ofsmPN+pgHH0/IttdVCJm2A/wzIGaZQGlSta0AVtynntUCo5lFvgUm1itKg8Q07U4MuOI2mNslb71d3qXvFpAl7ja0jkP8lMnQGoK4mKthB+KxaQmCE97hY1J/t8bHRZ9M74WlXogTKWZVugOFZpu5x3mEy8Wl9XrDkoRVsToj58yfl5IlOfctMuy1bm8zW0+uldv4kjGUa1h9BtpsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=As656skv7C2FjUEFq3aETqYqv8TweCx8hRO5XnHIHY8=;
 b=3usdmYij7TGo31sd6OdlxzFwwdLYgtQuqC3iljnAcZJlMyJq8VznR0myco1kWW7Mt9lKKBo1VaUDsf83N66HHNqorxJ6V5Df8AHlYz+XcAtSt1Vyl2oKBlcYtt/hrrXmQgdcUkT/Wznl7pGESFsNlH/xCdkwGbb7CPM1W1vjZ28=
Received: from PH8P221CA0007.NAMP221.PROD.OUTLOOK.COM (2603:10b6:510:2d8::25)
 by DS2PR12MB171439.namprd12.prod.outlook.com (2603:10b6:8:401::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.18; Thu, 24 Sep
 2026 18:46:32 +0000
Received: from SJ1PEPF00002316.namprd03.prod.outlook.com
 (2603:10b6:510:2d8:cafe::50) by PH8P221CA0007.outlook.office365.com
 (2603:10b6:510:2d8::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.18 via Frontend Transport; Thu,
 24 Sep 2026 18:46:32 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF00002316.mail.protection.outlook.com (10.167.242.170) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.8 via Frontend Transport; Thu, 24 Sep 2026 18:46:32 +0000
Received: from jzuo.laptop (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Thu, 24 Sep
 2026 13:46:15 -0500
From: Fangzhi Zuo <jerry.zuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Piotr Maziarz <piotr.maziarz@amd.com>, Alvin Lee
 <alvin.lee2@amd.com>
Subject: [PATCH 20/34] drm/amd/display: Drop disallow_self_refresh_applied
 output param
Date: Thu, 24 Sep 2026 14:45:33 -0400
Message-ID: <20260924184824.596894-21-jerry.zuo@amd.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260924184824.596894-1-jerry.zuo@amd.com>
References: <20260924184824.596894-1-jerry.zuo@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002316:EE_|DS2PR12MB171439:EE_
X-MS-Office365-Filtering-Correlation-Id: 076e5b89-a111-4084-9aae-08df1a6c26f4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|82310400026|23010399003|376014|1800799024|10067099003|11063799006|3023799007|6133799003|18002099003|22082099003|56012099006;
X-Microsoft-Antispam-Message-Info: WYJ+9icvJm1yiei82yyhrjDXMTER3ez0SdlmOVdlxz1u8hPFfAc2f+GYFnYm4NOJGjM9+rYsUHnCnxZgCNku+EFVa2hrW5pVMpaZXAWHwna0uWQHi+McMpREDsRAcYHXI+kEbjMxLVE/MMsmKY7m2FtryGucz77vizI5fts5VzcI6UyxJPBXvNtbkAVb0DsXQ5vU3BbiwPWooEqHjZqtJL0VIIGBaBiywLeqpKUfMT8zYwikkhEKy0DbcPZoEJOgjzb/fJaqz1OHSnET2+rkeUi8ClvZDayFJRkuAlCiVyWuq70IjoL9L1f9SR3hfCKBhl0JZ/BnKhVQ6XrMC0YA6Y5INhASG81I/RIhcktd7wtoSKLYCr7rqJVKx6pcmmDlC/qq3IcR3UQoA5svsznQIo+mQd6Cco9R5zfdM34aIhx00ZeJdwW0IaTkQ5r37eTkWAqMlLPa2tB9LEAOQQ5EnPCiHwScUFI13n/0QnMKhwGDj2fTtET+/iBqyPO5UQsIbmKVdcUR7OBeFslIkYuaq1cp6EPvwwa5+bdzC9yrlYMMH//7QQz4UuIIiUkY9cGas2QcjDWF7EHlhySMZ+kBT7z0n0nJerxOiOhDa4JKQWRw2AZD5FyVD3TZj5JUnVUNP3n1B0dUKb0cf0rwQdChBQ80sDBlHfntWAS7aDhdyvZYFMJWgXmL5yjE7biarUUIqVl91rvREhikAK4hS1GT9w==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(82310400026)(23010399003)(376014)(1800799024)(10067099003)(11063799006)(3023799007)(6133799003)(18002099003)(22082099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: QqGZ8QrcskfkvFGnjLR7NMIR9a7HUMcLr8oC8NxpbBiCamJTJVR7pGKe0EgavFDm6krvTX8bfTK30Fk2JosASq4jU0F4ZYZHSq56AU4O0HV6TW6E2I6c9k1kgrboc0WTw9diM/z37K3qjdnFB45JY3JitkGC2k1euG3xYaKOgGkdmDHfBFQ95D2xTXYtZVhdfTNkzyult3Z1Eg3vJXvTBqOxXweTegD5zxCwMlhwZYCIcQkYPBBUzbq5mjhskX3YEL9pFcLQOU9e+cmvG3VIAT+b+FPR48iaErhaheS/3TXbyknCLb5Sg5gsx6F45OILMuMtoNTgW9smJEYmqmz1x2101uKtiWiQJc/vCQ1++d+vgRHMU4ABjRS3Uf8cgFUSf13ocwQQRx6QQ2b8esVCrkODL4x1uLfEYFKpxG7pPadfxFzOY5rTt98T+/aHZeae
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2026 18:46:32.0994 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 076e5b89-a111-4084-9aae-08df1a6c26f4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00002316.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR12MB171439
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

From: Piotr Maziarz <piotr.maziarz@amd.com>

[WHY]
Besides programming the hubbub, the HUBBUB_ALLOW_SELF_REFRESH_CONTROL
executor wrote through an output pointer into hwseq->wa_state to record
that the MPO stutter workaround had been applied. That bookkeeping has no
relationship to the register write and makes the operation mutate a logical
object while the sequence runs.

[HOW]
Removed the pointer from hubbub_allow_self_refresh_control_params and from
the add helper, leaving the executor a plain pass through to
hubbub->funcs->allow_self_refresh_control.
hwss_build_post_unlock_full_sequence now sets the workaround flag itself,
inside the same condition that decides to emit the step. TG_GET_FRAME_COUNT
is left as is: its out parameter is the read back register value, and
reading it after the write matches the legacy implementations.

Signed-off-by: Piotr Maziarz <piotr.maziarz@amd.com>
Signed-off-by: Fangzhi Zuo <jerry.zuo@amd.com>
Reviewed-by: Alvin Lee <alvin.lee2@amd.com>
---
 .../drm/amd/display/dc/core/dc_hw_sequencer.c    | 16 ++++++++--------
 .../gpu/drm/amd/display/dc/hwss/hw_sequencer.h   |  4 +---
 2 files changed, 9 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_hw_sequencer.c b/drivers/gpu/drm/amd/display/dc/core/dc_hw_sequencer.c
index e2cc5ab40b3b..e6d10e3bd6e9 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_hw_sequencer.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_hw_sequencer.c
@@ -1165,14 +1165,19 @@ void hwss_build_post_unlock_full_sequence(struct dc *dc,
 			dc->current_state->stream_status[0].plane_count == 1 &&
 			context->stream_status[0].plane_count > 1) {
 
-		hwss_add_hubbub_allow_self_refresh_control(&seq_state, dc->res_pool->hubbub, false,
-			&hwseq->wa_state.disallow_self_refresh_during_multi_plane_transition_applied);
+		hwss_add_hubbub_allow_self_refresh_control(&seq_state, dc->res_pool->hubbub, false);
 
 		/* Get frame count for WA state tracking - this needs to be done immediately after the above call */
 		if (dc->res_pool->timing_generators[0]->funcs->get_frame_count) {
 			hwss_add_tg_get_frame_count(&seq_state, dc->res_pool->timing_generators[0],
 				&hwseq->wa_state.disallow_self_refresh_during_multi_plane_transition_applied_on_frame);
 		}
+
+		/*
+		 * Set here rather than as a sequence step: the executor must not
+		 * write to logical objects.
+		 */
+		hwseq->wa_state.disallow_self_refresh_during_multi_plane_transition_applied = true;
 	}
 }
 
@@ -3685,9 +3690,6 @@ void hwss_hubbub_allow_self_refresh_control(union block_sequence_params *params)
 	bool allow = params->hubbub_allow_self_refresh_control_params.allow;
 
 	hubbub->funcs->allow_self_refresh_control(hubbub, allow);
-
-	if (!allow && params->hubbub_allow_self_refresh_control_params.disallow_self_refresh_applied)
-		*params->hubbub_allow_self_refresh_control_params.disallow_self_refresh_applied = true;
 }
 
 void hwss_tg_get_frame_count(union block_sequence_params *params)
@@ -5881,14 +5883,12 @@ void hwss_add_hubbub_apply_dedcn21_147_wa(struct block_sequence_state *seq_state
 
 void hwss_add_hubbub_allow_self_refresh_control(struct block_sequence_state *seq_state,
 		struct hubbub *hubbub,
-		bool allow,
-		bool *disallow_self_refresh_applied)
+		bool allow)
 {
 	if (*seq_state->num_steps < MAX_HWSS_BLOCK_SEQUENCE_SIZE) {
 		seq_state->steps[*seq_state->num_steps].func = HUBBUB_ALLOW_SELF_REFRESH_CONTROL;
 		seq_state->steps[*seq_state->num_steps].params.hubbub_allow_self_refresh_control_params.hubbub = hubbub;
 		seq_state->steps[*seq_state->num_steps].params.hubbub_allow_self_refresh_control_params.allow = allow;
-		seq_state->steps[*seq_state->num_steps].params.hubbub_allow_self_refresh_control_params.disallow_self_refresh_applied = disallow_self_refresh_applied;
 		(*seq_state->num_steps)++;
 	}
 }
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/hw_sequencer.h b/drivers/gpu/drm/amd/display/dc/hwss/hw_sequencer.h
index 6f3ec43bf3b0..821cd0de7271 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/hw_sequencer.h
+++ b/drivers/gpu/drm/amd/display/dc/hwss/hw_sequencer.h
@@ -528,7 +528,6 @@ struct hubbub_apply_dedcn21_147_wa_params {
 struct hubbub_allow_self_refresh_control_params {
 	struct hubbub *hubbub;
 	bool allow;
-	bool *disallow_self_refresh_applied;
 };
 
 struct tg_get_frame_count_params {
@@ -2665,8 +2664,7 @@ void hwss_add_hubbub_apply_dedcn21_147_wa(struct block_sequence_state *seq_state
 
 void hwss_add_hubbub_allow_self_refresh_control(struct block_sequence_state *seq_state,
 		struct hubbub *hubbub,
-		bool allow,
-		bool *disallow_self_refresh_applied);
+		bool allow);
 
 void hwss_add_tg_get_frame_count(struct block_sequence_state *seq_state,
 		struct timing_generator *tg,
-- 
2.53.0

