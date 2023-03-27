Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3D96C761A6
	for <amd-gfx@archiver.kernel.org>; Mon, 27 Mar 2023 19:36:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7E99A10E721;
	Mon, 27 Mar 2023 19:36:30 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2072.outbound.protection.outlook.com [40.107.223.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CE18410E714
 for <amd-gfx@lists.freedesktop.org>; Mon, 27 Mar 2023 19:36:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RjVvMP/qSXytJEwpdmmV/agu874Qe2lezRjM9h8ywi4/yg/gM5AYOiJvc58Pkg8kivmsolx4y1S7VUf/krSbriHir9yuywVEZjrhSrfZj6bbfxWrgKtuy7WNYjjtln/VU67Vr1G4lnxWATXuCmVaZuoQHmz4cZ5aUAUPeG2NPPiAWAPtHA8L7pu4KwEWo+GiTAO80HFMZKMk4TGPhS9Z8xFqPPgfq+q+XyUEGyv/C8E6+CJ9dJnjOREFhS8/hY9drSnmfrkTZEdzWr1bdfOp8hY25530sRdiibbfTtu7Eoh/sGNiMcRVYAaFhalzH1+d4GuK29mdIz79+M/1jmqpow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DVrkYkBYx8WK+cWif1Nk6RS7Kql9vFkTXhF221Gipx0=;
 b=BZyifNj0RmS/GcrA+xcdroSU4HHcpKp3oJXodkoRfoVhQGc0QxKGUZcp3d6llibTuaEP73u+7pZ4XOTfiUcompF1u+kN7fYOvuFhck00QS7riTor2q1TE2GyD73Z2YKlA07l6si3MhNGRrBFB5PEGj6bYushNf7wEPi2spKFoGN2F9qM2kKyfnBdAT7JjEImBpVV3CLUTixnxfkKI1M4oWIgQAy5QPSw7jEwFvH0un2d1S5xSUbKrsZwynhUYqEUT/Bj0WsKffQekf7p3nqWxZ2SXTTkRibd86dkluJgTf9G2Qq5+a8VPuPtlra2PoZ9FnhhaP4P93kwSJYT7UIXdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DVrkYkBYx8WK+cWif1Nk6RS7Kql9vFkTXhF221Gipx0=;
 b=wTIRhEJdakuu4sxIm1ofMdrlu9OzxSjWHVMlW4yLl2a7kEKoYOQq6jPLnafD3e1iyTXwvIn11bmU5yFfKkQkYfrsNYeYvTYqWyFKcmzsgl4OTHJh0IKZgVaOORiUjE2PS1/K1XR77Id7k3EDiJHInFEANDr5iSvpqMw9DEh+W5Y=
Received: from BN8PR15CA0046.namprd15.prod.outlook.com (2603:10b6:408:80::23)
 by CY8PR12MB7684.namprd12.prod.outlook.com (2603:10b6:930:87::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.41; Mon, 27 Mar
 2023 19:36:23 +0000
Received: from BL02EPF000100D0.namprd05.prod.outlook.com
 (2603:10b6:408:80:cafe::47) by BN8PR15CA0046.outlook.office365.com
 (2603:10b6:408:80::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.42 via Frontend
 Transport; Mon, 27 Mar 2023 19:36:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF000100D0.mail.protection.outlook.com (10.167.241.204) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6178.30 via Frontend Transport; Mon, 27 Mar 2023 19:36:23 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 27 Mar
 2023 14:36:22 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 06/28] drm/amdgpu: add multi-xcc support to amdgpu_gfx
 interfaces (v4)
Date: Mon, 27 Mar 2023 15:35:40 -0400
Message-ID: <20230327193602.7901-6-alexander.deucher@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF000100D0:EE_|CY8PR12MB7684:EE_
X-MS-Office365-Filtering-Correlation-Id: 2930be07-06d1-47cf-d21c-08db2efa8c48
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: k9xdorKcjR33LiEsevsgDhUmXGz7Xpv99qseMCIGnnS3R26tL85FFS59sjsyKoKSLlwTULHeKNPc/JHo/SGihIBOlvBRr8vQX3Wj97EE2eCUvMupPRVJHDN72xOayU4ahhG9R11uFgtRlSxaqWrFE4xqBhuJFKhEdtthjTXbTdWJkSNsbnAA/AgUIx1TssX69kMgjmsqzqX2Qm5XRmQrheSMEmk5rhGG32johF/+asvRgGNkXhuNDFyOQIgdjm80xFKdJ/RKaFiyCV1jRAr57IOt3mDhzEAaeHV2qe/0do+mPI+hQjfJsJZkeb/w+xcrf9Qdhcnf7BjyjxMjKUecbTRKMR8O9PJlYBxnXL/IaqkhnaI76XROmydQMn+uk5jWarakZgjzHrl8WamiafY2/M3kEOOzZ8gmCeYbpvcbXtEx+Koom/bOsSvixaJ9Th9bJ/DUGkNtOn2kCzvo9IPtlZxi2ccrdiAozR2tDTVDVPrTtMCAI10ATprHww/bjUKNmooVeZxbG9ICPaYAKpxerC4PfscBMl7vuL804pz/1Onw4m8WFb6QbcId0aVZJzJb1gzAfryuUoSgvU32W8r5ruOyLDNMJNU6UnK82u9VGiXVm4rDkCEGfEGedvpTo5GsMiukmjoirVbGbxz8CzJqe670gHBG9eY9tYH0prNT5YKyveCDlIpIUT9vUXQlaGu6lMydsvVja3O+BySzqy4HhZfHEzJ0EiFdFkTJKl6VXEw=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(39860400002)(136003)(376002)(346002)(451199021)(46966006)(36840700001)(40470700004)(70586007)(6666004)(2616005)(356005)(7696005)(40460700003)(86362001)(426003)(40480700001)(47076005)(8676002)(82310400005)(316002)(82740400003)(41300700001)(186003)(54906003)(70206006)(36756003)(478600001)(16526019)(36860700001)(336012)(83380400001)(26005)(6916009)(4326008)(2906002)(30864003)(8936002)(5660300002)(81166007)(1076003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2023 19:36:23.2872 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2930be07-06d1-47cf-d21c-08db2efa8c48
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF000100D0.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7684
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

v1: Modify kiq_init/fini, mqd_sw_init/fini and
enable/disable_kcq to adapt to multi-die case.
Pass 0 as default to all asics with single xcc (Le)
v2: squash commits to avoid breaking the build (Le)
v3: unify naming style (Le)
v4: apply the changes to gc v11_0 (Hawking)

Signed-off-by: Le Ma <le.ma@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c | 75 ++++++++++++++-----------
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h | 16 +++---
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c  | 23 ++++----
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c  | 23 ++++----
 drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c   | 19 +++----
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c   | 25 ++++-----
 6 files changed, 93 insertions(+), 88 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
index b300b1784210..7f5c60381103 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
@@ -267,7 +267,7 @@ void amdgpu_gfx_graphics_queue_acquire(struct amdgpu_device *adev)
 }
 
 static int amdgpu_gfx_kiq_acquire(struct amdgpu_device *adev,
-				  struct amdgpu_ring *ring)
+				  struct amdgpu_ring *ring, int xcc_id)
 {
 	int queue_bit;
 	int mec, pipe, queue;
@@ -277,7 +277,7 @@ static int amdgpu_gfx_kiq_acquire(struct amdgpu_device *adev,
 		    * adev->gfx.mec.num_queue_per_pipe;
 
 	while (--queue_bit >= 0) {
-		if (test_bit(queue_bit, adev->gfx.mec_bitmap[0].queue_bitmap))
+		if (test_bit(queue_bit, adev->gfx.mec_bitmap[xcc_id].queue_bitmap))
 			continue;
 
 		amdgpu_queue_mask_bit_to_mec_queue(adev, queue_bit, &mec, &pipe, &queue);
@@ -303,9 +303,9 @@ static int amdgpu_gfx_kiq_acquire(struct amdgpu_device *adev,
 
 int amdgpu_gfx_kiq_init_ring(struct amdgpu_device *adev,
 			     struct amdgpu_ring *ring,
-			     struct amdgpu_irq_src *irq)
+			     struct amdgpu_irq_src *irq, int xcc_id)
 {
-	struct amdgpu_kiq *kiq = &adev->gfx.kiq[0];
+	struct amdgpu_kiq *kiq = &adev->gfx.kiq[xcc_id];
 	int r = 0;
 
 	spin_lock_init(&kiq->ring_lock);
@@ -314,15 +314,16 @@ int amdgpu_gfx_kiq_init_ring(struct amdgpu_device *adev,
 	ring->ring_obj = NULL;
 	ring->use_doorbell = true;
 	ring->doorbell_index = adev->doorbell_index.kiq;
+	ring->xcc_id = xcc_id;
 	ring->vm_hub = AMDGPU_GFXHUB_0;
 
-	r = amdgpu_gfx_kiq_acquire(adev, ring);
+	r = amdgpu_gfx_kiq_acquire(adev, ring, xcc_id);
 	if (r)
 		return r;
 
 	ring->eop_gpu_addr = kiq->eop_gpu_addr;
 	ring->no_scheduler = true;
-	sprintf(ring->name, "kiq_%d.%d.%d", ring->me, ring->pipe, ring->queue);
+	sprintf(ring->name, "kiq_%d.%d.%d.%d", xcc_id, ring->me, ring->pipe, ring->queue);
 	r = amdgpu_ring_init(adev, ring, 1024, irq, AMDGPU_CP_KIQ_IRQ_DRIVER0,
 			     AMDGPU_RING_PRIO_DEFAULT, NULL);
 	if (r)
@@ -336,19 +337,19 @@ void amdgpu_gfx_kiq_free_ring(struct amdgpu_ring *ring)
 	amdgpu_ring_fini(ring);
 }
 
-void amdgpu_gfx_kiq_fini(struct amdgpu_device *adev)
+void amdgpu_gfx_kiq_fini(struct amdgpu_device *adev, int xcc_id)
 {
-	struct amdgpu_kiq *kiq = &adev->gfx.kiq[0];
+	struct amdgpu_kiq *kiq = &adev->gfx.kiq[xcc_id];
 
 	amdgpu_bo_free_kernel(&kiq->eop_obj, &kiq->eop_gpu_addr, NULL);
 }
 
 int amdgpu_gfx_kiq_init(struct amdgpu_device *adev,
-			unsigned hpd_size)
+			unsigned hpd_size, int xcc_id)
 {
 	int r;
 	u32 *hpd;
-	struct amdgpu_kiq *kiq = &adev->gfx.kiq[0];
+	struct amdgpu_kiq *kiq = &adev->gfx.kiq[xcc_id];
 
 	r = amdgpu_bo_create_kernel(adev, hpd_size, PAGE_SIZE,
 				    AMDGPU_GEM_DOMAIN_GTT, &kiq->eop_obj,
@@ -371,13 +372,13 @@ int amdgpu_gfx_kiq_init(struct amdgpu_device *adev,
 
 /* create MQD for each compute/gfx queue */
 int amdgpu_gfx_mqd_sw_init(struct amdgpu_device *adev,
-			   unsigned mqd_size)
+			   unsigned mqd_size, int xcc_id)
 {
-	struct amdgpu_ring *ring = NULL;
 	int r, i;
+	struct amdgpu_kiq *kiq = &adev->gfx.kiq[xcc_id];
+	struct amdgpu_ring *ring = &kiq->ring;
 
 	/* create MQD for KIQ */
-	ring = &adev->gfx.kiq[0].ring;
 	if (!adev->enable_mes_kiq && !ring->mqd_obj) {
 		/* originaly the KIQ MQD is put in GTT domain, but for SRIOV VRAM domain is a must
 		 * otherwise hypervisor trigger SAVE_VF fail after driver unloaded which mean MQD
@@ -396,8 +397,8 @@ int amdgpu_gfx_mqd_sw_init(struct amdgpu_device *adev,
 		}
 
 		/* prepare MQD backup */
-		adev->gfx.mec.mqd_backup[AMDGPU_MAX_COMPUTE_RINGS] = kmalloc(mqd_size, GFP_KERNEL);
-		if (!adev->gfx.mec.mqd_backup[AMDGPU_MAX_COMPUTE_RINGS])
+		kiq->mqd_backup = kmalloc(mqd_size, GFP_KERNEL);
+		if (!kiq->mqd_backup)
 				dev_warn(adev->dev, "no memory to create MQD backup for ring %s\n", ring->name);
 	}
 
@@ -424,7 +425,7 @@ int amdgpu_gfx_mqd_sw_init(struct amdgpu_device *adev,
 
 	/* create MQD for each KCQ */
 	for (i = 0; i < adev->gfx.num_compute_rings; i++) {
-		ring = &adev->gfx.compute_ring[i];
+		ring = &adev->gfx.compute_ring[i + xcc_id * adev->gfx.num_compute_rings];
 		if (!ring->mqd_obj) {
 			r = amdgpu_bo_create_kernel(adev, mqd_size, PAGE_SIZE,
 						    AMDGPU_GEM_DOMAIN_GTT, &ring->mqd_obj,
@@ -435,7 +436,7 @@ int amdgpu_gfx_mqd_sw_init(struct amdgpu_device *adev,
 			}
 
 			/* prepare MQD backup */
-			adev->gfx.mec.mqd_backup[i] = kmalloc(mqd_size, GFP_KERNEL);
+			adev->gfx.mec.mqd_backup[i + xcc_id * adev->gfx.num_compute_rings] = kmalloc(mqd_size, GFP_KERNEL);
 			if (!adev->gfx.mec.mqd_backup[i])
 				dev_warn(adev->dev, "no memory to create MQD backup for ring %s\n", ring->name);
 		}
@@ -444,10 +445,11 @@ int amdgpu_gfx_mqd_sw_init(struct amdgpu_device *adev,
 	return 0;
 }
 
-void amdgpu_gfx_mqd_sw_fini(struct amdgpu_device *adev)
+void amdgpu_gfx_mqd_sw_fini(struct amdgpu_device *adev, int xcc_id)
 {
 	struct amdgpu_ring *ring = NULL;
-	int i;
+	int i, j;
+	struct amdgpu_kiq *kiq = &adev->gfx.kiq[xcc_id];
 
 	if (adev->asic_type >= CHIP_NAVI10 && amdgpu_async_gfx_ring) {
 		for (i = 0; i < adev->gfx.num_gfx_rings; i++) {
@@ -460,6 +462,7 @@ void amdgpu_gfx_mqd_sw_fini(struct amdgpu_device *adev)
 	}
 
 	for (i = 0; i < adev->gfx.num_compute_rings; i++) {
+		j = i + xcc_id * adev->gfx.num_compute_rings;
 		ring = &adev->gfx.compute_ring[i];
 		kfree(adev->gfx.mec.mqd_backup[i]);
 		amdgpu_bo_free_kernel(&ring->mqd_obj,
@@ -467,36 +470,40 @@ void amdgpu_gfx_mqd_sw_fini(struct amdgpu_device *adev)
 				      &ring->mqd_ptr);
 	}
 
-	ring = &adev->gfx.kiq[0].ring;
+	ring = &kiq->ring;
+	kfree(kiq->mqd_backup);
 	kfree(adev->gfx.mec.mqd_backup[AMDGPU_MAX_COMPUTE_RINGS]);
 	amdgpu_bo_free_kernel(&ring->mqd_obj,
 			      &ring->mqd_gpu_addr,
 			      &ring->mqd_ptr);
 }
 
-int amdgpu_gfx_disable_kcq(struct amdgpu_device *adev)
+int amdgpu_gfx_disable_kcq(struct amdgpu_device *adev, int xcc_id)
 {
-	struct amdgpu_kiq *kiq = &adev->gfx.kiq[0];
+	struct amdgpu_kiq *kiq = &adev->gfx.kiq[xcc_id];
 	struct amdgpu_ring *kiq_ring = &kiq->ring;
 	int i, r = 0;
+	int j;
 
 	if (!kiq->pmf || !kiq->pmf->kiq_unmap_queues)
 		return -EINVAL;
 
-	spin_lock(&adev->gfx.kiq[0].ring_lock);
+	spin_lock(&kiq->ring_lock);
 	if (amdgpu_ring_alloc(kiq_ring, kiq->pmf->unmap_queues_size *
 					adev->gfx.num_compute_rings)) {
 		spin_unlock(&adev->gfx.kiq[0].ring_lock);
 		return -ENOMEM;
 	}
 
-	for (i = 0; i < adev->gfx.num_compute_rings; i++)
+	for (i = 0; i < adev->gfx.num_compute_rings; i++) {
+		j = i + xcc_id * adev->gfx.num_compute_rings;
 		kiq->pmf->kiq_unmap_queues(kiq_ring, &adev->gfx.compute_ring[i],
 					   RESET_QUEUES, 0, 0);
+	}
 
 	if (adev->gfx.kiq[0].ring.sched.ready && !adev->job_hang)
 		r = amdgpu_ring_test_helper(kiq_ring);
-	spin_unlock(&adev->gfx.kiq[0].ring_lock);
+	spin_unlock(&kiq->ring_lock);
 
 	return r;
 }
@@ -514,18 +521,18 @@ int amdgpu_queue_mask_bit_to_set_resource_bit(struct amdgpu_device *adev,
 	return set_resource_bit;
 }
 
-int amdgpu_gfx_enable_kcq(struct amdgpu_device *adev)
+int amdgpu_gfx_enable_kcq(struct amdgpu_device *adev, int xcc_id)
 {
-	struct amdgpu_kiq *kiq = &adev->gfx.kiq[0];
-	struct amdgpu_ring *kiq_ring = &adev->gfx.kiq[0].ring;
+	struct amdgpu_kiq *kiq = &adev->gfx.kiq[xcc_id];
+	struct amdgpu_ring *kiq_ring = &kiq->ring;
 	uint64_t queue_mask = 0;
-	int r, i;
+	int r, i, j;
 
 	if (!kiq->pmf || !kiq->pmf->kiq_map_queues || !kiq->pmf->kiq_set_resources)
 		return -EINVAL;
 
 	for (i = 0; i < AMDGPU_MAX_COMPUTE_QUEUES; ++i) {
-		if (!test_bit(i, adev->gfx.mec_bitmap[0].queue_bitmap))
+		if (!test_bit(i, adev->gfx.mec_bitmap[xcc_id].queue_bitmap))
 			continue;
 
 		/* This situation may be hit in the future if a new HW
@@ -541,7 +548,7 @@ int amdgpu_gfx_enable_kcq(struct amdgpu_device *adev)
 
 	DRM_INFO("kiq ring mec %d pipe %d q %d\n", kiq_ring->me, kiq_ring->pipe,
 							kiq_ring->queue);
-	spin_lock(&adev->gfx.kiq[0].ring_lock);
+	spin_lock(&kiq->ring_lock);
 	r = amdgpu_ring_alloc(kiq_ring, kiq->pmf->map_queues_size *
 					adev->gfx.num_compute_rings +
 					kiq->pmf->set_resources_size);
@@ -555,11 +562,13 @@ int amdgpu_gfx_enable_kcq(struct amdgpu_device *adev)
 		queue_mask = ~0ULL;
 
 	kiq->pmf->kiq_set_resources(kiq_ring, queue_mask);
-	for (i = 0; i < adev->gfx.num_compute_rings; i++)
+	for (i = 0; i < adev->gfx.num_compute_rings; i++) {
+		j = i + xcc_id * adev->gfx.num_compute_rings;
 		kiq->pmf->kiq_map_queues(kiq_ring, &adev->gfx.compute_ring[i]);
+	}
 
 	r = amdgpu_ring_test_helper(kiq_ring);
-	spin_unlock(&adev->gfx.kiq[0].ring_lock);
+	spin_unlock(&kiq->ring_lock);
 	if (r)
 		DRM_ERROR("KCQ enable failed\n");
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
index d811cb038e94..a9e41d7970ea 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
@@ -408,19 +408,19 @@ void amdgpu_gfx_parse_disable_cu(unsigned *mask, unsigned max_se,
 
 int amdgpu_gfx_kiq_init_ring(struct amdgpu_device *adev,
 			     struct amdgpu_ring *ring,
-			     struct amdgpu_irq_src *irq);
+			     struct amdgpu_irq_src *irq, int xcc_id);
 
 void amdgpu_gfx_kiq_free_ring(struct amdgpu_ring *ring);
 
-void amdgpu_gfx_kiq_fini(struct amdgpu_device *adev);
+void amdgpu_gfx_kiq_fini(struct amdgpu_device *adev, int xcc_id);
 int amdgpu_gfx_kiq_init(struct amdgpu_device *adev,
-			unsigned hpd_size);
+			unsigned hpd_size, int xcc_id);
 
 int amdgpu_gfx_mqd_sw_init(struct amdgpu_device *adev,
-			   unsigned mqd_size);
-void amdgpu_gfx_mqd_sw_fini(struct amdgpu_device *adev);
-int amdgpu_gfx_disable_kcq(struct amdgpu_device *adev);
-int amdgpu_gfx_enable_kcq(struct amdgpu_device *adev);
+			   unsigned mqd_size, int xcc_id);
+void amdgpu_gfx_mqd_sw_fini(struct amdgpu_device *adev, int xcc_id);
+int amdgpu_gfx_disable_kcq(struct amdgpu_device *adev, int xcc_id);
+int amdgpu_gfx_enable_kcq(struct amdgpu_device *adev, int xcc_id);
 
 void amdgpu_gfx_compute_queue_acquire(struct amdgpu_device *adev);
 void amdgpu_gfx_graphics_queue_acquire(struct amdgpu_device *adev);
@@ -429,7 +429,7 @@ int amdgpu_gfx_mec_queue_to_bit(struct amdgpu_device *adev, int mec,
 				int pipe, int queue);
 void amdgpu_queue_mask_bit_to_mec_queue(struct amdgpu_device *adev, int bit,
 				 int *mec, int *pipe, int *queue);
-bool amdgpu_gfx_is_mec_queue_enabled(struct amdgpu_device *adev, int inst,
+bool amdgpu_gfx_is_mec_queue_enabled(struct amdgpu_device *adev, int xcc_id,
 				     int mec, int pipe, int queue);
 bool amdgpu_gfx_is_high_priority_compute_queue(struct amdgpu_device *adev,
 					       struct amdgpu_ring *ring);
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
index 88f8424ea1e4..accc0a7251b9 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -4629,19 +4629,19 @@ static int gfx_v10_0_sw_init(void *handle)
 	}
 
 	if (!adev->enable_mes_kiq) {
-		r = amdgpu_gfx_kiq_init(adev, GFX10_MEC_HPD_SIZE);
+		r = amdgpu_gfx_kiq_init(adev, GFX10_MEC_HPD_SIZE, 0);
 		if (r) {
 			DRM_ERROR("Failed to init KIQ BOs!\n");
 			return r;
 		}
 
 		kiq = &adev->gfx.kiq[0];
-		r = amdgpu_gfx_kiq_init_ring(adev, &kiq->ring, &kiq->irq);
+		r = amdgpu_gfx_kiq_init_ring(adev, &kiq->ring, &kiq->irq, 0);
 		if (r)
 			return r;
 	}
 
-	r = amdgpu_gfx_mqd_sw_init(adev, sizeof(struct v10_compute_mqd));
+	r = amdgpu_gfx_mqd_sw_init(adev, sizeof(struct v10_compute_mqd), 0);
 	if (r)
 		return r;
 
@@ -4690,11 +4690,11 @@ static int gfx_v10_0_sw_fini(void *handle)
 	for (i = 0; i < adev->gfx.num_compute_rings; i++)
 		amdgpu_ring_fini(&adev->gfx.compute_ring[i]);
 
-	amdgpu_gfx_mqd_sw_fini(adev);
+	amdgpu_gfx_mqd_sw_fini(adev, 0);
 
 	if (!adev->enable_mes_kiq) {
 		amdgpu_gfx_kiq_free_ring(&adev->gfx.kiq[0].ring);
-		amdgpu_gfx_kiq_fini(adev);
+		amdgpu_gfx_kiq_fini(adev, 0);
 	}
 
 	gfx_v10_0_pfp_fini(adev);
@@ -6812,14 +6812,13 @@ static int gfx_v10_0_kiq_init_queue(struct amdgpu_ring *ring)
 {
 	struct amdgpu_device *adev = ring->adev;
 	struct v10_compute_mqd *mqd = ring->mqd_ptr;
-	int mqd_idx = AMDGPU_MAX_COMPUTE_RINGS;
 
 	gfx_v10_0_kiq_setting(ring);
 
 	if (amdgpu_in_reset(adev)) { /* for GPU_RESET case */
 		/* reset MQD to a clean status */
-		if (adev->gfx.mec.mqd_backup[mqd_idx])
-			memcpy(mqd, adev->gfx.mec.mqd_backup[mqd_idx], sizeof(*mqd));
+		if (adev->gfx.kiq[0].mqd_backup)
+			memcpy(mqd, adev->gfx.kiq[0].mqd_backup, sizeof(*mqd));
 
 		/* reset ring buffer */
 		ring->wptr = 0;
@@ -6841,8 +6840,8 @@ static int gfx_v10_0_kiq_init_queue(struct amdgpu_ring *ring)
 		nv_grbm_select(adev, 0, 0, 0, 0);
 		mutex_unlock(&adev->srbm_mutex);
 
-		if (adev->gfx.mec.mqd_backup[mqd_idx])
-			memcpy(adev->gfx.mec.mqd_backup[mqd_idx], mqd, sizeof(*mqd));
+		if (adev->gfx.kiq[0].mqd_backup)
+			memcpy(adev->gfx.kiq[0].mqd_backup, mqd, sizeof(*mqd));
 	}
 
 	return 0;
@@ -6927,7 +6926,7 @@ static int gfx_v10_0_kcq_resume(struct amdgpu_device *adev)
 			goto done;
 	}
 
-	r = amdgpu_gfx_enable_kcq(adev);
+	r = amdgpu_gfx_enable_kcq(adev, 0);
 done:
 	return r;
 }
@@ -7280,7 +7279,7 @@ static int gfx_v10_0_hw_fini(void *handle)
 				DRM_ERROR("KGQ disable failed\n");
 		}
 #endif
-		if (amdgpu_gfx_disable_kcq(adev))
+		if (amdgpu_gfx_disable_kcq(adev, 0))
 			DRM_ERROR("KCQ disable failed\n");
 	}
 
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
index fd7b73688879..05caffdf4445 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -1389,19 +1389,19 @@ static int gfx_v11_0_sw_init(void *handle)
 	}
 
 	if (!adev->enable_mes_kiq) {
-		r = amdgpu_gfx_kiq_init(adev, GFX11_MEC_HPD_SIZE);
+		r = amdgpu_gfx_kiq_init(adev, GFX11_MEC_HPD_SIZE, 0);
 		if (r) {
 			DRM_ERROR("Failed to init KIQ BOs!\n");
 			return r;
 		}
 
 		kiq = &adev->gfx.kiq[0];
-		r = amdgpu_gfx_kiq_init_ring(adev, &kiq->ring, &kiq->irq);
+		r = amdgpu_gfx_kiq_init_ring(adev, &kiq->ring, &kiq->irq, 0);
 		if (r)
 			return r;
 	}
 
-	r = amdgpu_gfx_mqd_sw_init(adev, sizeof(struct v11_compute_mqd));
+	r = amdgpu_gfx_mqd_sw_init(adev, sizeof(struct v11_compute_mqd), 0);
 	if (r)
 		return r;
 
@@ -1463,11 +1463,11 @@ static int gfx_v11_0_sw_fini(void *handle)
 	for (i = 0; i < adev->gfx.num_compute_rings; i++)
 		amdgpu_ring_fini(&adev->gfx.compute_ring[i]);
 
-	amdgpu_gfx_mqd_sw_fini(adev);
+	amdgpu_gfx_mqd_sw_fini(adev, 0);
 
 	if (!adev->enable_mes_kiq) {
 		amdgpu_gfx_kiq_free_ring(&adev->gfx.kiq[0].ring);
-		amdgpu_gfx_kiq_fini(adev);
+		amdgpu_gfx_kiq_fini(adev, 0);
 	}
 
 	gfx_v11_0_pfp_fini(adev);
@@ -4035,14 +4035,13 @@ static int gfx_v11_0_kiq_init_queue(struct amdgpu_ring *ring)
 {
 	struct amdgpu_device *adev = ring->adev;
 	struct v11_compute_mqd *mqd = ring->mqd_ptr;
-	int mqd_idx = AMDGPU_MAX_COMPUTE_RINGS;
 
 	gfx_v11_0_kiq_setting(ring);
 
 	if (amdgpu_in_reset(adev)) { /* for GPU_RESET case */
 		/* reset MQD to a clean status */
-		if (adev->gfx.mec.mqd_backup[mqd_idx])
-			memcpy(mqd, adev->gfx.mec.mqd_backup[mqd_idx], sizeof(*mqd));
+		if (adev->gfx.kiq[0].mqd_backup)
+			memcpy(mqd, adev->gfx.kiq[0].mqd_backup, sizeof(*mqd));
 
 		/* reset ring buffer */
 		ring->wptr = 0;
@@ -4064,8 +4063,8 @@ static int gfx_v11_0_kiq_init_queue(struct amdgpu_ring *ring)
 		soc21_grbm_select(adev, 0, 0, 0, 0);
 		mutex_unlock(&adev->srbm_mutex);
 
-		if (adev->gfx.mec.mqd_backup[mqd_idx])
-			memcpy(adev->gfx.mec.mqd_backup[mqd_idx], mqd, sizeof(*mqd));
+		if (adev->gfx.kiq[0].mqd_backup)
+			memcpy(adev->gfx.kiq[0].mqd_backup, mqd, sizeof(*mqd));
 	}
 
 	return 0;
@@ -4153,7 +4152,7 @@ static int gfx_v11_0_kcq_resume(struct amdgpu_device *adev)
 			goto done;
 	}
 
-	r = amdgpu_gfx_enable_kcq(adev);
+	r = amdgpu_gfx_enable_kcq(adev, 0);
 done:
 	return r;
 }
@@ -4456,7 +4455,7 @@ static int gfx_v11_0_hw_fini(void *handle)
 				DRM_ERROR("KGQ disable failed\n");
 		}
 #endif
-		if (amdgpu_gfx_disable_kcq(adev))
+		if (amdgpu_gfx_disable_kcq(adev, 0))
 			DRM_ERROR("KCQ disable failed\n");
 
 		amdgpu_mes_kiq_hw_fini(adev);
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
index 18722450e265..8a43e87de49f 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
@@ -2016,19 +2016,19 @@ static int gfx_v8_0_sw_init(void *handle)
 		}
 	}
 
-	r = amdgpu_gfx_kiq_init(adev, GFX8_MEC_HPD_SIZE);
+	r = amdgpu_gfx_kiq_init(adev, GFX8_MEC_HPD_SIZE, 0);
 	if (r) {
 		DRM_ERROR("Failed to init KIQ BOs!\n");
 		return r;
 	}
 
 	kiq = &adev->gfx.kiq[0];
-	r = amdgpu_gfx_kiq_init_ring(adev, &kiq->ring, &kiq->irq);
+	r = amdgpu_gfx_kiq_init_ring(adev, &kiq->ring, &kiq->irq, 0);
 	if (r)
 		return r;
 
 	/* create MQD for all compute queues as well as KIQ for SRIOV case */
-	r = amdgpu_gfx_mqd_sw_init(adev, sizeof(struct vi_mqd_allocation));
+	r = amdgpu_gfx_mqd_sw_init(adev, sizeof(struct vi_mqd_allocation), 0);
 	if (r)
 		return r;
 
@@ -2051,9 +2051,9 @@ static int gfx_v8_0_sw_fini(void *handle)
 	for (i = 0; i < adev->gfx.num_compute_rings; i++)
 		amdgpu_ring_fini(&adev->gfx.compute_ring[i]);
 
-	amdgpu_gfx_mqd_sw_fini(adev);
+	amdgpu_gfx_mqd_sw_fini(adev, 0);
 	amdgpu_gfx_kiq_free_ring(&adev->gfx.kiq[0].ring);
-	amdgpu_gfx_kiq_fini(adev);
+	amdgpu_gfx_kiq_fini(adev, 0);
 
 	gfx_v8_0_mec_fini(adev);
 	amdgpu_gfx_rlc_fini(adev);
@@ -4596,14 +4596,13 @@ static int gfx_v8_0_kiq_init_queue(struct amdgpu_ring *ring)
 {
 	struct amdgpu_device *adev = ring->adev;
 	struct vi_mqd *mqd = ring->mqd_ptr;
-	int mqd_idx = AMDGPU_MAX_COMPUTE_RINGS;
 
 	gfx_v8_0_kiq_setting(ring);
 
 	if (amdgpu_in_reset(adev)) { /* for GPU_RESET case */
 		/* reset MQD to a clean status */
-		if (adev->gfx.mec.mqd_backup[mqd_idx])
-			memcpy(mqd, adev->gfx.mec.mqd_backup[mqd_idx], sizeof(struct vi_mqd_allocation));
+		if (adev->gfx.kiq[0].mqd_backup)
+			memcpy(mqd, adev->gfx.kiq[0].mqd_backup, sizeof(struct vi_mqd_allocation));
 
 		/* reset ring buffer */
 		ring->wptr = 0;
@@ -4626,8 +4625,8 @@ static int gfx_v8_0_kiq_init_queue(struct amdgpu_ring *ring)
 		vi_srbm_select(adev, 0, 0, 0, 0);
 		mutex_unlock(&adev->srbm_mutex);
 
-		if (adev->gfx.mec.mqd_backup[mqd_idx])
-			memcpy(adev->gfx.mec.mqd_backup[mqd_idx], mqd, sizeof(struct vi_mqd_allocation));
+		if (adev->gfx.kiq[0].mqd_backup)
+			memcpy(adev->gfx.kiq[0].mqd_backup, mqd, sizeof(struct vi_mqd_allocation));
 	}
 
 	return 0;
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
index 9f5a8d2d545d..ba1fd6178cc9 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -2159,19 +2159,19 @@ static int gfx_v9_0_sw_init(void *handle)
 		}
 	}
 
-	r = amdgpu_gfx_kiq_init(adev, GFX9_MEC_HPD_SIZE);
+	r = amdgpu_gfx_kiq_init(adev, GFX9_MEC_HPD_SIZE, 0);
 	if (r) {
 		DRM_ERROR("Failed to init KIQ BOs!\n");
 		return r;
 	}
 
 	kiq = &adev->gfx.kiq[0];
-	r = amdgpu_gfx_kiq_init_ring(adev, &kiq->ring, &kiq->irq);
+	r = amdgpu_gfx_kiq_init_ring(adev, &kiq->ring, &kiq->irq, 0);
 	if (r)
 		return r;
 
 	/* create MQD for all compute queues as wel as KIQ for SRIOV case */
-	r = amdgpu_gfx_mqd_sw_init(adev, sizeof(struct v9_mqd_allocation));
+	r = amdgpu_gfx_mqd_sw_init(adev, sizeof(struct v9_mqd_allocation), 0);
 	if (r)
 		return r;
 
@@ -2206,9 +2206,9 @@ static int gfx_v9_0_sw_fini(void *handle)
 	for (i = 0; i < adev->gfx.num_compute_rings; i++)
 		amdgpu_ring_fini(&adev->gfx.compute_ring[i]);
 
-	amdgpu_gfx_mqd_sw_fini(adev);
+	amdgpu_gfx_mqd_sw_fini(adev, 0);
 	amdgpu_gfx_kiq_free_ring(&adev->gfx.kiq[0].ring);
-	amdgpu_gfx_kiq_fini(adev);
+	amdgpu_gfx_kiq_fini(adev, 0);
 
 	gfx_v9_0_mec_fini(adev);
 	amdgpu_bo_free_kernel(&adev->gfx.rlc.clear_state_obj,
@@ -3510,7 +3510,6 @@ static int gfx_v9_0_kiq_init_queue(struct amdgpu_ring *ring)
 {
 	struct amdgpu_device *adev = ring->adev;
 	struct v9_mqd *mqd = ring->mqd_ptr;
-	int mqd_idx = AMDGPU_MAX_COMPUTE_RINGS;
 	struct v9_mqd *tmp_mqd;
 
 	gfx_v9_0_kiq_setting(ring);
@@ -3520,11 +3519,11 @@ static int gfx_v9_0_kiq_init_queue(struct amdgpu_ring *ring)
 	 * driver need to re-init the mqd.
 	 * check mqd->cp_hqd_pq_control since this value should not be 0
 	 */
-	tmp_mqd = (struct v9_mqd *)adev->gfx.mec.mqd_backup[mqd_idx];
+	tmp_mqd = (struct v9_mqd *)adev->gfx.kiq[0].mqd_backup;
 	if (amdgpu_in_reset(adev) && tmp_mqd->cp_hqd_pq_control){
 		/* for GPU_RESET case , reset MQD to a clean status */
-		if (adev->gfx.mec.mqd_backup[mqd_idx])
-			memcpy(mqd, adev->gfx.mec.mqd_backup[mqd_idx], sizeof(struct v9_mqd_allocation));
+		if (adev->gfx.kiq[0].mqd_backup)
+			memcpy(mqd, adev->gfx.kiq[0].mqd_backup, sizeof(struct v9_mqd_allocation));
 
 		/* reset ring buffer */
 		ring->wptr = 0;
@@ -3548,8 +3547,8 @@ static int gfx_v9_0_kiq_init_queue(struct amdgpu_ring *ring)
 		soc15_grbm_select(adev, 0, 0, 0, 0);
 		mutex_unlock(&adev->srbm_mutex);
 
-		if (adev->gfx.mec.mqd_backup[mqd_idx])
-			memcpy(adev->gfx.mec.mqd_backup[mqd_idx], mqd, sizeof(struct v9_mqd_allocation));
+		if (adev->gfx.kiq[0].mqd_backup)
+			memcpy(adev->gfx.kiq[0].mqd_backup, mqd, sizeof(struct v9_mqd_allocation));
 	}
 
 	return 0;
@@ -3643,7 +3642,7 @@ static int gfx_v9_0_kcq_resume(struct amdgpu_device *adev)
 			goto done;
 	}
 
-	r = amdgpu_gfx_enable_kcq(adev);
+	r = amdgpu_gfx_enable_kcq(adev, 0);
 done:
 	return r;
 }
@@ -3762,7 +3761,7 @@ static int gfx_v9_0_hw_fini(void *handle)
 	/* DF freeze and kcq disable will fail */
 	if (!amdgpu_ras_intr_triggered())
 		/* disable KCQ to avoid CPC touch memory not valid anymore */
-		amdgpu_gfx_disable_kcq(adev);
+		amdgpu_gfx_disable_kcq(adev, 0);
 
 	if (amdgpu_sriov_vf(adev)) {
 		gfx_v9_0_cp_gfx_enable(adev, false);
-- 
2.39.2

