Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5CC04C982D0
	for <amd-gfx@archiver.kernel.org>; Wed, 16 Sep 2026 17:53:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5A27910ECD0;
	Wed, 16 Sep 2026 17:53:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="DijxfcDn";
	dkim-atps=neutral
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011007.outbound.protection.outlook.com
 [40.93.194.7])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 57C9410ECC3
 for <amd-gfx@lists.freedesktop.org>; Wed, 16 Sep 2026 17:53:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hE/J5TIC+Nva31apho8J4q1LlBLvVLo8nLts9AXy6ntkL2DkdUU5qPfedqx5Ypspu8oFSLZNNkPaXvb+fNTwG++/4RvzE71RwMNmTDlApZsdxXIXvmFr3czOWkmv8CeNOB7nAHiwni71OnqZ9OZJX4W3MvatNCZVenWhMeYSmB5LXB3H8CBhhCEMixdwZ7Xo5e0+fE6eYPoymRu1MhNEUhQkc5OJV+ennOAICspqu+hgPxp+GrWSlot4fWVZILL90Sb3fGVsfaCOF+3M/xyJBO2fS7aCoMQh0xjTTH+ZpCHy+j1SswxmS9QzBd9e6V9pgMQAGvi17CxQdg/flIUnhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Iza/8sfxm5TXcOd/iLHc994APwqi03sijlDxd32E2CU=;
 b=lSHZrV8yazNELXwIIlbLknIzSC4aB1ZK+dk/LfRIqlK7rfBJvrQ+RQ3nPSzejdv+nL7dTHfzKH4Z1achMsFynFWXCOKXBpzZolf6psmGDQGGGN6uQmh8cGJE3oD29zLpGG/j/V9BoL3duVWo2f5a+rscYZRUo/Su/ANYtknPRmgRtOX+t70gAoqn7ufYjy+YD/7PYlhklsbXxXQ42Ae3tPXel7qsQM7SjI/QT8p3iIjAz+fBbDHQvzj++vqwQkS0JH2ZAy8ShI3sfXsCx56DQFG+Rj2zlX9DOL+4HXftO2/JnuqBzQ+C+dLjVlmec2ADWVNEJJpL56cl1SZdGZlriw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Iza/8sfxm5TXcOd/iLHc994APwqi03sijlDxd32E2CU=;
 b=DijxfcDnGZAe8G8bJFMfOfatEantB4gsyF7svPFjwOAwcy8uwyG7FXKlD17OsYTmuOwhGTL7+G0EOzVvh3fy+W5j1pjANkS085lbeaMBIapU0lonc7GORszL/aXoJBLwp6A+kedCivqINkYww66w/1v8wa59h6dK/zei6/2YfFA=
