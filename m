Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39910D38FED
	for <amd-gfx@archiver.kernel.org>; Wed, 14 Jan 2026 16:47:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D34A710E644;
	Wed, 14 Jan 2026 16:47:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Kavz6sxz";
	dkim-atps=neutral
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011003.outbound.protection.outlook.com [40.107.208.3])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CD20110E644
 for <amd-gfx@lists.freedesktop.org>; Wed, 14 Jan 2026 16:47:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=idKPAeFIULN5x5OkxQ8VYuBbxKZBOAYcxMFYOMvuIVShVW+YLRsN8OQMgdIJ73bE2q0XpDzLiXlkKaN1eETk7LVEyOuKxeimxuZ+lcfU0ALpvMK6l5TuxA6Sg30S2xvUv4g3Y8n5hueLH0w1N9ALLajSIorJjF/YkBLoSc8gzaMjM0kS8DiD0A8yc1eID8LNQgRIo39xT337tvSBdPQ+EKtpBNRffYOLPo4EsZgAVx1hLoqkbpkz05gFMmXIwxofsnDFNsjuAZtDebvAQBDrSRME0Bct/YJ45baA31XWIwrjrYqlV8PnPVRzYh5eTi8LzDJPSr9/hUAdRJ0dqY27BA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wf0IMo5hDqxNB7Su/mBBHNz2TM25HrGsmOw+clFyh8M=;
 b=htqx2c4TX/0Y9o12TIFMBg6rIOvSm1nl79Hha8eTO9LPFSio+N1lzZFi3D0c9A+rQGKAs7rZZFVXGY6f64t3xgQOm+sdrEABI45peFkHD8UlzpAcEmyCf2jHoCLf1mQ3HPKOQYNO6xPGmJeorCoD3zd/5QzDVGRKn6C/SeqNtG+ANX8HJfVx/T6QpDhY5Z4lMXMPQ9GJm2kxeW+gaIRb4Pl8gtOaQdwCeM8/nHcOj3cpFzgCwbEaWD22acPDrKcNyVPkv4Dy0Zb8TPYbUCNZ6DjhfJVH5XbOfJQrPlKbtcJ9fFsCWJ9HYUp+5Y6EP+IEio6oks1IZHa+PSNTOEv2OA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wf0IMo5hDqxNB7Su/mBBHNz2TM25HrGsmOw+clFyh8M=;
 b=Kavz6sxz0Bkav4jtLGwaMOB1dT6WWDhXFdJI0CVfAGe4R0heL2fI4b1InJVzeUQ6rWJmWDhcPwPK6Py/2nWvWXLshWg43IouXuMFWON566mBuPbIGju1btVCplxxVvx+nYGJFAmBI7FxWi9iyIVK01KdYloQIt1lYKh2ocGONeU=
