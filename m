Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E01E4C54EDA
	for <amd-gfx@archiver.kernel.org>; Thu, 22 May 2025 21:56:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 616ED10E71B;
	Thu, 22 May 2025 21:56:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="RbjOyoQ1";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2071.outbound.protection.outlook.com [40.107.236.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1EFC010E72F
 for <amd-gfx@lists.freedesktop.org>; Thu, 22 May 2025 21:56:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=v68aGVum6jT0m1gEchlQUl2neufOnMQRc5uK/iVnMavw1Z1BuZD2OKVNOrLqlp9EGoqL5lEbLYnw1jijrI8QHBCDDnG5RyZZeUqzgZz5sJGbl90QOzHxhv9GhU9FfncqMIh5hNK4Egk5x3uxt6a2UdiPKug9BzHSKk+Kp/qaDOO1zcjjwCi57T4tegK+olq5zYXDyBEknMJEbT4ySkQwyGJ1JKZhPUzLLKtHRm9vqhfYNIYHsTLH+2gWLu2UJCEvXCLYpsJWCo3EhJm4z8xKe8IAl1VYGO3tYSqu7wQ+1gHSQjAP95aZ55u0HNFYMFMlMur0lBMGDLILjnYB/qVsZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DVm39FX87PK5FZhn3iz/6/Si2RzuoMkEROCUJ3i3WNM=;
 b=CQYpI7lkShVY0r/WFc97sUAqRxbrSvr33uXDXKvyPGAwu9JRMxxrFWkYjz24r+pAjbFX6JJV0vzWC1ddc48jJGh9aT80AdabYIQj7d1aSnobmaraGIAtwV0NhxNXKn8bZ0i2yB+g+ET/DPnkuZq94hGmamZesnnIUxFfyueVYv31J0UO8IJzUfrjB9PZlT36B/UzRMphpEYvcuGiRtog1dux/uOGcWh6CtBb46/EoGdqdU+SWQgBuvFn5iCVNebh/UhHbOjcPoetYYfeZVM6QiU8IdQK+ch8tjB7YPmbio1C7JJQyEpPbHWwPzvnc8rBkT6LfiOep22dbLY0SHzJoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DVm39FX87PK5FZhn3iz/6/Si2RzuoMkEROCUJ3i3WNM=;
 b=RbjOyoQ1G1GWO8UMLBYwmRtp1sKENWL0gX+EOEUOtuDIU7EdepRBOLtbk/HvJzovfch9lKp4pI1msf44+DqlMz+sheJ/RDMw0SBqiiXYK19dFtadI+YCNvSJfttRDAdXokezckWdZb4sbnfexZms9JiEQfgffbF80JfNa1EIECI=
Received: from MN0PR02CA0001.namprd02.prod.outlook.com (2603:10b6:208:530::21)
 by PH7PR12MB7843.namprd12.prod.outlook.com (2603:10b6:510:27e::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.20; Thu, 22 May
 2025 21:56:19 +0000
Received: from BN3PEPF0000B078.namprd04.prod.outlook.com
 (2603:10b6:208:530:cafe::ae) by MN0PR02CA0001.outlook.office365.com
 (2603:10b6:208:530::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8769.19 via Frontend Transport; Thu,
 22 May 2025 21:56:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B078.mail.protection.outlook.com (10.167.243.123) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8769.18 via Frontend Transport; Thu, 22 May 2025 21:56:19 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 22 May
 2025 16:56:17 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 09/10] drm/amdgpu/gfx10: adjust ring reset sequences
Date: Thu, 22 May 2025 17:55:58 -0400
Message-ID: <20250522215559.14677-10-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250522215559.14677-1-alexander.deucher@amd.com>
References: <20250522215559.14677-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B078:EE_|PH7PR12MB7843:EE_
X-MS-Office365-Filtering-Correlation-Id: d18babda-1bdc-435b-2093-08dd997b7be9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?m1LrTjj584xN5e52yXxPYV04vT9OHy2mdCs6TQsuvbj2yWSHNzv2NAQP2pzi?=
 =?us-ascii?Q?OyDLPHx+vFbaYdpbpJGho1WbgHIDi+/CWAcfTNzIN0qRxbcjPKoeccGTK8az?=
 =?us-ascii?Q?Jz5hgyL3aNsyR1ZjfQgiV/Ad1W1gcmhvhN0bacz5ficvNRXDlkIYQiBOo5pw?=
 =?us-ascii?Q?0gHPlRv7CTPSJdCSl0sENINO/pH/010mTBQjbYSZPoICilz1ck7qVHRx5mrk?=
 =?us-ascii?Q?MzVEnH0O31Kt5wQpuOAIOCJND6jpU2rWkFW3+Ig5mIUojGCY1H/YVR+fGDhG?=
 =?us-ascii?Q?E24JgGOX7UBkcuPmI04dXwRhjYRzeD4WFWmX44oDRz5f1H5B7GmtzZtpXV/U?=
 =?us-ascii?Q?nuFBAcdi6VyT1ZZ3tMMiq+SLHdOS3cwqgdPFyEi2o+bCSXdU3zMiVDyjCXyc?=
 =?us-ascii?Q?ZBwfao35t3IzKmn8RVXy9fzCVfruARcx1Ff3EsOLTj7UKymSZu6BxwZ8ZSDz?=
 =?us-ascii?Q?qdZx+x8WUlXwW78i/p/bKZSzTxF5NLxBRJ6i+R2K/P+PpmK80GjZXZbOe2ZY?=
 =?us-ascii?Q?LhjDMPQ6f0/qiZmMZ1P1958AMtveAPpWbSWOhZbeKQSfx4Hp+VDDbxOE3IU3?=
 =?us-ascii?Q?6PJug5Rf5xLeyuksgS1raa4zBuk09fRDkfibP+Cpd++sxNDzyOuPNrcDYcKl?=
 =?us-ascii?Q?f9SnnjMN44UJ4Yuz7Oxabeql8yoLobVre1dXfDxiXLNugpyB4N8/dXRDRA1+?=
 =?us-ascii?Q?IooNFQ6kaTLS4PTDzU77TZnmrWMzMY43eIszL7MWHKhgrGdRWExxqS6C9Jwc?=
 =?us-ascii?Q?enDZ9i+OG2IvnowgQQ3M30bme5SO1o4IftwW9DgfbRRmOKZwQns+exHphoVr?=
 =?us-ascii?Q?4d6lQc3dfa4kS50COaRBsxYaaNOyV4R/7u8wYi82VZonisT9NcQhvmCHlRpG?=
 =?us-ascii?Q?pZ24gDW/jtiQuQnGv48kZ1x00xTiDG5zmdr/AaE9OKTHE6g1SPEwPfgztG7g?=
 =?us-ascii?Q?tSFIKhlH+vrEpDHta+z4i7ize8SYLR89d+J2eINREp4GLq3+aJgr//hebGkY?=
 =?us-ascii?Q?Lpb4ILq/5S0rdyEtonlSg86LVYVSOdnbl4foBHuFTfLWqbqBL0YEknNZDr4E?=
 =?us-ascii?Q?cJqL4YTs7V8UokRhRf2kvslW3RsAGawW07TUqnMia9ZEASz3htwKhJTivvcw?=
 =?us-ascii?Q?avJ8A9Ets6RxzZAm0U/AHsVz4CNNhLeBaQm8Cr/7cVMYx57rHnhnjHW4Krts?=
 =?us-ascii?Q?jy7xKfbM/ALkGZY2kacfIOeD3KZ5AAuP1MS5mZt/2mInA/hefcrWJz4MN0OA?=
 =?us-ascii?Q?PxzeVQJjKa8B/G2rJFpjfdFQaOrStNX786qT8Y/1LUsXDuF3GNeKVbkYfO9o?=
 =?us-ascii?Q?46/wnIWFHWSp9KpKq+EO8+fzBXkPXgptAHwGzB6tXuMaowQ2axlWitQrZREK?=
 =?us-ascii?Q?gKFfQcLKNepOo25LeZ4hv3EAcdNm7Y2++WO8tv6DFJwqJKZqPNundNi4g4ow?=
 =?us-ascii?Q?jRvctgaRshpsTj3BhBFF96s15t8MpeXN24pWnGZjjI0YL8WPGkmUtdNr4JRW?=
 =?us-ascii?Q?GHNcwIWXkRiAbKtuDoB+rg0h12yKKvR0Zivp?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2025 21:56:19.4970 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d18babda-1bdc-435b-2093-08dd997b7be9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B078.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7843
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

Don't clear the ring contents after we issue
a VM reset just write the trailing fence.  GFX
block will reset the work associated with the
vmid and and then continue from where it left off.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
index 14cbd1f08eb5c..3d2eab585b64e 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -8713,6 +8713,7 @@ static void gfx_v10_0_ring_emit_fence(struct amdgpu_ring *ring, u64 addr,
 {
 	bool write64bit = flags & AMDGPU_FENCE_FLAG_64BIT;
 	bool int_sel = flags & AMDGPU_FENCE_FLAG_INT;
+	bool exec = flags & AMDGPU_FENCE_FLAG_EXEC;
 
 	/* RELEASE_MEM - flush caches, send int */
 	amdgpu_ring_write(ring, PACKET3(PACKET3_RELEASE_MEM, 6));
@@ -8722,7 +8723,8 @@ static void gfx_v10_0_ring_emit_fence(struct amdgpu_ring *ring, u64 addr,
 				 PACKET3_RELEASE_MEM_GCR_GLM_WB |
 				 PACKET3_RELEASE_MEM_CACHE_POLICY(3) |
 				 PACKET3_RELEASE_MEM_EVENT_TYPE(CACHE_FLUSH_AND_INV_TS_EVENT) |
-				 PACKET3_RELEASE_MEM_EVENT_INDEX(5)));
+				 PACKET3_RELEASE_MEM_EVENT_INDEX(5) |
+				 (exec ? PACKET3_RELEASE_MEM_EXECUTE : 0)));
 	amdgpu_ring_write(ring, (PACKET3_RELEASE_MEM_DATA_SEL(write64bit ? 2 : 1) |
 				 PACKET3_RELEASE_MEM_INT_SEL(int_sel ? 2 : 0)));
 
@@ -9563,19 +9565,18 @@ static int gfx_v10_0_reset_kgq(struct amdgpu_ring *ring, unsigned int vmid)
 	kiq->pmf->kiq_map_queues(kiq_ring, ring);
 	amdgpu_ring_commit(kiq_ring);
 
-	spin_unlock_irqrestore(&kiq->ring_lock, flags);
-
 	r = amdgpu_ring_test_ring(kiq_ring);
+	spin_unlock_irqrestore(&kiq->ring_lock, flags);
 	if (r)
 		return r;
 
-	r = gfx_v10_0_kgq_init_queue(ring, true);
-	if (r) {
-		DRM_ERROR("fail to init kgq\n");
-		return r;
-	}
+	if (amdgpu_ring_alloc(ring, 8))
+		return -ENOMEM;
+	amdgpu_ring_emit_fence(ring, ring->fence_drv.gpu_addr,
+			       ring->fence_drv.sync_seq, AMDGPU_FENCE_FLAG_EXEC);
+	amdgpu_ring_commit(ring);
 
-	return amdgpu_ring_test_ring(ring);
+	return gfx_v10_0_ring_test_ib(ring, AMDGPU_QUEUE_RESET_TIMEOUT);
 }
 
 static int gfx_v10_0_reset_kcq(struct amdgpu_ring *ring,
@@ -9641,9 +9642,8 @@ static int gfx_v10_0_reset_kcq(struct amdgpu_ring *ring,
 	}
 	kiq->pmf->kiq_map_queues(kiq_ring, ring);
 	amdgpu_ring_commit(kiq_ring);
-	spin_unlock_irqrestore(&kiq->ring_lock, flags);
-
 	r = amdgpu_ring_test_ring(kiq_ring);
+	spin_unlock_irqrestore(&kiq->ring_lock, flags);
 	if (r)
 		return r;
 
-- 
2.49.0

