Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3575ACD4F24
	for <amd-gfx@archiver.kernel.org>; Wed, 13 May 2026 10:47:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AA87B10E2E6;
	Wed, 13 May 2026 10:47:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="mR8vGMNM";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013019.outbound.protection.outlook.com
 [40.93.201.19])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AB74D10E2E6
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 May 2026 10:47:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IOOntBUk0u3h8G+ZMjKgFSRHKjx4o5RT4LNRv2PgCEDNQ8hP+i51KcZNvyf9naIBNevIucj10gGKOvslZl1/0Dgnk+0iTKDNjSHMHuAY1oe3udrz8Nhem8V2RZ5TCsTneic4O+O2lpl7MKf4zrwTUTxox8+u57RtlcC3SdqAG/OdCpiUuXc9Pk76B3FUaBWNndE658BZ769QHdIsZv9LqalxQP8a0JO9KUbwjuB4nOtHVELoCA9utatXkFyNpC4D//VJm4q0wYB6S1k01gf9ysdoiEEn4IpxYrDl0WCKhAcG9isqLwOo0x3oPWAG7j5mnrvLfG5YNk20x90gAf6iXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iSkHvRpHTvmmf4bPG1gFhDh/221hYhoC0D64aLQjuFw=;
 b=BWzn56sHOQBThIc6SsWsnl3uwjvTLhAi/LeJhVdzNyGI67LqGPu9hkNIKhgeD1ZsU++UDoGMgmWHNEjLA3YgUw54e7Y1h8DWv6HTe1Rzql2ohCCWeIqZvM1t9w/qeUC64AKEPr6uXJSKghR4VlKVwswaAwxlRidG5+YcXDajU7Ac/8P5b4Af957rHsFRTiAARMvan+HCxzAQRdtCaA9SmWR7e6S/dm6rYNFEveF4PNFT2YD66vCjjoTjwjRwpa+7PpiGwgbSWJ+tMRSrkWe+ljCDBgrvkcRrROJl+V2+SWtQiPPDQbj6REBYoRJ7kbayJMq1niMbLiitWkO4TZAuPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iSkHvRpHTvmmf4bPG1gFhDh/221hYhoC0D64aLQjuFw=;
 b=mR8vGMNMuprOLJ9hcecFnluB8/CLsN/8qRqawgs/1wShuUQbsKF+9fnKPGwsoZIEMaj7QAjSgD4EOkHKgMsgjksi85BxjXwbRHEzzfSJzvT9C1fEglC1qlaXRXjWv7InBMzcyKgLPV+18vONZuph7oW/yvcF+boUv4QJ0GRMJBE=
