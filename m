Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17DC8CDB46F
	for <amd-gfx@archiver.kernel.org>; Tue, 23 Jun 2026 16:07:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A221710EBD4;
	Tue, 23 Jun 2026 16:06:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="QyrorklV";
	dkim-atps=neutral
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010004.outbound.protection.outlook.com [52.101.85.4])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 521C010EBD4
 for <amd-gfx@lists.freedesktop.org>; Tue, 23 Jun 2026 16:06:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DEmJ9qFTmf3GhfQrn7j9H3ab7PhRIH4gFjBp93Gh8Ciwp0HvfqxxjojkOhFiYYZn+w94BVylVUb6de0zNQmXc+K4RFuI3sqvU8BS/xR+4LRr059zG+V+njkNh4/be8VZ9AhsNlGjq7CncblPpIqJSJjFaLNgR7KQCnMlFlmc5RglNHUaB89xzHGlYHNBOobWAnu+lVkhS/hlD4W8fwLH4XzTEbEFyaPAu6DGX7o19JX5vDoaSXQOYPsC9uyrdBGHt3VovEIsDeeOW6Ihxi8obj0Ogv/0i54YrUM0dp1ZQPPAYaunVFp6oZmxJfII7rh3yiKr0I/De+cnr6O09I33cg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4l3tXP2Fb0lqZJoX1at83sz+LLE/surK09+9XCNlLQU=;
 b=k7wOFCtuiZBZpp35GT8NzeixJ+W+v8AetCjdASlUfoLNHa95EvDS+z7DzpEyMu9fJvLyjEQ5SXkX5BqkriLrAsJxCQrB8mEvEYL7fTpwutiHkhcmd6JzoHZFpNe05LYML8i9xrPD5EYkAaudh3SzwbXc280nXIHI1RjNq3MtCIQ8gjxuUoBvOFPfXBcYO6ZxBOh9o2ipplIEPkX/YS+DOA3DtiFMn5SG/lg0r+YF+P+1WZCwMJzR7uVr1rQv6D12fBlYOax5tiwP+2iCghKag9ukXhbsktcFTfPuNuW860up6krOt6KuQ0cIIcKefoPOqSbK9IwnUSP9rTx1voA8CA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4l3tXP2Fb0lqZJoX1at83sz+LLE/surK09+9XCNlLQU=;
 b=QyrorklV1g3u8eqUEbFuQpYH23cqOV0E1riOEL3cZqLvvSrIGkRagD8jwJwQqcr7jRkRlI/G6+8YOg/uiYXPJPL4TK8K1qbzc0g39dP9AhcuZK6mT8/yT9V9LRB70mNb+pLpmCDRzflaNfPAPOsZg0K+/JaiSfSt+j4jNNkYe1U=
