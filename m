Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1136C3DA4A
	for <amd-gfx@archiver.kernel.org>; Mon, 14 Apr 2025 19:21:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D987E10E2FB;
	Mon, 14 Apr 2025 19:20:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Fi3SShpp";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2058.outbound.protection.outlook.com [40.107.223.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C4B7710E2DC
 for <amd-gfx@lists.freedesktop.org>; Mon, 14 Apr 2025 19:20:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FHtifOEKv8aaOOEk+ivbpWE04N9T+HJsa0Sw2Wh3kzWEjwN0S7MLr9hqDjo6YCaTTb/29tlvnAfs+xw1vhuW5jOjJaMu9RMJZZqGQJKr1Uhh+5rektGvUJyPTQ7MDEhJsmKXPWjK0vHUHleh3Iv9W6bOfiuVvdtD0ae+XYyBN5BfH9fEuh2SNArSUoYPmIJ0xLX/1awjHyuFe3jSjku4o7WngFjlYA2cK+zBRR2vCdoIdIkNzNH3UVF2NPLbfwlsJD6afWZ3aTWjXNLtdD7OOuRGDyJKWrW5cEuWQ9gEtdoxUdXhsVKLrZd2zJ/a5PzsfbOhfS7EOOQCdW+Dm5IO1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VeCYdE9cMLiaG0R/taQlmtMJC0qHqvSsL3RF+taDNyE=;
 b=yhNi7sA1Cfp8n2z1L4+37BbEVJpaNkn1qpFg92DTXVi0fm9lBdoqoFyejgx16ytw7qK4eO/rUejPcrEpjaclRnD4N4YwyE9Nw2wnxZpSjrnei6trIxb0I2eN6AgnEd7RpzjzTBWfjEGOdUb1dFU0qtNA551X0RpEvHgK9LRyyqnpi0Jqa8ONwJelnWUAJxFQn3gAJ9U/9b0tN3AoXpKYoshUGwZPhvqaKYmDZ0/nFTgPx3/KaJygX8ysNq01l1MfrVN3Zw1ab9yd7bVYPIX3MNQG72kEwn9qi/l00d8hd0WEXa/cgWgAbxPkN9rMU4U7Sa7O4h5ZchnnoncTszB/ZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VeCYdE9cMLiaG0R/taQlmtMJC0qHqvSsL3RF+taDNyE=;
 b=Fi3SShpp/p9tlT4yCSQUSfldnoDoRb8oITmpaPGThp5KuClhPe+aumktzoGrrOIAZNskTLdmhdXAN0PMHD5Ptyo0I1N9Drzf/Y8fmo07jdVWhp42uycLU7/fZiEMkRx0GFnao93W5xnl5p9fWpCD6vepPOFF4IB5Lc9JuZ2NYsk=