Received: from SJ0PR03CA0258.namprd03.prod.outlook.com (2603:10b6:a03:3a0::23)
 by SN7PR12MB6864.namprd12.prod.outlook.com (2603:10b6:806:263::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.7; Wed, 14 Jan
 2026 16:47:49 +0000
Received: from SJ5PEPF00000203.namprd05.prod.outlook.com
 (2603:10b6:a03:3a0:cafe::9e) by SJ0PR03CA0258.outlook.office365.com
 (2603:10b6:a03:3a0::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9520.5 via Frontend Transport; Wed,
 14 Jan 2026 16:47:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SJ5PEPF00000203.mail.protection.outlook.com (10.167.244.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9520.1 via Frontend Transport; Wed, 14 Jan 2026 16:47:49 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 14 Jan
 2026 10:47:44 -0600
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Wed, 14 Jan 2026 10:47:44 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 18/42] drm/amdgpu/sdma4.4.2: switch to using job for IBs
Date: Wed, 14 Jan 2026 11:47:03 -0500
Message-ID: <20260114164727.15367-19-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260114164727.15367-1-alexander.deucher@amd.com>
References: <20260114164727.15367-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF00000203:EE_|SN7PR12MB6864:EE_
X-MS-Office365-Filtering-Correlation-Id: a462cfd5-e0e1-4dd0-72b8-08de538ca6d0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?QjuIc0Pqv0FujPC1D7orFuBZ/QQ4sMRH55lRiUdA6O9oWRZgYd1xI9TNTHWk?=
 =?us-ascii?Q?r52GwwT1adUrJDEscWizmSBwG64LDalrr6HMU9yTb0i0lf/K21hKiSflQO5r?=
 =?us-ascii?Q?tKRp3Azh/R0hIJLwdsWMdnMtd2ZuAeygAxeYllceVTdiLqFmEr8fqG8Y6TW7?=
 =?us-ascii?Q?ftpcQlvtl0k1PSYhpicpOvRxTO25KdQTelOm2hBOV/HSXhK4VZ/X79z57Snm?=
 =?us-ascii?Q?K2wTCylhKCKH0kaRfoMQJNgrc8QiOXLlZIKBUC47v6TZNRSLYw68dHF7GwMV?=
 =?us-ascii?Q?XwSSuc4F9RTVctT1EWHOEqLUTeLyfXJubzKqd0ybWn/5OAOxJ+jPaTThUcDH?=
 =?us-ascii?Q?hkbbUSdzlph/JFxpxyrCb+30fvznyFaM+3wtIApIPsS3oaCYtgBDXYhC95DM?=
 =?us-ascii?Q?pkiP83SLZnsDosTm2gCmWYb2KmIIi/2LsGkDbrdb+CivtseoLgjruXZbhdPI?=
 =?us-ascii?Q?1jwqwqIrKF8a54VtN1Wvz5sF13hp8XAtsq6DhnJ9MSlTdmRzZqcDD0V7ql3o?=
 =?us-ascii?Q?04txW47WQfS3/W+1A1am68EltmOI5RP2T3qU41WAaUO/527YNlygpAx7j8ZN?=
 =?us-ascii?Q?gDrORoLKiRu3kybD9TsTRCCKr/Z6WYUAgVZcuZ+fFQ+FaNeijxdsNsw46KCr?=
 =?us-ascii?Q?6IeHR+wQomjznc0KoIJQj+DUSTq/FqXiLK1x/vw4htx/nXEicQ3GynjZMbmj?=
 =?us-ascii?Q?yQh+e2Ng44SOzfnfRaDM+GiZLmNFyaFCPM3Id7n5Dac+jmD9zpzj/Klh9O9S?=
 =?us-ascii?Q?etrL/uLf2RADf99tpx3Db9ZauKgR+iy5SYQb6O1MtXYKcZfxSE1JLrcPt1Cu?=
 =?us-ascii?Q?OuoxHNG2o572wnJJjCBroT27yV9mnhcGsGjMyIk1vFnj4gbx6jGIWmQcH9Iw?=
 =?us-ascii?Q?W+K6ePp0gxuWnSRBTynQi1MUdI3zH7fMn+/3i51rFiHQitFbxUXf4gIoT9iW?=
 =?us-ascii?Q?3xPPQ50DVX/ksxkKNH9J4BUapsDgwYTBn88EWJKYx0f2Px8y1kHag6pNDLXu?=
 =?us-ascii?Q?rVzVvE3QrWHLLP7MCeRl2fuexSM66yy2enlIdB5c7n4EW5F9Pr0K5nbIRnJH?=
 =?us-ascii?Q?lR/+MRyi0WSjRdJgBlhVn3xJcCWTWV0OzbcPiaxkqGZcpAqW7MpmxCGVQT5A?=
 =?us-ascii?Q?WYEWTLu0ZHuWLODv1zCwculV0G5k9Cw7LJlKotvcE3zSMpygL0AjxgRKESo/?=
 =?us-ascii?Q?3PS4w/oVcG/ZN5mEk8JGaw1VyKiHMCKklW+qlNnI1H6l3t8RKuM7tldXX5FK?=
 =?us-ascii?Q?WgOUjH3gC58hCkdS1BAGC5QsqxcB7x0TJJuyPZIRoA68ySEn4N8iLfBuF7NF?=
 =?us-ascii?Q?M4i5UTXQ65SRzboSLrzFygt3iKq/isbknDdr82sQbustaQVRj43nlwYo925g?=
 =?us-ascii?Q?m5SokBykSKxwq0ZkXu8wxW2zsKNgTCSxjMifznKTwPLmeA4aubtoMsXDXHc1?=
 =?us-ascii?Q?NOZe+cD4XGj20wnf84KfNMoezef+NhFhLsq2b8Pyr2Wor0/Bh4NGAQEQCsk3?=
 =?us-ascii?Q?usV/cW6Axy25Tu3pGxApTdycwUjvmapZRF42MQ9U2XTMPITuc06x6kIlicDO?=
 =?us-ascii?Q?qUru3QYJoMpG+HlH9Pu25BqMeUO/0XRH+jJpDOdSdIr8EL2Ib9f176bXPP3U?=
 =?us-ascii?Q?dvCD0nAgInExLFXUhYvzchQ6TLpbCz+cnvVIXDvbLJiXlQp0AERxHREPdgBt?=
 =?us-ascii?Q?42iDYQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jan 2026 16:47:49.1059 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a462cfd5-e0e1-4dd0-72b8-08de538ca6d0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF00000203.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6864
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
 drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c | 38 +++++++++++++-----------
 1 file changed, 21 insertions(+), 17 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
index a1443990d5c60..dd8d6a572710d 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
@@ -1112,7 +1112,8 @@ static int sdma_v4_4_2_ring_test_ring(struct amdgpu_ring *ring)
 static int sdma_v4_4_2_ring_test_ib(struct amdgpu_ring *ring, long timeout)
 {
 	struct amdgpu_device *adev = ring->adev;
-	struct amdgpu_ib ib;
+	struct amdgpu_job *job;
+	struct amdgpu_ib *ib;
 	struct dma_fence *f = NULL;
 	unsigned index;
 	long r;
@@ -1126,26 +1127,30 @@ static int sdma_v4_4_2_ring_test_ib(struct amdgpu_ring *ring, long timeout)
 	gpu_addr = adev->wb.gpu_addr + (index * 4);
 	tmp = 0xCAFEDEAD;
 	adev->wb.wb[index] = cpu_to_le32(tmp);
-	memset(&ib, 0, sizeof(ib));
-	r = amdgpu_ib_get(adev, NULL, 256,
-					AMDGPU_IB_POOL_DIRECT, &ib);
+
+	r = amdgpu_job_alloc_with_ib(ring->adev, NULL, NULL, 256,
+				     AMDGPU_IB_POOL_DIRECT, &job,
+				     AMDGPU_KERNEL_JOB_ID_SDMA_RING_TEST);
 	if (r)
 		goto err0;
 
-	ib.ptr[0] = SDMA_PKT_HEADER_OP(SDMA_OP_WRITE) |
+	ib = &job->ibs[0];
+	ib->ptr[0] = SDMA_PKT_HEADER_OP(SDMA_OP_WRITE) |
 		SDMA_PKT_HEADER_SUB_OP(SDMA_SUBOP_WRITE_LINEAR);
-	ib.ptr[1] = lower_32_bits(gpu_addr);
-	ib.ptr[2] = upper_32_bits(gpu_addr);
-	ib.ptr[3] = SDMA_PKT_WRITE_UNTILED_DW_3_COUNT(0);
-	ib.ptr[4] = 0xDEADBEEF;
-	ib.ptr[5] = SDMA_PKT_NOP_HEADER_OP(SDMA_OP_NOP);
-	ib.ptr[6] = SDMA_PKT_NOP_HEADER_OP(SDMA_OP_NOP);
-	ib.ptr[7] = SDMA_PKT_NOP_HEADER_OP(SDMA_OP_NOP);
-	ib.length_dw = 8;
-
-	r = amdgpu_ib_schedule(ring, 1, &ib, NULL, &f);
-	if (r)
+	ib->ptr[1] = lower_32_bits(gpu_addr);
+	ib->ptr[2] = upper_32_bits(gpu_addr);
+	ib->ptr[3] = SDMA_PKT_WRITE_UNTILED_DW_3_COUNT(0);
+	ib->ptr[4] = 0xDEADBEEF;
+	ib->ptr[5] = SDMA_PKT_NOP_HEADER_OP(SDMA_OP_NOP);
+	ib->ptr[6] = SDMA_PKT_NOP_HEADER_OP(SDMA_OP_NOP);
+	ib->ptr[7] = SDMA_PKT_NOP_HEADER_OP(SDMA_OP_NOP);
+	ib->length_dw = 8;
+
+	r = amdgpu_job_submit_direct(job, ring, &f);
+	if (r) {
+		amdgpu_job_free(job);
 		goto err1;
+	}
 
 	r = dma_fence_wait_timeout(f, false, timeout);
 	if (r == 0) {
@@ -1161,7 +1166,6 @@ static int sdma_v4_4_2_ring_test_ib(struct amdgpu_ring *ring, long timeout)
 		r = -EINVAL;
 
 err1:
-	amdgpu_ib_free(&ib, NULL);
 	dma_fence_put(f);
 err0:
 	amdgpu_device_wb_free(adev, index);
-- 
2.52.0

