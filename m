Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFDE2C624D3
	for <amd-gfx@archiver.kernel.org>; Fri,  4 Sep 2026 12:59:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 44D1210F98B;
	Fri,  4 Sep 2026 12:59:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="4/8FWQsZ";
	dkim-atps=neutral
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010039.outbound.protection.outlook.com [52.101.56.39])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B5CFE10F928
 for <amd-gfx@lists.freedesktop.org>; Fri,  4 Sep 2026 12:59:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NHOh+qdsiQgOdg8c+VZWXEyH/yaMoHdBOQX3QCOHHWe1bRtWNoPI8YzxTwFOYXKCeHgadZY8V3OpnXb9YOHY3bR/p5Fwerbve6B/wg/ApV+yyqYPqvTYBxDpN+lssYPAm7XvKO/VYPgoKB+D+5N6Vkz1ucd6pDP+6hM5nQX1FQMZfa+Z7P7swTkPfUa+Otl5kbFaFKzA6N3NaSrYLUbgr9r2xhPhAJqX0LeZkYQss2gLzaYCgVb415JY8NG56mpE4Q6r7HuRVOHo4oYoHvHzoOBuA6GBo5gyagRsonxFQ10K1g+7NwPuggdDWVhPAOdk7IRWrMaZQXrl0Cqt3x4OzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qI34bd1KoZZMm7CkWz024FFtB5yb4DN5NA8OE8xS458=;
 b=PtSEaN4qh+NbLtaxIqDl70IXikPFPur3itQzkCanMEkX+X+JlHr7D7HkECbobVJ3LUKYvHmW2ZrT2KVJzVC9yxtwYi3K0n34+38hv+qB+9BntofKyP+fQ8mmhyzydS8aqb8wElIZX5SuTuNS3aJqj5/m6VCebdgwGaVLAjdZS82IOP9960H1NtNV6Fi8+30An+y6eLmpPr2k83zSkjwsaylyjxzkw3U9bf/Q4vDQjrdgdFFiNCK4sereXCidZ/MH+o+cR85BpuA9S7YNQmjXJNjVu/2vdIEZjQ8GbYjDg/Kb+wJDy2J7N9rCxm3nvWb7HXGEGoyOy2hYD0plUC+jTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qI34bd1KoZZMm7CkWz024FFtB5yb4DN5NA8OE8xS458=;
 b=4/8FWQsZuMqxJ2ZnEJFzlMWmtqXMGxcKSp435/gl/N7c3c/AgAlJbN49LwIqPkoJFGrDNWJHSApYk0dZPrRNrvjyz1Cut16x0P/3LHYqvJwzmyXoL2d7+ieR55mV6G4x4zsOgjxkk4HMpdZH6fhZDp68xVsXrrVZpRKDc74gHa4=
