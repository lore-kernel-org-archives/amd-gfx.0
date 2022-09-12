Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F247EC6FA82
	for <amd-gfx@archiver.kernel.org>; Mon, 12 Sep 2022 17:58:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 413B310E029;
	Mon, 12 Sep 2022 17:58:55 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam07on2048.outbound.protection.outlook.com [40.107.212.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0591110E029
 for <amd-gfx@lists.freedesktop.org>; Mon, 12 Sep 2022 17:58:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ACa7vHJQvgTAS2hQqqix4AF/FEYEAH+cELz2436+3/GKGFgyUVSD7LZLsJ4iEkqFCEYL+L1YG/dQYxUf8XoIOkBVOmA5dk1CG5liJNmU8O24kvTEwMYafNwqR2Q6jYGogCWG8vKEOze/+4+Bd9bI0wX1irMAY2LQo9O1L3ao9C/+KN2cZdoL6/Khc4z32VmMETRDCCv/RZDVsRS/mcr50QicmaSEQt3yxhnllDN3yivXpb5UpPxV5ZoO4bu2SzzrTYU1a9d+6LmHuzOh+nFH+BHW36gPM0iIQfI10ulxY9xVSef93EfF1ZiVQzslRAxkgSbE5YUgYnvcLLmkhDJnGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FNdZvG6MtUwAvPCOcVyFVgyYo3S3ntRR3+tQ0q4H6qU=;
 b=i/d3MOxF+ClVMbuLkSxR3xsolziphNyZvz5zpn3/XED+PsKNTYEiWZZGjl0F60dLNYuEp2Om4Vi/SIBrcUG7T6JbpC2d5udkpEYO+cnp9CMyNdXhl4dQhhJKXuWF2LvoaOMcWhlERAvFJ/yIHTwF4unZg4SdXsd2G7YzxSBsnp3EBYR1pIkGN7e320IZkwqv/4HBZk1fnsxnLGTJut2HRf8lc8ZG63cYWVht2ANlEshashkCiE2KN+TtazEnGGfuy03+T4LYliINWTy1cy6o1hgJm145NP5co5LBs/qzMchpbD3uwoNALIDquuMThIDRs2xRrzCm4IX1y6IuT5MTcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FNdZvG6MtUwAvPCOcVyFVgyYo3S3ntRR3+tQ0q4H6qU=;
 b=G+5lmscB8y0HhqVgxn3OcPvS7RNEL+VEycFZsyPpRuMpze7NGwc4ZDLwb2I6ioXFke81KydHO/UkISRfXFKq77bL3M/DF/KJHU3WHNmI18/5LidyrrQ7IHWCFOinjaAxUnQRXiiqSVs0NzvHILIOThkVbFHp/3aEWNwXbLkgl+0=
Received: from BN0PR04CA0028.namprd04.prod.outlook.com (2603:10b6:408:ee::33)
 by DM4PR12MB5213.namprd12.prod.outlook.com (2603:10b6:5:394::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.19; Mon, 12 Sep
 2022 17:58:47 +0000
Received: from BN8NAM11FT066.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:ee:cafe::36) by BN0PR04CA0028.outlook.office365.com
 (2603:10b6:408:ee::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.14 via Frontend
 Transport; Mon, 12 Sep 2022 17:58:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT066.mail.protection.outlook.com (10.13.177.138) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5612.13 via Frontend Transport; Mon, 12 Sep 2022 17:58:47 +0000
Received: from Philip-Dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Mon, 12 Sep
 2022 12:58:46 -0500
From: Philip Yang <Philip.Yang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v2 1/1] drm/amdgpu: fix amdgpu_vm_pt_free warning
Date: Mon, 12 Sep 2022 13:58:17 -0400
Message-ID: <20220912175817.17985-1-Philip.Yang@amd.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT066:EE_|DM4PR12MB5213:EE_
X-MS-Office365-Filtering-Correlation-Id: 2106e113-a527-49e8-8d1a-08da94e870f2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0fOKzermJgc04jg4KXOcbO/gFuEqJEDAnw9At14WsyjWpuQKRi5LKTuFKuTNwYFby1cegWDB8H8UVNk7Fade4uLmIjmUwVSv6eTZuG5wKxEPQeEVtaMTiJ2SokTvrCJbBHLjMKjbJSeXP6lO+/XBMqi2Zh8PbghOhvQ7g9niQX1kmJbUs1aQKCtmXiuDTIJeM/snrDARiJmTygwTZqVFUsu4A7M6PCN8oJ4r209Ev7LxHdUlRReMTDSmRCb6XIreDB/nyA8aLV1voJDCavB4SJuVfctNbaErDrotqQEqKfERt/yj9BXh7yM3h8B7Pqv/Hgnoa02wYcJ6WBUWGyCi3jIq+o0ZbvAFkmIrMJ4QG/IqFPbaz3ZomlgwPhSkwuUCEL4YHrutT48wf1Vp7o6BBQMdBz/Y9prvrFnM37JVBM4RPVoF39IF+Af72suWYmSIRZb1tpgExW4ffgBEUN62IPTIXJpoyWXRLNNA+MFrpY4oHBaiYq/gv3gYSHEyhiUhTBH2M5ao28HfTo1+3PUKVAmoRLKzeHYqn8aqtcTcEu8XtMalIPJvw5vpQfLWh9UL/zerFH/KdTOLij3isoLMpoeY9TPEYTVSiNfIu1uF3pbxA2Io6MBweYJvGM8Z+8MRNL22NezYBUODbJTk756s3e0XnNaskz1+26KyeD8OGkGjhA02Vj/l+d7Knadd2mh+yMllAxMYfr7mn2AKoH7bAJRS8zA4hYfCabUhMIpOCWcCQAPPyWLpUI3laqAPjNvcaZOgO9lq3lnk6Ij5JEx9i+BQSENtkJsHh9ZdKdMV9ck=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(39860400002)(136003)(396003)(346002)(376002)(451199015)(40470700004)(46966006)(36840700001)(2616005)(82740400003)(6666004)(86362001)(54906003)(336012)(40480700001)(81166007)(70586007)(8676002)(70206006)(47076005)(1076003)(82310400005)(36756003)(356005)(16526019)(6916009)(36860700001)(41300700001)(478600001)(426003)(83380400001)(186003)(7696005)(4326008)(26005)(5660300002)(8936002)(40460700003)(2906002)(316002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2022 17:58:47.3989 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2106e113-a527-49e8-8d1a-08da94e870f2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT066.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5213
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

Add a free_bo_work in vm to free page able BO from vm->bo_freed list.
pass vm resv unlock status from page table update caller, and add vm_bo
entry to vm->bo_freed_list and schedule the work if calling with vm resv
unlocked.

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
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c | 51 ++++++++++++++++++++---
 3 files changed, 55 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index 59cac347baa3..add3b08ffde9 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -2022,6 +2022,9 @@ int amdgpu_vm_init(struct amdgpu_device *adev, struct amdgpu_vm *vm)
 	spin_lock_init(&vm->invalidated_lock);
 	INIT_LIST_HEAD(&vm->freed);
 	INIT_LIST_HEAD(&vm->done);
+	INIT_LIST_HEAD(&vm->bo_freed);
+	INIT_WORK(&vm->bo_free_work, amdgpu_vm_pt_free_work);
+	spin_lock_init(&vm->bo_free_lock);
 
 	/* create scheduler entities for page table updates */
 	r = drm_sched_entity_init(&vm->immediate, DRM_SCHED_PRIORITY_NORMAL,
@@ -2244,6 +2247,7 @@ void amdgpu_vm_fini(struct amdgpu_device *adev, struct amdgpu_vm *vm)
 		amdgpu_vm_free_mapping(adev, vm, mapping, NULL);
 	}
 
+	cancel_work_sync(&vm->bo_free_work);
 	amdgpu_vm_pt_free_root(adev, vm);
 	amdgpu_bo_unreserve(root);
 	amdgpu_bo_unref(&root);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
index 9ecb7f663e19..c8c59c66ca2f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
@@ -276,6 +276,11 @@ struct amdgpu_vm {
 	/* BOs which are invalidated, has been updated in the PTs */
 	struct list_head        done;
 
+	/* PT BOs scheduled to free and fill with zero if vm_resv is not hold */
+	struct list_head	bo_freed;
+	struct work_struct	bo_free_work;
+	spinlock_t		bo_free_lock;
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
index 88de9f0d4728..12471ef126a9 100644
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
+		spin_lock(&entry->vm->bo_free_lock);
+		list_move(&entry->vm_status, &entry->vm->bo_freed);
+		spin_unlock(&entry->vm->bo_free_lock);
+
+		schedule_work(&entry->vm->bo_free_work);
+		return;
+	}
+
 	shadow = amdgpu_bo_shadowed(entry->bo);
 	if (shadow) {
 		ttm_bo_set_bulk_move(&shadow->tbo, NULL);
@@ -641,6 +651,33 @@ static void amdgpu_vm_pt_free(struct amdgpu_vm_bo_base *entry)
 	amdgpu_bo_unref(&entry->bo);
 }
 
+void amdgpu_vm_pt_free_work(struct work_struct *work)
+{
+	struct amdgpu_vm_bo_base *entry;
+	struct amdgpu_vm *vm;
+	struct amdgpu_bo *root;
+
+	vm = container_of(work, struct amdgpu_vm, bo_free_work);
+
+	root = amdgpu_bo_ref(vm->root.bo);
+	amdgpu_bo_reserve(root, true);
+
+	spin_lock(&vm->bo_free_lock);
+	while (!list_empty(&vm->bo_freed)) {
+		entry = list_first_entry(&vm->bo_freed, struct amdgpu_vm_bo_base,
+					 vm_status);
+		spin_unlock(&vm->bo_free_lock);
+
+		amdgpu_vm_pt_free(entry, false);
+
+		spin_lock(&vm->bo_free_lock);
+	}
+	spin_unlock(&vm->bo_free_lock);
+
+	amdgpu_bo_unreserve(root);
+	amdgpu_bo_unref(&root);
+}
+
 /**
  * amdgpu_vm_pt_free_dfs - free PD/PT levels
  *
@@ -652,16 +689,17 @@ static void amdgpu_vm_pt_free(struct amdgpu_vm_bo_base *entry)
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
@@ -673,7 +711,7 @@ static void amdgpu_vm_pt_free_dfs(struct amdgpu_device *adev,
  */
 void amdgpu_vm_pt_free_root(struct amdgpu_device *adev, struct amdgpu_vm *vm)
 {
-	amdgpu_vm_pt_free_dfs(adev, vm, NULL);
+	amdgpu_vm_pt_free_dfs(adev, vm, NULL, false);
 }
 
 /**
@@ -966,7 +1004,8 @@ int amdgpu_vm_ptes_update(struct amdgpu_vm_update_params *params,
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

