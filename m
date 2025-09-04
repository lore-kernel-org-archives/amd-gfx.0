Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB110CA1002
	for <amd-gfx@archiver.kernel.org>; Thu,  4 Sep 2025 14:46:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5D8F010EA6D;
	Thu,  4 Sep 2025 14:46:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="z1EDiEfK";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2047.outbound.protection.outlook.com [40.107.94.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 88B2910EA5F
 for <amd-gfx@lists.freedesktop.org>; Thu,  4 Sep 2025 14:46:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LEx1YP9WxjTn1DrLinWR0oUA7oyPvrC0ut5tqYke0HlH0YPB+mHvnQMGLPUqVxuCLitwoklLQpxCAjKtPXU5R0l0Alyj15xQNyXsvpr5GUtmurl1zwpsp8NYXFvRRXWLJ6gXvn+7/RUmSEyk+uMAZMflpgYWsitxHMBPHxyAXQENFp5+5Hvcg9dy9YEIX78ni4+mPtMw/svtOdb9ZnVB3Ho7KP2SUyL9Gi1YIIida0B/yK+hnBBMFw5OgB0atm8AV6GrlDUWdqQssTqgX9ZT0o8BcykJAGaVNzrie2Jiqo9m3JtiuFuF5wg8E4RLVbk7KA3i2mkZ54tuTnx/e/CVbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yTjmH1u7MMo4QfiuVKjpY2s4gB1PJGUj4g7rqe/9M60=;
 b=bsRBrqCZI/DnNKadwb4BGDwJWxL5ev5ZI6DFHiBxlxCL9+aQsDvrj80nGhsJROyGAYb+4n7eBx5JR9oMKQNFciithgPeVa4u3evTV+dcbj33MSvkfZbnSymk6vmUa/WAt5vt2BWVcqWOB2+LKTzy/HeAIINhOk7kXrVd/uZNu+bRRXXB+5y76Sbu0oreAA6Ym0o1zGJm/AEYh60FMKcppBb0U3MZPss17JKcSkFxP60zWYOw7TEpK3+yprjDYWG2g2PdTXofN8mHAjB2TSZVM/p4FB7DFbULzinqRRBAXI+CA3dGcyd6EtZNXs8ZKZYH3yar6OBXBza3iScsmI/WdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yTjmH1u7MMo4QfiuVKjpY2s4gB1PJGUj4g7rqe/9M60=;
 b=z1EDiEfKlOEW9gfHFKIa8m3K8CoOlVsqXbBXNtHIh4LfyV3uGvq5naKeS09gag3y73sWnqP3qAw4UCoL8elWK+Ne98VCrFAuT3kTNzqd9ujs+xnyk0IHtxBM9ejRirPjGIJ26yGeLMaEYRBICsOFTZZUS+6FNdv85KTl70yzkSk=
Received: from SA9PR13CA0162.namprd13.prod.outlook.com (2603:10b6:806:28::17)
 by DS4PR12MB9684.namprd12.prod.outlook.com (2603:10b6:8:281::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.17; Thu, 4 Sep
 2025 14:46:01 +0000
Received: from SN1PEPF0002636A.namprd02.prod.outlook.com
 (2603:10b6:806:28:cafe::87) by SA9PR13CA0162.outlook.office365.com
 (2603:10b6:806:28::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9094.17 via Frontend Transport; Thu,
 4 Sep 2025 14:46:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SN1PEPF0002636A.mail.protection.outlook.com (10.167.241.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9094.14 via Frontend Transport; Thu, 4 Sep 2025 14:46:00 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 4 Sep
 2025 09:46:00 -0500
Received: from tr4.amd.com (10.180.168.240) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.1748.10; Thu, 4 Sep
 2025 07:45:59 -0700
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 1/2] drm/amdgpu: set an error on all fences from a bad context
Date: Thu, 4 Sep 2025 10:45:45 -0400
Message-ID: <20250904144546.59539-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To satlexmb09.amd.com
 (10.181.42.218)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002636A:EE_|DS4PR12MB9684:EE_
X-MS-Office365-Filtering-Correlation-Id: e3f8bdf7-d6d4-4448-a441-08ddebc1c3fd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?dEBXBVF2mXR/zxlzgVm0JDkAH28efmmG+pBtcfEBjYDHlOd9WWoQCw1D3HLv?=
 =?us-ascii?Q?GOysN58Ay98Cryo2Ci4fAa2UecCsTm5VXH/z2L+goDZQVRXAYsb1EkucDsIy?=
 =?us-ascii?Q?tq4bsfkCPfZ39Dpx5OTnbf0OHFsInFFum7NUM0KOdNm+H/BLMMXyWzqoEQIW?=
 =?us-ascii?Q?lSWUDZ9ahtUjfklY6STVG0x5MZTv+zSyx8yIyOE4iq/plEfCkjW7HZIXYMyG?=
 =?us-ascii?Q?A/zWjiaxEGOFFTUucbA0mX+qbh6lAMg7OAXWmwBIOaSjsrD8PCtRCqFoYDvb?=
 =?us-ascii?Q?crA3SyLcjbTEUT3xIR5PmChiaqwJPE86DAslcZbgCPiZfGzpish+kEzRvrJU?=
 =?us-ascii?Q?XPL1PgeBSGJ7+y2chI/9OL8iacBdKAgBYLSj8Z5Y/PPYis3ETAnlpZZTELQf?=
 =?us-ascii?Q?cut9KdtHC2WyfdcLJ28jTUJGItuFHDFPFhXhfzES7kC2IMjgQGZjoOiB1pJB?=
 =?us-ascii?Q?/cBsrf53W1enysVHLrfvxvJxZ63xxXonTgir7xBMmGxceu3xtZBxSlJdiLN6?=
 =?us-ascii?Q?eLhM3G1rr+ilvdDJCrExMrV7+oZbkIrDBY4bfImoH7B+Kks5ZzhIvO01wLw7?=
 =?us-ascii?Q?+fxaLfwd0glhb2YEHyGONxw7P/Or7F6ZgV11GldaMeZXoomcwksdNRpZYhfC?=
 =?us-ascii?Q?3pLZfe1soT0vWBYkDH2hgSzIxXM5l9Lth5PFzkGG0hMFLPeUN4xBIED3J+p1?=
 =?us-ascii?Q?Qc4PBQF69Kbre65j4yckE5+zmdNgHVZjSei3N56clailTyD44lJ5yHp1NGPO?=
 =?us-ascii?Q?3kyDigI/ijsVuR7o0FuZIQ0MnjhwjuxbT+EMUdWXWeNRQ0NtZl4BqWUNVHcj?=
 =?us-ascii?Q?HTo2bIqyj+RaX/VxJWCKZSz3n6ZhUMwl6N3D2cehmJshk2FlIJIxhz6o5HqN?=
 =?us-ascii?Q?1OKAVh6pQG7uxdRHHe8AQWi0ZIRs9QRq0n3KCGrCwA7kUn9YDh+XuGTw5xXV?=
 =?us-ascii?Q?0nDIQY47hKB/EKVCc3/T8WhDPmYFiDSSqChhotcX9bPCXuPIVkQ2E9uJ+f3P?=
 =?us-ascii?Q?g8/gd7z4tlqD2xmmA84pGy81hurBcOmj8Gi73WpkI1oqN3uCadBwuawPuPLV?=
 =?us-ascii?Q?p9zW34ehxQ3IdZJxbatzNdVJP2R4QzLKx/LvCPfzjJQBadauWT6l4IXkFM2b?=
 =?us-ascii?Q?3YqMfgqszw7dE/EQUE0BFA8h/+jLB0HBeGjeB+uORPGC5034MxECpM+dOBWp?=
 =?us-ascii?Q?f6jcd6pDk7b5o9/y6jwAPz/psXdJQPFEMgZjR60NF/+/hS/+2fgW02n0v9Uy?=
 =?us-ascii?Q?1S1X0CTIpV4UN5SWKF+NrwKHahi0w2MmRidQAEbRl7WYGMu0pz9yy0+WeiyL?=
 =?us-ascii?Q?xhGwsxnNLoxtutBgYFaR0XTJyCkXSzRRMp50Xpcaw4axwelCvIN69ujIyy0b?=
 =?us-ascii?Q?SuXNXKs7rdViMaS3GDjIwRZ89TKG1lR0h44cGKI+oc3SSIjlPXYPsWbqFN3p?=
 =?us-ascii?Q?lwO4uuLUUX04CQuhqHl2YZjWv9qgXrgldmbAW8oWUe0v0MTI11XcLJARnDp8?=
 =?us-ascii?Q?C0A2J9zakkr/CLJEWCLuADfQQpN559T38WlA?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2025 14:46:00.5253 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e3f8bdf7-d6d4-4448-a441-08ddebc1c3fd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002636A.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR12MB9684
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

When we backup ring contents to reemit after a queue reset,
we don't backup ring contents from the bad context.  When
we signal the fences, we should set an error on those
fences as well.

v2: misc cleanups

Fixes: 77cc0da39c7c ("drm/amdgpu: track ring state associated with a fence")
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c | 28 +++++++++++++++++++----
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c  |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h  |  2 +-
 3 files changed, 26 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
index fd8cca241da62..1a2710f453551 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
@@ -758,11 +758,31 @@ void amdgpu_fence_driver_force_completion(struct amdgpu_ring *ring)
  * @fence: fence of the ring to signal
  *
  */
-void amdgpu_fence_driver_guilty_force_completion(struct amdgpu_fence *fence)
+void amdgpu_fence_driver_guilty_force_completion(struct amdgpu_fence *af)
 {
-	dma_fence_set_error(&fence->base, -ETIME);
-	amdgpu_fence_write(fence->ring, fence->seq);
-	amdgpu_fence_process(fence->ring);
+	struct dma_fence *unprocessed;
+	struct dma_fence __rcu **ptr;
+	struct amdgpu_fence *fence;
+	struct amdgpu_ring *ring = af->ring;
+	u64 i, seqno;
+
+	seqno = amdgpu_fence_read(ring);
+
+	for (i = seqno + 1; i <= ring->fence_drv.sync_seq; ++i) {
+		ptr = &ring->fence_drv.fences[i & ring->fence_drv.num_fences_mask];
+		rcu_read_lock();
+		unprocessed = rcu_dereference(*ptr);
+
+		if (unprocessed && !dma_fence_is_signaled(unprocessed)) {
+			fence = container_of(unprocessed, struct amdgpu_fence, base);
+
+			if (fence->context == af->context)
+				dma_fence_set_error(&fence->base, -ETIME);
+		}
+		rcu_read_unlock();
+	}
+	amdgpu_fence_write(ring, af->seq);
+	amdgpu_fence_process(ring);
 }
 
 void amdgpu_fence_save_wptr(struct dma_fence *fence)
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
index 6379bb25bf5ce..77ea1ef46236d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
@@ -812,7 +812,7 @@ int amdgpu_ring_reset_helper_end(struct amdgpu_ring *ring,
 	if (r)
 		return r;
 
-	/* signal the fence of the bad job */
+	/* signal the fences of the bad job */
 	if (guilty_fence)
 		amdgpu_fence_driver_guilty_force_completion(guilty_fence);
 	/* Re-emit the non-guilty commands */
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
index 7670f5d82b9e4..0704fd9b85fdb 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
@@ -155,7 +155,7 @@ extern const struct drm_sched_backend_ops amdgpu_sched_ops;
 void amdgpu_fence_driver_clear_job_fences(struct amdgpu_ring *ring);
 void amdgpu_fence_driver_set_error(struct amdgpu_ring *ring, int error);
 void amdgpu_fence_driver_force_completion(struct amdgpu_ring *ring);
-void amdgpu_fence_driver_guilty_force_completion(struct amdgpu_fence *fence);
+void amdgpu_fence_driver_guilty_force_completion(struct amdgpu_fence *af);
 void amdgpu_fence_save_wptr(struct dma_fence *fence);
 
 int amdgpu_fence_driver_init_ring(struct amdgpu_ring *ring);
-- 
2.51.0

