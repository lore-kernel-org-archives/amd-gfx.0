Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBEEFCD343F
	for <amd-gfx@archiver.kernel.org>; Wed, 12 Nov 2025 18:23:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7FDD110E78F;
	Wed, 12 Nov 2025 18:23:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="n6Y+fUJ6";
	dkim-atps=neutral
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012009.outbound.protection.outlook.com [40.107.209.9])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 64C2210E1CA
 for <amd-gfx@lists.freedesktop.org>; Wed, 12 Nov 2025 18:23:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rPuL43FrCW8rQEKKwwPh9vD4ylgjC3DtVTqsr5jQZwFXrSc6B9jlDlJsAA3BVQc/cKBiTRxEHED8QjHMx0WZNumlBGWuALdt6Aw7+CQ0IwM4i6g8JKJu+slCIKCqa/yHzqDYbgY/C90OZ7Xd/nzUA4xNiVNHds+A1gjJsJVMWdwaqC5RL5R0YlP8IYb/Anu7O/dEDGSAMbuKhZrRRy5LvlhHH0YE1lbX0KKcPUECy5KQ+eKZ5ck+trtc1VbJKRb0lOaz8BFsJpyQegdJTRy1jHlPi7gGMUuY2rWfbUYksUromV4+UETE8idr9xmVudyxXhYSLzlMGyIv16SyJzg47Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EfJFFyNw1OEGvGVxlD2yXyUceptPJH4sh1nq2acNU7I=;
 b=cjHkkA0MOKmCKAotiFZsy2/ZMpZ74ePo7N2/CCd+Syq7nPNxN/CTvDewg6UZ+puewX1fEUg8b6aFGeeBPJqg2ho5A3dWGGOE7XcyHxUJ2+c+BDMlazTtiupiYUbURCu8whW56jFK51wVkewuU5Ck8dLMAbdGBh/BLKp2rLRyZaDt2Emg7Udk8G5jVaZX6CjrtjMUIeP5eA3iwoWy0nIm5DGJf78rAWL0iKv9QNqSNN0CPHiL944iL7DXzLiptO8rirtUagbsFIw44WZZllb6GwIUyc+XdJwlk4+sS5qLCiElF948aajAYR7n3SgxKYbRzLvWKLpbJBT9R4RpNCmvOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EfJFFyNw1OEGvGVxlD2yXyUceptPJH4sh1nq2acNU7I=;
 b=n6Y+fUJ6GLtqsDmgWJq3GnvrLb+OxKi4Bn0+dQIl4RymgWVar8HOTq2cu7F8AaXnO4NFP6PEVIPDXc3RDmpW/NUxT+arlapaw0m+t2KEv+4OWUDaNIUVTwVNAfErjvUjhIWTP3bCCaHBlLrnAUTIVRM9Xzc1m9JpgJkh5x12G50=
