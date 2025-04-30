Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9F19C3ABAC
	for <amd-gfx@archiver.kernel.org>; Wed, 30 Apr 2025 15:48:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6578C10E7ED;
	Wed, 30 Apr 2025 15:48:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ZLKeFF+n";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2079.outbound.protection.outlook.com [40.107.237.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DB32F10E0C5
 for <amd-gfx@lists.freedesktop.org>; Wed, 30 Apr 2025 15:48:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ansvKKLpICKgw8wVyE8mJR6g9gc7OCXdwqFMOshcpNz64saBlpQtI9hdPO5o+lU57IDTaS+jReQ0vI6nOhX/H5zChjXbceJwto/g8r5efIf2Zh6PLfGpVUETQGR1tsGH8JEJahfM40hWbUe+Q5JbWEF92HuSWzbvXm0KITUplr4Zu9Z+DJr/ZhbW0/uWPBdhOvOS2ZJBmGI5JB6Fi0NW3RpTU3GZeshk6oz8Ly7IvFiGCwLZ/dTSfyzZHVgdOv/Nw/i02sPTFfUf1csRnv5eBSgcFcPlc1XwuphylAnJgqZc4uETb6Sb10iInpj6v7R7lViJQvxDSlotWEC65yd5tA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UyXFPxFHFrHKOm37CP0ikGLriT2br3c41XA8Gqtr6Ck=;
 b=MelQR9E8WIsIiOlAmG9NjtrFOHJbzzch5hAt3GwEwkvvFQmnEUbs1/+V7rT9TfRwTFka/ljKIiM++xWQfPlMJHYE4KNfcN5KiE6pfWmWMm3cgyUST1yLKoDAVk4mAeNu5tjgViASl5V5VwGQ8w3ReZiixv1kr5hJO18NM/yhK98We2UIxjiC8G6R1hmMamDaHlkWzS64hRPE3mzFcGbIbiUFsTkpjQHTU5MZZnBg+KazoM72TVhbo6EEdW1H3taWgnHulecSR/v40If5Y5d2w+Xfc1J7LZXLM/HnLhGhc6rof/MR34H5gxAl2QvnCDeuoxBTnRfso0MvrfAmxiLI5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UyXFPxFHFrHKOm37CP0ikGLriT2br3c41XA8Gqtr6Ck=;
 b=ZLKeFF+nwCab9c288jJzfCMG2BAe/+s5tLOX/u4wmgQiJ87tVtKHOXibIjzHvNjdPC4DD6qFJS8vHLQ1fuF2MnRIcPyRqvaWAUZlu71xflQRtc7QcKjsoa9bN9taaMVRUfwJakQ4rGpD+xxuB0w9GtAQSBXm5szCeCVUifdTliU=
