Return-Path: <SRS0=y1ja=OA=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57722C433EF
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Sep 2021 00:38:52 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 208A661074
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Sep 2021 00:38:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 208A661074
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8C5F66E94A;
	Fri, 10 Sep 2021 00:38:50 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2079.outbound.protection.outlook.com [40.107.220.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DA9C36E94A
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Sep 2021 00:38:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fV1+ojG/tabpmhjovHlzvdPqbKRIYeqKzc1nCduhH9yZSGg9TzHntoioYcrdAT95ErKrLNWXgm5C8p02iVdKBZnUon2UnvGqkXRGdyqyED2B3vFtlGs9zCzD36SXeaM1a2cjBxhsd+N9OA4vLikIsBLbzjptrZbUv3ijyBrGrGJdEx8TKLIAPMoBBsJvTC3H0Z7EmpP/wA77lc7yzHXKVTthfNE9GT72FF6AfjR6JYeHHvbxCeTg5gc2W4Udo98P8QIFLbKSSUVL/mwtmYXr06V6VZ45hOfGMsCV79q4T+wFeNdZkongsAPergESGj7JsxUAbywHqPCH/FOTFWKdPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=fLDBP3vR8hOtUl/d7VyGOYtDqXa73dv7VhDeHYc/2T8=;
 b=TdTj2ACrJFeZWM+ck6NxrxjnSUVY20s6zi7lR9aE4ZtuD615cPqWaZZbz8iHLMUsjp47AUHhvsXh9IMPQYqZeCvUf7IEe61+/yn32IjocLXZUrkm5tkcdPPKfrFzbHEghHoe7pJrR/Qi9JgO2Pht5GILtQist8hdpXR+KysVhyAKAKdliMM7G+mJZnmc3eEdNUMNiEj+ClwuPa68KXL1rhtCamhsVdZi1+3KzxbSnh/yjO3gZM5QpBuxlpLRlCigz+CN2wQYQtNh177ddikRrE0BysuiqDHrO4IcldqKcMYBrF5iSZsa46KmjFaDtuNdgelekXS9H7Pvje8M+RhR0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fLDBP3vR8hOtUl/d7VyGOYtDqXa73dv7VhDeHYc/2T8=;
 b=tlX5PIQtZjgJkvOiA3uIQd2690+a7T4ysO0PSepdoQgElZKbHtE7ZjhPhJWVjm25P1pYjKcW50jrdsKWKXq+1MY0UODhh2ZVIXo8VjmiHEM49Sc8tdlVETGzr6du21x2Lk6iwsHZ1J6BfkZLufSWhI6GhQh0tKM8NK8ZnrT+0YI=
Received: from DM5PR13CA0023.namprd13.prod.outlook.com (2603:10b6:3:23::33) by
 MWHPR12MB1503.namprd12.prod.outlook.com (2603:10b6:301:b::19) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4500.14; Fri, 10 Sep 2021 00:38:46 +0000
Received: from DM6NAM11FT050.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:23:cafe::12) by DM5PR13CA0023.outlook.office365.com
 (2603:10b6:3:23::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.9 via Frontend
 Transport; Fri, 10 Sep 2021 00:38:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT050.mail.protection.outlook.com (10.13.173.111) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4500.14 via Frontend Transport; Fri, 10 Sep 2021 00:38:45 +0000
Received: from pp-server-two.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Thu, 9 Sep 2021
 19:38:44 -0500
From: xinhui pan <xinhui.pan@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <alexander.deucher@amd.com>, <christian.koenig@amd.com>, xinhui pan
 <xinhui.pan@amd.com>
Subject: [PATCH 2/4] drm/amdgpu: UVD avoid memory allocation during IB test
Date: Fri, 10 Sep 2021 08:38:26 +0800
Message-ID: <20210910003828.4013-2-xinhui.pan@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: 9d2b1351-d7d4-4479-337b-08d973f3591a
X-MS-TrafficTypeDiagnostic: MWHPR12MB1503:
X-Microsoft-Antispam-PRVS: <MWHPR12MB15035047955FA54D9E92BE2F87D69@MWHPR12MB1503.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:935;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tjSjW3E0f3BEHa0RtSsJ2JxI1knX82IcXMJExcJHoLfWr5+/Z5gZx0qiRSuhxxT62DGzG62u/S9b3sTQA2j81FRtc54TBKU36JKGxd3suV5W0rWadX4b31Tk1Vfak55ZqqKZJvYBkvLBnVsN8at5d3Hv+45ovOTrR+92jsQpDH82fDfKPDrCR4HRPsd6eaSbBB4Xz6k67GUBry5ZsXWkLzBogIhNBIEvDT8134JnSZKs4y5S6/JyLNFQdBwmZSaHBQQMqPwtskjDljkBvQ1z8Eso5J3mpwU1YiKS9TVB6fzHlb5uqo0ueVWuf7I3Uvv4gbNR5QMXDyCIsUdaKmT/RIoCs9+H5p1H0/dgFZOvk32E/XeOt0HNqeukMTmV8PboI+XcbiGVjbz46p0Mbqp/qDOvPe2KtfKLLfesAgdOIT7SV7poW3zjAFizJf2PzgCLjnbwQHkE8yeJqNIAncTJz75YNBzp74GhcqwrXWE/DCsPmiZybSB2EXGAmUvlSYVORgDt+m4e4v1EFdezM1A5kpDFuaHux5gmRS/k/fudVJy02SmanmtB+ndgun5N/eRAkLVft67k/BWCamGFGYvX33br0/ehWP67/lVkHcDasdoLrZTBYC//m92axSjLkacztDUdGJGuyS4EdZREu2puwomuDt3chQf9bE2/Yu90jFv2qzXiXiP2UsxVyWBWucTuEB+Fq10J+qBnuGXEaczKQN+hN0Wh2AYsnYNoZRHSIYE=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(39860400002)(396003)(136003)(376002)(346002)(46966006)(36840700001)(86362001)(336012)(81166007)(54906003)(5660300002)(478600001)(6666004)(70586007)(26005)(70206006)(4326008)(426003)(186003)(36756003)(36860700001)(8936002)(1076003)(356005)(7696005)(2906002)(16526019)(47076005)(316002)(6916009)(82310400003)(83380400001)(82740400003)(8676002)(2616005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2021 00:38:45.7812 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d2b1351-d7d4-4479-337b-08d973f3591a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT050.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1503
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
 drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c | 75 +++++++++++++++----------
 drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.h |  1 +
 drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c   |  8 +--
 drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c   |  8 +--
 4 files changed, 49 insertions(+), 43 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c
index d451c359606a..e2eaac941d37 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c
@@ -141,6 +141,8 @@ int amdgpu_uvd_sw_init(struct amdgpu_device *adev)
 	const char *fw_name;
 	const struct common_firmware_header *hdr;
 	unsigned family_id;
+	struct amdgpu_bo *bo = NULL;
+	void *addr;
 	int i, j, r;
 
 	INIT_DELAYED_WORK(&adev->uvd.idle_work, amdgpu_uvd_idle_work_handler);
@@ -298,9 +300,34 @@ int amdgpu_uvd_sw_init(struct amdgpu_device *adev)
 		adev->uvd.filp[i] = NULL;
 	}
 
