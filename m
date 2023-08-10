Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11238C001DE
	for <amd-gfx@archiver.kernel.org>; Fri, 11 Aug 2023 03:40:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5D56610E62E;
	Fri, 11 Aug 2023 03:40:18 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2055.outbound.protection.outlook.com [40.107.93.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E243C10E629
 for <amd-gfx@lists.freedesktop.org>; Fri, 11 Aug 2023 03:40:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A58FXIayeMJECUpBq3knNLYpIOOYCjt0OJwPMDSRU9qULuisPEViSHqtFzq3NCFxP+C2M3siBpVW1rm5XQqN5LKc6ABwg00GlLD8csxyjIFl3Z5Pcbb2S32Z10NoSwv0QvmK5qpDoI997M8FLUL053ykgNc8lRD1zia0PBzzyTFJKneqwnaRn6EQK9jq6NrbZUk239Bp5/Z8u6CMGt+jJE/+OtYuqiZLwVa9aQ6WJoTT2sLayQP0UGq2NkX78qKiHlKzI3LGAkiztSZ3ZCMwGwJvcCf5etAXCJWAhXRKPFD+cPDiAV/42/mA4ZGWcvvM6qpGU67Vx4jvDJd+yPcBnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n8ONfY0vOFb/4YLSVvvrrMCecgYVymrqDXLiV9ApTH0=;
 b=LxcIpBi13+H8LdRMncH3pUlgDohVXoTbXrVMpQiSDeS6IyT/BFNBC/fRLUJc8QXO4dfBeND5w+Un3wOb21du2ZDnN0cI67UZGtbJLdl5vwQMvRYE453TqPXXJnkp9b5spPVfpZ4Cqabumvp1Fs7ywOwreFYNsemi5q3S5ixktDdYK3n7zf/A+mpVDSClbrgleBhxSVdBlZ73WanEXnlc9uTvf4yk2KMEbSMQvU08sv6RF1n71TpRhW3HkUdtPZq7A6j0lSgavtKJ9iKQAS4ivtLZAbRi7sdv+SmzzhCKpOcvcofummedM0zSdvXLervrp5TECZrBbZie+CHec2cPVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n8ONfY0vOFb/4YLSVvvrrMCecgYVymrqDXLiV9ApTH0=;
 b=tMEayDz2h8I8MCRJqMDv+qn7QS+Y/XgpG1PlfRFXPPwOCNR8NJAO/wfR6dN6twOdJ72n0/FxbfubH5+AvBN+mQ+WcPU08A2P5XRn5l8hLBePJACLSiUVtSJXPttjDrpFYPg9WUIwbPzNCu/EPSc+hCF4Mc64Hkrk5XTB0E4WI2w=
Received: from MW4PR03CA0256.namprd03.prod.outlook.com (2603:10b6:303:b4::21)
 by DS0PR12MB7630.namprd12.prod.outlook.com (2603:10b6:8:11d::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.30; Fri, 11 Aug
 2023 03:40:11 +0000
Received: from CO1PEPF000042AE.namprd03.prod.outlook.com
 (2603:10b6:303:b4:cafe::55) by MW4PR03CA0256.outlook.office365.com
 (2603:10b6:303:b4::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.30 via Frontend
 Transport; Fri, 11 Aug 2023 03:40:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000042AE.mail.protection.outlook.com (10.167.243.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6652.20 via Frontend Transport; Fri, 11 Aug 2023 03:40:10 +0000
Received: from SITE-L-T34-2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 10 Aug
 2023 22:40:09 -0500
From: Mario Limonciello <mario.limonciello@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/9] drm/amd: Add amdgpu_hwmon_get_sensor_generic()
Date: Thu, 10 Aug 2023 05:31:54 -0500
Message-ID: <20230810103202.141225-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000042AE:EE_|DS0PR12MB7630:EE_
X-MS-Office365-Filtering-Correlation-Id: 8971124d-4f23-489c-b027-08db9a1caa58
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YeVGekeri6OSk0wkwRJNI78fpQmTJXs3gL8fQlkjSfDqW/JzAw27XMFe0gqzOdEo87y5Bryk3y7q5TY7AFBbacHAGK+YI+94fUdIbwWHT9R9Zq07mXHTJr7bWGVfxGQnm3H9BSpxjfV0ZUhBHv1pHjagqOCBNzr8IPfWfxf2/k4UHJ7ZAuS0wyhmSpFggVOczIWUxaZXGRcMpxJxL6ltCU2UdaXpE8OEPmVJicGHMnDPPja4Uhxqob0GpAcZ6UIBv4jeKt3EA8vQd+lbaKDT6fWkas7ZBRcoCXzoLRkppWwPvaJMTq2JSkQq354FIoHqYZuKPPN6GAb4/fgkRPG/06LPWLrl6PjtbqwOtu3zxAu/ZG/qQj+tG6hyHb1a/E56FAjpwEGGEzXr/GT3uozbOZ3FEWqnBtRtQeXP/YskXt/Nf5Kx5TKsjPNKb/YmJDzUoLUoE0trMlEVO6FrbCRVdCnJT9uXrDP/kq51FvZYe8CAgYfjxEBcFkcC0j97oh7k+Yk4bXNnF/AnGAGAgYLVEe8NFe+pph87aV6GtCoDgnEIjmmwR+QYYx87DOF2KqME9SL9rJwwd/deECK5rdo+3wundi6JAELf8BZcu31I5KZhlp81PMoq+Kks142dL7hojLvqV1XBGk4ILkdm9OYbI72MS8P2JUB2dY0ur7FGvnhy0I6yIG0+986ZKZmIztgVKKmE7sZPyh3BjGDsX/ivDn2/b0A4SOBr0SnvVx6cffaeWO5p8evZJDDRR6zQwjVvhPJGOlzQOvOCG1bCTA1/zLZMRwy6gD+7keM+zip16vM=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(136003)(39860400002)(346002)(396003)(186006)(1800799006)(82310400008)(451199021)(36840700001)(46966006)(40470700004)(40460700003)(40480700001)(1076003)(6916009)(16526019)(336012)(26005)(478600001)(6666004)(70206006)(70586007)(36756003)(83380400001)(47076005)(2616005)(426003)(7696005)(36860700001)(41300700001)(44832011)(316002)(4326008)(2906002)(86362001)(30864003)(8676002)(8936002)(5660300002)(81166007)(82740400003)(356005)(41533002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2023 03:40:10.9195 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8971124d-4f23-489c-b027-08db9a1caa58
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000042AE.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7630
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
Cc: Mario Limonciello <mario.limonciello@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Many sensor function have a lot of boilerplate checks.  Move these
into a generic amdgpu_hwmon_get_sensor_generic() instead.

No intended functional changes.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/gpu/drm/amd/pm/amdgpu_pm.c | 321 ++++++++---------------------
 1 file changed, 88 insertions(+), 233 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
index 5aed023f74022..c0eda9bf09824 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
@@ -1467,6 +1467,32 @@ static ssize_t amdgpu_set_pp_power_profile_mode(struct device *dev,
 	return -EINVAL;
 }
 
+static unsigned int amdgpu_hwmon_get_sensor_generic(struct amdgpu_device *adev,
+						    enum amd_pp_sensors sensor,
+						    void *query)
+{
+	int r, size = sizeof(uint32_t);
+
+	if (amdgpu_in_reset(adev))
+		return -EPERM;
+	if (adev->in_suspend && !adev->in_runpm)
+		return -EPERM;
+
+	r = pm_runtime_get_sync(adev_to_drm(adev)->dev);
+	if (r < 0) {
+		pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);
+		return r;
+	}
+
+	/* get the sensor value */
+	r = amdgpu_dpm_read_sensor(adev, sensor, query, &size);
+
+	pm_runtime_mark_last_busy(adev_to_drm(adev)->dev);
+	pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);
+
+	return r;
+}
+
 /**
  * DOC: gpu_busy_percent
  *
@@ -1481,26 +1507,10 @@ static ssize_t amdgpu_get_gpu_busy_percent(struct device *dev,
 {
 	struct drm_device *ddev = dev_get_drvdata(dev);
 	struct amdgpu_device *adev = drm_to_adev(ddev);
-	int r, value, size = sizeof(value);
-
-	if (amdgpu_in_reset(adev))
-		return -EPERM;
-	if (adev->in_suspend && !adev->in_runpm)
-		return -EPERM;
-
-	r = pm_runtime_get_sync(ddev->dev);
-	if (r < 0) {
-		pm_runtime_put_autosuspend(ddev->dev);
-		return r;
-	}
-
-	/* read the IP busy sensor */
-	r = amdgpu_dpm_read_sensor(adev, AMDGPU_PP_SENSOR_GPU_LOAD,
-				   (void *)&value, &size);
-
-	pm_runtime_mark_last_busy(ddev->dev);
-	pm_runtime_put_autosuspend(ddev->dev);
+	unsigned int value;
+	int r;
 
+	r = amdgpu_hwmon_get_sensor_generic(adev, AMDGPU_PP_SENSOR_GPU_LOAD, &value);
 	if (r)
 		return r;
 
@@ -1521,26 +1531,10 @@ static ssize_t amdgpu_get_mem_busy_percent(struct device *dev,
 {
 	struct drm_device *ddev = dev_get_drvdata(dev);
 	struct amdgpu_device *adev = drm_to_adev(ddev);
-	int r, value, size = sizeof(value);
-
-	if (amdgpu_in_reset(adev))
-		return -EPERM;
-	if (adev->in_suspend && !adev->in_runpm)
-		return -EPERM;
-
-	r = pm_runtime_get_sync(ddev->dev);
-	if (r < 0) {
-		pm_runtime_put_autosuspend(ddev->dev);
-		return r;
-	}
-
-	/* read the IP busy sensor */
-	r = amdgpu_dpm_read_sensor(adev, AMDGPU_PP_SENSOR_MEM_LOAD,
-				   (void *)&value, &size);
-
-	pm_runtime_mark_last_busy(ddev->dev);
-	pm_runtime_put_autosuspend(ddev->dev);
+	unsigned int value;
+	int r;
 
+	r = amdgpu_hwmon_get_sensor_generic(adev, AMDGPU_PP_SENSOR_MEM_LOAD, &value);
 	if (r)
 		return r;
 
@@ -1814,45 +1808,15 @@ static ssize_t amdgpu_get_gpu_metrics(struct device *dev,
 	return size;
 }
 
-static int amdgpu_device_read_powershift(struct amdgpu_device *adev,
-						uint32_t *ss_power, bool dgpu_share)
-{
-	struct drm_device *ddev = adev_to_drm(adev);
-	uint32_t size;
-	int r = 0;
-
-	if (amdgpu_in_reset(adev))
-		return -EPERM;
-	if (adev->in_suspend && !adev->in_runpm)
-		return -EPERM;
-
-	r = pm_runtime_get_sync(ddev->dev);
-	if (r < 0) {
-		pm_runtime_put_autosuspend(ddev->dev);
-		return r;
-	}
-
-	if (dgpu_share)
-		r = amdgpu_dpm_read_sensor(adev, AMDGPU_PP_SENSOR_SS_DGPU_SHARE,
-				   (void *)ss_power, &size);
-	else
-		r = amdgpu_dpm_read_sensor(adev, AMDGPU_PP_SENSOR_SS_APU_SHARE,
-				   (void *)ss_power, &size);
-
-	pm_runtime_mark_last_busy(ddev->dev);
-	pm_runtime_put_autosuspend(ddev->dev);
-	return r;
-}
-
 static int amdgpu_show_powershift_percent(struct device *dev,
-					char *buf, bool dgpu_share)
+					char *buf, enum amd_pp_sensors sensor)
 {
 	struct drm_device *ddev = dev_get_drvdata(dev);
 	struct amdgpu_device *adev = drm_to_adev(ddev);
 	uint32_t ss_power;
 	int r = 0, i;
 
-	r = amdgpu_device_read_powershift(adev, &ss_power, dgpu_share);
+	r = amdgpu_hwmon_get_sensor_generic(adev, sensor, (void *)&ss_power);
 	if (r == -EOPNOTSUPP) {
 		/* sensor not available on dGPU, try to read from APU */
 		adev = NULL;
@@ -1865,14 +1829,15 @@ static int amdgpu_show_powershift_percent(struct device *dev,
 		}
 		mutex_unlock(&mgpu_info.mutex);
 		if (adev)
-			r = amdgpu_device_read_powershift(adev, &ss_power, dgpu_share);
+			r = amdgpu_hwmon_get_sensor_generic(adev, sensor, (void *)&ss_power);
 	}
 
-	if (!r)
-		r = sysfs_emit(buf, "%u%%\n", ss_power);
+	if (r)
+		return r;
 
-	return r;
+	return sysfs_emit(buf, "%u%%\n", ss_power);
 }
+
 /**
  * DOC: smartshift_apu_power
  *
@@ -1886,7 +1851,7 @@ static int amdgpu_show_powershift_percent(struct device *dev,
 static ssize_t amdgpu_get_smartshift_apu_power(struct device *dev, struct device_attribute *attr,
 					       char *buf)
 {
-	return amdgpu_show_powershift_percent(dev, buf, false);
+	return amdgpu_show_powershift_percent(dev, buf, AMDGPU_PP_SENSOR_SS_APU_SHARE);
 }
 
 /**
@@ -1902,7 +1867,7 @@ static ssize_t amdgpu_get_smartshift_apu_power(struct device *dev, struct device
 static ssize_t amdgpu_get_smartshift_dgpu_power(struct device *dev, struct device_attribute *attr,
 						char *buf)
 {
-	return amdgpu_show_powershift_percent(dev, buf, true);
+	return amdgpu_show_powershift_percent(dev, buf, AMDGPU_PP_SENSOR_SS_DGPU_SHARE);
 }
 
 /**
@@ -1965,7 +1930,6 @@ static ssize_t amdgpu_set_smartshift_bias(struct device *dev,
 	return r;
 }
 
-
 static int ss_power_attr_update(struct amdgpu_device *adev, struct amdgpu_device_attr *attr,
 				uint32_t mask, enum amdgpu_device_attr_states *states)
 {
@@ -1978,15 +1942,15 @@ static int ss_power_attr_update(struct amdgpu_device *adev, struct amdgpu_device
 static int ss_bias_attr_update(struct amdgpu_device *adev, struct amdgpu_device_attr *attr,
 			       uint32_t mask, enum amdgpu_device_attr_states *states)
 {
-	uint32_t ss_power, size;
+	uint32_t ss_power;
 
 	if (!amdgpu_device_supports_smart_shift(adev_to_drm(adev)))
 		*states = ATTR_STATE_UNSUPPORTED;
-	else if (amdgpu_dpm_read_sensor(adev, AMDGPU_PP_SENSOR_SS_APU_SHARE,
-		 (void *)&ss_power, &size))
+	else if (amdgpu_hwmon_get_sensor_generic(adev, AMDGPU_PP_SENSOR_SS_APU_SHARE,
+		 (void *)&ss_power))
 		*states = ATTR_STATE_UNSUPPORTED;
-	else if (amdgpu_dpm_read_sensor(adev, AMDGPU_PP_SENSOR_SS_DGPU_SHARE,
-		 (void *)&ss_power, &size))
+	else if (amdgpu_hwmon_get_sensor_generic(adev, AMDGPU_PP_SENSOR_SS_DGPU_SHARE,
+		 (void *)&ss_power))
 		*states = ATTR_STATE_UNSUPPORTED;
 
 	return 0;
@@ -2271,46 +2235,32 @@ static ssize_t amdgpu_hwmon_show_temp(struct device *dev,
 {
 	struct amdgpu_device *adev = dev_get_drvdata(dev);
 	int channel = to_sensor_dev_attr(attr)->index;
-	int r, temp = 0, size = sizeof(temp);
-
-	if (amdgpu_in_reset(adev))
-		return -EPERM;
-	if (adev->in_suspend && !adev->in_runpm)
-		return -EPERM;
+	int r, temp = 0;
 
 	if (channel >= PP_TEMP_MAX)
 		return -EINVAL;
 
-	r = pm_runtime_get_sync(adev_to_drm(adev)->dev);
-	if (r < 0) {
-		pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);
-		return r;
-	}
-
 	switch (channel) {
 	case PP_TEMP_JUNCTION:
 		/* get current junction temperature */
-		r = amdgpu_dpm_read_sensor(adev, AMDGPU_PP_SENSOR_HOTSPOT_TEMP,
-					   (void *)&temp, &size);
+		r = amdgpu_hwmon_get_sensor_generic(adev, AMDGPU_PP_SENSOR_HOTSPOT_TEMP,
+					   (void *)&temp);
 		break;
 	case PP_TEMP_EDGE:
 		/* get current edge temperature */
-		r = amdgpu_dpm_read_sensor(adev, AMDGPU_PP_SENSOR_EDGE_TEMP,
-					   (void *)&temp, &size);
+		r = amdgpu_hwmon_get_sensor_generic(adev, AMDGPU_PP_SENSOR_EDGE_TEMP,
+					   (void *)&temp);
 		break;
 	case PP_TEMP_MEM:
 		/* get current memory temperature */
-		r = amdgpu_dpm_read_sensor(adev, AMDGPU_PP_SENSOR_MEM_TEMP,
-					   (void *)&temp, &size);
+		r = amdgpu_hwmon_get_sensor_generic(adev, AMDGPU_PP_SENSOR_MEM_TEMP,
+					   (void *)&temp);
 		break;
 	default:
 		r = -EINVAL;
 		break;
 	}
 
-	pm_runtime_mark_last_busy(adev_to_drm(adev)->dev);
-	pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);
-
 	if (r)
 		return r;
 
@@ -2594,25 +2544,10 @@ static ssize_t amdgpu_hwmon_get_fan1_min(struct device *dev,
 {
 	struct amdgpu_device *adev = dev_get_drvdata(dev);
 	u32 min_rpm = 0;
-	u32 size = sizeof(min_rpm);
 	int r;
 
-	if (amdgpu_in_reset(adev))
-		return -EPERM;
-	if (adev->in_suspend && !adev->in_runpm)
-		return -EPERM;
-
-	r = pm_runtime_get_sync(adev_to_drm(adev)->dev);
-	if (r < 0) {
-		pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);
-		return r;
-	}
-
-	r = amdgpu_dpm_read_sensor(adev, AMDGPU_PP_SENSOR_MIN_FAN_RPM,
-				   (void *)&min_rpm, &size);
-
-	pm_runtime_mark_last_busy(adev_to_drm(adev)->dev);
-	pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);
+	r = amdgpu_hwmon_get_sensor_generic(adev, AMDGPU_PP_SENSOR_MIN_FAN_RPM,
+				   (void *)&min_rpm);
 
 	if (r)
 		return r;
@@ -2626,25 +2561,10 @@ static ssize_t amdgpu_hwmon_get_fan1_max(struct device *dev,
 {
 	struct amdgpu_device *adev = dev_get_drvdata(dev);
 	u32 max_rpm = 0;
-	u32 size = sizeof(max_rpm);
 	int r;
 
-	if (amdgpu_in_reset(adev))
-		return -EPERM;
-	if (adev->in_suspend && !adev->in_runpm)
-		return -EPERM;
-
-	r = pm_runtime_get_sync(adev_to_drm(adev)->dev);
-	if (r < 0) {
-		pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);
-		return r;
-	}
-
-	r = amdgpu_dpm_read_sensor(adev, AMDGPU_PP_SENSOR_MAX_FAN_RPM,
-				   (void *)&max_rpm, &size);
-
-	pm_runtime_mark_last_busy(adev_to_drm(adev)->dev);
-	pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);
+	r = amdgpu_hwmon_get_sensor_generic(adev, AMDGPU_PP_SENSOR_MAX_FAN_RPM,
+				   (void *)&max_rpm);
 
 	if (r)
 		return r;
@@ -2806,26 +2726,11 @@ static ssize_t amdgpu_hwmon_show_vddgfx(struct device *dev,
 {
 	struct amdgpu_device *adev = dev_get_drvdata(dev);
 	u32 vddgfx;
-	int r, size = sizeof(vddgfx);
-
-	if (amdgpu_in_reset(adev))
-		return -EPERM;
-	if (adev->in_suspend && !adev->in_runpm)
-		return -EPERM;
-
-	r = pm_runtime_get_sync(adev_to_drm(adev)->dev);
-	if (r < 0) {
-		pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);
-		return r;
-	}
+	int r;
 
 	/* get the voltage */
-	r = amdgpu_dpm_read_sensor(adev, AMDGPU_PP_SENSOR_VDDGFX,
-				   (void *)&vddgfx, &size);
-
-	pm_runtime_mark_last_busy(adev_to_drm(adev)->dev);
-	pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);
-
+	r = amdgpu_hwmon_get_sensor_generic(adev, AMDGPU_PP_SENSOR_VDDGFX,
+				   (void *)&vddgfx);
 	if (r)
 		return r;
 
@@ -2845,30 +2750,15 @@ static ssize_t amdgpu_hwmon_show_vddnb(struct device *dev,
 {
 	struct amdgpu_device *adev = dev_get_drvdata(dev);
 	u32 vddnb;
-	int r, size = sizeof(vddnb);
-
-	if (amdgpu_in_reset(adev))
-		return -EPERM;
-	if (adev->in_suspend && !adev->in_runpm)
-		return -EPERM;
+	int r;
 
 	/* only APUs have vddnb */
 	if  (!(adev->flags & AMD_IS_APU))
 		return -EINVAL;
 
-	r = pm_runtime_get_sync(adev_to_drm(adev)->dev);
-	if (r < 0) {
-		pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);
-		return r;
-	}
-
 	/* get the voltage */
-	r = amdgpu_dpm_read_sensor(adev, AMDGPU_PP_SENSOR_VDDNB,
-				   (void *)&vddnb, &size);
-
-	pm_runtime_mark_last_busy(adev_to_drm(adev)->dev);
-	pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);
-
+	r = amdgpu_hwmon_get_sensor_generic(adev, AMDGPU_PP_SENSOR_VDDNB,
+				   (void *)&vddnb);
 	if (r)
 		return r;
 
@@ -2882,40 +2772,35 @@ static ssize_t amdgpu_hwmon_show_vddnb_label(struct device *dev,
 	return sysfs_emit(buf, "vddnb\n");
 }
 
-static ssize_t amdgpu_hwmon_show_power_avg(struct device *dev,
-					   struct device_attribute *attr,
-					   char *buf)
+static unsigned int amdgpu_hwmon_get_power(struct device *dev,
+					   enum amd_pp_sensors sensor)
 {
 	struct amdgpu_device *adev = dev_get_drvdata(dev);
+	unsigned int uw;
 	u32 query = 0;
-	int r, size = sizeof(u32);
-	unsigned uw;
-
-	if (amdgpu_in_reset(adev))
-		return -EPERM;
-	if (adev->in_suspend && !adev->in_runpm)
-		return -EPERM;
-
-	r = pm_runtime_get_sync(adev_to_drm(adev)->dev);
-	if (r < 0) {
-		pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);
-		return r;
-	}
-
-	/* get the voltage */
-	r = amdgpu_dpm_read_sensor(adev, AMDGPU_PP_SENSOR_GPU_POWER,
-				   (void *)&query, &size);
-
-	pm_runtime_mark_last_busy(adev_to_drm(adev)->dev);
-	pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);
+	int r;
 
