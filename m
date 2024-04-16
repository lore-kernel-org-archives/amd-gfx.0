Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E05D2C4345F
	for <amd-gfx@archiver.kernel.org>; Tue, 16 Apr 2024 08:52:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 420D0112B00;
	Tue, 16 Apr 2024 08:52:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="RDOHcPV6";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2071.outbound.protection.outlook.com [40.107.220.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A86B8112B00
 for <amd-gfx@lists.freedesktop.org>; Tue, 16 Apr 2024 08:52:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gRP7gQ2eLG23CpIGZ0fy//m4W6vWfwGAp363sSRmf4WPKh1v+JRdN13EmfAccnEhCVHxkNWXPlrL4e+tVbwoAp6UC08KH5l/dGLMI9P6JnUke/WrF3Z7dopNi3jbQ5e/se7h50J1RX783B9D0osiCsejAvsurIYeRp8TjQT1lEqdTLseDzpJIJqqTi0Hg9MzGBf5oi/nd14bkOuOFtCG59zEwT5u0vHJKZluUrSAiwMg+qlVm/gcsToE3kHM25ZRqWS+06btizhAnMRBQQUcVhT3qSSO4n0CRW/KaREltJmSnElOTdUC5MYTi3OE/A3mYGa0UDHyMSKLvRnyofV3AQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N02hs8rEXxKPVs4dJnx15KhdAkGL/DbzHm5/9IZpBd0=;
 b=A3J5yeImDMfpZNwPtgAzRfs31OiZSwNsVmMwDpuRuwaV9BdqzuYQwpfm9weLNZkcI7K1GZb5XHwBi9KWu6gMfNLLE/EPqAHmw/o4aBFRVN9hoC7toft2kCTyO59YphFkZW6BCWnqf6G71SdA8E/rt5vcXtYlYEoOTxXnJbpzUFhG0b4ZyjamGjv5dnrSnVosxuQvHlzefH9bStBBAvgjEWth6bo0rEZPov2ybF0PjWYTTIRvZZsXVQx2bgzh3Xvf6P3Ga/RBMeCHu0Paxs3V25NdlbpYUYv5z2AHzcJhFVfeOR8zmIQpUzYpRpZDzBH/HqUTnRRrOfNoWCNPlzB7TQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N02hs8rEXxKPVs4dJnx15KhdAkGL/DbzHm5/9IZpBd0=;
 b=RDOHcPV6ynraNlvR8EOFnCz3U75Kzz5A1zF5ZvWH0wBOf2npB8fNMi4SvdszYiNkk/mYMuc/5MV/gKVR8u42knNAiFsysxD7U3/Adi7GYu6RmnULm/BIdGYRVLFzWGMZjgzysZiC0/X/jX5wabZIhtFpdtguO3fPDkWA7mpO4qM=
Received: from CH0PR03CA0425.namprd03.prod.outlook.com (2603:10b6:610:10e::27)
 by MN0PR12MB6365.namprd12.prod.outlook.com (2603:10b6:208:3c2::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.50; Tue, 16 Apr
 2024 08:52:05 +0000
Received: from CH2PEPF0000013E.namprd02.prod.outlook.com
 (2603:10b6:610:10e:cafe::57) by CH0PR03CA0425.outlook.office365.com
 (2603:10b6:610:10e::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.34 via Frontend
 Transport; Tue, 16 Apr 2024 08:52:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH2PEPF0000013E.mail.protection.outlook.com (10.167.244.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7452.22 via Frontend Transport; Tue, 16 Apr 2024 08:52:05 +0000
Received: from prike-code-pc.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 16 Apr
 2024 03:52:03 -0500
From: Prike Liang <Prike.Liang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Prike Liang <Prike.Liang@amd.com>
Subject: [PATCH 3/3] drm/amdgpu: add the amdgpu buffer object move speed
 metrics
Date: Tue, 16 Apr 2024 16:51:50 +0800
Message-ID: <20240416085150.2459820-3-Prike.Liang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240416085150.2459820-1-Prike.Liang@amd.com>
References: <20240416085150.2459820-1-Prike.Liang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000013E:EE_|MN0PR12MB6365:EE_
X-MS-Office365-Filtering-Correlation-Id: 84b759be-9b25-4b44-8a80-08dc5df27db4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WtwxVn6rCOAkc1VxdZG2DhwQo6wrKFhozBOpME4K6bDFTXDbvzi2U4ZSsgg5x3NWcjqI2NVlPNYX/q7mmfK/dXHOCtQvpBeanRJZydYtmRWYSC0n5mjLZ9+3tycyRICcEHAe9q9ccuGLP4t6uJvXSyAis0E41ctVX/BWRg26hPX16Hej170lCdIg2TgOhflEjYyuwjv5sFar3IRPAKxWMi2a2F0hqhXWsVebAqE55EmYGbpHzqVLC4B6F63Cz5rqqJDodliA6/ExgdSi0ZbTS4EIhFAqzYAEfqtF7r5pL81dS5jpb89mZR6yUa6fmJfR2oUJL0QV57EArywCBCCerE9JzqmQsT79vl/OGLC2hXkks4fLuFeuPeL74HbmVT5DQapYv+4fuAzF9MBESv++8k0hRfJ107wUk2+SiUoXisYosfykMvr16XfKV/Xxiy1cCqxjlmk8G4IsMi8jVO/Zi7c6iNo8NXcYRvMGCu1VNoFST39qHn2dHhBXtdR6oBDUC8RJ+lnMGpDtS+LptBTMRV8q25KGp0VgZaZEUWdErhWp6KQK242W00LcpufJkuiE4zdMed80Dw/3HV+xsk+E1aox9zzWFIC/ST6esmeLRhJK9kRhzukTjV99GDDE1MP6IuqjR7Hms9LkU4TPhi2bdQkFI95zRS5Io5P/FAzqDTbrXcUjBewZ8GBVAtXAiiBrg4vkppdHugwkiHH5ewsxqMg45x62NMqA1vOFQzW1UBFCyAc8/Kj2FMVxsGpgxrqt
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(1800799015)(376005)(82310400014)(36860700004); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2024 08:52:05.1751 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 84b759be-9b25-4b44-8a80-08dc5df27db4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF0000013E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6365
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

Add the amdgpu buffer object move speed metrics.

Signed-off-by: Prike Liang <Prike.Liang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h           |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_benchmark.c | 78 ++++++++++++++-----
 drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c   |  2 +-
 3 files changed, 61 insertions(+), 21 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index 163d221b3bbd..2840f1536b51 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -502,7 +502,7 @@ void amdgpu_device_wb_free(struct amdgpu_device *adev, u32 wb);
 /*
  * Benchmarking
  */
-int amdgpu_benchmark(struct amdgpu_device *adev, int test_number);
+int amdgpu_benchmark(struct amdgpu_device *adev, int test_number, struct seq_file *m);
 
 int amdgpu_benchmark_dump(struct amdgpu_device *adev, struct seq_file *m);
 /*
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_benchmark.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_benchmark.c
index f6848b574dea..fcd186ca088a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_benchmark.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_benchmark.c
@@ -65,20 +65,27 @@ static void amdgpu_benchmark_log_results(struct amdgpu_device *adev,
 					 int n, unsigned size,
 					 s64 time_ms,
 					 unsigned sdomain, unsigned ddomain,
-					 char *kind)
+					 char *kind, struct seq_file *m)
 {
 	s64 throughput = (n * (size >> 10));
 
 	throughput = div64_s64(throughput, time_ms);
 
-	dev_info(adev->dev, "amdgpu: %s %u bo moves of %u kB from"
-		 " %d to %d in %lld ms, throughput: %lld Mb/s or %lld MB/s\n",
-		 kind, n, size >> 10, sdomain, ddomain, time_ms,
-		 throughput * 8, throughput);
+	if (m) {
+		seq_printf(m, "\tamdgpu: %s %u bo moves of %u kB from"
+			 " %d to %d in %lld ms, throughput: %lld Mb/s or %lld MB/s\n",
+			kind, n, size >> 10, sdomain, ddomain, time_ms,
+			throughput * 8, throughput);
+	} else {
+		dev_info(adev->dev, "amdgpu: %s %u bo moves of %u kB from"
+			 " %d to %d in %lld ms, throughput: %lld Mb/s or %lld MB/s\n",
+			kind, n, size >> 10, sdomain, ddomain, time_ms,
+			throughput * 8, throughput);
+	}
 }
 
 static int amdgpu_benchmark_move(struct amdgpu_device *adev, unsigned size,
-				 unsigned sdomain, unsigned ddomain)
+				 unsigned sdomain, unsigned ddomain, struct seq_file *m)
 {
 	struct amdgpu_bo *dobj = NULL;
 	struct amdgpu_bo *sobj = NULL;
@@ -109,7 +116,7 @@ static int amdgpu_benchmark_move(struct amdgpu_device *adev, unsigned size,
 			goto out_cleanup;
 		else
 			amdgpu_benchmark_log_results(adev, n, size, time_ms,
-						     sdomain, ddomain, "dma");
+						     sdomain, ddomain, "dma", m);
 	}
 
 out_cleanup:
@@ -124,7 +131,7 @@ static int amdgpu_benchmark_move(struct amdgpu_device *adev, unsigned size,
 	return r;
 }
 
-int amdgpu_benchmark(struct amdgpu_device *adev, int test_number)
+int amdgpu_benchmark(struct amdgpu_device *adev, int test_number, struct seq_file *m)
 {
 	int i, r;
 	static const int common_modes[AMDGPU_BENCHMARK_COMMON_MODES_N] = {
@@ -153,13 +160,16 @@ int amdgpu_benchmark(struct amdgpu_device *adev, int test_number)
 		dev_info(adev->dev,
 			 "benchmark test: %d (simple test, VRAM to GTT and GTT to VRAM)\n",
 			 test_number);
+		if (m)
+			seq_printf(m, "\tbenchmark test: %d (simple test, VRAM to GTT and GTT to VRAM)\n",
+			 test_number);
 		/* simple test, VRAM to GTT and GTT to VRAM */
 		r = amdgpu_benchmark_move(adev, 1024*1024, AMDGPU_GEM_DOMAIN_GTT,
-					  AMDGPU_GEM_DOMAIN_VRAM);
+					  AMDGPU_GEM_DOMAIN_VRAM, m);
 		if (r)
 			goto done;
 		r = amdgpu_benchmark_move(adev, 1024*1024, AMDGPU_GEM_DOMAIN_VRAM,
-					  AMDGPU_GEM_DOMAIN_GTT);
+					  AMDGPU_GEM_DOMAIN_GTT, m);
 		if (r)
 			goto done;
 		break;
@@ -167,9 +177,13 @@ int amdgpu_benchmark(struct amdgpu_device *adev, int test_number)
 		dev_info(adev->dev,
 			 "benchmark test: %d (simple test, VRAM to VRAM)\n",
 			 test_number);
+		if (m)
+			seq_printf(m, "\tbenchmark test: %d (simple test, VRAM to VRAM)\n",
+			 test_number);
+
 		/* simple test, VRAM to VRAM */
 		r = amdgpu_benchmark_move(adev, 1024*1024, AMDGPU_GEM_DOMAIN_VRAM,
-					  AMDGPU_GEM_DOMAIN_VRAM);
+					  AMDGPU_GEM_DOMAIN_VRAM, m);
 		if (r)
 			goto done;
 		break;
@@ -177,11 +191,15 @@ int amdgpu_benchmark(struct amdgpu_device *adev, int test_number)
 		dev_info(adev->dev,
 			 "benchmark test: %d (GTT to VRAM, buffer size sweep, powers of 2)\n",
 			 test_number);
+		if (m)
+			seq_printf(m, "\tbenchmark test: %d (GTT to VRAM, buffer size sweep, powers of 2)\n",
+				test_number);
+
 		/* GTT to VRAM, buffer size sweep, powers of 2 */
 		for (i = 1; i <= 16384; i <<= 1) {
 			r = amdgpu_benchmark_move(adev, i * AMDGPU_GPU_PAGE_SIZE,
 						  AMDGPU_GEM_DOMAIN_GTT,
-						  AMDGPU_GEM_DOMAIN_VRAM);
+						  AMDGPU_GEM_DOMAIN_VRAM, m);
 			if (r)
 				goto done;
 		}
