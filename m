Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA325ECAAD3
	for <amd-gfx@archiver.kernel.org>; Wed, 14 Sep 2022 16:09:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3633F10E967;
	Wed, 14 Sep 2022 16:09:22 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2088.outbound.protection.outlook.com [40.107.100.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A88DC10E96A
 for <amd-gfx@lists.freedesktop.org>; Wed, 14 Sep 2022 16:09:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kM5oxvhw/3YGMbt2+3IBek5X/5BvyPK7aO3YyCMUKTgwdzKGbqJ+5uEiJ1jO9MnIyNsEgVVnTXl4M72IAbqeUG4DyxQl17Wa8vcRu0kJ5X1QqHHqcoc8Omhhu0lYsHPv9Hnm2go0sdXP259KReRbKBGTX6B5WPsDiu6+03tgIMSHqEYfIoREWYGmjfj/Q+9ja18rbQjS4XdtdkqFVIjI3h1KeHZvtUFXfbUopcOLVCCE4DMjuDCWlADoUtA+RFxFLaO3RIMb+HVxyhIYLva/lL23IFqHM7dCpjJb7ow3iVTcMnVJvbjligkPR/mO/I3e8pWC4d4yBvl+6yKj34VMIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N1sCPPKV8H4HSiGWCZ6P/hiWZ0EjrvNCVr//Hm+jzrY=;
 b=XBP+xd01antMOJ9jsBSxWQvVhOINWTJD5TroESPsIVA34GZE/9dLrCc1yTLuJlKzHGEty0xMNeRP7GOhOuXsty64VCQfR1ucNN4SgSTcYO/j2S5amuqbAefnRLLuJgN0yF1dDBrySH/VvaY+UzFSwZhCXLReVecJ2PEjBUAUTIjd36K24pL2szVCrr4VdpqEJOXc5fIAXbuiQ95ez/U7E6ojQvEYF/vmn9c5x4LolbMyGOYL4qhIoHs6SLr68O49hIquyyVlsvATGwFfpudEpg/zmH0FB8FpynOtPwCoxm5g5Wkcf6yPs19jy5p642K4+Bybqhg5naUu3cuSRNeWNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N1sCPPKV8H4HSiGWCZ6P/hiWZ0EjrvNCVr//Hm+jzrY=;
 b=pcrQch6/kDa+9mDYu5nRseuDhXl4Qm4LzjIpxosIhOdaFKSvKjSfiR6kC7UZdmDU350k0twmVB07gqeJJVfx4EWGa6pWW48FL4bV1mdVRBuhSWeB+bTYBCXj9lP0oYme1DzweAmzdcDviw8n5Ot3vzV7PSFxc3W5fO8PjzWCyII=
Received: from BN9PR03CA0045.namprd03.prod.outlook.com (2603:10b6:408:fb::20)
 by MN2PR12MB4334.namprd12.prod.outlook.com (2603:10b6:208:1d1::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.23; Wed, 14 Sep
 2022 16:09:12 +0000
Received: from BN8NAM11FT051.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:fb:cafe::c3) by BN9PR03CA0045.outlook.office365.com
 (2603:10b6:408:fb::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.14 via Frontend
 Transport; Wed, 14 Sep 2022 16:09:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT051.mail.protection.outlook.com (10.13.177.66) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5632.12 via Frontend Transport; Wed, 14 Sep 2022 16:09:12 +0000
Received: from Philip-Dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Wed, 14 Sep
 2022 11:09:06 -0500
From: Philip Yang <Philip.Yang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v5 1/1] drm/amdgpu: Fix amdgpu_vm_pt_free warning
Date: Wed, 14 Sep 2022 12:08:42 -0400
Message-ID: <20220914160842.9610-1-Philip.Yang@amd.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT051:EE_|MN2PR12MB4334:EE_
X-MS-Office365-Filtering-Correlation-Id: af67c74a-479e-468d-217a-08da966b76a0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +RCXHMdN05BzCkN46S20NlNvIxiF6Syk9BMTYxi7THPGaLQNXne949rXkDdNMCzICe1a/n8FPKsq28MPyDv4h/zkU3EARsyDb+fqQe8fyvQ5RDDm3VEdVsRLojMYr9LUde5V8RLTDOmRsotwtQYWccrl9U6ji8T0Ds7J0TQyWQc++JpEfOaGh6cf6R3pQY8UrVTkELKFlYO8+lrlgQIGi+NUI0Vb7admdpmiDFop1ddrYnpSnvi2RM6ILKjQQVSUuxAy6mwtj/B0t9BK/H3icuhU57AGDCMYN41KxRhfI+/+PJotPm5pjWFhsA1spNXHC4U29PqUdk1DpmdIfJKcZeJ7xsb2G7dn9x6upRm6BpjIinkiTVtS4gAWREFwcjOtRTtdACMGjI1FE/dyFyu5eBmBcsoHRE8vAqv7gT3Rfqr3JyirWEuV6kMOm22ImRkKhxfsBWxHy06EOew//2cB2SZFknd/wINjygJyXLAvcTxuqHirIQreAcxpEyC3B24CYF7c7uDZuUQAj0lERy58bDSqNYkBZ04SXfgiSvm/uKf6puKfn4Vp8HaKF364/2QbfPzpOpVLN87ewK0eBy9hmFtfTxNPaZedVamAUcnQ9s5NF8zRlIuGj0dJd0tIkOjBObesVuesDMlXw5LJd+UrHukudzNl24XwIr710c8BHjqnKYQgv65hBdWNAVATRQteAh4eLzD8NNT+FJUAvtXaZf44n8r8YC+oIUpxRdfJh407SdqHvKtqrYFd9mdORDyLvQVNhlmImQ8kC6XBZ83TCt5wfZgZjz5AzdZAsQ+aiZY=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(396003)(376002)(346002)(136003)(39860400002)(451199015)(36840700001)(40470700004)(46966006)(6666004)(41300700001)(478600001)(2616005)(336012)(1076003)(83380400001)(16526019)(426003)(186003)(26005)(7696005)(2906002)(40460700003)(47076005)(82310400005)(40480700001)(8676002)(4326008)(5660300002)(6916009)(316002)(54906003)(8936002)(70586007)(70206006)(36860700001)(82740400003)(356005)(81166007)(86362001)(36756003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2022 16:09:12.1594 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: af67c74a-479e-468d-217a-08da966b76a0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT051.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4334
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
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c    |  5 +++
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h    |  6 ++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c | 41 +++++++++++++++++++++--
 3 files changed, 49 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index 59cac347baa3..20cfc8c9635b 100644
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
@@ -2223,6 +2226,8 @@ void amdgpu_vm_fini(struct amdgpu_device *adev, struct amdgpu_vm *vm)
 
 	amdgpu_amdkfd_gpuvm_destroy_cb(adev, vm);
 
+	flush_work(&vm->pt_free_work);
+
 	root = amdgpu_bo_ref(vm->root.bo);
 	amdgpu_bo_reserve(root, true);
 	amdgpu_vm_set_pasid(adev, vm, 0);
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
index 88de9f0d4728..c16579471f22 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
@@ -641,6 +641,27 @@ static void amdgpu_vm_pt_free(struct amdgpu_vm_bo_base *entry)
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
+	spin_lock(&vm->pt_free_lock);
+	list_splice_init(&vm->pt_freed, &pt_freed);
+	spin_unlock(&vm->pt_free_lock);
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
@@ -652,11 +673,24 @@ static void amdgpu_vm_pt_free(struct amdgpu_vm_bo_base *entry)
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
+		spin_lock(&vm->pt_free_lock);
+		for_each_amdgpu_vm_pt_dfs_safe(adev, vm, start, cursor, entry)
+			list_move(&entry->vm_status, &vm->pt_freed);
+
+		if (start)
+			list_move(&start->entry->vm_status, &vm->pt_freed);
+		spin_unlock(&vm->pt_free_lock);
+		schedule_work(&vm->pt_free_work);
+		return;
+	}
+
 	for_each_amdgpu_vm_pt_dfs_safe(adev, vm, start, cursor, entry)
 		amdgpu_vm_pt_free(entry);
 
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

