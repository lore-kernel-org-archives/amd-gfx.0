Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D2C6606A321
	for <amd-gfx@archiver.kernel.org>; Wed, 25 Nov 2026 06:57:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=SoAdHeKN
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C195210F63C;
	Wed, 25 Nov 2026 06:57:22 +0000 (UTC)
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013016.outbound.protection.outlook.com
 [40.107.201.16])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 448BD10F635
 for <amd-gfx@lists.freedesktop.org>; Wed, 25 Nov 2026 06:57:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IAAgcykvqa6gpYlTNnCVj5Li2BThseQNIr/YKjc6siOT9Lh9zNWFot8SkSOsuuSSNxK+RC89c8Xz8VPBz1mhokjWKO+nRXYpe4CzOvOHV/CJFbYfaiLZBrMjxeLxxltxiCWCuyfoT7UQz50m2HheqG2n8lNJ8/Cm05Qs7o7oKHp5VJEA9jEDGqMdIoCYTee4Sa8kEGiGDOjZ5R7nMRDeM8F4rFnB0UgcLqZMe1/WkyqixfCGIAXa/38tLpBaNl13x5qFeo2ShomuG6Ze83nuBEsbW0bBkbbIqcUy78DtXrE0jBjFvoAPTUFMbb6cx3d7Dw5zpWntmzuZVn5//OKv+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UWVcEBx+3HNAIJ6QxRD2pJay4yu0ZmdsOLLIyWhCiCI=;
 b=bG7TjM7dxblvanYNf5qJ9Wp2h8MsqeCceyt+9wNnyJ8igqQjNnO2rPhorGgtJnGfUQrIWNk+jQZdG52gXWHoLwNGT2K8TBVl7n2Lm2UETauMnqnM9T6CF7/4hKYVNYuX1eyQua0Z5jrYi8t8iEqQjt3ByNTFGmlXejBFN8zNz6hEZ30aq42IwBUzaXdqw4pGswoT5cwHZVJRM75AUbWAjh7GZgkacg4SwI1Dba8rPi6/SROTF0o8yr50i+GGzpax30JSHt8ZKyp2wr03YjqGGopg+6Drt0V7eNIm9n0kSlTVW7ZYA64XLaYqnP6355Ps2RjMLjPxZle2p89r2ahobw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UWVcEBx+3HNAIJ6QxRD2pJay4yu0ZmdsOLLIyWhCiCI=;
 b=SoAdHeKNUlN5BMezyHCf7srSJOWBUzU3ylm6zeuMa+qNZpZJwL/QscIRR89YFzw/LMmfv2cB9DJBKlCDMab1qTfox9Kg7IuryxVUK8jnf+OdUcYTmIIxOiWjAEU4DD4qTReoPwZQgZPqoKvh/mYX8R4DefeTChkeFhpGP8ybWcU=
