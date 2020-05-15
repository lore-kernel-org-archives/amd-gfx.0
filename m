Return-Path: <SRS0=ENO8=65=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D487FC433E0
	for <amd-gfx@archiver.kernel.org>; Fri, 15 May 2020 18:14:08 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AA94920657
	for <amd-gfx@archiver.kernel.org>; Fri, 15 May 2020 18:14:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="xGbdqj50"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA94920657
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 634866ED33;
	Fri, 15 May 2020 18:14:08 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2061.outbound.protection.outlook.com [40.107.236.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 80E896ED2E
 for <amd-gfx@lists.freedesktop.org>; Fri, 15 May 2020 18:14:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z3gADDlicSnuqeinYshPD6UjgmOQHSgBTyniPxl5oKLi2sKnLcguoOR1D+NFvUih2Q1b4kzP3JkFDBTsXutii536JOHWzJv7AH3zuzisb8h0puc2eX0ZDmB9cUWYM0679CzOhFevd9R5xF0lylt0N1QCrZJbnfVZpIh7QEjua6MUW3vVCidpxKxiXVtNd9MOdxU2nRh9OStig91vy6kNdhCNAvxmeLB7U2Lwz06iLJJ23nJL6PRgTFReL585K1pi9uaCSnBkE/p/RnypZECNv+Qn/nTQOSUgb2GU1iHPXQfMHDUEsMKjCIPaXKvQtTDAOBMxIFEKKwtzEfUbR5580w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=23bN4KSsgSbSVxDTrs0W9+XWmV4ltZX3s8EmLYNcSg4=;
 b=JOpp4uNFv51fFvmqYQznSefKb+6fYTL8GfUVPOFsUZ6vlWX6PmWtCxqYRjLAggZPmnyF1Z57R201kOZA2i1vTwZG+G92KdaLW+FW1EM5JOrUJbTPoVGqvWhKTd3rYK20/loz2CJNIvXEdh4WxizrmeeMPdsJ1tRYQwGLyAl+0P0FNH1cidJL8io7pZgaTj5RkHeBoypxl8mb6a60SH63yaD0Ih+TB9JplV3B10VEBp7GkaCKnnKgQWhdFA1XtknaDSgtzfqZU/1PSv9gcLADQtnBxQ2hM6g4mWDqwr11nlFfWVjx+NSTWNwykBRA2lrR3zj0fIdnge4l17m+p3chmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=23bN4KSsgSbSVxDTrs0W9+XWmV4ltZX3s8EmLYNcSg4=;
 b=xGbdqj50+queBR8Xa96i6ihlprrjqKNeo8lgdWzZxB17VosqglFa/bIPeeNj1lSKznpHMNKv90XnZsuSW5z+Mjj5dcIsExMriq/LK3MEC1+ZuK+yrGq92+dtUrtuTOdpqZa25TxgkmndYQfqKq/UZC56EJlveZSzFt7tqcC28W8=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from CH2PR12MB4198.namprd12.prod.outlook.com (2603:10b6:610:7e::23)
 by CH2PR12MB3974.namprd12.prod.outlook.com (2603:10b6:610:2e::27)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.26; Fri, 15 May
 2020 18:14:03 +0000
Received: from CH2PR12MB4198.namprd12.prod.outlook.com
 ([fe80::812c:cc72:6d14:9580]) by CH2PR12MB4198.namprd12.prod.outlook.com
 ([fe80::812c:cc72:6d14:9580%9]) with mapi id 15.20.3000.022; Fri, 15 May 2020
 18:14:03 +0000
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 25/27] drm/amd/display: Remove nv12 work around
Date: Fri, 15 May 2020 14:13:12 -0400
Message-Id: <20200515181315.1237251-26-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200515181315.1237251-1-Rodrigo.Siqueira@amd.com>
References: <20200515181315.1237251-1-Rodrigo.Siqueira@amd.com>
X-ClientProxiedBy: BN7PR02CA0034.namprd02.prod.outlook.com
 (2603:10b6:408:20::47) To CH2PR12MB4198.namprd12.prod.outlook.com
 (2603:10b6:610:7e::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from atma2.hitronhub.home (2607:fea8:56a0:11a1::2) by
 BN7PR02CA0034.namprd02.prod.outlook.com (2603:10b6:408:20::47) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3000.20 via Frontend Transport; Fri, 15 May 2020 18:14:02 +0000
X-Mailer: git-send-email 2.26.2
X-Originating-IP: [2607:fea8:56a0:11a1::2]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: b709b893-ee86-469d-9dd4-08d7f8fbbf6b
X-MS-TrafficTypeDiagnostic: CH2PR12MB3974:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CH2PR12MB3974656FD460926FDCAC359798BD0@CH2PR12MB3974.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:221;
X-Forefront-PRVS: 04041A2886
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3JeeigM3QH7wuz+FSVOILiZ1PnfqJgSWlWh5Vh+eeTP3eR7zwg3kFzBqBW9wdWCztErEg/EJpyXl9qVmZSSAsuHqMpWIOxMUKRraLnq6E/Ul3FvgFA3d6DaCtoWlNXh9s93Oe00eb66q6NFhT7LPmtQwp7GcNnClGUav0g+mwJnd+/h9NYe4coR+num3PAPR0X3XhLQH++B3XyEiB98CDrHWGhNDShb910YRTNLfff44NE/H2VpU2FZZ851ahk3RXFCxDMQYJdmQ/lqvDVa27QQGE4vs5kDxsvb35b1qBeuSgVjBXrgsASrIcTcoxkW0N3mPr9Vo/b65FC/v5idaxMWZGydlMka4VYUk7/++HwHw/9jXaBVOLgNa/dM33JUrL+rPWcavrlt3sTaKyz3rU2RqzxeatXCJ0yQQujit/Y707MXYVQMccTyvU2wbYCbi
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB4198.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(346002)(376002)(366004)(396003)(136003)(39860400002)(6506007)(316002)(8676002)(8936002)(86362001)(6486002)(54906003)(6666004)(5660300002)(6916009)(478600001)(6512007)(2906002)(36756003)(66556008)(1076003)(52116002)(16526019)(186003)(2616005)(66476007)(66946007)(4326008);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: nJfI+gtRBSZZmpccJ1JqhDSjMnoxRrPxC5Zbu73G/wpK1U/RJSBHe0hhHz9rB4KJvkf7qESyO1utNNMRd9+bvhIVrnLU/lqxWAzdZZMe2n83C5bTmS+d0x3i6RsD52LJC1U+O8uOzWgNalc9fQSZYMdKqkkqhWpnOtfS68/VUcyfkgYOGllWOGK3MQWrsRXuhaaUxC+JDtLSRShNmsLnpNKMfJrZn4Z4ekt+BQD6jPdg5tI3rp7tbhfYj2HJG2uzaNGG1RFmOPuHGdoR7bETo3kxxSF2TxFAIY9S9Rd7HHnXJvH0qUdIPiz0/qa4iktVYrR0L6cB03jR5CTl3v0K8FzMsbWB5Z8GwQgsGmJRWb+/efnh7aKpF5lAjsiun8D2e5iwRcs3dWgiGaETAytVQkZhABcjrboms7YoEwUsO+1SQZ5yNMiOX99CHD/9uiHbjuulvAGmG0Up0uYSEERggSFsmrewN9gYlioE4lR2bCaYaF6bPKkTxebcsyHqjX+8
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b709b893-ee86-469d-9dd4-08d7f8fbbf6b
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2020 18:14:03.0584 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4boZgU27waCnI2SQ+Zk/xiwCtghvmM/OmLpSqdsCnm0zwXWla53PR2BD1kH3c3WaK2x8N6+gdwfiIBuN826RGg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB3974
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
Cc: Sunpeng.Li@amd.com, Harry.Wentland@amd.com, Rodrigo.Siqueira@amd.com,
 Aurabindo.Pillai@amd.com, Tony Cheng <Tony.Cheng@amd.com>,
 Yongqiang Sun <yongqiang.sun@amd.com>, Bhawanpreet.Lakha@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Yongqiang Sun <yongqiang.sun@amd.com>

[Why]
dal side nv12 wa has a lot of side effects.
KMD side wa is used, so this should be remove.

[How]
Removed wa from dal side.

Signed-off-by: Yongqiang Sun <yongqiang.sun@amd.com>
Reviewed-by: Tony Cheng <Tony.Cheng@amd.com>
Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 .../drm/amd/display/dc/core/dc_vm_helper.c    |   3 -
 drivers/gpu/drm/amd/display/dc/dc.h           |   1 -
 .../drm/amd/display/dc/dcn20/dcn20_hwseq.c    |   3 -
 .../gpu/drm/amd/display/dc/dcn21/dcn21_hubp.c | 121 +-----------------
 .../drm/amd/display/dc/dcn21/dcn21_resource.c |   1 -
 drivers/gpu/drm/amd/display/dc/inc/hw/hubp.h  |   3 -
 6 files changed, 2 insertions(+), 130 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_vm_helper.c b/drivers/gpu/drm/amd/display/dc/core/dc_vm_helper.c
index 64cf24a9ab08..f2b39ec35c89 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_vm_helper.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_vm_helper.c
@@ -47,9 +47,6 @@ int dc_setup_system_context(struct dc *dc, struct dc_phy_addr_space_config *pa_c
 		 */
 		memcpy(&dc->vm_pa_config, pa_config, sizeof(struct dc_phy_addr_space_config));
 		dc->vm_pa_config.valid = true;
-
-		if (pa_config->is_hvm_enabled == 0)
-			dc->debug.nv12_iflip_vm_wa = false;
 	}
 
 	return num_vmids;
diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index 391691c70805..11ac4b7ab174 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -471,7 +471,6 @@ struct dc_debug_options {
 	bool cm_in_bypass;
 	int force_clock_mode;/*every mode change.*/
 
-	bool nv12_iflip_vm_wa;
 	bool disable_dram_clock_change_vactive_support;
 	bool validate_dml_output;
 	bool enable_dmcub_surface_flip;
diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
index 258dcd33787e..26cac587c56b 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
@@ -1435,9 +1435,6 @@ static void dcn20_update_dchubp_dpp(
 		hubp->power_gated = false;
 	}
 
-	if (hubp->funcs->apply_PLAT_54186_wa && viewport_changed)
-		hubp->funcs->apply_PLAT_54186_wa(hubp, &plane_state->address);
-
 	if (pipe_ctx->update_flags.bits.enable || plane_state->update_flags.bits.addr_update)
 		hws->funcs.update_plane_addr(dc, pipe_ctx);
 
diff --git a/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_hubp.c b/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_hubp.c
index 960a0716dde5..f9045852728f 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_hubp.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_hubp.c
@@ -225,116 +225,6 @@ void hubp21_set_viewport(
 		  SEC_VIEWPORT_Y_START_C, viewport_c->y);
 }
 
-static void hubp21_apply_PLAT_54186_wa(
-		struct hubp *hubp,
-		const struct dc_plane_address *address)
-{
-	struct dcn21_hubp *hubp21 = TO_DCN21_HUBP(hubp);
-	struct dc_debug_options *debug = &hubp->ctx->dc->debug;
-	unsigned int chroma_bpe = 2;
-	unsigned int luma_addr_high_part = 0;
-	unsigned int row_height = 0;
-	unsigned int chroma_pitch = 0;
-	unsigned int viewport_c_height = 0;
-	unsigned int viewport_c_width = 0;
-	unsigned int patched_viewport_height = 0;
-	unsigned int patched_viewport_width = 0;
-	unsigned int rotation_angle = 0;
-	unsigned int pix_format = 0;
-	unsigned int h_mirror_en = 0;
-	unsigned int tile_blk_size = 64 * 1024; /* 64KB for 64KB SW, 4KB for 4KB SW */
-
-
-	if (!debug->nv12_iflip_vm_wa)
-		return;
-
-	REG_GET(DCHUBP_REQ_SIZE_CONFIG_C,
-		PTE_ROW_HEIGHT_LINEAR_C, &row_height);
-
-	REG_GET_2(DCSURF_PRI_VIEWPORT_DIMENSION_C,
-			PRI_VIEWPORT_WIDTH_C, &viewport_c_width,
-			PRI_VIEWPORT_HEIGHT_C, &viewport_c_height);
-
-	REG_GET(DCSURF_PRIMARY_SURFACE_ADDRESS_HIGH_C,
-			PRIMARY_SURFACE_ADDRESS_HIGH_C, &luma_addr_high_part);
-
-	REG_GET(DCSURF_SURFACE_PITCH_C,
-			PITCH_C, &chroma_pitch);
-
-	chroma_pitch += 1;
-
-	REG_GET_3(DCSURF_SURFACE_CONFIG,
-			SURFACE_PIXEL_FORMAT, &pix_format,
-			ROTATION_ANGLE, &rotation_angle,
-			H_MIRROR_EN, &h_mirror_en);
-
-	/* reset persistent cached data */
-	hubp21->PLAT_54186_wa_chroma_addr_offset = 0;
-	/* apply wa only for NV12 surface with scatter gather enabled with viewport > 512 along
-	 * the vertical direction*/
-	if (address->type != PLN_ADDR_TYPE_VIDEO_PROGRESSIVE ||
-			address->video_progressive.luma_addr.high_part == 0xf4)
-		return;
-
-	if ((rotation_angle == ROTATION_ANGLE_0 || rotation_angle == ROTATION_ANGLE_180)
-			&& viewport_c_height <= 512)
-		return;
-
-	if ((rotation_angle == ROTATION_ANGLE_90 || rotation_angle == ROTATION_ANGLE_270)
-				&& viewport_c_width <= 512)
-		return;
-
-	switch (rotation_angle) {
-	case ROTATION_ANGLE_0: /* 0 degree rotation */
-		row_height = 128;
-		patched_viewport_height = (viewport_c_height / row_height + 1) * row_height + 1;
-		patched_viewport_width = viewport_c_width;
-		hubp21->PLAT_54186_wa_chroma_addr_offset = 0;
-		break;
-	case ROTATION_ANGLE_180: /* 180 degree rotation */
-		row_height = 128;
-		patched_viewport_height = viewport_c_height + row_height;
-		patched_viewport_width = viewport_c_width;
-		hubp21->PLAT_54186_wa_chroma_addr_offset = 0 - chroma_pitch * row_height * chroma_bpe;
-		break;
-	case ROTATION_ANGLE_90: /* 90 degree rotation */
-		row_height = 256;
-		if (h_mirror_en) {
-			patched_viewport_height = viewport_c_height;
-			patched_viewport_width = viewport_c_width + row_height;
-			hubp21->PLAT_54186_wa_chroma_addr_offset = 0;
-		} else {
-			patched_viewport_height = viewport_c_height;
-			patched_viewport_width = viewport_c_width + row_height;
-			hubp21->PLAT_54186_wa_chroma_addr_offset = 0 - tile_blk_size;
-		}
-		break;
-	case ROTATION_ANGLE_270: /* 270 degree rotation */
-		row_height = 256;
-		if (h_mirror_en) {
-			patched_viewport_height = viewport_c_height;
-			patched_viewport_width = viewport_c_width + row_height;
-			hubp21->PLAT_54186_wa_chroma_addr_offset = 0 - tile_blk_size;
-		} else {
-			patched_viewport_height = viewport_c_height;
-			patched_viewport_width = viewport_c_width + row_height;
-			hubp21->PLAT_54186_wa_chroma_addr_offset = 0;
-		}
-		break;
-	default:
-		ASSERT(0);
-		break;
-	}
-
-	/* catch cases where viewport keep growing */
-	ASSERT(patched_viewport_height && patched_viewport_height < 5000);
-	ASSERT(patched_viewport_width && patched_viewport_width < 5000);
-
-	REG_UPDATE_2(DCSURF_PRI_VIEWPORT_DIMENSION_C,
-			PRI_VIEWPORT_WIDTH_C, patched_viewport_width,
-			PRI_VIEWPORT_HEIGHT_C, patched_viewport_height);
-}
-
 void hubp21_set_vm_system_aperture_settings(struct hubp *hubp,
 		struct vm_system_aperture_param *apt)
 {
@@ -812,8 +702,6 @@ bool hubp21_program_surface_flip_and_addr(
 		const struct dc_plane_address *address,
 		bool flip_immediate)
 {
-	struct dc_debug_options *debug = &hubp->ctx->dc->debug;
-	struct dcn21_hubp *hubp21 = TO_DCN21_HUBP(hubp);
 	struct surface_flip_registers flip_regs = { 0 };
 
 	flip_regs.vmid = address->vmid;
@@ -859,12 +747,8 @@ bool hubp21_program_surface_flip_and_addr(
 		flip_regs.DCSURF_PRIMARY_SURFACE_ADDRESS_HIGH =
 				address->video_progressive.luma_addr.high_part;
 
-		if (debug->nv12_iflip_vm_wa) {
-			flip_regs.DCSURF_PRIMARY_SURFACE_ADDRESS_C =
-					address->video_progressive.chroma_addr.low_part + hubp21->PLAT_54186_wa_chroma_addr_offset;
-		} else
-			flip_regs.DCSURF_PRIMARY_SURFACE_ADDRESS_C =
-					address->video_progressive.chroma_addr.low_part;
+		flip_regs.DCSURF_PRIMARY_SURFACE_ADDRESS_C =
+				address->video_progressive.chroma_addr.low_part;
 
 		flip_regs.DCSURF_PRIMARY_SURFACE_ADDRESS_HIGH_C =
 				address->video_progressive.chroma_addr.high_part;
@@ -942,7 +826,6 @@ static struct hubp_funcs dcn21_hubp_funcs = {
 	.set_blank = hubp1_set_blank,
 	.dcc_control = hubp1_dcc_control,
 	.mem_program_viewport = hubp21_set_viewport,
-	.apply_PLAT_54186_wa = hubp21_apply_PLAT_54186_wa,
 	.set_cursor_attributes	= hubp2_cursor_set_attributes,
 	.set_cursor_position	= hubp1_cursor_set_position,
 	.hubp_clk_cntl = hubp1_clk_cntl,
diff --git a/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c b/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c
index f00a56835084..00436654c584 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c
@@ -878,7 +878,6 @@ static const struct dc_debug_options debug_defaults_drv = {
 		.scl_reset_length10 = true,
 		.sanity_checks = true,
 		.disable_48mhz_pwrdwn = false,
-		.nv12_iflip_vm_wa = true,
 		.usbc_combo_phy_reset_wa = true
 };
 
diff --git a/drivers/gpu/drm/amd/display/dc/inc/hw/hubp.h b/drivers/gpu/drm/amd/display/dc/inc/hw/hubp.h
index 2cb8466e657b..efce08e4c0ca 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/hw/hubp.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/hw/hubp.h
@@ -104,9 +104,6 @@ struct hubp_funcs {
 			const struct rect *viewport,
 			const struct rect *viewport_c);
 
-	void (*apply_PLAT_54186_wa)(struct hubp *hubp,
-			const struct dc_plane_address *address);
-
 	bool (*hubp_program_surface_flip_and_addr)(
 		struct hubp *hubp,
 		const struct dc_plane_address *address,
-- 
2.26.2

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
