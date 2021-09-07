Return-Path: <SRS0=wMah=N5=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D5E0C433F5
	for <amd-gfx@archiver.kernel.org>; Tue,  7 Sep 2021 07:05:00 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CD7E560F6D
	for <amd-gfx@archiver.kernel.org>; Tue,  7 Sep 2021 07:04:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org CD7E560F6D
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7D13589D00;
	Tue,  7 Sep 2021 07:04:59 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2050.outbound.protection.outlook.com [40.107.94.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 12CAD89D00
 for <amd-gfx@lists.freedesktop.org>; Tue,  7 Sep 2021 07:04:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JclHDGdnkR2WHezqVnfyvfARJOPtiwCIS6FG5fCiQTUrhaAK3C5VEzZ03ParEiNzLnkP5X+rIvJHAbl44K6bCpzCmu52huOwzsCAQ3sIaAHL8ocH1RmO7rJX2WNHozaYZdH+paVLdvIZEsxXYGiyRhA4989PjQOA6N+QWqJURkTN5KXLXRqvkW0zI1S3vbaDfJBHYJLI1fy1N+Fk3V5Ph2Ca8WGlg7Ilz/zyHef0wuKN75kcwljWkArhGmkHcc1Eh++v7YsbvRVhyKbMWLAOeThnf8Bj7RPR/T6E8ivkGuSXROx20XgheoLYJlxuY24tY5bU3pJTRTEJCED5y/n+ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=fCx4tY9c/z2w/1c1oIcGct6Tv32N+qsiQ1hRzH9N/yw=;
 b=l54Jv7L9A1If9ngu0hCv4YL9h8nF3XWuZ0k+OX5bgQD4fh6DInY7LRsYPhPhnUSkq8S8CG5DaSDFNIIGDflrp9dUp11R0qvjHFkI/olp/24VxlkrerKw/8WVOBpW3LAQen2W4F6IiNW2MSfYzE69JSZGZTnP49Ul3W1RvfyxCWOEHh/WDGVRfdm5oVS59DtMj6vQfKKHT47AixOA2pyDwH6x1QOmTELLK+zpgF8m5xsJISfI3nxq5pN58RCmtOWo/pGPcVULyZIe/LFEhwzHssKhPfexUmfsyzG+Nl+GWYFYIw1PeBvMBnhR4976D7nB1zR3os7cOWefFyrsmpV+Lg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fCx4tY9c/z2w/1c1oIcGct6Tv32N+qsiQ1hRzH9N/yw=;
 b=VjD1WSGCYsQwK1x52kglNVhkmhwfrjqXr0ww7A+VcCaXchOYe593lvbpUe34i4ktnZCYdSEtzKIAra3RdtaI3SS3bGAN73qzMYIsirhrcZEVFjFdDguc+Aq+n7oKcNDQogsv0EYxrL/av1kS9VdApsoDJWURtvv4ATEMvXTZt6Y=
Received: from MWHPR21CA0040.namprd21.prod.outlook.com (2603:10b6:300:129::26)
 by MWHPR12MB1807.namprd12.prod.outlook.com (2603:10b6:300:113::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.20; Tue, 7 Sep
 2021 07:04:57 +0000
Received: from CO1NAM11FT032.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:129:cafe::50) by MWHPR21CA0040.outlook.office365.com
 (2603:10b6:300:129::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.1 via Frontend
 Transport; Tue, 7 Sep 2021 07:04:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT032.mail.protection.outlook.com (10.13.174.218) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4478.19 via Frontend Transport; Tue, 7 Sep 2021 07:04:56 +0000
Received: from pp-server-two.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Tue, 7 Sep 2021
 02:04:54 -0500
From: xinhui pan <xinhui.pan@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <christian.koenig@amd.com>, xinhui pan <xinhui.pan@amd.com>
Subject: [RFC PATCH] drm/amdgpu: alloc uvd msg from IB pool
Date: Tue, 7 Sep 2021 15:04:31 +0800
Message-ID: <20210907070431.2081-1-xinhui.pan@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9a9a7c9a-4419-4d87-5482-08d971cdcce6
X-MS-TrafficTypeDiagnostic: MWHPR12MB1807:
X-Microsoft-Antispam-PRVS: <MWHPR12MB18075EBEE4B6C049A54F614187D39@MWHPR12MB1807.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:660;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Xju7TecAyXLhycBuZed3Zr0T1Tti3PpEwrRGNCLg75PfjaD+zjQEjph+Zh0tuC5B6KFfw0QgiTLaJp/sivxWga9krD0SUdN9U9wJ9Ge8cCGvag4Rhj+J7sC4OnP9w3EhmVvRGRlMHnodne4tHj0j1Cym42wImgaCmEl6s/jxc53OfpT+58pTeIJMHjxOnuhaQZcwVWSK6eSHCjwAwEVmTI49frkUszKu4vnEpKl9yC4ZhB7CLlY+JNZvRmtx/TswcHPvkOWKeZIuabAo6a6SGCejDyliVMkcDxYnr1ESrTjeT1meeURuQTYPsc/AYSnnS8tAxdLAr1gIFkufGK8MNfKQ00K567ihqDfNBc+nNbf9mqv1epDlBgVCU9kW3B3kY/AtYSbDoZNfDKG5VsLJY08L2YV0JOjQCfwhh8p0WzKB/9egd6xl0vDL2iHQoeGLmwOIyBEBz3LpA4NGzOfl/LoiaNwP9FY/gKiPBhkOrjbFsr9HOPsHvOZehJoH+zXP853yXrtzzeW6g8rv5QlxthBuZsSoTAgYKG5wk9Key+XoV188cObX+vtmW20S6VbzcgtSoOUUrDF62er/7wREClHgnH+hKBByKK9s6lWClCcuiU/KZBEmc1/pB0qjre9+Ei+iX/jFl06hZyGHtA9LjNMcK35VNVzTexnqpNfyamjZHyVj2BGRvQH+Awqh4T6gjmGv7M3GqDEcjmmTzqAAdU/dRq1ynJEurzsNBK8K1As=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(39860400002)(376002)(396003)(346002)(136003)(36840700001)(46966006)(8676002)(82310400003)(2616005)(47076005)(70586007)(6916009)(70206006)(36860700001)(82740400003)(26005)(86362001)(426003)(336012)(478600001)(4326008)(54906003)(316002)(356005)(6666004)(8936002)(16526019)(2906002)(1076003)(36756003)(186003)(7696005)(83380400001)(81166007)(5660300002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2021 07:04:56.7818 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a9a7c9a-4419-4d87-5482-08d971cdcce6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT032.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1807
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

