Return-Path: <SRS0=n+xW=KC=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8131FC433B4
	for <amd-gfx@archiver.kernel.org>; Fri,  7 May 2021 14:40:13 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 08C18610FC
	for <amd-gfx@archiver.kernel.org>; Fri,  7 May 2021 14:40:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 08C18610FC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6A1646EE38;
	Fri,  7 May 2021 14:40:12 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2057.outbound.protection.outlook.com [40.107.93.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8225E6E087
 for <amd-gfx@lists.freedesktop.org>; Fri,  7 May 2021 14:40:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YknepGKtOXt8O8h3IuJpLkPrkUrDyejo8/V5OXg0tOvhfZuLfy2SC5wkjQliBpr7VWqNBKp4sLF5fwayzGku9I6UYihQS4Ahx0CMTpKhIGts2jVo+fstztdfPEQWkIGep52jUuvK3zAeCZA6z38QteqNIgk2nXexyEdM1R1YpJcWuDd6++qrNd5NGWHqj9a+0R2+jDAfukIXiZLgG6djj1LCGtKuY6hh7fVnPB1dmWfYOaPsi2Q1bF53NOwgqV6lJ364hrfg8o0cqK7haI+aVDak0PKC73DIowUMe4YzQaeUc78JnDfcZsaTrkjtdG5TE/X9wS9Or/hNnXC10C6YcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jKb8j0OAImFHVjCjEIobEZviSea5PZxXuhujXvaQs/M=;
 b=muPF7NK7X1QUcjI+XVvnK/sPkOAmimQFFMRipEssIlKS4lk1KRLpj27zSeTTV4Md7hKU9B4y4jvLjqUk01lMQvzbBbFo2eTfDzakRpTR8Wk9icamzTKKYf6j3h0zF9L+0oSq4BYLqdiBfwlCAH5SWrUF+x6IUFMzQp9cVwsfGMilzyYBKCnZMIQ5/9+/jFxRMjN5eeAVZ/wP0M+9SyL9PTkSqgX2obEY5fyokrdYO5UCBxHnPiikrP/ZoMT2xCa6EVBM0TdJt0MB2mvAUD4KkwIYogNiY/MCZvg8fS29qLvf4GKbOrj0rYPyeu7fgwIvE+X9xp0N/oP509pkdm0qVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jKb8j0OAImFHVjCjEIobEZviSea5PZxXuhujXvaQs/M=;
 b=0IH5kLgaWmJG1OXIaDIIVwpNtw/xpRRFAjH/vhas/nTAmC+OcaXLbhABssoFcFmWwfOXlQk3J3MrKwOsHxsEN1LV0l9XArtM17EKFvOD1oEDH786uDKMZmRYoXqfBGRoItnV4ozArwAdf/tMmuUBBCUzWcQ5HxJfm0YWYwvm61o=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2601.namprd12.prod.outlook.com (2603:10b6:5:45::27) by
 DM5PR1201MB2490.namprd12.prod.outlook.com (2603:10b6:3:e3::20) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4108.26; Fri, 7 May 2021 14:40:00 +0000
Received: from DM6PR12MB2601.namprd12.prod.outlook.com
 ([fe80::3d2c:5edf:5d51:4101]) by DM6PR12MB2601.namprd12.prod.outlook.com
 ([fe80::3d2c:5edf:5d51:4101%7]) with mapi id 15.20.4108.027; Fri, 7 May 2021
 14:40:00 +0000
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amd/display: Move plane code from amdgpu_dm to
 amdgpu_dm_plane
Date: Fri,  7 May 2021 10:39:42 -0400
Message-Id: <20210507143942.1546281-1-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.25.1
X-Originating-IP: [2607:fea8:56e0:6d60:ae2c:6ad7:f7d8:54c2]
X-ClientProxiedBy: BN9PR03CA0183.namprd03.prod.outlook.com
 (2603:10b6:408:f9::8) To DM6PR12MB2601.namprd12.prod.outlook.com
 (2603:10b6:5:45::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from atma2.hitronhub.home (2607:fea8:56e0:6d60:ae2c:6ad7:f7d8:54c2)
 by BN9PR03CA0183.namprd03.prod.outlook.com (2603:10b6:408:f9::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.25 via Frontend
 Transport; Fri, 7 May 2021 14:39:59 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9baa8ad9-6979-45ab-bd39-08d91165fe2f
X-MS-TrafficTypeDiagnostic: DM5PR1201MB2490:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR1201MB2490DB316D879C22435BCCC798579@DM5PR1201MB2490.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:346;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Cq5BLU7TbBhB4EX9taYXiV/Kk1bQ4zuXloZYEP5D4imXolRWQ0Kn/KVPGR651SaQlwnzg669N82mPY0X3zEque/9GWtmLUX29Aitj5/Zy9RIjgjEJZnY71zLW0iRn+fYdLNHHRuyhoNHfxA0X/qLI/9MhW64t9SKvQ+J1MP/BRvBqX8MNcLOel6ZNQk4TLYCKmKCfG+wK3+qIQTmqToeKG9QrEtCfGYZbeHuPYMNuWpEvvcpmGB4PljHq9H8pyugx8AtXTPuL28slPK0W8a3f96mL45BCZhdfstSf7XR5caFMmv79WvcWIn3Q0g0vLL0TuZO1dRSGnvp0zyS5tbHkDtL9n28kiby4KQY4DHCKQm62gfMs5lQb/RyQL7Br1K+gctAwVuTGaeuMPbNWA29UjojHOKj4HJQ8PIB/ogepkEJak3BAoy2ECgqN8nBAfKXS6+yYhwj6tQh7cO/hX0e7STrDQQtsi/4sw6yGnCnmkbNMogFlvolGKlEQp4QtQzGrwpn/11zyfxvsjSkcBYx3onfgCyH/zg56eOP54Dv+QEPVXBqy4IByj0UOr1YOmfAlWEe6I/aiS8C+zkE5xJ+9ngDoQ14LgVuGazCdb148/PIi9cSFzLKOt/Q6Lf6mq3kOFTIHKVBlPbQs/Z9pxF7/Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2601.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(136003)(39860400002)(366004)(346002)(396003)(52116002)(30864003)(8676002)(2906002)(83380400001)(316002)(1076003)(4326008)(6486002)(38100700002)(16526019)(6666004)(6512007)(478600001)(66476007)(6916009)(5660300002)(36756003)(66556008)(2616005)(186003)(8936002)(86362001)(66946007)(6506007)(21314003)(559001)(579004);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?t45o8KDLr7C439LSGiYkx03v1bfww+zvazhpbRGgZL0Iky+Zwh5Ou47fuos3?=
 =?us-ascii?Q?8TPaF5Ur0qfm+u4nIsU300hGoDzqs4CHMQOGzsSIJZnLlmlhI1T5QmvvVij5?=
 =?us-ascii?Q?nL+QuYEWz0HAYZhvX5O2N1L4UKk10sVKIhM4YdjMMOwp7MIF4QZ5ALLn2Iu9?=
 =?us-ascii?Q?ZVGi42Op+NPcLLBcDMY1h/Mrm4v7ZR7Ob9QkHj6rqAgLVCfZb1oW69w1cITH?=
 =?us-ascii?Q?5R1/8rds6mF5TSNYEcgEnA99kxO8XaNKCeybDmJUOH1RJwWOc7y0KvtHByjs?=
 =?us-ascii?Q?fImSl0lUOMRt2iUX1HhKgo4c7lgjlJLpNRia327wI7Ppz4Mi7FDxWoJP57AO?=
 =?us-ascii?Q?VlOwAVPDfdnklkogP6UyV2ut/NWtzYMWt8b96O/gEwmfxgW0AcCgsqwaiUst?=
 =?us-ascii?Q?lyVrXS3uejS8wF4OerxlTgjA0/b9rnhYxV2xc9MriykxF0oXgi2dkprE8tlQ?=
 =?us-ascii?Q?g309g3lkbOmTwSPTr65XXYOleKbUmQev23kChcHKTB19co0diYMJE84AcZcC?=
 =?us-ascii?Q?SSx3xxFxBjfFRQ5gu9MTmgVklhH3W2bcYSd4vfU04WD2na3A76cUV7xwe6RC?=
 =?us-ascii?Q?jatwgx5oZeLfOFcY+hXM1aHA0h0/Bq8r/xR44uM30BG4pHD9IyMDnF2fNwZ2?=
 =?us-ascii?Q?WQWLRsg09qeIouzbcGiSYGUNPoM4kCa/rsSEAX6TnNfhEtmuUA86Dp/ss+Sj?=
 =?us-ascii?Q?8q5D0MOD+beRq8fWv39Wy9khvrYRHWTN6E8HRv/UnyX0PdCgdFLHg2wWhZ5g?=
 =?us-ascii?Q?pwhrj2lLCMQ4GmW+0x/V2QJ8vQwouSZrphrGF0IijzanayAnMzM+nZPDIurx?=
 =?us-ascii?Q?CoPcWqW2iDz9RoF156YKT0Tt2Y047WvX9DQRUvSn0KNVsRzbfnV63xynLMbk?=
 =?us-ascii?Q?3o5CvCf61uoxpGBj7sKQ2V/Wu7DaKYR/dRPtmkX256AfULbw+NLuYCWyz2aD?=
 =?us-ascii?Q?TvE+NRbOB1Lb7zf3T4LNNDZKt1oeAEnQIHzvlMqg07i6s1SHBtTzUs64BRKm?=
 =?us-ascii?Q?6ieU5kV8COiG2gxC8KhxcNoiBletqyVPLb0a0Zl3cLa/6ENcyrVp8loNtYDe?=
 =?us-ascii?Q?bWHzzakIIpiO4CvilkwAfprzgzavNToAcNsTOhVxWzjxaWN9rQP94ErVqwQX?=
 =?us-ascii?Q?3Z/iZHjFpR/hJyof/FCat+kR4oyV3Up4IJv3hn8MGMoR4fRxztbGTVbjOb5M?=
 =?us-ascii?Q?CgwilOQWay92nOtnAG8cL0jnyJhiXGLDFXcBKzjk8D4ApUJsbRpbnDxtzZMU?=
 =?us-ascii?Q?YSZyNdvS9EDEyXgBHw3MRj45LBMmj4uLKiss3fVXrE/xBgJXa/p52guTQvdS?=
 =?us-ascii?Q?IV6MhPolIXv88QVUO1c3beFCn/x3sqNmo8YzXLpbF4eDk0WXjmGvmhBTrJkU?=
 =?us-ascii?Q?gFnf3ctyQxiwzrhqK9HTb7pa4Zgg?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9baa8ad9-6979-45ab-bd39-08d91165fe2f
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2601.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2021 14:40:00.6534 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aEZVznj1/fI0e8Ll7Rc01vBnathlaAPLLTp2t217Z4ae626O6IO04LzbdqHVTfJ7Ahfb+xAraoMIjin6DEg8pg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB2490
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
Cc: Bhawanpreet.Lakha@amd.com, Harry Wentland <harry.wentland@amd.com>,
 nicholas.kazlauskas@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

The amdgpu_dm file contains most of the code that works as an interface
between DRM API and Display Core. We maintain all the plane operations
inside amdgpu_dm; this commit extracts the plane code to its specific
file named amdgpu_dm_plane. This commit does not introduce any
functional change to the functions; it only changes some static
functions to global and adds some minor adjustments related to the copy
from one place to another.

Signed-off-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/Makefile    |    9 +-
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 1479 +---------------
 .../amd/display/amdgpu_dm/amdgpu_dm_plane.c   | 1496 +++++++++++++++++
 .../amd/display/amdgpu_dm/amdgpu_dm_plane.h   |   56 +
 4 files changed, 1559 insertions(+), 1481 deletions(-)
 create mode 100644 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
 create mode 100644 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.h

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/Makefile b/drivers/gpu/drm/amd/display/amdgpu_dm/Makefile
index 9a3b7bf8ab0b..6542ef0ff83e 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/Makefile
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/Makefile
@@ -23,9 +23,12 @@
 # Makefile for the 'dm' sub-component of DAL.
 # It provides the control and status of dm blocks.
 
-
-
-AMDGPUDM = amdgpu_dm.o amdgpu_dm_irq.o amdgpu_dm_mst_types.o amdgpu_dm_color.o
+AMDGPUDM := \
+	amdgpu_dm.o \
+	amdgpu_dm_color.o \
+	amdgpu_dm_irq.o \
+	amdgpu_dm_mst_types.o \
+	amdgpu_dm_plane.o
 
 ifneq ($(CONFIG_DRM_AMD_DC),)
 AMDGPUDM += amdgpu_dm_services.o amdgpu_dm_helpers.o amdgpu_dm_pp_smu.o
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index cc048c348a92..60ddb4d8be6c 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -44,6 +44,7 @@
 #include "amdgpu_ucode.h"
 #include "atom.h"
 #include "amdgpu_dm.h"
+#include "amdgpu_dm_plane.h"
 #ifdef CONFIG_DRM_AMD_DC_HDCP
 #include "amdgpu_dm_hdcp.h"
 #include <drm/drm_hdcp.h>
@@ -181,10 +182,6 @@ static int amdgpu_dm_initialize_drm_device(struct amdgpu_device *adev);
 /* removes and deallocates the drm structures, created by the above function */
 static void amdgpu_dm_destroy_drm_device(struct amdgpu_display_manager *dm);
 
-static int amdgpu_dm_plane_init(struct amdgpu_display_manager *dm,
-				struct drm_plane *plane,
-				unsigned long possible_crtcs,
-				const struct dc_plane_cap *plane_cap);
 static int amdgpu_dm_crtc_init(struct amdgpu_display_manager *dm,
 			       struct drm_plane *plane,
 			       uint32_t link_index);
@@ -203,9 +200,6 @@ static void amdgpu_dm_atomic_commit_tail(struct drm_atomic_state *state);
 static int amdgpu_dm_atomic_check(struct drm_device *dev,
 				  struct drm_atomic_state *state);
 
-static void handle_cursor_update(struct drm_plane *plane,
-				 struct drm_plane_state *old_plane_state);
-
 static void amdgpu_dm_set_psr_caps(struct dc_link *link);
 static bool amdgpu_dm_psr_enable(struct dc_stream_state *stream);
 static bool amdgpu_dm_link_setup_psr(struct dc_stream_state *stream);
@@ -4125,925 +4119,12 @@ static const struct drm_encoder_funcs amdgpu_dm_encoder_funcs = {
 	.destroy = amdgpu_dm_encoder_destroy,
 };
 
-
-static void get_min_max_dc_plane_scaling(struct drm_device *dev,
-					 struct drm_framebuffer *fb,
-					 int *min_downscale, int *max_upscale)
-{
-	struct amdgpu_device *adev = drm_to_adev(dev);
-	struct dc *dc = adev->dm.dc;
-	/* Caps for all supported planes are the same on DCE and DCN 1 - 3 */
-	struct dc_plane_cap *plane_cap = &dc->caps.planes[0];
-
-	switch (fb->format->format) {
-	case DRM_FORMAT_P010:
-	case DRM_FORMAT_NV12:
-	case DRM_FORMAT_NV21:
-		*max_upscale = plane_cap->max_upscale_factor.nv12;
-		*min_downscale = plane_cap->max_downscale_factor.nv12;
-		break;
-
-	case DRM_FORMAT_XRGB16161616F:
-	case DRM_FORMAT_ARGB16161616F:
-	case DRM_FORMAT_XBGR16161616F:
-	case DRM_FORMAT_ABGR16161616F:
-		*max_upscale = plane_cap->max_upscale_factor.fp16;
-		*min_downscale = plane_cap->max_downscale_factor.fp16;
-		break;
-
-	default:
-		*max_upscale = plane_cap->max_upscale_factor.argb8888;
-		*min_downscale = plane_cap->max_downscale_factor.argb8888;
-		break;
-	}
-
-	/*
-	 * A factor of 1 in the plane_cap means to not allow scaling, ie. use a
-	 * scaling factor of 1.0 == 1000 units.
-	 */
-	if (*max_upscale == 1)
-		*max_upscale = 1000;
-
-	if (*min_downscale == 1)
-		*min_downscale = 1000;
-}
-
-
-static int fill_dc_scaling_info(const struct drm_plane_state *state,
-				struct dc_scaling_info *scaling_info)
-{
-	int scale_w, scale_h, min_downscale, max_upscale;
-
-	memset(scaling_info, 0, sizeof(*scaling_info));
-
-	/* Source is fixed 16.16 but we ignore mantissa for now... */
-	scaling_info->src_rect.x = state->src_x >> 16;
-	scaling_info->src_rect.y = state->src_y >> 16;
-
-	/*
-	 * For reasons we don't (yet) fully understand a non-zero
-	 * src_y coordinate into an NV12 buffer can cause a
-	 * system hang. To avoid hangs (and maybe be overly cautious)
-	 * let's reject both non-zero src_x and src_y.
-	 *
-	 * We currently know of only one use-case to reproduce a
-	 * scenario with non-zero src_x and src_y for NV12, which
-	 * is to gesture the YouTube Android app into full screen
-	 * on ChromeOS.
-	 */
-	if (state->fb &&
-	    state->fb->format->format == DRM_FORMAT_NV12 &&
-	    (scaling_info->src_rect.x != 0 ||
-	     scaling_info->src_rect.y != 0))
-		return -EINVAL;
-
-	scaling_info->src_rect.width = state->src_w >> 16;
-	if (scaling_info->src_rect.width == 0)
-		return -EINVAL;
-
-	scaling_info->src_rect.height = state->src_h >> 16;
-	if (scaling_info->src_rect.height == 0)
-		return -EINVAL;
-
-	scaling_info->dst_rect.x = state->crtc_x;
-	scaling_info->dst_rect.y = state->crtc_y;
-
-	if (state->crtc_w == 0)
-		return -EINVAL;
-
-	scaling_info->dst_rect.width = state->crtc_w;
-
-	if (state->crtc_h == 0)
-		return -EINVAL;
-
-	scaling_info->dst_rect.height = state->crtc_h;
-
-	/* DRM doesn't specify clipping on destination output. */
-	scaling_info->clip_rect = scaling_info->dst_rect;
-
-	/* Validate scaling per-format with DC plane caps */
-	if (state->plane && state->plane->dev && state->fb) {
-		get_min_max_dc_plane_scaling(state->plane->dev, state->fb,
-					     &min_downscale, &max_upscale);
-	} else {
-		min_downscale = 250;
-		max_upscale = 16000;
-	}
-
-	scale_w = scaling_info->dst_rect.width * 1000 /
-		  scaling_info->src_rect.width;
-
-	if (scale_w < min_downscale || scale_w > max_upscale)
-		return -EINVAL;
-
-	scale_h = scaling_info->dst_rect.height * 1000 /
-		  scaling_info->src_rect.height;
-
-	if (scale_h < min_downscale || scale_h > max_upscale)
-		return -EINVAL;
-
-	/*
-	 * The "scaling_quality" can be ignored for now, quality = 0 has DC
-	 * assume reasonable defaults based on the format.
-	 */
-
-	return 0;
-}
-
-static void
-fill_gfx8_tiling_info_from_flags(union dc_tiling_info *tiling_info,
-				 uint64_t tiling_flags)
-{
-	/* Fill GFX8 params */
-	if (AMDGPU_TILING_GET(tiling_flags, ARRAY_MODE) == DC_ARRAY_2D_TILED_THIN1) {
-		unsigned int bankw, bankh, mtaspect, tile_split, num_banks;
-
-		bankw = AMDGPU_TILING_GET(tiling_flags, BANK_WIDTH);
-		bankh = AMDGPU_TILING_GET(tiling_flags, BANK_HEIGHT);
-		mtaspect = AMDGPU_TILING_GET(tiling_flags, MACRO_TILE_ASPECT);
-		tile_split = AMDGPU_TILING_GET(tiling_flags, TILE_SPLIT);
-		num_banks = AMDGPU_TILING_GET(tiling_flags, NUM_BANKS);
-
-		/* XXX fix me for VI */
-		tiling_info->gfx8.num_banks = num_banks;
-		tiling_info->gfx8.array_mode =
-				DC_ARRAY_2D_TILED_THIN1;
-		tiling_info->gfx8.tile_split = tile_split;
-		tiling_info->gfx8.bank_width = bankw;
-		tiling_info->gfx8.bank_height = bankh;
-		tiling_info->gfx8.tile_aspect = mtaspect;
-		tiling_info->gfx8.tile_mode =
-				DC_ADDR_SURF_MICRO_TILING_DISPLAY;
-	} else if (AMDGPU_TILING_GET(tiling_flags, ARRAY_MODE)
-			== DC_ARRAY_1D_TILED_THIN1) {
-		tiling_info->gfx8.array_mode = DC_ARRAY_1D_TILED_THIN1;
-	}
-
-	tiling_info->gfx8.pipe_config =
-			AMDGPU_TILING_GET(tiling_flags, PIPE_CONFIG);
-}
-
-static void
-fill_gfx9_tiling_info_from_device(const struct amdgpu_device *adev,
-				  union dc_tiling_info *tiling_info)
-{
-	tiling_info->gfx9.num_pipes =
-		adev->gfx.config.gb_addr_config_fields.num_pipes;
-	tiling_info->gfx9.num_banks =
-		adev->gfx.config.gb_addr_config_fields.num_banks;
-	tiling_info->gfx9.pipe_interleave =
-		adev->gfx.config.gb_addr_config_fields.pipe_interleave_size;
-	tiling_info->gfx9.num_shader_engines =
-		adev->gfx.config.gb_addr_config_fields.num_se;
-	tiling_info->gfx9.max_compressed_frags =
-		adev->gfx.config.gb_addr_config_fields.max_compress_frags;
-	tiling_info->gfx9.num_rb_per_se =
-		adev->gfx.config.gb_addr_config_fields.num_rb_per_se;
-	tiling_info->gfx9.shaderEnable = 1;
-	if (adev->asic_type == CHIP_SIENNA_CICHLID ||
-	    adev->asic_type == CHIP_NAVY_FLOUNDER ||
-	    adev->asic_type == CHIP_DIMGREY_CAVEFISH ||
-	    adev->asic_type == CHIP_VANGOGH)
-		tiling_info->gfx9.num_pkrs = adev->gfx.config.gb_addr_config_fields.num_pkrs;
-}
-
-static int
-validate_dcc(struct amdgpu_device *adev,
-	     const enum surface_pixel_format format,
-	     const enum dc_rotation_angle rotation,
-	     const union dc_tiling_info *tiling_info,
-	     const struct dc_plane_dcc_param *dcc,
-	     const struct dc_plane_address *address,
-	     const struct plane_size *plane_size)
-{
-	struct dc *dc = adev->dm.dc;
-	struct dc_dcc_surface_param input;
-	struct dc_surface_dcc_cap output;
-
-	memset(&input, 0, sizeof(input));
-	memset(&output, 0, sizeof(output));
-
-	if (!dcc->enable)
-		return 0;
-
-	if (format >= SURFACE_PIXEL_FORMAT_VIDEO_BEGIN ||
-	    !dc->cap_funcs.get_dcc_compression_cap)
-		return -EINVAL;
-
-	input.format = format;
-	input.surface_size.width = plane_size->surface_size.width;
-	input.surface_size.height = plane_size->surface_size.height;
-	input.swizzle_mode = tiling_info->gfx9.swizzle;
-
-	if (rotation == ROTATION_ANGLE_0 || rotation == ROTATION_ANGLE_180)
-		input.scan = SCAN_DIRECTION_HORIZONTAL;
-	else if (rotation == ROTATION_ANGLE_90 || rotation == ROTATION_ANGLE_270)
-		input.scan = SCAN_DIRECTION_VERTICAL;
-
-	if (!dc->cap_funcs.get_dcc_compression_cap(dc, &input, &output))
-		return -EINVAL;
-
-	if (!output.capable)
-		return -EINVAL;
-
-	if (dcc->independent_64b_blks == 0 &&
-	    output.grph.rgb.independent_64b_blks != 0)
-		return -EINVAL;
-
-	return 0;
-}
-
-static bool
-modifier_has_dcc(uint64_t modifier)
-{
-	return IS_AMD_FMT_MOD(modifier) && AMD_FMT_MOD_GET(DCC, modifier);
-}
-
-static unsigned
-modifier_gfx9_swizzle_mode(uint64_t modifier)
-{
-	if (modifier == DRM_FORMAT_MOD_LINEAR)
-		return 0;
-
-	return AMD_FMT_MOD_GET(TILE, modifier);
-}
-
 static const struct drm_format_info *
 amd_get_format_info(const struct drm_mode_fb_cmd2 *cmd)
 {
 	return amdgpu_lookup_format_info(cmd->pixel_format, cmd->modifier[0]);
 }
 
-static void
-fill_gfx9_tiling_info_from_modifier(const struct amdgpu_device *adev,
-				    union dc_tiling_info *tiling_info,
-				    uint64_t modifier)
-{
-	unsigned int mod_bank_xor_bits = AMD_FMT_MOD_GET(BANK_XOR_BITS, modifier);
-	unsigned int mod_pipe_xor_bits = AMD_FMT_MOD_GET(PIPE_XOR_BITS, modifier);
-	unsigned int pkrs_log2 = AMD_FMT_MOD_GET(PACKERS, modifier);
-	unsigned int pipes_log2 = min(4u, mod_pipe_xor_bits);
-
-	fill_gfx9_tiling_info_from_device(adev, tiling_info);
-
-	if (!IS_AMD_FMT_MOD(modifier))
-		return;
-
-	tiling_info->gfx9.num_pipes = 1u << pipes_log2;
-	tiling_info->gfx9.num_shader_engines = 1u << (mod_pipe_xor_bits - pipes_log2);
-
-	if (adev->family >= AMDGPU_FAMILY_NV) {
-		tiling_info->gfx9.num_pkrs = 1u << pkrs_log2;
-	} else {
-		tiling_info->gfx9.num_banks = 1u << mod_bank_xor_bits;
-
-		/* for DCC we know it isn't rb aligned, so rb_per_se doesn't matter. */
-	}
-}
-
-enum dm_micro_swizzle {
-	MICRO_SWIZZLE_Z = 0,
-	MICRO_SWIZZLE_S = 1,
-	MICRO_SWIZZLE_D = 2,
-	MICRO_SWIZZLE_R = 3
-};
-
-static bool dm_plane_format_mod_supported(struct drm_plane *plane,
-					  uint32_t format,
-					  uint64_t modifier)
-{
-	struct amdgpu_device *adev = drm_to_adev(plane->dev);
-	const struct drm_format_info *info = drm_format_info(format);
-	int i;
-
-	enum dm_micro_swizzle microtile = modifier_gfx9_swizzle_mode(modifier) & 3;
-
-	if (!info)
-		return false;
-
-	/*
-	 * We always have to allow these modifiers:
-	 * 1. Core DRM checks for LINEAR support if userspace does not provide modifiers.
-	 * 2. Not passing any modifiers is the same as explicitly passing INVALID.
-	 */
-	if (modifier == DRM_FORMAT_MOD_LINEAR ||
-	    modifier == DRM_FORMAT_MOD_INVALID) {
-		return true;
-	}
-
-	/* Check that the modifier is on the list of the plane's supported modifiers. */
-	for (i = 0; i < plane->modifier_count; i++) {
-		if (modifier == plane->modifiers[i])
-			break;
-	}
-	if (i == plane->modifier_count)
-		return false;
-
-	/*
-	 * For D swizzle the canonical modifier depends on the bpp, so check
-	 * it here.
-	 */
-	if (AMD_FMT_MOD_GET(TILE_VERSION, modifier) == AMD_FMT_MOD_TILE_VER_GFX9 &&
-	    adev->family >= AMDGPU_FAMILY_NV) {
-		if (microtile == MICRO_SWIZZLE_D && info->cpp[0] == 4)
-			return false;
-	}
-
-	if (adev->family >= AMDGPU_FAMILY_RV && microtile == MICRO_SWIZZLE_D &&
-	    info->cpp[0] < 8)
-		return false;
-
-	if (modifier_has_dcc(modifier)) {
-		/* Per radeonsi comments 16/64 bpp are more complicated. */
-		if (info->cpp[0] != 4)
-			return false;
-		/* We support multi-planar formats, but not when combined with
-		 * additional DCC metadata planes. */
-		if (info->num_planes > 1)
-			return false;
-	}
-
-	return true;
-}
-
-static void
-add_modifier(uint64_t **mods, uint64_t *size, uint64_t *cap, uint64_t mod)
-{
-	if (!*mods)
-		return;
-
-	if (*cap - *size < 1) {
-		uint64_t new_cap = *cap * 2;
-		uint64_t *new_mods = kmalloc(new_cap * sizeof(uint64_t), GFP_KERNEL);
-
-		if (!new_mods) {
-			kfree(*mods);
-			*mods = NULL;
-			return;
-		}
-
-		memcpy(new_mods, *mods, sizeof(uint64_t) * *size);
-		kfree(*mods);
-		*mods = new_mods;
-		*cap = new_cap;
-	}
-
-	(*mods)[*size] = mod;
-	*size += 1;
-}
-
-static void
-add_gfx9_modifiers(const struct amdgpu_device *adev,
-		   uint64_t **mods, uint64_t *size, uint64_t *capacity)
-{
-	int pipes = ilog2(adev->gfx.config.gb_addr_config_fields.num_pipes);
-	int pipe_xor_bits = min(8, pipes +
-				ilog2(adev->gfx.config.gb_addr_config_fields.num_se));
-	int bank_xor_bits = min(8 - pipe_xor_bits,
-				ilog2(adev->gfx.config.gb_addr_config_fields.num_banks));
-	int rb = ilog2(adev->gfx.config.gb_addr_config_fields.num_se) +
-		 ilog2(adev->gfx.config.gb_addr_config_fields.num_rb_per_se);
-
-
-	if (adev->family == AMDGPU_FAMILY_RV) {
-		/* Raven2 and later */
-		bool has_constant_encode = adev->asic_type > CHIP_RAVEN || adev->external_rev_id >= 0x81;
-
-		/*
-		 * No _D DCC swizzles yet because we only allow 32bpp, which
-		 * doesn't support _D on DCN
-		 */
-
-		if (has_constant_encode) {
-			add_modifier(mods, size, capacity, AMD_FMT_MOD |
-				    AMD_FMT_MOD_SET(TILE, AMD_FMT_MOD_TILE_GFX9_64K_S_X) |
-				    AMD_FMT_MOD_SET(TILE_VERSION, AMD_FMT_MOD_TILE_VER_GFX9) |
-				    AMD_FMT_MOD_SET(PIPE_XOR_BITS, pipe_xor_bits) |
-				    AMD_FMT_MOD_SET(BANK_XOR_BITS, bank_xor_bits) |
-				    AMD_FMT_MOD_SET(DCC, 1) |
-				    AMD_FMT_MOD_SET(DCC_INDEPENDENT_64B, 1) |
-				    AMD_FMT_MOD_SET(DCC_MAX_COMPRESSED_BLOCK, AMD_FMT_MOD_DCC_BLOCK_64B) |
-				    AMD_FMT_MOD_SET(DCC_CONSTANT_ENCODE, 1));
-		}
-
-		add_modifier(mods, size, capacity, AMD_FMT_MOD |
-			    AMD_FMT_MOD_SET(TILE, AMD_FMT_MOD_TILE_GFX9_64K_S_X) |
-			    AMD_FMT_MOD_SET(TILE_VERSION, AMD_FMT_MOD_TILE_VER_GFX9) |
-			    AMD_FMT_MOD_SET(PIPE_XOR_BITS, pipe_xor_bits) |
-			    AMD_FMT_MOD_SET(BANK_XOR_BITS, bank_xor_bits) |
-			    AMD_FMT_MOD_SET(DCC, 1) |
-			    AMD_FMT_MOD_SET(DCC_INDEPENDENT_64B, 1) |
-			    AMD_FMT_MOD_SET(DCC_MAX_COMPRESSED_BLOCK, AMD_FMT_MOD_DCC_BLOCK_64B) |
-			    AMD_FMT_MOD_SET(DCC_CONSTANT_ENCODE, 0));
-
-		if (has_constant_encode) {
-			add_modifier(mods, size, capacity, AMD_FMT_MOD |
-				    AMD_FMT_MOD_SET(TILE, AMD_FMT_MOD_TILE_GFX9_64K_S_X) |
-				    AMD_FMT_MOD_SET(TILE_VERSION, AMD_FMT_MOD_TILE_VER_GFX9) |
-				    AMD_FMT_MOD_SET(PIPE_XOR_BITS, pipe_xor_bits) |
-				    AMD_FMT_MOD_SET(BANK_XOR_BITS, bank_xor_bits) |
-				    AMD_FMT_MOD_SET(DCC, 1) |
-				    AMD_FMT_MOD_SET(DCC_RETILE, 1) |
-				    AMD_FMT_MOD_SET(DCC_INDEPENDENT_64B, 1) |
-				    AMD_FMT_MOD_SET(DCC_MAX_COMPRESSED_BLOCK, AMD_FMT_MOD_DCC_BLOCK_64B) |
-
-				    AMD_FMT_MOD_SET(DCC_CONSTANT_ENCODE, 1) |
-				    AMD_FMT_MOD_SET(RB, rb) |
-				    AMD_FMT_MOD_SET(PIPE, pipes));
-		}
-
-		add_modifier(mods, size, capacity, AMD_FMT_MOD |
-			    AMD_FMT_MOD_SET(TILE, AMD_FMT_MOD_TILE_GFX9_64K_S_X) |
-			    AMD_FMT_MOD_SET(TILE_VERSION, AMD_FMT_MOD_TILE_VER_GFX9) |
-			    AMD_FMT_MOD_SET(PIPE_XOR_BITS, pipe_xor_bits) |
-			    AMD_FMT_MOD_SET(BANK_XOR_BITS, bank_xor_bits) |
-			    AMD_FMT_MOD_SET(DCC, 1) |
-			    AMD_FMT_MOD_SET(DCC_RETILE, 1) |
-			    AMD_FMT_MOD_SET(DCC_INDEPENDENT_64B, 1) |
-			    AMD_FMT_MOD_SET(DCC_MAX_COMPRESSED_BLOCK, AMD_FMT_MOD_DCC_BLOCK_64B) |
-			    AMD_FMT_MOD_SET(DCC_CONSTANT_ENCODE, 0) |
-			    AMD_FMT_MOD_SET(RB, rb) |
-			    AMD_FMT_MOD_SET(PIPE, pipes));
-	}
-
-	/*
-	 * Only supported for 64bpp on Raven, will be filtered on format in
-	 * dm_plane_format_mod_supported.
-	 */
-	add_modifier(mods, size, capacity, AMD_FMT_MOD |
-		    AMD_FMT_MOD_SET(TILE, AMD_FMT_MOD_TILE_GFX9_64K_D_X) |
-		    AMD_FMT_MOD_SET(TILE_VERSION, AMD_FMT_MOD_TILE_VER_GFX9) |
-		    AMD_FMT_MOD_SET(PIPE_XOR_BITS, pipe_xor_bits) |
-		    AMD_FMT_MOD_SET(BANK_XOR_BITS, bank_xor_bits));
-
-	if (adev->family == AMDGPU_FAMILY_RV) {
-		add_modifier(mods, size, capacity, AMD_FMT_MOD |
-			    AMD_FMT_MOD_SET(TILE, AMD_FMT_MOD_TILE_GFX9_64K_S_X) |
-			    AMD_FMT_MOD_SET(TILE_VERSION, AMD_FMT_MOD_TILE_VER_GFX9) |
-			    AMD_FMT_MOD_SET(PIPE_XOR_BITS, pipe_xor_bits) |
-			    AMD_FMT_MOD_SET(BANK_XOR_BITS, bank_xor_bits));
-	}
-
-	/*
-	 * Only supported for 64bpp on Raven, will be filtered on format in
-	 * dm_plane_format_mod_supported.
-	 */
-	add_modifier(mods, size, capacity, AMD_FMT_MOD |
-		    AMD_FMT_MOD_SET(TILE, AMD_FMT_MOD_TILE_GFX9_64K_D) |
-		    AMD_FMT_MOD_SET(TILE_VERSION, AMD_FMT_MOD_TILE_VER_GFX9));
-
-	if (adev->family == AMDGPU_FAMILY_RV) {
-		add_modifier(mods, size, capacity, AMD_FMT_MOD |
-			    AMD_FMT_MOD_SET(TILE, AMD_FMT_MOD_TILE_GFX9_64K_S) |
-			    AMD_FMT_MOD_SET(TILE_VERSION, AMD_FMT_MOD_TILE_VER_GFX9));
-	}
-}
-
-static void
-add_gfx10_1_modifiers(const struct amdgpu_device *adev,
-		      uint64_t **mods, uint64_t *size, uint64_t *capacity)
-{
-	int pipe_xor_bits = ilog2(adev->gfx.config.gb_addr_config_fields.num_pipes);
-
-	add_modifier(mods, size, capacity, AMD_FMT_MOD |
-		    AMD_FMT_MOD_SET(TILE, AMD_FMT_MOD_TILE_GFX9_64K_R_X) |
-		    AMD_FMT_MOD_SET(TILE_VERSION, AMD_FMT_MOD_TILE_VER_GFX10) |
-		    AMD_FMT_MOD_SET(PIPE_XOR_BITS, pipe_xor_bits) |
-		    AMD_FMT_MOD_SET(DCC, 1) |
-		    AMD_FMT_MOD_SET(DCC_CONSTANT_ENCODE, 1) |
-		    AMD_FMT_MOD_SET(DCC_INDEPENDENT_64B, 1) |
-		    AMD_FMT_MOD_SET(DCC_MAX_COMPRESSED_BLOCK, AMD_FMT_MOD_DCC_BLOCK_64B));
-
-	add_modifier(mods, size, capacity, AMD_FMT_MOD |
-		    AMD_FMT_MOD_SET(TILE, AMD_FMT_MOD_TILE_GFX9_64K_R_X) |
-		    AMD_FMT_MOD_SET(TILE_VERSION, AMD_FMT_MOD_TILE_VER_GFX10) |
-		    AMD_FMT_MOD_SET(PIPE_XOR_BITS, pipe_xor_bits) |
-		    AMD_FMT_MOD_SET(DCC, 1) |
-		    AMD_FMT_MOD_SET(DCC_RETILE, 1) |
-		    AMD_FMT_MOD_SET(DCC_CONSTANT_ENCODE, 1) |
-		    AMD_FMT_MOD_SET(DCC_INDEPENDENT_64B, 1) |
-		    AMD_FMT_MOD_SET(DCC_MAX_COMPRESSED_BLOCK, AMD_FMT_MOD_DCC_BLOCK_64B));
-
-	add_modifier(mods, size, capacity, AMD_FMT_MOD |
-		    AMD_FMT_MOD_SET(TILE, AMD_FMT_MOD_TILE_GFX9_64K_R_X) |
-		    AMD_FMT_MOD_SET(TILE_VERSION, AMD_FMT_MOD_TILE_VER_GFX10) |
-		    AMD_FMT_MOD_SET(PIPE_XOR_BITS, pipe_xor_bits));
-
-	add_modifier(mods, size, capacity, AMD_FMT_MOD |
-		    AMD_FMT_MOD_SET(TILE, AMD_FMT_MOD_TILE_GFX9_64K_S_X) |
-		    AMD_FMT_MOD_SET(TILE_VERSION, AMD_FMT_MOD_TILE_VER_GFX10) |
-		    AMD_FMT_MOD_SET(PIPE_XOR_BITS, pipe_xor_bits));
-
-
-	/* Only supported for 64bpp, will be filtered in dm_plane_format_mod_supported */
-	add_modifier(mods, size, capacity, AMD_FMT_MOD |
-		    AMD_FMT_MOD_SET(TILE, AMD_FMT_MOD_TILE_GFX9_64K_D) |
-		    AMD_FMT_MOD_SET(TILE_VERSION, AMD_FMT_MOD_TILE_VER_GFX9));
-
-	add_modifier(mods, size, capacity, AMD_FMT_MOD |
-		    AMD_FMT_MOD_SET(TILE, AMD_FMT_MOD_TILE_GFX9_64K_S) |
-		    AMD_FMT_MOD_SET(TILE_VERSION, AMD_FMT_MOD_TILE_VER_GFX9));
-}
-
-static void
-add_gfx10_3_modifiers(const struct amdgpu_device *adev,
-		      uint64_t **mods, uint64_t *size, uint64_t *capacity)
-{
-	int pipe_xor_bits = ilog2(adev->gfx.config.gb_addr_config_fields.num_pipes);
-	int pkrs = ilog2(adev->gfx.config.gb_addr_config_fields.num_pkrs);
-
-	add_modifier(mods, size, capacity, AMD_FMT_MOD |
-		    AMD_FMT_MOD_SET(TILE, AMD_FMT_MOD_TILE_GFX9_64K_R_X) |
-		    AMD_FMT_MOD_SET(TILE_VERSION, AMD_FMT_MOD_TILE_VER_GFX10_RBPLUS) |
-		    AMD_FMT_MOD_SET(PIPE_XOR_BITS, pipe_xor_bits) |
-		    AMD_FMT_MOD_SET(PACKERS, pkrs) |
-		    AMD_FMT_MOD_SET(DCC, 1) |
-		    AMD_FMT_MOD_SET(DCC_CONSTANT_ENCODE, 1) |
-		    AMD_FMT_MOD_SET(DCC_INDEPENDENT_64B, 1) |
-		    AMD_FMT_MOD_SET(DCC_INDEPENDENT_128B, 1) |
-		    AMD_FMT_MOD_SET(DCC_MAX_COMPRESSED_BLOCK, AMD_FMT_MOD_DCC_BLOCK_64B));
-
-	add_modifier(mods, size, capacity, AMD_FMT_MOD |
-		    AMD_FMT_MOD_SET(TILE, AMD_FMT_MOD_TILE_GFX9_64K_R_X) |
-		    AMD_FMT_MOD_SET(TILE_VERSION, AMD_FMT_MOD_TILE_VER_GFX10_RBPLUS) |
-		    AMD_FMT_MOD_SET(PIPE_XOR_BITS, pipe_xor_bits) |
-		    AMD_FMT_MOD_SET(PACKERS, pkrs) |
-		    AMD_FMT_MOD_SET(DCC, 1) |
-		    AMD_FMT_MOD_SET(DCC_RETILE, 1) |
-		    AMD_FMT_MOD_SET(DCC_CONSTANT_ENCODE, 1) |
-		    AMD_FMT_MOD_SET(DCC_INDEPENDENT_64B, 1) |
-		    AMD_FMT_MOD_SET(DCC_INDEPENDENT_128B, 1) |
-		    AMD_FMT_MOD_SET(DCC_MAX_COMPRESSED_BLOCK, AMD_FMT_MOD_DCC_BLOCK_64B));
-
-	add_modifier(mods, size, capacity, AMD_FMT_MOD |
-		    AMD_FMT_MOD_SET(TILE, AMD_FMT_MOD_TILE_GFX9_64K_R_X) |
-		    AMD_FMT_MOD_SET(TILE_VERSION, AMD_FMT_MOD_TILE_VER_GFX10_RBPLUS) |
-		    AMD_FMT_MOD_SET(PIPE_XOR_BITS, pipe_xor_bits) |
-		    AMD_FMT_MOD_SET(PACKERS, pkrs));
-
-	add_modifier(mods, size, capacity, AMD_FMT_MOD |
-		    AMD_FMT_MOD_SET(TILE, AMD_FMT_MOD_TILE_GFX9_64K_S_X) |
-		    AMD_FMT_MOD_SET(TILE_VERSION, AMD_FMT_MOD_TILE_VER_GFX10_RBPLUS) |
-		    AMD_FMT_MOD_SET(PIPE_XOR_BITS, pipe_xor_bits) |
-		    AMD_FMT_MOD_SET(PACKERS, pkrs));
-
-	/* Only supported for 64bpp, will be filtered in dm_plane_format_mod_supported */
-	add_modifier(mods, size, capacity, AMD_FMT_MOD |
-		    AMD_FMT_MOD_SET(TILE, AMD_FMT_MOD_TILE_GFX9_64K_D) |
-		    AMD_FMT_MOD_SET(TILE_VERSION, AMD_FMT_MOD_TILE_VER_GFX9));
-
-	add_modifier(mods, size, capacity, AMD_FMT_MOD |
-		    AMD_FMT_MOD_SET(TILE, AMD_FMT_MOD_TILE_GFX9_64K_S) |
-		    AMD_FMT_MOD_SET(TILE_VERSION, AMD_FMT_MOD_TILE_VER_GFX9));
-}
-
-static int
-get_plane_modifiers(const struct amdgpu_device *adev, unsigned int plane_type, uint64_t **mods)
-{
-	uint64_t size = 0, capacity = 128;
-	*mods = NULL;
-
-	/* We have not hooked up any pre-GFX9 modifiers. */
-	if (adev->family < AMDGPU_FAMILY_AI)
-		return 0;
-
-	*mods = kmalloc(capacity * sizeof(uint64_t), GFP_KERNEL);
-
-	if (plane_type == DRM_PLANE_TYPE_CURSOR) {
-		add_modifier(mods, &size, &capacity, DRM_FORMAT_MOD_LINEAR);
-		add_modifier(mods, &size, &capacity, DRM_FORMAT_MOD_INVALID);
-		return *mods ? 0 : -ENOMEM;
-	}
-
-	switch (adev->family) {
-	case AMDGPU_FAMILY_AI:
-	case AMDGPU_FAMILY_RV:
-		add_gfx9_modifiers(adev, mods, &size, &capacity);
-		break;
-	case AMDGPU_FAMILY_NV:
-	case AMDGPU_FAMILY_VGH:
-		if (adev->asic_type >= CHIP_SIENNA_CICHLID)
-			add_gfx10_3_modifiers(adev, mods, &size, &capacity);
-		else
-			add_gfx10_1_modifiers(adev, mods, &size, &capacity);
-		break;
-	}
-
-	add_modifier(mods, &size, &capacity, DRM_FORMAT_MOD_LINEAR);
-
-	/* INVALID marks the end of the list. */
-	add_modifier(mods, &size, &capacity, DRM_FORMAT_MOD_INVALID);
-
-	if (!*mods)
-		return -ENOMEM;
-
-	return 0;
-}
-
-static int
-fill_gfx9_plane_attributes_from_modifiers(struct amdgpu_device *adev,
-					  const struct amdgpu_framebuffer *afb,
-					  const enum surface_pixel_format format,
-					  const enum dc_rotation_angle rotation,
-					  const struct plane_size *plane_size,
-					  union dc_tiling_info *tiling_info,
-					  struct dc_plane_dcc_param *dcc,
-					  struct dc_plane_address *address,
-					  const bool force_disable_dcc)
-{
-	const uint64_t modifier = afb->base.modifier;
-	int ret;
-
-	fill_gfx9_tiling_info_from_modifier(adev, tiling_info, modifier);
-	tiling_info->gfx9.swizzle = modifier_gfx9_swizzle_mode(modifier);
-
-	if (modifier_has_dcc(modifier) && !force_disable_dcc) {
-		uint64_t dcc_address = afb->address + afb->base.offsets[1];
-
-		dcc->enable = 1;
-		dcc->meta_pitch = afb->base.pitches[1];
-		dcc->independent_64b_blks = AMD_FMT_MOD_GET(DCC_INDEPENDENT_64B, modifier);
-
-		address->grph.meta_addr.low_part = lower_32_bits(dcc_address);
-		address->grph.meta_addr.high_part = upper_32_bits(dcc_address);
-	}
-
-	ret = validate_dcc(adev, format, rotation, tiling_info, dcc, address, plane_size);
-	if (ret)
-		return ret;
-
-	return 0;
-}
-
-static int
-fill_plane_buffer_attributes(struct amdgpu_device *adev,
-			     const struct amdgpu_framebuffer *afb,
-			     const enum surface_pixel_format format,
-			     const enum dc_rotation_angle rotation,
-			     const uint64_t tiling_flags,
-			     union dc_tiling_info *tiling_info,
-			     struct plane_size *plane_size,
-			     struct dc_plane_dcc_param *dcc,
-			     struct dc_plane_address *address,
-			     bool tmz_surface,
-			     bool force_disable_dcc)
-{
-	const struct drm_framebuffer *fb = &afb->base;
-	int ret;
-
-	memset(tiling_info, 0, sizeof(*tiling_info));
-	memset(plane_size, 0, sizeof(*plane_size));
-	memset(dcc, 0, sizeof(*dcc));
-	memset(address, 0, sizeof(*address));
-
-	address->tmz_surface = tmz_surface;
-
-	if (format < SURFACE_PIXEL_FORMAT_VIDEO_BEGIN) {
-		uint64_t addr = afb->address + fb->offsets[0];
-
-		plane_size->surface_size.x = 0;
-		plane_size->surface_size.y = 0;
-		plane_size->surface_size.width = fb->width;
-		plane_size->surface_size.height = fb->height;
-		plane_size->surface_pitch =
-			fb->pitches[0] / fb->format->cpp[0];
-
-		address->type = PLN_ADDR_TYPE_GRAPHICS;
-		address->grph.addr.low_part = lower_32_bits(addr);
-		address->grph.addr.high_part = upper_32_bits(addr);
-	} else if (format < SURFACE_PIXEL_FORMAT_INVALID) {
-		uint64_t luma_addr = afb->address + fb->offsets[0];
-		uint64_t chroma_addr = afb->address + fb->offsets[1];
-
-		plane_size->surface_size.x = 0;
-		plane_size->surface_size.y = 0;
-		plane_size->surface_size.width = fb->width;
-		plane_size->surface_size.height = fb->height;
-		plane_size->surface_pitch =
-			fb->pitches[0] / fb->format->cpp[0];
-
-		plane_size->chroma_size.x = 0;
-		plane_size->chroma_size.y = 0;
-		/* TODO: set these based on surface format */
-		plane_size->chroma_size.width = fb->width / 2;
-		plane_size->chroma_size.height = fb->height / 2;
-
-		plane_size->chroma_pitch =
-			fb->pitches[1] / fb->format->cpp[1];
-
-		address->type = PLN_ADDR_TYPE_VIDEO_PROGRESSIVE;
-		address->video_progressive.luma_addr.low_part =
-			lower_32_bits(luma_addr);
-		address->video_progressive.luma_addr.high_part =
-			upper_32_bits(luma_addr);
-		address->video_progressive.chroma_addr.low_part =
-			lower_32_bits(chroma_addr);
-		address->video_progressive.chroma_addr.high_part =
-			upper_32_bits(chroma_addr);
-	}
-
-	if (adev->family >= AMDGPU_FAMILY_AI) {
-		ret = fill_gfx9_plane_attributes_from_modifiers(adev, afb, format,
-								rotation, plane_size,
-								tiling_info, dcc,
-								address,
-								force_disable_dcc);
-		if (ret)
-			return ret;
-	} else {
-		fill_gfx8_tiling_info_from_flags(tiling_info, tiling_flags);
-	}
-
-	return 0;
-}
-
-static void
-fill_blending_from_plane_state(const struct drm_plane_state *plane_state,
-			       bool *per_pixel_alpha, bool *global_alpha,
-			       int *global_alpha_value)
-{
-	*per_pixel_alpha = false;
-	*global_alpha = false;
-	*global_alpha_value = 0xff;
-
-	if (plane_state->plane->type != DRM_PLANE_TYPE_OVERLAY)
-		return;
-
-	if (plane_state->pixel_blend_mode == DRM_MODE_BLEND_PREMULTI) {
-		static const uint32_t alpha_formats[] = {
-			DRM_FORMAT_ARGB8888,
-			DRM_FORMAT_RGBA8888,
-			DRM_FORMAT_ABGR8888,
-		};
-		uint32_t format = plane_state->fb->format->format;
-		unsigned int i;
-
-		for (i = 0; i < ARRAY_SIZE(alpha_formats); ++i) {
-			if (format == alpha_formats[i]) {
-				*per_pixel_alpha = true;
-				break;
-			}
-		}
-	}
-
-	if (plane_state->alpha < 0xffff) {
-		*global_alpha = true;
-		*global_alpha_value = plane_state->alpha >> 8;
-	}
-}
-
-static int
-fill_plane_color_attributes(const struct drm_plane_state *plane_state,
-			    const enum surface_pixel_format format,
-			    enum dc_color_space *color_space)
-{
-	bool full_range;
-
-	*color_space = COLOR_SPACE_SRGB;
-
-	/* DRM color properties only affect non-RGB formats. */
-	if (format < SURFACE_PIXEL_FORMAT_VIDEO_BEGIN)
-		return 0;
-
-	full_range = (plane_state->color_range == DRM_COLOR_YCBCR_FULL_RANGE);
-
-	switch (plane_state->color_encoding) {
-	case DRM_COLOR_YCBCR_BT601:
-		if (full_range)
-			*color_space = COLOR_SPACE_YCBCR601;
-		else
-			*color_space = COLOR_SPACE_YCBCR601_LIMITED;
-		break;
-
-	case DRM_COLOR_YCBCR_BT709:
-		if (full_range)
-			*color_space = COLOR_SPACE_YCBCR709;
-		else
-			*color_space = COLOR_SPACE_YCBCR709_LIMITED;
-		break;
-
-	case DRM_COLOR_YCBCR_BT2020:
-		if (full_range)
-			*color_space = COLOR_SPACE_2020_YCBCR;
-		else
-			return -EINVAL;
-		break;
-
-	default:
-		return -EINVAL;
-	}
-
-	return 0;
-}
-
-static int
-fill_dc_plane_info_and_addr(struct amdgpu_device *adev,
-			    const struct drm_plane_state *plane_state,
-			    const uint64_t tiling_flags,
-			    struct dc_plane_info *plane_info,
-			    struct dc_plane_address *address,
-			    bool tmz_surface,
-			    bool force_disable_dcc)
-{
-	const struct drm_framebuffer *fb = plane_state->fb;
-	const struct amdgpu_framebuffer *afb =
-		to_amdgpu_framebuffer(plane_state->fb);
-	int ret;
-
-	memset(plane_info, 0, sizeof(*plane_info));
-
-	switch (fb->format->format) {
-	case DRM_FORMAT_C8:
-		plane_info->format =
-			SURFACE_PIXEL_FORMAT_GRPH_PALETA_256_COLORS;
-		break;
-	case DRM_FORMAT_RGB565:
-		plane_info->format = SURFACE_PIXEL_FORMAT_GRPH_RGB565;
-		break;
-	case DRM_FORMAT_XRGB8888:
-	case DRM_FORMAT_ARGB8888:
-		plane_info->format = SURFACE_PIXEL_FORMAT_GRPH_ARGB8888;
-		break;
-	case DRM_FORMAT_XRGB2101010:
-	case DRM_FORMAT_ARGB2101010:
-		plane_info->format = SURFACE_PIXEL_FORMAT_GRPH_ARGB2101010;
-		break;
-	case DRM_FORMAT_XBGR2101010:
-	case DRM_FORMAT_ABGR2101010:
-		plane_info->format = SURFACE_PIXEL_FORMAT_GRPH_ABGR2101010;
-		break;
-	case DRM_FORMAT_XBGR8888:
-	case DRM_FORMAT_ABGR8888:
-		plane_info->format = SURFACE_PIXEL_FORMAT_GRPH_ABGR8888;
-		break;
-	case DRM_FORMAT_NV21:
-		plane_info->format = SURFACE_PIXEL_FORMAT_VIDEO_420_YCbCr;
-		break;
-	case DRM_FORMAT_NV12:
-		plane_info->format = SURFACE_PIXEL_FORMAT_VIDEO_420_YCrCb;
-		break;
-	case DRM_FORMAT_P010:
-		plane_info->format = SURFACE_PIXEL_FORMAT_VIDEO_420_10bpc_YCrCb;
-		break;
-	case DRM_FORMAT_XRGB16161616F:
-	case DRM_FORMAT_ARGB16161616F:
-		plane_info->format = SURFACE_PIXEL_FORMAT_GRPH_ARGB16161616F;
-		break;
-	case DRM_FORMAT_XBGR16161616F:
-	case DRM_FORMAT_ABGR16161616F:
-		plane_info->format = SURFACE_PIXEL_FORMAT_GRPH_ABGR16161616F;
-		break;
-	default:
-		DRM_ERROR(
-			"Unsupported screen format %p4cc\n",
-			&fb->format->format);
-		return -EINVAL;
-	}
-
-	switch (plane_state->rotation & DRM_MODE_ROTATE_MASK) {
-	case DRM_MODE_ROTATE_0:
-		plane_info->rotation = ROTATION_ANGLE_0;
-		break;
-	case DRM_MODE_ROTATE_90:
-		plane_info->rotation = ROTATION_ANGLE_90;
-		break;
-	case DRM_MODE_ROTATE_180:
-		plane_info->rotation = ROTATION_ANGLE_180;
-		break;
-	case DRM_MODE_ROTATE_270:
-		plane_info->rotation = ROTATION_ANGLE_270;
-		break;
-	default:
-		plane_info->rotation = ROTATION_ANGLE_0;
-		break;
-	}
-
-	plane_info->visible = true;
-	plane_info->stereo_format = PLANE_STEREO_FORMAT_NONE;
-
-	plane_info->layer_index = 0;
-
-	ret = fill_plane_color_attributes(plane_state, plane_info->format,
-					  &plane_info->color_space);
-	if (ret)
-		return ret;
-
-	ret = fill_plane_buffer_attributes(adev, afb, plane_info->format,
-					   plane_info->rotation, tiling_flags,
-					   &plane_info->tiling_info,
-					   &plane_info->plane_size,
-					   &plane_info->dcc, address, tmz_surface,
-					   force_disable_dcc);
-	if (ret)
-		return ret;
-
-	fill_blending_from_plane_state(
-		plane_state, &plane_info->per_pixel_alpha,
-		&plane_info->global_alpha, &plane_info->global_alpha_value);
-
-	return 0;
-}
-
 static int fill_dc_plane_attributes(struct amdgpu_device *adev,
 				    struct dc_plane_state *dc_plane_state,
 				    struct drm_plane_state *plane_state,
@@ -6816,456 +5897,6 @@ static int dm_update_mst_vcpi_slots_for_dsc(struct drm_atomic_state *state,
 }
 #endif
 
-static void dm_drm_plane_reset(struct drm_plane *plane)
-{
-	struct dm_plane_state *amdgpu_state = NULL;
-
-	if (plane->state)
-		plane->funcs->atomic_destroy_state(plane, plane->state);
-
-	amdgpu_state = kzalloc(sizeof(*amdgpu_state), GFP_KERNEL);
-	WARN_ON(amdgpu_state == NULL);
-
-	if (amdgpu_state)
-		__drm_atomic_helper_plane_reset(plane, &amdgpu_state->base);
-}
-
-static struct drm_plane_state *
-dm_drm_plane_duplicate_state(struct drm_plane *plane)
-{
-	struct dm_plane_state *dm_plane_state, *old_dm_plane_state;
-
-	old_dm_plane_state = to_dm_plane_state(plane->state);
-	dm_plane_state = kzalloc(sizeof(*dm_plane_state), GFP_KERNEL);
-	if (!dm_plane_state)
-		return NULL;
-
-	__drm_atomic_helper_plane_duplicate_state(plane, &dm_plane_state->base);
-
-	if (old_dm_plane_state->dc_state) {
-		dm_plane_state->dc_state = old_dm_plane_state->dc_state;
-		dc_plane_state_retain(dm_plane_state->dc_state);
-	}
-
-	return &dm_plane_state->base;
-}
-
-static void dm_drm_plane_destroy_state(struct drm_plane *plane,
-				struct drm_plane_state *state)
-{
-	struct dm_plane_state *dm_plane_state = to_dm_plane_state(state);
-
-	if (dm_plane_state->dc_state)
-		dc_plane_state_release(dm_plane_state->dc_state);
-
-	drm_atomic_helper_plane_destroy_state(plane, state);
-}
-
-static const struct drm_plane_funcs dm_plane_funcs = {
-	.update_plane	= drm_atomic_helper_update_plane,
-	.disable_plane	= drm_atomic_helper_disable_plane,
-	.destroy	= drm_primary_helper_destroy,
-	.reset = dm_drm_plane_reset,
-	.atomic_duplicate_state = dm_drm_plane_duplicate_state,
-	.atomic_destroy_state = dm_drm_plane_destroy_state,
-	.format_mod_supported = dm_plane_format_mod_supported,
-};
-
-static int dm_plane_helper_prepare_fb(struct drm_plane *plane,
-				      struct drm_plane_state *new_state)
-{
-	struct amdgpu_framebuffer *afb;
-	struct drm_gem_object *obj;
-	struct amdgpu_device *adev;
-	struct amdgpu_bo *rbo;
-	struct dm_plane_state *dm_plane_state_new, *dm_plane_state_old;
-	struct list_head list;
-	struct ttm_validate_buffer tv;
-	struct ww_acquire_ctx ticket;
-	uint32_t domain;
-	int r;
-
-	if (!new_state->fb) {
-		DRM_DEBUG_KMS("No FB bound\n");
-		return 0;
-	}
-
-	afb = to_amdgpu_framebuffer(new_state->fb);
-	obj = new_state->fb->obj[0];
-	rbo = gem_to_amdgpu_bo(obj);
-	adev = amdgpu_ttm_adev(rbo->tbo.bdev);
-	INIT_LIST_HEAD(&list);
-
-	tv.bo = &rbo->tbo;
-	tv.num_shared = 1;
-	list_add(&tv.head, &list);
-
-	r = ttm_eu_reserve_buffers(&ticket, &list, false, NULL);
-	if (r) {
-		dev_err(adev->dev, "fail to reserve bo (%d)\n", r);
-		return r;
-	}
-
-	if (plane->type != DRM_PLANE_TYPE_CURSOR)
-		domain = amdgpu_display_supported_domains(adev, rbo->flags);
-	else
-		domain = AMDGPU_GEM_DOMAIN_VRAM;
-
-	r = amdgpu_bo_pin(rbo, domain);
-	if (unlikely(r != 0)) {
-		if (r != -ERESTARTSYS)
-			DRM_ERROR("Failed to pin framebuffer with error %d\n", r);
-		ttm_eu_backoff_reservation(&ticket, &list);
-		return r;
-	}
-
-	r = amdgpu_ttm_alloc_gart(&rbo->tbo);
-	if (unlikely(r != 0)) {
-		amdgpu_bo_unpin(rbo);
-		ttm_eu_backoff_reservation(&ticket, &list);
-		DRM_ERROR("%p bind failed\n", rbo);
-		return r;
-	}
-
-	ttm_eu_backoff_reservation(&ticket, &list);
-
-	afb->address = amdgpu_bo_gpu_offset(rbo);
-
-	amdgpu_bo_ref(rbo);
-
-	/**
-	 * We don't do surface updates on planes that have been newly created,
-	 * but we also don't have the afb->address during atomic check.
-	 *
-	 * Fill in buffer attributes depending on the address here, but only on
-	 * newly created planes since they're not being used by DC yet and this
-	 * won't modify global state.
-	 */
-	dm_plane_state_old = to_dm_plane_state(plane->state);
-	dm_plane_state_new = to_dm_plane_state(new_state);
-
-	if (dm_plane_state_new->dc_state &&
-	    dm_plane_state_old->dc_state != dm_plane_state_new->dc_state) {
-		struct dc_plane_state *plane_state =
-			dm_plane_state_new->dc_state;
-		bool force_disable_dcc = !plane_state->dcc.enable;
-
-		fill_plane_buffer_attributes(
-			adev, afb, plane_state->format, plane_state->rotation,
-			afb->tiling_flags,
-			&plane_state->tiling_info, &plane_state->plane_size,
-			&plane_state->dcc, &plane_state->address,
-			afb->tmz_surface, force_disable_dcc);
-	}
-
-	return 0;
-}
-
-static void dm_plane_helper_cleanup_fb(struct drm_plane *plane,
-				       struct drm_plane_state *old_state)
-{
-	struct amdgpu_bo *rbo;
-	int r;
-
-	if (!old_state->fb)
-		return;
-
-	rbo = gem_to_amdgpu_bo(old_state->fb->obj[0]);
-	r = amdgpu_bo_reserve(rbo, false);
-	if (unlikely(r)) {
-		DRM_ERROR("failed to reserve rbo before unpin\n");
-		return;
-	}
-
-	amdgpu_bo_unpin(rbo);
-	amdgpu_bo_unreserve(rbo);
-	amdgpu_bo_unref(&rbo);
-}
-
-static int dm_plane_helper_check_state(struct drm_plane_state *state,
-				       struct drm_crtc_state *new_crtc_state)
-{
-	struct drm_framebuffer *fb = state->fb;
-	int min_downscale, max_upscale;
-	int min_scale = 0;
-	int max_scale = INT_MAX;
-
-	/* Plane enabled? Validate viewport and get scaling factors from plane caps. */
-	if (fb && state->crtc) {
-		/* Validate viewport to cover the case when only the position changes */
-		if (state->plane->type != DRM_PLANE_TYPE_CURSOR) {
-			int viewport_width = state->crtc_w;
-			int viewport_height = state->crtc_h;
-
-			if (state->crtc_x < 0)
-				viewport_width += state->crtc_x;
-			else if (state->crtc_x + state->crtc_w > new_crtc_state->mode.crtc_hdisplay)
-				viewport_width = new_crtc_state->mode.crtc_hdisplay - state->crtc_x;
-
-			if (state->crtc_y < 0)
-				viewport_height += state->crtc_y;
-			else if (state->crtc_y + state->crtc_h > new_crtc_state->mode.crtc_vdisplay)
-				viewport_height = new_crtc_state->mode.crtc_vdisplay - state->crtc_y;
-
-			if (viewport_width < 0 || viewport_height < 0) {
-				DRM_DEBUG_ATOMIC("Plane completely outside of screen\n");
-				return -EINVAL;
-			} else if (viewport_width < MIN_VIEWPORT_SIZE*2) { /* x2 for width is because of pipe-split. */
-				DRM_DEBUG_ATOMIC("Viewport width %d smaller than %d\n", viewport_width, MIN_VIEWPORT_SIZE*2);
-				return -EINVAL;
-			} else if (viewport_height < MIN_VIEWPORT_SIZE) {
-				DRM_DEBUG_ATOMIC("Viewport height %d smaller than %d\n", viewport_height, MIN_VIEWPORT_SIZE);
-				return -EINVAL;
-			}
-
-		}
-
-		/* Get min/max allowed scaling factors from plane caps. */
-		get_min_max_dc_plane_scaling(state->crtc->dev, fb,
-					     &min_downscale, &max_upscale);
-		/*
-		 * Convert to drm convention: 16.16 fixed point, instead of dc's
-		 * 1.0 == 1000. Also drm scaling is src/dst instead of dc's
-		 * dst/src, so min_scale = 1.0 / max_upscale, etc.
-		 */
-		min_scale = (1000 << 16) / max_upscale;
-		max_scale = (1000 << 16) / min_downscale;
-	}
-
-	return drm_atomic_helper_check_plane_state(
-		state, new_crtc_state, min_scale, max_scale, true, true);
-}
-
-static int dm_plane_atomic_check(struct drm_plane *plane,
-				 struct drm_plane_state *state)
-{
-	struct amdgpu_device *adev = drm_to_adev(plane->dev);
-	struct dc *dc = adev->dm.dc;
-	struct dm_plane_state *dm_plane_state;
-	struct dc_scaling_info scaling_info;
-	struct drm_crtc_state *new_crtc_state;
-	int ret;
-
-	trace_amdgpu_dm_plane_atomic_check(state);
-
-	dm_plane_state = to_dm_plane_state(state);
-
-	if (!dm_plane_state->dc_state)
-		return 0;
-
-	new_crtc_state =
-		drm_atomic_get_new_crtc_state(state->state, state->crtc);
-	if (!new_crtc_state)
-		return -EINVAL;
-
-	ret = dm_plane_helper_check_state(state, new_crtc_state);
-	if (ret)
-		return ret;
-
-	ret = fill_dc_scaling_info(state, &scaling_info);
-	if (ret)
-		return ret;
-
-	if (dc_validate_plane(dc, dm_plane_state->dc_state) == DC_OK)
-		return 0;
-
-	return -EINVAL;
-}
-
-static int dm_plane_atomic_async_check(struct drm_plane *plane,
-				       struct drm_plane_state *new_plane_state)
-{
-	/* Only support async updates on cursor planes. */
-	if (plane->type != DRM_PLANE_TYPE_CURSOR)
-		return -EINVAL;
-
-	return 0;
-}
-
-static void dm_plane_atomic_async_update(struct drm_plane *plane,
-					 struct drm_plane_state *new_state)
-{
-	struct drm_plane_state *old_state =
-		drm_atomic_get_old_plane_state(new_state->state, plane);
-
-	trace_amdgpu_dm_atomic_update_cursor(new_state);
-
-	swap(plane->state->fb, new_state->fb);
-
-	plane->state->src_x = new_state->src_x;
-	plane->state->src_y = new_state->src_y;
-	plane->state->src_w = new_state->src_w;
-	plane->state->src_h = new_state->src_h;
-	plane->state->crtc_x = new_state->crtc_x;
-	plane->state->crtc_y = new_state->crtc_y;
-	plane->state->crtc_w = new_state->crtc_w;
-	plane->state->crtc_h = new_state->crtc_h;
-
-	handle_cursor_update(plane, old_state);
-}
-
-static const struct drm_plane_helper_funcs dm_plane_helper_funcs = {
-	.prepare_fb = dm_plane_helper_prepare_fb,
-	.cleanup_fb = dm_plane_helper_cleanup_fb,
-	.atomic_check = dm_plane_atomic_check,
-	.atomic_async_check = dm_plane_atomic_async_check,
-	.atomic_async_update = dm_plane_atomic_async_update
-};
-
-/*
- * TODO: these are currently initialized to rgb formats only.
- * For future use cases we should either initialize them dynamically based on
- * plane capabilities, or initialize this array to all formats, so internal drm
- * check will succeed, and let DC implement proper check
- */
-static const uint32_t rgb_formats[] = {
-	DRM_FORMAT_XRGB8888,
-	DRM_FORMAT_ARGB8888,
-	DRM_FORMAT_RGBA8888,
-	DRM_FORMAT_XRGB2101010,
-	DRM_FORMAT_XBGR2101010,
-	DRM_FORMAT_ARGB2101010,
-	DRM_FORMAT_ABGR2101010,
-	DRM_FORMAT_XBGR8888,
-	DRM_FORMAT_ABGR8888,
-	DRM_FORMAT_RGB565,
-};
-
-static const uint32_t overlay_formats[] = {
-	DRM_FORMAT_XRGB8888,
-	DRM_FORMAT_ARGB8888,
-	DRM_FORMAT_RGBA8888,
-	DRM_FORMAT_XBGR8888,
-	DRM_FORMAT_ABGR8888,
-	DRM_FORMAT_RGB565
-};
-
-static const u32 cursor_formats[] = {
-	DRM_FORMAT_ARGB8888
-};
-
-static int get_plane_formats(const struct drm_plane *plane,
-			     const struct dc_plane_cap *plane_cap,
-			     uint32_t *formats, int max_formats)
-{
-	int i, num_formats = 0;
-
-	/*
-	 * TODO: Query support for each group of formats directly from
-	 * DC plane caps. This will require adding more formats to the
-	 * caps list.
-	 */
-
-	switch (plane->type) {
-	case DRM_PLANE_TYPE_PRIMARY:
-		for (i = 0; i < ARRAY_SIZE(rgb_formats); ++i) {
-			if (num_formats >= max_formats)
-				break;
-
-			formats[num_formats++] = rgb_formats[i];
-		}
-
-		if (plane_cap && plane_cap->pixel_format_support.nv12)
-			formats[num_formats++] = DRM_FORMAT_NV12;
-		if (plane_cap && plane_cap->pixel_format_support.p010)
-			formats[num_formats++] = DRM_FORMAT_P010;
-		if (plane_cap && plane_cap->pixel_format_support.fp16) {
-			formats[num_formats++] = DRM_FORMAT_XRGB16161616F;
-			formats[num_formats++] = DRM_FORMAT_ARGB16161616F;
-			formats[num_formats++] = DRM_FORMAT_XBGR16161616F;
-			formats[num_formats++] = DRM_FORMAT_ABGR16161616F;
-		}
-		break;
-
-	case DRM_PLANE_TYPE_OVERLAY:
-		for (i = 0; i < ARRAY_SIZE(overlay_formats); ++i) {
-			if (num_formats >= max_formats)
-				break;
-
-			formats[num_formats++] = overlay_formats[i];
-		}
-		break;
-
-	case DRM_PLANE_TYPE_CURSOR:
-		for (i = 0; i < ARRAY_SIZE(cursor_formats); ++i) {
-			if (num_formats >= max_formats)
-				break;
-
-			formats[num_formats++] = cursor_formats[i];
-		}
-		break;
-	}
-
-	return num_formats;
-}
-
-static int amdgpu_dm_plane_init(struct amdgpu_display_manager *dm,
-				struct drm_plane *plane,
-				unsigned long possible_crtcs,
-				const struct dc_plane_cap *plane_cap)
-{
-	uint32_t formats[32];
-	int num_formats;
-	int res = -EPERM;
-	unsigned int supported_rotations;
-	uint64_t *modifiers = NULL;
-
-	num_formats = get_plane_formats(plane, plane_cap, formats,
-					ARRAY_SIZE(formats));
-
-	res = get_plane_modifiers(dm->adev, plane->type, &modifiers);
-	if (res)
-		return res;
-
-	res = drm_universal_plane_init(adev_to_drm(dm->adev), plane, possible_crtcs,
-				       &dm_plane_funcs, formats, num_formats,
-				       modifiers, plane->type, NULL);
-	kfree(modifiers);
-	if (res)
-		return res;
-
-	if (plane->type == DRM_PLANE_TYPE_OVERLAY &&
-	    plane_cap && plane_cap->per_pixel_alpha) {
-		unsigned int blend_caps = BIT(DRM_MODE_BLEND_PIXEL_NONE) |
-					  BIT(DRM_MODE_BLEND_PREMULTI);
-
-		drm_plane_create_alpha_property(plane);
-		drm_plane_create_blend_mode_property(plane, blend_caps);
-	}
-
-	if (plane->type == DRM_PLANE_TYPE_PRIMARY &&
-	    plane_cap &&
-	    (plane_cap->pixel_format_support.nv12 ||
-	     plane_cap->pixel_format_support.p010)) {
-		/* This only affects YUV formats. */
-		drm_plane_create_color_properties(
-			plane,
-			BIT(DRM_COLOR_YCBCR_BT601) |
-			BIT(DRM_COLOR_YCBCR_BT709) |
-			BIT(DRM_COLOR_YCBCR_BT2020),
-			BIT(DRM_COLOR_YCBCR_LIMITED_RANGE) |
-			BIT(DRM_COLOR_YCBCR_FULL_RANGE),
-			DRM_COLOR_YCBCR_BT709, DRM_COLOR_YCBCR_LIMITED_RANGE);
-	}
-
-	supported_rotations =
-		DRM_MODE_ROTATE_0 | DRM_MODE_ROTATE_90 |
-		DRM_MODE_ROTATE_180 | DRM_MODE_ROTATE_270;
-
-	if (dm->adev->asic_type >= CHIP_BONAIRE &&
-	    plane->type != DRM_PLANE_TYPE_CURSOR)
-		drm_plane_create_rotation_property(plane, DRM_MODE_ROTATE_0,
-						   supported_rotations);
-
-	drm_plane_helper_add(plane, &dm_plane_helper_funcs);
-
-	/* Create (reset) the plane state */
-	if (plane->funcs->reset)
-		plane->funcs->reset(plane);
-
-	return 0;
-}
-
 static int amdgpu_dm_crtc_init(struct amdgpu_display_manager *dm,
 			       struct drm_plane *plane,
 			       uint32_t crtc_index)
@@ -8058,114 +6689,6 @@ static void remove_stream(struct amdgpu_device *adev,
 	acrtc->enabled = false;
 }
 
-static int get_cursor_position(struct drm_plane *plane, struct drm_crtc *crtc,
-			       struct dc_cursor_position *position)
-{
-	struct amdgpu_crtc *amdgpu_crtc = to_amdgpu_crtc(crtc);
-	int x, y;
-	int xorigin = 0, yorigin = 0;
-
-	if (!crtc || !plane->state->fb)
-		return 0;
-
-	if ((plane->state->crtc_w > amdgpu_crtc->max_cursor_width) ||
-	    (plane->state->crtc_h > amdgpu_crtc->max_cursor_height)) {
-		DRM_ERROR("%s: bad cursor width or height %d x %d\n",
-			  __func__,
-			  plane->state->crtc_w,
-			  plane->state->crtc_h);
-		return -EINVAL;
-	}
-
-	x = plane->state->crtc_x;
-	y = plane->state->crtc_y;
-
-	if (x <= -amdgpu_crtc->max_cursor_width ||
-	    y <= -amdgpu_crtc->max_cursor_height)
-		return 0;
-
-	if (x < 0) {
-		xorigin = min(-x, amdgpu_crtc->max_cursor_width - 1);
-		x = 0;
-	}
-	if (y < 0) {
-		yorigin = min(-y, amdgpu_crtc->max_cursor_height - 1);
-		y = 0;
-	}
-	position->enable = true;
-	position->translate_by_source = true;
-	position->x = x;
-	position->y = y;
-	position->x_hotspot = xorigin;
-	position->y_hotspot = yorigin;
-
-	return 0;
-}
-
-static void handle_cursor_update(struct drm_plane *plane,
-				 struct drm_plane_state *old_plane_state)
-{
-	struct amdgpu_device *adev = drm_to_adev(plane->dev);
-	struct amdgpu_framebuffer *afb = to_amdgpu_framebuffer(plane->state->fb);
-	struct drm_crtc *crtc = afb ? plane->state->crtc : old_plane_state->crtc;
-	struct dm_crtc_state *crtc_state = crtc ? to_dm_crtc_state(crtc->state) : NULL;
-	struct amdgpu_crtc *amdgpu_crtc = to_amdgpu_crtc(crtc);
-	uint64_t address = afb ? afb->address : 0;
-	struct dc_cursor_position position = {0};
-	struct dc_cursor_attributes attributes;
-	int ret;
-
-	if (!plane->state->fb && !old_plane_state->fb)
-		return;
-
-	DC_LOG_CURSOR("%s: crtc_id=%d with size %d to %d\n",
-		      __func__,
-		      amdgpu_crtc->crtc_id,
-		      plane->state->crtc_w,
-		      plane->state->crtc_h);
-
-	ret = get_cursor_position(plane, crtc, &position);
-	if (ret)
-		return;
-
-	if (!position.enable) {
-		/* turn off cursor */
-		if (crtc_state && crtc_state->stream) {
-			mutex_lock(&adev->dm.dc_lock);
-			dc_stream_set_cursor_position(crtc_state->stream,
-						      &position);
-			mutex_unlock(&adev->dm.dc_lock);
-		}
-		return;
-	}
-
-	amdgpu_crtc->cursor_width = plane->state->crtc_w;
-	amdgpu_crtc->cursor_height = plane->state->crtc_h;
-
-	memset(&attributes, 0, sizeof(attributes));
-	attributes.address.high_part = upper_32_bits(address);
-	attributes.address.low_part  = lower_32_bits(address);
-	attributes.width             = plane->state->crtc_w;
-	attributes.height            = plane->state->crtc_h;
-	attributes.color_format      = CURSOR_MODE_COLOR_PRE_MULTIPLIED_ALPHA;
-	attributes.rotation_angle    = 0;
-	attributes.attribute_flags.value = 0;
-
-	attributes.pitch = afb->base.pitches[0] / afb->base.format->cpp[0];
-
-	if (crtc_state->stream) {
-		mutex_lock(&adev->dm.dc_lock);
-		if (!dc_stream_set_cursor_attributes(crtc_state->stream,
-							 &attributes))
-			DRM_ERROR("DC failed to set cursor attributes\n");
-
-		if (!dc_stream_set_cursor_position(crtc_state->stream,
-						   &position))
-			DRM_ERROR("DC failed to set cursor position\n");
-		mutex_unlock(&adev->dm.dc_lock);
-	}
-}
-
 static void prepare_flip_isr(struct amdgpu_crtc *acrtc)
 {
 
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
new file mode 100644
index 000000000000..91a61f7d4827
--- /dev/null
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
@@ -0,0 +1,1496 @@
+/*
+ * Copyright 2021 Advanced Micro Devices, Inc.
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a
+ * copy of this software and associated documentation files (the "Software"),
+ * to deal in the Software without restriction, including without limitation
+ * the rights to use, copy, modify, merge, publish, distribute, sublicense,
+ * and/or sell copies of the Software, and to permit persons to whom the
+ * Software is furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
+ * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR
+ * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
+ * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
+ * OTHER DEALINGS IN THE SOFTWARE.
+ *
+ * Authors: AMD
+ *
+ */
+
+#include <drm/drm_atomic_helper.h>
+#include <drm/drm_fourcc.h>
+#include <drm/drm_plane_helper.h>
+
+#include "dc.h"
+
+#include "amdgpu.h"
+#include "amdgpu_display.h"
+#include "amdgpu_dm_plane.h"
+#include "amdgpu_dm_trace.h"
+#include "amdgpu_mode.h"
+
+/*
+ * TODO: these are currently initialized to rgb formats only.
+ * For future use cases we should either initialize them dynamically based on
+ * plane capabilities, or initialize this array to all formats, so internal drm
+ * check will succeed, and let DC implement proper check
+ */
+static const uint32_t rgb_formats[] = {
+	DRM_FORMAT_XRGB8888,
+	DRM_FORMAT_ARGB8888,
+	DRM_FORMAT_RGBA8888,
+	DRM_FORMAT_XRGB2101010,
+	DRM_FORMAT_XBGR2101010,
+	DRM_FORMAT_ARGB2101010,
+	DRM_FORMAT_ABGR2101010,
+	DRM_FORMAT_XBGR8888,
+	DRM_FORMAT_ABGR8888,
+	DRM_FORMAT_RGB565,
+};
+
+static const uint32_t overlay_formats[] = {
+	DRM_FORMAT_XRGB8888,
+	DRM_FORMAT_ARGB8888,
+	DRM_FORMAT_RGBA8888,
+	DRM_FORMAT_XBGR8888,
+	DRM_FORMAT_ABGR8888,
+	DRM_FORMAT_RGB565
+};
+
+static const u32 cursor_formats[] = {
+	DRM_FORMAT_ARGB8888
+};
+
+enum dm_micro_swizzle {
+	MICRO_SWIZZLE_Z = 0,
+	MICRO_SWIZZLE_S = 1,
+	MICRO_SWIZZLE_D = 2,
+	MICRO_SWIZZLE_R = 3
+};
+
+static void dm_drm_plane_reset(struct drm_plane *plane)
+{
+	struct dm_plane_state *amdgpu_state = NULL;
+
+	if (plane->state)
+		plane->funcs->atomic_destroy_state(plane, plane->state);
+
+	amdgpu_state = kzalloc(sizeof(*amdgpu_state), GFP_KERNEL);
+	WARN_ON(amdgpu_state == NULL);
+
+	if (amdgpu_state)
+		__drm_atomic_helper_plane_reset(plane, &amdgpu_state->base);
+}
+
+static struct drm_plane_state *
+dm_drm_plane_duplicate_state(struct drm_plane *plane)
+{
+	struct dm_plane_state *dm_plane_state, *old_dm_plane_state;
+
+	old_dm_plane_state = to_dm_plane_state(plane->state);
+	dm_plane_state = kzalloc(sizeof(*dm_plane_state), GFP_KERNEL);
+	if (!dm_plane_state)
+		return NULL;
+
+	__drm_atomic_helper_plane_duplicate_state(plane, &dm_plane_state->base);
+
+	if (old_dm_plane_state->dc_state) {
+		dm_plane_state->dc_state = old_dm_plane_state->dc_state;
+		dc_plane_state_retain(dm_plane_state->dc_state);
+	}
+
+	return &dm_plane_state->base;
+}
+
+static void dm_drm_plane_destroy_state(struct drm_plane *plane,
+				       struct drm_plane_state *state)
+{
+	struct dm_plane_state *dm_plane_state = to_dm_plane_state(state);
+
+	if (dm_plane_state->dc_state)
+		dc_plane_state_release(dm_plane_state->dc_state);
+
+	drm_atomic_helper_plane_destroy_state(plane, state);
+}
+
+static unsigned modifier_gfx9_swizzle_mode(uint64_t modifier)
+{
+	if (modifier == DRM_FORMAT_MOD_LINEAR)
+		return 0;
+
+	return AMD_FMT_MOD_GET(TILE, modifier);
+}
+
+static bool modifier_has_dcc(uint64_t modifier)
+{
+	return IS_AMD_FMT_MOD(modifier) && AMD_FMT_MOD_GET(DCC, modifier);
+}
+
+static bool dm_plane_format_mod_supported(struct drm_plane *plane,
+					  uint32_t format,
+					  uint64_t modifier)
+{
+	struct amdgpu_device *adev = drm_to_adev(plane->dev);
+	const struct drm_format_info *info = drm_format_info(format);
+	int i;
+
+	enum dm_micro_swizzle microtile = modifier_gfx9_swizzle_mode(modifier) & 3;
+
+	if (!info)
+		return false;
+
+	/*
+	 * We always have to allow these modifiers:
+	 * 1. Core DRM checks for LINEAR support if userspace does not provide modifiers.
+	 * 2. Not passing any modifiers is the same as explicitly passing INVALID.
+	 */
+	if (modifier == DRM_FORMAT_MOD_LINEAR ||
+	    modifier == DRM_FORMAT_MOD_INVALID) {
+		return true;
+	}
+
+	/* Check that the modifier is on the list of the plane's supported modifiers. */
+	for (i = 0; i < plane->modifier_count; i++) {
+		if (modifier == plane->modifiers[i])
+			break;
+	}
+	if (i == plane->modifier_count)
+		return false;
+
+	/*
+	 * For D swizzle the canonical modifier depends on the bpp, so check
+	 * it here.
+	 */
+	if (AMD_FMT_MOD_GET(TILE_VERSION, modifier) == AMD_FMT_MOD_TILE_VER_GFX9 &&
+	    adev->family >= AMDGPU_FAMILY_NV) {
+		if (microtile == MICRO_SWIZZLE_D && info->cpp[0] == 4)
+			return false;
+	}
+
+	if (adev->family >= AMDGPU_FAMILY_RV && microtile == MICRO_SWIZZLE_D &&
+	    info->cpp[0] < 8)
+		return false;
+
+	if (modifier_has_dcc(modifier)) {
+		/* Per radeonsi comments 16/64 bpp are more complicated. */
+		if (info->cpp[0] != 4)
+			return false;
+		/* We support multi-planar formats, but not when combined with
+		 * additional DCC metadata planes.
+		 */
+		if (info->num_planes > 1)
+			return false;
+	}
+
+	return true;
+}
+
+static const struct drm_plane_funcs dm_plane_funcs = {
+	.update_plane	= drm_atomic_helper_update_plane,
+	.disable_plane	= drm_atomic_helper_disable_plane,
+	.destroy	= drm_primary_helper_destroy,
+	.reset = dm_drm_plane_reset,
+	.atomic_duplicate_state = dm_drm_plane_duplicate_state,
+	.atomic_destroy_state = dm_drm_plane_destroy_state,
+	.format_mod_supported = dm_plane_format_mod_supported,
+};
+
+static int get_plane_formats(const struct drm_plane *plane,
+			     const struct dc_plane_cap *plane_cap,
+			     uint32_t *formats, int max_formats)
+{
+	int i, num_formats = 0;
+
+	/*
+	 * TODO: Query support for each group of formats directly from
+	 * DC plane caps. This will require adding more formats to the
+	 * caps list.
+	 */
+
+	switch (plane->type) {
+	case DRM_PLANE_TYPE_PRIMARY:
+		for (i = 0; i < ARRAY_SIZE(rgb_formats); ++i) {
+			if (num_formats >= max_formats)
+				break;
+
+			formats[num_formats++] = rgb_formats[i];
+		}
+
+		if (plane_cap && plane_cap->pixel_format_support.nv12)
+			formats[num_formats++] = DRM_FORMAT_NV12;
+		if (plane_cap && plane_cap->pixel_format_support.p010)
+			formats[num_formats++] = DRM_FORMAT_P010;
+		if (plane_cap && plane_cap->pixel_format_support.fp16) {
+			formats[num_formats++] = DRM_FORMAT_XRGB16161616F;
+			formats[num_formats++] = DRM_FORMAT_ARGB16161616F;
+			formats[num_formats++] = DRM_FORMAT_XBGR16161616F;
+			formats[num_formats++] = DRM_FORMAT_ABGR16161616F;
+		}
+		break;
+
+	case DRM_PLANE_TYPE_OVERLAY:
+		for (i = 0; i < ARRAY_SIZE(overlay_formats); ++i) {
+			if (num_formats >= max_formats)
+				break;
+
+			formats[num_formats++] = overlay_formats[i];
+		}
+		break;
+
+	case DRM_PLANE_TYPE_CURSOR:
+		for (i = 0; i < ARRAY_SIZE(cursor_formats); ++i) {
+			if (num_formats >= max_formats)
+				break;
+
+			formats[num_formats++] = cursor_formats[i];
+		}
+		break;
+	}
+
+	return num_formats;
+}
+
+static void add_modifier(uint64_t **mods, uint64_t *size,
+			 uint64_t *cap, uint64_t mod)
+{
+	if (!*mods)
+		return;
+
+	if (*cap - *size < 1) {
+		uint64_t new_cap = *cap * 2;
+		uint64_t *new_mods = kmalloc(new_cap * sizeof(uint64_t), GFP_KERNEL);
+
+		if (!new_mods) {
+			kfree(*mods);
+			*mods = NULL;
+			return;
+		}
+
+		memcpy(new_mods, *mods, sizeof(uint64_t) * *size);
+		kfree(*mods);
+		*mods = new_mods;
+		*cap = new_cap;
+	}
+
+	(*mods)[*size] = mod;
+	*size += 1;
+}
+
+static void fill_gfx9_tiling_info_from_device(const struct amdgpu_device *adev,
+					      union dc_tiling_info *tiling_info)
+{
+	tiling_info->gfx9.num_pipes =
+		adev->gfx.config.gb_addr_config_fields.num_pipes;
+	tiling_info->gfx9.num_banks =
+		adev->gfx.config.gb_addr_config_fields.num_banks;
+	tiling_info->gfx9.pipe_interleave =
+		adev->gfx.config.gb_addr_config_fields.pipe_interleave_size;
+	tiling_info->gfx9.num_shader_engines =
+		adev->gfx.config.gb_addr_config_fields.num_se;
+	tiling_info->gfx9.max_compressed_frags =
+		adev->gfx.config.gb_addr_config_fields.max_compress_frags;
+	tiling_info->gfx9.num_rb_per_se =
+		adev->gfx.config.gb_addr_config_fields.num_rb_per_se;
+	tiling_info->gfx9.shaderEnable = 1;
+	if (adev->asic_type == CHIP_SIENNA_CICHLID ||
+	    adev->asic_type == CHIP_NAVY_FLOUNDER ||
+	    adev->asic_type == CHIP_DIMGREY_CAVEFISH ||
+	    adev->asic_type == CHIP_VANGOGH)
+		tiling_info->gfx9.num_pkrs = adev->gfx.config.gb_addr_config_fields.num_pkrs;
+}
+
+static void
+fill_gfx9_tiling_info_from_modifier(const struct amdgpu_device *adev,
+				    union dc_tiling_info *tiling_info,
+				    uint64_t modifier)
+{
+	unsigned int mod_bank_xor_bits = AMD_FMT_MOD_GET(BANK_XOR_BITS, modifier);
+	unsigned int mod_pipe_xor_bits = AMD_FMT_MOD_GET(PIPE_XOR_BITS, modifier);
+	unsigned int pkrs_log2 = AMD_FMT_MOD_GET(PACKERS, modifier);
+	unsigned int pipes_log2 = min(4u, mod_pipe_xor_bits);
+
+	fill_gfx9_tiling_info_from_device(adev, tiling_info);
+
+	if (!IS_AMD_FMT_MOD(modifier))
+		return;
+
+	tiling_info->gfx9.num_pipes = 1u << pipes_log2;
+	tiling_info->gfx9.num_shader_engines = 1u << (mod_pipe_xor_bits - pipes_log2);
+
+	if (adev->family >= AMDGPU_FAMILY_NV) {
+		tiling_info->gfx9.num_pkrs = 1u << pkrs_log2;
+	} else {
+		tiling_info->gfx9.num_banks = 1u << mod_bank_xor_bits;
+
+		/* for DCC we know it isn't rb aligned, so rb_per_se doesn't matter. */
+	}
+}
+
+static int validate_dcc(struct amdgpu_device *adev,
+			const enum surface_pixel_format format,
+			const enum dc_rotation_angle rotation,
+			const union dc_tiling_info *tiling_info,
+			const struct dc_plane_dcc_param *dcc,
+			const struct dc_plane_address *address,
+			const struct plane_size *plane_size)
+{
+	struct dc *dc = adev->dm.dc;
+	struct dc_dcc_surface_param input;
+	struct dc_surface_dcc_cap output;
+
+	memset(&input, 0, sizeof(input));
+	memset(&output, 0, sizeof(output));
+
+	if (!dcc->enable)
+		return 0;
+
+	if (format >= SURFACE_PIXEL_FORMAT_VIDEO_BEGIN ||
+	    !dc->cap_funcs.get_dcc_compression_cap)
+		return -EINVAL;
+
+	input.format = format;
+	input.surface_size.width = plane_size->surface_size.width;
+	input.surface_size.height = plane_size->surface_size.height;
+	input.swizzle_mode = tiling_info->gfx9.swizzle;
+
+	if (rotation == ROTATION_ANGLE_0 || rotation == ROTATION_ANGLE_180)
+		input.scan = SCAN_DIRECTION_HORIZONTAL;
+	else if (rotation == ROTATION_ANGLE_90 || rotation == ROTATION_ANGLE_270)
+		input.scan = SCAN_DIRECTION_VERTICAL;
+
+	if (!dc->cap_funcs.get_dcc_compression_cap(dc, &input, &output))
+		return -EINVAL;
+
+	if (!output.capable)
+		return -EINVAL;
+
+	if (dcc->independent_64b_blks == 0 &&
+	    output.grph.rgb.independent_64b_blks != 0)
+		return -EINVAL;
+
+	return 0;
+}
+
+static int
+fill_gfx9_plane_attributes_from_modifiers(struct amdgpu_device *adev,
+					  const struct amdgpu_framebuffer *afb,
+					  const enum surface_pixel_format format,
+					  const enum dc_rotation_angle rotation,
+					  const struct plane_size *plane_size,
+					  union dc_tiling_info *tiling_info,
+					  struct dc_plane_dcc_param *dcc,
+					  struct dc_plane_address *address,
+					  const bool force_disable_dcc)
+{
+	const uint64_t modifier = afb->base.modifier;
+	int ret;
+
+	fill_gfx9_tiling_info_from_modifier(adev, tiling_info, modifier);
+	tiling_info->gfx9.swizzle = modifier_gfx9_swizzle_mode(modifier);
+
+	if (modifier_has_dcc(modifier) && !force_disable_dcc) {
+		uint64_t dcc_address = afb->address + afb->base.offsets[1];
+
+		dcc->enable = 1;
+		dcc->meta_pitch = afb->base.pitches[1];
+		dcc->independent_64b_blks = AMD_FMT_MOD_GET(DCC_INDEPENDENT_64B, modifier);
+
+		address->grph.meta_addr.low_part = lower_32_bits(dcc_address);
+		address->grph.meta_addr.high_part = upper_32_bits(dcc_address);
+	}
+
+	ret = validate_dcc(adev, format, rotation, tiling_info, dcc, address, plane_size);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
+static void add_gfx10_3_modifiers(const struct amdgpu_device *adev,
+				  uint64_t **mods, uint64_t *size,
+				  uint64_t *capacity)
+{
+	int pipe_xor_bits = ilog2(adev->gfx.config.gb_addr_config_fields.num_pipes);
+	int pkrs = ilog2(adev->gfx.config.gb_addr_config_fields.num_pkrs);
+
+	add_modifier(mods, size, capacity, AMD_FMT_MOD |
+		    AMD_FMT_MOD_SET(TILE, AMD_FMT_MOD_TILE_GFX9_64K_R_X) |
+		    AMD_FMT_MOD_SET(TILE_VERSION, AMD_FMT_MOD_TILE_VER_GFX10_RBPLUS) |
+		    AMD_FMT_MOD_SET(PIPE_XOR_BITS, pipe_xor_bits) |
+		    AMD_FMT_MOD_SET(PACKERS, pkrs) |
+		    AMD_FMT_MOD_SET(DCC, 1) |
+		    AMD_FMT_MOD_SET(DCC_CONSTANT_ENCODE, 1) |
+		    AMD_FMT_MOD_SET(DCC_INDEPENDENT_64B, 1) |
+		    AMD_FMT_MOD_SET(DCC_INDEPENDENT_128B, 1) |
+		    AMD_FMT_MOD_SET(DCC_MAX_COMPRESSED_BLOCK, AMD_FMT_MOD_DCC_BLOCK_64B));
+
+	add_modifier(mods, size, capacity, AMD_FMT_MOD |
+		    AMD_FMT_MOD_SET(TILE, AMD_FMT_MOD_TILE_GFX9_64K_R_X) |
+		    AMD_FMT_MOD_SET(TILE_VERSION, AMD_FMT_MOD_TILE_VER_GFX10_RBPLUS) |
+		    AMD_FMT_MOD_SET(PIPE_XOR_BITS, pipe_xor_bits) |
+		    AMD_FMT_MOD_SET(PACKERS, pkrs) |
+		    AMD_FMT_MOD_SET(DCC, 1) |
+		    AMD_FMT_MOD_SET(DCC_RETILE, 1) |
+		    AMD_FMT_MOD_SET(DCC_CONSTANT_ENCODE, 1) |
+		    AMD_FMT_MOD_SET(DCC_INDEPENDENT_64B, 1) |
+		    AMD_FMT_MOD_SET(DCC_INDEPENDENT_128B, 1) |
+		    AMD_FMT_MOD_SET(DCC_MAX_COMPRESSED_BLOCK, AMD_FMT_MOD_DCC_BLOCK_64B));
+
+	add_modifier(mods, size, capacity, AMD_FMT_MOD |
+		    AMD_FMT_MOD_SET(TILE, AMD_FMT_MOD_TILE_GFX9_64K_R_X) |
+		    AMD_FMT_MOD_SET(TILE_VERSION, AMD_FMT_MOD_TILE_VER_GFX10_RBPLUS) |
+		    AMD_FMT_MOD_SET(PIPE_XOR_BITS, pipe_xor_bits) |
+		    AMD_FMT_MOD_SET(PACKERS, pkrs));
+
+	add_modifier(mods, size, capacity, AMD_FMT_MOD |
+		    AMD_FMT_MOD_SET(TILE, AMD_FMT_MOD_TILE_GFX9_64K_S_X) |
+		    AMD_FMT_MOD_SET(TILE_VERSION, AMD_FMT_MOD_TILE_VER_GFX10_RBPLUS) |
+		    AMD_FMT_MOD_SET(PIPE_XOR_BITS, pipe_xor_bits) |
+		    AMD_FMT_MOD_SET(PACKERS, pkrs));
+
+	/* Only supported for 64bpp, will be filtered in dm_plane_format_mod_supported */
+	add_modifier(mods, size, capacity, AMD_FMT_MOD |
+		    AMD_FMT_MOD_SET(TILE, AMD_FMT_MOD_TILE_GFX9_64K_D) |
+		    AMD_FMT_MOD_SET(TILE_VERSION, AMD_FMT_MOD_TILE_VER_GFX9));
+
+	add_modifier(mods, size, capacity, AMD_FMT_MOD |
+		    AMD_FMT_MOD_SET(TILE, AMD_FMT_MOD_TILE_GFX9_64K_S) |
+		    AMD_FMT_MOD_SET(TILE_VERSION, AMD_FMT_MOD_TILE_VER_GFX9));
+}
+
+static void add_gfx10_1_modifiers(const struct amdgpu_device *adev,
+				  uint64_t **mods, uint64_t *size,
+				  uint64_t *capacity)
+{
+	int pipe_xor_bits = ilog2(adev->gfx.config.gb_addr_config_fields.num_pipes);
+
+	add_modifier(mods, size, capacity, AMD_FMT_MOD |
+		    AMD_FMT_MOD_SET(TILE, AMD_FMT_MOD_TILE_GFX9_64K_R_X) |
+		    AMD_FMT_MOD_SET(TILE_VERSION, AMD_FMT_MOD_TILE_VER_GFX10) |
+		    AMD_FMT_MOD_SET(PIPE_XOR_BITS, pipe_xor_bits) |
+		    AMD_FMT_MOD_SET(DCC, 1) |
+		    AMD_FMT_MOD_SET(DCC_CONSTANT_ENCODE, 1) |
+		    AMD_FMT_MOD_SET(DCC_INDEPENDENT_64B, 1) |
+		    AMD_FMT_MOD_SET(DCC_MAX_COMPRESSED_BLOCK, AMD_FMT_MOD_DCC_BLOCK_64B));
+
+	add_modifier(mods, size, capacity, AMD_FMT_MOD |
+		    AMD_FMT_MOD_SET(TILE, AMD_FMT_MOD_TILE_GFX9_64K_R_X) |
+		    AMD_FMT_MOD_SET(TILE_VERSION, AMD_FMT_MOD_TILE_VER_GFX10) |
+		    AMD_FMT_MOD_SET(PIPE_XOR_BITS, pipe_xor_bits) |
+		    AMD_FMT_MOD_SET(DCC, 1) |
+		    AMD_FMT_MOD_SET(DCC_RETILE, 1) |
+		    AMD_FMT_MOD_SET(DCC_CONSTANT_ENCODE, 1) |
+		    AMD_FMT_MOD_SET(DCC_INDEPENDENT_64B, 1) |
+		    AMD_FMT_MOD_SET(DCC_MAX_COMPRESSED_BLOCK, AMD_FMT_MOD_DCC_BLOCK_64B));
+
+	add_modifier(mods, size, capacity, AMD_FMT_MOD |
+		    AMD_FMT_MOD_SET(TILE, AMD_FMT_MOD_TILE_GFX9_64K_R_X) |
+		    AMD_FMT_MOD_SET(TILE_VERSION, AMD_FMT_MOD_TILE_VER_GFX10) |
+		    AMD_FMT_MOD_SET(PIPE_XOR_BITS, pipe_xor_bits));
+
+	add_modifier(mods, size, capacity, AMD_FMT_MOD |
+		    AMD_FMT_MOD_SET(TILE, AMD_FMT_MOD_TILE_GFX9_64K_S_X) |
+		    AMD_FMT_MOD_SET(TILE_VERSION, AMD_FMT_MOD_TILE_VER_GFX10) |
+		    AMD_FMT_MOD_SET(PIPE_XOR_BITS, pipe_xor_bits));
+
+
+	/* Only supported for 64bpp, will be filtered in dm_plane_format_mod_supported */
+	add_modifier(mods, size, capacity, AMD_FMT_MOD |
+		    AMD_FMT_MOD_SET(TILE, AMD_FMT_MOD_TILE_GFX9_64K_D) |
+		    AMD_FMT_MOD_SET(TILE_VERSION, AMD_FMT_MOD_TILE_VER_GFX9));
+
+	add_modifier(mods, size, capacity, AMD_FMT_MOD |
+		    AMD_FMT_MOD_SET(TILE, AMD_FMT_MOD_TILE_GFX9_64K_S) |
+		    AMD_FMT_MOD_SET(TILE_VERSION, AMD_FMT_MOD_TILE_VER_GFX9));
+}
+
+static void add_gfx9_modifiers(const struct amdgpu_device *adev,
+			       uint64_t **mods, uint64_t *size,
+			       uint64_t *capacity)
+{
+	int pipes = ilog2(adev->gfx.config.gb_addr_config_fields.num_pipes);
+	int pipe_xor_bits = min(8, pipes +
+				ilog2(adev->gfx.config.gb_addr_config_fields.num_se));
+	int bank_xor_bits = min(8 - pipe_xor_bits,
+				ilog2(adev->gfx.config.gb_addr_config_fields.num_banks));
+	int rb = ilog2(adev->gfx.config.gb_addr_config_fields.num_se) +
+		 ilog2(adev->gfx.config.gb_addr_config_fields.num_rb_per_se);
+
+	if (adev->family == AMDGPU_FAMILY_RV) {
+		/* Raven2 and later */
+		bool has_constant_encode = adev->asic_type > CHIP_RAVEN || adev->external_rev_id >= 0x81;
+
+		/*
+		 * No _D DCC swizzles yet because we only allow 32bpp, which
+		 * doesn't support _D on DCN
+		 */
+
+		if (has_constant_encode) {
+			add_modifier(mods, size, capacity, AMD_FMT_MOD |
+				    AMD_FMT_MOD_SET(TILE, AMD_FMT_MOD_TILE_GFX9_64K_S_X) |
+				    AMD_FMT_MOD_SET(TILE_VERSION, AMD_FMT_MOD_TILE_VER_GFX9) |
+				    AMD_FMT_MOD_SET(PIPE_XOR_BITS, pipe_xor_bits) |
+				    AMD_FMT_MOD_SET(BANK_XOR_BITS, bank_xor_bits) |
+				    AMD_FMT_MOD_SET(DCC, 1) |
+				    AMD_FMT_MOD_SET(DCC_INDEPENDENT_64B, 1) |
+				    AMD_FMT_MOD_SET(DCC_MAX_COMPRESSED_BLOCK, AMD_FMT_MOD_DCC_BLOCK_64B) |
+				    AMD_FMT_MOD_SET(DCC_CONSTANT_ENCODE, 1));
+		}
+
+		add_modifier(mods, size, capacity, AMD_FMT_MOD |
+			    AMD_FMT_MOD_SET(TILE, AMD_FMT_MOD_TILE_GFX9_64K_S_X) |
+			    AMD_FMT_MOD_SET(TILE_VERSION, AMD_FMT_MOD_TILE_VER_GFX9) |
+			    AMD_FMT_MOD_SET(PIPE_XOR_BITS, pipe_xor_bits) |
+			    AMD_FMT_MOD_SET(BANK_XOR_BITS, bank_xor_bits) |
+			    AMD_FMT_MOD_SET(DCC, 1) |
+			    AMD_FMT_MOD_SET(DCC_INDEPENDENT_64B, 1) |
+			    AMD_FMT_MOD_SET(DCC_MAX_COMPRESSED_BLOCK, AMD_FMT_MOD_DCC_BLOCK_64B) |
+			    AMD_FMT_MOD_SET(DCC_CONSTANT_ENCODE, 0));
+
+		if (has_constant_encode) {
+			add_modifier(mods, size, capacity, AMD_FMT_MOD |
+				    AMD_FMT_MOD_SET(TILE, AMD_FMT_MOD_TILE_GFX9_64K_S_X) |
+				    AMD_FMT_MOD_SET(TILE_VERSION, AMD_FMT_MOD_TILE_VER_GFX9) |
+				    AMD_FMT_MOD_SET(PIPE_XOR_BITS, pipe_xor_bits) |
+				    AMD_FMT_MOD_SET(BANK_XOR_BITS, bank_xor_bits) |
+				    AMD_FMT_MOD_SET(DCC, 1) |
+				    AMD_FMT_MOD_SET(DCC_RETILE, 1) |
+				    AMD_FMT_MOD_SET(DCC_INDEPENDENT_64B, 1) |
+				    AMD_FMT_MOD_SET(DCC_MAX_COMPRESSED_BLOCK, AMD_FMT_MOD_DCC_BLOCK_64B) |
+
+				    AMD_FMT_MOD_SET(DCC_CONSTANT_ENCODE, 1) |
+				    AMD_FMT_MOD_SET(RB, rb) |
+				    AMD_FMT_MOD_SET(PIPE, pipes));
+		}
+
+		add_modifier(mods, size, capacity, AMD_FMT_MOD |
+			    AMD_FMT_MOD_SET(TILE, AMD_FMT_MOD_TILE_GFX9_64K_S_X) |
+			    AMD_FMT_MOD_SET(TILE_VERSION, AMD_FMT_MOD_TILE_VER_GFX9) |
+			    AMD_FMT_MOD_SET(PIPE_XOR_BITS, pipe_xor_bits) |
+			    AMD_FMT_MOD_SET(BANK_XOR_BITS, bank_xor_bits) |
+			    AMD_FMT_MOD_SET(DCC, 1) |
+			    AMD_FMT_MOD_SET(DCC_RETILE, 1) |
+			    AMD_FMT_MOD_SET(DCC_INDEPENDENT_64B, 1) |
+			    AMD_FMT_MOD_SET(DCC_MAX_COMPRESSED_BLOCK, AMD_FMT_MOD_DCC_BLOCK_64B) |
+			    AMD_FMT_MOD_SET(DCC_CONSTANT_ENCODE, 0) |
+			    AMD_FMT_MOD_SET(RB, rb) |
+			    AMD_FMT_MOD_SET(PIPE, pipes));
+	}
+
+	/*
+	 * Only supported for 64bpp on Raven, will be filtered on format in
+	 * dm_plane_format_mod_supported.
+	 */
+	add_modifier(mods, size, capacity, AMD_FMT_MOD |
+		    AMD_FMT_MOD_SET(TILE, AMD_FMT_MOD_TILE_GFX9_64K_D_X) |
+		    AMD_FMT_MOD_SET(TILE_VERSION, AMD_FMT_MOD_TILE_VER_GFX9) |
+		    AMD_FMT_MOD_SET(PIPE_XOR_BITS, pipe_xor_bits) |
+		    AMD_FMT_MOD_SET(BANK_XOR_BITS, bank_xor_bits));
+
+	if (adev->family == AMDGPU_FAMILY_RV) {
+		add_modifier(mods, size, capacity, AMD_FMT_MOD |
+			    AMD_FMT_MOD_SET(TILE, AMD_FMT_MOD_TILE_GFX9_64K_S_X) |
+			    AMD_FMT_MOD_SET(TILE_VERSION, AMD_FMT_MOD_TILE_VER_GFX9) |
+			    AMD_FMT_MOD_SET(PIPE_XOR_BITS, pipe_xor_bits) |
+			    AMD_FMT_MOD_SET(BANK_XOR_BITS, bank_xor_bits));
+	}
+
+	/*
+	 * Only supported for 64bpp on Raven, will be filtered on format in
+	 * dm_plane_format_mod_supported.
+	 */
+	add_modifier(mods, size, capacity, AMD_FMT_MOD |
+		    AMD_FMT_MOD_SET(TILE, AMD_FMT_MOD_TILE_GFX9_64K_D) |
+		    AMD_FMT_MOD_SET(TILE_VERSION, AMD_FMT_MOD_TILE_VER_GFX9));
+
+	if (adev->family == AMDGPU_FAMILY_RV) {
+		add_modifier(mods, size, capacity, AMD_FMT_MOD |
+			    AMD_FMT_MOD_SET(TILE, AMD_FMT_MOD_TILE_GFX9_64K_S) |
+			    AMD_FMT_MOD_SET(TILE_VERSION, AMD_FMT_MOD_TILE_VER_GFX9));
+	}
+}
+
+static void fill_gfx8_tiling_info_from_flags(union dc_tiling_info *tiling_info,
+					     uint64_t tiling_flags)
+{
+	/* Fill GFX8 params */
+	if (AMDGPU_TILING_GET(tiling_flags, ARRAY_MODE) == DC_ARRAY_2D_TILED_THIN1) {
+		unsigned int bankw, bankh, mtaspect, tile_split, num_banks;
+
+		bankw = AMDGPU_TILING_GET(tiling_flags, BANK_WIDTH);
+		bankh = AMDGPU_TILING_GET(tiling_flags, BANK_HEIGHT);
+		mtaspect = AMDGPU_TILING_GET(tiling_flags, MACRO_TILE_ASPECT);
+		tile_split = AMDGPU_TILING_GET(tiling_flags, TILE_SPLIT);
+		num_banks = AMDGPU_TILING_GET(tiling_flags, NUM_BANKS);
+
+		/* XXX fix me for VI */
+		tiling_info->gfx8.num_banks = num_banks;
+		tiling_info->gfx8.array_mode =
+				DC_ARRAY_2D_TILED_THIN1;
+		tiling_info->gfx8.tile_split = tile_split;
+		tiling_info->gfx8.bank_width = bankw;
+		tiling_info->gfx8.bank_height = bankh;
+		tiling_info->gfx8.tile_aspect = mtaspect;
+		tiling_info->gfx8.tile_mode =
+				DC_ADDR_SURF_MICRO_TILING_DISPLAY;
+	} else if (AMDGPU_TILING_GET(tiling_flags, ARRAY_MODE)
+			== DC_ARRAY_1D_TILED_THIN1) {
+		tiling_info->gfx8.array_mode = DC_ARRAY_1D_TILED_THIN1;
+	}
+
+	tiling_info->gfx8.pipe_config =
+			AMDGPU_TILING_GET(tiling_flags, PIPE_CONFIG);
+}
+
+static int
+fill_plane_buffer_attributes(struct amdgpu_device *adev,
+			     const struct amdgpu_framebuffer *afb,
+			     const enum surface_pixel_format format,
+			     const enum dc_rotation_angle rotation,
+			     const uint64_t tiling_flags,
+			     union dc_tiling_info *tiling_info,
+			     struct plane_size *plane_size,
+			     struct dc_plane_dcc_param *dcc,
+			     struct dc_plane_address *address,
+			     bool tmz_surface,
+			     bool force_disable_dcc)
+{
+	const struct drm_framebuffer *fb = &afb->base;
+	int ret;
+
+	memset(tiling_info, 0, sizeof(*tiling_info));
+	memset(plane_size, 0, sizeof(*plane_size));
+	memset(dcc, 0, sizeof(*dcc));
+	memset(address, 0, sizeof(*address));
+
+	address->tmz_surface = tmz_surface;
+
+	if (format < SURFACE_PIXEL_FORMAT_VIDEO_BEGIN) {
+		uint64_t addr = afb->address + fb->offsets[0];
+
+		plane_size->surface_size.x = 0;
+		plane_size->surface_size.y = 0;
+		plane_size->surface_size.width = fb->width;
+		plane_size->surface_size.height = fb->height;
+		plane_size->surface_pitch =
+			fb->pitches[0] / fb->format->cpp[0];
+
+		address->type = PLN_ADDR_TYPE_GRAPHICS;
+		address->grph.addr.low_part = lower_32_bits(addr);
+		address->grph.addr.high_part = upper_32_bits(addr);
+	} else if (format < SURFACE_PIXEL_FORMAT_INVALID) {
+		uint64_t luma_addr = afb->address + fb->offsets[0];
+		uint64_t chroma_addr = afb->address + fb->offsets[1];
+
+		plane_size->surface_size.x = 0;
+		plane_size->surface_size.y = 0;
+		plane_size->surface_size.width = fb->width;
+		plane_size->surface_size.height = fb->height;
+		plane_size->surface_pitch =
+			fb->pitches[0] / fb->format->cpp[0];
+
+		plane_size->chroma_size.x = 0;
+		plane_size->chroma_size.y = 0;
+		/* TODO: set these based on surface format */
+		plane_size->chroma_size.width = fb->width / 2;
+		plane_size->chroma_size.height = fb->height / 2;
+
+		plane_size->chroma_pitch =
+			fb->pitches[1] / fb->format->cpp[1];
+
+		address->type = PLN_ADDR_TYPE_VIDEO_PROGRESSIVE;
+		address->video_progressive.luma_addr.low_part =
+			lower_32_bits(luma_addr);
+		address->video_progressive.luma_addr.high_part =
+			upper_32_bits(luma_addr);
+		address->video_progressive.chroma_addr.low_part =
+			lower_32_bits(chroma_addr);
+		address->video_progressive.chroma_addr.high_part =
+			upper_32_bits(chroma_addr);
+	}
+
+	if (adev->family >= AMDGPU_FAMILY_AI) {
+		ret = fill_gfx9_plane_attributes_from_modifiers(adev, afb, format,
+								rotation, plane_size,
+								tiling_info, dcc,
+								address,
+								force_disable_dcc);
+		if (ret)
+			return ret;
+	} else {
+		fill_gfx8_tiling_info_from_flags(tiling_info, tiling_flags);
+	}
+
+	return 0;
+}
+
+static int fill_plane_color_attributes(const struct drm_plane_state *plane_state,
+				       const enum surface_pixel_format format,
+				       enum dc_color_space *color_space)
+{
+	bool full_range;
+
+	*color_space = COLOR_SPACE_SRGB;
+
+	/* DRM color properties only affect non-RGB formats. */
+	if (format < SURFACE_PIXEL_FORMAT_VIDEO_BEGIN)
+		return 0;
+
+	full_range = (plane_state->color_range == DRM_COLOR_YCBCR_FULL_RANGE);
+
+	switch (plane_state->color_encoding) {
+	case DRM_COLOR_YCBCR_BT601:
+		if (full_range)
+			*color_space = COLOR_SPACE_YCBCR601;
+		else
+			*color_space = COLOR_SPACE_YCBCR601_LIMITED;
+		break;
+
+	case DRM_COLOR_YCBCR_BT709:
+		if (full_range)
+			*color_space = COLOR_SPACE_YCBCR709;
+		else
+			*color_space = COLOR_SPACE_YCBCR709_LIMITED;
+		break;
+
+	case DRM_COLOR_YCBCR_BT2020:
+		if (full_range)
+			*color_space = COLOR_SPACE_2020_YCBCR;
+		else
+			return -EINVAL;
+		break;
+
+	default:
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static void
+fill_blending_from_plane_state(const struct drm_plane_state *plane_state,
+			       bool *per_pixel_alpha, bool *global_alpha,
+			       int *global_alpha_value)
+{
+	*per_pixel_alpha = false;
+	*global_alpha = false;
+	*global_alpha_value = 0xff;
+
+	if (plane_state->plane->type != DRM_PLANE_TYPE_OVERLAY)
+		return;
+
+	if (plane_state->pixel_blend_mode == DRM_MODE_BLEND_PREMULTI) {
+		static const uint32_t alpha_formats[] = {
+			DRM_FORMAT_ARGB8888,
+			DRM_FORMAT_RGBA8888,
+			DRM_FORMAT_ABGR8888,
+		};
+		uint32_t format = plane_state->fb->format->format;
+		unsigned int i;
+
+		for (i = 0; i < ARRAY_SIZE(alpha_formats); ++i) {
+			if (format == alpha_formats[i]) {
+				*per_pixel_alpha = true;
+				break;
+			}
+		}
+	}
+
+	if (plane_state->alpha < 0xffff) {
+		*global_alpha = true;
+		*global_alpha_value = plane_state->alpha >> 8;
+	}
+}
+
+int fill_dc_plane_info_and_addr(struct amdgpu_device *adev,
+				const struct drm_plane_state *plane_state,
+				const uint64_t tiling_flags,
+				struct dc_plane_info *plane_info,
+				struct dc_plane_address *address,
+				bool tmz_surface,
+				bool force_disable_dcc)
+{
+	const struct drm_framebuffer *fb = plane_state->fb;
+	const struct amdgpu_framebuffer *afb =
+		to_amdgpu_framebuffer(plane_state->fb);
+	int ret;
+
+	memset(plane_info, 0, sizeof(*plane_info));
+
+	switch (fb->format->format) {
+	case DRM_FORMAT_C8:
+		plane_info->format =
+			SURFACE_PIXEL_FORMAT_GRPH_PALETA_256_COLORS;
+		break;
+	case DRM_FORMAT_RGB565:
+		plane_info->format = SURFACE_PIXEL_FORMAT_GRPH_RGB565;
+		break;
+	case DRM_FORMAT_XRGB8888:
+	case DRM_FORMAT_ARGB8888:
+		plane_info->format = SURFACE_PIXEL_FORMAT_GRPH_ARGB8888;
+		break;
+	case DRM_FORMAT_XRGB2101010:
+	case DRM_FORMAT_ARGB2101010:
+		plane_info->format = SURFACE_PIXEL_FORMAT_GRPH_ARGB2101010;
+		break;
+	case DRM_FORMAT_XBGR2101010:
+	case DRM_FORMAT_ABGR2101010:
+		plane_info->format = SURFACE_PIXEL_FORMAT_GRPH_ABGR2101010;
+		break;
+	case DRM_FORMAT_XBGR8888:
+	case DRM_FORMAT_ABGR8888:
+		plane_info->format = SURFACE_PIXEL_FORMAT_GRPH_ABGR8888;
+		break;
+	case DRM_FORMAT_NV21:
+		plane_info->format = SURFACE_PIXEL_FORMAT_VIDEO_420_YCbCr;
+		break;
+	case DRM_FORMAT_NV12:
+		plane_info->format = SURFACE_PIXEL_FORMAT_VIDEO_420_YCrCb;
+		break;
+	case DRM_FORMAT_P010:
+		plane_info->format = SURFACE_PIXEL_FORMAT_VIDEO_420_10bpc_YCrCb;
+		break;
+	case DRM_FORMAT_XRGB16161616F:
+	case DRM_FORMAT_ARGB16161616F:
+		plane_info->format = SURFACE_PIXEL_FORMAT_GRPH_ARGB16161616F;
+		break;
+	case DRM_FORMAT_XBGR16161616F:
+	case DRM_FORMAT_ABGR16161616F:
+		plane_info->format = SURFACE_PIXEL_FORMAT_GRPH_ABGR16161616F;
+		break;
+	default:
+		DRM_ERROR("Unsupported screen format %p4cc\n",
+			  &fb->format->format);
+		return -EINVAL;
+	}
+
+	switch (plane_state->rotation & DRM_MODE_ROTATE_MASK) {
+	case DRM_MODE_ROTATE_0:
+		plane_info->rotation = ROTATION_ANGLE_0;
+		break;
+	case DRM_MODE_ROTATE_90:
+		plane_info->rotation = ROTATION_ANGLE_90;
+		break;
+	case DRM_MODE_ROTATE_180:
+		plane_info->rotation = ROTATION_ANGLE_180;
+		break;
+	case DRM_MODE_ROTATE_270:
+		plane_info->rotation = ROTATION_ANGLE_270;
+		break;
+	default:
+		plane_info->rotation = ROTATION_ANGLE_0;
+		break;
+	}
+
+	plane_info->visible = true;
+	plane_info->stereo_format = PLANE_STEREO_FORMAT_NONE;
+
+	plane_info->layer_index = 0;
+
+	ret = fill_plane_color_attributes(plane_state, plane_info->format,
+					  &plane_info->color_space);
+	if (ret)
+		return ret;
+
+	ret = fill_plane_buffer_attributes(adev, afb, plane_info->format,
+					   plane_info->rotation, tiling_flags,
+					   &plane_info->tiling_info,
+					   &plane_info->plane_size,
+					   &plane_info->dcc, address, tmz_surface,
+					   force_disable_dcc);
+	if (ret)
+		return ret;
+
+	fill_blending_from_plane_state(plane_state, &plane_info->per_pixel_alpha,
+				       &plane_info->global_alpha,
+				       &plane_info->global_alpha_value);
+
+	return 0;
+}
+
+static int dm_plane_helper_prepare_fb(struct drm_plane *plane,
+				      struct drm_plane_state *new_state)
+{
+	struct amdgpu_framebuffer *afb;
+	struct drm_gem_object *obj;
+	struct amdgpu_device *adev;
+	struct amdgpu_bo *rbo;
+	struct dm_plane_state *dm_plane_state_new, *dm_plane_state_old;
+	struct list_head list;
+	struct ttm_validate_buffer tv;
+	struct ww_acquire_ctx ticket;
+	uint32_t domain;
+	int r;
+
+	if (!new_state->fb) {
+		DRM_DEBUG_KMS("No FB bound\n");
+		return 0;
+	}
+
+	afb = to_amdgpu_framebuffer(new_state->fb);
+	obj = new_state->fb->obj[0];
+	rbo = gem_to_amdgpu_bo(obj);
+	adev = amdgpu_ttm_adev(rbo->tbo.bdev);
+	INIT_LIST_HEAD(&list);
+
+	tv.bo = &rbo->tbo;
+	tv.num_shared = 1;
+	list_add(&tv.head, &list);
+
+	r = ttm_eu_reserve_buffers(&ticket, &list, false, NULL);
+	if (r) {
+		dev_err(adev->dev, "fail to reserve bo (%d)\n", r);
+		return r;
+	}
+
+	if (plane->type != DRM_PLANE_TYPE_CURSOR)
+		domain = amdgpu_display_supported_domains(adev, rbo->flags);
+	else
+		domain = AMDGPU_GEM_DOMAIN_VRAM;
+
+	r = amdgpu_bo_pin(rbo, domain);
+	if (unlikely(r != 0)) {
+		if (r != -ERESTARTSYS)
+			DRM_ERROR("Failed to pin framebuffer with error %d\n", r);
+		ttm_eu_backoff_reservation(&ticket, &list);
+		return r;
+	}
+
+	r = amdgpu_ttm_alloc_gart(&rbo->tbo);
+	if (unlikely(r != 0)) {
+		amdgpu_bo_unpin(rbo);
+		ttm_eu_backoff_reservation(&ticket, &list);
+		DRM_ERROR("%p bind failed\n", rbo);
+		return r;
+	}
+
+	ttm_eu_backoff_reservation(&ticket, &list);
+
+	afb->address = amdgpu_bo_gpu_offset(rbo);
+
+	amdgpu_bo_ref(rbo);
+
+	/**
+	 * We don't do surface updates on planes that have been newly created,
+	 * but we also don't have the afb->address during atomic check.
+	 *
+	 * Fill in buffer attributes depending on the address here, but only on
+	 * newly created planes since they're not being used by DC yet and this
+	 * won't modify global state.
+	 */
+	dm_plane_state_old = to_dm_plane_state(plane->state);
+	dm_plane_state_new = to_dm_plane_state(new_state);
+
+	if (dm_plane_state_new->dc_state &&
+	    dm_plane_state_old->dc_state != dm_plane_state_new->dc_state) {
+		struct dc_plane_state *plane_state =
+			dm_plane_state_new->dc_state;
+		bool force_disable_dcc = !plane_state->dcc.enable;
+
+		fill_plane_buffer_attributes(adev, afb, plane_state->format,
+			plane_state->rotation,
+			afb->tiling_flags,
+			&plane_state->tiling_info, &plane_state->plane_size,
+			&plane_state->dcc, &plane_state->address,
+			afb->tmz_surface, force_disable_dcc);
+	}
+
+	return 0;
+}
+
+static void dm_plane_helper_cleanup_fb(struct drm_plane *plane,
+				       struct drm_plane_state *old_state)
+{
+	struct amdgpu_bo *rbo;
+	int r;
+
+	if (!old_state->fb)
+		return;
+
+	rbo = gem_to_amdgpu_bo(old_state->fb->obj[0]);
+	r = amdgpu_bo_reserve(rbo, false);
+	if (unlikely(r)) {
+		DRM_ERROR("failed to reserve rbo before unpin\n");
+		return;
+	}
+
+	amdgpu_bo_unpin(rbo);
+	amdgpu_bo_unreserve(rbo);
+	amdgpu_bo_unref(&rbo);
+}
+
+void get_min_max_dc_plane_scaling(struct drm_device *dev,
+				  struct drm_framebuffer *fb,
+				  int *min_downscale, int *max_upscale)
+{
+	struct amdgpu_device *adev = drm_to_adev(dev);
+	struct dc *dc = adev->dm.dc;
+	/* Caps for all supported planes are the same on DCE and DCN 1 - 3 */
+	struct dc_plane_cap *plane_cap = &dc->caps.planes[0];
+
+	switch (fb->format->format) {
+	case DRM_FORMAT_P010:
+	case DRM_FORMAT_NV12:
+	case DRM_FORMAT_NV21:
+		*max_upscale = plane_cap->max_upscale_factor.nv12;
+		*min_downscale = plane_cap->max_downscale_factor.nv12;
+		break;
+
+	case DRM_FORMAT_XRGB16161616F:
+	case DRM_FORMAT_ARGB16161616F:
+	case DRM_FORMAT_XBGR16161616F:
+	case DRM_FORMAT_ABGR16161616F:
+		*max_upscale = plane_cap->max_upscale_factor.fp16;
+		*min_downscale = plane_cap->max_downscale_factor.fp16;
+		break;
+
+	default:
+		*max_upscale = plane_cap->max_upscale_factor.argb8888;
+		*min_downscale = plane_cap->max_downscale_factor.argb8888;
+		break;
+	}
+
+	/*
+	 * A factor of 1 in the plane_cap means to not allow scaling, ie. use a
+	 * scaling factor of 1.0 == 1000 units.
+	 */
+	if (*max_upscale == 1)
+		*max_upscale = 1000;
+
+	if (*min_downscale == 1)
+		*min_downscale = 1000;
+}
+
+int dm_plane_helper_check_state(struct drm_plane_state *state,
+				struct drm_crtc_state *new_crtc_state)
+{
+	struct drm_framebuffer *fb = state->fb;
+	int min_downscale, max_upscale;
+	int min_scale = 0;
+	int max_scale = INT_MAX;
+
+	/* Plane enabled? Validate viewport and get scaling factors from plane caps. */
+	if (fb && state->crtc) {
+		/* Validate viewport to cover the case when only the position changes */
+		if (state->plane->type != DRM_PLANE_TYPE_CURSOR) {
+			int viewport_width = state->crtc_w;
+			int viewport_height = state->crtc_h;
+
+			if (state->crtc_x < 0)
+				viewport_width += state->crtc_x;
+			else if (state->crtc_x + state->crtc_w > new_crtc_state->mode.crtc_hdisplay)
+				viewport_width = new_crtc_state->mode.crtc_hdisplay - state->crtc_x;
+
+			if (state->crtc_y < 0)
+				viewport_height += state->crtc_y;
+			else if (state->crtc_y + state->crtc_h > new_crtc_state->mode.crtc_vdisplay)
+				viewport_height = new_crtc_state->mode.crtc_vdisplay - state->crtc_y;
+
+			if (viewport_width < 0 || viewport_height < 0) {
+				DRM_DEBUG_ATOMIC("Plane completely outside of screen\n");
+				return -EINVAL;
+			} else if (viewport_width < MIN_VIEWPORT_SIZE*2) { /* x2 for width is because of pipe-split. */
+				DRM_DEBUG_ATOMIC("Viewport width %d smaller than %d\n", viewport_width, MIN_VIEWPORT_SIZE*2);
+				return -EINVAL;
+			} else if (viewport_height < MIN_VIEWPORT_SIZE) {
+				DRM_DEBUG_ATOMIC("Viewport height %d smaller than %d\n", viewport_height, MIN_VIEWPORT_SIZE);
+				return -EINVAL;
+			}
+		}
+
+		/* Get min/max allowed scaling factors from plane caps. */
+		get_min_max_dc_plane_scaling(state->crtc->dev, fb,
+					     &min_downscale, &max_upscale);
+		/*
+		 * Convert to drm convention: 16.16 fixed point, instead of dc's
+		 * 1.0 == 1000. Also drm scaling is src/dst instead of dc's
+		 * dst/src, so min_scale = 1.0 / max_upscale, etc.
+		 */
+		min_scale = (1000 << 16) / max_upscale;
+		max_scale = (1000 << 16) / min_downscale;
+	}
+
+	return drm_atomic_helper_check_plane_state(state, new_crtc_state,
+						   min_scale, max_scale,
+						   true, true);
+}
+
+int fill_dc_scaling_info(const struct drm_plane_state *state,
+			 struct dc_scaling_info *scaling_info)
+{
+	int scale_w, scale_h, min_downscale, max_upscale;
+
+	memset(scaling_info, 0, sizeof(*scaling_info));
+
+	/* Source is fixed 16.16 but we ignore mantissa for now... */
+	scaling_info->src_rect.x = state->src_x >> 16;
+	scaling_info->src_rect.y = state->src_y >> 16;
+
+	/*
+	 * For reasons we don't (yet) fully understand a non-zero
+	 * src_y coordinate into an NV12 buffer can cause a
+	 * system hang. To avoid hangs (and maybe be overly cautious)
+	 * let's reject both non-zero src_x and src_y.
+	 *
+	 * We currently know of only one use-case to reproduce a
+	 * scenario with non-zero src_x and src_y for NV12, which
+	 * is to gesture the YouTube Android app into full screen
+	 * on ChromeOS.
+	 */
+	if (state->fb &&
+	    state->fb->format->format == DRM_FORMAT_NV12 &&
+	    (scaling_info->src_rect.x != 0 ||
+	     scaling_info->src_rect.y != 0))
+		return -EINVAL;
+
+	scaling_info->src_rect.width = state->src_w >> 16;
+	if (scaling_info->src_rect.width == 0)
+		return -EINVAL;
+
+	scaling_info->src_rect.height = state->src_h >> 16;
+	if (scaling_info->src_rect.height == 0)
+		return -EINVAL;
+
+	scaling_info->dst_rect.x = state->crtc_x;
+	scaling_info->dst_rect.y = state->crtc_y;
+
+	if (state->crtc_w == 0)
+		return -EINVAL;
+
+	scaling_info->dst_rect.width = state->crtc_w;
+
+	if (state->crtc_h == 0)
+		return -EINVAL;
+
+	scaling_info->dst_rect.height = state->crtc_h;
+
+	/* DRM doesn't specify clipping on destination output. */
+	scaling_info->clip_rect = scaling_info->dst_rect;
+
+	/* Validate scaling per-format with DC plane caps */
+	if (state->plane && state->plane->dev && state->fb) {
+		get_min_max_dc_plane_scaling(state->plane->dev, state->fb,
+					     &min_downscale, &max_upscale);
+	} else {
+		min_downscale = 250;
+		max_upscale = 16000;
+	}
+
+	scale_w = scaling_info->dst_rect.width * 1000 /
+		  scaling_info->src_rect.width;
+
+	if (scale_w < min_downscale || scale_w > max_upscale)
+		return -EINVAL;
+
+	scale_h = scaling_info->dst_rect.height * 1000 /
+		  scaling_info->src_rect.height;
+
+	if (scale_h < min_downscale || scale_h > max_upscale)
+		return -EINVAL;
+
+	/*
+	 * The "scaling_quality" can be ignored for now, quality = 0 has DC
+	 * assume reasonable defaults based on the format.
+	 */
+
+	return 0;
+}
+
+static int dm_plane_atomic_check(struct drm_plane *plane,
+				 struct drm_plane_state *state)
+{
+	struct amdgpu_device *adev = drm_to_adev(plane->dev);
+	struct dc *dc = adev->dm.dc;
+	struct dm_plane_state *dm_plane_state;
+	struct dc_scaling_info scaling_info;
+	struct drm_crtc_state *new_crtc_state;
+	int ret;
+
+	trace_amdgpu_dm_plane_atomic_check(state);
+
+	dm_plane_state = to_dm_plane_state(state);
+
+	if (!dm_plane_state->dc_state)
+		return 0;
+
+	new_crtc_state =
+		drm_atomic_get_new_crtc_state(state->state, state->crtc);
+	if (!new_crtc_state)
+		return -EINVAL;
+
+	ret = dm_plane_helper_check_state(state, new_crtc_state);
+	if (ret)
+		return ret;
+
+	ret = fill_dc_scaling_info(state, &scaling_info);
+	if (ret)
+		return ret;
+
+	if (dc_validate_plane(dc, dm_plane_state->dc_state) == DC_OK)
+		return 0;
+
+	return -EINVAL;
+}
+
+static int dm_plane_atomic_async_check(struct drm_plane *plane,
+				       struct drm_plane_state *new_plane_state)
+{
+	/* Only support async updates on cursor planes. */
+	if (plane->type != DRM_PLANE_TYPE_CURSOR)
+		return -EINVAL;
+
+	return 0;
+}
+
+static int get_cursor_position(struct drm_plane *plane, struct drm_crtc *crtc,
+			       struct dc_cursor_position *position)
+{
+	struct amdgpu_crtc *amdgpu_crtc = to_amdgpu_crtc(crtc);
+	int x, y;
+	int xorigin = 0, yorigin = 0;
+
+	if (!crtc || !plane->state->fb)
+		return 0;
+
+	if ((plane->state->crtc_w > amdgpu_crtc->max_cursor_width) ||
+	    (plane->state->crtc_h > amdgpu_crtc->max_cursor_height)) {
+		DRM_ERROR("%s: bad cursor width or height %d x %d\n",
+			  __func__,
+			  plane->state->crtc_w,
+			  plane->state->crtc_h);
+		return -EINVAL;
+	}
+
+	x = plane->state->crtc_x;
+	y = plane->state->crtc_y;
+
+	if (x <= -amdgpu_crtc->max_cursor_width ||
+	    y <= -amdgpu_crtc->max_cursor_height)
+		return 0;
+
+	if (x < 0) {
+		xorigin = min(-x, amdgpu_crtc->max_cursor_width - 1);
+		x = 0;
+	}
+	if (y < 0) {
+		yorigin = min(-y, amdgpu_crtc->max_cursor_height - 1);
+		y = 0;
+	}
+	position->enable = true;
+	position->translate_by_source = true;
+	position->x = x;
+	position->y = y;
+	position->x_hotspot = xorigin;
+	position->y_hotspot = yorigin;
+
+	return 0;
+}
+
+void handle_cursor_update(struct drm_plane *plane,
+			  struct drm_plane_state *old_plane_state)
+{
+	struct amdgpu_device *adev = drm_to_adev(plane->dev);
+	struct amdgpu_framebuffer *afb = to_amdgpu_framebuffer(plane->state->fb);
+	struct drm_crtc *crtc = afb ? plane->state->crtc : old_plane_state->crtc;
+	struct dm_crtc_state *crtc_state = crtc ? to_dm_crtc_state(crtc->state) : NULL;
+	struct amdgpu_crtc *amdgpu_crtc = to_amdgpu_crtc(crtc);
+	uint64_t address = afb ? afb->address : 0;
+	struct dc_cursor_position position = {0};
+	struct dc_cursor_attributes attributes;
+	int ret;
+
+	if (!plane->state->fb && !old_plane_state->fb)
+		return;
+
+	DC_LOG_CURSOR("%s: crtc_id=%d with size %d to %d\n",
+		      __func__,
+		      amdgpu_crtc->crtc_id,
+		      plane->state->crtc_w,
+		      plane->state->crtc_h);
+
+	ret = get_cursor_position(plane, crtc, &position);
+	if (ret)
+		return;
+
+	if (!position.enable) {
+		/* turn off cursor */
+		if (crtc_state && crtc_state->stream) {
+			mutex_lock(&adev->dm.dc_lock);
+			dc_stream_set_cursor_position(crtc_state->stream,
+						      &position);
+			mutex_unlock(&adev->dm.dc_lock);
+		}
+		return;
+	}
+
+	amdgpu_crtc->cursor_width = plane->state->crtc_w;
+	amdgpu_crtc->cursor_height = plane->state->crtc_h;
+
+	memset(&attributes, 0, sizeof(attributes));
+	attributes.address.high_part = upper_32_bits(address);
+	attributes.address.low_part  = lower_32_bits(address);
+	attributes.width             = plane->state->crtc_w;
+	attributes.height            = plane->state->crtc_h;
+	attributes.color_format      = CURSOR_MODE_COLOR_PRE_MULTIPLIED_ALPHA;
+	attributes.rotation_angle    = 0;
+	attributes.attribute_flags.value = 0;
+
+	attributes.pitch = afb->base.pitches[0] / afb->base.format->cpp[0];
+
+	if (crtc_state->stream) {
+		mutex_lock(&adev->dm.dc_lock);
+		if (!dc_stream_set_cursor_attributes(crtc_state->stream,
+						     &attributes))
+			DRM_ERROR("DC failed to set cursor attributes\n");
+
+		if (!dc_stream_set_cursor_position(crtc_state->stream,
+						   &position))
+			DRM_ERROR("DC failed to set cursor position\n");
+		mutex_unlock(&adev->dm.dc_lock);
+	}
+}
+
+static void dm_plane_atomic_async_update(struct drm_plane *plane,
+					 struct drm_plane_state *new_state)
+{
+	struct drm_plane_state *old_state =
+		drm_atomic_get_old_plane_state(new_state->state, plane);
+
+	trace_amdgpu_dm_atomic_update_cursor(new_state);
+
+	swap(plane->state->fb, new_state->fb);
+
+	plane->state->src_x = new_state->src_x;
+	plane->state->src_y = new_state->src_y;
+	plane->state->src_w = new_state->src_w;
+	plane->state->src_h = new_state->src_h;
+	plane->state->crtc_x = new_state->crtc_x;
+	plane->state->crtc_y = new_state->crtc_y;
+	plane->state->crtc_w = new_state->crtc_w;
+	plane->state->crtc_h = new_state->crtc_h;
+
+	handle_cursor_update(plane, old_state);
+}
+
+static const struct drm_plane_helper_funcs dm_plane_helper_funcs = {
+	.prepare_fb = dm_plane_helper_prepare_fb,
+	.cleanup_fb = dm_plane_helper_cleanup_fb,
+	.atomic_check = dm_plane_atomic_check,
+	.atomic_async_check = dm_plane_atomic_async_check,
+	.atomic_async_update = dm_plane_atomic_async_update
+};
+
+static int get_plane_modifiers(const struct amdgpu_device *adev,
+			       unsigned int plane_type, uint64_t **mods)
+{
+	uint64_t size = 0, capacity = 128;
+	*mods = NULL;
+
+	/* We have not hooked up any pre-GFX9 modifiers. */
+	if (adev->family < AMDGPU_FAMILY_AI)
+		return 0;
+
+	*mods = kmalloc(capacity * sizeof(uint64_t), GFP_KERNEL);
+
+	if (plane_type == DRM_PLANE_TYPE_CURSOR) {
+		add_modifier(mods, &size, &capacity, DRM_FORMAT_MOD_LINEAR);
+		add_modifier(mods, &size, &capacity, DRM_FORMAT_MOD_INVALID);
+		return *mods ? 0 : -ENOMEM;
+	}
+
+	switch (adev->family) {
+	case AMDGPU_FAMILY_AI:
+	case AMDGPU_FAMILY_RV:
+		add_gfx9_modifiers(adev, mods, &size, &capacity);
+		break;
+	case AMDGPU_FAMILY_NV:
+	case AMDGPU_FAMILY_VGH:
+		if (adev->asic_type >= CHIP_SIENNA_CICHLID)
+			add_gfx10_3_modifiers(adev, mods, &size, &capacity);
+		else
+			add_gfx10_1_modifiers(adev, mods, &size, &capacity);
+		break;
+	}
+
+	add_modifier(mods, &size, &capacity, DRM_FORMAT_MOD_LINEAR);
+
+	/* INVALID marks the end of the list. */
+	add_modifier(mods, &size, &capacity, DRM_FORMAT_MOD_INVALID);
+
+	if (!*mods)
+		return -ENOMEM;
+
+	return 0;
+}
+
+int amdgpu_dm_plane_init(struct amdgpu_display_manager *dm,
+			 struct drm_plane *plane,
+			 unsigned long possible_crtcs,
+			 const struct dc_plane_cap *plane_cap)
+{
+	uint32_t formats[32];
+	int num_formats;
+	int res = -EPERM;
+	unsigned int supported_rotations;
+	uint64_t *modifiers = NULL;
+
+	num_formats = get_plane_formats(plane, plane_cap, formats,
+					ARRAY_SIZE(formats));
+
+	res = get_plane_modifiers(dm->adev, plane->type, &modifiers);
+	if (res)
+		return res;
+
+	res = drm_universal_plane_init(adev_to_drm(dm->adev), plane, possible_crtcs,
+				       &dm_plane_funcs, formats, num_formats,
+				       modifiers, plane->type, NULL);
+	kfree(modifiers);
+	if (res)
+		return res;
+
+	if (plane->type == DRM_PLANE_TYPE_OVERLAY &&
+	    plane_cap && plane_cap->per_pixel_alpha) {
+		unsigned int blend_caps = BIT(DRM_MODE_BLEND_PIXEL_NONE) |
+					  BIT(DRM_MODE_BLEND_PREMULTI);
+
+		drm_plane_create_alpha_property(plane);
+		drm_plane_create_blend_mode_property(plane, blend_caps);
+	}
+
+	if (plane->type == DRM_PLANE_TYPE_PRIMARY &&
+	    plane_cap &&
+	    (plane_cap->pixel_format_support.nv12 ||
+	     plane_cap->pixel_format_support.p010)) {
+		/* This only affects YUV formats. */
+		drm_plane_create_color_properties(plane,
+			BIT(DRM_COLOR_YCBCR_BT601) |
+			BIT(DRM_COLOR_YCBCR_BT709) |
+			BIT(DRM_COLOR_YCBCR_BT2020),
+			BIT(DRM_COLOR_YCBCR_LIMITED_RANGE) |
+			BIT(DRM_COLOR_YCBCR_FULL_RANGE),
+			DRM_COLOR_YCBCR_BT709, DRM_COLOR_YCBCR_LIMITED_RANGE);
+	}
+
+	supported_rotations =
+		DRM_MODE_ROTATE_0 | DRM_MODE_ROTATE_90 |
+		DRM_MODE_ROTATE_180 | DRM_MODE_ROTATE_270;
+
+	if (dm->adev->asic_type >= CHIP_BONAIRE &&
+	    plane->type != DRM_PLANE_TYPE_CURSOR)
+		drm_plane_create_rotation_property(plane, DRM_MODE_ROTATE_0,
+						   supported_rotations);
+
+	drm_plane_helper_add(plane, &dm_plane_helper_funcs);
+
+	/* Create (reset) the plane state */
+	if (plane->funcs->reset)
+		plane->funcs->reset(plane);
+
+	return 0;
+}
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.h
new file mode 100644
index 000000000000..cbf6f3017ecb
--- /dev/null
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.h
@@ -0,0 +1,56 @@
+/*
+ * Copyright (C) 2021 Advanced Micro Devices, Inc. All rights reserved.
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a
+ * copy of this software and associated documentation files (the "Software"),
+ * to deal in the Software without restriction, including without limitation
+ * the rights to use, copy, modify, merge, publish, distribute, sublicense,
+ * and/or sell copies of the Software, and to permit persons to whom the
+ * Software is furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
+ * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR
+ * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
+ * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
+ * OTHER DEALINGS IN THE SOFTWARE.
+ *
+ * Authors: AMD
+ *
+ */
+
+#include "dc.h"
+#include "amdgpu_dm.h"
+
+/* Forward declarations */
+struct dc_plane_state;
+
+void handle_cursor_update(struct drm_plane *plane,
+			  struct drm_plane_state *old_plane_state);
+
+int fill_dc_scaling_info(const struct drm_plane_state *state,
+			 struct dc_scaling_info *scaling_info);
+
+void get_min_max_dc_plane_scaling(struct drm_device *dev,
+				  struct drm_framebuffer *fb,
+				  int *min_downscale, int *max_upscale);
+
+int dm_plane_helper_check_state(struct drm_plane_state *state,
+				struct drm_crtc_state *new_crtc_state);
+
+int fill_dc_plane_info_and_addr(struct amdgpu_device *adev,
+				const struct drm_plane_state *plane_state,
+				const uint64_t tiling_flags,
+				struct dc_plane_info *plane_info,
+				struct dc_plane_address *address,
+				bool tmz_surface,
+				bool force_disable_dcc);
+
+int amdgpu_dm_plane_init(struct amdgpu_display_manager *dm,
+			 struct drm_plane *plane,
+			 unsigned long possible_crtcs,
+			 const struct dc_plane_cap *plane_cap);
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