Received: from CH2PR15CA0005.namprd15.prod.outlook.com (2603:10b6:610:51::15)
 by SA1PR12MB6970.namprd12.prod.outlook.com (2603:10b6:806:24d::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.31; Mon, 14 Apr
 2025 19:20:44 +0000
Received: from DS3PEPF000099DC.namprd04.prod.outlook.com
 (2603:10b6:610:51:cafe::14) by CH2PR15CA0005.outlook.office365.com
 (2603:10b6:610:51::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8632.33 via Frontend Transport; Mon,
 14 Apr 2025 19:20:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099DC.mail.protection.outlook.com (10.167.17.198) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8655.12 via Frontend Transport; Mon, 14 Apr 2025 19:20:43 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 14 Apr
 2025 14:20:41 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>, Sunil Khatri
 <sunil.khatri@amd.com>
Subject: [PATCH V3 2/4] drm/amdgpu/userq: add helpers to start/stop scheduling
Date: Mon, 14 Apr 2025 15:20:26 -0400
Message-ID: <20250414192028.3113100-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250414192028.3113100-1-alexander.deucher@amd.com>
References: <20250414192028.3113100-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099DC:EE_|SA1PR12MB6970:EE_
X-MS-Office365-Filtering-Correlation-Id: 2210a244-2009-4875-130b-08dd7b8973a0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?H+ksGgt6wGSDl7RowHlPKVcxuaXGdN5AtijuNphznXjoqq4K+FAIZ9Z/wseG?=
 =?us-ascii?Q?9XON9gf+1rKfSu0j48K33hygHKCzj0hFMc296qukajV3ws3yuDBNjxxESdo3?=
 =?us-ascii?Q?r1eUEN4Vv9WB+RizPI1BvhxkNFyFrLysB+uzKJqWhzj2GPtAxQ7d74Pxla90?=
 =?us-ascii?Q?BJaArEFhebpysEd0eDKIA7mj3nBgpEtXhQQBxJv3CuZpqyOWME9sC2N/QpLH?=
 =?us-ascii?Q?n/ke3Xi268b8Z0Vkk7FXeZgHn0YS2ahxw6aYcWaOs879mhijobdkzF11yj2s?=
 =?us-ascii?Q?YSwJgGSHE9D/tQCjSFjZcZEmBGFx3xstNc3xdrst81nn/DBoZFrh9bPzJDNH?=
 =?us-ascii?Q?jB7/bzL3DBe+cyEe7S3vvDWLg2mBUc0rIfEasMbzplTq0noxl+C6mFOVU3lN?=
 =?us-ascii?Q?1TUC33CWDZ3UgiVTRmTrKq6dAx9SOq5bIXHIg379pIJ1J/dhA1G/YdLcAdlg?=
 =?us-ascii?Q?HA1dA5WYA2i1/TIlzMx0lzKA6d/uKQgYlppuCZ/64qrnTVfLfHYi3tE/gxnn?=
 =?us-ascii?Q?lneS8mWIJWX1hNMKgY5lfUqRFEEKzTKcY08yRbodCkMS7SSeJjoqE9FB7XnP?=
 =?us-ascii?Q?IcFyGoOP3DGYbhtWUMXtsbbm6W/sevar7EGJDgZQKYwYZOsWwLiyRd+PhEsL?=
 =?us-ascii?Q?K1DijkcTzexc3g8/kZcx5C51qQmObH9HGXURu0vbxI/P9Fn3iSW37ApX4wA2?=
 =?us-ascii?Q?Shr+8VzX201ZbC842wF8So87fN0BeuQmbcLpNRAZ5zWZ9u3gwvhw++RuDkx9?=
 =?us-ascii?Q?bI+NZmBAaHXccGVoIx9Kx1er47rdtsiqH6WUIwwZCnePZqhTC+W/R3/l13GP?=
 =?us-ascii?Q?UhcPTCWIdDMjt1uisvYo8tMRvX28ecqEME69IDDIyhDr46Dm/8hOxNmcqKM1?=
 =?us-ascii?Q?58dV39JbJ414myxhJ1FEJou32DOv3SgAK1zigMHHwjjUXlcZzWWs6v+6i9Gp?=
 =?us-ascii?Q?qDUM7NZTsHEWd01u1+V+HnTm1VbUkxFZzvsolNrRS7CxOoo4ViqyPiF78fFR?=
 =?us-ascii?Q?YNdg8qsKxzfYuReh/6QvPXVq4J/GVQnYbuHpaO4TqOAK31tqdxYHtruRRJqq?=
 =?us-ascii?Q?qgFzKKbiyDvYn/TWcT0f3kJ5FGYp9nKi1TdukfKOzIBQUDok4VmcbxntpRaq?=
 =?us-ascii?Q?qDnjCZGw+ekpPxEnylKvnkVcxrnLHnmGeG766/7kQbDzs6FxqZYbg1RdYO81?=
 =?us-ascii?Q?ZNM1muMLYGYaLdAigZvbP6MtEt2FFSf24u2pd+ZURK2ll57hOdYGZWJ76s+F?=
 =?us-ascii?Q?aggdOAuEkeIIlOsnkjMozIDYABFW6YJ5WDUM86RWLQeukXcPxQqy5IB/lnTG?=
 =?us-ascii?Q?+ivgKnGcnpim52VWOcWfTAlt/c0qO63WRsoDU5G7heh4Mg4gv2unv8L2iv+b?=
 =?us-ascii?Q?Tq15bZBIhxA9a/wi1BNLkkaHCiHDneNAhNJur02SSy3PNzZYP6R/f++V3LzS?=
 =?us-ascii?Q?jTUmahD7ZgIOoCe4kSzvX6i+YyHv0bS0u+cO4mLY8P7ihD9eiW41cdYy6V/j?=
 =?us-ascii?Q?v9obuVf5SAvUqVLqVCHaE1iR2u7K9tY/9RUK?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2025 19:20:43.6303 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2210a244-2009-4875-130b-08dd7b8973a0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099DC.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6970
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

This will be used to stop/start user queue scheduling for
example when switching between kernel and user queues when
enforce isolation is enabled.

v2: use idx
v3: only stop compute/gfx queues

Reviewed-by: Sunil Khatri <sunil.khatri@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h           |  1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c | 86 +++++++++++++++++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.h |  5 ++
 3 files changed, 84 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index b156e31ac86ac..30be6b79a032a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -1249,6 +1249,7 @@ struct amdgpu_device {
 
 	struct list_head		userq_mgr_list;
 	struct mutex                    userq_mutex;
+	bool                            userq_halt_for_enforce_isolation;
 };
 
 static inline uint32_t amdgpu_ip_version(const struct amdgpu_device *adev,
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
index 1867520ba258e..e944d05685dde 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
@@ -275,6 +275,7 @@ amdgpu_userqueue_create(struct drm_file *filp, union drm_amdgpu_userq *args)
 	const struct amdgpu_userq_funcs *uq_funcs;
 	struct amdgpu_usermode_queue *queue;
 	struct amdgpu_db_info db_info;
+	bool skip_map_queue;
 	uint64_t index;
 	int qid, r = 0;
 
@@ -348,6 +349,7 @@ amdgpu_userqueue_create(struct drm_file *filp, union drm_amdgpu_userq *args)
 		goto unlock;
 	}
 
+
 	qid = idr_alloc(&uq_mgr->userq_idr, queue, 1, AMDGPU_MAX_USERQ_COUNT, GFP_KERNEL);
 	if (qid < 0) {
 		DRM_ERROR("Failed to allocate a queue id\n");
@@ -358,15 +360,28 @@ amdgpu_userqueue_create(struct drm_file *filp, union drm_amdgpu_userq *args)
 		goto unlock;
 	}
 
-	r = uq_funcs->map(uq_mgr, queue);
-	if (r) {
-		DRM_ERROR("Failed to map Queue\n");
-		idr_remove(&uq_mgr->userq_idr, qid);
-		amdgpu_userq_fence_driver_free(queue);
-		uq_funcs->mqd_destroy(uq_mgr, queue);
-		kfree(queue);
-		goto unlock;
+	/* don't map the queue if scheduling is halted */
+	mutex_lock(&adev->userq_mutex);
+	if (adev->userq_halt_for_enforce_isolation &&
+	    ((queue->queue_type == AMDGPU_HW_IP_GFX) ||
+	     (queue->queue_type == AMDGPU_HW_IP_COMPUTE)))
+		skip_map_queue = true;
+	else
+		skip_map_queue = false;
+	if (!skip_map_queue) {
+		r = uq_funcs->map(uq_mgr, queue);
+		if (r) {
+			mutex_unlock(&adev->userq_mutex);
+			DRM_ERROR("Failed to map Queue\n");
+			idr_remove(&uq_mgr->userq_idr, qid);
+			amdgpu_userq_fence_driver_free(queue);
+			uq_funcs->mqd_destroy(uq_mgr, queue);
+			kfree(queue);
+			goto unlock;
+		}
 	}
+	mutex_unlock(&adev->userq_mutex);
+
 
 	args->out.queue_id = qid;
 
@@ -733,3 +748,58 @@ int amdgpu_userq_resume(struct amdgpu_device *adev)
 	mutex_unlock(&adev->userq_mutex);
 	return ret;
 }
+
+int amdgpu_userq_stop_sched_for_enforce_isolation(struct amdgpu_device *adev,
+						  u32 idx)
+{
+	const struct amdgpu_userq_funcs *userq_funcs;
+	struct amdgpu_usermode_queue *queue;
+	struct amdgpu_userq_mgr *uqm, *tmp;
+	int queue_id;
+	int ret = 0;
+
+	mutex_lock(&adev->userq_mutex);
+	if (adev->userq_halt_for_enforce_isolation)
+		dev_warn(adev->dev, "userq scheduling already stopped!\n");
+	adev->userq_halt_for_enforce_isolation = true;
+	list_for_each_entry_safe(uqm, tmp, &adev->userq_mgr_list, list) {
+		cancel_delayed_work_sync(&uqm->resume_work);
+		idr_for_each_entry(&uqm->userq_idr, queue, queue_id) {
+			if (((queue->queue_type == AMDGPU_HW_IP_GFX) ||
+			     (queue->queue_type == AMDGPU_HW_IP_COMPUTE)) &&
+			    (queue->xcp_id == idx)) {
+				userq_funcs = adev->userq_funcs[queue->queue_type];
+				ret |= userq_funcs->unmap(uqm, queue);
+			}
+		}
+	}
+	mutex_unlock(&adev->userq_mutex);
+	return ret;
+}
+
+int amdgpu_userq_start_sched_for_enforce_isolation(struct amdgpu_device *adev,
+						   u32 idx)
+{
+	const struct amdgpu_userq_funcs *userq_funcs;
+	struct amdgpu_usermode_queue *queue;
+	struct amdgpu_userq_mgr *uqm, *tmp;
+	int queue_id;
+	int ret = 0;
+
+	mutex_lock(&adev->userq_mutex);
+	if (!adev->userq_halt_for_enforce_isolation)
+		dev_warn(adev->dev, "userq scheduling already started!\n");
+	adev->userq_halt_for_enforce_isolation = false;
+	list_for_each_entry_safe(uqm, tmp, &adev->userq_mgr_list, list) {
+		idr_for_each_entry(&uqm->userq_idr, queue, queue_id) {
+			if (((queue->queue_type == AMDGPU_HW_IP_GFX) ||
+			     (queue->queue_type == AMDGPU_HW_IP_COMPUTE)) &&
+			    (queue->xcp_id == idx)) {
+				userq_funcs = adev->userq_funcs[queue->queue_type];
+				ret |= userq_funcs->map(uqm, queue);
+			}
+		}
+	}
+	mutex_unlock(&adev->userq_mutex);
+	return ret;
+}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.h
index db79141e1c1e0..0701f33e6740f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.h
@@ -115,4 +115,9 @@ uint64_t amdgpu_userqueue_get_doorbell_index(struct amdgpu_userq_mgr *uq_mgr,
 int amdgpu_userq_suspend(struct amdgpu_device *adev);
 int amdgpu_userq_resume(struct amdgpu_device *adev);
 
+int amdgpu_userq_stop_sched_for_enforce_isolation(struct amdgpu_device *adev,
+						  u32 idx);
+int amdgpu_userq_start_sched_for_enforce_isolation(struct amdgpu_device *adev,
+						   u32 idx);
+
 #endif
-- 
2.49.0

