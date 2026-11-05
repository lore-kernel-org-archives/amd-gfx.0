Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2061E606A328
	for <amd-gfx@archiver.kernel.org>; Thu,  5 Nov 2026 03:06:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=gzcRdSzI
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AC8C110F241;
	Thu,  5 Nov 2026 03:06:31 +0000 (UTC)
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012039.outbound.protection.outlook.com [52.101.43.39])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 68EF910E0D3
 for <amd-gfx@lists.freedesktop.org>; Thu,  5 Nov 2026 03:06:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=G6I7pE+EZGhN323ebbiOzqBd7/CtjDSxHPEV7PQnNZylYay0t+NsnFmasqajtiFvPkhWcd/J/UgReRFpjdsm2vxvS7+80k8LP7j1e+tfFmLAOZhRKZNia77RNqAWg/h1PIIHjI25CGiK7m1+OstFiRbgOJk0+jF2zVdqcjFKECq3S3wse9Jhm0WDYdmdFCeLY6ARkFkjHZyGfuvrx0pKxh7LDi51B1whm0fqCVN7zckoJlbTjyyIT6Z6Bq0YlsX8cekbhDfdSkBbu3OXH7QbyZ/AH8zAAdLpEyVNG0CTacEKTxPbU5wSbEWdEpLB2KQL3ErIqLY4icfJryj2f3JX2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H6aQ9lqtbdUSUmmNRH6qdW/8mQDuhsYRSaapbZHn2X8=;
 b=nzSlfKRsEAnBo7F48TuZsEyWGN2Bl/2/Sy59sqq8y9YxlOXwHTiWdX0vS1fqAfS3oIpo7DLLlqLzfo4h3q9AkXuI4o4Rtwqq7be29OsG8lVSVpeNsv7uBdAoYDsvK5pW65qGBZF+usycETYKeFwfHOIPBbO4BGgC0UdDpFug/cdYx0tXxwIqa6d8IyNo2sVTVZKVMaxTbmEFdCS2SuKWFucKpa0kP2oUegHYxLLr7WtM5nscUNEeUPpYQQw1WUNKefTDhb3ZKLLpow6FsjUapZZlzkbc86J6jOmiSyvxGJXpuSauPveU0mZyr7x/L5Vwt0MHSkbb8TCABPIuFT9sSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H6aQ9lqtbdUSUmmNRH6qdW/8mQDuhsYRSaapbZHn2X8=;
 b=gzcRdSzIqAiQaGTb1nX8d4VcNUBhge2ouvKUicVr7MyZiQc8Aidikx6CEH2z+sHIHTKjD36HzWdqngyRMA3KhXwDtJ15+SbyZYdSgMGkmNyOc9VozPuhSBFb9iaUXCQJKjeFjLB7yHc4nYAEY8oqMR3gGrcbc7LXwqZJZTH0FWo=
