Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4649D1D465
	for <amd-gfx@archiver.kernel.org>; Thu,  8 Jan 2026 14:49:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 267D910E769;
	Thu,  8 Jan 2026 14:49:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="up9nhdH4";
	dkim-atps=neutral
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010032.outbound.protection.outlook.com
 [52.101.193.32])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E6A8910E767
 for <amd-gfx@lists.freedesktop.org>; Thu,  8 Jan 2026 14:49:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=u7paH8x97CgGZtGrhCYlzPaOyamDqdW+JTuhLU/FPGH9ZY26+ZYhHGRMdLdNH6asrzkuFc1CxRSr0uf95DTKexvFTyGm4M/9LQoBT01XXB8pZ0PaacYK3JY+YVxCqt74p1xP+m25DJq3GuyiMsCSqgbs32C/T1ix/zGBeJKP/tlYCy8ttN3q/xWlRaqNOta3E01SeRBly4hqty/c0j/6qOeqJaupdlC1+LNzrBqYwAkTQBk78rLc1SKeRvX7kej33F6UL3Kq+Y1k8aN+dS+Vm8NgWgc+mJdt/TnhcHWiOhgIG3JqkcSE+FR5HgxK5mrB2AJ/K32U58744s9nKRvSpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sAva8hlK48+sNECavskq6c/8oW62R8woRIm1Y9jVqKk=;
 b=BCxOCplGzSGZyxgGr/N+0rAgEDqke/dYrF703BPvPCZamc9DGIEvFOqFojf8A1ygL7dEWc2OVa20NCNg8sD7qZ1GDDqQb/4uoWmWQu8o8vsYFXmcESg7vEHtSntwYm2yKGhTkACLUXFBn9J9U43SOCTqqfXZ+37nV90o09MtbpyRzLzPdrc5oNLs+fO2j+Lb7RGzX1ZNp4vnOUReaCWZgzZ4bwAMC5oQdmslonU5KwI6W+ObFgJtmPUzAnGf9NLW6ErPooCixGOEhMtwgVdRks25XC4cXfOXEcWk/kBDeOgtPBbpvVvyEIgI0egFwnMX5ONK6YDCTNZh/J3oLVoV1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sAva8hlK48+sNECavskq6c/8oW62R8woRIm1Y9jVqKk=;
 b=up9nhdH4d1yky7kmX6Zx2fmaANLHBs6MEvtTOwdz6JjRVTORCpokMNIjdsGVXSh/s9ho+PO5+/fk/8dZdfw4nIsGjXwbaG0mz7lFvBYGc+Dl6lBQSGgQSMJ9XfzD3b/9aadIYtqy75/AY+wDQ8DTA+OQuvVSL58VXEu6Wl6+cwQ=
