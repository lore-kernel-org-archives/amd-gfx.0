Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A265BCF58D1
	for <amd-gfx@archiver.kernel.org>; Fri, 20 Sep 2024 06:31:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 558DD10E7AB;
	Fri, 20 Sep 2024 06:31:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ncFkOCB+";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2079.outbound.protection.outlook.com [40.107.93.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BA17310E7AA
 for <amd-gfx@lists.freedesktop.org>; Fri, 20 Sep 2024 06:31:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Zge2yrtJ0Obh4ThvFa+qxJwdE9DofvlaCYdlhrLcx0Dtim7U9zPrrGWzd92LITQpFCLuxg6A79nE2n36ld+TKhM3uMv4lNNUrQycQ6mDuuEpbcz+uxLzAT4trnaU+ngPJ/+9rLqjSfN4DzzeIdmJfOp5wL/BT+5hIDvjkXZ2sHeQExbp7pIC9Jdsj0Otv8Y4H/nPSUx6+3G8FZ0+Qf/3Os35DY6U71qns6OZKkoqJVGwv5c8Pot67gLm0htViDXAACb8pZX+wM3/2S/3w8aC9wG0GNSaDudiDRCHGQcFCoGWndVxi/iummZImIOM5DR1lLO9b8qBG5bcgkFXxxrLcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kpbbdfaecq44t17zrAhj1sJ9ekO2QQaEm1CAhdeuIh4=;
 b=OR2ccdABJHk/+iCYWO9CdX527Chc8Z1wmXdvVXdbZnk0O33J9HKH7Ge3lQkZN0rGHfarbMh9ZKvDVK3CUCqH3PIC2j/qcSRM/xPkTzbsvF7pCCW3NTxtNevcr1FSzAdm+wUIDj3QW05HNA6sO45iA0gaTVnB6IRYjYtT2Pp/4QlXUvZcIxCnOtp4ULHt4RHqmjA7R8Kw18oJ9ndfOnYvHWVgYrHlrK1B2li6VH4RafzPMKOVMmPf7NVcEjMZ0iORviSkiLbYD5ZyHX6hfq9VXf6X/SftkOFRbzkO4wh2QIxhISf88ubbyIhBq4BKHqVT2404zLXuqrZMKyEtqAvjbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kpbbdfaecq44t17zrAhj1sJ9ekO2QQaEm1CAhdeuIh4=;
 b=ncFkOCB+47QrJgz6YJf/kLP/kEt/mTTrhVzqINanm130lwMKUvBnif0++45gdfGR+OpabcSa1itfmIWhbAsQ+5yBCpp+W+v2TpvE/IMYNfdOrBHMiNB1l1/d6x/WjgpYW4VoZXPkU8zfOoiGx0BKycKGOnfhRLe7zuaQGwbkhmE=
