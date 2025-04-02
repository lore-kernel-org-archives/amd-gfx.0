Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 050DEC36010
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Apr 2025 03:03:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A231010E6B0;
	Wed,  2 Apr 2025 03:03:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="XYXfc+KG";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2041.outbound.protection.outlook.com [40.107.92.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1095510E6B0
 for <amd-gfx@lists.freedesktop.org>; Wed,  2 Apr 2025 03:03:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=S4ADG2fhEYKfgrMAV3wKBpDTrw8ND+f0C73r7KuHACJFjTXfNs1033oe909NN+b5dBgviZKLoDJxtZ2n7MXIPf2eZOaBAT3RsAh0xZgpnpSOKfWv2yKvfhuzfwP2iEIOayq3e/HK20/dSx27ZcKf+DYQHsylFRQ1mQhfXTMegat5lIySuhwwntQXog7gOsezz60N2V6Ur1HkXDC6xhR6axH7MdYOrFHi0VRzXDztnOQy0P5EirFZiBpyy1s9Ic5F+ZyepgVAbjkI2LLeAXfzSqdIeGZZswtC4kUtlw0+nRxsQuUDcm8ww4UIQQG/EHgdEGvD1L6kaYdbIOljBPCq9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+4Y1vbXrWwnd9zX286W1rlL/oTGbali6+QTBxGbitm4=;
 b=WAed55eVBpioM0ndQbZzPuJu23XjuwlKNpeSU2Xxdky04kTsAJUuiWbAwhcRni9tdWytC6CnJislxfpG8WCvVh57LBCYXfGnkYzkxtwCjXkxEyoHmkJGpBQLbUrbpT5Vc4j6HYuYz8vj5M04H8AfH7A5+6SC700NzVAUYuj7ZVkqIixRCzOYU+e+mBptRjXM1jBD3kdEmbPPS8qT+FH9pmXpOz0MC4KNpT6hbxKkdOxlsCJRnzHc9tlALv8ZmZtIu6Cpr4RsOcFgg37VZ48Eb5ArBw4qHLGxn6Qe2mf4yfV9oJhy8PXmRCHq9kyYjQKTnZpua8DNhnJNN8FkNOrXVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+4Y1vbXrWwnd9zX286W1rlL/oTGbali6+QTBxGbitm4=;
 b=XYXfc+KGB/PkTFOsbeN7I00dmrr3cJ+iCxZ3WaSH8PfkeCCZZavKYKtWVi0K/LlVlxj9rzMMgc2HP09TAK4D6gJ8HQjjJ84yteTE7OO9EpTfvyZYORJCMg9TZo3zNRNiC5OkIldEvSNEA7sUYQ6aFAxkHKbjz3kB7vM5gnXxepE=
Received: from SJ0PR03CA0084.namprd03.prod.outlook.com (2603:10b6:a03:331::29)
 by PH7PR12MB6761.namprd12.prod.outlook.com (2603:10b6:510:1ab::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.44; Wed, 2 Apr
 2025 03:03:17 +0000
Received: from SJ1PEPF00001CE0.namprd05.prod.outlook.com
 (2603:10b6:a03:331:cafe::2) by SJ0PR03CA0084.outlook.office365.com
 (2603:10b6:a03:331::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.54 via Frontend Transport; Wed,
 2 Apr 2025 03:03:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00001CE0.mail.protection.outlook.com (10.167.242.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8606.22 via Frontend Transport; Wed, 2 Apr 2025 03:03:17 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 1 Apr
 2025 22:03:16 -0500
Received: from JesseDEV.guestwireless.amd.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Tue, 1 Apr 2025 22:03:09 -0500
From: <jesse.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <christian.koenig@amd.com>,
 <jonathan.kim@amd.com>, <jiadong.zhu@amd.com>, "Jesse.zhang@amd.com"
 <Jesse.zhang@amd.com>, Jesse Zhang <jesse.zhang@amd.com>
Subject: [PATCH 7/7 V2] drm/amd/amdgpu: Remove deprecated SDMA reset callback
 mechanism
Date: Wed, 2 Apr 2025 11:02:15 +0800
Message-ID: <20250402030215.1074975-7-jesse.zhang@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250402030215.1074975-1-jesse.zhang@amd.com>
References: <20250402030215.1074975-1-jesse.zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: jesse.zhang@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE0:EE_|PH7PR12MB6761:EE_
X-MS-Office365-Filtering-Correlation-Id: d884d5ae-dc39-4d36-dda8-08dd7192eab3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?WQ4Rm2ZrWIJ6UDmTxteTZEQdeTxi7LfCI9nkGQamFo05VIoxlQVA0XjrDoqq?=
 =?us-ascii?Q?Vdm2U/01qNNwwoTijzSdrxWseX6L7Mleerl9KmWfp6Cw1bPsOGASDfeUg5fK?=
 =?us-ascii?Q?k5v81qzQzR3cQ7L79smFW/5cHO6PtTK6H1IWcuqgWFdTYoLtfgR95jfTNxX2?=
 =?us-ascii?Q?H64wqviDZBFQQ32yXAVQ5FsPiSLq6xkxvFBn8/5DDHrKPavKYEFxPCuNKrde?=
 =?us-ascii?Q?esdXeCIZHUMnBUEAJExwxUzkQ/eJ79yfqtW8iuaBHE2pavS9wZY90bdS4Nmo?=
 =?us-ascii?Q?5vzyEX0WaoK0LDZG5s1CnhI21CZraVpDnyAV41Nxh/bmlgSkHZhcoR8t01Ae?=
 =?us-ascii?Q?+9r2ffBT1mbQZqfbXE6zl533D0veNUYpx2VGoLxNUoKnjo0oa/DzeQ4zVWWJ?=
 =?us-ascii?Q?1xJcpqdTkNyQOxadEaYMwlBF0a1GoFUWG1ImB4VOCm/WR304IofDjOtii51I?=
 =?us-ascii?Q?NxOZwGp48sB5CTg4kXxvwdUxRx7Y3iPKnauZUpVuRWpfjkMmhyj7SbcILnBh?=
 =?us-ascii?Q?EI0rZ0KealslJaTA6oUSqkvJaW/a041wo4IIN9di6/a1PTINDE4SUkxZfefe?=
 =?us-ascii?Q?Jub9pvlGN+c81NDLDsMljYJSzwIMwh5ATU2lSFjOrPNBpTJIoHcig7cAbW4x?=
 =?us-ascii?Q?0nriPY0Wq/K3PhqHLSNj1wT8tS3V9fyV+eCxGTiFMEn4mnc/pDkZzyTuvfxt?=
 =?us-ascii?Q?PeOBSGSDpsz2xsrrotCvDXM6BcMp3kiW66ET4LcvwgoQyoj1Gg8bp+g0Bl+u?=
 =?us-ascii?Q?jNtNGsGcvvSIyBpsHXGRLuvocL0ua2Y9TmDcwLu5DHOX6b7qx4CzNwqjldRD?=
 =?us-ascii?Q?O3kHg580d9fzN8wzR+Kgbpv4nKv6R+0afF8+F2n77OMcHOmzBfIHSS1Ed9/8?=
 =?us-ascii?Q?tzFyHxmWppwvdIi4kaCY03ZFmVTLZ/ZYdxzJgpw8bpX9RLpTqUKgnSZTwAEG?=
 =?us-ascii?Q?MNk3eLsqrD1RAjWMjWBWC/DVJfxnSjXBHttGcRFxSYEfBbbhEJz0WDwrHCUw?=
 =?us-ascii?Q?LBzpMLmIfUa0GcFvx0Lij4aXG3XOtm3Uowi8o1O0S/+nvVGAi0Oiz+f2rq5t?=
 =?us-ascii?Q?aluHba1c+s/ubSwswwJvMsVm24Bab1cTxXqsiQ1T0VEZlod1kCzlZb2Lx43F?=
 =?us-ascii?Q?4Tv/tQzQ34yC/W+4vjKb5f0Xdjfq5UEBwZ5U+S4UJNuL2q1w2lGlv0MjTUGf?=
 =?us-ascii?Q?WqQVM3OiwKJDPlK8C9wKDKr1FL8feH26d9CLTRAAn/K6ioMIyOytY9PyzpCi?=
 =?us-ascii?Q?zNANUDKf9DQ9NLA1yBOUCCPHTW99OWDrAsH9r7TBY8M+92tsovMVb8SzghVL?=
 =?us-ascii?Q?v1MDLyYp446A54UWC5fct7TBYBxomHgZ95lO3164slYa8sYNYQyNNJCsw2n6?=
 =?us-ascii?Q?c3TwPo95/BF0q8LXig5TBT6LiMRlgB59VBOkVoEeMmrxqzJuQlXvoOPxC9Tm?=
 =?us-ascii?Q?o3/gZ7jF17DG9HeDL1nb8EdLnKgZBFV6Q/DtZUvj8eh7uCljdzWY77GknX9z?=
 =?us-ascii?Q?ebUKyYuWeHUe5HU=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2025 03:03:17.1892 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d884d5ae-dc39-4d36-dda8-08dd7192eab3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00001CE0.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6761
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

This patch removes the deprecated SDMA reset callback mechanism, which was previously used to register pre-reset and post-reset callbacks for SDMA engine resets.
The SDMA reset callback mechanism allowed KFD and AMDGPU to register pre-reset and post-reset functions for handling SDMA engine resets.
The callback mechanism has been replaced with a more direct and efficient approach using `stop_queue` and `start_queue` functions in the ring's function table.

1. **Remove Callback Mechanism**:
   - Removed the `amdgpu_sdma_register_on_reset_callbacks` function and its associated data structures (`sdma_on_reset_funcs`).
   - Removed the callback registration logic from the SDMA v4.4.2 initialization code.

2. **Clean Up Related Code**:
   - Removed the `sdma_v4_4_2_set_engine_reset_funcs` function, which was used to register the callbacks.
   - Removed the `sdma_v4_4_2_engine_reset_funcs` structure, which contained the pre-reset and post-reset callback functions.

Signed-off-by: Jesse Zhang <jesse.zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c | 24 ------------------------
 drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h |  8 --------
 drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c | 12 ------------
 3 files changed, 44 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
index dbc7c7cfee01..2d61f25528dd 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
@@ -531,30 +531,6 @@ bool amdgpu_sdma_is_shared_inv_eng(struct amdgpu_device *adev, struct amdgpu_rin
 		return false;
 }
 
-/**
- * amdgpu_sdma_register_on_reset_callbacks - Register SDMA reset callbacks
- * @funcs: Pointer to the callback structure containing pre_reset and post_reset functions
- *
- * This function allows KFD and AMDGPU to register their own callbacks for handling
- * pre-reset and post-reset operations for engine reset. These are needed because engine
- * reset will stop all queues on that engine.
- */
-void amdgpu_sdma_register_on_reset_callbacks(struct amdgpu_device *adev, struct sdma_on_reset_funcs *funcs)
-{
-	if (!funcs)
-		return;
-
-	/* Ensure the reset_callback_list is initialized */
-	if (!adev->sdma.reset_callback_list.next) {
-		INIT_LIST_HEAD(&adev->sdma.reset_callback_list);
-	}
-	/* Initialize the list node in the callback structure */
-	INIT_LIST_HEAD(&funcs->list);
-
-	/* Add the callback structure to the global list */
-	list_add_tail(&funcs->list, &adev->sdma.reset_callback_list);
-}
-
 static int amdgpu_sdma_soft_reset(struct amdgpu_device *adev, u32 instance_id)
 {
 	u32 soft_reset;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h
index 47d56fd0589f..419531cc8207 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h
@@ -103,13 +103,6 @@ struct amdgpu_sdma_ras {
 	struct amdgpu_ras_block_object ras_block;
 };
 
-struct sdma_on_reset_funcs {
-	int (*pre_reset)(struct amdgpu_device *adev, uint32_t instance_id);
-	int (*post_reset)(struct amdgpu_device *adev, uint32_t instance_id);
-	/* Linked list node to store this structure in a list; */
-	struct list_head list;
-};
-
 struct amdgpu_sdma {
 	struct amdgpu_sdma_instance instance[AMDGPU_MAX_SDMA_INSTANCES];
 	struct amdgpu_irq_src	trap_irq;
@@ -170,7 +163,6 @@ struct amdgpu_buffer_funcs {
 				 uint32_t byte_count);
 };
 
-void amdgpu_sdma_register_on_reset_callbacks(struct amdgpu_device *adev, struct sdma_on_reset_funcs *funcs);
 int amdgpu_sdma_reset_engine(struct amdgpu_device *adev, uint32_t instance_id);
 
 #define amdgpu_emit_copy_buffer(adev, ib, s, d, b, t) (adev)->mman.buffer_funcs->emit_copy_buffer((ib),  (s), (d), (b), (t))
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
index df82a97a5388..29dbee7302c7 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
@@ -106,7 +106,6 @@ static void sdma_v4_4_2_set_buffer_funcs(struct amdgpu_device *adev);
 static void sdma_v4_4_2_set_vm_pte_funcs(struct amdgpu_device *adev);
 static void sdma_v4_4_2_set_irq_funcs(struct amdgpu_device *adev);
 static void sdma_v4_4_2_set_ras_funcs(struct amdgpu_device *adev);
-static void sdma_v4_4_2_set_engine_reset_funcs(struct amdgpu_device *adev);
 static void sdma_v4_4_2_update_reset_mask(struct amdgpu_device *adev);
 
 static u32 sdma_v4_4_2_get_reg_offset(struct amdgpu_device *adev,
@@ -1351,7 +1350,6 @@ static int sdma_v4_4_2_early_init(struct amdgpu_ip_block *ip_block)
 	sdma_v4_4_2_set_vm_pte_funcs(adev);
 	sdma_v4_4_2_set_irq_funcs(adev);
 	sdma_v4_4_2_set_ras_funcs(adev);
-	sdma_v4_4_2_set_engine_reset_funcs(adev);
 
 	return 0;
 }
@@ -1739,16 +1737,6 @@ static int sdma_v4_4_2_restore_queue(struct amdgpu_device *adev, uint32_t instan
 	return sdma_v4_4_2_inst_start(adev, inst_mask, true);
 }
 
-static struct sdma_on_reset_funcs sdma_v4_4_2_engine_reset_funcs = {
-	.pre_reset = sdma_v4_4_2_stop_queue,
-	.post_reset = sdma_v4_4_2_restore_queue,
-};
-
-static void sdma_v4_4_2_set_engine_reset_funcs(struct amdgpu_device *adev)
-{
-	amdgpu_sdma_register_on_reset_callbacks(adev, &sdma_v4_4_2_engine_reset_funcs);
-}
-
 static int sdma_v4_4_2_set_trap_irq_state(struct amdgpu_device *adev,
 					struct amdgpu_irq_src *source,
 					unsigned type,
-- 
2.25.1

