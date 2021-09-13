Return-Path: <SRS0=miQW=OD=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F784C433F5
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Sep 2021 08:43:14 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6122460F4B
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Sep 2021 08:43:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 6122460F4B
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BBDA56EC8F;
	Mon, 13 Sep 2021 08:43:13 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2079.outbound.protection.outlook.com [40.107.244.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E49826EC8F
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 Sep 2021 08:43:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VU42lq/wLexdRPYuJ7FEFQ/uuDJBUQ8rVFpn0PQk9+blUrEIJEGPSW+RJ9rXSLNqjBQivF8lp91EEGZRhxIQuB9NqLdx9VWYWBmMes7b9VoBodcvv8auV4F93IRYv/8haKYInmDUYlQfpxxGxZaD5BknGiLlUmDJJuDjd0s00bgLFn3P985LpR64OVnffFBJz0OiqK/Zzb/5vYSystNKhXkjNfFm9PyELL5LGX3qRpv92w3I2vEYLft09gku3AJMuEfFGZOneKahn5/Dv9zZFsMsm8DrE45zuTdxx63pk3bOgqxUqbuRBiYI/pH3Cqk7oJLbvAPNoG818NmOOW5HyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=CsSV4EKmoA8VvZMxTWTgx3CA7bs1fCE+K77IkzQEMdc=;
 b=TGbpzhHEmWVZnYWc3cMYD26Dt0HFmKt3chmpGEv+1NU9fDTTiYDCob2DjjKWupkNhuSgEM9oB04aqlAY7a5/Gr5z6e+bHVyVkJ0A8mrCegU4T/I1v2EPiRrpS/wd4CCeXWJT8FK4fJRnb8K0YK8u0xMbFsSvol+p3CjWPrmFaskmNhKLxVQUmVyP5ayuEK4muUSUJZ/tr6gwXJnNEdBQQoA8FtYO0aZ+LEroAw0KKxIYSetzLEbFd6nBopZgrndKctnlEjx8TP72uDYVdii77DhFXzgC9VrJTWAvYeqENBP0RdyQaBTZbl4KSS/DeUsQ/krhJYnFyPtJ3Q23isP3Yw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CsSV4EKmoA8VvZMxTWTgx3CA7bs1fCE+K77IkzQEMdc=;
 b=HUAnrCnVKGYFLSNDsF5r57Jg8X1tz6wQs7B+8NeWaGUtTTLJQ2py2b7fKmZK1Ga+YiDvkzXJhOFrHAhlVzcro0RyihoJiqAQXEiC+4sLAR2XimvITSpRxeN8s+gtNSn0rCO+KrB4B6475nWTLAPuCtNdTZBT22F53nC+t9LZbRw=
Received: from DM5PR10CA0013.namprd10.prod.outlook.com (2603:10b6:4:2::23) by
 BN6PR12MB1777.namprd12.prod.outlook.com (2603:10b6:404:104::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.16; Mon, 13 Sep
 2021 08:43:10 +0000
Received: from DM6NAM11FT062.eop-nam11.prod.protection.outlook.com
 (2603:10b6:4:2:cafe::dc) by DM5PR10CA0013.outlook.office365.com
 (2603:10b6:4:2::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.14 via Frontend
 Transport; Mon, 13 Sep 2021 08:43:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT062.mail.protection.outlook.com (10.13.173.40) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4500.14 via Frontend Transport; Mon, 13 Sep 2021 08:43:10 +0000
Received: from pp-server-two.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Mon, 13 Sep
 2021 03:43:07 -0500
From: xinhui pan <xinhui.pan@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <alexander.deucher@amd.com>, <christian.koenig@amd.com>,
 <leo.liu@amd.com>, <James.Zhu@amd.com>, xinhui pan <xinhui.pan@amd.com>
Subject: [PATCH v4 1/3] drm/amdgpu: UVD avoid memory allocation during IB test
Date: Mon, 13 Sep 2021 16:42:51 +0800
Message-ID: <20210913084253.241955-1-xinhui.pan@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 539c9175-f0c4-45ab-7186-08d97692840b
X-MS-TrafficTypeDiagnostic: BN6PR12MB1777:
X-Microsoft-Antispam-PRVS: <BN6PR12MB1777EBBD697627921602471987D99@BN6PR12MB1777.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2512;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PO3jSZcu55KVFSn/UFsEq04Y++f9THUowK6A3hjcxyRH9Dt112muUYkBhnmiocsuVXFPZGJICgNkhgCzrdfZI697s9cl6MvGsSan+jMci8nTx9fE94vHGR9I/rddt5VL+rctmvHJo80vt4HNerxwAMtUa1bziO9xviCuoIKNEhaeWReD/I+pqyeBhDSZVnrOIgAr5+26JzVGN7wcztQSxEkiV3ZHnmC474ekh0NiKuJpSePkJ3clMc5BgiOD2Gp1bN0zIzAa6fZYD8Ht0oulcoplfkQbpM/cjU/V9Y/gNc5ay6bUL4bQFpuejftxX+T99zFfYPKpCdVfzLTzyk5z6zQF7kd6Rh3WUJHXqjpm8zrpfVtkPrPZGu3jU5dmYOFn6rpi2i7jajPMacfm6QgsAzQX6P7hHVccnrwdwsEPbpncP6+evs9WBAIJpFnkFhQccDo4XNJdyhAJJ0GeMRSVYlpz4EgdbF2BsmI8WrwzazkCDe3wiC7Xhfm2WSVmOFw5Dr2DZ9O+EwI8S4+0nBEW2M0maB3o/uxXcmKvX3i1Oz3m3EU8BXlSc5EDNMRf3BNdSDWLX87wxtuBuqQeMcvlUCL57/zSavAD73wwDUvXqxk+bZ0mKwFuN/9ZSu7/IKvlpTcz1Ry8RaUQAvEkDiNEC2IqJSZelpOE55iMSSn+/Tz9S57JrB9WXWkegydUpQYlsQslMN48Yr2lPNtTu1gulmqpycnbeIxzqYuBZ2WJMG8=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(346002)(136003)(376002)(396003)(39860400002)(36840700001)(46966006)(70586007)(36756003)(70206006)(478600001)(2906002)(36860700001)(16526019)(186003)(7696005)(81166007)(86362001)(54906003)(26005)(8936002)(82740400003)(336012)(83380400001)(6666004)(2616005)(426003)(5660300002)(316002)(82310400003)(4326008)(47076005)(1076003)(356005)(6916009)(8676002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Sep 2021 08:43:10.1291 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 539c9175-f0c4-45ab-7186-08d97692840b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT062.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1777
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
change from v3:
drop the bo resv lock in ib test.
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c | 102 ++++++++++++++++--------
 drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.h |   1 +
 drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c   |  11 +--
 drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c   |  11 +--
 4 files changed, 72 insertions(+), 53 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c
index d451c359606a..b0fbd5a1d5af 100644
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
+	if (adev->uvd.address_64_bit)
+		goto succ;
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
+succ:
+	amdgpu_bo_unreserve(bo);
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
@@ -302,6 +347,10 @@ int amdgpu_uvd_sw_init(struct amdgpu_device *adev)
 	if (!amdgpu_device_ip_block_version_cmp(adev, AMD_IP_BLOCK_TYPE_UVD, 5, 0))
 		adev->uvd.address_64_bit = true;
 
+	r = amdgpu_uvd_create_msg_bo_helper(adev, 128 << 10, &adev->uvd.ib_bo);
+	if (r)
+		return r;
+
 	switch (adev->asic_type) {
 	case CHIP_TONGA:
 		adev->uvd.use_ctx_buf = adev->uvd.fw_version >= FW_1_65_10;
@@ -324,6 +373,7 @@ int amdgpu_uvd_sw_init(struct amdgpu_device *adev)
 
 int amdgpu_uvd_sw_fini(struct amdgpu_device *adev)
 {
+	void *addr = amdgpu_bo_kptr(adev->uvd.ib_bo);
 	int i, j;
 
 	drm_sched_entity_destroy(&adev->uvd.entity);
@@ -342,6 +392,7 @@ int amdgpu_uvd_sw_fini(struct amdgpu_device *adev)
 		for (i = 0; i < AMDGPU_MAX_UVD_ENC_RINGS; ++i)
 			amdgpu_ring_fini(&adev->uvd.inst[j].ring_enc[i]);
 	}
+	amdgpu_bo_free_kernel(&adev->uvd.ib_bo, NULL, &addr);
 	release_firmware(adev->uvd.fw);
 
 	return 0;
@@ -1080,23 +1131,10 @@ static int amdgpu_uvd_send_msg(struct amdgpu_ring *ring, struct amdgpu_bo *bo,
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
@@ -1148,8 +1186,6 @@ static int amdgpu_uvd_send_msg(struct amdgpu_ring *ring, struct amdgpu_bo *bo,
 	}
 
 	amdgpu_bo_fence(bo, f, false);
-	amdgpu_bo_unreserve(bo);
-	amdgpu_bo_unref(&bo);
 
 	if (fence)
 		*fence = dma_fence_get(f);
@@ -1159,10 +1195,6 @@ static int amdgpu_uvd_send_msg(struct amdgpu_ring *ring, struct amdgpu_bo *bo,
 
 err_free:
 	amdgpu_job_free(job);
-
-err:
-	amdgpu_bo_unreserve(bo);
-	amdgpu_bo_unref(&bo);
 	return r;
 }
 
@@ -1173,16 +1205,11 @@ int amdgpu_uvd_get_create_msg(struct amdgpu_ring *ring, uint32_t handle,
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
-	if (r)
-		return r;
-
+	msg = amdgpu_bo_kptr(bo);
 	/* stitch together an UVD create msg */
 	msg[0] = cpu_to_le32(0x00000de4);
 	msg[1] = cpu_to_le32(0x00000000);
@@ -1198,7 +1225,9 @@ int amdgpu_uvd_get_create_msg(struct amdgpu_ring *ring, uint32_t handle,
 	for (i = 11; i < 1024; ++i)
 		msg[i] = cpu_to_le32(0x0);
 
-	return amdgpu_uvd_send_msg(ring, bo, true, fence);
+	r = amdgpu_uvd_send_msg(ring, bo, true, fence);
+
+	return r;
 }
 
 int amdgpu_uvd_get_destroy_msg(struct amdgpu_ring *ring, uint32_t handle,
@@ -1207,14 +1236,16 @@ int amdgpu_uvd_get_destroy_msg(struct amdgpu_ring *ring, uint32_t handle,
 	struct amdgpu_device *adev = ring->adev;
 	struct amdgpu_bo *bo = NULL;
 	uint32_t *msg;
-	int r, i;
+	int r = 0, i;
 
-	r = amdgpu_bo_create_reserved(adev, 1024, PAGE_SIZE,
-				      AMDGPU_GEM_DOMAIN_GTT,
-				      &bo, NULL, (void **)&msg);
+	if (direct)
+		bo = adev->uvd.ib_bo;
+	else
+		r = amdgpu_uvd_create_msg_bo_helper(adev, 4096, &bo);
 	if (r)
 		return r;
 
+	msg = amdgpu_bo_kptr(bo);
 	/* stitch together an UVD destroy msg */
 	msg[0] = cpu_to_le32(0x00000de4);
 	msg[1] = cpu_to_le32(0x00000002);
@@ -1223,7 +1254,12 @@ int amdgpu_uvd_get_destroy_msg(struct amdgpu_ring *ring, uint32_t handle,
 	for (i = 4; i < 1024; ++i)
 		msg[i] = cpu_to_le32(0x0);
 
-	return amdgpu_uvd_send_msg(ring, bo, direct, fence);
+	r = amdgpu_uvd_send_msg(ring, bo, direct, fence);
+
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
index bc571833632e..d5d023a24269 100644
--- a/drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c
@@ -332,15 +332,9 @@ static int uvd_v6_0_enc_get_destroy_msg(struct amdgpu_ring *ring,
 static int uvd_v6_0_enc_ring_test_ib(struct amdgpu_ring *ring, long timeout)
 {
 	struct dma_fence *fence = NULL;
-	struct amdgpu_bo *bo = NULL;
+	struct amdgpu_bo *bo = ring->adev->uvd.ib_bo;
 	long r;
 
-	r = amdgpu_bo_create_reserved(ring->adev, 128 * 1024, PAGE_SIZE,
-				      AMDGPU_GEM_DOMAIN_VRAM,
-				      &bo, NULL, NULL);
-	if (r)
-		return r;
-
 	r = uvd_v6_0_enc_get_create_msg(ring, 1, bo, NULL);
 	if (r)
 		goto error;
@@ -357,9 +351,6 @@ static int uvd_v6_0_enc_ring_test_ib(struct amdgpu_ring *ring, long timeout)
 
 error:
 	dma_fence_put(fence);
-	amdgpu_bo_unpin(bo);
-	amdgpu_bo_unreserve(bo);
-	amdgpu_bo_unref(&bo);
 	return r;
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c b/drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c
index b6e82d75561f..c115b2da22ef 100644
--- a/drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c
@@ -338,15 +338,9 @@ static int uvd_v7_0_enc_get_destroy_msg(struct amdgpu_ring *ring, uint32_t handl
 static int uvd_v7_0_enc_ring_test_ib(struct amdgpu_ring *ring, long timeout)
 {
 	struct dma_fence *fence = NULL;
-	struct amdgpu_bo *bo = NULL;
+	struct amdgpu_bo *bo = ring->adev->uvd.ib_bo;
 	long r;
 
-	r = amdgpu_bo_create_reserved(ring->adev, 128 * 1024, PAGE_SIZE,
-				      AMDGPU_GEM_DOMAIN_VRAM,
-				      &bo, NULL, NULL);
-	if (r)
-		return r;
-
 	r = uvd_v7_0_enc_get_create_msg(ring, 1, bo, NULL);
 	if (r)
 		goto error;
@@ -363,9 +357,6 @@ static int uvd_v7_0_enc_ring_test_ib(struct amdgpu_ring *ring, long timeout)
 
 error:
 	dma_fence_put(fence);
-	amdgpu_bo_unpin(bo);
-	amdgpu_bo_unreserve(bo);
-	amdgpu_bo_unref(&bo);
 	return r;
 }
 
-- 
2.25.1

