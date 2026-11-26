Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39FFC606A31C
	for <amd-gfx@archiver.kernel.org>; Thu, 26 Nov 2026 09:34:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=CB561Aam
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9F5A7112220;
	Thu, 26 Nov 2026 09:34:47 +0000 (UTC)
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010055.outbound.protection.outlook.com
 [40.93.198.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 90B201121FE
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Nov 2026 09:34:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=imUbzfNwVLXOPlhY1WSJdYWuzqFVrrEwWtwvkGDoUHZYaI7teBNpcpF5aHPa5dazOm6qVebgwJTPlXNc5c7Awwsx/w1p2vaOmPTkwqkLnFut0h8M86eqHF0T8mX2rP8Sf/XLSoK2v4JsfaR0MR2t7WFIowXCF/B0dOdXx2DwQuOWqFoJDRgP3PlOhpNyV7EYm1DzDBPMN773QJKwj3HTDiko00DUd6baWbPmckJz294XByLnDO2tU9pl+NQeGK2q6+ALdwvc0zw2/QStMKqudKt4eBNRSaHopmy2UeeMOag2XJslUs3b1kXFdjIA1B7/ZEJUc2sGC5M41mL1fu6gkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IvvzXNN5Yw3xsf4sNArJMoZAH/ig/4T3z2OxMeJe1k4=;
 b=wsB04bthWrDAoPLAstqerGbJ+CeD2Gzr+jJHAWecgSnDuabIug6Zi7uXJ0HT4akiaNXrG3ZYu9czNS2KmrstRrqwuwbYrfmCOCMXJopXavT2XNtRIOZLKcmLi5sPkh9x5QVGLgpLLLUQBQzMDd0tVZ5DR+mqhE9mCyND9zUaAhhU5Ea3c1LX6r5y9NDZ/il6O2zaWSLAHEbTm+8g3XnmmzsGxHGtzHmlRpFT1g60UVHSnBJWD0nIAXEvMdCfE+1/a7NPFCWJTF6Jfg3aS75dqaaRjlIWAWp97Lw83vE8tzBM2FMYb95A+5L65K/t/MZ1pOFWZPqOGY4mP2WrEbdh+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IvvzXNN5Yw3xsf4sNArJMoZAH/ig/4T3z2OxMeJe1k4=;
 b=CB561AamdvsrXGZleRHLfR1vaN0Cn/9wExQ98BNWu++TfbWzYm/sPV/qImJ0wIeV3q0ay/Bo8N+ilRyIWsddyWy7Dl0TEvPfhFNRykVx2+fBIogM1Js1SDKfBhi/B/5IftUB0LQV+BWpfKhzhzYnJQLmVl+XizQXTFf8LvMX/EU=
Received: from LV3P220CA0004.NAMP220.PROD.OUTLOOK.COM (2603:10b6:408:234::16)
 by PH0PR12MB8798.namprd12.prod.outlook.com (2603:10b6:510:28d::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.7; Thu, 26 Nov
 2026 09:34:31 +0000
Received: from BN7PEPF0000009D.namprd04.prod.outlook.com
 (2603:10b6:408:234:cafe::24) by LV3P220CA0004.outlook.office365.com
 (2603:10b6:408:234::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.662.7 via Frontend Transport; Thu, 26
 Nov 2026 09:34:31 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN7PEPF0000009D.mail.protection.outlook.com (10.167.248.149) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.662.3 via Frontend Transport; Thu, 26 Nov 2026 09:34:30 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Thu, 26 Nov
 2026 03:34:30 -0600
Received: from JesseDEV.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.57 via Frontend
 Transport; Thu, 26 Nov 2026 03:34:28 -0600
From: Jesse Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 <Lijo.Lazar@amd.com>, <timur.kristof@gmail.com>, <Mario.Novales@amd.com>, 
 <Manu.Rastogi@amd.com>, <Jiongyu.Zhu@amd.com>, Jesse Zhang
 <Jesse.Zhang@amd.com>
Subject: [PATCH v5 03/15] drm/amdgpu: add an engine scope to the IP block soft
 reset
Date: Thu, 26 Nov 2026 17:33:39 +0800
Message-ID: <20261126093417.192538-3-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20261126093417.192538-1-Jesse.Zhang@amd.com>
References: <20261126093417.192538-1-Jesse.Zhang@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN7PEPF0000009D:EE_|PH0PR12MB8798:EE_
X-MS-Office365-Filtering-Correlation-Id: f6cfe498-53f8-4b2d-3e3e-08df4ba07923
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700016|23010399003|82310400026|1800799024|10067099003|11063799006|56012099006|261021123027099003|261021121427099003|261009223027099003|261102123227099003|261022075727099003|261022105027099003|261022115727099003|261026140227099003|261026121527099003|261028144727099003|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info: 58UcNGYUjFH7vsPvW5qDUxQxweQ26Uk7XmDL45I9zcIcyINJno87xsFLHlV2dubzlhytohSlKje8+Cssw3mRgzorVX4O42qjlOWgxGLpN/WZeiM2ZCdMPv5Ocsd+bJfHbz8u0RPDu1dnWTUVM78hJ+D4xAdKaW2O55bysfPu8PEmKh+uFdKx3Nb4UP5Q/OrBomzV2jBH3X18LCcNuy9K7gY8IQwbzJ1rFXXcZdBRbMBA4bQiOgwJN+zKJLVqShkqViHaRKqcpXQlSAG9MNDX3JDqZvMpB2FxKS1EFdcB6KiH5AUNUTtavAfNoCFkmYOVT5/+zz4QN3Liy6gaj61bu15rDjDN9X2iYTjuy9p5TCzmUk63KftLuJPljYIJ7hcaKV7Gsov8JJk6debok9tHU5els3rLXCRZQXKhqN2wNKx2a/HryzZvP1OdgwfDpet2NIGY1VZ7RLaqW1TLlIGOvmB5nQditfEQo0iM8hExjnZNRDXl2JcmiyobZV9W3VCbVuS6sJKrFxgYQActsGbFEQPhqdpRPKGFArbmYyYY1F8bUId5bMRuB1ZlaVUz6A5aJ2ziWCvf1iJ+T1ch+uz7mFxPoMj0UEFEmVfTDy0qX/1I8AxMRpsq9W9NWDbblACFHs7vVF/W+Ys09GIjLRVTCOC8Ai5I+OWkIbcfFLB+G+yaaKrLwKlmAlZgDcccKAiUhB1NN89uaU/cFoDPvMLFHw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700016)(23010399003)(82310400026)(1800799024)(10067099003)(11063799006)(56012099006)(261021123027099003)(261021121427099003)(261009223027099003)(261102123227099003)(261022075727099003)(261022105027099003)(261022115727099003)(261026140227099003)(261026121527099003)(261028144727099003)(18002099003)(22082099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: zdRcFbDM6re78wH58vvN+W/xF6ej00D6Sjtsd1rU61s+2ncag46nnwu6UbzPMMwOdKPCzJXrmoU4tKVcSAO2K6p4IO6PB3dgFTbKse3bZ2MuGTiHlVR6YxxolG+MRXm5nwVfJkR8+0SaG9Z6QxVNSMjpVPUjNaCNtFmj0K+AojqkgH8k3/R7nswteXp8w+x/t0pQB6uPe/2KUINXFtG+c/2skxBeK1HmkXq1/pApyuPyV0xX/S2X7E4K4WVNytcCzu94ZG6z4uPWdTRgmew/p2UyXPOHmN8bFu8c/enyXJAPfXmLjC9FqqOFFt64HjMe+FJP0GOGq++w21tm75lLPlkOyH+gSQtOMbXFrFbjbaqUPfs2Ho3H7GCbGG3cb2NL12xDl2gVumkZjJXAyPO53v3SjCehMOnEgVpW2j3q+efkfrvB+fEcUwda8tgDiXzA
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2026 09:34:30.8719 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f6cfe498-53f8-4b2d-3e3e-08df4ba07923
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN7PEPF0000009D.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8798
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
now takes the device, the ring type and the instance of the engine, and
an optional guilty ring and user queue. On a ring timeout, the instance
is the XCC of the gfx and compute rings, and ring->me of the others.

v3: New patch, replaces the separate engine reset type and helper
    (Timur).
v4: Fold the engine reset into amdgpu_device_ip_soft_reset(), and take
    the ring type instead of a new engine enum (Timur).
    Pass the instance of the engine, needed for the user queues (Lijo).

Suggested-by: Timur Kristóf <timur.kristof@gmail.com>
Reviewed-by: Timur Kristóf <timur.kristof@gmail.com>
Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ip.c   | 60 ++++++++++++++++--------
 drivers/gpu/drm/amd/amdgpu/amdgpu_ip.h   |  7 ++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_job.c  | 16 ++++++-
 drivers/gpu/drm/amd/include/amd_shared.h |  7 +++
 4 files changed, 67 insertions(+), 23 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ip.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ip.c
index d0b0d3eaffc5..79bc275e3e0f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ip.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ip.c
@@ -421,8 +421,12 @@ static u32 amdgpu_ring_mask_from_ip(const enum amd_ip_block_type ip_type)
 /**
  * amdgpu_device_ip_soft_reset() - Perform a graceful soft reset on an IP block.
  *
- * @guilty_ring: The ring which is guilty of causing a reset.
- * @guilty_fence: The fence which didn't signal.
+ * @adev: amdgpu device
+ * @ring_type: The type of the ring or user queue that hung.
+ * @inst: The instance of the engine that hung, eg. the XCC or SDMA instance.
+ * @guilty_ring: The ring which is guilty of causing a reset, or NULL.
+ * @guilty_fence: The fence which didn't signal on @guilty_ring.
+ * @guilty_queue: The user queue which is guilty of causing a reset, or NULL.
  *
  * IP block soft reset is used when attempting to recover
  * from a GPU hang in a situation where a more fine grained
@@ -430,55 +434,71 @@ static u32 amdgpu_ring_mask_from_ip(const enum amd_ip_block_type ip_type)
  * resets all rings that belong to the same device IP block
  * and re-initializes the device IP block.
  *
+ * IP blocks implementing soft_reset_engine() only reset the engine of
+ * @ring_type on instance @inst and its rings, and recover its user queues.
+ *
  * The reset is handled gracefully, meaning that we try to
  * minimize collateral damage (ie. avoid rejecting non-guilty jobs)
  * as well as back up and restore the contents of all rings
  * so that the system can move on from the hang.
  */
-int amdgpu_device_ip_soft_reset(struct amdgpu_ring *guilty_ring,
-				struct amdgpu_fence *guilty_fence)
+int amdgpu_device_ip_soft_reset(struct amdgpu_device *adev,
+				enum amdgpu_ring_type ring_type, u32 inst,
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
+	r = engine ? funcs->soft_reset_engine(ip_block, ring_type, inst, guilty_queue) :
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
index 5dd6273982c4..133e7c849a56 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ip.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ip.h
@@ -158,7 +158,10 @@ int amdgpu_device_ip_wait_for_idle(struct amdgpu_device *adev,
 				   enum amd_ip_block_type block_type);
 bool amdgpu_device_ip_is_valid(struct amdgpu_device *adev,
 			       enum amd_ip_block_type block_type);
-int amdgpu_device_ip_soft_reset(struct amdgpu_ring *guilty_ring,
-				struct amdgpu_fence *guilty_fence);
+int amdgpu_device_ip_soft_reset(struct amdgpu_device *adev,
+				enum amdgpu_ring_type ring_type, u32 inst,
+				struct amdgpu_ring *guilty_ring,
+				struct amdgpu_fence *guilty_fence,
+				struct amdgpu_usermode_queue *guilty_queue);
 
 #endif /* __AMDGPU_IP_H__ */
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
index 8689a3c933b2..8d33ae680c5e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
@@ -85,6 +85,18 @@ static void amdgpu_job_core_dump(struct amdgpu_device *adev,
 	}
 }
 
+/* The instance of the IP block engine the ring runs on. */
+static u32 amdgpu_job_ring_inst(struct amdgpu_ring *ring)
+{
+	switch (ring->funcs->type) {
+	case AMDGPU_RING_TYPE_GFX:
+	case AMDGPU_RING_TYPE_COMPUTE:
+		return ring->xcc_id;
+	default:
+		return ring->me;
+	}
+}
+
 static enum drm_gpu_sched_stat amdgpu_job_timedout(struct drm_sched_job *s_job)
 {
 	struct amdgpu_ring *ring = to_amdgpu_ring(s_job->sched);
@@ -154,7 +166,9 @@ static enum drm_gpu_sched_stat amdgpu_job_timedout(struct drm_sched_job *s_job)
 	/* Attempt an IP block soft reset, if supported. */
 	if (amdgpu_gpu_recovery &&
 	    amdgpu_ring_is_reset_type_supported(ring, AMDGPU_RESET_TYPE_IP_BLOCK_SOFT_RESET)) {
-		r = amdgpu_device_ip_soft_reset(ring, job->hw_fence);
+		r = amdgpu_device_ip_soft_reset(adev, ring->funcs->type,
+						amdgpu_job_ring_inst(ring), ring,
+						job->hw_fence, NULL);
 		if (!r) {
 			atomic_inc(&ring->adev->gpu_reset_counter);
 			drm_dev_wedged_event(adev_to_drm(adev), DRM_WEDGE_RECOVERY_NONE, info);
diff --git a/drivers/gpu/drm/amd/include/amd_shared.h b/drivers/gpu/drm/amd/include/amd_shared.h
index db24bacb8e0e..8087318c007d 100644
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
@@ -441,6 +443,8 @@ enum amd_dpm_forced_level;
  * @complete: handles IP specific changes after resume
  * @wait_for_idle: poll for idle
  * @soft_reset: soft reset the IP block
+ * @soft_reset_engine: soft reset one instance of the engine of a ring type and
+ *                     its user queues
  * @set_clockgating_state: enable/disable cg for the IP block
  * @set_powergating_state: enable/disable pg for the IP block
  * @get_clockgating_state: get current clockgating status
@@ -472,6 +476,9 @@ struct amd_ip_funcs {
 	void (*complete)(struct amdgpu_ip_block *ip_block);
 	int (*wait_for_idle)(struct amdgpu_ip_block *ip_block);
 	int (*soft_reset)(struct amdgpu_ip_block *ip_block);
+	int (*soft_reset_engine)(struct amdgpu_ip_block *ip_block,
+				 enum amdgpu_ring_type ring_type, u32 inst,
+				 struct amdgpu_usermode_queue *guilty_queue);
 	int (*set_clockgating_state)(struct amdgpu_ip_block *ip_block,
 				     enum amd_clockgating_state state);
 	int (*set_powergating_state)(struct amdgpu_ip_block *ip_block,
-- 
2.50.1

