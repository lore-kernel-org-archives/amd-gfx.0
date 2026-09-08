Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A17D4C79FAD
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Sep 2026 11:44:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 383AE10EB7C;
	Tue,  8 Sep 2026 11:44:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="uymJg4Mc";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011050.outbound.protection.outlook.com [52.101.52.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5525410EB7C
 for <amd-gfx@lists.freedesktop.org>; Tue,  8 Sep 2026 11:44:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=c0oe9m/xhmF5EEuF1QnTbRDk9yWcxF9WJc3fc6fWzRgUkD66dVj3+yef3IB+ymHXt+D4H5I+oALnq0OWLhEEHFqTjmRusg4m+XAVmjZdySRVsGKkrPQMSE1lT0xhhMUV+OO8VkVDaTr4/j3Mh3flZ5t+zQVRUZBxBbmvXoo1ks8E0tmooKhUQjf7TZb/n9UuRskb3E6zw+tYOMOszq932AIJxHm8bPYoeg3o534Jg7yHIh3kLNZx/QF0M7ZzUBDLt212QEs7csqequeMWvvMV74gSnM7FPzqroac+1EYnx7g6xEVLYLvMlJWjS2rduFgUpuYa4X+i9VcH67zxYh/jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+eF4DwF8f9f1vV3SWdZvdYexn0jrfPYgnpCg9o9Zj2E=;
 b=X3MK4jzXseJpqSBSFDBPw6WSwBs5LMCYQPeNPtTGtGh5MHEbIWRG5sQcV6cCL9Pu07kAS2H7X7Nj9/+Py6HMD9aTNfZhYi4QOIF43XxpzAa2kyqhOJc09/wSNJMUxkNwdujI0MI2hebL959fzpGJAnhy7XJPJczbGR75SAofgDVQS9pH2xFXBWY178hXS1cBCodaV+WFitbke4cnMxBE93+COYVmVO9l1C3Affd4mDL09+UhEYKxTsPz0Hdm8dUqob4jD6UvqBf0MoLLr7ciN8d6bdCaBMY4bsRTsjSYcyhiJKUS5+6c1Ya6KnYkWpyXgPQ+Nxm2Mb2JBucHtD5/7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+eF4DwF8f9f1vV3SWdZvdYexn0jrfPYgnpCg9o9Zj2E=;
 b=uymJg4Mcn/16LEXQ3lN4m7mfiIMbjZMKlBShRY2fpaRNhtxc2hngxkmZw+yrQ5SbHEwbj3Cp7t2IxllVmMKzpI5Q9SJIm3FBzAhcIShI7qA3IkDMNsq/QbYM1Z2TlJLpvxz4lMtpj05H1jFuGurEF5RLGm0qpKcuFG4/mcOp0sI=
Received: from DS7P221CA0040.NAMP221.PROD.OUTLOOK.COM (2603:10b6:8:25e::11) by
 CH3PR12MB9730.namprd12.prod.outlook.com (2603:10b6:610:253::9) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.15; Tue, 8 Sep 2026 11:44:15 +0000
Received: from SA2PEPF000015CC.namprd03.prod.outlook.com
 (2603:10b6:8:25e:cafe::5b) by DS7P221CA0040.outlook.office365.com
 (2603:10b6:8:25e::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.15 via Frontend Transport; Tue, 8
 Sep 2026 11:44:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SA2PEPF000015CC.mail.protection.outlook.com (10.167.241.202) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.406.5 via Frontend Transport; Tue, 8 Sep 2026 11:44:15 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Tue, 8 Sep
 2026 06:44:00 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Tue, 8 Sep
 2026 06:44:00 -0500
Received: from chenyu-station.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.46 via Frontend
 Transport; Tue, 8 Sep 2026 06:43:51 -0500
From: Chenyu Chen <chen-yu.chen@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Rafal Ostrowski <rafal.ostrowski@amd.com>, Alvin Lee
 <alvin.lee2@amd.com>, Chenyu Chen <chen-yu.chen@amd.com>
Subject: [PATCH 64/66] drm/amd/display: Unify fast update classification paths
Date: Tue, 8 Sep 2026 19:31:57 +0800
Message-ID: <20260908113338.2433445-65-chen-yu.chen@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260908113338.2433445-1-chen-yu.chen@amd.com>
References: <20260908113338.2433445-1-chen-yu.chen@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF000015CC:EE_|CH3PR12MB9730:EE_
X-MS-Office365-Filtering-Correlation-Id: 05af35ca-ed8a-42df-10bc-08df0d9e829a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|23010399003|36860700016|6133799003|3023799007|10067099003|56012099006|11063799006|18002099003|22082099003|20052099010;
X-Microsoft-Antispam-Message-Info: 8s5K0FQF3blSEeuwX6Sb0h623+UMCTSAhBV5gYVy00iKhpvd1DoyDd6jQjsFURZxCUO8FOGOpTRHofJ55VwWvYFzsW0Im41s7e/SpzeoS3kYiscUL9G7vsIuICg07NpcmNMfleaOfBaLlezBdNia1S7P3zkRjKt693eVEL1E3j4pfDqAxgC+Z5o6GNikJs8dS6sKvkbduGzmd1sgJDqJ2P+Zo3lXYM467lFACXBPQv9OLqgeQG3TjjQQ5uxOMOVsTQhmgUeh9N2VNgtiMI3bdipUbtO+F2VjrswCXXn4o7De4LZ+cDZ1CcNwZfRKr6spBFRo+sacwYBHwf9La3sopKJ0kBoJKiIv4uOBdz0EiUoupUCH1tLHGQ3SVW6mFUsE7VL9zZG3A144MX+w9Hgrek45fJBM6twA8HbX1wAmLN2/EG2pWvaxTfXqQmubeCGPKtVsqcfu7j8hZRvRN+2fqt+dTprObsu6GPboYXfiJnxCcex6urHnwP+Hk/cAZZYI64dTJbs+c48opAmRKKiE3IjvCqcmyok2OIL91Ei4nDOnbu/SBdlohPa+vpF5OrP23Shj5rDYTVLt/A9YtNwuDBqcObcYk7rc0Mz30/rm4NYaeiLzzdqV+akIqS+f4AjHVwaUJJVldJe2u2oHZcvv69Jc3Uj/8M3p/juj1t2ZmjRSw7TMPF16TfaJeFu9/K3cCinHebjP7ZJwIyU/YLMPNw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(23010399003)(36860700016)(6133799003)(3023799007)(10067099003)(56012099006)(11063799006)(18002099003)(22082099003)(20052099010);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: lSjLGDV8OqsrohQmvZsNkXLgLmNexeMUAuTQ3zTxpOhEWahyD4tTbs/LGG1BfDa4PI7tfvFE34PH0nnDEuRWI7te34u509sw/x5eXCVSmVWXaTuv3MR3wLX125D1pKSoBMNjVf8zqzAu+DG5Kp+cp9ARmlMFU2uE3uxerfYbpS/7urTklENOdDyNI56CO0VtMOl24crWpJqt/j18dWa0Tce2VEAnMve7hcUS8vdsHXvmVoCtMACKNeeUrbQDAmUcaIuf+tQSF2KHGoIulDoyuOUxrS8lN4WLdItR9gleYQtRmSq2B51Km78GhRR9I562Z9zZuSQEDY1IPVyJZOJejH8uR1e6eR0P2MNDUO03Uje/AcvMZ2jiTstSzdelRlkT9dnjLAp0aniwonsKUvhfnxEfA3ipKvpQSDDPlFUHraU8wK8cDTvC1iFIQpaTlnL3
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2026 11:44:15.6401 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 05af35ca-ed8a-42df-10bc-08df0d9e829a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF000015CC.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9730
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

From: Rafal Ostrowski <rafal.ostrowski@amd.com>

[Why]
The dc_fast_update intermediate struct created code duplication and
complexity with multiple classification paths (populate_fast_updates,
fast_nonaddr_updates_exist, full_update_required). This refactoring
simplifies the update classification system by consolidating to a
single path while maintaining compatibility.

[How]
Remove entire dc_fast_update struct and associated helper functions:
- populate_fast_updates
- fast_nonaddr_updates_exist
- full_update_required

Refactor check_update_surfaces_for_stream as the
single classification path with explicit handling for func_shaper,
lut3d_func, cursor_csc_color_matrix_change, and
scaler_sharpener_update. Add a reserved bitfield to the
stream_update_flags union for completeness guards. Extract
dc_check_address_only_update and dc_check_update_surfaces_for_stream
as public.

Reviewed-by: Alvin Lee <alvin.lee2@amd.com>
Signed-off-by: Rafal Ostrowski <rafal.ostrowski@amd.com>
Signed-off-by: Chenyu Chen <chen-yu.chen@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc.c      | 246 ++----------------
 drivers/gpu/drm/amd/display/dc/dc.h           |  31 ---
 drivers/gpu/drm/amd/display/dc/dc_stream.h    |   3 +
 .../amd/display/dc/hwss/dcn35/dcn35_hwseq.c   |  17 +-
 .../amd/display/dc/hwss/dcn35/dcn35_hwseq.h   |   2 +-
 .../amd/display/dc/hwss/dcn401/dcn401_hwseq.c |  12 +-
 .../amd/display/dc/hwss/dcn401/dcn401_hwseq.h |   2 +-
 .../amd/display/dc/hwss/dcn42/dcn42_hwseq.c   |  13 +-
 .../amd/display/dc/hwss/dcn42/dcn42_hwseq.h   |   2 +-
 .../drm/amd/display/dc/hwss/hw_sequencer.h    |   2 +-
 10 files changed, 58 insertions(+), 272 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index ab192291ed52..f532d3174662 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -2279,6 +2279,7 @@ static enum dc_status dc_commit_state_no_check(struct dc *dc, struct dc_state *c
 	struct dc_stream_state *dc_streams[MAX_STREAMS] = {0};
 	struct dc_state *old_state;
 	bool subvp_prev_use = false;
+	bool dmub_locked = false;
 
 	dc_z10_restore(dc);
 	dc_allow_idle_optimizations(dc, false);
@@ -2330,7 +2331,7 @@ static enum dc_status dc_commit_state_no_check(struct dc *dc, struct dc_state *c
 	if (dc->hwss.subvp_pipe_control_lock)
 		dc->hwss.subvp_pipe_control_lock(dc, context, true, true, NULL, subvp_prev_use);
 	if (dc->hwss.dmub_hw_control_lock)
-		dc->hwss.dmub_hw_control_lock(dc, context, true);
+		dmub_locked = dc->hwss.dmub_hw_control_lock(dc, context, true);
 
 	if (dc->hwss.update_dsc_pg)
 		dc->hwss.update_dsc_pg(dc, context, false);
@@ -2406,7 +2407,7 @@ static enum dc_status dc_commit_state_no_check(struct dc *dc, struct dc_state *c
 		dc->hwss.commit_subvp_config(dc, context);
 	if (dc->hwss.subvp_pipe_control_lock)
 		dc->hwss.subvp_pipe_control_lock(dc, context, false, true, NULL, subvp_prev_use);
-	if (dc->hwss.dmub_hw_control_lock)
+	if (dc->hwss.dmub_hw_control_lock && dmub_locked)
 		dc->hwss.dmub_hw_control_lock(dc, context, false);
 
 	for (i = 0; i < context->stream_count; i++) {
@@ -3184,8 +3185,10 @@ static struct dc_update_descriptor check_update_surfaces_for_stream(
 				stream_update->vrr_active_variable || stream_update->vrr_active_fixed))
 			su_flags->bits.fams_changed = 1;
 
-		if (stream_update->scaler_sharpener_update)
+		if (stream_update->scaler_sharpener_update) {
 			su_flags->bits.scaler_sharpener = 1;
+			elevate_update_type(&overall_type, UPDATE_TYPE_FULL, LOCK_DESCRIPTOR_STREAM);
+		}
 
 		if (stream_update->sharpening_required)
 			su_flags->bits.sharpening_required = 1;
@@ -3250,6 +3253,16 @@ static struct dc_update_descriptor check_update_surfaces_for_stream(
 			su_flags->bits.cursor_pos = 1;
 			elevate_update_type(&overall_type, UPDATE_TYPE_FAST, LOCK_DESCRIPTOR_STREAM);
 		}
+
+		if (stream_update->func_shaper) {
+			su_flags->bits.func_shaper = 1;
+			elevate_update_type(&overall_type, UPDATE_TYPE_FULL, LOCK_DESCRIPTOR_STREAM);
+		}
+
+		if (stream_update->lut3d_func) {
+			su_flags->bits.lut3d_func = 1;
+			elevate_update_type(&overall_type, UPDATE_TYPE_FULL, LOCK_DESCRIPTOR_STREAM);
+		}
 	}
 
 	for (int i = 0 ; i < surface_count; i++) {
@@ -4881,6 +4894,7 @@ static void commit_planes_for_stream(struct dc *dc,
 	bool should_lock_all_pipes = (update_type != UPDATE_TYPE_FAST);
 	bool subvp_prev_use = false;
 	bool subvp_curr_use = false;
+	bool dmub_locked = false;
 	uint8_t current_stream_mask = 0;
 
 	if (should_lock_all_pipes)
@@ -4986,7 +5000,7 @@ static void commit_planes_for_stream(struct dc *dc,
 			dc->hwss.subvp_pipe_control_lock(dc, context, true, should_lock_all_pipes, NULL, subvp_prev_use);
 
 		if (dc->hwss.dmub_hw_control_lock)
-			dc->hwss.dmub_hw_control_lock(dc, context, true);
+			dmub_locked = dc->hwss.dmub_hw_control_lock(dc, context, true);
 
 		dc->hwss.interdependent_update_lock(dc, context, true);
 	} else {
@@ -4994,7 +5008,7 @@ static void commit_planes_for_stream(struct dc *dc,
 			dc->hwss.subvp_pipe_control_lock(dc, context, true, should_lock_all_pipes, top_pipe_to_program, subvp_prev_use);
 
 		if (dc->hwss.dmub_hw_control_lock)
-			dc->hwss.dmub_hw_control_lock(dc, context, true);
+			dmub_locked = dc->hwss.dmub_hw_control_lock(dc, context, true);
 
 		/* Lock the top pipe while updating plane addrs, since freesync requires
 		 *  plane addr update event triggers to be synchronized.
@@ -5037,7 +5051,7 @@ static void commit_planes_for_stream(struct dc *dc,
 			dc->hwss.subvp_pipe_control_lock(dc, context, false, should_lock_all_pipes,
 							 NULL, subvp_prev_use);
 
-		if (dc->hwss.dmub_hw_control_lock)
+		if (dc->hwss.dmub_hw_control_lock && dmub_locked)
 			dc->hwss.dmub_hw_control_lock(dc, context, false);
 		return;
 	}
@@ -5273,12 +5287,12 @@ static void commit_planes_for_stream(struct dc *dc,
 	if (should_lock_all_pipes && dc->hwss.interdependent_update_lock) {
 		if (dc->hwss.subvp_pipe_control_lock)
 			dc->hwss.subvp_pipe_control_lock(dc, context, false, should_lock_all_pipes, NULL, subvp_prev_use);
-		if (dc->hwss.dmub_hw_control_lock)
+		if (dc->hwss.dmub_hw_control_lock && dmub_locked)
 			dc->hwss.dmub_hw_control_lock(dc, context, false);
 	} else {
 		if (dc->hwss.subvp_pipe_control_lock)
 			dc->hwss.subvp_pipe_control_lock(dc, context, false, should_lock_all_pipes, top_pipe_to_program, subvp_prev_use);
-		if (dc->hwss.dmub_hw_control_lock)
+		if (dc->hwss.dmub_hw_control_lock && dmub_locked)
 			dc->hwss.dmub_hw_control_lock(dc, context, false);
 	}
 
@@ -5737,127 +5751,6 @@ static bool commit_minimal_transition_state(struct dc *dc,
 	return true;
 }
 
-void populate_fast_updates(struct dc_fast_update *fast_update,
-		struct dc_surface_update *srf_updates,
-		int surface_count,
-		struct dc_stream_update *stream_update)
-{
-	int i = 0;
-
-	if (stream_update) {
-		fast_update[0].out_transfer_func = stream_update->out_transfer_func;
-		fast_update[0].output_csc_transform = stream_update->output_csc_transform;
-		fast_update[0].cursor_attributes = stream_update->cursor_attributes;
-		fast_update[0].cursor_position = stream_update->cursor_position;
-		fast_update[0].periodic_interrupt = stream_update->periodic_interrupt;
-		fast_update[0].dither_option = stream_update->dither_option;
-		fast_update[0].gamut_remap = stream_update->gamut_remap;
-		fast_update[0].vrr_infopacket = stream_update->vrr_infopacket;
-		fast_update[0].vsc_infopacket = stream_update->vsc_infopacket;
-		fast_update[0].vsp_infopacket = stream_update->vsp_infopacket;
-		fast_update[0].hfvsif_infopacket = stream_update->hfvsif_infopacket;
-		fast_update[0].vtem_infopacket = stream_update->vtem_infopacket;
-		fast_update[0].adaptive_sync_infopacket = stream_update->adaptive_sync_infopacket;
-		fast_update[0].avi_infopacket = stream_update->avi_infopacket;
-		fast_update[0].hdr_static_metadata = stream_update->hdr_static_metadata;
-	} else {
-		fast_update[0].out_transfer_func = NULL;
-		fast_update[0].output_csc_transform = NULL;
-		fast_update[0].cursor_attributes = NULL;
-		fast_update[0].cursor_position = NULL;
-		fast_update[0].periodic_interrupt = NULL;
-		fast_update[0].dither_option = NULL;
-		fast_update[0].gamut_remap = NULL;
-		fast_update[0].vrr_infopacket = NULL;
-		fast_update[0].vsc_infopacket = NULL;
-		fast_update[0].vsp_infopacket = NULL;
-		fast_update[0].hfvsif_infopacket = NULL;
-		fast_update[0].vtem_infopacket = NULL;
-		fast_update[0].adaptive_sync_infopacket = NULL;
-		fast_update[0].avi_infopacket = NULL;
-		fast_update[0].hdr_static_metadata = NULL;
-	}
-
-	for (i = 0; i < surface_count; i++) {
-		fast_update[i].flip_addr = srf_updates[i].flip_addr;
-		fast_update[i].gamma = srf_updates[i].gamma;
-		fast_update[i].gamut_remap_matrix = srf_updates[i].gamut_remap_matrix;
-		fast_update[i].input_csc_color_matrix = srf_updates[i].input_csc_color_matrix;
-		fast_update[i].coeff_reduction_factor = srf_updates[i].coeff_reduction_factor;
-		fast_update[i].cursor_csc_color_matrix = srf_updates[i].cursor_csc_color_matrix;
-		fast_update[i].cm_hist_control = srf_updates[i].cm_hist_control;
-	}
-}
-
-static bool fast_updates_exist(const struct dc_fast_update *fast_update, int surface_count)
-{
-	int i;
-
-	if (fast_update[0].out_transfer_func ||
-		fast_update[0].output_csc_transform ||
-		fast_update[0].cursor_attributes ||
-		fast_update[0].cursor_position ||
-		fast_update[0].periodic_interrupt ||
-		fast_update[0].dither_option ||
-		fast_update[0].gamut_remap ||
-		fast_update[0].vrr_infopacket ||
-		fast_update[0].vsc_infopacket ||
-		fast_update[0].vsp_infopacket ||
-		fast_update[0].hfvsif_infopacket ||
-		fast_update[0].vtem_infopacket ||
-		fast_update[0].adaptive_sync_infopacket ||
-		fast_update[0].avi_infopacket ||
-		fast_update[0].hdr_static_metadata)
-		return true;
-
-	for (i = 0; i < surface_count; i++) {
-		if (fast_update[i].flip_addr ||
-				fast_update[i].gamma ||
-				fast_update[i].gamut_remap_matrix ||
-				fast_update[i].input_csc_color_matrix ||
-				fast_update[i].cursor_csc_color_matrix ||
-				fast_update[i].cm_hist_control ||
-				fast_update[i].coeff_reduction_factor)
-			return true;
-	}
-
-	return false;
-}
-
-bool fast_nonaddr_updates_exist(struct dc_fast_update *fast_update, int surface_count)
-{
-	int i;
-
-	if (fast_update[0].out_transfer_func ||
-		fast_update[0].output_csc_transform ||
-		fast_update[0].gamut_remap ||
-		fast_update[0].cursor_attributes ||
-		fast_update[0].cursor_position ||
-		fast_update[0].periodic_interrupt ||
-		fast_update[0].dither_option ||
-		fast_update[0].vrr_infopacket ||
-		fast_update[0].vsc_infopacket ||
-		fast_update[0].vsp_infopacket ||
-		fast_update[0].hfvsif_infopacket ||
-		fast_update[0].vtem_infopacket ||
-		fast_update[0].adaptive_sync_infopacket ||
-		fast_update[0].avi_infopacket ||
-		fast_update[0].hdr_static_metadata)
-		return true;
-
-	for (i = 0; i < surface_count; i++) {
-		if (fast_update[i].input_csc_color_matrix ||
-				fast_update[i].gamma ||
-				fast_update[i].gamut_remap_matrix ||
-				fast_update[i].coeff_reduction_factor ||
-				fast_update[i].cm_hist_control ||
-				fast_update[i].cursor_csc_color_matrix)
-			return true;
-	}
-
-	return false;
-}
-
 static bool full_update_required_weak(
 		const struct dc *dc,
 		const struct dc_surface_update *srf_updates,
@@ -5886,67 +5779,6 @@ static bool full_update_required_weak(
 	return false;
 }
 
-static bool full_update_required(
-		const struct dc *dc,
-		const struct dc_surface_update *srf_updates,
-		int surface_count,
-		const struct dc_stream_update *stream_update,
-		const struct dc_stream_state *stream)
-{
-	if (full_update_required_weak(dc, srf_updates, surface_count, stream_update, stream))
-		return true;
-
-	for (int i = 0; i < surface_count; i++) {
-		if (srf_updates &&
-				(srf_updates[i].plane_info ||
-				srf_updates[i].scaling_info ||
-				(srf_updates[i].hdr_mult.value &&
-				srf_updates[i].hdr_mult.value != srf_updates->surface->hdr_mult.value) ||
-				(srf_updates[i].sdr_white_level_nits &&
-				srf_updates[i].sdr_white_level_nits != srf_updates->surface->sdr_white_level_nits) ||
-				srf_updates[i].in_transfer_func ||
-				srf_updates[i].surface->force_full_update ||
-				(srf_updates[i].flip_addr &&
-				srf_updates[i].flip_addr->address.tmz_surface != srf_updates[i].surface->address.tmz_surface)))
-			return true;
-	}
-
-	if (stream_update &&
-			(((stream_update->src.height != 0 && stream_update->src.width != 0) ||
-			(stream_update->dst.height != 0 && stream_update->dst.width != 0) ||
-			stream_update->integer_scaling_update) ||
-			stream_update->abm_level ||
-			stream_update->dpms_off ||
-			stream_update->allow_freesync ||
-			stream_update->vrr_active_variable ||
-			stream_update->vrr_active_fixed ||
-			stream_update->output_color_space ||
-			stream_update->wb_update ||
-			stream_update->dsc_config ||
-			stream_update->mst_bw_update ||
-			stream_update->func_shaper ||
-			stream_update->lut3d_func ||
-			stream_update->pending_test_pattern ||
-			stream_update->crtc_timing_adjust ||
-			stream_update->scaler_sharpener_update ||
-			stream_update->hw_cursor_req))
-		return true;
-
-	return false;
-}
-
-static bool fast_update_only(
-		const struct dc *dc,
-		const struct dc_fast_update *fast_update,
-		const struct dc_surface_update *srf_updates,
-		int surface_count,
-		const struct dc_stream_update *stream_update,
-		const struct dc_stream_state *stream)
-{
-	return fast_updates_exist(fast_update, surface_count)
-			&& !full_update_required(dc, srf_updates, surface_count, stream_update, stream);
-}
-
 static bool update_planes_and_stream_v2(struct dc *dc,
 		struct dc_surface_update *srf_updates, int surface_count,
 		struct dc_stream_state *stream,
@@ -5954,7 +5786,6 @@ static bool update_planes_and_stream_v2(struct dc *dc,
 {
 	struct dc_state *context;
 	enum dc_update_type update_type;
-	struct dc_fast_update fast_update[MAX_SURFACES] = {0};
 
 	/* In cases where MPO and split or ODM are used transitions can
 	 * cause underflow. Apply stream configuration with minimal pipe
@@ -5962,11 +5793,7 @@ static bool update_planes_and_stream_v2(struct dc *dc,
 	 */
 	bool force_minimal_pipe_splitting = 0;
 	bool is_plane_addition = 0;
-	bool is_fast_update_only;
 
-	populate_fast_updates(fast_update, srf_updates, surface_count, stream_update);
-	is_fast_update_only = fast_update_only(dc, fast_update, srf_updates,
-			surface_count, stream_update, stream);
 	force_minimal_pipe_splitting = could_mpcc_tree_change_for_active_pipes(
 			dc,
 			stream,
@@ -6004,7 +5831,7 @@ static bool update_planes_and_stream_v2(struct dc *dc,
 		commit_minimal_transition_state_in_dc_update(dc, context, stream,
 				srf_updates, surface_count);
 
-	if (is_fast_update_only && !dc->check_config.enable_legacy_fast_update) {
+	if (update_type == UPDATE_TYPE_FAST && !dc->check_config.enable_legacy_fast_update) {
 		commit_planes_for_stream_fast(dc,
 				srf_updates,
 				surface_count,
@@ -6040,13 +5867,8 @@ static void commit_planes_and_stream_update_on_current_context(struct dc *dc,
 		struct dc_stream_update *stream_update,
 		enum dc_update_type update_type)
 {
-	struct dc_fast_update fast_update[MAX_SURFACES] = {0};
-
 	ASSERT(update_type < UPDATE_TYPE_FULL);
-	populate_fast_updates(fast_update, srf_updates, surface_count,
-			stream_update);
-	if (fast_update_only(dc, fast_update, srf_updates, surface_count,
-			stream_update, stream) &&
+	if (update_type == UPDATE_TYPE_FAST &&
 			!dc->check_config.enable_legacy_fast_update)
 		commit_planes_for_stream_fast(dc,
 				srf_updates,
@@ -8242,23 +8064,6 @@ static bool update_planes_and_stream_prepare_v3(
 	ASSERT(scratch->flow == UPDATE_V3_FLOW_INVALID);
 	dc_exit_ips_for_hw_access(scratch->dc);
 
-	/* HWSS path determination needs to be done prior to updating the surface and stream states. */
-	struct dc_fast_update fast_update[MAX_SURFACES] = { 0 };
-
-	populate_fast_updates(fast_update,
-			      scratch->surface_updates,
-			      scratch->surface_count,
-			      scratch->stream_update);
-
-	const bool is_hwss_fast_path_only =
-		fast_update_only(scratch->dc,
-				 fast_update,
-				 scratch->surface_updates,
-				 scratch->surface_count,
-				 scratch->stream_update,
-				 scratch->stream) &&
-		!scratch->dc->check_config.enable_legacy_fast_update;
-
 	if (!update_planes_and_stream_state(
 			scratch->dc,
 			scratch->surface_updates,
@@ -8274,7 +8079,8 @@ static bool update_planes_and_stream_prepare_v3(
 	if (scratch->new_context == scratch->dc->current_state) {
 		ASSERT(scratch->update_type < UPDATE_TYPE_FULL);
 
-		scratch->flow = is_hwss_fast_path_only
+		scratch->flow = (scratch->update_type == UPDATE_TYPE_FAST &&
+				!scratch->dc->check_config.enable_legacy_fast_update)
 				? UPDATE_V3_FLOW_NO_NEW_CONTEXT_CONTEXT_FAST
 				: UPDATE_V3_FLOW_NO_NEW_CONTEXT_CONTEXT_FULL;
 		return true;
diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index 1e25ed4eea80..634c0b7686bb 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -2091,32 +2091,6 @@ struct dc_scaling_info {
 	struct scaling_taps scaling_quality;
 };
 
-struct dc_fast_update {
-	const struct dc_flip_addrs *flip_addr;
-	const struct dc_gamma *gamma;
-	const struct colorspace_transform *gamut_remap_matrix;
-	const struct dc_csc_transform *input_csc_color_matrix;
-	const struct fixed31_32 *coeff_reduction_factor;
-	struct dc_transfer_func *out_transfer_func;
-	struct dc_csc_transform *output_csc_transform;
-	const struct dc_csc_transform *cursor_csc_color_matrix;
-	struct cm_hist_control *cm_hist_control;
-	/* stream-level fast updates */
-	const struct colorspace_transform *gamut_remap;
-	const struct dc_cursor_attributes *cursor_attributes;
-	const struct dc_cursor_position *cursor_position;
-	const struct periodic_interrupt_config *periodic_interrupt;
-	const enum dc_dither_option *dither_option;
-	struct dc_info_packet *vrr_infopacket;
-	struct dc_info_packet *vsc_infopacket;
-	struct dc_info_packet *vsp_infopacket;
-	struct dc_info_packet *hfvsif_infopacket;
-	struct dc_info_packet *vtem_infopacket;
-	struct dc_info_packet *adaptive_sync_infopacket;
-	struct dc_info_packet *avi_infopacket;
-	struct dc_info_packet *hdr_static_metadata;
-};
-
 struct dc_surface_update {
 	struct dc_plane_state *surface;
 
@@ -2422,11 +2396,6 @@ bool dc_resource_is_dsc_encoding_supported(const struct dc *dc);
 void get_audio_check(struct audio_info *aud_modes,
 	struct audio_check *aud_chk);
 
-bool fast_nonaddr_updates_exist(struct dc_fast_update *fast_update, int surface_count);
-void populate_fast_updates(struct dc_fast_update *fast_update,
-		struct dc_surface_update *srf_updates,
-		int surface_count,
-		struct dc_stream_update *stream_update);
 /*
  * Set up streams and links associated to drive sinks
  * The streams parameter is an absolute set of all active streams.
diff --git a/drivers/gpu/drm/amd/display/dc/dc_stream.h b/drivers/gpu/drm/amd/display/dc/dc_stream.h
index d9d79788a92c..fec5e7a84bb9 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_stream.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_stream.h
@@ -123,6 +123,9 @@ union stream_update_flags {
 		uint32_t info_frame : 1;
 		uint32_t dmdata : 1;
 		uint32_t dither : 1;
+		uint32_t func_shaper : 1;
+		uint32_t lut3d_func : 1;
+		uint32_t reserved : 11; /* adjust when adding new flags */
 	} bits;
 
 	uint32_t raw;
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.c
index a0944d53860e..f9d8ff6ce010 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.c
@@ -1823,27 +1823,30 @@ void dcn35_disable_link_output(struct dc_link *link,
 	dc->link_srv->dp_trace_source_sequence(link, DPCD_SOURCE_SEQ_AFTER_DISABLE_LINK_PHY);
 }
 
-void dcn35_dmub_hw_control_lock(struct dc *dc, struct dc_state *context, bool lock)
+bool dcn35_dmub_hw_control_lock(struct dc *dc, struct dc_state *context, bool lock)
 {
-	/* use always for now */
 	union dmub_inbox0_cmd_lock_hw hw_lock_cmd = { 0 };
 
 	if (!dc->ctx || !dc->ctx->dmub_srv)
-		return;
+		return false;
 
 	/* if not support inbox0 lock, would not use inbox0 lock mechanism  */
 	if (!dc->ctx->dmub_srv->dmub->meta_info.feature_bits.bits.inbox0_lock_support)
-		return;
+		return false;
 
-	if (!dc_dmub_srv_is_cursor_offload_enabled(dc) &&
-		!dmub_hw_lock_mgr_does_context_require_lock(dc, context))
-		return;
+	if (lock) {
+		if (!dc_dmub_srv_is_cursor_offload_enabled(dc) &&
+			!dmub_hw_lock_mgr_does_context_require_lock(dc, context))
+			return false;
+	}
 
 	hw_lock_cmd.bits.command_code = DMUB_INBOX0_CMD__HW_LOCK;
 	hw_lock_cmd.bits.hw_lock_client = HW_LOCK_CLIENT_DRIVER;
 	hw_lock_cmd.bits.lock = lock;
 	hw_lock_cmd.bits.should_release = !lock;
 	dmub_hw_lock_mgr_inbox0_cmd(dc->ctx->dmub_srv, hw_lock_cmd);
+
+	return true;
 }
 
 void dcn35_dmub_hw_control_lock_fast(union block_sequence_params *params)
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.h b/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.h
index 392ccbcb343c..9f779e408ec6 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.h
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.h
@@ -117,7 +117,7 @@ void dcn35_program_cursor_offload_now(struct dc *dc, const struct pipe_ctx *pipe
 void dcn35_disable_link_output(struct dc_link *link,
 		const struct link_resource *link_res,
 		enum signal_type signal);
-void dcn35_dmub_hw_control_lock(struct dc *dc, struct dc_state *context, bool lock);
+bool dcn35_dmub_hw_control_lock(struct dc *dc, struct dc_state *context, bool lock);
 void dcn35_dmub_hw_control_lock_fast(union block_sequence_params *params);
 
 #endif /* __DC_HWSS_DCN35_H__ */
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c
index c76754df2c38..8f202206c3c4 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c
@@ -1556,25 +1556,27 @@ void dcn401_optimize_bandwidth_sequence(struct dc *dc,
 				dc->clk_mgr, context, true, seq_state);
 }
 
-void dcn401_dmub_hw_control_lock(struct dc *dc,
+bool dcn401_dmub_hw_control_lock(struct dc *dc,
 		struct dc_state *context,
 		bool lock)
 {
 	(void)context;
-	/* use always for now */
 	union dmub_inbox0_cmd_lock_hw hw_lock_cmd = { 0 };
 
 	if (!dc->ctx || !dc->ctx->dmub_srv)
-		return;
+		return false;
 
-	if (!dc->debug.fams2_config.bits.enable && !dc_dmub_srv_is_cursor_offload_enabled(dc))
-		return;
+	if (lock) {
+		if (!dc->debug.fams2_config.bits.enable && !dc_dmub_srv_is_cursor_offload_enabled(dc))
+			return false;
+	}
 
 	hw_lock_cmd.bits.command_code = DMUB_INBOX0_CMD__HW_LOCK;
 	hw_lock_cmd.bits.hw_lock_client = HW_LOCK_CLIENT_DRIVER;
 	hw_lock_cmd.bits.lock = lock;
 	hw_lock_cmd.bits.should_release = !lock;
 	dmub_hw_lock_mgr_inbox0_cmd(dc->ctx->dmub_srv, hw_lock_cmd);
+	return true;
 }
 
 void dcn401_dmub_hw_control_lock_fast(union block_sequence_params *params)
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.h b/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.h
index 81e3700d728b..43bea09fb205 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.h
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.h
@@ -78,7 +78,7 @@ void dcn401_optimize_bandwidth_sequence(struct dc *dc,
 		struct dc_state *context,
 		struct block_sequence_state *seq_state);
 
-void dcn401_dmub_hw_control_lock(struct dc *dc,
+bool dcn401_dmub_hw_control_lock(struct dc *dc,
 		struct dc_state *context,
 		bool lock);
 void dcn401_fams2_update_config(struct dc *dc, struct dc_state *context, bool enable);
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn42/dcn42_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn42/dcn42_hwseq.c
index c152941c34f9..ee40ee8f62ef 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn42/dcn42_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn42/dcn42_hwseq.c
@@ -1188,25 +1188,28 @@ void dcn42_setup_stereo(struct pipe_ctx *pipe_ctx, struct dc *dc)
 
 	return;
 }
-void dcn42_dmub_hw_control_lock(struct dc *dc, struct dc_state *context, bool lock)
+bool dcn42_dmub_hw_control_lock(struct dc *dc, struct dc_state *context, bool lock)
 {
 
 	union dmub_inbox0_cmd_lock_hw hw_lock_cmd = { 0 };
 
 	if (!dc->ctx || !dc->ctx->dmub_srv)
-		return;
+		return false;
 
 	/* Use helper to check PSR/Replay for all streams in context */
 
-	if (!dc->debug.fams2_config.bits.enable && !dc_dmub_srv_is_cursor_offload_enabled(dc)
-		&& !dmub_hw_lock_mgr_does_context_require_lock(dc, context))
-		return;
+	if (lock) {
+		if (!dc->debug.fams2_config.bits.enable && !dc_dmub_srv_is_cursor_offload_enabled(dc)
+			&& !dmub_hw_lock_mgr_does_context_require_lock(dc, context))
+			return false;
+	}
 
 	hw_lock_cmd.bits.command_code = DMUB_INBOX0_CMD__HW_LOCK;
 	hw_lock_cmd.bits.hw_lock_client = HW_LOCK_CLIENT_DRIVER;
 	hw_lock_cmd.bits.lock = lock;
 	hw_lock_cmd.bits.should_release = !lock;
 	dmub_hw_lock_mgr_inbox0_cmd(dc->ctx->dmub_srv, hw_lock_cmd);
+	return true;
 }
 
 void dcn42_dmub_hw_control_lock_fast(union block_sequence_params *params)
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn42/dcn42_hwseq.h b/drivers/gpu/drm/amd/display/dc/hwss/dcn42/dcn42_hwseq.h
index 95b8ce23286c..31b92274a2f5 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn42/dcn42_hwseq.h
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn42/dcn42_hwseq.h
@@ -43,7 +43,7 @@ void dcn42_hw_block_power_up(struct dc *dc,
 		struct pg_block_update *update_state);
 void dcn42_root_clock_control(struct dc *dc,
 		struct pg_block_update *update_state, bool power_on);
-void dcn42_dmub_hw_control_lock(struct dc *dc, struct dc_state *context, bool lock);
+bool dcn42_dmub_hw_control_lock(struct dc *dc, struct dc_state *context, bool lock);
 void dcn42_dmub_hw_control_lock_fast(union block_sequence_params *params);
 void dcn42_setup_stereo(struct pipe_ctx *pipe_ctx, struct dc *dc);
 void dcn42_power_down_on_boot(struct dc *dc);
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/hw_sequencer.h b/drivers/gpu/drm/amd/display/dc/hwss/hw_sequencer.h
index f023bef4fd7e..fc5935b1e8b7 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/hw_sequencer.h
+++ b/drivers/gpu/drm/amd/display/dc/hwss/hw_sequencer.h
@@ -1719,7 +1719,7 @@ struct hw_sequencer_funcs {
 			const struct dc_state *cur_ctx,
 			const struct dc_state *new_ctx);
 	void (*wait_for_dcc_meta_propagation)(uint32_t delay);
-	void (*dmub_hw_control_lock)(struct dc *dc,
+	bool (*dmub_hw_control_lock)(struct dc *dc,
 			struct dc_state *context,
 			bool lock);
 	void (*fams2_update_config)(struct dc *dc,
-- 
2.43.0

