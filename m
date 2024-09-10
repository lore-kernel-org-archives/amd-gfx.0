Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12AA1EB64DE
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Sep 2024 03:39:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B8EDF10E640;
	Tue, 10 Sep 2024 03:39:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ymJkEoOC";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2085.outbound.protection.outlook.com [40.107.243.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 80B7E10E63A
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 Sep 2024 03:39:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tu143MW67Wa+X6DetChGT4jGEuofoAmoVKY3PEHqkZVp0C+TTDz87yMuGbXLTYVTr3QcPijo9bU/Wa1vhA5rSvWVvOCl8lxm5H9wVVvNsf+lWA634x4vaCt3C8qBWS2mPdJx9OR3azaWNd4TI1j0eubC+nt2gggeMDpQLzvzrd972/Vb2/sw1IaoiaixphNdKNqITYjlG73axywRD8omDjP0FoJo2RJgBsX8iUVou2K5Prx5eL1S3VCtKEQEq9QJCOC+ig0rn6LqEtWSk/gVnAc4u/RgiPdiOm7J5/zs44GhXA2jkHqSnIbWIz7SyTxYRkQLSKxW5ab99GaE0LQQ/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c+9w9B3+4imSXjDMEGW9Qa7uXd6KjSwBRkpdOq8KJtY=;
 b=kAEM9Sgj6FZndduZp5LgoSk72HOpdCJDL/VUbeqzZBvgxZuo6kycV0YVS4HvC9FuTZJvSHrEDviggMPl/GZzH6TTG3XBO0H2j4PM4L6zvxRCzfWQXDgWBdAk8CZOuhDw0RIJWwn7aldD4t40a5aV4SzFXQOS4rvdT2Wh4LJijXyTJWgRH20PbzYyO1f6BjmsZdVYg0+xaqVAh3rGGCIa4c2l+cmUUl0N595rtnVxyuNEfY18YMJtJ3GJ1/Qcam04VAgtuzZi+vbQKEbe/krEuErUuzrAJ/k0m4zAkVpY8by9DpnCsHstMRVbsbb+lmZJSToKz0bRQLuRoGdA90IDkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c+9w9B3+4imSXjDMEGW9Qa7uXd6KjSwBRkpdOq8KJtY=;
 b=ymJkEoOC9rBH7gLsLOvm5n8aYgzGycy7kU0h6TTD3QDJv/Z+wGjPCyFrfFruzdhgdIZVG+8otzgDTxACRPCfPRYe6jAvYSwRAXpNpA2UFfeyjFBAghLtZ75Dyp9yOUr7bGg/M/sMZfkEfK/guW5ScEFC1KAqnNim1qOCD1iBsBI=
