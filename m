Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D44BDD38FF0
	for <amd-gfx@archiver.kernel.org>; Wed, 14 Jan 2026 16:47:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 61B8410E63F;
	Wed, 14 Jan 2026 16:47:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="J0jcSlE4";
	dkim-atps=neutral
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010001.outbound.protection.outlook.com
 [52.101.193.1])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E9FE910E05F
 for <amd-gfx@lists.freedesktop.org>; Wed, 14 Jan 2026 16:47:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hrqpxjCyvBaDwSZWuN5fHvpCIy22F91SA1lAKQqnxTj90B+yTo4kFxlpOtusgM3ad3pUzBYP57XQi9cOHiHg69bZunRLzxTXSYqcJUDjmaHy42ueRwYmCQ1Xh6qC5npK1CRRMuOUODE4ONTE92NVO+me8+8/gxFWrc4xTCUzua1gchdml/STfFkqUB7q8g6Llvouq3g5EuVE3d0iz2wx3qRB/R4OjGCxwF8SdvMfOo7sN2wURcT/ajIcKBZG3NPiaZBQGB5Hcweg43FVEkvdc3RK4qtZ8lAXmp/c4IBqWFD0UUf7aG9Ig7sR7zhEWWfyW/CsyUQpIVz7ExKou/lnzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aPd2REzmd3dd6mLFQmZUhqOHi+jyCry97KG2ukxXeRk=;
 b=kEYU4KiE+b2yMt/8fvHOiJKcRP0i2o+1gTG32W2mwqfA+OhiU/f+GaN9rT/Y952kosinnRZsONE6reLTdm9w55tt81XSrIP6ZKQi9O6U2Dy2sePgg5lKEV1sLIiiR8RaYPLVzyeeOGuoLAIr7N522ukZn5RHDVZVrOpWHN4oCbS8vNkmyYYnW85SjR1/7cybOb2EafJwlLWyis9T57jttfYayCz3M7hQCwx2qDJSPsC7AF2tFXiONL2y9pHHE37Gug9ynjBmJKVGZ3PcnYmFKtE1lNcqhkl88E+KiLBAuwX7EQrwY08OyO+VdsnV56/Kt03wvosfhddJtgk8N9cPeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aPd2REzmd3dd6mLFQmZUhqOHi+jyCry97KG2ukxXeRk=;
 b=J0jcSlE41lEDjZUd0fZMF3xfpRSIsyUG1rs4tG7IPdISBptFaLrBnDhUL53XeRF8reQtM6rarZkCAO4UOzuV0at7zROwUPLmQInLa6Bp73Vxk+6MOajQeIzXFTWiO2/ByRfPZfLCQxwI0Z+UbMAyubD6uF/4giWnNF2fG6rmPu4=
