Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5CAEEE0214
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Sep 2024 07:03:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0EDD889130;
	Wed, 11 Sep 2024 07:03:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="MRZ/5U1f";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2077.outbound.protection.outlook.com [40.107.237.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AA48510E75A
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 Sep 2024 07:03:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=p0/ahMX7L2jVtPkrtsL0QBUmdvx08USoiJtm6KyVsLUD8sBhwMkRrHa2y82Hw9PZQlAXNYJ6TgIFVsiY1MKL7uH2HBIZkS1V7eIAhsRDYWkGNXKE01i/yg2e8IpdS8rhOp/N8xapxGGr/bYsbQP6BylLQAaOkXudtpfgaS98eRyzza5CdTft1YdfTGgN/dC/qGWHoKIINntkcY7ZJxY1MU1+4q6amLGWyWiHsMPQCSnUSWnB1NFekI/0zniCde/+gM3SPZQTiEpVyjSC3N4Z19aU4tPYThA4f2qp0/By/OnediJ/odMFhnSsye+3dRb2UpxBRvHrEGoREFahWaLHiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5lvWiBQ4roMygMAB0v94ufGM41m7VUwmwrebNxdvQIY=;
 b=ge5XkcTXVpd4vYI4uRmmJrke6d0WoXopPi7zS26i2SKI8+C4wQ8N5egSeXkPTHE607snOXrfnYqVx6flOX/zOwxpmf/NRbcEO+j3ymcG2DFhMpuEZKDlf4LLpKwSkyYoIkQw5o2CrB6yI3fJHEoWa0u4nQ6hkgldSI2pHNKMimwDl33vJUw7jgY5XO3WQXXY6db1XwZQFfbxVjneFMR/c1dO7P0M0JbE/xAVtcAJbS/8hj7e+cEFgK8uJGljMWKUaZ9WtpJhKIFehK23KJY5B91RD9BC5eSsZ/6BqUHvcQvvgS78MNx0UptmWaEPeXiswFThQ/3zikwOFy1r0yilcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5lvWiBQ4roMygMAB0v94ufGM41m7VUwmwrebNxdvQIY=;
 b=MRZ/5U1fDvv4B4I0MYfhYmD8JCO93/e6h8bLni6w/Kqy3QwoJwYQAiUxPYsqIMUFH0GA9to4j4v6kv/LyKOjozj/8yVQj1hthj5GMsWh5JDCMRC/u3psEGC1NKc7te2BVaosjSYuSf0cv0I5oy7stCMAVuSYOHfwFjzjLnNRZn0=
Received: from BYAPR08CA0008.namprd08.prod.outlook.com (2603:10b6:a03:100::21)
 by CY5PR12MB6300.namprd12.prod.outlook.com (2603:10b6:930:f::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.24; Wed, 11 Sep
 2024 07:03:14 +0000
Received: from CO1PEPF000075F3.namprd03.prod.outlook.com
 (2603:10b6:a03:100:cafe::44) by BYAPR08CA0008.outlook.office365.com
 (2603:10b6:a03:100::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.24 via Frontend
 Transport; Wed, 11 Sep 2024 07:03:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000075F3.mail.protection.outlook.com (10.167.249.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7918.13 via Frontend Transport; Wed, 11 Sep 2024 07:03:13 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 11 Sep
 2024 02:02:01 -0500
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Alexander.Deucher@amd.com>,
 <Christian.Koenig@amd.com>, <feifxu@amd.com>, <rajneesh.bhardwaj@amd.com>
Subject: [PATCH v2 02/10] drm/amdgpu: Use init level for pending_reset flag
Date: Wed, 11 Sep 2024 12:28:50 +0530
Message-ID: <20240911065858.2224424-3-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240911065858.2224424-1-lijo.lazar@amd.com>
References: <20240911065858.2224424-1-lijo.lazar@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000075F3:EE_|CY5PR12MB6300:EE_
X-MS-Office365-Filtering-Correlation-Id: 62079598-bd4f-440f-cdc8-08dcd22fcdb9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?HasQRRg4y3OoNPcWON/SouxTAvvsz0stwj26wFVYqgy0UQVc+x23+Y9EoSSt?=
 =?us-ascii?Q?mT7PVEeD7AT2TQXPotJ7MUnPCma523ho24MTWwsMpNMHz6yLxhMYpWbFQYMz?=
 =?us-ascii?Q?33msCkPTrMIHSKOTPV4/CiqvIuSpgx3cJpwwuMnFO8+uKftjEl84mkBxugdD?=
 =?us-ascii?Q?ztsh8/rfUmtynzqEQOkDrVBNQA6ockrrBa9ibfF+34EYVDIdfDPVANPxOwcF?=
 =?us-ascii?Q?SB8VKYSW9HPlHfUX0inMROkp3goRyooUtc5zhIsId5LxpFtt0o+ezncLn60f?=
 =?us-ascii?Q?2VAF6nJe6lSAJ6xfEd7imcbUHbEdeC10yA0i/u8MfwIGQeYicKcFAcQOOiAc?=
 =?us-ascii?Q?2Ih3XeXFsGYoGQVbvVtPbUsRwihOC7yckowBxrmgpn+U8WuzHQnv+yR7cqHJ?=
 =?us-ascii?Q?OwDzK7Qjnfk89rf8JS3tYXAHFlNpMOdV1zlDHZoRsICu/EFKhIvYsg2FOae/?=
 =?us-ascii?Q?oqwe72FlEjFfzzmSHYOR2clD6zpZyRz3Xn8jBmfd1Nw1kivHFewuTk52SK95?=
 =?us-ascii?Q?l7BnpbrMNEj2olgKsIYYcGS2OEgwBNGip3oEJOJ37z69wZxl+XluOFLlNILG?=
 =?us-ascii?Q?5roO9PVfsTWZKXKEY7CG8keaN1/VxtKIacBr4URDK7rPuzgBoz0EIYf3BrzF?=
 =?us-ascii?Q?KCAtndcsQq4ecg0zOq9FmqLPVEoYjU5AWuYGEWMh+M1BDPa4kA36FrCvAb3Y?=
 =?us-ascii?Q?9DCrO0tHJOQuk3KKYF7HJoaGHsjr0Q8GWlYi8HTBa/TGD49CKnomxud+0IWh?=
 =?us-ascii?Q?yKkVWMfuLooUnFB4zVjXsLIXvnzFHT1FqQ/r/Z4w08tdR8Kfc8Os1P+UnBuq?=
 =?us-ascii?Q?R2I7ACOUyAvKCT1vZLgLSd8Zi2CFLFoJaZICRVnPsijJ2J6nHbHm6WUUXNPr?=
 =?us-ascii?Q?l0MCobLEvG1zXWqi1Lep5/cO08YNZrZIr8cDUxl17USlX77+83BpfY3hjUQi?=
 =?us-ascii?Q?Z9BZtcOYOUZrjYhzgjDK3mefdJl2hL9qfHLG6dsmybibtcckUzL8Ito0bGFu?=
 =?us-ascii?Q?tDtvU4bialZO63f4NBlPhYd2naUGSL62xESL+fQOxOAks8PGU/azRMY+e/e5?=
 =?us-ascii?Q?crtQuWshlRj4Re19499aYYJqtQ8x72RuNSFzebw5kzzD+K+syd93QOcRCVPb?=
 =?us-ascii?Q?mYxwiRRsyzwVXMFN2435qIc0QfnGinA/dvLzRcL29UKvsnsaxAO0Y2WJVJc+?=
 =?us-ascii?Q?r0fB82G5JvBClkhHtWfelPLHqQQ+NceE+WZdokB+gnu0ynI4i8Ay/SRn3Xjg?=
 =?us-ascii?Q?bAxDIDX+01gQr4x5HD64I0VcFJ+2Ca4pEygIJviD3sr3QDp9YG+ERlXHu58Y?=
 =?us-ascii?Q?xKUlr/wm1ZGHNezG7Way+EY6E7KdJFrRLK3VyY3KECHiqnGVFF8o/vWHXbPM?=
 =?us-ascii?Q?gON6s3JUdmuyw0MBUHYbIhue7ZplU84NBaItTLvDEqa6+ggnHVQyJ0R5hwQZ?=
 =?us-ascii?Q?P6LFR2MUcmjqIDwmA4Kr91+yD64TKOQK?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2024 07:03:13.3913 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 62079598-bd4f-440f-cdc8-08dcd22fcdb9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000075F3.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6300
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

Drop pending_reset flag in gmc block. Instead use init level to
determine which type of init is preferred - in this case MINIMAL.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
v2:
	Fix logical issue while replacing pending_reset flag in smuv11 (Feifei)
	Use renamed init level id - AMDGPU_INIT_LEVEL_MINIMAL_XGMI

 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c    | 34 +++++--------------
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c       |  1 -
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h       |  1 -
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c       |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c      |  6 ++--
 .../gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c    |  3 +-
 6 files changed, 14 insertions(+), 33 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 2ecc70f220d2..ca5ef1d87035 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -1699,7 +1699,7 @@ bool amdgpu_device_need_post(struct amdgpu_device *adev)
 	}
 
 	/* Don't post if we need to reset whole hive on init */
-	if (adev->gmc.xgmi.pending_reset)
+	if (adev->init_lvl->level == AMDGPU_INIT_LEVEL_MINIMAL_XGMI)
 		return false;
 
 	if (adev->has_hw_reset) {
@@ -2993,7 +2993,7 @@ static int amdgpu_device_ip_init(struct amdgpu_device *adev)
 		amdgpu_ttm_set_buffer_funcs_status(adev, true);
 
 	/* Don't init kfd if whole hive need to be reset during init */
-	if (!adev->gmc.xgmi.pending_reset) {
+	if (adev->init_lvl->level != AMDGPU_INIT_LEVEL_MINIMAL_XGMI) {
 		kgd2kfd_init_zone_device(adev);
 		amdgpu_amdkfd_device_init(adev);
 	}
@@ -3507,14 +3507,9 @@ static int amdgpu_device_ip_suspend_phase2(struct amdgpu_device *adev)
 		}
 
 		/* skip unnecessary suspend if we do not initialize them yet */
-		if (adev->gmc.xgmi.pending_reset &&
-		    !(adev->ip_blocks[i].version->type == AMD_IP_BLOCK_TYPE_GMC ||
-		      adev->ip_blocks[i].version->type == AMD_IP_BLOCK_TYPE_SMC ||
-		      adev->ip_blocks[i].version->type == AMD_IP_BLOCK_TYPE_COMMON ||
-		      adev->ip_blocks[i].version->type == AMD_IP_BLOCK_TYPE_IH)) {
-			adev->ip_blocks[i].status.hw = false;
+		if (!amdgpu_ip_member_of_hwini(
+			    adev, adev->ip_blocks[i].version->type))
 			continue;
-		}
 
 		/* skip suspend of gfx/mes and psp for S0ix
 		 * gfx is in gfxoff state, so on resume it will exit gfxoff just
@@ -4332,20 +4327,8 @@ int amdgpu_device_init(struct amdgpu_device *adev,
 	if (!amdgpu_sriov_vf(adev) && amdgpu_asic_need_reset_on_init(adev)) {
 		if (adev->gmc.xgmi.num_physical_nodes) {
 			dev_info(adev->dev, "Pending hive reset.\n");
-			adev->gmc.xgmi.pending_reset = true;
-			/* Only need to init necessary block for SMU to handle the reset */
-			for (i = 0; i < adev->num_ip_blocks; i++) {
-				if (!adev->ip_blocks[i].status.valid)
-					continue;
-				if (!(adev->ip_blocks[i].version->type == AMD_IP_BLOCK_TYPE_GMC ||
-				      adev->ip_blocks[i].version->type == AMD_IP_BLOCK_TYPE_COMMON ||
-				      adev->ip_blocks[i].version->type == AMD_IP_BLOCK_TYPE_IH ||
-				      adev->ip_blocks[i].version->type == AMD_IP_BLOCK_TYPE_SMC)) {
-					DRM_DEBUG("IP %s disabled for hw_init.\n",
-						adev->ip_blocks[i].version->funcs->name);
-					adev->ip_blocks[i].status.hw = true;
-				}
-			}
+			amdgpu_set_init_level(adev,
+					      AMDGPU_INIT_LEVEL_MINIMAL_XGMI);
 		} else if (amdgpu_ip_version(adev, MP1_HWIP, 0) == IP_VERSION(13, 0, 10) &&
 				   !amdgpu_device_has_display_hardware(adev)) {
 					r = psp_gpu_reset(adev);
@@ -4453,7 +4436,7 @@ int amdgpu_device_init(struct amdgpu_device *adev,
 	/* enable clockgating, etc. after ib tests, etc. since some blocks require
 	 * explicit gating rather than handling it automatically.
 	 */
-	if (!adev->gmc.xgmi.pending_reset) {
+	if (adev->init_lvl->level != AMDGPU_INIT_LEVEL_MINIMAL_XGMI) {
 		r = amdgpu_device_ip_late_init(adev);
 		if (r) {
 			dev_err(adev->dev, "amdgpu_device_ip_late_init failed\n");
@@ -4530,7 +4513,7 @@ int amdgpu_device_init(struct amdgpu_device *adev,
 	if (px)
 		vga_switcheroo_init_domain_pm_ops(adev->dev, &adev->vga_pm_domain);
 
-	if (adev->gmc.xgmi.pending_reset)
+	if (adev->init_lvl->level == AMDGPU_INIT_LEVEL_MINIMAL_XGMI)
 		queue_delayed_work(system_wq, &mgpu_info.delayed_reset_work,
 				   msecs_to_jiffies(AMDGPU_RESUME_MS));
 
@@ -5502,7 +5485,6 @@ int amdgpu_do_asic_reset(struct list_head *device_list_handle,
 		list_for_each_entry(tmp_adev, device_list_handle, reset_list) {
 			/* For XGMI run all resets in parallel to speed up the process */
 			if (tmp_adev->gmc.xgmi.num_physical_nodes > 1) {
-				tmp_adev->gmc.xgmi.pending_reset = false;
 				if (!queue_work(system_unbound_wq, &tmp_adev->xgmi_reset_work))
 					r = -EALREADY;
 			} else
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index 82bde5132dc6..3dece2e69608 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -2495,7 +2495,6 @@ static void amdgpu_drv_delayed_reset_work_handler(struct work_struct *work)
 	for (i = 0; i < mgpu_info.num_dgpu; i++) {
 		adev = mgpu_info.gpu_ins[i].adev;
 		flush_work(&adev->xgmi_reset_work);
-		adev->gmc.xgmi.pending_reset = false;
 	}
 
 	/* reset function will rebuild the xgmi hive info , clear it now */
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
index 4d951a1baefa..33b2adffd58b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
@@ -182,7 +182,6 @@ struct amdgpu_xgmi {
 	bool supported;
 	struct ras_common_if *ras_if;
 	bool connected_to_cpu;
-	bool pending_reset;
 	struct amdgpu_xgmi_ras *ras;
 };
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index 61a2f386d9fb..c7cdbd2b5adc 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -3185,7 +3185,7 @@ int amdgpu_ras_recovery_init(struct amdgpu_device *adev)
 	 * when the GPU is pending on XGMI reset during probe time
 	 * (Mostly after second bus reset), skip it now
 	 */
-	if (adev->gmc.xgmi.pending_reset)
+	if (adev->init_lvl->level == AMDGPU_INIT_LEVEL_MINIMAL_XGMI)
 		return 0;
 	ret = amdgpu_ras_eeprom_init(&con->eeprom_control);
 	/*
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
index 7de449fae1e3..74135d611cba 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
@@ -860,7 +860,7 @@ int amdgpu_xgmi_add_device(struct amdgpu_device *adev)
 	if (!adev->gmc.xgmi.supported)
 		return 0;
 
-	if (!adev->gmc.xgmi.pending_reset &&
+	if ((adev->init_lvl->level != AMDGPU_INIT_LEVEL_MINIMAL_XGMI) &&
 	    amdgpu_device_ip_get_ip_block(adev, AMD_IP_BLOCK_TYPE_PSP)) {
 		ret = psp_xgmi_initialize(&adev->psp, false, true);
 		if (ret) {
@@ -907,7 +907,7 @@ int amdgpu_xgmi_add_device(struct amdgpu_device *adev)
 
 	task_barrier_add_task(&hive->tb);
 
-	if (!adev->gmc.xgmi.pending_reset &&
+	if ((adev->init_lvl->level != AMDGPU_INIT_LEVEL_MINIMAL_XGMI) &&
 	    amdgpu_device_ip_get_ip_block(adev, AMD_IP_BLOCK_TYPE_PSP)) {
 		list_for_each_entry(tmp_adev, &hive->device_list, gmc.xgmi.head) {
 			/* update node list for other device in the hive */
@@ -985,7 +985,7 @@ int amdgpu_xgmi_add_device(struct amdgpu_device *adev)
 		}
 	}
 
-	if (!ret && !adev->gmc.xgmi.pending_reset)
+	if (!ret && (adev->init_lvl->level != AMDGPU_INIT_LEVEL_MINIMAL_XGMI))
 		ret = amdgpu_xgmi_sysfs_add_dev_info(adev, hive);
 
 exit_unlock:
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
index 16fcd9dcd202..8981302b19c8 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
@@ -1616,7 +1616,8 @@ int smu_v11_0_baco_set_state(struct smu_context *smu, enum smu_baco_state state)
 			break;
 		default:
 			if (!ras || !adev->ras_enabled ||
-			    adev->gmc.xgmi.pending_reset) {
+			    (adev->init_lvl->level ==
+			     AMDGPU_INIT_LEVEL_MINIMAL_XGMI)) {
 				if (amdgpu_ip_version(adev, MP1_HWIP, 0) ==
 				    IP_VERSION(11, 0, 2)) {
 					data = RREG32_SOC15(THM, 0, mmTHM_BACO_CNTL_ARCT);
-- 
2.25.1

