Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F320C52D6F
	for <amd-gfx@archiver.kernel.org>; Wed,  7 Aug 2024 07:56:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E3AB310E436;
	Wed,  7 Aug 2024 07:56:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="l/S97tNV";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2053.outbound.protection.outlook.com [40.107.93.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4750510E436
 for <amd-gfx@lists.freedesktop.org>; Wed,  7 Aug 2024 07:56:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tqCaiL/Cex0w4z06I9CdnENJqanLUGlyFjMPMDyd0Mf/oGc6D8dIGlTbM4ir3+LK6qi1GYHVyjSg1FyGcNEWrnwkl+wfHpGn/xXpOZ3E9g+F9J2SA01tjWg7gB5Ly6EZQxvAGeeMffSUkrIjrbSHiT3RB8EmqkpK6wIdjSshv3TEqfh57vSm5hZKq0tCs9T77aVmG19meBiRHhYKgJAJ36JRz/Z9ehM+wR+bwoltwisYGUznhH6aB4myz2GwKIwl5T768xbzUw9lgbzhPtk1JN4Qp5rKyfvKo0wHpujz7Jtdu9Qru0YfkztSvIAmA8Ideyvr37VwK3MqEIJ0YZEgxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+I2VnPO/dULpu8APDsq1J2t+MU0qAtwrMO9IHWNKJtQ=;
 b=uGHs73Gb2NWG23F+XUHqc0CnX2J+9sMZrEsIPiMJNIgW63nxHnbf91DiiuWb8ve6rt0U+yqG3NAQfrImz6ArwIQXmcOe00z+aw5SIgZnGZfyd+Ur5DoeHpn7jIc0CHt6FdQKBOzAKwP/CwGyRGOxdEvUtQhE878k1eXW8/zZ17uJ8Qe6evFcXRApEFo3KVd6CVxQH1nbGnAG0gY5I5wrdnfMhUagCI3x/B5b9xdFezLHXauf8NJ8+I/moj/gdEwQlf4XfM2EkdqWotCnx5OXfRZ5/FK4d2K8hO2g3zB149W2SKTWGiLN2GRKSwWJ2JZXP1VwCvj1v7ak+4WGDmaoiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+I2VnPO/dULpu8APDsq1J2t+MU0qAtwrMO9IHWNKJtQ=;
 b=l/S97tNVdlWGuV1Qcptcqc+FZWOs6C8Ioh7kGwPYZAr3joakiipI159KzJL4eYxygiH2h52Y7bla37gerPVAkVnpMHP37yIPpLtBG9fXXiKYNhoHIarVIDgnDWSE9/+0IKnX9zKnwmNU7UxmtcOOAHk5vB4ztOZ9y4uC/Czz1CI=
Received: from BN9PR03CA0602.namprd03.prod.outlook.com (2603:10b6:408:106::7)
 by MW4PR12MB7335.namprd12.prod.outlook.com (2603:10b6:303:22b::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.22; Wed, 7 Aug
 2024 07:56:04 +0000
Received: from BN2PEPF000044A9.namprd04.prod.outlook.com
 (2603:10b6:408:106:cafe::68) by BN9PR03CA0602.outlook.office365.com
 (2603:10b6:408:106::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.27 via Frontend
 Transport; Wed, 7 Aug 2024 07:56:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN2PEPF000044A9.mail.protection.outlook.com (10.167.243.103) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7849.8 via Frontend Transport; Wed, 7 Aug 2024 07:56:03 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 7 Aug
 2024 02:56:02 -0500
Received: from tom-r5.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Wed, 7 Aug 2024 02:55:59 -0500
From: Tom Chung <chiahsuan.chung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <jerry.zuo@amd.com>, <zaeem.mohamed@amd.com>, Relja Vojvodic
 <Relja.Vojvodic@amd.com>, Ilya Bakoulin <ilya.bakoulin@amd.com>
Subject: [PATCH 03/24] drm/amd/display: 3DLUT non-DMA refactor
Date: Wed, 7 Aug 2024 15:55:25 +0800
Message-ID: <20240807075546.831208-4-chiahsuan.chung@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240807075546.831208-1-chiahsuan.chung@amd.com>
References: <20240807075546.831208-1-chiahsuan.chung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: chiahsuan.chung@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A9:EE_|MW4PR12MB7335:EE_
X-MS-Office365-Filtering-Correlation-Id: 9943466e-55a7-4719-249a-08dcb6b662cb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?I0ogFyN83gYG9qL9kK5aIHgIsoSFuN9Er2fsLJ86wDIzo6KyomIEc0mJ2EyR?=
 =?us-ascii?Q?LILEvj2xY7aFswscKNPfUh2I6gnsdTWGq9+g0jymuiE9lLXJMacwKTHLJq9R?=
 =?us-ascii?Q?2thw4tnfgtAT4vtcJ3rTJhBaKCtHQAx6svSP2SSDjobFMYtnn/P5r8P4dVDM?=
 =?us-ascii?Q?F7h+u2KKBhkMWn5JvFTyB3TfiEkfyRb0SzU/qQb8f4UQvfNwxobhz3md/HHJ?=
 =?us-ascii?Q?hZbTh+RUnTztqnCPHYeLjwPVRi+/PIrEp3116Aa6IxcsgjU4E8jVzXeqsQD8?=
 =?us-ascii?Q?+o6tJ+9aQDZbhmTB2ualgvWAbahKvXDQJYY7HMkiBO8QXu8a8PDGyvun8PAm?=
 =?us-ascii?Q?8UpChn+V6x+xgraKZ+534kiD9oHntH+ZT3hnDJPM5js47NJezXAXC03AjqZk?=
 =?us-ascii?Q?uiCd1u0GlVYREZ96e3tMDcGc5IEv0g0ZCK8ceGJWWaFxFZbCGTtGF1T2lMcK?=
 =?us-ascii?Q?PS3RANZQUHUxqpybH73Rti8pnQU+alqA/VQh06XA6ht61i4pYLsX5lfK94DI?=
 =?us-ascii?Q?/H6z+6wdgej1yz7w8z3ys45lnn0wug9gGDNmL95R9+ZuPeIvPMV8PZa49ATc?=
 =?us-ascii?Q?qlbY34tftX7A1+mSEex/O8dCVybmRFfSEVGX7BbEkSaakVO0w7FOUplc3TxL?=
 =?us-ascii?Q?JtSZA15zU7IF1TAX1hkGqGlvtqVGLAekXvR7KcTzoK7rVPowXi3eH4weP5Jg?=
 =?us-ascii?Q?pDlqo23Dhi5vw8JSaHVYgfKL7y2fmNxytZ2z+OV8k6a8/Sq7T2mKmyR/HOlh?=
 =?us-ascii?Q?3dL3XtRVkt1nvBC6bFgJqOFOEoHYFHRLZ07YwVPxz5iDFR4+CkjGe7C3eeVk?=
 =?us-ascii?Q?2REP4WDmye2xmozYMeYmrSyzT1iUl0WZ64eoqZVKDntfScVLLT4YoD4q4oDR?=
 =?us-ascii?Q?he7/7rCwLno9LXVKqgUI2CJIlSfLibyYWJTXkTr9TGeHsOx50cTeJpkvO78u?=
 =?us-ascii?Q?1tw1XV8DBHasKF5y6RU4+MgQmIFyKtvqJpD06emm12CBUDcf2LXkc1LIGK1t?=
 =?us-ascii?Q?+XFWvrFjVdT5PfszweGxJc0GCCsmVvsAoWQA4I1KS6GituiOP9lDqLJ3qp+b?=
 =?us-ascii?Q?iF8LEurb/XxnZqKHSU8LM6E+47FPqf1DBbbeS2X2Tr767zuaOAcgVwN2ZHhK?=
 =?us-ascii?Q?KhgXNFXe5INW0ZRd6jID3hE0kZQhjw1x+8VvTFNTaC/6voBVX+2K7f56ZV14?=
 =?us-ascii?Q?ycznc0Ld1IFfYfsnwlaaC1RXSZAWW7HjnqOlg+ZcyKT8smSEQcbQp6FuLaHC?=
 =?us-ascii?Q?hEFW2xH443b0F9xf0Fe55ebVHtdhDaijXU/yLbOid2a/qf/+I/goD0cZEu2d?=
 =?us-ascii?Q?Z94K49EefBAgNzKOv6Saq364K5XLca9DNUJ2Ng/AkY+2PVIq79uE3rrONYAr?=
 =?us-ascii?Q?DesHs98T3ZoLeu81eBCIPEQc8BbBArMorUYABrcD2xJZG4w7zXkyiwxe4fiO?=
 =?us-ascii?Q?1oq5jGeo5554u10FuaGWgROrgq2+QOtf?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2024 07:56:03.6770 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9943466e-55a7-4719-249a-08dcb6b662cb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000044A9.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7335
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

From: Relja Vojvodic <Relja.Vojvodic@amd.com>

[Why]
Currently the handling for 3DLUT is found in multiple different
places, which causes issues when the different functions are not
in sync with each other.
Frequently bugs occur because the LUT handling is broken up, and
what has already been handled isn't kept track of well, which can
cause earlier changes to the LUT params to be overridden.

[How]
Remove DMA LUT handling from DCN401 and refactor legacy LUT
handling in one place to make it easier to keep track of what has
and needs to be done.

Reviewed-by: Ilya Bakoulin <ilya.bakoulin@amd.com>
Signed-off-by: Relja Vojvodic <Relja.Vojvodic@amd.com>
Signed-off-by: Tom Chung <chiahsuan.chung@amd.com>
---
 .../amd/display/dc/hwss/dcn32/dcn32_init.c    |  1 -
 .../amd/display/dc/hwss/dcn401/dcn401_hwseq.c | 46 ++++++++-----------
 .../amd/display/dc/hwss/dcn401/dcn401_init.c  |  2 +-
 3 files changed, 21 insertions(+), 28 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_init.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_init.c
index 968b010971ea..58bed01fc20e 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_init.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_init.c
@@ -162,7 +162,6 @@ static const struct hwseq_private_funcs dcn32_private_funcs = {
 	.is_dp_dig_pixel_rate_div_policy = dcn32_is_dp_dig_pixel_rate_div_policy,
 	.apply_single_controller_ctx_to_hw = dce110_apply_single_controller_ctx_to_hw,
 	.reset_back_end_for_pipe = dcn20_reset_back_end_for_pipe,
-	.populate_mcm_luts = dcn401_populate_mcm_luts,
 };
 
 void dcn32_hw_sequencer_init_functions(struct dc *dc)
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c
index 77489bbcda02..44c1184868e0 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c
@@ -670,46 +670,40 @@ bool dcn401_set_mcm_luts(struct pipe_ctx *pipe_ctx,
 	struct dpp *dpp_base = pipe_ctx->plane_res.dpp;
 	int mpcc_id = pipe_ctx->plane_res.hubp->inst;
 	struct mpc *mpc = pipe_ctx->stream_res.opp->ctx->dc->res_pool->mpc;
-	bool result = true;
+	bool result;
 	const struct pwl_params *lut_params = NULL;
 	bool rval;
 
 	mpc->funcs->set_movable_cm_location(mpc, MPCC_MOVABLE_CM_LOCATION_BEFORE, mpcc_id);
 	pipe_ctx->plane_state->mcm_location = MPCC_MOVABLE_CM_LOCATION_BEFORE;
 	// 1D LUT
-	if (plane_state->mcm_shaper_3dlut_setting == DC_CM2_SHAPER_3DLUT_SETTING_BYPASS_ALL) {
-		if (plane_state->blend_tf.type == TF_TYPE_HWPWL)
-			lut_params = &plane_state->blend_tf.pwl;
-		else if (plane_state->blend_tf.type == TF_TYPE_DISTRIBUTED_POINTS) {
-			rval = cm3_helper_translate_curve_to_hw_format(&plane_state->blend_tf,
-					&dpp_base->regamma_params, false);
-			lut_params = rval ? &dpp_base->regamma_params : NULL;
-		}
-		result = mpc->funcs->program_1dlut(mpc, lut_params, mpcc_id);
-		lut_params = NULL;
+	if (plane_state->blend_tf.type == TF_TYPE_HWPWL)
+		lut_params = &plane_state->blend_tf.pwl;
+	else if (plane_state->blend_tf.type == TF_TYPE_DISTRIBUTED_POINTS) {
+		rval = cm3_helper_translate_curve_to_hw_format(&plane_state->blend_tf,
+				&dpp_base->regamma_params, false);
+		lut_params = rval ? &dpp_base->regamma_params : NULL;
 	}
+	result = mpc->funcs->program_1dlut(mpc, lut_params, mpcc_id);
+	lut_params = NULL;
 
 	// Shaper
-	if (plane_state->mcm_shaper_3dlut_setting == DC_CM2_SHAPER_3DLUT_SETTING_BYPASS_ALL) {
-		if (plane_state->in_shaper_func.type == TF_TYPE_HWPWL)
-			lut_params = &plane_state->in_shaper_func.pwl;
-		else if (plane_state->in_shaper_func.type == TF_TYPE_DISTRIBUTED_POINTS) {
-			// TODO: dpp_base replace
-			ASSERT(false);
-			rval = cm3_helper_translate_curve_to_hw_format(&plane_state->in_shaper_func,
-					&dpp_base->shaper_params, true);
-			lut_params = rval ? &dpp_base->shaper_params : NULL;
-		}
-
-		result = mpc->funcs->program_shaper(mpc, lut_params, mpcc_id);
+	if (plane_state->in_shaper_func.type == TF_TYPE_HWPWL)
+		lut_params = &plane_state->in_shaper_func.pwl;
+	else if (plane_state->in_shaper_func.type == TF_TYPE_DISTRIBUTED_POINTS) {
+		// TODO: dpp_base replace
+		rval = cm3_helper_translate_curve_to_hw_format(&plane_state->in_shaper_func,
+				&dpp_base->shaper_params, true);
+		lut_params = rval ? &dpp_base->shaper_params : NULL;
 	}
+	result &= mpc->funcs->program_shaper(mpc, lut_params, mpcc_id);
 
 	// 3D
-	if (plane_state->mcm_shaper_3dlut_setting == DC_CM2_SHAPER_3DLUT_SETTING_BYPASS_ALL) {
+	if (mpc->funcs->program_3dlut) {
 		if (plane_state->lut3d_func.state.bits.initialized == 1)
-			result = mpc->funcs->program_3dlut(mpc, &plane_state->lut3d_func.lut_3d, mpcc_id);
+			result &= mpc->funcs->program_3dlut(mpc, &plane_state->lut3d_func.lut_3d, mpcc_id);
 		else
-			result = mpc->funcs->program_3dlut(mpc, NULL, mpcc_id);
+			result &= mpc->funcs->program_3dlut(mpc, NULL, mpcc_id);
 	}
 
 	return result;
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_init.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_init.c
index 457f4167e848..f4eda4a55ea7 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_init.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_init.c
@@ -136,7 +136,7 @@ static const struct hwseq_private_funcs dcn401_private_funcs = {
 	.calculate_dccg_k1_k2_values = NULL,
 	.apply_single_controller_ctx_to_hw = dce110_apply_single_controller_ctx_to_hw,
 	.reset_back_end_for_pipe = dcn20_reset_back_end_for_pipe,
-	.populate_mcm_luts = dcn401_populate_mcm_luts,
+	.populate_mcm_luts = NULL,
 };
 
 void dcn401_hw_sequencer_init_functions(struct dc *dc)
-- 
2.34.1

