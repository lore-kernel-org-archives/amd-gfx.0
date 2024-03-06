Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9259DC5475B
	for <amd-gfx@archiver.kernel.org>; Wed,  6 Mar 2024 14:41:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 100C711323E;
	Wed,  6 Mar 2024 14:41:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="5SbQ/QhB";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2060.outbound.protection.outlook.com [40.107.220.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9D9E111323F
 for <amd-gfx@lists.freedesktop.org>; Wed,  6 Mar 2024 14:41:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fsp8uRWgNo96bA5HymgdWKiqWR5YQ5zErRBnASq0bCWyIC0G9inrKYaW5a8Mtp0fXInioXo6L5x0dRuL1tixkxei28uRw/RMU2O7Bci5MsJlxXgdelLuiPvknGgbT0/+389H2GjQ+uM5KDjnsRyRq0qwaUOb13VHBDvaMG0IPQbt9uYQiiFpqxXZc/wRvIGjSzsSNFWWMjFefscjiMwOErH8kFkYPYYhA9WK/O+lvZi6OIBtU7UutTSiWdUKc4cFKe8lhwtR9FVP5SAU3aHQk1kl9IiZCq5WeMazDDbywAOIpvAqNHqPYllqaGedPJ1meW+iL08DCCfjeihE+OO3Kg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IVB9Hhvm9buA2hW0V4VjhdOLQmYgmpc11rk+/SmJkr8=;
 b=ZRvkPpnNWoTu/qbpd3DnkuUu3fi4J7JA2dQYM76qBdCYI0s5MqSXJ7pmFR85tKrZfVJYHM/jQunuaiggsPFBo3McOgHXpGUsJ4y70RkOC/OKEozNf9Dyn3UD861iiksU4ebFQAv1bNEbs5oLKuvxcdAIru4tUeWAzfUb0F1BYepkKleeuHYccR+1Z0S3bwHVkhRuyvGutV8vhSzIW17v3IrsbCKmqE2xN1k9lcrnl6IjDrInk6hXKLYmB7H6L8YXv0p8SmXbJfwAcaMFgvQT+UjCvNTWT6ECvF7C20lI0Fo1de3xHVbEgUz3y0PiJrcmqqBfUc0Dcbe+BbNznJu4JA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IVB9Hhvm9buA2hW0V4VjhdOLQmYgmpc11rk+/SmJkr8=;
 b=5SbQ/QhBnk2fVyca2J8ni09keP86zKBp3WLXpf+G2t/dMPYe93z25Teo4J4KnSyQospt6NS3Bu7v61ibfJ5ydTl8RVC1lsjLwkzRmKPb0+CZ1Pdgpa36a/liDYwdnMXjhs6h2LC5LtyKjSUSj1vvZUxSr5jMJfV8wNV1oT3HQEc=
Received: from CH0P220CA0011.NAMP220.PROD.OUTLOOK.COM (2603:10b6:610:ef::13)
 by DS0PR12MB9057.namprd12.prod.outlook.com (2603:10b6:8:c7::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.39; Wed, 6 Mar
 2024 14:41:45 +0000
Received: from CH3PEPF0000000E.namprd04.prod.outlook.com
 (2603:10b6:610:ef:cafe::cc) by CH0P220CA0011.outlook.office365.com
 (2603:10b6:610:ef::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.24 via Frontend
 Transport; Wed, 6 Mar 2024 14:41:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH3PEPF0000000E.mail.protection.outlook.com (10.167.244.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7362.11 via Frontend Transport; Wed, 6 Mar 2024 14:41:45 +0000
Received: from MUN-L-SHSHARMA.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 6 Mar
 2024 08:41:43 -0600
From: Shashank Sharma <shashank.sharma@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Philip Yang <yangp@amd.com>, Shashank Sharma <shashank.sharma@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <Christian.Koenig@amd.com>, Alex Deucher
 <alexander.deucher@amd.com>, Felix Kuehling <felix.kuehling@amd.com>,
 Rajneesh Bhardwaj <rajneesh.bhardwaj@amd.com>
Subject: [PATCH v5 2/2] drm/amdgpu: sync page table freeing with tlb flush
Date: Wed, 6 Mar 2024 15:41:15 +0100
Message-ID: <20240306144115.1007-2-shashank.sharma@amd.com>
X-Mailer: git-send-email 2.38.0.windows.1
In-Reply-To: <20240306144115.1007-1-shashank.sharma@amd.com>
References: <20240306144115.1007-1-shashank.sharma@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF0000000E:EE_|DS0PR12MB9057:EE_
X-MS-Office365-Filtering-Correlation-Id: ff772c0c-c73c-4f77-02b9-08dc3deb8c09
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5Q3NlVrvPtGokmxRvfxfWpfJBGhjMQ9cQgL0GkWz9/thDlbNCbHt+7cCvCT7dxfh4yExLrzpbBMJ6hIc689HDIlC3jWdHYF3UW5OhTQpPHnaQztnh/ZrCNXJD6QbE2i7VOwdE1O5rpf2XBdwFDD3w+HOzM10ae5OTv2kz7wEcZr2346GssZEsUMv2hJhe3YV/h1Y2QgWZGvcn2WPxSfeNKUXXDP6KPGXoeYOknj5m7VKd25pxqNldAlQIrUoTMmk3uONw9Sy3nYxARTFGAD2AMsfyP/PWJLjEsEet31GdKGWpU+oweoqa+xrvsZCj5cPBSFUSLC1iYIF9n6oMULf0P7AbIyFjTusqruKaGdRpKHQiDwtGtiijs2A+PKMtRUQMYkWOmzY83vttwnLsnKq82V4vcsGTq1BGsesosKB1G9BLkoruquimdF9qZivyq65uDDDnizTX+TlsNZzMAgPZH1L3Mi6Oyn8ulrAytJJDYFeI321tRHj0mT2GTWluoNUzQiWKQCBiaQqCZ5V9QTeUtYeH+Mpe/XgMxKycSAIiTUuVCHn7I0p/5qJgVKPpybT7r/KfBPpb8CLoVZQrCQT6x00q3wT19E3RLXPz+FdW/Ix7W+nAuWFyH+8vQnvLH1gWj+Xz6K7EVAFCVUdncrHPXPwJh31rCU5o1xRH9vwTezYivdSYD7rck+PfxCmK/mPcwYRCRfsEd+v+dfNupD15Qjru91Ac/vzjIX8Ajvv/sMTTILco3d4K+rs+a9qacED
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(36860700004)(82310400014)(376005); DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2024 14:41:45.5152 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ff772c0c-c73c-4f77-02b9-08dc3deb8c09
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF0000000E.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9057
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

Cc: Christian König <Christian.Koenig@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Felix Kuehling <felix.kuehling@amd.com>
Cc: Rajneesh Bhardwaj <rajneesh.bhardwaj@amd.com>
Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c    |  4 ++
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h    |  7 +++
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c | 53 +++++++++++++----------
 3 files changed, 40 insertions(+), 24 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index 310aae6fb49b..b8a6e534cd81 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -905,6 +905,7 @@ int amdgpu_vm_update_range(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 	params.unlocked = unlocked;
 	params.needs_flush = flush_tlb;
 	params.allow_override = allow_override;
+	INIT_LIST_HEAD(&params.tlb_flush_waitlist);
 
 	/* Implicitly sync to command submissions in the same VM before
 	 * unmapping. Sync to moving fences before mapping.
@@ -997,6 +998,9 @@ int amdgpu_vm_update_range(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 				   DMA_RESV_USAGE_BOOKKEEP);
 	}
 
+	if (params.needs_flush)
+		amdgpu_vm_pt_free_list(adev, &params);
+
 error_unlock:
 	amdgpu_vm_eviction_unlock(vm);
 	drm_dev_exit(idx);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
index 298f604b8e5f..b81ca460b210 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
@@ -265,6 +265,11 @@ struct amdgpu_vm_update_params {
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
@@ -545,6 +550,8 @@ int amdgpu_vm_ptes_update(struct amdgpu_vm_update_params *params,
 			  uint64_t start, uint64_t end,
 			  uint64_t dst, uint64_t flags);
 void amdgpu_vm_pt_free_work(struct work_struct *work);
+void amdgpu_vm_pt_free_list(struct amdgpu_device *adev,
+			    struct amdgpu_vm_update_params *params);
 
 #if defined(CONFIG_DEBUG_FS)
 void amdgpu_debugfs_vm_bo_info(struct amdgpu_vm *vm, struct seq_file *m);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
index 95dc0afdaffb..d3afc9d34b71 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
@@ -679,40 +679,30 @@ void amdgpu_vm_pt_free_work(struct work_struct *work)
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
@@ -724,7 +714,11 @@ static void amdgpu_vm_pt_free_dfs(struct amdgpu_device *adev,
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
@@ -1056,10 +1050,21 @@ int amdgpu_vm_ptes_update(struct amdgpu_vm_update_params *params,
 			while (cursor.pfn < frag_start) {
 				/* Make sure previous mapping is freed */
 				if (cursor.entry->bo) {
+					struct amdgpu_vm_pt_cursor seek;
+					struct amdgpu_vm_bo_base *entry;
 					params->needs_flush = true;
-					amdgpu_vm_pt_free_dfs(adev, params->vm,
-							      &cursor,
-							      params->unlocked);
+
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

