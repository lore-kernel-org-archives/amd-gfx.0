Return-Path: <SRS0=KaZi=BP=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 947C8C433DF
	for <amd-gfx@archiver.kernel.org>; Wed,  5 Aug 2020 17:41:05 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 63F212073E
	for <amd-gfx@archiver.kernel.org>; Wed,  5 Aug 2020 17:41:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="Bz90KmPY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 63F212073E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1BBFD89D52;
	Wed,  5 Aug 2020 17:41:05 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2044.outbound.protection.outlook.com [40.107.94.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A6BCF89D52
 for <amd-gfx@lists.freedesktop.org>; Wed,  5 Aug 2020 17:41:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GWehwcaWl7ZAwmnUQxvq5GqrYBEySMpcxuap4WOEqa635wDT2qjhLkqA5KAbx7cxnx0byt5Y1XmN9VYtqWeYn/btA/P78wzRcpiPVqre7QE+FN0wamgUaGPFYdg7Ju+LvU4UtUUP99YdiIepauFesbTkfWFsEaAUyqpsuR8kugUdyAF5VnO8J5ZXLW3f/nuorlrj2kgSLbpOQ6pmaXxwwDhATrrGPqeRYhJuyNxB7LGah/dks0zJsDjnvAlZSf5XzlG7KQQqFdmNUD3h0cv81VYsWADk79rVOcjkHphw9PSitkH+0Yj+HDQQXEyzXPSKAaHg/tOCcNVzNmJN35wmxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C2K1ceP/icupOpk4vTNUa769aVD4kVssKQoxEhhmWTo=;
 b=NVJZefureot7ZEtqgMZ6rBbzNTbd2+zY4CtDwhP6aowE5gZ7B1EVtvH4CUWmLUrysyX0tEtP2pA/bcXEn231kvkFwFypFtf+rNYZG8KKzI/ylTMnCmtJzWNWouvdXdeKCX5zHrvmYroemSKRqfIrfxVh5Li+0V0MAKLVe34ZE4KPxZOT96g0u5QgX+srGSCikIPH2tScH4cQGzQPet1Q+nlBIxi2kudF7KxhcpT5rP0322lFtIFtZDnlb+FEoSzZPIgM8iyoFiiH7vRcqv6JjuxvIGaTo66mbll4ctNLEGvuiC68MxE8b3fX5KNcZNyo1HTMZj+ALvrFO+LZzyhsVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C2K1ceP/icupOpk4vTNUa769aVD4kVssKQoxEhhmWTo=;
 b=Bz90KmPYHUJvwwqvuZPhr+hWaU+AbxnYGiS9/L/G2/hZjHXc3Sg7mWdgc4H8Flqc9Bfwmqc8WJ8pfDRL2F4Mw2CM57N8ffPkgAAeIWGP/asCpxwQ/Htp0mZ3DCQNZom4ntkH7qVYT7KCqQP7kQ/k7wJy6x1AvzrTUaZQ2vRpKHU=
Received: from MWHPR10CA0069.namprd10.prod.outlook.com (2603:10b6:300:2c::31)
 by BL0PR12MB2450.namprd12.prod.outlook.com (2603:10b6:207:4d::32)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3239.17; Wed, 5 Aug
 2020 17:41:01 +0000
Received: from CO1NAM11FT033.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:2c:cafe::37) by MWHPR10CA0069.outlook.office365.com
 (2603:10b6:300:2c::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3239.17 via Frontend
 Transport; Wed, 5 Aug 2020 17:41:01 +0000
X-MS-Exchange-Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 CO1NAM11FT033.mail.protection.outlook.com (10.13.174.247) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3261.16 via Frontend Transport; Wed, 5 Aug 2020 17:41:01 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Wed, 5 Aug 2020
 12:41:00 -0500
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Wed, 5 Aug 2020
 12:40:59 -0500
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server id 15.1.1713.5 via Frontend
 Transport; Wed, 5 Aug 2020 12:40:59 -0500
From: Qingqing Zhuo <qingqing.zhuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/9] drm/amd/display: Adjust static-ness of resource functions
Date: Wed, 5 Aug 2020 13:40:50 -0400
Message-ID: <20200805174058.11736-2-qingqing.zhuo@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200805174058.11736-1-qingqing.zhuo@amd.com>
References: <20200805174058.11736-1-qingqing.zhuo@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 573e9c2b-5552-4555-c108-08d83966b83e
X-MS-TrafficTypeDiagnostic: BL0PR12MB2450:
X-Microsoft-Antispam-PRVS: <BL0PR12MB2450B79A73BEE8F70E2EA76CFB4B0@BL0PR12MB2450.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:311;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: efoORR+ZufnSqE3GLCU1h/9WMx2yGORaTxmQTv2z7z7roO7dnzV0+cvZzEAWKFWvd8Y9WIUFY0Vy8tLUf9mNdi8eXrFVoN/8BLBrBsn5BjnDIhH13FGPj3i1i/rfmOJpajWjHHWK10plNOWpToZFjCctE5NfYHVeyG+0g1ToJILunrpeBCm1jET1DbHnkifl5qDOtt9GRoZNEoSMm/38scxUiMOQAn5eGkt0FXLPohbYS8AXey+iaBxdyr5dlhHdIinVP6Wh5oXqcg0wusU7cx9dj3xtoNl6q/U41+kGQSdr7xs2Wrb4O1NIC0lm8g4OuC4JuZnpVNvZvrib43f8T09LIqOKZk4dXMRJD+6GayIE+dqmN0UhmuTu7fFMN1c0/dmMDZ9N3XEeGYWLPm7mEw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB02.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFTY:;
 SFS:(4636009)(136003)(346002)(376002)(396003)(39860400002)(46966005)(36756003)(1076003)(4326008)(2616005)(47076004)(44832011)(478600001)(83380400001)(316002)(426003)(8936002)(54906003)(6666004)(70206006)(6916009)(82310400002)(186003)(356005)(81166007)(5660300002)(336012)(86362001)(82740400003)(2906002)(26005)(8676002)(70586007);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2020 17:41:01.0214 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 573e9c2b-5552-4555-c108-08d83966b83e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT033.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB2450
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
Cc: Joshua Aberback <joshua.aberback@amd.com>, Eryk.Brol@amd.com,
 Sunpeng.Li@amd.com, Harry.Wentland@amd.com, Qingqing.Zhuo@amd.com,
 Rodrigo.Siqueira@amd.com, Bhawanpreet.Lakha@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Joshua Aberback <joshua.aberback@amd.com>

