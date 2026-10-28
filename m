Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C7E9606A31D
	for <amd-gfx@archiver.kernel.org>; Wed, 28 Oct 2026 20:35:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=pBeGnorN
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CAAEE10E26F;
	Wed, 28 Oct 2026 20:35:18 +0000 (UTC)
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010039.outbound.protection.outlook.com [52.101.201.39])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0F6CD10E26F
 for <amd-gfx@lists.freedesktop.org>; Wed, 28 Oct 2026 20:35:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NYff5GrxsfLyMoLdjBOAoGrq97gRTsfJa1c8lFTDjxLE7/Yds0bxv+jJJAs7NYZ8jc/d0APaZ0Q/aHz3iqXYFR03yV2D/So/nWEZ6k63/bWwlQP3A/aKNaz9KZIjxi1QzIdEOUrkdDQ97zMSxRQyEm0QLl0bEo/wTDpWw8Y7hrgP9/6cgrY4Ns3hPZ+EVyfKADlLPifQUHWpflzhpcX3L0d0YeIcRo/tBuvoQx94nd0eVwXeS4bm0PTQISiJHBlFT5zbVxUTdPFAuXNInpNb5vc9v3ASipddqAqhSMM/V9mT5jqy+tEDh/lWinXUy/XQRNQowwqqIle3wOr3AjHegw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FzP84tl+S77cGPf/nyjHPli4IMtm7AbvoaCIzowp56Y=;
 b=MzefMy/HeeKKndrxrq93DEZO7pfJz1ub3OtvJWQjGjOLcO4UVSlJsbpsNG7cCo2+JARZtw0KBYyr30BbBqepJ/7B+q1LfX9wKf2oHASNFDbPL1pSqkb4OP/dgpgGSbeACz1lZcM/Brf2pdqQEm/N61/rHso6Ne5tF+W15wb8P+0ZolzUqA6D6y602WOQZsFRtBzMDntr7kDZ0N00cCJWhZE/JPmY8ykaUapeAD2t7pPQzIRcakNJGZHyMoUn9M0o34OTl8g+P9JPK6erR55I7CdNTWJlMrvIjabr7vLtxQmZL1K+BKl+BdW6r73DBPfEjLzt87AZTauswH38psfx4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FzP84tl+S77cGPf/nyjHPli4IMtm7AbvoaCIzowp56Y=;
 b=pBeGnorNmhek/e4yxHarPT1tpHuvIBGoU6xCIKZB60HIC4j6QM+QxBOlW8PN10CCGhXtrTZiZsjCF7I+Tiw0nb30ZPNJGtx0Xd4jrNHbrzBieUByX0GLLQqCESJzCAmSJXJFtyAqlG7SLCyz2TSeGFJ6TYEwpVQUZ6D6Bw/mDSc=
