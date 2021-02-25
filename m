Return-Path: <SRS0=Rd3N=H3=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 230EFC433E0
	for <amd-gfx@archiver.kernel.org>; Thu, 25 Feb 2021 20:16:36 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BAB2C64F37
	for <amd-gfx@archiver.kernel.org>; Thu, 25 Feb 2021 20:16:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BAB2C64F37
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6418A6E140;
	Thu, 25 Feb 2021 20:16:35 +0000 (UTC)
Received: from NAM02-CY1-obe.outbound.protection.outlook.com
 (mail-eopbgr760044.outbound.protection.outlook.com [40.107.76.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C2EB06E1AA
 for <amd-gfx@lists.freedesktop.org>; Thu, 25 Feb 2021 20:16:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TUoEl6LZwUU+V7D2RSPbTcr84FFAKAQHMAEjnlVE1R90wI71da/xyjCNQq/x82Yue41YmvwZF8F10AI1M9tKezpfCN20ejIhL9hPiWj5q3Vc7GtOWrm1SK9MPhts0bs0mUqZEODVjYBJv3yZQ5Yqa/DfzpBgYYXkN2/XNn5T0HG0phGiDQiI1kotW96yUXnS0FpT0oeszlun5JDejlEBMx5nOEZz1hPmlVJiGfguVJ5y30racjxKtOIZDgXjp7nXSuM2XDxfDWqIcPCZOy0ShROsCPesW1/AGmG3HRfl7U5QT7f7LOxUkWtCtdXUUKPhM33XYI2I9k6CRhJYPhM/xA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nHsgw7oTDxdbOYLJNYjwgnpB95ld4Pb8h0n66kHFVOg=;
 b=W6kNf6AOjxx76rCgLKfBAqZvXtnfbdK0WcpB0Z/LwOXeio9aMOBE+vH9Fbe6m/whtcXZSIbCipX73EvMsSN39WL82xpnNxmyB+udQIuqg97aQ9/XLx0KZ82et+edccw0K6ZLYmuuIgub5rCo9jHUVWSHB3jNKNxm9Qu2s6H4L5gEk4F3OhFbpo02lIY1fhEcxVlaM0Pbhlv6r4UFGgg9PJedWmytXK50yyykObzzma3HXMgOcCNpH6DxbZ73XKfdsUY1CbRlzRiL/hcCGHxbzOzieZNIVa8dzhKC8p2k++1uXmbnUJztTymPTpMlRYVDSwAQyw9x13yhy6Y5Itwuow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nHsgw7oTDxdbOYLJNYjwgnpB95ld4Pb8h0n66kHFVOg=;
 b=nvw7dzT5TVMtNDDw0ePN5AJwcluCaXyAc3YeIa8W6ZUR4gpuzf1BRyVbCMwhQrjGejec+kSIxRQSx3iAtf86Z0CtCtProUrycSKcxBCX2tyWTPaGJa5XO+p2+HW/1+GzzSzZYwfU9XMUUPtmKRhQhnJRGosG/TxXvI83l1xvFNY=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 by MN2PR12MB3872.namprd12.prod.outlook.com (2603:10b6:208:168::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.19; Thu, 25 Feb
 2021 20:16:31 +0000
Received: from MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::b0c4:9a8b:4c4c:76af]) by MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::b0c4:9a8b:4c4c:76af%7]) with mapi id 15.20.3890.020; Thu, 25 Feb 2021
 20:16:31 +0000
From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 3/5] drm/amdgpu: add INFO ioctl support for querying video
 caps (v4)
Date: Thu, 25 Feb 2021 15:16:12 -0500
Message-Id: <20210225201614.896990-3-alexander.deucher@amd.com>
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
 15.20.3912.9 via Frontend Transport; Thu, 25 Feb 2021 20:16:30 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 6e6cc458-7a20-473a-9701-08d8d9ca3d63
