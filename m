Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C431CCFA1B
	for <amd-gfx@archiver.kernel.org>; Wed,  5 Nov 2025 15:41:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BA6FB10E75D;
	Wed,  5 Nov 2025 15:41:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="gc2OqcXV";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011056.outbound.protection.outlook.com [52.101.62.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F0BCC10E700
 for <amd-gfx@lists.freedesktop.org>; Wed,  5 Nov 2025 15:41:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FGZ+anZyUG0GcooU890+UJrFrs5DZgZDDo2y5ItJUK20xvNtgHZw5MXCiXc9kqzGNlj63/VbqE6PFKfZraTewvVbRARVFa8vOzgQ/YVe32/4ug9tZE9rxk3k2nCGzrYA4WgKre4/IsMQBs3gGbMnLzMbgMPbNxccGt0mFIz6T/pMvJzHf/Xuvzcf1OfsqSmS7DyNm5R3o6NqGGLDA0+g5TuRq2HSaZtK6S0CtGhb43taA+4Rr74t/ClxSW4M7c7Yf7C/N0/uOTFOZPX5cKXvyRPlly7qzwOiqLUzLUgbVdQFp032vlm9l2Y3uXAGKuGtMMpmX99Jin2dcAlZYhvarw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I8XbYUbity0hRe2PXNvQMIR1fSk+LJ8iqA252dl//iE=;
 b=uNeCNFFj0C1duv8sgQJ0FAJzSTCqQRYs7zazAnKPbjXeAN8BQm99RdzQhHkRYMuSrk4iJbctNa2vVpTl522n7U817DY69U5zgw+EISUlsMGgAs6fXy/c9O1xb5uI1QqF8kdiS92W7E0vg1uoKSRgXS3JmhbKBmFvytTpd4GIctB5STintm65WX0w3sV+ZBNQcsNe82na5FYQ8TDBQlRbrWU9pIvF8d1uSAe/nC1Fy0tCGX6JP45vjlVV6y3fpjI/9UIXGsP6uFMgsS1bvpekpPcr95vGrPRQ7upJSeW5RwRt+xN8VftRw7kZk4MNPgDZAiUKe4nz0kO8nqhOCa7u7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I8XbYUbity0hRe2PXNvQMIR1fSk+LJ8iqA252dl//iE=;
 b=gc2OqcXVggQ6YYocFoNfaTJkeC3Nu/el69x3lZ6iIdzKTYA7uarJuoIU9yxp/72424HK+zYInkMLceEuJPO19+V94N4orZgI5YM2ZWowXqcle5X8VUka/eFLsBvJ36oUE19C7YupTgFZp4NHxMlvVPZGalWjeDABD7oCBi2n6Lc=
Received: from BN1PR10CA0022.namprd10.prod.outlook.com (2603:10b6:408:e0::27)
 by SA1PR12MB9491.namprd12.prod.outlook.com (2603:10b6:806:458::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.7; Wed, 5 Nov
 2025 15:41:05 +0000
Received: from BN1PEPF0000468C.namprd05.prod.outlook.com
 (2603:10b6:408:e0:cafe::38) by BN1PR10CA0022.outlook.office365.com
 (2603:10b6:408:e0::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9275.16 via Frontend Transport; Wed,
 5 Nov 2025 15:41:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN1PEPF0000468C.mail.protection.outlook.com (10.167.243.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9298.6 via Frontend Transport; Wed, 5 Nov 2025 15:41:04 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 5 Nov
 2025 07:40:56 -0800
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 5 Nov
 2025 07:40:55 -0800
Received: from jzuo-laptop.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Wed, 5 Nov 2025 07:40:55 -0800
From: Fangzhi Zuo <Jerry.Zuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, Chuntao Tso <chunttso@amd.com>, Robin Chen
 <robin.chen@amd.com>
Subject: [PATCH 08/13] drm/amd/display: To support Replay frame skip mode
Date: Wed, 5 Nov 2025 10:36:23 -0500
Message-ID: <20251105154035.883188-9-Jerry.Zuo@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251105154035.883188-1-Jerry.Zuo@amd.com>
References: <20251105154035.883188-1-Jerry.Zuo@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF0000468C:EE_|SA1PR12MB9491:EE_
X-MS-Office365-Filtering-Correlation-Id: e4123fcc-e745-4f75-2b92-08de1c81bb03
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?9OICAvvQ3oXZGSuH4CTFBovEhIYThzMTjIQTPWN+q4JtgrMW/t93jmdGo1vV?=
 =?us-ascii?Q?6p53TqP4Jmqih0yS4ECJzwXHqOrREl20ECERcNKpoW5SNO6aycikgFgryQLW?=
 =?us-ascii?Q?OLM5Gs6374M+Gey/UroivjhgMmQ2hqWbQO3qUAQy0BUT3LOj2Z8kjIg09E25?=
 =?us-ascii?Q?tBZqMBa2JpB8+7cv+HOHdwPMI4HRmtpFeAqTis2teAsrFoxHUzWjQVTLIPQg?=
 =?us-ascii?Q?rpx3brOM3nj+KdQYGfPbNTbRzeuWX08Cg9AFUK8lXprembHTqt/QE3Z7niWu?=
 =?us-ascii?Q?zL5p5XUK6xcB3htJUFMnYSnGZR/DHjOXEHymvjPHLUooKdHiCvIjswl7J/GG?=
 =?us-ascii?Q?Sm3vkWKKZo6wtmIVsmnK49cHPAYCwWb0y6EYII/d7rTEKJPNsL5Di0m4+NFl?=
 =?us-ascii?Q?5w4uY5oLqBiera1ZW7ZmCTUqItPqFciz1HFlC2xrm4zKEXpUANM6QM5lftyr?=
 =?us-ascii?Q?9gl/JO7DGE3GL2UhLKGrW7APf4QYBXp4bu1IYEdXUvRxMsJ/fcs5k+HCONBN?=
 =?us-ascii?Q?z3piglP5MKdYE/7/M4Ydn6462I0oLcwPY8uyVZtiktkMH+INWLcQ3Br4UTu9?=
 =?us-ascii?Q?v/AVpvTb4tRf0F7y7o9Ka8CcieIqchMkmgQbozvC3Csg0Vjnyx4/p0wDSGkf?=
 =?us-ascii?Q?v1JCxPuzPN+Y7tOALWEckXLLfBYWcpqQDz9b7gAorwY9yMT1BefymJfd/ba9?=
 =?us-ascii?Q?87tWD9l6DbekgmMAD58YhM+y4iyK41ihP9c/34xahIUh1xzXoD3puauqLv6W?=
 =?us-ascii?Q?rZaGida2lj5MZTTdNFiPjfhKfUR18JEViYktzN8ey1RKQNT+3RzXVY5sXrFL?=
 =?us-ascii?Q?ehTISybia+5B0zlaYARh669I8nEzyYHXg+DlIGmux0PHmjeYR/SUPRmO3XoW?=
 =?us-ascii?Q?+YzHn0fSHnD5EGzRVMp+DhvKshrOG3MZKcIGvNKERXjxD6gZCh8hILocJTCQ?=
 =?us-ascii?Q?9axGtnyyzVMlnDAP+V5IjudelGOsQAgrJ/cqG/MyJbCJWC4jTGaN8kLlHqHx?=
 =?us-ascii?Q?BGpJp2HXNRw7otWdpW3X+OxLuFfKIqXrWAWcd9V0nZJay/Ct0WcS0acKpvwa?=
 =?us-ascii?Q?HAEv/YIoEeCKwmpJk9Ho7YAMZihOUAacLhyLZWIc6K8Lw6YzSlTk6lH4c8Yy?=
 =?us-ascii?Q?7uAqfeTdcPs1wx2sqVfrsLv/NSuHxRbg6lRENO8I64+YwmYBc2J+CDDcKXjR?=
 =?us-ascii?Q?CqfqCSapzyclST+YblXffY7BS9qawjqGd9KmKmG/sxLQAnCBzfk7qUvo/KtG?=
 =?us-ascii?Q?Y4X/iJicvXR1S3Gmna+tlk0qTFr4lTZhQ9zLlPULBPU3XFrKvmNVJgrchQvp?=
 =?us-ascii?Q?JyZvdUNAy+ezir5SDfaTo5UaNmjJKcht6pin52qm1TU2a76HvVW7Vdna4G8m?=
 =?us-ascii?Q?Qs/p3PL1KWOgM8DN3FDP4ZC9SBgTzjp5I45wvk0c0W6PZsrKOek9a/BKaeZV?=
 =?us-ascii?Q?YKGUITPH33cFGWLbhp8KRKR8++0+ky0bDDAOT84EGR4jBECuZ9vL0KfmGNG4?=
 =?us-ascii?Q?tDzLPRoM7hk9n9NO3DQFawmpqIUCQrtgu0UdsuW0VsG4/50bQNDGjrW5jrl1?=
 =?us-ascii?Q?0apU8TVYJBJStBXg2bI=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2025 15:41:04.6665 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e4123fcc-e745-4f75-2b92-08de1c81bb03
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF0000468C.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB9491
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

From: Chuntao Tso <chunttso@amd.com>

[Why & How]
The change is to optimize the Replay power saving by
reducing the refresh rate with frame skipping mode

Reviewed-by: Robin Chen <robin.chen@amd.com>
Signed-off-by: Chuntao Tso <chunttso@amd.com>
Signed-off-by: Fangzhi Zuo <jerry.zuo@amd.com>
---
 .../amd/display/amdgpu_dm/amdgpu_dm_replay.c  |  2 +-
 drivers/gpu/drm/amd/display/dc/dc_types.h     |  6 ++++
 .../gpu/drm/amd/display/dc/dce/dmub_replay.c  |  7 +++--
 .../gpu/drm/amd/display/dc/dce/dmub_replay.h  |  5 ++--
 .../gpu/drm/amd/display/dc/inc/link_service.h |  4 +--
 .../link/protocols/link_edp_panel_control.c   | 17 +++++++----
 .../link/protocols/link_edp_panel_control.h   |  4 +--
 .../amd/display/modules/power/power_helpers.c | 30 +++++++++++++++++++
 .../amd/display/modules/power/power_helpers.h |  5 ++++
 9 files changed, 65 insertions(+), 15 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_replay.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_replay.c
index 80704d709e44..da94e3544b65 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_replay.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_replay.c
@@ -162,7 +162,7 @@ bool amdgpu_dm_replay_enable(struct dc_stream_state *stream, bool wait)
 
 	if (link) {
 		link->dc->link_srv->edp_setup_replay(link, stream);
-		link->dc->link_srv->edp_set_coasting_vtotal(link, stream->timing.v_total);
+		link->dc->link_srv->edp_set_coasting_vtotal(link, stream->timing.v_total, 0);
 		DRM_DEBUG_DRIVER("Enabling replay...\n");
 		link->dc->link_srv->edp_set_replay_allow_active(link, &replay_active, wait, false, NULL);
 		return true;
diff --git a/drivers/gpu/drm/amd/display/dc/dc_types.h b/drivers/gpu/drm/amd/display/dc/dc_types.h
index ea6b71c43d2c..0495e6cfcca0 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_types.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_types.h
@@ -1184,6 +1184,10 @@ struct replay_settings {
 	uint32_t coasting_vtotal_table[PR_COASTING_TYPE_NUM];
 	/* Defer Update Coasting vtotal table */
 	uint32_t defer_update_coasting_vtotal_table[PR_COASTING_TYPE_NUM];
+	/* Skip frame number table */
+	uint32_t frame_skip_number_table[PR_COASTING_TYPE_NUM];
+	/* Defer skip frame number table */
+	uint32_t defer_frame_skip_number_table[PR_COASTING_TYPE_NUM];
 	/* Maximum link off frame count */
 	uint32_t link_off_frame_count;
 	/* Replay pseudo vtotal for low refresh rate*/
@@ -1192,6 +1196,8 @@ struct replay_settings {
 	uint16_t last_pseudo_vtotal;
 	/* Replay desync error */
 	uint32_t replay_desync_error_fail_count;
+	/* The frame skip number dal send to DMUB */
+	uint16_t frame_skip_number;
 };
 
 /* To split out "global" and "per-panel" config settings.
diff --git a/drivers/gpu/drm/amd/display/dc/dce/dmub_replay.c b/drivers/gpu/drm/amd/display/dc/dce/dmub_replay.c
index f9542edff14b..fd8244c94687 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dmub_replay.c
+++ b/drivers/gpu/drm/amd/display/dc/dce/dmub_replay.c
@@ -213,7 +213,8 @@ static bool dmub_replay_copy_settings(struct dmub_replay *dmub,
  */
 static void dmub_replay_set_coasting_vtotal(struct dmub_replay *dmub,
 		uint32_t coasting_vtotal,
-		uint8_t panel_inst)
+		uint8_t panel_inst,
+		uint16_t frame_skip_number)
 {
 	union dmub_rb_cmd cmd;
 	struct dc_context *dc = dmub->ctx;
@@ -227,6 +228,7 @@ static void dmub_replay_set_coasting_vtotal(struct dmub_replay *dmub,
 	pCmd->header.payload_bytes = sizeof(struct dmub_cmd_replay_set_coasting_vtotal_data);
 	pCmd->replay_set_coasting_vtotal_data.coasting_vtotal = (coasting_vtotal & 0xFFFF);
 	pCmd->replay_set_coasting_vtotal_data.coasting_vtotal_high = (coasting_vtotal & 0xFFFF0000) >> 16;
+	pCmd->replay_set_coasting_vtotal_data.frame_skip_number = frame_skip_number;
 
 	dc_wake_and_execute_dmub_cmd(dc, &cmd, DM_DMUB_WAIT_TYPE_WAIT);
 }
@@ -283,7 +285,7 @@ static void dmub_replay_residency(struct dmub_replay *dmub, uint8_t panel_inst,
  * Set REPLAY power optimization flags and coasting vtotal.
  */
 static void dmub_replay_set_power_opt_and_coasting_vtotal(struct dmub_replay *dmub,
-		unsigned int power_opt, uint8_t panel_inst, uint32_t coasting_vtotal)
+		unsigned int power_opt, uint8_t panel_inst, uint32_t coasting_vtotal, uint16_t frame_skip_number)
 {
 	union dmub_rb_cmd cmd;
 	struct dc_context *dc = dmub->ctx;
@@ -301,6 +303,7 @@ static void dmub_replay_set_power_opt_and_coasting_vtotal(struct dmub_replay *dm
 	pCmd->replay_set_power_opt_data.panel_inst = panel_inst;
 	pCmd->replay_set_coasting_vtotal_data.coasting_vtotal = (coasting_vtotal & 0xFFFF);
 	pCmd->replay_set_coasting_vtotal_data.coasting_vtotal_high = (coasting_vtotal & 0xFFFF0000) >> 16;
+	pCmd->replay_set_coasting_vtotal_data.frame_skip_number = frame_skip_number;
 
 	dc_wake_and_execute_dmub_cmd(dc, &cmd, DM_DMUB_WAIT_TYPE_WAIT);
 }
diff --git a/drivers/gpu/drm/amd/display/dc/dce/dmub_replay.h b/drivers/gpu/drm/amd/display/dc/dce/dmub_replay.h
index e6346c0ffc0e..07c79739a980 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dmub_replay.h
+++ b/drivers/gpu/drm/amd/display/dc/dce/dmub_replay.h
@@ -27,11 +27,12 @@ struct dmub_replay_funcs {
 	void (*replay_send_cmd)(struct dmub_replay *dmub,
 		enum replay_FW_Message_type msg, union dmub_replay_cmd_set *cmd_element);
 	void (*replay_set_coasting_vtotal)(struct dmub_replay *dmub, uint32_t coasting_vtotal,
-		uint8_t panel_inst);
+		uint8_t panel_inst, uint16_t frame_skip_number);
 	void (*replay_residency)(struct dmub_replay *dmub,
 		uint8_t panel_inst, uint32_t *residency, const bool is_start, const enum pr_residency_mode mode);
 	void (*replay_set_power_opt_and_coasting_vtotal)(struct dmub_replay *dmub,
-		unsigned int power_opt, uint8_t panel_inst, uint32_t coasting_vtotal);
+		unsigned int power_opt, uint8_t panel_inst, uint32_t coasting_vtotal,
+		uint16_t frame_skip_number);
 };
 
 struct dmub_replay *dmub_replay_create(struct dc_context *ctx);
diff --git a/drivers/gpu/drm/amd/display/dc/inc/link_service.h b/drivers/gpu/drm/amd/display/dc/inc/link_service.h
index 1e34e84160aa..6f94e48a24d1 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/link_service.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/link_service.h
@@ -292,12 +292,12 @@ struct link_service {
 			enum replay_FW_Message_type msg,
 			union dmub_replay_cmd_set *cmd_data);
 	bool (*edp_set_coasting_vtotal)(
-			struct dc_link *link, uint32_t coasting_vtotal);
+			struct dc_link *link, uint32_t coasting_vtotal, uint16_t frame_skip_number);
 	bool (*edp_replay_residency)(const struct dc_link *link,
 			unsigned int *residency, const bool is_start,
 			const enum pr_residency_mode mode);
 	bool (*edp_set_replay_power_opt_and_coasting_vtotal)(struct dc_link *link,
-			const unsigned int *power_opts, uint32_t coasting_vtotal);
+			const unsigned int *power_opts, uint32_t coasting_vtotal, uint16_t frame_skip_number);
 
 	bool (*edp_wait_for_t12)(struct dc_link *link);
 	bool (*edp_is_ilr_optimization_required)(struct dc_link *link,
diff --git a/drivers/gpu/drm/amd/display/dc/link/protocols/link_edp_panel_control.c b/drivers/gpu/drm/amd/display/dc/link/protocols/link_edp_panel_control.c
index 5e806edbb9f6..9391c75a30e5 100644
--- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_edp_panel_control.c
+++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_edp_panel_control.c
@@ -1110,7 +1110,7 @@ bool edp_send_replay_cmd(struct dc_link *link,
 	return true;
 }
 
-bool edp_set_coasting_vtotal(struct dc_link *link, uint32_t coasting_vtotal)
+bool edp_set_coasting_vtotal(struct dc_link *link, uint32_t coasting_vtotal, uint16_t frame_skip_number)
 {
 	struct dc *dc = link->ctx->dc;
 	struct dmub_replay *replay = dc->res_pool->replay;
@@ -1122,9 +1122,11 @@ bool edp_set_coasting_vtotal(struct dc_link *link, uint32_t coasting_vtotal)
 	if (!dc_get_edp_link_panel_inst(dc, link, &panel_inst))
 		return false;
 
-	if (coasting_vtotal && link->replay_settings.coasting_vtotal != coasting_vtotal) {
-		replay->funcs->replay_set_coasting_vtotal(replay, coasting_vtotal, panel_inst);
+	if (coasting_vtotal && (link->replay_settings.coasting_vtotal != coasting_vtotal ||
+		link->replay_settings.frame_skip_number != frame_skip_number)) {
+		replay->funcs->replay_set_coasting_vtotal(replay, coasting_vtotal, panel_inst, frame_skip_number);
 		link->replay_settings.coasting_vtotal = coasting_vtotal;
+		link->replay_settings.frame_skip_number = frame_skip_number;
 	}
 
 	return true;
@@ -1152,7 +1154,7 @@ bool edp_replay_residency(const struct dc_link *link,
 }
 
 bool edp_set_replay_power_opt_and_coasting_vtotal(struct dc_link *link,
-	const unsigned int *power_opts, uint32_t coasting_vtotal)
+	const unsigned int *power_opts, uint32_t coasting_vtotal, uint16_t frame_skip_number)
 {
 	struct dc  *dc = link->ctx->dc;
 	struct dmub_replay *replay = dc->res_pool->replay;
@@ -1163,13 +1165,16 @@ bool edp_set_replay_power_opt_and_coasting_vtotal(struct dc_link *link,
 
 	/* Only both power and coasting vtotal changed, this func could return true */
 	if (power_opts && link->replay_settings.replay_power_opt_active != *power_opts &&
-		coasting_vtotal && link->replay_settings.coasting_vtotal != coasting_vtotal) {
+		(coasting_vtotal &&
+		(link->replay_settings.coasting_vtotal != coasting_vtotal ||
+		link->replay_settings.frame_skip_number != frame_skip_number))) {
 		if (link->replay_settings.replay_feature_enabled &&
 			replay->funcs->replay_set_power_opt_and_coasting_vtotal) {
 			replay->funcs->replay_set_power_opt_and_coasting_vtotal(replay,
-				*power_opts, panel_inst, coasting_vtotal);
+				*power_opts, panel_inst, coasting_vtotal, frame_skip_number);
 			link->replay_settings.replay_power_opt_active = *power_opts;
 			link->replay_settings.coasting_vtotal = coasting_vtotal;
+			link->replay_settings.frame_skip_number = frame_skip_number;
 		} else
 			return false;
 	} else
diff --git a/drivers/gpu/drm/amd/display/dc/link/protocols/link_edp_panel_control.h b/drivers/gpu/drm/amd/display/dc/link/protocols/link_edp_panel_control.h
index 62a6344e613e..dd79c7cd2828 100644
--- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_edp_panel_control.h
+++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_edp_panel_control.h
@@ -59,12 +59,12 @@ bool edp_setup_replay(struct dc_link *link,
 bool edp_send_replay_cmd(struct dc_link *link,
 			enum replay_FW_Message_type msg,
 			union dmub_replay_cmd_set *cmd_data);
-bool edp_set_coasting_vtotal(struct dc_link *link, uint32_t coasting_vtotal);
+bool edp_set_coasting_vtotal(struct dc_link *link, uint32_t coasting_vtotal, uint16_t frame_skip_number);
 bool edp_replay_residency(const struct dc_link *link,
 	unsigned int *residency, const bool is_start, const enum pr_residency_mode mode);
 bool edp_get_replay_state(const struct dc_link *link, uint64_t *state);
 bool edp_set_replay_power_opt_and_coasting_vtotal(struct dc_link *link,
-	const unsigned int *power_opts, uint32_t coasting_vtotal);
+	const unsigned int *power_opts, uint32_t coasting_vtotal, uint16_t frame_skip_number);
 bool edp_wait_for_t12(struct dc_link *link);
 bool edp_is_ilr_optimization_required(struct dc_link *link,
        struct dc_crtc_timing *crtc_timing);
diff --git a/drivers/gpu/drm/amd/display/modules/power/power_helpers.c b/drivers/gpu/drm/amd/display/modules/power/power_helpers.c
index 29ccd3532d13..88b5b716a084 100644
--- a/drivers/gpu/drm/amd/display/modules/power/power_helpers.c
+++ b/drivers/gpu/drm/amd/display/modules/power/power_helpers.c
@@ -975,6 +975,34 @@ bool psr_su_set_dsc_slice_height(struct dc *dc, struct dc_link *link,
 	return true;
 }
 
+void set_replay_frame_skip_number(struct dc_link *link,
+	enum replay_coasting_vtotal_type type,
+	uint32_t coasting_vtotal_refresh_rate_mhz,
+	uint32_t flicker_free_refresh_rate_mhz,
+	bool is_defer)
+{
+	uint32_t *frame_skip_number_array = NULL;
+	uint32_t frame_skip_number = 0;
+
+	if (link == NULL || flicker_free_refresh_rate_mhz == 0 || coasting_vtotal_refresh_rate_mhz == 0)
+		return;
+
+	if (is_defer)
+		frame_skip_number_array = link->replay_settings.defer_frame_skip_number_table;
+	else
+		frame_skip_number_array = link->replay_settings.frame_skip_number_table;
+
+	if (frame_skip_number_array == NULL)
+		return;
+
+	frame_skip_number = coasting_vtotal_refresh_rate_mhz / flicker_free_refresh_rate_mhz;
+
+	if (frame_skip_number >= 1)
+		frame_skip_number_array[type] = frame_skip_number - 1;
+	else
+		frame_skip_number_array[type] = 0;
+}
+
 void set_replay_defer_update_coasting_vtotal(struct dc_link *link,
 	enum replay_coasting_vtotal_type type,
 	uint32_t vtotal)
@@ -987,6 +1015,8 @@ void update_replay_coasting_vtotal_from_defer(struct dc_link *link,
 {
 	link->replay_settings.coasting_vtotal_table[type] =
 		link->replay_settings.defer_update_coasting_vtotal_table[type];
+	link->replay_settings.frame_skip_number_table[type] =
+		link->replay_settings.defer_frame_skip_number_table[type];
 }
 
 void set_replay_coasting_vtotal(struct dc_link *link,
diff --git a/drivers/gpu/drm/amd/display/modules/power/power_helpers.h b/drivers/gpu/drm/amd/display/modules/power/power_helpers.h
index 391209a3bf29..87d31d9dce5a 100644
--- a/drivers/gpu/drm/amd/display/modules/power/power_helpers.h
+++ b/drivers/gpu/drm/amd/display/modules/power/power_helpers.h
@@ -60,6 +60,11 @@ void set_replay_coasting_vtotal(struct dc_link *link,
 void set_replay_defer_update_coasting_vtotal(struct dc_link *link,
 	enum replay_coasting_vtotal_type type,
 	uint32_t vtotal);
+void set_replay_frame_skip_number(struct dc_link *link,
+	enum replay_coasting_vtotal_type type,
+	uint32_t coasting_vtotal_refresh_rate_Mhz,
+	uint32_t flicker_free_refresh_rate_Mhz,
+	bool is_defer);
 void update_replay_coasting_vtotal_from_defer(struct dc_link *link,
 	enum replay_coasting_vtotal_type type);
 void set_replay_low_rr_full_screen_video_src_vtotal(struct dc_link *link, uint16_t vtotal);
-- 
2.43.0

