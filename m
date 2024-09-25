Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51CB7C369A8
	for <amd-gfx@archiver.kernel.org>; Wed, 25 Sep 2024 07:57:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 083C110E7B0;
	Wed, 25 Sep 2024 07:57:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="iv2g9i1e";
	dkim-atps=neutral
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2084.outbound.protection.outlook.com [40.107.100.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D7F9A10E7AF
 for <amd-gfx@lists.freedesktop.org>; Wed, 25 Sep 2024 07:57:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PPO7kExWm/MmlQZWt+TlBWOOmbGOJnY+8ICbta51CeoaW207IYWUaIdtqas7ghyWJPiJT9tELd4FGSkOuVG0doRP+o3//QjcZRZUZcT5n8Cb0wlytdFZ7LDGPqJoNVBJ8IxlrcfiMgI3A0k42tgMHijNgy+Yd8+wr2XzA0Eywwl3ySe71qNoKjrvZLKrASg5PNaAosxGhHJIklEQ5wHCvvkPi1h7UFeZAnkhaKBd6gIW+Y+nDhGvnrchNHWSHP0NlI6lf33Jar8MBANpc49/+PEZaR8eDGZpuepgOl2+Otf4O/romBRhPC4I+LMCL1IszguuDfinS2Inu1s7AwJHTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RExm6MeUVCDgeUyNMh6R2YFfOFHj4vCNzHVGI0Qwq80=;
 b=OViDBuXeZ+VAY4liw1rpgCdoAJctMPxirvX704GfogV0qUoxtAvKnu22pxldz0r4WiUAJaHSwijh+41UsK9mQpQrTLxjkCBWXGgLmjo/b+jPo0QPtUuduffyaluAkXrNng3Vv5lNessftU2ATJ2+EUUtFvEHd0x4wMkj72a8Us38vPX/nM/mPWbv7gyea94KznkoRTbNSBevejMGHhQfxeyG1NNf6TNyrliSKDIXX/hR8maE1KB+4X9+ariAf9u8G7Uw6J1ID6ie0mvMyQSr7SJ4Fq4Klrgv9PFBW2xQShZ4y1V/CX9uG8EtFbwuLIsAvveQwzSwUGagBvVwgiWqRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RExm6MeUVCDgeUyNMh6R2YFfOFHj4vCNzHVGI0Qwq80=;
 b=iv2g9i1eM/sO8cznh6y/u5r5T7avKEN+iN+rAwMjp/waT8Ceh95y6qg1wZpTv3yVHaeK7Cw3EOZoYE9B6GebseYnRwIujZ8oJbETFTjIlCbhvBWbRTtU1GFLoYQ6Xb7wSo6L/aCq1M0HPp7a8TZpEJ6Xup0yyhQyqvnqb3RI294=
Received: from BYAPR07CA0007.namprd07.prod.outlook.com (2603:10b6:a02:bc::20)
 by DM4PR12MB6062.namprd12.prod.outlook.com (2603:10b6:8:b2::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7982.27; Wed, 25 Sep 2024 07:57:01 +0000
Received: from SJ1PEPF000023CE.namprd02.prod.outlook.com
 (2603:10b6:a02:bc:cafe::d3) by BYAPR07CA0007.outlook.office365.com
 (2603:10b6:a02:bc::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.32 via Frontend
 Transport; Wed, 25 Sep 2024 07:57:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF000023CE.mail.protection.outlook.com (10.167.244.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8005.15 via Frontend Transport; Wed, 25 Sep 2024 07:57:00 +0000
Received: from patedamande.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 25 Sep
 2024 02:56:57 -0500
From: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <alexander.deucher@amd.com>,
 <kenneth.feng@amd.com>, <mario.limonciello@amd.com>
CC: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
Subject: [PATCH v1 4/9] drm/amd/pm: don't update runpm last_usage on debugfs
 getter
Date: Wed, 25 Sep 2024 09:54:28 +0200
Message-ID: <20240925075607.23929-5-pierre-eric.pelloux-prayer@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023CE:EE_|DM4PR12MB6062:EE_
X-MS-Office365-Filtering-Correlation-Id: 3616eed9-65eb-4ded-592d-08dcdd37a331
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?oFpOoSHCW1Rc+zJWqO+1dDRu90xZFYnahQxAt7MM3YEnafH/K/lCp3qnxSNU?=
 =?us-ascii?Q?7UjQ1ZU2/yk1SfsSBDJSRgiAZdfRkyfhQO6j1t3iMBFuPwIkIrC6uIQieJ/j?=
 =?us-ascii?Q?3vv+nhYRsh6WXlAbYX7+5aauRA/Mm7ZoL0Hym2M1/UD6yw1f0R9nVMcRMdH2?=
 =?us-ascii?Q?1VMvEVEYFZDj+EpszPgiycJCnQoEdX3sH9bG4IeHTQ+G9Y1hRIV/VPHpKl9A?=
 =?us-ascii?Q?veT66kTSwrbp1qA0lvPKm5guf612dXEta4gYq1RXxtH91bzwPiZ8g8J31XVf?=
 =?us-ascii?Q?4JpElPeE9e+dBMaU0PXCt/yTGxAbhOxF/g0hYzeEhKVMHoyrh/GoFF26C2h+?=
 =?us-ascii?Q?mSZMdTMyhzMhO3jBs6l43w8LzvR4Ip0v7vLfPlxaH4EI9Ciibk787iYOoBjU?=
 =?us-ascii?Q?m+eIwk5T75XcEhKgDPM4/tSuqT+pZ1xV1NL6iw6iDKDGTIn4CgnArUMwMXC3?=
 =?us-ascii?Q?E+0Z0h3ctnvTbAfSRonYE9uF/pbYyu7UbLKio/sH5y6NgDLQgMfuFwA0RDU+?=
 =?us-ascii?Q?XDBZSQS3/FIEv5jMT7HodJ2zpdUe8QXvVvypiL61pNRLtvdow295ReR3YbAR?=
 =?us-ascii?Q?bfnrN7AudlkG4Nd3/JiJaEbTSgdWWKcbMpy5ZqpVLPYNoFlfUMODxjaQ7w+O?=
 =?us-ascii?Q?wZUum05agtxlTr8K2D2sXqQ/WjQqmRvyQrlq4axIxLp1U7FfWRWxIhFh8531?=
 =?us-ascii?Q?eok0EF20nzlZ+6Su2e2v3qbcY7PYnoAjw5gyVz92KpkX680STTH7PsPH6pJg?=
 =?us-ascii?Q?55YJUp6wemB3y53KKGJENcXoMfa5OjvV1kUAVw2VHmxHdBdgjyQVZ5zlOXoY?=
 =?us-ascii?Q?ZMsWCdfQyBagRaA+Sm4SXv2CWSmEE4RBlYNmgBumAqYmIYc6duig3sD35l8t?=
 =?us-ascii?Q?ouvjKBC+hqamHxd4Z4ve/fyC5OTa2sOcvHwCWvq6dsDF57JiNxq29LV6VlCv?=
 =?us-ascii?Q?9Ytu3hNkhSdO3D9l7/Qwo6XrYknBIk/uWKzv3PnCapr458LZYGhIsoa9ZKtF?=
 =?us-ascii?Q?yyskKmfHyiKamYiJAkA2YV8zaQZC2U2SmSGZJT9+vgAdu4uKs/x5QmqAeSGl?=
 =?us-ascii?Q?ccDHWMO6ZFo0C+N8p+gOQv53xbPqzwOswMJbqiXM9UJyCE5623nuvq9uz+Jp?=
 =?us-ascii?Q?GJkMZjQ0RdbQoQmZj1a9gIaZkAFKB+bPuV0mgieNsEt3F+y4MYVXb+2jl1YL?=
 =?us-ascii?Q?ZZVbUgdwFhTZWtwsXvzHzSUVGVV6EDG5Jx/GyIyTqPFcf9iuhoe0bmcHh1Vr?=
 =?us-ascii?Q?UJmAlA2kH+r0uZMToQECEJp+1IzQR2Db18Fowk8B4yeiNuQXwUPGnqtEw+Ii?=
 =?us-ascii?Q?+Rv3XklNPcyApSIVriJ4svM4NuG76di56siv/fvxUZd22xXlvDUWg3aYGkeA?=
 =?us-ascii?Q?908jX3UHTOAzX+QPS7eI2DbKtxCp?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2024 07:57:00.9065 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3616eed9-65eb-4ded-592d-08dcdd37a331
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000023CE.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6062
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

Reading pm values from the GPU shouldn't prevent it to be suspended
by resetting the last active timestamp (eg: if an background app
monitors GPU sensors every second, it would prevent the autosuspend
sequence to trigger).

Tested-by: Mario Limonciello <mario.limonciello@amd.com>
Signed-off-by: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
---
 drivers/gpu/drm/amd/pm/amdgpu_pm.c | 26 --------------------------
 1 file changed, 26 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
index 042a4dd1bd6a..c8f34b1a4d8e 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
@@ -151,7 +151,6 @@ static ssize_t amdgpu_get_power_dpm_state(struct device *dev,
 
 	amdgpu_dpm_get_current_power_state(adev, &pm);
 
-	pm_runtime_mark_last_busy(ddev->dev);
 	pm_runtime_put_autosuspend(ddev->dev);
 
 	return sysfs_emit(buf, "%s\n",
@@ -275,7 +274,6 @@ static ssize_t amdgpu_get_power_dpm_force_performance_level(struct device *dev,
 
 	level = amdgpu_dpm_get_performance_level(adev);
 
-	pm_runtime_mark_last_busy(ddev->dev);
 	pm_runtime_put_autosuspend(ddev->dev);
 
 	return sysfs_emit(buf, "%s\n",
@@ -373,7 +371,6 @@ static ssize_t amdgpu_get_pp_num_states(struct device *dev,
 	if (amdgpu_dpm_get_pp_num_states(adev, &data))
 		memset(&data, 0, sizeof(data));
 
-	pm_runtime_mark_last_busy(ddev->dev);
 	pm_runtime_put_autosuspend(ddev->dev);
 
 	buf_len = sysfs_emit(buf, "states: %d\n", data.nums);
@@ -410,7 +407,6 @@ static ssize_t amdgpu_get_pp_cur_state(struct device *dev,
 
 	ret = amdgpu_dpm_get_pp_num_states(adev, &data);
 
-	pm_runtime_mark_last_busy(ddev->dev);
 	pm_runtime_put_autosuspend(ddev->dev);
 
 	if (ret)
@@ -536,7 +532,6 @@ static ssize_t amdgpu_get_pp_table(struct device *dev,
 
 	size = amdgpu_dpm_get_pp_table(adev, &table);
 
-	pm_runtime_mark_last_busy(ddev->dev);
 	pm_runtime_put_autosuspend(ddev->dev);
 
 	if (size <= 0)
@@ -866,7 +861,6 @@ static ssize_t amdgpu_get_pp_od_clk_voltage(struct device *dev,
 	if (size == 0)
 		size = sysfs_emit(buf, "\n");
 
-	pm_runtime_mark_last_busy(ddev->dev);
 	pm_runtime_put_autosuspend(ddev->dev);
 
 	return size;
@@ -944,7 +938,6 @@ static ssize_t amdgpu_get_pp_features(struct device *dev,
 	if (size <= 0)
 		size = sysfs_emit(buf, "\n");
 
-	pm_runtime_mark_last_busy(ddev->dev);
 	pm_runtime_put_autosuspend(ddev->dev);
 
 	return size;
@@ -1014,7 +1007,6 @@ static ssize_t amdgpu_get_pp_dpm_clock(struct device *dev,
 	if (size == 0)
 		size = sysfs_emit(buf, "\n");
 
-	pm_runtime_mark_last_busy(ddev->dev);
 	pm_runtime_put_autosuspend(ddev->dev);
 
 	return size;
@@ -1259,7 +1251,6 @@ static ssize_t amdgpu_get_pp_sclk_od(struct device *dev,
 
 	value = amdgpu_dpm_get_sclk_od(adev);
 
-	pm_runtime_mark_last_busy(ddev->dev);
 	pm_runtime_put_autosuspend(ddev->dev);
 
 	return sysfs_emit(buf, "%d\n", value);
@@ -1317,7 +1308,6 @@ static ssize_t amdgpu_get_pp_mclk_od(struct device *dev,
 
 	value = amdgpu_dpm_get_mclk_od(adev);
 
-	pm_runtime_mark_last_busy(ddev->dev);
 	pm_runtime_put_autosuspend(ddev->dev);
 
 	return sysfs_emit(buf, "%d\n", value);
@@ -1397,7 +1387,6 @@ static ssize_t amdgpu_get_pp_power_profile_mode(struct device *dev,
 	if (size <= 0)
 		size = sysfs_emit(buf, "\n");
 
-	pm_runtime_mark_last_busy(ddev->dev);
 	pm_runtime_put_autosuspend(ddev->dev);
 
 	return size;
@@ -1485,7 +1474,6 @@ static int amdgpu_hwmon_get_sensor_generic(struct amdgpu_device *adev,
 	/* get the sensor value */
 	r = amdgpu_dpm_read_sensor(adev, sensor, query, &size);
 
-	pm_runtime_mark_last_busy(adev_to_drm(adev)->dev);
 	pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);
 
 	return r;
@@ -1601,7 +1589,6 @@ static ssize_t amdgpu_get_pcie_bw(struct device *dev,
 
 	amdgpu_asic_get_pcie_usage(adev, &count0, &count1);
 
-	pm_runtime_mark_last_busy(ddev->dev);
 	pm_runtime_put_autosuspend(ddev->dev);
 
 	return sysfs_emit(buf, "%llu %llu %i\n",
@@ -1734,7 +1721,6 @@ static ssize_t amdgpu_get_apu_thermal_cap(struct device *dev,
 	else
 		size = sysfs_emit(buf, "failed to get thermal limit\n");
 
-	pm_runtime_mark_last_busy(ddev->dev);
 	pm_runtime_put_autosuspend(ddev->dev);
 
 	return size;
@@ -1807,7 +1793,6 @@ static ssize_t amdgpu_get_pm_metrics(struct device *dev,
 
 	size = amdgpu_dpm_get_pm_metrics(adev, buf, PAGE_SIZE);
 
-	pm_runtime_mark_last_busy(ddev->dev);
 	pm_runtime_put_autosuspend(ddev->dev);
 
 	return size;
@@ -1854,7 +1839,6 @@ static ssize_t amdgpu_get_gpu_metrics(struct device *dev,
 	memcpy(buf, gpu_metrics, size);
 
 out:
-	pm_runtime_mark_last_busy(ddev->dev);
 	pm_runtime_put_autosuspend(ddev->dev);
 
 	return size;
@@ -2722,7 +2706,6 @@ static ssize_t amdgpu_hwmon_get_pwm1_enable(struct device *dev,
 
 	ret = amdgpu_dpm_get_fan_control_mode(adev, &pwm_mode);
 
-	pm_runtime_mark_last_busy(adev_to_drm(adev)->dev);
 	pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);
 
 	if (ret)
@@ -2851,7 +2834,6 @@ static ssize_t amdgpu_hwmon_get_pwm1(struct device *dev,
 
 	err = amdgpu_dpm_get_fan_speed_pwm(adev, &speed);
 
-	pm_runtime_mark_last_busy(adev_to_drm(adev)->dev);
 	pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);
 
 	if (err)
@@ -2879,7 +2861,6 @@ static ssize_t amdgpu_hwmon_get_fan1_input(struct device *dev,
 
 	err = amdgpu_dpm_get_fan_speed_rpm(adev, &speed);
 
-	pm_runtime_mark_last_busy(adev_to_drm(adev)->dev);
 	pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);
 
 	if (err)
@@ -2941,7 +2922,6 @@ static ssize_t amdgpu_hwmon_get_fan1_target(struct device *dev,
 
 	err = amdgpu_dpm_get_fan_speed_rpm(adev, &rpm);
 
-	pm_runtime_mark_last_busy(adev_to_drm(adev)->dev);
 	pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);
 
 	if (err)
@@ -3012,7 +2992,6 @@ static ssize_t amdgpu_hwmon_get_fan1_enable(struct device *dev,
 
 	ret = amdgpu_dpm_get_fan_control_mode(adev, &pwm_mode);
 
-	pm_runtime_mark_last_busy(adev_to_drm(adev)->dev);
 	pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);
 
 	if (ret)
@@ -3053,7 +3032,6 @@ static ssize_t amdgpu_hwmon_set_fan1_enable(struct device *dev,
 
 	err = amdgpu_dpm_set_fan_control_mode(adev, pwm_mode);
 
-	pm_runtime_mark_last_busy(adev_to_drm(adev)->dev);
 	pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);
 
 	if (err)
@@ -3186,7 +3164,6 @@ static ssize_t amdgpu_hwmon_show_power_cap_generic(struct device *dev,
 	else
 		size = sysfs_emit(buf, "\n");
 
-	pm_runtime_mark_last_busy(adev_to_drm(adev)->dev);
 	pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);
 
 	return size;
@@ -3269,7 +3246,6 @@ static ssize_t amdgpu_hwmon_set_power_cap(struct device *dev,
 
 	err = amdgpu_dpm_set_power_limit(adev, value);
 
-	pm_runtime_mark_last_busy(adev_to_drm(adev)->dev);
 	pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);
 
 	if (err)
@@ -3717,7 +3693,6 @@ static int amdgpu_retrieve_od_settings(struct amdgpu_device *adev,
 	if (size == 0)
 		size = sysfs_emit(buf, "\n");
 
-	pm_runtime_mark_last_busy(adev->dev);
 	pm_runtime_put_autosuspend(adev->dev);
 
 	return size;
@@ -4694,7 +4669,6 @@ static int amdgpu_debugfs_pm_info_show(struct seq_file *m, void *unused)
 	seq_printf(m, "\n");
 
 out:
-	pm_runtime_mark_last_busy(dev->dev);
 	pm_runtime_put_autosuspend(dev->dev);
 
 	return r;
-- 
2.40.1

