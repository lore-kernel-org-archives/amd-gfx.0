Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36ECB606A31A
	for <amd-gfx@archiver.kernel.org>; Thu, 29 Oct 2026 04:09:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=IRJqQJpL
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B5C8610E77A;
	Thu, 29 Oct 2026 04:09:48 +0000 (UTC)
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013009.outbound.protection.outlook.com
 [40.93.201.9])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1A22510E77A
 for <amd-gfx@lists.freedesktop.org>; Thu, 29 Oct 2026 04:09:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GbKDWcT8Sl8Qk3c/4YrbX6P3cflm/SuCrKBFyY/wXoiZcHblF/IS/GUeR7+W1vg45lVhxGtdWH7GMaihlTde27+JDE2MBFGoPNLwEttiAR3Xgh7GHC9r13bR2n4Hed22T9arae1Ii+79I39sc9w/ZFfwOdwl6frJHqRMVFWhOToHPh76YxUR/gUXzDmtCfQWtlXDOnOQPWIFMk2yhrLODIFZTV4wrRPxrtk5d64omO5vHxOVJrrLa8JFDi6hBkp9VqXj/3M+k1WedU2U8foiafPqCgfjNDgGRyqQQvtksjeW9nDRSTvU1bOeaPcFugKPEW6PM9Z8dM7Sp52Hw8Bp/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zS0TAhYFmM0IN+bGgrzOuE2jnpkOyGQPhRRKipQMFTE=;
 b=gKFZlcdfwh984UocQjxjtLtHpR0ZVKB6SVsaQJ0fanJRxaFq6G+Fzm+Pfqgte782i2nvtKoKm7ZzfPW6ynPhU4vhVg/Pz5mLbryYi5ZvXX9VeEHTYswCRkShIxbiPfN2wmdEAEJSxTjlkRrVWUMZkMTkGfo3Z0PrBKge/k5MHeeGRjhUTmX5Qzi7xU1F3FQoxDklnrU7QbvaV2vcxYnXqzbocxPsyepiWhFqAkcjZU9pYa92RvRVv2KDFEoEUpdzwI4Lqsq5YKFu35pW2M3WIlJEK2aqp+F1414tLKrzgV9u9slco3Z4/wi/0eCnm2lOEBt25Ty8Wu9c4PrQgUDmTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zS0TAhYFmM0IN+bGgrzOuE2jnpkOyGQPhRRKipQMFTE=;
 b=IRJqQJpLNl/UthQ87IG+BzxrpGDy3Ah26bdy2jhSvCyaT1cj7cWmeNXBXigExmPmRyeub1nJ9zwqitolki22u7ANvQcuVb7HsU1GzEeNRjhiKlZW5iKaQKkiizYddxW+mRib6NXE68SlVN7n1jPtHDK8/NUdv6HwyM1UElMC3AU=
