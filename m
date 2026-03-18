Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFCA0FED9E9
	for <amd-gfx@archiver.kernel.org>; Wed, 18 Mar 2026 01:03:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 54E2010E661;
	Wed, 18 Mar 2026 01:03:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="yVWyG2mW";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010042.outbound.protection.outlook.com [52.101.46.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7FAC810E661
 for <amd-gfx@lists.freedesktop.org>; Wed, 18 Mar 2026 01:03:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hW7Qu6D0HApD3kCMepZ9ZelUTliFyN7GDAO6nED035uvulZo93CAxeXM7Tr8nznS6IhSzdqZf1jkyAsN10dw5A1Qf96rYfjbT6eAPmRarT9nSyk/1OuJuLhM77OFe0UVbfgbCJSH7X2TcWqs4R3gXvZgEhB0ew+ZR93zncvdUNNs8UdEVcjOp1PfFtr0i0JNv8eQlU+0eyU5LkGFRppduypE8/bTTe60UoWa5PaiBJlPpzlpYzynGZpdnz1pLfzWLUgrM74NQ8Ujqi/RHHMbx8R3beIS/4NVHWjHnVzl/aEjZqL3y4ib/2s+QE6AxHpw6dWr32Bc9HRvDVuqgckB/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SYBj2puTQIScAqkCSQVIimmEw6Okngd3jdnwGK55KEo=;
 b=r+K+sVf3TFk7nczPCwkF+yB09u2EXZb7tc9/HEj/nx7qo0B/wz7zwK2hrMV22GRaao6+uDmlNS8BFrRj7MSfYmxqnSaoxzQ0LlIAPZ2lPvdSmLxq8JpUvWHRhL6p9Y0D6Z2zRAoTLez8+X5ufPKTgga7ucibeAudRwxqLAb9S4qDk60c8Jm55OEa/HgVMJqx8GdHfmhtt0/aid5bKzfYAJrhicqPWMg8p99EwOQgfvMm3gG1n9QKiTw131SEIODbtQ9Ls8u67x8ET7aagd+8dT9dxUQM8JZyx0PdklJDVmsLLI0xl5pyvKx6VwlgmmW1uyLFmpg8FdjpfPV/hdwkQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SYBj2puTQIScAqkCSQVIimmEw6Okngd3jdnwGK55KEo=;
 b=yVWyG2mWuVEuYp9DDwTFSynoYbrGIFNIy/7C/f/FH7RKnC85LXzVNpHsz5mHFeGO3BR64WtsuK6k0A/Rk47blcudd8tAwHcNmmRuimo6ILePY+NgUNUkwND6OseYdGodeOQzznvPLRQN7uMINAFS2P1Ejh6NNCmCB78mt5lq4UY=
Received: from PH8P222CA0011.NAMP222.PROD.OUTLOOK.COM (2603:10b6:510:2d7::35)
 by DS4PR12MB9818.namprd12.prod.outlook.com (2603:10b6:8:2a9::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.19; Wed, 18 Mar
 2026 01:01:57 +0000
Received: from SN1PEPF000397B5.namprd05.prod.outlook.com
 (2603:10b6:510:2d7:cafe::49) by PH8P222CA0011.outlook.office365.com
 (2603:10b6:510:2d7::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9700.24 via Frontend Transport; Wed,
 18 Mar 2026 01:01:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF000397B5.mail.protection.outlook.com (10.167.248.59) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9700.17 via Frontend Transport; Wed, 18 Mar 2026 01:01:56 +0000
Received: from maxMSI.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 17 Mar
 2026 20:01:52 -0500
From: ChuanYu Tseng <ChuanYu.Tseng@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, Dillon Varone <Dillon.Varone@amd.com>, "Nicholas
 Kazlauskas" <nicholas.kazlauskas@amd.com>, Chuanyu Tseng
 <chuanyu.tseng@amd.com>
Subject: [PATCH 15/31] drm/amd/display: Refactor DC update checks
Date: Wed, 18 Mar 2026 08:59:24 +0800
Message-ID: <20260318010224.513094-16-ChuanYu.Tseng@amd.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF000397B5:EE_|DS4PR12MB9818:EE_
X-MS-Office365-Filtering-Correlation-Id: 17605033-8c3c-4feb-4c13-08de8489f3c3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700016|82310400026|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info: 29kr3TjqLrh8HMVIZgLbJEXo6UJx4L94zSpIZgQBj/eOcfsXObaNfPrEyM024DudvHGKsxld5Vgdo9YYxzOqbC3XnJjkIveZ5Hdai+wvYexGoLqKKzSI86L+euMgIDy+e+DH3oznJUAb77NzZ7Y5s14b3W4yqGGaxgKr7pesYVAuMwqvx3PPCSbliV82yqwwdSeF8jPB//X9un6i8g5DPmBIaKrlxaiIPs6KYGKqyJJTIaPWsKYmh1BVPP9P8E+/fr6IfP548KA+lmyaw0WDw2pMRw5uyS+gWUotzvR8h/V8sG+WbsA1TSx803DnQDkNdiwy6mn3REL1D0oG5Z+TNwXwwdMPphPgzNIMDEjuTbaaanWg7sOzeF1c+0zLjDCVeSol4ei38bsH3gqr9WUq1VHNpIE9Nyt6Hi+qlUI2phRpzVVz4fuMMd/9390+6wx/+2VbtUaZ69aavafs19MtoWrjqJOZcngiyMyT+/oy1QD0pU/mQFHr6adSZUg8L5GixJD/FOIkaK96QwJaZos6AiuXwCvQLo6b7RJzgOU707pw7KoZMzFyqIL80HZ9Bo45Jji7Ntg58mztvsrHafjFdVb164z/Th/Tc+h2gZJsVxsskQTTdrYra3JcuHfgPQk5p8yHQrQWy+0rLbqBdvzH4LkBcMZgQhY2QJmt4AJ+dNf3r/nIoQP6d8ewvF9X2bbw+oU23rrq1H8qlBtftv2qitr5tJs5PSj19RyG+otur/Ihcxs6tgjBbBh9KSk7p4I04WeMiE/RyCMZUdQbVeDEzQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700016)(82310400026)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: xeCTCOc8lOBmQoZkAUQCI8DQKH/GbLO836amD/TzZi8uQosw5RnOzLn/JtLErneNablUusUCMLOYLWbiiYfb4hUNlQeS62JSERXU1OJ0Mk4c2q8U/uzqAyvK0MLWZISj6w8OFvwr3DAxvNCyzgHKCumJGk/ZFuPxzU+odTtNdLrJYQGOPyChv8uSxfK1xxpRZ9rheX0ZBrqWx3q4Nh8ycOU1PNKH6Q6EKhLiYUBwecjCQUbDJ14cNWbpdQnvhGhmz/PisgwiYqLkapa6EqQ/t9+132YbTjQvbN5NI0A1mgci2h83zMUGEcpXT4zy3OLWtzMfyLTZRu5RHUY1FCBucTCU9nnFKAxG4F/j1PiqD8GWA3urj9pkf3x6N8njwZNel8T/wxga02rg+UAOAEGlchRjcwCMvwtxMNc0KBx5TwLDL2h88tgg0YrVNM84MW11
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2026 01:01:56.7902 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 17605033-8c3c-4feb-4c13-08de8489f3c3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF000397B5.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR12MB9818
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
DC currently has fragmented definitions of update types.  This changes
consolidates them into a single interface, and adds expanded
functionality to accommodate all use cases.
- adds `dc_check_update_state_and_surfaces_for_stream` to determine
  update type including state, surface, and stream changes.
- adds missing surface/stream update checks to
  `dc_check_update_surfaces_for_stream`
- adds new update type `UPDATE_TYPE_ADDR_ONLY` to accomodate flows where
further distinction from `UPDATE_TYPE_FAST` was needed
- removes caller reliance on `enable_legacy_fast_update` to determine
  which commit function to use, instead embedding it in the update type

Reviewed-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Signed-off-by: Dillon Varone <Dillon.Varone@amd.com>
Signed-off-by: Chuanyu Tseng <chuanyu.tseng@amd.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |   6 +-
 .../amd/display/amdgpu_dm/amdgpu_dm_crtc.c    |   2 +-
 drivers/gpu/drm/amd/display/dc/core/dc.c      | 472 ++++++++----------
 drivers/gpu/drm/amd/display/dc/dc.h           |  20 +-
 4 files changed, 201 insertions(+), 299 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 344ff8cb42df..2b0648460097 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -9885,7 +9885,7 @@ static void amdgpu_dm_enable_self_refresh(struct amdgpu_crtc *acrtc_attach,
 	}
 
 	/* Decrement skip count when SR is enabled and we're doing fast updates. */
-	if (acrtc_state->update_type == UPDATE_TYPE_FAST &&
+	if (acrtc_state->update_type <= UPDATE_TYPE_FAST &&
 	    (psr->psr_feature_enabled || pr->config.replay_supported)) {
 		if (aconn->sr_skip_count > 0)
 			aconn->sr_skip_count--;
@@ -10093,7 +10093,7 @@ static void amdgpu_dm_commit_planes(struct drm_atomic_state *state,
 		 * fast updates.
 		 */
 		if (crtc->state->async_flip &&
-		    (acrtc_state->update_type != UPDATE_TYPE_FAST ||
+		    (acrtc_state->update_type > UPDATE_TYPE_FAST ||
 		     get_mem_type(old_plane_state->fb) != get_mem_type(fb)))
 			drm_warn_once(state->dev,
 				      "[PLANE:%d:%s] async flip with non-fast update\n",
@@ -10101,7 +10101,7 @@ static void amdgpu_dm_commit_planes(struct drm_atomic_state *state,
 
 		bundle->flip_addrs[planes_count].flip_immediate =
 			crtc->state->async_flip &&
-			acrtc_state->update_type == UPDATE_TYPE_FAST &&
+			acrtc_state->update_type <= UPDATE_TYPE_FAST &&
 			get_mem_type(old_plane_state->fb) == get_mem_type(fb);
 
 		timestamp_ns = ktime_get_ns();
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c
index 39fcbc3e702d..50f2fb704539 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c
@@ -685,7 +685,7 @@ static int amdgpu_dm_crtc_helper_atomic_check(struct drm_crtc *crtc,
 	 * pitch, the DCC state, rotation, etc.
 	 */
 	if (crtc_state->async_flip &&
-	    dm_crtc_state->update_type != UPDATE_TYPE_FAST) {
+	    dm_crtc_state->update_type > UPDATE_TYPE_FAST) {
 		drm_dbg_atomic(crtc->dev,
 			       "[CRTC:%d:%s] async flips are only supported for fast updates\n",
 			       crtc->base.id, crtc->name);
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index ef7108e94627..414c9a0e8922 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -2696,7 +2696,7 @@ static bool is_surface_in_context(
 static struct surface_update_descriptor get_plane_info_update_type(const struct dc_surface_update *u)
 {
 	union surface_update_flags *update_flags = &u->surface->update_flags;
-	struct surface_update_descriptor update_type = { UPDATE_TYPE_FAST, LOCK_DESCRIPTOR_NONE };
+	struct surface_update_descriptor update_type = { UPDATE_TYPE_ADDR_ONLY, LOCK_DESCRIPTOR_NONE };
 
 	if (!u->plane_info)
 		return update_type;
@@ -2804,7 +2804,7 @@ static struct surface_update_descriptor get_scaling_info_update_type(
 		const struct dc_surface_update *u)
 {
 	union surface_update_flags *update_flags = &u->surface->update_flags;
-	struct surface_update_descriptor update_type = { UPDATE_TYPE_FAST, LOCK_DESCRIPTOR_NONE };
+	struct surface_update_descriptor update_type = { UPDATE_TYPE_ADDR_ONLY, LOCK_DESCRIPTOR_NONE };
 
 	if (!u->scaling_info)
 		return update_type;
@@ -2855,11 +2855,11 @@ static struct surface_update_descriptor get_scaling_info_update_type(
 	return update_type;
 }
 
-static struct surface_update_descriptor det_surface_update(
+static struct surface_update_descriptor check_update_surface(
 		const struct dc_check_config *check_config,
 		struct dc_surface_update *u)
 {
-	struct surface_update_descriptor overall_type = { UPDATE_TYPE_FAST, LOCK_DESCRIPTOR_NONE };
+	struct surface_update_descriptor overall_type = { UPDATE_TYPE_ADDR_ONLY, LOCK_DESCRIPTOR_NONE };
 	union surface_update_flags *update_flags = &u->surface->update_flags;
 
 	if (u->surface->force_full_update) {
@@ -2879,7 +2879,7 @@ static struct surface_update_descriptor det_surface_update(
 
 	if (u->flip_addr) {
 		update_flags->bits.addr_update = 1;
-		elevate_update_type(&overall_type, UPDATE_TYPE_FAST, LOCK_DESCRIPTOR_STREAM);
+		elevate_update_type(&overall_type, UPDATE_TYPE_ADDR_ONLY, LOCK_DESCRIPTOR_STREAM);
 
 		if (u->flip_addr->address.tmz_surface != u->surface->address.tmz_surface) {
 			update_flags->bits.tmz_changed = 1;
@@ -2893,27 +2893,43 @@ static struct surface_update_descriptor det_surface_update(
 
 	if (u->input_csc_color_matrix) {
 		update_flags->bits.input_csc_change = 1;
-		elevate_update_type(&overall_type, UPDATE_TYPE_FAST, LOCK_DESCRIPTOR_STREAM);
+		elevate_update_type(&overall_type,
+				check_config->enable_legacy_fast_update ? UPDATE_TYPE_MED : UPDATE_TYPE_FAST,
+				LOCK_DESCRIPTOR_STREAM);
+	}
+
+	if (u->cursor_csc_color_matrix) {
+		elevate_update_type(&overall_type,
+				check_config->enable_legacy_fast_update ? UPDATE_TYPE_MED : UPDATE_TYPE_FAST,
+				LOCK_DESCRIPTOR_STREAM);
 	}
 
 	if (u->coeff_reduction_factor) {
 		update_flags->bits.coeff_reduction_change = 1;
-		elevate_update_type(&overall_type, UPDATE_TYPE_FAST, LOCK_DESCRIPTOR_STREAM);
+		elevate_update_type(&overall_type,
+				check_config->enable_legacy_fast_update ? UPDATE_TYPE_MED : UPDATE_TYPE_FAST,
+				LOCK_DESCRIPTOR_STREAM);
 	}
 
 	if (u->gamut_remap_matrix) {
 		update_flags->bits.gamut_remap_change = 1;
-		elevate_update_type(&overall_type, UPDATE_TYPE_FAST, LOCK_DESCRIPTOR_STREAM);
+		elevate_update_type(&overall_type,
+				check_config->enable_legacy_fast_update ? UPDATE_TYPE_MED : UPDATE_TYPE_FAST,
+				LOCK_DESCRIPTOR_STREAM);
 	}
 
 	if (u->cm || (u->gamma && dce_use_lut(u->plane_info ? u->plane_info->format : u->surface->format))) {
 		update_flags->bits.gamma_change = 1;
-		elevate_update_type(&overall_type, UPDATE_TYPE_FAST, LOCK_DESCRIPTOR_STREAM);
+		elevate_update_type(&overall_type,
+				check_config->enable_legacy_fast_update ? UPDATE_TYPE_MED : UPDATE_TYPE_FAST,
+				LOCK_DESCRIPTOR_STREAM);
 	}
 
 	if (u->cm && (u->cm->flags.bits.lut3d_enable || u->surface->cm.flags.bits.lut3d_enable)) {
 		update_flags->bits.lut_3d = 1;
-		elevate_update_type(&overall_type, UPDATE_TYPE_FAST, LOCK_DESCRIPTOR_STREAM);
+		elevate_update_type(&overall_type,
+				check_config->enable_legacy_fast_update ? UPDATE_TYPE_MED : UPDATE_TYPE_FAST,
+				LOCK_DESCRIPTOR_STREAM);
 	}
 
 	if (u->cm && u->cm->flags.bits.lut3d_dma_enable != u->surface->cm.flags.bits.lut3d_dma_enable &&
@@ -2929,9 +2945,10 @@ static struct surface_update_descriptor det_surface_update(
 
 	if (u->hdr_mult.value)
 		if (u->hdr_mult.value != u->surface->hdr_mult.value) {
-			// TODO: Should be fast?
 			update_flags->bits.hdr_mult = 1;
-			elevate_update_type(&overall_type, UPDATE_TYPE_MED, LOCK_DESCRIPTOR_STREAM);
+			elevate_update_type(&overall_type,
+					check_config->enable_legacy_fast_update ? UPDATE_TYPE_MED : UPDATE_TYPE_FAST,
+					LOCK_DESCRIPTOR_STREAM);
 		}
 
 	if (u->sdr_white_level_nits)
@@ -2985,7 +3002,7 @@ static struct surface_update_descriptor check_update_surfaces_for_stream(
 		int surface_count,
 		struct dc_stream_update *stream_update)
 {
-	struct surface_update_descriptor overall_type = { UPDATE_TYPE_FAST, LOCK_DESCRIPTOR_NONE };
+	struct surface_update_descriptor overall_type = { UPDATE_TYPE_ADDR_ONLY, LOCK_DESCRIPTOR_NONE };
 
 	/* When countdown finishes, promote this flip to full to trigger deferred final transition */
 	if (check_config->deferred_transition_state && !check_config->transition_countdown_to_steady_state) {
@@ -3052,7 +3069,18 @@ static struct surface_update_descriptor check_update_surfaces_for_stream(
 		if (su_flags->raw)
 			elevate_update_type(&overall_type, UPDATE_TYPE_FULL, LOCK_DESCRIPTOR_GLOBAL);
 
-		// Non-global cases
+		/* Non-global cases */
+		if (stream_update->hdr_static_metadata ||
+				stream_update->vrr_infopacket ||
+				stream_update->vsc_infopacket ||
+				stream_update->vsp_infopacket ||
+				stream_update->hfvsif_infopacket ||
+				stream_update->adaptive_sync_infopacket ||
+				stream_update->vtem_infopacket ||
+				stream_update->avi_infopacket) {
+			elevate_update_type(&overall_type, UPDATE_TYPE_MED, LOCK_DESCRIPTOR_STREAM);
+		}
+
 		if (stream_update->output_csc_transform) {
 			su_flags->bits.out_csc = 1;
 			elevate_update_type(&overall_type, UPDATE_TYPE_FAST, LOCK_DESCRIPTOR_STREAM);
@@ -3062,11 +3090,32 @@ static struct surface_update_descriptor check_update_surfaces_for_stream(
 			su_flags->bits.out_tf = 1;
 			elevate_update_type(&overall_type, UPDATE_TYPE_FAST, LOCK_DESCRIPTOR_STREAM);
 		}
+
+		if (stream_update->periodic_interrupt) {
+			elevate_update_type(&overall_type, UPDATE_TYPE_MED, LOCK_DESCRIPTOR_STREAM);
+		}
+
+		if (stream_update->dither_option) {
+			elevate_update_type(&overall_type, UPDATE_TYPE_MED, LOCK_DESCRIPTOR_STREAM);
+		}
+
+		if (stream_update->cursor_position || stream_update->cursor_attributes) {
+			elevate_update_type(&overall_type, UPDATE_TYPE_MED, LOCK_DESCRIPTOR_STREAM);
+		}
+
+		/* TODO - cleanup post blend CM */
+		if (stream_update->func_shaper || stream_update->lut3d_func) {
+			elevate_update_type(&overall_type, UPDATE_TYPE_FAST, LOCK_DESCRIPTOR_STREAM);
+		}
+
+		if (stream_update->pending_test_pattern) {
+			elevate_update_type(&overall_type, UPDATE_TYPE_FULL, LOCK_DESCRIPTOR_GLOBAL);
+		}
 	}
 
 	for (int i = 0 ; i < surface_count; i++) {
 		struct surface_update_descriptor inner_type =
-				det_surface_update(check_config, &updates[i]);
+				check_update_surface(check_config, &updates[i]);
 
 		elevate_update_type(&overall_type, inner_type.update_type, inner_type.lock_descriptor);
 	}
@@ -3093,6 +3142,81 @@ struct surface_update_descriptor dc_check_update_surfaces_for_stream(
 	return check_update_surfaces_for_stream(check_config, updates, surface_count, stream_update);
 }
 
+/*
+ * check_update_state_and_surfaces_for_stream() - Determine update type (fast, med, or full)
+ *
+ * This function performs checks on the DC global state, and is therefore not re-entrant.  It
+ * should not be called from DM.
+ *
+ * See :c:type:`enum surface_update_type <surface_update_type>` for explanation of update types
+ */
+static struct surface_update_descriptor check_update_state_and_surfaces_for_stream(
+		const struct dc *dc,
+		const struct dc_check_config *check_config,
+		const struct dc_stream_state *stream,
+		const struct dc_surface_update *updates,
+		const int surface_count,
+		const struct dc_stream_update *stream_update)
+{
+	const struct dc_state *context = dc->current_state;
+
+	struct surface_update_descriptor overall_type = { UPDATE_TYPE_ADDR_ONLY, LOCK_DESCRIPTOR_NONE};
+
+	if (updates)
+		for (int i = 0; i < surface_count; i++)
+			if (!is_surface_in_context(context, updates[i].surface))
+				elevate_update_type(&overall_type, UPDATE_TYPE_FULL, LOCK_DESCRIPTOR_GLOBAL);
+
+	if (stream) {
+		const struct dc_stream_status *stream_status = dc_stream_get_status_const(stream);
+		if (stream_status == NULL || stream_status->plane_count != surface_count)
+			elevate_update_type(&overall_type, UPDATE_TYPE_FULL, LOCK_DESCRIPTOR_GLOBAL);
+	}
+	if (dc->idle_optimizations_allowed)
+		elevate_update_type(&overall_type, UPDATE_TYPE_FULL, LOCK_DESCRIPTOR_GLOBAL);
+
+	if (dc_can_clear_cursor_limit(dc))
+		elevate_update_type(&overall_type, UPDATE_TYPE_FULL, LOCK_DESCRIPTOR_GLOBAL);
+
+	return overall_type;
+}
+
+/*
+ * dc_check_update_state_and_surfaces_for_stream() - Determine update type (fast, med, or full)
+ *
+ * This function performs checks on the DC global state, stream and surface update, and is
+ * therefore not re-entrant.  It should not be called from DM.
+ *
+ * See :c:type:`enum surface_update_type <surface_update_type>` for explanation of update types
+ */
+static struct surface_update_descriptor dc_check_update_state_and_surfaces_for_stream(
+		const struct dc *dc,
+		const struct dc_check_config *check_config,
+		struct dc_stream_state *stream,
+		struct dc_surface_update *updates,
+		int surface_count,
+		struct dc_stream_update *stream_update)
+{
+	/* check updates against the entire DC state (global) first */
+	struct surface_update_descriptor overall_update_type = check_update_state_and_surfaces_for_stream(
+			dc,
+			check_config,
+			stream,
+			updates,
+			surface_count,
+			stream_update);
+
+	/* check updates for stream and plane */
+	struct surface_update_descriptor stream_update_type = dc_check_update_surfaces_for_stream(
+			check_config,
+			updates,
+			surface_count,
+			stream_update);
+	elevate_update_type(&overall_update_type, stream_update_type.update_type, stream_update_type.lock_descriptor);
+
+	return overall_update_type;
+}
+
 static struct dc_stream_status *stream_get_status(
 	struct dc_state *ctx,
 	struct dc_stream_state *stream)
@@ -3449,13 +3573,6 @@ static void update_seamless_boot_flags(struct dc *dc,
 	}
 }
 
-static bool full_update_required_weak(
-		const struct dc *dc,
-		const struct dc_surface_update *srf_updates,
-		int surface_count,
-		const struct dc_stream_update *stream_update,
-		const struct dc_stream_state *stream);
-
 struct pipe_split_policy_backup {
 	bool dynamic_odm_policy;
 	bool subvp_policy;
@@ -3525,12 +3642,11 @@ static bool update_planes_and_stream_state(struct dc *dc,
 		struct dc_surface_update *srf_updates, int surface_count,
 		struct dc_stream_state *stream,
 		struct dc_stream_update *stream_update,
-		enum surface_update_type *new_update_type,
+		struct surface_update_descriptor *update_descriptor,
 		struct dc_state **new_context)
 {
 	struct dc_state *context;
 	int i, j;
-	enum surface_update_type update_type;
 	const struct dc_stream_status *stream_status;
 	struct dc_context *dc_ctx = dc->ctx;
 
@@ -3544,17 +3660,20 @@ static bool update_planes_and_stream_state(struct dc *dc,
 	}
 
 	context = dc->current_state;
-	update_type = dc_check_update_surfaces_for_stream(
-			&dc->check_config, srf_updates, surface_count, stream_update).update_type;
-	if (full_update_required_weak(dc, srf_updates, surface_count, stream_update, stream))
-		update_type = UPDATE_TYPE_FULL;
+	*update_descriptor = dc_check_update_state_and_surfaces_for_stream(
+			dc,
+			&dc->check_config,
+			stream,
+			srf_updates,
+			surface_count,
+			stream_update);
 
 	/* It is possible to receive a flip for one plane while there are multiple flip_immediate planes in the same stream.
 	 * E.g. Desktop and MPO plane are flip_immediate but only the MPO plane received a flip
 	 * Force the other flip_immediate planes to flip so GSL doesn't wait for a flip that won't come.
 	 */
 	force_immediate_gsl_plane_flip(dc, srf_updates, surface_count);
-	if (update_type == UPDATE_TYPE_FULL)
+	if (update_descriptor->update_type == UPDATE_TYPE_FULL)
 		backup_planes_and_stream_state(&dc->scratch.current_state, stream);
 
 	/* update current stream with the new updates */
@@ -3580,7 +3699,7 @@ static bool update_planes_and_stream_state(struct dc *dc,
 		}
 	}
 
-	if (update_type == UPDATE_TYPE_FULL) {
+	if (update_descriptor->update_type == UPDATE_TYPE_FULL) {
 		if (stream_update) {
 			uint32_t dsc_changed = stream_update->stream->update_flags.bits.dsc_changed;
 			stream_update->stream->update_flags.raw = 0xFFFFFFFF;
@@ -3590,13 +3709,13 @@ static bool update_planes_and_stream_state(struct dc *dc,
 			srf_updates[i].surface->update_flags.raw = 0xFFFFFFFF;
 	}
 
-	if (update_type >= update_surface_trace_level)
+	if (update_descriptor->update_type >= update_surface_trace_level)
 		update_surface_trace(dc, srf_updates, surface_count);
 
 	for (i = 0; i < surface_count; i++)
 		copy_surface_update_to_plane(srf_updates[i].surface, &srf_updates[i]);
 
-	if (update_type >= UPDATE_TYPE_FULL) {
+	if (update_descriptor->update_type >= UPDATE_TYPE_FULL) {
 		struct dc_plane_state *new_planes[MAX_SURFACES] = {0};
 
 		for (i = 0; i < surface_count; i++)
@@ -3634,7 +3753,7 @@ static bool update_planes_and_stream_state(struct dc *dc,
 	for (i = 0; i < surface_count; i++) {
 		struct dc_plane_state *surface = srf_updates[i].surface;
 
-		if (update_type != UPDATE_TYPE_MED)
+		if (update_descriptor->update_type != UPDATE_TYPE_MED)
 			continue;
 		if (surface->update_flags.bits.position_change) {
 			for (j = 0; j < dc->res_pool->pipe_count; j++) {
@@ -3648,7 +3767,7 @@ static bool update_planes_and_stream_state(struct dc *dc,
 		}
 	}
 
-	if (update_type == UPDATE_TYPE_FULL) {
+	if (update_descriptor->update_type == UPDATE_TYPE_FULL) {
 		struct pipe_split_policy_backup policy;
 		bool minimize = false;
 
@@ -3677,8 +3796,7 @@ static bool update_planes_and_stream_state(struct dc *dc,
 	update_seamless_boot_flags(dc, context, surface_count, stream);
 
 	*new_context = context;
-	*new_update_type = update_type;
-	if (update_type == UPDATE_TYPE_FULL)
+	if (update_descriptor->update_type == UPDATE_TYPE_FULL)
 		backup_planes_and_stream_state(&dc->scratch.new_state, stream);
 
 	return true;
@@ -3758,7 +3876,7 @@ static void commit_planes_do_stream_update(struct dc *dc,
 				program_cursor_position(dc, stream);
 
 			/* Full fe update*/
-			if (update_type == UPDATE_TYPE_FAST)
+			if (update_type <= UPDATE_TYPE_FAST)
 				continue;
 
 			if (stream_update->dsc_config)
@@ -4067,7 +4185,7 @@ static void commit_planes_for_stream_fast(struct dc *dc,
 	struct pipe_ctx *top_pipe_to_program = NULL;
 	struct dc_stream_status *stream_status = NULL;
 	bool should_offload_fams2_flip = false;
-	bool should_lock_all_pipes = (update_type != UPDATE_TYPE_FAST);
+	bool should_lock_all_pipes = (update_type > UPDATE_TYPE_FAST);
 
 	if (should_lock_all_pipes)
 		determine_pipe_unlock_order(dc, context);
@@ -4127,7 +4245,7 @@ static void commit_planes_for_stream_fast(struct dc *dc,
 				continue;
 
 			pipe_ctx->plane_state->triplebuffer_flips = false;
-			if (update_type == UPDATE_TYPE_FAST &&
+			if (update_type <= UPDATE_TYPE_FAST &&
 					dc->hwss.program_triplebuffer != NULL &&
 					!pipe_ctx->plane_state->flip_immediate && dc->debug.enable_tri_buf) {
 				/*triple buffer for VUpdate only*/
@@ -4184,7 +4302,7 @@ static void commit_planes_for_stream(struct dc *dc,
 {
 	int i, j;
 	struct pipe_ctx *top_pipe_to_program = NULL;
-	bool should_lock_all_pipes = (update_type != UPDATE_TYPE_FAST);
+	bool should_lock_all_pipes = (update_type > UPDATE_TYPE_FAST);
 	bool subvp_prev_use = false;
 	bool subvp_curr_use = false;
 	uint8_t current_stream_mask = 0;
@@ -4201,7 +4319,7 @@ static void commit_planes_for_stream(struct dc *dc,
 	if (update_type == UPDATE_TYPE_FULL && dc->optimized_required)
 		hwss_process_outstanding_hw_updates(dc, dc->current_state);
 
-	if (update_type != UPDATE_TYPE_FAST && dc->res_pool->funcs->prepare_mcache_programming)
+	if (update_type > UPDATE_TYPE_FAST && dc->res_pool->funcs->prepare_mcache_programming)
 		dc->res_pool->funcs->prepare_mcache_programming(dc, context);
 
 	for (i = 0; i < dc->res_pool->pipe_count; i++) {
@@ -4263,7 +4381,7 @@ static void commit_planes_for_stream(struct dc *dc,
 				odm_pipe->ttu_regs.min_ttu_vblank = MAX_TTU;
 	}
 
-	if ((update_type != UPDATE_TYPE_FAST) && stream->update_flags.bits.dsc_changed)
+	if ((update_type > UPDATE_TYPE_FAST) && stream->update_flags.bits.dsc_changed)
 		if (top_pipe_to_program &&
 			top_pipe_to_program->stream_res.tg->funcs->lock_doublebuffer_enable) {
 			if (should_use_dmub_inbox1_lock(dc, stream->link)) {
@@ -4334,7 +4452,7 @@ static void commit_planes_for_stream(struct dc *dc,
 		}
 		dc->hwss.post_unlock_program_front_end(dc, context);
 
-		if (update_type != UPDATE_TYPE_FAST)
+		if (update_type > UPDATE_TYPE_FAST)
 			if (dc->hwss.commit_subvp_config)
 				dc->hwss.commit_subvp_config(dc, context);
 
@@ -4350,7 +4468,7 @@ static void commit_planes_for_stream(struct dc *dc,
 		return;
 	}
 
-	if (update_type != UPDATE_TYPE_FAST) {
+	if (update_type > UPDATE_TYPE_FAST) {
 		for (j = 0; j < dc->res_pool->pipe_count; j++) {
 			struct pipe_ctx *pipe_ctx = &context->res_ctx.pipe_ctx[j];
 
@@ -4378,7 +4496,7 @@ static void commit_planes_for_stream(struct dc *dc,
 			if (!should_update_pipe_for_plane(context, pipe_ctx, plane_state))
 				continue;
 			pipe_ctx->plane_state->triplebuffer_flips = false;
-			if (update_type == UPDATE_TYPE_FAST &&
+			if (update_type <= UPDATE_TYPE_FAST &&
 					dc->hwss.program_triplebuffer != NULL &&
 					!pipe_ctx->plane_state->flip_immediate && dc->debug.enable_tri_buf) {
 				/*triple buffer for VUpdate only*/
@@ -4405,7 +4523,7 @@ static void commit_planes_for_stream(struct dc *dc,
 				continue;
 
 			/* Full fe update*/
-			if (update_type == UPDATE_TYPE_FAST)
+			if (update_type <= UPDATE_TYPE_FAST)
 				continue;
 
 			stream_status =
@@ -4424,7 +4542,7 @@ static void commit_planes_for_stream(struct dc *dc,
 			continue;
 
 		/* Full fe update*/
-		if (update_type == UPDATE_TYPE_FAST)
+		if (update_type <= UPDATE_TYPE_FAST)
 			continue;
 
 		ASSERT(!pipe_ctx->plane_state->triplebuffer_flips);
@@ -4435,7 +4553,7 @@ static void commit_planes_for_stream(struct dc *dc,
 		}
 	}
 
-	if (dc->hwss.program_front_end_for_ctx && update_type != UPDATE_TYPE_FAST) {
+	if (dc->hwss.program_front_end_for_ctx && update_type > UPDATE_TYPE_FAST) {
 		dc->hwss.program_front_end_for_ctx(dc, context);
 
 		//Pipe busy until some frame and line #
@@ -4463,7 +4581,7 @@ static void commit_planes_for_stream(struct dc *dc,
 	}
 
 	// Update Type FAST, Surface updates
-	if (update_type == UPDATE_TYPE_FAST) {
+	if (update_type <= UPDATE_TYPE_FAST) {
 		if (dc->hwss.set_flip_control_gsl)
 			for (i = 0; i < surface_count; i++) {
 				struct dc_plane_state *plane_state = srf_updates[i].surface;
@@ -4520,7 +4638,7 @@ static void commit_planes_for_stream(struct dc *dc,
 		dc->hwss.pipe_control_lock(dc, top_pipe_to_program, false);
 	}
 
-	if ((update_type != UPDATE_TYPE_FAST) && stream->update_flags.bits.dsc_changed)
+	if ((update_type > UPDATE_TYPE_FAST) && stream->update_flags.bits.dsc_changed)
 		if (top_pipe_to_program &&
 		    top_pipe_to_program->stream_res.tg->funcs->lock_doublebuffer_enable) {
 			top_pipe_to_program->stream_res.tg->funcs->wait_for_state(
@@ -4553,13 +4671,13 @@ static void commit_planes_for_stream(struct dc *dc,
 		/* If enabling subvp or transitioning from subvp->subvp, enable the
 		 * phantom streams before we program front end for the phantom pipes.
 		 */
-		if (update_type != UPDATE_TYPE_FAST) {
+		if (update_type > UPDATE_TYPE_FAST) {
 			if (dc->hwss.enable_phantom_streams)
 				dc->hwss.enable_phantom_streams(dc, context);
 		}
 	}
 
-	if (update_type != UPDATE_TYPE_FAST)
+	if (update_type > UPDATE_TYPE_FAST)
 		dc->hwss.post_unlock_program_front_end(dc, context);
 
 	if (subvp_prev_use && !subvp_curr_use) {
@@ -4572,7 +4690,7 @@ static void commit_planes_for_stream(struct dc *dc,
 			dc->hwss.disable_phantom_streams(dc, context);
 	}
 
-	if (update_type != UPDATE_TYPE_FAST)
+	if (update_type > UPDATE_TYPE_FAST)
 		if (dc->hwss.commit_subvp_config)
 			dc->hwss.commit_subvp_config(dc, context);
 	/* Since phantom pipe programming is moved to post_unlock_program_front_end,
@@ -5044,191 +5162,12 @@ static bool commit_minimal_transition_state(struct dc *dc,
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
-	} else {
-		fast_update[0].out_transfer_func = NULL;
-		fast_update[0].output_csc_transform = NULL;
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
-		fast_update[0].output_csc_transform)
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
-		fast_update[0].output_csc_transform)
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
-static bool full_update_required_weak(
-		const struct dc *dc,
-		const struct dc_surface_update *srf_updates,
-		int surface_count,
-		const struct dc_stream_update *stream_update,
-		const struct dc_stream_state *stream)
-{
-	const struct dc_state *context = dc->current_state;
-	if (srf_updates)
-		for (int i = 0; i < surface_count; i++)
-			if (!is_surface_in_context(context, srf_updates[i].surface))
-				return true;
-
-	if (stream) {
-		const struct dc_stream_status *stream_status = dc_stream_get_status_const(stream);
-		if (stream_status == NULL || stream_status->plane_count != surface_count)
-			return true;
-	}
-	if (dc->idle_optimizations_allowed)
-		return true;
-
-	if (dc_can_clear_cursor_limit(dc))
-		return true;
-
-	return false;
-}
-
-static bool full_update_required(
-		const struct dc *dc,
-		const struct dc_surface_update *srf_updates,
-		int surface_count,
-		const struct dc_stream_update *stream_update,
-		const struct dc_stream_state *stream)
-{
-	const union dc_plane_cm_flags blend_only_flags = {
-		.bits = {
-			.blend_enable = 1,
-		}
-	};
-
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
-				srf_updates[i].flip_addr->address.tmz_surface != srf_updates[i].surface->address.tmz_surface) ||
-				(srf_updates[i].cm &&
-				((srf_updates[i].cm->flags.all != blend_only_flags.all && srf_updates[i].cm->flags.all != 0) ||
-				(srf_updates[i].surface->cm.flags.all != blend_only_flags.all && srf_updates[i].surface->cm.flags.all != 0)))))
-			return true;
-	}
-
-	if (stream_update &&
-			(((stream_update->src.height != 0 && stream_update->src.width != 0) ||
-			(stream_update->dst.height != 0 && stream_update->dst.width != 0) ||
-			stream_update->integer_scaling_update) ||
-			stream_update->hdr_static_metadata ||
-			stream_update->abm_level ||
-			stream_update->periodic_interrupt ||
-			stream_update->vrr_infopacket ||
-			stream_update->vsc_infopacket ||
-			stream_update->vsp_infopacket ||
-			stream_update->hfvsif_infopacket ||
-			stream_update->vtem_infopacket ||
-			stream_update->adaptive_sync_infopacket ||
-			stream_update->avi_infopacket ||
-			stream_update->dpms_off ||
-			stream_update->allow_freesync ||
-			stream_update->vrr_active_variable ||
-			stream_update->vrr_active_fixed ||
-			stream_update->gamut_remap ||
-			stream_update->output_color_space ||
-			stream_update->dither_option ||
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
 		struct dc_stream_update *stream_update)
 {
 	struct dc_state *context;
-	enum surface_update_type update_type;
-	struct dc_fast_update fast_update[MAX_SURFACES] = {0};
 
 	/* In cases where MPO and split or ODM are used transitions can
 	 * cause underflow. Apply stream configuration with minimal pipe
@@ -5236,11 +5175,9 @@ static bool update_planes_and_stream_v2(struct dc *dc,
 	 */
 	bool force_minimal_pipe_splitting = 0;
 	bool is_plane_addition = 0;
-	bool is_fast_update_only;
 
-	populate_fast_updates(fast_update, srf_updates, surface_count, stream_update);
-	is_fast_update_only = fast_update_only(dc, fast_update, srf_updates,
-			surface_count, stream_update, stream);
+	struct surface_update_descriptor update_descriptor = {0};
+
 	force_minimal_pipe_splitting = could_mpcc_tree_change_for_active_pipes(
 			dc,
 			stream,
@@ -5259,7 +5196,7 @@ static bool update_planes_and_stream_v2(struct dc *dc,
 			surface_count,
 			stream,
 			stream_update,
-			&update_type,
+			&update_descriptor,
 			&context))
 		return false;
 
@@ -5269,7 +5206,7 @@ static bool update_planes_and_stream_v2(struct dc *dc,
 			dc_state_release(context);
 			return false;
 		}
-		update_type = UPDATE_TYPE_FULL;
+		elevate_update_type(&update_descriptor, UPDATE_TYPE_FULL, LOCK_DESCRIPTOR_GLOBAL);
 	}
 
 	if (dc->hwss.is_pipe_topology_transition_seamless &&
@@ -5278,13 +5215,13 @@ static bool update_planes_and_stream_v2(struct dc *dc,
 		commit_minimal_transition_state_in_dc_update(dc, context, stream,
 				srf_updates, surface_count);
 
-	if (is_fast_update_only && !dc->check_config.enable_legacy_fast_update) {
+	if (update_descriptor.update_type <= UPDATE_TYPE_FAST) {
 		commit_planes_for_stream_fast(dc,
 				srf_updates,
 				surface_count,
 				stream,
 				stream_update,
-				update_type,
+				update_descriptor.update_type,
 				context);
 	} else {
 		if (!stream_update &&
@@ -5300,7 +5237,7 @@ static bool update_planes_and_stream_v2(struct dc *dc,
 				surface_count,
 				stream,
 				stream_update,
-				update_type,
+				update_descriptor.update_type,
 				context);
 	}
 	if (dc->current_state != context)
@@ -5314,14 +5251,8 @@ static void commit_planes_and_stream_update_on_current_context(struct dc *dc,
 		struct dc_stream_update *stream_update,
 		enum surface_update_type update_type)
 {
-	struct dc_fast_update fast_update[MAX_SURFACES] = {0};
-
 	ASSERT(update_type < UPDATE_TYPE_FULL);
-	populate_fast_updates(fast_update, srf_updates, surface_count,
-			stream_update);
-	if (fast_update_only(dc, fast_update, srf_updates, surface_count,
-			stream_update, stream) &&
-			!dc->check_config.enable_legacy_fast_update)
+	if (update_type <= UPDATE_TYPE_FAST)
 		commit_planes_for_stream_fast(dc,
 				srf_updates,
 				surface_count,
@@ -5412,7 +5343,7 @@ static bool update_planes_and_stream_v3(struct dc *dc,
 		struct dc_stream_update *stream_update)
 {
 	struct dc_state *new_context;
-	enum surface_update_type update_type;
+	struct surface_update_descriptor update_descriptor = {0};
 
 	/*
 	 * When this function returns true and new_context is not equal to
@@ -5424,22 +5355,26 @@ static bool update_planes_and_stream_v3(struct dc *dc,
 	 * replaced by a newer context. Refer to the use of
 	 * swap_and_free_current_context below.
 	 */
-	if (!update_planes_and_stream_state(dc, srf_updates, surface_count,
-				stream, stream_update, &update_type,
+	if (!update_planes_and_stream_state(dc,
+				srf_updates,
+				surface_count,
+				stream,
+				stream_update,
+				&update_descriptor,
 				&new_context))
 		return false;
 
 	if (new_context == dc->current_state) {
 		commit_planes_and_stream_update_on_current_context(dc,
 				srf_updates, surface_count, stream,
-				stream_update, update_type);
+				stream_update, update_descriptor.update_type);
 
 		if (dc->check_config.transition_countdown_to_steady_state)
 			dc->check_config.transition_countdown_to_steady_state--;
 	} else {
 		commit_planes_and_stream_update_with_new_context(dc,
 				srf_updates, surface_count, stream,
-				stream_update, update_type, new_context);
+				stream_update, update_descriptor.update_type, new_context);
 	}
 
 	return true;
@@ -7213,7 +7148,7 @@ struct dc_update_scratch_space {
 	struct dc_stream_update *stream_update;
 	bool update_v3;
 	bool do_clear_update_flags;
-	enum surface_update_type update_type;
+	struct surface_update_descriptor update_descriptor;
 	struct dc_state *new_context;
 	enum update_v3_flow flow;
 	struct dc_state *backup_context;
@@ -7296,45 +7231,28 @@ static bool update_planes_and_stream_prepare_v3(
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
 			scratch->surface_count,
 			scratch->stream,
 			scratch->stream_update,
-			&scratch->update_type,
+			&scratch->update_descriptor,
 			&scratch->new_context
 	)) {
 		return false;
 	}
 
 	if (scratch->new_context == scratch->dc->current_state) {
-		ASSERT(scratch->update_type < UPDATE_TYPE_FULL);
+		ASSERT(scratch->update_descriptor.update_type < UPDATE_TYPE_FULL);
 
-		scratch->flow = is_hwss_fast_path_only
+		scratch->flow = scratch->update_descriptor.update_type <= UPDATE_TYPE_FAST
 				? UPDATE_V3_FLOW_NO_NEW_CONTEXT_CONTEXT_FAST
 				: UPDATE_V3_FLOW_NO_NEW_CONTEXT_CONTEXT_FULL;
 		return true;
 	}
 
-	ASSERT(scratch->update_type >= UPDATE_TYPE_FULL);
+	ASSERT(scratch->update_descriptor.update_type >= UPDATE_TYPE_FULL);
 
 	const bool seamless = scratch->dc->hwss.is_pipe_topology_transition_seamless(
 			scratch->dc,
@@ -7407,7 +7325,7 @@ static void update_planes_and_stream_execute_v3_commit(
 			intermediate_update ? scratch->intermediate_count : scratch->surface_count,
 			scratch->stream,
 			use_stream_update ? scratch->stream_update : NULL,
-			intermediate_context ? UPDATE_TYPE_FULL : scratch->update_type,
+			intermediate_context ? UPDATE_TYPE_FULL : scratch->update_descriptor.update_type,
 			// `dc->current_state` only used in `NO_NEW_CONTEXT`, where it is equal to `new_context`
 			intermediate_context ? scratch->intermediate_context : scratch->new_context
 	);
@@ -7425,7 +7343,7 @@ static void update_planes_and_stream_execute_v3(
 				scratch->surface_count,
 				scratch->stream,
 				scratch->stream_update,
-				scratch->update_type,
+				scratch->update_descriptor.update_type,
 				scratch->new_context
 		);
 		break;
diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index 4d15d97ed7f1..1dd0a2cf786c 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -467,6 +467,7 @@ struct dc_static_screen_params {
  */
 
 enum surface_update_type {
+	UPDATE_TYPE_ADDR_ONLY, /* only surface address is being updated, no other programming needed */
 	UPDATE_TYPE_FAST, /* super fast, safe to execute in isr */
 	UPDATE_TYPE_MED,  /* ISR safe, most of programming needed, no bw/clk change*/
 	UPDATE_TYPE_FULL, /* may need to shuffle resources */
@@ -1880,18 +1881,6 @@ struct dc_scaling_info {
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
-};
-
 struct dc_surface_update {
 	struct dc_plane_state *surface;
 
@@ -2030,12 +2019,7 @@ bool dc_resource_is_dsc_encoding_supported(const struct dc *dc);
 void get_audio_check(struct audio_info *aud_modes,
 	struct audio_check *aud_chk);
 
-bool fast_nonaddr_updates_exist(struct dc_fast_update *fast_update, int surface_count);
-void populate_fast_updates(struct dc_fast_update *fast_update,
-		struct dc_surface_update *srf_updates,
-		int surface_count,
-		struct dc_stream_update *stream_update);
-/*
+	/*
  * Set up streams and links associated to drive sinks
  * The streams parameter is an absolute set of all active streams.
  *
-- 
2.43.0

