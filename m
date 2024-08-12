Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D729DC52D7C
	for <amd-gfx@archiver.kernel.org>; Mon, 12 Aug 2024 06:59:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8203310E0ED;
	Mon, 12 Aug 2024 06:59:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="eGZBNb3r";
	dkim-atps=neutral
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2080.outbound.protection.outlook.com [40.107.102.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8791210E0ED
 for <amd-gfx@lists.freedesktop.org>; Mon, 12 Aug 2024 06:59:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RUpUY8zrEmlJC1Tfve2STi8ObJFK9zKRGO8hQCdX++/YA+J2cX2MDy0WbW0QyYZtLIueSAOm2Hi300EXq7Xdx91JC6VFfLwe622CCr6XMwyBcb/cmA4NjEgwodxeqBH43kUsGeksv19LVLvDUkgUaVo4p4U5dgxX9xZCfBf5Jsjh9JdAYi17CieTfPZAW4n6KxciGw6wSpxGO9zflg1FS2yDr//7I0E7W9S9ucC9JxV0Z2qoFQxOp7LSpeFqCCBae+YuLh+lcv7Ay8tQ2PZa6Ut+69knkV2DFETzb8llshbeNprw+4ZG0xzsm8wxB44v4zX1mmwrSjB9G/Xo9aT1RQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1slBNzrljEEnN9kEEIL378ZL3mbXk4bFs3QhP9ewvkE=;
 b=b3UBS9igtKOZTii1oWahURnzxlA509XFh3DsgVFwCKd+1YqsAu0j9QxrWgFt/XK/aRfqDxY5fxcy+GQarSbaPrdoHGzjwtnuciCbo0XDDCZwsQkpQ6gL86BjfyP6onhA+NthzjCtNlHZkazaDDZjYqHuJGPg+JEeslQVynjeiBvMUZVxWtn74VGLk6S2l6pcLH23rXT7VVsAIrievlXRg8onTnVc9HnZb32QlE7K+6uqRRNM91kCmzqp758rcAx2a/UmA9SZeLmx9tDggoUD+oI9wiKL8lhVlSbPlkKHUaWDOTkvfl4RWiDftz6tJirjLAc3yXxi3IrubRDYCd8/lQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1slBNzrljEEnN9kEEIL378ZL3mbXk4bFs3QhP9ewvkE=;
 b=eGZBNb3rRjIRx4uLuJcJxe5Vddu/3RHbuXST9RHfg2+rEwBxLf8s8mQH7ljxdOdiCM+MwGoNREMpPYN5+FGNb0IjdMQP6T2jVXdAv+rN/yBkak6PkSLWCpyOpKjv5rT+ga06ZbeX35VaCsfdVmUG16TZobyFLCHSrEeT1Tf4QKo=
Received: from SJ0PR03CA0104.namprd03.prod.outlook.com (2603:10b6:a03:333::19)
 by SA1PR12MB7412.namprd12.prod.outlook.com (2603:10b6:806:2b2::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.20; Mon, 12 Aug
 2024 06:59:44 +0000
Received: from CO1PEPF000066E9.namprd05.prod.outlook.com
 (2603:10b6:a03:333:cafe::e9) by SJ0PR03CA0104.outlook.office365.com
 (2603:10b6:a03:333::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.33 via Frontend
 Transport; Mon, 12 Aug 2024 06:59:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000066E9.mail.protection.outlook.com (10.167.249.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7849.8 via Frontend Transport; Mon, 12 Aug 2024 06:59:44 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 12 Aug
 2024 01:59:43 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 12 Aug
 2024 01:59:43 -0500
Received: from sam-builder.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Mon, 12 Aug 2024 01:59:42 -0500
From: Samuel Zhang <guoqing.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Samuel Zhang <guoqing.zhang@amd.com>
Subject: [PATCH 2/2] drm/amdgpu: fix incomplete access issue in
 amdgpu_ttm_access_memory_sdma()
Date: Mon, 12 Aug 2024 14:59:29 +0800
Message-ID: <20240812065929.1842802-2-guoqing.zhang@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240812065929.1842802-1-guoqing.zhang@amd.com>
References: <20240812065929.1842802-1-guoqing.zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: guoqing.zhang@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000066E9:EE_|SA1PR12MB7412:EE_
X-MS-Office365-Filtering-Correlation-Id: 147ec23f-f433-498b-3efd-08dcba9c58b4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?YwEqOrHmfrM0qVVeWDxlbIsuE8omkoUWCERMZeysQIXcWHELAkriJYpppjbj?=
 =?us-ascii?Q?1ibB0QPWqnM7TH8qgvDrPSVc+UXP/ZP1g0lRRSxgCsC/D8GY9SxiPbNgeYrf?=
 =?us-ascii?Q?qqtouAxWKLdGfCzvCWvRwlxEP2KlU8QeUtZyvwpFI4Nfh0lICArtgoa0EJqX?=
 =?us-ascii?Q?gVUBJisHKtazfd6jJfEJx8k8V8cthY2T+zDKHTGHy8wSJrW6IfXRqAq5+Xvf?=
 =?us-ascii?Q?Y50NwyFin2M0ceG9IX6dxsDIqDOgUrRtnxe2Z04PMqEyqw1kVQpbIOnS3C4/?=
 =?us-ascii?Q?cB+EagH42scXGlsEaKz21CrVTHGlXp5AWYzeRpz33+/N1WkewuoQbsVk7dZa?=
 =?us-ascii?Q?Zz6smACKauulg+QWOP2luZhZRZAkMbwYkw25kuozibeh3ONm2LU1902IfJ3D?=
 =?us-ascii?Q?el2ih/OlMn0dsFRxrEODzODOo8QJb2Mm2JtukgTsh7NjfUCA2JlubypBMK7p?=
 =?us-ascii?Q?Yp8mXRRInZI115cizXFOwkqj67XRMTiV3EQFGdyS6RFo+R7xuP9jmbZ8fmSx?=
 =?us-ascii?Q?HB/z+R/MP4fZj3StRsNFgUvm8n9GESMt1l7PkiwQXhkMATYZHOPt5N1oMheh?=
 =?us-ascii?Q?Rk4ABkntbUvi+mKxDbQpbqRK76YkxL/gVYj0IKwguwH/wbNI7t+vTkflwp7F?=
 =?us-ascii?Q?QS6vSqBQ7/V76ojVkq+J9tuMm6ra+Yyy/78HBbCvSjVDO56zjNtYVVO/O+Qj?=
 =?us-ascii?Q?QxkFBXL0izZC2oPz+3HP07XXRYiLRcdakCWM99C8qwADrh7+h9LUvPibs+4F?=
 =?us-ascii?Q?SQVyc3wDOqYvm8/xFSpc5Ai42glwmO5q8aVd8cvSaboeHuPdMa4EsiKW+sWY?=
 =?us-ascii?Q?AY9KKpPGYvvVm8F8rfpzvxSkWqmKwXa5xRvMZpCleLf+T7S37xmvlw62wogi?=
 =?us-ascii?Q?fGrlihAngmPffWTiRIdr5EDX0E8GUGFI8Jwaxt6H+VdkFT/1TGPtcN2z+3ul?=
 =?us-ascii?Q?N6F4KAZmYxIXx6PVJ6tBa677KmksWAOItMXjcWETS3zWI+vinpfOeTc5HjDg?=
 =?us-ascii?Q?rvDV00frtWpwOgRF5017XmsymU9XeCvf7OMKVk2bj89MVCnPWBYYQ1Apsgrf?=
 =?us-ascii?Q?L+v7waU//4h6y0B1RQPutly3bZ8KcmCQvJMxOuzTTBu1wkcuG2iF3Orf8DyP?=
 =?us-ascii?Q?ZDhBO1TOhFvTRKzJUaGdTbut3NTksedmLljvoaUyz4tm+BDMaMWr0myN3grt?=
 =?us-ascii?Q?zU8u4F/8Kvxrd50PVraCG9mr6QHdocsG4hN+AgYsXf6nqdYBLL8NMoJdv8bp?=
 =?us-ascii?Q?XZxTQhfp3/Nv/2jvn5IR2ybWoavrh2zkFaJMnTCkXk7NtdkFBQ9SdaPl4H3L?=
 =?us-ascii?Q?0Nyf5FQepgUPu2lvmfEUZiZ5E9URt40SeNFEwF46m9+gnJ5TpCVdvnSeNdBH?=
 =?us-ascii?Q?bxuE8El9sCsqdHaFDv9b6wrmh5az1ISzY086Aahf148Qq/dnCUUZjYeKf+no?=
 =?us-ascii?Q?rXcJP8Ar66/tAwUZn+OmRx7l5LgA7tDu?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2024 06:59:44.4233 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 147ec23f-f433-498b-3efd-08dcba9c58b4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000066E9.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7412
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

The requested access range may be across 2 adjacent buddy blocks of a
BO. In this case, it needs to issue 2 sdma copy commands to fully access
the data range. But current implementation only issue 1 sdma copy
command and result in incomplete access.

The fix is to loop the res cursor when emitting copy commands so that
multiple(2) copy commands got issued when necessary.

Signed-off-by: Samuel Zhang <guoqing.zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c | 26 ++++++++++++++-----------
 1 file changed, 15 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
index a6e90eada367..c423574acd5c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
@@ -1484,7 +1484,7 @@ static int amdgpu_ttm_access_memory_sdma(struct ttm_buffer_object *bo,
 	struct dma_fence *fence;
 	uint64_t src_addr, dst_addr;
 	unsigned int num_dw;
-	int r, idx;
+	int r, idx, count = 0;
 
 	if (len > PAGE_SIZE)
 		return -EINVAL;
@@ -1498,7 +1498,7 @@ static int amdgpu_ttm_access_memory_sdma(struct ttm_buffer_object *bo,
 	if (write)
 		memcpy(adev->mman.sdma_access_ptr, buf, len);
 
-	num_dw = ALIGN(adev->mman.buffer_funcs->copy_num_dw, 8);
+	num_dw = ALIGN(adev->mman.buffer_funcs->copy_num_dw * 2, 8);
 	r = amdgpu_job_alloc_with_ib(adev, &adev->mman.high_pr,
 				     AMDGPU_FENCE_OWNER_UNDEFINED,
 				     num_dw * 4, AMDGPU_IB_POOL_DELAYED,
@@ -1507,15 +1507,19 @@ static int amdgpu_ttm_access_memory_sdma(struct ttm_buffer_object *bo,
 		goto out;
 
 	amdgpu_res_first(abo->tbo.resource, offset, len, &src_mm);
-	src_addr = amdgpu_ttm_domain_start(adev, bo->resource->mem_type) +
-		src_mm.start;
-	dst_addr = amdgpu_bo_gpu_offset(adev->mman.sdma_access_bo);
-	if (write)
-		swap(src_addr, dst_addr);
-
-	amdgpu_emit_copy_buffer(adev, &job->ibs[0], src_addr, dst_addr,
-				len, 0);
-
+	while (src_mm.remaining) {
+		src_addr = amdgpu_ttm_domain_start(adev, bo->resource->mem_type) +
+			src_mm.start;
+		dst_addr = amdgpu_bo_gpu_offset(adev->mman.sdma_access_bo) + count;
+		if (write)
+			swap(src_addr, dst_addr);
+
+		amdgpu_emit_copy_buffer(adev, &job->ibs[0], src_addr, dst_addr,
+					src_mm.size, 0);
+
+		count += src_mm.size;
+		amdgpu_res_next(&src_mm, src_mm.size);
+    }
 	amdgpu_ring_pad_ib(adev->mman.buffer_funcs_ring, &job->ibs[0]);
 	WARN_ON(job->ibs[0].length_dw > num_dw);
 
-- 
2.25.1

