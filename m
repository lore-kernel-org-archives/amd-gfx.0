Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2333AC43602
	for <amd-gfx@archiver.kernel.org>; Tue,  7 Jul 2026 15:42:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BB69010EE1F;
	Tue,  7 Jul 2026 15:42:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="HtM0OVUG";
	dkim-atps=neutral
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010037.outbound.protection.outlook.com [52.101.56.37])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 65D4B10EE13
 for <amd-gfx@lists.freedesktop.org>; Tue,  7 Jul 2026 15:42:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RYXuUbPn0L6XNSh+q0q0RWwVSZEP6VpKCZcb2qT8HOZsJsdoT69uj47WqOtmxaIWpWEHYfhk/UZn4DGGe5YxQOezVv/4wfVMwuz+1wWsCMsLE5oF2d8cXfWvatDgr3ZbjL6UmmfK2Puc1sIJciH/KpBg3W56Sty7m2DLde7I+R2fe+sgQjeckCMYIhsajGdK2ZCX0H+wHpw+vKBQJBo8QW3qrx4hOUaPW5Ut+PjOo6/cMGzvqayWufP6GR9o6EG42Gf6zlr7C61UAAybyrKF+jl/0cpGI2fAYxISUFGNd91T3gORNI4fondg061i3fPUF0/6p8BQbi9sD+luunQFqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I1NwMvXqD2GIIcA8j3z4S0qNmmzuQxBCMDX+/dcIcno=;
 b=iXDW0JT0u6qtVye8qSAj/s9r03E+Pghp5xHq/5msg0BRfi+h1aKgcdLK7qIVSHDOHl+JCglGaF4v5st6sjDSNjWOTWmY6DLl0lkKqoFc4WHr2zX4yWrOt3pmLzHwwCHUzDwk1zaF+yn0/77S4DH0bPyhcwePByRy3VYLz6LIICkK3HOeYa5Z3AyGZnOLYCswHc5Y02FN6ALa+amV8YaewpgsUmOse1p9Ubmsx+EICZz5weChKSnmkJdP+ParAFLowG4RtKUWaVNN2xLNML/nVcxCxYXlFwm0lz+ky1eXLGX6xVxaIuUBtvdyX7xkwkwhTGj2FG69nQgD+rA9d43pMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I1NwMvXqD2GIIcA8j3z4S0qNmmzuQxBCMDX+/dcIcno=;
 b=HtM0OVUGhihL69NBhT4FE2TDGsIO+eHnNOp7c6qiE4gkEE+Kaoo4PNjSKQcg1Yi9BJdrHxY2UzaDpb4/AkFMs4+YyrnsJDgo576UXQDnwyr/a3QVuC72J5ajT7bzuigZhCpKecUDDMLU30Eit/t+iIdjPDThUBv8hgy5A5DT/BM=
