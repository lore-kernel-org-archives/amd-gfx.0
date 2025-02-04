Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F293FC02197
	for <amd-gfx@archiver.kernel.org>; Tue,  4 Feb 2025 06:38:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D352010E243;
	Tue,  4 Feb 2025 06:38:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="iSzmcuqB";
	dkim-atps=neutral
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2079.outbound.protection.outlook.com [40.107.212.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BF93510E0BC
 for <amd-gfx@lists.freedesktop.org>; Tue,  4 Feb 2025 06:38:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=irXCIm+t0YeO+/SIK+Wj63ihkMtifa0EfNyBfYiRjnZjyIGcDZzG2L/4mAxTakmjCSEI90+PqgsVH+/soU/974esio47TVPwOPQRV0GdB+UMHqfzhYMwH3iBR42JbWtgrPFAgrjoTrFbcayfxwDd1f9R2KadP1SWeR/mH9pFEnv51+x1OxV3X/DdLdb5c2RFhQ45rFC6RbYdD6RMZ7pvamEcC+a9gSjXLToDt+7dfROwSYOUMWCwaWkXiviC1/XMq/BuDvopJun61Hyq3DCOtOQSpgCPjh8mlCDgPmA9rSc2WfPg3pqRTCABtQGjMgpzuJ1qvCyQJl8yvZ42id8ZFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wx3tu8p8mHHM8ga6UbRLF2/aSW3itz9bvjqRWDb7t6Y=;
 b=ty9RfYcbhzXXe+A2y7D6WUc8okn1mIoOKVR7BaG8oyTSTnjAKUwLl0y0L1vDLtHsw9L7xGfSblBhwACf3RRf9fpenHMg1HwoD0eTzNWabn/z6OLKXw2aNKEj3Gq5Z1oy5giAJ+ec1MQ+r9HUzjEYrXbLt0cYc2ELHV7zX/LCTGmsEezpfJ6eBqDcjJt51pc4gt70smF2uj9L2SuO9guNhITW55wnhcLd+9R3twaHYw73yedaRheRXj/4uB8pF50XsFE6niH70nFTbfmbOIUC79fYnPm9vohgXHuQy83eRQk0mY+WOi6znClUm5dWQPkRyt3us4OoLcRWZPBpopbJ2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wx3tu8p8mHHM8ga6UbRLF2/aSW3itz9bvjqRWDb7t6Y=;
 b=iSzmcuqBiVoOt8TdNz2DTQRz49Wwa0mucakPHJlkn1seKrBZGRL5UCNwQax3rdMgjeysjxqsSvcm4Yi7TLW5TclRsKHqabbdxhbkR6oW/6UAYrijCnmkGxCtH5CGSnMzIwoHofLy0Uv/TrzgHldOlEQGVeMWM6H2zYi63jLXF5E=
Received: from BN6PR17CA0059.namprd17.prod.outlook.com (2603:10b6:405:75::48)
 by CH2PR12MB4295.namprd12.prod.outlook.com (2603:10b6:610:a7::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.24; Tue, 4 Feb
 2025 06:38:39 +0000
Received: from BL02EPF0001A0FF.namprd03.prod.outlook.com
 (2603:10b6:405:75:cafe::fa) by BN6PR17CA0059.outlook.office365.com
 (2603:10b6:405:75::48) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8356.19 via Frontend Transport; Tue,
 4 Feb 2025 06:38:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0001A0FF.mail.protection.outlook.com (10.167.242.106) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8398.14 via Frontend Transport; Tue, 4 Feb 2025 06:38:38 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 4 Feb
 2025 00:38:35 -0600
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Alexander.Deucher@amd.com>,
 <pierre-eric.pelloux-prayer@amd.com>, <kenneth.feng@amd.com>,
 <mario.limonciello@amd.com>
Subject: [PATCH 1/3] drm/amd/pm: Add APIs for device access checks
Date: Tue, 4 Feb 2025 12:08:15 +0530
Message-ID: <20250204063817.1865562-1-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0FF:EE_|CH2PR12MB4295:EE_
X-MS-Office365-Filtering-Correlation-Id: 37e33f2d-cfe4-4d69-c903-08dd44e68f00
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?zuYBgg2wXOPLfzmhU0x0tLHXFbGSF0NrOWBCbz7GS4RN+JN0XuANYFSbDmK0?=
 =?us-ascii?Q?7hX4jClKrDLs+V1OdRcQ11YD/eFHw8MEAv8R8xapHm+E+BjsLhLGp8meHpBW?=
 =?us-ascii?Q?O7c2qfhWFPEXashWvpcXdVqr+eQFjDlq2hTJo+gSN3YnADu14cv8t7ZTI7Fs?=
 =?us-ascii?Q?qIyf1IEinWe5svRXV3F5JEY5TMMLU8cd+gaS69OGroaSnNOCQLZV5AIRGF2M?=
 =?us-ascii?Q?WfJ4WkjeHFUUerflrEge3qCdLEYp/0IzM20cJYFh0vrT2MhZ0INCxYiH6mkx?=
 =?us-ascii?Q?81/uyiFoXpzTFeoV9w69RXhYUnwnklExRO/lenjEAmhczaiu7sJfdtwxyp3X?=
 =?us-ascii?Q?Bdl+c1SficDk4WmsWzLxz/G8oo249t+QSKdd7xWYHr0IgD3luHEXD/nT0fI7?=
 =?us-ascii?Q?vLsyjdtl9Wa11+Q0Kf7mAnF+I9qIinaV3o7b4a6KGPsxIRCPGXuU9pFGZAc9?=
 =?us-ascii?Q?JEwF9kqWa9V+RgunoCn9jFKsVMRpwDQcLAKb2atFUpHNKGpWkEb7nEpbH+/D?=
 =?us-ascii?Q?NU+cyWMyck0dqBkCzwcgPA5ccezP572pg85243axDT8n2QfU9daUNjBlRqJW?=
 =?us-ascii?Q?4Vywq4CsLPuxDhJr4REkrWC21Bjo9yqixegiWAuAi+cuUM2fQk3uJM8ZTV2U?=
 =?us-ascii?Q?oKoEr1K37+sSGTVl1SPfl+EfUsXiiWWnULN/Xw7e3LgovkrFaqiJxNxANWmM?=
 =?us-ascii?Q?k0yhyZ+LN3jW2lA180LSrb/QIlvVrlaX1w0WEwWvNE5baxCYZGJC1xVXFtgu?=
 =?us-ascii?Q?BaiHpbakhDGohzzz/PWRSk0ddu7K+QqQFpYXIlNwuRgY+GFiTlFXR5gBAchJ?=
 =?us-ascii?Q?E+pG8Fw/JenmJuLTgnOLwR0E0P9r7faWprPRbMEe1raMAakUb47QttwYHZMQ?=
 =?us-ascii?Q?P9PC6FDM6FXi/awB/cZVeQlMfJUX8WjZzcldRvs/kg0mae+YSNk4jIGAUM5L?=
 =?us-ascii?Q?ZEtFa+G2RzY84Bbjz8oRsPU9zUbZSYAV9Y6SEfHX3si69mI8rocrA3HQO1/r?=
 =?us-ascii?Q?qVgL5vfPD0UT/p8zZVtGlcxZoSfKCNG4J/YWdA2ZiPGXZkabaBQnP6TVUH2b?=
 =?us-ascii?Q?lRufaaWtIJORDGPtib1wbeaGujQ9/LKzlGOMRaLWCe++1a3FUTmG8408YzgN?=
 =?us-ascii?Q?G52ZzrKqn+ph949J/KLqcXCNPClg21MFQ6uNMzL81i2oCrim67Iw1jZoUAqf?=
 =?us-ascii?Q?lg9WDpSG3jt4GymqICmuw5AvSRv78kVOgDcReSOYTcsXcNPQounjdhOc9/iN?=
 =?us-ascii?Q?mOFv+uBabjUu271hzruaanO9h31Ty56HMY6ENC2FyFWYT9nkTc0H225EvRn5?=
 =?us-ascii?Q?nKy0iwO8QHAC8X5O69UH7x3wp+l8XK7SJx8SsFgkN5uGoleRH+jxsmhltZ/s?=
 =?us-ascii?Q?njdDtNkyJWjD4Ok4XUmLTxTcUZRbrw4V8pwYCDA95EsAegQx2Q3lL0GdbF8N?=
 =?us-ascii?Q?stXDyUKAR27+u+zk9OjZTs3fKpDHsvS1ujU2ANiZ2/IpssxD8c9M2JsDlRtV?=
 =?us-ascii?Q?9LHEfvdvKbFkae4=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2025 06:38:38.8213 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 37e33f2d-cfe4-4d69-c903-08dd44e68f00
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A0FF.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4295
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

Wrap the checks before device access in helper functions and use them
for device access. The generic order of APIs now is to do input argument
validation first and check if device access is allowed.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/pm/amdgpu_pm.c | 616 +++++++++++------------------
 1 file changed, 229 insertions(+), 387 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
index 0aca0803514e..0fe0b798f559 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
@@ -97,6 +97,77 @@ const char * const amdgpu_pp_profile_name[] = {
 	"UNCAPPED",
 };
 
+/**
+ * amdgpu_pm_dev_state_check - Check if device can be accessed.
+ * @adev: Target device.
+ *
+ * Checks the state of the @adev for access. Return 0 if the device is
+ * accessible or a negative error code otherwise.
+ */
+static int amdgpu_pm_dev_state_check(struct amdgpu_device *adev)
+{
+	if (amdgpu_in_reset(adev))
+		return -EPERM;
+	if (adev->in_suspend && !adev->in_runpm)
+		return -EPERM;
+
+	return 0;
+}
+
+/**
+ * amdgpu_pm_get_access - Check if device can be accessed, resume if needed.
+ * @adev: Target device.
+ *
+ * Checks the state of the @adev for access. Use runtime pm API to resume if
+ * needed. Return 0 if the device is accessible or a negative error code
+ * otherwise.
+ */
+static int amdgpu_pm_get_access(struct amdgpu_device *adev)
+{
+	int ret;
+
+	ret = amdgpu_pm_dev_state_check(adev);
+	if (ret)
+		return ret;
+
+	return pm_runtime_resume_and_get(adev->dev);
+}
+
+/**
+ * amdgpu_pm_get_access_if_active - Check if device is active for access.
+ * @adev: Target device.
+ *
+ * Checks the state of the @adev for access. Use runtime pm API to determine
+ * if device is active. Allow access only if device is active.Return 0 if the
+ * device is accessible or a negative error code otherwise.
+ */
+static int amdgpu_pm_get_access_if_active(struct amdgpu_device *adev)
+{
+	int ret;
+
+	ret = amdgpu_pm_dev_state_check(adev);
+	if (ret)
+		return ret;
+
+	ret = pm_runtime_get_if_active(adev->dev);
+	if (ret <= 0)
+		return ret ?: -EPERM;
+
+	return 0;
+}
+
+/**
+ * amdgpu_pm_put_access - Put to auto suspend mode after a device access.
+ * @adev: Target device.
+ *
+ * Should be paired with amdgpu_pm_get_access* calls
+ */
+static inline void amdgpu_pm_put_access(struct amdgpu_device *adev)
+{
+	pm_runtime_mark_last_busy(adev->dev);
+	pm_runtime_put_autosuspend(adev->dev);
+}
+
 /**
  * DOC: power_dpm_state
  *
@@ -140,18 +211,13 @@ static ssize_t amdgpu_get_power_dpm_state(struct device *dev,
 	enum amd_pm_state_type pm;
 	int ret;
 
-	if (amdgpu_in_reset(adev))
-		return -EPERM;
-	if (adev->in_suspend && !adev->in_runpm)
-		return -EPERM;
-
-	ret = pm_runtime_get_if_active(ddev->dev);
-	if (ret <= 0)
-		return ret ?: -EPERM;
+	ret = amdgpu_pm_get_access_if_active(adev);
+	if (ret)
+		return ret;
 
 	amdgpu_dpm_get_current_power_state(adev, &pm);
 
-	pm_runtime_put_autosuspend(ddev->dev);
+	amdgpu_pm_put_access(adev);
 
 	return sysfs_emit(buf, "%s\n",
 			  (pm == POWER_STATE_TYPE_BATTERY) ? "battery" :
@@ -168,11 +234,6 @@ static ssize_t amdgpu_set_power_dpm_state(struct device *dev,
 	enum amd_pm_state_type  state;
 	int ret;
 
-	if (amdgpu_in_reset(adev))
-		return -EPERM;
-	if (adev->in_suspend && !adev->in_runpm)
-		return -EPERM;
-
 	if (strncmp("battery", buf, strlen("battery")) == 0)
 		state = POWER_STATE_TYPE_BATTERY;
 	else if (strncmp("balanced", buf, strlen("balanced")) == 0)
@@ -182,14 +243,13 @@ static ssize_t amdgpu_set_power_dpm_state(struct device *dev,
 	else
 		return -EINVAL;
 
-	ret = pm_runtime_resume_and_get(ddev->dev);
+	ret = amdgpu_pm_get_access(adev);
 	if (ret < 0)
 		return ret;
 
 	amdgpu_dpm_set_power_state(adev, state);
 
-	pm_runtime_mark_last_busy(ddev->dev);
-	pm_runtime_put_autosuspend(ddev->dev);
+	amdgpu_pm_put_access(adev);
 
 	return count;
 }
@@ -263,18 +323,13 @@ static ssize_t amdgpu_get_power_dpm_force_performance_level(struct device *dev,
 	enum amd_dpm_forced_level level = 0xff;
 	int ret;
 
-	if (amdgpu_in_reset(adev))
-		return -EPERM;
-	if (adev->in_suspend && !adev->in_runpm)
-		return -EPERM;
-
-	ret = pm_runtime_get_if_active(ddev->dev);
-	if (ret <= 0)
-		return ret ?: -EPERM;
+	ret = amdgpu_pm_get_access_if_active(adev);
+	if (ret)
+		return ret;
 
 	level = amdgpu_dpm_get_performance_level(adev);
 
-	pm_runtime_put_autosuspend(ddev->dev);
+	amdgpu_pm_put_access(adev);
 
 	return sysfs_emit(buf, "%s\n",
 			  (level == AMD_DPM_FORCED_LEVEL_AUTO) ? "auto" :
@@ -299,11 +354,6 @@ static ssize_t amdgpu_set_power_dpm_force_performance_level(struct device *dev,
 	enum amd_dpm_forced_level level;
 	int ret = 0;
 
-	if (amdgpu_in_reset(adev))
-		return -EPERM;
-	if (adev->in_suspend && !adev->in_runpm)
-		return -EPERM;
-
 	if (strncmp("low", buf, strlen("low")) == 0) {
 		level = AMD_DPM_FORCED_LEVEL_LOW;
 	} else if (strncmp("high", buf, strlen("high")) == 0) {
@@ -328,14 +378,13 @@ static ssize_t amdgpu_set_power_dpm_force_performance_level(struct device *dev,
 		return -EINVAL;
 	}
 
-	ret = pm_runtime_resume_and_get(ddev->dev);
+	ret = amdgpu_pm_get_access(adev);
 	if (ret < 0)
 		return ret;
 
 	mutex_lock(&adev->pm.stable_pstate_ctx_lock);
 	if (amdgpu_dpm_force_performance_level(adev, level)) {
-		pm_runtime_mark_last_busy(ddev->dev);
-		pm_runtime_put_autosuspend(ddev->dev);
+		amdgpu_pm_put_access(adev);
 		mutex_unlock(&adev->pm.stable_pstate_ctx_lock);
 		return -EINVAL;
 	}
@@ -343,8 +392,7 @@ static ssize_t amdgpu_set_power_dpm_force_performance_level(struct device *dev,
 	adev->pm.stable_pstate_ctx = NULL;
 	mutex_unlock(&adev->pm.stable_pstate_ctx_lock);
 
-	pm_runtime_mark_last_busy(ddev->dev);
-	pm_runtime_put_autosuspend(ddev->dev);
+	amdgpu_pm_put_access(adev);
 
 	return count;
 }
@@ -359,19 +407,14 @@ static ssize_t amdgpu_get_pp_num_states(struct device *dev,
 	uint32_t i;
 	int buf_len, ret;
 
-	if (amdgpu_in_reset(adev))
-		return -EPERM;
-	if (adev->in_suspend && !adev->in_runpm)
-		return -EPERM;
-
-	ret = pm_runtime_get_if_active(ddev->dev);
-	if (ret <= 0)
-		return ret ?: -EPERM;
+	ret = amdgpu_pm_get_access_if_active(adev);
+	if (ret)
+		return ret;
 
 	if (amdgpu_dpm_get_pp_num_states(adev, &data))
 		memset(&data, 0, sizeof(data));
 
-	pm_runtime_put_autosuspend(ddev->dev);
+	amdgpu_pm_put_access(adev);
 
 	buf_len = sysfs_emit(buf, "states: %d\n", data.nums);
 	for (i = 0; i < data.nums; i++)
@@ -394,20 +437,15 @@ static ssize_t amdgpu_get_pp_cur_state(struct device *dev,
 	enum amd_pm_state_type pm = 0;
 	int i = 0, ret = 0;
 
-	if (amdgpu_in_reset(adev))
-		return -EPERM;
-	if (adev->in_suspend && !adev->in_runpm)
-		return -EPERM;
-
-	ret = pm_runtime_get_if_active(ddev->dev);
-	if (ret <= 0)
-		return ret ?: -EPERM;
+	ret = amdgpu_pm_get_access_if_active(adev);
+	if (ret)
+		return ret;
 
 	amdgpu_dpm_get_current_power_state(adev, &pm);
 
 	ret = amdgpu_dpm_get_pp_num_states(adev, &data);
 
-	pm_runtime_put_autosuspend(ddev->dev);
+	amdgpu_pm_put_access(adev);
 
 	if (ret)
 		return ret;
@@ -429,11 +467,11 @@ static ssize_t amdgpu_get_pp_force_state(struct device *dev,
 {
 	struct drm_device *ddev = dev_get_drvdata(dev);
 	struct amdgpu_device *adev = drm_to_adev(ddev);
+	int ret;
 
-	if (amdgpu_in_reset(adev))
-		return -EPERM;
-	if (adev->in_suspend && !adev->in_runpm)
-		return -EPERM;
+	ret = amdgpu_pm_dev_state_check(adev);
+	if (ret)
+		return ret;
 
 	if (adev->pm.pp_force_state_enabled)
 		return amdgpu_get_pp_cur_state(dev, attr, buf);
@@ -453,11 +491,6 @@ static ssize_t amdgpu_set_pp_force_state(struct device *dev,
 	unsigned long idx;
 	int ret;
 
-	if (amdgpu_in_reset(adev))
-		return -EPERM;
-	if (adev->in_suspend && !adev->in_runpm)
-		return -EPERM;
-
 	adev->pm.pp_force_state_enabled = false;
 
 	if (strlen(buf) == 1)
@@ -469,7 +502,7 @@ static ssize_t amdgpu_set_pp_force_state(struct device *dev,
 
 	idx = array_index_nospec(idx, ARRAY_SIZE(data.states));
 
-	ret = pm_runtime_resume_and_get(ddev->dev);
+	ret = amdgpu_pm_get_access(adev);
 	if (ret < 0)
 		return ret;
 
@@ -490,14 +523,13 @@ static ssize_t amdgpu_set_pp_force_state(struct device *dev,
 		adev->pm.pp_force_state_enabled = true;
 	}
 
-	pm_runtime_mark_last_busy(ddev->dev);
-	pm_runtime_put_autosuspend(ddev->dev);
+	amdgpu_pm_put_access(adev);
 
 	return count;
 
 err_out:
-	pm_runtime_mark_last_busy(ddev->dev);
-	pm_runtime_put_autosuspend(ddev->dev);
+	amdgpu_pm_put_access(adev);
+
 	return ret;
 }
 
@@ -521,18 +553,13 @@ static ssize_t amdgpu_get_pp_table(struct device *dev,
 	char *table = NULL;
 	int size, ret;
 
-	if (amdgpu_in_reset(adev))
-		return -EPERM;
-	if (adev->in_suspend && !adev->in_runpm)
-		return -EPERM;
-
-	ret = pm_runtime_get_if_active(ddev->dev);
-	if (ret <= 0)
-		return ret ?: -EPERM;
+	ret = amdgpu_pm_get_access_if_active(adev);
+	if (ret)
+		return ret;
 
 	size = amdgpu_dpm_get_pp_table(adev, &table);
 
-	pm_runtime_put_autosuspend(ddev->dev);
+	amdgpu_pm_put_access(adev);
 
 	if (size <= 0)
 		return size;
@@ -554,19 +581,13 @@ static ssize_t amdgpu_set_pp_table(struct device *dev,
 	struct amdgpu_device *adev = drm_to_adev(ddev);
 	int ret = 0;
 
-	if (amdgpu_in_reset(adev))
-		return -EPERM;
-	if (adev->in_suspend && !adev->in_runpm)
-		return -EPERM;
-
-	ret = pm_runtime_resume_and_get(ddev->dev);
+	ret = amdgpu_pm_get_access(adev);
 	if (ret < 0)
 		return ret;
 
 	ret = amdgpu_dpm_set_pp_table(adev, buf, count);
 
-	pm_runtime_mark_last_busy(ddev->dev);
-	pm_runtime_put_autosuspend(ddev->dev);
+	amdgpu_pm_put_access(adev);
 
 	if (ret)
 		return ret;
@@ -735,11 +756,6 @@ static ssize_t amdgpu_set_pp_od_clk_voltage(struct device *dev,
 	const char delimiter[3] = {' ', '\n', '\0'};
 	uint32_t type;
 
-	if (amdgpu_in_reset(adev))
-		return -EPERM;
-	if (adev->in_suspend && !adev->in_runpm)
-		return -EPERM;
-
 	if (count > 127 || count == 0)
 		return -EINVAL;
 
@@ -785,7 +801,7 @@ static ssize_t amdgpu_set_pp_od_clk_voltage(struct device *dev,
 			tmp_str++;
 	}
 
-	ret = pm_runtime_resume_and_get(ddev->dev);
+	ret = amdgpu_pm_get_access(adev);
 	if (ret < 0)
 		return ret;
 
@@ -806,14 +822,13 @@ static ssize_t amdgpu_set_pp_od_clk_voltage(struct device *dev,
 			goto err_out;
 	}
 
-	pm_runtime_mark_last_busy(ddev->dev);
-	pm_runtime_put_autosuspend(ddev->dev);
+	amdgpu_pm_put_access(adev);
 
 	return count;
 
 err_out:
-	pm_runtime_mark_last_busy(ddev->dev);
-	pm_runtime_put_autosuspend(ddev->dev);
+	amdgpu_pm_put_access(adev);
+
 	return -EINVAL;
 }
 
@@ -835,14 +850,9 @@ static ssize_t amdgpu_get_pp_od_clk_voltage(struct device *dev,
 	};
 	uint clk_index;
 
-	if (amdgpu_in_reset(adev))
-		return -EPERM;
-	if (adev->in_suspend && !adev->in_runpm)
-		return -EPERM;
-
-	ret = pm_runtime_get_if_active(ddev->dev);
-	if (ret <= 0)
-		return ret ?: -EPERM;
+	ret = amdgpu_pm_get_access_if_active(adev);
+	if (ret)
+		return ret;
 
 	for (clk_index = 0 ; clk_index < 6 ; clk_index++) {
 		ret = amdgpu_dpm_emit_clock_levels(adev, od_clocks[clk_index], buf, &size);
@@ -861,7 +871,7 @@ static ssize_t amdgpu_get_pp_od_clk_voltage(struct device *dev,
 	if (size == 0)
 		size = sysfs_emit(buf, "\n");
 
-	pm_runtime_put_autosuspend(ddev->dev);
+	amdgpu_pm_put_access(adev);
 
 	return size;
 }
@@ -892,23 +902,17 @@ static ssize_t amdgpu_set_pp_features(struct device *dev,
 	uint64_t featuremask;
 	int ret;
 
-	if (amdgpu_in_reset(adev))
-		return -EPERM;
-	if (adev->in_suspend && !adev->in_runpm)
-		return -EPERM;
-
 	ret = kstrtou64(buf, 0, &featuremask);
 	if (ret)
 		return -EINVAL;
 
-	ret = pm_runtime_resume_and_get(ddev->dev);
+	ret = amdgpu_pm_get_access(adev);
 	if (ret < 0)
 		return ret;
 
 	ret = amdgpu_dpm_set_ppfeature_status(adev, featuremask);
 
-	pm_runtime_mark_last_busy(ddev->dev);
-	pm_runtime_put_autosuspend(ddev->dev);
+	amdgpu_pm_put_access(adev);
 
 	if (ret)
 		return -EINVAL;
@@ -925,20 +929,15 @@ static ssize_t amdgpu_get_pp_features(struct device *dev,
 	ssize_t size;
 	int ret;
 
-	if (amdgpu_in_reset(adev))
-		return -EPERM;
-	if (adev->in_suspend && !adev->in_runpm)
-		return -EPERM;
-
-	ret = pm_runtime_get_if_active(ddev->dev);
-	if (ret <= 0)
-		return ret ?: -EPERM;
+	ret = amdgpu_pm_get_access_if_active(adev);
+	if (ret)
+		return ret;
 
 	size = amdgpu_dpm_get_ppfeature_status(adev, buf);
 	if (size <= 0)
 		size = sysfs_emit(buf, "\n");
 
-	pm_runtime_put_autosuspend(ddev->dev);
+	amdgpu_pm_put_access(adev);
 
 	return size;
 }
@@ -991,14 +990,9 @@ static ssize_t amdgpu_get_pp_dpm_clock(struct device *dev,
 	int size = 0;
 	int ret = 0;
 
-	if (amdgpu_in_reset(adev))
-		return -EPERM;
-	if (adev->in_suspend && !adev->in_runpm)
-		return -EPERM;
-
-	ret = pm_runtime_get_if_active(ddev->dev);
-	if (ret <= 0)
-		return ret ?: -EPERM;
+	ret = amdgpu_pm_get_access_if_active(adev);
+	if (ret)
+		return ret;
 
 	ret = amdgpu_dpm_emit_clock_levels(adev, type, buf, &size);
 	if (ret == -ENOENT)
@@ -1007,7 +1001,7 @@ static ssize_t amdgpu_get_pp_dpm_clock(struct device *dev,
 	if (size == 0)
 		size = sysfs_emit(buf, "\n");
 
-	pm_runtime_put_autosuspend(ddev->dev);
+	amdgpu_pm_put_access(adev);
 
 	return size;
 }
@@ -1057,23 +1051,17 @@ static ssize_t amdgpu_set_pp_dpm_clock(struct device *dev,
 	int ret;
 	uint32_t mask = 0;
 
-	if (amdgpu_in_reset(adev))
-		return -EPERM;
-	if (adev->in_suspend && !adev->in_runpm)
-		return -EPERM;
-
 	ret = amdgpu_read_mask(buf, count, &mask);
 	if (ret)
 		return ret;
 
-	ret = pm_runtime_resume_and_get(ddev->dev);
+	ret = amdgpu_pm_get_access(adev);
 	if (ret < 0)
 		return ret;
 
 	ret = amdgpu_dpm_force_clock_level(adev, type, mask);
 
-	pm_runtime_mark_last_busy(ddev->dev);
-	pm_runtime_put_autosuspend(ddev->dev);
+	amdgpu_pm_put_access(adev);
 
 	if (ret)
 		return -EINVAL;
@@ -1240,18 +1228,13 @@ static ssize_t amdgpu_get_pp_sclk_od(struct device *dev,
 	uint32_t value = 0;
 	int ret;
 
-	if (amdgpu_in_reset(adev))
-		return -EPERM;
-	if (adev->in_suspend && !adev->in_runpm)
-		return -EPERM;
-
-	ret = pm_runtime_get_if_active(ddev->dev);
-	if (ret <= 0)
-		return ret ?: -EPERM;
+	ret = amdgpu_pm_get_access_if_active(adev);
+	if (ret)
+		return ret;
 
 	value = amdgpu_dpm_get_sclk_od(adev);
 
-	pm_runtime_put_autosuspend(ddev->dev);
+	amdgpu_pm_put_access(adev);
 
 	return sysfs_emit(buf, "%d\n", value);
 }
@@ -1266,24 +1249,18 @@ static ssize_t amdgpu_set_pp_sclk_od(struct device *dev,
 	int ret;
 	long int value;
 
-	if (amdgpu_in_reset(adev))
-		return -EPERM;
-	if (adev->in_suspend && !adev->in_runpm)
-		return -EPERM;
-
 	ret = kstrtol(buf, 0, &value);
 
 	if (ret)
 		return -EINVAL;
 
-	ret = pm_runtime_resume_and_get(ddev->dev);
+	ret = amdgpu_pm_get_access(adev);
 	if (ret < 0)
 		return ret;
 
 	amdgpu_dpm_set_sclk_od(adev, (uint32_t)value);
 
-	pm_runtime_mark_last_busy(ddev->dev);
-	pm_runtime_put_autosuspend(ddev->dev);
+	amdgpu_pm_put_access(adev);
 
 	return count;
 }
@@ -1297,18 +1274,13 @@ static ssize_t amdgpu_get_pp_mclk_od(struct device *dev,
 	uint32_t value = 0;
 	int ret;
 
-	if (amdgpu_in_reset(adev))
-		return -EPERM;
-	if (adev->in_suspend && !adev->in_runpm)
-		return -EPERM;
-
-	ret = pm_runtime_get_if_active(ddev->dev);
-	if (ret <= 0)
-		return ret ?: -EPERM;
+	ret = amdgpu_pm_get_access_if_active(adev);
+	if (ret)
+		return ret;
 
 	value = amdgpu_dpm_get_mclk_od(adev);
 
-	pm_runtime_put_autosuspend(ddev->dev);
+	amdgpu_pm_put_access(adev);
 
 	return sysfs_emit(buf, "%d\n", value);
 }
@@ -1323,24 +1295,18 @@ static ssize_t amdgpu_set_pp_mclk_od(struct device *dev,
 	int ret;
 	long int value;
 
-	if (amdgpu_in_reset(adev))
-		return -EPERM;
-	if (adev->in_suspend && !adev->in_runpm)
-		return -EPERM;
-
 	ret = kstrtol(buf, 0, &value);
 
 	if (ret)
 		return -EINVAL;
 
-	ret = pm_runtime_resume_and_get(ddev->dev);
+	ret = amdgpu_pm_get_access(adev);
 	if (ret < 0)
 		return ret;
 
 	amdgpu_dpm_set_mclk_od(adev, (uint32_t)value);
 
-	pm_runtime_mark_last_busy(ddev->dev);
-	pm_runtime_put_autosuspend(ddev->dev);
+	amdgpu_pm_put_access(adev);
 
 	return count;
 }
@@ -1378,20 +1344,15 @@ static ssize_t amdgpu_get_pp_power_profile_mode(struct device *dev,
 	ssize_t size;
 	int ret;
 
-	if (amdgpu_in_reset(adev))
-		return -EPERM;
-	if (adev->in_suspend && !adev->in_runpm)
-		return -EPERM;
-
-	ret = pm_runtime_get_if_active(ddev->dev);
-	if (ret <= 0)
-		return ret ?: -EPERM;
+	ret = amdgpu_pm_get_access_if_active(adev);
+	if (ret)
+		return ret;
 
 	size = amdgpu_dpm_get_power_profile_mode(adev, buf);
 	if (size <= 0)
 		size = sysfs_emit(buf, "\n");
 
-	pm_runtime_put_autosuspend(ddev->dev);
+	amdgpu_pm_put_access(adev);
 
 	return size;
 }
@@ -1414,11 +1375,6 @@ static ssize_t amdgpu_set_pp_power_profile_mode(struct device *dev,
 	long int profile_mode = 0;
 	const char delimiter[3] = {' ', '\n', '\0'};
 
-	if (amdgpu_in_reset(adev))
-		return -EPERM;
-	if (adev->in_suspend && !adev->in_runpm)
-		return -EPERM;
-
 	tmp[0] = *(buf);
 	tmp[1] = '\0';
 	ret = kstrtol(tmp, 0, &profile_mode);
@@ -1445,14 +1401,13 @@ static ssize_t amdgpu_set_pp_power_profile_mode(struct device *dev,
 	}
 	parameter[parameter_size] = profile_mode;
 
-	ret = pm_runtime_resume_and_get(ddev->dev);
+	ret = amdgpu_pm_get_access(adev);
 	if (ret < 0)
 		return ret;
 
 	ret = amdgpu_dpm_set_power_profile_mode(adev, parameter, parameter_size);
 
-	pm_runtime_mark_last_busy(ddev->dev);
-	pm_runtime_put_autosuspend(ddev->dev);
+	amdgpu_pm_put_access(adev);
 
 	if (!ret)
 		return count;
@@ -1466,19 +1421,14 @@ static int amdgpu_hwmon_get_sensor_generic(struct amdgpu_device *adev,
 {
 	int r, size = sizeof(uint32_t);
 
-	if (amdgpu_in_reset(adev))
-		return -EPERM;
-	if (adev->in_suspend && !adev->in_runpm)
-		return -EPERM;
-
-	r = pm_runtime_get_if_active(adev->dev);
-	if (r <= 0)
-		return r ?: -EPERM;
+	r = amdgpu_pm_get_access_if_active(adev);
+	if (r)
+		return r;
 
 	/* get the sensor value */
 	r = amdgpu_dpm_read_sensor(adev, sensor, query, &size);
 
-	pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);
+	amdgpu_pm_put_access(adev);
 
 	return r;
 }
