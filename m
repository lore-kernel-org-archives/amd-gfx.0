Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FB33CCA470
	for <amd-gfx@archiver.kernel.org>; Wed,  1 Oct 2025 21:28:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F1BB010E50B;
	Wed,  1 Oct 2025 21:28:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="KMEtEfPW";
	dkim-atps=neutral
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012035.outbound.protection.outlook.com [52.101.53.35])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4770B10E27C
 for <amd-gfx@lists.freedesktop.org>; Wed,  1 Oct 2025 21:28:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SR0qpvot7cfgefecpOqKyz0SfygFQyII7Di5db3tUj8KkRu6+rzF9oJtBCLcsN88APGKWr9WOu19XsmQzJbpmHz1TzRYt1W/kd4stEEpLV8j5TF9vEoiwk87SNKdFmtiLYAg3HIYNNsz8T7c7o4OdjU5znLVDfVvJeEqPsQY9xwHIS0agQAvik0vgzVL/jcfLOkvHzu043Irwi/h++PLo60Iqcy8BWicu+oxvws5zeI89KS3p16Rhr0Gr/6M+8Qn1VlkW4fnMpCklAImHpiRytQdD1tWMVtwU2bteRn56C+bedPHDBL9DkSUCEkuQyNIEfyB/AEPnq0/kYF5h8zsdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+Th4qUjbPv7qNfBJMzeIiONcrBvaMaX/TF5xJQs8a+Y=;
 b=CMKssRkr8kthvbPGHyFceyx05byD1FSmoi4kEjSWggNwqGCV4rYi44jIdqbQMZCRgq4Xoz01yhE8sSactHGiCOiiXW2je2uX18BxTvAiAatedoEuzQQO8c4Uhczt8ZhHJpMboDoj1XwFWGaJV0Rc9WtaWargYOqoRlDZe+bEL/7SiUC5anbsDjuz57oAZR4SOy/FKb3m3toYbPvfq7iZnmh1n0+jLquMp7/Kj1E2uHdt7u8RqQlLSMFOdSuHapaXs4Lpyd6qm94wTf7Kiuv63JLGGu9U5vm0YhlJP/b9VGIPGSJEo49FfyOezP/JvZ9MTdqn2reMuKb4eAf94mIMsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+Th4qUjbPv7qNfBJMzeIiONcrBvaMaX/TF5xJQs8a+Y=;
 b=KMEtEfPWdlB70NqnOoumid/Y3K3PAgzoJXDP7Mlw+GQH7oAWFV5kiqIvuSEb3CcqmKMbxzWCrBQNI04t2SrpqReQfoXeTQkJAK7mBTsUwFMKIOl1Ay+BMM6h1VebDw1mxzBWTG4hdoUMjvvOZLKXg55c+lKtfr7q5N+WwyL9Tdg=
