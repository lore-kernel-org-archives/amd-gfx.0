Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B971E77188
	for <amd-gfx@archiver.kernel.org>; Mon, 30 Dec 2024 06:09:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DBE5010E102;
	Mon, 30 Dec 2024 06:09:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="caLtsGqc";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2086.outbound.protection.outlook.com [40.107.92.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 46E6710E102
 for <amd-gfx@lists.freedesktop.org>; Mon, 30 Dec 2024 06:09:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yzTC9I+435PcJ0vAxcNTFMYFjejZolmnj+aNitjtlIQfuLTWPt6nfXHy87zYyWgZHC4cbdkKyxtdNITIX0bllxyMSGLYhbtCCF13ITjCMFLgA8vTMen4wjnAuMOi4tRSw9CghP7np7N1bajm3Xd50sXXpN4PHxO9gBoPWu5ogOolNtDN32H4QGZXyEwQy6JezhSJpFHCCOIWg1FGwZczC1hYLq4AyO0sCAiSum2l8j+d3+zfvA1gngrxtGaw/qRpz0gO9VOrKHkk0+W/sxADLuasnAA+xHEjxe42e6GS9kHBVjvxqQHPYSbtysVs+f9HeiziImX0UV/XdOk/qaIUHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3D95zRxIazPs17sZ6wbnKSUmQOfwjjhJS6oSZjRAGiI=;
 b=i5AFsd/ak3Ol4dBoDNQIO/FyDOXeOE9jX+n2MpThcVWEBWtqwS1Q0+TPhOtOXHGsQq80OsUl+l0snlVYvNx7X4rM4wHGzV5sh5XPVC2NSLdNa3Szxoq7sswtpuUoNjnEu7cKrDJcy1ZQTUG2te53KKhqPKI1D+krDya6mUQDeWSW282nYB24h4ynKtkQt2Iz0UxlVGSH1hpO4uEHYoLbdbYH7SIPHUQAOJAKzYgSX3gvBdIk0rG8BVWl4tziAXVLsZgBwCeU1/2v0biu98uLjC9bONIPaqsyj6NznbB4X9k3AgAfiapRJ1BYoSPqi1gczcAqR5Pcrjm9jJNo9zfqPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3D95zRxIazPs17sZ6wbnKSUmQOfwjjhJS6oSZjRAGiI=;
 b=caLtsGqcYiY3mIoxov1xZxr6oWLSOwStoSFN2Wu+B+7mSZJi0ZaaopnxSOhHsElUfRp0JcS1ZFid3d4dDvrJh5Ajed3eCFDstkyrl0/9nMjaOXqoy6g6pzzB67FaVPoyZPm5XZyp5V+m7TdJNv6e1qdWH6aruDfuK5I6y/eQTQE=
Received: from BN6PR17CA0058.namprd17.prod.outlook.com (2603:10b6:405:75::47)
 by CH0PR12MB8531.namprd12.prod.outlook.com (2603:10b6:610:181::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8293.19; Mon, 30 Dec
 2024 06:09:31 +0000
Received: from MN1PEPF0000F0E1.namprd04.prod.outlook.com
 (2603:10b6:405:75:cafe::87) by BN6PR17CA0058.outlook.office365.com
 (2603:10b6:405:75::47) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8293.19 via Frontend Transport; Mon,
 30 Dec 2024 06:09:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MN1PEPF0000F0E1.mail.protection.outlook.com (10.167.242.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8293.12 via Frontend Transport; Mon, 30 Dec 2024 06:09:31 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 30 Dec
 2024 00:09:31 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 30 Dec
 2024 00:09:10 -0600
Received: from emily-Z10PA-U8-Series.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Mon, 30 Dec 2024 00:09:10 -0600
From: Emily Deng <Emily.Deng@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Emily Deng <Emily.Deng@amd.com>
Subject: [PATCH] drm/amdgpu: Fix the looply call svm_range_restore_pages issue
Date: Mon, 30 Dec 2024 14:09:07 +0800
Message-ID: <20241230060907.1386294-1-Emily.Deng@amd.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Received-SPF: None (SATLEXMB05.amd.com: Emily.Deng@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0E1:EE_|CH0PR12MB8531:EE_
X-MS-Office365-Filtering-Correlation-Id: 770fe740-03b6-46bf-63c5-08dd289886a7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VzZOb2xwR0dQZmdOL2Z1MERCRHI4VXdsc1ZDRWVnMWYvUlJla24waysxK1R4?=
 =?utf-8?B?dGpUTVR0WTd3NTI2NXJHbVc3Y1QrbGZreTNBSXFVRHRpcXlMVDIxaUlmRzMr?=
 =?utf-8?B?ZGVsQmI5bmgwa0pjSmliSU1TNTRoaTlCNVpVbVloOFZtK0R1S2dxbTRBRERt?=
 =?utf-8?B?M2hBNURxTXZFUmVMRVBKQjM1RVZTekZLRGFsZGIvUEJaMTh2SjNDVGw0S002?=
 =?utf-8?B?Q1VkWStFT0JCbFNWbitpWFlOSXJMZUxSZ2pwY2ozT1Y0a2F4aWZFK3hKVHNO?=
 =?utf-8?B?NEFVUlJuV3dMYWpVSllFeGFMRHdwbzBiNzdMaGgxT1FRcERpUFlaVkZzRnc1?=
 =?utf-8?B?Zmk1VmwzaEQ4YlJxVGhaVXIrVWRJYVErOFFWSzgwVWpRVXZHaGVZd3o1eVdq?=
 =?utf-8?B?MkJQZllsRmlCOUpwaEt4T3l3aXR0a3NRTERtYmxOTEFNdnlJRGtnNXl0Y1gw?=
 =?utf-8?B?VEdSNjFwMWh1WjFnSEJnRGhjNnZwRmE0OURaYm1Yb01jUVQrRHJndjBteFJw?=
 =?utf-8?B?VFp0SENrRWtKZjlkNjUrclZ4djhrUkxQNVp5emduRUhobGQxOFJ6ZFZ0M2ky?=
 =?utf-8?B?TGlOczdRZmF1NzJWaS9SY0JST2R5bi9TWThPMkJ6c2lFQnpMZHZsQnZCWlJE?=
 =?utf-8?B?VXBaeU0rZGptRUdQNUtXQ3FLKzA4aXRLRUpnSmRkYkxrazlsRkVURjd5MnRI?=
 =?utf-8?B?QkV1NWxsVHcwY25PZEZ6Sitma0lBUEFjcDdPWDIrQkYyVWgyYlRLeXJaTmZ1?=
 =?utf-8?B?eUYwSC9tNUNNTnRvRUNQMDZMR1pWQnRIajJLYitHNk1hbUZuaG0vK3RNRGph?=
 =?utf-8?B?NWYyZmdVY2pYZU43VSsvY0ptdmtmbzd5dVJCbDJzaWc3UnZPQ1ppeTdybHlQ?=
 =?utf-8?B?Z2JPUXgyRUJETFJuVkxocU02UzAreFdlS2FYQ282NDhKWWZFaHV0YWt4ZklS?=
 =?utf-8?B?V2ZEQzhtdnJnZTFQWEl3ejcvc1Q1SnFqeVJPVlZQN2NhTkc1cXVFdWhUQm9R?=
 =?utf-8?B?Z1diMnlXTW1McVRaUUhOazl5eEhNS3NVSTJhQTdsNHdFMjM3ZXQ2Yld2VlRE?=
 =?utf-8?B?c2twcUhOL2l5ODBqdE9sWEhiSUxtUkdGenB4MGthUENFN1ladVpTYng1OW00?=
 =?utf-8?B?dHVscUpENlNZSlh2UnlMWFRYZ3VYUXhES3djczI1ZzF2ZzdDY3QzUUNOM3d2?=
 =?utf-8?B?dmVDY09IYjBJYjJKMllZc3VQdS9oRU01WThtMmxXRUkyU2hKRFpTclpZNDFQ?=
 =?utf-8?B?TEtCVVZtUUt4Z2pLaldJSWYzUUZhdDVZQ1I1a1poaWpoZkJBdW5vaTE1T2xP?=
 =?utf-8?B?SFJraDVidElTOG8vcStjZVF3citWNmlqd1B2UTlZdHdDUG4rVm9jQTlGQ3RT?=
 =?utf-8?B?UGVoTWY4MFIwZmV0NmJHejBMakxtU3RzQ3F5a1FpMmtlcVQyeExNbzZBSHRS?=
 =?utf-8?B?akUzM0hMbXpHRVgxUnZiRTRJN0xGVFhBRGM4MlJpdDB2Qkx4ajI0dEtLZ21I?=
 =?utf-8?B?S3BRZzlWUlJoSzdzY0JWOEJvMFZYRnM3dnBzeWxPS01mVXp4TXdxVTVCNmRn?=
 =?utf-8?B?akRCMzdHZk83Q1diY29NRVJnT2QvZWNNOVRuVG5UeXc0SzlmMWJ4cVpqWXd5?=
 =?utf-8?B?eWdFaEtrUUIwanh0aW40UFJKdGhuQk02L1VRU3BzQUZieFA2cHpSSkhRNy84?=
 =?utf-8?B?blgvNDNMN1pWNldRUWFMK3Y0dG1md3A4Ymk0QWFRZDFDVHd2NEx0MEdjNk5N?=
 =?utf-8?B?cTZpU09zRHFPKzNVSjVFS3JxUjUrKzE5YkNZcUVhalNPOXl2bEFxVVEwcUdS?=
 =?utf-8?B?cmdKUUpFVHV3S2FFV3JaUDV6Zkh5d1llcFBMbVRYZVVWRlFHL0Z5K09DeklH?=
 =?utf-8?B?QnExQUNJdXl5Y2hlQVdRL0xZelRaNWpHN3ZCTmd1Nk5NYXpqK1UyN3J3NHgy?=
 =?utf-8?B?MkVDeGo4VzF6alRRWHdzblFxQlpsM0M0RVNIc0d4ZjhjNGFPT1F5aTFMdFBM?=
 =?utf-8?Q?usvro6sHpnFBPtLN4WuclEEYyhiPoA=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Dec 2024 06:09:31.4954 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 770fe740-03b6-46bf-63c5-08dd289886a7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000F0E1.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB8531
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
 drivers/gpu/drm/amd/amdgpu/amdgpu.h       | 1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c    | 8 ++++++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c | 2 +-
 3 files changed, 8 insertions(+), 3 deletions(-)

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
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index 9d6ffe38b48a..4718074613fe 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -982,6 +982,7 @@ int amdgpu_vm_update_range(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 	 */
 	flush_tlb |= amdgpu_ip_version(adev, GC_HWIP, 0) < IP_VERSION(9, 0, 0);
 
+	flush_workqueue(adev->wq);
 	memset(&params, 0, sizeof(params));
 	params.adev = adev;
 	params.vm = vm;
@@ -2607,7 +2608,7 @@ void amdgpu_vm_fini(struct amdgpu_device *adev, struct amdgpu_vm *vm)
 	amdgpu_amdkfd_gpuvm_destroy_cb(adev, vm);
 
 	flush_work(&vm->pt_free_work);
-
+	cancel_work_sync(&vm->pt_free_work);
 	root = amdgpu_bo_ref(vm->root.bo);
 	amdgpu_bo_reserve(root, true);
 	amdgpu_vm_put_task_info(vm->task_info);
@@ -2708,6 +2709,8 @@ void amdgpu_vm_manager_init(struct amdgpu_device *adev)
 #endif
 
 	xa_init_flags(&adev->vm_manager.pasids, XA_FLAGS_LOCK_IRQ);
+	adev->wq = alloc_workqueue("amdgpu_recycle",
+				   WQ_MEM_RECLAIM | WQ_HIGHPRI | WQ_UNBOUND, 16);
 }
 
 /**
@@ -2721,7 +2724,8 @@ void amdgpu_vm_manager_fini(struct amdgpu_device *adev)
 {
 	WARN_ON(!xa_empty(&adev->vm_manager.pasids));
 	xa_destroy(&adev->vm_manager.pasids);
-
+	flush_workqueue(adev->wq);
+	destroy_workqueue(adev->wq);
 	amdgpu_vmid_mgr_fini(adev);
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
index f78a0434a48f..7543c428873b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
@@ -589,7 +589,7 @@ void amdgpu_vm_pt_free_list(struct amdgpu_device *adev,
 		spin_lock(&vm->status_lock);
 		list_splice_init(&params->tlb_flush_waitlist, &vm->pt_freed);
 		spin_unlock(&vm->status_lock);
-		schedule_work(&vm->pt_free_work);
+		queue_work(adev->wq, &vm->pt_free_work);
 		return;
 	}
 
-- 
2.34.1

