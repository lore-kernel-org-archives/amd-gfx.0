Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1919C43458
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Jul 2026 18:25:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5E14910E0FF;
	Mon, 13 Jul 2026 18:25:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="CT6gISQz";
	dkim-atps=neutral
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010050.outbound.protection.outlook.com [52.101.56.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6E9C910E0FF
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 Jul 2026 18:25:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yVKIENuKqdBD5FQ8xAwmDyrSECJGMxgZ+QnGnZoOZOPvw9KITr4Qk/y5QAjROwRsIhHYNqYNoNkakCFRV/DkRK7Q52mcd2Ho/GUjwW23Jv7okqchEDh2UZulU4aW76bM6+rHYpOjWt8MsDtRxKUjLckfiBsfFGkei+S/AZeF1bsbSdCnTG6QOVsftbE95TnCtp/xIIE2Af6HW/luvCLfQP6qrUpOf/BWskKQyuhhjUpAaZHZCVoveH/XEdCY64UQF3mewMJ06Oowuvhx4zS/SCil0mJZn/Y/4q32O5uBCYjWCE6Ay4MbIXFyfK218WsetzNjrkq9/dT2hoDBhc/Rnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oKaGvgXyTn/KXVQS8WMyDGyupAt/tei73WTi3L805kI=;
 b=muUjnjdmEStESKNaccpq60LH6Q7hNH9vIJ9DfsPIpRoi5LQggNaeBwwewvoYdMfj0r0fFicVxU1D3mBh8eQco1EgYzURe8DIoJl2SmOL1tSsfSNpWGFt03SxX87ImHK4GOiWLe3JC5168YZTrnGc+i2YyiA5yG6hSefCLWFBuNxtcRSLQjn60UN6f4JZWYqs3/EK5f1LKcvvPclENB5pwsXd3KskvEdUnGD5TZ0h+ujZG/B0DkeQOaEpnyq+dpYMrQoRB3aFhnxLDhLoK2dYJzQJDwnhDDOySGEl3NxuXudGU3Y0Dj4xWgX8P7aQxNBZijLANVX4k06eXilMb2pIyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oKaGvgXyTn/KXVQS8WMyDGyupAt/tei73WTi3L805kI=;
 b=CT6gISQzeLK5bAjQ3TnjOSq9Jl/VC+t2mKqYG4z5kGiJ2ABXvIuhE/7iqiWu29cMGx8cDBRycSYPvrQfzWROZNMNgdBDvpX/ucyViZQuDtrb+3D70JcyOkJSvTNJhwkWTuGcMKXHDPQUjKZptIrOZMSA/YWBmXDwIElIt6uJKHA=
Received: from SN7PR04CA0226.namprd04.prod.outlook.com (2603:10b6:806:127::21)
 by CH3PR12MB8185.namprd12.prod.outlook.com (2603:10b6:610:123::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.202.19; Mon, 13 Jul
 2026 18:25:46 +0000
Received: from SA2PEPF00003AE7.namprd02.prod.outlook.com
 (2603:10b6:806:127:cafe::98) by SN7PR04CA0226.outlook.office365.com
 (2603:10b6:806:127::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.202.19 via Frontend Transport; Mon,
 13 Jul 2026 18:25:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SA2PEPF00003AE7.mail.protection.outlook.com (10.167.248.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.223.9 via Frontend Transport; Mon, 13 Jul 2026 18:25:46 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 13 Jul
 2026 13:25:29 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Mon, 13 Jul 2026 13:25:28 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>, Pierre-Eric Pelloux-Prayer
 <pierre-eric.pelloux-prayer@amd.com>, =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
Subject: [PATCH 1/2] drm/amdgpu: switch all IPs to using job for IBs
Date: Mon, 13 Jul 2026 14:25:07 -0400
Message-ID: <20260713182508.630539-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003AE7:EE_|CH3PR12MB8185:EE_
X-MS-Office365-Filtering-Correlation-Id: 3288e76f-e1d7-4167-4f7e-08dee10c283f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700016|23010399003|376014|18002099003|3023799007|56012099006|11063799006|6133799003;
X-Microsoft-Antispam-Message-Info: WMUjx8E1ZcgG/8XDTmp6n0DqUg54hVfuSO1Mq1dejpTrefxU6p9ufEkpAa/cgtFVp33KuHhVoWGUzEm/WUN2/wrmGfCNZkWpcw1gGt2st0fWYPflNioNsCdNbYl4bPu4AgS+RhrVZ51/mvrE8dBjnZ7n6+r+AcfgTg8+vvPDfBHfbpmThxXKMfnIj5LPP52SdWQ0FrWrL+Trkho93KMbX68nkPCjacIvt3FaXUxEvZ/lxnQY9WLKE4ATXsTfjicSrJknX/R19tqiLLiFrbnkT5bTsd1VqTp9VWXrYKVN9YP7WLR3FujqRIeQpwHroWwjKKcQf46136PhJ/e/bwQGFdxHIy4Cu5zcfwHHRA2vMKo+8Lcm/jXt2jyAMkoOZW/7ft9qYUQ7KZwW+W/uk+MyLN8PJ7rfs/mfR9EmPABTOp3U/ntpz+OGOzzehfT2lY+yqbyodovfF6jiXOlpBNklSbWu8Z7vNxP7f88IegoUHomBVhXoGceq8zrjcumMC9lhLQR2IDTjKsOQDxPrw+bqUKYw/J//J5pnyVxt7QXPhaa0IP4owbB5Mp6C5c1PIn3eDMuIScOTFKvMkvaEZfP7+dzOQwYpOfG1IhtdyVEx2KDf0TdAwxJdPozKqV1YhuJJs/Kgg83RuQyyrbDVk+h8MsWzVVANmaLxh5w2ogh0IcLLcFksXcIW1tKj8fhK9BFFL3YPQ9uRVBG6HxSfcpfciA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700016)(23010399003)(376014)(18002099003)(3023799007)(56012099006)(11063799006)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 0hyWLQBMf4YW2149zbCr6zztqh15V+VNzrR1qpJx8n+CHnj2ytvPjAdV6uLv2MbmVP+Va3j13K+OKC+CucikFX1ooAbNqOa+mzrWtOAgeKl2s7Lg82nAXy5jCv+loAUdhor77Ew5YSCUF72mv1FEaEVUVGC9k4K04txM97fgwAkVwQnNmH6w2c/ROMFKVWCOhW5GhdQKhn88iGrzK2Aqlay/XTkay0jSLK020cLbMaJXhSfmcttBbtNVWETa3N/PYXOZ29j/YGa6XQmko7bhXN+3DK5e6c4Qd39lNo7OqRmp+TbNr2XI0PdR4Ux0Tw0Ni0PHdY+kRmlrYXRwz1PNRTbzGU2c/oF2mcDwuAtdPyg4LVHliVOX0wjmMnidN5k9ke98bLx/lnhYcJLV7GKkH4REtCvt9M/xByEXfNDrgztzRuclt70jikOZipJ1tdMH
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2026 18:25:46.3920 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3288e76f-e1d7-4167-4f7e-08dee10c283f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00003AE7.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8185
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
index 2b45010b7ebed..ddc66aeb54c8c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c
@@ -827,7 +827,8 @@ static int vpe_ring_test_ib(struct amdgpu_ring *ring, long timeout)
 {
 	struct amdgpu_device *adev = ring->adev;
 	const uint32_t test_pattern = 0xdeadbeef;
-	struct amdgpu_ib ib = {};
+	struct amdgpu_job *job;
+	struct amdgpu_ib *ib;
 	struct dma_fence *f = NULL;
 	uint32_t index;
 	uint64_t wb_addr;
@@ -842,23 +843,28 @@ static int vpe_ring_test_ib(struct amdgpu_ring *ring, long timeout)
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
@@ -869,7 +875,6 @@ static int vpe_ring_test_ib(struct amdgpu_ring *ring, long timeout)
 	ret = (le32_to_cpu(adev->wb.wb[index]) == test_pattern) ? 0 : -EINVAL;
 
 err1:
-	amdgpu_ib_free(&ib, NULL);
 	dma_fence_put(f);
 err0:
 	amdgpu_wb_free(adev, index);
diff --git a/drivers/gpu/drm/amd/amdgpu/cik_sdma.c b/drivers/gpu/drm/amd/amdgpu/cik_sdma.c
index b951328d94cfb..15647aba8a68c 100644
--- a/drivers/gpu/drm/amd/amdgpu/cik_sdma.c
+++ b/drivers/gpu/drm/amd/amdgpu/cik_sdma.c
@@ -652,7 +652,8 @@ static int cik_sdma_ring_test_ring(struct amdgpu_ring *ring)
 static int cik_sdma_ring_test_ib(struct amdgpu_ring *ring, long timeout)
 {
 	struct amdgpu_device *adev = ring->adev;
-	struct amdgpu_ib ib;
+	struct amdgpu_job *job;
+	struct amdgpu_ib *ib;
 	struct dma_fence *f = NULL;
 	unsigned index;
 	u32 tmp = 0;
@@ -666,22 +667,27 @@ static int cik_sdma_ring_test_ib(struct amdgpu_ring *ring, long timeout)
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
@@ -697,7 +703,6 @@ static int cik_sdma_ring_test_ib(struct amdgpu_ring *ring, long timeout)
 		r = -EINVAL;
 
 err1:
-	amdgpu_ib_free(&ib, NULL);
 	dma_fence_put(f);
 err0:
 	amdgpu_wb_free(adev, index);
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
index a998ce77da40b..67af7556bd665 100644
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
 	r = amdgpu_wb_get(adev, &index);
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
 	amdgpu_wb_free(adev, index);
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
index 0cbbdc3694f4c..1fe21305eba52 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -621,7 +621,8 @@ static int gfx_v11_0_ring_test_ring(struct amdgpu_ring *ring)
 static int gfx_v11_0_ring_test_ib(struct amdgpu_ring *ring, long timeout)
 {
 	struct amdgpu_device *adev = ring->adev;
-	struct amdgpu_ib ib;
+	struct amdgpu_job *job;
+	struct amdgpu_ib *ib;
 	struct dma_fence *f = NULL;
 	unsigned index;
 	uint64_t gpu_addr;
@@ -633,8 +634,6 @@ static int gfx_v11_0_ring_test_ib(struct amdgpu_ring *ring, long timeout)
 	    ring->funcs->type == AMDGPU_RING_TYPE_KIQ)
 		return 0;
 
-	memset(&ib, 0, sizeof(ib));
-
 	r = amdgpu_wb_get(adev, &index);
 	if (r)
 		return r;
@@ -643,22 +642,27 @@ static int gfx_v11_0_ring_test_ib(struct amdgpu_ring *ring, long timeout)
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
@@ -673,7 +677,6 @@ static int gfx_v11_0_ring_test_ib(struct amdgpu_ring *ring, long timeout)
 	else
 		r = -EINVAL;
 err2:
-	amdgpu_ib_free(&ib, NULL);
 	dma_fence_put(f);
 err1:
 	amdgpu_wb_free(adev, index);
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
index b3887c5262a0d..498798a9dac7a 100644
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
 	r = amdgpu_wb_get(adev, &index);
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
 	amdgpu_wb_free(adev, index);
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c b/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
index 1f7e243d2ad99..bfdf392bfc0bd 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
@@ -427,7 +427,8 @@ static int gfx_v12_1_ring_test_ring(struct amdgpu_ring *ring)
 static int gfx_v12_1_ring_test_ib(struct amdgpu_ring *ring, long timeout)
 {
 	struct amdgpu_device *adev = ring->adev;
-	struct amdgpu_ib ib;
+	struct amdgpu_job *job;
+	struct amdgpu_ib *ib;
 	struct dma_fence *f = NULL;
 	unsigned index;
 	uint64_t gpu_addr;
@@ -439,8 +440,6 @@ static int gfx_v12_1_ring_test_ib(struct amdgpu_ring *ring, long timeout)
 	    ring->funcs->type == AMDGPU_RING_TYPE_KIQ)
 		return 0;
 
-	memset(&ib, 0, sizeof(ib));
-
 	r = amdgpu_wb_get(adev, &index);
 	if (r)
 		return r;
@@ -449,22 +448,27 @@ static int gfx_v12_1_ring_test_ib(struct amdgpu_ring *ring, long timeout)
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
-	ib.ptr[1] = PACKET3_WRITE_DATA__DST_SEL(5) | PACKET3_WRITE_DATA__WR_CONFIRM(1);
-	ib.ptr[2] = lower_32_bits(gpu_addr);
-	ib.ptr[3] = upper_32_bits(gpu_addr);
-	ib.ptr[4] = 0xDEADBEEF;
-	ib.length_dw = 5;
+	ib->ptr[0] = PACKET3(PACKET3_WRITE_DATA, 3);
+	ib->ptr[1] = PACKET3_WRITE_DATA__DST_SEL(5) | PACKET3_WRITE_DATA__WR_CONFIRM(1);
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
@@ -479,7 +483,6 @@ static int gfx_v12_1_ring_test_ib(struct amdgpu_ring *ring, long timeout)
 	else
 		r = -EINVAL;
 err2:
-	amdgpu_ib_free(&ib, NULL);
 	dma_fence_put(f);
 err1:
 	amdgpu_wb_free(adev, index);
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c
index ac90d8e9d86a8..67da6a81d3f32 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c
@@ -1961,24 +1961,29 @@ static int gfx_v6_0_ring_test_ib(struct amdgpu_ring *ring, long timeout)
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
@@ -1994,7 +1999,6 @@ static int gfx_v6_0_ring_test_ib(struct amdgpu_ring *ring, long timeout)
 		r = -EINVAL;
 
 error:
-	amdgpu_ib_free(&ib, NULL);
 	dma_fence_put(f);
 	return r;
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
index 65b8497ad5f02..79e4c147f43e6 100644
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
index 9e0840df88497..52e575bf31032 100644
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
 	amdgpu_wb_free(adev, index);
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
@@ -1512,106 +1516,108 @@ static int gfx_v8_0_do_edc_gpr_workarounds(struct amdgpu_device *adev)
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
 
@@ -1636,7 +1642,6 @@ static int gfx_v8_0_do_edc_gpr_workarounds(struct amdgpu_device *adev)
 		RREG32(sec_ded_counter_registers[i]);
 
 fail:
-	amdgpu_ib_free(&ib, NULL);
 	dma_fence_put(f);
 
 	return r;
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
index 1cad6dc9476e0..043e6c3b3656b 100644
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
 	amdgpu_wb_free(adev, index);
@@ -4683,7 +4686,8 @@ static int gfx_v9_0_do_edc_gds_workarounds(struct amdgpu_device *adev)
 static int gfx_v9_0_do_edc_gpr_workarounds(struct amdgpu_device *adev)
 {
 	struct amdgpu_ring *ring = &adev->gfx.compute_ring[0];
-	struct amdgpu_ib ib;
+	struct amdgpu_job *job;
+	struct amdgpu_ib *ib;
 	struct dma_fence *f = NULL;
 	int r, i;
 	unsigned total_size, vgpr_offset, sgpr_offset;
@@ -4729,112 +4733,114 @@ static int gfx_v9_0_do_edc_gpr_workarounds(struct amdgpu_device *adev)
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
 
@@ -4846,7 +4852,6 @@ static int gfx_v9_0_do_edc_gpr_workarounds(struct amdgpu_device *adev)
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
index 44d38b76cb4f7..9e273944f70d0 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
@@ -450,9 +450,9 @@ static int gfx_v9_4_3_ring_test_ring(struct amdgpu_ring *ring)
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
@@ -464,22 +464,26 @@ static int gfx_v9_4_3_ring_test_ib(struct amdgpu_ring *ring, long timeout)
 
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
@@ -496,7 +500,6 @@ static int gfx_v9_4_3_ring_test_ib(struct amdgpu_ring *ring, long timeout)
 		r = -EINVAL;
 
 err2:
-	amdgpu_ib_free(&ib, NULL);
 	dma_fence_put(f);
 err1:
 	amdgpu_wb_free(adev, index);
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c b/drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c
index c7253b908351c..a308539d047b7 100644
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
 	amdgpu_wb_free(adev, index);
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c
index 05cce4bde73eb..4c8b6323afb14 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c
@@ -858,7 +858,8 @@ static int sdma_v3_0_ring_test_ring(struct amdgpu_ring *ring)
 static int sdma_v3_0_ring_test_ib(struct amdgpu_ring *ring, long timeout)
 {
 	struct amdgpu_device *adev = ring->adev;
-	struct amdgpu_ib ib;
+	struct amdgpu_job *job;
+	struct amdgpu_ib *ib;
 	struct dma_fence *f = NULL;
 	unsigned index;
 	u32 tmp = 0;
@@ -872,26 +873,30 @@ static int sdma_v3_0_ring_test_ib(struct amdgpu_ring *ring, long timeout)
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
@@ -906,7 +911,6 @@ static int sdma_v3_0_ring_test_ib(struct amdgpu_ring *ring, long timeout)
 	else
 		r = -EINVAL;
 err1:
-	amdgpu_ib_free(&ib, NULL);
 	dma_fence_put(f);
 err0:
 	amdgpu_wb_free(adev, index);
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
index 20c8ebf0e1591..a1a40b747f90c 100644
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
 	amdgpu_wb_free(adev, index);
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
index 6fe3d3d56c406..03e911cb18192 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
@@ -1109,7 +1109,8 @@ static int sdma_v4_4_2_ring_test_ring(struct amdgpu_ring *ring)
 static int sdma_v4_4_2_ring_test_ib(struct amdgpu_ring *ring, long timeout)
 {
 	struct amdgpu_device *adev = ring->adev;
-	struct amdgpu_ib ib;
+	struct amdgpu_job *job;
+	struct amdgpu_ib *ib;
 	struct dma_fence *f = NULL;
 	unsigned index;
 	long r;
@@ -1123,26 +1124,30 @@ static int sdma_v4_4_2_ring_test_ib(struct amdgpu_ring *ring, long timeout)
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
@@ -1158,7 +1163,6 @@ static int sdma_v4_4_2_ring_test_ib(struct amdgpu_ring *ring, long timeout)
 		r = -EINVAL;
 
 err1:
-	amdgpu_ib_free(&ib, NULL);
 	dma_fence_put(f);
 err0:
 	amdgpu_wb_free(adev, index);
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
index 1ca0e7f65442e..dc59039ffe000 100644
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
 
 	r = amdgpu_wb_get(adev, &index);
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
 	amdgpu_wb_free(adev, index);
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
index 81f1e9882177b..e112e3e2ed26b 100644
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
 
 	r = amdgpu_wb_get(adev, &index);
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
 	amdgpu_wb_free(adev, index);
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
index cf3d2997fff88..8d657aec1340a 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
@@ -964,7 +964,8 @@ static int sdma_v6_0_ring_test_ring(struct amdgpu_ring *ring)
 static int sdma_v6_0_ring_test_ib(struct amdgpu_ring *ring, long timeout)
 {
 	struct amdgpu_device *adev = ring->adev;
-	struct amdgpu_ib ib;
+	struct amdgpu_job *job;
+	struct amdgpu_ib *ib;
 	struct dma_fence *f = NULL;
 	unsigned index;
 	long r;
@@ -972,7 +973,6 @@ static int sdma_v6_0_ring_test_ib(struct amdgpu_ring *ring, long timeout)
 	u64 gpu_addr;
 
 	tmp = 0xCAFEDEAD;
-	memset(&ib, 0, sizeof(ib));
 
 	r = amdgpu_wb_get(adev, &index);
 	if (r) {
@@ -983,26 +983,31 @@ static int sdma_v6_0_ring_test_ib(struct amdgpu_ring *ring, long timeout)
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
@@ -1022,7 +1027,6 @@ static int sdma_v6_0_ring_test_ib(struct amdgpu_ring *ring, long timeout)
 		r = -EINVAL;
 
 err1:
-	amdgpu_ib_free(&ib, NULL);
 	dma_fence_put(f);
 err0:
 	amdgpu_wb_free(adev, index);
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
index 69cb89298a3e0..1f460e1b1e6d6 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
@@ -979,7 +979,8 @@ static int sdma_v7_0_ring_test_ring(struct amdgpu_ring *ring)
 static int sdma_v7_0_ring_test_ib(struct amdgpu_ring *ring, long timeout)
 {
 	struct amdgpu_device *adev = ring->adev;
-	struct amdgpu_ib ib;
+	struct amdgpu_job *job;
+	struct amdgpu_ib *ib;
 	struct dma_fence *f = NULL;
 	unsigned index;
 	long r;
@@ -987,7 +988,6 @@ static int sdma_v7_0_ring_test_ib(struct amdgpu_ring *ring, long timeout)
 	u64 gpu_addr;
 
 	tmp = 0xCAFEDEAD;
-	memset(&ib, 0, sizeof(ib));
 
 	r = amdgpu_wb_get(adev, &index);
 	if (r) {
@@ -998,26 +998,31 @@ static int sdma_v7_0_ring_test_ib(struct amdgpu_ring *ring, long timeout)
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
@@ -1037,7 +1042,6 @@ static int sdma_v7_0_ring_test_ib(struct amdgpu_ring *ring, long timeout)
 		r = -EINVAL;
 
 err1:
-	amdgpu_ib_free(&ib, NULL);
 	dma_fence_put(f);
 err0:
 	amdgpu_wb_free(adev, index);
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v7_1.c b/drivers/gpu/drm/amd/amdgpu/sdma_v7_1.c
index 18366e16ef3fa..e5f218f6d1f6a 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v7_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v7_1.c
@@ -969,7 +969,8 @@ static int sdma_v7_1_ring_test_ring(struct amdgpu_ring *ring)
 static int sdma_v7_1_ring_test_ib(struct amdgpu_ring *ring, long timeout)
 {
 	struct amdgpu_device *adev = ring->adev;
-	struct amdgpu_ib ib;
+	struct amdgpu_job *job;
+	struct amdgpu_ib *ib;
 	struct dma_fence *f = NULL;
 	unsigned index;
 	long r;
@@ -977,7 +978,6 @@ static int sdma_v7_1_ring_test_ib(struct amdgpu_ring *ring, long timeout)
 	u64 gpu_addr;
 
 	tmp = 0xCAFEDEAD;
-	memset(&ib, 0, sizeof(ib));
 
 	r = amdgpu_wb_get(adev, &index);
 	if (r) {
@@ -988,26 +988,31 @@ static int sdma_v7_1_ring_test_ib(struct amdgpu_ring *ring, long timeout)
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
@@ -1027,7 +1032,6 @@ static int sdma_v7_1_ring_test_ib(struct amdgpu_ring *ring, long timeout)
 		r = -EINVAL;
 
 err1:
-	amdgpu_ib_free(&ib, NULL);
 	dma_fence_put(f);
 err0:
 	amdgpu_wb_free(adev, index);
diff --git a/drivers/gpu/drm/amd/amdgpu/si_dma.c b/drivers/gpu/drm/amd/amdgpu/si_dma.c
index 47f1d325bd1af..0435de6e71022 100644
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
 	amdgpu_wb_free(adev, index);
-- 
2.55.0

