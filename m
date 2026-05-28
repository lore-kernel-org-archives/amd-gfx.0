Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE1B2CD5BD5
	for <amd-gfx@archiver.kernel.org>; Thu, 28 May 2026 06:42:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7BC1810ECB1;
	Thu, 28 May 2026 06:42:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="i57Hoids";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011069.outbound.protection.outlook.com [52.101.62.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 06BB210ECAD
 for <amd-gfx@lists.freedesktop.org>; Thu, 28 May 2026 06:42:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UbFhEVuKAfSR818PeyQDspG5i8Zjy4yJpPJFsKDcp9l2kX/qFz1o4gnCVfjcZfkRYePctVkZW6ivj9AeVnj6KIXF8gIdZE9TxOVGH7tQ5snOc75K0l7rDbRG6Am6/2gc4aEIMN8APMo3YYvS1NgV/tWh6arbzGoSILdA4YJbNGd/Mrw+nKD2tyq24rSJW/PrIf77fQErxTcsH1C3+cA/WjTlulkUYwpaEBiyrrzHDDoTr1evIDDjqU6EuJnxBox4muj+sLNvBV76eUy68q4F3IgN18XcQGnrDzOSqK2zFWYqoQ5Mf2Z6ebrFLee4CTYae+CP7aveT1YcWi2aqsTM+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pPBeo3fKWqGGfQxVIkawRn1BZpdUgPr9cp8qJHIM1AE=;
 b=pTTBuot7kHGDEdObo1KQH5lHs6nbcn7MQAJLT5DqT4KT/KzDXhbBJ4XlHvZG3wRFLuWJnbqg4MF8UKJfbt4En7WBTabkF8ZtD9O9yEdTo5+xzF4RH0g7B5TtZNA8gROmdSX/poWs9gdrbNVqkcuHWAxwCxs5w3dEkmT3mwlcOtEbmUIFBlQDNBCkMigHUZy10hBbUEciEliZu9QuXLj+l7ymor9wXYcuPPjo6REEkoEPlK7nSzVBjRZG8Yc+EuspWyq1akyUZSdVPhe6yyoDF/g4SCKDNXypCSGesDEAFms/drPAyHanEkUQQkze299scxAIylz7eLwmBk1ClSlAeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pPBeo3fKWqGGfQxVIkawRn1BZpdUgPr9cp8qJHIM1AE=;
 b=i57HoidsZoY61LV9/bVi/nD1PP28EdSq5oN7n9PuR5Tp8KhRYCoV/FXS38vRu6eg6uzI/aJge0rsp0CKypxvwoB2zs6v0ZlbdyMuim2aq4RRHLQmG2HI4Da1QFvkjszgPIsISVd/DyAQawsc1pNnytDIhMmCtLlc0x6sAqKJk+4=
Received: from BL1PR13CA0094.namprd13.prod.outlook.com (2603:10b6:208:2b9::9)
 by MW5PR12MB5623.namprd12.prod.outlook.com (2603:10b6:303:199::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.13; Thu, 28 May
 2026 06:42:28 +0000
Received: from BL6PEPF0001AB73.namprd02.prod.outlook.com
 (2603:10b6:208:2b9:cafe::9a) by BL1PR13CA0094.outlook.office365.com
 (2603:10b6:208:2b9::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.92.4 via Frontend Transport; Thu, 28
 May 2026 06:42:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF0001AB73.mail.protection.outlook.com (10.167.242.166) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.71.7 via Frontend Transport; Thu, 28 May 2026 06:42:27 +0000
Received: from BLRPVISHWAK.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 28 May
 2026 01:42:26 -0500
From: Pratik Vishwakarma <Pratik.Vishwakarma@amd.com>
To: <Alexander.Deucher@amd.com>, <amd-gfx@lists.freedesktop.org>
CC: Pratik Vishwakarma <Pratik.Vishwakarma@amd.com>
Subject: [PATCH 1/8] drm/amdgpu: Add support for GC IP version 11.5.6
Date: Thu, 28 May 2026 06:41:59 +0000
Message-ID: <20260528064206.12358-1-Pratik.Vishwakarma@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB73:EE_|MW5PR12MB5623:EE_
X-MS-Office365-Filtering-Correlation-Id: bc0be36f-0152-4fa0-a29a-08debc8448e0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|1800799024|376014|82310400026|11063799006|56012099006|18002099003;
X-Microsoft-Antispam-Message-Info: IQmGQ94SaWeUKeioVP2xUkX93C0sRymF7KuvL+QXMZ2+d4QptOJS/VSc4IUiZNFTKrxyJB7hmD1rEAW7+KvY+Eligu5ayJot2GvVZ9Chiu477zP+3TZqQLOSPDIZZRlUFK2ZJ2fauz63zbsLXgN1k5EV152W1C8y9Vsh7+x0wH6v/kLcRfT+uffI6DAouXkmmxCr5wmtcaddbrwivdvmCdTvH8/we0XqwXHN7qOLPqConGR9DM3LfvPCx1F7O9D6AxbPgvPeZs6Y12dZgAcg2ml3YwwTuBy4j+7xA9p4bgoDSyBDVuATMB+ppBZGvtZBLlzOoqe7eynGXsOpIJPq4XZ9BtBgjXxubZ6eJVip9fU3iH+u1eRplaBmTdN7iqpTMFX/2dHOApbgsNWNxAoqhfzWi1jlXcnte8ztYnzGfbLLM/LBuGhztOnRlf84Ioil4lGvNTRU3V4FwqaGH3oN5VbZt4zcfxcyhKqkTQQlxGRFKvl17ztvkxJz5kGG6IeM7NX6STk0WtOBn5ZL/q7qcQ8PoSbygaiVJrGwx6v1bnIRJamHYzH2Ed2mxxBJkIM1wc/5xgQeSGnQ9PEQjPuMeiP89jofS8GlTWX2rJexyiD7RCkMwx/LPmZCv7DyCicPUk9OGz+k8Lzyzi2ykNGRg0NWpIWzTjTKscgLL/gT8y/2oNfc0vz3/3y+rrXn3GpyNpe2DdN8zHKmZ155cegfLhGiWsdstO/59xdTD8Zws58=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(1800799024)(376014)(82310400026)(11063799006)(56012099006)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: UTgpTewLhv8xk6VxUsLGzQ8tiIweCTdIoSOJw+6amDDL3NvyTEpHO6+FDGdFEoa4TP5Xwg0shs11tQSbzJa6EpWxlBDINWE/0imXqPTMs2lD/Xng2NhghAmvHNG+jA6eqlzJ/cAakJUDN0YfWq4C9KCeP1Cb6Uuv1dj4asXIS6j5yk53kJAzORGEVDBOkTHXhG8JnrswfO4oqOW+tUkwFGjVxqdWFnSt3OBlkZn0xFwgIm9fpT0fdFOBwSDOIsG7QOI7DSqGVPBncpJDNZDvwA7IKEyRCqudF/ITw/xQdOloaQuxHzsu6zeIORFSOLRc8P2DlNdKcbWiy9ua51YO9Ht/GyfzDx5FPYbJ2pjPOXKS2uDtUvxZsSZNpBxo8J5Heu3dC/N2cjyT2KfXLjIHJ+VIrddnpbM5fKwAv4nKHaHVbDhqtJqfcLZSmEBI6AXx
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2026 06:42:27.7140 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bc0be36f-0152-4fa0-a29a-08debc8448e0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB73.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR12MB5623
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

Initialize GC IP 11_5_6

Signed-off-by: Pratik Vishwakarma <Pratik.Vishwakarma@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c |  6 ++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c       |  1 +
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c        | 12 +++++++++++-
 drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c        |  2 ++
 drivers/gpu/drm/amd/amdgpu/imu_v11_0.c        |  1 +
 drivers/gpu/drm/amd/amdgpu/mes_v11_0.c        |  2 ++
 drivers/gpu/drm/amd/amdgpu/soc21.c            |  5 +++++
 drivers/gpu/drm/amd/amdkfd/kfd_crat.c         |  1 +
 drivers/gpu/drm/amd/amdkfd/kfd_device.c       |  5 +++++
 9 files changed, 34 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
index 8e3b6a4050e9..5364b0540613 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
@@ -2097,6 +2097,7 @@ static int amdgpu_discovery_set_common_ip_blocks(struct amdgpu_device *adev)
 	case IP_VERSION(11, 5, 2):
 	case IP_VERSION(11, 5, 3):
 	case IP_VERSION(11, 5, 4):
+	case IP_VERSION(11, 5, 6):
 		amdgpu_device_ip_block_add(adev, &soc21_common_ip_block);
 		break;
 	case IP_VERSION(12, 0, 0):
@@ -2157,6 +2158,7 @@ static int amdgpu_discovery_set_gmc_ip_blocks(struct amdgpu_device *adev)
 	case IP_VERSION(11, 5, 2):
 	case IP_VERSION(11, 5, 3):
 	case IP_VERSION(11, 5, 4):
+	case IP_VERSION(11, 5, 6):
 		amdgpu_device_ip_block_add(adev, &gmc_v11_0_ip_block);
 		break;
 	case IP_VERSION(12, 0, 0):
@@ -2479,6 +2481,7 @@ static int amdgpu_discovery_set_gc_ip_blocks(struct amdgpu_device *adev)
 	case IP_VERSION(11, 5, 2):
 	case IP_VERSION(11, 5, 3):
 	case IP_VERSION(11, 5, 4):
+	case IP_VERSION(11, 5, 6):
 		amdgpu_device_ip_block_add(adev, &gfx_v11_0_ip_block);
 		break;
 	case IP_VERSION(12, 0, 0):
@@ -2690,6 +2693,7 @@ static int amdgpu_discovery_set_mes_ip_blocks(struct amdgpu_device *adev)
 	case IP_VERSION(11, 5, 2):
 	case IP_VERSION(11, 5, 3):
 	case IP_VERSION(11, 5, 4):
+	case IP_VERSION(11, 5, 6):
 		amdgpu_device_ip_block_add(adev, &mes_v11_0_ip_block);
 		adev->enable_mes = true;
 		adev->enable_mes_kiq = true;
@@ -3096,6 +3100,7 @@ int amdgpu_discovery_set_ip_blocks(struct amdgpu_device *adev)
 	case IP_VERSION(11, 5, 2):
 	case IP_VERSION(11, 5, 3):
 	case IP_VERSION(11, 5, 4):
+	case IP_VERSION(11, 5, 6):
 		adev->family = AMDGPU_FAMILY_GC_11_5_0;
 		break;
 	case IP_VERSION(12, 0, 0):
@@ -3124,6 +3129,7 @@ int amdgpu_discovery_set_ip_blocks(struct amdgpu_device *adev)
 	case IP_VERSION(11, 5, 2):
 	case IP_VERSION(11, 5, 3):
 	case IP_VERSION(11, 5, 4):
+	case IP_VERSION(11, 5, 6):
 		adev->flags |= AMD_IS_APU;
 		break;
 	default:
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
index 13bec8461cde..7bf4d1890152 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
@@ -976,6 +976,7 @@ void amdgpu_gmc_tmz_set(struct amdgpu_device *adev)
 	case IP_VERSION(11, 5, 2):
 	case IP_VERSION(11, 5, 3):
 	case IP_VERSION(11, 5, 4):
+	case IP_VERSION(11, 5, 6):
 		/* Don't enable it by default yet.
 		 */
 		if (amdgpu_tmz < 1) {
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
index fabdbbd0abb7..1941bfbcbfbf 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -129,6 +129,10 @@ MODULE_FIRMWARE("amdgpu/gc_11_5_4_pfp.bin");
 MODULE_FIRMWARE("amdgpu/gc_11_5_4_me.bin");
 MODULE_FIRMWARE("amdgpu/gc_11_5_4_mec.bin");
 MODULE_FIRMWARE("amdgpu/gc_11_5_4_rlc.bin");
+MODULE_FIRMWARE("amdgpu/gc_11_5_6_pfp.bin");
+MODULE_FIRMWARE("amdgpu/gc_11_5_6_me.bin");
+MODULE_FIRMWARE("amdgpu/gc_11_5_6_mec.bin");
+MODULE_FIRMWARE("amdgpu/gc_11_5_6_rlc.bin");
 
 static const struct amdgpu_hwip_reg_entry gc_reg_list_11_0[] = {
 	SOC15_REG_ENTRY_STR(GC, 0, regGRBM_STATUS),
@@ -1123,6 +1127,7 @@ static int gfx_v11_0_gpu_early_init(struct amdgpu_device *adev)
 	case IP_VERSION(11, 5, 2):
 	case IP_VERSION(11, 5, 3):
 	case IP_VERSION(11, 5, 4):
+	case IP_VERSION(11, 5, 6):
 		adev->gfx.config.max_hw_contexts = 8;
 		adev->gfx.config.sc_prim_fifo_size_frontend = 0x20;
 		adev->gfx.config.sc_prim_fifo_size_backend = 0x100;
@@ -1606,6 +1611,7 @@ static int gfx_v11_0_sw_init(struct amdgpu_ip_block *ip_block)
 	case IP_VERSION(11, 5, 2):
 	case IP_VERSION(11, 5, 3):
 	case IP_VERSION(11, 5, 4):
+	case IP_VERSION(11, 5, 6):
 		adev->gfx.me.num_me = 1;
 		adev->gfx.me.num_pipe_per_me = 1;
 		adev->gfx.me.num_queue_per_pipe = 2;
@@ -3078,7 +3084,8 @@ static int gfx_v11_0_wait_for_rlc_autoload_complete(struct amdgpu_device *adev)
 		    amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(11, 5, 1) ||
 		    amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(11, 5, 2) ||
 		    amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(11, 5, 3) ||
-		    amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(11, 5, 4))
+		    amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(11, 5, 4) ||
+		    amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(11, 5, 6))
 			bootload_status = RREG32_SOC15(GC, 0,
 					regRLC_RLCS_BOOTLOAD_STATUS_gc_11_0_1);
 		else
@@ -5721,6 +5728,7 @@ static void gfx_v11_cntl_power_gating(struct amdgpu_device *adev, bool enable)
 		case IP_VERSION(11, 5, 2):
 		case IP_VERSION(11, 5, 3):
 	        case IP_VERSION(11, 5, 4):
+		case IP_VERSION(11, 5, 6):
 			WREG32_SOC15(GC, 0, regRLC_PG_DELAY_3, RLC_PG_DELAY_3_DEFAULT_GC_11_0_1);
 			break;
 		default:
@@ -5760,6 +5768,7 @@ static int gfx_v11_0_set_powergating_state(struct amdgpu_ip_block *ip_block,
 	case IP_VERSION(11, 5, 2):
 	case IP_VERSION(11, 5, 3):
 	case IP_VERSION(11, 5, 4):
+	case IP_VERSION(11, 5, 6):
 		if (!enable)
 			amdgpu_gfx_off_ctrl(adev, false);
 
@@ -5795,6 +5804,7 @@ static int gfx_v11_0_set_clockgating_state(struct amdgpu_ip_block *ip_block,
 	case IP_VERSION(11, 5, 2):
 	case IP_VERSION(11, 5, 3):
 	case IP_VERSION(11, 5, 4):
+	case IP_VERSION(11, 5, 6):
 	        gfx_v11_0_update_gfx_clock_gating(adev,
 	                        state ==  AMD_CG_STATE_GATE);
 	        break;
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
index 16388e3caea3..9664b7b8f0db 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
@@ -604,6 +604,7 @@ static void gmc_v11_0_set_gfxhub_funcs(struct amdgpu_device *adev)
 	case IP_VERSION(11, 5, 2):
 	case IP_VERSION(11, 5, 3):
 	case IP_VERSION(11, 5, 4):
+	case IP_VERSION(11, 5, 6):
 		adev->gfxhub.funcs = &gfxhub_v11_5_0_funcs;
 		break;
 	default:
@@ -778,6 +779,7 @@ static int gmc_v11_0_sw_init(struct amdgpu_ip_block *ip_block)
 	case IP_VERSION(11, 5, 2):
 	case IP_VERSION(11, 5, 3):
 	case IP_VERSION(11, 5, 4):
+	case IP_VERSION(11, 5, 6):
 		set_bit(AMDGPU_GFXHUB(0), adev->vmhubs_mask);
 		set_bit(AMDGPU_MMHUB0(0), adev->vmhubs_mask);
 		/*
diff --git a/drivers/gpu/drm/amd/amdgpu/imu_v11_0.c b/drivers/gpu/drm/amd/amdgpu/imu_v11_0.c
index 46d25d55ebbe..f5927c3553ce 100644
--- a/drivers/gpu/drm/amd/amdgpu/imu_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/imu_v11_0.c
@@ -42,6 +42,7 @@ MODULE_FIRMWARE("amdgpu/gc_11_5_1_imu.bin");
 MODULE_FIRMWARE("amdgpu/gc_11_5_2_imu.bin");
 MODULE_FIRMWARE("amdgpu/gc_11_5_3_imu.bin");
 MODULE_FIRMWARE("amdgpu/gc_11_5_4_imu.bin");
+MODULE_FIRMWARE("amdgpu/gc_11_5_6_imu.bin");
 
 static int imu_v11_0_init_microcode(struct amdgpu_device *adev)
 {
diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
index a926a330700e..147ba2942690 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
@@ -58,6 +58,8 @@ MODULE_FIRMWARE("amdgpu/gc_11_5_3_mes_2.bin");
 MODULE_FIRMWARE("amdgpu/gc_11_5_3_mes1.bin");
 MODULE_FIRMWARE("amdgpu/gc_11_5_4_mes_2.bin");
 MODULE_FIRMWARE("amdgpu/gc_11_5_4_mes1.bin");
+MODULE_FIRMWARE("amdgpu/gc_11_5_6_mes_2.bin");
+MODULE_FIRMWARE("amdgpu/gc_11_5_6_mes1.bin");
 
 static int mes_v11_0_hw_init(struct amdgpu_ip_block *ip_block);
 static int mes_v11_0_hw_fini(struct amdgpu_ip_block *ip_block);
diff --git a/drivers/gpu/drm/amd/amdgpu/soc21.c b/drivers/gpu/drm/amd/amdgpu/soc21.c
index 93c002e511c7..963659deeaff 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc21.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc21.c
@@ -833,6 +833,11 @@ static int soc21_common_early_init(struct amdgpu_ip_block *ip_block)
 			AMD_PG_SUPPORT_GFX_PG;
 		adev->external_rev_id = adev->rev_id + 0x1;
                break;
+	case IP_VERSION(11, 5, 6):
+		adev->cg_flags = 0;
+		adev->pg_flags = 0;
+		adev->external_rev_id = adev->rev_id + 0xd0;
+		break;
 	default:
 		/* FIXME: not supported yet */
 		return -EINVAL;
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c b/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
index cf7b1b038d5f..af2ae144f508 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
@@ -1706,6 +1706,7 @@ int kfd_get_gpu_cache_info(struct kfd_node *kdev, struct kfd_gpu_cache_info **pc
 		case IP_VERSION(11, 5, 2):
 		case IP_VERSION(11, 5, 3):
 		case IP_VERSION(11, 5, 4):
+		case IP_VERSION(11, 5, 6):
 			/* Cacheline size not available in IP discovery for gc11.
 			 * kfd_fill_gpu_cache_info_from_gfx_config to hard code it
 			 */
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
index 9e77c4a842ef..69facc5a544a 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
@@ -167,6 +167,7 @@ static void kfd_device_info_set_event_interrupt_class(struct kfd_dev *kfd)
 	case IP_VERSION(11, 5, 2):
 	case IP_VERSION(11, 5, 3):
 	case IP_VERSION(11, 5, 4):
+	case IP_VERSION(11, 5, 6):
 		kfd->device_info.event_interrupt_class = &event_interrupt_class_v11;
 		break;
 	case IP_VERSION(12, 0, 0):
@@ -448,6 +449,10 @@ struct kfd_dev *kgd2kfd_probe(struct amdgpu_device *adev, bool vf)
                         gfx_target_version = 110504;
                         f2g = &gfx_v11_kfd2kgd;
                         break;
+		case IP_VERSION(11, 5, 6):
+			gfx_target_version = 110504;
+			f2g = &gfx_v11_kfd2kgd;
+			break;
 		case IP_VERSION(12, 0, 0):
 			gfx_target_version = 120000;
 			f2g = &gfx_v12_kfd2kgd;
-- 
2.43.0

