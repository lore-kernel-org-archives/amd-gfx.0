Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6C34C19776
	for <amd-gfx@archiver.kernel.org>; Fri, 28 Feb 2025 14:51:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8E04710ECC9;
	Fri, 28 Feb 2025 14:51:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="bU9yC1Uw";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2047.outbound.protection.outlook.com [40.107.93.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 92EAD10ECC9
 for <amd-gfx@lists.freedesktop.org>; Fri, 28 Feb 2025 14:51:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lf8MlooWQ2H9Tg608qGfGHfEpeJE3UmIUxViNQnsYxsRI4eUxA9PpG5s/S+CuN3FUbw+rewy2Nh/mhrcmTHpZitPyj83NHQ17iTmFV69VzDYPQJzVKQIR4IN+RjQ6Kod30/oUtZMGLon69kz2i9km2fWMZExkqJ3y5VzFrgQm+dSTAm9mJHO4GWc2X51STp/pgW6wSRm0166Qzc83IoOhwBIAeG76aTrCh5n1Wk9SBc4riDgtx674Buuxy5A4ootqlYoFGo78s3OkKB3g7V2XRz0gLMH5C9KqPIVM6PAMylWUp9wE3aVgAC0PUEwaMo0In7srEF8PlQ/R8zWIDD+HQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oiZsT0gVUTb3q8px9PSSY7SC46lhxH0Cw5R21Awcmac=;
 b=kLq2WUQEk9ynD+tckk2Wk6+grwXz/BeT+8SRLVEWhUA+V+EAA/WVu7mivaX1TAuKAfaut7ttA/7XOKnfNnnR7dMWu+Oi7TNQGI9FFSAK6HiKl5rrLBq1Pb4RHdrAahN5oTuiQxiuwFQZ3i9uTFH2FkcmYqR2MdhI2iXCcDcbSSFGAEXcZw12wg9wkZsV5TNhOiCJg/fTdwrgLXWxgRTJAkND08BRdkJHg39d5g2MCMJLTiywzBVufRmXlYNZUdzMiwaZoCV+EtCAF9c1TNcz5g/Z+ZObXSCDxkoTEyb1/v+wMSCWsPLT7FbvvAehdGK7gcFCxcI4pBONrAIZRbkKRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oiZsT0gVUTb3q8px9PSSY7SC46lhxH0Cw5R21Awcmac=;
 b=bU9yC1UwGoMpOvbi+Z730dQF+LDoCJohTe07lu5gQnSr5wwMFH3mArrP+v4DmxpQ/6u9QY4A09wDcmkWWqB/F2YTkvYqEXf8wHWAlKK2Jn1bT8jltHiwX/J4gAofMniUSuuU2T+PYXkQYhlwLeq4ghOvOGYqpQWG0LjdcS1jVec=
Received: from MN2PR22CA0023.namprd22.prod.outlook.com (2603:10b6:208:238::28)
 by MW6PR12MB8913.namprd12.prod.outlook.com (2603:10b6:303:247::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.20; Fri, 28 Feb
 2025 14:51:01 +0000
Received: from BL02EPF0001A103.namprd05.prod.outlook.com
 (2603:10b6:208:238:cafe::2f) by MN2PR22CA0023.outlook.office365.com
 (2603:10b6:208:238::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8489.21 via Frontend Transport; Fri,
 28 Feb 2025 14:51:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0001A103.mail.protection.outlook.com (10.167.241.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8489.16 via Frontend Transport; Fri, 28 Feb 2025 14:51:00 +0000
Received: from work.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 28 Feb
 2025 08:50:58 -0600
From: David Rosca <david.rosca@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: David Rosca <david.rosca@amd.com>
Subject: [PATCH v2 4/4] drm/amdgpu: Update SRIOV video codec caps
Date: Fri, 28 Feb 2025 15:48:33 +0100
Message-ID: <20250228144832.50699-5-david.rosca@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250228144832.50699-2-david.rosca@amd.com>
References: <20250228144832.50699-2-david.rosca@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A103:EE_|MW6PR12MB8913:EE_
X-MS-Office365-Filtering-Correlation-Id: 93376646-a93f-44aa-2c5a-08dd5807513a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?4j339V09HwdqQY7wiwhh3Ztzq6kXsWAixbJj7o665rFXxQiZdD1Iy1vLNMFR?=
 =?us-ascii?Q?DT23HwHWAOicypZx3VFwe8DiQGrvmi4VpktPj7ucj++9O7aSNLYbA+bW1Miw?=
 =?us-ascii?Q?S6lBWiusjYMtXTUfDTyulZzLYBmQWaONHTzU7wGhEpZbA5KKpFvuerDniwiV?=
 =?us-ascii?Q?I4UzM4J3h724901L+XV+nUyQuxHemXD0s0xE3Zm4YKSKXBEyeee6Go/dN2GV?=
 =?us-ascii?Q?ki4HzzIXEj/Iesp20Xwai7yJGojYEHGgyDjqb2+JTXDu5A4feYuugqy60WEC?=
 =?us-ascii?Q?/gk/DawYdavZdPSeoNEbnLOCjaK4mrYOcL8gsVlR0E75bTSDFQvg1BOr3QyQ?=
 =?us-ascii?Q?fOPiPanjSV0XhmrQ8xNVFSr6ya0NSuz7CHfmTNdppHgCOCIZUU+Ogap05Fk8?=
 =?us-ascii?Q?+7JP5xtIiFVRVS9hX8oRT6P3E70rfvLrqAmQjBD7eYtnNCyrKiivo6qMQ0ug?=
 =?us-ascii?Q?yFBm6pZuXjB0DFrsesxAHwVb/LlaqHaFb+5Z870+5WDoGLjxuhwnofdTlqIv?=
 =?us-ascii?Q?9+qlttnodhJLBLqIUT/kSzUg9Zpt73v6fDYO4p0XIGNSZW2+kJZN5xZdUOug?=
 =?us-ascii?Q?OevdKhnBL7fzzmwlIFqfxBR3NAztZLybMWTtQRl0fSker66M6C0HBWyB1HUe?=
 =?us-ascii?Q?wDi3keODV5SSw+B014f0cWEn/Z7VM5ueYg8IZ+iz1t5WFW9MV4yBiYEKrCA+?=
 =?us-ascii?Q?7I4aoVWDT70rZquX1VTVCKmiyw65NyQD8zgH8qMZWYxBh6lbUdPScSjO5raL?=
 =?us-ascii?Q?W3DU/+PqmVleLb4KY3ynrvND0uvE79+wjuW9/McL/7VeuojS+Vce8KkQDeSu?=
 =?us-ascii?Q?KnfXM+J3BC6K03XDARqURa2RbthnHMjbuTU5uAld6pboX4rRYmBdrkVsKplN?=
 =?us-ascii?Q?g/mTArzAsk/TRzvBng1HXCn5dmBKya4LyVKSbuSdxkJ/COWyVOlLIRtxBwpT?=
 =?us-ascii?Q?Cuu4iYgM9JW8SmGb2Gtrn0qFGyBs8Qo2ZAGYNl4eSAq0fbBvix8ztW78jt6Z?=
 =?us-ascii?Q?ABBmGQ2wN/pNOW6kqQ0yj3endLxrSB9HLSXso4tdHZpikJWuKgpjp16VN+FN?=
 =?us-ascii?Q?kYeUucSNpVwhgUprzXcYWXGIjV4g4OYqvqwK0AclYJTKb6a6F65LodEaxFAy?=
 =?us-ascii?Q?4xcnLA4PlQOjaLT5ymYt3ymvupWvoS2lGy0ETKz4OR3zhLPuEwvcZjPD5N9X?=
 =?us-ascii?Q?kX/vVwe6xSmTUW7tK/Ve9Gw7QRqz5RJTZ+M0/yj87NMHzB7RUkRczN4msbKQ?=
 =?us-ascii?Q?X8JhR4BaOfTfsTpX5y/UHe0yveXiz+o0jSZuBTG+gZ2991hDzL987j/7rWqH?=
 =?us-ascii?Q?taVkwXvfqNDwg1W52EVJSabhuG+C1/Aas9rFf5X+et9JTDYEG5SWjIWt8mBa?=
 =?us-ascii?Q?6nb4FEcQtHyg6g3U8DW+9MRn4MfP995p0+6XV2LLjjebbmNCF1Ia9orx+hxy?=
 =?us-ascii?Q?ZDNTwlsV10AXILCowWTvwq0cfTxgdhVSe/TOvfr87DIyVM3YcDDXLzt/mPpL?=
 =?us-ascii?Q?EBbgF3i3qv6YEts=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2025 14:51:00.6791 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 93376646-a93f-44aa-2c5a-08dd5807513a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A103.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8913
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

There have been multiple fixes to the video caps that are missing for
SRIOV. Update the SRIOV caps with correct values.

Signed-off-by: David Rosca <david.rosca@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/nv.c    | 16 ++++++++--------
 drivers/gpu/drm/amd/amdgpu/soc21.c | 10 ++--------
 2 files changed, 10 insertions(+), 16 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/nv.c b/drivers/gpu/drm/amd/amdgpu/nv.c
index 32b824c3658f..50e77d9b30af 100644
--- a/drivers/gpu/drm/amd/amdgpu/nv.c
+++ b/drivers/gpu/drm/amd/amdgpu/nv.c
@@ -141,23 +141,23 @@ static struct amdgpu_video_codec_info sriov_sc_video_codecs_encode_array[] = {
 };
 
 static struct amdgpu_video_codec_info sriov_sc_video_codecs_decode_array_vcn0[] = {
-	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_MPEG2, 4096, 4096, 3)},
-	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_MPEG4, 4096, 4096, 5)},
+	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_MPEG2, 1920, 1088, 3)},
+	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_MPEG4, 1920, 1088, 5)},
 	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_MPEG4_AVC, 4096, 4096, 52)},
