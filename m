Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DDF3CCD193
	for <amd-gfx@archiver.kernel.org>; Thu, 23 Oct 2025 16:53:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D85AA10E935;
	Thu, 23 Oct 2025 16:53:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="aCxLiZRL";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012015.outbound.protection.outlook.com
 [40.93.195.15])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 567EC10E935
 for <amd-gfx@lists.freedesktop.org>; Thu, 23 Oct 2025 16:53:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kPA/PhkNh6rpz67jW+XntcxmVCqmFtfYu1nwBsdRffeBDi/7Ltq7Sp3s4NlnAO0oR+tWfBUtNw3fjYeasZrOkK0/GXdcaJJrriPT0GWCy+qNNWzClHEoZhWrziyOZMm+tl1axmtHBH8v99gzSWNEdG3MZUjajKrfUczcjvMSqq6BVayW7cK5oG5SwloGb88rMISmmELfOdxEhaBCskdhN63JWvnfxk07E1hQmcT7sGZ5C0+8dofHFNVKvc0guKJ9q8ilCFvFz4W5wrdvsRaCNY6xBZhruOkAfz1XFkrNWKHHYSPm7bU8ZxStUzHPUC+QGkXQkynLo9veGfP0JMmyQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CVvP7AyfGqN5X+9iY01a/fkhXeBk+zjjwMnXYNtXWYY=;
 b=YUqo23pJhmEo5amMa6bVqomfiDKm/dXLzyVDXj/78qfb5PxbP7FRUkG/1g0+c3WBXCP++/H3jzUb2Qsuug99u/a00NKTq/1DA0L0K1mk/AAKztDbhu/YqIxRO2YMtF5xGzY7cehfP6+sPVCpZHXJlUrYLW/YhefMAQmj43kowvzU3GhsXN3Cwg4eSJCYbfmT7GJp+n0U+HIJzJGy2siq3f3WxR3voMGBqSri/4pp+x8UllR6I+25iqhXAfpP1FNVfT37gc+RNqvMpnzLZSdMsg4EzAokuz9Qc8rN8VGftk0n6QHAcTxbhNlNhBBnYJBhALG08Eh6j64QQ8s/gSLbkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CVvP7AyfGqN5X+9iY01a/fkhXeBk+zjjwMnXYNtXWYY=;
 b=aCxLiZRLJuELFO9tfBxQTrVgH2H1b2Au7VZGE8TjONUdIqf0GpNL2Zr6kMXLj23Mh27ZeBHNmRYcXfCQWxI1nAWe5GBANLQXmbT3UpW5Oo9Rx/HKcafemJhEIJSIZFll+nSK/meUkrdjGFrQ/b9f7iVvTD6XiVbb0+n+H1koP5w=
