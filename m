Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AAB9DCF6497
	for <amd-gfx@archiver.kernel.org>; Mon, 30 Sep 2024 12:00:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 600E010E402;
	Mon, 30 Sep 2024 12:00:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="XLLfSwS3";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2081.outbound.protection.outlook.com [40.107.94.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BF92810E402
 for <amd-gfx@lists.freedesktop.org>; Mon, 30 Sep 2024 12:00:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ltIDUg/rfdy4daqG++IzIvlB70tkR5jpFmiU1zMZ6fd7zWQ/PiaSu5BM89Xhj4xr1Mpbx9zROO7UvMAI3qRZYndLaJZUNbihMbC7Aek4/yeXV7YoWndAFKmq7tZzXzNOeujjWa0S58cHYSU7ZANSSUcSGek1V3KQ2sw/9isRzrhpEvPtncnhlLx+ah2X2m+QFz6DBhMJ6RXftu0qshqNLcuYRXs0in3doaBpT5PbeQy8Fn0TtfTaN9PyabW5wHATyuTDubjMkVyzehtOCsbZqokgRZBQE5dmAJI39HXa2HPex96stKFIaZKcVTDl0ccZgffERMpMC0fTg4kBi0q8bg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dftaCYsK3zZAHUadxQX7/RDnxL4hSWNoyteB3zfOxdw=;
 b=UiBOX0XL27Jz3q/RQ7i4ZvL5Dwd09nvGJM7gtGBFsNK1tgwJzcusoy6L/v//KrK70WxiZI8aHcoeD8hN6cKbRPR1OzVV+rWNquGsymM7cmtlTXHUk/rsi7Yi4LJv2tOHvSX2eoLKek9IIJdpk8e+6ZQXgcdnKsnnfmJ8JbYyVkxGIJUjHUgHVIn0yuKbF6XwWzmBJY9V7yhnUd4mwEGypxeIcloqSmw09pLGQ/wMMbPTVJmHP1ph/WPOxWCQeUnjnDq2/7dIYA7KUWatR7HWUm8w6ZsCZjkoWMfl6xt47BJPnSPGNPaZgkCW/6iUPsvielDebu3P97C1lglTIjJ7rQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dftaCYsK3zZAHUadxQX7/RDnxL4hSWNoyteB3zfOxdw=;
 b=XLLfSwS3ELlyNF2glhyv3stsKEHgimM50bcx+bJeQ4o6mv0y1sFA0D2+HnL9utQCbGnFCb/OkZQpLkxtVQ1OsM4PGYoR7LmRihWe+TV5nLMfLF3dVGO50VfGvgZmM1HB1GVxatVJIi6MlhOXqxwkmuW+1rkNZrDU4/ByhiUT9ps=
Received: from SN6PR2101CA0027.namprd21.prod.outlook.com
 (2603:10b6:805:106::37) by MN0PR12MB6152.namprd12.prod.outlook.com
 (2603:10b6:208:3c4::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.26; Mon, 30 Sep
 2024 12:00:21 +0000
Received: from SA2PEPF000015C7.namprd03.prod.outlook.com
 (2603:10b6:805:106:cafe::91) by SN6PR2101CA0027.outlook.office365.com
 (2603:10b6:805:106::37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.1 via Frontend
 Transport; Mon, 30 Sep 2024 12:00:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF000015C7.mail.protection.outlook.com (10.167.241.197) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8026.11 via Frontend Transport; Mon, 30 Sep 2024 12:00:21 +0000
Received: from amd-X570-AORUS-ELITE.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 30 Sep 2024 07:00:19 -0500
From: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <christian.koenig@amd.com>, <alexander.deucher@amd.com>, "Arunpravin
 Paneer Selvam" <Arunpravin.PaneerSelvam@amd.com>
Subject: [PATCH v3 03/09] drm/amdgpu: Add wait IOCTL timeline syncobj support
Date: Mon, 30 Sep 2024 17:29:00 +0530
Message-ID: <20240930115906.191060-3-Arunpravin.PaneerSelvam@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240930115906.191060-1-Arunpravin.PaneerSelvam@amd.com>
References: <20240930115906.191060-1-Arunpravin.PaneerSelvam@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF000015C7:EE_|MN0PR12MB6152:EE_
X-MS-Office365-Filtering-Correlation-Id: ef56f9b7-8115-497f-53b2-08dce14775c3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?GA6OocgTwVzWWw4+6uL2d97wtiATHU3iXyWSWXwk0PBcE3K1K6EGhsrMFuO6?=
 =?us-ascii?Q?yvCeVngccAOyb/Pz7rlldfkyLHY27HucGWM48JlOdboAAGX8vxGmvk5sqsb3?=
 =?us-ascii?Q?xbuFX0Xw1USLGXzmA3tft+4+OQS+vS/06TlQBvA4oc7buwBt+xJprmk7WOyF?=
 =?us-ascii?Q?Qhb8Mb1AvUWz9B3TlXxLmyDwMXIFlXkJoSPGQKLGj1oLSkbY/H4aLR2tZ0Fx?=
 =?us-ascii?Q?N2NjTpan7n6x4odOqaOb94M13ZKe/lUZwTZmsexHABrXMMkt75hHgnAT1a1k?=
 =?us-ascii?Q?z0YBitLCy3BhnD1w2YjyAPb21wAdNH953D/HvK2pvge9GA+IDGgX4vc1AozH?=
 =?us-ascii?Q?qvKOiuBs2bKzMloTCgoe3iB5gYYwnItIEIxEfRhyilyco6M9K2eKQhOh/ql0?=
 =?us-ascii?Q?g8q7xOXqR3QPOOD51Gr9uJZZKd5h4/T0N3DR+/0b/gkyD1ny6YlarDahBcUa?=
 =?us-ascii?Q?bEN2y5LME/JJhx23EPfGfsqjJUDk7aX9+ao+e4pS3AQZUkerbLzfPal5qsx4?=
 =?us-ascii?Q?gFyFuRIoH5/obT1Fa/ZDOEQ/wFCOBZww39EXjPcZ29qn2MjxHohdIOs7TwVD?=
 =?us-ascii?Q?una0u9fEgnX5MAN43CndRmQjZWR6z6zr8Bw09MJjwHq6c5l3gyNlpqgRdmWb?=
 =?us-ascii?Q?F46EPw387zMHpbM/65eTtjStgemtgIlW0cFF5d+ZBIK8xuNgTZwQMsVdW5PD?=
 =?us-ascii?Q?n4nDWcc+z64rzHpEoGId2DfFn2cQL9XpPBcIpfjyLTCQfZG5QlQSt28/ktxb?=
 =?us-ascii?Q?HR3OvKMHMG7+urmuoPYry0AKD3ds5VYr44upPqgIPQxUkHtz+hf4OvcX+8W3?=
 =?us-ascii?Q?XBEzD1FWi1wjJMLstd5g7DTwRazV4fDzm454mgyk/5yclVyItiTdruoXqNr8?=
 =?us-ascii?Q?tAx3v6M7C5sWZNHDJsYvlku3/emtn+RdI9g3EYuNonS521lypivdABq6LpYd?=
 =?us-ascii?Q?hEvw2plzK2Os9fxu9jHZOidm3M0EXmoAzymUx004KgD5Z1QW55Am5ZmJSkxn?=
 =?us-ascii?Q?YqBZuzVGKRBd8pivnsF6EhC4jmqRu/Eaq2+imujDTvkS3TGsLEPs8kbkt7n7?=
 =?us-ascii?Q?dXRecRalZsP/GEbQd8GAyiFThVYXsf4WekEqRsk0LfxnOxpzc714VwZ2YeUp?=
 =?us-ascii?Q?HsjZwO9PPqY+i1sCd1fDNf8reKp9I0VE3AD33KxdvZ5NJS25FBA+EjDWVpOM?=
 =?us-ascii?Q?pX1Ysgvo0W6+7Odnxay7qx3LsV0UtFMSR4+7xrgkLyc0WQb2rW8Ii8WtN/2B?=
 =?us-ascii?Q?P/Z4cYy9lYMy9Hx6q/FjwRCjY/SAgBwoPU+DHBGoh1EwCs/ldzhd5iIiWOqz?=
 =?us-ascii?Q?L5JXJMYsNM2h+1SX8mnUQPrvQU5ekMaK3QHNcj01Yw+EaO0RbctkL+isDbjq?=
 =?us-ascii?Q?PDWnmRpzF8uTvvKF0VbciCuAto8K?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2024 12:00:21.3649 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ef56f9b7-8115-497f-53b2-08dce14775c3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF000015C7.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6152
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

Signed-off-by: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>
---
 .../gpu/drm/amd/amdgpu/amdgpu_userq_fence.c   | 99 +++++++++++++++++--
 include/uapi/drm/amdgpu_drm.h                 | 16 ++-
 2 files changed, 107 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
index 8f9d2427d380..76552eed6d86 100644
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
@@ -524,15 +540,40 @@ int amdgpu_userq_wait_ioctl(struct drm_device *dev, void *data,
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
+				num_fences++;
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
 
+			dma_fence_put(fence);
 			num_fences++;
 			dma_fence_put(fence);
 		}
@@ -588,12 +629,46 @@ int amdgpu_userq_wait_ioctl(struct drm_device *dev, void *data,
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
+				if (WARN_ON_ONCE(num_fences >= wait_info->num_fences)) {
+					r = -EINVAL;
+					goto free_fences;
+				}
+
+				fences[num_fences++] = fence;
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
 
@@ -616,9 +691,13 @@ int amdgpu_userq_wait_ioctl(struct drm_device *dev, void *data,
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
 
@@ -664,6 +743,8 @@ int amdgpu_userq_wait_ioctl(struct drm_device *dev, void *data,
 		drm_gem_object_put(gobj[i]);
 	kfree(gobj);
 
+	kfree(timeline_points);
+	kfree(timeline_handles);
 	kfree(syncobj_handles);
 	kfree(bo_handles);
 
@@ -681,6 +762,10 @@ int amdgpu_userq_wait_ioctl(struct drm_device *dev, void *data,
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

