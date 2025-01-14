Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E76E4C02183
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Jan 2025 14:53:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 694B410E374;
	Tue, 14 Jan 2025 14:53:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="vGGSyPBv";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2054.outbound.protection.outlook.com [40.107.243.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6BBD610E37E
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Jan 2025 14:53:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZQnmPKvdREQLgJw9wcpSqQUn+5ihDy4gZmMqD0CLK5tuouoOJje6bdFajEHR1l1OQ6Oy5HVtWgEcu3EVOkeTZzzckqJSyD+1f+WRVPzZX3MYRu6BUQzhjZ0CgAdkVOiYSKeua71zxiucu+/Nvslw7xKAfLETOrosuktBdkSKPtYA/0mD8NZiPJppUlZnnoH3Fygd9zm1lZksdKCoqaOmgh9BnVoyBUjXRc2Qwr/E/icOOHvUaCzhDhkwo8ZebIT2Dy3ZxHT2puU7qfIumOUya4FgodL6/LWKxytcYxpKxz3sZ4/iorpy69f9xJWbeDGkg3pKh6CQFQaaOa4EWeh71Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Mjwf8M9AkIy3dOQOodtH24NsFOXXxV97yzEzou+jfRI=;
 b=W1hV2CXTn+pKj6qVGWZDxvmPnL51OM9nSlabESmDjKd6jPyaZVerh98R4oSPRv4SyY5WPUBEY3vriYeqLf2svlC5GBf3Ko/OEvCx9drwceuVzVdcGPs2JjcGBY/lTdJPVKQOGADr4lffoZ3teMq2niVb36JSbO38+xCKdJtjb60kUiY88eAMGOodo4+CUriJuuszxZroT/JozbT51jWzlmeYzs7HUauM4DDK11doVH34UeSQrXyTqROIlMenz4yKnB9v79C/e1RXk3y4dQ0NW2C39jgJ9w5XJeQGmfikzCelZZiUbvVq4mfzufVBtYCzOM5b1zYSRtHhsnkW6A+4JQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Mjwf8M9AkIy3dOQOodtH24NsFOXXxV97yzEzou+jfRI=;
 b=vGGSyPBv8jXw4WEo7ACyh8H+MbZBeAcqEKrrSRdd14OzU8TGNLnIg7+6+K4gJLyHramJXik0id0husDBIcF5Wv0aO9EIeFKXYwCyaxgAKHfZdM1kLdiX3gEU5TwOdfbc4ycSempI7GqTnaQcHbGWa9A0Jc08Sn0hB+cme9JoQdw=
Received: from SJ0PR05CA0170.namprd05.prod.outlook.com (2603:10b6:a03:339::25)
 by SA3PR12MB7859.namprd12.prod.outlook.com (2603:10b6:806:305::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.18; Tue, 14 Jan
 2025 14:53:40 +0000
Received: from MWH0EPF000989EC.namprd02.prod.outlook.com
 (2603:10b6:a03:339:cafe::20) by SJ0PR05CA0170.outlook.office365.com
 (2603:10b6:a03:339::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8356.11 via Frontend Transport; Tue,
 14 Jan 2025 14:53:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000989EC.mail.protection.outlook.com (10.167.241.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8356.11 via Frontend Transport; Tue, 14 Jan 2025 14:53:40 +0000
Received: from Philip-Dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 14 Jan
 2025 08:53:39 -0600
From: Philip Yang <Philip.Yang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Felix.Kuehling@amd.com>, <christian.koenig@amd.com>,
 <emily.deng@amd.com>, Philip Yang <Philip.Yang@amd.com>
Subject: [PATCH] drm/amdgpu: Unlocked unmap only clear page table leaves
Date: Tue, 14 Jan 2025 09:53:13 -0500
Message-ID: <20250114145314.4633-1-Philip.Yang@amd.com>
X-Mailer: git-send-email 2.47.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000989EC:EE_|SA3PR12MB7859:EE_
X-MS-Office365-Filtering-Correlation-Id: 63780b86-0334-4e6c-21b4-08dd34ab3bdd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?4g4jseieprQDX8A2TSxeFxflpHAk3uplPTFz8N22MGnNvlXHB8xgcVQOnkMV?=
 =?us-ascii?Q?BUNrIMv9TA44vV3ymTtFboQ0/94GIa1nYJUqLB7jdvTXIRnvGYGpnvVGNFbV?=
 =?us-ascii?Q?C5l03v2ELxq1Ufuun+ZnojPmkf89sCqr/Xpg04LljKeyNMJa6mKb8CFY+8sd?=
 =?us-ascii?Q?rDSIiCCxA903jCZak4Eu+qrAIiHx4ih0O1Ilz/pgkkDSTorU0O20LkpmXAo2?=
 =?us-ascii?Q?tfTSPd+VFnCvkrFYdljQEySiyA3VsSmwCBaeHjtrv6MkVDO2SO0xIiGILAp7?=
 =?us-ascii?Q?vhKDuH6O9KTacOEdtKNltlyxPrWogZ9NIGViS0nFAFMdvaGsMRhBRudKNu9g?=
 =?us-ascii?Q?7uUseC1icIcYBvbERDSHH69zqCd/XvG1dJcfLVSfE5FjOJetBBOLWbgKtY22?=
 =?us-ascii?Q?nnAcfH0CIlYkkH2n/sw/aYbtcOXdyb87c5+9bydKHBFPdpWSIWWEZCGrmV8p?=
 =?us-ascii?Q?2GLofe+OJupDrNPjy7L/JAewgGcmDmi5djFmWGOOu/8hg/SK3f2jGdlRZicB?=
 =?us-ascii?Q?261W7+1wCX17Yf4tlebh3gwwjRr4l+iD2UKOmMYjILHCrE2lRwv9Adn6M6iV?=
 =?us-ascii?Q?KbrUOtNMgWJZ0dZiIh+6PT8zTToCQewmJD8Lp6HZEgnmxGsMmoo6KdIdUqZj?=
 =?us-ascii?Q?0IA7tYhnyXgNci4xssnco/zH4XNphuoJY0xILElEsxpQAZ7aROyKxEdKPFZ/?=
 =?us-ascii?Q?svUTIgQR7ZPZR435c2gyQbaEd3u5BdLpTddm4xUSogRHCfEjlXf9EysB09LI?=
 =?us-ascii?Q?BbZcvjUTc31csz5VXl6W9T08Iue5k9efUAAm6hjq0lcT94CU9TuvOQsLUYyU?=
 =?us-ascii?Q?CYEUnZi57o/oXcMsAg4Sw07S1PlE/fQrdgImPeZUEfQmLuOd1vVq/oldDt36?=
 =?us-ascii?Q?LSxf04E74gjSJtSAvoRSMGWMSoPUTVtcswuSnloTLaoaeZ0TM69mU279wq/X?=
 =?us-ascii?Q?f9q+4QnRcU3MXdX1XQuBHG9I7KnsPcSPeCCJsgf5ImmPeTIzuXJk/9DRC/T7?=
 =?us-ascii?Q?3OTZ1WmjWD/SAkCZC4Wnuoo7FTwhLTrZ6Qo3XW9jlBvrwt52aHxl61bl5jWb?=
 =?us-ascii?Q?0hWM6U5KkN5stOmM8vlR2BirIyY+qVCY8+7o9YZ2vV6rW5KhptLFfpw/+C2u?=
 =?us-ascii?Q?ogKOvhzuqKYKezjq13m2mR8knG1JXUrus+SJqrzshUiGEj3IFsRLJngjotYR?=
 =?us-ascii?Q?ZynOLcyssej5Q3nSO3j43uXbbWJYJqWUOuy/B04hTNCKB9EbUJm9dR5jkzVi?=
 =?us-ascii?Q?NqsODdCCpKZ0CQ9kqIrp9YVFZ7SRrdVRuHJwtMALiFgxJD7uEBArrQ9b0GIB?=
 =?us-ascii?Q?jAlkq012aQBZAlLBIs18hlggAgGMCcgz1tz21fpsucaVXTYdP3gS87e7sLLB?=
 =?us-ascii?Q?uhzchqoIlBG2PID7ELp0YdscN7lyO1lR8iYdIOGtGBRyReDZvzl6wbyvknMa?=
 =?us-ascii?Q?f5tgfqjUGc7fZmO/uQd7i5IVv5JYqnM3Es2urvDbhbkV5kZHDQ2TLA=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jan 2025 14:53:40.3159 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 63780b86-0334-4e6c-21b4-08dd34ab3bdd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000989EC.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7859
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

SVM migration unmap pages from GPU and then update mapping to GPU to
recover page fault. Currently unmap clears the PDE entry for range
length >= huge page and free PTB bo, update mapping to alloc new PT bo.
There is race bug that the freed entry bo maybe still on the pt_free
list, reused when updating mapping and then freed, leave invalid PDE
entry and cause GPU page fault.

By setting the update to clear only one PDE entry or clear PTB, to
avoid unmap to free PTE bo. This fixes the race bug and improve the
unmap and map to GPU performance. Update mapping to huge page will
still free the PTB bo.

With this change, the vm->pt_freed list and work is not needed. Add
WARN_ON(unlocked) in amdgpu_vm_pt_free_dfs to catch if unmap to free the
PTB.

Signed-off-by: Philip Yang <Philip.Yang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c    |  4 ---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h    |  4 ---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c | 43 +++++++----------------
 3 files changed, 13 insertions(+), 38 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index c9c48b782ec1..48b2c0b3b315 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -2440,8 +2440,6 @@ int amdgpu_vm_init(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 	spin_lock_init(&vm->status_lock);
 	INIT_LIST_HEAD(&vm->freed);
 	INIT_LIST_HEAD(&vm->done);
-	INIT_LIST_HEAD(&vm->pt_freed);
-	INIT_WORK(&vm->pt_free_work, amdgpu_vm_pt_free_work);
 	INIT_KFIFO(vm->faults);
 
 	r = amdgpu_vm_init_entities(adev, vm);
@@ -2613,8 +2611,6 @@ void amdgpu_vm_fini(struct amdgpu_device *adev, struct amdgpu_vm *vm)
 
 	amdgpu_amdkfd_gpuvm_destroy_cb(adev, vm);
 
-	flush_work(&vm->pt_free_work);
-
 	root = amdgpu_bo_ref(vm->root.bo);
 	amdgpu_bo_reserve(root, true);
 	amdgpu_vm_put_task_info(vm->task_info);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
index 5d119ac26c4f..160889e5e64d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
@@ -369,10 +369,6 @@ struct amdgpu_vm {
 	/* BOs which are invalidated, has been updated in the PTs */
 	struct list_head        done;
 
-	/* PT BOs scheduled to free and fill with zero if vm_resv is not hold */
-	struct list_head	pt_freed;
-	struct work_struct	pt_free_work;
-
 	/* contains the page directory */
 	struct amdgpu_vm_bo_base     root;
 	struct dma_fence	*last_update;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
index f78a0434a48f..54ae0e9bc6d7 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
@@ -546,27 +546,6 @@ static void amdgpu_vm_pt_free(struct amdgpu_vm_bo_base *entry)
 	amdgpu_bo_unref(&entry->bo);
 }
 
-void amdgpu_vm_pt_free_work(struct work_struct *work)
-{
-	struct amdgpu_vm_bo_base *entry, *next;
-	struct amdgpu_vm *vm;
-	LIST_HEAD(pt_freed);
-
-	vm = container_of(work, struct amdgpu_vm, pt_free_work);
-
-	spin_lock(&vm->status_lock);
-	list_splice_init(&vm->pt_freed, &pt_freed);
-	spin_unlock(&vm->status_lock);
-
-	/* flush_work in amdgpu_vm_fini ensure vm->root.bo is valid. */
-	amdgpu_bo_reserve(vm->root.bo, true);
-
-	list_for_each_entry_safe(entry, next, &pt_freed, vm_status)
-		amdgpu_vm_pt_free(entry);
-
-	amdgpu_bo_unreserve(vm->root.bo);
-}
-
 /**
  * amdgpu_vm_pt_free_list - free PD/PT levels
  *
@@ -579,19 +558,15 @@ void amdgpu_vm_pt_free_list(struct amdgpu_device *adev,
 			    struct amdgpu_vm_update_params *params)
 {
 	struct amdgpu_vm_bo_base *entry, *next;
-	struct amdgpu_vm *vm = params->vm;
 	bool unlocked = params->unlocked;
 
 	if (list_empty(&params->tlb_flush_waitlist))
 		return;
 
-	if (unlocked) {
-		spin_lock(&vm->status_lock);
-		list_splice_init(&params->tlb_flush_waitlist, &vm->pt_freed);
-		spin_unlock(&vm->status_lock);
-		schedule_work(&vm->pt_free_work);
-		return;
-	}
+	/*
+	 * unlocked unmap clear page table leaves, warning to free the page entry.
+	 */
+	WARN_ON(unlocked);
 
 	list_for_each_entry_safe(entry, next, &params->tlb_flush_waitlist, vm_status)
 		amdgpu_vm_pt_free(entry);
@@ -899,7 +874,15 @@ int amdgpu_vm_ptes_update(struct amdgpu_vm_update_params *params,
 		incr = (uint64_t)AMDGPU_GPU_PAGE_SIZE << shift;
 		mask = amdgpu_vm_pt_entries_mask(adev, cursor.level);
 		pe_start = ((cursor.pfn >> shift) & mask) * 8;
-		entry_end = ((uint64_t)mask + 1) << shift;
+
+		if (cursor.level < AMDGPU_VM_PTB && params->unlocked)
+			/*
+			 * MMU notifier callback unlocked unmap huge page, leave is PDE entry,
+			 * only clear one entry. Next entry search again for PDE or PTE leave.
+			 */
+			entry_end = 1ULL << shift;
+		else
+			entry_end = ((uint64_t)mask + 1) << shift;
 		entry_end += cursor.pfn & ~(entry_end - 1);
 		entry_end = min(entry_end, end);
 
-- 
2.47.1

