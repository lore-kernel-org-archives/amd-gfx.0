Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F9E1D1D46E
	for <amd-gfx@archiver.kernel.org>; Thu,  8 Jan 2026 14:49:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B153110E76A;
	Thu,  8 Jan 2026 14:49:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="bGyAFSj1";
	dkim-atps=neutral
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012022.outbound.protection.outlook.com [52.101.53.22])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3AE7E10E767
 for <amd-gfx@lists.freedesktop.org>; Thu,  8 Jan 2026 14:49:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QDjM0iJ5Lm5RaAmdiW5J/p479PSKC92KD3N2hwh3MhXcFyyNgoAeoSXYuLmHqxfTZmlntVoTzZ2wFVC/TWipH0k3urmcie+6ytaWkWDfrLfjsB4BIPoXjxpUJ0Mhu8RwIYYk8D9lX4AaXeVAunZuhWZZDIqZWpmafY0Lc8RtxFzk9ZFcVy2m32JQeYReXqAe+XCB9PsNdecK8cmNbNNeQMh2Vl9huavzhXeJjw4p0l+CqngH5uRynNiaq9MQHSfHbth7e2PRvFNxQirWx0zwWHI33+XNb7wivy/buHZQUZlv6lMEwQjxOxxAsEr0OReSzYMVcge+jpyOtf3IlW3T3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GiDtZYjOGSj5/xkxK7r3T40Tq927c98955ls+J80WWA=;
 b=sYlGnUGhHRsUq49Tnkvcc6dn386oMQAyapVe2F/eiw+9gjxAMvbftBa99AH5U/EssPhWkHH56mZ0HntoH2S/hyE8ZuPW5MKnKD8i/SWfbdm1a9FbrDLYgpYAaSVQMcSxV6aG/abFmZvjKc38YhWW+NjnLKwgvlh9UJQtLcabacBYGbPNYOtMLcXfB5RsM5cwhYP4YSGoR3y1LwgysdazyMWfAjr21S8o9vo5/NSXwKOXcoFc5mfwh+zcP8nYzL9s7I9xGuZFn21RLAvvAQl9xlFzBTGR2g2wWK2KvWcElfhsUq5NHxgS7pddAHbCYI1l9Zmm8zbG7bdgxa9dMP/YgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GiDtZYjOGSj5/xkxK7r3T40Tq927c98955ls+J80WWA=;
 b=bGyAFSj1KyplgVYsEXKiXWZfmXbbjQwqb1xs0afCFb6kVL3ZyLNSx0Yb5FvX1cktHljIRqxCTxKdVrvjDtHJUfWn4iwZpMZlWPcIM75X+BJK7mr59owI5mIEOyJRH0wX+6H53FV7dDjKvnZFNA/W2ncGg0x8nsYbmmpoqK+N5xs=
