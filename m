Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7B79C531D0
	for <amd-gfx@archiver.kernel.org>; Tue, 28 Jul 2026 01:46:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4021C10E4FD;
	Tue, 28 Jul 2026 01:46:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="BQz/gAcC";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013048.outbound.protection.outlook.com
 [40.93.201.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B73B210E4FD
 for <amd-gfx@lists.freedesktop.org>; Tue, 28 Jul 2026 01:46:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YCm8aXDn4eJ6LjxW5D/e6IMGZFSJ0hbTaEeq6KGceNtwocDcIHG7AXGR/1xzNvexHecOLOqGkJygr4a0Ps+ZipPLnVMhlzx87e9BPvpI9UKtwdGUZh1OGg8o84qjJuTHsokTX3dXNA0JcvN2njghJi5wn+LcEO0JGrizNUVLev6HzhScz6aIT532EmF5KGjfKsTNfmDQNGHfOAeWw5/b5nPepMHycZOoII9x8HaY+KzuHeot+eXqGe8OUGcQGy52AIMME5kQP0OXLI70UoDswehMuONPGgNCKEz3P+hJLhk0rG6bO0AZmFDB2Af/ngytyO2EjKeB8WBT577u2oVBQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Avw3GBgQsczfkWZHKgss7kpk8Q/RkXQ4WC3equkzus0=;
 b=tqyHa4OmoEBvVASwyhL1Q9zIYALCghP8ao9pdUoqY38fRDjSsn7xqeECVDcz8KiXyCWvoBFEp7fk4actXczY7iBUM68ijvn3T8SxJeNW8h371BUgeW3FEuZ9/e1kFiA5ehp17+DiG5elSH71IL5pWecfobbwj2Gj9yOaybB90ot4C6o32WsxXOy+cTHDvSRU1e8ZLTRXlzrbwpBSslG724DjbMAFQTyUfXct+0sr9K+iYiG4CmazrW0My5xPb5Ye7zYN1EO7ZIl8OKuIGlsOTCzL+aIQL+w8NCWPZDrgWxlsS2naKEMdi9Y01nZpaFM7bjVSeB+EjjVqJvktBlYP4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Avw3GBgQsczfkWZHKgss7kpk8Q/RkXQ4WC3equkzus0=;
 b=BQz/gAcCci2xt0KmO/gbKLs4du292nOx68heF6qHFZQdMZMDZ/xTq3Wk3Sh/mtT3yNGZHsoZr0ObW7bxBSbgP8UJAm8w+AexR4YREa6By6DZcl8gO5dllMBSM0dgNGHUukYqOso/CuezhOqJL0MfFg+UPnc/fGFGkkOPCFSPgLk=
Received: from SJ0PR05CA0017.namprd05.prod.outlook.com (2603:10b6:a03:33b::22)
 by IA1PR12MB6067.namprd12.prod.outlook.com (2603:10b6:208:3ed::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.13; Tue, 28 Jul
 2026 01:46:35 +0000
Received: from BY1PEPF0001AE1C.namprd04.prod.outlook.com
 (2603:10b6:a03:33b:cafe::80) by SJ0PR05CA0017.outlook.office365.com
 (2603:10b6:a03:33b::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.270.12 via Frontend Transport; Tue,
 28 Jul 2026 01:46:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BY1PEPF0001AE1C.mail.protection.outlook.com (10.167.242.105) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.270.5 via Frontend Transport; Tue, 28 Jul 2026 01:46:34 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 27 Jul
 2026 20:46:33 -0500
Received: from JesseDEV.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Mon, 27 Jul 2026 20:46:32 -0500
From: Jesse Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 Jesse Zhang <Jesse.Zhang@amd.com>
Subject: [PATCH] drm/amdgpu: fix NULL pointer deref in amdgpu_vm_handle_moved
 for BO-less mappings
Date: Tue, 28 Jul 2026 09:46:13 +0800
Message-ID: <20260728014631.4001668-1-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY1PEPF0001AE1C:EE_|IA1PR12MB6067:EE_
X-MS-Office365-Filtering-Correlation-Id: e87ad92c-85be-4820-4908-08deec4a0e50
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|23010399003|36860700016|376014|11063799006|56012099006|10067099003|3023799007|18002099003;
X-Microsoft-Antispam-Message-Info: zVhifLEmkIwhoDwqALcTXA1qKN0S0BuD25aL6xIV5cUNzyvdJBIzUgiqg9PpHRdnggWzrlawSypXR0b691Ehzv9WxIGhLiDab3O5/WOBaroYwjd6YIp79apYkx2s6+PKLpBR1ac+Y8cZDGaJO1iiGTnnzLImqVNYZK4+bDrg0KLVHaYoXBv/Us5l+9hggTQk1alN1V9CjOHn3EVcWyov2FjyVh0lDjEMTNkhvmNuYkHN7J3cCJjLbm9d3ZsM6m6hH7Ho8H6I6oB+IFtCRhdAMEu5n4XETztRqvAfhBrVBfIiHNXh2zUUA105CNsYk63A8vDZ2/q7ZUaQN4XEm21k3XJmIG7jO1ssY0UkcLSz5yKxBmGHLRBTFulvJMHKuzt7IhD7V6kY1OO1xd0vP01ccO9IEEG2wVtuzOBXOONjRkxAUPJ1ZaXiDvuFbQJsl/cpMA/th82HfnoRiYiiWzuRy3ieK3nI9dWBWZLvdID7MHnqo7UTKyRPdje/exRpx1oGj/yGtJlD1uTryOvUXr5UJW6BJoRA/4x2P/fIzN3ieBYQXWcinYz8ycHJME7dNeuy1pzN6H0zsaR+8S3a+Rhfs++g4Ethn0axmplmVfFsJf+Qm21eryeFhsbjH4XDqxUSxssGT26diaVyoARuommoMnB/2WpkV44X3auIy34yZaxiMXpQoqUm2VbfwuWrk8SbiemhAMLm7442hnL85auhXw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(23010399003)(36860700016)(376014)(11063799006)(56012099006)(10067099003)(3023799007)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: ZguvvGrR1iTpwpZpRXE2F5dOgY21UGh/qnjctifTn3+cVQKnfM/i+/m4h6klXrKdIb9GuF13W16SbQWv65YbuNqeBGONgMIYgLRY/uuUe4U+q3fAqVUt2r+77yTemMz6HWB8W36/pGdsmyPwbxVYm8dYnZ6Go+biw7rV0mUMTA4NfEDu+UTcv+SvhNcnT96vRG0Osd2pzH2b05Reuq9EyS2j3MogSXbabs4C4MQaNUUcNFHU+2UcbQLFeywCgH5vz0ufJsZRKELi6Shkd+6prlZlWooT+mWk9SUVq3N0Lo47cEpo17k7v5XVSZk+1b29ihr4AJ8FdYZHp30vx09IfE/S0eg/zYJ5r8jWzXjTuKPqqwwFYrR3LYZFXWINOzZE4z3hQo6Q0ESf5cSLJV7ZNy66oyoQ4eKAmLwk+H12LVHY+Z6vZbfeQEgG1Ebhbnb9
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2026 01:46:34.3820 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e87ad92c-85be-4820-4908-08deec4a0e50
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BY1PEPF0001AE1C.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6067
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

The individual.needs_update loop in amdgpu_vm_handle_moved() unconditionally
dereferenced bo_va->base.bo (to read its reservation object, ttm_tt and to test
for a DMABuf import). However bo_va->base.bo can legitimately be NULL for
PRT/sparse mappings - amdgpu_vm_bo_update() already handles a NULL bo via its
"else if (!bo)" PRT path. When such a bo_va reaches the moved list (e.g. the
userq eviction restore worker running amdgpu_vm_handle_moved() while a user
queue is being torn down during a GPU reset), the NULL deref crashes the kernel:

  BUG: kernel NULL pointer dereference, address: 0000000000000158
  #PF: supervisor read access in kernel mode
  Oops: 0000 [#1] SMP NOPTI
  Workqueue: events amdgpu_userq_restore_worker [amdgpu]
  RIP: 0010:amdgpu_vm_handle_moved+0x17a/0x200 [amdgpu]
  Call Trace:
   <TASK>
   amdgpu_userq_vm_validate_and_restore_queue+0x2ce/0x920 [amdgpu]
   amdgpu_userq_restore_worker+0xce/0x210 [amdgpu]
   process_scheduled_works+0xa6/0x460
   worker_thread+0x13c/0x290
   kthread+0xfb/0x140
   ret_from_fork+0x1b6/0x2b0
   ret_from_fork_asm+0x1a/0x30
   </TASK>

The faulting instruction is "mov rax,[rdx+0x158]" with rdx (bo) == 0 and
CR2 == 0x158, i.e. reading bo->tbo.base.resv off a NULL bo.

Guard the BO-less case: skip the reservation dance and the DMABuf-import check
when bo is NULL, and let amdgpu_vm_bo_update() take its existing PRT path.

Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index aac8ace9d7a6..fbb76c32bff9 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -1631,11 +1631,17 @@ int amdgpu_vm_handle_moved(struct amdgpu_device *adev,
 		bo_va = list_first_entry(&vm->individual.needs_update,
 					 typeof(*bo_va), base.vm_status);
 		bo = bo_va->base.bo;
-		resv = bo->tbo.base.resv;
+		resv = bo ? bo->tbo.base.resv : NULL;
 		spin_unlock(&vm->individual_lock);
 
+		/* PRT/sparse mappings have no BO to reserve; just update the
+		 * page tables (amdgpu_vm_bo_update() handles a NULL bo).
+		 */
+		if (!bo) {
+			clear = false;
+			unlock = false;
 		/* Try to reserve the BO to avoid clearing its ptes */
-		if (!adev->debug_vm && !amdgpu_ttm_tt_get_usermm(bo->tbo.ttm) &&
+		} else if (!adev->debug_vm && !amdgpu_ttm_tt_get_usermm(bo->tbo.ttm) &&
 		    dma_resv_trylock(resv)) {
 			clear = false;
 			unlock = true;
@@ -1659,7 +1665,7 @@ int amdgpu_vm_handle_moved(struct amdgpu_device *adev,
 		/* Remember evicted DMABuf imports in compute VMs for later
 		 * validation
 		 */
-		if (vm->is_compute_context &&
+		if (bo && vm->is_compute_context &&
 		    drm_gem_is_imported(&bo_va->base.bo->tbo.base) &&
 		    (!bo_va->base.bo->tbo.resource ||
 		     bo_va->base.bo->tbo.resource->mem_type == TTM_PL_SYSTEM))
-- 
2.49.0