X-MS-TrafficTypeDiagnostic: MN2PR12MB3872:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB38724F2DC12538707FE242ECF79E9@MN2PR12MB3872.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uk55sOb1MJ8HC4M27IFFzRD8PLFjRsQ2Tirxp6trEHhT4OHy0JduQRIQZThxGszWgzoKT9Y8U/b/ehhlx21/cMnB1vMcr8DhtMQhLelYLuQXQJ0UigRXJxoEVKgCjnub//Gq3fyBdFRI0Lkh/2fVnNY7JCaQNPh/hMnAZ5v3nLenrVicmWA9F5JEXtCHw95dSIy7lgsbeBrXhmvuFxOTdOACuDVkyrXi990RyiQxiH1oNfI1NMv0BIwbmuWYpmFW5cAMO0PPiyoGe9Hibl9XvC+q4AgnASUnasldiErZ8C472AC9wKYfPgaAJlwW699xQ4eltRu2TiyHlAIQPygg3m1/81lljtKp96K8m6OlkMmfIKciFIx/S14DBdR+R7VgyQGAwDTXRb3Hxg0v6zaDJX01uq95T+WZMCusWJRtZVwNnN3yR2w+Re51Xszk1ixvIh6WMDNimqZ8hy86IOaBTApH6PP2zZgrfCYBnNbfef4fFtXSfaPt5GIjbDcmTqQoDSj2TKvuLAeS4rPNo3izpPYV7QCXG8DsyutZoDr+CM6+mXZBeSXGX8XfsQf2cwIw
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4488.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(39860400002)(376002)(136003)(366004)(346002)(66556008)(316002)(66476007)(26005)(54906003)(8676002)(1076003)(2616005)(7696005)(52116002)(956004)(4326008)(186003)(86362001)(6916009)(8936002)(36756003)(16526019)(6666004)(83380400001)(5660300002)(966005)(6486002)(478600001)(66946007)(2906002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?ylZmm1mlK3A5Pl9VCQC1AbK6u9DGnFzaIU99CcsTijhshRpf43laPVO4sWdg?=
 =?us-ascii?Q?tSG77qVBdvis5/JGEYhy78izyWbYk+fnPoqrMbN7xiWhgZxeAR6ZnHmvO2HH?=
 =?us-ascii?Q?JG+7qkI4DEvEvNC5ONpW/WwTIpMd1CnQZ+5B3wrX80nek7IFzp8YdU83/hI2?=
 =?us-ascii?Q?GrduwWfh6HmdDOXBoasDfqudFNA+xLYnPd+F7BTBN5JF7s7suLjDqDfsQSiE?=
 =?us-ascii?Q?PprmoiCmnbeOHdhO8/LbYVBj0HyNV8bfKXY+Wa0gKZfRo9UDM7E/FVFeCXgW?=
 =?us-ascii?Q?1tID5P/uQwaZRJdjun4G2qXReCUesTnKc5xZU/ZsNOuubVkGK24UZKIg/t7N?=
 =?us-ascii?Q?lXITxwf+P81fJA9gLmeToORV8mfn33VHhVxlFumi/ix1qiFzvGHFgShH4KAL?=
 =?us-ascii?Q?Kvtr0DIit0P1tr2W+eI20BMwOxXpscQzLYU40ZwDN3Qtk/KhwVZqhCRy2/I8?=
 =?us-ascii?Q?lGrH3HwTvfeBXFwL5nuuugxRZnayzyb36cUUDsC96cU49T4nyhvRIi50TlHh?=
 =?us-ascii?Q?A/PXJd59nsPP0vwKCZqXsZ5NXQaXXkzxTCjiH9uSmb/1RuA4mQsXFK4HoQQz?=
 =?us-ascii?Q?msYDBJtSIP9H3x4mbBplgxYbNxvu80C9OCOghs7y2BJ8DjN29GtmNRQSVCGB?=
 =?us-ascii?Q?b40432qxvTG36D/3o4c9JxQWyDoXpfGazb0cqnTPYf72uA9IcOfT0TNlaRlo?=
 =?us-ascii?Q?pGTTROphrMFfSUoIv2xnBZo47AfUrGI9FfUREoS90fBbc+iL/ckA+b27FY40?=
 =?us-ascii?Q?NFcLQ3yTbAcDi1A3u4F2jsG20FI5PuAxjCL7TZ6Ts64qJV+zYqlvY+X0dlbA?=
 =?us-ascii?Q?YMTLs9fwEjDhO4VucD29c6V4pPsNe9aurVAE6ytdE+xm0eVezcyiF4iq12aK?=
 =?us-ascii?Q?m9H4nHW7YHghMGexxL3SYaF5R5v30gQixxhxn1f+Q4xI6BK+WPtICs9KEv7u?=
 =?us-ascii?Q?nWvldUt38q71fv93m8DOM4SclakSpNixPor4ldASfsfaY9imGVekMwLV7NEG?=
 =?us-ascii?Q?pz9I3aqgfJXbyT2tNpW9URb1YrmGlb54yoNZGgKJTQIFDVYiB0UBcyx34ZmY?=
 =?us-ascii?Q?QzKfQtzvfEHqcwVaDG1Mu9ZVZ96Op+TfEXAkGRm+8KxNWkfbfUMjD42j9hg+?=
 =?us-ascii?Q?zwEqzdaV4Z3M1mSu3BKmIdZywbC4ghr5qciGviSC9+2L7dXF/PzGhmDXZ4yB?=
 =?us-ascii?Q?how/rljPMjB3uNfO6x35AK7TA6JLpxi9dVq0wvI+8f86SNWRtVL+ATLMRrau?=
 =?us-ascii?Q?bBemCvNQyGGnOWSMr9gKwvj4FhV4JvpAWceT+N377cOXFr5yZp0Um1ys0sW2?=
 =?us-ascii?Q?SFUC2MgM0806J0DBl+HqopL8?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e6cc458-7a20-473a-9701-08d8d9ca3d63
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4488.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2021 20:16:31.1524 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: z/YyomlCY0QEWOGutmYZFYKDO/kVva22H/X1r4ghD5UnYjun3Fl6jQok9xQjNLDj/OAS4gttyMPrpufroX7UIg==
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Leo Liu <leo.liu@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

We currently hardcode these in mesa, but querying them from
the kernel makes more sense since there may be board specific
limitations that the kernel driver is better suited to
determining.

Userpace patches that use this interface:
https://gitlab.freedesktop.org/leoliu/drm/-/commits/info_video_caps
https://gitlab.freedesktop.org/leoliu/mesa/-/commits/info_video_caps

v2: reorder the codecs to better align with mesa
v3: add max_pixels_per_frame to handle the portrait case, squash in
    memory leak fix
v4: drop extra break

Reviewed-by: Leo Liu <leo.liu@amd.com> (v2)
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c | 57 +++++++++++++++++++++++++
 include/uapi/drm/amdgpu_drm.h           | 34 +++++++++++++++
 2 files changed, 91 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
index cf81ade31703..9f35e8a6c421 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
@@ -982,6 +982,63 @@ int amdgpu_info_ioctl(struct drm_device *dev, void *data, struct drm_file *filp)
 				min_t(u64, size, sizeof(ras_mask))) ?
 			-EFAULT : 0;
 	}
