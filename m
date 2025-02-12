Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1066DC021A0
	for <amd-gfx@archiver.kernel.org>; Wed, 12 Feb 2025 16:11:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BC4BB10E8FD;
	Wed, 12 Feb 2025 16:11:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="3QO/ezL5";
	dkim-atps=neutral
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2055.outbound.protection.outlook.com [40.107.96.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CF39F10E8FD
 for <amd-gfx@lists.freedesktop.org>; Wed, 12 Feb 2025 16:11:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DNkNVPzj0J4UQbjIz8nlr5OBw7uz83Uo0jfvLrYKRVV6KuL+TqcX/n6Mj+NAaSZJKNlm4OXr+64+jTmCQ02PZdE+T4l7ApfIeVCib/pw+bCRE3dJoJpckitTBdprroUeVhnvmAmQ5aBWZ4Ey8VdtrSKVE79G4X88Ff+1CXWECnMUjLF5FFugwnShJ/V9PPJ6BF3sDRMZKKas2c3WKqpJYCqYjDDN979n3jwu/Rfkpqzr6Yo244QOCL4Yv9ke/h+E43j4EdzWQWHAKv+8IO6C+mh1LZg9BeoMv1VahANyDN77vQJnYctMePwu3Bg34lIpTBMKyJea7GuW/62wQQRnrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aQOy7J0K58XKULaTqsOaI0tscg+M1vJQYo0LgNuTZtM=;
 b=j8+N8DnK/5gF+j89ruU3Zjf0qCWiy3ZbArN2HNDv82hLjbxO5QHHa4qF1oXM/0zkMZ8KdlaQJZZrwgEZWRTz0wtC1UKIfP5T+5Jcg59YfR5fxOT+01wIIwxNRIF5Q1MSJdQojJZzhqOtBS8ZPRxScH9G0c4YCET53k2Wl2XN+zi7CzlsUnQaCBmVEBrzBz2ffwywbjzCPHFLzMqsk23DPWNkwi9UOWEwftcwtJCKx08BYxFmXiY6cVt0xFrsCoSmXSJ9LYMAvDZkc0aH6rx2A5o/SXZHUGq2BlJWCFdG2XZe9KPLKxuNG1jmrqxKL7HslRCE24MytZmQ0VXQ/MjQ1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aQOy7J0K58XKULaTqsOaI0tscg+M1vJQYo0LgNuTZtM=;
 b=3QO/ezL5D3PoJk3xSYhLx2jHee5rYMOSkieQ7AKzBGmegXbjMqnDmPxkVuHSUHp/P98iRjL85cXRt7zAgexSe/kn2aGJNyUE2A0FBHb2oyJ2dMesnLwMhL/YttaQlBi14r36AMnkHDO6fjT/jWM2EDbIeOJC0HoxwEtWc6pU0pM=
Received: from SJ0PR03CA0251.namprd03.prod.outlook.com (2603:10b6:a03:3a0::16)
 by CYXPR12MB9428.namprd12.prod.outlook.com (2603:10b6:930:d5::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.11; Wed, 12 Feb
 2025 16:11:46 +0000
Received: from SJ1PEPF00002310.namprd03.prod.outlook.com
 (2603:10b6:a03:3a0:cafe::a4) by SJ0PR03CA0251.outlook.office365.com
 (2603:10b6:a03:3a0::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8445.13 via Frontend Transport; Wed,
 12 Feb 2025 16:11:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00002310.mail.protection.outlook.com (10.167.242.164) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8445.10 via Frontend Transport; Wed, 12 Feb 2025 16:11:45 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 12 Feb
 2025 10:11:42 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: "chr[]" <chris@rudorff.com>, Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH] amdgpu/pm/legacy: fix suspend/resume issues
Date: Wed, 12 Feb 2025 11:11:29 -0500
Message-ID: <20250212161129.2712730-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.48.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002310:EE_|CYXPR12MB9428:EE_
X-MS-Office365-Filtering-Correlation-Id: 7dea93a1-1411-46ce-c8d0-08dd4b7ff261
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700013|1800799024|13003099007; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?D/iDt86NgWEiwtfbmqN+lB4XQsBuIX7OUfLCCwyONGJMPrgtijoxrG57n5zN?=
 =?us-ascii?Q?KLZY6+wMDmMyTfWzadZjvYYT97FtKHwumv6rP/MsltzBLrEA9LD0C+fjjQg9?=
 =?us-ascii?Q?dHY3iavffVdnJaJIwhjeifcMC4HZLeE0WmGE9ZER+ZB9Jz0Gon9PDJn5r6Ve?=
 =?us-ascii?Q?J6wyAkeV1CR6LHDiVa+QZw8poCJf9Jbvvvh3OXh2ooGMTnnlZZ/H5MzUF+lQ?=
 =?us-ascii?Q?Zw4KbELftvEDoMURvF3GohePyNKq5whA/ry9zBHCuMYEUDb/X6Vgv1rRuiW8?=
 =?us-ascii?Q?l4CXJ72iAyBKI3+KuPthT3m6JoYbym2I9wXnrUhCqbWB21LPnHpZygf1EC3v?=
 =?us-ascii?Q?3a0Mr++9lfxLAnnqFHPc53McVYs6r8ADhkaQg4etTQAL/xlR9vwAq/JaBhz6?=
 =?us-ascii?Q?VQtyczGYi+9Z3EvzkF/FLMctdZppkvFzebcxuBFttbsXlusS0DL9xzqWw/rT?=
 =?us-ascii?Q?K6zMQB28OIXesMO8o7IPpP6Faejc3ddXrdTPGxnL4+COg3tCPVE5qKLF+ZQW?=
 =?us-ascii?Q?+7dDGIcSiSgy33MolMjSWrgr17SKJ1CjJFsWtJHPoAG0eerVsc7nJYuYYP/Y?=
 =?us-ascii?Q?ZpgTOXtvg9eflErupaqqwlOYfJCKSKPN+TI00Hy7FjxkSPJh2CdGcfBd3YD4?=
 =?us-ascii?Q?wKyBFp5cqFv9MS26YBmmrV5STotVLlcfZaMuNQq89eMWEVvT1Iutl4aYCPCF?=
 =?us-ascii?Q?Mc06h+vgR9YALoYsXQE8lHnkqRa9podKvikfx0jZfA9PWHuo46u1p9BouCkd?=
 =?us-ascii?Q?YYraH6O3SZDzPZZv74BXXv54NgGeGnLB49+vQTJ727i1odxu9pOPEthBqTio?=
 =?us-ascii?Q?Lm7SLGty4BW8oXHVq872GnYYkVa2QODsXSG4IHvkpsw+/0AKffRcEcrbivxG?=
 =?us-ascii?Q?eCbDic7hecIg+T1jDRLUqljTt/h8DU9P0oKnDCCoRd0c0e0I4PAnro30crJ4?=
 =?us-ascii?Q?X75MjBuY1m3LfeS8edWLnZ27Kt9ts5KKuQBjDaVslLnuPqnoHuMtYwWKVhgl?=
 =?us-ascii?Q?Y3knbcmP8gfsdPtybbv+ejs9smnmgM05zvIMpivL9M+clgprXXt1eQw+/47O?=
 =?us-ascii?Q?AukgKCD4KRCJq/HzsGdsAo3GCeif+l51zqvS9Wh6FeV89cLNYvlGcAQMSfb+?=
 =?us-ascii?Q?LNSrvtRRUpj8rFyf/VWSGkIlXSwFUU4DR+yqZ/5cEQAyd855GqpThDNoI5bt?=
 =?us-ascii?Q?zdmIbltlFBTX2W0HdwoNgp2WqUCoq/A6Gj+K1ZqtuzxUeNIU0Pe3qxfwTbAH?=
 =?us-ascii?Q?E/6IesBTyQVj5nnR7RmJJOVT60Z672GzkMHh599FPiqz2CUhGph6eD59knSZ?=
 =?us-ascii?Q?GmUMQQ55BSruGU/YXvvS9L1cwBbxSK+lpDARkOoYH/hcAfvaiJG49PMSOMQF?=
 =?us-ascii?Q?Fia1xReMCn7A0HHAOwWe9xha7RCHBOOZ4RvnmWTBIpwBq2wzR2+IwO0eRfGo?=
 =?us-ascii?Q?c0T8QCLzukI=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024)(13003099007);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Feb 2025 16:11:45.4340 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7dea93a1-1411-46ce-c8d0-08dd4b7ff261
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00002310.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR12MB9428
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

From: "chr[]" <chris@rudorff.com>

resume and irq handler happily races in set_power_state()

* amdgpu_legacy_dpm_compute_clocks() needs lock
* protect irq work handler
* fix dpm_enabled usage

Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/2524
Fixes: 3712e7a49459 ("drm/amd/pm: unified lock protections in amdgpu_dpm.c")
Signed-off-by: chr[] <chris@rudorff.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/pm/legacy-dpm/kv_dpm.c    | 19 ++++++++++++++----
 .../gpu/drm/amd/pm/legacy-dpm/legacy_dpm.c    |  2 ++
 drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c    | 20 +++++++++++++++----
 3 files changed, 33 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/legacy-dpm/kv_dpm.c b/drivers/gpu/drm/amd/pm/legacy-dpm/kv_dpm.c
index 67a8e22b1126d..db0d3d4dba685 100644
--- a/drivers/gpu/drm/amd/pm/legacy-dpm/kv_dpm.c
+++ b/drivers/gpu/drm/amd/pm/legacy-dpm/kv_dpm.c
@@ -3042,6 +3042,7 @@ static int kv_dpm_hw_init(struct amdgpu_ip_block *ip_block)
 	if (!amdgpu_dpm)
 		return 0;
 
+	mutex_lock(&adev->pm.mutex);
 	kv_dpm_setup_asic(adev);
 	ret = kv_dpm_enable(adev);
 	if (ret)
@@ -3049,6 +3050,8 @@ static int kv_dpm_hw_init(struct amdgpu_ip_block *ip_block)
 	else
 		adev->pm.dpm_enabled = true;
 	amdgpu_legacy_dpm_compute_clocks(adev);
+	mutex_unlock(&adev->pm.mutex);
+
 	return ret;
 }
 
