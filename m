Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE512C636CC
	for <amd-gfx@archiver.kernel.org>; Thu, 16 Feb 2023 07:16:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 24FF610E311;
	Thu, 16 Feb 2023 07:16:55 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on20617.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eab::617])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5FC8A10E311
 for <amd-gfx@lists.freedesktop.org>; Thu, 16 Feb 2023 07:16:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AB1EQIIfsl1BGvfoE0wYedrweXdBz7H+O9jVmoUcSPK0QdCKbeqtZEUBvSITsu4yU9yWFbbUqxK0HJUvjl8jLlZyMTWxgyR63oMk4awjl4gG6iMMd4IGeQU6ektx+xpFc6HzDBegEveXojVuK0XT4lKv4tgNZPJuF40m6NkUObHYYlWMFMy95o1xzbv/vBg53PqcIPavUvXxWDsF6iYKIrShy4Uzqt1bjEynxp4gfBYRM3Ni6oaPYsekqs74WzHSGUInFTFWPHV3U3zSFDbeMOsh+RwSGA1OMja8fMGPvHJbJjQEM6YnjW5fh1EyaavYzvpN5Vv4OJGXXIJb39+7CA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xceZ4jOdGXy7gu8Zsqf86pAyRyhagmCQVb3o2sTltMY=;
 b=L5gekkxiGpi2omSfzX914aPh1Nh26JAluMxALPFkWcb1my6d8E+a1gJdwCRmEzqCueqlu6jUa6Y71ocQnUv+Euvu2u6Zh6/+74Vff2WiZGMrDrBbP77DWIxcwBvvNfoeNldTE4/hRP9VxFd1UEwqsemVum7Us+YWt1C1fhXgRy05YUpqUYJ2OJIm5c9WzVqD3/QkRQGWcLRV8N79ELiY5ZNHHewEgeFvIHk7SU0m70GKuuWgsFs/oqmJhs2FifFshQbGmPlHWBuxE6LuNuGB60PMfO3YAYQpDLiPmODv9xopWPHgeGYyYMRCGn83Mxy+Ku8sMPsGBzlhrUc9SpO56Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xceZ4jOdGXy7gu8Zsqf86pAyRyhagmCQVb3o2sTltMY=;
 b=LMDh/VaonWhga6dnlp6lBJ8+0SRgdyZGAbZ3PZBe8OzqqO7lgM0sSLNbQ+faIS55xXh66/gHh6H9vUsG0uw9vkqHLEFnfOY6Zz964PpI7EYpYxo0HO5j98iWcXNGIEPG8OIkXYtFyqOdJ7NxA57qmYYfi8W6K9XbQnl+BMvJYRc=
Received: from BN9PR03CA0108.namprd03.prod.outlook.com (2603:10b6:408:fd::23)
 by CY8PR12MB8213.namprd12.prod.outlook.com (2603:10b6:930:71::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.26; Thu, 16 Feb
 2023 07:16:51 +0000
Received: from BN8NAM11FT027.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:fd:cafe::86) by BN9PR03CA0108.outlook.office365.com
 (2603:10b6:408:fd::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.26 via Frontend
 Transport; Thu, 16 Feb 2023 07:16:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN8NAM11FT027.mail.protection.outlook.com (10.13.177.96) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6111.13 via Frontend Transport; Thu, 16 Feb 2023 07:16:51 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 16 Feb
 2023 01:16:50 -0600
Received: from vads-PC.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2375.34 via Frontend
 Transport; Thu, 16 Feb 2023 01:16:47 -0600
From: kunliu13 <Kun.Liu2@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <Evan.Quan@amd.com>,
 <Christian.Koenig@amd.com>
Subject: [PATCH 1/2] drm/amdgpu: added a sysfs interface for thermal throttling
Date: Thu, 16 Feb 2023 15:16:46 +0800
Message-ID: <20230216071646.200661-1-Kun.Liu2@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT027:EE_|CY8PR12MB8213:EE_
X-MS-Office365-Filtering-Correlation-Id: 2f8a4285-4ee0-464c-0ab4-08db0fedc645
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yAr4wIIV5o9WVUI7+CY/hwnJbgpF49WL0jAmU+E2WxsSlYb6nFHE9F+sCYU/VnDtXx6dHYVbFotaqbf0qVTF3PuWjD+NE+6IIK6zwcXI4H8nFU12ymlzE0AGs6Q0GPXB65OFgTGz+OgBIqP0cjcgq0qvfgjNQ+vtFfbR/RjZ4Bu+0U9Jl72/ZWOP4tj9g3VNC6i2szNZQ0uS8rre8wIqf304unQgsLnA8f5xR9o42/fjakeprVFYfrBe0s8wleepWknt8qadlEU8jmbrARMdu8IwqvBvTYmk4cxxt2opKjc+WB+lQFuGmJxWh2o/zXFwK+jjZrm6TcHeCVI5yn9y3pNolho8ZnBu6ya8jfv5b6U9Oogayn9IL7qXZ19TRmJBvZ5U0ytsZJPTM7+ZhKFyzpmbuXJZAotaQ017OeBxR8BQCdmfHxQA0Tf8A0uc+pzQ5ft8djdPI3zyo1zDgGU4G32NU4UfJu4KM6LsiYXyuaLLRT+dE3TfTz8oCQ0F0rOW+zzkzlNjVqZGXqbwrCApAhtul5tLv5JYJrld4Pq4/t2GdUVxY4rE4TbgYiZnfFIQCpZA/knX8/0Nhb1sL4MPtCtWp7wk685jsl+op9a8ExSMXQN/o8nWxcDMWuiDbgnwfWrxy949uszfxo7o7g3OtZVZddzOsiqrtl+7ZFQ1qPtSg9dwwHswD1JjD41BQdyCNCeVLELaYnDYH7418bIenU9B0P4F+UF2XkHrl4EjNLr9I6P08LW48B4F3TugjDrRmRmSzhJXPJagvaoN+TcnyZqsym5DR7KVhFKuy9VnArg=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230025)(4636009)(136003)(396003)(39860400002)(376002)(346002)(451199018)(40470700004)(36840700001)(46966006)(70586007)(70206006)(8936002)(6636002)(5660300002)(110136005)(54906003)(4326008)(2906002)(316002)(41300700001)(8676002)(7696005)(478600001)(1076003)(186003)(2616005)(26005)(336012)(40460700003)(36756003)(36860700001)(83380400001)(426003)(47076005)(82310400005)(356005)(81166007)(86362001)(40480700001)(82740400003)(43062005)(36900700001)(16060500005);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Feb 2023 07:16:51.0667 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f8a4285-4ee0-464c-0ab4-08db0fedc645
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT027.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8213
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
Cc: Guchun.Chen@amd.com, Xiaojian.Du@amd.com, Perry.Yuan@amd.com,
 Alexander.Deucher@amd.com, Richardqi.Liang@amd.com,
 kunliu13 <Kun.Liu2@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

added a sysfs interface for thermal throttling, then userspace can get/update thermal limit

Signed-off-by: Kun Liu <Kun.Liu2@amd.com>
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
index 236657eec..085bbd686 100644
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
+	int ret, size;
+	u32 limit;
+	struct drm_device *ddev = dev_get_drvdata(dev);
+	struct amdgpu_device *adev = drm_to_adev(ddev);
+
+	ret = pm_runtime_get_sync(ddev->dev);
+	if (ret < 0) {
+		pm_runtime_put_autosuspend(ddev->dev);
+		return ret;
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

