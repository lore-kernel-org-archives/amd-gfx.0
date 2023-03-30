Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1AC5EC6FD1D
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Mar 2023 19:49:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 742A410F008;
	Thu, 30 Mar 2023 19:49:04 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2068.outbound.protection.outlook.com [40.107.94.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C244910F008
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Mar 2023 19:49:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mV6oxI+NpaohlSWbVgeP1otJ5LW/OfYx+BiuMRR2lw+lqrqmXSBRYJ01pMSSo8ree4ByPJSN94l274tluYmJQDaVioFphzgVTVnEFHO0Ugn/DahidvoxkWxrXFL76ZHQp034yM511ts6HUWAGcT5bNC9fioAcQ+bdcdlaT6a/lDRo9YIHR3KsyvnTKQxUdgaq3Sb+1wkKux1nfqDx67MBguwCQqK/7/HUO8CZ6bnjrm07HNul9u/gUyyawDuLIYiWGCkLALQyX95w2/FNlv0Hva7kB9GTgHIqNvpOry+tLKvvFNpg5ioQhZqkyrNqRS0ToaoVBQhKTpR+HqR5OM4Aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EKaN4Zuo9dffHRSZgwrKrV5QjLEtC2CC6hhwWM9Tg9k=;
 b=oRq+VfyER+rsmYMuDdL1t5n50YNJbxcWZI1LuI93jiVPvfSVEK6zyNVz0sPsprWT0pGnhOfGrGjAir3o4Wa78rNiEtdKzXmDOheOeP+meutFKbcPuQ90KLLLEih6u7pO2uu6wOblfEzDR2Y58pyMIdQfSZhyPhV+HIcoh+N3GMayol1Ivln+fLZ9gofOG8SAVCvkbi4guEtAIBXm+rfhRnDg22o7lzExJm/FOr85zjSwlskmQ8dNj+s7RmqoY29PBVAE64vC11JA06tR0TnVjrG0H9XWdyZWLcrgwi1agRQ+U1L1ww0fvITgCD8M+giZjFV6+806YxMjIQ1OeHmIIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EKaN4Zuo9dffHRSZgwrKrV5QjLEtC2CC6hhwWM9Tg9k=;
 b=xqL/MZMowAJb0mYk95s38ZnbmU+G2iC6g+cH7WZOCtTJvj4CUSGjuhdvbRxNBMCtHleuVdoeT4uJVi/wCQxUy/zteIuWCR1C9Kh+qdZ7Au+40CZWGpFAeQegcofKO36VVj6SKeg2H/cD+VS6kgbxbysHbVrnqaMRqX2N1MrpyIU=
Received: from CY5PR15CA0155.namprd15.prod.outlook.com (2603:10b6:930:67::14)
 by DS7PR12MB6070.namprd12.prod.outlook.com (2603:10b6:8:9e::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.35; Thu, 30 Mar
 2023 19:48:59 +0000
Received: from CY4PEPF0000C971.namprd02.prod.outlook.com
 (2603:10b6:930:67:cafe::26) by CY5PR15CA0155.outlook.office365.com
 (2603:10b6:930:67::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.22 via Frontend
 Transport; Thu, 30 Mar 2023 19:48:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000C971.mail.protection.outlook.com (10.167.242.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6178.30 via Frontend Transport; Thu, 30 Mar 2023 19:48:58 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 30 Mar
 2023 14:48:57 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 5/8] drm/amdgpu: Use unique doorbell range per xcc
Date: Thu, 30 Mar 2023 15:48:40 -0400
Message-ID: <20230330194843.1136162-5-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230330194843.1136162-1-alexander.deucher@amd.com>
References: <20230330194843.1136162-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000C971:EE_|DS7PR12MB6070:EE_
X-MS-Office365-Filtering-Correlation-Id: 80809502-bbea-486e-ce4a-08db3157cdeb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wMx1egsKPQF4EoPVSBvVxVG9QHFp4cFt3Pvw8uZrpNK2F5ZadxODCcyX0l1y9QOcvTfVCdXkL1f9uKljF9ROwJeFus6avUsu/L85OzTe5k+lprb+8ioW6sePcLuKlb7awcWeiP42cqaQYHPAkjraFqWey090OpQA7LCxbvkZ9mtxAeAZ/UsQuXGpR8Sseyl90AkYp/LB+Bbkkyo+dvOAyBV0mhrHjLTj4Nb8LNlNfmt9V6P49LypYoDlI5GZyTIe9LK5eMJLS3JUHhZwXQTh2FioW5fhs6AH6b3xVtUkkX5PxSUH/hB9ov2n10+1TT1JifKyC0CDz0hAxwn446Hbd/oZc/B12AKFnGBJMUMFurIQQuY2UWaj3U6fxNtLePO0+SHtwpZWJ4/MI5ijXWonKtWQBrcgCNve0p44VFB0QXaPCws5ZnRP/yI67W/Ucq9VWuaUIOacxFCEs4b8IZHJdamkm02Ndw7aAG9kwp+UjrcxCKUF12G6pjj7GN/YFEeHIJot7SaC0JQ5AnSVEtEjDjqV9vd1qsdlC9FKvzMrqnp0OJDgOl/WUbXEGzlVKYsOhLhiCYkM+Mwv9ibLwWliDo4H2A9fLN0SV4YictxQBTGtcsu4TcrcEb74gmL4vmd+0844m1XD6bBxffJI9I7hESXJAm7x8Kb7Ze3wTVV40emFly6PbKFPEcNMru9xeSwvjTVWT3RzeW1jageY0/vZSYnLLAyVcRew1h3kzLLKP8s=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(346002)(39860400002)(396003)(136003)(376002)(451199021)(36840700001)(40470700004)(46966006)(83380400001)(82740400003)(356005)(426003)(81166007)(2906002)(47076005)(336012)(2616005)(82310400005)(16526019)(86362001)(186003)(40480700001)(1076003)(36860700001)(8936002)(478600001)(26005)(316002)(54906003)(6666004)(70586007)(5660300002)(70206006)(41300700001)(4326008)(7696005)(36756003)(40460700003)(6916009)(8676002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2023 19:48:58.8818 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 80809502-bbea-486e-ce4a-08db3157cdeb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000C971.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6070
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Lijo Lazar <lijo.lazar@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Lijo Lazar <lijo.lazar@amd.com>

Program different ranges in each XCC with MEC_DOORBELL_RANGE_LOWER/HIGHER.
Keeping the same range causes CPF in other XCCs also to be busy when an IB
packet is submitted to KCQ. Only the XCC which processes the packet
comes back to idle afterwards and this causes other CPs not be idle.
This in turn affects clockgating behavior as RLC doesn't get idle
interrupt.

LOWER/HIGHER covers only KIQ/KCQs which are per XCC queues. Assigning
different ranges doesn't seem to have any side effect as user queue ranges
are outside of this range. User queue tests - PM4 through KFD and AQL
through rocr - have the same results after this change.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell.h  | 35 +++++++++++--------
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c       |  5 ++-
 .../drm/amd/amdgpu/aqua_vanjaram_reg_init.c   |  1 +
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c       | 31 +++++++++++-----
 4 files changed, 47 insertions(+), 25 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell.h
index a8fd7797bc8b..60a5db32072b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell.h
@@ -81,6 +81,8 @@ struct amdgpu_doorbell_index {
 	uint32_t max_assignment;
 	/* Per engine SDMA doorbell size in dword */
 	uint32_t sdma_doorbell_range;
+	/* Per xcc doorbell size for KIQ/KCQ */
+	uint32_t xcc_doorbell_range;
 };
 
 typedef enum _AMDGPU_DOORBELL_ASSIGNMENT
@@ -304,28 +306,31 @@ typedef enum _AMDGPU_DOORBELL64_ASSIGNMENT
 	AMDGPU_DOORBELL64_INVALID                 = 0xFFFF
 } AMDGPU_DOORBELL64_ASSIGNMENT;
 
-typedef enum _AMDGPU_DOORBELL_ASSIGNMENT_LAYOUT1
-{
-	/* KIQ: 0~7 for maximum 8 XCD */
-	AMDGPU_DOORBELL_LAYOUT1_KIQ_START               = 0x000,
-	AMDGPU_DOORBELL_LAYOUT1_HIQ                     = 0x008,
-	AMDGPU_DOORBELL_LAYOUT1_DIQ                     = 0x009,
-	/* Compute: 0x0A ~ 0x49 */
-	AMDGPU_DOORBELL_LAYOUT1_MEC_RING_START          = 0x00A,
-	AMDGPU_DOORBELL_LAYOUT1_MEC_RING_END            = 0x049,
-	AMDGPU_DOORBELL_LAYOUT1_USERQUEUE_START         = 0x04A,
-	AMDGPU_DOORBELL_LAYOUT1_USERQUEUE_END           = 0x0C9,
+typedef enum _AMDGPU_DOORBELL_ASSIGNMENT_LAYOUT1 {
+	/* XCC0: 0x00 ~20, XCC1: 20 ~ 2F ... */
+
+	/* KIQ/HIQ/DIQ */
+	AMDGPU_DOORBELL_LAYOUT1_KIQ_START		= 0x000,
+	AMDGPU_DOORBELL_LAYOUT1_HIQ			= 0x001,
+	AMDGPU_DOORBELL_LAYOUT1_DIQ			= 0x002,
+	/* Compute: 0x08 ~ 0x20  */
+	AMDGPU_DOORBELL_LAYOUT1_MEC_RING_START		= 0x008,
+	AMDGPU_DOORBELL_LAYOUT1_MEC_RING_END		= 0x00F,
+	AMDGPU_DOORBELL_LAYOUT1_USERQUEUE_START		= 0x010,
+	AMDGPU_DOORBELL_LAYOUT1_USERQUEUE_END		= 0x01F,
+	AMDGPU_DOORBELL_LAYOUT1_XCC_RANGE		= 0x020,
+
 	/* SDMA: 0x100 ~ 0x19F */
-	AMDGPU_DOORBELL_LAYOUT1_sDMA_ENGINE_START       = 0x100,
-	AMDGPU_DOORBELL_LAYOUT1_sDMA_ENGINE_END         = 0x19F,
+	AMDGPU_DOORBELL_LAYOUT1_sDMA_ENGINE_START	= 0x100,
+	AMDGPU_DOORBELL_LAYOUT1_sDMA_ENGINE_END		= 0x19F,
 	/* IH: 0x1A0 ~ 0x1AF */
 	AMDGPU_DOORBELL_LAYOUT1_IH                      = 0x1A0,
 	/* VCN: 0x1B0 ~ 0x1D4 */
 	AMDGPU_DOORBELL_LAYOUT1_VCN_START               = 0x1B0,
 	AMDGPU_DOORBELL_LAYOUT1_VCN_END                 = 0x1D4,
 
-	AMDGPU_DOORBELL_LAYOUT1_FIRST_NON_CP            = AMDGPU_DOORBELL_LAYOUT1_sDMA_ENGINE_START,
-	AMDGPU_DOORBELL_LAYOUT1_LAST_NON_CP             = AMDGPU_DOORBELL_LAYOUT1_VCN_END,
+	AMDGPU_DOORBELL_LAYOUT1_FIRST_NON_CP		= AMDGPU_DOORBELL_LAYOUT1_sDMA_ENGINE_START,
+	AMDGPU_DOORBELL_LAYOUT1_LAST_NON_CP		= AMDGPU_DOORBELL_LAYOUT1_VCN_END,
 
 	AMDGPU_DOORBELL_LAYOUT1_MAX_ASSIGNMENT          = 0x1D4,
 	AMDGPU_DOORBELL_LAYOUT1_INVALID                 = 0xFFFF
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
index ce9f43024ed1..792f9e106727 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
@@ -316,7 +316,10 @@ int amdgpu_gfx_kiq_init_ring(struct amdgpu_device *adev,
 	ring->use_doorbell = true;
 	ring->xcc_id = xcc_id;
 	ring->vm_hub = AMDGPU_GFXHUB(xcc_id);
-	ring->doorbell_index = (adev->doorbell_index.kiq + xcc_id) << 1;
+	ring->doorbell_index =
+		(adev->doorbell_index.kiq +
+		 xcc_id * adev->doorbell_index.xcc_doorbell_range)
+		<< 1;
 
 	r = amdgpu_gfx_kiq_acquire(adev, ring, xcc_id);
 	if (r)
diff --git a/drivers/gpu/drm/amd/amdgpu/aqua_vanjaram_reg_init.c b/drivers/gpu/drm/amd/amdgpu/aqua_vanjaram_reg_init.c
index 6591d39c6518..55a6ebb940ba 100644
--- a/drivers/gpu/drm/amd/amdgpu/aqua_vanjaram_reg_init.c
+++ b/drivers/gpu/drm/amd/amdgpu/aqua_vanjaram_reg_init.c
@@ -44,6 +44,7 @@ void aqua_vanjaram_doorbell_index_init(struct amdgpu_device *adev)
 
 	adev->doorbell_index.userqueue_start = AMDGPU_DOORBELL_LAYOUT1_USERQUEUE_START;
 	adev->doorbell_index.userqueue_end = AMDGPU_DOORBELL_LAYOUT1_USERQUEUE_END;
+	adev->doorbell_index.xcc_doorbell_range = AMDGPU_DOORBELL_LAYOUT1_XCC_RANGE;
 
 	adev->doorbell_index.sdma_doorbell_range = 20;
 	for (i = 0; i < adev->sdma.num_instances; i++)
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
index f6fb0b01c086..3cd24651b96c 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
@@ -734,8 +734,10 @@ static int gfx_v9_4_3_compute_ring_init(struct amdgpu_device *adev, int ring_id,
 	unsigned irq_type;
 	struct amdgpu_ring *ring = &adev->gfx.compute_ring[ring_id];
 	unsigned int hw_prio;
+	uint32_t xcc_doorbell_start;
 
-	ring = &adev->gfx.compute_ring[ring_id];
+	ring = &adev->gfx.compute_ring[xcc_id * adev->gfx.num_compute_rings +
+				       ring_id];
 
 	/* mec0 is me1 */
 	ring->xcc_id = xcc_id;
@@ -745,9 +747,12 @@ static int gfx_v9_4_3_compute_ring_init(struct amdgpu_device *adev, int ring_id,
 
 	ring->ring_obj = NULL;
 	ring->use_doorbell = true;
-	ring->doorbell_index = (adev->doorbell_index.mec_ring0 + ring_id) << 1;
-	ring->eop_gpu_addr = adev->gfx.mec.hpd_eop_gpu_addr
-				+ (ring_id * GFX9_MEC_HPD_SIZE);
+	xcc_doorbell_start = adev->doorbell_index.mec_ring0 +
+			     xcc_id * adev->doorbell_index.xcc_doorbell_range;
+	ring->doorbell_index = (xcc_doorbell_start + ring_id) << 1;
+	ring->eop_gpu_addr = adev->gfx.mec.hpd_eop_gpu_addr +
+			     (ring_id + xcc_id * adev->gfx.num_compute_rings) *
+				     GFX9_MEC_HPD_SIZE;
 	ring->vm_hub = AMDGPU_GFXHUB(xcc_id);
 	sprintf(ring->name, "comp_%d.%d.%d.%d",
 			ring->xcc_id, ring->me, ring->pipe, ring->queue);
@@ -806,8 +811,8 @@ static int gfx_v9_4_3_sw_init(void *handle)
 	}
 
 	/* set up the compute queues - allocate horizontally across pipes */
-	ring_id = 0;
 	for (xcc_id = 0; xcc_id < num_xcc; xcc_id++) {
+		ring_id = 0;
 		for (i = 0; i < adev->gfx.mec.num_mec; ++i) {
 			for (j = 0; j < adev->gfx.mec.num_queue_per_pipe; j++) {
 				for (k = 0; k < adev->gfx.mec.num_pipe_per_mec;
@@ -1659,10 +1664,18 @@ static int gfx_v9_4_3_xcc_kiq_init_register(struct amdgpu_ring *ring,
 
 	/* enable the doorbell if requested */
 	if (ring->use_doorbell) {
-		WREG32_SOC15(GC, GET_INST(GC, xcc_id), regCP_MEC_DOORBELL_RANGE_LOWER,
-					(adev->doorbell_index.kiq * 2) << 2);
-		WREG32_SOC15(GC, GET_INST(GC, xcc_id), regCP_MEC_DOORBELL_RANGE_UPPER,
-				(adev->doorbell_index.userqueue_end * 2) << 2);
+		WREG32_SOC15(
+			GC, GET_INST(GC, xcc_id),
+			regCP_MEC_DOORBELL_RANGE_LOWER,
+			((adev->doorbell_index.kiq +
+			  xcc_id * adev->doorbell_index.xcc_doorbell_range) *
+			 2) << 2);
+		WREG32_SOC15(
+			GC, GET_INST(GC, xcc_id),
+			regCP_MEC_DOORBELL_RANGE_UPPER,
+			((adev->doorbell_index.userqueue_end +
+			  xcc_id * adev->doorbell_index.xcc_doorbell_range) *
+			 2) << 2);
 	}
 
 	WREG32_SOC15_RLC(GC, GET_INST(GC, xcc_id), regCP_HQD_PQ_DOORBELL_CONTROL,
-- 
2.39.2

