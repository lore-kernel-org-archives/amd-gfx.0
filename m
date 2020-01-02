Return-Path: <SRS0=MtTs=2X=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB07BC2D0DC
	for <amd-gfx@archiver.kernel.org>; Thu,  2 Jan 2020 21:12:07 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2D30221582
	for <amd-gfx@archiver.kernel.org>; Thu,  2 Jan 2020 21:12:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="zWj6Czjf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D30221582
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C98FD6E146;
	Thu,  2 Jan 2020 21:12:06 +0000 (UTC)
Received: from NAM04-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr700054.outbound.protection.outlook.com [40.107.70.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9D71C6E146
 for <amd-gfx@lists.freedesktop.org>; Thu,  2 Jan 2020 21:12:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LJIi7cI9eHzGSq8mKUXQs+KxLkWkKLQMG0R/6SCqpY4j65RDAfsXh/xs38ET1SGXkwv60rBVl/Z9E1/Ms8xg44I/id3E6tWKOVF2sTrewWrQ/ZLIubqjJVWuQEhg4vwsGh7P5GFsQr0sk1a3KuJC6IMltl3AtJFVvLL5JWunZDDAbWyHhWtZGXc2m2LAo/b+R8ZKlHl03SRGg98eUceMIuxmnwCQb4XeNNLOc5/SHqOoGrqBD/id7yFOharqlrgpp9lB3abjG6MJJn1H/nNBsUBiO3Heh6+k4ONu7LXGv+iwQ3MrOzvbVKvmCK2eJm3YzonamjTiJhzt1oBAJUrhEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sn5bcucFYg7IYFCYgoOlS7LweoNj2paF0PBkYFJ8288=;
 b=n6xXFBH/ob+WEmbzSxpmk6CmqXSCehithhYVYy+K+Z6p2zxdxDlqmNmbSvA0eKdhsZXVUTm5UwoYsKQwx2UKXZ4dQTH81QK0pC7mLTuIerkGFTnnn0AF5Z5xixcaU2FFVUkwNbN4ZlIBAIWLa+hdPMUQi9Zog6hWKixJ8YhHd/HLOKofFp3RuBhtRmhE9K0cHJXnBVEwB2jjp5O62XsNjoAqbjD7XR9zljaNXohCuPeUwI3AkrNgHhOE5gYjMYNR+aToUqNVccueNkZsKLWoGcY3ryxxRvkUmywF+gX9xlNCcrix47BTlmDv2CtC2uN+NRfQOy2T9t8CeMqeILwnkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sn5bcucFYg7IYFCYgoOlS7LweoNj2paF0PBkYFJ8288=;
 b=zWj6CzjfX832gBM81RmOHEYTHEX0R76COPW5UhRiHJqa1rmNba9vqfK9vrQeqvy3y4KoHhWD/b6s9g8Tzy2vuRqqaFp0+0GoPVDZJSEKFQgJ57feCtCSd/+WNEPFfw6/XPRKeuiUiBkL8xBXpHbauzGITAEbwB+bwrCd91tb3Y0=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Alex.Sierra@amd.com; 
Received: from SN6PR12MB2621.namprd12.prod.outlook.com (52.135.105.15) by
 SN6PR12MB2605.namprd12.prod.outlook.com (52.135.100.139) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2581.11; Thu, 2 Jan 2020 21:12:04 +0000
Received: from SN6PR12MB2621.namprd12.prod.outlook.com
 ([fe80::8923:17de:add5:1490]) by SN6PR12MB2621.namprd12.prod.outlook.com
 ([fe80::8923:17de:add5:1490%6]) with mapi id 15.20.2602.012; Thu, 2 Jan 2020
 21:12:03 +0000
From: Alex Sierra <alex.sierra@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 1/5] drm/amdgpu: Avoid reclaim fs while eviction lock
Date: Thu,  2 Jan 2020 15:11:43 -0600
Message-Id: <20200102211147.26566-1-alex.sierra@amd.com>
X-Mailer: git-send-email 2.17.1
X-ClientProxiedBy: SN6PR04CA0079.namprd04.prod.outlook.com
 (2603:10b6:805:f2::20) To SN6PR12MB2621.namprd12.prod.outlook.com
 (2603:10b6:805:73::15)
MIME-Version: 1.0
Received: from alex-MS-7B09.amd.com (165.204.77.1) by
 SN6PR04CA0079.namprd04.prod.outlook.com (2603:10b6:805:f2::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2602.10 via Frontend Transport; Thu, 2 Jan 2020 21:12:03 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [165.204.77.1]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 50e5e287-3ce4-4bcd-207f-08d78fc86a50
X-MS-TrafficTypeDiagnostic: SN6PR12MB2605:|SN6PR12MB2605:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN6PR12MB2605A908A4B37F025947258AFD200@SN6PR12MB2605.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:291;
X-Forefront-PRVS: 0270ED2845
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(136003)(396003)(376002)(346002)(39860400002)(366004)(199004)(189003)(8936002)(81166006)(5660300002)(81156014)(8676002)(316002)(2616005)(956004)(1076003)(6666004)(4326008)(44832011)(86362001)(16526019)(6916009)(186003)(26005)(478600001)(52116002)(36756003)(2906002)(7696005)(66556008)(66946007)(66476007)(6486002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:SN6PR12MB2605;
 H:SN6PR12MB2621.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kQl8qUUVdwz2aTAIy+XwF9wuyFrMyYRE4Tctwu3FtH4VG85i2aNUvlmup3Ipql6sia7ZZ8nkRAahFuPEP6otVr9rkQDtkJSL04Ng0EtuDzOu4YDIgyrcoQ0Pi9lzTzKzS/mr0q3F5TlsmNdCN7Yy2ai+HOUXQAoz7Rw0YVyrYkg8elc5ji2Rp/nfuKWbQMYxFwYzfnnT5VflrB0m03d+4DsNdCWhz8u6iEraAp/HNPrKXp4o9Oo9rFHevJ+lpKZf1FNodjTJoKSEVXIK/Aa+QyJsoi5udYfGuLaYV3Ro0kFRBLwAKHb1/Ibdn+W/4L66ziEYg7ZC04hoSIclNrapGRNQCjMfPomlCtHJSZu9cMNPctM4y1g9aZuEm6ermaO59pQRMCCPyaI2QORLG4HQ//OmU1xhelKRM9U7xTXrqO1bmDwjr5L18lozqbSSHCrx
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 50e5e287-3ce4-4bcd-207f-08d78fc86a50
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jan 2020 21:12:03.8400 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OX4qgWdTkRZaDY00iNJWXK27GJ6lZ6auqcug+dlo1qDRarfFCp2JlETXJ/jXHylY8Rfz/78mHwswP7Yr1Sq5gA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2605
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
