Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76C38606A31C
	for <amd-gfx@archiver.kernel.org>; Thu, 12 Nov 2026 13:44:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=dYRKaDkb
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DE9B410E5D3;
	Thu, 12 Nov 2026 13:44:05 +0000 (UTC)
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012015.outbound.protection.outlook.com [40.107.209.15])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8FA0C10E5D3
 for <amd-gfx@lists.freedesktop.org>; Thu, 12 Nov 2026 13:43:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yU0fZErScme5YzsIjDrvATpLXKcakqMrKfIr2e6eqRzDWZB8eJqHsyhUgpBl/vKKLjzTpz7di9DqiVeeHKsgE1E9Og4DogukXcQN2kOk+EkpSCCDHTK8aC04pOKNSNVJGawPE+HzRQbR8Fd674ik/Ov5phN4q5MePNncgF0ZfCf+yCACfloQH8OUv9BB1whIcRhzeLxliG/iZvqV69DZrwUmlqvj9Ui4fBIVbKLMN+3Ll9vqI449cMfbObwEby8i9iiHBWaHI2yupO+eqKRJYlzMI15EcuwscN81QXW84xb/R6bs51Wf8RPzZd8d6SE2esD7er8s8TWx8ZrIAB+lMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FzP84tl+S77cGPf/nyjHPli4IMtm7AbvoaCIzowp56Y=;
 b=a+TnC6lYvyxzkUgm9/BYGiRp8sLF4MOo9jbIUdtQ3m7eQH+vhp/Zi/GWQLa85Su02QSBOOUuT3MYAF/PPDl/q99Zef7w/KhwNXGOrhd1DWIfcCiieDQHGb2i281NETNk9RmBzt3WW0qxUL7+ib0cvdUkXs5I2Mmca9Eb5zqpsqRo1Fa3t9NYCZ+Kp3Hrfq5wH4GN15uWGNEwuZhjfu2SWai4S2iNoS9jids+iOeVVrylJuLbL60KBU6aBpl3qr4Oum3NPX/eC3VUCYVeU1M6NAOvGFL5s55lC6dW/r4b7hRI7jt2KDiqhoEAvWYMEhUcsJPV5fPvoUdOCzTBWcX8jg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FzP84tl+S77cGPf/nyjHPli4IMtm7AbvoaCIzowp56Y=;
 b=dYRKaDkb7qphNXS936V8XSKmqUhJl7s2n7/3fuIue0ZAebS2yH8Fml28pcbuvkbeKe4+zt98To4xAlAD46Q6jYQRSTz4QYJrCe5ybD0EiuPrRIyLkDTy83AIgZ6TO8qip6d0wBljgT8kzYU+42VTa+w75L3wDm6VcYE94CNFGeU=
