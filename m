Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7EC4BC5DF8C
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Aug 2026 19:55:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 18C8B10F4F5;
	Fri, 21 Aug 2026 19:55:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="GGHIGcIG";
	dkim-atps=neutral
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011043.outbound.protection.outlook.com [40.107.208.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4CE0E10F4F5
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Aug 2026 19:55:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Pz32JaA7+IWCp7X7IJKIIJyP3WynhnLJ3qnMueOUs73dN8V1Ts4bgGrVZFAG7KG1mMnHA1yuBvxKZSKATLh3lKCoagLpbeknT7lbI5Os4VxgEkwAhnHc1Of+FRLTX8Zx4+AwlqEOLeSlYDIzavFKeiQ+aGbdq3m+MNlskIU43JemkGK+j+kVHFYt6vKLFv+HJ3AF8f0OQ8FO3ta1+I9BQLnD0mElY0I9fRAIDTqNRQ6dXpYvcLirG85ZOfNXxHEjMgKcoTeBhtwPkl+aZUF3K/jKwsODslcTTT2ocHxe2nqoAsxnVKPDWesGt4GpOH9tyGuSiYK0QuoVsbXCtkAZ4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rYHfk/BqxTglIJkcqCrvlaLOSyPLos9x0kHKaawAA7c=;
 b=lJ8ivtNRWowfgXMCKDjW2A6u0TMIo9AZa09J27llgW3m0FX6V3gC8fmrtbzE+W0PopDCOjl5fitkWscEMbnDesGYucguKabhEES6vWkfs4hOK2aXKodkTJwh2GkbLJq/ETUd/WYEmMOPZtcncfrbYXtTyLsBtxI4+QiDS8VYTe0CL0rq8TYAKoTqKmRTXOcReP/ZvX99QvX6TgDWLB23OstP0++CQj+c90kggTo4kTAUtX5a9Weaa5k/EiQ8dAAKCxWor5EfdCOW8Qst/lOJXNJ3pgxpgu0YPQJcE/nJvaXoSWtCJd3MGDL+uTb0LSRet+BfuMppApyxWKKrF+SOrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rYHfk/BqxTglIJkcqCrvlaLOSyPLos9x0kHKaawAA7c=;
 b=GGHIGcIG57FlSYT7DBUDJT8ffCfQC4F9rGJyYzAchbjTxweF5MbYM1fj5Y8erCXVi3TsMyjQiyrYkXDKmfqfaoq7+eFoCVb6wv1x3OuG0kmil1yzmuxMMm12Sl5KXGOqL7UZpEzpNI0m1JPkz8EVBAFdVHpEMKVpxzipMFOxR3k=
Received: from DS1P222CA0007.NAMP222.PROD.OUTLOOK.COM (2603:10b6:8:454::12) by
 MN2PR12MB4208.namprd12.prod.outlook.com (2603:10b6:208:1d0::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.11; Fri, 21 Aug
 2026 19:35:52 +0000
Received: from CY4PEPF0000EDD1.namprd03.prod.outlook.com
 (2603:10b6:8:454:cafe::81) by DS1P222CA0007.outlook.office365.com
 (2603:10b6:8:454::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.339.11 via Frontend Transport; Fri,
 21 Aug 2026 19:35:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CY4PEPF0000EDD1.mail.protection.outlook.com (10.167.241.197) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.3 via Frontend Transport; Fri, 21 Aug 2026 19:35:51 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 21 Aug
 2026 14:35:43 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 21 Aug
 2026 14:35:42 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.45 via Frontend
 Transport; Fri, 21 Aug 2026 14:35:42 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Mukul Joshi <mukul.joshi@amd.com>, Harish Kasiviswanathan
 <Harish.Kasiviswanathan@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 51/95] drm/amdgpu: lock UALink import invalidation via drm_exec
Date: Fri, 21 Aug 2026 15:34:14 -0400
Message-ID: <20260821193458.808626-52-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260821193458.808626-1-alexander.deucher@amd.com>
References: <20260821193458.808626-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD1:EE_|MN2PR12MB4208:EE_
X-MS-Office365-Filtering-Correlation-Id: 7e37f032-35e8-4b07-7281-08deffbb6913
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|82310400026|376014|1800799024|36860700016|10067099003|11063799006|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: ZlVc7/w69ruYOeF2VPFBJ96+u0MZW0/d14A63A3mLuQt9XRmJc6Qjq8RcyZVL45gf9OGwYVAWKrpwmMQ5sanRxYIds8JGbuZU+D4a1jvt7hzmC27cmHUV+IYLPMwOppjnBALmOWJ/PAr0W7w8reWPYxtB5ROmtZVBKUxr0JLD8J1t8Wgx2FrxRqb2icVjEWGgzatxCLX9yXfY8HGwmkLSaWHCEV6Q7TrEz4azbXOkwlIXaF/JWsTKqK7w/hA1TiiZYOP+Lm/wrPeVZZ3CbIU8FWHx8xCYYLzfRQ1k5nEd1HR5GCYN63Hmr61dL36X9Q4eQFjvLG55aH/HSQ95WKtkwOt+Nzlufay0WCp+CQ1O7hu+owU6qCFuvpv1PNHEThLnpyxyDLPr2twcdOKMf/9ohpf/q6SP27E9gTNcltX7rxFDGYmB2f44Rb2rXqATeCwMeZnjiM/RROMvHN7ThIMn6fAMd9K1vyPBfGUjPhzfO9Nj1SGE3prdh5ILTKZY5AC3shuo+ohkM3puV83F6YctdbFtWSYIIRUbuF5tymNszM5ln0O70DIqUVnBcaGrSB4Zi0F7koD1AsC+9Jhd0hU9sHCmLw8nDGmlzQoZS24JAs/KgZRiSMzXNJGSZBUumKEqNpmdSt2dF4gGJSYx1r7BnV1Yzkx7FVNyfcaDXXb+rItK2DDhl7xyZAIi/5t1yf0rB2cmiC1/oeZedai/3adnQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(82310400026)(376014)(1800799024)(36860700016)(10067099003)(11063799006)(56012099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: BumGndFRSrCrd/kwBHP1+hJ2aLVa+ZGAClZZwmpnK8OmghZpZlxVS69CY/TysKyEC5txu7VLNbXV0kVrZaapIHM3t4IlixXnTOXBu5AKMih0Ck/2Qnn9ypiX68+Sc1Lvyusy/9CmaNy8kq8kQNe2HAUtj0mRFNw3c1l/HaViuB+XrQy75P7N7tfz0DjdyIA8DlMYqFOeVZ35nPlne3eeZn4C61d2heDwclwteQiMhLam31e1SgFOOQG2ucdbsZ9ODjqOI6zX/TbT2KaK+1miyPZkhW0t4IPoD1uOYUDX6HBeUbqmwJ013ndVMP9G1NtQcbbxW/g/hJbVf0G/MJl+J7w365BaAfMgkNlv9HMEc7Pc0+0noRocmfpWOPsH7TURcC66ddFR2OPD2Zg3dNm24GYEbQCm7YSbFvxvDRegvAEHZGxrwGsFjQhrPpBZxu+f
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2026 19:35:51.9170 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e37f032-35e8-4b07-7281-08deffbb6913
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EDD1.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4208
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
index d4e3a44252e36..03c061b135afb 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
@@ -1716,68 +1716,65 @@ static void amdgpu_ualink_exp_cleanup_worker(struct work_struct *work)
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
-		struct dma_resv *resv = amdkcl_ttm_resvp(&vm->root.bo->tbo);
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

