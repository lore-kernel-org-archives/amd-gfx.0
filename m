Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79689C7EE23
	for <amd-gfx@archiver.kernel.org>; Tue,  9 May 2023 22:23:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EACFD10E43F;
	Tue,  9 May 2023 22:22:59 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2060a.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eb2::60a])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6AF3610E43B
 for <amd-gfx@lists.freedesktop.org>; Tue,  9 May 2023 22:22:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PFPwRCBHtBDJ0dvnqimzWONI101oA9zO3lPmJVTIleN/JBxiz8jvhKFxYyI0yMkEsaeUNJbNqmLXuMOCdKFZ2e4HR0Kc9b4pWJcbgoubiEoSbepJpoW0PKGunZ615/0YhRjGqB9khdsku/5NdCJpBQJlpDBiVC8BIhh7QOrL1do1X0220zL01p4NjmbXkd4G+Jlp1iB/aEK817xqLtl1GN9Re3gSYwF04iXNsOqTVAbNDdykejo+5Fsnh0h5lu4cve3Tb7hT2Y1UiETVv2hN3ubHPcD3gIdxeah7nae/mSjCWRlm9hmutoxuVmYsR8feWU8/+XVPk+FEQBZ4EJc8kg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wzSRdsbTS06i0sDNCyxmbwzhhks3kRjAYtj9afnAmpI=;
 b=kLSO9tViflyq3RFMK+UDU477C3pMyluan0I8KvC2XqbRcPHXxho+aDZyoRbl9BBaNudNljYRD6PdZNrGUGPprtb+A+xmbW0CC5jIh+2ElrZ84HBQdVdKFTKdLUxzGnsELiEf0hYTzuAWbF4rxIRb1bC1dDxvPd0M/qr3vRXzCK4quMFG9vY567m9Yf02GjuvMNQusRYHXUiZdQobMn88AL4bb5XNPQggpUFZSJQ5PfamHB8X252Qa6LsKHfaPackYPAAbtJUr6NNhNfIT9z65CTB7XzVXFb2OKs81M33uS0Sl6RqjE/BkR3PX5WIOkh8aKtS9xa1HX+46zfYZ+AP4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wzSRdsbTS06i0sDNCyxmbwzhhks3kRjAYtj9afnAmpI=;
 b=lxYa4bfeZfqRAi0H+U5RgjBIi+nf/mnzF0Wkxp1pXvHSmUWsB2m6no6lWMVcioNqCGbiUV3iy+aIC99T/aSLAyrtwCqrsvt5Z/TptxRfzf/rQpf6JOb/vRqulZxyCE0nVaF5206OD3QsGCcMbbQ5U1c+iWdmdeLEhVpbNzyKUsg=
Received: from BN0PR04CA0071.namprd04.prod.outlook.com (2603:10b6:408:ea::16)
 by DS0PR12MB9058.namprd12.prod.outlook.com (2603:10b6:8:c6::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.33; Tue, 9 May
 2023 22:22:53 +0000
Received: from BN8NAM11FT013.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:ea:cafe::29) by BN0PR04CA0071.outlook.office365.com
 (2603:10b6:408:ea::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.18 via Frontend
 Transport; Tue, 9 May 2023 22:22:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT013.mail.protection.outlook.com (10.13.176.182) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6387.18 via Frontend Transport; Tue, 9 May 2023 22:22:52 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 9 May
 2023 17:22:51 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 4/6] drm/amdkfd: Move pgmap to amdgpu_kfd_dev structure
