Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E962D38FEF
	for <amd-gfx@archiver.kernel.org>; Wed, 14 Jan 2026 16:47:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B007610E643;
	Wed, 14 Jan 2026 16:47:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="U4CuCbsI";
	dkim-atps=neutral
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012052.outbound.protection.outlook.com [52.101.43.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 631A710E63F
 for <amd-gfx@lists.freedesktop.org>; Wed, 14 Jan 2026 16:47:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KVl23LvogGfbhaOSaiEi9VZSmvOs7rPeEjhfr8K8wkX1TuIrhQ1M0BNMQcR8Q3ABlFiNRzEdxbDzl6e1qMfMoU7rVWvoG0Z4zsMPFedk8O/9ROowvTppMMaFFdCM1njlj8aLBMyAGpfMI+q8imExthYNenKEq+1AqbiyqMURarOYawX5ukIaNMvujF7aLnYFOYOrTEh88/gwaMS6Dh5u3qB6hLKX1SbIoD25rVO3H5G1Qs0SJYWo/WMdk71E3L9EAB9Wa9xv45yQQ3AZ/foTeDNoQbIk4hoyj5pqBB2PkJQu2s3Kisnp8ern1a27T8iDomctVjBMreVXEW2tmszmFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3OY0cyDYzTSjJTbX7GpKgcHhe/B5OJJ8XK5ki5JWe38=;
 b=ONJU9Hs6FpdeE9ePfCeISqmk3YtLpRqzOtZBK7OIPeJuweQiytjh54WeCkzhaBetsqyhftFVhPxpZ0ttGHAyHX6Uhx/Fcx/hmlr9D/rouqWSHNW2qXf6JhDT/86Zk8QRi9YvgYHOZDPtAcfzTmjP+W4QL7EEjgJ2St2eWFmF1QIevGSTeLG0bQfWBV0Ks94olf+tTZQ2PRNq9rF4LGGgXW1RYhRMrNDaKA//d9B87oD7qIkKH5bucCn0mo/x2EvUZk3LAhiiGAka1scHpaQkXpx5cYvCZyMOahzkqvDipGujs2bNS1Rx47ECIyHSQoWPMX7BI4RQqtAiiBuWz/zkPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3OY0cyDYzTSjJTbX7GpKgcHhe/B5OJJ8XK5ki5JWe38=;
 b=U4CuCbsIy3u2fnMcXgrGtXxnEtr+XmRUQ9PQpV3d+n5TxpIQf3jiTkOn3I6NwgjQWkYvyzs2bADxzMf6i96nPn+BRmtTfiEBQ2spnYTcNC9fIZ8VBBWwYJydY0OwIbl7z9em4Lqx7clhTr0OAVLXvdeV6TzF3yOlA6o2hIaznYQ=
Received: from PH8P221CA0001.NAMP221.PROD.OUTLOOK.COM (2603:10b6:510:2d8::16)
 by IA1PR12MB8264.namprd12.prod.outlook.com (2603:10b6:208:3f5::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.7; Wed, 14 Jan
 2026 16:47:45 +0000
Received: from CY4PEPF0000E9D6.namprd05.prod.outlook.com
 (2603:10b6:510:2d8:cafe::c) by PH8P221CA0001.outlook.office365.com
 (2603:10b6:510:2d8::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9520.5 via Frontend Transport; Wed,
 14 Jan 2026 16:47:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000E9D6.mail.protection.outlook.com (10.167.241.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9520.1 via Frontend Transport; Wed, 14 Jan 2026 16:47:44 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 14 Jan
 2026 10:47:38 -0600
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Wed, 14 Jan 2026 10:47:38 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 06/42] drm/amdgpu/gfx9: switch to using job for IBs
Date: Wed, 14 Jan 2026 11:46:51 -0500
Message-ID: <20260114164727.15367-7-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260114164727.15367-1-alexander.deucher@amd.com>
References: <20260114164727.15367-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D6:EE_|IA1PR12MB8264:EE_
X-MS-Office365-Filtering-Correlation-Id: dc4c7807-0794-48f0-f35f-08de538ca426
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?+mkC/gY6UQL04Rgjy6HkZNZXrYNbEi/1/OV0KzZ2vRXrM6np5IHllFn+Yeub?=
 =?us-ascii?Q?R3YtRBIUAEsv5mjMnRfGBjiufnG30R0DSUqYG/gS4/1xVqH48iWJ6wOiZjIZ?=
 =?us-ascii?Q?IdaIntgzq8mvCQc7hmsIkesHwM6K9OFx1nn7xZ8/sVrKChYc4jiIsNcEQ4+h?=
 =?us-ascii?Q?v/Nu0MnVxM3KwkNBVPmfJE+ylF2WozhaeXDe6mxnLr3tiEXNn6y6PdreF9zi?=
 =?us-ascii?Q?AEvE2sW/2v079wKRZIXcZhUrbrpoU58P0gniSxPI6c4Y0eJfeo0aBrTgKNAI?=
 =?us-ascii?Q?FaJcZohiGgpHI0YZpyljv6MvFAyeCr2PMksmZ88BwHJh8pqc0f6QMWGEbMsL?=
 =?us-ascii?Q?ZzDDBnulve43MeL5iAMYwvn62RiNsDBnj0qHTZ9F8kIdxD3MZWTKhf0DkXcE?=
 =?us-ascii?Q?zkPzW8YV0X76N6/djhOjtOuwDWnWXrKTBEd2do/cF4QZ5vAcWXhwJ/bOBtl6?=
 =?us-ascii?Q?cS53Oz7/N2K7GFmoy6qn3ISpHYj3kgpSWtRUryLAIcOeAY1mJk6j0nig7RHb?=
 =?us-ascii?Q?hphpe/+lEaHLThkeObMEFGAcxTyA+i2w2mVvEaFWcqZ4jgI5OmfL055WFRy0?=
 =?us-ascii?Q?WXSOg5nFgmfktecPmEE/gxD7uNkCV6ncTTI7sRWvPSq2NlHuCdr9K1SzHpWY?=
 =?us-ascii?Q?kFdnek8L2nhzHW2XMxFOB1KtIVow4WnNGxdhu/yosDM+mjoYGTXYP2auqXZ+?=
 =?us-ascii?Q?PNNnJ+hkLDvdrNf4ccRsausceIL2VupkDtE6R7Og7yyFjFe2BmSO8L7vXTd8?=
 =?us-ascii?Q?8cZQRvUQOcNd5nQaP+Hx/LmYETK48BSgwYWGJY5T8u8drb/AIhvMmvs4YoE5?=
 =?us-ascii?Q?n/pocCmisbpHrqixWt1j9/7+YJH/zySVUo/xgX5ZmAWgfUdrHMW7SRnv20ck?=
 =?us-ascii?Q?q2cB59uvEGpGBM90cTmjNWycfLC8yZgc4kkoIWMRAhvPkABW4WjFb0rN6rhD?=
 =?us-ascii?Q?HgNiHNwefC0qR1DGjq/WDKiz4wii7vODuV4OHvKhcWibDjgF6a9V/FVCxU7w?=
 =?us-ascii?Q?5kQtACWiI7wHUSgyD6ptnWTiJBtr0g6/iDIe1e/bqUe36KwCpVyAO05z4q2a?=
 =?us-ascii?Q?tfWMh8YCSFoGHycy/fz2IoZSbNV87IZlg8qDauO2Zc+PJkycFq27/CAfgPOw?=
 =?us-ascii?Q?0oI8KE2j/EZBPAcMAOG1rE09jUDyXpVJEzXvm4TythH1wIEklUqDJBQMQu5j?=
 =?us-ascii?Q?4ibK9SOSC0eP1A1uZPQjG+ZX6fJe9+LYmmSTyniWC+N64jDfKoylwfIos5Yh?=
 =?us-ascii?Q?xfZOj5dgFjq980XneS5qc6LAY9890GT/skRTnNEge/tUpsir4W+XHsEoSZr+?=
 =?us-ascii?Q?R8qTOUylXaYTFYhE9exvI61xrqpXIWo2Hez0nSi71uu9SsgHnQNcLmMlljnX?=
 =?us-ascii?Q?Glt3l+EcMcD7n+JE8PJzAmcN8ZzRJHQXf7H6Hr3l3DGt/KheWj6GwXM8z/1p?=
 =?us-ascii?Q?ccxya4p0gjsPYPy7DnP4vev/o8v2vnzAG0hiV/pkSvQK9Cs7+TQoFxwV92sq?=
 =?us-ascii?Q?aXXMMPJ/VCV4I9waGFqzbTMK39PFw17CcCFxNH97JiMGg3LL0HmziwDFfPmf?=
 =?us-ascii?Q?n5mGuzIAEZW/bz2NzB1F196nAgD6sgMLWKcBWg2uOuT4jgueAFhG/y7c5px9?=
 =?us-ascii?Q?7vfcv6S7e+DvWbiIDlNCzC7EzfFU7MAdIvhCMAj7q7o2ob0+HnvSnkzrujio?=
 =?us-ascii?Q?GalGqg=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jan 2026 16:47:44.6861 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dc4c7807-0794-48f0-f35f-08de538ca426
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9D6.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8264
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

Switch to using a job structure for IBs.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c | 138 +++++++++++++-------------
 1 file changed, 71 insertions(+), 67 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
index 7e9d753f4a808..36f0300a21bfa 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -1224,9 +1224,9 @@ static int gfx_v9_0_ring_test_ring(struct amdgpu_ring *ring)
 static int gfx_v9_0_ring_test_ib(struct amdgpu_ring *ring, long timeout)
 {
 	struct amdgpu_device *adev = ring->adev;
-	struct amdgpu_ib ib;
+	struct amdgpu_job *job;
+	struct amdgpu_ib *ib;
 	struct dma_fence *f = NULL;
-
 	unsigned index;
 	uint64_t gpu_addr;
 	uint32_t tmp;
@@ -1238,22 +1238,26 @@ static int gfx_v9_0_ring_test_ib(struct amdgpu_ring *ring, long timeout)
 
 	gpu_addr = adev->wb.gpu_addr + (index * 4);
 	adev->wb.wb[index] = cpu_to_le32(0xCAFEDEAD);
-	memset(&ib, 0, sizeof(ib));
 
-	r = amdgpu_ib_get(adev, NULL, 20, AMDGPU_IB_POOL_DIRECT, &ib);
+	r = amdgpu_job_alloc_with_ib(ring->adev, NULL, NULL, 20,
+				     AMDGPU_IB_POOL_DIRECT, &job,
+				     AMDGPU_KERNEL_JOB_ID_GFX_RING_TEST);
 	if (r)
 		goto err1;
 
-	ib.ptr[0] = PACKET3(PACKET3_WRITE_DATA, 3);
-	ib.ptr[1] = WRITE_DATA_DST_SEL(5) | WR_CONFIRM;
-	ib.ptr[2] = lower_32_bits(gpu_addr);
-	ib.ptr[3] = upper_32_bits(gpu_addr);
-	ib.ptr[4] = 0xDEADBEEF;
-	ib.length_dw = 5;
+	ib = &job->ibs[0];
+	ib->ptr[0] = PACKET3(PACKET3_WRITE_DATA, 3);
+	ib->ptr[1] = WRITE_DATA_DST_SEL(5) | WR_CONFIRM;
+	ib->ptr[2] = lower_32_bits(gpu_addr);
+	ib->ptr[3] = upper_32_bits(gpu_addr);
+	ib->ptr[4] = 0xDEADBEEF;
+	ib->length_dw = 5;
 
-	r = amdgpu_ib_schedule(ring, 1, &ib, NULL, &f);
-	if (r)
+	r = amdgpu_job_submit_direct(job, ring, &f);
+	if (r) {
+		amdgpu_job_free(job);
 		goto err2;
+	}
 
 	r = dma_fence_wait_timeout(f, false, timeout);
 	if (r == 0) {
@@ -1270,7 +1274,6 @@ static int gfx_v9_0_ring_test_ib(struct amdgpu_ring *ring, long timeout)
 		r = -EINVAL;
 
 err2:
-	amdgpu_ib_free(&ib, NULL);
 	dma_fence_put(f);
 err1:
 	amdgpu_device_wb_free(adev, index);
@@ -4624,7 +4627,8 @@ static int gfx_v9_0_do_edc_gds_workarounds(struct amdgpu_device *adev)
 static int gfx_v9_0_do_edc_gpr_workarounds(struct amdgpu_device *adev)
 {
 	struct amdgpu_ring *ring = &adev->gfx.compute_ring[0];
-	struct amdgpu_ib ib;
+	struct amdgpu_job *job;
+	struct amdgpu_ib *ib;
 	struct dma_fence *f = NULL;
 	int r, i;
 	unsigned total_size, vgpr_offset, sgpr_offset;
@@ -4670,9 +4674,9 @@ static int gfx_v9_0_do_edc_gpr_workarounds(struct amdgpu_device *adev)
 	total_size += sizeof(sgpr_init_compute_shader);
 
 	/* allocate an indirect buffer to put the commands in */
-	memset(&ib, 0, sizeof(ib));
-	r = amdgpu_ib_get(adev, NULL, total_size,
-					AMDGPU_IB_POOL_DIRECT, &ib);
+	r = amdgpu_job_alloc_with_ib(ring->adev, NULL, NULL, total_size,
+				     AMDGPU_IB_POOL_DIRECT, &job,
+				     AMDGPU_KERNEL_JOB_ID_RUN_SHADER);
 	if (r) {
 		drm_err(adev_to_drm(adev), "failed to get ib (%d).\n", r);
 		return r;
@@ -4680,102 +4684,103 @@ static int gfx_v9_0_do_edc_gpr_workarounds(struct amdgpu_device *adev)
 
 	/* load the compute shaders */
 	for (i = 0; i < vgpr_init_shader_size/sizeof(u32); i++)
-		ib.ptr[i + (vgpr_offset / 4)] = vgpr_init_shader_ptr[i];
+		ib->ptr[i + (vgpr_offset / 4)] = vgpr_init_shader_ptr[i];
 
 	for (i = 0; i < ARRAY_SIZE(sgpr_init_compute_shader); i++)
-		ib.ptr[i + (sgpr_offset / 4)] = sgpr_init_compute_shader[i];
+		ib->ptr[i + (sgpr_offset / 4)] = sgpr_init_compute_shader[i];
 
 	/* init the ib length to 0 */
-	ib.length_dw = 0;
+	ib->length_dw = 0;
 
 	/* VGPR */
 	/* write the register state for the compute dispatch */
 	for (i = 0; i < gpr_reg_size; i++) {
-		ib.ptr[ib.length_dw++] = PACKET3(PACKET3_SET_SH_REG, 1);
-		ib.ptr[ib.length_dw++] = SOC15_REG_ENTRY_OFFSET(vgpr_init_regs_ptr[i])
+		ib->ptr[ib->length_dw++] = PACKET3(PACKET3_SET_SH_REG, 1);
+		ib->ptr[ib->length_dw++] = SOC15_REG_ENTRY_OFFSET(vgpr_init_regs_ptr[i])
 								- PACKET3_SET_SH_REG_START;
-		ib.ptr[ib.length_dw++] = vgpr_init_regs_ptr[i].reg_value;
+		ib->ptr[ib->length_dw++] = vgpr_init_regs_ptr[i].reg_value;
 	}
 	/* write the shader start address: mmCOMPUTE_PGM_LO, mmCOMPUTE_PGM_HI */
-	gpu_addr = (ib.gpu_addr + (u64)vgpr_offset) >> 8;
-	ib.ptr[ib.length_dw++] = PACKET3(PACKET3_SET_SH_REG, 2);
-	ib.ptr[ib.length_dw++] = SOC15_REG_OFFSET(GC, 0, mmCOMPUTE_PGM_LO)
+	gpu_addr = (ib->gpu_addr + (u64)vgpr_offset) >> 8;
+	ib->ptr[ib->length_dw++] = PACKET3(PACKET3_SET_SH_REG, 2);
+	ib->ptr[ib->length_dw++] = SOC15_REG_OFFSET(GC, 0, mmCOMPUTE_PGM_LO)
 							- PACKET3_SET_SH_REG_START;
-	ib.ptr[ib.length_dw++] = lower_32_bits(gpu_addr);
-	ib.ptr[ib.length_dw++] = upper_32_bits(gpu_addr);
+	ib->ptr[ib->length_dw++] = lower_32_bits(gpu_addr);
+	ib->ptr[ib->length_dw++] = upper_32_bits(gpu_addr);
 
 	/* write dispatch packet */
-	ib.ptr[ib.length_dw++] = PACKET3(PACKET3_DISPATCH_DIRECT, 3);
-	ib.ptr[ib.length_dw++] = compute_dim_x * 2; /* x */
-	ib.ptr[ib.length_dw++] = 1; /* y */
-	ib.ptr[ib.length_dw++] = 1; /* z */
-	ib.ptr[ib.length_dw++] =
+	ib->ptr[ib->length_dw++] = PACKET3(PACKET3_DISPATCH_DIRECT, 3);
+	ib->ptr[ib->length_dw++] = compute_dim_x * 2; /* x */
+	ib->ptr[ib->length_dw++] = 1; /* y */
+	ib->ptr[ib->length_dw++] = 1; /* z */
+	ib->ptr[ib->length_dw++] =
 		REG_SET_FIELD(0, COMPUTE_DISPATCH_INITIATOR, COMPUTE_SHADER_EN, 1);
 
 	/* write CS partial flush packet */
-	ib.ptr[ib.length_dw++] = PACKET3(PACKET3_EVENT_WRITE, 0);
-	ib.ptr[ib.length_dw++] = EVENT_TYPE(7) | EVENT_INDEX(4);
+	ib->ptr[ib->length_dw++] = PACKET3(PACKET3_EVENT_WRITE, 0);
+	ib->ptr[ib->length_dw++] = EVENT_TYPE(7) | EVENT_INDEX(4);
 
 	/* SGPR1 */
 	/* write the register state for the compute dispatch */
 	for (i = 0; i < gpr_reg_size; i++) {
-		ib.ptr[ib.length_dw++] = PACKET3(PACKET3_SET_SH_REG, 1);
-		ib.ptr[ib.length_dw++] = SOC15_REG_ENTRY_OFFSET(sgpr1_init_regs[i])
+		ib->ptr[ib->length_dw++] = PACKET3(PACKET3_SET_SH_REG, 1);
+		ib->ptr[ib->length_dw++] = SOC15_REG_ENTRY_OFFSET(sgpr1_init_regs[i])
 								- PACKET3_SET_SH_REG_START;
-		ib.ptr[ib.length_dw++] = sgpr1_init_regs[i].reg_value;
+		ib->ptr[ib->length_dw++] = sgpr1_init_regs[i].reg_value;
 	}
 	/* write the shader start address: mmCOMPUTE_PGM_LO, mmCOMPUTE_PGM_HI */
-	gpu_addr = (ib.gpu_addr + (u64)sgpr_offset) >> 8;
-	ib.ptr[ib.length_dw++] = PACKET3(PACKET3_SET_SH_REG, 2);
-	ib.ptr[ib.length_dw++] = SOC15_REG_OFFSET(GC, 0, mmCOMPUTE_PGM_LO)
+	gpu_addr = (ib->gpu_addr + (u64)sgpr_offset) >> 8;
+	ib->ptr[ib->length_dw++] = PACKET3(PACKET3_SET_SH_REG, 2);
+	ib->ptr[ib->length_dw++] = SOC15_REG_OFFSET(GC, 0, mmCOMPUTE_PGM_LO)
 							- PACKET3_SET_SH_REG_START;
-	ib.ptr[ib.length_dw++] = lower_32_bits(gpu_addr);
-	ib.ptr[ib.length_dw++] = upper_32_bits(gpu_addr);
+	ib->ptr[ib->length_dw++] = lower_32_bits(gpu_addr);
+	ib->ptr[ib->length_dw++] = upper_32_bits(gpu_addr);
 
 	/* write dispatch packet */
-	ib.ptr[ib.length_dw++] = PACKET3(PACKET3_DISPATCH_DIRECT, 3);
-	ib.ptr[ib.length_dw++] = compute_dim_x / 2 * sgpr_work_group_size; /* x */
-	ib.ptr[ib.length_dw++] = 1; /* y */
-	ib.ptr[ib.length_dw++] = 1; /* z */
-	ib.ptr[ib.length_dw++] =
+	ib->ptr[ib->length_dw++] = PACKET3(PACKET3_DISPATCH_DIRECT, 3);
+	ib->ptr[ib->length_dw++] = compute_dim_x / 2 * sgpr_work_group_size; /* x */
+	ib->ptr[ib->length_dw++] = 1; /* y */
+	ib->ptr[ib->length_dw++] = 1; /* z */
+	ib->ptr[ib->length_dw++] =
 		REG_SET_FIELD(0, COMPUTE_DISPATCH_INITIATOR, COMPUTE_SHADER_EN, 1);
 
 	/* write CS partial flush packet */
-	ib.ptr[ib.length_dw++] = PACKET3(PACKET3_EVENT_WRITE, 0);
-	ib.ptr[ib.length_dw++] = EVENT_TYPE(7) | EVENT_INDEX(4);
+	ib->ptr[ib->length_dw++] = PACKET3(PACKET3_EVENT_WRITE, 0);
+	ib->ptr[ib->length_dw++] = EVENT_TYPE(7) | EVENT_INDEX(4);
 
 	/* SGPR2 */
 	/* write the register state for the compute dispatch */
 	for (i = 0; i < gpr_reg_size; i++) {
-		ib.ptr[ib.length_dw++] = PACKET3(PACKET3_SET_SH_REG, 1);
-		ib.ptr[ib.length_dw++] = SOC15_REG_ENTRY_OFFSET(sgpr2_init_regs[i])
+		ib->ptr[ib->length_dw++] = PACKET3(PACKET3_SET_SH_REG, 1);
+		ib->ptr[ib->length_dw++] = SOC15_REG_ENTRY_OFFSET(sgpr2_init_regs[i])
 								- PACKET3_SET_SH_REG_START;
-		ib.ptr[ib.length_dw++] = sgpr2_init_regs[i].reg_value;
+		ib->ptr[ib->length_dw++] = sgpr2_init_regs[i].reg_value;
 	}
 	/* write the shader start address: mmCOMPUTE_PGM_LO, mmCOMPUTE_PGM_HI */
-	gpu_addr = (ib.gpu_addr + (u64)sgpr_offset) >> 8;
-	ib.ptr[ib.length_dw++] = PACKET3(PACKET3_SET_SH_REG, 2);
-	ib.ptr[ib.length_dw++] = SOC15_REG_OFFSET(GC, 0, mmCOMPUTE_PGM_LO)
+	gpu_addr = (ib->gpu_addr + (u64)sgpr_offset) >> 8;
+	ib->ptr[ib->length_dw++] = PACKET3(PACKET3_SET_SH_REG, 2);
+	ib->ptr[ib->length_dw++] = SOC15_REG_OFFSET(GC, 0, mmCOMPUTE_PGM_LO)
 							- PACKET3_SET_SH_REG_START;
-	ib.ptr[ib.length_dw++] = lower_32_bits(gpu_addr);
-	ib.ptr[ib.length_dw++] = upper_32_bits(gpu_addr);
+	ib->ptr[ib->length_dw++] = lower_32_bits(gpu_addr);
+	ib->ptr[ib->length_dw++] = upper_32_bits(gpu_addr);
 
 	/* write dispatch packet */
-	ib.ptr[ib.length_dw++] = PACKET3(PACKET3_DISPATCH_DIRECT, 3);
-	ib.ptr[ib.length_dw++] = compute_dim_x / 2 * sgpr_work_group_size; /* x */
-	ib.ptr[ib.length_dw++] = 1; /* y */
-	ib.ptr[ib.length_dw++] = 1; /* z */
-	ib.ptr[ib.length_dw++] =
+	ib->ptr[ib->length_dw++] = PACKET3(PACKET3_DISPATCH_DIRECT, 3);
+	ib->ptr[ib->length_dw++] = compute_dim_x / 2 * sgpr_work_group_size; /* x */
+	ib->ptr[ib->length_dw++] = 1; /* y */
+	ib->ptr[ib->length_dw++] = 1; /* z */
+	ib->ptr[ib->length_dw++] =
 		REG_SET_FIELD(0, COMPUTE_DISPATCH_INITIATOR, COMPUTE_SHADER_EN, 1);
 
 	/* write CS partial flush packet */
-	ib.ptr[ib.length_dw++] = PACKET3(PACKET3_EVENT_WRITE, 0);
-	ib.ptr[ib.length_dw++] = EVENT_TYPE(7) | EVENT_INDEX(4);
+	ib->ptr[ib->length_dw++] = PACKET3(PACKET3_EVENT_WRITE, 0);
+	ib->ptr[ib->length_dw++] = EVENT_TYPE(7) | EVENT_INDEX(4);
 
 	/* shedule the ib on the ring */
-	r = amdgpu_ib_schedule(ring, 1, &ib, NULL, &f);
+	r = amdgpu_job_submit_direct(job, ring, &f);
 	if (r) {
 		drm_err(adev_to_drm(adev), "ib schedule failed (%d).\n", r);
+		amdgpu_job_free(job);
 		goto fail;
 	}
 
@@ -4787,7 +4792,6 @@ static int gfx_v9_0_do_edc_gpr_workarounds(struct amdgpu_device *adev)
 	}
 
 fail:
-	amdgpu_ib_free(&ib, NULL);
 	dma_fence_put(f);
 
 	return r;
-- 
2.52.0

