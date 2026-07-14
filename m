Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F62AC44508
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Jul 2026 14:39:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BA42B10ED83;
	Tue, 14 Jul 2026 14:39:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="fo0bmdwl";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012050.outbound.protection.outlook.com
 [40.93.195.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0835F10ED83
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Jul 2026 14:39:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wAVFmgXDjDSzvUL3qnzlnxbC0ilGB6qzG3kMFVjM0JH/2YCOI8GeZivVDaSdhoTYoMIN0vGa2sMCHT9neb1sPURlxvkX5hX/G9GMyAX30UP3zMw4XLIK6EAAF2xDbfZXe0nGdqOWgbsG3LrX335QREWj8J6aVpiLwJiUDrRyDSrOPUbc7a2FC7OEPa2ICsDu/Q47fRRb4MD3ObAwbu+hkpP+kEUTqYpN+O5JvoB1cqipoPcUMkig3nL2MLJ/Bs8hjdCBTaYWnBpsUc4oUEhL3m5tOLzNk6ephaC2W/3khNo5x4OvDWQz/aD7Ry5wxvOsARKIRAfP2RoQKtZsYYiEZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oFJzK02hgBIt78/OL17E3wK8oZK4uXCDMZev2d5H7DE=;
 b=NTXJSgpk0ZXjaWISHXhEcVY08X3Wmd8ma4TAJyLsXNvHPds0AdBqlaIdo6ejlLEi1FyWet13Xi+M5fXvwsmX8zCqfM3/OD96E9eKnRBItGXdpEXMJXObIo0r6lFLE1tHvLwGw4wb0tQe0mumroJU6jfiYj2OWfXxB3li1C0ld/grUFpm1eoWe6F5YKMXIYeskcUwakhI9dcVEwlt9Vcykdss7L5eS8vVcG1361wTuqRlN65V6Q9+dAxCK5TcrDL6w9Ch3ONeS/k0jv9+MOyEheCDOwZgQOxE6/8smM2N3i3fo6uXm5/6bNneL1JCHsmjRbW4bjK72P+/Up79kNfb8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oFJzK02hgBIt78/OL17E3wK8oZK4uXCDMZev2d5H7DE=;
 b=fo0bmdwlBoLGLQK9Oj4+mV0T1zZkkOKY1yCop6fWiI1JKuBWEj8Rh64sAgQvlD3em2SKMjRYX+uysHXWMwRxlIt2tvgriFMPfFJmqhAZ3YR+W7F6v17DVSL3VzbdL3WnM8oT8k/DEuJzItyMMRZWdOnpuBnkTiTms1hM9U3lgng=
Received: from DS7PR05CA0078.namprd05.prod.outlook.com (2603:10b6:8:57::24) by
 MN2PR12MB4390.namprd12.prod.outlook.com (2603:10b6:208:26e::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.10; Tue, 14 Jul
 2026 14:39:53 +0000
Received: from DS3PEPF0000C381.namprd04.prod.outlook.com
 (2603:10b6:8:57:cafe::7b) by DS7PR05CA0078.outlook.office365.com
 (2603:10b6:8:57::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.10 via Frontend
 Transport; Tue, 14 Jul 2026 14:39:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 DS3PEPF0000C381.mail.protection.outlook.com (10.167.23.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.223.9 via Frontend Transport; Tue, 14 Jul 2026 14:39:52 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 14 Jul
 2026 09:39:52 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 14 Jul
 2026 09:39:51 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Tue, 14 Jul 2026 09:39:51 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>, Prike Liang <Prike.Liang@amd.com>, "Sunil
 Khatri" <sunil.khatri@amd.com>, "Lazar, Lijo" <lijo.lazar@amd.com>
Subject: [PATCH] drm/amdgpu: properly account for resets with user queues
Date: Tue, 14 Jul 2026 10:39:39 -0400
Message-ID: <20260714143939.680824-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF0000C381:EE_|MN2PR12MB4390:EE_
X-MS-Office365-Filtering-Correlation-Id: 13084973-1b10-438b-d3e9-08dee1b5c3ca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|23010399003|1800799024|36860700016|56012099006|11063799006|18002099003;
X-Microsoft-Antispam-Message-Info: PospS4swE3f8z7G21ejs9GHYCdn/hOjFRnoOcQTu74J8+lubqMaAp7bfR3f5H4mUZr8gC4RR5skcOgnr9PA71TmRb5aAYabuWTXWTSPlApvy7PCW+XUovF9bwvOhzCeq3LpuZ7FnDd6xq0chclAS45agcVg+78NlOVe48Ji4kQMvI6vETmizi+jHaZVkjFlfpZ7j00H+YANT9v3KzEig0JNqn8dls0cHbRIzWnbvXg/8X+9tGQ5s1ryoBoCfkqkmIBHNiCw/3D4berJWcxyp98F5b7sUHt/nN8eXG2/b4Qn+q8IQEfoM0UGVWCFiir6ST9E03OQs+A7vS6uXJF+1+N03zgiFdoZMBFyVm4RGS6d2KjJxoQLj8JB7jihoy5Cuhn4AOU7DxOJ15FTn4RLh3gaWTTXrDqktwuajtCTIetplVYzCeuDvHGAXo+3JpnIsQPYLStQ9t6hTvp6k6RngD8AE6ZiIuJRrgm42Z7ZH+gP/JF6y06iuUlwwPphsDwqYK8PrlpmEieIz5GaHmjo5eBS9th62JpNeKazyIz7L6mPX/Yg+ZxsmSqlPudUCld3XjXog6pwSKbkEFVPW6rfsOe+64FTXr4P/81uuj5zM/D64W1CV5MjDu9ALYOb6OrkG7+CSk1D6mj0NGEXhE2zIGJ3tnWe9iSm/wX37Y44MDvy54TMICXzbDrXLm55qaG5USyrxHj4bbg2kiVDPDi1k7A==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(23010399003)(1800799024)(36860700016)(56012099006)(11063799006)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: dnl8DdWkcyyeux6jy+7S/gBHBo13k1ClLjMYSTy4sYyI//cI829OI66O3dbpnQxu0mhqPlbdkho3h4+WiZAhM7pFIcTaRw+VVsbrAspSKB9cJ3mnvOtsAZhz1vVysUjh9rlVZxem2KBpvJs/gyT/kinAHpz2TewlQrgrloTnI3Zg6q2LedvWH1lCQZz9B79xxS4rrzNZP9EaAbVOsfHw3Nqz2PNjE0Q+a3ekCmhi0zJM8TKWMCEvCt0sF+APoSQmK9GR8Uwq8SfdAfEgIycy6RlBg7hjESuYpDPA9/5J19j9661VBa377DsLErPK1rIWYcTfiHnQF8Bop/530UBTLvExmeobRgZyjXy50/qJcXoWCLWu3qo5Y3nsRSqZi3Pn2/Z4XFkigbTzj/FwjB7roM+l+4YRefh1cQ2PyY2RDNHLlFQ62U6Jkc1fQxHO2veS
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2026 14:39:52.2967 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 13084973-1b10-438b-d3e9-08dee1b5c3ca
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF0000C381.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4390
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

We need to increment the reset counter, force fence completion,
and set the wedged event when a user queue is reset, but only
for the guilty queue.  We don't want additional events for
collateral damage.

Only increment the reset counter and set the wedged event
in the top level userq reset callers (both KGD and KFD).
This aligns with how this is managed for kernel queue resets.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Cc: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
Cc: Prike Liang <Prike.Liang@amd.com>
Cc: Sunil Khatri <sunil.khatri@amd.com>
Cc: Lazar, Lijo <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c       | 17 ++++++++++++++++-
 drivers/gpu/drm/amd/amdgpu/mes_userqueue.c      |  2 --
 .../drm/amd/amdkfd/kfd_device_queue_manager.c   | 14 ++++++++++++++
 3 files changed, 30 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
index 6aa75da27f912..0a0ebcdc271f8 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
@@ -123,6 +123,8 @@ static void amdgpu_userq_hang_detect_work(struct work_struct *work)
 	struct amdgpu_device *adev = uq_mgr->adev;
 	const struct amdgpu_userq_funcs *userq_funcs =
 		adev->userq_funcs[queue->queue_type];
+	struct drm_wedge_task_info *info = NULL;
+	struct amdgpu_task_info *ti = NULL;
 	bool gpu_reset = false;
 
 	if (unlikely(adev->debug_disable_gpu_ring_reset)) {
@@ -137,6 +139,14 @@ static void amdgpu_userq_hang_detect_work(struct work_struct *work)
 	if (!amdgpu_gpu_recovery)
 		return;
 
+	if (queue->vm && queue->vm->pasid) {
+		ti = amdgpu_vm_get_task_info_pasid(adev, queue->vm->pasid);
+		if (ti) {
+			amdgpu_vm_print_task_info(adev, ti);
+			info = &ti->task;
+		}
+	}
+
 	if (amdgpu_userq_is_reset_type_supported(adev, queue->queue_type,
 						 AMDGPU_RESET_TYPE_PER_QUEUE)) {
 		int r;
@@ -146,8 +156,13 @@ static void amdgpu_userq_hang_detect_work(struct work_struct *work)
 							 queue, NULL, NULL);
 		else
 			r = userq_funcs->reset(queue);
-		if (r)
+		if (r) {
 			gpu_reset = true;
+		} else {
+			atomic_inc(&adev->gpu_reset_counter);
+			amdgpu_userq_fence_driver_force_completion(queue);
+			drm_dev_wedged_event(adev_to_drm(adev), DRM_WEDGE_RECOVERY_NONE, info);
+		}
 	} else {
 		gpu_reset = true;
 	}
diff --git a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
index d3d79bbaf9eb7..a1371a9f961d1 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
@@ -234,9 +234,7 @@ int mes_userq_reset_queue(struct amdgpu_device *adev,
 				r = mes_userq_unmap(uq);
 				if (r)
 					return r;
-				atomic_inc(&adev->gpu_reset_counter);
 				amdgpu_userq_fence_driver_force_completion(uq);
-				drm_dev_wedged_event(adev_to_drm(adev), DRM_WEDGE_RECOVERY_NONE, NULL);
 				break;
 			}
 		}
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
index 0419fe869d4b0..0ae2d951bd21e 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
@@ -448,6 +448,9 @@ int kfd_reset_queue_mes(struct device_queue_manager *dqm, int queue_type,
 static int reset_queues_mes(struct device_queue_manager *dqm, struct queue *q)
 {
 	struct amdgpu_device *adev = (struct amdgpu_device *)dqm->dev->adev;
+	struct drm_wedge_task_info *info = NULL;
+	struct amdgpu_task_info *ti = NULL;
+	struct kfd_process_device *pdd;
 	unsigned int num_hung = 0;
 	int r = 0;
 	struct mes_remove_queue_input queue_input;
@@ -476,6 +479,17 @@ static int reset_queues_mes(struct device_queue_manager *dqm, struct queue *q)
 	r = amdgpu_gfx_reset_mes_compute(adev, NULL, NULL, NULL, &num_hung, &queue_input);
 	if (r)
 		goto fail;
+	pdd = kfd_get_process_device_data(q->device, q->process);
+	if (pdd) {
+		ti = amdgpu_vm_get_task_info_pasid(adev, pdd->pasid);
+		if (ti) {
+			amdgpu_vm_print_task_info(adev, ti);
+			info = &ti->task;
+		}
+	}
+
+	atomic_inc(&adev->gpu_reset_counter);
+	drm_dev_wedged_event(adev_to_drm(adev), DRM_WEDGE_RECOVERY_NONE, info);
 
 	dqm->detect_hang_count = num_hung;
 	/* When MES doesn't detect any queue hang, no reset happens. Don't signal reset
-- 
2.55.0

