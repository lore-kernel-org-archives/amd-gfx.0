Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76786C28B28
	for <amd-gfx@archiver.kernel.org>; Wed, 12 Mar 2025 08:00:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F357A10E023;
	Wed, 12 Mar 2025 08:00:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="we2QZ2XY";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2040.outbound.protection.outlook.com [40.107.92.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A23DC10E023
 for <amd-gfx@lists.freedesktop.org>; Wed, 12 Mar 2025 08:00:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pT2Q/jzLZ/H4oxnfikjzESaMY8UIopiY0rx+ruzw9gxCNEnrPIsxCk9kDM1NNwE6Os0jIbr1qB5sb4tM0/oi/99tqL1WwgMe/pGTdi9xnNqugFGhPOuqJnlC0r2rDy/GKcCbFsjk4Shsi11XYjI7PiC9Vl7NMYWBg9Wk0iuqQY07VxaHog7Dh7O8emEJvL/5kYkRXCyNgFjab+Br3aX6INg5ATEpPT+lLlMnbFB5kGo+pq7SwDtlCG34Oq5EjllG02yb0jYaS37bB4p8shx+NYF1y4xMjNh6/lyH6ErBdyjqoLTmy/kWeWA3tQ3g2KfzSOYPwFz4fZ9ZBj6A4VJrDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dNNc5i2J5tf4xP0dDIAxGNZI7VIbBfghyL/A0SHxwjQ=;
 b=Rn3jhJpAyiFuRssPmHUEb86cp2Epeex6YiWwMWftOTfBvpZPqtmF7LFCG8xCyBoJwb16JdyFDZ/VbiPeBFW6xl3W8J4xoAH/+JOFefZe2ScRXqPQwX56+cQUEgOZQq/C4fiPKEab/LLPT3r3/3XO7uyWt3MkbUYis8p16ESMtN6Rj1Gx0Q12kOZF5T0vJ8DKzDgJe28D68qk6LEq5Tzpt4vWnYG7Z4Wwo1zVrRsSOsct8JP4yuZMew+CgTGtzcpugY4ws7vhmkBuKLX4cWSSSBXvRqiaT8Twal2wp0R87YmOdEd/mOo7JZhuO+Lmn+nxYLcvl21B0Anlr4mGja2bgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dNNc5i2J5tf4xP0dDIAxGNZI7VIbBfghyL/A0SHxwjQ=;
 b=we2QZ2XYtbkD9sYEqUxjMbsYdenFDhlUVjvZzhvSfCQdM8zw0atHwD/40EouiUWjDpRMqN66MuKIMmHh/INC5S+wDzGTAiImLO+S5TRrQAHnaS9IQtH+zTufCnFuiXsLmoMf+5xf7VObt/+TOtxSngPgamw+0t6c0mT3nA+eJyA=
Received: from DS7PR05CA0035.namprd05.prod.outlook.com (2603:10b6:8:2f::18) by
 PH0PR12MB5678.namprd12.prod.outlook.com (2603:10b6:510:14e::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Wed, 12 Mar
 2025 08:00:18 +0000
Received: from CY4PEPF0000EE3E.namprd03.prod.outlook.com
 (2603:10b6:8:2f:cafe::41) by DS7PR05CA0035.outlook.office365.com
 (2603:10b6:8:2f::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.21 via Frontend Transport; Wed,
 12 Mar 2025 08:00:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CY4PEPF0000EE3E.mail.protection.outlook.com (10.167.242.16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8534.20 via Frontend Transport; Wed, 12 Mar 2025 08:00:16 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 12 Mar
 2025 03:00:15 -0500
Received: from JesseDEV.guestwireless.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Wed, 12 Mar 2025 03:00:09 -0500
From: "Jesse.zhang@amd.com" <jesse.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 <jonathan.kim@amd.com>, <jiadong.zhu@amd.com>, "Jesse.zhang@amd.com"
 <Jesse.zhang@amd.com>, Jesse Zhang <Jesse.Zhang@amd.com>
Subject: [PATCH 1/7] drm/amd/amdgpu: Simplify SDMA reset mechanism by removing
 dynamic callbacks
Date: Wed, 12 Mar 2025 15:59:57 +0800
Message-ID: <20250312080003.3224976-1-jesse.zhang@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: jesse.zhang@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3E:EE_|PH0PR12MB5678:EE_
X-MS-Office365-Filtering-Correlation-Id: a92634ba-4a3c-4a38-602c-08dd613bed6d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?i0CUE9h5vIZjEmBmNZENlwcSlI5knziFG9V4NtpwJZ/grOCSyVjpZ891q5PM?=
 =?us-ascii?Q?ZF3eE/jxeybBT2bRJjpmuyJrtKNi4kldtQ8vh6bupc6uSUGoIemvkJGDuaK9?=
 =?us-ascii?Q?HGpu3IMftE3Ig1LxTuFtkgqvCsYRAE/uJM2WX7auHNLjQbuikPqhqb+8y7s2?=
 =?us-ascii?Q?M28kwX+t/Jy3b+u3ENFH4MFuEIO23J1bloxy0ck8sKENirxzEKHNgvVT7jez?=
 =?us-ascii?Q?BlXD9PgnlbsTnTHFwll0NOihQmbDuKWrnJ2Bidpu4EEV+TKF8KQEi1KZEn7I?=
 =?us-ascii?Q?d5A/p15zDCqT5s8kf7Bzj1PedIA1Ma+w85qJ1pfMdZjQgexQqLEX66lwUjxY?=
 =?us-ascii?Q?mseXi3nbz3/cJI27f5pez3rFvaMVxU13xoX2SlNKoXDTAxXT0v/AuImEkZw/?=
 =?us-ascii?Q?DcNAKh+iot2xlyGTRiDjZ8ab3Dw9w8thL3LbqL68xjiGH2KZqDPKG7REgS1j?=
 =?us-ascii?Q?zrNBbV4RYBOGySVUffKfXcf9o+qK/KNMIRTsdh/tDrWZm+5R39GnGSt+rOGS?=
 =?us-ascii?Q?fe/jDzh6DA9vA0wEL6SGAAe19Ue6TVU14x7LZi0+8XGuIPTiDfY40IvrxR4p?=
 =?us-ascii?Q?vuAAM8ipMN/1G/1ZJ4SK8RHZ0yMxaHuPIcdWsjkXI8D/hcPpYP2EBbZOYuQ/?=
 =?us-ascii?Q?TouwfcNuMMxxP21dt1kv0PjiVl/k3utWEtVM9xx+N3At9O6VX2FsKRsQJuhW?=
 =?us-ascii?Q?CaXx+BozylG86kxHFd/kgQKTaeoEIqdH1jwJdqfmUiAp1oNdeyRH+m6R//7q?=
 =?us-ascii?Q?lMHRQdrl5SJ+smwfyhSuuwXrWg2FGJaKSSLcEZXD5wm1z0kd0r9p/2V8mh2n?=
 =?us-ascii?Q?7ZLPyQnvkgUq9FEjYXOEwOGY66UaCdr/Frc2S0bnhrIRieMGxsM1C69Wl+0y?=
 =?us-ascii?Q?tBINmy2Ri/hkO4Pi/jnf1uSH9uKQhEIHCUR7NYf9fFh86T2u80Uqdo9SLAUI?=
 =?us-ascii?Q?dZlcdy/+XcqRG6ppEkRdXXVsbQxE9y/2miZd6oi+pZYSvrvRU2CM8s6mM8qt?=
 =?us-ascii?Q?6OnqlQOS8U847qnotEPj2S+gIExqFKoBrbxpGAwY7EQ/Cc54/7xgFX2HSX3X?=
 =?us-ascii?Q?7f1Ht24S8CY55unuF7kZbNfYgnXjfmAwLHxOdrjm00snWjgdlAJuyR+K417m?=
 =?us-ascii?Q?Snu4qqWhI596aPDL+69GudHHm16n4KFeP4dTgxXcDCBVyovWr25oxjJ794OQ?=
 =?us-ascii?Q?nTztpjynbINOZMEyY12vkqG9KnJ4x5zSkHRDT6Or3/BE/veLCsJwv42DkC50?=
 =?us-ascii?Q?eRMBAiFO5IYIrAFMEAScdKokQdL6H8lNrhr3MTb01gukJAYjuVaa7ILaRJjm?=
 =?us-ascii?Q?GH0LUtrpkuRNMZFdNDd6mpPsR43H0t4w0b447Zf7YGFtcBgSg2ZfFe0qCTPO?=
 =?us-ascii?Q?7ks7aQKAYicu0tHj0J8UnPhKw4UXvjkpzvFYa+zjEZMupUbSEQxqsAaVD8uG?=
 =?us-ascii?Q?0GsQqLooV3GfozwQWy2fZshQFQp61M8Iys/WYFT7POexF8n4iV447oPqLqKz?=
 =?us-ascii?Q?V0vHyOSLx6i0vc0=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2025 08:00:16.9717 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a92634ba-4a3c-4a38-602c-08dd613bed6d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE3E.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5678
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

From: "Jesse.zhang@amd.com" <Jesse.zhang@amd.com>

Since KFD no longer registers its own callbacks for SDMA resets, and only KGD uses the reset mechanism,
we can simplify the SDMA reset flow by directly calling the ring's `stop_queue` and `start_queue` functions.
This patch removes the dynamic callback mechanism and prepares for its eventual deprecation.

The current SDMA reset mechanism uses a dynamic callback registration system to allow both KFD and KGD to register pre-reset and post-reset functions.
However, KFD no longer registers its callbacks, and the reset logic is now entirely handled by KGD.
This makes the dynamic callback mechanism unnecessary and adds complexity to the code.

1. **Remove Dynamic Callbacks**:
   - The `pre_reset` and `post_reset` callback invocations in `amdgpu_sdma_reset_engine` are removed.
   - Instead, the ring's `stop_queue` and `start_queue` functions are called directly during the reset process.

2. **Add `stop_queue` and `start_queue` to Ring Functions**:
   - The `amdgpu_ring_funcs` structure is extended to include `stop_queue` and `start_queue` functions.
   - These functions are implemented in the SDMA version-specific code (e.g., `sdma_v4_4_2_stop_queue` and `sdma_v4_4_2_restore_queue`).

3. **Prepare for Deprecation of Dynamic Mechanism**:
   - By removing the callback invocations, this patch prepares the codebase for the eventual removal of the dynamic callback registration mechanism.

Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h |  2 ++
 drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c | 33 ++----------------------
 drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c |  2 ++
 3 files changed, 6 insertions(+), 31 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
index b4fd1e17205e..1c52ff92ea26 100644
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
index 39669f8788a7..b1f4a11ad0c9 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
@@ -534,16 +534,10 @@ void amdgpu_sdma_register_on_reset_callbacks(struct amdgpu_device *adev, struct
  * @instance_id: ID of the SDMA engine instance to reset
  * @suspend_user_queues: check if suspend user queue.
  *
- * This function performs the following steps:
- * 1. Calls all registered pre_reset callbacks to allow KFD and AMDGPU to save their state.
- * 2. Resets the specified SDMA engine instance.
- * 3. Calls all registered post_reset callbacks to allow KFD and AMDGPU to restore their state.
- *
  * Returns: 0 on success, or a negative error code on failure.
  */
 int amdgpu_sdma_reset_engine(struct amdgpu_device *adev, uint32_t instance_id, bool suspend_user_queues)
 {
-	struct sdma_on_reset_funcs *funcs;
 	int ret = 0;
 	struct amdgpu_sdma_instance *sdma_instance = &adev->sdma.instance[instance_id];;
 	struct amdgpu_ring *gfx_ring = &sdma_instance->ring;
@@ -571,19 +565,7 @@ int amdgpu_sdma_reset_engine(struct amdgpu_device *adev, uint32_t instance_id, b
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
-
+	gfx_ring->funcs->stop_queue(adev, instance_id);
 	/* Perform the SDMA reset for the specified instance */
 	ret = amdgpu_dpm_reset_sdma(adev, 1 << instance_id);
 	if (ret) {
@@ -591,18 +573,7 @@ int amdgpu_sdma_reset_engine(struct amdgpu_device *adev, uint32_t instance_id, b
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
+	gfx_ring->funcs->start_queue(adev, instance_id);
 
 exit:
 	/* Restart the scheduler's work queue for the GFX and page rings
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
index fd34dc138081..c1f7ccff9c4e 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
@@ -2132,6 +2132,8 @@ static const struct amdgpu_ring_funcs sdma_v4_4_2_ring_funcs = {
 	.emit_reg_wait = sdma_v4_4_2_ring_emit_reg_wait,
 	.emit_reg_write_reg_wait = amdgpu_ring_emit_reg_write_reg_wait_helper,
 	.reset = sdma_v4_4_2_reset_queue,
+	.stop_queue = sdma_v4_4_2_stop_queue,
+	.start_queue = sdma_v4_4_2_restore_queue,
 	.is_guilty = sdma_v4_4_2_ring_is_guilty,
 };
 
-- 
2.25.1

