Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0DD1C54EE9
	for <amd-gfx@archiver.kernel.org>; Mon, 19 Sep 2022 17:16:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1B64710E12E;
	Mon, 19 Sep 2022 17:16:55 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2053.outbound.protection.outlook.com [40.107.244.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0CF7010E05F
 for <amd-gfx@lists.freedesktop.org>; Mon, 19 Sep 2022 17:16:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C/Fq0ZBLlnBhw8Y7HnAdP1EEWVwJdy9PA1kItjCy8cuIjbRvN7sFiQIzpnzuuVhp2ZlrhZ95oKr20SHIgHBtZSu+0G9d41sniFqp2yrppW3xvK153W9xul9YvzFL80QejlnxXDKBgZqkHx2AnqFUfqOV3EyVc1PzubznTNgGYTzVFYKUQQDuDzxn1EJjwBZ58AVA7bqflsPMzucKZxV08nRzZGcceJvKoXRJi/RfydZmPl4qkBfBrDj1TMdQjjgI6k50A2tdq1z6kW/CoDa7oci8YIQqWyZt4c3mcsNodml1JbXdpNamBXyYPHAU7+Qu0hQc4pYqTgBZQ/toyVrqkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LaxvHvR/Co4AMD8C6F1BTH867Yu1UwiExffrMqiPt8Q=;
 b=bsKbSQXonGnA4PuKfmhlPqfeudg6+yPcsRfFJA3hEWKpUmoeouoF10YybGjL29z98Wk0db8gqQHwiZuw2xkKEPEV0Z/ayrf1CEs5psGo9D6cSsiYNd15eHn3Vlm8wQAnZrG3cOaZu7e0EWMrFuIbTIUHerk0ldUP9V9AxxavARmfEBrF/04AX+thYAnwFwFJfoDEGvk30nPhnFoqj6BQ2gxgnc7a8KqwkrdzjglKL74mWcJMbMmupt72lB7eraPj2loq4lkP0PSu/PUKxNSdhRlBuqzap/AVHHYmfZ57sAP2vWY7jB8/Z5gB16KIGxtYMN9Ntzl6n2cSWu7xf3tpJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LaxvHvR/Co4AMD8C6F1BTH867Yu1UwiExffrMqiPt8Q=;
 b=AGxjcGM9+7VJICOv90871kcaV2HyWS6gyq8EjzjEQvPSMgOZPckXr0BQH1jfITMvSq6xzCjLEtKXQtHYaSP8H5ESw6CE/pHczcaFfMvhv3TGC8itPBLH7H61ByU5Mu8Qr1Yku758skAsg+P5zd557hlNYITX1Z8bvR5pS57+vBU=
Received: from DS7PR03CA0355.namprd03.prod.outlook.com (2603:10b6:8:55::30) by
 SA1PR12MB7037.namprd12.prod.outlook.com (2603:10b6:806:24c::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.22; Mon, 19 Sep
 2022 17:16:28 +0000
Received: from DM6NAM11FT080.eop-nam11.prod.protection.outlook.com
 (2603:10b6:8:55:cafe::84) by DS7PR03CA0355.outlook.office365.com
 (2603:10b6:8:55::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.21 via Frontend
 Transport; Mon, 19 Sep 2022 17:16:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT080.mail.protection.outlook.com (10.13.173.105) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5632.12 via Frontend Transport; Mon, 19 Sep 2022 17:16:28 +0000
Received: from Philip-Dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Mon, 19 Sep
 2022 12:16:26 -0500
From: Philip Yang <Philip.Yang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v2 7/7] drm/amdgpu: Fix amdgpu_vm_pt_free warning
Date: Mon, 19 Sep 2022 13:15:53 -0400
Message-ID: <20220919171553.11286-8-Philip.Yang@amd.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220919171553.11286-1-Philip.Yang@amd.com>
References: <20220919171553.11286-1-Philip.Yang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT080:EE_|SA1PR12MB7037:EE_
X-MS-Office365-Filtering-Correlation-Id: d553f612-885a-4292-7d5a-08da9a62b04c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Wg/KvlzzW+DmctLsVrLQqUogICMAlcKZbw1RMVVgm0SawVrnt9qtKAI7j9Qv2nfcXdBAGPohnSQfApkcgYuW5bBheRrayAVch6mPv2Ce3m/l+5UOHrwxoBydLQE+36gOEgiXcXS9NsWxN6kJuUIBkyQ9VneTQsLq6YCJixmvqE8kiaVf52aMjj5uNqsYzMwDDSiR7QySjKFRtcQWf4ohARpdwdpLpLri6xQToNsraq1XtPXQUD/KmNflIN+arMyIceP8gfxDJB/ScBSw5Msof/QOGUfcRj59IjsmYIkjrnx+Jv2uojjl2IYJC+1LDIRTzuMtqTANC8h0SUbhvyN7rQkCCNpM4rTvKq81gjkv5AVNOGpgD4Jy9IPwtMp10jwZgij8/uZXl0Ta4CaOZe1vhLqrvLRgy+jUZwwsczOVIiDwq67RHJZzxIPx/PmED+4k+pMobXx6gnHHDfCcHB80Nj9AmvsT7LmnWpH+NApRttvBHHbzqZLnj6aU0GAMkF9e7YoLjgP2ZVUnE022xjVZbRZJ8cng0WpQ0zXR2HqEdYdLiAsfks0yThQXSUkRIv8jPwimzB/3L4Jptm28RSTUPqmPT0KZzBcI5XArVJcips8adSCL3PeVl79MN/rDSg/N2lIdf6ck3iqUM+B34F5sWgN+IX2JTcdPr0JtkkKVECX7/T6tS1eni0rmWL399bl1AWqokZdEexhmebMlmjzEuIjHOMLsoLfYpRxlAnBFaL7SLhOfdUakgqXl7fcpLD/+NMktLx4JW5qiftrsfhxqTcqrNyLHcKNXXZL7ZZGzt/Q=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(136003)(39860400002)(346002)(396003)(376002)(451199015)(36840700001)(40470700004)(46966006)(186003)(356005)(6916009)(54906003)(316002)(36756003)(82740400003)(41300700001)(36860700001)(5660300002)(426003)(81166007)(47076005)(70206006)(2616005)(8936002)(83380400001)(70586007)(1076003)(16526019)(86362001)(6666004)(2906002)(8676002)(478600001)(40460700003)(4326008)(7696005)(336012)(82310400005)(26005)(40480700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2022 17:16:28.0684 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d553f612-885a-4292-7d5a-08da9a62b04c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT080.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7037
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
index b2e96682b9bb..83b0c5d86e48 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -2055,6 +2055,8 @@ int amdgpu_vm_init(struct amdgpu_device *adev, struct amdgpu_vm *vm)
 	spin_lock_init(&vm->status_lock);
 	INIT_LIST_HEAD(&vm->freed);
 	INIT_LIST_HEAD(&vm->done);
+	INIT_LIST_HEAD(&vm->pt_freed);
+	INIT_WORK(&vm->pt_free_work, amdgpu_vm_pt_free_work);
 
 	/* create scheduler entities for page table updates */
 	r = drm_sched_entity_init(&vm->immediate, DRM_SCHED_PRIORITY_NORMAL,
@@ -2256,6 +2258,8 @@ void amdgpu_vm_fini(struct amdgpu_device *adev, struct amdgpu_vm *vm)
 
 	amdgpu_amdkfd_gpuvm_destroy_cb(adev, vm);
 
+	flush_work(&vm->pt_free_work);
+
 	root = amdgpu_bo_ref(vm->root.bo);
 	amdgpu_bo_reserve(root, true);
 	amdgpu_vm_set_pasid(adev, vm, 0);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
index e6dd112d865c..83acb7bd80fe 100644
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
index 61a4b7182d44..358b91243e37 100644
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
+	/* flush_work in amdgpu_vm_fini ensure vm->root.bo is valid. */
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

