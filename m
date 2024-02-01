Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61BE4C4828D
	for <amd-gfx@archiver.kernel.org>; Thu,  1 Feb 2024 16:51:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DA3BB10F26C;
	Thu,  1 Feb 2024 16:51:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="vO879Xcg";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2088.outbound.protection.outlook.com [40.107.243.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2BC0810F26C
 for <amd-gfx@lists.freedesktop.org>; Thu,  1 Feb 2024 16:50:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EDAnt+G0qE2XxuQSbwene+e2vRc7GNLXcsDitN5DOHRAMJzib9D+SgrgI8bXndUx1W69hQRstADbEYlKNzblogctVFkLw24PphwcHQlkn18Cdq5XAgoK0wO28XhuUEM4clUJJX5t1qbHzDUm7/tg9vobLzwfF6AdaUT0dV5B/1lIaodZf15hdn7e9twIaHbU1oGl6OlAwsy9Ugi88nan0eaCQ5ofUgrTpIzFhdFQikRp38S/XGbAU8d1H9PFRFVrkhSKJaWvB7Gc25G6ItymvFb0Zkv+AVdqOwOZHeBkruQcbHk3TEViCtVfl0JfKM6QeJr9ElKU4aL4dr6S4OBqfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lwsSgxMw+b3RfRvDhjKV3qKdvJ5vMUOtO2eMD2awckY=;
 b=ed3+jEe182skd5YgJmcmDFs/y1//HfbfXkUYOhPCQzSgpl/hTB1mizZgATT4PPqRPH35jouDUSR5pJ5Po7c9xWEA17JwsoB+b7rFIH5WMouSVYFHvU8p2wZTPO8PgTP2zwaDRRvED2138yEh6Bx8eBFOUZLkXRX+nAMArMdCtK19GZOIA1cbxM+V72gVgKv/K64gJCvGH1BYNr3+nCoI+m3nESnAiQYQsHLDNqCUudmEXhtG/oD0CCDcVC+QN6PyMF4gbjlAunU73URiNXeeFbj7gh2GqmhyhcBSAdgEqLNJ/zuDGeka3MOiXiNU9Q4XC3IDs83mecWCS+iFb45G6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lwsSgxMw+b3RfRvDhjKV3qKdvJ5vMUOtO2eMD2awckY=;
 b=vO879XcgruqMio/a1PrgcPHpMOyw0DNncllxy9qtOoYWQ8pdrX2qvLO9hYdmYcbYZRiYgyzZiRXlG81F9cefodSvbZ3G8lEKw0Tun/tQHQXhPA+82Uk96C7EdI+VmZOkqLLlRrYvajr4vJsr1jgCuwY9iWJaz8spZjwdCSprw7c=
Received: from SA9P221CA0006.NAMP221.PROD.OUTLOOK.COM (2603:10b6:806:25::11)
 by IA1PR12MB7613.namprd12.prod.outlook.com (2603:10b6:208:42a::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.34; Thu, 1 Feb
 2024 16:50:53 +0000
Received: from SN1PEPF0002636D.namprd02.prod.outlook.com
 (2603:10b6:806:25:cafe::3b) by SA9P221CA0006.outlook.office365.com
 (2603:10b6:806:25::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.26 via Frontend
 Transport; Thu, 1 Feb 2024 16:50:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF0002636D.mail.protection.outlook.com (10.167.241.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7249.19 via Frontend Transport; Thu, 1 Feb 2024 16:50:53 +0000
Received: from Philip-Dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Thu, 1 Feb
 2024 10:50:52 -0600
From: Philip Yang <Philip.Yang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Felix.Kuehling@amd.com>, <christian.koenig@amd.com>, Philip Yang
 <Philip.Yang@amd.com>
Subject: [PATCH 1/2] drm/amdgpu: Unmap only clear the page table leaves
Date: Thu, 1 Feb 2024 11:50:16 -0500
Message-ID: <20240201165017.29789-1-Philip.Yang@amd.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002636D:EE_|IA1PR12MB7613:EE_
X-MS-Office365-Filtering-Correlation-Id: f6253b69-c613-49cb-c50c-08dc2345f3e8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ze6WjV2TlCn6tfcL+/aVhrnede/tI/Jn12Nots0JXF2EeynYY+TTCshZLLb0g+mZwEo3AAaarBAZTz1yIe6nyojBPTAzQ/ffvBbvPhAzyhySOko6qeyEJFk33Oj5elzJRNmkPD/rw37+cvWNG8Vllh26QvC2T4ThQDjZ0J9LfUOFEmFtT9RgVvtCP8IOGqBcSyWIuA4/wkY4MYJEYofC+ywCRH0ygEnpFaWtyIuul/P6GuYHPXinv6/xHURw+BpoSAzpXu7g/q5zQyXjisnmLKl2guATCkQs9/kElUqgdicg7ySGqYLbEECmsXMfo93u7H3aH0U6BL0ZlxZ9FD7CKh4ut9LgoKwTjgroXniact12yH6NmTtIrJmOjhEtKCZpNyjCtBBGIEBuP7Dd4WYHegs0GPRWl0BFehdCGinLKG24h9arYfitBA0/Y9jsNY7s7N8W0z4+9sFOsIenJhPxbPy7xVg0yZcJgO+7PfuC2vHBevV3yyYc6/rwGytgSc9O/W3X4l8LmiATK/O2sj7K8pKIhv4NosDtDz6QOFgBfWUDSbERKnI5+NOZ94ZA88B7Cj7u3nGgaQLc69NuYpiylLbEUUwtZOwsYXznJza3V4x0yB7IfklkQO/cE2gdGvyyXqPYFJ09lLblgMDqNOKAJMAWMjYFc7yOAXp1es2vt2bIfzQSQKlNsPD67Yr8dbR2HuV2BuNYar1Pl35NcBozxW6JH8JVAKbtlaNPl+7cQ+8SFw44/drjE3NINu8p2NHMvGZv1fk3R9Qd4Tzgd+OcgA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(39860400002)(376002)(136003)(346002)(396003)(230922051799003)(1800799012)(64100799003)(186009)(451199024)(82310400011)(40470700004)(36840700001)(46966006)(336012)(47076005)(83380400001)(40480700001)(40460700003)(26005)(16526019)(6666004)(7696005)(82740400003)(2616005)(426003)(1076003)(36860700001)(356005)(81166007)(36756003)(478600001)(4326008)(54906003)(316002)(6916009)(8676002)(8936002)(70586007)(70206006)(41300700001)(2906002)(5660300002)(86362001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Feb 2024 16:50:53.0976 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f6253b69-c613-49cb-c50c-08dc2345f3e8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002636D.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7613
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
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c | 43 ++++++-----------------
 3 files changed, 10 insertions(+), 41 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index 82e5fd66a10d..3bde77dfc63f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -2256,8 +2256,6 @@ int amdgpu_vm_init(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 	spin_lock_init(&vm->status_lock);
 	INIT_LIST_HEAD(&vm->freed);
 	INIT_LIST_HEAD(&vm->done);
-	INIT_LIST_HEAD(&vm->pt_freed);
-	INIT_WORK(&vm->pt_free_work, amdgpu_vm_pt_free_work);
 	INIT_KFIFO(vm->faults);
 
 	r = amdgpu_vm_init_entities(adev, vm);
@@ -2446,8 +2444,6 @@ void amdgpu_vm_fini(struct amdgpu_device *adev, struct amdgpu_vm *vm)
 
 	amdgpu_amdkfd_gpuvm_destroy_cb(adev, vm);
 
-	flush_work(&vm->pt_free_work);
-
 	root = amdgpu_bo_ref(vm->root.bo);
 	amdgpu_bo_reserve(root, true);
 	amdgpu_vm_set_pasid(adev, vm, 0);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
index cdb61f1e7c35..74fe211b9ecd 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
@@ -316,10 +316,6 @@ struct amdgpu_vm {
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
index a160265ddc07..a3d609655ce3 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
@@ -657,27 +657,6 @@ static void amdgpu_vm_pt_free(struct amdgpu_vm_bo_base *entry)
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
  * amdgpu_vm_pt_free_dfs - free PD/PT levels
  *
@@ -696,17 +675,7 @@ static void amdgpu_vm_pt_free_dfs(struct amdgpu_device *adev,
 	struct amdgpu_vm_pt_cursor cursor;
 	struct amdgpu_vm_bo_base *entry;
 
-	if (unlocked) {
-		spin_lock(&vm->status_lock);
-		for_each_amdgpu_vm_pt_dfs_safe(adev, vm, start, cursor, entry)
-			list_move(&entry->vm_status, &vm->pt_freed);
-
-		if (start)
-			list_move(&start->entry->vm_status, &vm->pt_freed);
-		spin_unlock(&vm->status_lock);
-		schedule_work(&vm->pt_free_work);
-		return;
-	}
+	WARN_ON(unlocked);
 
 	for_each_amdgpu_vm_pt_dfs_safe(adev, vm, start, cursor, entry)
 		amdgpu_vm_pt_free(entry);
@@ -1009,7 +978,15 @@ int amdgpu_vm_ptes_update(struct amdgpu_vm_update_params *params,
 		incr = (uint64_t)AMDGPU_GPU_PAGE_SIZE << shift;
 		mask = amdgpu_vm_pt_entries_mask(adev, cursor.level);
 		pe_start = ((cursor.pfn >> shift) & mask) * 8;
-		entry_end = ((uint64_t)mask + 1) << shift;
+
+		if (cursor.level < AMDGPU_VM_PTB && params->unlocked)
+			/*
+			 * Unmap to clear one PDE entry, to avoid unmap to free
+			 * PTB using pt_free work which has race condition.
+			 */
+			entry_end = 1ULL << shift;
+		else
+			entry_end = ((uint64_t)mask + 1) << shift;
 		entry_end += cursor.pfn & ~(entry_end - 1);
 		entry_end = min(entry_end, end);
 
-- 
2.35.1

