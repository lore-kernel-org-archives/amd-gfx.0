Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC281C54E65
	for <amd-gfx@archiver.kernel.org>; Thu, 22 May 2025 21:56:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4169210E2B3;
	Thu, 22 May 2025 21:56:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="3lngORxq";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2047.outbound.protection.outlook.com [40.107.237.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8E11A10E703
 for <amd-gfx@lists.freedesktop.org>; Thu, 22 May 2025 21:56:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=W4KhJkSjWTqXvPGHcFtVo3Wkc1v+mur1GYxeel5yBn2QRghpuX5IBkdcM7cRko240vKMQC5YLnoCQPeGOB2ZtC1vV1+2XMToKd9wI2lxRMWzg7cwTPqAbK2rseyyObbACLkJnirObQ+wpZDgEoTXQdytUxfYRyZ/Io9REMar/PL23mzgLm8cUzQj7yJoxJXWYvvniKGXAFMnehCssDjqNpDj8eN1QOJwGLIZyMXOsXkClvI4gu6f2RXk/EWqEd4HjibXH3I2zSPun/J0JVBeC/ex/yWrPkEFZiomDUG1dzS1FocE4uyPaV6ekCKPusMMZn2FGk3tiJcV/qwKC9EKZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XvFGzx9IoZRBpBoGGHLRyil6VQurlXrRnCqEtMhYPjY=;
 b=BukkWrErVSRrGhAOGheB6uUxt6GR6xR/v2gBbpJA73zTjljmPxe5NcEjNB/zkTMK5RL7EORD750XffJjmFA3/i7BdDvdKBVztFDXgBmeD3YMRQlZbXxZ9TbkjuIyf4AwpxuiRwJDiJ90h3TU98gGn3GwD5qdm5aRAyKbIGjPyaPq/daYEyAEeOQFYy/dIhRcBQc+jl6bpqzlS014QyAFCEJU6Bi7/9/KYSD13MCZi8Nz7L1n+eCuJeCaMutiAP6WpRp+NKBN2L+vbL8M2Y6M74wZ0CetfKmxAIfTE7Qr0XATB2QbP0eEX8A9ncLG8DRVd8oKEq71c30keJfcxZ0Qdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XvFGzx9IoZRBpBoGGHLRyil6VQurlXrRnCqEtMhYPjY=;
 b=3lngORxqXsAaW/cscpKAAKJwpDV3fRszHhcmbI03HHQtgRbtzjBVeUlvfABM0/fe2KQUc2bCVIm3Y1EvpioKxCUPZcPrc4LMFsERFZ6ylBTam64BrxAdbuxt+rokJxMoCVzYGVWw3w9NZVpqRGaTXKdMejEFMCDSIoXMbyY01Ro=
Received: from MN0PR02CA0025.namprd02.prod.outlook.com (2603:10b6:208:530::17)
 by CY3PR12MB9629.namprd12.prod.outlook.com (2603:10b6:930:101::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.21; Thu, 22 May
 2025 21:56:17 +0000
Received: from BN3PEPF0000B078.namprd04.prod.outlook.com
 (2603:10b6:208:530:cafe::ab) by MN0PR02CA0025.outlook.office365.com
 (2603:10b6:208:530::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8769.18 via Frontend Transport; Thu,
 22 May 2025 21:56:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B078.mail.protection.outlook.com (10.167.243.123) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8769.18 via Frontend Transport; Thu, 22 May 2025 21:56:17 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 22 May
 2025 16:56:15 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 05/10] drm/amdgpu/gfx11: adjust ring reset sequences
Date: Thu, 22 May 2025 17:55:54 -0400
Message-ID: <20250522215559.14677-6-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250522215559.14677-1-alexander.deucher@amd.com>
References: <20250522215559.14677-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B078:EE_|CY3PR12MB9629:EE_
X-MS-Office365-Filtering-Correlation-Id: afdc82ab-380f-48c8-ba2f-08dd997b7a9d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?KQhySF8eVPFF0b+QJH3e9CoJ0/J5YZzjzzT3vcl0YRkNNN9kV1wmC3YdVTuF?=
 =?us-ascii?Q?5ktnfNvnvrnLIlpFTItKzAFgZsV2LH/ktsnWEbtjSxK8/KVMxnWhCeKC0rse?=
 =?us-ascii?Q?qXLyz1TWrU3zie3wAYW8raeMimT+04DOsh1e2ah9Dkz2gfXSvEOlPA2DPO0P?=
 =?us-ascii?Q?ecc+OMU02bPx3uqgJARY/9dZnCuIKnD6tlmHlthxDTlu3nzjzRswQKuytJsr?=
 =?us-ascii?Q?JykGo/YuXPf9MP5MDLQRQ3yu54wkwoycZRZsF+NEnJdMV+gRuMKYfxRlK098?=
 =?us-ascii?Q?rpsLPUcXbOynRI9m6q5PN6GReaW8s4xC2czc9iot9Rr1y5Ec7pkYQvGEzf1w?=
 =?us-ascii?Q?DS2jziC18GGzhwwN5s2oloKadLndj/gfZchnPwoSTYd4tcleCssKYGafcGv7?=
 =?us-ascii?Q?x4Ws9cOj3shIyorHn14G0E7a24v42gjpI/7Iv3DU/G1UZnR09ZnPPyfLJy1/?=
 =?us-ascii?Q?wr3mtoALmWz0mRhbQdgRJzQeGhAFbOsoWQCZYJoVgOVVw+XvWqoGV3ZACNY2?=
 =?us-ascii?Q?MSgNJxmUBVMex5Dm0figL+mzFM4DVrVwRXbN630CS9yOLL9oYAMLCjOSzzNO?=
 =?us-ascii?Q?J0f3S9qk4zm0XCExSrBUEpGTEGSoZMs7rWbvaExcPDMkVIbKflgRqiIctrEn?=
 =?us-ascii?Q?vt2OxrNs1DYlaSx7ZxtYX2XJ09cX41YNIDufqqhqfXa4rqjivfXk4UO0b96b?=
 =?us-ascii?Q?lIZpVOyuD+0r+OoXOiKIMpG5dsnxLHyq/c2oizm+9Ku5HtwB/rIpWwmGn1bT?=
 =?us-ascii?Q?eI223QZ3yi1vGS99tEhQtwjmlXoQl0zA+1e8TCd5oChT2cRY/FqtLzYin+xs?=
 =?us-ascii?Q?ZMr+3aKhA4m5PHsZXF4tlYP1MjhbDgI6Wl1NJGzL9SZlKzeq5ANRg+Fk21Dt?=
 =?us-ascii?Q?0NpSUpFdj4tUUYI2zWSjF54IaN2npjJH0MONGbH31Q6MJAi/Q6JtndrgE9Z1?=
 =?us-ascii?Q?YSGNi0xf1JWxjITrBEPX0zyoIvMlPHmwGA3tk/hsixeC8m6z8KuvzZI3Uzs6?=
 =?us-ascii?Q?/LRk2i0wIDxiqnGTMg8Ea6aar8aD95wiRcm14FkwwqHjJ7JqG5eSNXFuZD2n?=
 =?us-ascii?Q?/GeG3H1hkFHQG3erwQBPB6odD4ieaLCH9u85FKdItA9m0L1VXiI/z3UCXJRI?=
 =?us-ascii?Q?wPv67M8ewY/JGNrrqtGxYOBH0XIfCvHtOrojBckSv0C2zcUkN0X2sOuI1oAq?=
 =?us-ascii?Q?jQriCYFocmAoR+5drSSFLsM8RyTSI8LFVdoTQoUF71BPv3u1QGLDij2029FN?=
 =?us-ascii?Q?H0Or6RU88THdb2fNfUY+mDpi9zVbpLhyJ2Nbf4MTAPcBr0HBWSqs4jpCX9uy?=
 =?us-ascii?Q?nXbFlFJD3ZW5pI917s2cGNMGjKMp03OWz6AQ0kkZQRuPlGA2gj9LKsYT0nH9?=
 =?us-ascii?Q?St91O+4dr9f7dvt9edXBF4Pq9qwr2q2rH/OWQY76kh810V4jFBsVVyypvM+d?=
 =?us-ascii?Q?uzjKxy4YLO5TgowI9sR0M7tMmDv5uXDSruFjfyMbTEYD7O2z12uJCAUAPbV7?=
 =?us-ascii?Q?rR0TI3zqL7B0gDZc2O/7tpyfKWDAqavnO+zu?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2025 21:56:17.3247 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: afdc82ab-380f-48c8-ba2f-08dd997b7a9d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B078.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY3PR12MB9629
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

Don't clear the ring contents after we issue
a VM reset just write the trailing fence.  GFX
block will reset the work associated with the
vmid and and then continue from where it left off.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c | 18 ++++++++++--------
 drivers/gpu/drm/amd/amdgpu/nvd.h       |  1 +
 2 files changed, 11 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
index afd6d59164bfa..5d57dba08717c 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -5903,6 +5903,7 @@ static void gfx_v11_0_ring_emit_fence(struct amdgpu_ring *ring, u64 addr,
 {
 	bool write64bit = flags & AMDGPU_FENCE_FLAG_64BIT;
 	bool int_sel = flags & AMDGPU_FENCE_FLAG_INT;
+	bool exec = flags & AMDGPU_FENCE_FLAG_EXEC;
 
 	/* RELEASE_MEM - flush caches, send int */
 	amdgpu_ring_write(ring, PACKET3(PACKET3_RELEASE_MEM, 6));
@@ -5912,7 +5913,8 @@ static void gfx_v11_0_ring_emit_fence(struct amdgpu_ring *ring, u64 addr,
 				 PACKET3_RELEASE_MEM_GCR_GLM_WB |
 				 PACKET3_RELEASE_MEM_CACHE_POLICY(3) |
 				 PACKET3_RELEASE_MEM_EVENT_TYPE(CACHE_FLUSH_AND_INV_TS_EVENT) |
-				 PACKET3_RELEASE_MEM_EVENT_INDEX(5)));
+				 PACKET3_RELEASE_MEM_EVENT_INDEX(5) |
+				 (exec ? PACKET3_RELEASE_MEM_EXECUTE_GFX11 : 0)));
 	amdgpu_ring_write(ring, (PACKET3_RELEASE_MEM_DATA_SEL(write64bit ? 2 : 1) |
 				 PACKET3_RELEASE_MEM_INT_SEL(int_sel ? 2 : 0)));
 
@@ -6823,19 +6825,19 @@ static int gfx_v11_0_reset_kgq(struct amdgpu_ring *ring, unsigned int vmid)
 			return r;
 	}
 
