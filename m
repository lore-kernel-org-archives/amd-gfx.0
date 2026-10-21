Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 767E2606A32E
	for <amd-gfx@archiver.kernel.org>; Wed, 21 Oct 2026 06:56:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=Emfq818l
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1375A10E067;
	Wed, 21 Oct 2026 06:56:48 +0000 (UTC)
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011038.outbound.protection.outlook.com [52.101.52.38])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 15A9910EC58
 for <amd-gfx@lists.freedesktop.org>; Wed, 21 Oct 2026 06:56:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=h3Mz269fbvagpcsOsp77ecqgfKH8j2UMQYoAhg10XRRG/I5MOdbaxdeD9bjrRSoKKND2nAQZpf8iXCEdtZq5rvT6TI6kxTsVwKHQ8PhCdfn4kdZnwhs/R0X4FYs3vTQOUUX2me0/1Y0qhww9fVL8WXR2TIZsoDy3z7NmNOLdEwfUos1+mhKlpbb5YZiTFwlHZAOghiLDPFQVrGDEaM0+JrUWNHZkU/af7UZXqEBXQ33iFL9Hpcrtb2RShQkBKy+uH9TLnk7fIJ/iODnGBwKIHdYF66H/kIeewcszRRTDQ20equtoFxL7byUPBaHipXFjdm1UhNJKN1I8L8ef7ITH9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0LSHcQ4QCIuFn8mGNkucB3M4On+PFPdCsA/ytGRqDAQ=;
 b=mXXar8PFrFa47XC4V0yy1ytn3I9QgMABJHr7cHKtsE1KTNLxmR/tGtY464pCXYIdu4Boi3Lx/MNn6ckPtAl/N16Rc0UgkeDNfbnzpJv04/CBk/izTrlJng499klE+96y5NjIjsEEWvM2ItprtB3OkmfGaQn6NdwIAie+096ZWgd8YYifwFjSs4wkWduScpGX2VZtduC8GMvSz3FMcrYbM+hFwildF1tDdMtKErOKaj12bvAi/6rBSdk3VPz9TKiBcn9NN6Bdue3DZPnhbNkK9GZBrM1R5OTG9OwDOfL5YjVdKGDXsiOaQBf3mwplsXoY4aNLaZSPO5ITTu8YvcSd2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0LSHcQ4QCIuFn8mGNkucB3M4On+PFPdCsA/ytGRqDAQ=;
 b=Emfq818lwuYf9ee+0aZsF/z2F0XGA4b/5Q9avtws4E+uq5I7FkOF8hL+z9TLHmrr/9zObW7EYZ5Hd0ZD5rvakHTYAP8fF4dhom6keXKipwp08fXK06ygCj0nYeL3XSoc1T1ycWV4EG5jYIgpkMTdvZJCW6M09GuFI3Ed/+vIb00=