Received: from BN9PR03CA0531.namprd03.prod.outlook.com (2603:10b6:408:131::26)
 by PH7PR12MB8793.namprd12.prod.outlook.com (2603:10b6:510:27a::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.12; Wed, 13 May
 2026 10:47:32 +0000
Received: from BN3PEPF0000B074.namprd04.prod.outlook.com
 (2603:10b6:408:131:cafe::98) by BN9PR03CA0531.outlook.office365.com
 (2603:10b6:408:131::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9891.24 via Frontend Transport; Wed,
 13 May 2026 10:47:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN3PEPF0000B074.mail.protection.outlook.com (10.167.243.119) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.25.13 via Frontend Transport; Wed, 13 May 2026 10:47:32 +0000
Received: from work.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 13 May
 2026 05:47:31 -0500
From: David Rosca <david.rosca@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Christian.Koenig@amd.com>, David Rosca <david.rosca@amd.com>
Subject: [PATCH 2/2] drm/amdgpu/userq: Add syncobj_points to signal ioctl
Date: Wed, 13 May 2026 12:47:12 +0200
Message-ID: <20260513104710.9705-4-david.rosca@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260513104710.9705-2-david.rosca@amd.com>
References: <20260513104710.9705-2-david.rosca@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B074:EE_|PH7PR12MB8793:EE_
X-MS-Office365-Filtering-Correlation-Id: 45bf3054-f10b-405d-f82c-08deb0dd0941
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|376014|82310400026|1800799024|56012099003|22082099003|18002099003|13003099007|11063799003;
X-Microsoft-Antispam-Message-Info: SB2Lm6PksPUZoAzuvR8c2cx4q8RGLCblLQiGBcbuI6W2Bwt6sm85p/Qcu+XlkX60+UyxOqT3E3cgwGyXdsGxfl8o5ueWVms8TWPjFlJb2Ya5AdXffo72xbVUTkQdwH0Ip+L3wmciYZ07ERPS9E4PRWK23vnwzRMM7y+zHxBV7E40Pw0b5x7ZwtINQA74GkoQSYkiDmgP8PTclwX16V4cnFG7/keHUHV4+pUfq+tFdHkNabXqvrKThtiTVgUQTEElHyLKVkn8wDwF+l+KkcfRix0Y4GO+TwmGcB08+IRJSYR7JCb4T/hDrQjWjdKb7dIGAPrnhp5kSyTkDaESU563/HDHjUrHOXsJrMfNsJysbUALe9jLwQ60CDGePKVtvobqJr0tGi5zUQP172Lfvv2fqLpSLN27LF5mt2p4baIPR/uWzyWD5S+12KdQgP80wsMuVItduNmeF0MryGHtSNuVQc51t0TNXa3TzZvOaYNdeXnMNFlq2k8uyGCQ+6aEr1SAce34qEuzBllwPGMbbqT9WK5S5bvyhCtBxmTQkRPik3hUsfVEsbQ2fQ+IKK2Ne9kYrelIMTAIDtFCeauLzL0fzCQWlJfXjXq2FOTwBgdYGqodg4fK/a0D5qtp0FJEoDrF+X0Fn2D0gX+bYi50derB6mWu2hHTvUMB+hLbpFhfR8A=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(376014)(82310400026)(1800799024)(56012099003)(22082099003)(18002099003)(13003099007)(11063799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: ZWZD3D6sNSKafHEZ04ReyomIfdZulw0xMOH153+Gky3mgihos5dWvM2/BZIxBu8vtyAy/Mv1VIZWPjTpZGegmggX7DSeXsYOch8VKN743aGl7xCIDegTCX+FsLCG1roAU8B3EaYnLBNzb+JfeyrLRYrjbU6f8Jf8OTeWhLUdIkQTzKzWo1nWmuEKkKZHZI3r1dcfUgYZ3g58Kmth2Vpl+huTB5MsJ90xtsJoffHIUYoUAAl1Dj+bHSuX+rqqYtf5MgRI+iEMvwKmCXPWWS9dgBFYSIPey6s6TK/euOECtGgwOshX2NX1bOyNVVP2mzaRrTMVNCZrK5U+YDDSM/TS22ehZBe0PvyO5FnHn46l45u+0alfAvbO/Y6GHKp6xv9V+kVfc/vhp8SvW/Lc5G4xfzFEZD++yLbD5xw2jMKq64C1FL7Eae3QZ1DYpS8VrJdE
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2026 10:47:32.2347 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 45bf3054-f10b-405d-f82c-08deb0dd0941
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B074.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8793
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

Userspace patches:

* radeonsi NV_timeline_semaphore
https://gitlab.freedesktop.org/mesa/mesa/-/merge_requests/37335

* RADV user queues
https://gitlab.freedesktop.org/mesa/mesa/-/merge_requests/40808

Signed-off-by: David Rosca <david.rosca@amd.com>
---
 .../gpu/drm/amd/amdgpu/amdgpu_userq_fence.c   | 47 +++++++++++++++----
 include/uapi/drm/amdgpu_drm.h                 |  5 ++
 2 files changed, 44 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
index c0d68863fa17..66c5fbba83f4 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
@@ -460,9 +460,10 @@ int amdgpu_userq_signal_ioctl(struct drm_device *dev, void *data,
 
 	struct drm_gem_object **gobj_write, **gobj_read;
 	u32 *syncobj_handles, num_syncobj_handles;
+	u64 *syncobj_points = NULL;
 	struct amdgpu_usermode_queue *queue;
 	struct amdgpu_userq_fence *fence;
-	struct drm_syncobj **syncobj;
+	struct amdgpu_cs_post_dep *syncobj;
 	struct drm_exec exec;
 	void __user *ptr;
 	int r, i, entry;
@@ -482,19 +483,38 @@ int amdgpu_userq_signal_ioctl(struct drm_device *dev, void *data,
 	if (IS_ERR(syncobj_handles))
 		return PTR_ERR(syncobj_handles);
 
+	if (args->syncobj_points) {
+		ptr = u64_to_user_ptr(args->syncobj_points);
+		syncobj_points = memdup_array_user(ptr, num_syncobj_handles,
+					    sizeof(u64));
+		if (IS_ERR(syncobj_points)) {
+			r = PTR_ERR(syncobj_points);
+			goto free_syncobj_handles;
+		}
+	}
+
 	syncobj = kmalloc_array(num_syncobj_handles, sizeof(*syncobj),
 				GFP_KERNEL);
 	if (!syncobj) {
 		r = -ENOMEM;
-		goto free_syncobj_handles;
+		goto free_syncobj_points;
 	}
 
 	for (entry = 0; entry < num_syncobj_handles; entry++) {
-		syncobj[entry] = drm_syncobj_find(filp, syncobj_handles[entry]);
-		if (!syncobj[entry]) {
+		syncobj[entry].chain = NULL;
+		syncobj[entry].syncobj = drm_syncobj_find(filp, syncobj_handles[entry]);
+		if (!syncobj[entry].syncobj) {
 			r = -ENOENT;
 			goto free_syncobj;
 		}
+		if (syncobj_points && syncobj_points[entry]) {
+			syncobj[entry].point = syncobj_points[entry];
+			syncobj[entry].chain = dma_fence_chain_alloc();
+			if (!syncobj[entry].chain) {
+				r = -ENOMEM;
+				goto free_syncobj;
+			}
+		}
 	}
 
 	ptr = u64_to_user_ptr(args->bo_read_handles);
@@ -561,8 +581,15 @@ int amdgpu_userq_signal_ioctl(struct drm_device *dev, void *data,
 		dma_resv_add_fence(gobj_write[i]->resv, &fence->base,
 				   DMA_RESV_USAGE_WRITE);
 
-	for (i = 0; i < num_syncobj_handles; i++)
-		drm_syncobj_replace_fence(syncobj[i], &fence->base);
+	for (i = 0; i < num_syncobj_handles; i++) {
+		if (syncobj[i].chain) {
+			drm_syncobj_add_point(syncobj[i].syncobj, syncobj[i].chain,
+					   &fence->base, syncobj[i].point);
+			syncobj[i].chain = NULL;
+		} else {
+			drm_syncobj_replace_fence(syncobj[i].syncobj, &fence->base);
+		}
+	}
 
 exec_fini:
 	/* drop the reference acquired in fence creation function */
@@ -580,9 +607,13 @@ int amdgpu_userq_signal_ioctl(struct drm_device *dev, void *data,
 		drm_gem_object_put(gobj_read[i]);
 	kvfree(gobj_read);
 free_syncobj:
-	while (entry-- > 0)
-		drm_syncobj_put(syncobj[entry]);
+	while (entry-- > 0) {
+		drm_syncobj_put(syncobj[entry].syncobj);
+		dma_fence_chain_free(syncobj[entry].chain);
+	}
 	kfree(syncobj);
+free_syncobj_points:
+	kfree(syncobj_points);
 free_syncobj_handles:
 	kfree(syncobj_handles);
 
diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.h
index 9f3090db2f16..ad643b41982c 100644
--- a/include/uapi/drm/amdgpu_drm.h
+++ b/include/uapi/drm/amdgpu_drm.h
@@ -502,6 +502,11 @@ struct drm_amdgpu_userq_signal {
 	 * @bo_write_handles.
 	 */
 	__u32	num_bo_write_handles;
+	/**
+	 * @syncobj_points: The list of syncobj points submitted by the user queue job
+	 * for the corresponding @syncobj_handles.
+	 */
+	__u64	syncobj_points;
 };
 
 struct drm_amdgpu_userq_fence_info {
-- 
2.43.0

