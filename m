Return-Path: <SRS0=B7jy=6A=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E44BBC2BA2B
	for <amd-gfx@archiver.kernel.org>; Thu, 16 Apr 2020 23:41:26 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BA0B421841
	for <amd-gfx@archiver.kernel.org>; Thu, 16 Apr 2020 23:41:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="m8VRJaIo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA0B421841
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C61456E201;
	Thu, 16 Apr 2020 23:41:25 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on20620.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe59::620])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3FFBA6E201
 for <amd-gfx@lists.freedesktop.org>; Thu, 16 Apr 2020 23:41:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cfSGgmGlTG3bxphuoLph8UU2ucTZAkkUrHnoFizYpELxzL95MSddCcCLT2x8VZ86hQ9JVePDl0U8x6LmxyCK1dHUB1WopZ7xHFB9beZ216q6KyILV6XpaVaogfP81uhfZ7g/Rwz/hfPf9UmJcGHlamYVcv/ItLhblz1QQiz9SdwVFoSJ3djh5l5Ajl4hRsI9mqnxq6MNaX8wzU9VtI+BLawlYdCHLtZiq/GSXioOL01U6rjzHm2nF0HmC8L/v4VmqqWJe7N78Jh+Cblcgy7Ml4yuaRRfvZdz5MSoUqu1F+KYPPr5TO4z4g9BofvUHSO8OIsCEzXXKqpc58DH1tvTDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LMS4+j84bTXDF2vL0PC9Vx0eLMTDGtUpfuSjbuMbXyg=;
 b=L6WamHBOTgaCtLn1M/A5Dk7GV0zYbAY7zjGM9Mggko1XO7q4BAByp3FKpI1Wox1n5Ho5nSE+ZdUldFCbrMP9CUr5jZRCCA3xQhUhv2te+ZbUSkOmNKqGLjvaZH90bpc/A0HeFZxoxxCZ+EhXoJhNDKg8hm+jQpedzfad5uwpw+vQ0rpkOwYaEFUIDom37KVBe3e3qZxubxAUTkjbgG3nehx+yCsHoNFcU42VSmOpIpvTsmFaZCi0UjZKSXm5mPHoGJHepxQl+zXCp/cUrbbw+cK13HdtBBSGoiUIOilqyMO1aM/1WBP8cnru6u6vQdouR3qfTq36imhuxCoMXdXDyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LMS4+j84bTXDF2vL0PC9Vx0eLMTDGtUpfuSjbuMbXyg=;
 b=m8VRJaIoJPhrG7RTaZMLiuejWYJCXp7Z845j69G3vdsJCojSddT2TajYpMf6dFWKsZ6ZlHacDG7lHxfykCY/RWMViLZupW9PHAlwalUulYR6Q07Atxkt9bidct8Nt37jqr85s9d+l+dEpjgbB7HujEH1NNw4dny2TcIPtZqazQE=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Rodrigo.Siqueira@amd.com; 
Received: from MW2PR12MB2524.namprd12.prod.outlook.com (2603:10b6:907:9::27)
 by MW2PR12MB2459.namprd12.prod.outlook.com (2603:10b6:907:c::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2900.15; Thu, 16 Apr
 2020 23:41:24 +0000
Received: from MW2PR12MB2524.namprd12.prod.outlook.com
 ([fe80::91a7:e6f7:b17a:bfa5]) by MW2PR12MB2524.namprd12.prod.outlook.com
 ([fe80::91a7:e6f7:b17a:bfa5%6]) with mapi id 15.20.2921.027; Thu, 16 Apr 2020
 23:41:24 +0000
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 11/35] drm/amd/display: add optc get crc support for timings
 with ODM/DSC