@@ -190,11 +208,14 @@ int amdgpu_benchmark(struct amdgpu_device *adev, int test_number)
 		dev_info(adev->dev,
 			 "benchmark test: %d (VRAM to GTT, buffer size sweep, powers of 2)\n",
 			 test_number);
+		if (m)
+			seq_printf(m,"\tbenchmark test: %d (VRAM to GTT, buffer size sweep, powers of 2)\n",
+				test_number);
 		/* VRAM to GTT, buffer size sweep, powers of 2 */
 		for (i = 1; i <= 16384; i <<= 1) {
 			r = amdgpu_benchmark_move(adev, i * AMDGPU_GPU_PAGE_SIZE,
 						  AMDGPU_GEM_DOMAIN_VRAM,
-						  AMDGPU_GEM_DOMAIN_GTT);
+						  AMDGPU_GEM_DOMAIN_GTT, m);
 			if (r)
 				goto done;
 		}
@@ -203,11 +224,14 @@ int amdgpu_benchmark(struct amdgpu_device *adev, int test_number)
 		dev_info(adev->dev,
 			 "benchmark test: %d (VRAM to VRAM, buffer size sweep, powers of 2)\n",
 			 test_number);
+		if (m)
+			seq_printf(m, "\tbenchmark test: %d (VRAM to VRAM, buffer size sweep, powers of 2)\n",
+				 test_number);
 		/* VRAM to VRAM, buffer size sweep, powers of 2 */
 		for (i = 1; i <= 16384; i <<= 1) {
 			r = amdgpu_benchmark_move(adev, i * AMDGPU_GPU_PAGE_SIZE,
 						  AMDGPU_GEM_DOMAIN_VRAM,
-						  AMDGPU_GEM_DOMAIN_VRAM);
+						  AMDGPU_GEM_DOMAIN_VRAM, m);
 			if (r)
 				goto done;
 		}
