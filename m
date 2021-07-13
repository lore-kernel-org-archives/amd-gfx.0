Return-Path: <SRS0=Y2YZ=MF=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF17DC07E95
	for <amd-gfx@archiver.kernel.org>; Tue, 13 Jul 2021 18:48:48 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8E595608FE
	for <amd-gfx@archiver.kernel.org>; Tue, 13 Jul 2021 18:48:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E595608FE
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4E825898ED;
	Tue, 13 Jul 2021 18:48:48 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2088.outbound.protection.outlook.com [40.107.236.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B99DB898ED
 for <amd-gfx@lists.freedesktop.org>; Tue, 13 Jul 2021 18:48:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=alDPwbl8fYXLZTa5wglkEzj0FsN74b7CbqPvbxTBbZ3NY9nyKPg1Ei+aEPR6ssYnDTyBotALenkoD+2eJEbBi5HvMWsWeRx3nNTpSczSvT5RLY/mH9RenGCd2Qq0PQlaO+x2augSmfcg3X2a46Od9Ho4G6kDgwRFvm0nMQUc7+IoE5cikdvyb1Ma7d6h123PFLkCsTOaPQlBzS+b7oGEih+TGq7JhRnU18eqfqzWgxny/WjhRK1t2ghaZFvMzfZoPrGhaTAYpTfgoGnPz6HvvEkeNRzwo5cUwBnNingVMSQzhc1FcIcRAowHnuyd+X4r787DSA6Aa1ZaG7Pk0l4bKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rTt6i0QGp/SPeB0D0qkDIlu+hV5k4pMuVXlz8uB9niY=;
 b=aCQia1sgwARcG96ZfPovk4Pep8fqjSuy39IrcE/h/D/qhlvNnVBbbrQkF3YYHXyIQDkGltLPzJ7uAQKXZEs1ILKicSrWdZAxc5Kc7TyHicVMEFE21VzWstVjT+qmgOkty4gbPgDNEbiflUkBPwdMLYzZG6MnJOEAgqwh+3NMK5GN96puHRTlq/bbJef7RIeoq3q6xDEI+pl+ufQc4twKQQl9tT90v0sHQUKt7WuhjHlvXlrxQ4Ans6Txnrfi5FlJzesa70ZuXr0Q3zht4vnGXcwopUxXsU7Vb7j5WkL1ro6HpbFiNjpm4nkeeQ22qPpSZm4NzBIlx73k4+wv/cxviA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rTt6i0QGp/SPeB0D0qkDIlu+hV5k4pMuVXlz8uB9niY=;
 b=gD3kX/ucajnapWWAn4vn1vYn+Zymy1QgAPmKtFyBd0MJtHNXKGAeoWwpQPKsoeUEfAl+M5Wwrdy1Rz8ySq041auhNuuCTRVnV3usA3VYfMUOMbm76jpdHWhR/hh1ofv8x9ow39VbHyNR/t4pTbYUgDZqGS6A5BOKMTqU4OqOVTc=
Received: from MW2PR16CA0021.namprd16.prod.outlook.com (2603:10b6:907::34) by
 MN2PR12MB4046.namprd12.prod.outlook.com (2603:10b6:208:1da::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.22; Tue, 13 Jul
 2021 18:48:42 +0000
Received: from CO1NAM11FT019.eop-nam11.prod.protection.outlook.com
 (2603:10b6:907:0:cafe::93) by MW2PR16CA0021.outlook.office365.com
 (2603:10b6:907::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.21 via Frontend
 Transport; Tue, 13 Jul 2021 18:48:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT019.mail.protection.outlook.com (10.13.175.57) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4308.20 via Frontend Transport; Tue, 13 Jul 2021 18:48:42 +0000
Received: from X570-RTG.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Tue, 13 Jul
 2021 13:48:39 -0500
From: <veerabadhran.gopalakrishnan@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 2/2] amdgpu/nv.c - Optimize code for video codec support
 structure
Date: Wed, 14 Jul 2021 00:18:08 +0530
Message-ID: <20210713184808.1268570-3-veerabadhran.gopalakrishnan@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210713184808.1268570-1-veerabadhran.gopalakrishnan@amd.com>
References: <20210713184808.1268570-1-veerabadhran.gopalakrishnan@amd.com>
MIME-Version: 1.0
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 214dfe14-bf53-4df3-f657-08d9462ed64e
X-MS-TrafficTypeDiagnostic: MN2PR12MB4046:
X-Microsoft-Antispam-PRVS: <MN2PR12MB4046B8DA13552B5DE4B3F021FA149@MN2PR12MB4046.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: G5qyuQuSlVotwr/x2pgSdyB5t7kUx+Khn3/C0n89sXAwr3/dyohfq+PnQ4umid31IN+d473M6IUTJRQGOeNiJ6ujXh2zo4Gp4oYKUfCay1lTzdUXSZ+/c6+bzvLtmG1n7T29lqg6na42NG6ecDgO+mLRgyRZo9c5Sf0KYTS5/nCb3AtdrHanaNvQHy/jDrW3gAyaqbg5CAnWXBh9CnM4WKeD0v5zPkAFpUfz5pTB0zmPannXTg3JzmBF73I7sc8So8t9DI/X0aDanOUi+jH1p3v4N2ekkAvT6SQPELOaTTKdzEwfcu1zSy5ySDPl0ClkosAJkFEqlOc3Rt1XBtO0z4/HcedsPy4BCsrrA7K+hMDsJCgbqdYcxJ8hVxK5oeUYW8+T7fYy0CHSkU8KHkXCn3eV2bkjVKLA7X0BEe5ft2JZUMDbYA7ZSRM1XSMUCs/1NIKlZIOHuPWqBeHxKakW7ld8eaSS3WgLTapL5eXNLn6jr7SaQrL5znudxKaI5tF10s8NBnQDekkXRqpjHZsspxgygd4WXaeS9Fa1UTxabjwnw5GN0rhEgJ6b1B+sq/oDcRH7SbsLhZyfkF+zxGmTTAubG6gAZP8ZQk/lCglHn9O2ZxJZqk+t8TH8HfvUFWtzJKcHVCkztwIp3bNmXLdR5UDXswk8ZSL/rPncqD9Nas0UVUT7Yd0r/qIcA/3Ufft6R6vTZ+HazuKqV0F0Birlhd6EhiA4FISagiQLoNuNlxo=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(136003)(346002)(396003)(39860400002)(376002)(46966006)(36840700001)(336012)(4326008)(47076005)(2616005)(316002)(5660300002)(81166007)(426003)(82310400003)(8936002)(36756003)(82740400003)(6666004)(36860700001)(30864003)(2876002)(7696005)(54906003)(2906002)(6916009)(186003)(70206006)(83380400001)(8676002)(86362001)(26005)(70586007)(1076003)(478600001)(356005)(16526019)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2021 18:48:42.5935 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 214dfe14-bf53-4df3-f657-08d9462ed64e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT019.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4046
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
Cc: Boyuan.Zhang@amd.com,
 Veerabadhran Gopalakrishnan <veerabadhran.gopalakrishnan@amd.com>,
 james.zhu@amd.com, leo.liu@amd.com, srinath.rao@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Veerabadhran Gopalakrishnan <veerabadhran.gopalakrishnan@amd.com>

Optimized the code for codec info structure initialization

Signed-off-by: Veerabadhran Gopalakrishnan <veerabadhran.gopalakrishnan@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h |   7 +
 drivers/gpu/drm/amd/amdgpu/nv.c     | 223 ++++------------------------
 drivers/gpu/drm/amd/amdgpu/soc15.c  | 176 +++-------------------
 3 files changed, 56 insertions(+), 350 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index d14b4968a..61a0897e9 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -619,6 +619,13 @@ struct amdgpu_video_codec_info {
 	u32 max_level;
 };
 
+#define codec_info_build(type, width, height, level) \
+			 .codec_type = type,\
+			 .max_width = width,\
+			 .max_height = height,\
+			 .max_pixels_per_frame = height * width,\
+			 .max_level = level,
+
 struct amdgpu_video_codecs {
 	const u32 codec_count;
 	const struct amdgpu_video_codec_info *codec_array;
diff --git a/drivers/gpu/drm/amd/amdgpu/nv.c b/drivers/gpu/drm/amd/amdgpu/nv.c
index 04f6cf38c..cf73a6923 100644
--- a/drivers/gpu/drm/amd/amdgpu/nv.c
+++ b/drivers/gpu/drm/amd/amdgpu/nv.c
@@ -64,32 +64,13 @@
 #include "smuio_v11_0.h"
 #include "smuio_v11_0_6.h"
 
-#define codec_info_build(type, width, height, level) \
-			 .codec_type = type,\
-			 .max_width = width,\
-			 .max_height = height,\
-			 .max_pixels_per_frame = height * width,\
-			 .max_level = level,
-
 static const struct amd_ip_funcs nv_common_ip_funcs;
 
 /* Navi */
 static const struct amdgpu_video_codec_info nv_video_codecs_encode_array[] =
 {
-	{
-		.codec_type = AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_MPEG4_AVC,
-		.max_width = 4096,
-		.max_height = 2304,
-		.max_pixels_per_frame = 4096 * 2304,
-		.max_level = 0,
-	},
-	{
-		.codec_type = AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_HEVC,
-		.max_width = 4096,
-		.max_height = 2304,
-		.max_pixels_per_frame = 4096 * 2304,
-		.max_level = 0,
-	},
+	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_MPEG4_AVC, 4096, 2304, 0)},
+	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_HEVC, 4096, 2304, 0)},
 };
 
 static const struct amdgpu_video_codecs nv_video_codecs_encode =
