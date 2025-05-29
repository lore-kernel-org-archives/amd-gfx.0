Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A55BC5B543
	for <amd-gfx@archiver.kernel.org>; Thu, 29 May 2025 20:08:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3B47310E25B;
	Thu, 29 May 2025 20:08:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="c6evHPPn";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2048.outbound.protection.outlook.com [40.107.244.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3E88710E221
 for <amd-gfx@lists.freedesktop.org>; Thu, 29 May 2025 20:08:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OiwgDEK4sgdnQSLarJJWBO7KfG9ijLSlYQiXHClefV6HK4mbd2sE2IJ5jiEP0IYiR4L/MRaKsfHojLdTyJ7eZHwco+i26a5xPdpw0YwY+yTTcLD9HsimY0N+K/Lg3BHOOGqalvzSrqX55FIJzfy9rNNIA8Rgk58yVrh/PFdYZ4TD1vs9KtIucKR2AL1GCkff9qwNrV4Br3TCiqaq9zZ9Z5c/qmvXlM0Wp7GIynC5h+NbbMv8pab1QCdXoI+6gbrjwQV5pNbk7rci1cEr5FGdONP1eiks2ydvI10TKw4oKDfj4sgcI/XdBj1dKYXFbmvXZt6mbeM+uEMZ+dUUV2I4oQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R6EEB1MtKOFZNktxIn5psSozCBcmOkybPxCmL8XAm0s=;
 b=jI2I2utra02LCh4QrIlm03Za3+4q8fdvT92RsxRTYzlRpYxYBi6utU3VcxFgKDLw92f6uMIwdoRvYzmdrDQ44E5ct/PAfVw5fmg6nWxNpKfqrRrjreISG1DVOf5bN1dYJjnFEVcmiWFlfbVfq7ioXMCnoUmwtkcukn3TgUNnCMVWtp53sC5CZQdAGet1cHtSR+TjkYywQRCEZCbj5RzS4vy877WnWEn+WuvKiYcUMnQ4gzUTIIyFaSlQVlYbeXKyOiIZZETmA7EH5fbe3wYCLMQxJx+jQA9s7kmoH/9Z3Udx8Fup8PPVuWe985kdWHJdirUxqA7izyAxDz9e3YFHNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R6EEB1MtKOFZNktxIn5psSozCBcmOkybPxCmL8XAm0s=;
 b=c6evHPPnqARbx3kd5GmLfxapkr9e07wkbqWRHtM/mlwlnAyszFJiSz/zIbE/FVx7nbesSnJuavO3Vd84nncvEe8jg1JT4mUUlFT9fUPwU8sOfJj4RxJbBAGnbd/fDakRMplwnrgN2SXCSarBoe4DCVF6R/818tG0/KQb2+GxiRc=
Received: from MW4P220CA0007.NAMP220.PROD.OUTLOOK.COM (2603:10b6:303:115::12)
 by PH7PR12MB9076.namprd12.prod.outlook.com (2603:10b6:510:2f6::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.30; Thu, 29 May
 2025 20:08:21 +0000
Received: from SJ1PEPF000026C6.namprd04.prod.outlook.com
 (2603:10b6:303:115:cafe::db) by MW4P220CA0007.outlook.office365.com
 (2603:10b6:303:115::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8769.18 via Frontend Transport; Thu,
 29 May 2025 20:08:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF000026C6.mail.protection.outlook.com (10.167.244.103) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8769.18 via Frontend Transport; Thu, 29 May 2025 20:08:20 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 29 May
 2025 15:08:18 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 03/28] drm/amdgpu/gfx8: drop reset_kgq
Date: Thu, 29 May 2025 16:07:33 -0400
Message-ID: <20250529200758.6326-4-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250529200758.6326-1-alexander.deucher@amd.com>
References: <20250529200758.6326-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000026C6:EE_|PH7PR12MB9076:EE_
X-MS-Office365-Filtering-Correlation-Id: da5c0a66-0508-489c-2a00-08dd9eec8f4e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?5D0IXv9K54HDOKlVIt/xyq8lVP825bLBCBS0Iy/us/GrmohwGcoctKFU+k4Z?=
 =?us-ascii?Q?oNe1kMke8dc5qXTuxTg6MYNO7w3H6dOifopujefYFe6PChVJVJbocDB79Q8c?=
 =?us-ascii?Q?yyuX8UTLbd9ODX9kBfULXX0EiCjez+eGibjFmgzx9ejKHwzSWdTQA6U+INov?=
 =?us-ascii?Q?WZzn1YNuR1kkvomlnm0Axe2LqybC2qgQSvtk4wPfpt1f5NCSEhZ9fuhT3Rej?=
 =?us-ascii?Q?cbrmHW7dzIFPAfGc8NvopKdqrUdbL2VSuoFuzSNIosv/jR8NJC8r3EKUWAS7?=
 =?us-ascii?Q?P8TWjL0xZkoSCJ7go8P0T6HJHKcNSZ98f8K4Y/gwozUM/gpa/RL0u+U3P01r?=
 =?us-ascii?Q?UmDG0d6PZqYqoMkzkRyF2EaQNvsQdzBgJt3xZUn3atx2guobKrfyPmprGPWh?=
 =?us-ascii?Q?q/KfF2mlA274pNhBLdlKZFnafIDrqUIKu4HyHTWSzplP2gvKEm8zGT4czRsD?=
 =?us-ascii?Q?14X44ahmJG6PQnPIsHDnySc1Dk9+pDHLDRxfoWLtiE7I25TYJB4SQpnc99zD?=
 =?us-ascii?Q?qFmefhCexE9yHi52das1Kjw3rf/wLKojh7h3ZwcsGtawz5TlO2SxtlICTTtD?=
 =?us-ascii?Q?b7Qa4OlXeDyTmrSaKGQqi1BhvV3pm/8v13J9EleHv9MeaqeXvdmJ7yBFWn22?=
 =?us-ascii?Q?F1QXzJNZbRtOFnloVRJk96tWLOunNEdRNa8phtEIFJP95I9KlJDQDDh5hlZn?=
 =?us-ascii?Q?lGCSpsnHHOXS0T6fc8oaE7UquP1ZGyw6FxJfoHHAeRMBR7OV05eJKQyWRrib?=
 =?us-ascii?Q?u1QJMX9Brx5kGApT79Z6w30tD3KkZiziI9yUN/2vloWrEiuXkbzl9glOnPfV?=
 =?us-ascii?Q?ioJKXtMhZa7CZeZL+H3hlxxn+CRCLFhcBZBvJ0pKyzKtg7El8NKBo918hzRV?=
 =?us-ascii?Q?hRQxrGJTU7vNqu+Phwn8Oblvrj10Sfz3QjNXYOA8Eq44zjDQSg2+yjEmAdZx?=
 =?us-ascii?Q?BzYIPfk32NV5iOG9lB1Z0SmeX7XMt2hbsPwsoL+MoRPmgWbiUuKh5nkLM0Ou?=
 =?us-ascii?Q?qtq86whY1hXRyT6ppxgBaDK31GaUFvK9vPqXVuRkABR+zoKgYZ1N8b34w/KV?=
 =?us-ascii?Q?SUBwwX/Ilqx7hl/JYG9tdyO3h8/3x+8bT/7Aj4AfjcRhSrIoVxbXs54SoI1+?=
 =?us-ascii?Q?3QXeHHEvVSfbeZ8NHF7CmSj4yh132D0BvBM9gpLnDFpPF68oODMJ97cK/5ec?=
 =?us-ascii?Q?brjFzIGd9xEitpdCuQsipTbCyBmYghnOB5F3zwzZnbNEN6KAaKOnIL69b+7x?=
 =?us-ascii?Q?sdECGGJigOUlMUnAVO4KGoEqDNinz7c+A+DSEYCt2uxFykVGIiWDDXbfD3of?=
 =?us-ascii?Q?st/Nl6I1JY4tJtizkcFsKlNATRZjRC15D41NPlUo7Ljl3wsGEAKVhmKu+3iy?=
 =?us-ascii?Q?8EzvKr4olEtRoMgOEuFSzguIf2v69OrI2oqC2vevE9WpNORbCSWJRbl2aj09?=
 =?us-ascii?Q?z4Pg+F2PXx/oGLg39/p6sozUBUZLm88qjL32YObymuaCrj2795UpECvliupX?=
 =?us-ascii?Q?I4eJBkvxNXALqW4f/SAAyWLL5aJ+YFZCjKHi?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2025 20:08:20.8948 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: da5c0a66-0508-489c-2a00-08dd9eec8f4e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000026C6.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9076
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

It doesn't work reliably and we have soft recover and
full adapter reset so drop this.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c | 71 ---------------------------
 1 file changed, 71 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
index 5ee2237d8ee8f..68c401ecb3eca 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
@@ -6339,34 +6339,6 @@ static void gfx_v8_0_ring_emit_wreg(struct amdgpu_ring *ring, uint32_t reg,
 	amdgpu_ring_write(ring, val);
 }
 
-static void gfx_v8_0_wait_reg_mem(struct amdgpu_ring *ring, int eng_sel,
-				  int mem_space, int opt, uint32_t addr0,
-				  uint32_t addr1, uint32_t ref, uint32_t mask,
-				  uint32_t inv)
-{
-	amdgpu_ring_write(ring, PACKET3(PACKET3_WAIT_REG_MEM, 5));
-	amdgpu_ring_write(ring,
-			  /* memory (1) or register (0) */
-			  (WAIT_REG_MEM_MEM_SPACE(mem_space) |
-			   WAIT_REG_MEM_OPERATION(opt) | /* wait */
-			   WAIT_REG_MEM_FUNCTION(3) |  /* equal */
-			   WAIT_REG_MEM_ENGINE(eng_sel)));
-
-	if (mem_space)
-		BUG_ON(addr0 & 0x3); /* Dword align */
-	amdgpu_ring_write(ring, addr0);
-	amdgpu_ring_write(ring, addr1);
-	amdgpu_ring_write(ring, ref);
-	amdgpu_ring_write(ring, mask);
-	amdgpu_ring_write(ring, inv); /* poll interval */
-}
-
-static void gfx_v8_0_ring_emit_reg_wait(struct amdgpu_ring *ring, uint32_t reg,
-					uint32_t val, uint32_t mask)
-{
-	gfx_v8_0_wait_reg_mem(ring, 0, 0, 0, reg, 0, val, mask, 0x20);
-}
-
 static void gfx_v8_0_ring_soft_recovery(struct amdgpu_ring *ring, unsigned vmid)
 {
 	struct amdgpu_device *adev = ring->adev;
@@ -6843,48 +6815,6 @@ static void gfx_v8_0_emit_wave_limit(struct amdgpu_ring *ring, bool enable)
 
 }
 
-static int gfx_v8_0_reset_kgq(struct amdgpu_ring *ring, unsigned int vmid)
-{
-	struct amdgpu_device *adev = ring->adev;
-	struct amdgpu_kiq *kiq = &adev->gfx.kiq[0];
-	struct amdgpu_ring *kiq_ring = &kiq->ring;
-	unsigned long flags;
-	u32 tmp;
-	int r;
-
-	if (amdgpu_sriov_vf(adev))
-		return -EINVAL;
-
-	if (!kiq->pmf || !kiq->pmf->kiq_unmap_queues)
-		return -EINVAL;
-
-	spin_lock_irqsave(&kiq->ring_lock, flags);
-
-	if (amdgpu_ring_alloc(kiq_ring, 5)) {
-		spin_unlock_irqrestore(&kiq->ring_lock, flags);
-		return -ENOMEM;
-	}
-
-	tmp = REG_SET_FIELD(0, CP_VMID_RESET, RESET_REQUEST, 1 << vmid);
-	gfx_v8_0_ring_emit_wreg(kiq_ring, mmCP_VMID_RESET, tmp);
-	amdgpu_ring_commit(kiq_ring);
-
-	spin_unlock_irqrestore(&kiq->ring_lock, flags);
-
-	r = amdgpu_ring_test_ring(kiq_ring);
-	if (r)
-		return r;
-
-	if (amdgpu_ring_alloc(ring, 7 + 12 + 5))
-		return -ENOMEM;
-	gfx_v8_0_ring_emit_fence_gfx(ring, ring->fence_drv.gpu_addr,
-				     ring->fence_drv.sync_seq, AMDGPU_FENCE_FLAG_EXEC);
-	gfx_v8_0_ring_emit_reg_wait(ring, mmCP_VMID_RESET, 0, 0xffff);
-	gfx_v8_0_ring_emit_wreg(ring, mmCP_VMID_RESET, 0);
-
-	return amdgpu_ring_test_ring(ring);
-}
-
 static const struct amd_ip_funcs gfx_v8_0_ip_funcs = {
 	.name = "gfx_v8_0",
 	.early_init = gfx_v8_0_early_init,
@@ -6950,7 +6880,6 @@ static const struct amdgpu_ring_funcs gfx_v8_0_ring_funcs_gfx = {
 	.emit_wreg = gfx_v8_0_ring_emit_wreg,
 	.soft_recovery = gfx_v8_0_ring_soft_recovery,
 	.emit_mem_sync = gfx_v8_0_emit_mem_sync,
-	.reset = gfx_v8_0_reset_kgq,
 };
 
 static const struct amdgpu_ring_funcs gfx_v8_0_ring_funcs_compute = {
-- 
2.49.0

