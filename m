Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A56A4D38FED
	for <amd-gfx@archiver.kernel.org>; Wed, 14 Jan 2026 16:48:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 45D4410E64D;
	Wed, 14 Jan 2026 16:48:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="KlAnRrqd";
	dkim-atps=neutral
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011071.outbound.protection.outlook.com
 [40.93.194.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 636E110E654
 for <amd-gfx@lists.freedesktop.org>; Wed, 14 Jan 2026 16:48:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lQ/fvS02BOS2Awk5+BKOZD7+sZ8xfv78bIjoYHD8P2nBpqvdLE9QAZnnMHRTDH3EINsP87yOcErSAgrLO1YKzlDI15i149VlnDL7tG37uM34Pasb6MeMpxuFr3uz4vS30ATezRuxADS7c6pbBMlmYgEqVI+ER9RVhcf1hkVSasoEakAtA38lQt05CKVB1UkmxOE4RofSD5t9g1bwlIg6LksrmfU58fLBjHc/IhEfdMfwkgahLEXDujdJlODlX+3gQFePBtkRT4iRfqOksNb2wyv2Mgf5bG3tNEMasFOLm9UWMMj03By/cnIvpsLyGHqga2QsYKJCDn0MVhAY/8U0YA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nrjefFgZCTbboZkbIbsn1K4lQjeLn5oLfKVZY3ZqSGc=;
 b=SDfTf603VC7o6UHHFqCYBx8lvYHOM/zFQuNUNypM2kXJ5IZ8vWAMq6DV36IuR9pNvEwXOIlJjJXS7L/OvR+cn85MzfICoy0w3/MBo74cHEFfgXdnIOFnhRd/Fd5OkAjBJWvPHuKCPdcks+B5go8y1UPM8o4HAerm+roX9ppBq1zwVgNuMDao1A+shMpmIJuQH0h4HQGVn8g/8Z9SKsmxa99aEoeMMPMHFCtDxI9rE3gpeLyStybVT8ARSyyyFsHfXogVW/Ifn+bhfs6/rd6Z0QfyyRjOW428/ELGta/RJflztNF+kuM9edGROwfYWqyZBZYadc51TNI2I6x/KYbHTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nrjefFgZCTbboZkbIbsn1K4lQjeLn5oLfKVZY3ZqSGc=;
 b=KlAnRrqdZKQFL02HnkpITSS2f7XWyW9iIZHyRloDCtNPx5TNgKrzXd93ONzXAmOAklwrCH20/D6o/P8duZJLLVXoX5DmMgtjXtmxpPkUJsYC+f6qF5c19mDHgzyBOteo38bxiuEJIAO4sA/2a/dZAj9yR6URGq4fgEuEcwHClio=
Received: from MN2PR18CA0027.namprd18.prod.outlook.com (2603:10b6:208:23c::32)
 by SA3PR12MB8021.namprd12.prod.outlook.com (2603:10b6:806:305::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.7; Wed, 14 Jan
 2026 16:48:06 +0000
Received: from BL02EPF00021F6B.namprd02.prod.outlook.com
 (2603:10b6:208:23c:cafe::ae) by MN2PR18CA0027.outlook.office365.com
 (2603:10b6:208:23c::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9499.7 via Frontend Transport; Wed,
 14 Jan 2026 16:48:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL02EPF00021F6B.mail.protection.outlook.com (10.167.249.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9520.1 via Frontend Transport; Wed, 14 Jan 2026 16:48:06 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 14 Jan
 2026 10:47:45 -0600
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 14 Jan
 2026 08:47:45 -0800
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Wed, 14 Jan 2026 10:47:44 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 19/42] drm/amdgpu/sdma5: switch to using job for IBs
Date: Wed, 14 Jan 2026 11:47:04 -0500
Message-ID: <20260114164727.15367-20-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260114164727.15367-1-alexander.deucher@amd.com>
References: <20260114164727.15367-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF00021F6B:EE_|SA3PR12MB8021:EE_
X-MS-Office365-Filtering-Correlation-Id: 8938d590-a272-433b-b9dc-08de538cb148
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?x5mO7012wQJmk5bCj+Tmu9xReUUZKIVdcFmDuCJf+SvA5daaq2QRVTbmxLEh?=
 =?us-ascii?Q?0PU7PLKkjG/AsooE/1DYBcMovDUURNsMV+Diz3dpOYgMzhlhCQfKkLVc0DXu?=
 =?us-ascii?Q?qUK2iitZW9uq+HSsnArThe+RJd38TCxJKpQI4ZE7ZeTrwI/r5VWXBat4daGa?=
 =?us-ascii?Q?XwxeZExq6IMH+7tch1IR/sbMthXz2n4xH0BrJyz8MrZ8o0OGyP3rQEAJciXA?=
 =?us-ascii?Q?tC4V1UjQim232s8aILa0Oau3gYe7SSGRjq0tuutbCLw+R5S+BL+CDf7eWWXi?=
 =?us-ascii?Q?Q96JxrWAFMmGwy6Q2VmhcdCeph0i6GSanL3+xoHnlxFSfg5fauKuD915F5K7?=
 =?us-ascii?Q?YLniB1iZSg7ndz0oEJ1r09Hd7vCc0mpfMmIWxQc9nD24qNhwmDBzLXTatUgh?=
 =?us-ascii?Q?g3S2W7vqNlZr2EZZPyx9EzbnKTw/PGXBoG7R8lZNlA/Uh2lFpzi9kkOn4rz0?=
 =?us-ascii?Q?cPNWB6ASWRAZ7i4ZeTBtrjGLfqg6ZXUi0mONTRwVTpmhZWouj0NKsa6lu3aw?=
 =?us-ascii?Q?DmAzm+Z6ryeFApHjJOGTP0coKFe4k70NcPOFefjc5+Y262Emu7aCYlLobKHd?=
 =?us-ascii?Q?hrYLACnsAtXhRluUaJVdFoUgdpIXmhtKV6biYj06hZiRJgdLPanhJ1ZJQzrH?=
 =?us-ascii?Q?G+MYbrETK4y61CM5ln2fq4YksE1vvgMX2T7f7zoH/O2dMruPhZyGJZeDbccd?=
 =?us-ascii?Q?RZteLnBYi1tIL38+QNPEh4f6SK7HVwZ7uTQ8pdajaY9qvcDwpwEuzm5WsQwS?=
 =?us-ascii?Q?jYzrMQTRrrtRwofiZeI8SVYdELg2qjfwJXq3lWReUySkXEC6i9ZeFCsUS8JS?=
 =?us-ascii?Q?slIvttGYisJCFHT/vfUmrZcnoR2hTF/MX6fYU+dJNJjj9nVeATlouhE7O6YZ?=
 =?us-ascii?Q?sW7doteVtrufA6YcLfTaJnf9bHoG/ydkMRRU9h9dFeak+gpkdoN3V+/uYxv4?=
 =?us-ascii?Q?WqAa6ypyx2Sqbq+HnLyJU7rwo8f2wNqdUR1XuxcNyD0UDhxCG7yzNUp0ZADF?=
 =?us-ascii?Q?f0avfMDxVEc6l1u/CbSRtBI7OMBKfQ0MZl2H3/P+xunJ/PC95XKgQhP16Fsg?=
 =?us-ascii?Q?u0sLT4G5ZwvN0go+cJTwLsCA5ft7nKOzy6lMZuSxdJLnfMLSleTHo4QjMbog?=
 =?us-ascii?Q?PXsGGv1zB/jYbJ9SycGbLzGU2xxUXX9HjRmj5WSq66CRe0kaft/wFrbljLFJ?=
 =?us-ascii?Q?M0hWOOP8vFe1oYDE5MRc7YdkIS/Jwy9rpcnMYexyBfGOqrpFK7QqkSP3J8V/?=
 =?us-ascii?Q?1eUpgOZI9Ldb0U9/Ci73iCR9A12aqpYPfuMWB75WKL+0E2o2gKrmqz1Mpr6s?=
 =?us-ascii?Q?LXdZpzcBFJrjT8MM/j5Zn16ubARhis+c59XbioBHg9sv/Wm6uROHN1t778K8?=
 =?us-ascii?Q?5wlMGl4Zb+L3fO0LPH+G2DiEGOQ9w78Ny8d2hEe/wXSrrFO5KtWegaObeNu2?=
 =?us-ascii?Q?7J1Kkx1QrerFrnDHVzB5twYWw72TADhZ7m3tQTavhwXeThsHjefkUuEKVCT6?=
 =?us-ascii?Q?DMg83GaBiJxZvekia5zWE4hEAmvAT/v993hcHSf/OOBfA22NNDb7gEec2Bmz?=
 =?us-ascii?Q?Du6C+E24wohv0Aj/tD6w3xC+vV+B02dH6tvo9eiu8p4R5bWQaSTb4ovl7hCs?=
 =?us-ascii?Q?w/HGHuXbCr9G55SFbfPGjcWfKIWuD162ZS4qNaBvlYhDFANXIKd9c5DLmKHX?=
 =?us-ascii?Q?v4V2gQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jan 2026 16:48:06.7612 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8938d590-a272-433b-b9dc-08de538cb148
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF00021F6B.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB8021
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
 drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c | 37 ++++++++++++++------------
 1 file changed, 20 insertions(+), 17 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
index 7811cbb1f7ba3..786f1776fa30d 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
@@ -1074,7 +1074,8 @@ static int sdma_v5_0_ring_test_ring(struct amdgpu_ring *ring)
 static int sdma_v5_0_ring_test_ib(struct amdgpu_ring *ring, long timeout)
 {
 	struct amdgpu_device *adev = ring->adev;
-	struct amdgpu_ib ib;
+	struct amdgpu_job *job;
+	struct amdgpu_ib *ib;
 	struct dma_fence *f = NULL;
 	unsigned index;
 	long r;
@@ -1082,7 +1083,6 @@ static int sdma_v5_0_ring_test_ib(struct amdgpu_ring *ring, long timeout)
 	u64 gpu_addr;
 
 	tmp = 0xCAFEDEAD;
-	memset(&ib, 0, sizeof(ib));
 
 	r = amdgpu_device_wb_get(adev, &index);
 	if (r) {
@@ -1093,27 +1093,31 @@ static int sdma_v5_0_ring_test_ib(struct amdgpu_ring *ring, long timeout)
 	gpu_addr = adev->wb.gpu_addr + (index * 4);
 	adev->wb.wb[index] = cpu_to_le32(tmp);
 
-	r = amdgpu_ib_get(adev, NULL, 256,
-			  AMDGPU_IB_POOL_DIRECT, &ib);
+	r = amdgpu_job_alloc_with_ib(ring->adev, NULL, NULL, 256,
+				     AMDGPU_IB_POOL_DIRECT, &job,
+				     AMDGPU_KERNEL_JOB_ID_SDMA_RING_TEST);
 	if (r) {
 		drm_err(adev_to_drm(adev), "failed to get ib (%ld).\n", r);
 		goto err0;
 	}
 
-	ib.ptr[0] = SDMA_PKT_HEADER_OP(SDMA_OP_WRITE) |
+	ib = &job->ibs[0];
+	ib->ptr[0] = SDMA_PKT_HEADER_OP(SDMA_OP_WRITE) |
 		SDMA_PKT_HEADER_SUB_OP(SDMA_SUBOP_WRITE_LINEAR);
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
@@ -1133,7 +1137,6 @@ static int sdma_v5_0_ring_test_ib(struct amdgpu_ring *ring, long timeout)
 		r = -EINVAL;
 
 err1:
-	amdgpu_ib_free(&ib, NULL);
 	dma_fence_put(f);
 err0:
 	amdgpu_device_wb_free(adev, index);
-- 
2.52.0

