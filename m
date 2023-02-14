Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AEACDC61DA4
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Feb 2023 07:54:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 50B9210E7FD;
	Tue, 14 Feb 2023 07:54:42 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on20615.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e89::615])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4725410E7FD
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Feb 2023 07:54:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a4pufLsPkLnURuwbJlPh8p8cDTUsdX2X9FMeCNB3FoNXU7FMcnjpBn7NigJeceG6o/lbh1w1LbahKLfEiaS4FY2WgJ9IYJ1VYv0e8V5PVzC7pwN9KZanPoZp41ZX+lwuHWJI6JscPSTKjmcZmIcBNaz2S+LgjhKK/Jkpdq1hTdFhoiVA5qowUJxIrVk//AVTQA9z+1IcVEYqRYxlm96SMFm31kXdju+SBpfRG+sRKSfe4snYAbnsSvP3DPcykhrxuQUred1LtGdFp7dEcDyaPJUVvwiNYVlG7QgYtV+nzVYMSolC7uX4OR7fMvq9kuZLqxtos828OrJ5bod2IcbVzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gZtYqA3B8qcjHpFQ4W6xT6b4xrVULMe/w/J1eTSvsQ4=;
 b=EUlHMlgbbU4ITkW27RmOBTItSS2ziSp+zas6M6a3bLMCD70zzRG+7lYAv21Ku/bgMlW7d8fS9YIhu5dTZrypgxO1vutiwmDoD0zXBNBNdIKMKf+OCCqOPbOMCfAM0S4t5KHQTZ5qS1HrAUCbDugC14bOzVqF6jCQ+xVKi0TYunpvO6dw8vo7qkYvgao4gkIy1WgEx8NzUMTJsePCUJs8SKGISY370mkHijyIg5fj5vpEDB60NIMG5DfS0vb4XIBlZXD2E2yGYt6maaCUdbMIlFzvMqAL4F0dBXgmq9xNZLuSFKrHs2vGvuO86uE2jtEHW8qg+5CTr77Fh+4vAmPDVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gZtYqA3B8qcjHpFQ4W6xT6b4xrVULMe/w/J1eTSvsQ4=;
 b=X1EJ2sOpxkKS0SODjBQI/X8Cf0WFgNyIUiDRFbdGzt+qs+6C6jpN7UBb/BDSNq5L5bAVr6JaDXFKztu/FzAMfrC67jVWe8IsTyKC5YXbauuSnV7B283hTvIoKry408p+sit+sLNR29GBTWDIEU4Nvsjwz+QqGr6HkHE8MlLto74=
