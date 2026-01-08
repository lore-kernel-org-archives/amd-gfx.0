Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6902D1D468
	for <amd-gfx@archiver.kernel.org>; Thu,  8 Jan 2026 14:49:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1C66E10E75D;
	Thu,  8 Jan 2026 14:49:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="XtELSUCW";
	dkim-atps=neutral
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012021.outbound.protection.outlook.com [40.107.209.21])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 75B7D10E75C
 for <amd-gfx@lists.freedesktop.org>; Thu,  8 Jan 2026 14:49:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kh//soLU/XF/ouy+EWKYnv7WI+in6CciDD7DWJEetr1E3ezN2bFpok5SRKRalW0igVPAFPbzkl4a35ZFAUva3nhosNH2+HAX5IONxmUwNX/G6+vgHjI8xfmbZfhQecqcIka/Fg+fLPFHg1qLuLPqHjM3abIDN1xz/BiECpza8N1sK9a+L0WyHlBauuOSNQLUhqa6c18z5fZu7UU5EJ1KZ+z1juvWzfK0DwxX/QqCfTF9IE36tfrla1190oXuHQZH899bFEBIUr4dXLyueStT+kIz2qpk60h6paTcW8hs/J9W0At3zq+9/I5S/K7yaexUuFffq1teEeQbgQgYqAXqbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uYZQ7eiv8jMfSXPYMrXFSlxfMwW76UA6+oI8PJDunso=;
 b=PS/uyMylvqx2dfvy7unig0occbIT8uM9p4Fp8wzuxbl1ynfQaFNOtNFWweIW8k9aXPWgLDYBqSQKDx2VXtlGWPliSydeVPnlj9SlSlrN/iYRXC55o3ue0oYYqQ0vTmDzwnFQNqc3r512ozs0GHnZe1AHawxywSIREVW++DHZWJIPHGHvM/kitrLIF4U2hhZyaREhhb2JRtlY+R19dptvMM+WrfOtIMAj1dorekITDPaVOEUHbGTDeFtuhEkOcG71FOY4GQbvpe/Eev2EHWvOHUYigbPqwLtXKiqS6Wo+9ZsF9NBOqZe/cvArkdr8tiiLiFM0aCQC8xZFgGc0+uNYsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uYZQ7eiv8jMfSXPYMrXFSlxfMwW76UA6+oI8PJDunso=;
 b=XtELSUCW0vTIkwwjJowqvgYWFs7h270XGipskDpU1SDOfMxak7QCCZepvWyidrjnJ5ANqpCmOkdSjvcLJCCapx6bzQyHzQ903ckVCbJKlqluirHQNZ3UeEdT3Bw9bJRQbcRg0nQJI+bdr90EDGHdPa7hAvzIm6pSJfl91OxjKl0=