Received: from SJ2PR07CA0012.namprd07.prod.outlook.com (2603:10b6:a03:505::13)
 by DS6PR12MB422600.namprd12.prod.outlook.com (2603:10b6:8:46b::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.15; Wed, 21 Oct
 2026 06:56:34 +0000
Received: from SJ1PEPF00002318.namprd03.prod.outlook.com
 (2603:10b6:a03:505:cafe::2e) by SJ2PR07CA0012.outlook.office365.com
 (2603:10b6:a03:505::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.546.15 via Frontend Transport; Wed,
 21 Oct 2026 06:56:34 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF00002318.mail.protection.outlook.com (10.167.242.228) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.546.15 via Frontend Transport; Wed, 21 Oct 2026 06:56:34 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.53; Wed, 21 Oct 2026 01:56:30 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>, Felix Kuehling <felix.kuehling@amd.com>,
 Lancelot Six <lancelot.six@amd.com>, James Zhu <james.zhu@amd.com>, "Lijo
 Lazar" <lijo.lazar@amd.com>, Samuel Pitoiset <hakzsam@gmail.com>, Natalie
 Vock <natalie.vock@gmx.de>, =?UTF-8?q?Timur=20Krist=C3=B3f?=
 <timur.kristof@gmail.com>, Pierre-Eric Pelloux-Prayer
 <pierre-eric.pelloux-prayer@amd.com>
Subject: [PATCH v2 5/7] drm/amdgpu: Make first-level trap state GPUVM-owned
Date: Wed, 21 Oct 2026 12:26:01 +0530
Message-ID: <20261021065603.1329111-6-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261021065603.1329111-1-srinivasan.shanmugam@amd.com>
References: <20261021065603.1329111-1-srinivasan.shanmugam@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002318:EE_|DS6PR12MB422600:EE_
X-MS-Office365-Filtering-Correlation-Id: c47ed4ec-a9ce-4b8c-526a-08df2f4071ef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|82310400026|376014|23010399003|1800799024|6133799003|22082099003|18002099003|10067099003|261009223027099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: 2gMV0H4/Rh77Lcy9f5mJouiL1lpKaSz12BKrTZQya2BO34PURFZNj1oXBBId/VfQqecQqcXCaz/oNpTvqQpnXN/9IEH0m0Wmr+YttbN2MgUJCEQJ7ZYg7aAXYLbCD8QFXxkFMGCk3wXjYp2s8PlbRrnmiGbxrI9nnqyYR1d4TRUgBMDzYcjdnOBe0Lt2R5KwLhb1F2zpPxil4HVAANO/QTogpkcrOk6C37gRPG8cQTRTNM4rmD48uBuJa3fLBweynm0812SPQDVAU8tzsEpdiWqalcg4/k/Y9uHimiek+GoMch308/OfuS8hcKit4xZQm+jgvut+Mub0fKxkM0f7V67ZeXKFWbSqKtVgUrKdylfHlvh0w6YrY0SOQxxQtC94TRXhQPAsjKq01jDzRa3HpRR9KZXX34wCdlN7Q1tUDKCUP3pDIurAGCrXYuT8TC7rnJgYLXbd8UKc4YGhkdC3YNK1ggw6OsZR1hB0spqc75GfNU3uLeV4O1c/gMMfP3orCDfqmvgDhBJHCL+NHhvzKo/oJkquMIrC6lXVSj45nI74ie1L1p+yQ6zC6fGor5BhqDppw3kw9zahvbwM+CBAlPUZVUWVvygpIRlIvR8x674JPilyDlqtg9KlwG3dU9+Kd2dbtKIr8dwGFkOBK//nxAJOX95IFFRHmxQEB2e8uZNE6cA2+MM6+jatRMxUuFEmypV7GDNlnvr9NS2qLUe9aQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(82310400026)(376014)(23010399003)(1800799024)(6133799003)(22082099003)(18002099003)(10067099003)(261009223027099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 334QpI3hNScFwlRFFeKEz9YONQH87VOi092A1e33ZcfCUNCUCi4MgdlzfSw2yE0CoWkN3fR2IgSAENWJOSZZ+or4uit/r9Mdcikdaex52tg7kdWJJc+VfLU7GJ7Xe+Pu2+wkTYE/W53joe4z4d2lX5wBSbGDQWPUxyS0G0IwwGGq/XBH6bWMLvIdKHHRXfdC4StKXclq6Wr/mKWEJEGlN6AU2uxYp8V616iPJd2ds9UC8u9gA0dJW8E/SSo1NIWRFe9kZbtf/jDb1tgimufe8OP79WoyJjYOJDgTd8y6mwsHgOZ1ekbqXMz9jXZ4rtJ30vZLOK1kRMndBnOM1rSta1LKXM70djrawceFW+LxY8pLDrCAAT4j1kr1KegLFrD8I776gNyikrgxQO1mm/QApDKmE6OkAQcoeNqaQXoR5wTtXevfK50mf3PUn0264gsZ
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2026 06:56:34.4567 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c47ed4ec-a9ce-4b8c-526a-08df2f4071ef
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00002318.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS6PR12MB422600
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
X-Spam-Status: No, score=-19.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The first-level trap state belongs to the GPUVM because the TBA and TMA
are mappings in that GPUVM.

User queues and kernel queues using the same GPUVM use the same
first-level trap state. There is no need to keep a separate trap object
in the file-private data.

Move the trap object into struct amdgpu_vm. Create it when the GPUVM is
initialized and free it when the GPUVM is destroyed.

Create the trap state after releasing the initial VM root reservation.
The trap allocation locks the VM internally, so doing this while the VM
root is already reserved could lock the same reservation again.

For the same reason, free the trap state before reserving the VM root
during VM cleanup.

Keep the first-level trap ISA buffer shared at the device level. The ISA
is the same for all GPUVMs on the same device, while each GPUVM keeps
its own trap mapping and TMA state.

Update the user queue path to get the first-level TBA and TMA from its
GPUVM.

Suggested-by: Christian König <christian.koenig@amd.com>
Suggested-by: Alex Deucher <alexander.deucher@amd.com>
Cc: Felix Kuehling <felix.kuehling@amd.com>
Cc: Lancelot Six <lancelot.six@amd.com>
Cc: James Zhu <james.zhu@amd.com>
Cc: Lijo Lazar <lijo.lazar@amd.com>
Cc: Samuel Pitoiset <hakzsam@gmail.com>
Cc: Natalie Vock <natalie.vock@gmx.de>
Cc: Timur Kristóf <timur.kristof@gmail.com>
Cc: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
Change-Id: If9f3516fe1f8ec5ebec5365f77655f0d1b928dd0
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h        |  2 --
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c    |  9 +----
 drivers/gpu/drm/amd/amdgpu/amdgpu_trap.c   | 41 ++--------------------
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c     | 31 ++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h     |  4 +++
 drivers/gpu/drm/amd/amdgpu/mes_userqueue.c |  7 ++--
 6 files changed, 41 insertions(+), 53 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index 2f49da48aa90..001d44206836 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -333,7 +333,6 @@ struct amdgpu_reset_control;
 struct amdgpu_coredump_info;
 struct amdgpu_video_codecs;
 struct amdgpu_trap_isa;
-struct amdgpu_trap_obj;
 
 enum amdgpu_cp_irq {
 	AMDGPU_CP_IRQ_GFX_ME0_PIPE0_EOP = 0,
@@ -422,7 +421,6 @@ struct amdgpu_fpriv {
 	struct xarray		bo_list_handles;
 	struct amdgpu_ctx_mgr	ctx_mgr;
 	struct amdgpu_userq_mgr	userq_mgr;
-	struct amdgpu_trap_obj *trap_obj;
 
 	/* Eviction fence infra */
 	struct amdgpu_eviction_fence_mgr evf_mgr;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
index 201c167577c6..bc623eeee4bc 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
@@ -1460,7 +1460,7 @@ int amdgpu_info_ioctl(struct drm_device *dev, void *data, struct drm_file *filp)
 		int num_xcc, r;
 
 		fpriv = (struct amdgpu_fpriv *)filp->driver_priv;
-		if (!amdgpu_trap_is_enabled(adev) || !fpriv->trap_obj)
+		if (!amdgpu_trap_is_enabled(adev) || !fpriv->vm.trap_obj)
 			return -EOPNOTSUPP;
 		num_xcc = amdgpu_xcp_get_num_xcc(adev->xcp_mgr, fpriv->xcp_id);
 		cwsr_info.ctl_stack_size =
@@ -1604,12 +1604,6 @@ int amdgpu_driver_open_kms(struct drm_device *dev, struct drm_file *file_priv)
 
 	amdgpu_evf_mgr_init(&fpriv->evf_mgr);
 
-	r = amdgpu_trap_alloc(adev,
-			      &fpriv->vm,
-			      &fpriv->trap_obj);
-	if (r == -EOPNOTSUPP)
-		r = 0;
-
 	amdgpu_ctx_mgr_init(&fpriv->ctx_mgr, adev);
 
 	file_priv->driver_priv = fpriv;
@@ -1679,7 +1673,6 @@ void amdgpu_driver_postclose_kms(struct drm_device *dev,
 	}
 
 	amdgpu_ctx_mgr_fini(&fpriv->ctx_mgr);
-	amdgpu_trap_free(adev, &fpriv->vm, &fpriv->trap_obj);
 
 	if (pasid)
 		amdgpu_pasid_free_delayed(pd->tbo.base.resv, pasid);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_trap.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_trap.c
index 12e37d0467f9..89968b5b7ecb 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_trap.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_trap.c
@@ -326,8 +326,6 @@ static int amdgpu_trap_map_region(struct amdgpu_device *adev,
 	va &= AMDGPU_GMC_HOLE_MASK;
 	r = amdgpu_vm_bo_map(adev, *bo_va, va, 0, size, va_flags);
 	if (r) {
-		dev_err(adev->dev, "failed to do bo map of %s region, err=%d\n",
-			(region == AMDGPU_TRAP_TBA ? "tba" : "tma"), r);
 		amdgpu_vm_bo_del(adev, *bo_va);
 		*bo_va = NULL;
 		return r;
@@ -335,9 +333,6 @@ static int amdgpu_trap_map_region(struct amdgpu_device *adev,
 
 	r = amdgpu_vm_bo_update(adev, *bo_va, false);
 	if (r) {
-		dev_err(adev->dev,
-			"failed to do page table update of %s region, err=%d\n",
-			(region == AMDGPU_TRAP_TBA ? "tba" : "tma"), r);
 		amdgpu_vm_bo_del(adev, *bo_va);
 		*bo_va = NULL;
 		return r;
@@ -351,39 +346,6 @@ static int amdgpu_trap_map_region(struct amdgpu_device *adev,
 	return 0;
 }
 
-static int amdgpu_trap_unmap_region(struct amdgpu_device *adev,
-				    struct amdgpu_trap_obj *cwsr,
-				    enum amdgpu_trap_region region)
-{
-	struct amdgpu_bo_va **bo_va;
-	uint64_t va;
-	int r;
-
-	if (!cwsr)
-		return -EINVAL;
-
-	if (region == AMDGPU_TRAP_TBA) {
-		bo_va = &cwsr->tba_va;
-		va = cwsr->tba_gpu_va_addr;
-	} else {
-		bo_va = &cwsr->tma_va;
-		va = cwsr->tma_gpu_va_addr;
-	}
-
-	r = amdgpu_vm_bo_unmap(adev, *bo_va, va);
-	if (r) {
-		dev_err(adev->dev,
-			"failed to do bo_unmap on CWSR trap handler, err=%d\n",
-			r);
-		return r;
-	}
-
-	amdgpu_vm_bo_del(adev, *bo_va);
-	*bo_va = NULL;
-
-	return r;
-}
-
 int amdgpu_trap_alloc(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 		      struct amdgpu_trap_obj **trap_obj)
 {
@@ -464,7 +426,8 @@ int amdgpu_trap_alloc(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 
 	r = amdgpu_trap_map_region(adev, vm, cwsr, AMDGPU_TRAP_TBA);
 	if (r) {
-		amdgpu_trap_unmap_region(adev, cwsr, AMDGPU_TRAP_TMA);
+		amdgpu_vm_bo_del(adev, cwsr->tma_va);
+		cwsr->tma_va = NULL;
 		goto err_tma;
 	}
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index 3f19d03fd7d8..6fafd29ae25e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -45,6 +45,7 @@
 #include "amdgpu_xgmi.h"
 #include "amdgpu_dma_buf.h"
 #include "amdgpu_res_cursor.h"
+#include "amdgpu_trap.h"
 #include "kfd_svm.h"
 
 /**
@@ -2628,6 +2629,7 @@ void amdgpu_vm_set_task_info(struct amdgpu_vm *vm)
 int amdgpu_vm_init(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 		   int32_t xcp_id)
 {
+	struct amdgpu_bo_va_mapping *mapping, *tmp;
 	struct amdgpu_bo *root_bo;
 	struct amdgpu_bo_vm *root;
 	int r, i;
@@ -2636,6 +2638,8 @@ int amdgpu_vm_init(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 	for (i = 0; i < AMDGPU_MAX_VMHUBS; i++)
 		vm->reserved_vmid[i] = NULL;
 
+	vm->trap_obj = NULL;
+
 	amdgpu_vm_bo_status_init(&vm->kernel);
 	amdgpu_vm_bo_status_init(&vm->always_valid);
 	spin_lock_init(&vm->individual_lock);
@@ -2702,10 +2706,28 @@ int amdgpu_vm_init(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 		dev_dbg(adev->dev, "Failed to create task info for VM\n");
 
 	amdgpu_bo_unreserve(vm->root.bo);
+
+	if (amdgpu_trap_is_enabled(adev)) {
+		r = amdgpu_trap_alloc(adev, vm, &vm->trap_obj);
+		if (r)
+			goto error_free_trap;
+	}
+
 	amdgpu_bo_unref(&root_bo);
 
 	return 0;
 
+error_free_trap:
+	amdgpu_bo_reserve(root_bo, true);
+
+	list_for_each_entry_safe(mapping, tmp, &vm->freed, list) {
+		list_del(&mapping->list);
+		amdgpu_vm_free_mapping(adev, vm, mapping, NULL);
+	}
+
+	amdgpu_vm_put_task_info(vm->task_info);
+	dma_fence_put(vm->last_update);
+
 error_free_root:
 	amdgpu_vm_pt_free_root(adev, vm);
 	amdgpu_bo_unreserve(vm->root.bo);
@@ -2850,6 +2872,15 @@ void amdgpu_vm_fini(struct amdgpu_device *adev, struct amdgpu_vm *vm)
 
 	amdgpu_amdkfd_gpuvm_destroy_cb(adev, vm);
 
+	/*
+	 * Free trap state before reserving root. amdgpu_trap_free()
+	 * uses drm_exec to lock the page directory internally; calling
+	 * it after amdgpu_bo_reserve(root) would deadlock on the same
+	 * ww_mutex.
+	 */
+	if (vm->trap_obj)
+		amdgpu_trap_free(adev, vm, &vm->trap_obj);
+
 	root = amdgpu_bo_ref(vm->root.bo);
 	amdgpu_bo_reserve(root, true);
 	dma_fence_wait(vm->last_unlocked, false);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
index f55239b5bc06..3242d2fa0c8f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
@@ -43,6 +43,7 @@ struct amdgpu_bo_va;
 struct amdgpu_job;
 struct amdgpu_bo_list_entry;
 struct amdgpu_bo_vm;
+struct amdgpu_trap_obj;
 
 /*
  * GPUVM handling
@@ -385,6 +386,9 @@ struct amdgpu_vm {
 
 	/* cached fault info */
 	struct amdgpu_vm_fault_info fault_info;
+
+	/* First-level trap state for this GPUVM; NULL if unavailable. */
+	struct amdgpu_trap_obj *trap_obj;
 };
 
 struct amdgpu_vm_manager {
diff --git a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
index 67fccdb64f14..951fa302a5fb 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
@@ -121,7 +121,6 @@ static int convert_to_mes_priority(int priority)
 static int mes_userq_map(struct amdgpu_usermode_queue *queue)
 {
 	struct amdgpu_userq_mgr *uq_mgr = queue->userq_mgr;
-	struct amdgpu_fpriv *fpriv = uq_mgr_to_fpriv(uq_mgr);
 	struct amdgpu_device *adev = uq_mgr->adev;
 	struct amdgpu_userq_obj *ctx = &queue->fw_obj;
 	struct amdgpu_mqd_prop *userq_props = queue->userq_prop;
@@ -153,9 +152,9 @@ static int mes_userq_map(struct amdgpu_usermode_queue *queue)
 	queue_input.page_table_base_addr = amdgpu_gmc_pd_addr(queue->vm->root.bo);
 	queue_input.wptr_mc_addr = queue->wptr_obj.gpu_addr;
 
-	if (fpriv->trap_obj) {
-		queue_input.tba_addr = fpriv->trap_obj->tba_gpu_va_addr;
-		queue_input.tma_addr = fpriv->trap_obj->tma_gpu_va_addr;
+	if (queue->vm->trap_obj) {
+		queue_input.tba_addr = queue->vm->trap_obj->tba_gpu_va_addr;
+		queue_input.tma_addr = queue->vm->trap_obj->tma_gpu_va_addr;
 		queue_input.trap_en = !amdgpu_trap_has_dbg_wa(adev);
 	}
 
-- 
2.34.1