Received: from SA1PR02CA0014.namprd02.prod.outlook.com (2603:10b6:806:2cf::21)
 by BY5PR12MB4195.namprd12.prod.outlook.com (2603:10b6:a03:200::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.19; Wed, 1 Oct
 2025 21:28:30 +0000
Received: from SA2PEPF00003F61.namprd04.prod.outlook.com
 (2603:10b6:806:2cf:cafe::53) by SA1PR02CA0014.outlook.office365.com
 (2603:10b6:806:2cf::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9182.15 via Frontend Transport; Wed,
 1 Oct 2025 21:28:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SA2PEPF00003F61.mail.protection.outlook.com (10.167.248.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9182.15 via Frontend Transport; Wed, 1 Oct 2025 21:28:30 +0000
Received: from kylin.lan (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 1 Oct
 2025 14:28:27 -0700
From: Alex Hung <alex.hung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>,
 Dillon Varone <dillon.varone@amd.com>
Subject: [PATCH 5/7] drm/amd/display: Driver implementation for cursor
 offloading to DMU
Date: Wed, 1 Oct 2025 15:24:10 -0600
Message-ID: <20251001212700.1458245-6-alex.hung@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251001212700.1458245-1-alex.hung@amd.com>
References: <20251001212700.1458245-1-alex.hung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003F61:EE_|BY5PR12MB4195:EE_
X-MS-Office365-Filtering-Correlation-Id: da664612-21e6-4095-efc4-08de01317770
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?3Tg97WZlWhY3S8H9cwjdfkkJWRh9FHc6GMYHoXCHDuhHXx2uLJO7ttWUKe2i?=
 =?us-ascii?Q?fnMMoOJY8WuaOhnj3hSAN3kyGizPhPWyQ+CoPwnZ4OzI/WnmB0xtgwMUn+FD?=
 =?us-ascii?Q?n3ebZertFckmZN9R8Z+fwcD+5IeRIKOperihjRUGkhjvKuFo2yBbYk5tK1UA?=
 =?us-ascii?Q?/5qqV231jjpYa+ol3FQFx9BaRzlvWVKaOlMUWYER/46EN4BFx3eMNbUDCs/P?=
 =?us-ascii?Q?nShi3ALXq8gxJZUbFEGwfYweVtFN1GjlGBQMZiBKpevfB4h++C8oG8ElpSOo?=
 =?us-ascii?Q?Oq3sstHnkQZZNTkppHkXu/7MlZ2arJrFqYyVWxMc8vJm8VipjukrJpjyVjXV?=
 =?us-ascii?Q?2g0jZ04jpkWg3vD/roXo+kkYVuHOfQwUV98EYGmhq8YETUubOiysFcsl4065?=
 =?us-ascii?Q?GrXbCu47AWvxTmiUxt/M4UWeZotv/oLKAM8X5r3ppUh6m9fGXWopmLaIE1ID?=
 =?us-ascii?Q?XmQFRysaqM28id73XsOWpVKPNA3AlIQvYLb/I9JhYjGcy/YLvLmGSsKsNKTD?=
 =?us-ascii?Q?7pQO8JpvH57ekK3VIM6CdEgefqLtYdmBHBVk3vCAZ2FkhDxnadUanTXCqtp9?=
 =?us-ascii?Q?99WDXeFtBMx5Cx/Gh084zCSqzuC6sD/8t7o6oRn8na20rBTEjOd3avqNZKAM?=
 =?us-ascii?Q?2GCeypL3NfHCkUb6qwN5IEcQjgvootBSxIxGVnyXY/fc6BLpya66RJgYlYyI?=
 =?us-ascii?Q?wJ+K3Lxt6RdX9Eijs5w/LkI51DwARwLmq8ZhxFvM/0m//a7F+z7vhLER1j0m?=
 =?us-ascii?Q?/mJPMloFGITyvrT2SCYQS78MGsLSUJbO/o8+XtZD1+d67HxZ9UDwHdSPkIM3?=
 =?us-ascii?Q?9KxXI40pISeTDc+QT/84Qgko4t6Mql/TEc2LK72KZT7NW/u/XMfRQTzNnNHr?=
 =?us-ascii?Q?Ga4ePKJkH6qQwKHwtPkL2h86s2BaQOQYKhih3jryNg7U1BkY6x7UIsbkyI0G?=
 =?us-ascii?Q?ZYQxLTSrGhj7FTYhVUpfjKJfj6cugO6g8X7E47MsQEhYLIscwioUy7k6+wz0?=
 =?us-ascii?Q?UNsgqaHLE88M71/6UuA016nByccHu9g3fwT46XDtLaswFrHglrHQgY+GS0rc?=
 =?us-ascii?Q?TFTgIL+/6LAFjvU6uuGG3W/fbV7EfnHogAB3fS0plflRHk/JQryLPLCMOzI4?=
 =?us-ascii?Q?bQhj9IXaj9F0Rq49cYm9hZ/nwOSBvsgNWMS73o1vBrjdVO5N6NKbYww8YhCw?=
 =?us-ascii?Q?tPpWIBzmlS73wCjh1KeA4Y5NkxLvPnCpY/QwXVt6Ejzu6wyrFpRLGN+dFFI4?=
 =?us-ascii?Q?Qy/wtm2VeKsq1yShnoja03qZK9xAoE8jL8B8a0z0NfJXQw3pC/EVWWbLTtkU?=
 =?us-ascii?Q?+IUgx3UcPmvXYL9fWPUpQYBZMWDfWNZISKagMwcAuGll+L1axvs7LNr2eDl5?=
 =?us-ascii?Q?k2xHYhNqEd0SOLteZaGVVPa/edI44Akoao+e9K6DOPNaAB0xzp7W0BIkv170?=
 =?us-ascii?Q?DWJZ3QsBtUQ44tNL3xAn+uHh4ONNLcJaauVE0mkgJGSJlxu369lAY2U4VbVC?=
 =?us-ascii?Q?HmTo7g9/l4COUXhgpLmbXqnp/Kht4nL9sFABryHsX7OU6bfnP66w9E0g/JhU?=
 =?us-ascii?Q?EShgMhW8AIEqf5GCwtA=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2025 21:28:30.1452 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: da664612-21e6-4095-efc4-08de01317770
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00003F61.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4195
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

From: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>

[Why]
We require an interlock between driver and firmware for upcoming
features and given that this could possibly happen on any single
cursor programming call (and that we can't asynchronously wait for
firmware to respond because of it) we'd be regressing cursor performance
by at least an extra 40us per call.

When we could possibly have cursor update every 20us - 100s from high
frequency gaming mice this means that we'd be stuttering or dropping
updates and impacting overall cursor performance.

We want a solution that can:

1. Interlock between other firmware features
2. Not stall out or require the DMCUB lock for every single update

[How]
When cursor offloading is enabled and supported by an ASIC driver will
route the cursor programming through to DMU as part of the regular
DC stream cursor programming interfaces for attributes and position.

The atomic pipe programming version will not be updated: this will still
follow the existing programming path by keeping track of a field that
specifies when the register writes should be deferred to DMU.

Cursor locking is not required when cursor offload is in progress since
the updates are consolidated and processed by DMU once at the end
of the frame in a periodic manner.

The shared buffer the firmware queries from is allocated along with the
rest of the scratch state region in an area that's accessible by
both firmware and driver.

The size of the cursor offload (v1) state will not change, but it does
have a unique union per ASIC version with room for expansion if needed.

When firmware features notifying DMU of DRR updates are not enabled we
now send an explicit vtotal min/max update via driver to DMU firmware
whenever the vtotal max changes. This is to allow the cursor programming
to determine the appropriate latch update point offset from vupdate.

Reviewed-by: Dillon Varone <dillon.varone@amd.com>
Signed-off-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc.c      |  12 ++
 .../drm/amd/display/dc/core/dc_hw_sequencer.c |  12 ++
 .../gpu/drm/amd/display/dc/core/dc_stream.c   |  42 ++++--
 drivers/gpu/drm/amd/display/dc/dc.h           |   1 +
 drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c  |  99 +++++++++++++
 drivers/gpu/drm/amd/display/dc/dc_dmub_srv.h  |  36 +++++
 .../drm/amd/display/dc/dpp/dcn10/dcn10_dpp.c  |  19 ++-
 .../drm/amd/display/dc/dpp/dcn30/dcn30_dpp.c  |  20 ++-
 .../amd/display/dc/dpp/dcn401/dcn401_dpp_cm.c |  42 ++++--
 .../amd/display/dc/hubp/dcn10/dcn10_hubp.c    |   1 +
 .../amd/display/dc/hubp/dcn20/dcn20_hubp.c    |  69 +++++----
 .../amd/display/dc/hwss/dcn10/dcn10_hwseq.c   |   3 +
 .../amd/display/dc/hwss/dcn20/dcn20_hwseq.c   |   3 +
 .../amd/display/dc/hwss/dcn35/dcn35_hwseq.c   | 138 ++++++++++++++++++
 .../amd/display/dc/hwss/dcn35/dcn35_hwseq.h   |   8 +
 .../amd/display/dc/hwss/dcn35/dcn35_init.c    |   6 +
 .../amd/display/dc/hwss/dcn401/dcn401_hwseq.c |  60 +++++++-
 .../amd/display/dc/hwss/dcn401/dcn401_hwseq.h |   2 +
 .../amd/display/dc/hwss/dcn401/dcn401_init.c  |   7 +
 .../drm/amd/display/dc/hwss/hw_sequencer.h    |  14 ++
 .../amd/display/dc/inc/hw/cursor_reg_cache.h  |  22 +++
 drivers/gpu/drm/amd/display/dc/inc/hw/dpp.h   |   1 +
 drivers/gpu/drm/amd/display/dc/inc/hw/hubp.h  |   1 +
 drivers/gpu/drm/amd/display/dmub/dmub_srv.h   |   6 +-
 .../gpu/drm/amd/display/dmub/src/dmub_srv.c   |  22 +--
 25 files changed, 567 insertions(+), 79 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index eae2dabd5182..2c2635b6cb0f 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -496,6 +496,10 @@ bool dc_stream_adjust_vmin_vmax(struct dc *dc,
 			return true;
 		}
 	}
+
+	if (dc->hwss.notify_cursor_offload_drr_update)
+		dc->hwss.notify_cursor_offload_drr_update(dc, dc->current_state, stream);
+
 	return false;
 }
 
@@ -2188,8 +2192,14 @@ static enum dc_status dc_commit_state_no_check(struct dc *dc, struct dc_state *c
 		dc->hwss.wait_for_mpcc_disconnect(dc, dc->res_pool, pipe);
 	}
 
+	for (i = 0; i < dc->current_state->stream_count; i++)
+		dc_dmub_srv_control_cursor_offload(dc, dc->current_state, dc->current_state->streams[i], false);
+
 	result = dc->hwss.apply_ctx_to_hw(dc, context);
 
+	for (i = 0; i < context->stream_count; i++)
+		dc_dmub_srv_control_cursor_offload(dc, context, context->streams[i], true);
+
 	if (result != DC_OK) {
 		/* Application of dc_state to hardware stopped. */
 		dc->current_state->res_ctx.link_enc_cfg_ctx.mode = LINK_ENC_CFG_STEADY;
@@ -4488,6 +4498,8 @@ static void commit_planes_for_stream(struct dc *dc,
 				pipe_ctx->plane_state->skip_manual_trigger)
 			continue;
 
+		if (dc->hwss.program_cursor_offload_now)
+			dc->hwss.program_cursor_offload_now(dc, pipe_ctx);
 		if (pipe_ctx->stream_res.tg->funcs->program_manual_trigger)
 			pipe_ctx->stream_res.tg->funcs->program_manual_trigger(pipe_ctx->stream_res.tg);
 	}
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_hw_sequencer.c b/drivers/gpu/drm/amd/display/dc/core/dc_hw_sequencer.c
index 25a07e5f4ed7..1bed3b14a287 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_hw_sequencer.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_hw_sequencer.c
@@ -911,6 +911,13 @@ void hwss_build_fast_sequence(struct dc *dc,
 					current_mpc_pipe->stream && current_mpc_pipe->plane_state &&
 					current_mpc_pipe->plane_state->update_flags.bits.addr_update &&
 					!current_mpc_pipe->plane_state->skip_manual_trigger) {
+				if (dc->hwss.program_cursor_offload_now) {
+					block_sequence[*num_steps].params.program_cursor_update_now_params.dc = dc;
+					block_sequence[*num_steps].params.program_cursor_update_now_params.pipe_ctx = current_mpc_pipe;
+					block_sequence[*num_steps].func = PROGRAM_CURSOR_UPDATE_NOW;
+					(*num_steps)++;
+				}
+
 				block_sequence[*num_steps].params.program_manual_trigger_params.pipe_ctx = current_mpc_pipe;
 				block_sequence[*num_steps].func = OPTC_PROGRAM_MANUAL_TRIGGER;
 				(*num_steps)++;
@@ -1004,6 +1011,11 @@ void hwss_execute_sequence(struct dc *dc,
 		case DMUB_HW_CONTROL_LOCK_FAST:
 			dc->hwss.dmub_hw_control_lock_fast(params);
 			break;
+		case PROGRAM_CURSOR_UPDATE_NOW:
+			dc->hwss.program_cursor_offload_now(
+				params->program_cursor_update_now_params.dc,
+				params->program_cursor_update_now_params.pipe_ctx);
+			break;
 		default:
 			ASSERT(false);
 			break;
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_stream.c b/drivers/gpu/drm/amd/display/dc/core/dc_stream.c
index 9ac2d41f8fca..ccaf37d3e7e4 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_stream.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_stream.c
@@ -231,6 +231,7 @@ void program_cursor_attributes(
 	int i;
 	struct resource_context *res_ctx;
 	struct pipe_ctx *pipe_to_program = NULL;
+	bool enable_cursor_offload = dc_dmub_srv_is_cursor_offload_enabled(dc);
 
 	if (!stream)
 		return;
@@ -245,9 +246,14 @@ void program_cursor_attributes(
 
 		if (!pipe_to_program) {
 			pipe_to_program = pipe_ctx;
-			dc->hwss.cursor_lock(dc, pipe_to_program, true);
-			if (pipe_to_program->next_odm_pipe)
-				dc->hwss.cursor_lock(dc, pipe_to_program->next_odm_pipe, true);
+
+			if (enable_cursor_offload && dc->hwss.begin_cursor_offload_update) {
+				dc->hwss.begin_cursor_offload_update(dc, pipe_ctx);
+			} else {
+				dc->hwss.cursor_lock(dc, pipe_to_program, true);
+				if (pipe_to_program->next_odm_pipe)
+					dc->hwss.cursor_lock(dc, pipe_to_program->next_odm_pipe, true);
+			}
 		}
 
 		dc->hwss.set_cursor_attribute(pipe_ctx);
@@ -255,12 +261,18 @@ void program_cursor_attributes(
 			dc_send_update_cursor_info_to_dmu(pipe_ctx, i);
 		if (dc->hwss.set_cursor_sdr_white_level)
 			dc->hwss.set_cursor_sdr_white_level(pipe_ctx);
+		if (enable_cursor_offload && dc->hwss.update_cursor_offload_pipe)
+			dc->hwss.update_cursor_offload_pipe(dc, pipe_ctx);
 	}
 
 	if (pipe_to_program) {
-		dc->hwss.cursor_lock(dc, pipe_to_program, false);
-		if (pipe_to_program->next_odm_pipe)
-			dc->hwss.cursor_lock(dc, pipe_to_program->next_odm_pipe, false);
+		if (enable_cursor_offload && dc->hwss.commit_cursor_offload_update) {
+			dc->hwss.commit_cursor_offload_update(dc, pipe_to_program);
+		} else {
+			dc->hwss.cursor_lock(dc, pipe_to_program, false);
+			if (pipe_to_program->next_odm_pipe)
+				dc->hwss.cursor_lock(dc, pipe_to_program->next_odm_pipe, false);
+		}
 	}
 }
 
@@ -366,6 +378,7 @@ void program_cursor_position(
 	int i;
 	struct resource_context *res_ctx;
 	struct pipe_ctx *pipe_to_program = NULL;
+	bool enable_cursor_offload = dc_dmub_srv_is_cursor_offload_enabled(dc);
 
 	if (!stream)
 		return;
@@ -384,16 +397,27 @@ void program_cursor_position(
 
 		if (!pipe_to_program) {
 			pipe_to_program = pipe_ctx;
-			dc->hwss.cursor_lock(dc, pipe_to_program, true);
+
+			if (enable_cursor_offload && dc->hwss.begin_cursor_offload_update)
+				dc->hwss.begin_cursor_offload_update(dc, pipe_ctx);
+			else
+				dc->hwss.cursor_lock(dc, pipe_to_program, true);
 		}
 
 		dc->hwss.set_cursor_position(pipe_ctx);
+		if (enable_cursor_offload && dc->hwss.update_cursor_offload_pipe)
+			dc->hwss.update_cursor_offload_pipe(dc, pipe_ctx);
+
 		if (dc->ctx->dmub_srv)
 			dc_send_update_cursor_info_to_dmu(pipe_ctx, i);
 	}
 
-	if (pipe_to_program)
-		dc->hwss.cursor_lock(dc, pipe_to_program, false);
+	if (pipe_to_program) {
+		if (enable_cursor_offload && dc->hwss.commit_cursor_offload_update)
+			dc->hwss.commit_cursor_offload_update(dc, pipe_to_program);
+		else
+			dc->hwss.cursor_lock(dc, pipe_to_program, false);
+	}
 }
 
 bool dc_stream_set_cursor_position(
diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index 5a0db8b21c27..945f541eb303 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -530,6 +530,7 @@ struct dc_config {
 	bool set_pipe_unlock_order;
 	bool enable_dpia_pre_training;
 	bool unify_link_enc_assignment;
+	bool enable_cursor_offload;
 	struct spl_sharpness_range dcn_sharpness_range;
 	struct spl_sharpness_range dcn_override_sharpness_range;
 };
diff --git a/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c b/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
index 53a088ebddef..c75663aefcf3 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
+++ b/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
@@ -1174,6 +1174,100 @@ void dc_dmub_srv_subvp_save_surf_addr(const struct dc_dmub_srv *dc_dmub_srv, con
 	dmub_srv_subvp_save_surf_addr(dc_dmub_srv->dmub, addr, subvp_index);
 }
 
+void dc_dmub_srv_cursor_offload_init(struct dc *dc)
+{
+	struct dmub_rb_cmd_cursor_offload_init *init;
+	struct dc_dmub_srv *dc_dmub_srv = dc->ctx->dmub_srv;
+	union dmub_rb_cmd cmd;
+
+	if (!dc->config.enable_cursor_offload)
+		return;
+
+	if (!dc_dmub_srv->dmub->meta_info.feature_bits.bits.cursor_offload_v1_support)
+		return;
+
+	if (!dc_dmub_srv->dmub->cursor_offload_fb.gpu_addr || !dc_dmub_srv->dmub->cursor_offload_fb.cpu_addr)
+		return;
+
+	if (!dc_dmub_srv->dmub->cursor_offload_v1)
+		return;
+
+	if (!dc_dmub_srv->dmub->shared_state)
+		return;
+
+	memset(&cmd, 0, sizeof(cmd));
+
+	init = &cmd.cursor_offload_init;
+	init->header.type = DMUB_CMD__CURSOR_OFFLOAD;
+	init->header.sub_type = DMUB_CMD__CURSOR_OFFLOAD_INIT;
+	init->header.payload_bytes = sizeof(init->init_data);
+	init->init_data.state_addr.quad_part = dc_dmub_srv->dmub->cursor_offload_fb.gpu_addr;
+	init->init_data.state_size = dc_dmub_srv->dmub->cursor_offload_fb.size;
+
+	dc_wake_and_execute_dmub_cmd(dc->ctx, &cmd, DM_DMUB_WAIT_TYPE_WAIT);
+
+	dc_dmub_srv->cursor_offload_enabled = true;
+}
+
+void dc_dmub_srv_control_cursor_offload(struct dc *dc, struct dc_state *context,
+					const struct dc_stream_state *stream, bool enable)
+{
+	struct pipe_ctx const *pipe_ctx;
+	struct dmub_rb_cmd_cursor_offload_stream_cntl *cntl;
+	union dmub_rb_cmd cmd;
+
+	if (!dc_dmub_srv_is_cursor_offload_enabled(dc))
+		return;
+
+	if (!stream)
+		return;
+
+	pipe_ctx = resource_get_otg_master_for_stream(&context->res_ctx, stream);
+	if (!pipe_ctx || !pipe_ctx->stream_res.tg || pipe_ctx->stream != stream)
+		return;
+
+	memset(&cmd, 0, sizeof(cmd));
+
+	cntl = &cmd.cursor_offload_stream_ctnl;
+	cntl->header.type = DMUB_CMD__CURSOR_OFFLOAD;
+	cntl->header.sub_type =
+		enable ? DMUB_CMD__CURSOR_OFFLOAD_STREAM_ENABLE : DMUB_CMD__CURSOR_OFFLOAD_STREAM_DISABLE;
+	cntl->header.payload_bytes = sizeof(cntl->data);
+
+	cntl->data.otg_inst = pipe_ctx->stream_res.tg->inst;
+	cntl->data.line_time_in_ns = 1u + (uint32_t)(div64_u64(stream->timing.h_total * 1000000ull,
+							       stream->timing.pix_clk_100hz / 10));
+
+	cntl->data.v_total_max = stream->adjust.v_total_max > stream->timing.v_total ?
+					 stream->adjust.v_total_max :
+					 stream->timing.v_total;
+
+	dc_wake_and_execute_dmub_cmd(dc->ctx, &cmd,
+				     enable ? DM_DMUB_WAIT_TYPE_NO_WAIT : DM_DMUB_WAIT_TYPE_WAIT);
+}
+
+void dc_dmub_srv_program_cursor_now(struct dc *dc, const struct pipe_ctx *pipe)
+{
+	struct dmub_rb_cmd_cursor_offload_stream_cntl *cntl;
+	union dmub_rb_cmd cmd;
+
+	if (!dc_dmub_srv_is_cursor_offload_enabled(dc))
+		return;
+
+	if (!pipe || !pipe->stream || !pipe->stream_res.tg)
+		return;
+
+	memset(&cmd, 0, sizeof(cmd));
+
+	cntl = &cmd.cursor_offload_stream_ctnl;
+	cntl->header.type = DMUB_CMD__CURSOR_OFFLOAD;
+	cntl->header.sub_type = DMUB_CMD__CURSOR_OFFLOAD_STREAM_PROGRAM;
+	cntl->header.payload_bytes = sizeof(cntl->data);
+	cntl->data.otg_inst = pipe->stream_res.tg->inst;
+
+	dc_wake_and_execute_dmub_cmd(dc->ctx, &cmd, DM_DMUB_WAIT_TYPE_NO_WAIT);
+}
+
 bool dc_dmub_srv_is_hw_pwr_up(struct dc_dmub_srv *dc_dmub_srv, bool wait)
 {
 	struct dc_context *dc_ctx;
@@ -2231,6 +2325,11 @@ bool dmub_lsdma_send_poll_reg_write_command(struct dc_dmub_srv *dc_dmub_srv, uin
 	return result;
 }
 
+bool dc_dmub_srv_is_cursor_offload_enabled(const struct dc *dc)
+{
+	return dc->ctx->dmub_srv && dc->ctx->dmub_srv->cursor_offload_enabled;
+}
+
 void dc_dmub_srv_release_hw(const struct dc *dc)
 {
 	struct dc_dmub_srv *dc_dmub_srv = dc->ctx->dmub_srv;
diff --git a/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.h b/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.h
index 7ef93444ef3c..9bb00d48fd5e 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.h
@@ -56,6 +56,7 @@ struct dc_dmub_srv {
 	union dmub_shared_state_ips_driver_signals driver_signals;
 	bool idle_allowed;
 	bool needs_idle_wake;
+	bool cursor_offload_enabled;
 };
 
 bool dc_dmub_srv_wait_for_pending(struct dc_dmub_srv *dc_dmub_srv);
@@ -325,6 +326,41 @@ bool dc_dmub_srv_ips_query_residency_info(const struct dc_context *ctx, uint8_t
 					  struct dmub_ips_residency_info *driver_info,
 					  enum ips_residency_mode ips_mode);
 
+/**
+ * dc_dmub_srv_cursor_offload_init() - Enables or disables cursor offloading for a stream.
+ *
+ * @dc: pointer to DC object
+ */
+void dc_dmub_srv_cursor_offload_init(struct dc *dc);
+
+/**
+ * dc_dmub_srv_control_cursor_offload() - Enables or disables cursor offloading for a stream.
+ *
+ * @dc: pointer to DC object
+ * @context: the DC context to reference for pipe allocations
+ * @stream: the stream to control
+ * @enable: true to enable cursor offload, false to disable
+ */
+void dc_dmub_srv_control_cursor_offload(struct dc *dc, struct dc_state *context,
+					const struct dc_stream_state *stream, bool enable);
+
+/**
+ * dc_dmub_srv_program_cursor_now() - Requests immediate cursor programming for a given pipe.
+ *
+ * @dc: pointer to DC object
+ * @pipe: top-most pipe for a stream.
+ */
+void dc_dmub_srv_program_cursor_now(struct dc *dc, const struct pipe_ctx *pipe);
+
+/**
+ * dc_dmub_srv_is_cursor_offload_enabled() - Checks if cursor offload is supported.
+ *
+ * @dc: pointer to DC object
+ *
+ * Return: true if cursor offload is supported, false otherwise
+ */
+bool dc_dmub_srv_is_cursor_offload_enabled(const struct dc *dc);
+
 /**
  * dc_dmub_srv_release_hw() - Notifies DMUB service that HW access is no longer required.
  *
diff --git a/drivers/gpu/drm/amd/display/dc/dpp/dcn10/dcn10_dpp.c b/drivers/gpu/drm/amd/display/dc/dpp/dcn10/dcn10_dpp.c
index 01480a04f85e..ce91e5d28956 100644
--- a/drivers/gpu/drm/amd/display/dc/dpp/dcn10/dcn10_dpp.c
+++ b/drivers/gpu/drm/amd/display/dc/dpp/dcn10/dcn10_dpp.c
@@ -199,6 +199,8 @@ void dpp_reset(struct dpp *dpp_base)
 
 	memset(&dpp->scl_data, 0, sizeof(dpp->scl_data));
 	memset(&dpp->pwl_data, 0, sizeof(dpp->pwl_data));
+
+	dpp_base->cursor_offload = false;
 }
 
 
@@ -484,10 +486,12 @@ void dpp1_set_cursor_position(
 		cur_en = 0;  /* not visible beyond top edge*/
 
 	if (dpp_base->pos.cur0_ctl.bits.cur0_enable != cur_en) {
-		REG_UPDATE(CURSOR0_CONTROL, CUR0_ENABLE, cur_en);
-
-		dpp_base->pos.cur0_ctl.bits.cur0_enable = cur_en;
+		if (!dpp_base->cursor_offload)
+			REG_UPDATE(CURSOR0_CONTROL, CUR0_ENABLE, cur_en);
 	}
+
+	dpp_base->pos.cur0_ctl.bits.cur0_enable = cur_en;
+	dpp_base->att.cur0_ctl.bits.cur0_enable = cur_en;
 }
 
 void dpp1_cnv_set_optional_cursor_attributes(
@@ -497,8 +501,13 @@ void dpp1_cnv_set_optional_cursor_attributes(
 	struct dcn10_dpp *dpp = TO_DCN10_DPP(dpp_base);
 
 	if (attr) {
-		REG_UPDATE(CURSOR0_FP_SCALE_BIAS,  CUR0_FP_BIAS,  attr->bias);
-		REG_UPDATE(CURSOR0_FP_SCALE_BIAS,  CUR0_FP_SCALE, attr->scale);
+		if (!dpp_base->cursor_offload) {
+			REG_UPDATE(CURSOR0_FP_SCALE_BIAS,  CUR0_FP_BIAS,  attr->bias);
+			REG_UPDATE(CURSOR0_FP_SCALE_BIAS,  CUR0_FP_SCALE, attr->scale);
+		}
+
+		dpp_base->att.fp_scale_bias.bits.fp_bias = attr->bias;
+		dpp_base->att.fp_scale_bias.bits.fp_scale = attr->scale;
 	}
 }
 
diff --git a/drivers/gpu/drm/amd/display/dc/dpp/dcn30/dcn30_dpp.c b/drivers/gpu/drm/amd/display/dc/dpp/dcn30/dcn30_dpp.c
index 09be2a90cc79..94d0dc3461d2 100644
--- a/drivers/gpu/drm/amd/display/dc/dpp/dcn30/dcn30_dpp.c
+++ b/drivers/gpu/drm/amd/display/dc/dpp/dcn30/dcn30_dpp.c
@@ -396,17 +396,21 @@ void dpp3_set_cursor_attributes(
 		}
 	}
 
-	REG_UPDATE_3(CURSOR0_CONTROL,
-			CUR0_MODE, color_format,
-			CUR0_EXPANSION_MODE, 0,
-			CUR0_ROM_EN, cur_rom_en);
+	if (!dpp_base->cursor_offload)
+		REG_UPDATE_3(CURSOR0_CONTROL,
+				CUR0_MODE, color_format,
+				CUR0_EXPANSION_MODE, 0,
+				CUR0_ROM_EN, cur_rom_en);
 
 	if (color_format == CURSOR_MODE_MONO) {
 		/* todo: clarify what to program these to */
-		REG_UPDATE(CURSOR0_COLOR0,
-				CUR0_COLOR0, 0x00000000);
-		REG_UPDATE(CURSOR0_COLOR1,
-				CUR0_COLOR1, 0xFFFFFFFF);
+
+		if (!dpp_base->cursor_offload) {
+			REG_UPDATE(CURSOR0_COLOR0,
+					CUR0_COLOR0, 0x00000000);
+			REG_UPDATE(CURSOR0_COLOR1,
+					CUR0_COLOR1, 0xFFFFFFFF);
+		}
 	}
 
 	dpp_base->att.cur0_ctl.bits.expansion_mode = 0;
diff --git a/drivers/gpu/drm/amd/display/dc/dpp/dcn401/dcn401_dpp_cm.c b/drivers/gpu/drm/amd/display/dc/dpp/dcn401/dcn401_dpp_cm.c
index 7aab77b58869..3adc17f2fc35 100644
--- a/drivers/gpu/drm/amd/display/dc/dpp/dcn401/dcn401_dpp_cm.c
+++ b/drivers/gpu/drm/amd/display/dc/dpp/dcn401/dcn401_dpp_cm.c
@@ -103,17 +103,21 @@ void dpp401_set_cursor_attributes(
 		}
 	}
 
-	REG_UPDATE_3(CURSOR0_CONTROL,
-		CUR0_MODE, color_format,
-		CUR0_EXPANSION_MODE, 0,
-		CUR0_ROM_EN, cur_rom_en);
+	if (!dpp_base->cursor_offload)
+		REG_UPDATE_3(CURSOR0_CONTROL,
+			CUR0_MODE, color_format,
+			CUR0_EXPANSION_MODE, 0,
+			CUR0_ROM_EN, cur_rom_en);
 
 	if (color_format == CURSOR_MODE_MONO) {
 		/* todo: clarify what to program these to */
-		REG_UPDATE(CURSOR0_COLOR0,
-			CUR0_COLOR0, 0x00000000);
-		REG_UPDATE(CURSOR0_COLOR1,
-			CUR0_COLOR1, 0xFFFFFFFF);
+
+		if (!dpp_base->cursor_offload) {
+			REG_UPDATE(CURSOR0_COLOR0,
+				CUR0_COLOR0, 0x00000000);
+			REG_UPDATE(CURSOR0_COLOR1,
+				CUR0_COLOR1, 0xFFFFFFFF);
+		}
 	}
 
 	dpp_base->att.cur0_ctl.bits.expansion_mode = 0;
@@ -132,10 +136,11 @@ void dpp401_set_cursor_position(
 	uint32_t cur_en = pos->enable ? 1 : 0;
 
 	if (dpp_base->pos.cur0_ctl.bits.cur0_enable != cur_en) {
-		REG_UPDATE(CURSOR0_CONTROL, CUR0_ENABLE, cur_en);
-
-		dpp_base->pos.cur0_ctl.bits.cur0_enable = cur_en;
+		if (!dpp_base->cursor_offload)
+			REG_UPDATE(CURSOR0_CONTROL, CUR0_ENABLE, cur_en);
 	}
+
+	dpp_base->pos.cur0_ctl.bits.cur0_enable = cur_en;
 }
 
 void dpp401_set_optional_cursor_attributes(
@@ -145,10 +150,17 @@ void dpp401_set_optional_cursor_attributes(
 	struct dcn401_dpp *dpp = TO_DCN401_DPP(dpp_base);
 
 	if (attr) {
-		REG_UPDATE(CURSOR0_FP_SCALE_BIAS_G_Y, CUR0_FP_BIAS_G_Y, attr->bias);
-		REG_UPDATE(CURSOR0_FP_SCALE_BIAS_G_Y, CUR0_FP_SCALE_G_Y, attr->scale);
-		REG_UPDATE(CURSOR0_FP_SCALE_BIAS_RB_CRCB, CUR0_FP_BIAS_RB_CRCB, attr->bias);
-		REG_UPDATE(CURSOR0_FP_SCALE_BIAS_RB_CRCB, CUR0_FP_SCALE_RB_CRCB, attr->scale);
+		if (!dpp_base->cursor_offload) {
+			REG_UPDATE(CURSOR0_FP_SCALE_BIAS_G_Y, CUR0_FP_BIAS_G_Y, attr->bias);
+			REG_UPDATE(CURSOR0_FP_SCALE_BIAS_G_Y, CUR0_FP_SCALE_G_Y, attr->scale);
+			REG_UPDATE(CURSOR0_FP_SCALE_BIAS_RB_CRCB, CUR0_FP_BIAS_RB_CRCB, attr->bias);
+			REG_UPDATE(CURSOR0_FP_SCALE_BIAS_RB_CRCB, CUR0_FP_SCALE_RB_CRCB, attr->scale);
+		}
+
+		dpp_base->att.fp_scale_bias_g_y.bits.fp_bias_g_y = attr->bias;
+		dpp_base->att.fp_scale_bias_g_y.bits.fp_scale_g_y = attr->scale;
+		dpp_base->att.fp_scale_bias_rb_crcb.bits.fp_bias_rb_crcb = attr->bias;
+		dpp_base->att.fp_scale_bias_rb_crcb.bits.fp_scale_rb_crcb = attr->scale;
 	}
 }
 
diff --git a/drivers/gpu/drm/amd/display/dc/hubp/dcn10/dcn10_hubp.c b/drivers/gpu/drm/amd/display/dc/hubp/dcn10/dcn10_hubp.c
index 9b026600b90e..6378e3fd7249 100644
--- a/drivers/gpu/drm/amd/display/dc/hubp/dcn10/dcn10_hubp.c
+++ b/drivers/gpu/drm/amd/display/dc/hubp/dcn10/dcn10_hubp.c
@@ -550,6 +550,7 @@ void hubp_reset(struct hubp *hubp)
 {
 	memset(&hubp->pos, 0, sizeof(hubp->pos));
 	memset(&hubp->att, 0, sizeof(hubp->att));
+	hubp->cursor_offload = false;
 }
 
 void hubp1_program_surface_config(
diff --git a/drivers/gpu/drm/amd/display/dc/hubp/dcn20/dcn20_hubp.c b/drivers/gpu/drm/amd/display/dc/hubp/dcn20/dcn20_hubp.c
index 91259b896e03..92288de4cc10 100644
--- a/drivers/gpu/drm/amd/display/dc/hubp/dcn20/dcn20_hubp.c
+++ b/drivers/gpu/drm/amd/display/dc/hubp/dcn20/dcn20_hubp.c
@@ -613,26 +613,28 @@ void hubp2_cursor_set_attributes(
 
 	hubp->curs_attr = *attr;
 
-	REG_UPDATE(CURSOR_SURFACE_ADDRESS_HIGH,
-			CURSOR_SURFACE_ADDRESS_HIGH, attr->address.high_part);
-	REG_UPDATE(CURSOR_SURFACE_ADDRESS,
-			CURSOR_SURFACE_ADDRESS, attr->address.low_part);
-
-	REG_UPDATE_2(CURSOR_SIZE,
-			CURSOR_WIDTH, attr->width,
-			CURSOR_HEIGHT, attr->height);
-
-	REG_UPDATE_4(CURSOR_CONTROL,
-			CURSOR_MODE, attr->color_format,
-			CURSOR_2X_MAGNIFY, attr->attribute_flags.bits.ENABLE_MAGNIFICATION,
-			CURSOR_PITCH, hw_pitch,
-			CURSOR_LINES_PER_CHUNK, lpc);
-
-	REG_SET_2(CURSOR_SETTINGS, 0,
-			/* no shift of the cursor HDL schedule */
-			CURSOR0_DST_Y_OFFSET, 0,
-			 /* used to shift the cursor chunk request deadline */
-			CURSOR0_CHUNK_HDL_ADJUST, 3);
+	if (!hubp->cursor_offload) {
+		REG_UPDATE(CURSOR_SURFACE_ADDRESS_HIGH,
+				CURSOR_SURFACE_ADDRESS_HIGH, attr->address.high_part);
+		REG_UPDATE(CURSOR_SURFACE_ADDRESS,
+				CURSOR_SURFACE_ADDRESS, attr->address.low_part);
+
+		REG_UPDATE_2(CURSOR_SIZE,
+				CURSOR_WIDTH, attr->width,
+				CURSOR_HEIGHT, attr->height);
+
+		REG_UPDATE_4(CURSOR_CONTROL,
+				CURSOR_MODE, attr->color_format,
+				CURSOR_2X_MAGNIFY, attr->attribute_flags.bits.ENABLE_MAGNIFICATION,
+				CURSOR_PITCH, hw_pitch,
+				CURSOR_LINES_PER_CHUNK, lpc);
+
+		REG_SET_2(CURSOR_SETTINGS, 0,
+				/* no shift of the cursor HDL schedule */
+				CURSOR0_DST_Y_OFFSET, 0,
+				/* used to shift the cursor chunk request deadline */
+				CURSOR0_CHUNK_HDL_ADJUST, 3);
+	}
 
 	hubp->att.SURFACE_ADDR_HIGH  = attr->address.high_part;
 	hubp->att.SURFACE_ADDR       = attr->address.low_part;
@@ -1059,23 +1061,28 @@ void hubp2_cursor_set_position(
 		cur_en = 0;  /* not visible beyond top edge*/
 
 	if (hubp->pos.cur_ctl.bits.cur_enable != cur_en) {
-		if (cur_en && REG_READ(CURSOR_SURFACE_ADDRESS) == 0)
+		bool cursor_not_programmed = hubp->att.SURFACE_ADDR == 0 && hubp->att.SURFACE_ADDR_HIGH == 0;
+
+		if (cur_en && cursor_not_programmed)
 			hubp->funcs->set_cursor_attributes(hubp, &hubp->curs_attr);
 
-		REG_UPDATE(CURSOR_CONTROL,
-			CURSOR_ENABLE, cur_en);
+		if (!hubp->cursor_offload)
+			REG_UPDATE(CURSOR_CONTROL, CURSOR_ENABLE, cur_en);
 	}
 
-	REG_SET_2(CURSOR_POSITION, 0,
-			CURSOR_X_POSITION, pos->x,
-			CURSOR_Y_POSITION, pos->y);
+	if (!hubp->cursor_offload) {
+		REG_SET_2(CURSOR_POSITION, 0,
+				CURSOR_X_POSITION, pos->x,
+				CURSOR_Y_POSITION, pos->y);
 
-	REG_SET_2(CURSOR_HOT_SPOT, 0,
-			CURSOR_HOT_SPOT_X, pos->x_hotspot,
-			CURSOR_HOT_SPOT_Y, pos->y_hotspot);
+		REG_SET_2(CURSOR_HOT_SPOT, 0,
+				CURSOR_HOT_SPOT_X, pos->x_hotspot,
+				CURSOR_HOT_SPOT_Y, pos->y_hotspot);
+
+		REG_SET(CURSOR_DST_OFFSET, 0,
+				CURSOR_DST_X_OFFSET, dst_x_offset);
+	}
 
-	REG_SET(CURSOR_DST_OFFSET, 0,
-			CURSOR_DST_X_OFFSET, dst_x_offset);
 	/* TODO Handle surface pixel formats other than 4:4:4 */
 	/* Cursor Position Register Config */
 	hubp->pos.cur_ctl.bits.cur_enable = cur_en;
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn10/dcn10_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn10/dcn10_hwseq.c
index c88781de6d18..fa62e40a9858 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn10/dcn10_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn10/dcn10_hwseq.c
@@ -3090,6 +3090,9 @@ static void dcn10_update_dchubp_dpp(
 	}
 
 	if (pipe_ctx->stream->cursor_attributes.address.quad_part != 0) {
+		if (dc->hwss.abort_cursor_offload_update)
+			dc->hwss.abort_cursor_offload_update(dc, pipe_ctx);
+
 		dc->hwss.set_cursor_attribute(pipe_ctx);
 		dc->hwss.set_cursor_position(pipe_ctx);
 
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c
index cf9e8ce784ce..6bd905905984 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c
@@ -1793,6 +1793,9 @@ void dcn20_update_dchubp_dpp(
 	if ((pipe_ctx->update_flags.bits.enable || pipe_ctx->update_flags.bits.opp_changed ||
 			pipe_ctx->update_flags.bits.scaler || viewport_changed == true) &&
 			pipe_ctx->stream->cursor_attributes.address.quad_part != 0) {
+		if (dc->hwss.abort_cursor_offload_update)
+			dc->hwss.abort_cursor_offload_update(dc, pipe_ctx);
+
 		dc->hwss.set_cursor_attribute(pipe_ctx);
 		dc->hwss.set_cursor_position(pipe_ctx);
 
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.c
index 7ea3fe48b329..404ff00c7130 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.c
@@ -1593,3 +1593,141 @@ void dcn35_hardware_release(struct dc *dc)
 	if (dc->hwss.hw_block_power_up)
 		dc->hwss.hw_block_power_up(dc, &pg_update_state);
 }
+
+void dcn35_abort_cursor_offload_update(struct dc *dc, const struct pipe_ctx *pipe)
+{
+	if (!dc_dmub_srv_is_cursor_offload_enabled(dc))
+		return;
+
+	/*
+	 * Insert a blank update to modify the write index and set pipe_mask to 0.
+	 *
+	 * While the DMU is interlocked with driver full pipe programming via
+	 * the DMU HW lock, if the cursor update begins to execute after a full
+	 * pipe programming occurs there are two possible issues:
+	 *
+	 * 1. Outdated cursor information is programmed, replacing the current update
+	 * 2. The cursor update in firmware holds the cursor lock, preventing
+	 *    the current update from being latched atomically in the same frame
+	 *    as the rest of the update.
+	 *
+	 * This blank update, treated as a no-op, will allow the firmware to skip
+	 * the programming.
+	 */
+
+	if (dc->hwss.begin_cursor_offload_update)
+		dc->hwss.begin_cursor_offload_update(dc, pipe);
+
+	if (dc->hwss.commit_cursor_offload_update)
+		dc->hwss.commit_cursor_offload_update(dc, pipe);
+}
+
+void dcn35_begin_cursor_offload_update(struct dc *dc, const struct pipe_ctx *pipe)
+{
+	volatile struct dmub_cursor_offload_v1 *cs = dc->ctx->dmub_srv->dmub->cursor_offload_v1;
+	const struct pipe_ctx *top_pipe = resource_get_otg_master(pipe);
+	uint32_t stream_idx, write_idx, payload_idx;
+
+	if (!top_pipe)
+		return;
+
+	stream_idx = top_pipe->pipe_idx;
+	write_idx = cs->offload_streams[stream_idx].write_idx + 1; /*  new payload (+1) */
+	payload_idx = write_idx % ARRAY_SIZE(cs->offload_streams[stream_idx].payloads);
+
+	cs->offload_streams[stream_idx].payloads[payload_idx].write_idx_start = write_idx;
+
+	if (pipe->plane_res.hubp)
+		pipe->plane_res.hubp->cursor_offload = true;
+
+	if (pipe->plane_res.dpp)
+		pipe->plane_res.dpp->cursor_offload = true;
+}
+
+void dcn35_commit_cursor_offload_update(struct dc *dc, const struct pipe_ctx *pipe)
+{
+	volatile struct dmub_cursor_offload_v1 *cs = dc->ctx->dmub_srv->dmub->cursor_offload_v1;
+	volatile struct dmub_shared_state_cursor_offload_stream_v1 *shared_stream;
+	const struct pipe_ctx *top_pipe = resource_get_otg_master(pipe);
+	uint32_t stream_idx, write_idx, payload_idx;
+
+	if (pipe->plane_res.hubp)
+		pipe->plane_res.hubp->cursor_offload = false;
+
+	if (pipe->plane_res.dpp)
+		pipe->plane_res.dpp->cursor_offload = false;
+
+	if (!top_pipe)
+		return;
+
+	stream_idx = top_pipe->pipe_idx;
+	write_idx = cs->offload_streams[stream_idx].write_idx + 1; /*  new payload (+1) */
+	payload_idx = write_idx % ARRAY_SIZE(cs->offload_streams[stream_idx].payloads);
+
+	shared_stream = &dc->ctx->dmub_srv->dmub->shared_state[DMUB_SHARED_STATE_FEATURE__CURSOR_OFFLOAD_V1]
+				 .data.cursor_offload_v1.offload_streams[stream_idx];
+
+	shared_stream->last_write_idx = write_idx;
+
+	cs->offload_streams[stream_idx].write_idx = write_idx;
+	cs->offload_streams[stream_idx].payloads[payload_idx].write_idx_finish = write_idx;
+}
+
+void dcn35_update_cursor_offload_pipe(struct dc *dc, const struct pipe_ctx *pipe)
+{
+	volatile struct dmub_cursor_offload_v1 *cs = dc->ctx->dmub_srv->dmub->cursor_offload_v1;
+	const struct pipe_ctx *top_pipe = resource_get_otg_master(pipe);
+	const struct hubp *hubp = pipe->plane_res.hubp;
+	const struct dpp *dpp = pipe->plane_res.dpp;
+	volatile struct dmub_cursor_offload_pipe_data_dcn30_v1 *p;
+	uint32_t stream_idx, write_idx, payload_idx;
+
+	if (!top_pipe || !hubp || !dpp)
+		return;
+
+	stream_idx = top_pipe->pipe_idx;
+	write_idx = cs->offload_streams[stream_idx].write_idx + 1; /*  new payload (+1) */
+	payload_idx = write_idx % ARRAY_SIZE(cs->offload_streams[stream_idx].payloads);
+
+	p = &cs->offload_streams[stream_idx].payloads[payload_idx].pipe_data[pipe->pipe_idx].dcn30;
+
+	p->CURSOR0_0_CURSOR_SURFACE_ADDRESS = hubp->att.SURFACE_ADDR;
+	p->CURSOR0_0_CURSOR_SURFACE_ADDRESS_HIGH = hubp->att.SURFACE_ADDR_HIGH;
+	p->CURSOR0_0_CURSOR_SIZE__CURSOR_WIDTH = hubp->att.size.bits.width;
+	p->CURSOR0_0_CURSOR_SIZE__CURSOR_HEIGHT = hubp->att.size.bits.height;
+	p->CURSOR0_0_CURSOR_POSITION__CURSOR_X_POSITION = hubp->pos.position.bits.x_pos;
+	p->CURSOR0_0_CURSOR_POSITION__CURSOR_Y_POSITION = hubp->pos.position.bits.y_pos;
+	p->CURSOR0_0_CURSOR_HOT_SPOT__CURSOR_HOT_SPOT_X = hubp->pos.hot_spot.bits.x_hot;
+	p->CURSOR0_0_CURSOR_HOT_SPOT__CURSOR_HOT_SPOT_Y = hubp->pos.hot_spot.bits.y_hot;
+	p->CURSOR0_0_CURSOR_DST_OFFSET__CURSOR_DST_X_OFFSET = hubp->pos.dst_offset.bits.dst_x_offset;
+	p->CURSOR0_0_CURSOR_CONTROL__CURSOR_ENABLE = hubp->pos.cur_ctl.bits.cur_enable;
+	p->CURSOR0_0_CURSOR_CONTROL__CURSOR_MODE = hubp->att.cur_ctl.bits.mode;
+	p->CURSOR0_0_CURSOR_CONTROL__CURSOR_2X_MAGNIFY = hubp->pos.cur_ctl.bits.cur_2x_magnify;
+	p->CURSOR0_0_CURSOR_CONTROL__CURSOR_PITCH = hubp->att.cur_ctl.bits.pitch;
+	p->CURSOR0_0_CURSOR_CONTROL__CURSOR_LINES_PER_CHUNK = hubp->pos.cur_ctl.bits.line_per_chunk;
+
+	p->CNVC_CUR0_CURSOR0_CONTROL__CUR0_ENABLE = dpp->att.cur0_ctl.bits.cur0_enable;
+	p->CNVC_CUR0_CURSOR0_CONTROL__CUR0_MODE = dpp->att.cur0_ctl.bits.mode;
+	p->CNVC_CUR0_CURSOR0_CONTROL__CUR0_EXPANSION_MODE = dpp->att.cur0_ctl.bits.expansion_mode;
+	p->CNVC_CUR0_CURSOR0_CONTROL__CUR0_ROM_EN = dpp->att.cur0_ctl.bits.cur0_rom_en;
+	p->CNVC_CUR0_CURSOR0_COLOR0__CUR0_COLOR0 = 0x000000;
+	p->CNVC_CUR0_CURSOR0_COLOR1__CUR0_COLOR1 = 0xFFFFFF;
+	p->CNVC_CUR0_CURSOR0_FP_SCALE_BIAS__CUR0_FP_BIAS = dpp->att.fp_scale_bias.bits.fp_bias;
+	p->CNVC_CUR0_CURSOR0_FP_SCALE_BIAS__CUR0_FP_SCALE = dpp->att.fp_scale_bias.bits.fp_scale;
+
+	p->HUBPREQ0_CURSOR_SETTINGS__CURSOR0_DST_Y_OFFSET = hubp->att.settings.bits.dst_y_offset;
+	p->HUBPREQ0_CURSOR_SETTINGS__CURSOR0_CHUNK_HDL_ADJUST = hubp->att.settings.bits.chunk_hdl_adjust;
+
+	cs->offload_streams[stream_idx].payloads[payload_idx].pipe_mask |= (1u << pipe->pipe_idx);
+}
+
+void dcn35_notify_cursor_offload_drr_update(struct dc *dc, struct dc_state *context,
+					    const struct dc_stream_state *stream)
+{
+	dc_dmub_srv_control_cursor_offload(dc, context, stream, true);
+}
+
+void dcn35_program_cursor_offload_now(struct dc *dc, const struct pipe_ctx *pipe)
+{
+	dc_dmub_srv_program_cursor_now(dc, pipe);
+}
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.h b/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.h
index 0b1d6f608edd..1ff41dba556c 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.h
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.h
@@ -101,4 +101,12 @@ bool dcn35_is_dp_dig_pixel_rate_div_policy(struct pipe_ctx *pipe_ctx);
 
 void dcn35_hardware_release(struct dc *dc);
 
+void dcn35_abort_cursor_offload_update(struct dc *dc, const struct pipe_ctx *pipe);
+void dcn35_begin_cursor_offload_update(struct dc *dc, const struct pipe_ctx *pipe);
+void dcn35_commit_cursor_offload_update(struct dc *dc, const struct pipe_ctx *pipe);
+void dcn35_update_cursor_offload_pipe(struct dc *dc, const struct pipe_ctx *pipe);
+void dcn35_notify_cursor_offload_drr_update(struct dc *dc, struct dc_state *context,
+					    const struct dc_stream_state *stream);
+void dcn35_program_cursor_offload_now(struct dc *dc, const struct pipe_ctx *pipe);
+
 #endif /* __DC_HWSS_DCN35_H__ */
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_init.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_init.c
index f2f16a0bdb4f..5a66c9db2670 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_init.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_init.c
@@ -86,6 +86,12 @@ static const struct hw_sequencer_funcs dcn35_funcs = {
 	.set_cursor_position = dcn10_set_cursor_position,
 	.set_cursor_attribute = dcn10_set_cursor_attribute,
 	.set_cursor_sdr_white_level = dcn10_set_cursor_sdr_white_level,
+	.abort_cursor_offload_update = dcn35_abort_cursor_offload_update,
+	.begin_cursor_offload_update = dcn35_begin_cursor_offload_update,
+	.commit_cursor_offload_update = dcn35_commit_cursor_offload_update,
+	.update_cursor_offload_pipe = dcn35_update_cursor_offload_pipe,
+	.notify_cursor_offload_drr_update = dcn35_notify_cursor_offload_drr_update,
+	.program_cursor_offload_now = dcn35_program_cursor_offload_now,
 	.setup_periodic_interrupt = dcn10_setup_periodic_interrupt,
 	.set_clock = dcn10_set_clock,
 	.get_clock = dcn10_get_clock,
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c
index ab21da435a36..71c2cfa4df75 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c
@@ -1473,7 +1473,10 @@ void dcn401_dmub_hw_control_lock(struct dc *dc,
 	/* use always for now */
 	union dmub_inbox0_cmd_lock_hw hw_lock_cmd = { 0 };
 
-	if (!dc->ctx || !dc->ctx->dmub_srv || !dc->debug.fams2_config.bits.enable)
+	if (!dc->ctx || !dc->ctx->dmub_srv)
+		return;
+
+	if (!dc->debug.fams2_config.bits.enable && !dc_dmub_srv_is_cursor_offload_enabled(dc))
 		return;
 
 	hw_lock_cmd.bits.command_code = DMUB_INBOX0_CMD__HW_LOCK;
@@ -2669,3 +2672,58 @@ void dcn401_plane_atomic_power_down(struct dc *dc,
 	if (hws->funcs.dpp_root_clock_control)
 		hws->funcs.dpp_root_clock_control(hws, dpp->inst, false);
 }
+
+void dcn401_update_cursor_offload_pipe(struct dc *dc, const struct pipe_ctx *pipe)
+{
+	volatile struct dmub_cursor_offload_v1 *cs = dc->ctx->dmub_srv->dmub->cursor_offload_v1;
+	const struct pipe_ctx *top_pipe = resource_get_otg_master(pipe);
+	const struct hubp *hubp = pipe->plane_res.hubp;
+	const struct dpp *dpp = pipe->plane_res.dpp;
+	volatile struct dmub_cursor_offload_pipe_data_dcn401_v1 *p;
+	uint32_t stream_idx, write_idx, payload_idx;
+
+	if (!top_pipe || !hubp || !dpp)
+		return;
+
+	stream_idx = top_pipe->pipe_idx;
+	write_idx = cs->offload_streams[stream_idx].write_idx;
+	payload_idx = write_idx % ARRAY_SIZE(cs->offload_streams[stream_idx].payloads);
+
+	p = &cs->offload_streams[stream_idx].payloads[payload_idx].pipe_data[pipe->pipe_idx].dcn401;
+
+	p->CURSOR0_0_CURSOR_SURFACE_ADDRESS = hubp->att.SURFACE_ADDR;
+	p->CURSOR0_0_CURSOR_SURFACE_ADDRESS_HIGH = hubp->att.SURFACE_ADDR_HIGH;
+	p->CURSOR0_0_CURSOR_SIZE__CURSOR_WIDTH = hubp->att.size.bits.width;
+	p->CURSOR0_0_CURSOR_SIZE__CURSOR_HEIGHT = hubp->att.size.bits.height;
+	p->CURSOR0_0_CURSOR_POSITION__CURSOR_X_POSITION = hubp->pos.position.bits.x_pos;
+	p->CURSOR0_0_CURSOR_POSITION__CURSOR_Y_POSITION = hubp->pos.position.bits.y_pos;
+	p->CURSOR0_0_CURSOR_HOT_SPOT__CURSOR_HOT_SPOT_X = hubp->pos.hot_spot.bits.x_hot;
+	p->CURSOR0_0_CURSOR_HOT_SPOT__CURSOR_HOT_SPOT_Y = hubp->pos.hot_spot.bits.y_hot;
+	p->CURSOR0_0_CURSOR_DST_OFFSET__CURSOR_DST_X_OFFSET = hubp->pos.dst_offset.bits.dst_x_offset;
+	p->CURSOR0_0_CURSOR_CONTROL__CURSOR_ENABLE = hubp->pos.cur_ctl.bits.cur_enable;
+	p->CURSOR0_0_CURSOR_CONTROL__CURSOR_MODE = hubp->att.cur_ctl.bits.mode;
+	p->CURSOR0_0_CURSOR_CONTROL__CURSOR_2X_MAGNIFY = hubp->pos.cur_ctl.bits.cur_2x_magnify;
+	p->CURSOR0_0_CURSOR_CONTROL__CURSOR_PITCH = hubp->att.cur_ctl.bits.pitch;
+	p->CURSOR0_0_CURSOR_CONTROL__CURSOR_LINES_PER_CHUNK = hubp->pos.cur_ctl.bits.line_per_chunk;
+
+	p->CM_CUR0_CURSOR0_CONTROL__CUR0_ENABLE = dpp->att.cur0_ctl.bits.cur0_enable;
+	p->CM_CUR0_CURSOR0_CONTROL__CUR0_MODE = dpp->att.cur0_ctl.bits.mode;
+	p->CM_CUR0_CURSOR0_CONTROL__CUR0_EXPANSION_MODE = dpp->att.cur0_ctl.bits.expansion_mode;
+	p->CM_CUR0_CURSOR0_CONTROL__CUR0_ROM_EN = dpp->att.cur0_ctl.bits.cur0_rom_en;
+	p->CM_CUR0_CURSOR0_COLOR0__CUR0_COLOR0 = 0x000000;
+	p->CM_CUR0_CURSOR0_COLOR1__CUR0_COLOR1 = 0xFFFFFF;
+
+	p->CM_CUR0_CURSOR0_FP_SCALE_BIAS_G_Y__CUR0_FP_BIAS_G_Y =
+		dpp->att.fp_scale_bias_g_y.bits.fp_bias_g_y;
+	p->CM_CUR0_CURSOR0_FP_SCALE_BIAS_G_Y__CUR0_FP_SCALE_G_Y =
+		dpp->att.fp_scale_bias_g_y.bits.fp_scale_g_y;
+	p->CM_CUR0_CURSOR0_FP_SCALE_BIAS_RB_CRCB__CUR0_FP_BIAS_RB_CRCB =
+		dpp->att.fp_scale_bias_rb_crcb.bits.fp_bias_rb_crcb;
+	p->CM_CUR0_CURSOR0_FP_SCALE_BIAS_RB_CRCB__CUR0_FP_SCALE_RB_CRCB =
+		dpp->att.fp_scale_bias_rb_crcb.bits.fp_scale_rb_crcb;
+
+	p->HUBPREQ0_CURSOR_SETTINGS__CURSOR0_DST_Y_OFFSET = hubp->att.settings.bits.dst_y_offset;
+	p->HUBPREQ0_CURSOR_SETTINGS__CURSOR0_CHUNK_HDL_ADJUST = hubp->att.settings.bits.chunk_hdl_adjust;
+
+	cs->offload_streams[stream_idx].payloads[payload_idx].pipe_mask |= (1u << pipe->pipe_idx);
+}
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.h b/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.h
index 9591657d8eee..f489bb7a4c26 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.h
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.h
@@ -110,4 +110,6 @@ void dcn401_plane_atomic_power_down(struct dc *dc,
 		struct dpp *dpp,
 		struct hubp *hubp);
 void dcn401_initialize_min_clocks(struct dc *dc);
+void dcn401_update_cursor_offload_pipe(struct dc *dc, const struct pipe_ctx *pipe);
+
 #endif /* __DC_HWSS_DCN401_H__ */
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_init.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_init.c
index a221b8cb6d4d..1c736b7e3300 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_init.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_init.c
@@ -9,6 +9,7 @@
 #include "dcn30/dcn30_hwseq.h"
 #include "dcn31/dcn31_hwseq.h"
 #include "dcn32/dcn32_hwseq.h"
+#include "dcn35/dcn35_hwseq.h"
 #include "dcn401/dcn401_hwseq.h"
 #include "dcn401_init.h"
 
@@ -60,6 +61,12 @@ static const struct hw_sequencer_funcs dcn401_funcs = {
 	.set_cursor_position = dcn401_set_cursor_position,
 	.set_cursor_attribute = dcn10_set_cursor_attribute,
 	.set_cursor_sdr_white_level = dcn10_set_cursor_sdr_white_level,
+	.abort_cursor_offload_update = dcn35_abort_cursor_offload_update,
+	.begin_cursor_offload_update = dcn35_begin_cursor_offload_update,
+	.commit_cursor_offload_update = dcn35_commit_cursor_offload_update,
+	.update_cursor_offload_pipe = dcn401_update_cursor_offload_pipe,
+	.notify_cursor_offload_drr_update = dcn35_notify_cursor_offload_drr_update,
+	.program_cursor_offload_now = dcn35_program_cursor_offload_now,
 	.setup_periodic_interrupt = dcn10_setup_periodic_interrupt,
 	.set_clock = dcn10_set_clock,
 	.get_clock = dcn10_get_clock,
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/hw_sequencer.h b/drivers/gpu/drm/amd/display/dc/hwss/hw_sequencer.h
index 619ac4dfff07..a937a2b2135e 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/hw_sequencer.h
+++ b/drivers/gpu/drm/amd/display/dc/hwss/hw_sequencer.h
@@ -154,6 +154,11 @@ struct dmub_hw_control_lock_fast_params {
 	bool lock;
 };
 
+struct program_cursor_update_now_params {
+	struct dc *dc;
+	struct pipe_ctx *pipe_ctx;
+};
+
 union block_sequence_params {
 	struct update_plane_addr_params update_plane_addr_params;
 	struct subvp_pipe_control_lock_fast_params subvp_pipe_control_lock_fast_params;
@@ -174,6 +179,7 @@ union block_sequence_params {
 	struct subvp_save_surf_addr subvp_save_surf_addr;
 	struct wait_for_dcc_meta_propagation_params wait_for_dcc_meta_propagation_params;
 	struct dmub_hw_control_lock_fast_params dmub_hw_control_lock_fast_params;
+	struct program_cursor_update_now_params program_cursor_update_now_params;
 };
 
 enum block_sequence_func {
@@ -196,6 +202,7 @@ enum block_sequence_func {
 	DMUB_SUBVP_SAVE_SURF_ADDR,
 	HUBP_WAIT_FOR_DCC_META_PROP,
 	DMUB_HW_CONTROL_LOCK_FAST,
+	PROGRAM_CURSOR_UPDATE_NOW,
 	/* This must be the last value in this enum, add new ones above */
 	HWSS_BLOCK_SEQUENCE_FUNC_COUNT
 };
@@ -310,6 +317,13 @@ struct hw_sequencer_funcs {
 	void (*set_cursor_position)(struct pipe_ctx *pipe);
 	void (*set_cursor_attribute)(struct pipe_ctx *pipe);
 	void (*set_cursor_sdr_white_level)(struct pipe_ctx *pipe);
+	void (*abort_cursor_offload_update)(struct dc *dc, const struct pipe_ctx *pipe);
+	void (*begin_cursor_offload_update)(struct dc *dc, const struct pipe_ctx *pipe);
+	void (*commit_cursor_offload_update)(struct dc *dc, const struct pipe_ctx *pipe);
+	void (*update_cursor_offload_pipe)(struct dc *dc, const struct pipe_ctx *pipe);
+	void (*notify_cursor_offload_drr_update)(struct dc *dc, struct dc_state *context,
+						 const struct dc_stream_state *stream);
+	void (*program_cursor_offload_now)(struct dc *dc, const struct pipe_ctx *pipe);
 
 	/* Colour Related */
 	void (*program_gamut_remap)(struct pipe_ctx *pipe_ctx);
diff --git a/drivers/gpu/drm/amd/display/dc/inc/hw/cursor_reg_cache.h b/drivers/gpu/drm/amd/display/dc/inc/hw/cursor_reg_cache.h
index 45645f9fd86c..081831230821 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/hw/cursor_reg_cache.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/hw/cursor_reg_cache.h
@@ -83,12 +83,34 @@ union reg_cur0_control_cfg {
 	} bits;
 	uint32_t raw;
 };
+
 struct cursor_position_cache_dpp {
 	union reg_cur0_control_cfg cur0_ctl;
 };
 
 struct cursor_attribute_cache_dpp {
 	union reg_cur0_control_cfg cur0_ctl;
+	union reg_cur0_fp_scale_bias {
+		struct {
+			uint32_t  fp_bias: 16;
+			uint32_t fp_scale: 16;
+		} bits;
+		uint32_t raw;
+	} fp_scale_bias;
+	union reg_cur0_fp_scale_bias_g_y {
+		struct {
+			uint32_t  fp_bias_g_y: 16;
+			uint32_t fp_scale_g_y: 16;
+		} bits;
+		uint32_t raw;
+	} fp_scale_bias_g_y;
+	union reg_cur0_fp_scale_bias_rb_crcb {
+		struct {
+			uint32_t  fp_bias_rb_crcb: 16;
+			uint32_t fp_scale_rb_crcb: 16;
+		} bits;
+		uint32_t raw;
+	} fp_scale_bias_rb_crcb;
 };
 
 struct cursor_attributes_cfg {
diff --git a/drivers/gpu/drm/amd/display/dc/inc/hw/dpp.h b/drivers/gpu/drm/amd/display/dc/inc/hw/dpp.h
index 1b7c085dc2cc..09c224691618 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/hw/dpp.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/hw/dpp.h
@@ -84,6 +84,7 @@ struct dpp {
 
 	struct pwl_params shaper_params;
 	bool cm_bypass_mode;
+	bool cursor_offload;
 
 	struct cursor_position_cache_dpp  pos;
 	struct cursor_attribute_cache_dpp att;
diff --git a/drivers/gpu/drm/amd/display/dc/inc/hw/hubp.h b/drivers/gpu/drm/amd/display/dc/inc/hw/hubp.h
index 2b874d2cc61c..5998a20a18c4 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/hw/hubp.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/hw/hubp.h
@@ -126,6 +126,7 @@ struct hubp {
 	int mpcc_id;
 	struct dc_cursor_attributes curs_attr;
 	struct dc_cursor_position curs_pos;
+	bool cursor_offload;
 	bool power_gated;
 
 	struct cursor_position_cache_hubp  pos;
diff --git a/drivers/gpu/drm/amd/display/dmub/dmub_srv.h b/drivers/gpu/drm/amd/display/dmub/dmub_srv.h
index 338fdc651f2c..9012a7ba1602 100644
--- a/drivers/gpu/drm/amd/display/dmub/dmub_srv.h
+++ b/drivers/gpu/drm/amd/display/dmub/dmub_srv.h
@@ -132,6 +132,7 @@ enum dmub_window_id {
 	DMUB_WINDOW_IB_MEM,
 	DMUB_WINDOW_SHARED_STATE,
 	DMUB_WINDOW_LSDMA_BUFFER,
+	DMUB_WINDOW_CURSOR_OFFLOAD,
 	DMUB_WINDOW_TOTAL,
 };
 
@@ -535,7 +536,8 @@ struct dmub_srv_create_params {
  * @fw_version: the current firmware version, if any
  * @is_virtual: false if hardware support only
  * @shared_state: dmub shared state between firmware and driver
- * @fw_state: dmub firmware state pointer
+ * @cursor_offload_v1: Cursor offload state
+ * @fw_state: dmub firmware state pointer (debug purpose only)
  */
 struct dmub_srv {
 	enum dmub_asic asic;
@@ -544,7 +546,9 @@ struct dmub_srv {
 	bool is_virtual;
 	struct dmub_fb scratch_mem_fb;
 	struct dmub_fb ib_mem_gart;
+	struct dmub_fb cursor_offload_fb;
 	volatile struct dmub_shared_state_feature_block *shared_state;
+	volatile struct dmub_cursor_offload_v1 *cursor_offload_v1;
 	volatile const struct dmub_fw_state *fw_state;
 
 	/* private: internal use only */
diff --git a/drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c b/drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c
index b17a19400c06..0244c9b44ecc 100644
--- a/drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c
+++ b/drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c
@@ -564,10 +564,11 @@ enum dmub_status
 	window_sizes[DMUB_WINDOW_4_MAILBOX] = DMUB_MAILBOX_SIZE;
 	window_sizes[DMUB_WINDOW_5_TRACEBUFF] = trace_buffer_size;
 	window_sizes[DMUB_WINDOW_6_FW_STATE] = fw_state_size;
-	window_sizes[DMUB_WINDOW_7_SCRATCH_MEM] = DMUB_SCRATCH_MEM_SIZE;
+	window_sizes[DMUB_WINDOW_7_SCRATCH_MEM] = dmub_align(DMUB_SCRATCH_MEM_SIZE, 64);
 	window_sizes[DMUB_WINDOW_IB_MEM] = DMUB_IB_MEM_SIZE;
 	window_sizes[DMUB_WINDOW_SHARED_STATE] = max(DMUB_FW_HEADER_SHARED_STATE_SIZE, shared_state_size);
 	window_sizes[DMUB_WINDOW_LSDMA_BUFFER] = DMUB_LSDMA_RB_SIZE;
+	window_sizes[DMUB_WINDOW_CURSOR_OFFLOAD] = dmub_align(sizeof(struct dmub_cursor_offload_v1), 64);
 
 	out->fb_size =
 		dmub_srv_calc_regions_for_memory_type(params, out, window_sizes, DMUB_WINDOW_MEMORY_TYPE_FB);
@@ -652,21 +653,22 @@ enum dmub_status dmub_srv_hw_init(struct dmub_srv *dmub,
 	struct dmub_fb *mail_fb = params->fb[DMUB_WINDOW_4_MAILBOX];
 	struct dmub_fb *tracebuff_fb = params->fb[DMUB_WINDOW_5_TRACEBUFF];
 	struct dmub_fb *fw_state_fb = params->fb[DMUB_WINDOW_6_FW_STATE];
-	struct dmub_fb *scratch_mem_fb = params->fb[DMUB_WINDOW_7_SCRATCH_MEM];
-	struct dmub_fb *ib_mem_gart = params->fb[DMUB_WINDOW_IB_MEM];
 	struct dmub_fb *shared_state_fb = params->fb[DMUB_WINDOW_SHARED_STATE];
 
 	struct dmub_rb_init_params rb_params, outbox0_rb_params;
 	struct dmub_window cw0, cw1, cw2, cw3, cw4, cw5, cw6, region6;
 	struct dmub_region inbox1, outbox1, outbox0;
 
+	uint32_t i;
+
 	if (!dmub->sw_init)
 		return DMUB_STATUS_INVALID;
 
-	if (!inst_fb || !stack_fb || !data_fb || !bios_fb || !mail_fb ||
-		!tracebuff_fb || !fw_state_fb || !scratch_mem_fb || !ib_mem_gart) {
-		ASSERT(0);
-		return DMUB_STATUS_INVALID;
+	for (i = 0; i < DMUB_WINDOW_TOTAL; ++i) {
+		if (!params->fb[i]) {
+			ASSERT(0);
+			return DMUB_STATUS_INVALID;
+		}
 	}
 
 	dmub->fb_base = params->fb_base;
@@ -748,9 +750,11 @@ enum dmub_status dmub_srv_hw_init(struct dmub_srv *dmub,
 
 	dmub->shared_state = shared_state_fb->cpu_addr;
 
-	dmub->scratch_mem_fb = *scratch_mem_fb;
+	dmub->scratch_mem_fb = *params->fb[DMUB_WINDOW_7_SCRATCH_MEM];
+	dmub->ib_mem_gart = *params->fb[DMUB_WINDOW_IB_MEM];
 
-	dmub->ib_mem_gart = *ib_mem_gart;
+	dmub->cursor_offload_fb = *params->fb[DMUB_WINDOW_CURSOR_OFFLOAD];
+	dmub->cursor_offload_v1 = (struct dmub_cursor_offload_v1 *)dmub->cursor_offload_fb.cpu_addr;
 
 	if (dmub->hw_funcs.setup_windows)
 		dmub->hw_funcs.setup_windows(dmub, &cw2, &cw3, &cw4, &cw5, &cw6, &region6);
-- 
2.43.0

