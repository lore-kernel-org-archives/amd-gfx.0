Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0EE8CCD1BE
	for <amd-gfx@archiver.kernel.org>; Wed, 22 Oct 2025 05:08:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2EEA610E5A5;
	Wed, 22 Oct 2025 05:08:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="RUwhY1tC";
	dkim-atps=neutral
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011001.outbound.protection.outlook.com [40.107.208.1])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B18D510E5A5
 for <amd-gfx@lists.freedesktop.org>; Wed, 22 Oct 2025 05:08:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=O6U3tmEao+2DNC69vBkUHX/rPIkHo2NDKRl3CM7KCkiWvDICooXSDd1Ufoydn5wNW3DYuU2MYiVwTeDdJGS/DjpyX0/N7THZo21XfKOrAu3Or1CiPK8XGXMS8sb2DRx4LG2u4R/UM+lf/LAv/0FDtko58kidBOZilz7yShta/7BXYq6/Lsg6R9CU8w6Zit5/qtMGA33ahmYwTpky8tHO4Anj3nE+K3YoWAVXd9P5LEBwEitaOXTlEo7uR0Vpu5lohERgZ2XJjD78lB/m+qyLKJQIqwXc76qafc4FHZGh1OCGs6svmmm9QGNLqXM1nY6LY/P5KmYM3YI+yJ0MWBZvWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fK5vbvBZeCzm/JyFZaz+/2NMrbOyGlG6aGId1ZchjC0=;
 b=qSE+NnxDUasvBGBALs69AbWhOC06y0eLoG+mbQO9RYldfGZBTVH4nhosMxDcUE2sFEVS5GA5qV1ywftz3yA14Z5YyOeCInpT5Ot1k+YgNEzF0pvvNVAgJvFiux0FvMDFWF2OPFO97SHrBKWHR7JdDiFOTv5PwB0PUaNoGtgBFEkey6ofgRAHMibHHjrHj24p4Vvod1Dx3qx2z0oB5pne6ItByYd//FZLww+jOXWf/aB1ks61w+3atcjMI1g1f+iJQ4Ac0gSlec3sdDxfRVWmRhEnTMbltrDTNjm80A7HLmlwXv7fHPuruCcI20H9dOvYknCFXpsVdE7VIPVhQZsxBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fK5vbvBZeCzm/JyFZaz+/2NMrbOyGlG6aGId1ZchjC0=;
 b=RUwhY1tCsmNErRcwqhbEXX4nMJiMzZ691Oyr1gsZSEL/hdyDexhqmycMVRUD+0l/BLnNk1FiG1tQXFAlT/qIXhLUeNsVNuq1btfe2RCc+sH+f/I0VuwzyZMyzbt8T7IKsrvGKobw296KCrgEnYfaaBgow9K5wj5Yrp9sUvpU2aY=
