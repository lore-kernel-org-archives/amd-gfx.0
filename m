Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE33BC8300F
	for <amd-gfx@archiver.kernel.org>; Fri, 27 Jun 2025 03:40:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AC12810E94A;
	Fri, 27 Jun 2025 03:40:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="A+qPm2Rr";
	dkim-atps=neutral
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2073.outbound.protection.outlook.com [40.107.96.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5FFBD10E940
 for <amd-gfx@lists.freedesktop.org>; Fri, 27 Jun 2025 03:40:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yERIVm7CRP8EHyE1IxjPEczcLSCFD0KM+kG1GdL39+eXYo5swtqKqS1E3M1TtkzKyWmX971KPYjbYkEiFkEY2vRPOcmb80sKyr4o1opeVuujjAwakUFg/CubPQnxvqMRISrqmohJ4YNEE//cT8O6VchWq7EEI1TZM8TLSs0D1xN03FbG3CUIPgvb8SUk9xnIJ5z6vHSjOQZ8GBl8mTU2FIomkK4VxqPjr1ab6NUusvATowaIkiRMutHsBnN0Hm8kl2XPzq50FxYCTV1bugp73u2Y6CzPueHvtTgpGWLIE6+eHireca7+amnORNqBc3CqJJMXacdHCNjKkxZkfRhixQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=erppHthlZRzp1uT+Ur66nP2aXNwWCtaY2k3kLwURIdg=;
 b=bCKP58p+f4ml7aAchJO2YktXkEeplX+x7d5pyAWlBgwh2Fir8lBBEkoIRjHZK7Q92G9RD6JH7KY+5R4dRXc6z4cdkKFVRXdNl1ode68F/eL4SufFf1lXBpdy2WZdm2GlYPGtIiZ24SXP3QHh92GqNZYVfQbk7HTteRBOix5cvwDyFsiN3CxmOPwpMMXNywTNt0p55Ax8V+pTPJDJwqbI5BCNwiVk8x2TUbLH/eRXAqQc7AJ+jWadPWxQs2Ppiyxk8q/vRLO7k+zgqbsLzEIpa74rykOaU0Xf8tPagbBnmRF6Tky/ORwsYd3AzU8pZqBUjYAGRj2afstyn9xUg3a5UQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=erppHthlZRzp1uT+Ur66nP2aXNwWCtaY2k3kLwURIdg=;
 b=A+qPm2RrN3StfzfzE7PbEiDAmLCUWu+PbImg2ndJQVvtzukh9sAnYoBolRyyuxJ8Zjz5PaI+axNrHQfWIDFxt8RIDJcPWvdwhuSFnDn4qepUD+9jfT/cNuwJbNsZtS8wPEgAej9mBXo2r6gUct4vhurWzbvBk3R3XaAA2/Xy8Jg=
Received: from MN2PR08CA0030.namprd08.prod.outlook.com (2603:10b6:208:239::35)
 by CH2PR12MB4262.namprd12.prod.outlook.com (2603:10b6:610:af::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.25; Fri, 27 Jun
 2025 03:40:27 +0000
Received: from BL6PEPF0001AB54.namprd02.prod.outlook.com
 (2603:10b6:208:239:cafe::f0) by MN2PR08CA0030.outlook.office365.com
 (2603:10b6:208:239::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8880.21 via Frontend Transport; Fri,
 27 Jun 2025 03:40:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB54.mail.protection.outlook.com (10.167.241.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8880.14 via Frontend Transport; Fri, 27 Jun 2025 03:40:27 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 26 Jun
 2025 22:40:24 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>,
 <sasundar@amd.com>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 07/33] drm/amdgpu/sdma7: clean up resume code
Date: Thu, 26 Jun 2025 23:39:36 -0400
Message-ID: <20250627034002.5590-8-alexander.deucher@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB54:EE_|CH2PR12MB4262:EE_
X-MS-Office365-Filtering-Correlation-Id: 6e2bf014-6d36-401b-de73-08ddb52c5b57
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?05yK9v5khZC2hddgYJdKu1bQgcavFz4fg3Op5JhtvHTYSUbTVXiyjg8QEFjT?=
 =?us-ascii?Q?RnlW7Z9rY9LEwDF69jm+wtFc3cTZGLq7WppXZmmYoKwp/nSFh5+MeCc5KnhY?=
 =?us-ascii?Q?dQBMhVhp3d98SwBNyERb4iQsdEOcenCdnEpy020k+GBy5upOghWbYnswAZAu?=
 =?us-ascii?Q?/gstVbVG4tPuBGU4snCVk+GMoMGN8SA3fpjDXlNEv6EH8s/fQQwqkLuPsmxF?=
 =?us-ascii?Q?ip9cQCRQwUEG3c8L082lBTbl3ZA5vxFIiRQtSWzgcsAbAoTFvY3nJyRIRA5p?=
 =?us-ascii?Q?JfwCwbJf7LqVPwkfOkngiF5rXXpYfvtxlliiGS1K0Ipa6dCBvtup52m+M0gt?=
 =?us-ascii?Q?VKEtzjPnDqwZvg888Y3Iy8PJf3/iC+QCNNNFx8wOqwy3Y+4jeOFIcusgZP7A?=
 =?us-ascii?Q?/Jyj75dX283xZFu9vGYxnJ/8IYfdNuFdNlzlfLS6P6Vdul3qzeF4lcYngLQY?=
 =?us-ascii?Q?dG5lTHBcE4wS0QaY3XlUAM/buPVE0wbrqX0vrusHlEzKB/F/7wd7Jlm7FVNy?=
 =?us-ascii?Q?mURaU4olth5EXV5gczIrI+a2IRQYNuF2dFH/VCwLyRAqyO+iIjkF0cdIrY5v?=
 =?us-ascii?Q?gQ3nX/5MYjwE7sitRYgNx/+uanbJxWENPKbcX/CORhy20iMeY61BwI/vgDjz?=
 =?us-ascii?Q?iMkQ/TSnXIJa0AwBnMX+76WLiPDHPLqzMgVAb5jgh3yE2ci4Kb6xbOreBc4N?=
 =?us-ascii?Q?Y2yYmq2G+5Vp8eNZTWEdgexk/B1o2+xlhK0viMNNGtCQkaWqvKMxIsGDRu5g?=
 =?us-ascii?Q?JipqvwamZBSU/OTLn+3igGyTfFd2q6nADY33hdH+1KgzgwczWLF25UbQtdNj?=
 =?us-ascii?Q?5Zb5ktqk+DPLSy2raPvxl3wBtIcM4+qlNa3FEzKAKgG3VuAYyTsJx3fRsWJg?=
 =?us-ascii?Q?r0mkqtlmydxR4Nzcr7t7D+9q87oMGYj8CYTTrOEbQ9iMXNA23os/SJdxtHwh?=
 =?us-ascii?Q?EMgGTGs5Ls5fQkZZdObWYmsEGATF1NHmt2mZCiLKemE3/g6zXj1qdY/du9Tx?=
 =?us-ascii?Q?0HO0kOUmY3Z8wK5NfdIdOOZ3tX3LE3p2/F0CGfmNeRG4v7p/j72vGRedpqTw?=
 =?us-ascii?Q?4XiJfab+dLpix7Gu/zPsu1odb2abR38JzDws/1ayuQzafZ+9zgHFep95ViPV?=
 =?us-ascii?Q?GS0OMsSqP6pVew/avLcrHYudJpfHLih6kJEC+p1Lk0BeQylmXHzbbOwkaY/T?=
 =?us-ascii?Q?jIRTmqvt5T6baJyoP397GB3wU682tpTNttTlg6I3OcmWRMizEBUBnAXgEUvV?=
 =?us-ascii?Q?PDHH7MIUVeqlqwYRQiJBBn+2/Mv5CW+Nw93SVJhoOSADKIzEaDwgY8ChSXMh?=
 =?us-ascii?Q?3E3x/gGGvpSVv1QFcNjPSG5d6Z+7I2EmRiFHmqHRHGPESd40GIAYCrYey2yC?=
 =?us-ascii?Q?qajwbEBi+FhednoqMJoAbftwPk40+klTIrD5qcm6W2Xv2HjKNzAT6LSjOhef?=
 =?us-ascii?Q?KUVJiH3uIq8uzI8A7wopE2+ynEIQY5XSJsidUlYE4XhCEi8dD5saEGnvFVJx?=
 =?us-ascii?Q?w78eVXCrgev8Pic36FjXIPR1ibYbka1GAxBo?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2025 03:40:27.1719 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e2bf014-6d36-401b-de73-08ddb52c5b57
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB54.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4262
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
 drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c | 28 +++++++++-----------------
 1 file changed, 10 insertions(+), 18 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
index 99a080bad2a3d..95e54a1180ec6 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
@@ -467,12 +467,11 @@ static void sdma_v7_0_enable(struct amdgpu_device *adev, bool enable)
  *
  * @adev: amdgpu_device pointer
  * @i: instance
- * @restore: used to restore wptr when restart
  *
- * Set up the gfx DMA ring buffers and enable them. On restart, we will restore wptr and rptr.
+ * Set up the gfx DMA ring buffers and enable them.
  * Return 0 for success.
  */
-static int sdma_v7_0_gfx_resume_instance(struct amdgpu_device *adev, int i, bool restore)
+static int sdma_v7_0_gfx_resume_instance(struct amdgpu_device *adev, int i)
 {
 	struct amdgpu_ring *ring;
 	u32 rb_cntl, ib_cntl;
@@ -498,17 +497,11 @@ static int sdma_v7_0_gfx_resume_instance(struct amdgpu_device *adev, int i, bool
 	WREG32_SOC15_IP(GC, sdma_v7_0_get_reg_offset(adev, i, regSDMA0_QUEUE0_RB_CNTL), rb_cntl);
 
 	/* Initialize the ring buffer's read and write pointers */
-	if (restore) {
-		WREG32_SOC15_IP(GC, sdma_v7_0_get_reg_offset(adev, i, regSDMA0_QUEUE0_RB_RPTR), lower_32_bits(ring->wptr << 2));
-		WREG32_SOC15_IP(GC, sdma_v7_0_get_reg_offset(adev, i, regSDMA0_QUEUE0_RB_RPTR_HI), upper_32_bits(ring->wptr << 2));
-		WREG32_SOC15_IP(GC, sdma_v7_0_get_reg_offset(adev, i, regSDMA0_QUEUE0_RB_WPTR), lower_32_bits(ring->wptr << 2));
-		WREG32_SOC15_IP(GC, sdma_v7_0_get_reg_offset(adev, i, regSDMA0_QUEUE0_RB_WPTR_HI), upper_32_bits(ring->wptr << 2));
-	} else {
-		WREG32_SOC15_IP(GC, sdma_v7_0_get_reg_offset(adev, i, regSDMA0_QUEUE0_RB_RPTR), 0);
-		WREG32_SOC15_IP(GC, sdma_v7_0_get_reg_offset(adev, i, regSDMA0_QUEUE0_RB_RPTR_HI), 0);
-		WREG32_SOC15_IP(GC, sdma_v7_0_get_reg_offset(adev, i, regSDMA0_QUEUE0_RB_WPTR), 0);
-		WREG32_SOC15_IP(GC, sdma_v7_0_get_reg_offset(adev, i, regSDMA0_QUEUE0_RB_WPTR_HI), 0);
-	}
+	WREG32_SOC15_IP(GC, sdma_v7_0_get_reg_offset(adev, i, regSDMA0_QUEUE0_RB_RPTR), 0);
+	WREG32_SOC15_IP(GC, sdma_v7_0_get_reg_offset(adev, i, regSDMA0_QUEUE0_RB_RPTR_HI), 0);
+	WREG32_SOC15_IP(GC, sdma_v7_0_get_reg_offset(adev, i, regSDMA0_QUEUE0_RB_WPTR), 0);
+	WREG32_SOC15_IP(GC, sdma_v7_0_get_reg_offset(adev, i, regSDMA0_QUEUE0_RB_WPTR_HI), 0);
+
 	/* setup the wptr shadow polling */
 	wptr_gpu_addr = ring->wptr_gpu_addr;
 	WREG32_SOC15_IP(GC, sdma_v7_0_get_reg_offset(adev, i, regSDMA0_QUEUE0_RB_WPTR_POLL_ADDR_LO),
@@ -533,8 +526,7 @@ static int sdma_v7_0_gfx_resume_instance(struct amdgpu_device *adev, int i, bool
 	WREG32_SOC15_IP(GC, sdma_v7_0_get_reg_offset(adev, i, regSDMA0_QUEUE0_RB_BASE), ring->gpu_addr >> 8);
 	WREG32_SOC15_IP(GC, sdma_v7_0_get_reg_offset(adev, i, regSDMA0_QUEUE0_RB_BASE_HI), ring->gpu_addr >> 40);
 
-	if (!restore)
-		ring->wptr = 0;
+	ring->wptr = 0;
 
 	/* before programing wptr to a less value, need set minor_ptr_update first */
 	WREG32_SOC15_IP(GC, sdma_v7_0_get_reg_offset(adev, i, regSDMA0_QUEUE0_MINOR_PTR_UPDATE), 1);
@@ -635,7 +627,7 @@ static int sdma_v7_0_gfx_resume(struct amdgpu_device *adev)
 	int i, r;
 
 	for (i = 0; i < adev->sdma.num_instances; i++) {
-		r = sdma_v7_0_gfx_resume_instance(adev, i, false);
+		r = sdma_v7_0_gfx_resume_instance(adev, i);
 		if (r)
 			return r;
 	}
@@ -828,7 +820,7 @@ static int sdma_v7_0_reset_queue(struct amdgpu_ring *ring,
 	if (r)
 		return r;
 
-	r = sdma_v7_0_gfx_resume_instance(adev, i, true);
+	r = sdma_v7_0_gfx_resume_instance(adev, i);
 	if (r)
 		return r;
 	amdgpu_fence_driver_force_completion(ring);
-- 
2.50.0

