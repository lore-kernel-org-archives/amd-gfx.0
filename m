Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70481CAC5A7
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Sep 2025 08:12:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 082A310E229;
	Wed, 24 Sep 2025 08:12:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="LBm8+WnM";
	dkim-atps=neutral
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010005.outbound.protection.outlook.com [52.101.56.5])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B64B610E229
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Sep 2025 08:12:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mtqOKvHhmi2g+cJbvwUakd9zMbbMFZYI1GaGCRFg55Z1gr//Qt3Zq72vJjft/Rz/VknAalrCCZlQJ/u5kyV42c6BPMMuogGRP33mhWbk64CA0KFbrjJuJcz7+UrivxC6utB+UMb0Mh1Op3dJAgGXfsr3R80rqfSv44o0jl+Xc03qYpm4kquIdmlcSGarsU1kFUPv+1V+jPTZtA1N3KtMVNyOKBLbD+HUIOk9vGTrd06aAN6UM01MVbJfmNv6EEvdLYAZebu13ruyuZUoIWRgNvIgAyPNnEjKtTnLBkL3dcHMQV/GeI/OLRqF1zhVoR+gB0eMflSOX+cVx5mtsm6cBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JR439/+KoU6SqinwznBhZrrM8eDk/8zmOS1AtFyruh0=;
 b=Aygw1klCuLunV4PKPOYuTKBlCeyKKJm7eAuDCvfpLv4PQoSe+r/Ar5PVYnTXX3AT4EZQNBGiL5F5tqxDK2NKx9PPknLvliFXru3MXQDUvD7nzSEOpsCt29Md6vYnrEntSZoyNg24zBbXac8llSffGABz7UqRFdWbBAB+ihPmNv0LNh7vFR7yxz7fa8xUbA1bD9E2qXKHlxiJs5BoDaLuYYSncYrFSumNFogDXRyfjCBGsT2mHbkamjegfpm0w60ocs5rpAOLhkjPoX9LbGclHHhImV00VoeKrmnSi4Ltt5YTIcLKm6WG0VQ++NsudMmyGCq12R8EfyVScGsU7He9jg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JR439/+KoU6SqinwznBhZrrM8eDk/8zmOS1AtFyruh0=;
 b=LBm8+WnMQSswM3yTMitrRQ1JWVFhentHRuF/yypKRYvPPb/SB/oN98gNnAyoIH1jkYNIeyTNn+HFHONoFlklV5G/9bD+2ITLoBB/qfKkPMRP8VX3nS6aKFF8n8zUipSmRWdgWRhYr6vZxDl9nwfcuuYMWhKg517Ny795eQvmOgE=
