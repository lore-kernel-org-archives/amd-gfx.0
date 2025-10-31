Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD510CCF9F0
	for <amd-gfx@archiver.kernel.org>; Fri, 31 Oct 2025 01:09:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7411510EA8D;
	Fri, 31 Oct 2025 01:09:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Y4j9FY6E";
	dkim-atps=neutral
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010070.outbound.protection.outlook.com [52.101.61.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 62E3610EA8D
 for <amd-gfx@lists.freedesktop.org>; Fri, 31 Oct 2025 01:09:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=L7wdp0sE7O/lOsHqAlw09mV10L2IHSqhCGGK6hXUTjnAb4D7zhtmv5+yXbuG3DI1hjKQbxAW6bFWcGclgVyCHvrQH+gTjGqHxr8N28NXSeIQvPBFqEDtyOYz/m1Sf+6hjkjm+AaNc5uEiz2XXP/P+Mqto7ifZ35ilxNo81KrVINkG9X5nCXkJxamdJAi4OI1CdtJPutAObSGcticPYEhVnUvS4o+ofeL8vZ/F9RvHPPk5Gowu9M7dk+QfBE7WizWOPUARNbm5QY7clYmpNxmKFBZhC4qOP8ae1c+qW/xotWbhNrLjYmNMi0RQYU9MKCHllfT3lg8th2fGOSdkBKs/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8MVFaQiPhaWcg9UmIbP5E5xGXv0xGpYfpomru6XkgmU=;
 b=n8erqr8bg6SC54U/Z05aBWMJ0zR5n78UALnw9w7pGzj3Jzu7Z+S82WLQ78pMc5H1J+188tQ1xkwBY649WSSxMYh2C9wYvZqwjYcPzk2ED++6MuBiOtHMPrFl2dwBJ+JVQfCtDD7S+197Azjs5YoV/aSKtGgQNA9FubfuBoM3YADSc6lEdxyhS4yTiRxZiyunXCjfcV0byrbIvsQyKDpLBT+d9REnQwLEWvO8ZhfdWDJ5Tp5ZQM7p/u7UTCL9QZYtqkBTa4/uDdMn8yXBSehPTnpPEH0ASgvyice8ai5OWWzfXQkXsGV+CiR+bDYs0f8ZzvcRCkZVvCA28WVHLXkFyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8MVFaQiPhaWcg9UmIbP5E5xGXv0xGpYfpomru6XkgmU=;
 b=Y4j9FY6EF3ejigs6LiA7+ftz85vQy/Ot1mvYrCT91t+UIWzQfyr21pnOtw7g1ZhHZMQFpadoc/mLwNloNdr1S8itwST8czIUZMEHu6S+wPBevM9+Z8Nj5xcXOqOLFe3dX0PERo/pxixo1VoDd04U+GVRQttK/Qbf4VkpV2LgGhM=
Received: from BN9PR03CA0616.namprd03.prod.outlook.com (2603:10b6:408:106::21)
 by DM6PR12MB4073.namprd12.prod.outlook.com (2603:10b6:5:217::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.14; Fri, 31 Oct
 2025 01:09:36 +0000
Received: from BN3PEPF0000B070.namprd21.prod.outlook.com
 (2603:10b6:408:106:cafe::51) by BN9PR03CA0616.outlook.office365.com
 (2603:10b6:408:106::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9275.15 via Frontend Transport; Fri,
 31 Oct 2025 01:09:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BN3PEPF0000B070.mail.protection.outlook.com (10.167.243.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9298.0 via Frontend Transport; Fri, 31 Oct 2025 01:09:35 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 30 Oct
 2025 18:09:33 -0700
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 30 Oct
 2025 18:09:32 -0700
Received: from JesseDEV.guestwireless.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17
 via Frontend Transport; Thu, 30 Oct 2025 18:09:26 -0700
From: Jesse.Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 Jesse.Zhang <Jesse.Zhang@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH] drm/amdgpu: Implement user queue reset functionality
Date: Fri, 31 Oct 2025 09:08:39 +0800
Message-ID: <20251031010910.3414823-1-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B070:EE_|DM6PR12MB4073:EE_
X-MS-Office365-Filtering-Correlation-Id: f92b9b11-c8f8-44f6-a2fc-08de181a2862
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Fm49b674ivXRJjaJYsWTtf/DY7Ezw8IhNekRdjY2v41z7Jz2rMX6uCv5Trpk?=
 =?us-ascii?Q?9FtVeQnqcMT1qvK8oSEVE0WkW6lpyDgXVFYZt9IwGShMKmBNfwQYL7d2D+mH?=
 =?us-ascii?Q?YArqzYnlnijnVOA34FnvnHiyB0j+UAnYvNYXTJU27+gUlnuj6fmVHzQZXczo?=
 =?us-ascii?Q?21ELrgAVDBqt5JJCT/g3EvX9UZWwH4o5bXMEyOOkyHb4pWzIXBsKwKz901JI?=
 =?us-ascii?Q?+cqs+inZF0ONX/KK+i8x41XvOk+P46bWRnpshejf2SxQgLBotMccCPh5XS7p?=
 =?us-ascii?Q?QrcbM/gVTdD+2sn5sdf/7guuy6bg9ibz0pBjDXVaOcXPJ1s2hq0V3M7PDq83?=
 =?us-ascii?Q?zixjRrknIdoPWEXKaQgkOAmCC+jBTn265Q0LK0xo/qPeffcp+UBdIwQDSnFU?=
 =?us-ascii?Q?GoBN6CcvQSClrVs8T/N6pCuh/723X/Qe11E6IiIVmInXMw/1ARWMAboiVI+k?=
 =?us-ascii?Q?sekVviQ1+++WCH+voRTtQ0lRHJdUWhLKcBiSDufSoWUZviI1nd4nLPRLOLqq?=
 =?us-ascii?Q?ImZKo7ay3MavWA4GUQeReJAH6VtiANSpPTAXoYxdZm9+wK5Z0nARiZHi8izZ?=
 =?us-ascii?Q?4vJE4SRISAzx78R0L5HISsn66TdKmxusm+zeTeuiwx+AICThIlSTEDTGGleq?=
 =?us-ascii?Q?rd6uXDRTipmKPGJ/e/vWYXFHLgBwhsl2utYNwGG6s619K8SXE7GdTYTBPSrl?=
 =?us-ascii?Q?jCmpKvmTNoP/x668Ome6sQVghNg917hN9Cx+fY7z7hohJUWeZ7FFiGM0HdLY?=
 =?us-ascii?Q?TDHAiindYK5BWDIESLYJ1LXRSJIKhUnsqWrApGs++qisjznWjsUMk6u4mpk1?=
 =?us-ascii?Q?XfeZNBoHU/uZjN8CnLyhqFOHz//U5H557w8Vd9xYBsTbB72e5AoORYiYBFgY?=
 =?us-ascii?Q?gQwQbemFym7rblwsI+95smbeyR17qtjEzasPN9oR61cffmc0saFLsBXOH87J?=
 =?us-ascii?Q?Bw3+mt1cnWsGD1ouHwulf9Pdla0e8/4DCkQY/JtUbaTCmMCSLEl6LPNLJmtS?=
 =?us-ascii?Q?2K19KKu4CgmD9LuiYMKgYkRikJQo7TA+OIMYMzMnaTPH/VIzJKaDzCufQ2c7?=
 =?us-ascii?Q?vcDe9Zb2v1kkrEeooJSvXITqfdytea8DMz050tXwS5Ht3wchws5Fh1mrd94x?=
 =?us-ascii?Q?QgJKHSrfxUDUyhNdaAZHLca3DyDkTmRmIU+IibBB1kzij0Yls7MndeeSwHIU?=
 =?us-ascii?Q?iCtMwnO1zUyxYeXuf+jn9rI3tKtjUlvUUBP1ZY6x91tS+YClR8GW5/DJOB0a?=
 =?us-ascii?Q?7rJl/e1r6nbk46verXHNPwUYvFIzlV6bqG8ZixhOnWQ4OeB/zwIdRWa8imii?=
 =?us-ascii?Q?TVbMejfPiml/R6oT3EXwHCqjo4/JNSdUuZyZdpQtFV2N/CI/WsZ6CB4IZ59e?=
 =?us-ascii?Q?TP+dX/3+N9/DAgRQakNx9nrddQXVD8cyUFzDMUjcQTMZ5CNLq2xoa7ykIn30?=
 =?us-ascii?Q?wW7Lb4r4Fx/XFlUeag+9Os0ECwIY45Za83+4odoaZGU8HNsF71WN50M8iHH4?=
 =?us-ascii?Q?WIGXhtdi6nfqy316k4yds4dbiPy3ckUhkmBmWfS8i91qfiN/2U9RIg2/13Po?=
 =?us-ascii?Q?uJy4PDrWk/TVFlkWPUI=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2025 01:09:35.8520 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f92b9b11-c8f8-44f6-a2fc-08de181a2862
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B070.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4073
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

This patch adds robust reset handling for user queues (userq) to improve
recovery from queue failures. The key components include:

1. Queue detection and reset logic:
   - amdgpu_userq_detect_and_reset_queues() identifies failed queues
   - Per-IP detect_and_reset callbacks for targeted recovery
   - Falls back to full GPU reset when needed

2. Reset infrastructure:
   - Adds userq_reset_work workqueue for async reset handling
   - Implements pre/post reset handlers for queue state management
   - Integrates with existing GPU reset framework

3. Error handling improvements:
   - Enhanced state tracking with HUNG state
   - Automatic reset triggering on critical failures
   - VRAM loss handling during recovery

4. Integration points:
   - Added to device init/reset paths
   - Called during queue destroy, suspend, and isolation events
   - Handles both individual queue and full GPU resets

The reset functionality works with both gfx/compute and sdma queues,
providing better resilience against queue failures while minimizing
disruption to unaffected queues.

v2: add detection and reset calls when preemption/unmaped fails.
    add a per device userq counter for each user queue type.(Alex)
v3: make sure we hold the adev->userq_mutex when we call amdgpu_userq_detect_and_reset_queues. (Alex)
   warn if the adev->userq_mutex is not held.
v4: make sure we have all of the uqm->userq_mutex held.
   warn if the uqm->userq_mutex is not held.

v5: Use array for user queue type counters.(Alex)
    all of the uqm->userq_mutex need to be held when calling detect and reset.  (Alex)

v6: fix lock dep warning in amdgpu_userq_fence_dence_driver_process

v7: add the queue types in an array and use a loop in amdgpu_userq_detect_and_reset_queues (Lijo)
v8: remove atomic_set(&userq_mgr->userq_count[i], 0).
   it should already be 0 since we kzalloc the structure (Alex)
v9: For consistency with kernel queues, We may want something like:
   amdgpu_userq_is_reset_type_supported (Alex)

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h        |   1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c |   8 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h   |   1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c  | 215 +++++++++++++++++++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h  |   5 +
 5 files changed, 218 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index bcfed46eedaf..9f9774f58ce1 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -1316,6 +1316,7 @@ struct amdgpu_device {
 	bool                            apu_prefer_gtt;
 
 	bool                            userq_halt_for_enforce_isolation;
+	struct work_struct              userq_reset_work;
 	struct amdgpu_uid *uid_info;
 
 	/* KFD
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 962380af4ee9..9506296b50c9 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -4607,6 +4607,7 @@ int amdgpu_device_init(struct amdgpu_device *adev,
 	}
 
 	INIT_WORK(&adev->xgmi_reset_work, amdgpu_device_xgmi_reset_func);
+	INIT_WORK(&adev->userq_reset_work, amdgpu_userq_reset_work);
 
 	adev->gfx.gfx_off_req_count = 1;
 	adev->gfx.gfx_off_residency = 0;
@@ -5989,6 +5990,10 @@ int amdgpu_device_reinit_after_reset(struct amdgpu_reset_context *reset_context)
 				if (r)
 					goto out;
 
+				r = amdgpu_userq_post_reset(tmp_adev, vram_lost);
+				if (r)
+					goto out;
+
 				drm_client_dev_resume(adev_to_drm(tmp_adev), false);
 
 				/*
@@ -6211,6 +6216,7 @@ static inline void amdgpu_device_stop_pending_resets(struct amdgpu_device *adev)
 	if (!amdgpu_sriov_vf(adev))
 		cancel_work(&adev->reset_work);
 #endif
+	cancel_work(&adev->userq_reset_work);
 
 	if (adev->kfd.dev)
 		cancel_work(&adev->kfd.reset_work);
@@ -6331,6 +6337,8 @@ static void amdgpu_device_halt_activities(struct amdgpu_device *adev,
 		    amdgpu_device_ip_need_full_reset(tmp_adev))
 			amdgpu_ras_suspend(tmp_adev);
 
+		amdgpu_userq_pre_reset(tmp_adev);
+
 		for (i = 0; i < AMDGPU_MAX_RINGS; ++i) {
 			struct amdgpu_ring *ring = tmp_adev->rings[i];
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
index 87b962df5460..7a27c6c4bb44 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
@@ -83,6 +83,7 @@ enum amdgpu_ring_type {
 	AMDGPU_RING_TYPE_MES,
 	AMDGPU_RING_TYPE_UMSCH_MM,
 	AMDGPU_RING_TYPE_CPER,
+	AMDGPU_RING_TYPE_MAX,
 };
 
 enum amdgpu_ib_pool_type {
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
index cc2f96ed7004..ce96a9a22b9b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
@@ -25,8 +25,10 @@
 #include <drm/drm_auth.h>
 #include <drm/drm_exec.h>
 #include <linux/pm_runtime.h>
+#include <drm/drm_drv.h>
 
 #include "amdgpu.h"
+#include "amdgpu_reset.h"
 #include "amdgpu_vm.h"
 #include "amdgpu_userq.h"
 #include "amdgpu_hmm.h"
@@ -46,6 +48,108 @@ u32 amdgpu_userq_get_supported_ip_mask(struct amdgpu_device *adev)
 	return userq_ip_mask;
 }
 
+static bool amdgpu_userq_is_reset_type_supported(struct amdgpu_device *adev,
+                                         enum amdgpu_ring_type ring_type,
+                                         int reset_type)
+{
+
+	if (ring_type < 0 || ring_type >= AMDGPU_RING_TYPE_MAX)
+		return false;
+
+	switch (ring_type) {
+	case AMDGPU_RING_TYPE_GFX:
+		if (adev->gfx.gfx_supported_reset & reset_type)
+			return true;
+		break;
+	case AMDGPU_RING_TYPE_COMPUTE:
+		if (adev->gfx.compute_supported_reset & reset_type)
+			return true;
+		break;
+	case AMDGPU_RING_TYPE_SDMA:
+		if (adev->sdma.supported_reset & reset_type)
+			return true;
+		break;
+	case AMDGPU_RING_TYPE_VCN_DEC:
+	case AMDGPU_RING_TYPE_VCN_ENC:
+		if (adev->vcn.supported_reset & reset_type)
+			return true;
+		break;
+	case AMDGPU_RING_TYPE_VCN_JPEG:
+		if (adev->jpeg.supported_reset & reset_type)
+			return true;
+		break;
+	default:
+		break;
+	}
+	return false;
+}
+
+static void amdgpu_userq_gpu_reset(struct amdgpu_device *adev)
+{
+	if (amdgpu_device_should_recover_gpu(adev)) {
+		amdgpu_reset_domain_schedule(adev->reset_domain,
+					     &adev->userq_reset_work);
+		/* Wait for the reset job to complete */
+		flush_work(&adev->userq_reset_work);
+	}
+}
+
+static int
+amdgpu_userq_detect_and_reset_queues(struct amdgpu_userq_mgr *uq_mgr)
+{
+	struct amdgpu_device *adev = uq_mgr->adev;
+	const int queue_types[] = {
+		AMDGPU_RING_TYPE_COMPUTE,
+		AMDGPU_RING_TYPE_GFX,
+		AMDGPU_RING_TYPE_SDMA
+	};
+	const int num_queue_types = ARRAY_SIZE(queue_types);
+	bool gpu_reset = false;
+	int r = 0;
+	int i;
+
+	/* Warning if current process mutex is not held */
+	WARN_ON(!mutex_is_locked(&uq_mgr->userq_mutex));
+
+	if (unlikely(adev->debug_disable_gpu_ring_reset)) {
+		dev_err(adev->dev, "userq reset disabled by debug mask\n");
+		return 0;
+	}
+
+	/*
+	 * If GPU recovery feature is disabled system-wide,
+	 * skip all reset detection logic
+	 */
+	if (!amdgpu_gpu_recovery)
+		return 0;
+
+	/*
+	 * Iterate through all queue types to detect and reset problematic queues
+	 * Process each queue type in the defined order
+	 */
+	for (i = 0; i < num_queue_types; i++) {
+		int ring_type = queue_types[i];
+		const struct amdgpu_userq_funcs *funcs = adev->userq_funcs[ring_type];
+
+		if (!amdgpu_userq_is_reset_type_supported(adev, ring_type, AMDGPU_RESET_TYPE_PER_QUEUE))
+				continue;
+
+		if (atomic_read(&uq_mgr->userq_count[ring_type]) > 0 &&
+		    funcs && funcs->detect_and_reset) {
+			r = funcs->detect_and_reset(adev, ring_type);
+			if (r) {
+				gpu_reset = true;
+				break;
+			}
+		}
+	}
+
+	if (gpu_reset)
+		amdgpu_userq_gpu_reset(adev);
+
+	return r;
+}
+
 static int amdgpu_userq_buffer_va_list_add(struct amdgpu_usermode_queue *queue,
 					   struct amdgpu_bo_va_mapping *va_map, u64 addr)
 {
@@ -176,17 +280,22 @@ amdgpu_userq_preempt_helper(struct amdgpu_userq_mgr *uq_mgr,
 	struct amdgpu_device *adev = uq_mgr->adev;
 	const struct amdgpu_userq_funcs *userq_funcs =
 		adev->userq_funcs[queue->queue_type];
+	bool found_hung_queue = false;
 	int r = 0;
 
 	if (queue->state == AMDGPU_USERQ_STATE_MAPPED) {
 		r = userq_funcs->preempt(uq_mgr, queue);
 		if (r) {
 			queue->state = AMDGPU_USERQ_STATE_HUNG;
+			found_hung_queue = true;
 		} else {
 			queue->state = AMDGPU_USERQ_STATE_PREEMPTED;
 		}
 	}
 
+	if (found_hung_queue)
+		amdgpu_userq_detect_and_reset_queues(uq_mgr);
+
 	return r;
 }
 
@@ -218,16 +327,23 @@ amdgpu_userq_unmap_helper(struct amdgpu_userq_mgr *uq_mgr,
 	struct amdgpu_device *adev = uq_mgr->adev;
 	const struct amdgpu_userq_funcs *userq_funcs =
 		adev->userq_funcs[queue->queue_type];
+	bool found_hung_queue = false;
 	int r = 0;
 
 	if ((queue->state == AMDGPU_USERQ_STATE_MAPPED) ||
 		(queue->state == AMDGPU_USERQ_STATE_PREEMPTED)) {
 		r = userq_funcs->unmap(uq_mgr, queue);
-		if (r)
+		if (r) {
 			queue->state = AMDGPU_USERQ_STATE_HUNG;
-		else
+			found_hung_queue = true;
+		} else {
 			queue->state = AMDGPU_USERQ_STATE_UNMAPPED;
+		}
 	}
+
+	if (found_hung_queue)
+		amdgpu_userq_detect_and_reset_queues(uq_mgr);
+
 	return r;
 }
 
@@ -244,10 +360,12 @@ amdgpu_userq_map_helper(struct amdgpu_userq_mgr *uq_mgr,
 		r = userq_funcs->map(uq_mgr, queue);
 		if (r) {
 			queue->state = AMDGPU_USERQ_STATE_HUNG;
+			amdgpu_userq_detect_and_reset_queues(uq_mgr);
 		} else {
 			queue->state = AMDGPU_USERQ_STATE_MAPPED;
 		}
 	}
+
 	return r;
 }
 
@@ -475,10 +593,11 @@ amdgpu_userq_destroy(struct drm_file *filp, int queue_id)
 		amdgpu_bo_unreserve(queue->db_obj.obj);
 	}
 	amdgpu_bo_unref(&queue->db_obj.obj);
-
+	atomic_dec(&uq_mgr->userq_count[queue->queue_type]);
 #if defined(CONFIG_DEBUG_FS)
 	debugfs_remove_recursive(queue->debugfs_queue);
 #endif
+	amdgpu_userq_detect_and_reset_queues(uq_mgr);
 	r = amdgpu_userq_unmap_helper(uq_mgr, queue);
 	/*TODO: It requires a reset for userq hw unmap error*/
 	if (unlikely(r != AMDGPU_USERQ_STATE_UNMAPPED)) {
@@ -700,6 +819,7 @@ amdgpu_userq_create(struct drm_file *filp, union drm_amdgpu_userq *args)
 	kfree(queue_name);
 
 	args->out.queue_id = qid;
+	atomic_inc(&uq_mgr->userq_count[queue->queue_type]);
 
 unlock:
 	mutex_unlock(&uq_mgr->userq_mutex);
@@ -1044,6 +1164,7 @@ amdgpu_userq_evict_all(struct amdgpu_userq_mgr *uq_mgr)
 	unsigned long queue_id;
 	int ret = 0, r;
 
+	amdgpu_userq_detect_and_reset_queues(uq_mgr);
 	/* Try to unmap all the queues in this process ctx */
 	xa_for_each(&uq_mgr->userq_mgr_xa, queue_id, queue) {
 		r = amdgpu_userq_preempt_helper(uq_mgr, queue);
@@ -1056,6 +1177,23 @@ amdgpu_userq_evict_all(struct amdgpu_userq_mgr *uq_mgr)
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
@@ -1083,22 +1221,19 @@ void
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
-		drm_file_err(uq_mgr->file, "Not evicting userqueue, timeout waiting for work\n");
-		return;
-	}
+	if (ret)
+		dev_err(adev->dev, "Not evicting userqueue, timeout waiting for work\n");
 
 	ret = amdgpu_userq_evict_all(uq_mgr);
-	if (ret) {
-		drm_file_err(uq_mgr->file, "Failed to evict userqueue\n");
-		return;
-	}
+	if (ret)
+		dev_err(adev->dev, "Failed to evict userqueue\n");
 
 	/* Signal current eviction fence */
 	amdgpu_eviction_fence_signal(evf_mgr, ev_fence);
@@ -1132,6 +1267,7 @@ void amdgpu_userq_mgr_fini(struct amdgpu_userq_mgr *userq_mgr)
 	cancel_delayed_work_sync(&userq_mgr->resume_work);
 
 	mutex_lock(&userq_mgr->userq_mutex);
+	amdgpu_userq_detect_and_reset_queues(userq_mgr);
 	xa_for_each(&userq_mgr->userq_mgr_xa, queue_id, queue) {
 		amdgpu_userq_wait_for_last_fence(userq_mgr, queue);
 		amdgpu_userq_unmap_helper(userq_mgr, queue);
@@ -1158,6 +1294,7 @@ int amdgpu_userq_suspend(struct amdgpu_device *adev)
 		uqm = queue->userq_mgr;
 		cancel_delayed_work_sync(&uqm->resume_work);
 		guard(mutex)(&uqm->userq_mutex);
+		amdgpu_userq_detect_and_reset_queues(uqm);
 		if (adev->in_s0ix)
 			r = amdgpu_userq_preempt_helper(uqm, queue);
 		else
@@ -1216,6 +1353,7 @@ int amdgpu_userq_stop_sched_for_enforce_isolation(struct amdgpu_device *adev,
 		if (((queue->queue_type == AMDGPU_HW_IP_GFX) ||
 		     (queue->queue_type == AMDGPU_HW_IP_COMPUTE)) &&
 		    (queue->xcp_id == idx)) {
+			amdgpu_userq_detect_and_reset_queues(uqm);
 			r = amdgpu_userq_preempt_helper(uqm, queue);
 			if (r)
 				ret = r;
@@ -1288,3 +1426,56 @@ int amdgpu_userq_gem_va_unmap_validate(struct amdgpu_device *adev,
 
 	return 0;
 }
+
+void amdgpu_userq_pre_reset(struct amdgpu_device *adev)
+{
+	const struct amdgpu_userq_funcs *userq_funcs;
+	struct amdgpu_usermode_queue *queue;
+	struct amdgpu_userq_mgr *uqm;
+	unsigned long queue_id;
+
+	xa_for_each(&adev->userq_doorbell_xa, queue_id, queue) {
+		uqm = queue->userq_mgr;
+		cancel_delayed_work_sync(&uqm->resume_work);
+		if (queue->state == AMDGPU_USERQ_STATE_MAPPED) {
+			amdgpu_userq_wait_for_last_fence(uqm, queue);
+			userq_funcs = adev->userq_funcs[queue->queue_type];
+			userq_funcs->unmap(uqm, queue);
+			/* just mark all queues as hung at this point.
+			 * if unmap succeeds, we could map again
+			 * in amdgpu_userq_post_reset() if vram is not lost
+			 */
+			queue->state = AMDGPU_USERQ_STATE_HUNG;
+			amdgpu_userq_fence_driver_force_completion(queue);
+		}
+	}
+}
+
+int amdgpu_userq_post_reset(struct amdgpu_device *adev, bool vram_lost)
+{
+	/* if any queue state is AMDGPU_USERQ_STATE_UNMAPPED
+	 * at this point, we should be able to map it again
+	 * and continue if vram is not lost.
+	 */
+	struct amdgpu_userq_mgr *uqm;
+	struct amdgpu_usermode_queue *queue;
+	const struct amdgpu_userq_funcs *userq_funcs;
+	unsigned long queue_id;
+	int r = 0;
+
+	xa_for_each(&adev->userq_doorbell_xa, queue_id, queue) {
+		uqm = queue->userq_mgr;
+		if (queue->state == AMDGPU_USERQ_STATE_HUNG && !vram_lost) {
+			userq_funcs = adev->userq_funcs[queue->queue_type];
+			/* Re-map queue */
+			r = userq_funcs->map(uqm, queue);
+			if (r) {
+				dev_err(adev->dev, "Failed to remap queue %ld\n", queue_id);
+				continue;
+			}
+			queue->state = AMDGPU_USERQ_STATE_MAPPED;
+		}
+	}
+
+	return r;
+}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
index 09da0617bfa2..c37444427a14 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
@@ -106,6 +106,7 @@ struct amdgpu_userq_mgr {
 	struct amdgpu_device		*adev;
 	struct delayed_work		resume_work;
 	struct drm_file			*file;
+	atomic_t                        userq_count[AMDGPU_RING_TYPE_MAX];
 };
 
 struct amdgpu_db_info {
@@ -148,6 +149,10 @@ int amdgpu_userq_stop_sched_for_enforce_isolation(struct amdgpu_device *adev,
 						  u32 idx);
 int amdgpu_userq_start_sched_for_enforce_isolation(struct amdgpu_device *adev,
 						   u32 idx);
+void amdgpu_userq_reset_work(struct work_struct *work);
+void amdgpu_userq_pre_reset(struct amdgpu_device *adev);
+int amdgpu_userq_post_reset(struct amdgpu_device *adev, bool vram_lost);
+
 int amdgpu_userq_input_va_validate(struct amdgpu_usermode_queue *queue,
 				   u64 addr, u64 expected_size);
 int amdgpu_userq_gem_va_unmap_validate(struct amdgpu_device *adev,
-- 
2.49.0

