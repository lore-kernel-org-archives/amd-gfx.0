Return-Path: <SRS0=Rd3N=H3=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FCF3C433E0
	for <amd-gfx@archiver.kernel.org>; Thu, 25 Feb 2021 20:16:40 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CCAD464F36
	for <amd-gfx@archiver.kernel.org>; Thu, 25 Feb 2021 20:16:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CCAD464F36
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6CC206E1AA;
	Thu, 25 Feb 2021 20:16:39 +0000 (UTC)
Received: from NAM02-CY1-obe.outbound.protection.outlook.com
 (mail-eopbgr760044.outbound.protection.outlook.com [40.107.76.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8CF826E140
 for <amd-gfx@lists.freedesktop.org>; Thu, 25 Feb 2021 20:16:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ib88q4LUBPAeRJMY89Ns+5a5eD5RqtORTBXTQpNYzCWNPVglOZfuc6EnzgfNRD/SjUO0prQOFjck6heh5axHLyTnBc54IZr9wVxfLusFjg+/JWOzwJnYVrunUuwyjiK2e5dg9/kAVMTbq+PQ6JBIGTimbXFSr5EK2uy2r4hW/CDtXnYSwre5erbGbf/tECt7tz2LCJpy0HcQ1MKGdSnGuHArnfl+zl3A3rFNeDzGLkL+7scn6cWQMyrvEo+ibKMmC5GMY8RBr2RKV282FRuVd3yVBJg0/i2s4p1hHDqJsFbMrj6C3EOfvHgjM4+DrGVEAcFxSXULUvxMhxtk+IIR5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=58mPtG7+9on+00bOqO3Hu6no4tqAt9isOfHWAD/E/sI=;
 b=Ucea7zpgpmFzbWnmv5cGrtYcudqJTzsouxoPzU5s7WGdjUIS94W+QopxoPl91wgH/VCT/1dczlL2+obakBZED2RsMZ1SQ5j09ZMxLqst+hB1Nose7LJRM8lu2677CA/cBMBg57hiNMBdKAW+Jfhyfrno/XTiYxajN+fetZKX8rPMC3AulisQiTjGzT5nxSqW/sNOA5EZsXWysSnRpE9oL4H6q/EpygVXr9bfWb9mJWLSWT0glUkuy5StLebBLGcPT/ccTUvrQ3wBQfrx/fya7seqyQgrmBqZLbko7x2MRk0Qf138LtBHSjW6d1WAi++DG55Ip7P07XE0F6a12spVrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=58mPtG7+9on+00bOqO3Hu6no4tqAt9isOfHWAD/E/sI=;
 b=3vSpdRt99DbIZ4ujlcPYfBecrkfSq5ERBZ1RmXvhNFo8aZ0AbuisdbJCMUecZPGEnDoyGRNOHoPPocKlTlkfXZZq859SS5PQsQU/BiO/fuwC3e79ug9oq9QRgSj4FsPzbMTr5qo6N6Qag7rUxjJZ5c3K0E8Eb0uGVAjNkWKs4v4=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 by MN2PR12MB3872.namprd12.prod.outlook.com (2603:10b6:208:168::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.19; Thu, 25 Feb
 2021 20:16:30 +0000
Received: from MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::b0c4:9a8b:4c4c:76af]) by MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::b0c4:9a8b:4c4c:76af%7]) with mapi id 15.20.3890.020; Thu, 25 Feb 2021
 20:16:30 +0000
From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 2/5] drm/amdgpu: add video decode/encode cap tables and asic
 callbacks (v3)
Date: Thu, 25 Feb 2021 15:16:11 -0500
Message-Id: <20210225201614.896990-2-alexander.deucher@amd.com>
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
 15.20.3912.9 via Frontend Transport; Thu, 25 Feb 2021 20:16:29 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: acc50b19-ecab-43d5-07de-08d8d9ca3cc1
