Return-Path: <SRS0=wMah=N5=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E0C3C433EF
	for <amd-gfx@archiver.kernel.org>; Tue,  7 Sep 2021 12:21:12 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1229B60EE6
	for <amd-gfx@archiver.kernel.org>; Tue,  7 Sep 2021 12:21:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 1229B60EE6
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8F1128928D;
	Tue,  7 Sep 2021 12:21:11 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1anam02on2042.outbound.protection.outlook.com [40.107.96.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 224598928D
 for <amd-gfx@lists.freedesktop.org>; Tue,  7 Sep 2021 12:21:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j/ugxkiJDKYR195Hzvm04ini02joNoXC5w7mPhh5HvnAkfY2cd/vShghLwUpc0YFYMQUPXYaIBL7NO42qxwc4IRhU5mjvdZUoAYFyEKoK16JIxsSHNlCwgRCR3F1CA+FXbj+XOQEOnIYGcRP1wYLGZa48r+8akIF+AD0x+O4II3hW7YW3evUFkHKfUJ5z9lKwIk6y84WwMcyxZNbd1dJ1//5GI9hWfEhZ+Mg+pl6hZHVuLYIdOouW2z3ni1AlcM7bPrO0NtXHyLvC8BkNCEBXEBhNOkDMq7L9lue4i0fvG6cChfoIUD/EGZr90G3gztl38GEx3FwU5ZUCpFvyDL4kw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=azsFx7weTtGOTl0kyY6nhOJed7W4253XtZFOzruB3Kg=;
 b=mt7Vm8JzAo/IXynsAmLNKKdErNyyII39b3Nzo/twsDMCsI0BVIWIbqguts8uCEcrwj2eVprsY3znqnxTc1wUS7LlwF9FKBSoEePQcVQ3ZhpOGzMv2PssudbK88wXP+o32JPawh1LiE0oLA9OisYqpN1XPA4rLpt2ukZMtyJh9N0DJkkHala06YtQcp/yBYGieUC7UiZ08dr4gHJ0CmKP+IfPeSSjtasbXH6izqPcU4nODRebPjdHk1QlmI2D0U85t9g8kY2vA9Y5qoAib263MAIS9YxuJG97zk5A9cwvhbYNrQL04/OVkFgR44lyn4vx5AN1wng11aywgSz4rKLQGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=azsFx7weTtGOTl0kyY6nhOJed7W4253XtZFOzruB3Kg=;
 b=m305RQfK9H0/Vq50C4U1Jz7ZghepuOT9EMBwhrwoZR4ktVsjr0m+90mAHYn3h/LiThXorIS7qB61/FOqIMC8euKJqQEtLBzSVkfKF9MzC47VhT+EL926E/s1DplwIUOrOQM2Ejn6CRt1TWGtc/CTgX7RqZ5IX42Ok7hSIy/S6s8=
Received: from DM6PR06CA0051.namprd06.prod.outlook.com (2603:10b6:5:54::28) by
 CH2PR12MB3895.namprd12.prod.outlook.com (2603:10b6:610:2a::13) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4478.19; Tue, 7 Sep 2021 12:21:08 +0000
Received: from DM6NAM11FT038.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:54:cafe::34) by DM6PR06CA0051.outlook.office365.com
 (2603:10b6:5:54::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.14 via Frontend
 Transport; Tue, 7 Sep 2021 12:21:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT038.mail.protection.outlook.com (10.13.173.137) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4478.19 via Frontend Transport; Tue, 7 Sep 2021 12:21:08 +0000
Received: from pp-server-two.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Tue, 7 Sep 2021
 07:21:06 -0500
From: xinhui pan <xinhui.pan@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <christian.koenig@amd.com>, <alexander.deucher@amd.com>, xinhui pan
 <xinhui.pan@amd.com>
Subject: [RFC PATCH] drm/amdgpu: alloc uvd msg from IB pool
Date: Tue, 7 Sep 2021 20:20:53 +0800
Message-ID: <20210907122053.4712-1-xinhui.pan@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6e912470-e6b6-4539-5d7e-08d971f9f8a5
X-MS-TrafficTypeDiagnostic: CH2PR12MB3895:
X-Microsoft-Antispam-PRVS: <CH2PR12MB38950395192808B39C5AC85C87D39@CH2PR12MB3895.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2803;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Yf+keJlP3visBdnUZAIwjo1MotenHo99Viu75U9pyK+uIj1xaZkNY37yN0s70RayqkM9KfgDVLjcP5lQLpH5bcBqUzPcDc/bogRf4DjFX0Ym1J9oMym6/VDKSIhrQi6E4TXIZs6rlzMq86Agibz8PPDountFsssqwM2A4u2fSWLDDq531wh6XjQwRe6w3ikIPhXHwrouSIAp3O1xzUsMpoo7TyJCaDwNDMP3PalOvqwh8O11D7XW9B3UfYIFcpw0fc+mv0kQUHifWuPfS2t1gtKLvR2yjg02kUzgLWkuQCjRa/WImvnehwMOqDyVvmVjqgQXZIxyIzpvmIC5F7GU/gprAU2fvGHUxiLH5DM2AacHYifxhaluPvIGKToRXI9BaGAR2MObsPmWfFShVZA43SjM0cSlIEx1XPNKXewk1TJlxN2KoNeYrvJbpGYqRpsFF9hdPne6cU4YtKgzvXRSZUPJ5zB6yTb3W9KgTJ3QWcyhjcKkuuOaLYv5unFVSi7CWuRgPhBNSfA7/Q36wU4RX61o37v62nU5ilIhNVuPG8lKhUHRRugL37mdJvgmqRZENZp0Evph9ASPJLYTAmpnxMyQcYrR/cRhpqjz6RXkxLzOdwYaKHgyIjpI+yrnabdHn7jH1y3x4fP06NZyxhsXgzfSiyKMaIhxBqTZEW2ecZqIS0AY5i790hP6g5vNq4wDdK6B3U3BrYp8+J0lekp0hO3he2OvM0abWjp360TXIZU=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(39860400002)(396003)(376002)(346002)(136003)(36840700001)(46966006)(54906003)(70586007)(4326008)(36860700001)(2616005)(70206006)(36756003)(1076003)(336012)(2906002)(82310400003)(316002)(186003)(5660300002)(7696005)(16526019)(26005)(426003)(8936002)(8676002)(6666004)(47076005)(6916009)(478600001)(81166007)(356005)(82740400003)(83380400001)(86362001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2021 12:21:08.1038 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e912470-e6b6-4539-5d7e-08d971f9f8a5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT038.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB3895
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

There is one dedicated IB pool for IB test. So lets use it for uvd msg
too.

For some older HW, use one reserved BO at specific range.

Signed-off-by: xinhui pan <xinhui.pan@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c | 174 +++++++++++++++---------
 drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.h |   2 +
 2 files changed, 113 insertions(+), 63 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c
index d451c359606a..c70b4321b342 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c
@@ -299,8 +299,35 @@ int amdgpu_uvd_sw_init(struct amdgpu_device *adev)
 	}
 
 	/* from uvd v5.0 HW addressing capacity increased to 64 bits */
-	if (!amdgpu_device_ip_block_version_cmp(adev, AMD_IP_BLOCK_TYPE_UVD, 5, 0))
+	if (!amdgpu_device_ip_block_version_cmp(adev, AMD_IP_BLOCK_TYPE_UVD, 5, 0)) {
 		adev->uvd.address_64_bit = true;
+	} else {
+		struct amdgpu_bo *bo = NULL;
+
+		r = amdgpu_bo_create_reserved(adev, PAGE_SIZE, PAGE_SIZE,
+				AMDGPU_GEM_DOMAIN_VRAM,
+				&bo, NULL, &adev->uvd.ib_bo_cpu_addr);
+		if (r)
+			return r;
+		amdgpu_bo_kunmap(bo);
+		amdgpu_bo_unpin(bo);
+		r = amdgpu_bo_pin_restricted(bo, AMDGPU_GEM_DOMAIN_VRAM,
+				0, 256 << 20);
+		if (r) {
+			amdgpu_bo_unreserve(bo);
+			amdgpu_bo_unref(&bo);
+			return r;
+		}
+		r = amdgpu_bo_kmap(bo, &adev->uvd.ib_bo_cpu_addr);
+		if (r) {
+			amdgpu_bo_unpin(bo);
+			amdgpu_bo_unreserve(bo);
+			amdgpu_bo_unref(&bo);
+			return r;
+		}
+		adev->uvd.ib_bo = bo;
+		amdgpu_bo_unreserve(bo);
+	}
 
 	switch (adev->asic_type) {
 	case CHIP_TONGA:
@@ -337,6 +364,9 @@ int amdgpu_uvd_sw_fini(struct amdgpu_device *adev)
 				      &adev->uvd.inst[j].gpu_addr,
 				      (void **)&adev->uvd.inst[j].cpu_addr);
 
+		amdgpu_bo_free_kernel(&adev->uvd.ib_bo, NULL,
+				      (void **)&adev->uvd.ib_bo_cpu_addr);
+
 		amdgpu_ring_fini(&adev->uvd.inst[j].ring);
 
 		for (i = 0; i < AMDGPU_MAX_UVD_ENC_RINGS; ++i)
@@ -1066,7 +1096,7 @@ int amdgpu_uvd_ring_parse_cs(struct amdgpu_cs_parser *parser, uint32_t ib_idx)
 	return 0;
 }
 