@@ -216,11 +240,14 @@ int amdgpu_benchmark(struct amdgpu_device *adev, int test_number)
 		dev_info(adev->dev,
 			 "benchmark test: %d (GTT to VRAM, buffer size sweep, common modes)\n",
 			 test_number);
+		if (m)
+			seq_printf(m,"\tbenchmark test: %d (GTT to VRAM, buffer size sweep, common modes)\n",
+				test_number);
 		/* GTT to VRAM, buffer size sweep, common modes */
 		for (i = 0; i < AMDGPU_BENCHMARK_COMMON_MODES_N; i++) {
 			r = amdgpu_benchmark_move(adev, common_modes[i],
 						  AMDGPU_GEM_DOMAIN_GTT,
-						  AMDGPU_GEM_DOMAIN_VRAM);
+						  AMDGPU_GEM_DOMAIN_VRAM, m);
 			if (r)
 				goto done;
 		}
@@ -229,11 +256,14 @@ int amdgpu_benchmark(struct amdgpu_device *adev, int test_number)
 		dev_info(adev->dev,
 			 "benchmark test: %d (VRAM to GTT, buffer size sweep, common modes)\n",
 			 test_number);
+		if (m)
+			seq_printf(m,"\tbenchmark test: %d (VRAM to GTT, buffer size sweep, common modes)\n",
+				test_number);
 		/* VRAM to GTT, buffer size sweep, common modes */
 		for (i = 0; i < AMDGPU_BENCHMARK_COMMON_MODES_N; i++) {
 			r = amdgpu_benchmark_move(adev, common_modes[i],
 						  AMDGPU_GEM_DOMAIN_VRAM,
-						  AMDGPU_GEM_DOMAIN_GTT);
+						  AMDGPU_GEM_DOMAIN_GTT, m);
 			if (r)
 				goto done;
 		}
