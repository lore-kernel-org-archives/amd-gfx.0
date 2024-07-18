Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A016FC52CD8
	for <amd-gfx@archiver.kernel.org>; Thu, 18 Jul 2024 14:08:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9DFF510E8FB;
	Thu, 18 Jul 2024 14:08:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="vdoahqdp";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2069.outbound.protection.outlook.com [40.107.220.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5EB2210E8C9
 for <amd-gfx@lists.freedesktop.org>; Thu, 18 Jul 2024 14:08:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gp+TRx580JRkl0LGiT+A4+dP8PetR5EDz6GglX1c9tRNIAblVUSKLyM5tC5l8w2Z1ukGtNYRk8wvPgsZ75S2TtZuG78pfinTtKtSETGNn5gsc0XoJ0VayNJY+SO7eGRXdjnB00kxc+DVTSTtZmWHhBjaiDmOxA481HVXJUXiC1Ow4VYOg0DGvBDbRBnY9QM8w66a4qgqn+lf8KkspqxTXOEHDUkrUQwGxjevJUFTy/3hFNetxlDbYB7wVPvu7DH5M4J1Pus+oqPz5xqbgx5/edPN0qJuKmNwe49EIqJ7KrjilK+FlOtxOwjUvf4/+WMYqgZWnsIBkMDzLQoEv6H0hw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xMr+d3HQb/lTCXm+3sA/ixrCks579RossD19I/gZ8d0=;
 b=d/7C5JcKRMQVpeVJj07P99ng1V7KabZO4T8hoS1E8ch/DcbBp2KirXlyB62mu0VHu7z0khue02Y1aolCDbHPBjEXt7glxglQ1XWnhGhi4770ZgKB/Gf11ZlJsJ6or7gz1tEA1MHTakL8wx7dVrET4KiY3f384h2vS44EB3XuC+XKh9C4ZLxeL8RKBB+wSPrRjX6fEhX7hDRsWok+nhsK4AErjGjeV1a73s6K+eIVxqtXKlSNfHQruJlh3+3U9PI30bR/grrK85OG2eqJCrnnUEsny5yITXV9QeZFNz3yd4+EbEaDLjMNVRJXksGdhkFfViS1SYvY2YF1+9vC6xn6Kg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xMr+d3HQb/lTCXm+3sA/ixrCks579RossD19I/gZ8d0=;
 b=vdoahqdp2zqvalObaLOEq5cmXoWII888CQ2ek8ZekO/aiZc1fL5wjSGJ/65AtJiXhSvnO3WLnMLj2ValJ2MKNRVtKcb1w2OFEQ0Zotsn525lIUSxJRkfR5O3bWebzqh7Ta2dzqbC+NlVhqsZN10iOVfEfnb8Bq3uGl2R0Dpg4i0=
Received: from BL0PR02CA0001.namprd02.prod.outlook.com (2603:10b6:207:3c::14)
 by PH7PR12MB6657.namprd12.prod.outlook.com (2603:10b6:510:1fe::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.17; Thu, 18 Jul
 2024 14:08:06 +0000
Received: from BL02EPF0001A104.namprd05.prod.outlook.com
 (2603:10b6:207:3c:cafe::15) by BL0PR02CA0001.outlook.office365.com
 (2603:10b6:207:3c::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.16 via Frontend
 Transport; Thu, 18 Jul 2024 14:08:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0001A104.mail.protection.outlook.com (10.167.241.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7784.11 via Frontend Transport; Thu, 18 Jul 2024 14:08:05 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 18 Jul
 2024 09:08:02 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Jiadong Zhu <Jiadong.Zhu@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 22/34] drm/amdgpu/gfx9.4.3: remap queue after reset
 successfully
Date: Thu, 18 Jul 2024 10:07:21 -0400
Message-ID: <20240718140733.1731004-23-alexander.deucher@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF0001A104:EE_|PH7PR12MB6657:EE_
X-MS-Office365-Filtering-Correlation-Id: 4a89764d-0153-411c-df36-08dca7330b8b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Qaa1SZ4R0hzp9tfXQau769vF4u54mKobOodigkdd8Tj9TMfnZF4zz5Xxeikp?=
 =?us-ascii?Q?ia9YfMhqunU6TTBTPA0VYgkXiBVorpv9hnpMR1AmzcEFlru2WqkQMhlYXEAQ?=
 =?us-ascii?Q?TPPjZ5cN5SEm008vYzAsLuxJHGfwUMi5DgOyPV9NiqGIBf+pxFCmizUBt3px?=
 =?us-ascii?Q?Noyv02Wpm3Nw3YPZx052kXyEoxQsshvtZlk07BRCp12z4EF/C45CtTgd16kc?=
 =?us-ascii?Q?q5DL9nZE18dyJLMQWO7VFUD4cUWHtwFJlOx9CpWochT5OTLiAXpfELlRGb9r?=
 =?us-ascii?Q?o8CRjGdNSWhC8OPgAm6kNsDX8XpOlo/idaVKZZ27eqbdYGeB16KE8VC3yG0v?=
 =?us-ascii?Q?4ouztY27oIIW1uHFRBd00BH81fHvhphNYnd2qL2ZDbr7sHc0EL9gOVLRWiXP?=
 =?us-ascii?Q?ahjkBPWZ3EUW8HY4FVxM0cqPKZvNeTYiTj63+XydkpUq5drR5lEEHbgK0WK/?=
 =?us-ascii?Q?tI6pPphJlmc4nK/M+utC+n6xn2vKHtpVxWiwb75imYANLdCvJyHeno+DGeXs?=
 =?us-ascii?Q?9iQi6ZrEVEzEzM0MA1c5UJiD+oFpFU1K4lwGdz5kRhlpCeyvA9Lv3C0dQm11?=
 =?us-ascii?Q?MF52p8s6d+t4bbEGs9d5B0dpr6yH7PNkEMCcDoWbmBkhR63cV5H6IjY3dq39?=
 =?us-ascii?Q?EfJZCueNHnSnzZVBuxS9glM9Ys4ItrfTIivRBjTRwMVZKLG05CKv4/Covhca?=
 =?us-ascii?Q?RQN9iJqnT/pP0PXmaOYc3aC5ARBgNQ2m2lu+CYIaY6RNcB/+623TZF/tm1UP?=
 =?us-ascii?Q?yYSILJGMk2arkJN1Wr1XOYA30nv7RkIbvKxRnsMJu5F2/F39SpMZ2Iiqf6lI?=
 =?us-ascii?Q?iwvLT6M51yjmip3u5dJe//gu4nHzW+HGWp5BORMXtiUHb+TCpvOsJfEUpAm0?=
 =?us-ascii?Q?AFEk7MBpCW2bHtMZ47UzBVYvxeSrr6gzM/mMWUgsJPCsDJFWxnRHD8cKZLv9?=
 =?us-ascii?Q?VAhdvkyqSrqlSQr7UmqtS7NLZyLuXnoSTKXFV96+teGMGosyIm0d1fsu28Oo?=
 =?us-ascii?Q?u0ZIg9v4DoxL43uQbYhA5ZH7XRu9mrNX/NAXryhCQ3OnJP0z36DjEjzBjkbc?=
 =?us-ascii?Q?CkGwpta0UPjNEHsdyr9x9/UhNDUjZqXjNx50i4AdpuXkP9+kuzojSJDbpR7U?=
 =?us-ascii?Q?VcKXN0+BN3lbB7UcldGAETsTpYS342GcmyfqCAToLL+pz5WLBzPIkhNp1ARD?=
 =?us-ascii?Q?kCEj8UQ/MCH5FzyH3kj9GTX3qraOdkjNVLEFxshfiXmMo0k2Nv4NE7dws3Yy?=
 =?us-ascii?Q?s0AB2QMfXbBiOmgumxCL0fz9tjRnJHbiGDi7Z78vp7DCe/WX55yMhF2JPwHI?=
 =?us-ascii?Q?IDzgxer6lvB2hWFR3JtFmBevQN7HHpqPaCtz5QPhY49V9cfCkgNao+Wp9c3Z?=
 =?us-ascii?Q?rXLzGJ6RaTgpyMAKyqijJlXl65kvaPb+Ay4fHTxgUD0dqrfQCdfVVesw2A0G?=
 =?us-ascii?Q?ELrpwu1eV4V/JvbE9twwNEHtNmBXt6oL?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2024 14:08:05.7873 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a89764d-0153-411c-df36-08dca7330b8b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A104.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6657
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

Signed-off-by: Jiadong Zhu <Jiadong.Zhu@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c | 36 ++++++++++++++++++-------
 1 file changed, 27 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
index 6cf90ebdbad1..394790d00385 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
@@ -1917,7 +1917,7 @@ static int gfx_v9_4_3_xcc_kiq_init_queue(struct amdgpu_ring *ring, int xcc_id)
 	return 0;
 }
 
-static int gfx_v9_4_3_xcc_kcq_init_queue(struct amdgpu_ring *ring, int xcc_id)
+static int gfx_v9_4_3_xcc_kcq_init_queue(struct amdgpu_ring *ring, int xcc_id, bool restore)
 {
 	struct amdgpu_device *adev = ring->adev;
 	struct v9_mqd *mqd = ring->mqd_ptr;
@@ -1929,8 +1929,8 @@ static int gfx_v9_4_3_xcc_kcq_init_queue(struct amdgpu_ring *ring, int xcc_id)
 	 */
 	tmp_mqd = (struct v9_mqd *)adev->gfx.mec.mqd_backup[mqd_idx];
 
-	if (!tmp_mqd->cp_hqd_pq_control ||
-	    (!amdgpu_in_reset(adev) && !adev->in_suspend)) {
+	if (!restore && (!tmp_mqd->cp_hqd_pq_control ||
+	    (!amdgpu_in_reset(adev) && !adev->in_suspend))) {
 		memset((void *)mqd, 0, sizeof(struct v9_mqd_allocation));
 		((struct v9_mqd_allocation *)mqd)->dynamic_cu_mask = 0xFFFFFFFF;
 		((struct v9_mqd_allocation *)mqd)->dynamic_rb_mask = 0xFFFFFFFF;
@@ -2015,7 +2015,7 @@ static int gfx_v9_4_3_xcc_kcq_resume(struct amdgpu_device *adev, int xcc_id)
 			goto done;
 		r = amdgpu_bo_kmap(ring->mqd_obj, (void **)&ring->mqd_ptr);
 		if (!r) {
-			r = gfx_v9_4_3_xcc_kcq_init_queue(ring, xcc_id);
+			r = gfx_v9_4_3_xcc_kcq_init_queue(ring, xcc_id, false);
 			amdgpu_bo_kunmap(ring->mqd_obj);
 			ring->mqd_ptr = NULL;
 		}
@@ -3292,11 +3292,29 @@ static int gfx_v9_4_3_reset_kcq(struct amdgpu_ring *ring,
 	if (r)
 		return r;
 
-	/* reset the ring */
-	ring->wptr = 0;
-	*ring->wptr_cpu_addr = 0;
-	amdgpu_ring_clear_ring(ring);
-
+	r = amdgpu_bo_reserve(ring->mqd_obj, false);
+	if (unlikely(r != 0)){
+		DRM_ERROR("fail to resv mqd_obj\n");
+		return r;
+	}
+	r = amdgpu_bo_kmap(ring->mqd_obj, (void **)&ring->mqd_ptr);
+	if (!r) {
+		r = gfx_v9_4_3_xcc_kcq_init_queue(ring, ring->xcc_id, true);
+		amdgpu_bo_kunmap(ring->mqd_obj);
+		ring->mqd_ptr = NULL;
+	}
+	amdgpu_bo_unreserve(ring->mqd_obj);
+	if (r){
+		DRM_ERROR("fail to unresv mqd_obj\n");
+		return r;
+	}
+	r = amdgpu_ring_alloc(kiq_ring, kiq->pmf->map_queues_size);
+	kiq->pmf->kiq_map_queues(kiq_ring, ring);
+	r = amdgpu_ring_test_ring(kiq_ring);
+	if (r){
+		DRM_ERROR("fail to remap queue\n");
+		return r;
+	}
 	return amdgpu_ring_test_ring(ring);
 }
 
-- 
2.45.2

