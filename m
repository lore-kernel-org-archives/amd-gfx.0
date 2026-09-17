Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA506C982CF
	for <amd-gfx@archiver.kernel.org>; Thu, 17 Sep 2026 11:03:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4DAA610EDCF;
	Thu, 17 Sep 2026 11:03:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="kDC4Lrme";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011019.outbound.protection.outlook.com [52.101.62.19])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BFEC410EDC1
 for <amd-gfx@lists.freedesktop.org>; Thu, 17 Sep 2026 11:03:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cysgrS9CRt6y0Ds3w5LWKyToUVJ+W3xFjsMCpre3YtZhUE4Bo8k7Qu5fKwpMAO/TnnXeo0lf6VUS+jLB9jw7BIa0MTM87smEg2P0bPdsXZb7efDpoEA61bPdBzdI1/gjeHmVQGE8/BpeOtBQRC5etju4Mw8rjAec6incQkxBJP2aBRFopUjFEwp0IAMMsWVAPMLtcDCgU+u3Qb9euTdntEIimHbi0eobRnXet/1F/Swdrh6PYDRs9jzn+hbXWuCiOeyNTvy31GsB8ktU8W4Z75X/NASJN2ZMfNs2/U87uCBDeOASruW/R1w0fcsmaSsoZixNpnt6+0/b0mYc5erl4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cfQycnVfncaMAkd+S3gDKaM6S0kEPZ3FSJ1KaMZMRzY=;
 b=l5tGH+h3g1W+tqPJxC2lQp4TQZfjwQqgkcVXXJvdv9F38XKF4lRr/Ey4bGlVt9Dq9Ah8ncf9+g8lELl8Hy/gmIaVuy6KG3u0cmZhoDrbVcYKU4u3rwSppdDxBlv+NX3uBal8qeGlVzuBbpHgY3TX/DwkKIQu8Mk7I6C8SyWLj5vUpuXwCDS0GroJrcKHDV92LBANDfdQoyEGQeFnz95DfwO94V9qYDWqZ0TB1/pxXfzAgOytM2WMe0CMd9tA4QV5qdpq/plg6xD+Vf4C5hDASjoD+gG6xHfktMncSwxRiiEKNeEZMFwEQIQesGOTwJeDHTygfS3fDeZCqoy+J7sXJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=gmail.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cfQycnVfncaMAkd+S3gDKaM6S0kEPZ3FSJ1KaMZMRzY=;
 b=kDC4LrmeU+lJa7NagkxTy13SSTVqx0Vi0QXwkly5gDULgKtfgiW7LZMmK3K2zj8VNZySipErWAv+JjwojMdkOtQ6ev7YPmRYOIVqllT6PcowIK0AJGORRt3AO4di4Wbc9B7FWSibRxXXLFMAMxEZVV+Q4PXVT3D8eiLXKFWbgog=
