Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64DCEC433F5
	for <amd-gfx@archiver.kernel.org>; Fri, 18 Feb 2022 22:26:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AF2E610EDD7;
	Fri, 18 Feb 2022 22:26:21 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2044.outbound.protection.outlook.com [40.107.236.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C05D710EDD7
 for <amd-gfx@lists.freedesktop.org>; Fri, 18 Feb 2022 22:26:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XF0fZeNHNssk8e+0Bb78sFup5h9q7Mv16voG2LpEfksaHsJZAAPZPfNR/dVpgxfPdX6awJUFfLWaXGAn5cFeF5jMscf1t6gABVsq74LenT8XtyL01TCrN9hX+VWxS00B1kNkzBoeHsnS33xPOY3YvCaXCpHZQ7FJTaXCCzSNbUVT4F5o6k0iRV8XECeuQgdm0weDdVFcZjdoErMsb+QnkufdKM9wo52yPpTG00e8UU4X92KgSWRlF0J2cdc37nqQglUiXf3DV83LN5VdEvNTKXC2qmgx4p2S5gm7pdksUN0be6fPbdN8n437FQjzAnFZIfhNOD4ILc4xwzmwemH4Og==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YbU37qmO7cIzf0xWl/ksSU3lKL6jpTz4XMzPLWDbOAU=;
 b=IC0m//iyq52WRGWxZZhrkFlXqqGySNS8MbIqE2ApvMUXCARBVEqy6aU2g/XUwxwOc04P7XqhyHp5//NURxgPFi1JiJfIcKzvWlwGrcgLrsS1Xrc1K1drGXT3wvtbdP7vAI3be1N2X03MbhkdyQtx5bjY+53Wip4es8NJH4ZNdogrSn7hVFR7FCJeSxgrogD93OECUnlNLb9TCgMU6/OgvbNBS1rUhgt/vOxPHvkew7YQw7pRVIC6g71cghcgclt6I/26JWKMAaTLpQH8kOQlgu+FU6mP56RDShFeqQl957a7GK3rVHDkgpbG3ivy7Yjjs6Gh5Q2ecbYdEGNR7xLFwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YbU37qmO7cIzf0xWl/ksSU3lKL6jpTz4XMzPLWDbOAU=;
 b=a9Py4uANAJIRDXTMAd7xWtu0VmXs44z5RHJ8Do5kuJokJeVoRI7QX6aSCl/S+LU/8syG9maJjfOxOaqR86g94yO3tPctCedyP+F+xy2O+RNb7mVkaBbCwTnCfmz3Vb0disv1IAGiBt9FPx5g+3V/mGeBb0goP2v5eRna4LDP9IE=
Received: from MWHPR20CA0005.namprd20.prod.outlook.com (2603:10b6:300:13d::15)
 by BY5PR12MB3730.namprd12.prod.outlook.com (2603:10b6:a03:1ac::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.16; Fri, 18 Feb
 2022 22:26:17 +0000
Received: from CO1NAM11FT036.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:13d:cafe::ba) by MWHPR20CA0005.outlook.office365.com
 (2603:10b6:300:13d::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.17 via Frontend
 Transport; Fri, 18 Feb 2022 22:26:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT036.mail.protection.outlook.com (10.13.174.124) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4995.15 via Frontend Transport; Fri, 18 Feb 2022 22:26:16 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Fri, 18 Feb
 2022 16:26:15 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 2/7] drm/amdgpu: plumb error handling though amdgpu_benchmark()
Date: Fri, 18 Feb 2022 17:25:58 -0500
Message-ID: <20220218222603.25470-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220218222603.25470-1-alexander.deucher@amd.com>
References: <20220218222603.25470-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 793fb125-6ce9-443d-6541-08d9f32dadf9
X-MS-TrafficTypeDiagnostic: BY5PR12MB3730:EE_
X-Microsoft-Antispam-PRVS: <BY5PR12MB37301FF80BD1BA9E36EF2C3BF7379@BY5PR12MB3730.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3968;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Swj6NMVamLkix7Vb/IOcfiTcsoO0lNoCXMHvC4Vrgv8wLgL7/CAgz9bfNAnbS4RxhyB6zo5/LyO2WjZVRHRx4IVskV/fRCZnnRBbwsQBPat55KjWFfyoUDDsCxt5NavIX4EAmOppji4krqy4AD6sOStaqWgYY8twBBxWwzHIb3pnzWyonW4AYDZi6eynX1Y+Gb2UhwztNLjANVilp0phPsQ3ae3v4KiY0InbC7NF3CSTrhy3vt7qTI0xGUieefPlgF71PYsgQ2Us1/qkkk0WO44N5sO93qcLuJ5VvqP+99GFHiRh4ithE3H4bdrPCBFv/aOAjNnKKhFXWSOeTOjqsXXXUFyOYsTZvwC4P4vY14Bv7FyMglGdW6sLXI41v19sRhVwf0IfU9rFzmXKQ0tf09QP0VyL4Rtg0UZM8jBPljtTUbaYaAn/ivLhBjQWL/z5YHoJSDkZUB4YnystLnR0y6oBAdjGQOnAGtOeJJsgVOV102aF65uCye7Rp0wMOOrb4KZAD0khbP6p/I4N3OKYfV4JdZoJsZ4Ggdu7vxrzklISO116VYUhjS0KDBDiJ1xd7BcFEZit+FKwd8ayMbGOPn1aEAFqfmWuEgfV8nIrxo9ncUTOR/kV97zpFZclY22PsbERVq3k8+jM7Grni6/3OoPS2PkFLXEsECdTeHzNE1xbnG7FT6gFkcxlNP25SmuDT4QOIUzTCGFIRTp5mw90Zg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(46966006)(36840700001)(40470700004)(2906002)(6666004)(36756003)(7696005)(5660300002)(40460700003)(8936002)(2616005)(81166007)(356005)(16526019)(70206006)(70586007)(47076005)(8676002)(4326008)(1076003)(82310400004)(36860700001)(26005)(186003)(316002)(83380400001)(426003)(336012)(508600001)(6916009)(86362001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2022 22:26:16.5797 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 793fb125-6ce9-443d-6541-08d9f32dadf9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT036.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB3730
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
Cc: Alex Deucher <alexander.deucher@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

So we can tell when this function fails.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h           |   2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_benchmark.c | 100 +++++++++++-------
 2 files changed, 64 insertions(+), 38 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index 566303c9942f..66d556fc17ef 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -586,7 +586,7 @@ void amdgpu_device_wb_free(struct amdgpu_device *adev, u32 wb);
 /*
  * Benchmarking
  */
-void amdgpu_benchmark(struct amdgpu_device *adev, int test_number);
+int amdgpu_benchmark(struct amdgpu_device *adev, int test_number);
 
 
 /*
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_benchmark.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_benchmark.c
index b38783278a99..7709f48e25a1 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_benchmark.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_benchmark.c
@@ -70,15 +70,14 @@ static void amdgpu_benchmark_log_results(struct amdgpu_device *adev,
 		 throughput * 8, throughput);
 }
 
-static void amdgpu_benchmark_move(struct amdgpu_device *adev, unsigned size,
-				  unsigned sdomain, unsigned ddomain)
+static int amdgpu_benchmark_move(struct amdgpu_device *adev, unsigned size,
+				 unsigned sdomain, unsigned ddomain)
 {
 	struct amdgpu_bo *dobj = NULL;
 	struct amdgpu_bo *sobj = NULL;
 	struct amdgpu_bo_param bp;
 	uint64_t saddr, daddr;
 	int r, n;
-	int time;
 
 	memset(&bp, 0, sizeof(bp));
 	bp.size = size;
@@ -129,19 +128,18 @@ static void amdgpu_benchmark_move(struct amdgpu_device *adev, unsigned size,
 	daddr = amdgpu_bo_gpu_offset(dobj);
 
 	if (adev->mman.buffer_funcs) {
-		time = amdgpu_benchmark_do_move(adev, size, saddr, daddr, n);
-		if (time < 0)
+		r = amdgpu_benchmark_do_move(adev, size, saddr, daddr, n);
+		if (r < 0)
 			goto out_cleanup;
-		if (time > 0)
-			amdgpu_benchmark_log_results(adev, n, size, time,
+		if (r > 0)
+			amdgpu_benchmark_log_results(adev, n, size, r,
 						     sdomain, ddomain, "dma");
 	}
 
 out_cleanup:
 	/* Check error value now. The value can be overwritten when clean up.*/
-	if (r) {
+	if (r < 0)
 		dev_info(adev->dev, "Error while benchmarking BO move.\n");
-	}
 
 	if (sobj) {
 		r = amdgpu_bo_reserve(sobj, true);
@@ -159,11 +157,12 @@ static void amdgpu_benchmark_move(struct amdgpu_device *adev, unsigned size,
 		}
 		amdgpu_bo_unref(&dobj);
 	}
+	return r;
 }
 
-void amdgpu_benchmark(struct amdgpu_device *adev, int test_number)
+int amdgpu_benchmark(struct amdgpu_device *adev, int test_number)
 {
-	int i;
+	int i, r;
 	static const int common_modes[AMDGPU_BENCHMARK_COMMON_MODES_N] = {
 		640 * 480 * 4,
 		720 * 480 * 4,
@@ -187,60 +186,87 @@ void amdgpu_benchmark(struct amdgpu_device *adev, int test_number)
 	switch (test_number) {
 	case 1:
 		/* simple test, VRAM to GTT and GTT to VRAM */
-		amdgpu_benchmark_move(adev, 1024*1024, AMDGPU_GEM_DOMAIN_GTT,
-				      AMDGPU_GEM_DOMAIN_VRAM);
-		amdgpu_benchmark_move(adev, 1024*1024, AMDGPU_GEM_DOMAIN_VRAM,
-				      AMDGPU_GEM_DOMAIN_GTT);
+		r = amdgpu_benchmark_move(adev, 1024*1024, AMDGPU_GEM_DOMAIN_GTT,
+					  AMDGPU_GEM_DOMAIN_VRAM);
+		if (r)
+			return r;
+		r = amdgpu_benchmark_move(adev, 1024*1024, AMDGPU_GEM_DOMAIN_VRAM,
+					  AMDGPU_GEM_DOMAIN_GTT);
+		if (r)
+			return r;
 		break;
 	case 2:
 		/* simple test, VRAM to VRAM */
 		amdgpu_benchmark_move(adev, 1024*1024, AMDGPU_GEM_DOMAIN_VRAM,
 				      AMDGPU_GEM_DOMAIN_VRAM);
+		if (r)
+			return r;
 		break;
 	case 3:
 		/* GTT to VRAM, buffer size sweep, powers of 2 */
-		for (i = 1; i <= 16384; i <<= 1)
-			amdgpu_benchmark_move(adev, i * AMDGPU_GPU_PAGE_SIZE,
-					      AMDGPU_GEM_DOMAIN_GTT,
-					      AMDGPU_GEM_DOMAIN_VRAM);
+		for (i = 1; i <= 16384; i <<= 1) {
+			r = amdgpu_benchmark_move(adev, i * AMDGPU_GPU_PAGE_SIZE,
+						  AMDGPU_GEM_DOMAIN_GTT,
+						  AMDGPU_GEM_DOMAIN_VRAM);
+			if (r)
+				return r;
+		}
 		break;
 	case 4:
 		/* VRAM to GTT, buffer size sweep, powers of 2 */
-		for (i = 1; i <= 16384; i <<= 1)
-			amdgpu_benchmark_move(adev, i * AMDGPU_GPU_PAGE_SIZE,
-					      AMDGPU_GEM_DOMAIN_VRAM,
-					      AMDGPU_GEM_DOMAIN_GTT);
+		for (i = 1; i <= 16384; i <<= 1) {
+			r = amdgpu_benchmark_move(adev, i * AMDGPU_GPU_PAGE_SIZE,
+						  AMDGPU_GEM_DOMAIN_VRAM,
+						  AMDGPU_GEM_DOMAIN_GTT);
+			if (r)
+				return r;
+		}
 		break;
 	case 5:
 		/* VRAM to VRAM, buffer size sweep, powers of 2 */
-		for (i = 1; i <= 16384; i <<= 1)
-			amdgpu_benchmark_move(adev, i * AMDGPU_GPU_PAGE_SIZE,
-					      AMDGPU_GEM_DOMAIN_VRAM,
-					      AMDGPU_GEM_DOMAIN_VRAM);
+		for (i = 1; i <= 16384; i <<= 1) {
+			r = amdgpu_benchmark_move(adev, i * AMDGPU_GPU_PAGE_SIZE,
+						  AMDGPU_GEM_DOMAIN_VRAM,
+						  AMDGPU_GEM_DOMAIN_VRAM);
+			if (r)
+				return r;
+		}
 		break;
 	case 6:
 		/* GTT to VRAM, buffer size sweep, common modes */
-		for (i = 0; i < AMDGPU_BENCHMARK_COMMON_MODES_N; i++)
-			amdgpu_benchmark_move(adev, common_modes[i],
-					      AMDGPU_GEM_DOMAIN_GTT,
-					      AMDGPU_GEM_DOMAIN_VRAM);
+		for (i = 0; i < AMDGPU_BENCHMARK_COMMON_MODES_N; i++) {
+			r = amdgpu_benchmark_move(adev, common_modes[i],
+						  AMDGPU_GEM_DOMAIN_GTT,
+						  AMDGPU_GEM_DOMAIN_VRAM);
+			if (r)
+				return r;
+		}
 		break;
 	case 7:
 		/* VRAM to GTT, buffer size sweep, common modes */
-		for (i = 0; i < AMDGPU_BENCHMARK_COMMON_MODES_N; i++)
-			amdgpu_benchmark_move(adev, common_modes[i],
-					      AMDGPU_GEM_DOMAIN_VRAM,
-					      AMDGPU_GEM_DOMAIN_GTT);
+		for (i = 0; i < AMDGPU_BENCHMARK_COMMON_MODES_N; i++) {
+			r = amdgpu_benchmark_move(adev, common_modes[i],
+						  AMDGPU_GEM_DOMAIN_VRAM,
+						  AMDGPU_GEM_DOMAIN_GTT);
+			if (r)
+				return r;
+		}
 		break;
 	case 8:
 		/* VRAM to VRAM, buffer size sweep, common modes */
-		for (i = 0; i < AMDGPU_BENCHMARK_COMMON_MODES_N; i++)
-			amdgpu_benchmark_move(adev, common_modes[i],
+		for (i = 0; i < AMDGPU_BENCHMARK_COMMON_MODES_N; i++) {
+			r = amdgpu_benchmark_move(adev, common_modes[i],
 					      AMDGPU_GEM_DOMAIN_VRAM,
 					      AMDGPU_GEM_DOMAIN_VRAM);
+			if (r)
+				return r;
+		}
 		break;
 
 	default:
 		dev_info(adev->dev, "Unknown benchmark\n");
+		r = -EINVAL;
+		break;
 	}
+	return r;
 }
-- 
2.35.1

