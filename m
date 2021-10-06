Return-Path: <SRS0=XefO=O2=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F473C433F5
	for <amd-gfx@archiver.kernel.org>; Wed,  6 Oct 2021 16:04:24 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 190EB610C8
	for <amd-gfx@archiver.kernel.org>; Wed,  6 Oct 2021 16:04:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 190EB610C8
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BB6C06E527;
	Wed,  6 Oct 2021 16:04:23 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam08on2084.outbound.protection.outlook.com [40.107.100.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C08E789133
 for <amd-gfx@lists.freedesktop.org>; Wed,  6 Oct 2021 16:04:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F8SP/9K8M3ZMJB/NGiv6ra4OGp37JvXrHyfUH1v7cvNoNSm0VRCbzabNLsXGnlJd/kkRMoume8vzk5YBkged4Inf0h18EvLko5765I7l+2EokndfCNiOKORqWxOLrz10L6/OwCt0+Q5vyA+aFZYdo8q451+N5Umw/1sWtiYwl4Da8BLnmAyGPwOk/JNNgkIl5y/hO5fUQ+MK40DEe5xoNGN3UryyjLadVr9FdPzqpKqOe6lgi9NJf2IDO/sQpiwJpRh1ytHk2NxFLU+ODKodiaC5R5Uqe71ysRhSLxR7h1Vlil7II/LjCM7xxY+9VZlEggWOVzAtvR7aG8kn1BpUaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WIlqb2b2+8mAzBsCSXMVJUmxDHjkxfiFraHQwzdDsbI=;
 b=LygmHpNGqQ9a05ykZTBjtiKiXgD3R1fp3OtUtVpQjZil/Nb5EXJRdrDrDJNiHcwVQK6XH1YVD5rt6+qdBJHJllsUMnfhl1FrXX3dJv5VgSEWplgk6Ir8cBmtyn4AFof0q8t35eCSgmHsNdtLrv4f3vUaBdI76ZSi6uLYiaL4OodtK8SjOQWUUtopD+zTRuI0ec+Kn+PfGUI8Hk6mwUT+Puf4AId+p++0U2U1JqDUo+5rhxa9EFQqStcZV1NIRh2yUGO0gh/MCPPdDedOq4ZU+X6iOf+o3fxNy72Bw9PhiQq1lQ2Bv3hGVxqlE5Ql3N5fKtY334pNHuvc05F1ejmo9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WIlqb2b2+8mAzBsCSXMVJUmxDHjkxfiFraHQwzdDsbI=;
 b=hr3BjcQWj6NO2DkI+uF1FL8WxsWKh1oKBSG7zH++omUhw3TB6jHlcgF2mAWeKpaHjtX9rxPa349Nw2kNhob/dF+iVlddYefEsZWw9QtTia71ZNSA26BANM+kmcgBrIkRpi28CS6Lx9rCzoEs5QuRbsp4inMQIu8qSw5F/4GMfj8=
Received: from MWHPR13CA0018.namprd13.prod.outlook.com (2603:10b6:300:16::28)
 by DM5PR12MB1754.namprd12.prod.outlook.com (2603:10b6:3:10f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.19; Wed, 6 Oct
 2021 16:04:18 +0000
Received: from CO1NAM11FT065.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:16:cafe::57) by MWHPR13CA0018.outlook.office365.com
 (2603:10b6:300:16::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.8 via Frontend
 Transport; Wed, 6 Oct 2021 16:04:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT065.mail.protection.outlook.com (10.13.174.62) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4587.18 via Frontend Transport; Wed, 6 Oct 2021 16:04:17 +0000
Received: from brihaspati.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Wed, 6 Oct 2021
 11:04:15 -0500
From: Nirmoy Das <nirmoy.das@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Christian.Koenig@amd.com>, Nirmoy Das <nirmoy.das@amd.com>
Subject: [PATCH 1/1] drm/amdgpu: unify BO evicting method in amdgpu_ttm
Date: Wed, 6 Oct 2021 18:04:08 +0200
Message-ID: <20211006160408.118395-1-nirmoy.das@amd.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fca35314-15ac-4c41-0e9b-08d988e2f37f
X-MS-TrafficTypeDiagnostic: DM5PR12MB1754:
X-Microsoft-Antispam-PRVS: <DM5PR12MB1754CC62914D33D03C86088A8BB09@DM5PR12MB1754.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 57m2yI4BsZ0KPu0xARaOWc0T27I3BYKaWgznB6oK4LBUQnava6VIfoD4VHIyPo1s6hIvgUdoOGbtbDtCVmax0CFv+QZmIuqzMg0wxQPmmQNzgGO+IdR/CQOCzcVwtOGSpBhuAEzBN8x9ajJEUbnW/b2GmyxUhbX3vdZ51yGHFMYuZTsN9TSwD5qNk+LaJ5gjXKfpjImtgegfpeQq73vGI83Bt7U//6R4kpkDjP+K/xXytA1lSWgDlfLKJorOzGKa1DrlFw8Trtv94C1yUnzcE3Js9iyG7AI00TSxuNNJk+rXRBTUJ7I0eUWXPjYxjx5qkHBucfVyATaS65hDNANir3ftFtU+CcEbBG/p9+9Yiy0QvIeB90kAtAPdbGCQbBqOtj8rhh0yw6EUnbbs17ngypCpn3vzUHkVGQX/TVQ+iBTQQJUraxdev2vyzDt+eRSX6N3mX2YihlcJuFL30rE54usrQmVwj9RJLkbwLM/oquAxVeQj4ibubNwW6W4CDdTtZcjIU/On+Y1UdWVOCIyuWCnDDVFD14QYuNz6wlgYB/X8tNJSppxexmknuzYOwNEmhk9nvwrhrZQrzrgoRqFK9j8eszwgyJDKKfStw11crfuEbjNY+qYeVF/MhCjzfhUJo31+eXw4nHc3sKvYMUnjpW4NoI+AeoDjqNJYiU5SqST1kMVvH4pZcCDhIvMdv1YKDXjc3QVrmtI2jVxklZyEuwH3uPwhUIpbcC0SOqXACgg=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(81166007)(6666004)(36860700001)(8936002)(8676002)(36756003)(86362001)(356005)(2906002)(47076005)(16526019)(186003)(44832011)(82310400003)(4326008)(6916009)(54906003)(508600001)(1076003)(83380400001)(316002)(26005)(2616005)(426003)(70206006)(5660300002)(7696005)(336012)(70586007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2021 16:04:17.7003 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fca35314-15ac-4c41-0e9b-08d988e2f37f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT065.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1754
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

Unify BO evicting functionality for possible memory
types in amdgpu_ttm.c and remove corresponding function
from amdgpu_object.c.

Signed-off-by: Nirmoy Das <nirmoy.das@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c |  8 +++---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c  |  4 +--
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.c  | 23 ----------------
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.h  |  1 -
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c     | 30 +++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h     |  1 +
 6 files changed, 36 insertions(+), 31 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
index 5497e2d31d1a..22f3de29d783 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
@@ -1328,7 +1328,7 @@ static int amdgpu_debugfs_evict_vram(void *data, u64 *val)
 		return r;
 	}
 
-	*val = amdgpu_bo_evict_vram(adev);
+	*val = amdgpu_bo_evict_memory(adev, TTM_PL_VRAM);
 
 	pm_runtime_mark_last_busy(dev->dev);
 	pm_runtime_put_autosuspend(dev->dev);
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
+	*val = amdgpu_bo_evict_memory(adev, TTM_PL_TT);
 
 	pm_runtime_mark_last_busy(dev->dev);
 	pm_runtime_put_autosuspend(dev->dev);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 57638fe9cfc2..c441ebe9da11 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -3921,7 +3921,7 @@ int amdgpu_device_suspend(struct drm_device *dev, bool fbcon)
 		amdgpu_amdkfd_suspend(adev, adev->in_runpm);
 
 	/* evict vram memory */
-	amdgpu_bo_evict_vram(adev);
+	amdgpu_bo_evict_memory(adev, TTM_PL_VRAM);
 
 	amdgpu_fence_driver_hw_fini(adev);
 
@@ -3930,7 +3930,7 @@ int amdgpu_device_suspend(struct drm_device *dev, bool fbcon)
 	 * This second call to evict vram is to evict the gart page table
 	 * using the CPU.
 	 */
-	amdgpu_bo_evict_vram(adev);
+	amdgpu_bo_evict_memory(adev, TTM_PL_VRAM);
 
 	return 0;
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
index 4ec904f36ceb..073ba2af0b9c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
@@ -1004,29 +1004,6 @@ void amdgpu_bo_unpin(struct amdgpu_bo *bo)
 	}
 }
 