Received: from CH2PR08CA0013.namprd08.prod.outlook.com (2603:10b6:610:5a::23)
 by CYYPR12MB8869.namprd12.prod.outlook.com (2603:10b6:930:bf::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.9; Thu, 5 Nov 2026
 03:06:21 +0000
Received: from BN2PEPF0000449F.namprd02.prod.outlook.com
 (2603:10b6:610:5a:cafe::6f) by CH2PR08CA0013.outlook.office365.com
 (2603:10b6:610:5a::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.569.12 via Frontend Transport; Thu, 5
 Nov 2026 03:06:21 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BN2PEPF0000449F.mail.protection.outlook.com (10.167.243.150) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.592.5 via Frontend Transport; Thu, 5 Nov 2026 03:06:20 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Wed, 4 Nov
 2026 21:06:20 -0600
Received: from JesseDEV.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.53 via Frontend
 Transport; Wed, 4 Nov 2026 21:06:18 -0600
From: Jesse Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 <Lijo.Lazar@amd.com>, <timur.kristof@gmail.com>, <Mario.Novales@amd.com>, 
 <Manu.Rastogi@amd.com>, <Jiongyu.Zhu@amd.com>, Jesse Zhang
 <Jesse.Zhang@amd.com>
Subject: [PATCH v4 03/13] drm/amdgpu: add an engine scope to the IP block soft
 reset
Date: Thu, 5 Nov 2026 11:05:45 +0800
Message-ID: <20261105030612.726542-3-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20261105030612.726542-1-Jesse.Zhang@amd.com>
References: <20261105030612.726542-1-Jesse.Zhang@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF0000449F:EE_|CYYPR12MB8869:EE_
X-MS-Office365-Filtering-Correlation-Id: 684aa778-aa16-4c37-610f-08df3ae9c490
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|23010399003|1800799024|376014|10067099003|22082099003|18002099003|56012099006|11063799006|261022115727099003|261102123227099003|261026121527099003|261028144727099003|261026140227099003|261021123027099003|261021121427099003|261009223027099003|261022105027099003;
X-Microsoft-Antispam-Message-Info: v2zH9gXgFbUJpQ0e57J+wiZz8kykt34vR0h9P6edFPkxBZLYvtG0wIzVv4ZNqPF5lpwAuzMFUbEL8wQbr7P1WqkFTihi+1g0ZTX5VSoX9dNae53AQq84e+zelNuCvqyU2pqdIt+G/T21vSa4VAgnVamnDC9fa9vcFriMaRKcaFvQiu5HlgsQ1b5DY68FHecYUS6PMLXwSVgWrpYQzrf6GCXmFudVot+9RwTR011k85nxE+NfPi0+CNbyGFncypRrheet1nN4KW8lqv9clbVXIkfWPpJb7PXxGUKFRw9/gXYn00bCsXS5d10b83Od9EmKJtTMVkQ7QbT9Gy9/9iBDBytW1/NZUqXzFapw/pc2LPzxbnV8DNV6Ygrq3KICuiUrM9XL3Z9eBTAO3kCAOPw78oAGl+8RzIvtYqz3b3kWoGMhpPowEK155MOVZfsLgXpgbwnGhb1Be8WZJih8N6gA7OveGKuf9l4ypo+YiMuXUva09JyK5XinWx5tVAYOZD8DdjKJKn8gQsmAOoyQWhFwuf5yYEXgn5TcU6O5Feo3hF8uQZTZ41OGV0CEp2V6Cl5dsPva78yzxuJjvFvS25ddLkQ3NmmTZJSW5n8pWxmtufnHRZ5cWnvNjoTzaDvcHmGZPC8QoNLWL9D62yRD7r9QHvhG+aIaT20M1YUv0rkIgkjYXkzR2m9wVYi2ehpb6cei9MfOKasgQ/Sxt8ImS1pc0g==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(23010399003)(1800799024)(376014)(10067099003)(22082099003)(18002099003)(56012099006)(11063799006)(261022115727099003)(261102123227099003)(261026121527099003)(261028144727099003)(261026140227099003)(261021123027099003)(261021121427099003)(261009223027099003)(261022105027099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 76jVIQgGlucYxW872tlpsqy+qxTis+RF7FFy8nR6+WzvvkeXFg+G7reCnL130xbrgNKkOytwflLB6EbTXxKdHe7W3mmZD+GkW1b6ivT1oYxfsSeW5eCDmKajsw6o50/oap3xVsdmffzVgOzAuqU3KiIXK/oAJHL2lY98a7+Qf1McyoUIWkxigcW+P8vajef0A5/yFdJDlyfu0Mcoxpnz0J3xPybopZj9wDIEJSG8xQrtScraUa3zjLg75Zj55+H3aaBmcrtfn8OEFYMq3I9iOCAWkCDUL7fl13OGGkfIcLEZzJR7HjjkqypTu2bSdVDCptKcxmGqD5Izy+tMmF1B2JsRThunUIwmmJbFVxBdGrH5INJvyxE20jiN6OIFSQHt5oO/jPgyRZ0AYzgBcwjIjBf4Vwg0XOQXSQ9bQuQ2tm8AwZIH214Z2lCCJXToeiFG
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2026 03:06:20.9054 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 684aa778-aa16-4c37-610f-08df3ae9c490
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF0000449F.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8869
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Some IP blocks have engines the hardware can reset on their own, eg.
the graphics and compute engines of the GFX IP. Add an optional
soft_reset_engine() callback, which resets the engine of a ring type and
recovers its user queues. amdgpu_device_ip_soft_reset() uses it instead
of soft_reset(), and then only stops and replays the rings of that type,
holding the reset domain for read: KFD can still add and remove queues
on the other engines.

A hung user queue has no kernel ring, so amdgpu_device_ip_soft_reset()
now takes the device and the ring type, and an optional guilty ring and
user queue.

v3: New patch, replaces the separate engine reset type and helper
    (Timur).
v4: Fold the engine reset into amdgpu_device_ip_soft_reset(), and take
    the ring type instead of a new engine enum (Timur).

Suggested-by: Timur Kristóf <timur.kristof@gmail.com>
Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ip.c   | 59 ++++++++++++++++--------
 drivers/gpu/drm/amd/amdgpu/amdgpu_ip.h   |  7 ++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_job.c  |  3 +-
 drivers/gpu/drm/amd/include/amd_shared.h |  6 +++
 4 files changed, 52 insertions(+), 23 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ip.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ip.c
index d0b0d3eaffc5..9d75bdb2c14b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ip.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ip.c
@@ -421,8 +421,11 @@ static u32 amdgpu_ring_mask_from_ip(const enum amd_ip_block_type ip_type)
 /**
  * amdgpu_device_ip_soft_reset() - Perform a graceful soft reset on an IP block.
  *
- * @guilty_ring: The ring which is guilty of causing a reset.
- * @guilty_fence: The fence which didn't signal.
+ * @adev: amdgpu device
+ * @ring_type: The type of the ring or user queue that hung.
+ * @guilty_ring: The ring which is guilty of causing a reset, or NULL.
+ * @guilty_fence: The fence which didn't signal on @guilty_ring.
+ * @guilty_queue: The user queue which is guilty of causing a reset, or NULL.
  *
  * IP block soft reset is used when attempting to recover
  * from a GPU hang in a situation where a more fine grained
@@ -430,55 +433,71 @@ static u32 amdgpu_ring_mask_from_ip(const enum amd_ip_block_type ip_type)
  * resets all rings that belong to the same device IP block
  * and re-initializes the device IP block.
  *
+ * IP blocks implementing soft_reset_engine() only reset the engine of
+ * @ring_type and its rings, and recover its user queues.
+ *
  * The reset is handled gracefully, meaning that we try to
  * minimize collateral damage (ie. avoid rejecting non-guilty jobs)
  * as well as back up and restore the contents of all rings
  * so that the system can move on from the hang.
  */
-int amdgpu_device_ip_soft_reset(struct amdgpu_ring *guilty_ring,
-				struct amdgpu_fence *guilty_fence)
+int amdgpu_device_ip_soft_reset(struct amdgpu_device *adev,
+				enum amdgpu_ring_type ring_type,
+				struct amdgpu_ring *guilty_ring,
+				struct amdgpu_fence *guilty_fence,
+				struct amdgpu_usermode_queue *guilty_queue)
 {
-	struct amdgpu_device *adev = guilty_ring->adev;
+	const struct amd_ip_funcs *funcs;
 	struct amdgpu_ip_block *ip_block;
 	enum amd_ip_block_type ip_type;
 	u32 ring_type_mask;
+	bool engine;
 	int r;
 
-	ip_type = amdgpu_ip_from_ring(guilty_ring->funcs->type);
+	ip_type = amdgpu_ip_from_ring(ring_type);
 	ip_block = amdgpu_device_ip_get_ip_block(adev, ip_type);
 
 	if (unlikely(!ip_block)) {
-		dev_warn(adev->dev, "IP block not found for ring %s\n",
-			 guilty_ring->name);
+		dev_warn(adev->dev, "IP block not found for ring type %d\n",
+			 ring_type);
 		return -EOPNOTSUPP;
 	}
 
-	if (!ip_block->version->funcs->soft_reset) {
+	funcs = ip_block->version->funcs;
+	engine = funcs->soft_reset_engine;
+	if (!engine && (!funcs->soft_reset || !guilty_ring)) {
 		dev_warn(adev->dev, "IP block soft reset not supported on %s\n",
-			 ip_block->version->funcs->name);
+			 funcs->name);
 		return -EOPNOTSUPP;
 	}
 
-	dev_err(adev->dev, "Starting %s IP block soft reset\n",
-		ip_block->version->funcs->name);
-
-	ring_type_mask = amdgpu_ring_mask_from_ip(ip_type);
+	dev_err(adev->dev, "Starting %s IP block soft reset\n", funcs->name);
 
-	amdgpu_device_lock_reset_domain(adev->reset_domain);
+	/* An engine reset leaves the others running: let KFD add/remove queues. */
+	if (engine) {
+		ring_type_mask = BIT(ring_type);
+		down_read(&adev->reset_domain->sem);
+	} else {
+		ring_type_mask = amdgpu_ring_mask_from_ip(ip_type);
+		amdgpu_device_lock_reset_domain(adev->reset_domain);
+	}
 	amdgpu_multi_ring_reset_helper_begin(adev, ring_type_mask, guilty_ring, guilty_fence);
 
-	r = ip_block->version->funcs->soft_reset(ip_block);
+	r = engine ? funcs->soft_reset_engine(ip_block, ring_type, guilty_queue) :
+		     funcs->soft_reset(ip_block);
 
 	r = amdgpu_multi_ring_reset_helper_end(adev, ring_type_mask, guilty_ring, r);
-	amdgpu_device_unlock_reset_domain(adev->reset_domain);
+	if (engine)
+		up_read(&adev->reset_domain->sem);
+	else
+		amdgpu_device_unlock_reset_domain(adev->reset_domain);
 
 	if (r) {
 		dev_err(adev->dev, "Failed %s IP block soft reset: %d\n",
-			ip_block->version->funcs->name, r);
+			funcs->name, r);
 		return r;
 	}
 
-	dev_err(adev->dev, "Successful %s IP block soft reset\n",
-		ip_block->version->funcs->name);
+	dev_err(adev->dev, "Successful %s IP block soft reset\n", funcs->name);
 	return 0;
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ip.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ip.h
index 5dd6273982c4..6532c16b1a15 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ip.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ip.h
@@ -158,7 +158,10 @@ int amdgpu_device_ip_wait_for_idle(struct amdgpu_device *adev,
 				   enum amd_ip_block_type block_type);
 bool amdgpu_device_ip_is_valid(struct amdgpu_device *adev,
 			       enum amd_ip_block_type block_type);
-int amdgpu_device_ip_soft_reset(struct amdgpu_ring *guilty_ring,
-				struct amdgpu_fence *guilty_fence);
+int amdgpu_device_ip_soft_reset(struct amdgpu_device *adev,
+				enum amdgpu_ring_type ring_type,
+				struct amdgpu_ring *guilty_ring,
+				struct amdgpu_fence *guilty_fence,
+				struct amdgpu_usermode_queue *guilty_queue);
 
 #endif /* __AMDGPU_IP_H__ */
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
index 8689a3c933b2..cb72d273bd52 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
@@ -154,7 +154,8 @@ static enum drm_gpu_sched_stat amdgpu_job_timedout(struct drm_sched_job *s_job)
 	/* Attempt an IP block soft reset, if supported. */
 	if (amdgpu_gpu_recovery &&
 	    amdgpu_ring_is_reset_type_supported(ring, AMDGPU_RESET_TYPE_IP_BLOCK_SOFT_RESET)) {
-		r = amdgpu_device_ip_soft_reset(ring, job->hw_fence);
+		r = amdgpu_device_ip_soft_reset(adev, ring->funcs->type, ring,
+						job->hw_fence, NULL);
 		if (!r) {
 			atomic_inc(&ring->adev->gpu_reset_counter);
 			drm_dev_wedged_event(adev_to_drm(adev), DRM_WEDGE_RECOVERY_NONE, info);
diff --git a/drivers/gpu/drm/amd/include/amd_shared.h b/drivers/gpu/drm/amd/include/amd_shared.h
index e81ce9d79009..06874a338b27 100644
--- a/drivers/gpu/drm/amd/include/amd_shared.h
+++ b/drivers/gpu/drm/amd/include/amd_shared.h
@@ -29,6 +29,7 @@
 
 #define AMD_MAX_USEC_TIMEOUT		1000000  /* 1000 ms */
 struct amdgpu_ip_block;
+struct amdgpu_usermode_queue;
 
 
 /*
@@ -421,6 +422,7 @@ enum DC_DEBUG_MASK {
 };
 
 enum amd_dpm_forced_level;
+enum amdgpu_ring_type;
 
 /**
  * struct amd_ip_funcs - general hooks for managing amdgpu IP Blocks
@@ -441,6 +443,7 @@ enum amd_dpm_forced_level;
  * @complete: handles IP specific changes after resume
  * @wait_for_idle: poll for idle
  * @soft_reset: soft reset the IP block
+ * @soft_reset_engine: soft reset the engine of a ring type and its user queues
  * @set_clockgating_state: enable/disable cg for the IP block
  * @set_powergating_state: enable/disable pg for the IP block
  * @get_clockgating_state: get current clockgating status
@@ -469,6 +472,9 @@ struct amd_ip_funcs {
 	void (*complete)(struct amdgpu_ip_block *ip_block);
 	int (*wait_for_idle)(struct amdgpu_ip_block *ip_block);
 	int (*soft_reset)(struct amdgpu_ip_block *ip_block);
+	int (*soft_reset_engine)(struct amdgpu_ip_block *ip_block,
+				 enum amdgpu_ring_type ring_type,
+				 struct amdgpu_usermode_queue *guilty_queue);
 	int (*set_clockgating_state)(struct amdgpu_ip_block *ip_block,
 				     enum amd_clockgating_state state);
 	int (*set_powergating_state)(struct amdgpu_ip_block *ip_block,
-- 
2.50.1

