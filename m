Return-Path: <SRS0=RbrA=N6=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E881C433F5
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Sep 2021 06:00:50 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 53923610E9
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Sep 2021 06:00:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 53923610E9
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E81C66E10E;
	Wed,  8 Sep 2021 06:00:49 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2074.outbound.protection.outlook.com [40.107.237.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 43CBF6E10E
 for <amd-gfx@lists.freedesktop.org>; Wed,  8 Sep 2021 06:00:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z/LPFXTgeryyqcxFkZ8wyzalUeUARgLEOAwZtCnvGI4NZkj/NJmnXb09Tw0339vnCNfyeBjVLAqMH3FtVeirUlegCgCpKbzAmECUD0PXVhXAtHN8e1a6EwniwLQMmnd+1IMlw0D1L65XxpkJyRPk9J2RJyW5SgwA/EVunKnoKKzTMLbDDijel3wJKl7/2GK+vvDvyF6vuIOKvlcOs1jh2A/scfxlYbSPh9tgpsp/3GuRxlBLkL/mWtVmd/xOJHghb/7hnRFd/qvscAcDRy5BeA86iOiGDAd10QRBStHv3if0jTi7qPX7AFM8C218CMuj8pxijnPPZt5HcrX1l1zACg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=2Fkl6l5JNRJUvL7oTQ2pxHAwdNhCN87gRIoBHPNk5zg=;
 b=MuosXvthOtGHGvG+VuM4+LMRbF2Lwr0BG9iy+D/PT2YabxyKgBn/FSRpDqA4CMQFSMZadJ+BVTw838EldeMZ8ZgoTp+vR+yxlL6TdyTaYud/e0imlmM8hIt0H3JRso3C91gc0+9r4h/cB2+yhUTKFGUnfmD2LN//dnb8/eXHZ4DdqXZODF0iFK56P+Igooq8wkOPc0llSoPsqHkQ3ubc4NvRQ3HqEKTcJkXU5uTNg4RgPgrOaf/Pl+e3SMDeLvRbnJW4OzjstcA2+JVojp25NnZDtUgDrjGdIuxfiGgRehRfxo4VSK+tMuKPlcioZyfj0pJaWskcoCp2NEBs+N3Cnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2Fkl6l5JNRJUvL7oTQ2pxHAwdNhCN87gRIoBHPNk5zg=;
 b=cLQS+Hk2d+hSpml4w78Tv40WB7KGcY9Aeg2pmDpe5qVxMJ/OwBcUR3GJFHSScRlNoXN+YpkMKwPGMRllKtF4eof+2tOJ7aHFumnKoTOd97qbAiDvEk8MVNoeoe2LKtUOMJBowctVm5qIU8RaVZaU/+jEt2ZZAKmJAXCHo1qLdgI=
Received: from DM5PR20CA0026.namprd20.prod.outlook.com (2603:10b6:3:13d::12)
 by DM5PR12MB1580.namprd12.prod.outlook.com (2603:10b6:4:10::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.21; Wed, 8 Sep
 2021 06:00:46 +0000
Received: from DM6NAM11FT022.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:13d:cafe::55) by DM5PR20CA0026.outlook.office365.com
 (2603:10b6:3:13d::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.14 via Frontend
 Transport; Wed, 8 Sep 2021 06:00:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT022.mail.protection.outlook.com (10.13.172.210) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4500.14 via Frontend Transport; Wed, 8 Sep 2021 06:00:46 +0000
Received: from pp-server-two.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Wed, 8 Sep 2021
 01:00:43 -0500
From: xinhui pan <xinhui.pan@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <alexander.deucher@amd.com>, <christian.koenig@amd.com>, xinhui pan
 <xinhui.pan@amd.com>
Subject: [RFC PATCH v2 2/2] drm/amdgpu: IPs use IB test dedicated BO
Date: Wed, 8 Sep 2021 14:00:02 +0800
Message-ID: <20210908060002.15881-2-xinhui.pan@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210908060002.15881-1-xinhui.pan@amd.com>
References: <20210908060002.15881-1-xinhui.pan@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 77ca89c0-4af4-4de4-d863-08d9728e0009
X-MS-TrafficTypeDiagnostic: DM5PR12MB1580:
X-Microsoft-Antispam-PRVS: <DM5PR12MB158027BD050EB2CEFA2ED87287D49@DM5PR12MB1580.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:983;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: G5sveK3LKc5bTmD4z+yfhhxlxJ85VpaVg02BoCbhd7urOWvz4ZYRKSUP4o+bhPNso3UlO3xIef0cdntvHsifVl1lkZyRZysxDQ5NPAaMxo4d6wheCytpBP3RaKOciDA+X88I/V0dqzrSxG2HA61JU+PR9GHrIS9TXNPv2VVLxTQmShXD4GE3SAmCBUlcSsLniPEEu5SSQ8uUllB6fQyRC9WGpXvD6I/GvBcRhW05phuPq+fJHFa+b25CrTJmdHNqnwjpDZp81LYCrPeaVmVs2FlCZXYNkaWvnNq71gjNpyCZqXIqTmyj7mPyowkjJkRE9Ukkc2GHGfk2U2FoJ2ncaOYsjYbdWJqL1lWrKrhyrsbjcmJl0q3ZG9I3VAGim1z3daSnEsnBXBRk3F6fnmHjHco/pkmPhY3I2e2SvLXVrc0sbItNloCPo7SMmt5R+zCb19KBkxI979rQBAGsuulaTX71cWUxCUsYnxvnpN55IvdVIJqKm1wODXjS4wUXHXqgqbMV0lgDbxlQ+JfdI891HaZckgSUiGBkpHnuAwQZFSapTTL7yJ5MglX8aaZHA6Zngkjc+Gt0Nsu5Ka1mXvdINIGNBTqikBkU3vXU1ls8v0O5g5a2O9rBVOVHf+gr26gWc/EK3lstix3HdmQpDmz51Z99mvpwWRsNjd1OxWOpZpHqBL4QeKZ2Pb6JWVDD6o7fl5d20JoChJHAyMbbAuIAjfh9wgJVrBUrY6hoQblQc3w=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(346002)(39860400002)(376002)(136003)(396003)(46966006)(36840700001)(81166007)(36756003)(356005)(1076003)(47076005)(30864003)(82740400003)(336012)(36860700001)(4326008)(70586007)(8676002)(7696005)(8936002)(70206006)(2616005)(6666004)(478600001)(54906003)(26005)(82310400003)(6916009)(83380400001)(316002)(86362001)(2906002)(186003)(16526019)(5660300002)(426003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2021 06:00:46.0294 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 77ca89c0-4af4-4de4-d863-08d9728e0009
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT022.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1580
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

Let vce/uvd/vcn use it to avoid memory allocation during IB test.
This is useful when memory is nearly used up and no BO can be
evicted/swappout.

Signed-off-by: xinhui pan <xinhui.pan@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c |  51 ++++-------
 drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c |   9 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c | 113 ++++++++++++------------
 drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c   |  10 +--
 drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c   |  10 +--
 5 files changed, 89 insertions(+), 104 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c
index d451c359606a..573ab1d69bd7 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c
@@ -1080,23 +1080,10 @@ static int amdgpu_uvd_send_msg(struct amdgpu_ring *ring, struct amdgpu_bo *bo,
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
@@ -1148,8 +1135,6 @@ static int amdgpu_uvd_send_msg(struct amdgpu_ring *ring, struct amdgpu_bo *bo,
 	}
 
 	amdgpu_bo_fence(bo, f, false);
-	amdgpu_bo_unreserve(bo);
-	amdgpu_bo_unref(&bo);
 
 	if (fence)
 		*fence = dma_fence_get(f);
@@ -1159,10 +1144,6 @@ static int amdgpu_uvd_send_msg(struct amdgpu_ring *ring, struct amdgpu_bo *bo,
 
 err_free:
 	amdgpu_job_free(job);
-
-err:
-	amdgpu_bo_unreserve(bo);
-	amdgpu_bo_unref(&bo);
 	return r;
 }
 
@@ -1177,11 +1158,12 @@ int amdgpu_uvd_get_create_msg(struct amdgpu_ring *ring, uint32_t handle,
 	uint32_t *msg;
 	int r, i;
 
-	r = amdgpu_bo_create_reserved(adev, 1024, PAGE_SIZE,
-				      AMDGPU_GEM_DOMAIN_GTT,
-				      &bo, NULL, (void **)&msg);
-	if (r)
-		return r;
+	if (!ring->adev->uvd.address_64_bit)
+		bo = adev->ib_test_vram_bo;
+	else
+		bo = adev->ib_test_gtt_bo;
+	amdgpu_bo_reserve(bo, true);
+	msg = amdgpu_bo_kptr(bo);
 
 	/* stitch together an UVD create msg */
 	msg[0] = cpu_to_le32(0x00000de4);
@@ -1198,7 +1180,9 @@ int amdgpu_uvd_get_create_msg(struct amdgpu_ring *ring, uint32_t handle,
 	for (i = 11; i < 1024; ++i)
 		msg[i] = cpu_to_le32(0x0);
 
-	return amdgpu_uvd_send_msg(ring, bo, true, fence);
+	r = amdgpu_uvd_send_msg(ring, bo, true, fence);
+	amdgpu_bo_unreserve(bo);
+	return r;
 }
 
 int amdgpu_uvd_get_destroy_msg(struct amdgpu_ring *ring, uint32_t handle,
@@ -1209,11 +1193,12 @@ int amdgpu_uvd_get_destroy_msg(struct amdgpu_ring *ring, uint32_t handle,
 	uint32_t *msg;
 	int r, i;
 
-	r = amdgpu_bo_create_reserved(adev, 1024, PAGE_SIZE,
-				      AMDGPU_GEM_DOMAIN_GTT,
-				      &bo, NULL, (void **)&msg);
-	if (r)
-		return r;
+	if (!ring->adev->uvd.address_64_bit)
+		bo = adev->ib_test_vram_bo;
+	else
+		bo = adev->ib_test_gtt_bo;
+	amdgpu_bo_reserve(bo, true);
+	msg = amdgpu_bo_kptr(bo);
 
 	/* stitch together an UVD destroy msg */
 	msg[0] = cpu_to_le32(0x00000de4);
@@ -1223,7 +1208,9 @@ int amdgpu_uvd_get_destroy_msg(struct amdgpu_ring *ring, uint32_t handle,
 	for (i = 4; i < 1024; ++i)
 		msg[i] = cpu_to_le32(0x0);
 
-	return amdgpu_uvd_send_msg(ring, bo, direct, fence);
+	r = amdgpu_uvd_send_msg(ring, bo, direct, fence);
+	amdgpu_bo_unreserve(bo);
+	return r;
 }
 
 static void amdgpu_uvd_idle_work_handler(struct work_struct *work)
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c
index e9fdf49d69e8..70af6afbbbb6 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c
@@ -1141,11 +1141,11 @@ int amdgpu_vce_ring_test_ib(struct amdgpu_ring *ring, long timeout)
 	if (ring != &ring->adev->vce.ring[0])
 		return 0;
 
-	r = amdgpu_bo_create_reserved(ring->adev, 512, PAGE_SIZE,
-				      AMDGPU_GEM_DOMAIN_VRAM,
-				      &bo, NULL, NULL);
+	bo = ring->adev->ib_test_vram_bo;
+	amdgpu_bo_reserve(bo, true);
+	r = ttm_bo_wait(&bo->tbo, false, false);
 	if (r)
-		return r;
+		goto error;
 
 	r = amdgpu_vce_get_create_msg(ring, 1, bo, NULL);
 	if (r)
@@ -1164,7 +1164,6 @@ int amdgpu_vce_ring_test_ib(struct amdgpu_ring *ring, long timeout)
 error:
 	dma_fence_put(fence);
 	amdgpu_bo_unreserve(bo);
-	amdgpu_bo_free_kernel(&bo, NULL, NULL);
 	return r;
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
index 561296a85b43..b150d5a5db73 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
@@ -577,8 +577,6 @@ static int amdgpu_vcn_dec_send_msg(struct amdgpu_ring *ring,
 		goto err_free;
 
 	amdgpu_bo_fence(bo, f, false);
-	amdgpu_bo_unreserve(bo);
-	amdgpu_bo_free_kernel(&bo, NULL, (void **)&msg);
 
 	if (fence)
 		*fence = dma_fence_get(f);
@@ -588,26 +586,15 @@ static int amdgpu_vcn_dec_send_msg(struct amdgpu_ring *ring,
 
 err_free:
 	amdgpu_job_free(job);
-
 err:
-	amdgpu_bo_unreserve(bo);
-	amdgpu_bo_free_kernel(&bo, NULL, (void **)&msg);
 	return r;
 }
 
-static int amdgpu_vcn_dec_get_create_msg(struct amdgpu_ring *ring, uint32_t handle,
-					 struct amdgpu_bo **bo)
+static void amdgpu_vcn_dec_get_create_msg(struct amdgpu_ring *ring, uint32_t handle,
+					 struct amdgpu_bo *bo)
 {
-	struct amdgpu_device *adev = ring->adev;
-	uint32_t *msg;
-	int r, i;
-
-	*bo = NULL;
-	r = amdgpu_bo_create_reserved(adev, 1024, PAGE_SIZE,
-				      AMDGPU_GEM_DOMAIN_VRAM,
-				      bo, NULL, (void **)&msg);
-	if (r)
-		return r;
+	uint32_t *msg = amdgpu_bo_kptr(bo);
+	int i;
 
 	msg[0] = cpu_to_le32(0x00000028);
 	msg[1] = cpu_to_le32(0x00000038);
@@ -625,23 +612,13 @@ static int amdgpu_vcn_dec_get_create_msg(struct amdgpu_ring *ring, uint32_t hand
 	msg[13] = cpu_to_le32(0x00000440);
 	for (i = 14; i < 1024; ++i)
 		msg[i] = cpu_to_le32(0x0);
-
-	return 0;
 }
 
-static int amdgpu_vcn_dec_get_destroy_msg(struct amdgpu_ring *ring, uint32_t handle,
-					  struct amdgpu_bo **bo)
+static void amdgpu_vcn_dec_get_destroy_msg(struct amdgpu_ring *ring, uint32_t handle,
+					  struct amdgpu_bo *bo)
 {
-	struct amdgpu_device *adev = ring->adev;
-	uint32_t *msg;
-	int r, i;
-
-	*bo = NULL;
-	r = amdgpu_bo_create_reserved(adev, 1024, PAGE_SIZE,
-				      AMDGPU_GEM_DOMAIN_VRAM,
-				      bo, NULL, (void **)&msg);
-	if (r)
-		return r;
+	uint32_t *msg = amdgpu_bo_kptr(bo);
+	int i;
 
 	msg[0] = cpu_to_le32(0x00000028);
 	msg[1] = cpu_to_le32(0x00000018);
@@ -651,8 +628,6 @@ static int amdgpu_vcn_dec_get_destroy_msg(struct amdgpu_ring *ring, uint32_t han
 	msg[5] = cpu_to_le32(0x00000000);
 	for (i = 6; i < 1024; ++i)
 		msg[i] = cpu_to_le32(0x0);
-
-	return 0;
 }
 
 int amdgpu_vcn_dec_ring_test_ib(struct amdgpu_ring *ring, long timeout)
@@ -661,17 +636,29 @@ int amdgpu_vcn_dec_ring_test_ib(struct amdgpu_ring *ring, long timeout)
 	struct amdgpu_bo *bo;
 	long r;
 
-	r = amdgpu_vcn_dec_get_create_msg(ring, 1, &bo);
+	bo = ring->adev->ib_test_vram_bo;
+	amdgpu_bo_reserve(bo, true);
+	r = ttm_bo_wait(&bo->tbo, false, false);
 	if (r)
 		goto error;
 
-	r = amdgpu_vcn_dec_send_msg(ring, bo, NULL);
+	amdgpu_vcn_dec_get_create_msg(ring, 1, bo);
+
+	r = amdgpu_vcn_dec_send_msg(ring, bo, &fence);
 	if (r)
 		goto error;
-	r = amdgpu_vcn_dec_get_destroy_msg(ring, 1, &bo);
-	if (r)
+
+	r = dma_fence_wait_timeout(fence, false, timeout);
+	if (r == 0)
+		r = -ETIMEDOUT;
+	if (r < 0)
 		goto error;
 
+	dma_fence_put(fence);
+	fence = NULL;
+
+	amdgpu_vcn_dec_get_destroy_msg(ring, 1, bo);
+
 	r = amdgpu_vcn_dec_send_msg(ring, bo, &fence);
 	if (r)
 		goto error;
@@ -681,9 +668,9 @@ int amdgpu_vcn_dec_ring_test_ib(struct amdgpu_ring *ring, long timeout)
 		r = -ETIMEDOUT;
 	else if (r > 0)
 		r = 0;
-
-	dma_fence_put(fence);
 error:
+	dma_fence_put(fence);
+	amdgpu_bo_unreserve(bo);
 	return r;
 }
 
@@ -727,8 +714,6 @@ static int amdgpu_vcn_dec_sw_send_msg(struct amdgpu_ring *ring,
 		goto err_free;
 
 	amdgpu_bo_fence(bo, f, false);
-	amdgpu_bo_unreserve(bo);
-	amdgpu_bo_unref(&bo);
 
 	if (fence)
 		*fence = dma_fence_get(f);
@@ -738,10 +723,7 @@ static int amdgpu_vcn_dec_sw_send_msg(struct amdgpu_ring *ring,
 
 err_free:
 	amdgpu_job_free(job);
-
 err:
-	amdgpu_bo_unreserve(bo);
-	amdgpu_bo_unref(&bo);
 	return r;
 }
 
@@ -751,17 +733,29 @@ int amdgpu_vcn_dec_sw_ring_test_ib(struct amdgpu_ring *ring, long timeout)
 	struct amdgpu_bo *bo;
 	long r;
 
-	r = amdgpu_vcn_dec_get_create_msg(ring, 1, &bo);
+	bo = ring->adev->ib_test_vram_bo;
+	amdgpu_bo_reserve(bo, true);
+	r = ttm_bo_wait(&bo->tbo, false, false);
 	if (r)
 		goto error;
 
-	r = amdgpu_vcn_dec_sw_send_msg(ring, bo, NULL);
+	amdgpu_vcn_dec_get_create_msg(ring, 1, bo);
+
+	r = amdgpu_vcn_dec_sw_send_msg(ring, bo, &fence);
 	if (r)
 		goto error;
-	r = amdgpu_vcn_dec_get_destroy_msg(ring, 1, &bo);
-	if (r)
+
+	r = dma_fence_wait_timeout(fence, false, timeout);
+	if (r == 0)
+		r = -ETIMEDOUT;
+	if (r < 0)
 		goto error;
 
+	dma_fence_put(fence);
+	fence = NULL;
+
+	amdgpu_vcn_dec_get_destroy_msg(ring, 1, bo);
+
 	r = amdgpu_vcn_dec_sw_send_msg(ring, bo, &fence);
 	if (r)
 		goto error;
@@ -772,8 +766,9 @@ int amdgpu_vcn_dec_sw_ring_test_ib(struct amdgpu_ring *ring, long timeout)
 	else if (r > 0)
 		r = 0;
 
-	dma_fence_put(fence);
 error:
+	dma_fence_put(fence);
+	amdgpu_bo_unreserve(bo);
 	return r;
 }
 
@@ -922,16 +917,25 @@ int amdgpu_vcn_enc_ring_test_ib(struct amdgpu_ring *ring, long timeout)
 	struct amdgpu_bo *bo = NULL;
 	long r;
 
-	r = amdgpu_bo_create_reserved(ring->adev, 128 * 1024, PAGE_SIZE,
-				      AMDGPU_GEM_DOMAIN_VRAM,
-				      &bo, NULL, NULL);
+	bo = ring->adev->ib_test_vram_bo;
+	amdgpu_bo_reserve(bo, true);
+	r = ttm_bo_wait(&bo->tbo, false, false);
 	if (r)
-		return r;
+		goto error;
 
-	r = amdgpu_vcn_enc_get_create_msg(ring, 1, bo, NULL);
+	r = amdgpu_vcn_enc_get_create_msg(ring, 1, bo, &fence);
 	if (r)
 		goto error;
 
+	r = dma_fence_wait_timeout(fence, false, timeout);
+	if (r == 0)
+		r = -ETIMEDOUT;
+	if (r < 0)
+		goto error;
+
+	dma_fence_put(fence);
+	fence = NULL;
+
 	r = amdgpu_vcn_enc_get_destroy_msg(ring, 1, bo, &fence);
 	if (r)
 		goto error;
@@ -945,7 +949,6 @@ int amdgpu_vcn_enc_ring_test_ib(struct amdgpu_ring *ring, long timeout)
 error:
 	dma_fence_put(fence);
 	amdgpu_bo_unreserve(bo);
-	amdgpu_bo_free_kernel(&bo, NULL, NULL);
 
 	return r;
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c b/drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c
index bc571833632e..0ce8fcc318d3 100644
--- a/drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c
@@ -335,11 +335,11 @@ static int uvd_v6_0_enc_ring_test_ib(struct amdgpu_ring *ring, long timeout)
 	struct amdgpu_bo *bo = NULL;
 	long r;
 
-	r = amdgpu_bo_create_reserved(ring->adev, 128 * 1024, PAGE_SIZE,
-				      AMDGPU_GEM_DOMAIN_VRAM,
-				      &bo, NULL, NULL);
+	bo = ring->adev->ib_test_vram_bo;
+	amdgpu_bo_reserve(bo, true);
+	r = ttm_bo_wait(&bo->tbo, false, false);
 	if (r)
-		return r;
+		goto error;
 
 	r = uvd_v6_0_enc_get_create_msg(ring, 1, bo, NULL);
 	if (r)
@@ -357,9 +357,7 @@ static int uvd_v6_0_enc_ring_test_ib(struct amdgpu_ring *ring, long timeout)
 
 error:
 	dma_fence_put(fence);
-	amdgpu_bo_unpin(bo);
 	amdgpu_bo_unreserve(bo);
-	amdgpu_bo_unref(&bo);
 	return r;
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c b/drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c
index b6e82d75561f..6d26c80df960 100644
--- a/drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c
@@ -341,11 +341,11 @@ static int uvd_v7_0_enc_ring_test_ib(struct amdgpu_ring *ring, long timeout)
 	struct amdgpu_bo *bo = NULL;
 	long r;
 
-	r = amdgpu_bo_create_reserved(ring->adev, 128 * 1024, PAGE_SIZE,
-				      AMDGPU_GEM_DOMAIN_VRAM,
-				      &bo, NULL, NULL);
+	bo = ring->adev->ib_test_vram_bo;
+	amdgpu_bo_reserve(bo, true);
+	r = ttm_bo_wait(&bo->tbo, false, false);
 	if (r)
-		return r;
+		goto error;
 
 	r = uvd_v7_0_enc_get_create_msg(ring, 1, bo, NULL);
 	if (r)
@@ -363,9 +363,7 @@ static int uvd_v7_0_enc_ring_test_ib(struct amdgpu_ring *ring, long timeout)
 
 error:
 	dma_fence_put(fence);
-	amdgpu_bo_unpin(bo);
 	amdgpu_bo_unreserve(bo);
-	amdgpu_bo_unref(&bo);
 	return r;
 }
 
-- 
2.25.1

