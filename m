Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCD3BCAC597
	for <amd-gfx@archiver.kernel.org>; Mon, 15 Sep 2025 10:42:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7D3C110E443;
	Mon, 15 Sep 2025 10:42:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="KPVVWAEr";
	dkim-atps=neutral
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013004.outbound.protection.outlook.com
 [40.93.196.4])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DC28810E443
 for <amd-gfx@lists.freedesktop.org>; Mon, 15 Sep 2025 10:42:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=F0tiQf+cAWr0vy6lHAjGB0B04rB9M+FlPtruUtDZZqXngd799KiMWrYM+/kuK614jFGJLPJT4xXlpnU+lnrVGDweGB1OyqDHTG4tp4fpu2Z7mstRgR85Lso493XZX5U7dAHGVQeB8foHnFfd3KfuEoJDtcLYsSWUp7qAESOExL8QoPgkHwM5SPPVYtvwNodFUBHWYEcnhx0SYJCEu5xYB+QOEzPXJWanNfd5VYw5KsDL48WX8SXQmqawrheOov8y/FVLrbWW72UOS4bjyMIZLmFYwDLuD0FOhm+t6BrLUNCCu2IPeWQz1bgQ2GaCC3EjJhdNcU5hP6+FoHCpOwWcgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VjdGq8tjGWHIps/ou2jSjYxcdCn+q95QQfKdrGdrOlE=;
 b=ThenJbcHIbYL896Uy8+69Pk3qnbXJ+fz9BeLBm29u6SeS69zOLfWawstnoCHIeXCo/2fwchRPRrRCGogVEPz+9C1H4L4BwIDz6y3a4n8peibOPVWW1Eait8PguY4tCDOlwks4kzVNQx90mDYMEybvnDTTtz9mf+JUYBSeLLOX2Irbw9eUdwG3xl8DXkPe7KhzReAHnsOJ3jMwrBeTL5NdbGad7cswklliOsSgyJKKIYC0XG8UN+dRIw67FD5MGMPiihbDZ8WXywVPwD/rTbxpPq3eb9r0m7+OJBuNOT9xvEiIC11ANVPlpfgCzMmOWykdAoGp+6FHedg8h+LJoYesw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VjdGq8tjGWHIps/ou2jSjYxcdCn+q95QQfKdrGdrOlE=;
 b=KPVVWAErDupWt/qSwWWJcKrM4lOL/9tlawZOaaaZKzxme5qakGqjI8h9mJ+qcrIW/Y8RVo8Qy8H3X2i8GT5P0w422Dsz8Wi/h1UC1Okr4CgWyt/Wh77qT+Cmc7F+7aVmn93DwUu4R6dBzRtrqR0Jd1ohJGl64s5RUho3q3W10qo=