@@ -241,12 +271,15 @@ int amdgpu_benchmark(struct amdgpu_device *adev, int test_number)
 	case 8:
 		dev_info(adev->dev,
 			 "benchmark test: %d (VRAM to VRAM, buffer size sweep, common modes)\n",
-			 test_number);
+			test_number);
+		if (m)
+			seq_printf(m,"\tbenchmark test: %d (VRAM to VRAM, buffer size sweep, common modes)\n",
+				test_number);
 		/* VRAM to VRAM, buffer size sweep, common modes */
 		for (i = 0; i < AMDGPU_BENCHMARK_COMMON_MODES_N; i++) {
 			r = amdgpu_benchmark_move(adev, common_modes[i],
 					      AMDGPU_GEM_DOMAIN_VRAM,
-					      AMDGPU_GEM_DOMAIN_VRAM);
+					      AMDGPU_GEM_DOMAIN_VRAM, m);
 			if (r)
 				goto done;
 		}
@@ -449,7 +482,7 @@ static void amdgpu_benchmark_mem_metrics_dump(struct amdgpu_device *adev, struct
 			&adev->mman.gtt_mgr.manager;
 	struct ttm_resource_manager *vram_man =
 			&adev->mman.vram_mgr.manager;
-	uint32_t l1_cache_size;
+	uint32_t l1_cache_size, j;
 
 	seq_puts(m, "amdgpu benchmark mem metrics dump:\n");
 
@@ -483,6 +516,13 @@ static void amdgpu_benchmark_mem_metrics_dump(struct amdgpu_device *adev, struct
 			atomic64_read(&adev->gart_pin_size));
 	seq_printf(m, "\tGTT heap usage size:%lld KB\n", ttm_resource_manager_usage(gtt_man));
 
+	seq_printf(m, "\t--------amdgpu buffer object move speed test begin--------\n");
+	for (j = 1; j < 8; j++) {
+		/*TODO: Add the cases of gfx and CPU move cases.*/
+		amdgpu_benchmark(adev, j, m);
+	}
+	seq_printf(m, "\t--------amdgpu buffer object move speed test end--------\n");
+
 	seq_printf(m, "\n");
 
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
index 7e935b9736c1..4d710c5f8465 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
@@ -1760,7 +1760,7 @@ static int amdgpu_debugfs_benchmark(void *data, u64 val)
 		return r;
 	}
 
-	r = amdgpu_benchmark(adev, val);
+	r = amdgpu_benchmark(adev, val, NULL);
 
 	pm_runtime_mark_last_busy(dev->dev);
 	pm_runtime_put_autosuspend(dev->dev);
-- 
2.34.1

