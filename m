Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B74E4C83F22
	for <amd-gfx@archiver.kernel.org>; Wed, 16 Jul 2025 11:01:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 55C7010E7A5;
	Wed, 16 Jul 2025 11:01:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="hx7KpG/A";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2089.outbound.protection.outlook.com [40.107.243.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C16EB10E7A4
 for <amd-gfx@lists.freedesktop.org>; Wed, 16 Jul 2025 11:01:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=O4+0xSecj4SFx6nQ+NH5BkvJ/HgTeEcbenb42bqqbcowZvCRB0/OKycRN9uwlmDCgqasziutxm0YVdAjSFmLMpNQlE1YzYy2VV0ELFXlnX6fGBDSe+bONjBCEusNtIkZ/EZGRg0iHIUF1Q+N6qLWbkjp1f6HKOifZvxYqXB9UlyWPBXMrItUzYN/816Qu2nnOllByw/9pfQPI65ZG70Hd5UibVVuIXpsCtsBxll0RCooUAqs6oc9CIo9nCSSOPpsh8Lv4jPF2i7J87/TIiobxLRQ2pEHxktNlWZ0UVSl6th1StyFjfK9uppnubVU0U9Xb26pVuIO2I3597A/Iwi+Fw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ntlr5jEFuMxfPGvvRikdcFYfXsH/89JEukIvq4CLDP4=;
 b=uIm+bNzFAUeP2yGDY6XwbcYCo/kH4R1xowwsRDBDOgcs4ROcMSCAxBjeOAqOTUnIoPh8FAwliaquwfI3K3xQzp8+lP86Teyq6pZdBjcfkBPauC4+YgUDbBxwsQr+24RTLSsfIQw+qPZzC9JmzGymVbX3sX6arcs5o54e/vulSQfnbUJnfWQ+pcUcZ/X3rSyRIDd9ucxovE35SG1AB0uhrlinIcbf+1ALohQjooNbYbeKPMx30Xy1CdRdMeUIqmxKfR1p7enztpGmJw1pgaswpoAFmcaHKeOztY0Hkqzu1yAjoRsVOo6soKFGsHFOsa/T5Burh0ks/+WOc7XIDJgXGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ntlr5jEFuMxfPGvvRikdcFYfXsH/89JEukIvq4CLDP4=;
 b=hx7KpG/AR+h5iQQiNNqL8nz0dK7YAjjOtY9MbevwFBmZSbIH3z/mc7XOWSD23lCxcQQkE7uTifJrxsZ5UyOaSbX/hso57y58Mk4CQ/6iZa/hhA0VuwT+yLLDAxbKIi2Yt11JKvc7PsUv4cJFwkbRbYKTsTGrXVoDqfRmOmj/pSA=
Received: from SN7PR04CA0005.namprd04.prod.outlook.com (2603:10b6:806:f2::10)
 by DS4PR12MB9634.namprd12.prod.outlook.com (2603:10b6:8:280::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.22; Wed, 16 Jul
 2025 11:01:13 +0000
Received: from SN1PEPF00036F3E.namprd05.prod.outlook.com
 (2603:10b6:806:f2:cafe::9e) by SN7PR04CA0005.outlook.office365.com
 (2603:10b6:806:f2::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8943.19 via Frontend Transport; Wed,
 16 Jul 2025 11:01:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SN1PEPF00036F3E.mail.protection.outlook.com (10.167.248.22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8922.22 via Frontend Transport; Wed, 16 Jul 2025 11:01:12 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 16 Jul
 2025 06:01:01 -0500
Received: from JesseDEV.guestwireless.amd.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Wed, 16 Jul 2025 06:00:55 -0500
From: Jesse.Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 Jesse.Zhang <Jesse.Zhang@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Subject: [v4 11/11] drm/amdgpu/userq: implement resets
Date: Wed, 16 Jul 2025 18:59:31 +0800
Message-ID: <20250716110011.1670654-11-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250716110011.1670654-1-Jesse.Zhang@amd.com>
References: <20250716110011.1670654-1-Jesse.Zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: Jesse.Zhang@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF00036F3E:EE_|DS4PR12MB9634:EE_
X-MS-Office365-Filtering-Correlation-Id: c3c4dcb5-4aec-4d4e-5840-08ddc458140b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?QIrFwz2nTFStG17+7UdEQl+qdO7FD8Nl44qGeatL+mQVmz/NIoFzoieAgaAz?=
 =?us-ascii?Q?hUAnycoRZc9Odv9+AZHq7vk5ilBucsiJSMRpMhs+lQFsA4f4tV0ovN0h53lX?=
 =?us-ascii?Q?tyBC9CVsym58ht6LHfz8GWNCo1kF6qOgNJUyQsGDy3NCA0PiAjynSpQg2aI6?=
 =?us-ascii?Q?2OwFPMn2cDQihs7DcKV9h6oF16V5sR5sZinPq9lwpGoe+QxUYEPGGG9wvBCb?=
 =?us-ascii?Q?3l9d9BgnzeYQGHXFGVALEhSkgmIhSaUrYl3D2lxyi/O9uCmz7ohoVmnCYwp3?=
 =?us-ascii?Q?KIw8AujbtRKNEa6jgguFd3eqZcICfKa10puoJIGF4HG/6cjGHfT2Pe592VBV?=
 =?us-ascii?Q?ZD1qGzgAOIZkakOfvsazhAk0q4C/i+zHruotFaTQtQddaEDADdwKZ183cD9g?=
 =?us-ascii?Q?ZkfPn2LUY9xyKtd8OQaYLpMlofCRadVU3D3bBY6Wwv+et13Dg6wDBXlThXQq?=
 =?us-ascii?Q?V0ik1aE0PKmNc8+qxWspf351Uy592dVyrbk14tk0X98YAOZPROI5IGPVBo8G?=
 =?us-ascii?Q?NF2I/wP1qh09QzBrFyQtIruRJZxgzT7WsBQ9ttDHSPNAkbJav1Cri1m8ij1z?=
 =?us-ascii?Q?1XKRxnc7eRdhAvTu+dIzm53/jrE4Jj21uhxCDLTctYupPonYYyCzUmnDaJ9T?=
 =?us-ascii?Q?fXCJNVkj5I+ONcXbT6FgIMy359FYiRQnouWiBJg6M6uB5qZVO4b7yuroIQwC?=
 =?us-ascii?Q?8CbE3WC4ysAguopG5XySI5W+htw1arqY2f5Krw8cdFo0wzvvfizOdyBVZ3d2?=
 =?us-ascii?Q?Lm/TsZ/VLMuVLb4NiohewkZt6S0HTb7d9k97YrtyM3idUQSHTeJX4scobVL1?=
 =?us-ascii?Q?R9oUJsFxxtdE+lt3zAmmr5kBdqiVpBeczKdtvnHdfRKw3i1R9PlSwEH6lg9w?=
 =?us-ascii?Q?2X3kMki1ZN8ZzIp8m73mgOWpk/zzyN9MK7YydJvBvi0IMrPmhegoENzowK5P?=
 =?us-ascii?Q?bIwf5tZoBf4Fm1X6L4cMaUaLK6K37mYWYRfBA775u8W9nLXsyOzb+FtDHP3a?=
 =?us-ascii?Q?qcfRuazNOVpRQc/W8u+kTg0ASQ3k2P3QEbRtMCgzxIfUgH0s11a8FvAFWZHT?=
 =?us-ascii?Q?ye7Tzy3kaUCPOikYmyHBIfB7+nrFSWPmMzPIaNffWX3osw55BeXSF59lXM24?=
 =?us-ascii?Q?SxXrj+M3KOLKz2/s+LxCbiHX0+pdKbLWgvxp+8CEiJ7xdpn6AAy3Iuw9p5Yn?=
 =?us-ascii?Q?chJnlEdziScnFwSXLjTko6PxaAmehfhz7x+PryaNqet0BzkPG7mAAD4BCw8B?=
 =?us-ascii?Q?DlrP18auEWS+K/u4qERQQm0Qr39VI3xnTnEbjYuM/HN5qFeXv/z1gKyynnHc?=
 =?us-ascii?Q?3Y+hkkxexzT3UWsmapv0S5lI5Zbd0c/3TSF9fjt3aaVKK9q6jLrOkCAcn6ki?=
 =?us-ascii?Q?0tqQK6GYMzovLn72fwnI3F5PISPUAvQkz/aDG1two4JhhKLtXpoToz5OtMSV?=
 =?us-ascii?Q?HGiWKC+sVTLOmkEMk41YR0QHKaViGjfcF8IItuq9SFq1RSAw5qkQX5Ypn/d3?=
 =?us-ascii?Q?O9vlvPRz49FHm5QstsKDmoA4GHJelM/DGvDa?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2025 11:01:12.8297 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c3c4dcb5-4aec-4d4e-5840-08ddc458140b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF00036F3E.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR12MB9634
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

If map or unmap fails, or a user fence times out, attempt to reset the queue.  If that fails, schedule a GPU reset.

v2: add detect hang for compute userq (Jesse)

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h        |   1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c |   8 ++
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c  | 129 +++++++++++++++++++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h  |   5 +
 4 files changed, 134 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index d06c86013bb8..10c48204b7c3 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -1305,6 +1305,7 @@ struct amdgpu_device {
 	struct list_head		userq_mgr_list;
 	struct mutex                    userq_mutex;
 	bool                            userq_halt_for_enforce_isolation;
+	struct work_struct		userq_reset_work;
 };
 
 static inline uint32_t amdgpu_ip_version(const struct amdgpu_device *adev,
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 3757634613c3..1dc88b0055dd 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -4475,6 +4475,7 @@ int amdgpu_device_init(struct amdgpu_device *adev,
 	}
 
 	INIT_WORK(&adev->xgmi_reset_work, amdgpu_device_xgmi_reset_func);
+	INIT_WORK(&adev->userq_reset_work, amdgpu_userq_reset_work);
 
 	adev->gfx.gfx_off_req_count = 1;
 	adev->gfx.gfx_off_residency = 0;
@@ -5880,6 +5881,10 @@ int amdgpu_device_reinit_after_reset(struct amdgpu_reset_context *reset_context)
 				if (r)
 					goto out;
 
+				r = amdgpu_userq_post_reset(tmp_adev, vram_lost);
+				if (r)
+					goto out;
+
 				drm_client_dev_resume(adev_to_drm(tmp_adev), false);
 
 				/*
@@ -6102,6 +6107,7 @@ static inline void amdgpu_device_stop_pending_resets(struct amdgpu_device *adev)
 	if (!amdgpu_sriov_vf(adev))
 		cancel_work(&adev->reset_work);
 #endif
+	cancel_work(&adev->userq_reset_work);
 
 	if (adev->kfd.dev)
 		cancel_work(&adev->kfd.reset_work);
@@ -6232,6 +6238,8 @@ static void amdgpu_device_halt_activities(struct amdgpu_device *adev,
 		      amdgpu_device_ip_need_full_reset(tmp_adev))
 			amdgpu_ras_suspend(tmp_adev);
 
+		amdgpu_userq_pre_reset(tmp_adev);
+
 		for (i = 0; i < AMDGPU_MAX_RINGS; ++i) {
 			struct amdgpu_ring *ring = tmp_adev->rings[i];
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
index 82fef5e3ddea..656fe45f65c0 100644
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
@@ -44,6 +47,14 @@ u32 amdgpu_userq_get_supported_ip_mask(struct amdgpu_device *adev)
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
 /**
  * Detect if a given usermode queue is hung by comparing its GPU address
  * to existing HQD addresses in the hardware.
@@ -123,6 +134,42 @@ static bool amdgpu_userqueue_detect_hang(struct amdgpu_userq_mgr *uqm, struct am
 	return false;
 }
 
+static bool
+amdgpu_userq_queue_reset_helper(struct amdgpu_userq_mgr *uq_mgr,
+                               struct amdgpu_usermode_queue *queue)
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
+		if (queue->queue_type == AMDGPU_RING_TYPE_COMPUTE) {
+			if (!amdgpu_userqueue_detect_hang(uq_mgr, queue)) {
+				dev_err(adev->dev, "userq not detected hang\n");
+				return true;
+			}
+		}
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
@@ -130,15 +177,22 @@ amdgpu_userq_unmap_helper(struct amdgpu_userq_mgr *uq_mgr,
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
 
@@ -149,16 +203,22 @@ amdgpu_userq_map_helper(struct amdgpu_userq_mgr *uq_mgr,
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
 
@@ -782,6 +842,23 @@ amdgpu_userq_evict_all(struct amdgpu_userq_mgr *uq_mgr)
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
@@ -808,22 +885,18 @@ void
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
@@ -1001,3 +1074,41 @@ int amdgpu_userq_start_sched_for_enforce_isolation(struct amdgpu_device *adev,
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
index 28bf7857facf..94bc28d230d3 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
@@ -145,4 +145,9 @@ int amdgpu_userq_stop_sched_for_enforce_isolation(struct amdgpu_device *adev,
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

