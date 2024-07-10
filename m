Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7908BC3DA42
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Jul 2024 20:30:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 233A210E8F3;
	Wed, 10 Jul 2024 20:30:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="OqvXcZ4j";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2069.outbound.protection.outlook.com [40.107.93.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1714710E8F3
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 Jul 2024 20:30:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dZzgSNsykWVvDptCc4Ib2w6p8rpvgW3Ll0WVaWIfygbNNRP4v17uDSjW7JMWc0vismQWZ+8nicg5LfZZLHznW1QRbDmbHsbcqSWhSGPJ4SyDCUYTKY5rXdDs8TEham4cZiRUCcteTz+UGmf+aEfLaZ0S3h3PqKyJtTW1wkHIm+IGoSe/QqX/bBb2RGNMG9Xw//V7kutSYtVDPz/IYHSfhoUna1J3fyHSMMTqrMcegA5aOsW7WphmTJp4DBP2X98jl01cn/GZ8G6xJemVPXvnwSttJIVbCDFUM/e/mGsNecOMvnpUpZ2TMhY0CusMV7Om9IJ/NCGNlPj7NqMhQqp/Aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vXvyyiFV9xKoLQ1aRZDpMF5ooTaPgYQsVpQ8rxVsL4c=;
 b=YJ7FDwDv6W8F4ClXmAqfzHLuh0DOGKlyuuuTcD7aSruAm0tU/dtcF7p/hoEo2ynVwZdcUV4dYcoQKOK8Yz+TOeEIpW5JdNUzrXPCgmX5NMieI/uypxTCGNsqYe4hwyRuzf96rR3nuPYSJ/EamOhjOpA3t6BF3m9n41UL2kFqAV4/rNtB8P0Tm6oSUaMDBrkcAF/D/k/QvaOz0Wc3jQlAgG1F3Gjoj7B8pXV0uniUJDkgafsrbqbFPnHRx8Pw0QKWklbS5KLtkMJ5W9Q2D7j7pnneclVuOUSbJV13os0efPg4O1vZN5cEnyeCB1criLhlu+VfC8XdpOHh9HU25/LziA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vXvyyiFV9xKoLQ1aRZDpMF5ooTaPgYQsVpQ8rxVsL4c=;
 b=OqvXcZ4jtq6F6Q+5lVrCYhY4LzA4+9WvCMT2aHCk1CDYHIZnU2V5rDpggGDnfRg9oBw3oYWvhAUMrLDl1evYI2pfgPdjnforYS8h+aJF32LIsPbZcgbmyGp9eKDrjgvtWLRv2yu2bp4/K+ok00f5LhdT2ozOOj9FOPpbwlkxAI8=
Received: from CH5PR05CA0001.namprd05.prod.outlook.com (2603:10b6:610:1f0::19)
 by IA1PR12MB7495.namprd12.prod.outlook.com (2603:10b6:208:419::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.20; Wed, 10 Jul
 2024 20:30:10 +0000
Received: from CH2PEPF0000009F.namprd02.prod.outlook.com
 (2603:10b6:610:1f0:cafe::ee) by CH5PR05CA0001.outlook.office365.com
 (2603:10b6:610:1f0::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.20 via Frontend
 Transport; Wed, 10 Jul 2024 20:30:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH2PEPF0000009F.mail.protection.outlook.com (10.167.244.21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7762.17 via Frontend Transport; Wed, 10 Jul 2024 20:30:10 +0000
Received: from smtp.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 10 Jul
 2024 15:30:05 -0500
From: <boyuan.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Boyuan Zhang <boyuan.zhang@amd.com>, Alex Deucher
 <alexander.deucher@amd.com>
Subject: [PATCH 1/2] drm/amdgpu/vcn: identify unified queue in sw init
Date: Wed, 10 Jul 2024 16:29:51 -0400
Message-ID: <20240710202952.188573-1-boyuan.zhang@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000009F:EE_|IA1PR12MB7495:EE_
X-MS-Office365-Filtering-Correlation-Id: f52a5326-238d-49a4-cdaf-08dca11f1858
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?SdiJ4dSBZjOOYW3IVSkQx5beL0bVIDPcajPNpNSV6MzfkZQbE5u3ZoNdKjTe?=
 =?us-ascii?Q?tdJUpCX9dgXGl1+lKaiX2t/GHS3Qc20TLZPFu8Vg2uLkz3sPgplJnV1ucZEY?=
 =?us-ascii?Q?lZo9MBz+xu/rPUbntGIfLhvhXRV0T7v7ixiSQLFX+fCElkg99e4fiE9uhydq?=
 =?us-ascii?Q?4LwUKhwZHFlSV8SpQD0iBcUKa/dpPAt/cqngG4jZHZb7gg6K6ju58wpYcTnL?=
 =?us-ascii?Q?dc+K22lzyQrcc5zSuyhwMJ/bLz4RiIHdHIuIbBvNkxIXSzdq19Z9mO9SFfu/?=
 =?us-ascii?Q?c9TPQMSufJZZ5sQX1cx2PTa9bD8nd93Pprrf7GIbO0oIie9sZS7l+0KFhU4X?=
 =?us-ascii?Q?yXx4DS5hzL3iFwBXtjqx+xfKxwXJTR+OLTCLyvHYmKTeo1PrsWwHFj2BQDIH?=
 =?us-ascii?Q?xfOIwcL5XP2zK+hyEi7zjsqlC8Yr7+0pU2kkH5eWOwXV7zs3jDa4CRD3zw83?=
 =?us-ascii?Q?ggU+3QAjZByw7/O1b3fh16gR6rBOwXzAb7LgokhUfUmlgDtfxRU3cPvSRcvR?=
 =?us-ascii?Q?DRsDU3zwsDZPYWGlQCJxhHvUIhRwPQek6bv1H8Vneza5IjmvE9MyT2ZhxGoA?=
 =?us-ascii?Q?bheRUUuzKSSm+4511PIed7noBAoAzyMT1sUV7C2454UwH+zg07tmwdKWlBPB?=
 =?us-ascii?Q?th+VBiZC4AB5Pa1PTm25ayuePdETKPyHhLjLn9Xp/TGeKMgk+Xcbt8qfEfAX?=
 =?us-ascii?Q?hCCZUql/R/Cah6WfhISmgaoAjDOn/sUiEyUpu8KhHhCMoWhbY68uuiOKa9wr?=
 =?us-ascii?Q?IxZEFX++fEScf+x+chqlmgc/6Rcr6cDuUTYhzUjPpJPDEz9cA185zjPFd/aM?=
 =?us-ascii?Q?2+/Fj6BxxH+S57vJHH8db9ccWv/xTnm6PWf4gKEUh+qDntIUsAXPdkz/gmO2?=
 =?us-ascii?Q?hBUBDoI7dDyqx9WGmS5ULNUWjQLcW+YnjRYOL7lmXDsrdsGcHuozJP6y4Iey?=
 =?us-ascii?Q?FycbjNcdlY4Vi/kKK6lb/JDKvRRQOwuyJZ1Si+r3zu7W2c/cbpxKWzhaBwmD?=
 =?us-ascii?Q?FdYjyNGUHy5GpqbPJWcg+L8pEXW2urPPMr+OFUovjP5h+neH2aG0Gy/RlGxx?=
 =?us-ascii?Q?mEpKU26vaX31oihKUYFvKAq/YUQFLYANbVoRFWzU3LWb3O2TcJTDEyTbfnji?=
 =?us-ascii?Q?eb8zTAambBCc7CetaXgGeH4F14471Vf1TpJ6wD7iZdnJLLJ1r2goGarJx6aV?=
 =?us-ascii?Q?bQoMdn1hRPTk9qRv3DPGThHJBAKDSROA3GItzDU7FhTv7UtK4XItpqNXhym2?=
 =?us-ascii?Q?ZEIEGKXdMj1UsEZJMKNtwPKg8HYs4A+J/ZRvRMC8oWmm/FyAGiH8C9wt2drM?=
 =?us-ascii?Q?x3Lh/3QCD++OE3DEMlrD3BteqDGb7aQeYsRoZxqLetlpKcoMuNb+48Amr5rl?=
 =?us-ascii?Q?SaHxLwko4q2YhKGEHN10IhyhxvxFDcaNXjlYfJq04ZY4ExTXMKit945j7x1w?=
 =?us-ascii?Q?IvqqlLtPrOs=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2024 20:30:10.2111 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f52a5326-238d-49a4-cdaf-08dca11f1858
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF0000009F.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7495
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

From: Boyuan Zhang <boyuan.zhang@amd.com>

Determine whether VCN using unified queue in sw_init, instead of calling
functions later on.

v2: fix coding style

Signed-off-by: Boyuan Zhang <boyuan.zhang@amd.com>
Acked-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c | 39 ++++++++++---------------
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h |  1 +
 2 files changed, 16 insertions(+), 24 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
index dad5f9722e14..f59e81be885d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
@@ -139,6 +139,10 @@ int amdgpu_vcn_sw_init(struct amdgpu_device *adev)
 		}
 	}
 
+	/* from vcn4 and above, only unified queue is used */
+	adev->vcn.using_unified_queue =
+		amdgpu_ip_version(adev, UVD_HWIP, 0) >= IP_VERSION(4, 0, 0);
+
 	hdr = (const struct common_firmware_header *)adev->vcn.fw->data;
 	adev->vcn.fw_version = le32_to_cpu(hdr->ucode_version);
 
@@ -266,18 +270,6 @@ int amdgpu_vcn_sw_fini(struct amdgpu_device *adev)
 	return 0;
 }
 
-/* from vcn4 and above, only unified queue is used */
-static bool amdgpu_vcn_using_unified_queue(struct amdgpu_ring *ring)
-{
-	struct amdgpu_device *adev = ring->adev;
-	bool ret = false;
-
-	if (amdgpu_ip_version(adev, UVD_HWIP, 0) >= IP_VERSION(4, 0, 0))
-		ret = true;
-
-	return ret;
-}
-
 bool amdgpu_vcn_is_disabled_vcn(struct amdgpu_device *adev, enum vcn_ring_type type, uint32_t vcn_instance)
 {
 	bool ret = false;
@@ -747,12 +739,11 @@ static int amdgpu_vcn_dec_sw_send_msg(struct amdgpu_ring *ring,
 	struct amdgpu_job *job;
 	struct amdgpu_ib *ib;
 	uint64_t addr = AMDGPU_GPU_PAGE_ALIGN(ib_msg->gpu_addr);
-	bool sq = amdgpu_vcn_using_unified_queue(ring);
 	uint32_t *ib_checksum;
 	uint32_t ib_pack_in_dw;
 	int i, r;
 
-	if (sq)
+	if (adev->vcn.using_unified_queue)
 		ib_size_dw += 8;
 
 	r = amdgpu_job_alloc_with_ib(ring->adev, NULL, NULL,
@@ -765,7 +756,7 @@ static int amdgpu_vcn_dec_sw_send_msg(struct amdgpu_ring *ring,
 	ib->length_dw = 0;
 
 	/* single queue headers */
-	if (sq) {
+	if (adev->vcn.using_unified_queue) {
 		ib_pack_in_dw = sizeof(struct amdgpu_vcn_decode_buffer) / sizeof(uint32_t)
 						+ 4 + 2; /* engine info + decoding ib in dw */
 		ib_checksum = amdgpu_vcn_unified_ring_ib_header(ib, ib_pack_in_dw, false);
@@ -784,7 +775,7 @@ static int amdgpu_vcn_dec_sw_send_msg(struct amdgpu_ring *ring,
 	for (i = ib->length_dw; i < ib_size_dw; ++i)
 		ib->ptr[i] = 0x0;
 
-	if (sq)
+	if (adev->vcn.using_unified_queue)
 		amdgpu_vcn_unified_ring_ib_checksum(&ib_checksum, ib_pack_in_dw);
 
 	r = amdgpu_job_submit_direct(job, ring, &f);
@@ -874,15 +865,15 @@ static int amdgpu_vcn_enc_get_create_msg(struct amdgpu_ring *ring, uint32_t hand
 					 struct dma_fence **fence)
 {
 	unsigned int ib_size_dw = 16;
+	struct amdgpu_device *adev = ring->adev;
 	struct amdgpu_job *job;
 	struct amdgpu_ib *ib;
 	struct dma_fence *f = NULL;
 	uint32_t *ib_checksum = NULL;
 	uint64_t addr;
-	bool sq = amdgpu_vcn_using_unified_queue(ring);
 	int i, r;
 
-	if (sq)
+	if (adev->vcn.using_unified_queue)
 		ib_size_dw += 8;
 
 	r = amdgpu_job_alloc_with_ib(ring->adev, NULL, NULL,
@@ -896,7 +887,7 @@ static int amdgpu_vcn_enc_get_create_msg(struct amdgpu_ring *ring, uint32_t hand
 
 	ib->length_dw = 0;
 
-	if (sq)
+	if (adev->vcn.using_unified_queue)
 		ib_checksum = amdgpu_vcn_unified_ring_ib_header(ib, 0x11, true);
 
 	ib->ptr[ib->length_dw++] = 0x00000018;
@@ -918,7 +909,7 @@ static int amdgpu_vcn_enc_get_create_msg(struct amdgpu_ring *ring, uint32_t hand
 	for (i = ib->length_dw; i < ib_size_dw; ++i)
 		ib->ptr[i] = 0x0;
 
-	if (sq)
+	if (adev->vcn.using_unified_queue)
 		amdgpu_vcn_unified_ring_ib_checksum(&ib_checksum, 0x11);
 
 	r = amdgpu_job_submit_direct(job, ring, &f);
@@ -941,15 +932,15 @@ static int amdgpu_vcn_enc_get_destroy_msg(struct amdgpu_ring *ring, uint32_t han
 					  struct dma_fence **fence)
 {
 	unsigned int ib_size_dw = 16;
+	struct amdgpu_device *adev = ring->adev;
 	struct amdgpu_job *job;
 	struct amdgpu_ib *ib;
 	struct dma_fence *f = NULL;
 	uint32_t *ib_checksum = NULL;
 	uint64_t addr;
-	bool sq = amdgpu_vcn_using_unified_queue(ring);
 	int i, r;
 
-	if (sq)
+	if (adev->vcn.using_unified_queue)
 		ib_size_dw += 8;
 
 	r = amdgpu_job_alloc_with_ib(ring->adev, NULL, NULL,
@@ -963,7 +954,7 @@ static int amdgpu_vcn_enc_get_destroy_msg(struct amdgpu_ring *ring, uint32_t han
 
 	ib->length_dw = 0;
 
-	if (sq)
+	if (adev->vcn.using_unified_queue)
 		ib_checksum = amdgpu_vcn_unified_ring_ib_header(ib, 0x11, true);
 
 	ib->ptr[ib->length_dw++] = 0x00000018;
@@ -985,7 +976,7 @@ static int amdgpu_vcn_enc_get_destroy_msg(struct amdgpu_ring *ring, uint32_t han
 	for (i = ib->length_dw; i < ib_size_dw; ++i)
 		ib->ptr[i] = 0x0;
 
-	if (sq)
+	if (adev->vcn.using_unified_queue)
 		amdgpu_vcn_unified_ring_ib_checksum(&ib_checksum, 0x11);
 
 	r = amdgpu_job_submit_direct(job, ring, &f);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
index 081695e74932..838c0935f683 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
@@ -329,6 +329,7 @@ struct amdgpu_vcn {
 
 	uint16_t inst_mask;
 	uint8_t	num_inst_per_aid;
+	bool using_unified_queue;
 };
 
 struct amdgpu_fw_shared_rb_ptrs_struct {
-- 
2.34.1