Received: from BN9PR03CA0631.namprd03.prod.outlook.com (2603:10b6:408:13b::6)
 by SA1PR12MB7128.namprd12.prod.outlook.com (2603:10b6:806:29c::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.15; Wed, 12 Nov
 2025 18:22:57 +0000
Received: from BL6PEPF0001AB53.namprd02.prod.outlook.com
 (2603:10b6:408:13b:cafe::fb) by BN9PR03CA0631.outlook.office365.com
 (2603:10b6:408:13b::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9320.16 via Frontend Transport; Wed,
 12 Nov 2025 18:22:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF0001AB53.mail.protection.outlook.com (10.167.241.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9320.13 via Frontend Transport; Wed, 12 Nov 2025 18:22:56 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Wed, 12 Nov
 2025 10:22:49 -0800
Received: from satlexmb07.amd.com (10.181.42.216) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 12 Nov
 2025 12:22:48 -0600
Received: from box-0.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Wed, 12 Nov 2025 10:22:48 -0800
From: <IVAN.LIPSKI@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, Nicholas Carbones <ncarbone@amd.com>, George Shen
 <george.shen@amd.com>
Subject: [PATCH 10/16] drm/amd/display: Add pipe topology history to dc
Date: Wed, 12 Nov 2025 13:20:28 -0500
Message-ID: <20251112182212.559007-11-IVAN.LIPSKI@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251112182212.559007-3-IVAN.LIPSKI@amd.com>
References: <20251112182212.559007-3-IVAN.LIPSKI@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: IVAN.LIPSKI@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB53:EE_|SA1PR12MB7128:EE_
X-MS-Office365-Filtering-Correlation-Id: 2e2d25cd-42e3-43a9-0a8a-08de221880d6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ukCqSfLzBiPp5Ro1dpDwoOtsah5puVo68EfCQF5JZOReddchbPhLLvqgXSAD?=
 =?us-ascii?Q?KYKu6Guqe8sSP/fazW659/1Ew1m7F6fjhkCVWdYjLumsjbt6gFrKnmOxt9pE?=
 =?us-ascii?Q?tO2fI/sZkWQ7Wx9/UrOlim5mMRhHg0ZyFMsE30RVoZUKIOM4jYdv5gA+Ooyk?=
 =?us-ascii?Q?PBwhWdvVTBw+HzDEGYlUFJPwBm8JjqF+zy55nmS6hIb9yd5GhIROJFu2b9r8?=
 =?us-ascii?Q?YPMsL+tPDKIKXYzPF4R9ngKReIp7wJeWDZRBUq0R9ieaQSQljoa6pEAXttVf?=
 =?us-ascii?Q?a4fpVFl5qtRXOFIoj8gMxVVIZnvaKVBoVu5PhCgCqqy9/89rJVkDUoX//KYU?=
 =?us-ascii?Q?qf2yFnYNetwIsgGqBlWNjmk2zV5s97rLaYuH4asWQh/6ylrY/54L85Z2v1eu?=
 =?us-ascii?Q?vxzpvlKPgGDqKEbv2dAg/s5ubnuE0mv7WdN1q8eub2Vdvl6qD2w4NMY/nNfa?=
 =?us-ascii?Q?FJoCQGzbv1eLi7f2lZK8xef1Xp1cEyY8RIBwCrm5EFA4xyo4p9qgQE4VEJSP?=
 =?us-ascii?Q?XNgZtJpeVvJ+E0RKd9MFO+gduIZ6yYNyvkW5PGYh9lFSMZalVD5RRvyLGtta?=
 =?us-ascii?Q?/cEIGkkwilQrE6G/w73vhAKBR/ZDPsCUDlNV5J9PjbFYxn/c4VHhBpxaeDff?=
 =?us-ascii?Q?fJPB2zaZAjreiEC0VJUKrRKIAmyuLZNAEgcoQyBnCrHLPxfHYdiQT7UdTz3b?=
 =?us-ascii?Q?D1LhkrMTjqRHy0QcCUt8qsiKHOF6oXYq9p3buW5I1inyFwd6qQEgSJATiFJz?=
 =?us-ascii?Q?wi46pE37b0H6R1+m1fFCTG9Sq5yZKZxsFO4ih0uBzKdHuTDAySsQUISXcERU?=
 =?us-ascii?Q?UQ7dakWrEhdQWXLW/u1Da9pSnmRT2KejnNSB+RfS5BU/gY5yFAXIaY8hzD6t?=
 =?us-ascii?Q?XxkE2vjpb/ZNRn2bNzhXUr4tjQJjCIeXg50595tL6eFI4dl5v9LeSF1yVu8h?=
 =?us-ascii?Q?WJAk22XSj2SNuNNC0e1125j4c5fJIxoJ+RVXMfkckcpuJHjM1+iHfPvuoJRN?=
 =?us-ascii?Q?hh/g5/+ISqAGTho9tbsJvqbK/H4kNt3tJv+Q2FeXSkj9Hc9VE7FutJ5voK62?=
 =?us-ascii?Q?WfaKMXbzaEqi3I9F78Cv9APvssEJ3EI+mtW0uYwjzuvIale87GXL0rl/Cs+n?=
 =?us-ascii?Q?Zm6XkE9lkaopsbM8ITC3sYf8ZCtFPp+UUqYtvmV2MsQhXwy0XxXP6FjKevfD?=
 =?us-ascii?Q?9mziUowknq2TBf1VwGgwCyBA0FOErL0AbRqd3PK9y2k4KW8sRDCjCkf/xtqP?=
 =?us-ascii?Q?v82duFYVF2s4TZd/lGIGSJXWmwvowAuJM4r62QMIBPnFglqQnKxUsjsbBjE4?=
 =?us-ascii?Q?lxk6wQpCPJG1UtHQfqQsBi93ngvizupP61FaUAxdyNmsKubyLJFaGLaUc0mj?=
 =?us-ascii?Q?7byGAECOLnPSnxxZOJ4x1xtRT0Z1YHb8EDJBf15a+kI3ro89q/M6hWnh/L2p?=
 =?us-ascii?Q?9LyxQdeNOES2wQPYdw6/4yZWQO8Qg7JiVhi6lbBKZCN/H6JQwHW3K80qHHtL?=
 =?us-ascii?Q?TtIF+CpQl2d9BDS2ZKSxjD1BqcCcKF3609j5sxQ+CBIwqbER0Q0uebPIPCze?=
 =?us-ascii?Q?JrByMbyEzLAKcMBcidM=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2025 18:22:56.8824 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e2d25cd-42e3-43a9-0a8a-08de221880d6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB53.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7128
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

From: Nicholas Carbones <ncarbone@amd.com>

[Why]
There is no way to check pipe topology update history through a
dump.

[How]
Add a topology history structure to dc with snapshots of the most recent
pipe topology updates.

Reviewed-by: George Shen <george.shen@amd.com>
Signed-off-by: Nicholas Carbones <ncarbone@amd.com>
Signed-off-by: Ivan Lipski <ivan.lipski@amd.com>
---
 .../gpu/drm/amd/display/dc/core/dc_resource.c | 76 +++++++++++++++++--
 drivers/gpu/drm/amd/display/dc/dc.h           |  1 +
 .../gpu/drm/amd/display/dc/inc/hw/hw_shared.h | 26 +++++++
 3 files changed, 97 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
index dc0c4065a92c..848c267ef11e 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
@@ -99,6 +99,40 @@
 
 #define UNABLE_TO_SPLIT -1
 
+static void capture_pipe_topology_data(struct dc *dc, int plane_idx, int slice_idx, int stream_idx,
+									   int dpp_inst, int opp_inst, int tg_inst, bool is_phantom_pipe)
+{
+	struct pipe_topology_snapshot *current_snapshot = &dc->debug_data.topology_history.snapshots[dc->debug_data.topology_history.current_snapshot_index];
+
+	if (current_snapshot->line_count >= MAX_PIPES)
+		return;
+
+	current_snapshot->pipe_log_lines[current_snapshot->line_count].is_phantom_pipe = is_phantom_pipe;
+	current_snapshot->pipe_log_lines[current_snapshot->line_count].plane_idx = plane_idx;
+	current_snapshot->pipe_log_lines[current_snapshot->line_count].slice_idx = slice_idx;
+	current_snapshot->pipe_log_lines[current_snapshot->line_count].stream_idx = stream_idx;
+	current_snapshot->pipe_log_lines[current_snapshot->line_count].dpp_inst = dpp_inst;
+	current_snapshot->pipe_log_lines[current_snapshot->line_count].opp_inst = opp_inst;
+	current_snapshot->pipe_log_lines[current_snapshot->line_count].tg_inst = tg_inst;
+
+	current_snapshot->line_count++;
+}
+
+static void start_new_topology_snapshot(struct dc *dc, struct dc_state *state)
+{
+	// Move to next snapshot slot (circular buffer)
+	dc->debug_data.topology_history.current_snapshot_index = (dc->debug_data.topology_history.current_snapshot_index + 1) % MAX_TOPOLOGY_SNAPSHOTS;
+
+	// Clear the new snapshot
+	struct pipe_topology_snapshot *current_snapshot = &dc->debug_data.topology_history.snapshots[dc->debug_data.topology_history.current_snapshot_index];
+	memset(current_snapshot, 0, sizeof(*current_snapshot));
+
+	// Set metadata
+	current_snapshot->timestamp_us = dm_get_timestamp(dc->ctx);
+	current_snapshot->stream_count = state->stream_count;
+	current_snapshot->phantom_stream_count = state->phantom_stream_count;
+}
+
 enum dce_version resource_parse_asic_id(struct hw_asic_id asic_id)
 {
 	enum dce_version dc_version = DCE_VERSION_UNKNOWN;
@@ -2311,10 +2345,11 @@ bool resource_is_odm_topology_changed(const struct pipe_ctx *otg_master_a,
 
 static void resource_log_pipe(struct dc *dc, struct pipe_ctx *pipe,
 		int stream_idx, int slice_idx, int plane_idx, int slice_count,
-		bool is_primary)
+		bool is_primary, bool is_phantom_pipe)
 {
 	DC_LOGGER_INIT(dc->ctx->logger);
 
+	// new format for logging: bit storing code
 	if (slice_idx == 0 && plane_idx == 0 && is_primary) {
 		/* case 0 (OTG master pipe with plane) */
 		DC_LOG_DC(" | plane%d  slice%d  stream%d|",
@@ -2323,6 +2358,10 @@ static void resource_log_pipe(struct dc *dc, struct pipe_ctx *pipe,
 				pipe->plane_res.dpp->inst,
 				pipe->stream_res.opp->inst,
 				pipe->stream_res.tg->inst);
+		capture_pipe_topology_data(dc, plane_idx, slice_idx, stream_idx,
+				pipe->plane_res.dpp->inst,
+				pipe->stream_res.opp->inst,
+				pipe->stream_res.tg->inst, is_phantom_pipe);
 	} else if (slice_idx == 0 && plane_idx == -1) {
 		/* case 1 (OTG master pipe without plane) */
 		DC_LOG_DC(" |         slice%d  stream%d|",
@@ -2331,6 +2370,10 @@ static void resource_log_pipe(struct dc *dc, struct pipe_ctx *pipe,
 				pipe->stream_res.opp->inst,
 				pipe->stream_res.opp->inst,
 				pipe->stream_res.tg->inst);
+		capture_pipe_topology_data(dc, 0xF, slice_idx, stream_idx,
+				pipe->plane_res.dpp->inst,
+				pipe->stream_res.opp->inst,
+				pipe->stream_res.tg->inst, is_phantom_pipe);
 	} else if (slice_idx != 0 && plane_idx == 0 && is_primary) {
 		/* case 2 (OPP head pipe with plane) */
 		DC_LOG_DC(" | plane%d  slice%d |       |",
@@ -2338,27 +2381,43 @@ static void resource_log_pipe(struct dc *dc, struct pipe_ctx *pipe,
 		DC_LOG_DC(" |DPP%d----OPP%d----|       |",
 				pipe->plane_res.dpp->inst,
 				pipe->stream_res.opp->inst);
+		capture_pipe_topology_data(dc, plane_idx, slice_idx, stream_idx,
+				pipe->plane_res.dpp->inst,
+				pipe->stream_res.opp->inst,
+				pipe->stream_res.tg->inst, is_phantom_pipe);
 	} else if (slice_idx != 0 && plane_idx == -1) {
 		/* case 3 (OPP head pipe without plane) */
 		DC_LOG_DC(" |         slice%d |       |", slice_idx);
 		DC_LOG_DC(" |DPG%d----OPP%d----|       |",
 				pipe->plane_res.dpp->inst,
 				pipe->stream_res.opp->inst);
+		capture_pipe_topology_data(dc, 0xF, slice_idx, stream_idx,
+				pipe->plane_res.dpp->inst,
+				pipe->stream_res.opp->inst,
+				pipe->stream_res.tg->inst, is_phantom_pipe);
 	} else if (slice_idx == slice_count - 1) {
 		/* case 4 (DPP pipe in last slice) */
 		DC_LOG_DC(" | plane%d |               |", plane_idx);
 		DC_LOG_DC(" |DPP%d----|               |",
 				pipe->plane_res.dpp->inst);
+		capture_pipe_topology_data(dc, plane_idx, slice_idx, stream_idx,
+				pipe->plane_res.dpp->inst,
+				pipe->stream_res.opp->inst,
+				pipe->stream_res.tg->inst, is_phantom_pipe);
 	} else {
 		/* case 5 (DPP pipe not in last slice) */
 		DC_LOG_DC(" | plane%d |       |       |", plane_idx);
 		DC_LOG_DC(" |DPP%d----|       |       |",
 				pipe->plane_res.dpp->inst);
+		capture_pipe_topology_data(dc, plane_idx, slice_idx, stream_idx,
+				pipe->plane_res.dpp->inst,
+				pipe->stream_res.opp->inst,
+				pipe->stream_res.tg->inst, is_phantom_pipe);
 	}
 }
 
 static void resource_log_pipe_for_stream(struct dc *dc, struct dc_state *state,
-		struct pipe_ctx *otg_master, int stream_idx)
+		struct pipe_ctx *otg_master, int stream_idx, bool is_phantom_pipe)
 {
 	struct pipe_ctx *opp_heads[MAX_PIPES];
 	struct pipe_ctx *dpp_pipes[MAX_PIPES];
@@ -2384,12 +2443,12 @@ static void resource_log_pipe_for_stream(struct dc *dc, struct dc_state *state,
 				resource_log_pipe(dc, dpp_pipes[dpp_idx],
 						stream_idx, slice_idx,
 						plane_idx, slice_count,
-						is_primary);
+						is_primary, is_phantom_pipe);
 			}
 		} else {
 			resource_log_pipe(dc, opp_heads[slice_idx],
 					stream_idx, slice_idx, plane_idx,
-					slice_count, true);
+					slice_count, true, is_phantom_pipe);
 		}
 
 	}
@@ -2420,6 +2479,10 @@ void resource_log_pipe_topology_update(struct dc *dc, struct dc_state *state)
 	struct pipe_ctx *otg_master;
 	int stream_idx, phantom_stream_idx;
 	DC_LOGGER_INIT(dc->ctx->logger);
+	bool is_phantom_pipe = false;
+
+	// Start a new snapshot for this topology update
+	start_new_topology_snapshot(dc, state);
 
 	DC_LOG_DC("    pipe topology update");
 	DC_LOG_DC("  ________________________");
@@ -2433,9 +2496,10 @@ void resource_log_pipe_topology_update(struct dc *dc, struct dc_state *state)
 		if (!otg_master)
 			continue;
 
-		resource_log_pipe_for_stream(dc, state, otg_master, stream_idx);
+		resource_log_pipe_for_stream(dc, state, otg_master, stream_idx, is_phantom_pipe);
 	}
 	if (state->phantom_stream_count > 0) {
+		is_phantom_pipe = true;
 		DC_LOG_DC(" |    (phantom pipes)     |");
 		for (stream_idx = 0; stream_idx < state->stream_count; stream_idx++) {
 			if (state->stream_status[stream_idx].mall_stream_config.type != SUBVP_MAIN)
@@ -2448,7 +2512,7 @@ void resource_log_pipe_topology_update(struct dc *dc, struct dc_state *state)
 			if (!otg_master)
 				continue;
 
-			resource_log_pipe_for_stream(dc, state, otg_master, stream_idx);
+			resource_log_pipe_for_stream(dc, state, otg_master, stream_idx, is_phantom_pipe);
 		}
 	}
 	DC_LOG_DC(" |________________________|\n");
diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index 2396c2806a7f..2016d75c21a0 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -899,6 +899,7 @@ struct dc_debug_data {
 	uint32_t ltFailCount;
 	uint32_t i2cErrorCount;
 	uint32_t auxErrorCount;
+	struct pipe_topology_history topology_history;
 };
 
 struct dc_phy_addr_space_config {
diff --git a/drivers/gpu/drm/amd/display/dc/inc/hw/hw_shared.h b/drivers/gpu/drm/amd/display/dc/inc/hw/hw_shared.h
index 5e2813e9ae2f..2bc86777dfb6 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/hw/hw_shared.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/hw/hw_shared.h
@@ -80,6 +80,32 @@
 #define MAX_HPO_DP2_ENCODERS	4
 #define MAX_HPO_DP2_LINK_ENCODERS	4
 
+/* Pipe topology snapshot structures */
+#define MAX_TOPOLOGY_SNAPSHOTS 4
+
+struct pipe_topology_line {
+	bool is_phantom_pipe;
+	int plane_idx;
+	int slice_idx;
+	int stream_idx;
+	int dpp_inst;
+	int opp_inst;
+	int tg_inst;
+};
+
+struct pipe_topology_snapshot {
+	struct pipe_topology_line pipe_log_lines[MAX_PIPES];
+	int line_count;
+	uint64_t timestamp_us;
+	int stream_count;
+	int phantom_stream_count;
+};
+
+struct pipe_topology_history {
+	struct pipe_topology_snapshot snapshots[MAX_TOPOLOGY_SNAPSHOTS];
+	int current_snapshot_index;
+};
+
 struct gamma_curve {
 	uint32_t offset;
 	uint32_t segments_num;
-- 
2.43.0

