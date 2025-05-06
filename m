Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBA9AC3ABBC
	for <amd-gfx@archiver.kernel.org>; Tue,  6 May 2025 15:59:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6C2E810E6FC;
	Tue,  6 May 2025 15:59:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="H3h1Nv/6";
	dkim-atps=neutral
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2051.outbound.protection.outlook.com [40.107.95.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B8C7E10E6F8
 for <amd-gfx@lists.freedesktop.org>; Tue,  6 May 2025 15:59:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k2jMmAnBGXbCOdNulOIh/Qy2RN2ufI9Y5z3h3GoQ5L4C4m7X1gygOSgFJiqxURz6eDL43wDG+5oSrnkNjXz+H5HJKQwIkI92tMye0qnxPYE8RZrOpjpoRlJNHIUr4X2lOj3fThehww0TIP0+RMBBeRqVzYRLksrG1ksYnfhyNPYdmRNuIVRs+0rT2fhTIj2sJjxRi+FsAqw6LC32cYKpayvcYeIL1c+7VNQsMEutekq2d2dzSwDP8PrvDA3CM3d63QnhlQ7wyxFwtbmAOCpcBIJb6wT/tkSvcjpq4Fjv/5bmVddzqGP04I5R8l6IL/Gix/UPRIgjDzGHaPOa2EcXyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=idkTKw+W9VMaqTwG3o0TMX/FAHkVIx7a4g/0RjWat2o=;
 b=sT5KM0oVOA4rGJ5ucQIiMF28JpdQ7rTxuLZ3MSSUfnQDl81E30sfT691KbEkD2iZvpp0OABPyQJkPTN8fK6cy2o3sFXvo+QtNejgpGUwp/i+40rTSGyM7qVQpyBmNsvBMXHU4clI2W/KXuEPcOuViYtwSvDAN0jexKqp49I0f9cJc32rqydkISi9JC1vrptbUwsuyIF1SmD1TwkY+RWJitwUboZCH3Smq/nw9d55QXmJfkfEeak95FD6BJT1ITHGc6a0yoWcwKNyNoMzonGYHz2tQxKbDXTYocK+URg1BW+oBqrdTt9NE4RqvsjYgcJRjagRwo6QEhe0APiJhGhPlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=idkTKw+W9VMaqTwG3o0TMX/FAHkVIx7a4g/0RjWat2o=;
 b=H3h1Nv/6z7CuS7i1mKvgvQ5dxzxiYm5Po/wKvB/aEW2QHdWM0uSlq7IRiUFhddn8w0IfJAs6BvYacqL1vfAlHKmNFnwbtHKyprAO0CSl1H0X4B+hQ70w2OShMX1fulNCM22X00G5CYFwUHQVWiVF/1lAtolehmLtfe3YSXuY3WI=
Received: from BN9PR03CA0222.namprd03.prod.outlook.com (2603:10b6:408:f8::17)
 by IA1PR12MB7688.namprd12.prod.outlook.com (2603:10b6:208:420::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.19; Tue, 6 May
 2025 15:59:18 +0000
Received: from BL02EPF00021F6C.namprd02.prod.outlook.com
 (2603:10b6:408:f8:cafe::9f) by BN9PR03CA0222.outlook.office365.com
 (2603:10b6:408:f8::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8699.31 via Frontend Transport; Tue,
 6 May 2025 15:59:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF00021F6C.mail.protection.outlook.com (10.167.249.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8722.18 via Frontend Transport; Tue, 6 May 2025 15:59:17 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 6 May
 2025 10:59:16 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, Sunil Khatri
 <sunil.khatri@amd.com>
Subject: [PATCH 5/7] drm/amdgpu/userq: implement resets
Date: Tue, 6 May 2025 11:58:57 -0400
Message-ID: <20250506155900.3866874-5-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250506155900.3866874-1-alexander.deucher@amd.com>
References: <20250506155900.3866874-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF00021F6C:EE_|IA1PR12MB7688:EE_
X-MS-Office365-Filtering-Correlation-Id: 69648aca-da41-424f-c416-08dd8cb6f513
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?QnRBME5NSXUxQWpXNENhb0M3cWgyOGlqR0xRSXI4M2hZcWpPNTcrT096VkVM?=
 =?utf-8?B?YmhKZXkyNUVMOUZoN3NBVWpxQ2FwU3MxMjJIWm9mbjI3NVR1NjlGQm9CbThn?=
 =?utf-8?B?Vm9BT0ZXandDcDVTQk1ub2VETDVEb1YxZFpWQTBadVVZU0V3R2RUVnYyakw3?=
 =?utf-8?B?K0xNRXBjenhEaTBIYmlGMlAvRVlSWG9PRE9sVHVycDVyVGRSMTU3dk1NYjJE?=
 =?utf-8?B?L21sZk9FVzRzZjVwZHE5SG5EWnFWd0lHbnFqL3d3RndodmRnLzFaZTJCUmZr?=
 =?utf-8?B?R3daMDlYVTFhY1B4VmFFZGFsaWJBeXM2K3JNKzN6VFh4UDJMTU1jbUsxNXBR?=
 =?utf-8?B?Qkd5Y2JTZUJRa3lDZlIvWEdNOEQ4MlVycmVoUi9YZ2x6TGMzR1FWRWRiblZy?=
 =?utf-8?B?dFRvVWE3SHNBWWVTTDR6S2ZJNWk4eUkrb0hlNHQvbXpKTjhnVWVzeUVscC9V?=
 =?utf-8?B?NXM2ZllrRERqc1pzaXordy9lZVRyUHJCMFduUjhKTlZFS0plQXgzRVBhS2dL?=
 =?utf-8?B?MjA5dVBmVXB4Z0ZraTF6WnBuU1VkSHRXTHEyWE5SNjZwNy81RFBzUVhaZ3Na?=
 =?utf-8?B?ZitDcllEclA0S1JzOE9nOEJuVVdndjhmZWQ4aE1sTC9GYzRTZjNkK2poUVM1?=
 =?utf-8?B?c21WRE1aWm9ZenFhSW1Jek9JOUZUNEtVZk9icXBtN3pRQmdyVWJxWmk3aklQ?=
 =?utf-8?B?ZEJwRDk1RGdLM2tiUzdQcTFZZVVtU3dmUUFUNU1QeGJhc3kvekR3VGZ5NTlL?=
 =?utf-8?B?QlVqUU1DVnVwK05SbGYwQVcxaUtEU0QyRFI1UERiNmRqb2U1c0VkWDY3OGdp?=
 =?utf-8?B?cUwyK1pEeTVDb09aMU5PdEpZSERyQlRTUXJYQU51Zmx0cnVpNFdVUWdxUXlT?=
 =?utf-8?B?SDhHd1NoQmJvQUc3OTc1WWZVMTBuMWxhd2NhU05WQkRmVTR2aEJSdnhNa0Nv?=
 =?utf-8?B?WHZ3dTBzQldRZCs3RWgwWVB6aGFKRGlKMUtZcENGSjFwbzlsQktiM1o2OHBD?=
 =?utf-8?B?bVhwVTdQLytNRUdoK0xsSUk4Ti91czEreFZOR3RGVEpnT0FVM1NnalNlS3NY?=
 =?utf-8?B?TEl6RTNXRXRkTDJ0SEVIc1lESU9BcXpkT3hoQlBMOXB5bzVSOXR2NU5veHpQ?=
 =?utf-8?B?L0RYZjI3QVFYbW9TWUxEWXRXdjNMb1BaYnpIbEVZc2U0T3JnMFFhdm96Wmp0?=
 =?utf-8?B?TlhGNm53Y3VLMG1Ga2oweUNwV1YwMUttS3hUdWNudGRFSzZENTNYanI1MW1j?=
 =?utf-8?B?ajA1UnlBdmVDYWdkekdrMFhhNzlMdW1tS3F5WmVxRlZXZFBxbWF5NkFmRGdI?=
 =?utf-8?B?akdxOGlGWkFNNHgvc2lHL001WlFBck5Lci91WFlYTU9zRHl3VllNSVNEWk1P?=
 =?utf-8?B?d3FlYmhxYU9IWVBxSExwL1FkUmc2ZUIrQUNKKzVXekxWQkhTMEJkUEowZVQ0?=
 =?utf-8?B?LzQ2bXdxei9tSG5meEhJNXROTFpZVWIwRVlYcFMxMzJib1gzWFM5T0JnZHo0?=
 =?utf-8?B?NjdxOEIrZ3NQUi96VUVFcFhlaVk3WG4xWHRCRFI0RkQ3OWNaRGVTUVRvc2pr?=
 =?utf-8?B?ZXV6VjJyTDlrUW5XSWtsTlRlaDlId01RaWNuWnF5VklBbEpuNEFud0JHby9H?=
 =?utf-8?B?MWg5VzJSRWozdmhMT1JzeVoyMzB5dG1HWkhVZUlEQm9CcURjdXk2ZGpEUzBt?=
 =?utf-8?B?azZ2ZXZaUnpLTUYxNzV5VUxJTXc5QVB6RDAwVUdFY1V6WTFuMExZSGFTYita?=
 =?utf-8?B?dVYxUXVmcjZFNW9aOUJaU2NxQi9NaEFlUlVWYkIyVktyc3dLbWxnaDZtQTZt?=
 =?utf-8?B?dktGVGVaL1NpZmptTVdLNWVPMXVuSDZHUFVkb2JiaXovZ3RjZGluWjV0aFR4?=
 =?utf-8?B?OGFvWFFhQVk5R3JUUzB0NXRGZTRTWXZxVEdLRS9ySmZ2QXpjWXhnMC9HMW5U?=
 =?utf-8?B?bGZ2N1ZIVmZ6V2pid0JBUWNZc3pTWE9FWjUzVXNvcE1veWswVnFBaStlZ21o?=
 =?utf-8?B?RUttOE53cDQ4WEMyeVJCS042dk41V200blVLVFVoeXM0VUp5LzAwV1czalkw?=
 =?utf-8?Q?ZS3wbu?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2025 15:59:17.9567 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 69648aca-da41-424f-c416-08dd8cb6f513
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF00021F6C.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7688
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

Acked-by: Christian König <christian.koenig@amd.com>
Reviewed-by: Sunil Khatri <sunil.khatri@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h        |   1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c |   8 ++
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c  | 123 +++++++++++++++++++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h  |   5 +
 4 files changed, 128 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index de57ab032cc70..ec49047e4cdd3 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -1302,6 +1302,7 @@ struct amdgpu_device {
 	struct list_head		userq_mgr_list;
 	struct mutex                    userq_mutex;
 	bool                            userq_halt_for_enforce_isolation;
+	struct work_struct		userq_reset_work;
 };
 
 static inline uint32_t amdgpu_ip_version(const struct amdgpu_device *adev,
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 8330e30f0cafe..8c738928091c0 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -4425,6 +4425,7 @@ int amdgpu_device_init(struct amdgpu_device *adev,
 	}
 
 	INIT_WORK(&adev->xgmi_reset_work, amdgpu_device_xgmi_reset_func);
+	INIT_WORK(&adev->userq_reset_work, amdgpu_userq_reset_work);
 
 	adev->gfx.gfx_off_req_count = 1;
 	adev->gfx.gfx_off_residency = 0;
@@ -5782,6 +5783,10 @@ int amdgpu_device_reinit_after_reset(struct amdgpu_reset_context *reset_context)
 				if (r)
 					goto out;
 
+				r = amdgpu_userq_post_reset(tmp_adev, vram_lost);
+				if (r)
+					goto out;
+
 				drm_client_dev_resume(adev_to_drm(tmp_adev), false);
 
 				/*
@@ -6004,6 +6009,7 @@ static inline void amdgpu_device_stop_pending_resets(struct amdgpu_device *adev)
 	if (!amdgpu_sriov_vf(adev))
 		cancel_work(&adev->reset_work);
 #endif
+	cancel_work(&adev->userq_reset_work);
 
 	if (adev->kfd.dev)
 		cancel_work(&adev->kfd.reset_work);
@@ -6114,6 +6120,8 @@ static int amdgpu_device_halt_activities(struct amdgpu_device *adev,
 		      amdgpu_device_ip_need_full_reset(tmp_adev))
 			amdgpu_ras_suspend(tmp_adev);
 
+		amdgpu_userq_pre_reset(tmp_adev);
+
 		for (i = 0; i < AMDGPU_MAX_RINGS; ++i) {
 			struct amdgpu_ring *ring = tmp_adev->rings[i];
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
index 394b036be1d9e..e09d0e5b9762a 100644
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
 
@@ -699,6 +753,23 @@ amdgpu_userq_evict_all(struct amdgpu_userq_mgr *uq_mgr)
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
@@ -725,22 +796,18 @@ void
 amdgpu_userq_evict(struct amdgpu_userq_mgr *uq_mgr,
 		   struct amdgpu_eviction_fence *ev_fence)
 {
-	int ret;
 	struct amdgpu_fpriv *fpriv = uq_mgr_to_fpriv(uq_mgr);
 	struct amdgpu_eviction_fence_mgr *evf_mgr = &fpriv->evf_mgr;
+	int ret;
 
 	/* Wait for any pending userqueue fence work to finish */
 	ret = amdgpu_userq_wait_for_signal(uq_mgr);
-	if (ret) {
+	if (ret)
 		drm_file_err(uq_mgr->file, "Not evicting userqueue, timeout waiting for work\n");
-		return;
-	}
 
 	ret = amdgpu_userq_evict_all(uq_mgr);
-	if (ret) {
+	if (ret)
 		drm_file_err(uq_mgr->file, "Failed to evict userqueue\n");
-		return;
-	}
 
 	/* Signal current eviction fence */
 	amdgpu_eviction_fence_signal(evf_mgr, ev_fence);
@@ -917,3 +984,41 @@ int amdgpu_userq_start_sched_for_enforce_isolation(struct amdgpu_device *adev,
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
index 3cc0ad8919f42..9d62befcdb24f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
@@ -134,4 +134,9 @@ int amdgpu_userq_stop_sched_for_enforce_isolation(struct amdgpu_device *adev,
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