Received: from SJ0PR03CA0348.namprd03.prod.outlook.com (2603:10b6:a03:39c::23)
 by CH2PR12MB4118.namprd12.prod.outlook.com (2603:10b6:610:a4::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.2; Thu, 8 Jan
 2026 14:48:58 +0000
Received: from BY1PEPF0001AE16.namprd04.prod.outlook.com
 (2603:10b6:a03:39c:cafe::83) by SJ0PR03CA0348.outlook.office365.com
 (2603:10b6:a03:39c::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9499.3 via Frontend Transport; Thu, 8
 Jan 2026 14:48:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BY1PEPF0001AE16.mail.protection.outlook.com (10.167.242.104) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9520.1 via Frontend Transport; Thu, 8 Jan 2026 14:48:57 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 8 Jan
 2026 08:48:55 -0600
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 8 Jan
 2026 08:48:55 -0600
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Thu, 8 Jan 2026 08:48:55 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 11/42] drm/amdgpu/gfx10: switch to using job for IBs
Date: Thu, 8 Jan 2026 09:48:12 -0500
Message-ID: <20260108144843.493816-12-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260108144843.493816-1-alexander.deucher@amd.com>
References: <20260108144843.493816-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY1PEPF0001AE16:EE_|CH2PR12MB4118:EE_
X-MS-Office365-Filtering-Correlation-Id: 74433fb9-f454-455a-ae17-08de4ec50db5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?UC8tgZbgURQ09YvhwcN5dvMLOx53IW4PPaikEDlQDYl+wr+LjzlSAjTmG+aR?=
 =?us-ascii?Q?x9AtVVfsBkM3rd3hacwVKYzis5DgiMsSH1c3PEtcfwGAUFR4k6zvPCQ3B89n?=
 =?us-ascii?Q?BId7cTbbNV3wE4+OSvvv4vBORiBVHxN1qtDnyuqDDIqr1seDxzjdzUCcW0Eg?=
 =?us-ascii?Q?Tq8W8iCCcqUqmM1ewg5OqZ8Kl3iymScjSZFz/RPbfAopah18fmDWCpjuRqNx?=
 =?us-ascii?Q?xh+4qEL0qmIo/U1oQx4YnHO2nksBNoXs83FUH6ZfbZT9C0inB0kglbK0h5rn?=
 =?us-ascii?Q?yPrACJnyqYMbnB/etf1ANN8AFUrZuVdxEs+9lMFCsqE5UTQJq/boqi3qx4Nj?=
 =?us-ascii?Q?0+ck/Dj2A+a4LkgtwUjJty5xAi4ggD45+AbJEAzLP4Q1rqEh9aK89KBiPd5y?=
 =?us-ascii?Q?DJrS40T9+CfEOM+fpA/gmfXV9wcOmwJ/ezqgdr89XHs2ui5i/9LJ8PRFPNG1?=
 =?us-ascii?Q?6cWRKMbDqHLfjUkqTENReq4LA4GhO4n1fqyqtqyfEGPbXCHaBgl6MTXXxvOR?=
 =?us-ascii?Q?9rUKJx0tySxby3JU3+cisOzGdV6WuOLfaITDnco2KE0sNEcqwSzKn9HplT9m?=
 =?us-ascii?Q?YI6hz8SfRtln0E2FPtlGULn5rU/fExX1EfIhGuQxN29Sw2Zx5fptPgeEQHQO?=
 =?us-ascii?Q?M6qSVG05Iz7YVdduLKAxcMs04p03MIpohN5uFddvFYLK8TjUf62lwy9BTClM?=
 =?us-ascii?Q?wFKhzhrQt6oD+SF6ccb7QZFUsct/tRYeySYRk1X62ix8Y0QEQ8zF6O043ePV?=
 =?us-ascii?Q?TN394FRmwrF4TnTro52juwt/eVTFCEt8cHksdlqNIZb7+LWYuLLUK7IDxhCz?=
 =?us-ascii?Q?6rVkJcHnXSlhVNspcGGcXiQouXZySxWHLad9jywRgKsHWFNz1sNq+3W5TwCt?=
 =?us-ascii?Q?k88YNeKXXKTbo529DxS0B5dvk5oW6/igh6CckEd6EpkfD8dggT056dWJuSwe?=
 =?us-ascii?Q?sErqQ8ERks0b+6S7hiTrdC214+w6/+ghd/ln/dLRxmf+fpZ4eIZS4xYpgRWg?=
 =?us-ascii?Q?9vL3HGBOCeV39X6egpSZr87EkDP0yRQf7tGtdCwcsDeMH4wURFl1d8f+DskW?=
 =?us-ascii?Q?iipLjSRHrb+iRyI96rD3fVlM+GM2Rn3tafd5ROO2g5Ga7TvNXOpoLEaHOWuV?=
 =?us-ascii?Q?VkT0ziz/WpdIFUqv4LFUrW1fSojIbhd9bSLkPL3flYioSRVY7oySNGeA6lGC?=
 =?us-ascii?Q?sLzB6CzIH8ubELrUtPOqJLIWs42VQ+Bf5VpzGvZn3gSqx3hhaHSZgkwn7OrN?=
 =?us-ascii?Q?SkKgJkMmfgNuySeAlxBunqxaCTgC2UJMNTKeeWq7zuflBt8Y8jDDNXlZdE7m?=
 =?us-ascii?Q?IlEft42nt9ZKWYwp5+Zz6FPtQ+xoMUvKxE0pm5AePxvkCPOLVdB8PdAaDWqw?=
 =?us-ascii?Q?JNBfkey/YLgOx8ZCaJyi7na0ruOqTTRP6r93tqPr35vovoCkZU/saoajQiZp?=
 =?us-ascii?Q?tQZA+EtrGSi3fj+R1Cc1tTQRjX6dIFgSRnKsbZ088n/juDPYZHqrFFhv6g/r?=
 =?us-ascii?Q?/O0h92w1UyP/6CPbY3MeJHGMsnh6sHrHqP1UDYZn+vf47upLUkSmm+B7LgZp?=
 =?us-ascii?Q?x7POuSjvYV5svucbMIs=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2026 14:48:57.7369 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 74433fb9-f454-455a-ae17-08de4ec50db5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BY1PEPF0001AE16.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4118
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
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c | 29 ++++++++++++++------------
 1 file changed, 16 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
index 41bbedb8e157e..496121bdc1de1 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -4071,15 +4071,14 @@ static int gfx_v10_0_ring_test_ring(struct amdgpu_ring *ring)
 static int gfx_v10_0_ring_test_ib(struct amdgpu_ring *ring, long timeout)
 {
 	struct amdgpu_device *adev = ring->adev;
-	struct amdgpu_ib ib;
+	struct amdgpu_job *job;
+	struct amdgpu_ib *ib;
 	struct dma_fence *f = NULL;
 	unsigned int index;
 	uint64_t gpu_addr;
 	uint32_t *cpu_ptr;
 	long r;
 
-	memset(&ib, 0, sizeof(ib));
-
 	r = amdgpu_device_wb_get(adev, &index);
 	if (r)
 		return r;
@@ -4088,22 +4087,27 @@ static int gfx_v10_0_ring_test_ib(struct amdgpu_ring *ring, long timeout)
 	adev->wb.wb[index] = cpu_to_le32(0xCAFEDEAD);
 	cpu_ptr = &adev->wb.wb[index];
 
-	r = amdgpu_ib_get(adev, NULL, 20, AMDGPU_IB_POOL_DIRECT, &ib);
+	r = amdgpu_job_alloc_with_ib(ring->adev, NULL, NULL, 20,
+				     AMDGPU_IB_POOL_DIRECT, &job,
+				     AMDGPU_KERNEL_JOB_ID_GFX_RING_TEST);
 	if (r) {
 		drm_err(adev_to_drm(adev), "failed to get ib (%ld).\n", r);
 		goto err1;
 	}
+	ib = &job->ibs[0];
 
-	ib.ptr[0] = PACKET3(PACKET3_WRITE_DATA, 3);
-	ib.ptr[1] = WRITE_DATA_DST_SEL(5) | WR_CONFIRM;
-	ib.ptr[2] = lower_32_bits(gpu_addr);
-	ib.ptr[3] = upper_32_bits(gpu_addr);
-	ib.ptr[4] = 0xDEADBEEF;
-	ib.length_dw = 5;
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
@@ -4118,7 +4122,6 @@ static int gfx_v10_0_ring_test_ib(struct amdgpu_ring *ring, long timeout)
 	else
 		r = -EINVAL;
 err2:
-	amdgpu_ib_free(&ib, NULL);
 	dma_fence_put(f);
 err1:
 	amdgpu_device_wb_free(adev, index);
-- 
2.52.0

