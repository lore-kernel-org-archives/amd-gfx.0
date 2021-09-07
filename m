Return-Path: <SRS0=wMah=N5=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8928EC433EF
	for <amd-gfx@archiver.kernel.org>; Tue,  7 Sep 2021 07:29:13 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 595456109D
	for <amd-gfx@archiver.kernel.org>; Tue,  7 Sep 2021 07:29:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 595456109D
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 03A8988FF7;
	Tue,  7 Sep 2021 07:29:13 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2080.outbound.protection.outlook.com [40.107.244.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A043A88FF7
 for <amd-gfx@lists.freedesktop.org>; Tue,  7 Sep 2021 07:29:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cvxEppi+v4WFwC3ziPTYJbIqyz/73hk8ybC+pE9uxrfiV6IPyoBYYlavHBC95Atih0l6Atk/FJbq2IkRnsj4lgUV3vokvBmIzrkWcpYkiWy/5OWeWq0odTA+6IW3bDeUTUrRHGGIpMlXdtEIHxgYi9/NeYMuTEY+YLLlfSj4lIrY0aEqnYwlgfKlLuTerjR+BeqDHRLhBBpzgqGGLyGt3qhYV0kddXl7lGRuPYz7lUSu5nxBkaRXkjSRcFhiuC5ykqYH2IFQHv5tFDR2CMB36D7YqGZJXAxLdT+BJ/me4bVvA0wLxkTLF6eCn0a0tOerwApCbjpLiub3EcPHAxMMoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=fCx4tY9c/z2w/1c1oIcGct6Tv32N+qsiQ1hRzH9N/yw=;
 b=LA0hmeShuShNF6GVpK9G8jZd0KygzfZHnNX5mKS4f61saV/pL7D8S/MGRpOIUdT+IVZJ6DbKDEbztzJ2R9faCNtZcr56DnzwuD/jgP8vzv7pbcwD7ccnLCldJDHid0BL1KvQZ0rLHtuArW42Vnkxknub9WiIygawfYOsiwbCAm8yBoav3wlZjKYxMVQnjpJyp7ofhNZajkhd0ozT0nz69FPna8EEbeF4IwzEBzZRqoG0jxmrTMMqWxYq5NHesB0i05DfX/Hi9/Q2VB1KLnNwWXDdNfKn9+ZniJKhVLjGyoMe+yHOt/QpCdUM09G1alLqRgeasRTRczdtvxUlanvgiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fCx4tY9c/z2w/1c1oIcGct6Tv32N+qsiQ1hRzH9N/yw=;
 b=ePDwHlUObcesTIg6iJjVjoXcUtiIPWCn7d+XaKU77S7KmCqF3W2VtGBaMFDzZ1bbILZ8jT4kPzpDmtkH3PgqWHZCd1r6ApYGkd9dl5j6DPxbIM3x82+O47rbw3Q6KIL+h34JnzWu73h9cfch6hxcX4q9oBSZVG9lyX9nn/UIJt8=
Received: from MWHPR07CA0020.namprd07.prod.outlook.com (2603:10b6:300:116::30)
 by BL1PR12MB5191.namprd12.prod.outlook.com (2603:10b6:208:318::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.21; Tue, 7 Sep
 2021 07:29:10 +0000
Received: from CO1NAM11FT012.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:116:cafe::67) by MWHPR07CA0020.outlook.office365.com
 (2603:10b6:300:116::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.14 via Frontend
 Transport; Tue, 7 Sep 2021 07:29:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT012.mail.protection.outlook.com (10.13.175.192) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4478.19 via Frontend Transport; Tue, 7 Sep 2021 07:29:09 +0000
Received: from pp-server-two.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Tue, 7 Sep 2021
 02:29:08 -0500
From: xinhui pan <xinhui.pan@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: xinhui pan <xinhui.pan@amd.com>
Subject: [RFC PATCH] drm/amdgpu: alloc uvd msg from IB pool
Date: Tue, 7 Sep 2021 15:28:53 +0800
Message-ID: <20210907072853.3942-1-xinhui.pan@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 77fc44f1-0c53-495c-bac9-08d971d12f08
X-MS-TrafficTypeDiagnostic: BL1PR12MB5191:
X-Microsoft-Antispam-PRVS: <BL1PR12MB5191995900CCD5F4E2FDC5E487D39@BL1PR12MB5191.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:660;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ja1WKZPJrvjqpFQbSu0oe4cEL1Eh6Bp/scCfYc4yyxx7u6Bf6UoY7NUS29SwEbRD4RGZhfWoBAVuLjGyuf3VjROoxWOZg8GGYWIbe+8FeGwB2Xw/FkGyfVC61v1BmeQIzh/TwucvPt0sft2sniQMk39iqNGl4Sj0WWyR92yBiaOekWSrWUo3892yPcTTsLPzuMl518UY7ViK8pffIUHdTAaKbcFPHu8jywUdq0qywqII+q4192ahnjycKQ0FqA4ALOdbxkNUwFBlXxbARlrUnOWStgOgCY3AgkGrXaWU3i0bnwSCjkMwbAwWtR5PhFVH+yM9KXxT6YwiYBBxMQ7yF2cHEn/fYAT2b7gIS7otERyHJTl2jgJZsya+phatCPlbKUuZItFY8kn04pKU9OlMIWB1fn7U4GaDry/y2/t9aOoCtMAlOGRLXMQjh2PnadzFkKn+Z2eH+4faXpP3+x8j0CJOFW9lE+HTLN2dOPeU/BBvFqg52JoDIz+JFXtiOKFEkafpAFiWFYW4LLb3APTOcnAKf5IkSoDJeTTR4PQ4MT3p9ggH0p8mrphXEO/qXGJmVfy5IxhExohMVMSi70R6oPdYCqdsOF/9Wgs8QeVnxVnDTxJxU2W2I0wB90gA8DCxuCiJg1GkCIszBHrFzPtWsiclOjklXoHVaORzuC2D/3uenc2LWlmqhYr4ap4voYfsEKYsSHwHEAsbPotjexmn57NWJlCUEEhGu5huwHHHiKM=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(346002)(396003)(136003)(376002)(39860400002)(36840700001)(46966006)(7696005)(70206006)(47076005)(82310400003)(8936002)(82740400003)(36860700001)(2616005)(316002)(478600001)(5660300002)(2906002)(36756003)(426003)(356005)(336012)(70586007)(83380400001)(16526019)(8676002)(1076003)(86362001)(4326008)(186003)(6916009)(26005)(81166007)(6666004)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2021 07:29:09.9278 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 77fc44f1-0c53-495c-bac9-08d971d12f08
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT012.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5191
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

There is one dedicated IB pool for IB test. So lets use it for uvd msg
too.

Signed-off-by: xinhui pan <xinhui.pan@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c | 223 +++++++++++++-----------
 1 file changed, 126 insertions(+), 97 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c
index d451c359606a..29fbe976a300 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c
@@ -1066,37 +1066,65 @@ int amdgpu_uvd_ring_parse_cs(struct amdgpu_cs_parser *parser, uint32_t ib_idx)
 	return 0;
 }
 
-static int amdgpu_uvd_send_msg(struct amdgpu_ring *ring, struct amdgpu_bo *bo,
-			       bool direct, struct dma_fence **fence)
+typedef void (*uvd_msg_cb) (struct amdgpu_ring *ring, uint32_t handle,
+		struct amdgpu_ib *ib, uint32_t *msg, uint64_t msg_gpu_addr);
+
+static void amdgpu_uvd_get_create_msg_cb(struct amdgpu_ring *ring, uint32_t handle,
+		struct amdgpu_ib *ib, uint32_t *msg, uint64_t addr)
 {
 	struct amdgpu_device *adev = ring->adev;
-	struct dma_fence *f = NULL;
-	struct amdgpu_job *job;
-	struct amdgpu_ib *ib;
 	uint32_t data[4];
-	uint64_t addr;
-	long r;
+	unsigned int offset_idx = 0;
+	unsigned int offset[3] = { UVD_BASE_SI, 0, 0 };
 	int i;
-	unsigned offset_idx = 0;
-	unsigned offset[3] = { UVD_BASE_SI, 0, 0 };
 
-	amdgpu_bo_kunmap(bo);
-	amdgpu_bo_unpin(bo);
+	if (adev->asic_type >= CHIP_VEGA10) {
+		offset_idx = 1 + ring->me;
+		offset[1] = adev->reg_offset[UVD_HWIP][0][1];
+		offset[2] = adev->reg_offset[UVD_HWIP][1][1];
+	}
 
-	if (!ring->adev->uvd.address_64_bit) {
-		struct ttm_operation_ctx ctx = { true, false };
+	data[0] = PACKET0(offset[offset_idx] + UVD_GPCOM_VCPU_DATA0, 0);
+	data[1] = PACKET0(offset[offset_idx] + UVD_GPCOM_VCPU_DATA1, 0);
+	data[2] = PACKET0(offset[offset_idx] + UVD_GPCOM_VCPU_CMD, 0);
+	data[3] = PACKET0(offset[offset_idx] + UVD_NO_OP, 0);
 
-		amdgpu_bo_placement_from_domain(bo, AMDGPU_GEM_DOMAIN_VRAM);
-		amdgpu_uvd_force_into_uvd_segment(bo);
-		r = ttm_bo_validate(&bo->tbo, &bo->placement, &ctx);
-		if (r)
-			goto err;
+	ib->ptr[0] = data[0];
+	ib->ptr[1] = addr;
+	ib->ptr[2] = data[1];
+	ib->ptr[3] = addr >> 32;
+	ib->ptr[4] = data[2];
+	ib->ptr[5] = 0;
+	for (i = 6; i < 16; i += 2) {
+		ib->ptr[i] = data[3];
+		ib->ptr[i+1] = 0;
 	}
+	ib->length_dw = 16;
 
-	r = amdgpu_job_alloc_with_ib(adev, 64, direct ? AMDGPU_IB_POOL_DIRECT :
-				     AMDGPU_IB_POOL_DELAYED, &job);
-	if (r)
-		goto err;
+	/* stitch together an UVD create msg */
+	msg[0] = cpu_to_le32(0x00000de4);
+	msg[1] = cpu_to_le32(0x00000000);
+	msg[2] = cpu_to_le32(handle);
+	msg[3] = cpu_to_le32(0x00000000);
+	msg[4] = cpu_to_le32(0x00000000);
+	msg[5] = cpu_to_le32(0x00000000);
+	msg[6] = cpu_to_le32(0x00000000);
+	msg[7] = cpu_to_le32(0x00000780);
+	msg[8] = cpu_to_le32(0x00000440);
+	msg[9] = cpu_to_le32(0x00000000);
+	msg[10] = cpu_to_le32(0x01b37000);
+	for (i = 11; i < 1024; ++i)
+		msg[i] = cpu_to_le32(0x0);
+}
+
+static void amdgpu_uvd_get_destroy_msg_cb(struct amdgpu_ring *ring, uint32_t handle,
+		struct amdgpu_ib *ib, uint32_t *msg, uint64_t addr)
+{
+	struct amdgpu_device *adev = ring->adev;
+	uint32_t data[4];
+	unsigned int offset_idx = 0;
+	unsigned int offset[3] = { UVD_BASE_SI, 0, 0 };
+	int i;
 
 	if (adev->asic_type >= CHIP_VEGA10) {
 		offset_idx = 1 + ring->me;
@@ -1109,8 +1137,6 @@ static int amdgpu_uvd_send_msg(struct amdgpu_ring *ring, struct amdgpu_bo *bo,
 	data[2] = PACKET0(offset[offset_idx] + UVD_GPCOM_VCPU_CMD, 0);
 	data[3] = PACKET0(offset[offset_idx] + UVD_NO_OP, 0);
 
-	ib = &job->ibs[0];
-	addr = amdgpu_bo_gpu_offset(bo);
 	ib->ptr[0] = data[0];
 	ib->ptr[1] = addr;
 	ib->ptr[2] = data[1];
@@ -1123,46 +1149,92 @@ static int amdgpu_uvd_send_msg(struct amdgpu_ring *ring, struct amdgpu_bo *bo,
 	}
 	ib->length_dw = 16;
 
-	if (direct) {
+	/* stitch together an UVD destroy msg */
+	msg[0] = cpu_to_le32(0x00000de4);
+	msg[1] = cpu_to_le32(0x00000002);
+	msg[2] = cpu_to_le32(handle);
+	msg[3] = cpu_to_le32(0x00000000);
+	for (i = 4; i < 1024; ++i)
+		msg[i] = cpu_to_le32(0x0);
+}
+
+static int amdgpu_uvd_send_msg(struct amdgpu_ring *ring, bool direct,
+		uvd_msg_cb cb, uint32_t handle, uint32_t ib_size,
+		uint32_t msg_size, struct dma_fence **fence)
+{
+	struct amdgpu_device *adev = ring->adev;
+	struct dma_fence *f = NULL;
+	struct amdgpu_job *job;
+	struct amdgpu_bo *bo = NULL;
+	struct amdgpu_ib msg;
+	int r;
+
+	if (!ring->adev->uvd.address_64_bit) {
+		struct ttm_operation_ctx ctx = { true, false };
+
+		r = amdgpu_bo_create_reserved(adev, msg_size, PAGE_SIZE,
+				AMDGPU_GEM_DOMAIN_VRAM,
+				&bo, NULL, (void **)&msg.ptr);
+		if (r)
+			return r;
+		amdgpu_bo_kunmap(bo);
+		amdgpu_bo_unpin(bo);
+		amdgpu_bo_placement_from_domain(bo, AMDGPU_GEM_DOMAIN_VRAM);
+		amdgpu_uvd_force_into_uvd_segment(bo);
+		r = ttm_bo_validate(&bo->tbo, &bo->placement, &ctx);
+		if (r)
+			goto error;
 		r = dma_resv_wait_timeout(bo->tbo.base.resv, true, false,
-					  msecs_to_jiffies(10));
+				msecs_to_jiffies(10));
 		if (r == 0)
 			r = -ETIMEDOUT;
 		if (r < 0)
-			goto err_free;
-
-		r = amdgpu_job_submit_direct(job, ring, &f);
-		if (r)
-			goto err_free;
+			goto error;
 	} else {
-		r = amdgpu_sync_resv(adev, &job->sync, bo->tbo.base.resv,
-				     AMDGPU_SYNC_ALWAYS,
-				     AMDGPU_FENCE_OWNER_UNDEFINED);
+		memset(&msg, 0, sizeof(msg));
+		r = amdgpu_ib_get(adev, NULL, PAGE_ALIGN(msg_size),
+				direct ?
+				AMDGPU_IB_POOL_DIRECT : AMDGPU_IB_POOL_DELAYED,
+				&msg);
 		if (r)
-			goto err_free;
+			goto error;
+	}
 
+	r = amdgpu_job_alloc_with_ib(adev, ib_size,
+			direct ? AMDGPU_IB_POOL_DIRECT : AMDGPU_IB_POOL_DELAYED,
+			&job);
+	if (r)
+		goto error;
+
+	cb(ring, handle, &(job->ibs[0]), msg.ptr,
+			bo ? amdgpu_bo_gpu_offset(bo) : msg.gpu_addr);
+
+	if (direct)
+		r = amdgpu_job_submit_direct(job, ring, &f);
+	else
 		r = amdgpu_job_submit(job, &adev->uvd.entity,
 				      AMDGPU_FENCE_OWNER_UNDEFINED, &f);
-		if (r)
-			goto err_free;
+	if (r) {
+		amdgpu_job_free(job);
+		goto error;
 	}
 
-	amdgpu_bo_fence(bo, f, false);
-	amdgpu_bo_unreserve(bo);
-	amdgpu_bo_unref(&bo);
+	if (bo)
+		amdgpu_bo_fence(bo, f, false);
+	else
+		amdgpu_ib_free(adev, &msg, f);
 
 	if (fence)
 		*fence = dma_fence_get(f);
 	dma_fence_put(f);
-
-	return 0;
-
-err_free:
-	amdgpu_job_free(job);
-
-err:
-	amdgpu_bo_unreserve(bo);
-	amdgpu_bo_unref(&bo);
+error:
+	if (bo) {
+		amdgpu_bo_unreserve(bo);
+		amdgpu_bo_unref(&bo);
+	} else {
+		if (r)
+			amdgpu_ib_free(adev, &msg, NULL);
+	}
 	return r;
 }
 
@@ -1172,58 +1244,15 @@ static int amdgpu_uvd_send_msg(struct amdgpu_ring *ring, struct amdgpu_bo *bo,
 int amdgpu_uvd_get_create_msg(struct amdgpu_ring *ring, uint32_t handle,
 			      struct dma_fence **fence)
 {
-	struct amdgpu_device *adev = ring->adev;
-	struct amdgpu_bo *bo = NULL;
-	uint32_t *msg;
-	int r, i;
-
-	r = amdgpu_bo_create_reserved(adev, 1024, PAGE_SIZE,
-				      AMDGPU_GEM_DOMAIN_GTT,
-				      &bo, NULL, (void **)&msg);
-	if (r)
-		return r;
-
-	/* stitch together an UVD create msg */
-	msg[0] = cpu_to_le32(0x00000de4);
-	msg[1] = cpu_to_le32(0x00000000);
-	msg[2] = cpu_to_le32(handle);
-	msg[3] = cpu_to_le32(0x00000000);
-	msg[4] = cpu_to_le32(0x00000000);
-	msg[5] = cpu_to_le32(0x00000000);
-	msg[6] = cpu_to_le32(0x00000000);
-	msg[7] = cpu_to_le32(0x00000780);
-	msg[8] = cpu_to_le32(0x00000440);
-	msg[9] = cpu_to_le32(0x00000000);
-	msg[10] = cpu_to_le32(0x01b37000);
-	for (i = 11; i < 1024; ++i)
-		msg[i] = cpu_to_le32(0x0);
-
-	return amdgpu_uvd_send_msg(ring, bo, true, fence);
+	return amdgpu_uvd_send_msg(ring, true, amdgpu_uvd_get_create_msg_cb,
+			handle, 64, PAGE_SIZE, fence);
 }
 
 int amdgpu_uvd_get_destroy_msg(struct amdgpu_ring *ring, uint32_t handle,
-			       bool direct, struct dma_fence **fence)
+			      bool direct, struct dma_fence **fence)
 {
-	struct amdgpu_device *adev = ring->adev;
-	struct amdgpu_bo *bo = NULL;
-	uint32_t *msg;
-	int r, i;
-
-	r = amdgpu_bo_create_reserved(adev, 1024, PAGE_SIZE,
-				      AMDGPU_GEM_DOMAIN_GTT,
-				      &bo, NULL, (void **)&msg);
-	if (r)
-		return r;
-
-	/* stitch together an UVD destroy msg */
-	msg[0] = cpu_to_le32(0x00000de4);
-	msg[1] = cpu_to_le32(0x00000002);
-	msg[2] = cpu_to_le32(handle);
-	msg[3] = cpu_to_le32(0x00000000);
-	for (i = 4; i < 1024; ++i)
-		msg[i] = cpu_to_le32(0x0);
-
-	return amdgpu_uvd_send_msg(ring, bo, direct, fence);
+	return amdgpu_uvd_send_msg(ring, direct, amdgpu_uvd_get_destroy_msg_cb,
+			handle, 64, PAGE_SIZE, fence);
 }
 
 static void amdgpu_uvd_idle_work_handler(struct work_struct *work)
-- 
2.25.1

