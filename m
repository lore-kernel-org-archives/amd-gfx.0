Return-Path: <SRS0=1siV=OB=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E559C433F5
	for <amd-gfx@archiver.kernel.org>; Sat, 11 Sep 2021 01:34:45 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1B9106113E
	for <amd-gfx@archiver.kernel.org>; Sat, 11 Sep 2021 01:34:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 1B9106113E
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E47006EB24;
	Sat, 11 Sep 2021 01:34:41 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2051.outbound.protection.outlook.com [40.107.237.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 791496EB24
 for <amd-gfx@lists.freedesktop.org>; Sat, 11 Sep 2021 01:34:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QbyGhggL1U09ZQFvvcZqdaEWBp1RMbDIt9/crz4F3pezPO0n4Omb9+tO9nEmnE5aq4HlJTA/hp8NhkDKUuHdxBjztzSQs/SnPwAjBjlwmu3ENeOIiewAdlszaV+bGaS9Cyy6UUWbvi+N0y+7anKRDcvJgxHWq0uGzxTFC92LbZE0x0YsFQfJvQSZlLN2k++GtD8nRcZFJ2i1jSdzu0oMG4csAIdUiy1TvrxSHJnx8Vs4Pu7IyHXc/8YqZD2pjegmsX0Idq3YjGLj6/4qV34CtgdFXlf9aR0IeQIFR/qS6l3B0OT79vswgmzn1mrVLZ7fWQ4tWbcd3gAJaRYVDsRydQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=SXpbgraCUSl/taytA3VRF2/zVRpWAj5W3zDPn0FKNas=;
 b=EKdSwrWPGbiBGCfm6/SRTPPght27tFVwbkBNdYlIcyDteefLp/zkYIgkmW4a9ZKFfcqQUFrh8papy2lr8VM9fPgjErMpnYN+Rl8YInYS5CygmweMr+Km2TU4BcuElGaSnCtelx7T9ai6+TIbr9CcLvTZJYSKowkGbXbXSC5uXc5zx9FiUw/9GXxaajU4H1mG889D4Lh9dtFunzmBJ48wjzTrf1c5zZcbRpGt3lGbUsw4TjIytb9tNiZvedExBLm/e/9r4javD5CYogrY+aJBJAwYTjYHWfbRPFe5CPe89qbDS7HKAY9xM1/r72KTo9Q/os/gL3pY9XI86DB2Q0FTUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SXpbgraCUSl/taytA3VRF2/zVRpWAj5W3zDPn0FKNas=;
 b=XzHdeClO33ZLOhgV9mP10jyFvlXbn/nV5xLSRj00kz8bNjh6UW2dg9DoDFy42lAOSoTu4xBtoVRByxfAbfNfG8I6UpXtp3NpyW71NvqOL+xnv6HCXiPY379pi1iqMu2N+TAJ+kmpITLFyBb7wVPld7s92DEymJpszdu6vxd28O0=
Received: from MW4PR04CA0356.namprd04.prod.outlook.com (2603:10b6:303:8a::31)
 by BL1PR12MB5173.namprd12.prod.outlook.com (2603:10b6:208:308::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.16; Sat, 11 Sep
 2021 01:34:39 +0000
Received: from CO1NAM11FT049.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8a:cafe::af) by MW4PR04CA0356.outlook.office365.com
 (2603:10b6:303:8a::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.14 via Frontend
 Transport; Sat, 11 Sep 2021 01:34:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT049.mail.protection.outlook.com (10.13.175.50) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4500.14 via Frontend Transport; Sat, 11 Sep 2021 01:34:38 +0000
Received: from pp-server-two.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Fri, 10 Sep
 2021 20:34:35 -0500
From: xinhui pan <xinhui.pan@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <alexander.deucher@amd.com>, <christian.koenig@amd.com>, xinhui pan
 <xinhui.pan@amd.com>
Subject: [PATCH v3 2/3] drm/amdgpu: VCE avoid memory allocation during IB test
Date: Sat, 11 Sep 2021 09:34:20 +0800
Message-ID: <20210911013421.5213-2-xinhui.pan@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210911013421.5213-1-xinhui.pan@amd.com>
References: <20210911013421.5213-1-xinhui.pan@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 063f357d-0376-4930-8b79-08d974c45225
X-MS-TrafficTypeDiagnostic: BL1PR12MB5173:
X-Microsoft-Antispam-PRVS: <BL1PR12MB51736AC32986C9209EC9446F87D79@BL1PR12MB5173.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1091;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fy61wJq2rwXGWqq3Kmz8wsidwwvQPhtukFp9lcl1QTcq+34Dz7KMl5OTNIibLeHwXpqksNuMyIahV2m//S3JNUThC4gglbM2IBoH1W1b+ETyaoDzP6bXRgZhhu6RmkMoFEHAaMu28URLpG9gmRqQQDVytXuixfNqPFwYcfGeIIRjf8gDhOMeqkHiNm+HfYq4uKm2zUK+8jFO34UlrhTJfqcUAua/rO+Dw2zHX+s77CZ69k0x5gtFctvxvR4AnYpugHmuWMMI00H1hEKVMCRj4DRQ5e0XjjzDZ29pPkkxq+vKwhcL6dOo0rUbfzapD0itfKNxFW9pusr+BKi+w8N7f6Ibi6/y7VqTSYXfkEasFd4H5hpRRvOSbEecVeXv7qKcas5pl08kzD56zSgVxKOpahR0Yl0C3YkUDfKtSZ13H5H4eMlpRN2+rR1pdOoyqyunY+SbBXFG1Ah7lHUFrXI+RA5GRWorTMootxM1WrZ/SgLQWfElY8/PfXtKm2fAcKLTp2ZN1HIFcqaqqwZoTrDPg7f5wE+Ah8Rn/TFVSdgjQGVOyUvoFDlgaCN2uG1zwYNFFur2ATswwJsqSteaIGu5xyYvKtnZsXURxna/lNNw1ERWJ/w491BLG745GxJ3dLUy47ZcbyDf4VJ5rCVlqkguIAVD+WFs99RTphUioyCaT1vlABhA9bU+rba15Pm6KeY8wJCJG3MFANnbWAVjSidKWaeavmceXeDOKCmL/kmr+OE=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(39860400002)(376002)(346002)(396003)(136003)(36840700001)(46966006)(7696005)(6666004)(478600001)(36860700001)(1076003)(316002)(5660300002)(4326008)(54906003)(2906002)(47076005)(82740400003)(86362001)(70206006)(356005)(6916009)(426003)(8936002)(82310400003)(26005)(81166007)(186003)(2616005)(336012)(83380400001)(70586007)(16526019)(8676002)(36756003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2021 01:34:38.8471 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 063f357d-0376-4930-8b79-08d974c45225
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT049.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5173
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

alloc extra msg from direct IB pool.

Signed-off-by: xinhui pan <xinhui.pan@amd.com>
---
change from v1:
let addr align up to gpu page boundary.
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c | 27 ++++++++++++-------------
 1 file changed, 13 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c
index e9fdf49d69e8..caa4d3420e00 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c
@@ -82,7 +82,6 @@ MODULE_FIRMWARE(FIRMWARE_VEGA20);
 
 static void amdgpu_vce_idle_work_handler(struct work_struct *work);
 static int amdgpu_vce_get_create_msg(struct amdgpu_ring *ring, uint32_t handle,
-				     struct amdgpu_bo *bo,
 				     struct dma_fence **fence);
 static int amdgpu_vce_get_destroy_msg(struct amdgpu_ring *ring, uint32_t handle,
 				      bool direct, struct dma_fence **fence);
@@ -441,12 +440,12 @@ void amdgpu_vce_free_handles(struct amdgpu_device *adev, struct drm_file *filp)
  * Open up a stream for HW test
  */
 static int amdgpu_vce_get_create_msg(struct amdgpu_ring *ring, uint32_t handle,
-				     struct amdgpu_bo *bo,
 				     struct dma_fence **fence)
 {
 	const unsigned ib_size_dw = 1024;
 	struct amdgpu_job *job;
 	struct amdgpu_ib *ib;
+	struct amdgpu_ib ib_msg;
 	struct dma_fence *f = NULL;
 	uint64_t addr;
 	int i, r;
@@ -456,9 +455,17 @@ static int amdgpu_vce_get_create_msg(struct amdgpu_ring *ring, uint32_t handle,
 	if (r)
 		return r;
 
-	ib = &job->ibs[0];
+	memset(&ib_msg, 0, sizeof(ib_msg));
+	/* only one gpu page is needed, alloc +1 page to make addr aligned. */
+	r = amdgpu_ib_get(ring->adev, NULL, AMDGPU_GPU_PAGE_SIZE * 2,
+			  AMDGPU_IB_POOL_DIRECT,
+			  &ib_msg);
+	if (r)
+		goto err;
 
-	addr = amdgpu_bo_gpu_offset(bo);
+	ib = &job->ibs[0];
+	/* let addr point to page boundary */
+	addr = AMDGPU_GPU_PAGE_ALIGN(ib_msg.gpu_addr);
 
 	/* stitch together an VCE create msg */
 	ib->length_dw = 0;
@@ -498,6 +505,7 @@ static int amdgpu_vce_get_create_msg(struct amdgpu_ring *ring, uint32_t handle,
 		ib->ptr[i] = 0x0;
 
 	r = amdgpu_job_submit_direct(job, ring, &f);
+	amdgpu_ib_free(ring->adev, &ib_msg, f);
 	if (r)
 		goto err;
 
@@ -1134,20 +1142,13 @@ int amdgpu_vce_ring_test_ring(struct amdgpu_ring *ring)
 int amdgpu_vce_ring_test_ib(struct amdgpu_ring *ring, long timeout)
 {
 	struct dma_fence *fence = NULL;
-	struct amdgpu_bo *bo = NULL;
 	long r;
 
 	/* skip vce ring1/2 ib test for now, since it's not reliable */
 	if (ring != &ring->adev->vce.ring[0])
 		return 0;
 
-	r = amdgpu_bo_create_reserved(ring->adev, 512, PAGE_SIZE,
-				      AMDGPU_GEM_DOMAIN_VRAM,
-				      &bo, NULL, NULL);
-	if (r)
-		return r;
-
-	r = amdgpu_vce_get_create_msg(ring, 1, bo, NULL);
+	r = amdgpu_vce_get_create_msg(ring, 1, NULL);
 	if (r)
 		goto error;
 
@@ -1163,8 +1164,6 @@ int amdgpu_vce_ring_test_ib(struct amdgpu_ring *ring, long timeout)
 
 error:
 	dma_fence_put(fence);
-	amdgpu_bo_unreserve(bo);
-	amdgpu_bo_free_kernel(&bo, NULL, NULL);
 	return r;
 }
 
-- 
2.25.1

