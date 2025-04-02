Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3412C28B20
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Apr 2025 09:14:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 59E2A10E053;
	Wed,  2 Apr 2025 09:14:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="3n79KRQm";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2078.outbound.protection.outlook.com [40.107.94.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4976610E053
 for <amd-gfx@lists.freedesktop.org>; Wed,  2 Apr 2025 09:14:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UHnBPqAzIMqyoW+wfTkvp1KjqhJ2dGjkTEm+d5jaD17L/13uWsRJd5O4C0sewkCz/uaQQ/7lol51gYcvktTKRqT1YjUYHmXBve1BPbYtSNxAEdhSP5OYU0/U6ngpakM6tuutXK6WVg98T6B05Xwvy1FRmqDKZCOJ5y12FfKEy4dsuljqZCrsk4r6NmhAFXxX4GWhJC7cg4cTdqocTqCmVavAfG5sE9XOlqcYFDul38Mbk21iptjPW6I/pDPQNAxMxtFh33XgAxdldQesThgA1cgTSecsrFYdyVcUyBBVquSY/Qq/HodcfByr3pLmCA0x3ueDwqDlI9MnSC1PjUO3BQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+774Wew93PWCwydr3UQPTQguSsDBth6jKP7MjgEc7BA=;
 b=fGsJY7Igh5bwU8YNGHvcsfciElBGcsOpIVQXFfoFEbWYJdKXHbZv3iDHMkAJ5jj6IJ3KjE9CD4wdlhgX5rG9xA5QQKrWjVVzMWZdXyXgpqCQD1yso87y7lID2CJWhPMByoXZdd3bTHRGJxgQYxLAwynViFuNJ/5EX+2Ap8K3jjHNEK0daybu/kn7h3v4hPjM2IDzPpEI6WN7oDhuim8p5KYI2vRKPYkKVkk3LPha9TMqmeHmlutzC7CMK7ukMYbUmtFvh5BJ14MVD3LrvwkTdtlBQldjQ6jjaTXlthrvB3A6wcEnkGCtehDIJhGO2eHOSqlvdh43usQp6BL0dT0qSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+774Wew93PWCwydr3UQPTQguSsDBth6jKP7MjgEc7BA=;
 b=3n79KRQmxqp78pfpMQ4HMf6tkiL8TjLrqaRd9FMXMOfZ6uLHxTykWR5gCoAqG5Sciy2tFuUqDDcdMO1Jx2HoEVg5ZSUXVliynzZWoHjAtR1zq5oRxhJTiQp8ZbmUyNtfw0uw9I9QX2l9DIzbaUlFTDG8N8xxVKJY03yazOfJzlE=
Received: from CH5P221CA0023.NAMP221.PROD.OUTLOOK.COM (2603:10b6:610:1f2::25)
 by IA0PR12MB7555.namprd12.prod.outlook.com (2603:10b6:208:43d::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.44; Wed, 2 Apr
 2025 09:14:20 +0000
Received: from CH1PEPF0000A348.namprd04.prod.outlook.com
 (2603:10b6:610:1f2:cafe::5a) by CH5P221CA0023.outlook.office365.com
 (2603:10b6:610:1f2::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8583.42 via Frontend Transport; Wed,
 2 Apr 2025 09:14:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH1PEPF0000A348.mail.protection.outlook.com (10.167.244.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8606.22 via Frontend Transport; Wed, 2 Apr 2025 09:14:20 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 2 Apr
 2025 04:14:18 -0500
Received: from JesseDEV.guestwireless.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Wed, 2 Apr 2025 04:14:11 -0500
From: "Jesse.zhang@amd.com" <jesse.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 <jonathan.kim@amd.com>, <jiadong.zhu@amd.com>, "Jesse.zhang@amd.com"
 <jesse.zhang@amd.com>, Jesse Zhang <Jesse.Zhang@amd.com>
Subject: [v3 1/7] drm/amd/amdgpu: Simplify SDMA reset mechanism by removing
 dynamic callbacks
Date: Wed, 2 Apr 2025 17:14:00 +0800
Message-ID: <20250402091406.1641643-1-jesse.zhang@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: jesse.zhang@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000A348:EE_|IA0PR12MB7555:EE_
X-MS-Office365-Filtering-Correlation-Id: 4f61317e-1929-4e13-0124-08dd71c6c07d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?6brN+FaP8sov10g1SZdMdB+cOtQi0mGVqJw+LXnDZkoU6fe/PHPXo0TRFpxY?=
 =?us-ascii?Q?PhMf5IIlDRPkBJnpGcNemN5tXWOPi2SsSih+6Sd3NYdMwjdrUVTFuopRG/p2?=
 =?us-ascii?Q?bxlZbzIFxhu1TQFed03u9RzgZq5Y/I5i2ZwlcMSEgMBQ+2ZQQM1gf31R/DqQ?=
 =?us-ascii?Q?OWGAWz5V+KOHQBfRfTXiqmb/j5qvEgQDzoT/3XeXVDPhVGkH98A4vwJ1H3oA?=
 =?us-ascii?Q?EYcfGskjys4d6kENYWzT10JO6VJ+pUKfBa8KxxrWqRyMVrD6LmwHuM5wqSCq?=
 =?us-ascii?Q?KixDSYFu6XlO2+NjVtKWVQ5FN9fXRoMWHKdXrA8dNdHfurffxmLLXHFWusjE?=
 =?us-ascii?Q?rD4XDVD92nF9ZP+qy4FemyunH1PvJmbTJCnp44DxwHReEljP017u9ql8m/VB?=
 =?us-ascii?Q?wZPS8Vn/G9eiiJWQhCB722YeBrbG6GRnC8TSEGmRmUcNwakqEdMqq2DZkRf2?=
 =?us-ascii?Q?asMxxekDQWs4KOd44+TnNNGp0Czkip844QYzV6lgae8jkB3oU8Q4Nxrcv6VY?=
 =?us-ascii?Q?n/GpqzUYikTuCklzbbic46efRSF/NQTnvff79MdYFFSucuPG9mBcCwAceCiy?=
 =?us-ascii?Q?MF/bspzrdqxGg0lKMFvDZpHruV7gp+uJ5yiYd5B69yh5PotnWJzMhNHU4hV3?=
 =?us-ascii?Q?eXi0xLV2+/5KVISGkOoAqU37d//1Ltavn/SCA4S514b4KABa2lDHEHbJC2VX?=
 =?us-ascii?Q?88SXwlCeMeUGqLLRGzBOcOyY9qidwLpyLI3I+Zxw9lUwpczyoGnH59L7d2FL?=
 =?us-ascii?Q?D7PpTg7+i08jaPPLAVxCCquhDj33/8NpvMQyLfYrBZwwInBPEZOeZU7x+5Gs?=
 =?us-ascii?Q?uLk56F0Yehll7RUai452SBrI13Q8IAgQvup7cFjmdyG4QndeWLcBDXC0YTX1?=
 =?us-ascii?Q?2/lUzOA7cOmQdH4b1wvfTNy3UuEkUeaqGaF2vTfdZSPRaDlxZ7ZhAg7OsL3L?=
 =?us-ascii?Q?6WBlCOGJlJlBKC8fSduTx6YWFiH2LIk3onrPOmLqlRg4zYEi2k/8BfVvrcON?=
 =?us-ascii?Q?5DHN4OkqH4sw/Ww+RQ5vRoyMc4a0HVQkFD2CUfKShslxzDulIYymrd+ROJKB?=
 =?us-ascii?Q?z1e5ZHejj6wNDvqNB0fz6KLFOndCjSNsCofOpS9vhW5KvpXfMyB2Cl06uZN8?=
 =?us-ascii?Q?jfOqBx9oq651OQzj56BWFdkj5Gi7YO6iXkfnu7UwqLjcFVc5hgGx2QytStVa?=
 =?us-ascii?Q?KqGgDnub2o7d3gP4eKfOAIlGTNb+oqn7MdssZy3uFeZY7EiBiVI89gISHcZU?=
 =?us-ascii?Q?V4UumvdNf+2bfEBKzCJDO1JYWnXg3zhdcddIN0KmjFS4sX1PzUWb5weUGc5J?=
 =?us-ascii?Q?YAGueY3vQMNBd5Ow09i1GsxSzQHgTTwSh6lsgXQBrjJc+ZJNoOolDAK2RpDm?=
 =?us-ascii?Q?BNb0N04I868w8F271+Y2A38BYOYsUon5KmyNUrR8czXAtaFHDt5F5/qYUtX2?=
 =?us-ascii?Q?EXp6NvxGiENP42beXL0dr/4k1yADx9J9y4RbWuE05FtKF6/ZrhC+626A2Mes?=
 =?us-ascii?Q?itSJnNm5Qeyb2bg=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2025 09:14:20.2734 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f61317e-1929-4e13-0124-08dd71c6c07d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000A348.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7555
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

Since KFD no longer registers its own callbacks for SDMA resets, and only KGD uses the reset mechanism,
we can simplify the SDMA reset flow by directly calling the ring's `stop_queue` and `start_queue` functions.
This patch removes the dynamic callback mechanism and prepares for its eventual deprecation.

1. **Remove Dynamic Callbacks**:
   - The `pre_reset` and `post_reset` callback invocations in `amdgpu_sdma_reset_engine` are removed.
   - Instead, the ring's `stop_queue` and `start_queue` functions are called directly during the reset process.

2. **Prepare for Deprecation of Dynamic Mechanism**:
   - By removing the callback invocations, this patch prepares the codebase for the eventual removal of the dynamic callback registration mechanism.

v2: Update stop_queue/start_queue function paramters to use ring pointer instead of device/instance(Christian)

Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h |  2 ++
 drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c | 34 +++---------------------
 drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c | 13 ++++-----
 3 files changed, 13 insertions(+), 36 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
index 615c3d5c5a8d..23ea221e26de 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
@@ -237,6 +237,8 @@ struct amdgpu_ring_funcs {
 	void (*patch_ce)(struct amdgpu_ring *ring, unsigned offset);
 	void (*patch_de)(struct amdgpu_ring *ring, unsigned offset);
 	int (*reset)(struct amdgpu_ring *ring, unsigned int vmid);
+	int (*stop_queue)(struct amdgpu_ring *ring);
+	int (*start_queue)(struct amdgpu_ring *ring);
 	void (*emit_cleaner_shader)(struct amdgpu_ring *ring);
 	bool (*is_guilty)(struct amdgpu_ring *ring);
 };
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
index 0a9893fee828..b51fe644940f 100644
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
+		gfx_ring->funcs->stop_queue(gfx_ring);
 
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
+		gfx_ring->funcs->start_queue(gfx_ring);
 
 exit:
 	/* Restart the scheduler's work queue for the GFX and page rings
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
index 688a720bbbbd..a8330504692d 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
@@ -1678,11 +1678,12 @@ static int sdma_v4_4_2_reset_queue(struct amdgpu_ring *ring, unsigned int vmid)
 	return r;
 }
 
-static int sdma_v4_4_2_stop_queue(struct amdgpu_device *adev, uint32_t instance_id)
+static int sdma_v4_4_2_stop_queue(struct amdgpu_ring *ring)
 {
 	u32 inst_mask;
 	uint64_t rptr;
-	struct amdgpu_ring *ring = &adev->sdma.instance[instance_id].ring;
+	struct amdgpu_device *adev = ring->adev;
+	u32 instance_id = GET_INST(SDMA0, ring->me);
 
 	if (amdgpu_sriov_vf(adev))
 		return -EINVAL;
@@ -1715,11 +1716,11 @@ static int sdma_v4_4_2_stop_queue(struct amdgpu_device *adev, uint32_t instance_
 	return 0;
 }
 
-static int sdma_v4_4_2_restore_queue(struct amdgpu_device *adev, uint32_t instance_id)
+static int sdma_v4_4_2_restore_queue(struct amdgpu_ring *ring)
 {
 	int i;
 	u32 inst_mask;
-	struct amdgpu_ring *ring = &adev->sdma.instance[instance_id].ring;
+	struct amdgpu_device *adev = ring->adev;
 
 	inst_mask = 1 << ring->me;
 	udelay(50);
@@ -1740,8 +1741,6 @@ static int sdma_v4_4_2_restore_queue(struct amdgpu_device *adev, uint32_t instan
 }
 
 static struct sdma_on_reset_funcs sdma_v4_4_2_engine_reset_funcs = {
-	.pre_reset = sdma_v4_4_2_stop_queue,
-	.post_reset = sdma_v4_4_2_restore_queue,
 };
 
 static void sdma_v4_4_2_set_engine_reset_funcs(struct amdgpu_device *adev)
@@ -2143,6 +2142,8 @@ static const struct amdgpu_ring_funcs sdma_v4_4_2_ring_funcs = {
 	.emit_reg_wait = sdma_v4_4_2_ring_emit_reg_wait,
 	.emit_reg_write_reg_wait = amdgpu_ring_emit_reg_write_reg_wait_helper,
 	.reset = sdma_v4_4_2_reset_queue,
+	.stop_queue = sdma_v4_4_2_stop_queue,
+	.start_queue = sdma_v4_4_2_restore_queue,
 	.is_guilty = sdma_v4_4_2_ring_is_guilty,
 };
 
-- 
2.25.1

