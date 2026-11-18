Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D86C0606A330
	for <amd-gfx@archiver.kernel.org>; Wed, 18 Nov 2026 18:52:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=wVKXul6a
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7D2AD10FF63;
	Wed, 18 Nov 2026 18:52:53 +0000 (UTC)
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010064.outbound.protection.outlook.com [52.101.46.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 335AF10FF63
 for <amd-gfx@lists.freedesktop.org>; Wed, 18 Nov 2026 18:52:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=V+l11vkhTdGD8meaZQugskTtTjKRTtT1UZmM+vufS/r2m9lYSmxUGjRT9lYUjDuLgjV1VfvMZ/zH1tqcDWA0z/X3o2SBa7Fpgs2XzpTJ684iyR35X9ZtXpiLXhpGsiKar2Mm9V1d+pBbsLi6raYS4/JoCM6Mizu/gtqcNliqrmi8Qw3JUh6bvUlPhDfK25gzw5S33m0qScdN0p0qbL6qnAcp7Bz1tOdhvAUOPzfsyKbxk4rr3C2fX7TQB29AKRhJr0OMOEu0iyZcceVNE6fNfK8mJcTCZxG7qepPtSYAvOWxGcCg38hu75T9k4xEDKLhlhZ/gH6dXH100HbrMgf2eA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ujLAPL+RhSpNLPRJd2Gr8Qeva5ve2N05GRSxu6YK+vc=;
 b=X/CkLMUyriznw/BVsjmczpTkOX0rDrCqtW4tjXBpsENWDX1UsUQLrxhi5+SyqxC1w0Symz4/tolJVoCwYJJ88RAOWOntExKNtNmnBwlUh288UvyVdK1gauvap1LCY/eqlY4lrs9oky9mj0mT1685ag7TP/Hm4gw//0nKqbV+tKoTWWRtTrxKFrFan/UWG/chEJJhILPKt3ckgR2jlaO/Y6dHDiTBMh0JNjnLlMvt61pTXY8++TzvNMvV9Oy7gub13+BtBTkKJwqarPYOnvvQ6vWf1NtnCPhf3y7oqPmgpqfKvRWI/XmNwVq49+I5ETn+PCbR3gGztaOikdkhzqmsNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ujLAPL+RhSpNLPRJd2Gr8Qeva5ve2N05GRSxu6YK+vc=;
 b=wVKXul6aA2uNhBCk3YhHwo2J0n/UQ0OLY7VNf9jzvRPuovh3vgoyR/nQorGU8lxWVxiRqSXOa2G46v7IIx7uKbA5i8EmGWGR5Bu0yQmxMv11oEblND8Y9T4hN20NuvHfqqUQ0hRvgjXOFGRuHfhHJrjLySelwIvnQPN1eys28eg=
Received: from CH2PR16CA0022.namprd16.prod.outlook.com (2603:10b6:610:50::32)
 by DS4PR12MB444842.namprd12.prod.outlook.com (2603:10b6:8:3e8::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Wed, 18 Nov
 2026 18:52:42 +0000
Received: from DS2PEPF00006E24.namprd05.prod.outlook.com
 (2603:10b6:610:50:cafe::a9) by CH2PR16CA0022.outlook.office365.com
 (2603:10b6:610:50::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.8 via Frontend Transport; Wed, 18
 Nov 2026 18:52:42 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS2PEPF00006E24.mail.protection.outlook.com (10.167.23.217) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Wed, 18 Nov 2026 18:52:41 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Wed, 18 Nov
 2026 12:52:41 -0600
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Wed, 18 Nov
 2026 12:52:40 -0600
Received: from bencheng-dev (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.57 via Frontend
 Transport; Wed, 18 Nov 2026 12:52:40 -0600
From: Benjamin Cheng <benjamin.cheng@amd.com>
To: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 <amd-gfx@lists.freedesktop.org>
CC: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>, "Shahyan
 Soltani" <shahyan.soltani@amd.com>, Benjamin Cheng <benjamin.cheng@amd.com>
Subject: [PATCH 4/8] drm/amdgpu: reserve only what the caller asks for in
 lock_pd
Date: Wed, 18 Nov 2026 13:52:21 -0500
Message-ID: <20261118185225.1857845-5-benjamin.cheng@amd.com>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261118185225.1857845-1-benjamin.cheng@amd.com>
References: <20261118185225.1857845-1-benjamin.cheng@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00006E24:EE_|DS4PR12MB444842:EE_
X-MS-Office365-Filtering-Correlation-Id: ddee4dc5-26ea-47fb-124b-08df45a52008
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|376014|23010399003|1800799024|22082099003|18002099003|261009223027099003|11063799006|261028144727099003|261022075727099003|56012099006|261021121427099003|261022105027099003|261021123027099003|261102123227099003|261026121527099003|261026140227099003|10067099003;
X-Microsoft-Antispam-Message-Info: uUDsc7bHH7NPPXKgPsObjSsixFSdvoYhlm5OREBXizuo1BdtlUN8p6ErlWFzFAXqoAyUya7X7LtCiqE86kjzi2VYPk047TxhfH9/hP2cJ9lktZnG0O+rAkmWItFR5NZtJLaAFKfMpP5wxevTIkYL6K1b4CtuO7UKmrt38dNsmdZZDYBZaNg3ey68lbISRC+AmAXUmXMVFNNLo/VSOGW9p9B3cy/317QCyrb50X4ExMnWhbYTKtUfas4ZnFXuKvWjBFks3DYX3y+TCHOwbbDXXI4Aaf+mKs0f/9WBJ+qTwMcm+71OzI6suZB4CcchCGwqmBzxOATsW/cj1QJguEDCVzSZ5Eq8sgvfFiF8u0elSWwTpkTIv+mb3vhzNMfH3x4lLabkcThInRjOSIGtnbwQCEE70ZJR1louxc4KUVTUuhvEEEt9ASvGUEPeu2PKFbmilD6m10ywDmTiS2oYN5uDCp+xyFedeV4RRU0LtYW6ndwWwmY1aJ4bx9gnDIGBWCb6v/zue1trfESBPJxrJ5lY/Oo8o/10qh60e04hX7Mse48V9rNeIbkfukQ8YdfinkirdXUK1wrGtwTnxuN1HipU58Kk3zxMXxZXI7yF1KXKJ4uLlaaBWABAZe8mZ1jm17Ee+oHGhmVvCmWV0fz6TF54UaThDsN8z6BsiCmSLZWZJEPcpbmNBiyec/KwOaK0j8Fzx8ymgIfnBMEjAtdQz+UYCQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(376014)(23010399003)(1800799024)(22082099003)(18002099003)(261009223027099003)(11063799006)(261028144727099003)(261022075727099003)(56012099006)(261021121427099003)(261022105027099003)(261021123027099003)(261102123227099003)(261026121527099003)(261026140227099003)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: Ay9znTb6qmAYQYKxahlydLnYBgaXvmp66A3JWNYFXRtsTeX4RjTX04B3xso7FN4GK+80spJbAu76YRZibPefCRh9FukILAPmg6dqHA8hEN+ohqlVrcTyYIOq4LR2W7GS9kUa3tNdlDHi59NFl4vsHXO7k2Tya/CcqnQJqogt3MfuYXdwO/2xUyZ38qhgN58V8WrZCpHlQX1rPSrQ5JUz8nq4vn6ivkCllBXRm3sRDtHsb1jUrph6pzM8OPL0exNmO7lDGoQ6S6eWOrbJT9890aa4xjkji2kn2fM0CmTbl24FcBWt6LPAs538zBMuUvjQCEvyhvZhmbWkpQFY7P0u4aiaaWQ7kpsNe3emaJ/KrSOcKcZfdUXQnGcc8vZ9gy994MiHCvG7XOR7VfnBuMuQhJNUFRUiBu24phCFFBk+RFpA2EiYpjWPc4ez6u5Kv9aJ
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2026 18:52:41.8396 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ddee4dc5-26ea-47fb-124b-08df45a52008
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF00006E24.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR12MB444842
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

amdgpu_vm_lock_pd() reserved AMDGPU_VM_UPDATE_FENCES for every caller,
including ones that only lock the root PD to add or remove a mapping and
never update the page tables.

Address this by making it only reserve what the caller asks for, so that
such callers have the option to not over-reserve. The only touched
call-sites in this change are the ones that do require fences.

Signed-off-by: Benjamin Cheng <benjamin.cheng@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c | 13 ++++++++-----
 drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c           |  3 ++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c          |  5 +++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c       |  6 ++++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c        |  6 +++---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c           |  8 +++++---
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c             |  3 ++-
 7 files changed, 27 insertions(+), 17 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
index a6616447abc8..56f761089b87 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
@@ -1188,7 +1188,8 @@ static int reserve_bo_and_vm(struct kgd_mem *mem,
 	ctx->sync = &mem->sync;
 	drm_exec_init(&ctx->exec, DRM_EXEC_INTERRUPTIBLE_WAIT, 0);
 	drm_exec_until_all_locked(&ctx->exec) {
-		ret = amdgpu_vm_lock_pd(vm, &ctx->exec, 2);
+		ret = amdgpu_vm_lock_pd(vm, &ctx->exec,
+					AMDGPU_VM_UPDATE_FENCES + 2);
 		drm_exec_retry_on_contention(&ctx->exec);
 		if (unlikely(ret))
 			goto error;
@@ -1235,8 +1236,8 @@ static int reserve_bo_and_cond_vms(struct kgd_mem *mem,
 				&& map_type != BO_VM_ALL))
 				continue;
 
-			ret = amdgpu_vm_lock_pd(entry->bo_va->base.vm,
-						&ctx->exec, 2);
+			ret = amdgpu_vm_lock_pd(entry->bo_va->base.vm, &ctx->exec,
+						AMDGPU_VM_UPDATE_FENCES + 2);
 			drm_exec_retry_on_contention(&ctx->exec);
 			if (unlikely(ret))
 				goto error;
@@ -2729,7 +2730,8 @@ static int validate_invalid_user_pages(struct amdkfd_process_info *process_info)
 		/* Reserve all the page directories */
 		list_for_each_entry(peer_vm, &process_info->vm_list_head,
 				    vm_list_node) {
-			ret = amdgpu_vm_lock_pd(peer_vm, &exec, 2);
+			ret = amdgpu_vm_lock_pd(peer_vm, &exec,
+						AMDGPU_VM_UPDATE_FENCES + 2);
 			drm_exec_retry_on_contention(&exec);
 			if (unlikely(ret))
 				goto unreserve_out;
@@ -2993,7 +2995,8 @@ int amdgpu_amdkfd_gpuvm_restore_process_bos(void *info, struct dma_fence __rcu *
 	drm_exec_until_all_locked(&exec) {
 		list_for_each_entry(peer_vm, &process_info->vm_list_head,
 				    vm_list_node) {
-			ret = amdgpu_vm_lock_pd(peer_vm, &exec, 2);
+			ret = amdgpu_vm_lock_pd(peer_vm, &exec,
+						AMDGPU_VM_UPDATE_FENCES + 2);
 			drm_exec_retry_on_contention(&exec);
 			if (unlikely(ret)) {
 				pr_err("Locking VM PD failed, ret: %d\n", ret);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
index 71e2b83faa12..771ab4388eb1 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
@@ -940,7 +940,8 @@ static int amdgpu_cs_parser_bos(struct amdgpu_cs_parser *p,
 	}
 
 	drm_exec_until_all_locked(&p->exec) {
-		r = amdgpu_vm_lock_pd(&fpriv->vm, &p->exec, 1 + p->gang_size);
+		r = amdgpu_vm_lock_pd(&fpriv->vm, &p->exec,
+				      AMDGPU_VM_UPDATE_FENCES + 1 + p->gang_size);
 		drm_exec_retry_on_contention(&p->exec);
 		if (unlikely(r))
 			goto out_free_user_pages;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
index eb7473ed9e0e..dfb44426b1e2 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
@@ -345,7 +345,7 @@ static void amdgpu_gem_object_close(struct drm_gem_object *obj,
 		if (unlikely(r))
 			goto out_unlock;
 
-		r = amdgpu_vm_lock_pd(vm, &exec, 0);
+		r = amdgpu_vm_lock_pd(vm, &exec, AMDGPU_VM_UPDATE_FENCES);
 		drm_exec_retry_on_contention(&exec);
 		if (unlikely(r))
 			goto out_unlock;
@@ -1002,7 +1002,8 @@ int amdgpu_gem_va_ioctl(struct drm_device *dev, void *data,
 				goto error;
 		}
 
-		r = amdgpu_vm_lock_pd(&fpriv->vm, &exec, 2);
+		r = amdgpu_vm_lock_pd(&fpriv->vm, &exec,
+				      AMDGPU_VM_UPDATE_FENCES + 2);
 		drm_exec_retry_on_contention(&exec);
 		if (unlikely(r))
 			goto error;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
index 2403cd911058..8a613d83ed53 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
@@ -3053,7 +3053,8 @@ static void amdgpu_ualink_invalidate_import_mappings(struct amdgpu_bo *bo)
 			goto fini;
 
 		for (bo_base = bo->vm_bo; bo_base; bo_base = bo_base->next) {
-			r = amdgpu_vm_lock_pd(bo_base->vm, &exec, 0);
+			r = amdgpu_vm_lock_pd(bo_base->vm, &exec,
+					      AMDGPU_VM_UPDATE_FENCES);
 			drm_exec_retry_on_contention(&exec);
 			if (unlikely(r))
 				goto fini;
@@ -4788,7 +4789,8 @@ static int amdgpu_ualink_reserve_npa_vm_and_bos(struct amdgpu_device *adev,
 				goto out;
 		}
 
-		r = amdgpu_vm_lock_pd(&adev->ualink.npa_vm, exec, 0);
+		r = amdgpu_vm_lock_pd(&adev->ualink.npa_vm, exec,
+				      AMDGPU_VM_UPDATE_FENCES);
 		drm_exec_retry_on_contention(exec);
 		if (unlikely(r))
 			goto out;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
index ed6f3b67e872..73e58d1a32ba 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
@@ -1054,10 +1054,10 @@ amdgpu_userq_vm_validate_and_restore_queue(struct amdgpu_userq_mgr *uq_mgr)
 	drm_exec_init(&exec, DRM_EXEC_IGNORE_DUPLICATES, 0);
 	drm_exec_until_all_locked(&exec) {
 		/*
-		 * Rearm adds one BOOKKEEP fence and validation may queue move fences
-		 * on the root PD BO, so reserve caller-side slots accordingly.
+		 * Rearm adds one BOOKKEEP fence and validation requires
+		 * AMDGPU_VM_UPDATE_FENCES.
 		 */
-		ret = amdgpu_vm_lock_pd(vm, &exec, TTM_NUM_MOVE_FENCES + 1);
+		ret = amdgpu_vm_lock_pd(vm, &exec, AMDGPU_VM_UPDATE_FENCES + 1);
 		drm_exec_retry_on_contention(&exec);
 		if (unlikely(ret))
 			goto unlock_all;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index f4a836594e7c..daf0e75d0bb1 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -455,15 +455,17 @@ void amdgpu_vm_bo_base_init(struct amdgpu_vm_bo_base *base,
  *
  * @vm: vm providing the BOs
  * @exec: drm execution context
- * @num_fences: number of extra fences to reserve
+ * @num_fences: number of fence slots to reserve, 0 to only lock the PD
  *
  * Lock the VM root PD in the DRM execution context.
  */
 int amdgpu_vm_lock_pd(struct amdgpu_vm *vm, struct drm_exec *exec,
 		      unsigned int num_fences)
 {
-	return drm_exec_prepare_obj(exec, &vm->root.bo->tbo.base,
-				    AMDGPU_VM_UPDATE_FENCES + num_fences);
+	if (!num_fences)
+		return drm_exec_lock_obj(exec, &vm->root.bo->tbo.base);
+
+	return drm_exec_prepare_obj(exec, &vm->root.bo->tbo.base, num_fences);
 }
 
 /**
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
index 3f32507e2aae..6dcc12289e92 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -1686,7 +1686,8 @@ static int svm_range_reserve_bos(struct svm_validate_context *ctx, bool intr)
 			}
 			vm = drm_priv_to_vm(pdd->drm_priv);
 
-			r = amdgpu_vm_lock_pd(vm, &ctx->exec, 2);
+			r = amdgpu_vm_lock_pd(vm, &ctx->exec,
+					      AMDGPU_VM_UPDATE_FENCES + 2);
 			drm_exec_retry_on_contention(&ctx->exec);
 			if (unlikely(r)) {
 				pr_debug("failed %d to reserve bo\n", r);
-- 
2.56.1

