Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A3FED38FED
	for <amd-gfx@archiver.kernel.org>; Wed, 14 Jan 2026 16:48:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 08EA510E64A;
	Wed, 14 Jan 2026 16:48:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="u8UqrusR";
	dkim-atps=neutral
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012042.outbound.protection.outlook.com
 [40.107.200.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6662E10E64F
 for <amd-gfx@lists.freedesktop.org>; Wed, 14 Jan 2026 16:48:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dj+31RYExilXuSAkbUPT6GE6RXaprFgIHxtg8oC4lOdXDcoznv75u/5AMOmKhEgH0XpY0YEOtSYNQ6FlFekJhR6nRoHVAT+HKhi3IiyiTaJYZhbyMys5DhqlqDIkV4OPe6RmvoGJAg3jXrxyI/bihC4oaJL3iB14ZTJqNre03+vNWN9A5SgHzs4AoUOL4cBdrMyDbimoSpyDYvMvuZehZW7WPLj5GnXDiz3ItfNVx6NY8OZ2pVSKBGUg7SZcJCjR3CWpgJsczWmySbzPbJU3DwdxAW8zlYuxnJt4DEbUFaPAf4Qj3C0MPX18uiZzCpgKicLFfDLVt7j7IJyGQET9gg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uYZQ7eiv8jMfSXPYMrXFSlxfMwW76UA6+oI8PJDunso=;
 b=CWBTnXJuaJNvGOQUFgG1Uk/4Yv/KFieAvY8WeQRZz/phQ5V46QaoRF8OGlxyvPsmlWDFYpG8tdYR9uZCFDQJCkyMvjcuONB/4ieKzcepODohjsw0M03UuTJTPLKaMtrgchG0yuuoe/e76gb5ZCJbCn/je6aOHOMvjMr1HiXW+UO0yON/aVR/Av4rtbxaNT5Xnxw4lsSt4rxMW/FjNLKizLjBs6dNkU0rEutmBFTAjagt3eXa1TQhpS3RMqsMNEz9cQUvBh23lQ/RwndIEFgieyg3YPUAtMlHtST4Fzj4KKQqGaymz5oIZbYCBvrreBvHNs+m0EQK786VjVC+s8WT+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uYZQ7eiv8jMfSXPYMrXFSlxfMwW76UA6+oI8PJDunso=;
 b=u8UqrusRBFcVYYEa1LoH7O+SQwKPv7BFQIos4dmmuASurOUl/mSNo/SgbKZgbhIuGtWyyfnEE5sOvaQY+hToKaqH0sppaAaJ1com2biwh77zfx4FGFuiVS3TMk0XYHvsbET+VEN39ahUq0zh5NaEsrsAl/akmFwUDBTcjdVVYv0=
Received: from MN2PR18CA0006.namprd18.prod.outlook.com (2603:10b6:208:23c::11)
 by DM6PR12MB4434.namprd12.prod.outlook.com (2603:10b6:5:2ad::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9478.4; Wed, 14 Jan
 2026 16:47:59 +0000
Received: from BL02EPF00021F6B.namprd02.prod.outlook.com
 (2603:10b6:208:23c:cafe::1a) by MN2PR18CA0006.outlook.office365.com
 (2603:10b6:208:23c::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9499.7 via Frontend Transport; Wed,
 14 Jan 2026 16:48:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL02EPF00021F6B.mail.protection.outlook.com (10.167.249.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9520.1 via Frontend Transport; Wed, 14 Jan 2026 16:47:59 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 14 Jan
 2026 10:47:40 -0600
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Wed, 14 Jan 2026 10:47:40 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 09/42] drm/amdgpu/gfx10: switch to using job for IBs
Date: Wed, 14 Jan 2026 11:46:54 -0500
Message-ID: <20260114164727.15367-10-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260114164727.15367-1-alexander.deucher@amd.com>
References: <20260114164727.15367-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF00021F6B:EE_|DM6PR12MB4434:EE_
X-MS-Office365-Filtering-Correlation-Id: 067c7c7f-d094-4de2-9bfd-08de538cacc2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?/Du+cOWWQzfB3zDOaAKR5bkMwISOf5hU6hqJIRajmw/bemqISc6Ku67+yi9+?=
 =?us-ascii?Q?lmDkouaatVTbc+RaSZeHsBqJi+lLgO3SBVVY3fVsjqlucOf34rMRJYjRNc2e?=
 =?us-ascii?Q?KdsZjU8i1ZXLgp9FS6iODRPGM1k2Ffsf02n5sUUYCk/tKCd9Rh8mcPVXbOIi?=
 =?us-ascii?Q?VhBD8yka/GmOA6Tyw3l2dnMKrJ43wYHs3aDfhL8aZRp1Yh9aMAvnymt2b9Cz?=
 =?us-ascii?Q?/uA2WjgAhiQNVJ7R1AwO10m22AVXjnWOu1Zr/hw8Gyt2xekDNqo5g2RyDLy/?=
 =?us-ascii?Q?BhWR0P0QZ7Wq7OQ/sZ4UEWfjxeZJ7M/HmrJCWPMw5j+DqkoSK1p/bQN8FYKa?=
 =?us-ascii?Q?PdgbaJYQUJFIqZRnzwKEZ8MGMd6ZNj3dLKslUMTG7bS5+TDJq9QurSY5HgKs?=
 =?us-ascii?Q?mXCtTeV+mBRhzxXgZP0ALgIoRjsZokFvch40PM8O99Nge9vYZtYUUqnJfEdt?=
 =?us-ascii?Q?9y9x7p+FnnzxL5keoPH4J+Zs9Us96kpzaFZ2Zh3rpeL9s9JWpV8mdeC/3IvE?=
 =?us-ascii?Q?FJV84EdDfqLIyG4RG6eTxtmmiu0OL25XCLBfItTVwJxOcKgY230JjP3BW6rC?=
 =?us-ascii?Q?XwPVo9xbY6pm6mgK4OXyHoxpJf2dtr2xLoLQpOVxjLEljao6TqcpLg75MX4p?=
 =?us-ascii?Q?tQx29+opd24cfQ98C1FPTQFJssqOii6FUM0pSdEfjHfk+I/j40B4QA7dZTEE?=
 =?us-ascii?Q?gT3btfsA/+RPvTSozieXka95n1nWCnxAGH8iI90jG+f7rLTxnBAn9PiTjSMC?=
 =?us-ascii?Q?0qpBJAWTiKzlCefpi85DCQaNyNe3iv1QfCAfbwCIJ8R0TiXKDRq1irY9mafF?=
 =?us-ascii?Q?CKvah8xQ1GrIicygAoyx5JwTHbRJ2eoj9j/WwLxsNORGn5HtkZRf9nGWY7qw?=
 =?us-ascii?Q?IAU1AVNzO9ZOA9waJmCH0wOLCEop5t7x7MzT36xjY8M8dt5W1tmJ9BTfqhCA?=
 =?us-ascii?Q?KuS/4ZtTn6kPDqOm8vzfijaGNcZ3AZjvwGJ+oeWGRxw0wA3/MLH39bJqvsea?=
 =?us-ascii?Q?tGjIU5Mco6kPxHCSPb2M7P4Iesa+jcTnYiVt+qqAaT3W0ls5s9/ix3ne2McL?=
 =?us-ascii?Q?jpd293rVwYRRbFHEfjWEGLmNrmegzPFWXmXTzn8e6VRPV1ocH+Wsh0LzaiXv?=
 =?us-ascii?Q?hDxWq959Cs92okuVoHt2zRTm7WSfFg6TZHq0QcsFFnufCi9OfQOwohE4gHlY?=
 =?us-ascii?Q?Im8uoo57nXS/OIwxoBuXrHF8WVEsZvIPqSxDYPFkoWrVDczTVdLdxaoHGQIQ?=
 =?us-ascii?Q?p38gzXITjck86TkWeB17JPGvXLLhs//EdRSNAPq7kX6SUCPTeRz7WFprT09s?=
 =?us-ascii?Q?o1yjYDSfqXG5jRnSex2VRnJnqkeCwkztywQKEYSGZcYLsso0xPxt/xsRihDm?=
 =?us-ascii?Q?PB/NCkyGrkhwiRngvFbxoJ8GnLsPEB2zjdIEGgeTN1Tm9rlxpsmHTWMBERzC?=
 =?us-ascii?Q?JUM5CbHKgTQkbT9aLu1xLrBnYd5quRDumRNMhL3bdWiV8E7zGxHY1oM8NZ6J?=
 =?us-ascii?Q?JW8/k0utIc+8BJh4TySHstDQxRxPvSoMfysjATrTEeJFSkVha3aVm+mTB+En?=
 =?us-ascii?Q?RhaCt91HZ35455PwoPpwkXsshpSDoqTtyGuKaRJSMxIqX4vfZBeGtmQ0lrQh?=
 =?us-ascii?Q?IRQfz6ncYOOBizGqhUKOktpfXE+WqpbaFFCzRSz2Vn6o8KZILOFDlLaszds1?=
 =?us-ascii?Q?kbg+ng=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jan 2026 16:47:59.1716 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 067c7c7f-d094-4de2-9bfd-08de538cacc2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF00021F6B.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4434
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
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c | 29 ++++++++++++++------------
 1 file changed, 16 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
index 41bbedb8e157e..496121bdc1de1 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -4071,15 +4071,14 @@ static int gfx_v10_0_ring_test_ring(struct amdgpu_ring *ring)
 static int gfx_v10_0_ring_test_ib(struct amdgpu_ring *ring, long timeout)
 {
 	struct amdgpu_device *adev = ring->adev;
-	struct amdgpu_ib ib;
+	struct amdgpu_job *job;
+	struct amdgpu_ib *ib;
 	struct dma_fence *f = NULL;
 	unsigned int index;
 	uint64_t gpu_addr;
 	uint32_t *cpu_ptr;
 	long r;
 
-	memset(&ib, 0, sizeof(ib));
-
 	r = amdgpu_device_wb_get(adev, &index);
 	if (r)
 		return r;
@@ -4088,22 +4087,27 @@ static int gfx_v10_0_ring_test_ib(struct amdgpu_ring *ring, long timeout)
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
@@ -4118,7 +4122,6 @@ static int gfx_v10_0_ring_test_ib(struct amdgpu_ring *ring, long timeout)
 	else
 		r = -EINVAL;
 err2:
-	amdgpu_ib_free(&ib, NULL);
 	dma_fence_put(f);
 err1:
 	amdgpu_device_wb_free(adev, index);
-- 
2.52.0

