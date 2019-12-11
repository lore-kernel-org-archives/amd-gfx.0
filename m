Return-Path: <SRS0=BheJ=2B=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5EB7C00454
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Dec 2019 15:33:32 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6E5AC2077B
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Dec 2019 15:33:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="N9kyEHid"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E5AC2077B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E5F2E6EB81;
	Wed, 11 Dec 2019 15:33:30 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2058.outbound.protection.outlook.com [40.107.92.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A48ED6EB7E
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 Dec 2019 15:33:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WK+q2Qw1baw92ofcGR+Pe3l3VMZo44gTwb9ZYBZR/EJxsHyyviJPKPcM2xjTHM5pHF52sU2hdGnjhrXi33MB9llm4xnFwxHlIvb2hquNIrMCF0KdwDwRldQspP/1Kbu8/NmA5SLuCnYO/W89amJ8ZyCEBja7YNBPHtl5fhRDtZFZHQhHAXRzgEgL3Vw9U8zlv9FAMX83oG3GMmy+CBLLMo2T/t0WcAs5ECALzrHx02DhrqQL0MMYmK8HilO0aHosS9m7qdeMrbGnwVYmtbBc93IJEsdkbnFoAPG617clZBST24rU7vuvJc27ilPbVk3faSm709AgmnS5YF8RWa5Z2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ifBo/90XqLQ3XXSCg75Tzp2RM/LJhVWyZD2FaKLSuPI=;
 b=KQpkWUBv1rC9lDz4fapD2M+lzqUD7nLvpMVSB2pADZ5oOabHTUWk4kxfU2/k6R1FcpINFrNHq7FNJlAVyXTAUOrMOrDOsJZ8Y6ITR0aGN0Qdh/l2Y4Xd19OY0D82Ks0N+0imQGw7CkClQl461spBzAiGP+EmZ/LCl97rUENFo0pk6T/O/ehAQwiHAE85LYN8ETT09/KeiqEopMqcWwe/Uqpreh9apWNTij5QWUhBETa6E3G/6qQTKHIuGImBVg/vOcur4lu/bGDruqJNhW95Ym2L2j/htIIEmuWdcYMc+doaEaOBtQEcRP9oV2GaJ/lSGcaaLvXULK35nUtnRCtcCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ifBo/90XqLQ3XXSCg75Tzp2RM/LJhVWyZD2FaKLSuPI=;
 b=N9kyEHidhJkRQEE5rBky2BMRL2Gh7gCZO2IdOcnFxEIF/4VbmzYPNPB/uWwwz8g08a24XB4prlnfacEptZ0LOI9pH32U9843vLGokXMTr/niXx1ckC/4pXoB1NG8ypOlMxP8mYjKeKowksw9Dl5CtXPbty90+GszRJdOhfQt218=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Rodrigo.Siqueira@amd.com; 
Received: from MW2PR12MB2524.namprd12.prod.outlook.com (52.132.180.155) by
 MW2PR12MB2426.namprd12.prod.outlook.com (52.132.184.27) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2538.15; Wed, 11 Dec 2019 15:33:27 +0000
Received: from MW2PR12MB2524.namprd12.prod.outlook.com
 ([fe80::3d1f:4c20:e980:6e69]) by MW2PR12MB2524.namprd12.prod.outlook.com
 ([fe80::3d1f:4c20:e980:6e69%5]) with mapi id 15.20.2516.018; Wed, 11 Dec 2019
 15:33:27 +0000
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 12/39] drm/amd/display: update chroma viewport wa
Date: Wed, 11 Dec 2019 10:32:26 -0500
Message-Id: <20191211153253.2291112-13-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191211153253.2291112-1-Rodrigo.Siqueira@amd.com>
References: <20191211153253.2291112-1-Rodrigo.Siqueira@amd.com>
X-ClientProxiedBy: YT1PR01CA0007.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01::20)
 To MW2PR12MB2524.namprd12.prod.outlook.com
 (2603:10b6:907:9::27)
