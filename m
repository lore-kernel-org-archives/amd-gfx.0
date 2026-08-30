Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1816BC61DD9
	for <amd-gfx@archiver.kernel.org>; Sun, 30 Aug 2026 15:40:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 99E1A10E1EA;
	Sun, 30 Aug 2026 15:40:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="rvsvNTBN";
	dkim-atps=neutral
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011016.outbound.protection.outlook.com
 [40.93.194.16])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A844410E1EA
 for <amd-gfx@lists.freedesktop.org>; Sun, 30 Aug 2026 15:40:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sc/VCwJtgt/X6Lwjf23avlu7uGJ1ICkhSn9MmtzPWWU+8cT2OkENfkDRJuVw4V7B2tuReUj6UtwlIxoMD3pIuaMYSAust9yt3bsgQXAJ8IaxN6pe8/AWoON+md1Jbs1S7/WeN/oWWvqboDbAkHdoPkngc8IiDZEMEtRsFmVmzGEqkzs1mBilwiZGBs49tzFmWzmqOa7L16ztd0JixGwFlV4R5D24ztcWPOu6fTx7MEiCpgfY2dc/VJVuUpXQDBBi8Ggv/wtR6DxQ2T1MVQ4I34KXJqAysWqkwcC842YT/0YoVbmt5aXsFxDxKk6HSZDNhMDh/gsHrEslm51wmoz7+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=POVtGO0a/GXIAS0nfbMWQpLI/iwwwxH1o5t53Y1ZuCU=;
 b=UfiKfL6VzBHvOHhh2UK9MOD7PW4ntcPeZxp65sblAauP9Svt1AuwQsORLYk0OZJD0MCIXbnrCJV4C3YQsvO8cOlC0Jl/aG+Qf6UjkvSLzFP6+gJiFjxVhM6Qb9Eu75aM1OJMzZibhWTfxSyg0NC6S4JbhLtswZA0B+35YUx1DEGiUkW52Uida2uh6mMPw+OXVqMRT2I2pAidz2UrSfZ9L/N0VkpWMmiaLtViAN+XLu0y7Skt9BWDf1Mo5/p6Mfm4A2Hz41IJap3QdHP4Ix3Xd4b3l4nTYN5OEiH5AyoN15wim/frgqUyttUDZOr2Fu2nIqz490ACK692Mgj9NzZKLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=gmail.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=POVtGO0a/GXIAS0nfbMWQpLI/iwwwxH1o5t53Y1ZuCU=;
 b=rvsvNTBNpn4hB1TgUJkD09ofweOWTktT+xHle8hh1kOuFvUZTlApuYrrCewo/Nr9pNABC2jdBrKsKYwYI3/SpO7cWAGDkzIiEcjvBvnj2x+Wfw9lH5fxUNpsVjg33zvL/jyTriAS6ryb9Q7lBPJrhN/AHS2mjNcG5+jQQawFLoY=
