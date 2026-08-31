Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C347CC624C6
	for <amd-gfx@archiver.kernel.org>; Mon, 31 Aug 2026 18:29:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3BFD910EA96;
	Mon, 31 Aug 2026 18:29:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="H0qFsQQf";
	dkim-atps=neutral
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010048.outbound.protection.outlook.com [52.101.56.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CDB8110EA21
 for <amd-gfx@lists.freedesktop.org>; Mon, 31 Aug 2026 18:29:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jRvQ2OBnlouk6ENDHmYoogNdZGGNZM/yUDlR93U2NGb5xSZpUj266i8UzQJ4kwfTAq6/v46wLRD4UmNGgYpQHUHXqv8rlTrE/NRIJmblIg8xo1JLnlpyLmZGL8eAExnx15oqLGA3jBSmOYWzzqCKOiDnxJZuDhseZPOS+1XHxNocY1DanJGbNW7uDhfB6uA0fzco7lkQ2l3Vh8mVPeVBVMHDO/jhE51iNq3z9ril6MA7UP4iwqgBCppTVRxgSWIfPiHwNZX//ndk7PHjojG50JRnXZElZjGgKPcXzABzrPyvpScXVZZHx/6Zzo5UN4fwlu/GJNTwTecvYVYLYeoC1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=raj9LA6hpJneWdGda9LueAPM9exiMcJyscxfJrMxoUQ=;
 b=ro9vmNTjOA9UpyzcmaO5VzqcqZcPKjUmrZ3pJkHaswIjdgezq4YGaRYppJH018N1hr+FfR/TP9ypZVd6P6zJ6ZivzMQN7XH1Y4wQbEyFIIClH7z2W8Vimq4/eupvOQ7YDoWZlcNGTkKJoUgsVAfajbVHKU2SrBuQqjVaIatGNFmNlZLvFaIwcQc7jzg4nbE3hpRlONrONgBP1NlOCdvZ0DiMkkBoqxgYjLw4HUiD8fPKaRiEEY6lF2q9Mq7ENzmcQ3a81pN9mhVKVaYI2cjoNCsrvkLmqtkyQ9Rya0SwgbuP8/Ys7tmg6g2RCHvxmiXeUxmLD0HevivtkSQ1B/I8mg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=raj9LA6hpJneWdGda9LueAPM9exiMcJyscxfJrMxoUQ=;
 b=H0qFsQQfR5iBVtNRycvzoLKXBIOzVL67uyPITY3Dyvs4Af6SzTDmhawsCRKM99DqHKk7eOb/T54ii65MGOOPrmMDD6FuzdxJ05dFz4Cs8Bym5WFaDMOycS7F+k4D7zQ+DQ86xLJ2KGJUzw8uW3LIP5SW8ccoPVhnhab0ko0vFlY=
Received: from BN9PR03CA0688.namprd03.prod.outlook.com (2603:10b6:408:10e::33)
 by SA1PR12MB6704.namprd12.prod.outlook.com (2603:10b6:806:254::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.12; Mon, 31 Aug
 2026 18:29:07 +0000
Received: from BN3PEPF0000B074.namprd04.prod.outlook.com
 (2603:10b6:408:10e:cafe::45) by BN9PR03CA0688.outlook.office365.com
 (2603:10b6:408:10e::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.13 via Frontend Transport; Mon,
 31 Aug 2026 18:29:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN3PEPF0000B074.mail.protection.outlook.com (10.167.243.119) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Mon, 31 Aug 2026 18:29:05 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Mon, 31 Aug
 2026 13:28:51 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Mon, 31 Aug
 2026 13:28:52 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.46 via Frontend
 Transport; Mon, 31 Aug 2026 13:28:51 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Felix Kuehling <felix.kuehling@amd.com>, Mukul Joshi
 <mukul.joshi@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 71/95] drm/amdgpu: Pin page tables in NPA VMs
Date: Mon, 31 Aug 2026 14:27:30 -0400
Message-ID: <20260831182754.1089811-72-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260831182754.1089811-1-alexander.deucher@amd.com>
References: <20260831182754.1089811-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B074:EE_|SA1PR12MB6704:EE_
X-MS-Office365-Filtering-Correlation-Id: 2779b656-5020-4c90-b7f1-08df078dbd16
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|82310400026|36860700016|1800799024|10067099003|11063799006|56012099006|22082099003|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info: OKnWrvQH1RKWu3ZdPtNXsW6qaLjPuElhBS4jlMZew7oZ0+nUnqAItv3KWTt9LN69nIMbwkWYxMZULbA3VNVqPJMST1sEQDgzF/39gvarBe+WAcX46sfFt64YY3r0saq2wHM9h8d6g+CjoJ2Ppqa+b+sBv+2uzef0eIzDNgp0RGiFL83KhohNglqu+7EsYvDN91LfG1WJ+o2UG+MYZXBHFcQhluEQNVBq1BHWCOMOwQ33iEyEXZLI1mBMtrW02FW5xUFTAFkpRVT0N5nlOZ9dqVoeL5I5iWqAGMFNajqZzn9dMmcF7GzsWVLLpKyFI+HSHqHpiIvVnY1n6En83CFkWON/rbfsIm9xqy7wItPUlJyom5EW0s5hYLdLFFDnkvi1/t5Q7px4VLFzwGd9+/ErbJNuXmHZogRPNGLTki9fNrekcjJTnphTPEHLkJhgwMB9n8HXAYvkEr0L+BgLvaYEuM82e2LClYmuASLyT4SfQ2Nm0KvSX/GqnqoKnt6CVjlNLeOk1dHNIjVh/mUrL8NgdKyDdWR7N1wiT9FPD9lbAqNq2BXHIhfZo97HHmeO/qNM9llMZBE+fSPOq+ZLdxyh9EfKmW76dPlVWzhjbjglZmFuWYtOF5uIGlejXIQ7Xv55pVBABnbDX8jRNOvm/RZZ3DvhUXOjG04vTWvtWxrKqFpT3h6MJ7X+/OrDDWdaYsrB4CGRvzcjBu0SXnSJIG1Hqg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(82310400026)(36860700016)(1800799024)(10067099003)(11063799006)(56012099006)(22082099003)(18002099003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: PqFSEuyMHD3oqDMWJeeXBQ5bfHnFHQeUvpfuxk5RlCIOJlIS3cBlIHxU1vpYLrqphsWYwOyE/P8/gQ1MEXE6f1GP4q15tNSDnBIbmxgObtXq4wi6Ix7wjHqBMYA08EFKNirVcVOe9KEOMuExw5vGL7hr5EKDXB0t5ix1QXtIdq/HKu37MHddmRQR5Liy+u4Y4HurW0/A8442e92AXqH7vJG+V5rpKsEEc1O03yFp7Tyh4M4vlx8JmUSjgbvlMVZsb7mhpS7jc10WFYj9CP/UJNAsNUf9zbELXaHBDDM4EdnCO3o7M0njras4tidqXOadoDI4MdmBEIl5rirlcJGpK7ERzZtI5dmnt4q1HKqh1hUIKsk/7wBmsezzH9tKN2nEbAXeHsj+/K1gfsYJvtCxuus36eNpJd6oAMUlhjMEqwnZqSV82hLDZjLwO5flC+VL
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2026 18:29:05.3650 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2779b656-5020-4c90-b7f1-08df078dbd16
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B074.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6704
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

From: Felix Kuehling <felix.kuehling@amd.com>

With latest POR, remote importers aren't guaranteed to support
instruction replay-on-fault. Therefore, we cannot support unpinned
exports or unpinned page-tables in the exporter mappings into NPA space.

Signed-off-by: Felix Kuehling <felix.kuehling@amd.com>
Reviewed-by: Mukul Joshi <mukul.joshi@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c |  4 +--
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c     | 40 ++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h     |  3 ++
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c  | 25 +++++++++++++-
 4 files changed, 69 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
index 5811218b35d33..0f57a7e2c3341 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
@@ -3444,8 +3444,8 @@ int amdgpu_ualink_manager_start(struct amdgpu_device *adev)
 	if (r)
 		goto out;
 
-	/* For using CPU for page table updates. */
-	r = amdgpu_vm_make_compute(adev, &adev->ualink.npa_vm);
+	/* For pinning page tables and using CPU for page table updates. */
+	r = amdgpu_vm_make_npa(adev, &adev->ualink.npa_vm);
 	if (r)
 		goto uninit_vm;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index fc928c2d8b21e..47cde54594693 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -2752,6 +2752,46 @@ int amdgpu_vm_make_compute(struct amdgpu_device *adev, struct amdgpu_vm *vm)
 	return r;
 }
 
+/**
+ * amdgpu_vm_make_npa - Turn a GFX VM into an NPA VM
+ *
+ * @adev: amdgpu_device pointer
+ * @vm: requested vm
+ *
+ * This only works on GFX VMs that don't have any BOs added and no
+ * page tables allocated yet.
+ *
+ * Changes the following VM parameters:
+ * - use_cpu_for_update
+ * - pins page tables
+ * - initializes PTEs to no-retry encoding
+ *
+ * Reinitializes the page directory to reflect the changed ATS
+ * setting.
+ *
+ * Returns:
+ * 0 for success, -errno for errors.
+ */
+int amdgpu_vm_make_npa(struct amdgpu_device *adev, struct amdgpu_vm *vm)
+{
+	int r = amdgpu_vm_make_compute(adev, vm);
+
+	if (r)
+		return r;
+	vm->is_npa = true;
+	r = amdgpu_bo_reserve(vm->root.bo, false);
+	if (r)
+		return r;
+	r = amdgpu_bo_pin(vm->root.bo, AMDGPU_GEM_DOMAIN_VRAM);
+	amdgpu_bo_unreserve(vm->root.bo);
+	if (r)
+		return r;
+
+	vm->is_npa = true;
+
+	return 0;
+}
+
 static int amdgpu_vm_stats_is_zero(struct amdgpu_vm *vm)
 {
 	for (int i = 0; i < __AMDGPU_PL_NUM; ++i) {
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
index 7a0ee19a12b18..0f6634b749746 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
@@ -369,6 +369,8 @@ struct amdgpu_vm {
 	struct ttm_lru_bulk_move lru_bulk_move;
 	/* Flag to indicate if VM is used for compute */
 	bool			is_compute_context;
+	/* Flag to indicate that page tables are for NPA mappings */
+	bool			is_npa;
 	/* Flag to indicate if VM needs a TLB fence (KFD or KGD) */
 	bool			need_tlb_fence;
 
@@ -429,6 +431,7 @@ void amdgpu_vm_manager_fini(struct amdgpu_device *adev);
 long amdgpu_vm_wait_idle(struct amdgpu_vm *vm, long timeout);
 int amdgpu_vm_init(struct amdgpu_device *adev, struct amdgpu_vm *vm, int32_t xcp_id);
 int amdgpu_vm_make_compute(struct amdgpu_device *adev, struct amdgpu_vm *vm);
+int amdgpu_vm_make_npa(struct amdgpu_device *adev, struct amdgpu_vm *vm);
 void amdgpu_vm_fini(struct amdgpu_device *adev, struct amdgpu_vm *vm);
 int amdgpu_vm_lock_pd(struct amdgpu_vm *vm, struct drm_exec *exec,
 		      unsigned int num_fences);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
index b85b70a1a428d..b9831a5f85d8b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
@@ -445,6 +445,7 @@ int amdgpu_vm_pt_create(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 {
 	struct amdgpu_bo_param bp;
 	unsigned int num_entries;
+	int r;
 
 	memset(&bp, 0, sizeof(bp));
 
@@ -477,7 +478,24 @@ int amdgpu_vm_pt_create(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 	if (vm->root.bo)
 		bp.resv = vm->root.bo->tbo.base.resv;
 
-	return amdgpu_bo_create_vm(adev, &bp, vmbo);
+	r = amdgpu_bo_create_vm(adev, &bp, vmbo);
+	if (r)
+		return r;
+
+	/* Assumes that reservation is shared with the VM root and that the
+	 * reservation is locked
+	 */
+	if (vm->root.bo && vm->is_npa) {
+		struct amdgpu_bo *pt_bo = &(*vmbo)->bo;
+
+		r = amdgpu_bo_pin(pt_bo, AMDGPU_GEM_DOMAIN_VRAM);
+		if (r) {
+			amdgpu_bo_unref(&pt_bo);
+			return r;
+		}
+	}
+
+	return 0;
 }
 
 /**
@@ -527,6 +545,8 @@ static int amdgpu_vm_pt_alloc(struct amdgpu_device *adev,
 	return 0;
 
 error_free_pt:
+	if (vm->is_npa)
+		amdgpu_bo_unpin(pt_bo);
 	amdgpu_bo_unref(&pt_bo);
 	return r;
 }
@@ -541,6 +561,9 @@ static void amdgpu_vm_pt_free(struct amdgpu_vm_bo_base *entry)
 	if (!entry->bo)
 		return;
 
+	if (entry->vm->is_npa)
+		amdgpu_bo_unpin(entry->bo);
+
 	amdgpu_vm_update_stats(entry, entry->bo->tbo.resource, -1);
 	entry->bo->vm_bo = NULL;
 	ttm_bo_set_bulk_move(&entry->bo->tbo, NULL);
-- 
2.55.0

