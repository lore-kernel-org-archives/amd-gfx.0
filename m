Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86F90D1D465
	for <amd-gfx@archiver.kernel.org>; Thu,  8 Jan 2026 14:49:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2D17D10E760;
	Thu,  8 Jan 2026 14:49:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="b3sf2B5E";
	dkim-atps=neutral
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010000.outbound.protection.outlook.com [52.101.56.0])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1787B10E767
 for <amd-gfx@lists.freedesktop.org>; Thu,  8 Jan 2026 14:49:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VpENT5HdeTgqRmA+VtcYoeXKfTzERKVuI91V786NZHNwB0qGMxsc9Bk8TZT2q9XxnfCt0HcGJaujnDvrkb4BCFqPx1AS9bdX/HoKHPf9Fh6uCOotjR0/BBU7w6Nwd6c8eCJ4bTM8sWMDG3mhraiHtpzhF8mkwhFD7QcW2rPSQEShUo392qyJxvN/8L8bsz18xl5mK//9km/YYcf4Ky5MalLCMAxS1fla1S7QYqjctnWILbEDxwluHNGctyFYEs/A2S4CDB/lD18IEr8nHvZqAkHIJGzheeSJ2EcW5KJewwEIEJbRAMMZ/6XiROz4I9uaXzhjmLxnNdfyyWL5euIWLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Qd9/3qs7nmmyKxOV0C4ubEP0KMKKaMtJd6v0BIT1nTQ=;
 b=ngvrOHnF221V32yR7qdj3NVMfkT4RUBQo+vaeohARkrVMGgyDurcV+riVS0lruVGDUoCoPJFUKcLreqFRf/tu90gftH1FrBoB4dC7qhxn9Vbgc6PlgESUUfhbMZ1X9zLYTG8uSq1H4oVKrk1cNduQD0CQ1ngzrWE6F7WZKyJX2q0ZhB0AkbiU/labiic+YyVCQRLoqZYGD3qcJWJvBY1CB4+m/P6SqBpUmh0dJ1mUXpRix5F3BtcOVz/2gpoceYn05re9Y28cEFdIhnU16nnR6goIhFI7pJpTf7tKd1yUQC7/zeg5JiqkU6fSVVzylxx+SeDj+Nr1ipmyagSf72kGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qd9/3qs7nmmyKxOV0C4ubEP0KMKKaMtJd6v0BIT1nTQ=;
 b=b3sf2B5EHrrYriUjHOLumYLJ59k2Q+zHmxF6fg+EId+tIBGJK/OITlFo1TO58esoJwxMpbIonbnlCogumoTMIUk0eR0Lh+t1oZCNlmaxkYIP2ojD9pNDFkympLTz1Gt9MirjlfsGQXEVIui+g8jF5LfR2Z6IZcMNcLZOqvfCBkw=
