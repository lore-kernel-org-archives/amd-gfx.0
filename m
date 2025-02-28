Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48B95C19776
	for <amd-gfx@archiver.kernel.org>; Fri, 28 Feb 2025 13:25:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D67B910E0CA;
	Fri, 28 Feb 2025 13:25:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="YLQ0T76p";
	dkim-atps=neutral
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2051.outbound.protection.outlook.com [40.107.102.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 341CC10E0CA
 for <amd-gfx@lists.freedesktop.org>; Fri, 28 Feb 2025 13:25:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=K/anvLa8jnEx4QHQeEYy02eLbICxpvvZxYF6t05Z4YNCCHrTSWxjMtoQmsprDhrR52+X1+pKjSoIjjgTmgwUIZMYh4j0eAOvg3TXRkx+uGQxNMO4fk+6FdkGXSTsXuljjDkVxGq0JfJz/22ZjyJhfH8F7fYcITanq93HTBFSWzImk3GYWa3FG80r4XgEXav9XykgW60R4oUoJvTf6UyLJn8RqktbKTWPRnDun9QxAHaGutE+u3jdxQI0KndawFaVLfNfPCMAvsgAnxcYQnSTEX177B4KbthQOh/VvKvdNgHvBMt0UFTV7kL2Sma3F8Pif0Gy/Qdc4BoY25yB87cgkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LsoVIVUBaYzhEsNbxFMfHtRiUjaVAEemr6cZEJr4NeA=;
 b=u7RV5hgRkMx66kxIKZ+ntyjRP/S+846v3ZWeKWVCL3Tw9E5J+rQX5KdsPufsF8mVtMLPwEshJ1aAGi0d5/x+eDCxO1XrSbmxqDPtNMMo2np0I2XDcL8t9dGt+/fqJC42n1MShcY4Det/JbxmQJQLK8KUNEHGiq/6KzhveYfArvQxb5JdyaYX/FLOib+aLx2TI8a8idOsPqdouefEX4jD0YJROpBLllfJwLop38BH7e86YJjtLcewdEWQtDjQzN24wwh+eywDtXlxNgFOcBgzV4G1+sAW13Q2zuaRHpIvFht5cvv8JbnH3dYxxkwux/5RGlMqKonxHAPm/xgmMlvXaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LsoVIVUBaYzhEsNbxFMfHtRiUjaVAEemr6cZEJr4NeA=;
 b=YLQ0T76pt6CwOEEp9t1ZpguiuoZQVwSaC7l8EF3wNi9ckbEHdPkMu+h2bQOUixlAJ1lbuO0lX2BEFDHaocrmnL5EexVfXh8PjitvEAFUSNV5cdWd07UnhEWm8fmCClHTCFRCv80U7Qo7hSqsx3JyKLlTEFU/sJ4btvgIhP3jgsI=
Received: from BYAPR21CA0030.namprd21.prod.outlook.com (2603:10b6:a03:114::40)
 by DM6PR12MB4123.namprd12.prod.outlook.com (2603:10b6:5:21f::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.23; Fri, 28 Feb
 2025 13:25:38 +0000
Received: from SA2PEPF000015C6.namprd03.prod.outlook.com
 (2603:10b6:a03:114:cafe::50) by BYAPR21CA0030.outlook.office365.com
 (2603:10b6:a03:114::40) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8511.6 via Frontend Transport; Fri,
 28 Feb 2025 13:25:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF000015C6.mail.protection.outlook.com (10.167.241.196) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8489.16 via Frontend Transport; Fri, 28 Feb 2025 13:25:37 +0000
Received: from work.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 28 Feb
 2025 07:25:36 -0600
From: David Rosca <david.rosca@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: David Rosca <david.rosca@amd.com>
Subject: [PATCH 1/4] drm/amdgpu: Fix MPEG2, MPEG4 and VC1 video caps max size
Date: Fri, 28 Feb 2025 14:24:29 +0100
Message-ID: <20250228132429.4842-4-david.rosca@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF000015C6:EE_|DM6PR12MB4123:EE_
X-MS-Office365-Filtering-Correlation-Id: 9b96d2f5-8bd3-4135-419c-08dd57fb6381
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?kZwNnwuKzFFFXGbi9JSqi1WJ39PpuTIhEhGJ5cG7HKKELaEGPGcHx1QiOfdp?=
 =?us-ascii?Q?ZCodyStBSBar2l8rkCAAimHmqg2LY5mB23BL4HP2XYOs8wR0+WFwRb8KDM11?=
 =?us-ascii?Q?LKuaeinML9L9qc3DaAkCyIwR7r/tsAPS4l1SPy6x/gVofBORmRlj9ZWm0NgZ?=
 =?us-ascii?Q?67GI8+PdbgLf+BYwkwJ2cEaeJW0aowRQend0Xau/dXslHtY4q4kJqrN+rzYw?=
 =?us-ascii?Q?7lHzpFkb2kQYk3pzw9PYH7ShbpDLNtSW06fP00atIz+QI41NY0oZHfEzvPVn?=
 =?us-ascii?Q?gx9+Ik8K8nTdsf/0htIjLSFegxE0h3jtdLCiReRvykEcXxaNDi4vR2xzQcOr?=
 =?us-ascii?Q?ESDyvMFkKtpHmYJPPSdANPdfSRPCWFFC5tWYiayUAhs+TpOfkxRl3MtkRqme?=
 =?us-ascii?Q?XZt+Ilz8RMoFQtvHu6CKyA4293UIWowUVgBcycyyR854meUghJis648Qqkfu?=
 =?us-ascii?Q?yytxJ/fyr+eU8vUbsrzBHPSBeB+pf6MY61Vx/VyWLoHFYiX2UskFyD93GgRq?=
 =?us-ascii?Q?GtRvV++lYNWBawojjJxP6mnPSPwk57WDePdHR3b4/HocnKri6FjwaV78z6vi?=
 =?us-ascii?Q?g250xSJeDpOPNhsQKurjjg8AWRnztysnmVgN2hc3xMboK3G0eHkKNqXl/XBj?=
 =?us-ascii?Q?qtM4uuM2xtCrCeG0FCgi7lrBqGhMnLAN4N2/O+wuIN+rl9Jy878Rzh+ox5dA?=
 =?us-ascii?Q?e0wk5j91UKtZl/d6QZxF2YiTxGbsFl27uTE2EyuS7wch2TR75PZ/860qMl4Z?=
 =?us-ascii?Q?av7/aihoNYDuP/jmaf7vSrIPUCzD294ZUhxC4rDO7sxT29o1EtDRzx6iQZTU?=
 =?us-ascii?Q?PaJNh6nw7pXyH4B7HftOYBxkYCw+bYodJ9oAzXlUAdoh1icyHDdmo1Rfu/rM?=
 =?us-ascii?Q?XphXHwvffQlBsjRcfzN/8tYVb6dnYlAHpGV6nUqzbaX5dUzmHSM7GJbvEtbi?=
 =?us-ascii?Q?VAKUBQBmnUw43ib1s4AsvKQGmxghDSIUkoS/fMjXqu6eiXcF45lbFndhB3BN?=
 =?us-ascii?Q?FkhHdtOo/wl1VjQaZBWTX5+uIR8uC0FgyNTBrH3mjbA67KMZR4C0JLMW4GqH?=
 =?us-ascii?Q?Pl93vTWzIOgH5uFoG7PgQ4KayjUicCRmSZSVGDpVMlw9oCXebxpi/QIuRXfl?=
 =?us-ascii?Q?/0Yop/KgLPbKmd7A1u6SsKsTXPRzjzagPt1nw2jyGIn2oz2vjx6l7L79HYhI?=
 =?us-ascii?Q?4e6Bm+6S5Zdlqolr9LYQ8+6V4yL4YSoH6qx6lANeCn7wzM+hflcV/e0PLRmt?=
 =?us-ascii?Q?Ea643MlGeI7Ozb72AQoM3QjBwXh3KQcNWmZqYoGX7nxYRgfugtTpRik+2JGu?=
 =?us-ascii?Q?rXKVRGWe6tAwkzJp8m+IKV/EJDqYl77Ynq7sKCZD6hh4vio1fbMTcQWzlDBU?=
 =?us-ascii?Q?zkkluPBFnZTQDs1jmeEoY7kbyD1Rap6YxJtKbinXN9zzxJckttfT64Lf59nd?=
 =?us-ascii?Q?/1YpqB/zKjy2zbzPFHmsPCZHy8+rljg56YMRR7QgwQngxapuzxCwmaUOidoY?=
 =?us-ascii?Q?4rJeqWwweZR2Dic=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2025 13:25:37.3364 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b96d2f5-8bd3-4135-419c-08dd57fb6381
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF000015C6.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4123
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

1920x1088 is the maximum supported resolution.

Signed-off-by: David Rosca <david.rosca@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/nv.c | 18 ++++++++---------
 drivers/gpu/drm/amd/amdgpu/vi.c | 36 ++++++++++++++++-----------------
 2 files changed, 27 insertions(+), 27 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/nv.c b/drivers/gpu/drm/amd/amdgpu/nv.c
index 8068f384f56c..a18e6fb9fa3f 100644
--- a/drivers/gpu/drm/amd/amdgpu/nv.c
+++ b/drivers/gpu/drm/amd/amdgpu/nv.c
@@ -78,10 +78,10 @@ static const struct amdgpu_video_codecs nv_video_codecs_encode = {
 
 /* Navi1x */
 static const struct amdgpu_video_codec_info nv_video_codecs_decode_array[] = {
-	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_MPEG2, 4096, 4096, 3)},
-	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_MPEG4, 4096, 4096, 5)},
+	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_MPEG2, 1920, 1088, 3)},
+	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_MPEG4, 1920, 1088, 5)},
 	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_MPEG4_AVC, 4096, 4096, 52)},
