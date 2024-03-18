Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90B2BC54E58
	for <amd-gfx@archiver.kernel.org>; Mon, 18 Mar 2024 16:12:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1DEEA10FB9E;
	Mon, 18 Mar 2024 16:12:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="nyBsbJUg";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2075.outbound.protection.outlook.com [40.107.223.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7A68410FB9B
 for <amd-gfx@lists.freedesktop.org>; Mon, 18 Mar 2024 16:12:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HYbAStLB4awpmpfg9tHxgYLFZejDGU5f1omLOBRh2xAWUAbXKDUph+QwYKoVCPu4qMq+YLe1qTirQGwdPIehmOjDlV3u3pa2n7kZYcIi+YWRV/Zklz7r9pvegTd2MGcb/QJQeRJY3aUR3tTcVAtSpBrqkalsNYBkPhuAfl4XzeRx81LWDFai2iJmDZijTMhoBhnQgLxF0fZLxXE9gzR6l7lOK4r/Zxe2AJv4r+lpcE3NUIcmBOWp7hRiXLvomxfOUkUBQcvZjcyVQznA8MBSB45WL71eK6AC7j84R33VMGY2SEDJMsy4gPFYRuDsbrsDmXbXmS07DuPX4LUuzOcd8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ilTq8UbY8YoxrzKhHW2IZEiORGppX4XbWzkyEbxdILQ=;
 b=CB9jYpeSGkkbqjcQcPkgpP7jll82atCIoNCMtili9ouBv6uPN9Fy57VSyguFFc0a386Hn8JsK0JemQBR50kdYRlB7WP+uD3dhbf2uvwHS8B7rrjlol3nnPkC87De+BBs1o9pVwPIZNaTdjhzG/qN+KO5p2lVssjZUzCo2PHrwGLpO/H460xit1gBuTcbdb6gWJLholuiHmebFEKx5iHgGoU3oA2xMRQ3c0/P+kV6reWu5iNWFb3j5mGBf0Hs2lpgrThzyqKtsC3tfpclIJ2crulvS9H6HSB9D/FQJ6Ye/FB+CuEZsYPCTbUuqQEvfZuIZWXmFTGPQ75ERS5WJ+NGQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ilTq8UbY8YoxrzKhHW2IZEiORGppX4XbWzkyEbxdILQ=;
 b=nyBsbJUgQYemMPITgNTyGabSpaCYG29HNCtKNu65JG8BqEQNrr8QZW//m2qLuN6Ec5AwzMol78kKi/1n+LmDYLYQMX9BXrO/ZrqnUuqGIh+QG5vzbsVlQHtPI4sl9x7uD4kETiXB7UrfurXzBCGIXnaLY5UKRyvCB7rmGPE2igA=
Received: from CH5P223CA0014.NAMP223.PROD.OUTLOOK.COM (2603:10b6:610:1f3::16)
 by DM4PR12MB6397.namprd12.prod.outlook.com (2603:10b6:8:b4::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.27; Mon, 18 Mar
 2024 16:12:10 +0000
Received: from CH2PEPF0000014A.namprd02.prod.outlook.com
 (2603:10b6:610:1f3:cafe::78) by CH5P223CA0014.outlook.office365.com
 (2603:10b6:610:1f3::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.27 via Frontend
 Transport; Mon, 18 Mar 2024 16:12:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH2PEPF0000014A.mail.protection.outlook.com (10.167.244.107) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7409.10 via Frontend Transport; Mon, 18 Mar 2024 16:12:10 +0000
Received: from MUN-L-SHSHARMA.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 18 Mar
 2024 11:12:04 -0500
From: Shashank Sharma <shashank.sharma@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Shashank Sharma <shashank.sharma@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <Christian.Koenig@amd.com>, Alex Deucher
 <alexander.deucher@amd.com>, Felix Kuehling <felix.kuehling@amd.com>,
 Rajneesh Bhardwaj <rajneesh.bhardwaj@amd.com>
Subject: [PATCH v9 2/2] drm/amdgpu: sync page table freeing with tlb flush
Date: Mon, 18 Mar 2024 17:11:40 +0100
Message-ID: <20240318161140.2101-2-shashank.sharma@amd.com>
X-Mailer: git-send-email 2.38.0.windows.1
In-Reply-To: <20240318161140.2101-1-shashank.sharma@amd.com>
References: <20240318161140.2101-1-shashank.sharma@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000014A:EE_|DM4PR12MB6397:EE_
X-MS-Office365-Filtering-Correlation-Id: 39b04ab1-1e3a-45ae-84e1-08dc47662a3f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 248tcIk17dCr9KlNwl64cYAAU5G4fwDmYpMzfjG9hsX1SjA33HK64wqP+je0WSNs5hji72M+Ao4CzIfuof2EqNgcvV5xQI2f6mVK6xqvI2VHeH5CSXWbR0lzgPg8zsBJTxYzD9CLjkPglXl727IuyNoVMeBgzEtwmf/T6sXPlPFTS6XTc8dtdmz06mcEyE+gqts/Mb/WZvoAmaY3gyHtGO/qCngRSfORYfnpUzmtP0+/no41ml0kiK2XQ9jwVqfxciB6VT57PIbW+PP0stH2G5A1qZ/yPtJ+WyaZk0Y93UL9KQoiSDhDWmaoM8dm2ukk1g28ywXWQd/Wh1AJjGrlE2jKTGNjmnVfyMAwbT9cHPVNYunwFxvF53m4+fYFgCGiskqr8hXe0uNaP+ImZEmWSRalxMsKvj40ILA1BXxdc3nA7mnjyjBQjkVnBl5dYNYUrTfZH0fWMy/1pV8UsHdpHvwLsgasLEMjsfZA0FYSFFuGpf/awkLbWQjzdWM1syEPrxyRNgiKFuUbO8KPPO0HHkhiRVjotTFgYXO4aNHl4m7xKW0zEtx/WfYWj69Fa//2WvNs02LwwKh+K9dTEZoa08TKrAaHRl9fJ95cDSdN/y95nhbGn2FkS/zjTT1oAFBubLgz2S8eeIK6PEXP6tTYh/xHZXie9D0c+PJ5rDNzhH14IA6KrAhP452JCgRJOYiWGCgL8SBMywwOMS9OULzLupDV8wzuKQnHuuV1GCPqaeOdaTF42+7niFT0IKJCRoYO
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(36860700004)(82310400014)(376005)(1800799015); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2024 16:12:10.0184 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 39b04ab1-1e3a-45ae-84e1-08dc47662a3f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF0000014A.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6397
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

The idea behind this patch is to delay the freeing of PT entry objects
until the TLB flush is done.

This patch:
- Adds a tlb_flush_waitlist in amdgpu_vm_update_params which will keep the
  objects that need to be freed after tlb_flush.
- Adds PT entries in this list in amdgpu_vm_ptes_update after finding
  the PT entry.
- Changes functionality of amdgpu_vm_pt_free_dfs from (df_search + free)
  to simply freeing of the BOs, also renames it to
  amdgpu_vm_pt_free_list to reflect this same.
- Exports function amdgpu_vm_pt_free_list to be called directly.
- Calls amdgpu_vm_pt_free_list directly from amdgpu_vm_update_range.

V2: rebase
V4: Addressed review comments from Christian
    - add only locked PTEs entries in TLB flush waitlist.
    - do not create a separate function for list flush.
    - do not create a new lock for TLB flush.
    - there is no need to wait on tlb_flush_fence exclusively.

V5: Addressed review comments from Christian
    - change the amdgpu_vm_pt_free_dfs's functionality to simple freeing
      of the objects and rename it.
    - add all the PTE objects in params->tlb_flush_waitlist
    - let amdgpu_vm_pt_free_root handle the freeing of BOs independently
    - call amdgpu_vm_pt_free_list directly

V6: Rebase
V7: Rebase
V8: Added a NULL check to fix this backtrace issue:
[  415.351447] BUG: kernel NULL pointer dereference, address: 0000000000000008
[  415.359245] #PF: supervisor write access in kernel mode
[  415.365081] #PF: error_code(0x0002) - not-present page
[  415.370817] PGD 101259067 P4D 101259067 PUD 10125a067 PMD 0
[  415.377140] Oops: 0002 [#1] PREEMPT SMP NOPTI
[  415.382004] CPU: 0 PID: 25481 Comm: test_with_MPI.e Tainted: G           OE     5.18.2-mi300-build-140423-ubuntu-22.04+ #24
[  415.394437] Hardware name: AMD Corporation Sh51p/Sh51p, BIOS RMO1001AS 02/21/2024
[  415.402797] RIP: 0010:amdgpu_vm_ptes_update+0x6fd/0xa10 [amdgpu]
[  415.409648] Code: 4c 89 ff 4d 8d 66 30 e8 f1 ed ff ff 48 85 db 74 42 48 39 5d a0 74 40 48 8b 53 20 48 8b 4b 18 48 8d 43 18 48 8d 75 b0 4c 89 ff <48
> 89 51 08 48 89 0a 49 8b 56 30 48 89 42 08 48 89 53 18 4c 89 63
[  415.430621] RSP: 0018:ffffc9000401f990 EFLAGS: 00010287
[  415.436456] RAX: ffff888147bb82f0 RBX: ffff888147bb82d8 RCX: 0000000000000000
[  415.444426] RDX: 0000000000000000 RSI: ffffc9000401fa30 RDI: ffff888161f80000
[  415.452397] RBP: ffffc9000401fa80 R08: 0000000000000000 R09: ffffc9000401fa00
[  415.460368] R10: 00000007f0cc0000 R11: 00000007f0c85000 R12: ffffc9000401fb20
[  415.468340] R13: 00000007f0d00000 R14: ffffc9000401faf0 R15: ffff888161f80000
[  415.476312] FS:  00007f132ff89840(0000) GS:ffff889f87c00000(0000) knlGS:0000000000000000
[  415.485350] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  415.491767] CR2: 0000000000000008 CR3: 0000000161d46003 CR4: 0000000000770ef0
[  415.499738] PKRU: 55555554
[  415.502750] Call Trace:
[  415.505482]  <TASK>
[  415.507825]  amdgpu_vm_update_range+0x32a/0x880 [amdgpu]
[  415.513869]  amdgpu_vm_clear_freed+0x117/0x250 [amdgpu]
[  415.519814]  amdgpu_amdkfd_gpuvm_unmap_memory_from_gpu+0x18c/0x250 [amdgpu]
[  415.527729]  kfd_ioctl_unmap_memory_from_gpu+0xed/0x340 [amdgpu]
[  415.534551]  kfd_ioctl+0x3b6/0x510 [amdgpu]

V9: Addressed review comments from Christian
    - No NULL check reqd for root PT freeing
    - Free PT list regardless of needs_flush
    - Move adding BOs in list in a separate function

Cc: Christian König <Christian.Koenig@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Felix Kuehling <felix.kuehling@amd.com>
Cc: Rajneesh Bhardwaj <rajneesh.bhardwaj@amd.com>
Acked-by: Felix Kuehling <felix.kuehling@amd.com>
Acked-by: Rajneesh Bhardwaj <rajneesh.bhardwaj@amd.com>
Tested-by: Rajneesh Bhardwaj <rajneesh.bhardwaj@amd.com>
Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c    |  3 ++
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h    |  7 +++
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c | 66 +++++++++++++++--------
 3 files changed, 53 insertions(+), 23 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index 104bf600c85f..8fada1152664 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -986,6 +986,7 @@ int amdgpu_vm_update_range(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 	params.unlocked = unlocked;
 	params.needs_flush = flush_tlb;
 	params.allow_override = allow_override;
+	INIT_LIST_HEAD(&params.tlb_flush_waitlist);
 
 	/* Implicitly sync to command submissions in the same VM before
 	 * unmapping. Sync to moving fences before mapping.
@@ -1076,6 +1077,8 @@ int amdgpu_vm_update_range(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 		tlb_cb = NULL;
 	}
 
+	amdgpu_vm_pt_free_list(adev, &params);
+
 error_free:
 	kfree(tlb_cb);
 	amdgpu_vm_eviction_unlock(vm);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
index b0a4fe683352..54d7da396de0 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
@@ -266,6 +266,11 @@ struct amdgpu_vm_update_params {
 	 * to be overridden for NUMA local memory.
 	 */
 	bool allow_override;
+
+	/**
+	 * @tlb_flush_waitlist: temporary storage for BOs until tlb_flush
+	 */
+	struct list_head tlb_flush_waitlist;
 };
 
 struct amdgpu_vm_update_funcs {
@@ -547,6 +552,8 @@ int amdgpu_vm_ptes_update(struct amdgpu_vm_update_params *params,
 			  uint64_t start, uint64_t end,
 			  uint64_t dst, uint64_t flags);
 void amdgpu_vm_pt_free_work(struct work_struct *work);
+void amdgpu_vm_pt_free_list(struct amdgpu_device *adev,
+			    struct amdgpu_vm_update_params *params);
 
 #if defined(CONFIG_DEBUG_FS)
 void amdgpu_debugfs_vm_bo_info(struct amdgpu_vm *vm, struct seq_file *m);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
index 601df0ce8290..d904fc96ba0f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
@@ -622,40 +622,58 @@ void amdgpu_vm_pt_free_work(struct work_struct *work)
 }
 
 /**
- * amdgpu_vm_pt_free_dfs - free PD/PT levels
+ * amdgpu_vm_pt_free_list - free PD/PT levels
  *
  * @adev: amdgpu device structure
- * @vm: amdgpu vm structure
- * @start: optional cursor where to start freeing PDs/PTs
- * @unlocked: vm resv unlock status
+ * @params: see amdgpu_vm_update_params definition
  *
- * Free the page directory or page table level and all sub levels.
+ * Free the page directory objects saved in the flush list
  */
-static void amdgpu_vm_pt_free_dfs(struct amdgpu_device *adev,
-				  struct amdgpu_vm *vm,
-				  struct amdgpu_vm_pt_cursor *start,
-				  bool unlocked)
+void amdgpu_vm_pt_free_list(struct amdgpu_device *adev,
+			    struct amdgpu_vm_update_params *params)
 {
-	struct amdgpu_vm_pt_cursor cursor;
-	struct amdgpu_vm_bo_base *entry;
+	struct amdgpu_vm_bo_base *entry, *next;
+	struct amdgpu_vm *vm = params->vm;
+	bool unlocked = params->unlocked;
+
+	if (list_empty(&params->tlb_flush_waitlist))
+		return;
 
 	if (unlocked) {
 		spin_lock(&vm->status_lock);
-		for_each_amdgpu_vm_pt_dfs_safe(adev, vm, start, cursor, entry)
-			list_move(&entry->vm_status, &vm->pt_freed);
-
-		if (start)
-			list_move(&start->entry->vm_status, &vm->pt_freed);
+		list_splice_init(&vm->pt_freed, &params->tlb_flush_waitlist);
 		spin_unlock(&vm->status_lock);
 		schedule_work(&vm->pt_free_work);
 		return;
 	}
 
-	for_each_amdgpu_vm_pt_dfs_safe(adev, vm, start, cursor, entry)
+	list_for_each_entry_safe(entry, next, &params->tlb_flush_waitlist, vm_status)
 		amdgpu_vm_pt_free(entry);
+}
 
-	if (start)
-		amdgpu_vm_pt_free(start->entry);
+/**
+ * amdgpu_vm_pt_add_list - add PD/PT level to the flush list
+ *
+ * @params: parameters for the update
+ * @cursor: first PT entry to start DF search from, non NULL
+ *
+ * This list will be freed after TLB flush.
+ */
+static void amdgpu_vm_pt_add_list(struct amdgpu_vm_update_params *params,
+				  struct amdgpu_vm_pt_cursor *cursor)
+{
+	struct amdgpu_vm_pt_cursor seek;
+	struct amdgpu_vm_bo_base *entry;
+
+	spin_lock(&params->vm->status_lock);
+	for_each_amdgpu_vm_pt_dfs_safe(params->adev, params->vm, cursor, seek, entry) {
+		if (entry && entry->bo)
+			list_move(&entry->vm_status, &params->tlb_flush_waitlist);
+	}
+
+	/* enter start node now */
+	list_move(&cursor->entry->vm_status, &params->tlb_flush_waitlist);
+	spin_unlock(&params->vm->status_lock);
 }
 
 /**
@@ -667,7 +685,11 @@ static void amdgpu_vm_pt_free_dfs(struct amdgpu_device *adev,
  */
 void amdgpu_vm_pt_free_root(struct amdgpu_device *adev, struct amdgpu_vm *vm)
 {
-	amdgpu_vm_pt_free_dfs(adev, vm, NULL, false);
+	struct amdgpu_vm_pt_cursor cursor;
+	struct amdgpu_vm_bo_base *entry;
+
+	for_each_amdgpu_vm_pt_dfs_safe(adev, vm, NULL, cursor, entry)
+		amdgpu_vm_pt_free(entry);
 }
 
 /**
@@ -973,9 +995,7 @@ int amdgpu_vm_ptes_update(struct amdgpu_vm_update_params *params,
 				/* Make sure previous mapping is freed */
 				if (cursor.entry->bo) {
 					params->needs_flush = true;
-					amdgpu_vm_pt_free_dfs(adev, params->vm,
-							      &cursor,
-							      params->unlocked);
+					amdgpu_vm_pt_add_list(params, &cursor);
 				}
 				amdgpu_vm_pt_next(adev, &cursor);
 			}
-- 
2.43.2

