Return-Path: <SRS0=Rd3N=H3=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E481EC433E6
	for <amd-gfx@archiver.kernel.org>; Thu, 25 Feb 2021 20:16:42 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9633864F37
	for <amd-gfx@archiver.kernel.org>; Thu, 25 Feb 2021 20:16:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9633864F37
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4E2936E29D;
	Thu, 25 Feb 2021 20:16:42 +0000 (UTC)
Received: from NAM02-CY1-obe.outbound.protection.outlook.com
 (mail-eopbgr760058.outbound.protection.outlook.com [40.107.76.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ACBA36E1D2
 for <amd-gfx@lists.freedesktop.org>; Thu, 25 Feb 2021 20:16:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S86fBHaTh9EBJfhJVaepqvzXqiG359Zx4wbZJITikpQGSMBY0jtJ0XeY/pYOzdUg9Oc+WtN4axXMzx42oBSQt2pjiGFrnUeV8Ubc4bxwOSNHn0/8UlZgq6ZlxraiDNtX8KlFpWqJ+LYgt1zb2xy/eg1C7Hmwmq5W31SS0OviLRNBvXINFOqRJuVcbcyzgbPRL4HLT2EfWRJWkmWu/AfD/MCE8GmdmXmADM1XxBoBPQSb6djnK8v/oU23CnCWsdqhm6at0T+D1bAiTjPSuZsIipBv4/NKLPZJQZTotEX2mi6oeNgyCLA+QVTphsntN4zvOQJZtzul/6wRJ3zBdbWnDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uJrq/jXVS91YgAEyqgJzAMp1SjYYN5MH9Xjxz6UW6+8=;
 b=jF/Vu7sOKV5DLJOHUquejJWdcBnNr8BuiWjfFlg1JUUGJ1VjDPl7phhzquKTpN/k8kTsWxUJMuH1aUVuVZc2oG3sDR2QrE5v2jZ8qd5BH56WCxC3yXQP7pPYjAq9UK5JGwiQlj2X2u0jGKOz1BpvPaBqUDnNJO9ubRLz748I6HJJL9WK8YHrSQOmbxJItiLLluepzP9hf00EOvZll11wn/ka/gxF53szMdnWyC0YbBIYN4n4Ch52hfFC4xuusDG9GqtTVafbdxJfSGov4pxniZDs0vlg5+B539io6S4Oewvgmyx29Q/zkR00YRvnf86HzKEHM4ERCU+g8qthuuPGcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uJrq/jXVS91YgAEyqgJzAMp1SjYYN5MH9Xjxz6UW6+8=;
 b=widUW9sdccRxnp27ekCBwOo7m5hRZSw2vxiaKFQVYS6LDndwUH5JWoUVbqtsZYGm0fnJPCQ1tucu2KM0bW66NyymH63XQODKxMonfify84Qs0//Y0kFgpe68PEMWWOAoFdlXTbQxkeBt+xvQgxwbet1pWZvTiPYqMOKd0oBC7/Y=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 by MN2PR12MB3872.namprd12.prod.outlook.com (2603:10b6:208:168::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.19; Thu, 25 Feb
 2021 20:16:33 +0000
Received: from MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::b0c4:9a8b:4c4c:76af]) by MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::b0c4:9a8b:4c4c:76af%7]) with mapi id 15.20.3890.020; Thu, 25 Feb 2021
 20:16:33 +0000
