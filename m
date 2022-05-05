Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28C5CC433F5
	for <amd-gfx@archiver.kernel.org>; Thu,  5 May 2022 03:20:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C724110F8FA;
	Thu,  5 May 2022 03:20:56 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam07on2067.outbound.protection.outlook.com [40.107.212.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AC9D110F8F9
 for <amd-gfx@lists.freedesktop.org>; Thu,  5 May 2022 03:20:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a+7+03yOEY/EDkEJNW4gi2Xl33JUbN118Ke28z+hOdX1DOZEhKOAdFosHzDlDDtCT88dobODm6irr71ztow2yVS4P7t0O5FkztkrzB2T8/j1m0c/2oeTWza6KWwIKP8PrCUdFdRTjjT63Eh/A9oN6mQcq6hUVgAfj8cVZ4+xhgeefzXHl2Vc6eCV7mggrMrhh1sa0mnan43lzC8neXweJaBK4bO8Bcto9cX/wR5cfyiCc0OI+4TRAvH70ypOW+CMzvY4/6RYizVO8n2ixvm4dedAv9yRq9yDPc/qXGUE6UU36Ajme7kAlj0vT9Z6MtqxafrqO4U34uCi4VqLCejeIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CXlAT6IISWQxs9off5C0AAllFlhfCIITUvTPWTpgTls=;
 b=Lyr5QgZKxHEPZxlvILG5praUFc6JrTbo9GnNAe1kxqZrY1ySTU8n/ZHJWZwyt3ZJzqg3rno/5+gZ3/Kna7OXvWs6jjJbLiK+kqW/uJ39Qq0g90ulDeKUw/C3qpFmx0o5OkyyqNoRSchDaJ0iP81TwoLO2pp7BzJfmiXNLjFTQ4F6/yqPGDyzFMPLcBqyemggoCnWQZvwEzvBO/hhPZAPXc05eWPb4sp3Tj2Hycn0+n1yrJpCWVNS6A6aaBjpBZQnDWBzMvM9+4APKKEzfRpKMJX+bc6kxuXXhAap1wl8LEREQ+FA1GPAlje8/fOd1POC2pw+YUSUnziLaSUvc6PkEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CXlAT6IISWQxs9off5C0AAllFlhfCIITUvTPWTpgTls=;
 b=Cn2VEWiFlX9p1dfy5cNXCzMTWeOpTLV+j8ry2xabZ82C/jdrgKVXymFqBfk5lrSPExqSoGQZRVytIMaRtiqIhtn0+7PflU3CIwRwcevt0QUV7OjxqHXIAQQzJ9/DVAJaPCMTT0yfBLig7g3jrib0mCs2ANfz1DBdQSD+E67WhZo=
Received: from MW2PR16CA0038.namprd16.prod.outlook.com (2603:10b6:907:1::15)
 by MW4PR12MB5667.namprd12.prod.outlook.com (2603:10b6:303:18a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.20; Thu, 5 May
 2022 03:20:50 +0000
Received: from CO1NAM11FT010.eop-nam11.prod.protection.outlook.com
 (2603:10b6:907:1:cafe::d0) by MW2PR16CA0038.outlook.office365.com
 (2603:10b6:907:1::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.25 via Frontend
 Transport; Thu, 5 May 2022 03:20:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT010.mail.protection.outlook.com (10.13.175.88) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5227.15 via Frontend Transport; Thu, 5 May 2022 03:20:50 +0000
Received: from lang-desktop.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Wed, 4 May
 2022 22:20:46 -0500
From: Lang Yu <Lang.Yu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: make scratch_get/free more general
Date: Thu, 5 May 2022 11:20:22 +0800
Message-ID: <20220505032022.3197203-1-Lang.Yu@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 664bf953-838a-4a8f-9e1b-08da2e46416f
X-MS-TrafficTypeDiagnostic: MW4PR12MB5667:EE_
X-Microsoft-Antispam-PRVS: <MW4PR12MB5667E0F0F048F2674B510B3AFBC29@MW4PR12MB5667.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: I6oS7PP38QuZnLl5GtdO+05lBV9QVTaWP9lsXLwseGMxxF5D+Hiejznu9R8Dlvhf9BWeW3haC+OkdtEoB+26SbL5QmkDXjWVuPF3i4qMkebN2VUthJ5APp4ZaZeok6t4JGMStt5XVvBW3Tc2PkoIWI7utxNS+33Bp4xxghja4o+pLRgDshgN3TqFGbyZgrYLR8/HPyT4sVtJSPWjo4gEGagFOUWAX2TZDM5LkpVU0iQtHX2gYNsbDt5h9xoVgHAj86qy/z0sbV+jgPYJSM/8qDDCknvbfvOGoHpv83T7oQpPm66baGlADkyHrPq+OJtaIqDfw2YoXKz06SCju7Ud1e3rz4Ev3iJSCVfp485IjN8+wEw9GCNkRenm9g2Al9mVPaf2NyX9xWEP+1skAJCi+Os7eL0jrGmC0kc9JPLAGSjroJHaQGGufhhHrRLJ1fRyOQO6TZEDZ+oy1ceOAuDk6Q4iHB3/m2xIEttiwoO9yKPxEWOUwZ97q+wYZIqGhm3ioZpF7Zz+fqbMv39HVbrmqoMptuokHK2GwPWE53iLDYVRZFU24upPFT7WcR7eAfIxakk6ISXMpgwIEdOLOHJ0QhfnJsVrjyWgiftCvNcfzjhem+eM/jzxOtdyLr7kQhAHag/TbZGt4mVGHJMrfOI+KfBwcX5EUSmZg69biUldsayp012IEqz3TV0UzDK69VSiOWiG6HxBFmGyc78GclrB+A==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(40470700004)(46966006)(36840700001)(70206006)(316002)(5660300002)(8936002)(70586007)(4326008)(6666004)(336012)(47076005)(426003)(36756003)(86362001)(356005)(7696005)(2906002)(81166007)(36860700001)(82310400005)(6916009)(186003)(16526019)(40460700003)(54906003)(2616005)(83380400001)(508600001)(30864003)(26005)(1076003)(8676002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2022 03:20:50.4894 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 664bf953-838a-4a8f-9e1b-08da2e46416f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT010.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB5667
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Huang Rui <ray.huang@amd.com>,
 Lang Yu <Lang.Yu@amd.com>, Christian Koenig <christian.koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Then other IPs can use this utility.

Signed-off-by: Lang Yu <Lang.Yu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h        |  3 ++
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 36 ++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c    | 36 ----------------------
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h    | 12 --------
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h   |  9 ++++++
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c     |  6 ++--
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c     |  6 ++--
 drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c      |  8 ++---
 drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c      |  8 ++---
 drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c      |  4 +--
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c      |  4 +--
 11 files changed, 66 insertions(+), 66 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index 578a405f777c..2f85d5a228a9 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -1272,6 +1272,9 @@ u32 amdgpu_device_pcie_port_rreg(struct amdgpu_device *adev,
 void amdgpu_device_pcie_port_wreg(struct amdgpu_device *adev,
 				u32 reg, u32 v);
 
+int amdgpu_device_scratch_get(struct amdgpu_scratch *scratch, uint32_t *reg);
+void amdgpu_device_scratch_free(struct amdgpu_scratch *scratch, uint32_t reg);
+
 /* atpx handler */
 #if defined(CONFIG_VGA_SWITCHEROO)
 void amdgpu_register_atpx_handler(void);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index e582f1044c0f..abbccede3586 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -5846,3 +5846,39 @@ void amdgpu_device_pcie_port_wreg(struct amdgpu_device *adev,
 	(void)RREG32(data);
 	spin_unlock_irqrestore(&adev->pcie_idx_lock, flags);
 }
+
+/**
+ * amdgpu_device_scratch_get - Allocate a scratch register
+ *
+ * @scratch: amdgpu_scratch pointer
+ * @reg: scratch register mmio offset
+ *
+ * Allocate a scratch register for use by the driver (all asics).
+ * Returns 0 on success or -EINVAL on failure.
+ */
+int amdgpu_device_scratch_get(struct amdgpu_scratch *scratch, uint32_t *reg)
+{
+	int i;
+
+	i = ffs(scratch->free_mask);
+	if (i != 0 && i <= scratch->num_reg) {
+		i--;
+		scratch->free_mask &= ~(1u << i);
+		*reg = scratch->reg_base + i;
+		return 0;
+	}
+	return -EINVAL;
+}
+
+/**
+ * amdgpu_device_scratch_free - Free a scratch register
+ *
+ * @scratch: amdgpu_scratch pointer
+ * @reg: scratch register mmio offset
+ *
+ * Free a scratch register allocated for use by the driver (all asics)
+ */
+void amdgpu_device_scratch_free(struct amdgpu_scratch *scratch, uint32_t reg)
+{
+	scratch->free_mask |= 1u << (reg - scratch->reg_base);
+}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
index 5d6b04fc6206..ede2fa56f6c9 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
@@ -98,42 +98,6 @@ bool amdgpu_gfx_is_me_queue_enabled(struct amdgpu_device *adev,
 			adev->gfx.me.queue_bitmap);
 }
 
-/**
- * amdgpu_gfx_scratch_get - Allocate a scratch register
- *
- * @adev: amdgpu_device pointer
- * @reg: scratch register mmio offset
- *
- * Allocate a CP scratch register for use by the driver (all asics).
- * Returns 0 on success or -EINVAL on failure.
- */
-int amdgpu_gfx_scratch_get(struct amdgpu_device *adev, uint32_t *reg)
-{
-	int i;
-
-	i = ffs(adev->gfx.scratch.free_mask);
-	if (i != 0 && i <= adev->gfx.scratch.num_reg) {
-		i--;
-		adev->gfx.scratch.free_mask &= ~(1u << i);
-		*reg = adev->gfx.scratch.reg_base + i;
-		return 0;
-	}
-	return -EINVAL;
-}
-
-/**
- * amdgpu_gfx_scratch_free - Free a scratch register
- *
- * @adev: amdgpu_device pointer
- * @reg: scratch register mmio offset
- *
- * Free a CP scratch register allocated for use by the driver (all asics)
- */
-void amdgpu_gfx_scratch_free(struct amdgpu_device *adev, uint32_t reg)
-{
-	adev->gfx.scratch.free_mask |= 1u << (reg - adev->gfx.scratch.reg_base);
-}
-
 /**
  * amdgpu_gfx_parse_disable_cu - Parse the disable_cu module parameter
  *
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
index 45522609d4b4..54455961720b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
@@ -110,15 +110,6 @@ struct amdgpu_kiq {
 	const struct kiq_pm4_funcs *pmf;
 };
 
-/*
- * GPU scratch registers structures, functions & helpers
- */
-struct amdgpu_scratch {
-	unsigned		num_reg;
-	uint32_t                reg_base;
-	uint32_t		free_mask;
-};
-
 /*
  * GFX configurations
  */
@@ -376,9 +367,6 @@ static inline u32 amdgpu_gfx_create_bitmask(u32 bit_width)
 	return (u32)((1ULL << bit_width) - 1);
 }
 
-int amdgpu_gfx_scratch_get(struct amdgpu_device *adev, uint32_t *reg);
-void amdgpu_gfx_scratch_free(struct amdgpu_device *adev, uint32_t reg);
-
 void amdgpu_gfx_parse_disable_cu(unsigned *mask, unsigned max_se,
 				 unsigned max_sh);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
index 7d89a52091c0..7d09842730cd 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
@@ -102,6 +102,15 @@ struct amdgpu_sched {
 	struct drm_gpu_scheduler	*sched[AMDGPU_MAX_HWIP_RINGS];
 };
 
+/*
+ * GPU scratch registers structures, functions & helpers
+ */
+struct amdgpu_scratch {
+	uint32_t		num_reg;
+	uint32_t                reg_base;
+	uint32_t		free_mask;
+};
+
 /*
  * Fences.
  */
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
index 64d36622ee23..bd5b2e1ab2c3 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -3792,7 +3792,7 @@ static int gfx_v10_0_ring_test_ring(struct amdgpu_ring *ring)
 	unsigned i;
 	int r;
 
-	r = amdgpu_gfx_scratch_get(adev, &scratch);
+	r = amdgpu_device_scratch_get(&adev->gfx.scratch, &scratch);
 	if (r) {
 		DRM_ERROR("amdgpu: cp failed to get scratch reg (%d).\n", r);
 		return r;
@@ -3804,7 +3804,7 @@ static int gfx_v10_0_ring_test_ring(struct amdgpu_ring *ring)
 	if (r) {
 		DRM_ERROR("amdgpu: cp failed to lock ring %d (%d).\n",
 			  ring->idx, r);
-		amdgpu_gfx_scratch_free(adev, scratch);
+		amdgpu_device_scratch_free(&adev->gfx.scratch, scratch);
 		return r;
 	}
 
@@ -3826,7 +3826,7 @@ static int gfx_v10_0_ring_test_ring(struct amdgpu_ring *ring)
 	if (i >= adev->usec_timeout)
 		r = -ETIMEDOUT;
 
-	amdgpu_gfx_scratch_free(adev, scratch);
+	amdgpu_device_scratch_free(&adev->gfx.scratch, scratch);
 
 	return r;
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
index c5655128fd9c..c6d33d6be778 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -313,7 +313,7 @@ static int gfx_v11_0_ring_test_ring(struct amdgpu_ring *ring)
 	unsigned i;
 	int r;
 
-	r = amdgpu_gfx_scratch_get(adev, &scratch);
+	r = amdgpu_device_scratch_get(&adev->gfx.scratch, &scratch);
 	if (r) {
 		DRM_ERROR("amdgpu: cp failed to get scratch reg (%d).\n", r);
 		return r;
@@ -325,7 +325,7 @@ static int gfx_v11_0_ring_test_ring(struct amdgpu_ring *ring)
 	if (r) {
 		DRM_ERROR("amdgpu: cp failed to lock ring %d (%d).\n",
 			  ring->idx, r);
-		amdgpu_gfx_scratch_free(adev, scratch);
+		amdgpu_device_scratch_free(&adev->gfx.scratch, scratch);
 		return r;
 	}
 
@@ -351,7 +351,7 @@ static int gfx_v11_0_ring_test_ring(struct amdgpu_ring *ring)
 	if (i >= adev->usec_timeout)
 		r = -ETIMEDOUT;
 
-	amdgpu_gfx_scratch_free(adev, scratch);
+	amdgpu_device_scratch_free(&adev->gfx.scratch, scratch);
 
 	return r;
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c
index 29a91b320d4f..896bbf50a494 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c
@@ -1794,7 +1794,7 @@ static int gfx_v6_0_ring_test_ring(struct amdgpu_ring *ring)
 	unsigned i;
 	int r;
 
-	r = amdgpu_gfx_scratch_get(adev, &scratch);
+	r = amdgpu_device_scratch_get(&adev->gfx.scratch, &scratch);
 	if (r)
 		return r;
 
@@ -1820,7 +1820,7 @@ static int gfx_v6_0_ring_test_ring(struct amdgpu_ring *ring)
 		r = -ETIMEDOUT;
 
 error_free_scratch:
-	amdgpu_gfx_scratch_free(adev, scratch);
+	amdgpu_device_scratch_free(&adev->gfx.scratch, scratch);
 	return r;
 }
 
@@ -1909,7 +1909,7 @@ static int gfx_v6_0_ring_test_ib(struct amdgpu_ring *ring, long timeout)
 	uint32_t tmp = 0;
 	long r;
 
-	r = amdgpu_gfx_scratch_get(adev, &scratch);
+	r = amdgpu_device_scratch_get(&adev->gfx.scratch, &scratch);
 	if (r)
 		return r;
 
@@ -1946,7 +1946,7 @@ static int gfx_v6_0_ring_test_ib(struct amdgpu_ring *ring, long timeout)
 	amdgpu_ib_free(adev, &ib, NULL);
 	dma_fence_put(f);
 err1:
-	amdgpu_gfx_scratch_free(adev, scratch);
+	amdgpu_device_scratch_free(&adev->gfx.scratch, scratch);
 	return r;
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
index ac3f2dbba726..b60e3bcba050 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
@@ -2087,7 +2087,7 @@ static int gfx_v7_0_ring_test_ring(struct amdgpu_ring *ring)
 	unsigned i;
 	int r;
 
-	r = amdgpu_gfx_scratch_get(adev, &scratch);
+	r = amdgpu_device_scratch_get(&adev->gfx.scratch, &scratch);
 	if (r)
 		return r;
 
@@ -2111,7 +2111,7 @@ static int gfx_v7_0_ring_test_ring(struct amdgpu_ring *ring)
 		r = -ETIMEDOUT;
 
 error_free_scratch:
-	amdgpu_gfx_scratch_free(adev, scratch);
+	amdgpu_device_scratch_free(&adev->gfx.scratch, scratch);
 	return r;
 }
 
@@ -2359,7 +2359,7 @@ static int gfx_v7_0_ring_test_ib(struct amdgpu_ring *ring, long timeout)
 	uint32_t tmp = 0;
 	long r;
 
-	r = amdgpu_gfx_scratch_get(adev, &scratch);
+	r = amdgpu_device_scratch_get(&adev->gfx.scratch, &scratch);
 	if (r)
 		return r;
 
@@ -2396,7 +2396,7 @@ static int gfx_v7_0_ring_test_ib(struct amdgpu_ring *ring, long timeout)
 	amdgpu_ib_free(adev, &ib, NULL);
 	dma_fence_put(f);
 err1:
-	amdgpu_gfx_scratch_free(adev, scratch);
+	amdgpu_device_scratch_free(&adev->gfx.scratch, scratch);
 	return r;
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
index e4e779a19c20..d268522b743c 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
@@ -850,7 +850,7 @@ static int gfx_v8_0_ring_test_ring(struct amdgpu_ring *ring)
 	unsigned i;
 	int r;
 
-	r = amdgpu_gfx_scratch_get(adev, &scratch);
+	r = amdgpu_device_scratch_get(&adev->gfx.scratch, &scratch);
 	if (r)
 		return r;
 
@@ -875,7 +875,7 @@ static int gfx_v8_0_ring_test_ring(struct amdgpu_ring *ring)
 		r = -ETIMEDOUT;
 
 error_free_scratch:
-	amdgpu_gfx_scratch_free(adev, scratch);
+	amdgpu_device_scratch_free(&adev->gfx.scratch, scratch);
 	return r;
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
index 06182b7e4351..a383808b566f 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -999,7 +999,7 @@ static int gfx_v9_0_ring_test_ring(struct amdgpu_ring *ring)
 	unsigned i;
 	int r;
 
-	r = amdgpu_gfx_scratch_get(adev, &scratch);
+	r = amdgpu_device_scratch_get(&adev->gfx.scratch, &scratch);
 	if (r)
 		return r;
 
@@ -1024,7 +1024,7 @@ static int gfx_v9_0_ring_test_ring(struct amdgpu_ring *ring)
 		r = -ETIMEDOUT;
 
 error_free_scratch:
-	amdgpu_gfx_scratch_free(adev, scratch);
+	amdgpu_device_scratch_free(&adev->gfx.scratch, scratch);
 	return r;
 }
 
-- 
2.25.1

