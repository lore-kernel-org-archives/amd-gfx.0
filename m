Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24C31E77197
	for <amd-gfx@archiver.kernel.org>; Thu,  9 Jan 2025 06:23:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8709210E0BB;
	Thu,  9 Jan 2025 06:23:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="lSUgkoSC";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2089.outbound.protection.outlook.com [40.107.94.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8FF2110E0BB
 for <amd-gfx@lists.freedesktop.org>; Thu,  9 Jan 2025 06:23:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YUBkc1cJGZXT9pGIwAEA7kA65UVL7/CRA34buok0g6CfJhUkFYouXP66xVcugMiHdBqXaDdcTq8ksM7Xa9ea7l0hz3VzaM4S9wV+axQfQprE9/NwWhaV1Sc1cIRGyCYVMTDYfZ2KV4+n+uSe1DRIwe6WBHkOJROVSzpoUwbOaF00XFsXQK2CRdB2G55FA4P5Ogu5zDVy9jW25Y4X6I6N7ZlzVxyKSoGRxULWu2pMn0Y5cvjYSDVTMBGvxycyEEeIh9A2W1G/wQ9px6KAnfu6UGV+xJpzCbBN65ZZU5StHaKUN1VrARUWhwz/0o328g5fvnWXO+iwfnib6ovagC8KEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+5I3MsYySsnujm/foAhG4Cka5IHjY6luI3CUbsh2LlA=;
 b=g3Ii/zHPQvrSepE2YHaTuvx52k66JxRIGQK1vx5y2W5BzmPNG35GeUtAM6FWHgQztiEJwB/5PjjV6yWftzBVyONNiCurDbgQVhgoeo7C/xoEB8pUeyCcfrOYWttkrBUxSqjyKdIGmvaWA8cutLijozgs1E/3q3oR1lKnLStD25AcWtEMVEid1RqcNfumgwYwgArJKsvogVXj95K7Kr9DVph39omBJsqdZkovPBzumKomCgbQwfqHJzcI4ckLeUiYic0R5jgvw9iNgslz5ndwxWSK0cy4/iMTF1L96W86ACRlryV2eZ1q8ivTqomIDXNizQ3f1wI0woDnIwMBlPH4fA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+5I3MsYySsnujm/foAhG4Cka5IHjY6luI3CUbsh2LlA=;
 b=lSUgkoSCT9c8KgRofLTNLoATl82YkBS06vlpXW/p68hggfkT5xVziG6Ka3mOyRPfobCcTR8zS9G+ZigkXbPGIvCGSYOn4f4xp8F4oEmQVte66AkpvdpBV7C65iqJSpL0h7tVI00M8c436MStJa1Mfzgr8ePchVFJltoy0BbPNdk=
Received: from CH2PR19CA0019.namprd19.prod.outlook.com (2603:10b6:610:4d::29)
 by MN6PR12MB8516.namprd12.prod.outlook.com (2603:10b6:208:46f::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.12; Thu, 9 Jan
 2025 06:09:01 +0000
Received: from CH1PEPF0000A34B.namprd04.prod.outlook.com
 (2603:10b6:610:4d:cafe::40) by CH2PR19CA0019.outlook.office365.com
 (2603:10b6:610:4d::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8335.10 via Frontend Transport; Thu,
 9 Jan 2025 06:09:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CH1PEPF0000A34B.mail.protection.outlook.com (10.167.244.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8335.7 via Frontend Transport; Thu, 9 Jan 2025 06:09:01 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 9 Jan
 2025 00:09:00 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 9 Jan
 2025 00:08:55 -0600
Received: from emily-Z10PA-U8-Series.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Thu, 9 Jan 2025 00:08:55 -0600
From: Emily Deng <Emily.Deng@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Emily Deng <Emily.Deng@amd.com>
Subject: [PATCH v3] drm/amdgpu: Fix the looply call svm_range_restore_pages
Date: Thu, 9 Jan 2025 14:08:53 +0800
Message-ID: <20250109060853.1437841-1-Emily.Deng@amd.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: Emily.Deng@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000A34B:EE_|MN6PR12MB8516:EE_
X-MS-Office365-Filtering-Correlation-Id: a6b1fe3f-ecd3-4eec-9b24-08dd30741cbf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?3JDEIjvzpVC68h92TjxDmGlnzcvgg89628GQqO+zHSMHGHZ+QeD095Dd59Qr?=
 =?us-ascii?Q?sc1CpRFWlnYquvt26VZ2yTdEWTmpg9E66P9QlsCg3fdZSqrYcQSv40LdMlfA?=
 =?us-ascii?Q?otZo9cZS1ib2TR7991hgd8R7MYgQgY9edVDFYxQwC7Zs6eRKBBLp2RMUgQEA?=
 =?us-ascii?Q?4oFo4HjZjYwmRpEDrGxkl8xjZorXRd8rjvgqFP/8scBQDnNg1G8MJebSQ+EB?=
 =?us-ascii?Q?oLF6RFuN/k0YUaeDCCKKcKV7at56mVq/57gfuTEzn2CyVi30Uja1+rawlVCH?=
 =?us-ascii?Q?+L5JF2RLbtrjnLiMGpwwlPTIcvxjyuDu5miO7qdKTJ6EcumvKhzqznJIZ2+l?=
 =?us-ascii?Q?qmkb6IVMVAQUvfV9bxRJO9NWV/NHCZiGC6qHpVqVZQ7aT53kLVfQFJBLMp1Q?=
 =?us-ascii?Q?ulnAjtcYB0xUkbNCIyqg0xlTnuGqj0Lsok62GTf12d5w7/MQHePLRIxIMPNa?=
 =?us-ascii?Q?kYbQkGjg22QBw2Tgu78ra9rB0M03dJAvPri8IIJ2OB80GeaF6+XloHuPafE4?=
 =?us-ascii?Q?AHqpau4ayvSLLrig0LtPDclwrz/lqDtmDqp0b81wdzKbERsBFkh2xSpvJWIg?=
 =?us-ascii?Q?0y0XPKzRNvuGYDhW36nxvh/yxFnGRXm372ICvQVs+y+A4gDfMcSh6jeW44i7?=
 =?us-ascii?Q?VbGV/8Gn0jlgnjqT71cyIVDOU2tTQpUSaIQfBjm6CLeyytVCLwLFrpAAYuGD?=
 =?us-ascii?Q?uHTLyZs2e9OxYh+Eh+50ygSwvOCIIj4DBQjJp119aljeujgHFL5ProBSJcC0?=
 =?us-ascii?Q?jhTJhqK/pwvxqH7hhnEtUOAwW9UkiMMeXdlwOIURb6IvlvUx/4Fo0IBZ2wxR?=
 =?us-ascii?Q?FhSXJTD9ULMKXUHhEwEyw3oeaUVyAPtytuX46hgAHiGwf7uqtZP0qEcNUdpq?=
 =?us-ascii?Q?Ld8qRMG+CWkTGtMgmLtS6ACOpIbYBCl8AzJ8Xuc8JMyaaD/+8kMT8b40Y8Rn?=
 =?us-ascii?Q?de3LpfzQzMwu3BbLZ4F5JMZB42B8mdaGjo40jBEhB0N9f9hOfpbJAFtLN49q?=
 =?us-ascii?Q?7gQImvCxN+WhGlyXC2ugYmcWkK+zfjC3Q6xrFb19hCNsU2SbYVSrn9X5xpYS?=
 =?us-ascii?Q?leTMO+Tw/uIcau/IKCwwlbOkT+KX3cPCv8Cqq1G5eR3fKU70TOKemZotsFvK?=
 =?us-ascii?Q?8rMhmuWDukKvxMFWLii+WsvRS6eP5iDNWR67LqbdXU5B3jTumKDnu5UzQc63?=
 =?us-ascii?Q?7O5tdk3FqASxjJ4c6oUpuEHkf3KJqwHwu6uMhkCt8iRXoLrTWtiw/Z67DaR1?=
 =?us-ascii?Q?XbaMSDReaHm/LgcIlifFlvODuKCq133STtS4sA5T/CK1kyh8NVakKQHiyzE9?=
 =?us-ascii?Q?K+W5P2DpwsQRdWwo1RWNl7Ygy/wo2AkBjN/moXwLld8iQNb53IgtWHspL2xh?=
 =?us-ascii?Q?Q2uGtPYV+2isDQe1+DgyOIt82ymGkv8Y9rPjROZpAeJBjZ3aBfp+PXhbn+St?=
 =?us-ascii?Q?hsUJwYWnLx9Hp7kR9DdPkfIKmYfXIZuU5YiN9S5F+BLKQkF2bE4I3grCmTDI?=
 =?us-ascii?Q?MToUfWQK1HlxHXA=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jan 2025 06:09:01.2355 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a6b1fe3f-ecd3-4eec-9b24-08dd30741cbf
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000A34B.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR12MB8516
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
index f78a0434a48f..62a5e0ad4243 100644
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
+			new_entry = kmalloc(sizeof(*new_entry), GFP_KERNEL);
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

