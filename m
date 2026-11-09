Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C48FC606A332
	for <amd-gfx@archiver.kernel.org>; Mon,  9 Nov 2026 14:08:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=MX6STt2M
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4414A10E524;
	Mon,  9 Nov 2026 14:08:46 +0000 (UTC)
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010020.outbound.protection.outlook.com [52.101.201.20])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1050D10E524
 for <amd-gfx@lists.freedesktop.org>; Mon,  9 Nov 2026 14:08:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HaQcfqggaizZjuYf0U9DAEIh2L5KAUKX7MqpkjFyagzMTdTtsq4eihQkJmmIxn1pSOVDVoZ9Z49yUKcQrWZ92Gb0+dyYK0tRsncuDniCFaMM8TppHY0b6poUbl4arbMnsIh+yTClLTeU/PC/sFXsecnDHzxClcoeOSfE6NjBLgP8cOKcgXQgC7XE7L9pGDq+NRl8XBYQvY+r8aZA9zz0ea7VsRWpNAdtGsX7a9SxmWbAHQL0HEtpNvAo2muC0QcF2fd4yAAZGoLSf4Iy5afiep9UxZMmJUdkNE8MSAsgqvRaU244/6Cv3WN1W5Lxmz1u+K5MDF5Ji2eHb8oUV3MMDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cZ14AdZr+xRYth51JwgssvEB8pgiUoiZ4EZgIx/0bQQ=;
 b=lE1pCghK24I1bNE3nRj5UK8f/vfwuoetyJqhQUxa86nGiGqCGhKrXejkarXXhiI7akD0TRC3UyerAXstYD0mdG+jPrexRYTi+j7bWz+3ZUZqmOugQVcalLkk7oNhnb4Z0a3ld3ibtwZySTrBQCK1o8zjdrzsc1l72tl0dfDO1OANrUHhlGgNUyz7AeEZN4z4oT47w13j/U/biqhuq1TVw1l1X3zHTvAG399wwrHV8ZAYUHHlRuC+5+Ln5uFr3S1YMQvVQxrN86xguYTkjIAU8lJcccZ7FHMaGoBDXCXPb9lYmwksQ61EkhxYVSoa6RLxAlDbTEVjeDgiPieXyOc/Tg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cZ14AdZr+xRYth51JwgssvEB8pgiUoiZ4EZgIx/0bQQ=;
 b=MX6STt2MiDfYxUdwpaHtjWhO6pvsdYbcq43XgsK52s043BhjjChXKBs6R+FqOYwHxl4EqJW621STPFvIbHQWn2RxrUTEpmxTKaaPbTG4J6DvzLumReNaatG6hq67wrfI0gYUUQ8yFxtdgdK+tcHnWAs8rFQH/YW/51e7N3YTwuE=