@@ -3067,10 +3070,13 @@ static int kv_dpm_suspend(struct amdgpu_ip_block *ip_block)
 	struct amdgpu_device *adev = ip_block->adev;
 
 	if (adev->pm.dpm_enabled) {
+		mutex_lock(&adev->pm.mutex);
+		adev->pm.dpm_enabled = false;
 		/* disable dpm */
 		kv_dpm_disable(adev);
 		/* reset the power state */
 		adev->pm.dpm.current_ps = adev->pm.dpm.requested_ps = adev->pm.dpm.boot_ps;
+		mutex_unlock(&adev->pm.mutex);
 	}
 	return 0;
 }
@@ -3080,18 +3086,23 @@ static int kv_dpm_resume(struct amdgpu_ip_block *ip_block)
 	int ret;
 	struct amdgpu_device *adev = ip_block->adev;
 
-	if (adev->pm.dpm_enabled) {
+	if (!amdgpu_dpm)
+		return 0;
+
+	if (!adev->pm.dpm_enabled) {
+		mutex_lock(&adev->pm.mutex);
 		/* asic init will reset to the boot state */
 		kv_dpm_setup_asic(adev);
 		ret = kv_dpm_enable(adev);
 		if (ret)
 			adev->pm.dpm_enabled = false;
-		else
+		else {
 			adev->pm.dpm_enabled = true;
-		if (adev->pm.dpm_enabled)
 			amdgpu_legacy_dpm_compute_clocks(adev);
+		}
+		mutex_unlock(&adev->pm.mutex);
 	}
-	return 0;
+	return ret;
 }
 
 static bool kv_dpm_is_idle(void *handle)
