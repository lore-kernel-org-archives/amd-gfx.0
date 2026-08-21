Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E61AEC5DF7D
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Aug 2026 19:51:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 73E5E10F417;
	Fri, 21 Aug 2026 19:51:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="QbrB48SN";
	dkim-atps=neutral
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012070.outbound.protection.outlook.com [52.101.53.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B11BC10F401
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Aug 2026 19:51:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LKmCb5SJmNdynJeTGvOou39oYMnLBO+JG1Oz8r0ZxgiQw2npTVi1ITB3tzMuSTrFjgkd3o3kD1IQ7+cwtLCOZZFKzubxemTlYnj4ox9ua5EdtWf+12YgRHjxaN0oREm1lNnIUiFNsYSlkhdw7ik93cI15R+32OGC18ASAc6wtE3mUluJYpLkWahkd0LZsObls3d7AXEMyOK8FJWQq5DGWCoZVPIJ1LGbsiwhZRU3DhilmeBCQ5bK2k9kXsXf3DCtW6PoxIe1xn/hUJnVzo4f3FILBBxkHgnsCk+xGssmmJ0XfDkcDIUdxuTrRis0cYX4OTpma7iPl5IMUp95vD+nYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yqUs+D1CnH8CuQY8FhXfGC8HEAGXvIY/u6pCKr2VUWc=;
 b=yWbr4RKHuIkoqOMZ9ZS3oOKfPakI8Boc4slQ5+QBOAV34Qygsk4QCbZO7j0RR57Y38atdCYw1tpvbSIo+qsPbaAajTNEN67/Dx2aYsj6PHOsEinr2BR3QCj2hqwAjNRxsCqNH5HHkn0K0VsfPXPYkMVKY6wm5KVzvLOMEfswLlfcZibQOIb1wemioFn9xb7KB8eeW2qnDyYjkP8guTs2FO02dREZ6IE7D1nJxCbHPeGNB8M1m0QUhI+5GtPK1gfoPDho+se7NMgWFnN6tw+xv+NXYUdhBgwfCrNmklPT/J1r0QngfC2e72JRy+ifMLPljICe1XE231wvCfMdI+G2ww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yqUs+D1CnH8CuQY8FhXfGC8HEAGXvIY/u6pCKr2VUWc=;
 b=QbrB48SNNYEURVKf1N7sPFDXdwCdlcb65pXFDQ56UJ0qt7///Gmh2cHXceRx88EHLNhXdytZ9kkr+xIhmylM+dK+pWAUTe5IdB1Nbzu+poXooa2ERFyggeoLYtyXAArdyLRpYcCy8GcP1KU3zdXiIyvp43JkHg7xnl7AMhMz6GQ=
Received: from CH2PR12CA0030.namprd12.prod.outlook.com (2603:10b6:610:57::40)
 by DS0PR12MB9273.namprd12.prod.outlook.com (2603:10b6:8:193::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.10; Fri, 21 Aug
 2026 19:36:02 +0000
Received: from CH1PEPF0000AD83.namprd04.prod.outlook.com
 (2603:10b6:610:57:cafe::73) by CH2PR12CA0030.outlook.office365.com
 (2603:10b6:610:57::40) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.339.11 via Frontend Transport; Fri,
 21 Aug 2026 19:36:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH1PEPF0000AD83.mail.protection.outlook.com (10.167.244.85) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.3 via Frontend Transport; Fri, 21 Aug 2026 19:36:01 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 21 Aug
 2026 14:35:55 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 21 Aug
 2026 14:35:55 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.45 via Frontend
 Transport; Fri, 21 Aug 2026 14:35:54 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Felix Kuehling <felix.kuehling@amd.com>, Mukul Joshi
 <mukul.joshi@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 71/95] drm/amdgpu: Pin page tables in NPA VMs
Date: Fri, 21 Aug 2026 15:34:34 -0400
Message-ID: <20260821193458.808626-72-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260821193458.808626-1-alexander.deucher@amd.com>
References: <20260821193458.808626-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD83:EE_|DS0PR12MB9273:EE_
X-MS-Office365-Filtering-Correlation-Id: 4eaeccc2-a976-456d-752c-08deffbb6e89
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|82310400026|36860700016|1800799024|376014|18002099003|22082099003|3023799007|56012099006|11063799006|10067099003;
X-Microsoft-Antispam-Message-Info: qTSlbAST/nyiwOTnODlCoFmVD7SN/7ByquP/wYC5oYaXrD3tPARkjcn5KyQ+2sT99Txvx5D+TYD1t5wV1IgIYdfsNGLkwaR4iNxVRWDa+BreKBx/TKGz1DdfqD1W/wo0CZ5mQm2btA9DqpGFaJmXP8eK8N1KAL9BoNPkeUf30VqW7D9a3HaW7mP3ari2IeDS+Op/+fnhZwI3VHAZtxfToHcTa9ZrDtmvssOB/S+XXAAN2e2cMzWlyFSlts3w4Yusx/gc9ZMJj3EPOw0n+DsFDtnXECVphFTJMj/63sd77IS7G8JMDusI5gsulL3hVkFqsHNZy2oTC+xAj4Ar60YVIFM00JpYSgQmoHdZLzvbaH8AD6toKd3rtAP7b26t+PLrQN2xwnZJcVeHMZ6J4Hfonu3hGCwuV/xwF70QH3E5mqkL50/eOKE1Nh7RkMYwYbVr/Zj1UICfIfuQ45ds/wZvCufH0mSOgiJwt12pWpGVWcml77gVgKTI4LfDh8YFKq9Z6k+o75FgeCNXP/r9GbCA9nRGMJh8cuoP7t2akllDhR8gpwujWvkqXYNIKd5hPL3bGalRigKbWHpcQ2llpGSZ1tIvprh61fjSBtMHsjOQHJr2VZn8YWbCXxkXCumJXWXcNhjQ5frhhilaypD5A5jXEQm7+qIroXeAR/uNhXg6b/Gjui26ja6bXtpqEE08iai39D67scNqhUs4g5TgAXC1YQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(82310400026)(36860700016)(1800799024)(376014)(18002099003)(22082099003)(3023799007)(56012099006)(11063799006)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: OK56peNQxndN8r6+HIbD+PFX8AViweQUCUFaXLPuZZUTPhQujYtn4gvsUt23xMHxgFPkqjhGsef+YegisarMSU+l58mON2mRqc3edUKSODMNO8hPuLBQ5y3ehHgX3cwk104RqW4pF0/h3v8fBaE/mBC/w73YMe/ChJy1iNyiyZiuR++8xhNcovEuiS2GwQ8cV2u8wqkLKrCt9q4HTrkhCyF2bvOZN1Yw7c6rhcxYiZsjcKTBafjvJnHHfOwmQUAW6ZlI+JtQCU+PvyhuY2zjy8ZUHrHHIR3CIn2ivKdWjB57BEuPKcFAfVKOAE8EzGR2yaW9NypOWyQ9gJqBOD+mN8lZppQjcB2tDCOzvZY3ibZSRMHggR+K5EKXGbVtfd7f06NdD2fXT1Mcqq9w5ppA64JgJdJ0SVdGehkoUa7dMW8sowdNGPg/QEn6fNJRMS3S
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2026 19:36:01.1213 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4eaeccc2-a976-456d-752c-08deffbb6e89
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000AD83.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9273
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

From: Felix Kuehling <felix.kuehling@amd.com>

With latest POR, remote importers aren't guaranteed to support
instruction replay-on-fault. Therefore, we cannot support unpinned
exports or unpinned page-tables in the exporter mappings into NPA space.

Signed-off-by: Felix Kuehling <felix.kuehling@amd.com>
Reviewed-by: Mukul Joshi <mukul.joshi@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c |  4 +--
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c     | 40 ++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h     |  3 ++
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c  | 25 +++++++++++++-
 4 files changed, 69 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
index 68faf2a30e0a1..f45edc882b2f2 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
@@ -3397,8 +3397,8 @@ int amdgpu_ualink_manager_start(struct amdgpu_device *adev)
 	if (r)
 		goto out;
 
-	/* For using CPU for page table updates. */
-	r = amdgpu_vm_make_compute(adev, &adev->ualink.npa_vm);
+	/* For pinning page tables and using CPU for page table updates. */
+	r = amdgpu_vm_make_npa(adev, &adev->ualink.npa_vm);
 	if (r)
 		goto uninit_vm;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index 8f8fecb9738ba..a7981aab0a329 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -2748,6 +2748,46 @@ int amdgpu_vm_make_compute(struct amdgpu_device *adev, struct amdgpu_vm *vm)
 	return r;
 }
 