Received: from DS1PR02CA0004.namprd02.prod.outlook.com (2603:10b6:8:452::14)
 by DS0PR12MB9038.namprd12.prod.outlook.com (2603:10b6:8:f2::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.12; Mon, 9 Nov
 2026 14:06:30 +0000
Received: from MWH0EPF000D894C.namprd05.prod.outlook.com
 (2603:10b6:8:452:cafe::17) by DS1PR02CA0004.outlook.office365.com
 (2603:10b6:8:452::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.13 via Frontend Transport; Mon, 9
 Nov 2026 14:06:30 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MWH0EPF000D894C.mail.protection.outlook.com (10.167.249.212) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Mon, 9 Nov 2026 14:06:29 +0000
Received: from chonglidebug.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Mon, 9 Nov
 2026 08:06:28 -0600
From: chong li <chongli2@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <christian.koenig@amd.com>, chong li <chongli2@amd.com>
Subject: [PATCH] drm/amdgpu: fix page fault by not skipping VM flush before
 tlb_seq update
Date: Mon, 9 Nov 2026 22:06:15 +0800
Message-ID: <20261109140616.2326304-1-chongli2@amd.com>
X-Mailer: git-send-email 2.48.1
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000D894C:EE_|DS0PR12MB9038:EE_
X-MS-Office365-Filtering-Correlation-Id: 02114e97-3046-4179-b053-08df3e6aa6eb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|23010399003|376014|1800799024|18002099003|10067099003|11063799006|261028144727099003|261102123227099003|261022075727099003|261022105027099003|56012099006|261021121427099003|261021123027099003|261026140227099003|261009223027099003;
X-Microsoft-Antispam-Message-Info: VcqYwHdl2FoM02gs6Xhga83XQXRMIxJiIyBUllxVaGl/xigxGscZc116Mj6zOhVbmVrKXwvqyiVgAo/Y1rzwVZaaTe+SkIwz4HTSwr7GEqruGJ3veWZcGZVFjQCRO/wW+qWwReok4zSXUstSaoErC0q+wJT9exeM1hBaxCJr8mzfjbIvXw3/dzS3fnSBO9QpPYqT8qUE2u+0AhRFVYl4qfnCZnaag6aJs/+taoFcj3Z98cWpiQpjT225MDkKnGKBFlSXHUmH2flwQn1UVCFi1K65SIVoHwiUuMm91AOtOXKWrt+AabbrGuCbIaMvlAWqaPGwtkwJNyeOh2C64BzX5ZzMiKkiJjPLivNFV/1EisPd3tv6SxL4ndHz6vML518SEJFB+xEeNy6R1HDIqrYyVoQlqcKL1dfgwPjwbHh1QNZXIaUtR44D6secwIssxQZm0GjmI6hPjTizzrJwyvn3M3bcVo7F0hzgDgosCrSg382GWQo5U5tbHYqa1BFuPk9m+MWYpxSlPF8XEFZAZ3GV8+KO6YMhFf2j1jbVmOsF3OBgL+HH3ZgyIOimVnptzCxi5DbxfwgG7Jc/TGtzbKOFI+0x2ndGUQp8ZvCdyIPqfxC9g+fDqx0g/si0hA4LziUdeza6awyR4LKZdfUhHaljAIDfoO7MBCJLnMLtxYAb5OKdfvNMRFHoK0R21xuHSGvWWlazazQ5wDenkJnnWPFVNw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(23010399003)(376014)(1800799024)(18002099003)(10067099003)(11063799006)(261028144727099003)(261102123227099003)(261022075727099003)(261022105027099003)(56012099006)(261021121427099003)(261021123027099003)(261026140227099003)(261009223027099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: V4VTlcEWV+u280qalIHdH8nRsAdKteC4TfM9vEelP/+GqxCYfrOZHEPNsSSYqYgN8m7tItQAXHyvvqxu/LszN3Iz4cXzV1DcsLQ65y2GzM8UDzK/eOuXcvx3kndWy7YXo/CeiTw6EgolYl/vsnCGZbzsltWlQg4a2TtIuHyrAgM9RVWjMXdxuyQO8bGa63+g963nXs+9vDFa1STmYn1fBYTi6ZJJmUMZl+ta+m13AR4ls3QLPTFNf7w4yOSFiUauJdKOAkVT90D8X7m5XhOFgc7iJnNEy9TRGRnkaSuuHzOURWYBbKYajS1imMKvmoLeSjB+xV8DSUmkp/DSSdI0ZPdyflS1nSPudU/agvSpU+19S1XVcbPpt+2/Apw2m2st5k9DI1Caat3ElDEZ7NUi1+THriW2lFU6Prf+jKndV4W5m2pZP6d1HrVLzyyIqy/8
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2026 14:06:29.6576 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 02114e97-3046-4179-b053-08df3e6aa6eb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000D894C.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9038
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

amdgpu_vm_tlb_seq() waits for the tlb_seq callback by taking the lock of
vm->last_tlb_flush. Newer page table updates replace vm->last_tlb_flush
immediately, without waiting for older callbacks. A job scheduled after
an older fence signals but before its callback finishes takes the newer
fence's lock, while the callback runs under the older fence's own lock.
The job misses that tlb_seq increment and can reuse a VMID whose TLB was
last flushed before the older page table update completed, without
flushing the TLB again.

how to fix:
Count the flush-requiring page table updates whose tlb_seq callback has
not run yet, and request a VM flush when a job reuses a VMID while this
count is non-zero.

Signed-off-by: chong li <chongli2@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c | 10 ++++++++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c  | 12 +++++++++++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h  | 10 ++++++++++
 3 files changed, 29 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c
index 9c879ac68352..b9e058da162b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c
@@ -393,7 +393,8 @@ static int amdgpu_vmid_grab_reserved(struct amdgpu_vm *vm,
 	unsigned vmhub = ring->vm_hub;
 	uint64_t fence_context = adev->fence_context + ring->idx;
 	bool needs_flush = vm->use_cpu_for_update;
-	uint64_t updates = amdgpu_vm_tlb_seq(vm);
+	bool tlb_pending;
+	uint64_t updates = amdgpu_vm_tlb_seq_pending(vm, &tlb_pending);
 	int r;
 
 	*id = vm->reserved_vmid[vmhub];
@@ -405,6 +406,8 @@ static int amdgpu_vmid_grab_reserved(struct amdgpu_vm *vm,
 	     !dma_fence_is_signaled((*id)->last_flush)))
 		needs_flush = true;
 
+	needs_flush |= tlb_pending;
+
 	if ((*id)->owner != vm->immediate.fence_context ||
 	    (!adev->vm_manager.concurrent_flush && needs_flush)) {
 		struct dma_fence *tmp;
@@ -456,7 +459,8 @@ static int amdgpu_vmid_grab_used(struct amdgpu_vm *vm,
 	unsigned vmhub = ring->vm_hub;
 	struct amdgpu_kq_vmid_mgr *id_mgr = &adev->vm_manager.id_mgr[vmhub];
 	uint64_t fence_context = adev->fence_context + ring->idx;
-	uint64_t updates = amdgpu_vm_tlb_seq(vm);
+	bool tlb_pending;
+	uint64_t updates = amdgpu_vm_tlb_seq_pending(vm, &tlb_pending);
 	int r;
 
 	job->vm_needs_flush = vm->use_cpu_for_update;
@@ -480,6 +484,8 @@ static int amdgpu_vmid_grab_used(struct amdgpu_vm *vm,
 		if ((*id)->flushed_updates < updates)
 			needs_flush = true;
 
+		needs_flush |= tlb_pending;
+
 		if (needs_flush && !adev->vm_manager.concurrent_flush)
 			continue;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index 2ba33212d507..6d15fd001a42 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -1095,6 +1095,9 @@ static void amdgpu_vm_tlb_seq_cb(struct dma_fence *fence,
 
 	tlb_cb = container_of(cb, typeof(*tlb_cb), cb);
 	atomic64_inc(&tlb_cb->vm->tlb_seq);
+	/* Pairs with atomic_read_acquire() in amdgpu_vm_tlb_seq_pending() */
+	smp_mb__before_atomic();
+	atomic_dec(&tlb_cb->vm->tlb_pending);
 	kfree(tlb_cb);
 }
 
@@ -1281,9 +1284,16 @@ int amdgpu_vm_update_range(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 		start = tmp;
 	}
 
+	/* Must be visible before the update fence can signal */
+	if (params.needs_flush)
+		atomic_inc(&vm->tlb_pending);
+
 	r = vm->update_funcs->commit(&params, fence);
-	if (r)
+	if (r) {
+		if (params.needs_flush)
+			atomic_dec(&vm->tlb_pending);
 		goto error_free;
+	}
 
 	if (params.needs_flush) {
 		amdgpu_vm_tlb_flush(&params, fence, tlb_cb);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
index d8e17f493f61..312fd0d268ce 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
@@ -337,6 +337,8 @@ struct amdgpu_vm {
 
 	/* Last finished delayed update */
 	atomic64_t		tlb_seq;
+	/* Flush updates whose tlb_seq callback has not run yet */
+	atomic_t		tlb_pending;
 	struct dma_fence	*last_tlb_flush;
 	atomic64_t		kfd_last_flushed_seq;
 	uint64_t		tlb_fence_context;
@@ -578,6 +580,14 @@ static inline uint64_t amdgpu_vm_tlb_seq(struct amdgpu_vm *vm)
 	return atomic64_read(&vm->tlb_seq);
 }
 
+/* Read tlb_pending first; pairs with the barrier in amdgpu_vm_tlb_seq_cb() */
+static inline uint64_t amdgpu_vm_tlb_seq_pending(struct amdgpu_vm *vm,
+						 bool *pending)
+{
+	*pending = atomic_read_acquire(&vm->tlb_pending) != 0;
+	return amdgpu_vm_tlb_seq(vm);
+}
+
 void amdgpu_vm_update_fault_cache(struct amdgpu_device *adev,
 				  unsigned int pasid,
 				  uint64_t addr,
-- 
2.48.1

