Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E0ADC54E58
	for <amd-gfx@archiver.kernel.org>; Mon, 18 Mar 2024 14:44:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AA00310F7E7;
	Mon, 18 Mar 2024 14:44:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="jH10xPwD";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2047.outbound.protection.outlook.com [40.107.244.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 89AE110F7E7
 for <amd-gfx@lists.freedesktop.org>; Mon, 18 Mar 2024 14:44:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ntBkpEgQJk4PgBG9IWQko3IFguM/WUF8WDOHYzH/e5zlbmD/PHA0les9t+E3qulU92hBL2ZNJKaSuSHlTJMdfwDyCUDfbEzRFLPBDvJe9IV/FrCx9wpDaMBfRMRxJYNWw2t32RICXZiaVLz/BzwsdJrNSQ8lKvLRDZVJAFIrlFU6Y6eTtYSP6/WSjI67bqQuhOiEW6501JZ3Pk4XdUH2rFawr+419quiO4XA5gLtEDEVqKSDhG0LQIMf6367SZwPHnIFsILLGCTOZbSRHU1j8oxOG+4GSFJ1kUwiZnGYKaOwE1nbGomTqbaOOwWKJh5A8lLu7eXKkfxVd0Rvg8o/fA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=REH7e6NnfKyoHYPkUojgqalY42Bx/L58X6VnmXZcFIo=;
 b=ihoIDtnA5bLIOU54aS0gTLhE/HTAMACdUpzmJ5q3p+xbHpmJTmzJdlmyF+rOfDvOTKUt4vSYOEm51wLos84qml+9M2/iUnLZYl5YvO2KV1Epo8s1GaLjd++WI5IUkJoV+IcIzXac6Sy+oVFKCG9n9LzPRPVh1ThJFomEMMFid8lAgzxNaHgVL2qpATavbBrrTRzpihI7B7CyfbLykleFCv03IgkLmvMThPqlRXIPeRj4iSynhbi62DNCizqMo+zgDb6PZeezmLfWevHnRS+VpkPJycCKnKw4edIjPOhEKPljSLGu5vSZY3jDJEGPSpX94AklF5xxZvzXp/zn4i+2sQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=REH7e6NnfKyoHYPkUojgqalY42Bx/L58X6VnmXZcFIo=;
 b=jH10xPwD95YFUkmPWeZzXX9NNSZa6fY7SCpakSfyFyvyCakQUX9MWMp2advy+AD36F8uXREOg5yurn80DHAVa1hIFwG5c0qGGUpNXSGBZG8HEdd6aHNrcMXzUps9a2LeE6Pth4XiStSAucAfeRh5UwmxeWoOvPEJzNryPe4zBCU=
Received: from SJ0PR13CA0096.namprd13.prod.outlook.com (2603:10b6:a03:2c5::11)
 by IA1PR12MB8494.namprd12.prod.outlook.com (2603:10b6:208:44c::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.26; Mon, 18 Mar
 2024 14:44:36 +0000
Received: from MWH0EPF000989EA.namprd02.prod.outlook.com
 (2603:10b6:a03:2c5:cafe::8c) by SJ0PR13CA0096.outlook.office365.com
 (2603:10b6:a03:2c5::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.11 via Frontend
 Transport; Mon, 18 Mar 2024 14:44:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000989EA.mail.protection.outlook.com (10.167.241.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7409.10 via Frontend Transport; Mon, 18 Mar 2024 14:44:35 +0000
Received: from MUN-L-SHSHARMA.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 18 Mar
 2024 09:44:33 -0500
From: Shashank Sharma <shashank.sharma@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Shashank Sharma <shashank.sharma@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <Christian.Koenig@amd.com>, Alex Deucher
 <alexander.deucher@amd.com>, Felix Kuehling <felix.kuehling@amd.com>,
 Rajneesh Bhardwaj <rajneesh.bhardwaj@amd.com>
Subject: [PATCH v8] drm/amdgpu: sync page table freeing with tlb flush
Date: Mon, 18 Mar 2024 15:44:12 +0100
Message-ID: <20240318144412.2051-1-shashank.sharma@amd.com>
X-Mailer: git-send-email 2.38.0.windows.1
In-Reply-To: <7caeb5ca-4164-4d4d-bfd9-147abcbf105d@amd.com>
References: <7caeb5ca-4164-4d4d-bfd9-147abcbf105d@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000989EA:EE_|IA1PR12MB8494:EE_
X-MS-Office365-Filtering-Correlation-Id: 6b506eaf-4b07-4404-d4cf-08dc4759ee89
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5Frt6a6lGXPxKWtEDsU3QM0GOLE/xfSBlPsr7Hh/aBGDduDF2E3X7UvRvyfWx6BmjtnAfL5VOyNBw5SYCblOhuYVxNwpFVQYhpbpecqx7U/A0g32mBMfS1RwtCyDAN41LNr9TnowLZPbD182T6dMdp49Ap5exomxdm3dgM+NpJaGnAMBg6SCqnTt1rbJOwqcahKMTZ7aa81pIlQNtRwEPABmqfSjUojaR3vtYlyShFAbLWVpYfqT0B0fqNhJMFHbrh/r1QLnIAZ/aNrxfpQPVidfQtqNeOi5wEK3IEocJ4Hmxd0INowDwzmK/LSOGE2DwR9b7mJXSzFjhItg6FUC7WivmTJZPyhw0EsylrhGy2pPSZiA4xAae1vONf9ysmqLSzf675Y2RzBcnAtUPFAwbGpkzfQ7QPdsRvPdG1AwGmTjveY4ukc6yTx4igU9SeUesP7cuNes+VYzIFoxOckZ4X+hnB7MvlyAmLAEgm2CTEcfFyVnGgM7dAudGJ4wjnTYSttyDzIBXx3vITZ62a0qXJpIbOwt4Q/rFncwg5VhycxDL+k51kAZ5vPxAts5Frk3YH9YgYPqUTSUiyjYv6fnfr3hR1Gs97C0FbnPKdE6gxHnDBILJi5/1dEIAa/quKzbqLDuui/BfvB+sykOZQNZiQS18vljky412KlNyMMY52Oo1Bk+GspD4ujBNvyR2N0anHKSyGd5YKx4LxyUu1hiwbQHQYCj9RaJP3NGE9Ae9OaFaQ5Y3UUPRSshvPmig/bq
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(376005)(1800799015)(36860700004)(82310400014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2024 14:44:35.7877 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b506eaf-4b07-4404-d4cf-08dc4759ee89
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000989EA.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8494
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

Cc: Christian König <Christian.Koenig@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Felix Kuehling <felix.kuehling@amd.com>
Cc: Rajneesh Bhardwaj <rajneesh.bhardwaj@amd.com>
Acked-by: Felix Kuehling <felix.kuehling@amd.com>
Acked-by: Rajneesh Bhardwaj <rajneesh.bhardwaj@amd.com>
Tested-by: Rajneesh Bhardwaj <rajneesh.bhardwaj@amd.com>
Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c    |  5 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h    |  7 +++
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c | 58 +++++++++++++----------
 3 files changed, 45 insertions(+), 25 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index 26f1c3359642..eaa402f99fe0 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -977,6 +977,7 @@ int amdgpu_vm_update_range(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 	params.unlocked = unlocked;
 	params.needs_flush = flush_tlb;
 	params.allow_override = allow_override;
+	INIT_LIST_HEAD(&params.tlb_flush_waitlist);
 
 	/* Implicitly sync to command submissions in the same VM before
 	 * unmapping. Sync to moving fences before mapping.
@@ -1062,8 +1063,10 @@ int amdgpu_vm_update_range(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 	if (r)
 		goto error_unlock;
 
-	if (params.needs_flush)
+	if (params.needs_flush) {
 		r = amdgpu_vm_tlb_flush(&params, fence);
+		amdgpu_vm_pt_free_list(adev, &params);
+	}
 
 error_unlock:
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
index 601df0ce8290..9231edfb427e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
@@ -622,40 +622,30 @@ void amdgpu_vm_pt_free_work(struct work_struct *work)
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
-
-	if (start)
-		amdgpu_vm_pt_free(start->entry);
 }
 
 /**
@@ -667,7 +657,13 @@ static void amdgpu_vm_pt_free_dfs(struct amdgpu_device *adev,
  */
 void amdgpu_vm_pt_free_root(struct amdgpu_device *adev, struct amdgpu_vm *vm)
 {
-	amdgpu_vm_pt_free_dfs(adev, vm, NULL, false);
+	struct amdgpu_vm_pt_cursor cursor;
+	struct amdgpu_vm_bo_base *entry;
+
+	for_each_amdgpu_vm_pt_dfs_safe(adev, vm, NULL, cursor, entry) {
+		if (entry)
+			amdgpu_vm_pt_free(entry);
+	}
 }
 
 /**
@@ -972,10 +968,24 @@ int amdgpu_vm_ptes_update(struct amdgpu_vm_update_params *params,
 			while (cursor.pfn < frag_start) {
 				/* Make sure previous mapping is freed */
 				if (cursor.entry->bo) {
+					struct amdgpu_vm_pt_cursor seek;
+					struct amdgpu_vm_bo_base *entry;
+
 					params->needs_flush = true;
-					amdgpu_vm_pt_free_dfs(adev, params->vm,
-							      &cursor,
-							      params->unlocked);
+					spin_lock(&params->vm->status_lock);
+					for_each_amdgpu_vm_pt_dfs_safe(adev, params->vm, &cursor,
+								       seek, entry) {
+						if (!entry || !entry->bo)
+							continue;
+
+						list_move(&entry->vm_status,
+							  &params->tlb_flush_waitlist);
+					}
+
+					/* enter start node now */
+					list_move(&cursor.entry->vm_status,
+						  &params->tlb_flush_waitlist);
+					spin_unlock(&params->vm->status_lock);
 				}
 				amdgpu_vm_pt_next(adev, &cursor);
 			}
-- 
2.43.2