Date: Tue, 9 May 2023 18:22:35 -0400
Message-ID: <20230509222237.478097-4-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230509222237.478097-1-alexander.deucher@amd.com>
References: <20230509222237.478097-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT013:EE_|DS0PR12MB9058:EE_
X-MS-Office365-Filtering-Correlation-Id: 8013fceb-2beb-4374-c532-08db50dbee29
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BL9BkNhbuIAZxiqtU9hR9SRvlQzaCN6DIayS/fb/TrKvsO8n45UQ0iyIzmTQAGx0UKBfWjfP3HmXXBWffwp2GzmkNVQIDo3RXMQaiAjfpJl4JqI0HWPuzVcEHG5SORWBCFx95fJgwpgEtvN/pFpy4SCoulDaE3UNS2qJG6tmvLza+gGP0TG1rE3zXw9PgyN9qNVadt0gXggsBs+ou6geJzQh/qS80OLYy+FAxRFwGp9ZvgL/xhEKpB1hfB+a92PER2xTyKCHCqQoPw60dNnIgxWBjRckyTBWM8+tqJ32g5uCajfy88MgvX4wgNYu2cVaY+tYFlmx1ybjk6qcXZYUqLCFrWaVWQtmmfbT9RU3dmOBUp+pLHqb0SuAzCRkn/OGjlVziLsBp9hQrB4wArKXg8g58stGgUL49exkqeHyy9WIIgRKo1Hoqy9xP0gJXKTdaA/nMYstf9pMTDnoq2N8Vyb05JqQKG7Xc+F5VwctL/UNb4i5g0vAaBMRs8gd/CZlvGuR7DPlvO+rRPhdcrruO1bW5Lj9kpqV2NYxRIZVKR+LH69wMLtMerIf+lupm7ynsSFsWDlRR5xpUmplbEyaH91dsfpLB5YDsmmOT4XxqhDsUy9lYWv4hNcUXGde/CuOygWRqFbt4aBXtUAQQNVnbz1wvA+kNeILU9GoSx0jlSC1TbetTtOdi6ZQbQhwypysI2yh0SEsZDdTLGhzC368hI9u0L/Ld9HdReLnhfjMlc4=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(39860400002)(396003)(346002)(136003)(376002)(451199021)(46966006)(36840700001)(40470700004)(2906002)(40460700003)(41300700001)(8936002)(8676002)(5660300002)(36756003)(82310400005)(40480700001)(7696005)(6666004)(26005)(1076003)(478600001)(86362001)(36860700001)(336012)(83380400001)(2616005)(47076005)(426003)(16526019)(186003)(316002)(82740400003)(356005)(6916009)(70206006)(70586007)(81166007)(54906003)(4326008)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2023 22:22:52.6363 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8013fceb-2beb-4374-c532-08db50dbee29
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT013.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9058
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Philip Yang <Philip.Yang@amd.com>,
 Felix Kuehling <Felix.Kuehling@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Philip Yang <Philip.Yang@amd.com>

VRAM pgmap resource is allocated every time when switching compute
partitions because kfd_dev is re-initialized by post_partition_switch,
As a result, it causes memory region resource leaking and system
memory usage accounting unbalanced.

pgmap resource should be allocated and registered only once when loading
driver and freed when unloading driver, move it from kfd_dev to
amdgpu_kfd_dev.

Signed-off-by: Philip Yang <Philip.Yang@amd.com>
Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h | 4 ++++
 drivers/gpu/drm/amd/amdkfd/kfd_migrate.c   | 8 ++++----
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h      | 3 ---
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c       | 6 +++---
 drivers/gpu/drm/amd/amdkfd/kfd_svm.h       | 4 ++--
 drivers/gpu/drm/amd/amdkfd/kfd_topology.c  | 2 +-
 6 files changed, 14 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
index 9cc28fe32cdb..844cc366ad7c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
@@ -30,6 +30,7 @@
 #include <linux/kthread.h>
 #include <linux/workqueue.h>
 #include <linux/mmu_notifier.h>
+#include <linux/memremap.h>
 #include <kgd_kfd_interface.h>
 #include <drm/ttm/ttm_execbuf_util.h>
 #include "amdgpu_sync.h"
@@ -101,6 +102,9 @@ struct amdgpu_kfd_dev {
 	uint64_t vram_used_aligned;
 	bool init_complete;
 	struct work_struct reset_work;
+
+	/* HMM page migration MEMORY_DEVICE_PRIVATE mapping */
+	struct dev_pagemap pgmap;
 };
 
 enum kgd_engine_type {
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
index 42e599912e52..199d32c7c289 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
@@ -206,7 +206,7 @@ svm_migrate_copy_done(struct amdgpu_device *adev, struct dma_fence *mfence)
 unsigned long
 svm_migrate_addr_to_pfn(struct amdgpu_device *adev, unsigned long addr)
 {
-	return (addr + adev->kfd.dev->pgmap.range.start) >> PAGE_SHIFT;
+	return (addr + adev->kfd.pgmap.range.start) >> PAGE_SHIFT;
 }
 
 static void
@@ -236,7 +236,7 @@ svm_migrate_addr(struct amdgpu_device *adev, struct page *page)
 	unsigned long addr;
 
 	addr = page_to_pfn(page) << PAGE_SHIFT;
-	return (addr - adev->kfd.dev->pgmap.range.start);
+	return (addr - adev->kfd.pgmap.range.start);
 }
 
 static struct page *
