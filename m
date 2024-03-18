Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09720C54E58
	for <amd-gfx@archiver.kernel.org>; Mon, 18 Mar 2024 12:09:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 61B9C10EB7B;
	Mon, 18 Mar 2024 12:09:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="bc7XSgPD";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2043.outbound.protection.outlook.com [40.107.223.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 65F2210EB7B
 for <amd-gfx@lists.freedesktop.org>; Mon, 18 Mar 2024 12:09:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n24bGxFcmHh5fym1IzXfykq9u9IdgDVPKtWFBhbbXQB8SNwTprYwMW97BN94EPVKOLA4ctEDlkRz5XFufsgc5sG7y3yp7EyJJp6YSF81NDKIJd+2iEKwt5z7jjo0cJMiZofNiv4V9XrNP0GBNaYl3i/NcI1bsmMd9cYHGxS9e83R+2Xo9Djr8q74jvQN/4GHKrsvhLjarfJXTaomteqmoRLF8+7qEJFk0Q/4jNbDaxZg6tFA2s7rBIfge8yMrlrce6vC1pWvVmNBp/sOoHK53PdUsQCEX5RC82NwNJWrRDWZtCTbjU+QY61e83zie9rRDrVFzgbgUrtlIzXb9B87Tg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UMvXXh1YszhBo/EJwv/PYeyVXI62ED5hVdKg3aar/Fc=;
 b=j4i2GISpAHQ9fpdxX92jKJo8JGH2xo5mWQp/N1Nh9d5jZr2uoavmE6/F7+xkkDcd/F+U//o1ZdX7121fGKmdjRN8A8536e3QISafKL2vp+kCF8zND5HtSJWueVkdO0mbWyND3e2V2/4nMIPcCq543Hh0MjrZrWosex7R9yWvGGPJgGkQ/9dKgaqNmS5GQTHzbsjNNvQrsk5QoyvqTyqqfvRmrYBIMznMK8p+PyaGbo6g0EaapttsXFXck8F7F8Bn6vOgY6Qa3sAT2eAH58goaK7hA3mXlbxr2z+w7hgde0bE+09cEm8X79Gu6MIM6qU1yzBNv8xi0tlpNhEHbgr57A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UMvXXh1YszhBo/EJwv/PYeyVXI62ED5hVdKg3aar/Fc=;
 b=bc7XSgPDGgL5I54jrEu23JQzGJ02otb8+G6VwXJvFiTmNNpSH1RSSB+p4Wrb6uPXpfhHzaUI1idAqi/u7XVxRV0e1EfB16uQGLdwj2Fc1hepKOE6eanjuZU8euR4iNSA+1TuU1xhRvxsOrEyvII/l3o82VUwneG3eZOjfXH2IxI=
Received: from PH7PR17CA0037.namprd17.prod.outlook.com (2603:10b6:510:323::28)
 by BL3PR12MB6451.namprd12.prod.outlook.com (2603:10b6:208:3ba::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.27; Mon, 18 Mar
 2024 12:09:05 +0000
Received: from MWH0EPF000989E7.namprd02.prod.outlook.com
 (2603:10b6:510:323:cafe::f7) by PH7PR17CA0037.outlook.office365.com
 (2603:10b6:510:323::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.27 via Frontend
 Transport; Mon, 18 Mar 2024 12:09:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000989E7.mail.protection.outlook.com (10.167.241.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7409.10 via Frontend Transport; Mon, 18 Mar 2024 12:09:04 +0000
Received: from MUN-L-SHSHARMA.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 18 Mar
 2024 07:09:01 -0500
From: Shashank Sharma <shashank.sharma@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Shashank Sharma <shashank.sharma@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <Christian.Koenig@amd.com>, Alex Deucher
 <alexander.deucher@amd.com>, Felix Kuehling <felix.kuehling@amd.com>,
 Rajneesh Bhardwaj <rajneesh.bhardwaj@amd.com>
Subject: [PATCH v7 2/2] drm/amdgpu: sync page table freeing with tlb flush
Date: Mon, 18 Mar 2024 13:08:36 +0100
Message-ID: <20240318120837.2011-2-shashank.sharma@amd.com>
X-Mailer: git-send-email 2.38.0.windows.1
In-Reply-To: <20240318120837.2011-1-shashank.sharma@amd.com>
References: <20240318120837.2011-1-shashank.sharma@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000989E7:EE_|BL3PR12MB6451:EE_
X-MS-Office365-Filtering-Correlation-Id: 9875f8a6-96bd-4431-de69-08dc474434ac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: upDdNx+miRTqFeEYTON0JEKSPiiyBfycDl+X2e5nvx8360X5SBbR3pBdssz/TBlVEcKbEGaqQ+9WQASQv8EDkbJjdYp1A0b8aTwZ1mvN2t1pBQm9cdG8D7vrBSbT+6NODnPf6ORjX7jfO06PgecOQ7hgRRqzD7ZoC6tuxI3EZFWsqZ/Mn8Ulj12Q9S24h9GlxmQuSUOvnr4PtD19pVttVWzYTbl1HexwxSrpnrLQnzSBtaj3kUU8zOaCHW7juB8FPsvMHJynGSKg9b2+oA8L8ngJodi8/gm5k1I1yF7f3Dlol3hvtmYsxb9Xl19DQXNCTjO6mw4Eu7U/Kk9voIaa8HWEwR0GSTeHoxiuvH+wY0wgeHnBt1prgBu040qgx71d4Ut9x4mbtqjthkxzl3cuycARcsUoMN0p+Mqle+FCJ3vXbVRRQIOFVOghrKCBWrDpdhvom/yEJL6/TnmC4JYjW6kpy5pBJgHJctcHJnl0f8yU3f+E3A+36DJblDRiby4oldvqQdPCFIVGQ/nKE1s78w8+5LGqXUWV9rt77vRSNEtQA01JNKTlox+UyB7mHj97wth3OxTHjlVWzQwcfb7cQjum7UDhfhdNA+QSY27iFQHmvt7b4oSk/2KDfrKmj1r4Zt9RwA/D8BCHotQpeG+VykKCBqx8x3Va3b4WQQW01swD43vLmcMxtPdkx7KrfU/qsUWDO8iOl3ZhZAZLquF+caEhitdgc/Z3it4bNhOJE5dpalByZLGa+KbRuI3XPood
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(36860700004)(376005)(1800799015)(82310400014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2024 12:09:04.5454 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9875f8a6-96bd-4431-de69-08dc474434ac
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000989E7.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6451
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

Cc: Christian König <Christian.Koenig@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Felix Kuehling <felix.kuehling@amd.com>
Cc: Rajneesh Bhardwaj <rajneesh.bhardwaj@amd.com>
Acked-by: Felix Kuehling <felix.kuehling@amd.com>
Acked-by: Rajneesh Bhardwaj <rajneesh.bhardwaj@amd.com>
Tested-by: Rajneesh Bhardwaj <rajneesh.bhardwaj@amd.com>
Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c    |  5 ++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h    |  7 +++
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c | 53 +++++++++++++----------
 3 files changed, 40 insertions(+), 25 deletions(-)

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
index 601df0ce8290..440dc8c581fc 100644
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
@@ -667,7 +657,11 @@ static void amdgpu_vm_pt_free_dfs(struct amdgpu_device *adev,
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
@@ -972,10 +966,21 @@ int amdgpu_vm_ptes_update(struct amdgpu_vm_update_params *params,
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

