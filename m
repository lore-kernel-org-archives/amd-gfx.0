Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB144C07C79
	for <amd-gfx@archiver.kernel.org>; Mon, 22 Apr 2024 13:35:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 58914112AE4;
	Mon, 22 Apr 2024 13:35:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ATkQaOh3";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2070.outbound.protection.outlook.com [40.107.223.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4E671112AE4
 for <amd-gfx@lists.freedesktop.org>; Mon, 22 Apr 2024 13:35:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OEV0dgvz+r3YhhAIGT2BoCq9AY1rq2slxl79uINwx+Aerh3L+vgBkegxELVMRDD/jo591XcMfpABsgHei8QCBvYGYwLqgsOUJYcWO9j1f3mV9dYbc2h7xYiTWH5DyHysXBGWAB9OzqVijuXa3KVT3IwnE/kaXm0CkE5X3rydJ5BHxPFQsbA5SpcQbpcqrtEqPobkK10AkfmXJ/8f7MM1LLK1DPOhSmYI00F5/F4PzhOI6upqau09qhEl8X00kvR1zlAitS1kXrqJVjK9W1faoYzkiXUyRKxhLEwxvzQxogDdzKTp2mx9VC0l/rZmISwYeJc2EEi3+K2FbZKW34EzQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8i29dVg2MLDiXmscol79f23o5AfXB697VkWLkcLPXoU=;
 b=ijOTWD8wJPQidqUeMd80QwNFfwmDsAD8RYk/iTtGLEWdEJKW/AhMWPsGelRL6g3DuZtW4seOgqwr0a+LQvqLFsj9gvcuq3JMnrXlJ6xFOvRdmRR6g3BxMgNvhaKDA1Zm6TEb6bEFYawNB9Vn0mKM7FJznNiwxwINoQZj1n6+YsHa5LVZ0ghfj9quJ9jYSNLtQEC73zIgE4V3QTMq1Y8kbLLSo66mGf1IFJCLuUPjKY7Xud5VBUJdq2MIyuFTEV0Z1U9IF8pO1m3fIcz5DgQnNHqj2Bp8bYQuvZdEOrschN6NBZc2TNUPZoUCLywO0rxEuh+SiQYC8etsU/PD+3sEzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8i29dVg2MLDiXmscol79f23o5AfXB697VkWLkcLPXoU=;
 b=ATkQaOh3kw6DRCUL3gLnqd4TpKPrsAi5MeZcNwl0VjArLGTv8Tw1IptOieJa/zhMFPsWv5blAtmyu0a8UJKQWlRXXMRSKDnzLP1Op3ltDEzKQOSeYaGm3pZXfXdj4kDYTweuyaZMeU74X+6j9ys6/asGAQwyzdwVAGeeJl57yQ8=
