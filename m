Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9ABAAD39011
	for <amd-gfx@archiver.kernel.org>; Wed, 14 Jan 2026 20:24:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2B46A10E676;
	Wed, 14 Jan 2026 20:24:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="AAhcnydV";
	dkim-atps=neutral
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012016.outbound.protection.outlook.com [52.101.53.16])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D113F10E243
 for <amd-gfx@lists.freedesktop.org>; Wed, 14 Jan 2026 20:24:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=F7RE+sdhUN4qdlQklQDKyBwXjejkwTOsCPiOxCu7OTXPLIDfoC82RCl65Nu3EA1Csx8HrHuktJSHZHniR72rPZIWJcVS4y6dKxJWUrgjhqrwp6x3mU5tbVMgPGr5HH8UhmlcuDq4sem+a7ONyYFrHhSXpuRUh2IuonNRtNXD/x7K2JJePLKeynjgIQH2lvfBrTeMO2Imb4zYgzT6UZUvvjrSm7XR25+WY4UMO76rT64iqaEu0gJkdpl4+AW8H+fGe0trsXFM+FKw7OvlvZko8oxpnHCwXSKDPAxMtYT21UiQnTyyTtOad013qybK9+1Ec2/lQueKuTOQNfs39gjodg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wSiyy5h9mbbS2C7iPQmkxZjMHBSdenyqPNo8lmkNS/o=;
 b=iZn7+AE/4oVQ0XbtR3OvfKyZvQgw4v8eeBELOqplosM+yQY+ac9EqMwAYv5OQvl/LTjEAT5xed3zzRUj8E/bVCpwKyR4UbdTtQXHbf/1k+l5QTmyOq1lqdgHFFURXfQorhGB/F7A47T9y4PhDtd0P8gYgo/MXX0ptQheHy5+eW6lRaR0uPLJSm/7/BLaJfqH6nKfyVyYsR9uwdRViWKd8S+pHxqpJP+AbMpIC2pdGUbAz9iIc7a9eZpFUp5vep8ZeftZ/YlrhcgPpXe7xhKxBePJLxUukrlV7mWfxkCy2XKOum3UwrqOo9s1yGmnTZnzHpKmMP4BQgQl5CWlUMV1hw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wSiyy5h9mbbS2C7iPQmkxZjMHBSdenyqPNo8lmkNS/o=;
 b=AAhcnydViXwI1IhFjD4iOQ4mJvFhG34gJlUoqlQ73bdnL5m0ZfNboKP8Lbcd++WgFawxz7m1vbG+stIF9yJufr3Bzy837xgcGf9BM7fiacTpinXBV2gYSWGfuV2ft/bbejwPffwGEAKvpusI7CFTL3m2/K2Npkv4cQ3aNX/9ipw=
Received: from SJ0P220CA0028.NAMP220.PROD.OUTLOOK.COM (2603:10b6:a03:41b::11)
 by MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.4; Wed, 14 Jan
 2026 20:24:04 +0000
