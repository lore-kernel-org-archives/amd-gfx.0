Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F91DE7719A
	for <amd-gfx@archiver.kernel.org>; Thu,  9 Jan 2025 03:04:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9FAA010E97F;
	Thu,  9 Jan 2025 03:04:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="YA8CuCWv";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2045.outbound.protection.outlook.com [40.107.237.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5AAAF10E981
 for <amd-gfx@lists.freedesktop.org>; Thu,  9 Jan 2025 03:04:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pVJAYvHufYH/9K9I/ybandQG1RAFkp+nSCmYAwypXmI/4BXviUPuzbEj92e1bnNTepMy5OW0oQeSZW4CJMfxfz0VGhqtofhkv9Vf42VgidxoJ6s3Ox7gmtNViYWq7HGWdkDEJelpEomc/QBIV/UJed1UqW1huFZ4iLMF+p0r37VfDRw8UJiPTdu7wx8iZU0mL68upO3BdsppmrIWXeI01O/rl5yCOjyc2VewRXE+SLU70nVfUbVkF6BYy0HNztx9WK4V2Cj38s655JZRLL0XO46zXAjhGX3TNa+kybgHHRM/2DYSgNjaultd3BVM+OCSwx/ktfqnq8Zc3vw1H0SCjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CD2IVibMowOPogrRQC/ru029kHUgu48ESbiAbFC9X5k=;
 b=E2JPAr61h5j8smbtnq81VGV5p6NVTu556F0rddZD563zOqhppZcP4FahOHrZ5yjaIeEV9dn8SWsAu6wr98eEiKDYxbYzi5XsxjG+kMoVIt4FA2w4v2DOFIu9dCeAH5X9jGrfw0Twlwz3CXvxZdzCi03xb3Gm3kv2KkFm8sq65LpQ+hs0/OuSCN0nuArk5GMIFKsPuFw71LXHEhlCyY1sRlkjsRsFn4Pl1FWlE9YgoPeyE08NCdgRhuHqOvNJ2j5tQOR8pjFrhj371UQmDrHCEV+5oNrNmbx9GAr3VpCEfrAStSVn7443vtpEZtBudInDqkxcLJHkFgv0aF2RJ+b2Vg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CD2IVibMowOPogrRQC/ru029kHUgu48ESbiAbFC9X5k=;
 b=YA8CuCWv5ezh809RvGtSXyWl6TeatNdiI6X/lE8s7qPmgHRip7vi1xO4CuwsJ8kyul0LlFoBBV5flA1VI6625nYAEdGI0xBPXrWaWkxcu8FnbGhM9Ku7/ecqpxEd0lkFRPWmJdrmbhadarKLtB18n29qznvVwc8oBqlaCqcYNVA=
Received: from BL0PR0102CA0048.prod.exchangelabs.com (2603:10b6:208:25::25) by
 PH7PR12MB8425.namprd12.prod.outlook.com (2603:10b6:510:240::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.10; Thu, 9 Jan
 2025 03:04:06 +0000
Received: from BL6PEPF00022572.namprd02.prod.outlook.com
 (2603:10b6:208:25:cafe::e5) by BL0PR0102CA0048.outlook.office365.com
 (2603:10b6:208:25::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8335.11 via Frontend Transport; Thu,
 9 Jan 2025 03:04:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF00022572.mail.protection.outlook.com (10.167.249.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8335.7 via Frontend Transport; Thu, 9 Jan 2025 03:04:05 +0000
Received: from ldev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 8 Jan
 2025 21:02:58 -0600
From: Tim Huang <tim.huang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <Yifan1.zhang@amd.com>,
 <Xiaojian.Du@amd.com>, Tim Huang <tim.huang@amd.com>, Yifan Zhang
 <yifan1.zhang@amd.com>
Subject: [PATCH 1/7] drm/amdgpu: add support for GC IP version 11.5.3
Date: Thu, 9 Jan 2025 11:01:27 +0800
Message-ID: <20250109030133.3887086-1-tim.huang@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00022572:EE_|PH7PR12MB8425:EE_
X-MS-Office365-Filtering-Correlation-Id: 6bfd2930-bf09-46f4-eeba-08dd305a4752
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?59/Co91+enh44cZItKijatPSfCCsZ7colfBlzIvWrYa+lGdcfTKXfJEp3YuP?=
 =?us-ascii?Q?KfKVj0TjIX2k2lXZpLac+9QPijTLl9ZfpIXgTD0kFiJ6Ihj2zv1WAyO5NTrB?=
 =?us-ascii?Q?88KqOX8CtfrMMATamveTd83NmkW6JuaSPmbNU+Bl0HUHf6egTinlrMYKNdG0?=
 =?us-ascii?Q?MYtsrL9Dr/aJlRdr6NHwS+jKkT0cf1T9HGj1vmyoAdsG2N6DdyQ+zlJEpPdo?=
 =?us-ascii?Q?qZOJEKq17B1bCN9IKG7XYcD1FVbtBqdnYOcIfMJUAPUB/rYrjHUcB0hD6gMZ?=
 =?us-ascii?Q?LKZN7AGpzMD2agDhhVyoG1653cqMmB6/BCMdh4GcAhDJY/Tferi3eg2lzEXM?=
 =?us-ascii?Q?0sfah/d8WwUUMM3IXdUUUpUmPBeDL5LSkqSPZGflNGv2veplB0RBVQDl42na?=
 =?us-ascii?Q?d7HQZ0owp+TSKNJ+J5aK0R9yONK/ASn1iK2ujVIcHefrtTUt8kXFC7syqzMO?=
 =?us-ascii?Q?HtSkRJBImgzSvj79Q2EK01ajCI+NsUaqVy2fg4WKFJ4+MqbAf8ZN+V8Csxcv?=
 =?us-ascii?Q?irzNp0WWVA6+xALBK5YxOMl0pNe2/mi7rdXy8WnxK8opkpFMEhDh3ovP3Re/?=
 =?us-ascii?Q?CJe6Lurvy38oXb5XGqG3IOBRLpq25sJKleXI1Ot88vKTOWr5oj9vwmwicTKu?=
 =?us-ascii?Q?tSM+9rbUYR9fAtZZdj72u3zR4o2RTiH9xpuDXuAgDMqWTHR8ijszplyoNFAv?=
 =?us-ascii?Q?E1/TtQsF2LvKqTakmdS89q3hk48pP3VRLSbE6RpAI1qAUKl76iQOK053hasm?=
 =?us-ascii?Q?k+Nf2ueKgpuLAgbjdrWnr3/WCQHbESYUccRMCwM1T4H45ifkJP6a4xsxZyYu?=
 =?us-ascii?Q?e9i23SvtaX/+7HoKAzOd1nOzRyZxqghQwfKyZM3NYXUr069h+4lZOou5wHBZ?=
 =?us-ascii?Q?mUiTOq2OY6DOOmdPYoJuZMnaZNhBWkSOtNAgwRsyhM1gK+2ygR38Dp/TSX7T?=
 =?us-ascii?Q?Os4dD+Tk/c39EwEwrdt5WQaPIerWMKg1IB+VNrSJqDCWL1UCn6sva3Z3pAIg?=
 =?us-ascii?Q?XgH3u0c4TpX8NKYH9AP+fOi6i3R6lZHJ0BHw6Fk0Y0QONn5BkwfHxXSeEnQS?=
 =?us-ascii?Q?pSzmJzLkVVGnBJ18lhQZPR3cRNcYqsMtcbSak4olZoaDx73ho9qFNf01Lt9v?=
 =?us-ascii?Q?A/0u2RNIzbyiLyChZSciYnEnpM5D7PHXDPXI5q3D/e+GwT4nBcJINZYjuLDv?=
 =?us-ascii?Q?hS7BaNr1obfj9Au97etytf5nwfWaQrGFXQ4joVZLB38GQ+rzmm3LRqhWc4Fl?=
 =?us-ascii?Q?bo0K9QwohsdeqKPcazvD5dF700zET/IcZ3gbB0FExGFW1+onvx6aHoyAjVEe?=
 =?us-ascii?Q?JEgXVPqi7kLeR+l//cOE4obvStyXU0IFnkXm6z/SN3VPKtiCsk1ZrOmVoHy0?=
 =?us-ascii?Q?A0vMShCRZc+BvwK2P5BBxAi0P5pEO0nOaBITqkJEEzRe3g6OJ/WQmhRc+Aa6?=
 =?us-ascii?Q?YGO5hWWz7yzh1yJpmd3PWMXjK75b8TMdvwAKkHh83wzwmj3MlhVAoPimjDHR?=
 =?us-ascii?Q?DZZd44sqiffKSCQ=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jan 2025 03:04:05.7504 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6bfd2930-bf09-46f4-eeba-08dd305a4752
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF00022572.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8425
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

This initializes GC IP version 11.5.3.

Signed-off-by: Tim Huang <tim.huang@amd.com>
Reviewed-by: Yifan Zhang <yifan1.zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c |  6 +++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c       |  1 +
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c        | 12 +++++++++-
 drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c        |  2 ++
 drivers/gpu/drm/amd/amdgpu/imu_v11_0.c        |  1 +
 drivers/gpu/drm/amd/amdgpu/mes_v11_0.c        |  2 ++
 drivers/gpu/drm/amd/amdgpu/soc21.c            | 22 +++++++++++++++++++
 drivers/gpu/drm/amd/amdkfd/kfd_crat.c         |  1 +
 drivers/gpu/drm/amd/amdkfd/kfd_device.c       |  5 +++++
 9 files changed, 51 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
index 949d74eff294..ea31418a479b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
@@ -1864,6 +1864,7 @@ static int amdgpu_discovery_set_common_ip_blocks(struct amdgpu_device *adev)
 	case IP_VERSION(11, 5, 0):
 	case IP_VERSION(11, 5, 1):
 	case IP_VERSION(11, 5, 2):
+	case IP_VERSION(11, 5, 3):
 		amdgpu_device_ip_block_add(adev, &soc21_common_ip_block);
 		break;
 	case IP_VERSION(12, 0, 0):
@@ -1919,6 +1920,7 @@ static int amdgpu_discovery_set_gmc_ip_blocks(struct amdgpu_device *adev)
 	case IP_VERSION(11, 5, 0):
 	case IP_VERSION(11, 5, 1):
 	case IP_VERSION(11, 5, 2):
+	case IP_VERSION(11, 5, 3):
 		amdgpu_device_ip_block_add(adev, &gmc_v11_0_ip_block);
 		break;
 	case IP_VERSION(12, 0, 0):
@@ -2215,6 +2217,7 @@ static int amdgpu_discovery_set_gc_ip_blocks(struct amdgpu_device *adev)
 	case IP_VERSION(11, 5, 0):
 	case IP_VERSION(11, 5, 1):
 	case IP_VERSION(11, 5, 2):
+	case IP_VERSION(11, 5, 3):
 		amdgpu_device_ip_block_add(adev, &gfx_v11_0_ip_block);
 		break;
 	case IP_VERSION(12, 0, 0):
@@ -2393,6 +2396,7 @@ static int amdgpu_discovery_set_mes_ip_blocks(struct amdgpu_device *adev)
 	case IP_VERSION(11, 5, 0):
 	case IP_VERSION(11, 5, 1):
 	case IP_VERSION(11, 5, 2):
+	case IP_VERSION(11, 5, 3):
 		amdgpu_device_ip_block_add(adev, &mes_v11_0_ip_block);
 		adev->enable_mes = true;
 		adev->enable_mes_kiq = true;
@@ -2708,6 +2712,7 @@ int amdgpu_discovery_set_ip_blocks(struct amdgpu_device *adev)
 	case IP_VERSION(11, 5, 0):
 	case IP_VERSION(11, 5, 1):
 	case IP_VERSION(11, 5, 2):
+	case IP_VERSION(11, 5, 3):
 		adev->family = AMDGPU_FAMILY_GC_11_5_0;
 		break;
 	case IP_VERSION(12, 0, 0):
@@ -2733,6 +2738,7 @@ int amdgpu_discovery_set_ip_blocks(struct amdgpu_device *adev)
 	case IP_VERSION(11, 5, 0):
 	case IP_VERSION(11, 5, 1):
 	case IP_VERSION(11, 5, 2):
+	case IP_VERSION(11, 5, 3):
 		adev->flags |= AMD_IS_APU;
 		break;
 	default:
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
index 1c19a65e6553..2667a183e9c5 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
@@ -851,6 +851,7 @@ void amdgpu_gmc_tmz_set(struct amdgpu_device *adev)
 	case IP_VERSION(11, 5, 0):
 	case IP_VERSION(11, 5, 1):
 	case IP_VERSION(11, 5, 2):
+	case IP_VERSION(11, 5, 3):
 		/* Don't enable it by default yet.
 		 */
 		if (amdgpu_tmz < 1) {
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
index 990203b15ec5..25641677cae2 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -100,6 +100,10 @@ MODULE_FIRMWARE("amdgpu/gc_11_5_2_pfp.bin");
 MODULE_FIRMWARE("amdgpu/gc_11_5_2_me.bin");
 MODULE_FIRMWARE("amdgpu/gc_11_5_2_mec.bin");
 MODULE_FIRMWARE("amdgpu/gc_11_5_2_rlc.bin");
+MODULE_FIRMWARE("amdgpu/gc_11_5_3_pfp.bin");
+MODULE_FIRMWARE("amdgpu/gc_11_5_3_me.bin");
+MODULE_FIRMWARE("amdgpu/gc_11_5_3_mec.bin");
+MODULE_FIRMWARE("amdgpu/gc_11_5_3_rlc.bin");
 
 static const struct amdgpu_hwip_reg_entry gc_reg_list_11_0[] = {
 	SOC15_REG_ENTRY_STR(GC, 0, regGRBM_STATUS),
@@ -1096,6 +1100,7 @@ static int gfx_v11_0_gpu_early_init(struct amdgpu_device *adev)
 	case IP_VERSION(11, 5, 0):
 	case IP_VERSION(11, 5, 1):
 	case IP_VERSION(11, 5, 2):
+	case IP_VERSION(11, 5, 3):
 		adev->gfx.config.max_hw_contexts = 8;
 		adev->gfx.config.sc_prim_fifo_size_frontend = 0x20;
 		adev->gfx.config.sc_prim_fifo_size_backend = 0x100;
@@ -1581,6 +1586,7 @@ static int gfx_v11_0_sw_init(struct amdgpu_ip_block *ip_block)
 	case IP_VERSION(11, 5, 0):
 	case IP_VERSION(11, 5, 1):
 	case IP_VERSION(11, 5, 2):
+	case IP_VERSION(11, 5, 3):
 		adev->gfx.me.num_me = 1;
 		adev->gfx.me.num_pipe_per_me = 1;
 		adev->gfx.me.num_queue_per_pipe = 1;
@@ -2943,7 +2949,8 @@ static int gfx_v11_0_wait_for_rlc_autoload_complete(struct amdgpu_device *adev)
 			    IP_VERSION(11, 0, 4) ||
 		    amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(11, 5, 0) ||
 		    amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(11, 5, 1) ||
-		    amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(11, 5, 2))
+		    amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(11, 5, 2) ||
+		    amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(11, 5, 3))
 			bootload_status = RREG32_SOC15(GC, 0,
 					regRLC_RLCS_BOOTLOAD_STATUS_gc_11_0_1);
 		else
@@ -5479,6 +5486,7 @@ static void gfx_v11_cntl_power_gating(struct amdgpu_device *adev, bool enable)
 		case IP_VERSION(11, 5, 0):
 		case IP_VERSION(11, 5, 1):
 		case IP_VERSION(11, 5, 2):
+		case IP_VERSION(11, 5, 3):
 			WREG32_SOC15(GC, 0, regRLC_PG_DELAY_3, RLC_PG_DELAY_3_DEFAULT_GC_11_0_1);
 			break;
 		default:
@@ -5516,6 +5524,7 @@ static int gfx_v11_0_set_powergating_state(struct amdgpu_ip_block *ip_block,
 	case IP_VERSION(11, 5, 0):
 	case IP_VERSION(11, 5, 1):
 	case IP_VERSION(11, 5, 2):
+	case IP_VERSION(11, 5, 3):
 		if (!enable)
 			amdgpu_gfx_off_ctrl(adev, false);
 
@@ -5549,6 +5558,7 @@ static int gfx_v11_0_set_clockgating_state(struct amdgpu_ip_block *ip_block,
 	case IP_VERSION(11, 5, 0):
 	case IP_VERSION(11, 5, 1):
 	case IP_VERSION(11, 5, 2):
+	case IP_VERSION(11, 5, 3):
 	        gfx_v11_0_update_gfx_clock_gating(adev,
 	                        state ==  AMD_CG_STATE_GATE);
 	        break;
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
index 72751ab4c766..5047b80ab60c 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
@@ -596,6 +596,7 @@ static void gmc_v11_0_set_gfxhub_funcs(struct amdgpu_device *adev)
 	case IP_VERSION(11, 5, 0):
 	case IP_VERSION(11, 5, 1):
 	case IP_VERSION(11, 5, 2):
+	case IP_VERSION(11, 5, 3):
 		adev->gfxhub.funcs = &gfxhub_v11_5_0_funcs;
 		break;
 	default:
@@ -759,6 +760,7 @@ static int gmc_v11_0_sw_init(struct amdgpu_ip_block *ip_block)
 	case IP_VERSION(11, 5, 0):
 	case IP_VERSION(11, 5, 1):
 	case IP_VERSION(11, 5, 2):
+	case IP_VERSION(11, 5, 3):
 		set_bit(AMDGPU_GFXHUB(0), adev->vmhubs_mask);
 		set_bit(AMDGPU_MMHUB0(0), adev->vmhubs_mask);
 		/*
diff --git a/drivers/gpu/drm/amd/amdgpu/imu_v11_0.c b/drivers/gpu/drm/amd/amdgpu/imu_v11_0.c
index aeca5c08ea2f..cfa91d709d49 100644
--- a/drivers/gpu/drm/amd/amdgpu/imu_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/imu_v11_0.c
@@ -39,6 +39,7 @@ MODULE_FIRMWARE("amdgpu/gc_11_0_4_imu.bin");
 MODULE_FIRMWARE("amdgpu/gc_11_5_0_imu.bin");
 MODULE_FIRMWARE("amdgpu/gc_11_5_1_imu.bin");
 MODULE_FIRMWARE("amdgpu/gc_11_5_2_imu.bin");
+MODULE_FIRMWARE("amdgpu/gc_11_5_3_imu.bin");
 
 static int imu_v11_0_init_microcode(struct amdgpu_device *adev)
 {
diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
index bb57ca8d24f1..bf51f3dcc130 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
@@ -54,6 +54,8 @@ MODULE_FIRMWARE("amdgpu/gc_11_5_1_mes_2.bin");
 MODULE_FIRMWARE("amdgpu/gc_11_5_1_mes1.bin");
 MODULE_FIRMWARE("amdgpu/gc_11_5_2_mes_2.bin");
 MODULE_FIRMWARE("amdgpu/gc_11_5_2_mes1.bin");
+MODULE_FIRMWARE("amdgpu/gc_11_5_3_mes_2.bin");
+MODULE_FIRMWARE("amdgpu/gc_11_5_3_mes1.bin");
 
 static int mes_v11_0_hw_init(struct amdgpu_ip_block *ip_block);
 static int mes_v11_0_hw_fini(struct amdgpu_ip_block *ip_block);
diff --git a/drivers/gpu/drm/amd/amdgpu/soc21.c b/drivers/gpu/drm/amd/amdgpu/soc21.c
index 62ad67d0b598..ba889a85cdc5 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc21.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc21.c
@@ -781,6 +781,28 @@ static int soc21_common_early_init(struct amdgpu_ip_block *ip_block)
 			AMD_PG_SUPPORT_GFX_PG;
 		adev->external_rev_id = adev->rev_id + 0x40;
 		break;
+	case IP_VERSION(11, 5, 3):
+		adev->cg_flags = AMD_CG_SUPPORT_GFX_CGCG |
+			AMD_CG_SUPPORT_GFX_CGLS |
+			AMD_CG_SUPPORT_GFX_MGCG |
+			AMD_CG_SUPPORT_GFX_FGCG |
+			AMD_CG_SUPPORT_REPEATER_FGCG |
+			AMD_CG_SUPPORT_GFX_PERF_CLK |
+			AMD_CG_SUPPORT_GFX_3D_CGCG |
+			AMD_CG_SUPPORT_GFX_3D_CGLS |
+			AMD_CG_SUPPORT_MC_MGCG |
+			AMD_CG_SUPPORT_MC_LS |
+			AMD_CG_SUPPORT_HDP_LS |
+			AMD_CG_SUPPORT_HDP_DS |
+			AMD_CG_SUPPORT_HDP_SD |
+			AMD_CG_SUPPORT_ATHUB_MGCG |
+			AMD_CG_SUPPORT_ATHUB_LS |
+			AMD_CG_SUPPORT_IH_CG |
+			AMD_CG_SUPPORT_BIF_MGCG |
+			AMD_CG_SUPPORT_BIF_LS;
+		adev->pg_flags = AMD_PG_SUPPORT_GFX_PG;
+		adev->external_rev_id = adev->rev_id + 0x50;
+		break;
 	default:
 		/* FIXME: not supported yet */
 		return -EINVAL;
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c b/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
index 693469c18c60..70b3ae0b74fe 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
@@ -1704,6 +1704,7 @@ int kfd_get_gpu_cache_info(struct kfd_node *kdev, struct kfd_gpu_cache_info **pc
 		case IP_VERSION(11, 5, 0):
 		case IP_VERSION(11, 5, 1):
 		case IP_VERSION(11, 5, 2):
+		case IP_VERSION(11, 5, 3):
 			/* Cacheline size not available in IP discovery for gc11.
 			 * kfd_fill_gpu_cache_info_from_gfx_config to hard code it
 			 */
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
index a29374c86405..b5d70d803289 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
@@ -180,6 +180,7 @@ static void kfd_device_info_set_event_interrupt_class(struct kfd_dev *kfd)
 	case IP_VERSION(11, 5, 0):
 	case IP_VERSION(11, 5, 1):
 	case IP_VERSION(11, 5, 2):
+	case IP_VERSION(11, 5, 3):
 		kfd->device_info.event_interrupt_class = &event_interrupt_class_v11;
 		break;
 	case IP_VERSION(12, 0, 0):
@@ -454,6 +455,10 @@ struct kfd_dev *kgd2kfd_probe(struct amdgpu_device *adev, bool vf)
 			gfx_target_version = 110502;
 			f2g = &gfx_v11_kfd2kgd;
 			break;
+		case IP_VERSION(11, 5, 3):
+			gfx_target_version = 110503;
+			f2g = &gfx_v11_kfd2kgd;
+			break;
 		case IP_VERSION(12, 0, 0):
 			gfx_target_version = 120000;
 			f2g = &gfx_v12_kfd2kgd;
-- 
2.43.0

