Return-Path: <SRS0=H3yO=K3=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAFF1C47080
	for <amd-gfx@archiver.kernel.org>; Tue,  1 Jun 2021 16:44:45 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4F8C5613B9
	for <amd-gfx@archiver.kernel.org>; Tue,  1 Jun 2021 16:44:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F8C5613B9
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0C44D6EAAD;
	Tue,  1 Jun 2021 16:44:45 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2062.outbound.protection.outlook.com [40.107.244.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ABFFF6EAAD
 for <amd-gfx@lists.freedesktop.org>; Tue,  1 Jun 2021 16:44:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PXW1SrKiSMzjQ/b0CqRcv/xqllh7KhH6DQQLHBs6Xc2DOEJuv0yiCsD9M3ETZAN4/VigirO2RhQCAq8D5i9Sd1Hkau6bRCtm2vU2WdLToX6XRZb9LW4qR38MuJk0BQH9Ed3XS6svsLo4Py0t62AntkjyYVSjmBZf97j/iFqGd+s8/iDiNCNsnfA4EF3BYYRW6uUCOf0jBV1CotrBs2nMU6sT3z47RJ4MnZ59uBW+zxQpRYtB247/ubYmfR037hEkuU3hv3pSCu+aiUHT6rm7Pj0z/oAafy1MhEMLBfzXoWo0fWjyJmSo0OKEKQCOiPu5aiFR7M7oU6OkVp95SuPd2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FpVqrfTOJpVonxAwlOiSu2Ewp4jccLCkMFxGXAN4TZY=;
 b=ND+7ZUF44NuOgP7LLKpf7X+l82SD9nCCg/xstYccXDZSrxn4+sDjrfGli4khrgyRQ+qtTzbpGceOh+L4RrtCDITAY8P0A/pmBfgKXx0oyOEucH8+BQoK6toFFOBS2NWCoC74u/55N6F4cdv5dH7c7uGX31uoPJg+b/63ks+Q5KTHwb3kJkRYP1NGrMwr8B9TEh9yQZaSIBf/PT8zZVkCOCBXmtQaIzCrFP3f8aE1Nc+BFvT2+r2/FISv6pfXjWihXkQw+EYSC45UIW34hL8WgXQjhNLmMAD4b5ayAJDL/aNN4SjSUxavaCXy5/2QK2tEdV+AIm3trhY1oVAH71rhUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FpVqrfTOJpVonxAwlOiSu2Ewp4jccLCkMFxGXAN4TZY=;
 b=sDe+6bLs9nCTzq8u8yqODN//Pbh5+dwSPW6R+cGNTK+POKYQtMwwe5nFY/Zxei5Hj7HTMUt2z68OApLzOkoV/da9uhCv04t7MAescGhUMV6WqlySPnAeNHSD+fKWogtS2IB3/k7lh2U1ezviIqxg4OxbqF4ZHoWM1YPjJ1JQlfE=
Received: from MWHPR22CA0068.namprd22.prod.outlook.com (2603:10b6:300:12a::30)
 by CH2PR12MB4183.namprd12.prod.outlook.com (2603:10b6:610:7a::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.22; Tue, 1 Jun
 2021 16:44:42 +0000
Received: from CO1NAM11FT043.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:12a:cafe::7d) by MWHPR22CA0068.outlook.office365.com
 (2603:10b6:300:12a::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.20 via Frontend
 Transport; Tue, 1 Jun 2021 16:44:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT043.mail.protection.outlook.com (10.13.174.193) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4150.30 via Frontend Transport; Tue, 1 Jun 2021 16:44:41 +0000
Received: from amd-Mayan-RMB.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Tue, 1 Jun 2021
 11:44:38 -0500
From: Sathishkumar S <sathishkumar.sundararaju@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amd/pm: sysfs attrs to read ss powershare (v6)
Date: Tue, 1 Jun 2021 22:14:14 +0530
Message-ID: <20210601164414.3915-1-sathishkumar.sundararaju@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b0291405-3be5-475d-98c3-08d9251c8d6b
X-MS-TrafficTypeDiagnostic: CH2PR12MB4183:
X-Microsoft-Antispam-PRVS: <CH2PR12MB41830DFCAB6CC0E9928AC68E9D3E9@CH2PR12MB4183.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: F4PXKiTvmla+iJTwU2SLrAjt1USkBK5Ljo5BsxdVhTOuL6zSt0VOgcxh+R1ozZDqsfayoDJcq7Wt8iYrd4GVvVYXPdmGmY3u06XvsS61DFRUrB+wv12MkeiS57oGDTwDBnIyLY+anct8TQuMlEkDsYGDyRS3ENRJzFYyg+OvLvjT+vfOdOVrHk5q48oQrZHhnoSxi/VZ55bJqpqXnX3ZUGeBd6T4SUdPKhEY7hU+6Q+fHmRRLUZeZ3Ed+Ky2ZIggh3h3E5GKmi30Pg1qiGYChDi6Sm9NjivLUbckgVhqJ1YaUwgJLdGMA5zqejov6y/LDCNKhH+Ld1YgD0KKei4/vlU21WtsPW2Q4toTiplHZJdfzccSaN+vw7zBWHjj0y82Yt1eF6e3efTeWiqX/vdE9YLE5zxO7kiGjpQp/Kq0jnhXeLW7TUGIgkC5DLykbxtRN0BnLSqz0HAgy9Bcjvdt6b1nKMOn0Un3y39uzp3o1Zdnhn9Qwc7uiI6N8oCtkEk/k3vqBdBUy6/dd1wJ21XF9ahVkbBGYzZDwnBwRqUxTMUAbFu5arkHE69De7/y5pEUWxNXs8wXfxF/n+7PN/mK5FCoO/+rM56hJMkFxTmufeCaavhEWl4vQm9okwwdGnTmEoW6WDNq/ZFAN+6cJMqdGeZHePBsy/aPPKVR1FPe4oqZvv/mvr7qWrvQWno7xvr4
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(396003)(39860400002)(136003)(346002)(376002)(46966006)(36840700001)(6666004)(316002)(4326008)(6916009)(2616005)(356005)(16526019)(5660300002)(8676002)(81166007)(70586007)(82740400003)(82310400003)(54906003)(26005)(83380400001)(336012)(186003)(426003)(478600001)(8936002)(70206006)(1076003)(47076005)(7696005)(86362001)(36756003)(2906002)(36860700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2021 16:44:41.0037 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b0291405-3be5-475d-98c3-08d9251c8d6b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT043.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4183
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
Cc: Alexander Deucher <Alexander.Deucher@amd.com>,
 Sathishkumar S <sathishkumar.sundararaju@amd.com>,
 Lijo Lazar <lijo.lazar@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

add sysfs attrs to read smartshift APU and DGPU power share.
document the sysfs device attributes.

V2: change variable/macro name for stapm power limit (Lijo)
V3: files to be exposed as sysfs device attributes (Alex)
V4: check ret value of sysfs create and remove only if created.
V5: add ss attrs in amdgpu_device_attrs and use attr_update (Lijo)
V6: all checks for ss support to be in if else if statements. (Lijo)

Signed-off-by: Sathishkumar S <sathishkumar.sundararaju@amd.com>
Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>
---
 Documentation/gpu/amdgpu.rst                  |  15 +++
 .../gpu/drm/amd/include/kgd_pp_interface.h    |   2 +
 drivers/gpu/drm/amd/pm/amdgpu_pm.c            | 110 ++++++++++++++++++
 drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h       |   2 +
 4 files changed, 129 insertions(+)

diff --git a/Documentation/gpu/amdgpu.rst b/Documentation/gpu/amdgpu.rst
index 2062a6023678..6cce26b5621e 100644
--- a/Documentation/gpu/amdgpu.rst
+++ b/Documentation/gpu/amdgpu.rst
@@ -300,4 +300,19 @@ pcie_replay_count
 .. kernel-doc:: drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
    :doc: pcie_replay_count
 
++GPU SmartShift Information
+============================
+
+GPU SmartShift information via sysfs
 
+smartshift_apu_power
+--------------------
+
+.. kernel-doc:: drivers/gpu/drm/amd/pm/amdgpu_pm.c
+   :doc: smartshift_apu_power
+
+smartshift_dgpu_power
+---------------------
+
+.. kernel-doc:: drivers/gpu/drm/amd/pm/amdgpu_pm.c
+   :doc: smartshift_dgpu_power
diff --git a/drivers/gpu/drm/amd/include/kgd_pp_interface.h b/drivers/gpu/drm/amd/include/kgd_pp_interface.h
index b1cd52a9d684..7bc7492f37b9 100644
--- a/drivers/gpu/drm/amd/include/kgd_pp_interface.h
+++ b/drivers/gpu/drm/amd/include/kgd_pp_interface.h
@@ -124,6 +124,8 @@ enum amd_pp_sensors {
 	AMDGPU_PP_SENSOR_VCE_POWER,
 	AMDGPU_PP_SENSOR_UVD_POWER,
 	AMDGPU_PP_SENSOR_GPU_POWER,
+	AMDGPU_PP_SENSOR_SS_APU_SHARE,
+	AMDGPU_PP_SENSOR_SS_DGPU_SHARE,
 	AMDGPU_PP_SENSOR_STABLE_PSTATE_SCLK,
 	AMDGPU_PP_SENSOR_STABLE_PSTATE_MCLK,
 	AMDGPU_PP_SENSOR_ENABLED_SMC_FEATURES_MASK,
diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
index f48132bc089d..bf9da642622c 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
@@ -1817,6 +1817,112 @@ static ssize_t amdgpu_get_gpu_metrics(struct device *dev,
 	return size;
 }
 
+/**
+ * DOC: smartshift_apu_power
+ *
+ * The amdgpu driver provides a sysfs API for reporting APU power
+ * share if it supports smartshift. The value is expressed as
+ * the proportion of stapm limit where stapm limit is the total APU
+ * power limit. The result is in percentage. If APU power is 130% of
+ * STAPM, then APU is using 30% of the dGPU's headroom.
+ */
+
+static ssize_t amdgpu_get_smartshift_apu_power(struct device *dev, struct device_attribute *attr,
+					       char *buf)
+{
+	struct drm_device *ddev = dev_get_drvdata(dev);
+	struct amdgpu_device *adev = drm_to_adev(ddev);
+	uint32_t ss_power, size;
+	int r = 0;
+
+	if (amdgpu_in_reset(adev))
+		return -EPERM;
+	if (adev->in_suspend && !adev->in_runpm)
+		return -EPERM;
+
+	r = pm_runtime_get_sync(ddev->dev);
+	if (r < 0) {
+		pm_runtime_put_autosuspend(ddev->dev);
+		return r;
+	}
+
+	r = amdgpu_dpm_read_sensor(adev, AMDGPU_PP_SENSOR_SS_APU_SHARE,
+				   (void *)&ss_power, &size);
+	if (r)
+		goto out;
+
+	r = sysfs_emit(buf, "%u%%\n", ss_power);
+
+out:
+	pm_runtime_mark_last_busy(ddev->dev);
+	pm_runtime_put_autosuspend(ddev->dev);
+	return r;
+}
+
+/**
+ * DOC: smartshift_dgpu_power
+ *
+ * The amdgpu driver provides a sysfs API for reporting the dGPU power
+ * share if the device is in HG and supports smartshift. The value
+ * is expressed as the proportion of stapm limit where stapm limit
+ * is the total APU power limit. The value is in percentage. If dGPU
+ * power is 20% higher than STAPM power(120%), it's using 20% of the
+ * APU's power headroom.
+ */
+
+static ssize_t amdgpu_get_smartshift_dgpu_power(struct device *dev, struct device_attribute *attr,
+						char *buf)
+{
+	struct drm_device *ddev = dev_get_drvdata(dev);
+	struct amdgpu_device *adev = drm_to_adev(ddev);
+	uint32_t ss_power, size;
+	int r = 0;
+
+	if (amdgpu_in_reset(adev))
+		return -EPERM;
+	if (adev->in_suspend && !adev->in_runpm)
+		return -EPERM;
+
+	r = pm_runtime_get_sync(ddev->dev);
+	if (r < 0) {
+		pm_runtime_put_autosuspend(ddev->dev);
+		return r;
+	}
+
+	r = amdgpu_dpm_read_sensor(adev, AMDGPU_PP_SENSOR_SS_DGPU_SHARE,
+				   (void *)&ss_power, &size);
+
+	if (r)
+		goto out;
+
+	r = sysfs_emit(buf, "%u%%\n", ss_power);
+
+out:
+	pm_runtime_mark_last_busy(ddev->dev);
+	pm_runtime_put_autosuspend(ddev->dev);
+	return r;
+}
+
+static int ss_power_attr_update(struct amdgpu_device *adev, struct amdgpu_device_attr *attr,
+				uint32_t mask, enum amdgpu_device_attr_states *states)
+{
+	uint32_t ss_power, size;
+
+	if (!amdgpu_acpi_is_power_shift_control_supported())
+		*states = ATTR_STATE_UNSUPPORTED;
+	else if ((adev->flags & AMD_IS_PX) &&
+		 !amdgpu_device_supports_smart_shift(adev_to_drm(adev)))
+		*states = ATTR_STATE_UNSUPPORTED;
+	else if (amdgpu_dpm_read_sensor(adev, AMDGPU_PP_SENSOR_SS_APU_SHARE,
+		 (void *)&ss_power, &size))
+		*states = ATTR_STATE_UNSUPPORTED;
+	else if (amdgpu_dpm_read_sensor(adev, AMDGPU_PP_SENSOR_SS_DGPU_SHARE,
+		 (void *)&ss_power, &size))
+		*states = ATTR_STATE_UNSUPPORTED;
+
+	return 0;
+}
+
 static struct amdgpu_device_attr amdgpu_device_attrs[] = {
 	AMDGPU_DEVICE_ATTR_RW(power_dpm_state,				ATTR_FLAG_BASIC|ATTR_FLAG_ONEVF),
 	AMDGPU_DEVICE_ATTR_RW(power_dpm_force_performance_level,	ATTR_FLAG_BASIC|ATTR_FLAG_ONEVF),
@@ -1843,6 +1949,10 @@ static struct amdgpu_device_attr amdgpu_device_attrs[] = {
 	AMDGPU_DEVICE_ATTR_RO(unique_id,				ATTR_FLAG_BASIC),
 	AMDGPU_DEVICE_ATTR_RW(thermal_throttling_logging,		ATTR_FLAG_BASIC),
 	AMDGPU_DEVICE_ATTR_RO(gpu_metrics,				ATTR_FLAG_BASIC),
+	AMDGPU_DEVICE_ATTR_RO(smartshift_apu_power,			ATTR_FLAG_BASIC,
+			      .attr_update = ss_power_attr_update),
+	AMDGPU_DEVICE_ATTR_RO(smartshift_dgpu_power,			ATTR_FLAG_BASIC,
+			      .attr_update = ss_power_attr_update),
 };
 
 static int default_attr_update(struct amdgpu_device *adev, struct amdgpu_device_attr *attr,
diff --git a/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h b/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
index 523f9d2982e9..71adb9e76a95 100644
--- a/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
+++ b/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
@@ -1218,6 +1218,8 @@ typedef enum {
 	METRICS_CURR_FANSPEED,
 	METRICS_VOLTAGE_VDDSOC,
 	METRICS_VOLTAGE_VDDGFX,
+	METRICS_SS_APU_SHARE,
+	METRICS_SS_DGPU_SHARE,
 } MetricsMember_t;
 
 enum smu_cmn2asic_mapping_type {
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
