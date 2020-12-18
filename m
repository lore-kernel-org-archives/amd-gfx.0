Return-Path: <SRS0=OQM/=FW=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C727C4361B
	for <amd-gfx@archiver.kernel.org>; Fri, 18 Dec 2020 13:56:09 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B217F23A51
	for <amd-gfx@archiver.kernel.org>; Fri, 18 Dec 2020 13:56:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B217F23A51
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3D12889E01;
	Fri, 18 Dec 2020 13:56:08 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam08on2049.outbound.protection.outlook.com [40.107.100.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3911689E01
 for <amd-gfx@lists.freedesktop.org>; Fri, 18 Dec 2020 13:56:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ADh62XPnslkESUJ1tvgVQKscjcXHBZdvWPBM/5reVCzU3E2O8Q/qN7v1JzZJU5unv8uC2w9ffftKoIMh880TE346n/nLIRCdkMcmNXQfGPms6F57uhpq+fT+KhDTpRS2FHKCMCYU0KZa6NirFlLXf/ehAxbDX2j9T6wyvcJjUbrVE680MZm3fZrupUNb4oX0Z9kdu8BuX1XSwQSkpqAzc9Bn0x4/pXcnKmrF1M8VV/kartvX99QxRE3LlmrfyewYRYdFfO6YpONkg4d0lXMedQDHwT+prX5+Ny9xr5Y2AjT+cRfJjiANge79yxnNdj7hdR4TrxH9kRMW8Kkoc03x9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kDpvPPiQnZnu4SB4pZG8MSpIuFCooFool/QS/KiV52E=;
 b=TqqhCyG4cuzL/qss/jPRKziRuGzjxCtqjGvHe/wDYqkrBIiSJGdWG0zYZKT07o4A/jWfhUabSBiJGBG3lH6LK4iew+s+K0wI3VX70F4RO/xAhHjM4xod55iMfcBiG5iMSoPQVUV38vQHmf6mArjInGtlvW/gVk/HRseIR206PImF2CAwJZJedzW432WEf0/uKdNl8bmY3cNQ8rrPtp64xwt0FSr0tIbJjX41oV6OZbyNQm265FH2jPJUG71U4PIUenUG5qdY8BqQVlN2GbdCQeS0E7+zSJhPBG6Kl0T2l9GGzyo3Di+bFD500pvmItUAqF13tX1uUTemUwsUxWv2WA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kDpvPPiQnZnu4SB4pZG8MSpIuFCooFool/QS/KiV52E=;
 b=KeAVIWrrgYxDK7eY2LZzurC1Q6/ic5I23Pt/tA2Nv2g8IGpJr9pdjv6uBOIVRzRjYTCpGiHHP7k9HwudNv3fT9SZPSM0kHRa3kez3gw876nslwURQcW9QVnoeGmz396jXeyDzrZ0sdISMoYb3ZwJZ8GbjLWNHb0fwe/PAIETMJw=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3916.namprd12.prod.outlook.com (2603:10b6:5:1ca::21)
 by DM6PR12MB3067.namprd12.prod.outlook.com (2603:10b6:5:115::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3676.25; Fri, 18 Dec
 2020 13:56:04 +0000
Received: from DM6PR12MB3916.namprd12.prod.outlook.com
 ([fe80::7080:fa49:2223:5f4e]) by DM6PR12MB3916.namprd12.prod.outlook.com
 ([fe80::7080:fa49:2223:5f4e%7]) with mapi id 15.20.3676.025; Fri, 18 Dec 2020
 13:56:04 +0000
From: Nirmoy Das <nirmoy.das@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 1/1] drm/amdgpu: cleanup vce,vcn,uvd ring selftests
Date: Fri, 18 Dec 2020 14:55:47 +0100
Message-Id: <20201218135547.5921-1-nirmoy.das@amd.com>
X-Mailer: git-send-email 2.29.2
X-Originating-IP: [93.229.45.20]
X-ClientProxiedBy: AM3PR05CA0109.eurprd05.prod.outlook.com
 (2603:10a6:207:2::11) To DM6PR12MB3916.namprd12.prod.outlook.com
 (2603:10b6:5:1ca::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from brihaspati.fritz.box (93.229.45.20) by
 AM3PR05CA0109.eurprd05.prod.outlook.com (2603:10a6:207:2::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3632.21 via Frontend Transport; Fri, 18 Dec 2020 13:56:03 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 2da8d8e3-3eb3-4951-8084-08d8a35ca949
X-MS-TrafficTypeDiagnostic: DM6PR12MB3067:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB30678D6917069F5FD9772E858BC30@DM6PR12MB3067.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1201;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ebzmjXUh9AxjIoobY6x6b6oyn/uCHT5W5WDnQ3AnnAHck5iJrbcQQXExeuRIJthnPSAm5n2e7/Fp4KcM/mMjNb9yYTwRBfWAIgHUxvypwCs5tgkCdzBc/eRj13UB3WKOjVu4PZucCsLCAIndq0Lu1XltHz2PHVeOSewIohAO9gSIwNqNQXmFi+O2vIFN27Iq/BBkAiWhrEPXxDkt9+lBOiviXljlL/AAEwwJ1zlffsmVmG9SlsfqGHlq39+89Al3tbop6r0oxpp1s0lOsSuEayOTh+1IGcFu2isrBuJDCGlUmfMG9X/p7v9E1prdO89nFIOtqVfXmLoaYKVgNGoewzf19/QB4LB1wYVdX4DPShOlZptjjfoQ1tdA6KFfpqN99M74qwCtH6R0uW3OZY5+iA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3916.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(396003)(346002)(366004)(39860400002)(376002)(5660300002)(83380400001)(1076003)(6486002)(478600001)(8676002)(6916009)(30864003)(4326008)(316002)(2616005)(26005)(8936002)(16526019)(44832011)(52116002)(186003)(956004)(36756003)(6506007)(66946007)(6512007)(66556008)(2906002)(86362001)(66476007)(6666004);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?zFW6DeCIk3Jx/D0rLf+xaFDAXs/LAdXUf+g875TLmImxoEkNAqpaD75iC3Yg?=
 =?us-ascii?Q?JXMreyqXeAxtflCgVchFf+gkpLJPyT8g9zrz5oyKeeSBzqMVq1e6+w7Iq3ij?=
 =?us-ascii?Q?KLDJDjxEh3+10ZwcyKWXahcfdDif5DyfDk2bQt/6+55dPR4ErAhVBl9M3EuE?=
 =?us-ascii?Q?p08GvRrAPW3jHGW4qihqBXoK4as+SJrsHyRe0J76K1BscUVeE0LR9u3dhD+M?=
 =?us-ascii?Q?tL18RYNwqT2Z7j8eqHKsHvlx2w6MAn+kyR2sKWAs3DgqymvIEceGS4Vpzdvb?=
 =?us-ascii?Q?cEliLg/8IrTwUWfCbTlhOOZOvvs1kLvtv0MMrg2zGVtpDImSt+HMBIGLH5DU?=
 =?us-ascii?Q?HY80I8K+hrKU/J0FCXJIRvGc6gAxt3QF8is9dRDCSejEymofp60W/++CviEl?=
 =?us-ascii?Q?7hgpZqNquUzZWzbdX0JqYap7A5QPrs8P1i0CcupaPYQizt/LXg2+Wdb+Xn2B?=
 =?us-ascii?Q?OMGmARs6vOG+0IBlsKPKK/MB1ciavBBx48YPvEX9U5t4ZQTg+uK4K0znMRNS?=
 =?us-ascii?Q?4EnV2ioG7iqcWMRkPiRAuSG3bthts9psmr+P4OUuysEQAJJ2K1Jgb2Uaxw7v?=
 =?us-ascii?Q?68qRZPYwGp40+sipoe9HNV7Y5cz0II8HyTq4WHhgQ4kIJSGzrEHZoCcVgpEL?=
 =?us-ascii?Q?bI7uKwhNJJp5bNUiY5z6LNylXgEsiCE6D1nVElmmcWmnOld/4tkwp06HdPz7?=
 =?us-ascii?Q?pTKdQC+beftHExpnmJo88vNLFM/+pejhzwR/UZYr3LKCH6bMpLYlcfqwoWYu?=
 =?us-ascii?Q?l9XGEQ9mVm7DepevDxb15dItUnaRxdjnjeP/dkob9aHnQmaWBlvaYESU10Qs?=
 =?us-ascii?Q?ZkSxK97+v2V+Fjl7zbxdpyor+wwsXN1Acgp5v2xj97M3rLYa9XWAHrZNFrrH?=
 =?us-ascii?Q?3aBXnt8emE7x8K/ZRgn00bJzQfAUF2yga3U0gIaTKeUQ62vNFGqGAv8JJjnc?=
 =?us-ascii?Q?4gJ2aAc3wsVACSFgAlCPiudx2DrkwFNgqG1b63xzBGKi4rn6Vw1nICk3M6bA?=
 =?us-ascii?Q?Rryt?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3916.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Dec 2020 13:56:04.4450 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-Network-Message-Id: 2da8d8e3-3eb3-4951-8084-08d8a35ca949
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cI0C6cBrb3E0kwxZLeTDDVshPkFI0UEecIuMXMYBXWsL9aETYrXSVFjIApLxlWT+U7votvR010TqDEhfRnjEKA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3067
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
Cc: Nirmoy Das <nirmoy.das@amd.com>, Christian.Koenig@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Use amdgpu_sa_bo instead of amdgpu_bo.

Signed-off-by: Nirmoy Das <nirmoy.das@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c | 56 +++++++------------------
 drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c | 17 ++++----
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c | 47 ++++++++++-----------
 3 files changed, 45 insertions(+), 75 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c
index 8b989670ed66..3c723e25dd5d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c
@@ -1057,7 +1057,7 @@ int amdgpu_uvd_ring_parse_cs(struct amdgpu_cs_parser *parser, uint32_t ib_idx)
 	return 0;
 }
 
-static int amdgpu_uvd_send_msg(struct amdgpu_ring *ring, struct amdgpu_bo *bo,
+static int amdgpu_uvd_send_msg(struct amdgpu_ring *ring, struct amdgpu_sa_bo *bo,
 			       bool direct, struct dma_fence **fence)
 {
 	struct amdgpu_device *adev = ring->adev;
@@ -1071,19 +1071,6 @@ static int amdgpu_uvd_send_msg(struct amdgpu_ring *ring, struct amdgpu_bo *bo,
 	unsigned offset_idx = 0;
 	unsigned offset[3] = { UVD_BASE_SI, 0, 0 };
 
-	amdgpu_bo_kunmap(bo);
-	amdgpu_bo_unpin(bo);
-
-	if (!ring->adev->uvd.address_64_bit) {
-		struct ttm_operation_ctx ctx = { true, false };
-
-		amdgpu_bo_placement_from_domain(bo, AMDGPU_GEM_DOMAIN_VRAM);
-		amdgpu_uvd_force_into_uvd_segment(bo);
-		r = ttm_bo_validate(&bo->tbo, &bo->placement, &ctx);
-		if (r)
-			goto err;
-	}
-
 	r = amdgpu_job_alloc_with_ib(adev, 64, direct ? AMDGPU_IB_POOL_DIRECT :
 				     AMDGPU_IB_POOL_DELAYED, &job);
 	if (r)
@@ -1101,7 +1088,7 @@ static int amdgpu_uvd_send_msg(struct amdgpu_ring *ring, struct amdgpu_bo *bo,
 	data[3] = PACKET0(offset[offset_idx] + UVD_NO_OP, 0);
 
 	ib = &job->ibs[0];
-	addr = amdgpu_bo_gpu_offset(bo);
+	addr = amdgpu_sa_bo_gpu_addr(bo);
 	ib->ptr[0] = data[0];
 	ib->ptr[1] = addr;
 	ib->ptr[2] = data[1];
@@ -1115,33 +1102,17 @@ static int amdgpu_uvd_send_msg(struct amdgpu_ring *ring, struct amdgpu_bo *bo,
 	ib->length_dw = 16;
 
 	if (direct) {
-		r = dma_resv_wait_timeout_rcu(bo->tbo.base.resv,
-							true, false,
-							msecs_to_jiffies(10));
-		if (r == 0)
-			r = -ETIMEDOUT;
-		if (r < 0)
-			goto err_free;
-
 		r = amdgpu_job_submit_direct(job, ring, &f);
 		if (r)
 			goto err_free;
 	} else {
-		r = amdgpu_sync_resv(adev, &job->sync, bo->tbo.base.resv,
-				     AMDGPU_SYNC_ALWAYS,
-				     AMDGPU_FENCE_OWNER_UNDEFINED);
-		if (r)
-			goto err_free;
-
 		r = amdgpu_job_submit(job, &adev->uvd.entity,
 				      AMDGPU_FENCE_OWNER_UNDEFINED, &f);
 		if (r)
 			goto err_free;
 	}
 
-	amdgpu_bo_fence(bo, f, false);
-	amdgpu_bo_unreserve(bo);
-	amdgpu_bo_unref(&bo);
+	amdgpu_sa_bo_free(adev, &bo, f);
 
 	if (fence)
 		*fence = dma_fence_get(f);
@@ -1153,8 +1124,7 @@ static int amdgpu_uvd_send_msg(struct amdgpu_ring *ring, struct amdgpu_bo *bo,
 	amdgpu_job_free(job);
 
 err:
-	amdgpu_bo_unreserve(bo);
-	amdgpu_bo_unref(&bo);
+	amdgpu_sa_bo_free(adev, &bo, f);
 	return r;
 }
 
@@ -1165,16 +1135,17 @@ int amdgpu_uvd_get_create_msg(struct amdgpu_ring *ring, uint32_t handle,
 			      struct dma_fence **fence)
 {
 	struct amdgpu_device *adev = ring->adev;
-	struct amdgpu_bo *bo = NULL;
+	struct amdgpu_sa_bo *bo = NULL;
 	uint32_t *msg;
 	int r, i;
 
-	r = amdgpu_bo_create_reserved(adev, 1024, PAGE_SIZE,
-				      AMDGPU_GEM_DOMAIN_VRAM,
-				      &bo, NULL, (void **)&msg);
+	r = amdgpu_sa_bo_new(&adev->ib_pools[AMDGPU_IB_POOL_DIRECT],
+			     &bo, 1024, PAGE_SIZE);
+
 	if (r)
 		return r;
 
+	msg = amdgpu_sa_bo_cpu_addr(bo);
 	/* stitch together an UVD create msg */
 	msg[0] = cpu_to_le32(0x00000de4);
 	msg[1] = cpu_to_le32(0x00000000);
@@ -1197,16 +1168,17 @@ int amdgpu_uvd_get_destroy_msg(struct amdgpu_ring *ring, uint32_t handle,
 			       bool direct, struct dma_fence **fence)
 {
 	struct amdgpu_device *adev = ring->adev;
-	struct amdgpu_bo *bo = NULL;
+	struct amdgpu_sa_bo *bo = NULL;
 	uint32_t *msg;
 	int r, i;
 
-	r = amdgpu_bo_create_reserved(adev, 1024, PAGE_SIZE,
-				      AMDGPU_GEM_DOMAIN_VRAM,
-				      &bo, NULL, (void **)&msg);
+	r = amdgpu_sa_bo_new(&adev->ib_pools[AMDGPU_IB_POOL_DIRECT],
+			     &bo, 1024, PAGE_SIZE);
+
 	if (r)
 		return r;
 
+	msg = amdgpu_sa_bo_cpu_addr(bo);
 	/* stitch together an UVD destroy msg */
 	msg[0] = cpu_to_le32(0x00000de4);
 	msg[1] = cpu_to_le32(0x00000002);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c
index 0d5284b936e4..bce29d6975d3 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c
@@ -81,7 +81,7 @@ MODULE_FIRMWARE(FIRMWARE_VEGA20);
 
 static void amdgpu_vce_idle_work_handler(struct work_struct *work);
 static int amdgpu_vce_get_create_msg(struct amdgpu_ring *ring, uint32_t handle,
-				     struct amdgpu_bo *bo,
+				     struct amdgpu_sa_bo *bo,
 				     struct dma_fence **fence);
 static int amdgpu_vce_get_destroy_msg(struct amdgpu_ring *ring, uint32_t handle,
 				      bool direct, struct dma_fence **fence);
@@ -437,7 +437,7 @@ void amdgpu_vce_free_handles(struct amdgpu_device *adev, struct drm_file *filp)
  * Open up a stream for HW test
  */
 static int amdgpu_vce_get_create_msg(struct amdgpu_ring *ring, uint32_t handle,
-				     struct amdgpu_bo *bo,
+				     struct amdgpu_sa_bo *bo,
 				     struct dma_fence **fence)
 {
 	const unsigned ib_size_dw = 1024;
@@ -454,7 +454,7 @@ static int amdgpu_vce_get_create_msg(struct amdgpu_ring *ring, uint32_t handle,
 
 	ib = &job->ibs[0];
 
-	addr = amdgpu_bo_gpu_offset(bo);
+	addr = amdgpu_sa_bo_gpu_addr(bo);
 
 	/* stitch together an VCE create msg */
 	ib->length_dw = 0;
@@ -1130,16 +1130,16 @@ int amdgpu_vce_ring_test_ring(struct amdgpu_ring *ring)
 int amdgpu_vce_ring_test_ib(struct amdgpu_ring *ring, long timeout)
 {
 	struct dma_fence *fence = NULL;
-	struct amdgpu_bo *bo = NULL;
+	struct amdgpu_sa_bo *bo = NULL;
+	struct amdgpu_device *adev = ring->adev;
 	long r;
 
 	/* skip vce ring1/2 ib test for now, since it's not reliable */
 	if (ring != &ring->adev->vce.ring[0])
 		return 0;
 
-	r = amdgpu_bo_create_reserved(ring->adev, 512, PAGE_SIZE,
-				      AMDGPU_GEM_DOMAIN_VRAM,
-				      &bo, NULL, NULL);
+	r = amdgpu_sa_bo_new(&adev->ib_pools[AMDGPU_IB_POOL_DIRECT],
+			     &bo, 512, PAGE_SIZE);
 	if (r)
 		return r;
 
@@ -1158,8 +1158,7 @@ int amdgpu_vce_ring_test_ib(struct amdgpu_ring *ring, long timeout)
 		r = 0;
 
 error:
+	amdgpu_sa_bo_free(adev, &bo, fence);
 	dma_fence_put(fence);
-	amdgpu_bo_unreserve(bo);
-	amdgpu_bo_unref(&bo);
 	return r;
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
index 4a77c7424dfc..ae4a80724ce2 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
@@ -488,7 +488,7 @@ int amdgpu_vcn_dec_sw_ring_test_ring(struct amdgpu_ring *ring)
 }
 
 static int amdgpu_vcn_dec_send_msg(struct amdgpu_ring *ring,
-				   struct amdgpu_bo *bo,
+				   struct amdgpu_sa_bo *bo,
 				   struct dma_fence **fence)
 {
 	struct amdgpu_device *adev = ring->adev;
@@ -504,7 +504,8 @@ static int amdgpu_vcn_dec_send_msg(struct amdgpu_ring *ring,
 		goto err;
 
 	ib = &job->ibs[0];
-	addr = amdgpu_bo_gpu_offset(bo);
+	addr = amdgpu_sa_bo_gpu_addr(bo);
+
 	ib->ptr[0] = PACKET0(adev->vcn.internal.data0, 0);
 	ib->ptr[1] = addr;
 	ib->ptr[2] = PACKET0(adev->vcn.internal.data1, 0);
@@ -521,9 +522,7 @@ static int amdgpu_vcn_dec_send_msg(struct amdgpu_ring *ring,
 	if (r)
 		goto err_free;
 
-	amdgpu_bo_fence(bo, f, false);
-	amdgpu_bo_unreserve(bo);
-	amdgpu_bo_unref(&bo);
+	amdgpu_sa_bo_free(adev, &bo, f);
 
 	if (fence)
 		*fence = dma_fence_get(f);
@@ -535,25 +534,27 @@ static int amdgpu_vcn_dec_send_msg(struct amdgpu_ring *ring,
 	amdgpu_job_free(job);
 
 err:
-	amdgpu_bo_unreserve(bo);
-	amdgpu_bo_unref(&bo);
+	amdgpu_sa_bo_free(adev, &bo, f);
 	return r;
 }
 
 static int amdgpu_vcn_dec_get_create_msg(struct amdgpu_ring *ring, uint32_t handle,
-					 struct amdgpu_bo **bo)
+					 struct amdgpu_sa_bo **bo)
 {
 	struct amdgpu_device *adev = ring->adev;
 	uint32_t *msg;
 	int r, i;
 
 	*bo = NULL;
-	r = amdgpu_bo_create_reserved(adev, 1024, PAGE_SIZE,
-				      AMDGPU_GEM_DOMAIN_VRAM,
-				      bo, NULL, (void **)&msg);
+
+	r = amdgpu_sa_bo_new(&adev->ib_pools[AMDGPU_IB_POOL_DIRECT],
+			     bo, 1024, PAGE_SIZE);
+
 	if (r)
 		return r;
 
+	msg = amdgpu_sa_bo_cpu_addr(*bo);
+
 	msg[0] = cpu_to_le32(0x00000028);
 	msg[1] = cpu_to_le32(0x00000038);
 	msg[2] = cpu_to_le32(0x00000001);
@@ -575,18 +576,19 @@ static int amdgpu_vcn_dec_get_create_msg(struct amdgpu_ring *ring, uint32_t hand
 }
 
 static int amdgpu_vcn_dec_get_destroy_msg(struct amdgpu_ring *ring, uint32_t handle,
-					  struct amdgpu_bo **bo)
+					  struct amdgpu_sa_bo **bo)
 {
 	struct amdgpu_device *adev = ring->adev;
 	uint32_t *msg;
 	int r, i;
 
 	*bo = NULL;
-	r = amdgpu_bo_create_reserved(adev, 1024, PAGE_SIZE,
-				      AMDGPU_GEM_DOMAIN_VRAM,
-				      bo, NULL, (void **)&msg);
+	r = amdgpu_sa_bo_new(&adev->ib_pools[AMDGPU_IB_POOL_DIRECT],
+			     bo, 1024, PAGE_SIZE);
+
 	if (r)
 		return r;
+	msg = amdgpu_sa_bo_cpu_addr(*bo);
 
 	msg[0] = cpu_to_le32(0x00000028);
 	msg[1] = cpu_to_le32(0x00000018);
@@ -603,7 +605,7 @@ static int amdgpu_vcn_dec_get_destroy_msg(struct amdgpu_ring *ring, uint32_t han
 int amdgpu_vcn_dec_ring_test_ib(struct amdgpu_ring *ring, long timeout)
 {
 	struct dma_fence *fence = NULL;
-	struct amdgpu_bo *bo;
+	struct amdgpu_sa_bo *bo;
 	long r;
 
 	r = amdgpu_vcn_dec_get_create_msg(ring, 1, &bo);
@@ -633,7 +635,7 @@ int amdgpu_vcn_dec_ring_test_ib(struct amdgpu_ring *ring, long timeout)
 }
 
 static int amdgpu_vcn_dec_sw_send_msg(struct amdgpu_ring *ring,
-				   struct amdgpu_bo *bo,
+				   struct amdgpu_sa_bo *bo,
 				   struct dma_fence **fence)
 {
 	struct amdgpu_vcn_decode_buffer *decode_buffer = NULL;
@@ -651,7 +653,7 @@ static int amdgpu_vcn_dec_sw_send_msg(struct amdgpu_ring *ring,
 		goto err;
 
 	ib = &job->ibs[0];
-	addr = amdgpu_bo_gpu_offset(bo);
+	addr = amdgpu_sa_bo_gpu_addr(bo);
 	ib->length_dw = 0;
 
 	ib->ptr[ib->length_dw++] = sizeof(struct amdgpu_vcn_decode_buffer) + 8;
@@ -671,9 +673,7 @@ static int amdgpu_vcn_dec_sw_send_msg(struct amdgpu_ring *ring,
 	if (r)
 		goto err_free;
 
-	amdgpu_bo_fence(bo, f, false);
-	amdgpu_bo_unreserve(bo);
-	amdgpu_bo_unref(&bo);
+	amdgpu_sa_bo_free(adev, &bo, f);
 
 	if (fence)
 		*fence = dma_fence_get(f);
@@ -685,15 +685,14 @@ static int amdgpu_vcn_dec_sw_send_msg(struct amdgpu_ring *ring,
 	amdgpu_job_free(job);
 
 err:
-	amdgpu_bo_unreserve(bo);
-	amdgpu_bo_unref(&bo);
+	amdgpu_sa_bo_free(adev, &bo, f);
 	return r;
 }
 
 int amdgpu_vcn_dec_sw_ring_test_ib(struct amdgpu_ring *ring, long timeout)
 {
 	struct dma_fence *fence = NULL;
-	struct amdgpu_bo *bo;
+	struct amdgpu_sa_bo *bo;
 	long r;
 
 	r = amdgpu_vcn_dec_get_create_msg(ring, 1, &bo);
-- 
2.29.2

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
