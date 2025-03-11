Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC328C282EC
	for <amd-gfx@archiver.kernel.org>; Tue, 11 Mar 2025 21:50:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7DC5710E32E;
	Tue, 11 Mar 2025 21:50:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="hskqdsDA";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2041.outbound.protection.outlook.com [40.107.244.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B28F810E32E
 for <amd-gfx@lists.freedesktop.org>; Tue, 11 Mar 2025 21:50:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mwWncGH3JNlF6emRyprNrsskHRQVG9MQxypI9VxV/DySPQfFYcgYaqrTYJxFIRUexnCXYkaYUrCw8ODmG/kh98beLK6W19x0H3RLeb4XxbdaLieWBGD89HGpBVhvSkuYqvli0vGv3qAv6tVQ2Uf/Cg8jkzBAvtvhxEKtQk655W5ZCELPhM5XiaGmTMbXJLHPtLDKanRzCvmmljIprG53vvfPcabQDDZNVHvnQ7A48NoiLZY0gAz5AJgc0ePsgVBqhR9h6mtN/gRtgPTr/Qt3oumwvRo1gdLTF32uffm08bY/NWOLro6cwtyRs9z6MxgJJMyqhEcoJVZmKUvY0pmJ5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VbD7Ad/vAZDnBtW1t34EggAE89BPn4ORQcYRrFysLsA=;
 b=fz06uH95IU303z+t34Re203KWxW/AHuUwzkKt5qlqHSUq26O44pqLtIAcTsvXPr0NndAe59ZhOfhtZVpj6R9AdNrXICRQqCEFv+anyU+xUR2r09RhnF+B7025hDOnIoR8SMT9v5PiAQtMHZLxFqbrv/OvaMhlLBgc2NLEfQFmZCxCzTYEGqhds6Jk8hh9btTY8wWtF3/8qnS901kBiOeIZ716stKDx5QiKd4z89kzwTEZD5/QeK0Uudf0dBKcYiQg5cfF3X/qjXS1u+CeDF9lywj43brF6hRAlFR7/HtCX1L+YIw765JYVqfuNB+PNZejV0Q7DrUL6BZKfoFSIas3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VbD7Ad/vAZDnBtW1t34EggAE89BPn4ORQcYRrFysLsA=;
 b=hskqdsDA4tQznEln2VJUc+5XzcznS7zX8kN9EMkYoB53JVArzlGJRy52wGWApYiAh/qiQsdKK3sk2PHBLdMHUMLDQVz2nM7GruiJwFJOXYQL0mzl8eP2mkB7pVeW8Mx25oxnq9tn26UZybJUncHUUuvP5i6ICrmqpaqvUUhKyeI=
Received: from MN2PR05CA0049.namprd05.prod.outlook.com (2603:10b6:208:236::18)
 by DS7PR12MB8201.namprd12.prod.outlook.com (2603:10b6:8:ef::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Tue, 11 Mar
 2025 21:50:15 +0000
Received: from BN1PEPF00005FFF.namprd05.prod.outlook.com
 (2603:10b6:208:236:cafe::c9) by MN2PR05CA0049.outlook.office365.com
 (2603:10b6:208:236::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.21 via Frontend Transport; Tue,
 11 Mar 2025 21:50:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN1PEPF00005FFF.mail.protection.outlook.com (10.167.243.231) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8534.20 via Frontend Transport; Tue, 11 Mar 2025 21:50:14 +0000
Received: from smtp.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 11 Mar
 2025 16:50:12 -0500
From: Alex Hung <alex.hung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Zaeem Mohamed <zaeem.mohamed@amd.com>, Solomon Chiu
 <solomon.chiu@amd.com>, Daniel Wheeler <daniel.wheeler@amd.com>, Alex Hung
 <alex.hung@amd.com>, Dillon Varone <dillon.varone@amd.com>, Aric Cyr
 <aric.cyr@amd.com>
Subject: [PATCH 06/11] drm/amd/display: Revert "Support for reg inbox0 for
 host->DMUB CMDs"
Date: Tue, 11 Mar 2025 15:42:07 -0600
Message-ID: <20250311214618.3106637-7-alex.hung@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250311214618.3106637-1-alex.hung@amd.com>
References: <20250311214618.3106637-1-alex.hung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00005FFF:EE_|DS7PR12MB8201:EE_
X-MS-Office365-Filtering-Correlation-Id: 74556c27-2ab6-4ed0-7499-08dd60e6b4cf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?tpkUNbyXWvhjvhfvCOE6jX4K5waBsJQPtnyvg84c+cdyGkGUWsHKMDC6mfV/?=
 =?us-ascii?Q?6i/+enAb9ySeaVkta0xJ3iV2zgAA+D1qPAfSbQbYMjd8SyJiBKZlgMpGDLxY?=
 =?us-ascii?Q?g2OJrn/nKlLpQ3wwurAPuOxl8uKJ+0UwKAMhGjS+S4LJ218H6bJHcGNVmzJt?=
 =?us-ascii?Q?dD4IxSDO8jndNJO1hu8Oml5aJ/BZuyzYL4+NxKCj1CvHaCsAxJFB/JXHHpK/?=
 =?us-ascii?Q?tBc9Y1+WQx4i7w7OgMgdovpoFO0SUMQyezLfUe8NygmO2v1AZ357ceRwBq8v?=
 =?us-ascii?Q?i+D1kRHtLQ2jPkuPB7oQo4bNOp1eERi/G6r3i5iesCP3V8atkMK7g6oKmGPh?=
 =?us-ascii?Q?SAGAIfN+Lfw4CZHbBGO+k5J+lvT3RfQYe1xur1b9WIlBJ62oi2MnYjMxsg3N?=
 =?us-ascii?Q?2lxQo6TjDa/4GLIouNmqcos7g42NrVTkMgrUFNfxT5/72onPzyNxCMCp6Mi9?=
 =?us-ascii?Q?17lvukX4rKWklsLfS/Zn4cyXo8meeYSWZJaw0AIzYPtxpEvbNBS2MoqkGqyC?=
 =?us-ascii?Q?aYbscMoFiXErvKP8x2bTVZfYRhMkb4VppAA79/7Akg6a1GceSXwJxWlHiRNB?=
 =?us-ascii?Q?UZgrXKEoJfMzgsNiByYxPpnkAJJe6oNbI/qdFPJiraIOKHYGi8mUww2Qoekf?=
 =?us-ascii?Q?+3o440zhQppkK08czRM6fErXQmWWprPJp5OP8TLJDmsnJpb8fQx3r2ZyuzZD?=
 =?us-ascii?Q?BMcCnlw6p4mFfE65ARRgBYYHovrtBQYbOR5E5YPzqF3jfNAK1DsjPId/cWKg?=
 =?us-ascii?Q?7NokT/bc5NxJfZFl1umVsqR9ITafp9NmKsStTGLPsGeVhJfm4oeXcTm+CiwZ?=
 =?us-ascii?Q?cJz33EtmrgUP0KHsxZrsZq+xdMzqwV7vKKZ1pW4JqatXin2uCu2xlh1Wyki0?=
 =?us-ascii?Q?5blcQjt2/kH4OX8uRZr5k/wVi3AqUzMx98GL4EQzDvcOSkdpRquWSG6O+NiF?=
 =?us-ascii?Q?v6JkXA9pc2sOVU3jgxUHmYS9m1QV3WbYlsveB6sdRhwzG3kVS9FZEGREb0Bz?=
 =?us-ascii?Q?AsfTe3pGOESMmGkd3VvIlHMTzRBm4jLJqjqsPaKK8Yl+JFpL2Y8zat5+zY7Q?=
 =?us-ascii?Q?N0ZnmRFdEIFWKBtQzB3roN1ZKz3aF4p0jEVo+rkO43hefPH5etMa31KtlH5z?=
 =?us-ascii?Q?R0JfjaOVajzxA2RTdZGU3Dt95rmuNPb0+KtiBUnDk8+NwrIoCawxGoX/EjlQ?=
 =?us-ascii?Q?swG+WNMGeDovP5T/B916KyjHifZG6Wh9b/MO84BjQ4CJ2CMz8Ds22lqLKGDg?=
 =?us-ascii?Q?JyG1BMvhu9Tt2h05dbEvf1nfUihkn5fvpVwjqLGhCjfyTUAAo4BTm3v667qU?=
 =?us-ascii?Q?evDHkjE14oihuWvTR/ezUO7S1kYMPiE4nB02sQTos22J0Xjr343GE/rVce5Z?=
 =?us-ascii?Q?3b5DGSK15gWUPf66JSdE3Zg1jFhZ2Yf70f1vF5+V20ZJg/GRQBCKuLg9eexI?=
 =?us-ascii?Q?4rnfvu8Ms3BUnLyTCMXI204JKMMfpG/DMy9f7pXk/xb9Iuemt0k53G+kCOks?=
 =?us-ascii?Q?DpZX+a7Fwe6XbVQ=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2025 21:50:14.8248 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 74556c27-2ab6-4ed0-7499-08dd60e6b4cf
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00005FFF.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8201
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

From: Dillon Varone <dillon.varone@amd.com>

This reverts commit b4a8503f69c214987b30cb7d8c3399d50477adac.

Reason: Cursor movement causes system to hang.

Reviewed-by: Aric Cyr <aric.cyr@amd.com>
Signed-off-by: Dillon Varone <dillon.varone@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c  | 185 +++++------
 drivers/gpu/drm/amd/display/dc/dc_dmub_srv.h  |   2 +-
 drivers/gpu/drm/amd/display/dc/dc_helper.c    |   2 +-
 .../gpu/drm/amd/display/dc/dce/dmub_abm_lcd.c |   3 +-
 .../gpu/drm/amd/display/dc/dce/dmub_replay.c  |  19 +-
 .../display/dc/link/protocols/link_dp_dpia.c  |   1 -
 drivers/gpu/drm/amd/display/dmub/dmub_srv.h   | 132 +++-----
 .../drm/amd/display/dmub/src/dmub_dcn401.c    | 121 +++----
 .../drm/amd/display/dmub/src/dmub_dcn401.h    |   4 +-
 .../gpu/drm/amd/display/dmub/src/dmub_srv.c   | 297 ++++++------------
 10 files changed, 270 insertions(+), 496 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c b/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
index ca6da53f45ad..614e03bfd598 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
+++ b/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
@@ -70,28 +70,20 @@ void dc_dmub_srv_destroy(struct dc_dmub_srv **dmub_srv)
 	}
 }
 
-bool dc_dmub_srv_wait_for_pending(struct dc_dmub_srv *dc_dmub_srv)
+void dc_dmub_srv_wait_idle(struct dc_dmub_srv *dc_dmub_srv)
 {
-	struct dmub_srv *dmub;
-	struct dc_context *dc_ctx;
+	struct dmub_srv *dmub = dc_dmub_srv->dmub;
+	struct dc_context *dc_ctx = dc_dmub_srv->ctx;
 	enum dmub_status status;
 
-	if (!dc_dmub_srv || !dc_dmub_srv->dmub)
-		return false;
-
-	dc_ctx = dc_dmub_srv->ctx;
-	dmub = dc_dmub_srv->dmub;
-
 	do {
-		status = dmub_srv_wait_for_pending(dmub, 100000);
+		status = dmub_srv_wait_for_idle(dmub, 100000);
 	} while (dc_dmub_srv->ctx->dc->debug.disable_timeout && status != DMUB_STATUS_OK);
 
 	if (status != DMUB_STATUS_OK) {
 		DC_ERROR("Error waiting for DMUB idle: status=%d\n", status);
 		dc_dmub_srv_log_diagnostic_data(dc_dmub_srv);
 	}
-
-	return status == DMUB_STATUS_OK;
 }
 
 void dc_dmub_srv_clear_inbox0_ack(struct dc_dmub_srv *dc_dmub_srv)
@@ -134,49 +126,7 @@ void dc_dmub_srv_send_inbox0_cmd(struct dc_dmub_srv *dc_dmub_srv,
 	}
 }
 
