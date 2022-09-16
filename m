Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA95EECAAA1
	for <amd-gfx@archiver.kernel.org>; Fri, 16 Sep 2022 15:05:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0E6BB10ED74;
	Fri, 16 Sep 2022 15:05:44 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2065.outbound.protection.outlook.com [40.107.92.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CB56910ED72
 for <amd-gfx@lists.freedesktop.org>; Fri, 16 Sep 2022 15:05:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SlIARFjhxUyhYw652mxDx4McOavGA+E6ZyRynhOsKSlcoAqCYuhcghdmNDMXu87bBhl6XDGoyZGEcXkNKU3zq4gncSpWORyT7ux68m09UFRLS+l+GvcKALZ6nZmAG85hoMX3+RCNOHi4mjYVl64IbMWbxngvwZC+MmenFSYWU0QoLthxzsD/zqAEcbXAqYqltcNzR8G+QvsKaoGqA6QkNlINOpdjaYe3aQuaUHqvmYvyBce9LUJvjo6Qx+IG3/va8305gemV0DQUg5F4yHlrEwaZDiCQDbpUWdDMa1i18fSgoldL7scalYFce3GBOnpKZqYALMt8qCun3E8QOZOISw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MwpQv3OizU+i+Gpz04X+YVQsyV/YZrDNIpP+HT8ApqI=;
 b=AgE96Ofp7ME9/E+J6Ntp64pSnVAbp1wv+Dzjf1bb1uI9x6LfWEwHtgM5gWd70trSGUC/2QS5t6Yx7AbaTq0IQNLHeINA5YnRn5fi9UCAbmtLd9UYWwrkfRhbbnxWFc/hgGmjgF0UmN7rBLzUrhSj0slrK5PRnVi5jsNjTubqdSHnrD6vKVEMhLv8f3fvoC5k6qDJh4s2F6+1hm164uzXWgV1/UW5Iq5TP+uc/zifKkPOV/uQQnOZQhRoLdywGaD8vNaxgFAflarggMfrhTTWcOxpihzTHzRIOw1qkchXhX01TQtNm2Iqubhw7o6mPp7B0uef5NwsDpmJc+p/naDgoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MwpQv3OizU+i+Gpz04X+YVQsyV/YZrDNIpP+HT8ApqI=;
 b=z2M2AQekGy5uYyH4agKaCaQdwLQ/dg2yLbnDGfUJqQQGMWb8j2ZGQPHFxpZaMPAmrEqLb5mmnC2X2KEs31T8ZjX+671Lv8iKXnRVO/Y+vuT9zipvD1yGhPQUBZvAneTJx+2PHqSW6REpWzpK8u2dKrG21eEZxpTLbrdotUgPK80=
Received: from BN9PR03CA0120.namprd03.prod.outlook.com (2603:10b6:408:fd::35)
 by CY8PR12MB7516.namprd12.prod.outlook.com (2603:10b6:930:94::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.22; Fri, 16 Sep
 2022 15:05:28 +0000
Received: from BN8NAM11FT074.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:fd:cafe::5b) by BN9PR03CA0120.outlook.office365.com
 (2603:10b6:408:fd::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.16 via Frontend
 Transport; Fri, 16 Sep 2022 15:05:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT074.mail.protection.outlook.com (10.13.176.154) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5632.12 via Frontend Transport; Fri, 16 Sep 2022 15:05:27 +0000
Received: from Philip-Dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Fri, 16 Sep
 2022 10:05:26 -0500
From: Philip Yang <Philip.Yang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 7/7] drm/amdgpu: Fix amdgpu_vm_pt_free warning
Date: Fri, 16 Sep 2022 11:05:10 -0400
Message-ID: <20220916150510.31321-8-Philip.Yang@amd.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220916150510.31321-1-Philip.Yang@amd.com>
References: <20220916150510.31321-1-Philip.Yang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT074:EE_|CY8PR12MB7516:EE_
X-MS-Office365-Filtering-Correlation-Id: 4cd88699-1262-475e-bea1-08da97f4e3ff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7CCOhMF0kLg+eoJU03ECUZr+cIcztPEq1+fEftbE8kqLKg79P7KimCEiOKOW81gVhyzaxZgUQtBRR/ljxmwtq3m2ZCD4FtQOx4PqZcuXs1qqkRVrmqbqUChg42F0kRSQX4hjlYkXUtWuO0G7jHpb+wMg4bLSctU2v3PlPZNhbJeO7VEA30oAnCTgcSJd1f+smYf4PGgpjTP/Ajgp+bkAQTLc+Jh//RS9ZqoUw79SKOGccMC27wl0IBm014mLEvSurQ/MNHQXdTTgT36wyUCkytyIrRa/42ZJga9Un+BCmuctDUnEEsp0vqhEoBDEEMK1hku3loIszD7w01dnRybTLg1bvDxkxG7fhQMzx8Yp67yV9WLC6bJRVLM/0c4ppcR9oeo+jxYDWv7nFEQgOZrTEydim/MH8Uvp4XG6OmOPLyau+OU5LrrtMCPBUBnjAy7IaCLCsGrNTLrDhvEE8v58Hy7VW2JLYHv58wJ0pegD5bEx8QUYm4WNYtyLIqtzotbw6zhWJdGF2/MdrM8QtYtv1M6GWKENYo2XSDtV3z3Nd4tTY7eIRiDkXxGaOH6fm/lvX4tP8Ue9euv+SK/LxS506+StfG1NszOrqvUDfuBUeuRxBg0T22IbxDXcCfKkVhpGJdK73Grc7e1UmWtHIfOlBM+qRPgwpPjbSqFPoseo3/1/4XqrVrevofg8r0MXwKRlt8YC2DL+aX6DPJQLr/iRCI8xcHXsW1epjGvfNLWYzUYrmZ5VtG30DUKL69je/riAWQ2nh9XOK7V5HE0+h/elcjsrwPu92ySSABvCBkMCUUA=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(396003)(376002)(136003)(346002)(39860400002)(451199015)(46966006)(40470700004)(36840700001)(82740400003)(54906003)(6666004)(82310400005)(336012)(70206006)(478600001)(186003)(8676002)(1076003)(7696005)(40480700001)(47076005)(5660300002)(36756003)(4326008)(83380400001)(26005)(81166007)(2906002)(8936002)(40460700003)(36860700001)(41300700001)(2616005)(6916009)(70586007)(16526019)(356005)(86362001)(316002)(426003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2022 15:05:27.7787 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4cd88699-1262-475e-bea1-08da97f4e3ff
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT074.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7516
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
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c    |  4 +++
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h    |  5 +++
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c | 41 +++++++++++++++++++++--
 3 files changed, 47 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index 9d7f9b3670d7..3402fb62b4ae 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -2057,6 +2057,8 @@ int amdgpu_vm_init(struct amdgpu_device *adev, struct amdgpu_vm *vm)
 	spin_lock_init(&vm->status_lock);
 	INIT_LIST_HEAD(&vm->freed);
 	INIT_LIST_HEAD(&vm->done);
+	INIT_LIST_HEAD(&vm->pt_freed);
+	INIT_WORK(&vm->pt_free_work, amdgpu_vm_pt_free_work);
 
 	/* create scheduler entities for page table updates */
 	r = drm_sched_entity_init(&vm->immediate, DRM_SCHED_PRIORITY_NORMAL,
@@ -2258,6 +2260,8 @@ void amdgpu_vm_fini(struct amdgpu_device *adev, struct amdgpu_vm *vm)
 
 	amdgpu_amdkfd_gpuvm_destroy_cb(adev, vm);
 
+	flush_work(&vm->pt_free_work);
+
 	root = amdgpu_bo_ref(vm->root.bo);
 	amdgpu_bo_reserve(root, true);
 	amdgpu_vm_set_pasid(adev, vm, 0);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
index 98895c8fef6c..2275c692d1ca 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
@@ -278,6 +278,10 @@ struct amdgpu_vm {
 	/* BOs which are invalidated, has been updated in the PTs */
 	struct list_head        done;
 
+	/* PT BOs scheduled to free and fill with zero if vm_resv is not hold */
+	struct list_head	pt_freed;
+	struct work_struct	pt_free_work;
+
 	/* contains the page directory */
 	struct amdgpu_vm_bo_base     root;
 	struct dma_fence	*last_update;
@@ -473,6 +477,7 @@ int amdgpu_vm_pde_update(struct amdgpu_vm_update_params *params,
 int amdgpu_vm_ptes_update(struct amdgpu_vm_update_params *params,
 			  uint64_t start, uint64_t end,
 			  uint64_t dst, uint64_t flags);
+void amdgpu_vm_pt_free_work(struct work_struct *work);
 
 #if defined(CONFIG_DEBUG_FS)
 void amdgpu_debugfs_vm_bo_info(struct amdgpu_vm *vm, struct seq_file *m);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
index 61a4b7182d44..25277380ef5f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
@@ -644,6 +644,27 @@ static void amdgpu_vm_pt_free(struct amdgpu_vm_bo_base *entry)
 	amdgpu_bo_unref(&entry->bo);
 }
 
+void amdgpu_vm_pt_free_work(struct work_struct *work)
+{
+	struct amdgpu_vm_bo_base *entry, *next;
+	struct amdgpu_vm *vm;
+	LIST_HEAD(pt_freed);
+
+	vm = container_of(work, struct amdgpu_vm, pt_free_work);
+
+	spin_lock(&vm->status_lock);
+	list_splice_init(&vm->pt_freed, &pt_freed);
+	spin_unlock(&vm->status_lock);
+
+	// flush_work in amdgpu_vm_fini ensure vm->root.bo is valid
+	amdgpu_bo_reserve(vm->root.bo, true);
+
+	list_for_each_entry_safe(entry, next, &pt_freed, vm_status)
+		amdgpu_vm_pt_free(entry);
+
+	amdgpu_bo_unreserve(vm->root.bo);
+}
+
 /**
  * amdgpu_vm_pt_free_dfs - free PD/PT levels
  *
@@ -655,11 +676,24 @@ static void amdgpu_vm_pt_free(struct amdgpu_vm_bo_base *entry)
  */
 static void amdgpu_vm_pt_free_dfs(struct amdgpu_device *adev,
 				  struct amdgpu_vm *vm,
-				  struct amdgpu_vm_pt_cursor *start)
+				  struct amdgpu_vm_pt_cursor *start,
+				  bool unlocked)
 {
 	struct amdgpu_vm_pt_cursor cursor;
 	struct amdgpu_vm_bo_base *entry;
 
+	if (unlocked) {
+		spin_lock(&vm->status_lock);
+		for_each_amdgpu_vm_pt_dfs_safe(adev, vm, start, cursor, entry)
+			list_move(&entry->vm_status, &vm->pt_freed);
+
+		if (start)
+			list_move(&start->entry->vm_status, &vm->pt_freed);
+		spin_unlock(&vm->status_lock);
+		schedule_work(&vm->pt_free_work);
+		return;
+	}
+
 	for_each_amdgpu_vm_pt_dfs_safe(adev, vm, start, cursor, entry)
 		amdgpu_vm_pt_free(entry);
 
@@ -676,7 +710,7 @@ static void amdgpu_vm_pt_free_dfs(struct amdgpu_device *adev,
  */
 void amdgpu_vm_pt_free_root(struct amdgpu_device *adev, struct amdgpu_vm *vm)
 {
-	amdgpu_vm_pt_free_dfs(adev, vm, NULL);
+	amdgpu_vm_pt_free_dfs(adev, vm, NULL, false);
 }
 
 /**
@@ -969,7 +1003,8 @@ int amdgpu_vm_ptes_update(struct amdgpu_vm_update_params *params,
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

