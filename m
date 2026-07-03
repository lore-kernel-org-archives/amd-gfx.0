Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0D32C43602
	for <amd-gfx@archiver.kernel.org>; Fri,  3 Jul 2026 06:19:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7711D10F646;
	Fri,  3 Jul 2026 06:19:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="yu/Li62y";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011038.outbound.protection.outlook.com [52.101.62.38])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BA00410F627
 for <amd-gfx@lists.freedesktop.org>; Fri,  3 Jul 2026 06:19:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=THC8MvT0EQAifQg6azUwEMLcIMx7TnmS1koRXyQjcaEZ8NnN8zbU8DeO8CHgPnSKsWOLjuPtomjy+UxqlaOw+5zWproPzij+qjZliUXquu08MwQFRBBxc1t0HOjXIijVAu81is650Ujiv+LGGP+f0eWN7bl4XLFsJYQhL+Y1A0tbUZuRrqzBkGAOrEiWLkWhNmcuRSXJbC229CgsszB8WIA5GgtnDKYm39tTmP1qAnjaxIrnJo94NSaNu0fsifptdl64jfD+JGlWMOeGhudThqjuBv2B96ld1XRg+MXLTIYm6QrPbVYejTJuJrR6b0G/JZtj6Ja5JvilIgLjSmtdtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MnwL8LuTEr78BsrbFWsa3hzzr9RT5XM+mcLG20JvBeI=;
 b=SnGp33j5Zurr3lL58wgBTGeUTs1XVBniKz6aRC/R6ng3LNh6yyRVFUlIXr83RfhzyDwwEmCt7on65lHcuKyRKy9fy5+hZfs+LZV2lNNYuO248ty0seoycQNeD4dH8AmvDXZnaDoYaLhn0KNYx6DFojlqYcsCReMk1lTbnjSfjFfWvAvmZRTvs+Z09Mm09DnmoeSyGfg7sDsWsHdOW1zfRODA0MiJ6wcUFmiHhdbl1BhRbFGR/+JYrPBVzkDDNi946BInHr4psRE6zWsxb3Oo/m5rlrDTXtcixbW+bj4A836OPgCa49p6Z6R0MHYyLvVVm9GxTRb6Gk8QxIevX5yIzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MnwL8LuTEr78BsrbFWsa3hzzr9RT5XM+mcLG20JvBeI=;
 b=yu/Li62y6sBavy5ajIOhruk/64sNTXN8PYCAoJR2cpg1GtPpPvwcXBKsPIV1RR3Jwrj2g8d/Bm6X9ghpSuDt1U+volUG1ilZeQ6eN3q30UqjCuOPUQN7gCUOI+INRAFunPQnlenJB6V5g3zVmfwzy2m9BOhTMdY8y3o8REv1Ty8=
