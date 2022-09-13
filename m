Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F285C6FA82
	for <amd-gfx@archiver.kernel.org>; Tue, 13 Sep 2022 13:19:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C84FD10E701;
	Tue, 13 Sep 2022 13:19:46 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2055.outbound.protection.outlook.com [40.107.243.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E6D3B10E701
 for <amd-gfx@lists.freedesktop.org>; Tue, 13 Sep 2022 13:19:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FvqmGmcJOSWYApU0iB6jOUYvAptCl8LyuDusJDKNrjioX5GI6lkKagxiKSpbmkDy8PRIoceqkOTum4bqTxA71AzddKZgDuR7aimyi99iGcy1sHa4WLNgpGLA/aAWs/HqvT7zM0YnIXCPtuwEipvy0FgowdB7RP/wOoH65caEE+EqZrlT7cq0nJ8zN3iLWCpl3ETaGbmMY0S2tXIu7MzDtgBczytB8duGuEZYw0o/846Nr6B2FdIqNKAtE0ghc5MOxH9+/OGqRpM3LIb/W24WiXUMFosiUoI86wuF0RKqrjF9vx7fzOWLdpFQbwUMSwWXAEk+aij60EW1nwj+5Iy73Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TzmKRYrEACdwUJxMyasHryjMsiQwn7i+/nIiI5bLBgs=;
 b=c/jgHyeX/+4qES7a4bqR6e/RISVICBgGQ4bmZdlY9GkA2A0QgwkbTpKVrcLpL4MyG8eLtm87vAX0h89OHPD36PpCoj66DFO+tge3i2Oq83i/J3Eo5bR1xp7VKCa02lTSn4okIQRSnuprqI2QBbiJ8hndMye3AFqg2DF9NK+YV8L09v0sgMRoPmdLo3TMPMS6TUHvwabf01zSvIiZcTeMRT3pnx7AQkALIFApNs89YPHJzCVxWJysYwFeYBskR/5Egks1ywgnW3LAqcX8jYViUli0A/yMfpz2pjTjuHc8Pjq6qs6CIK2ZJmKhSwmAV88wQsmwjr3ftr0glD187F7fbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TzmKRYrEACdwUJxMyasHryjMsiQwn7i+/nIiI5bLBgs=;
 b=tNZS2yLQV4WyXH9zYHxSzkMrGDxtj3RK+j6LEbfnP3XUgmdJzCCGAYdLKiMpDxBV2fih2zy4gOo4CJBv1yqQGPB+dE/lwlUyFNDBo5g7xUe4V8BRkFCsPMJklqEEBAxC5IGC9fuXAdrkCy871RcT6Afl/gUwR9epEgaTqVyK4XQ=
Received: from BN7PR02CA0021.namprd02.prod.outlook.com (2603:10b6:408:20::34)
 by SN7PR12MB6790.namprd12.prod.outlook.com (2603:10b6:806:269::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.14; Tue, 13 Sep
 2022 13:19:41 +0000
Received: from BN8NAM11FT093.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:20:cafe::de) by BN7PR02CA0021.outlook.office365.com
 (2603:10b6:408:20::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.12 via Frontend
 Transport; Tue, 13 Sep 2022 13:19:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT093.mail.protection.outlook.com (10.13.177.22) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5612.13 via Frontend Transport; Tue, 13 Sep 2022 13:19:41 +0000
Received: from Philip-Dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Tue, 13 Sep
 2022 08:19:40 -0500
From: Philip Yang <Philip.Yang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v3 1/1] drm/amdgpu: fix amdgpu_vm_pt_free warning
Date: Tue, 13 Sep 2022 09:19:26 -0400
Message-ID: <20220913131926.24766-1-Philip.Yang@amd.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220912175817.17985-1-Philip.Yang@amd.com>
References: <20220912175817.17985-1-Philip.Yang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT093:EE_|SN7PR12MB6790:EE_
X-MS-Office365-Filtering-Correlation-Id: 5e083008-3257-4d6d-0056-08da958a9dcc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gYQ/dh5fHCOocbSueq/LiyMFFQveDCmEg1zjH1D7bV4vmrNgv37Ikl0lH1kXdG0PS/vV4yH81AIjvsNd0WfOAcyOKaMGPCyJ5DAhvavjEu8ACunaaXH6TAXCGI9QiaRtcc9B/fPsH6OxD7M8QRHl0XvKJsT1tQaKNFpCBOKhmsdW/DoP8feCa73nGRP5g2oCWShGca2vQAF4HqxqCr6YPHCluzG+6w/NLXFrLQPINB/TC3SC606jza+RlMaQpoDh1uHHVsYJFASpP6bs+OiNBXuGhEot/XzNqFMa8/8DR3vfE2dsUyFjJP8sDnDxTh6zLDAB9NN+O4qbOKOnjMb0uejMZpqk0moT/IHPTDwKHH7KSLedUY+gc0x+F/+WJX9tcblVK/BtvXCRF7pfAncsXge39ftXu9N32erwYiig5/GrONd8R3Ec4wEWH67wl/tU0vR/tKDv9aB9S7Gwcw6jr6aiR08Dsj158bkONsvbNOsdvMpR7MY64pUQC5OMH/TW1BnXC4sW4/1uCjf2idG+5+vB94BRCml1Pb7VlKRb1F+GQgxIhWV3lXHcNSVO4mDpqxxiyYZ6knag89x2QXH0Gutya1ndO0NVQ6X9zmJ+jkuGcZW5kVIk7qTGonFDB5kksuqnWUzQrKMNRfn7cFzJdaefM/i5L58Ibavz+CCYgcSi5igpEhTC9kRyqZYc2evKAuSL4pcvjdpL9uhofInAePKOOcCygbDOd9rDru4IVicSVq3lPOV04OIVgF3nNEfZZLTqxqZ271U07ymp6sQD/dp3ECrmPWTDjQD7GjlN1is=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(346002)(39860400002)(136003)(376002)(396003)(451199015)(40470700004)(36840700001)(46966006)(36860700001)(83380400001)(26005)(7696005)(2616005)(36756003)(316002)(16526019)(41300700001)(336012)(478600001)(4326008)(54906003)(70206006)(40480700001)(186003)(8936002)(8676002)(6666004)(82310400005)(2906002)(5660300002)(70586007)(40460700003)(81166007)(82740400003)(1076003)(86362001)(426003)(47076005)(6916009)(356005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Sep 2022 13:19:41.1139 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e083008-3257-4d6d-0056-08da958a9dcc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT093.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6790
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
Cc: Philip Yang <Philip.Yang@amd.com>, felix.kuehling@amd.com,
 christian.koenig@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Free page table BO from vm resv unlocked context generate below
warnings.

Add a pt_free_work in vm to free page table BO from vm->pt_freed list.
pass vm resv unlock status from page table update caller, and add vm_bo
entry to vm->pt_freed list and schedule the pt_free_work if calling with
vm resv unlocked.

WARNING: CPU: 12 PID: 3238 at
drivers/gpu/drm/ttm/ttm_bo.c:106 ttm_bo_set_bulk_move+0xa1/0xc0
Call Trace:
 amdgpu_vm_pt_free+0x42/0xd0 [amdgpu]
 amdgpu_vm_pt_free_dfs+0xb3/0xf0 [amdgpu]
 amdgpu_vm_ptes_update+0x52d/0x850 [amdgpu]
 amdgpu_vm_update_range+0x2a6/0x640 [amdgpu]
 svm_range_unmap_from_gpus+0x110/0x300 [amdgpu]
 svm_range_cpu_invalidate_pagetables+0x535/0x600 [amdgpu]
 __mmu_notifier_invalidate_range_start+0x1cd/0x230
 unmap_vmas+0x9d/0x140
 unmap_region+0xa8/0x110

WARNING: CPU: 0 PID: 1475 at
drivers/dma-buf/dma-resv.c:483 dma_resv_iter_next
Call Trace:
 dma_resv_iter_first+0x43/0xa0
 amdgpu_vm_sdma_update+0x69/0x2d0 [amdgpu]
 amdgpu_vm_ptes_update+0x29c/0x870 [amdgpu]
 amdgpu_vm_update_range+0x2f6/0x6c0 [amdgpu]
 svm_range_unmap_from_gpus+0x115/0x300 [amdgpu]
 svm_range_cpu_invalidate_pagetables+0x510/0x5e0 [amdgpu]
 __mmu_notifier_invalidate_range_start+0x1d3/0x230
 unmap_vmas+0x140/0x150
 unmap_region+0xa8/0x110

Signed-off-by: Philip Yang <Philip.Yang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c    |  4 ++
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h    |  6 +++
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c | 47 ++++++++++++++++++++---
 3 files changed, 51 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index 59cac347baa3..27e6155053b6 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -2022,6 +2022,9 @@ int amdgpu_vm_init(struct amdgpu_device *adev, struct amdgpu_vm *vm)
 	spin_lock_init(&vm->invalidated_lock);
 	INIT_LIST_HEAD(&vm->freed);
 	INIT_LIST_HEAD(&vm->done);
+	INIT_LIST_HEAD(&vm->pt_freed);
+	INIT_WORK(&vm->pt_free_work, amdgpu_vm_pt_free_work);
+	spin_lock_init(&vm->pt_free_lock);
 
 	/* create scheduler entities for page table updates */
 	r = drm_sched_entity_init(&vm->immediate, DRM_SCHED_PRIORITY_NORMAL,
@@ -2244,6 +2247,7 @@ void amdgpu_vm_fini(struct amdgpu_device *adev, struct amdgpu_vm *vm)
 		amdgpu_vm_free_mapping(adev, vm, mapping, NULL);
 	}
 
+	cancel_work_sync(&vm->pt_free_work);
 	amdgpu_vm_pt_free_root(adev, vm);
 	amdgpu_bo_unreserve(root);
 	amdgpu_bo_unref(&root);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
index 9ecb7f663e19..b77fe838c327 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
@@ -276,6 +276,11 @@ struct amdgpu_vm {
 	/* BOs which are invalidated, has been updated in the PTs */
 	struct list_head        done;
 
+	/* PT BOs scheduled to free and fill with zero if vm_resv is not hold */
+	struct list_head	pt_freed;
+	struct work_struct	pt_free_work;
+	spinlock_t		pt_free_lock;
+
 	/* contains the page directory */
 	struct amdgpu_vm_bo_base     root;
 	struct dma_fence	*last_update;
@@ -471,6 +476,7 @@ int amdgpu_vm_pde_update(struct amdgpu_vm_update_params *params,
 int amdgpu_vm_ptes_update(struct amdgpu_vm_update_params *params,
 			  uint64_t start, uint64_t end,
 			  uint64_t dst, uint64_t flags);
+void amdgpu_vm_pt_free_work(struct work_struct *work);
 
 #if defined(CONFIG_DEBUG_FS)
 void amdgpu_debugfs_vm_bo_info(struct amdgpu_vm *vm, struct seq_file *m);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
index 88de9f0d4728..c6f91731ecfb 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
@@ -624,12 +624,22 @@ static int amdgpu_vm_pt_alloc(struct amdgpu_device *adev,
  *
  * @entry: PDE to free
  */
-static void amdgpu_vm_pt_free(struct amdgpu_vm_bo_base *entry)
+static void amdgpu_vm_pt_free(struct amdgpu_vm_bo_base *entry, bool unlocked)
 {
 	struct amdgpu_bo *shadow;
 
 	if (!entry->bo)
 		return;
+
+	if (unlocked) {
+		spin_lock(&entry->vm->pt_free_lock);
+		list_move(&entry->vm_status, &entry->vm->pt_freed);
+		spin_unlock(&entry->vm->pt_free_lock);
+
+		schedule_work(&entry->vm->pt_free_work);
+		return;
+	}
+
 	shadow = amdgpu_bo_shadowed(entry->bo);
 	if (shadow) {
 		ttm_bo_set_bulk_move(&shadow->tbo, NULL);
@@ -641,6 +651,29 @@ static void amdgpu_vm_pt_free(struct amdgpu_vm_bo_base *entry)
 	amdgpu_bo_unref(&entry->bo);
 }
 
+void amdgpu_vm_pt_free_work(struct work_struct *work)
+{
+	struct amdgpu_vm_bo_base *entry, *next;
+	struct amdgpu_vm *vm;
+	struct amdgpu_bo *root;
+	LIST_HEAD(pt_freed);
+
+	vm = container_of(work, struct amdgpu_vm, pt_free_work);
+
+	spin_lock(&vm->pt_free_lock);
+	list_splice_init(&vm->pt_freed, &pt_freed);
+	spin_unlock(&vm->pt_free_lock);
+
+	root = amdgpu_bo_ref(vm->root.bo);
+	amdgpu_bo_reserve(root, true);
+
+	list_for_each_entry_safe(entry, next, &pt_freed, vm_status)
+		amdgpu_vm_pt_free(entry, false);
+
+	amdgpu_bo_unreserve(root);
+	amdgpu_bo_unref(&root);
+}
+
 /**
  * amdgpu_vm_pt_free_dfs - free PD/PT levels
  *
@@ -652,16 +685,17 @@ static void amdgpu_vm_pt_free(struct amdgpu_vm_bo_base *entry)
  */
 static void amdgpu_vm_pt_free_dfs(struct amdgpu_device *adev,
 				  struct amdgpu_vm *vm,
-				  struct amdgpu_vm_pt_cursor *start)
+				  struct amdgpu_vm_pt_cursor *start,
+				  bool unlocked)
 {
 	struct amdgpu_vm_pt_cursor cursor;
 	struct amdgpu_vm_bo_base *entry;
 
 	for_each_amdgpu_vm_pt_dfs_safe(adev, vm, start, cursor, entry)
-		amdgpu_vm_pt_free(entry);
+		amdgpu_vm_pt_free(entry, unlocked);
 
 	if (start)
-		amdgpu_vm_pt_free(start->entry);
+		amdgpu_vm_pt_free(start->entry, unlocked);
 }
 
 /**
@@ -673,7 +707,7 @@ static void amdgpu_vm_pt_free_dfs(struct amdgpu_device *adev,
  */
 void amdgpu_vm_pt_free_root(struct amdgpu_device *adev, struct amdgpu_vm *vm)
 {
-	amdgpu_vm_pt_free_dfs(adev, vm, NULL);
+	amdgpu_vm_pt_free_dfs(adev, vm, NULL, false);
 }
 
 /**
@@ -966,7 +1000,8 @@ int amdgpu_vm_ptes_update(struct amdgpu_vm_update_params *params,
 				if (cursor.entry->bo) {
 					params->table_freed = true;
 					amdgpu_vm_pt_free_dfs(adev, params->vm,
-							      &cursor);
+							      &cursor,
+							      params->unlocked);
 				}
 				amdgpu_vm_pt_next(adev, &cursor);
 			}
-- 
2.35.1

