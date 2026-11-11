Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32CCC606A31C
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Nov 2026 01:42:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=0pIj6RhB
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A032310F8D0;
	Wed, 11 Nov 2026 01:42:45 +0000 (UTC)
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010065.outbound.protection.outlook.com [52.101.85.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9576210F8D0
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 Nov 2026 01:42:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lCSsNtqU/fbdUiOoMRIh9JPRRbu/Qf1DJCqwsndKNoNJhH5g6OZXaiJgmSyqQvgAGq47VTuBUelYQHRCO1jpPeW2Gs4K2RzXgSYRCyIH3XUhjZrwhkn2zl4oFOzUY0Q5LNEfI5EG2R8dNaBZWpAQ04PiPHNuTXSO1XfsQea8Fs/935jVl9eoRnJnV+Um5BD88f9GMglov704TeQ0He+kgaHo21cm72kzNnMZ3PIaCFRlJeRfyO7Cbw/psgxwCkeHzsSReuqrZpvkmKHrScjEKzHQS//F7JiPMYkPsA25l7GZr71NBumgJbkB33k/5zE38wKh50ELTC+FDGLzbRnKRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s0mxBm+Ecj2c+kVCIgNq/LAm4HaXl3sOGWYljT2rAIc=;
 b=qfTlb4SWr73i2k9OILhiltA5TvsbKhRjiqWiJAL98Ayyr7Y/X0bwqXBc2F1yaMZjLOqXa/JONCwqkrdz0RMI58V+F1wliSUWavmilEuk4cW7P+cLaoFr8xlSYuHDcrfnGVhdets6SWtu7hNNC0aUvUOpFIaKyKf2+8oGWwFq9AxCslA74kPayFDibJyjEWCTr41Lu1B9hFvSJ3Ahb+1l6QC0kGJDLDBSVb6+x76py8c70HnFkU0xuzxn9mmnVgv/LgLyfZDiwL978+4OfXV2bpRCZmzI1szqaoUjZdiR4fky/wGCOR+MCRfRz0c32sJr2Ak5ODCo8G4zfrlCFYqazw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s0mxBm+Ecj2c+kVCIgNq/LAm4HaXl3sOGWYljT2rAIc=;
 b=0pIj6RhB7Cv+nN18TjiL1ndhKaT/u1vD2kam2UaPTUVBykjj7x6JGQgNQmYf8Gxm5mTWODYuwnhI26pP8ob5P1sRbl5HhiG47w1uJJ/M22VoTWhWXelq2QGP4U6rOqnX2jV1OeTs9x70qSo8aF9vt7mN38sFgbKmwfAT6zW+Ylc=
Received: from SJ0PR13CA0068.namprd13.prod.outlook.com (2603:10b6:a03:2c4::13)
 by LY0PR12MB563561.namprd12.prod.outlook.com (2603:10b6:404:203::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.8; Wed, 11 Nov
 2026 01:42:34 +0000
Received: from SJ1PEPF0000231B.namprd03.prod.outlook.com
 (2603:10b6:a03:2c4:cafe::79) by SJ0PR13CA0068.outlook.office365.com
 (2603:10b6:a03:2c4::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.8 via Frontend Transport; Wed, 11
 Nov 2026 01:42:33 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF0000231B.mail.protection.outlook.com (10.167.242.232) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Wed, 11 Nov 2026 01:42:33 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Tue, 10 Nov
 2026 19:42:32 -0600
Received: from wayne-dev-lnx.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.53 via Frontend
 Transport; Tue, 10 Nov 2026 19:42:29 -0600
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Tony Cheng <tony.cheng@amd.com>, Jun Lei
 <jun.lei@amd.com>
Subject: [PATCH 34/74] drm/amd/display: Skip first-enable steps on a kept plane
Date: Wed, 11 Nov 2026 09:28:40 +0800
Message-ID: <20261111014100.3596072-35-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261111014100.3596072-1-Wayne.Lin@amd.com>
References: <20261111014100.3596072-1-Wayne.Lin@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF0000231B:EE_|LY0PR12MB563561:EE_
X-MS-Office365-Filtering-Correlation-Id: f372817d-3026-4bbd-e300-08df3f950ead
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|23010399003|82310400026|376014|1800799024|18002099003|22082099003|6133799003|3023799007|56012099006|11063799006|261021121427099003|261102123227099003|261009223027099003|10067099003|261022105027099003|261026121527099003|261026140227099003|261021123027099003|261028144727099003;
X-Microsoft-Antispam-Message-Info: mqihf3wf628VZqd1/2MFfzIb4WidUVNuJiGnlvA1EndIlSI95gHY7E9GgblcCNIC02nW7EWIf3saRly0UZhQoLuQ2WbBxMZ815WeF5ugvnAhZb+D6306LaRwDqGc9FoJOkbVTA0AEZ6XfYfLUyOoXFKM2X96KQXSr7IxX3qNQdsiMmQm5RMeYA6sd7LQ2oAbtiGLTW86jHLrEx5xsrv0FyhA2+VEGVoXw53DJovVDoMDkGgEVFq7tp0YSHDliU9/EEiiNVzcmnYTNeY7iwzwVOQtuqoCXyPDjhlDKYiIjJNgFdinncDKr0Uvs24gHX83r41376AEkHGiamjfMs5V/GaZnB5NIAlLTlE349/e0XQQq9dvAEN6KUX6+Z67YC4q9E53AuRHCiyO6ZDxNdyEqPEcDJtBU+rsYW6DB67SXIsWbkvvW0CgjPcuztAHQEup+K1NbtNJ0fyikV1kp4X3u7CNxzqPLIwvWkj0Yx54W/yKqJi71scEvGMoV2hTf7PwQmlXWUhZLQUujIWLuBWDf6vFceuP+aBnRzqH2BdjUwxONbID13jMCEARgYgf6Hl9dKJbteIpIpW5CivkkpbLlViP2WdqPVUzTs/Vq371Yuuq982P9wztbXnJH261jnoVZlz5/f+po0YGS11vsskBc2/2tUYu5Nr5yo4dl4WUt0yrRCBWHJFGjsCofZyqpai0dA1P+JGuP4/z9LBKInJG7g==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(23010399003)(82310400026)(376014)(1800799024)(18002099003)(22082099003)(6133799003)(3023799007)(56012099006)(11063799006)(261021121427099003)(261102123227099003)(261009223027099003)(10067099003)(261022105027099003)(261026121527099003)(261026140227099003)(261021123027099003)(261028144727099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: oPEKRCKo83AJRNrsQIW978gH2ZjIcljQC3VAptmMu5xvjgfDI9fTZk1/0XKJACPGUFoJY/bN8LUCSt1uEgYRnQC6WTa2/oWhTL65hXdfAVTqM512Kxk4HAXY/hbSlqYDR7+7Rq5cq4pGuIE66tB9XfESmm2b7uAzZlofHS3i0078ed4KCU+kR7qmoxKy7w0S1APARd/uFcS9v7rmZ8/BDg4szB6+1bKMPga3FlWWxqJbt8l3l0CPN6y4xjyZXCnv869APltcRJMDXiZ0okpyTNsH4Df4OMqNByOtCL3UznloR34DAKaMM22XWwqgaAkyGnjeO6cWdSca7koPrPVW5t21H9wiqfRGBLw6Gyn/LYieF5mvP3HyB42I9O7dPp9jJGo0ASgfemtetc7mQ4LrIRy0kAen78QB0OliGGpxPB4fUBwHv4wg8vAEqR/f5Yx9
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2026 01:42:33.7560 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f372817d-3026-4bbd-e300-08df3f950ead
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF0000231B.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LY0PR12MB563561
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Tony Cheng <tony.cheng@amd.com>

[Why]
The seamless builder branched on an internal plane-add check, and
rejected an update because the OPP tree was non-empty. A builder
check has to name a logical state change. Reconfiguring a HUBP/DPP
is a subset of enabling it.

[How]
Drop the OPP-tree support check and the plane-add branch. One step
table covers both. skip_if leaves out first-enable steps when the
HUBP/DPP is already on, and skips the MPCC remove when the tree is
empty. Rename the per-stream adder to add per OTG master.

Cc: Jun Lei <jun.lei@amd.com>
Signed-off-by: Tony Cheng <tony.cheng@amd.com>
Signed-off-by: Wayne Lin <wayne.lin@amd.com>
---
 .../bls_builder/bls_builder_private_types.h   |   5 +
 .../dc/bls_builder/dcn401_commit_builder.c    | 254 ++++++++----------
 2 files changed, 117 insertions(+), 142 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/bls_builder/bls_builder_private_types.h b/drivers/gpu/drm/amd/display/dc/bls_builder/bls_builder_private_types.h
index a3b27a179f20..df86ff7d4867 100644
--- a/drivers/gpu/drm/amd/display/dc/bls_builder/bls_builder_private_types.h
+++ b/drivers/gpu/drm/amd/display/dc/bls_builder/bls_builder_private_types.h
@@ -117,6 +117,11 @@ struct dcn401_commit_step_meta {
 		bool no_manual_trigger;
 		/* The OPP MPC tree has no plane yet. */
 		bool opp_tree_empty;
+		/*
+		 * The HUBP/DPP block is already on. The step is part of
+		 * enabling that block the first time, not of reconfiguring it.
+		 */
+		bool hubp_dpp_already_enabled;
 	} skip_if;
 };
 
diff --git a/drivers/gpu/drm/amd/display/dc/bls_builder/dcn401_commit_builder.c b/drivers/gpu/drm/amd/display/dc/bls_builder/dcn401_commit_builder.c
index a636e2bfe042..d071768bda03 100644
--- a/drivers/gpu/drm/amd/display/dc/bls_builder/dcn401_commit_builder.c
+++ b/drivers/gpu/drm/amd/display/dc/bls_builder/dcn401_commit_builder.c
@@ -784,34 +784,6 @@ static bool check_no_flip_int(const struct dc *dc,
 			!pipe->plane_state->flip_int_enabled;
 }
 
-/* With an empty tree, DC1 removes no MPCC before the insert. */
-/*
- * Plane add needs an empty OPP tree. A kept-plane update removes the MPCC
- * that is already there, so a non-empty tree is fine.
- */
-static bool check_opp_tree_for_update(const struct dc *dc,
-		const struct dc_state *current_state,
-		const struct dc_state *new_state)
-{
-	const struct pipe_ctx *pipe = dcn401_otg_of(new_state);
-	const struct output_pixel_processor *opp;
-	unsigned int i;
-
-	(void)dc;
-	if (!pipe)
-		return false;
-	opp = pipe->stream_res.opp;
-	if (!opp)
-		return false;
-	for (i = 0; i < MAX_PIPES; i++) {
-		if (opp->mpcc_disconnect_pending[i])
-			return false;
-	}
-	if (dcn401_is_plane_kept(current_state, new_state))
-		return true;
-	return !opp->mpc_tree_params.opp_list;
-}
-
 /*
  * A kept-plane update does not yet emit scaler or viewport steps. Plane
  * add has no current plane, so those rects are not compared.
@@ -1061,8 +1033,6 @@ static enum bls_builder_result dcn401_check_seamless_update_support(
 	CHECK_CONDITION(no_flip_int, "flip interrupt is enabled");
 
 	/* update_dchubp_dpp. */
-	CHECK_CONDITION(opp_tree_for_update,
-			"opp tree is not ready for the update");
 	CHECK_CONDITION(no_plane_gamut_remap, "plane gamut remap is set");
 	CHECK_CONDITION(no_stream_gamut_remap, "stream gamut remap is set");
 	CHECK_CONDITION(no_output_csc, "output csc is set");
@@ -1330,79 +1300,82 @@ static const struct dcn401_commit_step bls_update_head_new_lock[] = {
 	{ .func = DC_UDELAY },
 };
 
-/* blank_pixel_data (unblank), dcn401_program_tg and update_odm. */
+/*
+ * blank_pixel_data (unblank), dcn401_program_tg and update_odm.
+ * First enable of the HUBP/DPP only.
+ */
 static const struct dcn401_commit_step bls_update_head_new_stream[] = {
 	{ .func = OPP_SET_DISP_PATTERN_GENERATOR,
-	  .meta.opp_set_disp_pattern_generator.unblank = true },
-	{ .func = TG_PROGRAM_GLOBAL_SYNC },
-	{ .func = TG_WAIT_FOR_STATE },
-	{ .func = TG_SET_VTG_PARAMS },
-	{ .func = TG_SETUP_VERTICAL_INTERRUPT2 },
-	{ .func = OPTC_SET_ODM_BYPASS },
-	{ .func = OPP_PIPE_CLOCK_CONTROL },
-	{ .func = OPP_PROGRAM_LEFT_EDGE_EXTRA_PIXEL },
+	  .meta.opp_set_disp_pattern_generator.unblank = true,
+	  .meta.skip_if.hubp_dpp_already_enabled = true },
+	{ .func = TG_PROGRAM_GLOBAL_SYNC,
+	  .meta.skip_if.hubp_dpp_already_enabled = true },
+	{ .func = TG_WAIT_FOR_STATE,
+	  .meta.skip_if.hubp_dpp_already_enabled = true },
+	{ .func = TG_SET_VTG_PARAMS,
+	  .meta.skip_if.hubp_dpp_already_enabled = true },
+	{ .func = TG_SETUP_VERTICAL_INTERRUPT2,
+	  .meta.skip_if.hubp_dpp_already_enabled = true },
+	{ .func = OPTC_SET_ODM_BYPASS,
+	  .meta.skip_if.hubp_dpp_already_enabled = true },
+	{ .func = OPP_PIPE_CLOCK_CONTROL,
+	  .meta.skip_if.hubp_dpp_already_enabled = true },
+	{ .func = OPP_PROGRAM_LEFT_EDGE_EXTRA_PIXEL,
+	  .meta.skip_if.hubp_dpp_already_enabled = true },
 };
 
 /* enable_plane, then the watermark propagate and the DET segments. */
 static const struct dcn401_commit_step bls_update_head_new_enable_plane[] = {
-	{ .func = DC_IP_REQUEST_CNTL, .meta.dc_ip_request_cntl.enable = true },
-	{ .func = HUBP_PG_CONTROL, .meta.hubp_pg_control.power_on = true },
-	{ .func = DC_IP_REQUEST_CNTL, .meta.dc_ip_request_cntl.enable = false },
-	{ .func = HUBP_CLK_CNTL, .meta.hubp_clk_cntl.enable = true },
-	{ .func = HUBP_INIT },
-	{ .func = OPP_PIPE_CLOCK_CONTROL },
-	{ .func = HUBBUB_FORCE_WM_PROPAGATE_TO_PIPES },
+	{ .func = DC_IP_REQUEST_CNTL, .meta.dc_ip_request_cntl.enable = true,
+	  .meta.skip_if.hubp_dpp_already_enabled = true },
+	{ .func = HUBP_PG_CONTROL, .meta.hubp_pg_control.power_on = true,
+	  .meta.skip_if.hubp_dpp_already_enabled = true },
+	{ .func = DC_IP_REQUEST_CNTL, .meta.dc_ip_request_cntl.enable = false,
+	  .meta.skip_if.hubp_dpp_already_enabled = true },
+	{ .func = HUBP_CLK_CNTL, .meta.hubp_clk_cntl.enable = true,
+	  .meta.skip_if.hubp_dpp_already_enabled = true },
+	{ .func = HUBP_INIT,
+	  .meta.skip_if.hubp_dpp_already_enabled = true },
+	{ .func = OPP_PIPE_CLOCK_CONTROL,
+	  .meta.skip_if.hubp_dpp_already_enabled = true },
+	{ .func = HUBBUB_FORCE_WM_PROPAGATE_TO_PIPES,
+	  .meta.skip_if.hubp_dpp_already_enabled = true },
 	{ .func = HUBP_PROGRAM_DET_SEGMENTS,
-	  .meta.hubp_program_det_segments.allocate = true },
-};
-
-/* update_dchubp_dpp, with the MPC insert from dcn401_update_mpcc. */
-static const struct dcn401_commit_step
-		bls_update_head_new_update_dchubp_dpp[] = {
-	{ .func = DPP_DPPCLK_CONTROL, .meta.dpp_dppclk_control.enable = true },
-	{ .func = DCCG_UPDATE_DPP_DTO },
-	{ .func = HUBP_VTG_SEL },
-	{ .func = HUBP_SETUP2 },
-	{ .func = HUBP_SET_UNBOUNDED_REQUESTING },
-	{ .func = HUBP_SETUP_INTERDEPENDENT2 },
-	{ .func = DPP_SETUP_DPP },
-	{ .func = DPP_SET_CURSOR_MATRIX },
-	{ .func = DPP_PROGRAM_BIAS_AND_SCALE },
-	/* insert_plane programs the blending; no update_blending follows. */
-	{ .func = MPC_INSERT_PLANE },
-	{ .func = MPC_UPDATE_VISUAL_CONFIRM },
-	{ .func = DPP_SET_SCALER },
-	{ .func = HUBP_MEM_PROGRAM_VIEWPORT },
-	{ .func = HUBP_PROGRAM_MCACHE_ID },
-	{ .func = MPC_SET_GAMUT_REMAP_BYPASS,
-	  .meta.mpc_set_gamut_remap_bypass.block_id =
-			MPCC_MCM_FIRST_GAMUT_REMAP },
-	{ .func = MPC_SET_GAMUT_REMAP_BYPASS,
-	  .meta.mpc_set_gamut_remap_bypass.block_id =
-			MPCC_MCM_SECOND_GAMUT_REMAP },
-	{ .func = MPC_SET_GAMUT_REMAP_BYPASS,
-	  .meta.mpc_set_gamut_remap_bypass.block_id = MPCC_OGAM_GAMUT_REMAP },
-	{ .func = MPC_POWER_ON_MPC_MEM_PWR },
-	{ .func = MPC_SET_OCSC_DEFAULT },
-	{ .func = HUBP_PROGRAM_SURFACE_CONFIG },
-	{ .func = HUBP_UPDATE_PLANE_ADDR },
-	{ .func = HUBP_SET_BLANK, .meta.hubp_set_blank.unblank = true },
+	  .meta.hubp_program_det_segments.allocate = true,
+	  .meta.skip_if.hubp_dpp_already_enabled = true },
 };
 
 /*
- * update_dchubp_dpp for a kept plane: surface and address only. No
- * enable_plane, no scaler, no viewport. DC1 remove+insert when the OPP
- * tree already holds the MPCC.
+ * update_dchubp_dpp. First enable runs the whole table. A reconfigure
+ * skips the steps that only bring the HUBP/DPP up, and removes the MPCC
+ * when the OPP tree already holds one.
  */
 static const struct dcn401_commit_step
-		bls_update_head_kept_update_dchubp_dpp[] = {
+		bls_update_head_new_update_dchubp_dpp[] = {
+	{ .func = DPP_DPPCLK_CONTROL, .meta.dpp_dppclk_control.enable = true,
+	  .meta.skip_if.hubp_dpp_already_enabled = true },
+	{ .func = DCCG_UPDATE_DPP_DTO,
+	  .meta.skip_if.hubp_dpp_already_enabled = true },
+	{ .func = HUBP_VTG_SEL,
+	  .meta.skip_if.hubp_dpp_already_enabled = true },
+	{ .func = HUBP_SETUP2,
+	  .meta.skip_if.hubp_dpp_already_enabled = true },
+	{ .func = HUBP_SET_UNBOUNDED_REQUESTING,
+	  .meta.skip_if.hubp_dpp_already_enabled = true },
+	{ .func = HUBP_SETUP_INTERDEPENDENT2,
+	  .meta.skip_if.hubp_dpp_already_enabled = true },
 	{ .func = DPP_SETUP_DPP },
 	{ .func = DPP_SET_CURSOR_MATRIX },
 	{ .func = DPP_PROGRAM_BIAS_AND_SCALE },
 	{ .func = MPC_REMOVE_MPCC,
 	  .meta.skip_if.opp_tree_empty = true },
+	/* insert_plane programs the blending; no update_blending follows. */
 	{ .func = MPC_INSERT_PLANE },
 	{ .func = MPC_UPDATE_VISUAL_CONFIRM },
+	{ .func = DPP_SET_SCALER,
+	  .meta.skip_if.hubp_dpp_already_enabled = true },
+	{ .func = HUBP_MEM_PROGRAM_VIEWPORT,
+	  .meta.skip_if.hubp_dpp_already_enabled = true },
 	{ .func = HUBP_PROGRAM_MCACHE_ID },
 	{ .func = MPC_SET_GAMUT_REMAP_BYPASS,
 	  .meta.mpc_set_gamut_remap_bypass.block_id =
@@ -1416,29 +1389,43 @@ static const struct dcn401_commit_step
 	{ .func = MPC_SET_OCSC_DEFAULT },
 	{ .func = HUBP_PROGRAM_SURFACE_CONFIG },
 	{ .func = HUBP_UPDATE_PLANE_ADDR },
+	{ .func = HUBP_SET_BLANK, .meta.hubp_set_blank.unblank = true,
+	  .meta.skip_if.hubp_dpp_already_enabled = true },
 };
 
 /*
  * set_hdr_multiplier, the input and MCM transfer functions, the output
- * transfer function and the OPP format.
+ * transfer function and the OPP format. First enable only.
  */
 static const struct dcn401_commit_step
 		bls_update_head_new_transfer_funcs[] = {
-	{ .func = DPP_SET_HDR_MULTIPLIER },
-	{ .func = DPP_SET_PRE_DEGAM },
-	{ .func = DPP_PROGRAM_GAMCOR_LUT },
-	{ .func = MPC_SET_MOVABLE_CM_LOCATION },
+	{ .func = DPP_SET_HDR_MULTIPLIER,
+	  .meta.skip_if.hubp_dpp_already_enabled = true },
+	{ .func = DPP_SET_PRE_DEGAM,
+	  .meta.skip_if.hubp_dpp_already_enabled = true },
+	{ .func = DPP_PROGRAM_GAMCOR_LUT,
+	  .meta.skip_if.hubp_dpp_already_enabled = true },
+	{ .func = MPC_SET_MOVABLE_CM_LOCATION,
+	  .meta.skip_if.hubp_dpp_already_enabled = true },
 	{ .func = MPC_PROGRAM_LUT_MODE,
-	  .meta.mpc_program_lut_mode.id = MCM_LUT_1DLUT },
+	  .meta.mpc_program_lut_mode.id = MCM_LUT_1DLUT,
+	  .meta.skip_if.hubp_dpp_already_enabled = true },
 	{ .func = MPC_PROGRAM_LUT_MODE,
-	  .meta.mpc_program_lut_mode.id = MCM_LUT_SHAPER },
+	  .meta.mpc_program_lut_mode.id = MCM_LUT_SHAPER,
+	  .meta.skip_if.hubp_dpp_already_enabled = true },
 	{ .func = MPC_PROGRAM_LUT_MODE,
-	  .meta.mpc_program_lut_mode.id = MCM_LUT_3DLUT },
-	{ .func = HUBP_PROGRAM_3DLUT_FL_CONFIG },
-	{ .func = HUBP_SET_3DLUT_FL },
-	{ .func = MPC_SET_OUTPUT_GAMMA },
-	{ .func = OPP_SET_DYN_EXPANSION },
-	{ .func = OPP_PROGRAM_FMT },
+	  .meta.mpc_program_lut_mode.id = MCM_LUT_3DLUT,
+	  .meta.skip_if.hubp_dpp_already_enabled = true },
+	{ .func = HUBP_PROGRAM_3DLUT_FL_CONFIG,
+	  .meta.skip_if.hubp_dpp_already_enabled = true },
+	{ .func = HUBP_SET_3DLUT_FL,
+	  .meta.skip_if.hubp_dpp_already_enabled = true },
+	{ .func = MPC_SET_OUTPUT_GAMMA,
+	  .meta.skip_if.hubp_dpp_already_enabled = true },
+	{ .func = OPP_SET_DYN_EXPANSION,
+	  .meta.skip_if.hubp_dpp_already_enabled = true },
+	{ .func = OPP_PROGRAM_FMT,
+	  .meta.skip_if.hubp_dpp_already_enabled = true },
 };
 
 /*
@@ -1470,18 +1457,7 @@ static_assert(
 		ARRAY_SIZE(bls_update_head_new_update_dchubp_dpp) +
 		ARRAY_SIZE(bls_update_head_new_transfer_funcs) +
 		ARRAY_SIZE(bls_update_head_new_unlock) <= DC2_BLS_MAX_STEPS,
-		"dcn401 seamless plane-add head exceeds DC2_BLS_MAX_STEPS");
-static_assert(
-		ARRAY_SIZE(
-		bls_update_head_per_stream_per_otg_master_pipe_preamble) +
-		ARRAY_SIZE(bls_update_head_global_preamble) +
-		ARRAY_SIZE(bls_head_per_state_new) +
-		ARRAY_SIZE(
-		bls_update_head_per_stream_per_otg_master_pipe_current_pending) +
-		ARRAY_SIZE(bls_update_head_new_lock) +
-		ARRAY_SIZE(bls_update_head_kept_update_dchubp_dpp) +
-		ARRAY_SIZE(bls_update_head_new_unlock) <= DC2_BLS_MAX_STEPS,
-		"dcn401 seamless kept-plane head exceeds DC2_BLS_MAX_STEPS");
+		"dcn401 seamless update head exceeds DC2_BLS_MAX_STEPS");
 
 /* pipe is NULL only for the bandwidth and p-state steps. */
 struct dcn401_commit_step_args {
@@ -2309,6 +2285,10 @@ static bool dcn401_skip_step(const struct dcn401_commit_step_args *args,
 			(!args->pipe->stream_res.opp ||
 			!args->pipe->stream_res.opp->mpc_tree_params.opp_list))
 		return true;
+	if (step->meta.skip_if.hubp_dpp_already_enabled &&
+			args->current_state->stream_count &&
+			args->current_state->stream_status[0].plane_count)
+		return true;
 	return false;
 }
 
