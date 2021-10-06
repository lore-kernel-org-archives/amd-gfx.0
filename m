Return-Path: <SRS0=XefO=O2=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94CD2C433EF
	for <amd-gfx@archiver.kernel.org>; Wed,  6 Oct 2021 14:45:48 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 51F9661074
	for <amd-gfx@archiver.kernel.org>; Wed,  6 Oct 2021 14:45:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 51F9661074
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CBB8C6ECFB;
	Wed,  6 Oct 2021 14:45:47 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2052.outbound.protection.outlook.com [40.107.243.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 254606ECB5
 for <amd-gfx@lists.freedesktop.org>; Wed,  6 Oct 2021 14:45:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MIMQCgxrG4BDSDCBd1KeDOBD7B2caBY52LgRap3h6Lbp7WIp2UKjRZCGZ0/JyNmNJFWcLlMvd8xH9Rc3HWBkAVHfdUpp9CYejTOpd6yFHCvWHZL3oigUrM4Ev0Ic0opZfp2LUeyjTt9CN3wXgxx3/lMA4Suaf8HiDjGBjKp44bqsl6ZWk1NbO1Eigay0NccZFsJ78fCBaqy6aNcwtwjfgwhMb1yQzh7X5h/uD2xxnTrBy6cEc6PIV93+PNp5ZSXPhupgHRVhhLfF4ROvsy6OfGfDwoEl4cfQl9bpzj1SJk/Pv9oUe/pTjAWYA6ATHYKepv0Tib4e0sv1LMhcSMixuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6nPAiVpsYjF79XqRauDoycRkwspuc98/L5wb5ee4cYQ=;
 b=B8trpicPGaLZRLY/c2mnvdoNn0XHkjLi08BDT/0QScClFQbXS5kuOvF3wcn6eF9K12MEQ4Oh3mLWNNK4lD8quyivWL4C+C7GE+/UGtVnfOJtNBG2UrrfyBPNbeNNKE23HzbFwVECH89rpVzWXGlq5o8uD6C8oVvnVhBAiAng7sv6ka91qDfx3rdCFWpWyI3Y9Ne5k6gVT2Q1vXsNSRpsKiWSG9vDSN3G6IFu1YFMbiRoZlC0pbb6ARWH1/ZVL+QncNMuY9OjC/eaL2XMM9g2FG/lPrLgGfjC7wnZnNqkr6yRYUa9TNMvSLnCzlMJvpKHDYV29KfPDJH5hods8OwUIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6nPAiVpsYjF79XqRauDoycRkwspuc98/L5wb5ee4cYQ=;
 b=nQu+HvqKDGrwZyYPlVeCCYXyJVi/3RFG5GE9QOPlESE/xa9s3pFcFEwPmyTMlr8mHFU2KdI5uyLCLWN0ZjTgUGJcZb5Gwrtb4fosSwvxoNFhLh94O6ewDlrbgnr3SYTo4iwEbrO0+ia0YMmwkDzJXCYrC0xd7CHDJC67pKM+jMc=
Received: from DM3PR12CA0119.namprd12.prod.outlook.com (2603:10b6:0:51::15) by
 MWHPR1201MB2558.namprd12.prod.outlook.com (2603:10b6:300:e5::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.19; Wed, 6 Oct
 2021 14:45:42 +0000
Received: from DM6NAM11FT009.eop-nam11.prod.protection.outlook.com
 (2603:10b6:0:51:cafe::9b) by DM3PR12CA0119.outlook.office365.com
 (2603:10b6:0:51::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.22 via Frontend
 Transport; Wed, 6 Oct 2021 14:45:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT009.mail.protection.outlook.com (10.13.173.20) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4587.18 via Frontend Transport; Wed, 6 Oct 2021 14:45:41 +0000
Received: from brihaspati.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Wed, 6 Oct 2021
 09:45:39 -0500
From: Nirmoy Das <nirmoy.das@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Christian.Koenig@amd.com>, Nirmoy Das <nirmoy.das@amd.com>
Subject: [PATCH 1/1] drm/amdgpu: add and use amdgpu_bo_evict_gtt
Date: Wed, 6 Oct 2021 16:45:29 +0200
Message-ID: <20211006144529.61208-1-nirmoy.das@amd.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2190eea2-17bf-4169-3868-08d988d7f8a7
X-MS-TrafficTypeDiagnostic: MWHPR1201MB2558:
X-Microsoft-Antispam-PRVS: <MWHPR1201MB25585E770064E604ED634A588BB09@MWHPR1201MB2558.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4iUoetAuDeEHrqGFNcNIihgEG4V3XjIjPQhAjxOE021tBEfBotlGdMVjPPcWAqARXw1GKcFtsH+ZgMmzNfM4kLPGGPwBqWjX9r6TEIETV69MD/pB8Jsac9bM8aCwYMk9AKGVeRELk6US0ltnrcsRTUSkTsJr0IF+5x+ihOt/aHnTI8rE0gLY8lwffO9rGAVaK9r/3abS07/eFEZuDuBmWtRTdSKOubD0yKToM2HWohwolp5YbXAxq+8iMJaVPWqRi7sDwDi1/qSE889WMpz8mEb/WS0DQAc9VZJQJSG/jX79EezrLj3YTuflYJua8mjxyk9fQG20+6mdf+Nb3ggMBXMQ+lX61u1IQ1EenlCeEQnHj9/aBWTpocCqcHafBqc2avqt1vDH2Hj+Vhd9OBJHU+5IqJjiTNPMN624d4AqWQn4LMPdaq/zQy/h3a3w/eYFKeQKsF3iE9uw5G4RXyEtAq6tsWsHiTDdjSDINT1+ZKuLZqpJPifem4qe3l7IK9ozp8JQlGCFSxpl5xQG/Wa3HIPyRps+y5yev3peb43wEP2DFnkQRcYDPL2JoplEATFukKZf578FTrsAjv5vFgWEU/4FE6mt4HgrFwW+YxRfR0obkSMBqlQZE+Ey6rK6CgAWWmTI0lpbRhM6BhEdAfqWFKR3z2nGdCS2oaZExP9WizZWBsiglA16VrrFnZAcWwjpMwDUooc3Jgv3z3IREFl+8QsM4MnMW3xbNVYPTTvspHA=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(36860700001)(336012)(4326008)(44832011)(6666004)(6916009)(36756003)(16526019)(82310400003)(83380400001)(86362001)(426003)(47076005)(70206006)(186003)(7696005)(8676002)(5660300002)(1076003)(316002)(2906002)(356005)(2616005)(81166007)(8936002)(54906003)(508600001)(70586007)(26005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2021 14:45:41.9910 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2190eea2-17bf-4169-3868-08d988d7f8a7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT009.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1201MB2558
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

Unify BO evicting functionality for VRAM and TT memory
types in amdgpu_object.c. Use amdgpu_bo_evict_gtt()
for evicting gtt memory similar to how we do that
for amdgpu_debugfs_evict_vram().

Signed-off-by: Nirmoy Das <nirmoy.das@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c |  6 +--
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.c  | 52 +++++++++++++++++++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.h  |  1 +
 3 files changed, 50 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
index 5497e2d31d1a..67045983d63d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
@@ -1341,17 +1341,15 @@ static int amdgpu_debugfs_evict_gtt(void *data, u64 *val)
 {
 	struct amdgpu_device *adev = (struct amdgpu_device *)data;
 	struct drm_device *dev = adev_to_drm(adev);
-	struct ttm_resource_manager *man;
 	int r;
 
 	r = pm_runtime_get_sync(dev->dev);
 	if (r < 0) {
-		pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);
+		pm_runtime_put_autosuspend(dev->dev);
 		return r;
 	}
 
-	man = ttm_manager_type(&adev->mman.bdev, TTM_PL_TT);
-	*val = ttm_resource_manager_evict_all(&adev->mman.bdev, man);
+	*val = amdgpu_bo_evict_gtt(adev);
 
 	pm_runtime_mark_last_busy(dev->dev);
 	pm_runtime_put_autosuspend(dev->dev);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
index 4ec904f36ceb..3b8c9cf44d74 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
@@ -1005,10 +1005,37 @@ void amdgpu_bo_unpin(struct amdgpu_bo *bo)
 }
 
 /**
- * amdgpu_bo_evict_vram - evict VRAM buffers
+ * amdgpu_bo_evict_memory - evict memory buffers
  * @adev: amdgpu device object
+ * @mem_type: evicted BO's memory type
  *
- * Evicts all VRAM buffers on the lru list of the memory type.
+ * Evicts all @mem_type buffers on the lru list of the memory type.
+ *
+ * Returns:
+ * 0 for success or a negative error code on failure.
+ */
+static int amdgpu_bo_evict_memory(struct amdgpu_device *adev, int mem_type)
+{
+	struct ttm_resource_manager *man;
+
+	switch (mem_type) {
+	case TTM_PL_VRAM:
+	case TTM_PL_TT:
+		man = ttm_manager_type(&adev->mman.bdev, mem_type);
+		break;
+	default:
+		DRM_ERROR("Trying to evict invalid memory type\n");
+		return -EINVAL;
+	}
+
+	return ttm_resource_manager_evict_all(&adev->mman.bdev, man);
+}
+
+/**
+ * amdgpu_bo_evict_vram - evict vram buffers
+ * @adev: amdgpu device object
+ *
+ * Evicts all vram buffers on the lru list of the memory type.
  * Mainly used for evicting vram at suspend time.
  *
  * Returns:
@@ -1016,17 +1043,32 @@ void amdgpu_bo_unpin(struct amdgpu_bo *bo)
  */
 int amdgpu_bo_evict_vram(struct amdgpu_device *adev)
 {
-	struct ttm_resource_manager *man;
 
 	if (adev->in_s3 && (adev->flags & AMD_IS_APU)) {
 		/* No need to evict vram on APUs for suspend to ram */
 		return 0;
 	}
 
-	man = ttm_manager_type(&adev->mman.bdev, TTM_PL_VRAM);
-	return ttm_resource_manager_evict_all(&adev->mman.bdev, man);
+	return amdgpu_bo_evict_memory(adev, TTM_PL_VRAM);
+}
+
+/**
+ * amdgpu_bo_evict_gtt - evict gtt buffers
+ * @adev: amdgpu device object
+ *
+ * Evicts all gtt buffers on the lru list of the memory type.
+ * Mainly used for evicting gtt buffers through debugfs.
+ *
+ * Returns:
+ * 0 for success or a negative error code on failure.
+ */
+
+int amdgpu_bo_evict_gtt(struct amdgpu_device *adev)
+{
+	return amdgpu_bo_evict_memory(adev, TTM_PL_TT);
 }
 
+
 static const char *amdgpu_vram_names[] = {
 	"UNKNOWN",
 	"GDDR1",
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
index 8ff61bad4138..5e9b7710b8e3 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
@@ -306,6 +306,7 @@ int amdgpu_bo_pin_restricted(struct amdgpu_bo *bo, u32 domain,
 			     u64 min_offset, u64 max_offset);
 void amdgpu_bo_unpin(struct amdgpu_bo *bo);
 int amdgpu_bo_evict_vram(struct amdgpu_device *adev);
+int amdgpu_bo_evict_gtt(struct amdgpu_device *adev);
 int amdgpu_bo_init(struct amdgpu_device *adev);
 void amdgpu_bo_fini(struct amdgpu_device *adev);
 int amdgpu_bo_set_tiling_flags(struct amdgpu_bo *bo, u64 tiling_flags);
-- 
2.32.0

