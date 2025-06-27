Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30FD7C7EE31
	for <amd-gfx@archiver.kernel.org>; Fri, 27 Jun 2025 03:40:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AF33F10E93C;
	Fri, 27 Jun 2025 03:40:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="OmDboh9O";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2077.outbound.protection.outlook.com [40.107.236.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8303510E939
 for <amd-gfx@lists.freedesktop.org>; Fri, 27 Jun 2025 03:40:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BOlVwupnUnlfm6NTqBf1Eri24vv6QdWUpVURrwxd03IQFEBqbTaYqmRwEEuiSFmdQpgAvgU5UVlfqAUe+Znb5LBl/tcuCK3hXdGfxwKpMkSIyNdNB5ZupepqLGltXU8NzpkHtqKBcw3EBmYc+uEFuF7zPRUsCmBJhra+9fe4gl3Ryb2FcC7XweVsc/v54ZE4cI4aFzIcTL8+m2sumj7GPnE5JNwGCNaAK8KMxre16uoro683lKf2l6FNTuVo9qOERwjSyX8ZCd3FAzRc+jQkkDek2Lqp1WdQw6Zl8ynccgAGLkffN36X85NgA7dgvdW6P6qjcFznH90OPuceynLEQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z/Wv+DACEo7tt3kIcjYMA9+MJ6nyVur2IgN7KAG9EKs=;
 b=syPTq2kzoq4aU3P3bl/smbMaGVJ7+jutCgGbNIxSKJc1baAQ7KdM648liT6tuZf2Y0XQ7tVVXVPRrijrtMNfVzODn4rzwnnW78hsgw0t+G+kiOYR7zw3y00TCG3x2yDuBToDTPrhX5dmzIGbZy2ZAEEhAA66MOXGTQOW9ID/wNs2xowdDivgBc9psZX9pAVl3WQVFubtAEiQgSNV0rqRP+18bOWg/L8gwrdQ4C1XNusp+ygrQWpVVtlndGcMC90QeO+Y/dEk417j+3EDYj97LIgOIuZXe5dFOUOYtshvQQi2U4EVWkxpCHxN3cz5Ch1qgzYreOfyPvrQ0PTsLM6x4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z/Wv+DACEo7tt3kIcjYMA9+MJ6nyVur2IgN7KAG9EKs=;
 b=OmDboh9OBCLly6kzMJLM5OiBnP/UD49YUSQQ4qiuq4Inx4CdOqhryWSwRHTfbQWMjpSlb55dcSDIvU813R5eT/IPQpj6SfcEpCoauGYDLvtyYdG8UnNKegihxb2TiMif/WhMrAhLrGo+nESKWXeBfjRA4tFXS83gAA86kaLWMPk=
Received: from MN2PR08CA0005.namprd08.prod.outlook.com (2603:10b6:208:239::10)
 by CYYPR12MB8937.namprd12.prod.outlook.com (2603:10b6:930:cb::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.20; Fri, 27 Jun
 2025 03:40:25 +0000
Received: from BL6PEPF0001AB54.namprd02.prod.outlook.com
 (2603:10b6:208:239:cafe::5d) by MN2PR08CA0005.outlook.office365.com
 (2603:10b6:208:239::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8880.17 via Frontend Transport; Fri,
 27 Jun 2025 03:40:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB54.mail.protection.outlook.com (10.167.241.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8880.14 via Frontend Transport; Fri, 27 Jun 2025 03:40:24 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 26 Jun
 2025 22:40:22 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>,
 <sasundar@amd.com>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 04/33] drm/amdgpu/sdma5: clean up resume code
Date: Thu, 26 Jun 2025 23:39:33 -0400
Message-ID: <20250627034002.5590-5-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250627034002.5590-1-alexander.deucher@amd.com>
References: <20250627034002.5590-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB54:EE_|CYYPR12MB8937:EE_
X-MS-Office365-Filtering-Correlation-Id: 2f2a9d30-e4cd-4195-372e-08ddb52c59eb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?COyrhBTT+v+uWQPQw9vA0+bL45+/A84qHKX0sd8qPUwV96fKG8x8QPP7Qtkn?=
 =?us-ascii?Q?c1wkJ/7gDdVIMwaYxuTRWSzO2LXmPPzVTDMCmrVDSs1b52rT0E9BOM6NB7DI?=
 =?us-ascii?Q?g3TqGPHpVyI1UtF/rseaUbofW+IQmGjpd6PZZ4IE5KKRLkFXOHzcwuJMqGqL?=
 =?us-ascii?Q?1P7QLoP6SVEqSgWLEm4/i6e8+PKcOp+wB1KNq4ExNoblSaPEVyGuOIL6Suif?=
 =?us-ascii?Q?0h+tZZnCRjW2TaCezScya65/mJLf8Xy7DQIXRxDGNEK1ip4qr7g2ZT8WKCiX?=
 =?us-ascii?Q?9Mak6QGKqBx/fiytbDLS1WJUWbqCDHq3OqQqh3ezqFITsCTOnC9829WsIsGY?=
 =?us-ascii?Q?9kTc11vYkyNU4ICVzmTU/XaJ5Xrg6gtYJ3R+Cra9DNcFGlvbzxGu5HUTwyA6?=
 =?us-ascii?Q?9EwuP9iO1A4Qu0YSq7fOxwO4cR1snKvVde6xSlPWFCzMLEDCM+dfpBPjdDdE?=
 =?us-ascii?Q?VnqyXcBnXGKh3leTQHvzpfQvNhLXgLBRpK0KZjooa55zyLfuUU9uRPsgOa/X?=
 =?us-ascii?Q?lhBrj/8cDoB29WXF4+CCMG7opKl0gy2Eb4x04//1/avwQpMu3z87Orex7oeW?=
 =?us-ascii?Q?d+n9wZNF0SBXre5417Ru7XOLwqFcFSAFP1cqsjHTfcL4X/xgCrH+P60/QHPR?=
 =?us-ascii?Q?26cRLDiB8SWd7inpwQWlcFfpKuA8UV46wGsLBr5/X0y8+LM+oOjSoPj5DJJH?=
 =?us-ascii?Q?EBVVyOkx5Ngo2iHZ2W/XdWnVFaUQnkLppaL9OIKYI+QtshnOKvbu9BZdSZHG?=
 =?us-ascii?Q?Eg4ayNpuVYGR5MKx73e4MoDkqIg+HrUhWuZvBm7+7HbsoFeyQSbCw7bZNu93?=
 =?us-ascii?Q?WZQ0FM060vfSuqt3ycpSGG8tgyPEJDYnjqaBZ1YH8LYsg7CCTvmU26Yru4ft?=
 =?us-ascii?Q?z+nEBS255/fV273SP3NalZ4bdJVQK6pN72fc4dmB9/gErHQqZGx5FMoyawCn?=
 =?us-ascii?Q?kjU3iddQIiEzH/vNNB5XTlmA0NR2Cu7+zbjCujqF1jTSiEquqK4ynqV50Ahx?=
 =?us-ascii?Q?Vchw28Uc+DW7oIJAgRiIL2dTEYJJ8wbV6GerVhuEp4A3geMJAwmeT08xZtkf?=
 =?us-ascii?Q?WOk/vBl3yM+VxWeb1texobS73Ci9hlKSijByglFdxIkUZVFf+740Noyev6Ft?=
 =?us-ascii?Q?84rZizudZzYfvbl2hjiQd3hxOsMkex/HpR5fmh5JzPT5YWbRF/IR1WSsaz+B?=
 =?us-ascii?Q?k7i0suuIATl+r/zt9cAzTQ7/RPLRCDlReDmdLoSlEoF2QnLX9EDxyxNyP0W1?=
 =?us-ascii?Q?HSessG2owXWIR9sDd+ORTYm/gzOUwIgWF/Y7YOpIaYkwSNq64/kYaJhWlFA3?=
 =?us-ascii?Q?XRxRkKDYBOHKjwoOeUCG0OQjju1okfZ1ocm6oUbp/UZFKuxjRtGMDqHdxUcV?=
 =?us-ascii?Q?tlSjPj8G1AHcfWFpzHe/5+kBOPDEmfG9RlH0ZB72KmZxSmzLbblhep4MXxk7?=
 =?us-ascii?Q?7Bkz4LAgTMnCJpuAjYcMxXEex0pyvB/NmW1Pa/xfRY/TQYr7GF9MIa9nmmxN?=
 =?us-ascii?Q?H6uCLnhzMln1YPxBVdnqoNtnZL8SWACudx/C?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2025 03:40:24.7806 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f2a9d30-e4cd-4195-372e-08ddb52c59eb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB54.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8937
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

There no need to save the ring ptrs.  Just reset them.
This cleans up a conditional in the resume code.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c | 27 +++++++++-----------------
 1 file changed, 9 insertions(+), 18 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
index 5a1098bdd8256..5f4c6a99b06dc 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
@@ -680,12 +680,11 @@ static void sdma_v5_0_enable(struct amdgpu_device *adev, bool enable)
  *
  * @adev: amdgpu_device pointer
  * @i: instance
- * @restore: used to restore wptr when restart
  *
- * Set up the gfx DMA ring buffers and enable them. On restart, we will restore wptr and rptr.
+ * Set up the gfx DMA ring buffers and enable them.
  * Return 0 for success.
  */
-static int sdma_v5_0_gfx_resume_instance(struct amdgpu_device *adev, int i, bool restore)
+static int sdma_v5_0_gfx_resume_instance(struct amdgpu_device *adev, int i)
 {
 	struct amdgpu_ring *ring;
 	u32 rb_cntl, ib_cntl;
@@ -713,17 +712,10 @@ static int sdma_v5_0_gfx_resume_instance(struct amdgpu_device *adev, int i, bool
 	WREG32_SOC15_IP(GC, sdma_v5_0_get_reg_offset(adev, i, mmSDMA0_GFX_RB_CNTL), rb_cntl);
 
 	/* Initialize the ring buffer's read and write pointers */
-	if (restore) {
-		WREG32_SOC15_IP(GC, sdma_v5_0_get_reg_offset(adev, i, mmSDMA0_GFX_RB_RPTR), lower_32_bits(ring->wptr << 2));
-		WREG32_SOC15_IP(GC, sdma_v5_0_get_reg_offset(adev, i, mmSDMA0_GFX_RB_RPTR_HI), upper_32_bits(ring->wptr << 2));
-		WREG32_SOC15_IP(GC, sdma_v5_0_get_reg_offset(adev, i, mmSDMA0_GFX_RB_WPTR), lower_32_bits(ring->wptr << 2));
-		WREG32_SOC15_IP(GC, sdma_v5_0_get_reg_offset(adev, i, mmSDMA0_GFX_RB_WPTR_HI), upper_32_bits(ring->wptr << 2));
-	} else {
-		WREG32_SOC15_IP(GC, sdma_v5_0_get_reg_offset(adev, i, mmSDMA0_GFX_RB_RPTR), 0);
-		WREG32_SOC15_IP(GC, sdma_v5_0_get_reg_offset(adev, i, mmSDMA0_GFX_RB_RPTR_HI), 0);
-		WREG32_SOC15_IP(GC, sdma_v5_0_get_reg_offset(adev, i, mmSDMA0_GFX_RB_WPTR), 0);
-		WREG32_SOC15_IP(GC, sdma_v5_0_get_reg_offset(adev, i, mmSDMA0_GFX_RB_WPTR_HI), 0);
-	}
+	WREG32_SOC15_IP(GC, sdma_v5_0_get_reg_offset(adev, i, mmSDMA0_GFX_RB_RPTR), 0);
+	WREG32_SOC15_IP(GC, sdma_v5_0_get_reg_offset(adev, i, mmSDMA0_GFX_RB_RPTR_HI), 0);
+	WREG32_SOC15_IP(GC, sdma_v5_0_get_reg_offset(adev, i, mmSDMA0_GFX_RB_WPTR), 0);
+	WREG32_SOC15_IP(GC, sdma_v5_0_get_reg_offset(adev, i, mmSDMA0_GFX_RB_WPTR_HI), 0);
 	/* setup the wptr shadow polling */
 	wptr_gpu_addr = ring->wptr_gpu_addr;
 	WREG32_SOC15_IP(GC, sdma_v5_0_get_reg_offset(adev, i, mmSDMA0_GFX_RB_WPTR_POLL_ADDR_LO),
@@ -751,8 +743,7 @@ static int sdma_v5_0_gfx_resume_instance(struct amdgpu_device *adev, int i, bool
 	WREG32_SOC15_IP(GC, sdma_v5_0_get_reg_offset(adev, i, mmSDMA0_GFX_RB_BASE_HI),
 	       ring->gpu_addr >> 40);
 
-	if (!restore)
-		ring->wptr = 0;
+	ring->wptr = 0;
 
 	/* before programing wptr to a less value, need set minor_ptr_update first */
 	WREG32_SOC15_IP(GC, sdma_v5_0_get_reg_offset(adev, i, mmSDMA0_GFX_MINOR_PTR_UPDATE), 1);
@@ -851,7 +842,7 @@ static int sdma_v5_0_gfx_resume(struct amdgpu_device *adev)
 	int i, r;
 
 	for (i = 0; i < adev->sdma.num_instances; i++) {
-		r = sdma_v5_0_gfx_resume_instance(adev, i, false);
+		r = sdma_v5_0_gfx_resume_instance(adev, i);
 		if (r)
 			return r;
 	}
@@ -1616,7 +1607,7 @@ static int sdma_v5_0_restore_queue(struct amdgpu_ring *ring)
 	freeze = REG_SET_FIELD(freeze, SDMA0_FREEZE, FREEZE, 0);
 	WREG32(sdma_v5_0_get_reg_offset(adev, inst_id, mmSDMA0_FREEZE), freeze);
 
-	r = sdma_v5_0_gfx_resume_instance(adev, inst_id, true);
+	r = sdma_v5_0_gfx_resume_instance(adev, inst_id);
 	amdgpu_gfx_rlc_exit_safe_mode(adev, 0);
 
 	return r;
-- 
2.50.0

