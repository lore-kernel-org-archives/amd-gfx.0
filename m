Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5885CA0FED
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Sep 2025 08:16:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 83A3B10E89C;
	Wed, 10 Sep 2025 08:16:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="aGhuPA0S";
	dkim-atps=neutral
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2073.outbound.protection.outlook.com [40.107.101.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2445510E89C
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 Sep 2025 08:16:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LWY319UtHqEKsgxajahkPOU6d/VpspzeNpd7YFC5rqw/vsF9OncWyu9fagoku4HOx3hXTNSi0BI2jLbTWNtkEkD6/1fSOUxSzSQHZZV7b7AsL54BVRCGrYlaSiZbrPasWwkYqjzR26rFfw8/5XMOdNCyxXNq+R8jFpE9rLzowKl79aNfVDTmBIpih/AnAgWREX6FhRwsXfIQbOq2EaSDM5PrmA8zLADYUC33rjafoqkWntSf/QCRkL68fl0YYM9QT7n/giKU2SShOd9AOqhmTYINdVZrkS6or/ihdiw0Hybiusm+duvOZXJvkFcdtNq96l8tVCAsziZG5nF12wcXGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CQyG1W+H9FkLDCDg7lkIaM/fO8tn5SEI8fRnEqIBIKs=;
 b=O9KGM8YMzPzFnkBg0qxkevUxsbVKvPyTljZMbAi29taspL/yn8f8aNU+e7KkVuc3QWBHvg0cDb9KR4h5WEcnQ5WQ6yhk7Vi+KB3VRl5EjnygjqyC2eKoYcHny9HGIag56x/KY/j/d3PjVhMGu9HwyATzoXRslQRnDRgvQm5vTIxpQRCQVxGoNUxbv2/fjfnLSLp40X8nwgTqd3b/7CyzfXLDqyvfhmObCrFbJt2CQwD5BtrKGCUZxhEY8Go87tmlHDR+nZb+7a6e2/xiMQpBfnckI94GB5OdjLjzuH9CdBoEmJnvvmigz73sTU81VNOMH4wRIq1w86RszSJjGfQUYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CQyG1W+H9FkLDCDg7lkIaM/fO8tn5SEI8fRnEqIBIKs=;
 b=aGhuPA0SBF8rZv30UxBiBjWnCY7/hMdtk7Cs2pUWUC/fE3pDgUuqgWKSUkbl+FksX/qXh2qDAQ5FmK/YqDPr3aRnQAKEak4nkRM7eE2IJmv/597Rkb1dN4YFQxJjOEcdrtkDM6d1B5UwaS4CfFnh4fbklRRr9FM3YA3ZPUm5mt0=
Received: from BY1P220CA0022.NAMP220.PROD.OUTLOOK.COM (2603:10b6:a03:5c3::14)
 by SN7PR12MB8129.namprd12.prod.outlook.com (2603:10b6:806:323::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Wed, 10 Sep
 2025 08:16:50 +0000
Received: from CO1PEPF000075F2.namprd03.prod.outlook.com
 (2603:10b6:a03:5c3:cafe::4a) by BY1P220CA0022.outlook.office365.com
 (2603:10b6:a03:5c3::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9115.16 via Frontend Transport; Wed,
 10 Sep 2025 08:16:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CO1PEPF000075F2.mail.protection.outlook.com (10.167.249.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9115.13 via Frontend Transport; Wed, 10 Sep 2025 08:16:49 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 10 Sep
 2025 01:16:48 -0700
Received: from JesseDEV.guestwireless.amd.com (10.180.168.240) by
 satlexmb08.amd.com (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17
 via Frontend Transport; Wed, 10 Sep 2025 01:16:42 -0700
From: Jesse.Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 Jesse.Zhang <Jesse.Zhang@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 2/3] drm/amdgpu: Switch user queues to use preempt/restore for
 eviction
Date: Wed, 10 Sep 2025 16:14:36 +0800
Message-ID: <20250910081634.3943981-2-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250910081634.3943981-1-Jesse.Zhang@amd.com>
References: <20250910081634.3943981-1-Jesse.Zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000075F2:EE_|SN7PR12MB8129:EE_
X-MS-Office365-Filtering-Correlation-Id: e6b1c3d6-91f2-4aa7-8c3e-08ddf0426452
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?mwL+GLj9jJPfWHqFwoJexd69Fz5ld6vmXF98cPODgkiOXJQbw5h8FekrEsac?=
 =?us-ascii?Q?XwuRde/N7nCA3Ctb5comHDolt//6fLsoW4wnHPqsHGCu/caVPLa7vW/2a9nE?=
 =?us-ascii?Q?VfihGj+ncas8zZnh45T08D8tGWKKBQ3MXJUXGrYlAEtAm+RJp+F5Gi20X//q?=
 =?us-ascii?Q?Uek1+YhfPp5zHu82G+rUj8bI8r9/3z/g/XDurZEojCsqzAXOkCqnOH2ldA3O?=
 =?us-ascii?Q?EPFnGKsiJvLiy3qAOosPlUQq7gDWAkIKrC9NAgDnQPs+1ZePs0oopA+2AzfG?=
 =?us-ascii?Q?6W9l2gFiOUTsoq5H28+40q5a2+7h4oiFSMsp6cKielPVFMxStfZ5kdk/dQh+?=
 =?us-ascii?Q?71CVqneBU6G+We0AaZDShcsayahq01T/JYWF3GKcL5YFLiNulfZlKnpBmEJh?=
 =?us-ascii?Q?o5x357u8vB1qP2dKDcdGpUbrwPtHjG3ORhQ+AzR0LQPjcmXaFJ7PI9dHwdjc?=
 =?us-ascii?Q?DNKn06KYegN6AepdG1A7yivTdQhq8nO9ibmAvXOrXvApfrC+zqVjva2G/3GF?=
 =?us-ascii?Q?+RbpiT6HsCrTRmyjqUcpqelxzV+SeRj6X1JnOyYvW5KQ/7Exf0CqumaOhEsJ?=
 =?us-ascii?Q?Esx3JI+vxLpO5GD7gQQiIBi0zhj8ASp2dSOh2Sqjk9mjqQkInHC0O9E8Mj7Y?=
 =?us-ascii?Q?I8Wa/VKVBtF4jQsgrcl4ZNG3Adw7m0z7ZpvAP4iEJaqhdN3EgeJhwWJC8UUB?=
 =?us-ascii?Q?zZQYfQYzZCyDnRUiL9SBlKOhgIUohStNzg3OBXmxN76HELDCiLq8qAi3PaZC?=
 =?us-ascii?Q?8T1gyl5wXa+ZoWvdMkBZtS+VLjWWqYqECZbbCidprQlaPzzf5u5QKi7Z0f3e?=
 =?us-ascii?Q?yDVggRrPf5Mv8DCP+ficU0El9tOs6/GuqqAijYiqsqHI5oOu7Cq4g3mwUq5W?=
 =?us-ascii?Q?mvSZZYOfmqiwrZB28d+j8Nv7r8Hf98JHtRb1U/a09hYyUgEJ7hgkoZzbHzMd?=
 =?us-ascii?Q?8i9qXFsWR63D8z0I4QlAgPvIBxNJF/H9cEjpE9ZEwiDL5/9IKoFsf+48/qx3?=
 =?us-ascii?Q?7dT4/kOtKBW6Hlp6LxxWRz0awk4YymjGAaWtZPXtrGKUheDw9XrQmqCd12Am?=
 =?us-ascii?Q?aLkl3lm0hMaaAiPKlGiUvLjlKEd4YpouJzdUYKlG9VZYEVLv21t5nCsJvVxB?=
 =?us-ascii?Q?vLpcdg0vxYuspD227xZc5Gn194QDz2QukENE48J7z5UaGPE3mLT1UjP4zfki?=
 =?us-ascii?Q?4MOk71q6UdBBbVJKJpfbyG7kTCc0MYqG3oTJIld7oqEf5Vm4xAUotqsQvKha?=
 =?us-ascii?Q?gtEQa+y+Jf8Lhkx3syYPM5habytfmelAdBEc1htX6W1gaLjqGkUEFRICfpeZ?=
 =?us-ascii?Q?kJfIfxRPH0l4sKHAkjRf/kpPYoGJ2Foplk1QDRYg6jy2dXzXDUMV1kjNBkom?=
 =?us-ascii?Q?LM4mviQ64pN5+hQ/d3k5P8DRNHK/OShj5FaMLCzJQxy8A95W5Xmg23fcpDg5?=
 =?us-ascii?Q?n4/7m9LzcI24Nvc4SX6cL1eMIj1neuUdODtBuYmhJ1rGtlCCF0elqGI8GClS?=
 =?us-ascii?Q?ab+PhaCweOXXKjhnNjqDcEU4VzUYAFsA2YfA?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2025 08:16:49.6775 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e6b1c3d6-91f2-4aa7-8c3e-08ddf0426452
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000075F2.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8129
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

This patch modifies the user queue management to use preempt/restore
operations instead of full map/unmap for queue eviction scenarios where
applicable. The changes include:

1. Introduces new helper functions:
   - amdgpu_userqueue_preempt_helper()
   - amdgpu_userqueue_restore_helper()

2. Updates queue state management to track PREEMPTED state

3. Modifies eviction handling to use preempt instead of unmap:
   - amdgpu_userq_evict_all() now uses preempt_helper
   - amdgpu_userq_restore_all() now uses restore_helper

The preempt/restore approach provides better performance during queue
eviction by avoiding the overhead of full queue teardown and setup.
Full map/unmap operations are still used for initial setup/teardown
and system suspend scenarios.

v2: rename amdgpu_userqueue_restore_helper/amdgpu_userqueue_preempt_helper to
amdgpu_userq_restore_helper/amdgpu_userq_preempt_helper for consistency. (Alex)

v3: amdgpu_userq_stop_sched_for_enforce_isolation() and
amdgpu_userq_start_sched_for_enforce_isolation() should use preempt and restore (Alex)

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 53 ++++++++++++++++++++---
 1 file changed, 48 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
index 9608fe3b5a9e..b649ac0cedff 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
@@ -77,7 +77,7 @@ int amdgpu_userq_input_va_validate(struct amdgpu_vm *vm, u64 addr,
 }
 
 static int
-amdgpu_userq_unmap_helper(struct amdgpu_userq_mgr *uq_mgr,
+amdgpu_userq_preempt_helper(struct amdgpu_userq_mgr *uq_mgr,
 			  struct amdgpu_usermode_queue *queue)
 {
 	struct amdgpu_device *adev = uq_mgr->adev;
@@ -86,6 +86,49 @@ amdgpu_userq_unmap_helper(struct amdgpu_userq_mgr *uq_mgr,
 	int r = 0;
 
 	if (queue->state == AMDGPU_USERQ_STATE_MAPPED) {
+		r = userq_funcs->preempt(uq_mgr, queue);
+		if (r) {
+			queue->state = AMDGPU_USERQ_STATE_HUNG;
+		} else {
+			queue->state = AMDGPU_USERQ_STATE_PREEMPTED;
+		}
+	}
+
+	return r;
+}
+
+static int
+amdgpu_userq_restore_helper(struct amdgpu_userq_mgr *uq_mgr,
+			struct amdgpu_usermode_queue *queue)
+{
+	struct amdgpu_device *adev = uq_mgr->adev;
+	const struct amdgpu_userq_funcs *userq_funcs =
+		adev->userq_funcs[queue->queue_type];
+	int r = 0;
+
+	if (queue->state == AMDGPU_USERQ_STATE_PREEMPTED) {
+		r = userq_funcs->restore(uq_mgr, queue);
+		if (r) {
+			queue->state = AMDGPU_USERQ_STATE_HUNG;
+		} else {
+			queue->state = AMDGPU_USERQ_STATE_MAPPED;
+		}
+	}
+
+	return r;
+}
+
+static int
+amdgpu_userq_unmap_helper(struct amdgpu_userq_mgr *uq_mgr,
+			  struct amdgpu_usermode_queue *queue)
+{
+	struct amdgpu_device *adev = uq_mgr->adev;
+	const struct amdgpu_userq_funcs *userq_funcs =
+		adev->userq_funcs[queue->queue_type];
+	int r = 0;
+
+	if ((queue->state == AMDGPU_USERQ_STATE_MAPPED) ||
+		(queue->state == AMDGPU_USERQ_STATE_PREEMPTED)) {
 		r = userq_funcs->unmap(uq_mgr, queue);
 		if (r)
 			queue->state = AMDGPU_USERQ_STATE_HUNG;
@@ -651,7 +694,7 @@ amdgpu_userq_restore_all(struct amdgpu_userq_mgr *uq_mgr)
 
 	/* Resume all the queues for this process */
 	idr_for_each_entry(&uq_mgr->userq_idr, queue, queue_id) {
-		r = amdgpu_userq_map_helper(uq_mgr, queue);
+		r = amdgpu_userq_restore_helper(uq_mgr, queue);
 		if (r)
 			ret = r;
 	}
@@ -808,7 +851,7 @@ amdgpu_userq_evict_all(struct amdgpu_userq_mgr *uq_mgr)
 
 	/* Try to unmap all the queues in this process ctx */
 	idr_for_each_entry(&uq_mgr->userq_idr, queue, queue_id) {
-		r = amdgpu_userq_unmap_helper(uq_mgr, queue);
+		r = amdgpu_userq_preempt_helper(uq_mgr, queue);
 		if (r)
 			ret = r;
 	}
@@ -993,7 +1036,7 @@ int amdgpu_userq_stop_sched_for_enforce_isolation(struct amdgpu_device *adev,
 			if (((queue->queue_type == AMDGPU_HW_IP_GFX) ||
 			     (queue->queue_type == AMDGPU_HW_IP_COMPUTE)) &&
 			    (queue->xcp_id == idx)) {
-				r = amdgpu_userq_unmap_helper(uqm, queue);
+				r = amdgpu_userq_preempt_helper(uqm, queue);
 				if (r)
 					ret = r;
 			}
@@ -1027,7 +1070,7 @@ int amdgpu_userq_start_sched_for_enforce_isolation(struct amdgpu_device *adev,
 			if (((queue->queue_type == AMDGPU_HW_IP_GFX) ||
 			     (queue->queue_type == AMDGPU_HW_IP_COMPUTE)) &&
 			    (queue->xcp_id == idx)) {
-				r = amdgpu_userq_map_helper(uqm, queue);
+				r = amdgpu_userq_restore_helper(uqm, queue);
 				if (r)
 					ret = r;
 			}
-- 
2.49.0

