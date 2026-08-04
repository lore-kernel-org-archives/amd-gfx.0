Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19414C55822
	for <amd-gfx@archiver.kernel.org>; Tue,  4 Aug 2026 12:51:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 92C2D10EA20;
	Tue,  4 Aug 2026 12:51:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="oCsRNZDU";
	dkim-atps=neutral
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012053.outbound.protection.outlook.com
 [40.107.200.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AB2F810EA20
 for <amd-gfx@lists.freedesktop.org>; Tue,  4 Aug 2026 12:51:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EdZFaH9sIa+PDAe43HQm9SAulkjPBgzxxJBpfjyrH5F9urzmNr5Boogxfecn3jTwe765+az4w3Oy24mQ7x0zhlvAKsQPX6COfj0D8+PVSnHTzOAjMiucZ1V01RQrAi99hSF8zdlNP+2O90fgtac3X8wpPE7qCu4Iol/ViClOs7bmwNiyf15KEbrqRpcEplql5C6EX0EFOplyq3KicP6fIImWexeEg3JFyPueQaz7538c4tNuUoZkV97uOZT171xF6AFzKxIr5ikNbxzf/akFYUV8JcBXVnjsusl7kfLWyAaOVeE7F11iqOIL2i+V9P8JpAd/b67A+wc4rpSZZOBbZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zwoKMNH81f3FloIZMmaQvu0z/PqMx1Jripq02YmUj4Q=;
 b=Fb4i2Dr4kk/EyRcwIa1a+1dEMKP6NQjRM0E3MdH2xcoE6PYCbRUaq97BINtp0yIrT8t95SwF8WKsgW57Y2PXzXfoSfoXX+APeBaxqh+xuh4OmsdzZs5z2UFQmiU1+t7bTKwxy1nkeic6pjv2+lQSM7yfB9y9/9j2Bkf98vv+CEenNynhx2hope9VVTKqp2ZsA8uIsatWuR9IbamU9Y6xJZy978snrXVS2HYwfBuMAXp/1E6xdYsb2f7jnA8WZ8eqZPKU4Pj4RFygLbumCQhsxFOejn8lE+MMnFRpfXzmPHsZlJN8IBvXNuq7ia2R7YlOmvBs0WQDYgi2s5pyINUP3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zwoKMNH81f3FloIZMmaQvu0z/PqMx1Jripq02YmUj4Q=;
 b=oCsRNZDUF+dlf6vBEexzFs5ELJMiGthQVpwa3fYZFkm2ZNSaZVGewlls5knrjVzZgn+nV0ztSWvkombJRSgNwxeBZEp8+WSXis3g2SYgrVzOXK4J2w+34j5lPE4DvMs5fchrmkkZ+PiicTB6kvxnferBG5+yI6UQS2R/yPtRooU=
Received: from BN9PR03CA0901.namprd03.prod.outlook.com (2603:10b6:408:107::6)
 by CY8PR12MB7242.namprd12.prod.outlook.com (2603:10b6:930:59::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.18; Tue, 4 Aug
 2026 12:51:34 +0000
Received: from BL02EPF0001A106.namprd05.prod.outlook.com
 (2603:10b6:408:107:cafe::26) by BN9PR03CA0901.outlook.office365.com
 (2603:10b6:408:107::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.292.15 via Frontend Transport; Tue, 4
 Aug 2026 12:51:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL02EPF0001A106.mail.protection.outlook.com (10.167.241.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.292.8 via Frontend Transport; Tue, 4 Aug 2026 12:51:33 +0000
Received: from asad-mlse-vm.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 4 Aug
 2026 07:51:30 -0500
From: Asad Kamal <asad.kamal@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <christian.koenig@amd.com>, <YuanShang.Mao@amd.com>,
 <Tiantian.Zhang@amd.com>, <lijo.lazar@amd.com>, <hawking.zhang@amd.com>,
 <le.ma@amd.com>, <shiwu.zhang@amd.com>, <alexander.deucher@amd.com>,
 <kevinyang.wang@amd.com>, <asad.kamal@amd.com>, Yuansheng Mao
 <yuansheng.mao@amd.com>
Subject: [PATCH 1/2] Revert "drm/amdgpu: fix aperture mapping leak"
Date: Tue, 4 Aug 2026 20:51:15 +0800
Message-ID: <20260804125116.2196299-1-asad.kamal@amd.com>
X-Mailer: git-send-email 2.46.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A106:EE_|CY8PR12MB7242:EE_
X-MS-Office365-Filtering-Correlation-Id: ccd5db53-0224-4dcf-6903-08def2271d06
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700016|23010399003|82310400026|376014|56012099006|10067099003|11063799006|18002099003|13003099007;
X-Microsoft-Antispam-Message-Info: 87piz+8cbSS0E3Ni8JKlcWQFu80lumVqPGB3HCH3wYbewGr7vv40ua+GtmzEVmSKO7glswNRfEqNlCGozPrLtBLPjyKipiPolRW7Bo3O45F/eYPhWZj/YUgFi9IeZG2c+eY6jwt6alyJjhNh3lcByRYs3vFjBmxqYAtULhNQ8AoIo3YuLVcNvFIZ03fVs+xkxSj3RuE5kfCARfZ7h5vBHrZSRzX9Po1YLi4glY33m2O/uq/E7HLmExbBJhfGBsatADeNu2z8t2L5rX0C5sxaX3ZmrYXT3GodplmZX/YNWY7VMm0FKI7dkZBlDcHFSICglw8dpHzTxIWX/P9bc5LomXD96UGpaMoANo+o00cVdh79Hr6Tec/SC1c8m3u24gnlF2DPxWuR7OZ1raFrSG697cawN27kiUXH9rdh41Qyvni7QHkjhBsakK6mPJae5TQGJFDRQ7EwAwL5tPgB2bD4w3JZuE7gPQgFUVm4KbkXMiZWhR3j7F6gvkkXo2MaYoNBTK20SdFTY8ZWlJDBSYEWm3yhkuXmtd3zrwqPZ/LvToxSp+wRu+vJ96hKM98ddLjJWWUinaCy/WF6v1ROtAO/cSqfihGj94/PPPEXL8inIPlegJeXllaF7jxMegq1Rr1JyAf/X4v0GP+abtwH0nVpBA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700016)(23010399003)(82310400026)(376014)(56012099006)(10067099003)(11063799006)(18002099003)(13003099007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: VEHZ/Y4rYprL0Q7EuPpHpQmMBHIOco9+Jambr2PbafCz8ywtGP4VdkgzQ5oXXsnax7/zyb9dX44fK/xYhftur8//L8POcJjysfp4IhC/oaUmFgfH/OuFOvOVoeJd+TKVYq2wEk/2+JfGJ87E+Owbqwpk2EO5JmcuJS9z9ADmDHRwgLuttf+3nbKiU9WCr8w28wTTZVcft+NxyBRKyZ1i9FJd6fYbecH6jTz8DfmNF+CZgWV//Z4VLlqu2VUyJjq/LlGDQ7qTyW913tQCEecNU7IcqeAdh7nvuYm7ZO31aFPP65TFY0XwmOo0yfNM0HpuVB0+OwM1nWneVzmaunLctUYogEy2dTLYNOTadowJ3twkNv1UbJIk1wSy/VoWFu7KfRsZvlITSNKFtoKimk3uRVMgmDzJCzEGdn0me+Rt3PZxpCvhOWqw336zIaBmlQGq
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2026 12:51:33.7364 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ccd5db53-0224-4dcf-6903-08def2271d06
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A106.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7242
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

devres teardown is LIFO. The aperture devres node was registered after
the DRM device node, so devres_release_all() unmaps the aperture before
the DRM device release callback fires amdgpu_device_fini_sw(). IP
sw_fini callbacks (e.g. vcn_v4_0_sw_fini) write to fw_shared through a
pointer derived from aper_base_kaddr, causing a kernel page fault on
probe failure / rollback:

  BUG: unable to handle page fault ... PMD 0
  RIP: vcn_v4_0_sw_fini+0x7b/0x170 [amdgpu]
  Call Trace:
    amdgpu_device_fini_sw
    amdgpu_driver_release_kms
    devm_drm_dev_init_release
    devres_release_all

This reverts commit 3763eacdfba23f3d642dda8d23f0e261653fe7fe.

Fixes: 3763eacdfba2 ("drm/amdgpu: fix aperture mapping leak")
Reported-by: Yuansheng Mao <yuansheng.mao@amd.com>
Closes: https://gitlab.freedesktop.org/drm/amd/issues/SWDEV-599369
Signed-off-by: Asad Kamal <asad.kamal@amd.com>
Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c |  2 ++
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c    | 34 ++++++++++++----------
 2 files changed, 20 insertions(+), 16 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 638dfaf127fd..964efec0d335 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -4185,6 +4185,8 @@ static void amdgpu_device_unmap_mmio(struct amdgpu_device *adev)
 
 	iounmap(adev->rmmio);
 	adev->rmmio = NULL;
+	if (adev->mman.aper_base_kaddr)
+		iounmap(adev->mman.aper_base_kaddr);
 	adev->mman.aper_base_kaddr = NULL;
 
 	/* Memory manager related */
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
index c4094edbdff1..0b00625603c0 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
@@ -2139,23 +2139,17 @@ int amdgpu_ttm_init(struct amdgpu_device *adev)
 	/* Change the size here instead of the init above so only lpfn is affected */
 	amdgpu_ttm_disable_buffer_funcs(adev);
 #ifdef CONFIG_64BIT
-	if (adev->gmc.xgmi.connected_to_cpu) {
-		void *kaddr = devm_memremap(adev->dev, adev->gmc.aper_base,
-					    adev->gmc.visible_vram_size,
-					    MEMREMAP_WB);
-		if (IS_ERR(kaddr))
-			return PTR_ERR(kaddr);
-		adev->mman.aper_base_kaddr = (__force void __iomem *)kaddr;
-	} else if (adev->gmc.is_app_apu) {
+#ifdef CONFIG_X86
+	if (adev->gmc.xgmi.connected_to_cpu)
+		adev->mman.aper_base_kaddr = ioremap_cache(adev->gmc.aper_base,
+				adev->gmc.visible_vram_size);
+	else if (adev->gmc.is_app_apu)
 		DRM_DEBUG_DRIVER(
 			"No need to ioremap when real vram size is 0\n");
-	} else {
-		adev->mman.aper_base_kaddr = devm_ioremap_wc(adev->dev,
-							     adev->gmc.aper_base,
-							     adev->gmc.visible_vram_size);
-		if (!adev->mman.aper_base_kaddr)
-			return -ENOMEM;
-	}
+	else
+#endif
+		adev->mman.aper_base_kaddr = ioremap_wc(adev->gmc.aper_base,
+				adev->gmc.visible_vram_size);
 #endif
 
 	amdgpu_ttm_init_vram_resv_regions(adev);
@@ -2284,6 +2278,7 @@ int amdgpu_ttm_init(struct amdgpu_device *adev)
  */
 void amdgpu_ttm_fini(struct amdgpu_device *adev)
 {
+	int idx;
 	if (!adev->mman.initialized)
 		return;
 
@@ -2306,7 +2301,14 @@ void amdgpu_ttm_fini(struct amdgpu_device *adev)
 	amdgpu_ttm_unmark_vram_reserved(adev, AMDGPU_RESV_FW_VRAM_USAGE);
 	amdgpu_ttm_unmark_vram_reserved(adev, AMDGPU_RESV_DRV_VRAM_USAGE);
 
-	adev->mman.aper_base_kaddr = NULL;
+	if (drm_dev_enter(adev_to_drm(adev), &idx)) {
+
+		if (adev->mman.aper_base_kaddr)
+			iounmap(adev->mman.aper_base_kaddr);
+		adev->mman.aper_base_kaddr = NULL;
+
+		drm_dev_exit(idx);
+	}
 
 	if (!adev->gmc.is_app_apu)
 		amdgpu_vram_mgr_fini(adev);
-- 
2.46.0

