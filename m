Return-Path: <SRS0=y1ja=OA=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69CF4C433F5
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Sep 2021 00:38:58 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 357F561074
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Sep 2021 00:38:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 357F561074
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EDF0D6E94B;
	Fri, 10 Sep 2021 00:38:57 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam07on2050.outbound.protection.outlook.com [40.107.95.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 862736E94B
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Sep 2021 00:38:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P3bvyRiYp1BsQ6KN995kR75Sy0YDi7IaAzYUsmrA3zsiVBFK2mkkM87Ir31BwXy91fQOlXw199Ru8DNfvD0BXSfcZmQLMMgVj/atgoWMmSG95Gad7uPbt30NTXaQKl5BlI2qQ6egbyH9obRAGUqf0I2AproItwmeiWLnIyCt7kjTnczfWbx8hinJe5NjL+bwxnsRKXQEtXBm42n4sYJ1hN6XxGgwYSEMGWNSMj3f2VElaHRtHJ59abNWvWi4Hp6rUE3V1L/hRp3gaYEGimukXw8jlv3LCWZuJaIkCuBVbob6tkBTVccKMecITICG2Z768bqYgUAXMkR7zD3P2xcK2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=kol6YKwDX117REW+ls/ZpZyElT+PXraRKEa2DNVG5BE=;
 b=aonOu5ylEOZvlu6o72EAOzgwSbu/VM9Sf8dPUp/ah/JW+HopZbTnbilI90kEYo9nV6xyeVexzIdV7v1vVj0scjIjZJUhWx3lsuyBtl0dTvy4SuVHfMdt/235CEZBL0Xv4dRxbgwuQ0027afyTBEvI/rymJeTet88LFwUHmguX4i0+C7p0dHYLIM/i2K8GdReJdDxEpAaicq008A53+lBbdVtlgpgqP4+RQe1FMgVstMVvh/PKNwDGNILyHnqCiSAGuKTCjvlUHd0cgwAkIUnkJwYAaQTk8jn+AkBWQrJ4oAy02flKPGviNxupns36acAaCGPbGmyGHPXGAqIJSvQkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kol6YKwDX117REW+ls/ZpZyElT+PXraRKEa2DNVG5BE=;
 b=sQCt+9GjUr6m3EkuwfOYibk9G3nz/7MC48aqAtoyaKY35fcLj7AOTZ8IBbC8F6NOGOFsBRsvho1NAIeBQnUEJpLR+IYG9kn+8Ev5CNKzoeKXnTjZJmoz4hTWlrO44LMq5UUbExHa0RfBkOxxYCUfrP7YDRYw7ZO/ai80NH5q478=
Received: from DM6PR18CA0026.namprd18.prod.outlook.com (2603:10b6:5:15b::39)
 by MW2PR12MB2539.namprd12.prod.outlook.com (2603:10b6:907:9::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.16; Fri, 10 Sep
 2021 00:38:50 +0000
Received: from DM6NAM11FT014.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:15b:cafe::db) by DM6PR18CA0026.outlook.office365.com
 (2603:10b6:5:15b::39) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.14 via Frontend
 Transport; Fri, 10 Sep 2021 00:38:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT014.mail.protection.outlook.com (10.13.173.132) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4500.14 via Frontend Transport; Fri, 10 Sep 2021 00:38:50 +0000
Received: from pp-server-two.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Thu, 9 Sep 2021
 19:38:47 -0500
From: xinhui pan <xinhui.pan@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <alexander.deucher@amd.com>, <christian.koenig@amd.com>, xinhui pan
 <xinhui.pan@amd.com>
Subject: [PATCH 4/4] drm/amdgpu: VCN avoid memory allocation during IB test
Date: Fri, 10 Sep 2021 08:38:28 +0800
Message-ID: <20210910003828.4013-4-xinhui.pan@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210910003828.4013-1-xinhui.pan@amd.com>
References: <20210910003828.4013-1-xinhui.pan@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 87329a61-c4c9-47d5-ba3e-08d973f35bbf
X-MS-TrafficTypeDiagnostic: MW2PR12MB2539:
X-Microsoft-Antispam-PRVS: <MW2PR12MB2539CCF366672FF9C458D71387D69@MW2PR12MB2539.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:181;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RIDw4a43lQ1+AVASe36DaZlegBpvmDBl/hWS4DDVqx7JUmq8lw/YpIfwLe0/ZJBrwIJRCSoBIkbA0s85RyTOqFbKYG6FtcoMkqKS8EMr/6n6OIgyWRxysztnHwVRuGkJzWtp3SBxOr6wt4GOyXbdnruI1OWhZ5MJOt3pT3kx9fVMupRtdL1ktfjYkgegQWaU6+fk4Okp7mGmOnXGfykC3/GrutL9ulsOzwTXU9k5Zb1tvAR85fit6cuFswVRoKy/VAqbQIqNVrbf71P+rFMBqHhos5jxmSlLVt6atnW+dhI4S7GejwtFAEH6dYjh/qcnvFJKIqVybBzgwJtzanzaWcF7Yml+kf4rj+k6TGMIe/hzxCM71d1hJsj6P7yW4ILbuNqyCcRt/VBA9AzN24a4fHQjqnGp0iO29KAAmpmF32dJuBcTS2qvDqHyFX0DDB6NRHMeK0j+AbqmqCMVMNIW0vyPEggp2xBBJhENKFNobz4bNnfR6F+N5w8qgh+k+6Eg9W2jfkOEN9IPQj5el52s+wlHQcpBuC29vYvjrc0pcCYkn4kcE5jjw7eA8no2uKyYJMS0V/JgnxdEDmtDIponnHmgeJ8fkGr9AlTTCEVKIk71fPFL3KxIGtyaV1n+sRDzLhnzB8n/JCFnBCmPtyd0i0DisSUjDkjg3gmbwn8f2Bcnc8+3nQq8TMDVkrk9vH0acsq4olFqBCd587Z7Im2d+6pODJZ2aL2QeVxtjreMjyE=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(346002)(39860400002)(396003)(136003)(376002)(36840700001)(46966006)(36860700001)(26005)(2906002)(54906003)(83380400001)(86362001)(316002)(47076005)(70206006)(82310400003)(1076003)(8676002)(82740400003)(4326008)(36756003)(186003)(6916009)(2616005)(81166007)(16526019)(426003)(356005)(478600001)(336012)(70586007)(7696005)(5660300002)(6666004)(8936002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2021 00:38:50.2255 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 87329a61-c4c9-47d5-ba3e-08d973f35bbf
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT014.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR12MB2539
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
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c | 99 +++++++++++--------------
 1 file changed, 45 insertions(+), 54 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
index 561296a85b43..b60d5f01fdae 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
@@ -541,15 +541,14 @@ int amdgpu_vcn_dec_sw_ring_test_ring(struct amdgpu_ring *ring)
 }
 
 static int amdgpu_vcn_dec_send_msg(struct amdgpu_ring *ring,
-				   struct amdgpu_bo *bo,
-				   struct dma_fence **fence)
+		struct amdgpu_ib *ib_msg,
+		struct dma_fence **fence)
 {
 	struct amdgpu_device *adev = ring->adev;
 	struct dma_fence *f = NULL;
 	struct amdgpu_job *job;
 	struct amdgpu_ib *ib;
-	uint64_t addr;
-	void *msg = NULL;
+	uint64_t addr = ib_msg->gpu_addr;
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
+	r = amdgpu_ib_get(adev, NULL, PAGE_SIZE,
+			AMDGPU_IB_POOL_DIRECT,
+			ib);
 	if (r)
 		return r;
 
+	msg = ib->ptr;
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
+	r = amdgpu_ib_get(adev, NULL, PAGE_SIZE,
+			AMDGPU_IB_POOL_DIRECT,
+			ib);
 	if (r)
 		return r;
 
+	msg = ib->ptr;
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
+		struct amdgpu_ib *ib_msg,
+		struct dma_fence **fence)
 {
 	struct amdgpu_vcn_decode_buffer *decode_buffer = NULL;
 	const unsigned int ib_size_dw = 64;
@@ -697,7 +692,7 @@ static int amdgpu_vcn_dec_sw_send_msg(struct amdgpu_ring *ring,
 	struct dma_fence *f = NULL;
 	struct amdgpu_job *job;
 	struct amdgpu_ib *ib;
-	uint64_t addr;
+	uint64_t addr = ib_msg->gpu_addr;
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
+	addr = ib_msg->gpu_addr;
 
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
+	addr = ib_msg->gpu_addr;
 
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
+	r = amdgpu_ib_get(adev, NULL, 128 << 10,
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

