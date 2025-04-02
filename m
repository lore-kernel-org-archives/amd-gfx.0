Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9F4DC36014
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Apr 2025 09:15:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 60A5C10E721;
	Wed,  2 Apr 2025 09:15:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ojk2+QKa";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2054.outbound.protection.outlook.com [40.107.236.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5F3F010E721
 for <amd-gfx@lists.freedesktop.org>; Wed,  2 Apr 2025 09:15:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Avr9+2DLxnzEOsFlyZgtRGllQjSnn7l4zdshlkWRT/AeFpNcVShwYan4hpHhm6QzPTxSFqcag0YOeD+rfJjvGOk6vh5VJYRxe/8WYFWkbVWXIEl48vDFtifhPOywrXb3fA8V3wSOCnq9WSenrexAZSyx3C3kdp+UFazOneT9jqgsgQts6SuUIhCqTbZhpmUX9ZZJ8n6ADQrBdLdj5VUYONS8K2Ctz1XgTJLFKwzAjb5rDKtsF2BvbwOXcp+rwtgUgdsbkB6T9NsGhMFjniOLM4kCAvJNjYgV5qQus740L9ujjPbb6/JLLgRT9V/ZrbXmNGgV4sGi3NwV3WOcNWhkPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1UikoHKwtO1ImxMvmOM99vN8sfjKrbmsDauLmjeWaYk=;
 b=LmU5zgLzgVls3HSzsePld12Ez8TiwkY8raEcCoaDnLHv+Y9UUOPtQjtugrSsxNWcJahwhfo2jcmDlaNFLgXE8EaqqRmXv7Lnnwgl0p0h7DA6ysnQju6pJKvIRRa+5unxsl5SJ9ozjJAm5ar96uP4eC2ETh5qYNMq2YKDRvyA6sXcr4e+6Sm7dWWF7w0dZEip1Sp+bTOinu+Gg36hVWwKVZ9ov6iSYLfYsHeCxL96y7CCLu+fhpoYtzrnQ3nzUeO0Hmlhcyjc0OwV1SgVE72Mzu3+toK7mqL1T+Z1YYBd648pMSZOhntTmasw/MP7HhY3rSqcSc80emd38bgnIh69oQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1UikoHKwtO1ImxMvmOM99vN8sfjKrbmsDauLmjeWaYk=;
 b=ojk2+QKa/aUJunYD/mbXP5k4X3a0IISsykVY4/P9AG9RfCcUPfMia72NQLOSbP1K6F+fvYNRHaVaN2/VKwnqTGdM6maGJNvoRY9+owPQE1WRHH09EMVh8AX8047G+8+3OtaEx1XAuzxes6Q3/CxntLLS3baIpx5VYnXzFv+vXXU=
