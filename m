Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB34FC54E41
	for <amd-gfx@archiver.kernel.org>; Fri, 23 Feb 2024 13:42:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3F57610EC0D;
	Fri, 23 Feb 2024 13:42:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="44KjcXrR";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2071.outbound.protection.outlook.com [40.107.94.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 58B9A10EC0C
 for <amd-gfx@lists.freedesktop.org>; Fri, 23 Feb 2024 13:42:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MokvFhqCMLxUj7UFcFhJopzvLTOy/O1x+FvtgwrpDaXnMy/iU718EPXVMRlFJun7yzeLiKai09YXgf/S/GtuMM5UYGJPoPzQWy1lgdhZ0gzk/uWdmvAx8tyXjZaALwXcxbz3VxlH9fGJN8hZCa3EctQDC6GFzyf3waozEBiv28zBAlyyEi2Y8ymOZyosh7dcjC7Rq1+rr1kUlqZAZakkkLDOF3BTO1+LWubxn/AtA0KS5heEjkH4SbsWtDX+Ze1n1BhmsNkfauRHbJbzsoj3Hew6kLv8OBHKzTyhv5WZ6qUbPFBCCNBDo8pJP4Ltu8XcGEAJS5Q+TJk6QWQ8QCWX2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aIUmJTa+v2AGWwihmuUouvCiYaw83tStMxUGbr0u/f4=;
 b=lOL4zlwyoq+FWYYXDhmo2lEnIhAkEyRV74AC60PFQqDvWtUZVH8ucA0RUrhaSBpeVhDpvCeBaoHurQcKIxAGf50AYp4oHyQ8g+F+XYHp9uZz3GOTWW0VLNKgxQ4krpEXDFYf4jcrRlKTVTQBUtbbBDQssKYF9lLuapXoFDNsqz1pYZA2dIj2ltBWDvk7+j0SFFNBZSAWRLU+7HDqTkSgLrfgnv2EccEzLv2f+Ia2A8lsbsqO+u/b4WGvForAq6sQ/Tw9DxKDRXlOsW+IVPsuvGSRhmH6UynMYCUmFVkZeAMiGLInBcXJPNrMd9Jfb9f2HxXeIgxCsxUfGpbMZYswNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aIUmJTa+v2AGWwihmuUouvCiYaw83tStMxUGbr0u/f4=;
 b=44KjcXrRsiHxLjfESFjCPwhZ3JrI+BYQqHixH614pZDmXHNavAitpNCqwna1WsZBnwSxOaI6Mg7tejkOz73ya5wxbsdFVQiMcOfaV/vsXVkGIVDYKC2EJOT7XoNsDgihYnDuD+i4mV7SnrhNf7U4h3b1L8GM+0/wc9COQcuJdlc=
Received: from DM6PR05CA0058.namprd05.prod.outlook.com (2603:10b6:5:335::27)
 by BN9PR12MB5323.namprd12.prod.outlook.com (2603:10b6:408:104::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.15; Fri, 23 Feb
 2024 13:42:34 +0000
Received: from CY4PEPF0000EDD1.namprd03.prod.outlook.com
 (2603:10b6:5:335:cafe::34) by DM6PR05CA0058.outlook.office365.com
 (2603:10b6:5:335::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.15 via Frontend
 Transport; Fri, 23 Feb 2024 13:42:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EDD1.mail.protection.outlook.com (10.167.241.205) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7292.25 via Frontend Transport; Fri, 23 Feb 2024 13:42:33 +0000
Received: from MUN-L-SHSHARMA.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Fri, 23 Feb
 2024 07:42:31 -0600
From: Shashank Sharma <shashank.sharma@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Shashank Sharma <shashank.sharma@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <Christian.Koenig@amd.com>, Alex Deucher
 <alexander.deucher@amd.com>, Felix Kuehling <felix.kuehling@amd.com>,
 Rajneesh Bhardwaj <rajneesh.bhardwaj@amd.com>
Subject: [PATCH v3 3/3] drm/amdgpu: sync page table freeing with tlb flush
Date: Fri, 23 Feb 2024 14:42:06 +0100
Message-ID: <20240223134206.899-3-shashank.sharma@amd.com>
X-Mailer: git-send-email 2.38.0.windows.1
In-Reply-To: <20240223134206.899-1-shashank.sharma@amd.com>
References: <20240223134206.899-1-shashank.sharma@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD1:EE_|BN9PR12MB5323:EE_
X-MS-Office365-Filtering-Correlation-Id: 3fb346c0-8802-4303-1957-08dc34754a39
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VhUT8qLrqzXxVZlsqKiDf/xL7ub2roh7FO3QaCGYE1/zcmhNpXJUMDjFfYecF6HH5jRjll9qUbCZbBJmUgbqomPYrv196Zku/NINEyqBFtF+yfagp3d94j8ENaB20FDwUse+pg4gzpn4fN3Z+UvEtSwRC0jACapGi5qWoIac/IBtt/BN6Y21OSbobbdBBeZPwqexnglM4cGRyjumyVsllZJA+9fyKFhFTRO29sj/u+w5BS9HNK9BsTQDavYkjbt0IZviWod7jdBDnS/3tCGLN0JOVo6zBtpPEAYanvpL+08uVfAARAHUTRsUIvQi/07Lf+KSHkh4pLpjXQNjRsLccULE8X0arrB2mYflDQUjtCpLv0cfQGM1+8JhxXY4TVmCYd0dB/X7yB5WaDvw05lNy8ahRC8KkMU3uBHu+vYCXMWS3NrxIE3tz5qI3fqM3ovbt2sh8DyIFdtWCklq7eqG7Z9EyYsilaNTbxA4o4G0JAU1PdPws7EoaDlHZPExwOcvda9fOON/lefFV4q/1q/l8+9O3TrnlSIb7QncoC6Z7Bn8bR3bMvDH1YtTDnl/+8B21YQVOYzIMkolp23sObMiRkz4CZlxkrbelkgEujL//zsy6Ae41vPBsBrzq8/zmqBneKKIwXV/4jWERENF0ShcTt8Qe1+cCpK5Q0+2i8RFc54=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(36860700004)(40470700004)(46966006); DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Feb 2024 13:42:33.9748 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3fb346c0-8802-4303-1957-08dc34754a39
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EDD1.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5323
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

This patch:
- adds a new list in amdgou_vm to hold the VM PT entries being freed
- waits for the TLB flush using the vm->tlb_flush_fence
- actually frees the PT BOs

V2: rebase
V3: Do not attach the tlb_fence to the entries, rather add the entries
    to a list and delay their freeing (Christian)

Cc: Christian König <Christian.Koenig@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Felix Kuehling <felix.kuehling@amd.com>
Cc: Rajneesh Bhardwaj <rajneesh.bhardwaj@amd.com>
Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c    |  6 +++
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h    |  6 +++
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c | 51 ++++++++++++++++++++---
 3 files changed, 58 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index 67c690044b97..eebb73f2c2ef 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -939,6 +939,10 @@ int amdgpu_vm_update_range(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 		/* Makes sure no PD/PT is freed before the flush */
 		dma_resv_add_fence(vm->root.bo->tbo.base.resv, *fence,
 				   DMA_RESV_USAGE_BOOKKEEP);
+
+		mutex_lock(&vm->tlb_fence_lock);
+		vm->tlb_fence_last = *fence;
+		mutex_unlock(&vm->tlb_fence_lock);
 	}
 
 	amdgpu_res_first(pages_addr ? NULL : res, offset,
@@ -2212,6 +2216,7 @@ int amdgpu_vm_init(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 	INIT_LIST_HEAD(&vm->freed);
 	INIT_LIST_HEAD(&vm->done);
 	INIT_LIST_HEAD(&vm->pt_freed);
+	INIT_LIST_HEAD(&vm->tlb_flush_waitlist);
 	INIT_WORK(&vm->pt_free_work, amdgpu_vm_pt_free_work);
 	INIT_KFIFO(vm->faults);
 
@@ -2244,6 +2249,7 @@ int amdgpu_vm_init(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 	vm->last_unlocked = dma_fence_get_stub();
 	vm->generation = 0;
 
+	mutex_init(&vm->tlb_fence_lock);
 	mutex_init(&vm->eviction_lock);
 	vm->evicting = false;
 	vm->tlb_fence_context = dma_fence_context_alloc(1);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
index 8e6fd25d07b7..77f10ed80973 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
@@ -334,6 +334,10 @@ struct amdgpu_vm {
 	uint64_t		*tlb_seq_cpu_addr;
 	uint64_t		tlb_fence_context;
 
+	struct mutex 		tlb_fence_lock;
+	struct dma_fence	*tlb_fence_last;
+	struct list_head	tlb_flush_waitlist;
+
 	atomic64_t		kfd_last_flushed_seq;
 
 	/* How many times we had to re-generate the page tables */
@@ -379,6 +383,8 @@ struct amdgpu_vm {
 
 	/* cached fault info */
 	struct amdgpu_vm_fault_info fault_info;
+
+	int count_bos;
 };
 
 struct amdgpu_vm_manager {
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
index 95dc0afdaffb..57ea95c5c085 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
@@ -643,13 +643,13 @@ static void amdgpu_vm_pt_free(struct amdgpu_vm_bo_base *entry)
 	if (!entry->bo)
 		return;
 
-	entry->bo->vm_bo = NULL;
 	shadow = amdgpu_bo_shadowed(entry->bo);
 	if (shadow) {
 		ttm_bo_set_bulk_move(&shadow->tbo, NULL);
 		amdgpu_bo_unref(&shadow);
 	}
 	ttm_bo_set_bulk_move(&entry->bo->tbo, NULL);
+	entry->bo->vm_bo = NULL;
 
 	spin_lock(&entry->vm->status_lock);
 	list_del(&entry->vm_status);
@@ -657,6 +657,38 @@ static void amdgpu_vm_pt_free(struct amdgpu_vm_bo_base *entry)
 	amdgpu_bo_unref(&entry->bo);
 }
 
+static void amdgpu_vm_pt_flush_waitlist(struct amdgpu_vm *vm)
+{
+	struct amdgpu_vm_bo_base *entry, *next;
+	LIST_HEAD(tlb_flush_waitlist);
+
+	if (!vm || list_empty(&vm->tlb_flush_waitlist))
+		return;
+
+	/* Wait for pending TLB flush before freeing PT BOs */
+	mutex_lock(&vm->tlb_fence_lock);
+	if (vm->tlb_fence_last && !dma_fence_is_signaled(vm->tlb_fence_last)) {
+		if (dma_fence_wait_timeout(vm->tlb_fence_last, false,
+					   MAX_SCHEDULE_TIMEOUT) <= 0) {
+			DRM_ERROR("Timedout waiting for TLB flush, not freeing PT BOs\n");
+			mutex_unlock(&vm->tlb_fence_lock);
+			return;
+		}
+
+		vm->tlb_fence_last = NULL;
+	}
+
+	/* Save the waitlist locally and reset the flushlist */
+	list_splice_init(&vm->tlb_flush_waitlist, &tlb_flush_waitlist);
+	mutex_unlock(&vm->tlb_fence_lock);
+
+	/* Now free the entries */
+	list_for_each_entry_safe(entry, next, &tlb_flush_waitlist, vm_status) {
+		if (entry)
+			amdgpu_vm_pt_free(entry);
+	}
+}
+
 void amdgpu_vm_pt_free_work(struct work_struct *work)
 {
 	struct amdgpu_vm_bo_base *entry, *next;
@@ -673,7 +705,7 @@ void amdgpu_vm_pt_free_work(struct work_struct *work)
 	amdgpu_bo_reserve(vm->root.bo, true);
 
 	list_for_each_entry_safe(entry, next, &pt_freed, vm_status)
-		amdgpu_vm_pt_free(entry);
+		list_move(&entry->vm_status, &vm->tlb_flush_waitlist);
 
 	amdgpu_bo_unreserve(vm->root.bo);
 }
@@ -708,11 +740,17 @@ static void amdgpu_vm_pt_free_dfs(struct amdgpu_device *adev,
 		return;
 	}
 
-	for_each_amdgpu_vm_pt_dfs_safe(adev, vm, start, cursor, entry)
-		amdgpu_vm_pt_free(entry);
+	mutex_lock(&vm->tlb_fence_lock);
+
+	for_each_amdgpu_vm_pt_dfs_safe(adev, vm, start, cursor, entry) {
+		if (entry)
+			list_add(&entry->vm_status, &vm->tlb_flush_waitlist);
+	}
 
 	if (start)
-		amdgpu_vm_pt_free(start->entry);
+		list_add(&start->entry->vm_status, &vm->tlb_flush_waitlist);
+
+	mutex_unlock(&vm->tlb_fence_lock);
 }
 
 /**
@@ -725,6 +763,7 @@ static void amdgpu_vm_pt_free_dfs(struct amdgpu_device *adev,
 void amdgpu_vm_pt_free_root(struct amdgpu_device *adev, struct amdgpu_vm *vm)
 {
 	amdgpu_vm_pt_free_dfs(adev, vm, NULL, false);
+	amdgpu_vm_pt_flush_waitlist(vm);
 }
 
 /**
@@ -1070,6 +1109,8 @@ int amdgpu_vm_ptes_update(struct amdgpu_vm_update_params *params,
 		}
 	}
 
+	/* Actually free the buffers now */
+	amdgpu_vm_pt_flush_waitlist(params->vm);
 	return 0;
 }
 
-- 
2.43.2