Received: from DS1PR03CA0004.namprd03.prod.outlook.com (2603:10b6:8:450::12)
 by CH2PR12MB4325.namprd12.prod.outlook.com (2603:10b6:610:a9::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.6; Sun, 30 Aug
 2026 15:40:50 +0000
Received: from SA2PEPF000015C6.namprd03.prod.outlook.com
 (2603:10b6:8:450:cafe::87) by DS1PR03CA0004.outlook.office365.com
 (2603:10b6:8:450::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.13 via Frontend Transport; Sun,
 30 Aug 2026 15:40:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SA2PEPF000015C6.mail.protection.outlook.com (10.167.241.196) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Sun, 30 Aug 2026 15:40:50 +0000
Received: from honglei-remote.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Sun, 30 Aug
 2026 10:40:46 -0500
From: Honglei Huang <honglei1.huang@amd.com>
To: <Christian.Koenig@amd.com>, <Alexander.Deucher@amd.com>,
 <Felix.Kuehling@amd.com>, <Oak.Zeng@amd.com>, <Jenny-Jing.Liu@amd.com>,
 <Philip.Yang@amd.com>, <Xiaogang.Chen@amd.com>, <Ray.Huang@amd.com>,
 <Junhua.Shen@amd.com>, <timur.kristof@gmail.com>, <natalie.vock@gmx.de>
CC: <amd-gfx@lists.freedesktop.org>, <honghuan@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Subject: [RFC PATCH 1/3] drm/amdgpu: make VM eviction lock read/write to match
 notifier lock
Date: Sun, 30 Aug 2026 23:40:25 +0800
Message-ID: <17cb444d6b7ceb3f9739edaebe6c6d914bed33e1.1788103444.git.honghuan@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1788103444.git.honghuan@amd.com>
References: <cover.1788103444.git.honghuan@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF000015C6:EE_|CH2PR12MB4325:EE_
X-MS-Office365-Filtering-Correlation-Id: 4038d35b-3c4f-48ca-6c8f-08df06ad1176
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|23010399003|376014|1800799024|11063799006|10067099003|56012099006|18002099003|22082099003|921020;
X-Microsoft-Antispam-Message-Info: ++nVDeKqjxFw1GOIo9m/uMYd54XqagnPcJI73mVNFF2vvJkrBmuQtSV7bOg8MCHtbjuYjVuHZHOLCvvOqreakoHCfQnUmBIV9WoEnYWuzgWCkRdqm18NqsW6TPKFLx19vqZMXix3YZ/CVbET6nFmABy6IdO/rRO/yX28/PpWDa4DSPXzvvOKf8J8/NNxri+0rcQfDnkpKKev/ZAWMOtNIa11DiFTpLsT1hwhTyFPYbNjYkd89Tjx6ymnnvQIneQv4Knjn7eirnwVOply61WrByrNAlIk+nvM1pzPTH42XeANNFWgMd2zHvFWD3+PrfajPhh+VgnLTsGoP6LRPKnhuyTtghCZknM/HoJ7jweC4zHKhM60pbpwpnZSwC7zj/Pd117cnp4h90J7AHn1AE9DCrNvyy7KFSif/3KU2eXs76nLKf2xSvI75TcjQddRa9vdLb7uuTTOxsZ0QOXQvxofCH1w45ytl5kCPhHmqe+wm4FkG6/BG/xfy5b+eW9HxcN4MvKyXgoReiV5GC3wMeDIXScIqVkuegnGI8zz58wIamkHS5EbnaWJquZ4E8MH75omGDD0BpZIzS/KwslxfY4LxbTNGW9Rbhf8LSshLCEf85BKx8Ei1Lqp30K7sAze1TF9+gx/bNenNeTm4CXCQqr9Wtf6llMjYwVUBPVbwNVq8FtZsi8Y6nrkkwYgGof9BIwskfggzdb15xhVzxnzQ769IbCwoQ0yIaiigIJtrxK/Du2g7luvKsTdSvll6qPgr0en
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(23010399003)(376014)(1800799024)(11063799006)(10067099003)(56012099006)(18002099003)(22082099003)(921020);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 9QvmmDrv9fmsMV/WAIeBnIu0hEc9wmATdjlvAARqPFqQumBTxTIg4TJejPoBYepjDyl88BDf+/8bj3GwkNPv0TEdjxzHe5JEGjBSVbVWgiK/AXRTK2olLycdFSlyzH48Lq6KuoLhHJBLSpyvwVSJtYmkhSZKcLMws+Xf2svmiSTEPGLeSaZxwIA7blseqySumLoh0ztEDWSoNlVhcMvR0dOhQUMV7jwfR6F2xWiXaUlc4UYtvfbORugtrWsGlidCwnBzBebtYASwC9aFMWjjMgzNYlMQzVXewYyWmXPNjq5NcjeVNjDgF1yMEpa6tIEegPU5UVYX7CwM6a4bqx+bu4nf8Acepg0E3gRX4npg0Nt8ubXxY321ChzDIIs9DRMdWAdgg4dumK7WXOL8GE1cCqJSt4qbo7hUUdrHq72sXy56QNkE8/yxz4vWsw0s6+QS
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Aug 2026 15:40:50.1347 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4038d35b-3c4f-48ca-6c8f-08df06ad1176
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF000015C6.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4325
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

From: Honglei Huang <honghuan@amd.com>

Make the VM eviction lock read/write to match the drm_gpusvm notifier
lock. This allows VM updates, MMU notifier invalidation and eviction to
share the same rwsem.

Replace the VM eviction mutex with a selectable rwsem. Updates made with
the root BO reserved take the read side. Updates without the root BO
reservation take the write side, as does eviction. A VM using
drm_gpusvm can use the notifier lock as its eviction lock.

Suggested-by: Christian König <christian.koenig@amd.com>
Signed-off-by: Honglei Huang <honghuan@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c          |  9 +++++----
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h          |  8 ++++----
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm_internal.h | 12 ++++++++++--
 3 files changed, 19 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index e40bce2912..a2cc6e2017 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -617,7 +617,7 @@ int amdgpu_vm_validate(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 	 * As soon as all page tables are in place we can start updating them
 	 * again.
 	 */
-	scoped_guard(mutex, &vm->eviction_lock)
+	scoped_guard(rwsem_write, vm->eviction_lock)
 		vm->evicting = false;
 
 	list_for_each_entry_safe(bo_base, tmp, &vm->always_valid.evicted,
@@ -678,7 +678,7 @@ bool amdgpu_vm_ready(struct amdgpu_vm *vm)
 
 	amdgpu_vm_assert_locked(vm);
 
-	scoped_guard(mutex, &vm->eviction_lock)
+	scoped_guard(rwsem_read, vm->eviction_lock)
 		ret = !vm->evicting;
 
 	ret &= list_empty(&vm->kernel.evicted);
@@ -2351,7 +2351,7 @@ bool amdgpu_vm_evictable(struct amdgpu_bo *bo)
 
 	/* Try to block ongoing updates */
 	vm = bo_base->vm;
-	scoped_cond_guard(mutex_try, return false, &vm->eviction_lock) {
+	scoped_cond_guard(rwsem_write_try, return false, vm->eviction_lock) {
 
 		/* Don't evict VM page tables while they are updated */
 		if (!dma_fence_is_signaled(vm->last_unlocked))
@@ -2707,7 +2707,8 @@ int amdgpu_vm_init(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 	vm->last_tlb_flush = dma_fence_get_stub();
 	vm->generation = amdgpu_vm_generation(adev, NULL);
 
-	mutex_init(&vm->eviction_lock);
+	init_rwsem(&vm->default_eviction_lock);
+	vm->eviction_lock = &vm->default_eviction_lock;
 	vm->evicting = false;
 	vm->tlb_fence_context = dma_fence_context_alloc(1);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
index f5cf2dd374..eac2632db0 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
@@ -27,6 +27,7 @@
 #include <linux/idr.h>
 #include <linux/kfifo.h>
 #include <linux/rbtree.h>
+#include <linux/rwsem.h>
 #include <drm/gpu_scheduler.h>
 #include <drm/drm_file.h>
 #include <drm/ttm/ttm_bo.h>
@@ -283,10 +284,9 @@ struct amdgpu_vm {
 	/* tree of virtual addresses mapped */
 	struct rb_root_cached	va;
 
-	/* Lock to prevent eviction while we are updating page tables
-	 * use vm_eviction_lock/unlock(vm)
-	 */
-	struct mutex		eviction_lock;
+	/* SVM can replace this pointer with its notifier lock. */
+	struct rw_semaphore	default_eviction_lock;
+	struct rw_semaphore	*eviction_lock;
 	bool			evicting;
 
 	/* Memory statistics for this vm, protected by stats_lock */
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_internal.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_internal.h
index 3d4a80fd76..2bd069c56c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_internal.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_internal.h
@@ -157,7 +157,12 @@ void amdgpu_vm_pt_free_dummies(struct amdgpu_device *adev);
  */
 static inline int amdgpu_vm_begin_critical(struct amdgpu_vm_update_params *p)
 {
-	mutex_lock(&p->vm->eviction_lock);
+	/* Use the write lock to serialize updates when the root BO is unlocked. */
+	if (p->unlocked)
+		down_write(p->vm->eviction_lock);
+	else
+		down_read(p->vm->eviction_lock);
+
 	p->saved_flags = memalloc_noreclaim_save();
 	if (p->vm->evicting)
 		return -EBUSY;
@@ -175,7 +180,10 @@ static inline int amdgpu_vm_begin_critical(struct amdgpu_vm_update_params *p)
 static inline void amdgpu_vm_end_critical(struct amdgpu_vm_update_params *p)
 {
 	memalloc_noreclaim_restore(p->saved_flags);
-	mutex_unlock(&p->vm->eviction_lock);
+	if (p->unlocked)
+		up_write(p->vm->eviction_lock);
+	else
+		up_read(p->vm->eviction_lock);
 }
 
 #endif
-- 
2.34.1

