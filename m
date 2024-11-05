Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC7B3D1CA2E
	for <amd-gfx@archiver.kernel.org>; Tue,  5 Nov 2024 05:56:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7B97010E517;
	Tue,  5 Nov 2024 05:56:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="nuMMHA70";
	dkim-atps=neutral
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2052.outbound.protection.outlook.com [40.107.95.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AA34110E517
 for <amd-gfx@lists.freedesktop.org>; Tue,  5 Nov 2024 05:56:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lc09FaSrsNq3cWRFiBgPqKiRf6QgGVYnb24RXjuU/vHcBpAHFKPbC/I6Vpx/U5QtyepXyNEgSMHXQgfhx602MJUZb1fmwBf3ywSHaA5IU1i3tvCNXaGDDwRH+2LSRQjDyCqIACW0uxk8/dXdyKnsXcptoAxkpIuKabhC2fj4q8iBcvTXWSlYMLDsQj9s0nxqgaiDjC8/siidBAHmDF4twThC5TeSWfC+hH3pOvDyrKglGGbgIbhxL8rx9eOI8rTHu5nYMMArHFEje0NiuNtiLD1sysrJMHRmjAIL+pGQ6gCGmXRx1x19X9W/7AJnHLbeizDU2n+JORqC/96rzm9XUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=61sT14o15JcFEF1fwJrQRhM1vkS/OLsmzV/utR7go+c=;
 b=aErbknyIoKoGLZlIWRBYw+V09Cjv2vEg3YsiPlp6sfGEk1uAK+iNmainEYQpOlgMOnUw51Gwi+JLyeRv0cs/YTDOiHPb27h0iXaSQBD1H63BZnCGkZkECQr8v53dpMKm5N/MvC1kREQxsPoPzKuLKDWTS9U/1TbX2zA9FdULC6g78yR7u5x8W6bBxDj80e0YQj5eVIgvinjGlSevhKil9/Icm1uWO2j+0LV5d41tIIsmlCv5PzXmeXAdlfkJAqpH+Yb2ACFEuz8KdaLJO8aZdq9xWw7IUYrBtGsSPppbYH6ncor8eiQkDXPkJo7GvOAziENiUIPg3FkZyb/k2m1lgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=61sT14o15JcFEF1fwJrQRhM1vkS/OLsmzV/utR7go+c=;
 b=nuMMHA70H8PKP/pl4if+D83zkdKjIHAZNutfNskYrmPDSQsFIxuVreYlEgA2h2CB5gy8qXi+teVrn7DLhMtGIiV+gPsc6tKGMu1wgVimrJaGEl9wcE3vHFwp3XX2G49IQG5SwILZb3qSwF952s6GH+Sn4B1xeaJEJX1UAd+wl/g=
Received: from MW2PR16CA0057.namprd16.prod.outlook.com (2603:10b6:907:1::34)
 by IA0PR12MB7721.namprd12.prod.outlook.com (2603:10b6:208:433::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.30; Tue, 5 Nov
 2024 05:56:49 +0000
Received: from CO1PEPF000075EF.namprd03.prod.outlook.com
 (2603:10b6:907:1:cafe::c7) by MW2PR16CA0057.outlook.office365.com
 (2603:10b6:907:1::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.29 via Frontend
 Transport; Tue, 5 Nov 2024 05:56:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000075EF.mail.protection.outlook.com (10.167.249.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8137.17 via Frontend Transport; Tue, 5 Nov 2024 05:56:48 +0000
Received: from amd-X570-AORUS-ELITE.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 4 Nov 2024 23:56:46 -0600
From: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>
CC: <alexander.deucher@amd.com>, Arunpravin Paneer Selvam
 <Arunpravin.PaneerSelvam@amd.com>
Subject: [PATCH] drm/amdgpu: Modify userq signal/wait struct field names
Date: Tue, 5 Nov 2024 11:26:21 +0530
Message-ID: <20241105055621.865848-1-Arunpravin.PaneerSelvam@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000075EF:EE_|IA0PR12MB7721:EE_
X-MS-Office365-Filtering-Correlation-Id: af1ae42a-f697-4c98-8041-08dcfd5ea31e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?tsUScStCxmsEeRQoo1VEoNmQ/SsGmEtAddqkmPeq+eCbfPDEBnV5WUAmHEOI?=
 =?us-ascii?Q?EQOCd7I3hbl6j8nCZCpMyvlK+n5vUQ+dIB4+vL0EePjtqVokG3WwDafKgny3?=
 =?us-ascii?Q?nOpSDlUuF8XNJIM5kE0bzeFO6rFNZ4cSUYWPg0Unfg/zzL3e8YLjghcOjcH1?=
 =?us-ascii?Q?rUzjebd0nWu+XiyGVEfp1skwVXiPWo1O+11BrfBqhz0qgcfGuAzabIpUfGWt?=
 =?us-ascii?Q?0W4skhwQ0DcvkGA3QHkzl/dMsvYPz7VfF7fLXPGmR3MiPdvJw9DBfaTAlkNW?=
 =?us-ascii?Q?YkMSVhWdB5bd0yjBuBmaBMKn8X6orRQiC8ATDxabZpcpvx41IyZEfeLegILe?=
 =?us-ascii?Q?//nFsPuporPscb3jWzLwzgwgvQLjtgTvuz8/YPw8dHRIcVQaGBW2b8HkV4eT?=
 =?us-ascii?Q?dcGYQWM9j4mr1NQ/poZ9sIg9NL2jZRN1bh+1KIIe4xCgwVzY3GxIjErKGAYf?=
 =?us-ascii?Q?c2xWsVd+YYgPBH2AOIgs0TzuWN55+YGBhAwZ0C6+SWvE+I/PffexEn4GB8PP?=
 =?us-ascii?Q?lUkeTrV+3NpO8OejgicBFrS4brTzGaa/XG2bmovu7tzsf0pCQbvGXzHZkViB?=
 =?us-ascii?Q?um+TNG2Ju5vpiQ45Ke4Py+OI5qeWY5vnTQC1G2gHjRpJiguUVLot6ckxT7gr?=
 =?us-ascii?Q?s/wyNCj65SrJEy4q5FSoGU6lC+jEobUa8+hdQcuCR76ghxlp/y1T4yU2pzbO?=
 =?us-ascii?Q?ZZT4NaCw6BBUcLSqbPpWSpnoy/1vUJQPZiwSX+GU0H2ZEyQx1pMnciY5Ia6a?=
 =?us-ascii?Q?Lj2t0+uOVyBKtwmWdiqGo04oSG3XlDewOm3C+o1MVP8w9EYNwKKpzfoXYAJe?=
 =?us-ascii?Q?goh7oAvKU56CXl4VrYvaEGj86QGzcz8HQtZrUmSlqJq8Rdl2MR6ucIXYzpiJ?=
 =?us-ascii?Q?yHP+Rya8wEQFth9vHeGyos9nSZlqIJq7965YCiFwWI0zrJXAh1awi5F45HpM?=
 =?us-ascii?Q?JKK0vllk/wAsHtZ2wBA6l6LYniR8roioFfzA/Dqvai6IVfepYJw/m1GOV+Fu?=
 =?us-ascii?Q?V18hCHAc0V8InahvZBzJxmfrMZ3WsgB781h0ysgG/1FCGXRQgR3okzTMGZq4?=
 =?us-ascii?Q?+uCsFycIrZCl/IjlD8XR1gASp3X0/7LPS7ccNSoDdUMFNkWqpP4h0AY2PovS?=
 =?us-ascii?Q?AjvYUpgYYZvhkxG2EjckKhBAYXv7SxprAswZGAAnnR512mlkaBv+VIyXqLYo?=
 =?us-ascii?Q?llx+kltLmDQwlOg5cpFSkwdY0gX3Ju7g4A+PD/xVOI8z45Hjhz51feHIDVnt?=
 =?us-ascii?Q?JX2mWKLqzjf5J7RFo2fJEzt4NTmxUjEi05aq3BOCNacfryIldziGKeaKdYkR?=
 =?us-ascii?Q?cKmVCZfNfaNiqUFEjEBVJ7h2doBVgb2nR6RUxX6qWWkIDMP+BxjhvErjegAz?=
 =?us-ascii?Q?NE+C3/w=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2024 05:56:48.3487 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: af1ae42a-f697-4c98-8041-08dcfd5ea31e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000075EF.namprd03.prod.outlook.com
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

Modify kernel UAPI userq signal/wait struct field names and
description corresponding to the libdrm UAPI review comments.

libdrm MR: https://gitlab.freedesktop.org/mesa/drm/-/merge_requests/392

Signed-off-by: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>
---
 .../gpu/drm/amd/amdgpu/amdgpu_userq_fence.c   | 20 ++--
 include/uapi/drm/amdgpu_drm.h                 | 98 +++++++------------
 2 files changed, 46 insertions(+), 72 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
index 87183f086706..4d232c54840d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
@@ -400,7 +400,7 @@ int amdgpu_userq_signal_ioctl(struct drm_device *dev, void *data,
 	u64 wptr;
 
 	num_syncobj_handles = args->num_syncobj_handles;
-	syncobj_handles = memdup_user(u64_to_user_ptr(args->syncobj_handles_array),
+	syncobj_handles = memdup_user(u64_to_user_ptr(args->syncobj_handles),
 				      sizeof(u32) * num_syncobj_handles);
 	if (IS_ERR(syncobj_handles))
 		return PTR_ERR(syncobj_handles);
@@ -420,7 +420,7 @@ int amdgpu_userq_signal_ioctl(struct drm_device *dev, void *data,
 		}
 	}
 
-	num_read_bo_handles = args->num_read_bo_handles;
+	num_read_bo_handles = args->num_bo_read_handles;
 	bo_handles_read = memdup_user(u64_to_user_ptr(args->bo_read_handles),
 				      sizeof(u32) * num_read_bo_handles);
 	if (IS_ERR(bo_handles_read))
@@ -441,7 +441,7 @@ int amdgpu_userq_signal_ioctl(struct drm_device *dev, void *data,
 		}
 	}
 
-	num_write_bo_handles = args->num_write_bo_handles;
+	num_write_bo_handles = args->num_bo_write_handles;
 	bo_handles_write = memdup_user(u64_to_user_ptr(args->bo_write_handles),
 				       sizeof(u32) * num_write_bo_handles);
 	if (IS_ERR(bo_handles_write))
@@ -558,37 +558,37 @@ int amdgpu_userq_wait_ioctl(struct drm_device *dev, void *data,
 			    struct drm_file *filp)
 {
 	u32 *syncobj_handles, *timeline_points, *timeline_handles, *bo_handles_read, *bo_handles_write;
-	u32 num_syncobj, num_read_bo_handles, num_write_bo_handles, num_points;
+	u32 num_syncobj, num_read_bo_handles, num_write_bo_handles;
 	struct drm_amdgpu_userq_fence_info *fence_info = NULL;
 	struct drm_amdgpu_userq_wait *wait_info = data;
 	struct drm_gem_object **gobj_write;
 	struct drm_gem_object **gobj_read;
 	struct dma_fence **fences = NULL;
+	u16 num_points, num_fences = 0;
 	int r, i, rentry, wentry, cnt;
 	struct drm_exec exec;
-	u64 num_fences = 0;
 
-	num_read_bo_handles = wait_info->num_read_bo_handles;
+	num_read_bo_handles = wait_info->num_bo_read_handles;
 	bo_handles_read = memdup_user(u64_to_user_ptr(wait_info->bo_read_handles),
 				      sizeof(u32) * num_read_bo_handles);
 	if (IS_ERR(bo_handles_read))
 		return PTR_ERR(bo_handles_read);
 
-	num_write_bo_handles = wait_info->num_write_bo_handles;
+	num_write_bo_handles = wait_info->num_bo_write_handles;
 	bo_handles_write = memdup_user(u64_to_user_ptr(wait_info->bo_write_handles),
 				       sizeof(u32) * num_write_bo_handles);
 	if (IS_ERR(bo_handles_write))
 		goto free_bo_handles_read;
 
 	num_syncobj = wait_info->num_syncobj_handles;
-	syncobj_handles = memdup_user(u64_to_user_ptr(wait_info->syncobj_handles_array),
+	syncobj_handles = memdup_user(u64_to_user_ptr(wait_info->syncobj_handles),
 				      sizeof(u32) * num_syncobj);
 	if (IS_ERR(syncobj_handles)) {
 		r = PTR_ERR(syncobj_handles);
 		goto free_bo_handles_write;
 	}
 
-	num_points = wait_info->num_points;
+	num_points = wait_info->num_syncobj_timeline_handles;
 	timeline_handles = memdup_user(u64_to_user_ptr(wait_info->syncobj_timeline_handles),
 				       sizeof(u32) * num_points);
 	if (IS_ERR(timeline_handles)) {
@@ -856,7 +856,7 @@ int amdgpu_userq_wait_ioctl(struct drm_device *dev, void *data,
 
 		wait_info->num_fences = cnt;
 		/* Copy userq fence info to user space */
-		if (copy_to_user(u64_to_user_ptr(wait_info->userq_fence_info),
+		if (copy_to_user(u64_to_user_ptr(wait_info->out_fences),
 				 fence_info, wait_info->num_fences * sizeof(*fence_info))) {
 			r = -EFAULT;
 			goto free_fences;
diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.h
index d63a2584f017..1ad4ae06eb04 100644
--- a/include/uapi/drm/amdgpu_drm.h
+++ b/include/uapi/drm/amdgpu_drm.h
@@ -450,25 +450,19 @@ struct drm_amdgpu_userq_signal {
 	 * to retrieve the WPTR.
 	 */
 	__u32	queue_id;
+	__u32	pad;
 	/**
-	 * @flags: flags to indicate special function for userq fence creation.
-	 * Unused for now.
-	 */
-	__u32	flags;
-	/**
-	 * @syncobj_handles_array: An array of syncobj handles used by the userq fence
-	 * creation IOCTL to install the created dma_fence object which can be
-	 * utilized by userspace to explicitly synchronize GPU commands.
+	 * @syncobj_handles: The list of syncobj handles submitted by the user queue
+	 * job to be signaled.
 	 */
-	__u64	syncobj_handles_array;
+	__u64	syncobj_handles;
 	/**
 	 * @num_syncobj_handles: A count that represents the number of syncobj handles in
-	 * @syncobj_handles_array.
+	 * @syncobj_handles.
 	 */
 	__u64	num_syncobj_handles;
 	/**
 	 * @syncobj_point: A given point on the timeline to be signaled.
-	 * Unused for now.
 	 */
 	__u64	syncobj_point;
 	/**
@@ -482,20 +476,15 @@ struct drm_amdgpu_userq_signal {
 	 */
 	__u64	bo_write_handles;
 	/**
-	 * @num_read_bo_handles: A count that represents the number of read BO handles in
+	 * @num_bo_read_handles: A count that represents the number of read BO handles in
 	 * @bo_read_handles.
 	 */
-	__u32	num_read_bo_handles;
+	__u32	num_bo_read_handles;
 	/**
-	 * @num_write_bo_handles: A count that represents the number of write BO handles in
+	 * @num_bo_write_handles: A count that represents the number of write BO handles in
 	 * @bo_write_handles.
 	 */
-	__u32	num_write_bo_handles;
-	/**
-	 * @bo_flags: flags to indicate BOs synchronize for READ or WRITE
-	 */
-	__u32	bo_flags;
-	__u32	pad;
+	__u32	num_bo_write_handles;
 };
 
 struct drm_amdgpu_userq_fence_info {
@@ -514,38 +503,18 @@ struct drm_amdgpu_userq_fence_info {
 
 struct drm_amdgpu_userq_wait {
 	/**
-	 * @waitq_id: Queue handle used to retrieve the queue information to store
-	 * the fence driver references in the wait user queue structure.
-	 */
-	__u32	waitq_id;
-	/**
-	 * @flags: flags to specify special function for userq wait information.
-	 * Unused for now.
-	 */
-	__u32	flags;
-	/**
-	 * @bo_wait_flags: flags to define the BOs for READ or WRITE to store the
-	 * matching fence wait info pair in @userq_fence_info.
-	 */
-	__u32	bo_wait_flags;
-	/**
-	 * @num_points: A count that represents the number of timeline syncobj handles in
-	 * syncobj_handles_array.
-	 */
-	__u32	num_points;
-	/**
-	 * @syncobj_handles_array: An array of syncobj handles defined to get the
-	 * fence wait information of every syncobj handles in the array.
+	 * @syncobj_handles: The list of syncobj handles submitted by the user queue
+	 * job to get the va/value pairs.
 	 */
-	__u64	syncobj_handles_array;
+	__u64	syncobj_handles;
 	/**
-	 * @syncobj_timeline_handles: An array of timeline syncobj handles defined to get the
-	 * fence wait information of every timeline syncobj handles in the array.
+	 * @syncobj_timeline_handles: The list of timeline syncobj handles submitted by
+	 * the user queue job to get the va/value pairs at given @syncobj_timeline_points.
 	 */
-	__u64   syncobj_timeline_handles;
+	__u64	syncobj_timeline_handles;
 	/**
-	 * @syncobj_timeline_points: An array of timeline syncobj points defined to get the
-	 * fence wait points of every timeline syncobj handles in the syncobj_handles_array.
+	 * @syncobj_timeline_points: The list of timeline syncobj points submitted by the
+	 * user queue job for the corresponding @syncobj_timeline_handles.
 	 */
 	__u64	syncobj_timeline_points;
 	/**
@@ -558,32 +527,37 @@ struct drm_amdgpu_userq_wait {
 	 * job to get the va/value pairs.
 	 */
 	__u64	bo_write_handles;
+	/**
+	 * @num_syncobj_timeline_handles: A count that represents the number of timeline
+	 * syncobj handles in @syncobj_timeline_handles.
+	 */
+	__u16	num_syncobj_timeline_handles;
+	/**
+	 * @num_fences: This field can be used both as input and output. As input it defines
+	 * the maximum number of fences that can be returned and as output it will specify
+	 * how many fences were actually returned from the ioctl.
+	 */
+	__u16	num_fences;
 	/**
 	 * @num_syncobj_handles: A count that represents the number of syncobj handles in
-	 * @syncobj_handles_array.
+	 * @syncobj_handles.
 	 */
 	__u32	num_syncobj_handles;
 	/**
-	 * @num_read_bo_handles: A count that represents the number of read BO handles in
+	 * @num_bo_read_handles: A count that represents the number of read BO handles in
 	 * @bo_read_handles.
 	 */
-	__u32	num_read_bo_handles;
+	__u32	num_bo_read_handles;
 	/**
-	 * @num_write_bo_handles: A count that represents the number of write BO handles in
+	 * @num_bo_write_handles: A count that represents the number of write BO handles in
 	 * @bo_write_handles.
 	 */
-	__u32	num_write_bo_handles;
-	__u32	pad;
-	/**
-	 * @userq_fence_info: An array of fence information (va and value) pair of each
-	 * objects stored in @syncobj_handles_array and @bo_handles_array.
-	 */
-	__u64	userq_fence_info;
+	__u32	num_bo_write_handles;
 	/**
-	 * @num_fences: A count that represents the number of actual fences installed in
-	 * each syncobj and bo handles.
+	 * @out_fences: The field is a return value from the ioctl containing the list of
+	 * address/value pairs to wait for.
 	 */
-	__u64	num_fences;
+	__u64	out_fences;
 };
 
 /* vm ioctl */
-- 
2.34.1