X-MS-TrafficTypeDiagnostic: MN2PR12MB3872:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB3872DB39D004ADEA2773A16CF79E9@MN2PR12MB3872.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: abOkdPXKLH6JsBetj9+2jNsmG7YG7ZRoKq8oExYTEZVNLOliLeIy33mIwmZlOcoegXJ+o2tXsuO7PhnhMpBVDkn3EVbqGen6PwZsVVC/f/4o8POOOF2nBD0dDH2NN8tjkv17mC/NL/olkv6x2ChHEGPionnjoikPJO8JDz3A7yiWgybo9qJ7sOOLs0bHVmhqVqJ5mY4StvIPuVv84L4bJVeMPBtR8J1Ri62OPm2tE76AuHPzDmG/FlboBt43pwsuSdKXENhksUfjJiUjeVRdfkTQwTxSnm0rngnd1byfUfapR7vH2NFHZXhbGPOOZFd5cwTjvVWxYEa0mNNAhrHd9s9sfkLl1fT0smJXpaI8NjJCHcqbemAKUFi8K+TZL4V0Yb2lEfrn693UyGD+yyE+cGQhNFtj1e8ShEeU1aCv1SonO8LRXspY0a9aMSR2z9Taf28i1FsIf4Ifae/byck3Hm/Bqg++C1y/ubKB986LyTqdLXZIt8G7CUjTjDgD9J4SXlPwQJkpn/rkzJbveji7zOaaERYubnzXlpAjHALU+jaQmuBeoX4eum8GGuawnO25
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4488.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(39860400002)(376002)(136003)(366004)(346002)(66556008)(316002)(66476007)(26005)(54906003)(8676002)(30864003)(1076003)(2616005)(7696005)(52116002)(956004)(4326008)(186003)(86362001)(6916009)(8936002)(36756003)(16526019)(6666004)(83380400001)(5660300002)(6486002)(478600001)(66946007)(2906002)(21314003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?ZnGpXswKzf4dP8UwMm4iNAE/w0Rwl7BpeNRU3titwsrvlLNobSLZW68qBS2I?=
 =?us-ascii?Q?diEpffWeTysokBZOw/rUlpIxUC/vpULQl4iin/Ygv9b1JCY/Zi8EHwk2VvLH?=
 =?us-ascii?Q?oq7nfzBe8lFZ4vPeyBuAURuFfle2ZzMuh5iLcT8+at3nzEr4c6ZEWIbW8kWV?=
 =?us-ascii?Q?Y7I4bUGbAYnyNsN3606uWZeqyzpjLttCttm1NPi03nhqVZInSmGuQEAQRckG?=
 =?us-ascii?Q?zhbA669vNpDQEUz3odUEc7boXBEG+43FwxjKu1fZ1vjZxjFKQW1SOkw2mD5D?=
 =?us-ascii?Q?tEt6g06vV+lHKnpXv/Z68RFI8uxIibALQJ+YDXrU6NXWttTd/Jw711Edo7lk?=
 =?us-ascii?Q?EiMqJfxg8ZXlsXdWKb3XvqbyLAj9o+081ZOeIAmVC/XLVRJevETOUIcPRz2W?=
 =?us-ascii?Q?PKHSIDW/7Vz0/ChGSHxh6eyTNzDuMUJDxxQe/Os507pp011a0VgPdOaCSEQK?=
 =?us-ascii?Q?cKcTnwLey8lC7BF5XflBhoxz+Aofa4fzSOhvP3ksoCZh/wJwdxdDlmgI356J?=
 =?us-ascii?Q?ny5pLPhJnfnqj4BNbUWsrME0DlPUdL7NrL2PAJHBJZVLQZovgHW4Devuqjyw?=
 =?us-ascii?Q?hSxRIEoMH2978Zq++wwlTuxpH4eajixa9mlZ+j4WAetPKPFMN4i+gu06L1bq?=
 =?us-ascii?Q?pEYoZK5IgT9QY8Xxe1Rsh1kz1mnhSXU7u9pJCB4xiuj2e4qQ+jdN4ViXd6ld?=
 =?us-ascii?Q?ulqQDn7FhMeTceA5lQ5FcFAlwE2JyHj9kDUwuLWloIJnYveFOa4l7gko5GoU?=
 =?us-ascii?Q?I1r0/lAAAMNyLd28Glv2BSnwpBgHgezOBcR32kYPXCijfY4MRxAhfAVbruWV?=
 =?us-ascii?Q?KPg2dB38CDNnkFvmFiBheGaKlN7/ArH0WLuEFhOvRFmJcWg72oXWW78ObrK+?=
 =?us-ascii?Q?clwhNas53UzUgtTMXd8PcIlF6bFhpEsKdTL/tGNcSiKWFZKf3AXRjBah0cY4?=
 =?us-ascii?Q?RWZCbf87prTXvG97M68VNRdtdiOrFYTkl8EMUyw8mFqir2SzL2pzlMkBt0q+?=
 =?us-ascii?Q?uSjVMLorBhbC60M41iEnr5nA90hoyj2zIJx3HyiQAqjxKxHU6kcck23rGbYR?=
 =?us-ascii?Q?PQbsSHF3XcHdBsrc9ssfH/JeKYSVilaYf7yrf5GLDLUBtVTwLhXBAmsf/FsG?=
 =?us-ascii?Q?VBGdhtGThKwePO6dVEp8pPU8Ertalz3OSEDyG5FVIb35tAD42K5ckDJbWffG?=
 =?us-ascii?Q?Q4WJySCzNkRivPAZ4a3GxSbL0tzDtmTuMSMz+cv+uRckIyY9OhOMlWHqzA0Y?=
 =?us-ascii?Q?qGbCl6IEGBL1HI+fA5nEOLunUZPPzht2Eof0eoUsTPRdUIVrOh6W1jjdK3/7?=
 =?us-ascii?Q?bS12pOYM/QyavX+BX0IItqAm?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: acc50b19-ecab-43d5-07de-08d8d9ca3cc1
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4488.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2021 20:16:30.2384 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: x6ZzyEV4SYEQx/to6L5vaDssGIxLFhylkNUqLTGcwzeQBDc/phfXrkrUeD49DK1W1RgdIfIeWDLYxQHWIwYfVw==
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

For each asic family.  Will be used to populate tables
for the new INFO ioctl query.

v2: add max_pixels_per_frame to handle the portrait case
v3: fix copy paste typos

Reviewed-by: Leo Liu <leo.liu@amd.com> (v1)
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/cik.c   |  75 ++++++++++
 drivers/gpu/drm/amd/amdgpu/nv.c    | 179 ++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/si.c    | 109 ++++++++++++++
 drivers/gpu/drm/amd/amdgpu/soc15.c | 230 +++++++++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/vi.c    | 188 +++++++++++++++++++++++
 5 files changed, 781 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/cik.c b/drivers/gpu/drm/amd/amdgpu/cik.c
index 4d6832cc7fb0..72abfad2fd67 100644
--- a/drivers/gpu/drm/amd/amdgpu/cik.c
+++ b/drivers/gpu/drm/amd/amdgpu/cik.c
@@ -70,6 +70,80 @@
 #include "amdgpu_amdkfd.h"
 #include "dce_virtual.h"
 
+static const struct amdgpu_video_codec_info cik_video_codecs_encode_array[] =
+{
+	{
+		.codec_type = AMDGPU_VIDEO_CODEC_TYPE_MPEG4_AVC,
+		.max_width = 2048,
+		.max_height = 1152,
+		.max_pixels_per_frame = 2048 * 1152,
+		.max_level = 0,
+	},
+};
+
+static const struct amdgpu_video_codecs cik_video_codecs_encode =
+{
+	.codec_count = ARRAY_SIZE(cik_video_codecs_encode_array),
+	.codec_array = cik_video_codecs_encode_array,
+};
+
+static const struct amdgpu_video_codec_info cik_video_codecs_decode_array[] =
+{
+	{
+		.codec_type = AMDGPU_VIDEO_CODEC_TYPE_MPEG2,
+		.max_width = 2048,
+		.max_height = 1152,
+		.max_pixels_per_frame = 2048 * 1152,
+		.max_level = 3,
+	},
+	{
+		.codec_type = AMDGPU_VIDEO_CODEC_TYPE_MPEG4,
+		.max_width = 2048,
+		.max_height = 1152,
+		.max_pixels_per_frame = 2048 * 1152,
+		.max_level = 5,
+	},
+	{
+		.codec_type = AMDGPU_VIDEO_CODEC_TYPE_MPEG4_AVC,
+		.max_width = 2048,
+		.max_height = 1152,
+		.max_pixels_per_frame = 2048 * 1152,
+		.max_level = 41,
+	},
+	{
+		.codec_type = AMDGPU_VIDEO_CODEC_TYPE_VC1,
+		.max_width = 2048,
+		.max_height = 1152,
+		.max_pixels_per_frame = 2048 * 1152,
+		.max_level = 4,
+	},
+};
+
+static const struct amdgpu_video_codecs cik_video_codecs_decode =
+{
+	.codec_count = ARRAY_SIZE(cik_video_codecs_decode_array),
+	.codec_array = cik_video_codecs_decode_array,
+};
+
+static int cik_query_video_codecs(struct amdgpu_device *adev, bool encode,
+				  const struct amdgpu_video_codecs **codecs)
+{
+	switch (adev->asic_type) {
+	case CHIP_BONAIRE:
+	case CHIP_HAWAII:
+	case CHIP_KAVERI:
+	case CHIP_KABINI:
+	case CHIP_MULLINS:
+		if (encode)
+			*codecs = &cik_video_codecs_encode;
+		else
+			*codecs = &cik_video_codecs_decode;
+		return 0;
+	default:
+		return -EINVAL;
+	}
+}
+
 /*
  * Indirect registers accessor
  */
@@ -1933,6 +2007,7 @@ static const struct amdgpu_asic_funcs cik_asic_funcs =
 	.get_pcie_replay_count = &cik_get_pcie_replay_count,
 	.supports_baco = &cik_asic_supports_baco,
 	.pre_asic_init = &cik_pre_asic_init,
+	.query_video_codecs = &cik_query_video_codecs,
 };
 
 static int cik_common_early_init(void *handle)
