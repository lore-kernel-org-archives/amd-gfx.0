Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDE26C54EE9
	for <amd-gfx@archiver.kernel.org>; Tue, 13 Sep 2022 20:05:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B016410E430;
	Tue, 13 Sep 2022 20:05:43 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2058.outbound.protection.outlook.com [40.107.92.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 28D9310E44A
 for <amd-gfx@lists.freedesktop.org>; Tue, 13 Sep 2022 20:05:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QU5YKqYQfgxARJFevp8ZagS4tPrb14CzLK9sEwfeI3AkJA0FHMLE/ncAU3l/cTglbYuHgci5Zl1tsIXR6I3cnXnFIm4a9stptfLak83eJ0cYKXUftzWxPwbBENyvZ0VzK9431u4oo2d+DsYD3LR3AyHL8iydES5aiOaQxOgw8fXwZcEgkim4skKqPgy9lwMh2nrvDFfAf8U+n0z/Vj/HWuhACuJDfEl93S1DpVmCJGJkmkrsVLsiXvT8ZqzSnAs8k0qWrZCIauFgmP+hXIHIWUjSMJVjbTu3A9JzdWTQn7Ifnmrhf94A/gildGg6gpsPbU7Iz4UjGnYkrKmoKjvrBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0E5cdQO05o36hoSiWbPi9OE2w+hQFPsIgLp0djis8sw=;
 b=YQGvwfiR0G8x6VsjG5wZzYwutU8Ra4DyJ3BHYWe+wZGhw5dhdnV4vDtrfd0eoThs/oriolpqbZHfgTrySPfgcUdj7+rkrXt15nb7tcF18mYu1GVPEwqIYlTmuasxEDDMCV3SNcCiOdebm1BwQWRpgzfV3eMS3IWeXGVnDFdZ29XTWqVAhw5OwsQxHrMiMgtv3SaYTjCxRqXUVB7tDw9PiqLz1PiGtJbskj8uBvThN2GwM2w97l0cOOpsrvEHIxkL6dzDhl7cTDvmiXJF6W5SRHnaJOQGc50JF5ljlY9TbryJb9iYGVUD/hDcwNoxeuzxbTC1XVKxW15VYtlbauOeGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0E5cdQO05o36hoSiWbPi9OE2w+hQFPsIgLp0djis8sw=;
 b=4kLdS+zaM0ww66iQOtT+ZlupZ1ReMq9SbUJVz+F5bN7BTsy7VaXijYQGGK7Q2nX1+salC0SKJYL3Ibq2mYRm4Lsdx4YdJuVs8tystlrm3eOF6k2pUvuLYdtsU9uFDxv45VMBNCyws3cOTHaV6stMlQs+VAslXYN295H6C6bcAhM=
Received: from MW4PR03CA0323.namprd03.prod.outlook.com (2603:10b6:303:dd::28)
 by SA0PR12MB4352.namprd12.prod.outlook.com (2603:10b6:806:9c::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.14; Tue, 13 Sep
 2022 20:05:33 +0000
Received: from CO1NAM11FT033.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:dd:cafe::bf) by MW4PR03CA0323.outlook.office365.com
 (2603:10b6:303:dd::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.12 via Frontend
 Transport; Tue, 13 Sep 2022 20:05:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT033.mail.protection.outlook.com (10.13.174.247) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5632.12 via Frontend Transport; Tue, 13 Sep 2022 20:05:33 +0000
Received: from Philip-Dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Tue, 13 Sep
 2022 15:05:31 -0500
From: Philip Yang <Philip.Yang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v4 1/2] drm/amdgpu: Fix amdgpu_vm_pt_free warning
Date: Tue, 13 Sep 2022 16:05:06 -0400
Message-ID: <20220913200507.8849-1-Philip.Yang@amd.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT033:EE_|SA0PR12MB4352:EE_
X-MS-Office365-Filtering-Correlation-Id: efedf473-d954-4571-c268-08da95c350ce
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CIymdBjCG3o4MOWVphMQa/r4JhDd1a5oxQBcAWrfAe19F5ghxiT7gJq50DZ3NGDR1zd8qPgbxvQ+5etlLw3AG59Tlu1vtzf8nk2LBUywAOPLePqBiXu9vvNSWALugNWWslmqtsKJxItQ4yOP9FqZoqnI0k4dF4duwPnVSzW77HWzKApEYrnadV4frqqqDsgsgO2RMFJW90aMjiG/wLFWMf4fVedVqikV/kgDaW+cPAJ1kh+w2kJs+gqKJKWTy46qymXg+PrGlEGeCAbSq3w9G/RRN4yQGVuhj9fag4aPAmG0ic3l11LAiDEObNDbXYoFz+E6XVFjDNBNWM20Ehconn+sJSKGNpskf2FO+elxXeB8eTRrcpJE2Vnq8BNSVipINF0lzX6+wV+6Cg+7svr+oxoXTjKdS9Z0EtTAMnoKH3wWHWwfCVzGWRVBLKuJsWRmN8eWhlaozh+bIq5QJEqnajfayUn/dQsckgEfPQ+BY3TuhUH6a1S3y2SfxBdMcZKyBImYgIqUXlDOoMdL87Y2rZ2/LBgI40deAvBNuahc4cX0UVYObPQi7mAIplMqUF/TfnnhZawGss1JWsj6HoartB3OjQMo9mtos7goheTS4kDcyGr2nGZCVB95Q+5sjRzi2/NW0pZtTZ4z0R3hY5GulyaQdDMN5AasCuYpBu5C3gzrLncDl8ifwzckPqADYXbF74dECp5r4QLMkCcgKDlPW1+qQmlqGkhYdqmSXBLlKTjyg8MgbwXgNqfEyuBqHeVrnQNAvI+haRm5GMW+En7LaOoDF6ke4hJJP3nUYphM+9Q=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(346002)(376002)(396003)(136003)(39860400002)(451199015)(46966006)(36840700001)(40470700004)(16526019)(426003)(82740400003)(336012)(26005)(7696005)(83380400001)(40480700001)(316002)(54906003)(6916009)(47076005)(36756003)(4326008)(186003)(40460700003)(70586007)(8676002)(86362001)(36860700001)(5660300002)(8936002)(82310400005)(6666004)(478600001)(41300700001)(70206006)(2906002)(2616005)(81166007)(356005)(1076003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Sep 2022 20:05:33.1360 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: efedf473-d954-4571-c268-08da95c350ce
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT033.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4352
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