Received: from SJ0PR03CA0114.namprd03.prod.outlook.com (2603:10b6:a03:333::29)
 by LVUPR12MB999186.namprd12.prod.outlook.com (2603:10b6:408:3a3::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.13; Tue, 23 Jun
 2026 16:06:55 +0000
Received: from MWH0EPF000C6194.namprd02.prod.outlook.com
 (2603:10b6:a03:333:cafe::80) by SJ0PR03CA0114.outlook.office365.com
 (2603:10b6:a03:333::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.139.11 via Frontend Transport; Tue,
 23 Jun 2026 16:06:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 MWH0EPF000C6194.mail.protection.outlook.com (10.167.249.104) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.159.10 via Frontend Transport; Tue, 23 Jun 2026 16:06:53 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 23 Jun
 2026 11:06:53 -0500
Received: from asad-mlse-vm.amd.com (10.180.168.240) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 23 Jun
 2026 09:06:51 -0700
From: Asad Kamal <asad.kamal@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <lijo.lazar@amd.com>, <hawking.zhang@amd.com>, <le.ma@amd.com>,
 <shiwu.zhang@amd.com>, <alexander.deucher@amd.com>, <kevinyang.wang@amd.com>, 
 <asad.kamal@amd.com>, =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
Subject: [PATCH v2] drm/amdgpu: fix aperture mapping leak
Date: Wed, 24 Jun 2026 00:06:38 +0800
Message-ID: <20260623160638.4111587-1-asad.kamal@amd.com>
X-Mailer: git-send-email 2.46.0
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb09.amd.com
 (10.181.42.218)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000C6194:EE_|LVUPR12MB999186:EE_
X-MS-Office365-Filtering-Correlation-Id: 4594358a-a0a3-42e6-866a-08ded141717b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|1800799024|23010399003|82310400026|376014|18002099003|11063799006|5023799004|56012099006;
X-Microsoft-Antispam-Message-Info: dHYdaUp9+dO1TyCOyzodOJIYIOVNssZEeC0eu820HJbOt88HHOf5fcSRhSBJkY0UCled4WzH4gaZajFNdc/zHWp5ky5Vx4/ohX5n0hmZXROWjlPoHbX2HztdJuCHyhdodOhda8ifGWp24Au1CdG29/x11+Zg90aXYwZMhyg2yOOzbFbDM2YPfgE+t0GVjbJlc1SeLCQRbXTwR62JV2DBD5eMcIxtdrtO6x58OHOkWLetxIjTNyEW1oxbKn3Vj3OchFtxieKpKVb0BiFAHCTQ22cYLemg7EtMMWnhALg90yUM7k75d/neRj+7emq2Yp19D29xnsZpKzyR46KbGr0ReGiAtb6i6JPxEZEAT558Mb2ysMhtl36z9NPmqYvW4+rJl5gBT1FfADs3SdoySEmfJrrx+efHe6OUEbmd/QhWqmnvddec6bqYRBwkxXOef85a+UWPAH3MtAdiEkGwfckq8YlWCpKiPH9HLMCR3eUuWt2zXn9mcvEFnUsx7XxwkHLxeQp3JwwmTllw1Z8XL1rJXO1ZjOD0FlwIDoJPflpU/hkIozPZjQsoWP/Acs/LeSh+EOIFstI8H/QUFE5S5c0AvaaYHoMs+LN6WgfH0GkB2zaNVS1mr+YwCzolI1BGnE7Z4GggHW5diwL1l1KPrheZWwr7fLk+q51p2RHwEy74dLha2QSNHueQoINlzovRtjrdAwcflZSKYh6O5w9/dpogvw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(1800799024)(23010399003)(82310400026)(376014)(18002099003)(11063799006)(5023799004)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: FQ48dnjKMjzZ1gRiRlKCWnPFhG0IaLqtT+bj2yGxT8E0Fuj/fmqFNyYLYQfjEZD0uy8Y+0mg2y/kXh1yivxoizCV+0gtVzbOwEosoPhgkTOOXuj5ReMugSI+dT1kORt/ucRXHYcUNR7ObbUfw9PGkcL5IADC8mX0fS2nRjXW3w9Xi0LtM3jhZ+CXc+Pxe1/vxlRtwuzJwVhahis229nQiVclEUe9CDufVbxobrRtH+ZSgy0jZm/L9chVGttfxRCqrxj+xsgqHgqPiqAbBU7B2wn9B6XjT5P0VZUSg2jk3eD050pRV++5hc9HHU2viZ0q3ADR463tWE1aOUkoUB06Bdz71K14GhuyjjcGAjV7vODJA/VaSl2UEOTZ4tO8PXucLGBt0gdDkpszuPmtnzsdwVv7tJpzK/PHqY17szXKL4wdPz2OiI921YvXZYcbVrq6
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2026 16:06:53.9006 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4594358a-a0a3-42e6-866a-08ded141717b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000C6194.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LVUPR12MB999186
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

v2: Remove redundant x86_64 guard (Lijo)

Fixes: 9d0af8b4def0 ("drm/amdgpu: pre-map device buffer as cached for A+A config")
Signed-off-by: Asad Kamal <asad.kamal@amd.com>
Reviewed-by: Christian König <christian.koenig@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c |  2 --
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c    | 36 ++++++++++------------
 2 files changed, 16 insertions(+), 22 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 5442a1fc1c37..70d07ca187a3 100644
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
index f80371bc74d7..1a211f024446 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
@@ -2119,18 +2119,23 @@ int amdgpu_ttm_init(struct amdgpu_device *adev)
 	/* Change the size here instead of the init above so only lpfn is affected */
 	amdgpu_ttm_disable_buffer_funcs(adev);
 #ifdef CONFIG_64BIT
-#ifdef CONFIG_X86
-	if (adev->gmc.xgmi.connected_to_cpu)
-		adev->mman.aper_base_kaddr = ioremap_cache(adev->gmc.aper_base,
-				adev->gmc.visible_vram_size);
-
-	else if (adev->gmc.is_app_apu)
+	if (adev->gmc.xgmi.connected_to_cpu) {
+		void *kaddr = devm_memremap(adev->dev, adev->gmc.aper_base,
+					    adev->gmc.visible_vram_size,
+					    MEMREMAP_WB);
+		if (IS_ERR(kaddr))
+			return PTR_ERR(kaddr);
+		adev->mman.aper_base_kaddr = (__force void __iomem *)kaddr;
+	} else if (adev->gmc.is_app_apu) {
 		DRM_DEBUG_DRIVER(
 			"No need to ioremap when real vram size is 0\n");
-	else
-#endif
-		adev->mman.aper_base_kaddr = ioremap_wc(adev->gmc.aper_base,
-				adev->gmc.visible_vram_size);
+	} else {
+		adev->mman.aper_base_kaddr = devm_ioremap_wc(adev->dev,
+							     adev->gmc.aper_base,
+							     adev->gmc.visible_vram_size);
+		if (!adev->mman.aper_base_kaddr)
+			return -ENOMEM;
+	}
 #endif
 
 	amdgpu_ttm_init_vram_resv_regions(adev);
@@ -2247,8 +2252,6 @@ int amdgpu_ttm_init(struct amdgpu_device *adev)
  */
 void amdgpu_ttm_fini(struct amdgpu_device *adev)
 {
-	int idx;
-
 	if (!adev->mman.initialized)
 		return;
 
@@ -2271,14 +2274,7 @@ void amdgpu_ttm_fini(struct amdgpu_device *adev)
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

