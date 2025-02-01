Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25E65C0218A
	for <amd-gfx@archiver.kernel.org>; Sat,  1 Feb 2025 04:27:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 97E8B10E072;
	Sat,  1 Feb 2025 04:27:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ucqx1A1m";
	dkim-atps=neutral
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2089.outbound.protection.outlook.com [40.107.212.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3DEA310E072
 for <amd-gfx@lists.freedesktop.org>; Sat,  1 Feb 2025 04:27:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Q4uGzxgvlzca3eMHy0b4lMEGF6RbVs0rSOhbIaqeFIndJo5ssvY2k6aRcQmIs3CyE+pxV0Vz0e5J8xj2iuvQFpp14HLKhz1VF1MSA408AG8ub7Pplr0Q+WWBD9m7NvtWCiJvaoSxgGK+bSRCnmz8M2YFkgWfGcX9t0ISJ0rkQWoWQUm63gmo5DSQkN0dwMo7ZUMuieTDTid7Sih0EYD7zOnLzU+K3JjHk+O8BcX3GWQ5mRKFwJS8WV5zGV9DZU4vyMa0YqHY2XQvbQ/Hcy9cJ2VdMl890muyaS1yCApnMzm3p8QEpc4IBD7iv6cCd3l1CARXL3ef+OaC1ZYUlNKStQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W1cMeNf4blWBujfb0+CcgqPkczJFVb+CRtOVismj0MU=;
 b=sEzEdJJiT7acBzJS8OPYmGNfLjhjtBGFAsOcRnCFT/00N4l1uTk7JKzKW25ROSohXwlJw7OYLB0Mw5gxoHFBCgqRQ6kMKcN4LvlPDerxXmWRqfE1gUr4xpN58SjhgDYIAYZ5PXvXM0vtwt5PeytrF/PDHFtQ/DuCBsHtkVG+YlJ3sQcYdWOI/3aR0khuv8iDrDXa7obA3+Z5V9j7BD1wsOjDafPaQiax1sBF4Cy1bT5NlXeGTzvWFv3763sGoj5rxVWbtzOqHfDAaVNKjcg22jMzeVXPwbhd4xbpeD4OlxmhyYAmM/6pDwAUw3OKzuvgLZVkamwhWLeSHJA7SdygAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W1cMeNf4blWBujfb0+CcgqPkczJFVb+CRtOVismj0MU=;
 b=ucqx1A1moTTWOz91EHn9GWXLShH6LJccZoU6ibnNskW7Y2J9La4Rf57ijySHA0y8szNybMNGkOE8AT9opQ/biIbyz57k1Rx+fTl9uSrzklnvub1iPegEQADnElzVxhf75ljwxAWXvUMy+5sTvAwsmhi05as6oyHENPF6k5qwmb4=
Received: from MW4PR03CA0054.namprd03.prod.outlook.com (2603:10b6:303:8e::29)
 by CH3PR12MB9432.namprd12.prod.outlook.com (2603:10b6:610:1c7::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.18; Sat, 1 Feb
 2025 04:26:58 +0000
Received: from SJ5PEPF000001EC.namprd05.prod.outlook.com
 (2603:10b6:303:8e:cafe::a) by MW4PR03CA0054.outlook.office365.com
 (2603:10b6:303:8e::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.20 via Frontend Transport; Sat,
 1 Feb 2025 04:26:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF000001EC.mail.protection.outlook.com (10.167.242.200) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8398.14 via Frontend Transport; Sat, 1 Feb 2025 04:26:57 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 31 Jan
 2025 22:26:54 -0600
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Alexander.Deucher@amd.com>,
 <pierre-eric.pelloux-prayer@amd.com>, <kenneth.feng@amd.com>,
 <mario.limonciello@amd.com>
Subject: [PATCH] drm/amd/pm: Fix get_if_active usage
Date: Sat, 1 Feb 2025 09:56:39 +0530
Message-ID: <20250201042639.1805796-1-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001EC:EE_|CH3PR12MB9432:EE_
X-MS-Office365-Filtering-Correlation-Id: 597bb504-a415-464c-1561-08dd4278aa72
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?SDJHQy0UjMJWCbBJfLsbW05gHS11gZeaXZmWwJgAHeD8tK/ODrr6+c+CBEEj?=
 =?us-ascii?Q?VCjvCBAKcla34PGMIB95A1nYuoQBQgXEbCg0RIfzsmaBc2y9PYe1QhnWaWt4?=
 =?us-ascii?Q?3cHuEBs8erSK0p2XH5RCQKlJ7UGbwQnnXbxt6XUxMrznFlph+VHuSnVctdey?=
 =?us-ascii?Q?0Nc8ROeFvzvfZdAU1Nva7n4yRnS/hXmX5xrk8NdQzdQNn1A/XXWkNjApr6Al?=
 =?us-ascii?Q?9cm75nwSc0PDrCZOEQF3cEChDGVYSM1byJ7YxjLoFO6ay1W1rTxcV6UDaBUc?=
 =?us-ascii?Q?X1crNU6N5ZxdeH/go7jthv27slrzJIKsoRVcAHWR32XHMyjR062y1aSHiz/U?=
 =?us-ascii?Q?0PBtSP0HyyHCmehEzMKxcMFKGG1r3l5wxF003wwX8edNBblswtb3GCShItq6?=
 =?us-ascii?Q?s6IKYwg7yyWnERbL/gUu9npqj0yquphMEA2Agf957hwt6VLZ/sctmTVZga9j?=
 =?us-ascii?Q?qrBmRA0YbbCWPLzgwHLrq+2mEmxYYYF707dHLfy6/ziEbsZyaLEVnj79yYWQ?=
 =?us-ascii?Q?lLz7GNCxY65lVE2XdAgUfWkiYrK/w/s0Gi50Dq7KsYy8TiWP2TSws2jur0uW?=
 =?us-ascii?Q?N4XwYILK3DQCRY0eDX9X9ONp3J+JNsu6s6J7xddTucyrXW9kxE0YZUyfW6kZ?=
 =?us-ascii?Q?eatm+SRsnKCOUCc6uwrnMlZia75SfX+4sP98VMezLs6vRk36aUv/QHN6rXR8?=
 =?us-ascii?Q?yACgHAvqw7abL9iuA7mCyTkLn2IR8Xz7u95tQj56bAsQ1CbZlqNYps5Jkiue?=
 =?us-ascii?Q?GZ+PnTwVIHdu93ncnsFIR+l6THJeTLdZ6pnxgb0Gw4s+siLMU+pAdHL8fOCx?=
 =?us-ascii?Q?Egx85hIS9HJJBKk5uAOtMeQEuEaUphSx5BdxX0o9bM0xIQtnzc546IZOzrcp?=
 =?us-ascii?Q?6yBvNXE2wyW5Gc5+YZW7q5aWNs+u1dQXy8G4HpEJkDJD2K9UVRWcO7S27wJW?=
 =?us-ascii?Q?5KkPyKBiDO4dlPpVy0Bs+KND6+jT2Vll7AR4fofTxZYNUeHvKoTlv/AwZvhu?=
 =?us-ascii?Q?wrGoPTCTjy0jnJLn8kHESWGcPzSPUfFzwgw4Zrm0Nbxl/xIlaE49wXy9GwHy?=
 =?us-ascii?Q?MtYUZlT6/uFaTdysWaRtKpONPJzuVvmkvytOTEnMmbxBont0iiM30BukKmv3?=
 =?us-ascii?Q?Q5Ay8OjSfeyiecBSrq/oQgzZUVv04dWureae/6bk/Ta1o5O1sp97Yc4eKcat?=
 =?us-ascii?Q?LI3Ar2dR3/KjBhYhhgwMLNqLtNTNHFROVmgzuyUL+fTAAGcQGSxuwkiah3p/?=
 =?us-ascii?Q?cz0lM9gEs59RwhgNQt4B1qzbKf3UQuwZp4ngj5caCxOjvdLu3YbaPV396lWQ?=
 =?us-ascii?Q?siWKi0FZeMesIoBUpbd2v2RW7Sv7DSeNTmGOV9nqu5nmhIp7u//vaEzwVpbC?=
 =?us-ascii?Q?jjaJxQjuFXq8oR/7Wy71K9Pky2xPek0xYECyaN65JIGTN2//hzGzOJ10CUO9?=
 =?us-ascii?Q?dNbaoWhMsIEA7W2YR5aUw1begP0+TxAunOeNcdVousqILejw+BaiWeYtxGC2?=
 =?us-ascii?Q?pR3ItvjJP0aKS/o=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Feb 2025 04:26:57.8027 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 597bb504-a415-464c-1561-08dd4278aa72
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001EC.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9432
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

If a device supports runtime pm, then pm_runtime_get_if_active returns 0
if a device is not active and 1 if already active. However, if a device
doesn't support runtime pm, the API returns -EINVAL. A device not
supporting runtime pm implies it's not affected by runtime pm and it's
active. Hence no need to get() to increment usage count. Remove < 0
return value check.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>

Fixes: 6e796cb4a972b ("drm/amd/pm: use pm_runtime_get_if_active for debugfs getters")
---
 drivers/gpu/drm/amd/pm/amdgpu_pm.c | 129 +++++++++++------------------
 1 file changed, 48 insertions(+), 81 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
index 0aca0803514e..a8db2d3c9154 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
@@ -138,16 +138,14 @@ static ssize_t amdgpu_get_power_dpm_state(struct device *dev,
 	struct drm_device *ddev = dev_get_drvdata(dev);
 	struct amdgpu_device *adev = drm_to_adev(ddev);
 	enum amd_pm_state_type pm;
-	int ret;
 
 	if (amdgpu_in_reset(adev))
 		return -EPERM;
 	if (adev->in_suspend && !adev->in_runpm)
 		return -EPERM;
 
-	ret = pm_runtime_get_if_active(ddev->dev);
-	if (ret <= 0)
-		return ret ?: -EPERM;
+	if (!pm_runtime_get_if_active(adev->dev))
+		return -EPERM;
 
 	amdgpu_dpm_get_current_power_state(adev, &pm);
 
@@ -261,16 +259,14 @@ static ssize_t amdgpu_get_power_dpm_force_performance_level(struct device *dev,
 	struct drm_device *ddev = dev_get_drvdata(dev);
 	struct amdgpu_device *adev = drm_to_adev(ddev);
 	enum amd_dpm_forced_level level = 0xff;
-	int ret;
 
 	if (amdgpu_in_reset(adev))
 		return -EPERM;
 	if (adev->in_suspend && !adev->in_runpm)
 		return -EPERM;
 
-	ret = pm_runtime_get_if_active(ddev->dev);
-	if (ret <= 0)
-		return ret ?: -EPERM;
+	if (!pm_runtime_get_if_active(adev->dev))
+		return -EPERM;
 
 	level = amdgpu_dpm_get_performance_level(adev);
 
@@ -357,16 +353,15 @@ static ssize_t amdgpu_get_pp_num_states(struct device *dev,
 	struct amdgpu_device *adev = drm_to_adev(ddev);
 	struct pp_states_info data;
 	uint32_t i;
-	int buf_len, ret;
+	int buf_len;
 
 	if (amdgpu_in_reset(adev))
 		return -EPERM;
 	if (adev->in_suspend && !adev->in_runpm)
 		return -EPERM;
 
-	ret = pm_runtime_get_if_active(ddev->dev);
-	if (ret <= 0)
-		return ret ?: -EPERM;
+	if (!pm_runtime_get_if_active(adev->dev))
+		return -EPERM;
 
 	if (amdgpu_dpm_get_pp_num_states(adev, &data))
 		memset(&data, 0, sizeof(data));
@@ -399,9 +394,8 @@ static ssize_t amdgpu_get_pp_cur_state(struct device *dev,
 	if (adev->in_suspend && !adev->in_runpm)
 		return -EPERM;
 
-	ret = pm_runtime_get_if_active(ddev->dev);
-	if (ret <= 0)
-		return ret ?: -EPERM;
+	if (!pm_runtime_get_if_active(adev->dev))
+		return -EPERM;
 
 	amdgpu_dpm_get_current_power_state(adev, &pm);
 
@@ -519,16 +513,15 @@ static ssize_t amdgpu_get_pp_table(struct device *dev,
 	struct drm_device *ddev = dev_get_drvdata(dev);
 	struct amdgpu_device *adev = drm_to_adev(ddev);
 	char *table = NULL;
-	int size, ret;
+	int size;
 
 	if (amdgpu_in_reset(adev))
 		return -EPERM;
 	if (adev->in_suspend && !adev->in_runpm)
 		return -EPERM;
 
-	ret = pm_runtime_get_if_active(ddev->dev);
-	if (ret <= 0)
-		return ret ?: -EPERM;
+	if (!pm_runtime_get_if_active(adev->dev))
+		return -EPERM;
 
 	size = amdgpu_dpm_get_pp_table(adev, &table);
 
@@ -840,9 +833,8 @@ static ssize_t amdgpu_get_pp_od_clk_voltage(struct device *dev,
 	if (adev->in_suspend && !adev->in_runpm)
 		return -EPERM;
 
-	ret = pm_runtime_get_if_active(ddev->dev);
-	if (ret <= 0)
-		return ret ?: -EPERM;
+	if (!pm_runtime_get_if_active(adev->dev))
+		return -EPERM;
 
 	for (clk_index = 0 ; clk_index < 6 ; clk_index++) {
 		ret = amdgpu_dpm_emit_clock_levels(adev, od_clocks[clk_index], buf, &size);
@@ -923,16 +915,14 @@ static ssize_t amdgpu_get_pp_features(struct device *dev,
 	struct drm_device *ddev = dev_get_drvdata(dev);
 	struct amdgpu_device *adev = drm_to_adev(ddev);
 	ssize_t size;
-	int ret;
 
 	if (amdgpu_in_reset(adev))
 		return -EPERM;
 	if (adev->in_suspend && !adev->in_runpm)
 		return -EPERM;
 
-	ret = pm_runtime_get_if_active(ddev->dev);
-	if (ret <= 0)
-		return ret ?: -EPERM;
+	if (!pm_runtime_get_if_active(adev->dev))
+		return -EPERM;
 
 	size = amdgpu_dpm_get_ppfeature_status(adev, buf);
 	if (size <= 0)
@@ -996,9 +986,8 @@ static ssize_t amdgpu_get_pp_dpm_clock(struct device *dev,
 	if (adev->in_suspend && !adev->in_runpm)
 		return -EPERM;
 
-	ret = pm_runtime_get_if_active(ddev->dev);
-	if (ret <= 0)
-		return ret ?: -EPERM;
+	if (!pm_runtime_get_if_active(adev->dev))
+		return -EPERM;
 
 	ret = amdgpu_dpm_emit_clock_levels(adev, type, buf, &size);
 	if (ret == -ENOENT)
@@ -1238,16 +1227,14 @@ static ssize_t amdgpu_get_pp_sclk_od(struct device *dev,
 	struct drm_device *ddev = dev_get_drvdata(dev);
 	struct amdgpu_device *adev = drm_to_adev(ddev);
 	uint32_t value = 0;
-	int ret;
 
 	if (amdgpu_in_reset(adev))
 		return -EPERM;
 	if (adev->in_suspend && !adev->in_runpm)
 		return -EPERM;
 
-	ret = pm_runtime_get_if_active(ddev->dev);
-	if (ret <= 0)
-		return ret ?: -EPERM;
+	if (!pm_runtime_get_if_active(adev->dev))
+		return -EPERM;
 
 	value = amdgpu_dpm_get_sclk_od(adev);
 
@@ -1295,16 +1282,14 @@ static ssize_t amdgpu_get_pp_mclk_od(struct device *dev,
 	struct drm_device *ddev = dev_get_drvdata(dev);
 	struct amdgpu_device *adev = drm_to_adev(ddev);
 	uint32_t value = 0;
-	int ret;
 
 	if (amdgpu_in_reset(adev))
 		return -EPERM;
 	if (adev->in_suspend && !adev->in_runpm)
 		return -EPERM;
 
-	ret = pm_runtime_get_if_active(ddev->dev);
-	if (ret <= 0)
-		return ret ?: -EPERM;
+	if (!pm_runtime_get_if_active(adev->dev))
+		return -EPERM;
 
 	value = amdgpu_dpm_get_mclk_od(adev);
 
@@ -1376,16 +1361,14 @@ static ssize_t amdgpu_get_pp_power_profile_mode(struct device *dev,
 	struct drm_device *ddev = dev_get_drvdata(dev);
 	struct amdgpu_device *adev = drm_to_adev(ddev);
 	ssize_t size;
-	int ret;
 
 	if (amdgpu_in_reset(adev))
 		return -EPERM;
 	if (adev->in_suspend && !adev->in_runpm)
 		return -EPERM;
 
-	ret = pm_runtime_get_if_active(ddev->dev);
-	if (ret <= 0)
-		return ret ?: -EPERM;
+	if (!pm_runtime_get_if_active(adev->dev))
+		return -EPERM;
 
 	size = amdgpu_dpm_get_power_profile_mode(adev, buf);
 	if (size <= 0)
@@ -1471,9 +1454,8 @@ static int amdgpu_hwmon_get_sensor_generic(struct amdgpu_device *adev,
 	if (adev->in_suspend && !adev->in_runpm)
 		return -EPERM;
 
-	r = pm_runtime_get_if_active(adev->dev);
-	if (r <= 0)
-		return r ?: -EPERM;
+	if (!pm_runtime_get_if_active(adev->dev))
+		return -EPERM;
 
 	/* get the sensor value */
 	r = amdgpu_dpm_read_sensor(adev, sensor, query, &size);
@@ -1574,7 +1556,6 @@ static ssize_t amdgpu_get_pcie_bw(struct device *dev,
 	struct drm_device *ddev = dev_get_drvdata(dev);
 	struct amdgpu_device *adev = drm_to_adev(ddev);
 	uint64_t count0 = 0, count1 = 0;
-	int ret;
 
 	if (amdgpu_in_reset(adev))
 		return -EPERM;
@@ -1587,9 +1568,8 @@ static ssize_t amdgpu_get_pcie_bw(struct device *dev,
 	if (!adev->asic_funcs->get_pcie_usage)
 		return -ENODATA;
 
-	ret = pm_runtime_get_if_active(ddev->dev);
-	if (ret <= 0)
-		return ret ?: -EPERM;
+	if (!pm_runtime_get_if_active(adev->dev))
+		return -EPERM;
 
 	amdgpu_asic_get_pcie_usage(adev, &count0, &count1);
 
@@ -1715,9 +1695,8 @@ static ssize_t amdgpu_get_apu_thermal_cap(struct device *dev,
 	struct drm_device *ddev = dev_get_drvdata(dev);
 	struct amdgpu_device *adev = drm_to_adev(ddev);
 
-	ret = pm_runtime_get_if_active(ddev->dev);
-	if (ret <= 0)
-		return ret ?: -EPERM;
+	if (!pm_runtime_get_if_active(adev->dev))
+		return -EPERM;
 
 	ret = amdgpu_dpm_get_apu_thermal_limit(adev, &limit);
 	if (!ret)
@@ -1784,16 +1763,14 @@ static ssize_t amdgpu_get_pm_metrics(struct device *dev,
 	struct drm_device *ddev = dev_get_drvdata(dev);
 	struct amdgpu_device *adev = drm_to_adev(ddev);
 	ssize_t size = 0;
-	int ret;
 
 	if (amdgpu_in_reset(adev))
 		return -EPERM;
 	if (adev->in_suspend && !adev->in_runpm)
 		return -EPERM;
 
-	ret = pm_runtime_get_if_active(ddev->dev);
-	if (ret <= 0)
-		return ret ?: -EPERM;
+	if (!pm_runtime_get_if_active(adev->dev))
+		return -EPERM;
 
 	size = amdgpu_dpm_get_pm_metrics(adev, buf, PAGE_SIZE);
 
@@ -1822,16 +1799,14 @@ static ssize_t amdgpu_get_gpu_metrics(struct device *dev,
 	struct amdgpu_device *adev = drm_to_adev(ddev);
 	void *gpu_metrics;
 	ssize_t size = 0;
-	int ret;
 
 	if (amdgpu_in_reset(adev))
 		return -EPERM;
 	if (adev->in_suspend && !adev->in_runpm)
 		return -EPERM;
 
-	ret = pm_runtime_get_if_active(ddev->dev);
-	if (ret <= 0)
-		return ret ?: -EPERM;
+	if (!pm_runtime_get_if_active(adev->dev))
+		return -EPERM;
 
 	size = amdgpu_dpm_get_gpu_metrics(adev, &gpu_metrics);
 	if (size <= 0)
@@ -2709,9 +2684,8 @@ static ssize_t amdgpu_hwmon_get_pwm1_enable(struct device *dev,
 	if (adev->in_suspend && !adev->in_runpm)
 		return -EPERM;
 
-	ret = pm_runtime_get_if_active(adev->dev);
-	if (ret <= 0)
-		return ret ?: -EPERM;
+	if (!pm_runtime_get_if_active(adev->dev))
+		return -EPERM;
 
 	ret = amdgpu_dpm_get_fan_control_mode(adev, &pwm_mode);
 
@@ -2837,9 +2811,8 @@ static ssize_t amdgpu_hwmon_get_pwm1(struct device *dev,
 	if (adev->in_suspend && !adev->in_runpm)
 		return -EPERM;
 
-	err = pm_runtime_get_if_active(adev->dev);
-	if (err <= 0)
-		return err ?: -EPERM;
+	if (!pm_runtime_get_if_active(adev->dev))
+		return -EPERM;
 
 	err = amdgpu_dpm_get_fan_speed_pwm(adev, &speed);
 
@@ -2864,9 +2837,8 @@ static ssize_t amdgpu_hwmon_get_fan1_input(struct device *dev,
 	if (adev->in_suspend && !adev->in_runpm)
 		return -EPERM;
 
-	err = pm_runtime_get_if_active(adev->dev);
-	if (err <= 0)
-		return err ?: -EPERM;
+	if (!pm_runtime_get_if_active(adev->dev))
+		return -EPERM;
 
 	err = amdgpu_dpm_get_fan_speed_rpm(adev, &speed);
 
@@ -2925,9 +2897,8 @@ static ssize_t amdgpu_hwmon_get_fan1_target(struct device *dev,
 	if (adev->in_suspend && !adev->in_runpm)
 		return -EPERM;
 
-	err = pm_runtime_get_if_active(adev->dev);
-	if (err <= 0)
-		return err ?: -EPERM;
+	if (!pm_runtime_get_if_active(adev->dev))
+		return -EPERM;
 
 	err = amdgpu_dpm_get_fan_speed_rpm(adev, &rpm);
 
@@ -2995,9 +2966,8 @@ static ssize_t amdgpu_hwmon_get_fan1_enable(struct device *dev,
 	if (adev->in_suspend && !adev->in_runpm)
 		return -EPERM;
 
-	ret = pm_runtime_get_if_active(adev->dev);
-	if (ret <= 0)
-		return ret ?: -EPERM;
+	if (!pm_runtime_get_if_active(adev->dev))
+		return -EPERM;
 
 	ret = amdgpu_dpm_get_fan_control_mode(adev, &pwm_mode);
 
@@ -3162,9 +3132,8 @@ static ssize_t amdgpu_hwmon_show_power_cap_generic(struct device *dev,
 	if (adev->in_suspend && !adev->in_runpm)
 		return -EPERM;
 
-	r = pm_runtime_get_if_active(adev->dev);
-	if (r <= 0)
-		return r ?: -EPERM;
+	if (!pm_runtime_get_if_active(adev->dev))
+		return -EPERM;
 
 	r = amdgpu_dpm_get_power_limit(adev, &limit,
 				      pp_limit_level, power_type);
@@ -3693,16 +3662,14 @@ static int amdgpu_retrieve_od_settings(struct amdgpu_device *adev,
 				       char *buf)
 {
 	int size = 0;
-	int ret;
 
 	if (amdgpu_in_reset(adev))
 		return -EPERM;
 	if (adev->in_suspend && !adev->in_runpm)
 		return -EPERM;
 
-	ret = pm_runtime_get_if_active(adev->dev);
-	if (ret <= 0)
-		return ret ?: -EPERM;
+	if (!pm_runtime_get_if_active(adev->dev))
+		return -EPERM;
 
 	size = amdgpu_dpm_print_clock_levels(adev, od_type, buf);
 	if (size == 0)
-- 
2.25.1