Received: from PH8PR22CA0021.namprd22.prod.outlook.com (2603:10b6:510:2d1::7)
 by DM4PR12MB6181.namprd12.prod.outlook.com (2603:10b6:8:a9::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.8; Wed, 28 Oct
 2026 20:35:07 +0000
Received: from PH3PEPF00059619.namprd05.prod.outlook.com
 (2603:10b6:510:2d1:cafe::38) by PH8PR22CA0021.outlook.office365.com
 (2603:10b6:510:2d1::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.546.22 via Frontend Transport; Wed,
 28 Oct 2026 20:35:07 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 PH3PEPF00059619.mail.protection.outlook.com (10.167.243.23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.569.4 via Frontend Transport; Wed, 28 Oct 2026 20:35:06 +0000
Received: from krussell.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Wed, 28 Oct
 2026 15:35:03 -0500
From: Kent Russell <kent.russell@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <jay.cornwall@amd.com>, <gang.ba@amd.com>, Kent Russell
 <kent.russell@amd.com>
Subject: [PATCH 1/2] drm/amdgpu: Run shader cleaner on all XCCs on faults
Date: Wed, 28 Oct 2026 16:34:52 -0400
Message-ID: <20261028203453.3463371-1-kent.russell@amd.com>
X-Mailer: git-send-email 2.43.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH3PEPF00059619:EE_|DM4PR12MB6181:EE_
X-MS-Office365-Filtering-Correlation-Id: 0defd55b-23a8-4d5e-087c-08df3532f3fc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|30052699003|82310400026|1800799024|36860700016|261021121427099003|261028144727099003|11063799006|56012099006|261009223027099003|261026121527099003|261026140227099003|261021123027099003|261022105027099003|10067099003|18002099003;
X-Microsoft-Antispam-Message-Info: RWzTDtkV041HliwDNw/jX0J2Ruk3kQu9tYsKgspZ4Kgq+D5+NoE66xkhWgCAaDeHgCtnlh+nsVP6LcP5fahWI0IaoH599FS1gUpY3g/Vw26ESkLGz9LuRfmvsqwBeYa/RHLjlg125NZhzZAdzQ92/R3KzI7hC79zpjzVykvsQWIudPjhGZvLMpLmvbE+OoIpz+TO6fDkjBfGqkKedKGBuRkD7ph40Olrxys0SdPDFzqm9x6kgx6Pvggns+UiKRg4nA00XtJSnXCoT1AiB/NwAL/N04YyBQ40cxNRILQZl6SxA+alwTGA59veaEm/g5KyNL7T+sA7bQNc/t3QIrJLOA5xRSGe3VElhWvr+QUgmXUVbJhQo8DTbpmwO6fTTDI0CKjQCGyXUxmAjYfnP+dvdAq355FJQpAm0tPRmqc4KIkG4SjIaXT7pm9yuiSKZEB5aJ0nU6vL0/Y222UBMPiKpCCDnsKSff+WOQ9c8wS9jbd0+zOJTUnQXwBT1+BulGKogwgT9t8eZWh1QePgTYYWJWK50qPFpxT5sa+OjVRBU9lM4wOiVEfQhLzkJJ3gNT/yMXjnRDWJehZNpA3bhCzdi/ljzCqKnS9GuFI4unXzOaUBnFZ9LBTxre5Wu93q4BKGpSg/+f9EyDVZ8kp1KktD9ygntalvuZhjzidtGct2dfUh5fkzqFL5ctE9OWaWvdQvNcZWeY75pPbKQlitlGCJFg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(30052699003)(82310400026)(1800799024)(36860700016)(261021121427099003)(261028144727099003)(11063799006)(56012099006)(261009223027099003)(261026121527099003)(261026140227099003)(261021123027099003)(261022105027099003)(10067099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: +tBP3U4cXgR5kevRICAFIQbC24I9XcPNe/o8Pz6KST8bRX+a5LHsuSSCClfP4Zu5FRfCyTJnNBVQzMto5Tpk5J5c8s0IsN428OZi5ssjFfdNSyycGDpzB1WmCx83oFCAAolC7NEJ168+tb3QWPCqhG9rppwYX2Ktzoks97ljtzuV4dmU9EzwJ3/kniWMrb9TUjZGTzakWp7yMdU+REMx2/9je/86lECDlijglR9IsYwQdMlhN0xYu7uaNEy70egVpqUZxT9MFyf5FaVSlCsS5mZVs9m1jRUNEEez4qVY+gzBr4EstBH/TDH3sUs8Yl2fE3buXt2NJ6dYBM/UcUuY27OSTYUemMnblR2IndBLVIwN6TpS1WaFmdB93IoP3Cg9tlIg19jMs8LEw8ndeCKwMZdc0iINMGuKM4oHqSaZf1h3JhflzX+IoobP4VxSeE3u
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2026 20:35:06.6798 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0defd55b-23a8-4d5e-087c-08df3532f3fc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: PH3PEPF00059619.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6181
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