Received: from CH5P220CA0019.NAMP220.PROD.OUTLOOK.COM (2603:10b6:610:1ef::17)
 by DS7PR12MB8232.namprd12.prod.outlook.com (2603:10b6:8:e3::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.9; Wed, 16 Sep
 2026 17:52:59 +0000
Received: from CH3PEPF0000000D.namprd04.prod.outlook.com
 (2603:10b6:610:1ef:cafe::57) by CH5P220CA0019.outlook.office365.com
 (2603:10b6:610:1ef::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.428.11 via Frontend Transport; Wed,
 16 Sep 2026 17:52:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH3PEPF0000000D.mail.protection.outlook.com (10.167.244.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.428.7 via Frontend Transport; Wed, 16 Sep 2026 17:52:56 +0000
Received: from georzhanmkm.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Wed, 16 Sep
 2026 12:52:44 -0500
From: George Zhang <george.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>,
 George Zhang <george.zhang@amd.com>, Zhikai Zhai <zhikai.zhai@amd.com>
Subject: [PATCH 40/64] drm/amd/display: Fix missing gaps for link lock with
 inbox0
Date: Wed, 16 Sep 2026 13:51:55 -0400
Message-ID: <20260916175301.368306-41-george.zhang@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260916175301.368306-1-george.zhang@amd.com>
References: <20260916175301.368306-1-george.zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF0000000D:EE_|DS7PR12MB8232:EE_
X-MS-Office365-Filtering-Correlation-Id: 213d854c-76f4-4f59-2e04-08df141b5736
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|36860700016|23010399003|22082099003|18002099003|10067099003|56012099006|5023799004|11063799006;
X-Microsoft-Antispam-Message-Info: u6MdQZAdrwyx8zR/evZcbUcc3tfF0dL6OgjDSbMWOF1Yyp1ZNYaiSvQZEETMOPNAw4tA7iYQvHYn43Y7BUNJpO3aBiz4BP0KhzO2/3Xq5pJQEQzcB8haWzjTSzn1qfREmdbHvEs2ubBfa4B9V87R+RxS8kFUS44dMipL98s7xGTb2xci1IeDvvl5CDC2hCsBmKm7AN3KsOk8umApngzIKo05xpGVP0XVGhwsFgJD7Fr8IbxSx/fdbXUMqqruSWad3QhoUVyhm+XtMSN3SyI3VvykpRl2CoWtrPt3bHkk5thKNPaePitTU9Hv44k5o9nJIWECCoDe3TViuhfJBCIaYfsnMafrS5lRWemLzf8ysHgaJBxxiQ7fICxBjo5nRFoO+HfOzr/4POR9DxoCb1wSMMgdP8nh0IxNhxj/eWJBmm/VgxD4eeEd7nP1DieqjgVY3Maq2q2UkkVmPpmyvUHOnWgxwT62jAruBdTm2v3ehrsYAx7rr8DO4RCmyrENzM7P7W+XLW968U8gWfce8c8YGZtYZc3ayeh/8iAvyXptSaXjVTQppX+8EmNcfSopwz8wi9sCD7tW/ZAZe4GtybR3L2VKCFTeKCqCTHpDTZUzw9hxkDoeHqcA/GANq3Dsrbrcv9n61u1p4hYmMqGKp5sk1rz6vfjrmkdudEqvVdmDYTdu0knAYeysaXKHLx3mILRHmD3rVgumyn3aZ4pNeWY6Jw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(1800799024)(36860700016)(23010399003)(22082099003)(18002099003)(10067099003)(56012099006)(5023799004)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: jRWL4iQOugi6PIQS0zUE4GEeCaae4Y0Bcaf7vVlqnQ3W/XXQnJwp3HSJs/cocQqbY8TvhlXQFArERpTkNgBohbTyv9F+cn1xLQgSNBocvVUQ9ng0qlApGt9f+4tldJNIsIuks26H2/FfycTiGGet1Jw2NzxBXmy9Lp1yzvXpaYYf3zsztCv6EaweCGBLpjQIxaER35nH9cFsyySoYP4mlFVSwMvLFxYfae8Q+F/U9yGgt0694HvJpyNAecyAl3ccY4MT1u4dX4UQ0naI10S6Gov/YtVUb2t+e9c95P2jfS6UbfcTr19Q7W6Rsz5KzBpHlLDMXE5rQoP7dxy1L5Lz0r7J3n3eLq4d8tp6nSjDZj2W5UBfy5HNY1v0PQAqiNDSByuXlQyHQurS+gfqMIqKIW/1cBZ0lnO9qnG6ie5HhGSOq2WSR8qA3a2HvN3kD/nR
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2026 17:52:56.9191 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 213d854c-76f4-4f59-2e04-08df141b5736
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF0000000D.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8232
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
Inbox1 was previously being used for cursor and DIG locking with
DMUB doing the relevant programming on behalf of driver.

With the Inbox0 lock the driver is expected to do the programming
itself and the Inbox0 lock acts as nothing more than a SW mutex.

There are still a few gaps in how Inbox1 was being leveraged in the
cursor path that need to be addressed for Inbox0.

[How]
Add a `should_use_dmub_inbox0_lock_for_link` helper to help
check if we support the Inbox0 locking infrastructure and we should
be locking it if the specific link in question requires it.

Reviewed-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Reviewend-by: George Zhang <george.zhang@amd.com>
Signed-off-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Signed-off-by: Zhikai Zhai <zhikai.zhai@amd.com>
---
 .../gpu/drm/amd/display/dc/core/dc_stream.c   | 21 +++++++++++++++++++
 .../drm/amd/display/dc/dce/dmub_hw_lock_mgr.c | 10 ++++++++-
 .../gpu/drm/amd/display/dmub/inc/dmub_cmd.h   |  3 ++-
 3 files changed, 32 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_stream.c b/drivers/gpu/drm/amd/display/dc/core/dc_stream.c
index 8d3aacc7b96c..88ac4a4cfd6e 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_stream.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_stream.c
@@ -34,6 +34,7 @@
 #include "dc_dmub_srv.h"
 #include "dc_state_priv.h"
 #include "dc_stream_priv.h"
+#include "dce/dmub_hw_lock_mgr.h"

 #define DC_LOGGER dc->ctx->logger
 #ifndef MIN
@@ -307,6 +308,7 @@ void program_cursor_attributes(
 	struct resource_context *res_ctx;
 	struct pipe_ctx *pipe_to_program = NULL;
 	bool enable_cursor_offload = dc_dmub_srv_is_cursor_offload_enabled(dc);
+	bool unlock_dmub = false;

 	if (!stream)
 		return;
@@ -330,6 +332,12 @@ void program_cursor_attributes(
 						pipe_ctx->plane_res.dpp, pipe_ctx->plane_res.hubp,
 						top_pipe->pipe_idx);
 			} else {
+				if (dc->hwss.dmub_hw_control_lock && pipe_ctx->stream &&
+				    should_use_dmub_inbox0_lock_for_link(dc, pipe_ctx->stream->link)) {
+					dc->hwss.dmub_hw_control_lock(dc, dc->current_state, true);
+					unlock_dmub = true;
+				}
+
 				dc->hwss.cursor_lock(dc, pipe_to_program, true);
 				if (pipe_to_program->next_odm_pipe)
 					dc->hwss.cursor_lock(dc, pipe_to_program->next_odm_pipe, true);
@@ -362,6 +370,9 @@ void program_cursor_attributes(
 			dc->hwss.cursor_lock(dc, pipe_to_program, false);
 			if (pipe_to_program->next_odm_pipe)
 				dc->hwss.cursor_lock(dc, pipe_to_program->next_odm_pipe, false);
+
+			if (unlock_dmub)
+				dc->hwss.dmub_hw_control_lock(dc, dc->current_state, false);
 		}
 	}
 }
@@ -481,6 +492,7 @@ void program_cursor_position(
 	struct resource_context *res_ctx;
 	struct pipe_ctx *pipe_to_program = NULL;
 	bool enable_cursor_offload = dc_dmub_srv_is_cursor_offload_enabled(dc);
+	bool unlock_dmub = false;

 	if (!stream)
 		return;
@@ -508,6 +520,12 @@ void program_cursor_position(
 						pipe_ctx->plane_res.dpp, pipe_ctx->plane_res.hubp,
 						top_pipe->pipe_idx);
 			} else {
+				if (dc->hwss.dmub_hw_control_lock && pipe_ctx->stream &&
+				    should_use_dmub_inbox0_lock_for_link(dc, pipe_ctx->stream->link)) {
+					dc->hwss.dmub_hw_control_lock(dc, dc->current_state, true);
+					unlock_dmub = true;
+				}
+
 				dc->hwss.cursor_lock(dc, pipe_to_program, true);
 			}
 		}
@@ -535,6 +553,9 @@ void program_cursor_position(
 					top_pipe->pipe_idx);
 		} else {
 			dc->hwss.cursor_lock(dc, pipe_to_program, false);
+
+			if (unlock_dmub)
+				dc->hwss.dmub_hw_control_lock(dc, dc->current_state, false);
 		}
 	}
 }