Received: from SJ0PR05CA0091.namprd05.prod.outlook.com (2603:10b6:a03:334::6)
 by IA0PR12MB8253.namprd12.prod.outlook.com (2603:10b6:208:402::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.13; Thu, 23 Oct
 2025 16:52:56 +0000
Received: from SJ1PEPF00002313.namprd03.prod.outlook.com
 (2603:10b6:a03:334:cafe::f4) by SJ0PR05CA0091.outlook.office365.com
 (2603:10b6:a03:334::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9253.11 via Frontend Transport; Thu,
 23 Oct 2025 16:52:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF00002313.mail.protection.outlook.com (10.167.242.167) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9253.7 via Frontend Transport; Thu, 23 Oct 2025 16:52:56 +0000
Received: from dogwood-dvt-marlim.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 23 Oct 2025 09:52:54 -0700
From: Mario Limonciello <mario.limonciello@amd.com>
To: <mario.limonciello@amd.com>, <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v4 1/2] drm/amd: Unwind for failed device suspend
Date: Thu, 23 Oct 2025 11:52:39 -0500
Message-ID: <20251023165243.317153-2-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251023165243.317153-1-mario.limonciello@amd.com>
References: <20251023165243.317153-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002313:EE_|IA0PR12MB8253:EE_
X-MS-Office365-Filtering-Correlation-Id: 56fc35ff-f1a2-47e4-84cb-08de12549dcb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?q+QRfKh3FTfCab1RlJ/s9uha9NuYH3xzloH/+U8GSGHZs11w+WWT3Xx9n/f4?=
 =?us-ascii?Q?CPcwgZYkMUkwSU2wXN7cMFQ04mBs6BpnrA8T4jGm5s4U+GTE1HURZrg5MvWM?=
 =?us-ascii?Q?DJ8R5L/Cj7i+C7jyqjQvqW88630CP8aAiU72TOQ3rKOj+bJWrQskp7ZWX225?=
 =?us-ascii?Q?IMYhx+2/UoAUamRY3KM8itDn3t5KOCEvbRtRmXiCAKSDgEkF/iM9h1liMWHl?=
 =?us-ascii?Q?QqUF6deFdTr/+ueQPkkdBUp6JyNfBFxQ/jqC5H1N1AS/SCkM3jSx0MXHb/C0?=
 =?us-ascii?Q?tBza4ux3pHt3ISSbfN5AVRkQHOdLh/so+dvzq3+H/7njyCXgBeXr/hp1iOLU?=
 =?us-ascii?Q?vGwl6lOCEDOzaNDgd/TqDG2JcLdCBGcgdFcEAIUtP7wEP/ich33xlLpphrxy?=
 =?us-ascii?Q?3DVvz2lIGZgxnl4Gs943aZOw9IqwRsRozpvWxXDFqu81X50Tj95fETry5dZg?=
 =?us-ascii?Q?1MLoGUrv+5SSfZNdHZo1Xp4iY5mD/IFeiMFks7d2Q1SxpijVM2BpRu5JzI0/?=
 =?us-ascii?Q?jKmwprzhUM/ZO5NyNNZkhnYUl4WVrMWOHzwevJCGoYyyPBmIZ5r356pfML7L?=
 =?us-ascii?Q?S65BfG3QdjKYj/inL1TR8PFcxxHgEOCzR0Uo3aRg8Nw/GmzOh2SwD9N8B4m5?=
 =?us-ascii?Q?cjiW2jNfYZgeaxQkA1cyJYMk+HYdul23AzoiWpaKXXEnsilDytmycWBy4U6a?=
 =?us-ascii?Q?dgim+fugEGJyD1hJzcmzwPl1ceMM5hYsO/CKXs+58LCaMXh2IWJC94g4QUsQ?=
 =?us-ascii?Q?drAvpwAdH+RcuunQKdJPSTJ4oBKuTbRPZL6ndLVOMPlYnHc4/JyC36JPCvfg?=
 =?us-ascii?Q?IsNouvkB9ofandnzV431/10zU4qOfgR2Brv7LChzacKRU21Cz48qC1P+CYGh?=
 =?us-ascii?Q?VflpNCWzTM5vDMEPfak/Oop5gHynSupYHqQRMF7tUyw+5RqWu4RABqX0jmFk?=
 =?us-ascii?Q?+NqH/NqMyHaWagsWj9MQYA0gXYyIfJsfVQV3aGK4U7+ss1efJOrv+Qe7hKjn?=
 =?us-ascii?Q?gGrnNQvaotAs9y3gQygZCi279XVqiIn7UVdnTcYs+D+a53AIoxmStUta/G+H?=
 =?us-ascii?Q?cl0VGtRe/oC2FRc1XGveLM50xccMVJDbbl5DivhoeGvpQ6BlepfpRjUfrX4w?=
 =?us-ascii?Q?8jBgU/qTH11Chue7BhHyWY37Oh26ZRsqnBDN4WJk620qvVQavrVc0Lk/cTT8?=
 =?us-ascii?Q?3Jl7BwtA6dL52hckQhC6MeqCwZCFVpilaTzkk4X0MxeYVv7Dp8BZ3WVp9ctv?=
 =?us-ascii?Q?0Zn5q6ls6SkObkRbRxaJjTlk4tXc53R5aQv0JgvrhuTlCsGkXeQhiMnqGTEL?=
 =?us-ascii?Q?hB9cBoBTUtKCd0EECG9K76mgw4bklK3T4roZlYt/SpxcsflaUhsCaTqOOqzM?=
 =?us-ascii?Q?klZ9ortEg4whhLimXz8jIfBwWxJoy5AhEUCY/xMcXr13j+grxs3QXOZ5dE4t?=
 =?us-ascii?Q?3jIQk7IPcdzeu6N3iS8h6WmrAbrCbO05XIKdjLCh3JxL6ivPs7RgOOe81DZE?=
 =?us-ascii?Q?4UaMaxCUpMJLd2+Xn12HQoas5bzfXFLgPDgB7dVEmJ6B6d5GpWTSW7AcbO6B?=
 =?us-ascii?Q?m+ZmMKVsAiX0/maWelw=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2025 16:52:56.5693 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 56fc35ff-f1a2-47e4-84cb-08de12549dcb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00002313.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8253
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

Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/4627
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 80 +++++++++++++++++++---
 1 file changed, 72 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 3ffb9bb1ec0b..645b15aa34f1 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -5231,7 +5231,7 @@ void amdgpu_device_complete(struct drm_device *dev)
 int amdgpu_device_suspend(struct drm_device *dev, bool notify_clients)
 {
 	struct amdgpu_device *adev = drm_to_adev(dev);
-	int r = 0;
+	int r, rec;
 
 	if (dev->switch_power_state == DRM_SWITCH_POWER_OFF)
 		return 0;
@@ -5247,8 +5247,9 @@ int amdgpu_device_suspend(struct drm_device *dev, bool notify_clients)
 			return r;
 	}
 
-	if (amdgpu_acpi_smart_shift_update(adev, AMDGPU_SS_DEV_D3))
-		dev_warn(adev->dev, "smart shift update failed\n");
+	r = amdgpu_acpi_smart_shift_update(adev, AMDGPU_SS_DEV_D3);
+	if (r)
+		goto unwind_sriov;
 
 	if (notify_clients)
 		drm_client_dev_suspend(adev_to_drm(adev), false);
@@ -5259,16 +5260,16 @@ int amdgpu_device_suspend(struct drm_device *dev, bool notify_clients)
 
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
 
@@ -5276,16 +5277,79 @@ int amdgpu_device_suspend(struct drm_device *dev, bool notify_clients)
 
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
+	/* suspend phase 1 = resume phase 3 */
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
+	adev->in_suspend = adev->in_s0ix = adev->in_s3 = false;
+
+	return r;
 }
 
 static inline int amdgpu_virt_resume(struct amdgpu_device *adev)
-- 
2.51.1

