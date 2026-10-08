Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3078CA600D
	for <amd-gfx@archiver.kernel.org>; Thu,  8 Oct 2026 17:23:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5F08F10E3BB;
	Thu,  8 Oct 2026 17:23:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="o+vp4uu8";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010028.outbound.protection.outlook.com [52.101.201.28])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DE02E10E3BB
 for <amd-gfx@lists.freedesktop.org>; Thu,  8 Oct 2026 17:23:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nEHwabfKyQTeWx5uDCTRX0VfukzY/2GEHFvb0MQzcUpnIe+3+K29gmCHrxl7FMaXXpQ3IfXFLEHIoQ8hj88oJPe35QhItQv16CW/bxmPGOlOmoNzlFdp7zB7fGCtfOLQgbCo0M6yS+eymGoSbKI95Mi02Tnw4XwZ+4ZKBuolyXcGwwALdVusbm3ScBoVCBYWEr/osq6rLqdtII83RkyVHoU2UCmWZ1TkndEuyJ6PvEhkImPNkeWgZ3lADhBud5EC502swPNRK783rdQMSd7Ci1O2C00tgb0zfi0bZ7E/hdrOyK7V7r1e+eT4GYIBgDPED7Z440bHPSXvjq5KBT1baQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+OmPSYpaEBYvaBtT8J0dMXblyiI/Qek6p9otNRMWWCI=;
 b=mKx1IA6FoiHmLhVvJTTYaNeWhhtuv7c5nyAMhQ32wkD3lV0IVKWa11N3NQgVd5Qyx4aDnG8HXduvml5FsA/NEhT9QJNF469Bvs081sJyt7KBpmrYMcCY+gu/tXSHwDTaL7e+GzYZZvS/0TzISQKW71OnxaR7mo66hIZo2gE4z9dc+9D1i3a3+/Y0J0co72T33cfcT7CYTN3KgQWoFbPx0+B9LRHn2+8vm61+stK/95tRE2+V4cBoWrPrc9B3SfyTu7jEI0fC4iotDSEjyQNeH6l7bsyKmGezZ1x3jehzNFNj/9fAa7Xzkvrr7g0vYjm1efAJmIBi5nVdtTPgV+CheQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+OmPSYpaEBYvaBtT8J0dMXblyiI/Qek6p9otNRMWWCI=;
 b=o+vp4uu8jw++h18pjYeljco2LRq8Sf/4Fy4i1UNkRqYspp4Hd7WoyrnUjQnA1+zPaJSjA6Z8BCo1jFb3p7FquZzj4QvQHeogYuViNzu1EMYzHnpSaARCjXtScTCAJYpr137cDIV7D6iYp+Udn+zl4Rz+g2Gng5Op9HDgI35N9es=
Received: from CH0P221CA0027.NAMP221.PROD.OUTLOOK.COM (2603:10b6:610:11d::8)
 by BN7PPFFF39339DD.namprd12.prod.outlook.com (2603:10b6:40f:fc02::6eb) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.20; Thu, 8 Oct
 2026 17:23:25 +0000
