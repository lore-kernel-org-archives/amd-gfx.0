Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47C6BD38FF0
	for <amd-gfx@archiver.kernel.org>; Wed, 14 Jan 2026 16:48:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A7C7010E666;
	Wed, 14 Jan 2026 16:48:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="hY75iTE7";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012061.outbound.protection.outlook.com
 [40.93.195.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AC39D10E65A
 for <amd-gfx@lists.freedesktop.org>; Wed, 14 Jan 2026 16:48:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Xky/pwKMLzJpQmkPMDfNbKNZH47fat62RUcAg4dzYRmvzYqdqeTyMaqT1Pitt7286IrSlL6Kj1i8zM20BHq827UeRFJ9UVKv3FsnS/pxJxnLSjOWJq6ztcXlNzY91iPR7c7hL8xWnv1ygs5Ylp8Do+XTjRGdpJoQIVTGb6XT1SqRbhGYhNeDfsKiPRdEC4dvsgKsfne48anTJF7u6x0C77d/UvP2aJsAEh9ahReA3D5hXxBerixYx8159g1gj2oD4XorWGA2Pp12Yry5YKftfRugtP9267Ra1zlzDy/hdPbL23DfhGjD9FTx8mGKvaP2LKf5ch2ySsRyce8N+3NMzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1Ea3qMVyyPwoGnupDmqyLfX7/oKR2Er1ePraw6+AFos=;
 b=NWw+ETFvBskhrQKH7vw2dd0fDMbD1l2ZMe3pqFnGK8rbkWovcUqy5gj2uwiSrF6f3AdNprGZknYeD4CGPZkm+gBFTzPX7iB3rOXGgMYWyh/glMCN0BXjSiD7A3Hvxr5PVD3mCFn+RM/2AJDkoIDE5+zDVLnNEktehClfFmmyf1PQWAuB2zoRWj8K9OquY55Ualj5V0Y+U9vTE1UDH8UfwGWeJPUw5HWdWHtMVuD11YMjobTbp1pUOeYFu7UEzjfPom5wbi70lgllSxUVpi+eF8pNITPowX+KrPlasox6Fv0tL0cTpDupmkz2VkaJCy46qsLPPhDbOwZMRrSJYbtQzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1Ea3qMVyyPwoGnupDmqyLfX7/oKR2Er1ePraw6+AFos=;
 b=hY75iTE7fthgG8sGZdp35sJRZywdAyHmSindMg+6IcYSbvH/HnCQa24ep9Il0XT5ItDJGI1ERrjArkTPWllyd4LAYViCgycSY+86D+SwSA1CHwO47LQNZlbq1AB68kbdBJfebmJAdSbVPhChwVUvUfgWI5KbYct+esRbfRlPDgk=
Received: from MN2PR18CA0021.namprd18.prod.outlook.com (2603:10b6:208:23c::26)
 by PH7PR12MB6466.namprd12.prod.outlook.com (2603:10b6:510:1f6::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.4; Wed, 14 Jan
 2026 16:48:09 +0000
Received: from BL02EPF00021F6B.namprd02.prod.outlook.com
 (2603:10b6:208:23c:cafe::e3) by MN2PR18CA0021.outlook.office365.com
 (2603:10b6:208:23c::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9499.7 via Frontend Transport; Wed,
 14 Jan 2026 16:48:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL02EPF00021F6B.mail.protection.outlook.com (10.167.249.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9520.1 via Frontend Transport; Wed, 14 Jan 2026 16:48:09 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 14 Jan
 2026 10:47:46 -0600
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Wed, 14 Jan 2026 10:47:45 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 21/42] drm/amdgpu/sdma6: switch to using job for IBs
Date: Wed, 14 Jan 2026 11:47:06 -0500
Message-ID: <20260114164727.15367-22-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260114164727.15367-1-alexander.deucher@amd.com>
References: <20260114164727.15367-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF00021F6B:EE_|PH7PR12MB6466:EE_
X-MS-Office365-Filtering-Correlation-Id: f49c60de-2837-4a87-5d88-08de538cb2a6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?mamhDZinyALFUf0/NgBIhwZ9rWdwYS3Y45vIfzreP6dJ/xWX3iSarS0cBli3?=
 =?us-ascii?Q?Mv/kFyXp+xdmuEZ3p6g4hfBjDuE6hH6PuIZMJ2AvYVwHo2EGtpKO+LGY7yKE?=
 =?us-ascii?Q?mK+AP3C5ceFGJKp5WxwyENO5rysQzsGfI5190wGLZwhMB4vtp/K12L2URCm/?=
 =?us-ascii?Q?lm5twHNd8mLgfLgNa69AKTdtPelsODD0O3eWp+Ke+wGlWTRWTwhv5XbfX23/?=
 =?us-ascii?Q?ns329YeOtz1l8BrJNr5gBtTCmue0W1qQN4D1o76aonhRCqpuOLEK4xZ26loV?=
 =?us-ascii?Q?3n/VOHpOau5G0wsgz+wV2QWhutaYjAxn+rvMYkdpvUMO3BmvyKgv3QhNfvrq?=
 =?us-ascii?Q?ZpKmk4TLgsI5J2HSvQ6GUKg7xrxz7dwi5J9JnngIKJYQdDNpM8ERTCCG2gMt?=
 =?us-ascii?Q?gr8V36oSUDoa0U9O6RNATzssIvFjF052LLhdS3RIyZ1xFjeOvrhZIyx0L0PE?=
 =?us-ascii?Q?qSVgGJkSG31bxcMntvdadGCHqNIwS3MVOa0nKL+8SsYV6tniGU/Wcr3c/L/p?=
 =?us-ascii?Q?Cn/UmCWn0PUzfSG36funRhGEtdz7SfojN39h2Db/+2zD9wc9p8nuuz4DQCTv?=
 =?us-ascii?Q?Hnv8Vbnz24GLWcSCgDvfi71lOUDQu2UowQyL1O3ufbBY3LsHOmVd/gR82m6L?=
 =?us-ascii?Q?LvL3JrIEATAZX2pGNGsfGMEdZdE/mP3fCvNHN8gZFyCLAe5TzKU74yu9lQYO?=
 =?us-ascii?Q?nW01gQvV/Oczu/7zKyhoEp++16a3YIA1KTS7Yyrp8bXOb//KI2t7EHIYtI32?=
 =?us-ascii?Q?J6VU0RgIz+6EzjVIdTgso5htiHqkN15XyPOIK1UCnC+71LB8y3i72iCENRLL?=
 =?us-ascii?Q?+/xmeZXHUgIiGwyPPynxCKxXWzjCa6HWL3lO0saya7M+5pU15owD9CRumO1C?=
 =?us-ascii?Q?oQOlx2e34pmZIMtFjZys/zNPIkYxTo/j27Iw3vntWr6plPikC2UOeNtQKyOw?=
 =?us-ascii?Q?386X6eKlKvBFZ05mcn4fLCD1B+/mys0SbWjIZSCcm7JkUkl6+CacseGwO9Te?=
 =?us-ascii?Q?mr6+avtQqAQX9YTFlAt6zR9QYY9eTC5FWmpfxkss/+gGQura/LfkaRkbzn74?=
 =?us-ascii?Q?vLhDL2GD51zRNoJ32qpWxjVAdQSBFvHaKyzWab53LRl1bPzpTEyvam1V6tiN?=
 =?us-ascii?Q?ZnNP75DR0xZ3r0B11ePtHFfQWd3vwvuazJJe7krIC7VkPXdX4zbje/h44WCK?=
 =?us-ascii?Q?SpjtzJ6bDDelOv6ok91Vh5ELDTlW36oELZJUeHXKqikRTopMGyCNcdMArjc9?=
 =?us-ascii?Q?13Ak6SK7RaiTqa3AfZ25mFl9sIq0IEfaerxXQB2tGhB+WnQQ4HPEPy+qNcAS?=
 =?us-ascii?Q?r/rKf5znMRH8M4ZapFViqSOGjhMy4XZlCQXoH5BfoflS+CM8xQdNlALrBJYk?=
 =?us-ascii?Q?si2K35/l+FT0FG7JOhWZPg2lOIVdKuBjH7n7ydyQdUS3+Vd6/pZBOrgV/Zcy?=
 =?us-ascii?Q?p948ZUi5NNlnV0dScSGTg10PUgjTzfLUB9/7S1jUlV6DAZ+3cPBBYAI8O1Tc?=
 =?us-ascii?Q?R9Y+Wkl+w+q4UQ2qaqzl+GnAfks9hFIGen6LC6OElMwlXaNw26WVywew/OZ3?=
 =?us-ascii?Q?VPf4mVdd4roYj8iIAgIRjHmV7vThjlnPBBs3mIFTyPPp4UAFGhDPtDW3dvBH?=
 =?us-ascii?Q?VM5kwwOVH/GxGia4EJF+VF2mH27glLlihDQ7vlcvXvU9wli6+eZzoIetDviA?=
 =?us-ascii?Q?6d1y3w=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jan 2026 16:48:09.0598 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f49c60de-2837-4a87-5d88-08de538cb2a6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF00021F6B.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6466
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

