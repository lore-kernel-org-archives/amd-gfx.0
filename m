Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0696E77197
	for <amd-gfx@archiver.kernel.org>; Fri,  3 Jan 2025 00:21:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8E60310E262;
	Fri,  3 Jan 2025 00:21:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Yz2C95Oc";
	dkim-atps=neutral
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2071.outbound.protection.outlook.com [40.107.102.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 838D510E142
 for <amd-gfx@lists.freedesktop.org>; Fri,  3 Jan 2025 00:21:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=idYhxzsEmzyw9SEn2uU6iaPb6DUfp9l6NhZVkophrI3xfgvAwyGOZcE/j7/bjm0VcmFSOMzEw/jvQIucIVIPXFwGz5WeCe3YhcQ3o1lw2Pstep3x0QsHwBlG9hImH4leqStXlTKhBgK1L3n9T/pl8DIRvssUCfK2gKIHvWCyvHhlT2iklRuevfwn7FPdUknIiIGB5LQ4jc8AMCIy4ZkVLHD2FyXg49Vk/kGnTyu9pzKVm8F5KCVnZSVvimWnP6yJ5wcXrGDibGRnkEBnhHVIksIUb2ysEVu3DrKC1K8b6/O91VA9v94KE6elWJYYttCdV6G2SwLV/I5I1qrdti14rA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Bck3G060yD7rf891YKKj1A6zMnLrHSDvhTN1ILxatOc=;
 b=iGnO8VWIF1H3VwOHcZegr7rzUtg/VAGOEUUWULrXS9RzAZ/GRbKO491JlW8FdoBuft7zHbe/Sg+C5B4CXqvofTbm66WaQjbuVebuWVMISz7wQlqTZ/Mp0sZsmNt6TxZePdMAXj8amKttA569E+aHB7lgqRahPwIggcKKXe5CPZsYOb9Hjm7Q5RCth9qLgPBjNKIwwlBVqkGxbOa5EHZqan0wCNR2+WFOQUFhTVBXfr19piVcO8AhXziiLUqcEnwlhcvQxvH5yMTJXGaky2QTrLRY/E0tirrLIsDrEz/mTGjPmaC98b5IeHJ0XBO1nX3qeqgYHy9JwJbz6hw36oCiQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Bck3G060yD7rf891YKKj1A6zMnLrHSDvhTN1ILxatOc=;
 b=Yz2C95OctRrNCoNdCkc1iFjh6uKrWAjkJ+a+nEquXsM2+p5K6912o20qR1ui+BJlQW8kpYOIvXrvrFgPA+JdN1PBwJRqUQWxj29cbBjLOYaZNBBhSF6cKcOQbZY+tu/nv2AJR3QFY1npwy4j8mjHw7NFi0VAm7LFm28/HfWJX9Y=
Received: from MN0P223CA0018.NAMP223.PROD.OUTLOOK.COM (2603:10b6:208:52b::35)
 by IA1PR12MB6138.namprd12.prod.outlook.com (2603:10b6:208:3ea::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8293.18; Fri, 3 Jan
 2025 00:06:28 +0000
Received: from BL02EPF00029927.namprd02.prod.outlook.com
 (2603:10b6:208:52b:cafe::bd) by MN0P223CA0018.outlook.office365.com
 (2603:10b6:208:52b::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8314.13 via Frontend Transport; Fri,
 3 Jan 2025 00:06:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BL02EPF00029927.mail.protection.outlook.com (10.167.249.52) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8314.11 via Frontend Transport; Fri, 3 Jan 2025 00:06:28 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 2 Jan
 2025 18:06:28 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 2 Jan
 2025 18:06:27 -0600
Received: from emily-Z10PA-U8-Series.amd.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Thu, 2 Jan 2025 18:06:27 -0600
From: Emily Deng <Emily.Deng@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Emily Deng <Emily.Deng@amd.com>
Subject: [PATCH 1/2] drm/amdgpu: Fix the looply call svm_range_restore_pages
 issue
Date: Fri, 3 Jan 2025 08:06:19 +0800
Message-ID: <20250103000619.1398626-1-Emily.Deng@amd.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF00029927:EE_|IA1PR12MB6138:EE_
X-MS-Office365-Filtering-Correlation-Id: a7476962-fcd1-47d1-8ed4-08dd2b8a78b3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ak9MVk5iMnNxOHYxOVorT1hHU1NDUWJVNDBXUnQrN0FvOXhaYlFycHpnKzF4?=
 =?utf-8?B?N2ZVQ3lERmdUSjlnb3ZRNEk2cXRscjJOQmRYWTUvOFRGMUg1UlBwWlg4Yitw?=
 =?utf-8?B?MXA4R0dPQkZhMGUweUt1ZzM1cXBCQkVoNEhtZ2JGQm1IV3pqLzlvc3N0eWla?=
 =?utf-8?B?a24wZG5LakJmMDk2WFZERHdlbVhZSDVqNHN1c2hiRFExcGxURHVZQjNqVjZr?=
 =?utf-8?B?YnB2Vk56bnBTQjJqVHJQcTNDcVBlcmk3ZGV5cHMrRGF6NFBnM2JyU3lhSzF0?=
 =?utf-8?B?Zm1rT3VUVy9XMmYvNHJ1amh1T0xKcVRsUDJxd0ZLcnhVaXJQcXJ3Y2xVNUJG?=
 =?utf-8?B?cFFzTE9pejByaGpjTFRTb09iM29hRVFPa3Qxa2k1QkFxV29IbHlkT1Y1OTdM?=
 =?utf-8?B?cFdqVjNmKzJDWHNPK2xPcnZnRzVJaitOMEZIaTNhNDViT29FZXdLeE1ubGNj?=
 =?utf-8?B?eXg5d0kwM3NnRm1sRnJxNHpHV1JkcXBGL2EzRC9RVEsvU3hab3NFYkdpNTdn?=
 =?utf-8?B?bU4wUXBmQ2M4dGNvNGU4VVhpRU01N2kvc01TSUZyUHJmT2FCZlFoSjgvMVds?=
 =?utf-8?B?c2lldjBpcU1nVlVuQTYrbUV1Z2FDbGt0YjdML3hrajcyRUlsclpkSlQ5RGhl?=
 =?utf-8?B?dThwRStZRE9OSGw3Zk9HYXc1dERrVTdTeVI0WVFkdTB5bnRrL0p4dTEvRnht?=
 =?utf-8?B?T3BtWE1pbVdpYVVkSTgwV0ZhamwyNDJEWktWaklLTEEvaUdjUnhlRHpyR3dV?=
 =?utf-8?B?emgycDk1Z3ljcDNENldiaDJkVVA4QjVnbzZFSFJCa081MUNIUE0wYVh1Y3Z4?=
 =?utf-8?B?eHJja2RGeDBETEJkcmZ0eExFYUdNVWdkeS9wUXl2amgrRXBsak9xN2NaSzQ5?=
 =?utf-8?B?Z2doWGUzSE8yOGhDaVArU2ZvbU8zTmkrSWpsdTI5L2MreGMyVWpjYjF1WmVC?=
 =?utf-8?B?QnJNcU9RRWhmK1RQNjliRm5qcUdTZUhXdGhlWkZnaU5IdUNLV0hLSG90TE1W?=
 =?utf-8?B?VlphRXJ2ZXhpRnpSa1NVc0txZEgwRmxkYVBMWEJQbm4zTG9JZmRtc1hWOU4w?=
 =?utf-8?B?KzlpNm1yK3pNNnRWR0xmcnBnVnNWaDRieFZTWXBxazJmNTliVU9yUVE1VjF1?=
 =?utf-8?B?Mm1TQ3BKY1pEbjk4cnRWWGtYY2tLeEo0RW80T29sQ2tNMHR1UmtPaFkwcjRS?=
 =?utf-8?B?QXJzeEI4OXI0TnN0TTlKSE1GQkczYlIrb3k0bDhMbnBVRktBcXBNcUZJSk5a?=
 =?utf-8?B?UXFCVTFWenAvei9sSWVNRXpQcHhWOXRwdXNwbEF6ZTRsV2puRUQ3MGswMFN5?=
 =?utf-8?B?ajFwZ0dNWmxQY0FRejJydEdUWnBHejcxUXdmVWNJd0FUZ2hKdGE3Q3RiMHRt?=
 =?utf-8?B?ODRzQkZOOEdONktJeTkvLy8zWE5zWnJYZUhuM2dXelovQUVrYmsveUNRQkNH?=
 =?utf-8?B?bThUdTNXbG8wMVppOUlDaU5ZZlR3ckt1a0hIVjdqZERCTEN4VExMOEFTNEpB?=
 =?utf-8?B?cGJ2S1U3ZURVU21KaGlLMFc0YzF3eXAzQk5aMGVRbDVGUmRhWEN3OHdpM3NH?=
 =?utf-8?B?b0RXMVBKUmxNMGZhb2VNbGl4WGRMUXlIejVkZ0lFTWx3NGF2TTBKaEZHZXcw?=
 =?utf-8?B?LzNjYWQzMnZXOUdEK1c5RnlQZHI3MWJ4cmI3THRPRDZyWFhmQ3Jad28ySFpm?=
 =?utf-8?B?TkcyVG9UbjlLZ0kzYmRCYWVDaS9XdzJFZjZTczJsUUU0R3NHTW5YaExBSWNi?=
 =?utf-8?B?UEFQMVVMUGtHVG40S3ROdFZRbG1sZXJmUG1yYWtibzhxd3ljZVovSTRIOGli?=
 =?utf-8?B?bHZibkUzN0R1aUlBbUNUaEVtai9PSlQxS09CTkxTdHFaVVFDcDZTR2JHbm1Y?=
 =?utf-8?B?SW8yT2hDLzE3eEpqRkxubEZzQTNKZEZPanpLMkUrMDhmVkY1WEc5ZHZuZ3hK?=
 =?utf-8?B?U2VyWDBXSW5sY3FvTWpIOW0rRlY5SlVKcG1qVlpuVFFtWnJKYXpaNGlrVnhH?=
 =?utf-8?Q?bjq0Ed/kCs11fW51KTXKBOvxISAksk=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jan 2025 00:06:28.6055 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a7476962-fcd1-47d1-8ed4-08dd2b8a78b3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF00029927.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6138
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
index 5e55a44f9eef..cfb2916f937d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -1209,6 +1209,7 @@ struct amdgpu_device {
 	struct mutex                    enforce_isolation_mutex;
 
 	struct amdgpu_init_level *init_lvl;
+	struct workqueue_struct *wq;
 };
 
 static inline uint32_t amdgpu_ip_version(const struct amdgpu_device *adev,
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index c9c48b782ec1..b35a7d83a0a4 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -983,6 +983,7 @@ int amdgpu_vm_update_range(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 	 */
 	flush_tlb |= amdgpu_ip_version(adev, GC_HWIP, 0) < IP_VERSION(9, 0, 0);
 
+	flush_workqueue(adev->wq);
 	memset(&params, 0, sizeof(params));
 	params.adev = adev;
 	params.vm = vm;
@@ -2614,7 +2615,7 @@ void amdgpu_vm_fini(struct amdgpu_device *adev, struct amdgpu_vm *vm)
 	amdgpu_amdkfd_gpuvm_destroy_cb(adev, vm);
 
 	flush_work(&vm->pt_free_work);
-
+	cancel_work_sync(&vm->pt_free_work);
 	root = amdgpu_bo_ref(vm->root.bo);
 	amdgpu_bo_reserve(root, true);
 	amdgpu_vm_put_task_info(vm->task_info);
@@ -2716,6 +2717,8 @@ void amdgpu_vm_manager_init(struct amdgpu_device *adev)
 #endif
 
 	xa_init_flags(&adev->vm_manager.pasids, XA_FLAGS_LOCK_IRQ);
+	adev->wq = alloc_workqueue("amdgpu_recycle",
+				   WQ_MEM_RECLAIM | WQ_HIGHPRI | WQ_UNBOUND, 16);
 }
 
 /**
@@ -2729,7 +2732,8 @@ void amdgpu_vm_manager_fini(struct amdgpu_device *adev)
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
2.36.1

