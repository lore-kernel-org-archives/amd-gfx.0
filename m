Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DAA3E77199
	for <amd-gfx@archiver.kernel.org>; Thu,  9 Jan 2025 12:16:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E515B10ED90;
	Thu,  9 Jan 2025 12:16:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ev4okY5H";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2086.outbound.protection.outlook.com [40.107.244.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 94B6D10ED9F
 for <amd-gfx@lists.freedesktop.org>; Thu,  9 Jan 2025 12:16:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=u2wBc6Z9dEW7llkI2dFv20zuhFIE9MPo07vpRXkOj4dG5J5h94+zETc1+BDTBTbhNvrzagus6TxAGmQ4W5umCX7bCbYZ8Xv+ENlRIy6mBkOSrwHinZgmTv1yBJJo18uoa+inWV47eFo5tmaPKs5rhBveEKNTr3NwQeBnat40BvgF7kt0hr+MM19+CkcSPH7z4hyndex+J/zpmJt1H6Q9u7Z31pkYMjw3twzMCxm2A7OTEBMjo/dlfbkY56nT/moJyZanBq85az5pxQbnL4j8GuWFUjAE1gARwwar9n64nok+uJyA7kxuEIYzslNKLdhtdodEhkzWOABugDvY4eDPkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=90uTuVTWdePwXp1yZJ0ZKiB7Of93OUHmkxkx2c1SMg8=;
 b=UAjBm7vh6te00BCh8NzfDvWcxAPAJEPGXzHg4HQz4gg8LrsNumsXtxAPE3pGPvtXz6/bfRt9e8rHZd82VCeeEJL2BJWjRWC/PhXAOMPGQlwnTMOZPLst13UC8wY1FcG4QPxVtBEh+DS7vz/5DO818d3WRJqqgvSo9nDZLC3i8/1AIUqds5jo4uxbqB2aXJX85bYp/Cfw8wy6oV5Dry4I9C/3OfESs8AEYQmgg1r02dP/acTdBVJ+9f72jhhdDAEIb83rfZY6fJrDh8P+BWiU+D7Wf1eSmKyUCUPimkT3T2PybFokAJ/UaeB9vm5KUIsft/ntrIilpy595MpWdwDR8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=90uTuVTWdePwXp1yZJ0ZKiB7Of93OUHmkxkx2c1SMg8=;
 b=ev4okY5HXPhFBfoGghVVODxFUlKh1WemDND8GVqLDzxz56XKTHlSOQFs3F9VHW2sj+7NxkmmmIpUxd49m2hEbLnA2S0+QEBdrZd2eMpFKoGELbDvHby/ATvAK1QlUfjUcNQUJ4ft3BhRreOJvWEvrirbt75l23WWR8Fo42ylG0M=