Date: Thu, 16 Apr 2020 19:40:20 -0400
Message-Id: <20200416234044.2082886-12-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200416234044.2082886-1-Rodrigo.Siqueira@amd.com>
References: <20200416234044.2082886-1-Rodrigo.Siqueira@amd.com>
X-ClientProxiedBy: BN8PR12CA0012.namprd12.prod.outlook.com
 (2603:10b6:408:60::25) To MW2PR12MB2524.namprd12.prod.outlook.com
 (2603:10b6:907:9::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from atma2.hitronhub.home (2607:fea8:56a0:11a1::2) by
 BN8PR12CA0012.namprd12.prod.outlook.com (2603:10b6:408:60::25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2921.25 via Frontend Transport; Thu, 16 Apr 2020 23:41:22 +0000
X-Mailer: git-send-email 2.26.0
X-Originating-IP: [2607:fea8:56a0:11a1::2]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 07fe6d40-6729-465e-9c9e-08d7e25fac65
X-MS-TrafficTypeDiagnostic: MW2PR12MB2459:|MW2PR12MB2459:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MW2PR12MB245969469C9F145CC0C5DE1398D80@MW2PR12MB2459.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4502;
X-Forefront-PRVS: 0375972289
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW2PR12MB2524.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10009020)(4636009)(346002)(136003)(376002)(396003)(366004)(39860400002)(316002)(2906002)(54906003)(36756003)(6916009)(6486002)(1076003)(478600001)(86362001)(81156014)(8676002)(8936002)(6512007)(66476007)(66556008)(66946007)(2616005)(5660300002)(16526019)(186003)(6506007)(4326008)(52116002);
 DIR:OUT; SFP:1101; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9mmE2fQBKs9VzE+vbatXaP6BbRrTd8OyneP8pMrHLaTBJa5dhuh2BRrvYheLw/vNBfPvEa8ls4cngdMqXDMAXsxeTeqswdSRiLz39TgUlvKbxDwz8ol4nn3Yrw0861KCBafGxljshy8zU9cglx4J/P+gz4UYjyORwYKzxAv2B4wmkXgOvnD+l+Tne4OyDE0dOy3gS8h/HkR6ZlqIzKBomldgKxpBcYHlGJdERlUYhtWGEBCYx0ERr9GA8GNk0TxRHmiEkVeC3bZHbF3IwYDuSiQSxocKysg2GBqe+Xy7/YuPpAPNnlGhdvXv6sCQZYpndFMnXietBjTciFxINSx4bY5crn1jfFCkLcvO53mPmBX166PBg0opLYalCW6CWsgn77pcOTqZwIkS56NC787Bx3ubqtqbZvjfs+7OkTHFXkpsCLNwHfxlImHjtX0RLACV
X-MS-Exchange-AntiSpam-MessageData: pHnmAf8xEI7Uz65Lu64Is3ylXOsPQznKsCdaLfYGLVWqsc/Xv76ae1Ucd3T/aXCVrHGxH6ucrXswIOPzb5PpXv0hC35J7njuRxLXv4ZnfCavjQAqqX06gNJfxofBqUuMOpechSqNvbZvWqNCFwuDj/LYJNOPwthlykbdSYfLPWk=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 07fe6d40-6729-465e-9c9e-08d7e25fac65
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2020 23:41:24.0614 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OaMd+zaDUK8Rxw6sV3KBMuhmFVsxFKD9UOMXriWnWQt5JBa5kM73RymFPyztxVnWU0gaqRbOGbLtwfFDnCcubg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR12MB2459
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
 Nikola Cornij <Nikola.Cornij@amd.com>, Wenjing Liu <wenjing.liu@amd.com>,
 Bhawanpreet.Lakha@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Wenjing Liu <wenjing.liu@amd.com>

[why]
Optc needs to know if timing is enabled with ODM or DSC before computing
crc.  Otherwise value computed will be inaccurate. Before this change,
the CRC computed without ODM is not equal to the CRC computed with ODM
for the same timing. This is unexpected as we are driving the same
timing despite of the underlaying hardware setup to achieve it. This is
caused by missing hardware programming sequence to support it.

[how]
Add the new programming sequence based on hardware guide.

Signed-off-by: Wenjing Liu <wenjing.liu@amd.com>
Reviewed-by: Nikola Cornij <Nikola.Cornij@amd.com>
Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc.c           |  5 ++++-
 drivers/gpu/drm/amd/display/dc/dcn10/dcn10_optc.h  |  7 ++++++-
 drivers/gpu/drm/amd/display/dc/dcn20/dcn20_optc.c  | 14 +++++++++++++-
 drivers/gpu/drm/amd/display/dc/dcn20/dcn20_optc.h  |  7 +++++++
 .../drm/amd/display/dc/inc/hw/timing_generator.h   |  3 +++
 5 files changed, 33 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index 9bde05547b30..d5ecf2031255 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -350,7 +350,7 @@ bool dc_stream_configure_crc(struct dc *dc, struct dc_stream_state *stream,
 
 	for (i = 0; i < MAX_PIPES; i++) {
 		pipe = &dc->current_state->res_ctx.pipe_ctx[i];
-		if (pipe->stream == stream)
+		if (pipe->stream == stream && !pipe->top_pipe && !pipe->prev_odm_pipe)
 			break;
 	}
 	/* Stream not found */
@@ -367,6 +367,9 @@ bool dc_stream_configure_crc(struct dc *dc, struct dc_stream_state *stream,
 	param.windowb_x_end = pipe->stream->timing.h_addressable;
 	param.windowb_y_end = pipe->stream->timing.v_addressable;
 
+	param.dsc_mode = pipe->stream->timing.flags.DSC ? 1:0;
+	param.odm_mode = pipe->next_odm_pipe ? 1:0;
+
 	/* Default to the union of both windows */
 	param.selection = UNION_WINDOW_A_B;
 	param.continuous_mode = continuous;
diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_optc.h b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_optc.h
index 9a459a8fe8a0..8d1e52fb0393 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_optc.h
+++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_optc.h
@@ -158,6 +158,7 @@ struct dcn_optc_registers {
 	uint32_t OTG_GSL_WINDOW_Y;
 	uint32_t OTG_VUPDATE_KEEPOUT;
 	uint32_t OTG_CRC_CNTL;
+	uint32_t OTG_CRC_CNTL2;
 	uint32_t OTG_CRC0_DATA_RG;
 	uint32_t OTG_CRC0_DATA_B;
 	uint32_t OTG_CRC0_WINDOWA_X_CONTROL;
@@ -475,7 +476,11 @@ struct dcn_optc_registers {
 	type OPTC_DSC_SLICE_WIDTH;\
 	type OPTC_SEGMENT_WIDTH;\
 	type OPTC_DWB0_SOURCE_SELECT;\
-	type OPTC_DWB1_SOURCE_SELECT;
+	type OPTC_DWB1_SOURCE_SELECT;\
+	type OTG_CRC_DSC_MODE;\
+	type OTG_CRC_DATA_STREAM_COMBINE_MODE;\
+	type OTG_CRC_DATA_STREAM_SPLIT_MODE;\
+	type OTG_CRC_DATA_FORMAT;
 
 
 
diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_optc.c b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_optc.c
index d875b0c38fde..8c16967fe018 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_optc.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_optc.c
@@ -409,6 +409,18 @@ void optc2_program_manual_trigger(struct timing_generator *optc)
 			OTG_TRIGA_MANUAL_TRIG, 1);
 }
 
+bool optc2_configure_crc(struct timing_generator *optc,
+			  const struct crc_params *params)
+{
+	struct optc *optc1 = DCN10TG_FROM_TG(optc);
+
+	REG_SET_2(OTG_CRC_CNTL2, 0,
+			OTG_CRC_DSC_MODE, params->dsc_mode,
+			OTG_CRC_DATA_STREAM_COMBINE_MODE, params->odm_mode);
+
+	return optc1_configure_crc(optc, params);
+}
+
 static struct timing_generator_funcs dcn20_tg_funcs = {
 		.validate_timing = optc1_validate_timing,
 		.program_timing = optc1_program_timing,
@@ -452,7 +464,7 @@ static struct timing_generator_funcs dcn20_tg_funcs = {
 		.clear_optc_underflow = optc1_clear_optc_underflow,
 		.setup_global_swap_lock = NULL,
 		.get_crc = optc1_get_crc,
-		.configure_crc = optc1_configure_crc,
+		.configure_crc = optc2_configure_crc,
 		.set_dsc_config = optc2_set_dsc_config,
 		.set_dwb_source = optc2_set_dwb_source,
 		.set_odm_bypass = optc2_set_odm_bypass,
diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_optc.h b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_optc.h
index 239cc40ae474..e0a0a8a8e2c6 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_optc.h
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_optc.h
@@ -36,6 +36,7 @@
 	SRI(OTG_GSL_WINDOW_Y, OTG, inst),\
 	SRI(OTG_VUPDATE_KEEPOUT, OTG, inst),\
 	SRI(OTG_DSC_START_POSITION, OTG, inst),\
+	SRI(OTG_CRC_CNTL2, OTG, inst),\
 	SRI(OPTC_DATA_FORMAT_CONTROL, ODM, inst),\
 	SRI(OPTC_BYTES_PER_PIXEL, ODM, inst),\
 	SRI(OPTC_WIDTH_CONTROL, ODM, inst),\
@@ -62,6 +63,10 @@
 	SF(OTG0_OTG_GSL_CONTROL, OTG_MASTER_UPDATE_LOCK_GSL_EN, mask_sh), \
 	SF(OTG0_OTG_DSC_START_POSITION, OTG_DSC_START_POSITION_X, mask_sh), \
 	SF(OTG0_OTG_DSC_START_POSITION, OTG_DSC_START_POSITION_LINE_NUM, mask_sh),\
+	SF(OTG0_OTG_CRC_CNTL2, OTG_CRC_DSC_MODE, mask_sh),\
+	SF(OTG0_OTG_CRC_CNTL2, OTG_CRC_DATA_STREAM_COMBINE_MODE, mask_sh),\
+	SF(OTG0_OTG_CRC_CNTL2, OTG_CRC_DATA_STREAM_SPLIT_MODE, mask_sh),\
+	SF(OTG0_OTG_CRC_CNTL2, OTG_CRC_DATA_FORMAT, mask_sh),\
 	SF(ODM0_OPTC_DATA_SOURCE_SELECT, OPTC_SEG0_SRC_SEL, mask_sh),\
 	SF(ODM0_OPTC_DATA_SOURCE_SELECT, OPTC_SEG1_SRC_SEL, mask_sh),\
 	SF(ODM0_OPTC_DATA_SOURCE_SELECT, OPTC_NUM_OF_INPUT_SEGMENT, mask_sh),\
@@ -109,4 +114,6 @@ void optc2_lock_doublebuffer_enable(struct timing_generator *optc);
 void optc2_setup_manual_trigger(struct timing_generator *optc);
 void optc2_program_manual_trigger(struct timing_generator *optc);
 bool optc2_is_two_pixels_per_containter(const struct dc_crtc_timing *timing);
+bool optc2_configure_crc(struct timing_generator *optc,
+			  const struct crc_params *params);
 #endif /* __DC_OPTC_DCN20_H__ */
diff --git a/drivers/gpu/drm/amd/display/dc/inc/hw/timing_generator.h b/drivers/gpu/drm/amd/display/dc/inc/hw/timing_generator.h
index e5e7d94026fc..f803191e3134 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/hw/timing_generator.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/hw/timing_generator.h
@@ -117,6 +117,9 @@ struct crc_params {
 
 	enum crc_selection selection;
 
+	uint8_t dsc_mode;
+	uint8_t odm_mode;
+
 	bool continuous_mode;
 	bool enable;
 };
-- 
2.26.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
