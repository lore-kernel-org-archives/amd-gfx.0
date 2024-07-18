Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40F95C3DA70
	for <amd-gfx@archiver.kernel.org>; Thu, 18 Jul 2024 14:08:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F37BD10E8E1;
	Thu, 18 Jul 2024 14:08:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="sAbJlpie";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2072.outbound.protection.outlook.com [40.107.223.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 568DD10E8E3
 for <amd-gfx@lists.freedesktop.org>; Thu, 18 Jul 2024 14:08:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xYEdnsBb1JwTVU+vBITiqWpMWVxsSCx+nu9s8PyciZIpsS87Q7rAHF6yzi+ylZMzcwuHgjVRopV9ckyXsucDEJwUenlIM/oElTs1DHdNR/8gvrzsKonaxNnGxQBrKCGEyRNIw3puI1hNhOVSQfWZSCUjFI0ZV8atSUh9xSgGesDsgpNAccfJIE9Yj6GIYjMEHhOgQoPVWJ+UjgjfB0CZ4FFYtugdDplPPN1CwwP13Gz4+TD2GXvlppTvt4sX/oBbuyvYZowpZE42AB777DT1izJkNvshNLi7/aehelabgM4BCPT3el0s+kIsPcV1fdTQiaOJ2+8iseDIJ9iwZWVqSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dZHUPCKAPJNu6VZaC73TS5niX7JkcdeCm/nR1FPo68Y=;
 b=Yp9Xs07V7fBOyPJaG0KpMuo9GDIEgjDD9Fevvkmdz0plaLEUR/BT3rHC6KCTWKfpPHaxePU67LE7iji0mJlT9Prpc/4LP9uEagXoV/pp0lE3MW+YRCnbUJFeALafM2k/HRAD8TUA7nvZD54QPM7/rKu8OhhTiVLHWTVWJcF/EuAxbmGHK+uxTvxOrJC2Fn+qUFrvSPbM8Qkv2vevc1OuMbOMJ1WGwBEwxT54sMa8Z8mCBxXyS7/X48bGiS4ASxM3rV0Y0EC+Xd47vI/JwXsNLKd4Z8h7zpPXI++cul2GkXfjfs2VPnb+hH4pdg2Ke8vOlugQvcpNU/o+I057b4BimQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dZHUPCKAPJNu6VZaC73TS5niX7JkcdeCm/nR1FPo68Y=;
 b=sAbJlpie1kOWzynJNm2YT3kuTKx7Us26vYYffrLb0cj0cCXvqN+3Ygy2l3KWjKb8OSFBkwo5Da4w6GnqwFfoqXI8Y8tb9mhEys2CK7FoO6N6bHNYUdbw/nsrMHAW/p8RL2UF5iwqptDN1lZTBm8gnqt3RH4/q9HkWunVl6XqZ6M=
Received: from BLAPR03CA0041.namprd03.prod.outlook.com (2603:10b6:208:32d::16)
 by IA0PR12MB8255.namprd12.prod.outlook.com (2603:10b6:208:404::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.14; Thu, 18 Jul
 2024 14:08:03 +0000
Received: from BL02EPF0001A106.namprd05.prod.outlook.com
 (2603:10b6:208:32d:cafe::85) by BLAPR03CA0041.outlook.office365.com
 (2603:10b6:208:32d::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.16 via Frontend
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
 2024 09:07:59 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Jiadong Zhu <Jiadong.Zhu@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 16/34] drm/amdgpu/gfx10: wait for reset done before remap
Date: Thu, 18 Jul 2024 10:07:15 -0400
Message-ID: <20240718140733.1731004-17-alexander.deucher@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF0001A106:EE_|IA0PR12MB8255:EE_
X-MS-Office365-Filtering-Correlation-Id: 7e15d960-f8f2-4fee-4573-08dca7330a53
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?7Xhwc2gwKRDioXnBbJXOUNrAX4W1d2KCqhZ0YhAv3OKMXQ66keQdahzmsqq3?=
 =?us-ascii?Q?m/WklCqpWocov3OSGIhYmyu01al+fNtgDCJ8+3Gq1n1aLPbvdcNpQeG+MdAG?=
 =?us-ascii?Q?sEtOJb8t+gPXu/vpmWu7qQdm7Kotz2bzI+LqFWH/UJycqppMfQsWC6iETMvm?=
 =?us-ascii?Q?jNHBDQEroVL1z5Dh9MpRDicrm1wn1Kqk62EisbvsB9GFeXOilTGqV9Nmqqsk?=
 =?us-ascii?Q?30VEwqI6zVfVlERWgfON8sBk5PYE/MTmSIIf852BLeAs8EGFKhC2Jfw12UKQ?=
 =?us-ascii?Q?mz2wOBbmc7mh22YzIZMgaX6re5+I/jFmnaAbnVq4qHEq4gOYeLWCi+SUNMsu?=
 =?us-ascii?Q?fYCailrLs6BO199A7Ibe/lEFrjKmyfkwSjQn9CBs//A2XTW/3nSxnr6fwIrm?=
 =?us-ascii?Q?MPEOhEjMxwz1sv8TEfk9DPaV9L2meXX1aq9AcbdOB+ogpQp+pdmhnoidccen?=
 =?us-ascii?Q?135ExpmR2/Ytn9EuhfDiEZYIVqrZOl+mF4JgreK2BG+jRWz5sn1LKAnTJX6a?=
 =?us-ascii?Q?TGDhiCU+OF1Dza0YBmYdBojUmtYFRqC/C2EUPWLRQUQvXpP5ixDY5Tk/na2T?=
 =?us-ascii?Q?jIZ+WOyEbCu4qkfH4OBg2vFkR+TdWDQl+YVu1UZ1l+2lpdpJMofP/HLjuXzs?=
 =?us-ascii?Q?tZ8zXINz3AEdEfJ+J6bR1OAylrkz0q5hjWHXKu6WwkA/2Sci1JfejqRi8ygq?=
 =?us-ascii?Q?CfyGaqu+W29agH8DjKK/cxlZctR/6SFUtVreHqrJ6ArCN44HTbTe5yCz82PU?=
 =?us-ascii?Q?mJNAa8gXaKphLvWWV2llrR/rwqZGj2Ytlf0DagOou4c+Zq79XE7b5Ap20MBx?=
 =?us-ascii?Q?TqIwWxWufSE7qL5HJD8MXUGjCbko3/qSk6YfawOmBfqxG5Km8z/I+59zZd1D?=
 =?us-ascii?Q?S72Mgq9yJXoF3t8zkuJ051VYDjKMfjmYrjYUH78l8ipWghH8FHwUtlub1arO?=
 =?us-ascii?Q?VbtlmDHnkvZxn4KUgCvNyC2Bx3DBAxpeKC1b+llURl6a84wDDuthAKKRuTVZ?=
 =?us-ascii?Q?ajwTNFQxyIcIMYwgFV5I7rLS/1o72C//4m8b8ncYfk/pVcpiec0ijQEMXOfE?=
 =?us-ascii?Q?ca6bWVdfyJUoDBV04yPTsdNRcTd+jU7f0jr7QXqb2wUsDsB2mgQQpB/dcOGQ?=
 =?us-ascii?Q?FVbJEJ27lvb4lwoVh0dffKjO+1XJGoIzT+deiPk6OZUhgC3Fi+RH0YvnUXJe?=
 =?us-ascii?Q?np5/bRoEZuFpxaVGKj1XH6cG2QygB9bOrThMP3Efn1hoVIwy/0JaXrDHNuvj?=
 =?us-ascii?Q?PCZJpQuubDRfbBtKtSUFRgHFsaAxI7fOBnlyHYq/knJZDR0AHpJFn7bLYm6H?=
 =?us-ascii?Q?cDIBXjlhcSCUqF2cTI4my0dVWYTAwkV3MsfjVf/25rcc0BfNIz6YUJ4kgn1z?=
 =?us-ascii?Q?2Qy5vGMThBexaeP0ViNQXiZreo8uzCJCzXGVAyAFQcrObiDC1TSUHuDqh+9T?=
 =?us-ascii?Q?QdrHqSSSj7BtrM+39G5Rbs3kGZ7q7Sa4?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2024 14:08:03.7542 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e15d960-f8f2-4fee-4573-08dca7330a53
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A106.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8255
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

There is a racing condition that cp firmware modifies
MQD in reset sequence after driver updates it for
remapping. We have to wait till CP_HQD_ACTIVE becoming
false then remap the queue.

v2: fix KIQ locking (Alex)

Signed-off-by: Jiadong Zhu <Jiadong.Zhu@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c | 41 +++++++++++++++++++-------
 1 file changed, 30 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
index 5cc0d22d1e2f..e9d93bf909db 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -9513,7 +9513,7 @@ static int gfx_v10_0_reset_kcq(struct amdgpu_ring *ring,
 	struct amdgpu_kiq *kiq = &adev->gfx.kiq[0];
 	struct amdgpu_ring *kiq_ring = &kiq->ring;
 	unsigned long flags;
-	int r;
+	int i, r;
 
 	if (!kiq->pmf || !kiq->pmf->kiq_unmap_queues)
 		return -EINVAL;
@@ -9521,8 +9521,8 @@ static int gfx_v10_0_reset_kcq(struct amdgpu_ring *ring,
 	spin_lock_irqsave(&kiq->ring_lock, flags);
 
 	if (amdgpu_ring_alloc(kiq_ring, kiq->pmf->unmap_queues_size)) {
-		r = -ENOMEM;
-		goto out;
+		spin_unlock_irqrestore(&kiq->ring_lock, flags);
+		return -ENOMEM;
 	}
 
 	kiq->pmf->kiq_unmap_queues(kiq_ring, ring, RESET_QUEUES,
@@ -9530,13 +9530,33 @@ static int gfx_v10_0_reset_kcq(struct amdgpu_ring *ring,
 	amdgpu_ring_commit(kiq_ring);
 
 	r = amdgpu_ring_test_ring(kiq_ring);
+	spin_unlock_irqrestore(&kiq->ring_lock, flags);
 	if (r)
-		goto out;
+		return r;
+
+	/* make sure dequeue is complete*/
+	gfx_v10_0_set_safe_mode(adev, 0);
+	mutex_lock(&adev->srbm_mutex);
+	nv_grbm_select(adev, ring->me, ring->pipe, ring->queue, 0);
+	for (i = 0; i < adev->usec_timeout; i++) {
+		if (!(RREG32_SOC15(GC, 0, mmCP_HQD_ACTIVE) & 1))
+			break;
+		udelay(1);
+	}
+	if (i >= adev->usec_timeout)
+		r = -ETIMEDOUT;
+	nv_grbm_select(adev, 0, 0, 0, 0);
+	mutex_unlock(&adev->srbm_mutex);
+	gfx_v10_0_unset_safe_mode(adev, 0);
+	if (r) {
+		dev_err(adev->dev, "fail to wait on hqd deactive\n");
+		return r;
+	}
 
 	r = amdgpu_bo_reserve(ring->mqd_obj, false);
 	if (unlikely(r != 0)){
 		dev_err(adev->dev, "fail to resv mqd_obj\n");
-		goto out;
+		return r;
 	}
 	r = amdgpu_bo_kmap(ring->mqd_obj, (void **)&ring->mqd_ptr);
 	if (!r) {
@@ -9545,21 +9565,20 @@ static int gfx_v10_0_reset_kcq(struct amdgpu_ring *ring,
 		ring->mqd_ptr = NULL;
 	}
 	amdgpu_bo_unreserve(ring->mqd_obj);
-	if (r){
+	if (r) {
 		dev_err(adev->dev, "fail to unresv mqd_obj\n");
-		goto out;
+		return r;
 	}
 
+	spin_lock_irqsave(&kiq->ring_lock, flags);
 	if (amdgpu_ring_alloc(kiq_ring, kiq->pmf->map_queues_size)) {
-		r = -ENOMEM;
-		goto out;
+		spin_unlock_irqrestore(&kiq->ring_lock, flags);
+		return -ENOMEM;
 	}
 	kiq->pmf->kiq_map_queues(kiq_ring, ring);
 	amdgpu_ring_commit(kiq_ring);
 
 	r = amdgpu_ring_test_ring(kiq_ring);
-
-out:
 	spin_unlock_irqrestore(&kiq->ring_lock, flags);
 	if (r)
 		return r;
-- 
2.45.2

