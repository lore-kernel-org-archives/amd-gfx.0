Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34C33C19F32
	for <amd-gfx@archiver.kernel.org>; Fri,  7 Mar 2025 06:20:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 94F2B10EAEA;
	Fri,  7 Mar 2025 06:20:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="bWiNRHTh";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2056.outbound.protection.outlook.com [40.107.94.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 67B0410EAE9
 for <amd-gfx@lists.freedesktop.org>; Fri,  7 Mar 2025 06:20:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=A/MNcQRDa5oUcI/L68U74cf4uH7bfEUSpXOmgdIHvhT8fFFjWKaSQJ5zyPsbcQM51Sldpllnqm5NwLmDE+XqV5ZtGP2jW5d3iP7jpiktSgTq4G2HWtGBKX49srFYMIyq87uNJG5rsy+EaL73AFZhaQmJCIQ3BRP3M5dkEMMpccXpRdXH4afTVLmHDa54F/L/baSNgxQAcZOXLfXLuI6OL2Q8+1fdl3ZCUQ70adOrApvp0xrR5lT6DOlUvzDOzYqPUKwN0E5kgSosFCbVk1PvOXFULDX3J6kng0aVML9VFduXoLLpflgcU+CfCPbykWhzLJOmQhzjafV6c0PAL4gTCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+NksQaODIp+pGMGdWOCEe0eSb7csLMf7IV3pqUZ6jcQ=;
 b=v3oaNF+yvKQKPDiNbgojWqtRMuqYi6fls5KYJkL4K+dk7FkB0tmmlz+SHnCX9QzKpe9d9lu3OQdMUSvApcdMnrfPTjp2deCT7fz6AEBDMs4G8d07F1t7pXm4/f5kewdi11pFtVCXDxsnTTtqRtWk+QGzGQ1TM5BbtYelyEAi8aZ9esZ5BEmVDHhtpe54OWiXH09+jZySSD3lgMO9tkgLYXj0FdNpnxn3RpniEhKr8JjLjLYvKyRO5mzMIC2QQ0Cz3AuzjMP1awAUPhLeOqYlxGwXYpvOhebU8MqoOTrpOSmhMkg2uOzcd+f6wPqNXhPWHDbzjHDNWNGxtm/VHtwUFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+NksQaODIp+pGMGdWOCEe0eSb7csLMf7IV3pqUZ6jcQ=;
 b=bWiNRHTh+I9YpyHBsj8a8ohHf8GVeMjPp2QTWb3b248UsvmjLkDmYMkyoonb0zcz76sEbhgnPZcFlM2ZJJ45pbz9RZ9EOf0bZUgSr2YKxd+2IY6Z6VOS37eOCQA/xpLUp55QV05WL50GaKTzy/5evWKOHyJKZ84ncVhOxPmd39Q=
Received: from BN9PR03CA0534.namprd03.prod.outlook.com (2603:10b6:408:131::29)
 by IA0PR12MB8929.namprd12.prod.outlook.com (2603:10b6:208:484::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.17; Fri, 7 Mar
 2025 06:20:24 +0000
Received: from BN3PEPF0000B075.namprd04.prod.outlook.com
 (2603:10b6:408:131:cafe::fa) by BN9PR03CA0534.outlook.office365.com
 (2603:10b6:408:131::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8511.19 via Frontend Transport; Fri,
 7 Mar 2025 06:20:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B075.mail.protection.outlook.com (10.167.243.120) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8511.15 via Frontend Transport; Fri, 7 Mar 2025 06:20:24 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 7 Mar
 2025 00:20:22 -0600
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Alexander.Deucher@amd.com>
Subject: [PATCH 1/2] drm/amd/pm: Add debug bit for smu pool allocation
Date: Fri, 7 Mar 2025 11:50:05 +0530
Message-ID: <20250307062006.251686-1-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B075:EE_|IA0PR12MB8929:EE_
X-MS-Office365-Filtering-Correlation-Id: 2e1fcbf8-9c46-4766-cb0f-08dd5d40255f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?vXfgq+Z4qA+R/FTKuixqh8W3SOADxftbrUgX/J5lWo3TC6orBp8DT1oNEYi5?=
 =?us-ascii?Q?hy2XOBdBJUUORl3shRAX1HWuvxXxHJInnr5iMxxhHzRH7ZmX/s3eW+jQ2jMS?=
 =?us-ascii?Q?WrbGlJ/kBAKNx1A9JlKqg9BZ0tgULnPN+uo5bFU4icMMWiow7kL94Y8Vpsl9?=
 =?us-ascii?Q?4iVOSwHUGvHUPBPnrrdXyMEiWkPHpioIwL8C+0dt0vTSoIqfAMtqRtB3fqD2?=
 =?us-ascii?Q?qYpfdR7tXtnCdYU1o653f1FznVOKw9vzDMBDbGNkIAayDMWFewdKcNQq+kDy?=
 =?us-ascii?Q?dwpcZMKqAzI7NgIK9yqcRM3wi5XPBZfrRENAcFa9Y/2IP5v3526X+jfDCCGm?=
 =?us-ascii?Q?MaZaZsI8oxMwXx3aragGfgRg1kPh9C5Lput5NjWpCNNS0XszlC51hqH+xsKp?=
 =?us-ascii?Q?fQZPnbHOovRtY/WYvUuqdnGcSKoXGOWVrM9U0gEBcDOZlpBFAHLh1X0340Hv?=
 =?us-ascii?Q?LREp1fLm5dHMYC2nur7V3AR1/oBTwytEOUcbY42Cu6a+se0cOGTodJh7vd3m?=
 =?us-ascii?Q?N/IQxIUtxRBQ6BvZo74+k8VyIz+DRYkeBW/dit5jsyji2WMmwQTMiDKo05In?=
 =?us-ascii?Q?dT/p3oRwXq60snj0P5+Sf6rCLM+aoW/4usOOJ8UfTh+YdW5ouI/nWahcfLm1?=
 =?us-ascii?Q?0T9qgCSaHHfTRJKH8l/tta5fpJ83FbQL5+wRuLcuGsjYvrRxrn6Zo9ZLR85T?=
 =?us-ascii?Q?Tr8rVTV4ruTDnV8aTDO3luL5B7X67TmbXdjMfxYl584fsq0TzBPNejCVw28x?=
 =?us-ascii?Q?V5NyqmoK4ZF5jSf+SqkGO6htaYZsTE5kqfWpnUbDwC6Khhx6nygCS8dWsyEu?=
 =?us-ascii?Q?ooti8CmIvYRxwUK/p813qfGBHHuaIBJdLyVFNW2D97WS1/002a7P83V4XBXG?=
 =?us-ascii?Q?FP3uGTgQja3K8xQ+s6XY6zCxl51uHP4FFfV2rhIBS35I3E9xUcrZc3X+iqbN?=
 =?us-ascii?Q?w1+alH7LCOgQsUfxjTvNZLJeZEDBfaVbBc08Oi5i09wSYIVLtWpgIDkKeQGO?=
 =?us-ascii?Q?NrJq3JxeHhY93WoSwG63JymqPGo3mhp+dDzfZ/WQO1G3HnLWbB8mszJFSV9g?=
 =?us-ascii?Q?4Yi4hkteeoW9Mv4rAxBcgK7szMLsmpB4evtg+CSXjguF+VRSIy6dL4LR+oV6?=
 =?us-ascii?Q?69O2e3p5w+NZt0nvARrt3/pDHoiJZUpDq2bqI/+ekTqSiAEzixjWtacEsk//?=
 =?us-ascii?Q?NSM06zpQnYLjEQFLcAJ4Ig/78QctBwW60VkChr7mcMXd6dtr+puYexpC0AVR?=
 =?us-ascii?Q?oFDtFZUEvx3zvo450MZVHGd2O2fo3HniyjgfekjjlRwQxRE+kEb4Rb95JwBH?=
 =?us-ascii?Q?TQ8sF/I1VmanIYcsBvmj9XBEFTt+gV4aYA+YoWoVTfXWC3uiUR29g0ubnpnI?=
 =?us-ascii?Q?eRR9brnkh5251A5NsagnXTIA5jSa4Ewr52NA6KPSGLzhHKMX71IpU3IDpXMh?=
 =?us-ascii?Q?a07uRE9jVsvHYJW2EXUqUxwPfIwgzhQ3Jl25YIOHv3u49Yu1lL/magNnZY40?=
 =?us-ascii?Q?V2NLWAcukVcgPxI=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2025 06:20:24.2178 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e1fcbf8-9c46-4766-cb0f-08dd5d40255f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B075.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8929
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

In certain cases, it's desirable to avoid PMFW log transactions to
system memory. Add a mask bit to decide whether to allocate smu pool in
device memory or system memory.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c   | 5 +++++
 drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h   | 3 ++-
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c | 5 ++++-
 3 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index b161daa90019..22775c204632 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -140,6 +140,7 @@ enum AMDGPU_DEBUG_MASK {
 	AMDGPU_DEBUG_ENABLE_RAS_ACA = BIT(4),
 	AMDGPU_DEBUG_ENABLE_EXP_RESETS = BIT(5),
 	AMDGPU_DEBUG_DISABLE_GPU_RING_RESET = BIT(6),
+	AMDGPU_DEBUG_SMU_POOL = BIT(7),
 };
 
 unsigned int amdgpu_vram_limit = UINT_MAX;
@@ -2231,6 +2232,10 @@ static void amdgpu_init_debug_options(struct amdgpu_device *adev)
 		pr_info("debug: ring reset disabled\n");
 		adev->debug_disable_gpu_ring_reset = true;
 	}
+	if (amdgpu_debug_mask & AMDGPU_DEBUG_SMU_POOL) {
+		pr_info("debug: use vram for smu pool\n");
+		adev->pm.smu_debug_mask |= SMU_DEBUG_POOL_USE_VRAM;
+	}
 }
 
 static unsigned long amdgpu_fix_asic_type(struct pci_dev *pdev, unsigned long flags)
diff --git a/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h b/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
index 9fb26b5c8ae7..f93d287dbf13 100644
--- a/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
+++ b/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
@@ -295,7 +295,8 @@ enum ip_power_state {
 };
 
 /* Used to mask smu debug modes */
-#define SMU_DEBUG_HALT_ON_ERROR		0x1
+#define SMU_DEBUG_HALT_ON_ERROR		BIT(0)
+#define SMU_DEBUG_POOL_USE_VRAM		BIT(1)
 
 #define MAX_SMU_I2C_BUSES       2
 
diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
index 54a31d586d55..f6def50ba22d 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -1027,7 +1027,10 @@ static int smu_alloc_memory_pool(struct smu_context *smu)
 
 	memory_pool->size = pool_size;
 	memory_pool->align = PAGE_SIZE;
-	memory_pool->domain = AMDGPU_GEM_DOMAIN_GTT;
+	memory_pool->domain =
+		(adev->pm.smu_debug_mask & SMU_DEBUG_POOL_USE_VRAM) ?
+			AMDGPU_GEM_DOMAIN_VRAM :
+			AMDGPU_GEM_DOMAIN_GTT;
 
 	switch (pool_size) {
 	case SMU_MEMORY_POOL_SIZE_256_MB:
-- 
2.25.1

