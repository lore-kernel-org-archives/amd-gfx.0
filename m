Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 916C9C36010
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Apr 2025 03:02:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0113F10E091;
	Wed,  2 Apr 2025 03:02:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="IpNjEjyT";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2079.outbound.protection.outlook.com [40.107.236.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7A83C10E091
 for <amd-gfx@lists.freedesktop.org>; Wed,  2 Apr 2025 03:02:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QAOlk5jVbUCz5ZW9uvy7tOU/6Mq5I5tDDdPXeGknE8KbmsEezzKhG+GYUyHN0P3AN81OfkzsEO1dImtdjuVDXrAZZ3TJ2n2HmOFreTXhH9hYU/ZZsD3eqZUAlkuymHm60OWL6ClBn0qRmi/kFDoO6uCbWw58d7USzLV7CGqRJT7CoPalN3dFu7zCCNXPNIuHYJT+QtTeb2dSwCRF/swCuaV6cEpIbzKFLNjz/0i9EgVEoyhF1x33eJ8WeMHS9buucdxAUhG457icGrIQGKfJWmow6BCGlcxucCkhjQRvBpSj48FYbMO7UaR06TbRf+1SqYmjeUiPFEQ+D9/tTuQivw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PzyfO3qz7Je3HemewTUW1LNrrZbIDzPeVT2RCYsEICk=;
 b=bbRsX5lGI8s8wlbWx9P3AMFRycZMsksghJjXKRhv3o2WskY5Z+htL9hvSbOgTRfjoBaNWeVbeIiuIDqzFi2PXPr2fT4kmae1e/v5jxb0LnZ503x1Oh+8ZjiyNohGAbNQdrT1C+0TwNbfowgd7mcUH4yLdOYhC9qXdX/elptjcR5K2R97yEP1Q1rIlO+EtX1Qv+Aoj8wg65dijhOLAlmW85wVYgZCWHBlRxgZWqnDy0Wy2OazOHS4yzBkGHejmdndGGoLYbAXYEw8ckc+FrxyeS6QVL5CVYlID3i8Pj1rbiJWf9KWS7XC3qGFV48cedv4mAtobYDgTed3lHqW3Qpcuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PzyfO3qz7Je3HemewTUW1LNrrZbIDzPeVT2RCYsEICk=;
 b=IpNjEjyTH1D+OiHM7VqMz3HDwd1q5wwnb9IWsYbqicMTv9JUq0kSp0Q9PS7M7rzDpdK6Sn1OTZ/gSocidhsDhZnSnusdL5x1yk+EuVq5aNZadUR4GOVbnHv+9jpLwjtTtQCbjsn23+8b6HyVg1yU06OmJhQ0zd7glVy0BYm/dQ8=
Received: from SJ0PR13CA0143.namprd13.prod.outlook.com (2603:10b6:a03:2c6::28)
 by CY3PR12MB9578.namprd12.prod.outlook.com (2603:10b6:930:109::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8583.41; Wed, 2 Apr
 2025 03:02:30 +0000
Received: from SJ1PEPF00001CDD.namprd05.prod.outlook.com
 (2603:10b6:a03:2c6:cafe::54) by SJ0PR13CA0143.outlook.office365.com
 (2603:10b6:a03:2c6::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8606.21 via Frontend Transport; Wed,
 2 Apr 2025 03:02:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00001CDD.mail.protection.outlook.com (10.167.242.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8606.22 via Frontend Transport; Wed, 2 Apr 2025 03:02:29 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 1 Apr
 2025 22:02:28 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 1 Apr
 2025 22:02:27 -0500
Received: from JesseDEV.guestwireless.amd.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Tue, 1 Apr 2025 22:02:21 -0500
From: <jesse.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <christian.koenig@amd.com>,
 <jonathan.kim@amd.com>, <jiadong.zhu@amd.com>, "Jesse.zhang@amd.com"
 <jesse.zhang@amd.com>, Jesse Zhang <Jesse.Zhang@amd.com>
Subject: [PATCH 1/7 V2] drm/amd/amdgpu: Simplify SDMA reset mechanism by
 removing dynamic callbacks
Date: Wed, 2 Apr 2025 11:02:09 +0800
Message-ID: <20250402030215.1074975-1-jesse.zhang@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CDD:EE_|CY3PR12MB9578:EE_
X-MS-Office365-Filtering-Correlation-Id: 307c76c4-ae9a-4775-3c21-08dd7192ce5d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?GbZDuzWH4I+zVXtLW3v3/eBfG4XByFgk7qbNb4YnWhujFpNsekAQWWgPIXtT?=
 =?us-ascii?Q?FmBw5/8gIg+Xna/gO8DMp2QII2XKYn/Z0NdOKnmxNv29dv2b+aIDHKa5ITVB?=
 =?us-ascii?Q?TPYWmw8Hxh/FLiWixzzlMOxdyR4MygFymKUib63cdiF1BM8rqJNBsi3db+zH?=
 =?us-ascii?Q?UNY9w76w27hlxBdNw+irJiFki9QEvuj9x/KmDDNXpDoW+2YCfmhwklHLEG9J?=
 =?us-ascii?Q?Xfqgl4ScvQZTJF7W0UjAmyn80ecXWWjoChEk34TH3oTHRq3v4czppZQ5AuJj?=
 =?us-ascii?Q?QLnTy2hioXbUbaXr01YIJseUxxbz78/VlebeLN9XVfhsfgnP1l/yugHQ2HlY?=
 =?us-ascii?Q?7OsE+nrYVamilxp6di2HnoSuYDy1Dl2C5RZT418WvcPmbN7z1k1c0sbTHcr/?=
 =?us-ascii?Q?aMmJc9y2JT5yNYByrZrpLpwYVhgJ0nZ/+7B7uTbs/YCRAj+ckO43EhEzTvts?=
 =?us-ascii?Q?EEQGRxP3hYbi08Fv52o0i5oiBqn4og16WruYxn5RQSUUdozXWhfBf0Fu/kvb?=
 =?us-ascii?Q?A7kzIAGboWq38PumO4UZNf/FwWbr3EXxcgH78qxARwXRVBmy2qkBGf7+1sY7?=
 =?us-ascii?Q?xTM5BJ5+poPDc0jXCak8xP/P9I4KIzbP+m9PhQl5y5LvCzZhuAXcDNAzW6Cz?=
 =?us-ascii?Q?CC4nbZhzSSLpI9XgTEua795AWUBSB/BU23nXz8RBdEOSuE9v7QdXUq/iA4kS?=
 =?us-ascii?Q?PzEz8WAyBOiiE/5KiOI7t/mFig7kWtQBFnTVGqRrZ8AJhUQVZ1bzHzx0yN2P?=
 =?us-ascii?Q?wKJ4rTuQmenr9uhQqEKtoIJNY5rPNQUCrd77loEwd2+pS227E3jCAd2KpPw9?=
 =?us-ascii?Q?KIgHZwtq0o3dX5CHn3MVSU7xmWFKzjddsYepeNoVh+zh2spR/GUH35PPEA63?=
 =?us-ascii?Q?fnJxceIlgO1RDGo3chCJjd7+XGudh06ivX0wRYXDrIxPP+3KQvV3Fv4jgVE0?=
 =?us-ascii?Q?OXxH80ELq53xv96Pa6tSI9D0E6CZNR0gtwddkGnEX9lvopOhLvDcNo50A81S?=
 =?us-ascii?Q?bzZol2jH5vtGRuDEjJ3C6Iq8sfbXuTJ3S1QEYHl5Rk91NY9yh++/qmOUdnLc?=
 =?us-ascii?Q?NvjKm2u7DaY1zGWB6gy2PSXUhWIS0hjXq0iE2mUvHI0ZpGxr1JUVOL5wytNK?=
 =?us-ascii?Q?QgxWIbQxQooD4UCOr73S2Rh86KRPMnGoBDSL7ItthREYYT4LIvq1pCA9Xw0k?=
 =?us-ascii?Q?j7aX++ETgUE1y6k5tJfAXMwqcn7DZvbrArVpLarvEXzJ6KG9/F85E1TI/2dq?=
 =?us-ascii?Q?YZy10NH1JyRyWRqvP6p8LIC1SjbKrV6cv4jOztJ0eCyWkqGNx1TJd99s9NhL?=
 =?us-ascii?Q?6d/Q9A0iJfOYEZcv7/G2+Yhq/kawmtTRYmwNDor554R0ZN/QkRezacI3+trd?=
 =?us-ascii?Q?gHLHdv3gQ3WJ6RsYjTIGj+23JP3tj9iW1ol0sTw5MF+WGMbaRZExG/t7llWn?=
 =?us-ascii?Q?aVAg0qabspR9PwOkU6ySkOBtYUV/lKnUv5o78Qul6v8sKfCjhbgdGFKqE+Uh?=
 =?us-ascii?Q?71o11Mn3TEVZJzdJlNerHVWWQLyA8RyI5/s9?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2025 03:02:29.6139 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 307c76c4-ae9a-4775-3c21-08dd7192ce5d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00001CDD.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY3PR12MB9578
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

From: "Jesse.zhang@amd.com" <jesse.zhang@amd.com>

Since KFD no longer registers its own callbacks for SDMA resets, and only KGD uses the reset mechanism,
we can simplify the SDMA reset flow by directly calling the ring's `stop_queue` and `start_queue` functions.
This patch removes the dynamic callback mechanism and prepares for its eventual deprecation.

1. **Remove Dynamic Callbacks**:
   - The `pre_reset` and `post_reset` callback invocations in `amdgpu_sdma_reset_engine` are removed.
   - Instead, the ring's `stop_queue` and `start_queue` functions are called directly during the reset process.

2. **Prepare for Deprecation of Dynamic Mechanism**:
   - By removing the callback invocations, this patch prepares the codebase for the eventual removal of the dynamic callback registration mechanism.

Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h |  2 ++
 drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c | 34 +++---------------------
 drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c |  2 ++
 3 files changed, 8 insertions(+), 30 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
index 615c3d5c5a8d..1b66be2b49dc 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
@@ -237,6 +237,8 @@ struct amdgpu_ring_funcs {
 	void (*patch_ce)(struct amdgpu_ring *ring, unsigned offset);
 	void (*patch_de)(struct amdgpu_ring *ring, unsigned offset);
 	int (*reset)(struct amdgpu_ring *ring, unsigned int vmid);
+	int (*stop_queue)(struct amdgpu_device *adev, uint32_t instance_id);
+	int (*start_queue)(struct amdgpu_device *adev, uint32_t instance_id);
 	void (*emit_cleaner_shader)(struct amdgpu_ring *ring);
 	bool (*is_guilty)(struct amdgpu_ring *ring);
 };
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
index 0a9893fee828..7d862c887a1a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
@@ -558,16 +558,10 @@ void amdgpu_sdma_register_on_reset_callbacks(struct amdgpu_device *adev, struct
  * @adev: Pointer to the AMDGPU device
  * @instance_id: ID of the SDMA engine instance to reset
  *
- * This function performs the following steps:
- * 1. Calls all registered pre_reset callbacks to allow KFD and AMDGPU to save their state.
- * 2. Resets the specified SDMA engine instance.
- * 3. Calls all registered post_reset callbacks to allow KFD and AMDGPU to restore their state.
- *
  * Returns: 0 on success, or a negative error code on failure.
  */
 int amdgpu_sdma_reset_engine(struct amdgpu_device *adev, uint32_t instance_id)
 {
-	struct sdma_on_reset_funcs *funcs;
 	int ret = 0;
 	struct amdgpu_sdma_instance *sdma_instance = &adev->sdma.instance[instance_id];
 	struct amdgpu_ring *gfx_ring = &sdma_instance->ring;
@@ -589,18 +583,8 @@ int amdgpu_sdma_reset_engine(struct amdgpu_device *adev, uint32_t instance_id)
 		page_sched_stopped = true;
 	}
 
-	/* Invoke all registered pre_reset callbacks */
-	list_for_each_entry(funcs, &adev->sdma.reset_callback_list, list) {
-		if (funcs->pre_reset) {
-			ret = funcs->pre_reset(adev, instance_id);
-			if (ret) {
-				dev_err(adev->dev,
-				"beforeReset callback failed for instance %u: %d\n",
-					instance_id, ret);
-				goto exit;
-			}
-		}
-	}
+	if (gfx_ring->funcs->stop_queue)
+		gfx_ring->funcs->stop_queue(adev, instance_id);
 
 	/* Perform the SDMA reset for the specified instance */
 	ret = amdgpu_dpm_reset_sdma(adev, 1 << instance_id);
@@ -609,18 +593,8 @@ int amdgpu_sdma_reset_engine(struct amdgpu_device *adev, uint32_t instance_id)
 		goto exit;
 	}
 
-	/* Invoke all registered post_reset callbacks */
-	list_for_each_entry(funcs, &adev->sdma.reset_callback_list, list) {
-		if (funcs->post_reset) {
-			ret = funcs->post_reset(adev, instance_id);
-			if (ret) {
-				dev_err(adev->dev,
-				"afterReset callback failed for instance %u: %d\n",
-					instance_id, ret);
-				goto exit;
-			}
-		}
-	}
+	if (gfx_ring->funcs->start_queue)
+		gfx_ring->funcs->start_queue(adev, instance_id);
 
 exit:
 	/* Restart the scheduler's work queue for the GFX and page rings
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
index 688a720bbbbd..df82a97a5388 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
@@ -2143,6 +2143,8 @@ static const struct amdgpu_ring_funcs sdma_v4_4_2_ring_funcs = {
 	.emit_reg_wait = sdma_v4_4_2_ring_emit_reg_wait,
 	.emit_reg_write_reg_wait = amdgpu_ring_emit_reg_write_reg_wait_helper,
 	.reset = sdma_v4_4_2_reset_queue,
+	.stop_queue = sdma_v4_4_2_stop_queue,
+	.start_queue = sdma_v4_4_2_restore_queue,
 	.is_guilty = sdma_v4_4_2_ring_is_guilty,
 };
 
-- 
2.25.1