+	r = amdgpu_bo_create_reserved(adev, 128 << 10, PAGE_SIZE,
+			AMDGPU_GEM_DOMAIN_GTT,
+			&bo, NULL, &addr);
+	if (r)
+		return r;
+
 	/* from uvd v5.0 HW addressing capacity increased to 64 bits */
-	if (!amdgpu_device_ip_block_version_cmp(adev, AMD_IP_BLOCK_TYPE_UVD, 5, 0))
+	if (!amdgpu_device_ip_block_version_cmp(adev, AMD_IP_BLOCK_TYPE_UVD, 5, 0)) {
 		adev->uvd.address_64_bit = true;
+		amdgpu_bo_kunmap(bo);
+		amdgpu_bo_unpin(bo);
+		r = amdgpu_bo_pin_restricted(bo, AMDGPU_GEM_DOMAIN_VRAM,
+				0, 256 << 20);
+		if (r) {
+			amdgpu_bo_unreserve(bo);
+			amdgpu_bo_unref(&bo);
+			return r;
+		}
+		r = amdgpu_bo_kmap(bo, &addr);
+		if (r) {
+			amdgpu_bo_unpin(bo);
+			amdgpu_bo_unreserve(bo);
+			amdgpu_bo_unref(&bo);
+			return r;
+		}
+	}
+	adev->uvd.ib_bo = bo;
+	amdgpu_bo_unreserve(bo);
 
 	switch (adev->asic_type) {
 	case CHIP_TONGA:
@@ -342,6 +369,7 @@ int amdgpu_uvd_sw_fini(struct amdgpu_device *adev)
 		for (i = 0; i < AMDGPU_MAX_UVD_ENC_RINGS; ++i)
 			amdgpu_ring_fini(&adev->uvd.inst[j].ring_enc[i]);
 	}
