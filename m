Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB3FBC624DA
	for <amd-gfx@archiver.kernel.org>; Mon, 31 Aug 2026 18:29:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6311110EA82;
	Mon, 31 Aug 2026 18:29:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="yg2tm6Pl";
	dkim-atps=neutral
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011064.outbound.protection.outlook.com
 [40.93.194.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1262610E50F
 for <amd-gfx@lists.freedesktop.org>; Mon, 31 Aug 2026 18:28:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XfuLBeywnGITkR5vj0aSI2TU+O48tKQuH13HsFMb2OJRDzj48iJqbj7A+0v4eeXpChD26IktFXbUbxkG3mo4TryT1oGn1npPN1tA8ka9zPo2xjS0cz9wCSWvgvF5yx1P1+dJKOMqzn+Wu5QwUwMkc4vszXTrfmJyuxt240ICgC211RfSpWkd2oCb7UbDSRQWo7VtrWHK/pMMCSA4/PpkbHFTiaa78EoeDcTYPuWg+C/7Q3V8ne/PKgAbjELolcvxGxaQD7WDnNlQXwo9855t/HMEc2KXokJ2KmO6SKzAeIwfW/p50mU0TrJJG/HsXRAHmPF7TcPZNbAiVHpFxkx/dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cgxua/tFjzGsV9cmRBQ/Qjd71suFRi1qekZTqn0xyAg=;
 b=M9CoYb6asuCuoH5W/SYhWup7svrtZtynq2VnNtGOJqqiT333CfKe27MSOCmghgoP3MsMPHPdRBUPfKRgBO0y8olfE37IbRZO5HOK9oMYjt9Zck6yv7fyUpr4VrR+DsRPD9QYEPpNFo4H8WJ8h0a5z1exes55lQ336uDKUCCCLqOpaBQLLkkzks8kJximN5WdYJ9Nm27xdA8/1xMrkfqzURgIncpcsJv6viOaLgoytsEVVmKcKfVy5Acm64s1guPDNd+J6P0pBPdpsWHCpKsuncnPw8CKpGDdVEgfJ3Ct18wohTXuZbUibEAho9ABTD3mOg87OzokPtYgbIkJhqlO3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cgxua/tFjzGsV9cmRBQ/Qjd71suFRi1qekZTqn0xyAg=;
 b=yg2tm6PlLZSv3CbnumBf9BjEoX5HxF++83iULSrucuenDGD97aRVEonaJGvHkPWPyLiU9vYM67LflgbcdsjnjrRU1tasfqLiCKjhlaS7TFwPmOvYCxZV+XMno/sVBY1Ul/F+ZEHzg6/VZ3AAQ3Nx8noN4s9DUgY1FDkzGVrIn1o=
Received: from CH0PR04CA0104.namprd04.prod.outlook.com (2603:10b6:610:75::19)
 by BL3PR12MB6425.namprd12.prod.outlook.com (2603:10b6:208:3b4::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Mon, 31 Aug
 2026 18:28:49 +0000
Received: from BL6PEPF0001AB76.namprd02.prod.outlook.com
 (2603:10b6:610:75:cafe::46) by CH0PR04CA0104.outlook.office365.com
 (2603:10b6:610:75::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.13 via Frontend Transport; Mon,
 31 Aug 2026 18:28:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BL6PEPF0001AB76.mail.protection.outlook.com (10.167.242.169) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Mon, 31 Aug 2026 18:28:49 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Mon, 31 Aug
 2026 13:28:38 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.46 via Frontend
 Transport; Mon, 31 Aug 2026 13:28:38 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Mukul Joshi <mukul.joshi@amd.com>, Harish Kasiviswanathan
 <Harish.Kasiviswanathan@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 51/95] drm/amdgpu: lock UALink import invalidation via drm_exec
Date: Mon, 31 Aug 2026 14:27:10 -0400
Message-ID: <20260831182754.1089811-52-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260831182754.1089811-1-alexander.deucher@amd.com>
References: <20260831182754.1089811-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB76:EE_|BL3PR12MB6425:EE_
X-MS-Office365-Filtering-Correlation-Id: d6addabd-3a99-4029-f325-08df078db374
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|82310400026|23010399003|1800799024|376014|56012099006|10067099003|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: aMy3WnfmXy+EST3MdkNo3HxJ7jEd5nH8+C0nPlN9zrKH6gTcDyHALmjvL+0sF+gD+/z/owi18gb57LZXMGVt/xh8PiaZr3h0gWSSPxl3iGOJmOVoTgW3FLSZ12x/H5niQPzXWoEpP6R80ONhz49UX8fqPml/+PL3TbSQMFjINvKQTyrglQJBLDYPA0S+BE6PBop8Y8XwEhBTcA1boqiZXUJC1pczZ7kUdLY2UhXUz+H8ZtPZfzy/X3CpZqLyTPobISzDo6bPo4QqUoeBdZMSow3HZJVc8+dwAfSTJr73xyLh5TPJNB0zgWcuFFFX/mo0xRlxpjJmeiRsnOeCk9+B+9nXEjJxtQqA8lz0DblNSgRvm6HXi/669CxSkWLs2PDcQKv30t98qJlwWYjqy5uZx/TlLJ9Tj+8fsJ1caUbyvk+09OUYRKL32igzAZryl/aN89hvIK/cgmH4a2HMf9A5JeFeHrwP1XJt+JoAMw9GC9cQNeAL6DLkq963wsciHAgsxloSjvgY7wMAfbaqLIcPRYb/m4+UbAm8AxuCrGDrLpCN05k/0BmRWjzk1lx6XMTF6r5RJDjGOp0FtCkV+Ux8U7lCrKcCo406N55VB+aSz0GGtI5YyvvV3umS5oDGqDmn0Z7+Ji53l+JyOZlgje2bCNu3hwuuDGOn4YkQObe006aJHW5Z1jiogy+Sqls8h6Gi/Ts4+CG9prfioPPcezJ0mA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(82310400026)(23010399003)(1800799024)(376014)(56012099006)(10067099003)(11063799006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: XGj5TkPLdR/c4p+ImBaId36YBr6rAP7jFxWsL/QbpLF/dbI2IUmQF/Gnuxw03Wq2oG+/31wkxjSpKPDw97QOM5LPIFd9O8SNuDDyxGwbv9eBIMSYx32k05/t9K805BNrFtEe/MLPzf9qmBTP0AfbycRQYEgFnTR4XeXHupRiGqVOOZSa4eDj2JfxWCnwCPLl+7Xok1Fo6MfonxRe0fc0dZBgMTm+DFyEpo0wGqh4gB37Vbiu8Tag28jN4CQXUI8T+dsFeQCu04OTB0e6Zfn5QN+XqPdau6sTE9p8F/yBlSf1c8/9+8JkxbaE8uJ9nQzBTE+c5OYV/5hdIMizKXBXsO+iCtZP31G6fxp2OYpDpJMUMpc5AsYhpuC4UQjewYRtiT+ekPHtNdC1hiuNGbv9si9CGkfDUoli8OIJl29qZ8S59nByqABDg+LJkqWfuk6I
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2026 18:28:49.1953 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d6addabd-3a99-4029-f325-08df078db374
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB76.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6425
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

From: Mukul Joshi <mukul.joshi@amd.com>

Convert amdgpu_ualink_invalidate_import_mappings() to lock the BO and
every client VM root PD in a single drm_exec transaction instead of
borrowing the caller's reservation ticket via dma_resv_locking_ctx().

drm_exec owns its ww_acquire_ctx (exec.ticket) for the lifetime of the
transaction, so amdgpu_vm_handle_moved() now uses &exec.ticket.

Also, drop the explicit dma_resv_reserve_fences call as amdgpu_vm_lock_pd()
already reserves 2 + num_fences on the same VM root PD.

Signed-off-by: Mukul Joshi <mukul.joshi@amd.com>
Reviewed-by: Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c | 63 +++++++++++-----------
 1 file changed, 30 insertions(+), 33 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
index 9d21f08123eed..82a362e44a3fe 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
@@ -1763,68 +1763,65 @@ static void amdgpu_ualink_exp_cleanup_worker(struct work_struct *work)
  */
 static void amdgpu_ualink_invalidate_import_mappings(struct amdgpu_bo *bo)
 {
-	struct drm_gem_object *obj = &bo->tbo.base;
-	struct ww_acquire_ctx *ticket = dma_resv_locking_ctx(obj->resv);
 	struct amdgpu_device *adev = amdgpu_ttm_adev(bo->tbo.bdev);
 	struct ttm_operation_ctx ctx = { false, false };
 	struct ttm_placement placement = {};
 	struct amdgpu_vm_bo_base *bo_base;
+	struct drm_exec exec;
 	int r;
 
-	amdgpu_bo_reserve(bo, false);
+	/*
+	 * Lock the BO together with every client VM page directory it is
+	 * mapped into in a single drm_exec transaction.
+	 */
+	drm_exec_init(&exec, DRM_EXEC_IGNORE_DUPLICATES, 0);
+	drm_exec_until_all_locked(&exec) {
+		r = drm_exec_lock_obj(&exec, &bo->tbo.base);
+		drm_exec_retry_on_contention(&exec);
+		if (unlikely(r))
+			goto fini;
+
+		for (bo_base = bo->vm_bo; bo_base; bo_base = bo_base->next) {
+			r = amdgpu_vm_lock_pd(bo_base->vm, &exec, 0);
+			drm_exec_retry_on_contention(&exec);
+			if (unlikely(r))
+				goto fini;
+		}
+	}
 
 	/* FIXME: This should be after the "if", but needs a fix to make sure
 	 * DMABuf imports are initialized in the right VM list.
 	 */
 	amdgpu_vm_bo_invalidate(bo, false);
 	if (!bo->tbo.resource || bo->tbo.resource->mem_type == TTM_PL_SYSTEM)
-		goto out;
+		goto fini;
 
 	r = ttm_bo_validate(&bo->tbo, &placement, &ctx);
 	if (r) {
 		dev_err(adev->dev, "Failed to invalidate NPA DMA-buf import (%d)\n",
 			r);
-		goto out;
+		goto fini;
 	}
 
 	for (bo_base = bo->vm_bo; bo_base; bo_base = bo_base->next) {
 		struct amdgpu_vm *vm = bo_base->vm;
-		struct dma_resv *resv = vm->root.bo->tbo.base.resv;
-
-		if (ticket) {
-			/* When we get an error here it means that somebody
-			 * else is holding the VM lock and updating page tables
-			 * So we can just continue here.
-			 */
-			r = dma_resv_lock(resv, ticket);
-			if (r)
-				continue;
-
-		} else {
-			/* TODO: This is more problematic and we actually need
-			 * to allow page tables updates without holding the
-			 * lock.
-			 */
-			if (!dma_resv_trylock(resv))
-				continue;
-		}
 
-		/* Reserve fences for two SDMA page table updates */
-		r = dma_resv_reserve_fences(resv, 2);
-		if (!r)
-			r = amdgpu_vm_clear_freed(adev, vm, NULL);
+		/*
+		 * Fences for the two SDMA page table updates were already
+		 * reserved by amdgpu_vm_lock_pd() above (it reserves 2 +
+		 * num_fences on the same VM root PD dma_resv).
+		 */
+		r = amdgpu_vm_clear_freed(adev, vm, NULL);
 		if (!r)
-			r = amdgpu_vm_handle_moved(adev, vm, ticket);
+			r = amdgpu_vm_handle_moved(adev, vm, &exec.ticket);
 
 		if (r && r != -EBUSY)
 			dev_err(adev->dev, "Failed to invalidate VM page tables (%d))\n",
 				r);
-
-		dma_resv_unlock(resv);
 	}
 
-out:
-	amdgpu_bo_unreserve(bo);
+fini:
+	drm_exec_fini(&exec);
 }
 
 static int amdgpu_ualink_map_npa_to_dmabuf(struct amdgpu_device *adev,
-- 
2.55.0

