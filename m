Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC7E1D3A674
	for <amd-gfx@archiver.kernel.org>; Tue, 29 Oct 2024 16:57:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9023610E6A4;
	Tue, 29 Oct 2024 16:57:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="G5136HFY";
	dkim-atps=neutral
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2079.outbound.protection.outlook.com [40.107.96.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C8F8410E396
 for <amd-gfx@lists.freedesktop.org>; Tue, 29 Oct 2024 16:57:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yqCVv024uJGl5EzBco+DvGdGJzRSuREnyBFEjFBAFHNdPmOYDt9hMd61IpTDDv2HbT1ial4TJ99RFANOhpvk729eB6K4g1sMTb1rfla6Drhig99nB6ePq7eEujzF8+hnPBCZOIKHbXWm9/NgupeQhBgYdqAoqK3KKhv8G+wLWPunTMaZ9ldQ1VtQ5arvhqVbCiJB4ibEF8A7W2Pee2r3N/A6ayNcKEfcRg1hMBfZoTxiRK8jwYaCeJFmCafj4TgxDig9XUNUNdv4Cxy+SR+1DM4SBH7Xo/EtFxzrE5lzl2cWU3HAEDyuQzlAYNPtHLNG/4X9Ziss/Mrwams2v/HLdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ud2gnoR7/+XFPsB4mqoylVQp8f0b7fUQgKDylI6EqZE=;
 b=LMJ6ggqfXutJZKvkHIeOaWFUKLohePBFWU/ycLfNBuVOxbN5Pd3Jd9UiPS6Pii64Yzy75XFRRObyZsS/TrRYVYg+0HyGLlp2myAGQSGUPW0Ux72HlGahOmBbrVjN9BOixtoTKBmNRglu8FVq434GRKp/tRPd864f8TtIYK5s1ChzRI+r0vTpYM/w12VPW5xxVkIBGD0yxGegOFoeZBbfqGVPGsUBifa2KUzrpPXDxAAKLZ1TKlvtLK8r9dlIx+K7/b9b4zvCbxch2P8+S5TYtJen/KhfnRY+gUHGqA/HEAA7KaTlMxu2FR4YDzhtjWE/ykYuyQwreT3nJAawBtlspw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ud2gnoR7/+XFPsB4mqoylVQp8f0b7fUQgKDylI6EqZE=;
 b=G5136HFYB+vRnPze2JbDXxy6w2rd2mOjZnA8Op1A+Wss79Xnn3Co5F4wSBYJLB4cuRZmc9D90bC0El9ZU5/XyrMunrPgPUhjBU8yWl2oHUFL0nQlm76AEpHzzIFdbkRFbRB8Yt6O6Ub6L/lU3e1mD6X/qd11IV8kuCJ/PZg2s54=
Received: from BN9P221CA0009.NAMP221.PROD.OUTLOOK.COM (2603:10b6:408:10a::17)
 by SJ0PR12MB8168.namprd12.prod.outlook.com (2603:10b6:a03:4e7::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.20; Tue, 29 Oct
 2024 16:57:18 +0000
Received: from BN3PEPF0000B06D.namprd21.prod.outlook.com
 (2603:10b6:408:10a:cafe::30) by BN9P221CA0009.outlook.office365.com
 (2603:10b6:408:10a::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.26 via Frontend
 Transport; Tue, 29 Oct 2024 16:57:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B06D.mail.protection.outlook.com (10.167.243.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8137.0 via Frontend Transport; Tue, 29 Oct 2024 16:57:16 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 29 Oct
 2024 11:57:11 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <yaolu@kylinos.cn>, <jfalempe@redhat.com>, Alex Deucher
 <alexander.deucher@amd.com>
Subject: [PATCH 7/7] drm/amd/display: add panic support for DCE based IPs
Date: Tue, 29 Oct 2024 12:56:53 -0400
Message-ID: <20241029165653.1873243-8-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241029165653.1873243-1-alexander.deucher@amd.com>
References: <20241029165653.1873243-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B06D:EE_|SJ0PR12MB8168:EE_
X-MS-Office365-Filtering-Correlation-Id: 9832c5d0-c1fe-44c9-41a2-08dcf83abe7f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?RKxllOxtvhCeJ8Yv5YpuhwPsCiN82UxW4mfzItwWOWLQYEScE9f3bMJ1oY2w?=
 =?us-ascii?Q?0ES1J8QpazfnPoBbQIOn2x1x/lntIhrlc7i2dSi2Ps97m1Sa7HJ++HSeox7J?=
 =?us-ascii?Q?7wdZkOpgDLvMSUDoNAndzh1mYzyXz5v3WiZ0QnTME8IfoZe2SNfiR7ZaF0yr?=
 =?us-ascii?Q?yuDyjacKO3Lu5MpS74CqNrZIkMCij9NkNGrs5nMy9Py/WBY7ZuKymqK8wyUY?=
 =?us-ascii?Q?kQkPsQGQGe9/GTxs4zwAVACGw314HK/IkzMuAiP3iUIQW71gsTJUwTFyKgZm?=
 =?us-ascii?Q?crPRirej5MZqxszaQRm+1WGFcFy/8wH71sAlSnnfFdtnDYFHKblr7odlvdq7?=
 =?us-ascii?Q?1safXHgTIKxLSpb1I1w7g12ssngl/AFhAGljhbp9663SzUn5Fio+C/tZnMMS?=
 =?us-ascii?Q?W4YcXY1SV+te03JxzWTmpJKRuFcrp+Fuu/gR6+2UEG8vFGADjqHosWfCzgoE?=
 =?us-ascii?Q?eprEnf0d3yd0RSscevSZDM44MCCPcIT0m5RIAYHirVjpVY0Mg1hzNybLf+0h?=
 =?us-ascii?Q?mTbI/oenmxzlMzqkxa64FsdQt0igPCYrHGo2GUtAdm2anUp/D+S2cOvnm8MN?=
 =?us-ascii?Q?Bd07IiglX6r8P44OZys/A9uzA3BBBKiesiRObNnce8xX7Xx/8jmUzMsb4K4h?=
 =?us-ascii?Q?zwGhpIKodGwOx5MmIifNRFXDrmockWxZElNsZGWLnT+BpyKrHGGdz5VdbEMt?=
 =?us-ascii?Q?Q24Q/QYFExs+WDAKg10H82nU4lTrHyS+0UgWEvljAWQj/CNBZa3gwKdkICWl?=
 =?us-ascii?Q?6W00Yza90I5Pma1FmsfWUw5U8wkZSg0LBXOgzpZ2CKX4F0W67WIaWjqzwUAy?=
 =?us-ascii?Q?dgtZyFaDvLAmuEaGpBZz7E7g8jRqIgM4xDjYAKa2WtG6WRTMYX2hL66Cp34Z?=
 =?us-ascii?Q?Zddsre0u3c5mDtk7QDVvezT8WqsORYgiNDC2Y6agdyjqaDTmRzvHKZGjUgVD?=
 =?us-ascii?Q?QsWVW0fGuJ6bFHofBU9p/FxIorxDFOIc+fl+Fde3fqgLbL5IN7V8l91XmS0I?=
 =?us-ascii?Q?gTOOl9vx4TEWKTp66nHylDF/3wE41cBA9ze95EYbp+RL+1pvo+vX6TVGf/ij?=
 =?us-ascii?Q?vUyxUs8XOEfOz5cnfTHidVYitUjtE/wTTc8yvi/oOKR4gRFofojoubrKclMM?=
 =?us-ascii?Q?rvRWivoX4r/VPHdXv7MlGfKX0kQ5dcEHbVOUTqvTAn3/ukYpGPmJs6f6iv9C?=
 =?us-ascii?Q?PcZci1H6tbqxps5GAvfxOJ1LrimxA4ZDqudDAMI7thsVB5tlwXPigehbtdd6?=
 =?us-ascii?Q?BvF0UKEvMi/RBJaLLKilS1ZF2r47uIddQAUWS4NcWCb2wWaHFCozNBqBa0PK?=
 =?us-ascii?Q?K6pSeQoMrTY+zbSIabBuotSxxKFyIBiRkDmxJH2LoQrIZieCIO2orxC/4j1y?=
 =?us-ascii?Q?ArxiNIULuR4nM/GS3du4wneSznVUZbTsTuSU3CQO8Efz1KM4yQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2024 16:57:16.6945 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9832c5d0-c1fe-44c9-41a2-08dcf83abe7f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B06D.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB8168
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

This adds panic support for DCE based IPs.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 .../amd/display/amdgpu_dm/amdgpu_dm_plane.c   | 73 ++++++++++++++++---
 .../drm/amd/display/dc/dce/dce_mem_input.c    | 34 +++++++--
 .../gpu/drm/amd/display/dc/inc/hw/mem_input.h |  2 +
 3 files changed, 92 insertions(+), 17 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
index 60606b36f07b..5421d48be9f1 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
@@ -1523,22 +1523,71 @@ static void amdgpu_dm_plane_panic_flush(struct drm_plane *plane)
 	for (i = 0; i < dc->res_pool->pipe_count; i++) {
 		struct pipe_ctx *pipe_ctx = &dc->current_state->res_ctx.pipe_ctx[i];
 		struct hubp *hubp;
+		struct mem_input *mi;
 
 		if (!pipe_ctx)
 			continue;
 
-		hubp = pipe_ctx->plane_res.hubp;
-		if (!hubp)
-			continue;
-
-		/* if framebuffer is tiled, disable tiling */
-		if (fb->modifier && hubp->funcs->hubp_clear_tiling)
-			hubp->funcs->hubp_clear_tiling(hubp);
-
-		/* force page flip to see the new content of the framebuffer */
-		hubp->funcs->hubp_program_surface_flip_and_addr(hubp,
-								&dc_plane_state->address,
-								true);
+		switch (dc->ctx->dce_version) {
+#if defined(CONFIG_DRM_AMD_DC_SI)
+		case DCE_VERSION_6_0:
+		case DCE_VERSION_6_1:
+		case DCE_VERSION_6_4:
+#endif
+		case DCE_VERSION_8_0:
+		case DCE_VERSION_8_1:
+		case DCE_VERSION_8_3:
+		case DCE_VERSION_10_0:
+		case DCE_VERSION_11_0:
+		case DCE_VERSION_11_2:
+		case DCE_VERSION_11_22:
+		case DCE_VERSION_12_0:
+		case DCE_VERSION_12_1:
+			mi = pipe_ctx->plane_res.mi;
+			if (!mi)
+				continue;
+			/* if framebuffer is tiled, disable tiling */
+			if (fb->modifier && mi->funcs->mem_input_clear_tiling)
+				mi->funcs->mem_input_clear_tiling(mi);
+
+			/* force page flip to see the new content of the framebuffer */
+			mi->funcs->mem_input_program_surface_flip_and_addr(mi,
+									   &dc_plane_state->address,
+									   true);
+			break;
+		case DCN_VERSION_1_0:
+		case DCN_VERSION_1_01:
+		case DCN_VERSION_2_0:
+		case DCN_VERSION_2_01:
+		case DCN_VERSION_2_1:
+		case DCN_VERSION_3_0:
+		case DCN_VERSION_3_01:
+		case DCN_VERSION_3_02:
+		case DCN_VERSION_3_03:
+		case DCN_VERSION_3_1:
+		case DCN_VERSION_3_14:
+		case DCN_VERSION_3_16:
+		case DCN_VERSION_3_15:
+		case DCN_VERSION_3_2:
+		case DCN_VERSION_3_21:
+		case DCN_VERSION_3_5:
+		case DCN_VERSION_3_51:
+		case DCN_VERSION_4_01:
+			hubp = pipe_ctx->plane_res.hubp;
+			if (!hubp)
+				continue;
+			/* if framebuffer is tiled, disable tiling */
+			if (fb->modifier && hubp->funcs->hubp_clear_tiling)
+				hubp->funcs->hubp_clear_tiling(hubp);
+
+			/* force page flip to see the new content of the framebuffer */
+			hubp->funcs->hubp_program_surface_flip_and_addr(hubp,
+									&dc_plane_state->address,
+									true);
+			break;
+		default:
+			break;;
+		}
 	}
 }
 
diff --git a/drivers/gpu/drm/amd/display/dc/dce/dce_mem_input.c b/drivers/gpu/drm/amd/display/dc/dce/dce_mem_input.c
index f5e1d9caee4c..ebd174be5786 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dce_mem_input.c
+++ b/drivers/gpu/drm/amd/display/dc/dce/dce_mem_input.c
@@ -481,7 +481,6 @@ static void program_tiling(
 	}
 }
 
-
 static void program_size_and_rotation(
 	struct dce_mem_input *dce_mi,
 	enum dc_rotation_angle rotation,
@@ -627,6 +626,27 @@ static void program_grph_pixel_format(
 			GRPH_PRESCALE_B_SIGN, sign);
 }
 
+static void dce_mi_clear_tiling(
+	struct mem_input *mi)
+{
+	struct dce_mem_input *dce_mi = TO_DCE_MEM_INPUT(mi);
+
+	if (dce_mi->masks->GRPH_SW_MODE) { /* GFX9 */
+		REG_UPDATE(GRPH_CONTROL,
+			   GRPH_SW_MODE, DC_SW_LINEAR);
+	}
+
+	if (dce_mi->masks->GRPH_MICRO_TILE_MODE) { /* GFX8 */
+		REG_UPDATE(GRPH_CONTROL,
+			   GRPH_ARRAY_MODE, DC_SW_LINEAR);
+	}
+
+	if (dce_mi->masks->GRPH_ARRAY_MODE) { /* GFX6 but reuses gfx8 struct */
+		REG_UPDATE(GRPH_CONTROL,
+			   GRPH_ARRAY_MODE, DC_SW_LINEAR);
+	}
+}
+
 static void dce_mi_program_surface_config(
 	struct mem_input *mi,
 	enum surface_pixel_format format,
@@ -884,7 +904,8 @@ static const struct mem_input_funcs dce_mi_funcs = {
 	.mem_input_program_pte_vm = dce_mi_program_pte_vm,
 	.mem_input_program_surface_config =
 			dce_mi_program_surface_config,
-	.mem_input_is_flip_pending = dce_mi_is_flip_pending
+	.mem_input_is_flip_pending = dce_mi_is_flip_pending,
+	.mem_input_clear_tiling = dce_mi_clear_tiling,
 };
 
 #if defined(CONFIG_DRM_AMD_DC_SI)
@@ -897,7 +918,8 @@ static const struct mem_input_funcs dce60_mi_funcs = {
 	.mem_input_program_pte_vm = dce_mi_program_pte_vm,
 	.mem_input_program_surface_config =
 			dce60_mi_program_surface_config,
-	.mem_input_is_flip_pending = dce_mi_is_flip_pending
+	.mem_input_is_flip_pending = dce_mi_is_flip_pending,
+	.mem_input_clear_tiling = dce_mi_clear_tiling,
 };
 #endif
 
@@ -910,7 +932,8 @@ static const struct mem_input_funcs dce112_mi_funcs = {
 	.mem_input_program_pte_vm = dce_mi_program_pte_vm,
 	.mem_input_program_surface_config =
 			dce_mi_program_surface_config,
-	.mem_input_is_flip_pending = dce_mi_is_flip_pending
+	.mem_input_is_flip_pending = dce_mi_is_flip_pending,
+	.mem_input_clear_tiling = dce_mi_clear_tiling,
 };
 
 static const struct mem_input_funcs dce120_mi_funcs = {
@@ -922,7 +945,8 @@ static const struct mem_input_funcs dce120_mi_funcs = {
 	.mem_input_program_pte_vm = dce_mi_program_pte_vm,
 	.mem_input_program_surface_config =
 			dce_mi_program_surface_config,
-	.mem_input_is_flip_pending = dce_mi_is_flip_pending
+	.mem_input_is_flip_pending = dce_mi_is_flip_pending,
+	.mem_input_clear_tiling = dce_mi_clear_tiling,
 };
 
 void dce_mem_input_construct(
diff --git a/drivers/gpu/drm/amd/display/dc/inc/hw/mem_input.h b/drivers/gpu/drm/amd/display/dc/inc/hw/mem_input.h
index a8b44f398ce6..4f5d102455ca 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/hw/mem_input.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/hw/mem_input.h
@@ -187,6 +187,8 @@ struct mem_input_funcs {
 			const struct dc_cursor_position *pos,
 			const struct dc_cursor_mi_param *param);
 
+	void (*mem_input_clear_tiling)(
+		struct mem_input *mem_input);
 };
 
 #endif
-- 
2.47.0

