Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC37DC43458
	for <amd-gfx@archiver.kernel.org>; Mon,  6 Jul 2026 20:06:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 155DC10EAA6;
	Mon,  6 Jul 2026 20:06:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="lWJHGtGN";
	dkim-atps=neutral
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010006.outbound.protection.outlook.com [52.101.85.6])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6156310EAA6
 for <amd-gfx@lists.freedesktop.org>; Mon,  6 Jul 2026 20:06:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YsE9KKFOrGDeDHaPV+v9iWcWhVC2FiLn+FGm1seAPumUHzgqSDhUKN+P/Os9x35AhaD+yA74MyYzeunCeeEcOBhIL6BHbUkebaMtob8haWyz/PeTGTyKzPhSSQ4/RoNUCXY+6NOhAYJ6/rBbaaNxsNkGUSQjbBgh2J80tcUcpgva8+HIVHFTPvvgLvj3gbNRTW+aOqpmMqbJx9wEcQegtxojqEa2EjgZ5bH8BljhKw4QoW/gAiSEWaw7XnCzzCmxDpwnOKtdb/tMA3pEYYsaxJ0s+1Ukrq9bDTS4NUZuJbCOYnidsIYpllIQqdSTzoGjYxIMR2QsSq0njyhPuks1tg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1fqTjbdl3CQbg/Aj8U+ZFe+5/NvolqFLoCJ6qWJzTU0=;
 b=D5mj50ASSWJ7ehgq5Zbnq/GoJplHtfrIpKrJrxeoG8reRbveDLF7F09CzPWdorv+y1vdT5eo2OtgyaUjMBIw7G6bcSOkXNoJ8SWZa3AfnRNBBKExmAS1LoCX1jFuEli9/yVDHn3aGxqIAAbzFQF3jDKqxzHP/Ie70dv/0cXwzkdWZJGbOgfsE/nG9OyiQa06yvPNq6g+avnedL+Wh7LMIfkhDU2AY+lB6ubfsh+Qt5GzqmJnP03W1g/MutsxQgicUs53DVQRoS3/It4VLEci4k6aZYsSYmHbe6daUZdgbHeGFjdPA2e9G/LsrxFsZdReghdqHFLB2pdK5Ftx/yeoHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1fqTjbdl3CQbg/Aj8U+ZFe+5/NvolqFLoCJ6qWJzTU0=;
 b=lWJHGtGNYMeaqraxLyyHva6SvS9ULJ207iZ48IZjdpMwH1QgSl0Df+j5uRkiG57LQrt6IZYnxEoXJ6teGcuZNqIcIgDxq4nUxr3BVhzRsOphteoS8x4Ty4rmuRPkvlbjzVrudXaccA3rLRUG8t+Habu/YQISUmLv1yJHBwh1ENw=
