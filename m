Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 052AEE77188
	for <amd-gfx@archiver.kernel.org>; Fri,  3 Jan 2025 02:40:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 877B010E7E5;
	Fri,  3 Jan 2025 02:40:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="LL1IVA7C";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2063.outbound.protection.outlook.com [40.107.220.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 414F710E7E7
 for <amd-gfx@lists.freedesktop.org>; Fri,  3 Jan 2025 02:40:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yx2MyKPmgnAqePDXoCi991Nj36r0OjCwY4rxfgWDyISc/9+pr4N2ARGTd/0giNOtLo35OOYvbcpoyUyzYIqOMBLREXzVaTF1suQpVuYSssCEuX4XE+TXJaYvVA+OZ0m7ofQlDylkSlkpbWWKG/JAxqrJxF/kKsq6PFoXkaDMvLDMZ+wCRHgHBqQ5Nrz0YAwPkv5HvUJJxDoUUUV6Nf0CORt+8VyBPGg4oOz94uAcMS6LZStmBkb9I1hM0uK/UXP5MSziFhnGAu7ZLjSrpRRIfENiOYzrbWqzmJLUDoS0lJLTiYM11faBIRFnKshQmy4sxma/r/M5XpzoE6+iDK5QIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ieMioZFRS/FSSQ7feg2pXiBe0+lOaDn2SGOYe8TvrCo=;
 b=tWSv6DKaKwhwXDN5FQF/rsAGU5tkKunyIZYp17ApabtNqx3cv2I6XOQyzq/v0IMWgrAIwDYrPAg1maf9TE3ns+q2R/dIW9DV4Y31nRi7pVd8/zqrwsRSJBWG0Qk9meDVmnTWwSSYaKQTvYXpOv7Ar6ly+Kt48ZaCh7je5anGylwelSPcBgLy/U+yeZWLqr+seJ56NLBVdpTRz8brPLTlaCATokG+DqTpe+kcsoEeN5/T954VKpsFR5pse4IASEBf8h/u0j9PmmB7B7u85vym4i//TrQNzE8DWFdRHqyoZzxyHeZQRsLedGTA879AyXv+qqXZVVi9qWyhKgruIhFuXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ieMioZFRS/FSSQ7feg2pXiBe0+lOaDn2SGOYe8TvrCo=;
 b=LL1IVA7CAb58vxSD1BI43H2VZZj3dSRGtG8M+7hzS+RYOHIVsBNwHVxrc4RRv4/huJqkng5AHciNfekyk4Ebl0jwoOYEdvopWgZcvtVm3tXRvdGUJBstD/63o3sBBMF/sBjXD1aY+NY0dab79ocgnHK7WcltGiPWBDzq4bEfLiY=
Received: from BL0PR05CA0009.namprd05.prod.outlook.com (2603:10b6:208:91::19)
 by MN2PR12MB4334.namprd12.prod.outlook.com (2603:10b6:208:1d1::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8314.14; Fri, 3 Jan
 2025 02:26:20 +0000
Received: from BL6PEPF00020E63.namprd04.prod.outlook.com
 (2603:10b6:208:91:cafe::a9) by BL0PR05CA0009.outlook.office365.com
 (2603:10b6:208:91::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8335.5 via Frontend Transport; Fri, 3
 Jan 2025 02:26:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BL6PEPF00020E63.mail.protection.outlook.com (10.167.249.24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8314.11 via Frontend Transport; Fri, 3 Jan 2025 02:26:20 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 2 Jan
 2025 20:26:20 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 2 Jan
 2025 20:26:18 -0600
Received: from emily-Z10PA-U8-Series.amd.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Thu, 2 Jan 2025 20:26:17 -0600
From: Emily Deng <Emily.Deng@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Emily Deng <Emily.Deng@amd.com>
Subject: [PATCH v2] drm/amdgpu: Fix the looply call svm_range_restore_pages
 issue
Date: Fri, 3 Jan 2025 10:26:15 +0800
Message-ID: <20250103022615.1399054-1-Emily.Deng@amd.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E63:EE_|MN2PR12MB4334:EE_
X-MS-Office365-Filtering-Correlation-Id: 249ec1c3-e772-4036-3e26-08dd2b9e02a8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WG1vbjRPa3J6ZFlmSTI5cEdmUmF4MmhqdlBaeklqVWVXbVlQdjZ6bDQ5Tkc0?=
 =?utf-8?B?aFRWMXFRV05qK2FKWmFMU3hKNkU1MHY1ZndVSG5LSFJ6S2FiOE1ZVzEwaUsv?=
 =?utf-8?B?ZitaeXpNMC9Id0lqb2xTZVRaOHM4UGxCem9xbnZBZFN0b3RGNVNjZnNrRndq?=
 =?utf-8?B?cU1ncWg1dEhqNzl6bW5xZnNRSXZONVVpRWFldGs0MXUrNzdRZUFwRWZERUFO?=
 =?utf-8?B?SjN5MGs3TldzQ21uS2lObkRoSm9OVzhwdlNhYjVTZ29ScTJjT1gra0hTZzBj?=
 =?utf-8?B?bUJmc0RiU3hYSWQybkFVV0kzdk96MTYwQTgyTFlrV21sMmF3R21rRFdtalAx?=
 =?utf-8?B?cUpvMmFTQ0xwU0dRUzBvQXZKVGJxQXBHNGdIRWpHV0c0WXlQYnh2UElkUjlv?=
 =?utf-8?B?Ylk2Zkt6L3MzdnNsekdZL3NWeG92dTJHWUhxS2lQQ0hwbC9aNG82a0JkL3Vn?=
 =?utf-8?B?VGdWOEdaN1dGM2xnaE9IVFV0VEZ3UGJwNHIvWkptL01GNTBYOFoxaGdJL212?=
 =?utf-8?B?TGJ2S2lSSXVzRk9LcVFXckR6UTV0bWtDWTI3a09IQzFzc2RwS25wM0M1aUZE?=
 =?utf-8?B?REtJdW5KR2NMTnRlbnc3RktaRWJ0L2FiV0JnZzY4bWpqeUN1NmhwT1FsbWtH?=
 =?utf-8?B?NFhJYStuU3FNQ3RhK3NZc3dJeWtQUWx6eUp1UVJVNit2cDEwL0k2Vml6Rktj?=
 =?utf-8?B?bEczTFIxWU1IT2lxNjNNZ1RTUVl2WUNOUGtvN0hPbDgyMmZHSEFCK29jcEJW?=
 =?utf-8?B?SFhmcDcrcWVHY1lhWHBXaENzemxxNUhEWVQ5SDBQQnVINVU3WjFta1I2R1la?=
 =?utf-8?B?TDVsUXVIMGdTZnRJRzludktseEpqSWVpdmMwUVhOT2RhVDc2NkdXclVwMGR1?=
 =?utf-8?B?djdpM3ZLb2hzWTdDdGZObXpnY1VLN0x0OU1WQkUzS2RNOUpMK2dqYUJQT3di?=
 =?utf-8?B?L2RRODBXNVZzQVc3RzY5ZzAxWmVDbTRheW8zdmpBNXJucGVvb0FVcUI5MDRt?=
 =?utf-8?B?TFhZZDREQUplWW44ME53TlJuMlcyWWg2dmRjakpxeEpyTWJ2Zk1iY2ZIVVJS?=
 =?utf-8?B?endVVFBNTENSQTJGeUU4Y2NrRjA1UnpFd0FOejhHTlhyT1RZV0c5dE8zeTlE?=
 =?utf-8?B?aDhER2R1TUpCWjI4czYzYjFZK3Q2dHNnelVSc0dLMHMxck5hUGF3NTNFRThZ?=
 =?utf-8?B?TEZrZzk2YkpGdWFlZVd4ZXhQSi9TZFJERnZ0TEZVeE1wcGorWFlXSmkxaXNY?=
 =?utf-8?B?K3FUS2hGajN6bDdNTmZJQmJRTDFFckpQcjZkL0QyQk1EaWt1U20zQUFsVzc4?=
 =?utf-8?B?aFA1YXZvT2hzdDFaL2JPUFdTOUVQN3RYcnpxS2JocUE4SXBkVXlqK2JvbGta?=
 =?utf-8?B?QWk0Z0RJZTdoVk8zdmJMV0hmRXE1K0h2ZCt6WWtBRUxQRkNIRzN5NHVkazRo?=
 =?utf-8?B?QnBFMFRVUlRDOUFMM2RTdGZ2QlNMeHRBTnJhN3JCTU9BYTh2MkZQcmhqMCtC?=
 =?utf-8?B?UzF3eFA1WG1yMTZJd3gwcHo3cFF6QndhNGYranJHWDdyQWFuZHdzQloya1Vs?=
 =?utf-8?B?dzR0dFJZZFJsSE9mRjNWTUxPNzVyczYvbm16eklSNDM3amFXd2hxVnRxRE5i?=
 =?utf-8?B?emd6T3oxODBKQk5aaFJtSFRWYlphbk04d3hMT2JKNFdSODIrOTdyRi9Oa01n?=
 =?utf-8?B?TkYvYjFNNnhGclAyREVHWXZDcWdKVmk3OGlGOUpsaVczVmlyNlJ1OVZnRVRX?=
 =?utf-8?B?QXR6WkN6SlgxNVZUa21YU3NQOHZ1ci9hQUhtZTkzdGU1c3NldUFOdUh4TFdZ?=
 =?utf-8?B?REk2SnZQRnEyT1RYeGdlZGtNa2pvTFdZNlphZmMvd1NRSVNNRHVVZmROOUVu?=
 =?utf-8?B?Rm5JWTAzN05SN0tKaXRqb3N3ODJKVUhtNHlBU3JJejMxVnJkU0IybGlCOU9B?=
 =?utf-8?B?cFpBaEhqNUwyNFpXNGJpWEk3dTZvbWNWOWpQb2JyQldHc2dCTjNNeDZrcnE3?=
 =?utf-8?B?cG5KM0h3VFFBPT0=?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jan 2025 02:26:20.5104 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 249ec1c3-e772-4036-3e26-08dd2b9e02a8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF00020E63.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4334
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

As the delayed free pt, the wanted freed bo has been reused which will cause
unexpected page fault, and then call svm_range_restore_pages.

Detail as below:
1.It wants to free the pt in follow code, but it is not freed immediately
and used “schedule_work(&vm->pt_free_work);”.

[   92.276838] Call Trace:
[   92.276841]  dump_stack+0x63/0xa0
[   92.276887]  amdgpu_vm_pt_free_list+0xfb/0x120 [amdgpu]
[   92.276932]  amdgpu_vm_update_range+0x69c/0x8e0 [amdgpu]
[   92.276990]  svm_range_unmap_from_gpus+0x112/0x310 [amdgpu]
[   92.277046]  svm_range_cpu_invalidate_pagetables+0x725/0x780 [amdgpu]
[   92.277050]  ? __alloc_pages_nodemask+0x19f/0x3e0
[   92.277051]  mn_itree_invalidate+0x72/0xc0
[   92.277052]  __mmu_notifier_invalidate_range_start+0x48/0x60
[   92.277054]  migrate_vma_collect+0xf6/0x100
[   92.277055]  migrate_vma_setup+0xcf/0x120
[   92.277109]  svm_migrate_ram_to_vram+0x256/0x6b0 [amdgpu]

2.Call svm_range_map_to_gpu->amdgpu_vm_update_range to update the page
table, at this time it will use the same entry bo which is the want free
bo in step1.

3.Then it executes the pt_free_work to free the bo. At this time, the GPU
access memory will cause page fault as pt bo has been freed. And then it will
call svm_range_restore_pages again.

How to fix?
Add a workqueue, and flush the workqueue each time before updating page table.

Signed-off-by: Emily Deng <Emily.Deng@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h              | 1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c | 1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c           | 7 +++++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c        | 6 +++++-
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c             | 3 +++
 5 files changed, 15 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index 93c352b08969..cbf68ad1c8d0 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -1188,6 +1188,7 @@ struct amdgpu_device {
 	struct mutex                    enforce_isolation_mutex;
 
 	struct amdgpu_init_level *init_lvl;
+	struct workqueue_struct *wq;
 };
 
 static inline uint32_t amdgpu_ip_version(const struct amdgpu_device *adev,
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
index f30548f4c3b3..5b4835bc81b3 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
@@ -2069,6 +2069,7 @@ int amdgpu_amdkfd_gpuvm_map_memory_to_gpu(
 		if (ret)
 			goto out;
 	}
+	flush_workqueue(adev->wq);
 
 	ret = reserve_bo_and_vm(mem, avm, &ctx);
 	if (unlikely(ret))
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index 9d6ffe38b48a..500d97cd9114 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -2607,7 +2607,7 @@ void amdgpu_vm_fini(struct amdgpu_device *adev, struct amdgpu_vm *vm)
 	amdgpu_amdkfd_gpuvm_destroy_cb(adev, vm);
 
 	flush_work(&vm->pt_free_work);
-
+	cancel_work_sync(&vm->pt_free_work);
 	root = amdgpu_bo_ref(vm->root.bo);
 	amdgpu_bo_reserve(root, true);
 	amdgpu_vm_put_task_info(vm->task_info);
@@ -2708,6 +2708,8 @@ void amdgpu_vm_manager_init(struct amdgpu_device *adev)
 #endif
 
 	xa_init_flags(&adev->vm_manager.pasids, XA_FLAGS_LOCK_IRQ);
+	adev->wq = alloc_workqueue("amdgpu_recycle",
+				   WQ_MEM_RECLAIM | WQ_HIGHPRI | WQ_UNBOUND, 16);
 }
 
 /**
@@ -2721,7 +2723,8 @@ void amdgpu_vm_manager_fini(struct amdgpu_device *adev)
 {
 	WARN_ON(!xa_empty(&adev->vm_manager.pasids));
 	xa_destroy(&adev->vm_manager.pasids);
-
+	flush_workqueue(adev->wq);
+	destroy_workqueue(adev->wq);
 	amdgpu_vmid_mgr_fini(adev);
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
index f78a0434a48f..1204406215ee 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
@@ -554,15 +554,19 @@ void amdgpu_vm_pt_free_work(struct work_struct *work)
 
 	vm = container_of(work, struct amdgpu_vm, pt_free_work);
 
+	printk("Emily:%s\n", __func__);
 	spin_lock(&vm->status_lock);
 	list_splice_init(&vm->pt_freed, &pt_freed);
 	spin_unlock(&vm->status_lock);
+	printk("Emily:%s 1\n", __func__);
 
 	/* flush_work in amdgpu_vm_fini ensure vm->root.bo is valid. */
 	amdgpu_bo_reserve(vm->root.bo, true);
+	printk("Emily:%s 2\n", __func__);
 
 	list_for_each_entry_safe(entry, next, &pt_freed, vm_status)
 		amdgpu_vm_pt_free(entry);
+	printk("Emily:%s 3\n", __func__);
 
 	amdgpu_bo_unreserve(vm->root.bo);
 }
@@ -589,7 +593,7 @@ void amdgpu_vm_pt_free_list(struct amdgpu_device *adev,
 		spin_lock(&vm->status_lock);
 		list_splice_init(&params->tlb_flush_waitlist, &vm->pt_freed);
 		spin_unlock(&vm->status_lock);
-		schedule_work(&vm->pt_free_work);
+		queue_work(adev->wq, &vm->pt_free_work);
 		return;
 	}
 
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
index 3e2911895c74..55edf96d5a95 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -1314,6 +1314,7 @@ svm_range_unmap_from_gpu(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 	uint64_t init_pte_value = 0;
 
 	pr_debug("[0x%llx 0x%llx]\n", start, last);
+	flush_workqueue(adev->wq);
 
 	return amdgpu_vm_update_range(adev, vm, false, true, true, false, NULL, start,
 				      last, init_pte_value, 0, 0, NULL, NULL,
@@ -1422,6 +1423,8 @@ svm_range_map_to_gpu(struct kfd_process_device *pdd, struct svm_range *prange,
 		 * different memory partition based on fpfn/lpfn, we should use
 		 * same vm_manager.vram_base_offset regardless memory partition.
 		 */
+		flush_workqueue(adev->wq);
+
 		r = amdgpu_vm_update_range(adev, vm, false, false, flush_tlb, true,
 					   NULL, last_start, prange->start + i,
 					   pte_flags,
-- 
2.34.1

