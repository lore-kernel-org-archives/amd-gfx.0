Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9B00CCF9EE
	for <amd-gfx@archiver.kernel.org>; Wed, 25 Sep 2024 20:00:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6A89E10E85B;
	Wed, 25 Sep 2024 20:00:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="IaK50nDA";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2070.outbound.protection.outlook.com [40.107.244.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 21D6210E855
 for <amd-gfx@lists.freedesktop.org>; Wed, 25 Sep 2024 20:00:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kZf9rWg6Xx8+8upwG/oxQOaBXUuzc1fwBAWrGr02FQRRnyTXWG/luJY2C2tL/Sm8BNOEaFbyJsJZeFepMidI4ldyLy8/MnXkLw4U5tAbyt/TjrEAxOoIUbulw3P4YA9XOP3Z81yko3OlmxeN2cH9r6qzovYWVdQmoyc63Vu4VACXLfNfuWCkBUdSu5p+01JXWyOUdBeh5Fx/Z/9T73ijdv3ndrUzRMYIPcvU54sS0xsO5UbUSXG0d+DG1u6pWSsT5LHZI2Qx0pArOSnn0mV6IrbB2o74f+pmw1Ned9vGtkULI+Y8dZ2TjTHHdAT1R30w4DdFPC06aRnkCgaCMyxusg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HXCFo+rr71NjMIC+Vbh+PwTJ1xerZDUzDj0zU0+dMOk=;
 b=vqRUBBKCulM+Fhi2Xu/A2VxjPJRAxCdz/DluZEJsZl/4XRJzlMv2HPwyrvnCZ6k/U6ugXCbP3hjD9fOEpza8uXmfY5tQ1+mEuJYSlmAMqJ+SjdG0sBnmJA+3terPHOG0pnCeLtxVVhZpMTMl6QjxgpjaCvzkH1KJtSdfHG5XxRMDaIDTTJbJPOw79d9yQEf52qz4uaVFPrXJTyU4qznN2q8q9/F8GqOTR6SUgD1i/E0dFNsS5h5sqADMvwMhEn1muvDuWBdiOuPUAgIFZA9qO+ca+MkNNRHB2w6XIntT9l2v724aKIpmnQFAPKuRW+GUx4r7S90hw3sScUOB6Ti1zQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HXCFo+rr71NjMIC+Vbh+PwTJ1xerZDUzDj0zU0+dMOk=;
 b=IaK50nDApJj42wCCt5SY5Vuzzj5fxyency4Kh5t7qaXX5rvOiUjH+UipHq8IpV9MH1vsG1g5DKqpljxgzh8UFs/E7v+dG4htyFGnEYRXtVm8AG7uEdOItluMfxFHscjRx3VcS7ry0Fx3RPPFS5RzkQj/204PGR6DJgVe6G6euqc=
Received: from SJ0PR03CA0191.namprd03.prod.outlook.com (2603:10b6:a03:2ef::16)
 by DS0PR12MB7778.namprd12.prod.outlook.com (2603:10b6:8:151::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.26; Wed, 25 Sep
 2024 20:00:06 +0000
Received: from SJ1PEPF00001CDF.namprd05.prod.outlook.com
 (2603:10b6:a03:2ef:cafe::84) by SJ0PR03CA0191.outlook.office365.com
 (2603:10b6:a03:2ef::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.16 via Frontend
 Transport; Wed, 25 Sep 2024 20:00:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00001CDF.mail.protection.outlook.com (10.167.242.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8005.15 via Frontend Transport; Wed, 25 Sep 2024 20:00:06 +0000
Received: from amd-X570-AORUS-ELITE.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 25 Sep 2024 15:00:03 -0500
From: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <christian.koenig@amd.com>, <alexander.deucher@amd.com>, "Arunpravin
 Paneer Selvam" <Arunpravin.PaneerSelvam@amd.com>
Subject: [PATCH v2 03/08] drm/amdgpu: Add wait IOCTL timeline syncobj support
Date: Thu, 26 Sep 2024 01:29:23 +0530
Message-ID: <20240925195928.142001-3-Arunpravin.PaneerSelvam@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240925195928.142001-1-Arunpravin.PaneerSelvam@amd.com>
References: <20240925195928.142001-1-Arunpravin.PaneerSelvam@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CDF:EE_|DS0PR12MB7778:EE_
X-MS-Office365-Filtering-Correlation-Id: 382e8862-2cca-4fd5-78cb-08dcdd9ca6ea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?HLrFSnUrixmkGxsK2vwAQB3FYk1MKRA91+3z14V6BD8yfDIUpcPnX+MGoHnT?=
 =?us-ascii?Q?yeQ+lSwGDSTiJ7NFE0AapIOP8ACsklfYg3H1kRwOOpTyfb6FDGlxdKjvz6p2?=
 =?us-ascii?Q?SU0q/eBNZMIelKg3uGg0GZctM+2uEjtEAY2nLbyE7vcaSmZDYKK3abk830+G?=
 =?us-ascii?Q?CQYxscOkM1Us0d/dt+tZ8zKM3ZfO3n/wd82eSkQZEr+buy/6zjIJadcSrYPb?=
 =?us-ascii?Q?KXAZHj5Ay1on5zsWTOQqakB5F18q3XvJCJjN7Fv7H9AIFmecot0EiFX0j6oC?=
 =?us-ascii?Q?P1fRmeLo2Zuue/ceYtyysyk2Ien20VS8ALWWmGzIDx8Efp90zY7R/BBxmJCP?=
 =?us-ascii?Q?cHox6s3tR1SqczYFpsilUPA4csK/ICC28lTQIwZbbCC0c5jor+KNidWIMajF?=
 =?us-ascii?Q?QSmnH0IdECWYo/fLlrg+fQL2cA5mIFPytP7pI2I2yCi25g4+lP6ltwu8oaKE?=
 =?us-ascii?Q?y7ewTEDUqKGb1Z0VZuL4faA8UybFURzuRYcwah7XIC/hCmFgsuzz+3qvIuYV?=
 =?us-ascii?Q?y4cw4RT0WMIIGmhvX0PD7dKk5/PRz0cVUztuXKEVJHO9Yn3vUQaD/gA7eLji?=
 =?us-ascii?Q?14Vwz0Z7IEFMF48D+w6unN0LtZFrB8IGCDO99vpk46i2zMSgaAEhfwDmVfd4?=
 =?us-ascii?Q?HcpamkqwSfWg9CjJpAgQ6MVwpwno7TewKuFcFyIoPURerQW8esTyCeqksJUq?=
 =?us-ascii?Q?Tku5eV5ENUS9f21Zbt7pqVwukT4JtClD8OjzKifmb12ZZIUovD7PQXhhI/RK?=
 =?us-ascii?Q?MPId5/uYyLsHYKUBXTIILGXxmVzQJSvAsDNMRMJtXNulbzze74RGQc4BrJjz?=
 =?us-ascii?Q?0Dha8OUm70c6msGRCMNz73siiPeY0yW5xy32+IOrztDPvw5jNmZOP4UBfgjs?=
 =?us-ascii?Q?yCvLoKZ3VvVxbBe6W352wNW6EAUnW8qN1xFkF1xaA0H69DgMUjA3QXzyy8ij?=
 =?us-ascii?Q?UmImJYwVf8c8cqv8D9gMrzxEVcTfnJF3eXkk1OqOUkOhmdJUvs9nyv1eIOnn?=
 =?us-ascii?Q?QKVKgpdOEufCQc/bJ3GP5uRq9aYLoMqlJZoSLRrgw5uvXyxGa7aFFMo4o+Sw?=
 =?us-ascii?Q?4BOAlqAI7TkZBEiyZq+vr3q+8dlVhTeGsAATGYGL82/5t998+Z3dMkgCU4ms?=
 =?us-ascii?Q?++F9AIun0tuWrfON60VO9pwwVnNv7UJPRtpZ6J83VaVcbS66//1CfzQ28UT+?=
 =?us-ascii?Q?aKNnc8Ww8XaN2ZjWqQqGZc7rezDFNKJpExw8UVWF5wdwaOcJq2+9A2KlKuSS?=
 =?us-ascii?Q?Mz+1tmvChqUyAaIJ+zPcO28IbK7hxGBbwxYEFz6tDTmMA6U7C1tMIW1WbbvW?=
 =?us-ascii?Q?omIKYXADN5HkCvO0hf1kC0FzG2LnILelTavaTQvdaPUfhd1PN6vDd/RuX/PB?=
 =?us-ascii?Q?lJeZH8IVD9nZd3NWl9DcGw7THOSc?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2024 20:00:06.3382 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 382e8862-2cca-4fd5-78cb-08dcdd9ca6ea
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00001CDF.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7778
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

Signed-off-by: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>
---
 .../gpu/drm/amd/amdgpu/amdgpu_userq_fence.c   | 82 +++++++++++++++++--
 include/uapi/drm/amdgpu_drm.h                 | 16 +++-
 2 files changed, 88 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
index 97b1af574407..2465ca307644 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
@@ -474,11 +474,11 @@ int amdgpu_userq_signal_ioctl(struct drm_device *dev, void *data,
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
@@ -498,11 +498,26 @@ int amdgpu_userq_wait_ioctl(struct drm_device *dev, void *data,
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
@@ -524,17 +539,34 @@ int amdgpu_userq_wait_ioctl(struct drm_device *dev, void *data,
 	}
 
 	if (!wait_info->num_fences) {
+		if (num_points) {
+			struct dma_fence *fence;
+
+			for (i = 0; i < num_points; i++) {
+				r = drm_syncobj_find_fence(filp, timeline_handles[i],
+							   timeline_points[i],
+							   DRM_SYNCOBJ_WAIT_FLAGS_WAIT_FOR_SUBMIT,
+							   &fence);
+				if (r || !fence)
+					continue;
+
+				dma_fence_put(fence);
+				num_fences++;
+			}
+		}
+
 		/* Count syncobj's fence */
 		for (i = 0; i < num_syncobj; i++) {
 			struct dma_fence *fence;
 
 			r = drm_syncobj_find_fence(filp, syncobj_handles[i],
-						   0, 0, &fence);
-			dma_fence_put(fence);
-
+						   0,
+						   DRM_SYNCOBJ_WAIT_FLAGS_WAIT_FOR_SUBMIT,
+						   &fence);
 			if (r || !fence)
 				continue;
 
+			dma_fence_put(fence);
 			num_fences++;
 		}
 
@@ -589,12 +621,34 @@ int amdgpu_userq_wait_ioctl(struct drm_device *dev, void *data,
 			}
 		}
 
+		if (num_points) {
+			struct dma_fence *fence;
+
+			for (i = 0; i < num_points; i++) {
+				r = drm_syncobj_find_fence(filp, timeline_handles[i],
+							   timeline_points[i],
+							   DRM_SYNCOBJ_WAIT_FLAGS_WAIT_FOR_SUBMIT,
+							   &fence);
+				if (r || !fence)
+					continue;
+
+				if (WARN_ON_ONCE(num_fences >= wait_info->num_fences)) {
+					r = -EINVAL;
+					goto free_fences;
+				}
+
+				fences[num_fences++] = fence;
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
 			if (r || !fence)
 				continue;
 
@@ -617,9 +671,13 @@ int amdgpu_userq_wait_ioctl(struct drm_device *dev, void *data,
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
 
@@ -665,6 +723,8 @@ int amdgpu_userq_wait_ioctl(struct drm_device *dev, void *data,
 		drm_gem_object_put(gobj[i]);
 	kfree(gobj);
 
+	kfree(timeline_points);
+	kfree(timeline_handles);
 	kfree(syncobj_handles);
 	kfree(bo_handles);
 
@@ -682,6 +742,10 @@ int amdgpu_userq_wait_ioctl(struct drm_device *dev, void *data,
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