Received: from BN8PR04CA0048.namprd04.prod.outlook.com (2603:10b6:408:d4::22)
 by DS0PR12MB8341.namprd12.prod.outlook.com (2603:10b6:8:f8::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Tue, 7 Jul
 2026 15:42:38 +0000
Received: from BL02EPF0001A106.namprd05.prod.outlook.com
 (2603:10b6:408:d4:cafe::2f) by BN8PR04CA0048.outlook.office365.com
 (2603:10b6:408:d4::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.181.13 via Frontend Transport; Tue, 7
 Jul 2026 15:42:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL02EPF0001A106.mail.protection.outlook.com (10.167.241.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Tue, 7 Jul 2026 15:42:37 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 7 Jul
 2026 10:42:32 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Tue, 7 Jul 2026 10:42:31 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 27/30] drm/amdgpu/gfx10: drop all BUG()s
Date: Tue, 7 Jul 2026 11:42:00 -0400
Message-ID: <20260707154203.2603209-27-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260707154203.2603209-1-alexander.deucher@amd.com>
References: <20260707154203.2603209-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A106:EE_|DS0PR12MB8341:EE_
X-MS-Office365-Filtering-Correlation-Id: e0014d4b-16d1-496c-cc81-08dedc3e5f5c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|23010399003|36860700016|376014|22082099003|18002099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: V4XLRpFF5dF0u2DzZV2wjVoaecwqMuky2k+4TFV66UIFyb31g4UMiuNVLF1SVgoJzbpHLKasYxg72f+eGXhWvPo8H7LgRFaSRSQsW6LLkN90jveTiBEWN37nguvAU8pV3B78vTus7iwumxLSFpmEdR4XxhcBS1y/yI78kgOYqUxTumchak6D7Hyt0DkhJYPGFSZYl31sYdqU/RpRWGPQd6iUD31h9KcxIri94b4QHszr7cqD7EIyGbeOn92zszhHvnm0Yllxl2IxqRiO43zrvYXXV8d7vo4zB8ms3luDJm6Vf6tJDJH7f4AOeva2RevO9/2hvvxMne2NKPYdGf6t+G4NdhQnYEIj2H3kkjM+yEH5TIJoqB6O5nri+eKEWPFFOWogp8lHPHx06ib/OF/KUEA5i7rWyPf3Vl0ruVGX6qWWoKqAxsqPEwEfbP3ORT08JMIWosr+WhxDcb63cNiRhsjSFEIvbfCHUI+2MKV6qirPNF4xfD16tpb90bICa+huKBAtX6mCjqezbshZtI8G5TN+kIvS/kHqMQEeEgoEt1q9nO/l21lMnn2yKE+Ge+hGoda1uyAVS5n13dYvmSKjjBpPIRBiQVyjjOlcFCwTpfg8s6nzXw7vCkYFNbw1QwYPoZjjS3LBOTcuYTj23z4UnbH96duPe186xYGuCBe9+YN3x8kJ9cbExRyYVnQKd+WepiVTi/WZTAvLNvn06gCXfw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(23010399003)(36860700016)(376014)(22082099003)(18002099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: lV8fttrjw40UFFLhIJPMWJxFyqIEScICuJjggrQieTy+5+TNKVxGvvcLv8+I+XqbKCrmrlF2eGJDbUHGaQVcrTy3DRX13GhGG1JtpZHETYOBm1s5Ghi6eZ7I8PgKmtwnwupzIvlYKYcuI9AD/N4N8Ky9i2GKa2Cyz6RNQlUbrDMKBjuRHdEknyofBMScQvSIs1ucC7QmJglJDwyf3ClXtN+5CPdXL0YEl7Te7aENcLT5QoINegoOfyt1bnnXRf6NF0CpuGc9bpk9fnmba2g+avtHiN+VwHl6bfdAKdbLvChpKZ+LWnFaurLf2yrQv8gQadbaNVGGRgZOimGxbGP+REtlNmd8yiF8xJWvj8o8UoThnn7wjv2EFKx59Hi0zMv87tcA8ZX7eX6ejn639hIOu5sm+HSfpJZ4LmE9T2vrILqG5bep0yYq8blm5FS6dSG7
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2026 15:42:37.8757 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e0014d4b-16d1-496c-cc81-08dedc3e5f5c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A106.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8341
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

There's no need to crash the kernel for these cases.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
index fa3deae20b29f..2f06230dfe4eb 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -4580,7 +4580,7 @@ static const struct amdgpu_gfx_funcs gfx_v10_0_gfx_funcs = {
 
 static void gfx_v10_0_gpu_early_init(struct amdgpu_device *adev)
 {
-	u32 gb_addr_config;
+	u32 gb_addr_config = 0;
 
 	switch (amdgpu_ip_version(adev, GC_HWIP, 0)) {
 	case IP_VERSION(10, 1, 10):
@@ -4620,7 +4620,6 @@ static void gfx_v10_0_gpu_early_init(struct amdgpu_device *adev)
 		gb_addr_config = CYAN_SKILLFISH_GB_ADDR_CONFIG_GOLDEN;
 		break;
 	default:
-		BUG();
 		break;
 	}
 
@@ -8599,13 +8598,16 @@ static u64 gfx_v10_0_ring_get_rptr_compute(struct amdgpu_ring *ring)
 
 static u64 gfx_v10_0_ring_get_wptr_compute(struct amdgpu_ring *ring)
 {
+	struct amdgpu_device *adev = ring->adev;
 	u64 wptr;
 
 	/* XXX check if swapping is necessary on BE */
-	if (ring->use_doorbell)
+	if (ring->use_doorbell) {
 		wptr = atomic64_read((atomic64_t *)ring->wptr_cpu_addr);
-	else
-		BUG();
+	} else {
+		dev_warn(adev->dev, "gfx_v10_0_ring_get_wptr_compute() requires doorbell!\n");
+		wptr = 0;
+	}
 	return wptr;
 }
 
@@ -8618,7 +8620,7 @@ static void gfx_v10_0_ring_set_wptr_compute(struct amdgpu_ring *ring)
 			     ring->wptr);
 		WDOORBELL64(ring->doorbell_index, ring->wptr);
 	} else {
-		BUG(); /* only DOORBELL method supported on gfx10 now */
+		dev_warn(adev->dev, "gfx_v10_0_ring_set_wptr_compute() requires doorbell!\n");
 	}
 }
 
@@ -9376,7 +9378,7 @@ static void gfx_v10_0_handle_priv_fault(struct amdgpu_device *adev,
 		}
 		break;
 	default:
-		BUG();
+		break;
 	}
 }
 
@@ -9446,7 +9448,7 @@ static int gfx_v10_0_kiq_set_interrupt_state(struct amdgpu_device *adev,
 		}
 		break;
 	default:
-		BUG(); /* kiq only support GENERIC2_INT now */
+		/* kiq only support GENERIC2_INT now */
 		break;
 	}
 	return 0;
-- 
2.55.0

