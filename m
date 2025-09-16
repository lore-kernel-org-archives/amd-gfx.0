Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D288CAC599
	for <amd-gfx@archiver.kernel.org>; Tue, 16 Sep 2025 08:08:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0542510E6EA;
	Tue, 16 Sep 2025 08:08:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="yO1C9PXf";
	dkim-atps=neutral
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012038.outbound.protection.outlook.com [52.101.48.38])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1D50E10E6EA
 for <amd-gfx@lists.freedesktop.org>; Tue, 16 Sep 2025 08:08:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lD2RsuEaL5buRQIyV9lp9f7dm8EqFU2Xn6VPH+z1xruhNl+FJWXKog7+fMpRYcJMc5MMSpXWC8OjNewbzRseJSxorJEm1F9VuOr/1SiUhQGE+H6xyBtENj3w67mzpoD1Dzyg8Tvzw2eWLXA4jIlunVs2vPDQKz+eVXuMU7rLC+qV4Bf6+RrpVvTZRiqX88zHhM1YYAb/AuuQKWMuAxhCKUA+tyOrrfHzm2WvK97HMUslqKSVxYOmj4qGlrTWFFqbjfjHzpQE3vLNva7RnLngSwprf13esbhpCZ/vdxjsosGhZFghof6uwuVjH0OaPhgOgBuXJkgz7gwZQlArPR+9Xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RdBHMMt/9n75CldmDRmB+cmvzeKcR8zXZXW5L93vcJA=;
 b=ldbGgl3Fc+wKyyLJafhoDqNM7RoU1pLWSfNCh6FXFnyTtkXYjs8GOLDhO/Fwo4S8Z9zpcWUKXzXN7G6ZC4T3hQ00ua7OSU7EwsjaD4QnrsNKQSLO004tYqRAtU9HE4havti0OVe+iafJxYzG9VkoJ82ZMaCukzzZ99xNSXWkY0iI8p+4ka3NGFJrzsxE1bxMi2EUCbvuxRZ+WmtBXWraoIgugVkzgWmjxwSEF8bGdH9u+oZoIfnQEoBe8XZ+ksMR2BZ9KNT01UIJ/33jP92AGZp8JIi+87GHyAAQUihDuHvkA0PMZ/5NZ6QZyTDJpdl4Ihbhdwstg2tibbqJum1IGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RdBHMMt/9n75CldmDRmB+cmvzeKcR8zXZXW5L93vcJA=;
 b=yO1C9PXfoXSxPQfJT7xX6rbNSQkkJeXVanUW9X8oUDhuXWbM4gBGwG+AZUQ6xGXXDrikeL3AZdYCDC+vwdVLzV+EfY5/xN0aF+MT5MRWjl2ztKlDxyaIzi2eEBm2qGU90vSPEjtDoGaxGBtktbRoV/rNqGyrMpE0HebnfvhXyc0=
