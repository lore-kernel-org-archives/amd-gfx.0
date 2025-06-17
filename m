Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 548E3C7115E
	for <amd-gfx@archiver.kernel.org>; Tue, 17 Jun 2025 03:08:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DE78810E482;
	Tue, 17 Jun 2025 03:08:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="VxKL4jSA";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2077.outbound.protection.outlook.com [40.107.94.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C1E8010E47C
 for <amd-gfx@lists.freedesktop.org>; Tue, 17 Jun 2025 03:08:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gmafuDDiSz6BwqAlA8SLso/nYzhuGEIwBF/mwgEZLhWc2ARlDL/qm3d8tUwD1kJgxG1GatwlKVq8xy7vmssRat+ktVqzhlhin0LaWOs0mN4fV70BAm1uLjfu0txDfYfJL3XDloHa6+0to41rGIIsyQJfxowvWviqZha8RANl9kk2IlunGTVCIOsJDFZNPnOEYHJt/vjUlomlp2GHH6pJysJOZ70QNUG9vnjSA+MFibi97LjdBoHFTqqKs4ZFxO+7sWZEITJh+eieiHNa0pTKFgtNI/jluh+Xb0x7xb8kpqBk6EvfXQ8KoesxKhO5wiAcVfBH09xLz7wE9RsdORzO2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3vVF+s/ty21nfrdvMrffnc8iIbhSSkerMwQyh9PEBiA=;
 b=zOBeFbnL7dGeebmgr8iWrZzgvEtqKVF1xYMIzYfpRB8yckn1mKVaCb+r5HleJpO5SSI3tiLjz+eq2qH4fVaD3TUBfhm3Cb2up6cYEoJX1RsgLZnHtpnzvfAeo1YAGH6Ax5pbLK0PCaSe/byE9V3MmhaZZWRUHoABNOvG5VbjUAEDrg46BbikVzyBWxSa1Rd3O6xSLex59BsrOMQ1EktuI3EuhDz2TzwMXpFlKFa1tC8gvMDi9hwCTTUrXhnizHix7P7/dSpRF3Eo26qVhMLm7FJ3dx5rMNG2jRkKQMEzhhj7ogbJGxaFiqMmqyMfKRO/b4bStTA80Oa/KymjxfGAsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3vVF+s/ty21nfrdvMrffnc8iIbhSSkerMwQyh9PEBiA=;
 b=VxKL4jSAYGlIWOUfFpuNToQP1SW6Ts5/rn6mYQi2wAflZwi0r4EMtGSsXEIpUgGQa5KABI16bUTI769OJ84s94Vr7qd6N5+dGlZBZSWqUCwq/iQmrKQfrv8oWp7zMFA6xB62MHbv/cPbLlc38Qa7gYrATdUxvBm6F8rXPgN1VrI=
Received: from MW4PR03CA0011.namprd03.prod.outlook.com (2603:10b6:303:8f::16)
 by SN7PR12MB7450.namprd12.prod.outlook.com (2603:10b6:806:29a::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.29; Tue, 17 Jun
 2025 03:08:33 +0000
Received: from SJ1PEPF00002324.namprd03.prod.outlook.com
 (2603:10b6:303:8f:cafe::60) by MW4PR03CA0011.outlook.office365.com
 (2603:10b6:303:8f::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8792.35 via Frontend Transport; Tue,
 17 Jun 2025 03:08:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00002324.mail.protection.outlook.com (10.167.242.87) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8835.15 via Frontend Transport; Tue, 17 Jun 2025 03:08:33 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 16 Jun
 2025 22:08:30 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>,
 <sasundar@amd.com>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 03/36] drm/amdgpu: remove fence slab
Date: Mon, 16 Jun 2025 23:07:42 -0400
Message-ID: <20250617030815.5785-4-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250617030815.5785-1-alexander.deucher@amd.com>
References: <20250617030815.5785-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002324:EE_|SN7PR12MB7450:EE_
X-MS-Office365-Filtering-Correlation-Id: a211fa9c-577f-4f6f-30c2-08ddad4c3e83
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Ljqjj3VM4iNry24dkOvuFMUfG+M7y47Cnfsd85H6ra/HX207f/nv/vP/dW5N?=
 =?us-ascii?Q?HF9AB48ETGrfdoi5zqYyB7M2JXwe1pKSF83RKH7YHOcbf85IdM1Ew23nDNv6?=
 =?us-ascii?Q?en6nwypEHq/SsVBkfwAk7H+o7vijcQGIyq+9U22hVo5XuGeKzW91xUoRkZ6X?=
 =?us-ascii?Q?6j7qLIgXAsJtI8dBpKxmL6h0t606PB+TbAqKG8fH15JmveDt1gyatXaiyxmu?=
 =?us-ascii?Q?17qO3z8HQ2mbexqGNPpA/1o2AsZcptg89Lv1o0wGhYmpvl/8970rXHJ2/veT?=
 =?us-ascii?Q?uXiqvNh2t/+tiNW19sVBrKFlzzIdzuVQcOXUwTagk9FzcO8G2WvQXyywFv4p?=
 =?us-ascii?Q?moED1/3quX45FDqgX5nsXv0q04TeeTM/p8UkpAMeEBPeA9t9DY0zSY8bt8cw?=
 =?us-ascii?Q?MM+U8jn7AG8+jqgQFCr/c51iEkQ5FHLzGkdbt2pU1n9oFys+XbtbERGG5i4M?=
 =?us-ascii?Q?E5SkYfe1gQbjaZ3gNRL9SSpaSMNrfk3D0yXarNhkuG6aDEkeA7Cq/2xH4FmX?=
 =?us-ascii?Q?epE9rGBnmLPF+vuMiAXr50FqA7PJTSqB+2WJsRHNuvTADPeWoXZpxjbscfVM?=
 =?us-ascii?Q?yZyjCVyAOv2Wn+/FG2+XJYcYCCc39zZbkZEM2+ht5Uv5Y0sCInZ5wHdn2ZcS?=
 =?us-ascii?Q?/6FkGPp2MAJluNs5R9Nk4/KUWIEgVyKemI3uqH9RQsXeogsziVCGR7dnu0kM?=
 =?us-ascii?Q?NnfX9Nc2dpZsZkoQpFaRLhtjEofif6fVlqLVTz5Oh6iO6iYCq0K3CAu/dHDQ?=
 =?us-ascii?Q?AGa+lILHUKEVxTU4EotZBZHxjb6tGsMNELQVA65aFOS05YuSTf2kV+oeCtjl?=
 =?us-ascii?Q?vtSAvDK2EeVhMQUUD8iUuygTJplrBtmYybRllF3TP7UTimFdifrrcH1P0xKJ?=
 =?us-ascii?Q?HWXJ+AC3P4SmA8IhoZ//54liUrXK9jUUL/5qKdSmi0yGDaoZnbevcHPLYkUb?=
 =?us-ascii?Q?dHiPeKi84I9AKxbMqJONpRdBQ+s5IST06uDQ1worrKSFVeFXmID3jNiBFYWi?=
 =?us-ascii?Q?QxIDbYqEnm6Sw9DWFbm+NoVnNvZnJlSJ4ag+UcDBioFvywqVhPmBaBbr8OOT?=
 =?us-ascii?Q?S3RXZm3+d0Vg0JV13EK38eXjiVi4tklNyZ9MuET1iht2KDr1wH/5k5n76CHB?=
 =?us-ascii?Q?dXB1YC/mmNEE99teJGWIVcF+hK0ca4QWW0OAwVCOKYTgek3r7QLtmpkWheDu?=
 =?us-ascii?Q?stNv/pJ0PSeZY/Bw6IXYC12Z3qYxISaWAmZmshg9kfydcrv67zfxvaxfc8Zx?=
 =?us-ascii?Q?bl1HhidTmyUMeHC/hJJEyw2vDWAwUT4L+WT9KkZ3z0pfV7JN1iQWNJcak9mz?=
 =?us-ascii?Q?G+x+HtZfb8/dvcKA+t9vRAhm+PQ5Pyj7DX10yT+oRuca/CJIhIm5d0N8FM4g?=
 =?us-ascii?Q?uNYUkDMOGvISEvs1yN7wRnJoMQo0V/kAByr2h8w6TVP3MHM0wDz9+Yu2CSj0?=
 =?us-ascii?Q?xMeiYFHql/NXpnvzRAWQ2ubXFI0JRTP2yLA7dPcdtDor6ZiiTAwl6JCy+uvY?=
 =?us-ascii?Q?j4c0RbjtxyKjtQd8rWfRNxPoNltR5p+4iDp1?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2025 03:08:33.3029 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a211fa9c-577f-4f6f-30c2-08ddad4c3e83
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00002324.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7450
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

Just use kmalloc for the fences in the rare case we need
an independent fence.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h       |  3 ---
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c   |  5 -----
 drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c | 21 +++------------------
 3 files changed, 3 insertions(+), 26 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index 5e2f086d2c99e..534d999b1433d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -470,9 +470,6 @@ struct amdgpu_sa_manager {
 	void				*cpu_ptr;
 };
 
-int amdgpu_fence_slab_init(void);
-void amdgpu_fence_slab_fini(void);
-
 /*
  * IRQS.
  */
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index 7f8fa69300bf4..d645fa9bdff3b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -3113,10 +3113,6 @@ static int __init amdgpu_init(void)
 	if (r)
 		goto error_sync;
 
-	r = amdgpu_fence_slab_init();
-	if (r)
-		goto error_fence;
-
 	r = amdgpu_userq_fence_slab_init();
 	if (r)
 		goto error_fence;
@@ -3151,7 +3147,6 @@ static void __exit amdgpu_exit(void)
 	amdgpu_unregister_atpx_handler();
 	amdgpu_acpi_release();
 	amdgpu_sync_fini();
-	amdgpu_fence_slab_fini();
 	amdgpu_userq_fence_slab_fini();
 	mmu_notifier_synchronize();
 	amdgpu_xcp_drv_release();
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
index e88848c14491a..5555f3ae08c60 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
@@ -41,21 +41,6 @@
 #include "amdgpu_trace.h"
 #include "amdgpu_reset.h"
 
-static struct kmem_cache *amdgpu_fence_slab;
-
-int amdgpu_fence_slab_init(void)
-{
-	amdgpu_fence_slab = KMEM_CACHE(amdgpu_fence, SLAB_HWCACHE_ALIGN);
-	if (!amdgpu_fence_slab)
-		return -ENOMEM;
-	return 0;
-}
-
-void amdgpu_fence_slab_fini(void)
-{
-	rcu_barrier();
-	kmem_cache_destroy(amdgpu_fence_slab);
-}
 /*
  * Cast helper
  */
@@ -132,8 +117,8 @@ int amdgpu_fence_emit(struct amdgpu_ring *ring, struct dma_fence **f,
 
 	if (!af) {
 		/* create a separate hw fence */
-		am_fence = kmem_cache_alloc(amdgpu_fence_slab, GFP_ATOMIC);
-		if (am_fence == NULL)
+		am_fence = kmalloc(sizeof(*am_fence), GFP_KERNEL);
+		if (!am_fence)
 			return -ENOMEM;
 	} else {
 		am_fence = af;
@@ -806,7 +791,7 @@ static void amdgpu_fence_free(struct rcu_head *rcu)
 	struct dma_fence *f = container_of(rcu, struct dma_fence, rcu);
 
 	/* free fence_slab if it's separated fence*/
-	kmem_cache_free(amdgpu_fence_slab, to_amdgpu_fence(f));
+	kfree(to_amdgpu_fence(f));
 }
 
 /**
-- 
2.49.0