MIME-Version: 1.0
X-Mailer: git-send-email 2.24.0
X-Originating-IP: [165.204.55.250]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 250b0c72-bb36-45fd-cc25-08d77e4f77bc
X-MS-TrafficTypeDiagnostic: MW2PR12MB2426:|MW2PR12MB2426:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MW2PR12MB24266335BD57F841F064E07D985A0@MW2PR12MB2426.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-Forefront-PRVS: 024847EE92
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(376002)(136003)(346002)(396003)(366004)(39860400002)(199004)(189003)(86362001)(6512007)(1076003)(478600001)(54906003)(4326008)(6486002)(66556008)(66476007)(66946007)(2616005)(316002)(2906002)(81156014)(8676002)(26005)(30864003)(36756003)(15650500001)(52116002)(8936002)(186003)(6916009)(81166006)(5660300002)(6506007);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MW2PR12MB2426;
 H:MW2PR12MB2524.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nivBpe+lu3ECghldaTY36wliALtGcOb9luwY06gDKq6YfuyuAdwUCvrHmtd8lXPhE4/D90A3V375r0S0lFUxGnq4ecACYlim8E3/PVQL6KMmdWAT4wC0qvxARMr5dchzZ+Z+rpWo+qtMx2i24Ve0AIBQIiz9ye+dKqvm/6xiymzCQCpGLdhrWSuixXJg69s8Va5cNIfHVLqR0vWY9CrIZ6vsj+M0k1hf4AOOjhAXWE6IIVu5Gi8YOyC5PbMIwAWJ82rAL+Q/hwOCyTCvix9HSJgADj0ygET/k7xl0PTp0e/VrYuWhgajY2BrpLarUpMCm8EigfR/BC8fDpiIgm4cjs0M8j9RsMstzZDvPvAawC9Ab46Q02OOIGdl7YIrbBMfxhld16+3d5UVzlpbfXfrPORl9ekMStEky4XBBnk3TONBONDK02Gi5BG9wC2fBK0B
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 250b0c72-bb36-45fd-cc25-08d77e4f77bc
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2019 15:33:27.4531 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sVlqU5v7iIX/K1/keIxq/quObsz9K57WAZdrV7teTZDOkdwdDDvG21XFGdkUi2TQHneCRDG1z6nMaEY7qARFUA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR12MB2426
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
Cc: Sunpeng.Li@amd.com, Bhawanpreet.Lakha@amd.com,
 Tony Cheng <Tony.Cheng@amd.com>, Harry.Wentland@amd.com,
 Eric Yang <Eric.Yang2@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Eric Yang <Eric.Yang2@amd.com>

[Why]
Need previously implemented chroma vp wa to work for rotation cases.

[How]
Implement rotation specific wa.

Signed-off-by: Eric Yang <Eric.Yang2@amd.com>
Reviewed-by: Tony Cheng <Tony.Cheng@amd.com>
Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 .../gpu/drm/amd/display/dc/dcn10/dcn10_hubp.c |   3 +-
 .../gpu/drm/amd/display/dc/dcn10/dcn10_hubp.h |   4 +-
 .../amd/display/dc/dcn10/dcn10_hw_sequencer.c |   3 +-
 .../drm/amd/display/dc/dcn20/dcn20_hwseq.c    |  14 +-
 .../gpu/drm/amd/display/dc/dcn21/dcn21_hubp.c | 314 ++++++++++++++++--
 .../gpu/drm/amd/display/dc/dcn21/dcn21_hubp.h |   1 +
 drivers/gpu/drm/amd/display/dc/inc/hw/hubp.h  |   7 +-
 7 files changed, 305 insertions(+), 41 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hubp.c b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hubp.c