Received: from MN2PR16CA0024.namprd16.prod.outlook.com (2603:10b6:208:134::37)
 by DS0PR12MB8414.namprd12.prod.outlook.com (2603:10b6:8:fb::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7962.24; Fri, 20 Sep 2024 06:31:35 +0000
Received: from MN1PEPF0000F0E4.namprd04.prod.outlook.com
 (2603:10b6:208:134:cafe::e2) by MN2PR16CA0024.outlook.office365.com
 (2603:10b6:208:134::37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.22 via Frontend
 Transport; Fri, 20 Sep 2024 06:31:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MN1PEPF0000F0E4.mail.protection.outlook.com (10.167.242.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7918.13 via Frontend Transport; Fri, 20 Sep 2024 06:31:34 +0000
Received: from jenkins-jiadong-1.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 20 Sep 2024 01:31:33 -0500
From: <jiadong.zhu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <alexander.deucher@amd.com>, Jiadong Zhu <Jiadong.Zhu@amd.com>
Subject: [PATCH 1/4] drm/amdgpu/sdma5: split out per instance resume function
Date: Fri, 20 Sep 2024 14:31:09 +0800
Message-ID: <20240920063112.370961-1-jiadong.zhu@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0E4:EE_|DS0PR12MB8414:EE_
X-MS-Office365-Filtering-Correlation-Id: 91d3324c-19b4-46f6-42de-08dcd93ddfb0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?4FBR4qL5ww/wyRO7b2HVcOnpIyrynkmYj+NllqXw/wynYaRQDLN7CczgyLLy?=
 =?us-ascii?Q?Udv/2twu8eV5ClUV8rTESN70r75zgHR+/OpGBm3I6YesCmkDHqQMw1MwKhpw?=
 =?us-ascii?Q?81iGhlQtgpAPM26hhPEG41UzMc+VjX4zDZXC95zEFw+3j1jyHy6lAB/wmfSo?=
 =?us-ascii?Q?8h8iY+AQLGeI4SrUCW/Aeo/c1KaGrc25dfpvJIJWa/s4ZuEl7XZWq/P+6Y4W?=
 =?us-ascii?Q?FAsGnO7F2XH6Hf3uegjkg2rD6Fc9Ha51SqYfFNlSi/NB+DPv25WxFp0jbKK3?=
 =?us-ascii?Q?Sw8tCL1eOR5dtMkr9TsqpUyTeL0P7y/hobmtvhxJrAEkjplPUYnSQ2ZHcDcR?=
 =?us-ascii?Q?6xzocdJ8uSB0Hqn7M2mu16sIJxYPuRKF4tw21TTfT2Ycc9NhVq1sOzoNMgwA?=
 =?us-ascii?Q?NvM1RGfdL3JYxMgzS08fPyM6k5P8lwyxHODUnRbwGULpTm/SDbXGU87Nru2e?=
 =?us-ascii?Q?YbQ0hw672EdABlsJbdG8NDjire1tvCsHbHtNaMSDnSQhBU8WJSNv6R1yao37?=
 =?us-ascii?Q?EvCUcW3G0WEtDTeGhtrbUmB9dz1XjiSVFuZUmEIdXbFZTWSWH6dzUByn5JqY?=
 =?us-ascii?Q?4Hy0QW9crIpMGAZ7P7xdmOsTbW5RwKipqlo7lUK02RphX1i0WxHwpn805J9F?=
 =?us-ascii?Q?ygRGVPzkUhTuryywdK1MQEtgD5hqukHv+IonQPMZeJIXkNeuO6ivoQFrNi9U?=
 =?us-ascii?Q?qs0uoYCiWpGDNDetX6TQ7SPnRzIXW6BDAazeioSwN7fPowoV6XdoY2Ksc7af?=
 =?us-ascii?Q?wb5b8m06Yu4bEh+pKWqQpth5DwqVRL3tJl4r9Vk4Ir0L+Ut/6f+lc0VsN/y+?=
 =?us-ascii?Q?DhKhlLXFJAaQEFnhh7xFaBHmsTK0rX2NSM+tMW6mJhn2rS3QCF7C8dZdNOhl?=
 =?us-ascii?Q?cecNp1wo5jfmkBYmP09ZOIOLJ9oO/qbrD8YnBfSO35VdayXiYZTLLMCSqNwd?=
 =?us-ascii?Q?3w/c94IlkPgqXUw0zmsT0PLQGR7JmluHb+aQ2TIo4KhpEuFnI2bSW83nhW1g?=
 =?us-ascii?Q?JKZccCU5mQpDcHmNZSkGnkvwBSb0Rtm8PixnxeMrNQ8TDNnJaUeBjt9mE7lQ?=
 =?us-ascii?Q?y/+y7b5po0kBMozend6imFpE3QQOWGns2opNKGrh5Gvh86GGc5VpadbCHqUZ?=
 =?us-ascii?Q?6+ee52XQ7MnO5PO8TKpHipo8cge/FNRLZDFvoQ0kXSMBWte30BJEQ/Abl4bb?=
 =?us-ascii?Q?/exM5bGZxwQYQ1e/qQt9gWIS5MBbobTCBWDdFKsvTk9N0Wnl24ty80U84q6I?=
 =?us-ascii?Q?WGakPA+P7MEOBe/KQ26fCAnCEUK6TLRZ+LznrnO+cKhc0Nim6dlv2wl3dHzc?=
 =?us-ascii?Q?SkGw0XWUPFduiW6KQ2WjbiBpri2hnXWQCtAemxnkNQEVO7PNwI/TEyJT5E/E?=
 =?us-ascii?Q?P8Uw0lI=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Sep 2024 06:31:34.7464 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 91d3324c-19b4-46f6-42de-08dcd93ddfb0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000F0E4.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8414
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

