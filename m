Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0116DD38FEE
	for <amd-gfx@archiver.kernel.org>; Wed, 14 Jan 2026 16:47:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9514810E622;
	Wed, 14 Jan 2026 16:47:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Y5r5FeRS";
	dkim-atps=neutral
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010028.outbound.protection.outlook.com [52.101.85.28])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0AC2F10E62A
 for <amd-gfx@lists.freedesktop.org>; Wed, 14 Jan 2026 16:47:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iq58j5QGgRESp+DIRSqxU4I6/kWHR9xBQyw4NGg6lKIi5UkrJSEt9SXVJ1DPDyRxDz1nGMF1uz9CTmpHGWHYPjQcIKjawVKxHJ8pPOUQiWCh6NmoAZof//uDO/MH57Are3zD9Zrjo1c6ZH9Mqjr9lz+JZ3nm/+/4na94DS+KkP7sS9ucG6XNmOFdCF9LslbrhW+KYSRq7AXNpDqxk6D+VxyRTpyu8O6j92/VDS46wS4J+9dMQoTBq8IqN0UytooTJySWnG8nDGihDcxbljd6CdDr/JHHjwZxV5FiZpOTwkGpJWfJ8cb9HAtrEr3hpVhqOiS6Xps6qJ+h3zwFF0EgNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tEChAF3U4+gQtdUgKiEeNq4UFjGY6OllnW0z0S6cl1U=;
 b=vPv7OzvuWKY1nA7ld7FBjTGPPmh0bm1egkMQpU0RRlj+Hke+rPMEFCX46TC3CeSmWQUHtLIviXtxUCoBIkU7zsoeS3/akciUOEXKzAdz75mRI0FxmbKLjdpuFjwkH8JuB2xaSl2KvuZb0CQ/rc2TNd+L3YWfYLwPdc2XVNVcncmRXcNnw4uSiQ+2IXyKySCEpaPwNgd93ACxDldMul7vgdKJT4uyAT8/l8rzsQyXWluj0alY7GPwXy57VFudMF+D+3phIdBSHi9kzLqSduKsyyfEjHbp9odAW0UbTARii/EtGB61oMCOUeOkWkwlrKnAKTOyedeZGoVV4JSJxC468g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tEChAF3U4+gQtdUgKiEeNq4UFjGY6OllnW0z0S6cl1U=;
 b=Y5r5FeRSpW0zBeAN9v4M5iTK4FRJX+DGcNqv6aTPq55Cr2DiewR8mQvqwxsbLZuK2ztpcn7FIlsVMBeQONIJYuGdKSbYCdFJZZzdcx6l6XB7a8QzlDs01SahnqQee1Lr0liSWiUiJWw274LbQX6orsOnqz/cpWqsMgfcTqtKZLw=
