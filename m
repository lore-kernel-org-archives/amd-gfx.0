Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0134BC369A8
	for <amd-gfx@archiver.kernel.org>; Wed, 25 Sep 2024 07:57:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A0AA210E7B4;
	Wed, 25 Sep 2024 07:57:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="3gec5piu";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2046.outbound.protection.outlook.com [40.107.237.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2C3B210E7B4
 for <amd-gfx@lists.freedesktop.org>; Wed, 25 Sep 2024 07:57:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=t7HrFglTSyyR9s7l96zKVifhI1T9HyI4PsPNuubqKOtFeQhXAsY9m3LueyOOhNJcsRhItbIb2fJshA2uT9/2DuQ/AzoJdTKreRoeLtFy/x8FH+P6kyDKVZGy9Pj314PN8PjpuIaQUx1hqfJV/d3810J2OPD60YMQgSQAlHM73Qr/Dw66qdjQ5e4/qfFWo3p2Wk3Vc80lhOFgUn5lU3Qa8RR3GLebOHJWktongVKcAw/y1CsVEnt02pO/x5J9T1GE7n1SPeMD29r2VLa+DPOLe2nRQ1yKEaHBcuAZnqS8KwaBwheCiMdfeBiIABQyFkdXPj/2++/pxBjWrGucJrhjug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6TwNqIakwDNh5RcxDmNr2FO1Ttl5gk069T2vVsDg01o=;
 b=TLE2bALoYpidRS7Hw6rW+zVtbQK57H6ihSbkA429SVI2TeB6u/I2JWw7w29KmReFLiT36YEOM/hdo91GE4E3hqpxnZ+PH/ZK/YgzFi2Lun2fnIdcIqDmjeCcfI4f/gIbksBXE/FqXlPpHsqCTVh+yjEaC0SOegLadODJfjuaBeJ0fAtCIsJWYI2lgPxZZTCrF/0fdEdo5bOfA4fG+5XkzQWBvjKUVyI4vyTZhUEAYWDa4TaseQ+v1m8njGflPDyfnKxH9/qdoZrNYBDPw1rtgjl/N7qAWXeE7bnXQhsCd+6FqTTt7dP16rmZ5KexxhhON9uLZJEJ6PQPWOTufeLFzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6TwNqIakwDNh5RcxDmNr2FO1Ttl5gk069T2vVsDg01o=;
 b=3gec5piuWvB4K9XkL00HFGKGqxfhIzm9mSmLBqoqkcwJJT+9ixMXnScdrJ6G6D1JmXqn8tFhJSLQFQniPhCr70eaX5G5qERK7DxIV9OPBv1/lcm/SFD2fTQAqzuuWKnFV1a9H6xAWO7X6bYRFVVQlzJWDxLsjjEEumoS/9VccsM=
Received: from BYAPR07CA0032.namprd07.prod.outlook.com (2603:10b6:a02:bc::45)
 by PH7PR12MB6833.namprd12.prod.outlook.com (2603:10b6:510:1af::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.29; Wed, 25 Sep
 2024 07:57:06 +0000
Received: from SJ1PEPF000023CE.namprd02.prod.outlook.com
 (2603:10b6:a02:bc:cafe::54) by BYAPR07CA0032.outlook.office365.com
 (2603:10b6:a02:bc::45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.29 via Frontend
 Transport; Wed, 25 Sep 2024 07:57:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF000023CE.mail.protection.outlook.com (10.167.244.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8005.15 via Frontend Transport; Wed, 25 Sep 2024 07:57:05 +0000
Received: from patedamande.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 25 Sep
 2024 02:56:59 -0500
From: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <alexander.deucher@amd.com>,
 <kenneth.feng@amd.com>, <mario.limonciello@amd.com>
CC: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
Subject: [PATCH v1 5/9] drm/amd/pm: use pm_runtime_get_if_active for debugfs
 getters
Date: Wed, 25 Sep 2024 09:54:29 +0200
Message-ID: <20240925075607.23929-6-pierre-eric.pelloux-prayer@amd.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240925075607.23929-1-pierre-eric.pelloux-prayer@amd.com>
References: <20240925075607.23929-1-pierre-eric.pelloux-prayer@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023CE:EE_|PH7PR12MB6833:EE_
X-MS-Office365-Filtering-Correlation-Id: 77cac6f4-2943-400c-49af-08dcdd37a62c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?il3OmNr9lMoUmcrIvu7R9digdhtFJmzZC4lWunrXOJN0eukpRWCF9/m6IYY3?=
 =?us-ascii?Q?fEgUOcXQ6SOXpIsnytymket5sE2ytetWY4sgwF99OxDnbg1ag46FxWqhyM/V?=
 =?us-ascii?Q?1+uqKCcTJxT3D18BWfjskcfpxxko9xv7cs9NdqXWbTcKZU5d8wZroxKte23r?=
 =?us-ascii?Q?nl9jdTthMKvHNmHfY0lGXNrLILrGLC3a64DYizKoC8nBfuOOSLSz+oO5encq?=
 =?us-ascii?Q?I7RH74ERwOoIa1LMK+a+JYQwEGcmgl/O4x9/Z9eUCE1CaVl468mRCbf9Xr+k?=
 =?us-ascii?Q?IDBzJNIhHD63TqHbShZ5i+0LPV8b+Yapki1laUrrq/55TsXgmYL7YioGPpj+?=
 =?us-ascii?Q?B9Vm5dA8pW6H5+B4ox2w7QDzHfW8hVn1Jyh4aInpF2RGTxKqKqifvM/iDSQ6?=
 =?us-ascii?Q?hjUDnT6pAGtxaHW47sLSCPYFU1dkgsswnUyeaic8TH5T3jPXE+XTSb0yHecJ?=
 =?us-ascii?Q?Dq7Rf4Dv2Xr3lHCpYSeaBkqDUwkRbbAO8xNUaRzwj3a+0Hx+9JGCo+GY5Xeg?=
 =?us-ascii?Q?beq5Y1/lQDw0s8/wSPRbnNffynRtnIpaV3ShU1Kf91ldxoCHjd1+USr81WRr?=
 =?us-ascii?Q?8nPs+/+B8SqcwwjgCT5araTpgrZMrELFl7BeZcM9qCdcLV8FpQyH27KIM18S?=
 =?us-ascii?Q?PXaEbXBaSoJphQCSS3W1xtmGQmW1Mx4xcNj5JxT0C5N7lKMwPRWMtwf0FdU2?=
 =?us-ascii?Q?ne7tRpTA7XcuSVlc3eErVvcXMersoqHFYLD6jk0AHcmv6f8/E1n26MBHflCe?=
 =?us-ascii?Q?zhnX6OGPbg11MUjYueeyFwD7Vj6+2iXB1G/j7VVv+I/uJCDHmCDZ8W9G/lIN?=
 =?us-ascii?Q?aLN7DbJl7squYb4cWgVx54y5JR5HtIge4b0RkUGIubJ1wIn/Ym/WCBTjSGTL?=
 =?us-ascii?Q?HFQNiPmltqWiX3i9kGOkRUJ6jye+imrYwC5Y8teUBP0BZB2lhR7VV3b7Mw/S?=
 =?us-ascii?Q?dYe8zz1ffhfuqYfCFJy6KUaBWhJUsskPFHH3RJy3lVnqRnLYFbchvqydWSOz?=
 =?us-ascii?Q?bUMmdafscx/rV3entw7z+MSrFW1S4mS4ae2mzOITS38WnG7vhqLQ/rljQQlm?=
 =?us-ascii?Q?3dT5pyQQuSAS9xVYHWaYQBf8a4Rm9pafr0aZIShW0q6gXVD3/8tNsL5ZxBQK?=
 =?us-ascii?Q?7wrjSboJ7jUjY5PkaDRem1lNpiknXvojTHtXGe6Uk5/vRnHjhzWJZvDsqiWx?=
 =?us-ascii?Q?89R2JBvhqxdBIv28sZOCd2oqbXGI8/+Z61CD+ZRBFGItJzY+Di+b4l2bF4NO?=
 =?us-ascii?Q?XPBmGwzGpO1ahq3Y3V/De3S8gYcdIbIwFYtqDZZEBmMMthWhUZz0fFy8CHcn?=
 =?us-ascii?Q?UyHa3SMVG+ZA8TJ11kvMkJQ7bYJEpUePg19oEZ5/cAxhDtlOfATkX5T0POOh?=
 =?us-ascii?Q?G9ImoHxmMqLZ8NfHlZKKwayr6Dpju9yTuYcs3tirgCc90ozJYqX1vmpGnJlc?=
 =?us-ascii?Q?42uf7SipL/roDgT1DRMI6tjkmamn6+/r?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2024 07:57:05.9065 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 77cac6f4-2943-400c-49af-08dcdd37a62c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000023CE.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6833
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

Don't wake up the GPU for reading pm values. Instead, take a runtime
powermanagement ref when trying to read it iff the GPU is already
awake.

This avoids spurious wake ups (eg: from applets).

We use pm_runtime_get_if_in_active(ign_usage_count=true) because we care
about "is the GPU awake?" not about "is the GPU awake and something else
prevents suspend?".

Tested-by: Mario Limonciello <mario.limonciello@amd.com>
Signed-off-by: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
---
 drivers/gpu/drm/amd/pm/amdgpu_pm.c | 138 ++++++++++++++---------------
 1 file changed, 69 insertions(+), 69 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
index c8f34b1a4d8e..f1f339b75380 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
@@ -145,9 +145,9 @@ static ssize_t amdgpu_get_power_dpm_state(struct device *dev,
 	if (adev->in_suspend && !adev->in_runpm)
 		return -EPERM;
 
-	ret = pm_runtime_resume_and_get(ddev->dev);
-	if (ret < 0)
-		return ret;
+	ret = pm_runtime_get_if_active(ddev->dev, true);
+	if (ret <= 0)
+		return ret ?: -EPERM;
 
 	amdgpu_dpm_get_current_power_state(adev, &pm);
 
@@ -268,9 +268,9 @@ static ssize_t amdgpu_get_power_dpm_force_performance_level(struct device *dev,
 	if (adev->in_suspend && !adev->in_runpm)
 		return -EPERM;
 
-	ret = pm_runtime_resume_and_get(ddev->dev);
-	if (ret < 0)
-		return ret;
+	ret = pm_runtime_get_if_active(ddev->dev, true);
+	if (ret <= 0)
+		return ret ?: -EPERM;
 
 	level = amdgpu_dpm_get_performance_level(adev);
 
@@ -364,9 +364,9 @@ static ssize_t amdgpu_get_pp_num_states(struct device *dev,
 	if (adev->in_suspend && !adev->in_runpm)
 		return -EPERM;
 
-	ret = pm_runtime_resume_and_get(ddev->dev);
-	if (ret < 0)
-		return ret;
+	ret = pm_runtime_get_if_active(ddev->dev, true);
+	if (ret <= 0)
+		return ret ?: -EPERM;
 
 	if (amdgpu_dpm_get_pp_num_states(adev, &data))
 		memset(&data, 0, sizeof(data));
@@ -399,9 +399,9 @@ static ssize_t amdgpu_get_pp_cur_state(struct device *dev,
 	if (adev->in_suspend && !adev->in_runpm)
 		return -EPERM;
 
-	ret = pm_runtime_resume_and_get(ddev->dev);
-	if (ret < 0)
-		return ret;
+	ret = pm_runtime_get_if_active(ddev->dev, true);
+	if (ret <= 0)
+		return ret ?: -EPERM;
 
 	amdgpu_dpm_get_current_power_state(adev, &pm);
 
@@ -526,9 +526,9 @@ static ssize_t amdgpu_get_pp_table(struct device *dev,
 	if (adev->in_suspend && !adev->in_runpm)
 		return -EPERM;
 
-	ret = pm_runtime_resume_and_get(ddev->dev);
-	if (ret < 0)
-		return ret;
+	ret = pm_runtime_get_if_active(ddev->dev, true);
+	if (ret <= 0)
+		return ret ?: -EPERM;
 
 	size = amdgpu_dpm_get_pp_table(adev, &table);
 
@@ -840,9 +840,9 @@ static ssize_t amdgpu_get_pp_od_clk_voltage(struct device *dev,
 	if (adev->in_suspend && !adev->in_runpm)
 		return -EPERM;
 
-	ret = pm_runtime_resume_and_get(ddev->dev);
-	if (ret < 0)
-		return ret;
+	ret = pm_runtime_get_if_active(ddev->dev, true);
+	if (ret <= 0)
+		return ret ?: -EPERM;
 
 	for (clk_index = 0 ; clk_index < 6 ; clk_index++) {
 		ret = amdgpu_dpm_emit_clock_levels(adev, od_clocks[clk_index], buf, &size);
@@ -930,9 +930,9 @@ static ssize_t amdgpu_get_pp_features(struct device *dev,
 	if (adev->in_suspend && !adev->in_runpm)
 		return -EPERM;
 
-	ret = pm_runtime_resume_and_get(ddev->dev);
-	if (ret < 0)
-		return ret;
+	ret = pm_runtime_get_if_active(ddev->dev, true);
+	if (ret <= 0)
+		return ret ?: -EPERM;
 
 	size = amdgpu_dpm_get_ppfeature_status(adev, buf);
 	if (size <= 0)
@@ -996,9 +996,9 @@ static ssize_t amdgpu_get_pp_dpm_clock(struct device *dev,
 	if (adev->in_suspend && !adev->in_runpm)
 		return -EPERM;
 
-	ret = pm_runtime_resume_and_get(ddev->dev);
-	if (ret < 0)
-		return ret;
+	ret = pm_runtime_get_if_active(ddev->dev, true);
+	if (ret <= 0)
+		return ret ?: -EPERM;
 
 	ret = amdgpu_dpm_emit_clock_levels(adev, type, buf, &size);
 	if (ret == -ENOENT)
@@ -1245,9 +1245,9 @@ static ssize_t amdgpu_get_pp_sclk_od(struct device *dev,
 	if (adev->in_suspend && !adev->in_runpm)
 		return -EPERM;
 
-	ret = pm_runtime_resume_and_get(ddev->dev);
-	if (ret < 0)
-		return ret;
+	ret = pm_runtime_get_if_active(ddev->dev, true);
+	if (ret <= 0)
+		return ret ?: -EPERM;
 
 	value = amdgpu_dpm_get_sclk_od(adev);
 
@@ -1302,9 +1302,9 @@ static ssize_t amdgpu_get_pp_mclk_od(struct device *dev,
 	if (adev->in_suspend && !adev->in_runpm)
 		return -EPERM;
 
-	ret = pm_runtime_resume_and_get(ddev->dev);
-	if (ret < 0)
-		return ret;
+	ret = pm_runtime_get_if_active(ddev->dev, true);
+	if (ret <= 0)
+		return ret ?: -EPERM;
 
 	value = amdgpu_dpm_get_mclk_od(adev);
 
@@ -1379,9 +1379,9 @@ static ssize_t amdgpu_get_pp_power_profile_mode(struct device *dev,
 	if (adev->in_suspend && !adev->in_runpm)
 		return -EPERM;
 
-	ret = pm_runtime_resume_and_get(ddev->dev);
-	if (ret < 0)
-		return ret;
+	ret = pm_runtime_get_if_active(ddev->dev, true);
+	if (ret <= 0)
+		return ret ?: -EPERM;
 
 	size = amdgpu_dpm_get_power_profile_mode(adev, buf);
 	if (size <= 0)
@@ -1467,9 +1467,9 @@ static int amdgpu_hwmon_get_sensor_generic(struct amdgpu_device *adev,
 	if (adev->in_suspend && !adev->in_runpm)
 		return -EPERM;
 
-	r = pm_runtime_resume_and_get(adev->dev);
-	if (r < 0)
-		return r;
+	r = pm_runtime_get_if_active(adev->dev, true);
+	if (r <= 0)
+		return r ?: -EPERM;
 
 	/* get the sensor value */
 	r = amdgpu_dpm_read_sensor(adev, sensor, query, &size);
@@ -1583,9 +1583,9 @@ static ssize_t amdgpu_get_pcie_bw(struct device *dev,
 	if (!adev->asic_funcs->get_pcie_usage)
 		return -ENODATA;
 
-	ret = pm_runtime_resume_and_get(ddev->dev);
-	if (ret < 0)
-		return ret;
+	ret = pm_runtime_get_if_active(ddev->dev, true);
+	if (ret <= 0)
+		return ret ?: -EPERM;
 
 	amdgpu_asic_get_pcie_usage(adev, &count0, &count1);
 
@@ -1711,9 +1711,9 @@ static ssize_t amdgpu_get_apu_thermal_cap(struct device *dev,
 	struct drm_device *ddev = dev_get_drvdata(dev);
 	struct amdgpu_device *adev = drm_to_adev(ddev);
 
-	ret = pm_runtime_resume_and_get(ddev->dev);
-	if (ret < 0)
-		return ret;
+	ret = pm_runtime_get_if_active(ddev->dev, true);
+	if (ret <= 0)
+		return ret ?: -EPERM;
 
 	ret = amdgpu_dpm_get_apu_thermal_limit(adev, &limit);
 	if (!ret)
@@ -1787,9 +1787,9 @@ static ssize_t amdgpu_get_pm_metrics(struct device *dev,
 	if (adev->in_suspend && !adev->in_runpm)
 		return -EPERM;
 
-	ret = pm_runtime_resume_and_get(ddev->dev);
-	if (ret < 0)
-		return ret;
+	ret = pm_runtime_get_if_active(ddev->dev, true);
+	if (ret <= 0)
+		return ret ?: -EPERM;
 
 	size = amdgpu_dpm_get_pm_metrics(adev, buf, PAGE_SIZE);
 
@@ -1825,9 +1825,9 @@ static ssize_t amdgpu_get_gpu_metrics(struct device *dev,
 	if (adev->in_suspend && !adev->in_runpm)
 		return -EPERM;
 
-	ret = pm_runtime_resume_and_get(ddev->dev);
-	if (ret < 0)
-		return ret;
+	ret = pm_runtime_get_if_active(ddev->dev, true);
+	if (ret <= 0)
+		return ret ?: -EPERM;
 
 	size = amdgpu_dpm_get_gpu_metrics(adev, &gpu_metrics);
 	if (size <= 0)
@@ -2700,9 +2700,9 @@ static ssize_t amdgpu_hwmon_get_pwm1_enable(struct device *dev,
 	if (adev->in_suspend && !adev->in_runpm)
 		return -EPERM;
 
-	ret = pm_runtime_resume_and_get(adev->dev);
-	if (ret < 0)
-		return ret;
+	ret = pm_runtime_get_if_active(adev->dev, true);
+	if (ret <= 0)
+		return ret ?: -EPERM;
 
 	ret = amdgpu_dpm_get_fan_control_mode(adev, &pwm_mode);
 
@@ -2828,9 +2828,9 @@ static ssize_t amdgpu_hwmon_get_pwm1(struct device *dev,
 	if (adev->in_suspend && !adev->in_runpm)
 		return -EPERM;
 
-	err = pm_runtime_resume_and_get(adev->dev);
-	if (err < 0)
-		return err;
+	err = pm_runtime_get_if_active(adev->dev, true);
+	if (err <= 0)
+		return err ?: -EPERM;
 
 	err = amdgpu_dpm_get_fan_speed_pwm(adev, &speed);
 
@@ -2855,9 +2855,9 @@ static ssize_t amdgpu_hwmon_get_fan1_input(struct device *dev,
 	if (adev->in_suspend && !adev->in_runpm)
 		return -EPERM;
 
-	err = pm_runtime_resume_and_get(adev->dev);
-	if (err < 0)
-		return err;
+	err = pm_runtime_get_if_active(adev->dev, true);
+	if (err <= 0)
+		return err ?: -EPERM;
 
 	err = amdgpu_dpm_get_fan_speed_rpm(adev, &speed);
 
@@ -2916,9 +2916,9 @@ static ssize_t amdgpu_hwmon_get_fan1_target(struct device *dev,
 	if (adev->in_suspend && !adev->in_runpm)
 		return -EPERM;
 
-	err = pm_runtime_resume_and_get(adev->dev);
-	if (err < 0)
-		return err;
+	err = pm_runtime_get_if_active(adev->dev, true);
+	if (err <= 0)
+		return err ?: -EPERM;
 
 	err = amdgpu_dpm_get_fan_speed_rpm(adev, &rpm);
 
@@ -2986,9 +2986,9 @@ static ssize_t amdgpu_hwmon_get_fan1_enable(struct device *dev,
 	if (adev->in_suspend && !adev->in_runpm)
 		return -EPERM;
 
-	ret = pm_runtime_resume_and_get(adev->dev);
-	if (ret < 0)
-		return ret;
+	ret = pm_runtime_get_if_active(adev->dev, true);
+	if (ret <= 0)
+		return ret ?: -EPERM;
 
 	ret = amdgpu_dpm_get_fan_control_mode(adev, &pwm_mode);
 
@@ -3152,9 +3152,9 @@ static ssize_t amdgpu_hwmon_show_power_cap_generic(struct device *dev,
 	if (adev->in_suspend && !adev->in_runpm)
 		return -EPERM;
 
-	r = pm_runtime_resume_and_get(adev->dev);
-	if (r < 0)
-		return r;
+	r = pm_runtime_get_if_active(adev->dev, true);
+	if (r <= 0)
+		return r ?: -EPERM;
 
 	r = amdgpu_dpm_get_power_limit(adev, &limit,
 				      pp_limit_level, power_type);
@@ -3685,9 +3685,9 @@ static int amdgpu_retrieve_od_settings(struct amdgpu_device *adev,
 	if (adev->in_suspend && !adev->in_runpm)
 		return -EPERM;
 
-	ret = pm_runtime_resume_and_get(adev->dev);
-	if (ret < 0)
-		return ret;
+	ret = pm_runtime_get_if_active(adev->dev, true);
+	if (ret <= 0)
+		return ret ?: -EPERM;
 
 	size = amdgpu_dpm_print_clock_levels(adev, od_type, buf);
 	if (size == 0)
-- 
2.40.1