Received: from CY5PR20CA0005.namprd20.prod.outlook.com (2603:10b6:930:3::9) by
 PH0PR12MB5630.namprd12.prod.outlook.com (2603:10b6:510:146::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.13; Wed, 25 Nov
 2026 06:55:57 +0000
Received: from EA8PEPF0000000C.namprd05.prod.outlook.com
 (2603:10b6:930:3:cafe::31) by CY5PR20CA0005.outlook.office365.com
 (2603:10b6:930:3::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.662.7 via Frontend Transport; Wed, 25
 Nov 2026 06:55:57 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 EA8PEPF0000000C.mail.protection.outlook.com (10.167.249.235) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.662.3 via Frontend Transport; Wed, 25 Nov 2026 06:55:56 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Wed, 25 Nov
 2026 00:55:56 -0600
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Wed, 25 Nov
 2026 00:55:56 -0600
Received: from chenyu-station.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.57 via Frontend
 Transport; Wed, 25 Nov 2026 00:55:47 -0600
From: Chenyu Chen <chen-yu.chen@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Piotr Maziarz <piotr.maziarz@amd.com>, Alvin Lee
 <alvin.lee2@amd.com>, Chenyu Chen <chen-yu.chen@amd.com>
Subject: [PATCH 05/27] drm/amd/display: Decouple PROGRAM_CURSOR_UPDATE_NOW
 from dc and pipe_ctx
Date: Wed, 25 Nov 2026 14:54:54 +0800
Message-ID: <20261125065631.3889665-6-chen-yu.chen@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261125065631.3889665-1-chen-yu.chen@amd.com>
References: <20261125065631.3889665-1-chen-yu.chen@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: EA8PEPF0000000C:EE_|PH0PR12MB5630:EE_
X-MS-Office365-Filtering-Correlation-Id: 7c93978e-7711-4e18-b9e2-08df4ac1280a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|23010399003|36860700016|6133799003|18002099003|22082099003|3023799007|11063799006|56012099006|261026140227099003|261022105027099003|261102123227099003|261028144727099003|261021121427099003|261021123027099003|261009223027099003|10067099003;
X-Microsoft-Antispam-Message-Info: R23WRT2eA9xmFeqcGJzO2JTEW9xmOrrHYVFNbs5+HEWpwowJg3riMisnb0yTJBM4SRr5o/cQt/crbb1gwcv9s0rJsIYdzYaiC16kt/UBtlqFh5Ct+CVRmw2R1HEGrLJNtWnEhhlTnQoiwJHlva8YKURJA8iMlqy0jM0ZyMBlApIuRr7bmRhonIifo2PUiGB8LKMaUJY4jrDAbbVg89zJ+Kh6qrTUPcZhPm2xWnKQwxMzVqaBQzHSxD9TQRfFexnQnCVdhaLELS3N0bv10jltEIv6sot0oWTidYSba8YOzLbua/AQVb3Cckz5ygdxE4tBH359oUeLc3lupGhCSEMasYh2IkTfkKzmpwu3vdqhYX48WGEjmRkAnzYCh6SUqek5QU4/iSjrw7f/iyuWAwazVooNVTxWtLfFXYRR7GLe6ESjNpbou4Hf4VICvFF+6Z0GSHeIzDX+0NmbhT0SDOBEdOsDLjmlHFrGfQwyv7CtARGQ1vXhHOVpNWzDRCNeV9wyQTGYYkioEtMzPDd015z0JMw3YeqsOEf2l1eIxCv8HuQg/kqIwfmnxuARoqMP7nMcRmDMIePbN8IL/6E+Qo1QrnxaWtnRwpRyDvGHFvrrKv0pirzxI3FraxzHDuF8b5rjSLRks8cf1p3uyw+u805BJSMn7n5iPvlfsN2043LgT+9L00j7xdpTIRxkoub0DNSHewrVySySnTAGIUM2ozO7dw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(23010399003)(36860700016)(6133799003)(18002099003)(22082099003)(3023799007)(11063799006)(56012099006)(261026140227099003)(261022105027099003)(261102123227099003)(261028144727099003)(261021121427099003)(261021123027099003)(261009223027099003)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: j3fwFw3R1xvDbS4xbOYDnZndVNrV8B14SI+7c9lwZYM4/4ZSnIxtDFXUBZAMxvvtWeoMGaLnCyBhTiNcnYpsEoNzrGVJXKcTLwBzjW/nI5qkiR5oy4ytVwJFN7PDlt4D4+W8Ao2TmgkK64CxckBm93+6fzzrbQOoKt3F/uO4LrXAihO4Ckxpp7/W5vWnVYFZ8b2rwLGc2OXjh7yjNOqnpmrhCXnvZ4zcFHimXgZTUcmBzIpkNd0mIEcSBGcaSN/Eo3GITJl1WZ6E9Wkdr9G4R266UdJfrzPehaZGJbddDrJzKeHOWdgM02cfSPEHuPviKvbADBuzfxGwm3gST81vieF8PVj3aj5Hir7MJgQX9wlZbkPa4aBwwOCLEryADtsm66VTpAJeX3q7Tle5NcilgqHDbcMba0rVLx7T+CdLJj1WvIgwqKKSVeVojta+dsUZ
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2026 06:55:56.9492 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c93978e-7711-4e18-b9e2-08df4ac1280a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: EA8PEPF0000000C.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5630
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Piotr Maziarz <piotr.maziarz@amd.com>

[WHY]
PROGRAM_CURSOR_UPDATE_NOW carried dc and pipe_ctx, and its executor
read the OTG instance and the cursor offload state through them at run
time, against the BLS contract.

[HOW]
Carry the DMUB service handle and the OTG instance instead, filled by
the new hwss_add_program_cursor_update_now(). The executor passes them
through the program_cursor_offload_now hook to
dc_dmub_srv_program_cursor_now(), which checks the service itself for
cursor offload. The non-BLS path in commit_planes_for_stream uses the
same hook signature.

Cc: Alvin Lee <alvin.lee2@amd.com>
Signed-off-by: Piotr Maziarz <piotr.maziarz@amd.com>
Signed-off-by: Chenyu Chen <chen-yu.chen@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc.c      |  3 +-
 .../drm/amd/display/dc/core/dc_hw_sequencer.c | 28 +++++++++++++------
 drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c  | 11 +++-----
 drivers/gpu/drm/amd/display/dc/dc_dmub_srv.h  |  8 +++---
 .../amd/display/dc/hwss/dcn35/dcn35_hwseq.c   |  4 +--
 .../amd/display/dc/hwss/dcn35/dcn35_hwseq.h   |  2 +-
 .../drm/amd/display/dc/hwss/hw_sequencer.h    | 10 +++++--
 7 files changed, 40 insertions(+), 26 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index 92cb123e459b..584eb3e0f4c6 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -5435,7 +5435,8 @@ static void commit_planes_for_stream(struct dc *dc,
 			continue;
 
 		if (dc->hwss.program_cursor_offload_now)
-			dc->hwss.program_cursor_offload_now(dc, pipe_ctx);
+			dc->hwss.program_cursor_offload_now(dc->ctx->dmub_srv,
+					pipe_ctx->stream_res.tg->inst);
 		if (pipe_ctx->stream_res.tg->funcs->program_manual_trigger)
 			pipe_ctx->stream_res.tg->funcs->program_manual_trigger(pipe_ctx->stream_res.tg);
 	}
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_hw_sequencer.c b/drivers/gpu/drm/amd/display/dc/core/dc_hw_sequencer.c
index 241cbe19056d..079a9ee8c5f5 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_hw_sequencer.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_hw_sequencer.c
@@ -1715,12 +1715,9 @@ void hwss_build_fast_sequence(struct dc *dc,
 					current_mpc_pipe->stream && current_mpc_pipe->plane_state &&
 					current_mpc_pipe->plane_state->update_bits.addr_update &&
 					!current_mpc_pipe->plane_state->skip_manual_trigger) {
-				if (dc->hwss.program_cursor_offload_now) {
-					block_sequence[*num_steps].params.program_cursor_update_now_params.dc = dc;
-					block_sequence[*num_steps].params.program_cursor_update_now_params.pipe_ctx = current_mpc_pipe;
-					block_sequence[*num_steps].func = PROGRAM_CURSOR_UPDATE_NOW;
-					(*num_steps)++;
-				}
+				if (dc->hwss.program_cursor_offload_now)
+					hwss_add_program_cursor_update_now(&seq_state, dc->ctx->dmub_srv,
+							current_mpc_pipe->stream_res.tg->inst);
 
 				hwss_add_optc_program_manual_trigger(&seq_state, current_mpc_pipe->stream_res.tg);
 			}
@@ -1849,8 +1846,8 @@ void hwss_execute_sequence(struct dc *dc,
 			break;
 		case PROGRAM_CURSOR_UPDATE_NOW:
 			dc->hwss.program_cursor_offload_now(
-				params->program_cursor_update_now_params.dc,
-				params->program_cursor_update_now_params.pipe_ctx);
+				params->program_cursor_update_now_params.dmub_srv,
+				params->program_cursor_update_now_params.otg_inst);
 			break;
 		case HUBP_WAIT_PIPE_READ_START:
 			params->hubp_wait_pipe_read_start_params.hubp->funcs->hubp_wait_pipe_read_start(
@@ -6439,6 +6436,21 @@ void hwss_add_abort_cursor_offload_update(struct block_sequence_state *seq_state
 	}
 }
 
+void hwss_add_program_cursor_update_now(struct block_sequence_state *seq_state,
+		struct dc_dmub_srv *dmub_srv,
+		uint32_t otg_inst)
+{
+	struct program_cursor_update_now_params *p;
+
+	if (*seq_state->num_steps < MAX_HWSS_BLOCK_SEQUENCE_SIZE) {
+		seq_state->steps[*seq_state->num_steps].func = PROGRAM_CURSOR_UPDATE_NOW;
+		p = &seq_state->steps[*seq_state->num_steps].params.program_cursor_update_now_params;
+		p->dmub_srv = dmub_srv;
+		p->otg_inst = otg_inst;
+		(*seq_state->num_steps)++;
+	}
+}
+
 void hwss_add_stream_enc_update_hdmi_info_packets(struct block_sequence_state *seq_state,
 		struct pipe_ctx *pipe_ctx)
 {
diff --git a/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c b/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
index 323e8bec23dc..220e3fc34f3f 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
+++ b/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
@@ -1328,15 +1328,12 @@ void dc_dmub_srv_control_cursor_offload(struct dc *dc, struct dc_state *context,
 				     enable ? DM_DMUB_WAIT_TYPE_NO_WAIT : DM_DMUB_WAIT_TYPE_WAIT);
 }
 
-void dc_dmub_srv_program_cursor_now(struct dc *dc, const struct pipe_ctx *pipe)
+void dc_dmub_srv_program_cursor_now(struct dc_dmub_srv *dc_dmub_srv, uint32_t otg_inst)
 {
 	struct dmub_rb_cmd_cursor_offload_stream_cntl *cntl;
 	union dmub_rb_cmd cmd;
 
-	if (!dc_dmub_srv_is_cursor_offload_enabled(dc))
-		return;
-
-	if (!pipe || !pipe->stream || !pipe->stream_res.tg)
+	if (!dc_dmub_srv || !dc_dmub_srv->cursor_offload_enabled)
 		return;
 
 	memset(&cmd, 0, sizeof(cmd));
@@ -1345,9 +1342,9 @@ void dc_dmub_srv_program_cursor_now(struct dc *dc, const struct pipe_ctx *pipe)
 	cntl->header.type = DMUB_CMD__CURSOR_OFFLOAD;
 	cntl->header.sub_type = DMUB_CMD__CURSOR_OFFLOAD_STREAM_PROGRAM;
 	cntl->header.payload_bytes = sizeof(cntl->data);
-	cntl->data.otg_inst = pipe->stream_res.tg->inst;
+	cntl->data.otg_inst = otg_inst;
 
-	dc_wake_and_execute_dmub_cmd(dc->ctx, &cmd, DM_DMUB_WAIT_TYPE_NO_WAIT);
+	dc_wake_and_execute_dmub_cmd(dc_dmub_srv->ctx, &cmd, DM_DMUB_WAIT_TYPE_NO_WAIT);
 }
 
 bool dc_dmub_srv_is_hw_pwr_up(struct dc_dmub_srv *dc_dmub_srv, bool wait)
diff --git a/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.h b/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.h
index b3d6279cbc15..6c1e1b8f6d9b 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.h
@@ -397,12 +397,12 @@ void dc_dmub_srv_control_cursor_offload(struct dc *dc, struct dc_state *context,
 					const struct dc_stream_state *stream, bool enable);
 
 /**
- * dc_dmub_srv_program_cursor_now() - Requests immediate cursor programming for a given pipe.
+ * dc_dmub_srv_program_cursor_now() - Requests immediate cursor programming for a given OTG.
  *
- * @dc: pointer to DC object
- * @pipe: top-most pipe for a stream.
+ * @dc_dmub_srv: DMUB service handle
+ * @otg_inst: OTG instance of the stream
  */
-void dc_dmub_srv_program_cursor_now(struct dc *dc, const struct pipe_ctx *pipe);
+void dc_dmub_srv_program_cursor_now(struct dc_dmub_srv *dc_dmub_srv, uint32_t otg_inst);
 
 /**
  * dc_dmub_srv_is_cursor_offload_enabled() - Checks if cursor offload is supported.
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.c
index aa047b5b4939..564ffd61f391 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.c
@@ -1806,9 +1806,9 @@ void dcn35_notify_cursor_offload_drr_update(struct dc *dc, struct dc_state *cont
 	dc_dmub_srv_control_cursor_offload(dc, context, stream, true);
 }
 
-void dcn35_program_cursor_offload_now(struct dc *dc, const struct pipe_ctx *pipe)
+void dcn35_program_cursor_offload_now(struct dc_dmub_srv *dc_dmub_srv, uint32_t otg_inst)
 {
-	dc_dmub_srv_program_cursor_now(dc, pipe);
+	dc_dmub_srv_program_cursor_now(dc_dmub_srv, otg_inst);
 }
 
 static void disable_link_output_symclk_on_tx_off(struct dc_link *link, enum dp_link_encoding link_encoding)
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.h b/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.h
index 0ae2f44cfb9f..2bc210d5fcc4 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.h
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.h
@@ -117,7 +117,7 @@ void dcn35_update_cursor_offload_pipe(struct dmub_srv *dmub, uint32_t stream_idx
 		uint8_t pipe_idx, const struct dpp *dpp, const struct hubp *hubp);
 void dcn35_notify_cursor_offload_drr_update(struct dc *dc, struct dc_state *context,
 					    const struct dc_stream_state *stream);
-void dcn35_program_cursor_offload_now(struct dc *dc, const struct pipe_ctx *pipe);
+void dcn35_program_cursor_offload_now(struct dc_dmub_srv *dc_dmub_srv, uint32_t otg_inst);
 void dcn35_disable_link_output(struct dc_link *link,
 		const struct link_resource *link_res,
 		enum signal_type signal);
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/hw_sequencer.h b/drivers/gpu/drm/amd/display/dc/hwss/hw_sequencer.h
index 6e009ba37ff9..4769c71f05fb 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/hw_sequencer.h
+++ b/drivers/gpu/drm/amd/display/dc/hwss/hw_sequencer.h
@@ -597,8 +597,8 @@ struct control_cm_hist_params {
 };
 
 struct program_cursor_update_now_params {
-	struct dc *dc;
-	struct pipe_ctx *pipe_ctx;
+	struct dc_dmub_srv *dmub_srv;
+	uint32_t otg_inst;
 };
 
 struct hubp_wait_pipe_read_start_params {
@@ -2050,7 +2050,7 @@ struct hw_sequencer_funcs {
 			const struct hubp *hubp);
 	void (*notify_cursor_offload_drr_update)(struct dc *dc, struct dc_state *context,
 						 const struct dc_stream_state *stream);
-	void (*program_cursor_offload_now)(struct dc *dc, const struct pipe_ctx *pipe);
+	void (*program_cursor_offload_now)(struct dc_dmub_srv *dc_dmub_srv, uint32_t otg_inst);
 
 	/* Colour Related */
 	void (*program_gamut_remap)(struct program_gamut_remap_params *params);
@@ -3226,6 +3226,10 @@ void hwss_add_commit_cursor_offload_update(struct block_sequence_state *seq_stat
 		struct dc *dc,
 		struct pipe_ctx *pipe_ctx);
 
+void hwss_add_program_cursor_update_now(struct block_sequence_state *seq_state,
+		struct dc_dmub_srv *dmub_srv,
+		uint32_t otg_inst);
+
 void hwss_add_stream_enc_update_hdmi_info_packets(struct block_sequence_state *seq_state,
 		struct pipe_ctx *pipe_ctx);
 
-- 
2.43.0