diff --git a/drivers/gpu/drm/amd/amdgpu/nv.c b/drivers/gpu/drm/amd/amdgpu/nv.c
index 160fa5f59805..c7ea779e7d6e 100644
--- a/drivers/gpu/drm/amd/amdgpu/nv.c
+++ b/drivers/gpu/drm/amd/amdgpu/nv.c
@@ -65,6 +65,184 @@
 
 static const struct amd_ip_funcs nv_common_ip_funcs;
 
+/* Navi */
+static const struct amdgpu_video_codec_info nv_video_codecs_encode_array[] =
+{
+	{
+		.codec_type = AMDGPU_VIDEO_CODEC_TYPE_MPEG4_AVC,
+		.max_width = 4096,
+		.max_height = 2304,
+		.max_pixels_per_frame = 4096 * 2304,
+		.max_level = 0,
+	},
+	{
+		.codec_type = AMDGPU_VIDEO_CODEC_TYPE_HEVC,
+		.max_width = 4096,
+		.max_height = 2304,
+		.max_pixels_per_frame = 4096 * 2304,
+		.max_level = 0,
+	},
+};
+
+static const struct amdgpu_video_codecs nv_video_codecs_encode =
+{
+	.codec_count = ARRAY_SIZE(nv_video_codecs_encode_array),
+	.codec_array = nv_video_codecs_encode_array,
+};
+
+/* Navi1x */
+static const struct amdgpu_video_codec_info nv_video_codecs_decode_array[] =
+{
+	{
+		.codec_type = AMDGPU_VIDEO_CODEC_TYPE_MPEG2,
+		.max_width = 4096,
+		.max_height = 4096,
+		.max_pixels_per_frame = 4096 * 4096,
+		.max_level = 3,
+	},
+	{
+		.codec_type = AMDGPU_VIDEO_CODEC_TYPE_MPEG4,
+		.max_width = 4096,
+		.max_height = 4096,
+		.max_pixels_per_frame = 4096 * 4096,
+		.max_level = 5,
+	},
+	{
+		.codec_type = AMDGPU_VIDEO_CODEC_TYPE_MPEG4_AVC,
+		.max_width = 4096,
+		.max_height = 4096,
+		.max_pixels_per_frame = 4096 * 4096,
+		.max_level = 52,
+	},
+	{
+		.codec_type = AMDGPU_VIDEO_CODEC_TYPE_VC1,
+		.max_width = 4096,
+		.max_height = 4096,
+		.max_pixels_per_frame = 4096 * 4096,
+		.max_level = 4,
+	},
+	{
+		.codec_type = AMDGPU_VIDEO_CODEC_TYPE_HEVC,
+		.max_width = 8192,
+		.max_height = 4352,
+		.max_pixels_per_frame = 8192 * 4352,
+		.max_level = 186,
+	},
+	{
+		.codec_type = AMDGPU_VIDEO_CODEC_TYPE_JPEG,
+		.max_width = 4096,
+		.max_height = 4096,
+		.max_pixels_per_frame = 4096 * 4096,
+		.max_level = 0,
+	},
+	{
+		.codec_type = AMDGPU_VIDEO_CODEC_TYPE_VP9,
+		.max_width = 8192,
+		.max_height = 4352,
+		.max_pixels_per_frame = 8192 * 4352,
+		.max_level = 0,
+	},
+};
+
+static const struct amdgpu_video_codecs nv_video_codecs_decode =
+{
+	.codec_count = ARRAY_SIZE(nv_video_codecs_decode_array),
+	.codec_array = nv_video_codecs_decode_array,
+};
+
+/* Sienna Cichlid */
+static const struct amdgpu_video_codec_info sc_video_codecs_decode_array[] =
+{
+	{
+		.codec_type = AMDGPU_VIDEO_CODEC_TYPE_MPEG2,
+		.max_width = 4096,
+		.max_height = 4096,
+		.max_pixels_per_frame = 4096 * 4096,
+		.max_level = 3,
+	},
+	{
+		.codec_type = AMDGPU_VIDEO_CODEC_TYPE_MPEG4,
+		.max_width = 4096,
+		.max_height = 4096,
+		.max_pixels_per_frame = 4096 * 4096,
+		.max_level = 5,
+	},
+	{
+		.codec_type = AMDGPU_VIDEO_CODEC_TYPE_MPEG4_AVC,
+		.max_width = 4096,
+		.max_height = 4096,
+		.max_pixels_per_frame = 4096 * 4096,
+		.max_level = 52,
+	},
+	{
+		.codec_type = AMDGPU_VIDEO_CODEC_TYPE_VC1,
+		.max_width = 4096,
+		.max_height = 4096,
+		.max_pixels_per_frame = 4096 * 4096,
+		.max_level = 4,
+	},
+	{
+		.codec_type = AMDGPU_VIDEO_CODEC_TYPE_HEVC,
+		.max_width = 8192,
+		.max_height = 4352,
+		.max_pixels_per_frame = 8192 * 4352,
+		.max_level = 186,
+	},
+	{
+		.codec_type = AMDGPU_VIDEO_CODEC_TYPE_JPEG,
+		.max_width = 4096,
+		.max_height = 4096,
+		.max_pixels_per_frame = 4096 * 4096,
+		.max_level = 0,
+	},
+	{
+		.codec_type = AMDGPU_VIDEO_CODEC_TYPE_VP9,
+		.max_width = 8192,
+		.max_height = 4352,
+		.max_pixels_per_frame = 8192 * 4352,
+		.max_level = 0,
+	},
+	{
+		.codec_type = AMDGPU_VIDEO_CODEC_TYPE_AV1,
+		.max_width = 8192,
+		.max_height = 4352,
+		.max_pixels_per_frame = 8192 * 4352,
+		.max_level = 0,
+	},
+};
+
+static const struct amdgpu_video_codecs sc_video_codecs_decode =
+{
+	.codec_count = ARRAY_SIZE(sc_video_codecs_decode_array),
+	.codec_array = sc_video_codecs_decode_array,
+};
+
+static int nv_query_video_codecs(struct amdgpu_device *adev, bool encode,
+				 const struct amdgpu_video_codecs **codecs)
+{
+	switch (adev->asic_type) {
+	case CHIP_SIENNA_CICHLID:
+	case CHIP_NAVY_FLOUNDER:
+	case CHIP_DIMGREY_CAVEFISH:
+	case CHIP_VANGOGH:
+		if (encode)
+			*codecs = &nv_video_codecs_encode;
+		else
+			*codecs = &sc_video_codecs_decode;
+		return 0;
+	case CHIP_NAVI10:
+	case CHIP_NAVI14:
+	case CHIP_NAVI12:
+		if (encode)
+			*codecs = &nv_video_codecs_encode;
+		else
+			*codecs = &nv_video_codecs_decode;
+		return 0;
+	default:
+		return -EINVAL;
+	}
+}
+
 /*
  * Indirect registers accessor
  */