@@ -101,55 +82,13 @@ static const struct amdgpu_video_codecs nv_video_codecs_encode =
 /* Navi1x */
 static const struct amdgpu_video_codec_info nv_video_codecs_decode_array[] =
 {
-	{
-		.codec_type = AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_MPEG2,
-		.max_width = 4096,
-		.max_height = 4096,
-		.max_pixels_per_frame = 4096 * 4096,
-		.max_level = 3,
-	},
-	{
-		.codec_type = AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_MPEG4,
-		.max_width = 4096,
-		.max_height = 4096,
-		.max_pixels_per_frame = 4096 * 4096,
-		.max_level = 5,
-	},
-	{
-		.codec_type = AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_MPEG4_AVC,
-		.max_width = 4096,
-		.max_height = 4096,
-		.max_pixels_per_frame = 4096 * 4096,
-		.max_level = 52,
-	},
-	{
-		.codec_type = AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_VC1,
-		.max_width = 4096,
-		.max_height = 4096,
-		.max_pixels_per_frame = 4096 * 4096,
-		.max_level = 4,
-	},
-	{
-		.codec_type = AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_HEVC,
-		.max_width = 8192,
-		.max_height = 4352,
-		.max_pixels_per_frame = 8192 * 4352,
-		.max_level = 186,
-	},
-	{
-		.codec_type = AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_JPEG,
-		.max_width = 4096,
-		.max_height = 4096,
-		.max_pixels_per_frame = 4096 * 4096,
-		.max_level = 0,
-	},
-	{
-		.codec_type = AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_VP9,
-		.max_width = 8192,
-		.max_height = 4352,
-		.max_pixels_per_frame = 8192 * 4352,
-		.max_level = 0,
-	},
+	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_MPEG2, 4096, 4906, 3)},
+	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_MPEG4, 4096, 4906, 5)},
+	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_MPEG4_AVC, 4096, 4906, 52)},
+	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_VC1, 4096, 4906, 4)},
+	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_HEVC, 8192, 4352, 186)},
+	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_JPEG, 4096, 4096, 0)},
+	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_VP9, 8192, 4352, 0)},
 };
 
 static const struct amdgpu_video_codecs nv_video_codecs_decode =