[Why]
Register definitions are asic-specific, so functions that use registers of
a particular asic should be static, to be exposed in asic-specific function
pointer structures.

[How]
 - make register-definition-using functions static
 - make some functions non-static, for future use
 - remove duplicate function definition

Signed-off-by: Joshua Aberback <joshua.aberback@amd.com>
Reviewed-by: Nicholas Kazlauskas <Nicholas.Kazlauskas@amd.com>
Acked-by: Qingqing Zhuo <qingqing.zhuo@amd.com>
---
 .../drm/amd/display/dc/dcn20/dcn20_resource.h |  1 -
 .../drm/amd/display/dc/dcn30/dcn30_resource.c | 27 ++++++++++---------
 .../drm/amd/display/dc/dcn30/dcn30_resource.h |  3 +++
 3 files changed, 18 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.h b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.h
index 2c1959845c29..cdd39ee9761d 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.h
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.h
@@ -95,7 +95,6 @@ struct display_stream_compressor *dcn20_dsc_create(
 	struct dc_context *ctx, uint32_t inst);
 void dcn20_dsc_destroy(struct display_stream_compressor **dsc);
 
-void dcn20_patch_bounding_box(struct dc *dc, struct _vcs_dpi_soc_bounding_box_st *bb);
 void dcn20_cap_soc_clocks(
 		struct _vcs_dpi_soc_bounding_box_st *bb,
 		struct pp_smu_nv_clock_table max_clocks);
diff --git a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c
index 653a571e366d..de53d26f61d5 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c
@@ -871,7 +871,7 @@ void dcn30_dpp_destroy(struct dpp **dpp)
 	*dpp = NULL;
 }
 
