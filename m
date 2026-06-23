Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB276CDB479
	for <amd-gfx@archiver.kernel.org>; Tue, 23 Jun 2026 14:41:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4CA9010EB2B;
	Tue, 23 Jun 2026 14:41:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="HIhkq67z";
	dkim-atps=neutral
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012058.outbound.protection.outlook.com [52.101.48.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2B9ED10EB2B
 for <amd-gfx@lists.freedesktop.org>; Tue, 23 Jun 2026 14:41:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=liCJSId6AtHAI2s9mNNQuPFJxv2+UUzJjW1bIvnBmRzkO+ujRTGPA4Z1vVVr5/ef1LJ3oSgJhplXJMlsILcDUOS4GanuDr/o6qcR4NJgmh3/2gRLQi39+iZfeTqXfRj7ffWU3Jhdltsn6shzthUfdIaYZ5K00/gX0b6y5RtVGw/E1DDk0iPvN1NkIS10iBXfXL1CuzI2KlePJD6WM2P9y+eGGnAoFid8c2sl00zi3Hgn9QWb2SmFzUMwk+9T2LI/UrKEwAp60fFudMa1RnkxYluO+KWxDQMaahSIK29kfv5kP8huvbEON40iGLQeINYFLApUeeC8dZPOaj5KUGrUYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HvRbeJFv+wupdEbeSBUAcyXw9od1SIT89m/Nk49BEMQ=;
 b=DdDl0Wxi4oWehx4Q79N2sjE34L92GLD56XQJ71hvztH3EcJ8uOt6SmkRVnIOL5bSEeX+esvLcGCMf5IbRE6a2pOaIU/nM834m4l7bPm7ZKZSSdCFY3Y/deLkFix/kf1NemgLJq8kHqM1lG7MeXBnnB8JLUukFpRhbG6abtxEB8UmFkkPAOfoOYqmDp4O9cQaBuEFgthEdRKiJ7zksm1ltWIDZjHcZNRZwFpl/XDBnqMEdGXLOlBV691iHoMAPFWZiiTLvIbPoiCt9eN6qHzzJNftiY3h7LB6l8y/2YugyBYsDCP/1m9c1enKKwSg19vHywuQz4npndwUratFsQO99g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HvRbeJFv+wupdEbeSBUAcyXw9od1SIT89m/Nk49BEMQ=;
 b=HIhkq67zXWvdXptK/9pQd2bqTLlIZQy0JCCUJfFJ5osbC0LZIwdK59fTPDn9/xNGJd6Ux126YZj1YV5PkuaItzb7ozcjVsKW5K69FWJ8peeNcbcfS5U6FMIhS1DvxFRh4tHIofwcf9x+wif4zOQiBwiYYc8aVzJXY6mfKdHHgzY=
Received: from PH8P220CA0027.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:348::8)
 by PH0PR12MB5648.namprd12.prod.outlook.com (2603:10b6:510:14b::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.20; Tue, 23 Jun
 2026 14:41:21 +0000
Received: from CY4PEPF0000EE34.namprd05.prod.outlook.com
 (2603:10b6:510:348:cafe::5c) by PH8P220CA0027.outlook.office365.com
 (2603:10b6:510:348::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.159.13 via Frontend Transport; Tue,
 23 Jun 2026 14:41:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000EE34.mail.protection.outlook.com (10.167.242.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.159.10 via Frontend Transport; Tue, 23 Jun 2026 14:41:20 +0000
Received: from asad-mlse-vm.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 23 Jun
 2026 09:41:16 -0500
From: Asad Kamal <asad.kamal@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <lijo.lazar@amd.com>, <hawking.zhang@amd.com>, <le.ma@amd.com>,
 <shiwu.zhang@amd.com>, <alexander.deucher@amd.com>, <kevinyang.wang@amd.com>, 
 <asad.kamal@amd.com>, =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
Subject: [PATCH v2] drm/amdgpu: fix aperture mapping leak
Date: Tue, 23 Jun 2026 22:41:04 +0800
Message-ID: <20260623144104.4079805-1-asad.kamal@amd.com>
X-Mailer: git-send-email 2.46.0
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE34:EE_|PH0PR12MB5648:EE_
X-MS-Office365-Filtering-Correlation-Id: f8bef06c-7231-46c5-972d-08ded1357dc8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700016|376014|82310400026|23010399003|18002099003|56012099006|5023799004|11063799006;
X-Microsoft-Antispam-Message-Info: YZUb/7TI7yUaj5t+5HCExP7ejmrXWsL73BAqBfjduekzqvvu2F9urvkD/LBzUV50Jcn79amAuwHY6ELs/FqTJOqPT0tkuC64V7xuBFBt5fe/kwedmkC1K3OSqvRbAGGSdNWbrlWMJxYE5u1lT4JsNxxnBa5NXpX/eJdrh7GcQzxGqnP0tJDurDTYwOEyvVIucsDR6n2QDeXNFeiaN65kBDcutY577WoFDVb6RpjXibG31kr4H3Q8VB5G0gJibpEkpglKWlRFcE7fiMzucqB5v1AmkMEfWfEj11Z4wuOhBwGTdt51l5H6e8mnOgHtNnZEkpkK/O0xGEHuNFCeAh5NqILIygrg58cytaozv8c/qrkKUbVrrly6ucq5ciLJTe3FnlSwQ07a3pC6Z2j5WvA+AFjNlQUPgx//gIyJ65DaizdmYC2NDjZyRVSoIKyPIYYDZ1pJpE7xvt1EKyrpg0nblrDvZnNy2GolQFdGeRngsmNKt6T5Za+kIJ069RCnaxCik3IRNzjpBpVyWLjivBUcqLHJZTxDM8jr9ljVp8p6mgofVJ0VKPdmuF0UpUvBgKGM2U/+OUHEizS9zw4YkBVYLxbmSbyjpUZ70lLumZr0X9FAEL4Y3/yF4thFeyp0MTtvTwfRBeXQpFsePoBnbDVHCbuoWMZJUixcvjPyW7Fi5ATh6/q4TqOHackb/DbsEh5wP4UCZrOoDhx9IAf3ur/kwA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700016)(376014)(82310400026)(23010399003)(18002099003)(56012099006)(5023799004)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: lYmbI1v6Ch6YpjWkSmWFUtpWR0kTInwo4kVB+fJuNpwudEMJ0amlNhSJpW2TJbxeMCTmuV342GHNh/tRSIWsBKBMzAMa4aQ8TmigrARgpwzGfBsADNXXMlpG+1gdhRx3ny8d9bzjdMAINWdpy33DO2nYr/cGLEYRwaE84OT5PBp+ENpniv4SLu/krIaU2wzZo5XSqFe7x9n7p/kIykgRLWm6N8ueiRfH9ppI02e2CcxsMSJ+Dg2rEcCtKWLy6ii/wG1xPGk5IapMKA5bP6speN10HZewEShfwSdmVRTVO84+hExVvfun1TULa6gavMDofee9utZltwlG1KcTsLQKKYCM8WAJtmzhYc6cprpW0j8ufwaxAzOBdM8QyjLNX9ZScDrHDNVp/eMTqprN2ukBJhWpNh0Rsv48u0R9Lz4JkY3PpkEoTQw/0xhW+3NzYVdK
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2026 14:41:20.6059 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f8bef06c-7231-46c5-972d-08ded1357dc8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE34.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5648
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
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c    | 39 +++++++++-------------
 2 files changed, 15 insertions(+), 26 deletions(-)

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
index f80371bc74d7..352ea6820fcb 100644
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
+	if (adev->gmc.xgmi.connected_to_cpu) {
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