-	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_VC1, 4096, 4096, 4)},
+	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_VC1, 1920, 1088, 4)},
 	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_HEVC, 8192, 4352, 186)},
-	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_JPEG, 4096, 4096, 0)},
+	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_JPEG, 16384, 16384, 0)},
 	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_VP9, 8192, 4352, 0)},
 	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_AV1, 8192, 4352, 0)},
 };
 
 static struct amdgpu_video_codec_info sriov_sc_video_codecs_decode_array_vcn1[] = {
-	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_MPEG2, 4096, 4096, 3)},
-	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_MPEG4, 4096, 4096, 5)},
+	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_MPEG2, 1920, 1088, 3)},
+	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_MPEG4, 1920, 1088, 5)},
 	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_MPEG4_AVC, 4096, 4096, 52)},
-	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_VC1, 4096, 4096, 4)},
+	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_VC1, 1920, 1088, 4)},
 	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_HEVC, 8192, 4352, 186)},
-	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_JPEG, 4096, 4096, 0)},
+	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_JPEG, 16384, 16384, 0)},
 	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_VP9, 8192, 4352, 0)},
 };
 
diff --git a/drivers/gpu/drm/amd/amdgpu/soc21.c b/drivers/gpu/drm/amd/amdgpu/soc21.c
index dd5d04c068f9..ad36c96478a8 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc21.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc21.c
@@ -117,23 +117,17 @@ static struct amdgpu_video_codecs sriov_vcn_4_0_0_video_codecs_encode_vcn1 = {
 };
 
 static struct amdgpu_video_codec_info sriov_vcn_4_0_0_video_codecs_decode_array_vcn0[] = {
-	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_MPEG2, 4096, 4096, 3)},
-	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_MPEG4, 4096, 4096, 5)},
 	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_MPEG4_AVC, 4096, 4096, 52)},
-	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_VC1, 4096, 4096, 4)},
 	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_HEVC, 8192, 4352, 186)},
-	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_JPEG, 4096, 4096, 0)},
+	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_JPEG, 16384, 16384, 0)},
 	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_VP9, 8192, 4352, 0)},
 	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_AV1, 8192, 4352, 0)},
 };
 
 static struct amdgpu_video_codec_info sriov_vcn_4_0_0_video_codecs_decode_array_vcn1[] = {
-	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_MPEG2, 4096, 4096, 3)},
-	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_MPEG4, 4096, 4096, 5)},
 	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_MPEG4_AVC, 4096, 4096, 52)},
-	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_VC1, 4096, 4096, 4)},
 	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_HEVC, 8192, 4352, 186)},
-	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_JPEG, 4096, 4096, 0)},
+	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_JPEG, 16384, 16384, 0)},
 	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_VP9, 8192, 4352, 0)},
 };
 
-- 
2.43.0