+	r = amdgpu_hwmon_get_sensor_generic(adev, sensor, (void *)&query);
 	if (r)
 		return r;
 
 	/* convert to microwatts */
 	uw = (query >> 8) * 1000000 + (query & 0xff) * 1000;
 
-	return sysfs_emit(buf, "%u\n", uw);
+	return uw;
+}
+
+static ssize_t amdgpu_hwmon_show_power_avg(struct device *dev,
+					   struct device_attribute *attr,
+					   char *buf)
+{
+	unsigned int val;
+
+	val = amdgpu_hwmon_get_power(dev, AMDGPU_PP_SENSOR_GPU_POWER);
+	if (val < 0)
+		return val;
+
+	return sysfs_emit(buf, "%u\n", val);
 }
 
 static ssize_t amdgpu_hwmon_show_power_cap_min(struct device *dev,
@@ -3050,26 +2935,11 @@ static ssize_t amdgpu_hwmon_show_sclk(struct device *dev,
 {
 	struct amdgpu_device *adev = dev_get_drvdata(dev);
 	uint32_t sclk;
-	int r, size = sizeof(sclk);
-
-	if (amdgpu_in_reset(adev))
-		return -EPERM;
-	if (adev->in_suspend && !adev->in_runpm)
-		return -EPERM;
-
-	r = pm_runtime_get_sync(adev_to_drm(adev)->dev);
-	if (r < 0) {
-		pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);
-		return r;
-	}
+	int r;
 
 	/* get the sclk */
-	r = amdgpu_dpm_read_sensor(adev, AMDGPU_PP_SENSOR_GFX_SCLK,
-				   (void *)&sclk, &size);
-
-	pm_runtime_mark_last_busy(adev_to_drm(adev)->dev);
-	pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);
-
+	r = amdgpu_hwmon_get_sensor_generic(adev, AMDGPU_PP_SENSOR_GFX_SCLK,
+				   (void *)&sclk);
 	if (r)
 		return r;
 
@@ -3089,26 +2959,11 @@ static ssize_t amdgpu_hwmon_show_mclk(struct device *dev,
 {
 	struct amdgpu_device *adev = dev_get_drvdata(dev);
 	uint32_t mclk;
-	int r, size = sizeof(mclk);
-
-	if (amdgpu_in_reset(adev))
-		return -EPERM;
-	if (adev->in_suspend && !adev->in_runpm)
-		return -EPERM;
-
-	r = pm_runtime_get_sync(adev_to_drm(adev)->dev);
-	if (r < 0) {
-		pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);
-		return r;
-	}
+	int r;
 
 	/* get the sclk */
-	r = amdgpu_dpm_read_sensor(adev, AMDGPU_PP_SENSOR_GFX_MCLK,
-				   (void *)&mclk, &size);
-
-	pm_runtime_mark_last_busy(adev_to_drm(adev)->dev);
-	pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);
-
+	r = amdgpu_hwmon_get_sensor_generic(adev, AMDGPU_PP_SENSOR_GFX_MCLK,
+				   (void *)&mclk);
 	if (r)
 		return r;
 
-- 
2.34.1

