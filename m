Return-Path: <SRS0=i8pd=27=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 575CEC282DD
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Jan 2020 00:04:32 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2E5692075D
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Jan 2020 00:04:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="UsR4o1Q8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E5692075D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A84A46E084;
	Fri, 10 Jan 2020 00:04:28 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2051.outbound.protection.outlook.com [40.107.237.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E97716E072
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Jan 2020 00:04:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IAvb8lVkpoFQA8H8GxUB90dGdc7oygOSRdMJ+XiVK2ZxB994+xvhivZvuzad39aYyJznBQoelUSdlklx8tKYn0fNE/yE6x+357/QTrCkrtOtILjykeSH7yDhOPvSWx2a53cq406qjwFvxhqfl6zFdKS3AERXGA2B7sbIh4XdyGGYtZ9B5A4xWy22F0bf0V3j3Nz9I+TMidRaMw20FNam5BcHG5is86eV5D0gOSm+cCGcoxVFg8i5CDUr9rplj9HKM9plIOr188EAxQXblnojAAa2Zdv+95auLgG7I9SMwYf616WE7jxIEgZQx8n6k4MKe0QUxagMgmZ160oSLuDA9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sn5bcucFYg7IYFCYgoOlS7LweoNj2paF0PBkYFJ8288=;
 b=YBRMRcjCE92wgY++pS1XXNdBACCv42WGQ0SfdiH6ARIXM09HdX6TAaHut8HxWeShPkj0OgWoobEGkkSynlNPvYN9WWUu7aS3UiprItKIWMZ+/VmoYW1plMX9x6RgY0vCCUQ9s20mYmIs2PtvZMcdPG4zRpjMafg7OxV3Qj8+u3H8+PxSSVzE55y9FY145KqwMepqs7DPs5b0JPRUr2vOGkJ0axp+jIzcaJ5UDQsDC/9m3y/id7ItJIwmNVum2uvDF4xgwV1QxcEwiundOv6K4mZ4IBxRH2m72sPRYz0J3Xd2jfEWGXJjlE4Jn+x8w1hyicDffUd7iub0x5z0190ecQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sn5bcucFYg7IYFCYgoOlS7LweoNj2paF0PBkYFJ8288=;
 b=UsR4o1Q8Ohke/MmwQ2oBIMcj8fY1m+/pDufrMzcfoYpRyTGEKvoTs0DLJ99OqGLBD0B1hq8jSyynWigfi1RE9CWWHSxKAVTzBkTIQNeGas/ucU5zKlASSdlvL9NnI+vy9DTGxJ3fQkkncbFiKyYs3+PvuSp3hbA5K+0DHiChJ4U=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Alex.Sierra@amd.com; 
Received: from SN6PR12MB2621.namprd12.prod.outlook.com (52.135.105.15) by
 SN6PR12MB2720.namprd12.prod.outlook.com (52.135.103.141) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2623.9; Fri, 10 Jan 2020 00:04:25 +0000
Received: from SN6PR12MB2621.namprd12.prod.outlook.com
 ([fe80::8923:17de:add5:1490]) by SN6PR12MB2621.namprd12.prod.outlook.com
 ([fe80::8923:17de:add5:1490%6]) with mapi id 15.20.2623.008; Fri, 10 Jan 2020
 00:04:25 +0000
From: Alex Sierra <alex.sierra@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 1/7] drm/amdgpu: Avoid reclaim fs while eviction lock
Date: Thu,  9 Jan 2020 18:04:06 -0600
Message-Id: <20200110000412.66930-1-alex.sierra@amd.com>
X-Mailer: git-send-email 2.17.1
X-ClientProxiedBy: SN2PR01CA0005.prod.exchangelabs.com (2603:10b6:804:2::15)
 To SN6PR12MB2621.namprd12.prod.outlook.com (2603:10b6:805:73::15)
MIME-Version: 1.0
Received: from alex-MS-7B09.amd.com (165.204.77.1) by
 SN2PR01CA0005.prod.exchangelabs.com (2603:10b6:804:2::15) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2623.8 via Frontend Transport; Fri, 10 Jan 2020 00:04:25 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [165.204.77.1]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 208526a2-cdfa-4152-5de5-08d79560a74b
