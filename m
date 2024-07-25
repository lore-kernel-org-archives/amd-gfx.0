Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6448C49EA1
	for <amd-gfx@archiver.kernel.org>; Thu, 25 Jul 2024 15:01:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 84CE510E852;
	Thu, 25 Jul 2024 15:01:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="PnoQkplF";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2060.outbound.protection.outlook.com [40.107.243.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3A66110E849
 for <amd-gfx@lists.freedesktop.org>; Thu, 25 Jul 2024 15:01:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xxiTOgOYpodXm5v7tAcZk8VRA1nTtPkxgJ97QBvF8vP+vSafOA/TCv2wwiwS01RjmT0H7rBK7wYTmZPF1/DmiSi5MsPW2ZaipTlCBwDZRxR2EN6MVn8HuN/XhRd3Tm0PxPwB70q4jf9H0BtDPe+PHp1GoTTkdY0pTGFtM0LD6hz7zVE4rSFKIhhlyrMNSx5kcHWHYIsql9wiRPLn4tVbY2sd5Ozkx8jWw8MnKfxN2ZtX8NGKfgwAQFXjyvuMP8E4I4Ii8hgEFAR0CFd4qcvfoKhxNmh/+p1LHEelA5ul0OL4OOPrjrIo1umeyldsbF9bX7Jf+boEvkEFmL66xbCWQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V5U9aT+ukHuT3d2CIc61CO4UVKZCTSFtLbtdRnz4Cqk=;
 b=SIIFhxYdsSAQrGVo6gYgIfXzISoG/krJjTDWaED7fNfoa5LeqT5EjdMKBG5ZHs2Gowh+493MfFnG9zdxbeK6IHXNq/7tv+rdsuWFZlISD2OJLvWyP3Bopfz6FaJCXy9hBHPzCWf1aoKL2X77xOnhNmUhgMVa9Ls0Jyo5mn8y0xYtTA4u0FcLD7wjGhadH1qYYuPYaP7HgWs3fOHpa9MnmZDX1mIdw2SMMuP6UqvLBM4Fo855mAdkqs39O1/AjfWun6r0zsDRZdfZDdIyzyXWEWDcxwgUAUifR8KZaVVjb7fCeMzC8wE+43f0B7kRsx/sJ125Uol/ggnahEBLCvU5eA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V5U9aT+ukHuT3d2CIc61CO4UVKZCTSFtLbtdRnz4Cqk=;
 b=PnoQkplFF+1GM14/VWaIThsqKeKw+fOgVE/W7cAO0yp0X/vvWLygrKqv41kFCm1Ni9pG7AIXnzQPA9ArFqnNK57gLSb8Oiy2xmSSfYqjE2DAgbeq2KRjAPyLA41JzsSDf77E/WpA2vprVaLEUKUJyzszORGCiJoRTZtURkEbaKA=
Received: from CYZPR10CA0017.namprd10.prod.outlook.com (2603:10b6:930:8a::17)
 by SJ0PR12MB8167.namprd12.prod.outlook.com (2603:10b6:a03:4e6::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.16; Thu, 25 Jul
 2024 15:01:24 +0000
Received: from CY4PEPF0000E9D4.namprd03.prod.outlook.com
 (2603:10b6:930:8a:cafe::1f) by CYZPR10CA0017.outlook.office365.com
 (2603:10b6:930:8a::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.29 via Frontend
 Transport; Thu, 25 Jul 2024 15:01:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9D4.mail.protection.outlook.com (10.167.241.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7784.11 via Frontend Transport; Thu, 25 Jul 2024 15:01:23 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 25 Jul
 2024 10:01:19 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Jiadong Zhu <Jiadong.Zhu@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 21/53] drm/amdgpu/gfx9: remap queue after reset successfully
Date: Thu, 25 Jul 2024 11:00:23 -0400
Message-ID: <20240725150055.1991893-22-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240725150055.1991893-1-alexander.deucher@amd.com>
References: <20240725150055.1991893-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D4:EE_|SJ0PR12MB8167:EE_
X-MS-Office365-Filtering-Correlation-Id: 7a69cf50-ac12-4d72-8379-08dcacbaa69b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Jlnlw1+VQtBUQ8Qx28+TbjitGVOnM3m0CJxcb++FnlVKM5rY1s7qwRlCXm2+?=
 =?us-ascii?Q?X2Y9S6gNgfGeiLuUF8x0LkprWTIREZo6dgY2HvYCv/EWNzSvp99ckc2M2HdD?=
 =?us-ascii?Q?L9KQhFW8OOcjC9cIvCx1lKABanbl1fjr9Xm7KYe2XY/OL3+kTy3itYqJpdVe?=
 =?us-ascii?Q?v32fVXlbvTE540hzMazbyAj1/QbjZHq7KSTAXDse1c0xIQ1OXTlOSEu6PKbh?=
 =?us-ascii?Q?uM2z/IQ/cs6Snn+/SL/H5Q0CzGqJ8t97J0KxwVzCe47uR1AqY2PQiS3BJQjm?=
 =?us-ascii?Q?v9n0ymBQrZkfwLjbRlrultt1WnOgOaWWaJa/gGrTrnulsCUH6ARM+gO0KqH9?=
 =?us-ascii?Q?PEY5hXKfpkX39RKz6HNWVadI7yhLOuHXm7nCxAwex8JI+EBZWEIntX4GEuaK?=
 =?us-ascii?Q?uNK5hs/rSIbw47MLVjNGkICAwx8XxMhwTukWIe/17HEA4EH5cpQPLWKY3121?=
 =?us-ascii?Q?0JdoEFN/GFUQ9YuSlT4moPMtLCtBZBi14Lg0TFzWSQX5ZmVdu13Cmq3oMyOE?=
 =?us-ascii?Q?xHDzyCb7KaXy3kMegrGa7e31o+w7mteLHi54Po76o0PqBbOAz6fSNxkEBzCH?=
 =?us-ascii?Q?sxuskXfMiv3C2/Ur1VUevbGETkfOVOP30fgxmw5RTM8nBS+B2IREjB7+N5J0?=
 =?us-ascii?Q?I9QZN5XYnUNplcDiz451D5JzHrs2nG+wHTWowum3rR8qPPxN0QaGv/JETNTR?=
 =?us-ascii?Q?lxXzT7n/ODLiZNDZHrOWGkGLmC9FsFKphneiex6OG5aHCLB9EmAPkX/YW3bP?=
 =?us-ascii?Q?ZxQa8Uf0ZYUX+X+0CCrUJ0AcH7GktAm5kHXXl1yRYz+Wl3bs6Ot66ijObOA1?=
 =?us-ascii?Q?LP3j7SN37MijCFLQ3WfdOB2f8duCzgeb+A1XC9t0UCLGBMcCZ9nK8zda9Ybu?=
 =?us-ascii?Q?+l3XGP86eA2jWGnDDMgtQ5x4Cwy6zo2DLGlmVHaL+dCQqif4TsQp7q0sLkXm?=
 =?us-ascii?Q?34xvceW5wCPcrSQ0zY2ePgjuQWAquyAdx0TFnJynBHUXgESHwQtoCMH1VyHB?=
 =?us-ascii?Q?+B7WatVyEeq57yUJhVPsv3vGVnKa/UrIbXrJaMErmQRsarugmzIKWhgtIEN6?=
 =?us-ascii?Q?EUTiXYSQ1S9dafvSIHlNSb6USMU2jhZKk33PP6vJLu8pFyuK5Y9PC708fZA3?=
 =?us-ascii?Q?dCOgaY/l0EfF2o6FDz+A610igwt9WOyVNqEY7lzhOoHtzY+HE8rwpgrbPMst?=
 =?us-ascii?Q?5Z+zAfJT85G80H2lHMND85wtCG9+hjvYAWsMj5+hWf52C0MVm8o05mtb2MJm?=
 =?us-ascii?Q?0MuCacQtVUobwaIf0JrLQXvtSRNuMqr0ZTx6s4rCZNqCxfJX0VtTyNqnJI/Y?=
 =?us-ascii?Q?5KRban2bpMZgtCKeiTsmWpmc208946H2nvyXwLkPWrKsjr5gZdH0U+gh4N/Q?=
 =?us-ascii?Q?rityVneFRLCAwSf7kxmmzZf8jWdkPLJDhYk4WMG4WKMsSAKbyNXXuUzY6YJJ?=
 =?us-ascii?Q?Jy+9NDI2s7DrfnUdBpaB9HE+VbrqQw5p?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2024 15:01:23.7465 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a69cf50-ac12-4d72-8379-08dcacbaa69b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9D4.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB8167
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