@@ -161,62 +100,14 @@ static const struct amdgpu_video_codecs nv_video_codecs_decode =
 /* Sienna Cichlid */
 static const struct amdgpu_video_codec_info sc_video_codecs_decode_array[] =
 {
-	{
-		.codec_type = AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_MPEG2,
-		.max_width = 4096,
-		.max_height = 4096,
-		.max_pixels_per_frame = 4096 * 4096,
-		.max_level = 3,
-	},
-	{
-		.codec_type = AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_MPEG4,
-		.max_width = 4096,
-		.max_height = 4096,
-		.max_pixels_per_frame = 4096 * 4096,
-		.max_level = 5,
-	},
-	{
-		.codec_type = AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_MPEG4_AVC,
-		.max_width = 4096,
-		.max_height = 4096,
-		.max_pixels_per_frame = 4096 * 4096,
-		.max_level = 52,
-	},
-	{
-		.codec_type = AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_VC1,
-		.max_width = 4096,
-		.max_height = 4096,
-		.max_pixels_per_frame = 4096 * 4096,
-		.max_level = 4,
-	},
-	{
-		.codec_type = AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_HEVC,
-		.max_width = 8192,
-		.max_height = 4352,
-		.max_pixels_per_frame = 8192 * 4352,
-		.max_level = 186,
-	},
-	{
-		.codec_type = AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_JPEG,
-		.max_width = 4096,
-		.max_height = 4096,
-		.max_pixels_per_frame = 4096 * 4096,
-		.max_level = 0,
-	},
-	{
-		.codec_type = AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_VP9,
-		.max_width = 8192,
-		.max_height = 4352,
-		.max_pixels_per_frame = 8192 * 4352,
-		.max_level = 0,
-	},
-	{
-		.codec_type = AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_AV1,
-		.max_width = 8192,
-		.max_height = 4352,
-		.max_pixels_per_frame = 8192 * 4352,
-		.max_level = 0,
-	},
+	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_MPEG2, 4096, 4906, 3)},
+	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_MPEG4, 4096, 4906, 5)},
+	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_MPEG4_AVC, 4096, 4906, 52)},
+	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_VC1, 4096, 4906, 4)},
+	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_HEVC, 8192, 4352, 186)},
+	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_JPEG, 4096, 4096, 0)},
+	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_VP9, 8192, 4352, 0)},
+	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_AV1, 8192, 4352, 0)},
 };
 
 static const struct amdgpu_video_codecs sc_video_codecs_decode =
