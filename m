Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19CE0C4167B
	for <amd-gfx@archiver.kernel.org>; Tue,  7 Nov 2023 16:58:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A737310E62E;
	Tue,  7 Nov 2023 16:58:42 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2058.outbound.protection.outlook.com [40.107.94.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1BCB910E623
 for <amd-gfx@lists.freedesktop.org>; Tue,  7 Nov 2023 16:58:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hbf7CCq5gkn3nPBaivgdWFA+txmNQFQKKGJa3hC59Y8gldvWIVo+TOykC2c74JuuHKPIZFyryBj4iG5TQOgMy+XncaAVHpYfiVxGQ/P/SQ9cZ9pZmwgmfEzzPOpTSHFwrc6QJnwIV9qBwUGifZxQbINl1lLKsOESEtWDSTXbG0V5MrDWm9sYvZdWomeNuR35p4GXfgpeZIEOaRW5CNHoYnbdvmJu7Eqk3SwmGKWaWot0GJG2lYPq540YZ1A2EJ+Y+Ybir6Y8raWwW7KmplgKl26LuiAKeIH2NLWOX8Wpi2/fA/q0d53oX99+Rr6MvlvpzqAiRth8qIOFwDetHp0dHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dom0y6XUtYM7kJpD3mXnBYOs7Zy+QpGkNG6z8LLSnQQ=;
 b=JfxTW0WzmIG2XS7iOFZJ04XERPUAX2sqr/QxFjlsN5dCfjo4hHtS1genLJJIcjc/0ehISk24IHxiU249YjfBm5vf7ZiFoCzxI74u1IapomnA067H+SVx4qBsJqPW7uuxx9OIeDDFdzG5U+Wkz7OsoFVEJBAQLhVg1YjirmncQeqAzgyZSx4OPs6TDsf36fVajJFu+jEWopPJSnqKBk1+jebDkPCba9gEX3YsjAW73yLpc2ptBjJsZasdS/KAJRWTZZh2QQ+g3y+oBFWRN7Ojo3aglgiXvHpIPSoP9LNj7tThm974zvQu+FbUKLngYN4/3J9nxq+SpTZuIntvUdxVLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dom0y6XUtYM7kJpD3mXnBYOs7Zy+QpGkNG6z8LLSnQQ=;
 b=l44sMTeoloaRMciLSSJk+YEntt62Ej2lomFUWGVUOTCv/+NoKu33BxiWb68ZN5KACQqhJh+YEaSCEiTFRttolGhait3sWumYg2Qd2GoRGtFOaEC7YQLEajVurB3l+W7WuSnBUDrk/Mt7BqUBPzBOxf65I8Jb6AavI+C8Hhx4shQ=
Received: from CH2PR18CA0011.namprd18.prod.outlook.com (2603:10b6:610:4f::21)
 by CYXPR12MB9320.namprd12.prod.outlook.com (2603:10b6:930:e6::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.29; Tue, 7 Nov
 2023 16:58:35 +0000
Received: from DS2PEPF00003446.namprd04.prod.outlook.com
 (2603:10b6:610:4f:cafe::f3) by CH2PR18CA0011.outlook.office365.com
 (2603:10b6:610:4f::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.29 via Frontend
 Transport; Tue, 7 Nov 2023 16:58:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF00003446.mail.protection.outlook.com (10.167.17.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6977.16 via Frontend Transport; Tue, 7 Nov 2023 16:58:33 +0000
Received: from Harpoon.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Tue, 7 Nov
 2023 10:58:31 -0600
From: Felix Kuehling <Felix.Kuehling@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 4/6] drm/amdkfd: Export DMABufs from KFD using GEM handles
Date: Tue, 7 Nov 2023 11:58:12 -0500
Message-ID: <20231107165814.3628510-4-Felix.Kuehling@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231107165814.3628510-1-Felix.Kuehling@amd.com>
References: <20231107165814.3628510-1-Felix.Kuehling@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003446:EE_|CYXPR12MB9320:EE_
X-MS-Office365-Filtering-Correlation-Id: eacff5aa-479d-4a62-d517-08dbdfb2c6ea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WbjRYywcQnzv5PrsCjddZh5W1T2lEXb9zS+A4m3UQNya7TYD2hyD348+PvruZsMvdno/ipwmpCdRg2nxp5iLSA+vrsaiuxr6ZAmTgVMGfWuuwYRcM5XAxBoXEwxopGdkK4YyZzgJQOZkNEIOSDlTbU0stIWk6reVlOgyelyleX9xuX1FkINEfKt6ZpMoIRiMCGGsJe1CCQ2HPz/lV5TVQwv2mqRRUNQQWQpMPDpSUqPEuU5b9CDl6tapK9gLFLHMdjpfBg/npN2KcuMphu7xyGhG293MefisIVkVr393KEyoVAe5Z728xgWIBoylzfcXqJqJN+CeMPi5O9qb7tAmTJYHZyNSpHxTcizgaSjT1LTQySiHbl5NcPnil1kk+1o0+dQAHIQ4mzhlCQdxZsojz6yy/zOpaKwK4dznRKI+rcCiC9f6Una55nJlWJwk0tzPjn+XIZKBbZyTp2L2EZTn4+9e3L/nRdroALYIlBQ4OzJVNukM9fhDD8l3ww9Wpckro7PASbVhgn7KHk7KAfJgTqwrrD/h46D955Duy4dhdII/Pvi0ogU27U8P1qg4yoS06ialyRj2i/tSRkK4DDt26YiWZaLLW8xrJXlKEoxAVEqh9W9calu625iByXn10jxecrQ3BdGDguvWRXU0CuA8z2v3Tj2a4fUtAV3PmkASuYyMFxr69Sn+irB2ekAe2xBj4wYlYbRCQNgl3oOPn3NT7BJmTI8ccwIG6XtNBhI4JFvi3LTBBF6IPxkxGJA8MmWToaK6NR4ATPtgsc2qU4FaIw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(346002)(39860400002)(396003)(136003)(376002)(230922051799003)(451199024)(82310400011)(186009)(1800799009)(64100799003)(46966006)(36840700001)(40470700004)(36860700001)(5660300002)(40460700003)(2906002)(16526019)(86362001)(36756003)(81166007)(41300700001)(356005)(82740400003)(478600001)(83380400001)(8676002)(8936002)(4326008)(1076003)(2616005)(426003)(54906003)(316002)(6916009)(70206006)(70586007)(26005)(47076005)(6666004)(7696005)(336012)(40480700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2023 16:58:33.6414 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: eacff5aa-479d-4a62-d517-08dbdfb2c6ea
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF00003446.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR12MB9320
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
Cc: xiaogang.chen@amd.com, ramesh.errabolu@amd.com, christian.koenig@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Create GEM handles for exporting DMABufs using GEM-Prime APIs. The GEM
handles are created in a drm_client_dev context to avoid exposing them
in user mode contexts through a DMABuf import.

Signed-off-by: Felix Kuehling <Felix.Kuehling@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c    | 11 +++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h    |  5 +++
 .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c  | 33 +++++++++++++++----
 drivers/gpu/drm/amd/amdkfd/kfd_chardev.c      |  4 +--
 4 files changed, 44 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
index 6ab17330a6ed..b0a67f16540a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
@@ -142,6 +142,7 @@ void amdgpu_amdkfd_device_init(struct amdgpu_device *adev)
 {
 	int i;
 	int last_valid_bit;
+	int ret;
 
 	amdgpu_amdkfd_gpuvm_init_mem_limits();
 
@@ -160,6 +161,12 @@ void amdgpu_amdkfd_device_init(struct amdgpu_device *adev)
 			.enable_mes = adev->enable_mes,
 		};
 
+		ret = drm_client_init(&adev->ddev, &adev->kfd.client, "kfd", NULL);
+		if (ret) {
+			dev_err(adev->dev, "Failed to init DRM client: %d\n", ret);
+			return;
+		}
+
 		/* this is going to have a few of the MSBs set that we need to
 		 * clear
 		 */
@@ -198,6 +205,10 @@ void amdgpu_amdkfd_device_init(struct amdgpu_device *adev)
 
 		adev->kfd.init_complete = kgd2kfd_device_init(adev->kfd.dev,
 							&gpu_resources);
+		if (adev->kfd.init_complete)
+			drm_client_register(&adev->kfd.client);
+		else
+			drm_client_release(&adev->kfd.client);
 
 		amdgpu_amdkfd_total_mem_size += adev->gmc.real_vram_size;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
index 68d534a89942..4caf8cece028 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
@@ -32,6 +32,7 @@
 #include <linux/mmu_notifier.h>
 #include <linux/memremap.h>
 #include <kgd_kfd_interface.h>
+#include <drm/drm_client.h>
 #include <drm/ttm/ttm_execbuf_util.h>
 #include "amdgpu_sync.h"
 #include "amdgpu_vm.h"
@@ -84,6 +85,7 @@ struct kgd_mem {
 
 	struct amdgpu_sync sync;
 
+	uint32_t gem_handle;
 	bool aql_queue;
 	bool is_imported;
 };
@@ -106,6 +108,9 @@ struct amdgpu_kfd_dev {
 
 	/* HMM page migration MEMORY_DEVICE_PRIVATE mapping */
 	struct dev_pagemap pgmap;
+
+	/* Client for KFD BO GEM handle allocations */
+	struct drm_client_dev client;
 };
 
 enum kgd_engine_type {
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
index 0c1cb6048259..4bb8b5fd7598 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
@@ -25,6 +25,7 @@
 #include <linux/pagemap.h>
 #include <linux/sched/mm.h>
 #include <linux/sched/task.h>
+#include <linux/fdtable.h>
 #include <drm/ttm/ttm_tt.h>
 
 #include "amdgpu_object.h"
@@ -804,13 +805,22 @@ kfd_mem_dmaunmap_attachment(struct kgd_mem *mem,
 static int kfd_mem_export_dmabuf(struct kgd_mem *mem)
 {
 	if (!mem->dmabuf) {
-		struct dma_buf *ret = amdgpu_gem_prime_export(
-			&mem->bo->tbo.base,
+		struct amdgpu_device *bo_adev;
+		struct dma_buf *dmabuf;
+		int r, fd;
+
+		bo_adev = amdgpu_ttm_adev(mem->bo->tbo.bdev);
+		r = drm_gem_prime_handle_to_fd(&bo_adev->ddev, bo_adev->kfd.client.file,
+					       mem->gem_handle,
 			mem->alloc_flags & KFD_IOC_ALLOC_MEM_FLAGS_WRITABLE ?
-				DRM_RDWR : 0);
-		if (IS_ERR(ret))
-			return PTR_ERR(ret);
-		mem->dmabuf = ret;
+					       DRM_RDWR : 0, &fd);
+		if (r)
+			return r;
+		dmabuf = dma_buf_get(fd);
+		close_fd(fd);
+		if (WARN_ON_ONCE(IS_ERR(dmabuf)))
+			return PTR_ERR(dmabuf);
+		mem->dmabuf = dmabuf;
 	}
 
 	return 0;
@@ -1826,6 +1836,9 @@ int amdgpu_amdkfd_gpuvm_alloc_memory_of_gpu(
 		pr_debug("Failed to allow vma node access. ret %d\n", ret);
 		goto err_node_allow;
 	}
+	ret = drm_gem_handle_create(adev->kfd.client.file, gobj, &(*mem)->gem_handle);
+	if (ret)
+		goto err_gem_handle_create;
 	bo = gem_to_amdgpu_bo(gobj);
 	if (bo_type == ttm_bo_type_sg) {
 		bo->tbo.sg = sg;
@@ -1877,6 +1890,8 @@ int amdgpu_amdkfd_gpuvm_alloc_memory_of_gpu(
 err_pin_bo:
 err_validate_bo:
 	remove_kgd_mem_from_kfd_bo_list(*mem, avm->process_info);
+	drm_gem_handle_delete(adev->kfd.client.file, (*mem)->gem_handle);
+err_gem_handle_create:
 	drm_vma_node_revoke(&gobj->vma_node, drm_priv);
 err_node_allow:
 	/* Don't unreserve system mem limit twice */
@@ -1991,8 +2006,12 @@ int amdgpu_amdkfd_gpuvm_free_memory_of_gpu(
 
 	/* Free the BO*/
 	drm_vma_node_revoke(&mem->bo->tbo.base.vma_node, drm_priv);
-	if (mem->dmabuf)
+	if (!mem->is_imported)
+		drm_gem_handle_delete(adev->kfd.client.file, mem->gem_handle);
+	if (mem->dmabuf) {
 		dma_buf_put(mem->dmabuf);
+		mem->dmabuf = NULL;
+	}
 	mutex_destroy(&mem->lock);
 
 	/* If this releases the last reference, it will end up calling
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
index 06988cf1db51..4417a9863cd0 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
@@ -1855,8 +1855,8 @@ static uint32_t get_process_num_bos(struct kfd_process *p)
 	return num_of_bos;
 }
 
-static int criu_get_prime_handle(struct kgd_mem *mem, int flags,
-				      u32 *shared_fd)
+static int criu_get_prime_handle(struct kgd_mem *mem,
+				 int flags, u32 *shared_fd)
 {
 	struct dma_buf *dmabuf;
 	int ret;
-- 
2.34.1

