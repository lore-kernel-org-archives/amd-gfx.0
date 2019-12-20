Return-Path: <SRS0=BZXp=2K=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1D4FC43603
	for <amd-gfx@archiver.kernel.org>; Fri, 20 Dec 2019 06:25:06 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 754DB21D7D
	for <amd-gfx@archiver.kernel.org>; Fri, 20 Dec 2019 06:25:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="BWM8YLJN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 754DB21D7D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 24B9F89C29;
	Fri, 20 Dec 2019 06:25:06 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2042.outbound.protection.outlook.com [40.107.236.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CFBD189C29
 for <amd-gfx@lists.freedesktop.org>; Fri, 20 Dec 2019 06:25:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Kg7EXasCRDCzxh1zt8Ixya8nr3IG3qxxSr79SGWVOoYAOKn02XsoPnH60wxB0fuvDPc+QFLUHQav7e8FQmsgNAwnxbi2ElzbBkMAWdc/W9xFNDBPImoKBJUqNC1QftT7/Qmrr4Mi9CrQWvIlWLp6n43OGYzX2v0FVyQYgDHeUyIQl9bk4cj2yex0h+W60Z1i2BgC6KBgPo43NjnedrS4p80/g8eDFlSE9NOAbfZw0UiVBriu95CIpHTlVw+oPanxo3CctSgSjjsD+/lYuKYzkNib7uT5qegWJB0QQW6SjqvUC63LYoj77Pol+QggLSI67MvHeu3OCsX96ZQOioaEuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jRElxNBnhNN/G36IGUuQDKAQRF8NzV6PL9Sm62snXJw=;
 b=dnaaNYupW2c/ccz64TRIqcR8fzA6uG4C1+3sKzbZWTcuqo8saf3TciUEqI/hbdKO1h3T0J3e1zJfayd0Xg8NQ6WAU2Ac0i2xIEBD6xC+Xgwa3joA4ZgNrb3QvugqoIVdPsabEB8Tl1e3N1LSf9mZI/0QjFINJP8AFVZ9wgZ3H4TM+tnJ4Wg8+Ghrj4zKB36cKsayKeIHZBeHFM47IdsFCWS0Kv+DqKlWaEhrzDbf3jz0j8ugKirsZwjNIDHFHNDwksKRxnoNJkp/bs6/NGof7HSWfUsf7I6rA7WDzhMI9/g2IvEBAeZUH1mJkYUaqfE6V+g7QK8G+vIfeN1LzP7V8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jRElxNBnhNN/G36IGUuQDKAQRF8NzV6PL9Sm62snXJw=;
 b=BWM8YLJN40JU+oQLXnzXa0l1+ppXKbq5sOfJAKhWJbzWP8+C5RehGj8+idmJdcWEGbQ/rGboByZVjNHjOfjybdslH7Avay0QlxbL3OvBuQ5NG0CDKJWvT2mZmnbVSBjkHwzceA2KrVzeLJLB2A/Ded2YiVxhQNcQcaD9jkXUDbc=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Alex.Sierra@amd.com; 
Received: from BYAPR12MB2616.namprd12.prod.outlook.com (20.177.124.144) by
 BYAPR12MB2775.namprd12.prod.outlook.com (20.176.255.84) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2538.15; Fri, 20 Dec 2019 06:25:02 +0000
Received: from BYAPR12MB2616.namprd12.prod.outlook.com
 ([fe80::39fb:deaf:bb2f:420e]) by BYAPR12MB2616.namprd12.prod.outlook.com
 ([fe80::39fb:deaf:bb2f:420e%7]) with mapi id 15.20.2516.021; Fri, 20 Dec 2019
 06:25:02 +0000
From: Alex Sierra <alex.sierra@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 1/5] drm/amdgpu: Avoid reclaim fs while eviction lock
Date: Fri, 20 Dec 2019 00:24:38 -0600
Message-Id: <20191220062442.33635-1-alex.sierra@amd.com>
X-Mailer: git-send-email 2.17.1
X-ClientProxiedBy: SN4PR0501CA0085.namprd05.prod.outlook.com
 (2603:10b6:803:22::23) To BYAPR12MB2616.namprd12.prod.outlook.com
 (2603:10b6:a03:66::16)