Received: from DS7PR03CA0294.namprd03.prod.outlook.com (2603:10b6:5:3ad::29)
 by MN0PR12MB5810.namprd12.prod.outlook.com (2603:10b6:208:376::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.44; Wed, 2 Apr
 2025 09:14:56 +0000
Received: from CY4PEPF0000E9D6.namprd05.prod.outlook.com
 (2603:10b6:5:3ad:cafe::a7) by DS7PR03CA0294.outlook.office365.com
 (2603:10b6:5:3ad::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.54 via Frontend Transport; Wed,
 2 Apr 2025 09:14:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CY4PEPF0000E9D6.mail.protection.outlook.com (10.167.241.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8606.22 via Frontend Transport; Wed, 2 Apr 2025 09:14:55 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 2 Apr
 2025 04:14:54 -0500
Received: from JesseDEV.guestwireless.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Wed, 2 Apr 2025 04:14:46 -0500
From: "Jesse.zhang@amd.com" <jesse.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 <jonathan.kim@amd.com>, <jiadong.zhu@amd.com>, "Jesse.zhang@amd.com"
 <Jesse.zhang@amd.com>, Jesse Zhang <jesse.zhang@amd.com>
Subject: [v3 6/7] drm/amd/amdgpu: Refactor SDMA v5.2 reset logic into
 stop_queue and restore_queue functions
Date: Wed, 2 Apr 2025 17:14:05 +0800
Message-ID: <20250402091406.1641643-6-jesse.zhang@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250402091406.1641643-1-jesse.zhang@amd.com>
References: <20250402091406.1641643-1-jesse.zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: jesse.zhang@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D6:EE_|MN0PR12MB5810:EE_
X-MS-Office365-Filtering-Correlation-Id: f482b43b-8240-46be-c593-08dd71c6d541
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?pLWtZuSKjbzSnerPendHK4i5vODFgPtZlnsMVelHW3QW2ohatH+EegMnd0EV?=
 =?us-ascii?Q?vVsUcrxCl2A0xjcZfvGUEs2DsG2ecU/8WOGWjlOh30uWmC2RIRmDLMIH3Fih?=
 =?us-ascii?Q?EaOVWfYdGlW4jLDuTcb0k3sA4cjMpNsYxZXN9dHogyvsdLqOloibTgz+1H7Z?=
 =?us-ascii?Q?X0VMGdxBGV4l21oiRx0FXfg8ZgIdoHSDBXgbRhzp/LYAem2t7x/wkwXnvYhq?=
 =?us-ascii?Q?TWma96T4uGZLqZq4TvTFhkEDWGZmBFmyz9dFZDDKMpqVWmQWCttpqOgJOxKO?=
 =?us-ascii?Q?fLGaGGkNKGiIOeot/tlIPZ+c4BbDhf3CcWDwZrQy/FqcNtOYlubu+RTQgF0g?=
 =?us-ascii?Q?1oR42CfaJt3M3IrpGXqB1hem2zVC3+OKHHwFi9tnJ8B55/2TDafXQf3KK7VL?=
 =?us-ascii?Q?ZBrRMshK6gKty5v8grNiyEHCJ53Fow625sjNb1krkf2QEgqcX99CSN9k76tL?=
 =?us-ascii?Q?G89OzTF+EAShQu1WG6LZZs9cScgynVwKNmldEHX6wuaK7sb0RIIRJo0vEO6S?=
 =?us-ascii?Q?t3FRQv/8JuicXHLuMeCD04uKZXq7dZTtM4PlxUWIlmMv9U3g52lTLyPNbADd?=
 =?us-ascii?Q?WQ+nB9t+3vpm8sX4KBJqppYmNlxMA5hjsmSsTUCcKspZRyPwP8TK000HM6xZ?=
 =?us-ascii?Q?jnFPnVrDoE/MdkdtRlq6nfaRoCY1pdopXasj0C0LOodqsvvDsR0YrvrC9j95?=
 =?us-ascii?Q?P01owaQfc4/wM6uDNleno10xPHD8V4Z/TudVNNK6xXIi4cGa+k7mW60zPLKH?=
 =?us-ascii?Q?WI9OZ1BjMXpghZQnwJoPEoCDRnwj4/rJhVmhjUGZuAQ4Hzt0Sq4e5hbkk5CH?=
 =?us-ascii?Q?72gMtx+VdarEm9m4GC5jfEeMdGcYpStmuuvcrqersgdVMnvfEYjz4pWDC7sf?=
 =?us-ascii?Q?tSB/WlXuIXnfspBH4XL5WLEXArOfc1JM+CMEyA3ZAvmvF1HFJJc8daPBBEEk?=
 =?us-ascii?Q?eOm2XNIULpATVblvbh4z+Kd2IDoqacsXRkEUYoY6iJArevAiQxoFuKXjKnSQ?=
 =?us-ascii?Q?S7FMlAThPdDrSgRDJ0Xs8lclY2OCst5x5r3BaZReOfd87LNdujXXJ7Ia5rBP?=
 =?us-ascii?Q?+W5MKr6hClGCwgILLnOI4DTnXsDfCiDxmuaA0cCq6f1KgB0W2GEaSUP9PZXq?=
 =?us-ascii?Q?DBaofLmPUB15SWmkJ50dhnov3hUwSn/0XYifKtJ/AYLMniZyBHJslAYmU9g+?=
 =?us-ascii?Q?ZwZ/jLkGB/a2O5kRPWaEywMLMwNkpm9phc6wPWtdnHqet7OoTY6R7E/QhXOi?=
 =?us-ascii?Q?tHJLW59v/XkfMla9bq2v1AdGSE/nC1/d/3aOAMg27DL+c274b3zoHO+n1V3D?=
 =?us-ascii?Q?yUu29toIpy0UQao/TyiAIzyug2B364kBxyt/10CwAoeGOeOyrD3iykvzqkoB?=
 =?us-ascii?Q?/iNCJqMFa9rTrXQN2/7ybPc7YprEnBnjQcR7u2UHEREaAnndlEcXuDMzZLm0?=
 =?us-ascii?Q?oK+Ema7fY6/2lBKNJD23DAGjMlft4r0JxSqpTwXt+v8PDhNBSh0azC2mbNY8?=
 =?us-ascii?Q?RiFunNaxxDmrwd0=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2025 09:14:55.0236 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f482b43b-8240-46be-c593-08dd71c6d541
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9D6.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5810
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

This patch refactors the SDMA v5.2 reset logic by splitting the `sdma_v5_2_reset_queue` function into two separate functions: `sdma_v5_2_stop_queue` and `sdma_v5_2_restore_queue`.
This change aligns with the new SDMA reset mechanism, where the reset process is divided into stopping the queue, performing the reset, and restoring the queue.

1. **Split `sdma_v5_2_reset_queue`**:
	- Extracted the queue stopping logic into `sdma_v5_2_stop_queue`.
	- Extracted the queue restoration logic into `sdma_v5_2_restore_queue`.
	- The soft reset step is now handled by the caller (`amdgpu_sdma_reset_engine`).

2. **Update Ring Functions**:
	- Added `stop_queue` and `start_queue` to the `sdma_v5_2_ring_funcs` structure to support the new reset mechanism.

v2: remove the suspend_user_queues param when calling amdgpu_sdma_reset_engine()
v3: Update stop_queue/start_queue function paramters to use ring pointer instead of device/instance(Christian)

Signed-off-by: Jesse Zhang <jesse.zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c | 42 +++++++++++++++-----------
 1 file changed, 25 insertions(+), 17 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
index 96b02c3e4993..d0b8a4976473 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
@@ -1439,18 +1439,24 @@ static int sdma_v5_2_wait_for_idle(struct amdgpu_ip_block *ip_block)
 static int sdma_v5_2_reset_queue(struct amdgpu_ring *ring, unsigned int vmid)
 {
 	struct amdgpu_device *adev = ring->adev;
-	int j, r;
-	u32 f32_cntl, freeze, cntl, preempt, soft_reset, stat1_reg;
-	u32 inst_id;
+	u32 inst_id = ring->me;
+
+	return amdgpu_sdma_reset_engine(adev, inst_id);
+}
+
+static int sdma_v5_2_stop_queue(struct amdgpu_ring *ring)
+{
+	int j, r = 0;
+	u32 f32_cntl, freeze, cntl, preempt, stat1_reg;
+	struct amdgpu_device *adev = ring->adev;
+	u32 inst_id = ring->me;
 
 	if (amdgpu_sriov_vf(adev))
 		return -EINVAL;
 
-	inst_id = ring->me;
 	amdgpu_gfx_rlc_enter_safe_mode(adev, 0);
-
 	/* stop queue */
-	sdma_v5_2_gfx_stop(adev, 1 << ring->me);
+	sdma_v5_2_gfx_stop(adev, 1 << inst_id);
 
 	/*engine stop SDMA1_F32_CNTL.HALT to 1 and SDMAx_FREEZE freeze bit to 1 */
 	freeze = RREG32(sdma_v5_2_get_reg_offset(adev, inst_id, mmSDMA0_FREEZE));
@@ -1488,18 +1494,19 @@ static int sdma_v5_2_reset_queue(struct amdgpu_ring *ring, unsigned int vmid)
 	preempt = REG_SET_FIELD(preempt, SDMA0_GFX_PREEMPT, IB_PREEMPT, 0);
 	WREG32(sdma_v5_2_get_reg_offset(adev, inst_id, mmSDMA0_GFX_PREEMPT), preempt);
 
-	soft_reset = RREG32_SOC15(GC, 0, mmGRBM_SOFT_RESET);
-	soft_reset |= 1 << GRBM_SOFT_RESET__SOFT_RESET_SDMA0__SHIFT << inst_id;
-
-
-	WREG32_SOC15(GC, 0, mmGRBM_SOFT_RESET, soft_reset);
-
-	udelay(50);
-
-	soft_reset &= ~(1 << GRBM_SOFT_RESET__SOFT_RESET_SDMA0__SHIFT << inst_id);
+err0:
+	amdgpu_gfx_rlc_exit_safe_mode(adev, 0);
+	return r;
+}
 
-	WREG32_SOC15(GC, 0, mmGRBM_SOFT_RESET, soft_reset);
+static int sdma_v5_2_restore_queue(struct amdgpu_ring *ring)
+{
+	u32 freeze;
+	int r;
+	struct amdgpu_device *adev = ring->adev;
+	u32 inst_id = ring->me;
 
+	amdgpu_gfx_rlc_enter_safe_mode(adev, 0);
 	/* unfreeze and unhalt */
 	freeze = RREG32(sdma_v5_2_get_reg_offset(adev, inst_id, mmSDMA0_FREEZE));
 	freeze = REG_SET_FIELD(freeze, SDMA0_FREEZE, FREEZE, 0);
@@ -1507,7 +1514,6 @@ static int sdma_v5_2_reset_queue(struct amdgpu_ring *ring, unsigned int vmid)
 
 	r = sdma_v5_2_gfx_resume_instance(adev, inst_id, true);
 
-err0:
 	amdgpu_gfx_rlc_exit_safe_mode(adev, 0);
 	return r;
 }
@@ -1947,6 +1953,8 @@ static const struct amdgpu_ring_funcs sdma_v5_2_ring_funcs = {
 	.init_cond_exec = sdma_v5_2_ring_init_cond_exec,
 	.preempt_ib = sdma_v5_2_ring_preempt_ib,
 	.reset = sdma_v5_2_reset_queue,
+	.stop_queue = sdma_v5_2_stop_queue,
+	.start_queue = sdma_v5_2_restore_queue,
 };
 
 static void sdma_v5_2_set_ring_funcs(struct amdgpu_device *adev)
-- 
2.25.1