X-MS-TrafficTypeDiagnostic: SN6PR12MB2720:|SN6PR12MB2720:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN6PR12MB2720CC0A679E2A309E04FE1BFD380@SN6PR12MB2720.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:291;
X-Forefront-PRVS: 02788FF38E
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(366004)(136003)(396003)(346002)(376002)(39850400004)(189003)(199004)(26005)(316002)(36756003)(52116002)(16526019)(186003)(956004)(86362001)(1076003)(44832011)(5660300002)(6666004)(7696005)(6916009)(2616005)(81166006)(66476007)(66946007)(6486002)(8936002)(66556008)(4326008)(2906002)(81156014)(8676002)(478600001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:SN6PR12MB2720;
 H:SN6PR12MB2621.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qmNTW0Ll9nX4rXmCNW/n9Bbs4m7wAPNlGQhRNBsZouJGVft4Pmqh/MRsLaObOG23+R1xjPzL2RgSQ2pTBdskbsAt34+EjMDwef3LUZavzv/m6dm6LWzrK4yPpWy2ob/H8qJavavotviA+/ih5KE6xK1gDkXoCQWpy1o8unU/wCTAEEO9Ssj02LbjJVKuKLQG1GnbIdY1qKcvvv7TYgC2BqW5bOlb9jPQYeqRT54JKOjJ75fT8XdsMHp07GukqycYVTmBey21le9TdkNbfdTfpbOdjwN0HjhZ7HFhEXJY4Qi3WaJgu5U83yGBWc9/Y/4Y9TFvJ4jh7vSzkcRQ1RAHQcfj1hR+rC9Lv0mwyTTt7Q1V2gm4/rRJky/olb7VRfmo7sJ4OyGLd1EHm09kQ68+CpTE+y2kjpTQ6QBl3Sm8goqTK534/TACT8vF+sTxpdqr
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 208526a2-cdfa-4152-5de5-08d79560a74b
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2020 00:04:25.3946 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0zGup6hplNCX4tzWEVFIoU8xq4683PzJJgDYLkdf4Tn1JWVGikJ+HuY3vvJaYocO7XjJwFgF1/hglhaO+zHEaA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2720
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
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 40 +++++++++++++++++++++-----
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h |  6 +++-
 2 files changed, 38 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index b999b67ff57a..d6aba4f9df74 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -82,6 +82,32 @@ struct amdgpu_prt_cb {
 	struct dma_fence_cb cb;
 };
 
+/**
+ * vm eviction_lock can be taken in MMU notifiers. Make sure no reclaim-FS
+ * happens while holding this lock anywhere to prevent deadlocks when
+ * an MMU notifier runs in reclaim-FS context.
+ */
+static inline void amdgpu_vm_eviction_lock(struct amdgpu_vm *vm)
+{
+	mutex_lock(&vm->eviction_lock);
+	vm->saved_flags = memalloc_nofs_save();
+}
+
+static inline int amdgpu_vm_eviction_trylock(struct amdgpu_vm *vm)
+{
+	if (mutex_trylock(&vm->eviction_lock)) {
+		vm->saved_flags = memalloc_nofs_save();
+		return 1;
+	}
+	return 0;
+}
+
+static inline void amdgpu_vm_eviction_unlock(struct amdgpu_vm *vm)
+{
+	memalloc_nofs_restore(vm->saved_flags);
+	mutex_unlock(&vm->eviction_lock);
+}
+
 /**
  * amdgpu_vm_level_shift - return the addr shift for each level
  *
@@ -678,9 +704,9 @@ int amdgpu_vm_validate_pt_bos(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 		}
 	}
 
-	mutex_lock(&vm->eviction_lock);
+	amdgpu_vm_eviction_lock(vm);
 	vm->evicting = false;
-	mutex_unlock(&vm->eviction_lock);
+	amdgpu_vm_eviction_unlock(vm);
 
 	return 0;
 }
@@ -1559,7 +1585,7 @@ static int amdgpu_vm_bo_update_mapping(struct amdgpu_device *adev,
 	if (!(flags & AMDGPU_PTE_VALID))
 		owner = AMDGPU_FENCE_OWNER_KFD;
 
-	mutex_lock(&vm->eviction_lock);
+	amdgpu_vm_eviction_lock(vm);
 	if (vm->evicting) {
 		r = -EBUSY;
 		goto error_unlock;
@@ -1576,7 +1602,7 @@ static int amdgpu_vm_bo_update_mapping(struct amdgpu_device *adev,
 	r = vm->update_funcs->commit(&params, fence);
 
 error_unlock:
-	mutex_unlock(&vm->eviction_lock);
+	amdgpu_vm_eviction_unlock(vm);
 	return r;
 }
 
@@ -2537,18 +2563,18 @@ bool amdgpu_vm_evictable(struct amdgpu_bo *bo)
 		return false;
 
 	/* Try to block ongoing updates */
-	if (!mutex_trylock(&bo_base->vm->eviction_lock))
+	if (!amdgpu_vm_eviction_trylock(bo_base->vm))
 		return false;
 
 	/* Don't evict VM page tables while they are updated */
 	if (!dma_fence_is_signaled(bo_base->vm->last_direct) ||
 	    !dma_fence_is_signaled(bo_base->vm->last_delayed)) {
-		mutex_unlock(&bo_base->vm->eviction_lock);
+		amdgpu_vm_eviction_unlock(bo_base->vm);
 		return false;
 	}
 
 	bo_base->vm->evicting = true;
-	mutex_unlock(&bo_base->vm->eviction_lock);
+	amdgpu_vm_eviction_unlock(bo_base->vm);
 	return true;
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
index 100547f094ff..c21a36bebc0c 100644
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
+	unsigned int		saved_flags;
 
 	/* BOs who needs a validation */
 	struct list_head	evicted;
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
