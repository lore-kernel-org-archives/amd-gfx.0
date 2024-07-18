Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87DE8C3DA7E
	for <amd-gfx@archiver.kernel.org>; Thu, 18 Jul 2024 14:08:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1409310E908;
	Thu, 18 Jul 2024 14:08:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="2ZBoEtQW";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2084.outbound.protection.outlook.com [40.107.223.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 36AA610E8DD
 for <amd-gfx@lists.freedesktop.org>; Thu, 18 Jul 2024 14:08:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kJejg/BcWu+HBcJtTPxOlEIQGJHAOyv6lkkCO9J0I8R/8pRhKO9afgARS8lX/J9u0B7lBM9H4KEKYIRh753kL4J27pgvfrT5ta88BSD2Ys6bEwmuO9vIZVf3aq1CqlKxROhUF3sbsyzIBzSP8ud9fnV8ebKhbk3kUgJrGiOvIJ1rLNXmCNG50c5QVlS4X4SnzFSaR6IHRTbkzmROPsH02oiVd71+NUQeWngpmR7uDZcw9HTrF7P2zScnMdyrr8vb3VhQi0+gj0F4ceU9E2YdWIb/sILCPL2GRVEKJBxvWyCPBJZKLyO4GsXHZ6gNnjfLtjpjbgiStXthEKu6DxT9XA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HiOR0eTAubmBPXLsn6aB5xZK9B/4snfkJE2kzwJASV0=;
 b=n8oXTu0QpvSO+b1i410vmQfPKrx58aVVQvufDkrYZIcQXphYDdIqXbWUZdQrGRae4A0IVSndVte8A/a0/41VncGKnWDovprpRma21RcJ+DSqVaHWgt27wE5itKHo2UTMsKq39qwsyRdGzMbe4knKrYHYzwlJ7VeLDZN7Q8CaVAb0Wmn7qmdd6g6uGedW8WXTUBP/yz0b3w47jpiikoKVwaP+Kq4UbXjgAcY1GBWrLNp0hwThD8AqxMeDSeaT2V5HqjHw00Z2yhE9K+08kxGSNXGq8imleE5Eb3XaWFDG5C8cpXXiI5JRz0ayfEgtPvwUdRcRGOLvdm3/xwp5HFs3iQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HiOR0eTAubmBPXLsn6aB5xZK9B/4snfkJE2kzwJASV0=;
 b=2ZBoEtQWGd2BCQmcswwcZh73Tlm1fBiIiVCXXKh6MSMxlHL38hpo/xnvdGFpVu27XTnnk9V7Anxf4ND15dNDznwMkUTomkut9nQRzkzbeJSEMn8Eq5l01mas78LJahGxFNsJR8VnJUyZXpElvOcQKz5EZACpgsEVGpYdzqNSRIU=
Received: from BLAPR03CA0046.namprd03.prod.outlook.com (2603:10b6:208:32d::21)
 by PH7PR12MB7871.namprd12.prod.outlook.com (2603:10b6:510:27d::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.24; Thu, 18 Jul
 2024 14:08:03 +0000
Received: from BL02EPF0001A106.namprd05.prod.outlook.com
 (2603:10b6:208:32d:cafe::e7) by BLAPR03CA0046.outlook.office365.com
 (2603:10b6:208:32d::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.29 via Frontend
 Transport; Thu, 18 Jul 2024 14:08:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0001A106.mail.protection.outlook.com (10.167.241.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7784.11 via Frontend Transport; Thu, 18 Jul 2024 14:08:03 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 18 Jul
 2024 09:07:58 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Jiadong Zhu <Jiadong.Zhu@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 15/34] drm/amdgpu/gfx10: remap queue after reset successfully
Date: Thu, 18 Jul 2024 10:07:14 -0400
Message-ID: <20240718140733.1731004-16-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240718140733.1731004-1-alexander.deucher@amd.com>
References: <20240718140733.1731004-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A106:EE_|PH7PR12MB7871:EE_
X-MS-Office365-Filtering-Correlation-Id: 27079351-64c8-4591-abf0-08dca73309f8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?lVAOu7BbWAiHCahhnuNGoGkvql3t0pFICIkRjvWvAD/+lGxhBgi/XMHLLG6P?=
 =?us-ascii?Q?Kr9PXEDFPg/C6FOYeiQYZUaY5xO5taNWaymkTbS7A2UN5eNQRaUGn8WKNNk8?=
 =?us-ascii?Q?EMIFEc4urS27ojRr9BOl3FH7YexHjffXA9BCSTcW1xJQaiYQCIJWlP4KM6iV?=
 =?us-ascii?Q?U+Q8DklSEtwZhyxq2ZZ083zQJ/p2x/Sg/RPgujwQ1/PbwmnxsMCR18bLKGoW?=
 =?us-ascii?Q?n2tevSw+PgZbHt4sajDJ4QwzQUOeKHDvJ2SXJXSHtQdM49I42Z4vKP/f8lsV?=
 =?us-ascii?Q?Da/RUoQPZmE3NsGGt3JA0G6ahzgmLmX1MQRR3+wq6/Zf0BznyF070Xm30gIc?=
 =?us-ascii?Q?JL+Er8SQyKml5spGKpwoZczH5SGA5hgi/kK9pfwcHyY7ArKqS3Yz9ZcNFY9i?=
 =?us-ascii?Q?bzJ+cT+b2P6rvhR/8XsCF+u9dj6r9ZOFFo9ngc1a2We45ypxJVfG8tNMj8cJ?=
 =?us-ascii?Q?yBSePO8W9GxWk0ZgtEuLUk2uCFLcY5YsihW52dYss8yvRG5WdYBmWnZxuEB6?=
 =?us-ascii?Q?7nYVKj617OxaRkqdJzoq91FDxa8rlzA/8T/YtYtMAw4jTDvMMyjOBJEKKaGP?=
 =?us-ascii?Q?Xh6r3jja9H4wAfJSgNRcz2nXh9JSL79kRZ5TC1Ld5waOKBQxvQPwUOcYjFqp?=
 =?us-ascii?Q?xokGXL229Q0sW3ZSfP/1tvnLldyusxYz5fNuQSmjFhZOEnj7t+p2xv33XjDF?=
 =?us-ascii?Q?5CrgADgOagBCKU3xq/dQNz1ggwAKKNhlvKSk7z8p9r3c193JVp1ByyrQ2mmm?=
 =?us-ascii?Q?vYOABfsELhL7zkU16juYj6Ef4T8DTMUuU28w3ttarK6HbW+8gD+EYVz2BoCc?=
 =?us-ascii?Q?IbtHyKCWZImQr3MJjk+v8CUXOMJKaq794cDlg5fP8ngXSRoYcRP6I7iAkma0?=
 =?us-ascii?Q?k0TQ/m86lJXJ1iWXV0ip2uvbK22u/ik2IvoABPpSSF7aHT/Iq6M803ugxl4T?=
 =?us-ascii?Q?CXjvFq2TLZ8/KUh8GM5PDYdbKxjqvMKeNgOM4pDYZQU9tysMmiI13rbzlhh2?=
 =?us-ascii?Q?c4H4OHfzvq2Y3M+oqT+Fs8En2Qvb1Lb/D/OnBfZ0Gbsbuaf6lITN1B64F5sc?=
 =?us-ascii?Q?HP29UwZxULBQzUL1ZeHGIUzMhuz3mdHSibA833f+dRSFeCq504RSV2QFBD+6?=
 =?us-ascii?Q?4OFqYQqyBEW7prynO6PafZUdM4E8io2S27u4tiEFMX5NnXXwX66IdOP6Z5H4?=
 =?us-ascii?Q?/IHg4uBTnJC+zHhErHPSiKHPH3qqN4OYXGuzfS4KObYYcisKkx7Ky/JblFzf?=
 =?us-ascii?Q?xqj6QfEXL9Gb53FtjOQ3TtkJIyKD6b9HEzyC+wAx+iQ3yd0NZsWB3VySteNK?=
 =?us-ascii?Q?fRdJkWFFwxX5Y6eNSwN7p0zB12abcsAOfPcRJLZud6ATAjfG4feyiNtveW/a?=
 =?us-ascii?Q?4NFKKa1cy4lx9gOiT+oUnh0i7q5O5TNCpUbR6vzJLhH4NJ+5gD0RM8kpIMQQ?=
 =?us-ascii?Q?k5cIKT3EURhvCgs4tbMvzeMHFiDAf0i+?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2024 14:08:03.1605 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 27079351-64c8-4591-abf0-08dca73309f8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A106.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7871
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

From: Jiadong Zhu <Jiadong.Zhu@amd.com>

Kiq command unmap_queues only does the dequeueing action.
We have to map the queue back with clean mqd.

v2: fix up error handling (Alex)

Signed-off-by: Jiadong Zhu <Jiadong.Zhu@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c | 46 ++++++++++++++++++++------
 1 file changed, 35 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
index 3d0446337751..5cc0d22d1e2f 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -7086,13 +7086,13 @@ static int gfx_v10_0_kiq_init_queue(struct amdgpu_ring *ring)
 	return 0;
 }
 
-static int gfx_v10_0_kcq_init_queue(struct amdgpu_ring *ring)
+static int gfx_v10_0_kcq_init_queue(struct amdgpu_ring *ring, bool restore)
 {
 	struct amdgpu_device *adev = ring->adev;
 	struct v10_compute_mqd *mqd = ring->mqd_ptr;
 	int mqd_idx = ring - &adev->gfx.compute_ring[0];
 
-	if (!amdgpu_in_reset(adev) && !adev->in_suspend) {
+	if (!restore && !amdgpu_in_reset(adev) && !adev->in_suspend) {
 		memset((void *)mqd, 0, sizeof(*mqd));
 		mutex_lock(&adev->srbm_mutex);
 		nv_grbm_select(adev, ring->me, ring->pipe, ring->queue, 0);
@@ -7154,7 +7154,7 @@ static int gfx_v10_0_kcq_resume(struct amdgpu_device *adev)
 			goto done;
 		r = amdgpu_bo_kmap(ring->mqd_obj, (void **)&ring->mqd_ptr);
 		if (!r) {
-			r = gfx_v10_0_kcq_init_queue(ring);
+			r = gfx_v10_0_kcq_init_queue(ring, false);
 			amdgpu_bo_kunmap(ring->mqd_obj);
 			ring->mqd_ptr = NULL;
 		}
@@ -9521,25 +9521,49 @@ static int gfx_v10_0_reset_kcq(struct amdgpu_ring *ring,
 	spin_lock_irqsave(&kiq->ring_lock, flags);
 
 	if (amdgpu_ring_alloc(kiq_ring, kiq->pmf->unmap_queues_size)) {
-		spin_unlock_irqrestore(&kiq->ring_lock, flags);
-		return -ENOMEM;
+		r = -ENOMEM;
+		goto out;
 	}
 
 	kiq->pmf->kiq_unmap_queues(kiq_ring, ring, RESET_QUEUES,
 				   0, 0);
 	amdgpu_ring_commit(kiq_ring);
 
-	spin_unlock_irqrestore(&kiq->ring_lock, flags);
+	r = amdgpu_ring_test_ring(kiq_ring);
+	if (r)
+		goto out;
+
+	r = amdgpu_bo_reserve(ring->mqd_obj, false);
+	if (unlikely(r != 0)){
+		dev_err(adev->dev, "fail to resv mqd_obj\n");
+		goto out;
+	}
+	r = amdgpu_bo_kmap(ring->mqd_obj, (void **)&ring->mqd_ptr);
+	if (!r) {
+		r = gfx_v10_0_kcq_init_queue(ring, true);
+		amdgpu_bo_kunmap(ring->mqd_obj);
+		ring->mqd_ptr = NULL;
+	}
+	amdgpu_bo_unreserve(ring->mqd_obj);
+	if (r){
+		dev_err(adev->dev, "fail to unresv mqd_obj\n");
+		goto out;
+	}
+
+	if (amdgpu_ring_alloc(kiq_ring, kiq->pmf->map_queues_size)) {
+		r = -ENOMEM;
+		goto out;
+	}
+	kiq->pmf->kiq_map_queues(kiq_ring, ring);
+	amdgpu_ring_commit(kiq_ring);
 
 	r = amdgpu_ring_test_ring(kiq_ring);
+
+out:
+	spin_unlock_irqrestore(&kiq->ring_lock, flags);
 	if (r)
 		return r;
 
-	/* reset the ring */
-	ring->wptr = 0;
-	*ring->wptr_cpu_addr = 0;
-	amdgpu_ring_clear_ring(ring);
-
 	return amdgpu_ring_test_ring(ring);
 }
 
-- 
2.45.2

