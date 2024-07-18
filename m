Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6834C3DA49
	for <amd-gfx@archiver.kernel.org>; Thu, 18 Jul 2024 14:08:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 95CF710E8E4;
	Thu, 18 Jul 2024 14:08:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="B6N0+YCK";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2055.outbound.protection.outlook.com [40.107.243.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5484010E8C5
 for <amd-gfx@lists.freedesktop.org>; Thu, 18 Jul 2024 14:08:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=c9rZJZDixf3aex1zYGJqaYGojX7hnwI4EDSXLW7syvXPB3yOcaInUp24lH44kHPgaXDfyF8zTsKSKUO7vYHsV4t+ikrsSq4Cann8B6xxKc7C5Z0o4z1/j3/ChBCUTpUTtM8CpRN1R795PgVd/qRFIayGjcFBNBoEsvWEuTBfsGnzMS59PEx1UOkbviXrc3XhHskpHMG5sUWuVb7+aszBswbFDE18kBkm4MlMmHFugTh4q1bLq+oTB7itq1wMOcBFpL1bU0Vk3Rut7JbE8BIFsa0tzQRHUrFZ5lQ9MitGIyO4BusDOONuNZwvsL7zzcjG+2bPe6TIsp8WJPuIzcXUSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jlSfK7Mdl9Oqj2M7Q6ND5PhyVo/2Xtp7H7OdS2IZpYQ=;
 b=TrPMNat+AGVGueyI8zctg6GySiN2CGtveeOgDsRqURH92d7Aw2I9UMBvFxsZq6BbDgcyC5E5iMn79KvD9z7yAJ37pzNhTcjHA2LATNMCqoK2VbtVPOmfLtVulyylsGH5SLj3q5hZhtOKWwtSVvga4TLqlB3eivPBwoZuqxaZ9lM2PY9/VMEj6rF/fgi8l9Zxc6NNmFUG6qX9U1YxRh4rmAL0HmrGyZ5qEBmJwrnkkl5PM+QSFpY9mCH6oe5yZn1lkoXVthS/PjnBbeojOZyiAbQtYOBEozx/nFk2GMLV6irYq3K+u04Vdc7ZmyjhFt+LXeRu1V29O8jJpjjuPQbBGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jlSfK7Mdl9Oqj2M7Q6ND5PhyVo/2Xtp7H7OdS2IZpYQ=;
 b=B6N0+YCKqJfAI7aoZGQNXeojHxfxWRwpZgLgYRMjc53WxvOsBbdvkTFyacwFuVGvpLWYHIspl51e+65E/GKtOQlZo820RFCY4xxdoAx3y65N4pR3GwTjLNtV7GVBOcKFzKIlZU5wiSfj6mYAr1xJfV8oMoDeoatn3zM8N9q7CMQ=
Received: from BL1PR13CA0081.namprd13.prod.outlook.com (2603:10b6:208:2b8::26)
 by CYYPR12MB8729.namprd12.prod.outlook.com (2603:10b6:930:c2::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.33; Thu, 18 Jul
 2024 14:08:07 +0000
Received: from BL02EPF0001A108.namprd05.prod.outlook.com
 (2603:10b6:208:2b8:cafe::e0) by BL1PR13CA0081.outlook.office365.com
 (2603:10b6:208:2b8::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.14 via Frontend
 Transport; Thu, 18 Jul 2024 14:08:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0001A108.mail.protection.outlook.com (10.167.241.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7784.11 via Frontend Transport; Thu, 18 Jul 2024 14:08:07 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 18 Jul
 2024 09:08:04 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 25/34] drm/amdgpu/gfx12: fallback to driver reset compute
 queue directly
Date: Thu, 18 Jul 2024 10:07:24 -0400
Message-ID: <20240718140733.1731004-26-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240718140733.1731004-1-alexander.deucher@amd.com>
References: <20240718140733.1731004-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A108:EE_|CYYPR12MB8729:EE_
X-MS-Office365-Filtering-Correlation-Id: 2ca56c45-826d-468a-4951-08dca7330c53
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Vc/DMk/AIeu5J8RBI0LgTIEEoDOrwFQUC26MwyGyj+n8w7YSwqDIgr93VCQV?=
 =?us-ascii?Q?e7igsgQ5E7FC6qJcmdVYQi6jvnBGjRzENd9q2ScaUNsVzuNLuPtC3RFp/yRs?=
 =?us-ascii?Q?6dWkHOHAb3G/GEBREEYao+EIWU417MySo4SCsLDZmcuEVvYP+fQQ1mzr43jq?=
 =?us-ascii?Q?kZcUAwvBErKW3qkZi2BukFhJA6l+MVs4Adeny4Ne+VBIaf4sJuGeD1fXta6N?=
 =?us-ascii?Q?ePGezkSb8AY4/WJEbrRvr+cZ2ReszBmO9xRuE/6VlicUL2D2nRf4E5tk5Oep?=
 =?us-ascii?Q?I+zQHxJkp7F4Sykg4GJ0J4MOHaSYk53u9xA2u7KZqYxjv/wEqm666UgVHCkG?=
 =?us-ascii?Q?MLz6RCBCctJHA0oP1P5sR1kFfuhXLyu/SNoWjbDktv22f/PLF8F7+d0SshIF?=
 =?us-ascii?Q?kEuIMwnAgarMJnB4bgYXE+F8LnXH/jnVZwFBEVtbZNUnla1NFHMiMoa0iSsO?=
 =?us-ascii?Q?LPoTu9tz9EU8N+kY1qJTkmZR7Ap6cMJXhtYcVJSfvaHvDn8XpiAL0U/tI6KN?=
 =?us-ascii?Q?LgPt9f9mR53J8aQpfnDtUwkgqti6sHVUDjBic9xmMnl0/tc1/JxnT6YYsb0D?=
 =?us-ascii?Q?Vhf6unhPD8p0SLUdduqsobFiBqgDqBVCMWPkITB0Tw0Ryk+kMG7jgkxNU65s?=
 =?us-ascii?Q?xMMjGOI7eV1WqhCPJldVfrIyWYiecMOQEKC/XTGVmLldBfZZ7nix0L9GirNY?=
 =?us-ascii?Q?78B3OqOgcBbBJcoAnjep+0s1l1J085nCVeimuAsTZDwSqjAQD/3tSEptB++l?=
 =?us-ascii?Q?dDb8dUHmsAHbgR2piV1jmGNcm3/MPk//xd1T8MwZr7azIH7IEW1TuQLyat+C?=
 =?us-ascii?Q?WNvlrwehmIVZnQb1awSM+mWiv4dzG9U9X812uKBCyA94BKFLLh/zo11FC9x8?=
 =?us-ascii?Q?YTGt4XWpd5EB1+/mIZ88jyAzVwsW4gpuqgSQ5VEVB+jAvKRg1ANmHe9aE9Su?=
 =?us-ascii?Q?NjKl7zoyPRLJiuKLKqBWqKguVVdgfXax8aq772X5CCGlq6LWA4V27HLj1ZxX?=
 =?us-ascii?Q?9YUDrFK0Fye/d1DXq/5T8i4KodFbg8zNE8WW9MbXGQBXf3T9vbpZdCzo+VlV?=
 =?us-ascii?Q?hqccnRSwoC/L0vFMNzFnZH4JtxvnERsSW426mA4evshEJs8uWZUbC6Qq66pl?=
 =?us-ascii?Q?pNFZsw8qTHGspNSrOVJsNm/85pg1nTYyJTvRMcJ3vWEMVdMCK4dEagGOMVDt?=
 =?us-ascii?Q?etgYHNndH/WmnU3dQD1qXePnFBPrLwhp6Fiw1RJZvGAwxuzi8b+NR/HX6DIz?=
 =?us-ascii?Q?2Olq0V6zgg7IUSzPROQ5/pOJTsGRUm31e1zuZqXvCMm45Kosk1CqxXpPU/Pe?=
 =?us-ascii?Q?ZZW7HaBpJLaOdBbbd3QQ1OfJxsWlw9X04SSya/igliV9j27Af1oNn4r+Xab6?=
 =?us-ascii?Q?jbpkrukiD6A5JMlwoYPkdtOnaDN16K9sj8hbCGMzVmMJZB5dBYmcCZQkAT9n?=
 =?us-ascii?Q?gRN+KoyztHQR+WssShYM/7C73NhVGqTs?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2024 14:08:07.0942 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ca56c45-826d-468a-4951-08dca7330c53
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A108.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8729
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

Since the MES FW resets kernel compute queue always failed, this
may caused by the KIQ failed to process unmap KCQ. So, before MES
FW work properly that will fallback to driver executes dequeue and
resets SPI directly. Besides, rework the ring reset function and make
the busy ring type reset in each function respectively.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c | 93 ++++++++++++++++++++++----
 1 file changed, 79 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
index 9ed6c8ba6b33..c4193fa2fea4 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
@@ -2910,13 +2910,13 @@ static int gfx_v12_0_gfx_mqd_init(struct amdgpu_device *adev, void *m,
 	return 0;
 }
 
-static int gfx_v12_0_gfx_init_queue(struct amdgpu_ring *ring)
+static int gfx_v12_0_kgq_init_queue(struct amdgpu_ring *ring, bool reset)
 {
 	struct amdgpu_device *adev = ring->adev;
 	struct v12_gfx_mqd *mqd = ring->mqd_ptr;
 	int mqd_idx = ring - &adev->gfx.gfx_ring[0];
 
-	if (!amdgpu_in_reset(adev) && !adev->in_suspend) {
+	if (!reset && !amdgpu_in_reset(adev) && !adev->in_suspend) {
 		memset((void *)mqd, 0, sizeof(*mqd));
 		mutex_lock(&adev->srbm_mutex);
 		soc24_grbm_select(adev, ring->me, ring->pipe, ring->queue, 0);
@@ -2952,7 +2952,7 @@ static int gfx_v12_0_cp_async_gfx_ring_resume(struct amdgpu_device *adev)
 
 		r = amdgpu_bo_kmap(ring->mqd_obj, (void **)&ring->mqd_ptr);
 		if (!r) {
-			r = gfx_v12_0_gfx_init_queue(ring);
+			r = gfx_v12_0_kgq_init_queue(ring, false);
 			amdgpu_bo_kunmap(ring->mqd_obj);
 			ring->mqd_ptr = NULL;
 		}
@@ -3256,13 +3256,13 @@ static int gfx_v12_0_kiq_init_queue(struct amdgpu_ring *ring)
 	return 0;
 }
 
-static int gfx_v12_0_kcq_init_queue(struct amdgpu_ring *ring)
+static int gfx_v12_0_kcq_init_queue(struct amdgpu_ring *ring, bool reset)
 {
 	struct amdgpu_device *adev = ring->adev;
 	struct v12_compute_mqd *mqd = ring->mqd_ptr;
 	int mqd_idx = ring - &adev->gfx.compute_ring[0];
 
-	if (!amdgpu_in_reset(adev) && !adev->in_suspend) {
+	if (!reset && !amdgpu_in_reset(adev) && !adev->in_suspend) {
 		memset((void *)mqd, 0, sizeof(*mqd));
 		mutex_lock(&adev->srbm_mutex);
 		soc24_grbm_select(adev, ring->me, ring->pipe, ring->queue, 0);
@@ -3326,7 +3326,7 @@ static int gfx_v12_0_kcq_resume(struct amdgpu_device *adev)
 			goto done;
 		r = amdgpu_bo_kmap(ring->mqd_obj, (void **)&ring->mqd_ptr);
 		if (!r) {
-			r = gfx_v12_0_kcq_init_queue(ring);
+			r = gfx_v12_0_kcq_init_queue(ring, false);
 			amdgpu_bo_kunmap(ring->mqd_obj);
 			ring->mqd_ptr = NULL;
 		}
@@ -5135,18 +5135,83 @@ static void gfx_v12_ip_dump(void *handle)
 	amdgpu_gfx_off_ctrl(adev, true);
 }
 
-static int gfx_v12_0_reset_ring(struct amdgpu_ring *ring, unsigned int vmid)
+static int gfx_v12_0_reset_kgq(struct amdgpu_ring *ring, unsigned int vmid)
 {
+	struct amdgpu_device *adev = ring->adev;
 	int r;
 
 	r = amdgpu_mes_reset_legacy_queue(ring->adev, ring, vmid);
-	if (r)
+	if (r) {
+		dev_err(adev->dev, "reset via MES failed %d\n", r);
 		return r;
+	}
 
-	/* reset the ring */
-	ring->wptr = 0;
-	*ring->wptr_cpu_addr = 0;
-	amdgpu_ring_clear_ring(ring);
+	r = amdgpu_bo_reserve(ring->mqd_obj, false);
+	if (unlikely(r != 0)){
+		dev_err(adev->dev, "fail to resv mqd_obj\n");
+		return r;
+	}
+	r = amdgpu_bo_kmap(ring->mqd_obj, (void **)&ring->mqd_ptr);
+	if (!r) {
+		r = gfx_v12_0_kgq_init_queue(ring, true);
+		amdgpu_bo_kunmap(ring->mqd_obj);
+		ring->mqd_ptr = NULL;
+	}
+	amdgpu_bo_unreserve(ring->mqd_obj);
+	if (r){
+		DRM_ERROR("fail to unresv mqd_obj\n");
+		return r;
+	}
+
+	r = amdgpu_mes_map_legacy_queue(adev, ring);
+	if (r) {
+		dev_err(adev->dev, "failed to remap kgq\n");
+		return r;
+	}
+
+	return amdgpu_ring_test_ring(ring);
+}
+
+static int gfx_v12_0_reset_kcq(struct amdgpu_ring *ring, unsigned int vmid)
+{
+	struct amdgpu_device *adev = ring->adev;
+	int r, i;
+
+	gfx_v12_0_set_safe_mode(adev, 0);
+	mutex_lock(&adev->srbm_mutex);
+	soc24_grbm_select(adev, ring->me, ring->pipe, ring->queue, 0);
+	WREG32_SOC15(GC, 0, regCP_HQD_DEQUEUE_REQUEST, 0x2);
+	WREG32_SOC15(GC, 0, regSPI_COMPUTE_QUEUE_RESET, 0x1);
+	for (i = 0; i < adev->usec_timeout; i++) {
+		if (!(RREG32_SOC15(GC, 0, regCP_HQD_ACTIVE) & 1))
+			break;
+		udelay(1);
+	}
+	soc24_grbm_select(adev, 0, 0, 0, 0);
+	mutex_unlock(&adev->srbm_mutex);
+	gfx_v12_0_unset_safe_mode(adev, 0);
+
+	r = amdgpu_bo_reserve(ring->mqd_obj, false);
+	if (unlikely(r != 0)){
+		DRM_ERROR("fail to resv mqd_obj\n");
+		return r;
+	}
+	r = amdgpu_bo_kmap(ring->mqd_obj, (void **)&ring->mqd_ptr);
+	if (!r) {
+		r = gfx_v12_0_kcq_init_queue(ring, true);
+		amdgpu_bo_kunmap(ring->mqd_obj);
+		ring->mqd_ptr = NULL;
+	}
+	amdgpu_bo_unreserve(ring->mqd_obj);
+	if (r){
+		DRM_ERROR("fail to unresv mqd_obj\n");
+		return r;
+	}
+	r = amdgpu_mes_map_legacy_queue(adev, ring);
+	if (r) {
+		dev_err(adev->dev, "failed to remap kcq\n");
+		return r;
+	}
 
 	return amdgpu_ring_test_ring(ring);
 }
@@ -5213,7 +5278,7 @@ static const struct amdgpu_ring_funcs gfx_v12_0_ring_funcs_gfx = {
 	.emit_reg_write_reg_wait = gfx_v12_0_ring_emit_reg_write_reg_wait,
 	.soft_recovery = gfx_v12_0_ring_soft_recovery,
 	.emit_mem_sync = gfx_v12_0_emit_mem_sync,
-	.reset = gfx_v12_0_reset_ring,
+	.reset = gfx_v12_0_reset_kgq,
 };
 
 static const struct amdgpu_ring_funcs gfx_v12_0_ring_funcs_compute = {
@@ -5248,7 +5313,7 @@ static const struct amdgpu_ring_funcs gfx_v12_0_ring_funcs_compute = {
 	.emit_reg_write_reg_wait = gfx_v12_0_ring_emit_reg_write_reg_wait,
 	.soft_recovery = gfx_v12_0_ring_soft_recovery,
 	.emit_mem_sync = gfx_v12_0_emit_mem_sync,
-	.reset = gfx_v12_0_reset_ring,
+	.reset = gfx_v12_0_reset_kcq,
 };
 
 static const struct amdgpu_ring_funcs gfx_v12_0_ring_funcs_kiq = {
-- 
2.45.2

