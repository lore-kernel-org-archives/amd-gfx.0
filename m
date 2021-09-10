Return-Path: <SRS0=y1ja=OA=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B00B4C433EF
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Sep 2021 12:30:39 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 51FEB611C0
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Sep 2021 12:30:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 51FEB611C0
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ED3FF6E9EB;
	Fri, 10 Sep 2021 12:30:38 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2052.outbound.protection.outlook.com [40.107.93.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 27CBD6E9EB
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Sep 2021 12:30:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WVbI71k90PUJGQ6zzwK0qGUQVp7TkRqvniuuDOrnBrRYy5ZfL+4Wxzbn5bLerEnK8jEsbY+x1/LwoVEAcFd4Nfr0jnJJ2m+CmrO2mmeobzr4QoiomWeE64AiwtnHTU+m5KDtAyYVAWKHjf+pKf5e0dIcPjpWkCMJFBu1knyvf40/5kNlQAIo8vq4Gh3GuBfmq2N9zBpgIC+b/qemk1Z/9LSr/8gnmqPfkpV5jH75OrmiAZCAdISH7zy8gcmcJaeoZ0ZuCCy/ea+gRTVwxXfe5rGPCF39BfT6PMVoI+ImsROdwLLnnvi5z62tlU1Elf/jgq15fmC0DG+8kiowWLqoIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=ORbN+Wy33xnweGuAiz+0VSbLaSjBNbYScVPhX3pZGZM=;
 b=C0pmwl+wJZ18HHLt8Pa7F8EhavRhjnk6XlpBi8t0O1BkVE9hMjf4xsSNS6MzEiiR015myZJtAO3YbjFvQkepg1O8xwjXLXu1AdqHfp5fYXZlSjhCXOYUKYxHwzOZ+mTTD3pG6FuoLVW0wqCpIXE8FLpkmUN56C7Uh/om2KGulmqPPMOPMLAJ5RYKskDeycq1e2Yczwxn4Xpu24lsAf9jVYJO4Dhw9gfC+B0TMJYF8tIDhRAD6Qhm/a+7mGlOn1p/ImRn+1qyoj5nTTzYXR1UacGa5yM4QUTt3dxxSViHJ4qZU0tfDKFJA0ZPA9oviwdbnOIl3cuBNJ8fE35vDhNDeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ORbN+Wy33xnweGuAiz+0VSbLaSjBNbYScVPhX3pZGZM=;
 b=tDRBF5rLHCtIu+zEIgbrXci8wPSkjh59kH3lQ5XD+L3s3VMB5nT5kNalznw322M51UQPY/V1m4uGO70wS2hRqa7g1T3YVPwig2v7bbbxekRm18zwL0jTKhUZLweN+GlfULqycNJiHj/lJdNZXsB+u1LFzzajgUfuoLHwVGxaiM0=
Received: from DM5PR06CA0042.namprd06.prod.outlook.com (2603:10b6:3:5d::28) by
 MWHPR12MB1870.namprd12.prod.outlook.com (2603:10b6:300:10a::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.14; Fri, 10 Sep
 2021 12:30:08 +0000
Received: from DM6NAM11FT060.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:5d:cafe::40) by DM5PR06CA0042.outlook.office365.com
 (2603:10b6:3:5d::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.14 via Frontend
 Transport; Fri, 10 Sep 2021 12:30:08 +0000
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
 15.20.4500.14 via Frontend Transport; Fri, 10 Sep 2021 12:30:08 +0000
Received: from pp-server-two.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Fri, 10 Sep
 2021 07:30:06 -0500
From: xinhui pan <xinhui.pan@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <alexander.deucher@amd.com>, <christian.koenig@amd.com>, xinhui pan
 <xinhui.pan@amd.com>
Subject: [PATCH v2 1/3] drm/amdgpu: UVD avoid memory allocation during IB test
Date: Fri, 10 Sep 2021 20:29:38 +0800
Message-ID: <20210910122940.15699-1-xinhui.pan@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 163b9cca-d8a0-4bad-e525-08d97456b9cb
X-MS-TrafficTypeDiagnostic: MWHPR12MB1870:
X-Microsoft-Antispam-PRVS: <MWHPR12MB1870E7DBE1C3C4916FE670CB87D69@MWHPR12MB1870.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1388;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Z6bLPHtLG6IQT08lHisR2Yst9Tz6YWUkLtpXqeDSEiXJrgXHhx2dqMdWZubofOKuBlhofsS8kFGhnibM6YwKsK+K2LkEEne9+ytjrHrnsV/fflYLttnD2fb39KehLwzFl0ciKu5owwhl6wL8ytP63CCR3RkOInrND6STQku92poRJLrIppYXF5tS2M//mqFrRCNwNYDkqOEdQmV4yFGAjnlYNlM4IkxjK8uR3iUeWtY5vkfvYoXvwiyHREorJgAHl5Y5ldhDZnqcDE+jZv785kfb/RJzvyK0DkFAlvBBnd+DUjLBO7rTOvOdxXDIbD5tPMLM1l/Z9R36wNOFjFzvmCmdKM1PseUKy2KL3GfRBSzmqUJJsDdhtlXZAJxis32OBLfr7cN3qCqoAakJ2HkHc5a/FCCVaNjXme5zyhRHknLVlx/lWItfZuMduSNTMijEXGY2XukExTDwkRDMicsEESWZHMxvOBbs2xqjniI5vLi80LIe0eNRYzZ57/Lz02u+TMjRqDjD6kpQ5idO7lhMZXT8jYXYUibhkDa1+AHsAME/9ARLgDuvLEsrCdcmlwqtJdAJssDo/xNMdjldXfSwUie/bzEUbp2byXptlHUyN7PmYqSVyQTZDO7nru/UKLtUfVzpPXs6gmSEs21uZQt+5KquMZVpOZMCVtTkS4CYP48a83HG1C8dcwM5j/X0b7s+xsYxV024XIkXb/jj+2DbHQ4V83/BrPf5BWjkF9L+tqQ=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(6666004)(36860700001)(70206006)(83380400001)(81166007)(4326008)(16526019)(70586007)(8676002)(1076003)(2616005)(356005)(82310400003)(2906002)(47076005)(5660300002)(7696005)(26005)(36756003)(54906003)(8936002)(6916009)(498600001)(86362001)(336012)(426003)(186003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2021 12:30:08.1863 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 163b9cca-d8a0-4bad-e525-08d97456b9cb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT060.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1870
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

move BO allocation in sw_init.

Signed-off-by: xinhui pan <xinhui.pan@amd.com>
---
change from v1:
only use pre-allocated BO for direct IB submission.
and take its reservation lock to avoid any potential race.
better safe than sorry.
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c | 103 +++++++++++++++++-------
 drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.h |   1 +
 drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c   |   8 +-
 drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c   |   8 +-
 4 files changed, 78 insertions(+), 42 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c
index d451c359606a..04a6f7a18d0a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c
@@ -134,6 +134,51 @@ MODULE_FIRMWARE(FIRMWARE_VEGA12);
 MODULE_FIRMWARE(FIRMWARE_VEGA20);
 
 static void amdgpu_uvd_idle_work_handler(struct work_struct *work);
+static void amdgpu_uvd_force_into_uvd_segment(struct amdgpu_bo *abo);
+
+static int amdgpu_uvd_create_msg_bo_helper(struct amdgpu_device *adev,
+					   uint32_t size,
+					   struct amdgpu_bo **bo_ptr)
+{
+	struct ttm_operation_ctx ctx = { true, false };
+	struct amdgpu_bo *bo = NULL;
+	void *addr;
+	int r;
+
+	r = amdgpu_bo_create_reserved(adev, size, PAGE_SIZE,
+				      AMDGPU_GEM_DOMAIN_GTT,
+				      &bo, NULL, &addr);
+	if (r)
+		return r;
+
+	if (adev->uvd.address_64_bit) {
+		*bo_ptr = bo;
+		return 0;
+	}
+
+	amdgpu_bo_kunmap(bo);
+	amdgpu_bo_unpin(bo);
+	amdgpu_bo_placement_from_domain(bo, AMDGPU_GEM_DOMAIN_VRAM);
+	amdgpu_uvd_force_into_uvd_segment(bo);
+	r = ttm_bo_validate(&bo->tbo, &bo->placement, &ctx);
+	if (r)
+		goto err;
+	r = amdgpu_bo_pin(bo, AMDGPU_GEM_DOMAIN_VRAM);
+	if (r)
+		goto err_pin;
+	r = amdgpu_bo_kmap(bo, &addr);
+	if (r)
+		goto err_kmap;
+	*bo_ptr = bo;
+	return 0;
+err_kmap:
+	amdgpu_bo_unpin(bo);
+err_pin:
+err:
+	amdgpu_bo_unreserve(bo);
+	amdgpu_bo_unref(&bo);
+	return r;
+}
 
 int amdgpu_uvd_sw_init(struct amdgpu_device *adev)
 {
@@ -302,6 +347,11 @@ int amdgpu_uvd_sw_init(struct amdgpu_device *adev)
 	if (!amdgpu_device_ip_block_version_cmp(adev, AMD_IP_BLOCK_TYPE_UVD, 5, 0))
 		adev->uvd.address_64_bit = true;
 
+	r = amdgpu_uvd_create_msg_bo_helper(adev, 128 << 10, &adev->uvd.ib_bo);
+	if (r)
+		return r;
+	amdgpu_bo_unreserve(adev->uvd.ib_bo);
+
 	switch (adev->asic_type) {
 	case CHIP_TONGA:
 		adev->uvd.use_ctx_buf = adev->uvd.fw_version >= FW_1_65_10;
@@ -324,6 +374,7 @@ int amdgpu_uvd_sw_init(struct amdgpu_device *adev)
 
 int amdgpu_uvd_sw_fini(struct amdgpu_device *adev)
 {
+	void *addr = amdgpu_bo_kptr(adev->uvd.ib_bo);
 	int i, j;
 
 	drm_sched_entity_destroy(&adev->uvd.entity);
@@ -342,6 +393,7 @@ int amdgpu_uvd_sw_fini(struct amdgpu_device *adev)
 		for (i = 0; i < AMDGPU_MAX_UVD_ENC_RINGS; ++i)
 			amdgpu_ring_fini(&adev->uvd.inst[j].ring_enc[i]);
 	}
+	amdgpu_bo_free_kernel(&adev->uvd.ib_bo, NULL, &addr);
 	release_firmware(adev->uvd.fw);
 
 	return 0;
@@ -1080,23 +1132,10 @@ static int amdgpu_uvd_send_msg(struct amdgpu_ring *ring, struct amdgpu_bo *bo,
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
-		goto err;
+		return r;
 
 	if (adev->asic_type >= CHIP_VEGA10) {
 		offset_idx = 1 + ring->me;
@@ -1148,8 +1187,6 @@ static int amdgpu_uvd_send_msg(struct amdgpu_ring *ring, struct amdgpu_bo *bo,
 	}
 
 	amdgpu_bo_fence(bo, f, false);
-	amdgpu_bo_unreserve(bo);
-	amdgpu_bo_unref(&bo);
 
 	if (fence)
 		*fence = dma_fence_get(f);
@@ -1159,10 +1196,6 @@ static int amdgpu_uvd_send_msg(struct amdgpu_ring *ring, struct amdgpu_bo *bo,
 
 err_free:
 	amdgpu_job_free(job);
-
-err:
-	amdgpu_bo_unreserve(bo);
-	amdgpu_bo_unref(&bo);
 	return r;
 }
 
@@ -1173,16 +1206,15 @@ int amdgpu_uvd_get_create_msg(struct amdgpu_ring *ring, uint32_t handle,
 			      struct dma_fence **fence)
 {
 	struct amdgpu_device *adev = ring->adev;
-	struct amdgpu_bo *bo = NULL;
+	struct amdgpu_bo *bo = adev->uvd.ib_bo;
 	uint32_t *msg;
 	int r, i;
 
-	r = amdgpu_bo_create_reserved(adev, 1024, PAGE_SIZE,
-				      AMDGPU_GEM_DOMAIN_GTT,
-				      &bo, NULL, (void **)&msg);
+	r = amdgpu_bo_reserve(bo, false);
 	if (r)
 		return r;
 
+	msg = amdgpu_bo_kptr(bo);
 	/* stitch together an UVD create msg */
 	msg[0] = cpu_to_le32(0x00000de4);
 	msg[1] = cpu_to_le32(0x00000000);
@@ -1198,23 +1230,28 @@ int amdgpu_uvd_get_create_msg(struct amdgpu_ring *ring, uint32_t handle,
 	for (i = 11; i < 1024; ++i)
 		msg[i] = cpu_to_le32(0x0);
 
-	return amdgpu_uvd_send_msg(ring, bo, true, fence);
+	r = amdgpu_uvd_send_msg(ring, bo, true, fence);
+
+	amdgpu_bo_unreserve(bo);
+	return r;
 }
 
 int amdgpu_uvd_get_destroy_msg(struct amdgpu_ring *ring, uint32_t handle,
 			       bool direct, struct dma_fence **fence)
 {
 	struct amdgpu_device *adev = ring->adev;
-	struct amdgpu_bo *bo = NULL;
+	struct amdgpu_bo *bo = adev->uvd.ib_bo;
 	uint32_t *msg;
 	int r, i;
 
-	r = amdgpu_bo_create_reserved(adev, 1024, PAGE_SIZE,
-				      AMDGPU_GEM_DOMAIN_GTT,
-				      &bo, NULL, (void **)&msg);
+	if (direct)
+		r = amdgpu_bo_reserve(bo, false);
+	else
+		r = amdgpu_uvd_create_msg_bo_helper(adev, 4096, &bo);
 	if (r)
 		return r;
 
+	msg = amdgpu_bo_kptr(bo);
 	/* stitch together an UVD destroy msg */
 	msg[0] = cpu_to_le32(0x00000de4);
 	msg[1] = cpu_to_le32(0x00000002);
@@ -1223,7 +1260,13 @@ int amdgpu_uvd_get_destroy_msg(struct amdgpu_ring *ring, uint32_t handle,
 	for (i = 4; i < 1024; ++i)
 		msg[i] = cpu_to_le32(0x0);
 
-	return amdgpu_uvd_send_msg(ring, bo, direct, fence);
+	r = amdgpu_uvd_send_msg(ring, bo, direct, fence);
+
+	amdgpu_bo_unreserve(bo);
+	if (!direct)
+		amdgpu_bo_free_kernel(&bo, NULL, (void **)&msg);
+
+	return r;
 }
 
 static void amdgpu_uvd_idle_work_handler(struct work_struct *work)
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.h
index edbb8194ee81..76ac9699885d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.h
@@ -68,6 +68,7 @@ struct amdgpu_uvd {
 	/* store image width to adjust nb memory state */
 	unsigned		decode_image_width;
 	uint32_t                keyselect;
+	struct amdgpu_bo	*ib_bo;
 };
 
 int amdgpu_uvd_sw_init(struct amdgpu_device *adev);
diff --git a/drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c b/drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c
index bc571833632e..4ab62ef6f04a 100644
--- a/drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c
@@ -332,12 +332,10 @@ static int uvd_v6_0_enc_get_destroy_msg(struct amdgpu_ring *ring,
 static int uvd_v6_0_enc_ring_test_ib(struct amdgpu_ring *ring, long timeout)
 {
 	struct dma_fence *fence = NULL;
-	struct amdgpu_bo *bo = NULL;
+	struct amdgpu_bo *bo = ring->adev->uvd.ib_bo;
 	long r;
 
-	r = amdgpu_bo_create_reserved(ring->adev, 128 * 1024, PAGE_SIZE,
-				      AMDGPU_GEM_DOMAIN_VRAM,
-				      &bo, NULL, NULL);
+	r = amdgpu_bo_reserve(bo, false);
 	if (r)
 		return r;
 
@@ -357,9 +355,7 @@ static int uvd_v6_0_enc_ring_test_ib(struct amdgpu_ring *ring, long timeout)
 
 error:
 	dma_fence_put(fence);
-	amdgpu_bo_unpin(bo);
 	amdgpu_bo_unreserve(bo);
-	amdgpu_bo_unref(&bo);
 	return r;
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c b/drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c
index b6e82d75561f..85ad5fb358c8 100644
--- a/drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c
@@ -338,12 +338,10 @@ static int uvd_v7_0_enc_get_destroy_msg(struct amdgpu_ring *ring, uint32_t handl
 static int uvd_v7_0_enc_ring_test_ib(struct amdgpu_ring *ring, long timeout)
 {
 	struct dma_fence *fence = NULL;
-	struct amdgpu_bo *bo = NULL;
+	struct amdgpu_bo *bo = ring->adev->uvd.ib_bo;
 	long r;
 
-	r = amdgpu_bo_create_reserved(ring->adev, 128 * 1024, PAGE_SIZE,
-				      AMDGPU_GEM_DOMAIN_VRAM,
-				      &bo, NULL, NULL);
+	r = amdgpu_bo_reserve(bo, false);
 	if (r)
 		return r;
 
@@ -363,9 +361,7 @@ static int uvd_v7_0_enc_ring_test_ib(struct amdgpu_ring *ring, long timeout)
 
 error:
 	dma_fence_put(fence);
-	amdgpu_bo_unpin(bo);
 	amdgpu_bo_unreserve(bo);
-	amdgpu_bo_unref(&bo);
 	return r;
 }
 
-- 
2.25.1

