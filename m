Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14111D1D46B
	for <amd-gfx@archiver.kernel.org>; Thu,  8 Jan 2026 14:49:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 96B9410E767;
	Thu,  8 Jan 2026 14:49:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="NP7RsweU";
	dkim-atps=neutral
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010038.outbound.protection.outlook.com [52.101.56.38])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9072510E767
 for <amd-gfx@lists.freedesktop.org>; Thu,  8 Jan 2026 14:49:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZQzrInplc6xn7oSJ2u5ZhMoTwJOz+q+ZjE2FhznrIlB+CnQQ/Ru2Leh5DnEpkBrFHJ2eJxXxys2ZXyTa++ahIAJP4ZAOyuljktbjL8hTHp/V+CC4wycrzXiq5HQ2n9KWhQJ1LjNAImRqyIgI8c8/NgpUC54F+ERltQ3SCM/mtFY3m39hyX9imuSq2fXuyXe+LZGbv1eneR9J/Lu9smtOcsxS9vlAD3YzV65KFNY1hEs+jhqK6+X5SlWVMYLtnORRjNL4IqUQig30quR0IeUSRLoRILt8YAE1QjVowpyAJNavOzJlVzz9v2SacGBdGUuCO/IqphJoJcmr8YmGN8SbCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3OY0cyDYzTSjJTbX7GpKgcHhe/B5OJJ8XK5ki5JWe38=;
 b=httSkLIaWEfEr52waSwuJE9nbWXC9v+s2VcMwrsIB8dhNrUvMmMND5teoGuEQBSk16MgDjxF2njTiY0MIRNmxK9YfBpoU9AVaTL0WLmnH1vqJIJRwYxN2LLCyanfLcICT11yCbP7ix/v8UyrXfJa1czQcqcE5jXU9MOAaCpD6XGXQlbcqyJ2nTlqPoFnKuAXqC9zKqK7uA0CvMWvp0/mcAoZ5AuMsfa41gb22KoDPW2uHmV+lyDIHMFbQn4Jvf4HaRXWxxG1qoO+hf5L/TmRGl8cA1/qNwFW9hW1FTNTmCWXr1aiVWcpQ/oJynYuhLyTGCMC13tS3am3bTgE8nQQ4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3OY0cyDYzTSjJTbX7GpKgcHhe/B5OJJ8XK5ki5JWe38=;
 b=NP7RsweUWnZIzPI1ClSsoqnUk/qhMiNpYHfrONgs70GRSqUKH+/9jVAlpaZzk06JNjuS5mpA6Lu6ZWpB5lLuBNgHE/ZsQ8jJByUX77L/gFNEjNHxddVAuRlTMTbYFi21m5A4/ZNFDmgbB4a8XetDFnW8wQVwvDpvBcWmrCrHtVQ=
