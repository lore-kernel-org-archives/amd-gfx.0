Return-Path: <SRS0=y1ja=OA=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1DE1C433EF
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Sep 2021 12:30:15 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 68DBD611C8
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Sep 2021 12:30:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 68DBD611C8
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 11D536E9E8;
	Fri, 10 Sep 2021 12:30:15 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1anam02on2054.outbound.protection.outlook.com [40.107.96.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B57F26E9E8
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Sep 2021 12:30:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=miAE0v6Fy3NX/zZIZ8lXMVJUMEh1x9TqUlRr7OXiGjvZFjnUEWa5nW/NlQM0YbuC3+oqE1ASJ8doSTFX1rNvh2nWJKih6fUB+H3RujiBI9zk+nqDfs8Z5ubinwsCmA4SFC7pjGJ+oqZwps1JmEMLU+qaf0P/22yr7JQQhP1Dx6+jRo+qlDNbn1ZmYBOfyPPmnHtAHhYZGlub5H4LVSVGU3V9UiO2l+lBVo8YEiW9SEeWkjRL82B11CCmGw9Rqc/KoPVtDj0yuxaLQIkJ7yFSS3s2hFWy2vzkUrJ9Z9IjAhajSSahr55RTo4siqxlLYPcfwL/vej7TOOkB54Ycqtsbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=0NuQN124+qkvBad1iOlZDV7VlykHsz//6KXZg4MRiqM=;
 b=KM3I5e+aRWZNORzIBlc/zcW5cvrYujMxyrkCQqSDEavTgkmDTB5h5W3cS5Af6FOX7j6/CY/ZkZsk4EnrtmoxQLC/TVqZtwYPMG2U+R2AYOXYt2cTtKW97r3pbm2EvdnOhoB1hqnUVJPzapZLHKKSZm/SSaUCa6LCslwNkGIGjc4p+n4KpQEBmWW/iMRoRLc1jhpRhCfiR3q0JkLwWkzb5TSEfKHkwXppnfAvYqL1XzriTSfHv9HtlS6P8MKWBXCb5+KPjZs/kXp4+wRy98pE6zYWORYNt+9N426yMQ4rJQ/q6q77Lz7YHym0VM6RwQuBWRULHUtqpcXV1iKUnE6ZmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0NuQN124+qkvBad1iOlZDV7VlykHsz//6KXZg4MRiqM=;
 b=wvPO/yvhgO/JqMMdDycj6GUTHftSIl6b087iwTMauIEQmspN51iiT2pUzEapIA8jriGATC/tKrV5wK7OXz8PE7kyVq2GeIe9++LgX9frH7adcRbq9TueN92U3Pi6HO9WcPQ2EgVNTA1EmvydJqkBcPVcG1rrIuzwsRips5Ppe2U=
Received: from DM5PR06CA0027.namprd06.prod.outlook.com (2603:10b6:3:5d::13) by
 DM6PR12MB2651.namprd12.prod.outlook.com (2603:10b6:5:42::25) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4500.16; Fri, 10 Sep 2021 12:30:12 +0000
Received: from DM6NAM11FT060.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:5d:cafe::fa) by DM5PR06CA0027.outlook.office365.com
 (2603:10b6:3:5d::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.15 via Frontend
 Transport; Fri, 10 Sep 2021 12:30:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT060.mail.protection.outlook.com (10.13.173.63) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4500.14 via Frontend Transport; Fri, 10 Sep 2021 12:30:12 +0000
Received: from pp-server-two.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Fri, 10 Sep
 2021 07:30:09 -0500
From: xinhui pan <xinhui.pan@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <alexander.deucher@amd.com>, <christian.koenig@amd.com>, xinhui pan
 <xinhui.pan@amd.com>
Subject: [PATCH v2 3/3] drm/amdgpu: VCN avoid memory allocation during IB test
Date: Fri, 10 Sep 2021 20:29:40 +0800
Message-ID: <20210910122940.15699-3-xinhui.pan@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210910122940.15699-1-xinhui.pan@amd.com>
References: <20210910122940.15699-1-xinhui.pan@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 422e2b01-874c-4a06-3627-08d97456bc21
X-MS-TrafficTypeDiagnostic: DM6PR12MB2651:
X-Microsoft-Antispam-PRVS: <DM6PR12MB2651DA7E68724F19817EBCC287D69@DM6PR12MB2651.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:181;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: q4m52oveBbnFekK976Tx0i5pW3RceE6WbtPT+iqHX7VFuSe5Ho46V2DGeoKrq+hrnuMiG2nJ7wNQVj4lS0fHrtNuP62RshKupT19nnK7r2spvrzvg6FVhZ1JNzHZ/rzsbaVUojNmn0VsSfb0GQI7+r1JMLYD9IgKh+C6lrY6uuWqiPvkxOhakCk7OVOUKBKdMcN+wTxx3URdV20thiCWCdHb5yx9zDcLTJsIGbqjxzmjc3hgPLfh9pMkDVAe3wNnOSJzfI5+M3rKKvwSck+dsFi/EOcQomb6QoYeZTzXll1fRAkCFBCh6y03+A9IHNlY1Z3B3cDKCJsad6kaeA/q/k2ETOcnacFNpXnB6s6EprEGGucXSc4KS6FzWo6HcMZDSuaRfdsoVMbFPqprKkMuI8SKI72niumXMAKDrz6bOx4CH6h6pdzZjQ6wJpJE+/AbRphVbVgXG9FkH0J/mlvr07127XLHid6KvaU3clEhF0Q2V/xO6+Y69nXwFXReusUhzrsTY8LwBXigVacRYoPmowzRAEdg7DzRVNGlUN68IVL6iT3hzE2w6f1PD1DKZAb9eSaxdtRw86pLf54W087dVCspCeYwDOJCsFG5oydURU/X1YacyD8tmaflky36cd1k1OUrInHhJxvPUTud6+I+8n0Br/ogVUPCR+vvO+DAumTU1SeWKeQu+3rgd4LqS0SW0Cpqa0ePHy1/bAhkveqMWBmY9q5tqAADp274rETWFE0=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(376002)(396003)(39860400002)(136003)(346002)(46966006)(36840700001)(70206006)(6666004)(1076003)(2616005)(478600001)(16526019)(4326008)(83380400001)(426003)(82740400003)(336012)(36860700001)(86362001)(82310400003)(36756003)(2906002)(356005)(8936002)(81166007)(8676002)(6916009)(70586007)(5660300002)(7696005)(47076005)(186003)(54906003)(26005)(316002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2021 12:30:12.1009 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 422e2b01-874c-4a06-3627-08d97456bc21
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT060.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2651
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

