Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DCB91061B2B
	for <amd-gfx@archiver.kernel.org>; Tue, 31 Mar 2026 02:59:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D364910E83E;
	Tue, 31 Mar 2026 02:59:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ZTXnyEvc";
	dkim-atps=neutral
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011042.outbound.protection.outlook.com [40.107.208.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3197E10E83E
 for <amd-gfx@lists.freedesktop.org>; Tue, 31 Mar 2026 02:59:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qY1ng1WD9GSwDpVZHbLx7DDJdopZ6MXxazfBXN/Hnl2nQhR4qHoHQz7Suyzts3AecsrFjHjQXV8rmsFBmRoPUrJApOaXIo8qX8uGtFXvznzWq4fvFJeDVb+okoNt3QOKsgYp5MuU/mgdcXO1/C8cCsy/QlhoUU8TJCpRWUR80IbLL6+vPlD07xgxypc05du+ZjCQw5LBVGK45s+fDe/w+/Lz7RY2HaYvXn9KYmLzCv40DvdHDWYkQpQZxfBJh5aQh3LGz8zdd/rWb1yIdiVOV3oq+rhlGlWgxSWlcHTNUn04pVurKI/kasSWI+Fvvv+ueGeZrpcLYAlLlcqk3Tf/OQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6xpA8JB49xdiIJKH5BZiBqhPsaVaYYFjVZiQW2aMJ4s=;
 b=hfOWjYR7dra4n90mfmCdGUARhaIPYpvijjqW+JzCwxaFMf0BNURDGE6uYRYvOofzGNiTKQMmsQwVeZDciSnSzf4l5V9ZZxNxtLUK3tfi1VgIxEIU5onWO+4fBb4S12/k4RZl9FaQLoZPLlR/bO5QGK4HgVQJOTHHwLyYNSlT/G5o8yJYOqFGqvFBFVldjQW+aUKYJCuPmb5989Prfw8AArG1Q9rxA0bgRE1FOH0mLwxkkXbfSo8cO8mJLLePtQmrDc6nXO61VApVcHgHQsmDa2rcj0c09j38hhBHjLiIRAKETxg8kjPbyQNk/CzPyZhY1xNyKB+qoQOrpOatzmPpsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6xpA8JB49xdiIJKH5BZiBqhPsaVaYYFjVZiQW2aMJ4s=;
 b=ZTXnyEvcdxHcfB7vV4ZkFla8Ucxoq9oH1K3d63u95UhaAItFOvH73qgBLWBUhc6ZF0bXhYmE8gwPuqzwghKElz1lftBirCDs3qIBFhrb9Q3UMHOZoTCloO6aMjD8et4+Q6EOD8gB++NKwWl/Dts9g0z7qsj6m9QLkgoKItWOar8=
Received: from SN7PR04CA0208.namprd04.prod.outlook.com (2603:10b6:806:126::33)
 by DS0PR12MB7679.namprd12.prod.outlook.com (2603:10b6:8:134::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.15; Tue, 31 Mar
 2026 02:59:17 +0000
Received: from SA2PEPF00001506.namprd04.prod.outlook.com
 (2603:10b6:806:126:cafe::44) by SN7PR04CA0208.outlook.office365.com
 (2603:10b6:806:126::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9745.28 via Frontend Transport; Tue,
 31 Mar 2026 02:59:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SA2PEPF00001506.mail.protection.outlook.com (10.167.242.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9745.21 via Frontend Transport; Tue, 31 Mar 2026 02:59:16 +0000
Received: from prike-code-pc.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 30 Mar
 2026 21:59:14 -0500
From: Prike Liang <Prike.Liang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <Christian.Koenig@amd.com>, Prike Liang
 <Prike.Liang@amd.com>
Subject: [PATCH 2/2] drm/amdgpu: defer PASID free from dma_fence callback
Date: Tue, 31 Mar 2026 10:59:04 +0800
Message-ID: <20260331025904.3387764-2-Prike.Liang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260331025904.3387764-1-Prike.Liang@amd.com>
References: <20260331025904.3387764-1-Prike.Liang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00001506:EE_|DS0PR12MB7679:EE_
X-MS-Office365-Filtering-Correlation-Id: 8ed80d7c-02e7-4c44-7b4a-08de8ed17f2d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700016|1800799024|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info: cJqR/U8O9pwbFO+vEBBZV3FjX2b3dTmgA6crSwdJ4b6D7PxuU/xtFQqF5QzT3DNuYyyND4rYsTrDgEgV7/uq3KZieJkDxFSqJt63SkpcYIVeT3sZ+6U5eu0pmTlOda3Zc2hXrDMl4Gq5P7fDQ3B33Ia+CLbFDinpgrtmnF0SH4DPZryA0ysnsS0GjbMnOUjnDHr1nOK7ncQX8/+S8Vks9UJJTuQ6rwSiGZvDFa3bAu0YoV0E5YaH4KZj1zkLSgVaslBadRzQVAzXcac4EJN9/GhEp3JTfokDr6Hy/i7VxB0c+WoBBU3qk01RAVagB0iD5B3SF9/rbkFZ6JR14HhYXQkw/r4h+5FzM5KFGFPjwGo+2T4y9IHRuW6XRM0cHNDUWkc2HdWYy8dw3en5v1uGKkilQ6NA18qbRmfjxFbqZvhrOyVTRBcvBSNGvCKDbt5Txf0IP0gGmdhL3TL86gTUnBEuRyW6BW68X3FkBWiS7vmuaEM9JN+hgpsrx5ZSt9q4c1a/dC5XS2jl91BkTRZ5354xNswSqtCLHTSCSKGyqYwfwb5FVCYFfDYLkS/DP7XPseueS2Ahs5DTLBEoZXB0lGzm0V2halD7cJhwZtpx9gvOR0/tMBeRQKTc9xi1LYjbpZDqJDspWb3rYbEBajZNcvH+UbX2jZ4UhSMAC4pQN+c3qVmquHqIyguit2K9X0nd5UG7QLUWr6SBaB84hEmSg+t4KKLmcH4g3xyyNO3Qc/4ToXAITpdpPdERLNeQGZAebTUC117Cpy8dLL1Gu6ww2g==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700016)(1800799024)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: IJjGDwpQYoZJ5P3HhNq4eqxE1irIz8M8gr0xp09Of2xfkUat96K5kAdGQpEKyZpWs/keQHeBhcrXBfVhcDyN6yJ/h7c6uPQg8FKHxZizpDQxIMYuZA9T5/B3wdklV22sVA+K997MiQEXkEOIeiSv69SiNWTAhklt0+L5Nh2kzGyT2uzyvOZPuk1V9i2flQDANoa0Kw3jfWmjqzsBCZb00qwSX0d/RdrAISvyWtPjlDOmE64YLJYNvDh4RzVvl+PcmMjOFQbv3TomaWoVytxDmf9blwToQqYVqbL9EhXNDJnut7SbjQqNRb2Sjeqie6VVqwdHT8LkapvLgUumrdJpOhWzZwGOOekXqGoNPFGKfNZSVNJiWtJSgtHYZ5fHcPSCo1aLbrS/38HW87iy5lxyqzC+CL+TdOOflHQSQ5Qyzg8NMcu8qKlpeJAGtJa3LSRJ
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2026 02:59:16.5577 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ed80d7c-02e7-4c44-7b4a-08de8ed17f2d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00001506.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7679
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

amdgpu_pasid_free_delayed() registers a callback on the VM root BO's
BOOKKEEP singleton fence. That fence can include the TLB flush fence;
when amdgpu_tlb_fence_work() signals it, dma_fence_signal() holds the
fence spinlock and may run nested dma_fence_chain work under irq-safe
locks. However, amdgpu_pasid_free() takes xa_lock, which lockdep treats
as irq-unsafe relative to that chain. Invoking it from
the fence callback created a HARDIRQ-safe -> HARDIRQ-unsafe dependency
lockdep inversion as following if call the amdgpu_pasid_free() immediatly.

[ 4127.396125] WARNING: HARDIRQ-safe -> HARDIRQ-unsafe lock order detected
[ 4127.396400] 6.19.0-custom #16 Tainted: G     U     OE
[ 4127.396633] -----------------------------------------------------
[ 4127.396885] kworker/11:1/3530 [HC0[0]:SC0[0]:HE0:SE1] is trying to acquire:
[ 4127.397173] ffffffffc1a6ea78 (amdgpu_pasid_xa.xa_lock){+.+.}-{3:3}, at: xa_erase+0x17/0x40
[ 4127.397525]
               and this task is already holding:
[ 4127.397767] ffff8e639340cfb8 (&f->lock){....}-{3:3}, at: dma_fence_signal+0x2a/0x80
[ 4127.398095] which would create a new lock dependency:
[ 4127.398312]  (&f->lock){....}-{3:3} -> (amdgpu_pasid_xa.xa_lock){+.+.}-{3:3}
[ 4127.398619]
               but this new dependency connects a HARDIRQ-irq-safe lock:
[ 4127.398944]  (&chain->lock){-...}-{3:3}
[ 4127.398951]
               ... which became HARDIRQ-irq-safe at:
[ 4127.399369]   lock_acquire+0xc6/0x2c0
[ 4127.399531]   _raw_spin_lock_irqsave+0x54/0xa0
[ 4127.399720]   dma_fence_signal+0x2a/0x80
[ 4127.399889]   dma_fence_chain_irq_work+0x50/0x70
[ 4127.400085]   irq_work_single+0x49/0xa0
[ 4127.400253]   irq_work_run_list+0x30/0x50
[ 4127.400425]   irq_work_run+0x1c/0x40
[ 4127.400579]   __sysvec_irq_work+0x38/0x120
[ 4127.400759]   sysvec_irq_work+0x7e/0x90
[ 4127.400925]   asm_sysvec_irq_work+0x1f/0x30
[ 4127.401105]   _raw_spin_unlock_irqrestore+0x3b/0x60
[ 4127.401310]   dma_fence_signal+0x48/0x80
[ 4127.401479]   amdgpu_tlb_fence_work+0x8d/0x130 [amdgpu]
[ 4127.402127]   process_one_work+0x233/0x650
[ 4127.402312]   worker_thread+0x1b2/0x360
[ 4127.402477]   kthread+0x11c/0x260
[ 4127.402622]   ret_from_fork+0x29f/0x2f0
[ 4127.402790]   ret_from_fork_asm+0x1a/0x30
[ 4127.402963]
               to a HARDIRQ-irq-unsafe lock:
[ 4127.403193]  (amdgpu_pasid_xa.xa_lock){+.+.}-{3:3}
[ 4127.403200]
               ... which became HARDIRQ-irq-unsafe at:
[ 4127.403662] ...
[ 4127.403665]   lock_acquire+0xc6/0x2c0
[ 4127.403904]   _raw_spin_lock+0x39/0x80
[ 4127.404069]   amdgpu_pasid_alloc+0x7f/0x150 [amdgpu]
[ 4127.404681]   amdgpu_driver_open_kms+0x9b/0x3b0 [amdgpu]
[ 4127.405281]   drm_file_alloc+0x212/0x300 [drm]
[ 4127.405519]   drm_client_init+0x84/0x130 [drm]
[ 4127.405749]   amdgpu_amdkfd_drm_client_create+0x5f/0xa0 [amdgpu]
[ 4127.406449]   amdgpu_pci_probe+0x470/0x6a0 [amdgpu]
[ 4127.407040]   local_pci_probe+0x4f/0xb0
[ 4127.407209]   pci_device_probe+0xdb/0x230
[ 4127.407382]   really_probe+0xe5/0x3e0
[ 4127.407541]   __driver_probe_device+0x7e/0x170
[ 4127.407731]   driver_probe_device+0x23/0xa0
[ 4127.407910]   __driver_attach+0xef/0x210
[ 4127.408079]   bus_for_each_dev+0x83/0xd0
[ 4127.408249]   driver_attach+0x22/0x30
[ 4127.408407]   bus_add_driver+0x12d/0x250
[ 4127.408575]   driver_register+0x68/0x130
[ 4127.408745]   __pci_register_driver+0x81/0x90
[ 4127.408931]   0xffffffffc0bfd06b
[ 4127.409075]   do_one_initcall+0x61/0x390
[ 4127.409245]   do_init_module+0x6a/0x280
[ 4127.409411]   load_module+0x22c5/0x23a0
[ 4127.409576]   init_module_from_file+0xdf/0x100
[ 4127.409765]   idempotent_init_module+0x1a3/0x2b0
[ 4127.409962]   __x64_sys_finit_module+0x77/0xf0
[ 4127.410151]   x64_sys_call+0x190a/0x21b0
[ 4127.410324]   do_syscall_64+0x6f/0x760
[ 4127.410487]   entry_SYSCALL_64_after_hwframe+0x76/0x7e

Signed-off-by: Prike Liang <Prike.Liang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c | 29 +++++++++++++++++++++----
 1 file changed, 25 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c
index 7b0afeddbb05..bcbd4652780e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c
@@ -24,7 +24,7 @@
 
 #include <linux/xarray.h>
 #include <linux/dma-fence-array.h>
-
+#include <linux/workqueue.h>
 
 #include "amdgpu.h"
 #include "amdgpu_trace.h"
@@ -45,6 +45,8 @@ static u32 amdgpu_pasid_next;
 /* Helper to free pasid from a fence callback */
 struct amdgpu_pasid_cb {
 	struct dma_fence_cb cb;
+	struct work_struct work;
+	struct dma_fence *fence;
 	u32 pasid;
 };
 
@@ -89,15 +91,34 @@ void amdgpu_pasid_free(u32 pasid)
 	xa_erase(&amdgpu_pasid_xa, pasid);
 }
 
+static void amdgpu_pasid_free_work(struct work_struct *work)
+{
+	struct amdgpu_pasid_cb *cb = container_of(work, struct amdgpu_pasid_cb,
+						  work);
+	amdgpu_pasid_free(cb->pasid);
+	/* put the fence referenced by amdgpu_pasid_free_cb()*/
+	dma_fence_put(cb->fence);
+	/* put the fence referenced by amdgpu_pasid_free_delayed()*/
+	dma_fence_put(cb->fence);
+	kfree(cb);
+}
+
 static void amdgpu_pasid_free_cb(struct dma_fence *fence,
 				 struct dma_fence_cb *_cb)
 {
 	struct amdgpu_pasid_cb *cb =
 		container_of(_cb, struct amdgpu_pasid_cb, cb);
 
-	amdgpu_pasid_free(cb->pasid);
-	dma_fence_put(fence);
-	kfree(cb);
+	/*
+	 * dma_fence_signal() holds the signaled fence's lock and may run under
+	 * dma_fence_chain irq_work (irq-safe locks). xa_lock is
+	 * irq-unsafe; taking it here violates lock order and can deadlock.
+	 * Defer PASID free and fence refcount drops to process context.
+	 */
+	cb->fence = fence;
+	dma_fence_get(fence);
+	INIT_WORK(&cb->work, amdgpu_pasid_free_work);
+	queue_work(system_unbound_wq, &cb->work);
 }
 
 /**
-- 
2.34.1