Received: from MN2PR16CA0039.namprd16.prod.outlook.com (2603:10b6:208:234::8)
 by SA0PR12MB4432.namprd12.prod.outlook.com (2603:10b6:806:98::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.9; Wed, 24 Sep
 2025 08:12:33 +0000
Received: from BL6PEPF00022574.namprd02.prod.outlook.com
 (2603:10b6:208:234:cafe::f1) by MN2PR16CA0039.outlook.office365.com
 (2603:10b6:208:234::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.20 via Frontend Transport; Wed,
 24 Sep 2025 08:12:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BL6PEPF00022574.mail.protection.outlook.com (10.167.249.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9160.9 via Frontend Transport; Wed, 24 Sep 2025 08:12:32 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 24 Sep
 2025 01:12:32 -0700
Received: from JesseDEV.guestwireless.amd.com (10.180.168.240) by
 satlexmb08.amd.com (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17
 via Frontend Transport; Wed, 24 Sep 2025 01:12:30 -0700
From: Jesse.Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 Jesse.Zhang <Jesse.Zhang@amd.com>
Subject: [PATCH] drm/amdgpu: Fix fence signaling race condition in userqueue
Date: Wed, 24 Sep 2025 16:11:11 +0800
Message-ID: <20250924081230.2341706-1-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00022574:EE_|SA0PR12MB4432:EE_
X-MS-Office365-Filtering-Correlation-Id: 9bace5a0-667a-4cbe-b066-08ddfb421cd5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?qk/A7QV+CYRkf9ObvO3KdIb+Oa264bKMRzfGMRclCxYH1JqBeTmXGkwHrbP2?=
 =?us-ascii?Q?My6OHwDHc8QQ1o7wPFKbdZ5RPdKlBVx1iFfZFRwZ4/Te7rsUwdUw7gPar5xk?=
 =?us-ascii?Q?QvIbunBVoxYnRAd/emZGJnEQ2ZziaKrvJjQzGr725KvauF4RFMPM49VyeTZp?=
 =?us-ascii?Q?gOUSrvaORpY+eMahxsrsg+Kus5QcYohIKXhcQ9AQtN9r1/ZI40EXo41lCdoi?=
 =?us-ascii?Q?0rrjnrNvThymzs9xNvXlKuw0taT+6uF5x07PArzFlt7MsCMsp7aP0/xV0U67?=
 =?us-ascii?Q?nT3Mn1B6lMXkTxsZFOjVR5FlXMs+E44LVnlqRgZh3YMlyZuVOlXpQA8IJ3QU?=
 =?us-ascii?Q?t9yGxmsOG91cPFnrvK070DDdi4e+lnWr9vuOMzj2ze7jLp9K5XIJNhq8x8rv?=
 =?us-ascii?Q?iNCNLgxB4RAHI3kvLSKFUivGWizXkmlMSSUAdsSiUyHhERmv3dehdSB0SQ89?=
 =?us-ascii?Q?Qx7DU2HSGC/Q/H2ISeb9+NPHcuYb08mM6lCn/PA/GbgWQGZGwhK7h6MlAO67?=
 =?us-ascii?Q?lnylcNBy5k9O3S++dHsftnV6Mc3dIBJZWKE4y6MVtkdh+YrxxNrXpTkoWqhm?=
 =?us-ascii?Q?Zes8KCGa6e0bYI7HwcesIILyfhHaISWvr2zWXs9U+EkhN5ENWaG6YM/l4vQQ?=
 =?us-ascii?Q?xSwQZajf3DCV8/tQHIx3g03J97dMFObXYlkW9HaC5me1vAHMAyyb1rMQu4ID?=
 =?us-ascii?Q?0HkY/ud/cVeQiYm1yF+5kCIS5O8rIRXLwL4RBKWUTshqXs/d9431OEDMGYIx?=
 =?us-ascii?Q?d2WIBDJkVgtggKVnH4JK204Q66uVXYeDHbozqhBcXP9vqQsNVibpWFOMyRe0?=
 =?us-ascii?Q?NXT+CB1DDdP/GYrQBSt+4sthLvqeHMEdigwBVsdCt8iuL1mc/lIxySskQw58?=
 =?us-ascii?Q?lSzJY4DYcNfgEw7U6x+2+Lyxo6jKU0X+O1qBUYqpjaer6rH3Y3s7WZfz5gkG?=
 =?us-ascii?Q?qlD6FltGGnnoCw3wklIXhn2f8I3FKZVHoY68yevIOXDtYlpvwvg+FvqF8o0C?=
 =?us-ascii?Q?oNQ76lbgTu9Cyu0ME7nSth7gyZVUZ1Irt1awZ85+/7TZb65nvbrGtyzRGKwW?=
 =?us-ascii?Q?8TAENL0wcuOr/OmR1iib2tNDKtewHx7sOF/KZHgdFxWhCQjsOK28N+i57dtk?=
 =?us-ascii?Q?S6KA5A9BOSAUfd3aBCY/B7eP7pkZU4qkzW6qwlOA+zJJ179Yrxi+POIyfEBF?=
 =?us-ascii?Q?JI9y1uEs46P0Fa1sB/xIDF3nPsVGPoBUqZPalFv/VEaf7N11v6bUBtzl7BmI?=
 =?us-ascii?Q?6FltfYWMJMushdK4h2s5BvpCeaQS8WffILakvz1E3kFUYAs/vMWNCNTM2zoe?=
 =?us-ascii?Q?K/9JhQ9y19EI+fvcWb29C1GVYSuEOt0X3oK/Wnisv+8LyQYEfvzi4MojRmsO?=
 =?us-ascii?Q?qUT7gSXWtLOt7O5mv+osO4kIahgds0laW+QqdxaMmaC5dQD5Ua1lhY8CR5tJ?=
 =?us-ascii?Q?3/7l2PZBpvLTWqqk4h2yikjf/oh94bwOconpD7pyU/3Jlq95C7sMC8kL++wR?=
 =?us-ascii?Q?F6qSLhzJ6KQPC/tLKMpB9kOKhhFwWZBz4m4s?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2025 08:12:32.6222 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9bace5a0-667a-4cbe-b066-08ddfb421cd5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF00022574.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4432
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

This commit fixes a potential race condition in the userqueue fence
signaling mechanism by replacing dma_fence_is_signaled_locked() with
dma_fence_is_signaled().

The issue occurred because:
1. dma_fence_is_signaled_locked() should only be used when holding
   the fence's individual lock, not just the fence list lock
2. Using the locked variant without the proper fence lock could lead
   to double-signaling scenarios:
   - Hardware completion signals the fence
   - Software path also tries to signal the same fence

By using dma_fence_is_signaled() instead, we properly handle the
locking hierarchy and avoid the race condition while still maintaining
the necessary synchronization through the fence_list_lock.

Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
index 59d0abbdfc2f..ac366e1bc9ab 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
@@ -289,7 +289,16 @@ static int amdgpu_userq_fence_create(struct amdgpu_usermode_queue *userq,
 
 	/* Check if hardware has already processed the job */
 	spin_lock_irqsave(&fence_drv->fence_list_lock, flags);
-	if (!dma_fence_is_signaled_locked(fence))
+	/*
+	 * Use dma_fence_is_signaled() instead of dma_fence_is_signaled_locked()
+	 * because we only hold the fence_list_lock, not the individual fence lock.
+	 * dma_fence_is_signaled_locked() should only be used when the fence's
+	 * own lock is held, which isn't the case here. Using the locked variant
+	 * can lead to race conditions where the fence gets signaled twice:
+	 * 1. Hardware completion signals the fence
+	 * 2. Software path also tries to signal the same fence
+	*/
+	if (!dma_fence_is_signaled(fence))
 		list_add_tail(&userq_fence->link, &fence_drv->fences);
 	else
 		dma_fence_put(fence);
-- 
2.49.0