Received: from SJ0PR03CA0244.namprd03.prod.outlook.com (2603:10b6:a03:3a0::9)
 by SJ2PR12MB9113.namprd12.prod.outlook.com (2603:10b6:a03:560::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.7; Wed, 14 Jan
 2026 16:47:47 +0000
Received: from SJ5PEPF00000203.namprd05.prod.outlook.com
 (2603:10b6:a03:3a0:cafe::fa) by SJ0PR03CA0244.outlook.office365.com
 (2603:10b6:a03:3a0::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9520.5 via Frontend Transport; Wed,
 14 Jan 2026 16:47:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SJ5PEPF00000203.mail.protection.outlook.com (10.167.244.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9520.1 via Frontend Transport; Wed, 14 Jan 2026 16:47:45 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Wed, 14 Jan
 2026 10:47:44 -0600
Received: from satlexmb08.amd.com (10.181.42.217) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 14 Jan
 2026 10:47:43 -0600
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Wed, 14 Jan 2026 10:47:43 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 16/42] drm/amdgpu/sdma3: switch to using job for IBs
Date: Wed, 14 Jan 2026 11:47:01 -0500
Message-ID: <20260114164727.15367-17-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260114164727.15367-1-alexander.deucher@amd.com>
References: <20260114164727.15367-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: alexander.deucher@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF00000203:EE_|SJ2PR12MB9113:EE_
X-MS-Office365-Filtering-Correlation-Id: e67752dc-b6c0-4729-4347-08de538ca496
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?qEC3Qrsl5rkaTiyXPXJm7JU+mu8KyCocYf99YsopfAAEJQ9m/eZ9y91Wx4gB?=
 =?us-ascii?Q?4IAY+QRjWaU8SwPH8dKq74efHKvWp/WS8zTqNjQC/PDbX/6NhewFM/RxwI3I?=
 =?us-ascii?Q?n/ex3XTeTLqHpFaoMbRLP9NusMAsr2pXorqlm1LSV1TqyfO7dhMVkRahe9di?=
 =?us-ascii?Q?kNCs1Kf+hX27oRfsCKXbyC6bAzeIPMT7CNKGxqQ+/Gi1C9JO8/u9/37Y8k1z?=
 =?us-ascii?Q?j//RsdGsFj4Isvs1P/7ZZjgbYKXsZvARDW+Cw29YmP6lYHB398p/Lst/K85B?=
 =?us-ascii?Q?X1Jsz+wJl+Qyj6nGSbMF0C5m+vU+moijZXQROiYvW544f9H84Byeethk6RGM?=
 =?us-ascii?Q?UU1oGGX1MuyokUhEHDd/4vuBGjyb89wKA/77bPcotnPFYERm8cCtc/IPSgev?=
 =?us-ascii?Q?Nh7WiLZLz22B8H8Y7tbDhHwj3WXtqXoUqj8ehEjkY5LDFXIUXdTcSP++oTJa?=
 =?us-ascii?Q?QlKNIfMTD487JwKgAl/O8lK82nw3QDgn0OPfSeuvvpz9D3zS8lvpvOpOM6cO?=
 =?us-ascii?Q?526N+LL1BxDt1kWozpgHAF8jSoQe0irTpKr+JxUBzNDi7IO8sOCVuF1hP+MI?=
 =?us-ascii?Q?p+iEib+pPhe1ATSGqe2OJLP4XbDW+cIftUYa3lDJxqjSodBI5NbKEyA4M310?=
 =?us-ascii?Q?/9FqvSk0Actw3BhSNlubYD9aj+DP/NuiePQO/8nKg9EisH1vcbVm69gistVe?=
 =?us-ascii?Q?edj61DznQkJyNXmcOHNQq4FMcxIEwaOioPsMOlGROdytXOJ8MJbiksM5f7qk?=
 =?us-ascii?Q?CQgQLNh+wauRSp3aj5d4ADQh5iBu5TME7MV0XlRuf3hCdJxntFa3X2frR7l3?=
 =?us-ascii?Q?FSDsT8Akb2QVYSvbw+9mu7yyqKX+ca9psIuGgnuabfGUPWU8p7Ez2C3FInLR?=
 =?us-ascii?Q?gZ5++Itmzg2fvkQmxVHfFPRMxyig7Gtx4SGn0hQswm4I5Ouk/uW5rHZjnvu7?=
 =?us-ascii?Q?CwGfcwwJvz9Y+wsdAwnyWWtWcbbCse8b5uW59n8eH5Y+7bOErIiiiBCIYYn6?=
 =?us-ascii?Q?xnzGGRV81Md+kzzF+WP9Tixi+P/90saXCLTK243iTor0Joa9O+agfDo5gL1U?=
 =?us-ascii?Q?5UFSdAJBFPXn1+ZcW90sizu6FDDpEhonocSqnk7VbVX5WQx+X1iq2bXIzeh2?=
 =?us-ascii?Q?NhVXGOAd52JthkizU78PKzwELlmE9xpZaL2wSN7u+NEJw5cwYlmUnc2IdjWX?=
 =?us-ascii?Q?zu2zkkNdCVARKpNsWQrlBqr4KgUErguLfs4Gb6beoM1cyjoEh7fQ2cLUpVgX?=
 =?us-ascii?Q?nip9q7091qDbqNVMECFUstmstltt26t5932fjCvZR45fkOf/iL9BEw7/ReTF?=
 =?us-ascii?Q?b0SEP2dT6zcP2m15rVTxl6rN+25Nrl1UEjkf/XcM9yBeTNCeSIsDnQUva4yS?=
 =?us-ascii?Q?gm0B/kqAovyzARlDkBt8buTYdXExKuNVpd11jHa5oOCeL1xwHMpQmJ8z5QLW?=
 =?us-ascii?Q?QcHfWLc6SMFoEHY39sFTfCAM+2G0jgpgKRLAPHy4EC265jPjBU0XGBZq6aKD?=
 =?us-ascii?Q?nObY8b5gLyDhU4gZcAD7+WFT7yGTiMnf/x2OMWm5NyX7t3QKGXgc1VvR7PHS?=
 =?us-ascii?Q?cw9X1otDdRQcGPKrkC9evvN0tcmEqpX2SSZOyGBb8VBC65+3IM6FjSKzpkHv?=
 =?us-ascii?Q?j/DDEPIF3ZcOgJWsx6z5YOhiactz3ddC8iy4VWvjnb8OnMnR7MhYNTMY/DZQ?=
 =?us-ascii?Q?tMMCCQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jan 2026 16:47:45.3685 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e67752dc-b6c0-4729-4347-08de538ca496
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF00000203.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9113
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
 drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c | 38 ++++++++++++++------------
 1 file changed, 21 insertions(+), 17 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c
index 1c076bd1cf73e..f9f05768072ad 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c
@@ -858,7 +858,8 @@ static int sdma_v3_0_ring_test_ring(struct amdgpu_ring *ring)
 static int sdma_v3_0_ring_test_ib(struct amdgpu_ring *ring, long timeout)
 {
 	struct amdgpu_device *adev = ring->adev;
-	struct amdgpu_ib ib;
+	struct amdgpu_job *job;
+	struct amdgpu_ib *ib;
 	struct dma_fence *f = NULL;
 	unsigned index;
 	u32 tmp = 0;
@@ -872,26 +873,30 @@ static int sdma_v3_0_ring_test_ib(struct amdgpu_ring *ring, long timeout)
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
-	ib.ptr[3] = SDMA_PKT_WRITE_UNTILED_DW_3_COUNT(1);
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
+	ib->ptr[3] = SDMA_PKT_WRITE_UNTILED_DW_3_COUNT(1);
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
@@ -906,7 +911,6 @@ static int sdma_v3_0_ring_test_ib(struct amdgpu_ring *ring, long timeout)
 	else
 		r = -EINVAL;
 err1:
-	amdgpu_ib_free(&ib, NULL);
 	dma_fence_put(f);
 err0:
 	amdgpu_device_wb_free(adev, index);
-- 
2.52.0

