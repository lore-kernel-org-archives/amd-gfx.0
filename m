Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07270C98315
	for <amd-gfx@archiver.kernel.org>; Thu, 24 Sep 2026 14:22:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7339610F5E2;
	Thu, 24 Sep 2026 14:22:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="YIpj4Vvp";
	dkim-atps=neutral
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011017.outbound.protection.outlook.com [52.101.57.17])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 89BA410F5E2
 for <amd-gfx@lists.freedesktop.org>; Thu, 24 Sep 2026 14:22:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jpsVx5MSqzumQTLIy3dHi1Xt9AZvMCNvMYh+ekk3wjFw4Zin6LeGpjCMPFMiUm5dZ5C7ZYtLfPslq2UvOBrI3p9KErv3Eu6ezATgPmigxliR+Rb7Ls5d+MBlzXGNHKTldzwO7JyakHYGKdvRxIJYsdru3CyQ/qafGXcKDdsD+a63aOWv3Y7+OroUb+77q9buGKx7UOTvqlKgrz9KkIb21XtPUwbJrh4LN6/b1z1Ef93IPDOUkx+98M6+Pn+0yzT589hRuDwQKm7p7qpA1CxyicykHy5p6CSJQVTekGqT9cqwNLrT7ATR1ADUD+leJylbcqg2FLjgdgiM3Nuf7qYk5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SCXax9RmeL8Hp4iVkWvz7vlc4+jqIJBNK5kJ9A3Pga4=;
 b=deFZKb6/fBG5DkhXICR+5cjzAdB3Uowj6lCGrm4n0mBAFM6yN94KRnm6JFoIoVrYWxEUO71q4/T/aak4Nly/2wBbEBG9ndPhXMMQTPoRqlyrTWmZKKYYRB/7vccrJ6dLWE8fYwHdbxkEnybmNog44bI7Sph2fd0pIeYXrkWUrf5ffJR5ioQeq/AWozvLpgvqex074RIaeawF+sdkGnUGQwTrgdAFf9avNII0wZBPs4HKes7iAFlGDKLWHUcdDTisMbGz25R+j1K/B4N32R2R+gRAoByGNfpnKGB4DUi+eBEg1qGw52r7lD5YT5sbDK3omfc/NtoyX6ZxtpdZmkyd2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SCXax9RmeL8Hp4iVkWvz7vlc4+jqIJBNK5kJ9A3Pga4=;
 b=YIpj4VvpISnS+ZevLtO//2RKomFM6lHeQMnrGR0Sl1QV9FrmZCHoN56hFoYTX2p+/GmDeyhZwxOymdQV9W41iQ8i/o7KzINt0Gh1Z3doB+GbtasZFK3TQYm0L6N8ZZ8mPMsW9jKC+IucyWzbXZuf2qaxfe8bid4iFatR2vybFhE=
