Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0EB2CC88E72
	for <amd-gfx@archiver.kernel.org>; Thu, 17 Sep 2026 11:03:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8A0BE10ED8C;
	Thu, 17 Sep 2026 11:03:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="w6aku/us";
	dkim-atps=neutral
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012037.outbound.protection.outlook.com [52.101.48.37])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4EED710E6EE
 for <amd-gfx@lists.freedesktop.org>; Thu, 17 Sep 2026 11:03:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=j9i5TEICEWoO1g1CtK/gtd5no0ZesgOH2lZNLPqEP2ZWKNo/QexsF1ptVi8/hpgGzxW83/jMQU333I9ykpTbRNpi/t/J6rUwQQfxENm38n63cGVBtO+tB0zwU6Vcpu6lgrhoWTKFr7sr7cSz7IJ126iYugrFzWgjNPZO/lHooCDD1FkPywtsvOSu+XjhG0ZsY+3QnUoYsFFK+MA8vHz4Sx318wTlLOm7x5qm85eDmN8wYXR62u1E2RVTMZQDDGF405cblyoTOeJwfH3huScJteBAJS/QfWdN6YWI61wwtJ+tym7KEsYTXbMYPOh/zZF+TmT3GHe2h0jxToshg5FlCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dlsK/vH1pqM4axQhMT9FtuEFzvkYXN2iyBhFHkCEp2s=;
 b=byHwhI4Qyaz14ai4uYWx9sYhByx6+9nJ1Nf67xx+14ec+sNjZLzgTl3cwfeqdOvhiF54nuBtcJaUHSxhaYcn5e12yNqh04PAUssSD59I1eMaO97G4cJ5hF7JmKCfWGcFQ4tnkEDCfaa3xx8PCRyylatpyCozVC9wIOpWmKLbjJgL3gMcNCuwXLV+pjJsX9GmfpZEkL4dw1jPDKPYd5e3LQz1lwRGdqCI9i2fyLOSOlgI2iBYjVl44THj2VY3WWNjtlk35R2cyu22wr7CHcplBKSHj/ldQEJo6D0JlOkYFCn86riNVhHWwKWAR+tpHc+n3ipT33MgaVBsliLkKpf8FQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=gmail.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dlsK/vH1pqM4axQhMT9FtuEFzvkYXN2iyBhFHkCEp2s=;
 b=w6aku/usKqET1WAwcPtXLQ6XwGOwoqtdysEPoM5+Xz0IhU/sX+GYIgRq+Rb9Res1DwqvXfWXLIriYSSyHIyuWQUeuoO93jPKUAXmZCYaemuty8IgesjgGH1tpgoeNJhuSuLCfOLseLlz/HWbOmGFQCn1ImmLI333uNa7mGOOeis=