Received: from BN9PR03CA0557.namprd03.prod.outlook.com (2603:10b6:408:138::22)
 by PH7PR12MB8427.namprd12.prod.outlook.com (2603:10b6:510:242::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.12; Wed, 22 Oct
 2025 05:08:44 +0000
Received: from BN1PEPF00006001.namprd05.prod.outlook.com
 (2603:10b6:408:138:cafe::ee) by BN9PR03CA0557.outlook.office365.com
 (2603:10b6:408:138::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9228.13 via Frontend Transport; Wed,
 22 Oct 2025 05:08:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN1PEPF00006001.mail.protection.outlook.com (10.167.243.233) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9253.7 via Frontend Transport; Wed, 22 Oct 2025 05:08:43 +0000
Received: from dogwood-dvt-marlim.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Tue, 21 Oct 2025 22:08:43 -0700
From: Mario Limonciello <mario.limonciello@amd.com>
To: <mario.limonciello@amd.com>, <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v2 1/2] drm/amd: Unwind for failed device suspend
Date: Wed, 22 Oct 2025 00:08:22 -0500
Message-ID: <20251022050827.552763-2-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251022050827.552763-1-mario.limonciello@amd.com>
References: <20251022050827.552763-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00006001:EE_|PH7PR12MB8427:EE_
X-MS-Office365-Filtering-Correlation-Id: 6d7a9f50-15e3-4f56-30e5-08de112912b1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?bNfKoFRwzIKhmZIiW++HBQJkwyBaxHxDvxTs2YGPk7o5+akPgTJ80EIzcyd0?=
 =?us-ascii?Q?uFDw+UGzmzqRj6FXI4phKPFvBifOg+VydOtU89EEghTCm07s9U0dchyZ/rMj?=
 =?us-ascii?Q?Z1nmfK1QajTcXc/rrpBp4o97JDXmnfFo5W8pH/CG0yetgyr5yCZk/7IBPe2p?=
 =?us-ascii?Q?Qyk8G6Yi503RQZMuYZZMJ4qhE9iM8fTiFs2zzZzBh+rQqqEuxpRLRzH2vsQr?=
 =?us-ascii?Q?zIKZwOpFwscq6V7Nyv0FNSELM82hZRJrR3iB/e3V1JR3NcadkCeZf7rxwJj6?=
 =?us-ascii?Q?iNqZw/l2KNtL51UUQlP95IE4yukZlH4FaFWxAuldYAMoTKbq0XMJ4IY5MyRH?=
 =?us-ascii?Q?SFTY+cVzp03WFKES9/3vhRadWUAVgCfthTIuqmd1FQvNJ1HmPMtB3mPFLBzh?=
 =?us-ascii?Q?78A9kgxaa/F+3/+mRll8BXXMAx/3LsWyi6Tp7FGZTd8YpB0HuBBXRXOTqQnM?=
 =?us-ascii?Q?r8yA7w58wUoF2aMi1RUjmAfnI0kADQSWJZkxb+lZwI7qY90rx9mqYV1hl2IU?=
 =?us-ascii?Q?jFhK4tXrdbCHL0MbscqqUptUb0AgNP6ZOMTjOZojbi9a5cWvGdFdc+TBxRs4?=
 =?us-ascii?Q?LOUsofyduLHxE5VlEtLWvuiY0Al28ocPdR9JHk4erTZSDJ9xofAQ9n70ry3W?=
 =?us-ascii?Q?SLMmPSA7wysqkfP3gMNPaXO/hkLAGaUrTgeriPiPJSrzC9vIL4lEiP7i7+/N?=
 =?us-ascii?Q?D8kd36vw7hw3VfFofSaaI2ngs9xFjY0kqya0YfD2MBxpoPWb/AUTPuyGFPz6?=
 =?us-ascii?Q?x2KQV8l8Uto7eOkysBuy2X5fOk5XcrU2AXEGsavA/SCdk8BdighMNo/Vvkwt?=
 =?us-ascii?Q?vIFCIHlAYIYZSr4YCsrRLtd2uNyyz9VQ6Hhfc0gGVVAqmaw3DPYJh9hPyIDe?=
 =?us-ascii?Q?13FWxLaxMy6DXHgtdQd7GxXxkoXkSeD6/CyGAKU/nU4gymFnlj+rC4isP2zi?=
 =?us-ascii?Q?JcNIyOnPZqiGJFJOJirp6Hjwv0eLKowSVbJpWY7n0LfMEzLw0OR29oaMUW4C?=
 =?us-ascii?Q?210NHKiwWkBuuMPRq3ZO7eKHxlKiVwpCbMv5CV03IBOb2NzQ0me3iyZa/SsX?=
 =?us-ascii?Q?4Ym/n0sqt2/VNG5MJx3dIAsClNQ0Fu/I7fHXhX6dKaM/klTTmEMQd8iMV7Gu?=
 =?us-ascii?Q?OK0zhJ85VdP9uTUboEbH7dOB+ibU5CumZrVc6Su5GMoOVwf1/8KbyKBaZOkP?=
 =?us-ascii?Q?2OtBdzFa5xTRclGyRRRXPqj9mQfbc1b7b4Ir3kw9hO/L556cn0fmbxwObgdg?=
 =?us-ascii?Q?vrubfxsfsHlXJOsDYBsYbi6Q/nRsY9nqeXX0DtrAphjK6/JEwjqvD9lMpSrc?=
 =?us-ascii?Q?Xiz5VgroolYyP7VyFTpnBVsbVT1FgK+Xo2dgZc5Y/47PC70iB9JRsb7wgfIa?=
 =?us-ascii?Q?mjXGijiMEq0sTvqUhfik2sawnZrKyUOTyC6IFt4Sfca3xe9fD1Wqz5U/flBI?=
 =?us-ascii?Q?bA1yYg5zGhl3TsUNyQ9k6gacN02ER+mmv5H68NPuURYXx67I3wdRfQQ+273s?=
 =?us-ascii?Q?jxDa6VCWrv8t4u2mG/i+LlSpobpC3U1zganInDP+kDqQyXPsQ+J4LCLBQvp/?=
 =?us-ascii?Q?RicbLvld35nCtk2hckM=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2025 05:08:43.7688 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d7a9f50-15e3-4f56-30e5-08de112912b1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00006001.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8427
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

If device suspend has failed, add a recovery flow that will attempt
to unwind the suspend and get things back up and running.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
v2:
 * Whole unwind
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 80 +++++++++++++++++++---
 1 file changed, 72 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 2dc60040474d..f9a87d517c72 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -5227,7 +5227,7 @@ void amdgpu_device_complete(struct drm_device *dev)
 int amdgpu_device_suspend(struct drm_device *dev, bool notify_clients)
 {
 	struct amdgpu_device *adev = drm_to_adev(dev);
-	int r = 0;
+	int r, rec;
 
 	if (dev->switch_power_state == DRM_SWITCH_POWER_OFF)
 		return 0;
@@ -5243,8 +5243,9 @@ int amdgpu_device_suspend(struct drm_device *dev, bool notify_clients)
 			return r;
 	}
 
-	if (amdgpu_acpi_smart_shift_update(adev, AMDGPU_SS_DEV_D3))
-		dev_warn(adev->dev, "smart shift update failed\n");
+	r = amdgpu_acpi_smart_shift_update(adev, AMDGPU_SS_DEV_D3);
+	if (r)
+		goto unwind_sriov;
 
 	if (notify_clients)
 		drm_client_dev_suspend(adev_to_drm(adev), false);
@@ -5255,16 +5256,16 @@ int amdgpu_device_suspend(struct drm_device *dev, bool notify_clients)
 
 	r = amdgpu_device_ip_suspend_phase1(adev);
 	if (r)
-		return r;
+		goto unwind_smartshift;
 
 	amdgpu_amdkfd_suspend(adev, !amdgpu_sriov_vf(adev) && !adev->in_runpm);
 	r = amdgpu_userq_suspend(adev);
 	if (r)
-		return r;
+		goto unwind_ip_phase1;
 
 	r = amdgpu_device_evict_resources(adev);
 	if (r)
-		return r;
+		goto unwind_userq;
 
 	amdgpu_ttm_set_buffer_funcs_status(adev, false);
 
@@ -5272,14 +5273,14 @@ int amdgpu_device_suspend(struct drm_device *dev, bool notify_clients)
 
 	r = amdgpu_device_ip_suspend_phase2(adev);
 	if (r)
-		return r;
+		goto unwind_evict;
 
 	if (amdgpu_sriov_vf(adev))
 		amdgpu_virt_release_full_gpu(adev, false);
 
 	r = amdgpu_dpm_notify_rlc_state(adev, false);
 	if (r)
-		return r;
+		goto unwind_ip_phase2;
 
 #ifdef CONFIG_HIBERNATE_CALLBACKS
 	if (adev->in_s4)
@@ -5287,6 +5288,69 @@ int amdgpu_device_suspend(struct drm_device *dev, bool notify_clients)
 #endif
 
 	return 0;
+
+unwind_ip_phase2:
+	/* suspend phase 2 = resume phase 2 + resume phase 1 */
+	rec = amdgpu_device_ip_resume_phase2(adev);
+	if (rec) {
+		dev_warn(adev->dev, "failed to re-initialize IPs phase2: %d\n", rec);
+		return r;
+	}
+	rec = amdgpu_device_fw_loading(adev);
+	if (rec) {
+		dev_warn(adev->dev, "failed to reload firmwares: %d\n", rec);
+		return r;
+	}
+	rec = amdgpu_device_ip_resume_phase1(adev);
+	if (rec) {
+		dev_warn(adev->dev, "failed to re-initialize IPs phase1: %d\n", rec);
+		return r;
+	}
+
+unwind_evict:
+	if (adev->mman.buffer_funcs_ring->sched.ready)
+		amdgpu_ttm_set_buffer_funcs_status(adev, true);
+	amdgpu_fence_driver_hw_init(adev);
+
+unwind_userq:
+	rec = amdgpu_userq_resume(adev);
+	if (rec) {
+		dev_warn(adev->dev, "failed to re-initialize user queues: %d\n", rec);
+		return r;
+	}
+	rec = amdgpu_amdkfd_resume(adev, !amdgpu_sriov_vf(adev) && !adev->in_runpm);
+	if (rec) {
+		dev_warn(adev->dev, "failed to re-initialize kfd: %d\n", rec);
+		return r;
+	}
+
+unwind_ip_phase1:
+	/* suspend phase 1 = resume phase 3*/
+	rec = amdgpu_device_ip_resume_phase3(adev);
+	if (rec) {
+		dev_warn(adev->dev, "failed to re-initialize IPs phase1: %d\n", rec);
+		return r;
+	}
+
+unwind_smartshift:
+	rec = amdgpu_acpi_smart_shift_update(adev, AMDGPU_SS_DEV_D0);
+	if (rec) {
+		dev_warn(adev->dev, "failed to re-update smart shift: %d\n", rec);
+		return r;
+	}
+
+unwind_sriov:
+	if (amdgpu_sriov_vf(adev)) {
+		rec = amdgpu_virt_request_full_gpu(adev, true);
+		if (rec) {
+			dev_warn(adev->dev, "failed to reinitialize sriov: %d\n", rec);
+			return r;
+		}
+	}
+
+	adev->in_suspend = false;
+
+	return r;
 }
 
 static inline int amdgpu_virt_resume(struct amdgpu_device *adev)
-- 
2.49.0

