Return-Path: <SRS0=1siV=OB=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF8A7C433FE
	for <amd-gfx@archiver.kernel.org>; Sat, 11 Sep 2021 01:34:46 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A74686120A
	for <amd-gfx@archiver.kernel.org>; Sat, 11 Sep 2021 01:34:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org A74686120A
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D6C216EB23;
	Sat, 11 Sep 2021 01:34:43 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2055.outbound.protection.outlook.com [40.107.244.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3D9C16EB23
 for <amd-gfx@lists.freedesktop.org>; Sat, 11 Sep 2021 01:34:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JpQlUdN0njrsVnxbhnEmFR4sNvKfNa2Ba4fMSbBDpIJtvOen8zNwp1ll/FD2KfYR/FFb10rAYbAzapXif6XoIyLrrt1aXQ1Fmnelcjx6UDAmyKSbkTtMZ49KdjlAueODbmgvB5li4jS1zDKeANsjWLGnmHfKIjJmXdQbQnIZvbNAgKZyLKBKo95O+QR4m19KhxLD5rYzu53cUsEPe7GKPQmUbVeJqlllY1wE4yRoD4Ixx2CwDHSopkKHccWNi3eJMBsJaKNp/FPQGbhgqgWuchlHtPSmkl/l1vjQUgs9CMZb3w553Ehtm5jWERL1FJjPKmZcnB+CweXeGPhtanly1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=0NuQN124+qkvBad1iOlZDV7VlykHsz//6KXZg4MRiqM=;
 b=goP5yG4HRQAJsfMr+5lW7wVOCC4EWGp8qthZkBQApPC/PUo9pAr3yR5Z1rJ8S417gjh4qwR2oWpQIKl1xkAcOKT373m6hBo7+ydiK8NgHDowoBtMFcmJIVwgCHCqyWvvHkfQBoChOC+ck8zm2IDBj5oMcxihBpBEDI5EPFovjq/fDJrP/d3tcxxO1Y5UzfyTClJrQFVFhdJzMLBnIo4oDNmJCoM2p/kMlLY+MNjSLp23BmHuu5R0CK9Srh2B5Dtlehf5ig2osNBq/85Vle0BIeWGnOGAJCkIhUGmsIA79+F+jPeijYgDKN1tldkY1VmOf+zxvN6NDjLdFErSOVlcWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0NuQN124+qkvBad1iOlZDV7VlykHsz//6KXZg4MRiqM=;
 b=izKNy31VXewl6mRqLuc80CWyCJGI73TkBM/VcMtal3L65DcxMStnkXTnO0ljnJfPwvJ2tkGqZ0tI/rDUfS6okhKJA1XC0BREZxIQ3bLOPlMMQ+V3hPO/1wRVy2WNjyGVBTg5cv5WIYsPowoZdnxtwtOHftDgKBoCDa4yaUfiJcQ=
Received: from MW4PR04CA0349.namprd04.prod.outlook.com (2603:10b6:303:8a::24)
 by BN7PR12MB2593.namprd12.prod.outlook.com (2603:10b6:408:25::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.17; Sat, 11 Sep
 2021 01:34:40 +0000
Received: from CO1NAM11FT049.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8a:cafe::a0) by MW4PR04CA0349.outlook.office365.com
 (2603:10b6:303:8a::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.14 via Frontend
 Transport; Sat, 11 Sep 2021 01:34:40 +0000
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
 15.20.4500.14 via Frontend Transport; Sat, 11 Sep 2021 01:34:39 +0000
Received: from pp-server-two.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Fri, 10 Sep
 2021 20:34:37 -0500
From: xinhui pan <xinhui.pan@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <alexander.deucher@amd.com>, <christian.koenig@amd.com>, xinhui pan
 <xinhui.pan@amd.com>
Subject: [PATCH v3 3/3] drm/amdgpu: VCN avoid memory allocation during IB test
Date: Sat, 11 Sep 2021 09:34:21 +0800
Message-ID: <20210911013421.5213-3-xinhui.pan@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210911013421.5213-1-xinhui.pan@amd.com>
References: <20210911013421.5213-1-xinhui.pan@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2f54f21c-ee98-4a25-f690-08d974c452b5
X-MS-TrafficTypeDiagnostic: BN7PR12MB2593:
X-Microsoft-Antispam-PRVS: <BN7PR12MB25931EEB624F59A5C9D89A3287D79@BN7PR12MB2593.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:181;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XhJOq69k/hCMmSqQt9AzopT0tFNHAlz1AhpNn2C97fp+yjIBY+Kb1P6vzSuUHcHxsOWTn2muzjLux97DvuomkGVn5omOLEAvmaQKj8LuwmBiONUfOOf82NnCseWLG/Lzb77WuuxBtVfDzXYPYpxxUxZ6i5lUFCe6Bf6+M+7izRfDH9yVoXEbt3Ph/q2pS6c4wKjbSaTC+aSV9hOq/mAxxiMXkaFSJgW3yRCVOfU9I8oDQskCbfGnOhRCPnUZLeWI67rr6cmlCyKcRvX8tXaeDqepLfawDV6RRszbIHfQ0UGPpBCg99LS87u2rnYZ0ftEZWs+JUk60j8tkN2NyGbry2ZCCV6aiyCDds0TW6A+vpOOeqMvh7mLIoFoGxebBCvt+1MHuy5fYkiUT/xRJ1GszYSzKJFOpoSGRDV/2X+Xrxk75uut+22axXXeW1YJExXDk1bdQTzHuOWvW9pThlA8Sfuklay39L1hHF11fY1iCKKEz9OpjqzQu87EuvQtKyNwC9oV9Vy3SeGy7bQrwG9u2oR3NehQ6mrISZIimN7XKwBjRgbZn1Wk33DSHMY6FDVCvpaGXJy6LSqoVuLOrO87p1kP35UcVUeJG/zK5qr/19xjwbejF0eGZGtGe61Wkt7e5oY4g67ns+4unLjhJsKdtDkY/6xHgv7y8YNO/CBG+b8eGacncl7jAt6ABnRTxATXUKFpZCofzQ6GcjW7Ui4M0z3HPTSqQDSrJvB6loeYfhQ=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(396003)(346002)(136003)(39860400002)(376002)(46966006)(36840700001)(2616005)(4326008)(36860700001)(47076005)(70586007)(16526019)(356005)(186003)(426003)(478600001)(26005)(8936002)(336012)(8676002)(82740400003)(5660300002)(7696005)(2906002)(83380400001)(316002)(6916009)(70206006)(81166007)(1076003)(36756003)(6666004)(54906003)(82310400003)(86362001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2021 01:34:39.7955 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f54f21c-ee98-4a25-f690-08d974c452b5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT049.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR12MB2593
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

Reviewed-by: Christian König <christian.koenig@amd.com>
Signed-off-by: xinhui pan <xinhui.pan@amd.com>
---
change from v1:
let addr align up to gpu page boundary.
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c | 97 +++++++++++--------------
 1 file changed, 44 insertions(+), 53 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
index 561296a85b43..b60b8fe5bf67 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
@@ -541,15 +541,14 @@ int amdgpu_vcn_dec_sw_ring_test_ring(struct amdgpu_ring *ring)
 }
 
 static int amdgpu_vcn_dec_send_msg(struct amdgpu_ring *ring,
-				   struct amdgpu_bo *bo,
+				   struct amdgpu_ib *ib_msg,
 				   struct dma_fence **fence)
 {
 	struct amdgpu_device *adev = ring->adev;
 	struct dma_fence *f = NULL;
 	struct amdgpu_job *job;
 	struct amdgpu_ib *ib;
-	uint64_t addr;
-	void *msg = NULL;
+	uint64_t addr = AMDGPU_GPU_PAGE_ALIGN(ib_msg->gpu_addr);
 	int i, r;
 
 	r = amdgpu_job_alloc_with_ib(adev, 64,
@@ -558,8 +557,6 @@ static int amdgpu_vcn_dec_send_msg(struct amdgpu_ring *ring,
 		goto err;
 
 	ib = &job->ibs[0];
-	addr = amdgpu_bo_gpu_offset(bo);
-	msg = amdgpu_bo_kptr(bo);
 	ib->ptr[0] = PACKET0(adev->vcn.internal.data0, 0);
 	ib->ptr[1] = addr;
 	ib->ptr[2] = PACKET0(adev->vcn.internal.data1, 0);
@@ -576,9 +573,7 @@ static int amdgpu_vcn_dec_send_msg(struct amdgpu_ring *ring,
 	if (r)
 		goto err_free;
 
-	amdgpu_bo_fence(bo, f, false);
-	amdgpu_bo_unreserve(bo);
-	amdgpu_bo_free_kernel(&bo, NULL, (void **)&msg);
+	amdgpu_ib_free(adev, ib_msg, f);
 
 	if (fence)
 		*fence = dma_fence_get(f);
@@ -588,27 +583,26 @@ static int amdgpu_vcn_dec_send_msg(struct amdgpu_ring *ring,
 
 err_free:
 	amdgpu_job_free(job);
-
 err:
-	amdgpu_bo_unreserve(bo);
-	amdgpu_bo_free_kernel(&bo, NULL, (void **)&msg);
+	amdgpu_ib_free(adev, ib_msg, f);
 	return r;
 }
 
 static int amdgpu_vcn_dec_get_create_msg(struct amdgpu_ring *ring, uint32_t handle,
-					 struct amdgpu_bo **bo)
+		struct amdgpu_ib *ib)
 {
 	struct amdgpu_device *adev = ring->adev;
 	uint32_t *msg;
 	int r, i;
 
-	*bo = NULL;
-	r = amdgpu_bo_create_reserved(adev, 1024, PAGE_SIZE,
-				      AMDGPU_GEM_DOMAIN_VRAM,
-				      bo, NULL, (void **)&msg);
+	memset(ib, 0, sizeof(*ib));
+	r = amdgpu_ib_get(adev, NULL, AMDGPU_GPU_PAGE_SIZE * 2,
+			AMDGPU_IB_POOL_DIRECT,
+			ib);
 	if (r)
 		return r;
 
+	msg = (uint32_t *)AMDGPU_GPU_PAGE_ALIGN((unsigned long)ib->ptr);
 	msg[0] = cpu_to_le32(0x00000028);
 	msg[1] = cpu_to_le32(0x00000038);
 	msg[2] = cpu_to_le32(0x00000001);
@@ -630,19 +624,20 @@ static int amdgpu_vcn_dec_get_create_msg(struct amdgpu_ring *ring, uint32_t hand
 }
 
 static int amdgpu_vcn_dec_get_destroy_msg(struct amdgpu_ring *ring, uint32_t handle,
-					  struct amdgpu_bo **bo)
+					  struct amdgpu_ib *ib)
 {
 	struct amdgpu_device *adev = ring->adev;
 	uint32_t *msg;
 	int r, i;
 
-	*bo = NULL;
-	r = amdgpu_bo_create_reserved(adev, 1024, PAGE_SIZE,
-				      AMDGPU_GEM_DOMAIN_VRAM,
-				      bo, NULL, (void **)&msg);
+	memset(ib, 0, sizeof(*ib));
+	r = amdgpu_ib_get(adev, NULL, AMDGPU_GPU_PAGE_SIZE * 2,
+			AMDGPU_IB_POOL_DIRECT,
+			ib);
 	if (r)
 		return r;
 
+	msg = (uint32_t *)AMDGPU_GPU_PAGE_ALIGN((unsigned long)ib->ptr);
 	msg[0] = cpu_to_le32(0x00000028);
 	msg[1] = cpu_to_le32(0x00000018);
 	msg[2] = cpu_to_le32(0x00000000);
@@ -658,21 +653,21 @@ static int amdgpu_vcn_dec_get_destroy_msg(struct amdgpu_ring *ring, uint32_t han
 int amdgpu_vcn_dec_ring_test_ib(struct amdgpu_ring *ring, long timeout)
 {
 	struct dma_fence *fence = NULL;
-	struct amdgpu_bo *bo;
+	struct amdgpu_ib ib;
 	long r;
 
-	r = amdgpu_vcn_dec_get_create_msg(ring, 1, &bo);
+	r = amdgpu_vcn_dec_get_create_msg(ring, 1, &ib);
 	if (r)
 		goto error;
 
-	r = amdgpu_vcn_dec_send_msg(ring, bo, NULL);
+	r = amdgpu_vcn_dec_send_msg(ring, &ib, NULL);
 	if (r)
 		goto error;
-	r = amdgpu_vcn_dec_get_destroy_msg(ring, 1, &bo);
+	r = amdgpu_vcn_dec_get_destroy_msg(ring, 1, &ib);
 	if (r)
 		goto error;
 
-	r = amdgpu_vcn_dec_send_msg(ring, bo, &fence);
+	r = amdgpu_vcn_dec_send_msg(ring, &ib, &fence);
 	if (r)
 		goto error;
 
@@ -688,8 +683,8 @@ int amdgpu_vcn_dec_ring_test_ib(struct amdgpu_ring *ring, long timeout)
 }
 
 static int amdgpu_vcn_dec_sw_send_msg(struct amdgpu_ring *ring,
-				   struct amdgpu_bo *bo,
-				   struct dma_fence **fence)
+				      struct amdgpu_ib *ib_msg,
+				      struct dma_fence **fence)
 {
 	struct amdgpu_vcn_decode_buffer *decode_buffer = NULL;
 	const unsigned int ib_size_dw = 64;
@@ -697,7 +692,7 @@ static int amdgpu_vcn_dec_sw_send_msg(struct amdgpu_ring *ring,
 	struct dma_fence *f = NULL;
 	struct amdgpu_job *job;
 	struct amdgpu_ib *ib;
-	uint64_t addr;
+	uint64_t addr = AMDGPU_GPU_PAGE_ALIGN(ib_msg->gpu_addr);
 	int i, r;
 
 	r = amdgpu_job_alloc_with_ib(adev, ib_size_dw * 4,
@@ -706,7 +701,6 @@ static int amdgpu_vcn_dec_sw_send_msg(struct amdgpu_ring *ring,
 		goto err;
 
 	ib = &job->ibs[0];
-	addr = amdgpu_bo_gpu_offset(bo);
 	ib->length_dw = 0;
 
 	ib->ptr[ib->length_dw++] = sizeof(struct amdgpu_vcn_decode_buffer) + 8;
@@ -726,9 +720,7 @@ static int amdgpu_vcn_dec_sw_send_msg(struct amdgpu_ring *ring,
 	if (r)
 		goto err_free;
 
-	amdgpu_bo_fence(bo, f, false);
-	amdgpu_bo_unreserve(bo);
-	amdgpu_bo_unref(&bo);
+	amdgpu_ib_free(adev, ib_msg, f);
 
 	if (fence)
 		*fence = dma_fence_get(f);
@@ -738,31 +730,29 @@ static int amdgpu_vcn_dec_sw_send_msg(struct amdgpu_ring *ring,
 
 err_free:
 	amdgpu_job_free(job);
-
 err:
-	amdgpu_bo_unreserve(bo);
-	amdgpu_bo_unref(&bo);
+	amdgpu_ib_free(adev, ib_msg, f);
 	return r;
 }
 
 int amdgpu_vcn_dec_sw_ring_test_ib(struct amdgpu_ring *ring, long timeout)
 {
 	struct dma_fence *fence = NULL;
-	struct amdgpu_bo *bo;
+	struct amdgpu_ib ib;
 	long r;
 
-	r = amdgpu_vcn_dec_get_create_msg(ring, 1, &bo);
+	r = amdgpu_vcn_dec_get_create_msg(ring, 1, &ib);
 	if (r)
 		goto error;
 
-	r = amdgpu_vcn_dec_sw_send_msg(ring, bo, NULL);
+	r = amdgpu_vcn_dec_sw_send_msg(ring, &ib, NULL);
 	if (r)
 		goto error;
-	r = amdgpu_vcn_dec_get_destroy_msg(ring, 1, &bo);
+	r = amdgpu_vcn_dec_get_destroy_msg(ring, 1, &ib);
 	if (r)
 		goto error;
 
-	r = amdgpu_vcn_dec_sw_send_msg(ring, bo, &fence);
+	r = amdgpu_vcn_dec_sw_send_msg(ring, &ib, &fence);
 	if (r)
 		goto error;
 
@@ -809,7 +799,7 @@ int amdgpu_vcn_enc_ring_test_ring(struct amdgpu_ring *ring)
 }
 
 static int amdgpu_vcn_enc_get_create_msg(struct amdgpu_ring *ring, uint32_t handle,
-					 struct amdgpu_bo *bo,
+					 struct amdgpu_ib *ib_msg,
 					 struct dma_fence **fence)
 {
 	const unsigned ib_size_dw = 16;
@@ -825,7 +815,7 @@ static int amdgpu_vcn_enc_get_create_msg(struct amdgpu_ring *ring, uint32_t hand
 		return r;
 
 	ib = &job->ibs[0];
-	addr = amdgpu_bo_gpu_offset(bo);
+	addr = AMDGPU_GPU_PAGE_ALIGN(ib_msg->gpu_addr);
 
 	ib->length_dw = 0;
 	ib->ptr[ib->length_dw++] = 0x00000018;
@@ -863,7 +853,7 @@ static int amdgpu_vcn_enc_get_create_msg(struct amdgpu_ring *ring, uint32_t hand
 }
 
 static int amdgpu_vcn_enc_get_destroy_msg(struct amdgpu_ring *ring, uint32_t handle,
-					  struct amdgpu_bo *bo,
+					  struct amdgpu_ib *ib_msg,
 					  struct dma_fence **fence)
 {
 	const unsigned ib_size_dw = 16;
@@ -879,7 +869,7 @@ static int amdgpu_vcn_enc_get_destroy_msg(struct amdgpu_ring *ring, uint32_t han
 		return r;
 
 	ib = &job->ibs[0];
-	addr = amdgpu_bo_gpu_offset(bo);
+	addr = AMDGPU_GPU_PAGE_ALIGN(ib_msg->gpu_addr);
 
 	ib->length_dw = 0;
 	ib->ptr[ib->length_dw++] = 0x00000018;
@@ -918,21 +908,23 @@ static int amdgpu_vcn_enc_get_destroy_msg(struct amdgpu_ring *ring, uint32_t han
 
 int amdgpu_vcn_enc_ring_test_ib(struct amdgpu_ring *ring, long timeout)
 {
+	struct amdgpu_device *adev = ring->adev;
 	struct dma_fence *fence = NULL;
-	struct amdgpu_bo *bo = NULL;
+	struct amdgpu_ib ib;
 	long r;
 
-	r = amdgpu_bo_create_reserved(ring->adev, 128 * 1024, PAGE_SIZE,
-				      AMDGPU_GEM_DOMAIN_VRAM,
-				      &bo, NULL, NULL);
+	memset(&ib, 0, sizeof(ib));
+	r = amdgpu_ib_get(adev, NULL, (128 << 10) + AMDGPU_GPU_PAGE_SIZE,
+			AMDGPU_IB_POOL_DIRECT,
+			&ib);
 	if (r)
 		return r;
 
-	r = amdgpu_vcn_enc_get_create_msg(ring, 1, bo, NULL);
+	r = amdgpu_vcn_enc_get_create_msg(ring, 1, &ib, NULL);
 	if (r)
 		goto error;
 
-	r = amdgpu_vcn_enc_get_destroy_msg(ring, 1, bo, &fence);
+	r = amdgpu_vcn_enc_get_destroy_msg(ring, 1, &ib, &fence);
 	if (r)
 		goto error;
 
@@ -943,9 +935,8 @@ int amdgpu_vcn_enc_ring_test_ib(struct amdgpu_ring *ring, long timeout)
 		r = 0;
 
 error:
+	amdgpu_ib_free(adev, &ib, fence);
 	dma_fence_put(fence);
-	amdgpu_bo_unreserve(bo);
-	amdgpu_bo_free_kernel(&bo, NULL, NULL);
 
 	return r;
 }
-- 
2.25.1

