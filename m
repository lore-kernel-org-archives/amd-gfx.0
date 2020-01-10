Return-Path: <SRS0=i8pd=27=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E78C5C282DD
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Jan 2020 00:43:51 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8347F2075D
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Jan 2020 00:43:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="35pSTUkv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8347F2075D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DDF246E984;
	Fri, 10 Jan 2020 00:43:50 +0000 (UTC)
Received: from NAM04-CO1-obe.outbound.protection.outlook.com
 (mail-eopbgr690059.outbound.protection.outlook.com [40.107.69.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A24596E913
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Jan 2020 00:43:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ny8eCV2f26vvdnPq853WJfjYcEaWt4eWe9lvIiH/QKgGdUn7rsJk4YOXDwMpbuMs3aNkk6WHGMFQp8minYcV4nGxdoY90W5B05zVWtrqKLSvGdrwCnI+qY6uatt4q+9WrqXuYq5ai0WMwuGUk+7rFtJSunl+q8lLOUGP7puZQub3/R0fiCXGPozgnRl3DUXFRwuuW2P7xxaJJ2lvU4JkFkzqknYc6llYZ5uIh22uLC6JzSf+DKtQdzTAQAEBR4WppM4tfxl5Rvvh/jRfjpIaiyl9AIMZsqLKf6H2CVsntMdZzq/Biy/Mx0XoinE8jPmbJjw9VBW3Mv0ypa5U1u9cmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sn5bcucFYg7IYFCYgoOlS7LweoNj2paF0PBkYFJ8288=;
 b=Sym2i8Oz9cSH0Nirbpbw3WTb6Y1lH7A6scwHpvu7tyNInB/Y0BkdIQG2YdtMhsK+hMj7d8XLwpXgl5CAFHoaHJCpcLhOHDvWEg/QtVJOTwH3jz+UPDbzxc2ItOjTnMt7n69VhEmYCi4r75B+LyB9exFCxXd70NXdxr7Zw80J6gg9jWAUs0WRO3KGe6DYEjWUMCZvf57rzDhSVaH+jjcM1di/LZ7Fow15U9PdsYPtJwA5uw5kmUrA8t8uWtC0MJ34jGiVI2J8BylRu1AQs4xJin9GHFpMB9ye8CP1PoepnVxC6U3mg2pHJlsQE+RV7hcpEFthYoewJGpsuuOD9ssLxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sn5bcucFYg7IYFCYgoOlS7LweoNj2paF0PBkYFJ8288=;
 b=35pSTUkvg2SETS1zUvQ7NFvsBL7sRqdn20wul8ZWGw48qbobzATuwyTNxhK2+7z83pMSsu4MmXVuG2cengdVCpXGao0LEQgfcXy197ZZ0QzcNz6patlSgKZNTfQVeUWNH6EjW8raNhsU/GeeE/WOY9tf+xlHkY68KBmmkol4cNQ=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Alex.Sierra@amd.com; 
Received: from SN6PR12MB2621.namprd12.prod.outlook.com (52.135.105.15) by
 SN6PR12MB2672.namprd12.prod.outlook.com (52.135.103.25) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2623.9; Fri, 10 Jan 2020 00:43:47 +0000
Received: from SN6PR12MB2621.namprd12.prod.outlook.com
 ([fe80::8923:17de:add5:1490]) by SN6PR12MB2621.namprd12.prod.outlook.com
 ([fe80::8923:17de:add5:1490%6]) with mapi id 15.20.2623.008; Fri, 10 Jan 2020
 00:43:47 +0000
From: Alex Sierra <alex.sierra@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 1/8] drm/amdgpu: Avoid reclaim fs while eviction lock
Date: Thu,  9 Jan 2020 18:43:28 -0600
Message-Id: <20200110004335.113095-1-alex.sierra@amd.com>
X-Mailer: git-send-email 2.17.1
X-ClientProxiedBy: SN6PR2101CA0017.namprd21.prod.outlook.com
 (2603:10b6:805:106::27) To SN6PR12MB2621.namprd12.prod.outlook.com
 (2603:10b6:805:73::15)
MIME-Version: 1.0
Received: from alex-MS-7B09.amd.com (165.204.77.1) by
 SN6PR2101CA0017.namprd21.prod.outlook.com (2603:10b6:805:106::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2644.4 via Frontend
 Transport; Fri, 10 Jan 2020 00:43:47 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [165.204.77.1]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 9a5fc32e-936f-4d4e-65f2-08d795662743
X-MS-TrafficTypeDiagnostic: SN6PR12MB2672:|SN6PR12MB2672:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN6PR12MB26724B1EC634665093628C27FD380@SN6PR12MB2672.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:291;
X-Forefront-PRVS: 02788FF38E
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(136003)(346002)(39860400002)(396003)(376002)(366004)(199004)(189003)(8936002)(26005)(5660300002)(7696005)(316002)(86362001)(1076003)(186003)(2616005)(16526019)(956004)(44832011)(2906002)(36756003)(52116002)(66556008)(478600001)(66476007)(6916009)(6666004)(6486002)(66946007)(4326008)(81156014)(81166006)(8676002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:SN6PR12MB2672;
 H:SN6PR12MB2621.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: o6sBKjl3nXpkOXOPtKhNWzUK2kmbZf71rEIEshfsLBH23aY9kgASSrsCwtBpsoaeYF3Va/l/FKbqbfqAZ1OwjczwXv3gjt7bKxHsKaBWHPB1QyS6VES3KuVoKCOTDLfmbd6oRZWT6oGBOOx+84mB37BcmHBwSV9fw3ZQddnT3Ce/tSJiJCxaDiDYjKnbEDdIX5Dsn9W6W5kNBSTf8UjcTNbHEKvIAJchCfGDfR9sWs+PJ3QwxjsXFjHsGxja25JAj0ZHxMue7FgQEUbMInRRgm5y2cc+B1aHDAg9a/JA8ClOGZYoBuhL6Wctkop1cLqR6VLQL685k77WHCOoPs/g9a6y2v12Cxicnnj5PwKzprkYjms6WXFYnlsrUAZ+sjR/M3LPTyHd/FQq8QmT6+E3/anuAj9Emdj0Wwq99CIyo/A2TfGxCR2o5Mg8bmNP/85d
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a5fc32e-936f-4d4e-65f2-08d795662743
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2020 00:43:47.6014 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IAev49K5Iko79gtoYAlWfh4NEIt66YKB1AUkLJnfQSmUQNTo3T+5x20XzZBIHc0qS5kQz8musS3Y6F3MD+P3Eg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2672
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