-struct dpp *dcn30_dpp_create(
+static struct dpp *dcn30_dpp_create(
 	struct dc_context *ctx,
 	uint32_t inst)
 {
@@ -889,7 +889,8 @@ struct dpp *dcn30_dpp_create(
 	kfree(dpp);
 	return NULL;
 }
-struct output_pixel_processor *dcn30_opp_create(
+
+static struct output_pixel_processor *dcn30_opp_create(
 	struct dc_context *ctx, uint32_t inst)
 {
 	struct dcn20_opp *opp =
@@ -905,7 +906,7 @@ struct output_pixel_processor *dcn30_opp_create(
 	return &opp->base;
 }
 
-struct dce_aux *dcn30_aux_engine_create(
+static struct dce_aux *dcn30_aux_engine_create(
 	struct dc_context *ctx,
 	uint32_t inst)
 {
@@ -924,6 +925,7 @@ struct dce_aux *dcn30_aux_engine_create(
 
 	return &aux_engine->base;
 }
+
 #define i2c_inst_regs(id) { I2C_HW_ENGINE_COMMON_REG_LIST(id) }
 
 static const struct dce_i2c_registers i2c_hw_regs[] = {
@@ -943,7 +945,7 @@ static const struct dce_i2c_mask i2c_masks = {
 		I2C_COMMON_MASK_SH_LIST_DCN2(_MASK)
 };
 
-struct dce_i2c_hw *dcn30_i2c_hw_create(
+static struct dce_i2c_hw *dcn30_i2c_hw_create(
 	struct dc_context *ctx,
 	uint32_t inst)
 {
@@ -958,6 +960,7 @@ struct dce_i2c_hw *dcn30_i2c_hw_create(
 
 	return dce_i2c_hw;
 }
+
 static struct mpc *dcn30_mpc_create(
 		struct dc_context *ctx,
 		int num_mpcc,
@@ -1008,7 +1011,7 @@ struct hubbub *dcn30_hubbub_create(struct dc_context *ctx)
 	return &hubbub3->base;
 }
 
-struct timing_generator *dcn30_timing_generator_create(
+static struct timing_generator *dcn30_timing_generator_create(
 		struct dc_context *ctx,
 		uint32_t instance)
 {
@@ -1042,7 +1045,7 @@ static const struct encoder_feature_support link_enc_feature = {
 		.flags.bits.IS_TPS4_CAPABLE = true
 };
 
-struct link_encoder *dcn30_link_encoder_create(
+static struct link_encoder *dcn30_link_encoder_create(
 	const struct encoder_init_data *enc_init_data)
 {
 	struct dcn20_link_encoder *enc20 =
@@ -1063,7 +1066,7 @@ struct link_encoder *dcn30_link_encoder_create(
 	return &enc20->enc10.base;
 }
 
-struct panel_cntl *dcn30_panel_cntl_create(const struct panel_cntl_init_data *init_data)
+static struct panel_cntl *dcn30_panel_cntl_create(const struct panel_cntl_init_data *init_data)
 {
 	struct dce_panel_cntl *panel_cntl =
 		kzalloc(sizeof(struct dce_panel_cntl), GFP_KERNEL);
@@ -1311,7 +1314,7 @@ static void dcn30_resource_destruct(struct dcn30_resource_pool *pool)
 		dcn_dccg_destroy(&pool->base.dccg);
 }
 
-struct hubp *dcn30_hubp_create(
+static struct hubp *dcn30_hubp_create(
 	struct dc_context *ctx,
 	uint32_t inst)
 {
@@ -1330,7 +1333,7 @@ struct hubp *dcn30_hubp_create(
 	return NULL;
 }
 
-bool dcn30_dwbc_create(struct dc_context *ctx, struct resource_pool *pool)
+static bool dcn30_dwbc_create(struct dc_context *ctx, struct resource_pool *pool)
 {
 	int i;
 	uint32_t pipe_count = pool->res_cap->num_dwb;
@@ -1355,7 +1358,7 @@ bool dcn30_dwbc_create(struct dc_context *ctx, struct resource_pool *pool)
 	return true;
 }
 
-bool dcn30_mmhubbub_create(struct dc_context *ctx, struct resource_pool *pool)
+static bool dcn30_mmhubbub_create(struct dc_context *ctx, struct resource_pool *pool)
 {
 	int i;
 	uint32_t pipe_count = pool->res_cap->num_dwb;
@@ -2292,7 +2295,7 @@ static void get_optimal_dcfclk_fclk_for_uclk(unsigned int uclk_mts,
                (dcn3_0_soc.return_bus_width_bytes * (dcn3_0_soc.max_avg_sdp_bw_use_normal_percent / 100));
 }
 
-static void dcn30_update_bw_bounding_box(struct dc *dc, struct clk_bw_params *bw_params)
+void dcn30_update_bw_bounding_box(struct dc *dc, struct clk_bw_params *bw_params)
 {
 	unsigned int i, j;
 	unsigned int num_states = 0;
@@ -2683,7 +2686,7 @@ static bool dcn30_resource_construct(
 	if (!resource_construct(num_virtual_links, dc, &pool->base,
 			(!IS_FPGA_MAXIMUS_DC(dc->ctx->dce_environment) ?
 			&res_create_funcs : &res_create_maximus_funcs)))
-			goto create_fail;
+		goto create_fail;
 
 	/* HW Sequencer and Plane caps */
 	dcn30_hw_sequencer_construct(dc);
diff --git a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.h b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.h
index 4b4a4d81c1e3..c9d5f94092a0 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.h
+++ b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.h
@@ -79,4 +79,7 @@ enum dc_status dcn30_add_stream_to_ctx(
 		struct dc *dc,
 		struct dc_state *new_ctx,
 		struct dc_stream_state *dc_stream);
+
+void dcn30_update_bw_bounding_box(struct dc *dc, struct clk_bw_params *bw_params);
+
 #endif /* _DCN30_RESOURCE_H_ */
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
