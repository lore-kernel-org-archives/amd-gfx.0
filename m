Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C407C43334
	for <amd-gfx@archiver.kernel.org>; Fri,  3 Jun 2022 20:12:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AFDFA1123D3;
	Fri,  3 Jun 2022 20:12:31 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2044.outbound.protection.outlook.com [40.107.237.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 708791123D3
 for <amd-gfx@lists.freedesktop.org>; Fri,  3 Jun 2022 20:12:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C3/yRLwiFaoUuHybIfjLYJuB1CF69Jt3Zv+yMSIqMNCRNw3Xn1aI7bzXN9cJiIrgkQiaqwYLUz8QkrsRZbNqrHu8FM9WyCl6eBRCjVzOfBFPffheH1TrqTnYGTen8XR3KzRtlbadtEpdc996UwLu4BjSwshjuVT3f06pP36Szn+b1PRvh2LC0+QFXt5iv1uA4EIRdO62C3jv/T72bAFbB3w/UbryDl3e+oYSDFVWKzBSk+OfTYgqCrMw+qMuGJrhgOVMleSr+CUcOEc0Qw/bagmyoHPWz9jtsWoIQBeg68PjA5v4KcJVvYQQZZ4muYuP0lJV8v32bwdqXyqH0aLaDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VK7sbzE5hhrmhmbtxUz5ozGhRXJkXnwTYBjgvosVdTY=;
 b=BoK4I6LsZzSyuSpsQMCjWVOXW3PlixudhU3ZCj0M1xKCCq8yWGOa4KsdEocKwRDeYDAGOwWrIS+w+whUJKaGeL9FPiOSpeSRDecxpmuhCHn56OwEPdDOGdDrdhqjEt9CfQnjEaYQoJJGUS/ylzk7VbenNvU+L+4iajvPc8HHDqmC9NJUTesMtw8kFiG+xXqxzOwzKR9mvnpts8YVFIr7MOOJDL5agKJjpXQChu9uf0Z9htNSsBR2WCpQgOlaEwnRLe/wiivrLkN5mj5EmuY4GW7SfrBKoANXtnZRo7Nn5AbLTU4qcIfLhoM+EqI+3cW+Wol4SsSjymmfao7G/Sxj/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VK7sbzE5hhrmhmbtxUz5ozGhRXJkXnwTYBjgvosVdTY=;
 b=GGRMEivYAyAyV+WZDjDkPRN8zw+YmMzrH0ts15o7Y5ryc6TDT0vP0iAhISUZBXZoFZtYcNBjXV5p7Zx0SRQXZlW+W27GR9JfUCg1eTOYv642rJLTG7p5BPUbT1DXntClgBHPrG1S5TGcMUC2FZtUCQSHImj2ofhHeZRyxinPjLE=
Received: from DM5PR06CA0077.namprd06.prod.outlook.com (2603:10b6:3:4::15) by
 CO6PR12MB5475.namprd12.prod.outlook.com (2603:10b6:5:354::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5314.12; Fri, 3 Jun 2022 20:12:28 +0000
Received: from DM6NAM11FT055.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:4:cafe::e) by DM5PR06CA0077.outlook.office365.com
 (2603:10b6:3:4::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.12 via Frontend
 Transport; Fri, 3 Jun 2022 20:12:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT055.mail.protection.outlook.com (10.13.173.103) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5314.12 via Frontend Transport; Fri, 3 Jun 2022 20:12:27 +0000
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Fri, 3 Jun
 2022 15:12:26 -0500
From: Hamza Mahfooz <hamza.mahfooz@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 01/16] drm/amd/display: Update optimized blank calc and
 programming
Date: Fri, 3 Jun 2022 16:11:32 -0400
Message-ID: <20220603201147.121817-2-hamza.mahfooz@amd.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220603201147.121817-1-hamza.mahfooz@amd.com>
References: <20220603201147.121817-1-hamza.mahfooz@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fe0176de-8bfb-4d7b-192d-08da459d61db
X-MS-TrafficTypeDiagnostic: CO6PR12MB5475:EE_
X-Microsoft-Antispam-PRVS: <CO6PR12MB5475DEF2B9853ACBA00BAA90F4A19@CO6PR12MB5475.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DLL/5It2MGhVpVvcL57JdgvcueyOVuuI0DLt6fsUHWnGCrmQ5EXi1v00E1iSbS9cKlK1Dbq4R4PSxrVEC1qDLXJsjfNrduOGldRpyCeeFqC6s2NG3teL6KWL60RGS1ViAyGdX5Ngk02fs+8csKsQXJimUFJb4WGiUcefiaEosaqRuFE/b/K8QV5ejbZW2wXzIMlwIOtCwG1VMfiyRkk1GmZQBTz3OetnruEyNbCEQlL44TV1QUp2bHB7N26wv73Ro+6ZXzca0tdFCcCmoAiWERj73BCw3R68FaGsv2McnoOunc9elj2p8Lnr9cIYhVFKauEL5Cp7PbnyWFC/iC23nDY5fMmFClfPq8HFXcGXvRdz9XL9HeQ3JeFHM346OkSzCabbKdBfSDJJnIQAz3Qi+SkX+yaGJiMptUMmNT5hGDIacMB8S/sxU1DaraHIEJK0VxVWQq/B+DhntjLq0se+E+RfhufBl9M5sMH/k6k/BiU03C+O8R3wSpn/+6l2t/HjT/lB2/QpV0eCwrj+JoHLtFsHvWZxEiJ0uGbpZAZ5+n25f5W0467v/nIPxmc0gLnOI99DLbZIgkvyGi0xtTLE2pbYdkfbh6UTp/AmkBFOjVBb251FjfKh0qcXNWSRX79sD/px72BVeo1aOnYI5tI1w1DvNFD+mSFwCuMhVjXT4CO47zsIwo9vi80ipT6Z2eJl02q7KSIoPi88/AT0XQB6Pg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(36840700001)(40470700004)(46966006)(16526019)(36860700001)(54906003)(83380400001)(6666004)(5660300002)(36756003)(316002)(1076003)(44832011)(82310400005)(70586007)(70206006)(47076005)(2616005)(26005)(426003)(186003)(336012)(4326008)(40460700003)(8676002)(81166007)(356005)(2906002)(508600001)(6916009)(86362001)(8936002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2022 20:12:27.9183 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fe0176de-8bfb-4d7b-192d-08da459d61db
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT055.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR12MB5475
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
 Gabe Teeger <gabe.teeger@amd.com>, solomon.chiu@amd.com, jerry.zuo@amd.com,
 Aurabindo.Pillai@amd.com, hamza.mahfooz@amd.com, wayne.lin@amd.com,
 Bhawanpreet.Lakha@amd.com, Nicholas
 Kazlauskas <Nicholas.Kazlauskas@amd.com>, agustin.gutierrez@amd.com,
 pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Gabe Teeger <gabe.teeger@amd.com>

[Why]
The existing calculations in DCN3.1 were placeholder and need to be
replaced with HW team approved calculations.

[How]
The new calculations add new parameters to the bounding box and pipe
params - VblankNom and the bounding box default.

The placeholder calculations are dropped from DCN3.1 in the meantime
while we work out hardware approved replacements.
Also fix a bug where we wipe out other register contents with a REG_SET
instead of a REG_UPDATE for the register we were programming the
min_dst_y_next_start_optimized.

Reviewed-by: Nicholas Kazlauskas <Nicholas.Kazlauskas@amd.com>
Acked-by: Hamza Mahfooz <hamza.mahfooz@amd.com>
Signed-off-by: Gabe Teeger <gabe.teeger@amd.com>
---
 .../gpu/drm/amd/display/dc/dcn31/dcn31_hubp.c    |  2 +-
 .../drm/amd/display/dc/dcn31/dcn31_resource.c    |  1 -
 .../dc/dml/dcn31/display_rq_dlg_calc_31.c        | 16 ++--------------
 .../amd/display/dc/dml/display_mode_structs.h    |  1 +
 .../drm/amd/display/dc/dml/display_mode_vba.h    |  1 +
 5 files changed, 5 insertions(+), 16 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_hubp.c b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_hubp.c
index 197a5cae068b..84e1486f3d51 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_hubp.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_hubp.c
@@ -59,7 +59,7 @@ static void hubp31_program_extended_blank(struct hubp *hubp,
 {
 	struct dcn20_hubp *hubp2 = TO_DCN20_HUBP(hubp);
 
-	REG_SET(BLANK_OFFSET_1, 0, MIN_DST_Y_NEXT_START, min_dst_y_next_start_optimized);
+	REG_UPDATE(BLANK_OFFSET_1, MIN_DST_Y_NEXT_START, min_dst_y_next_start_optimized);
 }
 
 static struct hubp_funcs dcn31_hubp_funcs = {
diff --git a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_resource.c b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_resource.c
index 3d9f07d4770b..a67475251188 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_resource.c
@@ -1651,7 +1651,6 @@ int dcn31_populate_dml_pipes_from_context(
 			continue;
 		pipe = &res_ctx->pipe_ctx[i];
 		timing = &pipe->stream->timing;
-
 		if (pipe->plane_state &&
 				(pipe->plane_state->src_rect.height < pipe->plane_state->dst_rect.height ||
 				pipe->plane_state->src_rect.width < pipe->plane_state->dst_rect.width))
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn31/display_rq_dlg_calc_31.c b/drivers/gpu/drm/amd/display/dc/dml/dcn31/display_rq_dlg_calc_31.c
index 53d760e169e6..dd570689c095 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn31/display_rq_dlg_calc_31.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn31/display_rq_dlg_calc_31.c
@@ -1055,7 +1055,6 @@ static void dml_rq_dlg_get_dlg_params(
 
 	float vba__refcyc_per_req_delivery_pre_l = get_refcyc_per_req_delivery_pre_l_in_us(mode_lib, e2e_pipe_param, num_pipes, pipe_idx) * refclk_freq_in_mhz;  // From VBA
 	float vba__refcyc_per_req_delivery_l = get_refcyc_per_req_delivery_l_in_us(mode_lib, e2e_pipe_param, num_pipes, pipe_idx) * refclk_freq_in_mhz;  // From VBA
-	int blank_lines;
 
 	memset(disp_dlg_regs, 0, sizeof(*disp_dlg_regs));
 	memset(disp_ttu_regs, 0, sizeof(*disp_ttu_regs));
@@ -1079,20 +1078,9 @@ static void dml_rq_dlg_get_dlg_params(
 	min_ttu_vblank = get_min_ttu_vblank_in_us(mode_lib, e2e_pipe_param, num_pipes, pipe_idx);	// From VBA
 
 	dlg_vblank_start = interlaced ? (vblank_start / 2) : vblank_start;
-
 	disp_dlg_regs->min_dst_y_next_start = (unsigned int) (((double) dlg_vblank_start) * dml_pow(2, 2));
-	blank_lines = (dst->vblank_end + dst->vtotal_min - dst->vblank_start - dst->vstartup_start - 1);
-	if (blank_lines < 0)
-		blank_lines = 0;
-	if (blank_lines != 0) {
-		disp_dlg_regs->optimized_min_dst_y_next_start_us =
-			((unsigned int) blank_lines * dst->hactive) / (unsigned int) dst->pixel_rate_mhz;
-		disp_dlg_regs->optimized_min_dst_y_next_start =
-			(unsigned int)(((double) (dlg_vblank_start + blank_lines)) * dml_pow(2, 2));
-	} else {
-		// use unoptimized value
-		disp_dlg_regs->optimized_min_dst_y_next_start = disp_dlg_regs->min_dst_y_next_start;
-	}
+	disp_dlg_regs->optimized_min_dst_y_next_start_us = 0;
+	disp_dlg_regs->optimized_min_dst_y_next_start = disp_dlg_regs->min_dst_y_next_start;
 	ASSERT(disp_dlg_regs->min_dst_y_next_start < (unsigned int)dml_pow(2, 18));
 
 	dml_print("DML_DLG: %s: min_ttu_vblank (us)         = %3.2f\n", __func__, min_ttu_vblank);
diff --git a/drivers/gpu/drm/amd/display/dc/dml/display_mode_structs.h b/drivers/gpu/drm/amd/display/dc/dml/display_mode_structs.h
index 2df660cd8801..94df32dcc139 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/display_mode_structs.h
+++ b/drivers/gpu/drm/amd/display/dc/dml/display_mode_structs.h
@@ -224,6 +224,7 @@ struct _vcs_dpi_ip_params_st {
 	unsigned int can_vstartup_lines_exceed_vsync_plus_back_porch_lines_minus_one;
 	unsigned int bug_forcing_LC_req_same_size_fixed;
 	unsigned int number_of_cursors;
+	unsigned int VBlankNomDefaultUS;
 };
 
 struct _vcs_dpi_display_xfc_params_st {
diff --git a/drivers/gpu/drm/amd/display/dc/dml/display_mode_vba.h b/drivers/gpu/drm/amd/display/dc/dml/display_mode_vba.h
index 0603b32971a6..a590ac391653 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/display_mode_vba.h
+++ b/drivers/gpu/drm/amd/display/dc/dml/display_mode_vba.h
@@ -355,6 +355,7 @@ struct vba_vars_st {
 	unsigned int CursorBPP[DC__NUM_DPP__MAX][DC__NUM_CURSOR__MAX];
 	bool XFCEnabled[DC__NUM_DPP__MAX];
 	bool ScalerEnabled[DC__NUM_DPP__MAX];
+	unsigned int VBlankNom[DC__NUM_DPP__MAX];
 
 	// Intermediates/Informational
 	bool ImmediateFlipSupport;
-- 
2.36.1