+/**
+ * amdgpu_vm_make_npa - Turn a GFX VM into an NPA VM
+ *
+ * @adev: amdgpu_device pointer
+ * @vm: requested vm
+ *
+ * This only works on GFX VMs that don't have any BOs added and no
+ * page tables allocated yet.
+ *
+ * Changes the following VM parameters:
+ * - use_cpu_for_update
+ * - pins page tables
+ * - initializes PTEs to no-retry encoding
+ *
+ * Reinitializes the page directory to reflect the changed ATS
+ * setting.
+ *
+ * Returns:
+ * 0 for success, -errno for errors.
+ */
+int amdgpu_vm_make_npa(struct amdgpu_device *adev, struct amdgpu_vm *vm)
+{
+	int r = amdgpu_vm_make_compute(adev, vm);
+
+	if (r)
+		return r;
+	vm->is_npa = true;
+	r = amdgpu_bo_reserve(vm->root.bo, false);
+	if (r)
+		return r;
+	r = amdgpu_bo_pin(vm->root.bo, AMDGPU_GEM_DOMAIN_VRAM);
+	amdgpu_bo_unreserve(vm->root.bo);
+	if (r)
+		return r;
+
+	vm->is_npa = true;
+
+	return 0;
+}
+
 static int amdgpu_vm_stats_is_zero(struct amdgpu_vm *vm)
 {
 	for (int i = 0; i < __AMDGPU_PL_NUM; ++i) {
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
index 9dd7a17731f2e..defabb0a7b030 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
@@ -443,6 +443,8 @@ struct amdgpu_vm {
 	struct ttm_lru_bulk_move lru_bulk_move;
 	/* Flag to indicate if VM is used for compute */
 	bool			is_compute_context;
+	/* Flag to indicate that page tables are for NPA mappings */
+	bool			is_npa;
 	/* Flag to indicate if VM needs a TLB fence (KFD or KGD) */
 	bool			need_tlb_fence;
 
@@ -503,6 +505,7 @@ void amdgpu_vm_manager_fini(struct amdgpu_device *adev);
 long amdgpu_vm_wait_idle(struct amdgpu_vm *vm, long timeout);
 int amdgpu_vm_init(struct amdgpu_device *adev, struct amdgpu_vm *vm, int32_t xcp_id);
 int amdgpu_vm_make_compute(struct amdgpu_device *adev, struct amdgpu_vm *vm);
+int amdgpu_vm_make_npa(struct amdgpu_device *adev, struct amdgpu_vm *vm);
 void amdgpu_vm_fini(struct amdgpu_device *adev, struct amdgpu_vm *vm);
 int amdgpu_vm_lock_pd(struct amdgpu_vm *vm, struct drm_exec *exec,
 		      unsigned int num_fences);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
index e43a60d098082..ff69a3c828de3 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
@@ -444,6 +444,7 @@ int amdgpu_vm_pt_create(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 {
 	struct amdgpu_bo_param bp;
 	unsigned int num_entries;
+	int r;
 
 	memset(&bp, 0, sizeof(bp));
 
@@ -476,7 +477,24 @@ int amdgpu_vm_pt_create(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 	if (vm->root.bo)
 		bp.resv = vm->root.bo->tbo.base.resv;
 
-	return amdgpu_bo_create_vm(adev, &bp, vmbo);
+	r = amdgpu_bo_create_vm(adev, &bp, vmbo);
+	if (r)
+		return r;
+
+	/* Assumes that reservation is shared with the VM root and that the
+	 * reservation is locked
+	 */
+	if (vm->root.bo && vm->is_npa) {
+		struct amdgpu_bo *pt_bo = &(*vmbo)->bo;
+
+		r = amdgpu_bo_pin(pt_bo, AMDGPU_GEM_DOMAIN_VRAM);
+		if (r) {
+			amdgpu_bo_unref(&pt_bo);
+			return r;
+		}
+	}
+
+	return 0;
 }
 
 /**
@@ -526,6 +544,8 @@ static int amdgpu_vm_pt_alloc(struct amdgpu_device *adev,
 	return 0;
 
 error_free_pt:
+	if (vm->is_npa)
+		amdgpu_bo_unpin(pt_bo);
 	amdgpu_bo_unref(&pt_bo);
 	return r;
 }
@@ -540,6 +560,9 @@ static void amdgpu_vm_pt_free(struct amdgpu_vm_bo_base *entry)
 	if (!entry->bo)
 		return;
 
+	if (entry->vm->is_npa)
+		amdgpu_bo_unpin(entry->bo);
+
 	amdgpu_vm_update_stats(entry, entry->bo->tbo.resource, -1);
 	entry->bo->vm_bo = NULL;
 	ttm_bo_set_bulk_move(&entry->bo->tbo, NULL);
-- 
2.55.0