Received: from DM6PR08CA0042.namprd08.prod.outlook.com (2603:10b6:5:1e0::16)
 by MW6PR12MB8759.namprd12.prod.outlook.com (2603:10b6:303:243::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Mon, 22 Apr
 2024 13:35:40 +0000
Received: from DS3PEPF000099DF.namprd04.prod.outlook.com
 (2603:10b6:5:1e0:cafe::d3) by DM6PR08CA0042.outlook.office365.com
 (2603:10b6:5:1e0::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7495.34 via Frontend
 Transport; Mon, 22 Apr 2024 13:35:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099DF.mail.protection.outlook.com (10.167.17.202) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7519.19 via Frontend Transport; Mon, 22 Apr 2024 13:35:39 +0000
Received: from sathish-X570-AORUS-ELITE.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 22 Apr 2024 08:35:37 -0500
From: Sathishkumar S <sathishkumar.sundararaju@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Leo Liu <Leo.Liu@amd.com>, Sathishkumar S
 <sathishkumar.sundararaju@amd.com>
Subject: [PATCH] drm/amdgpu: update jpeg max decode resolution
Date: Mon, 22 Apr 2024 19:05:24 +0530
Message-ID: <20240422133524.1476394-1-sathishkumar.sundararaju@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099DF:EE_|MW6PR12MB8759:EE_
X-MS-Office365-Filtering-Correlation-Id: 9afc169c-e039-4cd1-a9f4-08dc62d119cf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?eDNONWUya1g5cVpPQ2tQMG5IK0hqLzZQUmhHODlLUS9Dbm9CaHRxWFlrS1pY?=
 =?utf-8?B?Zkh6TzRJckhrcDJRc1R3QzlpWVo0cGJsbVgxT09ZdVF4L3lNRkVVUTJ6aUhk?=
 =?utf-8?B?Sm9NSmFESkxLOHdCOHBVTjhTZmtNQngzZVBaZDVuV2lySGtRN0pTdWJheEgw?=
 =?utf-8?B?WktaQXA5dEhXNWxTRlA3aXRKTjBVeDJMR1l2RDZkeURaN0ZsS3ZFSmRtZ1lo?=
 =?utf-8?B?NkZrekhDV2tkbTlCSzRXOXRsU1RlcllXb1dPS0tmbGFKSDZxTFNrUDROMnhB?=
 =?utf-8?B?ZG82S0FUdTlOMWs4Z0lYMjI5ci9ocnpza0dkYUVQZk5Od1ROeFloOUtaYWFs?=
 =?utf-8?B?NDB6c1hYWVhGUXVGYSsyNVYvTkdzZENZSy9GcVpiZUtFdlZTSElwN2I5MDNm?=
 =?utf-8?B?eEswSEU4VGdJZW9iWFZhdjJCRG9kUEZwMnZBRzhxMCtyK1hRTEZ0Vk5zRkw0?=
 =?utf-8?B?NStjMGlEK3NhQldqNDc3ZkY3SWZBYTByUDJFNWVlRXhSVm9abHU0U2ovUzhJ?=
 =?utf-8?B?VzQxNGdCeDJyNWo1TVdIelRTS1JYM281T1h2WTJEbDBiaWJkQVd3VlJuSldN?=
 =?utf-8?B?ZU9YUDRTeHV6a1phamIwd0tkeVpmM2NLSUgzTFN0a2Z3Q3Y1UTJKU24rS1hs?=
 =?utf-8?B?WVhVNksxVFYxUkRDZWVhME1zQmpCYkJHZENYalJhaGw5cnMxV3d2UmlVODZC?=
 =?utf-8?B?K3VtbjdtN1BSL1dIbVFadktzT1Vva3dYYlJxM1k0YkRnbXhBcTVEd1FwMW1s?=
 =?utf-8?B?V1FoY3huWVJ3TlhYQ1A5WTJzbE5ueG85SGJ6cU5XVGcxMFZKcGFwYTFlanp1?=
 =?utf-8?B?ZGtlMHphSkw1Q040bnBZejVFcEViK0phYjNSU3B2WldKWVZLczRFdEpTOTgy?=
 =?utf-8?B?YjJpekp5WWFBNmY0VjkvaFBha3ZxUHZlZkZUbFNUY2pEZXo4WTRkRU9oaFRU?=
 =?utf-8?B?QlliVnNoUWROQTZ0Unh6ZHF6R0NWU1hEc1o3WGJHNGJYdnBLdEE2MTVtaTZP?=
 =?utf-8?B?endaSGU5Ums3OXpzTXUvaUVyMjE4WDZBb3hFM1daalczY0xFdllSTkVsRnJ1?=
 =?utf-8?B?dHJ6WDE2RERrM0ZUOTVDcm55SGZHK1VsSDQvdlNmVjZrY3hlaW04RGpGZXdJ?=
 =?utf-8?B?OTNvaXc3RWZveTJjSFR1eHBJWVd3VUMvTDJFSjJRUEVaOC8vcXJWbWtuWmYv?=
 =?utf-8?B?WmlRUVl3VU1WT0MzZmpwdzN0ek8yTVpXd1dCdGdyaE9OeWIrbnM3ZmhXb0tQ?=
 =?utf-8?B?eTdkSDdhRm44eVpVWkFwYXNqNVRwSHUzeStDeDJVdC9WNEJmVU1GUjlYMXY1?=
 =?utf-8?B?eTNnTkVKUng5M2pZMmRnUE5zZWtSVzl5V1p3RXNLdWF4UWNBM0loQXZFNG9m?=
 =?utf-8?B?Q3ZrcEJaaUFFbjhaOWE1eGpVc3lZSHJOOXZ5Q2N1Q2lZcTJDZ09mYmlpNkFD?=
 =?utf-8?B?dVVQMU11Snl6a3M2b1hXOUI3NWhiMjgzVkMrc28yeTVabkVGWFQ4V3prdDZ1?=
 =?utf-8?B?d2VwMUVkR1VkVnBUUzJvZUFob2E3U3AxS29vbnhmL3VmTW5jYU1GNC9EL1p1?=
 =?utf-8?B?amt2RTBZRVp5dFNWS0d3WVo1UFRhZXpyWEQxNCtBLytycDVoZW1FQkRGUkl6?=
 =?utf-8?B?ckdxeVhmR3BzdlNJWWxhTmNLcVVibjNOL2dLeCtycS81eHhKVDZGOTdiOFNN?=
 =?utf-8?B?RWIwRXorWGdkbkVFanNIcEVpcEZYMDlMdWQwMis0VjFrbU9ETncwK2lXaDBO?=
 =?utf-8?B?K2x5R01oeEJsVmtZcWVzZkRQUHNiL0UwZGhyV3VTN2tKRlBvYTJnanZDaVpU?=
 =?utf-8?B?cFNRY0k5Rlpwb2FJSURQYXphQXdLL05jOW9ZTGpOaHZUdWViL0J3TFFCZldr?=
 =?utf-8?Q?PzQplDotmB121?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(36860700004)(376005)(1800799015)(82310400014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2024 13:35:39.8150 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9afc169c-e039-4cd1-a9f4-08dc62d119cf
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099DF.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8759
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

jpeg ip version v2.1 and higher supports 16kx16k resolution decode

Signed-off-by: Sathishkumar S <sathishkumar.sundararaju@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/nv.c    | 6 +++---
 drivers/gpu/drm/amd/amdgpu/soc15.c | 4 ++--
 drivers/gpu/drm/amd/amdgpu/soc21.c | 4 ++--
 3 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/nv.c b/drivers/gpu/drm/amd/amdgpu/nv.c
index b5303cd3cb53..12e54047bf79 100644
--- a/drivers/gpu/drm/amd/amdgpu/nv.c
+++ b/drivers/gpu/drm/amd/amdgpu/nv.c
@@ -110,7 +110,7 @@ static const struct amdgpu_video_codec_info sc_video_codecs_decode_array_vcn0[]
 	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_MPEG4_AVC, 4096, 4096, 52)},
 	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_VC1, 4096, 4096, 4)},
 	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_HEVC, 8192, 4352, 186)},
