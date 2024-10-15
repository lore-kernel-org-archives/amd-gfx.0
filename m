Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40064CFC271
	for <amd-gfx@archiver.kernel.org>; Tue, 15 Oct 2024 07:43:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D71D010E51F;
	Tue, 15 Oct 2024 07:43:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Nqe88do5";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2060.outbound.protection.outlook.com [40.107.220.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AA24510E51C
 for <amd-gfx@lists.freedesktop.org>; Tue, 15 Oct 2024 07:43:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gPTUNd8RG8Ym/VkcvaAnn4eRc6v0uT1KNL8Yvwc01NqXOw54bXhHxYBGhtH0vKI7iJpYlSn2PpYnLu6Gy8EAKypLHDqORr0XR1Sz9zLa0NGDKdSiq8oyJfNxGdbFVzqKOkQaSFlxaMAKT2y25W+9iKmN7atGYjkg7O26WGf/3widImstoRP5cO+uQAmoJAFFpfqEPbxIa0Vxkz0kH6E/PQxCP8hSqdWy4GoolEtVCgKiUfqN6X+jFaJdeCaKksl7wBrGeGbXp+ezrK/iJ2++IkEchywhg0pJp3HtuzKHMgyN+Q4SoLL5Gv/omOyZTcXm+7kZQ6fzvEi4fwxiyXQ3gw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=298WT5uo4ZNyO5wSLCmBXWPCtd/SvUjCftR2aOeRnAE=;
 b=OMJt2wvDzgy2cwqBgH8WWsRVSbzM6QiCns7Z/thBRd9JTgPm/ZM/2TQEIGFNzbJ7f+eFh/d/4bcmWR/1IsYnFkAkoESmo8ID/rOt9hJM6mWqqRGXxiFZoJGDEUOJDd8SpKJiOE/C1VVTj7YjBKNlapK4c01b8NJLga1DJuO655gNfg4bGF7v6u0jvNyEDupdfRf1ayCrr5iZQTv6ThsgSUUe05QqRZjeD7L2mY6YfUZXyTZ1pPAoqVfknTGuqstbYtwb+wXvkKdLjcK9yqDlgKHlMjlDc/GovTZGFahjx/2+BVo7b1qTJ75JrtITIaXJuFyJBUzfBeI92ND2omo9pA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=298WT5uo4ZNyO5wSLCmBXWPCtd/SvUjCftR2aOeRnAE=;
 b=Nqe88do5mzrBvd9J6oT1I/HtcFy4PUJisGRzVn98pi2MVVg9YjjF+wX/Mghj3Pcoe9hKVFvn7z3cs02D5E55h6osLUgO2prlwQVsUZyytdrc63JXbNSbe6ROs37iAfhk2W4f58g42xJVOzvFGJAKPopqFA2JXRoP97lWv0AnHIU=