diff --git a/drivers/gpu/drm/amd/display/dc/dce/dmub_hw_lock_mgr.c b/drivers/gpu/drm/amd/display/dc/dce/dmub_hw_lock_mgr.c
index 52673e2f504c..2ac1485a3438 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dmub_hw_lock_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/dce/dmub_hw_lock_mgr.c
@@ -36,6 +36,14 @@ static bool dmub_hw_lock_has_inbox0_lock(const struct dc *dc)
 	       dc->ctx->dmub_srv->dmub->meta_info.feature_bits.bits.inbox0_lock_support;
 }

+static bool dmub_hw_lock_has_inbox0_lock_split(const struct dc *dc)
+{
+	return dc->ctx && dc->ctx->dmub_srv &&
+		dc->hwss.dmub_hw_control_lock &&
+		dc->hwss.dmub_hw_control_lock_fast &&
+		dc->ctx->dmub_srv->dmub->meta_info.feature_bits.bits.inbox0_lock_split;
+}
+
 void dmub_hw_lock_mgr_cmd(struct dc_dmub_srv *dmub_srv,
 				bool lock,
 				union dmub_hw_lock_flags *hw_locks,
@@ -121,5 +129,5 @@ bool should_use_dmub_inbox1_lock(const struct dc *dc, const struct dc_link *link

 bool should_use_dmub_inbox0_lock_for_link(const struct dc *dc, const struct dc_link *link)
 {
-	return dmub_hw_lock_has_inbox0_lock(dc) && dmub_hw_lock_mgr_does_link_require_lock(dc, link);
+	return dmub_hw_lock_has_inbox0_lock_split(dc) && dmub_hw_lock_mgr_does_link_require_lock(dc, link);
 }
diff --git a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
index ef576640de5b..af621b8552e1 100644
--- a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
+++ b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
@@ -1004,7 +1004,8 @@ union dmub_fw_meta_feature_bits {
 		uint32_t shared_state_link_detection : 1; /**< 1 supports link detection via shared state */
 		uint32_t cursor_offload_v1_support: 1; /**< 1 supports cursor offload */
 		uint32_t inbox0_lock_support: 1; /**< 1 supports inbox0 lock mechanism */
-		uint32_t reserved : 29;
+		uint32_t inbox0_lock_split: 1; /**< 1 supports inbox0 lock acquire/release split mechanism */
+		uint32_t reserved : 28;
 	} bits; /**< status bits */
 	uint32_t all; /**< 32-bit access to status bits */
 };
--
2.55.0