diff --git a/drivers/gpu/drm/amd/pm/legacy-dpm/legacy_dpm.c b/drivers/gpu/drm/amd/pm/legacy-dpm/legacy_dpm.c
index e861355ebd75b..e06c25c945007 100644
--- a/drivers/gpu/drm/amd/pm/legacy-dpm/legacy_dpm.c
+++ b/drivers/gpu/drm/amd/pm/legacy-dpm/legacy_dpm.c
@@ -1012,6 +1012,7 @@ void amdgpu_dpm_thermal_work_handler(struct work_struct *work)
 	if (!adev->pm.dpm_enabled)
 		return;
 
+	mutex_lock(&adev->pm.mutex);
 	if (!pp_funcs->read_sensor(adev->powerplay.pp_handle,
 				   AMDGPU_PP_SENSOR_GPU_TEMP,
 				   (void *)&temp,
@@ -1033,4 +1034,5 @@ void amdgpu_dpm_thermal_work_handler(struct work_struct *work)
 	adev->pm.dpm.state = dpm_state;
 
 	amdgpu_legacy_dpm_compute_clocks(adev->powerplay.pp_handle);
+	mutex_unlock(&adev->pm.mutex);
 }
diff --git a/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c b/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c
index a87dcf0974bc1..c40ec4f74afb0 100644
--- a/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c
+++ b/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c
@@ -7786,6 +7786,7 @@ static int si_dpm_hw_init(struct amdgpu_ip_block *ip_block)
 	if (!amdgpu_dpm)
 		return 0;
 
+	mutex_lock(&adev->pm.mutex);
 	si_dpm_setup_asic(adev);
 	ret = si_dpm_enable(adev);
 	if (ret)
@@ -7793,6 +7794,7 @@ static int si_dpm_hw_init(struct amdgpu_ip_block *ip_block)
 	else
 		adev->pm.dpm_enabled = true;
 	amdgpu_legacy_dpm_compute_clocks(adev);
+	mutex_unlock(&adev->pm.mutex);
 	return ret;
 }
 
