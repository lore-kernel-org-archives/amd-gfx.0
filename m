Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 813BE606A323
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Nov 2026 14:50:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=cuw/yVvm
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 212E910E199;
	Tue, 10 Nov 2026 14:50:53 +0000 (UTC)
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013057.outbound.protection.outlook.com
 [40.107.201.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9B8C210E199
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 Nov 2026 14:50:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vgqw4EYfAv5rwB1i9nrpY820leZmFI6zbdkBGXG+RDvhoXqZiOhgVNZjiEqKzxxEmFD9lnzmDg/RIrLcvAIFk8PrncXHZMQUQ0SCr+BScrTOxsFOVOcJ+H3Xa7E191sNe/S77oN1a6En2Po6CI7yzPhVYo7yqGbxrL15giwzK0PK1YCR9TObgmhvw6sSmKISMUixsMWNnbLcBBz3hn2LppCpr3SMytUrWMCPO91/vgpVGD3rldkFaEe+pXLro9MjnUpdXZ7tO+X6hW+5vVAyPbP5dC3YDKPVDi7CYycUYZK+1apPFSji/gvKB916Rwx4HEwnAcHCR1OKatMxdZ4yJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FzP84tl+S77cGPf/nyjHPli4IMtm7AbvoaCIzowp56Y=;
 b=vX23Jy1NpJgeQuFF0eyAaqdMD7OG9Y8efii68oK2U0drApHF4WycqO0mxDiGlwNO7Lozs2IC2Pp2s8rilDoQSINqGo05DTSefthg2xscCAx87JG9SnfIQCxK48n3CUZ7hA4dvrvjXifuqsUZct8rwwW2vAjd5amNcZgc6A7GZ0n/u1/5CY3SRL+8yZV8XPZl12OmSQcVf3trfHqSfEHwwYrL0EW0kmNb2L7G40v/Uwo7+CZPk9XN8ueUFGbzdE2rR21iglXbImlly1/fUAaFYwCJEzDPInAxwZGzEam/VhZdRPi/nJmF6REiVlR8l9uUn/eLbfyzqDKmWAOHFpqGRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FzP84tl+S77cGPf/nyjHPli4IMtm7AbvoaCIzowp56Y=;
 b=cuw/yVvmOMYvQS0HVz1+GEnHFsFptaRNhE5rms3Hgq2bUfpIMBzu/aMRu/VF58nW5GcDqT6O/KRNVWeCzKP2Nmt/KspcP9ueXYDckyIBH2lUmgaJUAXMVcF1rN0KJ4nuBSFdqYaICi87aGs5ljJdvYUgCjUc2evK80qCtj54o28=
Received: from CH0PR08CA0015.namprd08.prod.outlook.com (2603:10b6:610:33::20)
 by LV2PR12MB5774.namprd12.prod.outlook.com (2603:10b6:408:17a::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.11; Tue, 10 Nov
 2026 14:45:16 +0000
Received: from CH1PEPF0000A345.namprd04.prod.outlook.com
 (2603:10b6:610:33:cafe::1c) by CH0PR08CA0015.outlook.office365.com
 (2603:10b6:610:33::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.8 via Frontend Transport; Tue, 10
 Nov 2026 14:45:16 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH1PEPF0000A345.mail.protection.outlook.com (10.167.244.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Tue, 10 Nov 2026 14:45:16 +0000
Received: from krussell.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Tue, 10 Nov
 2026 08:45:15 -0600
From: Kent Russell <kent.russell@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <jay.cornwall@amd.com>, <gang.ba@amd.com>, Kent Russell
 <kent.russell@amd.com>
Subject: [PATCH 1/3] drm/amdgpu: Run shader cleaner on all XCCs on faults
Date: Tue, 10 Nov 2026 09:45:04 -0500
Message-ID: <20261110144506.3946989-1-kent.russell@amd.com>
X-Mailer: git-send-email 2.43.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000A345:EE_|LV2PR12MB5774:EE_
X-MS-Office365-Filtering-Correlation-Id: 29fa74d8-ad4e-40c8-9d23-08df3f393c19
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|30052699003|1800799024|36860700016|376014|23010399003|18002099003|10067099003|11063799006|56012099006|261009223027099003|261026121527099003|261028144727099003|261022105027099003|261102123227099003|261021123027099003|261026140227099003|261021121427099003;
X-Microsoft-Antispam-Message-Info: yBUesihML0V4Q+QVYm5uQWQOmRqvVr5vb5Z1cIq4+WMDU523pOaQrDy3wDUGNxFV63GQPAnax02iai8vxuuaX66eLts7GUfSMl3g3UqDS/VvMJgeSYZsrWuflvOSRfuhI9M3kyEI2CHADuTDK5KgrCvCXSal3MBsbh8JkuV0lMxqKWiCDCxn/oCXhFhJOO1JMjoVMB6xcx7d4sj2DZ0m3tq7xGQb4A4GzjvgHUuXsYH4PyBvBlYXjy2HMgTziRmWjdXpeiuN5raOaJHQe2LN30UP+65hYkzDTamHbGSrfz+v04sr8qlIsHi8DbUpFnN06FaZ2Q1eobJgeoxZguA9jHSXJgGin5uYpRHoGSh6Cl62nZcQ5k7GgMXM+RKuteHu6DP7PGvaB6h/XD9TkreHpU3fR8X1vi7aH0LUhmCeXfwMOTyjIbt04q44Odda8sA7kLWE8pIhiH03yLKo5iwV9aOmIi55WgpxDm+fliyoVi0mAurJu9KLmo32rvKBJI/p+C3Vm5vl33d/cIo7xDqWq77MV8OC3ri+MLf//muybAZ2hIBVI+trNJQmq2fqkDfFphRDO/UMRULEy8LbDmNcmrdfjHBlXM8QMXXOwAvx96IukczVSM0sb0MlhLIbJLO8TROqzg7mIyzEj56aqUWhK6ds8JW5ZTY7MOkayl3p1+SreGERyKjAcFaIvFYQ9Dre81awH9EquM6gE8N8jRLZ1w==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(30052699003)(1800799024)(36860700016)(376014)(23010399003)(18002099003)(10067099003)(11063799006)(56012099006)(261009223027099003)(261026121527099003)(261028144727099003)(261022105027099003)(261102123227099003)(261021123027099003)(261026140227099003)(261021121427099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 6PgyHsTvNMuOc1NuoPQCbFwxjELCZ1bH0lSzUZMB8FeZefkgYc1cwAuLF6K/EaOOYCT8z2+UpUS/iVOaudl/Gv0qETHS00iwjs+HgO11dloFmC77P7FghsrO1d4bnnjlz3jMWW5oLzJX3+fmlD08gs0I03UxzXmy05gcEV1C0jWPeJZepSRK8TYl71NrmhUeuyFWYTCXcEIQ5e4Kh8FKow3QV+5u0vXakqWXjbEyb6zK1luwZhk9DttorQmH9n4mh0Yo2KZ/K7jNvL62r0414z6bGIi+PB+U4Fiwjg6wp6wwO/XKVFgQidXsHOg/D5dLrkaJnQ4MQi0DIGGLF7aftysMmK9D7kxkxzpdtKG3/oNiDvP4j05bBck9LYSaYjjz9XC3DRIm89bsF0yMU24J2yOYJob64vjrzOtl0Sx3HHGcODxtN5Ibx+5efljq8HfG
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2026 14:45:16.3345 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 29fa74d8-ad4e-40c8-9d23-08df3f393c19
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000A345.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5774
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The previous patch only ran on XCC0, giving us a good chance that we
don't clear the right registers on fault handling in MI3. Loop through
them all to make sure we clear them all.

Signed-off-by: Kent Russell <kent.russell@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.c | 78 +++++++++++++++----------
 1 file changed, 47 insertions(+), 31 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.c
index f54f54fe535e..dc46133ed506 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.c
@@ -716,51 +716,67 @@ static int gfx_v9_4_2_do_vgprs_init(struct amdgpu_device *adev)
 
 static int gfx_v9_clean_shaders(struct amdgpu_device *adev)
 {
-	int r;
+	int r = 0;
 	/* CU_ID: 0~15, SIMD_ID: 0~3, WAVE_ID: 0 ~ 9 */
 	int wb_size = adev->gfx.config.max_shader_engines *
 			 CU_ID_MAX * SIMD_ID_MAX * WAVE_ID_MAX;
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
-	if (fence)
-		dma_fence_put(fence);
-	amdgpu_ib_free(&wb_ib, NULL);
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