MIME-Version: 1.0
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [165.204.77.1]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 5f0e03d3-b6cf-4938-50ce-08d785155851
X-MS-TrafficTypeDiagnostic: BYAPR12MB2775:|BYAPR12MB2775:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR12MB2775D3A64F9E7137AD95924FFD2D0@BYAPR12MB2775.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:159;
X-Forefront-PRVS: 025796F161
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(366004)(39860400002)(136003)(396003)(376002)(346002)(189003)(199004)(5660300002)(6666004)(66476007)(8936002)(8676002)(2616005)(81156014)(81166006)(478600001)(44832011)(6512007)(1076003)(2906002)(66556008)(66946007)(6916009)(316002)(26005)(186003)(36756003)(6506007)(52116002)(86362001)(4326008)(6486002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:BYAPR12MB2775;
 H:BYAPR12MB2616.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uX6LyMG6+wZp77tcoNtWJrWVyniQBCaiTlogn1dg01pPopcn+GOoC0zh75nVuui8ruA0TIdQ8PnP/VSpjDB+JRPNNsu4dVkp2Nirr4R/2belqqer2mg/bYTh0u/2OORfE5S3XA7Yk2/mICF9fHmcHi/XTHkjRpkQitYn4GNg52O9ulEBHsEjo8AQC4AzllbsjKycBLKI5JQPKg9FKkUrWBcKnsQ5oTo8u6XFIp5g8j8cMApw8OSeofrZfIag5z9bLpHDiasJxs2JUopRCKSwGEtKMBxR9V8wdLh6GTvkGEM1VE+toYh0LGVlKFgreLBjd5yy8Emun6eE+FbZosnhvOLBHl+uOoYJ7rz0X5Vkd/kUZ8ODT4vP1H4wpju6k066q46xHXtYH1ZNCNqQn+B5ug0cUB4RXrDhYn4DRoG+QjsxAEj2JsB2fL/AQvNV9gwY
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f0e03d3-b6cf-4938-50ce-08d785155851
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Dec 2019 06:25:02.2394 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: whrTl6M7fFl/WRooFahntK0a64kqPOXpzoEicsiLLOqK9Qdi91p8QHHpcfBW8lUK262Qj9BrdKHTvmVN1HtCuw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2775
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
Cc: Alex Sierra <alex.sierra@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[Why]
Avoid reclaim filesystem while eviction lock is held called from
MMU notifier.

[How]
Setting PF_MEMALLOC_NOFS flags while eviction mutex is locked.
Using memalloc_nofs_save / memalloc_nofs_restore API.

Change-Id: I5531c9337836e7d4a430df3f16dcc82888e8018c
Signed-off-by: Alex Sierra <alex.sierra@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 14 ++++++-------
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h | 28 +++++++++++++++++++++++++-
 2 files changed, 34 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index b999b67ff57a..b36daa6230fb 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -678,9 +678,9 @@ int amdgpu_vm_validate_pt_bos(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 		}
 	}
 
-	mutex_lock(&vm->eviction_lock);
+	vm_eviction_lock(vm);
 	vm->evicting = false;
-	mutex_unlock(&vm->eviction_lock);
+	vm_eviction_unlock(vm);
 
 	return 0;
 }
@@ -1559,7 +1559,7 @@ static int amdgpu_vm_bo_update_mapping(struct amdgpu_device *adev,
 	if (!(flags & AMDGPU_PTE_VALID))
 		owner = AMDGPU_FENCE_OWNER_KFD;
 
-	mutex_lock(&vm->eviction_lock);
+	vm_eviction_lock(vm);
 	if (vm->evicting) {
 		r = -EBUSY;
 		goto error_unlock;
@@ -1576,7 +1576,7 @@ static int amdgpu_vm_bo_update_mapping(struct amdgpu_device *adev,
 	r = vm->update_funcs->commit(&params, fence);
 
 error_unlock:
-	mutex_unlock(&vm->eviction_lock);
+	vm_eviction_unlock(vm);
 	return r;
 }
 
@@ -2537,18 +2537,18 @@ bool amdgpu_vm_evictable(struct amdgpu_bo *bo)
 		return false;
 
 	/* Try to block ongoing updates */
-	if (!mutex_trylock(&bo_base->vm->eviction_lock))
+	if (!vm_eviction_trylock(bo_base->vm))
 		return false;
 
 	/* Don't evict VM page tables while they are updated */
 	if (!dma_fence_is_signaled(bo_base->vm->last_direct) ||
 	    !dma_fence_is_signaled(bo_base->vm->last_delayed)) {
-		mutex_unlock(&bo_base->vm->eviction_lock);
+		vm_eviction_unlock(bo_base->vm);
 		return false;
 	}
 
 	bo_base->vm->evicting = true;
-	mutex_unlock(&bo_base->vm->eviction_lock);
+	vm_eviction_unlock(bo_base->vm);
 	return true;
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
index 100547f094ff..d35aa76469ec 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
@@ -30,6 +30,7 @@
 #include <drm/gpu_scheduler.h>
 #include <drm/drm_file.h>
 #include <drm/ttm/ttm_bo_driver.h>
+#include <linux/sched/mm.h>
 
 #include "amdgpu_sync.h"
 #include "amdgpu_ring.h"
@@ -242,9 +243,12 @@ struct amdgpu_vm {
 	/* tree of virtual addresses mapped */
 	struct rb_root_cached	va;
 
-	/* Lock to prevent eviction while we are updating page tables */
+	/* Lock to prevent eviction while we are updating page tables
+	 * use vm_eviction_lock/unlock(vm)
+	 */
 	struct mutex		eviction_lock;
 	bool			evicting;
+	unsigned int            saved_flags;
 
 	/* BOs who needs a validation */
 	struct list_head	evicted;
@@ -436,4 +440,26 @@ void amdgpu_vm_move_to_lru_tail(struct amdgpu_device *adev,
 				struct amdgpu_vm *vm);
 void amdgpu_vm_del_from_lru_notify(struct ttm_buffer_object *bo);
 
+/* vm eviction_lock can be taken in MMU notifiers. Make sure no reclaim-FS
+ * happens while holding this lock anywhere to prevent deadlocks when
+ * an MMU notifier runs in reclaim-FS context.
+ */
+static inline void vm_eviction_lock(struct amdgpu_vm *vm)
+{
+	mutex_lock(&vm->eviction_lock);
+	vm->saved_flags = memalloc_nofs_save();
+}
+static inline int vm_eviction_trylock(struct amdgpu_vm *vm)
+{
+	if (mutex_trylock(&vm->eviction_lock)) {
+		vm->saved_flags = memalloc_nofs_save();
+		return 1;
+	}
+	return 0;
+}
+static inline void vm_eviction_unlock(struct amdgpu_vm *vm)
+{
+	memalloc_nofs_restore(vm->saved_flags);
+	mutex_unlock(&vm->eviction_lock);
+}
 #endif
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