@@ -7811,11 +7813,15 @@ static int si_dpm_suspend(struct amdgpu_ip_block *ip_block)
 	struct amdgpu_device *adev = ip_block->adev;
 
 	if (adev->pm.dpm_enabled) {
+		mutex_lock(&adev->pm.mutex);
+		adev->pm.dpm_enabled = false;
 		/* disable dpm */
 		si_dpm_disable(adev);
 		/* reset the power state */
 		adev->pm.dpm.current_ps = adev->pm.dpm.requested_ps = adev->pm.dpm.boot_ps;
+		mutex_unlock(&adev->pm.mutex);
 	}
+
 	return 0;
 }
 
@@ -7824,18 +7830,24 @@ static int si_dpm_resume(struct amdgpu_ip_block *ip_block)
 	int ret;
 	struct amdgpu_device *adev = ip_block->adev;
 
-	if (adev->pm.dpm_enabled) {
+	if (!amdgpu_dpm)
+		return 0;
+
+	if (!adev->pm.dpm_enabled) {
 		/* asic init will reset to the boot state */
+		mutex_lock(&adev->pm.mutex);
 		si_dpm_setup_asic(adev);
 		ret = si_dpm_enable(adev);
 		if (ret)
 			adev->pm.dpm_enabled = false;
-		else
+		else {
 			adev->pm.dpm_enabled = true;
-		if (adev->pm.dpm_enabled)
 			amdgpu_legacy_dpm_compute_clocks(adev);
+		}
+		mutex_unlock(&adev->pm.mutex);
 	}
-	return 0;
+
+	return ret;
 }
 
 static bool si_dpm_is_idle(void *handle)
-- 
2.48.1