Received: from BL0PR02CA0118.namprd02.prod.outlook.com (2603:10b6:208:35::23)
 by DS2PR12MB9776.namprd12.prod.outlook.com (2603:10b6:8:2bd::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.3; Thu, 8 Jan
 2026 14:49:03 +0000
Received: from MN1PEPF0000ECDA.namprd02.prod.outlook.com
 (2603:10b6:208:35:cafe::a3) by BL0PR02CA0118.outlook.office365.com
 (2603:10b6:208:35::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9499.3 via Frontend Transport; Thu, 8
 Jan 2026 14:49:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MN1PEPF0000ECDA.mail.protection.outlook.com (10.167.242.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9520.1 via Frontend Transport; Thu, 8 Jan 2026 14:49:03 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 8 Jan
 2026 08:48:57 -0600
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Thu, 8 Jan 2026 08:48:57 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 16/42] drm/amdgpu/cik_sdma: switch to using job for IBs
Date: Thu, 8 Jan 2026 09:48:17 -0500
Message-ID: <20260108144843.493816-17-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260108144843.493816-1-alexander.deucher@amd.com>
References: <20260108144843.493816-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECDA:EE_|DS2PR12MB9776:EE_
X-MS-Office365-Filtering-Correlation-Id: 87fcc039-9fb3-49d3-c186-08de4ec51145
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?QGORws1wIeEF7sgOHcMrtlsyaTiRvaWHmnzObuiga0mgHCfIfONVgo3uwnHU?=
 =?us-ascii?Q?uFWIQI40U/6nOn6SSSke41TQukf3rS+qa0z5G/pKqXis+JBggVHrGoW7/pFI?=
 =?us-ascii?Q?BJmOHY+rqg7Jtw4dSg7CIg3anrhjC2WIDFFlfL5KHZ7T9VV1mLnitgHy3QfO?=
 =?us-ascii?Q?Wt65Lm8dxZJDlnDh25QtU1OK6/LQM2Pv4b7U55zB2r3rvOiYPnBXRyxaBfCU?=
 =?us-ascii?Q?xzI/4UnTjBquYl+adLJntoj7eYoyctmugM9i8DNZvFUXn+eGM3hLOBs0Z0bh?=
 =?us-ascii?Q?wl1vHO9bfAgrQpx8Q4BcYs2WjgrauydKBaFg8uoiFeeQUHB6L1hovOOs7NpM?=
 =?us-ascii?Q?YjlMnZ4Ko8JIUn9a1o2/Z0mcn8olyK/hH/TUwx/BZn1qgsI3z0EI3kdHV90N?=
 =?us-ascii?Q?56mD0Jm9/d7HIJU5AX41LGY1iZU1ZkP9l2fssykFU2ApepL5wCKhBSbA5JFo?=
 =?us-ascii?Q?+w+aMFpNdD/OED9fjQlbY80+ainCKXJdY32fECRd+vk5yVVvsVrD7mvx3ftG?=
 =?us-ascii?Q?W2Yx0xX+gNcVNPs5EI9L6j44HB4cdypZAbybkuRtm9AmXa+vTXNeJK88NFLT?=
 =?us-ascii?Q?o/y7t4vUmskfxxEyYXLnK7UExMSUnG/AklN8WOKD5a+uln16kLcjXvCyZdjx?=
 =?us-ascii?Q?w+EsOcr3MHI/WH9OZjZ/3OMOYLt9Xq2cnotn3nWgjjzZ3uVyTAXNAV8EPfff?=
 =?us-ascii?Q?ng7Y/eKDMs13+WYKyxefK0cGjiPglp43DXAUgGUq9qI0v6s5Jpo1WX4dcsOE?=
 =?us-ascii?Q?ONR25Y8zcrMmQt+N2Xtci0iiH418EWnx6ZvvoipvC3c4oRWlDahjh9fhcmHi?=
 =?us-ascii?Q?u4agqaYMrj6nOLatorFhYSIETm4IkQ1vU5bhzgGcyXjbzNXY47cl/CS5EPN2?=
 =?us-ascii?Q?dfTuAX9nlISAhrc3XhlGi7K4B5a+sk67dQP4QF1G3yV3oY+dPuCXR5UieXNr?=
 =?us-ascii?Q?2Bg784ydk9luAIDkUUrxpgwxAVgDqCPwsFSg2ZB3GKhhf0sFgq3cOq5dij9h?=
 =?us-ascii?Q?wUNPNEyUh8oo8xvxxLRxn7wVwDoS20VYfVDxPm5MjkKI1rYLAobxvUgEtT/7?=
 =?us-ascii?Q?37+D8Xth2bi5KVhPLYNopCk//QbOapv30pBAA1rhIXPI2hi1E4i19OrR4sMh?=
 =?us-ascii?Q?AGqubif6bH0nqX8QkZxT/dRkoWZgr8qNvKyBcsgJtTGBc//f2vutbDUBVTBB?=
 =?us-ascii?Q?kcf6T6qWelgomOY1DC8ob8SuA+XzJnhROCftN53qanJyIWl1n6XFS9Xb2zN4?=
 =?us-ascii?Q?3GMjY7atoHY5eHCFJUVGNjOAQCZnL0BpOxQan8//dkQvx9Kt3zPQh44y1Cbo?=
 =?us-ascii?Q?blm3E5xw3t77ri6J2eiql62PVCpl1z+xQWQPwlUFBfB8/dgRWPJGSloxgEW0?=
 =?us-ascii?Q?AqJlhcJocDfatoYoftXgL4C1jciMxO+QkvOs6J7sQxZVxaZEH8tXmiAQ0fYl?=
 =?us-ascii?Q?QrIHhOmDAzNbcoP7zfRj7gV2ZxqXaJIKpPfgr3cQr0TmBo2OWlM+C1R56cY6?=
 =?us-ascii?Q?YVSv8J2isFpMHBbIULrPR6SnETcKJOtNEBPYo+arYYEnuI5AMcnSW7E9V82s?=
 =?us-ascii?Q?/ghQfkCdESTur5IcmMQ=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2026 14:49:03.8062 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 87fcc039-9fb3-49d3-c186-08de4ec51145
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000ECDA.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR12MB9776
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
 drivers/gpu/drm/amd/amdgpu/cik_sdma.c | 31 ++++++++++++++++-----------
 1 file changed, 18 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/cik_sdma.c b/drivers/gpu/drm/amd/amdgpu/cik_sdma.c
index 9e8715b4739da..e2ca96f5a7cfb 100644
--- a/drivers/gpu/drm/amd/amdgpu/cik_sdma.c
+++ b/drivers/gpu/drm/amd/amdgpu/cik_sdma.c
@@ -652,7 +652,8 @@ static int cik_sdma_ring_test_ring(struct amdgpu_ring *ring)
 static int cik_sdma_ring_test_ib(struct amdgpu_ring *ring, long timeout)
 {
 	struct amdgpu_device *adev = ring->adev;
-	struct amdgpu_ib ib;
+	struct amdgpu_job *job;
+	struct amdgpu_ib *ib;
 	struct dma_fence *f = NULL;
 	unsigned index;
 	u32 tmp = 0;
@@ -666,22 +667,27 @@ static int cik_sdma_ring_test_ib(struct amdgpu_ring *ring, long timeout)
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
+	ib = &job->ibs[0];
 
-	ib.ptr[0] = SDMA_PACKET(SDMA_OPCODE_WRITE,
+	ib->ptr[0] = SDMA_PACKET(SDMA_OPCODE_WRITE,
 				SDMA_WRITE_SUB_OPCODE_LINEAR, 0);
-	ib.ptr[1] = lower_32_bits(gpu_addr);
-	ib.ptr[2] = upper_32_bits(gpu_addr);
-	ib.ptr[3] = 1;
-	ib.ptr[4] = 0xDEADBEEF;
-	ib.length_dw = 5;
-	r = amdgpu_ib_schedule(ring, 1, &ib, NULL, &f);
-	if (r)
+	ib->ptr[1] = lower_32_bits(gpu_addr);
+	ib->ptr[2] = upper_32_bits(gpu_addr);
+	ib->ptr[3] = 1;
+	ib->ptr[4] = 0xDEADBEEF;
+	ib->length_dw = 5;
+
+	r = amdgpu_job_submit_direct(job, ring, &f);
+	if (r) {
+		amdgpu_job_free(job);
 		goto err1;
+	}
 
 	r = dma_fence_wait_timeout(f, false, timeout);
 	if (r == 0) {
@@ -697,7 +703,6 @@ static int cik_sdma_ring_test_ib(struct amdgpu_ring *ring, long timeout)
 		r = -EINVAL;
 
 err1:
-	amdgpu_ib_free(&ib, NULL);
 	dma_fence_put(f);
 err0:
 	amdgpu_device_wb_free(adev, index);
-- 
2.52.0