-	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_JPEG, 4096, 4096, 0)},
+	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_JPEG, 16384, 16384, 0)},
 	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_VP9, 8192, 4352, 0)},
 	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_AV1, 8192, 4352, 0)},
 };
@@ -121,7 +121,7 @@ static const struct amdgpu_video_codec_info sc_video_codecs_decode_array_vcn1[]
 	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_MPEG4_AVC, 4096, 4096, 52)},
 	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_VC1, 4096, 4096, 4)},
 	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_HEVC, 8192, 4352, 186)},
-	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_JPEG, 4096, 4096, 0)},
+	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_JPEG, 16384, 16384, 0)},
 	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_VP9, 8192, 4352, 0)},
 };
 
@@ -199,7 +199,7 @@ static const struct amdgpu_video_codec_info yc_video_codecs_decode_array[] = {
 	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_MPEG4_AVC, 4096, 4096, 52)},
 	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_HEVC, 8192, 4352, 186)},
 	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_VP9, 8192, 4352, 0)},
-	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_JPEG, 4096, 4096, 0)},
+	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_JPEG, 16384, 16384, 0)},
 	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_AV1, 8192, 4352, 0)},
 };
 
diff --git a/drivers/gpu/drm/amd/amdgpu/soc15.c b/drivers/gpu/drm/amd/amdgpu/soc15.c
index a5d3c66b5868..170f02e96717 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc15.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc15.c
@@ -143,7 +143,7 @@ static const struct amdgpu_video_codec_info rn_video_codecs_decode_array[] =
 	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_MPEG4_AVC, 4096, 4096, 52)},
 	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_VC1, 4096, 4096, 4)},
 	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_HEVC, 8192, 4352, 186)},
-	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_JPEG, 4096, 4096, 0)},
+	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_JPEG, 16384, 16384, 0)},
 	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_VP9, 8192, 4352, 0)},
 };
 
@@ -156,7 +156,7 @@ static const struct amdgpu_video_codecs rn_video_codecs_decode =
 static const struct amdgpu_video_codec_info vcn_4_0_3_video_codecs_decode_array[] = {
 	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_MPEG4_AVC, 4096, 4096, 52)},
 	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_HEVC, 8192, 4352, 186)},
-	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_JPEG, 4096, 4096, 0)},
+	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_JPEG, 16384, 16384, 0)},
 	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_VP9, 8192, 4352, 0)},
 	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_AV1, 8192, 4352, 0)},
 };
diff --git a/drivers/gpu/drm/amd/amdgpu/soc21.c b/drivers/gpu/drm/amd/amdgpu/soc21.c
index 27c26e42120e..fb6797467571 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc21.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc21.c
@@ -72,7 +72,7 @@ static const struct amdgpu_video_codecs vcn_4_0_0_video_codecs_encode_vcn1 = {
 static const struct amdgpu_video_codec_info vcn_4_0_0_video_codecs_decode_array_vcn0[] = {
 	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_MPEG4_AVC, 4096, 4096, 52)},
 	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_HEVC, 8192, 4352, 186)},
-	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_JPEG, 4096, 4096, 0)},
+	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_JPEG, 16384, 16384, 0)},
 	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_VP9, 8192, 4352, 0)},
 	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_AV1, 8192, 4352, 0)},
 };
@@ -80,7 +80,7 @@ static const struct amdgpu_video_codec_info vcn_4_0_0_video_codecs_decode_array_
 static const struct amdgpu_video_codec_info vcn_4_0_0_video_codecs_decode_array_vcn1[] = {
 	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_MPEG4_AVC, 4096, 4096, 52)},
 	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_HEVC, 8192, 4352, 186)},
-	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_JPEG, 4096, 4096, 0)},
+	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_JPEG, 16384, 16384, 0)},
 	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_VP9, 8192, 4352, 0)},
 };
 
-- 
2.25.1