-/**
- * amdgpu_bo_evict_vram - evict VRAM buffers
- * @adev: amdgpu device object
- *
- * Evicts all VRAM buffers on the lru list of the memory type.
- * Mainly used for evicting vram at suspend time.
- *
- * Returns:
- * 0 for success or a negative error code on failure.
- */
-int amdgpu_bo_evict_vram(struct amdgpu_device *adev)
-{
-	struct ttm_resource_manager *man;
-
-	if (adev->in_s3 && (adev->flags & AMD_IS_APU)) {
-		/* No need to evict vram on APUs for suspend to ram */
-		return 0;
-	}
-
-	man = ttm_manager_type(&adev->mman.bdev, TTM_PL_VRAM);
-	return ttm_resource_manager_evict_all(&adev->mman.bdev, man);
-}
-
 static const char *amdgpu_vram_names[] = {
 	"UNKNOWN",
 	"GDDR1",
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
index 8ff61bad4138..d787e0e89e0b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
@@ -305,7 +305,6 @@ int amdgpu_bo_pin(struct amdgpu_bo *bo, u32 domain);
 int amdgpu_bo_pin_restricted(struct amdgpu_bo *bo, u32 domain,
 			     u64 min_offset, u64 max_offset);
 void amdgpu_bo_unpin(struct amdgpu_bo *bo);
-int amdgpu_bo_evict_vram(struct amdgpu_device *adev);
 int amdgpu_bo_init(struct amdgpu_device *adev);
 void amdgpu_bo_fini(struct amdgpu_device *adev);
 int amdgpu_bo_set_tiling_flags(struct amdgpu_bo *bo, u64 tiling_flags);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
index e2896ac2c9ce..545b4bdeae07 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
@@ -2034,6 +2034,36 @@ int amdgpu_fill_buffer(struct amdgpu_bo *bo,
 	return r;
 }
 
+/**
+ * amdgpu_bo_evict_memory - evict memory buffers
+ * @adev: amdgpu device object
+ * @mem_type: evicted BO's memory type
+ *
+ * Evicts all @mem_type buffers on the lru list of the memory type.
+ *
+ * Returns:
+ * 0 for success or a negative error code on failure.
+ */
+int amdgpu_bo_evict_memory(struct amdgpu_device *adev, int mem_type)
+{
+	struct ttm_resource_manager *man;
+
+	switch (mem_type) {
+	case TTM_PL_VRAM:
+	case TTM_PL_TT:
+	case AMDGPU_PL_GWS:
+	case AMDGPU_PL_GDS:
+	case AMDGPU_PL_OA:
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
 #if defined(CONFIG_DEBUG_FS)
 
 static int amdgpu_mm_vram_table_show(struct seq_file *m, void *unused)
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
index e69f3e8e06e5..9ec7531bf131 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
@@ -190,6 +190,7 @@ bool amdgpu_ttm_tt_is_readonly(struct ttm_tt *ttm);
 uint64_t amdgpu_ttm_tt_pde_flags(struct ttm_tt *ttm, struct ttm_resource *mem);
 uint64_t amdgpu_ttm_tt_pte_flags(struct amdgpu_device *adev, struct ttm_tt *ttm,
 				 struct ttm_resource *mem);
+int amdgpu_bo_evict_memory(struct amdgpu_device *adev, int mem_type);
 
 void amdgpu_ttm_debugfs_init(struct amdgpu_device *adev);
 
-- 
2.32.0