Received: from SJ0PR05CA0109.namprd05.prod.outlook.com (2603:10b6:a03:334::24)
 by DM4PR12MB8473.namprd12.prod.outlook.com (2603:10b6:8:183::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Fri, 4 Sep
 2026 12:59:42 +0000
Received: from SJ1PEPF000023D4.namprd21.prod.outlook.com
 (2603:10b6:a03:334:cafe::8b) by SJ0PR05CA0109.outlook.office365.com
 (2603:10b6:a03:334::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.11 via Frontend Transport; Fri, 4
 Sep 2026 12:59:42 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF000023D4.mail.protection.outlook.com (10.167.244.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.406.1 via Frontend Transport; Fri, 4 Sep 2026 12:59:42 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Fri, 4 Sep 2026 07:59:38 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>, Felix Kuehling <felix.kuehling@amd.com>,
 James Zhu <james.zhu@amd.com>, Lijo Lazar <lijo.lazar@amd.com>, Lancelot Six
 <lancelot.six@amd.com>, Natalie Vock <natalie.vock@gmx.de>, "Pierre-Eric
 Pelloux-Prayer" <pierre-eric.pelloux-prayer@amd.com>
Subject: [PATCH 1/3] drm/amdgpu/uapi: Add second-level trap handler ops to VM
 ioctl
Date: Fri, 4 Sep 2026 18:29:21 +0530
Message-ID: <20260904125923.321117-2-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260904125923.321117-1-srinivasan.shanmugam@amd.com>
References: <20260904125923.321117-1-srinivasan.shanmugam@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023D4:EE_|DM4PR12MB8473:EE_
X-MS-Office365-Filtering-Correlation-Id: d99e8032-e48b-4ae4-ec56-08df0a8462ea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|23010399003|1800799024|376014|36860700016|18002099003|22082099003|5023799004|56012099006|6133799003|11063799006|10067099003;
X-Microsoft-Antispam-Message-Info: WL9wEoYame/x6RGdsVFJ8WNzODRSeFCwmiSypaK1fgsPD7vdaxdEE6XQ9whtu9C0q1MLN6IWiH4HxhoTJPwViUxaVerAUNgda6/OJtEUGt99PDYo9MubzNkuhEADLITYgj0wO07EMigrLejlJ9I67VgHnLiZFdUBzBPKDmuY0kN05OftuPi/Y8W2FjkmbVIDo7ykwgaDQmNzpgLUQvgS28Y37VPjyC0R40hUiy4v7NTqhCswPsin5wCX+yfjFrr6yx5xE/Ri+Ii+SEh3rdjI/OnGlXyfjvPlx/2dOVIiYs5pv5W/NfBfdSmnjw8LEjp0ZA4WTXpotevKS7d82CdsqGtJOnM/UrNcZaWiZJBmJlyWR4mrJW4D+fM6fXSbf7Z1hXuRd/7hgV2kC/xJrC+90V7KdiDEUb1C4f2zKPIyU9AGNmdEIe64+JrYY+6pSJ12l0RqU3zuRGoz12i9erHqYeP8LGScF6CH3heEiTlkOT0jEpt6nE2w/sguoIAdryvGakahxhq9c6QOSeX/iIoLyX7I05gtKk1XOCO2g2w5R+bgGu1K7vu0jsMCvBzE1CxTuf/gANbqKU5MlwFd19lhVdR/H0ogm4U7QxtsPk6DgfmwfefcpU04Y8abzgxBGxjuKaY84CvO4FJrYXMeE9B1HjNLpLgx66vtZwGJ1ftT8IlOgVlan7PDA/FOEf1aOy6Ne6czEtgtm3x5SJMFmVFdlA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(23010399003)(1800799024)(376014)(36860700016)(18002099003)(22082099003)(5023799004)(56012099006)(6133799003)(11063799006)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: MeKNV0IzqAhpFG2DMMK/VgMp7skfNO+2pIzVYzt2g1ic1rSOfbPUtcKaruXzIVh1dKWBfvCF6Wyu8zTSWp+YildstS1g2GCKlGt+J2nw8svUotSWdWUpRYqePeoXXqqbKsg4Kpa472EMspdf7GPgcH+4xIZVZl9BRYEL5C5Ge/Ct+GmfTTDhgWco4iF9bgceFr1cYnwEK181ccuwsJqxqvgklX8EIkMAUC3wPbdjC0Fm+SR4sb03AJGFeAY9l45bLHANSVl6uuu4MNMS81TBZTUl65dV1+asE8ayv+mSfygGsUkgkE8k7bry4vBhJjHciUE/C2vuPt+AFni/4yNEvGNEraVQH2eIdDwOtaREjVSaEiN/sYVjISzot14YAVFFTsJy1NO43MVppr1GRknv+djmTdepDySC8Mb34zpJlOxuLVEk0YHD4sbbZ8ilp1vm
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2026 12:59:42.0146 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d99e8032-e48b-4ae4-ec56-08df0a8462ea
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000023D4.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB8473
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

When a GPU shader hits an exception, the hardware jumps to the
first-level trap handler. The first-level handler (managed by the kernel
via CWSR) checks the TMA buffer for a second-level handler address and
forwards the trap to userspace if one is installed.

KFD already supports this for compute workloads. Render-node user queues
had no equivalent mechanism. Add it via the VM ioctl.

Add two new VM ioctl operations:
  AMDGPU_VM_OP_SET_L2_TRAP   (op = 3)
  AMDGPU_VM_OP_CLEAR_L2_TRAP (op = 4)

Extend drm_amdgpu_vm_in with a 32-byte union for op-specific data.  The
l2trap member carries the GPU virtual addresses and sizes of the TBA
(handler code) and TMA (handler scratch memory). Existing ops only use
the first 8 bytes (op + flags); the union is zero-extended for those ops
by the DRM framework, so existing userspace is unaffected.

Both TBA and TMA buffers MUST be allocated with the
AMDGPU_GEM_CREATE_VM_ALWAYS_VALID flag. The GPU jumps to TBA
automatically on a hardware exception without any software job
submission, so the kernel cannot track TBA/TMA in a job's used-buffer
list. Without VM_ALWAYS_VALID the BO can be evicted and the page table
entry becomes stale, causing GPU page faults or corruption.

Explicit padding is used at every natural alignment boundary so the
layout is identical for native and 32-bit compat userspace.

The TRAP ioctl and its associated structures are removed entirely; the
ioctl number was never part of a released kernel.

v2:
  - Document VM_ALWAYS_VALID requirement in kdoc. The GPU jumps to TBA
    on hardware exception without any software submission so the kernel
    cannot track BOs in a job's used-buffer list. Without this flag,
    eviction leaves a stale page table entry (Natalie Vock).

Cc: Christian König <christian.koenig@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Felix Kuehling <felix.kuehling@amd.com>
Cc: James Zhu <james.zhu@amd.com>
Cc: Lijo Lazar <lijo.lazar@amd.com>
Cc: Lancelot Six <lancelot.six@amd.com>
Cc: Natalie Vock <natalie.vock@gmx.de>
Cc: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c  |   1 -
 drivers/gpu/drm/amd/amdgpu/amdgpu_trap.c | 105 +----------------------
 drivers/gpu/drm/amd/amdgpu/amdgpu_trap.h |   2 -
 include/uapi/drm/amdgpu_drm.h            |  98 ++++++++++++++++-----
 4 files changed, 77 insertions(+), 129 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index a93ee106ab92..6473faf18d71 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -3079,7 +3079,6 @@ const struct drm_ioctl_desc amdgpu_ioctls_kms[] = {
 	DRM_IOCTL_DEF_DRV(AMDGPU_SCHED, amdgpu_sched_ioctl, DRM_MASTER),
 	DRM_IOCTL_DEF_DRV(AMDGPU_BO_LIST, amdgpu_bo_list_ioctl, DRM_AUTH|DRM_RENDER_ALLOW),
 	DRM_IOCTL_DEF_DRV(AMDGPU_FENCE_TO_HANDLE, amdgpu_cs_fence_to_handle_ioctl, DRM_AUTH|DRM_RENDER_ALLOW),
-	DRM_IOCTL_DEF_DRV(AMDGPU_TRAP, amdgpu_trap_ioctl, DRM_AUTH | DRM_RENDER_ALLOW),
 	/* KMS */
 	DRM_IOCTL_DEF_DRV(AMDGPU_GEM_MMAP, amdgpu_gem_mmap_ioctl, DRM_AUTH|DRM_RENDER_ALLOW),
 	DRM_IOCTL_DEF_DRV(AMDGPU_GEM_WAIT_IDLE, amdgpu_gem_wait_idle_ioctl, DRM_AUTH|DRM_RENDER_ALLOW),
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_trap.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_trap.c
index 31f653ec3fb1..804b4b4f65bb 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_trap.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_trap.c
@@ -505,109 +505,6 @@ void amdgpu_trap_free(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 	*trap_obj = NULL;
 }
 
-static int amdgpu_trap_validate_user_addr(struct amdgpu_device *adev,
-					  struct amdgpu_vm *vm,
-					  struct amdgpu_trap_usr_addr *usr_addr)
-{
-	struct amdgpu_bo_va_mapping *va_map;
-	uint64_t addr;
-	uint32_t size;
-	int r;
-
-	addr = (usr_addr->addr & AMDGPU_GMC_HOLE_MASK) >> AMDGPU_GPU_PAGE_SHIFT;
-	size = usr_addr->size >> AMDGPU_GPU_PAGE_SHIFT;
-
-	r = amdgpu_bo_reserve(vm->root.bo, false);
-	if (r)
-		return r;
-
-	va_map = amdgpu_vm_bo_lookup_mapping(vm, addr);
-	if (!va_map) {
-		r = -EINVAL;
-		goto err;
-	}
-	/* validate whether resident in the VM mapping range */
-	if (addr >= va_map->start && va_map->last - addr + 1 >= size) {
-		amdgpu_bo_unreserve(vm->root.bo);
-		return 0;
-	}
-
-	r = -EINVAL;
-err:
-	amdgpu_bo_unreserve(vm->root.bo);
-
-	return r;
-}
-
-static int amdgpu_trap_set_l2_trap_handler(struct amdgpu_device *adev, struct amdgpu_vm *vm,
-					   struct amdgpu_trap_obj *cwsr_obj,
-					   struct amdgpu_trap_usr_addr *tma,
-					   struct amdgpu_trap_usr_addr *tba)
-{
-	uint64_t *l1tma;
-	int r;
-
-	if (!amdgpu_trap_is_enabled(adev))
-		return -EOPNOTSUPP;
-
-	if (!cwsr_obj || !cwsr_obj->tma_cpu_addr || !tma || !tba)
-		return -EINVAL;
-	r = amdgpu_trap_validate_user_addr(adev, vm, tma);
-	if (r)
-		return r;
-	r = amdgpu_trap_validate_user_addr(adev, vm, tba);
-	if (r)
-		return r;
-
-	l1tma = (uint64_t *)(cwsr_obj->tma_cpu_addr);
-	l1tma[0] = tma->addr;
-	l1tma[1] = tba->addr;
-
-	return 0;
-}
-
-/*
- * Userspace trap handler related ioctl
- */
-/**
- * amdgpu_trap_ioctl - Handle trap handler specific requests.
- *
- * @dev: drm device pointer
- * @data: request object
- * @filp: drm filp
- *
- * This function is used to perform cwsr and trap handler related operations
- * Returns 0 on success, error code on failure.
- */
-int amdgpu_trap_ioctl(struct drm_device *dev, void *data, struct drm_file *filp)
-{
-	struct amdgpu_device *adev = drm_to_adev(dev);
-	union drm_amdgpu_trap *cwsr = data;
-	struct amdgpu_fpriv *fpriv;
-	int r;
-
-	fpriv = (struct amdgpu_fpriv *)filp->driver_priv;
-
-	if (!fpriv->trap_obj)
-		return -EOPNOTSUPP;
-
-	switch (cwsr->in.op) {
-	case AMDGPU_TRAP_OP_SET_L2_TRAP: {
-		struct amdgpu_trap_usr_addr tba;
-		struct amdgpu_trap_usr_addr tma;
-
-		tba.addr = cwsr->in.l2trap.tba_va;
-		tba.size = cwsr->in.l2trap.tba_sz;
-		tma.addr = cwsr->in.l2trap.tma_va;
-		tma.size = cwsr->in.l2trap.tma_sz;
-		r = amdgpu_trap_set_l2_trap_handler(adev, &fpriv->vm, fpriv->trap_obj, &tma, &tba);
-	} break;
-	default:
-		return -EINVAL;
-	}
-
-	return r;
-}
 
 int amdgpu_trap_set_trap_debug_flag(struct amdgpu_device *adev,
 				    struct amdgpu_trap_obj *cwsr_obj,
@@ -625,4 +522,4 @@ int amdgpu_trap_set_trap_debug_flag(struct amdgpu_device *adev,
 	l1tma[2] = enabled;
 
 	return 0;
-}
\ No newline at end of file
+}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_trap.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_trap.h
index 6d4664469bad..495ffd3f1dd8 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_trap.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_trap.h
@@ -92,8 +92,6 @@ static inline bool amdgpu_trap_has_dbg_wa(struct amdgpu_device *adev)
 	return gc_ver >= IP_VERSION(11, 0, 0) && gc_ver <= IP_VERSION(11, 0, 3);
 }
 
-int amdgpu_trap_ioctl(struct drm_device *dev, void *data,
-		      struct drm_file *filp);
 int amdgpu_trap_set_trap_debug_flag(struct amdgpu_device *adev,
 				    struct amdgpu_trap_obj *cwsr_obj,
 				    bool enabled);
diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.h
index 552cbf483543..d21c7a85e81e 100644
--- a/include/uapi/drm/amdgpu_drm.h
+++ b/include/uapi/drm/amdgpu_drm.h
@@ -59,7 +59,6 @@ extern "C" {
 #define DRM_AMDGPU_USERQ_WAIT		0x18
 #define DRM_AMDGPU_GEM_LIST_HANDLES	0x19
 #define DRM_AMDGPU_PROC_OPTIONS		0x1A
-#define DRM_AMDGPU_TRAP			0x1B
 
 #define DRM_IOCTL_AMDGPU_GEM_CREATE	DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_GEM_CREATE, union drm_amdgpu_gem_create)
 #define DRM_IOCTL_AMDGPU_GEM_MMAP	DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_GEM_MMAP, union drm_amdgpu_gem_mmap)
@@ -82,7 +81,6 @@ extern "C" {
 #define DRM_IOCTL_AMDGPU_USERQ_WAIT	DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_USERQ_WAIT, struct drm_amdgpu_userq_wait)
 #define DRM_IOCTL_AMDGPU_GEM_LIST_HANDLES DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_GEM_LIST_HANDLES, struct drm_amdgpu_gem_list_handles)
 #define DRM_IOCTL_AMDGPU_PROC_OPTIONS	DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_PROC_OPTIONS, struct drm_amdgpu_proc_options)
-#define DRM_IOCTL_AMDGPU_TRAP	DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_TRAP, union drm_amdgpu_trap)
 
 /**
  * DOC: memory domains
@@ -634,10 +632,86 @@ struct drm_amdgpu_userq_wait {
 #define AMDGPU_VM_OP_RESERVE_VMID	1
 #define AMDGPU_VM_OP_UNRESERVE_VMID	2
 
+/**
+ * AMDGPU_VM_OP_SET_L2_TRAP - install or replace the second-level trap
+ *   handler for all GFX and compute user queues belonging to this VM.
+ *
+ * The second-level trap handler is a per-VM setting. All shader waves
+ * executing under this VMID share the same handler regardless of queue
+ * type. GFX and compute queues from the same process share the same VMID
+ * so one SET_L2_TRAP covers all queue types for this DRM file.
+ *
+ * IMPORTANT: Both TBA and TMA buffers MUST be allocated with the
+ * AMDGPU_GEM_CREATE_VM_ALWAYS_VALID flag. The GPU jumps to TBA
+ * automatically on a hardware exception without any software job
+ * submission, so the kernel cannot track TBA/TMA in a job's used-buffer
+ * list. Without VM_ALWAYS_VALID the BO can be evicted and the page
+ * table entry becomes stale, causing a GPU page fault or memory
+ * corruption when the next shader exception fires.
+ *
+ * The TBA range must contain the handler executable code.
+ * The TMA range is the handler scratch memory buffer.
+ * Both ranges must be non-empty and fully mapped in the GPU virtual
+ * address space of this DRM file descriptor.
+ *
+ * Userspace should keep both mappings alive until
+ * AMDGPU_VM_OP_CLEAR_L2_TRAP succeeds. If either mapping is removed
+ * while the handler is active, the kernel waits for the VM to be idle,
+ * evicts all user queues, flushes the GPU TLB, clears the handler, and
+ * allows the unmap to proceed. UNMAP never returns an error for this
+ * condition. Queues whose trap handler VA was removed are not restarted.
+ *
+ * Returns:
+ *  0             on success;
+ *  -EOPNOTSUPP   if the first-level CWSR handler is unavailable;
+ *  -EINVAL       if TBA/TMA is invalid, not mapped, or not allocated
+ *                with AMDGPU_GEM_CREATE_VM_ALWAYS_VALID;
+ *  negative errno if the VM reservation fails.
+ */
+#define AMDGPU_VM_OP_SET_L2_TRAP	3
+
+/**
+ * AMDGPU_VM_OP_CLEAR_L2_TRAP - disable the second-level trap handler.
+ *
+ * All active user queues are evicted and the GPU TLB is flushed before
+ * TBA is zeroed to ensure no wave is executing inside the handler at the
+ * time of the clear. The l2trap input members are ignored.
+ *
+ * After this operation succeeds userspace may safely remove the TBA
+ * and TMA mappings.
+ *
+ * Returns:
+ *  0             on success;
+ *  -EOPNOTSUPP   if the first-level CWSR handler is unavailable;
+ *  negative errno if the VM reservation fails.
+ */
+#define AMDGPU_VM_OP_CLEAR_L2_TRAP	4
+
 struct drm_amdgpu_vm_in {
 	/** AMDGPU_VM_OP_* */
 	__u32	op;
 	__u32	flags;
+	union {
+		struct {
+			/** GPU VA of second-level trap handler code buffer */
+			__u64 tba_va;
+			/** TBA buffer size in bytes */
+			__u32 tba_sz;
+			/** Explicit padding; tma_va starts at offset 24 */
+			__u32 _pad;
+			/** GPU VA of second-level trap handler scratch buffer */
+			__u64 tma_va;
+			/** TMA buffer size in bytes */
+			__u32 tma_sz;
+			/** Padding to fix total union size at 32 bytes */
+			__u32 _pad2;
+		} l2trap;
+		/**
+		 * Padding — keeps the union at a fixed 32-byte size for
+		 * future ops. Zero-initialise for RESERVE/UNRESERVE_VMID.
+		 */
+		__u64 _pad[4];
+	};
 };
 
 struct drm_amdgpu_vm_out {
@@ -1747,27 +1821,7 @@ struct drm_amdgpu_info_cwsr {
 	__u32 min_save_area_size;
 };
 
-/* cwsr ioctl */
-#define AMDGPU_TRAP_OP_SET_L2_TRAP 1
 
-struct drm_amdgpu_trap_in {
-	/* AMDGPU_TRAP_OP_* */
-	__u32 op;
-	struct {
-		/* Level 2 trap handler base address */
-		__u64 tba_va;
-		/* Level 2 trap handler buffer size (in bytes) */
-		__u32 tba_sz;
-		/* Level 2 trap memory buffer address */
-		__u64 tma_va;
-		/* Level 2 trap memory buffer size (in bytes) */
-		__u32 tma_sz;
-	} l2trap;
-};
-
-union drm_amdgpu_trap {
-	struct drm_amdgpu_trap_in in;
-};
 /*
  * Supported GPU families
  */
-- 
2.34.1