@@ -1576,24 +1526,19 @@ static ssize_t amdgpu_get_pcie_bw(struct device *dev,
 	uint64_t count0 = 0, count1 = 0;
 	int ret;
 
-	if (amdgpu_in_reset(adev))
-		return -EPERM;
-	if (adev->in_suspend && !adev->in_runpm)
-		return -EPERM;
-
 	if (adev->flags & AMD_IS_APU)
 		return -ENODATA;
 
 	if (!adev->asic_funcs->get_pcie_usage)
 		return -ENODATA;
 
-	ret = pm_runtime_get_if_active(ddev->dev);
-	if (ret <= 0)
-		return ret ?: -EPERM;
+	ret = amdgpu_pm_get_access_if_active(adev);
+	if (ret)
+		return ret;
 
 	amdgpu_asic_get_pcie_usage(adev, &count0, &count1);
 
-	pm_runtime_put_autosuspend(ddev->dev);
+	amdgpu_pm_put_access(adev);
 
 	return sysfs_emit(buf, "%llu %llu %i\n",
 			  count0, count1, pcie_get_mps(adev->pdev));
@@ -1615,12 +1560,11 @@ static ssize_t amdgpu_get_unique_id(struct device *dev,
 {
 	struct drm_device *ddev = dev_get_drvdata(dev);
 	struct amdgpu_device *adev = drm_to_adev(ddev);
+	int r;
 
-	if (amdgpu_in_reset(adev))
-		return -EPERM;
-	if (adev->in_suspend && !adev->in_runpm)
-		return -EPERM;
-
+	r = amdgpu_pm_dev_state_check(adev);
+	if (r)
+		return r;
 	if (adev->unique_id)
 		return sysfs_emit(buf, "%016llx\n", adev->unique_id);
 
@@ -1715,9 +1659,9 @@ static ssize_t amdgpu_get_apu_thermal_cap(struct device *dev,
 	struct drm_device *ddev = dev_get_drvdata(dev);
 	struct amdgpu_device *adev = drm_to_adev(ddev);
 
-	ret = pm_runtime_get_if_active(ddev->dev);
-	if (ret <= 0)
-		return ret ?: -EPERM;
+	ret = amdgpu_pm_get_access_if_active(adev);
+	if (ret)
+		return ret;
 
 	ret = amdgpu_dpm_get_apu_thermal_limit(adev, &limit);
 	if (!ret)
@@ -1725,7 +1669,7 @@ static ssize_t amdgpu_get_apu_thermal_cap(struct device *dev,
 	else
 		size = sysfs_emit(buf, "failed to get thermal limit\n");
 
-	pm_runtime_put_autosuspend(ddev->dev);
+	amdgpu_pm_put_access(adev);
 
 	return size;
 }
@@ -1749,20 +1693,18 @@ static ssize_t amdgpu_set_apu_thermal_cap(struct device *dev,
 		return -EINVAL;
 	}
 
-	ret = pm_runtime_resume_and_get(ddev->dev);
+	ret = amdgpu_pm_get_access(adev);
 	if (ret < 0)
 		return ret;
 
 	ret = amdgpu_dpm_set_apu_thermal_limit(adev, value);
 	if (ret) {
-		pm_runtime_mark_last_busy(ddev->dev);
-		pm_runtime_put_autosuspend(ddev->dev);
+		amdgpu_pm_put_access(adev);
 		dev_err(dev, "failed to update thermal limit\n");
 		return ret;
 	}
 
-	pm_runtime_mark_last_busy(ddev->dev);
-	pm_runtime_put_autosuspend(ddev->dev);
+	amdgpu_pm_put_access(adev);
 
 	return count;
 }
@@ -1786,18 +1728,13 @@ static ssize_t amdgpu_get_pm_metrics(struct device *dev,
 	ssize_t size = 0;
 	int ret;
 
-	if (amdgpu_in_reset(adev))
-		return -EPERM;
-	if (adev->in_suspend && !adev->in_runpm)
-		return -EPERM;
-
-	ret = pm_runtime_get_if_active(ddev->dev);
-	if (ret <= 0)
-		return ret ?: -EPERM;
+	ret = amdgpu_pm_get_access_if_active(adev);
+	if (ret)
+		return ret;
 
 	size = amdgpu_dpm_get_pm_metrics(adev, buf, PAGE_SIZE);
 
-	pm_runtime_put_autosuspend(ddev->dev);
+	amdgpu_pm_put_access(adev);
 
 	return size;
 }
@@ -1824,14 +1761,9 @@ static ssize_t amdgpu_get_gpu_metrics(struct device *dev,
 	ssize_t size = 0;
 	int ret;
 
-	if (amdgpu_in_reset(adev))
-		return -EPERM;
-	if (adev->in_suspend && !adev->in_runpm)
-		return -EPERM;
-
-	ret = pm_runtime_get_if_active(ddev->dev);
-	if (ret <= 0)
-		return ret ?: -EPERM;
+	ret = amdgpu_pm_get_access_if_active(adev);
+	if (ret)
+		return ret;
 
 	size = amdgpu_dpm_get_gpu_metrics(adev, &gpu_metrics);
 	if (size <= 0)
@@ -1843,7 +1775,7 @@ static ssize_t amdgpu_get_gpu_metrics(struct device *dev,
 	memcpy(buf, gpu_metrics, size);
 
 out:
-	pm_runtime_put_autosuspend(ddev->dev);
+	amdgpu_pm_put_access(adev);
 
 	return size;
 }
@@ -1939,19 +1871,14 @@ static ssize_t amdgpu_set_smartshift_bias(struct device *dev,
 	int r = 0;
 	int bias = 0;
 
-	if (amdgpu_in_reset(adev))
-		return -EPERM;
-	if (adev->in_suspend && !adev->in_runpm)
-		return -EPERM;
-
-	r = pm_runtime_resume_and_get(ddev->dev);
-	if (r < 0)
-		return r;
-
 	r = kstrtoint(buf, 10, &bias);
 	if (r)
 		goto out;
 
+	r = amdgpu_pm_get_access(adev);
+	if (r < 0)
+		return r;
+
 	if (bias > AMDGPU_SMARTSHIFT_MAX_BIAS)
 		bias = AMDGPU_SMARTSHIFT_MAX_BIAS;
 	else if (bias < AMDGPU_SMARTSHIFT_MIN_BIAS)
@@ -1963,8 +1890,8 @@ static ssize_t amdgpu_set_smartshift_bias(struct device *dev,
 	/* TODO: update bias level with SMU message */
 
 out:
-	pm_runtime_mark_last_busy(ddev->dev);
-	pm_runtime_put_autosuspend(ddev->dev);
+	amdgpu_pm_put_access(adev);
+
 	return r;
 }
 
@@ -2218,14 +2145,14 @@ static ssize_t amdgpu_get_pm_policy_attr(struct device *dev,
 	struct drm_device *ddev = dev_get_drvdata(dev);
 	struct amdgpu_device *adev = drm_to_adev(ddev);
 	struct amdgpu_pm_policy_attr *policy_attr;
+	int r;
 
 	policy_attr =
 		container_of(attr, struct amdgpu_pm_policy_attr, dev_attr);
 
-	if (amdgpu_in_reset(adev))
-		return -EPERM;
-	if (adev->in_suspend && !adev->in_runpm)
-		return -EPERM;
+	r = amdgpu_pm_dev_state_check(adev);
+	if (r)
+		return r;
 
 	return amdgpu_dpm_get_pm_policy_info(adev, policy_attr->id, buf);
 }
@@ -2243,11 +2170,6 @@ static ssize_t amdgpu_set_pm_policy_attr(struct device *dev,
 	char *tmp, *param;
 	long val;
 
-	if (amdgpu_in_reset(adev))
-		return -EPERM;
-	if (adev->in_suspend && !adev->in_runpm)
-		return -EPERM;
-
 	count = min(count, sizeof(tmp_buf));
 	memcpy(tmp_buf, buf, count);
 	tmp_buf[count - 1] = '\0';
@@ -2273,14 +2195,13 @@ static ssize_t amdgpu_set_pm_policy_attr(struct device *dev,
 	policy_attr =
 		container_of(attr, struct amdgpu_pm_policy_attr, dev_attr);
 
-	ret = pm_runtime_resume_and_get(ddev->dev);
+	ret = amdgpu_pm_get_access(adev);
 	if (ret < 0)
 		return ret;
 
 	ret = amdgpu_dpm_set_pm_policy(adev, policy_attr->id, val);
 
-	pm_runtime_mark_last_busy(ddev->dev);
-	pm_runtime_put_autosuspend(ddev->dev);
+	amdgpu_pm_put_access(adev);
 
 	if (ret)
 		return ret;
@@ -2704,18 +2625,13 @@ static ssize_t amdgpu_hwmon_get_pwm1_enable(struct device *dev,
 	u32 pwm_mode = 0;
 	int ret;
 
-	if (amdgpu_in_reset(adev))
-		return -EPERM;
-	if (adev->in_suspend && !adev->in_runpm)
-		return -EPERM;
-
-	ret = pm_runtime_get_if_active(adev->dev);
-	if (ret <= 0)
-		return ret ?: -EPERM;
+	ret = amdgpu_pm_get_access_if_active(adev);
+	if (ret)
+		return ret;
 
 	ret = amdgpu_dpm_get_fan_control_mode(adev, &pwm_mode);
 
-	pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);
+	amdgpu_pm_put_access(adev);
 
 	if (ret)
 		return -EINVAL;
@@ -2733,11 +2649,6 @@ static ssize_t amdgpu_hwmon_set_pwm1_enable(struct device *dev,
 	u32 pwm_mode;
 	int value;
 
-	if (amdgpu_in_reset(adev))
-		return -EPERM;
-	if (adev->in_suspend && !adev->in_runpm)
-		return -EPERM;
-
 	err = kstrtoint(buf, 10, &value);
 	if (err)
 		return err;
@@ -2751,14 +2662,13 @@ static ssize_t amdgpu_hwmon_set_pwm1_enable(struct device *dev,
 	else
 		return -EINVAL;
 
-	ret = pm_runtime_resume_and_get(adev->dev);
+	ret = amdgpu_pm_get_access(adev);
 	if (ret < 0)
 		return ret;
 
 	ret = amdgpu_dpm_set_fan_control_mode(adev, pwm_mode);
 
-	pm_runtime_mark_last_busy(adev_to_drm(adev)->dev);
-	pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);
+	amdgpu_pm_put_access(adev);
 
 	if (ret)
 		return -EINVAL;
@@ -2789,16 +2699,11 @@ static ssize_t amdgpu_hwmon_set_pwm1(struct device *dev,
 	u32 value;
 	u32 pwm_mode;
 
-	if (amdgpu_in_reset(adev))
-		return -EPERM;
-	if (adev->in_suspend && !adev->in_runpm)
-		return -EPERM;
-
 	err = kstrtou32(buf, 10, &value);
 	if (err)
 		return err;
 
-	err = pm_runtime_resume_and_get(adev->dev);
+	err = amdgpu_pm_get_access(adev);
 	if (err < 0)
 		return err;
 
@@ -2815,8 +2720,7 @@ static ssize_t amdgpu_hwmon_set_pwm1(struct device *dev,
 	err = amdgpu_dpm_set_fan_speed_pwm(adev, value);
 
 out:
-	pm_runtime_mark_last_busy(adev_to_drm(adev)->dev);
-	pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);
+	amdgpu_pm_put_access(adev);
 
 	if (err)
 		return err;
@@ -2832,18 +2736,13 @@ static ssize_t amdgpu_hwmon_get_pwm1(struct device *dev,
 	int err;
 	u32 speed = 0;
 
-	if (amdgpu_in_reset(adev))
-		return -EPERM;
-	if (adev->in_suspend && !adev->in_runpm)
-		return -EPERM;
-
-	err = pm_runtime_get_if_active(adev->dev);
-	if (err <= 0)
-		return err ?: -EPERM;
+	err = amdgpu_pm_get_access_if_active(adev);
+	if (err)
+		return err;
 
 	err = amdgpu_dpm_get_fan_speed_pwm(adev, &speed);
 
-	pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);
+	amdgpu_pm_put_access(adev);
 
 	if (err)
 		return err;
@@ -2859,18 +2758,13 @@ static ssize_t amdgpu_hwmon_get_fan1_input(struct device *dev,
 	int err;
 	u32 speed = 0;
 
-	if (amdgpu_in_reset(adev))
-		return -EPERM;
-	if (adev->in_suspend && !adev->in_runpm)
-		return -EPERM;
-
-	err = pm_runtime_get_if_active(adev->dev);
-	if (err <= 0)
-		return err ?: -EPERM;
+	err = amdgpu_pm_get_access_if_active(adev);
+	if (err)
+		return err;
 
 	err = amdgpu_dpm_get_fan_speed_rpm(adev, &speed);
 
-	pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);
+	amdgpu_pm_put_access(adev);
 
 	if (err)
 		return err;
@@ -2920,18 +2814,13 @@ static ssize_t amdgpu_hwmon_get_fan1_target(struct device *dev,
 	int err;
 	u32 rpm = 0;
 
-	if (amdgpu_in_reset(adev))
-		return -EPERM;
-	if (adev->in_suspend && !adev->in_runpm)
-		return -EPERM;
-
-	err = pm_runtime_get_if_active(adev->dev);
-	if (err <= 0)
-		return err ?: -EPERM;
+	err = amdgpu_pm_get_access_if_active(adev);
+	if (err)
+		return err;
 
 	err = amdgpu_dpm_get_fan_speed_rpm(adev, &rpm);
 
-	pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);
+	amdgpu_pm_put_access(adev);
 
 	if (err)
 		return err;
@@ -2948,16 +2837,11 @@ static ssize_t amdgpu_hwmon_set_fan1_target(struct device *dev,
 	u32 value;
 	u32 pwm_mode;
 
-	if (amdgpu_in_reset(adev))
-		return -EPERM;
-	if (adev->in_suspend && !adev->in_runpm)
-		return -EPERM;
-
 	err = kstrtou32(buf, 10, &value);
 	if (err)
 		return err;
 
-	err = pm_runtime_resume_and_get(adev->dev);
+	err = amdgpu_pm_get_access(adev);
 	if (err < 0)
 		return err;
 
@@ -2973,8 +2857,7 @@ static ssize_t amdgpu_hwmon_set_fan1_target(struct device *dev,
 	err = amdgpu_dpm_set_fan_speed_rpm(adev, value);
 
 out:
-	pm_runtime_mark_last_busy(adev_to_drm(adev)->dev);
-	pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);
+	amdgpu_pm_put_access(adev);
 
 	if (err)
 		return err;
@@ -2990,18 +2873,13 @@ static ssize_t amdgpu_hwmon_get_fan1_enable(struct device *dev,
 	u32 pwm_mode = 0;
 	int ret;
 
-	if (amdgpu_in_reset(adev))
-		return -EPERM;
-	if (adev->in_suspend && !adev->in_runpm)
-		return -EPERM;
-
-	ret = pm_runtime_get_if_active(adev->dev);
-	if (ret <= 0)
-		return ret ?: -EPERM;
+	ret = amdgpu_pm_get_access_if_active(adev);
+	if (ret)
+		return ret;
 
 	ret = amdgpu_dpm_get_fan_control_mode(adev, &pwm_mode);
 
-	pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);
+	amdgpu_pm_put_access(adev);
 
 	if (ret)
 		return -EINVAL;
@@ -3019,11 +2897,6 @@ static ssize_t amdgpu_hwmon_set_fan1_enable(struct device *dev,
 	int value;
 	u32 pwm_mode;
 
-	if (amdgpu_in_reset(adev))
-		return -EPERM;
-	if (adev->in_suspend && !adev->in_runpm)
-		return -EPERM;
-
 	err = kstrtoint(buf, 10, &value);
 	if (err)
 		return err;
@@ -3035,14 +2908,13 @@ static ssize_t amdgpu_hwmon_set_fan1_enable(struct device *dev,
 	else
 		return -EINVAL;
 
-	err = pm_runtime_resume_and_get(adev->dev);
+	err = amdgpu_pm_get_access(adev);
 	if (err < 0)
 		return err;
 
 	err = amdgpu_dpm_set_fan_control_mode(adev, pwm_mode);
 
-	pm_runtime_mark_last_busy(adev_to_drm(adev)->dev);
-	pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);
+	amdgpu_pm_put_access(adev);
 
 	if (err)
 		return -EINVAL;
@@ -3157,14 +3029,9 @@ static ssize_t amdgpu_hwmon_show_power_cap_generic(struct device *dev,
 	ssize_t size;
 	int r;
 
-	if (amdgpu_in_reset(adev))
-		return -EPERM;
-	if (adev->in_suspend && !adev->in_runpm)
-		return -EPERM;
-
-	r = pm_runtime_get_if_active(adev->dev);
-	if (r <= 0)
-		return r ?: -EPERM;
+	r = amdgpu_pm_get_access_if_active(adev);
+	if (r)
+		return r;
 
 	r = amdgpu_dpm_get_power_limit(adev, &limit,
 				      pp_limit_level, power_type);
@@ -3174,7 +3041,7 @@ static ssize_t amdgpu_hwmon_show_power_cap_generic(struct device *dev,
 	else
 		size = sysfs_emit(buf, "\n");
 
-	pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);
+	amdgpu_pm_put_access(adev);
 
 	return size;
 }
@@ -3235,11 +3102,6 @@ static ssize_t amdgpu_hwmon_set_power_cap(struct device *dev,
 	int err;
 	u32 value;
 
-	if (amdgpu_in_reset(adev))
-		return -EPERM;
-	if (adev->in_suspend && !adev->in_runpm)
-		return -EPERM;
-
 	if (amdgpu_sriov_vf(adev))
 		return -EINVAL;
 
@@ -3250,14 +3112,13 @@ static ssize_t amdgpu_hwmon_set_power_cap(struct device *dev,
 	value = value / 1000000; /* convert to Watt */
 	value |= limit_type << 24;
 
-	err = pm_runtime_resume_and_get(adev->dev);
+	err = amdgpu_pm_get_access(adev);
 	if (err < 0)
 		return err;
 
 	err = amdgpu_dpm_set_power_limit(adev, value);
 
-	pm_runtime_mark_last_busy(adev_to_drm(adev)->dev);
-	pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);
+	amdgpu_pm_put_access(adev);
 
 	if (err)
 		return err;
@@ -3695,20 +3556,15 @@ static int amdgpu_retrieve_od_settings(struct amdgpu_device *adev,
 	int size = 0;
 	int ret;
 
-	if (amdgpu_in_reset(adev))
-		return -EPERM;
-	if (adev->in_suspend && !adev->in_runpm)
-		return -EPERM;
-
-	ret = pm_runtime_get_if_active(adev->dev);
-	if (ret <= 0)
-		return ret ?: -EPERM;
+	ret = amdgpu_pm_get_access_if_active(adev);
+	if (ret)
+		return ret;
 
 	size = amdgpu_dpm_print_clock_levels(adev, od_type, buf);
 	if (size == 0)
 		size = sysfs_emit(buf, "\n");
 
-	pm_runtime_put_autosuspend(adev->dev);
+	amdgpu_pm_put_access(adev);
 
 	return size;
 }
@@ -3776,11 +3632,6 @@ amdgpu_distribute_custom_od_settings(struct amdgpu_device *adev,
 	long parameter[64];
 	int ret;
 
-	if (amdgpu_in_reset(adev))
-		return -EPERM;
-	if (adev->in_suspend && !adev->in_runpm)
-		return -EPERM;
-
 	ret = parse_input_od_command_lines(in_buf,
 					   count,
 					   &cmd_type,
@@ -3789,7 +3640,7 @@ amdgpu_distribute_custom_od_settings(struct amdgpu_device *adev,
 	if (ret)
 		return ret;
 
-	ret = pm_runtime_resume_and_get(adev->dev);
+	ret = amdgpu_pm_get_access(adev);
 	if (ret < 0)
 		return ret;
 
@@ -3808,14 +3659,12 @@ amdgpu_distribute_custom_od_settings(struct amdgpu_device *adev,
 			goto err_out;
 	}
 
-	pm_runtime_mark_last_busy(adev->dev);
-	pm_runtime_put_autosuspend(adev->dev);
+	amdgpu_pm_put_access(adev);
 
 	return count;
 
 err_out:
-	pm_runtime_mark_last_busy(adev->dev);
-	pm_runtime_put_autosuspend(adev->dev);
+	amdgpu_pm_put_access(adev);
 
 	return ret;
 }
@@ -4785,16 +4634,10 @@ static void amdgpu_parse_cg_state(struct seq_file *m, u64 flags)
 static int amdgpu_debugfs_pm_info_show(struct seq_file *m, void *unused)
 {
 	struct amdgpu_device *adev = (struct amdgpu_device *)m->private;
-	struct drm_device *dev = adev_to_drm(adev);
 	u64 flags = 0;
 	int r;
 
-	if (amdgpu_in_reset(adev))
-		return -EPERM;
-	if (adev->in_suspend && !adev->in_runpm)
-		return -EPERM;
-
-	r = pm_runtime_resume_and_get(dev->dev);
+	r = amdgpu_pm_get_access(adev);
 	if (r < 0)
 		return r;
 
@@ -4811,7 +4654,7 @@ static int amdgpu_debugfs_pm_info_show(struct seq_file *m, void *unused)
 	seq_printf(m, "\n");
 
 out:
-	pm_runtime_put_autosuspend(dev->dev);
+	amdgpu_pm_put_access(adev);
 
 	return r;
 }
@@ -4831,10 +4674,9 @@ static ssize_t amdgpu_pm_prv_buffer_read(struct file *f, char __user *buf,
 	void *smu_prv_buf;
 	int ret = 0;
 
-	if (amdgpu_in_reset(adev))
-		return -EPERM;
-	if (adev->in_suspend && !adev->in_runpm)
-		return -EPERM;
+	ret = amdgpu_pm_dev_state_check(adev);
+	if (ret)
+		return ret;
 
 	ret = amdgpu_dpm_get_smu_prv_buf_details(adev, &smu_prv_buf, &smu_prv_buf_size);
 	if (ret)
-- 
2.25.1