-	r = gfx_v11_0_kgq_init_queue(ring, true);
-	if (r) {
-		dev_err(adev->dev, "failed to init kgq\n");
-		return r;
-	}
-
 	r = amdgpu_mes_map_legacy_queue(adev, ring);
 	if (r) {
 		dev_err(adev->dev, "failed to remap kgq\n");
 		return r;
 	}
 
-	return amdgpu_ring_test_ring(ring);
+	if (amdgpu_ring_alloc(ring, 8))
+		return -ENOMEM;
+	amdgpu_ring_emit_fence(ring, ring->fence_drv.gpu_addr,
+			       ring->fence_drv.sync_seq, AMDGPU_FENCE_FLAG_EXEC);
+	amdgpu_ring_commit(ring);
+
+	return gfx_v11_0_ring_test_ib(ring, AMDGPU_QUEUE_RESET_TIMEOUT);
 }
 
 static int gfx_v11_0_reset_compute_pipe(struct amdgpu_ring *ring)
diff --git a/drivers/gpu/drm/amd/amdgpu/nvd.h b/drivers/gpu/drm/amd/amdgpu/nvd.h
index 56f1bfac0b208..f0c3e3a870541 100644
--- a/drivers/gpu/drm/amd/amdgpu/nvd.h
+++ b/drivers/gpu/drm/amd/amdgpu/nvd.h
@@ -371,6 +371,7 @@
 		 * 3 - cache_policy__me_release_mem__bypass
 		 */
 #define		PACKET3_RELEASE_MEM_EXECUTE		(1 << 28)
+#define		PACKET3_RELEASE_MEM_EXECUTE_GFX11	(3 << 28)
 
 #define		PACKET3_RELEASE_MEM_DATA_SEL(x)		((x) << 29)
 		/* 0 - discard
-- 
2.49.0