Received: from PH7P220CA0162.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:33b::31)
 by CYYPR12MB8732.namprd12.prod.outlook.com (2603:10b6:930:c8::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.11; Thu, 9 Jan
 2025 12:16:14 +0000
Received: from SN1PEPF000397B5.namprd05.prod.outlook.com
 (2603:10b6:510:33b:cafe::eb) by PH7P220CA0162.outlook.office365.com
 (2603:10b6:510:33b::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8335.11 via Frontend Transport; Thu,
 9 Jan 2025 12:16:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SN1PEPF000397B5.mail.protection.outlook.com (10.167.248.59) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8335.7 via Frontend Transport; Thu, 9 Jan 2025 12:16:13 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 9 Jan
 2025 06:16:13 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 9 Jan
 2025 06:16:12 -0600
Received: from emily-Z10PA-U8-Series.amd.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Thu, 9 Jan 2025 06:16:12 -0600
From: Emily Deng <Emily.Deng@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Emily Deng <Emily.Deng@amd.com>
Subject: [PATCH v4] drm/amdgpu: Fix the looply call svm_range_restore_pages
Date: Thu, 9 Jan 2025 20:16:10 +0800
Message-ID: <20250109121610.1438511-1-Emily.Deng@amd.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000397B5:EE_|CYYPR12MB8732:EE_
X-MS-Office365-Filtering-Correlation-Id: 268ff98e-5bc4-4560-2bc7-08dd30a76928
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?tTAOwx8LPpJb1zDbVL/gguoaY69fNGvNWCuXr1fgfL5ovfWlArI0AyOJkZmy?=
 =?us-ascii?Q?HwuNJgUEBwo8XlGzKWBcoDLoGemXbh+8TSlm0XAaDnimrRHwz++BmadLBfWC?=
 =?us-ascii?Q?Bi68jICGUZUS5nhsGja9o+pbx30hI8H04NPsmHtqyvjnKFk6v6S/CZCTcVvN?=
 =?us-ascii?Q?V0z2aBlpr43zIXQjjT7wVqbLF/5FR9/mlKswdw3q36cvn9zn4h5H/Mg846Js?=
 =?us-ascii?Q?fgO3JbjkAFDIhzRVdPhgtwlwUpKpB28HSCTmQDHrYyhFcNwihUb0G07C7gzv?=
 =?us-ascii?Q?2S5eKxQkpl3ZQM7pF6sx/5G8DdJ8A9R0HTF7tKjW8dPqbh0YdELBX2HjIIxb?=
 =?us-ascii?Q?c7/onI9Izc1RCkm18VVNYDc009Rmhn8h56HbCP0nNIq4hk2t1ANtNZt/ks0N?=
 =?us-ascii?Q?NzUsZUFwPaECKpUZ2LA9Z3bDyft3O5RuaMQrM9WgzWdlNuBKZiQGdaHQ0WaR?=
 =?us-ascii?Q?LbFv777UX3Ylc+NYa4zts9vOR/i5/RyZ3XmW/cAI0TvdiHxiXhdmLt24XrJq?=
 =?us-ascii?Q?5Q6uahUbJOOoQ25g+eUSPaDG3EDEIAWfnANEIvUONtyKM8YPALIJIvXvkh5h?=
 =?us-ascii?Q?Nrn670GNcI1PPtsmIcGe15YrF6fyIgdKYd16pnxENcTdLMIG+LzecsfqgqUX?=
 =?us-ascii?Q?lEnXJhBu1JjV08dPKerPnnwo3s0QQ0sVjZlMNIWRuKb9rOyFa66t3i3aNLDf?=
 =?us-ascii?Q?eFtPyxnIo/xA5hYtxneJQk4mbt535hdjwmnGYK353xDpvrT5ZXtg0dBkxS67?=
 =?us-ascii?Q?9yAwsdD8dMN2ER/7nwR5sNMH4BNXaaIcFOk8JVfytXJ8JjuYLgGYcgujiZbs?=
 =?us-ascii?Q?S//p9qnpPs2tgQAm06bZ9EUD3h57f6Ivhxqocx3/BWuxWlWVsWXVEa7oKhFv?=
 =?us-ascii?Q?TEOdITBGao30YvmxX01XofT90IDm5dDGQD04nBIYcjE2GmA+INrILQqBoKhT?=
 =?us-ascii?Q?xnqnpPs5Pmk1GB4aZHwhlQ4UziUk3FV3XeYtlgaD/Yf4MYDCpOscXddghn0m?=
 =?us-ascii?Q?ZLrpmYSE6cOkSw1jYFwGcIPTMLiYkkb2HsY2kSc9LRptwC3sS343AlaO1jzP?=
 =?us-ascii?Q?sdRqcjB+473EtJ+/HYmxmhi+aUh9ANFebFDCWPKYBf0ydHHJ5Sfay5oDbBc/?=
 =?us-ascii?Q?ycfGDGeEZpOJq1Oqh7GE+2pXUu2SsMkBzHnfOuptitZtTtwpnNDwctkrkmFp?=
 =?us-ascii?Q?iN0SvEP02cxjz7l6tUtrsOeorGiz5ILN67cKmQXAYQ1UMpiPjfPxOEdzbtG2?=
 =?us-ascii?Q?W5D78GX2byC5ZpDzabRRUaWthG5orYi0BmTk1+dzGRVWN37uqmEMy8Hz0ovU?=
 =?us-ascii?Q?cQih524EMk1+0C9Vw8ng89Ct8d7Iy0eSWZ7V3DIHQcoU4/Z5Qm0R1HJAU1+3?=
 =?us-ascii?Q?5956JPgqCEPHsshD4PSn87gjI70pzn3L1B+dvnR9nRJzi2PAw++liLnWNYg3?=
 =?us-ascii?Q?meZwC6nMDKJKGHeRHsFMuKhzaWhauliHoyA7QTu6IxurSO70fG/a9BjCGZA8?=
 =?us-ascii?Q?asKI250QffWcO7A=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jan 2025 12:16:13.7609 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 268ff98e-5bc4-4560-2bc7-08dd30a76928
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF000397B5.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8732
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

As the delayed free pt, the wanted freed bo has been reused, which will cause
unexpected page fault, and then call svm_range_restore_pages.

Detail as below:
1.It wants to free the pt in follow code, but it is not freed immediately
and used schedule_work(&vm->pt_free_work);

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
Duplicate the free bo list.

Signed-off-by: Emily Deng <Emily.Deng@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c | 21 ++++++++++++++++++---
 1 file changed, 18 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
index f78a0434a48f..6c0de0c93594 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
@@ -561,8 +561,10 @@ void amdgpu_vm_pt_free_work(struct work_struct *work)
 	/* flush_work in amdgpu_vm_fini ensure vm->root.bo is valid. */
 	amdgpu_bo_reserve(vm->root.bo, true);
 
-	list_for_each_entry_safe(entry, next, &pt_freed, vm_status)
+	list_for_each_entry_safe(entry, next, &pt_freed, vm_status) {
 		amdgpu_vm_pt_free(entry);
+		kfree(entry);
+	}
 
 	amdgpu_bo_unreserve(vm->root.bo);
 }
@@ -578,7 +580,7 @@ void amdgpu_vm_pt_free_work(struct work_struct *work)
 void amdgpu_vm_pt_free_list(struct amdgpu_device *adev,
 			    struct amdgpu_vm_update_params *params)
 {
-	struct amdgpu_vm_bo_base *entry, *next;
+	struct amdgpu_vm_bo_base *entry, *next, *new_entry;
 	struct amdgpu_vm *vm = params->vm;
 	bool unlocked = params->unlocked;
 
@@ -587,7 +589,20 @@ void amdgpu_vm_pt_free_list(struct amdgpu_device *adev,
 
 	if (unlocked) {
 		spin_lock(&vm->status_lock);
-		list_splice_init(&params->tlb_flush_waitlist, &vm->pt_freed);
+		list_for_each_entry_safe(entry, next, &params->tlb_flush_waitlist, vm_status) {
+			new_entry = kmalloc(sizeof(*new_entry), GFP_ATOMIC);
+			if (!new_entry) {
+				spin_unlock(&vm->status_lock);
+				return;
+			}
+			*new_entry = *entry;
+			INIT_LIST_HEAD(&new_entry->vm_status);
+			list_add_tail(&new_entry->vm_status, &vm->pt_freed);
+			if (entry->bo) {
+				entry->bo = NULL;
+				list_del(&entry->vm_status);
+			}
+		}
 		spin_unlock(&vm->status_lock);
 		schedule_work(&vm->pt_free_work);
 		return;
-- 
2.34.1