Received: from SJ0PR05CA0156.namprd05.prod.outlook.com (2603:10b6:a03:339::11)
 by IA0PR12MB8376.namprd12.prod.outlook.com (2603:10b6:208:40b::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.12; Thu, 17 Sep
 2026 11:02:57 +0000
Received: from SJ5PEPF00000207.namprd05.prod.outlook.com
 (2603:10b6:a03:339:cafe::94) by SJ0PR05CA0156.outlook.office365.com
 (2603:10b6:a03:339::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.406.3 via Frontend Transport; Thu, 17
 Sep 2026 11:02:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF00000207.mail.protection.outlook.com (10.167.244.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.8 via Frontend Transport; Thu, 17 Sep 2026 11:02:57 +0000
Received: from yhuang-B850M-AORUS-PRO-WIFI7.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Thu, 17 Sep 2026 06:02:54 -0500
From: Huang Yu <yhuang13@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
CC: Yu Huang <Yu.Huang@amd.com>, Honglei Huang <honghuan@amd.com>, Ray Huang
 <ray.huang@amd.com>, Shen Junhua <junhshen@amd.com>, Lingshan Zhu
 <lingszhu@amd.com>, Timur Cristof <timur.kristof@gmail.com>, Natalie Vock
 <natalie.vock@gmx.de>, AMD-GFX <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 06/13] drm/amdgpu: split amdgpu_vm_update_range
Date: Thu, 17 Sep 2026 19:01:51 +0800
Message-ID: <20260917110158.296198-7-yhuang13@amd.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260917110158.296198-1-yhuang13@amd.com>
References: <20260917110158.296198-1-yhuang13@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF00000207:EE_|IA0PR12MB8376:EE_
X-MS-Office365-Filtering-Correlation-Id: fede996a-cb71-4ada-0624-08df14ab3af3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|82310400026|376014|23010399003|1800799024|56012099006|11063799006|10067099003|18002099003|6133799003|22082099003|3023799007;
X-Microsoft-Antispam-Message-Info: VocxaJihfrLIjRwjVdQqUUBZKTR1xY2AIdxbZ1LlnnBL4OWRDF9WX7IUmjXXoQC4S9ngfMgYhrY5/nH8ibJ9CGd5/IlOjt4eJUMJiVsSTJXiV2JumcYLli+yIMZTzFz+OGo6fbtZtLoDmaVuTBAcQNjgoRiUyGG8/40E97F6b/5LoMXqapjadE0lTwhzzB5OkJh697HE+awqnyma+CaVwpgly5BwkcWnMc/QsDY1vQqK/4Xv1yslA8lzaW5IxUUprbPdXQ9cKG+W5ZZJROU81+J5htn8vBYXHx9JvL+pKSiiyy+Wgze+Y/cetJf4yN6XOQnbU+KxdczYcCROD8X8jiG/lXH4As/JvHyUQFiiSL4/KDGsSk6gR9pdQRDB9f2/8+fDqKWad2h044ZPnUhm6AJ9jpTGysNGxplqahoZmwBToST3B115Yx8xrlKivLgZaza5Lz1MilBCp87MLalK/1RLXBzKg6aDa8uzzvsVb/DlwugJOpcCC6h2IH55h4s/VUUENoRsJHE89l37mM06PFWSj0G0Iykt2MdR92R3Od5o6oa+lWHj+bjxeQqcFWtq/pdBBwPMrwP/110967XLo83mRDRlPL1Bc263tJ758zsCw4ktXL0RdyXnQoXTdKbgW/LkeqLXjHkjRkYIjVdtAXYY1x4bVG9ZSlDZcGzA+TtUbpj5OKco0Z7mu8MFCqCioMyyNtKKrrtES1Us7efSRQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(82310400026)(376014)(23010399003)(1800799024)(56012099006)(11063799006)(10067099003)(18002099003)(6133799003)(22082099003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: D2bCxiCBnNjF4ECq43YYV513OV6+i7cZAmXBlWLhpOcr7TYfqrs/4AP28Weejf/5xvRT+2qrdBYUrtF1rQRjPkjL9cbojTBCcQb40PuDFSDkxKXCI94PGj8Ye4NLrmDmuN318WoU+sjPbaMXdmeHWm1tVosFxQcXeEiqbUHc64+Zvy2VA1ddcUUltJP8YEIRJwUMTWvpgz1I3YcdWpN9hGZ+TrYTj02qzdCv9nGTH1irJM1bGHXIYNLqh09OcwxESiklEgDCh5Khg8f1EmgCJKT98/ORUfQU6DKw5ur9QoEr5Cx+MdA/zaCz/V5zZ+nsXSser8NCtdg25S6s/n+FsbwArS9J6d/JdC2ojW/kppK0+ZROvQeXnQ2mCu8BIVLvv3XtedlJlAW+IAQndi5JwMYanhS9vDo6h0bxekKanzAcjayjs8Edpn97fXY4Cbaw
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2026 11:02:57.0129 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fede996a-cb71-4ada-0624-08df14ab3af3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF00000207.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8376
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

From: Christian König <ckoenig.leichtzumerken@gmail.com>

Split amdgpu_vm_update_range into two functions.

amdgpu_vm_map_range() is for mapping PTEs into a range and updates
which can be done while holding the VM lock.

amdgpu_vm_unmap_range() is for unmapping PTEs without holding the VM
lock in MMU notifiers.

Signed-off-by: Christian König <christian.koenig@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_job.h   |   3 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c    | 112 ++++++++++++++++++----
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h    |  14 ++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c |  35 ++-----
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c      |  16 ++--
 5 files changed, 120 insertions(+), 60 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h
index 7e03bd2ff639..16832b0914fa 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h
@@ -47,7 +47,7 @@ enum amdgpu_ib_pool_type;
 /* Internal kernel job ids. (decreasing values, starting from U64_MAX). */
 #define AMDGPU_KERNEL_JOB_ID_VM_UPDATE              (18446744073709551615ULL)
 #define AMDGPU_KERNEL_JOB_ID_VM_UPDATE_PDES         (18446744073709551614ULL)
-#define AMDGPU_KERNEL_JOB_ID_VM_UPDATE_RANGE        (18446744073709551613ULL)
+#define AMDGPU_KERNEL_JOB_ID_VM_MAP_RANGE           (18446744073709551613ULL)
 #define AMDGPU_KERNEL_JOB_ID_VM_PT_CLEAR            (18446744073709551612ULL)
 #define AMDGPU_KERNEL_JOB_ID_TTM_MAP_BUFFER         (18446744073709551611ULL)
 #define AMDGPU_KERNEL_JOB_ID_TTM_ACCESS_MEMORY_SDMA (18446744073709551610ULL)
@@ -63,6 +63,7 @@ enum amdgpu_ib_pool_type;
 #define AMDGPU_KERNEL_JOB_ID_SDMA_RING_TEST         (18446744073709551600ULL)
 #define AMDGPU_KERNEL_JOB_ID_VPE_RING_TEST          (18446744073709551599ULL)
 #define AMDGPU_KERNEL_JOB_ID_RUN_SHADER             (18446744073709551598ULL)
+#define AMDGPU_KERNEL_JOB_ID_VM_UNMAP_RANGE         (18446744073709551597ULL)
 
 struct amdgpu_job {
 	struct drm_sched_job    base;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index 6a69e876e729..77437436292c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -1105,11 +1105,10 @@ amdgpu_vm_tlb_flush(struct amdgpu_vm_update_params *params,
 }
 
 /**
- * amdgpu_vm_update_range - update a range in the vm page table
+ * amdgpu_vm_map_range - map something to a range in the vm page tables
  *
  * @adev: amdgpu_device pointer to use for commands
  * @vm: the VM to update the range
- * @unlocked: unlocked invalidation during MM callback
  * @flush_tlb: trigger tlb invalidation after update completed
  * @allow_override: change MTYPE for local NUMA nodes
  * @sync: fences we need to sync to
@@ -1122,23 +1121,26 @@ amdgpu_vm_tlb_flush(struct amdgpu_vm_update_params *params,
  * @pages_addr: DMA addresses to use for mapping
  * @fence: optional resulting fence
  *
- * Fill in the page table entries between @start and @last.
+ * Fill in the page table entries between @start and @last. Allocate and free
+ * new page tables as needed. Can only be called while holding the VM lock.
  *
  * Returns:
  * 0 for success, negative erro code for failure.
  */
-int amdgpu_vm_update_range(struct amdgpu_device *adev, struct amdgpu_vm *vm,
-			   bool unlocked, bool flush_tlb, bool allow_override,
-			   struct amdgpu_sync *sync, uint64_t start,
-			   uint64_t last, uint64_t flags, uint64_t offset,
-			   uint64_t vram_base, struct ttm_resource *res,
-			   dma_addr_t *pages_addr, struct dma_fence **fence)
+int amdgpu_vm_map_range(struct amdgpu_device *adev, struct amdgpu_vm *vm,
+			bool flush_tlb, bool allow_override,
+			struct amdgpu_sync *sync, uint64_t start,
+			uint64_t last, uint64_t flags, uint64_t offset,
+			uint64_t vram_base, struct ttm_resource *res,
+			dma_addr_t *pages_addr, struct dma_fence **fence)
 {
 	struct amdgpu_vm_tlb_seq_struct *tlb_cb;
 	struct amdgpu_vm_update_params params;
 	struct amdgpu_res_cursor cursor;
 	int r, idx;
 
+	amdgpu_vm_assert_locked(vm);
+
 	if (!drm_dev_enter(adev_to_drm(adev), &idx))
 		return -ENODEV;
 
@@ -1163,7 +1165,6 @@ int amdgpu_vm_update_range(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 	params.adev = adev;
 	params.vm = vm;
 	params.pages_addr = pages_addr;
-	params.unlocked = unlocked;
 	params.needs_flush = flush_tlb;
 	params.override_pte = allow_override && adev->gmc.override_pte;
 	INIT_LIST_HEAD(&params.tlb_flush_waitlist);
@@ -1174,7 +1175,7 @@ int amdgpu_vm_update_range(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 		goto error_free;
 	}
 
-	if (!unlocked && !dma_fence_is_signaled(vm->last_unlocked)) {
+	if (!dma_fence_is_signaled(vm->last_unlocked)) {
 		struct dma_fence *tmp = dma_fence_get_stub();
 
 		amdgpu_bo_fence(vm->root.bo, vm->last_unlocked, true);
@@ -1183,7 +1184,7 @@ int amdgpu_vm_update_range(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 	}
 
 	r = vm->update_funcs->prepare(&params, sync,
-				      AMDGPU_KERNEL_JOB_ID_VM_UPDATE_RANGE);
+				      AMDGPU_KERNEL_JOB_ID_VM_MAP_RANGE);
 	if (r)
 		goto error_free;
 
@@ -1259,6 +1260,77 @@ int amdgpu_vm_update_range(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 	return r;
 }
 
+/**
+ * amdgpu_vm_unmap_range - clear leave PTEs to unmap something
+ *
+ * @adev: amdgpu_device pointer to use for commands
+ * @vm: the VM to update the range
+ * @sync: fences we need to sync to
+ * @start: start of unmapped range
+ * @last: last unmapped entry
+ * @flags: flags for the entries
+ * @fence: optional resulting fence
+ *
+ * Fill in the page table entries between @start and @last with a fixed flags
+ * value without allocating or freeing page tables. Can be used without locking
+ * the VM.
+ *
+ * Returns:
+ * 0 for success, negative erro code for failure.
+ */
+int amdgpu_vm_unmap_range(struct amdgpu_device *adev, struct amdgpu_vm *vm,
+			   struct amdgpu_sync *sync, uint64_t start,
+			   uint64_t last, uint64_t flags,
+			   struct dma_fence **fence)
+{
+	struct amdgpu_vm_tlb_seq_struct *tlb_cb;
+	struct amdgpu_vm_update_params params;
+	int r, idx;
+
+	if (!drm_dev_enter(adev_to_drm(adev), &idx))
+		return -ENODEV;
+
+	tlb_cb = kmalloc(sizeof(*tlb_cb), GFP_KERNEL);
+	if (!tlb_cb) {
+		drm_dev_exit(idx);
+		return -ENOMEM;
+	}
+
+	memset(&params, 0, sizeof(params));
+	params.adev = adev;
+	params.vm = vm;
+	params.needs_flush = true;
+	params.unlocked = true;
+	INIT_LIST_HEAD(&params.tlb_flush_waitlist);
+
+	amdgpu_vm_eviction_lock(vm);
+	if (vm->evicting) {
+		r = -EBUSY;
+		goto error_free;
+	}
+
+	r = vm->update_funcs->prepare(&params, sync,
+				      AMDGPU_KERNEL_JOB_ID_VM_UNMAP_RANGE);
+	if (r)
+		goto error_free;
+
+	amdgpu_vm_pt_leaves(&params, start, last, NULL, flags);
+
+	r = vm->update_funcs->commit(&params, fence);
+	if (r)
+		goto error_free;
+
+	amdgpu_vm_tlb_flush(&params, fence, tlb_cb);
+	amdgpu_vm_pt_free_list(adev, &params);
+	tlb_cb = NULL;
+
+error_free:
+	kfree(tlb_cb);
+	amdgpu_vm_eviction_unlock(vm);
+	drm_dev_exit(idx);
+	return r;
+}
+
 void amdgpu_vm_get_memory(struct amdgpu_vm *vm,
 			  struct amdgpu_mem_stats stats[__AMDGPU_PL_NUM])
 {
@@ -1387,11 +1459,11 @@ int amdgpu_vm_bo_update(struct amdgpu_device *adev, struct amdgpu_bo_va *bo_va,
 
 		trace_amdgpu_vm_bo_update(mapping);
 
-		r = amdgpu_vm_update_range(adev, vm, false, flush_tlb,
-					   !uncached, &sync, mapping->start,
-					   mapping->last, update_flags,
-					   mapping->offset, vram_base, mem,
-					   pages_addr, last_update);
+		r = amdgpu_vm_map_range(adev, vm, flush_tlb, !uncached, &sync,
+					mapping->start, mapping->last,
+					update_flags, mapping->offset,
+					vram_base, mem, pages_addr,
+					last_update);
 		if (r)
 			goto error_free;
 	}
@@ -1598,9 +1670,9 @@ int amdgpu_vm_clear_freed(struct amdgpu_device *adev,
 			struct amdgpu_bo_va_mapping, list);
 		list_del(&mapping->list);
 
-		r = amdgpu_vm_update_range(adev, vm, false, true, false,
-					   &sync, mapping->start, mapping->last,
-					   0, 0, 0, NULL, NULL, &f);
+		r = amdgpu_vm_map_range(adev, vm, true, false,
+					&sync, mapping->start, mapping->last,
+					0, 0, 0, NULL, NULL, &f);
 		amdgpu_vm_free_mapping(adev, vm, mapping, f);
 		if (r) {
 			dma_fence_put(f);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
index 8ab20826ddf2..e871a9e3e1a9 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
@@ -457,12 +457,16 @@ int amdgpu_vm_flush_compute_tlb(struct amdgpu_device *adev,
 				uint32_t xcc_mask);
 void amdgpu_vm_bo_base_init(struct amdgpu_vm_bo_base *base,
 			    struct amdgpu_vm *vm, struct amdgpu_bo *bo);
-int amdgpu_vm_update_range(struct amdgpu_device *adev, struct amdgpu_vm *vm,
-			   bool unlocked, bool flush_tlb, bool allow_override,
+int amdgpu_vm_map_range(struct amdgpu_device *adev, struct amdgpu_vm *vm,
+			bool flush_tlb, bool allow_override,
+			struct amdgpu_sync *sync, uint64_t start,
+			uint64_t last, uint64_t flags, uint64_t offset,
+			uint64_t vram_base, struct ttm_resource *res,
+			dma_addr_t *pages_addr, struct dma_fence **fence);
+int amdgpu_vm_unmap_range(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 			   struct amdgpu_sync *sync, uint64_t start,
-			   uint64_t last, uint64_t flags, uint64_t offset,
-			   uint64_t vram_base, struct ttm_resource *res,
-			   dma_addr_t *pages_addr, struct dma_fence **fence);
+			   uint64_t last, uint64_t flags,
+			   struct dma_fence **fence);
 int amdgpu_vm_bo_update(struct amdgpu_device *adev,
 			struct amdgpu_bo_va *bo_va,
 			bool clear);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
index 919e1967c5ba..5bb1a3300aa4 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
@@ -554,7 +554,6 @@ void amdgpu_vm_pt_free_list(struct amdgpu_device *adev,
 			    struct amdgpu_vm_update_params *params)
 {
 	struct amdgpu_vm_bo_base *entry, *next;
-	bool unlocked = params->unlocked;
 
 	if (list_empty(&params->tlb_flush_waitlist))
 		return;
@@ -562,7 +561,7 @@ void amdgpu_vm_pt_free_list(struct amdgpu_device *adev,
 	/*
 	 * unlocked unmap clear page table leaves, warning to free the page entry.
 	 */
-	WARN_ON(unlocked);
+	WARN_ON(params->unlocked);
 
 	list_for_each_entry_safe(entry, next, &params->tlb_flush_waitlist, vm_status)
 		amdgpu_vm_pt_free(entry);
@@ -800,24 +799,17 @@ int amdgpu_vm_ptes_update(struct amdgpu_vm_update_params *params,
 		uint64_t incr, entry_end, pe_start;
 		struct amdgpu_bo *pt;
 
-		if (!params->unlocked) {
-			/* make sure that the page tables covering the
-			 * address range are actually allocated
-			 */
-			r = amdgpu_vm_pt_alloc(params->adev, params->vm,
-					       &cursor);
-			if (r)
-				return r;
-		}
+		/* make sure that the page tables covering the
+		 * address range are actually allocated
+		 */
+		r = amdgpu_vm_pt_alloc(params->adev, params->vm, &cursor);
+		if (r)
+			return r;
 
 		shift = amdgpu_vm_pt_level_shift(adev, cursor.level);
 		parent_shift = amdgpu_vm_pt_level_shift(adev, cursor.level - 1);
-		if (params->unlocked) {
-			/* Unlocked updates are only allowed on the leaves */
-			if (amdgpu_vm_pt_descendant(adev, &cursor))
-				continue;
-		} else if (adev->asic_type < CHIP_VEGA10 &&
-			   (flags & AMDGPU_PTE_VALID)) {
+		if (adev->asic_type < CHIP_VEGA10 &&
+		    (flags & AMDGPU_PTE_VALID)) {
 			/* No huge page support before GMC v9 */
 			if (cursor.level != AMDGPU_VM_PTB) {
 				if (!amdgpu_vm_pt_descendant(adev, &cursor))
@@ -863,14 +855,7 @@ int amdgpu_vm_ptes_update(struct amdgpu_vm_update_params *params,
 		mask = amdgpu_vm_pt_entries_mask(adev, cursor.level);
 		pe_start = ((cursor.pfn >> shift) & mask) * 8;
 
-		if (cursor.level < AMDGPU_VM_PTB && params->unlocked)
-			/*
-			 * MMU notifier callback unlocked unmap huge page, leave is PDE entry,
-			 * only clear one entry. Next entry search again for PDE or PTE leave.
-			 */
-			entry_end = 1ULL << shift;
-		else
-			entry_end = ((uint64_t)mask + 1) << shift;
+		entry_end = ((uint64_t)mask + 1) << shift;
 		entry_end += cursor.pfn & ~(entry_end - 1);
 		entry_end = min(entry_end, end);
 
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
index bc754f407f00..93e490f00c83 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -1406,9 +1406,8 @@ svm_range_unmap_from_gpu(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 		return -EINVAL;
 	}
 
-	return amdgpu_vm_update_range(adev, vm, true, true, false, NULL, gpu_start,
-				      gpu_end, init_pte_value, 0, 0, NULL, NULL,
-				      fence);
+	return amdgpu_vm_unmap_range(adev, vm, NULL, gpu_start, gpu_end,
+				     init_pte_value, fence);
 }
 
 static int
@@ -1518,12 +1517,11 @@ svm_range_map_to_gpu(struct kfd_process_device *pdd, struct svm_range *prange,
 			 (last_domain == SVM_RANGE_VRAM_DOMAIN) ? 1 : 0,
 			 pte_flags);
 
-		r = amdgpu_vm_update_range(adev, vm, false, flush_tlb, true,
-					   NULL, gpu_start, gpu_end,
-					   pte_flags,
-					   (last_start - prange->start) << PAGE_SHIFT,
-					   bo_adev ? bo_adev->vm_manager.vram_base_offset : 0,
-					   NULL, dma_addr, &vm->last_update);
+		r = amdgpu_vm_map_range(adev, vm, flush_tlb, true, NULL,
+					gpu_start, gpu_end, pte_flags,
+					(last_start - prange->start) << PAGE_SHIFT,
+					bo_adev ? bo_adev->vm_manager.vram_base_offset : 0,
+					NULL, dma_addr, &vm->last_update);
 
 		for (j = last_start - prange->start; j <= i; j++)
 			dma_addr[j] |= last_domain;
-- 
2.53.0

