Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA0A0C3DA7E
	for <amd-gfx@archiver.kernel.org>; Thu, 18 Jul 2024 14:08:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6958A10E8C5;
	Thu, 18 Jul 2024 14:08:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="aPB4If/b";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2066.outbound.protection.outlook.com [40.107.243.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C936E10E8D4
 for <amd-gfx@lists.freedesktop.org>; Thu, 18 Jul 2024 14:08:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UqhCg5PJCGFmBVkrtzfJkk99fJ9Wc6NEbpq2PkpbRU2R9fNVGP+6M7YDhqvMplgI7+C1xmDgk4qfD7Uljfilc6IHWc01c0P/NyuLwxsxZChADynW607QD1a1hAMJdIvn8Bt3ZTwDUAgXO0LlibOVke28dasP7Y042VfmzJqmTglXS5hRKn9bmFkI68OPxZPwDkqJ8PWXhc3g2m0HNDBTK9laOgZmultvtYydRjtPnIC8h7VBdAqFrK6a6GP5jO4YTD4Rwcv24i+1x2g+ikR3eK1U0bjpX8ftJxubMjXKXXtiwpPlhwQOwY++aSJb6YbcqEXV37HHw8G4o+MrzqiT/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V5U9aT+ukHuT3d2CIc61CO4UVKZCTSFtLbtdRnz4Cqk=;
 b=IriFEYgbPdNNONjFXeXlMOSVnNHf90eT3oUbdGfrz5qKOmyGXwezhfWeAduX+IQqXyV9CiALBVhTVz0gH79zw/V7sFwjcg7uuxnw4ixiYRM3DmyrEuT5Z6l+IaPtwCt6Dmz+ZbOg9ojst1PUktyNHGwEglD8DE3/PEnz/+TI1OJnWXRnAlwulrXIjzb1pKF26QehSCyUw9n54wny9pukAVB2x7wNasxn0HS7oKtIs2zxHaXKeQhyXFYHs171+R7bLugKDlrpJFCjkuqWhsnKyRM437GemrmKIOENCcst+U9LOIqifCxjIbr5UVC/wVn8JVCVxnAPZufyryNY4GvouQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V5U9aT+ukHuT3d2CIc61CO4UVKZCTSFtLbtdRnz4Cqk=;
 b=aPB4If/b99Mp/MMKlmjRX9tFry7fahATnw6ZF+Rlq2BcsxlTw+CjgexuavIaDs4qpuI/GSNSFhqy+HuzBeQ+rVLillU+A3J+el89Gl4mCNuQoXHPV2VIcUTdcgI4Cl/fuZkxBblRaXm0QHW6DH0Gvlst3WTw2PGKZqga5OiU+Oo=
Received: from BL0PR02CA0032.namprd02.prod.outlook.com (2603:10b6:207:3c::45)
 by CH2PR12MB4296.namprd12.prod.outlook.com (2603:10b6:610:af::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.29; Thu, 18 Jul
 2024 14:08:05 +0000
Received: from BL02EPF0001A104.namprd05.prod.outlook.com
 (2603:10b6:207:3c:cafe::b8) by BL0PR02CA0032.outlook.office365.com
 (2603:10b6:207:3c::45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.29 via Frontend
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
 15.20.7784.11 via Frontend Transport; Thu, 18 Jul 2024 14:08:04 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 18 Jul
 2024 09:08:00 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Jiadong Zhu <Jiadong.Zhu@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 19/34] drm/amdgpu/gfx9: remap queue after reset successfully
Date: Thu, 18 Jul 2024 10:07:18 -0400
Message-ID: <20240718140733.1731004-20-alexander.deucher@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF0001A104:EE_|CH2PR12MB4296:EE_
X-MS-Office365-Filtering-Correlation-Id: 0270ca49-bc9a-48b1-4713-08dca7330b12
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?n7mitCMf7k5mWC4u5irQ7hAOz2215ME7QNdjzncwA/FmnItKeuGxQbNfzJOq?=
 =?us-ascii?Q?al73ldFte8y2ukfEPjy1BqsnJjTZYx+lA7TkCzdYV/k7PDrx7/lKXhXI0zsT?=
 =?us-ascii?Q?/nOyswcCV91ajiJ0vP5rEuG6LefByQwBITVXn7bJimrPHOImKPPUeyVh9qQ1?=
 =?us-ascii?Q?rt2hI9/Xrm9LdGLUQOVb7NGZeFLSTHvhyQ/RMAOgQL8bN0uCYg0kLYbmXFst?=
 =?us-ascii?Q?mJLSmfglfc9fEgaTf7QC/XGf2xMRRb5h1JP0BKzTwKjZ8L/ajmJb40I6fVxZ?=
 =?us-ascii?Q?NcdtvMVIAvOOuaoPqCsjrFwy2Eswmt/C/cSUybZL7+adh2wCwFixIG/INEdD?=
 =?us-ascii?Q?EO+cESS6iiecEHgjIdYHSYjUBD4k3PHIHyYXwXdNfZ2Vaa/xgiw6AXZhqgme?=
 =?us-ascii?Q?4rqIqO+bfmdeUT5qSkmFXrMUq/Ht35kgOLM93UFqGrBKLNDQH+i8XFatBfz4?=
 =?us-ascii?Q?jZyakZp1ajYiMVwQKRB0+ifBYqQ6vUo1wEDCabf5Rc5MWQVA+9EAhKTcanfN?=
 =?us-ascii?Q?LQ5ZOBjwq29WwpUUzOp+mEhoJlws8Kud43YqfYGvhLF9a0zcvIinfcK/KFZx?=
 =?us-ascii?Q?gtA9+PKudh/8CXHt9Eg0k4a5HPWiM+Y9jk28h4hVUNb5wjC4VkRcJMnxfOw9?=
 =?us-ascii?Q?A9sMgP70UvSLCZ9wXrvt6TyTYi/IVu9k87MGDoW+vvBgv3S1FNDFiXqWTJ/c?=
 =?us-ascii?Q?TCZ52VXUf3yTlCFe/c1DEMwWcm+0cj+ZeVdrf5jSmy/pQOhYF1BwDFxKtwBL?=
 =?us-ascii?Q?Ym/RYqq9K+hwkavzJ2MqaseiZ2fvWxAxVc+EkZoXYTP+A9yU0/ytmtnNHJQ9?=
 =?us-ascii?Q?PVN5GlXZuYg8se23KScq5QfoAkr1R1nYrJJVzFsvJKr+PNwMrlLPbi0IGr+7?=
 =?us-ascii?Q?8wYmPqGvR+rA15L7ib4QLQ9hrvjw+RYH5J8jOUC+buPaHcW5khMQNCWx8bPw?=
 =?us-ascii?Q?HcRX8AQtggBszvMGZzzwp1/t2AYktWGIZESsXFIyEWO1UJNgolFLeb4CjQ7N?=
 =?us-ascii?Q?cIbU+OLqUglTkvXh321XDZwqiqoklPtVUEeOuTie0ctlTtOGjos9I5JRZ2o3?=
 =?us-ascii?Q?6Gy1+SA1ZBjYDfqk+jwNKZ89RO2juy9xU3Y37L+tZWYGsQIN8bvgqD5VCSxo?=
 =?us-ascii?Q?ei4jXIf626dmGIyriYq7Lffjerfti/3tIldo2ADZg/snJksJp2lmL8jf8B/M?=
 =?us-ascii?Q?P6uBPFC3wZ1AymbQEuxG4GBv93RhYjEWkFqUE3issOjJ8h4BN2fKx595AD1R?=
 =?us-ascii?Q?KSYkuww1NT8cQhn1B9tbzjXfQfB+kagd+zi9PHtOQLfwr1ie3NXUWGhLzdRB?=
 =?us-ascii?Q?cCjQIeEkvPaP3yytCtWj4CsmnSdIjdASDCAeQ7y8R/ep0bi1VD5Fdj+VO47D?=
 =?us-ascii?Q?5zTsBrQHixVhkBMYp02Rm6BDElxiVsrLS+srt728GoTktc4JWlNxU6gYXxMu?=
 =?us-ascii?Q?w7ZXpUtbOD3izN1J6ZvqGJ+JGxv04A8r?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2024 14:08:04.9904 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0270ca49-bc9a-48b1-4713-08dca7330b12
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A104.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4296
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
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c | 36 ++++++++++++++++++++-------
 1 file changed, 27 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
index 78495df29b5c..3a819c6923c6 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -3742,7 +3742,7 @@ static int gfx_v9_0_kiq_init_queue(struct amdgpu_ring *ring)
 	return 0;
 }
 
-static int gfx_v9_0_kcq_init_queue(struct amdgpu_ring *ring)
+static int gfx_v9_0_kcq_init_queue(struct amdgpu_ring *ring, bool restore)
 {
 	struct amdgpu_device *adev = ring->adev;
 	struct v9_mqd *mqd = ring->mqd_ptr;
@@ -3754,8 +3754,8 @@ static int gfx_v9_0_kcq_init_queue(struct amdgpu_ring *ring)
 	 */
 	tmp_mqd = (struct v9_mqd *)adev->gfx.mec.mqd_backup[mqd_idx];
 
-	if (!tmp_mqd->cp_hqd_pq_control ||
-	    (!amdgpu_in_reset(adev) && !adev->in_suspend)) {
+	if (!restore && (!tmp_mqd->cp_hqd_pq_control ||
+	    (!amdgpu_in_reset(adev) && !adev->in_suspend))) {
 		memset((void *)mqd, 0, sizeof(struct v9_mqd_allocation));
 		((struct v9_mqd_allocation *)mqd)->dynamic_cu_mask = 0xFFFFFFFF;
 		((struct v9_mqd_allocation *)mqd)->dynamic_rb_mask = 0xFFFFFFFF;
@@ -3819,7 +3819,7 @@ static int gfx_v9_0_kcq_resume(struct amdgpu_device *adev)
 			goto done;
 		r = amdgpu_bo_kmap(ring->mqd_obj, (void **)&ring->mqd_ptr);
 		if (!r) {
-			r = gfx_v9_0_kcq_init_queue(ring);
+			r = gfx_v9_0_kcq_init_queue(ring, false);
 			amdgpu_bo_kunmap(ring->mqd_obj);
 			ring->mqd_ptr = NULL;
 		}
@@ -7129,11 +7129,29 @@ static int gfx_v9_0_reset_kcq(struct amdgpu_ring *ring,
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
+		r = gfx_v9_0_kcq_init_queue(ring, true);
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