Received: from SJ0PR13CA0179.namprd13.prod.outlook.com (2603:10b6:a03:2c7::34)
 by CH3PR12MB8880.namprd12.prod.outlook.com (2603:10b6:610:17b::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.26; Tue, 10 Sep
 2024 03:39:37 +0000
Received: from CO1PEPF000044EF.namprd05.prod.outlook.com
 (2603:10b6:a03:2c7:cafe::4b) by SJ0PR13CA0179.outlook.office365.com
 (2603:10b6:a03:2c7::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.24 via Frontend
 Transport; Tue, 10 Sep 2024 03:39:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1PEPF000044EF.mail.protection.outlook.com (10.167.241.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7918.13 via Frontend Transport; Tue, 10 Sep 2024 03:39:36 +0000
Received: from jenkins-jiadong-1.amd.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 9 Sep 2024 22:39:34 -0500
From: <jiadong.zhu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <alexander.deucher@amd.com>, Jiadong Zhu <Jiadong.Zhu@amd.com>
Subject: [PATCH v2 2/3] drm/amdgpu/sdma6: split out per instance resume
 function
Date: Tue, 10 Sep 2024 11:39:17 +0800
Message-ID: <20240910033918.6035-2-jiadong.zhu@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240910033918.6035-1-jiadong.zhu@amd.com>
References: <20240910033918.6035-1-jiadong.zhu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB03.amd.com
 (10.181.40.144)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044EF:EE_|CH3PR12MB8880:EE_
X-MS-Office365-Filtering-Correlation-Id: 8c0a6d21-2a43-4a38-c3e5-08dcd14a3166
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?o3sKXxNv6PbB75j2+uqmsYliW7qT8wEGeTWAJDk19gReMShhIAbSJQlvS2wE?=
 =?us-ascii?Q?qSukjr+wsWxLyoxoQLuwfVdo7drT82zsMfpzMqXeiuTRKN6kZ/ScLK2SzXdK?=
 =?us-ascii?Q?idfks2MOCKqnpGETB+506cePhnJTDGo7VfgOzu4GzWH3K8amlBU8u8RH3K23?=
 =?us-ascii?Q?/j0rox8oYhUE/KfEd7dPLFOGZmx818aq0+07zPur9FHNQXGx22wAoRQuJCu9?=
 =?us-ascii?Q?CToXr2m2APKvHUaeM0q4Gtiy54/mHr8bK52sNQRBjIrWr1ZMFROV8mIT5ppq?=
 =?us-ascii?Q?Uw07yvTfMr3Iv1DWO4krzdlZX1RqqGmpX/BgcrjwgLvfrvfMELBIcEj7B1GT?=
 =?us-ascii?Q?m4TgUU/8JwZ5p3fJ06jNs05jItskU6EodbLRO7Kh0X/tMVZo2SHahDXhe1j6?=
 =?us-ascii?Q?nXcvB2TIVqRPol2reUAPOToCd7h0xUzDclQa5JaF9dq1r9amzDHHS+UHK0is?=
 =?us-ascii?Q?pI0P9R5WBOFyFMN29pVArxJjhR3qLiIfLwMqBjpYtcqu7z+vBbNycsVqO/Iq?=
 =?us-ascii?Q?E6+fBUS25Ij2m9Ni82Yw1apwcJaIkQmppmXjAlP831F6SLn8F9bdRNO0Y01D?=
 =?us-ascii?Q?m0ChjhpQVcxiHUBv2tZowZ2M5+qbyiMxPXo9WkxDsNaRheJ+xhBxMJnmLY7p?=
 =?us-ascii?Q?CUUckLZ1EljmxElo+k5Z/D+1NwMujQtrs93KuXRyUzaPl0gk2AvOPUqhsrOZ?=
 =?us-ascii?Q?763MdzVhySCisM48S5DnnoHMWmzEEMswHeuG+A3hb98n51haJMMcErl9QR0j?=
 =?us-ascii?Q?JryBmY/x/wOH2SMOq2celpfvTb7k2fBY38vImWF9bVbX9jw0rKdYoq7DW9zg?=
 =?us-ascii?Q?Tg3hT3/Ci8wqZ0OY7pTWal6QTX+d9qJrPJIgJO9JmBrFDovHi8pzicqcQsZN?=
 =?us-ascii?Q?LHiMclsePc+913ax/05F0mK6I5XxtLpnYMMcdjw7s87obIFgJgZC5+emvr7e?=
 =?us-ascii?Q?BkV+H5Zn9O+5J8Jv0HVuGS3T7KMvK7SBEWVsopBWQJMiVhkWgXjJPEuUFStj?=
 =?us-ascii?Q?Gx9x5MVm4Viojro7ns5AEKRAQnGQpAo8HpYgK+eHcpZlTv73pkMiLx9VFskT?=
 =?us-ascii?Q?F/9ipS/PdOwShAIj/sw1Y0zc0iGFAYW/mJESU90s89D4y4zHxAbtNZDaYfFa?=
 =?us-ascii?Q?XrWNnxeAx/pzBazemXn4Hc/Yf6ch+lDYyT2lrGUuvrvTUi9qqr0Q6y9Msgbv?=
 =?us-ascii?Q?t5nLGTIDyHqVZd5As4EfIW06EXEmyPYQrDJsNLFUobxG1/Q79OS60V4JuRpb?=
 =?us-ascii?Q?9/jTtxLWNjy3rwW056VAfF0XLIXdLvp5Dkw3JWunn2A8AGRTVkzSJLb+pxqQ?=
 =?us-ascii?Q?kJC5vzJzcP0KSgaBjRv4HrHuy0BQ6PYLa2+QdrSTQDxuSm0gT0vx8vjbhvqe?=
 =?us-ascii?Q?tC3n06UITpAZ5wHp0W4IfOORlPkpfdznu3AuQMO9fKZ8BHhlj6GM24TClFOr?=
 =?us-ascii?Q?BoXA7JQFs4YicG9vXOLCdY3RBSbI+qC0?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2024 03:39:36.4808 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c0a6d21-2a43-4a38-c3e5-08dcd14a3166
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044EF.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8880
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

From: Jiadong Zhu <Jiadong.Zhu@amd.com>

Extract the resume sequence for individual sdma instance from sdma_v6_0_gfx_resume.
The function could be used for start/restart scenario on a certain instance.

Signed-off-by: Jiadong Zhu <Jiadong.Zhu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c | 240 ++++++++++++++-----------
 1 file changed, 131 insertions(+), 109 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
index 208a1fa9d4e7..b2efc678b7e9 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
@@ -469,14 +469,16 @@ static void sdma_v6_0_enable(struct amdgpu_device *adev, bool enable)
 }
 
 /**
- * sdma_v6_0_gfx_resume - setup and start the async dma engines
+ * sdma_v6_0_gfx_resume_instance - start/restart a certain sdma engine
  *
  * @adev: amdgpu_device pointer
+ * @i: instance
+ * @restore: used to restore wptr when restart
  *
- * Set up the gfx DMA ring buffers and enable them.
- * Returns 0 for success, error for failure.
+ * Set up the gfx DMA ring buffers and enable them. On restart, we will restore wptr and rptr.
+ * Return 0 for success.
  */
-static int sdma_v6_0_gfx_resume(struct amdgpu_device *adev)
+static int sdma_v6_0_gfx_resume_instance(struct amdgpu_device *adev, int i, bool restore)
 {
 	struct amdgpu_ring *ring;
 	u32 rb_cntl, ib_cntl;
@@ -485,132 +487,152 @@ static int sdma_v6_0_gfx_resume(struct amdgpu_device *adev)
 	u32 doorbell_offset;
 	u32 temp;
 	u64 wptr_gpu_addr;
-	int i, r;
-
-	for (i = 0; i < adev->sdma.num_instances; i++) {
-		ring = &adev->sdma.instance[i].ring;
 
-		if (!amdgpu_sriov_vf(adev))
-			WREG32_SOC15_IP(GC, sdma_v6_0_get_reg_offset(adev, i, regSDMA0_SEM_WAIT_FAIL_TIMER_CNTL), 0);
+	ring = &adev->sdma.instance[i].ring;
+	if (!amdgpu_sriov_vf(adev))
+		WREG32_SOC15_IP(GC, sdma_v6_0_get_reg_offset(adev, i, regSDMA0_SEM_WAIT_FAIL_TIMER_CNTL), 0);
 
-		/* Set ring buffer size in dwords */
-		rb_bufsz = order_base_2(ring->ring_size / 4);
-		rb_cntl = RREG32_SOC15_IP(GC, sdma_v6_0_get_reg_offset(adev, i, regSDMA0_QUEUE0_RB_CNTL));
-		rb_cntl = REG_SET_FIELD(rb_cntl, SDMA0_QUEUE0_RB_CNTL, RB_SIZE, rb_bufsz);
+	/* Set ring buffer size in dwords */
+	rb_bufsz = order_base_2(ring->ring_size / 4);
+	rb_cntl = RREG32_SOC15_IP(GC, sdma_v6_0_get_reg_offset(adev, i, regSDMA0_QUEUE0_RB_CNTL));
+	rb_cntl = REG_SET_FIELD(rb_cntl, SDMA0_QUEUE0_RB_CNTL, RB_SIZE, rb_bufsz);
 #ifdef __BIG_ENDIAN
-		rb_cntl = REG_SET_FIELD(rb_cntl, SDMA0_QUEUE0_RB_CNTL, RB_SWAP_ENABLE, 1);
-		rb_cntl = REG_SET_FIELD(rb_cntl, SDMA0_QUEUE0_RB_CNTL,
-					RPTR_WRITEBACK_SWAP_ENABLE, 1);
+	rb_cntl = REG_SET_FIELD(rb_cntl, SDMA0_QUEUE0_RB_CNTL, RB_SWAP_ENABLE, 1);
+	rb_cntl = REG_SET_FIELD(rb_cntl, SDMA0_QUEUE0_RB_CNTL,
+				RPTR_WRITEBACK_SWAP_ENABLE, 1);
 #endif
-		rb_cntl = REG_SET_FIELD(rb_cntl, SDMA0_QUEUE0_RB_CNTL, RB_PRIV, 1);
-		WREG32_SOC15_IP(GC, sdma_v6_0_get_reg_offset(adev, i, regSDMA0_QUEUE0_RB_CNTL), rb_cntl);
-
-		/* Initialize the ring buffer's read and write pointers */
+	rb_cntl = REG_SET_FIELD(rb_cntl, SDMA0_QUEUE0_RB_CNTL, RB_PRIV, 1);
+	WREG32_SOC15_IP(GC, sdma_v6_0_get_reg_offset(adev, i, regSDMA0_QUEUE0_RB_CNTL), rb_cntl);
+
+	/* Initialize the ring buffer's read and write pointers */
+	if (restore) {
+		WREG32_SOC15_IP(GC, sdma_v6_0_get_reg_offset(adev, i, regSDMA0_QUEUE0_RB_RPTR), lower_32_bits(ring->wptr << 2));
+		WREG32_SOC15_IP(GC, sdma_v6_0_get_reg_offset(adev, i, regSDMA0_QUEUE0_RB_RPTR_HI), upper_32_bits(ring->wptr << 2));
+		WREG32_SOC15_IP(GC, sdma_v6_0_get_reg_offset(adev, i, regSDMA0_QUEUE0_RB_WPTR), lower_32_bits(ring->wptr << 2));
+		WREG32_SOC15_IP(GC, sdma_v6_0_get_reg_offset(adev, i, regSDMA0_QUEUE0_RB_WPTR_HI), upper_32_bits(ring->wptr << 2));
+	} else {
 		WREG32_SOC15_IP(GC, sdma_v6_0_get_reg_offset(adev, i, regSDMA0_QUEUE0_RB_RPTR), 0);
 		WREG32_SOC15_IP(GC, sdma_v6_0_get_reg_offset(adev, i, regSDMA0_QUEUE0_RB_RPTR_HI), 0);
 		WREG32_SOC15_IP(GC, sdma_v6_0_get_reg_offset(adev, i, regSDMA0_QUEUE0_RB_WPTR), 0);
 		WREG32_SOC15_IP(GC, sdma_v6_0_get_reg_offset(adev, i, regSDMA0_QUEUE0_RB_WPTR_HI), 0);
+	}
+	/* setup the wptr shadow polling */
+	wptr_gpu_addr = ring->wptr_gpu_addr;
+	WREG32_SOC15_IP(GC, sdma_v6_0_get_reg_offset(adev, i, regSDMA0_QUEUE0_RB_WPTR_POLL_ADDR_LO),
+	       lower_32_bits(wptr_gpu_addr));
+	WREG32_SOC15_IP(GC, sdma_v6_0_get_reg_offset(adev, i, regSDMA0_QUEUE0_RB_WPTR_POLL_ADDR_HI),
+	       upper_32_bits(wptr_gpu_addr));
+
+	/* set the wb address whether it's enabled or not */
+	WREG32_SOC15_IP(GC, sdma_v6_0_get_reg_offset(adev, i, regSDMA0_QUEUE0_RB_RPTR_ADDR_HI),
+	       upper_32_bits(ring->rptr_gpu_addr) & 0xFFFFFFFF);
+	WREG32_SOC15_IP(GC, sdma_v6_0_get_reg_offset(adev, i, regSDMA0_QUEUE0_RB_RPTR_ADDR_LO),
+	       lower_32_bits(ring->rptr_gpu_addr) & 0xFFFFFFFC);
+
+	rb_cntl = REG_SET_FIELD(rb_cntl, SDMA0_QUEUE0_RB_CNTL, RPTR_WRITEBACK_ENABLE, 1);
+	rb_cntl = REG_SET_FIELD(rb_cntl, SDMA0_QUEUE0_RB_CNTL, WPTR_POLL_ENABLE, 0);
+	rb_cntl = REG_SET_FIELD(rb_cntl, SDMA0_QUEUE0_RB_CNTL, F32_WPTR_POLL_ENABLE, 1);
+
+	WREG32_SOC15_IP(GC, sdma_v6_0_get_reg_offset(adev, i, regSDMA0_QUEUE0_RB_BASE), ring->gpu_addr >> 8);
+	WREG32_SOC15_IP(GC, sdma_v6_0_get_reg_offset(adev, i, regSDMA0_QUEUE0_RB_BASE_HI), ring->gpu_addr >> 40);
+
+	if (!restore)
+		ring->wptr = 0;
 
-		/* setup the wptr shadow polling */
-		wptr_gpu_addr = ring->wptr_gpu_addr;
-		WREG32_SOC15_IP(GC, sdma_v6_0_get_reg_offset(adev, i, regSDMA0_QUEUE0_RB_WPTR_POLL_ADDR_LO),
-		       lower_32_bits(wptr_gpu_addr));
-		WREG32_SOC15_IP(GC, sdma_v6_0_get_reg_offset(adev, i, regSDMA0_QUEUE0_RB_WPTR_POLL_ADDR_HI),
-		       upper_32_bits(wptr_gpu_addr));
-
-		/* set the wb address whether it's enabled or not */
-		WREG32_SOC15_IP(GC, sdma_v6_0_get_reg_offset(adev, i, regSDMA0_QUEUE0_RB_RPTR_ADDR_HI),
-		       upper_32_bits(ring->rptr_gpu_addr) & 0xFFFFFFFF);
-		WREG32_SOC15_IP(GC, sdma_v6_0_get_reg_offset(adev, i, regSDMA0_QUEUE0_RB_RPTR_ADDR_LO),
-		       lower_32_bits(ring->rptr_gpu_addr) & 0xFFFFFFFC);
-
-		rb_cntl = REG_SET_FIELD(rb_cntl, SDMA0_QUEUE0_RB_CNTL, RPTR_WRITEBACK_ENABLE, 1);
-		rb_cntl = REG_SET_FIELD(rb_cntl, SDMA0_QUEUE0_RB_CNTL, WPTR_POLL_ENABLE, 0);
-		rb_cntl = REG_SET_FIELD(rb_cntl, SDMA0_QUEUE0_RB_CNTL, F32_WPTR_POLL_ENABLE, 1);
+	/* before programing wptr to a less value, need set minor_ptr_update first */
+	WREG32_SOC15_IP(GC, sdma_v6_0_get_reg_offset(adev, i, regSDMA0_QUEUE0_MINOR_PTR_UPDATE), 1);
 
-		WREG32_SOC15_IP(GC, sdma_v6_0_get_reg_offset(adev, i, regSDMA0_QUEUE0_RB_BASE), ring->gpu_addr >> 8);
-		WREG32_SOC15_IP(GC, sdma_v6_0_get_reg_offset(adev, i, regSDMA0_QUEUE0_RB_BASE_HI), ring->gpu_addr >> 40);
+	if (!amdgpu_sriov_vf(adev)) { /* only bare-metal use register write for wptr */
+		WREG32_SOC15_IP(GC, sdma_v6_0_get_reg_offset(adev, i, regSDMA0_QUEUE0_RB_WPTR), lower_32_bits(ring->wptr) << 2);
+		WREG32_SOC15_IP(GC, sdma_v6_0_get_reg_offset(adev, i, regSDMA0_QUEUE0_RB_WPTR_HI), upper_32_bits(ring->wptr) << 2);
+	}
 
-		ring->wptr = 0;
+	doorbell = RREG32_SOC15_IP(GC, sdma_v6_0_get_reg_offset(adev, i, regSDMA0_QUEUE0_DOORBELL));
+	doorbell_offset = RREG32_SOC15_IP(GC, sdma_v6_0_get_reg_offset(adev, i, regSDMA0_QUEUE0_DOORBELL_OFFSET));
 
-		/* before programing wptr to a less value, need set minor_ptr_update first */
-		WREG32_SOC15_IP(GC, sdma_v6_0_get_reg_offset(adev, i, regSDMA0_QUEUE0_MINOR_PTR_UPDATE), 1);
+	if (ring->use_doorbell) {
+		doorbell = REG_SET_FIELD(doorbell, SDMA0_QUEUE0_DOORBELL, ENABLE, 1);
+		doorbell_offset = REG_SET_FIELD(doorbell_offset, SDMA0_QUEUE0_DOORBELL_OFFSET,
+				OFFSET, ring->doorbell_index);
+	} else {
+		doorbell = REG_SET_FIELD(doorbell, SDMA0_QUEUE0_DOORBELL, ENABLE, 0);
+	}
+	WREG32_SOC15_IP(GC, sdma_v6_0_get_reg_offset(adev, i, regSDMA0_QUEUE0_DOORBELL), doorbell);
+	WREG32_SOC15_IP(GC, sdma_v6_0_get_reg_offset(adev, i, regSDMA0_QUEUE0_DOORBELL_OFFSET), doorbell_offset);
 
-		if (!amdgpu_sriov_vf(adev)) { /* only bare-metal use register write for wptr */
-			WREG32_SOC15_IP(GC, sdma_v6_0_get_reg_offset(adev, i, regSDMA0_QUEUE0_RB_WPTR), lower_32_bits(ring->wptr) << 2);
-			WREG32_SOC15_IP(GC, sdma_v6_0_get_reg_offset(adev, i, regSDMA0_QUEUE0_RB_WPTR_HI), upper_32_bits(ring->wptr) << 2);
-		}
+	if (i == 0)
+		adev->nbio.funcs->sdma_doorbell_range(adev, i, ring->use_doorbell,
+					      ring->doorbell_index,
+					      adev->doorbell_index.sdma_doorbell_range * adev->sdma.num_instances);
 
-		doorbell = RREG32_SOC15_IP(GC, sdma_v6_0_get_reg_offset(adev, i, regSDMA0_QUEUE0_DOORBELL));
-		doorbell_offset = RREG32_SOC15_IP(GC, sdma_v6_0_get_reg_offset(adev, i, regSDMA0_QUEUE0_DOORBELL_OFFSET));
+	if (amdgpu_sriov_vf(adev))
+		sdma_v6_0_ring_set_wptr(ring);
+
+	/* set minor_ptr_update to 0 after wptr programed */
+	WREG32_SOC15_IP(GC, sdma_v6_0_get_reg_offset(adev, i, regSDMA0_QUEUE0_MINOR_PTR_UPDATE), 0);
+
+	/* Set up sdma hang watchdog */
+	temp = RREG32_SOC15_IP(GC, sdma_v6_0_get_reg_offset(adev, i, regSDMA0_WATCHDOG_CNTL));
+	/* 100ms per unit */
+	temp = REG_SET_FIELD(temp, SDMA0_WATCHDOG_CNTL, QUEUE_HANG_COUNT,
+			     max(adev->usec_timeout/100000, 1));
+	WREG32_SOC15_IP(GC, sdma_v6_0_get_reg_offset(adev, i, regSDMA0_WATCHDOG_CNTL), temp);
+
+	/* Set up RESP_MODE to non-copy addresses */
+	temp = RREG32_SOC15_IP(GC, sdma_v6_0_get_reg_offset(adev, i, regSDMA0_UTCL1_CNTL));
+	temp = REG_SET_FIELD(temp, SDMA0_UTCL1_CNTL, RESP_MODE, 3);
+	temp = REG_SET_FIELD(temp, SDMA0_UTCL1_CNTL, REDO_DELAY, 9);
+	WREG32_SOC15_IP(GC, sdma_v6_0_get_reg_offset(adev, i, regSDMA0_UTCL1_CNTL), temp);
+
+	/* program default cache read and write policy */
+	temp = RREG32_SOC15_IP(GC, sdma_v6_0_get_reg_offset(adev, i, regSDMA0_UTCL1_PAGE));
+	/* clean read policy and write policy bits */
+	temp &= 0xFF0FFF;
+	temp |= ((CACHE_READ_POLICY_L2__DEFAULT << 12) |
+		 (CACHE_WRITE_POLICY_L2__DEFAULT << 14) |
+		 SDMA0_UTCL1_PAGE__LLC_NOALLOC_MASK);
+	WREG32_SOC15_IP(GC, sdma_v6_0_get_reg_offset(adev, i, regSDMA0_UTCL1_PAGE), temp);
 
-		if (ring->use_doorbell) {
-			doorbell = REG_SET_FIELD(doorbell, SDMA0_QUEUE0_DOORBELL, ENABLE, 1);
-			doorbell_offset = REG_SET_FIELD(doorbell_offset, SDMA0_QUEUE0_DOORBELL_OFFSET,
-					OFFSET, ring->doorbell_index);
-		} else {
-			doorbell = REG_SET_FIELD(doorbell, SDMA0_QUEUE0_DOORBELL, ENABLE, 0);
-		}
-		WREG32_SOC15_IP(GC, sdma_v6_0_get_reg_offset(adev, i, regSDMA0_QUEUE0_DOORBELL), doorbell);
-		WREG32_SOC15_IP(GC, sdma_v6_0_get_reg_offset(adev, i, regSDMA0_QUEUE0_DOORBELL_OFFSET), doorbell_offset);
-
-		if (i == 0)
-			adev->nbio.funcs->sdma_doorbell_range(adev, i, ring->use_doorbell,
-						      ring->doorbell_index,
-						      adev->doorbell_index.sdma_doorbell_range * adev->sdma.num_instances);
-
-		if (amdgpu_sriov_vf(adev))
-			sdma_v6_0_ring_set_wptr(ring);
-
-		/* set minor_ptr_update to 0 after wptr programed */
-		WREG32_SOC15_IP(GC, sdma_v6_0_get_reg_offset(adev, i, regSDMA0_QUEUE0_MINOR_PTR_UPDATE), 0);
-
-		/* Set up sdma hang watchdog */
-		temp = RREG32_SOC15_IP(GC, sdma_v6_0_get_reg_offset(adev, i, regSDMA0_WATCHDOG_CNTL));
-		/* 100ms per unit */
-		temp = REG_SET_FIELD(temp, SDMA0_WATCHDOG_CNTL, QUEUE_HANG_COUNT,
-				     max(adev->usec_timeout/100000, 1));
-		WREG32_SOC15_IP(GC, sdma_v6_0_get_reg_offset(adev, i, regSDMA0_WATCHDOG_CNTL), temp);
-
-		/* Set up RESP_MODE to non-copy addresses */
-		temp = RREG32_SOC15_IP(GC, sdma_v6_0_get_reg_offset(adev, i, regSDMA0_UTCL1_CNTL));
-		temp = REG_SET_FIELD(temp, SDMA0_UTCL1_CNTL, RESP_MODE, 3);
-		temp = REG_SET_FIELD(temp, SDMA0_UTCL1_CNTL, REDO_DELAY, 9);
-		WREG32_SOC15_IP(GC, sdma_v6_0_get_reg_offset(adev, i, regSDMA0_UTCL1_CNTL), temp);
-
-		/* program default cache read and write policy */
-		temp = RREG32_SOC15_IP(GC, sdma_v6_0_get_reg_offset(adev, i, regSDMA0_UTCL1_PAGE));
-		/* clean read policy and write policy bits */
-		temp &= 0xFF0FFF;
-		temp |= ((CACHE_READ_POLICY_L2__DEFAULT << 12) |
-			 (CACHE_WRITE_POLICY_L2__DEFAULT << 14) |
-			 SDMA0_UTCL1_PAGE__LLC_NOALLOC_MASK);
-		WREG32_SOC15_IP(GC, sdma_v6_0_get_reg_offset(adev, i, regSDMA0_UTCL1_PAGE), temp);
-
-		if (!amdgpu_sriov_vf(adev)) {
-			/* unhalt engine */
-			temp = RREG32_SOC15_IP(GC, sdma_v6_0_get_reg_offset(adev, i, regSDMA0_F32_CNTL));
-			temp = REG_SET_FIELD(temp, SDMA0_F32_CNTL, HALT, 0);
-			temp = REG_SET_FIELD(temp, SDMA0_F32_CNTL, TH1_RESET, 0);
-			WREG32_SOC15_IP(GC, sdma_v6_0_get_reg_offset(adev, i, regSDMA0_F32_CNTL), temp);
-		}
+	if (!amdgpu_sriov_vf(adev)) {
+		/* unhalt engine */
+		temp = RREG32_SOC15_IP(GC, sdma_v6_0_get_reg_offset(adev, i, regSDMA0_F32_CNTL));
+		temp = REG_SET_FIELD(temp, SDMA0_F32_CNTL, HALT, 0);
+		temp = REG_SET_FIELD(temp, SDMA0_F32_CNTL, TH1_RESET, 0);
+		WREG32_SOC15_IP(GC, sdma_v6_0_get_reg_offset(adev, i, regSDMA0_F32_CNTL), temp);
+	}
 
-		/* enable DMA RB */
-		rb_cntl = REG_SET_FIELD(rb_cntl, SDMA0_QUEUE0_RB_CNTL, RB_ENABLE, 1);
-		WREG32_SOC15_IP(GC, sdma_v6_0_get_reg_offset(adev, i, regSDMA0_QUEUE0_RB_CNTL), rb_cntl);
+	/* enable DMA RB */
+	rb_cntl = REG_SET_FIELD(rb_cntl, SDMA0_QUEUE0_RB_CNTL, RB_ENABLE, 1);
+	WREG32_SOC15_IP(GC, sdma_v6_0_get_reg_offset(adev, i, regSDMA0_QUEUE0_RB_CNTL), rb_cntl);
 
-		ib_cntl = RREG32_SOC15_IP(GC, sdma_v6_0_get_reg_offset(adev, i, regSDMA0_QUEUE0_IB_CNTL));
-		ib_cntl = REG_SET_FIELD(ib_cntl, SDMA0_QUEUE0_IB_CNTL, IB_ENABLE, 1);
+	ib_cntl = RREG32_SOC15_IP(GC, sdma_v6_0_get_reg_offset(adev, i, regSDMA0_QUEUE0_IB_CNTL));
+	ib_cntl = REG_SET_FIELD(ib_cntl, SDMA0_QUEUE0_IB_CNTL, IB_ENABLE, 1);
 #ifdef __BIG_ENDIAN
-		ib_cntl = REG_SET_FIELD(ib_cntl, SDMA0_QUEUE0_IB_CNTL, IB_SWAP_ENABLE, 1);
+	ib_cntl = REG_SET_FIELD(ib_cntl, SDMA0_QUEUE0_IB_CNTL, IB_SWAP_ENABLE, 1);
 #endif
-		/* enable DMA IBs */
-		WREG32_SOC15_IP(GC, sdma_v6_0_get_reg_offset(adev, i, regSDMA0_QUEUE0_IB_CNTL), ib_cntl);
+	/* enable DMA IBs */
+	WREG32_SOC15_IP(GC, sdma_v6_0_get_reg_offset(adev, i, regSDMA0_QUEUE0_IB_CNTL), ib_cntl);
+
+	if (amdgpu_sriov_vf(adev))
+		sdma_v6_0_enable(adev, true);
 
-		if (amdgpu_sriov_vf(adev))
-			sdma_v6_0_enable(adev, true);
+	return amdgpu_ring_test_helper(ring);
+}
 
-		r = amdgpu_ring_test_helper(ring);
+/**
+ * sdma_v6_0_gfx_resume - setup and start the async dma engines
+ *
+ * @adev: amdgpu_device pointer
+ *
+ * Set up the gfx DMA ring buffers and enable them.
+ * Returns 0 for success, error for failure.
+ */
+static int sdma_v6_0_gfx_resume(struct amdgpu_device *adev)
+{
+	int i, r;
+
+	for (i = 0; i < adev->sdma.num_instances; i++) {
+		r = sdma_v6_0_gfx_resume_instance(adev, i, false);
 		if (r)
 			return r;
 	}
-- 
2.25.1