@@ -2325,7 +2305,7 @@ static void dcn401_add_steps(struct block_sequence_state *sequence,
 }
 
 /* The support check found an OTG master for each stream of state. */
-static void dcn401_add_steps_per_stream_per_otg_master_pipe(
+static void dcn401_add_per_otg_master(
 		struct block_sequence_state *sequence,
 		const struct dcn401_commit_step_args *state_args,
 		struct dc_state *state,
@@ -2343,9 +2323,9 @@ static void dcn401_add_steps_per_stream_per_otg_master_pipe(
 
 #define DCN401_ADD_STEPS(sequence, args, steps) \
 	dcn401_add_steps(sequence, args, steps, ARRAY_SIZE(steps))
-#define DCN401_ADD_STEPS_PER_STREAM(sequence, args, state, steps) \
-	dcn401_add_steps_per_stream_per_otg_master_pipe(sequence, args, \
-			state, steps, ARRAY_SIZE(steps))
+#define DCN401_ADD_PER_OTG_MASTER(sequence, args, state, steps) \
+	dcn401_add_per_otg_master(sequence, args, state, steps, \
+			ARRAY_SIZE(steps))
 
 /*
  * Points the step arguments at the states and the sequence at
@@ -2384,12 +2364,12 @@ static enum bls_builder_result dcn401_build_non_seamless_commit(
 
 	dcn401_init_and_unpack_params(params, &state_args, &head);
 	DCN401_ADD_STEPS(&head, &state_args, bls_head_per_state_new);
-	DCN401_ADD_STEPS_PER_STREAM(&head, &state_args,
+	DCN401_ADD_PER_OTG_MASTER(&head, &state_args,
 			state_args.current_state,
 			bls_head_per_stream_per_otg_master_pipe_current);
-	DCN401_ADD_STEPS_PER_STREAM(&head, &state_args, state_args.new_state,
+	DCN401_ADD_PER_OTG_MASTER(&head, &state_args, state_args.new_state,
 			bls_head_per_stream_per_otg_master_pipe_new);
-	DCN401_ADD_STEPS_PER_STREAM(&head, &state_args, state_args.new_state,
+	DCN401_ADD_PER_OTG_MASTER(&head, &state_args, state_args.new_state,
 			bls_head_per_stream_per_otg_master_pipe_new_front_end);
 	DCN401_ADD_STEPS(&head, &state_args, bls_head_per_state_new_postamble);
 
@@ -2402,7 +2382,6 @@ static enum bls_builder_result dcn401_build_seamless_update(
 	struct dcn401_commit_step_args state_args;
 	struct block_sequence_state head;
 	enum bls_builder_result result;
-	bool plane_add;
 
 	if (!params)
 		return BLS_BUILD_ERROR_UNSUPPORTED_STATE_UPDATE;
@@ -2411,41 +2390,32 @@ static enum bls_builder_result dcn401_build_seamless_update(
 	if (result != BLS_BUILD_SUCCESS)
 		return result;
 
-	plane_add = dcn401_is_plane_add(params->current_state,
-			params->new_state);
 	dcn401_init_and_unpack_params(params, &state_args, &head);
-	DCN401_ADD_STEPS_PER_STREAM(&head, &state_args,
+	DCN401_ADD_PER_OTG_MASTER(&head, &state_args,
 			state_args.current_state,
 			bls_update_head_per_stream_per_otg_master_pipe_preamble);
 	DCN401_ADD_STEPS(&head, &state_args,
 			bls_update_head_global_preamble);
 	DCN401_ADD_STEPS(&head, &state_args, bls_head_per_state_new);
-	DCN401_ADD_STEPS_PER_STREAM(&head, &state_args,
+	DCN401_ADD_PER_OTG_MASTER(&head, &state_args,
 			state_args.current_state,
 			bls_update_head_per_stream_per_otg_master_pipe_current_pending);
 
-	/* One stream, so adding each table per stream keeps the DC1 order. */
-	DCN401_ADD_STEPS_PER_STREAM(&head, &state_args, state_args.new_state,
+	/*
+	 * One stream. skip_if drops first-enable steps when the HUBP/DPP
+	 * is already on, so a kept-plane surface update is the same table.
+	 */
+	DCN401_ADD_PER_OTG_MASTER(&head, &state_args, state_args.new_state,
 			bls_update_head_new_lock);
-	if (plane_add) {
-		DCN401_ADD_STEPS_PER_STREAM(&head, &state_args,
-				state_args.new_state,
-				bls_update_head_new_stream);
-		DCN401_ADD_STEPS_PER_STREAM(&head, &state_args,
-				state_args.new_state,
-				bls_update_head_new_enable_plane);
-		DCN401_ADD_STEPS_PER_STREAM(&head, &state_args,
-				state_args.new_state,
-				bls_update_head_new_update_dchubp_dpp);
-		DCN401_ADD_STEPS_PER_STREAM(&head, &state_args,
-				state_args.new_state,
-				bls_update_head_new_transfer_funcs);
-	} else {
-		DCN401_ADD_STEPS_PER_STREAM(&head, &state_args,
-				state_args.new_state,
-				bls_update_head_kept_update_dchubp_dpp);
-	}
-	DCN401_ADD_STEPS_PER_STREAM(&head, &state_args, state_args.new_state,
+	DCN401_ADD_PER_OTG_MASTER(&head, &state_args, state_args.new_state,
+			bls_update_head_new_stream);
+	DCN401_ADD_PER_OTG_MASTER(&head, &state_args, state_args.new_state,
+			bls_update_head_new_enable_plane);
+	DCN401_ADD_PER_OTG_MASTER(&head, &state_args, state_args.new_state,
+			bls_update_head_new_update_dchubp_dpp);
+	DCN401_ADD_PER_OTG_MASTER(&head, &state_args, state_args.new_state,
+			bls_update_head_new_transfer_funcs);
+	DCN401_ADD_PER_OTG_MASTER(&head, &state_args, state_args.new_state,
 			bls_update_head_new_unlock);
 
 	return BLS_BUILD_SUCCESS;
-- 
2.43.0

