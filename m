Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A861FC87FCB
	for <amd-gfx@archiver.kernel.org>; Wed,  6 Aug 2025 02:29:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1F6A810E719;
	Wed,  6 Aug 2025 02:29:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="RCujGIO9";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2076.outbound.protection.outlook.com [40.107.236.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F2D1910E70C
 for <amd-gfx@lists.freedesktop.org>; Wed,  6 Aug 2025 02:29:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MXYMR61jpciTruVLd5kl702GEf9qcx8/Bx4fPCsHSxhxiGfdhcUx245g+LdmydkGwdrnacoxIFbmFC4JBkcnpZMEG0LlSg/oT3OBtKQ/7xsy1YiArCsSvMrmUPtM1m6XRIACwVMJH+NZeuOxSX1Iv+nQnnwKiWMiDNlK7D0PpxaYcBezOz88+3jB3DFnDjePjObuj6TBoLyff7HatCs5oRyesZ2mdZIb0P9Ev9DSOiayAktyt3lwhNfVIoYhgBRjD9iNK6gnkeLVKhD3JFwJECbTvg0gFf5bwNFmhGjVHdQXTaVWEkmHboG/jQ96qOB4YF1mpgBzfHzaXoJrVKHG3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2Xa2WHgkeqzhEVWcSFqB3Ix9N3Qp9hsn1wbD6FmhfPM=;
 b=VQ76vVrK4OZpAOI2eIOdQV8d9hsilqS+tP1eF8M3D/kGKeVFoD0IBcDnNHj0imSe37HsVvMB7R84aDGxQxX3WyYnU7Uus96eHOadHpEZYz5T1IoInrn3Oh3OX9sHJP3GbG+A6lUZU83TFl8tj4gNqPb77ELhUCxpPW4P7LTvTxpLuoCRLg96uumdLet5KnQWoQGnWoUsXYwhRqCXWMqujusVIjEOoe7deOcvjbAnGqEc/2+37l6GKNVHejJ9G49Qng7JcvFs6ChfRW+W2kUOUbPhG7uKQx5wbhCoTRHfruJnqanN56KORnRK003ED4K5fzKo+zgSendictQD6Xm4hA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2Xa2WHgkeqzhEVWcSFqB3Ix9N3Qp9hsn1wbD6FmhfPM=;
 b=RCujGIO9DTBfsn7iRTYLbS1H5xPslztLtrfZPqvHCesXAH8h57LiA0qxAgg8eO+fGB6MkTAiw+pIAZfJWikFgp7Z+NvtQ/axa93wKBDaRiesjGnIBFiHJtIlP+sFcQE9Wk2Az0dbhUifZPJdi6hjQvKToSixfcGMuFMHj3SAQNw=
Received: from MN2PR03CA0003.namprd03.prod.outlook.com (2603:10b6:208:23a::8)
 by LV8PR12MB9271.namprd12.prod.outlook.com (2603:10b6:408:1ff::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.21; Wed, 6 Aug
 2025 02:29:32 +0000
Received: from BN2PEPF000044A8.namprd04.prod.outlook.com
 (2603:10b6:208:23a:cafe::1e) by MN2PR03CA0003.outlook.office365.com
 (2603:10b6:208:23a::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9009.13 via Frontend Transport; Wed,
 6 Aug 2025 02:29:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN2PEPF000044A8.mail.protection.outlook.com (10.167.243.102) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9009.8 via Frontend Transport; Wed, 6 Aug 2025 02:29:32 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 5 Aug
 2025 21:29:31 -0500
Received: from JesseDEV.guestwireless.amd.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Tue, 5 Aug 2025 21:29:24 -0500
From: Jesse.Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 Alex Deucher <alexander.deucher@amd.com>, Jesse Zhang <Jesse.Zhang@amd.com>
Subject: [v7 11/11] drm/amdgpu: Implement user queue reset handling and
 recovery
Date: Wed, 6 Aug 2025 10:24:56 +0800
Message-ID: <20250806022816.1050823-11-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250806022816.1050823-1-Jesse.Zhang@amd.com>
References: <20250806022816.1050823-1-Jesse.Zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: Jesse.Zhang@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A8:EE_|LV8PR12MB9271:EE_
X-MS-Office365-Filtering-Correlation-Id: cd219b24-1337-47aa-90e7-08ddd49113b0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?oWzg0615XhcFdbuOIPahqR+mFhgxBnxlJMv6crq3mjCgExiSF6GM//IsNstY?=
 =?us-ascii?Q?eurrFIYZ0znXKFjh0XVzalJBOhOVEnw+PaJ29fim50tD8vKkydt7XGhjsANV?=
 =?us-ascii?Q?OFmW4HeqU50d94Ujn9JTvuwXfX8myaJKthgbplz8QzuMebD0eYoVx+O5hzCy?=
 =?us-ascii?Q?LsFVF6Q45k8dInIjawVnGBKcBiQTRV1b1mHnEuc6WQS6IHyCUQs9Hw8W/SPm?=
 =?us-ascii?Q?tw/tlkl3poSwr8ylq3lNNiq0zp+dkjkJXIzu8vQf7kAd28k+CGecRe13EnX6?=
 =?us-ascii?Q?RFrs0/oH3CY0YW2YWgPJeuqcRDCTexRjN5J51h1hRLhJfhp4keCJPjZH7JjT?=
 =?us-ascii?Q?/2qbacnSe9fxknlNLFs6LW8VNL3FZt73IOo2k1cdkT9RvMLXPnND7CtJTBx+?=
 =?us-ascii?Q?uajSOu6AGB5CyHiPZjXmBwH7W26tJBibMN9J+sYrnr9chrQVwvhot0UsLBi4?=
 =?us-ascii?Q?RTxOuBHiqJFZd/j01Md5l7iPio/Sw4ztM1iPNLQ0iPHfyGGJhnqZEex2pjNF?=
 =?us-ascii?Q?jFWHHN12blXErCx1Efesqz3Ham1b7K2hWdgBOB8o+de6eqiMw2K07pRu8DLk?=
 =?us-ascii?Q?+DQ+h9aEtll5FarXLIdHTRiHon0xWTWQWQnksYVY6vWmDjp0ZwvN+V0W+rdV?=
 =?us-ascii?Q?YJGALY3CSyIYzaNG7UYbqU2/LJ5yPFVIXo+oIXk7GqPDIZjLbdhTqglPAlGH?=
 =?us-ascii?Q?eE8V0a+uG+s5qPmaFTMw18Mg4k83WMtKkYWH8YtghgJDtnfa2ATE96rz0yec?=
 =?us-ascii?Q?E4bBwu3+cbFCrJKYJiBpQvgIPglg4wQIdUkA1yIb/izaoK9rMladHYwMqk8S?=
 =?us-ascii?Q?EI0f39WmLmlfj2QyfLK5xs9RnnjwGoLwFNHz14JTm5ldZh+DYZchejTkkX8J?=
 =?us-ascii?Q?1BicBNJp9f2aOLrHFVhg2zm+bMwsL19A2hvJAit9Nqz0bbGALLlNcCmwKTmj?=
 =?us-ascii?Q?Uwm3YIX7yDllKUGo54bUAhpSHJuscLH/LqEuHaiUZevOJJEiaC/ofO54JIO2?=
 =?us-ascii?Q?/CRcR6wKdDvPnPd1opsAuPDbjOpzoaSGhFivxXZH1IBu165l23hzub15hFEK?=
 =?us-ascii?Q?LsSjY67a1w8A0Vp8BjfAZ9QnZ+KAduTjVvKDl4u6v1gMXX6ZqItlwlqjFFng?=
 =?us-ascii?Q?gBxsuoUlUJNFbbW1XsN7T12lSxtmfqtLs4fwpklRG3u0tMT5YgF3qwK4NJzw?=
 =?us-ascii?Q?lUJwzY0egSuuh9iESIJYGF8o9+mGFpXiwZ40l8/ZrBEPTXedjJAm/TSm5aL1?=
 =?us-ascii?Q?4YmsN32cvVNBPe1Ttd4Wd9IHw8zaV04vEvcebKV+ZKU6afrlOF4nQnYxbq4i?=
 =?us-ascii?Q?L/90c5goX28+btGy64i7H33R4dmU2/xgIK56pyFB05YwEAkMHKjvXR6yY2nO?=
 =?us-ascii?Q?2+ljOpAInJovSB5AQlb+GGYP05aDJwEECB1677G1o6WoqS4FC+dLxAmIAFsw?=
 =?us-ascii?Q?iiqnmWKm24sYkI0U1fyb0XQZc+g245m9o2tKwTMIU8Lw+qegKexekaevpx2p?=
 =?us-ascii?Q?M1HyyuYf/8Aa91zpe4qblCPoeLolMYagOLjg?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2025 02:29:32.1743 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cd219b24-1337-47aa-90e7-08ddd49113b0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000044A8.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9271
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

From: Alex Deucher <alexander.deucher@amd.com>

This patch introduces queue reset and GPU reset support for userq.
It adds detection and recovery logic for gfx, compute, and SDMA queues when errors occur during queue operations (e.g., map/unmap failures).
This enhances user queue resiliency and ensures graceful recovery in case of individual queue failure without immediately requiring full GPU reset.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h        |   1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c |   8 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c  | 202 +++++++++++++++++++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h  |   5 +
 4 files changed, 201 insertions(+), 15 deletions(-)

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
index 1496544cd1c2..edec881e6fa5 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
@@ -25,8 +25,9 @@
 #include <drm/drm_auth.h>
 #include <drm/drm_exec.h>
 #include <linux/pm_runtime.h>
-
+#include <drm/drm_drv.h>
 #include "amdgpu.h"
+#include "amdgpu_reset.h"
 #include "amdgpu_vm.h"
 #include "amdgpu_userq.h"
 #include "amdgpu_userq_fence.h"
@@ -44,6 +45,88 @@ u32 amdgpu_userq_get_supported_ip_mask(struct amdgpu_device *adev)
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
+	int id, r = 0;
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
+	return r;
+}
+
 static int
 amdgpu_userqueue_preempt_helper(struct amdgpu_userq_mgr *uq_mgr,
 			  struct amdgpu_usermode_queue *queue)
@@ -99,15 +182,23 @@ amdgpu_userq_unmap_helper(struct amdgpu_userq_mgr *uq_mgr,
 	struct amdgpu_device *adev = uq_mgr->adev;
 	const struct amdgpu_userq_funcs *userq_funcs =
 		adev->userq_funcs[queue->queue_type];
+	bool gpu_reset = false;
 	int r = 0;
 
-	if (queue->state == AMDGPU_USERQ_STATE_MAPPED) {
+	if ((queue->state == AMDGPU_USERQ_STATE_MAPPED)  ||
+			(queue->state == AMDGPU_USERQ_STATE_PREEMPTED)) {
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
 
@@ -118,16 +209,22 @@ amdgpu_userq_map_helper(struct amdgpu_userq_mgr *uq_mgr,
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
 
@@ -366,6 +463,7 @@ amdgpu_userq_destroy(struct drm_file *filp, int queue_id)
 		amdgpu_bo_unreserve(queue->db_obj.obj);
 	}
 	amdgpu_bo_unref(&queue->db_obj.obj);
+	amdgpu_userq_detect_and_reset_queues(uq_mgr);
 	r = amdgpu_userq_unmap_helper(uq_mgr, queue);
 	amdgpu_userq_cleanup(uq_mgr, queue, queue_id);
 	mutex_unlock(&uq_mgr->userq_mutex);
@@ -584,7 +682,7 @@ amdgpu_userq_restore_all(struct amdgpu_userq_mgr *uq_mgr)
 
 	/* Resume all the queues for this process */
 	idr_for_each_entry(&uq_mgr->userq_idr, queue, queue_id) {
-		r = amdgpu_userq_map_helper(uq_mgr, queue);
+		r = amdgpu_userqueue_restore_helper(uq_mgr, queue);
 		if (r)
 			ret = r;
 	}
@@ -741,7 +839,7 @@ amdgpu_userq_evict_all(struct amdgpu_userq_mgr *uq_mgr)
 
 	/* Try to unmap all the queues in this process ctx */
 	idr_for_each_entry(&uq_mgr->userq_idr, queue, queue_id) {
-		r = amdgpu_userq_unmap_helper(uq_mgr, queue);
+		r = amdgpu_userqueue_preempt_helper(uq_mgr, queue);
 		if (r)
 			ret = r;
 	}
@@ -751,6 +849,23 @@ amdgpu_userq_evict_all(struct amdgpu_userq_mgr *uq_mgr)
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
@@ -777,22 +892,19 @@ void
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
@@ -833,6 +945,7 @@ void amdgpu_userq_mgr_fini(struct amdgpu_userq_mgr *userq_mgr)
 
 	mutex_lock(&adev->userq_mutex);
 	mutex_lock(&userq_mgr->userq_mutex);
+	amdgpu_userq_detect_and_reset_queues(userq_mgr);
 	idr_for_each_entry(&userq_mgr->userq_idr, queue, queue_id) {
 		amdgpu_userq_wait_for_last_fence(userq_mgr, queue);
 		amdgpu_userq_unmap_helper(userq_mgr, queue);
@@ -866,6 +979,7 @@ int amdgpu_userq_suspend(struct amdgpu_device *adev)
 	list_for_each_entry_safe(uqm, tmp, &adev->userq_mgr_list, list) {
 		cancel_delayed_work_sync(&uqm->resume_work);
 		mutex_lock(&uqm->userq_mutex);
+		amdgpu_userq_detect_and_reset_queues(uqm);
 		idr_for_each_entry(&uqm->userq_idr, queue, queue_id) {
 			r = amdgpu_userq_unmap_helper(uqm, queue);
 			if (r)
@@ -922,6 +1036,7 @@ int amdgpu_userq_stop_sched_for_enforce_isolation(struct amdgpu_device *adev,
 	list_for_each_entry_safe(uqm, tmp, &adev->userq_mgr_list, list) {
 		cancel_delayed_work_sync(&uqm->resume_work);
 		mutex_lock(&uqm->userq_mutex);
+		amdgpu_userq_detect_and_reset_queues(uqm);
 		idr_for_each_entry(&uqm->userq_idr, queue, queue_id) {
 			if (((queue->queue_type == AMDGPU_HW_IP_GFX) ||
 			     (queue->queue_type == AMDGPU_HW_IP_COMPUTE)) &&
@@ -970,3 +1085,60 @@ int amdgpu_userq_start_sched_for_enforce_isolation(struct amdgpu_device *adev,
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
index 9fa0d1a88d71..e68bb144b26f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
@@ -138,4 +138,9 @@ int amdgpu_userq_stop_sched_for_enforce_isolation(struct amdgpu_device *adev,
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

