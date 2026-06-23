Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9FD3ACD98F0
	for <amd-gfx@archiver.kernel.org>; Tue, 23 Jun 2026 03:46:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E828010E925;
	Tue, 23 Jun 2026 03:46:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="WgZgvzi/";
	dkim-atps=neutral
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010025.outbound.protection.outlook.com [52.101.85.25])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D535D10E925
 for <amd-gfx@lists.freedesktop.org>; Tue, 23 Jun 2026 03:46:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pETVGxWJDZWFKa4RKrZ0PcuJELpBnJisBfhfCuNskqt1URuJ4RXGy5Bc6w3CPWywn/4Qog0Gq/MEfEowc84zeecCdwmM67fNGSZc4C+/DrskpyfxkEMFl+TL/QVJQcQB+dCwJ/RO2PHHvze8YR/sDJAcVxIQx7v4LKxGL6DfJ2t9ENVeQ78Pt6SydahvYK7SPInzETu7kWeatX8UfUPFQjpDbJ7IYHk393xJ+48eRkz7/FX0lYLQXM5wDSMtym7zb92n/n7NyrcB51DzCPSbTwwhhUi5xTwnKSarPlnjie2Z57eeBgZnnGNebGiOXVrtHWpzCegyv/lnWPtpLaALZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q2zvVnOQDD/FtXePCRTDVDbkupvXxfDSeTyxZst7SLs=;
 b=g2L2ZJNuwr6r3pul3LnoIjMfI119qv2wggXuXSIMJg+KCB1ea5NeqJbq+zhBwj4zQCkK4eKQNy+26TvxHeONhi9ebxRfN3U+U4vgkwHq9FG7ueitJUTAMqskW3aNW8wqrzx9xymQHU50Mw5N2fZoKREzCYsc1pZ89HbDuxSruy7ykvVfxwA+0LiZfp8cVEk8Dx9ovED3bf+EZJZwaZP5DBtzIS64scpOGbvWH89UDq3PpZ4la1Ki31dhEnWmUKPfuUq3axZmWPeorsVFs/AEn2ERwBqtLAWWfCI1JZOJFrcq+esWXco9F6rFFR1STlzGoEpFmcre8CoxjPlKasaJcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q2zvVnOQDD/FtXePCRTDVDbkupvXxfDSeTyxZst7SLs=;
 b=WgZgvzi/VzHZciyA4yFczSbyi+QGDrmsZzQWmFNLMAFRDur7NJbskliUHEy4Bz7vh+oNCt6GNr7hBrNFAwRxkrFd3Z6ZUOrtczrLtImhaOmhf33Csxu7HMeoTeT9AO9Bv2h0slrM7EnJ0WxQsTmgXmiPdRhUIT/LtekVn8jQ4G0=