Received: from SJ0PR03CA0347.namprd03.prod.outlook.com (2603:10b6:a03:39c::22)
 by MW4PR12MB8611.namprd12.prod.outlook.com (2603:10b6:303:1ed::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.2; Thu, 8 Jan
 2026 14:48:55 +0000
Received: from BY1PEPF0001AE16.namprd04.prod.outlook.com
 (2603:10b6:a03:39c:cafe::30) by SJ0PR03CA0347.outlook.office365.com
 (2603:10b6:a03:39c::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9499.4 via Frontend Transport; Thu, 8
 Jan 2026 14:48:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BY1PEPF0001AE16.mail.protection.outlook.com (10.167.242.104) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9520.1 via Frontend Transport; Thu, 8 Jan 2026 14:48:55 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 8 Jan
 2026 08:48:54 -0600
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 8 Jan
 2026 06:48:54 -0800
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Thu, 8 Jan 2026 08:48:53 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 08/42] drm/amdgpu/gfx9: switch to using job for IBs
Date: Thu, 8 Jan 2026 09:48:09 -0500
Message-ID: <20260108144843.493816-9-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260108144843.493816-1-alexander.deucher@amd.com>
References: <20260108144843.493816-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY1PEPF0001AE16:EE_|MW4PR12MB8611:EE_
X-MS-Office365-Filtering-Correlation-Id: 17a94121-d521-4f13-7b38-08de4ec50c5a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?yJ1vy0UVellXouxLVYhQdoDgdWIxaKXkVFuXDG06YpxAMm5eINS/8zSl8TZp?=
 =?us-ascii?Q?VtAO18Lo7ZiX3GTXjUNQCS1ikkK6VfHeS7vsUVdpR1Ryw8x0XICtT4g+9Q1i?=
 =?us-ascii?Q?g+fLLNPL5eR445nOF9kjxIx2Evj3u+eHRO+0/ThqP/YHHoSRVuGFDW6WIJZ2?=
 =?us-ascii?Q?ZpyTPtkSBBUNNf7Ppa+OePQrk+7m1BAfwQ+UHyjV3vhTgjWPKccpUpDFSaVb?=
 =?us-ascii?Q?qpI7tKyq7ld/WrqPhwegqqFysqwo31CAoNZDxpoasBaW7/xiDCK8RdbIKfMs?=
 =?us-ascii?Q?TfGzEVjG8NVQsyNcS/ewQto7tC2QHpI/Qv2OW9pi+rWQi9YcaWkRLcolNTKl?=
 =?us-ascii?Q?jaopfv/DuebI3dnpV+WeYjg2CArJvMIXLppS9Qdkb9JIN9+x1f3px3zh084W?=
 =?us-ascii?Q?0w3ZZRS+t2LF2gjxeoVbLEAxakj16/sNBkSla9VSEF5ncFXcu3AfMgyk3Zjv?=
 =?us-ascii?Q?RVHTn4T2+EDPOBJsgCnpfZuXtVmE578bwehMVibEBC6TP6QvdoAgCxWRa2Lo?=
 =?us-ascii?Q?Zp2r6YCHo9IQkjD/thjSZ+2aezYkA1Ih1w2wOA+3ZPVZJnVQcol207cc2fMM?=
 =?us-ascii?Q?EdfsOIQfFzFMGfOfb32+i+yk42sYUacJ19wUQ/hzwz5/yfC5xZoSzNC6cZCT?=
 =?us-ascii?Q?uxKkXafgrn597CTa/QO+kvpcURGU1sTMQN16Z4COUPWpcYewXIRMPeZWpzJv?=
 =?us-ascii?Q?UDXaIrDci841i9W8DBVGMxI4H3VSiOnkGh/4aVM1aX93INm2WOjPuUTEG33t?=
 =?us-ascii?Q?NMOR7V+tP77I5xKfl8QbMfQ6oqO7oWxk6NG9pDIMZrzyDqucWGIvjgh/XjYl?=
 =?us-ascii?Q?RmU4mMgTeKe+SVlNXI2epIEFxf7s4am7S6LMsdcqzWAYY+f3HY6ybNrWJy+T?=
 =?us-ascii?Q?HGKnDmtAoKYXyAJSO9SBMdmrPnQW1UwNADT2+aQdwlT2o/n61X0BA1xuZeDl?=
 =?us-ascii?Q?0SK5Dl7kBpupVvcB+I87cRuXGe8YYpXQznws0289hMHDJSdmW3PHedRpX+Kv?=
 =?us-ascii?Q?wOG/p/wQE/HQlH0g85pEsyYxXjAVh/s+EkruFzg4CCJNbm/LywhHHCYl965Y?=
 =?us-ascii?Q?NVpUvRVrn6ZRctY5omlieKpRyeTaJNBalx7pTA2yuVxvhV8gsxkiVT17uNbM?=
 =?us-ascii?Q?U+cTF+Q92PoTqTKHDQoc0PWhzOcQIZony++Q77s0rDVFfQ+BHUSnohlTW5jI?=
 =?us-ascii?Q?xFfhD3ezjVwcDIjAud+Sr3e2H+Rlrq6NMLjyr7LSyP0sEv8vdDPNRsYCGyAR?=
 =?us-ascii?Q?+91Fdiz03URH7vGsbVLv6iekWym1/acCMKFu3CRg3s2aDBynOAp8KC0NQDvW?=
 =?us-ascii?Q?vejOqdNfGoac+VEqNSra4Gx95f1kryWrihU9HkHVVVY1pGd0Z8+1UXfSZHb9?=
 =?us-ascii?Q?aRwjIvyPyHCmd//uCI8GhWaDdm+zQeE496tvFDBP6G9u3m35aq1jZPjhKkrA?=
 =?us-ascii?Q?mPfjU8D0zc3ZWYpcsOSxQ4wqC4WyaEjuKtrh9LJ3JyM+ObpHu5LBq9t28itT?=
 =?us-ascii?Q?REncKcVvKzBf08/9eMYKOEDtqnQFYBRMXDsxLZfFF0hkQXfeEG8pPRAUVDXv?=
 =?us-ascii?Q?xLK4/JsJBzWSJUtyFJc=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2026 14:48:55.4595 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 17a94121-d521-4f13-7b38-08de4ec50c5a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BY1PEPF0001AE16.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB8611
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