Received: from SJ0PR03CA0277.namprd03.prod.outlook.com (2603:10b6:a03:39e::12)
 by DSVPR12MB999309.namprd12.prod.outlook.com (2603:10b6:8:41f::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.18; Thu, 24 Sep
 2026 14:22:08 +0000
Received: from SJ1PEPF00002319.namprd03.prod.outlook.com
 (2603:10b6:a03:39e:cafe::4f) by SJ0PR03CA0277.outlook.office365.com
 (2603:10b6:a03:39e::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.18 via Frontend Transport; Thu,
 24 Sep 2026 14:22:07 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF00002319.mail.protection.outlook.com (10.167.242.229) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.8 via Frontend Transport; Thu, 24 Sep 2026 14:22:07 +0000
Received: from liuxiang-mlse-vm.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Thu, 24 Sep
 2026 09:22:02 -0500
From: Xiang Liu <xiang.liu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Tao.Zhou1@amd.com>, <Stanley.Yang@amd.com>,
 <YiPeng.Chai@amd.com>, <Mukul.Joshi@amd.com>, Xiang Liu <xiang.liu@amd.com>
Subject: [PATCH] drm/amdgpu: don't leak bo_va when gem_object_open fails
Date: Thu, 24 Sep 2026 22:21:29 +0800
Message-ID: <20260924142129.745010-1-xiang.liu@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002319:EE_|DSVPR12MB999309:EE_
X-MS-Office365-Filtering-Correlation-Id: db35e42a-26c0-45b1-ee0c-08df1a4736ac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|82310400026|1800799024|36860700016|10067099003|56012099006|5023799004|11063799006|18002099003;
X-Microsoft-Antispam-Message-Info: LA7rRK7Tkry168qeYR/qiOTB0g1Swc+VUCQb5bo+UKioO4dlmOLmJfsQ+xGFPOzDRLYdbWELwPTDIrUYuWRJAcmUBRCZflUzB7b2tV3s69k/PGrJSR9jT7KF/UzuM58zoxwOFfRMTMM4uq42PhuZ0g9FgITkk8Dnrr9RsXl7aTSxxJCOgN8JhUtC9a0JMDxfR/ovwPvie87Jk52Fh2FXzmkhUacrcmZzGIzb1atzqG3O3RQ0JvlRpfCmiaS76oebdZJbfrgZVMDdGZp7fKOSAK9OgKMOmlSiTa1JXfxtfubm5oFWCjaGietTvAMWKVjq6CwbutFPVY9Dfey7WFi1U8+/243Zj2P5q2e62u7FQot+65zyn+qMk4aIIYjk981oQF3AR5hp+KR8yi9Hon8xDuQZMkFgjupbP1wc7gOoW78hnAa32SPrzLsu/X+tJHVAuBvd4Y/UUROZsGG+QUPElsQbyb+KZ5LAl3wBW8OHZZXDc3GCluEqxWCPTvUdeWBS1nUVI4J5zrqjZVK67iWSgMedZ5cPmxVy4cUaDxCrCQUPnKcmuDt5g09pv7vOGeW4UkIVa5WQgYmNNOTrwNJx0W5YCvoM19r/TIGEF377VywsMwG4MVfCqE7yAXP3sb5m3guKzdBobD3ifkRHLuI9jBEn8oCs5ufpDWifkBKMku3/peM7AAr7nFiXDCg5FBY2NRRMcdLRe0br4XIsewLrLQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(82310400026)(1800799024)(36860700016)(10067099003)(56012099006)(5023799004)(11063799006)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: kfGjsguEIITbEEAb/OvGonQr6ZpPs+2C4CV+BUAu4h8KqpuUijhdq7nw5MxT5mhhKFcWtzM3rG7o7a75gerk5FRFg9VgF/XvcSqMbmZSbhAIwWTfKZ77h6P+P8U3cV07HI/ZO4Re5LRKqebBSxyQQBAeWKLFz6fCmjGWkF5/MgdG5Plc1jBGR292wQ33UNvl9J+SBWwZYJjvvgxTtGgUxhA26uRTeMWCqh3TqUs1lox3oSgh02MzUdYgy2PQv6Nt3KixXJSnHxHvN5oUA6Epq+1BGh8h7lBmlREB9S2F0Ijxnex5o5PUylZW/9GLcnfixShHInIhomM5pgNnWiWPhofmdaTVS5rP4RKDMf+6isiHXBiU+vfBb4zp2uUSiCK1Z2RYX4NPUQdkEJGq/wGeHNYcHQuop3M3dkDcicTNMmUAh2IT0XEonU5oUVhHqwca
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2026 14:22:07.1502 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: db35e42a-26c0-45b1-ee0c-08df1a4736ac
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00002319.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DSVPR12MB999309
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

drm_gem_handle_create_tail() skips the close() callback when open()
returns an error, so a bo_va added before a failing step is never
removed. It stays linked on bo->vm_bo and a later eviction of that BO
dereferences the VM after it has been torn down.

Validate and fence the BO before adding the bo_va, drop the bo_va when
attaching the eviction fence fails, and propagate the allocation failure
from amdgpu_vm_bo_add().

Signed-off-by: Xiang Liu <xiang.liu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c | 80 ++++++++++++++-----------
 1 file changed, 45 insertions(+), 35 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
index 9da1880ee76d..be0c642f3740 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
@@ -260,7 +260,7 @@ static int amdgpu_gem_object_open(struct drm_gem_object *obj,
 	struct amdgpu_bo_va *bo_va;
 	struct mm_struct *mm;
 	struct drm_exec exec;
-	int r;
+	int r = 0;
 
 	mm = amdgpu_ttm_tt_get_usermm(abo->tbo.ttm);
 	if (mm && mm != current->mm)
@@ -270,6 +270,42 @@ static int amdgpu_gem_object_open(struct drm_gem_object *obj,
 	    !amdgpu_vm_is_bo_always_valid(vm, abo))
 		return -EPERM;
 
+	/* Validate and add eviction fence to DMABuf imports with dynamic
+	 * attachment in compute VMs. Re-validation will be done by
+	 * amdgpu_vm_validate. Fences are on the reservation shared with the
+	 * export, which is currently required to be validated and fenced
+	 * already by amdgpu_amdkfd_gpuvm_restore_process_bos.
+	 *
+	 * This runs before the BO is added to the VM: drm_gem_handle_create_tail()
+	 * does not call the close() callback when open() fails, so nothing that
+	 * would need unwinding may exist yet.
+	 *
+	 * Nested locking below for the case that a GEM object is opened in
+	 * kfd_mem_export_dmabuf. Since the lock below is only taken for imports,
+	 * but not for export, this is a different lock class that cannot lead to
+	 * circular lock dependencies.
+	 */
+	if (vm->is_compute_context && vm->process_info &&
+	    drm_gem_is_imported(obj) &&
+	    dma_buf_is_dynamic(obj->import_attach->dmabuf)) {
+		mutex_lock_nested(&vm->process_info->lock, 1);
+		if (!WARN_ON(!vm->process_info->eviction_fence))
+			r = amdgpu_amdkfd_bo_validate_and_fence(abo,
+					AMDGPU_GEM_DOMAIN_GTT,
+					&vm->process_info->eviction_fence->base);
+		mutex_unlock(&vm->process_info->lock);
+		if (r) {
+			struct amdgpu_task_info *ti = amdgpu_vm_get_task_info_vm(vm);
+
+			dev_warn(adev->dev, "validate_and_fence failed: %d\n", r);
+			if (ti) {
+				dev_warn(adev->dev, "pid %d\n", ti->task.pid);
+				amdgpu_vm_put_task_info(ti);
+			}
+			return r;
+		}
+	}
+
 	drm_exec_init(&exec, DRM_EXEC_IGNORE_DUPLICATES, 0);
 	drm_exec_until_all_locked(&exec) {
 		r = drm_exec_prepare_obj(&exec, &abo->tbo.base, TTM_NUM_MOVE_FENCES + 1);
@@ -287,47 +323,21 @@ static int amdgpu_gem_object_open(struct drm_gem_object *obj,
 	bo_va = amdgpu_vm_bo_find(vm, abo);
 	if (!bo_va) {
 		bo_va = amdgpu_vm_bo_add(adev, vm, abo);
+		if (!bo_va) {
+			r = -ENOMEM;
+			goto out_unlock;
+		}
 		r = amdgpu_evf_mgr_attach_fence(&fpriv->evf_mgr, abo);
-		if (r)
+		if (r) {
+			amdgpu_vm_bo_del(adev, bo_va);
 			goto out_unlock;
+		}
 	} else {
 		++bo_va->ref_count;
 	}
 
 	drm_exec_fini(&exec);
-
-	/* Validate and add eviction fence to DMABuf imports with dynamic
-	 * attachment in compute VMs. Re-validation will be done by
-	 * amdgpu_vm_validate. Fences are on the reservation shared with the
-	 * export, which is currently required to be validated and fenced
-	 * already by amdgpu_amdkfd_gpuvm_restore_process_bos.
-	 *
-	 * Nested locking below for the case that a GEM object is opened in
-	 * kfd_mem_export_dmabuf. Since the lock below is only taken for imports,
-	 * but not for export, this is a different lock class that cannot lead to
-	 * circular lock dependencies.
-	 */
-	if (!vm->is_compute_context || !vm->process_info)
-		return 0;
-	if (!drm_gem_is_imported(obj) ||
-	    !dma_buf_is_dynamic(obj->import_attach->dmabuf))
-		return 0;
-	mutex_lock_nested(&vm->process_info->lock, 1);
-	if (!WARN_ON(!vm->process_info->eviction_fence)) {
-		r = amdgpu_amdkfd_bo_validate_and_fence(abo, AMDGPU_GEM_DOMAIN_GTT,
-							&vm->process_info->eviction_fence->base);
-		if (r) {
-			struct amdgpu_task_info *ti = amdgpu_vm_get_task_info_vm(vm);
-
-			dev_warn(adev->dev, "validate_and_fence failed: %d\n", r);
-			if (ti) {
-				dev_warn(adev->dev, "pid %d\n", ti->task.pid);
-				amdgpu_vm_put_task_info(ti);
-			}
-		}
-	}
-	mutex_unlock(&vm->process_info->lock);
-	return r;
+	return 0;
 
 out_unlock:
 	drm_exec_fini(&exec);
-- 
2.34.1