Received: from BN8PR15CA0012.namprd15.prod.outlook.com (2603:10b6:408:c0::25)
 by BN5PR12MB9511.namprd12.prod.outlook.com (2603:10b6:408:2a9::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.22; Mon, 15 Sep
 2025 10:42:17 +0000
Received: from BL6PEPF0001AB4D.namprd04.prod.outlook.com
 (2603:10b6:408:c0:cafe::6c) by BN8PR15CA0012.outlook.office365.com
 (2603:10b6:408:c0::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9115.20 via Frontend Transport; Mon,
 15 Sep 2025 10:42:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF0001AB4D.mail.protection.outlook.com (10.167.242.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9137.12 via Frontend Transport; Mon, 15 Sep 2025 10:42:17 +0000
Received: from work.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 15 Sep
 2025 03:42:12 -0700
From: David Rosca <david.rosca@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: David Rosca <david.rosca@amd.com>
Subject: [PATCH 1/2] drm/amdgpu/userq: Add syncobj_points to signal ioctl
Date: Mon, 15 Sep 2025 12:41:46 +0200
Message-ID: <20250915104146.11185-2-david.rosca@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB4D:EE_|BN5PR12MB9511:EE_
X-MS-Office365-Filtering-Correlation-Id: f2f4d79d-574e-493c-930b-08ddf4448a68
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?NjSW3AFtuwTNLYKK1mXdldRFjxmmqTtC2LQ3gOxzlBgKorSSpqyIQM7LOA2X?=
 =?us-ascii?Q?KL23/uGbV/qqiDL+6lqHRMR9y/XsBSalXGyUbo9EYJjA1wQNibShOp8hdQ1H?=
 =?us-ascii?Q?2ciGUoUXR2CXG68HZMhY/w3Az6VLM5iLRIIrVD/+QHG5aW0//lBu+AftQjWl?=
 =?us-ascii?Q?QlE6Yqd5DaoBzDOU7RHQBfd2q/gTd+oQM7pJoF5fJ3fBSZkbSWPm2od0Huwk?=
 =?us-ascii?Q?aijEKuOZYkiijaYBoAkT+cb82iX6HEIT8aYgwJNWL6ayv78QsR0vytP346QP?=
 =?us-ascii?Q?a2jtTp79eRy2S7V2edyUIjBi0WhbXgauGsJdsNp4nbCxvgV2avppdgfoSGc9?=
 =?us-ascii?Q?LDVEPOndMvCvdZShilzk03bGCCFJvuDph0QKDyRdPn4f0afSnsOOoWf8o2wi?=
 =?us-ascii?Q?FfvWu3jsX2UnPhMHGIPT8yvjk3yqG9QYbr0ZHpH5wy7R8rbI62BerVoiXlso?=
 =?us-ascii?Q?BjknhIetz//cLNC0d0XFL+aVSZrQF8yxJR32D9DMoKjwo0kwueHAk5PFKzai?=
 =?us-ascii?Q?w8L0ppSRpDqwNyPhBJj/OqlNqa+xcpSc7CiI+NTqBP4faZpBslF3ZA2bIh8F?=
 =?us-ascii?Q?e7PaOc/fOnTWd7Xjhzzj9BVzmvvlhrbYVLPjOuTpJPZydajdL0RqVbORX382?=
 =?us-ascii?Q?yEfOwr/sqZcFwSBzWHwxfsPSNm4rTZZ/LX5UhgoD6fZJZkLT5/hsMeO/xwRm?=
 =?us-ascii?Q?rFA9C+uqrmiCHhVnlGpbq32z3vmOD6vlmj+En6U/de1XpOa6Nj+tmwUbop4s?=
 =?us-ascii?Q?QFB7PtU0gA+iJ8g+E4LKSa/n1KIkR8J5kVT3RrsdMH4YL/iBXlr4xcO0mem3?=
 =?us-ascii?Q?GU7iD7NbXvKH53GY22s2AmqAJYeIroM9DwI3xnGDWSqghsoMLxj0s5T/ENFg?=
 =?us-ascii?Q?FXywFboXEiHh5fvW6bI/qDSoFcqB58ya0KV+59/4o3K0rw04zMROKomqPTW4?=
 =?us-ascii?Q?0mCXHfyu7RfOHL74XKEYaxClfuvOS7xKHIEWJoEntMtUpBz/58dHygJMFKei?=
 =?us-ascii?Q?mFhNwGOvmSsoe9Jhpg/1mBxqq0Y0Rthh2fs14F39Z04QP8WCJ6tRDRBmB4/k?=
 =?us-ascii?Q?3jq+AC555HkAqkUHC6rRfsmeF+JO8cT+GwxzQaepAW10IJzmWRsQSYpXfO/y?=
 =?us-ascii?Q?6ekPzcb9qVBcSiBvzB0Uu725F/wZ1KJb/j7g3HNeCSefPylZb+qYKYNWKZN5?=
 =?us-ascii?Q?efbmsmnQ/lpdswhPbNm9Xmb2DvoHOOB5zgXWBlO8xe+NpreEk277cGfODiS4?=
 =?us-ascii?Q?24Arx46M68Ji0CAUg6ntFIeIQn6P5giO5zn5R4iE7Vu+sacbz4U3gpc0fjyo?=
 =?us-ascii?Q?SWtFGkgtS7LUBa/c4wbD3BUllNRmiDgoWl0EOAyuuKioWiBVuqTK8jbzh4H2?=
 =?us-ascii?Q?dZaIhNqgQjmgnFsGLCwk8MX1UiyZwKYOCe3kQx3lf1+SqC0SoI/VHeg0TbV8?=
 =?us-ascii?Q?EmaATsTOb2oUndOxyd845C+SjFhutNU7UhSVkl70RhYQph9HCN+rcX6PHJX1?=
 =?us-ascii?Q?UI87P8q+34jMJnf1SyJSIVYfLv/Q9ibG1TpO?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2025 10:42:17.3105 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f2f4d79d-574e-493c-930b-08ddf4448a68
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB4D.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN5PR12MB9511
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

Signed-off-by: David Rosca <david.rosca@amd.com>
---
 .../gpu/drm/amd/amdgpu/amdgpu_userq_fence.c   | 49 +++++++++++++++----
 include/uapi/drm/amdgpu_drm.h                 |  5 ++
 2 files changed, 45 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
index 95e91d1dc58a..5b2cdc49a28c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
@@ -460,10 +460,11 @@ int amdgpu_userq_signal_ioctl(struct drm_device *dev, void *data,
 	struct drm_gem_object **gobj_read = NULL;
 	struct amdgpu_usermode_queue *queue;
 	struct amdgpu_userq_fence *userq_fence;
-	struct drm_syncobj **syncobj = NULL;
+	struct amdgpu_cs_post_dep *syncobj = NULL;
 	u32 *bo_handles_write, num_write_bo_handles;
 	u32 *syncobj_handles, num_syncobj_handles;
 	u32 *bo_handles_read, num_read_bo_handles;
+	u64 *syncobj_points = NULL;
 	int r, i, entry, rentry, wentry;
 	struct dma_fence *fence;
 	struct drm_exec exec;
@@ -475,19 +476,37 @@ int amdgpu_userq_signal_ioctl(struct drm_device *dev, void *data,
 	if (IS_ERR(syncobj_handles))
 		return PTR_ERR(syncobj_handles);
 
+	if (args->syncobj_points) {
+		syncobj_points = memdup_user(u64_to_user_ptr(args->syncobj_points),
+					     sizeof(u64) * num_syncobj_handles);
+		if (IS_ERR(syncobj_points)) {
+			r = PTR_ERR(syncobj_points);
+			goto free_syncobj_handles;
+		}
+	}
+
 	/* Array of pointers to the looked up syncobjs */
 	syncobj = kmalloc_array(num_syncobj_handles, sizeof(*syncobj), GFP_KERNEL);
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
 
 	num_read_bo_handles = args->num_bo_read_handles;
@@ -603,8 +622,15 @@ int amdgpu_userq_signal_ioctl(struct drm_device *dev, void *data,
 	}
 
 	/* Add the created fence to syncobj/BO's */
-	for (i = 0; i < num_syncobj_handles; i++)
-		drm_syncobj_replace_fence(syncobj[i], fence);
+	for (i = 0; i < num_syncobj_handles; i++) {
+		if (syncobj[i].chain) {
+			drm_syncobj_add_point(syncobj[i].syncobj, syncobj[i].chain,
+							      fence, syncobj[i].point);
+			syncobj[i].chain = NULL;
+		} else {
+			drm_syncobj_replace_fence(syncobj[i].syncobj, fence);
+		}
+	}
 
 	/* drop the reference acquired in fence creation function */
 	dma_fence_put(fence);
@@ -624,10 +650,15 @@ int amdgpu_userq_signal_ioctl(struct drm_device *dev, void *data,
 free_bo_handles_read:
 	kfree(bo_handles_read);
 free_syncobj:
-	while (entry-- > 0)
-		if (syncobj[entry])
-			drm_syncobj_put(syncobj[entry]);
+	while (entry-- > 0) {
+		if (syncobj[entry].syncobj)
+			drm_syncobj_put(syncobj[entry].syncobj);
+		if (syncobj[entry].chain)
+			dma_fence_chain_free(syncobj[entry].chain);
+	}
 	kfree(syncobj);
+free_syncobj_points:
+	kfree(syncobj_points);
 free_syncobj_handles:
 	kfree(syncobj_handles);
 
diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.h
index 85b3ca14f81e..197ea3bfb559 100644
--- a/include/uapi/drm/amdgpu_drm.h
+++ b/include/uapi/drm/amdgpu_drm.h
@@ -504,6 +504,11 @@ struct drm_amdgpu_userq_signal {
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