-static int amdgpu_uvd_send_msg(struct amdgpu_ring *ring, struct amdgpu_bo *bo,
+static int amdgpu_uvd_send_msg(struct amdgpu_ring *ring, uint64_t addr,
 			       bool direct, struct dma_fence **fence)
 {
 	struct amdgpu_device *adev = ring->adev;
@@ -1074,29 +1104,15 @@ static int amdgpu_uvd_send_msg(struct amdgpu_ring *ring, struct amdgpu_bo *bo,
 	struct amdgpu_job *job;
 	struct amdgpu_ib *ib;
 	uint32_t data[4];
-	uint64_t addr;
 	long r;
 	int i;
 	unsigned offset_idx = 0;
 	unsigned offset[3] = { UVD_BASE_SI, 0, 0 };
 
-	amdgpu_bo_kunmap(bo);
-	amdgpu_bo_unpin(bo);
-
-	if (!ring->adev->uvd.address_64_bit) {
-		struct ttm_operation_ctx ctx = { true, false };
-
-		amdgpu_bo_placement_from_domain(bo, AMDGPU_GEM_DOMAIN_VRAM);
-		amdgpu_uvd_force_into_uvd_segment(bo);
-		r = ttm_bo_validate(&bo->tbo, &bo->placement, &ctx);
-		if (r)
-			goto err;
-	}
-
 	r = amdgpu_job_alloc_with_ib(adev, 64, direct ? AMDGPU_IB_POOL_DIRECT :
 				     AMDGPU_IB_POOL_DELAYED, &job);
 	if (r)
-		goto err;
+		return r;
 
 	if (adev->asic_type >= CHIP_VEGA10) {
 		offset_idx = 1 + ring->me;
@@ -1110,7 +1126,6 @@ static int amdgpu_uvd_send_msg(struct amdgpu_ring *ring, struct amdgpu_bo *bo,
 	data[3] = PACKET0(offset[offset_idx] + UVD_NO_OP, 0);
 
 	ib = &job->ibs[0];
-	addr = amdgpu_bo_gpu_offset(bo);
 	ib->ptr[0] = data[0];
 	ib->ptr[1] = addr;
 	ib->ptr[2] = data[1];
@@ -1123,33 +1138,13 @@ static int amdgpu_uvd_send_msg(struct amdgpu_ring *ring, struct amdgpu_bo *bo,
 	}
 	ib->length_dw = 16;
 
-	if (direct) {
-		r = dma_resv_wait_timeout(bo->tbo.base.resv, true, false,
-					  msecs_to_jiffies(10));
-		if (r == 0)
-			r = -ETIMEDOUT;
-		if (r < 0)
-			goto err_free;
-
+	if (direct)
 		r = amdgpu_job_submit_direct(job, ring, &f);
-		if (r)
-			goto err_free;
-	} else {
-		r = amdgpu_sync_resv(adev, &job->sync, bo->tbo.base.resv,
-				     AMDGPU_SYNC_ALWAYS,
-				     AMDGPU_FENCE_OWNER_UNDEFINED);
-		if (r)
-			goto err_free;
-
+	else
 		r = amdgpu_job_submit(job, &adev->uvd.entity,
-				      AMDGPU_FENCE_OWNER_UNDEFINED, &f);
-		if (r)
-			goto err_free;
-	}
-
-	amdgpu_bo_fence(bo, f, false);
-	amdgpu_bo_unreserve(bo);
-	amdgpu_bo_unref(&bo);
+				AMDGPU_FENCE_OWNER_UNDEFINED, &f);
+	if (r)
+		goto err_free;
 
 	if (fence)
 		*fence = dma_fence_get(f);
@@ -1159,10 +1154,6 @@ static int amdgpu_uvd_send_msg(struct amdgpu_ring *ring, struct amdgpu_bo *bo,
 
 err_free:
 	amdgpu_job_free(job);
-
-err:
-	amdgpu_bo_unreserve(bo);
-	amdgpu_bo_unref(&bo);
 	return r;
 }
 
@@ -1173,16 +1164,31 @@ int amdgpu_uvd_get_create_msg(struct amdgpu_ring *ring, uint32_t handle,
 			      struct dma_fence **fence)
 {
 	struct amdgpu_device *adev = ring->adev;
-	struct amdgpu_bo *bo = NULL;
+	struct amdgpu_bo *bo = adev->uvd.ib_bo;
+	struct dma_fence *f = NULL;
+	struct amdgpu_ib ib;
 	uint32_t *msg;
 	int r, i;
 
-	r = amdgpu_bo_create_reserved(adev, 1024, PAGE_SIZE,
-				      AMDGPU_GEM_DOMAIN_GTT,
-				      &bo, NULL, (void **)&msg);
-	if (r)
-		return r;
-
+	if (bo) {
+		r = amdgpu_bo_reserve(bo, true);
+		if (r)
+			return r;
+		r = dma_resv_wait_timeout(bo->tbo.base.resv, true, false,
+				msecs_to_jiffies(10));
+		if (r == 0)
+			r = -ETIMEDOUT;
+		if (r < 0)
+			goto err;
+		ib.gpu_addr = amdgpu_bo_gpu_offset(bo);
+		msg = adev->uvd.ib_bo_cpu_addr;
+	} else {
+		memset(&msg, 0, sizeof(msg));
+		r = amdgpu_ib_get(adev, NULL, PAGE_SIZE,
+				AMDGPU_IB_POOL_DIRECT,
+				&ib);
+		msg = ib.ptr;
+	}
 	/* stitch together an UVD create msg */
 	msg[0] = cpu_to_le32(0x00000de4);
 	msg[1] = cpu_to_le32(0x00000000);
@@ -1198,23 +1204,52 @@ int amdgpu_uvd_get_create_msg(struct amdgpu_ring *ring, uint32_t handle,
 	for (i = 11; i < 1024; ++i)
 		msg[i] = cpu_to_le32(0x0);
 
-	return amdgpu_uvd_send_msg(ring, bo, true, fence);
+	r = amdgpu_uvd_send_msg(ring, ib.gpu_addr, true, &f);
+	if (r)
+		goto err;
+	if (bo)
+		amdgpu_bo_fence(bo, f, false);
+	else
+		amdgpu_ib_free(adev, &ib, f);
+	if (fence)
+		*fence = dma_fence_get(f);
+	dma_fence_put(f);
+err:
+	if (bo)
+		amdgpu_bo_unreserve(bo);
+	return r;
 }
 
 int amdgpu_uvd_get_destroy_msg(struct amdgpu_ring *ring, uint32_t handle,
 			       bool direct, struct dma_fence **fence)
 {
 	struct amdgpu_device *adev = ring->adev;
-	struct amdgpu_bo *bo = NULL;
+	struct amdgpu_bo *bo = adev->uvd.ib_bo;
+	struct dma_fence *f = NULL;
+	struct amdgpu_ib ib;
 	uint32_t *msg;
 	int r, i;
 
-	r = amdgpu_bo_create_reserved(adev, 1024, PAGE_SIZE,
-				      AMDGPU_GEM_DOMAIN_GTT,
-				      &bo, NULL, (void **)&msg);
-	if (r)
-		return r;
-
+	if (bo) {
+		r = amdgpu_bo_reserve(bo, true);
+		if (r)
+			return r;
+		r = dma_resv_wait_timeout(bo->tbo.base.resv, true, false,
+				msecs_to_jiffies(10));
+		if (r == 0)
+			r = -ETIMEDOUT;
+		if (r < 0)
+			goto err;
+		ib.gpu_addr = amdgpu_bo_gpu_offset(bo);
+		msg = adev->uvd.ib_bo_cpu_addr;
+	} else {
+		memset(&msg, 0, sizeof(msg));
+		r = amdgpu_ib_get(adev, NULL, PAGE_SIZE,
+				direct ?
+				AMDGPU_IB_POOL_DIRECT : AMDGPU_IB_POOL_DELAYED,
+				&ib);
+		msg = ib.ptr;
+	}
 	/* stitch together an UVD destroy msg */
 	msg[0] = cpu_to_le32(0x00000de4);
 	msg[1] = cpu_to_le32(0x00000002);
@@ -1223,7 +1258,20 @@ int amdgpu_uvd_get_destroy_msg(struct amdgpu_ring *ring, uint32_t handle,
 	for (i = 4; i < 1024; ++i)
 		msg[i] = cpu_to_le32(0x0);
 
-	return amdgpu_uvd_send_msg(ring, bo, direct, fence);
+	r = amdgpu_uvd_send_msg(ring, ib.gpu_addr, true, &f);
+	if (r)
+		goto err;
+	if (bo)
+		amdgpu_bo_fence(bo, f, false);
+	else
+		amdgpu_ib_free(adev, &ib, f);
+	if (fence)
+		*fence = dma_fence_get(f);
+	dma_fence_put(f);
+err:
+	if (bo)
+		amdgpu_bo_unreserve(bo);
+	return r;
 }
 
 static void amdgpu_uvd_idle_work_handler(struct work_struct *work)
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.h
index edbb8194ee81..3ff49daf558c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.h
@@ -68,6 +68,8 @@ struct amdgpu_uvd {
 	/* store image width to adjust nb memory state */
 	unsigned		decode_image_width;
 	uint32_t                keyselect;
+	struct amdgpu_bo	*ib_bo;
+	void			*ib_bo_cpu_addr;
 };
 
 int amdgpu_uvd_sw_init(struct amdgpu_device *adev);
-- 
2.25.1

