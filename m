Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70A81C433EF
	for <amd-gfx@archiver.kernel.org>; Fri, 29 Apr 2022 17:46:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0A4FC10F138;
	Fri, 29 Apr 2022 17:46:46 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam07on2082.outbound.protection.outlook.com [40.107.95.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4775810F126
 for <amd-gfx@lists.freedesktop.org>; Fri, 29 Apr 2022 17:46:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k451a+c/3hsXGYXLJt5SeJIHz0o4QJKE9AOROK4L5ZFBrUqghE6upAMJia71b+b8Fx5+HQSKB7UIwZx5asO52kkQ3svX1uoTExFzRHcMNLp+U+4wGDsHnDJAjlNqIJf6AUWFOEQaTVjKWHnlWXa+W56i/ON0kbXrTgmloME8GWyDINvPRJLU4Dnjys2XrL3jcnj+411CyS+y6letolgPzTqqJrmp401OSDzOQYhQU0DcM+gX6W9hCR2u9dXr1fay/hEZ65ehKw2qrB2NPO80L5BFmlRZ1SQj1OH9k0WSS4kAUrenR3UbYpSeJuhhX2MFLTO8hj5W3IO0ew+YoKaMiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KTZl8I5Yb8F3M4uFoqm9QzmYovSLtP5zdBxDOj4jFFI=;
 b=ggQx5srpp7jhLEt4Lq36ugZZpxbpuxJg56K8t8k8eQBQhpT7fEttHkczFLy9tL0BglliapIBKt0Ms61ENmUJbmxM5fjYrG8Puy7SV9+ml5Q0t93Nu5jtWEjTG2bS+kUoho7LksGpyV3+btM5IRe2ZuAqhd2pLTcZwaVaEuX41+Jwgfstk/bKCMEbU6GJUKKnAGY1SrGP2oTpGjnrIA8PpOp3sODQjDv2H2byTr8DL67rc0sXCXrz5aRRMsdOrJJrisdLPtG/ZVBODsH+axoCSyIrGBhFFGbuDuV1siHDbc/XGGQRl+xIcNpH9UkHV954joJTXbrZsCEwbnRpNfL2Ug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KTZl8I5Yb8F3M4uFoqm9QzmYovSLtP5zdBxDOj4jFFI=;
 b=a6u2I1yNg734h2lclaZNGqpanww8wRfojNjMy/0Q65taxD42LIn4B1cHHxj7RImw1/kDGWUgZN+KWWxcYJCjHazIsGVQqeTHfGd1r/El788yucB25+Ndgv2YrB72MWa780iVI8R2C1Gk2fVQTn271lYa6AWNUIeOYRTvDqrC5Zs=
Received: from DM5PR08CA0039.namprd08.prod.outlook.com (2603:10b6:4:60::28) by
 BYAPR12MB3496.namprd12.prod.outlook.com (2603:10b6:a03:d8::26) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5186.20; Fri, 29 Apr 2022 17:46:42 +0000
Received: from DM6NAM11FT006.eop-nam11.prod.protection.outlook.com
 (2603:10b6:4:60:cafe::33) by DM5PR08CA0039.outlook.office365.com
 (2603:10b6:4:60::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.23 via Frontend
 Transport; Fri, 29 Apr 2022 17:46:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT006.mail.protection.outlook.com (10.13.173.104) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5206.12 via Frontend Transport; Fri, 29 Apr 2022 17:46:41 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Fri, 29 Apr
 2022 12:46:40 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 07/73] drm/amdgpu: initialize/finalize the ring for mes queue
Date: Fri, 29 Apr 2022 13:45:18 -0400
Message-ID: <20220429174624.459475-8-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220429174624.459475-1-alexander.deucher@amd.com>
References: <20220429174624.459475-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 44b0a025-b212-4582-08b2-08da2a08384a
X-MS-TrafficTypeDiagnostic: BYAPR12MB3496:EE_
X-Microsoft-Antispam-PRVS: <BYAPR12MB34965E90DD85AFE6863B1B66F7FC9@BYAPR12MB3496.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ti2JUS/MnDm1qAxLDyWENshr2pvCEdgA9ra0Xb/duzNG5FxnIB1c7cYuAwy7CtLpWqFr+r1tCKzOmdkdjg+/j8hRzq/MCln2Ct+mNe0pPBMxasnFJBnZVkPmrDMzFnTViDV/HV2j7ucDkH3yLimh/akZLLouPW5JoLF6Po92vb1ohyRp9p94mWow/tnOSnw8eJ/4JA71I0cjTRunxXPsNC1HrWLfXYTyeewW8oF9ruVtMU5Rnjl11iL+50VMoZ1pW4mMEeV03dEohMWksWzGh+/SYoIlOMXEsen1tQPZivXern99Q734x2v0TRFjmYQTTs9g4OWfR1iVpU+inb4ozsC8PaGxjLTGbTlu4/VZRy48zDqDn19LLdsYjuIDIFkSneS6II+uwhz6y40VNNmGfAL9PKej8vcTSOwG5lejnd0U/51nEX7rp8Xn2doBnStNcR5TK60sCBppu44injapYbECgaX8ySFdoQDaS+elyfABIjvLLjHS6iSfYgeQljUxP0iu0BMYqM2VYQY3o54uIK5/wSvmT6AcY+ValPqvYgq9tY1GYY4ho7FlR5bRiB/tjdPAT85hTgQd3rY5G8ojCqYxL4N5HGp+JZTUqn0h6nukHe1xE1ZiziuAdWUBXr9yuTpWJRNs0+4qz6eIJPGmiV2fJi/xbC2MeE8NTQGEK+2qfuoXxpdpGpE0dVNCuGi+6jLeqlzCyGKQBA1CwtwDnQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(36840700001)(40470700004)(46966006)(70586007)(70206006)(4326008)(8676002)(5660300002)(82310400005)(8936002)(356005)(6666004)(83380400001)(426003)(336012)(47076005)(7696005)(2616005)(2906002)(26005)(86362001)(81166007)(1076003)(36860700001)(16526019)(186003)(316002)(40460700003)(6916009)(54906003)(508600001)(36756003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2022 17:46:41.7733 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 44b0a025-b212-4582-08b2-08da2a08384a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT006.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3496
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Jack Xiao <Jack.Xiao@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Jack Xiao <Jack.Xiao@amd.com>

Iniailize/finalize the ring for mes queue which submits the command
stream to the mes-managed hardware queue.

Signed-off-by: Jack Xiao <Jack.Xiao@amd.com>
Acked-by: Christian König <christian.koenig@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c | 145 ++++++++++++++++-------
 1 file changed, 104 insertions(+), 41 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
index 773954318216..13db99d653bd 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
@@ -149,6 +149,16 @@ void amdgpu_ring_undo(struct amdgpu_ring *ring)
 		ring->funcs->end_use(ring);
 }
 
+#define amdgpu_ring_get_gpu_addr(ring, offset)				\
+	(ring->is_mes_queue ?						\
+	 (ring->mes_ctx->meta_data_gpu_addr + offset) :			\
+	 (ring->adev->wb.gpu_addr + offset * 4))
+
+#define amdgpu_ring_get_cpu_addr(ring, offset)				\
+	(ring->is_mes_queue ?						\
+	 (void *)((uint8_t *)(ring->mes_ctx->meta_data_ptr) + offset) : \
+	 (&ring->adev->wb.wb[offset]))
+
 /**
  * amdgpu_ring_init - init driver ring struct.
  *
@@ -189,51 +199,88 @@ int amdgpu_ring_init(struct amdgpu_device *adev, struct amdgpu_ring *ring,
 			return -EINVAL;
 
 		ring->adev = adev;
-		ring->idx = adev->num_rings++;
-		adev->rings[ring->idx] = ring;
 		ring->num_hw_submission = sched_hw_submission;
 		ring->sched_score = sched_score;
 		ring->vmid_wait = dma_fence_get_stub();
+
+		if (!ring->is_mes_queue) {
+			ring->idx = adev->num_rings++;
+			adev->rings[ring->idx] = ring;
+		}
+
 		r = amdgpu_fence_driver_init_ring(ring);
 		if (r)
 			return r;
 	}
 
-	r = amdgpu_device_wb_get(adev, &ring->rptr_offs);
-	if (r) {
-		dev_err(adev->dev, "(%d) ring rptr_offs wb alloc failed\n", r);
-		return r;
-	}
+	if (ring->is_mes_queue) {
+		ring->rptr_offs = amdgpu_mes_ctx_get_offs(ring,
+				AMDGPU_MES_CTX_RPTR_OFFS);
+		ring->wptr_offs = amdgpu_mes_ctx_get_offs(ring,
+				AMDGPU_MES_CTX_WPTR_OFFS);
+		ring->fence_offs = amdgpu_mes_ctx_get_offs(ring,
+				AMDGPU_MES_CTX_FENCE_OFFS);
+		ring->trail_fence_offs = amdgpu_mes_ctx_get_offs(ring,
+				AMDGPU_MES_CTX_TRAIL_FENCE_OFFS);
+		ring->cond_exe_offs = amdgpu_mes_ctx_get_offs(ring,
+				AMDGPU_MES_CTX_COND_EXE_OFFS);
+	} else {
+		r = amdgpu_device_wb_get(adev, &ring->rptr_offs);
+		if (r) {
+			dev_err(adev->dev, "(%d) ring rptr_offs wb alloc failed\n", r);
+			return r;
+		}
 
-	r = amdgpu_device_wb_get(adev, &ring->wptr_offs);
-	if (r) {
-		dev_err(adev->dev, "(%d) ring wptr_offs wb alloc failed\n", r);
-		return r;
-	}
+		r = amdgpu_device_wb_get(adev, &ring->wptr_offs);
+		if (r) {
+			dev_err(adev->dev, "(%d) ring wptr_offs wb alloc failed\n", r);
+			return r;
+		}
 
-	r = amdgpu_device_wb_get(adev, &ring->fence_offs);
-	if (r) {
-		dev_err(adev->dev, "(%d) ring fence_offs wb alloc failed\n", r);
-		return r;
-	}
+		r = amdgpu_device_wb_get(adev, &ring->fence_offs);
+		if (r) {
+			dev_err(adev->dev, "(%d) ring fence_offs wb alloc failed\n", r);
+			return r;
+		}
 
-	r = amdgpu_device_wb_get(adev, &ring->trail_fence_offs);
-	if (r) {
-		dev_err(adev->dev,
-			"(%d) ring trail_fence_offs wb alloc failed\n", r);
-		return r;
+		r = amdgpu_device_wb_get(adev, &ring->trail_fence_offs);
+		if (r) {
+			dev_err(adev->dev, "(%d) ring trail_fence_offs wb alloc failed\n", r);
+			return r;
+		}
+
+		r = amdgpu_device_wb_get(adev, &ring->cond_exe_offs);
+		if (r) {
+			dev_err(adev->dev, "(%d) ring cond_exec_polling wb alloc failed\n", r);
+			return r;
+		}
 	}
+
+	ring->fence_gpu_addr =
+		amdgpu_ring_get_gpu_addr(ring, ring->fence_offs);
+	ring->fence_cpu_addr =
+		amdgpu_ring_get_cpu_addr(ring, ring->fence_offs);
+
+	ring->rptr_gpu_addr =
+		amdgpu_ring_get_gpu_addr(ring, ring->rptr_offs);
+	ring->rptr_cpu_addr =
+		amdgpu_ring_get_cpu_addr(ring, ring->rptr_offs);
+
+	ring->wptr_gpu_addr =
+		amdgpu_ring_get_gpu_addr(ring, ring->wptr_offs);
+	ring->wptr_cpu_addr =
+		amdgpu_ring_get_cpu_addr(ring, ring->wptr_offs);
+
 	ring->trail_fence_gpu_addr =
-		adev->wb.gpu_addr + (ring->trail_fence_offs * 4);
-	ring->trail_fence_cpu_addr = &adev->wb.wb[ring->trail_fence_offs];
+		amdgpu_ring_get_gpu_addr(ring, ring->trail_fence_offs);
+	ring->trail_fence_cpu_addr =
+		amdgpu_ring_get_cpu_addr(ring, ring->trail_fence_offs);
+
+	ring->cond_exe_gpu_addr =
+		amdgpu_ring_get_gpu_addr(ring, ring->cond_exe_offs);
+	ring->cond_exe_cpu_addr =
+		amdgpu_ring_get_cpu_addr(ring, ring->cond_exe_offs);
 
-	r = amdgpu_device_wb_get(adev, &ring->cond_exe_offs);
-	if (r) {
-		dev_err(adev->dev, "(%d) ring cond_exec_polling wb alloc failed\n", r);
-		return r;
-	}
-	ring->cond_exe_gpu_addr = adev->wb.gpu_addr + (ring->cond_exe_offs * 4);
-	ring->cond_exe_cpu_addr = &adev->wb.wb[ring->cond_exe_offs];
 	/* always set cond_exec_polling to CONTINUE */
 	*ring->cond_exe_cpu_addr = 1;
 
@@ -248,8 +295,20 @@ int amdgpu_ring_init(struct amdgpu_device *adev, struct amdgpu_ring *ring,
 	ring->buf_mask = (ring->ring_size / 4) - 1;
 	ring->ptr_mask = ring->funcs->support_64bit_ptrs ?
 		0xffffffffffffffff : ring->buf_mask;
+
 	/* Allocate ring buffer */
-	if (ring->ring_obj == NULL) {
+	if (ring->is_mes_queue) {
+		int offset = 0;
+
+		BUG_ON(ring->ring_size > PAGE_SIZE*4);
+
+		offset = amdgpu_mes_ctx_get_offs(ring,
+					 AMDGPU_MES_CTX_RING_OFFS);
+		ring->gpu_addr = amdgpu_mes_ctx_get_offs_gpu_addr(ring, offset);
+		ring->ring = amdgpu_mes_ctx_get_offs_cpu_addr(ring, offset);
+		amdgpu_ring_clear_ring(ring);
+
+	} else if (ring->ring_obj == NULL) {
 		r = amdgpu_bo_create_kernel(adev, ring->ring_size + ring->funcs->extra_dw, PAGE_SIZE,
 					    AMDGPU_GEM_DOMAIN_GTT,
 					    &ring->ring_obj,
@@ -286,26 +345,30 @@ void amdgpu_ring_fini(struct amdgpu_ring *ring)
 {
 
 	/* Not to finish a ring which is not initialized */
-	if (!(ring->adev) || !(ring->adev->rings[ring->idx]))
+	if (!(ring->adev) ||
+	    (!ring->is_mes_queue && !(ring->adev->rings[ring->idx])))
 		return;
 
 	ring->sched.ready = false;
 
-	amdgpu_device_wb_free(ring->adev, ring->rptr_offs);
-	amdgpu_device_wb_free(ring->adev, ring->wptr_offs);
+	if (!ring->is_mes_queue) {
+		amdgpu_device_wb_free(ring->adev, ring->rptr_offs);
+		amdgpu_device_wb_free(ring->adev, ring->wptr_offs);
 
-	amdgpu_device_wb_free(ring->adev, ring->cond_exe_offs);
-	amdgpu_device_wb_free(ring->adev, ring->fence_offs);
+		amdgpu_device_wb_free(ring->adev, ring->cond_exe_offs);
+		amdgpu_device_wb_free(ring->adev, ring->fence_offs);
 
-	amdgpu_bo_free_kernel(&ring->ring_obj,
-			      &ring->gpu_addr,
-			      (void **)&ring->ring);
+		amdgpu_bo_free_kernel(&ring->ring_obj,
+				      &ring->gpu_addr,
+				      (void **)&ring->ring);
+	}
 
 	dma_fence_put(ring->vmid_wait);
 	ring->vmid_wait = NULL;
 	ring->me = 0;
 
-	ring->adev->rings[ring->idx] = NULL;
+	if (!ring->is_mes_queue)
+		ring->adev->rings[ring->idx] = NULL;
 }
 
 /**
-- 
2.35.1

