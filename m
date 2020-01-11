Return-Path: <SRS0=NqWJ=3A=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC8E2C282DD
	for <amd-gfx@archiver.kernel.org>; Sat, 11 Jan 2020 18:39:57 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 867BF20866
	for <amd-gfx@archiver.kernel.org>; Sat, 11 Jan 2020 18:39:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="LOhy9rYW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 867BF20866
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0040C89DDF;
	Sat, 11 Jan 2020 18:39:57 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2087.outbound.protection.outlook.com [40.107.236.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0BDB689DDF
 for <amd-gfx@lists.freedesktop.org>; Sat, 11 Jan 2020 18:39:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TAM2qxqovfTDu6g6RezMpj2D/nzTO6GK5c4PL9o1PcUJ2Vsd1YncEwjYb7s1aVG1H1NguETr9plbVxtYlBPBuQaOWTXArXOJ1ItsKw5/z2GaIt21x512MmlmYHobygZPHYquhfdFNm7UyCtQVNpVkvWdV2/ssHJ3eKaZfIAR1Wymsrf+qFEz8leaxd9RXNi24+dNcDqH1hIO0t6fGDQ1sxuvGBSSWBBmV9rD0cVz/qKVBvJagb5b+P1e8ukk8yyKfx2B6FA8LcCzQNPBVHhfFhObW1BuOJ8s3OUqjKEPYUUeFqBmQmQ0IAuSdbx2XLSX4qBd+iqY1GKeIYNtoqmlCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1lpKxhOnn7ebHDjnQmuYleYe74WDsQRs+8XOp0GVQoU=;
 b=KW3/xEDTax6vxvvkCrNJLS5kWJ9TIHz5kSIz4wsGC7BY0hyxaGLXAx673zYDDdWCX1+gPqxTpN5lh9vA+/1NRU0LO7NU7JbGHyIwLJ91t0nH80nV/Q+X4xbAtimNgnyXM5lMw++9M2GLYq5iPUdSguLQAqPgzFWtnoctn7hkQs8+2YyF8K2fB33bN6T/rpRAgB7lRZnkAQnYP0TKdT3KsD0kt4Vsi5zMdX57+L4eSSRin1hWUO/K9fCKyVOm+pRLbkBgs80JOjGfiIkEn/73LahJOBULHGkId2mHyJmytYR7ITiy3Df+vmc7s7/JJgcolQ/Oj9zzSgmUi9Dn7DWV2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1lpKxhOnn7ebHDjnQmuYleYe74WDsQRs+8XOp0GVQoU=;
 b=LOhy9rYWYm4sa9MI0ymgdeCLLLb5w/ihAYwDvoi0BnCa+cOtc02I+AWgbU1Zmw+foG8vJiv4exBq0c6mGgTXgrouzdOtjgvQroCJ7MwPigS/wFH6Ul2Ioc4cyX0Do7y+UECl0nLJ2OXK7c4+u7So/GH/IMLLpqTLucSjvomxMkY=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Alex.Sierra@amd.com; 
Received: from SN6PR12MB2621.namprd12.prod.outlook.com (52.135.105.15) by
 SN6PR12MB2814.namprd12.prod.outlook.com (52.135.104.161) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2623.9; Sat, 11 Jan 2020 18:39:52 +0000
Received: from SN6PR12MB2621.namprd12.prod.outlook.com
 ([fe80::8923:17de:add5:1490]) by SN6PR12MB2621.namprd12.prod.outlook.com
 ([fe80::8923:17de:add5:1490%6]) with mapi id 15.20.2623.014; Sat, 11 Jan 2020
 18:39:52 +0000
From: Alex Sierra <alex.sierra@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 1/7] drm/amdgpu: Avoid reclaim fs while eviction lock
Date: Sat, 11 Jan 2020 12:39:32 -0600
Message-Id: <20200111183938.126310-1-alex.sierra@amd.com>
X-Mailer: git-send-email 2.17.1
X-ClientProxiedBy: SN6PR16CA0054.namprd16.prod.outlook.com
 (2603:10b6:805:ca::31) To SN6PR12MB2621.namprd12.prod.outlook.com
 (2603:10b6:805:73::15)
MIME-Version: 1.0
Received: from alex-MS-7B09.amd.com (165.204.77.1) by
 SN6PR16CA0054.namprd16.prod.outlook.com (2603:10b6:805:ca::31) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2623.13 via Frontend Transport; Sat, 11 Jan 2020 18:39:51 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [165.204.77.1]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 3f364767-8f4b-4555-b93a-08d796c5a4fb
X-MS-TrafficTypeDiagnostic: SN6PR12MB2814:|SN6PR12MB2814:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN6PR12MB2814937A7EABC1FEEAB95E82FD3B0@SN6PR12MB2814.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:291;
X-Forefront-PRVS: 0279B3DD0D
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(396003)(136003)(346002)(366004)(376002)(39860400002)(199004)(189003)(66476007)(26005)(66556008)(66946007)(16526019)(186003)(7696005)(52116002)(6916009)(86362001)(478600001)(4326008)(36756003)(5660300002)(6486002)(8676002)(316002)(6666004)(956004)(8936002)(2906002)(81166006)(81156014)(1076003)(44832011)(2616005);
 DIR:OUT; SFP:1101; SCL:1; SRVR:SN6PR12MB2814;
 H:SN6PR12MB2621.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YbLPLfTb/2YoqIE3SWdlmorRlrMPgNrNYrktajnZfeM2u+tEhpDBDI7pbQfRv1m+IuubObTwQET9dHRNKlJvYEUKxcJZO8gGwYtuXQREWfD6E0MMko0nl94a36u0HAA5UCrM2YH3SI3daDOkuvdOiAuJDuIYa/Vgwjl2CVsMn6dORWcBkSRUJihE3hDNh5EDGfeIXRG3vvnT8e1lKVkRPweWlE4EoFDWaWoLZdAoD6V7vTnjpUhEGobQlQfkRougqOPHk7kPtKXiO3pZsfRWd4TiVqxSD/SOMEDejhvLAb6N+CGhX/hGtukGqc/I0nveg6zcEU6vh7iMD1XgGD/XY8B4+58gqhpuMMsgn8kxGmMkLFx/Z3wkA+ToIbnT6vq52h5ZjOpFc1cdO/qzCZJDX4wd3zjm3B4oRJz/Pxr7XNJn2wzWJNzBzhent8/EdAHh
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f364767-8f4b-4555-b93a-08d796c5a4fb
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jan 2020 18:39:51.8997 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zp2hU8v0EvXCPpFD3YXkKPLk4uENkfo7mvmQX5vHaQ6UOGseQhxrk/X207o832EjaNWBCimORyViKAPT73fvzQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2814
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
Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>
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
