Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1E20D1D465
	for <amd-gfx@archiver.kernel.org>; Thu,  8 Jan 2026 14:49:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4133310E771;
	Thu,  8 Jan 2026 14:49:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="H7tTacA2";
	dkim-atps=neutral
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010011.outbound.protection.outlook.com [52.101.85.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CA59E10E76D
 for <amd-gfx@lists.freedesktop.org>; Thu,  8 Jan 2026 14:49:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aOOiL6VIGqHfS3NDTkDrYJSxpbc/pessKzAAgKLQkXqc8izHBVMScc/AJRU2SYUDF0+0zWjQyHikn1AS2ITtDkoyjeqd/WnNqprJ0fHaVOv/7hbkG/tB8brqapa/7EygF+FbMOKCT8D3HlPhkswrooiUrwIckaQNojheq0lvLHsYBQQGKkot4A0etJ0LVIqdZnDLBizu5qEBTcn7tYMUTKu9SKZlXjkrp2hg9x+Wom0/FMTJxYV3TmkLESdXh9MgzFMBqHUl0clWOV/527XEIsQvt6St2KNED4DhGOG1/Im9mM+tnTgkTl8sZPW5ZW73Kf0rXupsr6TWuEWe8DYsyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AH7Nv5WshC+pPRLCYDNAfELJjhz9RQ0WarKmvDNJzMA=;
 b=LgORCgaBpw1UOaCMDHsZ8pIqHXofcQfQ8BxjdQd67MjTccWjD6Zu2T9ascaXaxkIPpdz63ZTjpzDwGShlkhIzdh11j4srifIxV5SLuJDdlCTqUeSiGXdySbi0eyLofYA3zLJ1YLmavYgwxie/sJbSZErwFBuq79wOb5oOuuHKb8MYK6SD7AWT0LppufHRcntmFo3ICcWX0GFIofcqwIFMraSiJibqsVNtlAp1d6LbwUXYiRrDztcPfqnAk2gH00VnXvVxFXtllaB6UU0s00PD9gmsREaWz73bQm1Up4otYlIk3p0WOJS4FlC8f42BJvSxd0M/HmB6NARpHJtWit3hw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AH7Nv5WshC+pPRLCYDNAfELJjhz9RQ0WarKmvDNJzMA=;
 b=H7tTacA2fPdISMWMxl6FdQDffb0p6MjRMc/gzYd/DLRyQRw0MPkEWUtFkzSJ5OAHaRpli7FP4eaF5EJzlP4dj+UruYN8I5Ti65iB/HLgXuOdb0kL2HiNmN3qCKAdN9IlL/ePEmjZPlqV0+fW42zx3Z0snCnAlMbC6FbIBI4ltKQ=
Received: from SJ0PR03CA0355.namprd03.prod.outlook.com (2603:10b6:a03:39c::30)
 by MN6PR12MB8544.namprd12.prod.outlook.com (2603:10b6:208:47f::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.2; Thu, 8 Jan
 2026 14:49:08 +0000
Received: from BY1PEPF0001AE16.namprd04.prod.outlook.com
 (2603:10b6:a03:39c:cafe::be) by SJ0PR03CA0355.outlook.office365.com
 (2603:10b6:a03:39c::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9499.3 via Frontend Transport; Thu, 8
 Jan 2026 14:49:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BY1PEPF0001AE16.mail.protection.outlook.com (10.167.242.104) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9520.1 via Frontend Transport; Thu, 8 Jan 2026 14:49:07 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Thu, 8 Jan
 2026 08:49:01 -0600
Received: from satlexmb08.amd.com (10.181.42.217) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 8 Jan
 2026 08:49:01 -0600
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Thu, 8 Jan 2026 08:49:01 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 25/42] drm/amdgpu/sdma7.1: switch to using job for IBs
Date: Thu, 8 Jan 2026 09:48:26 -0500
Message-ID: <20260108144843.493816-26-alexander.deucher@amd.com>
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
X-MS-TrafficTypeDiagnostic: BY1PEPF0001AE16:EE_|MN6PR12MB8544:EE_
X-MS-Office365-Filtering-Correlation-Id: 7e4f7ce9-b4d7-45b7-fc79-08de4ec513ad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?KHLt4UEV8cGFUuVJJVMiTTKXLgrH3y7bE2SnJKhgYSEKqfP02IcvgmtEERFM?=
 =?us-ascii?Q?5X2x+QvmR7B+VpTTKuDvmV/7yrgO7oV5XbEVQL5ZwO3Obe3BBxJ8akqeeI/H?=
 =?us-ascii?Q?CmE2QNcJKeoh5NRg2r+LV5Coa0rf6XCzsOgQpRio6buxQMDV1N/xk8aQfNQe?=
 =?us-ascii?Q?FV2lRyMtAIgCa3mp2kd3eqqVRD8m14INNcK2+5glbG6D5B3wzgfl5z3TfBDH?=
 =?us-ascii?Q?1LO04AcnvDQkQysP3JTjBbPFqTSZd6dGHLIm/N7Dxl/uciD5R+b5zWOFuZnW?=
 =?us-ascii?Q?sGjZPCizRYqHPnSKZUMR+8C1wqgpBNFLtvhWA5TZrg2WvNuklmCYsbsiMLfl?=
 =?us-ascii?Q?puWGQxAu2h/BLSOL3mGKSleoWn/dzp3L9bqEJerwz3Sd4BOQuFty+7eoeDnT?=
 =?us-ascii?Q?GGayiN4a70VzDRGY1AQAy6xefRvKqh6QGp4i173TubrCeXBWLhbekeaFBQF9?=
 =?us-ascii?Q?KOIYEoMGfy3XPkO1Dhr5283b0u3GbIbbjMOBA012qYUOv/SNjkyN377yQPB0?=
 =?us-ascii?Q?3esAerQFafipJPVL6LDd+4oYCcWQwF5Pt7OfCOhWiujjU9c8MYviJAtFgiCh?=
 =?us-ascii?Q?KE/hNjgH7kh0KCXN7IOwGjNTx2EBfo8VQIOByaGCQlHwEQFr6RPcTl6W6pL5?=
 =?us-ascii?Q?+axwFZ+NfnPwk4X4F/YLb34q5c2Ow5NSKmTzJOBho3SCraBpqb2G3IXIa8lD?=
 =?us-ascii?Q?iYTFkIscqg+FmfYnFFwZfnoxrJT3vZpoiZ7stXtF/aLV7QobAcD7d8Xr2TkQ?=
 =?us-ascii?Q?9ytSFJSdCJ8nPYcB0vLRz5ooafmuFoUeRk5jEh3vAP0LTgLFQV9TLSF64iQ/?=
 =?us-ascii?Q?b6UBkZf37gUWu3nFZoDFhULgAdbkGwVIOEZhJ7qTmRWB8Tn0H1gNNyfKjkU+?=
 =?us-ascii?Q?VQzYOMR5Dyd0tPvgZuCgTKiDdb4ydU7CeF6gip7hYPorluurc0dQx+dkjHT/?=
 =?us-ascii?Q?eN5b7Y5hYiDxUP4MzQOne2YqpK68m3+JbyaH9vOImOZedzfhIQ9O1eVIdZlb?=
 =?us-ascii?Q?rQHU8LQREWcgSSlype+6TtvIjjt/o0IhHvvuh6NrkTawrUxaW/kfdqz2jO5g?=
 =?us-ascii?Q?MXkuJCaEWUNVwKqrdacQtmQR31keEjkEpq+ClhVbJScUjysJ/m+hOf01UsSG?=
 =?us-ascii?Q?lC0WD9mLZd2GoXY3HRm+hL8QkBtlcFClih2X2fawDf+d0CMFZI++DA2LgNs8?=
 =?us-ascii?Q?2sxY7nTV5igt7o7CRPtephCbzwSTKPI6WSuYI4Um93b0ZFR6mdbC4GLNElOm?=
 =?us-ascii?Q?rCAthi9DmXEMmd+yTWvZwloVWGJdLdCaqPRhlntToaSKqFXfDj0MbW7oN69T?=
 =?us-ascii?Q?T8/gxtXoYpQw1mpUDNmkFN2EbNEccirR9vLs9+YuG98NW4QAWou4NUfxocV1?=
 =?us-ascii?Q?J6cObHlwA/jr6ixjeusjUiuXorn6B7W0F8/b6zgjDxUYynRGF9xi3GO4eF+B?=
 =?us-ascii?Q?/w/WlBsW+/VV1wx/ls56shod4C5kyfGAf3HPRlSoDiUjadPHYCnkiF67/Qff?=
 =?us-ascii?Q?Zmh/jj9h+N/nHB5Es8666jNQ4fU0svsw7O9E2NFHOydkDkSp1x047jdo8jL2?=
 =?us-ascii?Q?FeRd2so7Oly+4++5XgA=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2026 14:49:07.7523 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e4f7ce9-b4d7-45b7-fc79-08de4ec513ad
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BY1PEPF0001AE16.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR12MB8544
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
 drivers/gpu/drm/amd/amdgpu/sdma_v7_1.c | 36 ++++++++++++++------------
 1 file changed, 20 insertions(+), 16 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v7_1.c b/drivers/gpu/drm/amd/amdgpu/sdma_v7_1.c
index 5bc45c3e00d18..d71a546bdde61 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v7_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v7_1.c
@@ -987,7 +987,8 @@ static int sdma_v7_1_ring_test_ring(struct amdgpu_ring *ring)
 static int sdma_v7_1_ring_test_ib(struct amdgpu_ring *ring, long timeout)
 {
 	struct amdgpu_device *adev = ring->adev;
-	struct amdgpu_ib ib;
+	struct amdgpu_job *job;
+	struct amdgpu_ib *ib;
 	struct dma_fence *f = NULL;
 	unsigned index;
 	long r;
@@ -995,7 +996,6 @@ static int sdma_v7_1_ring_test_ib(struct amdgpu_ring *ring, long timeout)
 	u64 gpu_addr;
 
 	tmp = 0xCAFEDEAD;
-	memset(&ib, 0, sizeof(ib));
 
 	r = amdgpu_device_wb_get(adev, &index);
 	if (r) {
@@ -1006,26 +1006,31 @@ static int sdma_v7_1_ring_test_ib(struct amdgpu_ring *ring, long timeout)
 	gpu_addr = adev->wb.gpu_addr + (index * 4);
 	adev->wb.wb[index] = cpu_to_le32(tmp);
 
-	r = amdgpu_ib_get(adev, NULL, 256, AMDGPU_IB_POOL_DIRECT, &ib);
+	r = amdgpu_job_alloc_with_ib(ring->adev, NULL, NULL, 256,
+				     AMDGPU_IB_POOL_DIRECT, &job,
+				     AMDGPU_KERNEL_JOB_ID_SDMA_RING_TEST);
 	if (r) {
 		DRM_ERROR("amdgpu: failed to get ib (%ld).\n", r);
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
@@ -1045,7 +1050,6 @@ static int sdma_v7_1_ring_test_ib(struct amdgpu_ring *ring, long timeout)
 		r = -EINVAL;
 
 err1:
-	amdgpu_ib_free(&ib, NULL);
 	dma_fence_put(f);
 err0:
 	amdgpu_device_wb_free(adev, index);
-- 
2.52.0