-	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_VC1, 4096, 4096, 4)},
+	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_VC1, 1920, 1088, 4)},
 	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_HEVC, 8192, 4352, 186)},
 	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_JPEG, 4096, 4096, 0)},
 	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_VP9, 8192, 4352, 0)},
@@ -104,10 +104,10 @@ static const struct amdgpu_video_codecs sc_video_codecs_encode = {
 };
 
 static const struct amdgpu_video_codec_info sc_video_codecs_decode_array_vcn0[] = {
-	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_MPEG2, 4096, 4096, 3)},
-	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_MPEG4, 4096, 4096, 5)},
+	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_MPEG2, 1920, 1088, 3)},
+	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_MPEG4, 1920, 1088, 5)},
 	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_MPEG4_AVC, 4096, 4096, 52)},
-	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_VC1, 4096, 4096, 4)},
+	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_VC1, 1920, 1088, 4)},
 	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_HEVC, 8192, 4352, 186)},
 	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_JPEG, 16384, 16384, 0)},
 	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_VP9, 8192, 4352, 0)},
@@ -115,10 +115,10 @@ static const struct amdgpu_video_codec_info sc_video_codecs_decode_array_vcn0[]
 };
 
 static const struct amdgpu_video_codec_info sc_video_codecs_decode_array_vcn1[] = {
-	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_MPEG2, 4096, 4096, 3)},
-	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_MPEG4, 4096, 4096, 5)},
+	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_MPEG2, 1920, 1088, 3)},
+	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_MPEG4, 1920, 1088, 5)},
 	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_MPEG4_AVC, 4096, 4096, 52)},