index 4d1301e5eaf5..31b64733d693 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hubp.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hubp.c
@@ -810,8 +810,7 @@ static void hubp1_set_vm_context0_settings(struct hubp *hubp,
 void min_set_viewport(
 	struct hubp *hubp,
 	const struct rect *viewport,
-	const struct rect *viewport_c,
-	enum dc_rotation_angle rotation)
+	const struct rect *viewport_c)
 {
 	struct dcn10_hubp *hubp1 = TO_DCN10_HUBP(hubp);
 
diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hubp.h b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hubp.h
index e44eaae5033b..780af5b3c16f 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hubp.h
+++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hubp.h
@@ -749,9 +749,7 @@ void hubp1_set_blank(struct hubp *hubp, bool blank);
 
 void min_set_viewport(struct hubp *hubp,
 		const struct rect *viewport,
-		const struct rect *viewport_c,
-		enum dc_rotation_angle rotation);
-/* rotation angle added for use by hubp21_set_viewport */
+		const struct rect *viewport_c);
 
 void hubp1_clk_cntl(struct hubp *hubp, bool enable);
 void hubp1_vtg_sel(struct hubp *hubp, uint32_t otg_inst);
diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
index 3996fef56948..c9f7c0af58e3 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
@@ -2291,8 +2291,7 @@ static void dcn10_update_dchubp_dpp(
 		hubp->funcs->mem_program_viewport(
 			hubp,
 			&pipe_ctx->plane_res.scl_data.viewport,
-			&pipe_ctx->plane_res.scl_data.viewport_c,
-			plane_state->rotation);
+			&pipe_ctx->plane_res.scl_data.viewport_c);
 	}
 
 	if (pipe_ctx->stream->cursor_attributes.address.quad_part != 0) {
diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
index cafbd08f1cf2..8d779062a4e8 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
@@ -1305,6 +1305,7 @@ static void dcn20_update_dchubp_dpp(
 	struct hubp *hubp = pipe_ctx->plane_res.hubp;
 	struct dpp *dpp = pipe_ctx->plane_res.dpp;
 	struct dc_plane_state *plane_state = pipe_ctx->plane_state;
+	bool viewport_changed = false;
 
 	if (pipe_ctx->update_flags.bits.dppclk)
 		dpp->funcs->dpp_dppclk_control(dpp, false, true);
@@ -1383,12 +1384,14 @@ static void dcn20_update_dchubp_dpp(
 
 	if (pipe_ctx->update_flags.bits.viewport ||
 			(context == dc->current_state && plane_state->update_flags.bits.scaling_change) ||
-			(context == dc->current_state && pipe_ctx->stream->update_flags.bits.scaling))
+			(context == dc->current_state && pipe_ctx->stream->update_flags.bits.scaling)) {
+
 		hubp->funcs->mem_program_viewport(
 			hubp,
 			&pipe_ctx->plane_res.scl_data.viewport,
-			&pipe_ctx->plane_res.scl_data.viewport_c,
-			plane_state->rotation);
+			&pipe_ctx->plane_res.scl_data.viewport_c);
+		viewport_changed = true;
+	}
 
 	/* Any updates are handled in dc interface, just need to apply existing for plane enable */
 	if ((pipe_ctx->update_flags.bits.enable || pipe_ctx->update_flags.bits.opp_changed)
@@ -1441,9 +1444,14 @@ static void dcn20_update_dchubp_dpp(
 		hubp->power_gated = false;
 	}
 
+	if (hubp->funcs->apply_PLAT_54186_wa && viewport_changed)
+		hubp->funcs->apply_PLAT_54186_wa(hubp, &plane_state->address);
+
 	if (pipe_ctx->update_flags.bits.enable || plane_state->update_flags.bits.addr_update)
 		hws->funcs.update_plane_addr(dc, pipe_ctx);
 
+
+
 	if (pipe_ctx->update_flags.bits.enable)
 		hubp->funcs->set_blank(hubp, false);
 }
diff --git a/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_hubp.c b/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_hubp.c
index 332bf3d3a664..216ae170bc50 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_hubp.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_hubp.c
@@ -169,12 +169,9 @@ static void hubp21_setup(
 void hubp21_set_viewport(
 	struct hubp *hubp,
 	const struct rect *viewport,
-	const struct rect *viewport_c,
-	enum dc_rotation_angle rotation)
+	const struct rect *viewport_c)
 {
 	struct dcn21_hubp *hubp21 = TO_DCN21_HUBP(hubp);
-	int patched_viewport_height = 0;
-	struct dc_debug_options *debug = &hubp->ctx->dc->debug;
 
 	REG_SET_2(DCSURF_PRI_VIEWPORT_DIMENSION, 0,
 		  PRI_VIEWPORT_WIDTH, viewport->width,
@@ -193,31 +190,10 @@ void hubp21_set_viewport(
 		  SEC_VIEWPORT_X_START, viewport->x,
 		  SEC_VIEWPORT_Y_START, viewport->y);
 
-	/*
-	 *	Work around for underflow issue with NV12 + rIOMMU translation
-	 *	+ immediate flip. This will cause hubp underflow, but will not
-	 *	be user visible since underflow is in blank region
-	 *	Disable w/a when rotated 180 degrees, causes vertical chroma offset
-	 */
-	patched_viewport_height = viewport_c->height;
-	if (debug->nv12_iflip_vm_wa && viewport_c->height > 512 &&
-			rotation != ROTATION_ANGLE_180) {
-		int pte_row_height = 0;
-		int pte_rows = 0;
-
-		REG_GET(DCHUBP_REQ_SIZE_CONFIG_C,
-			PTE_ROW_HEIGHT_LINEAR_C, &pte_row_height);
-
-		pte_row_height = 1 << (pte_row_height + 3);
-		pte_rows = (viewport_c->height / pte_row_height) + 1;
-		patched_viewport_height = pte_rows * pte_row_height + 1;
-	}
-
-
 	/* DC supports NV12 only at the moment */
 	REG_SET_2(DCSURF_PRI_VIEWPORT_DIMENSION_C, 0,
 		  PRI_VIEWPORT_WIDTH_C, viewport_c->width,
-		  PRI_VIEWPORT_HEIGHT_C, patched_viewport_height);
+		  PRI_VIEWPORT_HEIGHT_C, viewport_c->height);
 
 	REG_SET_2(DCSURF_PRI_VIEWPORT_START_C, 0,
 		  PRI_VIEWPORT_X_START_C, viewport_c->x,
@@ -225,13 +201,113 @@ void hubp21_set_viewport(
 
 	REG_SET_2(DCSURF_SEC_VIEWPORT_DIMENSION_C, 0,
 		  SEC_VIEWPORT_WIDTH_C, viewport_c->width,
-		  SEC_VIEWPORT_HEIGHT_C, patched_viewport_height);
+		  SEC_VIEWPORT_HEIGHT_C, viewport_c->height);
 
 	REG_SET_2(DCSURF_SEC_VIEWPORT_START_C, 0,
 		  SEC_VIEWPORT_X_START_C, viewport_c->x,
 		  SEC_VIEWPORT_Y_START_C, viewport_c->y);
 }
 
+static void hubp21_apply_PLAT_54186_wa(
+		struct hubp *hubp,
+		const struct dc_plane_address *address)
+{
+	struct dcn21_hubp *hubp21 = TO_DCN21_HUBP(hubp);
+	struct dc_debug_options *debug = &hubp->ctx->dc->debug;
+	unsigned int chroma_bpe = 2;
+	unsigned int luma_addr_high_part = 0;
+	unsigned int row_height = 0;
+	unsigned int chroma_pitch = 0;
+	unsigned int viewport_c_height = 0;
+	unsigned int viewport_c_width = 0;
+	unsigned int patched_viewport_height = 0;
+	unsigned int patched_viewport_width = 0;
+	unsigned int rotation_angle = 0;
+	unsigned int pix_format = 0;
+	unsigned int h_mirror_en = 0;
+	unsigned int tile_blk_size = 64 * 1024; /* 64KB for 64KB SW, 4KB for 4KB SW */
+
+
+	if (!debug->nv12_iflip_vm_wa)
+		return;
+
+	REG_GET(DCHUBP_REQ_SIZE_CONFIG_C,
+		PTE_ROW_HEIGHT_LINEAR_C, &row_height);
+
+	REG_GET_2(DCSURF_PRI_VIEWPORT_DIMENSION_C,
+			PRI_VIEWPORT_WIDTH_C, &viewport_c_width,
+			PRI_VIEWPORT_HEIGHT_C, &viewport_c_height);
+
+	REG_GET(DCSURF_PRIMARY_SURFACE_ADDRESS_HIGH_C,
+			PRIMARY_SURFACE_ADDRESS_HIGH_C, &luma_addr_high_part);
+
+	REG_GET(DCSURF_SURFACE_PITCH_C,
+			PITCH_C, &chroma_pitch);
+
+	chroma_pitch += 1;
+
+	REG_GET_3(DCSURF_SURFACE_CONFIG,
+			SURFACE_PIXEL_FORMAT, &pix_format,
+			ROTATION_ANGLE, &rotation_angle,
+			H_MIRROR_EN, &h_mirror_en);
+
+	/* apply wa only for NV12 surface with scatter gather enabled with view port > 512 */
+	if (address->type != PLN_ADDR_TYPE_VIDEO_PROGRESSIVE ||
+			address->video_progressive.luma_addr.high_part == 0xf4
+			|| viewport_c_height <= 512)
+		return;
+
+	switch (rotation_angle) {
+	case 0: /* 0 degree rotation */
+		row_height = 128;
+		patched_viewport_height = (viewport_c_height / row_height + 1) * row_height + 1;
+		patched_viewport_width = viewport_c_width;
+		hubp21->PLAT_54186_wa_chroma_addr_offset = 0;
+		break;
+	case 2: /* 180 degree rotation */
+		row_height = 128;
+		patched_viewport_height = viewport_c_height + row_height;
+		patched_viewport_width = viewport_c_width;
+		hubp21->PLAT_54186_wa_chroma_addr_offset = 0 - chroma_pitch * row_height * chroma_bpe;
+		break;
+	case 1: /* 90 degree rotation */
+		row_height = 256;
+		if (h_mirror_en) {
+			patched_viewport_height = viewport_c_height;
+			patched_viewport_width = viewport_c_width + row_height;
+			hubp21->PLAT_54186_wa_chroma_addr_offset = 0;
+		} else {
+			patched_viewport_height = viewport_c_height;
+			patched_viewport_width = viewport_c_width + row_height;
+			hubp21->PLAT_54186_wa_chroma_addr_offset = 0 - tile_blk_size;
+		}
+		break;
+	case 3:	/* 270 degree rotation */
+		row_height = 256;
+		if (h_mirror_en) {
+			patched_viewport_height = viewport_c_height;
+			patched_viewport_width = viewport_c_width + row_height;
+			hubp21->PLAT_54186_wa_chroma_addr_offset = 0 - tile_blk_size;
+		} else {
+			patched_viewport_height = viewport_c_height;
+			patched_viewport_width = viewport_c_width + row_height;
+			hubp21->PLAT_54186_wa_chroma_addr_offset = 0;
+		}
+		break;
+	default:
+		ASSERT(0);
+		break;
+	}
+
+	/* catch cases where viewport keep growing */
+	ASSERT(patched_viewport_height && patched_viewport_height < 5000);
+	ASSERT(patched_viewport_width && patched_viewport_width < 5000);
+
+	REG_UPDATE_2(DCSURF_PRI_VIEWPORT_DIMENSION_C,
+			PRI_VIEWPORT_WIDTH_C, patched_viewport_width,
+			PRI_VIEWPORT_HEIGHT_C, patched_viewport_height);
+}
+
 void hubp21_set_vm_system_aperture_settings(struct hubp *hubp,
 		struct vm_system_aperture_param *apt)
 {
@@ -602,6 +678,187 @@ void hubp21_validate_dml_output(struct hubp *hubp,
 				dml_dlg_attr->refcyc_per_meta_chunk_flip_l, dlg_attr.refcyc_per_meta_chunk_flip_l);
 }
 
+bool hubp21_program_surface_flip_and_addr(
+	struct hubp *hubp,
+	const struct dc_plane_address *address,
+	bool flip_immediate)
+{
+	struct dcn21_hubp *hubp21 = TO_DCN21_HUBP(hubp);
+	struct dc_debug_options *debug = &hubp->ctx->dc->debug;
+
+	//program flip type
+	REG_UPDATE(DCSURF_FLIP_CONTROL,
+			SURFACE_FLIP_TYPE, flip_immediate);
+
+	// Program VMID reg
+	REG_UPDATE(VMID_SETTINGS_0,
+			VMID, address->vmid);
+
+	if (address->type == PLN_ADDR_TYPE_GRPH_STEREO) {
+		REG_UPDATE(DCSURF_FLIP_CONTROL, SURFACE_FLIP_MODE_FOR_STEREOSYNC, 0x1);
+		REG_UPDATE(DCSURF_FLIP_CONTROL, SURFACE_FLIP_IN_STEREOSYNC, 0x1);
+
+	} else {
+		// turn off stereo if not in stereo
+		REG_UPDATE(DCSURF_FLIP_CONTROL, SURFACE_FLIP_MODE_FOR_STEREOSYNC, 0x0);
+		REG_UPDATE(DCSURF_FLIP_CONTROL, SURFACE_FLIP_IN_STEREOSYNC, 0x0);
+	}
+
+
+
+	/* HW automatically latch rest of address register on write to
+	 * DCSURF_PRIMARY_SURFACE_ADDRESS if SURFACE_UPDATE_LOCK is not used
+	 *
+	 * program high first and then the low addr, order matters!
+	 */
+	switch (address->type) {
+	case PLN_ADDR_TYPE_GRAPHICS:
+		/* DCN1.0 does not support const color
+		 * TODO: program DCHUBBUB_RET_PATH_DCC_CFGx_0/1
+		 * base on address->grph.dcc_const_color
+		 * x = 0, 2, 4, 6 for pipe 0, 1, 2, 3 for rgb and luma
+		 * x = 1, 3, 5, 7 for pipe 0, 1, 2, 3 for chroma
+		 */
+
+		if (address->grph.addr.quad_part == 0)
+			break;
+
+		REG_UPDATE_2(DCSURF_SURFACE_CONTROL,
+				PRIMARY_SURFACE_TMZ, address->tmz_surface,
+				PRIMARY_META_SURFACE_TMZ, address->tmz_surface);
+
+		if (address->grph.meta_addr.quad_part != 0) {
+			REG_SET(DCSURF_PRIMARY_META_SURFACE_ADDRESS_HIGH, 0,
+					PRIMARY_META_SURFACE_ADDRESS_HIGH,
+					address->grph.meta_addr.high_part);
+
+			REG_SET(DCSURF_PRIMARY_META_SURFACE_ADDRESS, 0,
+					PRIMARY_META_SURFACE_ADDRESS,
+					address->grph.meta_addr.low_part);
+		}
+
+		REG_SET(DCSURF_PRIMARY_SURFACE_ADDRESS_HIGH, 0,
+				PRIMARY_SURFACE_ADDRESS_HIGH,
+				address->grph.addr.high_part);
+
+		REG_SET(DCSURF_PRIMARY_SURFACE_ADDRESS, 0,
+				PRIMARY_SURFACE_ADDRESS,
+				address->grph.addr.low_part);
+		break;
+	case PLN_ADDR_TYPE_VIDEO_PROGRESSIVE:
+		if (address->video_progressive.luma_addr.quad_part == 0
+				|| address->video_progressive.chroma_addr.quad_part == 0)
+			break;
+
+		REG_UPDATE_4(DCSURF_SURFACE_CONTROL,
+				PRIMARY_SURFACE_TMZ, address->tmz_surface,
+				PRIMARY_SURFACE_TMZ_C, address->tmz_surface,
+				PRIMARY_META_SURFACE_TMZ, address->tmz_surface,
+				PRIMARY_META_SURFACE_TMZ_C, address->tmz_surface);
+
+		if (address->video_progressive.luma_meta_addr.quad_part != 0) {
+			REG_SET(DCSURF_PRIMARY_META_SURFACE_ADDRESS_HIGH_C, 0,
+					PRIMARY_META_SURFACE_ADDRESS_HIGH_C,
+					address->video_progressive.chroma_meta_addr.high_part);
+
+			REG_SET(DCSURF_PRIMARY_META_SURFACE_ADDRESS_C, 0,
+					PRIMARY_META_SURFACE_ADDRESS_C,
+					address->video_progressive.chroma_meta_addr.low_part);
+
+			REG_SET(DCSURF_PRIMARY_META_SURFACE_ADDRESS_HIGH, 0,
+					PRIMARY_META_SURFACE_ADDRESS_HIGH,
+					address->video_progressive.luma_meta_addr.high_part);
+
+			REG_SET(DCSURF_PRIMARY_META_SURFACE_ADDRESS, 0,
+					PRIMARY_META_SURFACE_ADDRESS,
+					address->video_progressive.luma_meta_addr.low_part);
+		}
+
+		REG_SET(DCSURF_PRIMARY_SURFACE_ADDRESS_HIGH_C, 0,
+				PRIMARY_SURFACE_ADDRESS_HIGH_C,
+				address->video_progressive.chroma_addr.high_part);
+
+		if (debug->nv12_iflip_vm_wa) {
+			REG_SET(DCSURF_PRIMARY_SURFACE_ADDRESS_C, 0,
+					PRIMARY_SURFACE_ADDRESS_C,
+					address->video_progressive.chroma_addr.low_part + hubp21->PLAT_54186_wa_chroma_addr_offset);
+		} else {
+			REG_SET(DCSURF_PRIMARY_SURFACE_ADDRESS_C, 0,
+					PRIMARY_SURFACE_ADDRESS_C,
+					address->video_progressive.chroma_addr.low_part);
+		}
+
+		REG_SET(DCSURF_PRIMARY_SURFACE_ADDRESS_HIGH, 0,
+				PRIMARY_SURFACE_ADDRESS_HIGH,
+				address->video_progressive.luma_addr.high_part);
+
+		REG_SET(DCSURF_PRIMARY_SURFACE_ADDRESS, 0,
+				PRIMARY_SURFACE_ADDRESS,
+				address->video_progressive.luma_addr.low_part);
+		break;
+	case PLN_ADDR_TYPE_GRPH_STEREO:
+		if (address->grph_stereo.left_addr.quad_part == 0)
+			break;
+		if (address->grph_stereo.right_addr.quad_part == 0)
+			break;
+
+		REG_UPDATE_8(DCSURF_SURFACE_CONTROL,
+				PRIMARY_SURFACE_TMZ, address->tmz_surface,
+				PRIMARY_SURFACE_TMZ_C, address->tmz_surface,
+				PRIMARY_META_SURFACE_TMZ, address->tmz_surface,
+				PRIMARY_META_SURFACE_TMZ_C, address->tmz_surface,
+				SECONDARY_SURFACE_TMZ, address->tmz_surface,
+				SECONDARY_SURFACE_TMZ_C, address->tmz_surface,
+				SECONDARY_META_SURFACE_TMZ, address->tmz_surface,
+				SECONDARY_META_SURFACE_TMZ_C, address->tmz_surface);
+
+		if (address->grph_stereo.right_meta_addr.quad_part != 0) {
+
+			REG_SET(DCSURF_SECONDARY_META_SURFACE_ADDRESS_HIGH, 0,
+					SECONDARY_META_SURFACE_ADDRESS_HIGH,
+					address->grph_stereo.right_meta_addr.high_part);
+
+			REG_SET(DCSURF_SECONDARY_META_SURFACE_ADDRESS, 0,
+					SECONDARY_META_SURFACE_ADDRESS,
+					address->grph_stereo.right_meta_addr.low_part);
+		}
+		if (address->grph_stereo.left_meta_addr.quad_part != 0) {
+
+			REG_SET(DCSURF_PRIMARY_META_SURFACE_ADDRESS_HIGH, 0,
+					PRIMARY_META_SURFACE_ADDRESS_HIGH,
+					address->grph_stereo.left_meta_addr.high_part);
+
+			REG_SET(DCSURF_PRIMARY_META_SURFACE_ADDRESS, 0,
+					PRIMARY_META_SURFACE_ADDRESS,
+					address->grph_stereo.left_meta_addr.low_part);
+		}
+
+		REG_SET(DCSURF_SECONDARY_SURFACE_ADDRESS_HIGH, 0,
+				SECONDARY_SURFACE_ADDRESS_HIGH,
+				address->grph_stereo.right_addr.high_part);
+
+		REG_SET(DCSURF_SECONDARY_SURFACE_ADDRESS, 0,
+				SECONDARY_SURFACE_ADDRESS,
+				address->grph_stereo.right_addr.low_part);
+
+		REG_SET(DCSURF_PRIMARY_SURFACE_ADDRESS_HIGH, 0,
+				PRIMARY_SURFACE_ADDRESS_HIGH,
+				address->grph_stereo.left_addr.high_part);
+
+		REG_SET(DCSURF_PRIMARY_SURFACE_ADDRESS, 0,
+				PRIMARY_SURFACE_ADDRESS,
+				address->grph_stereo.left_addr.low_part);
+		break;
+	default:
+		BREAK_TO_DEBUGGER();
+		break;
+	}
+
+	hubp->request_address = *address;
+
+	return true;
+}
+
 void hubp21_init(struct hubp *hubp)
 {
 	// DEDCN21-133: Inconsistent row starting line for flip between DPTE and Meta
@@ -614,7 +871,7 @@ void hubp21_init(struct hubp *hubp)
 static struct hubp_funcs dcn21_hubp_funcs = {
 	.hubp_enable_tripleBuffer = hubp2_enable_triplebuffer,
 	.hubp_is_triplebuffer_enabled = hubp2_is_triplebuffer_enabled,
-	.hubp_program_surface_flip_and_addr = hubp2_program_surface_flip_and_addr,
+	.hubp_program_surface_flip_and_addr = hubp21_program_surface_flip_and_addr,
 	.hubp_program_surface_config = hubp1_program_surface_config,
 	.hubp_is_flip_pending = hubp1_is_flip_pending,
 	.hubp_setup = hubp21_setup,
@@ -623,6 +880,7 @@ static struct hubp_funcs dcn21_hubp_funcs = {
 	.set_blank = hubp1_set_blank,
 	.dcc_control = hubp1_dcc_control,
 	.mem_program_viewport = hubp21_set_viewport,
+	.apply_PLAT_54186_wa = hubp21_apply_PLAT_54186_wa,
 	.set_cursor_attributes	= hubp2_cursor_set_attributes,
 	.set_cursor_position	= hubp1_cursor_set_position,
 	.hubp_clk_cntl = hubp1_clk_cntl,
diff --git a/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_hubp.h b/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_hubp.h
index aeda719a2a13..9873b6cbc5ba 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_hubp.h
+++ b/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_hubp.h
@@ -108,6 +108,7 @@ struct dcn21_hubp {
 	const struct dcn_hubp2_registers *hubp_regs;
 	const struct dcn_hubp2_shift *hubp_shift;
 	const struct dcn_hubp2_mask *hubp_mask;
+	int PLAT_54186_wa_chroma_addr_offset;
 };
 
 bool hubp21_construct(
diff --git a/drivers/gpu/drm/amd/display/dc/inc/hw/hubp.h b/drivers/gpu/drm/amd/display/dc/inc/hw/hubp.h
index 85a34dde8526..686145933335 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/hw/hubp.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/hw/hubp.h
@@ -82,9 +82,10 @@ struct hubp_funcs {
 	void (*mem_program_viewport)(
 			struct hubp *hubp,
 			const struct rect *viewport,
-			const struct rect *viewport_c,
-			enum dc_rotation_angle rotation);
-			/* rotation needed for Renoir workaround */
+			const struct rect *viewport_c);
+
+	void (*apply_PLAT_54186_wa)(struct hubp *hubp,
+			const struct dc_plane_address *address);
 
 	bool (*hubp_program_surface_flip_and_addr)(
 		struct hubp *hubp,
-- 
2.24.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
