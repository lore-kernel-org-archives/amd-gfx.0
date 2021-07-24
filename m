Return-Path: <SRS0=oGIb=MQ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C86DBC4338F
	for <amd-gfx@archiver.kernel.org>; Sat, 24 Jul 2021 04:11:45 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8FDB160E52
	for <amd-gfx@archiver.kernel.org>; Sat, 24 Jul 2021 04:11:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 8FDB160E52
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 546566FE61;
	Sat, 24 Jul 2021 04:11:45 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2081.outbound.protection.outlook.com [40.107.244.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CA5636FE61
 for <amd-gfx@lists.freedesktop.org>; Sat, 24 Jul 2021 04:11:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mrARyqkBI2yrJcGCdNGa12yL2Kj75O32EzI++zfCL/qTSIJGrQAHHez6N4EzLvDL25MuCWps6qVcvT9u8IuoaqPfjwCRqPIjYQllGpWtTxt18H2SpGbQ6ZRzcaIccaK3xR53VR02pMcA0tcplkXCkOEYw1VaTjokeXN75riACujySoHUZfVFw0fZML835P6HgtMKg1nRy5VkvJnMM6x36F+OzMAdEoId+HjnhBH12WHh8tbGBGTydSddR6iND5R7RZtT7M9iTANoW7DgYp8Fu+wj/fA2DJdSJDBUQ1icSNglgsqyszFnaWAcxWMtBuYCI0DRBVkYmoEvgex0VABhow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5CQQzw40C28UIInFowVNY+RM7IfOuHgxUbnjrlbxwLk=;
 b=kPOG39IohIBMUfukQHCPMfdVHLDP7iAfyngcHxQOiBlO5zSrJupPY+3eSnvVhhl/0iLRrA/w4zO9u5SLR02zc8TxMq3yymb3L9aySG5RSWDg3x8CXbnRgaPX0e7iUO1x8jYrI6jmuz1IUeOvcCnkSzxdWwofCo0ydeumSajK/gf3Qcq3Zf3HlOaBVGaz+MNuyhxykW6XDJwWjz8IleHzfypDOTtgxR2Uw0BwESoMMlD4ps4em3448T+ObwNwHzsqCrlb5sUmcH3IChQArJGnnhPLr05Ty3lTKM1NYF6FwEFOQGLHZ5ZcprW+c/xE9EyR2YEvjuLIMeMXiq/VW+rP1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5CQQzw40C28UIInFowVNY+RM7IfOuHgxUbnjrlbxwLk=;
 b=dObIBO1di49wcrvuxdFqZ5SRZyVz3UvFz9ptF9lzvZ9yPXinMNOVAfAEDI5Fe/8w5qRWN5yjNKbCsROeLMrrxx57gCRph73Rfr8oK8tCStBXGEJ+TysnTb9ym5TFu37rrM3sgSyeF9kl2sETVjmqU6wAlDhVh73MvF2v4rJCEbA=
Received: from BN6PR2001CA0034.namprd20.prod.outlook.com
 (2603:10b6:405:16::20) by BYAPR12MB2853.namprd12.prod.outlook.com
 (2603:10b6:a03:13a::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4352.29; Sat, 24 Jul
 2021 04:11:41 +0000
Received: from BN8NAM11FT028.eop-nam11.prod.protection.outlook.com
 (2603:10b6:405:16:cafe::f8) by BN6PR2001CA0034.outlook.office365.com
 (2603:10b6:405:16::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4352.24 via Frontend
 Transport; Sat, 24 Jul 2021 04:11:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT028.mail.protection.outlook.com (10.13.176.225) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4352.24 via Frontend Transport; Sat, 24 Jul 2021 04:11:41 +0000
Received: from solomon-t14.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Fri, 23 Jul
 2021 23:11:38 -0500
From: Solomon Chiu <solomon.chiu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 11/14] drm/amd/display: refactor riommu invalidation wa
Date: Sat, 24 Jul 2021 12:09:58 +0800
Message-ID: <20210724041001.3875757-12-solomon.chiu@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210724041001.3875757-4-solomon.chiu@amd.com>
References: <20210724041001.3875757-4-solomon.chiu@amd.com>
MIME-Version: 1.0
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7d64649e-bdc1-45c9-3f58-08d94e592440
X-MS-TrafficTypeDiagnostic: BYAPR12MB2853:
X-Microsoft-Antispam-PRVS: <BYAPR12MB2853C5C67BEAD842F6E21B5A97E69@BYAPR12MB2853.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:92;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KD4f8iMrazFcSpbuZOUE42zFoCbFvHBtNuCpwUKmOtN2lIUEmc4kOwXewfyz2kjZPWciRD39QNJNiWF7oED744667/sBviwAmt7R9+PM3OOHetcvAbbcKvJrudfK2px9NROPlGQa/YX7esT0ytUjk5RQzX2NX65+zIE6lpxrJRwZZ8PFavXA0MZbbUfi81dW5/X+A2x8c29E3ngb9CQdiwX7fLrBPb6ZrHAEhur8/dazKSTbzlPy3C6QjDJG5IgR1q40br9Ui7zH6tzYyHNiDG01mFV3siCeekSy/aZ2/4RJgiHNyUAGhvPggevD5RkyV9+qIE3ua7jW+Ky4fBh+XLhl8zqYzmjEXB0zbxWVDc/NFHoacByH6E1f+P9ygFW3dGgTCg9QPneGiFFs3ZdzHDThJxn3jP3ZSWf1W4uU4TsR7Er/loqXOBDIKymfDL+p2AvovTkRrCKuLqbCGRh1oPBnExL29PDjcIIJkKUPKW6AS7mIZZpgAY7l2NE6vmHZbDjV3CbfqbWNiKc9OhXry7zVvuX/3vApDSDo9DR2RxLoDpNZjsUqJgfh9lWDcvJel3KnIa6Jhag1tcksEhQiPOREVh9qBMqGyU5cxF0uKJCWaG38rrz/p7Gar20olWMh/uv5Kq0rBXoivceIdlvn5ktXJTxtdV2d8JwYmn8IrjjGxCr9VTLLXfU/sebHaIcNI66L4JyjDmey23UbuqjzMVTX8abf7PBjMHetyx6ad28=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(346002)(376002)(39860400002)(396003)(136003)(46966006)(36840700001)(4326008)(426003)(5660300002)(86362001)(82310400003)(83380400001)(2616005)(54906003)(1076003)(7696005)(82740400003)(81166007)(44832011)(2906002)(36860700001)(336012)(356005)(70206006)(70586007)(316002)(8676002)(6916009)(186003)(47076005)(8936002)(478600001)(36756003)(26005)(6666004)(16526019)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2021 04:11:41.6352 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d64649e-bdc1-45c9-3f58-08d94e592440
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT028.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2853
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
Cc: Eric Yang <Eric.Yang2@amd.com>, Solomon Chiu <solomon.chiu@amd.com>,
 Sunpeng.Li@amd.com, Harry.Wentland@amd.com, Qingqing.Zhuo@amd.com,
 Rodrigo.Siqueira@amd.com, Anson.Jacob@amd.com, Aurabindo.Pillai@amd.com,
 Bhawanpreet.Lakha@amd.com, Kazlauskas Nicholas <Nicholas.Kazlauskas@amd.com>,
 bindu.r@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Eric Yang <Eric.Yang2@amd.com>

[Why]
A cleaner solution, only done once on boot.

[How]
Remove previous workaround and configure an extra
vmid one time on boot

Reviewed-by: Kazlauskas Nicholas <Nicholas.Kazlauskas@amd.com>
Acked-by: Solomon Chiu <solomon.chiu@amd.com>
Signed-off-by: Eric Yang <Eric.Yang2@amd.com>
---
 .../drm/amd/display/dc/dcn20/dcn20_hwseq.c    |  6 ---
 .../drm/amd/display/dc/dcn31/dcn31_hubbub.c   | 48 +++++++++++--------
 .../drm/amd/display/dc/dcn31/dcn31_hwseq.c    | 17 -------
 .../gpu/drm/amd/display/dc/dcn31/dcn31_init.c |  2 +-
 .../drm/amd/display/dc/dcn31/dcn31_resource.c |  1 -
 .../gpu/drm/amd/display/dc/inc/hw/dchubbub.h  |  3 --
 .../amd/display/dc/inc/hw_sequencer_private.h |  1 -
 7 files changed, 28 insertions(+), 50 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
index ef185b93b31d..5c2853654cca 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
@@ -570,12 +570,6 @@ void dcn20_plane_atomic_disable(struct dc *dc, struct pipe_ctx *pipe_ctx)
 	struct hubp *hubp = pipe_ctx->plane_res.hubp;
 	struct dpp *dpp = pipe_ctx->plane_res.dpp;
 
-	if (hws->wa.early_riommu_invalidation) {
-		struct hubbub *hubbub = dc->res_pool->hubbub;
-
-		hubbub->funcs->apply_invalidation_req_wa(hubbub, &hubbub->vmid_cache);
-	}
-
 	dc->hwss.wait_for_mpcc_disconnect(dc, dc->res_pool, pipe_ctx);
 
 	/* In flip immediate with pipe splitting case GSL is used for
diff --git a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_hubbub.c b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_hubbub.c
index ef233cb49b31..90c73a1cb986 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_hubbub.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_hubbub.c
@@ -876,11 +876,35 @@ static bool hubbub31_get_dcc_compression_cap(struct hubbub *hubbub,
 static int hubbub31_init_dchub_sys_ctx(struct hubbub *hubbub,
 		struct dcn_hubbub_phys_addr_config *pa_config)
 {
-	hubbub3_init_dchub_sys_ctx(hubbub, pa_config);
+	struct dcn20_hubbub *hubbub2 = TO_DCN20_HUBBUB(hubbub);
+	struct dcn_vmid_page_table_config phys_config;
 
-	dcn21_dchvm_init(hubbub);
+	REG_SET(DCN_VM_FB_LOCATION_BASE, 0,
+			FB_BASE, pa_config->system_aperture.fb_base >> 24);
+	REG_SET(DCN_VM_FB_LOCATION_TOP, 0,
+			FB_TOP, pa_config->system_aperture.fb_top >> 24);
+	REG_SET(DCN_VM_FB_OFFSET, 0,
+			FB_OFFSET, pa_config->system_aperture.fb_offset >> 24);
+	REG_SET(DCN_VM_AGP_BOT, 0,
+			AGP_BOT, pa_config->system_aperture.agp_bot >> 24);
+	REG_SET(DCN_VM_AGP_TOP, 0,
+			AGP_TOP, pa_config->system_aperture.agp_top >> 24);
+	REG_SET(DCN_VM_AGP_BASE, 0,
+			AGP_BASE, pa_config->system_aperture.agp_base >> 24);
 
-	hubbub->vmid_cache = *pa_config;
+	if (pa_config->gart_config.page_table_start_addr != pa_config->gart_config.page_table_end_addr) {
+		phys_config.page_table_start_addr = pa_config->gart_config.page_table_start_addr >> 12;
+		phys_config.page_table_end_addr = pa_config->gart_config.page_table_end_addr >> 12;
+		phys_config.page_table_base_addr = pa_config->gart_config.page_table_base_addr;
+		phys_config.depth = 0;
+		phys_config.block_size = 0;
+		// Init VMID 0 based on PA config
+		dcn20_vmid_setup(&hubbub2->vmid[0], &phys_config);
+
+		dcn20_vmid_setup(&hubbub2->vmid[15], &phys_config);
+	}
+
+	dcn21_dchvm_init(hubbub);
 
 	return NUM_VMID;
 }
@@ -922,23 +946,6 @@ static void hubbub31_get_dchub_ref_freq(struct hubbub *hubbub,
 	}
 }
 
-static void hubbub31_apply_invalidation_req_wa(struct hubbub *hubbub,
-		struct dcn_hubbub_phys_addr_config *pa_config)
-{
-	struct dcn20_hubbub *hubbub1 = TO_DCN20_HUBBUB(hubbub);
-	struct dcn_vmid_page_table_config phys_config;
-
-	if (pa_config->gart_config.page_table_start_addr != pa_config->gart_config.page_table_end_addr) {
-		phys_config.page_table_start_addr = pa_config->gart_config.page_table_start_addr >> 12;
-		phys_config.page_table_end_addr = pa_config->gart_config.page_table_end_addr >> 12;
-		phys_config.page_table_base_addr = pa_config->gart_config.page_table_base_addr;
-		phys_config.depth = 0;
-		phys_config.block_size = 0;
-		// Program an arbitrary unused VMID
-		dcn20_vmid_setup(&hubbub1->vmid[15], &phys_config);
-	}
-}
-
 static const struct hubbub_funcs hubbub31_funcs = {
 	.update_dchub = hubbub2_update_dchub,
 	.init_dchub_sys_ctx = hubbub31_init_dchub_sys_ctx,
@@ -955,7 +962,6 @@ static const struct hubbub_funcs hubbub31_funcs = {
 	.program_compbuf_size = dcn31_program_compbuf_size,
 	.init_crb = dcn31_init_crb,
 	.hubbub_read_state = hubbub2_read_state,
-	.apply_invalidation_req_wa = hubbub31_apply_invalidation_req_wa
 };
 
 void hubbub31_construct(struct dcn20_hubbub *hubbub31,
diff --git a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_hwseq.c b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_hwseq.c
index 83f7904630e6..6399e8acd093 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_hwseq.c
@@ -598,20 +598,3 @@ bool dcn31_is_abm_supported(struct dc *dc,
 	}
 	return false;
 }
-
-static void apply_riommu_invalidation_wa(struct dc *dc)
-{
-	struct dce_hwseq *hws = dc->hwseq;
-
-	if (!hws->wa.early_riommu_invalidation)
-		return;
-
-	REG_UPDATE(DCHUBBUB_ARB_HOSTVM_CNTL, DISABLE_HOSTVM_FORCE_ALLOW_PSTATE, 0);
-}
-
-void dcn31_init_pipes(struct dc *dc, struct dc_state *context)
-{
-	dcn10_init_pipes(dc, context);
-	apply_riommu_invalidation_wa(dc);
-
-}
diff --git a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_init.c b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_init.c
index aaf2dbd095fe..05954045c332 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_init.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_init.c
@@ -103,7 +103,7 @@ static const struct hw_sequencer_funcs dcn31_funcs = {
 };
 
 static const struct hwseq_private_funcs dcn31_private_funcs = {
-	.init_pipes = dcn31_init_pipes,
+	.init_pipes = dcn10_init_pipes,
 	.update_plane_addr = dcn20_update_plane_addr,
 	.plane_atomic_disconnect = dcn10_plane_atomic_disconnect,
 	.update_mpcc = dcn20_update_mpcc,
diff --git a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_resource.c b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_resource.c
index 38c010afade1..f9446ce4fdc5 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_resource.c
@@ -1302,7 +1302,6 @@ static struct dce_hwseq *dcn31_hwseq_create(
 		hws->regs = &hwseq_reg;
 		hws->shifts = &hwseq_shift;
 		hws->masks = &hwseq_mask;
-		hws->wa.early_riommu_invalidation = true;
 	}
 	return hws;
 }
diff --git a/drivers/gpu/drm/amd/display/dc/inc/hw/dchubbub.h b/drivers/gpu/drm/amd/display/dc/inc/hw/dchubbub.h
index 259283d8bde8..713f5558f5e1 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/hw/dchubbub.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/hw/dchubbub.h
@@ -166,15 +166,12 @@ struct hubbub_funcs {
 	void (*program_det_size)(struct hubbub *hubbub, int hubp_inst, unsigned det_buffer_size_in_kbyte);
 	void (*program_compbuf_size)(struct hubbub *hubbub, unsigned compbuf_size_kb, bool safe_to_increase);
 	void (*init_crb)(struct hubbub *hubbub);
-	void (*apply_invalidation_req_wa)(struct hubbub *hubbub,
-			struct dcn_hubbub_phys_addr_config *pa_config);
 };
 
 struct hubbub {
 	const struct hubbub_funcs *funcs;
 	struct dc_context *ctx;
 	bool riommu_active;
-	struct dcn_hubbub_phys_addr_config vmid_cache;
 };
 
 #endif
diff --git a/drivers/gpu/drm/amd/display/dc/inc/hw_sequencer_private.h b/drivers/gpu/drm/amd/display/dc/inc/hw_sequencer_private.h
index 082549f75978..f7f7e4fff0c2 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/hw_sequencer_private.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/hw_sequencer_private.h
@@ -41,7 +41,6 @@ struct dce_hwseq_wa {
 	bool DEGVIDCN10_254;
 	bool DEGVIDCN21;
 	bool disallow_self_refresh_during_multi_plane_transition;
-	bool early_riommu_invalidation;
 };
 
 struct hwseq_wa_state {
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
