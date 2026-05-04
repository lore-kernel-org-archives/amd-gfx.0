Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0263CFF885A
	for <amd-gfx@archiver.kernel.org>; Mon,  4 May 2026 22:10:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8630E10E11E;
	Mon,  4 May 2026 22:10:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="yy6XVKPj";
	dkim-atps=neutral
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011002.outbound.protection.outlook.com [40.107.208.2])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 86D5710E11F
 for <amd-gfx@lists.freedesktop.org>; Mon,  4 May 2026 22:10:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kRUdx3+quQqO2qJiIL99BH8iOuiEVqdFv0hVx/SCv8LCzUtCdLp2xVYXHnabWKM7tJiLMyk941KiLpMlLnrVFbYcr8vaJ0cuS1eJ5BmeXk/lD0p7ftKasT7DFkMcapg5Qc6SkbjyQt/TKCTCieb98SuFYNgq9jKPRu8pUliEvR/34q/mCrIn4T0Hdn8XqEFmMUxjCpUlTgz9TNugLk93vStvppu8Wc7iZWSkC7P2uXqiAyYMbYoToejQzFbNcs7yX1hkbmJ2+ZZXXbk1nPZ7bzNigaQASXuuyhN2aF+3YYXuz8R4zSmwfO/A5XLW1li/giIjuYMhmUpNhfgSChiFDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=320PrQrCQCfqPtaAJhMtTjrD37hUT982nKny1RmCK/o=;
 b=aEfgA9AZkb/nPz7CXSleT9GXccweUSewTaPKTFldFm3kRoSc8w8uqrNlQy7RA4w8+6Etu6lbelcE+7MLAOcbN/Wl3sFhxdv3fjkM4bKxq/gavlbQlO1S+yUcDqHk7HJwFHN3rSJwSxIbeMLPWm7hausD3HbphzL0mHzobsOC96Gwy9yFblYMtCQVphluc7pXT0Xc0hIj3qqDOIDVqLEFRQKQNbC8VYtIJq1FCNke/hrY+lj/9dNd/OrAl/b8cxKg54QTq8lqAAUOz4g2XeuU5VtcZ7RjS2l/b7tiXPKRyZqbyaWKi5RiYbZuFmhIFtSeHcEWfX6i51+HKpTkjB/aDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=320PrQrCQCfqPtaAJhMtTjrD37hUT982nKny1RmCK/o=;
 b=yy6XVKPj6TiBu+1IkEEKuix+93OMbtCjlfBtwzW2QnDqLFVMxas8XirNvT98nVME+cYMWa4pA033V1vszEDlMDBZxtNswf5jI0QjExT1J1IB8R+NkLHC+2Cq1PRPscZyU2Nqgb7WxahSRcYl4y1/k7As2WySgWB8MUD8vx9z7Ro=