Received: from BL0PR02CA0137.namprd02.prod.outlook.com (2603:10b6:208:35::42)
 by SJ5PPFDDE56F72B.namprd12.prod.outlook.com
 (2603:10b6:a0f:fc02::9a5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.4; Thu, 8 Jan
 2026 14:48:59 +0000
Received: from MN1PEPF0000ECDA.namprd02.prod.outlook.com
 (2603:10b6:208:35:cafe::5b) by BL0PR02CA0137.outlook.office365.com
 (2603:10b6:208:35::42) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9499.3 via Frontend Transport; Thu, 8
 Jan 2026 14:48:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MN1PEPF0000ECDA.mail.protection.outlook.com (10.167.242.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9520.1 via Frontend Transport; Thu, 8 Jan 2026 14:48:58 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 8 Jan
 2026 08:48:56 -0600
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
Subject: [PATCH 12/42] drm/amdgpu/gfx11: switch to using job for IBs
Date: Thu, 8 Jan 2026 09:48:13 -0500
Message-ID: <20260108144843.493816-13-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260108144843.493816-1-alexander.deucher@amd.com>
References: <20260108144843.493816-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECDA:EE_|SJ5PPFDDE56F72B:EE_
X-MS-Office365-Filtering-Correlation-Id: 54e6ffc5-3fa5-4ed2-20fd-08de4ec50e4b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?WOtJI/7cOnOKXzRHTP8yG5NQkA+rFIpjAu1cBln2SiLWigi+P3GcdvfwFneF?=
 =?us-ascii?Q?tTUCDVu1hL0ertffVOxtv5L31GoCdbc2Sv+17Xz7XAM9t5pK+ocuSP/lGZqf?=
 =?us-ascii?Q?jut5HPxd1gQpVFmrK0z5cd8m1syQXrFimd0Xe5BmgOe0dOHn8eCfGKFbhGsd?=
 =?us-ascii?Q?dtaTV1AZpGfeVLDHmAYrlFTX/vmC096lEAGmjRGOSTQedqH4tLdnVu7ZIijA?=
 =?us-ascii?Q?n0w+c1tVwOuOGg1xkRgTQgCjhj4UOBtf2Mf35K2o25W9Sa3y1PF4c/HCqD1k?=
 =?us-ascii?Q?DOdPT2oJlpc3UtcRJfS37bvLYcSCZSGZXcJL/fqPnZF5E691Bs3TE2a1KgWb?=
 =?us-ascii?Q?8gBSB9xnwaH9OE6hPrDEmPDCQzIeME+zpLrU83MxuD29Qlb4hIKWfMDBljdo?=
 =?us-ascii?Q?8WUlvAwC0L0F5/y5Qln7AoEXQkMPEqFxsUPmMXJ4RyUhbEEpKAMiMdZVdWTq?=
 =?us-ascii?Q?nMdczT+NozsGqeceJVE2niOL7mY1m7w7ADst8qP6k6GjzIyfS8nfKQ7AK17R?=
 =?us-ascii?Q?o0kqfC9xlXRWhqix3aPd/1sUSso4TuY3lVXN3aBYUwXBdZNzcUeNI7xjQbPD?=
 =?us-ascii?Q?HUQK+z9mO9iWwCt5gWCjPNtSVhj9fm61fZZuMZ9LbAnGbkcdC+w8g6s+ugYh?=
 =?us-ascii?Q?7hzzggEcpz9vKikJZuJ8hlNzGN3jmLCg9N1jtXQc5xqnDwu1NuyIev41Z96V?=
 =?us-ascii?Q?1jM44r5CxvYJtS2O95N1tL0dnZH6jOocU/iEBsLxNhjeG8g+OmN0B+d4eVaY?=
 =?us-ascii?Q?fWXO75e+qvP9f2W3fv8HdLuJ8LWgjjbzIe4CDzxiuvYqIDuzmyCnmqcDIRvC?=
 =?us-ascii?Q?DuQy1zGu11XraRLOYz8Bq9Sxk2rgl9VR6wPU6WB4hCGsgffseEP3HfSdcBEA?=
 =?us-ascii?Q?C9avP2x9Euo4pUokdjpuskL4mhrvx8nSqIDzK6vTvYBsKvp15SfmpDVIdmP8?=
 =?us-ascii?Q?EYsp+5CmiggUg3Jl2H9P4dhnZWO7WIZ+bnm6wyL7meX29r3vMtnDUw5pKOgg?=
 =?us-ascii?Q?mF/ArVfWyajXLUiTFPoWsQU8RWS7i37J771o4Li48LPAyBc8dSLfqVrtoAfg?=
 =?us-ascii?Q?GZWcMqDluOZd5mySLr8JR3o9WmKhLVZNTmANYC1jFO58Ye8Tixq8l27i2rIx?=
 =?us-ascii?Q?gbQQlVIjPDvN9mg/ctwusDE9sng9VkaOSsIMKElrNPSmGmT1f1HwM3BXQejK?=
 =?us-ascii?Q?nVqyc7u4tS4/kWmxIFuJBc5iRB9wBHoVKbtT0C7MI6MEpNk9YKAIgxhycSEE?=
 =?us-ascii?Q?bOGahejlLI5FjLdFa320l6MsvOfU2Zx5p94fO7zD4bs9gwSUp6CPNhbN+Ajk?=
 =?us-ascii?Q?VeWwoEylmZZsm68++d+EVN4azkgU3guC0HK3EfJsiuOBVYWwDwaGky3kJSt0?=
 =?us-ascii?Q?oRXcP4zESXOOvLfhPyZHlotyPKDAxSPrBXUSK77OpUJKzg+kvTm3QbcPY45r?=
 =?us-ascii?Q?kkbw0Kfll9C0QhRdKujdrC/qfULLj/2/leKipURG+v/HQzVqU6xgwL+HSs6d?=
 =?us-ascii?Q?c0Z1a371plaw1mOnHAIxb7vXZq7KvX8/IStSN8D34XVdejOJ8VCbrVv3mmdM?=
 =?us-ascii?Q?oI91wqSm1SXF+3znLlo=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2026 14:48:58.8067 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 54e6ffc5-3fa5-4ed2-20fd-08de4ec50e4b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000ECDA.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPFDDE56F72B
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