Received: from MN2PR20CA0031.namprd20.prod.outlook.com (2603:10b6:208:e8::44)
 by SN7PR12MB6692.namprd12.prod.outlook.com (2603:10b6:806:270::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.21; Wed, 30 Apr
 2025 15:48:26 +0000
Received: from BL6PEPF0001AB4B.namprd04.prod.outlook.com
 (2603:10b6:208:e8:cafe::43) by MN2PR20CA0031.outlook.office365.com
 (2603:10b6:208:e8::44) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.36 via Frontend Transport; Wed,
 30 Apr 2025 15:48:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB4B.mail.protection.outlook.com (10.167.242.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8699.20 via Frontend Transport; Wed, 30 Apr 2025 15:48:26 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 30 Apr
 2025 10:48:24 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>, Sunil Khatri
 <sunil.khatri@amd.com>
Subject: [PATCH 5/7] drm/amdgpu/userq: implement resets
Date: Wed, 30 Apr 2025 11:48:07 -0400
Message-ID: <20250430154809.2665473-5-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250430154809.2665473-1-alexander.deucher@amd.com>
References: <20250430154809.2665473-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB4B:EE_|SN7PR12MB6692:EE_
X-MS-Office365-Filtering-Correlation-Id: 95352b0b-9ad8-49d8-fb7a-08dd87fe721a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?WgFTl0Fn5pMcrLoC9e0K+oJadP8vg0SFLwRnI/ekbiNppJ/V56okg2Pwjkqy?=
 =?us-ascii?Q?bQX+nKYKVPqqQRnMO3uFRxYswdSn1gI0usZ+obgPqnswpyxkOjfQzjR/aIus?=
 =?us-ascii?Q?+qxdML3MmXqdxnJtJmShUVYvTJxqgdwHk6oSEOLIdgc8nfH+LsdfTmBQ3/Ts?=
 =?us-ascii?Q?gO5V8iG0XE850XALuUltfUn5VvyKS86TN0oYkAEvHJfaN1cgUmJN7mvoqrP3?=
 =?us-ascii?Q?hmty/YS58HwhsmXHAZH6kEcFQYKE8WI2L+3DF3OEE7T5tV2/9JyAzK8aiR5B?=
 =?us-ascii?Q?1vjfLtTWtrPVlHuB1GukcFrY135da5kt/Yd2Kpn6ypSKjP4ZP816UoipQ/Wc?=
 =?us-ascii?Q?+QbUVBB6iAcur/WbLHtXTzxH/L0MaUsTCbJZUKNOMJMXl9arrYP57jMunQyA?=
 =?us-ascii?Q?KU9oa+jgwXgdgEPoV7pdksQd2m/Srf3g6TC5wAf1/zc99ZjdiDze+zCu9XL8?=
 =?us-ascii?Q?5NmM7cZIP4q5PHJ8BYqM3POugr9P4tgKrC/jvXeqk+mdvJbhelD3w6ews3xQ?=
 =?us-ascii?Q?6/atFUbsp5RemHwuTz7b5ZEWNqLSmlPJPzrAvcd6WegZKBZokcSsKkTj1osk?=
 =?us-ascii?Q?CbuR8fYIoaGgY8865vjw6+K6MJn6Xv2urA10Kiu0LLpT19Ta5C3pSzJomvO8?=
 =?us-ascii?Q?J44tg0GXzsm1BbaAMI5DW9CaKiza4Fjct+ZakDc4AikP5ZKEFXVHj6BvNXjO?=
 =?us-ascii?Q?YMb/cepxMxKuiOyZ2w8sC2W/n8LSvDT4LYUdg9IltjqiA2vbnVaT24L/GxNh?=
 =?us-ascii?Q?6LED16GRQum/HD7y4GaH8mQ/+add2gpR0k9h21Q/A4hUUwArqRzPDQtK+sPX?=
 =?us-ascii?Q?5Sw7mvbPiZn8dJCcYmj1ASXgUR9pOY34/a7gBHxlZsw9Mnfh1tDEugxn+wZP?=
 =?us-ascii?Q?34A3EB9mEhgQKqHY/NHzR4gGNB7inY3ldENY62fM+4YKCdqn0c/V/aDJGILv?=
 =?us-ascii?Q?X3xsYgR8xIujeE4YenaUAmmXfb4da6rGMquyJGKoZPZfgSDMDU4wCx5w9qta?=
 =?us-ascii?Q?gGbxR45LWb22/IlnE5JopVco0KEBHcPymLvNoVsiXa4Cps5bhT5xuk1NaDod?=
 =?us-ascii?Q?9s0kqBCLWdyRpoL+x/CRGZ1oywY3Q2/c6qxxACM+PSITON0NnLLGvshf4KZ6?=
 =?us-ascii?Q?Om6I/ep62w1dPNrHFojvpwO7nbTHgIJ0MsU7IcyX1HXDoLz93CYD/LecrYxl?=
 =?us-ascii?Q?X68Aj/TBbyBBvWyHyfjy7oht60+GR0TeWRbQVJO7Dh3CgFPiGnRFdMneGsG6?=
 =?us-ascii?Q?8Dmh5CLF8lWeb2q105TOfDNhZCmJJ6j4QMkqJI0ZOWDyXSuE//qco0hlS9GS?=
 =?us-ascii?Q?V/fJB5gvYZ7LMQ2EEEpeZEcbCje9WWCrr1SgzNJSaRbZtoioAlsOaJaqtQJA?=
 =?us-ascii?Q?vttak9s76PjoHL9D3YCt8LfiJRRF0YqURL/TlHCkn4TcUPSiQhBWCy3pq5GL?=
 =?us-ascii?Q?cG/zl2x8Zn2ZN8GDB0WgkH9mo/VYBJz7HA16xNFf/sStdeCLu4LjqX20ZokR?=
 =?us-ascii?Q?Tk0nonOSNmNOxWLJiTqYij7e1VCq8L0sAyBV?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2025 15:48:26.1822 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 95352b0b-9ad8-49d8-fb7a-08dd87fe721a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB4B.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6692
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

If map or unmap fails, or a user fence times out, attempt to
reset the queue.  If that fails, schedule a GPU reset.

Reviewed-by: Sunil Khatri <sunil.khatri@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h        |   1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c |   8 ++
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c  | 128 +++++++++++++++++++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h  |   5 +
 4 files changed, 131 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index cc26cf1bd843e..936e1a0ac02f1 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -1251,6 +1251,7 @@ struct amdgpu_device {
 	struct list_head		userq_mgr_list;
 	struct mutex                    userq_mutex;
 	bool                            userq_halt_for_enforce_isolation;
+	struct work_struct		userq_reset_work;
 };
 
 static inline uint32_t amdgpu_ip_version(const struct amdgpu_device *adev,
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index fe68ba9997ae4..317c86c1493a8 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -4420,6 +4420,7 @@ int amdgpu_device_init(struct amdgpu_device *adev,
 	}
 
 	INIT_WORK(&adev->xgmi_reset_work, amdgpu_device_xgmi_reset_func);
+	INIT_WORK(&adev->userq_reset_work, amdgpu_userq_reset_work);
 
 	adev->gfx.gfx_off_req_count = 1;
 	adev->gfx.gfx_off_residency = 0;
@@ -5777,6 +5778,10 @@ int amdgpu_device_reinit_after_reset(struct amdgpu_reset_context *reset_context)
 				if (r)
 					goto out;
 
+				r = amdgpu_userq_post_reset(tmp_adev, vram_lost);
+				if (r)
+					goto out;
+
 				drm_client_dev_resume(adev_to_drm(tmp_adev), false);
 
 				/*
@@ -5999,6 +6004,7 @@ static inline void amdgpu_device_stop_pending_resets(struct amdgpu_device *adev)
 	if (!amdgpu_sriov_vf(adev))
 		cancel_work(&adev->reset_work);
 #endif
+	cancel_work(&adev->userq_reset_work);
 
 	if (adev->kfd.dev)
 		cancel_work(&adev->kfd.reset_work);
@@ -6109,6 +6115,8 @@ static int amdgpu_device_halt_activities(struct amdgpu_device *adev,
 		      amdgpu_device_ip_need_full_reset(tmp_adev))
 			amdgpu_ras_suspend(tmp_adev);
 
+		amdgpu_userq_pre_reset(tmp_adev);
+
 		for (i = 0; i < AMDGPU_MAX_RINGS; ++i) {
 			struct amdgpu_ring *ring = tmp_adev->rings[i];
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
index afbe01149ed3f..4be46fa76ceba 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
@@ -26,7 +26,10 @@
 #include <drm/drm_exec.h>
 #include <linux/pm_runtime.h>
 
+#include <drm/drm_drv.h>
+
 #include "amdgpu.h"
+#include "amdgpu_reset.h"
 #include "amdgpu_vm.h"
 #include "amdgpu_userq.h"
 #include "amdgpu_userq_fence.h"
@@ -44,6 +47,44 @@ u32 amdgpu_userq_get_supported_ip_mask(struct amdgpu_device *adev)
 	return userq_ip_mask;
 }
 
+static void amdgpu_userq_gpu_reset(struct amdgpu_device *adev)
+{
+
+	if (amdgpu_device_should_recover_gpu(adev))
+		amdgpu_reset_domain_schedule(adev->reset_domain,
+					     &adev->userq_reset_work);
+}
+
+static bool
+amdgpu_userq_queue_reset_helper(struct amdgpu_userq_mgr *uq_mgr,
+				struct amdgpu_usermode_queue *queue)
+{
+	struct amdgpu_device *adev = uq_mgr->adev;
+	const struct amdgpu_userq_funcs *userq_funcs =
+		adev->userq_funcs[queue->queue_type];
+	bool gpu_reset = false;
+	int r;
+
+	if (unlikely(adev->debug_disable_gpu_ring_reset)) {
+		dev_err(adev->dev, "userq reset disabled by debug mask\n");
+	} else if (amdgpu_gpu_recovery && userq_funcs->reset) {
+		r = userq_funcs->reset(uq_mgr, queue);
+		if (r) {
+			dev_err(adev->dev, "userq reset failed\n");
+			gpu_reset = true;
+		} else {
+			dev_err(adev->dev, "userq reset succeeded\n");
+			atomic_inc(&adev->gpu_reset_counter);
+			amdgpu_userq_fence_driver_force_completion(queue);
+			drm_dev_wedged_event(adev_to_drm(adev), DRM_WEDGE_RECOVERY_NONE);
+		}
+	} else if (amdgpu_gpu_recovery && !userq_funcs->reset) {
+		gpu_reset = true;
+	}
+
+	return gpu_reset;
+}
+
 static int
 amdgpu_userq_unmap_helper(struct amdgpu_userq_mgr *uq_mgr,
 			  struct amdgpu_usermode_queue *queue)
@@ -51,15 +92,22 @@ amdgpu_userq_unmap_helper(struct amdgpu_userq_mgr *uq_mgr,
 	struct amdgpu_device *adev = uq_mgr->adev;
 	const struct amdgpu_userq_funcs *userq_funcs =
 		adev->userq_funcs[queue->queue_type];
+	bool gpu_reset = false;
 	int r = 0;
 
 	if (queue->state == AMDGPU_USERQ_STATE_MAPPED) {
 		r = userq_funcs->unmap(uq_mgr, queue);
-		if (r)
+		if (r) {
 			queue->state = AMDGPU_USERQ_STATE_HUNG;
-		else
+			gpu_reset = amdgpu_userq_queue_reset_helper(uq_mgr, queue);
+		} else {
 			queue->state = AMDGPU_USERQ_STATE_UNMAPPED;
+		}
 	}
+
+	if (gpu_reset)
+		amdgpu_userq_gpu_reset(adev);
+
 	return r;
 }
 
@@ -70,16 +118,22 @@ amdgpu_userq_map_helper(struct amdgpu_userq_mgr *uq_mgr,
 	struct amdgpu_device *adev = uq_mgr->adev;
 	const struct amdgpu_userq_funcs *userq_funcs =
 		adev->userq_funcs[queue->queue_type];
+	bool gpu_reset = false;
 	int r = 0;
 
 	if (queue->state == AMDGPU_USERQ_STATE_UNMAPPED) {
 		r = userq_funcs->map(uq_mgr, queue);
 		if (r) {
 			queue->state = AMDGPU_USERQ_STATE_HUNG;
+			gpu_reset = amdgpu_userq_queue_reset_helper(uq_mgr, queue);
 		} else {
 			queue->state = AMDGPU_USERQ_STATE_MAPPED;
 		}
 	}
+
+	if (gpu_reset)
+		amdgpu_userq_gpu_reset(adev);
+
 	return r;
 }
 
@@ -698,6 +752,23 @@ amdgpu_userq_evict_all(struct amdgpu_userq_mgr *uq_mgr)
 	return ret;
 }
 
+void amdgpu_userq_reset_work(struct work_struct *work)
+{
+	struct amdgpu_device *adev = container_of(work, struct amdgpu_device,
+						  userq_reset_work);
+	struct amdgpu_reset_context reset_context;
+
+	memset(&reset_context, 0, sizeof(reset_context));
+
+	reset_context.method = AMD_RESET_METHOD_NONE;
+	reset_context.reset_req_dev = adev;
+	reset_context.src = AMDGPU_RESET_SRC_USERQ;
+	set_bit(AMDGPU_NEED_FULL_RESET, &reset_context.flags);
+	/*set_bit(AMDGPU_SKIP_COREDUMP, &reset_context.flags);*/
+
+	amdgpu_device_gpu_recover(adev, NULL, &reset_context);
+}
+
 static int
 amdgpu_userq_wait_for_signal(struct amdgpu_userq_mgr *uq_mgr)
 {
@@ -724,22 +795,19 @@ void
 amdgpu_userq_evict(struct amdgpu_userq_mgr *uq_mgr,
 		   struct amdgpu_eviction_fence *ev_fence)
 {
-	int ret;
 	struct amdgpu_fpriv *fpriv = uq_mgr_to_fpriv(uq_mgr);
 	struct amdgpu_eviction_fence_mgr *evf_mgr = &fpriv->evf_mgr;
+	struct amdgpu_device *adev = uq_mgr->adev;
+	int ret;
 
 	/* Wait for any pending userqueue fence work to finish */
 	ret = amdgpu_userq_wait_for_signal(uq_mgr);
-	if (ret) {
-		DRM_ERROR("Not evicting userqueue, timeout waiting for work\n");
-		return;
-	}
+	if (ret)
+		dev_err(adev->dev, "Not evicting userqueue, timeout waiting for work\n");
 
 	ret = amdgpu_userq_evict_all(uq_mgr);
-	if (ret) {
-		DRM_ERROR("Failed to evict userqueue\n");
-		return;
-	}
+	if (ret)
+		dev_err(adev->dev, "Failed to evict userqueue\n");
 
 	/* Signal current eviction fence */
 	amdgpu_eviction_fence_signal(evf_mgr, ev_fence);
@@ -914,3 +982,41 @@ int amdgpu_userq_start_sched_for_enforce_isolation(struct amdgpu_device *adev,
 	mutex_unlock(&adev->userq_mutex);
 	return ret;
 }
+
+void amdgpu_userq_pre_reset(struct amdgpu_device *adev)
+{
+	const struct amdgpu_userq_funcs *userq_funcs;
+	struct amdgpu_usermode_queue *queue;
+	struct amdgpu_userq_mgr *uqm, *tmp;
+	int queue_id;
+
+	mutex_lock(&adev->userq_mutex);
+	list_for_each_entry_safe(uqm, tmp, &adev->userq_mgr_list, list) {
+		cancel_delayed_work_sync(&uqm->resume_work);
+		mutex_lock(&uqm->userq_mutex);
+		idr_for_each_entry(&uqm->userq_idr, queue, queue_id) {
+			if (queue->state == AMDGPU_USERQ_STATE_MAPPED) {
+				amdgpu_userq_wait_for_last_fence(uqm, queue);
+				userq_funcs = adev->userq_funcs[queue->queue_type];
+				userq_funcs->unmap(uqm, queue);
+				/* just mark all queues as hung at this point.
+				 * if unmap succeeds, we could map again
+				 * in amdgpu_userq_post_reset() if vram is not lost
+				 */
+				queue->state = AMDGPU_USERQ_STATE_HUNG;
+				amdgpu_userq_fence_driver_force_completion(queue);
+			}
+		}
+		mutex_unlock(&uqm->userq_mutex);
+	}
+	mutex_unlock(&adev->userq_mutex);
+}
+
+int amdgpu_userq_post_reset(struct amdgpu_device *adev, bool vram_lost)
+{
+	/* if any queue state is AMDGPU_USERQ_STATE_UNMAPPED
+	 * at this point, we should be able to map it again
+	 * and continue if vram is not lost.
+	 */
+	return 0;
+}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
index 24d201cdc9887..6ede08dd821d2 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
@@ -132,4 +132,9 @@ int amdgpu_userq_stop_sched_for_enforce_isolation(struct amdgpu_device *adev,
 int amdgpu_userq_start_sched_for_enforce_isolation(struct amdgpu_device *adev,
 						   u32 idx);
 
+void amdgpu_userq_reset_work(struct work_struct *work);
+
+void amdgpu_userq_pre_reset(struct amdgpu_device *adev);
+int amdgpu_userq_post_reset(struct amdgpu_device *adev, bool vram_lost);
+
 #endif
-- 
2.49.0

