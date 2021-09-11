Return-Path: <SRS0=1siV=OB=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E01FDC433EF
	for <amd-gfx@archiver.kernel.org>; Sat, 11 Sep 2021 01:34:41 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 912846120A
	for <amd-gfx@archiver.kernel.org>; Sat, 11 Sep 2021 01:34:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 912846120A
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8ECDC6EB20;
	Sat, 11 Sep 2021 01:34:40 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2076.outbound.protection.outlook.com [40.107.94.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6865E6EB20
 for <amd-gfx@lists.freedesktop.org>; Sat, 11 Sep 2021 01:34:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ScF0VnLea1pI52RdKpCa9GlKq/doSXCtoNjA5QKUAMYMK9FrmStWsahc+rbvPXpJp8rqUQ84eESd1RLw00tcKlRqdI80MqGmd4LnSd0ITN9agUhWKsuhrpC5xO1dOgTXeGTpP3gY0wzX4F/9K2hvCAQbFEdN/K2caxn7WhRGTF/06ujiyc8nzD7ltJpKFsx6gAq+j14a7xdkgTsXjDFK9soa8DUxH4i7oIZfK/RULalgry549qS10pE4Fgabd8tuutfQoNJUTRh4l87beGsZc2CLkvk+/pX7F+MizoiHVScQzQMpavLSFDMJY/CrVsUNW0QH20S6NIHAJCI07SArew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=CugdGIoGSPDBJN47HtL6yS6DhkWJwLbKIa721JHJjus=;
 b=fEyIVj0bhD1MDDLCvXVrdPImMWV1x9JmFwjCrvd1oVsUzpGlWD9IxL+bjDVOgKiPev7oFW0mmhJDz+scUxLlmGq0sF5KI3F19DpG8WrfIPhayMzWvHDDUUZYUuhWpaVX6FlCw0JhxjcGhYGZlm5YtbGjr/fHsP7IVhBPXjusoidrPObj7DLU59Xl20fHjM4Vr6DVvRASpCGg2OWfh6Nxm/i6eS1ns1dPtSYXGLEcHGhtNxM0oVidn97eiFVNdetONhsgQuEFPo/+J4LB28IosiaEbevlRCYOesLl5k/sychMlhO1DorfPHzqtOt9OWjbaF36pPPFbX1Qu1EgQ1WNoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CugdGIoGSPDBJN47HtL6yS6DhkWJwLbKIa721JHJjus=;
 b=DruyOWXR4Ct0jLRLOA3wdA74S/xQjPB608KbBD/fw6NSA/z0LWdzT2JJSiej9Vl0iQoi0Ei+AXYSfpKYCUcGvKcb76HStx/GfqwJDLhuIw1VNA/bDcF0vic2b9O9JBlIpcHzuhgTHGtgJstPYcVPUu7uQXEsk78hdxhuEuyYSfc=
Received: from MW3PR05CA0001.namprd05.prod.outlook.com (2603:10b6:303:2b::6)
 by MN2PR12MB3392.namprd12.prod.outlook.com (2603:10b6:208:cb::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.17; Sat, 11 Sep
 2021 01:34:37 +0000
Received: from CO1NAM11FT015.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:2b:cafe::31) by MW3PR05CA0001.outlook.office365.com
 (2603:10b6:303:2b::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.8 via Frontend
 Transport; Sat, 11 Sep 2021 01:34:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT015.mail.protection.outlook.com (10.13.175.130) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4500.14 via Frontend Transport; Sat, 11 Sep 2021 01:34:36 +0000
Received: from pp-server-two.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Fri, 10 Sep
 2021 20:34:33 -0500
From: xinhui pan <xinhui.pan@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <alexander.deucher@amd.com>, <christian.koenig@amd.com>, xinhui pan
 <xinhui.pan@amd.com>
Subject: [PATCH v3 1/3] drm/amdgpu: UVD avoid memory allocation during IB test
Date: Sat, 11 Sep 2021 09:34:19 +0800
Message-ID: <20210911013421.5213-1-xinhui.pan@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 98212f80-dcb9-4afc-71ed-08d974c450e8
X-MS-TrafficTypeDiagnostic: MN2PR12MB3392:
X-Microsoft-Antispam-PRVS: <MN2PR12MB3392D98E017588E71DE1EFB787D79@MN2PR12MB3392.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0jyxeYEQXENNR485OAJ9wtRAmBXMj9x+iGFmCw0dM1q5cxXAVAKdXY9iQC/8NbV88nDbTzfXKLyIZwEJWzZyK+oBID3MsjmzDi+hhZehHa/0vEXZUDtthoihCTulYTCXXrM3A3K4yfIlct3K54UD68ZIYgrKCRnFQr4mHlkgsxkNk9n8VICF18i/IPUQrvz3tLaUUXa6UkZlYjmVDbmJ9KNd4TrwQ4+zYzwh/c6kkD21ygBaTTYaEjLxJkidAg1WK8xa0krnjhoTgRgrzyDCbzAWqIZE9Ve6dtzpVlnj5QoK+OK6BrY5BD98Uv+rBBFgNZo7KdH8IAG0ezyVUqsUKTF9P+VygrCoTEDHJX5LevuUJT2v0liC2v8hqZpHsjMi20sYU1fCmxBYbc/hBD/LC3TwqcJrPwHHVUYAvdgHLVI5qbHc4p9Ie772c3+U4BUMBHJA9isKufotvGGfUryF+qeyjzNokBCXhz1E+5nBycwzRNsSs01VofKwu0FfwAApow4M5cw8JKt9d90TSGdztVx7KO9FkMssIF7d5Vwq8uBvmoC66d9STH9A90hLCxO+DIUG9qvCdEg5ggsPx1FTDBfMnjp3u2yxlfY3hImk1UqgARZoiF6aKhqVwT1Tm6+hckLcijEIs+U/qDCVyGTcM5dT//u+QV+HU7cO0rq2XgrPNkreaC3HqtqU+7uOjg6DtsVttGaDTCcUvRC0M7g6pHygnFS1VAiFMxYRbXYjqeU=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(396003)(39860400002)(136003)(376002)(346002)(46966006)(36840700001)(2616005)(4326008)(336012)(8936002)(7696005)(82310400003)(47076005)(1076003)(81166007)(36756003)(2906002)(54906003)(316002)(26005)(36860700001)(86362001)(70206006)(426003)(356005)(82740400003)(16526019)(6666004)(186003)(5660300002)(70586007)(8676002)(6916009)(83380400001)(478600001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2021 01:34:36.7781 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 98212f80-dcb9-4afc-71ed-08d974c450e8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT015.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3392
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
change from v2:
use reservation trylock for direct IB test.
change from v1:
only use pre-allocated BO for direct IB submission.
and take its reservation lock to avoid any potential race.
better safe than sorry.
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c | 104 +++++++++++++++++-------
 drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.h |   1 +
 drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c   |   8 +-
 drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c   |   8 +-
 4 files changed, 79 insertions(+), 42 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c
index d451c359606a..a4b3dd6b38c6 100644
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
 
@@ -1173,16 +1206,16 @@ int amdgpu_uvd_get_create_msg(struct amdgpu_ring *ring, uint32_t handle,
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
+	/* Direct IB submission should be exclusive. */
+	r = WARN_ON_ONCE(ttm_bo_reserve(&bo->tbo, true, true, NULL));
 	if (r)
 		return r;
 
+	msg = amdgpu_bo_kptr(bo);
 	/* stitch together an UVD create msg */
 	msg[0] = cpu_to_le32(0x00000de4);
 	msg[1] = cpu_to_le32(0x00000000);
@@ -1198,23 +1231,28 @@ int amdgpu_uvd_get_create_msg(struct amdgpu_ring *ring, uint32_t handle,
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
+		r = WARN_ON_ONCE(ttm_bo_reserve(&bo->tbo, true, true, NULL));
+	else
+		r = amdgpu_uvd_create_msg_bo_helper(adev, 4096, &bo);
 	if (r)
 		return r;
 
+	msg = amdgpu_bo_kptr(bo);
 	/* stitch together an UVD destroy msg */
 	msg[0] = cpu_to_le32(0x00000de4);
 	msg[1] = cpu_to_le32(0x00000002);
@@ -1223,7 +1261,13 @@ int amdgpu_uvd_get_destroy_msg(struct amdgpu_ring *ring, uint32_t handle,
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
index bc571833632e..dd92d96dd5a2 100644
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
+	r = WARN_ON_ONCE(ttm_bo_reserve(&bo->tbo, true, true, NULL));
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
index b6e82d75561f..271122cf2237 100644
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
+	r = WARN_ON_ONCE(ttm_bo_reserve(&bo->tbo, true, true, NULL));
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

