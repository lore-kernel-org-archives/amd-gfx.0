Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03EC7D38FED
	for <amd-gfx@archiver.kernel.org>; Wed, 14 Jan 2026 16:47:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9A35710E05F;
	Wed, 14 Jan 2026 16:47:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="cczvc90P";
	dkim-atps=neutral
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011005.outbound.protection.outlook.com
 [40.93.194.5])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 639A610E641
 for <amd-gfx@lists.freedesktop.org>; Wed, 14 Jan 2026 16:47:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GEYbyWczi+dNdK8gL105S1gQtT9riz5sv9ui2567qJFWlvsKjcOeBxBAIz1Ful8OtPw1xi0kExPgVPTBLUjcyYLiqW8++8iaYWbZWsLusVoURJfX/NvFjQHmOSy3szksm4zf2Hxun/6Y5+mMAQlNbhP1NRGi8ZtQFDuJPobbGfraS3JubJwWsdqpH8/nElsqSuEFGFUQnK4pQqF39NTlv0eq9lFClJcLhS6Cnw5AVHfi5U1WriwrGnvbvNgIbRJLfJPr7H6wtiA5rty7dm2bNxDt2pZNeXuT2Y5gdtpu/3DJJjMHZUKkYRKU0Lp4hHmx42HJlvvS/zbXW8KwIMQ64Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W6kzMH4dhC/439IPdi1wsziEZIbnOMq+H3OPCw4i0pQ=;
 b=NwKJMBwCn0oGuyP/IsujlZgBN7qYzTCKmbiPGZkuV/eEfP7pKoeNa0zA/XSzbuXH2KkffK2w4ItaPIjssLkhhT6sJZqXNF23HicwrL4LtzoAW3m25hWkisP6OFGOjeUbN+GGMJGUs3lOL9AzeP56aBWraDL1SoE7hYP2p5a50SmNfWf0rY5cSkg/TkgBBA4x0ElE/uplAkBY8uBWfSJqRjSx8QRwGapxsWZCD7u8j58JU06W4PfxW9M8Q1ijG7naSF3a+hD0QRJJ4Mf8nPVhAab/82+Vd5F3IRkV4Bt02uJ4WbTjG2tqGbMYyX3Cj4iOj/rL0HlYWrE3UDqkgeG4qQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W6kzMH4dhC/439IPdi1wsziEZIbnOMq+H3OPCw4i0pQ=;
 b=cczvc90P2nksYDKL3uQzyavQxU7cr5lP4a8JgDectmh3vJrcBYT/YSl/aOt+HysEX4bMTzj/H9nkFn+bcT4i2HRcrFc8TdA0VQhE8QWM6b+4yN6YIfDP+gdq1XScWtxxN5c9CwUQzmr124/gqMbTmiwliNC3BWKeQdkGVyPPsQw=