@@ -845,6 +1023,7 @@ static const struct amdgpu_asic_funcs nv_asic_funcs =
 	.supports_baco = &nv_asic_supports_baco,
 	.pre_asic_init = &nv_pre_asic_init,
 	.update_umd_stable_pstate = &nv_update_umd_stable_pstate,
+	.query_video_codecs = &nv_query_video_codecs,
 };
 
 static int nv_common_early_init(void *handle)
diff --git a/drivers/gpu/drm/amd/amdgpu/si.c b/drivers/gpu/drm/amd/amdgpu/si.c
index 6b5cf7882a12..489dbcc7040d 100644
--- a/drivers/gpu/drm/amd/amdgpu/si.c
+++ b/drivers/gpu/drm/amd/amdgpu/si.c
@@ -905,6 +905,114 @@ static const u32 hainan_mgcg_cgcg_init[] =
 	0x3630, 0xfffffff0, 0x00000100,
 };
 
+/* XXX: update when we support VCE */
+#if 0
+/* tahiti, pitcarin, verde */
+static const struct amdgpu_video_codec_info tahiti_video_codecs_encode_array[] =
+{
+	{
+		.codec_type = AMDGPU_VIDEO_CODEC_TYPE_MPEG4_AVC,
+		.max_width = 2048,
+		.max_height = 1152,
+		.max_pixels_per_frame = 2048 * 1152,
+		.max_level = 0,
+	},
+};
+
+static const struct amdgpu_video_codecs tahiti_video_codecs_encode =
+{
+	.codec_count = ARRAY_SIZE(tahiti_video_codecs_encode_array),
+	.codec_array = tahiti_video_codecs_encode_array,
+};
+#else
+static const struct amdgpu_video_codecs tahiti_video_codecs_encode =
+{
+	.codec_count = 0,
+	.codec_array = NULL,
+};
+#endif
+/* oland and hainan don't support encode */
+static const struct amdgpu_video_codecs hainan_video_codecs_encode =
+{
+	.codec_count = 0,
+	.codec_array = NULL,
+};
+
+/* tahiti, pitcarin, verde, oland */
+static const struct amdgpu_video_codec_info tahiti_video_codecs_decode_array[] =
+{
+	{
+		.codec_type = AMDGPU_VIDEO_CODEC_TYPE_MPEG2,
+		.max_width = 2048,
+		.max_height = 1152,
+		.max_pixels_per_frame = 2048 * 1152,
+		.max_level = 3,
+	},
+	{
+		.codec_type = AMDGPU_VIDEO_CODEC_TYPE_MPEG4,
+		.max_width = 2048,
+		.max_height = 1152,
+		.max_pixels_per_frame = 2048 * 1152,
+		.max_level = 5,
+	},
+	{
+		.codec_type = AMDGPU_VIDEO_CODEC_TYPE_MPEG4_AVC,
+		.max_width = 2048,
+		.max_height = 1152,
+		.max_pixels_per_frame = 2048 * 1152,
+		.max_level = 41,
+	},
+	{
+		.codec_type = AMDGPU_VIDEO_CODEC_TYPE_VC1,
+		.max_width = 2048,
+		.max_height = 1152,
+		.max_pixels_per_frame = 2048 * 1152,
+		.max_level = 4,
+	},
+};
+
+static const struct amdgpu_video_codecs tahiti_video_codecs_decode =
+{
+	.codec_count = ARRAY_SIZE(tahiti_video_codecs_decode_array),
+	.codec_array = tahiti_video_codecs_decode_array,
+};
+
+/* hainan doesn't support decode */
+static const struct amdgpu_video_codecs hainan_video_codecs_decode =
+{
+	.codec_count = 0,
+	.codec_array = NULL,
+};
+
+static int si_query_video_codecs(struct amdgpu_device *adev, bool encode,
+				 const struct amdgpu_video_codecs **codecs)
+{
+	switch (adev->asic_type) {
+	case CHIP_VERDE:
+	case CHIP_TAHITI:
+	case CHIP_PITCAIRN:
+		if (encode)
+			*codecs = &tahiti_video_codecs_encode;
+		else
+			*codecs = &tahiti_video_codecs_decode;
+		return 0;
+	case CHIP_OLAND:
+		if (encode)
+			*codecs = &hainan_video_codecs_encode;
+		else
+			*codecs = &tahiti_video_codecs_decode;
+		return 0;
+	case CHIP_HAINAN:
+		if (encode)
+			*codecs = &hainan_video_codecs_encode;
+		else
+			*codecs = &hainan_video_codecs_decode;
+		return 0;
+	default:
+		return -EINVAL;
+	}
+}
+
 static u32 si_pcie_rreg(struct amdgpu_device *adev, u32 reg)
 {
 	unsigned long flags;
@@ -1903,6 +2011,7 @@ static const struct amdgpu_asic_funcs si_asic_funcs =
 	.get_pcie_replay_count = &si_get_pcie_replay_count,
 	.supports_baco = &si_asic_supports_baco,
 	.pre_asic_init = &si_pre_asic_init,
+	.query_video_codecs = &si_query_video_codecs,
 };
 
 static uint32_t si_get_rev_id(struct amdgpu_device *adev)