Received: from BL6PEPF0006C3DC.namprd02.prod.outlook.com
 (2603:10b6:610:11d:cafe::15) by CH0P221CA0027.outlook.office365.com
 (2603:10b6:610:11d::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.20 via Frontend Transport; Thu, 8
 Oct 2026 17:23:23 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF0006C3DC.mail.protection.outlook.com (10.167.249.230) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.6 via Frontend Transport; Thu, 8 Oct 2026 17:23:22 +0000
Received: from krussell.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Thu, 8 Oct
 2026 12:23:17 -0500
From: Kent Russell <kent.russell@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <jay.cornwall@amd.com>, <gang.ba@amd.com>, Kent Russell
 <kent.russell@amd.com>
Subject: [PATCH] drm/amdgpu: Run shader cleaner on all XCCs on faults
Date: Thu, 8 Oct 2026 13:23:13 -0400
Message-ID: <20261008172313.2714482-1-kent.russell@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0006C3DC:EE_|BN7PPFFF39339DD:EE_
X-MS-Office365-Filtering-Correlation-Id: 513cee8a-a03b-400d-ee31-08df2560daaf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|376014|30052699003|36860700016|82310400026|11063799006|56012099006|10067099003|18002099003;
X-Microsoft-Antispam-Message-Info: MvgsonXwoWwJKxjrjLwj/dR9tLpg/Xw0/NPLYqchUhZlNCHvHLvyeSVcoODxAnCL21Y4PGxgIfUoaq6RAsaq/v38MZgeElAJ8rq+ysY2DJKC/HpeEEnbeTTKDBnnS9nj4cJVB/d6v+iTUQ7WMIVc1THi1ZcydlVT8WACGXkunsCZaQfSQvkiGRcN+LLzoudMGVlqpgnFiMpE6E7DWpRZKG0QrDNgJBtds7n6F020R61Uxre40+jzx7AdC5bBSGCZZTvTuex7aI98e6Re6DDe9Ky1LP0fFru601lZPK+5SR1YraEYJYstNtbh2s+EuiG4iZ9AfIM6nnRr5MnywIaCDnfHwCxddu25cmNG9pTQHUQeyuYPt/p3Tqm2ZVoZFDEjWMcGddaE4rxSCe1haQUby6zqPHX4FNiO6IajPgob8UzRVqZKECby6RukufOy/Qk9K/eWRRcFzDaZ5DO1L5pQu0XJoekEi83bQeRc/8BAGSJ3tto79I27m+tAxsRvf800QD2aoHe8XJQqQy9muxeQrhgEQgTDHqFUT+Zauj6hoVHhDC8ZgcTRYWOAxVYzIYuuY6kBV2IRfTrxr8aywD6FdRFMTTFr9RfRsD9EMRXY3x9b/Ak6LZ1mkwyoznY4XImUnaxhG2oyPT+0fs2glr1wLY2/VTMR4Ej6mFXqaBHG9Iw36o1nCNfNr6NAby83t+ArOVywosAwtxhMCV+f8EKM+w==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(376014)(30052699003)(36860700016)(82310400026)(11063799006)(56012099006)(10067099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: sYYucAOW6mwShm8SIzi8RNe9NsdzcseM6y0DQa9RnrqXOoni03unYaFAC6HUNLWBRN5e6KVh3uL5k/uiEhM42H2LemoRyjofcxhvNGyyIiG0tf0HcyIEdte2ykv/Q1xlADr+bMst3XTlC4D4bJJ7+oGxHHETpIiJVW2qjTrj/3OCheDSkAAkH6gmloQBUoq8DuduxmBZn6WtB3Qkr0s+UoshG5LzJDmGQdU0haisFaDIX7J3mX1BgJUBhE9wZa26LG3i6CWx0Kw18eL9nB17vikx0PGhX2j+5BNvILwiONFK4sRwH+Pt8+kWF3HFHHdWzqBpnTuSj6nA5zQPR4Eehcew/WSfu/rRZNKT7zG0TUrIGaWD3pI454kJ8xjZ+i644dREMvtHJPQmyI1l2j3aDDv9ZMi4VeH0/Ge1V8I1cIggsc1FIHY0Qz0gKrv/TMtn
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2026 17:23:22.5518 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 513cee8a-a03b-400d-ee31-08df2560daaf
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0006C3DC.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PPFFF39339DD
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

The previous patch only ran on XCC0, giving us a good chance that we
don't clear the right registers on fault handling in MI3. Loop through
them all to make sure we clear them all.

Signed-off-by: Kent Russell <kent.russell@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.c | 82 +++++++++++++++----------
 1 file changed, 49 insertions(+), 33 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.c
index 3cecf4ecf88f..e81044f01669 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.c
@@ -724,54 +724,70 @@ static int gfx_v9_4_2_do_vgprs_init(struct amdgpu_device *adev)
 
 static int gfx_v9_clean_shaders(struct amdgpu_device *adev)
 {
-	int r;
+	int r = 0;
 	/* CU_ID: 0~15, SIMD_ID: 0~3, WAVE_ID: 0 ~ 9 */
 	int wb_size = adev->gfx.config.max_shader_engines *
 			 CU_ID_MAX * SIMD_ID_MAX * WAVE_ID_MAX;
 	struct amdgpu_ib disp_ib;
 	struct amdgpu_ib wb_ib;
+	struct amdgpu_ring *ring;
 	struct dma_fence *fence = NULL;
 	u32 pattern = 0xa;
+	int xcc_id;
 
-	/* bail if the compute ring is not ready */
-	if (!adev->gfx.compute_ring[0].sched.ready)
+	if (adev->gfx.disable_kq) {
+		dev_warn(adev->dev, "Cannot run shader cleaner with kernel queues disabled");
 		return 0;
-
-	/* allocate the write-back buffer from IB */
-	memset(&wb_ib, 0, sizeof(wb_ib));
-	r = amdgpu_ib_get(adev, NULL, (1 + wb_size) * sizeof(uint32_t),
-			  AMDGPU_IB_POOL_DIRECT, &wb_ib);
-	if (r) {
-		dev_err(adev->dev, "failed to get ib (%d) for wb.\n", r);
-		return r;
 	}
-	memset(wb_ib.ptr, 0, (1 + wb_size) * sizeof(uint32_t));
 
-	r = gfx_v9_4_2_run_shader(adev,
-			&adev->gfx.compute_ring[0],
-			&disp_ib,
-			fault_cleaner_compute_shader_aldebaran,
-			sizeof(fault_cleaner_compute_shader_aldebaran),
-			fault_cleaner_init_regs_aldebaran,
-			ARRAY_SIZE(fault_cleaner_init_regs_aldebaran),
-			adev->gfx.cu_info.number * 32,
-			wb_ib.gpu_addr, pattern, &fence);
+	for_each_inst(xcc_id, adev->gfx.xcc_mask) {
+		ring = &adev->gfx.compute_ring[xcc_id * adev->gfx.num_compute_rings];
 
-	if (r) {
-		dev_err(adev->dev, "failed to clear MI200\n");
-		goto pro_end;
-	}
+		/* bail if the compute ring is not ready */
+		if (!ring->sched.ready)
+			continue;
 
-	/* wait for the GPU to finish processing the IB */
-	r = dma_fence_wait(fence, false);
-	if (r)
-		dev_err(adev->dev, "timeout to clear MI200\n");
+		/* allocate the write-back buffer from IB */
+		memset(&wb_ib, 0, sizeof(wb_ib));
+		r = amdgpu_ib_get(adev, NULL, (1 + wb_size) * sizeof(uint32_t),
+				  AMDGPU_IB_POOL_DIRECT, &wb_ib);
+		if (r) {
+			dev_err(adev->dev, "failed to get ib (%d) for wb.\n", r);
+			return r;
+		}
+		memset(wb_ib.ptr, 0, (1 + wb_size) * sizeof(uint32_t));
+
+		r = gfx_v9_4_2_run_shader(adev,
+				ring,
+				&disp_ib,
+				fault_cleaner_compute_shader_aldebaran,
+				sizeof(fault_cleaner_compute_shader_aldebaran),
+				fault_cleaner_init_regs_aldebaran,
+				ARRAY_SIZE(fault_cleaner_init_regs_aldebaran),
+				adev->gfx.cu_info.number * 32,
+				wb_ib.gpu_addr, pattern, &fence);
+
+		if (r) {
+			dev_err(adev->dev, "failed to clear GPR on xcc %d\n", xcc_id);
+			goto pro_end;
+		}
+
+		/* wait for the GPU to finish processing the IB */
+		r = dma_fence_wait(fence, false);
+		if (r)
+			dev_err(adev->dev, "timeout to clear GPR on xcc %d\n", xcc_id);
 
 pro_end:
-	amdgpu_ib_free(&disp_ib, NULL);
-	if (fence)
-		dma_fence_put(fence);
-	amdgpu_ib_free(&wb_ib, NULL);
+		amdgpu_ib_free(&disp_ib, NULL);
+		if (fence) {
+			dma_fence_put(fence);
+			fence = NULL;
+		}
+		amdgpu_ib_free(&wb_ib, NULL);
+
+		if (r)
+			break;
+	}
 
 	if (r)
 		dev_dbg(adev->dev, "Clean GPR Failed\n");
-- 
2.43.0