Received: from DM6PR08CA0062.namprd08.prod.outlook.com (2603:10b6:5:1e0::36)
 by SJ2PR12MB8691.namprd12.prod.outlook.com (2603:10b6:a03:541::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.24; Tue, 14 Feb
 2023 07:54:36 +0000
Received: from DS1PEPF0000E640.namprd02.prod.outlook.com
 (2603:10b6:5:1e0:cafe::b7) by DM6PR08CA0062.outlook.office365.com
 (2603:10b6:5:1e0::36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.26 via Frontend
 Transport; Tue, 14 Feb 2023 07:54:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF0000E640.mail.protection.outlook.com (10.167.17.202) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6111.8 via Frontend Transport; Tue, 14 Feb 2023 07:54:35 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 14 Feb
 2023 01:54:35 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 13 Feb
 2023 23:54:35 -0800
Received: from vads-PC.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2375.34 via Frontend
 Transport; Tue, 14 Feb 2023 01:54:33 -0600
From: kunliu13 <Kun.Liu2@amd.com>
To: <Mario.Limonciello@amd.com>, <Richardqi.Liang@amd.com>,
 <Perry.Yuan@amd.com>, <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/2] drm/amdgpu: added a sysfs interface for thermal throttling
Date: Tue, 14 Feb 2023 15:54:27 +0800
Message-ID: <20230214075427.31127-1-Kun.Liu2@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0000E640:EE_|SJ2PR12MB8691:EE_
X-MS-Office365-Filtering-Correlation-Id: 79b2462d-4ef7-473f-e2c5-08db0e60b769
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nJ5QEaA9OJmMyOCWhNbWjb8KD9J0+JzkRX6KnIFDOBKpPAwXsmdhFTv5m6XeczxZHw8TjbjwTUCupNprcQ+17uZ+UmX14sVzFs2MojKXKnNVtedYFUSGSGalZBLMCbz2oBr5whAEUuaYOWiDd3nt8Ylgyp+ErwIUfiu8omvFz6Ngl3ozRwD0Yr8QkKe4khlynBNvzsDZuYAx3PqA6WIBw19dT1FjPhTOAmdkUpe1fbnZBpqnKgmlPOb5k9eQ7p0VpclgvKMKy5GfCepXyUYComhiaHYJYtwDlZmeD7mQ03WTv1ZXK9QKeG3FjyX5Uib8hcqDX73iZq4kLA6SQWgO7wYwWyYIBhyV7zLDdgfu+vpaHyxh+78CyykGLe7xv/TFeGXwhHGjixFFYZ0nr1SDlxQzzXUBA0osxEZOwXMfv8fDMiMEc6Whsslo0gSK0tP5pAMj45kgz6V3cx2pZ5sxeLZ3p4YDP2LvElhPhqPACuB0Fm1tsg7PhHBHEMqR7W4j+n8RxrwASULBV7PvMv+jrR3mNsCdn9wBDfeaVjlo7eIGwSKgESvvaLnfqRjdiiKOT9u6HUzTOvX3GzjyBiWlFAUq/N5LaSUU7uDcL9dGiD1SwXSE88iafHZN5ebetDxPCq+Tsqm+2cKnylYG3MccKBW7cQKexlXJWVtC8dNf3si3TyjK5i9bUEaBFNlH83VN62ir/z6C7eThDo6n7mDHP7egPTzRJmRO2DSCwK/GytODlGbwv9VL5Lq13qmwVX2jU5aPcU7vEhiqyWnub95MuAhCTQjLzM5ccBKoUsZjjPM=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230025)(4636009)(396003)(346002)(376002)(39860400002)(136003)(451199018)(40470700004)(46966006)(36840700001)(316002)(478600001)(6666004)(2616005)(86362001)(110136005)(82310400005)(54906003)(40460700003)(2906002)(70206006)(4326008)(8676002)(36860700001)(5660300002)(41300700001)(36756003)(426003)(1076003)(186003)(26005)(336012)(7696005)(47076005)(40480700001)(82740400003)(8936002)(70586007)(356005)(81166007)(83380400001)(43062005)(16060500005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2023 07:54:35.9095 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 79b2462d-4ef7-473f-e2c5-08db0e60b769
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF0000E640.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8691
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
Cc: Alexander.Deucher@amd.com, Evan.Quan@amd.com, Xiaojian.Du@amd.com,
 kunliu13 <Kun.Liu2@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

added a sysfs interface for thermal throttling, then userspace can get/update thermal limit

Jira ID: SWDEV-354511
Signed-off-by: Kun Liu <Kun.Liu2@amd.com>

Change-Id: I9948cb8966b731d2d74d7aad87cbcdc840dd34c8
---
 .../gpu/drm/amd/include/kgd_pp_interface.h    |  2 +
 drivers/gpu/drm/amd/pm/amdgpu_dpm.c           | 28 +++++++
 drivers/gpu/drm/amd/pm/amdgpu_pm.c            | 76 +++++++++++++++++++
 drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h       |  3 +
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c     | 24 ++++++
 drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h | 12 +++
 6 files changed, 145 insertions(+)

diff --git a/drivers/gpu/drm/amd/include/kgd_pp_interface.h b/drivers/gpu/drm/amd/include/kgd_pp_interface.h
index f3d64c78f..8394464ea 100644
--- a/drivers/gpu/drm/amd/include/kgd_pp_interface.h
+++ b/drivers/gpu/drm/amd/include/kgd_pp_interface.h
@@ -331,6 +331,8 @@ struct amd_pm_funcs {
 	int (*get_mclk_od)(void *handle);
 	int (*set_mclk_od)(void *handle, uint32_t value);
 	int (*read_sensor)(void *handle, int idx, void *value, int *size);
+	int (*get_apu_thermal_limit)(void *handle, uint32_t *limit);
+	int (*set_apu_thermal_limit)(void *handle, uint32_t limit);
 	enum amd_dpm_forced_level (*get_performance_level)(void *handle);
 	enum amd_pm_state_type (*get_current_power_state)(void *handle);
 	int (*get_fan_speed_rpm)(void *handle, uint32_t *rpm);
diff --git a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
index 1b300c569..d9a9cf189 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
@@ -438,6 +438,34 @@ int amdgpu_dpm_read_sensor(struct amdgpu_device *adev, enum amd_pp_sensors senso
 	return ret;
 }
 
+int amdgpu_dpm_get_apu_thermal_limit(struct amdgpu_device *adev, uint32_t *limit)
+{
+	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
+	int ret = -EINVAL;
+
+	if (pp_funcs && pp_funcs->get_apu_thermal_limit) {
+		mutex_lock(&adev->pm.mutex);
+		ret = pp_funcs->get_apu_thermal_limit(adev->powerplay.pp_handle, limit);
+		mutex_unlock(&adev->pm.mutex);
+	}
+
+	return ret;
+}
+
+int amdgpu_dpm_set_apu_thermal_limit(struct amdgpu_device *adev, uint32_t limit)
+{
+	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
+	int ret = -EINVAL;
+
+	if (pp_funcs && pp_funcs->set_apu_thermal_limit) {
+		mutex_lock(&adev->pm.mutex);
+		ret = pp_funcs->set_apu_thermal_limit(adev->powerplay.pp_handle, limit);
+		mutex_unlock(&adev->pm.mutex);
+	}
+
+	return ret;
+}
+
 void amdgpu_dpm_compute_clocks(struct amdgpu_device *adev)
 {
 	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
index 236657eec..99b249e55 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
@@ -1685,6 +1685,81 @@ static ssize_t amdgpu_set_thermal_throttling_logging(struct device *dev,
 	return count;
 }
 
+/**
+ * DOC: apu_thermal_cap
+ *
+ * The amdgpu driver provides a sysfs API for retrieving/updating thermal
+ * limit temperature in millidegrees Celsius
+ *
+ * Reading back the file shows you core limit value
+ *
+ * Writing an integer to the file, sets a new thermal limit. The value
+ * should be between 0 and 100. If the value is less than 0 or greater
+ * than 100, then the write request will be ignored.
+ */
+static ssize_t amdgpu_get_apu_thermal_cap(struct device *dev,
+				     struct device_attribute *attr,
+				     char *buf)
+{
+	int ret, size = 0;
+	u32 limit;
+	struct drm_device *ddev = dev_get_drvdata(dev);
+	struct amdgpu_device *adev = drm_to_adev(ddev);
+
+	ret = pm_runtime_get_sync(ddev->dev);
+	if (ret < 0) {
+		pm_runtime_put_autosuspend(ddev->dev);
+		return size;
+	}
+
+	ret = amdgpu_dpm_get_apu_thermal_limit(adev, &limit);
+	if (!ret)
+		size = sysfs_emit(buf, "%u\n", limit);
+	else
+		size = sysfs_emit(buf, "failed to get thermal limit\n");
+
+	pm_runtime_mark_last_busy(ddev->dev);
+	pm_runtime_put_autosuspend(ddev->dev);
+
+	return size;
+}
+
+static ssize_t amdgpu_set_apu_thermal_cap(struct device *dev,
+				     struct device_attribute *attr,
+				     const char *buf,
+				     size_t count)
+{
+	int ret;
+	u32 value;
+	struct drm_device *ddev = dev_get_drvdata(dev);
+	struct amdgpu_device *adev = drm_to_adev(ddev);
+
+	ret = kstrtou32(buf, 10, &value);
+	if (ret)
+		return ret;
+
+	if (value < 0 || value > 100) {
+		dev_err(dev, "Invalid argument !\n");
+		return count;
+	}
+
+	ret = pm_runtime_get_sync(ddev->dev);
+	if (ret < 0) {
+		pm_runtime_put_autosuspend(ddev->dev);
+		return ret;
+	}
+
+	ret = amdgpu_dpm_set_apu_thermal_limit(adev, value);
+	if (ret)
+		dev_err(dev, "failed to update thermal limit\n");
+
+	pm_runtime_mark_last_busy(ddev->dev);
+	pm_runtime_put_autosuspend(ddev->dev);
+
+	return count;
+}
+
+
 /**
  * DOC: gpu_metrics
  *
@@ -1937,6 +2012,7 @@ static struct amdgpu_device_attr amdgpu_device_attrs[] = {
 	AMDGPU_DEVICE_ATTR_RW(pp_features,				ATTR_FLAG_BASIC|ATTR_FLAG_ONEVF),
 	AMDGPU_DEVICE_ATTR_RO(unique_id,				ATTR_FLAG_BASIC|ATTR_FLAG_ONEVF),
 	AMDGPU_DEVICE_ATTR_RW(thermal_throttling_logging,		ATTR_FLAG_BASIC|ATTR_FLAG_ONEVF),
+	AMDGPU_DEVICE_ATTR_RW(apu_thermal_cap,			ATTR_FLAG_BASIC|ATTR_FLAG_ONEVF),
 	AMDGPU_DEVICE_ATTR_RO(gpu_metrics,				ATTR_FLAG_BASIC|ATTR_FLAG_ONEVF),
 	AMDGPU_DEVICE_ATTR_RO(smartshift_apu_power,			ATTR_FLAG_BASIC,
 			      .attr_update = ss_power_attr_update),
diff --git a/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h b/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
index cb5b9df78..0cc379ea1 100644
--- a/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
+++ b/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
@@ -369,6 +369,9 @@ struct amdgpu_pm {
 int amdgpu_dpm_read_sensor(struct amdgpu_device *adev, enum amd_pp_sensors sensor,
 			   void *data, uint32_t *size);
 
+int amdgpu_dpm_get_apu_thermal_limit(struct amdgpu_device *adev, uint32_t *limit);
+int amdgpu_dpm_set_apu_thermal_limit(struct amdgpu_device *adev, uint32_t limit);
+
 int amdgpu_dpm_set_powergating_by_smu(struct amdgpu_device *adev,
 				      uint32_t block_type, bool gate);
 
diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
index 2fa79f892..b612fb6bd 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -2514,6 +2514,28 @@ static int smu_read_sensor(void *handle,
 	return ret;
 }
 
+static int smu_get_apu_thermal_limit(void *handle, uint32_t *limit)
+{
+	int ret = -EINVAL;
+	struct smu_context *smu = handle;
+
+	if (smu->ppt_funcs && smu->ppt_funcs->get_apu_thermal_limit)
+		ret = smu->ppt_funcs->get_apu_thermal_limit(smu, limit);
+
+	return ret;
+}
+
+static int smu_set_apu_thermal_limit(void *handle, uint32_t limit)
+{
+	int ret = -EINVAL;
+	struct smu_context *smu = handle;
+
+	if (smu->ppt_funcs && smu->ppt_funcs->set_apu_thermal_limit)
+		ret = smu->ppt_funcs->set_apu_thermal_limit(smu, limit);
+
+	return ret;
+}
+
 static int smu_get_power_profile_mode(void *handle, char *buf)
 {
 	struct smu_context *smu = handle;
@@ -2998,6 +3020,8 @@ static const struct amd_pm_funcs swsmu_pm_funcs = {
 	.emit_clock_levels       = smu_emit_ppclk_levels,
 	.force_performance_level = smu_force_performance_level,
 	.read_sensor             = smu_read_sensor,
+	.get_apu_thermal_limit       = smu_get_apu_thermal_limit,
+	.set_apu_thermal_limit       = smu_set_apu_thermal_limit,
 	.get_performance_level   = smu_get_performance_level,
 	.get_current_power_state = smu_get_current_power_state,
 	.get_fan_speed_rpm       = smu_get_fan_speed_rpm,
diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
index 3bc4128a2..378d3df4d 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
@@ -721,6 +721,18 @@ struct pptable_funcs {
 	int (*read_sensor)(struct smu_context *smu, enum amd_pp_sensors sensor,
 			   void *data, uint32_t *size);
 
+	/**
+	 * @get_apu_thermal_limit: get apu core limit from smu
+	 * &limit: current limit temperature in millidegrees Celsius
+	 */
+	int (*get_apu_thermal_limit)(struct smu_context *smu, uint32_t *limit);
+
+	/**
+	 * @set_apu_thermal_limit: update all controllers with new limit
+	 * &limit: limit temperature to be setted, in millidegrees Celsius
+	 */
+	int (*set_apu_thermal_limit)(struct smu_context *smu, uint32_t limit);
+
 	/**
 	 * @pre_display_config_changed: Prepare GPU for a display configuration
 	 *                              change.
-- 
2.25.1