Received: from BY1P220CA0041.NAMP220.PROD.OUTLOOK.COM (2603:10b6:a03:59e::13)
 by SJ2PR12MB9005.namprd12.prod.outlook.com (2603:10b6:a03:53d::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.25; Mon, 4 May
 2026 22:10:07 +0000
Received: from SJ1PEPF00001CE8.namprd03.prod.outlook.com
 (2603:10b6:a03:59e:cafe::a) by BY1P220CA0041.outlook.office365.com
 (2603:10b6:a03:59e::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9870.25 via Frontend Transport; Mon,
 4 May 2026 22:10:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF00001CE8.mail.protection.outlook.com (10.167.242.24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9891.9 via Frontend Transport; Mon, 4 May 2026 22:10:06 +0000
Received: from amartin-dev-ubuntu.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Mon, 4 May 2026 17:10:06 -0500
From: Andrew Martin <andrew.martin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <david.francis@amd.com>, Andrew Martin <andrew.martin@amd.com>
Subject: [PATCH] drm/amdkfd: Fix IRQ-unsafe spinlock
Date: Mon, 4 May 2026 18:09:54 -0400
Message-ID: <20260504220954.1496706-1-andrew.martin@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE8:EE_|SJ2PR12MB9005:EE_
X-MS-Office365-Filtering-Correlation-Id: 0fa21d26-cd0f-481d-79de-08deaa29e666
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|36860700016|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: yPlwbUv9Q/KyOXnKFzEDbgOh9My+FQNqP5d7jKYiRgvkVOOeoYZ0NcrNXDlNBx8pe9jyRAkze52o337cAN7/Xh8Sd/JV+hwu+ZCPMJ/s/puTI4ogyOhUDnP58LIyXE6OLKi6Ue7ymCdpaZnYfVgPUIIxYpPbwxkJASi7w4yN4fh5iythl/CcgYUWn5nKo1EANazfItU5ttK0Y5wvlaORqv/gvNqa2mhrPvvpzMmjgW8ghwarMYVN7JE8bt7tr/4VN1OgC7kzF6gkv/pLzvAnaa/veBHkOfj7X3fCoeO3D7MUwiTR6lNBmZacvK4ZB0ZuUg8U3rkD+htUUmbdE7glWpQxlRB+5J4dSazdNLv6ukHcORk8m/3V1qtUe07R2AJ7hgYem+SeARBOi46PSHhcl+vqSgOEqrYBVbe2NOuNtx1hwjjcVNpTeoq0IqAvwr8H6oPehs6fmspS5HB3ObRpuFyqaI2UEReX57MECKU49WRejZooZwXorAf3giK4KbbGioTNkZUhnVjDXFOgbCmQQZUiHFs9FpfjYetCuSSJFfh94Hhpufsx+WeLi4RMl4XyXGE5xEbcyUNvLOxearRPyBXmyJAwAQ5d+O/cNI2BA39Gkgvz0wqWvZ0QMmHkdeYHv2EYqOKGU+6ly7zjiJK0W/CCL348KYAsP1PJYaLZhr2r3WeMWoWFHTIBorDvUcPFRydSi3G/mDoCpgXURw6hhJmuZkr27aCJOTPzAcpMNVg=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(36860700016)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: OwEcCycANkXcSJ53LWs7ih6c2BWjgRdZdSv2MlZvgMr1raCs5hkLC1nKMjmPQhHqeTw0ZzvMgTqcy1hnnfGjS+Ppk4c32IKNgdUOOvzyntbpw8Q1xwJB315BDmFj0bx5Q+0GuMssT67hTWDuo/ZUNFrpLkNckXKXpmwubGF9cNSQTwjsRmTMiLyuJBcl3tTNaimFSxVMD386zHdoSBDDRlT6CESGg546P67WLDQtxcyJz2EP8EOjjb3AWdYdbpZPmaLvrwY+B+PFQanLWwFl0o7lSRcGkdBtImtNMF9eq+r2loQCPQZ3UYcWAJ/GbFKS7JLkmksyW8/bTZ51FLiLpuhIbuil/wYWVFfvkYbG+qMYxDFxbdoAQmCg9IC39oDB8gQshy1xge3aK43H6q5f4Pz4ptoQBeTkOFZ2l6okBzDg8W9ioUbYM5dsTVGWjyO4
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 May 2026 22:10:06.8285 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0fa21d26-cd0f-481d-79de-08deaa29e666
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00001CE8.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9005
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

This patch fixes a multiple CPU hangs caused by the improper use of
spin_lock that are not IRQ safe.  This allow the software driver to
get into some sort of deadlock/race condition.  It happen of kernels
that have CONFIG_PROVE_LOCKING=y and or CONFIG_PREEMPT (full
preemption).

Fixes: 4c131aa02bc4 ("drm/amdgpu: Add profiling counters in fdinfo")
Signed-off-by: Andrew Martin <andrew.martin@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 158 ++++++++++++++++---------
 1 file changed, 105 insertions(+), 53 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index 8de9b7b3cc88..dc0fbf134fc0 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -165,14 +165,16 @@ static void amdgpu_vm_bo_evicted(struct amdgpu_vm_bo_base *vm_bo)
 	struct amdgpu_vm *vm = vm_bo->vm;
 	struct amdgpu_bo *bo = vm_bo->bo;
 
+	unsigned long flags;
+
 	vm_bo->moved = true;
 	amdgpu_vm_assert_locked(vm);
-	spin_lock(&vm_bo->vm->status_lock);
+	spin_lock_irqsave(&vm_bo->vm->status_lock, flags);
 	if (bo->tbo.type == ttm_bo_type_kernel)
 		list_move(&vm_bo->vm_status, &vm->evicted);
 	else
 		list_move_tail(&vm_bo->vm_status, &vm->evicted);
-	spin_unlock(&vm_bo->vm->status_lock);
+	spin_unlock_irqrestore(&vm_bo->vm->status_lock, flags);
 }
 /**
  * amdgpu_vm_bo_moved - vm_bo is moved
@@ -184,10 +186,12 @@ static void amdgpu_vm_bo_evicted(struct amdgpu_vm_bo_base *vm_bo)
  */
 static void amdgpu_vm_bo_moved(struct amdgpu_vm_bo_base *vm_bo)
 {
+	unsigned long flags;
+
 	amdgpu_vm_assert_locked(vm_bo->vm);
-	spin_lock(&vm_bo->vm->status_lock);
+	spin_lock_irqsave(&vm_bo->vm->status_lock, flags);
 	list_move(&vm_bo->vm_status, &vm_bo->vm->moved);
-	spin_unlock(&vm_bo->vm->status_lock);
+	spin_unlock_irqrestore(&vm_bo->vm->status_lock, flags);
 }
 
 /**
@@ -200,10 +204,12 @@ static void amdgpu_vm_bo_moved(struct amdgpu_vm_bo_base *vm_bo)
  */
 static void amdgpu_vm_bo_idle(struct amdgpu_vm_bo_base *vm_bo)
 {
+	unsigned long flags;
+
 	amdgpu_vm_assert_locked(vm_bo->vm);
-	spin_lock(&vm_bo->vm->status_lock);
+	spin_lock_irqsave(&vm_bo->vm->status_lock, flags);
 	list_move(&vm_bo->vm_status, &vm_bo->vm->idle);
-	spin_unlock(&vm_bo->vm->status_lock);
+	spin_unlock_irqrestore(&vm_bo->vm->status_lock, flags);
 	vm_bo->moved = false;
 }
 
@@ -217,9 +223,11 @@ static void amdgpu_vm_bo_idle(struct amdgpu_vm_bo_base *vm_bo)
  */
 static void amdgpu_vm_bo_invalidated(struct amdgpu_vm_bo_base *vm_bo)
 {
-	spin_lock(&vm_bo->vm->status_lock);
+	unsigned long flags;
+
+	spin_lock_irqsave(&vm_bo->vm->status_lock, flags);
 	list_move(&vm_bo->vm_status, &vm_bo->vm->invalidated);
-	spin_unlock(&vm_bo->vm->status_lock);
+	spin_unlock_irqrestore(&vm_bo->vm->status_lock, flags);
 }
 
 /**
@@ -232,10 +240,12 @@ static void amdgpu_vm_bo_invalidated(struct amdgpu_vm_bo_base *vm_bo)
  */
 static void amdgpu_vm_bo_evicted_user(struct amdgpu_vm_bo_base *vm_bo)
 {
+	unsigned long flags;
+
 	vm_bo->moved = true;
-	spin_lock(&vm_bo->vm->status_lock);
+	spin_lock_irqsave(&vm_bo->vm->status_lock, flags);
 	list_move(&vm_bo->vm_status, &vm_bo->vm->evicted_user);
-	spin_unlock(&vm_bo->vm->status_lock);
+	spin_unlock_irqrestore(&vm_bo->vm->status_lock, flags);
 }
 
 /**
@@ -248,11 +258,13 @@ static void amdgpu_vm_bo_evicted_user(struct amdgpu_vm_bo_base *vm_bo)
  */
 static void amdgpu_vm_bo_relocated(struct amdgpu_vm_bo_base *vm_bo)
 {
+	unsigned long flags;
+
 	amdgpu_vm_assert_locked(vm_bo->vm);
 	if (vm_bo->bo->parent) {
-		spin_lock(&vm_bo->vm->status_lock);
+		spin_lock_irqsave(&vm_bo->vm->status_lock, flags);
 		list_move(&vm_bo->vm_status, &vm_bo->vm->relocated);
-		spin_unlock(&vm_bo->vm->status_lock);
+		spin_unlock_irqrestore(&vm_bo->vm->status_lock, flags);
 	} else {
 		amdgpu_vm_bo_idle(vm_bo);
 	}
@@ -268,10 +280,12 @@ static void amdgpu_vm_bo_relocated(struct amdgpu_vm_bo_base *vm_bo)
  */
 static void amdgpu_vm_bo_done(struct amdgpu_vm_bo_base *vm_bo)
 {
+	unsigned long flags;
+
 	amdgpu_vm_assert_locked(vm_bo->vm);
-	spin_lock(&vm_bo->vm->status_lock);
+	spin_lock_irqsave(&vm_bo->vm->status_lock, flags);
 	list_move(&vm_bo->vm_status, &vm_bo->vm->done);
-	spin_unlock(&vm_bo->vm->status_lock);
+	spin_unlock_irqrestore(&vm_bo->vm->status_lock, flags);
 }
 
 /**
@@ -284,10 +298,11 @@ static void amdgpu_vm_bo_done(struct amdgpu_vm_bo_base *vm_bo)
 static void amdgpu_vm_bo_reset_state_machine(struct amdgpu_vm *vm)
 {
 	struct amdgpu_vm_bo_base *vm_bo, *tmp;
+	unsigned long flags;
 
 	amdgpu_vm_assert_locked(vm);
 
-	spin_lock(&vm->status_lock);
+	spin_lock_irqsave(&vm->status_lock, flags);
 	list_splice_init(&vm->done, &vm->invalidated);
 	list_for_each_entry(vm_bo, &vm->invalidated, vm_status)
 		vm_bo->moved = true;
@@ -301,7 +316,7 @@ static void amdgpu_vm_bo_reset_state_machine(struct amdgpu_vm *vm)
 		else if (bo->parent)
 			list_move(&vm_bo->vm_status, &vm_bo->vm->relocated);
 	}
-	spin_unlock(&vm->status_lock);
+	spin_unlock_irqrestore(&vm->status_lock, flags);
 }
 
 /**
@@ -320,8 +335,10 @@ static void amdgpu_vm_update_shared(struct amdgpu_vm_bo_base *base)
 	uint32_t bo_memtype = amdgpu_bo_mem_stats_placement(bo);
 	bool shared;
 
+	unsigned long flags;
+
 	dma_resv_assert_held(bo->tbo.base.resv);
-	spin_lock(&vm->status_lock);
+	spin_lock_irqsave(&vm->status_lock, flags);
 	shared = drm_gem_object_is_shared_for_memory_stats(&bo->tbo.base);
 	if (base->shared != shared) {
 		base->shared = shared;
@@ -333,7 +350,7 @@ static void amdgpu_vm_update_shared(struct amdgpu_vm_bo_base *base)
 			vm->stats[bo_memtype].drm.private += size;
 		}
 	}
-	spin_unlock(&vm->status_lock);
+	spin_unlock_irqrestore(&vm->status_lock, flags);
 }
 
 /**
@@ -404,10 +421,11 @@ void amdgpu_vm_update_stats(struct amdgpu_vm_bo_base *base,
 			    struct ttm_resource *res, int sign)
 {
 	struct amdgpu_vm *vm = base->vm;
+	unsigned long flags;
 
-	spin_lock(&vm->status_lock);
+	spin_lock_irqsave(&vm->status_lock, flags);
 	amdgpu_vm_update_stats_locked(base, res, sign);
-	spin_unlock(&vm->status_lock);
+	spin_unlock_irqrestore(&vm->status_lock, flags);
 }
 
 /**
@@ -428,15 +446,17 @@ void amdgpu_vm_bo_base_init(struct amdgpu_vm_bo_base *base,
 	base->next = NULL;
 	INIT_LIST_HEAD(&base->vm_status);
 
+	unsigned long flags;
+
 	if (!bo)
 		return;
 	base->next = bo->vm_bo;
 	bo->vm_bo = base;
 
-	spin_lock(&vm->status_lock);
+	spin_lock_irqsave(&vm->status_lock, flags);
 	base->shared = drm_gem_object_is_shared_for_memory_stats(&bo->tbo.base);
 	amdgpu_vm_update_stats_locked(base, bo->tbo.resource, +1);
-	spin_unlock(&vm->status_lock);
+	spin_unlock_irqrestore(&vm->status_lock, flags);
 
 	if (!amdgpu_vm_is_bo_always_valid(vm, bo))
 		return;
@@ -492,28 +512,29 @@ int amdgpu_vm_lock_done_list(struct amdgpu_vm *vm, struct drm_exec *exec,
 	struct list_head *prev = &vm->done;
 	struct amdgpu_bo_va *bo_va;
 	struct amdgpu_bo *bo;
+	unsigned long flags;
 	int ret;
 
 	/* We can only trust prev->next while holding the lock */
-	spin_lock(&vm->status_lock);
+	spin_lock_irqsave(&vm->status_lock, flags);
 	while (!list_is_head(prev->next, &vm->done)) {
 		bo_va = list_entry(prev->next, typeof(*bo_va), base.vm_status);
 
 		bo = bo_va->base.bo;
 		if (bo) {
 			amdgpu_bo_ref(bo);
-			spin_unlock(&vm->status_lock);
+			spin_unlock_irqrestore(&vm->status_lock, flags);
 
 			ret = drm_exec_prepare_obj(exec, &bo->tbo.base, 1);
 			amdgpu_bo_unref(&bo);
 			if (unlikely(ret))
 				return ret;
 
-			spin_lock(&vm->status_lock);
+			spin_lock_irqsave(&vm->status_lock, flags);
 		}
 		prev = prev->next;
 	}
-	spin_unlock(&vm->status_lock);
+	spin_unlock_irqrestore(&vm->status_lock, flags);
 
 	return 0;
 }
@@ -611,6 +632,7 @@ int amdgpu_vm_validate(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 	uint64_t new_vm_generation = amdgpu_vm_generation(adev, vm);
 	struct amdgpu_vm_bo_base *bo_base;
 	struct amdgpu_bo *bo;
+	unsigned long flags;
 	int r;
 
 	if (vm->generation != new_vm_generation) {
@@ -622,12 +644,12 @@ int amdgpu_vm_validate(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 			return r;
 	}
 
-	spin_lock(&vm->status_lock);
+	spin_lock_irqsave(&vm->status_lock, flags);
 	while (!list_empty(&vm->evicted)) {
 		bo_base = list_first_entry(&vm->evicted,
 					   struct amdgpu_vm_bo_base,
 					   vm_status);
-		spin_unlock(&vm->status_lock);
+		spin_unlock_irqrestore(&vm->status_lock, flags);
 
 		bo = bo_base->bo;
 
@@ -641,13 +663,13 @@ int amdgpu_vm_validate(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 			vm->update_funcs->map_table(to_amdgpu_bo_vm(bo));
 			amdgpu_vm_bo_relocated(bo_base);
 		}
-		spin_lock(&vm->status_lock);
+		spin_lock_irqsave(&vm->status_lock, flags);
 	}
 	while (ticket && !list_empty(&vm->evicted_user)) {
 		bo_base = list_first_entry(&vm->evicted_user,
 					   struct amdgpu_vm_bo_base,
 					   vm_status);
-		spin_unlock(&vm->status_lock);
+		spin_unlock_irqrestore(&vm->status_lock, flags);
 
 		bo = bo_base->bo;
 		dma_resv_assert_held(bo->tbo.base.resv);
@@ -658,9 +680,9 @@ int amdgpu_vm_validate(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 
 		amdgpu_vm_bo_invalidated(bo_base);
 
-		spin_lock(&vm->status_lock);
+		spin_lock_irqsave(&vm->status_lock, flags);
 	}
-	spin_unlock(&vm->status_lock);
+	spin_unlock_irqrestore(&vm->status_lock, flags);
 
 	amdgpu_vm_eviction_lock(vm);
 	vm->evicting = false;
@@ -681,6 +703,7 @@ int amdgpu_vm_validate(struct amdgpu_device *adev, struct amdgpu_vm *vm,
  */
 bool amdgpu_vm_ready(struct amdgpu_vm *vm)
 {
+	unsigned long flags;
 	bool ret;
 
 	amdgpu_vm_assert_locked(vm);
@@ -689,9 +712,9 @@ bool amdgpu_vm_ready(struct amdgpu_vm *vm)
 	ret = !vm->evicting;
 	amdgpu_vm_eviction_unlock(vm);
 
-	spin_lock(&vm->status_lock);
+	spin_lock_irqsave(&vm->status_lock, flags);
 	ret &= list_empty(&vm->evicted);
-	spin_unlock(&vm->status_lock);
+	spin_unlock_irqrestore(&vm->status_lock, flags);
 
 	spin_lock(&vm->immediate.lock);
 	ret &= !vm->immediate.stopped;
@@ -990,11 +1013,13 @@ int amdgpu_vm_update_pdes(struct amdgpu_device *adev,
 	LIST_HEAD(relocated);
 	int r, idx;
 
+	unsigned long flags;
+
 	amdgpu_vm_assert_locked(vm);
 
-	spin_lock(&vm->status_lock);
+	spin_lock_irqsave(&vm->status_lock, flags);
 	list_splice_init(&vm->relocated, &relocated);
-	spin_unlock(&vm->status_lock);
+	spin_unlock_irqrestore(&vm->status_lock, flags);
 
 	if (list_empty(&relocated))
 		return 0;
@@ -1261,10 +1286,12 @@ void amdgpu_vm_get_memory(struct amdgpu_vm *vm,
 			  struct amdgpu_mem_stats stats[__AMDGPU_PL_NUM],
 			  struct amdgpu_process_stats *process_stats)
 {
-	spin_lock(&vm->status_lock);
+	unsigned long flags;
+
+	spin_lock_irqsave(&vm->status_lock, flags);
 	memcpy(stats, vm->stats, sizeof(*stats) * __AMDGPU_PL_NUM);
 	memcpy(process_stats, &vm->process_stats, sizeof(*process_stats));
-	spin_unlock(&vm->status_lock);
+	spin_unlock_irqrestore(&vm->status_lock, flags);
 }
 
 /**
@@ -1634,26 +1661,27 @@ int amdgpu_vm_handle_moved(struct amdgpu_device *adev,
 	struct amdgpu_bo_va *bo_va;
 	struct dma_resv *resv;
 	bool clear, unlock;
+	unsigned long flags;
 	int r;
 
-	spin_lock(&vm->status_lock);
+	spin_lock_irqsave(&vm->status_lock, flags);
 	while (!list_empty(&vm->moved)) {
 		bo_va = list_first_entry(&vm->moved, struct amdgpu_bo_va,
 					 base.vm_status);
-		spin_unlock(&vm->status_lock);
+		spin_unlock_irqrestore(&vm->status_lock, flags);
 
 		/* Per VM BOs never need to bo cleared in the page tables */
 		r = amdgpu_vm_bo_update(adev, bo_va, false);
 		if (r)
 			return r;
-		spin_lock(&vm->status_lock);
+		spin_lock_irqsave(&vm->status_lock, flags);
 	}
 
 	while (!list_empty(&vm->invalidated)) {
 		bo_va = list_first_entry(&vm->invalidated, struct amdgpu_bo_va,
 					 base.vm_status);
 		resv = bo_va->base.bo->tbo.base.resv;
-		spin_unlock(&vm->status_lock);
+		spin_unlock_irqrestore(&vm->status_lock, flags);
 
 		/* Try to reserve the BO to avoid clearing its ptes */
 		if (!adev->debug_vm && dma_resv_trylock(resv)) {
@@ -1685,9 +1713,9 @@ int amdgpu_vm_handle_moved(struct amdgpu_device *adev,
 		     bo_va->base.bo->tbo.resource->mem_type == TTM_PL_SYSTEM))
 			amdgpu_vm_bo_evicted_user(&bo_va->base);
 
-		spin_lock(&vm->status_lock);
+		spin_lock_irqsave(&vm->status_lock, flags);
 	}
-	spin_unlock(&vm->status_lock);
+	spin_unlock_irqrestore(&vm->status_lock, flags);
 
 	return 0;
 }
@@ -2225,9 +2253,13 @@ void amdgpu_vm_bo_del(struct amdgpu_device *adev,
 		}
 	}
 
-	spin_lock(&vm->status_lock);
-	list_del(&bo_va->base.vm_status);
-	spin_unlock(&vm->status_lock);
+	{
+		unsigned long flags;
+
+		spin_lock_irqsave(&vm->status_lock, flags);
+		list_del(&bo_va->base.vm_status);
+		spin_unlock_irqrestore(&vm->status_lock, flags);
+	}
 
 	list_for_each_entry_safe(mapping, next, &bo_va->valids, list) {
 		list_del(&mapping->list);
@@ -2334,11 +2366,12 @@ void amdgpu_vm_bo_move(struct amdgpu_bo *bo, struct ttm_resource *new_mem,
 
 	for (bo_base = bo->vm_bo; bo_base; bo_base = bo_base->next) {
 		struct amdgpu_vm *vm = bo_base->vm;
+		unsigned long flags;
 
-		spin_lock(&vm->status_lock);
+		spin_lock_irqsave(&vm->status_lock, flags);
 		amdgpu_vm_update_stats_locked(bo_base, bo->tbo.resource, -1);
 		amdgpu_vm_update_stats_locked(bo_base, new_mem, +1);
-		spin_unlock(&vm->status_lock);
+		spin_unlock_irqrestore(&vm->status_lock, flags);
 	}
 
 	amdgpu_vm_bo_invalidate(bo, evicted);
@@ -3104,10 +3137,11 @@ void amdgpu_debugfs_vm_bo_info(struct amdgpu_vm *vm, struct seq_file *m)
 	unsigned int total_invalidated_objs = 0;
 	unsigned int total_done_objs = 0;
 	unsigned int id = 0;
+	unsigned long flags;
 
 	amdgpu_vm_assert_locked(vm);
 
-	spin_lock(&vm->status_lock);
+	spin_lock_irqsave(&vm->status_lock, flags);
 	seq_puts(m, "\tIdle BOs:\n");
 	list_for_each_entry_safe(bo_va, tmp, &vm->idle, base.vm_status) {
 		if (!bo_va->base.bo)
@@ -3159,7 +3193,7 @@ void amdgpu_debugfs_vm_bo_info(struct amdgpu_vm *vm, struct seq_file *m)
 			continue;
 		total_done += amdgpu_bo_print_info(id++, bo_va->base.bo, m);
 	}
-	spin_unlock(&vm->status_lock);
+	spin_unlock_irqrestore(&vm->status_lock, flags);
 	total_done_objs = id;
 
 	seq_printf(m, "\tTotal idle size:        %12lld\tobjs:\t%d\n", total_idle,
@@ -3260,9 +3294,27 @@ void amdgpu_sdma_set_vm_pte_scheds(struct amdgpu_device *adev,
 	adev->vm_manager.vm_pte_funcs = vm_pte_funcs;
 }
 
+/**
+ * amdgpu_vm_increment_process_counter - increment a process profiling counter
+ *
+ * @vm: the VM to update
+ * @stat_type: which counter to increment
+ *
+ * NOTE: This function is called from IRQ context in amdgpu_irq_dispatch(),
+ * so we MUST use spin_lock_irqsave/spin_unlock_irqrestore to prevent
+ * deadlock when an interrupt arrives while another context holds status_lock.
+ *
+ * The deadlock scenario without IRQ-safe locking:
+ * 1. Process context: amdgpu_vm_bo_del() acquires spin_lock(&vm->status_lock)
+ * 2. IRQ arrives on same CPU
+ * 3. IRQ handler: amdgpu_vm_increment_process_counter() tries to acquire
+ *    spin_lock(&vm->status_lock) -> DEADLOCK
+ */
 void amdgpu_vm_increment_process_counter(struct amdgpu_vm *vm, enum amdgpu_process_stat_type stat_type)
 {
-	spin_lock(&vm->status_lock);
+	unsigned long flags;
+
+	spin_lock_irqsave(&vm->status_lock, flags);
 	switch (stat_type) {
 	case AMDGPU_VM_VMFAULT_COUNTER:
 		vm->process_stats.vmfault_counter++;
@@ -3282,5 +3334,5 @@ void amdgpu_vm_increment_process_counter(struct amdgpu_vm *vm, enum amdgpu_proce
 	default:
 		pr_debug("unknown process stat type 0x%x\n", stat_type);
 	}
-	spin_unlock(&vm->status_lock);
+	spin_unlock_irqrestore(&vm->status_lock, flags);
 }
-- 
2.43.0

