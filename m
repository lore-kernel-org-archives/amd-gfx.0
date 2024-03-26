Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DF13C54E58
	for <amd-gfx@archiver.kernel.org>; Tue, 26 Mar 2024 08:22:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DFB1C10EDCA;
	Tue, 26 Mar 2024 08:22:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="o/YpVDzt";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2044.outbound.protection.outlook.com [40.107.243.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AD65310EDCA
 for <amd-gfx@lists.freedesktop.org>; Tue, 26 Mar 2024 08:22:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M2L5t30UUMNTdq6r5/fDlworBOMwy16opkS02jDFk8F85TsXoXu3wnDS4cPjpfCrxXGcII/vvdX70f+bHMvN/XTzrFpJyQzZRzmu/jsJnUx9vPodSOYKPQHsZSoeArlAiagJVDLoqVQKVQtrnoTexk6cs+OU6GUy3iIw/58EXuy/Ccat5qJa2ygT3MFvcU/sM6WLF/PQXDSFeDK+pXHiFQ2FoXkZqhK2Xdj+13N/g7KVI0Fr4A/loF6NwPotN/1OMIrykcwwNiN8r8gz+MYXD7GPwgHP9WAXQsoe/TMxLUj907KKrZJIGJ1UCl0huwSJwAcd8q7sVWnWE7GWGAyg3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VFuqMTrD+4+q35tP9qXiPY3WCwV8Ib2KdrGxmd9zjWE=;
 b=nC1n5B8CXvXBad5XfX2UMvWHwhrDWVPuIBROivu/oQjGrSC/08uj13pWe/AOSXoGM4LJhEvYQNcRs9Iml1D/SLKRs/joI+QRvFZchgRe7tRi2eDPGQMueT45+HgNzibSBmHIYs8e+IzEx8ev9yhYrC9QSEXo/Xk0YJG+H3b0WIr0mI5Qh962cHO97zPqx7WI6YKrCyD4WILjcT6LcR/K/sZs6iOxQaKiEsTTyxC1Q2OxtJqu0WqShjyd0Ns5JpG/4v4ofjyTlwPZXv8sZXGb81v1KxObp5yaBYI83niWKnEn0sBrUvnxKpBSvFKPylpcer/nxApRUxbghehSIG9Rxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VFuqMTrD+4+q35tP9qXiPY3WCwV8Ib2KdrGxmd9zjWE=;
 b=o/YpVDztDIVG2nxbRI7G5wtjvGWXAF9ua9oUyf5wJxIY+xfJp2EcrLuCiq7jardJHslLb8FZN7isi0d+SKJDLnEsAm1VKbXKoUnW+zbYhrwp8Leba2YHayFmTO4f+jZncjkCIqnk+V3tbdHZW6kQE77ahc7Uz8dKubMrCBD2+Qs=
Received: from CH2PR04CA0007.namprd04.prod.outlook.com (2603:10b6:610:52::17)
 by CH3PR12MB9395.namprd12.prod.outlook.com (2603:10b6:610:1ce::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.32; Tue, 26 Mar
 2024 08:21:59 +0000
Received: from DS3PEPF000099DE.namprd04.prod.outlook.com
 (2603:10b6:610:52:cafe::e6) by CH2PR04CA0007.outlook.office365.com
 (2603:10b6:610:52::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.13 via Frontend
 Transport; Tue, 26 Mar 2024 08:21:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099DE.mail.protection.outlook.com (10.167.17.200) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7409.10 via Frontend Transport; Tue, 26 Mar 2024 08:21:58 +0000
Received: from prike-code-pc.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 26 Mar
 2024 03:21:57 -0500
From: Prike Liang <Prike.Liang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Prike Liang <Prike.Liang@amd.com>
Subject: [PATCH] drm/amdgpu: Fix the ring buffer size for queue VM flush
Date: Tue, 26 Mar 2024 16:21:47 +0800
Message-ID: <20240326082147.1694774-1-Prike.Liang@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099DE:EE_|CH3PR12MB9395:EE_
X-MS-Office365-Filtering-Correlation-Id: c6e34fb2-965f-4690-754c-08dc4d6dce4e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Fn3hDXKqBYky1cS+yXP4yHJlmRM/BSauw13qCSFZT4Wvn9wJ3chzVAFTKY3iP/C5rWRJnPH99DWnnTwVeX2/VaKla+lwKtyhy+LvqVer/nXe5nAMwWTzpgZo/Truln0jItm/MrSNUY1cotP9l+M0gdQPSx8I2OJoW6BULWhfzoQgSw2SC2CRwhiIESi6YIQPTy3RxhZmNnPcamOxZS3ySe9amitB7XMWTUvc6iSrHXGWO1s48Pam6FhaQCFD3yacwXq5x8v+3dY5Ye8xvhrv2a/WWHJG5oV5cPQham+D0YGKYchC7LrIPsTat+KrAtQZs2RQjlcdVz+hhhq2wo6aSYQ9Ek9CLWu/84l+82nbCYSxqkmXK6oOiyq6JE1AsIj5c1cJ5u+94Y9Deg4jdnNrfbbCoFaGi3IMBBg5v1bef9yWANrEGm0HgOW9Mp7Q/bZSfU1IZGhYOjBsmqh4A9OWidNR8xGZGKqjy34efIlCAsaKmwQVJefOcM4D0KSPZQzFLO83NZ7Om6zb8GbToTNCEE4QuZP5ixM/chtvycjPQ2TBG7lf1D7GQISYS7EjtaxCiSgPCFGo2j9UvzaAKUdGNS8i6ZyvWvHNO3K2ay0ZlPWJ5moGI/FA+Js9yQgyU9j+sWcdxbVoHLnxoW5R5BYNzoU5VN6Ert0cEFZaFsGfYuS1W8gg3j6S6gbfBZv37A3ZKwEbnMsRCUooixc5s3jwRU6z8W5EBHOI+uSJFA5iEMxZcbTohnSL6XKWPkprCS8V
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(36860700004)(376005)(82310400014)(1800799015); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2024 08:21:58.6852 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c6e34fb2-965f-4690-754c-08dc4d6dce4e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099DE.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9395
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

Here are the corrections needed for the queue ring buffer size
calculation for the following cases:
- Remove the KIQ VM flush ring usage.
- Add the invalidate TLBs packet for gfx10 and gfx11 queue.
- There's no VM flush and PFP sync, so remove the gfx9 real
  ring and compute ring buffer usage.

Signed-off-by: Prike Liang <Prike.Liang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c | 3 +--
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c | 3 +--
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c  | 5 -----
 3 files changed, 2 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
index d524f1a353ed..0c7312c0fa7f 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -9186,7 +9186,7 @@ static const struct amdgpu_ring_funcs gfx_v10_0_ring_funcs_gfx = {
 		7 + /* PIPELINE_SYNC */
 		SOC15_FLUSH_GPU_TLB_NUM_WREG * 5 +
 		SOC15_FLUSH_GPU_TLB_NUM_REG_WAIT * 7 +
-		2 + /* VM_FLUSH */
+		4 + /* VM_FLUSH */
 		8 + /* FENCE for VM_FLUSH */
 		20 + /* GDS switch */
 		4 + /* double SWITCH_BUFFER,
@@ -9276,7 +9276,6 @@ static const struct amdgpu_ring_funcs gfx_v10_0_ring_funcs_kiq = {
 		7 + /* gfx_v10_0_ring_emit_pipeline_sync */
 		SOC15_FLUSH_GPU_TLB_NUM_WREG * 5 +
 		SOC15_FLUSH_GPU_TLB_NUM_REG_WAIT * 7 +
-		2 + /* gfx_v10_0_ring_emit_vm_flush */
 		8 + 8 + 8, /* gfx_v10_0_ring_emit_fence_kiq x3 for user fence, vm fence */
 	.emit_ib_size =	7, /* gfx_v10_0_ring_emit_ib_compute */
 	.emit_ib = gfx_v10_0_ring_emit_ib_compute,
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
index 7a906318e451..5390dd2c51da 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -6191,7 +6191,7 @@ static const struct amdgpu_ring_funcs gfx_v11_0_ring_funcs_gfx = {
 		7 + /* PIPELINE_SYNC */
 		SOC15_FLUSH_GPU_TLB_NUM_WREG * 5 +
 		SOC15_FLUSH_GPU_TLB_NUM_REG_WAIT * 7 +
-		2 + /* VM_FLUSH */
+		4 + /* VM_FLUSH */
 		8 + /* FENCE for VM_FLUSH */
 		20 + /* GDS switch */
 		5 + /* COND_EXEC */
@@ -6277,7 +6277,6 @@ static const struct amdgpu_ring_funcs gfx_v11_0_ring_funcs_kiq = {
 		7 + /* gfx_v11_0_ring_emit_pipeline_sync */
 		SOC15_FLUSH_GPU_TLB_NUM_WREG * 5 +
 		SOC15_FLUSH_GPU_TLB_NUM_REG_WAIT * 7 +
-		2 + /* gfx_v11_0_ring_emit_vm_flush */
 		8 + 8 + 8, /* gfx_v11_0_ring_emit_fence_kiq x3 for user fence, vm fence */
 	.emit_ib_size =	7, /* gfx_v11_0_ring_emit_ib_compute */
 	.emit_ib = gfx_v11_0_ring_emit_ib_compute,
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
index 71b555993b7a..fce0b8238d13 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -6872,7 +6872,6 @@ static const struct amdgpu_ring_funcs gfx_v9_0_ring_funcs_gfx = {
 		7 +  /* PIPELINE_SYNC */
 		SOC15_FLUSH_GPU_TLB_NUM_WREG * 5 +
 		SOC15_FLUSH_GPU_TLB_NUM_REG_WAIT * 7 +
-		2 + /* VM_FLUSH */
 		8 +  /* FENCE for VM_FLUSH */
 		20 + /* GDS switch */
 		4 + /* double SWITCH_BUFFER,
@@ -6892,7 +6891,6 @@ static const struct amdgpu_ring_funcs gfx_v9_0_ring_funcs_gfx = {
 	.emit_ib = gfx_v9_0_ring_emit_ib_gfx,
 	.emit_fence = gfx_v9_0_ring_emit_fence,
 	.emit_pipeline_sync = gfx_v9_0_ring_emit_pipeline_sync,
-	.emit_vm_flush = gfx_v9_0_ring_emit_vm_flush,
 	.emit_gds_switch = gfx_v9_0_ring_emit_gds_switch,
 	.emit_hdp_flush = gfx_v9_0_ring_emit_hdp_flush,
 	.test_ring = gfx_v9_0_ring_test_ring,
@@ -6981,7 +6979,6 @@ static const struct amdgpu_ring_funcs gfx_v9_0_ring_funcs_compute = {
 		7 + /* gfx_v9_0_ring_emit_pipeline_sync */
 		SOC15_FLUSH_GPU_TLB_NUM_WREG * 5 +
 		SOC15_FLUSH_GPU_TLB_NUM_REG_WAIT * 7 +
-		2 + /* gfx_v9_0_ring_emit_vm_flush */
 		8 + 8 + 8 + /* gfx_v9_0_ring_emit_fence x3 for user fence, vm fence */
 		7 + /* gfx_v9_0_emit_mem_sync */
 		5 + /* gfx_v9_0_emit_wave_limit for updating mmSPI_WCL_PIPE_PERCENT_GFX register */
@@ -6990,7 +6987,6 @@ static const struct amdgpu_ring_funcs gfx_v9_0_ring_funcs_compute = {
 	.emit_ib = gfx_v9_0_ring_emit_ib_compute,
 	.emit_fence = gfx_v9_0_ring_emit_fence,
 	.emit_pipeline_sync = gfx_v9_0_ring_emit_pipeline_sync,
-	.emit_vm_flush = gfx_v9_0_ring_emit_vm_flush,
 	.emit_gds_switch = gfx_v9_0_ring_emit_gds_switch,
 	.emit_hdp_flush = gfx_v9_0_ring_emit_hdp_flush,
 	.test_ring = gfx_v9_0_ring_test_ring,
@@ -7019,7 +7015,6 @@ static const struct amdgpu_ring_funcs gfx_v9_0_ring_funcs_kiq = {
 		7 + /* gfx_v9_0_ring_emit_pipeline_sync */
 		SOC15_FLUSH_GPU_TLB_NUM_WREG * 5 +
 		SOC15_FLUSH_GPU_TLB_NUM_REG_WAIT * 7 +
-		2 + /* gfx_v9_0_ring_emit_vm_flush */
 		8 + 8 + 8, /* gfx_v9_0_ring_emit_fence_kiq x3 for user fence, vm fence */
 	.emit_ib_size =	7, /* gfx_v9_0_ring_emit_ib_compute */
 	.emit_fence = gfx_v9_0_ring_emit_fence_kiq,
-- 
2.34.1

