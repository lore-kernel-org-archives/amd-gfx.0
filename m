Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C459FCFD376
	for <amd-gfx@archiver.kernel.org>; Tue,  2 Dec 2025 10:28:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 43CED10E607;
	Tue,  2 Dec 2025 10:28:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="AaXwx/93";
	dkim-atps=neutral
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012009.outbound.protection.outlook.com [52.101.43.9])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 259C510E607
 for <amd-gfx@lists.freedesktop.org>; Tue,  2 Dec 2025 10:28:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ilKyFV6YyqG3fgWdGLNeoox6sfpgoDpOlXamNY1WooDacj4XItSDQghKB2dpjCQa1MXBXaN0MkWiWHNiQmHZDTi3SgG9K1mqnKdt6KU0fXxwwkb/cJyus3gTk4REo5trDPx6V5DPWLIOqVOgLG4AwwQu1bB/3Op7+hBI9RlhRDZxvBiZT/LdNdjNFbY79Ltyk/hkDYCKhvqDosADan/JFaXhCqwgcJniG4SHIY735IuTJsWxDB3qEGyr/ADHjBsy/s9APiWXEYbypuKCiV2L5nWaoeQvNYK8rQ59hZXkUALLGb8ASeD1er2fWqFTUHuLCJEumHk/fLM8GRgLhNauLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eg+CkJ6VsXufv7z51z0QYKRb9buNdAcZdUYfYYvxr48=;
 b=uNrBYSwr2Zt4laSvJmPXY8Xlmp0JjoTDOdxHljuFwlE1l+Tfe1vJolAI9ro3KJxZYO2u/V89m185QQIB73UE2uHs7/2b4nzpjWJP0zc15x9FwUIS6G2WBEgcOt19PG/3GnlMR5XwyhNaWNeTTRWDI2MxWj6hNVetB5b1l/3snLkti2HS/bah4Vq18k1E/7rxdalqnV4SwTmsrNhhEm6DgxXXBEjaWlbenrafF/ra8sTkzXN1ROL+3Nd02du6QKZWEdYcQmMYN26GRuxEJlPkSOP5yE7GasCTDCTGVTIAsLUZesX+cUVxNgtm5Ak0Z/eMLm11VmzK40ixuYoRh3PjIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eg+CkJ6VsXufv7z51z0QYKRb9buNdAcZdUYfYYvxr48=;
 b=AaXwx/933DNIm2c1yBC0cvV1hp5zyI95KE3YZoTGa4dH1ovYgCtXI1dNnA43l2+ZxW7zxGQdlzKrL+5Dr2c0/M85wIVgs/QbbRMVvBikYjkZA21FLkgegf2BM7JNYl06S6YkGUmqZr+5sTqXpF/AN9inAAcZYCtpmgsSJZV71tI=