From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 5/5] drm/amdgpu/codec: drop the internal codec index
Date: Thu, 25 Feb 2021 15:16:14 -0500
Message-Id: <20210225201614.896990-5-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210225201614.896990-1-alexander.deucher@amd.com>
References: <20210225201614.896990-1-alexander.deucher@amd.com>
X-Originating-IP: [165.204.84.11]
X-ClientProxiedBy: BL0PR05CA0023.namprd05.prod.outlook.com
 (2603:10b6:208:91::33) To MN2PR12MB4488.namprd12.prod.outlook.com
 (2603:10b6:208:24e::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from tr4.amd.com (165.204.84.11) by
 BL0PR05CA0023.namprd05.prod.outlook.com (2603:10b6:208:91::33) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3912.9 via Frontend Transport; Thu, 25 Feb 2021 20:16:32 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 45260c20-b2e2-4a56-e2c7-08d8d9ca3e63
X-MS-TrafficTypeDiagnostic: MN2PR12MB3872:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB38727A559B420132535418F7F79E9@MN2PR12MB3872.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2331;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6xZntV4X9YWpUjXITRFIwifbcuNU37Bji40WUb4CVI4aCvDBPcL/eB6XJEceWvpLC5gDRnfBcN6CPscvnBFA0JDGDTaw62SXw/+eJbsg9c0te2GN2xfgmPwrzzcjzUitTn8HB9b9WU9I/6LayXP0fFWVLYzRJBJ1V7/KQ4DBx2cN6/RGIRRUa7YHP6uTwdtqSw5QOZ+MYuvTlZCSzPJuWNl+qp1o17tebJ5h2vywFeIz/iUqgpMa4SGdIVS+1C0bnWQF+PzkX7gzgdnLe2oAzS0IQVijT/Cukkxc31ibdCG3Kt+qaRT3Ku2Xmq5fHbzMevy9pR6z45YaWksg+m0KOdF+yJx8X9TOLK6vYFUP3ulr/fTD1keKafvkELYuQfBl0fwHqUdk0rHvlYPAtaqqGmlLNbd0rb4nmJpN4ou1CB/Pafju8IfpYLZbWKze19+jHwM6Os+1VchSiD1Q1CpTd0Ix7VCxuyu7lZJHuPAytLs+yhSTmg28SsHbShQ6xH1EgJVdsa2xUeKFymJylWlVdA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4488.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(39860400002)(376002)(136003)(366004)(346002)(66556008)(316002)(66476007)(26005)(8676002)(30864003)(1076003)(2616005)(7696005)(52116002)(956004)(4326008)(186003)(86362001)(6916009)(8936002)(36756003)(16526019)(6666004)(83380400001)(5660300002)(6486002)(478600001)(66946007)(2906002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?1ypMQ0J2nR0U98InGc1Nua0ELuz6+vTnI+zDadB/bGc8YunuBM99/YeoGK2K?=
 =?us-ascii?Q?utKNB+mMUsizw/6ycV65v9ee0MOOFcpVFDx6GbWeJ7eour6rnaT23fWYSAHk?=
 =?us-ascii?Q?qOAUxlI0E6PZv4Ua6z4sAZW3K0F6QdKKP7DhuJBbwFKQebdKZ4vCrDsDpO4W?=
 =?us-ascii?Q?kMFQT1nVU5htac0dXx1KZOK+fLHrq5t+fsC4oPvcPDsVrC48seUMqAfpj61M?=
 =?us-ascii?Q?5wqJhYBJB7qvQmisJ3bplb4pFcvE5vt3lizvj96FiZXmQ10hNtA2FgtgzIm2?=
 =?us-ascii?Q?tcZUpB9/D95S6csoF/aNnSo6mOwPCuj+/A7lzyGV8mejzqSSqsSOz7TtIJyG?=
 =?us-ascii?Q?oXsRt6zAzBTjsR6Mb5GEFHHFIsc5BsFIkzWmt36nZ4t8Bu+A4Ci1IH1TKfsd?=
 =?us-ascii?Q?UssdDALS+hcryADLErlEkzrVdiVK2g+UMEm/yD1T0PfA3TYFOdAEbGPf9osV?=
 =?us-ascii?Q?EHhwT6yVdVU0hVjLile0owsTvkgmLUSkX5xPUdFhAgpUVODgeqjT4UiQ0Sys?=
 =?us-ascii?Q?tWE28hSP81EJYq+XJZ7MstPNhhNWP8/TSrE4DOc417q6xDZtNXUeqhTLkOFK?=
 =?us-ascii?Q?yoDA1dT0FsEwo+IIFMCIF0o6ro9hnBP2BusR71QdEnTEjz8JToWeWPWMxvNO?=
 =?us-ascii?Q?zW877thw7bRCWrabEu6ujLdK6Hy8+pORNOPKeEZ7Apsc5Aaa30xgrABERDKP?=
 =?us-ascii?Q?eEH5BWpY2sKcFA0v4mSTXpC4IHzK6rCokLv6zfYByJjaqgk52jCehH19YuRZ?=
 =?us-ascii?Q?Z4zOeOqcuXM0RWE8cZ9MssyCVlR0xsRDGDC6VxdwVOPqKT8RfiMVCHaNOL3s?=
 =?us-ascii?Q?aUGGXnsIKjQFvNmG9DWAh56I5hKZRkyNBEu41IYwpAREzH6DacS33Oxx4Vp1?=
 =?us-ascii?Q?3enApijmVhSRIHCJMLNqPrX51KG964omMs4/mCY66nxbszHpYxS5Y6SDWffr?=
 =?us-ascii?Q?klSlhth/p7PJSL9Nd/zyMMyUswop2UCy/CyBupYsGnRGNd954Sd+4j1ND2fe?=
 =?us-ascii?Q?x1JDOKGQdAPk2Qys8lM19dr2fpRmXMJlSxo251UbcTX4MhoqXs/j1y8RAT5R?=
 =?us-ascii?Q?su40iWqgyQASU+s4GqJuL918uou0TqnvmfktghfVKE4rX0J9zI2ZWzZkr2X3?=
 =?us-ascii?Q?Y0EqUB4W1KDFxBl32KYNXNgTpkeCch3pD6rhIZUrli67+o+5ldIG+d2KoNKN?=
 =?us-ascii?Q?vny5CeDrg7GEm5xXnCWwOrKMAMIWHQLc0Fm407/zaX1WjSQCP7ypE/it0Kpf?=
 =?us-ascii?Q?QXVr1nWiz9E/mbhfM+Q6Z2gght7v2NAYtxSLrLc80FiFObKqTfl7MtJz/IJW?=
 =?us-ascii?Q?KOEeH5hjL0bpttKSr8mKPNJ/?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 45260c20-b2e2-4a56-e2c7-08d8d9ca3e63
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4488.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2021 20:16:32.9426 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: k/TvjI2iCHeuu97q8nZ+S3RrZaGZSOQ/9fgmhWsrSZ4lUgNnM8nP/w/sVvzmGf/euLI4zhy6ZNI5Ux5FxBL0HA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3872
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
Cc: Alex Deucher <alexander.deucher@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

And just use the ioctl index.  They are the same.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h     |  9 -----
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c | 16 ++++-----
 drivers/gpu/drm/amd/amdgpu/cik.c        | 12 ++++---
 drivers/gpu/drm/amd/amdgpu/nv.c         | 36 ++++++++++---------
 drivers/gpu/drm/amd/amdgpu/si.c         | 12 ++++---
 drivers/gpu/drm/amd/amdgpu/soc15.c      | 46 +++++++++++++------------
 drivers/gpu/drm/amd/amdgpu/vi.c         | 28 ++++++++-------
 7 files changed, 80 insertions(+), 79 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index 09aec16c8feb..9ec99a2df666 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -583,15 +583,6 @@ enum amd_reset_method {
 	AMD_RESET_METHOD_PCI,
 };
 
-#define AMDGPU_VIDEO_CODEC_TYPE_MPEG2			0
-#define AMDGPU_VIDEO_CODEC_TYPE_MPEG4			1
-#define AMDGPU_VIDEO_CODEC_TYPE_VC1			2
-#define AMDGPU_VIDEO_CODEC_TYPE_MPEG4_AVC		3
-#define AMDGPU_VIDEO_CODEC_TYPE_HEVC			4
-#define AMDGPU_VIDEO_CODEC_TYPE_JPEG			5
-#define AMDGPU_VIDEO_CODEC_TYPE_VP9			6
-#define AMDGPU_VIDEO_CODEC_TYPE_AV1			7
-
 struct amdgpu_video_codec_info {
 	u32 codec_type;
 	u32 max_width;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
index 9f35e8a6c421..a5ed84bc83f7 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
@@ -1012,14 +1012,14 @@ int amdgpu_info_ioctl(struct drm_device *dev, void *data, struct drm_file *filp)
 			int idx = codecs->codec_array[i].codec_type;
 
 			switch (idx) {
-			case AMDGPU_VIDEO_CODEC_TYPE_MPEG2:
-			case AMDGPU_VIDEO_CODEC_TYPE_MPEG4:
-			case AMDGPU_VIDEO_CODEC_TYPE_MPEG4_AVC:
-			case AMDGPU_VIDEO_CODEC_TYPE_VC1:
-			case AMDGPU_VIDEO_CODEC_TYPE_HEVC:
-			case AMDGPU_VIDEO_CODEC_TYPE_JPEG:
-			case AMDGPU_VIDEO_CODEC_TYPE_VP9:
-			case AMDGPU_VIDEO_CODEC_TYPE_AV1:
+			case AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_MPEG2:
+			case AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_MPEG4:
+			case AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_VC1:
+			case AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_MPEG4_AVC:
+			case AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_HEVC:
+			case AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_JPEG:
+			case AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_VP9:
+			case AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_AV1:
 				caps->codec_info[idx].valid = 1;
 				caps->codec_info[idx].max_width =
 					codecs->codec_array[i].max_width;
diff --git a/drivers/gpu/drm/amd/amdgpu/cik.c b/drivers/gpu/drm/amd/amdgpu/cik.c
index 72abfad2fd67..c0fcc41ee574 100644
--- a/drivers/gpu/drm/amd/amdgpu/cik.c
+++ b/drivers/gpu/drm/amd/amdgpu/cik.c
@@ -26,6 +26,8 @@
 #include <linux/module.h>
 #include <linux/pci.h>
 
+#include <drm/amdgpu_drm.h>
+
 #include "amdgpu.h"
 #include "amdgpu_atombios.h"
 #include "amdgpu_ih.h"
@@ -73,7 +75,7 @@
 static const struct amdgpu_video_codec_info cik_video_codecs_encode_array[] =
 {
 	{
-		.codec_type = AMDGPU_VIDEO_CODEC_TYPE_MPEG4_AVC,
+		.codec_type = AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_MPEG4_AVC,
 		.max_width = 2048,
 		.max_height = 1152,
 		.max_pixels_per_frame = 2048 * 1152,
@@ -90,28 +92,28 @@ static const struct amdgpu_video_codecs cik_video_codecs_encode =
 static const struct amdgpu_video_codec_info cik_video_codecs_decode_array[] =
 {
 	{
-		.codec_type = AMDGPU_VIDEO_CODEC_TYPE_MPEG2,
+		.codec_type = AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_MPEG2,
 		.max_width = 2048,
 		.max_height = 1152,
 		.max_pixels_per_frame = 2048 * 1152,
 		.max_level = 3,
 	},
 	{
-		.codec_type = AMDGPU_VIDEO_CODEC_TYPE_MPEG4,
+		.codec_type = AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_MPEG4,
 		.max_width = 2048,
 		.max_height = 1152,
 		.max_pixels_per_frame = 2048 * 1152,
 		.max_level = 5,
 	},
 	{
-		.codec_type = AMDGPU_VIDEO_CODEC_TYPE_MPEG4_AVC,
+		.codec_type = AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_MPEG4_AVC,
 		.max_width = 2048,
 		.max_height = 1152,
 		.max_pixels_per_frame = 2048 * 1152,
 		.max_level = 41,
 	},
 	{
-		.codec_type = AMDGPU_VIDEO_CODEC_TYPE_VC1,
+		.codec_type = AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_VC1,
 		.max_width = 2048,
 		.max_height = 1152,
 		.max_pixels_per_frame = 2048 * 1152,
diff --git a/drivers/gpu/drm/amd/amdgpu/nv.c b/drivers/gpu/drm/amd/amdgpu/nv.c
index c7ea779e7d6e..a84ecdea2595 100644
--- a/drivers/gpu/drm/amd/amdgpu/nv.c
+++ b/drivers/gpu/drm/amd/amdgpu/nv.c
@@ -25,6 +25,8 @@
 #include <linux/module.h>
 #include <linux/pci.h>
 
+#include <drm/amdgpu_drm.h>
+
 #include "amdgpu.h"
 #include "amdgpu_atombios.h"
 #include "amdgpu_ih.h"
@@ -69,14 +71,14 @@ static const struct amd_ip_funcs nv_common_ip_funcs;
 static const struct amdgpu_video_codec_info nv_video_codecs_encode_array[] =
 {
 	{
-		.codec_type = AMDGPU_VIDEO_CODEC_TYPE_MPEG4_AVC,
+		.codec_type = AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_MPEG4_AVC,
 		.max_width = 4096,
 		.max_height = 2304,
 		.max_pixels_per_frame = 4096 * 2304,
 		.max_level = 0,
 	},
 	{
-		.codec_type = AMDGPU_VIDEO_CODEC_TYPE_HEVC,
+		.codec_type = AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_HEVC,
 		.max_width = 4096,
 		.max_height = 2304,
 		.max_pixels_per_frame = 4096 * 2304,
@@ -94,49 +96,49 @@ static const struct amdgpu_video_codecs nv_video_codecs_encode =
 static const struct amdgpu_video_codec_info nv_video_codecs_decode_array[] =
 {
 	{
-		.codec_type = AMDGPU_VIDEO_CODEC_TYPE_MPEG2,
+		.codec_type = AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_MPEG2,
 		.max_width = 4096,
 		.max_height = 4096,
 		.max_pixels_per_frame = 4096 * 4096,
 		.max_level = 3,
 	},
 	{
-		.codec_type = AMDGPU_VIDEO_CODEC_TYPE_MPEG4,
+		.codec_type = AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_MPEG4,
 		.max_width = 4096,
 		.max_height = 4096,
 		.max_pixels_per_frame = 4096 * 4096,
 		.max_level = 5,
 	},
 	{
-		.codec_type = AMDGPU_VIDEO_CODEC_TYPE_MPEG4_AVC,
+		.codec_type = AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_MPEG4_AVC,
 		.max_width = 4096,
 		.max_height = 4096,
 		.max_pixels_per_frame = 4096 * 4096,
 		.max_level = 52,
 	},
 	{
-		.codec_type = AMDGPU_VIDEO_CODEC_TYPE_VC1,
+		.codec_type = AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_VC1,
 		.max_width = 4096,
 		.max_height = 4096,
 		.max_pixels_per_frame = 4096 * 4096,
 		.max_level = 4,
 	},
 	{
-		.codec_type = AMDGPU_VIDEO_CODEC_TYPE_HEVC,
+		.codec_type = AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_HEVC,
 		.max_width = 8192,
 		.max_height = 4352,
 		.max_pixels_per_frame = 8192 * 4352,
 		.max_level = 186,
 	},
 	{
-		.codec_type = AMDGPU_VIDEO_CODEC_TYPE_JPEG,
+		.codec_type = AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_JPEG,
 		.max_width = 4096,
 		.max_height = 4096,
 		.max_pixels_per_frame = 4096 * 4096,
 		.max_level = 0,
 	},
 	{
-		.codec_type = AMDGPU_VIDEO_CODEC_TYPE_VP9,
+		.codec_type = AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_VP9,
 		.max_width = 8192,
 		.max_height = 4352,
 		.max_pixels_per_frame = 8192 * 4352,
@@ -154,56 +156,56 @@ static const struct amdgpu_video_codecs nv_video_codecs_decode =
 static const struct amdgpu_video_codec_info sc_video_codecs_decode_array[] =
 {
 	{
-		.codec_type = AMDGPU_VIDEO_CODEC_TYPE_MPEG2,
+		.codec_type = AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_MPEG2,
 		.max_width = 4096,
 		.max_height = 4096,
 		.max_pixels_per_frame = 4096 * 4096,
 		.max_level = 3,
 	},
 	{
-		.codec_type = AMDGPU_VIDEO_CODEC_TYPE_MPEG4,
+		.codec_type = AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_MPEG4,
 		.max_width = 4096,
 		.max_height = 4096,
 		.max_pixels_per_frame = 4096 * 4096,
 		.max_level = 5,
 	},
 	{
-		.codec_type = AMDGPU_VIDEO_CODEC_TYPE_MPEG4_AVC,
+		.codec_type = AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_MPEG4_AVC,
 		.max_width = 4096,
 		.max_height = 4096,
 		.max_pixels_per_frame = 4096 * 4096,
 		.max_level = 52,
 	},
 	{
-		.codec_type = AMDGPU_VIDEO_CODEC_TYPE_VC1,
+		.codec_type = AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_VC1,
 		.max_width = 4096,
 		.max_height = 4096,
 		.max_pixels_per_frame = 4096 * 4096,
 		.max_level = 4,
 	},
 	{
-		.codec_type = AMDGPU_VIDEO_CODEC_TYPE_HEVC,
+		.codec_type = AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_HEVC,
 		.max_width = 8192,
 		.max_height = 4352,
 		.max_pixels_per_frame = 8192 * 4352,
 		.max_level = 186,
 	},
 	{
-		.codec_type = AMDGPU_VIDEO_CODEC_TYPE_JPEG,
+		.codec_type = AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_JPEG,
 		.max_width = 4096,
 		.max_height = 4096,
 		.max_pixels_per_frame = 4096 * 4096,
 		.max_level = 0,
 	},
 	{
-		.codec_type = AMDGPU_VIDEO_CODEC_TYPE_VP9,
+		.codec_type = AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_VP9,
 		.max_width = 8192,
 		.max_height = 4352,
 		.max_pixels_per_frame = 8192 * 4352,
 		.max_level = 0,
 	},
 	{
-		.codec_type = AMDGPU_VIDEO_CODEC_TYPE_AV1,
+		.codec_type = AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_AV1,
 		.max_width = 8192,
 		.max_height = 4352,
 		.max_pixels_per_frame = 8192 * 4352,
diff --git a/drivers/gpu/drm/amd/amdgpu/si.c b/drivers/gpu/drm/amd/amdgpu/si.c
index 489dbcc7040d..7cbc2bb03bc6 100644
--- a/drivers/gpu/drm/amd/amdgpu/si.c
+++ b/drivers/gpu/drm/amd/amdgpu/si.c
@@ -26,6 +26,8 @@
 #include <linux/module.h>
 #include <linux/pci.h>
 
+#include <drm/amdgpu_drm.h>
+
 #include "amdgpu.h"
 #include "amdgpu_atombios.h"
 #include "amdgpu_ih.h"
@@ -911,7 +913,7 @@ static const u32 hainan_mgcg_cgcg_init[] =
 static const struct amdgpu_video_codec_info tahiti_video_codecs_encode_array[] =
 {
 	{
-		.codec_type = AMDGPU_VIDEO_CODEC_TYPE_MPEG4_AVC,
+		.codec_type = AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_MPEG4_AVC,
 		.max_width = 2048,
 		.max_height = 1152,
 		.max_pixels_per_frame = 2048 * 1152,
@@ -942,28 +944,28 @@ static const struct amdgpu_video_codecs hainan_video_codecs_encode =
 static const struct amdgpu_video_codec_info tahiti_video_codecs_decode_array[] =
 {
 	{
-		.codec_type = AMDGPU_VIDEO_CODEC_TYPE_MPEG2,
+		.codec_type = AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_MPEG2,
 		.max_width = 2048,
 		.max_height = 1152,
 		.max_pixels_per_frame = 2048 * 1152,
 		.max_level = 3,
 	},
 	{
-		.codec_type = AMDGPU_VIDEO_CODEC_TYPE_MPEG4,
+		.codec_type = AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_MPEG4,
 		.max_width = 2048,
 		.max_height = 1152,
 		.max_pixels_per_frame = 2048 * 1152,
 		.max_level = 5,
 	},
 	{
-		.codec_type = AMDGPU_VIDEO_CODEC_TYPE_MPEG4_AVC,
+		.codec_type = AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_MPEG4_AVC,
 		.max_width = 2048,
 		.max_height = 1152,
 		.max_pixels_per_frame = 2048 * 1152,
 		.max_level = 41,
 	},
 	{
-		.codec_type = AMDGPU_VIDEO_CODEC_TYPE_VC1,
+		.codec_type = AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_VC1,
 		.max_width = 2048,
 		.max_height = 1152,
 		.max_pixels_per_frame = 2048 * 1152,
diff --git a/drivers/gpu/drm/amd/amdgpu/soc15.c b/drivers/gpu/drm/amd/amdgpu/soc15.c
index f4735d83126b..230caaa3513f 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc15.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc15.c
@@ -25,6 +25,8 @@
 #include <linux/module.h>
 #include <linux/pci.h>
 
+#include <drm/amdgpu_drm.h>
+
 #include "amdgpu.h"
 #include "amdgpu_atombios.h"
 #include "amdgpu_ih.h"
@@ -87,14 +89,14 @@
 static const struct amdgpu_video_codec_info vega_video_codecs_encode_array[] =
 {
 	{
-		.codec_type = AMDGPU_VIDEO_CODEC_TYPE_MPEG4_AVC,
+		.codec_type = AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_MPEG4_AVC,
 		.max_width = 4096,
 		.max_height = 2304,
 		.max_pixels_per_frame = 4096 * 2304,
 		.max_level = 0,
 	},
 	{
-		.codec_type = AMDGPU_VIDEO_CODEC_TYPE_HEVC,
+		.codec_type = AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_HEVC,
 		.max_width = 4096,
 		.max_height = 2304,
 		.max_pixels_per_frame = 4096 * 2304,
@@ -112,42 +114,42 @@ static const struct amdgpu_video_codecs vega_video_codecs_encode =
 static const struct amdgpu_video_codec_info vega_video_codecs_decode_array[] =
 {
 	{
-		.codec_type = AMDGPU_VIDEO_CODEC_TYPE_MPEG2,
+		.codec_type = AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_MPEG2,
 		.max_width = 4096,
 		.max_height = 4096,
 		.max_pixels_per_frame = 4096 * 4096,
 		.max_level = 3,
 	},
 	{
-		.codec_type = AMDGPU_VIDEO_CODEC_TYPE_MPEG4,
+		.codec_type = AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_MPEG4,
 		.max_width = 4096,
 		.max_height = 4096,
 		.max_pixels_per_frame = 4096 * 4096,
 		.max_level = 5,
 	},
 	{
-		.codec_type = AMDGPU_VIDEO_CODEC_TYPE_MPEG4_AVC,
+		.codec_type = AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_MPEG4_AVC,
 		.max_width = 4096,
 		.max_height = 4096,
 		.max_pixels_per_frame = 4096 * 4096,
 		.max_level = 52,
 	},
 	{
-		.codec_type = AMDGPU_VIDEO_CODEC_TYPE_VC1,
+		.codec_type = AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_VC1,
 		.max_width = 4096,
 		.max_height = 4096,
 		.max_pixels_per_frame = 4096 * 4096,
 		.max_level = 4,
 	},
 	{
-		.codec_type = AMDGPU_VIDEO_CODEC_TYPE_HEVC,
+		.codec_type = AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_HEVC,
 		.max_width = 4096,
 		.max_height = 4096,
 		.max_pixels_per_frame = 4096 * 4096,
 		.max_level = 186,
 	},
 	{
-		.codec_type = AMDGPU_VIDEO_CODEC_TYPE_JPEG,
+		.codec_type = AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_JPEG,
 		.max_width = 4096,
 		.max_height = 4096,
 		.max_pixels_per_frame = 4096 * 4096,
@@ -165,49 +167,49 @@ static const struct amdgpu_video_codecs vega_video_codecs_decode =
 static const struct amdgpu_video_codec_info rv_video_codecs_decode_array[] =
 {
 	{
-		.codec_type = AMDGPU_VIDEO_CODEC_TYPE_MPEG2,
+		.codec_type = AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_MPEG2,
 		.max_width = 4096,
 		.max_height = 4096,
 		.max_pixels_per_frame = 4096 * 4096,
 		.max_level = 3,
 	},
 	{
-		.codec_type = AMDGPU_VIDEO_CODEC_TYPE_MPEG4,
+		.codec_type = AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_MPEG4,
 		.max_width = 4096,
 		.max_height = 4096,
 		.max_pixels_per_frame = 4096 * 4096,
 		.max_level = 5,
 	},
 	{
-		.codec_type = AMDGPU_VIDEO_CODEC_TYPE_MPEG4_AVC,
+		.codec_type = AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_MPEG4_AVC,
 		.max_width = 4096,
 		.max_height = 4096,
 		.max_pixels_per_frame = 4096 * 4096,
 		.max_level = 52,
 	},
 	{
-		.codec_type = AMDGPU_VIDEO_CODEC_TYPE_VC1,
+		.codec_type = AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_VC1,
 		.max_width = 4096,
 		.max_height = 4096,
 		.max_pixels_per_frame = 4096 * 4096,
 		.max_level = 4,
 	},
 	{
-		.codec_type = AMDGPU_VIDEO_CODEC_TYPE_HEVC,
+		.codec_type = AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_HEVC,
 		.max_width = 4096,
 		.max_height = 4096,
 		.max_pixels_per_frame = 4096 * 4096,
 		.max_level = 186,
 	},
 	{
-		.codec_type = AMDGPU_VIDEO_CODEC_TYPE_JPEG,
+		.codec_type = AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_JPEG,
 		.max_width = 4096,
 		.max_height = 4096,
 		.max_pixels_per_frame = 4096 * 4096,
 		.max_level = 0,
 	},
 	{
-		.codec_type = AMDGPU_VIDEO_CODEC_TYPE_VP9,
+		.codec_type = AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_VP9,
 		.max_width = 4096,
 		.max_height = 4096,
 		.max_pixels_per_frame = 4096 * 4096,
@@ -225,49 +227,49 @@ static const struct amdgpu_video_codecs rv_video_codecs_decode =
 static const struct amdgpu_video_codec_info rn_video_codecs_decode_array[] =
 {
 	{
-		.codec_type = AMDGPU_VIDEO_CODEC_TYPE_MPEG2,
+		.codec_type = AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_MPEG2,
 		.max_width = 4096,
 		.max_height = 4096,
 		.max_pixels_per_frame = 4096 * 4096,
 		.max_level = 3,
 	},
 	{
-		.codec_type = AMDGPU_VIDEO_CODEC_TYPE_MPEG4,
+		.codec_type = AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_MPEG4,
 		.max_width = 4096,
 		.max_height = 4096,
 		.max_pixels_per_frame = 4096 * 4096,
 		.max_level = 5,
 	},
 	{
-		.codec_type = AMDGPU_VIDEO_CODEC_TYPE_MPEG4_AVC,
+		.codec_type = AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_MPEG4_AVC,
 		.max_width = 4096,
 		.max_height = 4096,
 		.max_pixels_per_frame = 4096 * 4096,
 		.max_level = 52,
 	},
 	{
-		.codec_type = AMDGPU_VIDEO_CODEC_TYPE_VC1,
+		.codec_type = AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_VC1,
 		.max_width = 4096,
 		.max_height = 4096,
 		.max_pixels_per_frame = 4096 * 4096,
 		.max_level = 4,
 	},
 	{
-		.codec_type = AMDGPU_VIDEO_CODEC_TYPE_HEVC,
+		.codec_type = AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_HEVC,
 		.max_width = 8192,
 		.max_height = 4352,
 		.max_pixels_per_frame = 4096 * 4096,
 		.max_level = 186,
 	},
 	{
-		.codec_type = AMDGPU_VIDEO_CODEC_TYPE_JPEG,
+		.codec_type = AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_JPEG,
 		.max_width = 4096,
 		.max_height = 4096,
 		.max_pixels_per_frame = 4096 * 4096,
 		.max_level = 0,
 	},
 	{
-		.codec_type = AMDGPU_VIDEO_CODEC_TYPE_VP9,
+		.codec_type = AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_VP9,
 		.max_width = 8192,
 		.max_height = 4352,
 		.max_pixels_per_frame = 4096 * 4096,
diff --git a/drivers/gpu/drm/amd/amdgpu/vi.c b/drivers/gpu/drm/amd/amdgpu/vi.c
index c33d46a99b7f..ea338de5818a 100644
--- a/drivers/gpu/drm/amd/amdgpu/vi.c
+++ b/drivers/gpu/drm/amd/amdgpu/vi.c
@@ -24,6 +24,8 @@
 #include <linux/pci.h>
 #include <linux/slab.h>
 
+#include <drm/amdgpu_drm.h>
+
 #include "amdgpu.h"
 #include "amdgpu_atombios.h"
 #include "amdgpu_ih.h"
@@ -90,7 +92,7 @@ static const struct amdgpu_video_codecs topaz_video_codecs_encode =
 static const struct amdgpu_video_codec_info tonga_video_codecs_encode_array[] =
 {
 	{
-		.codec_type = AMDGPU_VIDEO_CODEC_TYPE_MPEG4_AVC,
+		.codec_type = AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_MPEG4_AVC,
 		.max_width = 4096,
 		.max_height = 2304,
 		.max_pixels_per_frame = 4096 * 2304,
@@ -108,14 +110,14 @@ static const struct amdgpu_video_codecs tonga_video_codecs_encode =
 static const struct amdgpu_video_codec_info polaris_video_codecs_encode_array[] =
 {
 	{
-		.codec_type = AMDGPU_VIDEO_CODEC_TYPE_MPEG4_AVC,
+		.codec_type = AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_MPEG4_AVC,
 		.max_width = 4096,
 		.max_height = 2304,
 		.max_pixels_per_frame = 4096 * 2304,
 		.max_level = 0,
 	},
 	{
-		.codec_type = AMDGPU_VIDEO_CODEC_TYPE_HEVC,
+		.codec_type = AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_HEVC,
 		.max_width = 4096,
 		.max_height = 2304,
 		.max_pixels_per_frame = 4096 * 2304,
@@ -140,28 +142,28 @@ static const struct amdgpu_video_codecs topaz_video_codecs_decode =
 static const struct amdgpu_video_codec_info tonga_video_codecs_decode_array[] =
 {
 	{
-		.codec_type = AMDGPU_VIDEO_CODEC_TYPE_MPEG2,
+		.codec_type = AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_MPEG2,
 		.max_width = 4096,
 		.max_height = 4096,
 		.max_pixels_per_frame = 4096 * 4096,
 		.max_level = 3,
 	},
 	{
-		.codec_type = AMDGPU_VIDEO_CODEC_TYPE_MPEG4,
+		.codec_type = AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_MPEG4,
 		.max_width = 4096,
 		.max_height = 4096,
 		.max_pixels_per_frame = 4096 * 4096,
 		.max_level = 5,
 	},
 	{
-		.codec_type = AMDGPU_VIDEO_CODEC_TYPE_MPEG4_AVC,
+		.codec_type = AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_MPEG4_AVC,
 		.max_width = 4096,
 		.max_height = 4096,
 		.max_pixels_per_frame = 4096 * 4096,
 		.max_level = 52,
 	},
 	{
-		.codec_type = AMDGPU_VIDEO_CODEC_TYPE_VC1,
+		.codec_type = AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_VC1,
 		.max_width = 4096,
 		.max_height = 4096,
 		.max_pixels_per_frame = 4096 * 4096,
@@ -179,42 +181,42 @@ static const struct amdgpu_video_codecs tonga_video_codecs_decode =
 static const struct amdgpu_video_codec_info cz_video_codecs_decode_array[] =
 {
 	{
-		.codec_type = AMDGPU_VIDEO_CODEC_TYPE_MPEG2,
+		.codec_type = AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_MPEG2,
 		.max_width = 4096,
 		.max_height = 4096,
 		.max_pixels_per_frame = 4096 * 4096,
 		.max_level = 3,
 	},
 	{
-		.codec_type = AMDGPU_VIDEO_CODEC_TYPE_MPEG4,
+		.codec_type = AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_MPEG4,
 		.max_width = 4096,
 		.max_height = 4096,
 		.max_pixels_per_frame = 4096 * 4096,
 		.max_level = 5,
 	},
 	{
-		.codec_type = AMDGPU_VIDEO_CODEC_TYPE_MPEG4_AVC,
+		.codec_type = AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_MPEG4_AVC,
 		.max_width = 4096,
 		.max_height = 4096,
 		.max_pixels_per_frame = 4096 * 4096,
 		.max_level = 52,
 	},
 	{
-		.codec_type = AMDGPU_VIDEO_CODEC_TYPE_VC1,
+		.codec_type = AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_VC1,
 		.max_width = 4096,
 		.max_height = 4096,
 		.max_pixels_per_frame = 4096 * 4096,
 		.max_level = 4,
 	},
 	{
-		.codec_type = AMDGPU_VIDEO_CODEC_TYPE_HEVC,
+		.codec_type = AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_HEVC,
 		.max_width = 4096,
 		.max_height = 4096,
 		.max_pixels_per_frame = 4096 * 4096,
 		.max_level = 186,
 	},
 	{
-		.codec_type = AMDGPU_VIDEO_CODEC_TYPE_JPEG,
+		.codec_type = AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_JPEG,
 		.max_width = 4096,
 		.max_height = 4096,
 		.max_pixels_per_frame = 4096 * 4096,
-- 
2.29.2

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