diff --git a/drivers/gpu/drm/amd/amdgpu/soc15.c b/drivers/gpu/drm/amd/amdgpu/soc15.c
index 1221aa6b40a9..f4735d83126b 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc15.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc15.c
@@ -83,6 +83,234 @@
 #define mmMP0_MISC_LIGHT_SLEEP_CTRL                                                             0x01ba
 #define mmMP0_MISC_LIGHT_SLEEP_CTRL_BASE_IDX                                                    0
 
+/* Vega, Raven, Arcturus */
+static const struct amdgpu_video_codec_info vega_video_codecs_encode_array[] =
+{
+	{
+		.codec_type = AMDGPU_VIDEO_CODEC_TYPE_MPEG4_AVC,
+		.max_width = 4096,
+		.max_height = 2304,
+		.max_pixels_per_frame = 4096 * 2304,
+		.max_level = 0,
+	},
+	{
+		.codec_type = AMDGPU_VIDEO_CODEC_TYPE_HEVC,
+		.max_width = 4096,
+		.max_height = 2304,
+		.max_pixels_per_frame = 4096 * 2304,
+		.max_level = 0,
+	},
+};
+
+static const struct amdgpu_video_codecs vega_video_codecs_encode =
+{
+	.codec_count = ARRAY_SIZE(vega_video_codecs_encode_array),
+	.codec_array = vega_video_codecs_encode_array,
+};
+
+/* Vega */
+static const struct amdgpu_video_codec_info vega_video_codecs_decode_array[] =
+{
+	{
+		.codec_type = AMDGPU_VIDEO_CODEC_TYPE_MPEG2,
+		.max_width = 4096,
+		.max_height = 4096,
+		.max_pixels_per_frame = 4096 * 4096,
+		.max_level = 3,
+	},
+	{
+		.codec_type = AMDGPU_VIDEO_CODEC_TYPE_MPEG4,
+		.max_width = 4096,
+		.max_height = 4096,
+		.max_pixels_per_frame = 4096 * 4096,
+		.max_level = 5,
+	},
+	{
+		.codec_type = AMDGPU_VIDEO_CODEC_TYPE_MPEG4_AVC,
+		.max_width = 4096,
+		.max_height = 4096,
+		.max_pixels_per_frame = 4096 * 4096,
+		.max_level = 52,
+	},
+	{
+		.codec_type = AMDGPU_VIDEO_CODEC_TYPE_VC1,
+		.max_width = 4096,
+		.max_height = 4096,
+		.max_pixels_per_frame = 4096 * 4096,
+		.max_level = 4,
+	},
+	{
+		.codec_type = AMDGPU_VIDEO_CODEC_TYPE_HEVC,
+		.max_width = 4096,
+		.max_height = 4096,
+		.max_pixels_per_frame = 4096 * 4096,
+		.max_level = 186,
+	},
+	{
+		.codec_type = AMDGPU_VIDEO_CODEC_TYPE_JPEG,
+		.max_width = 4096,
+		.max_height = 4096,
+		.max_pixels_per_frame = 4096 * 4096,
+		.max_level = 0,
+	},
+};
+
+static const struct amdgpu_video_codecs vega_video_codecs_decode =
+{
+	.codec_count = ARRAY_SIZE(vega_video_codecs_decode_array),
+	.codec_array = vega_video_codecs_decode_array,
+};
+
+/* Raven */
+static const struct amdgpu_video_codec_info rv_video_codecs_decode_array[] =
+{
+	{
+		.codec_type = AMDGPU_VIDEO_CODEC_TYPE_MPEG2,
+		.max_width = 4096,
+		.max_height = 4096,
+		.max_pixels_per_frame = 4096 * 4096,
+		.max_level = 3,
+	},
+	{
+		.codec_type = AMDGPU_VIDEO_CODEC_TYPE_MPEG4,
+		.max_width = 4096,
+		.max_height = 4096,
+		.max_pixels_per_frame = 4096 * 4096,
+		.max_level = 5,
+	},
+	{
+		.codec_type = AMDGPU_VIDEO_CODEC_TYPE_MPEG4_AVC,
+		.max_width = 4096,
+		.max_height = 4096,
+		.max_pixels_per_frame = 4096 * 4096,
+		.max_level = 52,
+	},
+	{
+		.codec_type = AMDGPU_VIDEO_CODEC_TYPE_VC1,
+		.max_width = 4096,
+		.max_height = 4096,
+		.max_pixels_per_frame = 4096 * 4096,
+		.max_level = 4,
+	},
+	{
+		.codec_type = AMDGPU_VIDEO_CODEC_TYPE_HEVC,
+		.max_width = 4096,
+		.max_height = 4096,
+		.max_pixels_per_frame = 4096 * 4096,
+		.max_level = 186,
+	},
+	{
+		.codec_type = AMDGPU_VIDEO_CODEC_TYPE_JPEG,
+		.max_width = 4096,
+		.max_height = 4096,
+		.max_pixels_per_frame = 4096 * 4096,
+		.max_level = 0,
+	},
+	{
+		.codec_type = AMDGPU_VIDEO_CODEC_TYPE_VP9,
+		.max_width = 4096,
+		.max_height = 4096,
+		.max_pixels_per_frame = 4096 * 4096,
+		.max_level = 0,
+	},
+};
+
+static const struct amdgpu_video_codecs rv_video_codecs_decode =
+{
+	.codec_count = ARRAY_SIZE(rv_video_codecs_decode_array),
+	.codec_array = rv_video_codecs_decode_array,
+};
+
+/* Renoir, Arcturus */
+static const struct amdgpu_video_codec_info rn_video_codecs_decode_array[] =
+{
+	{
+		.codec_type = AMDGPU_VIDEO_CODEC_TYPE_MPEG2,
+		.max_width = 4096,
+		.max_height = 4096,
+		.max_pixels_per_frame = 4096 * 4096,
+		.max_level = 3,
+	},
+	{
+		.codec_type = AMDGPU_VIDEO_CODEC_TYPE_MPEG4,
+		.max_width = 4096,
+		.max_height = 4096,
+		.max_pixels_per_frame = 4096 * 4096,
+		.max_level = 5,
+	},
+	{
+		.codec_type = AMDGPU_VIDEO_CODEC_TYPE_MPEG4_AVC,
+		.max_width = 4096,
+		.max_height = 4096,
+		.max_pixels_per_frame = 4096 * 4096,
+		.max_level = 52,
+	},
+	{
+		.codec_type = AMDGPU_VIDEO_CODEC_TYPE_VC1,
+		.max_width = 4096,
+		.max_height = 4096,
+		.max_pixels_per_frame = 4096 * 4096,
+		.max_level = 4,
+	},
+	{
+		.codec_type = AMDGPU_VIDEO_CODEC_TYPE_HEVC,
+		.max_width = 8192,
+		.max_height = 4352,
+		.max_pixels_per_frame = 4096 * 4096,
+		.max_level = 186,
+	},
+	{
+		.codec_type = AMDGPU_VIDEO_CODEC_TYPE_JPEG,
+		.max_width = 4096,
+		.max_height = 4096,
+		.max_pixels_per_frame = 4096 * 4096,
+		.max_level = 0,
+	},
+	{
+		.codec_type = AMDGPU_VIDEO_CODEC_TYPE_VP9,
+		.max_width = 8192,
+		.max_height = 4352,
+		.max_pixels_per_frame = 4096 * 4096,
+		.max_level = 0,
+	},
+};
+
+static const struct amdgpu_video_codecs rn_video_codecs_decode =
+{
+	.codec_count = ARRAY_SIZE(rn_video_codecs_decode_array),
+	.codec_array = rn_video_codecs_decode_array,
+};
+
+static int soc15_query_video_codecs(struct amdgpu_device *adev, bool encode,
+				    const struct amdgpu_video_codecs **codecs)
+{
+	switch (adev->asic_type) {
+	case CHIP_VEGA20:
+	case CHIP_VEGA10:
+	case CHIP_VEGA12:
+		if (encode)
+			*codecs = &vega_video_codecs_encode;
+		else
+			*codecs = &vega_video_codecs_decode;
+		return 0;
+	case CHIP_RAVEN:
+		if (encode)
+			*codecs = &vega_video_codecs_encode;
+		else
+			*codecs = &rv_video_codecs_decode;
+		return 0;
+	case CHIP_ARCTURUS:
+	case CHIP_RENOIR:
+		if (encode)
+			*codecs = &vega_video_codecs_encode;
+		else
+			*codecs = &rn_video_codecs_decode;
+		return 0;
+	default:
+		return -EINVAL;
+	}
+}
+
 /*
  * Indirect registers accessor
  */
