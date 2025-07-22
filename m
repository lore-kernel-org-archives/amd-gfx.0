Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CCA0C83F25
	for <amd-gfx@archiver.kernel.org>; Tue, 22 Jul 2025 03:07:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D765610E5DB;
	Tue, 22 Jul 2025 03:07:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="vQ6CWIT6";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2047.outbound.protection.outlook.com [40.107.236.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 029AF10E5DB
 for <amd-gfx@lists.freedesktop.org>; Tue, 22 Jul 2025 03:07:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QxrhH7IeRZFpi6cFr7Xw+DNWopVb+gB4AfzXlpQAS1sHQur+IVzTE/vLQtcPVNJhomBcuttAlK2PMnhBVbDa59pUDAkBVBs7Sybx0YZJ/EcYIJ/TWQh43GuoLZ3M+UnSh0SWIsPQhodmTb9nr7NdVKFWqN1dObSpTBf/NywH7560XTF0yH7y4U68DJCFByO935x3jYXcKkCg0zAD0RKMLK4cv4Uhi9HC+/o7RW2HoHDJYoasK1ktFDefJu7RcXsE38zcYmKtbzjXkG8czEQjiuLwKRmOaK/gsvdVBF0Mopnb9JFYgSTIzxlXCMkvn7lCe4m8jZtzojgiE4b1DAvSMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Le1aWl6G9A5bWbubwxOmbIu+Egu8tqWq4v7FZpGXnHQ=;
 b=vwjnmZL9h7Vi84GJI9Uoe6dEKvCuKSKophg0pz6WBYA+Jl86kvIBEuF6kQuliPwJoqg2Hqrs6N3QlCoZVKfjtlnOC3zsop4geZdERL11O+8VC2NxYEjC8UItNJSQeqwPWnmqm2VMam8NcVlGjIXIszU1omm/Pn8S3z8OD/l5Al+VBOCLEUkV/POYq+gHZR/AXtbXBozK9vdyhcW4Fg1Ad+Ei/KoV7lbqtynbzsJIZ/CDvfse0ZKZlauOpGLk5gghzxtu43m3xHI81Sb9wovf4/xCMWYJUuIYHGtIZC+DRrw2lITGmz4gwn7NJx5vCUxwRzFaKiKNoBEMRPnLd/27ig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Le1aWl6G9A5bWbubwxOmbIu+Egu8tqWq4v7FZpGXnHQ=;
 b=vQ6CWIT69OsLl3VPXss8KgC1ywap/4Oucjx4eG5LfRdxJ/TlN/bPvjtwaeMwwFfexfPe+oup8ApLdggpsU8Enak+VFNsdy+5HEIxHS1xUHbW02iCyAEcQFk61t64NIucYtaKgAqjL3NjpjY6h5Ybj8VdX+c27svKqLJJXBD0noU=
Received: from BN9PR03CA0303.namprd03.prod.outlook.com (2603:10b6:408:112::8)
 by DS0PR12MB7557.namprd12.prod.outlook.com (2603:10b6:8:130::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.30; Tue, 22 Jul
 2025 03:06:58 +0000
Received: from BL6PEPF00020E63.namprd04.prod.outlook.com
 (2603:10b6:408:112:cafe::d8) by BN9PR03CA0303.outlook.office365.com
 (2603:10b6:408:112::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8943.29 via Frontend Transport; Tue,
 22 Jul 2025 03:06:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF00020E63.mail.protection.outlook.com (10.167.249.24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8964.20 via Frontend Transport; Tue, 22 Jul 2025 03:06:56 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 21 Jul
 2025 22:06:56 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 21 Jul
 2025 22:06:56 -0500
Received: from JesseDEV.guestwireless.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Mon, 21 Jul 2025 22:06:49 -0500
From: Jesse.Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 Alex Deucher <alexander.deucher@amd.com>, Jesse Zhang <Jesse.Zhang@amd.com>
Subject: [v5 9/9] drm/amdgpu: Add GPU reset handling for user mode queues
Date: Tue, 22 Jul 2025 11:03:45 +0800
Message-ID: <20250722030605.2741435-9-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250722030605.2741435-1-Jesse.Zhang@amd.com>
References: <20250722030605.2741435-1-Jesse.Zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E63:EE_|DS0PR12MB7557:EE_
X-MS-Office365-Filtering-Correlation-Id: 2ccfe963-4e66-41e9-d840-08ddc8ccd165
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Zon/MRiBu01lPceoSZd5l9Z1R0lLVrAr2y/ntdhWpFiRis9BEUsvmZSwO1lL?=
 =?us-ascii?Q?bcbIMvSIu6B/Dlzld8W40tj0kxtqa6qnWByrEbKrN+NimACE6sxfg7gzP+gn?=
 =?us-ascii?Q?zRQAdTi4q4j5shHsemo1pBNWNvpTo3jNycsu/kZAIaqBYeN+cfG8W3PxrNOI?=
 =?us-ascii?Q?U2IXmMEAg76H6rpjAIL6zvv/CLX8jEhekYhayzJ3pXr6GfKY9kIi6uwrF7ln?=
 =?us-ascii?Q?vpK1Yo0CRidlK03DgWtJuDM4FTZqLNjcXidCylp0N3OzdoTYeIsrz5AKWB6w?=
 =?us-ascii?Q?/dQKJLlUS+rgA2yQXxaEXkUAlU1pL30iafa9xPS5TEnyMwObRuNXUwwlYOJL?=
 =?us-ascii?Q?MGFOgmF1czIWvoAAqtw/4srXl8pJiAVWaQTKOBd4BKzcH4/jHwbR5/ULJfKY?=
 =?us-ascii?Q?0jxa+EbW1TXEHxfGpGkIJzs9YtABd+UHpuWH1GVL6HLPmspRr/qIUFdm/SA9?=
 =?us-ascii?Q?y4FYgda1LSurlyqdl3pHQr+vr4X9xBd7hwjgRyG3fMV7lPBbfFOEkOSCc90T?=
 =?us-ascii?Q?6nypRksCHmFsbk0iO3s2QqJRXurGHSCl0wc2R/ENIotXaqxEisHTwi/AFwiu?=
 =?us-ascii?Q?qn3ihvZkYD3WIZtD7jqM9mW0c3o6CBknI4tUNLqkmOBmkNPJgaoMbCK/RYX7?=
 =?us-ascii?Q?kn6BhhmzJsUQkVsmNc2f00Aoc+GZ2ApyovoFrqE4RG2c3/vSyJzygliOd4WS?=
 =?us-ascii?Q?XYNWCgHNejoGu36mkymGkpgNJzj+wmlNFltohbtBlTwmFsInndTVBarcyR6E?=
 =?us-ascii?Q?1K8d77fImOtyOERMkNi0+Iz8bZmYaAcSSn/K6guSioPK9j19nLsr93D2/m9+?=
 =?us-ascii?Q?yOdlh+UE9iuT+U81uuJXULxknimIr/BSwNt6MKgGnZYBKwR4NdoUFrLtjpX3?=
 =?us-ascii?Q?/J+RTxAzB0ZTuSgdkqrq+z2T/WlceuFogsjmt67+Zcz5Nv7XQJob7Qp6AbUe?=
 =?us-ascii?Q?2BMhXQ7Por+43qbbMz7j2hknUak5x0QRwMsEphp01bnYwpaaCE1DsIAy0ww6?=
 =?us-ascii?Q?8gXcHMGuXuZhR3mux9Bq88ntOPPxGyWuUHihm0KPyqCdSxIRutF8zktT/NHz?=
 =?us-ascii?Q?MLJmI/rkho2wdjX03K65fBTEJ0VD+o6WuXiikm2B7l3SADJ05uR5aE8D9rlM?=
 =?us-ascii?Q?ZHFDsmTB+yg3gNUfBtdZOM0PzwaKyq5xf9i+xTb9OvR8QFd8GKSu8AZ2Glsz?=
 =?us-ascii?Q?6z52xAdqUrEpgS5XtSeV+Dydw8o4y8s2QjS1WrvnpMFTnosbQDtXUHTBmPSY?=
 =?us-ascii?Q?nbmXLnVNikTgoyC8mk6xHQAeVoS9ruDn60koMeJGvd2GsJsExIwCFaVE2Bk4?=
 =?us-ascii?Q?twYO/2/ELPtoCM+iBVBgyQyUVebhoAes/Kb7T2rVM07oQpwUsTg/7h2pp/eg?=
 =?us-ascii?Q?dSSMLjE0i6bkXsAwk4bPwd6m57Mmij4M7i/lkWjh5+2FdHHmVG9DiwCEOqfF?=
 =?us-ascii?Q?0v/ADAanSGT9fRy2Wcd9nYmpEnR84MFLSVPLJZApcc3N+Wpw6PINx1Us+nBX?=
 =?us-ascii?Q?w86W5WikHB+ud4NXmDw977Ux7RdRnR1i83C0?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2025 03:06:56.8026 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ccfe963-4e66-41e9-d840-08ddc8ccd165
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF00020E63.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7557
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

From: "Alex Deucher" <alexander.deucher@amd.com>

This patch introduces GPU reset support for userq.
It adds detection and recovery logic for gfx, compute, and SDMA queues when errors occur during queue operations (e.g., map/unmap failures).

Key changes include:
- New function `amdgpu_userq_detect_and_reset_queues()` to scan active queues and attempt recovery via queue-specific handlers.
- Integration of userq reset logic into suspend/resume, eviction, and reset paths.
- New pre-reset and post-reset hooks (`amdgpu_userq_pre_reset()` and `amdgpu_userq_post_reset()`) for cleaning up and reinitializing user queues during full GPU reset.
- A new work_struct (`userq_reset_work`) is introduced and used in `amdgpu_userq_gpu_reset()` to trigger GPU recovery using the standard GPU reset framework.
- Improved robustness and logging during user queue unmap/map operations.

This enhances user queue resiliency and ensures graceful recovery in case of individual queue failure without immediately requiring full GPU reset.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h        |   1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c |   8 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c  | 200 +++++++++++++++++++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h  |   5 +
 4 files changed, 203 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index ef3af170dda4..9db05cdc7304 100644
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
index aac0de86f3e8..0c91302162fa 100644
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
@@ -44,6 +47,92 @@ u32 amdgpu_userq_get_supported_ip_mask(struct amdgpu_device *adev)
 	return userq_ip_mask;
 }
 
+static void amdgpu_userq_gpu_reset(struct amdgpu_device *adev)
+{
+
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
+	const struct amdgpu_userq_funcs *userq_gfx_funcs =
+			adev->userq_funcs[AMDGPU_RING_TYPE_GFX];
+	const struct amdgpu_userq_funcs *userq_compute_funcs =
+			adev->userq_funcs[AMDGPU_RING_TYPE_COMPUTE];
+	const struct amdgpu_userq_funcs *userq_sdma_funcs =
+			adev->userq_funcs[AMDGPU_RING_TYPE_SDMA];
+
+	bool has_gfx = false, has_compute = false, has_sdma = false;
+	struct amdgpu_usermode_queue *userq;
+	bool gpu_reset = false;
+	int gpu_suspend, id, r = 0;
+
+	if (idr_is_empty(&uq_mgr->userq_idr))
+		return false;
+
+	/* Detect which types of queues are present */
+	idr_for_each_entry(&uq_mgr->userq_idr, userq, id) {
+		switch (userq->queue_type) {
+		case AMDGPU_RING_TYPE_GFX:
+			has_gfx = true;
+			break;
+		case AMDGPU_RING_TYPE_COMPUTE:
+			has_compute = true;
+			break;
+		case AMDGPU_RING_TYPE_SDMA:
+			has_sdma = true;
+			break;
+		default:
+			break;
+		}
+	}
+
+	if (unlikely(adev->debug_disable_gpu_ring_reset)) {
+		dev_err(adev->dev, "userq reset disabled by debug mask\n");
+	} else if (amdgpu_gpu_recovery) {
+		if (has_compute && userq_compute_funcs->detect_and_reset) {
+			gpu_suspend = amdgpu_mes_suspend(adev);
+			r = userq_compute_funcs->detect_and_reset(adev, AMDGPU_RING_TYPE_COMPUTE);
+			if (r) {
+				gpu_reset = true;
+				goto gpu_reset;
+			}
+		}
+
+		if (has_gfx && userq_gfx_funcs->detect_and_reset) {
+			r = userq_gfx_funcs->detect_and_reset(adev, AMDGPU_RING_TYPE_GFX);
+			if (r) {
+				gpu_reset = true;
+				goto gpu_reset;
+			}
+		}
+
+		if (has_sdma && userq_sdma_funcs && userq_sdma_funcs->detect_and_reset) {
+			r = userq_sdma_funcs->detect_and_reset(adev, AMDGPU_RING_TYPE_SDMA);
+			if (r) {
+				gpu_reset = true;
+				goto gpu_reset;
+			}
+		}
+	}
+
+gpu_reset:
+	if (gpu_reset)
+		amdgpu_userq_gpu_reset(adev);
+
+	if ((!gpu_suspend) && has_compute)
+		amdgpu_mes_resume(adev);
+
+	return r;
+}
+
 static int
 amdgpu_userq_unmap_helper(struct amdgpu_userq_mgr *uq_mgr,
 			  struct amdgpu_usermode_queue *queue)
@@ -51,15 +140,22 @@ amdgpu_userq_unmap_helper(struct amdgpu_userq_mgr *uq_mgr,
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
+			gpu_reset = true;
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
 
@@ -70,16 +166,22 @@ amdgpu_userq_map_helper(struct amdgpu_userq_mgr *uq_mgr,
 	struct amdgpu_device *adev = uq_mgr->adev;
 	const struct amdgpu_userq_funcs *userq_funcs =
 		adev->userq_funcs[queue->queue_type];
+	bool gpu_reset = false;
 	int r = 0;
 
 	if (queue->state == AMDGPU_USERQ_STATE_UNMAPPED) {
 		r = userq_funcs->map(uq_mgr, queue);
 		if (r) {
 			queue->state = AMDGPU_USERQ_STATE_HUNG;
+			gpu_reset = true;
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
 
@@ -318,6 +420,7 @@ amdgpu_userq_destroy(struct drm_file *filp, int queue_id)
 		amdgpu_bo_unreserve(queue->db_obj.obj);
 	}
 	amdgpu_bo_unref(&queue->db_obj.obj);
+	amdgpu_userq_detect_and_reset_queues(uq_mgr);
 	r = amdgpu_userq_unmap_helper(uq_mgr, queue);
 	amdgpu_userq_cleanup(uq_mgr, queue, queue_id);
 	mutex_unlock(&uq_mgr->userq_mutex);
@@ -691,6 +794,7 @@ amdgpu_userq_evict_all(struct amdgpu_userq_mgr *uq_mgr)
 	int queue_id;
 	int ret = 0, r;
 
+	amdgpu_userq_detect_and_reset_queues(uq_mgr);
 	/* Try to unmap all the queues in this process ctx */
 	idr_for_each_entry(&uq_mgr->userq_idr, queue, queue_id) {
 		r = amdgpu_userq_unmap_helper(uq_mgr, queue);
@@ -703,6 +807,23 @@ amdgpu_userq_evict_all(struct amdgpu_userq_mgr *uq_mgr)
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
@@ -729,22 +850,19 @@ void
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
@@ -785,6 +903,7 @@ void amdgpu_userq_mgr_fini(struct amdgpu_userq_mgr *userq_mgr)
 
 	mutex_lock(&adev->userq_mutex);
 	mutex_lock(&userq_mgr->userq_mutex);
+	amdgpu_userq_detect_and_reset_queues(userq_mgr);
 	idr_for_each_entry(&userq_mgr->userq_idr, queue, queue_id) {
 		amdgpu_userq_wait_for_last_fence(userq_mgr, queue);
 		amdgpu_userq_unmap_helper(userq_mgr, queue);
@@ -818,6 +937,7 @@ int amdgpu_userq_suspend(struct amdgpu_device *adev)
 	list_for_each_entry_safe(uqm, tmp, &adev->userq_mgr_list, list) {
 		cancel_delayed_work_sync(&uqm->resume_work);
 		mutex_lock(&uqm->userq_mutex);
+		amdgpu_userq_detect_and_reset_queues(uqm);
 		idr_for_each_entry(&uqm->userq_idr, queue, queue_id) {
 			r = amdgpu_userq_unmap_helper(uqm, queue);
 			if (r)
@@ -874,6 +994,7 @@ int amdgpu_userq_stop_sched_for_enforce_isolation(struct amdgpu_device *adev,
 	list_for_each_entry_safe(uqm, tmp, &adev->userq_mgr_list, list) {
 		cancel_delayed_work_sync(&uqm->resume_work);
 		mutex_lock(&uqm->userq_mutex);
+		amdgpu_userq_detect_and_reset_queues(uqm);
 		idr_for_each_entry(&uqm->userq_idr, queue, queue_id) {
 			if (((queue->queue_type == AMDGPU_HW_IP_GFX) ||
 			     (queue->queue_type == AMDGPU_HW_IP_COMPUTE)) &&
@@ -922,3 +1043,60 @@ int amdgpu_userq_start_sched_for_enforce_isolation(struct amdgpu_device *adev,
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
+	list_for_each_entry_safe(uqm, tmp, &adev->userq_mgr_list, list) {
+		cancel_delayed_work_sync(&uqm->resume_work);
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
+	int queue_id, r = 0;
+
+	list_for_each_entry(uqm, &adev->userq_mgr_list, list) {
+		idr_for_each_entry(&uqm->userq_idr, queue, queue_id) {
+			if (queue->state == AMDGPU_USERQ_STATE_HUNG && !vram_lost) {
+				userq_funcs = adev->userq_funcs[queue->queue_type];
+
+				r = userq_funcs->map(uqm, queue);  // Re-map queue
+				if (r) {
+					dev_err(adev->dev, "Failed to remap queue %d\n", queue_id);
+					continue;
+				}
+				queue->state = AMDGPU_USERQ_STATE_MAPPED;
+			}
+		}
+
+		/* Restart resume work after reset */
+		//queue_delayed_work(system_wq, &uqm->resume_work, msecs_to_jiffies(100));
+	}
+
+	return r;
+}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
index 0335ff03f65f..649ec25f4deb 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
@@ -135,4 +135,9 @@ int amdgpu_userq_stop_sched_for_enforce_isolation(struct amdgpu_device *adev,
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

