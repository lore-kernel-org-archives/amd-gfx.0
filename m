Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83F69C4332F
	for <amd-gfx@archiver.kernel.org>; Thu, 20 Oct 2022 15:50:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DBEB210E4E7;
	Thu, 20 Oct 2022 15:50:19 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2046.outbound.protection.outlook.com [40.107.92.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9A6598985A
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 Oct 2022 15:48:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TA2eRfvNYuttxJbRsPYYrNnCMUSpi6lTebfCc+yV9NhixNbUh0nS3AEO82g2kzaeV6mTye0BSSBhKOQ9IvioNlbWOp3Yzek5plQ5xC/T+b+D3N3CuilP2dpaplLDvFLGLGHKTg9waNa7SIAqNDtwukQ6int3SJrJ0mT8IEkAsx4WVF6fuq77IUh9EOZ12RbNAAtDtFFQK9F6fD6GlXnZRaimGwzjlHuPksCIrGpVgpS11NWgsAXo9BWBPv8RS5xh4lOPWGH5oxC25IMReso41tkseFLCZsAdg2uW4DK+yBuafWjvLvfA46tQA0bGI2G/Uk9nsVyZ6/4gpUZ7461GwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3MNL6RKtjHbkgjcApD/9JUWNrhfAz1QUuksG4xHmAG8=;
 b=a91utYsBG5xix9wwEzQ3fWzsDBhP5FkZ6fA1Rgf/V6AxVOy++ZVzpVjExT8lCzKOAavCvjPIRcyIYYcCVFhNdHFL0DBfKgZ5Ipa6RChj9g2O6qdS2LpOWhQMYry26DITDD2aLayADZrXs0tFjvLVI1yOQmeGyIfYB2FhJVBWlZmZsNF2tGknTK0dl9Meek4eVJyPI+bUQr7iqg1ivUEMupGYMhCDXrQIb6bqqpVd69cNVqUHrigPtG/HtzYYQp4SiQJhTjSTTCREhxer8myNb9aWm5Dmh3cSlITlefvvzpnNxrhYDt8LS4V3GFYvJ4/WYyayCg88dF7ylKCJ7nxB/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3MNL6RKtjHbkgjcApD/9JUWNrhfAz1QUuksG4xHmAG8=;
 b=nhUaE1vdw5aPGqLbZiebqOEDFR6eTeZCQPYk7WegDBWS3Zi4D/PZqz4+BrscEiMpozgPsPnvqtptoirf2R07D5XLgCGloRp6t0Q6w5DqDqKCy4O0gO5F/cRUCiN8Zd6eRLuTw5Uhj4nw1HKEhSbqnjqA+6gT5tDsE7zhX3SPf7M=
Received: from DS7PR05CA0055.namprd05.prod.outlook.com (2603:10b6:8:2f::15) by
 DM4PR12MB7526.namprd12.prod.outlook.com (2603:10b6:8:112::20) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5723.35; Thu, 20 Oct 2022 15:48:21 +0000
Received: from DM6NAM11FT005.eop-nam11.prod.protection.outlook.com
 (2603:10b6:8:2f:cafe::80) by DS7PR05CA0055.outlook.office365.com
 (2603:10b6:8:2f::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.9 via Frontend
 Transport; Thu, 20 Oct 2022 15:48:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT005.mail.protection.outlook.com (10.13.172.238) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5746.16 via Frontend Transport; Thu, 20 Oct 2022 15:48:21 +0000
Received: from atma3.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Thu, 20 Oct
 2022 10:48:19 -0500
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 32/33] drm/amd/display: Add kernel doc for commit sequence
Date: Thu, 20 Oct 2022 11:47:01 -0400
Message-ID: <20221020154702.503934-33-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221020154702.503934-1-Rodrigo.Siqueira@amd.com>
References: <20221020154702.503934-1-Rodrigo.Siqueira@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT005:EE_|DM4PR12MB7526:EE_
X-MS-Office365-Filtering-Correlation-Id: d13ee16b-d3db-426e-6134-08dab2b283de
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aRpgHlt+UMWkckC04mEWX2wybd1YcGX7pB498NZNhLO1drvuo6C3gEq5Ym8TcjLOlFLQv1+/DwRqKqefETLKjGpU4Ks/uYBs19PvYRHSb1O9lzbk3xcSxxniyCBcIHZp8FDjoAINY379psIEdwH8yHZHi5YGvGabipbHj31uik8+My+zERtE8bTuyVCPupSdL8NCdup0sTPyl2LS5SZ+iuZOyRuQofJAZ4OBKUkL2+tlS/WBHarZJ3a0JpARkVblwjv9wTcII73w3XlpbdaNFep8QpELF2CVzM6p2Yhp01HvVIyzWeTLS727MFbjGFA1L+ut+fpr37t9bttaLBErlF8DTLZORkTjWzBy5XEZIC7KOUbHGudmVXiCZacuQF7xFt1rNjymYyZL3Fw8Kj4XEbZqnKPHGqkNmOhMHkYVDVn2/rIy5UOy8boiiJLUyx5KeJP9Wd51O/448BUgxkcywt0a/MsNlXFogaiVbVa2xbqitNCXG0aWtZavII2LvVAox4N4fKh83/QJzLIh4JKWTYDrh8njptXnQWik8l0jeC4w+7njUFILezEHb75OWTKsVu6oT9G+PyRdLCqX4UktgsTLh+QQyHFYhCtpa7lcMBn2OLXkg+Hpo0MAMhzmvXj3SLIZhhLx0+BMLJb2EFiopx8WuYVID4PTZBLFZNkDcr5p4LjSYbvPivhsxU8txMUurFlkqNHPU03WyVNohZ0064aJcdaAhfAJjDJKMxPq5XL3vyWbcGwEWJ+7+Ly99UryBT/+4+I7HujGfwL8VSMNc7ypdn7VgZG3bovrFAbStrYfXO8DBPvNDV08l8U5gVRJ
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(346002)(136003)(396003)(39860400002)(376002)(451199015)(46966006)(40470700004)(36840700001)(83380400001)(6916009)(54906003)(478600001)(7696005)(2616005)(2906002)(26005)(8936002)(40460700003)(36756003)(47076005)(426003)(86362001)(5660300002)(336012)(16526019)(1076003)(6666004)(186003)(40480700001)(70586007)(70206006)(81166007)(356005)(82740400003)(316002)(4326008)(8676002)(41300700001)(36860700001)(82310400005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2022 15:48:21.2033 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d13ee16b-d3db-426e-6134-08dab2b283de
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT005.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7526
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
Cc: stylon.wang@amd.com, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com, roman.li@amd.com,
 solomon.chiu@amd.com, Aurabindo.Pillai@amd.com, wayne.lin@amd.com,
 Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Add basic kernel-doc that describes some of the struct and functions
that are part of the DC commit sequence..

Reviewed-by: Aurabindo Pillai <Aurabindo.Pillai@amd.com>
Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Signed-off-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc.c      | 63 ++++++++++++++++---
 .../gpu/drm/amd/display/dc/core/dc_resource.c | 11 ++++
 .../gpu/drm/amd/display/dc/inc/core_types.h   | 16 ++++-
 3 files changed, 79 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index 945b5210fba4..2858917a66be 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -1714,8 +1714,13 @@ void dc_z10_save_init(struct dc *dc)
 		dc->hwss.z10_save_init(dc);
 }
 
-/*
- * Applies given context to HW and copy it into current context.
+/**
+ * dc_commit_state_no_check - Apply context to the hardware
+ *
+ * @dc: DC object with the current status to be updated
+ * @context: New state that will become the current status at the end of this function
+ *
+ * Applies given context to the hardware and copy it into current context.
  * It's up to the user to release the src context afterwards.
  */
 static enum dc_status dc_commit_state_no_check(struct dc *dc, struct dc_state *context)
@@ -3651,10 +3656,24 @@ static void commit_planes_for_stream(struct dc *dc,
 	}
 }
 
