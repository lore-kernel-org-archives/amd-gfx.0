Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C7C6C19776
	for <amd-gfx@archiver.kernel.org>; Fri, 28 Feb 2025 14:51:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3C15010E008;
	Fri, 28 Feb 2025 14:51:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="1DVcJMz3";
	dkim-atps=neutral
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2070.outbound.protection.outlook.com [40.107.102.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6BBA510E008
 for <amd-gfx@lists.freedesktop.org>; Fri, 28 Feb 2025 14:50:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kAWavwJOZxSqfyTsPjXgTONGEWgXTZvU0NgcorQOdAa7p3yNjaaSH8Gb2D5L3Hr9IcEsCcP9e3uc12ivr4vGCfyl6h8bfOYdGN8NU2gZvSAwL5CRYa5eENyvFyr4iBMNOroSwUyDLeGmTks3BOtBkeihzxbfgntGNuURRQzaM61KcH2dAbxeO//drkmNKsWHDk8oi+bHDOK3XM574FhRWWT7xBWPDQNnWReNhq9BV6r4iyLUvaZaAGt2PAg9q88A4fyVAGnObx29sDF6BClS2Tc9EOh+cAjakvmWrpdL6QAJ5kU2LeSpaMajdECFN5wAWd4te49iwHdg40oQrcemiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SnpYeslVlZgFzfc3zzhnOnzyxJ2V/BgBd8oaloDFiBI=;
 b=JUP5hEUyoNk9U7amd2AfM0eXGHaE4Fh+hgMVGVWUncgL7NUsyRhzYspGtgNyTmZXlAc6J9Gi+ZdlRBBaZn1/ikOd0g7MLTlC8FuXSwbiBIyD54TRcIHpBCzOcTn/xxyzWT6Te22P3g4HYQvmlcPHrYoo5UVpw7U4DocgQ9g/Wno7jHcMCJcYsqlBw8ZzTJ7iNsnLYtxVCD3bEpQxSUblrO83WS1G/vTrHuxBghhCRHVdrt2+fe92X9vxTOIZ7DkChC7R1YkiHHo+5xV+QL+8W0BZhDpOW1W58hRRxR4wSgliQ/zu9RGHZoK5HPOh0lWOqQYba8KCzeSiMbVd70nMAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SnpYeslVlZgFzfc3zzhnOnzyxJ2V/BgBd8oaloDFiBI=;
 b=1DVcJMz3JKPbwnk41HLVwojytgjR5kp/IR8JbhZVo6DJO6ZB1ku4oXarRJUP/vDKm5UOQCif9aSjK7vxgvN9LsTmYwhUJa9IjqoBxFZyMNyt7laJm0RuCmX8anQ8U6bQ0SZd9Co/QZC9P1bUxe+K5COSs+GFJ3Q+rckU3kdOAhs=
Received: from BL0PR0102CA0062.prod.exchangelabs.com (2603:10b6:208:25::39) by
 CH3PR12MB9316.namprd12.prod.outlook.com (2603:10b6:610:1ce::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.22; Fri, 28 Feb
 2025 14:50:52 +0000
Received: from BL02EPF0001A102.namprd05.prod.outlook.com
 (2603:10b6:208:25:cafe::4) by BL0PR0102CA0062.outlook.office365.com
 (2603:10b6:208:25::39) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8489.22 via Frontend Transport; Fri,
 28 Feb 2025 14:50:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0001A102.mail.protection.outlook.com (10.167.241.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8489.16 via Frontend Transport; Fri, 28 Feb 2025 14:50:50 +0000
Received: from work.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 28 Feb
 2025 08:50:49 -0600
From: David Rosca <david.rosca@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: David Rosca <david.rosca@amd.com>
Subject: [PATCH v2 1/4] drm/amdgpu: Fix MPEG2,
 MPEG4 and VC1 video caps max size
Date: Fri, 28 Feb 2025 15:48:30 +0100
Message-ID: <20250228144832.50699-2-david.rosca@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A102:EE_|CH3PR12MB9316:EE_
X-MS-Office365-Filtering-Correlation-Id: c62d7ebb-f611-4d54-bf12-08dd58074b32
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?RamIvPsZEpUsnHFnFZ0obH75LJNawYrovGbQB/JXFm22jMshpQLOD60fBzxr?=
 =?us-ascii?Q?ovrhxMGjUr2XGecmS4JA6peaAaYU/C0YUNiUgEOq7wFwMqbWwHFFJXZAz5WS?=
 =?us-ascii?Q?SYx41xEJmKvKxl58EhYqEYXR03yi1zG3PuinyjldtHy8+Kh5eKVZF6nzN6an?=
 =?us-ascii?Q?w1Tn2KfhPLzG5YGmdiwenpZQHoo6NyXAj0MK5CPvVOpZE4GE6/C/xetmS2re?=
 =?us-ascii?Q?UNwq/YXFAiHyLeDlPsHE9slWk6r+KwacMG+Ul3q7iTvSsV9lQOPvRPZFPE/V?=
 =?us-ascii?Q?fVJMaUzULUun0EkS2m+xq+kpfVzKcBc7q8omUAOOERp4sufMuyOVbycjMsKI?=
 =?us-ascii?Q?l6x+CfSstATU7P/VwIatwsWsv+TtxP2uEhB66B36N70Zwzu8RXAl4+qZm3x4?=
 =?us-ascii?Q?AvvFx0SWwwWrpnZQoE1FIVP71+wxnaQKNa6pFwjcYRN2UsElDVcMhnbglvVI?=
 =?us-ascii?Q?gaZfOt7YMruPXA8q7q7ZZrVWUGJgstJlBJtN3Ob9Dsmu8goOOcdq6EESFK2b?=
 =?us-ascii?Q?4au/s1F8DOYZwx5xS2qkiesfM5eMGAuam+v2PGdcgv/yObyL3cD8+TrgvavQ?=
 =?us-ascii?Q?yJ1XSxxSSeyzRU9rItpTgn4SYuo1zjIaUDtBIvhnXmaeMv8s4xWDhDX43cTT?=
 =?us-ascii?Q?ghaGSgn3gxOQOeBfdy/GKNqYlsgAbTERuq4TAUD2yCDWf+65+xL1SLCv9jXo?=
 =?us-ascii?Q?P8cQynT48mZRwZ4zaoGkT/mw3fZ8QylqHcGriYwKNt/GgMinVQpUOnjGvRg+?=
 =?us-ascii?Q?nTLauvq/0avmxpwvBobszSPqH8WgvNx5eA3mwum1/45pZzUgetZ1xk0Kl7wz?=
 =?us-ascii?Q?/fH4/cDNdE/5L+cJysJquTgbGoe62iAkYetu7miOvtdcZtylL8Cpx43fipv2?=
 =?us-ascii?Q?dyKM6SFwnoQU8fiK7F0C5ahhH/M2RZBYTJZD7nM2TpV4qnq8HPzuNPu0PGYU?=
 =?us-ascii?Q?pv6Ro4Nmsl55lUWpTVteSyXX1UgsD+fcX9b8BucxI7qLDU8Kzs3hVQY+NdsK?=
 =?us-ascii?Q?7RrVQ0Z0QDC0Ci5WOJXcDUy7klobWM6pdMXCTddeVNf12r0M3IOPK6/iHx7+?=
 =?us-ascii?Q?V2eNB5cgHGXydL7MQ7CIqYegaUfV8gEVBvgpy6+vaGRnWzYqrs4EeDIrm5/q?=
 =?us-ascii?Q?ScY+b0+C2hQnXSpacTMmaCThNsaoB0HCx7TqYR2JL32OQNO2tmcqpk8cO9Fo?=
 =?us-ascii?Q?emYhKRbT0jhUGoNlqscUbbz1TVw6LktaiXpNgmge/ClH1nRFPm1WcTll3wmL?=
 =?us-ascii?Q?2DKn/mNsqkLaBPD5kYogmW961UNXj8aqVS1Ne9OUuIXs8d8//DPXUr/g4baR?=
 =?us-ascii?Q?Trg0hjiOs9RKaP0FCYWqT8ITK9yHxqaD8XAN2h/wYUDVFCHzUarHHGPvpJMU?=
 =?us-ascii?Q?iyrSHgbGvqMCBNhrvZcLbLBoi3gca8J86POv5KvYbP7/ydo/YGOKuPE5AzB9?=
 =?us-ascii?Q?cmkQVVGO10HyLImDWd4ADf0smRoeHXh7U44+fdYEDPShsav4oVcHlE8oYz+u?=
 =?us-ascii?Q?eYzLtNFqfRoDEOg=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2025 14:50:50.5641 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c62d7ebb-f611-4d54-bf12-08dd58074b32
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A102.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9316
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
 drivers/gpu/drm/amd/amdgpu/nv.c    | 18 +++++++--------
 drivers/gpu/drm/amd/amdgpu/soc15.c | 18 +++++++--------
 drivers/gpu/drm/amd/amdgpu/vi.c    | 36 +++++++++++++++---------------
 3 files changed, 36 insertions(+), 36 deletions(-)

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
diff --git a/drivers/gpu/drm/amd/amdgpu/soc15.c b/drivers/gpu/drm/amd/amdgpu/soc15.c
index 8732f766947e..c5a752d8aee5 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc15.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc15.c
@@ -102,10 +102,10 @@ static const struct amdgpu_video_codecs vega_video_codecs_encode =
 /* Vega */
 static const struct amdgpu_video_codec_info vega_video_codecs_decode_array[] =
 {
-	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_MPEG2, 4096, 4096, 3)},
-	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_MPEG4, 4096, 4096, 5)},
+	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_MPEG2, 1920, 1088, 3)},
+	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_MPEG4, 1920, 1088, 5)},
 	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_MPEG4_AVC, 4096, 4096, 52)},
-	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_VC1, 4096, 4096, 4)},
+	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_VC1, 1920, 1088, 4)},
 	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_HEVC, 4096, 4096, 186)},
 	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_JPEG, 4096, 4096, 0)},
 };
@@ -119,10 +119,10 @@ static const struct amdgpu_video_codecs vega_video_codecs_decode =
 /* Raven */
 static const struct amdgpu_video_codec_info rv_video_codecs_decode_array[] =
 {
-	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_MPEG2, 4096, 4096, 3)},
-	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_MPEG4, 4096, 4096, 5)},
+	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_MPEG2, 1920, 1088, 3)},
+	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_MPEG4, 1920, 1088, 5)},
 	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_MPEG4_AVC, 4096, 4096, 52)},
-	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_VC1, 4096, 4096, 4)},
+	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_VC1, 1920, 1088, 4)},
 	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_HEVC, 4096, 4096, 186)},
 	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_JPEG, 4096, 4096, 0)},
 	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_VP9, 4096, 4096, 0)},
@@ -137,10 +137,10 @@ static const struct amdgpu_video_codecs rv_video_codecs_decode =
 /* Renoir, Arcturus */
 static const struct amdgpu_video_codec_info rn_video_codecs_decode_array[] =
 {
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