+	case AMDGPU_INFO_VIDEO_CAPS: {
+		const struct amdgpu_video_codecs *codecs;
+		struct drm_amdgpu_info_video_caps *caps;
+		int r;
+
+		switch (info->video_cap.type) {
+		case AMDGPU_INFO_VIDEO_CAPS_DECODE:
+			r = amdgpu_asic_query_video_codecs(adev, false, &codecs);
+			if (r)
+				return -EINVAL;
+			break;
+		case AMDGPU_INFO_VIDEO_CAPS_ENCODE:
+			r = amdgpu_asic_query_video_codecs(adev, true, &codecs);
+			if (r)
+				return -EINVAL;
+			break;
+		default:
+			DRM_DEBUG_KMS("Invalid request %d\n",
+				      info->video_cap.type);
+			return -EINVAL;
+		}
+
+		caps = kzalloc(sizeof(*caps), GFP_KERNEL);
+		if (!caps)
+			return -ENOMEM;
+
+		for (i = 0; i < codecs->codec_count; i++) {
+			int idx = codecs->codec_array[i].codec_type;
+
+			switch (idx) {
+			case AMDGPU_VIDEO_CODEC_TYPE_MPEG2:
+			case AMDGPU_VIDEO_CODEC_TYPE_MPEG4:
+			case AMDGPU_VIDEO_CODEC_TYPE_MPEG4_AVC:
+			case AMDGPU_VIDEO_CODEC_TYPE_VC1:
+			case AMDGPU_VIDEO_CODEC_TYPE_HEVC:
+			case AMDGPU_VIDEO_CODEC_TYPE_JPEG:
+			case AMDGPU_VIDEO_CODEC_TYPE_VP9:
+			case AMDGPU_VIDEO_CODEC_TYPE_AV1:
+				caps->codec_info[idx].valid = 1;
+				caps->codec_info[idx].max_width =
+					codecs->codec_array[i].max_width;
+				caps->codec_info[idx].max_height =
+					codecs->codec_array[i].max_height;
+				caps->codec_info[idx].max_pixels_per_frame =
+					codecs->codec_array[i].max_pixels_per_frame;
+				caps->codec_info[idx].max_level =
+					codecs->codec_array[i].max_level;
+				break;
+			default:
+				break;
+			}
+		}
+		r = copy_to_user(out, caps,
+				 min((size_t)size, sizeof(*caps))) ? -EFAULT : 0;
+		kfree(caps);
+		return r;
+	}
 	default:
 		DRM_DEBUG_KMS("Invalid request %d\n", info->query);
 		return -EINVAL;
diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.h
index 7fb9c09ee93f..728566542f8a 100644
--- a/include/uapi/drm/amdgpu_drm.h
+++ b/include/uapi/drm/amdgpu_drm.h
@@ -782,6 +782,12 @@ struct drm_amdgpu_cs_chunk_data {
 #define AMDGPU_INFO_VRAM_LOST_COUNTER		0x1F
 /* query ras mask of enabled features*/
 #define AMDGPU_INFO_RAS_ENABLED_FEATURES	0x20
+/* query video encode/decode caps */
+#define AMDGPU_INFO_VIDEO_CAPS			0x21
+	/* Subquery id: Decode */
+	#define AMDGPU_INFO_VIDEO_CAPS_DECODE		0
+	/* Subquery id: Encode */
+	#define AMDGPU_INFO_VIDEO_CAPS_ENCODE		1
 
 /* RAS MASK: UMC (VRAM) */
 #define AMDGPU_INFO_RAS_ENABLED_UMC			(1 << 0)
@@ -878,6 +884,10 @@ struct drm_amdgpu_info {
 		struct {
 			__u32 type;
 		} sensor_info;
+
+		struct {
+			__u32 type;
+		} video_cap;
 	};
 };
 
@@ -1074,6 +1084,30 @@ struct drm_amdgpu_info_vce_clock_table {
 	__u32 pad;
 };
 
+/* query video encode/decode caps */
+#define AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_MPEG2			0
+#define AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_MPEG4			1
+#define AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_VC1			2
+#define AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_MPEG4_AVC		3
+#define AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_HEVC			4
+#define AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_JPEG			5
+#define AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_VP9			6
+#define AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_AV1			7
+#define AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_COUNT			8
+
+struct drm_amdgpu_info_video_codec_info {
+	__u32 valid;
+	__u32 max_width;
+	__u32 max_height;
+	__u32 max_pixels_per_frame;
+	__u32 max_level;
+	__u32 pad;
+};
+
+struct drm_amdgpu_info_video_caps {
+	struct drm_amdgpu_info_video_codec_info codec_info[AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_COUNT];
+};
+
 /*
  * Supported GPU families
  */
-- 
2.29.2

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