Received: from MN2PR15CA0057.namprd15.prod.outlook.com (2603:10b6:208:237::26)
 by DM4PR12MB5940.namprd12.prod.outlook.com (2603:10b6:8:6b::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Fri, 3 Jul
 2026 06:18:58 +0000
Received: from BN2PEPF00004FBF.namprd04.prod.outlook.com
 (2603:10b6:208:237:cafe::3c) by MN2PR15CA0057.outlook.office365.com
 (2603:10b6:208:237::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.181.11 via Frontend Transport; Fri, 3
 Jul 2026 06:18:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF00004FBF.mail.protection.outlook.com (10.167.243.185) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Fri, 3 Jul 2026 06:18:58 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.41; Fri, 3 Jul 2026 01:18:56 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>
Subject: [PATCH v4 2/3] drm/amdgpu: Resolve VM through DRM PASID ownership
Date: Fri, 3 Jul 2026 11:48:32 +0530
Message-ID: <20260703061833.3163913-3-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260703061833.3163913-1-srinivasan.shanmugam@amd.com>
References: <20260703061833.3163913-1-srinivasan.shanmugam@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF00004FBF:EE_|DM4PR12MB5940:EE_
X-MS-Office365-Filtering-Correlation-Id: cf42c378-d9db-4cdd-44dc-08ded8caf7b2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700016|1800799024|23010399003|22082099003|18002099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: F+Hqer3y7obO60U1Fhd0/FnjaZ7uvyhimFdDaXjZ+I2q4LpEVc9SGMvbvkeR8Ktb0xAeXb3cu8zDKx2uaFowhnQW8dC3tdotH0X+Wav4Jb6qlflX8vJHsmQzyrwnkuSJIQ7wJaDDpOdb1clLpW2CT6xweH4VCD2eLNDk2UxQDHcS1+4laFIs+CHHbfDp1ASUD239GjE/f5FpZRPy2XtVhJSp+N6NC3xdBz4Tq0NFZOawC6RUESvDMo7/0OFdH0QvFOlOP3YCYEvybpmwfU3x6OuvM+xIJ24uYhgxK+9ZRmaBxuyKHYhmUxfWrnmrM2IcuLyYpXEduCcdGqY16I1AXAHWw0yA1V4xAoE27f63XXOtd/ovRPRZ7h13k9vVIfqzPALJICoK3r4KF/kHppMU35qtydGd0Kxb11831WGQSYzfpvjd/lQVG/y3M2lOPmxfyf4jbuGRL/mUg3pFDsbNrP4nu3gZ8xSznXK2PQgTTzKYXParJEQJhKUkb/em5vj2aEmxg4skadG+sfl28Y5nooJovDky2Tw5pgJCS1heENs/LI/yyQtRW2or6XYHCMwLqrHwsWqyQ6eTskbiffBO53VFDykcPvH4IAWYfbUpSgFVoqW0dN/L1AGNJdcAShMeiEA0yPrNrFsJ+blVZCbDEh5V9hb9l3EqNnSYh8KHRfukembQu6Qzuh1asVgHlj9QGPnEcNztDWhsYq1M8aY+Uw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700016)(1800799024)(23010399003)(22082099003)(18002099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: S8+MTgu8L+kVQYurJ1BCDwoRP/3HmZPgYsE15dVn2dmfdb++asuK58o2EVZP9Nm7G7enMUUceBJa1tUvvI2SyWfH7+aEw+q3p+CiHgswFw53a5xgs+Ta5JcVQBAboB2We+sTAT3DhmH5+p9TRMJ3CFRwhNj10Rs3eNhx5iXZpixsxYLPDmdis7kUHmLhw5TrJ9x3Xmu8vMsZbt4254q4cZzNo0kKignr6oR8ZpO0rbwapAsVjEEq2fS77D5N/AyfD6bK5AXvhnD3EkREG+Dx02596MmGqoeOm3MEOhOMI9srTNpBUF4krnhqmrIuVYCRNaBgJWOOOEzzO6LbMNIJe5Kg5vlaSJb2YP9smkt/ht0mD5Y7e8BPWF9kbXLQ/Lq3EwOoQq2q5CFhJXiRpC1TOrQpnYZA9UNrcdvF/9d/vAKtoVPGS+SqL3L9zPaRTcjr
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2026 06:18:58.3409 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cf42c378-d9db-4cdd-44dc-08ded8caf7b2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF00004FBF.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5940
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

Allocate DRM PASIDs with fpriv and resolve VM lookup users through:

	PASID -> fpriv -> VM

This preserves the root BO reference and revalidation flow in
amdgpu_vm_lock_by_pasid().

v4:
- Allocate DRM PASIDs with fpriv directly.
- Squash ownership registration and PASID lookup conversion.

Cc: Alex Deucher <alexander.deucher@amd.com>
Suggested-by: Christian König <christian.koenig@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c | 16 +++++-----
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c  | 40 ++++++++++++++++---------
 2 files changed, 34 insertions(+), 22 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
index 4610d6889e9b..087ca7783d1b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
@@ -1375,11 +1375,11 @@ int amdgpu_info_ioctl(struct drm_device *dev, void *data, struct drm_file *filp)
 
 		memset(&gpuvm_fault, 0, sizeof(gpuvm_fault));
 
-		xa_lock_irqsave(&adev->vm_manager.pasids, flags);
+		amdgpu_pasid_lock(&flags);
 		gpuvm_fault.addr = vm->fault_info.addr;
 		gpuvm_fault.status = vm->fault_info.status;
 		gpuvm_fault.vmhub = vm->fault_info.vmhub;
-		xa_unlock_irqrestore(&adev->vm_manager.pasids, flags);
+		amdgpu_pasid_unlock(flags);
 
 		return copy_to_user(out, &gpuvm_fault,
 				    min((size_t)size, sizeof(gpuvm_fault))) ? -EFAULT : 0;
@@ -1464,7 +1464,7 @@ int amdgpu_driver_open_kms(struct drm_device *dev, struct drm_file *file_priv)
 	struct amdgpu_device *adev = drm_to_adev(dev);
 	struct amdgpu_fpriv *fpriv;
 	struct drm_exec exec;
-	int r, pasid;
+	int r, pasid = 0;
 
 	/* Ensure IB tests are run on ring */
 	flush_delayed_work(&adev->delayed_init_work);
@@ -1487,16 +1487,16 @@ int amdgpu_driver_open_kms(struct drm_device *dev, struct drm_file *file_priv)
 		goto out_suspend;
 	}
 
-	pasid = amdgpu_pasid_alloc(16, NULL);
+	r = amdgpu_xcp_open_device(adev, fpriv, file_priv);
+	if (r)
+		goto error_pasid;
+
+	pasid = amdgpu_pasid_alloc(16, fpriv);
 	if (pasid < 0) {
 		dev_warn(adev->dev, "No more PASIDs available!");
 		pasid = 0;
 	}
 
-	r = amdgpu_xcp_open_device(adev, fpriv, file_priv);
-	if (r)
-		goto error_pasid;
-
 	amdgpu_debugfs_vm_init(file_priv);
 
 	r = amdgpu_vm_init(adev, &fpriv->vm, fpriv->xcp_id, pasid);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index 32719f31b6c9..9092ff227a55 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -2463,12 +2463,14 @@ static void amdgpu_vm_destroy_task_info(struct kref *kref)
 static inline struct amdgpu_vm *
 amdgpu_vm_get_vm_from_pasid(struct amdgpu_device *adev, u32 pasid)
 {
+	struct amdgpu_fpriv *fpriv;
 	struct amdgpu_vm *vm;
 	unsigned long flags;
 
-	xa_lock_irqsave(&adev->vm_manager.pasids, flags);
-	vm = xa_load(&adev->vm_manager.pasids, pasid);
-	xa_unlock_irqrestore(&adev->vm_manager.pasids, flags);
+	amdgpu_pasid_lock(&flags);
+	fpriv = amdgpu_pasid_get_fpriv_locked(pasid);
+	vm = fpriv ? &fpriv->vm : NULL;
+	amdgpu_pasid_unlock(flags);
 
 	return vm;
 }
@@ -2943,14 +2945,16 @@ struct amdgpu_vm *amdgpu_vm_lock_by_pasid(struct amdgpu_device *adev,
 					  u32 pasid, struct drm_exec *exec)
 {
 	unsigned long irqflags;
+	struct amdgpu_fpriv *fpriv;
 	struct amdgpu_bo *root;
 	struct amdgpu_vm *vm;
 	int r;
 
-	xa_lock_irqsave(&adev->vm_manager.pasids, irqflags);
-	vm = xa_load(&adev->vm_manager.pasids, pasid);
-	root = vm ? amdgpu_bo_ref(vm->root.bo) : NULL;
-	xa_unlock_irqrestore(&adev->vm_manager.pasids, irqflags);
+	amdgpu_pasid_lock(&irqflags);
+	fpriv = amdgpu_pasid_get_fpriv_locked(pasid);
+	vm = fpriv ? &fpriv->vm : NULL;
+	root = vm && vm->root.bo ? amdgpu_bo_ref(vm->root.bo) : NULL;
+	amdgpu_pasid_unlock(irqflags);
 
 	if (!root)
 		return NULL;
@@ -2962,11 +2966,17 @@ struct amdgpu_vm *amdgpu_vm_lock_by_pasid(struct amdgpu_device *adev,
 	}
 
 	/* Double check that the VM still exists */
-	xa_lock_irqsave(&adev->vm_manager.pasids, irqflags);
-	vm = xa_load(&adev->vm_manager.pasids, pasid);
-	if (vm && vm->root.bo != root)
+	amdgpu_pasid_lock(&irqflags);
+	fpriv = amdgpu_pasid_get_fpriv_locked(pasid);
+	if (!fpriv) {
 		vm = NULL;
-	xa_unlock_irqrestore(&adev->vm_manager.pasids, irqflags);
+	} else {
+		vm = &fpriv->vm;
+		if (vm->root.bo != root)
+			vm = NULL;
+	}
+	amdgpu_pasid_unlock(irqflags);
+
 	if (!vm) {
 		drm_exec_unlock_obj(exec, &root->tbo.base);
 		amdgpu_bo_unref(&root);
@@ -3163,12 +3173,14 @@ void amdgpu_vm_update_fault_cache(struct amdgpu_device *adev,
 				  uint32_t status,
 				  unsigned int vmhub)
 {
+	struct amdgpu_fpriv *fpriv;
 	struct amdgpu_vm *vm;
 	unsigned long flags;
 
-	xa_lock_irqsave(&adev->vm_manager.pasids, flags);
+	amdgpu_pasid_lock(&flags);
 
-	vm = xa_load(&adev->vm_manager.pasids, pasid);
+	fpriv = amdgpu_pasid_get_fpriv_locked(pasid);
+	vm = fpriv ? &fpriv->vm : NULL;
 	/* Don't update the fault cache if status is 0.  In the multiple
 	 * fault case, subsequent faults will return a 0 status which is
 	 * useless for userspace and replaces the useful fault status, so
@@ -3201,7 +3213,7 @@ void amdgpu_vm_update_fault_cache(struct amdgpu_device *adev,
 			WARN_ONCE(1, "Invalid vmhub %u\n", vmhub);
 		}
 	}
-	xa_unlock_irqrestore(&adev->vm_manager.pasids, flags);
+	amdgpu_pasid_unlock(flags);
 }
 
 void amdgpu_vm_print_task_info(struct amdgpu_device *adev,
-- 
2.34.1