@@ -994,6 +1222,7 @@ static const struct amdgpu_asic_funcs soc15_asic_funcs =
 	.get_pcie_replay_count = &soc15_get_pcie_replay_count,
 	.supports_baco = &soc15_supports_baco,
 	.pre_asic_init = &soc15_pre_asic_init,
+	.query_video_codecs = &soc15_query_video_codecs,
 };
 
 static const struct amdgpu_asic_funcs vega20_asic_funcs =
@@ -1015,6 +1244,7 @@ static const struct amdgpu_asic_funcs vega20_asic_funcs =
 	.get_pcie_replay_count = &soc15_get_pcie_replay_count,
 	.supports_baco = &soc15_supports_baco,
 	.pre_asic_init = &soc15_pre_asic_init,
+	.query_video_codecs = &soc15_query_video_codecs,
 };
 
 static int soc15_common_early_init(void *handle)
diff --git a/drivers/gpu/drm/amd/amdgpu/vi.c b/drivers/gpu/drm/amd/amdgpu/vi.c
index eafb76aebd00..c33d46a99b7f 100644
--- a/drivers/gpu/drm/amd/amdgpu/vi.c
+++ b/drivers/gpu/drm/amd/amdgpu/vi.c
@@ -79,6 +79,193 @@
 #include "mxgpu_vi.h"
 #include "amdgpu_dm.h"
 