Received: from DM6PR03CA0097.namprd03.prod.outlook.com (2603:10b6:5:333::30)
 by CH3PR12MB8209.namprd12.prod.outlook.com (2603:10b6:610:123::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.10; Thu, 12 Nov
 2026 13:43:50 +0000
Received: from CH7PEPF00000016.namprd21.prod.outlook.com
 (2603:10b6:5:333:cafe::56) by DM6PR03CA0097.outlook.office365.com
 (2603:10b6:5:333::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.9 via Frontend Transport; Thu, 12
 Nov 2026 13:43:50 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH7PEPF00000016.mail.protection.outlook.com (10.167.244.165) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.592.0 via Frontend Transport; Thu, 12 Nov 2026 13:43:49 +0000
Received: from krussell.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Thu, 12 Nov
 2026 07:43:48 -0600
From: Kent Russell <kent.russell@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <jay.cornwall@amd.com>, <gang.ba@amd.com>, Kent Russell
 <kent.russell@amd.com>
Subject: [PATCH 1/3] drm/amdgpu: Run shader cleaner on all XCCs on faults
Date: Thu, 12 Nov 2026 08:43:38 -0500
Message-ID: <20261112134340.4122401-1-kent.russell@amd.com>
X-Mailer: git-send-email 2.43.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH7PEPF00000016:EE_|CH3PR12MB8209:EE_
X-MS-Office365-Filtering-Correlation-Id: 72d8c4bc-4a12-4bbf-8790-08df40c2fb6c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|1800799024|36860700016|82310400026|30052699003|10067099003|11063799006|56012099006|261022105027099003|261028144727099003|261026121527099003|261026140227099003|261021123027099003|261021121427099003|261102123227099003|261009223027099003|18002099003;
X-Microsoft-Antispam-Message-Info: KlOx7L8nt0LQEsgFVuIdHA7lanOKfEALBh1B5F4UwdQjDKtkJcES8SeKmQrEtb7gaqSFCnGW9Jh11cPw2TdMHTy2Jz0GEgQ8z1Ai+FczMh61iFEyb/UgXELkrwTcbVraH/JgZLCGbepP5PFDUtmWyIO0jr2O6OxO/gx6jp/d0rC7rC/P7lfhyR8Wm6Gv9m6EQ/NEgQD06OzZyJk5m9TQXUyjaUz4Sut6Y449AVfG0O0fHbnE1R9ckfc4rVZEudyjNDQNjgz9AHNLKAQ8tcdnLdBjlNJ2UwU22Wb4dS2iPBzVdjI3snVuN4MweHJ22zbzGl10+eopAFu9lfVq09+UzJHOU6jJDZHLTUdpon/VIKg0XQBChZRvGTQY2RE7ctgGdB1Ecjd9eU2gMk9aALXcV1RiPDIeig1eryP0FT/UcArYxDO3Iy+DEbZy/k5NSPqoBwPgezRLE8n7XGnaTcdDxUcXIRXeOUws9VYUAgr1jqZhYvP1KibT/sABFThWA8DQZbHmz3HCYiHatHYBZ+9vWEBr4UMSWFh3fdJreEnUr8/5+5EvoZl8SqucATjhbR4Hr1VePjNYosVGwaDyTA7ZA/joYqhwIAQdNEU1JRuDZNbS/WFE2wBsI4b7RVPyb5b8mspmUdhY5JyqYBYO6AVV/1SvWk/OLi8sumc+qWl61/tIUP1sEh7Pq6sXdsM1LugNqFJBP2b+7ZTyHJ9NsjK4UQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(1800799024)(36860700016)(82310400026)(30052699003)(10067099003)(11063799006)(56012099006)(261022105027099003)(261028144727099003)(261026121527099003)(261026140227099003)(261021123027099003)(261021121427099003)(261102123227099003)(261009223027099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: Ad9lGxrWOpgdbUB7IUNsrRYWiIQGWdqqSpVCwe0WiQv6pM8YVLRAJSyz2g4idUzFRUj+FeQXU1duUwzSNAIQMsRDb461//Zf73u6IDeRiICcTI6MiAg/ZsKqh+0r8mxwbW8pC7I5+sn4rb/naIdiDK5dg2yUb+TGb4SyHuWsR9y+KN1RJlRzQOao/2oe1i9BuNEhFyUO0XHL9VgBGGSJO4lqglVm6KPtk+9O0Po0nm8g7pLg6VGEmzr4PIDmp1OT7WwAsIFDraUGYlDDm72m779cM+OP83bFJfzqIzbmsPMfgS9WLug4UUz1wAsH6kjneBq3ED3LTOLvDIc3DAQsLWm3rJBQL17qNm5knInI/wfdW8qkGU8jqRIxugZ1L9gr8SonhvddDSLWq6jR7uziY/BSXLsN0eiVubahUqQNsHSCADBDfHAqGdKlHv3Pb3aH
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2026 13:43:49.5370 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 72d8c4bc-4a12-4bbf-8790-08df40c2fb6c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH7PEPF00000016.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8209
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