@@ -228,80 +119,20 @@ static const struct amdgpu_video_codecs sc_video_codecs_decode =
 /* SRIOV Sienna Cichlid, not const since data is controlled by host */
 static struct amdgpu_video_codec_info sriov_sc_video_codecs_encode_array[] =
 {
-	{
-		.codec_type = AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_MPEG4_AVC,
-		.max_width = 4096,
-		.max_height = 2304,
-		.max_pixels_per_frame = 4096 * 2304,
-		.max_level = 0,
-	},
-	{
-		.codec_type = AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_HEVC,
-		.max_width = 4096,
-		.max_height = 2304,
-		.max_pixels_per_frame = 4096 * 2304,
-		.max_level = 0,
-	},
+	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_MPEG4_AVC, 4096, 2304, 0)},
+	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_HEVC, 4096, 2304, 0)},
 };
 
 static struct amdgpu_video_codec_info sriov_sc_video_codecs_decode_array[] =
 {
-	{
-		.codec_type = AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_MPEG2,
-		.max_width = 4096,
-		.max_height = 4096,
-		.max_pixels_per_frame = 4096 * 4096,
-		.max_level = 3,
-	},
-	{
-		.codec_type = AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_MPEG4,
-		.max_width = 4096,
-		.max_height = 4096,
-		.max_pixels_per_frame = 4096 * 4096,
-		.max_level = 5,
-	},
-	{
-		.codec_type = AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_MPEG4_AVC,
-		.max_width = 4096,
-		.max_height = 4096,
-		.max_pixels_per_frame = 4096 * 4096,
-		.max_level = 52,
-	},
-	{
-		.codec_type = AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_VC1,
-		.max_width = 4096,
-		.max_height = 4096,
-		.max_pixels_per_frame = 4096 * 4096,
-		.max_level = 4,
-	},
-	{
-		.codec_type = AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_HEVC,
-		.max_width = 8192,
-		.max_height = 4352,
-		.max_pixels_per_frame = 8192 * 4352,
-		.max_level = 186,
-	},
-	{
-		.codec_type = AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_JPEG,
-		.max_width = 4096,
-		.max_height = 4096,
-		.max_pixels_per_frame = 4096 * 4096,
-		.max_level = 0,
-	},
-	{
-		.codec_type = AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_VP9,
-		.max_width = 8192,
-		.max_height = 4352,
-		.max_pixels_per_frame = 8192 * 4352,
-		.max_level = 0,
-	},
-	{
-		.codec_type = AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_AV1,
-		.max_width = 8192,
-		.max_height = 4352,
-		.max_pixels_per_frame = 8192 * 4352,
-		.max_level = 0,
-	},
+	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_MPEG2, 4096, 4906, 3)},
+	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_MPEG4, 4096, 4906, 5)},
+	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_MPEG4_AVC, 4096, 4906, 52)},
+	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_VC1, 4096, 4906, 4)},
+	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_HEVC, 8192, 4352, 186)},
+	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_JPEG, 4096, 4096, 0)},
+	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_VP9, 8192, 4352, 0)},
+	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_AV1, 8192, 4352, 0)},
 };
 
 static struct amdgpu_video_codecs sriov_sc_video_codecs_encode =
