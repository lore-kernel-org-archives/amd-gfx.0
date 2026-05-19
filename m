Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27D9BCD5BA4
	for <amd-gfx@archiver.kernel.org>; Tue, 19 May 2026 13:12:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BCE5910ECBE;
	Tue, 19 May 2026 13:12:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="IxpHF86K";
	dkim-atps=neutral
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012056.outbound.protection.outlook.com [52.101.53.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7DAFB10ECBE
 for <amd-gfx@lists.freedesktop.org>; Tue, 19 May 2026 13:12:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=msbq8Bl5JnMz+C0i3S7Eh8MpK7fPJv0XzTEJzwxaotpiSM92u0xMql92hxjWA0hY7ubX1hy52Af9S59vkBsfrqDMkqI+D8tYdHdC49ACT4b1ty5BWM/yA8MCpN3ThP7S10PuL5VcHdWGqAFqjSJPV6ymzZnQ3p/K3uDgyuNP16Y/9fJKBWuDifehl8gBfixxAAIFHp5R5YXFeT9wvrbH9JPQAq2IyNtGZJjV/2RumfFnbwPB0+f1uHLH2QIf185rLIKxTTTiEjo3Deo87DAGeaVN5BFXGbCo1pleyzYCeFWUmxPVw5BBOdsfG0ti/rFCtYc9hZ6TSK8yhhSmTMw5gg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1EViN+46EC2qMIqaoKsibErnNtXyKLxY8eoan86vbV8=;
 b=Pug6vXq3tKaE5SNwPXeyUc0iEievrzi5+MFQ4PYiAnOWUWJ+FWVifJZ6Cf+TvQBrOdOyNzNWqDFENkOQ5suTgLeCcy4uOswkyyUBCQv13CJWNwnLR9lV49yqMScpS+6OWjrZPLS7fgmUmKv8As2yZgbpsDXz4HfCzq/yvlYkzbE24Nd1VQu5yvyrwlRM0K8Ylyxv65a7iX9McMNpXq/JYkrFu4SQJzAbWBzkq0ZMhVzdij//+JL4jkqByPxziFNPdW6IwBj+02NZDU6PqeUTXkHic9Sjk695LjbBVyos2thGddcCSTsfwmWQo9Ly9N+M5QRboFQ4OBR1L+vx0+CD2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1EViN+46EC2qMIqaoKsibErnNtXyKLxY8eoan86vbV8=;
 b=IxpHF86KoH008fa/hM2a/j8PyWObUR0S7fv0fJ8Bi3KDraJtPs4hHE5zRRbIr9sPYLdlFlqpAb7tski7VXbOYBIOoe378izYlMwfp873LwXukIBs05LllPr3fv+PX2TEn9PgIT4XS0F6HVGMY0bfm/6Hlw6z499P0ZUT+ceMHwA=
Received: from MW4PR03CA0104.namprd03.prod.outlook.com (2603:10b6:303:b7::19)
 by IA0PR12MB7721.namprd12.prod.outlook.com (2603:10b6:208:433::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.23; Tue, 19 May
 2026 13:12:37 +0000
Received: from MWH0EPF000C618E.namprd02.prod.outlook.com
 (2603:10b6:303:b7:cafe::9c) by MW4PR03CA0104.outlook.office365.com
 (2603:10b6:303:b7::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.48.14 via Frontend Transport; Tue, 19
 May 2026 13:12:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MWH0EPF000C618E.mail.protection.outlook.com (10.167.249.100) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.48.11 via Frontend Transport; Tue, 19 May 2026 13:12:36 +0000
Received: from work.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 19 May
 2026 08:12:35 -0500
From: David Rosca <david.rosca@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Christian.Koenig@amd.com>, David Rosca <david.rosca@amd.com>
Subject: [PATCH v2] drm/amdgpu/userq: Add syncobj_points to signal ioctl
Date: Tue, 19 May 2026 14:58:45 +0200
Message-ID: <20260519125844.33399-2-david.rosca@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000C618E:EE_|IA0PR12MB7721:EE_
X-MS-Office365-Filtering-Correlation-Id: 07f46b92-7d85-4714-d09b-08deb5a84bd4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700016|1800799024|56012099003|18002099003|11063799006;
X-Microsoft-Antispam-Message-Info: mSZ5jojWTOmdzk+4LB3l9fprKv+VsQ+0P0vu1RhJPNXFtGrWp8A08DxGL39J6BrsgV2CRQSZVQjgYOnN6FmOgWjGreBH+bIDQ6ekTP8OOEly5/jneZEMyI06XpjTEj8gBYDqTXMpkICIDLOLp+TYECUWwL0YJUmfWt+KJGTbCAWc2MvyOjb0fPYUDuVSwTTIybkm2LuJGFfizF3+/r6hKyZOvPKMjSGW1bW/j+XHWAeXEMBW1pH6wkSl2aiCngcEjgLodXMMJRmbbhff6t8Rpv1L5Tfd4SnvbN3FYngYtesFqEFnlXqsks5LdEa3UF4aDdNVkQCmtD8RdEck9v+xYLDd74FkaRQsHNabnRlu1Sp4te9OEGKrK2cibio8E/NVHyG8Oct1scpDXo+DMm/BBxYodXCPje2Zj+h9Dk33TrrP0OQFDwc2au2metixwJ5ZPA55s9m/bbY2BH3aixlbD0N9Mej+8qfHhrIiIIkoXKGqCVwRpQ14H0/N2VfNQkYAajb3qdag8fc1/IMnBgeFoBQwddkZH1BMV8SRU1mdENZy2tk4P7uC8LHM2/KKKsD50kP0nBZXMPjvcaSMpSy+Szk2/9UYlQIeRe8A/iNYo5msjNJUig370tiVMLP+QVynDQjkHL0iAN15qAX7KyJpVZOhxNDitstuO4PrVLWSJbV1cMLzE4IwMEX+tVLy54Ro
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700016)(1800799024)(56012099003)(18002099003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: tjZsyOBkVrtENUOJB0u3Hv1yPoHnUXLklkDZbnAWYF5kEN9MrGTKrLqAZmml8Yqj1n9FxDlk48lh+cpXYdn1Tkgu5xES2JoDbsRPrQ7ZYNt3CmqOlWPCP1+2v2ICN5VNWkfkaqAPKhjnTAEEUv5bRc+RCQlC1cGvGMvDQ+TOUdPta9r/slIZnFd4FydH+iCvagTvPmH/B9EiKoq7BKdkfmyxuSwKUXqpavJFHZfZSA5hkHzjZbk7ygUpZWeGuFVgvikNmadJ6jNSYtuEBRzk16fTE+sk9NSNLFP7TpWEqASLw44hTST+XRrfllUWF9Wy6mk7JUiybL3aWzaVG5YXDwTCUhkIt4hINOU7s0VNte3J4JmefJP+vInpoSMvd3XRsP9GWFw4cIjPC/jGc4XwSnEPAYLlQ6I9F/bUSmG8vH/iHj2FJSvG8+f9X/2HGETf
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2026 13:12:36.3508 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 07f46b92-7d85-4714-d09b-08deb5a84bd4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000C618E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7721
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
v2: don't use struct amdgpu_cs_post_dep
    fixed syncobj leak when dma_fence_chain_alloc fails

 .../gpu/drm/amd/amdgpu/amdgpu_userq_fence.c   | 50 ++++++++++++++++---
 include/uapi/drm/amdgpu_drm.h                 |  5 ++
 2 files changed, 47 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
index c0d68863fa17..f4366c5d1e35 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
@@ -460,9 +460,13 @@ int amdgpu_userq_signal_ioctl(struct drm_device *dev, void *data,
 
 	struct drm_gem_object **gobj_write, **gobj_read;
 	u32 *syncobj_handles, num_syncobj_handles;
+	u64 *syncobj_points = NULL;
 	struct amdgpu_usermode_queue *queue;
 	struct amdgpu_userq_fence *fence;
-	struct drm_syncobj **syncobj;
+	struct {
+		struct drm_syncobj *syncobj;
+		struct dma_fence_chain *chain;
+	} *syncobj;
 	struct drm_exec exec;
 	void __user *ptr;
 	int r, i, entry;
@@ -482,19 +486,38 @@ int amdgpu_userq_signal_ioctl(struct drm_device *dev, void *data,
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
+			syncobj[entry].chain = dma_fence_chain_alloc();
+			if (!syncobj[entry].chain) {
+				drm_syncobj_put(syncobj[entry].syncobj);
+				r = -ENOMEM;
+				goto free_syncobj;
+			}
+		}
 	}
 
 	ptr = u64_to_user_ptr(args->bo_read_handles);
@@ -561,8 +584,15 @@ int amdgpu_userq_signal_ioctl(struct drm_device *dev, void *data,
 		dma_resv_add_fence(gobj_write[i]->resv, &fence->base,
 				   DMA_RESV_USAGE_WRITE);
 
-	for (i = 0; i < num_syncobj_handles; i++)
-		drm_syncobj_replace_fence(syncobj[i], &fence->base);
+	for (i = 0; i < num_syncobj_handles; i++) {
+		if (syncobj[i].chain) {
+			drm_syncobj_add_point(syncobj[i].syncobj, syncobj[i].chain,
+					   &fence->base, syncobj_points[i]);
+			syncobj[i].chain = NULL;
+		} else {
+			drm_syncobj_replace_fence(syncobj[i].syncobj, &fence->base);
+		}
+	}
 
 exec_fini:
 	/* drop the reference acquired in fence creation function */
@@ -580,9 +610,13 @@ int amdgpu_userq_signal_ioctl(struct drm_device *dev, void *data,
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

