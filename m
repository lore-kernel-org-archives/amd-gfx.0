Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72D17C76196
	for <amd-gfx@archiver.kernel.org>; Tue, 28 Mar 2023 15:14:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A576310E48F;
	Tue, 28 Mar 2023 15:14:14 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2085.outbound.protection.outlook.com [40.107.94.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 77E8610E290
 for <amd-gfx@lists.freedesktop.org>; Tue, 28 Mar 2023 15:14:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V87hUuv9heohE5PtvcqCtcX4fiOlj1kfiCkMGGQe8ND/QPnsv82hZjprjm+KvNcGji+GiG6t8hpRk86xzouO+vZPbNiF3AUHkLOgVC73MxM3yD36p+jBa3HihOaZP2ONerDvJjIGzlrAMa/pOPdZnPcnPAEQSiIYmi2yNhWpdPlUs3kbJiW8shtt6Kz+fkanl9cd1OU/gyUwbqQ9NORwGqA2aJAgcXLBE2B8nzyJlyLBQ6Rs8FVRZoCY+D18TaJyFN96jfaRiqd/Y9uzJPMgrpXeS2ebUp8quYSZ3l4OSneaVjsxOvg9bpPg0QsPCyv9QikpOFBb/TYG8BQMyozoOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lAwYKdxYzNcNgcWVC+oHsRAk7i7lKv8HSO8x1EO/aOU=;
 b=ntP+KsWcZKCc/iy/NYvZH3Ch9XFlcK8yOw6FdTPC3nM2tbDtorHKD7lBNjiP4ZruO4KE0nqd//TZ+gaYbxPbSbFAZUfCyuRuTa2VqyFhYkRATKMte155gGOj6DE1oNP4UF/WfEa6n1UD8EgWfEwxhl6H360kyzK5EKrtWpXCi6jKBBBQDtypr0Jpez+HLkAv0g1z1ineCJN8KNA3qlSa7F1MLSubJ+6RPPoA5C/BwEP+9Tu9KeuP39DeOtcBd3/QLJknu+vjobCK5UrceITw1js1ACyufDdZsse54ntxGkYqv5qw7oSGk0JFyb3hrSeVe0UH747EZTRLK0wImFJ7Ww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lAwYKdxYzNcNgcWVC+oHsRAk7i7lKv8HSO8x1EO/aOU=;
 b=uvwICqsHvc231CwpT8ACBtxluQ/i2DtIupGNyo5fHSwVqEiVmeTQZpcjeHJPk46InrZ8Mk7fJ7p2TP8IEBz7DnM6zmc2y5335xHTB5L95ET4ybaPakyhZyWQgxjcVT4DrVhP8uCntyawE8uqYBWjS+P2Gv8RLncZZ7oZ4DyS0Ic=
Received: from BN9PR03CA0076.namprd03.prod.outlook.com (2603:10b6:408:fc::21)
 by MW5PR12MB5681.namprd12.prod.outlook.com (2603:10b6:303:19e::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.33; Tue, 28 Mar
 2023 15:14:10 +0000
Received: from BN8NAM11FT022.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:fc:cafe::5b) by BN9PR03CA0076.outlook.office365.com
 (2603:10b6:408:fc::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.43 via Frontend
 Transport; Tue, 28 Mar 2023 15:14:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT022.mail.protection.outlook.com (10.13.176.112) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6254.9 via Frontend Transport; Tue, 28 Mar 2023 15:14:10 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 28 Mar
 2023 10:14:05 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 02/32] drm/amdgpu: enable the ring and IB test for slave kcq
Date: Tue, 28 Mar 2023 11:13:14 -0400
Message-ID: <20230328151344.1934291-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230328151344.1934291-1-alexander.deucher@amd.com>
References: <20230328151344.1934291-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT022:EE_|MW5PR12MB5681:EE_
X-MS-Office365-Filtering-Correlation-Id: 82893b07-d697-4a57-a50a-08db2f9f152c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gdg6o9D+fstwVUHOIfM7wEVDRB4js9IrwZ4eYdXD9IuhbPLVH5D1zod98ZeADbNXuBiUhieiuv0f3SFbdpe81j0CZ3gu8GfhCYyc6Ji+ibXVINyLGsuny3dfVDNpV3NSDZ4B92tMlzYVYkiMQgbsnKkrXuQywASY+63zsyt+LoGt7tkJPNEGJaSHJCkRbF4iZeqpjWyarjygMYkPNOrXT2Qf+ovYtX98W92dhWXV4fin5MNyLtJI7VSzE+7XWemwPfX0eVJCSWln9LlsFl55TR7zGEZDOBY+lOVzPi+YooztBbvRabUQbPQFB6/1W6aMsXEg2ld3QFOE90wbc+oes8z0DMpAIKxkJgZD4xpL8AnCKwpAgY4mnajEgqiJ3NY2uHiCxGj/8p85TGJ65PmxO2ihI0CGdqsEV8U7n4zmF3L8P7A95jiKq5PHibgt/+MyDxz+4bUO6+hfJbuqzVkGT6UCuhIEqIEZc9lzPocf/ubOGIzx0dSLkQBCDUCQT3243LMZimZMHNbWUQIEMe4+gDlIH7bljGw4PCBULP44PZ4enhfoxfRfTmoq7TNnQ4lSHfya1wmFIAd+rwEOzTWNluzOJtCvbdN7ExN669pn6WCuIOZzqqC0KVry23eUjJn9kFKs3+f/dOLJpuTT+nFU7T+W2qXUiSAtjfkFd8SJdYdY5Lq88PQQJwNJN+X0ZaRieqgW0zDWb2ipSaAsCUZnaH4PcutFFykjM4ekRpKx4bE=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(136003)(396003)(346002)(39860400002)(376002)(451199021)(46966006)(36840700001)(40470700004)(7696005)(6666004)(26005)(1076003)(6916009)(478600001)(316002)(54906003)(186003)(36860700001)(47076005)(16526019)(70586007)(426003)(70206006)(336012)(8676002)(2616005)(83380400001)(41300700001)(81166007)(8936002)(4326008)(356005)(5660300002)(2906002)(82740400003)(40460700003)(86362001)(40480700001)(82310400005)(36756003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2023 15:14:10.4141 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 82893b07-d697-4a57-a50a-08db2f9f152c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT022.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR12MB5681
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Le Ma <Le.Ma@amd.com>,
 Shiwu Zhang <shiwu.zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Shiwu Zhang <shiwu.zhang@amd.com>

With the mec FW update to utilize the mqd base set by
driver for kcq mapping, slave kcq ring test and IB test
can be re-enabled.

Signed-off-by: Shiwu Zhang <shiwu.zhang@amd.com>
Reviewed-by: Le Ma <Le.Ma@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c | 61 ++++++++++++-------------
 drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c  |  5 --
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c | 12 ++---
 3 files changed, 33 insertions(+), 45 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
index 14ea9bbc3715..5ef6fbe354c9 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
@@ -442,7 +442,7 @@ int amdgpu_gfx_mqd_sw_init(struct amdgpu_device *adev,
 
 			/* prepare MQD backup */
 			adev->gfx.mec.mqd_backup[i + xcc_id * adev->gfx.num_compute_rings] = kmalloc(mqd_size, GFP_KERNEL);
-			if (!adev->gfx.mec.mqd_backup[i])
+			if (!adev->gfx.mec.mqd_backup[i + xcc_id * adev->gfx.num_compute_rings])
 				dev_warn(adev->dev, "no memory to create MQD backup for ring %s\n", ring->name);
 		}
 	}
@@ -468,8 +468,8 @@ void amdgpu_gfx_mqd_sw_fini(struct amdgpu_device *adev, int xcc_id)
 
 	for (i = 0; i < adev->gfx.num_compute_rings; i++) {
 		j = i + xcc_id * adev->gfx.num_compute_rings;
-		ring = &adev->gfx.compute_ring[i];
-		kfree(adev->gfx.mec.mqd_backup[i]);
+		ring = &adev->gfx.compute_ring[j];
+		kfree(adev->gfx.mec.mqd_backup[j]);
 		amdgpu_bo_free_kernel(&ring->mqd_obj,
 				      &ring->mqd_gpu_addr,
 				      &ring->mqd_ptr);
@@ -494,22 +494,20 @@ int amdgpu_gfx_disable_kcq(struct amdgpu_device *adev, int xcc_id)
 		return -EINVAL;
 
 	spin_lock(&kiq->ring_lock);
-	if (amdgpu_gfx_is_master_xcc(adev, xcc_id)) {
-		if (amdgpu_ring_alloc(kiq_ring, kiq->pmf->unmap_queues_size *
-						adev->gfx.num_compute_rings)) {
-			spin_unlock(&kiq->ring_lock);
-			return -ENOMEM;
-		}
+	if (amdgpu_ring_alloc(kiq_ring, kiq->pmf->unmap_queues_size *
+					adev->gfx.num_compute_rings)) {
+		spin_unlock(&kiq->ring_lock);
+		return -ENOMEM;
+	}
 
-		for (i = 0; i < adev->gfx.num_compute_rings; i++) {
-			j = i + xcc_id * adev->gfx.num_compute_rings;
-			kiq->pmf->kiq_unmap_queues(kiq_ring,
-						   &adev->gfx.compute_ring[i],
-						   RESET_QUEUES, 0, 0);
-		}
+	for (i = 0; i < adev->gfx.num_compute_rings; i++) {
+		j = i + xcc_id * adev->gfx.num_compute_rings;
+		kiq->pmf->kiq_unmap_queues(kiq_ring,
+					   &adev->gfx.compute_ring[i],
+					   RESET_QUEUES, 0, 0);
 	}
 
-	if (adev->gfx.kiq[0].ring.sched.ready && !adev->job_hang)
+	if (kiq_ring->sched.ready && !adev->job_hang)
 		r = amdgpu_ring_test_helper(kiq_ring);
 	spin_unlock(&kiq->ring_lock);
 
@@ -557,26 +555,23 @@ int amdgpu_gfx_enable_kcq(struct amdgpu_device *adev, int xcc_id)
 	DRM_INFO("kiq ring mec %d pipe %d q %d\n", kiq_ring->me, kiq_ring->pipe,
 							kiq_ring->queue);
 	spin_lock(&kiq->ring_lock);
-	/* No need to map kcq on the slave */
-	if (amdgpu_gfx_is_master_xcc(adev, xcc_id)) {
-		r = amdgpu_ring_alloc(kiq_ring, kiq->pmf->map_queues_size *
-						adev->gfx.num_compute_rings +
-						kiq->pmf->set_resources_size);
-		if (r) {
-			DRM_ERROR("Failed to lock KIQ (%d).\n", r);
-			spin_unlock(&adev->gfx.kiq[0].ring_lock);
-			return r;
-		}
+	r = amdgpu_ring_alloc(kiq_ring, kiq->pmf->map_queues_size *
+					adev->gfx.num_compute_rings +
+					kiq->pmf->set_resources_size);
+	if (r) {
+		DRM_ERROR("Failed to lock KIQ (%d).\n", r);
+		spin_unlock(&kiq->ring_lock);
+		return r;
+	}
 
-		if (adev->enable_mes)
-			queue_mask = ~0ULL;
+	if (adev->enable_mes)
+		queue_mask = ~0ULL;
 
-		kiq->pmf->kiq_set_resources(kiq_ring, queue_mask);
-		for (i = 0; i < adev->gfx.num_compute_rings; i++) {
-			j = i + xcc_id * adev->gfx.num_compute_rings;
+	kiq->pmf->kiq_set_resources(kiq_ring, queue_mask);
+	for (i = 0; i < adev->gfx.num_compute_rings; i++) {
+		j = i + xcc_id * adev->gfx.num_compute_rings;
 			kiq->pmf->kiq_map_queues(kiq_ring,
-						 &adev->gfx.compute_ring[i]);
-		}
+						 &adev->gfx.compute_ring[j]);
 	}
 
 	r = amdgpu_ring_test_helper(kiq_ring);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
index 15fd61c202c8..2b6fdcf3bf60 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
@@ -407,11 +407,6 @@ int amdgpu_ib_ring_tests(struct amdgpu_device *adev)
 		else
 			tmo = tmo_gfx;
 
-		/* skip ib test on the slave kcq */
-		if (ring->funcs->type == AMDGPU_RING_TYPE_COMPUTE &&
-		    !amdgpu_gfx_is_master_xcc(adev, ring->xcc_id))
-			continue;
-
 		r = amdgpu_ring_test_ib(ring, tmo);
 		if (!r) {
 			DRM_DEV_DEBUG(adev->dev, "ib test on %s succeeded\n",
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
index 351bc16b95ae..5cc4c2c31b3a 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
@@ -1962,13 +1962,11 @@ static int gfx_v9_4_3_cp_resume(struct amdgpu_device *adev)
 		if (r)
 			return r;
 
-		/* skip ring test on slave kcq */
-		if (amdgpu_gfx_is_master_xcc(adev, i)) {
-			for (j = 0; j < adev->gfx.num_compute_rings; j++) {
-				ring = &adev->gfx.compute_ring[j +
-					i * adev->gfx.num_compute_rings];
-				amdgpu_ring_test_helper(ring);
-			}
+		for (j = 0; j < adev->gfx.num_compute_rings; j++) {
+			ring = &adev->gfx.compute_ring[j + i * adev->gfx.num_compute_rings];
+			r = amdgpu_ring_test_helper(ring);
+			if (r)
+				return r;
 		}
 
 		gfx_v9_4_3_enable_gui_idle_interrupt(adev, true, i);
-- 
2.39.2