@@ -990,14 +990,14 @@ static const struct dev_pagemap_ops svm_migrate_pgmap_ops = {
 
 int svm_migrate_init(struct amdgpu_device *adev)
 {
-	struct kfd_dev *kfddev = adev->kfd.dev;
+	struct amdgpu_kfd_dev *kfddev = &adev->kfd;
 	struct dev_pagemap *pgmap;
 	struct resource *res = NULL;
 	unsigned long size;
 	void *r;
 
 	/* Page migration works on Vega10 or newer */
-	if (!KFD_IS_SOC15(kfddev))
+	if (!KFD_IS_SOC15(kfddev->dev))
 		return -EINVAL;
 
 	pgmap = &kfddev->pgmap;
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
index 02a90fd7f646..214d950f948e 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
@@ -378,9 +378,6 @@ struct kfd_dev {
 
 	int noretry;
 
-	/* HMM page migration MEMORY_DEVICE_PRIVATE mapping */
-	struct dev_pagemap pgmap;
-
 	struct kfd_node *nodes[MAX_KFD_NODES];
 	unsigned int num_nodes;
 };
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
index 8a1075eed5b4..83f8e4e50315 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -173,7 +173,7 @@ svm_range_dma_map_dev(struct amdgpu_device *adev, struct svm_range *prange,
 
 			addr[i] = (hmm_pfns[i] << PAGE_SHIFT) +
 				   bo_adev->vm_manager.vram_base_offset -
-				   bo_adev->kfd.dev->pgmap.range.start;
+				   bo_adev->kfd.pgmap.range.start;
 			addr[i] |= SVM_RANGE_VRAM_DOMAIN;
 			pr_debug_ratelimited("vram address: 0x%llx\n", addr[i]);
 			continue;
@@ -2826,7 +2826,7 @@ svm_range_restore_pages(struct amdgpu_device *adev, unsigned int pasid,
 	bool migration = false;
 	int r = 0;
 
-	if (!KFD_IS_SVM_API_SUPPORTED(adev->kfd.dev)) {
+	if (!KFD_IS_SVM_API_SUPPORTED(adev)) {
 		pr_debug("device does not support SVM\n");
 		return -EFAULT;
 	}
@@ -3111,7 +3111,7 @@ int svm_range_list_init(struct kfd_process *p)
 	spin_lock_init(&svms->deferred_list_lock);
 
 	for (i = 0; i < p->n_pdds; i++)
-		if (KFD_IS_SVM_API_SUPPORTED(p->pdds[i]->dev->kfd))
+		if (KFD_IS_SVM_API_SUPPORTED(p->pdds[i]->dev->adev))
 			bitmap_set(svms->bitmap_supported, i, 1);
 
 	return 0;
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.h b/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
index 7515ddade3ae..021def496f5a 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
@@ -200,8 +200,8 @@ void svm_range_list_lock_and_flush_work(struct svm_range_list *svms, struct mm_s
 /* SVM API and HMM page migration work together, device memory type
  * is initialized to not 0 when page migration register device memory.
  */
-#define KFD_IS_SVM_API_SUPPORTED(dev) ((dev)->pgmap.type != 0 ||\
-				       (dev)->adev->gmc.is_app_apu)
+#define KFD_IS_SVM_API_SUPPORTED(adev) ((adev)->kfd.pgmap.type != 0 ||\
+					(adev)->gmc.is_app_apu)
 
 void svm_range_bo_unref_async(struct svm_range_bo *svm_bo);
 
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
index d2a42b6b1fa8..6d6243b978e1 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
@@ -2021,7 +2021,7 @@ int kfd_topology_add_device(struct kfd_node *gpu)
 		dev->node_props.capability |= (dev->gpu->adev->ras_enabled != 0) ?
 			HSA_CAP_RASEVENTNOTIFY : 0;
 
-	if (KFD_IS_SVM_API_SUPPORTED(dev->gpu->adev->kfd.dev))
+	if (KFD_IS_SVM_API_SUPPORTED(dev->gpu->adev))
 		dev->node_props.capability |= HSA_CAP_SVMAPI_SUPPORTED;
 
 	kfd_debug_print_topology();
-- 
2.40.1

