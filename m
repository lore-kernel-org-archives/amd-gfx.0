Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64A9EC433F5
	for <amd-gfx@archiver.kernel.org>; Fri, 29 Apr 2022 17:47:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B792F10F5A9;
	Fri, 29 Apr 2022 17:47:17 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2088.outbound.protection.outlook.com [40.107.94.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1B17310F232
 for <amd-gfx@lists.freedesktop.org>; Fri, 29 Apr 2022 17:47:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I0Gd1nsa/X9SzaVuQ+lEGLrU931sBooB+wYGuOj7CEfytfPUrg0k+KeYw0ZnzlzGXCX3IHCiiwVZv8nSP3WF7eturPv3ufFWeRbfUkYBLS/CJrb1rb7RjB6cOjWWG/6PsfL+dO6iE+tm4W7yDG++P23AxjM1ADrYdTasM+hNpuRcXud5sykkmLFja7wjFf5Ib8hFCLQ9O7IGewlMv8HYY6MFvhIEGsHP+vN6Z6vgjD4xupJO/a8jUteShVmI4rZJVG4P8W8mnILEamjwfedAqFoClvLtRv6A9/BqjNMJbfsXGC8jsQn2bLnbY4GX7s6f06C0eOQOMZhS2Wnk5uOLIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x3N5oi705KrtpTBFoo74YiriORwq9/7PN3AqBBOBpsg=;
 b=AiKAQdK+szkzkdvwLE8fiV5E6+fFGDWazO/x5Dt2RwxVXcEEGMMbFOgH1/U7hw2fYlosSJ4G+rJHz6hnm5ShQSISfLrUy+zFj2IXz8VeSPuFJxZI+N/LM/AWoTv834HFOe6h7xGhH77t+l1IFXW4j0gBYG7XWsDPHcg49w18kwWrIudieXqVFqgOi/lPJPQKLaIMy+1dC7HxyoK8eSWiMYZDfyojtkY9elbcM3i/xpMxR1Zi9X0vevcC5PNAlciQkWNOZMuqmfanmAQ2T/asdiFXK2mqYn0Yfw8ZNev3rLkvDFL2TFtehZNQJSgmeQyfKMHFsEZfdKqxgne8jXZaVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x3N5oi705KrtpTBFoo74YiriORwq9/7PN3AqBBOBpsg=;
 b=BsVo6wcfARVRxZEr5VHCvSrb4nIbudgGoRgQEOQ2LFJetWV3axjO8yuttkhsB4S8Bo8qhuhfe1sbS9s9y2day/wgJVlUr9aWs4bwexF8X5Xcvd7C8DoIXKavwa7puAEMdY6mTeX/Rn2WbD+YbA9nYgo4lB8ZAYG67AFFbcGY8b8=
Received: from DS7PR06CA0007.namprd06.prod.outlook.com (2603:10b6:8:2a::25) by
 PH0PR12MB5433.namprd12.prod.outlook.com (2603:10b6:510:e1::22) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5186.14; Fri, 29 Apr 2022 17:46:59 +0000
Received: from DM6NAM11FT050.eop-nam11.prod.protection.outlook.com
 (2603:10b6:8:2a:cafe::f6) by DS7PR06CA0007.outlook.office365.com
 (2603:10b6:8:2a::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.13 via Frontend
 Transport; Fri, 29 Apr 2022 17:46:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT050.mail.protection.outlook.com (10.13.173.111) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5206.12 via Frontend Transport; Fri, 29 Apr 2022 17:46:59 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Fri, 29 Apr
 2022 12:46:56 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 34/73] drm/amdgpu/sdma5: add mes support for sdma ib test
Date: Fri, 29 Apr 2022 13:45:45 -0400
Message-ID: <20220429174624.459475-35-alexander.deucher@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: 3d1a4644-83bc-4af9-4e1b-08da2a0842cd
X-MS-TrafficTypeDiagnostic: PH0PR12MB5433:EE_
X-Microsoft-Antispam-PRVS: <PH0PR12MB54334C573735B890E9140AC6F7FC9@PH0PR12MB5433.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GNrCZJrxSx1f+XsjIvGi0epkUqL6HnKjPraoBE8BGbAUM8He6g8srAd4bUzEDsfw5uDwsxS89lozgKwytWxepAzDAxw20hgvWCa3a5vavtzPBVTP/eg8pp+8HgkJWvHLxDOt4QIW6eTzu2Pmkz/+3LRCASsvL7Pbw1HBL0a6WfuZIqmUDTgFxQMOcekA0uJbzpVvBVczGo5ozR+OaA9Mug2vhclpXOkJBxVVjxiP/IcQ91oqEhT2gmhYT8wmMboy4sEOobdUG59u0YLBZnNB9tzZVPalski/36YlNPZioeDj1KHah9Z6kcx6MKHDDxOh/gfJFiYVzRbikTWOhO4dHqiU9OoTc4SGPLKyU3D/JzYMAxbu95VNWNoZo/8YZcOftFTvXbU62tl9DxApe1X6mKtmEJVlJteFz9yumz8VxEH7v+WvxhEjmOR1C2jxbtdsY5KF49wb+mB3yPETs9ddfQFpLJmbutcDxdNfTJ4PFrRr8d2TkbZOyjsZ8NkVAfZqvFUNm3mR56FcvC2Ron4aprdYp7+exQ8lnrL/kv/gfFTXYz3WJiq/Nng8/z6/04boleUcNOKA6Bsu1NultuBr5VAiVtrem3VQYQoIq5QmpIey6U98/btR+Fv0weXKE21QHmF+5/BK7vMMXkeaGmis43mxg2GwIJXvKx129xsaCkjloNOaPpWkntZoXbi43KHQvmTgOu1b0vKuRnapycUL3A==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(46966006)(36840700001)(40470700004)(7696005)(36860700001)(26005)(6666004)(426003)(336012)(1076003)(2616005)(16526019)(83380400001)(36756003)(186003)(47076005)(8936002)(8676002)(4326008)(5660300002)(2906002)(82310400005)(40460700003)(508600001)(86362001)(54906003)(70206006)(70586007)(6916009)(316002)(81166007)(356005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2022 17:46:59.4108 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d1a4644-83bc-4af9-4e1b-08da2a0842cd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT050.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5433
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

Add MES support for sdma ib test.

Signed-off-by: Jack Xiao <Jack.Xiao@amd.com>
Acked-by: Christian König <christian.koenig@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c | 50 ++++++++++++++++++--------
 1 file changed, 36 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
index 1f0b19e18494..1f9021f896a1 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
@@ -1098,22 +1098,38 @@ static int sdma_v5_0_ring_test_ib(struct amdgpu_ring *ring, long timeout)
 	long r;
 	u32 tmp = 0;
 	u64 gpu_addr;
+	volatile uint32_t *cpu_ptr = NULL;
 
-	r = amdgpu_device_wb_get(adev, &index);
-	if (r) {
-		dev_err(adev->dev, "(%ld) failed to allocate wb slot\n", r);
-		return r;
-	}
-
-	gpu_addr = adev->wb.gpu_addr + (index * 4);
 	tmp = 0xCAFEDEAD;
-	adev->wb.wb[index] = cpu_to_le32(tmp);
 	memset(&ib, 0, sizeof(ib));
-	r = amdgpu_ib_get(adev, NULL, 256,
+
+	if (ring->is_mes_queue) {
+		uint32_t offset = 0;
+		offset = amdgpu_mes_ctx_get_offs(ring, AMDGPU_MES_CTX_IB_OFFS);
+		ib.gpu_addr = amdgpu_mes_ctx_get_offs_gpu_addr(ring, offset);
+		ib.ptr = (void *)amdgpu_mes_ctx_get_offs_cpu_addr(ring, offset);
+
+		offset = amdgpu_mes_ctx_get_offs(ring,
+					 AMDGPU_MES_CTX_PADDING_OFFS);
+		gpu_addr = amdgpu_mes_ctx_get_offs_gpu_addr(ring, offset);
+		cpu_ptr = amdgpu_mes_ctx_get_offs_cpu_addr(ring, offset);
+		*cpu_ptr = tmp;
+	} else {
+		r = amdgpu_device_wb_get(adev, &index);
+		if (r) {
+			dev_err(adev->dev, "(%ld) failed to allocate wb slot\n", r);
+			return r;
+		}
+
+		gpu_addr = adev->wb.gpu_addr + (index * 4);
+		adev->wb.wb[index] = cpu_to_le32(tmp);
+
+		r = amdgpu_ib_get(adev, NULL, 256,
 					AMDGPU_IB_POOL_DIRECT, &ib);
-	if (r) {
-		DRM_ERROR("amdgpu: failed to get ib (%ld).\n", r);
-		goto err0;
+		if (r) {
+			DRM_ERROR("amdgpu: failed to get ib (%ld).\n", r);
+			goto err0;
+		}
 	}
 
 	ib.ptr[0] = SDMA_PKT_HEADER_OP(SDMA_OP_WRITE) |
@@ -1140,7 +1156,12 @@ static int sdma_v5_0_ring_test_ib(struct amdgpu_ring *ring, long timeout)
 		DRM_ERROR("amdgpu: fence wait failed (%ld).\n", r);
 		goto err1;
 	}
-	tmp = le32_to_cpu(adev->wb.wb[index]);
+
+	if (ring->is_mes_queue)
+		tmp = le32_to_cpu(*cpu_ptr);
+	else
+		tmp = le32_to_cpu(adev->wb.wb[index]);
+
 	if (tmp == 0xDEADBEEF)
 		r = 0;
 	else
@@ -1150,7 +1171,8 @@ static int sdma_v5_0_ring_test_ib(struct amdgpu_ring *ring, long timeout)
 	amdgpu_ib_free(adev, &ib, NULL);
 	dma_fence_put(f);
 err0:
-	amdgpu_device_wb_free(adev, index);
+	if (!ring->is_mes_queue)
+		amdgpu_device_wb_free(adev, index);
 	return r;
 }
 
-- 
2.35.1

