Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F975C19776
	for <amd-gfx@archiver.kernel.org>; Fri, 28 Feb 2025 13:25:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E2FE810E2A1;
	Fri, 28 Feb 2025 13:25:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Dy4XAOC4";
	dkim-atps=neutral
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2060.outbound.protection.outlook.com [40.107.102.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B380510E2A1
 for <amd-gfx@lists.freedesktop.org>; Fri, 28 Feb 2025 13:25:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=siK8VkOe4QsRUnba/+SIw85cB4nhiCUPjRzru9NXGVp1qkL3FOVjhTa7dw+UOZ0Jgq9Ip6pyUo6ABS7H304u5RLnn1v/HhvgAOMWYeNYtqMv7Yxx3dsMFu2v0P9gVCw0+Q/UGtFp3asjXTqc9uuMlKAbDLHdlzgPmZsHJQV4f0URJ2xCzavcUajLVmDwIsxK4+1ljfq5yUYZ9LkBlxKXaYQiDh0IeFMmwkcI64BNmenafqrXSGDIdNQXei9OF7u08ewiyL6BHT7HvjYlwLz1/xYk+eNsNxFSETmCjeRAsAe3m+dyT3/PB7KPlwW3tzssKD5yp+ma7o6fCmprAqO+/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DYe/R2EIZTmY+jR0hNU0LTCfFDHN0zbNm3HvWm5O3uo=;
 b=Vxx508rnXh3xk5bGuXyIye/WLlxfh8gAH3APC1GWUdufujYeRJLf07KZSqKDyrsJcV3yAQKETh/ET32kn7x26f9E6vSACY4sxYWg6FsFQwvcCKybPOEO7sFXKQvJ0ijOd5cFzLRET5zU/f5MMOkCPLbf//VLs4i4yeU009AKvTlzG/p5mBxjTpFLS89NDre8mlTig1UwPzzKZr/k8M535iyQFtvMzQzC0GWk0FJq82nbee59RlCaoLvimgT5hFrq28LHDgwoKqERxnVXOMc/fwV4EebhBuEtOxoC2t2ePVZz93wavG3pFNvdeIdOSRmrz/wCFUOVdS2ApDDnWSkgMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DYe/R2EIZTmY+jR0hNU0LTCfFDHN0zbNm3HvWm5O3uo=;
 b=Dy4XAOC4CkImkFAsgQxRnPGoxeXD6INlyjGL53agE8740MOdF0lQwT622u4jUewIUSxtEasUaHv1pCQnQ0FYhOIeZdFtadRrfmxwa2BHKz1fjbrpNz4WvR0vsJBc3kHFlbdeaSw0XyXWDSXm27Aiq41xLJTnM0UgrFb9zGdpunY=
Received: from PH8PR07CA0010.namprd07.prod.outlook.com (2603:10b6:510:2cd::22)
 by LV3PR12MB9120.namprd12.prod.outlook.com (2603:10b6:408:1a3::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.22; Fri, 28 Feb
 2025 13:25:45 +0000
Received: from SA2PEPF000015C8.namprd03.prod.outlook.com
 (2603:10b6:510:2cd:cafe::43) by PH8PR07CA0010.outlook.office365.com
 (2603:10b6:510:2cd::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8489.21 via Frontend Transport; Fri,
 28 Feb 2025 13:25:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF000015C8.mail.protection.outlook.com (10.167.241.198) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8489.16 via Frontend Transport; Fri, 28 Feb 2025 13:25:44 +0000
Received: from work.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 28 Feb
 2025 07:25:43 -0600
From: David Rosca <david.rosca@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: David Rosca <david.rosca@amd.com>
Subject: [PATCH 3/4] drm/amdgpu: Remove JPEG from vega and carrizo video caps
Date: Fri, 28 Feb 2025 14:24:31 +0100
Message-ID: <20250228132429.4842-6-david.rosca@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250228132429.4842-4-david.rosca@amd.com>
References: <20250228132429.4842-4-david.rosca@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF000015C8:EE_|LV3PR12MB9120:EE_
X-MS-Office365-Filtering-Correlation-Id: e13c85e6-1a70-45ea-f673-08dd57fb67fd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?NARZau0tLMpC2VFhqZnvfDqumK2NdvWtZxNQ20NRcfGrs+tXzA1ruKBOdUaT?=
 =?us-ascii?Q?XnjIsYRVU83TVotF7CPtOvTIZMjCq8GpZhcA+QD+BUp720Gs1nc3Rj+rwJLW?=
 =?us-ascii?Q?3LiwUlj+DMow8a7x7/b87BHAhl8UaWG33OuxMhyJyzj3JCD+i919ZXUxcJVd?=
 =?us-ascii?Q?orqsCiaUi4AZcGnGovwj8lSROjrtKo1wojgHDR746VrFQCmqter8jNibYQX5?=
 =?us-ascii?Q?yQcwCh0hNDtULl2P+rtAPE0s1u1FhDu6zBtzbBrwWWHm1swJqrw7CbLa6Mhz?=
 =?us-ascii?Q?D7Y6VyKZSx+y6cc2RyGZFIt7HsDCRBnfNhXIx9K759JTfx7C6wQRARpEC8gR?=
 =?us-ascii?Q?bCVv/u8QBvqC4WKedyuuq8+s13bO2DFAwLIseAPE8MIfcBKme+hdC0WlXVM3?=
 =?us-ascii?Q?6BzK7msSsQs3nDNrMDowQXIn84ytOy1uGE56eL++uS5Kt3vrQUqd1mcLa4dA?=
 =?us-ascii?Q?Njdo3sM8/ofpwwh+0QhRHNVRxBIH1BkMYzBsRHgTHPy8rDWhiND3P71aTZxu?=
 =?us-ascii?Q?K5Jg6Pmg+vIeJdZ3bh1bvgQML3bMT55+I6Qs1fsFDQxeZMPSWpY8wPTJs0eQ?=
 =?us-ascii?Q?4qPZRO6Aj9op+x742UbbjnnFaX6J4hxdCC+ZAuE45+GlZyteA8VZ1kInwBFc?=
 =?us-ascii?Q?EZCHl52t1eWcx6OkkfCaYPBoppvksuwELIKlQhO3aWDy6T+0bJIIWZ+xGn2P?=
 =?us-ascii?Q?KG4WBfup0DnosZ7dtGUQNRwIazBOl7tU40M7tbbRWq9L2JIvd706MiSwY7uz?=
 =?us-ascii?Q?Y2DPgAgsKvfvIkuiRR6iCUs00jPp1DfP08yoYTRBoo0VvQkg8RH0DbeJULJz?=
 =?us-ascii?Q?xITzpJBjHzVVoqWF/ZAyyA0TOwDWTc2CAP5fApIlqOyFknuQiyC8Vs9SIFxl?=
 =?us-ascii?Q?paJYmBwmxJulJ3pVq0hbCGDw4KdOpcEk6VkvH/UTAfFlCyb3L6/e2aqN9Ovx?=
 =?us-ascii?Q?K+JGF+RwsaXg/XSmo1Uon9lt2+aVAYj78P0EIvtgwMQfUDG+zEb6ZSQ1+cVW?=
 =?us-ascii?Q?x8Zb9EUMFF6Ed2ITjrBJliCtmKbSQk7FMiC/us52udlC68h7pooQqqbV199+?=
 =?us-ascii?Q?qI9q50+zz1/ZEjp05zgaz6MN1sRLpsmnxbQ6EGuNWimksmptd0rMaQWfHq/k?=
 =?us-ascii?Q?kWVZg3Z41ZoCr6NO7snXmWcworVhVig6C8kI7zSDu6GLebu2X9QlS3TyCU+k?=
 =?us-ascii?Q?yW2wIgAsIn2KhWlMx2C07fBNwwfCg4rzBCDqXEwBv2Ah6IGvTCDwhk5iM9aM?=
 =?us-ascii?Q?mvx345bt5B0pK7dhzkZusjBCH5pqb2GC80iZn2wo/BjSyiF+0VFOUlQVe1h8?=
 =?us-ascii?Q?OcYRXtmH6R5fl4OFVor2KmeEjyHDQjtq8eSLWLeSFb/MwIXViLGVMLyUi1fO?=
 =?us-ascii?Q?aVW3+Ng0e9ewMk+h1q3YBASmVB0JHK5iu4ndyHPEtp0Z+KTcYTeJpYZKNu9e?=
 =?us-ascii?Q?0fK64l4FQvbGMmkmy7Pj2LFUr9iiLcZlAcS1O5bGST0qnfdnzodQNT7HfVLw?=
 =?us-ascii?Q?fiC1X+W+rqwYEHQ=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2025 13:25:44.8801 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e13c85e6-1a70-45ea-f673-08dd57fb67fd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF000015C8.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9120
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

JPEG is only supported for VCN1+.

Signed-off-by: David Rosca <david.rosca@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/soc15.c | 1 -
 drivers/gpu/drm/amd/amdgpu/vi.c    | 7 -------
 2 files changed, 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/soc15.c b/drivers/gpu/drm/amd/amdgpu/soc15.c
index f01176da8b3e..d5d3f9e945c4 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc15.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc15.c
@@ -107,7 +107,6 @@ static const struct amdgpu_video_codec_info vega_video_codecs_decode_array[] =
 	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_MPEG4_AVC, 4096, 4096, 52)},
 	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_VC1, 4096, 4096, 4)},
 	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_HEVC, 4096, 4096, 186)},
-	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_JPEG, 4096, 4096, 0)},
 };
 
 static const struct amdgpu_video_codecs vega_video_codecs_decode =
diff --git a/drivers/gpu/drm/amd/amdgpu/vi.c b/drivers/gpu/drm/amd/amdgpu/vi.c
index 9b3510e53112..86d8bc10d90a 100644
--- a/drivers/gpu/drm/amd/amdgpu/vi.c
+++ b/drivers/gpu/drm/amd/amdgpu/vi.c
@@ -239,13 +239,6 @@ static const struct amdgpu_video_codec_info cz_video_codecs_decode_array[] =
 		.max_pixels_per_frame = 4096 * 4096,
 		.max_level = 186,
 	},
-	{
-		.codec_type = AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_JPEG,
-		.max_width = 4096,
-		.max_height = 4096,
-		.max_pixels_per_frame = 4096 * 4096,
-		.max_level = 0,
-	},
 };
 
 static const struct amdgpu_video_codecs cz_video_codecs_decode =
-- 
2.43.0

