Return-Path: <SRS0=S2wj=5F=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D82A3C4332B
	for <amd-gfx@archiver.kernel.org>; Fri, 20 Mar 2020 15:11:55 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AD4242072D
	for <amd-gfx@archiver.kernel.org>; Fri, 20 Mar 2020 15:11:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="Oe+APTps"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD4242072D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4E8BF6E15C;
	Fri, 20 Mar 2020 15:11:55 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr770075.outbound.protection.outlook.com [40.107.77.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E6E106E18F
 for <amd-gfx@lists.freedesktop.org>; Fri, 20 Mar 2020 15:11:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K38ZTTMWJC2tBeB23Z4riXiyCuiZejeQTMk2wo1dZGtSXFYdkwsLSU6t9Kh9jib7ItdjWOzG7Kb7/DrVbETWC74JcK9ceLVwWxjh6u+WApKMvUNXd4XjSIqjlfOOCqkl2l5bjcRqCVxDd9/pVwt7pccLoApIfY40pa1owLzG4bUKqui6hw9W+Dea4Rk5HCOgbS15pVlM0lxRmsWHQIbhy63IcujMv9DY4qEy6a//uJEMsv2BFh6Z5m19Z+vaNpgOvy9LqboaFvOiuJI0UP+Wp+Jg5EqzemztW6Q5qSQc4pjGY62rskRJOBjyvDpfHM0y+JRcAqWvnIAvYlpn2aRKog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2pDyiy18bLBeIpMvhE/YYZ3fL3xQT2KVBn0TtC8eWZ8=;
 b=Dn2bQsjU6QMGJB1KZeL/T6pFcGpdgCF57cOTKZ4H/S/ue7f3973xo0PlGx5XcHZigPqNShiX+R4OAlvOBFiEYbxvlTfMGOgQfbNN7fXXVLJYWR0PVHV4OJHqv2Wo5z19/pQXJ8cmsJehUImXyvNVsvhNeV2p6D3P7Of1j17TZ99JWok3FxFZpmbCnU0an94Lnr91HAYpDgaQHJVfv9eAZ7GyVLLdwwW9cNxFxFsPprOB8nxAM/eTjyAJTZiTDWbPxQxJtd+fs9ygSxoPPkBtnFOySQ/00TsLiSDSzkjH0ve8fHjYCsTlZd0Bu+gTWZg4FVTqe7ExHDFO35aF8qNNJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2pDyiy18bLBeIpMvhE/YYZ3fL3xQT2KVBn0TtC8eWZ8=;
 b=Oe+APTpsWInVc2vFiPX5KDmZElmjWQa1MY5+TnyBeOpmJBw/twV8LZUPowvKkptokUlYq3OALmQpajdV7q6p9fhwyBcyR7Bh6tLWsdogqQnbux2Ckyrqb38hZ0gfKpOlGEovd77gR+1wGtx7Pdyq32vUZn4+6n/+iveEnpdIgKg=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Rodrigo.Siqueira@amd.com; 
Received: from MW2PR12MB2524.namprd12.prod.outlook.com (2603:10b6:907:9::27)
 by MW2PR12MB2572.namprd12.prod.outlook.com (2603:10b6:907:6::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2835.18; Fri, 20 Mar
 2020 15:11:53 +0000
Received: from MW2PR12MB2524.namprd12.prod.outlook.com
 ([fe80::91a7:e6f7:b17a:bfa5]) by MW2PR12MB2524.namprd12.prod.outlook.com
 ([fe80::91a7:e6f7:b17a:bfa5%6]) with mapi id 15.20.2814.021; Fri, 20 Mar 2020
 15:11:53 +0000
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 08/12] drm/amd/display: Support plane level CTM
Date: Fri, 20 Mar 2020 11:11:24 -0400
Message-Id: <20200320151128.2039940-9-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.25.2
In-Reply-To: <20200320151128.2039940-1-Rodrigo.Siqueira@amd.com>
References: <20200320151128.2039940-1-Rodrigo.Siqueira@amd.com>
X-ClientProxiedBy: YTXPR0101CA0055.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:1::32) To MW2PR12MB2524.namprd12.prod.outlook.com
 (2603:10b6:907:9::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from atma2.hitronhub.home (2607:fea8:56a0:11a1::4) by
 YTXPR0101CA0055.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:1::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2835.18 via Frontend
 Transport; Fri, 20 Mar 2020 15:11:52 +0000
X-Mailer: git-send-email 2.25.2
X-Originating-IP: [2607:fea8:56a0:11a1::4]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: cb39a778-eee1-4e50-49d9-08d7cce105ab
X-MS-TrafficTypeDiagnostic: MW2PR12MB2572:|MW2PR12MB2572:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MW2PR12MB257221C9CEDA7A88E4135BB798F50@MW2PR12MB2572.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:569;
X-Forefront-PRVS: 03484C0ABF
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(346002)(366004)(39860400002)(376002)(396003)(136003)(199004)(81156014)(66556008)(6506007)(54906003)(4326008)(16526019)(2906002)(8936002)(186003)(81166006)(52116002)(2616005)(1076003)(8676002)(86362001)(66476007)(316002)(66946007)(6666004)(6486002)(36756003)(5660300002)(6512007)(6916009)(478600001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MW2PR12MB2572;
 H:MW2PR12MB2524.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: x+/ulXa/QOWFsPsZLFVee0DQqxez3CabPIwE3iQXhmiJIPG90IJ7T1aM7UqhmTEfpeVDvY1R9nm5mogGIZEC9Is5uZXlmC1RF74Mnkiamz9aJT3BOVwR045/VQSR8Q/uDnCMKKWrZaQl0/i3hkEjM962D8/NnjgYYSVlNt+4k9Z5A7reigCpIqTCJLRVFDJcF2k25tOyZUCIxE45YMMaAqeRtgYbSFhPE2/QZGPoW4LvE+v7m1ogg6dX76GjdLd5+YJxTScWCPPs8UaFSi58Ub+gp2F7J53tKPKNetV2K880mJ2Mu29IsDZVqJYqUXCjXZHhcgg1zWn2FVOKQKUvMogLFUU8fqT4AZWX3G3QPFef+DRTt4PB0Dz1NecpJsg3rm+ZVsHeJellGpKToGkz9lqXzYbDwAcIc5lJl7qUTUcovWjcY+3BqVOWY6mdEUaG
X-MS-Exchange-AntiSpam-MessageData: osQV+JulxPbSjiDhz8TeR3xge7PBp7zqG1YpUw57yli/xnWUN1vPEwihqBrLpZqTajweDF3ZoorgVl3lflt8BYBF/Ke3GEmbDmPkRGqGgWqVmIJh06tdrnus/hhZyJZwJRlkqjqnfbAjmrfZLtToSwAwZygpuaikgwohsdHuPgY=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cb39a778-eee1-4e50-49d9-08d7cce105ab
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2020 15:11:53.2623 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fMl5dptWPf95MvON4bqzZLGISh3xHdfjcY8jbrETfvlbszXHYbjqeylHnQjfx+kdhc/Ael7Rm8on2RENbsba9A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR12MB2572
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
 Stylon Wang <stylon.wang@amd.com>, Harry.Wentland@amd.com,
 Nicholas Kazlauskas <Nicholas.Kazlauskas@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Stylon Wang <stylon.wang@amd.com>

[Why]
CTM was only supported at CRTC level and we need color space conversion
in linear space at plane level.

[How]
- Add plane-level CTM to dc interface
- Program plane-level CTM in DCN

Signed-off-by: Stylon Wang <stylon.wang@amd.com>
Reviewed-by: Nicholas Kazlauskas <Nicholas.Kazlauskas@amd.com>
Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc.c               | 10 +++++++++-
 drivers/gpu/drm/amd/display/dc/dc.h                    |  3 +++
 .../gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c  |  6 ++++++
 3 files changed, 18 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index 1a2c2e3dd6d2..f21bbb295ad3 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -1726,6 +1726,9 @@ static enum surface_update_type det_surface_update(const struct dc *dc,
 	if (u->coeff_reduction_factor)
 		update_flags->bits.coeff_reduction_change = 1;
 
+	if (u->gamut_remap_matrix)
+		update_flags->bits.gamut_remap_change = 1;
+
 	if (u->gamma) {
 		enum surface_pixel_format format = SURFACE_PIXEL_FORMAT_GRPH_BEGIN;
 
@@ -1751,7 +1754,8 @@ static enum surface_update_type det_surface_update(const struct dc *dc,
 
 	if (update_flags->bits.input_csc_change
 			|| update_flags->bits.coeff_reduction_change
-			|| update_flags->bits.gamma_change) {
+			|| update_flags->bits.gamma_change
+			|| update_flags->bits.gamut_remap_change) {
 		type = UPDATE_TYPE_FULL;
 		elevate_update_type(&overall_type, type);
 	}
@@ -1996,6 +2000,10 @@ static void copy_surface_update_to_plane(
 	if (srf_update->coeff_reduction_factor)
 		surface->coeff_reduction_factor =
 			*srf_update->coeff_reduction_factor;
+
+	if (srf_update->gamut_remap_matrix)
+		surface->gamut_remap_matrix =
+			*srf_update->gamut_remap_matrix;
 }
 
 static void copy_stream_update_to_stream(struct dc *dc,
diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index 52c7c06d1fde..92123b0d1196 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -726,6 +726,7 @@ union surface_update_flags {
 		uint32_t output_tf_change:1;
 		uint32_t pixel_format_change:1;
 		uint32_t plane_size_change:1;
+		uint32_t gamut_remap_change:1;
 
 		/* Full updates */
 		uint32_t new_plane:1;
@@ -760,6 +761,7 @@ struct dc_plane_state {
 	struct dc_csc_transform input_csc_color_matrix;
 	struct fixed31_32 coeff_reduction_factor;
 	struct fixed31_32 hdr_mult;
+	struct colorspace_transform gamut_remap_matrix;
 
 	// TODO: No longer used, remove
 	struct dc_hdr_static_metadata hdr_static_ctx;
@@ -839,6 +841,7 @@ struct dc_surface_update {
 	const struct dc_transfer_func *func_shaper;
 	const struct dc_3dlut *lut3d_func;
 	const struct dc_transfer_func *blend_tf;
+	const struct colorspace_transform *gamut_remap_matrix;
 };
 
 /*
diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
index 9cc3314966bd..0be010085575 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
@@ -2004,6 +2004,12 @@ void dcn10_program_gamut_remap(struct pipe_ctx *pipe_ctx)
 		for (i = 0; i < CSC_TEMPERATURE_MATRIX_SIZE; i++)
 			adjust.temperature_matrix[i] =
 				pipe_ctx->stream->gamut_remap_matrix.matrix[i];
+	} else if (pipe_ctx->plane_state &&
+		   pipe_ctx->plane_state->gamut_remap_matrix.enable_remap == true) {
+		adjust.gamut_adjust_type = GRAPHICS_GAMUT_ADJUST_TYPE_SW;
+		for (i = 0; i < CSC_TEMPERATURE_MATRIX_SIZE; i++)
+			adjust.temperature_matrix[i] =
+				pipe_ctx->plane_state->gamut_remap_matrix.matrix[i];
 	}
 
 	pipe_ctx->plane_res.dpp->funcs->dpp_set_gamut_remap(pipe_ctx->plane_res.dpp, &adjust);
-- 
2.25.2

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
