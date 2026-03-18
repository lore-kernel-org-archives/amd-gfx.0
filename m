Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1345D1077605
	for <amd-gfx@archiver.kernel.org>; Wed, 18 Mar 2026 18:36:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7150210E716;
	Wed, 18 Mar 2026 18:36:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="DCXPHsQJ";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010007.outbound.protection.outlook.com [52.101.46.7])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D6E0610E43D
 for <amd-gfx@lists.freedesktop.org>; Wed, 18 Mar 2026 18:36:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CVph1HhIjFju3X+f9zWjSPx2sDtTqtcO+9DXXngg/+ONGqM9LLilzDq4BDSbU0U1NM0QCJnAKdZUugtm2PvviPP/GXmZGxV2vssM+E2rsjriIqU6zACTkhBjNDKYTsnhxrw2nVStk3EuMvZbYrGkybJETspIlucnxQcvsEQalxAyocLQlXrqXVgmTKqmbJ06YHRHeypVczSkfQZ5VwpSXV9t8ewY+xReczXUUtzjiYAS9lxOvhI+76q0d0xhKcz50dUIZlEKjz3zHpSKG2r9XU6BxYQt05umYbZodE4CoYawK1ae38zeNYd6egb8waYaOw+y21GVI6FMNFGJMFJevA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iuwgILsIAkqBzmmPlXygaYmgkRQrXV6WG1/MGJer5MI=;
 b=nqyueEF3fkdlY6IffLASiHmCHxu51IW44NjXkAr6dYj8v7Y6iva10K0PaxILjDYG8kSKV08hd5cjfsoOqSEVA7xL0QA1AGdwVrt0mdS0VuAt1p1BbmvHw70I3K9jJHZUQS1fjzqtZrR6f6i9nj8dSvobMb8HhvcZ34NxbvYZr7zn1OaJmlbiA3ZgbNM598XAQzZ3hZ+L4cWBVDLq7SS7aOAQbI1dZ/0BOk0BLk7e9quz16d09JJxFNb4arSGarT/+yls/cPnoRqHJMcx5+lPmIe2RxiY4PdE4XlPOusO19PRACDpPHRTLbbBZZf6vhv9aCbDgKdr+7KuqVzDgBf0zw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iuwgILsIAkqBzmmPlXygaYmgkRQrXV6WG1/MGJer5MI=;
 b=DCXPHsQJlLQHPbYsHXmnHgZBZZCaaKfqwixhVxPzG4WkvG7NSb0mlqwmDPtb03l8cW+insW5Uupbb8t18YeDHnIZllk+v9T5A2gmmlf7QJmmAn6WgELPT7+jxvzut/eX74priKHIP9BaWe3Xgk/lrzSarRFV9iLiwbziWOyK0Bo=