+/* Topaz */
+static const struct amdgpu_video_codecs topaz_video_codecs_encode =
+{
+	.codec_count = 0,
+	.codec_array = NULL,
+};
+
+/* Tonga, CZ, ST, Fiji */
+static const struct amdgpu_video_codec_info tonga_video_codecs_encode_array[] =
+{
+	{
+		.codec_type = AMDGPU_VIDEO_CODEC_TYPE_MPEG4_AVC,
+		.max_width = 4096,
+		.max_height = 2304,
+		.max_pixels_per_frame = 4096 * 2304,
+		.max_level = 0,
+	},
+};
+
+static const struct amdgpu_video_codecs tonga_video_codecs_encode =
+{
+	.codec_count = ARRAY_SIZE(tonga_video_codecs_encode_array),
+	.codec_array = tonga_video_codecs_encode_array,
+};
+
+/* Polaris */
+static const struct amdgpu_video_codec_info polaris_video_codecs_encode_array[] =
+{
+	{
+		.codec_type = AMDGPU_VIDEO_CODEC_TYPE_MPEG4_AVC,
+		.max_width = 4096,
+		.max_height = 2304,
+		.max_pixels_per_frame = 4096 * 2304,
+		.max_level = 0,
+	},
+	{
+		.codec_type = AMDGPU_VIDEO_CODEC_TYPE_HEVC,
+		.max_width = 4096,
+		.max_height = 2304,
+		.max_pixels_per_frame = 4096 * 2304,
+		.max_level = 0,
+	},
+};
+
+static const struct amdgpu_video_codecs polaris_video_codecs_encode =
+{
+	.codec_count = ARRAY_SIZE(polaris_video_codecs_encode_array),
+	.codec_array = polaris_video_codecs_encode_array,
+};
+
+/* Topaz */
+static const struct amdgpu_video_codecs topaz_video_codecs_decode =
+{
+	.codec_count = 0,
+	.codec_array = NULL,
+};
+
+/* Tonga */
+static const struct amdgpu_video_codec_info tonga_video_codecs_decode_array[] =
+{
+	{
+		.codec_type = AMDGPU_VIDEO_CODEC_TYPE_MPEG2,
+		.max_width = 4096,
+		.max_height = 4096,
+		.max_pixels_per_frame = 4096 * 4096,
+		.max_level = 3,
+	},
+	{
+		.codec_type = AMDGPU_VIDEO_CODEC_TYPE_MPEG4,
+		.max_width = 4096,
+		.max_height = 4096,
+		.max_pixels_per_frame = 4096 * 4096,
+		.max_level = 5,
+	},
+	{
+		.codec_type = AMDGPU_VIDEO_CODEC_TYPE_MPEG4_AVC,
+		.max_width = 4096,
+		.max_height = 4096,
+		.max_pixels_per_frame = 4096 * 4096,
+		.max_level = 52,
+	},
+	{
+		.codec_type = AMDGPU_VIDEO_CODEC_TYPE_VC1,
+		.max_width = 4096,
+		.max_height = 4096,
+		.max_pixels_per_frame = 4096 * 4096,
+		.max_level = 4,
+	},
+};
+
+static const struct amdgpu_video_codecs tonga_video_codecs_decode =
+{
+	.codec_count = ARRAY_SIZE(tonga_video_codecs_decode_array),
+	.codec_array = tonga_video_codecs_decode_array,
+};
+
+/* CZ, ST, Fiji, Polaris */
+static const struct amdgpu_video_codec_info cz_video_codecs_decode_array[] =
+{
+	{
+		.codec_type = AMDGPU_VIDEO_CODEC_TYPE_MPEG2,
+		.max_width = 4096,
+		.max_height = 4096,
+		.max_pixels_per_frame = 4096 * 4096,
+		.max_level = 3,
+	},
+	{
+		.codec_type = AMDGPU_VIDEO_CODEC_TYPE_MPEG4,
+		.max_width = 4096,
+		.max_height = 4096,
+		.max_pixels_per_frame = 4096 * 4096,
+		.max_level = 5,
+	},
+	{
+		.codec_type = AMDGPU_VIDEO_CODEC_TYPE_MPEG4_AVC,
+		.max_width = 4096,
+		.max_height = 4096,
+		.max_pixels_per_frame = 4096 * 4096,
+		.max_level = 52,
+	},
+	{
+		.codec_type = AMDGPU_VIDEO_CODEC_TYPE_VC1,
+		.max_width = 4096,
+		.max_height = 4096,
+		.max_pixels_per_frame = 4096 * 4096,
+		.max_level = 4,
+	},
+	{
+		.codec_type = AMDGPU_VIDEO_CODEC_TYPE_HEVC,
+		.max_width = 4096,
+		.max_height = 4096,
+		.max_pixels_per_frame = 4096 * 4096,
+		.max_level = 186,
+	},
+	{
+		.codec_type = AMDGPU_VIDEO_CODEC_TYPE_JPEG,
+		.max_width = 4096,
+		.max_height = 4096,
+		.max_pixels_per_frame = 4096 * 4096,
+		.max_level = 0,
+	},
+};
+
+static const struct amdgpu_video_codecs cz_video_codecs_decode =
+{
+	.codec_count = ARRAY_SIZE(cz_video_codecs_decode_array),
+	.codec_array = cz_video_codecs_decode_array,
+};
+
+static int vi_query_video_codecs(struct amdgpu_device *adev, bool encode,
+				 const struct amdgpu_video_codecs **codecs)
+{
+	switch (adev->asic_type) {
+	case CHIP_TOPAZ:
+		if (encode)
+			*codecs = &topaz_video_codecs_encode;
+		else
+			*codecs = &topaz_video_codecs_decode;
+		return 0;
+	case CHIP_TONGA:
+		if (encode)
+			*codecs = &tonga_video_codecs_encode;
+		else
+			*codecs = &tonga_video_codecs_decode;
+		return 0;
+	case CHIP_POLARIS10:
+	case CHIP_POLARIS11:
+	case CHIP_POLARIS12:
+	case CHIP_VEGAM:
+		if (encode)
+			*codecs = &polaris_video_codecs_encode;
+		else
+			*codecs = &cz_video_codecs_decode;
+		return 0;
+	case CHIP_FIJI:
+	case CHIP_CARRIZO:
+	case CHIP_STONEY:
+		if (encode)
+			*codecs = &tonga_video_codecs_encode;
+		else
+			*codecs = &cz_video_codecs_decode;
+		return 0;
+	default:
+		return -EINVAL;
+	}
+}
+
 /*
  * Indirect registers accessor
  */
@@ -1085,6 +1272,7 @@ static const struct amdgpu_asic_funcs vi_asic_funcs =
 	.get_pcie_replay_count = &vi_get_pcie_replay_count,
 	.supports_baco = &vi_asic_supports_baco,
 	.pre_asic_init = &vi_pre_asic_init,
+	.query_video_codecs = &vi_query_video_codecs,
 };
 
 #define CZ_REV_BRISTOL(rev)	 \
-- 
2.29.2

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