Received: from BN1PR14CA0009.namprd14.prod.outlook.com (2603:10b6:408:e3::14)
 by DS2PR12MB9567.namprd12.prod.outlook.com (2603:10b6:8:27c::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.17; Tue, 2 Dec
 2025 10:28:44 +0000
Received: from BN3PEPF0000B373.namprd21.prod.outlook.com
 (2603:10b6:408:e3:cafe::68) by BN1PR14CA0009.outlook.office365.com
 (2603:10b6:408:e3::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9388.9 via Frontend Transport; Tue, 2
 Dec 2025 10:28:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN3PEPF0000B373.mail.protection.outlook.com (10.167.243.170) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9412.0 via Frontend Transport; Tue, 2 Dec 2025 10:28:44 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 2 Dec
 2025 04:28:44 -0600
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 2 Dec
 2025 04:28:43 -0600
Received: from chenyu-station.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Tue, 2 Dec 2025 02:28:40 -0800
From: Chenyu Chen <chen-yu.chen@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, Joshua Aberback <joshua.aberback@amd.com>, Aric Cyr
 <aric.cyr@amd.com>, Chenyu Chen <chen-yu.chen@amd.com>
Subject: [PATCH 1/6] drm/amd/display: Defer transitions from minimal state to
 final state
Date: Tue, 2 Dec 2025 18:21:03 +0800
Message-ID: <20251202102437.3126523-2-chen-yu.chen@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251202102437.3126523-1-chen-yu.chen@amd.com>
References: <20251202102437.3126523-1-chen-yu.chen@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B373:EE_|DS2PR12MB9567:EE_
X-MS-Office365-Filtering-Correlation-Id: 803e4922-213a-4c16-e2c2-08de318d9216
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?3d9CjE6FQvdQllQh7WNef8vlOZJFrr7J8awvMAsodWWOocXQSIub4H4bbcku?=
 =?us-ascii?Q?tzF4RNPbW0C/yvjmYQjXMcJs+E67n9H6uwftEs60l99Ves93utx2lVjvel95?=
 =?us-ascii?Q?WU3lMrZPcj4L5YFYOzQXEWbu7AHEN8dc/YzI60XsjnJRD4Lx3o2Qd2ifT8CF?=
 =?us-ascii?Q?sQFBhk1UgcER1XqO5ZSwuXpJLm3FKjuszOHq8ePOOfMwIyfvBcoSOu86JY3Q?=
 =?us-ascii?Q?V+qYep7kE0q+gVo1ycqWKcex/YjtG4805pcpWOk5E+yaT2bNnelKucrW986R?=
 =?us-ascii?Q?qsKGJsvJkafD+w9CiU3BX58K5WNGTMZedQBjQNX42YldB4U6yTNRd8FEbnK6?=
 =?us-ascii?Q?9X+rhzccGQaskwcrR+1nvW/oNLffsVV6JUyRqJ8bWgWRl1wfLrhbMdo3R2M7?=
 =?us-ascii?Q?NYCajbA7mGT/DdDxvE4180m0VwTyfvWhposUQfrBjtRZzX4uMVnvyE6s0mJ9?=
 =?us-ascii?Q?2Q0IsJIuGgfFZCC9ASbf1g6gm6VMckUVQUHLW6/LlLGRT48bFbX4gvIuWSDg?=
 =?us-ascii?Q?ijZwaKdbepiBcUswwFENAgAsv4TBzEjLn9VMT5PRWo2iQFMXyiBlTAtvbOYh?=
 =?us-ascii?Q?aepUoWuDupw9+wN11JH1xE280QEvUMZOm1NJF/lfK3XfTCNcTHIlHH62BY3E?=
 =?us-ascii?Q?r2+OX8YATuOi27NR3xJdaxfU5pnY17EmBc88m9+OuYtJ8OZmLgAQeByt6DDe?=
 =?us-ascii?Q?832qLr3wobUJ1gXIW+Zn+nykxrgTck7ZUbkN5Ae8Ido1FEPGa01PqE1oIoOC?=
 =?us-ascii?Q?Cz7IdLwo9mf2OhJOoYr0KBwRabS8pDXvsanJcGvX+eviK3F17wZ7VkEhpxq+?=
 =?us-ascii?Q?cdGQ491sPWjemUTul1t6PUYyKrIs+YQQFkbp7/6LzWsNKizGmhUcsOGbdEk9?=
 =?us-ascii?Q?HpEKzth0W6VIV1Kj4BpA5iZ6d91JOcw41w1wQDluVe8vHX2ANvleJ3Z2QVpE?=
 =?us-ascii?Q?wRGZBuafm+dY8SyGf2Xpt6Tb0/ZQLSn0UTJDIx9VlfdJC73SylXTz1weBC+v?=
 =?us-ascii?Q?XRizmjchQg32Cy3Kn2tKxEqLOtJyLERvOR/Vc/FInX+EFbkgrylQnhWn11EM?=
 =?us-ascii?Q?1nZWrU8buTeoYXvA7F5zHnc62Y5q4yhLnK9ujXCuwtRRtpXBu5ySYEnyIJtm?=
 =?us-ascii?Q?+tIAec2uKXNc9H8oeZlxZbu0KI4wmgXTzJQS68BQaZfLWx18LyXYVYbstVxb?=
 =?us-ascii?Q?+HRMe4csLtwc29vkGba29x6nz0pQaLes79dKZ0jXpio/3dn4sl+45MDM9AK/?=
 =?us-ascii?Q?5cQwHYqu27KLCVoeQEyXwd4jBsyMr8kH1cfISQbMg+sP5f3w665WUqBbjRbt?=
 =?us-ascii?Q?Gwy2vJorEVG/iocIsA58L8S1ny2C2yg7kDwMp9D44ieMB8fH2UDUxp7Zki+x?=
 =?us-ascii?Q?rCL5WbI04z/0ghqG8Eh+CVe5cgtaODv5p6rFaTTzryhAeH7C+4BDBCXIQiT5?=
 =?us-ascii?Q?eVKZlavQNub2I/mlSPXn4/bFCSsBu/2uic0yeP/RgSYV29c579U770q8YdrY?=
 =?us-ascii?Q?Mmqh/iD0SAzxN2HvNLWBe7wvLuckgJxy/smwQaZ+JgKxVDe6kOzB5CmXNgvL?=
 =?us-ascii?Q?u1C/o1kzmQoSdmsU8K8=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Dec 2025 10:28:44.3876 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 803e4922-213a-4c16-e2c2-08de318d9216
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B373.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR12MB9567
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

From: Joshua Aberback <joshua.aberback@amd.com>

[Why]
In non-seamless pipe transitions, it can take several frames to process
a single flip. One of the reasons is the 2-step transition implementation
where first the minimal transition state is applied, then the final state
is applied, all within the same flip. This delay is noticeable to the user
in some video playback scenarios, which makes for a bad user experience.

[How]
 - in applicable non-seamless cases, complete the flip with the minimal
   state applied, start a counter, and create all new contexts as minimal
 - if another pipe transition occurs while counting, reset the counter
 - when the counter finishes, promote the current flip to a full update
   and restore creation of optimized contexts
 - when creating minimal states from new context, apply stream updates

Reviewed-by: Aric Cyr <aric.cyr@amd.com>
Signed-off-by: Joshua Aberback <joshua.aberback@amd.com>
Signed-off-by: Chenyu Chen <chen-yu.chen@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc.c | 200 +++++++++++++++--------
 drivers/gpu/drm/amd/display/dc/dc.h      |   7 +
 2 files changed, 137 insertions(+), 70 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index 1e7c61b975e3..e0db791953a5 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -2963,6 +2963,11 @@ static struct surface_update_descriptor check_update_surfaces_for_stream(
 {
 	struct surface_update_descriptor overall_type = { UPDATE_TYPE_FAST, LOCK_DESCRIPTOR_NONE };
 
+	/* When countdown finishes, promote this flip to full to trigger deferred final transition */
+	if (check_config->deferred_transition_state && !check_config->transition_countdown_to_steady_state) {
+		elevate_update_type(&overall_type, UPDATE_TYPE_FULL, LOCK_DESCRIPTOR_GLOBAL);
+	}
+
 	if (stream_update && stream_update->pending_test_pattern) {
 		elevate_update_type(&overall_type, UPDATE_TYPE_FULL, LOCK_DESCRIPTOR_GLOBAL);
 	}
@@ -3441,6 +3446,49 @@ static bool full_update_required_weak(
 		const struct dc_stream_update *stream_update,
 		const struct dc_stream_state *stream);
 
+struct pipe_split_policy_backup {
+	bool dynamic_odm_policy;
+	bool subvp_policy;
+	enum pipe_split_policy mpc_policy;
+	char force_odm[MAX_PIPES];
+};
+
+static void backup_and_set_minimal_pipe_split_policy(struct dc *dc,
+		struct dc_state *context,
+		struct pipe_split_policy_backup *policy)
+{
+	int i;
+
+	if (!dc->config.is_vmin_only_asic) {
+		policy->mpc_policy = dc->debug.pipe_split_policy;
+		dc->debug.pipe_split_policy = MPC_SPLIT_AVOID;
+	}
+	policy->dynamic_odm_policy = dc->debug.enable_single_display_2to1_odm_policy;
+	dc->debug.enable_single_display_2to1_odm_policy = false;
+	policy->subvp_policy = dc->debug.force_disable_subvp;
+	dc->debug.force_disable_subvp = true;
+	for (i = 0; i < context->stream_count; i++) {
+		policy->force_odm[i] = context->streams[i]->debug.force_odm_combine_segments;
+		if (context->streams[i]->debug.allow_transition_for_forced_odm)
+			context->streams[i]->debug.force_odm_combine_segments = 0;
+	}
+}
+
+static void restore_minimal_pipe_split_policy(struct dc *dc,
+		struct dc_state *context,
+		struct pipe_split_policy_backup *policy)
+{
+	uint8_t i;
+
+	if (!dc->config.is_vmin_only_asic)
+		dc->debug.pipe_split_policy = policy->mpc_policy;
+	dc->debug.enable_single_display_2to1_odm_policy =
+			policy->dynamic_odm_policy;
+	dc->debug.force_disable_subvp = policy->subvp_policy;
+	for (i = 0; i < context->stream_count; i++)
+		context->streams[i]->debug.force_odm_combine_segments = policy->force_odm[i];
+}
+
 /**
  * update_planes_and_stream_state() - The function takes planes and stream
  * updates as inputs and determines the appropriate update type. If update type
@@ -3591,10 +3639,30 @@ static bool update_planes_and_stream_state(struct dc *dc,
 	}
 
 	if (update_type == UPDATE_TYPE_FULL) {
+		struct pipe_split_policy_backup policy;
+		bool minimize = false;
+
+		if (dc->check_config.deferred_transition_state) {
+			if (dc->check_config.transition_countdown_to_steady_state) {
+				/* During countdown, all new contexts created as minimal transition states */
+				minimize = true;
+			} else {
+				dc->check_config.deferred_transition_state = false;
+			}
+		}
+
+		if (minimize)
+			backup_and_set_minimal_pipe_split_policy(dc, context, &policy);
+
 		if (dc->res_pool->funcs->validate_bandwidth(dc, context, DC_VALIDATE_MODE_AND_PROGRAMMING) != DC_OK) {
+			if (minimize)
+				restore_minimal_pipe_split_policy(dc, context, &policy);
 			BREAK_TO_DEBUGGER();
 			goto fail;
 		}
+
+		if (minimize)
+			restore_minimal_pipe_split_policy(dc, context, &policy);
 	}
 	update_seamless_boot_flags(dc, context, surface_count, stream);
 
@@ -4622,48 +4690,6 @@ static bool could_mpcc_tree_change_for_active_pipes(struct dc *dc,
 	return force_minimal_pipe_splitting;
 }
 
-struct pipe_split_policy_backup {
-	bool dynamic_odm_policy;
-	bool subvp_policy;
-	enum pipe_split_policy mpc_policy;
-	char force_odm[MAX_PIPES];
-};
-
-static void backup_and_set_minimal_pipe_split_policy(struct dc *dc,
-		struct dc_state *context,
-		struct pipe_split_policy_backup *policy)
-{
-	int i;
-
-	if (!dc->config.is_vmin_only_asic) {
-		policy->mpc_policy = dc->debug.pipe_split_policy;
-		dc->debug.pipe_split_policy = MPC_SPLIT_AVOID;
-	}
-	policy->dynamic_odm_policy = dc->debug.enable_single_display_2to1_odm_policy;
-	dc->debug.enable_single_display_2to1_odm_policy = false;
-	policy->subvp_policy = dc->debug.force_disable_subvp;
-	dc->debug.force_disable_subvp = true;
-	for (i = 0; i < context->stream_count; i++) {
-		policy->force_odm[i] = context->streams[i]->debug.force_odm_combine_segments;
-		if (context->streams[i]->debug.allow_transition_for_forced_odm)
-			context->streams[i]->debug.force_odm_combine_segments = 0;
-	}
-}
-
-static void restore_minimal_pipe_split_policy(struct dc *dc,
-		struct dc_state *context,
-		struct pipe_split_policy_backup *policy)
-{
-	uint8_t i;
-
-	if (!dc->config.is_vmin_only_asic)
-		dc->debug.pipe_split_policy = policy->mpc_policy;
-	dc->debug.enable_single_display_2to1_odm_policy =
-			policy->dynamic_odm_policy;
-	dc->debug.force_disable_subvp = policy->subvp_policy;
-	for (i = 0; i < context->stream_count; i++)
-		context->streams[i]->debug.force_odm_combine_segments = policy->force_odm[i];
-}
 
 static void release_minimal_transition_state(struct dc *dc,
 		struct dc_state *minimal_transition_context,
@@ -4773,6 +4799,7 @@ static int initialize_empty_surface_updates(
 static bool commit_minimal_transition_based_on_new_context(struct dc *dc,
 		struct dc_state *new_context,
 		struct dc_stream_state *stream,
+		struct dc_stream_update *stream_update,
 		struct dc_surface_update *srf_updates,
 		int surface_count)
 {
@@ -4790,7 +4817,7 @@ static bool commit_minimal_transition_based_on_new_context(struct dc *dc,
 				new_context)) {
 			DC_LOG_DC("commit minimal transition state: base = new state\n");
 			commit_planes_for_stream(dc, srf_updates,
-					surface_count, stream, NULL,
+					surface_count, stream, stream_update,
 					UPDATE_TYPE_FULL, intermediate_context);
 			swap_and_release_current_context(
 					dc, intermediate_context, stream);
@@ -4884,8 +4911,8 @@ static bool commit_minimal_transition_state_in_dc_update(struct dc *dc,
 		int surface_count)
 {
 	bool success = commit_minimal_transition_based_on_new_context(
-				dc, new_context, stream, srf_updates,
-				surface_count);
+				dc, new_context, stream, NULL,
+				srf_updates, surface_count);
 	if (!success)
 		success = commit_minimal_transition_based_on_current_context(dc,
 				new_context, stream);
@@ -5294,32 +5321,63 @@ static void commit_planes_and_stream_update_with_new_context(struct dc *dc,
 		enum surface_update_type update_type,
 		struct dc_state *new_context)
 {
+	bool skip_new_context = false;
 	ASSERT(update_type >= UPDATE_TYPE_FULL);
-	if (!dc->hwss.is_pipe_topology_transition_seamless(dc,
-			dc->current_state, new_context))
-		/*
-		 * It is required by the feature design that all pipe topologies
-		 * using extra free pipes for power saving purposes such as
-		 * dynamic ODM or SubVp shall only be enabled when it can be
-		 * transitioned seamlessly to AND from its minimal transition
-		 * state. A minimal transition state is defined as the same dc
-		 * state but with all power saving features disabled. So it uses
-		 * the minimum pipe topology. When we can't seamlessly
-		 * transition from state A to state B, we will insert the
-		 * minimal transition state A' or B' in between so seamless
-		 * transition between A and B can be made possible.
-		 */
-		commit_minimal_transition_state_in_dc_update(dc, new_context,
-				stream, srf_updates, surface_count);
+	/*
+	 * It is required by the feature design that all pipe topologies
+	 * using extra free pipes for power saving purposes such as
+	 * dynamic ODM or SubVp shall only be enabled when it can be
+	 * transitioned seamlessly to AND from its minimal transition
+	 * state. A minimal transition state is defined as the same dc
+	 * state but with all power saving features disabled. So it uses
+	 * the minimum pipe topology. When we can't seamlessly
+	 * transition from state A to state B, we will insert the
+	 * minimal transition state A' or B' in between so seamless
+	 * transition between A and B can be made possible.
+	 *
+	 * To optimize for the time it takes to execute flips,
+	 * the transition from the minimal state to the final state is
+	 * deferred until a steady state (no more transitions) is reached.
+	 */
+	if (!dc->hwss.is_pipe_topology_transition_seamless(dc, dc->current_state, new_context)) {
+		if (!dc->debug.disable_deferred_minimal_transitions) {
+			dc->check_config.deferred_transition_state = true;
+			dc->check_config.transition_countdown_to_steady_state =
+					dc->debug.num_fast_flips_to_steady_state_override ?
+					dc->debug.num_fast_flips_to_steady_state_override :
+					NUM_FAST_FLIPS_TO_STEADY_STATE;
+
+			if (commit_minimal_transition_based_on_new_context(dc, new_context, stream, stream_update,
+					srf_updates, surface_count)) {
+				skip_new_context = true;
+				dc_state_release(new_context);
+				new_context = dc->current_state;
+			} else {
+				/*
+				 * In this case a new mpo plane is being enabled on pipes that were
+				 * previously in use, and the surface update to the existing plane
+				 * includes an alpha box where the new plane will be, so the update
+				 * from minimal to final cannot be deferred as the alpha box would
+				 * be visible to the user
+				 */
+				commit_minimal_transition_based_on_current_context(dc, new_context, stream);
+			}
+		} else {
+			commit_minimal_transition_state_in_dc_update(dc, new_context, stream,
+					srf_updates, surface_count);
+		}
+	} else if (dc->check_config.deferred_transition_state) {
+		/* reset countdown as steady state not reached */
+		dc->check_config.transition_countdown_to_steady_state =
+				dc->debug.num_fast_flips_to_steady_state_override ?
+				dc->debug.num_fast_flips_to_steady_state_override :
+				NUM_FAST_FLIPS_TO_STEADY_STATE;
+	}
 
-	commit_planes_for_stream(
-			dc,
-			srf_updates,
-			surface_count,
-			stream,
-			stream_update,
-			update_type,
-			new_context);
+	if (!skip_new_context) {
+		commit_planes_for_stream(dc, srf_updates, surface_count, stream, stream_update, update_type, new_context);
+		swap_and_release_current_context(dc, new_context, stream);
+	}
 }
 
 static bool update_planes_and_stream_v3(struct dc *dc,
@@ -5349,11 +5407,13 @@ static bool update_planes_and_stream_v3(struct dc *dc,
 		commit_planes_and_stream_update_on_current_context(dc,
 				srf_updates, surface_count, stream,
 				stream_update, update_type);
+
+		if (dc->check_config.transition_countdown_to_steady_state)
+			dc->check_config.transition_countdown_to_steady_state--;
 	} else {
 		commit_planes_and_stream_update_with_new_context(dc,
 				srf_updates, surface_count, stream,
 				stream_update, update_type, new_context);
-		swap_and_release_current_context(dc, new_context, stream);
 	}
 
 	return true;
diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index 167cfb1b01dd..d926bf54185b 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -82,6 +82,8 @@ struct dcn_dccg_reg_state;
 #define MAX_DPIA_PER_HOST_ROUTER 3
 #define MAX_DPIA_NUM  (MAX_HOST_ROUTERS_NUM * MAX_DPIA_PER_HOST_ROUTER)
 
+#define NUM_FAST_FLIPS_TO_STEADY_STATE 20
+
 /* Display Core Interfaces */
 struct dc_versions {
 	const char *dc_ver;
@@ -293,6 +295,9 @@ struct dc_check_config {
 	 */
 	unsigned int max_optimizable_video_width;
 	bool enable_legacy_fast_update;
+
+	bool deferred_transition_state;
+	unsigned int transition_countdown_to_steady_state;
 };
 
 struct dc_caps {
@@ -1201,6 +1206,8 @@ struct dc_debug_options {
 	bool disable_stutter_for_wm_program;
 	bool enable_block_sequence_programming;
 	uint32_t custom_psp_footer_size;
+	bool disable_deferred_minimal_transitions;
+	unsigned int num_fast_flips_to_steady_state_override;
 };
 
 
-- 
2.43.0