Received: from PH8P221CA0011.NAMP221.PROD.OUTLOOK.COM (2603:10b6:510:2d8::26)
 by CY1PR12MB9560.namprd12.prod.outlook.com (2603:10b6:930:fd::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.5; Wed, 14 Jan
 2026 16:47:40 +0000
Received: from CY4PEPF0000E9D6.namprd05.prod.outlook.com
 (2603:10b6:510:2d8:cafe::12) by PH8P221CA0011.outlook.office365.com
 (2603:10b6:510:2d8::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9520.5 via Frontend Transport; Wed,
 14 Jan 2026 16:47:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000E9D6.mail.protection.outlook.com (10.167.241.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9520.1 via Frontend Transport; Wed, 14 Jan 2026 16:47:40 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Wed, 14 Jan
 2026 10:47:37 -0600
Received: from satlexmb08.amd.com (10.181.42.217) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 14 Jan
 2026 10:47:37 -0600
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Wed, 14 Jan 2026 10:47:36 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 02/42] drm/amdgpu/vpe: switch to using job for IBs
Date: Wed, 14 Jan 2026 11:46:47 -0500
Message-ID: <20260114164727.15367-3-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260114164727.15367-1-alexander.deucher@amd.com>
References: <20260114164727.15367-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: alexander.deucher@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D6:EE_|CY1PR12MB9560:EE_
X-MS-Office365-Filtering-Correlation-Id: ecf04b9f-be25-4d12-32da-08de538ca1a8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?iBxccYrbiOWbeSVxB01QkKr3lW9MJ+AVLUvoV0Pj3740GF2CsPB2Lo2JRKOT?=
 =?us-ascii?Q?vJ7210Qe4chQu1Xz5sR36rBc/q4ynKNX19Q7fLmHUrWq5nW9YC+N3rNa9QGw?=
 =?us-ascii?Q?XlRIfcLdpHkb2hJTPYYbD3C1ywEn7oQJLFOsDJ0NDpP74HNluwYfZWzbDG10?=
 =?us-ascii?Q?pg43qK0nffK6jhT2yZE8pKhQULObPnPPLKYY9Xoci7ZLT82QWIFksZg9L5nf?=
 =?us-ascii?Q?k2iu2ei5WdQ0iXzZmBwwB5sHchD2mkjqaBIbLzHDAJsbiSs1nO9RhZ+8TNow?=
 =?us-ascii?Q?D2Tp06dzqh2d4UMk7Cen7IKcqdpTlTVdOV60NYE5harkj7D5+eRnzYBi9IEw?=
 =?us-ascii?Q?rp1BirKyfJsD8QQB+tyUG7FD2eewJUMJIh5oiYAOA1vuUjBPHIwu7gNZaphf?=
 =?us-ascii?Q?4dGS0nzVkKBpRxEN/qq6E/bwsgh+iyQjVE9YomjeMb5CE/WbBZ4aVUV99k/0?=
 =?us-ascii?Q?zu6ULwLHg/2u6jdfGdjQ6b7tWSegtApmYRoDGLegXMuPBu6a8MA8vtZZPENH?=
 =?us-ascii?Q?8aRba6nIKC5dAA49lxhzJzdLlz8fYN+4WkdC5vlgeFGO/YcY/Hbd5dS58yu0?=
 =?us-ascii?Q?oQcDvGDcGmZ0AGNrrfqx0ExqjwVnUijAGzEuxtOtdpcKQzZQOgIM9NPsZGy3?=
 =?us-ascii?Q?HLXFRc5WRI/1Bb14xI+EVU2f5c1BFPr5hj626NOfWyXBtzHFbF12PcCh3WjJ?=
 =?us-ascii?Q?F8+dC8/rN8pnAUATAfzEgcXrZOBwoRcbwcy6PKAIiUXO/WYMAoqHh7KTC82O?=
 =?us-ascii?Q?Hc4x+wk/3sF/EsGFCbU/5hm8HkDf+l4Kp93uvF06O4W3P7YQKA3lcaXiHj0h?=
 =?us-ascii?Q?hKfrrxOlHgfoWNK0nqSWL0kxlNil1lDsI3cNLXjWLKxglK8CRBKK0dxPBCuC?=
 =?us-ascii?Q?rN1xJ8RPpMTDrZ0D1g67Yef4onxWB7bkWwaplhIWFYqhJc40hAYwIljTRYsQ?=
 =?us-ascii?Q?u+yiFXPhlXR8mInUaR2WIkxeqomu8fzYIlJdEamTHXfpspdbMAYkGo2TBp93?=
 =?us-ascii?Q?nVgbEBg4PbrHRw6PRsoRsyLopThA3CcsB4hhlZUff0pTLJYSceRmpm7Ka612?=
 =?us-ascii?Q?EYu1wWvezRE9je2bAiQG47DjkuDTlIFyA5phz7QgH8ipz/4xypQzTTn/1O2W?=
 =?us-ascii?Q?J8A5Gb7th3aH+j3F/O0DCx97S0V0nEl+cFMXyeGNY9Yd+PTQDDA5cDdN8HMU?=
 =?us-ascii?Q?LWLOF0zyiXKnTcTHLvt1v9lojMzSRGhntd2NwJCviYNCeWcP7Rj7tyZoXuYT?=
 =?us-ascii?Q?2S1za5j4kTZVFfVnu5sCIBAE6NP2KidOsukRn3HWdAYMINlVxQFGytf6vWaQ?=
 =?us-ascii?Q?+sKQJjmDyLRTDCJYnwtscl/5Ajhzq3aPNnKXONjYfObUZ6c9/v3M6pX2CWZn?=
 =?us-ascii?Q?4j6p8qMDTHdXCvA7FMlmyjVzAWqcW0EBnlywu4Yj7tdL2NuZtHUiMiHkkshy?=
 =?us-ascii?Q?RNrWnUcgTtw2o5Hs82IKEGFfIkwHA7aaFXF/vYslpuAXRe1d38z6e3K8AaKm?=
 =?us-ascii?Q?DCypC56c5EFYivKsIheVwaZShDyn3Zn4Q63lCtFFGlIYMxM5KXf2SosLMOXJ?=
 =?us-ascii?Q?TyUDDWjkX92hbtE9/JBJduqj+dz8zpUCCE8tQbn0uX+thnsAKvmSPSbO9Z4i?=
 =?us-ascii?Q?qWu4x9XqzndulI8nbCaEgRAPrC8tHCNZJwouArQ03ayNbx4pvhqq8Gh0R7+o?=
 =?us-ascii?Q?Tw2u9w=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jan 2026 16:47:40.5001 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ecf04b9f-be25-4d12-32da-08de538ca1a8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9D6.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR12MB9560
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
 drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c | 37 ++++++++++++++-----------
 1 file changed, 21 insertions(+), 16 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c
index fd881388d6125..9fb1946be1ba2 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c
@@ -817,7 +817,8 @@ static int vpe_ring_test_ib(struct amdgpu_ring *ring, long timeout)
 {
 	struct amdgpu_device *adev = ring->adev;
 	const uint32_t test_pattern = 0xdeadbeef;
-	struct amdgpu_ib ib = {};
+	struct amdgpu_job *job;
+	struct amdgpu_ib *ib;
 	struct dma_fence *f = NULL;
 	uint32_t index;
 	uint64_t wb_addr;
@@ -832,23 +833,28 @@ static int vpe_ring_test_ib(struct amdgpu_ring *ring, long timeout)
 	adev->wb.wb[index] = 0;
 	wb_addr = adev->wb.gpu_addr + (index * 4);
 
-	ret = amdgpu_ib_get(adev, NULL, 256, AMDGPU_IB_POOL_DIRECT, &ib);
+	ret = amdgpu_job_alloc_with_ib(ring->adev, NULL, NULL, 256,
+				       AMDGPU_IB_POOL_DIRECT, &job,
+				       AMDGPU_KERNEL_JOB_ID_VPE_RING_TEST);
 	if (ret)
 		goto err0;
-
-	ib.ptr[0] = VPE_CMD_HEADER(VPE_CMD_OPCODE_FENCE, 0);
-	ib.ptr[1] = lower_32_bits(wb_addr);
-	ib.ptr[2] = upper_32_bits(wb_addr);
-	ib.ptr[3] = test_pattern;
-	ib.ptr[4] = VPE_CMD_HEADER(VPE_CMD_OPCODE_NOP, 0);
-	ib.ptr[5] = VPE_CMD_HEADER(VPE_CMD_OPCODE_NOP, 0);
-	ib.ptr[6] = VPE_CMD_HEADER(VPE_CMD_OPCODE_NOP, 0);
-	ib.ptr[7] = VPE_CMD_HEADER(VPE_CMD_OPCODE_NOP, 0);
-	ib.length_dw = 8;
-
-	ret = amdgpu_ib_schedule(ring, 1, &ib, NULL, &f);
-	if (ret)
+	ib = &job->ibs[0];
+
+	ib->ptr[0] = VPE_CMD_HEADER(VPE_CMD_OPCODE_FENCE, 0);
+	ib->ptr[1] = lower_32_bits(wb_addr);
+	ib->ptr[2] = upper_32_bits(wb_addr);
+	ib->ptr[3] = test_pattern;
+	ib->ptr[4] = VPE_CMD_HEADER(VPE_CMD_OPCODE_NOP, 0);
+	ib->ptr[5] = VPE_CMD_HEADER(VPE_CMD_OPCODE_NOP, 0);
+	ib->ptr[6] = VPE_CMD_HEADER(VPE_CMD_OPCODE_NOP, 0);
+	ib->ptr[7] = VPE_CMD_HEADER(VPE_CMD_OPCODE_NOP, 0);
+	ib->length_dw = 8;
+
+	ret = amdgpu_job_submit_direct(job, ring, &f);
+	if (ret) {
+		amdgpu_job_free(job);
 		goto err1;
+	}
 
 	ret = dma_fence_wait_timeout(f, false, timeout);
 	if (ret <= 0) {
@@ -859,7 +865,6 @@ static int vpe_ring_test_ib(struct amdgpu_ring *ring, long timeout)
 	ret = (le32_to_cpu(adev->wb.wb[index]) == test_pattern) ? 0 : -EINVAL;
 
 err1:
-	amdgpu_ib_free(&ib, NULL);
 	dma_fence_put(f);
 err0:
 	amdgpu_device_wb_free(adev, index);
-- 
2.52.0