diff --git a/drivers/gpu/drm/amd/amdgpu/soc15.c b/drivers/gpu/drm/amd/amdgpu/soc15.c
index b02436401..b7d350be8 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc15.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc15.c
@@ -88,20 +88,8 @@
 /* Vega, Raven, Arcturus */
 static const struct amdgpu_video_codec_info vega_video_codecs_encode_array[] =
 {
-	{
-		.codec_type = AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_MPEG4_AVC,
-		.max_width = 4096,
-		.max_height = 2304,
-		.max_pixels_per_frame = 4096 * 2304,
-		.max_level = 0,
-	},
-	{
-		.codec_type = AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_HEVC,
-		.max_width = 4096,
-		.max_height = 2304,
-		.max_pixels_per_frame = 4096 * 2304,
-		.max_level = 0,
-	},
+	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_MPEG4_AVC, 4096, 2304, 0)},
+	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_HEVC, 4096, 2304, 0)},
 };
 
 static const struct amdgpu_video_codecs vega_video_codecs_encode =
@@ -113,48 +101,12 @@ static const struct amdgpu_video_codecs vega_video_codecs_encode =
 /* Vega */
 static const struct amdgpu_video_codec_info vega_video_codecs_decode_array[] =
 {
-	{
-		.codec_type = AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_MPEG2,
-		.max_width = 4096,
-		.max_height = 4096,
-		.max_pixels_per_frame = 4096 * 4096,
-		.max_level = 3,
-	},
-	{
-		.codec_type = AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_MPEG4,
-		.max_width = 4096,
-		.max_height = 4096,
-		.max_pixels_per_frame = 4096 * 4096,
-		.max_level = 5,
-	},
-	{
-		.codec_type = AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_MPEG4_AVC,
-		.max_width = 4096,
-		.max_height = 4096,
-		.max_pixels_per_frame = 4096 * 4096,
-		.max_level = 52,
-	},
-	{
-		.codec_type = AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_VC1,
-		.max_width = 4096,
-		.max_height = 4096,
-		.max_pixels_per_frame = 4096 * 4096,
-		.max_level = 4,
-	},
-	{
-		.codec_type = AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_HEVC,
-		.max_width = 4096,
-		.max_height = 4096,
-		.max_pixels_per_frame = 4096 * 4096,
-		.max_level = 186,
-	},
-	{
-		.codec_type = AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_JPEG,
-		.max_width = 4096,
-		.max_height = 4096,
-		.max_pixels_per_frame = 4096 * 4096,
-		.max_level = 0,
-	},
+	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_MPEG2, 4096, 4906, 3)},
+	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_MPEG4, 4096, 4906, 5)},
+	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_MPEG4_AVC, 4096, 4906, 52)},
+	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_VC1, 4096, 4906, 4)},
+	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_HEVC, 4096, 4096, 186)},
+	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_JPEG, 4096, 4096, 0)},
 };
 
 static const struct amdgpu_video_codecs vega_video_codecs_decode =
