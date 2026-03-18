Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A295AFEDA09
	for <amd-gfx@archiver.kernel.org>; Wed, 18 Mar 2026 01:02:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3686D10E655;
	Wed, 18 Mar 2026 01:02:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="o5a26ebP";
	dkim-atps=neutral
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012040.outbound.protection.outlook.com [40.107.209.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7A22F10E655
 for <amd-gfx@lists.freedesktop.org>; Wed, 18 Mar 2026 01:02:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Suu8Cgg8O8i6qHZHcXFPVX5jDGjowLEwGSgqmXkOGMS2065VNYrLTWdAS4PL6BFT1cXIbOmvpo3cln7APt4MRWDNsyHn0IQA/X5PJEKwYUdwGav9R5GlLN1B7jqk/QOd832s+rPAuBHqV4zVgevip4NP+OuzhClGPM1wkxdShkHiEXIVpv+/DotVODy80RlJCt4Jwe+KxYMloE8WklB8U5IWbI/DggwmwQ0O5c5JeTTyPvp/TVzdEg4gum/Ax9ZYIKtUN3I/TlmZl452jAGJehadeZ3lav/6+HNi2pprsBkZdvaFJXvCkO9TiwoIfxS27WayUX/oBJ2oAKwXEVxf/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4N4oaPrO8nTsewzzuhkqGtCFzZ30gT7WtcPMRTZd+IM=;
 b=kxvTacKDAcB1WKejxqaRXfvGpoWvDkv6uhxZloubp7TzH2hMoGMaRA4ui5+zNLwJIsIee9/fMEoapzrMiHlAdVvTJFPp44+adXQ+C+G2F7ySk4VDTrOa8ScZXv16WmpvMyjlEpgEWpq0qfE1rToxLQg4ts3/JVPRAAZB7wKlKg4hk4DiVqNGLU5GAKVLiDCWKlChggEO0+Mi56NhJFydZCzA60dFcoAYtjSTsV5zPPhUymTtjh9hTOmS3BQNUXAAIMQ5KlvK/Wi2L/WR7qQO4D6i4TB3xLBpesm7T28U3R495jL7CR3BcWIAlO4gKJ6usmeYPWZpe77b3SseaqMdyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4N4oaPrO8nTsewzzuhkqGtCFzZ30gT7WtcPMRTZd+IM=;
 b=o5a26ebPDoN2gis+eCQOlo/GCrDQK2OOPMd5mvq9ezmTTM7J6fI2/6SeJP5Fq3vzETqmvvbXJ9Os9bUDxogktFOHbWdcsv70xjZmnn4dmBGLPUynctDkfAkCDgM11/JkGET8sg/jXuML5csQlc0+IMe7zgowRBaV6EXQx2B0+cc=
Received: from PH8P222CA0007.NAMP222.PROD.OUTLOOK.COM (2603:10b6:510:2d7::29)
 by CH1PR12MB9647.namprd12.prod.outlook.com (2603:10b6:610:2b0::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.19; Wed, 18 Mar
 2026 01:02:19 +0000
Received: from SN1PEPF000397B5.namprd05.prod.outlook.com
 (2603:10b6:510:2d7:cafe::49) by PH8P222CA0007.outlook.office365.com
 (2603:10b6:510:2d7::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9700.24 via Frontend Transport; Wed,
 18 Mar 2026 01:02:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF000397B5.mail.protection.outlook.com (10.167.248.59) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9700.17 via Frontend Transport; Wed, 18 Mar 2026 01:02:19 +0000
Received: from maxMSI.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 17 Mar
 2026 20:02:15 -0500
From: ChuanYu Tseng <ChuanYu.Tseng@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>,
 Charlene Liu <charlene.liu@amd.com>, Chuanyu Tseng <chuanyu.tseng@amd.com>
Subject: [PATCH 21/31] drm/amd/display: Revert inbox0 lock for cursor due to
 deadlock
Date: Wed, 18 Mar 2026 08:59:30 +0800
Message-ID: <20260318010224.513094-22-ChuanYu.Tseng@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260318010224.513094-1-ChuanYu.Tseng@amd.com>
References: <20260318010224.513094-1-ChuanYu.Tseng@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000397B5:EE_|CH1PR12MB9647:EE_
X-MS-Office365-Filtering-Correlation-Id: 413d0e3d-d402-4f6b-c65e-08de848a0156
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700016|376014|82310400026|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info: jGiTPYm1rR2lX5GBfJ33qWltGt0fI2au4eaDVUs+KQv8dJJeEpVkC+IU11i3wuAt5PfABPFslWYvz9SxFzHjBOIJKge7PRhMaiP39SMN+2yRd/C039qA5MhN/YGBnNgPG016iAAxnKnDuJG0JDaH20d2NEY5DJKBNHeeS5WUVIcQ3UYEZNGDpUzMYkzdkEWxa1AKK7Ln1lWRYnUPAxYJbldlJPSQ6WIwqRMixq6ADDOwxuIDdWYqiEduqY/d0XPZirGGe0JTLPtOUUmy8fm3rWGRpFeySSamg4JqfId5Qqgg/CvdAF04vY8UjkZnNiK4JO/IRRt+sKH86rXMmt+c4B6BNY0YN81SvBT+kgnz2mxVGrXCY8Gp8AP/Wy/4a4+qQCL9888ztUadjBzblwL7N4keNqml9q7oEzl6LvPiP7MENcvuhaS7oY1RBZyD8coDSBFHYNjlRjwOgsCqdtFB5sVHkYO6mG8jOvjzUzfv7GZ28zg+hME/nv5DxJIqQ7+3vKrQGNJYV/YY5vk1J6QFbvDgI5cj1yWlz8OnvpckBaTVX768nxV05PIbqMcZh5pJQ9yYGEaPVXhZv9roitzQj+x3Wh5cB9sBLOw/y1Z3nV+baBsT5k+nnCV1IeUDT8RojZG25eKCUbu6iti0AlxtQ2G/bywkApUbgnIKhjDsPIBXd7GCZdkhCA0Wh8vYnaE8sLv0zOAxU6saYpBKmJMQn89Uc3pm4iiJyA9Zwh/+EdR6Oyipdb/8JQ74BtuADLIAoyWAohAXzyCc8gZhqPjj+w==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700016)(376014)(82310400026)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: PcKkQoW8XskO240zXU7Rcm46XZz9BId/RFwQW+Z9RjKDhVlNTu7J03UelQRnAHwBop0xycSjxpN1AwPASTveNohpOst4GienffweacekAjQD3zN0iTZrPTNGpjPypx8izVvs4RHlYjSnlSFzXN0qBoAAkkhIseS748/a+CuK1QmkdPk/sndP5bf76PBxhpdHD9LrG0DB6YRXjRISwoOR6mOVqpoR0zQRg9dHQezv0FHZC8LATsX0ZzmV4B205dTwlDAP27FEYz+dr/7KKz6lomU/lx2zia8dOumL4q6xBhG6J475ovaA6HQatkRu9/QICbZvqd7Vwn6OjVATCf2jr/fqCUs1caB0cKN1yuAHFay6k1d5KbCyk6/4SOLvKw67UmE65qeey7RYlAEV61HcMxzg0wFHzKWKNJMHe+AYa72dONSUFePfBZR/z7tQRS17
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2026 01:02:19.5666 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 413d0e3d-d402-4f6b-c65e-08de848a0156
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF000397B5.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PR12MB9647
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
A deadlock occurs when using inbox0 lock for cursor operations on
PSR-SU and Replays that does not when using the inbox1 locking path.

This is because of a priority inversion issue where inbox1 work
cannot be serviced while holding the HW lock from driver and sending
cursor notifications to DMUB.

Typically the lower priority of inbox1 for the lock command would
allow the PSR and Replay FSMs to complete their transition prior
to giving driver the lock but this is no longer the case with inbox0
having the highest priority in servicing.

[How]
This will reintroduce any synchronization bugs that were there
with Replay or PSR-SU touching the cursor at the same time as driver.

Reviewed-by: Charlene Liu <charlene.liu@amd.com>
Signed-off-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Signed-off-by: Chuanyu Tseng <chuanyu.tseng@amd.com>
---
 .../gpu/drm/amd/display/dc/core/dc_stream.c   | 30 +++----------------
 1 file changed, 4 insertions(+), 26 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_stream.c b/drivers/gpu/drm/amd/display/dc/core/dc_stream.c
index 44e17329c637..87ecef6e699f 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_stream.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_stream.c
@@ -33,7 +33,6 @@
 #include "dc_dmub_srv.h"
 #include "dc_state_priv.h"
 #include "dc_stream_priv.h"
-#include "dce/dmub_hw_lock_mgr.h"
 
 #define DC_LOGGER dc->ctx->logger
 #ifndef MIN
@@ -259,7 +258,6 @@ void program_cursor_attributes(
 	struct resource_context *res_ctx;
 	struct pipe_ctx *pipe_to_program = NULL;
 	bool enable_cursor_offload = dc_dmub_srv_is_cursor_offload_enabled(dc);
-	bool unlock_dmub = false;
 
 	if (!stream)
 		return;
@@ -278,12 +276,6 @@ void program_cursor_attributes(
 			if (enable_cursor_offload && dc->hwss.begin_cursor_offload_update) {
 				dc->hwss.begin_cursor_offload_update(dc, pipe_ctx);
 			} else {
-				if (dc->hwss.dmub_hw_control_lock && pipe_ctx->stream &&
-				    should_use_dmub_inbox0_lock_for_link(dc, pipe_ctx->stream->link)) {
-					dc->hwss.dmub_hw_control_lock(dc, dc->current_state, true);
-					unlock_dmub = true;
-				}
-
 				dc->hwss.cursor_lock(dc, pipe_to_program, true);
 				if (pipe_to_program->next_odm_pipe)
 					dc->hwss.cursor_lock(dc, pipe_to_program->next_odm_pipe, true);
@@ -306,9 +298,6 @@ void program_cursor_attributes(
 			dc->hwss.cursor_lock(dc, pipe_to_program, false);
 			if (pipe_to_program->next_odm_pipe)
 				dc->hwss.cursor_lock(dc, pipe_to_program->next_odm_pipe, false);
-
-			if (unlock_dmub)
-				dc->hwss.dmub_hw_control_lock(dc, dc->current_state, false);
 		}
 	}
 }
@@ -416,7 +405,6 @@ void program_cursor_position(
 	struct resource_context *res_ctx;
 	struct pipe_ctx *pipe_to_program = NULL;
 	bool enable_cursor_offload = dc_dmub_srv_is_cursor_offload_enabled(dc);
-	bool unlock_dmub = false;
 
 	if (!stream)
 		return;
@@ -436,16 +424,10 @@ void program_cursor_position(
 		if (!pipe_to_program) {
 			pipe_to_program = pipe_ctx;
 
-			if (enable_cursor_offload && dc->hwss.begin_cursor_offload_update) {
+			if (enable_cursor_offload && dc->hwss.begin_cursor_offload_update)
 				dc->hwss.begin_cursor_offload_update(dc, pipe_ctx);
-			} else {
-				if (dc->hwss.dmub_hw_control_lock && pipe_ctx->stream &&
-				    should_use_dmub_inbox0_lock_for_link(dc, pipe_ctx->stream->link)) {
-					dc->hwss.dmub_hw_control_lock(dc, dc->current_state, true);
-					unlock_dmub = true;
-				}
+			else
 				dc->hwss.cursor_lock(dc, pipe_to_program, true);
-			}
 		}
 
 		dc->hwss.set_cursor_position(pipe_ctx);
@@ -457,14 +439,10 @@ void program_cursor_position(
 	}
 
 	if (pipe_to_program) {
-		if (enable_cursor_offload && dc->hwss.commit_cursor_offload_update) {
+		if (enable_cursor_offload && dc->hwss.commit_cursor_offload_update)
 			dc->hwss.commit_cursor_offload_update(dc, pipe_to_program);
-		} else {
+		else
 			dc->hwss.cursor_lock(dc, pipe_to_program, false);
-
-			if (unlock_dmub)
-				dc->hwss.dmub_hw_control_lock(dc, dc->current_state, false);
-		}
 	}
 }
 
-- 
2.43.0

