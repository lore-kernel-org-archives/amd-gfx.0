Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7004CF6498
	for <amd-gfx@archiver.kernel.org>; Wed, 19 Nov 2025 23:50:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7D65310E278;
	Wed, 19 Nov 2025 23:50:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="mf6ZjUay";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012068.outbound.protection.outlook.com
 [40.93.195.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 926C110E278
 for <amd-gfx@lists.freedesktop.org>; Wed, 19 Nov 2025 23:50:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uCXnM33MuJnsYfGhXfGDZ99vl4GIpBu048xdO4nnebnXcMBU0HIlbmqr2VZQsDofZmllTkfB5RykkdXPi7HQyu+0REMLcsPC3LrSeQE9bmWrKmwqVbDKybc3h4rG7Qy/42ukcpCHzgzdf2/jStkLQKVsf/15MN8Rd/SfVXY7kwsxMOIzY+RMXsm0He5WvhunO3i8IONfTXUx6mlI0CcG+9c6q86joC8BwYD6ktbVNVUnR/bSAiZjBu15M+DgD8bGjpFxTYQsGNOL+t4Xn9uDIsNwP3wDOzxs1r4H9Uo7dBCsyqWa1WhyrH5p7bkogyWWh77jdQaHZUBQ4LYOzbzIIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r2cKtdHnOYW6rW+/PpcaeWL6iIrc2kPOeB37jZ5Nc7o=;
 b=KR8prSJPBUvY7yRY9bj+vNlPz8xUcD47p1V5X31htx6LwXmfEcSDvnkpyqCufyXHop9u9t84vAfMWoVQnStugac0OJ/V/SJnoB+al85MdMjUNaxDSFMA9e9X2o/aK33zJ3oVOKVqSNTzPH61FUCqaPdt51tvKzypTXRId10iTAiq0vIFkmAOAxSEtDi3I8xvazvJ5EUmpOIdQUJ5wFbgkg4pv/voozMCr6g5DthgkxU6EBBf/LNbcUM5mgupAHnom4/UW7hI4tWm36ltZJFV8ZcIYYcIB6PqqMnrq53vbqCwBm8PC91M7rKk4/Lv0y6uG6pAatAIYKkIEpbBVR8KBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r2cKtdHnOYW6rW+/PpcaeWL6iIrc2kPOeB37jZ5Nc7o=;
 b=mf6ZjUaySySs4SUDthvBclrumLsxTejNE0tFojcNS+nzboCXsTRJr5UGjpa0vCqzKxS8oYMR3PRwzckgy5pthl6ztxLab43Cp0LWfNQO98P6yaO5YOCXcuMmXvN5Z5YeRAm9MtUXMOLCSLjJ3/SQolCcpDdnt/hxz33Gm0SYH6Q=
Received: from MN2PR19CA0058.namprd19.prod.outlook.com (2603:10b6:208:19b::35)
 by LV3PR12MB9095.namprd12.prod.outlook.com (2603:10b6:408:1a6::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.22; Wed, 19 Nov
 2025 23:50:47 +0000
Received: from BL02EPF0002992C.namprd02.prod.outlook.com
 (2603:10b6:208:19b:cafe::a7) by MN2PR19CA0058.outlook.office365.com
 (2603:10b6:208:19b::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9343.10 via Frontend Transport; Wed,
 19 Nov 2025 23:50:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BL02EPF0002992C.mail.protection.outlook.com (10.167.249.57) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9343.9 via Frontend Transport; Wed, 19 Nov 2025 23:50:46 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Wed, 19 Nov
 2025 15:50:46 -0800
Received: from satlexmb07.amd.com (10.181.42.216) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 19 Nov
 2025 17:50:46 -0600
Received: from rico-code.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Wed, 19 Nov 2025 15:50:45 -0800
From: Tianci Yin <tianci.yin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Kasiviswanathan Harish <Harish.Kasiviswanathan@amd.com>, Hawking Zhang
 <Hawking.Zhang@amd.com>, Tianci Yin <tianci.yin@amd.com>
Subject: [PATCH] drm/amdgpu: Enlarge DMA mask to 48-bit for GFX11 and GFX12
Date: Thu, 20 Nov 2025 07:50:42 +0800
Message-ID: <20251119235042.992611-1-tianci.yin@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: tianci.yin@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0002992C:EE_|LV3PR12MB9095:EE_
X-MS-Office365-Filtering-Correlation-Id: ea1f6341-94ff-4e43-97d3-08de27c675f2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?6znnboP2fUfjOvstjlpOMaVy0mVp1YgfGoSd6LPmH2jLpPJXli6IwQagcKLf?=
 =?us-ascii?Q?JytLDjZ3xM0FEeUzMOxeFuIgLsXjRBi/dy0ZfCiK2J0J10MO7NPbpC/Da5vS?=
 =?us-ascii?Q?GWjTD5ePwHI5jnXWl1ewqZsDQpqE5tZgbvPoGXebczoYM2hiwB3QSAmTeMpz?=
 =?us-ascii?Q?jun5MAMRKEzxp4XxyVhhl6XfObY+J450WsO8szl8dMxf1KiPHzzl5IDlli6X?=
 =?us-ascii?Q?jmRg03C34qrb9e/nLlTBCA2dVAp1Hmrq9j2iAPh02zsi1nqEALw2FoksM9xo?=
 =?us-ascii?Q?CkiTbVSFIoaCC+fwh26j8CCYL5pKf6+JI7AGFrqzj1CEUY2dR7+ALFzRWYJM?=
 =?us-ascii?Q?vfzgqwflVcxj6R/MJiweLj94QqHde+ZHsbBwGV4NBpJYdsPj8vUA1MLZPDZO?=
 =?us-ascii?Q?r4WjW6rmBpXMSyodua9vrNNkd9PO8xvd7FOAGrvlgDeSarfvQ3k6Ouhl1dW6?=
 =?us-ascii?Q?6o99reSHzZk1YUFACa+n5chaOznkhxkCOhBPankuxXgn2EokUtvRz65asRIT?=
 =?us-ascii?Q?g2sHGrgw+O/SuKCXlY6gfmbeRd69V3HVXe3yRSMM45ckYUxxrjXJQQmnhafq?=
 =?us-ascii?Q?2pNNOOnhRMLR6LcxDXmjlkcLs4i/aN1nVoGjZTG+GPObRGwIHqVmO79pxnBX?=
 =?us-ascii?Q?Rc4Co+5bG6DIpFIpp2aXP6zVq9WtwqMlplTiRJz+tqXbSqkiidkYCR8xmO0s?=
 =?us-ascii?Q?z8K3Ei7uApq4/IU8T0xLuiqRWigcCyXwPMkpIV9xJU+rvISCW/BqkqhZjYhl?=
 =?us-ascii?Q?C1Tktl9w40RSskhH/hpE8sPoWJVu124wEfo69ZzqaJl5Y5EfzrWNbZlGIrtR?=
 =?us-ascii?Q?ypJa/UPx3L22h46GGWydFpyrZRFr/2/2JjMePW2oOHfMFkRmR6I46aVarfyI?=
 =?us-ascii?Q?RVfeGEgGmDjtRevCtAqC9L7ULLIw2bHFfhcxXW1ZMAOZwMPNVXq5dMlmwoJz?=
 =?us-ascii?Q?EBevDsI33iin4zbote3Qdxak1/flSkF9ozk/exWAQWOa14G7p4I+3Ow5McK0?=
 =?us-ascii?Q?GVYDDPNnija3cpYKm4YL7ThA2SfHcv0424KNXzdtEFCT1TaGgIqpM4O44Mif?=
 =?us-ascii?Q?glpO+QgZa8jcyEFq0dLE9l2pobjLWpf0b9DlHJIID/tEuib+jftIIiVNmwM/?=
 =?us-ascii?Q?Gnzfww8EjifJs87ZBxgB7qcAqQB1uCYyBszoC64vn0/vc6VZjQONMJ1KVOuZ?=
 =?us-ascii?Q?zM6OcsRfwQJHUXBdhJavhiaYQtXk4ECOaS+eS1wgJCiWMAeNa3QmJDbda1aq?=
 =?us-ascii?Q?UWgJZKVnMleS0PYa6J7a4BNzUlylWiqPeBkydJInpQPM+IPxLeX/UCClDKaF?=
 =?us-ascii?Q?pnSDFlNZZxo7zEvN6tbVr2Cdt8+X3fLf1sIDFTPMg1CvBJ226cudEHb3JXdl?=
 =?us-ascii?Q?rOBMlFYQCH/NHRgq9D+QFnp9UR/oCD0EKsKre6gLl0Xs59vQ5Tyf6qTdt0qr?=
 =?us-ascii?Q?iNXi23EM3Ja7rPpnyT7/X7SsSOeYJjCuMlod/1Lxk86NHisjsGz/tjAR+4so?=
 =?us-ascii?Q?kjWDQvZn2hyrbi2iNjZ0HAoTSiCXzNZFyfFMI1+wC5fN1JLlWSa9n3ggDZ/p?=
 =?us-ascii?Q?rp1vt4h9Vo+xUxWMhPw=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2025 23:50:46.8494 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ea1f6341-94ff-4e43-97d3-08de27c675f2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0002992C.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9095
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

From: tiancyin <tianci.yin@amd.com>

[Why]
On some servers equipped with huge system memory at multi-terabyte scale,
the PCI bus physical address alignment policy may assign GPUs very large
bus addresses that exceed 44 bits. This causes DMA address overflow errors:

[   83.216803] amdgpu 0000:43:00.0: DMA addr 0x0000210b39000000+8388608
overflow (mask fffffffffff, bus limit 0).

[How]
Enlarge the DMA mask from 44-bit to 48-bit to accommodate larger physical
addresses.

Signed-off-by: tiancyin <tianci.yin@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c | 24 +++++++++++++++++++-----
 drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c | 26 +++++++++++++++++++++-----
 2 files changed, 40 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
index a1f8141f28c9..60393e311537 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
@@ -21,6 +21,7 @@
  *
  */
 #include <linux/firmware.h>
+#include <linux/processor.h>
 #include <linux/pci.h>
 
 #include <drm/drm_cache.h>
@@ -726,7 +727,7 @@ static int gmc_v11_0_gart_init(struct amdgpu_device *adev)
 
 static int gmc_v11_0_sw_init(struct amdgpu_ip_block *ip_block)
 {
-	int r, vram_width = 0, vram_type = 0, vram_vendor = 0;
+	int r, vram_width = 0, vram_type = 0, vram_vendor = 0, dma_mask;
 	struct amdgpu_device *adev = ip_block->adev;
 
 	adev->mmhub.funcs->init(adev);
@@ -805,13 +806,26 @@ static int gmc_v11_0_sw_init(struct amdgpu_ip_block *ip_block)
 	 */
 	adev->gmc.mc_mask = 0xffffffffffffULL; /* 48 bit MC */
 
-	r = dma_set_mask_and_coherent(adev->dev, DMA_BIT_MASK(44));
+#if defined CONFIG_X86 && defined CONFIG_PHYS_ADDR_T_64BIT
+	dma_mask = boot_cpu_data.x86_phys_bits >= 48 ? 48 : 44;
+#else
+	dma_mask = 44;
+#endif
+	r = dma_set_mask_and_coherent(adev->dev, DMA_BIT_MASK(dma_mask));
 	if (r) {
-		dev_warn(adev->dev, "amdgpu: No suitable DMA available.\n");
-		return r;
+		dev_notice(adev->dev,
+			"amdgpu: %d bit DMA is not available, fallback to 44 bit.\n",
+			dma_mask);
+		dma_mask = 44;
+		r = dma_set_mask_and_coherent(adev->dev, DMA_BIT_MASK(dma_mask));
+		if (r) {
+			dev_warn(adev->dev,
+				 "amdgpu: No suitable DMA available.\n");
+			return r;
+		}
 	}
 
-	adev->need_swiotlb = drm_need_swiotlb(44);
+	adev->need_swiotlb = drm_need_swiotlb(dma_mask);
 
 	r = gmc_v11_0_mc_init(adev);
 	if (r)
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
index f4a19357ccbc..5ca3d1141cb3 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
@@ -21,6 +21,7 @@
  *
  */
 #include <linux/firmware.h>
+#include <linux/processor.h>
 #include <linux/pci.h>
 
 #include <drm/drm_cache.h>
@@ -742,7 +743,7 @@ static int gmc_v12_0_gart_init(struct amdgpu_device *adev)
 
 static int gmc_v12_0_sw_init(struct amdgpu_ip_block *ip_block)
 {
-	int r, vram_width = 0, vram_type = 0, vram_vendor = 0;
+	int r, vram_width = 0, vram_type = 0, vram_vendor = 0, dma_mask;
 	struct amdgpu_device *adev = ip_block->adev;
 
 	adev->mmhub.funcs->init(adev);
@@ -802,13 +803,28 @@ static int gmc_v12_0_sw_init(struct amdgpu_ip_block *ip_block)
 	 */
 	adev->gmc.mc_mask = 0xffffffffffffULL; /* 48 bit MC */
 
-	r = dma_set_mask_and_coherent(adev->dev, DMA_BIT_MASK(44));
+#if defined CONFIG_X86 && defined CONFIG_PHYS_ADDR_T_64BIT
+	dma_mask = boot_cpu_data.x86_phys_bits >= 48 ? 48 : 44;
+#else
+	dma_mask = 44;
+#endif
+	r = dma_set_mask_and_coherent(adev->dev, DMA_BIT_MASK(dma_mask));
 	if (r) {
-		printk(KERN_WARNING "amdgpu: No suitable DMA available.\n");
-		return r;
+		printk(KERN_NOTICE
+			"amdgpu: %d bit DMA is not available, fallback to 44 bit.\n",
+			dma_mask);
+		dma_mask = 44;
+		r = dma_set_mask_and_coherent(adev->dev,
+					      DMA_BIT_MASK(dma_mask));
+		if (r) {
+			printk(KERN_WARNING
+			       "amdgpu: No suitable DMA available.\n");
+			return r;
+		}
+
 	}
 
-	adev->need_swiotlb = drm_need_swiotlb(44);
+	adev->need_swiotlb = drm_need_swiotlb(dma_mask);
 
 	r = gmc_v12_0_mc_init(adev);
 	if (r)
-- 
2.34.1