+	amdgpu_bo_free_kernel(&adev->uvd.ib_bo, NULL, NULL);
 	release_firmware(adev->uvd.fw);
 
 	return 0;
@@ -1080,23 +1108,10 @@ static int amdgpu_uvd_send_msg(struct amdgpu_ring *ring, struct amdgpu_bo *bo,
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
@@ -1148,8 +1163,6 @@ static int amdgpu_uvd_send_msg(struct amdgpu_ring *ring, struct amdgpu_bo *bo,
 	}
 
 	amdgpu_bo_fence(bo, f, false);
-	amdgpu_bo_unreserve(bo);
-	amdgpu_bo_unref(&bo);
 
 	if (fence)
 		*fence = dma_fence_get(f);
@@ -1159,10 +1172,6 @@ static int amdgpu_uvd_send_msg(struct amdgpu_ring *ring, struct amdgpu_bo *bo,
 
 err_free:
 	amdgpu_job_free(job);
-
-err:
-	amdgpu_bo_unreserve(bo);
-	amdgpu_bo_unref(&bo);
 	return r;
 }
 
@@ -1173,16 +1182,15 @@ int amdgpu_uvd_get_create_msg(struct amdgpu_ring *ring, uint32_t handle,
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
+	r = ttm_bo_reserve(&bo->tbo, true, true, NULL);
 	if (r)
 		return r;
 
+	msg = amdgpu_bo_kptr(bo);
 	/* stitch together an UVD create msg */
 	msg[0] = cpu_to_le32(0x00000de4);
 	msg[1] = cpu_to_le32(0x00000000);
@@ -1198,23 +1206,25 @@ int amdgpu_uvd_get_create_msg(struct amdgpu_ring *ring, uint32_t handle,
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
+	r = ttm_bo_reserve(&bo->tbo, true, true, NULL);
 	if (r)
 		return r;
 
+	msg = amdgpu_bo_kptr(bo);
 	/* stitch together an UVD destroy msg */
 	msg[0] = cpu_to_le32(0x00000de4);
 	msg[1] = cpu_to_le32(0x00000002);
@@ -1223,7 +1233,10 @@ int amdgpu_uvd_get_destroy_msg(struct amdgpu_ring *ring, uint32_t handle,
 	for (i = 4; i < 1024; ++i)
 		msg[i] = cpu_to_le32(0x0);
 
-	return amdgpu_uvd_send_msg(ring, bo, direct, fence);
+	r = amdgpu_uvd_send_msg(ring, bo, direct, fence);
+
+	amdgpu_bo_unreserve(bo);
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
index bc571833632e..301c0cea7164 100644
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
+	r = ttm_bo_reserve(&bo->tbo, true, true, NULL);
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
index b6e82d75561f..efa270288029 100644
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
+	r = ttm_bo_reserve(&bo->tbo, true, true, NULL);
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