Received: from SJ0PR13CA0008.namprd13.prod.outlook.com (2603:10b6:a03:2c0::13)
 by DS0PR12MB9040.namprd12.prod.outlook.com (2603:10b6:8:f5::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Mon, 6 Jul
 2026 20:06:09 +0000
Received: from SJ1PEPF000026C9.namprd04.prod.outlook.com
 (2603:10b6:a03:2c0:cafe::8f) by SJ0PR13CA0008.outlook.office365.com
 (2603:10b6:a03:2c0::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.202.9 via Frontend Transport; Mon, 6
 Jul 2026 20:06:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SJ1PEPF000026C9.mail.protection.outlook.com (10.167.244.106) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Mon, 6 Jul 2026 20:06:08 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 6 Jul
 2026 15:06:08 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 6 Jul
 2026 15:06:08 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Mon, 6 Jul 2026 15:06:07 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 1/7] drm/amdgpu/gfx10: disallow gfxoff around GPU reset
Date: Mon, 6 Jul 2026 16:05:54 -0400
Message-ID: <20260706200600.15071-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000026C9:EE_|DS0PR12MB9040:EE_
X-MS-Office365-Filtering-Correlation-Id: 899dcdf6-7284-4723-403c-08dedb9a04e7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|36860700016|23010399003|11063799006|3023799007|18002099003|56012099006;
X-Microsoft-Antispam-Message-Info: f+a0HGSOnjy9QZ83CwKzXNfd2DRU6H74JU4m0up521vfxijB8IPV2ixWdY4GXNm+tqNnVyYmEZIuLvJtAqnuV41plOefKwcbF/QlBVW0PSyzCiF1mEwlAiIUykGlOPEDt4VdB1RHXx9CcFyO+IRjs+RScGNnPSEmQegkSkyt1huiwQnE9M9VlOeFSjmzlXJpNpbnGd8IQ6rbWbyNJIhVk9tnfy+Izkcgfo9Cf6AUBouZRtOoNnpARp+ao+FD5Q/3NWOANtg2zgl4DSR3XbXaAMcFhLytFWKn3RIQGg/TyGZIPI2R/jrt6H9NdfHBWL+W5VNZR4Y/b6pt67S8x+FbC49vqkQMaligMus7445VRvtXyP+WYwGtNQnDxy8jyTnb32mrVrQHPTizQ2eKaZwDub4rQxwGbYWEZKkSlrEMlqCBdwreUcSHzhHI5M0YKCmPNdL8IiwTW4Utb3VbzZVuQOKogGe/VsuJWf2FDS53TqvUt7m0mGdv6bsVqxBGzZAGQBKld95V6mcqtZ3nSHNorlxpbHCtjb2P2VrkAucNMyO5qXjaGjAifx2kT/TRZbyn2co/Dk+EOwfdhS1M11+QjonUhDgcFCnTyn3/DrEL28BlgDGtfXb5XNPjYD9k5rLJVZkVjEWvYHcHBk5o3eiumFOfheACkKEE9A82cYmftLNzxeKnyGJlPfPYeKOfE4wMeUdGLV1sQRImXgk03eO7QA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(1800799024)(36860700016)(23010399003)(11063799006)(3023799007)(18002099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 2OaLqToNnkywtpJp4Io9JIuatD9xkWcX8ocBpBHsK2JxdsqnYjwCFg+NudMreEEBjUxdINbUy5M7LOCulgPLijL+cK2xB84ILNZqxC/Z/27hGMkYjhXj6sOe/Wwmf3pyddt2QUIlD4D01PChx5WMTG51x+OUr5Mb0pNmL3Nv6q0LPY3cDnYaPBsckai14vqKe8LzQTeReS4+ivaJz6FQufMDgLEILulmIyhwxoGPU50ZQRwDneq2ZOaWo6D/3wI4iuiDM1Lb8MfUguJQp+WyY0pNK9whLfJKb9QlDyUdzgbiS8kO+I0MoVvBSnCiF2Oyn+5MFCU6UmR5Fq0M9ZO0hhUh7H/81kFe58i6AIrc9higCw077AMGE6XIyfJnBVx6r2rTfc+EAU6bFz0y6DE0t2I0ajbKOx6VLyUEnbhMllExPDyMUcHvDWvsCr3n0cuM
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2026 20:06:08.6208 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 899dcdf6-7284-4723-403c-08dedb9a04e7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000026C9.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9040
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

If gfx is hung, we shouldn't need this since gfx won't be
powered down, but we could potentially have a case where
a queue can be preempted, but due logic errors in the commands,
the fence never signals.  GFX could potentially go into
the off state.  Protect against that.

Assisted-by: Claude:claude-opus-4.6
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c | 34 +++++++++++++++++---------
 1 file changed, 23 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
index f03cbf358cd7b..516a621d11faa 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -9528,6 +9528,7 @@ static int gfx_v10_0_reset_kgq(struct amdgpu_ring *ring,
 		return -ENOMEM;
 	}
 
+	amdgpu_gfx_off_ctrl(adev, false);
 	addr = amdgpu_bo_gpu_offset(ring->mqd_obj) +
 		offsetof(struct v10_gfx_mqd, cp_gfx_hqd_active);
 	tmp = REG_SET_FIELD(0, CP_VMID_RESET, RESET_REQUEST, 1 << vmid);
@@ -9547,28 +9548,33 @@ static int gfx_v10_0_reset_kgq(struct amdgpu_ring *ring,
 	r = amdgpu_ring_test_ring(kiq_ring);
 	spin_unlock_irqrestore(&kiq->ring_lock, flags);
 	if (r)
-		return r;
+		goto fail;
 
 	r = gfx_v10_0_kgq_init_queue(ring, true);
 	if (r) {
 		DRM_ERROR("fail to init kgq\n");
-		return r;
+		goto fail;
 	}
 
 	spin_lock_irqsave(&kiq->ring_lock, flags);
 
 	if (amdgpu_ring_alloc(kiq_ring, kiq->pmf->map_queues_size)) {
 		spin_unlock_irqrestore(&kiq->ring_lock, flags);
-		return -ENOMEM;
+		r = -ENOMEM;
+		goto fail;
 	}
 	kiq->pmf->kiq_map_queues(kiq_ring, ring);
 	amdgpu_ring_commit(kiq_ring);
 	r = amdgpu_ring_test_ring(kiq_ring);
 	spin_unlock_irqrestore(&kiq->ring_lock, flags);
 	if (r)
-		return r;
+		goto fail;
 
-	return amdgpu_ring_reset_helper_end(ring, timedout_fence);
+	r = amdgpu_ring_reset_helper_end(ring, timedout_fence);
+
+fail:
+	amdgpu_gfx_off_ctrl(adev, true);
+	return r;
 }
 
 static int gfx_v10_0_reset_kcq(struct amdgpu_ring *ring,
@@ -9593,13 +9599,14 @@ static int gfx_v10_0_reset_kcq(struct amdgpu_ring *ring,
 		return -ENOMEM;
 	}
 
+	amdgpu_gfx_off_ctrl(adev, false);
 	kiq->pmf->kiq_unmap_queues(kiq_ring, ring, RESET_QUEUES,
 				   0, 0);
 	amdgpu_ring_commit(kiq_ring);
 	r = amdgpu_ring_test_ring(kiq_ring);
 	spin_unlock_irqrestore(&kiq->ring_lock, flags);
 	if (r)
-		return r;
+		goto fail;
 
 	/* make sure dequeue is complete*/
 	amdgpu_gfx_rlc_enter_safe_mode(adev, 0);
@@ -9617,28 +9624,33 @@ static int gfx_v10_0_reset_kcq(struct amdgpu_ring *ring,
 	amdgpu_gfx_rlc_exit_safe_mode(adev, 0);
 	if (r) {
 		dev_err(adev->dev, "fail to wait on hqd deactivate\n");
-		return r;
+		goto fail;
 	}
 
 	r = gfx_v10_0_kcq_init_queue(ring, true);
 	if (r) {
 		dev_err(adev->dev, "fail to init kcq\n");
-		return r;
+		goto fail;
 	}
 
 	spin_lock_irqsave(&kiq->ring_lock, flags);
 	if (amdgpu_ring_alloc(kiq_ring, kiq->pmf->map_queues_size)) {
 		spin_unlock_irqrestore(&kiq->ring_lock, flags);
-		return -ENOMEM;
+		r = -ENOMEM;
+		goto fail;
 	}
 	kiq->pmf->kiq_map_queues(kiq_ring, ring);
 	amdgpu_ring_commit(kiq_ring);
 	r = amdgpu_ring_test_ring(kiq_ring);
 	spin_unlock_irqrestore(&kiq->ring_lock, flags);
 	if (r)
-		return r;
+		goto fail;
+
+	r = amdgpu_ring_reset_helper_end(ring, timedout_fence);
 
-	return amdgpu_ring_reset_helper_end(ring, timedout_fence);
+fail:
+	amdgpu_gfx_off_ctrl(adev, true);
+	return r;
 }
 
 static void gfx_v10_ip_print(struct amdgpu_ip_block *ip_block, struct drm_printer *p)
-- 
2.54.0

