Return-Path: <SRS0=wMah=N5=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FFCDC433EF
	for <amd-gfx@archiver.kernel.org>; Tue,  7 Sep 2021 12:26:55 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D4D9D60F45
	for <amd-gfx@archiver.kernel.org>; Tue,  7 Sep 2021 12:26:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org D4D9D60F45
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 50D6489343;
	Tue,  7 Sep 2021 12:26:54 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2044.outbound.protection.outlook.com [40.107.220.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A18D789343
 for <amd-gfx@lists.freedesktop.org>; Tue,  7 Sep 2021 12:26:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bIR/pKr2oLG6whnmKMl0bmwtHEfgI9UFbRK/Vvkad5zC5bgpjXn2C99kGHaaQB2RkVx76Z7QVMmjDsPJ1xAHUCfM1sfFgvmm59wIfT72OKd3HRER2kV+aMF2LiiHVGOQzqB1VYBl5CZ/x+l2fxkik2cbFu4Ea5XtIoQTs5JDRUtehgyg9znZz53npr4vYx2RLHQ19pULOtdv2yMrEpKQjaww60QQ9+QSoJyt6ACg8/l8KJHS+veja6Z0R2417+bL7nyvqth8rHgj9++5zOfkIPahuYR3Lznmq3R49hH56vX4Yg6Ud9KlMV5NQO66V4KjZKn5YuGO0oEQK/NrcB3YEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=2E0ItchvegdvbGb8xUPWP0AcItXVascu4rqEwZJXGEg=;
 b=kZFm9O7+LTMPwKAiQHKHZUscc3OuT5DOElE8aaTDcN0niPQJUv7dbwGLFz3SYp1MKPdMKPnSNuZZ+G7fXVfiMo30t5cQM7YDGgWqfoy6EJBlvwTFDGQYJzSIhb6M+mo8rASZTwAbk0vqDvmFADets+xv0RjVdCThdrrqxfCr7thND2muoo5r78i+vN3h/YNpGdnnnX/iPMo6IC/SG/1YKf0CfgJMFJsam7UVXbe2v802pqP24fEObkq6fWa/jmzuKmLNBMpAOyLc0FDNof3LNfkMO3Co/52GmSet90+AciiZgg9tW2WmHMdufPmqE+s2ZOQkwqCVcfW6IVVY3pnFtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2E0ItchvegdvbGb8xUPWP0AcItXVascu4rqEwZJXGEg=;
 b=FPLnDe81izb1HuSPsbnwqEc3eC5xe5Wu0u7Gw1Y5qXqooqjdBuXGqOI7Kmyd+pIXmn59dPryOu7+eDFgZF3odZ2ZemKtPUmZoszlPByErwulgsiLDoAh9bLML0jPfRJNOiOYm7i0T5ca0QKCUYvh3AecBRTOnn3ZEa8UpEC5380=
Received: from BN9PR03CA0776.namprd03.prod.outlook.com (2603:10b6:408:13a::31)
 by CO6PR12MB5460.namprd12.prod.outlook.com (2603:10b6:5:357::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.19; Tue, 7 Sep
 2021 12:26:51 +0000
Received: from BN8NAM11FT030.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:13a:cafe::68) by BN9PR03CA0776.outlook.office365.com
 (2603:10b6:408:13a::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.14 via Frontend
 Transport; Tue, 7 Sep 2021 12:26:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT030.mail.protection.outlook.com (10.13.177.146) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4478.19 via Frontend Transport; Tue, 7 Sep 2021 12:26:50 +0000
Received: from pp-server-two.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Tue, 7 Sep 2021
 07:26:49 -0500
From: xinhui pan <xinhui.pan@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <christian.koenig@amd.com>, <alexander.deucher@amd.com>, xinhui pan
 <xinhui.pan@amd.com>
Subject: [RFC PATCH v3] drm/amdgpu: alloc uvd msg from IB pool
Date: Tue, 7 Sep 2021 20:26:17 +0800
Message-ID: <20210907122617.5303-1-xinhui.pan@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a1daad29-80d9-4873-cb04-08d971fac4e7
X-MS-TrafficTypeDiagnostic: CO6PR12MB5460:
X-Microsoft-Antispam-PRVS: <CO6PR12MB54607BFF8B840F25775EDA5487D39@CO6PR12MB5460.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2803;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nxhQjxNLX7LsvVFv95kzu1c9k49xUgp/UW2e66OUUzEYZEL1+AWryzdrjK+HqFQypeI3Lj5xlyPPVROJavdAMUbvKtKArv1+uIVzCKCsTtObn8ygjnZC7eqyepUtkYG3yMMH543MCIHhlS+ASBnJ38B76cMjO3A1pOLNXyiRjIUPmmBNQk1hKwsfbzrDXniOQhoC2maDl3wMGPwyTdrgqsh9NzbC0RrXunzd6P82ppGGBvugmad5H/EeNQymGPgZk5m7ykrFB64ov02q1dbw9iZ9rNFteGVmMkxJ2FelA7ooXeSX9g9Hj9Qtc0ZevUbbiwjrW76/pRwOKj9miP3NFfC5iVOQ33yG1XJf/JO8wzdykXbc5X5g0U/VNfxAEc3cyjZzgVV81gdGA+pDnKWKSKsllxhpnRg7/hxsgExgJIbDDvp0YK4UF8p5liiUnhUzDRtoh8shcCrfzLMUvNmEbQGm6hPaOqZxFyBmUghPxKrIQL9gfujYDVoYRBfwNQITQSBoE6grmaxuNhCvencMLsXs5IptB/70YzGpewe9jPE1PRBJk0S113lwPBk3vfQAV6QdeQv6d7d9xfiMuaZUbmKRbYygPECraVCxoddnFrJR+gKofI5vAdyipqicEooYAHMpeBtaRycUdKF73MzCiZPnF79fMyvRE8kFMouIF+iXZHUtPDz4N3YRhPyt60oLj6nbr+xMcrFchM2zF0R8H8wCXBrJpmClsmLunwRIbJk=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(39860400002)(396003)(136003)(376002)(346002)(36840700001)(46966006)(70206006)(8936002)(70586007)(4326008)(478600001)(6916009)(36860700001)(47076005)(54906003)(82740400003)(2616005)(5660300002)(6666004)(8676002)(316002)(26005)(36756003)(2906002)(426003)(7696005)(336012)(356005)(83380400001)(86362001)(16526019)(82310400003)(81166007)(186003)(1076003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2021 12:26:50.8483 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a1daad29-80d9-4873-cb04-08d971fac4e7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT030.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR12MB5460
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
 drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c | 173 +++++++++++++++---------
 drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.h |   2 +
 2 files changed, 112 insertions(+), 63 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c
index d451c359606a..b741ab7b2468 100644
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
@@ -342,6 +369,8 @@ int amdgpu_uvd_sw_fini(struct amdgpu_device *adev)
 		for (i = 0; i < AMDGPU_MAX_UVD_ENC_RINGS; ++i)
 			amdgpu_ring_fini(&adev->uvd.inst[j].ring_enc[i]);
 	}
+	amdgpu_bo_free_kernel(&adev->uvd.ib_bo, NULL,
+			(void **)&adev->uvd.ib_bo_cpu_addr);
 	release_firmware(adev->uvd.fw);
 
 	return 0;
@@ -1066,7 +1095,7 @@ int amdgpu_uvd_ring_parse_cs(struct amdgpu_cs_parser *parser, uint32_t ib_idx)
 	return 0;
 }
 
-static int amdgpu_uvd_send_msg(struct amdgpu_ring *ring, struct amdgpu_bo *bo,
+static int amdgpu_uvd_send_msg(struct amdgpu_ring *ring, uint64_t addr,
 			       bool direct, struct dma_fence **fence)
 {
 	struct amdgpu_device *adev = ring->adev;
@@ -1074,29 +1103,15 @@ static int amdgpu_uvd_send_msg(struct amdgpu_ring *ring, struct amdgpu_bo *bo,
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
@@ -1110,7 +1125,6 @@ static int amdgpu_uvd_send_msg(struct amdgpu_ring *ring, struct amdgpu_bo *bo,
 	data[3] = PACKET0(offset[offset_idx] + UVD_NO_OP, 0);
 
 	ib = &job->ibs[0];
-	addr = amdgpu_bo_gpu_offset(bo);
 	ib->ptr[0] = data[0];
 	ib->ptr[1] = addr;
 	ib->ptr[2] = data[1];
@@ -1123,33 +1137,13 @@ static int amdgpu_uvd_send_msg(struct amdgpu_ring *ring, struct amdgpu_bo *bo,
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
@@ -1159,10 +1153,6 @@ static int amdgpu_uvd_send_msg(struct amdgpu_ring *ring, struct amdgpu_bo *bo,
 
 err_free:
 	amdgpu_job_free(job);
-
-err:
-	amdgpu_bo_unreserve(bo);
-	amdgpu_bo_unref(&bo);
 	return r;
 }
 
@@ -1173,16 +1163,31 @@ int amdgpu_uvd_get_create_msg(struct amdgpu_ring *ring, uint32_t handle,
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
@@ -1198,23 +1203,52 @@ int amdgpu_uvd_get_create_msg(struct amdgpu_ring *ring, uint32_t handle,
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
@@ -1223,7 +1257,20 @@ int amdgpu_uvd_get_destroy_msg(struct amdgpu_ring *ring, uint32_t handle,
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