Received: from MW4PR04CA0213.namprd04.prod.outlook.com (2603:10b6:303:87::8)
 by BN7PPF0D942FA9A.namprd12.prod.outlook.com (2603:10b6:40f:fc02::6c7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.8; Thu, 29 Oct
 2026 04:09:36 +0000
Received: from MWH0EPF000C618B.namprd02.prod.outlook.com
 (2603:10b6:303:87:cafe::1e) by MW4PR04CA0213.outlook.office365.com
 (2603:10b6:303:87::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.569.8 via Frontend Transport; Thu, 29
 Oct 2026 04:09:36 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MWH0EPF000C618B.mail.protection.outlook.com (10.167.249.123) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.569.4 via Frontend Transport; Thu, 29 Oct 2026 04:09:36 +0000
Received: from amd-desktop.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Wed, 28 Oct
 2026 23:09:34 -0500
From: Shahyan Soltani <shahyan.soltani@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <alexander.deucher@amd.com>, <christian.koenig@amd.com>
Subject: [PATCH v3 1/2] drm/amdgpu: defer amdgpu_vm_pt_clear() to validation
Date: Thu, 29 Oct 2026 00:09:21 -0400
Message-ID: <20261029040922.3911530-2-shahyan.soltani@amd.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261029040922.3911530-1-shahyan.soltani@amd.com>
References: <20261029040922.3911530-1-shahyan.soltani@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000C618B:EE_|BN7PPF0D942FA9A:EE_
X-MS-Office365-Filtering-Correlation-Id: 6053ae75-5d45-4a9c-e21f-08df357271db
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|376014|82310400026|36860700016|261028144727099003|261021121427099003|56012099006|11063799006|261009223027099003|261022105027099003|261022075727099003|261026121527099003|261021123027099003|261026140227099003|10067099003|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info: FOK6grqWeD5cIY2loL6vMG6KM9fyCCSZ2NrSDWcMhF51tCppaVRW+8wbTJm09roU7iqvrE8vj5osIeY5ZUGCXiecCKf0yMVct5FtahtKiZOlqhv9aAtP+BX6OLlkDypW8VAXLXOOnEswSp7WCRqbnzIjQKP3WS01GiDgNBIkmbzSc9bZlYm4n2XUYca+iHAAWWH+vi+M+unYf06WzfW0UWZ+tA55fK/Zn5VFkxVsBE3EwIdjwZM1ede1Q2eHWvGCft3A6ZrtoVKjwlJ0jw2wZgFAs/jo2XhFfB7INJ6MkVqAJpG5Asx1kVLK6fenH2DcFb5SYcP11kDY7giMgbhLGDJicUO19TVQdq6EGbpdIbu5/N835FjMoDezxIATYe+7DWCXN2neIBdRfLH6X4Wb//8JuOasktpY+Fn+8KPdQN+ZmxX9P4CgxS9FLLTXBX1eje9EloY/akIe8gK6bhQXU3sOjFNx4z9yLKaqDlIMrLP/BO5/zrlrqleJMWKnmBgDmfvTGNyBiiM4z7KiN40vjXd22QujY0VaEGlqwV/pN1HSqBjsK0xVvdeb8bIYn3ZZesfV2+JfdEM2LTGI0nO3yAkbK0jH+kz53rYkW7zFGDvA5KlcrndjV8KgE6RktSIE5sr2EbV99LE/oQS3oYXbf84FHsyCcoglJvVvH8cgeefrONf4gZxgQhMsz+qghVQlTT4U3vwrbd/iSMNwo2ipRg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(376014)(82310400026)(36860700016)(261028144727099003)(261021121427099003)(56012099006)(11063799006)(261009223027099003)(261022105027099003)(261022075727099003)(261026121527099003)(261021123027099003)(261026140227099003)(10067099003)(18002099003)(22082099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: ZqOXnNeN3o6ETtTUN4xU5Jvajyyhi8uSCD7BdIoVoppRtADAm+zsDDs7AExtR2fM3hoqcJ8kiG2iqS+5lUP9LA1tfH5OnckhIg5gAm1+c/6TDoplCv9KWISiP4nMqg9RzPVU2fKL8BCKY1ZRm6ZnzsZs/wKpji4nCVGUioNhcc2dwtJUEYhoLlx9fbTwBXEr2lfvq+YtG06eLTix18XAQJZ7WB9z1YJI71IqdnFf0Otq05wWmsSBYVolZl/KmWSE7phIGMOWdQwy6O/cl5DlKFJEU46cr+6V3zJiev34TIcttmGhTL1582125DB6Cahc29HGJGHEw2qXKyHoKQ3EdaPhg3O25bzYku9i53ID96S4mc6Re4Qg64pyNlzy/sYXYBjYBcRlSfqqHbcROq7+0AAHooBeScmbshyvyuEdP9zLcfnpkol7Z2/w8lrANuN6
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2026 04:09:36.1331 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6053ae75-5d45-4a9c-e21f-08df357271db
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000C618B.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PPF0D942FA9A
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Currently amdgpu_vm_pt_clear() is called at open time in
amdgpu_vm_init(). It submits an SDMA job, which needs the GPU to be
awake and adds complications when it comes to preventing the GPU from
resuming when direct hardware access isn't required. Instead,
amdgpu_vm_pt_clear() can be moved out of amdgpu_vm_init() to run later
on when it's required, such as when amdgpu_vm_validate() is called.

Introduce delayed virtual memory hardware initialization by changing the
vm->generation assignment on amdgpu_vm_init() to ~0ULL. By setting
vm->generation to this value, it will force a mismatch to occur on init,
processing the amdgpu_vm_validate() logic, and clearing the root PT much
later on in the stack.

Set the initial domain of vm->root.bo to 0, this will allow all contents
of the root PT to exist in system memory without requiring the GPU to be
active. The vm->root.bo is then put on the evicted list, which will then
migrate the PT to its preferred/allowed domain at the best possible
time (usually through amdgpu_vm_validate() on the CS path).

Edit amdgpu_ualink_manager_start() to no longer depend on
amdgpu_vm_pt_clear() within amdgpu_vm_init(). Instead, the root bo will
be reserved directly after initializing the npa vm and
amdgpu_vm_validate() will be called within the reservation, using the
logic of the new amdgpu_ualink_bo_validate() function to process the
validation.

Signed-off-by: Shahyan Soltani <shahyan.soltani@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c | 31 ++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.h |  1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c     |  6 +----
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c  | 13 +++++++--
 4 files changed, 44 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
index 6cd3927a7e82..1e8f7fe8e1fa 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
@@ -27,6 +27,7 @@
 #include <linux/random.h>
 #include "amdgpu.h"
 #include "amdgpu_sdma.h"
+#include "amdgpu_vm.h"
 #include "amdgpu_ualink.h"
 #include "amdgpu_xgmi.h"
 #include "amdgpu_dma_buf.h"
@@ -4165,14 +4166,44 @@ int amdgpu_gem_ualink_handle_ioctl(struct drm_device *dev, void *data,
 	return r;
 }
 
+int amdgpu_ualink_bo_validate(void *param, struct amdgpu_bo *bo)
+{
+	struct ttm_operation_ctx ctx = { false, false };
+	int r;
+
+	if (bo->tbo.pin_count)
+		return 0;
+
+	amdgpu_bo_placement_from_domain(bo, bo->preferred_domains);
+
+	r = ttm_bo_validate(&bo->tbo, &bo->placement, &ctx);
+	return r;
+}
+
 int amdgpu_ualink_manager_start(struct amdgpu_device *adev)
 {
+	struct drm_exec exec;
 	int i, r;
 
 	r = amdgpu_vm_init(adev, &adev->ualink.npa_vm, 0);
 	if (r)
 		goto out;
 
+	r = amdgpu_ualink_reserve_npa_vm_and_bos(adev, &adev->ualink.npa_vm.root.bo,
+						 0, &exec, false);
+	if (unlikely(r)) {
+		dev_err(adev->dev, "Failed to reserve VM in ualink_manager_start\n");
+		goto uninit_vm;
+	}
+
+	/* Ensure the root PT is migrated to the correct domain */
+	r = amdgpu_vm_validate(adev, &adev->ualink.npa_vm, NULL, amdgpu_ualink_bo_validate, NULL);
+	amdgpu_ualink_unreserve_npa_vm_and_bos(adev, &exec);
+	if (r) {
+		drm_err(adev_to_drm(adev), "amdgpu_vm_validate() failed.\n");
+		goto uninit_vm;
+	}
+
 	/* For pinning page tables and using CPU for page table updates. */
 	r = amdgpu_vm_make_npa(adev, &adev->ualink.npa_vm);
 	if (r)
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.h
index 85c9a9634a4b..399ff4da0444 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.h
@@ -405,6 +405,7 @@ int amdgpu_ualink_resume_handler(struct amdgpu_device *adev);
 int amdgpu_ualink_sysfs_init(struct amdgpu_device *adev);
 void amdgpu_ualink_sysfs_fini(struct amdgpu_device *adev);
 void amdgpu_ualink_xcp_sysfs_update(struct amdgpu_xcp *xcp);
+int amdgpu_ualink_bo_validate(void *param, struct amdgpu_bo *bo);
 int amdgpu_ualink_manager_start(struct amdgpu_device *adev);
 void amdgpu_ualink_manager_stop(struct amdgpu_device *adev);
 int amdgpu_ualink_export_handle(struct drm_device *dev, struct drm_file *filp,
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index 000c982816a7..088a4e5a1aa2 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -2660,6 +2660,7 @@ int amdgpu_vm_init(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 
 	vm->is_compute_context = false;
 	vm->need_tlb_fence = amdgpu_userq_enabled(&adev->ddev);
+	vm->generation = ~0ULL;
 
 	vm->use_cpu_for_update = !!(adev->vm_manager.vm_update_mode &
 				    AMDGPU_VM_USE_CPU_FOR_GFX);
@@ -2678,7 +2679,6 @@ int amdgpu_vm_init(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 	vm->last_update = dma_fence_get_stub();
 	vm->last_unlocked = dma_fence_get_stub();
 	vm->last_tlb_flush = dma_fence_get_stub();
-	vm->generation = amdgpu_vm_generation(adev, NULL);
 
 	mutex_init(&vm->eviction_lock);
 	vm->evicting = false;
@@ -2701,10 +2701,6 @@ int amdgpu_vm_init(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 	if (r)
 		goto error_free_root;
 
-	r = amdgpu_vm_pt_clear(adev, vm, root, false);
-	if (r)
-		goto error_free_root;
-
 	r = amdgpu_vm_create_task_info(vm);
 	if (r)
 		dev_dbg(adev->dev, "Failed to create task info for VM\n");
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
index c73eb416c0e2..2b9f8aafb685 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
@@ -449,6 +449,7 @@ int amdgpu_vm_pt_create(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 {
 	struct amdgpu_bo_param bp;
 	unsigned int num_entries;
+	u32 set_domain;
 	int r;
 
 	memset(&bp, 0, sizeof(bp));
@@ -457,9 +458,11 @@ int amdgpu_vm_pt_create(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 	bp.byte_align = AMDGPU_GPU_PAGE_SIZE;
 
 	if (!adev->gmc.is_app_apu)
-		bp.domain = AMDGPU_GEM_DOMAIN_VRAM;
+		set_domain = AMDGPU_GEM_DOMAIN_VRAM;
 	else
-		bp.domain = AMDGPU_GEM_DOMAIN_GTT;
+		set_domain = AMDGPU_GEM_DOMAIN_GTT;
+
+	bp.domain = (!vm->root.bo) ? 0 : set_domain;
 
 	bp.domain = amdgpu_bo_get_preferred_domain(adev, bp.domain);
 	bp.flags = AMDGPU_GEM_CREATE_VRAM_CONTIGUOUS |
@@ -486,6 +489,12 @@ int amdgpu_vm_pt_create(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 	if (r)
 		return r;
 
+	if (!vm->root.bo) {
+		(*vmbo)->bo.preferred_domains = set_domain;
+		(*vmbo)->bo.allowed_domains = (set_domain == AMDGPU_GEM_DOMAIN_VRAM) ?
+			AMDGPU_GEM_DOMAIN_VRAM | AMDGPU_GEM_DOMAIN_GTT : set_domain;
+	}
+
 	/* Assumes that reservation is shared with the VM root and that the
 	 * reservation is locked
 	 */
-- 
2.56.0