Received: from BN7PR02CA0033.namprd02.prod.outlook.com (2603:10b6:408:20::46)
 by MN0PR12MB6031.namprd12.prod.outlook.com (2603:10b6:208:3cd::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.26; Tue, 15 Oct
 2024 07:43:37 +0000
Received: from BL6PEPF00020E60.namprd04.prod.outlook.com
 (2603:10b6:408:20:cafe::92) by BN7PR02CA0033.outlook.office365.com
 (2603:10b6:408:20::46) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.27 via Frontend
 Transport; Tue, 15 Oct 2024 07:43:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF00020E60.mail.protection.outlook.com (10.167.249.21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8069.17 via Frontend Transport; Tue, 15 Oct 2024 07:43:37 +0000
Received: from amd-X570-AORUS-ELITE.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 15 Oct 2024 02:43:35 -0500
From: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>
CC: <alexander.deucher@amd.com>, Arunpravin Paneer Selvam
 <Arunpravin.PaneerSelvam@amd.com>
Subject: [PATCH v4 03/09] drm/amdgpu: Add wait IOCTL timeline syncobj support
Date: Tue, 15 Oct 2024 13:13:03 +0530
Message-ID: <20241015074309.2484264-3-Arunpravin.PaneerSelvam@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241015074309.2484264-1-Arunpravin.PaneerSelvam@amd.com>
References: <20241015074309.2484264-1-Arunpravin.PaneerSelvam@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E60:EE_|MN0PR12MB6031:EE_
X-MS-Office365-Filtering-Correlation-Id: 396b209a-4881-461c-2ecc-08dceced145c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?e2rnK5zfnDX7hSYqhHIYpWAuYIs7eXMjFq5a5I1lf9sJUJtg8qCVxIL0EQNJ?=
 =?us-ascii?Q?o9sgboq7aJoLRt11zag5QMEFBLBjcUGeX3zun9by8B85VVBhrawkz2eyzGYp?=
 =?us-ascii?Q?DS85YcWIoF4B6v0VZdwybbZGsCBqbiVn+U2H8d4LO+p4kDSN97HYg92QsEch?=
 =?us-ascii?Q?2Cgcfqu0XSNqJ0beTEvof6JDuq4jMCpDk3YPSl72y9piXSygVg/5Gm7npdRX?=
 =?us-ascii?Q?YCNNKGGGGpxXfw1PU+gnI5xD8DaWC3yOiMCrpeyuH2HF/fcg5z+EbAt2iR0K?=
 =?us-ascii?Q?R5Lxlz5XhePVXa60FoJ+y+VBqGt1nad83cytGdPDVZ+6Vq8W92wJ2L8PmeHJ?=
 =?us-ascii?Q?O3YCWMphRfLOanTfgsSRRmp8uWyy2eaBlE3agUtbaJZK1SO8PDIdsmoVzAmn?=
 =?us-ascii?Q?u7/Lhnev6u3LhpUigOKAdKWsPRUf+jo3AzT6t0gQzL8O2zROZ5hO1x6XajkZ?=
 =?us-ascii?Q?9VCrNbEGTPHWLX4pFcdGGjfpMVCTg4i31qOtHARYCSfY5BVfteNZgMnYJl6d?=
 =?us-ascii?Q?lTPlnPlOozTr0xCjjZyxp3MuyEln/YjJIbnJ3vUMFpoQBDarXYhIOq/eTFsZ?=
 =?us-ascii?Q?XfJLqpMcnWbmb+rdrlAY4l81hkdBlufbxq2qf1VvGSQfQEbYQFIwAveMQJXJ?=
 =?us-ascii?Q?M80YpCwAgmKyThjLh7crVh+DGGCwhGE+lnm9rSYyITvyc3S+jFvuZy0RE0Dy?=
 =?us-ascii?Q?b5N6iEj8MvOuJ1Isskngw6OW5ZLTdnHzdCI2p1IiMmq6GGKy/gn8XWWiBaLA?=
 =?us-ascii?Q?jXDURXL+0c0HwDEur2M1lXTDh9FF8Zzp4Xn3Trrk3gq9no7aQ0HQFuCRFA0w?=
 =?us-ascii?Q?3e5pv4ORPuYJ1nvUvUk3rYm96E0o8TdgXyRe+G3RfC92GLfISmywNGr/L3pJ?=
 =?us-ascii?Q?rXhqm0/7zn1+WsnEWyzPAPrjmI0dMSQyFHD2dMOrlHv6jvIqgL3QbuwlRJWQ?=
 =?us-ascii?Q?EG3aibhhsoxTg519+rd99hnkuG8yIA//qxC63mPooChZqwkD5rHWWyo0hZQh?=
 =?us-ascii?Q?7HFnryxLzzQbBbb5JbMQ+ID4bvU1Vw8BOyIejyultRdbjkxCzQr5d0B/hKfu?=
 =?us-ascii?Q?y4Lgh8MTBSCjiPTbnELGV2YkKl57FttLgwNXQDnzOyMysC68qPhi+vQYCAa+?=
 =?us-ascii?Q?Z/Fk5lPnmS0a3uWs2GHmVCV39PCIQz6rd0tcrN69BTrE8Rp6TGWYNy9hdsC5?=
 =?us-ascii?Q?Ej00tujkF5QVOF2gFpSx34pGwoWymsxTy3XmJzuP992jiDlesB75WONLaQEq?=
 =?us-ascii?Q?FMKJrAC6W9Ve7LXN6msvTAtAKe37+9F6gcNRsMzjxiQOEjF1CW3Q9btiS1eg?=
 =?us-ascii?Q?0pJRLPh8fz8sk3EYdBpO+kQP+VaS4vFoMdwHclSwx5s1Pfo9xp5fwv2snPMl?=
 =?us-ascii?Q?iT5WjvKmLHoxH+CFCDuJ/5GHaz15?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2024 07:43:37.2132 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 396b209a-4881-461c-2ecc-08dceced145c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF00020E60.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6031
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

Add user fence wait IOCTL timeline syncobj support.

v2:(Christian)
  - handle dma_fence_wait() return value.
  - shorten the variable name syncobj_timeline_points a bit.
  - move num_points up to avoid padding issues.

v3:(Christian)
  - Handle timeline drm_syncobj_find_fence() call error
    handling
  - Use dma_fence_unwrap_for_each() in timeline fence as
    there could be more than one fence.

v4:(Christian)
  - Drop the first num_fences since fence is always included in
    the dma_fence_unwrap_for_each() iteration, when fence != f
    then fence is most likely just a container.

Signed-off-by: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>
---
 .../gpu/drm/amd/amdgpu/amdgpu_userq_fence.c   | 91 +++++++++++++++++--
 include/uapi/drm/amdgpu_drm.h                 | 16 +++-
 2 files changed, 99 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
index 8f9d2427d380..1a9565b61266 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
@@ -24,6 +24,7 @@
 
 #include <linux/kref.h>
 #include <linux/slab.h>
+#include <linux/dma-fence-unwrap.h>
 
 #include <drm/drm_exec.h>
 #include <drm/drm_syncobj.h>
@@ -474,11 +475,11 @@ int amdgpu_userq_signal_ioctl(struct drm_device *dev, void *data,
 int amdgpu_userq_wait_ioctl(struct drm_device *dev, void *data,
 			    struct drm_file *filp)
 {
+	u32 *syncobj_handles, *timeline_points, *timeline_handles, *bo_handles;
+	u32 num_syncobj, num_bo_handles, num_points;
 	struct drm_amdgpu_userq_fence_info *fence_info = NULL;
 	struct drm_amdgpu_userq_wait *wait_info = data;
-	u32 *syncobj_handles, *bo_handles;
 	struct dma_fence **fences = NULL;
-	u32 num_syncobj, num_bo_handles;
 	struct drm_gem_object **gobj;
 	struct drm_exec exec;
 	int r, i, entry, cnt;
@@ -498,11 +499,26 @@ int amdgpu_userq_wait_ioctl(struct drm_device *dev, void *data,
 		goto free_bo_handles;
 	}
 
+	num_points = wait_info->num_points;
+	timeline_handles = memdup_user(u64_to_user_ptr(wait_info->syncobj_timeline_handles),
+				       sizeof(u32) * num_points);
+	if (IS_ERR(timeline_handles)) {
+		r = PTR_ERR(timeline_handles);
+		goto free_syncobj_handles;
+	}
+
+	timeline_points = memdup_user(u64_to_user_ptr(wait_info->syncobj_timeline_points),
+				      sizeof(u32) * num_points);
+	if (IS_ERR(timeline_points)) {
+		r = PTR_ERR(timeline_points);
+		goto free_timeline_handles;
+	}
+
 	/* Array of GEM object handles */
 	gobj = kmalloc_array(num_bo_handles, sizeof(*gobj), GFP_KERNEL);
 	if (!gobj) {
 		r = -ENOMEM;
-		goto free_syncobj_handles;
+		goto free_timeline_points;
 	}
 
 	for (entry = 0; entry < num_bo_handles; entry++) {
@@ -524,12 +540,34 @@ int amdgpu_userq_wait_ioctl(struct drm_device *dev, void *data,
 	}
 
 	if (!wait_info->num_fences) {
+		if (num_points) {
+			struct dma_fence_unwrap iter;
+			struct dma_fence *fence;
+			struct dma_fence *f;
+
+			for (i = 0; i < num_points; i++) {
+				r = drm_syncobj_find_fence(filp, timeline_handles[i],
+							   timeline_points[i],
+							   DRM_SYNCOBJ_WAIT_FLAGS_WAIT_FOR_SUBMIT,
+							   &fence);
+				if (r)
+					goto exec_fini;
+
+				dma_fence_unwrap_for_each(f, &iter, fence)
+					num_fences++;
+
+				dma_fence_put(fence);
+			}
+		}
+
 		/* Count syncobj's fence */
 		for (i = 0; i < num_syncobj; i++) {
 			struct dma_fence *fence;
 
 			r = drm_syncobj_find_fence(filp, syncobj_handles[i],
-						   0, 0, &fence);
+						   0,
+						   DRM_SYNCOBJ_WAIT_FLAGS_WAIT_FOR_SUBMIT,
+						   &fence);
 			if (r)
 				goto exec_fini;
 
@@ -588,12 +626,41 @@ int amdgpu_userq_wait_ioctl(struct drm_device *dev, void *data,
 			}
 		}
 
+		if (num_points) {
+			struct dma_fence_unwrap iter;
+			struct dma_fence *fence;
+			struct dma_fence *f;
+
+			for (i = 0; i < num_points; i++) {
+				r = drm_syncobj_find_fence(filp, timeline_handles[i],
+							   timeline_points[i],
+							   DRM_SYNCOBJ_WAIT_FLAGS_WAIT_FOR_SUBMIT,
+							   &fence);
+				if (r)
+					goto free_fences;
+
+				dma_fence_unwrap_for_each(f, &iter, fence) {
+					if (WARN_ON_ONCE(num_fences >= wait_info->num_fences)) {
+						r = -EINVAL;
+						goto free_fences;
+					}
+
+					dma_fence_get(f);
+					fences[num_fences++] = f;
+				}
+
+				dma_fence_put(fence);
+			}
+		}
+
 		/* Retrieve syncobj's fence */
 		for (i = 0; i < num_syncobj; i++) {
 			struct dma_fence *fence;
 
 			r = drm_syncobj_find_fence(filp, syncobj_handles[i],
-						   0, 0, &fence);
+						   0,
+						   DRM_SYNCOBJ_WAIT_FLAGS_WAIT_FOR_SUBMIT,
+						   &fence);
 			if (r)
 				goto free_fences;
 
@@ -616,9 +683,13 @@ int amdgpu_userq_wait_ioctl(struct drm_device *dev, void *data,
 				 * Just waiting on other driver fences should
 				 * be good for now
 				 */
-				dma_fence_wait(fences[i], false);
-				dma_fence_put(fences[i]);
+				r = dma_fence_wait(fences[i], true);
+				if (r) {
+					dma_fence_put(fences[i]);
+					goto free_fences;
+				}
 
+				dma_fence_put(fences[i]);
 				continue;
 			}
 
@@ -664,6 +735,8 @@ int amdgpu_userq_wait_ioctl(struct drm_device *dev, void *data,
 		drm_gem_object_put(gobj[i]);
 	kfree(gobj);
 
+	kfree(timeline_points);
+	kfree(timeline_handles);
 	kfree(syncobj_handles);
 	kfree(bo_handles);
 
@@ -681,6 +754,10 @@ int amdgpu_userq_wait_ioctl(struct drm_device *dev, void *data,
 	while (entry-- > 0)
 		drm_gem_object_put(gobj[entry]);
 	kfree(gobj);
+free_timeline_points:
+	kfree(timeline_points);
+free_timeline_handles:
+	kfree(timeline_handles);
 free_syncobj_handles:
 	kfree(syncobj_handles);
 free_bo_handles:
diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.h
index af42798e901d..3b24e0cb1b51 100644
--- a/include/uapi/drm/amdgpu_drm.h
+++ b/include/uapi/drm/amdgpu_drm.h
@@ -521,12 +521,26 @@ struct drm_amdgpu_userq_wait {
 	 * matching fence wait info pair in @userq_fence_info.
 	 */
 	__u32	bo_wait_flags;
-	__u32	pad;
+	/**
+	 * @num_points: A count that represents the number of timeline syncobj handles in
+	 * syncobj_handles_array.
+	 */
+	__u32	num_points;
 	/**
 	 * @syncobj_handles_array: An array of syncobj handles defined to get the
 	 * fence wait information of every syncobj handles in the array.
 	 */
 	__u64	syncobj_handles_array;
+	/**
+	 * @syncobj_timeline_handles: An array of timeline syncobj handles defined to get the
+	 * fence wait information of every timeline syncobj handles in the array.
+	 */
+	__u64   syncobj_timeline_handles;
+	/**
+	 * @syncobj_timeline_points: An array of timeline syncobj points defined to get the
+	 * fence wait points of every timeline syncobj handles in the syncobj_handles_array.
+	 */
+	__u64	syncobj_timeline_points;
 	/**
 	 * @bo_handles_array: An array of GEM BO handles defined to fetch the fence
 	 * wait information of every BO handles in the array.
-- 
2.34.1

