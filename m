Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8AD5C3ABB2
	for <amd-gfx@archiver.kernel.org>; Wed, 28 May 2025 17:28:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 78E2310E6BA;
	Wed, 28 May 2025 17:28:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="FyIzigA5";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2052.outbound.protection.outlook.com [40.107.93.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8691110E6C9
 for <amd-gfx@lists.freedesktop.org>; Wed, 28 May 2025 17:28:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GYtIro29rch8ioAjtVCVl28U6nExREkXEhMHdfdw4Lc+jRnv8XfTGBzTAjQ1YMUi7XsmP/TTydzNYU/gZUgQkwDjMTVI1fByYBcCsKjJdtyRFvj5J0JTmSg58acPo8T7FS9H9fdbkkque09RS0jaOxxymDMJi9VsZY9NoyKbcEw30wUhkUFsETlkvfV5uRUmc7q2EgGaKttXIwrkYkCkodxZR5sLxh2zlbgJysa/7Zh9qEuH29KXzFA6TKT2OtycSlpU9a9Dllh3UCG070hYB5PrB+eR6eAoQeZzzlTsZqr3vUTyLo9FIuWDU+1pw+rd7vFWl+VOv0sNI9IhOtxrYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R6EEB1MtKOFZNktxIn5psSozCBcmOkybPxCmL8XAm0s=;
 b=OQHOsvtVD/7uEebcsPPUD7GcMMLDPHT3miokjTENcGHIhKFSkV/gkE7pJ/hbKxwtOyexp2ULkuhZc+53WjMcXrL0UtpD4et/gf+qFfrRa90VOVeXzr1u5GU9kA7qOyQReyRauWTLss7rblihvtjYyM8EJ/OEc9C0LQiJPhYq8ev2eURGBJ46W6IRu3VmW86FF18gCeMCKXaiO/qxijHMIinQM5V2s7K7rcTxffmqtxsOGU9D+3zxjB0uftVrGRbiWLeK2nXhifGQ2fXFa4l3mOBFf4pMeahNLhhUcGkHhroJP9Ady+QFdcPeRV44qdFtmZoRd/yOI/9H2Spw3jtXUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R6EEB1MtKOFZNktxIn5psSozCBcmOkybPxCmL8XAm0s=;
 b=FyIzigA5o/2t3+H1DMkFrXCrLFZeagM63hrWyPtjJPtet6Jyh54UdU9wi737ISE3qHHEVTLoi24JkWW9LgjNHeP75V1g/JHX6xn/+bj5s27u5qU7QsjOGUBFE/JPV2JCHMQZ1YAkjbpIW0FsonOhCOxYM0ik96sn2wt5SCmHlEk=
Received: from BL1P222CA0021.NAMP222.PROD.OUTLOOK.COM (2603:10b6:208:2c7::26)
 by CH3PR12MB7714.namprd12.prod.outlook.com (2603:10b6:610:14e::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.25; Wed, 28 May
 2025 17:28:20 +0000
Received: from BL6PEPF00022573.namprd02.prod.outlook.com
 (2603:10b6:208:2c7:cafe::1a) by BL1P222CA0021.outlook.office365.com
 (2603:10b6:208:2c7::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8769.19 via Frontend Transport; Wed,
 28 May 2025 17:28:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF00022573.mail.protection.outlook.com (10.167.249.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8769.18 via Frontend Transport; Wed, 28 May 2025 17:28:20 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 28 May
 2025 12:28:17 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 05/16] drm/amdgpu/gfx8: drop reset_kgq
Date: Wed, 28 May 2025 13:27:50 -0400
Message-ID: <20250528172801.34424-6-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250528172801.34424-1-alexander.deucher@amd.com>
References: <20250528172801.34424-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00022573:EE_|CH3PR12MB7714:EE_
X-MS-Office365-Filtering-Correlation-Id: 84285f99-40f0-45ef-b31e-08dd9e0d0aaa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?iaDjGjZCHxsG8U9HRPuK7UOhX+jJt/J1As58fDfv+CUWJgmPVYqdJOWBd4Et?=
 =?us-ascii?Q?GQEoLFuDrxbZFLuS9QodgOH274y0V7tlGjE8zvtwAj04+q6mYt4S3Io1lvNy?=
 =?us-ascii?Q?CDdMq5y8/WN0BjP3lebc2XpPFKLVaBEtXHfsvsTzMxD7/ORd/ekg4tSFK0I9?=
 =?us-ascii?Q?8O+nlYC9y9WIdlIvWijiahvDPIna3lc2YVTBZWxsdEe4VrXjk03Ss2Pm6NUd?=
 =?us-ascii?Q?0TCX55fmu+r4i+WTIZKaZ2a/tbI+88OdmhVMaJ+RU2GWavh6dgnenzw0xt3G?=
 =?us-ascii?Q?6w538fZOA79cmOjIV9lPogGqLUnt1OWvSs7uE1S3dc5/WI4CB40ccy2Q861h?=
 =?us-ascii?Q?0M5z4Wh1GC9G8EbfZAceF7ixkSTJOGtwnlZdlv/cq2H0St7qcqhEByDQEMnq?=
 =?us-ascii?Q?POZb+mW03b/TvT755EmWe6soW5OuNbDi3ehKsmeVe8SwUp8+m4hDlAtCaEnY?=
 =?us-ascii?Q?uVzKWJXf2PW3wScLsoNAycqD8n1MP2JVtwaCjSFDjLfmkeh9Y0i3MkUYzVLn?=
 =?us-ascii?Q?c2WtxQSG9NbEi5zcGyoWOaabZMjFJuqQS06283i7+m+OShnvRJUIslayexJK?=
 =?us-ascii?Q?UyV+ow7ltmXfjX1hEW4gV1eRYQmtBQr3+tvTJvpM/2E/YCOpGfiT2fVFqDYd?=
 =?us-ascii?Q?QLNgR1rHYuXjnA1/nhqLFMXkY3wPoCh/a+oCWfWc55OhaOnTCtRxXzOckmCl?=
 =?us-ascii?Q?SMPIjJ97FES4dtnz8eHriN366Q9aSmnSuxqC6BEEWmUCzdrTzdTqDhdf4XxV?=
 =?us-ascii?Q?h+EnlAC2y6ftLIbOSCaRbr+DwKO/pYZD1UeH8ByaJcA45sPkJd0GDbMGq6Rz?=
 =?us-ascii?Q?aBC9kSRNRahPTGtWzZS/Yb21+zWbYj3dmMOA8c0RlWEekzVITQzDg+1mTTn6?=
 =?us-ascii?Q?eGhp1GTQRExwo0VJUXXxyJw9i8UdDVWqr7n3NoLICf5Ondb1QaFar2TTSm4Z?=
 =?us-ascii?Q?XWg6wJfhOC1A8CHpVK4l3JQpVI5gQkAXV3QcForu+Q9kOqXAJ2iVj3taBtk+?=
 =?us-ascii?Q?eBtbA8HQUonyxYGywNXAbAmK4/kZz2IViB4d8HMzyljeLLMqQViMaUABGL54?=
 =?us-ascii?Q?2AfU1tZlPe7WRg7T6Uk5jlw/c1D1XwhSNOd+JluarQkYpey+/sMtgy392w3G?=
 =?us-ascii?Q?xo6ZAnMu/cchi6M92bjt9oGiYmwaTAdm+SiW0VoO58EmnjDodRaCnBiFgpEM?=
 =?us-ascii?Q?2FHR8eyiin3xmX8QCl/gdEuelxfvEGFdvhPEOH8HjoBAT7I1abUw/U9gghVY?=
 =?us-ascii?Q?wZXzVf7QcxJITy0JlG22haewAn3+uFrksG3ptSJ/OKkf21FI2/XwGLk8CNUZ?=
 =?us-ascii?Q?s56X32ubX0IvBZzRdd1sSccrNQ63jAceBWv5+LyTZoTG5RYw0pZ0UklDyBfR?=
 =?us-ascii?Q?RA6W0iur6q5OMcd/BKXu+3Zq6gwvPuaZASGVu+GKMHHoXg0kfFIzABCwlXj3?=
 =?us-ascii?Q?r0QVf+i0aaeAt2+KDaFGeaSPXx7zHjRh6rfMgM70G+fWnaP5VSNINRQQRmgR?=
 =?us-ascii?Q?/pgegT0EbqUdIpj8VuNDdUcU1VYFiYWAHv7P?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2025 17:28:20.6524 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 84285f99-40f0-45ef-b31e-08dd9e0d0aaa
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF00022573.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7714
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