Received: from BN0PR04CA0018.namprd04.prod.outlook.com (2603:10b6:408:ee::23)
 by CYYPR12MB9014.namprd12.prod.outlook.com (2603:10b6:930:bf::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.19; Wed, 18 Mar
 2026 18:36:20 +0000
Received: from MN1PEPF0000F0E3.namprd04.prod.outlook.com
 (2603:10b6:408:ee:cafe::e3) by BN0PR04CA0018.outlook.office365.com
 (2603:10b6:408:ee::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9700.27 via Frontend Transport; Wed,
 18 Mar 2026 18:35:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 MN1PEPF0000F0E3.mail.protection.outlook.com (10.167.242.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9723.19 via Frontend Transport; Wed, 18 Mar 2026 18:36:18 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Wed, 18 Mar
 2026 13:36:13 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 18 Mar
 2026 13:36:12 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Wed, 18 Mar 2026 13:36:12 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>, Pierre-Eric Pelloux-Prayer
 <pierre-eric.pelloux-prayer@amd.com>, =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
Subject: [PATCH 2/7] drm/amdgpu: switch all IPs to using job for IBs
Date: Wed, 18 Mar 2026 14:35:59 -0400
Message-ID: <20260318183604.16505-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260318183604.16505-1-alexander.deucher@amd.com>
References: <20260318183604.16505-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Received-SPF: None (SATLEXMB03.amd.com: alexander.deucher@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0E3:EE_|CYYPR12MB9014:EE_
X-MS-Office365-Filtering-Correlation-Id: 5d1d193b-897c-4d17-2b40-08de851d3e89
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|36860700016|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: J601IUDA3XidDJ2n4y4ZnK0Fv3u9w9FO+D906cpT2KZotieGpPBx81bhvp1UJc0p2bDl3/vhL43RR8JiO1P1AyIybsb5+LK875Ey3Zk4qB21Y8Os4xgl6XDVSVnQPALfTgJKu+B7iLRItC0c2Gi/YXH86Q3rd+AexImONTYrhkXNNymVtp9UGDDP8ampqHrCfd0e5RNnkYc2oogvQKM6+L6OpJeO+wcOCL/gNfxe7TQVFxgCZoLFlCwhQLAh8aSfWp1ZX1astg3w/3I3McwidLeA1a6Q2AWgbDWSRZS3hx2eHjmYu+Zt0EOsG6C1gjbXDWcl8lUE0BcAy4eUDaOLHUJG38Q4duOuP3bGcuYZpo8CZw3FrmL0wQc/PgNSOjAmFOUgdZeKRVkgL5v55SYFmXciSy7ImOKn6Ctw86cZ1j1l7w09xzYn4qz4t3aKyDzE+CHt7LEVldCDWN+26EQyJgWef74mOaWhdSy0550Ix78gaGBKsZErtEbdtZa1jmlTT3ObR6UObxKXxr14oAOhEaHW98FgV3vagVr9DW5RcF0pz9FvVdrRmuOqQs7dxn23lcSJYlMEs9NLa3fYJSpQr7kOQsmfPmpNqQwVMiZ38D6AxvixCVY6Kqglhn+WqKWrmknAzNazFATbrXQ2tU1pAjVokJHV36MNOrc0nhG60VIm8WTL1KyYD3/a05Qqn7pubQfWguoHuL4JiSUPwA5J3K/AXSZpBsdhEV1vkBazQW9eeowlG+xhAY3Ysp7Kf+avVU7ZUDPRxaDFPHBiN90Gfw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(376014)(36860700016)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 3SWp4zuVFuaADHVtpw6ZZ4di1WijP/E9KrVB+Qj8RBKsTIWUcS5XtmPX8HsnKwCZAuAiDV8am3cnUwyeFzukuhHt0dCuhgt9WaY2SOZud5wdBpbxzi5f+JI4gZKtKbOJNqfNKK532UaihQlFNsZcLYJ98Ki3BHt/AxWlJ7BBIzqHvxrXcGezeZhXGo8K/GCuB1ctgZ1NLKLDOzVEBg8JUVRU1VxJGvMcT6w1KqQrNp9isdeO8PxcBexYDjhjnjS5xAWFDWVzlJ7WIaZvrYOfJrX6eHJKo+LvxrC8gM4OLqYt4WEupxTY2gSGMDj50ZJuXW387nAbfDRFffSPumkgQWpcsce6Ak7770d4KGjuAsIYFzEKbipvFRcBdrNi6sVTrYv4tNrjmXiRYM3btMCoZxboYOfqy+Y0QDGPcDkp+ZjjoeUcAjKRi70mxsbrmtCY
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2026 18:36:18.2463 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d1d193b-897c-4d17-2b40-08de851d3e89
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000F0E3.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB9014
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

Switch to using a job structure for IBs.

v2: fix missing ib pointer setup spotted by the kernel test robot

Acked-by: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
Acked-by: Christian König <christian.koenig@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c  |  37 +++---
 drivers/gpu/drm/amd/amdgpu/cik_sdma.c    |  31 ++---
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c   |  29 ++---
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c   |  29 ++---
 drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c   |  29 ++---
 drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c   |  29 ++---
 drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c    |  24 ++--
 drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c    |  25 ++--
 drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c    | 139 ++++++++++++-----------
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c    | 139 ++++++++++++-----------
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.c  |  27 ++---
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c  |  29 ++---
 drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c   |  38 ++++---
 drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c   |  38 ++++---
 drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c   |  38 ++++---
 drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c |  38 ++++---
 drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c   |  37 +++---
 drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c   |  36 +++---
 drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c   |  36 +++---
 drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c   |  36 +++---
 drivers/gpu/drm/amd/amdgpu/sdma_v7_1.c   |  36 +++---
 drivers/gpu/drm/amd/amdgpu/si_dma.c      |  29 +++--
 22 files changed, 502 insertions(+), 427 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c
index fd881388d6125..9fb1946be1ba2 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c
@@ -817,7 +817,8 @@ static int vpe_ring_test_ib(struct amdgpu_ring *ring, long timeout)
 {
 	struct amdgpu_device *adev = ring->adev;
 	const uint32_t test_pattern = 0xdeadbeef;
-	struct amdgpu_ib ib = {};
+	struct amdgpu_job *job;
+	struct amdgpu_ib *ib;
 	struct dma_fence *f = NULL;
 	uint32_t index;
 	uint64_t wb_addr;
@@ -832,23 +833,28 @@ static int vpe_ring_test_ib(struct amdgpu_ring *ring, long timeout)
 	adev->wb.wb[index] = 0;
 	wb_addr = adev->wb.gpu_addr + (index * 4);
 
-	ret = amdgpu_ib_get(adev, NULL, 256, AMDGPU_IB_POOL_DIRECT, &ib);
+	ret = amdgpu_job_alloc_with_ib(ring->adev, NULL, NULL, 256,
+				       AMDGPU_IB_POOL_DIRECT, &job,
+				       AMDGPU_KERNEL_JOB_ID_VPE_RING_TEST);
 	if (ret)
 		goto err0;
-
-	ib.ptr[0] = VPE_CMD_HEADER(VPE_CMD_OPCODE_FENCE, 0);
-	ib.ptr[1] = lower_32_bits(wb_addr);
-	ib.ptr[2] = upper_32_bits(wb_addr);
-	ib.ptr[3] = test_pattern;
-	ib.ptr[4] = VPE_CMD_HEADER(VPE_CMD_OPCODE_NOP, 0);
-	ib.ptr[5] = VPE_CMD_HEADER(VPE_CMD_OPCODE_NOP, 0);
-	ib.ptr[6] = VPE_CMD_HEADER(VPE_CMD_OPCODE_NOP, 0);
-	ib.ptr[7] = VPE_CMD_HEADER(VPE_CMD_OPCODE_NOP, 0);
-	ib.length_dw = 8;
-
-	ret = amdgpu_ib_schedule(ring, 1, &ib, NULL, &f);
-	if (ret)
+	ib = &job->ibs[0];
+
+	ib->ptr[0] = VPE_CMD_HEADER(VPE_CMD_OPCODE_FENCE, 0);
+	ib->ptr[1] = lower_32_bits(wb_addr);
+	ib->ptr[2] = upper_32_bits(wb_addr);
+	ib->ptr[3] = test_pattern;
+	ib->ptr[4] = VPE_CMD_HEADER(VPE_CMD_OPCODE_NOP, 0);
+	ib->ptr[5] = VPE_CMD_HEADER(VPE_CMD_OPCODE_NOP, 0);
+	ib->ptr[6] = VPE_CMD_HEADER(VPE_CMD_OPCODE_NOP, 0);
+	ib->ptr[7] = VPE_CMD_HEADER(VPE_CMD_OPCODE_NOP, 0);
+	ib->length_dw = 8;
+
+	ret = amdgpu_job_submit_direct(job, ring, &f);
+	if (ret) {
+		amdgpu_job_free(job);
 		goto err1;
+	}
 
 	ret = dma_fence_wait_timeout(f, false, timeout);
 	if (ret <= 0) {
@@ -859,7 +865,6 @@ static int vpe_ring_test_ib(struct amdgpu_ring *ring, long timeout)
 	ret = (le32_to_cpu(adev->wb.wb[index]) == test_pattern) ? 0 : -EINVAL;
 
 err1:
-	amdgpu_ib_free(&ib, NULL);
 	dma_fence_put(f);
 err0:
 	amdgpu_device_wb_free(adev, index);
diff --git a/drivers/gpu/drm/amd/amdgpu/cik_sdma.c b/drivers/gpu/drm/amd/amdgpu/cik_sdma.c
index 22780c09177d8..c6fccb92e656c 100644
--- a/drivers/gpu/drm/amd/amdgpu/cik_sdma.c
+++ b/drivers/gpu/drm/amd/amdgpu/cik_sdma.c
@@ -651,7 +651,8 @@ static int cik_sdma_ring_test_ring(struct amdgpu_ring *ring)
 static int cik_sdma_ring_test_ib(struct amdgpu_ring *ring, long timeout)
 {
 	struct amdgpu_device *adev = ring->adev;
-	struct amdgpu_ib ib;
+	struct amdgpu_job *job;
+	struct amdgpu_ib *ib;
 	struct dma_fence *f = NULL;
 	unsigned index;
 	u32 tmp = 0;
@@ -665,22 +666,27 @@ static int cik_sdma_ring_test_ib(struct amdgpu_ring *ring, long timeout)
 	gpu_addr = adev->wb.gpu_addr + (index * 4);
 	tmp = 0xCAFEDEAD;
 	adev->wb.wb[index] = cpu_to_le32(tmp);
-	memset(&ib, 0, sizeof(ib));
-	r = amdgpu_ib_get(adev, NULL, 256,
-					AMDGPU_IB_POOL_DIRECT, &ib);
+
+	r = amdgpu_job_alloc_with_ib(ring->adev, NULL, NULL, 256,
+				     AMDGPU_IB_POOL_DIRECT, &job,
+				     AMDGPU_KERNEL_JOB_ID_SDMA_RING_TEST);
 	if (r)
 		goto err0;
+	ib = &job->ibs[0];
 
-	ib.ptr[0] = SDMA_PACKET(SDMA_OPCODE_WRITE,
+	ib->ptr[0] = SDMA_PACKET(SDMA_OPCODE_WRITE,
 				SDMA_WRITE_SUB_OPCODE_LINEAR, 0);
-	ib.ptr[1] = lower_32_bits(gpu_addr);
-	ib.ptr[2] = upper_32_bits(gpu_addr);
-	ib.ptr[3] = 1;
-	ib.ptr[4] = 0xDEADBEEF;
-	ib.length_dw = 5;
-	r = amdgpu_ib_schedule(ring, 1, &ib, NULL, &f);
-	if (r)
+	ib->ptr[1] = lower_32_bits(gpu_addr);
+	ib->ptr[2] = upper_32_bits(gpu_addr);
+	ib->ptr[3] = 1;
+	ib->ptr[4] = 0xDEADBEEF;
+	ib->length_dw = 5;
+
+	r = amdgpu_job_submit_direct(job, ring, &f);
+	if (r) {
+		amdgpu_job_free(job);
 		goto err1;
+	}
 
 	r = dma_fence_wait_timeout(f, false, timeout);
 	if (r == 0) {
@@ -696,7 +702,6 @@ static int cik_sdma_ring_test_ib(struct amdgpu_ring *ring, long timeout)
 		r = -EINVAL;
 
 err1:
-	amdgpu_ib_free(&ib, NULL);
 	dma_fence_put(f);
 err0:
 	amdgpu_device_wb_free(adev, index);
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
index 1893ceeeb26c8..50954b60e49df 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -4071,15 +4071,14 @@ static int gfx_v10_0_ring_test_ring(struct amdgpu_ring *ring)
 static int gfx_v10_0_ring_test_ib(struct amdgpu_ring *ring, long timeout)
 {
 	struct amdgpu_device *adev = ring->adev;
-	struct amdgpu_ib ib;
+	struct amdgpu_job *job;
+	struct amdgpu_ib *ib;
 	struct dma_fence *f = NULL;
 	unsigned int index;
 	uint64_t gpu_addr;
 	uint32_t *cpu_ptr;
 	long r;
 
-	memset(&ib, 0, sizeof(ib));
-
 	r = amdgpu_device_wb_get(adev, &index);
 	if (r)
 		return r;
@@ -4088,22 +4087,27 @@ static int gfx_v10_0_ring_test_ib(struct amdgpu_ring *ring, long timeout)
 	adev->wb.wb[index] = cpu_to_le32(0xCAFEDEAD);
 	cpu_ptr = &adev->wb.wb[index];
 
-	r = amdgpu_ib_get(adev, NULL, 20, AMDGPU_IB_POOL_DIRECT, &ib);
+	r = amdgpu_job_alloc_with_ib(ring->adev, NULL, NULL, 20,
+				     AMDGPU_IB_POOL_DIRECT, &job,
+				     AMDGPU_KERNEL_JOB_ID_GFX_RING_TEST);
 	if (r) {
 		drm_err(adev_to_drm(adev), "failed to get ib (%ld).\n", r);
 		goto err1;
 	}
+	ib = &job->ibs[0];
 
-	ib.ptr[0] = PACKET3(PACKET3_WRITE_DATA, 3);
-	ib.ptr[1] = WRITE_DATA_DST_SEL(5) | WR_CONFIRM;
-	ib.ptr[2] = lower_32_bits(gpu_addr);
-	ib.ptr[3] = upper_32_bits(gpu_addr);
-	ib.ptr[4] = 0xDEADBEEF;
-	ib.length_dw = 5;
+	ib->ptr[0] = PACKET3(PACKET3_WRITE_DATA, 3);
+	ib->ptr[1] = WRITE_DATA_DST_SEL(5) | WR_CONFIRM;
+	ib->ptr[2] = lower_32_bits(gpu_addr);
+	ib->ptr[3] = upper_32_bits(gpu_addr);
+	ib->ptr[4] = 0xDEADBEEF;
+	ib->length_dw = 5;
 
-	r = amdgpu_ib_schedule(ring, 1, &ib, NULL, &f);
-	if (r)
+	r = amdgpu_job_submit_direct(job, ring, &f);
+	if (r) {
+		amdgpu_job_free(job);
 		goto err2;
+	}
 
 	r = dma_fence_wait_timeout(f, false, timeout);
 	if (r == 0) {
@@ -4118,7 +4122,6 @@ static int gfx_v10_0_ring_test_ib(struct amdgpu_ring *ring, long timeout)
 	else
 		r = -EINVAL;
 err2:
-	amdgpu_ib_free(&ib, NULL);
 	dma_fence_put(f);
 err1:
 	amdgpu_device_wb_free(adev, index);
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
index b1a1b8a10a08b..d03a4577d4ebf 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -604,7 +604,8 @@ static int gfx_v11_0_ring_test_ring(struct amdgpu_ring *ring)
 static int gfx_v11_0_ring_test_ib(struct amdgpu_ring *ring, long timeout)
 {
 	struct amdgpu_device *adev = ring->adev;
-	struct amdgpu_ib ib;
+	struct amdgpu_job *job;
+	struct amdgpu_ib *ib;
 	struct dma_fence *f = NULL;
 	unsigned index;
 	uint64_t gpu_addr;
@@ -616,8 +617,6 @@ static int gfx_v11_0_ring_test_ib(struct amdgpu_ring *ring, long timeout)
 	    ring->funcs->type == AMDGPU_RING_TYPE_KIQ)
 		return 0;
 
-	memset(&ib, 0, sizeof(ib));
-
 	r = amdgpu_device_wb_get(adev, &index);
 	if (r)
 		return r;
@@ -626,22 +625,27 @@ static int gfx_v11_0_ring_test_ib(struct amdgpu_ring *ring, long timeout)
 	adev->wb.wb[index] = cpu_to_le32(0xCAFEDEAD);
 	cpu_ptr = &adev->wb.wb[index];
 
-	r = amdgpu_ib_get(adev, NULL, 20, AMDGPU_IB_POOL_DIRECT, &ib);
+	r = amdgpu_job_alloc_with_ib(ring->adev, NULL, NULL, 20,
+				     AMDGPU_IB_POOL_DIRECT, &job,
+				     AMDGPU_KERNEL_JOB_ID_GFX_RING_TEST);
 	if (r) {
 		drm_err(adev_to_drm(adev), "failed to get ib (%ld).\n", r);
 		goto err1;
 	}
+	ib = &job->ibs[0];
 
-	ib.ptr[0] = PACKET3(PACKET3_WRITE_DATA, 3);
-	ib.ptr[1] = WRITE_DATA_DST_SEL(5) | WR_CONFIRM;
-	ib.ptr[2] = lower_32_bits(gpu_addr);
-	ib.ptr[3] = upper_32_bits(gpu_addr);
-	ib.ptr[4] = 0xDEADBEEF;
-	ib.length_dw = 5;
+	ib->ptr[0] = PACKET3(PACKET3_WRITE_DATA, 3);
+	ib->ptr[1] = WRITE_DATA_DST_SEL(5) | WR_CONFIRM;
+	ib->ptr[2] = lower_32_bits(gpu_addr);
+	ib->ptr[3] = upper_32_bits(gpu_addr);
+	ib->ptr[4] = 0xDEADBEEF;
+	ib->length_dw = 5;
 
-	r = amdgpu_ib_schedule(ring, 1, &ib, NULL, &f);
-	if (r)
+	r = amdgpu_job_submit_direct(job, ring, &f);
+	if (r) {
+		amdgpu_job_free(job);
 		goto err2;
+	}
 
 	r = dma_fence_wait_timeout(f, false, timeout);
 	if (r == 0) {
@@ -656,7 +660,6 @@ static int gfx_v11_0_ring_test_ib(struct amdgpu_ring *ring, long timeout)
 	else
 		r = -EINVAL;
 err2:
-	amdgpu_ib_free(&ib, NULL);
 	dma_fence_put(f);
 err1:
 	amdgpu_device_wb_free(adev, index);
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
index a418ae609c363..905dbd06c28f3 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
@@ -493,7 +493,8 @@ static int gfx_v12_0_ring_test_ring(struct amdgpu_ring *ring)
 static int gfx_v12_0_ring_test_ib(struct amdgpu_ring *ring, long timeout)
 {
 	struct amdgpu_device *adev = ring->adev;
-	struct amdgpu_ib ib;
+	struct amdgpu_job *job;
+	struct amdgpu_ib *ib;
 	struct dma_fence *f = NULL;
 	unsigned index;
 	uint64_t gpu_addr;
@@ -505,8 +506,6 @@ static int gfx_v12_0_ring_test_ib(struct amdgpu_ring *ring, long timeout)
 	    ring->funcs->type == AMDGPU_RING_TYPE_KIQ)
 		return 0;
 
-	memset(&ib, 0, sizeof(ib));
-
 	r = amdgpu_device_wb_get(adev, &index);
 	if (r)
 		return r;
@@ -515,22 +514,27 @@ static int gfx_v12_0_ring_test_ib(struct amdgpu_ring *ring, long timeout)
 	adev->wb.wb[index] = cpu_to_le32(0xCAFEDEAD);
 	cpu_ptr = &adev->wb.wb[index];
 
-	r = amdgpu_ib_get(adev, NULL, 16, AMDGPU_IB_POOL_DIRECT, &ib);
+	r = amdgpu_job_alloc_with_ib(ring->adev, NULL, NULL, 16,
+				     AMDGPU_IB_POOL_DIRECT, &job,
+				     AMDGPU_KERNEL_JOB_ID_GFX_RING_TEST);
 	if (r) {
 		drm_err(adev_to_drm(adev), "failed to get ib (%ld).\n", r);
 		goto err1;
 	}
+	ib = &job->ibs[0];
 
-	ib.ptr[0] = PACKET3(PACKET3_WRITE_DATA, 3);
-	ib.ptr[1] = WRITE_DATA_DST_SEL(5) | WR_CONFIRM;
-	ib.ptr[2] = lower_32_bits(gpu_addr);
-	ib.ptr[3] = upper_32_bits(gpu_addr);
-	ib.ptr[4] = 0xDEADBEEF;
-	ib.length_dw = 5;
+	ib->ptr[0] = PACKET3(PACKET3_WRITE_DATA, 3);
+	ib->ptr[1] = WRITE_DATA_DST_SEL(5) | WR_CONFIRM;
+	ib->ptr[2] = lower_32_bits(gpu_addr);
+	ib->ptr[3] = upper_32_bits(gpu_addr);
+	ib->ptr[4] = 0xDEADBEEF;
+	ib->length_dw = 5;
 
-	r = amdgpu_ib_schedule(ring, 1, &ib, NULL, &f);
-	if (r)
+	r = amdgpu_job_submit_direct(job, ring, &f);
+	if (r) {
+		amdgpu_job_free(job);
 		goto err2;
+	}
 
 	r = dma_fence_wait_timeout(f, false, timeout);
 	if (r == 0) {
@@ -545,7 +549,6 @@ static int gfx_v12_0_ring_test_ib(struct amdgpu_ring *ring, long timeout)
 	else
 		r = -EINVAL;
 err2:
-	amdgpu_ib_free(&ib, NULL);
 	dma_fence_put(f);
 err1:
 	amdgpu_device_wb_free(adev, index);
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c b/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
index db49582a211f7..266e890edae0f 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
@@ -306,7 +306,8 @@ static int gfx_v12_1_ring_test_ring(struct amdgpu_ring *ring)
 static int gfx_v12_1_ring_test_ib(struct amdgpu_ring *ring, long timeout)
 {
 	struct amdgpu_device *adev = ring->adev;
-	struct amdgpu_ib ib;
+	struct amdgpu_job *job;
+	struct amdgpu_ib *ib;
 	struct dma_fence *f = NULL;
 	unsigned index;
 	uint64_t gpu_addr;
@@ -318,8 +319,6 @@ static int gfx_v12_1_ring_test_ib(struct amdgpu_ring *ring, long timeout)
 	    ring->funcs->type == AMDGPU_RING_TYPE_KIQ)
 		return 0;
 
-	memset(&ib, 0, sizeof(ib));
-
 	r = amdgpu_device_wb_get(adev, &index);
 	if (r)
 		return r;
@@ -328,22 +327,27 @@ static int gfx_v12_1_ring_test_ib(struct amdgpu_ring *ring, long timeout)
 	adev->wb.wb[index] = cpu_to_le32(0xCAFEDEAD);
 	cpu_ptr = &adev->wb.wb[index];
 
-	r = amdgpu_ib_get(adev, NULL, 16, AMDGPU_IB_POOL_DIRECT, &ib);
+	r = amdgpu_job_alloc_with_ib(ring->adev, NULL, NULL, 16,
+				     AMDGPU_IB_POOL_DIRECT, &job,
+				     AMDGPU_KERNEL_JOB_ID_GFX_RING_TEST);
 	if (r) {
 		dev_err(adev->dev, "amdgpu: failed to get ib (%ld).\n", r);
 		goto err1;
 	}
+	ib = &job->ibs[0];
 
-	ib.ptr[0] = PACKET3(PACKET3_WRITE_DATA, 3);
-	ib.ptr[1] = WRITE_DATA_DST_SEL(5) | WR_CONFIRM;
-	ib.ptr[2] = lower_32_bits(gpu_addr);
-	ib.ptr[3] = upper_32_bits(gpu_addr);
-	ib.ptr[4] = 0xDEADBEEF;
-	ib.length_dw = 5;
+	ib->ptr[0] = PACKET3(PACKET3_WRITE_DATA, 3);
+	ib->ptr[1] = WRITE_DATA_DST_SEL(5) | WR_CONFIRM;
+	ib->ptr[2] = lower_32_bits(gpu_addr);
+	ib->ptr[3] = upper_32_bits(gpu_addr);
+	ib->ptr[4] = 0xDEADBEEF;
+	ib->length_dw = 5;
 
-	r = amdgpu_ib_schedule(ring, 1, &ib, NULL, &f);
-	if (r)
+	r = amdgpu_job_submit_direct(job, ring, &f);
+	if (r) {
+		amdgpu_job_free(job);
 		goto err2;
+	}
 
 	r = dma_fence_wait_timeout(f, false, timeout);
 	if (r == 0) {
@@ -358,7 +362,6 @@ static int gfx_v12_1_ring_test_ib(struct amdgpu_ring *ring, long timeout)
 	else
 		r = -EINVAL;
 err2:
-	amdgpu_ib_free(&ib, NULL);
 	dma_fence_put(f);
 err1:
 	amdgpu_device_wb_free(adev, index);
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c
index 73223d97a87f5..2f8aa99f17480 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c
@@ -1895,24 +1895,29 @@ static int gfx_v6_0_ring_test_ib(struct amdgpu_ring *ring, long timeout)
 {
 	struct amdgpu_device *adev = ring->adev;
 	struct dma_fence *f = NULL;
-	struct amdgpu_ib ib;
+	struct amdgpu_job *job;
+	struct amdgpu_ib *ib;
 	uint32_t tmp = 0;
 	long r;
 
 	WREG32(mmSCRATCH_REG0, 0xCAFEDEAD);
-	memset(&ib, 0, sizeof(ib));
-	r = amdgpu_ib_get(adev, NULL, 256, AMDGPU_IB_POOL_DIRECT, &ib);
+	r = amdgpu_job_alloc_with_ib(ring->adev, NULL, NULL, 256,
+				     AMDGPU_IB_POOL_DIRECT, &job,
+				     AMDGPU_KERNEL_JOB_ID_GFX_RING_TEST);
 	if (r)
 		return r;
 
-	ib.ptr[0] = PACKET3(PACKET3_SET_CONFIG_REG, 1);
-	ib.ptr[1] = mmSCRATCH_REG0 - PACKET3_SET_CONFIG_REG_START;
-	ib.ptr[2] = 0xDEADBEEF;
-	ib.length_dw = 3;
+	ib = &job->ibs[0];
+	ib->ptr[0] = PACKET3(PACKET3_SET_CONFIG_REG, 1);
+	ib->ptr[1] = mmSCRATCH_REG0 - PACKET3_SET_CONFIG_REG_START;
+	ib->ptr[2] = 0xDEADBEEF;
+	ib->length_dw = 3;
 
-	r = amdgpu_ib_schedule(ring, 1, &ib, NULL, &f);
-	if (r)
+	r = amdgpu_job_submit_direct(job, ring, &f);
+	if (r) {
+		amdgpu_job_free(job);
 		goto error;
+	}
 
 	r = dma_fence_wait_timeout(f, false, timeout);
 	if (r == 0) {
@@ -1928,7 +1933,6 @@ static int gfx_v6_0_ring_test_ib(struct amdgpu_ring *ring, long timeout)
 		r = -EINVAL;
 
 error:
-	amdgpu_ib_free(&ib, NULL);
 	dma_fence_put(f);
 	return r;
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
index 2b691452775bc..fa235b981c2e9 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
@@ -2291,25 +2291,31 @@ static void gfx_v7_ring_emit_cntxcntl(struct amdgpu_ring *ring, uint32_t flags)
 static int gfx_v7_0_ring_test_ib(struct amdgpu_ring *ring, long timeout)
 {
 	struct amdgpu_device *adev = ring->adev;
-	struct amdgpu_ib ib;
+	struct amdgpu_job *job;
+	struct amdgpu_ib *ib;
 	struct dma_fence *f = NULL;
 	uint32_t tmp = 0;
 	long r;
 
 	WREG32(mmSCRATCH_REG0, 0xCAFEDEAD);
-	memset(&ib, 0, sizeof(ib));
-	r = amdgpu_ib_get(adev, NULL, 256, AMDGPU_IB_POOL_DIRECT, &ib);
+
+	r = amdgpu_job_alloc_with_ib(ring->adev, NULL, NULL, 256,
+				     AMDGPU_IB_POOL_DIRECT, &job,
+				     AMDGPU_KERNEL_JOB_ID_GFX_RING_TEST);
 	if (r)
 		return r;
 
-	ib.ptr[0] = PACKET3(PACKET3_SET_UCONFIG_REG, 1);
-	ib.ptr[1] = mmSCRATCH_REG0 - PACKET3_SET_UCONFIG_REG_START;
-	ib.ptr[2] = 0xDEADBEEF;
-	ib.length_dw = 3;
+	ib = &job->ibs[0];
+	ib->ptr[0] = PACKET3(PACKET3_SET_UCONFIG_REG, 1);
+	ib->ptr[1] = mmSCRATCH_REG0 - PACKET3_SET_UCONFIG_REG_START;
+	ib->ptr[2] = 0xDEADBEEF;
+	ib->length_dw = 3;
 
-	r = amdgpu_ib_schedule(ring, 1, &ib, NULL, &f);
-	if (r)
+	r = amdgpu_job_submit_direct(job, ring, &f);
+	if (r) {
+		amdgpu_job_free(job);
 		goto error;
+	}
 
 	r = dma_fence_wait_timeout(f, false, timeout);
 	if (r == 0) {
@@ -2325,7 +2331,6 @@ static int gfx_v7_0_ring_test_ib(struct amdgpu_ring *ring, long timeout)
 		r = -EINVAL;
 
 error:
-	amdgpu_ib_free(&ib, NULL);
 	dma_fence_put(f);
 	return r;
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
index a6b4c8f41dc11..4736216cd0211 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
@@ -868,9 +868,9 @@ static int gfx_v8_0_ring_test_ring(struct amdgpu_ring *ring)
 static int gfx_v8_0_ring_test_ib(struct amdgpu_ring *ring, long timeout)
 {
 	struct amdgpu_device *adev = ring->adev;
-	struct amdgpu_ib ib;
+	struct amdgpu_job *job;
+	struct amdgpu_ib *ib;
 	struct dma_fence *f = NULL;
-
 	unsigned int index;
 	uint64_t gpu_addr;
 	uint32_t tmp;
@@ -882,22 +882,26 @@ static int gfx_v8_0_ring_test_ib(struct amdgpu_ring *ring, long timeout)
 
 	gpu_addr = adev->wb.gpu_addr + (index * 4);
 	adev->wb.wb[index] = cpu_to_le32(0xCAFEDEAD);
-	memset(&ib, 0, sizeof(ib));
 
-	r = amdgpu_ib_get(adev, NULL, 20, AMDGPU_IB_POOL_DIRECT, &ib);
+	r = amdgpu_job_alloc_with_ib(ring->adev, NULL, NULL, 20,
+				     AMDGPU_IB_POOL_DIRECT, &job,
+				     AMDGPU_KERNEL_JOB_ID_GFX_RING_TEST);
 	if (r)
 		goto err1;
 
-	ib.ptr[0] = PACKET3(PACKET3_WRITE_DATA, 3);
-	ib.ptr[1] = WRITE_DATA_DST_SEL(5) | WR_CONFIRM;
-	ib.ptr[2] = lower_32_bits(gpu_addr);
-	ib.ptr[3] = upper_32_bits(gpu_addr);
-	ib.ptr[4] = 0xDEADBEEF;
-	ib.length_dw = 5;
+	ib = &job->ibs[0];
+	ib->ptr[0] = PACKET3(PACKET3_WRITE_DATA, 3);
+	ib->ptr[1] = WRITE_DATA_DST_SEL(5) | WR_CONFIRM;
+	ib->ptr[2] = lower_32_bits(gpu_addr);
+	ib->ptr[3] = upper_32_bits(gpu_addr);
+	ib->ptr[4] = 0xDEADBEEF;
+	ib->length_dw = 5;
 
-	r = amdgpu_ib_schedule(ring, 1, &ib, NULL, &f);
-	if (r)
+	r = amdgpu_job_submit_direct(job, ring, &f);
+	if (r) {
+		amdgpu_job_free(job);
 		goto err2;
+	}
 
 	r = dma_fence_wait_timeout(f, false, timeout);
 	if (r == 0) {
@@ -914,7 +918,6 @@ static int gfx_v8_0_ring_test_ib(struct amdgpu_ring *ring, long timeout)
 		r = -EINVAL;
 
 err2:
-	amdgpu_ib_free(&ib, NULL);
 	dma_fence_put(f);
 err1:
 	amdgpu_device_wb_free(adev, index);
@@ -1474,7 +1477,8 @@ static const u32 sec_ded_counter_registers[] =
 static int gfx_v8_0_do_edc_gpr_workarounds(struct amdgpu_device *adev)
 {
 	struct amdgpu_ring *ring = &adev->gfx.compute_ring[0];
-	struct amdgpu_ib ib;
+	struct amdgpu_job *job;
+	struct amdgpu_ib *ib;
 	struct dma_fence *f = NULL;
 	int r, i;
 	u32 tmp;
@@ -1505,106 +1509,108 @@ static int gfx_v8_0_do_edc_gpr_workarounds(struct amdgpu_device *adev)
 	total_size += sizeof(sgpr_init_compute_shader);
 
 	/* allocate an indirect buffer to put the commands in */
-	memset(&ib, 0, sizeof(ib));
-	r = amdgpu_ib_get(adev, NULL, total_size,
-					AMDGPU_IB_POOL_DIRECT, &ib);
+	r = amdgpu_job_alloc_with_ib(ring->adev, NULL, NULL, total_size,
+				     AMDGPU_IB_POOL_DIRECT, &job,
+				     AMDGPU_KERNEL_JOB_ID_RUN_SHADER);
 	if (r) {
 		drm_err(adev_to_drm(adev), "failed to get ib (%d).\n", r);
 		return r;
 	}
+	ib = &job->ibs[0];
 
 	/* load the compute shaders */
 	for (i = 0; i < ARRAY_SIZE(vgpr_init_compute_shader); i++)
-		ib.ptr[i + (vgpr_offset / 4)] = vgpr_init_compute_shader[i];
+		ib->ptr[i + (vgpr_offset / 4)] = vgpr_init_compute_shader[i];
 
 	for (i = 0; i < ARRAY_SIZE(sgpr_init_compute_shader); i++)
-		ib.ptr[i + (sgpr_offset / 4)] = sgpr_init_compute_shader[i];
+		ib->ptr[i + (sgpr_offset / 4)] = sgpr_init_compute_shader[i];
 
 	/* init the ib length to 0 */
-	ib.length_dw = 0;
+	ib->length_dw = 0;
 
 	/* VGPR */
 	/* write the register state for the compute dispatch */
 	for (i = 0; i < ARRAY_SIZE(vgpr_init_regs); i += 2) {
-		ib.ptr[ib.length_dw++] = PACKET3(PACKET3_SET_SH_REG, 1);
-		ib.ptr[ib.length_dw++] = vgpr_init_regs[i] - PACKET3_SET_SH_REG_START;
-		ib.ptr[ib.length_dw++] = vgpr_init_regs[i + 1];
+		ib->ptr[ib->length_dw++] = PACKET3(PACKET3_SET_SH_REG, 1);
+		ib->ptr[ib->length_dw++] = vgpr_init_regs[i] - PACKET3_SET_SH_REG_START;
+		ib->ptr[ib->length_dw++] = vgpr_init_regs[i + 1];
 	}
 	/* write the shader start address: mmCOMPUTE_PGM_LO, mmCOMPUTE_PGM_HI */
-	gpu_addr = (ib.gpu_addr + (u64)vgpr_offset) >> 8;
-	ib.ptr[ib.length_dw++] = PACKET3(PACKET3_SET_SH_REG, 2);
-	ib.ptr[ib.length_dw++] = mmCOMPUTE_PGM_LO - PACKET3_SET_SH_REG_START;
-	ib.ptr[ib.length_dw++] = lower_32_bits(gpu_addr);
-	ib.ptr[ib.length_dw++] = upper_32_bits(gpu_addr);
+	gpu_addr = (ib->gpu_addr + (u64)vgpr_offset) >> 8;
+	ib->ptr[ib->length_dw++] = PACKET3(PACKET3_SET_SH_REG, 2);
+	ib->ptr[ib->length_dw++] = mmCOMPUTE_PGM_LO - PACKET3_SET_SH_REG_START;
+	ib->ptr[ib->length_dw++] = lower_32_bits(gpu_addr);
+	ib->ptr[ib->length_dw++] = upper_32_bits(gpu_addr);
 
 	/* write dispatch packet */
-	ib.ptr[ib.length_dw++] = PACKET3(PACKET3_DISPATCH_DIRECT, 3);
-	ib.ptr[ib.length_dw++] = 8; /* x */
-	ib.ptr[ib.length_dw++] = 1; /* y */
-	ib.ptr[ib.length_dw++] = 1; /* z */
-	ib.ptr[ib.length_dw++] =
+	ib->ptr[ib->length_dw++] = PACKET3(PACKET3_DISPATCH_DIRECT, 3);
+	ib->ptr[ib->length_dw++] = 8; /* x */
+	ib->ptr[ib->length_dw++] = 1; /* y */
+	ib->ptr[ib->length_dw++] = 1; /* z */
+	ib->ptr[ib->length_dw++] =
 		REG_SET_FIELD(0, COMPUTE_DISPATCH_INITIATOR, COMPUTE_SHADER_EN, 1);
 
 	/* write CS partial flush packet */
-	ib.ptr[ib.length_dw++] = PACKET3(PACKET3_EVENT_WRITE, 0);
-	ib.ptr[ib.length_dw++] = EVENT_TYPE(7) | EVENT_INDEX(4);
+	ib->ptr[ib->length_dw++] = PACKET3(PACKET3_EVENT_WRITE, 0);
+	ib->ptr[ib->length_dw++] = EVENT_TYPE(7) | EVENT_INDEX(4);
 
 	/* SGPR1 */
 	/* write the register state for the compute dispatch */
 	for (i = 0; i < ARRAY_SIZE(sgpr1_init_regs); i += 2) {
-		ib.ptr[ib.length_dw++] = PACKET3(PACKET3_SET_SH_REG, 1);
-		ib.ptr[ib.length_dw++] = sgpr1_init_regs[i] - PACKET3_SET_SH_REG_START;
-		ib.ptr[ib.length_dw++] = sgpr1_init_regs[i + 1];
+		ib->ptr[ib->length_dw++] = PACKET3(PACKET3_SET_SH_REG, 1);
+		ib->ptr[ib->length_dw++] = sgpr1_init_regs[i] - PACKET3_SET_SH_REG_START;
+		ib->ptr[ib->length_dw++] = sgpr1_init_regs[i + 1];
 	}
 	/* write the shader start address: mmCOMPUTE_PGM_LO, mmCOMPUTE_PGM_HI */
-	gpu_addr = (ib.gpu_addr + (u64)sgpr_offset) >> 8;
-	ib.ptr[ib.length_dw++] = PACKET3(PACKET3_SET_SH_REG, 2);
-	ib.ptr[ib.length_dw++] = mmCOMPUTE_PGM_LO - PACKET3_SET_SH_REG_START;
-	ib.ptr[ib.length_dw++] = lower_32_bits(gpu_addr);
-	ib.ptr[ib.length_dw++] = upper_32_bits(gpu_addr);
+	gpu_addr = (ib->gpu_addr + (u64)sgpr_offset) >> 8;
+	ib->ptr[ib->length_dw++] = PACKET3(PACKET3_SET_SH_REG, 2);
+	ib->ptr[ib->length_dw++] = mmCOMPUTE_PGM_LO - PACKET3_SET_SH_REG_START;
+	ib->ptr[ib->length_dw++] = lower_32_bits(gpu_addr);
+	ib->ptr[ib->length_dw++] = upper_32_bits(gpu_addr);
 
 	/* write dispatch packet */
-	ib.ptr[ib.length_dw++] = PACKET3(PACKET3_DISPATCH_DIRECT, 3);
-	ib.ptr[ib.length_dw++] = 8; /* x */
-	ib.ptr[ib.length_dw++] = 1; /* y */
-	ib.ptr[ib.length_dw++] = 1; /* z */
-	ib.ptr[ib.length_dw++] =
+	ib->ptr[ib->length_dw++] = PACKET3(PACKET3_DISPATCH_DIRECT, 3);
+	ib->ptr[ib->length_dw++] = 8; /* x */
+	ib->ptr[ib->length_dw++] = 1; /* y */
+	ib->ptr[ib->length_dw++] = 1; /* z */
+	ib->ptr[ib->length_dw++] =
 		REG_SET_FIELD(0, COMPUTE_DISPATCH_INITIATOR, COMPUTE_SHADER_EN, 1);
 
 	/* write CS partial flush packet */
-	ib.ptr[ib.length_dw++] = PACKET3(PACKET3_EVENT_WRITE, 0);
-	ib.ptr[ib.length_dw++] = EVENT_TYPE(7) | EVENT_INDEX(4);
+	ib->ptr[ib->length_dw++] = PACKET3(PACKET3_EVENT_WRITE, 0);
+	ib->ptr[ib->length_dw++] = EVENT_TYPE(7) | EVENT_INDEX(4);
 
 	/* SGPR2 */
 	/* write the register state for the compute dispatch */
 	for (i = 0; i < ARRAY_SIZE(sgpr2_init_regs); i += 2) {
-		ib.ptr[ib.length_dw++] = PACKET3(PACKET3_SET_SH_REG, 1);
-		ib.ptr[ib.length_dw++] = sgpr2_init_regs[i] - PACKET3_SET_SH_REG_START;
-		ib.ptr[ib.length_dw++] = sgpr2_init_regs[i + 1];
+		ib->ptr[ib->length_dw++] = PACKET3(PACKET3_SET_SH_REG, 1);
+		ib->ptr[ib->length_dw++] = sgpr2_init_regs[i] - PACKET3_SET_SH_REG_START;
+		ib->ptr[ib->length_dw++] = sgpr2_init_regs[i + 1];
 	}
 	/* write the shader start address: mmCOMPUTE_PGM_LO, mmCOMPUTE_PGM_HI */
-	gpu_addr = (ib.gpu_addr + (u64)sgpr_offset) >> 8;
-	ib.ptr[ib.length_dw++] = PACKET3(PACKET3_SET_SH_REG, 2);
-	ib.ptr[ib.length_dw++] = mmCOMPUTE_PGM_LO - PACKET3_SET_SH_REG_START;
-	ib.ptr[ib.length_dw++] = lower_32_bits(gpu_addr);
-	ib.ptr[ib.length_dw++] = upper_32_bits(gpu_addr);
+	gpu_addr = (ib->gpu_addr + (u64)sgpr_offset) >> 8;
+	ib->ptr[ib->length_dw++] = PACKET3(PACKET3_SET_SH_REG, 2);
+	ib->ptr[ib->length_dw++] = mmCOMPUTE_PGM_LO - PACKET3_SET_SH_REG_START;
+	ib->ptr[ib->length_dw++] = lower_32_bits(gpu_addr);
+	ib->ptr[ib->length_dw++] = upper_32_bits(gpu_addr);
 
 	/* write dispatch packet */
-	ib.ptr[ib.length_dw++] = PACKET3(PACKET3_DISPATCH_DIRECT, 3);
-	ib.ptr[ib.length_dw++] = 8; /* x */
-	ib.ptr[ib.length_dw++] = 1; /* y */
-	ib.ptr[ib.length_dw++] = 1; /* z */
-	ib.ptr[ib.length_dw++] =
+	ib->ptr[ib->length_dw++] = PACKET3(PACKET3_DISPATCH_DIRECT, 3);
+	ib->ptr[ib->length_dw++] = 8; /* x */
+	ib->ptr[ib->length_dw++] = 1; /* y */
+	ib->ptr[ib->length_dw++] = 1; /* z */
+	ib->ptr[ib->length_dw++] =
 		REG_SET_FIELD(0, COMPUTE_DISPATCH_INITIATOR, COMPUTE_SHADER_EN, 1);
 
 	/* write CS partial flush packet */
-	ib.ptr[ib.length_dw++] = PACKET3(PACKET3_EVENT_WRITE, 0);
-	ib.ptr[ib.length_dw++] = EVENT_TYPE(7) | EVENT_INDEX(4);
+	ib->ptr[ib->length_dw++] = PACKET3(PACKET3_EVENT_WRITE, 0);
+	ib->ptr[ib->length_dw++] = EVENT_TYPE(7) | EVENT_INDEX(4);
 
 	/* shedule the ib on the ring */
-	r = amdgpu_ib_schedule(ring, 1, &ib, NULL, &f);
+	r = amdgpu_job_submit_direct(job, ring, &f);
 	if (r) {
 		drm_err(adev_to_drm(adev), "ib submit failed (%d).\n", r);
+		amdgpu_job_free(job);
 		goto fail;
 	}
 
@@ -1629,7 +1635,6 @@ static int gfx_v8_0_do_edc_gpr_workarounds(struct amdgpu_device *adev)
 		RREG32(sec_ded_counter_registers[i]);
 
 fail:
-	amdgpu_ib_free(&ib, NULL);
 	dma_fence_put(f);
 
 	return r;
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
index 95be105671ece..50ef4e06be569 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -1224,9 +1224,9 @@ static int gfx_v9_0_ring_test_ring(struct amdgpu_ring *ring)
 static int gfx_v9_0_ring_test_ib(struct amdgpu_ring *ring, long timeout)
 {
 	struct amdgpu_device *adev = ring->adev;
-	struct amdgpu_ib ib;
+	struct amdgpu_job *job;
+	struct amdgpu_ib *ib;
 	struct dma_fence *f = NULL;
-
 	unsigned index;
 	uint64_t gpu_addr;
 	uint32_t tmp;
@@ -1238,22 +1238,26 @@ static int gfx_v9_0_ring_test_ib(struct amdgpu_ring *ring, long timeout)
 
 	gpu_addr = adev->wb.gpu_addr + (index * 4);
 	adev->wb.wb[index] = cpu_to_le32(0xCAFEDEAD);
-	memset(&ib, 0, sizeof(ib));
 
-	r = amdgpu_ib_get(adev, NULL, 20, AMDGPU_IB_POOL_DIRECT, &ib);
+	r = amdgpu_job_alloc_with_ib(ring->adev, NULL, NULL, 20,
+				     AMDGPU_IB_POOL_DIRECT, &job,
+				     AMDGPU_KERNEL_JOB_ID_GFX_RING_TEST);
 	if (r)
 		goto err1;
 
-	ib.ptr[0] = PACKET3(PACKET3_WRITE_DATA, 3);
-	ib.ptr[1] = WRITE_DATA_DST_SEL(5) | WR_CONFIRM;
-	ib.ptr[2] = lower_32_bits(gpu_addr);
-	ib.ptr[3] = upper_32_bits(gpu_addr);
-	ib.ptr[4] = 0xDEADBEEF;
-	ib.length_dw = 5;
+	ib = &job->ibs[0];
+	ib->ptr[0] = PACKET3(PACKET3_WRITE_DATA, 3);
+	ib->ptr[1] = WRITE_DATA_DST_SEL(5) | WR_CONFIRM;
+	ib->ptr[2] = lower_32_bits(gpu_addr);
+	ib->ptr[3] = upper_32_bits(gpu_addr);
+	ib->ptr[4] = 0xDEADBEEF;
+	ib->length_dw = 5;
 
-	r = amdgpu_ib_schedule(ring, 1, &ib, NULL, &f);
-	if (r)
+	r = amdgpu_job_submit_direct(job, ring, &f);
+	if (r) {
+		amdgpu_job_free(job);
 		goto err2;
+	}
 
 	r = dma_fence_wait_timeout(f, false, timeout);
 	if (r == 0) {
@@ -1270,7 +1274,6 @@ static int gfx_v9_0_ring_test_ib(struct amdgpu_ring *ring, long timeout)
 		r = -EINVAL;
 
 err2:
-	amdgpu_ib_free(&ib, NULL);
 	dma_fence_put(f);
 err1:
 	amdgpu_device_wb_free(adev, index);
@@ -4624,7 +4627,8 @@ static int gfx_v9_0_do_edc_gds_workarounds(struct amdgpu_device *adev)
 static int gfx_v9_0_do_edc_gpr_workarounds(struct amdgpu_device *adev)
 {
 	struct amdgpu_ring *ring = &adev->gfx.compute_ring[0];
-	struct amdgpu_ib ib;
+	struct amdgpu_job *job;
+	struct amdgpu_ib *ib;
 	struct dma_fence *f = NULL;
 	int r, i;
 	unsigned total_size, vgpr_offset, sgpr_offset;
@@ -4670,112 +4674,114 @@ static int gfx_v9_0_do_edc_gpr_workarounds(struct amdgpu_device *adev)
 	total_size += sizeof(sgpr_init_compute_shader);
 
 	/* allocate an indirect buffer to put the commands in */
-	memset(&ib, 0, sizeof(ib));
-	r = amdgpu_ib_get(adev, NULL, total_size,
-					AMDGPU_IB_POOL_DIRECT, &ib);
+	r = amdgpu_job_alloc_with_ib(ring->adev, NULL, NULL, total_size,
+				     AMDGPU_IB_POOL_DIRECT, &job,
+				     AMDGPU_KERNEL_JOB_ID_RUN_SHADER);
 	if (r) {
 		drm_err(adev_to_drm(adev), "failed to get ib (%d).\n", r);
 		return r;
 	}
+	ib = &job->ibs[0];
 
 	/* load the compute shaders */
 	for (i = 0; i < vgpr_init_shader_size/sizeof(u32); i++)
-		ib.ptr[i + (vgpr_offset / 4)] = vgpr_init_shader_ptr[i];
+		ib->ptr[i + (vgpr_offset / 4)] = vgpr_init_shader_ptr[i];
 
 	for (i = 0; i < ARRAY_SIZE(sgpr_init_compute_shader); i++)
-		ib.ptr[i + (sgpr_offset / 4)] = sgpr_init_compute_shader[i];
+		ib->ptr[i + (sgpr_offset / 4)] = sgpr_init_compute_shader[i];
 
 	/* init the ib length to 0 */
-	ib.length_dw = 0;
+	ib->length_dw = 0;
 
 	/* VGPR */
 	/* write the register state for the compute dispatch */
 	for (i = 0; i < gpr_reg_size; i++) {
-		ib.ptr[ib.length_dw++] = PACKET3(PACKET3_SET_SH_REG, 1);
-		ib.ptr[ib.length_dw++] = SOC15_REG_ENTRY_OFFSET(vgpr_init_regs_ptr[i])
+		ib->ptr[ib->length_dw++] = PACKET3(PACKET3_SET_SH_REG, 1);
+		ib->ptr[ib->length_dw++] = SOC15_REG_ENTRY_OFFSET(vgpr_init_regs_ptr[i])
 								- PACKET3_SET_SH_REG_START;
-		ib.ptr[ib.length_dw++] = vgpr_init_regs_ptr[i].reg_value;
+		ib->ptr[ib->length_dw++] = vgpr_init_regs_ptr[i].reg_value;
 	}
 	/* write the shader start address: mmCOMPUTE_PGM_LO, mmCOMPUTE_PGM_HI */
-	gpu_addr = (ib.gpu_addr + (u64)vgpr_offset) >> 8;
-	ib.ptr[ib.length_dw++] = PACKET3(PACKET3_SET_SH_REG, 2);
-	ib.ptr[ib.length_dw++] = SOC15_REG_OFFSET(GC, 0, mmCOMPUTE_PGM_LO)
+	gpu_addr = (ib->gpu_addr + (u64)vgpr_offset) >> 8;
+	ib->ptr[ib->length_dw++] = PACKET3(PACKET3_SET_SH_REG, 2);
+	ib->ptr[ib->length_dw++] = SOC15_REG_OFFSET(GC, 0, mmCOMPUTE_PGM_LO)
 							- PACKET3_SET_SH_REG_START;
-	ib.ptr[ib.length_dw++] = lower_32_bits(gpu_addr);
-	ib.ptr[ib.length_dw++] = upper_32_bits(gpu_addr);
+	ib->ptr[ib->length_dw++] = lower_32_bits(gpu_addr);
+	ib->ptr[ib->length_dw++] = upper_32_bits(gpu_addr);
 
 	/* write dispatch packet */
-	ib.ptr[ib.length_dw++] = PACKET3(PACKET3_DISPATCH_DIRECT, 3);
-	ib.ptr[ib.length_dw++] = compute_dim_x * 2; /* x */
-	ib.ptr[ib.length_dw++] = 1; /* y */
-	ib.ptr[ib.length_dw++] = 1; /* z */
-	ib.ptr[ib.length_dw++] =
+	ib->ptr[ib->length_dw++] = PACKET3(PACKET3_DISPATCH_DIRECT, 3);
+	ib->ptr[ib->length_dw++] = compute_dim_x * 2; /* x */
+	ib->ptr[ib->length_dw++] = 1; /* y */
+	ib->ptr[ib->length_dw++] = 1; /* z */
+	ib->ptr[ib->length_dw++] =
 		REG_SET_FIELD(0, COMPUTE_DISPATCH_INITIATOR, COMPUTE_SHADER_EN, 1);
 
 	/* write CS partial flush packet */
-	ib.ptr[ib.length_dw++] = PACKET3(PACKET3_EVENT_WRITE, 0);
-	ib.ptr[ib.length_dw++] = EVENT_TYPE(7) | EVENT_INDEX(4);
+	ib->ptr[ib->length_dw++] = PACKET3(PACKET3_EVENT_WRITE, 0);
+	ib->ptr[ib->length_dw++] = EVENT_TYPE(7) | EVENT_INDEX(4);
 
 	/* SGPR1 */
 	/* write the register state for the compute dispatch */
 	for (i = 0; i < gpr_reg_size; i++) {
-		ib.ptr[ib.length_dw++] = PACKET3(PACKET3_SET_SH_REG, 1);
-		ib.ptr[ib.length_dw++] = SOC15_REG_ENTRY_OFFSET(sgpr1_init_regs[i])
+		ib->ptr[ib->length_dw++] = PACKET3(PACKET3_SET_SH_REG, 1);
+		ib->ptr[ib->length_dw++] = SOC15_REG_ENTRY_OFFSET(sgpr1_init_regs[i])
 								- PACKET3_SET_SH_REG_START;
-		ib.ptr[ib.length_dw++] = sgpr1_init_regs[i].reg_value;
+		ib->ptr[ib->length_dw++] = sgpr1_init_regs[i].reg_value;
 	}
 	/* write the shader start address: mmCOMPUTE_PGM_LO, mmCOMPUTE_PGM_HI */
-	gpu_addr = (ib.gpu_addr + (u64)sgpr_offset) >> 8;
-	ib.ptr[ib.length_dw++] = PACKET3(PACKET3_SET_SH_REG, 2);
-	ib.ptr[ib.length_dw++] = SOC15_REG_OFFSET(GC, 0, mmCOMPUTE_PGM_LO)
+	gpu_addr = (ib->gpu_addr + (u64)sgpr_offset) >> 8;
+	ib->ptr[ib->length_dw++] = PACKET3(PACKET3_SET_SH_REG, 2);
+	ib->ptr[ib->length_dw++] = SOC15_REG_OFFSET(GC, 0, mmCOMPUTE_PGM_LO)
 							- PACKET3_SET_SH_REG_START;
-	ib.ptr[ib.length_dw++] = lower_32_bits(gpu_addr);
-	ib.ptr[ib.length_dw++] = upper_32_bits(gpu_addr);
+	ib->ptr[ib->length_dw++] = lower_32_bits(gpu_addr);
+	ib->ptr[ib->length_dw++] = upper_32_bits(gpu_addr);
 
 	/* write dispatch packet */
-	ib.ptr[ib.length_dw++] = PACKET3(PACKET3_DISPATCH_DIRECT, 3);
-	ib.ptr[ib.length_dw++] = compute_dim_x / 2 * sgpr_work_group_size; /* x */
-	ib.ptr[ib.length_dw++] = 1; /* y */
-	ib.ptr[ib.length_dw++] = 1; /* z */
-	ib.ptr[ib.length_dw++] =
+	ib->ptr[ib->length_dw++] = PACKET3(PACKET3_DISPATCH_DIRECT, 3);
+	ib->ptr[ib->length_dw++] = compute_dim_x / 2 * sgpr_work_group_size; /* x */
+	ib->ptr[ib->length_dw++] = 1; /* y */
+	ib->ptr[ib->length_dw++] = 1; /* z */
+	ib->ptr[ib->length_dw++] =
 		REG_SET_FIELD(0, COMPUTE_DISPATCH_INITIATOR, COMPUTE_SHADER_EN, 1);
 
 	/* write CS partial flush packet */
-	ib.ptr[ib.length_dw++] = PACKET3(PACKET3_EVENT_WRITE, 0);
-	ib.ptr[ib.length_dw++] = EVENT_TYPE(7) | EVENT_INDEX(4);
+	ib->ptr[ib->length_dw++] = PACKET3(PACKET3_EVENT_WRITE, 0);
+	ib->ptr[ib->length_dw++] = EVENT_TYPE(7) | EVENT_INDEX(4);
 
 	/* SGPR2 */
 	/* write the register state for the compute dispatch */
 	for (i = 0; i < gpr_reg_size; i++) {
-		ib.ptr[ib.length_dw++] = PACKET3(PACKET3_SET_SH_REG, 1);
-		ib.ptr[ib.length_dw++] = SOC15_REG_ENTRY_OFFSET(sgpr2_init_regs[i])
+		ib->ptr[ib->length_dw++] = PACKET3(PACKET3_SET_SH_REG, 1);
+		ib->ptr[ib->length_dw++] = SOC15_REG_ENTRY_OFFSET(sgpr2_init_regs[i])
 								- PACKET3_SET_SH_REG_START;
-		ib.ptr[ib.length_dw++] = sgpr2_init_regs[i].reg_value;
+		ib->ptr[ib->length_dw++] = sgpr2_init_regs[i].reg_value;
 	}
 	/* write the shader start address: mmCOMPUTE_PGM_LO, mmCOMPUTE_PGM_HI */
-	gpu_addr = (ib.gpu_addr + (u64)sgpr_offset) >> 8;
-	ib.ptr[ib.length_dw++] = PACKET3(PACKET3_SET_SH_REG, 2);
-	ib.ptr[ib.length_dw++] = SOC15_REG_OFFSET(GC, 0, mmCOMPUTE_PGM_LO)
+	gpu_addr = (ib->gpu_addr + (u64)sgpr_offset) >> 8;
+	ib->ptr[ib->length_dw++] = PACKET3(PACKET3_SET_SH_REG, 2);
+	ib->ptr[ib->length_dw++] = SOC15_REG_OFFSET(GC, 0, mmCOMPUTE_PGM_LO)
 							- PACKET3_SET_SH_REG_START;
-	ib.ptr[ib.length_dw++] = lower_32_bits(gpu_addr);
-	ib.ptr[ib.length_dw++] = upper_32_bits(gpu_addr);
+	ib->ptr[ib->length_dw++] = lower_32_bits(gpu_addr);
+	ib->ptr[ib->length_dw++] = upper_32_bits(gpu_addr);
 
 	/* write dispatch packet */
-	ib.ptr[ib.length_dw++] = PACKET3(PACKET3_DISPATCH_DIRECT, 3);
-	ib.ptr[ib.length_dw++] = compute_dim_x / 2 * sgpr_work_group_size; /* x */
-	ib.ptr[ib.length_dw++] = 1; /* y */
-	ib.ptr[ib.length_dw++] = 1; /* z */
-	ib.ptr[ib.length_dw++] =
+	ib->ptr[ib->length_dw++] = PACKET3(PACKET3_DISPATCH_DIRECT, 3);
+	ib->ptr[ib->length_dw++] = compute_dim_x / 2 * sgpr_work_group_size; /* x */
+	ib->ptr[ib->length_dw++] = 1; /* y */
+	ib->ptr[ib->length_dw++] = 1; /* z */
+	ib->ptr[ib->length_dw++] =
 		REG_SET_FIELD(0, COMPUTE_DISPATCH_INITIATOR, COMPUTE_SHADER_EN, 1);
 
 	/* write CS partial flush packet */
-	ib.ptr[ib.length_dw++] = PACKET3(PACKET3_EVENT_WRITE, 0);
-	ib.ptr[ib.length_dw++] = EVENT_TYPE(7) | EVENT_INDEX(4);
+	ib->ptr[ib->length_dw++] = PACKET3(PACKET3_EVENT_WRITE, 0);
+	ib->ptr[ib->length_dw++] = EVENT_TYPE(7) | EVENT_INDEX(4);
 
 	/* shedule the ib on the ring */
-	r = amdgpu_ib_schedule(ring, 1, &ib, NULL, &f);
+	r = amdgpu_job_submit_direct(job, ring, &f);
 	if (r) {
 		drm_err(adev_to_drm(adev), "ib schedule failed (%d).\n", r);
+		amdgpu_job_free(job);
 		goto fail;
 	}
 
@@ -4787,7 +4793,6 @@ static int gfx_v9_0_do_edc_gpr_workarounds(struct amdgpu_device *adev)
 	}
 
 fail:
-	amdgpu_ib_free(&ib, NULL);
 	dma_fence_put(f);
 
 	return r;
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.c
index 8058ea91ecafd..96ec6d9ea8656 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.c
@@ -345,12 +345,13 @@ const struct soc15_reg_entry sgpr64_init_regs_aldebaran[] = {
 
 static int gfx_v9_4_2_run_shader(struct amdgpu_device *adev,
 				 struct amdgpu_ring *ring,
-				 struct amdgpu_ib *ib,
 				 const u32 *shader_ptr, u32 shader_size,
 				 const struct soc15_reg_entry *init_regs, u32 regs_size,
 				 u32 compute_dim_x, u64 wb_gpu_addr, u32 pattern,
 				 struct dma_fence **fence_ptr)
 {
+	struct amdgpu_job *job;
+	struct amdgpu_ib *ib;
 	int r, i;
 	uint32_t total_size, shader_offset;
 	u64 gpu_addr;
@@ -360,14 +361,14 @@ static int gfx_v9_4_2_run_shader(struct amdgpu_device *adev,
 	shader_offset = total_size;
 	total_size += ALIGN(shader_size, 256);
 
-	/* allocate an indirect buffer to put the commands in */
-	memset(ib, 0, sizeof(*ib));
-	r = amdgpu_ib_get(adev, NULL, total_size,
-					AMDGPU_IB_POOL_DIRECT, ib);
+	r = amdgpu_job_alloc_with_ib(ring->adev, NULL, NULL, total_size,
+				     AMDGPU_IB_POOL_DIRECT, &job,
+				     AMDGPU_KERNEL_JOB_ID_RUN_SHADER);
 	if (r) {
 		dev_err(adev->dev, "failed to get ib (%d).\n", r);
 		return r;
 	}
+	ib = &job->ibs[0];
 
 	/* load the compute shaders */
 	for (i = 0; i < shader_size/sizeof(u32); i++)
@@ -408,11 +409,11 @@ static int gfx_v9_4_2_run_shader(struct amdgpu_device *adev,
 	ib->ptr[ib->length_dw++] =
 		REG_SET_FIELD(0, COMPUTE_DISPATCH_INITIATOR, COMPUTE_SHADER_EN, 1);
 
-	/* shedule the ib on the ring */
-	r = amdgpu_ib_schedule(ring, 1, ib, NULL, fence_ptr);
+	/* schedule the ib on the ring */
+	r = amdgpu_job_submit_direct(job, ring, fence_ptr);
 	if (r) {
 		dev_err(adev->dev, "ib submit failed (%d).\n", r);
-		amdgpu_ib_free(ib, NULL);
+		amdgpu_job_free(job);
 	}
 	return r;
 }
@@ -493,7 +494,6 @@ static int gfx_v9_4_2_do_sgprs_init(struct amdgpu_device *adev)
 	int wb_size = adev->gfx.config.max_shader_engines *
 			 CU_ID_MAX * SIMD_ID_MAX * WAVE_ID_MAX;
 	struct amdgpu_ib wb_ib;
-	struct amdgpu_ib disp_ibs[3];
 	struct dma_fence *fences[3];
 	u32 pattern[3] = { 0x1, 0x5, 0xa };
 
@@ -514,7 +514,6 @@ static int gfx_v9_4_2_do_sgprs_init(struct amdgpu_device *adev)
 
 	r = gfx_v9_4_2_run_shader(adev,
 			&adev->gfx.compute_ring[0],
-			&disp_ibs[0],
 			sgpr112_init_compute_shader_aldebaran,
 			sizeof(sgpr112_init_compute_shader_aldebaran),
 			sgpr112_init_regs_aldebaran,
@@ -539,7 +538,6 @@ static int gfx_v9_4_2_do_sgprs_init(struct amdgpu_device *adev)
 
 	r = gfx_v9_4_2_run_shader(adev,
 			&adev->gfx.compute_ring[1],
-			&disp_ibs[1],
 			sgpr96_init_compute_shader_aldebaran,
 			sizeof(sgpr96_init_compute_shader_aldebaran),
 			sgpr96_init_regs_aldebaran,
@@ -579,7 +577,6 @@ static int gfx_v9_4_2_do_sgprs_init(struct amdgpu_device *adev)
 	memset(wb_ib.ptr, 0, (1 + wb_size) * sizeof(uint32_t));
 	r = gfx_v9_4_2_run_shader(adev,
 			&adev->gfx.compute_ring[0],
-			&disp_ibs[2],
 			sgpr64_init_compute_shader_aldebaran,
 			sizeof(sgpr64_init_compute_shader_aldebaran),
 			sgpr64_init_regs_aldebaran,
@@ -611,13 +608,10 @@ static int gfx_v9_4_2_do_sgprs_init(struct amdgpu_device *adev)
 	}
 
 disp2_failed:
-	amdgpu_ib_free(&disp_ibs[2], NULL);
 	dma_fence_put(fences[2]);
 disp1_failed:
-	amdgpu_ib_free(&disp_ibs[1], NULL);
 	dma_fence_put(fences[1]);
 disp0_failed:
-	amdgpu_ib_free(&disp_ibs[0], NULL);
 	dma_fence_put(fences[0]);
 pro_end:
 	amdgpu_ib_free(&wb_ib, NULL);
@@ -637,7 +631,6 @@ static int gfx_v9_4_2_do_vgprs_init(struct amdgpu_device *adev)
 	int wb_size = adev->gfx.config.max_shader_engines *
 			 CU_ID_MAX * SIMD_ID_MAX * WAVE_ID_MAX;
 	struct amdgpu_ib wb_ib;
-	struct amdgpu_ib disp_ib;
 	struct dma_fence *fence;
 	u32 pattern = 0xa;
 
@@ -657,7 +650,6 @@ static int gfx_v9_4_2_do_vgprs_init(struct amdgpu_device *adev)
 
 	r = gfx_v9_4_2_run_shader(adev,
 			&adev->gfx.compute_ring[0],
-			&disp_ib,
 			vgpr_init_compute_shader_aldebaran,
 			sizeof(vgpr_init_compute_shader_aldebaran),
 			vgpr_init_regs_aldebaran,
@@ -687,7 +679,6 @@ static int gfx_v9_4_2_do_vgprs_init(struct amdgpu_device *adev)
 	}
 
 disp_failed:
-	amdgpu_ib_free(&disp_ib, NULL);
 	dma_fence_put(fence);
 pro_end:
 	amdgpu_ib_free(&wb_ib, NULL);
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
index ad4d442e7345e..d78b2c2ae13a3 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
@@ -451,9 +451,9 @@ static int gfx_v9_4_3_ring_test_ring(struct amdgpu_ring *ring)
 static int gfx_v9_4_3_ring_test_ib(struct amdgpu_ring *ring, long timeout)
 {
 	struct amdgpu_device *adev = ring->adev;
-	struct amdgpu_ib ib;
+	struct amdgpu_job *job;
+	struct amdgpu_ib *ib;
 	struct dma_fence *f = NULL;
-
 	unsigned index;
 	uint64_t gpu_addr;
 	uint32_t tmp;
@@ -465,22 +465,26 @@ static int gfx_v9_4_3_ring_test_ib(struct amdgpu_ring *ring, long timeout)
 
 	gpu_addr = adev->wb.gpu_addr + (index * 4);
 	adev->wb.wb[index] = cpu_to_le32(0xCAFEDEAD);
-	memset(&ib, 0, sizeof(ib));
 
-	r = amdgpu_ib_get(adev, NULL, 20, AMDGPU_IB_POOL_DIRECT, &ib);
+	r = amdgpu_job_alloc_with_ib(ring->adev, NULL, NULL, 20,
+				     AMDGPU_IB_POOL_DIRECT, &job,
+				     AMDGPU_KERNEL_JOB_ID_GFX_RING_TEST);
 	if (r)
 		goto err1;
 
-	ib.ptr[0] = PACKET3(PACKET3_WRITE_DATA, 3);
-	ib.ptr[1] = WRITE_DATA_DST_SEL(5) | WR_CONFIRM;
-	ib.ptr[2] = lower_32_bits(gpu_addr);
-	ib.ptr[3] = upper_32_bits(gpu_addr);
-	ib.ptr[4] = 0xDEADBEEF;
-	ib.length_dw = 5;
+	ib = &job->ibs[0];
+	ib->ptr[0] = PACKET3(PACKET3_WRITE_DATA, 3);
+	ib->ptr[1] = WRITE_DATA_DST_SEL(5) | WR_CONFIRM;
+	ib->ptr[2] = lower_32_bits(gpu_addr);
+	ib->ptr[3] = upper_32_bits(gpu_addr);
+	ib->ptr[4] = 0xDEADBEEF;
+	ib->length_dw = 5;
 
-	r = amdgpu_ib_schedule(ring, 1, &ib, NULL, &f);
-	if (r)
+	r = amdgpu_job_submit_direct(job, ring, &f);
+	if (r) {
+		amdgpu_job_free(job);
 		goto err2;
+	}
 
 	r = dma_fence_wait_timeout(f, false, timeout);
 	if (r == 0) {
@@ -497,7 +501,6 @@ static int gfx_v9_4_3_ring_test_ib(struct amdgpu_ring *ring, long timeout)
 		r = -EINVAL;
 
 err2:
-	amdgpu_ib_free(&ib, NULL);
 	dma_fence_put(f);
 err1:
 	amdgpu_device_wb_free(adev, index);
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c b/drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c
index 0090ace49024f..34c5acfa038d2 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c
@@ -583,7 +583,8 @@ static int sdma_v2_4_ring_test_ring(struct amdgpu_ring *ring)
 static int sdma_v2_4_ring_test_ib(struct amdgpu_ring *ring, long timeout)
 {
 	struct amdgpu_device *adev = ring->adev;
-	struct amdgpu_ib ib;
+	struct amdgpu_job *job;
+	struct amdgpu_ib *ib;
 	struct dma_fence *f = NULL;
 	unsigned index;
 	u32 tmp = 0;
@@ -597,26 +598,30 @@ static int sdma_v2_4_ring_test_ib(struct amdgpu_ring *ring, long timeout)
 	gpu_addr = adev->wb.gpu_addr + (index * 4);
 	tmp = 0xCAFEDEAD;
 	adev->wb.wb[index] = cpu_to_le32(tmp);
-	memset(&ib, 0, sizeof(ib));
-	r = amdgpu_ib_get(adev, NULL, 256,
-					AMDGPU_IB_POOL_DIRECT, &ib);
+
+	r = amdgpu_job_alloc_with_ib(ring->adev, NULL, NULL, 256,
+				     AMDGPU_IB_POOL_DIRECT, &job,
+				     AMDGPU_KERNEL_JOB_ID_SDMA_RING_TEST);
 	if (r)
 		goto err0;
 
-	ib.ptr[0] = SDMA_PKT_HEADER_OP(SDMA_OP_WRITE) |
+	ib = &job->ibs[0];
+	ib->ptr[0] = SDMA_PKT_HEADER_OP(SDMA_OP_WRITE) |
 		SDMA_PKT_HEADER_SUB_OP(SDMA_SUBOP_WRITE_LINEAR);
-	ib.ptr[1] = lower_32_bits(gpu_addr);
-	ib.ptr[2] = upper_32_bits(gpu_addr);
-	ib.ptr[3] = SDMA_PKT_WRITE_UNTILED_DW_3_COUNT(1);
-	ib.ptr[4] = 0xDEADBEEF;
-	ib.ptr[5] = SDMA_PKT_HEADER_OP(SDMA_OP_NOP);
-	ib.ptr[6] = SDMA_PKT_HEADER_OP(SDMA_OP_NOP);
-	ib.ptr[7] = SDMA_PKT_HEADER_OP(SDMA_OP_NOP);
-	ib.length_dw = 8;
-
-	r = amdgpu_ib_schedule(ring, 1, &ib, NULL, &f);
-	if (r)
+	ib->ptr[1] = lower_32_bits(gpu_addr);
+	ib->ptr[2] = upper_32_bits(gpu_addr);
+	ib->ptr[3] = SDMA_PKT_WRITE_UNTILED_DW_3_COUNT(1);
+	ib->ptr[4] = 0xDEADBEEF;
+	ib->ptr[5] = SDMA_PKT_HEADER_OP(SDMA_OP_NOP);
+	ib->ptr[6] = SDMA_PKT_HEADER_OP(SDMA_OP_NOP);
+	ib->ptr[7] = SDMA_PKT_HEADER_OP(SDMA_OP_NOP);
+	ib->length_dw = 8;
+
+	r = amdgpu_job_submit_direct(job, ring, &f);
+	if (r) {
+		amdgpu_job_free(job);
 		goto err1;
+	}
 
 	r = dma_fence_wait_timeout(f, false, timeout);
 	if (r == 0) {
@@ -632,7 +637,6 @@ static int sdma_v2_4_ring_test_ib(struct amdgpu_ring *ring, long timeout)
 		r = -EINVAL;
 
 err1:
-	amdgpu_ib_free(&ib, NULL);
 	dma_fence_put(f);
 err0:
 	amdgpu_device_wb_free(adev, index);
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c
index 2526d393162ac..73bd9005dbeaa 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c
@@ -857,7 +857,8 @@ static int sdma_v3_0_ring_test_ring(struct amdgpu_ring *ring)
 static int sdma_v3_0_ring_test_ib(struct amdgpu_ring *ring, long timeout)
 {
 	struct amdgpu_device *adev = ring->adev;
-	struct amdgpu_ib ib;
+	struct amdgpu_job *job;
+	struct amdgpu_ib *ib;
 	struct dma_fence *f = NULL;
 	unsigned index;
 	u32 tmp = 0;
@@ -871,26 +872,30 @@ static int sdma_v3_0_ring_test_ib(struct amdgpu_ring *ring, long timeout)
 	gpu_addr = adev->wb.gpu_addr + (index * 4);
 	tmp = 0xCAFEDEAD;
 	adev->wb.wb[index] = cpu_to_le32(tmp);
-	memset(&ib, 0, sizeof(ib));
-	r = amdgpu_ib_get(adev, NULL, 256,
-					AMDGPU_IB_POOL_DIRECT, &ib);
+
+	r = amdgpu_job_alloc_with_ib(ring->adev, NULL, NULL, 256,
+				     AMDGPU_IB_POOL_DIRECT, &job,
+				     AMDGPU_KERNEL_JOB_ID_SDMA_RING_TEST);
 	if (r)
 		goto err0;
 
-	ib.ptr[0] = SDMA_PKT_HEADER_OP(SDMA_OP_WRITE) |
+	ib = &job->ibs[0];
+	ib->ptr[0] = SDMA_PKT_HEADER_OP(SDMA_OP_WRITE) |
 		SDMA_PKT_HEADER_SUB_OP(SDMA_SUBOP_WRITE_LINEAR);
-	ib.ptr[1] = lower_32_bits(gpu_addr);
-	ib.ptr[2] = upper_32_bits(gpu_addr);
-	ib.ptr[3] = SDMA_PKT_WRITE_UNTILED_DW_3_COUNT(1);
-	ib.ptr[4] = 0xDEADBEEF;
-	ib.ptr[5] = SDMA_PKT_NOP_HEADER_OP(SDMA_OP_NOP);
-	ib.ptr[6] = SDMA_PKT_NOP_HEADER_OP(SDMA_OP_NOP);
-	ib.ptr[7] = SDMA_PKT_NOP_HEADER_OP(SDMA_OP_NOP);
-	ib.length_dw = 8;
-
-	r = amdgpu_ib_schedule(ring, 1, &ib, NULL, &f);
-	if (r)
+	ib->ptr[1] = lower_32_bits(gpu_addr);
+	ib->ptr[2] = upper_32_bits(gpu_addr);
+	ib->ptr[3] = SDMA_PKT_WRITE_UNTILED_DW_3_COUNT(1);
+	ib->ptr[4] = 0xDEADBEEF;
+	ib->ptr[5] = SDMA_PKT_NOP_HEADER_OP(SDMA_OP_NOP);
+	ib->ptr[6] = SDMA_PKT_NOP_HEADER_OP(SDMA_OP_NOP);
+	ib->ptr[7] = SDMA_PKT_NOP_HEADER_OP(SDMA_OP_NOP);
+	ib->length_dw = 8;
+
+	r = amdgpu_job_submit_direct(job, ring, &f);
+	if (r) {
+		amdgpu_job_free(job);
 		goto err1;
+	}
 
 	r = dma_fence_wait_timeout(f, false, timeout);
 	if (r == 0) {
@@ -905,7 +910,6 @@ static int sdma_v3_0_ring_test_ib(struct amdgpu_ring *ring, long timeout)
 	else
 		r = -EINVAL;
 err1:
-	amdgpu_ib_free(&ib, NULL);
 	dma_fence_put(f);
 err0:
 	amdgpu_device_wb_free(adev, index);
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
index 44f0f23e11484..94f1ea2d7f73a 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
@@ -1515,7 +1515,8 @@ static int sdma_v4_0_ring_test_ring(struct amdgpu_ring *ring)
 static int sdma_v4_0_ring_test_ib(struct amdgpu_ring *ring, long timeout)
 {
 	struct amdgpu_device *adev = ring->adev;
-	struct amdgpu_ib ib;
+	struct amdgpu_job *job;
+	struct amdgpu_ib *ib;
 	struct dma_fence *f = NULL;
 	unsigned index;
 	long r;
@@ -1529,26 +1530,30 @@ static int sdma_v4_0_ring_test_ib(struct amdgpu_ring *ring, long timeout)
 	gpu_addr = adev->wb.gpu_addr + (index * 4);
 	tmp = 0xCAFEDEAD;
 	adev->wb.wb[index] = cpu_to_le32(tmp);
-	memset(&ib, 0, sizeof(ib));
-	r = amdgpu_ib_get(adev, NULL, 256,
-					AMDGPU_IB_POOL_DIRECT, &ib);
+
+	r = amdgpu_job_alloc_with_ib(ring->adev, NULL, NULL, 256,
+				     AMDGPU_IB_POOL_DIRECT, &job,
+				     AMDGPU_KERNEL_JOB_ID_SDMA_RING_TEST);
 	if (r)
 		goto err0;
 
-	ib.ptr[0] = SDMA_PKT_HEADER_OP(SDMA_OP_WRITE) |
+	ib = &job->ibs[0];
+	ib->ptr[0] = SDMA_PKT_HEADER_OP(SDMA_OP_WRITE) |
 		SDMA_PKT_HEADER_SUB_OP(SDMA_SUBOP_WRITE_LINEAR);
-	ib.ptr[1] = lower_32_bits(gpu_addr);
-	ib.ptr[2] = upper_32_bits(gpu_addr);
-	ib.ptr[3] = SDMA_PKT_WRITE_UNTILED_DW_3_COUNT(0);
-	ib.ptr[4] = 0xDEADBEEF;
-	ib.ptr[5] = SDMA_PKT_NOP_HEADER_OP(SDMA_OP_NOP);
-	ib.ptr[6] = SDMA_PKT_NOP_HEADER_OP(SDMA_OP_NOP);
-	ib.ptr[7] = SDMA_PKT_NOP_HEADER_OP(SDMA_OP_NOP);
-	ib.length_dw = 8;
-
-	r = amdgpu_ib_schedule(ring, 1, &ib, NULL, &f);
-	if (r)
+	ib->ptr[1] = lower_32_bits(gpu_addr);
+	ib->ptr[2] = upper_32_bits(gpu_addr);
+	ib->ptr[3] = SDMA_PKT_WRITE_UNTILED_DW_3_COUNT(0);
+	ib->ptr[4] = 0xDEADBEEF;
+	ib->ptr[5] = SDMA_PKT_NOP_HEADER_OP(SDMA_OP_NOP);
+	ib->ptr[6] = SDMA_PKT_NOP_HEADER_OP(SDMA_OP_NOP);
+	ib->ptr[7] = SDMA_PKT_NOP_HEADER_OP(SDMA_OP_NOP);
+	ib->length_dw = 8;
+
+	r = amdgpu_job_submit_direct(job, ring, &f);
+	if (r) {
+		amdgpu_job_free(job);
 		goto err1;
+	}
 
 	r = dma_fence_wait_timeout(f, false, timeout);
 	if (r == 0) {
@@ -1564,7 +1569,6 @@ static int sdma_v4_0_ring_test_ib(struct amdgpu_ring *ring, long timeout)
 		r = -EINVAL;
 
 err1:
-	amdgpu_ib_free(&ib, NULL);
 	dma_fence_put(f);
 err0:
 	amdgpu_device_wb_free(adev, index);
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
index 78bdfed0a7fd3..0895ae39f6af0 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
@@ -1111,7 +1111,8 @@ static int sdma_v4_4_2_ring_test_ring(struct amdgpu_ring *ring)
 static int sdma_v4_4_2_ring_test_ib(struct amdgpu_ring *ring, long timeout)
 {
 	struct amdgpu_device *adev = ring->adev;
-	struct amdgpu_ib ib;
+	struct amdgpu_job *job;
+	struct amdgpu_ib *ib;
 	struct dma_fence *f = NULL;
 	unsigned index;
 	long r;
@@ -1125,26 +1126,30 @@ static int sdma_v4_4_2_ring_test_ib(struct amdgpu_ring *ring, long timeout)
 	gpu_addr = adev->wb.gpu_addr + (index * 4);
 	tmp = 0xCAFEDEAD;
 	adev->wb.wb[index] = cpu_to_le32(tmp);
-	memset(&ib, 0, sizeof(ib));
-	r = amdgpu_ib_get(adev, NULL, 256,
-					AMDGPU_IB_POOL_DIRECT, &ib);
+
+	r = amdgpu_job_alloc_with_ib(ring->adev, NULL, NULL, 256,
+				     AMDGPU_IB_POOL_DIRECT, &job,
+				     AMDGPU_KERNEL_JOB_ID_SDMA_RING_TEST);
 	if (r)
 		goto err0;
 
-	ib.ptr[0] = SDMA_PKT_HEADER_OP(SDMA_OP_WRITE) |
+	ib = &job->ibs[0];
+	ib->ptr[0] = SDMA_PKT_HEADER_OP(SDMA_OP_WRITE) |
 		SDMA_PKT_HEADER_SUB_OP(SDMA_SUBOP_WRITE_LINEAR);
-	ib.ptr[1] = lower_32_bits(gpu_addr);
-	ib.ptr[2] = upper_32_bits(gpu_addr);
-	ib.ptr[3] = SDMA_PKT_WRITE_UNTILED_DW_3_COUNT(0);
-	ib.ptr[4] = 0xDEADBEEF;
-	ib.ptr[5] = SDMA_PKT_NOP_HEADER_OP(SDMA_OP_NOP);
-	ib.ptr[6] = SDMA_PKT_NOP_HEADER_OP(SDMA_OP_NOP);
-	ib.ptr[7] = SDMA_PKT_NOP_HEADER_OP(SDMA_OP_NOP);
-	ib.length_dw = 8;
-
-	r = amdgpu_ib_schedule(ring, 1, &ib, NULL, &f);
-	if (r)
+	ib->ptr[1] = lower_32_bits(gpu_addr);
+	ib->ptr[2] = upper_32_bits(gpu_addr);
+	ib->ptr[3] = SDMA_PKT_WRITE_UNTILED_DW_3_COUNT(0);
+	ib->ptr[4] = 0xDEADBEEF;
+	ib->ptr[5] = SDMA_PKT_NOP_HEADER_OP(SDMA_OP_NOP);
+	ib->ptr[6] = SDMA_PKT_NOP_HEADER_OP(SDMA_OP_NOP);
+	ib->ptr[7] = SDMA_PKT_NOP_HEADER_OP(SDMA_OP_NOP);
+	ib->length_dw = 8;
+
+	r = amdgpu_job_submit_direct(job, ring, &f);
+	if (r) {
+		amdgpu_job_free(job);
 		goto err1;
+	}
 
 	r = dma_fence_wait_timeout(f, false, timeout);
 	if (r == 0) {
@@ -1160,7 +1165,6 @@ static int sdma_v4_4_2_ring_test_ib(struct amdgpu_ring *ring, long timeout)
 		r = -EINVAL;
 
 err1:
-	amdgpu_ib_free(&ib, NULL);
 	dma_fence_put(f);
 err0:
 	amdgpu_device_wb_free(adev, index);
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
index 52f4e9e099cbf..e91f976f869dc 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
@@ -1073,7 +1073,8 @@ static int sdma_v5_0_ring_test_ring(struct amdgpu_ring *ring)
 static int sdma_v5_0_ring_test_ib(struct amdgpu_ring *ring, long timeout)
 {
 	struct amdgpu_device *adev = ring->adev;
-	struct amdgpu_ib ib;
+	struct amdgpu_job *job;
+	struct amdgpu_ib *ib;
 	struct dma_fence *f = NULL;
 	unsigned index;
 	long r;
@@ -1081,7 +1082,6 @@ static int sdma_v5_0_ring_test_ib(struct amdgpu_ring *ring, long timeout)
 	u64 gpu_addr;
 
 	tmp = 0xCAFEDEAD;
-	memset(&ib, 0, sizeof(ib));
 
 	r = amdgpu_device_wb_get(adev, &index);
 	if (r) {
@@ -1092,27 +1092,31 @@ static int sdma_v5_0_ring_test_ib(struct amdgpu_ring *ring, long timeout)
 	gpu_addr = adev->wb.gpu_addr + (index * 4);
 	adev->wb.wb[index] = cpu_to_le32(tmp);
 
-	r = amdgpu_ib_get(adev, NULL, 256,
-			  AMDGPU_IB_POOL_DIRECT, &ib);
+	r = amdgpu_job_alloc_with_ib(ring->adev, NULL, NULL, 256,
+				     AMDGPU_IB_POOL_DIRECT, &job,
+				     AMDGPU_KERNEL_JOB_ID_SDMA_RING_TEST);
 	if (r) {
 		drm_err(adev_to_drm(adev), "failed to get ib (%ld).\n", r);
 		goto err0;
 	}
 
-	ib.ptr[0] = SDMA_PKT_HEADER_OP(SDMA_OP_WRITE) |
+	ib = &job->ibs[0];
+	ib->ptr[0] = SDMA_PKT_HEADER_OP(SDMA_OP_WRITE) |
 		SDMA_PKT_HEADER_SUB_OP(SDMA_SUBOP_WRITE_LINEAR);
-	ib.ptr[1] = lower_32_bits(gpu_addr);
-	ib.ptr[2] = upper_32_bits(gpu_addr);
-	ib.ptr[3] = SDMA_PKT_WRITE_UNTILED_DW_3_COUNT(0);
-	ib.ptr[4] = 0xDEADBEEF;
-	ib.ptr[5] = SDMA_PKT_NOP_HEADER_OP(SDMA_OP_NOP);
-	ib.ptr[6] = SDMA_PKT_NOP_HEADER_OP(SDMA_OP_NOP);
-	ib.ptr[7] = SDMA_PKT_NOP_HEADER_OP(SDMA_OP_NOP);
-	ib.length_dw = 8;
-
-	r = amdgpu_ib_schedule(ring, 1, &ib, NULL, &f);
-	if (r)
+	ib->ptr[1] = lower_32_bits(gpu_addr);
+	ib->ptr[2] = upper_32_bits(gpu_addr);
+	ib->ptr[3] = SDMA_PKT_WRITE_UNTILED_DW_3_COUNT(0);
+	ib->ptr[4] = 0xDEADBEEF;
+	ib->ptr[5] = SDMA_PKT_NOP_HEADER_OP(SDMA_OP_NOP);
+	ib->ptr[6] = SDMA_PKT_NOP_HEADER_OP(SDMA_OP_NOP);
+	ib->ptr[7] = SDMA_PKT_NOP_HEADER_OP(SDMA_OP_NOP);
+	ib->length_dw = 8;
+
+	r = amdgpu_job_submit_direct(job, ring, &f);
+	if (r) {
+		amdgpu_job_free(job);
 		goto err1;
+	}
 
 	r = dma_fence_wait_timeout(f, false, timeout);
 	if (r == 0) {
@@ -1132,7 +1136,6 @@ static int sdma_v5_0_ring_test_ib(struct amdgpu_ring *ring, long timeout)
 		r = -EINVAL;
 
 err1:
-	amdgpu_ib_free(&ib, NULL);
 	dma_fence_put(f);
 err0:
 	amdgpu_device_wb_free(adev, index);
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
index b4fb90cc8f7d9..d626d91a188eb 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
@@ -973,7 +973,8 @@ static int sdma_v5_2_ring_test_ring(struct amdgpu_ring *ring)
 static int sdma_v5_2_ring_test_ib(struct amdgpu_ring *ring, long timeout)
 {
 	struct amdgpu_device *adev = ring->adev;
-	struct amdgpu_ib ib;
+	struct amdgpu_job *job;
+	struct amdgpu_ib *ib;
 	struct dma_fence *f = NULL;
 	unsigned index;
 	long r;
@@ -981,7 +982,6 @@ static int sdma_v5_2_ring_test_ib(struct amdgpu_ring *ring, long timeout)
 	u64 gpu_addr;
 
 	tmp = 0xCAFEDEAD;
-	memset(&ib, 0, sizeof(ib));
 
 	r = amdgpu_device_wb_get(adev, &index);
 	if (r) {
@@ -992,26 +992,31 @@ static int sdma_v5_2_ring_test_ib(struct amdgpu_ring *ring, long timeout)
 	gpu_addr = adev->wb.gpu_addr + (index * 4);
 	adev->wb.wb[index] = cpu_to_le32(tmp);
 
-	r = amdgpu_ib_get(adev, NULL, 256, AMDGPU_IB_POOL_DIRECT, &ib);
+	r = amdgpu_job_alloc_with_ib(ring->adev, NULL, NULL, 256,
+				     AMDGPU_IB_POOL_DIRECT, &job,
+				     AMDGPU_KERNEL_JOB_ID_SDMA_RING_TEST);
 	if (r) {
 		drm_err(adev_to_drm(adev), "failed to get ib (%ld).\n", r);
 		goto err0;
 	}
 
-	ib.ptr[0] = SDMA_PKT_HEADER_OP(SDMA_OP_WRITE) |
+	ib = &job->ibs[0];
+	ib->ptr[0] = SDMA_PKT_HEADER_OP(SDMA_OP_WRITE) |
 		SDMA_PKT_HEADER_SUB_OP(SDMA_SUBOP_WRITE_LINEAR);
-	ib.ptr[1] = lower_32_bits(gpu_addr);
-	ib.ptr[2] = upper_32_bits(gpu_addr);
-	ib.ptr[3] = SDMA_PKT_WRITE_UNTILED_DW_3_COUNT(0);
-	ib.ptr[4] = 0xDEADBEEF;
-	ib.ptr[5] = SDMA_PKT_NOP_HEADER_OP(SDMA_OP_NOP);
-	ib.ptr[6] = SDMA_PKT_NOP_HEADER_OP(SDMA_OP_NOP);
-	ib.ptr[7] = SDMA_PKT_NOP_HEADER_OP(SDMA_OP_NOP);
-	ib.length_dw = 8;
-
-	r = amdgpu_ib_schedule(ring, 1, &ib, NULL, &f);
-	if (r)
+	ib->ptr[1] = lower_32_bits(gpu_addr);
+	ib->ptr[2] = upper_32_bits(gpu_addr);
+	ib->ptr[3] = SDMA_PKT_WRITE_UNTILED_DW_3_COUNT(0);
+	ib->ptr[4] = 0xDEADBEEF;
+	ib->ptr[5] = SDMA_PKT_NOP_HEADER_OP(SDMA_OP_NOP);
+	ib->ptr[6] = SDMA_PKT_NOP_HEADER_OP(SDMA_OP_NOP);
+	ib->ptr[7] = SDMA_PKT_NOP_HEADER_OP(SDMA_OP_NOP);
+	ib->length_dw = 8;
+
+	r = amdgpu_job_submit_direct(job, ring, &f);
+	if (r) {
+		amdgpu_job_free(job);
 		goto err1;
+	}
 
 	r = dma_fence_wait_timeout(f, false, timeout);
 	if (r == 0) {
@@ -1031,7 +1036,6 @@ static int sdma_v5_2_ring_test_ib(struct amdgpu_ring *ring, long timeout)
 		r = -EINVAL;
 
 err1:
-	amdgpu_ib_free(&ib, NULL);
 	dma_fence_put(f);
 err0:
 	amdgpu_device_wb_free(adev, index);
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
index b005672f2f96b..b7b6e7674400e 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
@@ -980,7 +980,8 @@ static int sdma_v6_0_ring_test_ring(struct amdgpu_ring *ring)
 static int sdma_v6_0_ring_test_ib(struct amdgpu_ring *ring, long timeout)
 {
 	struct amdgpu_device *adev = ring->adev;
-	struct amdgpu_ib ib;
+	struct amdgpu_job *job;
+	struct amdgpu_ib *ib;
 	struct dma_fence *f = NULL;
 	unsigned index;
 	long r;
@@ -988,7 +989,6 @@ static int sdma_v6_0_ring_test_ib(struct amdgpu_ring *ring, long timeout)
 	u64 gpu_addr;
 
 	tmp = 0xCAFEDEAD;
-	memset(&ib, 0, sizeof(ib));
 
 	r = amdgpu_device_wb_get(adev, &index);
 	if (r) {
@@ -999,26 +999,31 @@ static int sdma_v6_0_ring_test_ib(struct amdgpu_ring *ring, long timeout)
 	gpu_addr = adev->wb.gpu_addr + (index * 4);
 	adev->wb.wb[index] = cpu_to_le32(tmp);
 
-	r = amdgpu_ib_get(adev, NULL, 256, AMDGPU_IB_POOL_DIRECT, &ib);
+	r = amdgpu_job_alloc_with_ib(ring->adev, NULL, NULL, 256,
+				     AMDGPU_IB_POOL_DIRECT, &job,
+				     AMDGPU_KERNEL_JOB_ID_SDMA_RING_TEST);
 	if (r) {
 		drm_err(adev_to_drm(adev), "failed to get ib (%ld).\n", r);
 		goto err0;
 	}
 
-	ib.ptr[0] = SDMA_PKT_COPY_LINEAR_HEADER_OP(SDMA_OP_WRITE) |
+	ib = &job->ibs[0];
+	ib->ptr[0] = SDMA_PKT_COPY_LINEAR_HEADER_OP(SDMA_OP_WRITE) |
 		SDMA_PKT_COPY_LINEAR_HEADER_SUB_OP(SDMA_SUBOP_WRITE_LINEAR);
-	ib.ptr[1] = lower_32_bits(gpu_addr);
-	ib.ptr[2] = upper_32_bits(gpu_addr);
-	ib.ptr[3] = SDMA_PKT_WRITE_UNTILED_DW_3_COUNT(0);
-	ib.ptr[4] = 0xDEADBEEF;
-	ib.ptr[5] = SDMA_PKT_NOP_HEADER_OP(SDMA_OP_NOP);
-	ib.ptr[6] = SDMA_PKT_NOP_HEADER_OP(SDMA_OP_NOP);
-	ib.ptr[7] = SDMA_PKT_NOP_HEADER_OP(SDMA_OP_NOP);
-	ib.length_dw = 8;
-
-	r = amdgpu_ib_schedule(ring, 1, &ib, NULL, &f);
-	if (r)
+	ib->ptr[1] = lower_32_bits(gpu_addr);
+	ib->ptr[2] = upper_32_bits(gpu_addr);
+	ib->ptr[3] = SDMA_PKT_WRITE_UNTILED_DW_3_COUNT(0);
+	ib->ptr[4] = 0xDEADBEEF;
+	ib->ptr[5] = SDMA_PKT_NOP_HEADER_OP(SDMA_OP_NOP);
+	ib->ptr[6] = SDMA_PKT_NOP_HEADER_OP(SDMA_OP_NOP);
+	ib->ptr[7] = SDMA_PKT_NOP_HEADER_OP(SDMA_OP_NOP);
+	ib->length_dw = 8;
+
+	r = amdgpu_job_submit_direct(job, ring, &f);
+	if (r) {
+		amdgpu_job_free(job);
 		goto err1;
+	}
 
 	r = dma_fence_wait_timeout(f, false, timeout);
 	if (r == 0) {
@@ -1038,7 +1043,6 @@ static int sdma_v6_0_ring_test_ib(struct amdgpu_ring *ring, long timeout)
 		r = -EINVAL;
 
 err1:
-	amdgpu_ib_free(&ib, NULL);
 	dma_fence_put(f);
 err0:
 	amdgpu_device_wb_free(adev, index);
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
index 5679a94d0815e..7013f58de9d40 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
@@ -996,7 +996,8 @@ static int sdma_v7_0_ring_test_ring(struct amdgpu_ring *ring)
 static int sdma_v7_0_ring_test_ib(struct amdgpu_ring *ring, long timeout)
 {
 	struct amdgpu_device *adev = ring->adev;
-	struct amdgpu_ib ib;
+	struct amdgpu_job *job;
+	struct amdgpu_ib *ib;
 	struct dma_fence *f = NULL;
 	unsigned index;
 	long r;
@@ -1004,7 +1005,6 @@ static int sdma_v7_0_ring_test_ib(struct amdgpu_ring *ring, long timeout)
 	u64 gpu_addr;
 
 	tmp = 0xCAFEDEAD;
-	memset(&ib, 0, sizeof(ib));
 
 	r = amdgpu_device_wb_get(adev, &index);
 	if (r) {
@@ -1015,26 +1015,31 @@ static int sdma_v7_0_ring_test_ib(struct amdgpu_ring *ring, long timeout)
 	gpu_addr = adev->wb.gpu_addr + (index * 4);
 	adev->wb.wb[index] = cpu_to_le32(tmp);
 
-	r = amdgpu_ib_get(adev, NULL, 256, AMDGPU_IB_POOL_DIRECT, &ib);
+	r = amdgpu_job_alloc_with_ib(ring->adev, NULL, NULL, 256,
+				     AMDGPU_IB_POOL_DIRECT, &job,
+				     AMDGPU_KERNEL_JOB_ID_SDMA_RING_TEST);
 	if (r) {
 		drm_err(adev_to_drm(adev), "failed to get ib (%ld).\n", r);
 		goto err0;
 	}
 
-	ib.ptr[0] = SDMA_PKT_COPY_LINEAR_HEADER_OP(SDMA_OP_WRITE) |
+	ib = &job->ibs[0];
+	ib->ptr[0] = SDMA_PKT_COPY_LINEAR_HEADER_OP(SDMA_OP_WRITE) |
 		SDMA_PKT_COPY_LINEAR_HEADER_SUB_OP(SDMA_SUBOP_WRITE_LINEAR);
-	ib.ptr[1] = lower_32_bits(gpu_addr);
-	ib.ptr[2] = upper_32_bits(gpu_addr);
-	ib.ptr[3] = SDMA_PKT_WRITE_UNTILED_DW_3_COUNT(0);
-	ib.ptr[4] = 0xDEADBEEF;
-	ib.ptr[5] = SDMA_PKT_NOP_HEADER_OP(SDMA_OP_NOP);
-	ib.ptr[6] = SDMA_PKT_NOP_HEADER_OP(SDMA_OP_NOP);
-	ib.ptr[7] = SDMA_PKT_NOP_HEADER_OP(SDMA_OP_NOP);
-	ib.length_dw = 8;
-
-	r = amdgpu_ib_schedule(ring, 1, &ib, NULL, &f);
-	if (r)
+	ib->ptr[1] = lower_32_bits(gpu_addr);
+	ib->ptr[2] = upper_32_bits(gpu_addr);
+	ib->ptr[3] = SDMA_PKT_WRITE_UNTILED_DW_3_COUNT(0);
+	ib->ptr[4] = 0xDEADBEEF;
+	ib->ptr[5] = SDMA_PKT_NOP_HEADER_OP(SDMA_OP_NOP);
+	ib->ptr[6] = SDMA_PKT_NOP_HEADER_OP(SDMA_OP_NOP);
+	ib->ptr[7] = SDMA_PKT_NOP_HEADER_OP(SDMA_OP_NOP);
+	ib->length_dw = 8;
+
+	r = amdgpu_job_submit_direct(job, ring, &f);
+	if (r) {
+		amdgpu_job_free(job);
 		goto err1;
+	}
 
 	r = dma_fence_wait_timeout(f, false, timeout);
 	if (r == 0) {
@@ -1054,7 +1059,6 @@ static int sdma_v7_0_ring_test_ib(struct amdgpu_ring *ring, long timeout)
 		r = -EINVAL;
 
 err1:
-	amdgpu_ib_free(&ib, NULL);
 	dma_fence_put(f);
 err0:
 	amdgpu_device_wb_free(adev, index);
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v7_1.c b/drivers/gpu/drm/amd/amdgpu/sdma_v7_1.c
index f20e0fc3fc743..28237f6ae002c 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v7_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v7_1.c
@@ -986,7 +986,8 @@ static int sdma_v7_1_ring_test_ring(struct amdgpu_ring *ring)
 static int sdma_v7_1_ring_test_ib(struct amdgpu_ring *ring, long timeout)
 {
 	struct amdgpu_device *adev = ring->adev;
-	struct amdgpu_ib ib;
+	struct amdgpu_job *job;
+	struct amdgpu_ib *ib;
 	struct dma_fence *f = NULL;
 	unsigned index;
 	long r;
@@ -994,7 +995,6 @@ static int sdma_v7_1_ring_test_ib(struct amdgpu_ring *ring, long timeout)
 	u64 gpu_addr;
 
 	tmp = 0xCAFEDEAD;
-	memset(&ib, 0, sizeof(ib));
 
 	r = amdgpu_device_wb_get(adev, &index);
 	if (r) {
@@ -1005,26 +1005,31 @@ static int sdma_v7_1_ring_test_ib(struct amdgpu_ring *ring, long timeout)
 	gpu_addr = adev->wb.gpu_addr + (index * 4);
 	adev->wb.wb[index] = cpu_to_le32(tmp);
 
-	r = amdgpu_ib_get(adev, NULL, 256, AMDGPU_IB_POOL_DIRECT, &ib);
+	r = amdgpu_job_alloc_with_ib(ring->adev, NULL, NULL, 256,
+				     AMDGPU_IB_POOL_DIRECT, &job,
+				     AMDGPU_KERNEL_JOB_ID_SDMA_RING_TEST);
 	if (r) {
 		DRM_ERROR("amdgpu: failed to get ib (%ld).\n", r);
 		goto err0;
 	}
 
-	ib.ptr[0] = SDMA_PKT_COPY_LINEAR_HEADER_OP(SDMA_OP_WRITE) |
+	ib = &job->ibs[0];
+	ib->ptr[0] = SDMA_PKT_COPY_LINEAR_HEADER_OP(SDMA_OP_WRITE) |
 		SDMA_PKT_COPY_LINEAR_HEADER_SUB_OP(SDMA_SUBOP_WRITE_LINEAR);
-	ib.ptr[1] = lower_32_bits(gpu_addr);
-	ib.ptr[2] = upper_32_bits(gpu_addr);
-	ib.ptr[3] = SDMA_PKT_WRITE_UNTILED_DW_3_COUNT(0);
-	ib.ptr[4] = 0xDEADBEEF;
-	ib.ptr[5] = SDMA_PKT_NOP_HEADER_OP(SDMA_OP_NOP);
-	ib.ptr[6] = SDMA_PKT_NOP_HEADER_OP(SDMA_OP_NOP);
-	ib.ptr[7] = SDMA_PKT_NOP_HEADER_OP(SDMA_OP_NOP);
-	ib.length_dw = 8;
-
-	r = amdgpu_ib_schedule(ring, 1, &ib, NULL, &f);
-	if (r)
+	ib->ptr[1] = lower_32_bits(gpu_addr);
+	ib->ptr[2] = upper_32_bits(gpu_addr);
+	ib->ptr[3] = SDMA_PKT_WRITE_UNTILED_DW_3_COUNT(0);
+	ib->ptr[4] = 0xDEADBEEF;
+	ib->ptr[5] = SDMA_PKT_NOP_HEADER_OP(SDMA_OP_NOP);
+	ib->ptr[6] = SDMA_PKT_NOP_HEADER_OP(SDMA_OP_NOP);
+	ib->ptr[7] = SDMA_PKT_NOP_HEADER_OP(SDMA_OP_NOP);
+	ib->length_dw = 8;
+
+	r = amdgpu_job_submit_direct(job, ring, &f);
+	if (r) {
+		amdgpu_job_free(job);
 		goto err1;
+	}
 
 	r = dma_fence_wait_timeout(f, false, timeout);
 	if (r == 0) {
@@ -1044,7 +1049,6 @@ static int sdma_v7_1_ring_test_ib(struct amdgpu_ring *ring, long timeout)
 		r = -EINVAL;
 
 err1:
-	amdgpu_ib_free(&ib, NULL);
 	dma_fence_put(f);
 err0:
 	amdgpu_device_wb_free(adev, index);
diff --git a/drivers/gpu/drm/amd/amdgpu/si_dma.c b/drivers/gpu/drm/amd/amdgpu/si_dma.c
index 3e58feb2d5e4f..8362db058da2a 100644
--- a/drivers/gpu/drm/amd/amdgpu/si_dma.c
+++ b/drivers/gpu/drm/amd/amdgpu/si_dma.c
@@ -258,7 +258,8 @@ static int si_dma_ring_test_ring(struct amdgpu_ring *ring)
 static int si_dma_ring_test_ib(struct amdgpu_ring *ring, long timeout)
 {
 	struct amdgpu_device *adev = ring->adev;
-	struct amdgpu_ib ib;
+	struct amdgpu_job *job;
+	struct amdgpu_ib *ib;
 	struct dma_fence *f = NULL;
 	unsigned index;
 	u32 tmp = 0;
@@ -272,20 +273,25 @@ static int si_dma_ring_test_ib(struct amdgpu_ring *ring, long timeout)
 	gpu_addr = adev->wb.gpu_addr + (index * 4);
 	tmp = 0xCAFEDEAD;
 	adev->wb.wb[index] = cpu_to_le32(tmp);
-	memset(&ib, 0, sizeof(ib));
-	r = amdgpu_ib_get(adev, NULL, 256,
-					AMDGPU_IB_POOL_DIRECT, &ib);
+
+	r = amdgpu_job_alloc_with_ib(ring->adev, NULL, NULL, 256,
+				     AMDGPU_IB_POOL_DIRECT, &job,
+				     AMDGPU_KERNEL_JOB_ID_SDMA_RING_TEST);
 	if (r)
 		goto err0;
 
-	ib.ptr[0] = DMA_PACKET(DMA_PACKET_WRITE, 0, 0, 0, 1);
-	ib.ptr[1] = lower_32_bits(gpu_addr);
-	ib.ptr[2] = upper_32_bits(gpu_addr) & 0xff;
-	ib.ptr[3] = 0xDEADBEEF;
-	ib.length_dw = 4;
-	r = amdgpu_ib_schedule(ring, 1, &ib, NULL, &f);
-	if (r)
+	ib = &job->ibs[0];
+	ib->ptr[0] = DMA_PACKET(DMA_PACKET_WRITE, 0, 0, 0, 1);
+	ib->ptr[1] = lower_32_bits(gpu_addr);
+	ib->ptr[2] = upper_32_bits(gpu_addr) & 0xff;
+	ib->ptr[3] = 0xDEADBEEF;
+	ib->length_dw = 4;
+
+	r = amdgpu_job_submit_direct(job, ring, &f);
+	if (r) {
+		amdgpu_job_free(job);
 		goto err1;
+	}
 
 	r = dma_fence_wait_timeout(f, false, timeout);
 	if (r == 0) {
@@ -301,7 +307,6 @@ static int si_dma_ring_test_ib(struct amdgpu_ring *ring, long timeout)
 		r = -EINVAL;
 
 err1:
-	amdgpu_ib_free(&ib, NULL);
 	dma_fence_put(f);
 err0:
 	amdgpu_device_wb_free(adev, index);
-- 
2.53.0

