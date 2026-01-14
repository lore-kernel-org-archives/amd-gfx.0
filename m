Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B87D1D38FEE
	for <amd-gfx@archiver.kernel.org>; Wed, 14 Jan 2026 16:47:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5B1B410E62A;
	Wed, 14 Jan 2026 16:47:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="kbfnd2o6";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011042.outbound.protection.outlook.com [52.101.52.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 618BA10E62A
 for <amd-gfx@lists.freedesktop.org>; Wed, 14 Jan 2026 16:47:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fhVi9S0wv6vNodq4rLpOJtPkk4ceAbKszb292VKbny0TK13XvP67P5Xfq1ia99jJvhasyd66Wban4JiqpyCmsAYyP/88GurnGa/a3ZSjce8+Ud/D/pwa/KUnLun5EzcJo0IXi72T8bcgBdaX/41UCdGEcAllTLdeF02pd9UAu5CxrS/guQSF2j8G24bASzebR9Qpp9Y5uoCXjVLN4CLwmkA8jJ1W8o2j0y2fiAFcKTXeFLYXLjgsweKbp4q8BY4V3yTM3fKXfEIwr3CqWwQQisXuZWNwZpaCWh4DVLq8LNRpaDjTmUL5k0f23hicv75WCez4E5qLruNJo1bavAMEjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sAva8hlK48+sNECavskq6c/8oW62R8woRIm1Y9jVqKk=;
 b=T0sdfvi3LQVQV6lEfxpB233CVEVPJZX7ss5UJwuRinOlStP/CjLLFBIlOo+7Ib3BujJWaGzTpLSJX32KYwb0gjBd3IxmitbKrr5PrIxyeIMTcMoDH/YRG6exyNJ5rblqjdlpD93aOG6aYCpe937lubFT7ioEZFgqrZF1DP2SFzJ60GDNbN+nLJZssO882Kq9BB0ACKf+XEM1zr2x/KWu/f8lFDoP715VLxFGDwo1NYuNuRAJh1JxXRH4lOdsO26HCul3Ty0XpIV3MN/gOcfuRFy/iWnuey1Q37fB+RvNrEEQtYr+pBdA3ztBiPL/EGPi0BAZ03yyV88RivvoyWIZYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sAva8hlK48+sNECavskq6c/8oW62R8woRIm1Y9jVqKk=;
 b=kbfnd2o648Zgpd8vI5sylfOtu2eVuNIee9yCKh3tBW3OUETzY32vEM5pat8iItKH58QyGVE35W3QkUTBWHID6Bv/7W14nkFJh77tQiNoMXUjiHp8sw8/Z5UjookAyUsN4v4c51Tqnop4IJ4Q1XfEUPkNRdk9S4tnqGrMAzXtqWo=
Received: from SJ0PR03CA0260.namprd03.prod.outlook.com (2603:10b6:a03:3a0::25)
 by DM6PR12MB4124.namprd12.prod.outlook.com (2603:10b6:5:221::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.4; Wed, 14 Jan
 2026 16:47:43 +0000
Received: from SJ5PEPF00000203.namprd05.prod.outlook.com
 (2603:10b6:a03:3a0:cafe::cd) by SJ0PR03CA0260.outlook.office365.com
 (2603:10b6:a03:3a0::25) with Microsoft SMTP Server (version=TLS1_3,
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
 15.20.9520.1 via Frontend Transport; Wed, 14 Jan 2026 16:47:43 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 14 Jan
 2026 10:47:41 -0600
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 14 Jan
 2026 08:47:40 -0800
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Wed, 14 Jan 2026 10:47:40 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 10/42] drm/amdgpu/gfx11: switch to using job for IBs
Date: Wed, 14 Jan 2026 11:46:55 -0500
Message-ID: <20260114164727.15367-11-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260114164727.15367-1-alexander.deucher@amd.com>
References: <20260114164727.15367-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF00000203:EE_|DM6PR12MB4124:EE_
X-MS-Office365-Filtering-Correlation-Id: aa55cbed-022d-4f06-556a-08de538ca37d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?aahb4I1j2WiP1rELqO0mCcOfK0i3hytBrO3iRZkUKS041o4PzvDCwixq5b3J?=
 =?us-ascii?Q?tC8t1cK8/3+0UtIWzWUM7H9YIDecxqu2D80WWmoEGTl1ujMOdTpimbArKnZX?=
 =?us-ascii?Q?vBiOO7NbwIuD5JSXsHQ278ONeefoBnfQWerScSqaITl9vJwTcR1+574AFI6L?=
 =?us-ascii?Q?cJc1f4shpu4HUJXHrp72uwJeyK3CZtvOb5PqB+qNp1yOp4+zH0kLVctDCHzt?=
 =?us-ascii?Q?kxGtsw7nqt4mKEXbPmMazRPYMtB6mXfwOmBWZUgRBM7gBwuHjMKnOPvJYLn0?=
 =?us-ascii?Q?WfW2w5SOx+q4ENgyHW4BQkZ2SqdW/F4I3FzTz2Se+NrVClxnOUfaCXa7gaai?=
 =?us-ascii?Q?zHY1aZR7tglc2WfzvUf8lU2A2IGqqYhmTBFsEVRSAEAlsGA7EnEQgxpgllEj?=
 =?us-ascii?Q?5fEMp7P86ZBS+gXfxHkNIObYnB9WfY5KNWcONjG27a5SL8o0Gvjs4wQ0LRiL?=
 =?us-ascii?Q?PXkww6gyzEERvuqI5lwYagd+hQfiKKNFvOmc46PBTP/6VRZNkd9N0mRQ+F9C?=
 =?us-ascii?Q?9AhDfB0qhOwZXwKKWKJYNCulBmlYni6K965iiY5kepqIfVaLlB+M3vbw51T5?=
 =?us-ascii?Q?KolJ1aa0kvQ00KlUp+XVBlDlAZXFEoZ1lLyVk3pM9fEa2n8lwHqtlmuC5TRq?=
 =?us-ascii?Q?w9CrpMbUxoGKeRfzbQ5D41nQNVCEeBmnztipQSAXyhxL5Oc3YDG9U4B9EYIC?=
 =?us-ascii?Q?BN66eglmAmmbRrRrLlbXP4ywuRyknZGYJpOF8q80Oat3AGXmvVvkD8brdKgd?=
 =?us-ascii?Q?m7CeNqqjDUhW+hUuv6K4TuxlGCx1eVstX+PiL6wV/Xd0wX9HoedBn/8Z5KDW?=
 =?us-ascii?Q?L8C+Daphydm/lEB28NAEAteHiWneu7Q4L4ZHhtfv/+n6d10YeyrwDJhhFE7R?=
 =?us-ascii?Q?+QaS07pE6TdibHI3lOdkyU6LkePajgZbKHt5bzNkKOwW5djJn/vPhhsapMml?=
 =?us-ascii?Q?LsrGNX28XqLuW2ciboLa8x0ZSgDfu/HsjQOFh3I7smB+VDvvD0LT/3gRR+gM?=
 =?us-ascii?Q?VBNSkdPr2h2xQ6MhIC/5dfMbGpmavvtlyqVJb3Ax88SEFJo725xEGqvkii9P?=
 =?us-ascii?Q?W24B70rlW7q9gfY6cPI9KlkPz+HgVzGdwNFW7DgqfUue4oGZNLQq6hEsJP6Q?=
 =?us-ascii?Q?VepdN5z7zpQ/C3E36JWF49fmiIjGhHcAvKAoGxwFI8Rjd4yZt/30QK4qYFTI?=
 =?us-ascii?Q?gkNPJyXlLejkv9+aAf8gK9zerFVXkAav6o317p64rD8SoPIYh64yj+Xo6xoP?=
 =?us-ascii?Q?MzcNuglk80WW7wFT8x44L0IcamdrklJfAj5R+6xe6ox40oXemB0+0LtnXXxr?=
 =?us-ascii?Q?aDx1405T3ExYE3E9FikZPGxUb/1VUgwSnYhHoivYl1js3bVT7FwmVmqQxyEP?=
 =?us-ascii?Q?rUyJal0spJmRk2s3eeRhvbgfX3dYoxX4/hbhxcVTKz0GUkINqcA475DFiDHb?=
 =?us-ascii?Q?gheWKBpBdH91PoDddx+bY1k+YrKyhhYXV3cODy0tTDBzYdLcOdG7AU0hKa3w?=
 =?us-ascii?Q?u+RpeH3E+nCrT47+9ZeqVJQ/POUg1LIjMlSRcjY6r49WvHwBogy5+3P+nUW7?=
 =?us-ascii?Q?Uiccq2smnL21i5tnO/81ieZvhLr6wNGRcZVH6Zpb8at4qKcDyEZH+Tdcg7IW?=
 =?us-ascii?Q?guCD3dVvFu19sOWNPF4gfnhC0JC40zit+91jHT3KkQC2vWH3xudnsJ/HaG6w?=
 =?us-ascii?Q?g4UJgQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jan 2026 16:47:43.5281 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: aa55cbed-022d-4f06-556a-08de538ca37d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF00000203.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4124
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
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c | 29 ++++++++++++++------------
 1 file changed, 16 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
index 3a4ca104b1612..5ad2516a60240 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -604,7 +604,8 @@ static int gfx_v11_0_ring_test_ring(struct amdgpu_ring *ring)
 static int gfx_v11_0_ring_test_ib(struct amdgpu_ring *ring, long timeout)
 {
 	struct amdgpu_device *adev = ring->adev;
-	struct amdgpu_ib ib;
+	struct amdgpu_job *job;
+	struct amdgpu_ib *ib;
 	struct dma_fence *f = NULL;
 	unsigned index;
 	uint64_t gpu_addr;
@@ -616,8 +617,6 @@ static int gfx_v11_0_ring_test_ib(struct amdgpu_ring *ring, long timeout)
 	    ring->funcs->type == AMDGPU_RING_TYPE_KIQ)
 		return 0;
 
-	memset(&ib, 0, sizeof(ib));
-
 	r = amdgpu_device_wb_get(adev, &index);
 	if (r)
 		return r;
@@ -626,22 +625,27 @@ static int gfx_v11_0_ring_test_ib(struct amdgpu_ring *ring, long timeout)
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
@@ -656,7 +660,6 @@ static int gfx_v11_0_ring_test_ib(struct amdgpu_ring *ring, long timeout)
 	else
 		r = -EINVAL;
 err2:
-	amdgpu_ib_free(&ib, NULL);
 	dma_fence_put(f);
 err1:
 	amdgpu_device_wb_free(adev, index);
-- 
2.52.0