Received: from SJ5PEPF000001D0.namprd05.prod.outlook.com
 (2603:10b6:a03:41b:cafe::d0) by SJ0P220CA0028.outlook.office365.com
 (2603:10b6:a03:41b::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9499.7 via Frontend Transport; Wed,
 14 Jan 2026 20:24:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001D0.mail.protection.outlook.com (10.167.242.52) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9520.1 via Frontend Transport; Wed, 14 Jan 2026 20:24:04 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 14 Jan
 2026 14:24:02 -0600
Received: from mkmmattstew-dt.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Wed, 14 Jan 2026 14:24:02 -0600
From: Matthew Stewart <Matthew.Stewart2@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, Peichen Huang <PeiChen.Huang@amd.com>, Robin Chen
 <robin.chen@amd.com>, Matthew Stewart <matthew.stewart2@amd.com>
Subject: [PATCH 02/14] drm/amd/display: panel inst for monitors
Date: Wed, 14 Jan 2026 15:21:43 -0500
Message-ID: <20260114202421.3654137-3-Matthew.Stewart2@amd.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260114202421.3654137-1-Matthew.Stewart2@amd.com>
References: <20260114202421.3654137-1-Matthew.Stewart2@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D0:EE_|MN2PR12MB4192:EE_
X-MS-Office365-Filtering-Correlation-Id: 6cd04c0e-abd0-4b3e-77bb-08de53aadc97
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?c2jdXfG3Js4haoSofsrJWSW4WL2evF1w5NaMOAqYQYDPUSo5VRcfm6/SRQX4?=
 =?us-ascii?Q?aF2xbdQ2ylTloHZiwpHMqPNlrHY52qigWe7LUUFEaoF6Myt/XoknuFmgbIA0?=
 =?us-ascii?Q?C4krFs6RE/zKuhN8MiTPFUxbVxMeLn7BmsEyFMPVfTVs0/K4ZdBM4oOv8CHK?=
 =?us-ascii?Q?aXix/PL2gDaNBQJYhprWNF4++l8ZKsJrKu4SWFX3Buq1V5ZilIUeD4kBCq/e?=
 =?us-ascii?Q?v3ZnRWROTXF1sBENlYC9rneXhFLu8egfFkH2uqSXcT29o1gBUsBPXQyDeraO?=
 =?us-ascii?Q?sGCY5bOI+nOiPm7Iw2XdVbChzIJya0YVAybfrHPIwGuWUmotTpnmGpyy1k2y?=
 =?us-ascii?Q?zGy+l2FzPAnd1dybOXt1eJMzH91NYxzHaHodMQNYCONmh57EG7B44/1b2+q1?=
 =?us-ascii?Q?CUAjAfxqqcR0RFdXYTbYJQujtmjbF8HY5yaVt4gbLTnBqM4Qp1UXZt5LCMyW?=
 =?us-ascii?Q?dpsetf2LqtkxPf/nfyGmZPZmI5nReEztcpuVMzi4yPtO5lAVxisDd39TobRP?=
 =?us-ascii?Q?irAKNYtmgqX6XGZ5GFAVzBQhKiXdo0Fjdis2c7dR4qQC/uRNnPyS2k+m+ePe?=
 =?us-ascii?Q?GYqGLaALThKen2itc04UpIeIGjPeqIC4Y8JkyuIKjb40LCRax/ta824fAMOc?=
 =?us-ascii?Q?xiT5uK5JgmAutGMcD/FspPsava35n/Y6Bx+ZuvorFkIEPwhDCLXz7j02TbhG?=
 =?us-ascii?Q?Jr0K72Xlg6v8RhH/PhAK5ARuhqrc0zlNy2myFCqtRWZtA6gMbhWKW0Joz3zS?=
 =?us-ascii?Q?aZtmH5JuRWIGpZhfS3GXhVIkPfmtqTJezo0MJgJW+x43vXIHxgGbIatf7xI5?=
 =?us-ascii?Q?No5uUWwwkJtAAEbdugTQS3Pn4LD+35pwwlSzMeboHdKGyRXyX/2jkcpoSAj1?=
 =?us-ascii?Q?Em0mnrG9WkSsJS9iG4pKwLFAnEKiBwfKk1gk96v7WVMuLC4LtCEg54HT67Xn?=
 =?us-ascii?Q?ijHcjJKxRlHpQCnCr5sCUF+F5//+TblSu46rsm/LDuL/MVvD3GUMNPHlEA5t?=
 =?us-ascii?Q?+BmIpsFDorko5ohS2V0LfuDQPXfmdA33hHp6NrK67rm9CxoiCaO+Z0lnhYLX?=
 =?us-ascii?Q?jnNm3IRSTcdp8OMdSZKQvemOr0DMmRgd9+TKi5wcP906W/60DkCI/X1BAKAA?=
 =?us-ascii?Q?DNKFjPPSx8gWUjBu8KqG/OUv60fqTi/xtLPZMqSNdWXtsQvfwbX1dMJeoysH?=
 =?us-ascii?Q?UVKnuorQ7kJn+VWJB1BClCcgxiMGAyRPXLuqmaCe1I71aNjVnKm1kL7pgi4k?=
 =?us-ascii?Q?9bGW/eKxJc9UWMXoKHz1mpu7lWNASFj6SNs1OO1D54cGHPdo4qOs5dOLnhIb?=
 =?us-ascii?Q?FeSGhZZJcfXVQXmKsHNO8Iu3+xxHdcxZn+LZadl7kXb2Dp1SQpDRmmVukXcD?=
 =?us-ascii?Q?I/Tbiq19pK8pXqjlruptHeupTFIEYGPkVWOKdgyDqIGLHJzW7S1GYjgBedCh?=
 =?us-ascii?Q?rZIcSKKGgwlHn4w57jlMDslOuTiAThSpg+wRUDg1KmXiGmMcifzzRyQR+MjL?=
 =?us-ascii?Q?bYFZEkdMriVUtb6peyGPyqsoovCnAyA7y1XVbyURAeoFsVJNskf4EEwVsvJh?=
 =?us-ascii?Q?iebt4qAKFBQFXlpgRMdV+uKU0aG1ID+2gQAxkF7gCGgS7s9jHzOSi+Y1icDv?=
 =?us-ascii?Q?o1PYvjGwwC/P2Hd8PEaVOQqJhBmy6Aon93TWOVhKfXr5+9l77vLwe9jCpNiI?=
 =?us-ascii?Q?g7l6Kg=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jan 2026 20:24:04.2917 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6cd04c0e-abd0-4b3e-77bb-08de53aadc97
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001D0.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4192
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

[WHY]
To find proper panel replay panel inst for external monitors.

[HOW]
Use otg index as panel replay panel inst.
Both Replay features use the same logic to get panel inst.
Correct the bug that would overwrite panel inst in cmd

Reviewed-by: Robin Chen <robin.chen@amd.com>
Signed-off-by: Peichen Huang <PeiChen.Huang@amd.com>
Signed-off-by: Matthew Stewart <matthew.stewart2@amd.com>
---
 .../dc/link/protocols/link_dp_panel_replay.c  | 32 ++++++++++++-------
 .../link/protocols/link_edp_panel_control.c   | 15 +++++----
 2 files changed, 29 insertions(+), 18 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_panel_replay.c b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_panel_replay.c
index be441851d876..bbd6f93f5c98 100644
--- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_panel_replay.c
+++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_panel_replay.c
@@ -156,13 +156,23 @@ bool dp_pr_get_panel_inst(const struct dc *dc,
 		const struct dc_link *link,
 		unsigned int *inst_out)
 {
-	if (dc_is_embedded_signal(link->connector_signal)) {
-		/* TODO: just get edp link panel inst for now, fix it */
-		return dc_get_edp_link_panel_inst(dc, link, inst_out);
-	} else if (dc_is_dp_sst_signal(link->connector_signal)) {
-		/* TODO: just set to 1 for now, fix it */
-		*inst_out = 1;
-		return true;
+	if (!dc || !link || !inst_out)
+		return false;
+
+	if (!dc_is_dp_sst_signal(link->connector_signal)) /* only supoprt DP sst (eDP included) for now */
+		return false;
+
+	for (unsigned int i = 0; i < MAX_PIPES; i++) {
+		if (dc->current_state->res_ctx.pipe_ctx[i].stream &&
+			dc->current_state->res_ctx.pipe_ctx[i].stream->link == link) {
+			/* *inst_out is equal to otg number */
+			if (dc->current_state->res_ctx.pipe_ctx[i].stream_res.tg)
+				*inst_out = dc->current_state->res_ctx.pipe_ctx[i].stream_res.tg->inst;
+			else
+				*inst_out = 0;
+
+			return true;
+		}
 	}
 
 	return false;
@@ -280,13 +290,13 @@ bool dp_pr_update_state(struct dc_link *link, struct dmub_cmd_pr_update_state_da
 		return false;
 
 	memset(&cmd, 0, sizeof(cmd));
+	memcpy(&cmd.pr_update_state.data, update_state_data, sizeof(struct dmub_cmd_pr_update_state_data));
+
 	cmd.pr_update_state.header.type = DMUB_CMD__PR;
 	cmd.pr_update_state.header.sub_type = DMUB_CMD__PR_UPDATE_STATE;
 	cmd.pr_update_state.header.payload_bytes = sizeof(struct dmub_cmd_pr_update_state_data);
 	cmd.pr_update_state.data.panel_inst = panel_inst;
 
-	memcpy(&cmd.pr_update_state.data, update_state_data, sizeof(struct dmub_cmd_pr_update_state_data));
-
 	dc_wake_and_execute_dmub_cmd(dc->ctx, &cmd, DM_DMUB_WAIT_TYPE_WAIT);
 	return true;
 }
@@ -301,13 +311,13 @@ bool dp_pr_set_general_cmd(struct dc_link *link, struct dmub_cmd_pr_general_cmd_
 		return false;
 
 	memset(&cmd, 0, sizeof(cmd));
+	memcpy(&cmd.pr_general_cmd.data, general_cmd_data, sizeof(struct dmub_cmd_pr_general_cmd_data));
+
 	cmd.pr_general_cmd.header.type = DMUB_CMD__PR;
 	cmd.pr_general_cmd.header.sub_type = DMUB_CMD__PR_GENERAL_CMD;
 	cmd.pr_general_cmd.header.payload_bytes = sizeof(struct dmub_cmd_pr_general_cmd_data);
 	cmd.pr_general_cmd.data.panel_inst = panel_inst;
 
-	memcpy(&cmd.pr_general_cmd.data, general_cmd_data, sizeof(struct dmub_cmd_pr_general_cmd_data));
-
 	dc_wake_and_execute_dmub_cmd(dc->ctx, &cmd, DM_DMUB_WAIT_TYPE_WAIT);
 	return true;
 }
diff --git a/drivers/gpu/drm/amd/display/dc/link/protocols/link_edp_panel_control.c b/drivers/gpu/drm/amd/display/dc/link/protocols/link_edp_panel_control.c
index cb4129c0937a..aa02b38e183a 100644
--- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_edp_panel_control.c
+++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_edp_panel_control.c
@@ -39,6 +39,7 @@
 #include "dce/dmub_replay.h"
 #include "abm.h"
 #include "resource.h"
+#include "link_dp_panel_replay.h"
 #define DC_LOGGER \
 	link->ctx->logger
 #define DC_LOGGER_INIT(logger)
@@ -942,7 +943,7 @@ bool edp_set_replay_allow_active(struct dc_link *link, const bool *allow_active,
 	if (replay == NULL && force_static)
 		return false;
 
-	if (!dc_get_edp_link_panel_inst(dc, link, &panel_inst))
+	if (!dp_pr_get_panel_inst(dc, link, &panel_inst))
 		return false;
 
 	/* Set power optimization flag */
@@ -973,7 +974,7 @@ bool edp_get_replay_state(const struct dc_link *link, uint64_t *state)
 	unsigned int panel_inst;
 	enum replay_state pr_state = REPLAY_STATE_0;
 
-	if (!dc_get_edp_link_panel_inst(dc, link, &panel_inst))
+	if (!dp_pr_get_panel_inst(dc, link, &panel_inst))
 		return false;
 
 	if (replay != NULL && link->replay_settings.replay_feature_enabled)
@@ -1020,7 +1021,7 @@ bool edp_setup_freesync_replay(struct dc_link *link, const struct dc_stream_stat
 	if (!replay)
 		return false;
 
-	if (!dc_get_edp_link_panel_inst(dc, link, &panel_inst))
+	if (!dp_pr_get_panel_inst(dc, link, &panel_inst))
 		return false;
 
 	replay_context.aux_inst = link->ddc->ddc_pin->hw_info.ddc_channel;
@@ -1099,7 +1100,7 @@ bool edp_send_replay_cmd(struct dc_link *link,
 
 	DC_LOGGER_INIT(link->ctx->logger);
 
-	if (dc_get_edp_link_panel_inst(dc, link, &panel_inst))
+	if (dp_pr_get_panel_inst(dc, link, &panel_inst))
 		cmd_data->panel_inst = panel_inst;
 	else {
 		DC_LOG_DC("%s(): get edp panel inst fail ", __func__);
@@ -1120,7 +1121,7 @@ bool edp_set_coasting_vtotal(struct dc_link *link, uint32_t coasting_vtotal, uin
 	if (!replay)
 		return false;
 
-	if (!dc_get_edp_link_panel_inst(dc, link, &panel_inst))
+	if (!dp_pr_get_panel_inst(dc, link, &panel_inst))
 		return false;
 
 	if (coasting_vtotal && (link->replay_settings.coasting_vtotal != coasting_vtotal ||
@@ -1140,7 +1141,7 @@ bool edp_replay_residency(const struct dc_link *link,
 	struct dmub_replay *replay = dc->res_pool->replay;
 	unsigned int panel_inst;
 
-	if (!dc_get_edp_link_panel_inst(dc, link, &panel_inst))
+	if (!dp_pr_get_panel_inst(dc, link, &panel_inst))
 		return false;
 
 	if (!residency)
@@ -1161,7 +1162,7 @@ bool edp_set_replay_power_opt_and_coasting_vtotal(struct dc_link *link,
 	struct dmub_replay *replay = dc->res_pool->replay;
 	unsigned int panel_inst;
 
-	if (!dc_get_edp_link_panel_inst(dc, link, &panel_inst))
+	if (!dp_pr_get_panel_inst(dc, link, &panel_inst))
 		return false;
 
 	/* Only both power and coasting vtotal changed, this func could return true */
-- 
2.52.0