@@ -166,55 +118,13 @@ static const struct amdgpu_video_codecs vega_video_codecs_decode =
 /* Raven */
 static const struct amdgpu_video_codec_info rv_video_codecs_decode_array[] =
 {
-	{
-		.codec_type = AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_MPEG2,
-		.max_width = 4096,
-		.max_height = 4096,
-		.max_pixels_per_frame = 4096 * 4096,
-		.max_level = 3,
-	},
-	{
-		.codec_type = AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_MPEG4,
-		.max_width = 4096,
-		.max_height = 4096,
-		.max_pixels_per_frame = 4096 * 4096,
-		.max_level = 5,
-	},
-	{
-		.codec_type = AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_MPEG4_AVC,
-		.max_width = 4096,
-		.max_height = 4096,
-		.max_pixels_per_frame = 4096 * 4096,
-		.max_level = 52,
-	},
-	{
-		.codec_type = AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_VC1,
-		.max_width = 4096,
-		.max_height = 4096,
-		.max_pixels_per_frame = 4096 * 4096,
-		.max_level = 4,
-	},
-	{
-		.codec_type = AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_HEVC,
-		.max_width = 4096,
-		.max_height = 4096,
-		.max_pixels_per_frame = 4096 * 4096,
-		.max_level = 186,
-	},
-	{
-		.codec_type = AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_JPEG,
-		.max_width = 4096,
-		.max_height = 4096,
-		.max_pixels_per_frame = 4096 * 4096,
-		.max_level = 0,
-	},
-	{
-		.codec_type = AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_VP9,
-		.max_width = 4096,
-		.max_height = 4096,
-		.max_pixels_per_frame = 4096 * 4096,
-		.max_level = 0,
-	},
+	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_MPEG2, 4096, 4906, 3)},
+	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_MPEG4, 4096, 4906, 5)},
+	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_MPEG4_AVC, 4096, 4906, 52)},
+	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_VC1, 4096, 4906, 4)},
+	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_HEVC, 4096, 4096, 186)},
+	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_JPEG, 4096, 4096, 0)},
+	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_VP9, 4096, 4096, 0)},
 };
 
 static const struct amdgpu_video_codecs rv_video_codecs_decode =
@@ -226,55 +136,13 @@ static const struct amdgpu_video_codecs rv_video_codecs_decode =
 /* Renoir, Arcturus */
 static const struct amdgpu_video_codec_info rn_video_codecs_decode_array[] =
 {
-	{
-		.codec_type = AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_MPEG2,
-		.max_width = 4096,
-		.max_height = 4096,
-		.max_pixels_per_frame = 4096 * 4096,
-		.max_level = 3,
-	},
-	{
-		.codec_type = AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_MPEG4,
-		.max_width = 4096,
-		.max_height = 4096,
-		.max_pixels_per_frame = 4096 * 4096,
-		.max_level = 5,
-	},
-	{
-		.codec_type = AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_MPEG4_AVC,
-		.max_width = 4096,
-		.max_height = 4096,
-		.max_pixels_per_frame = 4096 * 4096,
-		.max_level = 52,
-	},
-	{
-		.codec_type = AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_VC1,
-		.max_width = 4096,
-		.max_height = 4096,
-		.max_pixels_per_frame = 4096 * 4096,
-		.max_level = 4,
-	},
-	{
-		.codec_type = AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_HEVC,
-		.max_width = 8192,
-		.max_height = 4352,
-		.max_pixels_per_frame = 4096 * 4096,
-		.max_level = 186,
-	},
-	{
-		.codec_type = AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_JPEG,
-		.max_width = 4096,
-		.max_height = 4096,
-		.max_pixels_per_frame = 4096 * 4096,
-		.max_level = 0,
-	},
-	{
-		.codec_type = AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_VP9,
-		.max_width = 8192,
-		.max_height = 4352,
-		.max_pixels_per_frame = 4096 * 4096,
-		.max_level = 0,
-	},
+	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_MPEG2, 4096, 4906, 3)},
+	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_MPEG4, 4096, 4906, 5)},
+	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_MPEG4_AVC, 4096, 4906, 52)},
+	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_VC1, 4096, 4906, 4)},
+	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_HEVC, 8192, 4352, 186)},
+	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_JPEG, 4096, 4096, 0)},
+	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_VP9, 8192, 4352, 0)},
 };
 
 static const struct amdgpu_video_codecs rn_video_codecs_decode =
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