Received: from BL0PR02CA0144.namprd02.prod.outlook.com (2603:10b6:208:35::49)
 by CH3PR12MB7571.namprd12.prod.outlook.com (2603:10b6:610:147::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.2; Thu, 8 Jan
 2026 14:49:04 +0000
Received: from MN1PEPF0000ECDA.namprd02.prod.outlook.com
 (2603:10b6:208:35:cafe::a3) by BL0PR02CA0144.outlook.office365.com
 (2603:10b6:208:35::49) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9478.5 via Frontend Transport; Thu, 8
 Jan 2026 14:49:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MN1PEPF0000ECDA.mail.protection.outlook.com (10.167.242.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9520.1 via Frontend Transport; Thu, 8 Jan 2026 14:49:04 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Thu, 8 Jan
 2026 08:48:58 -0600
Received: from satlexmb08.amd.com (10.181.42.217) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 8 Jan
 2026 08:48:58 -0600
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Thu, 8 Jan 2026 08:48:57 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 17/42] drm/amdgpu/sdma2.4: switch to using job for IBs
Date: Thu, 8 Jan 2026 09:48:18 -0500
Message-ID: <20260108144843.493816-18-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260108144843.493816-1-alexander.deucher@amd.com>
References: <20260108144843.493816-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: alexander.deucher@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECDA:EE_|CH3PR12MB7571:EE_
X-MS-Office365-Filtering-Correlation-Id: 962986bc-aa4a-41c3-5c98-08de4ec51188
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?cqOgxHaQ4YxX8Cw1oqC7fAbVRRZpl/TV/159GrJqU5xIUk/Xp2fksCOKOoml?=
 =?us-ascii?Q?GmxDtwFcNuRlMwM1pVmoNIi4tL2wBeXSJMOZypxb0sgBrWjxu+0vRycHydMR?=
 =?us-ascii?Q?o1pDebF6dkvWpTMWiXC5CycW5Hs1aj7hkL55GoW3cFZ9GmSZ4sc3HcQJEG5l?=
 =?us-ascii?Q?kFUaAI9EiJHFFwxsWx6kNISrJnwoHwf8tFyO7jfVaJ4RLVVOX2Ou+NLkdJRT?=
 =?us-ascii?Q?TnKRqJyHKCVXBetHklSyXQMwnfCYMKCg4QKzyv0GrxniwU0CMC+gRBdM87Gz?=
 =?us-ascii?Q?T+JzzSyc1oi9zyIVBCzHGX/Z6768Zzu5ONvUXhDxPbHDrmwGOGukT9V/q3mb?=
 =?us-ascii?Q?ec7OM7BtoX6tGOmfFwxTjo5SLUqAPRB5N8rnYBxS63erZ6l+c52vLM4cwmit?=
 =?us-ascii?Q?iPM+vAw2a2awfHpSmydZNI4YXBpd9TkqrS05wxEf5jkIaHipx7NNM2uVSswL?=
 =?us-ascii?Q?eCvzqSvkOIaJ3Fk4/FIFDNoL0pmH9RHDRla/JMoKc5nknVc/rCqRI00fwKaC?=
 =?us-ascii?Q?/YRUtEzcxiMXfZNL/bmq7yocWgQ6gXND/51uoz1gXPbtYOR8q8r3/MnE/Psd?=
 =?us-ascii?Q?Cjh5g+IarXWz+bHy+Rgb5VU9zwy0Ex5wtOyJQHX9qapQdCxI04o5fzGUmX7c?=
 =?us-ascii?Q?rG1bFtKaCTn0D9uvOqzuE9XVBCzr0pzDHL86LctnXLvAvrj9QXGRQvrrwuPr?=
 =?us-ascii?Q?XYn021ARUREcnF9CMco9M8/GI6Ks3ECa2DTLC+kImXH2p02Au2waxpJ+af/E?=
 =?us-ascii?Q?XxlaKgvjFkxO9CgfnTwWuxfweZtCJLxGpgdTV/SXc57ExvjbWocPvgFcNWdi?=
 =?us-ascii?Q?Hbe9R1/ZL74sIvPUoCisTVTkK+nXEwtKqoStmaADElm7Ep70byt7+BFNJn0J?=
 =?us-ascii?Q?lD/bDaDaS2+taUhZh9nSCel//VqgdfvKQt3yfdaoIixptDTdMzYj2Yeo7pUV?=
 =?us-ascii?Q?21kTr4UQrQtkwjqxl9Uhoy8q7iBPwhcylcSCtCiWIwkcs2K4RMWdG+p35UHm?=
 =?us-ascii?Q?CQO63xbkd7XPgPeZgU8XnOnSQKkdL9arB0QBkWb/agcoP/wi8paWZ22frupj?=
 =?us-ascii?Q?Hn9C4yCq8uBCz+C1qn/w67dpzSfVvCSTJJthOC5gpkbEuxkoRRxgX+bk06W1?=
 =?us-ascii?Q?UyYgEWBQv0a9Sl644zz3bVpEqZPF46muif0TAkODqK8f/ugjrS9uIApmU6OT?=
 =?us-ascii?Q?RAMzjtGaxl4FDNTWOerpxTpv312QyaVgIY6wOmEB8s7cbDfVI3sDG7Qx3pNF?=
 =?us-ascii?Q?yvA15KNJsvF+/JU7SKRHmFz84v1E+n8zd5j56JGbxgfGtYCCXtWgweT36EgB?=
 =?us-ascii?Q?1ZU+Sbm4YmeONu864Uqsfg8FqGTMrxvMi7nA7zAdS0imtb0B5A6Hjbl31xEs?=
 =?us-ascii?Q?Ayvjn4NB7AWPMqDPSJRpXOHT43Jo+0xBM2HA/6JNPECdfW2ayhljROg1fKyd?=
 =?us-ascii?Q?X7Bck8KGSCjMIkToXLXRORzcZNTMIXOmvA7Y89CXZxuV6W/lEn/sFDDLygdM?=
 =?us-ascii?Q?HtbIhMvZ+TXIq9c8ix+kEtguTKv14jEGul8wooZFvqDTJInm67NHwCuYDpVP?=
 =?us-ascii?Q?6MuC3p9IhRsRF3AV4ks=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2026 14:49:04.2422 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 962986bc-aa4a-41c3-5c98-08de4ec51188
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000ECDA.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7571
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
 drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c | 38 ++++++++++++++------------
 1 file changed, 21 insertions(+), 17 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c b/drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c
index 92ce580647cdc..46263d50cc9ef 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c
@@ -584,7 +584,8 @@ static int sdma_v2_4_ring_test_ring(struct amdgpu_ring *ring)
 static int sdma_v2_4_ring_test_ib(struct amdgpu_ring *ring, long timeout)
 {
 	struct amdgpu_device *adev = ring->adev;
-	struct amdgpu_ib ib;
+	struct amdgpu_job *job;
+	struct amdgpu_ib *ib;
 	struct dma_fence *f = NULL;
 	unsigned index;
 	u32 tmp = 0;
@@ -598,26 +599,30 @@ static int sdma_v2_4_ring_test_ib(struct amdgpu_ring *ring, long timeout)
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
-	ib.ptr[5] = SDMA_PKT_HEADER_OP(SDMA_OP_NOP);
-	ib.ptr[6] = SDMA_PKT_HEADER_OP(SDMA_OP_NOP);
-	ib.ptr[7] = SDMA_PKT_HEADER_OP(SDMA_OP_NOP);
-	ib.length_dw = 8;
-
-	r = amdgpu_ib_schedule(ring, 1, &ib, NULL, &f);
-	if (r)
+	ib->ptr[1] = lower_32_bits(gpu_addr);
+	ib->ptr[2] = upper_32_bits(gpu_addr);
+	ib->ptr[3] = SDMA_PKT_WRITE_UNTILED_DW_3_COUNT(1);
+	ib->ptr[4] = 0xDEADBEEF;
+	ib->ptr[5] = SDMA_PKT_HEADER_OP(SDMA_OP_NOP);
+	ib->ptr[6] = SDMA_PKT_HEADER_OP(SDMA_OP_NOP);
+	ib->ptr[7] = SDMA_PKT_HEADER_OP(SDMA_OP_NOP);
+	ib->length_dw = 8;
+
+	r = amdgpu_job_submit_direct(job, ring, &f);
+	if (r) {
+		amdgpu_job_free(job);
 		goto err1;
+	}
 
 	r = dma_fence_wait_timeout(f, false, timeout);
 	if (r == 0) {
@@ -633,7 +638,6 @@ static int sdma_v2_4_ring_test_ib(struct amdgpu_ring *ring, long timeout)
 		r = -EINVAL;
 
 err1:
-	amdgpu_ib_free(&ib, NULL);
 	dma_fence_put(f);
 err0:
 	amdgpu_device_wb_free(adev, index);
-- 
2.52.0

