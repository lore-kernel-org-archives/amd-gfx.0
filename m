Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01509D1D468
	for <amd-gfx@archiver.kernel.org>; Thu,  8 Jan 2026 14:49:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9459710E773;
	Thu,  8 Jan 2026 14:49:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="wRHfU4kf";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013051.outbound.protection.outlook.com
 [40.93.201.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CC0D310E76B
 for <amd-gfx@lists.freedesktop.org>; Thu,  8 Jan 2026 14:49:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=auKGS02B2FI3CDzt3Lj0ne5HGI0YJjCKbxohNWQ7j2uirfvMITNkS9+blKPBOkoawecOSqngFrSp/O9rCSYXgDznMgvCboAcKijHxR7/hHJ1hkQ/msVwi8HOTcOtW1OcxQb+JziWfgf2SK/5aW7QfDKoKOJadjl8ud7N5SUj4O0IJUrhL49TPZDy0GEgxkPzn/RE0zZbxRja4fzO8OatV7HyXGRO8dlhAGYbRF0ygK8lxC9tE05ZghuGuPdyGfVnZE3HSaBLILPTxnQFsP/cqKFMadut5wasJyFhgLeQWwr/HFduyD2nBJ8+Gf0ZZqkFTI2XZgZZBb0JoIJ489zFtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1Ea3qMVyyPwoGnupDmqyLfX7/oKR2Er1ePraw6+AFos=;
 b=HTUGfScfFqCUX1HtayYDfqVbglj7Fub+INlxyKawS88URk+r7dwYSttp9A2rJBY2BZCKEmV9lHViTnca17Gq4vlyt5GIgqlqemJk4+rCdVGate5jCbgV5OBO/zLdXYwgME3AwBt8CFZRRlpxUqa2HB9EnhY9epiy33Wzao53LzmYPi5cSWuhNq9I6cl6FBRc15rOYh52+bjxd8rwubw+tjtd19+A7Qou7bHoJU7HHUY/ZE/jdSg1Xk/VMFWlV4ZaQ4t1v6SwObNNZrFvw/XOa2X2GmVzNYO11jCZXzXYaMeuKAIEJdDM5f65b8hmjjLUBuzDQtIAGjXYxsGw4BFVCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1Ea3qMVyyPwoGnupDmqyLfX7/oKR2Er1ePraw6+AFos=;
 b=wRHfU4kfdXVPg6hoF1u6uWB7xNRjZdKzBPhsEo6Io9/cv5xUqkU1Vo/A0jbCZdNQYZF7EtyUDLIRp8FaAzeV9/t7GUPrQ/GbU4Cf2zdoPPXewmxAGviDytXXe3+rdokmMaDBAfL4vlHCzfV4y6PPK8RBhWNM4OWtdB5JtCq/IfE=
Received: from BL0PR02CA0135.namprd02.prod.outlook.com (2603:10b6:208:35::40)
 by CH3PR12MB9344.namprd12.prod.outlook.com (2603:10b6:610:1c8::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9478.4; Thu, 8 Jan
 2026 14:49:08 +0000
Received: from MN1PEPF0000ECD7.namprd02.prod.outlook.com
 (2603:10b6:208:35:cafe::48) by BL0PR02CA0135.outlook.office365.com
 (2603:10b6:208:35::40) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9499.3 via Frontend Transport; Thu, 8
 Jan 2026 14:49:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MN1PEPF0000ECD7.mail.protection.outlook.com (10.167.242.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9520.1 via Frontend Transport; Thu, 8 Jan 2026 14:49:08 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Thu, 8 Jan
 2026 08:49:00 -0600
Received: from satlexmb08.amd.com (10.181.42.217) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 8 Jan
 2026 08:49:00 -0600
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Thu, 8 Jan 2026 08:49:00 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 23/42] drm/amdgpu/sdma6: switch to using job for IBs
Date: Thu, 8 Jan 2026 09:48:24 -0500
Message-ID: <20260108144843.493816-24-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260108144843.493816-1-alexander.deucher@amd.com>
References: <20260108144843.493816-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: alexander.deucher@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD7:EE_|CH3PR12MB9344:EE_
X-MS-Office365-Filtering-Correlation-Id: 1a827603-51eb-45aa-129e-08de4ec51436
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?+J/ZaqUk4Ck/USp96BYqrPY2mRdoi57aUgGuLps+aJt8tbUchlrmAe7VWB6U?=
 =?us-ascii?Q?FyeP2Z2jxPD/WK0WA+0oY/XSfA4PHQ+AI74NhWSgc4H/OtQ1wDI/zAYM0k/k?=
 =?us-ascii?Q?XumRIp6Hib5DKRrR3rrA+3nJi83HALB5w/Qs0x91Tf9JUD39LpKnsBZ9lRaz?=
 =?us-ascii?Q?9ekNrm2i6pXPt0yOk7/nRBOhFOem98rV6XxPlgvx161VZpq/wWwfQEBTXwHR?=
 =?us-ascii?Q?Jg4N3rBkC5pY/J8j5bW3VoLp86YEcVJdYrT4FKZ6kdH+/R/mHDpIcQlqDQ5A?=
 =?us-ascii?Q?LCBnwyC5KuxgBhX+hBiY8szyv2PHS3y0J2Lj4nr4oPXCo6eVWFC1GwlVdKi6?=
 =?us-ascii?Q?03RzOnk0gOj9h+m44XuQhqsFG/imi1IPtuMAm/wimqjExT1emBwKUpNXdH2L?=
 =?us-ascii?Q?vx1YDTj9m+L21G2PMt48xF5MldL/q/9orkHnILAAOTR9QmKRFGrXB0xf/03o?=
 =?us-ascii?Q?JeCvZHDCvFiW+v6bh54B60IwiE1kqqwtnb9bteDKLbYVHnfjoLNYR2wMqEfY?=
 =?us-ascii?Q?WMN2yhfbh84LhfO11McUX55YkhFFq4A+Vb/fIdATNero9Z8wvYrNYVqWi4OK?=
 =?us-ascii?Q?pevwhNY/HbUvaKFyiV+TqCeowIptBI3bY9s9FSh1kIQ8PtBcqLmaFIKNo1Ak?=
 =?us-ascii?Q?+j7uiXmmcNupa4rCIrwKS5UwDOfvi3+I4NdhoVOT+ywtUzCKmeP+qgesA0Ol?=
 =?us-ascii?Q?vqas/kBoliiuC4L7yX5dqQsEUDlX18llXSY6m3eEKbSE0Wsbg1HBwCWdc0S3?=
 =?us-ascii?Q?kI4k4Ohyc1FxRIF/GJ13d1IUymHd89/liy9Dk8+18IsKldYMj0LUCUA74Syn?=
 =?us-ascii?Q?7FaIL8Ny+1K3mEtNHs+TozBdjTITePSa0VYScgiaMYWkdbRUF2AdMcoP7wtc?=
 =?us-ascii?Q?cd8dOretMet5s/11oHnUetR3cv69IcTW8tZ2l4ZL61sC4c4EFUZYwR/LUQJ+?=
 =?us-ascii?Q?46uVZrwzKv7KHYm7nEYWCmhIIwpudkmK4qzZ49uPyL3aqwXCc7Puh+oYbDqW?=
 =?us-ascii?Q?aeK117y1hiKdn6gvcfJ/uSm7e3B0P/Jcqf0MdiCnf23AIAgpHa6IOc+LOekn?=
 =?us-ascii?Q?LG2dp0CL6WRNKWqbYd/1yLTpMHC3m4bvmhvc9ApxLivtUfcBDDtbOASCJTNo?=
 =?us-ascii?Q?ifby3UJ0pSzXaZyQVffDjUsXYtPI+UIK0QCdIlm3atQL5vnRIZ7lzOehHQnn?=
 =?us-ascii?Q?CwYVq5YIuXDc+wUiZGgTdm2mrTAbLKGBYyhH5AKrJh7d6BTG/ip33ppgpgUy?=
 =?us-ascii?Q?IP6KagpJg9aYsmHDvPLMluB+gcDaDuw1DdYQ3W1KwpUmjA070KpTqFkRccup?=
 =?us-ascii?Q?fKm7DZFme2qW5relIttu/EhICa3LMZfrHtpvI99rHsNTyVxskvEfTjIE0LJJ?=
 =?us-ascii?Q?qorWypwxXCnYBcirb5ADckTFaBns8yfztN/308MTLL/eHwdF+7bMBTOD/jJZ?=
 =?us-ascii?Q?rTtRc0NoWmTDZjPk9AMwOTA5qs+F7p7T32rgfC9BX1iSjWJ4xDzQOnWm2Fy6?=
 =?us-ascii?Q?nc04FQtRlXJON5rMMVsVKRoKF7NOOpDC0VilPdmaHu4uHn6qafuKE48ihqRg?=
 =?us-ascii?Q?rB+Y+y2oZF9KW8dLib4=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2026 14:49:08.7362 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a827603-51eb-45aa-129e-08de4ec51436
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000ECD7.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9344
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
 drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c | 36 ++++++++++++++------------
 1 file changed, 20 insertions(+), 16 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
index eec659194718d..210ea6ba6212f 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
@@ -981,7 +981,8 @@ static int sdma_v6_0_ring_test_ring(struct amdgpu_ring *ring)
 static int sdma_v6_0_ring_test_ib(struct amdgpu_ring *ring, long timeout)
 {
 	struct amdgpu_device *adev = ring->adev;
-	struct amdgpu_ib ib;
+	struct amdgpu_job *job;
+	struct amdgpu_ib *ib;
 	struct dma_fence *f = NULL;
 	unsigned index;
 	long r;
@@ -989,7 +990,6 @@ static int sdma_v6_0_ring_test_ib(struct amdgpu_ring *ring, long timeout)
 	u64 gpu_addr;
 
 	tmp = 0xCAFEDEAD;
-	memset(&ib, 0, sizeof(ib));
 
 	r = amdgpu_device_wb_get(adev, &index);
 	if (r) {
@@ -1000,26 +1000,31 @@ static int sdma_v6_0_ring_test_ib(struct amdgpu_ring *ring, long timeout)
 	gpu_addr = adev->wb.gpu_addr + (index * 4);
 	adev->wb.wb[index] = cpu_to_le32(tmp);
 
-	r = amdgpu_ib_get(adev, NULL, 256, AMDGPU_IB_POOL_DIRECT, &ib);
+	r = amdgpu_job_alloc_with_ib(ring->adev, NULL, NULL, 256,
+				     AMDGPU_IB_POOL_DIRECT, &job,
+				     AMDGPU_KERNEL_JOB_ID_SDMA_RING_TEST);
 	if (r) {
 		drm_err(adev_to_drm(adev), "failed to get ib (%ld).\n", r);
 		goto err0;
 	}
 
-	ib.ptr[0] = SDMA_PKT_COPY_LINEAR_HEADER_OP(SDMA_OP_WRITE) |
+	ib = &job->ibs[0];
+	ib->ptr[0] = SDMA_PKT_COPY_LINEAR_HEADER_OP(SDMA_OP_WRITE) |
 		SDMA_PKT_COPY_LINEAR_HEADER_SUB_OP(SDMA_SUBOP_WRITE_LINEAR);
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
@@ -1039,7 +1044,6 @@ static int sdma_v6_0_ring_test_ib(struct amdgpu_ring *ring, long timeout)
 		r = -EINVAL;
 
 err1:
-	amdgpu_ib_free(&ib, NULL);
 	dma_fence_put(f);
 err0:
 	amdgpu_device_wb_free(adev, index);
-- 
2.52.0