-	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_VC1, 4096, 4096, 4)},
+	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_VC1, 1920, 1088, 4)},
 	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_HEVC, 8192, 4352, 186)},
 	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_JPEG, 16384, 16384, 0)},
 	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_VP9, 8192, 4352, 0)},
diff --git a/drivers/gpu/drm/amd/amdgpu/vi.c b/drivers/gpu/drm/amd/amdgpu/vi.c
index 3bbbb75242d9..9b3510e53112 100644
--- a/drivers/gpu/drm/amd/amdgpu/vi.c
+++ b/drivers/gpu/drm/amd/amdgpu/vi.c
@@ -167,16 +167,16 @@ static const struct amdgpu_video_codec_info tonga_video_codecs_decode_array[] =
 {
 	{
 		.codec_type = AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_MPEG2,
-		.max_width = 4096,
-		.max_height = 4096,
-		.max_pixels_per_frame = 4096 * 4096,
+		.max_width = 1920,
+		.max_height = 1088,
+		.max_pixels_per_frame = 1920 * 1088,
 		.max_level = 3,
 	},
 	{
 		.codec_type = AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_MPEG4,
-		.max_width = 4096,
-		.max_height = 4096,
-		.max_pixels_per_frame = 4096 * 4096,
+		.max_width = 1920,
+		.max_height = 1088,
+		.max_pixels_per_frame = 1920 * 1088,
 		.max_level = 5,
 	},
 	{
@@ -188,9 +188,9 @@ static const struct amdgpu_video_codec_info tonga_video_codecs_decode_array[] =
 	},
 	{
 		.codec_type = AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_VC1,
-		.max_width = 4096,
-		.max_height = 4096,
-		.max_pixels_per_frame = 4096 * 4096,
+		.max_width = 1920,
+		.max_height = 1088,
+		.max_pixels_per_frame = 1920 * 1088,
 		.max_level = 4,
 	},
 };
@@ -206,16 +206,16 @@ static const struct amdgpu_video_codec_info cz_video_codecs_decode_array[] =
 {
 	{
 		.codec_type = AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_MPEG2,
-		.max_width = 4096,
-		.max_height = 4096,
-		.max_pixels_per_frame = 4096 * 4096,
+		.max_width = 1920,
+		.max_height = 1088,
+		.max_pixels_per_frame = 1920 * 1088,
 		.max_level = 3,
 	},
 	{
 		.codec_type = AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_MPEG4,
-		.max_width = 4096,
-		.max_height = 4096,
-		.max_pixels_per_frame = 4096 * 4096,
+		.max_width = 1920,
+		.max_height = 1088,
+		.max_pixels_per_frame = 1920 * 1088,
 		.max_level = 5,
 	},
 	{
@@ -227,9 +227,9 @@ static const struct amdgpu_video_codec_info cz_video_codecs_decode_array[] =
 	},
 	{
 		.codec_type = AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_VC1,
-		.max_width = 4096,
-		.max_height = 4096,
-		.max_pixels_per_frame = 4096 * 4096,
+		.max_width = 1920,
+		.max_height = 1088,
+		.max_pixels_per_frame = 1920 * 1088,
 		.max_level = 4,
 	},
 	{
-- 
2.43.0

