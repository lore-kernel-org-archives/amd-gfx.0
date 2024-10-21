Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D549D15DBE
	for <amd-gfx@archiver.kernel.org>; Mon, 21 Oct 2024 16:50:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B68E410E565;
	Mon, 21 Oct 2024 16:50:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="GANA/zwE";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2061.outbound.protection.outlook.com [40.107.244.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A9B6410E566
 for <amd-gfx@lists.freedesktop.org>; Mon, 21 Oct 2024 16:50:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ymIdbCgQs/8EHpS1T+H3PqFFzNwvtGywtVHmDfvNPPRAPUpCRJR30guSpctkY1tp7K8kxA4riumVDuDzbQ8TUsPZlB8/mJIVRp0VVtYhMM0kPlCVQ6xqOvsyX3xIOL0MjI0/CW5Lu/xsImHiSl8RBfgCyCBIzoY1RunlbxGcKmZDKaLVGeRQ0+5AcJ9lO9W+MNPkBzVO5oO3pB6w4jSO4TVyx/JdFvjk25cppFkyA2xa/5A0eW7hTt8t7BetgUD3IPHla5ZGGEPJLA/V97KTzsrXBCvHYALkSTwC+4tMBoaL3XKcBetGCubtQoRi5MDCgx2d9Zw3rAmGv7LiE1xo0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RwYOxSG6GyEZbOkJc0XIe4B5NtFqzuEW4mZseMIkceA=;
 b=n58/yXRPqd9Yr4xW0k1CNcYKUkg1Ry3wW6wRH0wAXJm0qk9w43nY2dKR99ZehfrGKajSXuXTbSkqymMhowV/PT32RuimRd6XqJJVhPiYW8nQopj9PB8jSZm7OGOjs2btMw5fRtUBD/S6hWHS8XtaK7Yu1oVSObyiHXNRUxT+2Px+nAUKa21UhDNyNnQp//qj5gN0NKkORvLn2a65joo9JgXrlVxyH8SRlImkro9C+pPilL8Dnmt4HxDwCxvluo6bk2615umsQBmJ/RbRz3EVGQ1Hv+FpblhSTeM1PAc1KD+9X/Kx+RUEL6WdliYdu5aNi55GwGUr5oYIc7qec+HNlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RwYOxSG6GyEZbOkJc0XIe4B5NtFqzuEW4mZseMIkceA=;
 b=GANA/zwE6KSrD7axtNcgfC8wpY6epk8iR5lbCCh8z5PtCEy0zCEXG0MfLdVQih0nqoSi6tFvzkvhcYR36IDYgjwvhTgCd36omeCj91mRj9SawiU+ltX37p4C0Oy5svpTLeEiG8T+08mW6By7oD9Lms2ohbvzvyqcUqupKGqoQ8g=
Received: from BL6PEPF0001641A.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:22e:400:0:1004:0:6) by MW4PR12MB7263.namprd12.prod.outlook.com
 (2603:10b6:303:226::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.28; Mon, 21 Oct
 2024 16:50:47 +0000
Received: from BL6PEPF0001AB59.namprd02.prod.outlook.com
 (2a01:111:f403:f903::3) by BL6PEPF0001641A.outlook.office365.com
 (2603:1036:903:4::a) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.29 via Frontend
 Transport; Mon, 21 Oct 2024 16:50:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB59.mail.protection.outlook.com (10.167.241.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8093.14 via Frontend Transport; Mon, 21 Oct 2024 16:50:47 +0000
Received: from 10.22.74.174.in-addr.arpa (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 21 Oct 2024 11:50:45 -0500
From: David Rosca <david.rosca@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: David Rosca <david.rosca@amd.com>, Leo Liu <leo.liu@amd.com>
Subject: [PATCH] drm/amdgpu: Fix video caps for H264 and HEVC encode maximum
 size
Date: Mon, 21 Oct 2024 18:49:24 +0200
Message-ID: <20241021164923.19073-1-david.rosca@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB59:EE_|MW4PR12MB7263:EE_
X-MS-Office365-Filtering-Correlation-Id: b64c075c-365e-432d-61c1-08dcf1f0830b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?8J2e/HwWZJ3v0WFgOzvw+8Lye9zbqHXGQ6+Kp4sd2uHTQkhkbLvFPP2CJsXP?=
 =?us-ascii?Q?vxUf5DLf5PeQKB6uHF2jcs+2R8KNssFEyLz91qvClUJ9NXbWGpXaNJZPiOev?=
 =?us-ascii?Q?5BcTBUPyBqIX4Gg7IPkMYnrekTLe0P5ZtCmLMIj930hyB+AbTiXrnfoSMYSG?=
 =?us-ascii?Q?z483+nZNHv9l94/IFmnhv+wl+lr03aY7ZylYbSP2SIpIwqFzTEezX0tiVKD+?=
 =?us-ascii?Q?bklOOBMdTh0HCHPmYCPWonMj/AUv18RiSyPS8xNleZJcWRQkyodCICGpzuTh?=
 =?us-ascii?Q?pQOFqYPlQ57nt5VYwn3fewQC+EtoONUV/bQEoYyyMC4c6oFOWnqNUKHT8QT6?=
 =?us-ascii?Q?XCzsknfPBbuf6SNQKiQzWiAAVtgj+x2VAdyctniglSWsd9QkJ++8EiH6G4Tm?=
 =?us-ascii?Q?JDj2IZm1tKHdTyYTMvwjiT0TCGUivG+71sPbQP7MOqV41bwO2FlBPUJO6zWD?=
 =?us-ascii?Q?xDLdbebYX6inu1k1ZxVFq2P+O/uWZY0wvLQgSZsloDv+7nPs+NjdkkHpc5PP?=
 =?us-ascii?Q?Fg1lkIm3YvoUePSBOCSzFDr4FDOj2EJJz9LetW4TfhR/dF+1RCMoLpscxnKA?=
 =?us-ascii?Q?WJu6MbIn09OmawYc3h+dxbLc3iHMFKdsBV7LGHipQPlyiqV1pCJRwH2knFat?=
 =?us-ascii?Q?IwKDjagdryU/DaTAJg2ke4SOx8ScBjkky9AIfSHry2ZUjNa66/3rY2zR9he3?=
 =?us-ascii?Q?cyV3ynrCNVvcDz176E2qf/yFZCUAFgjlpUPQj6zpAMKnHVJZQE4EZfkPayCV?=
 =?us-ascii?Q?AibflEomCOfURvq6I9nWjKZ3A1s0YgjoFFXsbEijwymAGMp7EiH54sAEuzQq?=
 =?us-ascii?Q?IVRoUVXHywpuiGDbUwuBXcBCw+JlTJ1hZsuB7VFO12Owk//Knf1BP4NnYJqE?=
 =?us-ascii?Q?CgL2rB6X63QFL7/HExEYMAOSxiXbLcI7coaNlfMS5PVhDrC2G37Uc/KRmtc/?=
 =?us-ascii?Q?58yRP6yRjgRZHetvi3xMAvMYPXJdXsh/JHZvKG3bQivvVn5Wy8Jd0xlb1D0k?=
 =?us-ascii?Q?/fzF/0DCyr3XMmgbAQz+HstHAZ3GNk5lb9/SUmnR2sBIhlMJR+JaVvcm9mRy?=
 =?us-ascii?Q?hoO2v6VerY/V88Idq2KThjm3SzJh7tdJbk1XOXWNBZiwiZ+sACqS36gkvG81?=
 =?us-ascii?Q?nLk0UazydCewxDhF58m2HR+ALsoCJS/EryTuiDveOOap530kYt5M4rmwJ9mq?=
 =?us-ascii?Q?/GZ/5Cb+wzMtqtj/L7+Mwe7DenaHMZgv09fF7NcGMX2pvni3NtKP2cgKO333?=
 =?us-ascii?Q?XSL3SWQICjJCdG7zIJFk8TMGp+V1Vr7EW/ivKmZ2Aus/sIESBFc8VGNN4OQ7?=
 =?us-ascii?Q?GGE+vicKJpoRzT1D1tYgnr1DfeGbZc7ajxO7UpGFOyks1gT7ATh+mQwGEWQx?=
 =?us-ascii?Q?Oo0JAwJAljDjCe/i7souIV4o+BVj/UeHyygxUI8RIW5x+ol0vg=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2024 16:50:47.2150 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b64c075c-365e-432d-61c1-08dcf1f0830b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB59.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7263
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

H264 supports 4096x4096 starting from Polaris.
HEVC also supports 4096x4096, with VCN 3 and newer 8192x4352
is supported.

Signed-off-by: David Rosca <david.rosca@amd.com>
Reviewed-by: Leo Liu <leo.liu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/nv.c    | 12 ++++++------
 drivers/gpu/drm/amd/amdgpu/soc15.c |  4 ++--
 drivers/gpu/drm/amd/amdgpu/soc21.c | 12 ++++++------
 drivers/gpu/drm/amd/amdgpu/soc24.c |  2 +-
 drivers/gpu/drm/amd/amdgpu/vi.c    |  8 ++++----
 5 files changed, 19 insertions(+), 19 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/nv.c b/drivers/gpu/drm/amd/amdgpu/nv.c
index 4e8f9af1e2be..d07210d97ed6 100644
--- a/drivers/gpu/drm/amd/amdgpu/nv.c
+++ b/drivers/gpu/drm/amd/amdgpu/nv.c
@@ -67,8 +67,8 @@ static const struct amd_ip_funcs nv_common_ip_funcs;
 
 /* Navi */
 static const struct amdgpu_video_codec_info nv_video_codecs_encode_array[] = {
-	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_MPEG4_AVC, 4096, 2304, 0)},
-	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_HEVC, 4096, 2304, 0)},
+	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_MPEG4_AVC, 4096, 4096, 0)},
+	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_HEVC, 4096, 4096, 0)},
 };
 
 static const struct amdgpu_video_codecs nv_video_codecs_encode = {
@@ -94,8 +94,8 @@ static const struct amdgpu_video_codecs nv_video_codecs_decode = {
 
 /* Sienna Cichlid */
 static const struct amdgpu_video_codec_info sc_video_codecs_encode_array[] = {
-	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_MPEG4_AVC, 4096, 2160, 0)},
-	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_HEVC, 7680, 4352, 0)},
+	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_MPEG4_AVC, 4096, 4096, 0)},
+	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_HEVC, 8192, 4352, 0)},
 };
 
 static const struct amdgpu_video_codecs sc_video_codecs_encode = {
@@ -136,8 +136,8 @@ static const struct amdgpu_video_codecs sc_video_codecs_decode_vcn1 = {
 
 /* SRIOV Sienna Cichlid, not const since data is controlled by host */
 static struct amdgpu_video_codec_info sriov_sc_video_codecs_encode_array[] = {
-	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_MPEG4_AVC, 4096, 2160, 0)},
-	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_HEVC, 7680, 4352, 0)},
+	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_MPEG4_AVC, 4096, 4096, 0)},
+	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_HEVC, 8192, 4352, 0)},
 };
 
 static struct amdgpu_video_codec_info sriov_sc_video_codecs_decode_array_vcn0[] = {
diff --git a/drivers/gpu/drm/amd/amdgpu/soc15.c b/drivers/gpu/drm/amd/amdgpu/soc15.c
index dd1c1aacdd8e..143a8f77e348 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc15.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc15.c
@@ -90,8 +90,8 @@ static const struct amd_ip_funcs soc15_common_ip_funcs;
 /* Vega, Raven, Arcturus */
 static const struct amdgpu_video_codec_info vega_video_codecs_encode_array[] =
 {
-	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_MPEG4_AVC, 4096, 2304, 0)},
-	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_HEVC, 4096, 2304, 0)},
+	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_MPEG4_AVC, 4096, 4096, 0)},
+	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_HEVC, 4096, 4096, 0)},
 };
 
 static const struct amdgpu_video_codecs vega_video_codecs_encode =
