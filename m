Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0C80C369A4
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Apr 2025 08:37:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4792B10E619;
	Tue,  8 Apr 2025 08:37:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="shvF+CTW";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2059.outbound.protection.outlook.com [40.107.244.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BA44E10E619
 for <amd-gfx@lists.freedesktop.org>; Tue,  8 Apr 2025 08:37:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Z6mVb1L5CudGk2HRG3tKcc+zRwchE4rH8JzWz7n1/tg5415yZSFP3L86sny7A2DzesHR2xfNMj1U45T8C7Uw3D7+vjLgRnPQ930KQldUe+sjYwACaDcGqMKGj/WaAx9luk4Bv1kafqF0+FKtmAtrApkpkUOE094vzp8tBFcZVhxfBGEupbSSEKFZtrVWlgIo9PRXekljbuL7k0VoW2fXR5skPZeJyGqxX1nq2fLTWUG0Ozv1hE4LPb8l0ERmshHnsLm4IAVmmaKbUUZ1zQwr+C1ayiVjbSfgdFSGTzxZNWmEbDWs4hgPd6FmjIB0U2ff6/QKZmOx3gkOIc9KYaGxKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5zylK4ka1RiILaAmiDFDCV5AptwT8V5mU49kWEWWaCw=;
 b=FljFeqtK347ZDLqeKh0Ao0dDQQ6yNkKOonpvGEj5AkaSrF1ENePR9kcUIRKNoPuHu0PnVHEcGGR8xFnOo7/f2fsOdO9ecn8IOrKteV+qSmtBIEEbwgapZwdTCfr6/+SzG0C6rkqyIMG/WzyNd9m10FmZ95vpqoWgSi87He8MzpIBgIG4w2GeBAoMUHj3aFuzPIJTkwCmwZ9r1v+TsIQoB9jeijdoXvPinILqnAVVJDGfcTw4+APUG/H4SfYeC5JO5Jp1B/fLRSgt1QnU2KZzm9YyJyRpv3uNXkhz9eIesjFJbPd558JKxl4vO3u3hHoeYdbrfZMtPHsSxCOsMx9vIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5zylK4ka1RiILaAmiDFDCV5AptwT8V5mU49kWEWWaCw=;
 b=shvF+CTWixlaUYqE5hC0IIZofjzQSDAsRF0ZPj8Em4bj1wsyjkQXMgRkZi6zrwK54j5Smjm8UNha/7WgipDXxMBMr8izW+H8/mZFpQNMiYPqKMpC+kYDZKaCkJ5QHegqtJsVksJQplYNKS6IW+3JhSfzXxROy0djvjqhpevA23M=
Received: from BN9PR03CA0080.namprd03.prod.outlook.com (2603:10b6:408:fc::25)
 by SA1PR12MB8144.namprd12.prod.outlook.com (2603:10b6:806:337::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.34; Tue, 8 Apr
 2025 08:37:45 +0000
Received: from BL6PEPF0001AB53.namprd02.prod.outlook.com
 (2603:10b6:408:fc:cafe::b1) by BN9PR03CA0080.outlook.office365.com
 (2603:10b6:408:fc::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8606.34 via Frontend Transport; Tue,
 8 Apr 2025 08:37:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB53.mail.protection.outlook.com (10.167.241.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8606.22 via Frontend Transport; Tue, 8 Apr 2025 08:37:44 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 8 Apr
 2025 03:37:44 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 8 Apr
 2025 03:37:44 -0500
Received: from JesseDEV.guestwireless.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Tue, 8 Apr 2025 03:37:32 -0500
From: "Jesse.zhang@amd.com" <jesse.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 <jonathan.kim@amd.com>, <jiadong.zhu@amd.com>, "Jesse.zhang@amd.com"
 <Jesse.zhang@amd.com>, Jesse Zhang <jesse.zhang@amd.com>, Alex Deucher
 <alexander.deucher@amd.com>
Subject: [v4 7/7] drm/amd/amdgpu: Remove deprecated SDMA reset callback
 mechanism
Date: Tue, 8 Apr 2025 16:36:33 +0800
Message-ID: <20250408083633.2300420-7-jesse.zhang@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250408083633.2300420-1-jesse.zhang@amd.com>
References: <20250408083633.2300420-1-jesse.zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: jesse.zhang@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB53:EE_|SA1PR12MB8144:EE_
X-MS-Office365-Filtering-Correlation-Id: 3ab3f155-0ace-47b8-0087-08dd7678a262
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ik2wo1LznkBlVClYqPIzUZYydPpLCrMc8Cp2F33beodbfxc2+0DhVewh5NGc?=
 =?us-ascii?Q?nQGRD9XWKLLb/i4ZHsAW1wRps5PV+dOYbCSRGP+yT+qfjikvfhRHnz9Aefdj?=
 =?us-ascii?Q?nDbJjj95y5gbGirbVga8dAHS7XkRBHQjxbIilj5mGkKyKdKwYOBhW/Dhvcza?=
 =?us-ascii?Q?bOQWCYB/rTbDjH5EZJT7JGHvcLXNCdd6Sa3S1MvCJrHadfw51TSyW0GQbkzI?=
 =?us-ascii?Q?28bx90OHuw7lLOBrqnJbrayv/8EYVvrINZztLw91Fk4FfChAU/w8Y+CW3Enz?=
 =?us-ascii?Q?4f+gcqrfqIRMl34lUrom73WtK27RahRnT1iIKaALosKcthT1z11/U7oJLc6t?=
 =?us-ascii?Q?YdnfjSrPXg+cOcOZah1xyuVrFxaVTzgaO8T0A6Dp5NmJun8pn3xx+rBJY2C8?=
 =?us-ascii?Q?NkTu0wEoACUQVpv/rqMzy1XIzFOQd8VfolSSZbYyisMg91zMkdX82rJWI6Oo?=
 =?us-ascii?Q?gY/hM1K81F3rzQU42DpKBwlstKDyR2zbWHbxBFE/O+Qrw7hwkFN6wBjXt7US?=
 =?us-ascii?Q?4pDX+EhSxOQ9wYebLpxMn4FND4/gCdAZiAC29eXHb4pEKExWAy8RssZr9OMt?=
 =?us-ascii?Q?TjEcaeXwwah3oNgKhreu0U2JRa6Fx59WEy29WkAbFL9i6od7K3P8UJs9vJ4R?=
 =?us-ascii?Q?NV2BIvmvCSnNinY/+u75kk0NT0FS6rzvwKHAAMJbmkok4ss33JXcjcWDKW7i?=
 =?us-ascii?Q?4+8RhGK2udKrAenCeGidBxihY/keMPCLA72VV3Q1uTUkJfZuY7yXnypGGL/a?=
 =?us-ascii?Q?OlbxY1/IUYRhhW1jyU0+6AH+d4LqbXagPMcNb0TMLqjINcREUj9u0IGrbOvy?=
 =?us-ascii?Q?vtG7+hRB4GMwWTyZnx1aBTJkx2R6m3pdxQEEsaVojFXSvr6xIoSgL09Xvwab?=
 =?us-ascii?Q?ZUuAUWngTddzMjtTvj1ayNXO83s57LAF9oUpBFitrrKHFcJfnuNthVnhB/xT?=
 =?us-ascii?Q?ckU9CL+HwbhWqBeIEzPT+SMahQ5tfbr+X4UpjB/FTRB78ZjplvLHp3guyfwP?=
 =?us-ascii?Q?24XOHVeBLhQym1mdsyOTRsxYu7ER69w0be7HnqOdlPDLNqQYOqIFXajes35u?=
 =?us-ascii?Q?3scjlP6lfK/eWj90GSv5iyxMwFQIy4bcS+AHYY7fmeaWyqneBaFJAHw4SXMy?=
 =?us-ascii?Q?FIiipp8+6rbO/hmFhtzuAgogg+MWx+nhl99wq4C5OC6WZkh33B6+AHrVZKf6?=
 =?us-ascii?Q?jRdT9NWFD3fgvbpMNzOQ/b2X8lyvxjKIhr2PNtGKL2C+zWfanD1HE14Aqp/l?=
 =?us-ascii?Q?BQhVnXphfyOn+T30pVG4OkQk1m/hXaefBVfOzS1nSX7fQkJg1qLHvYquRn94?=
 =?us-ascii?Q?48Ta6kovK605xmnr+LTpyWZIeel1qt9CFq5czoi+jpj4SG/3SHKKFvmiUlhJ?=
 =?us-ascii?Q?DweuHjuO8dWPCtgwIIlu1hyRVUjtg00xsTgL8IJPE5QhnRk8QMcEeYa5TpUQ?=
 =?us-ascii?Q?R5epCZ9289aCD2bHYTob5wfPCWQb2McPFzNXEP8pwZfr7lt3VFQWjg/k/izn?=
 =?us-ascii?Q?pmY5Fpxq1BanM5Q=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2025 08:37:44.8650 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ab3f155-0ace-47b8-0087-08dd7678a262
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB53.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8144
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
 The callback mechanism has been replaced with a more direct and efficient approach using `stop_queue` and `start_queue` functions in the ring's function table.

The SDMA reset callback mechanism allowed KFD and AMDGPU to register pre-reset and post-reset functions for handling SDMA engine resets.
However, this approach added unnecessary complexity and was no longer needed after the introduction of the `stop_queue` and `start_queue` functions in the ring's function table.

1. **Remove Callback Mechanism**:
   - Removed the `amdgpu_sdma_register_on_reset_callbacks` function and its associated data structures (`sdma_on_reset_funcs`).
   - Removed the callback registration logic from the SDMA v4.4.2 initialization code.

2. **Clean Up Related Code**:
   - Removed the `sdma_v4_4_2_set_engine_reset_funcs` function, which was used to register the callbacks.
   - Removed the `sdma_v4_4_2_engine_reset_funcs` structure, which contained the pre-reset and post-reset callback functions.

Signed-off-by: Jesse Zhang <jesse.zhang@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c | 24 ------------------------
 drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h |  8 --------
 drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c | 10 ----------
 3 files changed, 42 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
index 96d0350c7754..ca42d47dd072 100644
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
 	struct amdgpu_sdma_instance *sdma_instance = &adev->sdma.instance[instance_id];
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h
index bf83d6646238..89a114680053 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h
@@ -109,13 +109,6 @@ struct amdgpu_sdma_ras {
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
@@ -176,7 +169,6 @@ struct amdgpu_buffer_funcs {
 				 uint32_t byte_count);
 };
 
-void amdgpu_sdma_register_on_reset_callbacks(struct amdgpu_device *adev, struct sdma_on_reset_funcs *funcs);
 int amdgpu_sdma_reset_engine(struct amdgpu_device *adev, uint32_t instance_id);
 
 #define amdgpu_emit_copy_buffer(adev, ib, s, d, b, t) (adev)->mman.buffer_funcs->emit_copy_buffer((ib),  (s), (d), (b), (t))
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
index c663c63485f4..e343aaaea12d 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
@@ -106,7 +106,6 @@ static void sdma_v4_4_2_set_buffer_funcs(struct amdgpu_device *adev);
 static void sdma_v4_4_2_set_vm_pte_funcs(struct amdgpu_device *adev);
 static void sdma_v4_4_2_set_irq_funcs(struct amdgpu_device *adev);
 static void sdma_v4_4_2_set_ras_funcs(struct amdgpu_device *adev);
-static void sdma_v4_4_2_set_engine_reset_funcs(struct amdgpu_device *adev);
 static void sdma_v4_4_2_update_reset_mask(struct amdgpu_device *adev);
 static int sdma_v4_4_2_stop_queue(struct amdgpu_ring *ring);
 static int sdma_v4_4_2_restore_queue(struct amdgpu_ring *ring);
@@ -1358,7 +1357,6 @@ static int sdma_v4_4_2_early_init(struct amdgpu_ip_block *ip_block)
 	sdma_v4_4_2_set_vm_pte_funcs(adev);
 	sdma_v4_4_2_set_irq_funcs(adev);
 	sdma_v4_4_2_set_ras_funcs(adev);
-	sdma_v4_4_2_set_engine_reset_funcs(adev);
 	return 0;
 }
 
@@ -1747,14 +1745,6 @@ static int sdma_v4_4_2_restore_queue(struct amdgpu_ring *ring)
 	return sdma_v4_4_2_inst_start(adev, inst_mask, true);
 }
 
-static struct sdma_on_reset_funcs sdma_v4_4_2_engine_reset_funcs = {
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

