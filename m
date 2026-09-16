Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0F3EC982D2
	for <amd-gfx@archiver.kernel.org>; Wed, 16 Sep 2026 17:53:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 00B6C10ED1F;
	Wed, 16 Sep 2026 17:53:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="i9OF8kjX";
	dkim-atps=neutral
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010057.outbound.protection.outlook.com [52.101.61.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 884C710ECC3
 for <amd-gfx@lists.freedesktop.org>; Wed, 16 Sep 2026 17:53:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=obSOg9q4GYR7WhK789+XQsc0tmh7SCvIQmpEcxuECHj4R5Dzu9G83EcP+yrUD4kSZJO51hYmukDsAUCiWEbsjvsUbda3pKySNofb9kDw4LyLck5s+J/IEEDB+BtCN58+r9G+ar28w/i33jU9aNbVb4ORn1c/HCfGDwsMIZEgvxcP2CvE8+joDUy0nQH3tDP9M/R12i31Duh2X7FIYwr+LK4Qde7gRvyv6R2eNhSxh973XyaxX2YbANosSI3MinUK9wWjQMa04q2Paclkv2qBzxAWuZHNUsgqOvvO7n0pGU4MsLSZrFyGeazGG6B69r4KaB+IoPQmuw9XowrzUw/3cA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b29Pr+rom/87UehBEE998aetkdYpdyngjqtp1bMhGhM=;
 b=leVZGd/hWiaZ/UBniqE+jGHCbD6TWgPR34nA+fQQtArElyoHtsI/CwOS4RYYJSIbF4n6qJ36+c8OR5G8jaiZTuysC8e7L0IFjihwzbUZ2Fmo6BDyvR3Rw//dqUdF+2kOdKsVIAR2UbGLZ0QWvGSTR/Aq7WlO87IilBW/lOWF4CHd4+U0U2rudAfpZG2Mu6/6bYod/034u9HSnQZhHbmUGeFg0V7pRBgmB0O3zWDcPddTEmAiMyRDrkZ3w496GzhtkJHo8jrHkAClwW/3QjyLi7E3uD8NgquL7nF1nBcUSBvZKwteZGzvc3ANixMrGYHgl35ae7y162ENolw3+8P1hg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b29Pr+rom/87UehBEE998aetkdYpdyngjqtp1bMhGhM=;
 b=i9OF8kjXFnHIIZV9hzOZYqV7bZK8wS1QyoiBNnjOl7mAwqct+W/+m07CmWUQ4lwK4EerLe4jPJC/nCxJpAVNlGeh4iKf+GIJRSdSDovLVlTN43kOWYrAweCD+SgZPc2iUgfclI1A86/DhwXcCvqdCtNdx7mnKBIZpXLk41LDRZo=
Received: from CH0PR03CA0193.namprd03.prod.outlook.com (2603:10b6:610:e4::18)
 by BY5PR12MB4260.namprd12.prod.outlook.com (2603:10b6:a03:206::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Wed, 16 Sep
 2026 17:52:58 +0000
Received: from CH3PEPF00000010.namprd04.prod.outlook.com
 (2603:10b6:610:e4:cafe::3d) by CH0PR03CA0193.outlook.office365.com
 (2603:10b6:610:e4::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.428.11 via Frontend Transport; Wed,
 16 Sep 2026 17:52:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH3PEPF00000010.mail.protection.outlook.com (10.167.244.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.428.7 via Frontend Transport; Wed, 16 Sep 2026 17:52:58 +0000
Received: from georzhanmkm.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Wed, 16 Sep
 2026 12:52:45 -0500
From: George Zhang <george.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Dillon Varone <Dillon.Varone@amd.com>, "Nicholas
 Kazlauskas" <nicholas.kazlauskas@amd.com>, Aric Cyr <aric.cyr@amd.com>,
 "George Zhang" <george.zhang@amd.com>
Subject: [PATCH 41/64] drm/amd/display: Add more diagnostic logs for DMU
Date: Wed, 16 Sep 2026 13:51:56 -0400
Message-ID: <20260916175301.368306-42-george.zhang@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH3PEPF00000010:EE_|BY5PR12MB4260:EE_
X-MS-Office365-Filtering-Correlation-Id: 90d97607-7269-4996-da1e-08df141b580d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|1800799024|23010399003|82310400026|376014|11063799006|6133799003|56012099006|10067099003|3023799007|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: f8d+TpyRienDQqrp8XW2jKaboCEHiuw8rpGeiSb1y7wpX5s8oLao/p8SkVs/F+Ms/Gttth8HkCA5/uhXO+Q1Xf0oVaimph4deycGLMASu63Qbp7RXaNt0+ZO6eahXZzLmehDdUMVnazafVq/0ZAtqs1Mf2P3xbVKof6f8IMQknfKzAj2AFBFw2xOUSURMLMsB/IrgQEuHJpeoH+Jcdf5mN5bAnayHIc4C7W8yWyF+MQpZ3JiyNUbRQkZGTIZCpER8Wd/jISfghDQnTXzLnw7dqkmUFrB/aq3iQ052PatG+FtjSAwNYAocUSROEkXaX09uAQZC0uw21MFaNfwwyHfhxPd41ijrTdNLKMdgjQFLn335RREnu52ijU8FhrPZhlATmmeeo/92s7/fQE8ervkOGX9oWauwjILXmKD9/4DwFzNh11pUkeSCSODe8BcHTOBhC6Xz/3jNV3brddcsAbJUh0Xi1VPvO/5c5+P80zS8NGKCWlD6kyE1hWEknBIk/OiW7a7xqKz144jlyomssXlfeOXf/nSv3yPul15UuOjKswuPyw5az9Vu9akLDIIe9EpUBMNXaHZI+QcuQRaJwcCo+4Cm14jQTYtk1SKWR5lVf46NicwqwQXhwEHlvcoYhvWyYiIHInfloYfNXNkA2H5+v9J/I4naO+1h6bj5uthSNREMVNZTTcZ6UxF/MqJbQQH8ODh9YONyKQQpq6If2No0A==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(1800799024)(23010399003)(82310400026)(376014)(11063799006)(6133799003)(56012099006)(10067099003)(3023799007)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: EujtDhyEVvRCajEp3dAIPMCwm8kco/ORoxeh4Ze/hWpezdiu9Qac58hgR9tqwTFBS8WdWExzI+wB78GYUmhMS+IYzMeVWqtzhaaX3oNxe3wHeKoiVCgjZOHCePCjWAcgPrL7HlujBFDFeBSLkX3gY+1P6mMbsRP0hW1j686n1yNX8skVBg8awd+XhOGPtGtSAwG6pJRizxqnRAJBM70ymddcu9ziojtKd2M6selUv4h4ZvdUM0+EGEXb8tixfWqHUmr7xrcbVklHxNzINO2sUIh4eLrrFYOM/mzUeoqblqCT6n6+BfD1/+NMco/bdqUq4NY0oh10L/JopjQ7wQ19q44BaE8HBoXyrmo5BDL8NrvxqhwuEXF/f9cqWAQFIFhPU2r+VpjQ1SIh1Lt2vbHuOL5VW+i1VFgUaRT4uQOM1gl+5OqbQnm0m36WRO3rpUW6
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2026 17:52:58.3327 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 90d97607-7269-4996-da1e-08df141b580d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF00000010.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4260
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

From: Dillon Varone <Dillon.Varone@amd.com>

[WHY&HOW]
Adds diagnostic logs for recent DMU traces.

Reviewed-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Reviewed-by: Aric Cyr <aric.cyr@amd.com>
Signed-off-by: Dillon Varone <Dillon.Varone@amd.com>
Signed-off-by: George Zhang <george.zhang@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c  | 125 ++++++++++++------
 drivers/gpu/drm/amd/display/dmub/dmub_srv.h   |  58 +++++++-
 .../gpu/drm/amd/display/dmub/src/dmub_dcn20.c |  84 ++++++------
 .../gpu/drm/amd/display/dmub/src/dmub_dcn20.h |   2 +-
 .../gpu/drm/amd/display/dmub/src/dmub_dcn31.c |  94 +++++++------
 .../gpu/drm/amd/display/dmub/src/dmub_dcn31.h |   2 +-
 .../gpu/drm/amd/display/dmub/src/dmub_dcn32.c |  94 +++++++------
 .../gpu/drm/amd/display/dmub/src/dmub_dcn32.h |   2 +-
 .../gpu/drm/amd/display/dmub/src/dmub_dcn35.c |  94 +++++++------
 .../gpu/drm/amd/display/dmub/src/dmub_dcn35.h |   2 +-
 .../drm/amd/display/dmub/src/dmub_dcn401.c    |  98 +++++++-------
 .../drm/amd/display/dmub/src/dmub_dcn401.h    |   2 +-
 .../gpu/drm/amd/display/dmub/src/dmub_dcn42.c |  98 +++++++-------
 .../gpu/drm/amd/display/dmub/src/dmub_dcn42.h |   2 +-
 .../gpu/drm/amd/display/dmub/src/dmub_dcn60.c |  98 +++++++-------
 .../gpu/drm/amd/display/dmub/src/dmub_dcn60.h |   2 +-
 .../gpu/drm/amd/display/dmub/src/dmub_srv.c   |  54 +++++++-
 17 files changed, 511 insertions(+), 400 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c b/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
index 1e7071f8d53f..37248ecc3c08 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
+++ b/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
@@ -273,6 +273,49 @@ bool dc_dmub_srv_cmd_list_queue_execute(struct dc_dmub_srv *dc_dmub_srv,
 	return dc_dmub_srv_cmd_list_queue_execute_timeout(dc_dmub_srv, count, cmd_list, DMUB_CMD_DEFAULT_MAX_WAIT_US);
 }
 
+static void dc_dmub_srv_log_timeout(const struct dc_dmub_srv *dc_dmub_srv,
+		struct dmub_timeout_info *timeout_info,
+		union dmub_rb_cmd *cmd)
+{
+	struct dmub_srv *dmub;
+
+	if (!dc_dmub_srv || !dc_dmub_srv->dmub)
+		return;
+
+	dmub = dc_dmub_srv->dmub;
+
+	// timeout already ocurred, do not overwrite
+	if (timeout_info->timeout_occured)
+		return;
+
+	timeout_info->timeout_occured = true;
+	if (cmd)
+		timeout_info->timeout_cmd = *cmd;
+	timeout_info->timestamp = dm_get_timestamp(dc_dmub_srv->ctx);
+
+	// capture last trace entries from the DMCUB trace buffer
+	dmub_srv_get_trace_snapshot(dmub,
+			&timeout_info->trace_snapshot);
+}
+
+static void dc_dmub_srv_log_timeouts(struct dc_dmub_srv *dc_dmub_srv,
+		union dmub_rb_cmd *cmd)
+{
+	struct dmub_srv *dmub;
+
+	if (!dc_dmub_srv || !dc_dmub_srv->dmub)
+		return;
+
+	dmub = dc_dmub_srv->dmub;
+
+	// log if this is the first timeout
+	dc_dmub_srv_log_timeout(dc_dmub_srv, &dmub->debug.first_timeout_info, cmd);
+
+	// clear valid flag and log latest timeout
+	dmub->debug.latest_timeout_info.timeout_occured = false;
+	dc_dmub_srv_log_timeout(dc_dmub_srv, &dmub->debug.latest_timeout_info, cmd);
+}
+
 bool dc_dmub_srv_wait_for_idle(struct dc_dmub_srv *dc_dmub_srv,
 		enum dm_dmub_wait_type wait_type,
 		union dmub_rb_cmd *cmd_list,
@@ -294,12 +337,8 @@ bool dc_dmub_srv_wait_for_idle(struct dc_dmub_srv *dc_dmub_srv,
 
 		if (status != DMUB_STATUS_OK) {
 			DC_LOG_DEBUG("No reply for DMUB command: status=%d\n", status);
-			if (!dmub->debug.timeout_info.timeout_occured) {
-				dmub->debug.timeout_info.timeout_occured = true;
-				if (cmd_list)
-					dmub->debug.timeout_info.timeout_cmd = *cmd_list;
-				dmub->debug.timeout_info.timestamp = dm_get_timestamp(dc_dmub_srv->ctx);
-			}
+
+			dc_dmub_srv_log_timeouts(dc_dmub_srv, cmd_list);
 			dc_dmub_srv_handle_failure(dc_dmub_srv);
 			return false;
 		}
@@ -985,44 +1024,44 @@ void dc_dmub_srv_log_diagnostic_data(struct dc_dmub_srv *dc_dmub_srv)
 	}
 
 	DC_LOG_DEBUG("DMCUB STATE:");
-	DC_LOG_DEBUG("    dmcub_version      : %08x", dc_dmub_srv->dmub->debug.dmcub_version);
-	DC_LOG_DEBUG("    scratch  [0]       : %08x", dc_dmub_srv->dmub->debug.scratch[0]);
-	DC_LOG_DEBUG("    scratch  [1]       : %08x", dc_dmub_srv->dmub->debug.scratch[1]);
-	DC_LOG_DEBUG("    scratch  [2]       : %08x", dc_dmub_srv->dmub->debug.scratch[2]);
-	DC_LOG_DEBUG("    scratch  [3]       : %08x", dc_dmub_srv->dmub->debug.scratch[3]);
-	DC_LOG_DEBUG("    scratch  [4]       : %08x", dc_dmub_srv->dmub->debug.scratch[4]);
-	DC_LOG_DEBUG("    scratch  [5]       : %08x", dc_dmub_srv->dmub->debug.scratch[5]);
-	DC_LOG_DEBUG("    scratch  [6]       : %08x", dc_dmub_srv->dmub->debug.scratch[6]);
-	DC_LOG_DEBUG("    scratch  [7]       : %08x", dc_dmub_srv->dmub->debug.scratch[7]);
-	DC_LOG_DEBUG("    scratch  [8]       : %08x", dc_dmub_srv->dmub->debug.scratch[8]);
-	DC_LOG_DEBUG("    scratch  [9]       : %08x", dc_dmub_srv->dmub->debug.scratch[9]);
-	DC_LOG_DEBUG("    scratch [10]       : %08x", dc_dmub_srv->dmub->debug.scratch[10]);
-	DC_LOG_DEBUG("    scratch [11]       : %08x", dc_dmub_srv->dmub->debug.scratch[11]);
-	DC_LOG_DEBUG("    scratch [12]       : %08x", dc_dmub_srv->dmub->debug.scratch[12]);
-	DC_LOG_DEBUG("    scratch [13]       : %08x", dc_dmub_srv->dmub->debug.scratch[13]);
-	DC_LOG_DEBUG("    scratch [14]       : %08x", dc_dmub_srv->dmub->debug.scratch[14]);
-	DC_LOG_DEBUG("    scratch [15]       : %08x", dc_dmub_srv->dmub->debug.scratch[15]);
+	DC_LOG_DEBUG("    dmcub_version      : %08x", dc_dmub_srv->dmub->debug.hw.dmcub_version);
+	DC_LOG_DEBUG("    scratch  [0]       : %08x", dc_dmub_srv->dmub->debug.hw.scratch[0]);
+	DC_LOG_DEBUG("    scratch  [1]       : %08x", dc_dmub_srv->dmub->debug.hw.scratch[1]);
+	DC_LOG_DEBUG("    scratch  [2]       : %08x", dc_dmub_srv->dmub->debug.hw.scratch[2]);
+	DC_LOG_DEBUG("    scratch  [3]       : %08x", dc_dmub_srv->dmub->debug.hw.scratch[3]);
+	DC_LOG_DEBUG("    scratch  [4]       : %08x", dc_dmub_srv->dmub->debug.hw.scratch[4]);
+	DC_LOG_DEBUG("    scratch  [5]       : %08x", dc_dmub_srv->dmub->debug.hw.scratch[5]);
+	DC_LOG_DEBUG("    scratch  [6]       : %08x", dc_dmub_srv->dmub->debug.hw.scratch[6]);
+	DC_LOG_DEBUG("    scratch  [7]       : %08x", dc_dmub_srv->dmub->debug.hw.scratch[7]);
+	DC_LOG_DEBUG("    scratch  [8]       : %08x", dc_dmub_srv->dmub->debug.hw.scratch[8]);
+	DC_LOG_DEBUG("    scratch  [9]       : %08x", dc_dmub_srv->dmub->debug.hw.scratch[9]);
+	DC_LOG_DEBUG("    scratch [10]       : %08x", dc_dmub_srv->dmub->debug.hw.scratch[10]);
+	DC_LOG_DEBUG("    scratch [11]       : %08x", dc_dmub_srv->dmub->debug.hw.scratch[11]);
+	DC_LOG_DEBUG("    scratch [12]       : %08x", dc_dmub_srv->dmub->debug.hw.scratch[12]);
+	DC_LOG_DEBUG("    scratch [13]       : %08x", dc_dmub_srv->dmub->debug.hw.scratch[13]);
+	DC_LOG_DEBUG("    scratch [14]       : %08x", dc_dmub_srv->dmub->debug.hw.scratch[14]);
+	DC_LOG_DEBUG("    scratch [15]       : %08x", dc_dmub_srv->dmub->debug.hw.scratch[15]);
 	for (i = 0; i < DMUB_PC_SNAPSHOT_COUNT; i++)
-		DC_LOG_DEBUG("    pc[%d]             : %08x", i, dc_dmub_srv->dmub->debug.pc[i]);
-	DC_LOG_DEBUG("    unk_fault_addr     : %08x", dc_dmub_srv->dmub->debug.undefined_address_fault_addr);
-	DC_LOG_DEBUG("    inst_fault_addr    : %08x", dc_dmub_srv->dmub->debug.inst_fetch_fault_addr);
-	DC_LOG_DEBUG("    data_fault_addr    : %08x", dc_dmub_srv->dmub->debug.data_write_fault_addr);
-	DC_LOG_DEBUG("    inbox1_rptr        : %08x", dc_dmub_srv->dmub->debug.inbox1_rptr);
-	DC_LOG_DEBUG("    inbox1_wptr        : %08x", dc_dmub_srv->dmub->debug.inbox1_wptr);
-	DC_LOG_DEBUG("    inbox1_size        : %08x", dc_dmub_srv->dmub->debug.inbox1_size);
-	DC_LOG_DEBUG("    inbox0_rptr        : %08x", dc_dmub_srv->dmub->debug.inbox0_rptr);
-	DC_LOG_DEBUG("    inbox0_wptr        : %08x", dc_dmub_srv->dmub->debug.inbox0_wptr);
-	DC_LOG_DEBUG("    inbox0_size        : %08x", dc_dmub_srv->dmub->debug.inbox0_size);
-	DC_LOG_DEBUG("    outbox1_rptr       : %08x", dc_dmub_srv->dmub->debug.outbox1_rptr);
-	DC_LOG_DEBUG("    outbox1_wptr       : %08x", dc_dmub_srv->dmub->debug.outbox1_wptr);
-	DC_LOG_DEBUG("    outbox1_size       : %08x", dc_dmub_srv->dmub->debug.outbox1_size);
-	DC_LOG_DEBUG("    is_enabled         : %d", dc_dmub_srv->dmub->debug.is_dmcub_enabled);
-	DC_LOG_DEBUG("    is_soft_reset      : %d", dc_dmub_srv->dmub->debug.is_dmcub_soft_reset);
-	DC_LOG_DEBUG("    is_secure_reset    : %d", dc_dmub_srv->dmub->debug.is_dmcub_secure_reset);
-	DC_LOG_DEBUG("    is_traceport_en    : %d", dc_dmub_srv->dmub->debug.is_traceport_en);
-	DC_LOG_DEBUG("    is_cw0_en          : %d", dc_dmub_srv->dmub->debug.is_cw0_enabled);
-	DC_LOG_DEBUG("    is_cw6_en          : %d", dc_dmub_srv->dmub->debug.is_cw6_enabled);
-	DC_LOG_DEBUG("    is_pwait           : %d", dc_dmub_srv->dmub->debug.is_pwait);
+		DC_LOG_DEBUG("    pc[%d]             : %08x", i, dc_dmub_srv->dmub->debug.hw.pc[i]);
+	DC_LOG_DEBUG("    unk_fault_addr     : %08x", dc_dmub_srv->dmub->debug.hw.undefined_address_fault_addr);
+	DC_LOG_DEBUG("    inst_fault_addr    : %08x", dc_dmub_srv->dmub->debug.hw.inst_fetch_fault_addr);
+	DC_LOG_DEBUG("    data_fault_addr    : %08x", dc_dmub_srv->dmub->debug.hw.data_write_fault_addr);
+	DC_LOG_DEBUG("    inbox1_rptr        : %08x", dc_dmub_srv->dmub->debug.hw.inbox1_rptr);
+	DC_LOG_DEBUG("    inbox1_wptr        : %08x", dc_dmub_srv->dmub->debug.hw.inbox1_wptr);
+	DC_LOG_DEBUG("    inbox1_size        : %08x", dc_dmub_srv->dmub->debug.hw.inbox1_size);
+	DC_LOG_DEBUG("    inbox0_rptr        : %08x", dc_dmub_srv->dmub->debug.hw.inbox0_rptr);
+	DC_LOG_DEBUG("    inbox0_wptr        : %08x", dc_dmub_srv->dmub->debug.hw.inbox0_wptr);
+	DC_LOG_DEBUG("    inbox0_size        : %08x", dc_dmub_srv->dmub->debug.hw.inbox0_size);
+	DC_LOG_DEBUG("    outbox1_rptr       : %08x", dc_dmub_srv->dmub->debug.hw.outbox1_rptr);
+	DC_LOG_DEBUG("    outbox1_wptr       : %08x", dc_dmub_srv->dmub->debug.hw.outbox1_wptr);
+	DC_LOG_DEBUG("    outbox1_size       : %08x", dc_dmub_srv->dmub->debug.hw.outbox1_size);
+	DC_LOG_DEBUG("    is_enabled         : %d", dc_dmub_srv->dmub->debug.hw.is_dmcub_enabled);
+	DC_LOG_DEBUG("    is_soft_reset      : %d", dc_dmub_srv->dmub->debug.hw.is_dmcub_soft_reset);
+	DC_LOG_DEBUG("    is_secure_reset    : %d", dc_dmub_srv->dmub->debug.hw.is_dmcub_secure_reset);
+	DC_LOG_DEBUG("    is_traceport_en    : %d", dc_dmub_srv->dmub->debug.hw.is_traceport_en);
+	DC_LOG_DEBUG("    is_cw0_en          : %d", dc_dmub_srv->dmub->debug.hw.is_cw0_enabled);
+	DC_LOG_DEBUG("    is_cw6_en          : %d", dc_dmub_srv->dmub->debug.hw.is_cw6_enabled);
+	DC_LOG_DEBUG("    is_pwait           : %d", dc_dmub_srv->dmub->debug.hw.is_pwait);
 }
 
 bool dc_dmub_should_update_cursor_data(struct pipe_ctx *pipe_ctx)
diff --git a/drivers/gpu/drm/amd/display/dmub/dmub_srv.h b/drivers/gpu/drm/amd/display/dmub/dmub_srv.h
index a5222ffc8ab6..17579ff2e1bf 100644
--- a/drivers/gpu/drm/amd/display/dmub/dmub_srv.h
+++ b/drivers/gpu/drm/amd/display/dmub/dmub_srv.h
@@ -69,6 +69,7 @@
 #include "dc/dc_types.h"
 
 #define DMUB_PC_SNAPSHOT_COUNT 10
+#define DMUB_TRACE_SNAPSHOT_COUNT 8
 
 /* Default tracebuffer size if meta is absent. */
 #define DMUB_TRACE_BUFFER_SIZE (64 * 1024)
@@ -81,6 +82,7 @@ struct dmub_srv;
 struct dmub_srv_common_regs;
 struct dmub_srv_dcn31_regs;
 
+struct dmcub_trace_buf;
 struct dmcub_trace_buf_entry;
 
 /* enum dmub_window_memory_type - memory location type specification for windows */
@@ -358,6 +360,26 @@ struct dmub_srv_hw_params {
 	bool disable_dpia_bw_allocation;
 };
 
+#define DMUB_TIMEOUT_TRACE_COUNT 8
+
+/**
+ * struct dmub_trace_buf_header - Header for the DMUB trace buffer
+ * @entry_count: Number of valid entries in the trace buffer
+ * @reserved: Reserved for future use
+ */
+struct dmub_trace_buf_header {
+	uint32_t entry_count;
+	uint32_t reserved[3];
+};
+
+/**
+ * struct dmub_trace_snapshot - Snapshot of the DMUB trace buffer
+ * @traces: Array of trace buffer entries
+ */
+struct dmub_trace_snapshot {
+	struct dmcub_trace_buf_entry traces[DMUB_TRACE_SNAPSHOT_COUNT];
+};
+
 /**
  * struct dmub_srv_debug - Debug info for dmub_srv
  * @timeout_occured: Indicates a timeout occured on any message from driver to dmub
@@ -367,13 +389,13 @@ struct dmub_timeout_info {
 	bool timeout_occured;
 	union dmub_rb_cmd timeout_cmd;
 	unsigned long long timestamp;
+	struct dmub_trace_snapshot trace_snapshot;
 };
 
 /**
- * struct dmub_diagnostic_data - Diagnostic data retrieved from DMCUB for
- * debugging purposes, including logging, crash analysis, etc.
+ * struct dmub_hw_diagnostic_data - Hardware diagnostic data for the DMUB
  */
-struct dmub_diagnostic_data {
+struct dmub_hw_diagnostic_data {
 	uint32_t dmcub_version;
 	uint32_t scratch[17];
 	uint32_t pc[DMUB_PC_SNAPSHOT_COUNT];
@@ -390,7 +412,6 @@ struct dmub_diagnostic_data {
 	uint32_t outbox1_wptr;
 	uint32_t outbox1_size;
 	uint32_t gpint_datain0;
-	struct dmub_timeout_info timeout_info;
 	uint8_t is_dmcub_enabled : 1;
 	uint8_t is_dmcub_soft_reset : 1;
 	uint8_t is_dmcub_secure_reset : 1;
@@ -400,6 +421,17 @@ struct dmub_diagnostic_data {
 	uint8_t is_pwait : 1;
 };
 
+/**
+ * struct dmub_diagnostic_data - Diagnostic data retrieved from DMCUB for
+ * debugging purposes, including logging, crash analysis, etc.
+ */
+struct dmub_diagnostic_data {
+	struct dmub_hw_diagnostic_data hw;
+	struct dmub_timeout_info first_timeout_info;
+	struct dmub_timeout_info latest_timeout_info;
+	struct dmub_trace_snapshot trace_snapshot;
+};
+
 /**
  * struct dmub_preos_info - preos fw info before loading post os fw.
  */
@@ -537,7 +569,7 @@ struct dmub_srv_hw_funcs {
 	void (*send_inbox0_cmd)(struct dmub_srv *dmub, union dmub_inbox0_data_register data);
 	uint32_t (*get_current_time)(struct dmub_srv *dmub);
 
-	void (*get_diagnostic_data)(struct dmub_srv *dmub);
+	void (*get_diagnostic_data)(struct dmub_srv *dmub, struct dmub_hw_diagnostic_data *hw_data);
 	bool (*get_preos_fw_info)(struct dmub_srv *dmub);
 
 	bool (*should_detect)(struct dmub_srv *dmub);
@@ -992,6 +1024,14 @@ enum dmub_status dmub_srv_set_skip_panel_power_sequence(struct dmub_srv *dmub,
 
 bool dmub_srv_get_outbox0_msg(struct dmub_srv *dmub, struct dmcub_trace_buf_entry *entry);
 
+/**
+ * dmub_srv_get_diagnostic_data() - Get diagnostic data from the DMUB.
+ * @dmub: the dmub service
+ *
+ * Returns:
+ *   true - if the diagnostic data was successfully retrieved
+ *   false - otherwise
+ */
 bool dmub_srv_get_diagnostic_data(struct dmub_srv *dmub);
 
 bool dmub_srv_should_detect(struct dmub_srv *dmub);
@@ -1151,4 +1191,12 @@ bool dmub_srv_get_preos_info(struct dmub_srv *dmub);
 enum dmub_status dmub_srv_get_fw_meta_info_from_raw_fw(struct dmub_srv_fw_meta_info_params *params,
 						       struct dmub_fw_meta_info *fw_info_out);
 
+/**
+ * dmub_srv_get_trace_snapshot() - Fetch the latest trace entries from the DMCUB trace buffer
+ * @dmub: the dmub service
+ * @trace_snapshot: output buffer for trace entries
+ *
+ */
+void dmub_srv_get_trace_snapshot(struct dmub_srv *dmub, struct dmub_trace_snapshot *trace_snapshot);
+
 #endif /* _DMUB_SRV_H_ */
diff --git a/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn20.c b/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn20.c
index 0b152926f75b..08c23ca47094 100644
--- a/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn20.c
+++ b/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn20.c
@@ -416,72 +416,68 @@ uint32_t dmub_dcn20_get_current_time(struct dmub_srv *dmub)
 	return REG_READ(DMCUB_TIMER_CURRENT);
 }
 
-void dmub_dcn20_get_diagnostic_data(struct dmub_srv *dmub)
+void dmub_dcn20_get_diagnostic_data(struct dmub_srv *dmub, struct dmub_hw_diagnostic_data *hw_data)
 {
 	uint32_t is_dmub_enabled, is_soft_reset, is_sec_reset;
 	uint32_t is_traceport_enabled, is_cw0_enabled, is_cw6_enabled;
-	struct dmub_timeout_info timeout = {0};
 
-	if (!dmub)
+	if (!dmub || !hw_data)
 		return;
 
-	/* timeout data filled externally, cache before resetting memory */
-	timeout = dmub->debug.timeout_info;
-	memset(&dmub->debug, 0, sizeof(dmub->debug));
-	dmub->debug.timeout_info = timeout;
-
-	dmub->debug.dmcub_version = dmub->fw_version;
-
-	dmub->debug.scratch[0] = REG_READ(DMCUB_SCRATCH0);
-	dmub->debug.scratch[1] = REG_READ(DMCUB_SCRATCH1);
-	dmub->debug.scratch[2] = REG_READ(DMCUB_SCRATCH2);
-	dmub->debug.scratch[3] = REG_READ(DMCUB_SCRATCH3);
-	dmub->debug.scratch[4] = REG_READ(DMCUB_SCRATCH4);
-	dmub->debug.scratch[5] = REG_READ(DMCUB_SCRATCH5);
-	dmub->debug.scratch[6] = REG_READ(DMCUB_SCRATCH6);
-	dmub->debug.scratch[7] = REG_READ(DMCUB_SCRATCH7);
-	dmub->debug.scratch[8] = REG_READ(DMCUB_SCRATCH8);
-	dmub->debug.scratch[9] = REG_READ(DMCUB_SCRATCH9);
-	dmub->debug.scratch[10] = REG_READ(DMCUB_SCRATCH10);
-	dmub->debug.scratch[11] = REG_READ(DMCUB_SCRATCH11);
-	dmub->debug.scratch[12] = REG_READ(DMCUB_SCRATCH12);
-	dmub->debug.scratch[13] = REG_READ(DMCUB_SCRATCH13);
-	dmub->debug.scratch[14] = REG_READ(DMCUB_SCRATCH14);
-	dmub->debug.scratch[15] = REG_READ(DMCUB_SCRATCH15);
-
-	dmub->debug.undefined_address_fault_addr = REG_READ(DMCUB_UNDEFINED_ADDRESS_FAULT_ADDR);
-	dmub->debug.inst_fetch_fault_addr = REG_READ(DMCUB_INST_FETCH_FAULT_ADDR);
-	dmub->debug.data_write_fault_addr = REG_READ(DMCUB_DATA_WRITE_FAULT_ADDR);
-
-	dmub->debug.inbox1_rptr = REG_READ(DMCUB_INBOX1_RPTR);
-	dmub->debug.inbox1_wptr = REG_READ(DMCUB_INBOX1_WPTR);
-	dmub->debug.inbox1_size = REG_READ(DMCUB_INBOX1_SIZE);
-
-	dmub->debug.inbox0_rptr = REG_READ(DMCUB_INBOX0_RPTR);
-	dmub->debug.inbox0_wptr = REG_READ(DMCUB_INBOX0_WPTR);
-	dmub->debug.inbox0_size = REG_READ(DMCUB_INBOX0_SIZE);
+	memset(hw_data, 0, sizeof(*hw_data));
+
+	hw_data->dmcub_version = dmub->fw_version;
+
+	hw_data->scratch[0] = REG_READ(DMCUB_SCRATCH0);
+	hw_data->scratch[1] = REG_READ(DMCUB_SCRATCH1);
+	hw_data->scratch[2] = REG_READ(DMCUB_SCRATCH2);
+	hw_data->scratch[3] = REG_READ(DMCUB_SCRATCH3);
+	hw_data->scratch[4] = REG_READ(DMCUB_SCRATCH4);
+	hw_data->scratch[5] = REG_READ(DMCUB_SCRATCH5);
+	hw_data->scratch[6] = REG_READ(DMCUB_SCRATCH6);
+	hw_data->scratch[7] = REG_READ(DMCUB_SCRATCH7);
+	hw_data->scratch[8] = REG_READ(DMCUB_SCRATCH8);
+	hw_data->scratch[9] = REG_READ(DMCUB_SCRATCH9);
+	hw_data->scratch[10] = REG_READ(DMCUB_SCRATCH10);
+	hw_data->scratch[11] = REG_READ(DMCUB_SCRATCH11);
+	hw_data->scratch[12] = REG_READ(DMCUB_SCRATCH12);
+	hw_data->scratch[13] = REG_READ(DMCUB_SCRATCH13);
+	hw_data->scratch[14] = REG_READ(DMCUB_SCRATCH14);
+	hw_data->scratch[15] = REG_READ(DMCUB_SCRATCH15);
+
+	hw_data->undefined_address_fault_addr = REG_READ(DMCUB_UNDEFINED_ADDRESS_FAULT_ADDR);
+	hw_data->inst_fetch_fault_addr = REG_READ(DMCUB_INST_FETCH_FAULT_ADDR);
+	hw_data->data_write_fault_addr = REG_READ(DMCUB_DATA_WRITE_FAULT_ADDR);
+
+	hw_data->inbox1_rptr = REG_READ(DMCUB_INBOX1_RPTR);
+	hw_data->inbox1_wptr = REG_READ(DMCUB_INBOX1_WPTR);
+	hw_data->inbox1_size = REG_READ(DMCUB_INBOX1_SIZE);
+
+	hw_data->inbox0_rptr = REG_READ(DMCUB_INBOX0_RPTR);
+	hw_data->inbox0_wptr = REG_READ(DMCUB_INBOX0_WPTR);
+	hw_data->inbox0_size = REG_READ(DMCUB_INBOX0_SIZE);
 
 	REG_GET(DMCUB_CNTL, DMCUB_ENABLE, &is_dmub_enabled);
 	ASSERT(is_dmub_enabled <= 0xFF);
-	dmub->debug.is_dmcub_enabled = (uint8_t)is_dmub_enabled;
+	hw_data->is_dmcub_enabled = (uint8_t)is_dmub_enabled;
 
 	REG_GET(DMCUB_CNTL, DMCUB_SOFT_RESET, &is_soft_reset);
 	ASSERT(is_soft_reset <= 0xFF);
-	dmub->debug.is_dmcub_soft_reset = (uint8_t)is_soft_reset;
+	hw_data->is_dmcub_soft_reset = (uint8_t)is_soft_reset;
 
 	REG_GET(DMCUB_SEC_CNTL, DMCUB_SEC_RESET_STATUS, &is_sec_reset);
 	ASSERT(is_sec_reset <= 0xFF);
-	dmub->debug.is_dmcub_secure_reset = (uint8_t)is_sec_reset;
+	hw_data->is_dmcub_secure_reset = (uint8_t)is_sec_reset;
 
 	REG_GET(DMCUB_CNTL, DMCUB_TRACEPORT_EN, &is_traceport_enabled);
 	ASSERT(is_traceport_enabled <= 0xFF);
-	dmub->debug.is_traceport_en  = (uint8_t)is_traceport_enabled;
+	hw_data->is_traceport_en  = (uint8_t)is_traceport_enabled;
 
 	REG_GET(DMCUB_REGION3_CW0_TOP_ADDRESS, DMCUB_REGION3_CW0_ENABLE, &is_cw0_enabled);
 	ASSERT(is_cw0_enabled <= 0xFF);
-	dmub->debug.is_cw0_enabled = (uint8_t)is_cw0_enabled;
+	hw_data->is_cw0_enabled = (uint8_t)is_cw0_enabled;
 
 	REG_GET(DMCUB_REGION3_CW6_TOP_ADDRESS, DMCUB_REGION3_CW6_ENABLE, &is_cw6_enabled);
 	ASSERT(is_cw6_enabled <= 0xFF);
-	dmub->debug.is_cw6_enabled = (uint8_t)is_cw6_enabled;
+	hw_data->is_cw6_enabled = (uint8_t)is_cw6_enabled;
 }
diff --git a/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn20.h b/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn20.h
index 42c1fb4bc73f..fd89d341573b 100644
--- a/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn20.h
+++ b/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn20.h
@@ -247,6 +247,6 @@ bool dmub_dcn20_use_cached_trace_buffer(struct dmub_srv *dmub);
 
 uint32_t dmub_dcn20_get_current_time(struct dmub_srv *dmub);
 
-void dmub_dcn20_get_diagnostic_data(struct dmub_srv *dmub);
+void dmub_dcn20_get_diagnostic_data(struct dmub_srv *dmub, struct dmub_hw_diagnostic_data *hw_data);
 
 #endif /* _DMUB_DCN20_H_ */
diff --git a/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn31.c b/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn31.c
index 478d79a6e246..cd0ba8d41357 100644
--- a/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn31.c
+++ b/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn31.c
@@ -418,82 +418,78 @@ uint32_t dmub_dcn31_get_current_time(struct dmub_srv *dmub)
 	return REG_READ(DMCUB_TIMER_CURRENT);
 }
 
-void dmub_dcn31_get_diagnostic_data(struct dmub_srv *dmub)
+void dmub_dcn31_get_diagnostic_data(struct dmub_srv *dmub, struct dmub_hw_diagnostic_data *hw_data)
 {
 	uint32_t is_dmub_enabled, is_soft_reset, is_sec_reset, is_pwait;
 	uint32_t is_traceport_enabled, is_cw0_enabled, is_cw6_enabled;
-	struct dmub_timeout_info timeout = {0};
 
-	if (!dmub)
+	if (!dmub || !hw_data)
 		return;
 
-	/* timeout data filled externally, cache before resetting memory */
-	timeout = dmub->debug.timeout_info;
-	memset(&dmub->debug, 0, sizeof(dmub->debug));
-	dmub->debug.timeout_info = timeout;
-
-	dmub->debug.dmcub_version = dmub->fw_version;
-
-	dmub->debug.scratch[0] = REG_READ(DMCUB_SCRATCH0);
-	dmub->debug.scratch[1] = REG_READ(DMCUB_SCRATCH1);
-	dmub->debug.scratch[2] = REG_READ(DMCUB_SCRATCH2);
-	dmub->debug.scratch[3] = REG_READ(DMCUB_SCRATCH3);
-	dmub->debug.scratch[4] = REG_READ(DMCUB_SCRATCH4);
-	dmub->debug.scratch[5] = REG_READ(DMCUB_SCRATCH5);
-	dmub->debug.scratch[6] = REG_READ(DMCUB_SCRATCH6);
-	dmub->debug.scratch[7] = REG_READ(DMCUB_SCRATCH7);
-	dmub->debug.scratch[8] = REG_READ(DMCUB_SCRATCH8);
-	dmub->debug.scratch[9] = REG_READ(DMCUB_SCRATCH9);
-	dmub->debug.scratch[10] = REG_READ(DMCUB_SCRATCH10);
-	dmub->debug.scratch[11] = REG_READ(DMCUB_SCRATCH11);
-	dmub->debug.scratch[12] = REG_READ(DMCUB_SCRATCH12);
-	dmub->debug.scratch[13] = REG_READ(DMCUB_SCRATCH13);
-	dmub->debug.scratch[14] = REG_READ(DMCUB_SCRATCH14);
-	dmub->debug.scratch[15] = REG_READ(DMCUB_SCRATCH15);
-
-	dmub->debug.undefined_address_fault_addr = REG_READ(DMCUB_UNDEFINED_ADDRESS_FAULT_ADDR);
-	dmub->debug.inst_fetch_fault_addr = REG_READ(DMCUB_INST_FETCH_FAULT_ADDR);
-	dmub->debug.data_write_fault_addr = REG_READ(DMCUB_DATA_WRITE_FAULT_ADDR);
-
-	dmub->debug.inbox1_rptr = REG_READ(DMCUB_INBOX1_RPTR);
-	dmub->debug.inbox1_wptr = REG_READ(DMCUB_INBOX1_WPTR);
-	dmub->debug.inbox1_size = REG_READ(DMCUB_INBOX1_SIZE);
-
-	dmub->debug.inbox0_rptr = REG_READ(DMCUB_INBOX0_RPTR);
-	dmub->debug.inbox0_wptr = REG_READ(DMCUB_INBOX0_WPTR);
-	dmub->debug.inbox0_size = REG_READ(DMCUB_INBOX0_SIZE);
-
-	dmub->debug.outbox1_rptr = REG_READ(DMCUB_OUTBOX1_RPTR);
-	dmub->debug.outbox1_wptr = REG_READ(DMCUB_OUTBOX1_WPTR);
-	dmub->debug.outbox1_size = REG_READ(DMCUB_OUTBOX1_SIZE);
+	memset(hw_data, 0, sizeof(*hw_data));
+
+	hw_data->dmcub_version = dmub->fw_version;
+
+	hw_data->scratch[0] = REG_READ(DMCUB_SCRATCH0);
+	hw_data->scratch[1] = REG_READ(DMCUB_SCRATCH1);
+	hw_data->scratch[2] = REG_READ(DMCUB_SCRATCH2);
+	hw_data->scratch[3] = REG_READ(DMCUB_SCRATCH3);
+	hw_data->scratch[4] = REG_READ(DMCUB_SCRATCH4);
+	hw_data->scratch[5] = REG_READ(DMCUB_SCRATCH5);
+	hw_data->scratch[6] = REG_READ(DMCUB_SCRATCH6);
+	hw_data->scratch[7] = REG_READ(DMCUB_SCRATCH7);
+	hw_data->scratch[8] = REG_READ(DMCUB_SCRATCH8);
+	hw_data->scratch[9] = REG_READ(DMCUB_SCRATCH9);
+	hw_data->scratch[10] = REG_READ(DMCUB_SCRATCH10);
+	hw_data->scratch[11] = REG_READ(DMCUB_SCRATCH11);
+	hw_data->scratch[12] = REG_READ(DMCUB_SCRATCH12);
+	hw_data->scratch[13] = REG_READ(DMCUB_SCRATCH13);
+	hw_data->scratch[14] = REG_READ(DMCUB_SCRATCH14);
+	hw_data->scratch[15] = REG_READ(DMCUB_SCRATCH15);
+
+	hw_data->undefined_address_fault_addr = REG_READ(DMCUB_UNDEFINED_ADDRESS_FAULT_ADDR);
+	hw_data->inst_fetch_fault_addr = REG_READ(DMCUB_INST_FETCH_FAULT_ADDR);
+	hw_data->data_write_fault_addr = REG_READ(DMCUB_DATA_WRITE_FAULT_ADDR);
+
+	hw_data->inbox1_rptr = REG_READ(DMCUB_INBOX1_RPTR);
+	hw_data->inbox1_wptr = REG_READ(DMCUB_INBOX1_WPTR);
+	hw_data->inbox1_size = REG_READ(DMCUB_INBOX1_SIZE);
+
+	hw_data->inbox0_rptr = REG_READ(DMCUB_INBOX0_RPTR);
+	hw_data->inbox0_wptr = REG_READ(DMCUB_INBOX0_WPTR);
+	hw_data->inbox0_size = REG_READ(DMCUB_INBOX0_SIZE);
+
+	hw_data->outbox1_rptr = REG_READ(DMCUB_OUTBOX1_RPTR);
+	hw_data->outbox1_wptr = REG_READ(DMCUB_OUTBOX1_WPTR);
+	hw_data->outbox1_size = REG_READ(DMCUB_OUTBOX1_SIZE);
 
 	REG_GET(DMCUB_CNTL, DMCUB_ENABLE, &is_dmub_enabled);
 	ASSERT(is_dmub_enabled <= 0xFF);
-	dmub->debug.is_dmcub_enabled = (uint8_t)is_dmub_enabled;
+	hw_data->is_dmcub_enabled = (uint8_t)is_dmub_enabled;
 
 	REG_GET(DMCUB_CNTL, DMCUB_PWAIT_MODE_STATUS, &is_pwait);
 	ASSERT(is_pwait <= 0xFF);
-	dmub->debug.is_pwait = (uint8_t)is_pwait;
+	hw_data->is_pwait = (uint8_t)is_pwait;
 
 	REG_GET(DMCUB_CNTL2, DMCUB_SOFT_RESET, &is_soft_reset);
 	ASSERT(is_soft_reset <= 0xFF);
-	dmub->debug.is_dmcub_soft_reset = (uint8_t)is_soft_reset;
+	hw_data->is_dmcub_soft_reset = (uint8_t)is_soft_reset;
 
 	REG_GET(DMCUB_SEC_CNTL, DMCUB_SEC_RESET_STATUS, &is_sec_reset);
 	ASSERT(is_sec_reset <= 0xFF);
-	dmub->debug.is_dmcub_secure_reset = (uint8_t)is_sec_reset;
+	hw_data->is_dmcub_secure_reset = (uint8_t)is_sec_reset;
 
 	REG_GET(DMCUB_CNTL, DMCUB_TRACEPORT_EN, &is_traceport_enabled);
 	ASSERT(is_traceport_enabled <= 0xFF);
-	dmub->debug.is_traceport_en  = (uint8_t)is_traceport_enabled;
+	hw_data->is_traceport_en  = (uint8_t)is_traceport_enabled;
 
 	REG_GET(DMCUB_REGION3_CW0_TOP_ADDRESS, DMCUB_REGION3_CW0_ENABLE, &is_cw0_enabled);
 	ASSERT(is_cw0_enabled <= 0xFF);
-	dmub->debug.is_cw0_enabled = (uint8_t)is_cw0_enabled;
+	hw_data->is_cw0_enabled = (uint8_t)is_cw0_enabled;
 
 	REG_GET(DMCUB_REGION3_CW6_TOP_ADDRESS, DMCUB_REGION3_CW6_ENABLE, &is_cw6_enabled);
 	ASSERT(is_cw6_enabled <= 0xFF);
-	dmub->debug.is_cw6_enabled = (uint8_t)is_cw6_enabled;
+	hw_data->is_cw6_enabled = (uint8_t)is_cw6_enabled;
 }
 
 bool dmub_dcn31_should_detect(struct dmub_srv *dmub)
diff --git a/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn31.h b/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn31.h
index 1c43ef2bca66..ec878c58d09b 100644
--- a/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn31.h
+++ b/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn31.h
@@ -251,7 +251,7 @@ void dmub_dcn31_set_outbox0_rptr(struct dmub_srv *dmub, uint32_t rptr_offset);
 
 uint32_t dmub_dcn31_get_current_time(struct dmub_srv *dmub);
 
-void dmub_dcn31_get_diagnostic_data(struct dmub_srv *dmub);
+void dmub_dcn31_get_diagnostic_data(struct dmub_srv *dmub, struct dmub_hw_diagnostic_data *hw_data);
 
 bool dmub_dcn31_should_detect(struct dmub_srv *dmub);
 
diff --git a/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn32.c b/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn32.c
index 3f9fb9e05b79..0d585dc63364 100644
--- a/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn32.c
+++ b/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn32.c
@@ -437,77 +437,73 @@ uint32_t dmub_dcn32_get_current_time(struct dmub_srv *dmub)
 	return REG_READ(DMCUB_TIMER_CURRENT);
 }
 
-void dmub_dcn32_get_diagnostic_data(struct dmub_srv *dmub)
+void dmub_dcn32_get_diagnostic_data(struct dmub_srv *dmub, struct dmub_hw_diagnostic_data *hw_data)
 {
 	uint32_t is_dmub_enabled, is_soft_reset, is_pwait;
 	uint32_t is_traceport_enabled, is_cw6_enabled;
-	struct dmub_timeout_info timeout = {0};
 
-	if (!dmub)
+	if (!dmub || !hw_data)
 		return;
 
-	/* timeout data filled externally, cache before resetting memory */
-	timeout = dmub->debug.timeout_info;
-	memset(&dmub->debug, 0, sizeof(dmub->debug));
-	dmub->debug.timeout_info = timeout;
-
-	dmub->debug.dmcub_version = dmub->fw_version;
-
-	dmub->debug.scratch[0] = REG_READ(DMCUB_SCRATCH0);
-	dmub->debug.scratch[1] = REG_READ(DMCUB_SCRATCH1);
-	dmub->debug.scratch[2] = REG_READ(DMCUB_SCRATCH2);
-	dmub->debug.scratch[3] = REG_READ(DMCUB_SCRATCH3);
-	dmub->debug.scratch[4] = REG_READ(DMCUB_SCRATCH4);
-	dmub->debug.scratch[5] = REG_READ(DMCUB_SCRATCH5);
-	dmub->debug.scratch[6] = REG_READ(DMCUB_SCRATCH6);
-	dmub->debug.scratch[7] = REG_READ(DMCUB_SCRATCH7);
-	dmub->debug.scratch[8] = REG_READ(DMCUB_SCRATCH8);
-	dmub->debug.scratch[9] = REG_READ(DMCUB_SCRATCH9);
-	dmub->debug.scratch[10] = REG_READ(DMCUB_SCRATCH10);
-	dmub->debug.scratch[11] = REG_READ(DMCUB_SCRATCH11);
-	dmub->debug.scratch[12] = REG_READ(DMCUB_SCRATCH12);
-	dmub->debug.scratch[13] = REG_READ(DMCUB_SCRATCH13);
-	dmub->debug.scratch[14] = REG_READ(DMCUB_SCRATCH14);
-	dmub->debug.scratch[15] = REG_READ(DMCUB_SCRATCH15);
-	dmub->debug.scratch[16] = REG_READ(DMCUB_SCRATCH16);
-
-	dmub->debug.undefined_address_fault_addr = REG_READ(DMCUB_UNDEFINED_ADDRESS_FAULT_ADDR);
-	dmub->debug.inst_fetch_fault_addr = REG_READ(DMCUB_INST_FETCH_FAULT_ADDR);
-	dmub->debug.data_write_fault_addr = REG_READ(DMCUB_DATA_WRITE_FAULT_ADDR);
-
-	dmub->debug.inbox1_rptr = REG_READ(DMCUB_INBOX1_RPTR);
-	dmub->debug.inbox1_wptr = REG_READ(DMCUB_INBOX1_WPTR);
-	dmub->debug.inbox1_size = REG_READ(DMCUB_INBOX1_SIZE);
-
-	dmub->debug.inbox0_rptr = REG_READ(DMCUB_INBOX0_RPTR);
-	dmub->debug.inbox0_wptr = REG_READ(DMCUB_INBOX0_WPTR);
-	dmub->debug.inbox0_size = REG_READ(DMCUB_INBOX0_SIZE);
-
-	dmub->debug.outbox1_rptr = REG_READ(DMCUB_OUTBOX1_RPTR);
-	dmub->debug.outbox1_wptr = REG_READ(DMCUB_OUTBOX1_WPTR);
-	dmub->debug.outbox1_size = REG_READ(DMCUB_OUTBOX1_SIZE);
+	memset(hw_data, 0, sizeof(*hw_data));
+
+	hw_data->dmcub_version = dmub->fw_version;
+
+	hw_data->scratch[0] = REG_READ(DMCUB_SCRATCH0);
+	hw_data->scratch[1] = REG_READ(DMCUB_SCRATCH1);
+	hw_data->scratch[2] = REG_READ(DMCUB_SCRATCH2);
+	hw_data->scratch[3] = REG_READ(DMCUB_SCRATCH3);
+	hw_data->scratch[4] = REG_READ(DMCUB_SCRATCH4);
+	hw_data->scratch[5] = REG_READ(DMCUB_SCRATCH5);
+	hw_data->scratch[6] = REG_READ(DMCUB_SCRATCH6);
+	hw_data->scratch[7] = REG_READ(DMCUB_SCRATCH7);
+	hw_data->scratch[8] = REG_READ(DMCUB_SCRATCH8);
+	hw_data->scratch[9] = REG_READ(DMCUB_SCRATCH9);
+	hw_data->scratch[10] = REG_READ(DMCUB_SCRATCH10);
+	hw_data->scratch[11] = REG_READ(DMCUB_SCRATCH11);
+	hw_data->scratch[12] = REG_READ(DMCUB_SCRATCH12);
+	hw_data->scratch[13] = REG_READ(DMCUB_SCRATCH13);
+	hw_data->scratch[14] = REG_READ(DMCUB_SCRATCH14);
+	hw_data->scratch[15] = REG_READ(DMCUB_SCRATCH15);
+	hw_data->scratch[16] = REG_READ(DMCUB_SCRATCH16);
+
+	hw_data->undefined_address_fault_addr = REG_READ(DMCUB_UNDEFINED_ADDRESS_FAULT_ADDR);
+	hw_data->inst_fetch_fault_addr = REG_READ(DMCUB_INST_FETCH_FAULT_ADDR);
+	hw_data->data_write_fault_addr = REG_READ(DMCUB_DATA_WRITE_FAULT_ADDR);
+
+	hw_data->inbox1_rptr = REG_READ(DMCUB_INBOX1_RPTR);
+	hw_data->inbox1_wptr = REG_READ(DMCUB_INBOX1_WPTR);
+	hw_data->inbox1_size = REG_READ(DMCUB_INBOX1_SIZE);
+
+	hw_data->inbox0_rptr = REG_READ(DMCUB_INBOX0_RPTR);
+	hw_data->inbox0_wptr = REG_READ(DMCUB_INBOX0_WPTR);
+	hw_data->inbox0_size = REG_READ(DMCUB_INBOX0_SIZE);
+
+	hw_data->outbox1_rptr = REG_READ(DMCUB_OUTBOX1_RPTR);
+	hw_data->outbox1_wptr = REG_READ(DMCUB_OUTBOX1_WPTR);
+	hw_data->outbox1_size = REG_READ(DMCUB_OUTBOX1_SIZE);
 
 	REG_GET(DMCUB_CNTL, DMCUB_ENABLE, &is_dmub_enabled);
 	ASSERT(is_dmub_enabled <= 0xFF);
-	dmub->debug.is_dmcub_enabled = (uint8_t)is_dmub_enabled;
+	hw_data->is_dmcub_enabled = (uint8_t)is_dmub_enabled;
 
 	REG_GET(DMCUB_CNTL, DMCUB_PWAIT_MODE_STATUS, &is_pwait);
 	ASSERT(is_pwait <= 0xFF);
-	dmub->debug.is_pwait = (uint8_t)is_pwait;
+	hw_data->is_pwait = (uint8_t)is_pwait;
 
 	REG_GET(DMCUB_CNTL2, DMCUB_SOFT_RESET, &is_soft_reset);
 	ASSERT(is_soft_reset <= 0xFF);
-	dmub->debug.is_dmcub_soft_reset = (uint8_t)is_soft_reset;
+	hw_data->is_dmcub_soft_reset = (uint8_t)is_soft_reset;
 
 	REG_GET(DMCUB_CNTL, DMCUB_TRACEPORT_EN, &is_traceport_enabled);
 	ASSERT(is_traceport_enabled <= 0xFF);
-	dmub->debug.is_traceport_en  = (uint8_t)is_traceport_enabled;
+	hw_data->is_traceport_en  = (uint8_t)is_traceport_enabled;
 
 	REG_GET(DMCUB_REGION3_CW6_TOP_ADDRESS, DMCUB_REGION3_CW6_ENABLE, &is_cw6_enabled);
 	ASSERT(is_cw6_enabled <= 0xFF);
-	dmub->debug.is_cw6_enabled = (uint8_t)is_cw6_enabled;
+	hw_data->is_cw6_enabled = (uint8_t)is_cw6_enabled;
 
-	dmub->debug.gpint_datain0 = REG_READ(DMCUB_GPINT_DATAIN0);
+	hw_data->gpint_datain0 = REG_READ(DMCUB_GPINT_DATAIN0);
 }
 void dmub_dcn32_configure_dmub_in_system_memory(struct dmub_srv *dmub)
 {
diff --git a/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn32.h b/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn32.h
index daf81027d663..ccf849e07b38 100644
--- a/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn32.h
+++ b/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn32.h
@@ -260,7 +260,7 @@ void dmub_dcn32_set_outbox0_rptr(struct dmub_srv *dmub, uint32_t rptr_offset);
 
 uint32_t dmub_dcn32_get_current_time(struct dmub_srv *dmub);
 
-void dmub_dcn32_get_diagnostic_data(struct dmub_srv *dmub);
+void dmub_dcn32_get_diagnostic_data(struct dmub_srv *dmub, struct dmub_hw_diagnostic_data *hw_data);
 
 void dmub_dcn32_configure_dmub_in_system_memory(struct dmub_srv *dmub);
 void dmub_dcn32_send_inbox0_cmd(struct dmub_srv *dmub, union dmub_inbox0_data_register data);
diff --git a/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn35.c b/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn35.c
index 69fb6084232e..bd7637276aa6 100644
--- a/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn35.c
+++ b/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn35.c
@@ -458,77 +458,73 @@ uint32_t dmub_dcn35_get_current_time(struct dmub_srv *dmub)
 	return REG_READ(DMCUB_TIMER_CURRENT);
 }
 
-void dmub_dcn35_get_diagnostic_data(struct dmub_srv *dmub)
+void dmub_dcn35_get_diagnostic_data(struct dmub_srv *dmub, struct dmub_hw_diagnostic_data *hw_data)
 {
 	uint32_t is_dmub_enabled, is_soft_reset, is_pwait;
 	uint32_t is_traceport_enabled, is_cw6_enabled;
-	struct dmub_timeout_info timeout = {0};
 
-	if (!dmub)
+	if (!dmub || !hw_data)
 		return;
 
-	/* timeout data filled externally, cache before resetting memory */
-	timeout = dmub->debug.timeout_info;
-	memset(&dmub->debug, 0, sizeof(dmub->debug));
-	dmub->debug.timeout_info = timeout;
-
-	dmub->debug.dmcub_version = dmub->fw_version;
-
-	dmub->debug.scratch[0] = REG_READ(DMCUB_SCRATCH0);
-	dmub->debug.scratch[1] = REG_READ(DMCUB_SCRATCH1);
-	dmub->debug.scratch[2] = REG_READ(DMCUB_SCRATCH2);
-	dmub->debug.scratch[3] = REG_READ(DMCUB_SCRATCH3);
-	dmub->debug.scratch[4] = REG_READ(DMCUB_SCRATCH4);
-	dmub->debug.scratch[5] = REG_READ(DMCUB_SCRATCH5);
-	dmub->debug.scratch[6] = REG_READ(DMCUB_SCRATCH6);
-	dmub->debug.scratch[7] = REG_READ(DMCUB_SCRATCH7);
-	dmub->debug.scratch[8] = REG_READ(DMCUB_SCRATCH8);
-	dmub->debug.scratch[9] = REG_READ(DMCUB_SCRATCH9);
-	dmub->debug.scratch[10] = REG_READ(DMCUB_SCRATCH10);
-	dmub->debug.scratch[11] = REG_READ(DMCUB_SCRATCH11);
-	dmub->debug.scratch[12] = REG_READ(DMCUB_SCRATCH12);
-	dmub->debug.scratch[13] = REG_READ(DMCUB_SCRATCH13);
-	dmub->debug.scratch[14] = REG_READ(DMCUB_SCRATCH14);
-	dmub->debug.scratch[15] = REG_READ(DMCUB_SCRATCH15);
-	dmub->debug.scratch[16] = REG_READ(DMCUB_SCRATCH16);
-
-	dmub->debug.undefined_address_fault_addr = REG_READ(DMCUB_UNDEFINED_ADDRESS_FAULT_ADDR);
-	dmub->debug.inst_fetch_fault_addr = REG_READ(DMCUB_INST_FETCH_FAULT_ADDR);
-	dmub->debug.data_write_fault_addr = REG_READ(DMCUB_DATA_WRITE_FAULT_ADDR);
-
-	dmub->debug.inbox1_rptr = REG_READ(DMCUB_INBOX1_RPTR);
-	dmub->debug.inbox1_wptr = REG_READ(DMCUB_INBOX1_WPTR);
-	dmub->debug.inbox1_size = REG_READ(DMCUB_INBOX1_SIZE);
-
-	dmub->debug.inbox0_rptr = REG_READ(DMCUB_INBOX0_RPTR);
-	dmub->debug.inbox0_wptr = REG_READ(DMCUB_INBOX0_WPTR);
-	dmub->debug.inbox0_size = REG_READ(DMCUB_INBOX0_SIZE);
-
-	dmub->debug.outbox1_rptr = REG_READ(DMCUB_OUTBOX1_RPTR);
-	dmub->debug.outbox1_wptr = REG_READ(DMCUB_OUTBOX1_WPTR);
-	dmub->debug.outbox1_size = REG_READ(DMCUB_OUTBOX1_SIZE);
+	memset(hw_data, 0, sizeof(*hw_data));
+
+	hw_data->dmcub_version = dmub->fw_version;
+
+	hw_data->scratch[0] = REG_READ(DMCUB_SCRATCH0);
+	hw_data->scratch[1] = REG_READ(DMCUB_SCRATCH1);
+	hw_data->scratch[2] = REG_READ(DMCUB_SCRATCH2);
+	hw_data->scratch[3] = REG_READ(DMCUB_SCRATCH3);
+	hw_data->scratch[4] = REG_READ(DMCUB_SCRATCH4);
+	hw_data->scratch[5] = REG_READ(DMCUB_SCRATCH5);
+	hw_data->scratch[6] = REG_READ(DMCUB_SCRATCH6);
+	hw_data->scratch[7] = REG_READ(DMCUB_SCRATCH7);
+	hw_data->scratch[8] = REG_READ(DMCUB_SCRATCH8);
+	hw_data->scratch[9] = REG_READ(DMCUB_SCRATCH9);
+	hw_data->scratch[10] = REG_READ(DMCUB_SCRATCH10);
+	hw_data->scratch[11] = REG_READ(DMCUB_SCRATCH11);
+	hw_data->scratch[12] = REG_READ(DMCUB_SCRATCH12);
+	hw_data->scratch[13] = REG_READ(DMCUB_SCRATCH13);
+	hw_data->scratch[14] = REG_READ(DMCUB_SCRATCH14);
+	hw_data->scratch[15] = REG_READ(DMCUB_SCRATCH15);
+	hw_data->scratch[16] = REG_READ(DMCUB_SCRATCH16);
+
+	hw_data->undefined_address_fault_addr = REG_READ(DMCUB_UNDEFINED_ADDRESS_FAULT_ADDR);
+	hw_data->inst_fetch_fault_addr = REG_READ(DMCUB_INST_FETCH_FAULT_ADDR);
+	hw_data->data_write_fault_addr = REG_READ(DMCUB_DATA_WRITE_FAULT_ADDR);
+
+	hw_data->inbox1_rptr = REG_READ(DMCUB_INBOX1_RPTR);
+	hw_data->inbox1_wptr = REG_READ(DMCUB_INBOX1_WPTR);
+	hw_data->inbox1_size = REG_READ(DMCUB_INBOX1_SIZE);
+
+	hw_data->inbox0_rptr = REG_READ(DMCUB_INBOX0_RPTR);
+	hw_data->inbox0_wptr = REG_READ(DMCUB_INBOX0_WPTR);
+	hw_data->inbox0_size = REG_READ(DMCUB_INBOX0_SIZE);
+
+	hw_data->outbox1_rptr = REG_READ(DMCUB_OUTBOX1_RPTR);
+	hw_data->outbox1_wptr = REG_READ(DMCUB_OUTBOX1_WPTR);
+	hw_data->outbox1_size = REG_READ(DMCUB_OUTBOX1_SIZE);
 
 	REG_GET(DMCUB_CNTL, DMCUB_ENABLE, &is_dmub_enabled);
 	ASSERT(is_dmub_enabled <= 0xFF);
-	dmub->debug.is_dmcub_enabled = (uint8_t)is_dmub_enabled;
+	hw_data->is_dmcub_enabled = (uint8_t)is_dmub_enabled;
 
 	REG_GET(DMCUB_CNTL, DMCUB_PWAIT_MODE_STATUS, &is_pwait);
 	ASSERT(is_pwait <= 0xFF);
-	dmub->debug.is_pwait = (uint8_t)is_pwait;
+	hw_data->is_pwait = (uint8_t)is_pwait;
 
 	REG_GET(DMCUB_CNTL2, DMCUB_SOFT_RESET, &is_soft_reset);
 	ASSERT(is_soft_reset <= 0xFF);
-	dmub->debug.is_dmcub_soft_reset = (uint8_t)is_soft_reset;
+	hw_data->is_dmcub_soft_reset = (uint8_t)is_soft_reset;
 
 	REG_GET(DMCUB_CNTL, DMCUB_TRACEPORT_EN, &is_traceport_enabled);
 	ASSERT(is_traceport_enabled <= 0xFF);
-	dmub->debug.is_traceport_en  = (uint8_t)is_traceport_enabled;
+	hw_data->is_traceport_en  = (uint8_t)is_traceport_enabled;
 
 	REG_GET(DMCUB_REGION3_CW6_TOP_ADDRESS, DMCUB_REGION3_CW6_ENABLE, &is_cw6_enabled);
 	ASSERT(is_cw6_enabled <= 0xFF);
-	dmub->debug.is_cw6_enabled = (uint8_t)is_cw6_enabled;
+	hw_data->is_cw6_enabled = (uint8_t)is_cw6_enabled;
 
-	dmub->debug.gpint_datain0 = REG_READ(DMCUB_GPINT_DATAIN0);
+	hw_data->gpint_datain0 = REG_READ(DMCUB_GPINT_DATAIN0);
 }
 
 bool dmub_dcn35_get_preos_fw_info(struct dmub_srv *dmub)
diff --git a/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn35.h b/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn35.h
index 92e6695a2c9b..869095284993 100644
--- a/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn35.h
+++ b/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn35.h
@@ -269,7 +269,7 @@ void dmub_dcn35_set_outbox0_rptr(struct dmub_srv *dmub, uint32_t rptr_offset);
 
 uint32_t dmub_dcn35_get_current_time(struct dmub_srv *dmub);
 
-void dmub_dcn35_get_diagnostic_data(struct dmub_srv *dmub);
+void dmub_dcn35_get_diagnostic_data(struct dmub_srv *dmub, struct dmub_hw_diagnostic_data *hw_data);
 
 void dmub_dcn35_configure_dmub_in_system_memory(struct dmub_srv *dmub);
 
diff --git a/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn401.c b/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn401.c
index 3444eb7d7d81..02ab26516584 100644
--- a/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn401.c
+++ b/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn401.c
@@ -423,85 +423,81 @@ uint32_t dmub_dcn401_get_current_time(struct dmub_srv *dmub)
 	return REG_READ(DMCUB_TIMER_CURRENT);
 }
 
-void dmub_dcn401_get_diagnostic_data(struct dmub_srv *dmub)
+void dmub_dcn401_get_diagnostic_data(struct dmub_srv *dmub, struct dmub_hw_diagnostic_data *hw_data)
 {
 	uint32_t is_dmub_enabled, is_soft_reset, is_sec_reset, is_pwait;
 	uint32_t is_traceport_enabled, is_cw0_enabled, is_cw6_enabled;
-	struct dmub_timeout_info timeout = {0};
 
-	if (!dmub)
+	if (!dmub || !hw_data)
 		return;
 
-	/* timeout data filled externally, cache before resetting memory */
-	timeout = dmub->debug.timeout_info;
-	memset(&dmub->debug, 0, sizeof(dmub->debug));
-	dmub->debug.timeout_info = timeout;
-
-	dmub->debug.dmcub_version = dmub->fw_version;
-
-	dmub->debug.scratch[0] = REG_READ(DMCUB_SCRATCH0);
-	dmub->debug.scratch[1] = REG_READ(DMCUB_SCRATCH1);
-	dmub->debug.scratch[2] = REG_READ(DMCUB_SCRATCH2);
-	dmub->debug.scratch[3] = REG_READ(DMCUB_SCRATCH3);
-	dmub->debug.scratch[4] = REG_READ(DMCUB_SCRATCH4);
-	dmub->debug.scratch[5] = REG_READ(DMCUB_SCRATCH5);
-	dmub->debug.scratch[6] = REG_READ(DMCUB_SCRATCH6);
-	dmub->debug.scratch[7] = REG_READ(DMCUB_SCRATCH7);
-	dmub->debug.scratch[8] = REG_READ(DMCUB_SCRATCH8);
-	dmub->debug.scratch[9] = REG_READ(DMCUB_SCRATCH9);
-	dmub->debug.scratch[10] = REG_READ(DMCUB_SCRATCH10);
-	dmub->debug.scratch[11] = REG_READ(DMCUB_SCRATCH11);
-	dmub->debug.scratch[12] = REG_READ(DMCUB_SCRATCH12);
-	dmub->debug.scratch[13] = REG_READ(DMCUB_SCRATCH13);
-	dmub->debug.scratch[14] = REG_READ(DMCUB_SCRATCH14);
-	dmub->debug.scratch[15] = REG_READ(DMCUB_SCRATCH15);
-	dmub->debug.scratch[16] = REG_READ(DMCUB_SCRATCH16);
-
-	dmub->debug.undefined_address_fault_addr = REG_READ(DMCUB_UNDEFINED_ADDRESS_FAULT_ADDR);
-	dmub->debug.inst_fetch_fault_addr = REG_READ(DMCUB_INST_FETCH_FAULT_ADDR);
-	dmub->debug.data_write_fault_addr = REG_READ(DMCUB_DATA_WRITE_FAULT_ADDR);
-
-	dmub->debug.inbox1_rptr = REG_READ(DMCUB_INBOX1_RPTR);
-	dmub->debug.inbox1_wptr = REG_READ(DMCUB_INBOX1_WPTR);
-	dmub->debug.inbox1_size = REG_READ(DMCUB_INBOX1_SIZE);
-
-	dmub->debug.inbox0_rptr = REG_READ(DMCUB_INBOX0_RPTR);
-	dmub->debug.inbox0_wptr = REG_READ(DMCUB_INBOX0_WPTR);
-	dmub->debug.inbox0_size = REG_READ(DMCUB_INBOX0_SIZE);
-
-	dmub->debug.outbox1_rptr = REG_READ(DMCUB_OUTBOX1_RPTR);
-	dmub->debug.outbox1_wptr = REG_READ(DMCUB_OUTBOX1_WPTR);
-	dmub->debug.outbox1_size = REG_READ(DMCUB_OUTBOX1_SIZE);
+	memset(hw_data, 0, sizeof(*hw_data));
+
+	hw_data->dmcub_version = dmub->fw_version;
+
+	hw_data->scratch[0] = REG_READ(DMCUB_SCRATCH0);
+	hw_data->scratch[1] = REG_READ(DMCUB_SCRATCH1);
+	hw_data->scratch[2] = REG_READ(DMCUB_SCRATCH2);
+	hw_data->scratch[3] = REG_READ(DMCUB_SCRATCH3);
+	hw_data->scratch[4] = REG_READ(DMCUB_SCRATCH4);
+	hw_data->scratch[5] = REG_READ(DMCUB_SCRATCH5);
+	hw_data->scratch[6] = REG_READ(DMCUB_SCRATCH6);
+	hw_data->scratch[7] = REG_READ(DMCUB_SCRATCH7);
+	hw_data->scratch[8] = REG_READ(DMCUB_SCRATCH8);
+	hw_data->scratch[9] = REG_READ(DMCUB_SCRATCH9);
+	hw_data->scratch[10] = REG_READ(DMCUB_SCRATCH10);
+	hw_data->scratch[11] = REG_READ(DMCUB_SCRATCH11);
+	hw_data->scratch[12] = REG_READ(DMCUB_SCRATCH12);
+	hw_data->scratch[13] = REG_READ(DMCUB_SCRATCH13);
+	hw_data->scratch[14] = REG_READ(DMCUB_SCRATCH14);
+	hw_data->scratch[15] = REG_READ(DMCUB_SCRATCH15);
+	hw_data->scratch[16] = REG_READ(DMCUB_SCRATCH16);
+
+	hw_data->undefined_address_fault_addr = REG_READ(DMCUB_UNDEFINED_ADDRESS_FAULT_ADDR);
+	hw_data->inst_fetch_fault_addr = REG_READ(DMCUB_INST_FETCH_FAULT_ADDR);
+	hw_data->data_write_fault_addr = REG_READ(DMCUB_DATA_WRITE_FAULT_ADDR);
+
+	hw_data->inbox1_rptr = REG_READ(DMCUB_INBOX1_RPTR);
+	hw_data->inbox1_wptr = REG_READ(DMCUB_INBOX1_WPTR);
+	hw_data->inbox1_size = REG_READ(DMCUB_INBOX1_SIZE);
+
+	hw_data->inbox0_rptr = REG_READ(DMCUB_INBOX0_RPTR);
+	hw_data->inbox0_wptr = REG_READ(DMCUB_INBOX0_WPTR);
+	hw_data->inbox0_size = REG_READ(DMCUB_INBOX0_SIZE);
+
+	hw_data->outbox1_rptr = REG_READ(DMCUB_OUTBOX1_RPTR);
+	hw_data->outbox1_wptr = REG_READ(DMCUB_OUTBOX1_WPTR);
+	hw_data->outbox1_size = REG_READ(DMCUB_OUTBOX1_SIZE);
 
 	REG_GET(DMCUB_CNTL, DMCUB_ENABLE, &is_dmub_enabled);
 	ASSERT(is_dmub_enabled <= 0xFF);
-	dmub->debug.is_dmcub_enabled = (uint8_t)is_dmub_enabled;
+	hw_data->is_dmcub_enabled = (uint8_t)is_dmub_enabled;
 
 	REG_GET(DMCUB_CNTL, DMCUB_PWAIT_MODE_STATUS, &is_pwait);
 	ASSERT(is_pwait <= 0xFF);
-	dmub->debug.is_pwait = (uint8_t)is_pwait;
+	hw_data->is_pwait = (uint8_t)is_pwait;
 
 	REG_GET(DMCUB_CNTL2, DMCUB_SOFT_RESET, &is_soft_reset);
 	ASSERT(is_soft_reset <= 0xFF);
-	dmub->debug.is_dmcub_soft_reset = (uint8_t)is_soft_reset;
+	hw_data->is_dmcub_soft_reset = (uint8_t)is_soft_reset;
 
 	REG_GET(DMCUB_SEC_CNTL, DMCUB_SEC_RESET_STATUS, &is_sec_reset);
 	ASSERT(is_sec_reset <= 0xFF);
-	dmub->debug.is_dmcub_secure_reset = (uint8_t)is_sec_reset;
+	hw_data->is_dmcub_secure_reset = (uint8_t)is_sec_reset;
 
 	REG_GET(DMCUB_CNTL, DMCUB_TRACEPORT_EN, &is_traceport_enabled);
 	ASSERT(is_traceport_enabled <= 0xFF);
-	dmub->debug.is_traceport_en  = (uint8_t)is_traceport_enabled;
+	hw_data->is_traceport_en  = (uint8_t)is_traceport_enabled;
 
 	REG_GET(DMCUB_REGION3_CW0_TOP_ADDRESS, DMCUB_REGION3_CW0_ENABLE, &is_cw0_enabled);
 	ASSERT(is_cw0_enabled <= 0xFF);
-	dmub->debug.is_cw0_enabled = (uint8_t)is_cw0_enabled;
+	hw_data->is_cw0_enabled = (uint8_t)is_cw0_enabled;
 
 	REG_GET(DMCUB_REGION3_CW6_TOP_ADDRESS, DMCUB_REGION3_CW6_ENABLE, &is_cw6_enabled);
 	ASSERT(is_cw6_enabled <= 0xFF);
-	dmub->debug.is_cw6_enabled = (uint8_t)is_cw6_enabled;
+	hw_data->is_cw6_enabled = (uint8_t)is_cw6_enabled;
 
-	dmub->debug.gpint_datain0 = REG_READ(DMCUB_GPINT_DATAIN0);
+	hw_data->gpint_datain0 = REG_READ(DMCUB_GPINT_DATAIN0);
 }
 void dmub_dcn401_configure_dmub_in_system_memory(struct dmub_srv *dmub)
 {
diff --git a/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn401.h b/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn401.h
index 88c3a44d67d9..de7840d93592 100644
--- a/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn401.h
+++ b/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn401.h
@@ -264,7 +264,7 @@ void dmub_dcn401_set_outbox0_rptr(struct dmub_srv *dmub, uint32_t rptr_offset);
 
 uint32_t dmub_dcn401_get_current_time(struct dmub_srv *dmub);
 
-void dmub_dcn401_get_diagnostic_data(struct dmub_srv *dmub);
+void dmub_dcn401_get_diagnostic_data(struct dmub_srv *dmub, struct dmub_hw_diagnostic_data *hw_data);
 
 void dmub_dcn401_configure_dmub_in_system_memory(struct dmub_srv *dmub);
 void dmub_dcn401_send_inbox0_cmd(struct dmub_srv *dmub, union dmub_inbox0_data_register data);
diff --git a/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn42.c b/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn42.c
index e86fcfc74985..53e70c682a77 100644
--- a/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn42.c
+++ b/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn42.c
@@ -626,85 +626,81 @@ uint32_t dmub_dcn42_get_current_time(struct dmub_srv *dmub)
 	return REG_READ(DMCUB_TIMER_CURRENT);
 }
 
-void dmub_dcn42_get_diagnostic_data(struct dmub_srv *dmub)
+void dmub_dcn42_get_diagnostic_data(struct dmub_srv *dmub, struct dmub_hw_diagnostic_data *hw_data)
 {
 	uint32_t is_dmub_enabled, is_soft_reset, is_sec_reset, is_pwait;
 	uint32_t is_traceport_enabled, is_cw0_enabled, is_cw6_enabled;
-	struct dmub_timeout_info timeout = {0};
 
-	if (!dmub)
+	if (!dmub || !hw_data)
 		return;
 
-	/* timeout data filled externally, cache before resetting memory */
-	timeout = dmub->debug.timeout_info;
-	memset(&dmub->debug, 0, sizeof(dmub->debug));
-	dmub->debug.timeout_info = timeout;
-
-	dmub->debug.dmcub_version = dmub->fw_version;
-
-	dmub->debug.scratch[0] = REG_READ(DMCUB_SCRATCH0);
-	dmub->debug.scratch[1] = REG_READ(DMCUB_SCRATCH1);
-	dmub->debug.scratch[2] = REG_READ(DMCUB_SCRATCH2);
-	dmub->debug.scratch[3] = REG_READ(DMCUB_SCRATCH3);
-	dmub->debug.scratch[4] = REG_READ(DMCUB_SCRATCH4);
-	dmub->debug.scratch[5] = REG_READ(DMCUB_SCRATCH5);
-	dmub->debug.scratch[6] = REG_READ(DMCUB_SCRATCH6);
-	dmub->debug.scratch[7] = REG_READ(DMCUB_SCRATCH7);
-	dmub->debug.scratch[8] = REG_READ(DMCUB_SCRATCH8);
-	dmub->debug.scratch[9] = REG_READ(DMCUB_SCRATCH9);
-	dmub->debug.scratch[10] = REG_READ(DMCUB_SCRATCH10);
-	dmub->debug.scratch[11] = REG_READ(DMCUB_SCRATCH11);
-	dmub->debug.scratch[12] = REG_READ(DMCUB_SCRATCH12);
-	dmub->debug.scratch[13] = REG_READ(DMCUB_SCRATCH13);
-	dmub->debug.scratch[14] = REG_READ(DMCUB_SCRATCH14);
-	dmub->debug.scratch[15] = REG_READ(DMCUB_SCRATCH15);
-	dmub->debug.scratch[16] = REG_READ(DMCUB_SCRATCH16);
-
-	dmub->debug.undefined_address_fault_addr = REG_READ(DMCUB_UNDEFINED_ADDRESS_FAULT_ADDR);
-	dmub->debug.inst_fetch_fault_addr = REG_READ(DMCUB_INST_FETCH_FAULT_ADDR);
-	dmub->debug.data_write_fault_addr = REG_READ(DMCUB_DATA_WRITE_FAULT_ADDR);
-
-	dmub->debug.inbox1_rptr = REG_READ(DMCUB_INBOX1_RPTR);
-	dmub->debug.inbox1_wptr = REG_READ(DMCUB_INBOX1_WPTR);
-	dmub->debug.inbox1_size = REG_READ(DMCUB_INBOX1_SIZE);
-
-	dmub->debug.inbox0_rptr = REG_READ(DMCUB_INBOX0_RPTR);
-	dmub->debug.inbox0_wptr = REG_READ(DMCUB_INBOX0_WPTR);
-	dmub->debug.inbox0_size = REG_READ(DMCUB_INBOX0_SIZE);
-
-	dmub->debug.outbox1_rptr = REG_READ(DMCUB_OUTBOX1_RPTR);
-	dmub->debug.outbox1_wptr = REG_READ(DMCUB_OUTBOX1_WPTR);
-	dmub->debug.outbox1_size = REG_READ(DMCUB_OUTBOX1_SIZE);
+	memset(hw_data, 0, sizeof(*hw_data));
+
+	hw_data->dmcub_version = dmub->fw_version;
+
+	hw_data->scratch[0] = REG_READ(DMCUB_SCRATCH0);
+	hw_data->scratch[1] = REG_READ(DMCUB_SCRATCH1);
+	hw_data->scratch[2] = REG_READ(DMCUB_SCRATCH2);
+	hw_data->scratch[3] = REG_READ(DMCUB_SCRATCH3);
+	hw_data->scratch[4] = REG_READ(DMCUB_SCRATCH4);
+	hw_data->scratch[5] = REG_READ(DMCUB_SCRATCH5);
+	hw_data->scratch[6] = REG_READ(DMCUB_SCRATCH6);
+	hw_data->scratch[7] = REG_READ(DMCUB_SCRATCH7);
+	hw_data->scratch[8] = REG_READ(DMCUB_SCRATCH8);
+	hw_data->scratch[9] = REG_READ(DMCUB_SCRATCH9);
+	hw_data->scratch[10] = REG_READ(DMCUB_SCRATCH10);
+	hw_data->scratch[11] = REG_READ(DMCUB_SCRATCH11);
+	hw_data->scratch[12] = REG_READ(DMCUB_SCRATCH12);
+	hw_data->scratch[13] = REG_READ(DMCUB_SCRATCH13);
+	hw_data->scratch[14] = REG_READ(DMCUB_SCRATCH14);
+	hw_data->scratch[15] = REG_READ(DMCUB_SCRATCH15);
+	hw_data->scratch[16] = REG_READ(DMCUB_SCRATCH16);
+
+	hw_data->undefined_address_fault_addr = REG_READ(DMCUB_UNDEFINED_ADDRESS_FAULT_ADDR);
+	hw_data->inst_fetch_fault_addr = REG_READ(DMCUB_INST_FETCH_FAULT_ADDR);
+	hw_data->data_write_fault_addr = REG_READ(DMCUB_DATA_WRITE_FAULT_ADDR);
+
+	hw_data->inbox1_rptr = REG_READ(DMCUB_INBOX1_RPTR);
+	hw_data->inbox1_wptr = REG_READ(DMCUB_INBOX1_WPTR);
+	hw_data->inbox1_size = REG_READ(DMCUB_INBOX1_SIZE);
+
+	hw_data->inbox0_rptr = REG_READ(DMCUB_INBOX0_RPTR);
+	hw_data->inbox0_wptr = REG_READ(DMCUB_INBOX0_WPTR);
+	hw_data->inbox0_size = REG_READ(DMCUB_INBOX0_SIZE);
+
+	hw_data->outbox1_rptr = REG_READ(DMCUB_OUTBOX1_RPTR);
+	hw_data->outbox1_wptr = REG_READ(DMCUB_OUTBOX1_WPTR);
+	hw_data->outbox1_size = REG_READ(DMCUB_OUTBOX1_SIZE);
 
 	REG_GET(DMCUB_CNTL, DMCUB_ENABLE, &is_dmub_enabled);
 	ASSERT(is_dmub_enabled <= 0xFF);
-	dmub->debug.is_dmcub_enabled = (uint8_t)is_dmub_enabled;
+	hw_data->is_dmcub_enabled = (uint8_t)is_dmub_enabled;
 
 	REG_GET(DMCUB_CNTL, DMCUB_PWAIT_MODE_STATUS, &is_pwait);
 	ASSERT(is_pwait <= 0xFF);
-	dmub->debug.is_pwait = (uint8_t)is_pwait;
+	hw_data->is_pwait = (uint8_t)is_pwait;
 
 	REG_GET(DMCUB_CNTL2, DMCUB_SOFT_RESET, &is_soft_reset);
 	ASSERT(is_soft_reset <= 0xFF);
-	dmub->debug.is_dmcub_soft_reset = (uint8_t)is_soft_reset;
+	hw_data->is_dmcub_soft_reset = (uint8_t)is_soft_reset;
 
 	REG_GET(DMCUB_SEC_CNTL, DMCUB_SEC_RESET_STATUS, &is_sec_reset);
 	ASSERT(is_sec_reset <= 0xFF);
-	dmub->debug.is_dmcub_secure_reset = (uint8_t)is_sec_reset;
+	hw_data->is_dmcub_secure_reset = (uint8_t)is_sec_reset;
 
 	REG_GET(DMCUB_CNTL, DMCUB_TRACEPORT_EN, &is_traceport_enabled);
 	ASSERT(is_traceport_enabled <= 0xFF);
-	dmub->debug.is_traceport_en  = (uint8_t)is_traceport_enabled;
+	hw_data->is_traceport_en  = (uint8_t)is_traceport_enabled;
 
 	REG_GET(DMCUB_REGION3_CW0_TOP_ADDRESS, DMCUB_REGION3_CW0_ENABLE, &is_cw0_enabled);
 	ASSERT(is_cw0_enabled <= 0xFF);
-	dmub->debug.is_cw0_enabled = (uint8_t)is_cw0_enabled;
+	hw_data->is_cw0_enabled = (uint8_t)is_cw0_enabled;
 
 	REG_GET(DMCUB_REGION3_CW6_TOP_ADDRESS, DMCUB_REGION3_CW6_ENABLE, &is_cw6_enabled);
 	ASSERT(is_cw6_enabled <= 0xFF);
-	dmub->debug.is_cw6_enabled = (uint8_t)is_cw6_enabled;
+	hw_data->is_cw6_enabled = (uint8_t)is_cw6_enabled;
 
-	dmub->debug.gpint_datain0 = REG_READ(DMCUB_GPINT_DATAIN0);
+	hw_data->gpint_datain0 = REG_READ(DMCUB_GPINT_DATAIN0);
 }
 
 bool dmub_dcn42_get_preos_fw_info(struct dmub_srv *dmub)
diff --git a/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn42.h b/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn42.h
index c53f7691d1a8..c879e94272d7 100644
--- a/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn42.h
+++ b/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn42.h
@@ -297,7 +297,7 @@ union dmub_fw_boot_options dmub_dcn42_get_fw_boot_option(struct dmub_srv *dmub);
 
 /* Timing and diagnostics */
 uint32_t dmub_dcn42_get_current_time(struct dmub_srv *dmub);
-void dmub_dcn42_get_diagnostic_data(struct dmub_srv *dmub);
+void dmub_dcn42_get_diagnostic_data(struct dmub_srv *dmub, struct dmub_hw_diagnostic_data *hw_data);
 bool dmub_dcn42_get_preos_fw_info(struct dmub_srv *dmub);
 
 #endif /* _DMUB_DCN42_H_ */
diff --git a/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn60.c b/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn60.c
index 5c524f8d3fdf..8c3cc51c07a3 100644
--- a/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn60.c
+++ b/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn60.c
@@ -469,85 +469,81 @@ uint32_t dmub_dcn60_get_current_time(struct dmub_srv *dmub)
 	return REG_READ(DMCUB_TIMER_CURRENT);
 }
 
-void dmub_dcn60_get_diagnostic_data(struct dmub_srv *dmub)
+void dmub_dcn60_get_diagnostic_data(struct dmub_srv *dmub, struct dmub_hw_diagnostic_data *hw_data)
 {
 	uint32_t is_dmub_enabled, is_soft_reset, is_sec_reset, is_pwait;
 	uint32_t is_traceport_enabled, is_cw0_enabled, is_cw6_enabled;
-	struct dmub_timeout_info timeout = {0};
 
-	if (!dmub)
+	if (!dmub || !hw_data)
 		return;
 
-	/* timeout data filled externally, cache before resetting memory */
-	timeout = dmub->debug.timeout_info;
-	memset(&dmub->debug, 0, sizeof(dmub->debug));
-	dmub->debug.timeout_info = timeout;
-
-	dmub->debug.dmcub_version = dmub->fw_version;
-
-	dmub->debug.scratch[0] = REG_READ(DMCUB_SCRATCH0);
-	dmub->debug.scratch[1] = REG_READ(DMCUB_SCRATCH1);
-	dmub->debug.scratch[2] = REG_READ(DMCUB_SCRATCH2);
-	dmub->debug.scratch[3] = REG_READ(DMCUB_SCRATCH3);
-	dmub->debug.scratch[4] = REG_READ(DMCUB_SCRATCH4);
-	dmub->debug.scratch[5] = REG_READ(DMCUB_SCRATCH5);
-	dmub->debug.scratch[6] = REG_READ(DMCUB_SCRATCH6);
-	dmub->debug.scratch[7] = REG_READ(DMCUB_SCRATCH7);
-	dmub->debug.scratch[8] = REG_READ(DMCUB_SCRATCH8);
-	dmub->debug.scratch[9] = REG_READ(DMCUB_SCRATCH9);
-	dmub->debug.scratch[10] = REG_READ(DMCUB_SCRATCH10);
-	dmub->debug.scratch[11] = REG_READ(DMCUB_SCRATCH11);
-	dmub->debug.scratch[12] = REG_READ(DMCUB_SCRATCH12);
-	dmub->debug.scratch[13] = REG_READ(DMCUB_SCRATCH13);
-	dmub->debug.scratch[14] = REG_READ(DMCUB_SCRATCH14);
-	dmub->debug.scratch[15] = REG_READ(DMCUB_SCRATCH15);
-	dmub->debug.scratch[16] = REG_READ(DMCUB_SCRATCH16);
-
-	dmub->debug.undefined_address_fault_addr = REG_READ(DMCUB_UNDEFINED_ADDRESS_FAULT_ADDR);
-	dmub->debug.inst_fetch_fault_addr = REG_READ(DMCUB_INST_FETCH_FAULT_ADDR);
-	dmub->debug.data_write_fault_addr = REG_READ(DMCUB_DATA_WRITE_FAULT_ADDR);
-
-	dmub->debug.inbox1_rptr = REG_READ(DMCUB_INBOX1_RPTR);
-	dmub->debug.inbox1_wptr = REG_READ(DMCUB_INBOX1_WPTR);
-	dmub->debug.inbox1_size = REG_READ(DMCUB_INBOX1_SIZE);
-
-	dmub->debug.inbox0_rptr = REG_READ(DMCUB_INBOX0_RPTR);
-	dmub->debug.inbox0_wptr = REG_READ(DMCUB_INBOX0_WPTR);
-	dmub->debug.inbox0_size = REG_READ(DMCUB_INBOX0_SIZE);
-
-	dmub->debug.outbox1_rptr = REG_READ(DMCUB_OUTBOX1_RPTR);
-	dmub->debug.outbox1_wptr = REG_READ(DMCUB_OUTBOX1_WPTR);
-	dmub->debug.outbox1_size = REG_READ(DMCUB_OUTBOX1_SIZE);
+	memset(hw_data, 0, sizeof(*hw_data));
+
+	hw_data->dmcub_version = dmub->fw_version;
+
+	hw_data->scratch[0] = REG_READ(DMCUB_SCRATCH0);
+	hw_data->scratch[1] = REG_READ(DMCUB_SCRATCH1);
+	hw_data->scratch[2] = REG_READ(DMCUB_SCRATCH2);
+	hw_data->scratch[3] = REG_READ(DMCUB_SCRATCH3);
+	hw_data->scratch[4] = REG_READ(DMCUB_SCRATCH4);
+	hw_data->scratch[5] = REG_READ(DMCUB_SCRATCH5);
+	hw_data->scratch[6] = REG_READ(DMCUB_SCRATCH6);
+	hw_data->scratch[7] = REG_READ(DMCUB_SCRATCH7);
+	hw_data->scratch[8] = REG_READ(DMCUB_SCRATCH8);
+	hw_data->scratch[9] = REG_READ(DMCUB_SCRATCH9);
+	hw_data->scratch[10] = REG_READ(DMCUB_SCRATCH10);
+	hw_data->scratch[11] = REG_READ(DMCUB_SCRATCH11);
+	hw_data->scratch[12] = REG_READ(DMCUB_SCRATCH12);
+	hw_data->scratch[13] = REG_READ(DMCUB_SCRATCH13);
+	hw_data->scratch[14] = REG_READ(DMCUB_SCRATCH14);
+	hw_data->scratch[15] = REG_READ(DMCUB_SCRATCH15);
+	hw_data->scratch[16] = REG_READ(DMCUB_SCRATCH16);
+
+	hw_data->undefined_address_fault_addr = REG_READ(DMCUB_UNDEFINED_ADDRESS_FAULT_ADDR);
+	hw_data->inst_fetch_fault_addr = REG_READ(DMCUB_INST_FETCH_FAULT_ADDR);
+	hw_data->data_write_fault_addr = REG_READ(DMCUB_DATA_WRITE_FAULT_ADDR);
+
+	hw_data->inbox1_rptr = REG_READ(DMCUB_INBOX1_RPTR);
+	hw_data->inbox1_wptr = REG_READ(DMCUB_INBOX1_WPTR);
+	hw_data->inbox1_size = REG_READ(DMCUB_INBOX1_SIZE);
+
+	hw_data->inbox0_rptr = REG_READ(DMCUB_INBOX0_RPTR);
+	hw_data->inbox0_wptr = REG_READ(DMCUB_INBOX0_WPTR);
+	hw_data->inbox0_size = REG_READ(DMCUB_INBOX0_SIZE);
+
+	hw_data->outbox1_rptr = REG_READ(DMCUB_OUTBOX1_RPTR);
+	hw_data->outbox1_wptr = REG_READ(DMCUB_OUTBOX1_WPTR);
+	hw_data->outbox1_size = REG_READ(DMCUB_OUTBOX1_SIZE);
 
 	REG_GET(DMCUB_CNTL, DMCUB_ENABLE, &is_dmub_enabled);
 	ASSERT(is_dmub_enabled <= 0xFF);
-	dmub->debug.is_dmcub_enabled = (uint8_t)is_dmub_enabled;
+	hw_data->is_dmcub_enabled = (uint8_t)is_dmub_enabled;
 
 	REG_GET(DMCUB_CNTL, DMCUB_PWAIT_MODE_STATUS, &is_pwait);
 	ASSERT(is_pwait <= 0xFF);
-	dmub->debug.is_pwait = (uint8_t)is_pwait;
+	hw_data->is_pwait = (uint8_t)is_pwait;
 
 	REG_GET(DMCUB_CNTL2, DMCUB_SOFT_RESET, &is_soft_reset);
 	ASSERT(is_soft_reset <= 0xFF);
-	dmub->debug.is_dmcub_soft_reset = (uint8_t)is_soft_reset;
+	hw_data->is_dmcub_soft_reset = (uint8_t)is_soft_reset;
 
 	REG_GET(DMCUB_SEC_CNTL, DMCUB_SEC_RESET_STATUS, &is_sec_reset);
 	ASSERT(is_sec_reset <= 0xFF);
-	dmub->debug.is_dmcub_secure_reset = (uint8_t)is_sec_reset;
+	hw_data->is_dmcub_secure_reset = (uint8_t)is_sec_reset;
 
 	REG_GET(DMCUB_CNTL, DMCUB_TRACEPORT_EN, &is_traceport_enabled);
 	ASSERT(is_traceport_enabled <= 0xFF);
-	dmub->debug.is_traceport_en  = (uint8_t)is_traceport_enabled;
+	hw_data->is_traceport_en  = (uint8_t)is_traceport_enabled;
 
 	REG_GET(DMCUB_REGION3_CW0_TOP_ADDRESS, DMCUB_REGION3_CW0_ENABLE, &is_cw0_enabled);
 	ASSERT(is_cw0_enabled <= 0xFF);
-	dmub->debug.is_cw0_enabled = (uint8_t)is_cw0_enabled;
+	hw_data->is_cw0_enabled = (uint8_t)is_cw0_enabled;
 
 	REG_GET(DMCUB_REGION3_CW6_TOP_ADDRESS, DMCUB_REGION3_CW6_ENABLE, &is_cw6_enabled);
 	ASSERT(is_cw6_enabled <= 0xFF);
-	dmub->debug.is_cw6_enabled = (uint8_t)is_cw6_enabled;
+	hw_data->is_cw6_enabled = (uint8_t)is_cw6_enabled;
 
-	dmub->debug.gpint_datain0 = REG_READ(DMCUB_GPINT_DATAIN0);
+	hw_data->gpint_datain0 = REG_READ(DMCUB_GPINT_DATAIN0);
 }
 void dmub_dcn60_configure_dmub_in_system_memory(struct dmub_srv *dmub)
 {
diff --git a/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn60.h b/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn60.h
index 5007ed1c19d7..238cba46d366 100644
--- a/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn60.h
+++ b/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn60.h
@@ -277,7 +277,7 @@ void dmub_dcn60_set_outbox0_rptr(struct dmub_srv *dmub, uint32_t rptr_offset);
 
 uint32_t dmub_dcn60_get_current_time(struct dmub_srv *dmub);
 
-void dmub_dcn60_get_diagnostic_data(struct dmub_srv *dmub);
+void dmub_dcn60_get_diagnostic_data(struct dmub_srv *dmub, struct dmub_hw_diagnostic_data *hw_data);
 
 void dmub_dcn60_configure_dmub_in_system_memory(struct dmub_srv *dmub);
 void dmub_dcn60_send_inbox0_cmd(struct dmub_srv *dmub, union dmub_inbox0_data_register data);
diff --git a/drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c b/drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c
index dd868e38e0b0..41b14b137643 100644
--- a/drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c
+++ b/drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c
@@ -1315,11 +1315,63 @@ bool dmub_srv_get_outbox0_msg(struct dmub_srv *dmub, struct dmcub_trace_buf_entr
 	return dmub_rb_out_trace_buffer_front(&dmub->outbox0_rb, (void *)entry);
 }
 
+void dmub_srv_get_trace_snapshot(struct dmub_srv *dmub, struct dmub_trace_snapshot *trace_snapshot)
+{
+	const unsigned int snapshot_max_entry_count =
+			sizeof(trace_snapshot->traces) / sizeof(struct dmcub_trace_buf_entry);
+
+	struct dmub_trace_buf_header *trace_buf_header;
+	struct dmcub_trace_buf_entry *trace_buf;
+	unsigned int trace_buf_max_entry_count;
+	unsigned int entry_count, start_idx, first_chunk_entry_count;
+
+	if (!dmub || !dmub->fb_info || !trace_snapshot)
+		return;
+
+	// capture last trace entries from the DMCUB trace buffer
+	trace_buf_header = (struct dmub_trace_buf_header *)dmub->fb_info->fb[DMUB_WINDOW_5_TRACEBUFF].cpu_addr;
+	trace_buf_max_entry_count = dmub->fb_info->fb[DMUB_WINDOW_5_TRACEBUFF].size == 0 ? 0 :
+			(dmub->fb_info->fb[DMUB_WINDOW_5_TRACEBUFF].size -
+			sizeof(struct dmub_trace_buf_header)) /
+			sizeof(struct dmcub_trace_buf_entry);
+	trace_buf_max_entry_count = trace_buf_max_entry_count > DMUB_TRACE_BUFFER_SIZE ?
+			DMUB_TRACE_BUFFER_SIZE : trace_buf_max_entry_count;
+
+	if (trace_buf_header && trace_buf_max_entry_count > 0) {
+		entry_count = trace_buf_header->entry_count;
+		start_idx = 0;
+		if (entry_count >= snapshot_max_entry_count) {
+			start_idx = (entry_count - snapshot_max_entry_count) % trace_buf_max_entry_count;
+		}
+
+		trace_buf = (struct dmcub_trace_buf_entry *)(trace_buf_header + 1);
+
+		if (start_idx + snapshot_max_entry_count <= trace_buf_max_entry_count) {
+			// contiguous
+			memcpy(trace_snapshot->traces,
+					&trace_buf[start_idx],
+					sizeof(struct dmcub_trace_buf_entry) * snapshot_max_entry_count);
+		} else {
+			// wraparound case
+			first_chunk_entry_count = trace_buf_max_entry_count - start_idx;
+
+			memcpy(trace_snapshot->traces,
+					&trace_buf[start_idx],
+					sizeof(struct dmcub_trace_buf_entry) * first_chunk_entry_count);
+			memcpy(&trace_snapshot->traces[first_chunk_entry_count],
+					&trace_buf[0],
+					sizeof(struct dmcub_trace_buf_entry) * (snapshot_max_entry_count - first_chunk_entry_count));
+		}
+	}
+}
+
 bool dmub_srv_get_diagnostic_data(struct dmub_srv *dmub)
 {
 	if (!dmub || !dmub->hw_funcs.get_diagnostic_data)
 		return false;
-	dmub->hw_funcs.get_diagnostic_data(dmub);
+
+	dmub->hw_funcs.get_diagnostic_data(dmub, &dmub->debug.hw);
+	dmub_srv_get_trace_snapshot(dmub, &dmub->debug.trace_snapshot);
 
 	return true;
 }
-- 
2.55.0