diff --git a/drivers/gpu/drm/amd/amdgpu/soc21.c b/drivers/gpu/drm/amd/amdgpu/soc21.c
index c4b950e75133..4c2d88045ac2 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc21.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc21.c
@@ -49,13 +49,13 @@ static const struct amd_ip_funcs soc21_common_ip_funcs;
 
 /* SOC21 */
 static const struct amdgpu_video_codec_info vcn_4_0_0_video_codecs_encode_array_vcn0[] = {
-	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_MPEG4_AVC, 4096, 2304, 0)},
+	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_MPEG4_AVC, 4096, 4096, 0)},
 	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_HEVC, 8192, 4352, 0)},
 	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_AV1, 8192, 4352, 0)},
 };
 
 static const struct amdgpu_video_codec_info vcn_4_0_0_video_codecs_encode_array_vcn1[] = {
-	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_MPEG4_AVC, 4096, 2304, 0)},
+	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_MPEG4_AVC, 4096, 4096, 0)},
 	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_HEVC, 8192, 4352, 0)},
 };
 
@@ -96,14 +96,14 @@ static const struct amdgpu_video_codecs vcn_4_0_0_video_codecs_decode_vcn1 = {
 
 /* SRIOV SOC21, not const since data is controlled by host */
 static struct amdgpu_video_codec_info sriov_vcn_4_0_0_video_codecs_encode_array_vcn0[] = {
-	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_MPEG4_AVC, 4096, 2304, 0)},
-	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_HEVC, 4096, 2304, 0)},
+	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_MPEG4_AVC, 4096, 4096, 0)},
+	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_HEVC, 8192, 4352, 0)},
 	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_AV1, 8192, 4352, 0)},
 };
 
 static struct amdgpu_video_codec_info sriov_vcn_4_0_0_video_codecs_encode_array_vcn1[] = {
-	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_MPEG4_AVC, 4096, 2304, 0)},
-	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_HEVC, 4096, 2304, 0)},
+	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_MPEG4_AVC, 4096, 4096, 0)},
+	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_HEVC, 8192, 4352, 0)},
 };
 
 static struct amdgpu_video_codecs sriov_vcn_4_0_0_video_codecs_encode_vcn0 = {
diff --git a/drivers/gpu/drm/amd/amdgpu/soc24.c b/drivers/gpu/drm/amd/amdgpu/soc24.c
index b20dc81dc257..6f4371276fbb 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc24.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc24.c
@@ -48,7 +48,7 @@
 static const struct amd_ip_funcs soc24_common_ip_funcs;
 
 static const struct amdgpu_video_codec_info vcn_5_0_0_video_codecs_encode_array_vcn0[] = {
-	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_MPEG4_AVC, 4096, 2304, 0)},
+	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_MPEG4_AVC, 4096, 4096, 0)},
 	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_HEVC, 8192, 4352, 0)},
 	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_AV1, 8192, 4352, 0)},
 };
diff --git a/drivers/gpu/drm/amd/amdgpu/vi.c b/drivers/gpu/drm/amd/amdgpu/vi.c
index 4996049dc199..3832c89953d2 100644
--- a/drivers/gpu/drm/amd/amdgpu/vi.c
+++ b/drivers/gpu/drm/amd/amdgpu/vi.c
@@ -136,15 +136,15 @@ static const struct amdgpu_video_codec_info polaris_video_codecs_encode_array[]
 	{
 		.codec_type = AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_MPEG4_AVC,
 		.max_width = 4096,
-		.max_height = 2304,
-		.max_pixels_per_frame = 4096 * 2304,
+		.max_height = 4096,
+		.max_pixels_per_frame = 4096 * 4096,
 		.max_level = 0,
 	},
 	{
 		.codec_type = AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_HEVC,
 		.max_width = 4096,
-		.max_height = 2304,
-		.max_pixels_per_frame = 4096 * 2304,
+		.max_height = 4096,
+		.max_pixels_per_frame = 4096 * 4096,
 		.max_level = 0,
 	},
 };
-- 
2.47.0

