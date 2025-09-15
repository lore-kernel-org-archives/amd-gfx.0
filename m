Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34C96CAC597
	for <amd-gfx@archiver.kernel.org>; Mon, 15 Sep 2025 13:34:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C713B10E4BD;
	Mon, 15 Sep 2025 13:34:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="KqhGW2Hh";
	dkim-atps=neutral
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011011.outbound.protection.outlook.com [40.107.208.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0BE5110E4BE
 for <amd-gfx@lists.freedesktop.org>; Mon, 15 Sep 2025 13:34:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TvVbDVJsVS8sWFJZHwcfONn7p5aBQXcTwTTTY22lOia+uGwo0ZOQBcOgE2MzjRWhxgtfZefcWQoIJ7f53aMiiNgxPWJvpB+lnG1qdkqOr62wnWauwMxTfOJn+tgBwXOrF//iImR0m772plyW9OEUj0JdObyjo69uI3v/K5SajfXs2soxEglucxm7R95PO9MTRB4NLoJlttsxOnJwULM0sy3TbiL5Nrtv7P7MVRrnX4u3EqmtE/26pA5uwVWNaOWrr05ni4enDcmbQhZHU4XGRMIzmHjTapCoIxAIH9bBHwude3IfrVTuhPcsSr+8/az86sEuJnsMnoncErh43zYNdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PmrvVK6dhquAiEgysUIJ8Bpqf3qKboLJN+SoNDhhqnA=;
 b=NxVAw7ZkxXs4+uTI7xSesckJZD6wjrlb1dI22CzlNX6QJw3FDFdMbAdGOzznDJuDiu2myL92LM2SyZKwP55hqKNdy6WzOFgwILmPa0DgFkZccy84gLCRLpFygIBsJyQeJ+fY8e1SPOaVB34FE2+2rWrFXNTAzXluj1H/Mr3lnwvpULSWGnEeqocdRHqRmQ7GMkcDQrw+He2MKb0/4J1kR18VnB6Dfcaumg0aPSB5MhqkNVWcR8seGV0igtUtLatjGv9C5MhD89uH1wEBkJN1SD0ayy/DB5ytdNPMm4Cb644ItLUxRuys3J8DeCK+FOWZsxkPu2nRSGXzjLqDIc+xVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PmrvVK6dhquAiEgysUIJ8Bpqf3qKboLJN+SoNDhhqnA=;
 b=KqhGW2HhRPOsiAJFXMxq4VC5VQYQCcEXDPwyol0SYHUiHQOOGtKa/aPAnqMs+b3EVnBp9HvB2nFE7YEZ4Rt8qlJ0ZLqQ3/C3899VTYQ6Gke3MUHbwL0fYXr5HCPKRzYt5UaBTSQUW/VFibwqDHUK99S3h2H4HEYB0CuNLY7XH5U=
Received: from DM6PR07CA0062.namprd07.prod.outlook.com (2603:10b6:5:74::39) by
 LV3PR12MB9356.namprd12.prod.outlook.com (2603:10b6:408:20c::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.19; Mon, 15 Sep
 2025 13:34:12 +0000
Received: from CY4PEPF0000FCBE.namprd03.prod.outlook.com
 (2603:10b6:5:74:cafe::f2) by DM6PR07CA0062.outlook.office365.com
 (2603:10b6:5:74::39) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9115.21 via Frontend Transport; Mon,
 15 Sep 2025 13:34:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000FCBE.mail.protection.outlook.com (10.167.242.100) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9137.12 via Frontend Transport; Mon, 15 Sep 2025 13:34:11 +0000
Received: from tr4.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 15 Sep
 2025 06:34:10 -0700
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <christian.koenig@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 1/2] drm/amdgpu: set an error on all fences from a bad context
Date: Mon, 15 Sep 2025 09:33:55 -0400
Message-ID: <20250915133356.3547174-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCBE:EE_|LV3PR12MB9356:EE_
X-MS-Office365-Filtering-Correlation-Id: d96c3c21-bab5-4b08-f95b-08ddf45c8e5d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?h7pgSqorGZrqie+N/xISb4c5RQZKlo9iZXWSrZT/ELS6sTsnhEKIj2pDupvl?=
 =?us-ascii?Q?Ha+QSzFPt85Jzj6F+wD0XlwmGNwp0OteIhzo5n18caVxTopTXbXX2wZFwDZo?=
 =?us-ascii?Q?78P9kkggVg+s7jO25dg3ok3CWt6n5rw4jOYh8LPSGSgt3Mcnydwc+0DE55kk?=
 =?us-ascii?Q?L8XlwVy0LeKyE1hNlp9DmKcpjLDM8GJDAqvWuFbPyh4F+gREbCt4F9czdhiz?=
 =?us-ascii?Q?FruGYm7B2V/2N7NPjWKdJ3q5Cw7I8ZG1/fJ5Pk6caU7nVJNpF3mf8r+jOxLN?=
 =?us-ascii?Q?WZSJD8V1xyq1ZI1GPAH6O8jdXwbO97JJA33KimJuZX1bvG7dMXZOT8jt71n+?=
 =?us-ascii?Q?u8T0RbeLCAzIH519VxqoDoyt30UtAfQcc1zZ/LEOeBB+eKz/XathUz5laZpV?=
 =?us-ascii?Q?8BzeRAaOIJQR0S2bWPwM2JX7l+jhV3tm33I/J6KiDeIhigcJ4Wx24I6DSkde?=
 =?us-ascii?Q?+51u8DtI1yzHu7tavHdkGjajzaAOZ+gkc/3UZHPOUVOXbv8bsyLDQthBYqvA?=
 =?us-ascii?Q?Xt9dGp9macy/z1gSeegDcATHAAFGQbKBpSsum9U5T9jC5bEj7rlOs7+LbtXl?=
 =?us-ascii?Q?EbNeQjcLHhx4UbcWxqxhfmhEna8XPuQAy3uro/zvHOElaBk9uhC2jLwJjqD2?=
 =?us-ascii?Q?g+xVLbLa0y6zu9QeJn2XN80wRzQeCGtqyqMepJ/ojqKEKb9y2YcY2IkZrFMs?=
 =?us-ascii?Q?/fgezSEAKMuKw4y6gJcCxgXe/Vwc2fIXQ3ZF6WghwbvUXT5Dj1ccsBesUK1h?=
 =?us-ascii?Q?QcLE210QByZyUBQUT8wQwcFv06jt9mS1+05rANd6qoyT00Cp6YqzAD2EyUnV?=
 =?us-ascii?Q?5EItIZz7Nn0l0i3jhZje7rud4W/i4cpMIbuYSO1j3ZHjQB/As4pcETjrt2D7?=
 =?us-ascii?Q?qWjSfJCPPcUWF0jyMsAdKu0JWvbnmTdABLhcUS6rMnm8T7F2CddIhP2f7FY0?=
 =?us-ascii?Q?MKFJtmQZcY7dFmYsIzbY4xjTFPXpMm6N0apVyzMVaAyqds1QqY+kLA7o2Mo2?=
 =?us-ascii?Q?wytpbYDfQwZtXckV65YwVV6rf/qPvP9ibRZvQI+ebfwPeXK5eV9eSU0wUsLC?=
 =?us-ascii?Q?G8tnNN70MyB38sQbkfsa4gRvxWngVyvVwxTcGZvjMAu4P93o5ZpUpjJRvr4y?=
 =?us-ascii?Q?OB9vFRzzvp04iZi7pFoNtxfaIgRMXAfjcCGDN6d0BkCdfiKciBVtEztF9zGK?=
 =?us-ascii?Q?/oJ4ZsO0nTQPdgwiKty/WF43c6ygGAC4/VM6uQXP++13m8p5s1x6YcpYx9bI?=
 =?us-ascii?Q?m/eFRalFLEmH7HR4ZJgFVgx6mZYszx7KnzRtRABjwIUWKdvMvDLOqRW4yqUF?=
 =?us-ascii?Q?QSEYZ3UeArECkzE+MKs5QzJJ4+ou1h5612QfD301Ib3zhCEuowmimHfEARh5?=
 =?us-ascii?Q?H49eWJXD21RLmxIUSVYwGWAFO+8hjWzjG1Giwwj/NcvFi/SnM1UyHl1Ixsw/?=
 =?us-ascii?Q?1sKde6aYcpg6DIqQ+5JnqtMJ5OAJ0y18M799stV/Y9d8ZCNjjpwZDDtsZPe2?=
 =?us-ascii?Q?mXQFjI8H26AGg+MT6fKcuOIDyGxckBsUSeAA?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2025 13:34:11.8305 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d96c3c21-bab5-4b08-f95b-08ddf45c8e5d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000FCBE.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9356
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
v3: add locking for fence error, fix comment (Christian)

Fixes: 77cc0da39c7c ("drm/amdgpu: track ring state associated with a fence")
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c | 33 ++++++++++++++++++++---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c  |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h  |  2 +-
 3 files changed, 31 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
index fd8cca241da62..72f0f16924476 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
@@ -758,11 +758,36 @@ void amdgpu_fence_driver_force_completion(struct amdgpu_ring *ring)
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
+	unsigned long flags;
+	u64 i, seqno;
+
+	seqno = amdgpu_fence_read(ring);
+
+	spin_lock_irqsave(&ring->fence_drv.lock, flags);
+	for (i = seqno + 1; i <= ring->fence_drv.sync_seq; ++i) {
+		ptr = &ring->fence_drv.fences[i & ring->fence_drv.num_fences_mask];
+		rcu_read_lock();
+		unprocessed = rcu_dereference(*ptr);
+
+		if (unprocessed && !dma_fence_is_signaled(unprocessed)) {
+			fence = container_of(unprocessed, struct amdgpu_fence, base);
+
+			if (fence == af)
+				dma_fence_set_error(&fence->base, -ETIME);
+			else if (fence->context == af->context)
+				dma_fence_set_error(&fence->base, -ECANCELED);
+		}
+		rcu_read_unlock();
+	}
+	spin_unlock_irqrestore(&ring->fence_drv.lock, flags);
+	amdgpu_fence_write(ring, af->seq);
+	amdgpu_fence_process(ring);
 }
 
 void amdgpu_fence_save_wptr(struct dma_fence *fence)
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
index 6379bb25bf5ce..f6c9decedbd51 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
@@ -812,7 +812,7 @@ int amdgpu_ring_reset_helper_end(struct amdgpu_ring *ring,
 	if (r)
 		return r;
 
-	/* signal the fence of the bad job */
+	/* signal the guilty fence and set an error on all fences from the context */
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

