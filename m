Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C281BC761A6
	for <amd-gfx@archiver.kernel.org>; Mon, 27 Mar 2023 19:36:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 530C310E722;
	Mon, 27 Mar 2023 19:36:37 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2064.outbound.protection.outlook.com [40.107.237.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B669010E722
 for <amd-gfx@lists.freedesktop.org>; Mon, 27 Mar 2023 19:36:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jDy46IK2KMmeUcY7fJMTV+Utx36lQqgBqkf6J1vGu/y/3ScOJbRZmAGGC6ogdpVWfp6lW0BcxU3bJh+wrBUWEoV1j62vlTDUyG3vztveluhcp2/wpfsL9AZ1mTNooPx28ONeZebiDQpQ84NGcjo55n7ChDAcKmNJHsC6D3L6KG2o+NNAPd5+7vx2a1y3CmCN5TETYKSfS4/cp+YJy4xWFoQQCukyHGOMYsFq1rLLiPVZXiuWTYMhWhPnPkv/HdWeb0OB8pA5By+j1fmsJqIpVuUAZycIKuuK4OdFEfU0nNzY0zcSX/YgMlsG5M4kg/LZqfwaTHX+cAHyEsYMAZQysA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tK0onmJW0rqIgWGICEDNX3GkfF8gGGyH8vsB9bQbBbY=;
 b=Qu9jfsG+e0CkMNYkk/ntjhPCD6DyUU3K2hRZlIcg4hGnocsRB1lEK6PDFOh8jcOniyJdU9WM9ZOqHozjrZKgGFSKT8ty6bUnoEr5KSaqfDYfLX1wXs95VMgF/Vd4dfRXUv0n+ZLWaZ5W4p0cl3qQp/P1UAZOrzpyaqf5Ry32qYbVbdBSL7p/poJHuKCQkBw2i9NxTxqu4+rZVuMI5oR1IkJHkJrvFmv1fG0XYXINZYKaTUvDN7+QWESR4pp+SPrS3d8qgVKeJX56+SIqRWMTWBPCk+agM6skaPDNH1i2NyIOesofINd+Bcr899bAgxJkIyhMv8M/lwk/UFx/dyoa1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tK0onmJW0rqIgWGICEDNX3GkfF8gGGyH8vsB9bQbBbY=;
 b=lecvybACm5GFKep9o3KNl5r5Tac794UXDoc3gRDhbOH1hh8X56GfaSY4sAiLd7EoBS8eJAmpoVNuCfIFCm6OGrITXOoPDsYA+8BTZKr+CQXtJLaQs+u3KLBZERdu5DQRbSBeD0hkftyjGPZX1V1eLJf7UqQVP4/2JDvRU0HHv1A=
Received: from BN8PR15CA0063.namprd15.prod.outlook.com (2603:10b6:408:80::40)
 by DM4PR12MB6183.namprd12.prod.outlook.com (2603:10b6:8:a7::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.30; Mon, 27 Mar
 2023 19:36:29 +0000
Received: from BL02EPF000100D0.namprd05.prod.outlook.com
 (2603:10b6:408:80:cafe::73) by BN8PR15CA0063.outlook.office365.com
 (2603:10b6:408:80::40) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.41 via Frontend
 Transport; Mon, 27 Mar 2023 19:36:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF000100D0.mail.protection.outlook.com (10.167.241.204) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6178.30 via Frontend Transport; Mon, 27 Mar 2023 19:36:29 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 27 Mar
 2023 14:36:28 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 13/28] drm/amdgpu: add master/slave check in init phase
Date: Mon, 27 Mar 2023 15:35:47 -0400
Message-ID: <20230327193602.7901-13-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230327193602.7901-1-alexander.deucher@amd.com>
References: <20230327193602.7901-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF000100D0:EE_|DM4PR12MB6183:EE_
X-MS-Office365-Filtering-Correlation-Id: 17b0221f-1d24-42ba-31a6-08db2efa8ff4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zjLP5REtrhrnUWBDRa9g+9tDnuCPZCI7lPiKeaOdx0fmhgm/728eoyp1tCnIdpzVnIInZnxPnKgPHYL3+Vb9/56YBTUTg7RqJ8+9oY6wjoxEO34WOtN+o40Nb396nUC/Rkox+8Z4bVFJq2gvVk9Vw2VgPd9ez9hTyw26ifUdlJmQBvNMWkBxIkhhPSxH9/XsVcTLcK4ecgzvS9PIpjqE74P8kJ11Q6E3qU3hj0q0YrjSQJV7B01UiLoanVqLmRSstRX1Ss088Wdi6OslscLSly2gqfjFw2A/LnlG1gKGmDD449DW2vouxljlyU1LMRBxEIW7k5gakPFdsQoctpQk3hgsqRBhRKwTriIh6zPBM9Yhh/KQhihLj1nne56en+cwB2aPOZRpvn9uE9Blm0S/iRpjVcjAkzvO9E17KuLUgi7CAeb+WxXsp6eMa04hmxn06IRq3NuJ8vf9a8kmw0b1yzo0ZWBo8mh/JpZppZhdwKenlEZfwvalM5s0PhuZZ9tumvmfiJYxaNxvQ3gYOltpwrA1woIviS/FbEM1Fum8+JVNXUTV9CPXmnA3tHpqM3Faa78ReSFhYW70bB6tXrJjeVK9PNC1vqC7oaLqKUcITEE5D1pe7I9cyvlQ7WEdbQ0Kllu6hACjcgjW1dltriFm37HNYq3SCB4n3Uic6lsKwgpxpqR+G+u+cMDsIFOPk/AKz8Rz2Mem7mqnUHLInYcFQ9k4bnPemQi+2TxnF+8Re54=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(136003)(346002)(376002)(39860400002)(396003)(451199021)(46966006)(40470700004)(36840700001)(16526019)(26005)(426003)(1076003)(40480700001)(41300700001)(186003)(6666004)(7696005)(83380400001)(336012)(2616005)(47076005)(478600001)(54906003)(316002)(36860700001)(40460700003)(4326008)(70206006)(2906002)(70586007)(8676002)(6916009)(81166007)(82740400003)(356005)(36756003)(82310400005)(86362001)(5660300002)(8936002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2023 19:36:29.4435 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 17b0221f-1d24-42ba-31a6-08db2efa8ff4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF000100D0.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6183
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Le Ma <le.ma@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Le Ma <le.ma@amd.com>

Skip KCQ setup on slave xcc as there's no use case.

Signed-off-by: Le Ma <le.ma@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c | 59 +++++++++++++++----------
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h |  2 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c  |  5 +++
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c | 10 +++--
 4 files changed, 50 insertions(+), 26 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
index 7f5c60381103..c83fb4277233 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
@@ -489,16 +489,19 @@ int amdgpu_gfx_disable_kcq(struct amdgpu_device *adev, int xcc_id)
 		return -EINVAL;
 
 	spin_lock(&kiq->ring_lock);
-	if (amdgpu_ring_alloc(kiq_ring, kiq->pmf->unmap_queues_size *
-					adev->gfx.num_compute_rings)) {
-		spin_unlock(&adev->gfx.kiq[0].ring_lock);
-		return -ENOMEM;
-	}
+	if (amdgpu_gfx_is_master_xcc(adev, xcc_id)) {
+		if (amdgpu_ring_alloc(kiq_ring, kiq->pmf->unmap_queues_size *
+						adev->gfx.num_compute_rings)) {
+			spin_unlock(&kiq->ring_lock);
+			return -ENOMEM;
+		}
 
-	for (i = 0; i < adev->gfx.num_compute_rings; i++) {
-		j = i + xcc_id * adev->gfx.num_compute_rings;
-		kiq->pmf->kiq_unmap_queues(kiq_ring, &adev->gfx.compute_ring[i],
-					   RESET_QUEUES, 0, 0);
+		for (i = 0; i < adev->gfx.num_compute_rings; i++) {
+			j = i + xcc_id * adev->gfx.num_compute_rings;
+			kiq->pmf->kiq_unmap_queues(kiq_ring,
+						   &adev->gfx.compute_ring[i],
+						   RESET_QUEUES, 0, 0);
+		}
 	}
 
 	if (adev->gfx.kiq[0].ring.sched.ready && !adev->job_hang)
@@ -549,22 +552,26 @@ int amdgpu_gfx_enable_kcq(struct amdgpu_device *adev, int xcc_id)
 	DRM_INFO("kiq ring mec %d pipe %d q %d\n", kiq_ring->me, kiq_ring->pipe,
 							kiq_ring->queue);
 	spin_lock(&kiq->ring_lock);
-	r = amdgpu_ring_alloc(kiq_ring, kiq->pmf->map_queues_size *
-					adev->gfx.num_compute_rings +
-					kiq->pmf->set_resources_size);
-	if (r) {
-		DRM_ERROR("Failed to lock KIQ (%d).\n", r);
-		spin_unlock(&adev->gfx.kiq[0].ring_lock);
-		return r;
-	}
+	/* No need to map kcq on the slave */
+	if (amdgpu_gfx_is_master_xcc(adev, xcc_id)) {
+		r = amdgpu_ring_alloc(kiq_ring, kiq->pmf->map_queues_size *
+						adev->gfx.num_compute_rings +
+						kiq->pmf->set_resources_size);
+		if (r) {
+			DRM_ERROR("Failed to lock KIQ (%d).\n", r);
+			spin_unlock(&adev->gfx.kiq[0].ring_lock);
+			return r;
+		}
 
-	if (adev->enable_mes)
-		queue_mask = ~0ULL;
+		if (adev->enable_mes)
+			queue_mask = ~0ULL;
 
-	kiq->pmf->kiq_set_resources(kiq_ring, queue_mask);
-	for (i = 0; i < adev->gfx.num_compute_rings; i++) {
-		j = i + xcc_id * adev->gfx.num_compute_rings;
-		kiq->pmf->kiq_map_queues(kiq_ring, &adev->gfx.compute_ring[i]);
+		kiq->pmf->kiq_set_resources(kiq_ring, queue_mask);
+		for (i = 0; i < adev->gfx.num_compute_rings; i++) {
+			j = i + xcc_id * adev->gfx.num_compute_rings;
+			kiq->pmf->kiq_map_queues(kiq_ring,
+						 &adev->gfx.compute_ring[i]);
+		}
 	}
 
 	r = amdgpu_ring_test_helper(kiq_ring);
@@ -1078,3 +1085,9 @@ void amdgpu_gfx_cp_init_microcode(struct amdgpu_device *adev,
 		adev->firmware.fw_size += ALIGN(fw_size, PAGE_SIZE);
 	}
 }
+
+bool amdgpu_gfx_is_master_xcc(struct amdgpu_device *adev, int xcc_id)
+{
+	return !(xcc_id % (adev->gfx.num_xcc_per_xcp ?
+			adev->gfx.num_xcc_per_xcp : 1));
+}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
index 1f7010041431..4c5881a24f6f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
@@ -462,4 +462,6 @@ void amdgpu_gfx_cp_init_microcode(struct amdgpu_device *adev, uint32_t ucode_id)
 int amdgpu_gfx_ras_sw_init(struct amdgpu_device *adev);
 int amdgpu_gfx_poison_consumption_handler(struct amdgpu_device *adev,
 						struct amdgpu_iv_entry *entry);
+
+bool amdgpu_gfx_is_master_xcc(struct amdgpu_device *adev, int xcc_id);
 #endif
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
index 2b6fdcf3bf60..15fd61c202c8 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
@@ -407,6 +407,11 @@ int amdgpu_ib_ring_tests(struct amdgpu_device *adev)
 		else
 			tmo = tmo_gfx;
 
+		/* skip ib test on the slave kcq */
+		if (ring->funcs->type == AMDGPU_RING_TYPE_COMPUTE &&
+		    !amdgpu_gfx_is_master_xcc(adev, ring->xcc_id))
+			continue;
+
 		r = amdgpu_ring_test_ib(ring, tmo);
 		if (!r) {
 			DRM_DEV_DEBUG(adev->dev, "ib test on %s succeeded\n",
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
index 0e162189d860..b9b02fa15c7b 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
@@ -1886,9 +1886,13 @@ static int gfx_v9_4_3_cp_resume(struct amdgpu_device *adev)
 		if (r)
 			return r;
 
-		for (j = 0; j < adev->gfx.num_compute_rings; j++) {
-			ring = &adev->gfx.compute_ring[j + i * adev->gfx.num_compute_rings];
-			amdgpu_ring_test_helper(ring);
+		/* skip ring test on slave kcq */
+		if (amdgpu_gfx_is_master_xcc(adev, i)) {
+			for (j = 0; j < adev->gfx.num_compute_rings; j++) {
+				ring = &adev->gfx.compute_ring[j +
+					i * adev->gfx.num_compute_rings];
+				amdgpu_ring_test_helper(ring);
+			}
 		}
 
 		gfx_v9_4_3_enable_gui_idle_interrupt(adev, true, i);
-- 
2.39.2