Received: from SJ0PR03CA0177.namprd03.prod.outlook.com (2603:10b6:a03:338::32)
 by SA1PR12MB6945.namprd12.prod.outlook.com (2603:10b6:806:24c::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Thu, 17 Sep
 2026 11:02:59 +0000
Received: from SJ5PEPF00000209.namprd05.prod.outlook.com
 (2603:10b6:a03:338:cafe::42) by SJ0PR03CA0177.outlook.office365.com
 (2603:10b6:a03:338::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.406.11 via Frontend Transport; Thu,
 17 Sep 2026 11:02:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF00000209.mail.protection.outlook.com (10.167.244.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.8 via Frontend Transport; Thu, 17 Sep 2026 11:02:59 +0000
Received: from yhuang-B850M-AORUS-PRO-WIFI7.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Thu, 17 Sep 2026 06:02:56 -0500
From: Huang Yu <yhuang13@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
CC: Yu Huang <Yu.Huang@amd.com>, Honglei Huang <honghuan@amd.com>, Ray Huang
 <ray.huang@amd.com>, Shen Junhua <junhshen@amd.com>, Lingshan Zhu
 <lingszhu@amd.com>, Timur Cristof <timur.kristof@gmail.com>, Natalie Vock
 <natalie.vock@gmx.de>, AMD-GFX <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 07/13] drm/amdgpu: nuke most amdgpu_vm_eviction_(try)lock uses
Date: Thu, 17 Sep 2026 19:01:52 +0800
Message-ID: <20260917110158.296198-8-yhuang13@amd.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260917110158.296198-1-yhuang13@amd.com>
References: <20260917110158.296198-1-yhuang13@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF00000209:EE_|SA1PR12MB6945:EE_
X-MS-Office365-Filtering-Correlation-Id: 3e694cc2-1691-452e-ef3d-08df14ab3c64
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700016|376014|82310400026|23010399003|56012099006|11063799006|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: gZ97B98e3eNQFDB/SdywmZ7gTBvMEqN7P5z3frMxDiKvusFbEczDqWsluzVJ6slML2y+RvXbNya1EdY7gZrIV6OxYoDtuNPE51SiATR9l0DdWYgajPCNrLHfKVZDzpsgKMNBKvqUBdKHyymYWH2mAh3M+gWLmyCDEk7f/0+dmdDkx0bYtgk5zaVka1TgoGHe1c6wXcByp2dDuN4B9w4mYVv9jF42OwXVXqa2kzi8iwdfZ65smeEgSSLQFUkfpK7HLwlMQU2MbyMLA9NzomJFPIKDpGszH4X4EmFhQ1xeK3aXqjACJ5Suq7ry8zwNPsL5hCgrzk3wKplUVmUFObGwvLeuAxrcxSF4nq14Lg/tuMShGgP08z7aHKfQfPlufPWiZ+pkTpab4xNsq3iAcQZF6oDDNR2MSWqAwoa8lXIY7dF2oyd+iT0/24nzjCaUN4KrTsm69JZfmmBwjlqmOitSRGsh7gcCBNyw8XrTEURcJMwrA3VH/wA/Bn0dUU3fD/rT8HP7Hk7daLFLc8oQnzTtReEEzSDvOvaWPGg1Ev4n3NOFt/VfR1yvlKxopcSOe+g4t2mdFNOs1VnCKWOQ6IdFIMW9L1Cj9FxwQWpRXdfYL7K6b5iI/EBAP6LGhSb0B64yAxsWmQqYSP7VrfXmhU/3WlwSehGFkQMnhOR43i/JjTxwdMeIyjqQkx+7ounzYikMegiqB6arb1BCtMSRGsO/xg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700016)(376014)(82310400026)(23010399003)(56012099006)(11063799006)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: aiZ/QPfMRemSThcRupOvgFprNI1O/Oh1oouToqCnt2TQntWG8JrGG2ABxut4NBYK9TMIcEWivlJf/jFvwMGX+FmyI5k3qcBnweJQ+GOjCZnkadiXTstdSduiQdOUwHhJzSiDi+SfYNfhxkkDcAiD+ZiL8MLCBLBkE8yNTL2uHWDpn0s6AjYxtB/9iJfvHFQVOeEPwrMMB+e+lm1ab9k8nwi7AAmyG5MRtS8UYRGZGLKNL0nyAt7cS1wjQtoZycRoJZepKeS0NoEAYuGoJ5IlyH8wr2nV9rsO7a3v0o0fRsKbdGhJCY4qqFwn2W2R7lprb2jqZ+z1nTXm9KC6vDoVZwGn2tXhcREshoXGfPxx9dOaoGcMYC7AHzl+x0cdwYFtnjSX3lnAGRGVbvDUkwvhyttfojoMZ37ldmy6LA0tNQgdelFdiGmPGqYjTCsB4fXc
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2026 11:02:59.4452 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e694cc2-1691-452e-ef3d-08df14ab3c64
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF00000209.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6945
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

From: Christian König <ckoenig.leichtzumerken@gmail.com>

Use scoped_guard/scoped_cond_guard instead.

Saving and restoring the GFP flags is not necessary in those use case.

Signed-off-by: Christian König <christian.koenig@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c        | 27 +++++++++----------
 .../gpu/drm/amd/amdgpu/amdgpu_vm_internal.h   |  9 -------
 2 files changed, 12 insertions(+), 24 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index 77437436292c..0930b3fdade7 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -616,9 +616,8 @@ int amdgpu_vm_validate(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 	 * As soon as all page tables are in place we can start updating them
 	 * again.
 	 */
-	amdgpu_vm_eviction_lock(vm);
-	vm->evicting = false;
-	amdgpu_vm_eviction_unlock(vm);
+	scoped_guard(mutex, &vm->eviction_lock)
+		vm->evicting = false;
 
 	list_for_each_entry_safe(bo_base, tmp, &vm->always_valid.evicted,
 				 vm_status) {
@@ -678,9 +677,8 @@ bool amdgpu_vm_ready(struct amdgpu_vm *vm)
 
 	amdgpu_vm_assert_locked(vm);
 
-	amdgpu_vm_eviction_lock(vm);
-	ret = !vm->evicting;
-	amdgpu_vm_eviction_unlock(vm);
+	scoped_guard(mutex, &vm->eviction_lock)
+		ret = !vm->evicting;
 
 	ret &= list_empty(&vm->kernel.evicted);
 
@@ -2340,6 +2338,7 @@ void amdgpu_vm_bo_del(struct amdgpu_device *adev,
 bool amdgpu_vm_evictable(struct amdgpu_bo *bo)
 {
 	struct amdgpu_vm_bo_base *bo_base = bo->vm_bo;
+	struct amdgpu_vm *vm;
 
 	/* Page tables of a destroyed VM can go away immediately */
 	if (!bo_base || !bo_base->vm)
@@ -2350,17 +2349,15 @@ bool amdgpu_vm_evictable(struct amdgpu_bo *bo)
 		return false;
 
 	/* Try to block ongoing updates */
-	if (!amdgpu_vm_eviction_trylock(bo_base->vm))
-		return false;
+	vm = bo_base->vm;
+	scoped_cond_guard(mutex_try, return false, &vm->eviction_lock) {
 
-	/* Don't evict VM page tables while they are updated */
-	if (!dma_fence_is_signaled(bo_base->vm->last_unlocked)) {
-		amdgpu_vm_eviction_unlock(bo_base->vm);
-		return false;
-	}
+		/* Don't evict VM page tables while they are updated */
+		if (!dma_fence_is_signaled(vm->last_unlocked))
+			return false;
 
-	bo_base->vm->evicting = true;
-	amdgpu_vm_eviction_unlock(bo_base->vm);
+		vm->evicting = true;
+	}
 	return true;
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_internal.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_internal.h
index 1011f49f0478..7f6442d0b647 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_internal.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_internal.h
@@ -141,15 +141,6 @@ static inline void amdgpu_vm_eviction_lock(struct amdgpu_vm *vm)
 	vm->saved_flags = memalloc_noreclaim_save();
 }
 
-static inline bool amdgpu_vm_eviction_trylock(struct amdgpu_vm *vm)
-{
-	if (mutex_trylock(&vm->eviction_lock)) {
-		vm->saved_flags = memalloc_noreclaim_save();
-		return true;
-	}
-	return false;
-}
-
 static inline void amdgpu_vm_eviction_unlock(struct amdgpu_vm *vm)
 {
 	memalloc_noreclaim_restore(vm->saved_flags);
-- 
2.53.0