Received: from PH8P221CA0001.NAMP221.PROD.OUTLOOK.COM (2603:10b6:510:2d8::16)
 by IA0PR12MB8280.namprd12.prod.outlook.com (2603:10b6:208:3df::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.5; Wed, 14 Jan
 2026 16:47:46 +0000
Received: from CY4PEPF0000E9D6.namprd05.prod.outlook.com
 (2603:10b6:510:2d8:cafe::c) by PH8P221CA0001.outlook.office365.com
 (2603:10b6:510:2d8::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9520.5 via Frontend Transport; Wed,
 14 Jan 2026 16:47:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000E9D6.mail.protection.outlook.com (10.167.241.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9520.1 via Frontend Transport; Wed, 14 Jan 2026 16:47:45 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 14 Jan
 2026 10:47:39 -0600
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Wed, 14 Jan 2026 10:47:39 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 07/42] drm/amdgpu/gfx9.4.2: switch to using job for IBs
Date: Wed, 14 Jan 2026 11:46:52 -0500
Message-ID: <20260114164727.15367-8-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260114164727.15367-1-alexander.deucher@amd.com>
References: <20260114164727.15367-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D6:EE_|IA0PR12MB8280:EE_
X-MS-Office365-Filtering-Correlation-Id: 702c8644-2e4c-412a-e822-08de538ca4ce
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?7VG3MBVOnql6JykLh/b9mMlT1a4cQNajBEF2TpQTgimkvVHpuMaybZM19GcC?=
 =?us-ascii?Q?1cf5KQrGZApXMwpz/mc4QH0jSiejoBbcIxJiksW2zgD6jNFh4L846anMAlrG?=
 =?us-ascii?Q?mzK1nguC9d3GBQNe/oVOEzyiHrfN194WNmsiG2g1hWcqMBm/+dDZiIBA7GIr?=
 =?us-ascii?Q?K7S1u5ZGiD6P6BRUHC0XftIgp0JHl9I+/EjBMATHQ1mpVuB4TuY4OzjQ4E+e?=
 =?us-ascii?Q?eY3b5wJsWZqNtuqvVPcCszCitPA2oTHhXVLkhknK8mBeLwE327WZKKN4ypxH?=
 =?us-ascii?Q?XpUlkYpzPpr1yPkGywyDv2FEUYJVaUdYI2+Rwooi58Kuf+ZK8iQjON7Z83Vg?=
 =?us-ascii?Q?oP8rR+/2cnfaG5Tf0iqgamDlPYQDBvpNL2wZUis9bgax7hOci+DWhG6EdIsm?=
 =?us-ascii?Q?j0pgG/ktYknI6K9j2pasYFd3+kXqEMZS8Lwu1ZYJLJlGT0NkNEoQbcwGWw8W?=
 =?us-ascii?Q?2LXVUTJH4CJW+OQqtyvtmmQx3C8oqD4pOoGY3ZkTCV2GkPOvPA70HdNErTFn?=
 =?us-ascii?Q?WKeDZoIE8Yt4zAXasK2XyK5OjHpzN+ZtZuhPbVrRlVYCwY/TF1uav/rpE/Dl?=
 =?us-ascii?Q?/OqeRq8XEImg3JrRkgMnF8AN0X4sEq2eDlkZfTqXubq041gumsZyzCSgUA06?=
 =?us-ascii?Q?dk8hsdIwu9zTneTigDGBdVSgopUQKG+DdEr+XuVQ0uQPqu32XsR1mnnlzLMs?=
 =?us-ascii?Q?W+nGNomw3LbxMMOrboO6/FZLqJSfHnkzq/jwRsDXk9s5j0rW5RfCh0HM8S+y?=
 =?us-ascii?Q?yiT56t8t6u/iJhd2atV+cJzlkkN09wEJLE2TP9dUze5Zd6Ph2PTumMXZFkWX?=
 =?us-ascii?Q?Id7UP8hZijA1D8b02/aXdl+sajIN+JloQ5OKfuANGcbsUrWJMjPgGsnKo89i?=
 =?us-ascii?Q?JOI+kQff4TJ3PEV4JJENXgLSI8W3CmWaXO0V8Agzkl/6Ylln64+jzhv/h/Bt?=
 =?us-ascii?Q?hxyBv8POwMUkHw9BpfH14pAQhoo/sfkcaHSd5A/L3oU2FeDZv2KdXC3lt+do?=
 =?us-ascii?Q?LrPrdJE2NILXRJCempZNog7EzasJ8/4snDf1Qye9p3Rn6Mc/wLpByL8SXlpw?=
 =?us-ascii?Q?hOltdOdcsizJ1SWEt04e3I8iRqD8tNX80P/q/dcpf6OWO9rEAFuKnOwkGpD3?=
 =?us-ascii?Q?pAzBtMXBl8i0UN0J40v8+6i2TTpgn2uZBPlhsxSxpALA9RsOOKVlc8ViYKt4?=
 =?us-ascii?Q?QlQrH12yGKoroKU/AWvGs6pUAZ+q1eX6QHP7mkFNvNi3keQ4c+4Ta1cS8BPl?=
 =?us-ascii?Q?ALjEHwu3HtJ29yMWV7X4u/O8l/OUXJNPcR8hy7O4fg20iuLkgIWmeqeTQhHw?=
 =?us-ascii?Q?61L4nBbdLrGNQGWyNp5nbtJL1t2WvT9XI5+SeJ+JrSl+AHdDE9j91ZIUv9H3?=
 =?us-ascii?Q?eEOnhY6kxusy5bQGKlTPU0irBk4T1G53SRSXDR8LFzTFUrEpnjcsMNLGTXv+?=
 =?us-ascii?Q?ZhVoYpsVpn7+10iba7L7oTOY6D90FhA58GusVcDnRrje0HwlXl74MLjzvTzi?=
 =?us-ascii?Q?/qW1JY3W3tYpcKuEzNEqp3E0lENcDx6UFw13qvGYI6/iNrUgvbHZ+yHNjvza?=
 =?us-ascii?Q?DKPrTk0ETHWLC+y89RmkFzv/rZdkK0bZiXvjwYA+7K0ZfmRSg9yI82kpNf7L?=
 =?us-ascii?Q?UdFJIttQErzVXu93/iX0DH5QWsJ5zh6A9luwprpaDAWHC4QaaFOSgL40vGzk?=
 =?us-ascii?Q?8NWeKg=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jan 2026 16:47:45.7871 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 702c8644-2e4c-412a-e822-08de538ca4ce
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9D6.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8280
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
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.c | 26 ++++++++-----------------
 1 file changed, 8 insertions(+), 18 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.c
index 8058ea91ecafd..424b05b84ea74 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.c
@@ -345,12 +345,13 @@ const struct soc15_reg_entry sgpr64_init_regs_aldebaran[] = {
 
 static int gfx_v9_4_2_run_shader(struct amdgpu_device *adev,
 				 struct amdgpu_ring *ring,
-				 struct amdgpu_ib *ib,
 				 const u32 *shader_ptr, u32 shader_size,
 				 const struct soc15_reg_entry *init_regs, u32 regs_size,
 				 u32 compute_dim_x, u64 wb_gpu_addr, u32 pattern,
 				 struct dma_fence **fence_ptr)
 {
+	struct amdgpu_job *job;
+	struct amdgpu_ib *ib;
 	int r, i;
 	uint32_t total_size, shader_offset;
 	u64 gpu_addr;
@@ -360,10 +361,9 @@ static int gfx_v9_4_2_run_shader(struct amdgpu_device *adev,
 	shader_offset = total_size;
 	total_size += ALIGN(shader_size, 256);
 
-	/* allocate an indirect buffer to put the commands in */
-	memset(ib, 0, sizeof(*ib));
-	r = amdgpu_ib_get(adev, NULL, total_size,
-					AMDGPU_IB_POOL_DIRECT, ib);
+	r = amdgpu_job_alloc_with_ib(ring->adev, NULL, NULL, total_size,
+				     AMDGPU_IB_POOL_DIRECT, &job,
+				     AMDGPU_KERNEL_JOB_ID_RUN_SHADER);
 	if (r) {
 		dev_err(adev->dev, "failed to get ib (%d).\n", r);
 		return r;
@@ -408,11 +408,11 @@ static int gfx_v9_4_2_run_shader(struct amdgpu_device *adev,
 	ib->ptr[ib->length_dw++] =
 		REG_SET_FIELD(0, COMPUTE_DISPATCH_INITIATOR, COMPUTE_SHADER_EN, 1);
 
-	/* shedule the ib on the ring */
-	r = amdgpu_ib_schedule(ring, 1, ib, NULL, fence_ptr);
+	/* schedule the ib on the ring */
+	r = amdgpu_job_submit_direct(job, ring, fence_ptr);
 	if (r) {
 		dev_err(adev->dev, "ib submit failed (%d).\n", r);
-		amdgpu_ib_free(ib, NULL);
+		amdgpu_job_free(job);
 	}
 	return r;
 }
@@ -493,7 +493,6 @@ static int gfx_v9_4_2_do_sgprs_init(struct amdgpu_device *adev)
 	int wb_size = adev->gfx.config.max_shader_engines *
 			 CU_ID_MAX * SIMD_ID_MAX * WAVE_ID_MAX;
 	struct amdgpu_ib wb_ib;
-	struct amdgpu_ib disp_ibs[3];
 	struct dma_fence *fences[3];
 	u32 pattern[3] = { 0x1, 0x5, 0xa };
 
@@ -514,7 +513,6 @@ static int gfx_v9_4_2_do_sgprs_init(struct amdgpu_device *adev)
 
 	r = gfx_v9_4_2_run_shader(adev,
 			&adev->gfx.compute_ring[0],
-			&disp_ibs[0],
 			sgpr112_init_compute_shader_aldebaran,
 			sizeof(sgpr112_init_compute_shader_aldebaran),
 			sgpr112_init_regs_aldebaran,
@@ -539,7 +537,6 @@ static int gfx_v9_4_2_do_sgprs_init(struct amdgpu_device *adev)
 
 	r = gfx_v9_4_2_run_shader(adev,
 			&adev->gfx.compute_ring[1],
-			&disp_ibs[1],
 			sgpr96_init_compute_shader_aldebaran,
 			sizeof(sgpr96_init_compute_shader_aldebaran),
 			sgpr96_init_regs_aldebaran,
@@ -579,7 +576,6 @@ static int gfx_v9_4_2_do_sgprs_init(struct amdgpu_device *adev)
 	memset(wb_ib.ptr, 0, (1 + wb_size) * sizeof(uint32_t));
 	r = gfx_v9_4_2_run_shader(adev,
 			&adev->gfx.compute_ring[0],
-			&disp_ibs[2],
 			sgpr64_init_compute_shader_aldebaran,
 			sizeof(sgpr64_init_compute_shader_aldebaran),
 			sgpr64_init_regs_aldebaran,
@@ -611,13 +607,10 @@ static int gfx_v9_4_2_do_sgprs_init(struct amdgpu_device *adev)
 	}
 
 disp2_failed:
-	amdgpu_ib_free(&disp_ibs[2], NULL);
 	dma_fence_put(fences[2]);
 disp1_failed:
-	amdgpu_ib_free(&disp_ibs[1], NULL);
 	dma_fence_put(fences[1]);
 disp0_failed:
-	amdgpu_ib_free(&disp_ibs[0], NULL);
 	dma_fence_put(fences[0]);
 pro_end:
 	amdgpu_ib_free(&wb_ib, NULL);
@@ -637,7 +630,6 @@ static int gfx_v9_4_2_do_vgprs_init(struct amdgpu_device *adev)
 	int wb_size = adev->gfx.config.max_shader_engines *
 			 CU_ID_MAX * SIMD_ID_MAX * WAVE_ID_MAX;
 	struct amdgpu_ib wb_ib;
-	struct amdgpu_ib disp_ib;
 	struct dma_fence *fence;
 	u32 pattern = 0xa;
 
@@ -657,7 +649,6 @@ static int gfx_v9_4_2_do_vgprs_init(struct amdgpu_device *adev)
 
 	r = gfx_v9_4_2_run_shader(adev,
 			&adev->gfx.compute_ring[0],
-			&disp_ib,
 			vgpr_init_compute_shader_aldebaran,
 			sizeof(vgpr_init_compute_shader_aldebaran),
 			vgpr_init_regs_aldebaran,
@@ -687,7 +678,6 @@ static int gfx_v9_4_2_do_vgprs_init(struct amdgpu_device *adev)
 	}
 
 disp_failed:
-	amdgpu_ib_free(&disp_ib, NULL);
 	dma_fence_put(fence);
 pro_end:
 	amdgpu_ib_free(&wb_ib, NULL);
-- 
2.52.0