Received: from BN0PR08CA0011.namprd08.prod.outlook.com (2603:10b6:408:142::33)
 by CH1PR12MB9573.namprd12.prod.outlook.com (2603:10b6:610:2ae::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.19; Tue, 16 Sep
 2025 08:08:12 +0000
Received: from BN3PEPF0000B076.namprd04.prod.outlook.com
 (2603:10b6:408:142:cafe::dd) by BN0PR08CA0011.outlook.office365.com
 (2603:10b6:408:142::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9115.21 via Frontend Transport; Tue,
 16 Sep 2025 08:08:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BN3PEPF0000B076.mail.protection.outlook.com (10.167.243.121) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9137.12 via Frontend Transport; Tue, 16 Sep 2025 08:08:12 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 16 Sep
 2025 01:08:11 -0700
Received: from JesseDEV.guestwireless.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17
 via Frontend Transport; Tue, 16 Sep 2025 01:08:10 -0700
From: Jesse.Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 Lijo Lazar <lijo.lazar@amd.com>, Jesse Zhang <Jesse.Zhang@amd.com>
Subject: [PATCH v3] drm/amdgpu: Add fallback to pipe reset if KCQ ring reset
 fails
Date: Tue, 16 Sep 2025 16:07:35 +0800
Message-ID: <20250916080809.993236-1-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B076:EE_|CH1PR12MB9573:EE_
X-MS-Office365-Filtering-Correlation-Id: 199141dd-706d-4387-f2bd-08ddf4f82e50
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ipokG+bfkA8NjS9Z0tt+ka7T20s0YPUt25h9dzeyxbgr9lzxAMvqTx+r8PEo?=
 =?us-ascii?Q?Ba9GPOeI1fz5iN8ErRqDKxk1tgZ2MmLbQPzBb2k2OAD0N8Ga69QecNuwme37?=
 =?us-ascii?Q?VShWmU5sjTWSqeoHmMUw8wk5gJQBFLZlJ+OixW/DimiWsa013XpQXtkwtrCR?=
 =?us-ascii?Q?1BbO3YsXyhEXsxR6AA2rZMQT/HLIXNMWLtC91EMij2Z+FAfqtyVMWbl93FEG?=
 =?us-ascii?Q?m6ZD/os+yCjisWFRqueRpF/D5IhQukkaoFYBkyy8uYw23Y/VNVhkS+CyV7Hs?=
 =?us-ascii?Q?lxHIYYlrTfEMti67VKwOGrYTTpksP0Wsp42OB3oXnODYoTj19yIJeYhesMav?=
 =?us-ascii?Q?O3vgK4J/jNomsXOYLP15IRMCh0Er4eYjTux3s014TD1k5omQ2AG/3mP+E5rq?=
 =?us-ascii?Q?mhRlSXF9lOzrYszMw6zo5O51OhICeNkDTL2G8/euJjK0H0gGU2mazBxTqU21?=
 =?us-ascii?Q?FfR+UTy2RNv6OmqYhzNkHX1INi/SxDXH/dSk8TXx/qR5nb2v6Jo6L/MyEnTi?=
 =?us-ascii?Q?yD+Znge75X14lwLTgAyaZ7VuxiHTADirG0nHNTQuECARGq0MlPvtu1AVmpAq?=
 =?us-ascii?Q?iFyWQnBX8aFh+GmSBGsPJr21N7imlgcTnKDGfKHxWlX3v6m8OpSMxsA6GfAu?=
 =?us-ascii?Q?TKWMpy7cuboZjQpmqW4w2YscBgJjrXNffp3H4Wl+JLKhWmGAKrMnTjcbk+DK?=
 =?us-ascii?Q?UzCam4KRFCv1RRgdqf/xmoyKx8umnMbhwIKkL2m9tJauKJTv9hBSjKbXz9S8?=
 =?us-ascii?Q?V7Vf2qhI8IhUTXgrj54rmAe3khtSxBWnwxAU8mKtq8mOC/Iip/GE88SKzgeC?=
 =?us-ascii?Q?Kn6CJRxngC6LVGcH1Ks9PkwWkeV7tD5P5zOHp1rKddCmKNQdAQ5WVCrg0QJ2?=
 =?us-ascii?Q?4s8FTpnXKGyQz+zyAbKGS/BYMpaF6h/5+k1OldaWZYW81CYezjCfCzSenhaI?=
 =?us-ascii?Q?CcpeHugiuU3o7+wV1eJXv0QJox/vWk69UdhCQMSHaT4c0HFs6TyJX/yrB/t+?=
 =?us-ascii?Q?l+VxWkvlkPXqheOm02iwCOJr0h4XJ85Lj0uAmEUV4FjGE0yyWWJO7qLOuQjL?=
 =?us-ascii?Q?ckAtiTm3gTqymuN9PMHf8I8rvl3/0hUKysyAs/S+caj6P2bgYotXpWJemZl8?=
 =?us-ascii?Q?NpCx8U5yN22Ai9HvwKD93gwLUSphTa2bDrOSXtXpPA3+xTsOCE6jVe49UImZ?=
 =?us-ascii?Q?NS7HW8jRNrxcEcAFtSev0Oq7dQ4Le/fE7DXaU4opcBB6oJ0avduTxaHeABX/?=
 =?us-ascii?Q?JRDkAGTjEmGswYL5yNMUm4P5TmgbKVH0oCOZ401+AkakbryeBRfxNC0+OMVZ?=
 =?us-ascii?Q?IU1b0cU0E5cGF1gYeXVUYZdEnVub6bzf9J22NTxuDip2fp7LYxSx3PnnAnjk?=
 =?us-ascii?Q?z0BGak3YcpJM69SCak9vNA/4c5qJ2DigEMwwa2AUPz+d8pde7gbt0FCXW+uy?=
 =?us-ascii?Q?Wsw3xST+/LKH2E5HhT2ifCCad3Y7l8C2DFuuypuUcb7puiwf7taT+KoxLhtR?=
 =?us-ascii?Q?s07RFKBnW4DE1V2HjbBwMpdVno0QC3oK6hbv?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2025 08:08:12.2138 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 199141dd-706d-4387-f2bd-08ddf4f82e50
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B076.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PR12MB9573
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

From: Lijo Lazar <lijo.lazar@amd.com>

Add a fallback mechanism to attempt pipe reset when KCQ reset
fails to recover the ring. After performing the KCQ reset and
queue remapping, test the ring functionality. If the ring test
fails, initiate a pipe reset as an additional recovery step.

v2: fix the typo (Lijo)
v3: try pipeline reset when kiq mapping fails (Lijo)

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
index 8ba66d4dfe86..77f9d5b9a556 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
@@ -3560,6 +3560,7 @@ static int gfx_v9_4_3_reset_kcq(struct amdgpu_ring *ring,
 	struct amdgpu_device *adev = ring->adev;
 	struct amdgpu_kiq *kiq = &adev->gfx.kiq[ring->xcc_id];
 	struct amdgpu_ring *kiq_ring = &kiq->ring;
+	int reset_mode = AMDGPU_RESET_TYPE_PER_QUEUE;
 	unsigned long flags;
 	int r;
 
@@ -3597,6 +3598,7 @@ static int gfx_v9_4_3_reset_kcq(struct amdgpu_ring *ring,
 		if (!(adev->gfx.compute_supported_reset & AMDGPU_RESET_TYPE_PER_PIPE))
 			return -EOPNOTSUPP;
 		r = gfx_v9_4_3_reset_hw_pipe(ring);
+		reset_mode = AMDGPU_RESET_TYPE_PER_PIPE;
 		dev_info(adev->dev, "ring: %s pipe reset :%s\n", ring->name,
 				r ? "failed" : "successfully");
 		if (r)
@@ -3619,10 +3621,20 @@ static int gfx_v9_4_3_reset_kcq(struct amdgpu_ring *ring,
 	r = amdgpu_ring_test_ring(kiq_ring);
 	spin_unlock_irqrestore(&kiq->ring_lock, flags);
 	if (r) {
+		if (reset_mode == AMDGPU_RESET_TYPE_PER_QUEUE)
+			goto pipe_reset;
+
 		dev_err(adev->dev, "fail to remap queue\n");
 		return r;
 	}
 
+	if (reset_mode == AMDGPU_RESET_TYPE_PER_QUEUE) {
+		r = amdgpu_ring_test_ring(ring);
+		if (r)
+			goto pipe_reset;
+	}
+
+
 	return amdgpu_ring_reset_helper_end(ring, timedout_fence);
 }
 
-- 
2.49.0

