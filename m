Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CD02CCFA13
	for <amd-gfx@archiver.kernel.org>; Thu, 26 Sep 2024 07:48:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3FEBD10EAD9;
	Thu, 26 Sep 2024 07:48:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="4oabVu//";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2074.outbound.protection.outlook.com [40.107.94.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A0F4B10EAD9
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Sep 2024 07:48:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vsp2SmDoHk1Vps6ynVkKMNF9o7vCP+9Sb4GVZqgjrh9/MBXjy/Uxn0v4BgmLTU2m9j/BlNChYEAU3il82r20vokMs43Sbf89uW6Ml0zRDU/UXqOLLW+QuDcSOGrxj8/ELo3xqxOehGVmfEj+4bAo8sjx1Gft2usXNBt3Q2opm/+RVOac0+TyiiA3hoxcmhsGf0eY/xImNJdwoKx+yYjkKpSv8q2GddDRC1v7hlK3MeXv1ZD05210W5p60IZnb3sUdTgGUH8qYFoFDmhznoWDaE2uFRwjVL85z56yscf82nd9gWFgM8fzl+kqArTVVD9RDLRb4NPWU4RHCafHX+VEVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+zIjZVTSYA9+KtJiOdHUdIT6Pb7NTPOvuS7KBWEGVSA=;
 b=WRfqYt+aKi0QubUzqEuKv3W9g/ezBqRQ5SSwaxWm/yGV6+/674Sva9yeNovQplqpb7oUWwpAUObb5HLHEGKCR+sj41nhGf0ESq93Ks1rEWw5XGF3oGNYmS6wjliqRecttI1mlCcjTVSUTd8QL48NiGxCBIO5vWnc9CwgcIBNVKQ05Y3UmlQdWpXMZ5DdB6iyD2DcBFWp5u1wcsm7+xLoBV2xfsM/2NJgenDmvOxBvFhZycpGsagE/DgG3oQ8Zq06wroXCHm9OrHd2aayQSgcH3/rW1bAT2FThvyiPyGZVlmQHAVf6mvyQgxgjkNLW3bANiHqC7g6a3Ro5ZerbK73aA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+zIjZVTSYA9+KtJiOdHUdIT6Pb7NTPOvuS7KBWEGVSA=;
 b=4oabVu//S397WopfylndhsvEpCQp6MBgoMlwWMS9JBBc4W3xYIyg9LIgQch/dhujzmB8xe5fD/+YakqvAOPd7amX7gU5PAhEAqpxLLjGn7N18wycaw/LoFr6jjlTbU/Haml6sKnlknWF3t9ImVRYa5MM+nDdJ5DFDtcpZysLi0M=
Received: from MN2PR20CA0020.namprd20.prod.outlook.com (2603:10b6:208:e8::33)
 by SA3PR12MB9227.namprd12.prod.outlook.com (2603:10b6:806:398::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.21; Thu, 26 Sep
 2024 07:48:00 +0000
Received: from BN3PEPF0000B074.namprd04.prod.outlook.com
 (2603:10b6:208:e8:cafe::d) by MN2PR20CA0020.outlook.office365.com
 (2603:10b6:208:e8::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.22 via Frontend
 Transport; Thu, 26 Sep 2024 07:48:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B074.mail.protection.outlook.com (10.167.243.119) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8005.15 via Frontend Transport; Thu, 26 Sep 2024 07:47:59 +0000
Received: from jenkins-jiadong-1.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 26 Sep 2024 02:46:23 -0500
From: <jiadong.zhu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <alexander.deucher@amd.com>, Jiadong Zhu <Jiadong.Zhu@amd.com>
Subject: [PATCH v2 1/4] drm/amdgpu/sdma5: split out per instance resume
 function
Date: Thu, 26 Sep 2024 15:45:33 +0800
Message-ID: <20240926074536.22211-1-jiadong.zhu@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B074:EE_|SA3PR12MB9227:EE_
X-MS-Office365-Filtering-Correlation-Id: 4d6914de-8a38-4a4c-9aba-08dcddff8b1f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?rv789c7E2UzdzpsYTHNwsVXd9HYyLmC4lB2ATuYVsLsKLdeoXG2g8UHgC9RQ?=
 =?us-ascii?Q?oI6vRhD4W7xKlo+kGKVVZ+3WP0ztTLoFT7GYs2PM1IqW9FNOChfx+/Prtn/n?=
 =?us-ascii?Q?X0qI6RRGZHPd3qeKplxFZt1k514J1yGIUu+0lQIZCFA8cdLrTmm4UlYI9Tkl?=
 =?us-ascii?Q?SoS36BTxQt4xx62SBtgxEMB8fmFebXnEJky6hg6dIBCWmhCVkfh8zP9lHE18?=
 =?us-ascii?Q?D45OyudNHSMRU7ud97qTIU10dT7amBkNTE3mJoBD7htsQELaCpyD6KNI2vgw?=
 =?us-ascii?Q?lkMkKwXJe4NgMNb3cRLzQAlhTK03F+Ax/SBldatdwac9K7pIpLNibFXjclvX?=
 =?us-ascii?Q?Jp9sMHUEHu6DHhtr0QQYHdzoxF4tEroBxFEr6c6WWCGsYj6dZ9/wZJfB+ocK?=
 =?us-ascii?Q?r7fI9kPa9SnN8KMSAJ51qBWwHPxQ72Ci9fP6Wxc85IBAj3rk+GQqglwgz5VZ?=
 =?us-ascii?Q?CJnicOyMTH0iHWyEt8BZEB7XIdrp52pCAfGyKwG/Cco0yl86hCM1b45CAaSv?=
 =?us-ascii?Q?q2MOE1UAaAP81I2QFt55YDbicpPJK2ZgGm+s7T4LOcvM/otXMMtQnKsF/DoD?=
 =?us-ascii?Q?qTF2O19JJ8zjxu9EjVajR33Un7EzLbs4euX+4TPxHYMdJYsiUvbwoJEGlM/3?=
 =?us-ascii?Q?GHq/XQwB0kAZjjD1AkrGzuwdy123P7VG0h6ctyC6S/JkCC+fczHKNJ9bztHJ?=
 =?us-ascii?Q?ftJVgJKxFvt/VQW1uIleyZL+R/vhQLUTZPfOCS3LioMlq3UetBlZWVpixERh?=
 =?us-ascii?Q?UhI/a10QOrLMFd9z3Y1vea+UWTvjmwznN+Pgr8HtzkuTmdafSedrBNWFbPhE?=
 =?us-ascii?Q?craDI3Ya9k1f/2un5LZWIdNRSwKg6o95FCDo73TbxDQEN6NefNAyI+/Khxw2?=
 =?us-ascii?Q?YS2E2aGU+4s5VxGBzsPWGGXbkBhhRogx/mRkDywcXQLmOI8817SjJs3gn8v6?=
 =?us-ascii?Q?b4atIGvAORYMKJE0v8Z36jowY28/bl1ick3F6uHVRyZHk2UjUTM0SOfI8ohr?=
 =?us-ascii?Q?kA/12eXcNNGf9AnDQjCJmPKYa0m7fnzRgRa2O1pKXqmpXsTJvHe8q10rahmc?=
 =?us-ascii?Q?Zfyx2hShhgBYp9HP5/JmgtQmiYTWkeOyF6b5S941ULmGBaJHqBcAN0xP8HUy?=
 =?us-ascii?Q?RD+X8GALAdPI4L3RVam5RJZUvhg17QLaF9XQK0nty0tfdRVyJkQr0UojDX9z?=
 =?us-ascii?Q?jXArp1mJNfntsBNo6n/KUt40nuiLNZG8Z4oxYpg3duiBSH00cApbqafZybCz?=
 =?us-ascii?Q?+XYEsv6yzXNUPT8cjlInggmx30pQuJxj3LEWH3w1uyymPHs1sXmrQlWuIpDX?=
 =?us-ascii?Q?oFtbWXitcEuHdWjoDJABzU3fVJUUN8AZrfF4EV6Ft1NVUJh9jAEQErQzvLV0?=
 =?us-ascii?Q?+49LdKA=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2024 07:47:59.9489 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d6914de-8a38-4a4c-9aba-08dcddff8b1f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B074.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB9227
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

Extract the resume sequence from sdma_v5_0_gfx_resume for
starting/restarting an individual instance.

Signed-off-by: Jiadong Zhu <Jiadong.Zhu@amd.com>
Acked-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c | 253 ++++++++++++++-----------
 1 file changed, 138 insertions(+), 115 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
index 3e48ea38385d..e813da1e48aa 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
@@ -705,14 +705,16 @@ static void sdma_v5_0_enable(struct amdgpu_device *adev, bool enable)
 }
 
 /**
- * sdma_v5_0_gfx_resume - setup and start the async dma engines
+ * sdma_v5_0_gfx_resume_instance - start/restart a certain sdma engine
  *
  * @adev: amdgpu_device pointer
+ * @i: instance
+ * @restore: used to restore wptr when restart
  *
- * Set up the gfx DMA ring buffers and enable them (NAVI10).
- * Returns 0 for success, error for failure.
+ * Set up the gfx DMA ring buffers and enable them. On restart, we will restore wptr and rptr.
+ * Return 0 for success.
  */
-static int sdma_v5_0_gfx_resume(struct amdgpu_device *adev)
+static int sdma_v5_0_gfx_resume_instance(struct amdgpu_device *adev, int i, bool restore)
 {
 	struct amdgpu_ring *ring;
 	u32 rb_cntl, ib_cntl;
@@ -722,142 +724,163 @@ static int sdma_v5_0_gfx_resume(struct amdgpu_device *adev)
 	u32 temp;
 	u32 wptr_poll_cntl;
 	u64 wptr_gpu_addr;
-	int i, r;
 
-	for (i = 0; i < adev->sdma.num_instances; i++) {
-		ring = &adev->sdma.instance[i].ring;
+	ring = &adev->sdma.instance[i].ring;
 
-		if (!amdgpu_sriov_vf(adev))
-			WREG32(sdma_v5_0_get_reg_offset(adev, i, mmSDMA0_SEM_WAIT_FAIL_TIMER_CNTL), 0);
+	if (!amdgpu_sriov_vf(adev))
+		WREG32(sdma_v5_0_get_reg_offset(adev, i, mmSDMA0_SEM_WAIT_FAIL_TIMER_CNTL), 0);
 
-		/* Set ring buffer size in dwords */
-		rb_bufsz = order_base_2(ring->ring_size / 4);
-		rb_cntl = RREG32_SOC15_IP(GC, sdma_v5_0_get_reg_offset(adev, i, mmSDMA0_GFX_RB_CNTL));
-		rb_cntl = REG_SET_FIELD(rb_cntl, SDMA0_GFX_RB_CNTL, RB_SIZE, rb_bufsz);
+	/* Set ring buffer size in dwords */
+	rb_bufsz = order_base_2(ring->ring_size / 4);
+	rb_cntl = RREG32_SOC15_IP(GC, sdma_v5_0_get_reg_offset(adev, i, mmSDMA0_GFX_RB_CNTL));
+	rb_cntl = REG_SET_FIELD(rb_cntl, SDMA0_GFX_RB_CNTL, RB_SIZE, rb_bufsz);
 #ifdef __BIG_ENDIAN
-		rb_cntl = REG_SET_FIELD(rb_cntl, SDMA0_GFX_RB_CNTL, RB_SWAP_ENABLE, 1);
-		rb_cntl = REG_SET_FIELD(rb_cntl, SDMA0_GFX_RB_CNTL,
-					RPTR_WRITEBACK_SWAP_ENABLE, 1);
+	rb_cntl = REG_SET_FIELD(rb_cntl, SDMA0_GFX_RB_CNTL, RB_SWAP_ENABLE, 1);
+	rb_cntl = REG_SET_FIELD(rb_cntl, SDMA0_GFX_RB_CNTL,
+				RPTR_WRITEBACK_SWAP_ENABLE, 1);
 #endif
-		WREG32_SOC15_IP(GC, sdma_v5_0_get_reg_offset(adev, i, mmSDMA0_GFX_RB_CNTL), rb_cntl);
-
-		/* Initialize the ring buffer's read and write pointers */
+	WREG32_SOC15_IP(GC, sdma_v5_0_get_reg_offset(adev, i, mmSDMA0_GFX_RB_CNTL), rb_cntl);
+
+	/* Initialize the ring buffer's read and write pointers */
+	if (restore) {
+		WREG32_SOC15_IP(GC, sdma_v5_0_get_reg_offset(adev, i, mmSDMA0_GFX_RB_RPTR), lower_32_bits(ring->wptr << 2));
+		WREG32_SOC15_IP(GC, sdma_v5_0_get_reg_offset(adev, i, mmSDMA0_GFX_RB_RPTR_HI), upper_32_bits(ring->wptr << 2));
+		WREG32_SOC15_IP(GC, sdma_v5_0_get_reg_offset(adev, i, mmSDMA0_GFX_RB_WPTR), lower_32_bits(ring->wptr << 2));
+		WREG32_SOC15_IP(GC, sdma_v5_0_get_reg_offset(adev, i, mmSDMA0_GFX_RB_WPTR_HI), upper_32_bits(ring->wptr << 2));
+	} else {
 		WREG32_SOC15_IP(GC, sdma_v5_0_get_reg_offset(adev, i, mmSDMA0_GFX_RB_RPTR), 0);
 		WREG32_SOC15_IP(GC, sdma_v5_0_get_reg_offset(adev, i, mmSDMA0_GFX_RB_RPTR_HI), 0);
 		WREG32_SOC15_IP(GC, sdma_v5_0_get_reg_offset(adev, i, mmSDMA0_GFX_RB_WPTR), 0);
 		WREG32_SOC15_IP(GC, sdma_v5_0_get_reg_offset(adev, i, mmSDMA0_GFX_RB_WPTR_HI), 0);
-
-		/* setup the wptr shadow polling */
-		wptr_gpu_addr = ring->wptr_gpu_addr;
-		WREG32_SOC15_IP(GC, sdma_v5_0_get_reg_offset(adev, i, mmSDMA0_GFX_RB_WPTR_POLL_ADDR_LO),
-		       lower_32_bits(wptr_gpu_addr));
-		WREG32_SOC15_IP(GC, sdma_v5_0_get_reg_offset(adev, i, mmSDMA0_GFX_RB_WPTR_POLL_ADDR_HI),
-		       upper_32_bits(wptr_gpu_addr));
-		wptr_poll_cntl = RREG32_SOC15_IP(GC, sdma_v5_0_get_reg_offset(adev, i,
-							 mmSDMA0_GFX_RB_WPTR_POLL_CNTL));
-		wptr_poll_cntl = REG_SET_FIELD(wptr_poll_cntl,
-					       SDMA0_GFX_RB_WPTR_POLL_CNTL,
-					       F32_POLL_ENABLE, 1);
-		WREG32_SOC15_IP(GC, sdma_v5_0_get_reg_offset(adev, i, mmSDMA0_GFX_RB_WPTR_POLL_CNTL),
-		       wptr_poll_cntl);
-
-		/* set the wb address whether it's enabled or not */
-		WREG32_SOC15_IP(GC, sdma_v5_0_get_reg_offset(adev, i, mmSDMA0_GFX_RB_RPTR_ADDR_HI),
-		       upper_32_bits(ring->rptr_gpu_addr) & 0xFFFFFFFF);
-		WREG32_SOC15_IP(GC, sdma_v5_0_get_reg_offset(adev, i, mmSDMA0_GFX_RB_RPTR_ADDR_LO),
-		       lower_32_bits(ring->rptr_gpu_addr) & 0xFFFFFFFC);
-
-		rb_cntl = REG_SET_FIELD(rb_cntl, SDMA0_GFX_RB_CNTL, RPTR_WRITEBACK_ENABLE, 1);
-
-		WREG32_SOC15_IP(GC, sdma_v5_0_get_reg_offset(adev, i, mmSDMA0_GFX_RB_BASE),
-		       ring->gpu_addr >> 8);
-		WREG32_SOC15_IP(GC, sdma_v5_0_get_reg_offset(adev, i, mmSDMA0_GFX_RB_BASE_HI),
-		       ring->gpu_addr >> 40);
-
+	}
+	/* setup the wptr shadow polling */
+	wptr_gpu_addr = ring->wptr_gpu_addr;
+	WREG32_SOC15_IP(GC, sdma_v5_0_get_reg_offset(adev, i, mmSDMA0_GFX_RB_WPTR_POLL_ADDR_LO),
+	       lower_32_bits(wptr_gpu_addr));
+	WREG32_SOC15_IP(GC, sdma_v5_0_get_reg_offset(adev, i, mmSDMA0_GFX_RB_WPTR_POLL_ADDR_HI),
+	       upper_32_bits(wptr_gpu_addr));
+	wptr_poll_cntl = RREG32_SOC15_IP(GC, sdma_v5_0_get_reg_offset(adev, i,
+						 mmSDMA0_GFX_RB_WPTR_POLL_CNTL));
+	wptr_poll_cntl = REG_SET_FIELD(wptr_poll_cntl,
+				       SDMA0_GFX_RB_WPTR_POLL_CNTL,
+				       F32_POLL_ENABLE, 1);
+	WREG32_SOC15_IP(GC, sdma_v5_0_get_reg_offset(adev, i, mmSDMA0_GFX_RB_WPTR_POLL_CNTL),
+	       wptr_poll_cntl);
+
+	/* set the wb address whether it's enabled or not */
+	WREG32_SOC15_IP(GC, sdma_v5_0_get_reg_offset(adev, i, mmSDMA0_GFX_RB_RPTR_ADDR_HI),
+	       upper_32_bits(ring->rptr_gpu_addr) & 0xFFFFFFFF);
+	WREG32_SOC15_IP(GC, sdma_v5_0_get_reg_offset(adev, i, mmSDMA0_GFX_RB_RPTR_ADDR_LO),
+	       lower_32_bits(ring->rptr_gpu_addr) & 0xFFFFFFFC);
+
+	rb_cntl = REG_SET_FIELD(rb_cntl, SDMA0_GFX_RB_CNTL, RPTR_WRITEBACK_ENABLE, 1);
+
+	WREG32_SOC15_IP(GC, sdma_v5_0_get_reg_offset(adev, i, mmSDMA0_GFX_RB_BASE),
+	       ring->gpu_addr >> 8);
+	WREG32_SOC15_IP(GC, sdma_v5_0_get_reg_offset(adev, i, mmSDMA0_GFX_RB_BASE_HI),
+	       ring->gpu_addr >> 40);
+
+	if (!restore)
 		ring->wptr = 0;
 
-		/* before programing wptr to a less value, need set minor_ptr_update first */
-		WREG32_SOC15_IP(GC, sdma_v5_0_get_reg_offset(adev, i, mmSDMA0_GFX_MINOR_PTR_UPDATE), 1);
+	/* before programing wptr to a less value, need set minor_ptr_update first */
+	WREG32_SOC15_IP(GC, sdma_v5_0_get_reg_offset(adev, i, mmSDMA0_GFX_MINOR_PTR_UPDATE), 1);
 
-		if (!amdgpu_sriov_vf(adev)) { /* only bare-metal use register write for wptr */
-			WREG32(sdma_v5_0_get_reg_offset(adev, i, mmSDMA0_GFX_RB_WPTR),
-			       lower_32_bits(ring->wptr << 2));
-			WREG32(sdma_v5_0_get_reg_offset(adev, i, mmSDMA0_GFX_RB_WPTR_HI),
-			       upper_32_bits(ring->wptr << 2));
-		}
+	if (!amdgpu_sriov_vf(adev)) { /* only bare-metal use register write for wptr */
+		WREG32(sdma_v5_0_get_reg_offset(adev, i, mmSDMA0_GFX_RB_WPTR),
+		       lower_32_bits(ring->wptr << 2));
+		WREG32(sdma_v5_0_get_reg_offset(adev, i, mmSDMA0_GFX_RB_WPTR_HI),
+		       upper_32_bits(ring->wptr << 2));
+	}
 
-		doorbell = RREG32_SOC15_IP(GC, sdma_v5_0_get_reg_offset(adev, i, mmSDMA0_GFX_DOORBELL));
-		doorbell_offset = RREG32_SOC15_IP(GC, sdma_v5_0_get_reg_offset(adev, i,
-						mmSDMA0_GFX_DOORBELL_OFFSET));
+	doorbell = RREG32_SOC15_IP(GC, sdma_v5_0_get_reg_offset(adev, i, mmSDMA0_GFX_DOORBELL));
+	doorbell_offset = RREG32_SOC15_IP(GC, sdma_v5_0_get_reg_offset(adev, i,
+					mmSDMA0_GFX_DOORBELL_OFFSET));
 
-		if (ring->use_doorbell) {
-			doorbell = REG_SET_FIELD(doorbell, SDMA0_GFX_DOORBELL, ENABLE, 1);
-			doorbell_offset = REG_SET_FIELD(doorbell_offset, SDMA0_GFX_DOORBELL_OFFSET,
-					OFFSET, ring->doorbell_index);
-		} else {
-			doorbell = REG_SET_FIELD(doorbell, SDMA0_GFX_DOORBELL, ENABLE, 0);
-		}
-		WREG32_SOC15_IP(GC, sdma_v5_0_get_reg_offset(adev, i, mmSDMA0_GFX_DOORBELL), doorbell);
-		WREG32_SOC15_IP(GC, sdma_v5_0_get_reg_offset(adev, i, mmSDMA0_GFX_DOORBELL_OFFSET),
-		       doorbell_offset);
+	if (ring->use_doorbell) {
+		doorbell = REG_SET_FIELD(doorbell, SDMA0_GFX_DOORBELL, ENABLE, 1);
+		doorbell_offset = REG_SET_FIELD(doorbell_offset, SDMA0_GFX_DOORBELL_OFFSET,
+				OFFSET, ring->doorbell_index);
+	} else {
+		doorbell = REG_SET_FIELD(doorbell, SDMA0_GFX_DOORBELL, ENABLE, 0);
+	}
+	WREG32_SOC15_IP(GC, sdma_v5_0_get_reg_offset(adev, i, mmSDMA0_GFX_DOORBELL), doorbell);
+	WREG32_SOC15_IP(GC, sdma_v5_0_get_reg_offset(adev, i, mmSDMA0_GFX_DOORBELL_OFFSET),
+	       doorbell_offset);
 
-		adev->nbio.funcs->sdma_doorbell_range(adev, i, ring->use_doorbell,
-						      ring->doorbell_index, 20);
+	adev->nbio.funcs->sdma_doorbell_range(adev, i, ring->use_doorbell,
+					      ring->doorbell_index, 20);
 
-		if (amdgpu_sriov_vf(adev))
-			sdma_v5_0_ring_set_wptr(ring);
+	if (amdgpu_sriov_vf(adev))
+		sdma_v5_0_ring_set_wptr(ring);
 
-		/* set minor_ptr_update to 0 after wptr programed */
-		WREG32_SOC15_IP(GC, sdma_v5_0_get_reg_offset(adev, i, mmSDMA0_GFX_MINOR_PTR_UPDATE), 0);
+	/* set minor_ptr_update to 0 after wptr programed */
+	WREG32_SOC15_IP(GC, sdma_v5_0_get_reg_offset(adev, i, mmSDMA0_GFX_MINOR_PTR_UPDATE), 0);
 
-		if (!amdgpu_sriov_vf(adev)) {
-			/* set utc l1 enable flag always to 1 */
-			temp = RREG32(sdma_v5_0_get_reg_offset(adev, i, mmSDMA0_CNTL));
-			temp = REG_SET_FIELD(temp, SDMA0_CNTL, UTC_L1_ENABLE, 1);
-
-			/* enable MCBP */
-			temp = REG_SET_FIELD(temp, SDMA0_CNTL, MIDCMD_PREEMPT_ENABLE, 1);
-			WREG32(sdma_v5_0_get_reg_offset(adev, i, mmSDMA0_CNTL), temp);
-
-			/* Set up RESP_MODE to non-copy addresses */
-			temp = RREG32(sdma_v5_0_get_reg_offset(adev, i, mmSDMA0_UTCL1_CNTL));
-			temp = REG_SET_FIELD(temp, SDMA0_UTCL1_CNTL, RESP_MODE, 3);
-			temp = REG_SET_FIELD(temp, SDMA0_UTCL1_CNTL, REDO_DELAY, 9);
-			WREG32(sdma_v5_0_get_reg_offset(adev, i, mmSDMA0_UTCL1_CNTL), temp);
-
-			/* program default cache read and write policy */
-			temp = RREG32(sdma_v5_0_get_reg_offset(adev, i, mmSDMA0_UTCL1_PAGE));
-			/* clean read policy and write policy bits */
-			temp &= 0xFF0FFF;
-			temp |= ((CACHE_READ_POLICY_L2__DEFAULT << 12) | (CACHE_WRITE_POLICY_L2__DEFAULT << 14));
-			WREG32(sdma_v5_0_get_reg_offset(adev, i, mmSDMA0_UTCL1_PAGE), temp);
-		}
+	if (!amdgpu_sriov_vf(adev)) {
+		/* set utc l1 enable flag always to 1 */
+		temp = RREG32(sdma_v5_0_get_reg_offset(adev, i, mmSDMA0_CNTL));
+		temp = REG_SET_FIELD(temp, SDMA0_CNTL, UTC_L1_ENABLE, 1);
+
+		/* enable MCBP */
+		temp = REG_SET_FIELD(temp, SDMA0_CNTL, MIDCMD_PREEMPT_ENABLE, 1);
+		WREG32(sdma_v5_0_get_reg_offset(adev, i, mmSDMA0_CNTL), temp);
+
+		/* Set up RESP_MODE to non-copy addresses */
+		temp = RREG32(sdma_v5_0_get_reg_offset(adev, i, mmSDMA0_UTCL1_CNTL));
+		temp = REG_SET_FIELD(temp, SDMA0_UTCL1_CNTL, RESP_MODE, 3);
+		temp = REG_SET_FIELD(temp, SDMA0_UTCL1_CNTL, REDO_DELAY, 9);
+		WREG32(sdma_v5_0_get_reg_offset(adev, i, mmSDMA0_UTCL1_CNTL), temp);
+
+		/* program default cache read and write policy */
+		temp = RREG32(sdma_v5_0_get_reg_offset(adev, i, mmSDMA0_UTCL1_PAGE));
+		/* clean read policy and write policy bits */
+		temp &= 0xFF0FFF;
+		temp |= ((CACHE_READ_POLICY_L2__DEFAULT << 12) | (CACHE_WRITE_POLICY_L2__DEFAULT << 14));
+		WREG32(sdma_v5_0_get_reg_offset(adev, i, mmSDMA0_UTCL1_PAGE), temp);
+	}
 
-		if (!amdgpu_sriov_vf(adev)) {
-			/* unhalt engine */
-			temp = RREG32(sdma_v5_0_get_reg_offset(adev, i, mmSDMA0_F32_CNTL));
-			temp = REG_SET_FIELD(temp, SDMA0_F32_CNTL, HALT, 0);
-			WREG32(sdma_v5_0_get_reg_offset(adev, i, mmSDMA0_F32_CNTL), temp);
-		}
+	if (!amdgpu_sriov_vf(adev)) {
+		/* unhalt engine */
+		temp = RREG32(sdma_v5_0_get_reg_offset(adev, i, mmSDMA0_F32_CNTL));
+		temp = REG_SET_FIELD(temp, SDMA0_F32_CNTL, HALT, 0);
+		WREG32(sdma_v5_0_get_reg_offset(adev, i, mmSDMA0_F32_CNTL), temp);
+	}
 
-		/* enable DMA RB */
-		rb_cntl = REG_SET_FIELD(rb_cntl, SDMA0_GFX_RB_CNTL, RB_ENABLE, 1);
-		WREG32_SOC15_IP(GC, sdma_v5_0_get_reg_offset(adev, i, mmSDMA0_GFX_RB_CNTL), rb_cntl);
+	/* enable DMA RB */
+	rb_cntl = REG_SET_FIELD(rb_cntl, SDMA0_GFX_RB_CNTL, RB_ENABLE, 1);
+	WREG32_SOC15_IP(GC, sdma_v5_0_get_reg_offset(adev, i, mmSDMA0_GFX_RB_CNTL), rb_cntl);
 
-		ib_cntl = RREG32_SOC15_IP(GC, sdma_v5_0_get_reg_offset(adev, i, mmSDMA0_GFX_IB_CNTL));
-		ib_cntl = REG_SET_FIELD(ib_cntl, SDMA0_GFX_IB_CNTL, IB_ENABLE, 1);
+	ib_cntl = RREG32_SOC15_IP(GC, sdma_v5_0_get_reg_offset(adev, i, mmSDMA0_GFX_IB_CNTL));
+	ib_cntl = REG_SET_FIELD(ib_cntl, SDMA0_GFX_IB_CNTL, IB_ENABLE, 1);
 #ifdef __BIG_ENDIAN
-		ib_cntl = REG_SET_FIELD(ib_cntl, SDMA0_GFX_IB_CNTL, IB_SWAP_ENABLE, 1);
+	ib_cntl = REG_SET_FIELD(ib_cntl, SDMA0_GFX_IB_CNTL, IB_SWAP_ENABLE, 1);
 #endif
-		/* enable DMA IBs */
-		WREG32_SOC15_IP(GC, sdma_v5_0_get_reg_offset(adev, i, mmSDMA0_GFX_IB_CNTL), ib_cntl);
+	/* enable DMA IBs */
+	WREG32_SOC15_IP(GC, sdma_v5_0_get_reg_offset(adev, i, mmSDMA0_GFX_IB_CNTL), ib_cntl);
 
-		if (amdgpu_sriov_vf(adev)) { /* bare-metal sequence doesn't need below to lines */
-			sdma_v5_0_ctx_switch_enable(adev, true);
-			sdma_v5_0_enable(adev, true);
-		}
+	if (amdgpu_sriov_vf(adev)) { /* bare-metal sequence doesn't need below to lines */
+		sdma_v5_0_ctx_switch_enable(adev, true);
+		sdma_v5_0_enable(adev, true);
+	}
+
+	return amdgpu_ring_test_helper(ring);
+}
 
-		r = amdgpu_ring_test_helper(ring);
+/**
+ * sdma_v5_0_gfx_resume - setup and start the async dma engines
+ *
+ * @adev: amdgpu_device pointer
+ *
+ * Set up the gfx DMA ring buffers and enable them (NAVI10).
+ * Returns 0 for success, error for failure.
+ */
+static int sdma_v5_0_gfx_resume(struct amdgpu_device *adev)
+{
+	int i, r;
+
+	for (i = 0; i < adev->sdma.num_instances; i++) {
+		r = sdma_v5_0_gfx_resume_instance(adev, i, false);
 		if (r)
 			return r;
 	}
-- 
2.25.1