Received: from PH8P220CA0012.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:345::19)
 by MN0PR12MB5764.namprd12.prod.outlook.com (2603:10b6:208:377::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.18; Tue, 23 Jun
 2026 03:46:37 +0000
Received: from SN1PEPF000397AE.namprd05.prod.outlook.com
 (2603:10b6:510:345:cafe::84) by PH8P220CA0012.outlook.office365.com
 (2603:10b6:510:345::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.139.20 via Frontend Transport; Tue,
 23 Jun 2026 03:46:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF000397AE.mail.protection.outlook.com (10.167.248.52) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.159.10 via Frontend Transport; Tue, 23 Jun 2026 03:46:36 +0000
Received: from asad-mlse-vm.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 22 Jun
 2026 22:46:34 -0500
From: Asad Kamal <asad.kamal@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <lijo.lazar@amd.com>, <hawking.zhang@amd.com>, <le.ma@amd.com>,
 <shiwu.zhang@amd.com>, <alexander.deucher@amd.com>, <kevinyang.wang@amd.com>, 
 <asad.kamal@amd.com>, =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
Subject: [PATCH] drm/amdgpu: fix aperture mapping leak
Date: Tue, 23 Jun 2026 11:46:17 +0800
Message-ID: <20260623034617.3946617-1-asad.kamal@amd.com>
X-Mailer: git-send-email 2.46.0
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000397AE:EE_|MN0PR12MB5764:EE_
X-MS-Office365-Filtering-Correlation-Id: bbb95f94-48d8-4729-4938-08ded0da06b7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700016|82310400026|23010399003|1800799024|56012099006|11063799006|5023799004|18002099003;
X-Microsoft-Antispam-Message-Info: Jcgpw7Rwb/Ms91XOw023n5Tp9Q2w4vc6MyrzR/EExiP8tJ+YMTx+Mq6E9wBtRGBBKb7bQvv7yW1WiIujdzeUK1KyeHaqkZSKB8na6putk3eeGEOpKT/Ijoba9QVxi8kJvaMARvvaUTBBN1ATQXqltFmIPRaN4k7WWPl/cHJIxs5fUx4QnIrQnU5Urt7GKrj0xddcM/WOsEl144dofrGkIjIGOutnXtR5woMnT3qSQdRlKz9ShE889k/fRihbV7Q28G8j/OlhCdwpAiWgw/JJRKGVA88dS4ucmvw3QANgqtfFSQxE78T43UxKJPjXeRubOSc4JFj4OYJRciozXyswtP6FTcvdIgy+lfjNQI0jZ59Qh6mbKbUEDDSe2lXT0c1V7aGGF4M04yDfOLZuf3kfpsOhfseXQ/kzuXJxVORsx2A6rAI3hD4hEIep/m0PsrlT5kXjL3CmI4/HHNscEDqJdF1JGDPg62tayOf+uhCGI+JK82+Sm0WK480M8wpd413giY51MDEbOWLQqrQONlMwPoF04FHitlXb2l3AiyIhrAjEYRytu6gl8I1twniyyn3wj84S4TXjMIFfzwKbnrZmfPhHkIDnpfPUKYNC2kLUznnPsvULZHbdIlN04iQ9uI+csJ8Drfn2f096+17VyZgavBVrqb3Vo+yST1RVfOt5l3tbCDwmSXnDTHiYyY1iJ7/Ub+nhVIrDcZCTHhGPRi7Azw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700016)(82310400026)(23010399003)(1800799024)(56012099006)(11063799006)(5023799004)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: mpjhzw3yO38nsoykFJFWRk43/WHAePEsWoZQt/xRuPicGB5EUHRH0fbyFRlCdpThj50cVsA5HhV+HAuY19rKGMBWYCRikvxtnzNWTrryiNVNmyvrpJ6w2JgOp+Zj/+9SOtsliKYPVpRxNITMqo7BjZ6DHNGr9pNkuKZVeJxpBf3TK4WBCieBLOwAf5jaekJnJO1USC5o8qqka2f0NtvsjwzZxb5fHQx5BZvedf+cDgLO/RmpI4MoGnGdXTXXSgflEXnCG4ZuyN286xQg+4JwTtNJb5poyCG/1qN40Wzw8a73z/I/5aEUEAVuL9DZXeX1z9oyz8ufJUGwk77uAJA9sbtBggkx5FLDCvv4WsBwhjMUzhS76MrvD8ywB1mfWnsvfh6z866LEfVIBgXe+Oku4kp2BdGKPn08J4njJ+KfgsEdfy5/ySFyInT+b/DNF/Lg
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2026 03:46:36.6650 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bbb95f94-48d8-4729-4938-08ded0da06b7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF000397AE.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5764
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

amdgpu_pci_remove() calls drm_dev_unplug() before invoking the driver
fini routines. This causes drm_dev_enter() in amdgpu_ttm_fini() to
always return false, so iounmap(aper_base_kaddr) never runs on normal
driver unload, leaving an orphaned entry in the x86 PAT interval tree.

On connected_to_cpu hardware, the aperture is mapped write-back (WB) via
ioremap_cache(). On reload, IP discovery calls memremap(..., MEMREMAP_WC)
over the same range. The WC vs WB conflict causes:

  ioremap error for 0x..., requested 0x1, got 0x0
  amdgpu: discovery failed: -2

Fix by switching to devres-managed mappings so cleanup is guaranteed
regardless of drm_dev_enter() state:

- connected_to_cpu path: devm_memremap(MEMREMAP_WB). For
  IORESOURCE_SYSTEM_RAM ranges this takes the try_ram_remap() shortcut,
  returning __va(offset) from the existing kernel direct map. No new
  ioremap VA or PAT entry is created, so there is nothing to orphan.

- dGPU path: devm_ioremap_wc() registers iounmap() as a devres action,
  guaranteeing cleanup at device_del() time.

Also remove iounmap(aper_base_kaddr) from amdgpu_device_unmap_mmio()
since the mapping is now devres-owned.

Fixes: 9d0af8b4def0 ("drm/amdgpu: pre-map device buffer as cached for A+A config")
Signed-off-by: Asad Kamal <asad.kamal@amd.com>
Reviewed-by: Christian König <christian.koenig@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c |  2 --
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c    | 39 +++++++++-------------
 2 files changed, 15 insertions(+), 26 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 42fff6ee106d..dbe229459f10 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -4190,8 +4190,6 @@ static void amdgpu_device_unmap_mmio(struct amdgpu_device *adev)
 
 	iounmap(adev->rmmio);
 	adev->rmmio = NULL;
-	if (adev->mman.aper_base_kaddr)
-		iounmap(adev->mman.aper_base_kaddr);
 	adev->mman.aper_base_kaddr = NULL;
 
 	/* Memory manager related */
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
index f80371bc74d7..ddf657484f45 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
@@ -2118,20 +2118,20 @@ int amdgpu_ttm_init(struct amdgpu_device *adev)
 
 	/* Change the size here instead of the init above so only lpfn is affected */
 	amdgpu_ttm_disable_buffer_funcs(adev);
-#ifdef CONFIG_64BIT
-#ifdef CONFIG_X86
-	if (adev->gmc.xgmi.connected_to_cpu)
-		adev->mman.aper_base_kaddr = ioremap_cache(adev->gmc.aper_base,
-				adev->gmc.visible_vram_size);
-
-	else if (adev->gmc.is_app_apu)
-		DRM_DEBUG_DRIVER(
-			"No need to ioremap when real vram size is 0\n");
-	else
-#endif
-		adev->mman.aper_base_kaddr = ioremap_wc(adev->gmc.aper_base,
-				adev->gmc.visible_vram_size);
-#endif
+	if (IS_ENABLED(CONFIG_X86_64) && adev->gmc.xgmi.connected_to_cpu) {
+		void *kaddr = devm_memremap(adev->dev, adev->gmc.aper_base,
+					    adev->gmc.visible_vram_size,
+					    MEMREMAP_WB);
+		if (IS_ERR(kaddr))
+			return PTR_ERR(kaddr);
+		adev->mman.aper_base_kaddr = (__force void __iomem *)kaddr;
+	} else if (IS_ENABLED(CONFIG_64BIT) && !adev->gmc.is_app_apu) {
+		adev->mman.aper_base_kaddr = devm_ioremap_wc(adev->dev,
+							     adev->gmc.aper_base,
+							     adev->gmc.visible_vram_size);
+		if (!adev->mman.aper_base_kaddr)
+			return -ENOMEM;
+	}
 
 	amdgpu_ttm_init_vram_resv_regions(adev);
 
@@ -2247,8 +2247,6 @@ int amdgpu_ttm_init(struct amdgpu_device *adev)
  */
 void amdgpu_ttm_fini(struct amdgpu_device *adev)
 {
-	int idx;
-
 	if (!adev->mman.initialized)
 		return;
 
@@ -2271,14 +2269,7 @@ void amdgpu_ttm_fini(struct amdgpu_device *adev)
 	amdgpu_ttm_unmark_vram_reserved(adev, AMDGPU_RESV_FW_VRAM_USAGE);
 	amdgpu_ttm_unmark_vram_reserved(adev, AMDGPU_RESV_DRV_VRAM_USAGE);
 
-	if (drm_dev_enter(adev_to_drm(adev), &idx)) {
-
-		if (adev->mman.aper_base_kaddr)
-			iounmap(adev->mman.aper_base_kaddr);
-		adev->mman.aper_base_kaddr = NULL;
-
-		drm_dev_exit(idx);
-	}
+	adev->mman.aper_base_kaddr = NULL;
 
 	if (!adev->gmc.is_app_apu)
 		amdgpu_vram_mgr_fini(adev);
-- 
2.46.0