-/* Determines if the incoming context requires a applying transition state with unnecessary
- * pipe splitting and ODM disabled, due to hardware limitations. In a case where
- * the OPP associated with an MPCC might change due to plane additions, this function
+/**
+ * could_mpcc_tree_change_for_active_pipes - Check if an OPP associated with MPCC might change
+ *
+ * @dc: Used to get the current state status
+ * @stream: Target stream, which we want to remove the attached planes
+ * @surface_count: Number of surface update
+ * @is_plane_addition: [in] Fill out with true if it is a plane addition case
+ *
+ * DCN32x and newer support a feature named Dynamic ODM which can conflict with
+ * the MPO if used simultaneously in some specific configurations (e.g.,
+ * 4k@144). This function checks if the incoming context requires applying a
+ * transition state with unnecessary pipe splitting and ODM disabled to
+ * circumvent our hardware limitations to prevent this edge case. If the OPP
+ * associated with an MPCC might change due to plane additions, this function
  * returns true.
+ *
+ * Return:
+ * Return true if OPP and MPCC might change, otherwise, return false.
  */
 static bool could_mpcc_tree_change_for_active_pipes(struct dc *dc,
 		struct dc_stream_state *stream,
@@ -3729,6 +3748,24 @@ static bool could_mpcc_tree_change_for_active_pipes(struct dc *dc,
 	return force_minimal_pipe_splitting;
 }
 
+/**
+ * commit_minimal_transition_state - Create a transition pipe split state
+ *
+ * @dc: Used to get the current state status
+ * @transition_base_context: New transition state
+ *
+ * In some specific configurations, such as pipe split on multi-display with
+ * MPO and/or Dynamic ODM, removing a plane may cause unsupported pipe
+ * programming when moving to new planes. To mitigate those types of problems,
+ * this function adds a transition state that minimizes pipe usage before
+ * programming the new configuration. When adding a new plane, the current
+ * state requires the least pipes, so it is applied without splitting. When
+ * removing a plane, the new state requires the least pipes, so it is applied
+ * without splitting.
+ *
+ * Return:
+ * Return false if something is wrong in the transition state.
+ */
 static bool commit_minimal_transition_state(struct dc *dc,
 		struct dc_state *transition_base_context)
 {
@@ -3742,6 +3779,10 @@ static bool commit_minimal_transition_state(struct dc *dc,
 
 	if (!transition_context)
 		return false;
+	/* Setup:
+	 * Store the current ODM and MPC config in some temp variables to be
+	 * restored after we commit the transition state.
+	 */
 
 	/* check current pipes in use*/
 	for (i = 0; i < dc->res_pool->pipe_count; i++) {
@@ -3777,7 +3818,7 @@ static bool commit_minimal_transition_state(struct dc *dc,
 
 	dc_resource_state_copy_construct(transition_base_context, transition_context);
 
-	//commit minimal state
+	/* commit minimal state */
 	if (dc->res_pool->funcs->validate_bandwidth(dc, transition_context, false)) {
 		for (i = 0; i < transition_context->stream_count; i++) {
 			struct dc_stream_status *stream_status = &transition_context->stream_status[i];
@@ -3795,10 +3836,12 @@ static bool commit_minimal_transition_state(struct dc *dc,
 		ret = dc_commit_state_no_check(dc, transition_context);
 	}
 
-	/*always release as dc_commit_state_no_check retains in good case*/
+	/* always release as dc_commit_state_no_check retains in good case */
 	dc_release_state(transition_context);
 
-	/*restore previous pipe split and odm policy*/
+	/* TearDown:
+	 * Restore original configuration for ODM and MPO.
+	 */
 	if (!dc->config.is_vmin_only_asic)
 		dc->debug.pipe_split_policy = tmp_mpc_policy;
 
@@ -3806,12 +3849,12 @@ static bool commit_minimal_transition_state(struct dc *dc,
 	dc->debug.force_disable_subvp = temp_subvp_policy;
 
 	if (ret != DC_OK) {
-		/*this should never happen*/
+		/* this should never happen */
 		BREAK_TO_DEBUGGER();
 		return false;
 	}
 
-	/*force full surface update*/
+	/* force full surface update */
 	for (i = 0; i < dc->current_state->stream_count; i++) {
 		for (j = 0; j < dc->current_state->stream_status[i].plane_count; j++) {
 			dc->current_state->stream_status[i].plane_states[j]->update_flags.raw = 0xFFFFFFFF;
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
index 7caf3139fabc..da164685547d 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
@@ -1768,6 +1768,17 @@ bool dc_remove_plane_from_context(
 	return true;
 }
 
+/**
+ * dc_rem_all_planes_for_stream - Remove planes attached to the target stream.
+ *
+ * @dc: Current dc state.
+ * @stream: Target stream, which we want to remove the attached plans.
+ * @context: New context.
+ *
+ * Return:
+ * Return true if DC was able to remove all planes from the target
+ * stream, otherwise, return false.
+ */
 bool dc_rem_all_planes_for_stream(
 		const struct dc *dc,
 		struct dc_stream_state *stream,
diff --git a/drivers/gpu/drm/amd/display/dc/inc/core_types.h b/drivers/gpu/drm/amd/display/dc/inc/core_types.h
index fe34cfde22a6..85495ef026f5 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/core_types.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/core_types.h
@@ -420,7 +420,10 @@ struct pipe_ctx {
 
 	struct pll_settings pll_settings;
 
-	/* link config records software decision for what link config should be
+	/**
+	 * @link_config:
+	 *
+	 * link config records software decision for what link config should be
 	 * enabled given current link capability and stream during hw resource
 	 * mapping. This is to decouple the dependency on link capability during
 	 * dc commit or update.
@@ -542,6 +545,10 @@ struct dc_state {
 
 	/**
 	 * @bw_ctx: The output from bandwidth and watermark calculations and the DML
+	 *
+	 * Each context must have its own instance of VBA, and in order to
+	 * initialize and obtain IP and SOC, the base DML instance from DC is
+	 * initially copied into every context.
 	 */
 	struct bw_context bw_ctx;
 
@@ -559,6 +566,13 @@ struct dc_state {
 
 	struct clk_mgr *clk_mgr;
 
+	/**
+	 * @refcount: refcount reference
+	 *
+	 * Notice that dc_state is used around the code to capture the current
+	 * context, so we need to pass it everywhere. That's why we want to use
+	 * kref in this struct.
+	 */
 	struct kref refcount;
 
 	struct {
-- 
2.35.1

