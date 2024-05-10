Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D05EC25B10
	for <amd-gfx@archiver.kernel.org>; Fri, 10 May 2024 08:12:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C748E10E6A8;
	Fri, 10 May 2024 08:12:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="L/4NwWK4";
	dkim-atps=neutral
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2044.outbound.protection.outlook.com [40.107.95.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BB51D10E6A8
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 May 2024 08:11:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mLUCockVqveSMaTggYmG+yU1f4/NoudyrPn4w45xcoY3y1NL2iFrwdk/h4X11YRL55Z/Qodk2fcBXNLnWi/pCw+/+gjUSFyxqHw8/aOp06z8rC5JX7BTLkXmyirhcHlTlXZgy3XR9Sf7pDrG3UZkgq5Rf9fAnn4zdF9fLn3XEpkLUzQ1GckPjO8W8VU18vygrP6hdb0YFEj6loscqtgV1eUhyxLFn8iuUGiynj9L3Vb4NV5Ctd0a4X6iEZ/4Nx6i7LJn4d3oGwusevvEeFkwBByJm1laumE9E/hya4Uo/fD4LoUo/x6tDNf27jPyH5FN94iRFGmPPnst2iwhcRD1CA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KV+w5gwp8BuBl+3wNKT7/JvoOWb0U//71hibBOiSjeQ=;
 b=Aiv+ZXN7EUKhYvx3HUI9j1+a57CPzEo/5+uKAuaWA7k9IWj2akYuGJ6mRiXjYDCDIY4khyuead8YZeJnIeqYxv9G7BUswy+KRKKttxv43uOSkJM9YPU1aZTGapC+rS22msz/b3rfNJqo+nkz0wvBbqu4lfX4PatkM1bFEJpnL1JhjJbDwMeoK5OozE6B4kYGnZKspSUR/suCuLRfC4rlSoEFgcymi4866dvZIXiTdgAXArowrKLJcq6/htxNqWITHKd6lvu/Q0kjF6e/sKWu6pABvNBnEXztDGULT72BQjsPsG/7SNKs3xwhEj4L94E3Kahp1iM9NW6S9myVjqYcAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KV+w5gwp8BuBl+3wNKT7/JvoOWb0U//71hibBOiSjeQ=;
 b=L/4NwWK4rDN8TSBDMruAfC4S2btGJBKQ2oHLCjuz+juRwNEbwKtNl8JDSAqeeaU/E1hN9uia6xTU+cuc24ZylfZe26KK+MXqqVOMI0OmmyrZPBVcfrPsmstO6XkIrrYo4PkRC7npNjMZsV8+Vrd4DE2Z4xT7BSOXyQenrur8A8E=
Received: from SN6PR04CA0077.namprd04.prod.outlook.com (2603:10b6:805:f2::18)
 by DS0PR12MB8443.namprd12.prod.outlook.com (2603:10b6:8:126::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.47; Fri, 10 May
 2024 08:11:57 +0000
Received: from SA2PEPF00003AE6.namprd02.prod.outlook.com
 (2603:10b6:805:f2:cafe::5d) by SN6PR04CA0077.outlook.office365.com
 (2603:10b6:805:f2::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.48 via Frontend
 Transport; Fri, 10 May 2024 08:11:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF00003AE6.mail.protection.outlook.com (10.167.248.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7544.18 via Frontend Transport; Fri, 10 May 2024 08:11:56 +0000
Received: from prike-code-pc.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Fri, 10 May
 2024 03:11:54 -0500
From: Prike Liang <Prike.Liang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <Christian.Koenig@amd.com>, Prike Liang
 <Prike.Liang@amd.com>
Subject: [PATCH] drm/amdgpu: Use the slab allocator to reduce job allocation
 fragmentation
Date: Fri, 10 May 2024 16:11:45 +0800
Message-ID: <20240510081145.4081645-1-Prike.Liang@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003AE6:EE_|DS0PR12MB8443:EE_
X-MS-Office365-Filtering-Correlation-Id: cb0f2fae-f169-4257-fb02-08dc70c8dc16
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|1800799015|376005|82310400017|36860700004; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?/iSgeWNFgQ4ue5iTGS7AihttD6/YvVWR8B/1rth3vL8y90J8J8XatmaO9LYX?=
 =?us-ascii?Q?hTvKoiPPVeAWhjjBYlXVAiUU8RL6XErFHb2bTt6OeiLhVIZhO8HX5Pg0uISV?=
 =?us-ascii?Q?KJdEa/zuId5U5LmGFzTcmCOIiX27KL/83pAFHZa00TewFQBijY8L4xwQoiyF?=
 =?us-ascii?Q?ny6/KM5SIVSvFm29AiOuW3mpKfeem5I70PzOFvMc6GmyOHw0uZ3BxDS10OYh?=
 =?us-ascii?Q?u8or3yqsWOR9gG6G8HlDk0EmyRAWY6cLe9Uev+KoVgYawKx8i0XbsnHLfJhr?=
 =?us-ascii?Q?WfXY725+cq4i84lcV5fWKeay7wFSDWnH/Hhvyy6eJ9AYKTaYPVJbfgz6zSkV?=
 =?us-ascii?Q?Uf8zt6Y8+xZYk2C98TN3zA+Zn9tmYKu6dVlle0MEOjS2abdWmGh+bXSm07uv?=
 =?us-ascii?Q?MP8wCc8JUaZRQoHUrKYWufUIvyPeuIIGsGR373K2zcuLYR6F2WlQ/AIjNYAU?=
 =?us-ascii?Q?7wIdc9A6FYsP8L1qvrU3awnnYnrRp6vB8QMv8BENh/zYtMVUGPK2zIpysh3a?=
 =?us-ascii?Q?JNClun+jtdryr+/uY9zfpOf4iYbQ0qxUT5kE28orZpWWJ4TDB7xOUS/5//Xq?=
 =?us-ascii?Q?QBVBYhODwIxTZNin9C3n++aXCkAexaFqZL0rdsXcVWEuyvtx52NAsZ4jGMy/?=
 =?us-ascii?Q?k3rb/6jYaRoV6Iono5Shv34wFsKRuJiuru2tIgaelUwYF4LKOzKFmvCtxsPd?=
 =?us-ascii?Q?Kn+7SefcXFsI9e6PL6pwZStrbGjBdy+pxmj6BPl3/dVr1yZ8pde7cBQa+aHw?=
 =?us-ascii?Q?Nueoq+FMykCg/5TraGHdkVIYVdhOZE+hd/swSys789LwW82Y4Bh/ISNsfTWD?=
 =?us-ascii?Q?m1tIzzBxjt25TOFt1ccvrhwLfxgKQrDxA4AxAgTnBccFdTRYW5pwwiSA9vAh?=
 =?us-ascii?Q?o/GPbXMmFJunSuKZWrXCzilFNBL7oxyHa/Gw8ex8lRPEwjp2ybQrkYp13Jz4?=
 =?us-ascii?Q?EzCHW3gBW5wr6fvjeiqmsbeQbQV9Ej2rSjDPcBoyW3PPPFYXhKeNBOaJkhA1?=
 =?us-ascii?Q?/SilQVCsuTcLBcbZXSJzCrYmRJymPsMSSH2yBuUqrzUcUnXdBZa1anp83BlU?=
 =?us-ascii?Q?tJwLwmso8/3xJs5wIBZ3EOsdPGzpuLooYOpu6NCzN2BkjWXfj3TtdYMncL0q?=
 =?us-ascii?Q?CotwA43b/SlM+wDLdQa2JJGm3KEx08Z0jNs/2Q0a+/h9+No52FKRvT/R/sW0?=
 =?us-ascii?Q?Mfq8vRoBvdIdFGZ6FajGvFHuKkMWWNm41tMlUE4k2N5qDlzH3RZdfsXilsMO?=
 =?us-ascii?Q?ULIcx3naGCWi3KSEh4cDYHBfWuxipnHlCjs3/j2pac0Zmoq2rzFTQyKXpAcF?=
 =?us-ascii?Q?fJaZ0nVpKEyIec9qDX3mwSuaAyWI/kQlXlfC/HJFVEL7UKPPhAu3X7zQYygO?=
 =?us-ascii?Q?pKYEnwpNb30fGYN5nA8AaL1x5W46?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(1800799015)(376005)(82310400017)(36860700004); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2024 08:11:56.7406 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cb0f2fae-f169-4257-fb02-08dc70c8dc16
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00003AE6.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8443
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

Using kzalloc() results in about 50% memory fragmentation, therefore
use the slab allocator to reproduce memory fragmentation.

Signed-off-by: Prike Liang <Prike.Liang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c |  1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_job.c | 26 ++++++++++++++++++++-----
 drivers/gpu/drm/amd/amdgpu/amdgpu_job.h |  1 +
 3 files changed, 23 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index ea14f1c8f430..3de1b42291b6 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -3040,6 +3040,7 @@ static void __exit amdgpu_exit(void)
 	amdgpu_fence_slab_fini();
 	mmu_notifier_synchronize();
 	amdgpu_xcp_drv_release();
+	amdgpue_job_slab_fini();
 }
 
 module_init(amdgpu_init);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
index e4742b65032d..8327bf017a0e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
@@ -31,6 +31,8 @@
 #include "amdgpu_trace.h"
 #include "amdgpu_reset.h"
 
+static struct kmem_cache *amdgpu_job_slab;
+
 static enum drm_gpu_sched_stat amdgpu_job_timedout(struct drm_sched_job *s_job)
 {
 	struct amdgpu_ring *ring = to_amdgpu_ring(s_job->sched);
@@ -101,10 +103,19 @@ int amdgpu_job_alloc(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 	if (num_ibs == 0)
 		return -EINVAL;
 
-	*job = kzalloc(struct_size(*job, ibs, num_ibs), GFP_KERNEL);
-	if (!*job)
+	amdgpu_job_slab = kmem_cache_create("amdgpu_job",
+				struct_size(*job, ibs, num_ibs), 0,
+				SLAB_HWCACHE_ALIGN, NULL);
+	if (!amdgpu_job_slab) {
+		DRM_ERROR("create amdgpu_job cache failed\n");
 		return -ENOMEM;
+	}
 
+	*job = kmem_cache_zalloc(amdgpu_job_slab, GFP_KERNEL);
+	if (!*job) {
+		kmem_cache_destroy(amdgpu_job_slab);
+		return -ENOMEM;
+	}
 	/*
 	 * Initialize the scheduler to at least some ring so that we always
 	 * have a pointer to adev.
@@ -138,7 +149,7 @@ int amdgpu_job_alloc_with_ib(struct amdgpu_device *adev,
 	if (r) {
 		if (entity)
 			drm_sched_job_cleanup(&(*job)->base);
-		kfree(*job);
+		kmem_cache_free(amdgpu_job_slab, job);
 	}
 
 	return r;
@@ -179,6 +190,11 @@ void amdgpu_job_free_resources(struct amdgpu_job *job)
 		amdgpu_ib_free(ring->adev, &job->ibs[i], f);
 }
 
+void amdgpue_job_slab_fini(void)
+{
+	kmem_cache_destroy(amdgpu_job_slab);
+}
+
 static void amdgpu_job_free_cb(struct drm_sched_job *s_job)
 {
 	struct amdgpu_job *job = to_amdgpu_job(s_job);
@@ -189,7 +205,7 @@ static void amdgpu_job_free_cb(struct drm_sched_job *s_job)
 
 	/* only put the hw fence if has embedded fence */
 	if (!job->hw_fence.ops)
-		kfree(job);
+		kmem_cache_free(amdgpu_job_slab, job);
 	else
 		dma_fence_put(&job->hw_fence);
 }
@@ -221,7 +237,7 @@ void amdgpu_job_free(struct amdgpu_job *job)
 		dma_fence_put(job->gang_submit);
 
 	if (!job->hw_fence.ops)
-		kfree(job);
+		kmem_cache_free(amdgpu_job_slab, job);
 	else
 		dma_fence_put(&job->hw_fence);
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h
index a963a25ddd62..4491d5f9c74d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h
@@ -103,5 +103,6 @@ int amdgpu_job_submit_direct(struct amdgpu_job *job, struct amdgpu_ring *ring,
 			     struct dma_fence **fence);
 
 void amdgpu_job_stop_all_jobs_on_sched(struct drm_gpu_scheduler *sched);
+void amdgpue_job_slab_fini(void);
 
 #endif
-- 
2.34.1

