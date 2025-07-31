Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3538C83F17
	for <amd-gfx@archiver.kernel.org>; Thu, 31 Jul 2025 06:14:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A070B10E704;
	Thu, 31 Jul 2025 06:14:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="tCn62QKI";
	dkim-atps=neutral
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2082.outbound.protection.outlook.com [40.107.100.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DBF2010E24B
 for <amd-gfx@lists.freedesktop.org>; Thu, 31 Jul 2025 06:14:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NXWPYaCcZbasZiGdwXesezG2NbYqYXb+vUFSPakfvwpD40KOpQTQL1W86UtXPtAEVEHILMvEfPKbhKfWOtSbO3SVEQSkCh/IRIsjT16xv+F5VX2Elm31lmyFg6Q9w8XQ+FxKf2K7QTaVqOj6jhWzEmIvF5VyE2SLmFHzBvrlkOlYE9e5US8o4X3Eq+52yf0CpO9DqPHBXD1FrlQdbKpsTbImuUTu1qXzS/DCMx8H3jNGhxkN3RCBAwCmeLyJjozE4RxhuA8i7MJong+38H2qOCqppmSnPAW5sB91syGECX9bxSpb3vZccEVDhh4LVt4Di5i+hnGimEmY3n80VFHZSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Pfzff1/kMfRi/J3OXnB72+8Ak96d83x1T8VN+seoVOU=;
 b=Dafn8rVJkUoyJ267IHalUj3PQKyMKke/gNEDAEudo0kG/6+8aNFmjssZeqS/x43wq5EgbMMEox+xInBeEph4USR6aRpfVsTt9gbVq9pMIpUzEc4kFHFMx/kGsvN0ceANGRvh+ZVdb/toT8sikhKO3LTTBM5bf8h+Sa+LugZzoPvdcdCeHAyhPC+QYlR3YL1391VeJutoxrFvjczrd1R62CctOrjOSYcPjcPh+BaEH1d+gP9LA59w4Ig2qf0E+9v14wAbemE4W767zMvshT8SvVOh0XbGUNTuAyytXGmQ8TrfyvTJ6SVhghHj1uRIpQ58a0GEfxG5aKK/5q2lv8+c/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Pfzff1/kMfRi/J3OXnB72+8Ak96d83x1T8VN+seoVOU=;
 b=tCn62QKIZcHhOVRRBS+kzt0VDYnV01FRqsG8chGmKD6GVe/F+wJ5lF00hCGEphMuemK5IIVqziG6Z16gGWQw2jNYXtdFCKHjq8OOnPSbL4skhY6iU+eQbJR69sANFTkt3o/NptwjruSaYZ4FgGpnyIZaeI+XJaWJ21MMzfbLATU=
Received: from BN9PR03CA0348.namprd03.prod.outlook.com (2603:10b6:408:f6::23)
 by LV3PR12MB9120.namprd12.prod.outlook.com (2603:10b6:408:1a3::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.27; Thu, 31 Jul
 2025 06:14:26 +0000
Received: from BN3PEPF0000B371.namprd21.prod.outlook.com
 (2603:10b6:408:f6:cafe::69) by BN9PR03CA0348.outlook.office365.com
 (2603:10b6:408:f6::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8989.12 via Frontend Transport; Thu,
 31 Jul 2025 06:14:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B371.mail.protection.outlook.com (10.167.243.168) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9009.0 via Frontend Transport; Thu, 31 Jul 2025 06:14:26 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 31 Jul
 2025 01:14:23 -0500
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Alexander.Deucher@amd.com>, <Ce.Sun@amd.com>
Subject: [PATCH 1/3] drm/amdgpu: Add wrapper function for dpc state
Date: Thu, 31 Jul 2025 11:44:05 +0530
Message-ID: <20250731061408.1699369-1-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B371:EE_|LV3PR12MB9120:EE_
X-MS-Office365-Filtering-Correlation-Id: 633f9471-ffd2-43be-25d1-08ddcff9805b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?24x5WjfD3UbIxJCr6xevBzhEYdgc1f4qcgCgJnBl3PXHwPckj3Gqb1GCcDQ9?=
 =?us-ascii?Q?XJdqRuNlGoc9U0Cqh5Cv7QPDsnhPFNtL8X1KJzY3+G42nVV+pEXuWo5Th0vx?=
 =?us-ascii?Q?GRatZT7/inJGFJykh1ZLmsmNCqQNctjx3zBzWF90k/qKTl13pBnSrk9aUJCH?=
 =?us-ascii?Q?FjtciocqEtkOENJXyavf4EhkZgCVpl8RwQifxpREuK4gN/FTl4pXgi17UkwA?=
 =?us-ascii?Q?DcKXYj8PLEt/14LUagt0xY6u1H36eNuSlSDvjImn2Py8MPkCxAGwbnC+L9xt?=
 =?us-ascii?Q?Xeafa/iwrNeltxGn09w9fBgylHehm4PuknOpS6+kghrcws1eR/0IzRItDhQt?=
 =?us-ascii?Q?axy2x5uZEdyOsja0PvCDJRUfHkNPC6KfLj4h2NaqJ8or9gzi+zrFegikj1Pk?=
 =?us-ascii?Q?w731Ixbq50pxF76aPimttJXzlt10RCbzacwdVYe9xF6xMVcNiFr2Qn27Oek6?=
 =?us-ascii?Q?PUnF4KdVeXQHBn5Zh7CFUPS+ILZ4rivrb2c8mrob0wGLFHY0gTCtmM79IIB/?=
 =?us-ascii?Q?Yv+HcCU3xCEfR4wDoFC5ToECGPNdSonfAqx9d1wI9k0lki5h71ZndukargQ3?=
 =?us-ascii?Q?fkiMpbSWx5XWEd6wL96tlzGMYOB8gKyj/RXybwVbACFz/Ud5wP2Wte2tt7/+?=
 =?us-ascii?Q?kNTc1vdJSRsouxSKqUmody11NxASQzKr4Iy/wrjJeIP+GD3g1jQ8h5WaEZiF?=
 =?us-ascii?Q?yoZT146hQknZzSbiZPWJRBdB4CL9W+PVZExY+77NQSPwcKeEpCPnBkzjagJK?=
 =?us-ascii?Q?ACBICgpmXFFTzkfrRoSEdr7fllfqe4bOxqmE1lwRtio48BzquxkMPn0OIasS?=
 =?us-ascii?Q?FWBvIbkMniUnqJiAj5vzYK7JguDi+jWzuUEPdz4jgVe8eQyXY7vNRNbmynHO?=
 =?us-ascii?Q?maSt4yBLREBtjECU760J2kBeWGzggJBg6WylSd9PkG8X/Nr8tCpefuc84N1f?=
 =?us-ascii?Q?OTDWBp/AGPhwJtjDT7LqxTm11ANemAiQeR6DABsztzu4GRreSnsJeGlJJi96?=
 =?us-ascii?Q?6Dkibq8HwWlWJS4fAKIB83NDqtqivqQfmlvh0d9nB/v9mAyUe7eb/OX+PGJr?=
 =?us-ascii?Q?JicYYn9o29GQx9yNPS5Bvqy2jWZ/m+IYptCmJ71ZPgJQVsVGv92uAUAOaT+/?=
 =?us-ascii?Q?7t+tUJ5sZZmu9TDcl5MlNEq4gSkTLrWRLeCN8mYG2QW4vAEHBHgpT51bBLdd?=
 =?us-ascii?Q?tJkaFL1Eq7Tc935fhQkehKfPmu8XxcniNBDInM6a4bSnmPfR75LAqxcdNsSZ?=
 =?us-ascii?Q?V+0DhaGA5fFr5adg76m4rh9W/bQtVphBZV9dNbaN2AAh3Nd2IMgcLkgCfb7l?=
 =?us-ascii?Q?DoNW0L0BY4O/f5+uHT4c0+UdnvKU3rzgzjlkexaSV53lsJOvHmRH+OO260IK?=
 =?us-ascii?Q?mS2YttQpyoYKcqYeJ50W/sotprAJQuFaETWT9MvfXMEsj4EPmFIuFJ6spWit?=
 =?us-ascii?Q?vg+8tUkMfx+7CQmqDwmPnybZu/v7fcEz2RylBqFz4XrqRHLhzj2TDP4EyWQO?=
 =?us-ascii?Q?w8iTRKP42iG+Yf15MHokhpv0VWdlpIsbX9ru?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2025 06:14:26.3322 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 633f9471-ffd2-43be-25d1-08ddcff9805b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B371.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9120
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

Use wrapper functions to set/indicate dpc status.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 17 ++++++++---------
 drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h  | 11 +++++++++++
 2 files changed, 19 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index f4f80cb2f706..ea66322c279b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -5707,7 +5707,7 @@ int amdgpu_device_link_reset(struct amdgpu_device *adev)
 
 	dev_info(adev->dev, "GPU link reset\n");
 
-	if (!adev->pcie_reset_ctx.occurs_dpc)
+	if (!amdgpu_reset_in_dpc(adev))
 		ret = amdgpu_dpm_link_reset(adev);
 
 	if (ret)
@@ -6158,7 +6158,7 @@ static void amdgpu_device_recovery_prepare(struct amdgpu_device *adev,
 			list_add_tail(&tmp_adev->reset_list, device_list);
 			if (adev->shutdown)
 				tmp_adev->shutdown = true;
-			if (adev->pcie_reset_ctx.occurs_dpc)
+			if (amdgpu_reset_in_dpc(adev))
 				tmp_adev->pcie_reset_ctx.in_link_reset = true;
 		}
 		if (!list_is_first(&adev->reset_list, device_list))
@@ -6234,9 +6234,8 @@ static void amdgpu_device_halt_activities(struct amdgpu_device *adev,
 		drm_client_dev_suspend(adev_to_drm(tmp_adev), false);
 
 		/* disable ras on ALL IPs */
-		if (!need_emergency_restart &&
-		      (!adev->pcie_reset_ctx.occurs_dpc) &&
-		      amdgpu_device_ip_need_full_reset(tmp_adev))
+		if (!need_emergency_restart && !amdgpu_reset_in_dpc(adev) &&
+		    amdgpu_device_ip_need_full_reset(tmp_adev))
 			amdgpu_ras_suspend(tmp_adev);
 
 		for (i = 0; i < AMDGPU_MAX_RINGS; ++i) {
@@ -6264,10 +6263,10 @@ static int amdgpu_device_asic_reset(struct amdgpu_device *adev,
 
 retry:	/* Rest of adevs pre asic reset from XGMI hive. */
 	list_for_each_entry(tmp_adev, device_list, reset_list) {
-		if (adev->pcie_reset_ctx.occurs_dpc)
+		if (amdgpu_reset_in_dpc(adev))
 			tmp_adev->no_hw_access = true;
 		r = amdgpu_device_pre_asic_reset(tmp_adev, reset_context);
-		if (adev->pcie_reset_ctx.occurs_dpc)
+		if (amdgpu_reset_in_dpc(adev))
 			tmp_adev->no_hw_access = false;
 		/*TODO Should we stop ?*/
 		if (r) {
@@ -6900,7 +6899,7 @@ pci_ers_result_t amdgpu_pci_error_detected(struct pci_dev *pdev, pci_channel_sta
 
 		if (hive)
 			mutex_lock(&hive->hive_lock);
-		adev->pcie_reset_ctx.occurs_dpc = true;
+		amdgpu_reset_set_dpc_status(adev, true);
 		memset(&reset_context, 0, sizeof(reset_context));
 		INIT_LIST_HEAD(&device_list);
 
@@ -7063,7 +7062,7 @@ void amdgpu_pci_resume(struct pci_dev *pdev)
 	amdgpu_device_sched_resume(&device_list, NULL, NULL);
 	amdgpu_device_gpu_resume(adev, &device_list, false);
 	amdgpu_device_recovery_put_reset_lock(adev, &device_list);
-	adev->pcie_reset_ctx.occurs_dpc = false;
+	amdgpu_reset_set_dpc_status(adev, false);
 
 	if (hive) {
 		mutex_unlock(&hive->hive_lock);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h
index 4d9b9701139b..3a806953338f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h
@@ -160,4 +160,15 @@ int amdgpu_reset_do_xgmi_reset_on_init(
 
 bool amdgpu_reset_in_recovery(struct amdgpu_device *adev);
 
+static inline void amdgpu_reset_set_dpc_status(struct amdgpu_device *adev,
+					       bool status)
+{
+	adev->pcie_reset_ctx.occurs_dpc = status;
+}
+
+static inline bool amdgpu_reset_in_dpc(struct amdgpu_device *adev)
+{
+	return adev->pcie_reset_ctx.occurs_dpc;
+}
+
 #endif
-- 
2.49.0

