Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD22FCFD647
	for <amd-gfx@archiver.kernel.org>; Wed,  7 Jan 2026 15:58:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4C63810E628;
	Wed,  7 Jan 2026 15:58:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="L9RY/Keq";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013066.outbound.protection.outlook.com
 [40.93.201.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1682010E633
 for <amd-gfx@lists.freedesktop.org>; Wed,  7 Jan 2026 15:58:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WPeVJywQnneZQx6riYIeDUmjBH1xaEDQFjkpaxUlEx2LaRIi8zHHS5was+YV9z3zvX2PsUkJNUBhQPDA0LSI3dDZS+1QxIK1WaSMhtF9zvdy9pVvQtGi2ofpDVpSdSuVAgvsu2lSOwXCl/RWRXxNCtPcgZn8UbO4oE3qvQNZOgmdoBq98VL9UzB3N23Ey6LRevw8y307zFyo4AnJGEZwIuJ4oqgjn/bqOHn9H9HGPeiWBmTB5PNwFmgMcMXmjog7fnAwESdpNdsXrvjtGFRW/CZ44te1bPhGjt017zoWFM+O4EDQOUBdzqW42ObB/4bTFlOU2L/0TN3Q4xoGAlNIZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EB6zbothXxDPp+pNgKrU9dyU1sh+/8Wl43bmzMz1P3o=;
 b=t6ioUXRdR2siNaeYj+hNWxV3pPdLGSjAIMm5J8WduucorzwSwJdc2hcf9kAOk5VR0thA+KbThVtmozZsFEvKmPSRuTHmNTRSApnz0iAW+x82Q/kHeqFIhTT78nhUqRMd+u8qTChig8KzXVABmo+la9Ov3dW4fcSmAkJKzpq8pdfJcgT0woKxqvgP9wyr1ciwHFDGuWUCM7Hg0Gyn7WIP8YofhF4SrDx7bT1DHLLxPDX/06jdbSoEH79XzZCGiiEuBp5gWD1aQE0Ux8LTYmDDA7rpqbh65FhHyo5WRqsnjc6vcyVTsJ9F6TvGsNmz5eFR5eOwKzgpTEne3vGtLcXV+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EB6zbothXxDPp+pNgKrU9dyU1sh+/8Wl43bmzMz1P3o=;
 b=L9RY/KeqnMxokjPCDI3h6YrkpZxXShO0t4qxNKzPr2iAOdbA9HCEYzjXVlrZvxYsJeCGe7SawNeQKF3sbsRPh0E3MIHdwOHaSh6ndaguSc4IWolFzCnmnPXaSvHyIASOBGSHL/4VkpyQcNlK6cGa5F/cZ67o2pOkruK1HynxzZg=
Received: from CH0P221CA0047.NAMP221.PROD.OUTLOOK.COM (2603:10b6:610:11d::28)
 by LV0PR12MB999092.namprd12.prod.outlook.com (2603:10b6:408:32e::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.2; Wed, 7 Jan
 2026 15:58:12 +0000
Received: from CH2PEPF0000009F.namprd02.prod.outlook.com
 (2603:10b6:610:11d::4) by CH0P221CA0047.outlook.office365.com
 (2603:10b6:610:11d::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9499.2 via Frontend Transport; Wed, 7
 Jan 2026 15:58:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH2PEPF0000009F.mail.protection.outlook.com (10.167.244.21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9499.1 via Frontend Transport; Wed, 7 Jan 2026 15:58:12 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 7 Jan
 2026 09:58:07 -0600
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 7 Jan
 2026 09:58:07 -0600
Received: from mkmmattstew-dt.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Wed, 7 Jan 2026 09:58:06 -0600
From: Matthew Stewart <Matthew.Stewart2@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, Peichen Huang <PeiChen.Huang@amd.com>, Robin Chen
 <robin.chen@amd.com>, Wenjing Liu <wenjing.liu@amd.com>, Matthew Stewart
 <matthew.stewart2@amd.com>
Subject: [PATCH 14/21] drm/amd/display: init code for external panel replay
Date: Wed, 7 Jan 2026 10:48:06 -0500
Message-ID: <20260107155421.1999951-15-Matthew.Stewart2@amd.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260107155421.1999951-1-Matthew.Stewart2@amd.com>
References: <20260107155421.1999951-1-Matthew.Stewart2@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000009F:EE_|LV0PR12MB999092:EE_
X-MS-Office365-Filtering-Correlation-Id: 3de1154c-dc34-413a-4740-08de4e058fdb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?lybzuJhqCWsAy9qnxtPtcTU5z5Q4FYec2kiPdQdP28D6kFaH7L5fQ1m1wi18?=
 =?us-ascii?Q?w3RgNYWq8tXvL74Zuge2eeZCNupMSb+BgPJ/I1nt05CFWkGpKWWN/frzR9ko?=
 =?us-ascii?Q?frJMnAZMLdaYKMUkSLi6flZOjemqb/IzJJXwSgRzuTy4oSUzXDr433X9rKEl?=
 =?us-ascii?Q?0vE09To80pmU7A5YulyZbpGVXOGdO4f/9t0SJ8effr8Pwx5hZnBOujm88Bc3?=
 =?us-ascii?Q?J7gpWL6glGBMgdCOB6zu6U7npV4tfOa5199tUGOsQCHFCbsnDehtcbW/NML/?=
 =?us-ascii?Q?eLFavcHo4wiocOzLRjgeuEMP8fcQP9FC5baCjBYthu76RRaZUmtwOCZDgrYZ?=
 =?us-ascii?Q?PH9VhkUxHontD6rLBERquwi1myj1p0lV1hEnXAzskC/SJ54u3O1K+EVzXMwz?=
 =?us-ascii?Q?EVf8MbOdCDIhhKIjRoFkg/t8kS/U1tS814xLNbtAv69I8QJ45RgciIatgjSc?=
 =?us-ascii?Q?gBRyZYAwf/55FLRQT14FdNZdrSJG7c0kdDS4H2ZlIB7NfHueUBUoFl8Rq0t2?=
 =?us-ascii?Q?xrNkxvUyVorOGVtzgRJmSj7e1/2AowTre5Wkuwmpx/nWPPo4wSEtv58qtL6P?=
 =?us-ascii?Q?Vc+1nXeDaTE7YCl43wrK3gkb6RyEt9VxO75FYpiNknRnXKXCE7KI5SZaeK8e?=
 =?us-ascii?Q?01zYLEZXKAohwOnMDqiNkI5M5ei7szTL06omycp17sg5a+Ub99E5a0kUir7+?=
 =?us-ascii?Q?iqteZQTlEtPebkzvz2hsXDyaSNTy4WNmVXpsPTD+4aUOYodhtDOBkGN64Tcq?=
 =?us-ascii?Q?81QanH/jYRPCY/aqUF8LyGZd0lqQ2J1xiwQAUJhZe7FtyZVTZ3YasiE8mwkh?=
 =?us-ascii?Q?nOr4gVhC/3sUEkrNCSJ0Vq+3mdR9fU+lrliRww/Pveo9kf82ZcqFMTv0OK8t?=
 =?us-ascii?Q?n7Bm2pOsvRKRWE4IZQu3x671VcoNgaQuLErAzhOhGLvAY+FKa9lHEpBAHGaq?=
 =?us-ascii?Q?XI+H8nKzHgnbcpW6rNwEBHXrkO90BLnDwVxt6DrxRpEJtxo6rbtvzlK4g8tY?=
 =?us-ascii?Q?HuvOdvSTbzmeLnTauqKiC0R84TOseNN6rWtqN0rtG4zuig8DIsTLuItawSaB?=
 =?us-ascii?Q?olicDIy/JsDxI/mnEZmMH7sB2RGkQN/Yuaab4pHyGSRSzsF0uxWQxABW5Wxe?=
 =?us-ascii?Q?8s0cQv4GgMNThhc9KDHMu6SSaPuZjSjvF2YX8ivyiyHhehYAElQ7HF8ezyyP?=
 =?us-ascii?Q?6Fs2/O7PAX0uy1Kb87lEQF3XzV5npaPbbxpTlu2yA3tcdPAeedCthwo2+C45?=
 =?us-ascii?Q?Ys9Plet/Nd6PiRrD5MdijBbiok82Sjnmn91IimKX1g9/f+zWSDHa1RYAQayq?=
 =?us-ascii?Q?2R8ZBOgGV/QcQg5CP3TI+oFngiDXY5gwEdz6+2mN8DvxV/q6xWcuIf66FVW8?=
 =?us-ascii?Q?nh67ZdytpH+xRod0ZlYPd9EsW+hrMmfryab6JCyZiS6YYqrpCN5BxfUgJdQ5?=
 =?us-ascii?Q?AmaoBpvlmiz9w+5g9L+LGJldYgG1b0gXdbPy4MsIj34GRuPDod985/NrkJFo?=
 =?us-ascii?Q?FhZunUYVmjVkHRR3TuqNr6NviNcwYYYETTaoltel3ZbBob8A3Az7I9Roc78r?=
 =?us-ascii?Q?AhnnEuyH57IYvzgMxg4=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jan 2026 15:58:12.8178 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3de1154c-dc34-413a-4740-08de4e058fdb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF0000009F.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV0PR12MB999092
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

From: Peichen Huang <PeiChen.Huang@amd.com>

Prepare for supporting panel replay on external monitors.

Reviewed-by: Robin Chen <robin.chen@amd.com>
Reviewed-by: Wenjing Liu <wenjing.liu@amd.com>
Signed-off-by: Peichen Huang <PeiChen.Huang@amd.com>
Signed-off-by: Matthew Stewart <matthew.stewart2@amd.com>
---
 .../drm/amd/display/dc/dce/dmub_hw_lock_mgr.c |  2 +-
 .../gpu/drm/amd/display/dc/inc/link_service.h |  4 +-
 .../gpu/drm/amd/display/dc/link/link_dpms.c   |  4 ++
 .../drm/amd/display/dc/link/link_factory.c    |  1 +
 .../dc/link/protocols/link_dp_panel_replay.c  | 53 +++++++++++++------
 .../dc/link/protocols/link_dp_panel_replay.h  |  4 +-
 6 files changed, 47 insertions(+), 21 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dce/dmub_hw_lock_mgr.c b/drivers/gpu/drm/amd/display/dc/dce/dmub_hw_lock_mgr.c
index 5bfa2b0d2afd..7116fdd4c7ec 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dmub_hw_lock_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/dce/dmub_hw_lock_mgr.c
@@ -69,7 +69,7 @@ bool dmub_hw_lock_mgr_does_link_require_lock(const struct dc *dc, const struct d
 	if (link->psr_settings.psr_version == DC_PSR_VERSION_SU_1)
 		return true;
 
-	if (link->replay_settings.replay_feature_enabled)
+	if (link->replay_settings.replay_feature_enabled && dc_is_embedded_signal(link->connector_signal))
 		return true;
 
 	if (link->psr_settings.psr_version == DC_PSR_VERSION_1) {
diff --git a/drivers/gpu/drm/amd/display/dc/inc/link_service.h b/drivers/gpu/drm/amd/display/dc/inc/link_service.h
index 5885b4abdf38..57bb82e94942 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/link_service.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/link_service.h
@@ -283,8 +283,6 @@ struct link_service {
 	bool (*edp_set_replay_allow_active)(struct dc_link *dc_link,
 			const bool *enable, bool wait, bool force_static,
 			const unsigned int *power_opts);
-	bool (*dp_setup_replay)(struct dc_link *link,
-			const struct dc_stream_state *stream);
 	bool (*edp_send_replay_cmd)(struct dc_link *link,
 			enum replay_FW_Message_type msg,
 			union dmub_replay_cmd_set *cmd_data);
@@ -304,6 +302,8 @@ struct link_service {
 	bool (*edp_receiver_ready_T9)(struct dc_link *link);
 	bool (*edp_receiver_ready_T7)(struct dc_link *link);
 	bool (*edp_power_alpm_dpcd_enable)(struct dc_link *link, bool enable);
+	bool (*dp_setup_replay)(struct dc_link *link, const struct dc_stream_state *stream);
+	bool (*dp_pr_get_panel_inst)(const struct dc *dc, const struct dc_link *link, unsigned int *inst_out);
 	bool (*dp_pr_enable)(struct dc_link *link, bool enable);
 	bool (*dp_pr_update_state)(struct dc_link *link, struct dmub_cmd_pr_update_state_data *update_state_data);
 	bool (*dp_pr_set_general_cmd)(struct dc_link *link, struct dmub_cmd_pr_general_cmd_data *general_cmd_data);
diff --git a/drivers/gpu/drm/amd/display/dc/link/link_dpms.c b/drivers/gpu/drm/amd/display/dc/link/link_dpms.c
index 7e46ea98952c..91742bde4dc2 100644
--- a/drivers/gpu/drm/amd/display/dc/link/link_dpms.c
+++ b/drivers/gpu/drm/amd/display/dc/link/link_dpms.c
@@ -46,6 +46,7 @@
 #include "protocols/link_dp_capability.h"
 #include "protocols/link_dp_training.h"
 #include "protocols/link_edp_panel_control.h"
+#include "protocols/link_dp_panel_replay.h"
 #include "protocols/link_dp_dpia_bw.h"
 
 #include "dm_helpers.h"
@@ -2529,6 +2530,9 @@ void link_set_dpms_on(
 			link_set_dsc_enable(pipe_ctx, true);
 	}
 
+	if (link->replay_settings.config.replay_supported && !dc_is_embedded_signal(link->connector_signal))
+		dp_setup_replay(link, stream);
+
 	status = enable_link(state, pipe_ctx);
 
 	if (status != DC_OK) {
diff --git a/drivers/gpu/drm/amd/display/dc/link/link_factory.c b/drivers/gpu/drm/amd/display/dc/link/link_factory.c
index e185f2caad0c..5fbcf04c6251 100644
--- a/drivers/gpu/drm/amd/display/dc/link/link_factory.c
+++ b/drivers/gpu/drm/amd/display/dc/link/link_factory.c
@@ -236,6 +236,7 @@ static void construct_link_service_edp_panel_control(struct link_service *link_s
 static void construct_link_service_dp_panel_replay(struct link_service *link_srv)
 {
 	link_srv->dp_setup_replay = dp_setup_replay;
+	link_srv->dp_pr_get_panel_inst = dp_pr_get_panel_inst;
 	link_srv->dp_pr_enable = dp_pr_enable;
 	link_srv->dp_pr_update_state = dp_pr_update_state;
 	link_srv->dp_pr_set_general_cmd = dp_pr_set_general_cmd;
diff --git a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_panel_replay.c b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_panel_replay.c
index fdbfa5103183..be441851d876 100644
--- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_panel_replay.c
+++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_panel_replay.c
@@ -75,7 +75,7 @@ static bool dp_setup_panel_replay(struct dc_link *link, const struct dc_stream_s
 	if (!replay)
 		return false;
 
-	if (!dc_get_edp_link_panel_inst(dc, link, &panel_inst))
+	if (!dp_pr_get_panel_inst(dc, link, &panel_inst))
 		return false;
 
 	replay_context.aux_inst = link->ddc->ddc_pin->hw_info.ddc_channel;
@@ -103,14 +103,18 @@ static bool dp_setup_panel_replay(struct dc_link *link, const struct dc_stream_s
 	link->replay_settings.replay_feature_enabled = dp_pr_copy_settings(link, &replay_context);
 
 	if (link->replay_settings.replay_feature_enabled) {
-		pr_config_1.bits.PANEL_REPLAY_ENABLE = 1;
-		pr_config_1.bits.PANEL_REPLAY_CRC_ENABLE = 1;
-		pr_config_1.bits.IRQ_HPD_ASSDP_MISSING = 1;
-		pr_config_1.bits.IRQ_HPD_VSCSDP_UNCORRECTABLE_ERROR = 1;
-		pr_config_1.bits.IRQ_HPD_RFB_ERROR = 1;
-		pr_config_1.bits.IRQ_HPD_ACTIVE_FRAME_CRC_ERROR = 1;
-		pr_config_1.bits.PANEL_REPLAY_SELECTIVE_UPDATE_ENABLE = 1;
-		pr_config_1.bits.PANEL_REPLAY_EARLY_TRANSPORT_ENABLE = 1;
+		if (dc_is_embedded_signal(link->connector_signal)) {
+			pr_config_1.bits.PANEL_REPLAY_ENABLE = 1;
+			pr_config_1.bits.PANEL_REPLAY_CRC_ENABLE = 1;
+			pr_config_1.bits.IRQ_HPD_ASSDP_MISSING = 1;
+			pr_config_1.bits.IRQ_HPD_VSCSDP_UNCORRECTABLE_ERROR = 1;
+			pr_config_1.bits.IRQ_HPD_RFB_ERROR = 1;
+			pr_config_1.bits.IRQ_HPD_ACTIVE_FRAME_CRC_ERROR = 1;
+			pr_config_1.bits.PANEL_REPLAY_SELECTIVE_UPDATE_ENABLE = 1;
+			pr_config_1.bits.PANEL_REPLAY_EARLY_TRANSPORT_ENABLE = 1;
+		} else {
+			pr_config_1.bits.PANEL_REPLAY_ENABLE = 1;
+		}
 
 		pr_config_2.bits.SINK_REFRESH_RATE_UNLOCK_GRANTED = 0;
 
@@ -147,6 +151,23 @@ static bool dp_setup_panel_replay(struct dc_link *link, const struct dc_stream_s
 	return true;
 }
 
+
+bool dp_pr_get_panel_inst(const struct dc *dc,
+		const struct dc_link *link,
+		unsigned int *inst_out)
+{
+	if (dc_is_embedded_signal(link->connector_signal)) {
+		/* TODO: just get edp link panel inst for now, fix it */
+		return dc_get_edp_link_panel_inst(dc, link, inst_out);
+	} else if (dc_is_dp_sst_signal(link->connector_signal)) {
+		/* TODO: just set to 1 for now, fix it */
+		*inst_out = 1;
+		return true;
+	}
+
+	return false;
+}
+
 bool dp_setup_replay(struct dc_link *link, const struct dc_stream_state *stream)
 {
 	if (!link)
@@ -165,7 +186,7 @@ bool dp_pr_enable(struct dc_link *link, bool enable)
 	unsigned int panel_inst = 0;
 	union dmub_rb_cmd cmd;
 
-	if (!dc_get_edp_link_panel_inst(dc, link, &panel_inst))
+	if (!dp_pr_get_panel_inst(dc, link, &panel_inst))
 		return false;
 
 	if (link->replay_settings.replay_allow_active != enable) {
@@ -192,16 +213,16 @@ bool dp_pr_copy_settings(struct dc_link *link, struct replay_context *replay_con
 	union dmub_rb_cmd cmd;
 	struct pipe_ctx *pipe_ctx = NULL;
 
-	if (!dc_get_edp_link_panel_inst(dc, link, &panel_inst))
+	if (!dp_pr_get_panel_inst(dc, link, &panel_inst))
 		return false;
 
 	for (unsigned int i = 0; i < MAX_PIPES; i++) {
 		if (dc->current_state->res_ctx.pipe_ctx[i].stream &&
 			dc->current_state->res_ctx.pipe_ctx[i].stream->link &&
 			dc->current_state->res_ctx.pipe_ctx[i].stream->link == link &&
-			dc->current_state->res_ctx.pipe_ctx[i].stream->link->connector_signal == SIGNAL_TYPE_EDP) {
+			dc_is_dp_sst_signal(dc->current_state->res_ctx.pipe_ctx[i].stream->link->connector_signal)) {
 			pipe_ctx = &dc->current_state->res_ctx.pipe_ctx[i];
-			//TODO: refactor for multi edp support
+			/* todo: need update for MST */
 			break;
 		}
 	}
@@ -255,7 +276,7 @@ bool dp_pr_update_state(struct dc_link *link, struct dmub_cmd_pr_update_state_da
 	unsigned int panel_inst = 0;
 	union dmub_rb_cmd cmd;
 
-	if (!dc_get_edp_link_panel_inst(dc, link, &panel_inst))
+	if (!dp_pr_get_panel_inst(dc, link, &panel_inst))
 		return false;
 
 	memset(&cmd, 0, sizeof(cmd));
@@ -276,7 +297,7 @@ bool dp_pr_set_general_cmd(struct dc_link *link, struct dmub_cmd_pr_general_cmd_
 	unsigned int panel_inst = 0;
 	union dmub_rb_cmd cmd;
 
-	if (!dc_get_edp_link_panel_inst(dc, link, &panel_inst))
+	if (!dp_pr_get_panel_inst(dc, link, &panel_inst))
 		return false;
 
 	memset(&cmd, 0, sizeof(cmd));
@@ -298,7 +319,7 @@ bool dp_pr_get_state(const struct dc_link *link, uint64_t *state)
 	uint32_t retry_count = 0;
 	uint32_t replay_state = 0;
 
-	if (!dc_get_edp_link_panel_inst(dc, link, &panel_inst))
+	if (!dp_pr_get_panel_inst(dc, link, &panel_inst))
 		return false;
 
 	do {
diff --git a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_panel_replay.h b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_panel_replay.h
index b936092edb85..5522d5911fd1 100644
--- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_panel_replay.h
+++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_panel_replay.h
@@ -27,8 +27,8 @@
 
 #include "link_service.h"
 
-bool dp_setup_replay(struct dc_link *link,
-		const struct dc_stream_state *stream);
+bool dp_setup_replay(struct dc_link *link, const struct dc_stream_state *stream);
+bool dp_pr_get_panel_inst(const struct dc *dc, const struct dc_link *link, unsigned int *inst_out);
 bool dp_pr_enable(struct dc_link *link, bool enable);
 bool dp_pr_copy_settings(struct dc_link *link, struct replay_context *replay_context);
 bool dp_pr_update_state(struct dc_link *link, struct dmub_cmd_pr_update_state_data *update_state_data);
-- 
2.52.0