-static bool dc_dmub_srv_reg_cmd_list_queue_execute(struct dc_dmub_srv *dc_dmub_srv,
-		unsigned int count,
-		union dmub_rb_cmd *cmd_list)
-{
-	struct dc_context *dc_ctx;
-	struct dmub_srv *dmub;
-	enum dmub_status status = DMUB_STATUS_OK;
-	int i;
-
-	if (!dc_dmub_srv || !dc_dmub_srv->dmub)
-		return false;
-
-	dc_ctx = dc_dmub_srv->ctx;
-	dmub = dc_dmub_srv->dmub;
-
-	for (i = 0 ; i < count; i++) {
-		/* confirm no messages pending */
-		do {
-			status = dmub_srv_wait_for_idle(dmub, 100000);
-		} while (dc_dmub_srv->ctx->dc->debug.disable_timeout && status != DMUB_STATUS_OK);
-
-		/* queue command */
-		if (status == DMUB_STATUS_OK)
-			status = dmub_srv_reg_cmd_execute(dmub, &cmd_list[i]);
-
-		/* check for errors */
-		if (status != DMUB_STATUS_OK) {
-			break;
-		}
-	}
-
-	if (status != DMUB_STATUS_OK) {
-		if (status != DMUB_STATUS_POWER_STATE_D3) {
-			DC_ERROR("Error starting DMUB execution: status=%d\n", status);
-			dc_dmub_srv_log_diagnostic_data(dc_dmub_srv);
-		}
-		return false;
-	}
-
-	return true;
-}
-
-static bool dc_dmub_srv_fb_cmd_list_queue_execute(struct dc_dmub_srv *dc_dmub_srv,
+bool dc_dmub_srv_cmd_list_queue_execute(struct dc_dmub_srv *dc_dmub_srv,
 		unsigned int count,
 		union dmub_rb_cmd *cmd_list)
 {
@@ -193,16 +143,11 @@ static bool dc_dmub_srv_fb_cmd_list_queue_execute(struct dc_dmub_srv *dc_dmub_sr
 
 	for (i = 0 ; i < count; i++) {
 		// Queue command
-		if (!cmd_list[i].cmd_common.header.multi_cmd_pending ||
-				dmub_rb_num_free(&dmub->inbox1.rb) >= count - i) {
-			status = dmub_srv_fb_cmd_queue(dmub, &cmd_list[i]);
-		} else {
-			status = DMUB_STATUS_QUEUE_FULL;
-		}
+		status = dmub_srv_cmd_queue(dmub, &cmd_list[i]);
 
 		if (status == DMUB_STATUS_QUEUE_FULL) {
 			/* Execute and wait for queue to become empty again. */
-			status = dmub_srv_fb_cmd_execute(dmub);
+			status = dmub_srv_cmd_execute(dmub);
 			if (status == DMUB_STATUS_POWER_STATE_D3)
 				return false;
 
@@ -211,7 +156,7 @@ static bool dc_dmub_srv_fb_cmd_list_queue_execute(struct dc_dmub_srv *dc_dmub_sr
 			} while (dc_dmub_srv->ctx->dc->debug.disable_timeout && status != DMUB_STATUS_OK);
 
 			/* Requeue the command. */
-			status = dmub_srv_fb_cmd_queue(dmub, &cmd_list[i]);
+			status = dmub_srv_cmd_queue(dmub, &cmd_list[i]);
 		}
 
 		if (status != DMUB_STATUS_OK) {
@@ -223,7 +168,7 @@ static bool dc_dmub_srv_fb_cmd_list_queue_execute(struct dc_dmub_srv *dc_dmub_sr
 		}
 	}
 
-	status = dmub_srv_fb_cmd_execute(dmub);
+	status = dmub_srv_cmd_execute(dmub);
 	if (status != DMUB_STATUS_OK) {
 		if (status != DMUB_STATUS_POWER_STATE_D3) {
 			DC_ERROR("Error starting DMUB execution: status=%d\n", status);
@@ -235,23 +180,6 @@ static bool dc_dmub_srv_fb_cmd_list_queue_execute(struct dc_dmub_srv *dc_dmub_sr
 	return true;
 }
 
-bool dc_dmub_srv_cmd_list_queue_execute(struct dc_dmub_srv *dc_dmub_srv,
-		unsigned int count,
-		union dmub_rb_cmd *cmd_list)
-{
-	bool res = false;
-
-	if (dc_dmub_srv && dc_dmub_srv->dmub) {
-		if (dc_dmub_srv->dmub->inbox_type == DMUB_CMD_INTERFACE_REG) {
-			res = dc_dmub_srv_reg_cmd_list_queue_execute(dc_dmub_srv, count, cmd_list);
-		} else {
-			res = dc_dmub_srv_fb_cmd_list_queue_execute(dc_dmub_srv, count, cmd_list);
-		}
-	}
-
-	return res;
-}
-
 bool dc_dmub_srv_wait_for_idle(struct dc_dmub_srv *dc_dmub_srv,
 		enum dm_dmub_wait_type wait_type,
 		union dmub_rb_cmd *cmd_list)
@@ -274,8 +202,7 @@ bool dc_dmub_srv_wait_for_idle(struct dc_dmub_srv *dc_dmub_srv,
 			DC_LOG_DEBUG("No reply for DMUB command: status=%d\n", status);
 			if (!dmub->debug.timeout_info.timeout_occured) {
 				dmub->debug.timeout_info.timeout_occured = true;
-				if (cmd_list)
-					dmub->debug.timeout_info.timeout_cmd = *cmd_list;
+				dmub->debug.timeout_info.timeout_cmd = *cmd_list;
 				dmub->debug.timeout_info.timestamp = dm_get_timestamp(dc_dmub_srv->ctx);
 			}
 			dc_dmub_srv_log_diagnostic_data(dc_dmub_srv);
@@ -283,9 +210,8 @@ bool dc_dmub_srv_wait_for_idle(struct dc_dmub_srv *dc_dmub_srv,
 		}
 
 		// Copy data back from ring buffer into command
-		if (wait_type == DM_DMUB_WAIT_TYPE_WAIT_WITH_REPLY && cmd_list) {
-			dmub_srv_cmd_get_response(dc_dmub_srv->dmub, cmd_list);
-		}
+		if (wait_type == DM_DMUB_WAIT_TYPE_WAIT_WITH_REPLY)
+			dmub_rb_get_return_data(&dmub->inbox1_rb, cmd_list);
 	}
 
 	return true;
@@ -298,10 +224,74 @@ bool dc_dmub_srv_cmd_run(struct dc_dmub_srv *dc_dmub_srv, union dmub_rb_cmd *cmd
 
 bool dc_dmub_srv_cmd_run_list(struct dc_dmub_srv *dc_dmub_srv, unsigned int count, union dmub_rb_cmd *cmd_list, enum dm_dmub_wait_type wait_type)
 {
-	if (!dc_dmub_srv_cmd_list_queue_execute(dc_dmub_srv, count, cmd_list))
+	struct dc_context *dc_ctx;
+	struct dmub_srv *dmub;
+	enum dmub_status status;
+	int i;
+
+	if (!dc_dmub_srv || !dc_dmub_srv->dmub)
+		return false;
+
+	dc_ctx = dc_dmub_srv->ctx;
+	dmub = dc_dmub_srv->dmub;
+
+	for (i = 0 ; i < count; i++) {
+		// Queue command
+		status = dmub_srv_cmd_queue(dmub, &cmd_list[i]);
+
+		if (status == DMUB_STATUS_QUEUE_FULL) {
+			/* Execute and wait for queue to become empty again. */
+			status = dmub_srv_cmd_execute(dmub);
+			if (status == DMUB_STATUS_POWER_STATE_D3)
+				return false;
+
+			status = dmub_srv_wait_for_idle(dmub, 100000);
+			if (status != DMUB_STATUS_OK)
+				return false;
+
+			/* Requeue the command. */
+			status = dmub_srv_cmd_queue(dmub, &cmd_list[i]);
+		}
+
+		if (status != DMUB_STATUS_OK) {
+			if (status != DMUB_STATUS_POWER_STATE_D3) {
+				DC_ERROR("Error queueing DMUB command: status=%d\n", status);
+				dc_dmub_srv_log_diagnostic_data(dc_dmub_srv);
+			}
+			return false;
+		}
+	}
+
+	status = dmub_srv_cmd_execute(dmub);
+	if (status != DMUB_STATUS_OK) {
+		if (status != DMUB_STATUS_POWER_STATE_D3) {
+			DC_ERROR("Error starting DMUB execution: status=%d\n", status);
+			dc_dmub_srv_log_diagnostic_data(dc_dmub_srv);
+		}
 		return false;
+	}
+
+	// Wait for DMUB to process command
+	if (wait_type != DM_DMUB_WAIT_TYPE_NO_WAIT) {
+		if (dc_dmub_srv->ctx->dc->debug.disable_timeout) {
+			do {
+				status = dmub_srv_wait_for_idle(dmub, 100000);
+			} while (status != DMUB_STATUS_OK);
+		} else
+			status = dmub_srv_wait_for_idle(dmub, 100000);
 
-	return dc_dmub_srv_wait_for_idle(dc_dmub_srv, wait_type, cmd_list);
+		if (status != DMUB_STATUS_OK) {
+			DC_LOG_DEBUG("No reply for DMUB command: status=%d\n", status);
+			dc_dmub_srv_log_diagnostic_data(dc_dmub_srv);
+			return false;
+		}
+
+		// Copy data back from ring buffer into command
+		if (wait_type == DM_DMUB_WAIT_TYPE_WAIT_WITH_REPLY)
+			dmub_rb_get_return_data(&dmub->inbox1_rb, cmd_list);
+	}
+
+	return true;
 }
 
 bool dc_dmub_srv_optimized_init_done(struct dc_dmub_srv *dc_dmub_srv)
@@ -1253,7 +1243,7 @@ static void dc_dmub_srv_notify_idle(const struct dc *dc, bool allow_idle)
 			ips_fw->signals.bits.ips1_commit,
 			ips_fw->signals.bits.ips2_commit);
 
-		dc_dmub_srv_wait_for_idle(dc->ctx->dmub_srv, DM_DMUB_WAIT_TYPE_WAIT, NULL);
+		dc_dmub_srv_wait_idle(dc->ctx->dmub_srv);
 
 		memset(&new_signals, 0, sizeof(new_signals));
 
@@ -1410,7 +1400,7 @@ static void dc_dmub_srv_exit_low_power_state(const struct dc *dc)
 					ips_fw->signals.bits.ips1_commit,
 					ips_fw->signals.bits.ips2_commit);
 
-				dmub_srv_sync_inboxes(dc->ctx->dmub_srv->dmub);
+				dmub_srv_sync_inbox1(dc->ctx->dmub_srv->dmub);
 			}
 		}
 
@@ -1664,8 +1654,7 @@ void dc_dmub_srv_fams2_update_config(struct dc *dc,
 	/* fill in generic command header */
 	global_cmd->header.type = DMUB_CMD__FW_ASSISTED_MCLK_SWITCH;
 	global_cmd->header.sub_type = DMUB_CMD__FAMS2_CONFIG;
-	global_cmd->header.payload_bytes =
-			sizeof(struct dmub_rb_cmd_fams2) - sizeof(struct dmub_cmd_header);
+	global_cmd->header.payload_bytes = sizeof(struct dmub_rb_cmd_fams2) - sizeof(struct dmub_cmd_header);
 
 	if (enable) {
 		/* send global configuration parameters */
@@ -1684,13 +1673,11 @@ void dc_dmub_srv_fams2_update_config(struct dc *dc,
 			/* configure command header */
 			stream_base_cmd->header.type = DMUB_CMD__FW_ASSISTED_MCLK_SWITCH;
 			stream_base_cmd->header.sub_type = DMUB_CMD__FAMS2_CONFIG;
-			stream_base_cmd->header.payload_bytes =
-					sizeof(struct dmub_rb_cmd_fams2) - sizeof(struct dmub_cmd_header);
+			stream_base_cmd->header.payload_bytes = sizeof(struct dmub_rb_cmd_fams2) - sizeof(struct dmub_cmd_header);
 			stream_base_cmd->header.multi_cmd_pending = 1;
 			stream_sub_state_cmd->header.type = DMUB_CMD__FW_ASSISTED_MCLK_SWITCH;
 			stream_sub_state_cmd->header.sub_type = DMUB_CMD__FAMS2_CONFIG;
-			stream_sub_state_cmd->header.payload_bytes =
-					sizeof(struct dmub_rb_cmd_fams2) - sizeof(struct dmub_cmd_header);
+			stream_sub_state_cmd->header.payload_bytes = sizeof(struct dmub_rb_cmd_fams2) - sizeof(struct dmub_cmd_header);
 			stream_sub_state_cmd->header.multi_cmd_pending = 1;
 			/* copy stream static base state */
 			memcpy(&stream_base_cmd->config,
@@ -1736,8 +1723,7 @@ void dc_dmub_srv_fams2_drr_update(struct dc *dc,
 	cmd.fams2_drr_update.dmub_optc_state_req.v_total_mid_frame_num = vtotal_mid_frame_num;
 	cmd.fams2_drr_update.dmub_optc_state_req.program_manual_trigger = program_manual_trigger;
 
-	cmd.fams2_drr_update.header.payload_bytes =
-			sizeof(cmd.fams2_drr_update) - sizeof(cmd.fams2_drr_update.header);
+	cmd.fams2_drr_update.header.payload_bytes = sizeof(cmd.fams2_drr_update) - sizeof(cmd.fams2_drr_update.header);
 
 	dm_execute_dmub_cmd(dc->ctx, &cmd, DM_DMUB_WAIT_TYPE_WAIT);
 }
@@ -1773,8 +1759,7 @@ void dc_dmub_srv_fams2_passthrough_flip(
 		/* build command header */
 		cmds[num_cmds].fams2_flip.header.type = DMUB_CMD__FW_ASSISTED_MCLK_SWITCH;
 		cmds[num_cmds].fams2_flip.header.sub_type = DMUB_CMD__FAMS2_FLIP;
-		cmds[num_cmds].fams2_flip.header.payload_bytes =
-				sizeof(struct dmub_rb_cmd_fams2_flip) - sizeof(struct dmub_cmd_header);
+		cmds[num_cmds].fams2_flip.header.payload_bytes = sizeof(struct dmub_rb_cmd_fams2_flip);
 
 		/* for chaining multiple commands, all but last command should set to 1 */
 		cmds[num_cmds].fams2_flip.header.multi_cmd_pending = 1;
diff --git a/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.h b/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.h
index ada5c2fb2db3..a636f4c3f01d 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.h
@@ -58,7 +58,7 @@ struct dc_dmub_srv {
 	bool needs_idle_wake;
 };
 
-bool dc_dmub_srv_wait_for_pending(struct dc_dmub_srv *dc_dmub_srv);
+void dc_dmub_srv_wait_idle(struct dc_dmub_srv *dc_dmub_srv);
 
 bool dc_dmub_srv_optimized_init_done(struct dc_dmub_srv *dc_dmub_srv);
 
diff --git a/drivers/gpu/drm/amd/display/dc/dc_helper.c b/drivers/gpu/drm/amd/display/dc/dc_helper.c
index 72b87b78da0e..8f077e15b4f0 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_helper.c
+++ b/drivers/gpu/drm/amd/display/dc/dc_helper.c
@@ -682,7 +682,7 @@ void reg_sequence_wait_done(const struct dc_context *ctx)
 	if (offload &&
 	    ctx->dc->debug.dmub_offload_enabled &&
 	    !ctx->dc->debug.dmcub_emulation) {
-		dc_dmub_srv_wait_for_idle(ctx->dmub_srv, DM_DMUB_WAIT_TYPE_WAIT, NULL);
+		dc_dmub_srv_wait_idle(ctx->dmub_srv);
 	}
 }
 
diff --git a/drivers/gpu/drm/amd/display/dc/dce/dmub_abm_lcd.c b/drivers/gpu/drm/amd/display/dc/dce/dmub_abm_lcd.c
index a641ae04450c..0d7e7f3b81a1 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dmub_abm_lcd.c
+++ b/drivers/gpu/drm/amd/display/dc/dce/dmub_abm_lcd.c
@@ -240,8 +240,7 @@ bool dmub_abm_save_restore(
 	cmd.abm_save_restore.abm_init_config_data.version = DMUB_CMD_ABM_CONTROL_VERSION_1;
 	cmd.abm_save_restore.abm_init_config_data.panel_mask = panel_mask;
 
-	cmd.abm_save_restore.header.payload_bytes =
-			sizeof(struct dmub_rb_cmd_abm_save_restore) - sizeof(struct dmub_cmd_header);
+	cmd.abm_save_restore.header.payload_bytes = sizeof(struct dmub_rb_cmd_abm_save_restore);
 
 	dc_wake_and_execute_dmub_cmd(dc, &cmd, DM_DMUB_WAIT_TYPE_WAIT);
 
diff --git a/drivers/gpu/drm/amd/display/dc/dce/dmub_replay.c b/drivers/gpu/drm/amd/display/dc/dce/dmub_replay.c
index fcd3d86ad517..c31e4f26a305 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dmub_replay.c
+++ b/drivers/gpu/drm/amd/display/dc/dce/dmub_replay.c
@@ -280,9 +280,7 @@ static void dmub_replay_set_power_opt_and_coasting_vtotal(struct dmub_replay *dm
 	memset(&cmd, 0, sizeof(cmd));
 	pCmd->header.type = DMUB_CMD__REPLAY;
 	pCmd->header.sub_type = DMUB_CMD__REPLAY_SET_POWER_OPT_AND_COASTING_VTOTAL;
-	pCmd->header.payload_bytes =
-			sizeof(struct dmub_rb_cmd_replay_set_power_opt_and_coasting_vtotal) -
-			sizeof(struct dmub_cmd_header);
+	pCmd->header.payload_bytes = sizeof(struct dmub_rb_cmd_replay_set_power_opt_and_coasting_vtotal);
 	pCmd->replay_set_power_opt_data.power_opt = power_opt;
 	pCmd->replay_set_power_opt_data.panel_inst = panel_inst;
 	pCmd->replay_set_coasting_vtotal_data.coasting_vtotal = (coasting_vtotal & 0xFFFF);
@@ -321,8 +319,7 @@ static void dmub_replay_send_cmd(struct dmub_replay *dmub,
 		cmd.replay_set_timing_sync.header.sub_type =
 			DMUB_CMD__REPLAY_SET_TIMING_SYNC_SUPPORTED;
 		cmd.replay_set_timing_sync.header.payload_bytes =
-			sizeof(struct dmub_rb_cmd_replay_set_timing_sync) -
-			sizeof(struct dmub_cmd_header);
+			sizeof(struct dmub_rb_cmd_replay_set_timing_sync);
 		//Cmd Body
 		cmd.replay_set_timing_sync.replay_set_timing_sync_data.panel_inst =
 						cmd_element->sync_data.panel_inst;
@@ -334,8 +331,7 @@ static void dmub_replay_send_cmd(struct dmub_replay *dmub,
 		cmd.replay_set_frameupdate_timer.header.sub_type =
 			DMUB_CMD__REPLAY_SET_RESIDENCY_FRAMEUPDATE_TIMER;
 		cmd.replay_set_frameupdate_timer.header.payload_bytes =
-			sizeof(struct dmub_rb_cmd_replay_set_frameupdate_timer) -
-			sizeof(struct dmub_cmd_header);
+			sizeof(struct dmub_rb_cmd_replay_set_frameupdate_timer);
 		//Cmd Body
 		cmd.replay_set_frameupdate_timer.data.panel_inst =
 						cmd_element->panel_inst;
@@ -349,8 +345,7 @@ static void dmub_replay_send_cmd(struct dmub_replay *dmub,
 		cmd.replay_set_pseudo_vtotal.header.sub_type =
 			DMUB_CMD__REPLAY_SET_PSEUDO_VTOTAL;
 		cmd.replay_set_pseudo_vtotal.header.payload_bytes =
-			sizeof(struct dmub_rb_cmd_replay_set_pseudo_vtotal) -
-			sizeof(struct dmub_cmd_header);
+			sizeof(struct dmub_rb_cmd_replay_set_pseudo_vtotal);
 		//Cmd Body
 		cmd.replay_set_pseudo_vtotal.data.panel_inst =
 			cmd_element->pseudo_vtotal_data.panel_inst;
@@ -362,8 +357,7 @@ static void dmub_replay_send_cmd(struct dmub_replay *dmub,
 		cmd.replay_disabled_adaptive_sync_sdp.header.sub_type =
 			DMUB_CMD__REPLAY_DISABLED_ADAPTIVE_SYNC_SDP;
 		cmd.replay_disabled_adaptive_sync_sdp.header.payload_bytes =
-			sizeof(struct dmub_rb_cmd_replay_disabled_adaptive_sync_sdp) -
-			sizeof(struct dmub_cmd_header);
+			sizeof(struct dmub_rb_cmd_replay_disabled_adaptive_sync_sdp);
 		//Cmd Body
 		cmd.replay_disabled_adaptive_sync_sdp.data.panel_inst =
 			cmd_element->disabled_adaptive_sync_sdp_data.panel_inst;
@@ -375,8 +369,7 @@ static void dmub_replay_send_cmd(struct dmub_replay *dmub,
 		cmd.replay_set_general_cmd.header.sub_type =
 			DMUB_CMD__REPLAY_SET_GENERAL_CMD;
 		cmd.replay_set_general_cmd.header.payload_bytes =
-			sizeof(struct dmub_rb_cmd_replay_set_general_cmd) -
-			sizeof(struct dmub_cmd_header);
+			sizeof(struct dmub_rb_cmd_replay_set_general_cmd);
 		//Cmd Body
 		cmd.replay_set_general_cmd.data.panel_inst =
 			cmd_element->set_general_cmd_data.panel_inst;
diff --git a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_dpia.c b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_dpia.c
index c149210096ac..0d123e647652 100644
--- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_dpia.c
+++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_dpia.c
@@ -92,7 +92,6 @@ bool dpia_query_hpd_status(struct dc_link *link)
 
 	/* prepare QUERY_HPD command */
 	cmd.query_hpd.header.type = DMUB_CMD__QUERY_HPD_STATE;
-	cmd.query_hpd.header.payload_bytes = sizeof(cmd.query_hpd.data);
 	cmd.query_hpd.data.instance = link->link_id.enum_id - ENUM_ID_1;
 	cmd.query_hpd.data.ch_type = AUX_CHANNEL_DPIA;
 
diff --git a/drivers/gpu/drm/amd/display/dmub/dmub_srv.h b/drivers/gpu/drm/amd/display/dmub/dmub_srv.h
index 203e3a440845..4e0efff92dca 100644
--- a/drivers/gpu/drm/amd/display/dmub/dmub_srv.h
+++ b/drivers/gpu/drm/amd/display/dmub/dmub_srv.h
@@ -51,8 +51,8 @@
  * for the cache windows.
  *
  * The call to dmub_srv_hw_init() programs the DMCUB registers to prepare
- * for command submission. Commands can be queued via dmub_srv_fb_cmd_queue()
- * and executed via dmub_srv_fb_cmd_execute().
+ * for command submission. Commands can be queued via dmub_srv_cmd_queue()
+ * and executed via dmub_srv_cmd_execute().
  *
  * If the queue is full the dmub_srv_wait_for_idle() call can be used to
  * wait until the queue has been cleared.
@@ -170,13 +170,6 @@ enum dmub_srv_power_state_type {
 	DMUB_POWER_STATE_D3 = 8
 };
 
-/* enum dmub_inbox_cmd_interface type - defines default interface for host->dmub commands */
-enum dmub_inbox_cmd_interface_type {
-	DMUB_CMD_INTERFACE_DEFAULT = 0,
-	DMUB_CMD_INTERFACE_FB = 1,
-	DMUB_CMD_INTERFACE_REG = 2,
-};
-
 /**
  * struct dmub_region - dmub hw memory region
  * @base: base address for region, must be 256 byte aligned
@@ -356,21 +349,6 @@ struct dmub_diagnostic_data {
 	uint8_t is_cw6_enabled : 1;
 };
 
-struct dmub_srv_inbox {
-	/* generic status */
-	uint64_t num_submitted;
-	uint64_t num_reported;
-	union {
-		/* frame buffer mailbox status */
-		struct dmub_rb rb;
-		/* register mailbox status */
-		struct {
-			bool is_pending;
-			bool is_multi_pending;
-		};
-	};
-};
-
 /**
  * struct dmub_srv_base_funcs - Driver specific base callbacks
  */
@@ -484,21 +462,18 @@ struct dmub_srv_hw_funcs {
 	void (*init_reg_offsets)(struct dmub_srv *dmub, struct dc_context *ctx);
 
 	void (*subvp_save_surf_addr)(struct dmub_srv *dmub, const struct dc_plane_address *addr, uint8_t subvp_index);
-
 	void (*send_reg_inbox0_cmd_msg)(struct dmub_srv *dmub,
 			union dmub_rb_cmd *cmd);
 	uint32_t (*read_reg_inbox0_rsp_int_status)(struct dmub_srv *dmub);
 	void (*read_reg_inbox0_cmd_rsp)(struct dmub_srv *dmub,
 			union dmub_rb_cmd *cmd);
 	void (*write_reg_inbox0_rsp_int_ack)(struct dmub_srv *dmub);
-	void (*clear_reg_inbox0_rsp_int_ack)(struct dmub_srv *dmub);
-	void (*enable_reg_inbox0_rsp_int)(struct dmub_srv *dmub, bool enable);
-
 	uint32_t (*read_reg_outbox0_rdy_int_status)(struct dmub_srv *dmub);
 	void (*write_reg_outbox0_rdy_int_ack)(struct dmub_srv *dmub);
 	void (*read_reg_outbox0_msg)(struct dmub_srv *dmub, uint32_t *msg);
 	void (*write_reg_outbox0_rsp)(struct dmub_srv *dmub, uint32_t *rsp);
 	uint32_t (*read_reg_outbox0_rsp_int_status)(struct dmub_srv *dmub);
+	void (*enable_reg_inbox0_rsp_int)(struct dmub_srv *dmub, bool enable);
 	void (*enable_reg_outbox0_rdy_int)(struct dmub_srv *dmub, bool enable);
 };
 
@@ -518,7 +493,6 @@ struct dmub_srv_create_params {
 	enum dmub_asic asic;
 	uint32_t fw_version;
 	bool is_virtual;
-	enum dmub_inbox_cmd_interface_type inbox_type;
 };
 
 /**
@@ -547,9 +521,8 @@ struct dmub_srv {
 	const struct dmub_srv_dcn401_regs *regs_dcn401;
 	struct dmub_srv_base_funcs funcs;
 	struct dmub_srv_hw_funcs hw_funcs;
-	struct dmub_srv_inbox inbox1;
+	struct dmub_rb inbox1_rb;
 	uint32_t inbox1_last_wptr;
-	struct dmub_srv_inbox reg_inbox0;
 	/**
 	 * outbox1_rb is accessed without locks (dal & dc)
 	 * and to be used only in dmub_srv_stat_get_notification()
@@ -569,7 +542,6 @@ struct dmub_srv {
 	struct dmub_fw_meta_info meta_info;
 	struct dmub_feature_caps feature_caps;
 	struct dmub_visual_confirm_color visual_confirm_color;
-	enum dmub_inbox_cmd_interface_type inbox_type;
 
 	enum dmub_srv_power_state_type power_state;
 	struct dmub_diagnostic_data debug;
@@ -727,7 +699,19 @@ enum dmub_status dmub_srv_hw_init(struct dmub_srv *dmub,
 enum dmub_status dmub_srv_hw_reset(struct dmub_srv *dmub);
 
 /**
- * dmub_srv_fb_cmd_queue() - queues a command to the DMUB
+ * dmub_srv_sync_inbox1() - sync sw state with hw state
+ * @dmub: the dmub service
+ *
+ * Sync sw state with hw state when resume from S0i3
+ *
+ * Return:
+ *   DMUB_STATUS_OK - success
+ *   DMUB_STATUS_INVALID - unspecified error
+ */
+enum dmub_status dmub_srv_sync_inbox1(struct dmub_srv *dmub);
+
+/**
+ * dmub_srv_cmd_queue() - queues a command to the DMUB
  * @dmub: the dmub service
  * @cmd: the command to queue
  *
@@ -739,11 +723,11 @@ enum dmub_status dmub_srv_hw_reset(struct dmub_srv *dmub);
  *   DMUB_STATUS_QUEUE_FULL - no remaining room in queue
  *   DMUB_STATUS_INVALID - unspecified error
  */
-enum dmub_status dmub_srv_fb_cmd_queue(struct dmub_srv *dmub,
+enum dmub_status dmub_srv_cmd_queue(struct dmub_srv *dmub,
 				    const union dmub_rb_cmd *cmd);
 
 /**
- * dmub_srv_fb_cmd_execute() - Executes a queued sequence to the dmub
+ * dmub_srv_cmd_execute() - Executes a queued sequence to the dmub
  * @dmub: the dmub service
  *
  * Begins execution of queued commands on the dmub.
@@ -752,7 +736,7 @@ enum dmub_status dmub_srv_fb_cmd_queue(struct dmub_srv *dmub,
  *   DMUB_STATUS_OK - success
  *   DMUB_STATUS_INVALID - unspecified error
  */
-enum dmub_status dmub_srv_fb_cmd_execute(struct dmub_srv *dmub);
+enum dmub_status dmub_srv_cmd_execute(struct dmub_srv *dmub);
 
 /**
  * dmub_srv_wait_for_hw_pwr_up() - Waits for firmware hardware power up is completed
@@ -810,23 +794,6 @@ enum dmub_status dmub_srv_wait_for_auto_load(struct dmub_srv *dmub,
 enum dmub_status dmub_srv_wait_for_phy_init(struct dmub_srv *dmub,
 					    uint32_t timeout_us);
 
-/**
- * dmub_srv_wait_for_pending() - Re-entrant wait for messages currently pending
- * @dmub: the dmub service
- * @timeout_us: the maximum number of microseconds to wait
- *
- * Waits until the commands queued prior to this call are complete.
- * If interfaces remain busy due to additional work being submitted
- * concurrently, this function will not continue to wait.
- *
- * Return:
- *   DMUB_STATUS_OK - success
- *   DMUB_STATUS_TIMEOUT - wait for buffer to flush timed out
- *   DMUB_STATUS_INVALID - unspecified error
- */
-enum dmub_status dmub_srv_wait_for_pending(struct dmub_srv *dmub,
-					uint32_t timeout_us);
-
 /**
  * dmub_srv_wait_for_idle() - Waits for the DMUB to be idle
  * @dmub: the dmub service
@@ -925,6 +892,9 @@ enum dmub_status dmub_srv_get_fw_boot_status(struct dmub_srv *dmub,
 enum dmub_status dmub_srv_get_fw_boot_option(struct dmub_srv *dmub,
 					     union dmub_fw_boot_options *option);
 
+enum dmub_status dmub_srv_cmd_with_reply_data(struct dmub_srv *dmub,
+					      union dmub_rb_cmd *cmd);
+
 enum dmub_status dmub_srv_set_skip_panel_power_sequence(struct dmub_srv *dmub,
 					     bool skip);
 
@@ -989,51 +959,35 @@ enum dmub_status dmub_srv_clear_inbox0_ack(struct dmub_srv *dmub);
 void dmub_srv_subvp_save_surf_addr(struct dmub_srv *dmub, const struct dc_plane_address *addr, uint8_t subvp_index);
 
 /**
- * dmub_srv_set_power_state() - Track DC power state in dmub_srv
+ * dmub_srv_send_reg_inbox0_cmd() - send a dmub command and wait for the command
+ * being processed by DMUB.
  * @dmub: The dmub service
- * @power_state: DC power state setting
- *
- * Store DC power state in dmub_srv.  If dmub_srv is in D3, then don't send messages to DMUB
+ * @cmd: The dmub command being sent. If with_replay is true, the function will
+ * update cmd with replied data.
+ * @with_reply: true if DMUB reply needs to be copied back to cmd. false if the
+ * cmd doesn't need to be replied.
+ * @timeout_us: timeout in microseconds.
  *
  * Return:
- *   void
+ * DMUB_STATUS_OK - success
+ * DMUB_STATUS_TIMEOUT - DMUB fails to process the command within the timeout
+ * interval.
  */
-void dmub_srv_set_power_state(struct dmub_srv *dmub, enum dmub_srv_power_state_type dmub_srv_power_state);
+enum dmub_status dmub_srv_send_reg_inbox0_cmd(
+		struct dmub_srv *dmub,
+		union dmub_rb_cmd *cmd,
+		bool with_reply, uint32_t timeout_us);
 
 /**
- * dmub_srv_reg_cmd_execute() - Executes provided command to the dmub
- * @dmub: the dmub service
- * @cmd: the command packet to be executed
- *
- * Executes a single command for the dmub.
- *
- * Return:
- *   DMUB_STATUS_OK - success
- *   DMUB_STATUS_INVALID - unspecified error
- */
-enum dmub_status dmub_srv_reg_cmd_execute(struct dmub_srv *dmub, union dmub_rb_cmd *cmd);
-
-
-/**
- * dmub_srv_cmd_get_response() - Copies return data for command into buffer
- * @dmub: the dmub service
- * @cmd_rsp: response buffer
- *
- * Copies return data for command into buffer
- */
-void dmub_srv_cmd_get_response(struct dmub_srv *dmub,
-		union dmub_rb_cmd *cmd_rsp);
-
-/**
- * dmub_srv_sync_inboxes() - Sync inbox state
- * @dmub: the dmub service
+ * dmub_srv_set_power_state() - Track DC power state in dmub_srv
+ * @dmub: The dmub service
+ * @power_state: DC power state setting
  *
- * Sync inbox state
+ * Store DC power state in dmub_srv.  If dmub_srv is in D3, then don't send messages to DMUB
  *
  * Return:
- *   DMUB_STATUS_OK - success
- *   DMUB_STATUS_INVALID - unspecified error
+ *   void
  */
-enum dmub_status dmub_srv_sync_inboxes(struct dmub_srv *dmub);
+void dmub_srv_set_power_state(struct dmub_srv *dmub, enum dmub_srv_power_state_type dmub_srv_power_state);
 
 #endif /* _DMUB_SRV_H_ */
diff --git a/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn401.c b/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn401.c
index 731ca9b6a6cf..e67f7c4784eb 100644
--- a/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn401.c
+++ b/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn401.c
@@ -517,69 +517,28 @@ void dmub_dcn401_send_reg_inbox0_cmd_msg(struct dmub_srv *dmub,
 		union dmub_rb_cmd *cmd)
 {
 	uint32_t *dwords = (uint32_t *)cmd;
-	int32_t payload_size_bytes = cmd->cmd_common.header.payload_bytes;
-	uint32_t msg_index;
-	static_assert(sizeof(*cmd) == 64, "DMUB command size mismatch");
-
-	/* read remaining data based on payload size */
-	for (msg_index = 0; msg_index < 15; msg_index++) {
-		if (payload_size_bytes <= msg_index * 4) {
-			break;
-		}
 
-		switch (msg_index) {
-		case 0:
-			REG_WRITE(DMCUB_REG_INBOX0_MSG0, dwords[msg_index + 1]);
-			break;
-		case 1:
-			REG_WRITE(DMCUB_REG_INBOX0_MSG1, dwords[msg_index + 1]);
-			break;
-		case 2:
-			REG_WRITE(DMCUB_REG_INBOX0_MSG2, dwords[msg_index + 1]);
-			break;
-		case 3:
-			REG_WRITE(DMCUB_REG_INBOX0_MSG3, dwords[msg_index + 1]);
-			break;
-		case 4:
-			REG_WRITE(DMCUB_REG_INBOX0_MSG4, dwords[msg_index + 1]);
-			break;
-		case 5:
-			REG_WRITE(DMCUB_REG_INBOX0_MSG5, dwords[msg_index + 1]);
-			break;
-		case 6:
-			REG_WRITE(DMCUB_REG_INBOX0_MSG6, dwords[msg_index + 1]);
-			break;
-		case 7:
-			REG_WRITE(DMCUB_REG_INBOX0_MSG7, dwords[msg_index + 1]);
-			break;
-		case 8:
-			REG_WRITE(DMCUB_REG_INBOX0_MSG8, dwords[msg_index + 1]);
-			break;
-		case 9:
-			REG_WRITE(DMCUB_REG_INBOX0_MSG9, dwords[msg_index + 1]);
-			break;
-		case 10:
-			REG_WRITE(DMCUB_REG_INBOX0_MSG10, dwords[msg_index + 1]);
-			break;
-		case 11:
-			REG_WRITE(DMCUB_REG_INBOX0_MSG11, dwords[msg_index + 1]);
-			break;
-		case 12:
-			REG_WRITE(DMCUB_REG_INBOX0_MSG12, dwords[msg_index + 1]);
-			break;
-		case 13:
-			REG_WRITE(DMCUB_REG_INBOX0_MSG13, dwords[msg_index + 1]);
-			break;
-		case 14:
-			REG_WRITE(DMCUB_REG_INBOX0_MSG14, dwords[msg_index + 1]);
-			break;
-		}
-	}
+	static_assert(sizeof(*cmd) == 64, "DMUB command size mismatch");
 
+	REG_WRITE(DMCUB_REG_INBOX0_MSG0, dwords[0]);
+	REG_WRITE(DMCUB_REG_INBOX0_MSG1, dwords[1]);
+	REG_WRITE(DMCUB_REG_INBOX0_MSG2, dwords[2]);
+	REG_WRITE(DMCUB_REG_INBOX0_MSG3, dwords[3]);
+	REG_WRITE(DMCUB_REG_INBOX0_MSG4, dwords[4]);
+	REG_WRITE(DMCUB_REG_INBOX0_MSG5, dwords[5]);
+	REG_WRITE(DMCUB_REG_INBOX0_MSG6, dwords[6]);
+	REG_WRITE(DMCUB_REG_INBOX0_MSG7, dwords[7]);
+	REG_WRITE(DMCUB_REG_INBOX0_MSG8, dwords[8]);
+	REG_WRITE(DMCUB_REG_INBOX0_MSG9, dwords[9]);
+	REG_WRITE(DMCUB_REG_INBOX0_MSG10, dwords[10]);
+	REG_WRITE(DMCUB_REG_INBOX0_MSG11, dwords[11]);
+	REG_WRITE(DMCUB_REG_INBOX0_MSG12, dwords[12]);
+	REG_WRITE(DMCUB_REG_INBOX0_MSG13, dwords[13]);
+	REG_WRITE(DMCUB_REG_INBOX0_MSG14, dwords[14]);
 	/* writing to INBOX RDY register will trigger DMUB REG INBOX0 RDY
 	 * interrupt.
 	 */
-	REG_WRITE(DMCUB_REG_INBOX0_RDY, dwords[0]);
+	REG_WRITE(DMCUB_REG_INBOX0_RDY, dwords[15]);
 }
 
 uint32_t dmub_dcn401_read_reg_inbox0_rsp_int_status(struct dmub_srv *dmub)
@@ -597,39 +556,30 @@ void dmub_dcn401_read_reg_inbox0_cmd_rsp(struct dmub_srv *dmub,
 
 	static_assert(sizeof(*cmd) == 64, "DMUB command size mismatch");
 
-	dwords[0] = REG_READ(DMCUB_REG_INBOX0_RSP);
-	dwords[1] = REG_READ(DMCUB_REG_INBOX0_MSG0);
-	dwords[2] = REG_READ(DMCUB_REG_INBOX0_MSG1);
-	dwords[3] = REG_READ(DMCUB_REG_INBOX0_MSG2);
-	dwords[4] = REG_READ(DMCUB_REG_INBOX0_MSG3);
-	dwords[5] = REG_READ(DMCUB_REG_INBOX0_MSG4);
-	dwords[6] = REG_READ(DMCUB_REG_INBOX0_MSG5);
-	dwords[7] = REG_READ(DMCUB_REG_INBOX0_MSG6);
-	dwords[8] = REG_READ(DMCUB_REG_INBOX0_MSG7);
-	dwords[9] = REG_READ(DMCUB_REG_INBOX0_MSG8);
-	dwords[10] = REG_READ(DMCUB_REG_INBOX0_MSG9);
-	dwords[11] = REG_READ(DMCUB_REG_INBOX0_MSG10);
-	dwords[12] = REG_READ(DMCUB_REG_INBOX0_MSG11);
-	dwords[13] = REG_READ(DMCUB_REG_INBOX0_MSG12);
-	dwords[14] = REG_READ(DMCUB_REG_INBOX0_MSG13);
-	dwords[15] = REG_READ(DMCUB_REG_INBOX0_MSG14);
+	dwords[0] = REG_READ(DMCUB_REG_INBOX0_MSG0);
+	dwords[1] = REG_READ(DMCUB_REG_INBOX0_MSG1);
+	dwords[2] = REG_READ(DMCUB_REG_INBOX0_MSG2);
+	dwords[3] = REG_READ(DMCUB_REG_INBOX0_MSG3);
+	dwords[4] = REG_READ(DMCUB_REG_INBOX0_MSG4);
+	dwords[5] = REG_READ(DMCUB_REG_INBOX0_MSG5);
+	dwords[6] = REG_READ(DMCUB_REG_INBOX0_MSG6);
+	dwords[7] = REG_READ(DMCUB_REG_INBOX0_MSG7);
+	dwords[8] = REG_READ(DMCUB_REG_INBOX0_MSG8);
+	dwords[9] = REG_READ(DMCUB_REG_INBOX0_MSG9);
+	dwords[10] = REG_READ(DMCUB_REG_INBOX0_MSG10);
+	dwords[11] = REG_READ(DMCUB_REG_INBOX0_MSG11);
+	dwords[12] = REG_READ(DMCUB_REG_INBOX0_MSG12);
+	dwords[13] = REG_READ(DMCUB_REG_INBOX0_MSG13);
+	dwords[14] = REG_READ(DMCUB_REG_INBOX0_MSG14);
+	dwords[15] = REG_READ(DMCUB_REG_INBOX0_RSP);
 }
 
 void dmub_dcn401_write_reg_inbox0_rsp_int_ack(struct dmub_srv *dmub)
 {
 	REG_UPDATE(HOST_INTERRUPT_CSR, HOST_REG_INBOX0_RSP_INT_ACK, 1);
-}
-
-void dmub_dcn401_clear_reg_inbox0_rsp_int_ack(struct dmub_srv *dmub)
-{
 	REG_UPDATE(HOST_INTERRUPT_CSR, HOST_REG_INBOX0_RSP_INT_ACK, 0);
 }
 
-void dmub_dcn401_enable_reg_inbox0_rsp_int(struct dmub_srv *dmub, bool enable)
-{
-	REG_UPDATE(HOST_INTERRUPT_CSR, HOST_REG_INBOX0_RSP_INT_EN, enable ? 1:0);
-}
-
 void dmub_dcn401_write_reg_outbox0_rdy_int_ack(struct dmub_srv *dmub)
 {
 	REG_UPDATE(HOST_INTERRUPT_CSR, HOST_REG_OUTBOX0_RDY_INT_ACK, 1);
@@ -654,6 +604,11 @@ uint32_t dmub_dcn401_read_reg_outbox0_rsp_int_status(struct dmub_srv *dmub)
 	return status;
 }
 
+void dmub_dcn401_enable_reg_inbox0_rsp_int(struct dmub_srv *dmub, bool enable)
+{
+	REG_UPDATE(HOST_INTERRUPT_CSR, HOST_REG_INBOX0_RSP_INT_EN, enable ? 1:0);
+}
+
 void dmub_dcn401_enable_reg_outbox0_rdy_int(struct dmub_srv *dmub, bool enable)
 {
 	REG_UPDATE(HOST_INTERRUPT_CSR, HOST_REG_OUTBOX0_RDY_INT_EN, enable ? 1:0);
diff --git a/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn401.h b/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn401.h
index 88c3a44d67d9..c35be52676f6 100644
--- a/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn401.h
+++ b/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn401.h
@@ -277,13 +277,11 @@ uint32_t dmub_dcn401_read_reg_inbox0_rsp_int_status(struct dmub_srv *dmub);
 void dmub_dcn401_read_reg_inbox0_cmd_rsp(struct dmub_srv *dmub,
 		union dmub_rb_cmd *cmd);
 void dmub_dcn401_write_reg_inbox0_rsp_int_ack(struct dmub_srv *dmub);
-void dmub_dcn401_clear_reg_inbox0_rsp_int_ack(struct dmub_srv *dmub);
-void dmub_dcn401_enable_reg_inbox0_rsp_int(struct dmub_srv *dmub, bool enable);
-
 void dmub_dcn401_write_reg_outbox0_rdy_int_ack(struct dmub_srv *dmub);
 void dmub_dcn401_read_reg_outbox0_msg(struct dmub_srv *dmub, uint32_t *msg);
 void dmub_dcn401_write_reg_outbox0_rsp(struct dmub_srv *dmub, uint32_t *msg);
 uint32_t dmub_dcn401_read_reg_outbox0_rsp_int_status(struct dmub_srv *dmub);
+void dmub_dcn401_enable_reg_inbox0_rsp_int(struct dmub_srv *dmub, bool enable);
 void dmub_dcn401_enable_reg_outbox0_rdy_int(struct dmub_srv *dmub, bool enable);
 uint32_t dmub_dcn401_read_reg_outbox0_rdy_int_status(struct dmub_srv *dmub);
 
diff --git a/drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c b/drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c
index 713576a1f6fa..70038f83170c 100644
--- a/drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c
+++ b/drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c
@@ -157,9 +157,6 @@ static bool dmub_srv_hw_setup(struct dmub_srv *dmub, enum dmub_asic asic)
 {
 	struct dmub_srv_hw_funcs *funcs = &dmub->hw_funcs;
 
-	/* default to specifying now inbox type */
-	enum dmub_inbox_cmd_interface_type default_inbox_type = DMUB_CMD_INTERFACE_DEFAULT;
-
 	switch (asic) {
 	case DMUB_ASIC_DCN20:
 	case DMUB_ASIC_DCN21:
@@ -398,15 +395,10 @@ static bool dmub_srv_hw_setup(struct dmub_srv *dmub, enum dmub_asic asic)
 
 		funcs->get_current_time = dmub_dcn401_get_current_time;
 		funcs->get_diagnostic_data = dmub_dcn401_get_diagnostic_data;
-
 		funcs->send_reg_inbox0_cmd_msg = dmub_dcn401_send_reg_inbox0_cmd_msg;
 		funcs->read_reg_inbox0_rsp_int_status = dmub_dcn401_read_reg_inbox0_rsp_int_status;
 		funcs->read_reg_inbox0_cmd_rsp = dmub_dcn401_read_reg_inbox0_cmd_rsp;
 		funcs->write_reg_inbox0_rsp_int_ack = dmub_dcn401_write_reg_inbox0_rsp_int_ack;
-		funcs->clear_reg_inbox0_rsp_int_ack = dmub_dcn401_clear_reg_inbox0_rsp_int_ack;
-		funcs->enable_reg_inbox0_rsp_int = dmub_dcn401_enable_reg_inbox0_rsp_int;
-		default_inbox_type = DMUB_CMD_INTERFACE_FB; // still default to FB for now
-
 		funcs->write_reg_outbox0_rdy_int_ack = dmub_dcn401_write_reg_outbox0_rdy_int_ack;
 		funcs->read_reg_outbox0_msg = dmub_dcn401_read_reg_outbox0_msg;
 		funcs->write_reg_outbox0_rsp = dmub_dcn401_write_reg_outbox0_rsp;
@@ -419,20 +411,6 @@ static bool dmub_srv_hw_setup(struct dmub_srv *dmub, enum dmub_asic asic)
 		return false;
 	}
 
-	/* set default inbox type if not overriden */
-	if (dmub->inbox_type == DMUB_CMD_INTERFACE_DEFAULT) {
-		if (default_inbox_type != DMUB_CMD_INTERFACE_DEFAULT) {
-			/* use default inbox type as specified by DCN rev */
-			dmub->inbox_type = default_inbox_type;
-		} else if (funcs->send_reg_inbox0_cmd_msg) {
-			/* prefer reg as default inbox type if present */
-			dmub->inbox_type = DMUB_CMD_INTERFACE_REG;
-		} else {
-			/* use fb as fallback */
-			dmub->inbox_type = DMUB_CMD_INTERFACE_FB;
-		}
-	}
-
 	return true;
 }
 
@@ -448,7 +426,6 @@ enum dmub_status dmub_srv_create(struct dmub_srv *dmub,
 	dmub->asic = params->asic;
 	dmub->fw_version = params->fw_version;
 	dmub->is_virtual = params->is_virtual;
-	dmub->inbox_type = params->inbox_type;
 
 	/* Setup asic dependent hardware funcs. */
 	if (!dmub_srv_hw_setup(dmub, params->asic)) {
@@ -718,7 +695,7 @@ enum dmub_status dmub_srv_hw_init(struct dmub_srv *dmub,
 	inbox1.base = cw4.region.base;
 	inbox1.top = cw4.region.base + DMUB_RB_SIZE;
 	outbox1.base = inbox1.top;
-	outbox1.top = inbox1.top + DMUB_RB_SIZE;
+	outbox1.top = cw4.region.top;
 
 	cw5.offset.quad_part = tracebuff_fb->gpu_addr;
 	cw5.region.base = DMUB_CW5_BASE;
@@ -760,7 +737,7 @@ enum dmub_status dmub_srv_hw_init(struct dmub_srv *dmub,
 	rb_params.ctx = dmub;
 	rb_params.base_address = mail_fb->cpu_addr;
 	rb_params.capacity = DMUB_RB_SIZE;
-	dmub_rb_init(&dmub->inbox1.rb, &rb_params);
+	dmub_rb_init(&dmub->inbox1_rb, &rb_params);
 
 	// Initialize outbox1 ring buffer
 	rb_params.ctx = dmub;
@@ -791,6 +768,27 @@ enum dmub_status dmub_srv_hw_init(struct dmub_srv *dmub,
 	return DMUB_STATUS_OK;
 }
 
+enum dmub_status dmub_srv_sync_inbox1(struct dmub_srv *dmub)
+{
+	if (!dmub->sw_init)
+		return DMUB_STATUS_INVALID;
+
+	if (dmub->hw_funcs.get_inbox1_rptr && dmub->hw_funcs.get_inbox1_wptr) {
+		uint32_t rptr = dmub->hw_funcs.get_inbox1_rptr(dmub);
+		uint32_t wptr = dmub->hw_funcs.get_inbox1_wptr(dmub);
+
+		if (rptr > dmub->inbox1_rb.capacity || wptr > dmub->inbox1_rb.capacity) {
+			return DMUB_STATUS_HW_FAILURE;
+		} else {
+			dmub->inbox1_rb.rptr = rptr;
+			dmub->inbox1_rb.wrpt = wptr;
+			dmub->inbox1_last_wptr = dmub->inbox1_rb.wrpt;
+		}
+	}
+
+	return DMUB_STATUS_OK;
+}
+
 enum dmub_status dmub_srv_hw_reset(struct dmub_srv *dmub)
 {
 	if (!dmub->sw_init)
@@ -801,13 +799,8 @@ enum dmub_status dmub_srv_hw_reset(struct dmub_srv *dmub)
 
 	/* mailboxes have been reset in hw, so reset the sw state as well */
 	dmub->inbox1_last_wptr = 0;
-	dmub->inbox1.rb.wrpt = 0;
-	dmub->inbox1.rb.rptr = 0;
-	dmub->inbox1.num_reported = 0;
-	dmub->inbox1.num_submitted = 0;
-	dmub->reg_inbox0.num_reported = 0;
-	dmub->reg_inbox0.num_submitted = 0;
-	dmub->reg_inbox0.is_pending = 0;
+	dmub->inbox1_rb.wrpt = 0;
+	dmub->inbox1_rb.rptr = 0;
 	dmub->outbox0_rb.wrpt = 0;
 	dmub->outbox0_rb.rptr = 0;
 	dmub->outbox1_rb.wrpt = 0;
@@ -818,7 +811,7 @@ enum dmub_status dmub_srv_hw_reset(struct dmub_srv *dmub)
 	return DMUB_STATUS_OK;
 }
 
-enum dmub_status dmub_srv_fb_cmd_queue(struct dmub_srv *dmub,
+enum dmub_status dmub_srv_cmd_queue(struct dmub_srv *dmub,
 				    const union dmub_rb_cmd *cmd)
 {
 	if (!dmub->hw_init)
@@ -827,20 +820,18 @@ enum dmub_status dmub_srv_fb_cmd_queue(struct dmub_srv *dmub,
 	if (dmub->power_state != DMUB_POWER_STATE_D0)
 		return DMUB_STATUS_POWER_STATE_D3;
 
-	if (dmub->inbox1.rb.rptr > dmub->inbox1.rb.capacity ||
-	    dmub->inbox1.rb.wrpt > dmub->inbox1.rb.capacity) {
+	if (dmub->inbox1_rb.rptr > dmub->inbox1_rb.capacity ||
+	    dmub->inbox1_rb.wrpt > dmub->inbox1_rb.capacity) {
 		return DMUB_STATUS_HW_FAILURE;
 	}
 
-	if (dmub_rb_push_front(&dmub->inbox1.rb, cmd)) {
-		dmub->inbox1.num_submitted++;
+	if (dmub_rb_push_front(&dmub->inbox1_rb, cmd))
 		return DMUB_STATUS_OK;
-	}
 
 	return DMUB_STATUS_QUEUE_FULL;
 }
 
-enum dmub_status dmub_srv_fb_cmd_execute(struct dmub_srv *dmub)
+enum dmub_status dmub_srv_cmd_execute(struct dmub_srv *dmub)
 {
 	struct dmub_rb flush_rb;
 
@@ -855,13 +846,13 @@ enum dmub_status dmub_srv_fb_cmd_execute(struct dmub_srv *dmub)
 	 * been flushed to framebuffer memory. Otherwise DMCUB might
 	 * read back stale, fully invalid or partially invalid data.
 	 */
-	flush_rb = dmub->inbox1.rb;
+	flush_rb = dmub->inbox1_rb;
 	flush_rb.rptr = dmub->inbox1_last_wptr;
 	dmub_rb_flush_pending(&flush_rb);
 
-		dmub->hw_funcs.set_inbox1_wptr(dmub, dmub->inbox1.rb.wrpt);
+		dmub->hw_funcs.set_inbox1_wptr(dmub, dmub->inbox1_rb.wrpt);
 
-	dmub->inbox1_last_wptr = dmub->inbox1.rb.wrpt;
+	dmub->inbox1_last_wptr = dmub->inbox1_rb.wrpt;
 
 	return DMUB_STATUS_OK;
 }
@@ -919,97 +910,26 @@ enum dmub_status dmub_srv_wait_for_auto_load(struct dmub_srv *dmub,
 	return DMUB_STATUS_TIMEOUT;
 }
 
-static void dmub_srv_update_reg_inbox0_status(struct dmub_srv *dmub)
-{
-	if (dmub->reg_inbox0.is_pending) {
-		dmub->reg_inbox0.is_pending = dmub->hw_funcs.read_reg_inbox0_rsp_int_status &&
-				!dmub->hw_funcs.read_reg_inbox0_rsp_int_status(dmub);
-
-		if (!dmub->reg_inbox0.is_pending) {
-			/* ack the rsp interrupt */
-			if (dmub->hw_funcs.write_reg_inbox0_rsp_int_ack)
-				dmub->hw_funcs.write_reg_inbox0_rsp_int_ack(dmub);
-
-			/* only update the reported count if commands aren't being batched */
-			if (!dmub->reg_inbox0.is_pending && !dmub->reg_inbox0.is_multi_pending) {
-				dmub->reg_inbox0.num_reported = dmub->reg_inbox0.num_submitted;
-			}
-		}
-	}
-}
-
-enum dmub_status dmub_srv_wait_for_pending(struct dmub_srv *dmub,
-					uint32_t timeout_us)
-{
-	uint32_t i;
-	const uint32_t polling_interval_us = 1;
-	struct dmub_srv_inbox scratch_reg_inbox0 = dmub->reg_inbox0;
-	struct dmub_srv_inbox scratch_inbox1 = dmub->inbox1;
-	const volatile struct dmub_srv_inbox *reg_inbox0 = &dmub->reg_inbox0;
-	const volatile struct dmub_srv_inbox *inbox1 = &dmub->inbox1;
-
-	if (!dmub->hw_init ||
-			!dmub->hw_funcs.get_inbox1_wptr)
-		return DMUB_STATUS_INVALID;
-
-	/* take a snapshot of the required mailbox state */
-	scratch_inbox1.rb.wrpt = dmub->hw_funcs.get_inbox1_wptr(dmub);
-
-	for (i = 0; i <= timeout_us; i += polling_interval_us) {
-			scratch_inbox1.rb.rptr = dmub->hw_funcs.get_inbox1_rptr(dmub);
-
-		scratch_reg_inbox0.is_pending = scratch_reg_inbox0.is_pending &&
-				dmub->hw_funcs.read_reg_inbox0_rsp_int_status &&
-				!dmub->hw_funcs.read_reg_inbox0_rsp_int_status(dmub);
-
-		if (scratch_inbox1.rb.rptr > dmub->inbox1.rb.capacity)
-			return DMUB_STATUS_HW_FAILURE;
-
-		/* check current HW state first, but use command submission vs reported as a fallback */
-		if ((dmub_rb_empty(&scratch_inbox1.rb) ||
-				inbox1->num_reported >= scratch_inbox1.num_submitted) &&
-				(!scratch_reg_inbox0.is_pending ||
-				reg_inbox0->num_reported >= scratch_reg_inbox0.num_submitted))
-			return DMUB_STATUS_OK;
-
-		udelay(polling_interval_us);
-	}
-
-	return DMUB_STATUS_TIMEOUT;
-}
-
 enum dmub_status dmub_srv_wait_for_idle(struct dmub_srv *dmub,
 					uint32_t timeout_us)
 {
 	uint32_t i, rptr;
-	const uint32_t polling_interval_us = 1;
 
 	if (!dmub->hw_init)
 		return DMUB_STATUS_INVALID;
 
-	for (i = 0; i < timeout_us; i += polling_interval_us) {
-		/* update inbox1 state */
+	for (i = 0; i <= timeout_us; ++i) {
 			rptr = dmub->hw_funcs.get_inbox1_rptr(dmub);
 
-		if (rptr > dmub->inbox1.rb.capacity)
+		if (rptr > dmub->inbox1_rb.capacity)
 			return DMUB_STATUS_HW_FAILURE;
 
-		if (dmub->inbox1.rb.rptr > rptr) {
-			/* rb wrapped */
-			dmub->inbox1.num_reported += (rptr + dmub->inbox1.rb.capacity - dmub->inbox1.rb.rptr) / DMUB_RB_CMD_SIZE;
-		} else {
-			dmub->inbox1.num_reported += (rptr - dmub->inbox1.rb.rptr) / DMUB_RB_CMD_SIZE;
-		}
-		dmub->inbox1.rb.rptr = rptr;
-
-		/* update reg_inbox0 */
-		dmub_srv_update_reg_inbox0_status(dmub);
+		dmub->inbox1_rb.rptr = rptr;
 
-		/* check for idle */
-		if (dmub_rb_empty(&dmub->inbox1.rb) && !dmub->reg_inbox0.is_pending)
+		if (dmub_rb_empty(&dmub->inbox1_rb))
 			return DMUB_STATUS_OK;
 
-		udelay(polling_interval_us);
+		udelay(1);
 	}
 
 	return DMUB_STATUS_TIMEOUT;
@@ -1120,6 +1040,35 @@ enum dmub_status dmub_srv_set_skip_panel_power_sequence(struct dmub_srv *dmub,
 	return DMUB_STATUS_OK;
 }
 
+enum dmub_status dmub_srv_cmd_with_reply_data(struct dmub_srv *dmub,
+					      union dmub_rb_cmd *cmd)
+{
+	enum dmub_status status = DMUB_STATUS_OK;
+
+	// Queue command
+	status = dmub_srv_cmd_queue(dmub, cmd);
+
+	if (status != DMUB_STATUS_OK)
+		return status;
+
+	// Execute command
+	status = dmub_srv_cmd_execute(dmub);
+
+	if (status != DMUB_STATUS_OK)
+		return status;
+
+	// Wait for DMUB to process command
+	status = dmub_srv_wait_for_idle(dmub, 100000);
+
+	if (status != DMUB_STATUS_OK)
+		return status;
+
+	// Copy data back from ring buffer into command
+	dmub_rb_get_return_data(&dmub->inbox1_rb, cmd);
+
+	return status;
+}
+
 static inline bool dmub_rb_out_trace_buffer_front(struct dmub_rb *rb,
 				 void *entry)
 {
@@ -1211,105 +1160,47 @@ void dmub_srv_subvp_save_surf_addr(struct dmub_srv *dmub, const struct dc_plane_
 	}
 }
 
-void dmub_srv_set_power_state(struct dmub_srv *dmub, enum dmub_srv_power_state_type dmub_srv_power_state)
-{
-	if (!dmub || !dmub->hw_init)
-		return;
-
-	dmub->power_state = dmub_srv_power_state;
-}
 
-enum dmub_status dmub_srv_reg_cmd_execute(struct dmub_srv *dmub, union dmub_rb_cmd *cmd)
+enum dmub_status dmub_srv_send_reg_inbox0_cmd(
+		struct dmub_srv *dmub,
+		union dmub_rb_cmd *cmd,
+		bool with_reply, uint32_t timeout_us)
 {
-	uint32_t num_pending = 0;
-
-	if (!dmub->hw_init)
-		return DMUB_STATUS_INVALID;
-
-	if (dmub->power_state != DMUB_POWER_STATE_D0)
-		return DMUB_STATUS_POWER_STATE_D3;
-
-	if (!dmub->hw_funcs.send_reg_inbox0_cmd_msg ||
-			!dmub->hw_funcs.clear_reg_inbox0_rsp_int_ack)
-		return DMUB_STATUS_INVALID;
-
-	if (dmub->reg_inbox0.num_submitted >= dmub->reg_inbox0.num_reported)
-		num_pending = dmub->reg_inbox0.num_submitted - dmub->reg_inbox0.num_reported;
-	else
-		/* num_submitted wrapped */
-		num_pending = DMUB_REG_INBOX0_RB_MAX_ENTRY -
-				(dmub->reg_inbox0.num_reported - dmub->reg_inbox0.num_submitted);
-
-	if (num_pending >= DMUB_REG_INBOX0_RB_MAX_ENTRY)
-		return DMUB_STATUS_QUEUE_FULL;
+	uint32_t rsp_ready = 0;
+	uint32_t i;
 
-	/* clear last rsp ack and send message */
-	dmub->hw_funcs.clear_reg_inbox0_rsp_int_ack(dmub);
 	dmub->hw_funcs.send_reg_inbox0_cmd_msg(dmub, cmd);
 
-	dmub->reg_inbox0.num_submitted++;
-	dmub->reg_inbox0.is_pending = true;
-	dmub->reg_inbox0.is_multi_pending = cmd->cmd_common.header.multi_cmd_pending;
-
-	return DMUB_STATUS_OK;
-}
-
-void dmub_srv_cmd_get_response(struct dmub_srv *dmub,
-		union dmub_rb_cmd *cmd_rsp)
-{
-	if (dmub) {
-		if (dmub->inbox_type == DMUB_CMD_INTERFACE_REG &&
-				dmub->hw_funcs.read_reg_inbox0_cmd_rsp) {
-			dmub->hw_funcs.read_reg_inbox0_cmd_rsp(dmub, cmd_rsp);
-		} else {
-			dmub_rb_get_return_data(&dmub->inbox1.rb, cmd_rsp);
-		}
+	for (i = 0; i < timeout_us; i++) {
+		rsp_ready = dmub->hw_funcs.read_reg_inbox0_rsp_int_status(dmub);
+		if (rsp_ready)
+			break;
+		udelay(1);
 	}
-}
-
-static enum dmub_status dmub_srv_sync_reg_inbox0(struct dmub_srv *dmub)
-{
-	if (!dmub || !dmub->sw_init)
-		return DMUB_STATUS_INVALID;
-
-	dmub->reg_inbox0.is_pending = 0;
-	dmub->reg_inbox0.is_multi_pending = 0;
-
-	return DMUB_STATUS_OK;
-}
+	if (rsp_ready == 0)
+		return DMUB_STATUS_TIMEOUT;
 
-static enum dmub_status dmub_srv_sync_inbox1(struct dmub_srv *dmub)
-{
-	if (!dmub->sw_init)
-		return DMUB_STATUS_INVALID;
+	if (with_reply)
+		dmub->hw_funcs.read_reg_inbox0_cmd_rsp(dmub, cmd);
 
-	if (dmub->hw_funcs.get_inbox1_rptr && dmub->hw_funcs.get_inbox1_wptr) {
-		uint32_t rptr = dmub->hw_funcs.get_inbox1_rptr(dmub);
-		uint32_t wptr = dmub->hw_funcs.get_inbox1_wptr(dmub);
+	dmub->hw_funcs.write_reg_inbox0_rsp_int_ack(dmub);
 
-		if (rptr > dmub->inbox1.rb.capacity || wptr > dmub->inbox1.rb.capacity) {
-			return DMUB_STATUS_HW_FAILURE;
-		} else {
-			dmub->inbox1.rb.rptr = rptr;
-			dmub->inbox1.rb.wrpt = wptr;
-			dmub->inbox1_last_wptr = dmub->inbox1.rb.wrpt;
-		}
+	/* wait for rsp int status is cleared to initial state before exit */
+	for (; i <= timeout_us; i++) {
+		rsp_ready = dmub->hw_funcs.read_reg_inbox0_rsp_int_status(dmub);
+		if (rsp_ready == 0)
+			break;
+		udelay(1);
 	}
+	ASSERT(rsp_ready == 0);
 
 	return DMUB_STATUS_OK;
 }
 
-enum dmub_status dmub_srv_sync_inboxes(struct dmub_srv *dmub)
+void dmub_srv_set_power_state(struct dmub_srv *dmub, enum dmub_srv_power_state_type dmub_srv_power_state)
 {
-	enum dmub_status status;
-
-	status = dmub_srv_sync_reg_inbox0(dmub);
-	if (status != DMUB_STATUS_OK)
-		return status;
-
-	status = dmub_srv_sync_inbox1(dmub);
-	if (status != DMUB_STATUS_OK)
-		return status;
+	if (!dmub || !dmub->hw_init)
+		return;
 
-	return DMUB_STATUS_OK;
+	dmub->power_state = dmub_srv_power_state;
 }
-- 
2.43.0

