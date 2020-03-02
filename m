Return-Path: <SRS0=ZiRI=4T=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B922C3F2D1
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Mar 2020 16:48:03 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 60A5521D56
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Mar 2020 16:48:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="hcYdmMy/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 60A5521D56
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F25546E5BB;
	Mon,  2 Mar 2020 16:48:02 +0000 (UTC)
Received: from NAM02-BL2-obe.outbound.protection.outlook.com
 (mail-eopbgr750089.outbound.protection.outlook.com [40.107.75.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 10D9F6E5AE
 for <amd-gfx@lists.freedesktop.org>; Mon,  2 Mar 2020 16:48:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SEuMrv8ms1ybl13FYi5UeY3MBaU/7gSseOlkGgdtBhUID6OBCm3t3EdQDsTFi0QSB+ci0iengpD5nQHdPoL87VrMls/fRGkCCEoOsmf9eAdgLF5f3bOsB6yTZXI8QKiWsqkkdVAuaVI5fzLScQ9/wmbP7DFL9ALIL8d1/wpU5wdeCOtoFv/fQs50cwHqz05nBNB4H3aVr/hMBmBXt72mTnQTWvsR4QsRNHOUTQWFs8R67dRi2FCJKPs/wtu+hjE/QBsrJ4jatn5D6mJNQ3GXUOKxfYIZQcnzpupTvvmCCsxsx9HxRW2ebYK9JyLbRKu9XGV2hadwl8GmV3DasnTmgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TZZlKCGRHxW+qHPOQsTPsGlB/jZTtJLe1KoGEVGHr1U=;
 b=I974ECt/an9/JN+BcDkG9kXZwnmGY6zR2NxJ/y4iuKTaagr32bCmq8DpRyHA0yXLjo2xLbnNxM2z6x0Z8ZTcalRha+9/TGjwMcjizOGdKQvKC1jmaZTF/5BNJtOGBwMv5oNf4gQ8aISgpy6Q7Qx3eHW3rgpy1FB/3FOr6xpbrtzEmgQuQvQHCLGxiZoYstZwr8Tp/jKvCXgjCK5Eq31OnuaoaZWTdUWO3c+aC/1oEEnx25ovvRxzpxoLEUssK1UcoG0du9s/hMfCUvadJpAlBQLW7nPbBlbY56Oc3zJGfipG2vSCrFXrv6zbl6kpzCl1okHIzZ/nY6WLq7u1QEoz+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TZZlKCGRHxW+qHPOQsTPsGlB/jZTtJLe1KoGEVGHr1U=;
 b=hcYdmMy/igbNvHCeRf9/cV+I2yeQ76pXD2DoM9EUiE1uRcqcVowrVmk2/KqaZPIGE2ElLGifUE2txH0E4YHIxc0pfBQX51aVnIaUg4ewN4AxOdHcSoLg10ccOnNfmAcj3HMy6Vngu87XYVXLFDW2UI6f+qhzYo9K3VGTnxQlmEs=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Rodrigo.Siqueira@amd.com; 
Received: from MW2PR12MB2524.namprd12.prod.outlook.com (2603:10b6:907:9::27)
 by MW2PR12MB2411.namprd12.prod.outlook.com (2603:10b6:907:10::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2772.19; Mon, 2 Mar
 2020 16:47:58 +0000
Received: from MW2PR12MB2524.namprd12.prod.outlook.com
 ([fe80::91a7:e6f7:b17a:bfa5]) by MW2PR12MB2524.namprd12.prod.outlook.com
 ([fe80::91a7:e6f7:b17a:bfa5%6]) with mapi id 15.20.2772.019; Mon, 2 Mar 2020
 16:47:58 +0000
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 09/22] drm/amd/display: program DPG_OFFSET_SEGMENT for odm_pipe
Date: Mon,  2 Mar 2020 11:47:23 -0500
Message-Id: <20200302164736.89429-10-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200302164736.89429-1-Rodrigo.Siqueira@amd.com>
References: <20200302164736.89429-1-Rodrigo.Siqueira@amd.com>
X-ClientProxiedBy: YTBPR01CA0021.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:14::34) To MW2PR12MB2524.namprd12.prod.outlook.com
 (2603:10b6:907:9::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from atma2.amd.com (165.204.55.250) by
 YTBPR01CA0021.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:14::34) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2772.14 via Frontend Transport; Mon, 2 Mar 2020 16:47:57 +0000
X-Mailer: git-send-email 2.25.1
X-Originating-IP: [165.204.55.250]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 9c416a1d-1b07-4e7b-e864-08d7bec97649
X-MS-TrafficTypeDiagnostic: MW2PR12MB2411:|MW2PR12MB2411:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MW2PR12MB241170D26FDC2A881A34E5AD98E70@MW2PR12MB2411.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-Forefront-PRVS: 033054F29A
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(39860400002)(396003)(346002)(136003)(376002)(366004)(199004)(189003)(66946007)(6916009)(6666004)(54906003)(8676002)(316002)(4326008)(66556008)(478600001)(36756003)(66476007)(8936002)(2616005)(1076003)(956004)(81156014)(186003)(81166006)(16526019)(86362001)(2906002)(52116002)(7696005)(26005)(6486002)(5660300002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MW2PR12MB2411;
 H:MW2PR12MB2524.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TIU3UhHT20tLKtgyntG9NzMgBzlI9XEaLm9QeaECQoe7Ru3OotyJQH4XyGeS04uwsCq4TiqMF9rbmAlUhV/ZLjTx8I3NoSyidArpy7VglMefc6/1VegNDmI9xvCre3FL/v862hYJyDa7bd/Dlg/PighKGC1UY6Fqyl02GIu1+lbjim2M+a4EqxhKotCt2v0jpS3+Wx5e6xzo+vNmgs+hVPuMpqqILkfmAPqnoZcce+vrrJg61VYxLn4X0aQhRhvAt7m8Dtk/UMM3SgzKW6KPhUyYHSSRKyXch3/IWjWPQwsHsNSK9+xUFL+GKGt0CqSgr1apuDhqzSWwSvd2c5luAiyq56jvaWZ2slAYuASemZcATsRzn8L45F+iuQopHpovzL5bqlpBrRvm6HPC9GdJVkkSmtHRrplDpPQWgBeXpvpxlebMmEAfzfeflppep9dk
X-MS-Exchange-AntiSpam-MessageData: DYcOvC+3CHohX+813YaSpAmGxSQj2ZRuyMBvqwrrfDodS2u1G3Z438VpiGLEn0t1ixSKppZGvyJ03tKls8+b1o1ZTTZxPWXMxye5ldp7Qw5wwhu1Km9sB+aA7nUx72FIlZGxJBBwBZWVQ7XLWuQmTg==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c416a1d-1b07-4e7b-e864-08d7bec97649
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Mar 2020 16:47:58.1291 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: x9t4jJUN4ASsIOl23llzwZzTvhfPuTlGzRPsWnfQ0Od1vr/CMw2SG31l3KW+T1aYFWg0zge8i6qwlG0kHl05pA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR12MB2411
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
 Nikola Cornij <Nikola.Cornij@amd.com>, Wenjing Liu <Wenjing.Liu@amd.com>,
 Bhawanpreet.Lakha@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Wenjing Liu <Wenjing.Liu@amd.com>

[why]
When test pattern is enabled with ODM combine, test pattern is generated
by piecing multiple DPGs image together.  The current code will program
all DPGs with horizontal offset of 0. This will cause all DPGs to output
the beginning of the pattern. Instead each DPG should program a
horizontal offset of its x position to form a continous pattern when
pieced together.

Signed-off-by: Wenjing Liu <Wenjing.Liu@amd.com>
Reviewed-by: Nikola Cornij <Nikola.Cornij@amd.com>
Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 .../gpu/drm/amd/display/dc/core/dc_link_dp.c  | 40 +++++++++++--------
 .../drm/amd/display/dc/dcn20/dcn20_hwseq.c    | 12 ++++--
 .../gpu/drm/amd/display/dc/dcn20/dcn20_opp.c  |  8 +++-
 .../gpu/drm/amd/display/dc/dcn20/dcn20_opp.h  |  9 ++++-
 drivers/gpu/drm/amd/display/dc/inc/hw/opp.h   |  3 +-
 5 files changed, 49 insertions(+), 23 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
index c81f55b28497..bf5406eaf7b7 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
@@ -3720,6 +3720,8 @@ static void set_crtc_test_pattern(struct dc_link *link,
 			struct pipe_ctx *odm_pipe;
 			enum controller_dp_color_space controller_color_space;
 			int opp_cnt = 1;
+			int offset = 0;
+			int dpg_width = width;
 
 			switch (test_pattern_color_space) {
 			case DP_TEST_PATTERN_COLOR_SPACE_RGB:
@@ -3741,28 +3743,31 @@ static void set_crtc_test_pattern(struct dc_link *link,
 
 			for (odm_pipe = pipe_ctx->next_odm_pipe; odm_pipe; odm_pipe = odm_pipe->next_odm_pipe)
 				opp_cnt++;
+			dpg_width = width / opp_cnt;
+			offset = dpg_width;
 
-			width /= opp_cnt;
+			opp->funcs->opp_set_disp_pattern_generator(opp,
+				controller_test_pattern,
+				controller_color_space,
+				color_depth,
+				NULL,
+				dpg_width,
+				height,
+				0);
 
 			for (odm_pipe = pipe_ctx->next_odm_pipe; odm_pipe; odm_pipe = odm_pipe->next_odm_pipe) {
 				struct output_pixel_processor *odm_opp = odm_pipe->stream_res.opp;
-
 				odm_opp->funcs->opp_program_bit_depth_reduction(odm_opp, &params);
 				odm_opp->funcs->opp_set_disp_pattern_generator(odm_opp,
 					controller_test_pattern,
 					controller_color_space,
 					color_depth,
 					NULL,
-					width,
-					height);
+					dpg_width,
+					height,
+					offset);
+				offset += offset;
 			}
-			opp->funcs->opp_set_disp_pattern_generator(opp,
-				controller_test_pattern,
-				controller_color_space,
-				color_depth,
-				NULL,
-				width,
-				height);
 		}
 	}
 	break;
@@ -3779,11 +3784,12 @@ static void set_crtc_test_pattern(struct dc_link *link,
 		else if (opp->funcs->opp_set_disp_pattern_generator) {
 			struct pipe_ctx *odm_pipe;
 			int opp_cnt = 1;
+			int dpg_width = width;
 
 			for (odm_pipe = pipe_ctx->next_odm_pipe; odm_pipe; odm_pipe = odm_pipe->next_odm_pipe)
 				opp_cnt++;
 
-			width /= opp_cnt;
+			dpg_width = width / opp_cnt;
 			for (odm_pipe = pipe_ctx->next_odm_pipe; odm_pipe; odm_pipe = odm_pipe->next_odm_pipe) {
 				struct output_pixel_processor *odm_opp = odm_pipe->stream_res.opp;
 
@@ -3793,16 +3799,18 @@ static void set_crtc_test_pattern(struct dc_link *link,
 					CONTROLLER_DP_COLOR_SPACE_UDEFINED,
 					color_depth,
 					NULL,
-					width,
-					height);
+					dpg_width,
+					height,
+					0);
 			}
 			opp->funcs->opp_set_disp_pattern_generator(opp,
 				CONTROLLER_DP_TEST_PATTERN_VIDEOMODE,
 				CONTROLLER_DP_COLOR_SPACE_UDEFINED,
 				color_depth,
 				NULL,
-				width,
-				height);
+				dpg_width,
+				height,
+				0);
 		}
 	}
 	break;
diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
index 97c0c8ced8e5..49f5af9e3016 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
@@ -307,7 +307,8 @@ void dcn20_init_blank(
 			COLOR_DEPTH_UNDEFINED,
 			&black_color,
 			otg_active_width,
-			otg_active_height);
+			otg_active_height,
+			0);
 
 	if (num_opps == 2) {
 		bottom_opp->funcs->opp_set_disp_pattern_generator(
@@ -317,7 +318,8 @@ void dcn20_init_blank(
 				COLOR_DEPTH_UNDEFINED,
 				&black_color,
 				otg_active_width,
-				otg_active_height);
+				otg_active_height,
+				0);
 	}
 
 	hws->funcs.wait_for_blank_complete(opp);
@@ -974,7 +976,8 @@ void dcn20_blank_pixel_data(
 			stream->timing.display_color_depth,
 			&black_color,
 			width,
-			height);
+			height,
+			0);
 
 	for (odm_pipe = pipe_ctx->next_odm_pipe; odm_pipe; odm_pipe = odm_pipe->next_odm_pipe) {
 		odm_pipe->stream_res.opp->funcs->opp_set_disp_pattern_generator(
@@ -985,7 +988,8 @@ void dcn20_blank_pixel_data(
 				stream->timing.display_color_depth,
 				&black_color,
 				width,
-				height);
+				height,
+				0);
 	}
 
 	if (!blank)
diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_opp.c b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_opp.c
index 023cc71fad0f..138321e151eb 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_opp.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_opp.c
@@ -45,7 +45,8 @@ void opp2_set_disp_pattern_generator(
 		enum dc_color_depth color_depth,
 		const struct tg_color *solid_color,
 		int width,
-		int height)
+		int height,
+		int offset)
 {
 	struct dcn20_opp *oppn20 = TO_DCN20_OPP(opp);
 	enum test_pattern_color_format bit_depth;
@@ -92,6 +93,11 @@ void opp2_set_disp_pattern_generator(
 		DPG_ACTIVE_WIDTH, width,
 		DPG_ACTIVE_HEIGHT, height);
 
+	/* set DPG offset */
+	REG_SET_2(DPG_OFFSET_SEGMENT, 0,
+		DPG_X_OFFSET, offset,
+		DPG_SEGMENT_WIDTH, 0);
+
 	switch (test_pattern) {
 	case CONTROLLER_DP_TEST_PATTERN_COLORSQUARES:
 	case CONTROLLER_DP_TEST_PATTERN_COLORSQUARES_CEA:
diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_opp.h b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_opp.h
index 4093bec172c1..64c5b429c79a 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_opp.h
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_opp.h
@@ -36,6 +36,7 @@
 #define OPP_DPG_REG_LIST(id) \
 	SRI(DPG_CONTROL, DPG, id), \
 	SRI(DPG_DIMENSIONS, DPG, id), \
+	SRI(DPG_OFFSET_SEGMENT, DPG, id), \
 	SRI(DPG_COLOUR_B_CB, DPG, id), \
 	SRI(DPG_COLOUR_G_Y, DPG, id), \
 	SRI(DPG_COLOUR_R_CR, DPG, id), \
@@ -53,6 +54,7 @@
 	uint32_t FMT_422_CONTROL; \
 	uint32_t DPG_CONTROL; \
 	uint32_t DPG_DIMENSIONS; \
+	uint32_t DPG_OFFSET_SEGMENT; \
 	uint32_t DPG_COLOUR_B_CB; \
 	uint32_t DPG_COLOUR_G_Y; \
 	uint32_t DPG_COLOUR_R_CR; \
@@ -68,6 +70,8 @@
 	OPP_SF(DPG0_DPG_CONTROL, DPG_HRES, mask_sh), \
 	OPP_SF(DPG0_DPG_DIMENSIONS, DPG_ACTIVE_WIDTH, mask_sh), \
 	OPP_SF(DPG0_DPG_DIMENSIONS, DPG_ACTIVE_HEIGHT, mask_sh), \
+	OPP_SF(DPG0_DPG_OFFSET_SEGMENT, DPG_X_OFFSET, mask_sh), \
+	OPP_SF(DPG0_DPG_OFFSET_SEGMENT, DPG_SEGMENT_WIDTH, mask_sh), \
 	OPP_SF(DPG0_DPG_COLOUR_R_CR, DPG_COLOUR0_R_CR, mask_sh), \
 	OPP_SF(DPG0_DPG_COLOUR_R_CR, DPG_COLOUR1_R_CR, mask_sh), \
 	OPP_SF(DPG0_DPG_COLOUR_B_CB, DPG_COLOUR0_B_CB, mask_sh), \
@@ -97,6 +101,8 @@
 	type DPG_HRES; \
 	type DPG_ACTIVE_WIDTH; \
 	type DPG_ACTIVE_HEIGHT; \
+	type DPG_X_OFFSET; \
+	type DPG_SEGMENT_WIDTH; \
 	type DPG_COLOUR0_R_CR; \
 	type DPG_COLOUR1_R_CR; \
 	type DPG_COLOUR0_B_CB; \
@@ -144,7 +150,8 @@ void opp2_set_disp_pattern_generator(
 	enum dc_color_depth color_depth,
 	const struct tg_color *solid_color,
 	int width,
-	int height);
+	int height,
+	int offset);
 
 bool opp2_dpg_is_blanked(struct output_pixel_processor *opp);
 
diff --git a/drivers/gpu/drm/amd/display/dc/inc/hw/opp.h b/drivers/gpu/drm/amd/display/dc/inc/hw/opp.h
index 7575564b2265..2717352eb697 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/hw/opp.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/hw/opp.h
@@ -310,7 +310,8 @@ struct opp_funcs {
 			enum dc_color_depth color_depth,
 			const struct tg_color *solid_color,
 			int width,
-			int height);
+			int height,
+			int offset);
 
 	bool (*dpg_is_blanked)(
 			struct output_pixel_processor *opp);
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
