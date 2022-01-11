Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5ABEC433EF
	for <amd-gfx@archiver.kernel.org>; Tue, 11 Jan 2022 07:47:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4150912BD6C;
	Tue, 11 Jan 2022 07:47:56 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2056.outbound.protection.outlook.com [40.107.223.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1B74812BD6C
 for <amd-gfx@lists.freedesktop.org>; Tue, 11 Jan 2022 07:47:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AN8wAxaBsQqzUiEczFSgsm0ReE+MszHPIWaFUgpO7gYRx7vCqJNZTDXn/zTGykGdnIA39nuoTbHabykxLVsCD2R7ZJJluFzVazfSwVXrJEIB8Ly9QFNZmaKm2zB7ebOn+VpjYOZSfuW6fy3OMO6xBB+NVx7y/8xOibtkn0eQmBwTvaHAqJvKdQ5OPVTuPXIimkD2PwqczyZytadkpnQag4mgI0vjXHRXgqMtNQZsdtqjfzw2v9vbAkxpyJWKT9tvEwnLWPtVMG0Ur/cSO9FknqBJLHLHfV5xE4x20jJpCAgAtlcjR7Uiz5y9SGprOtIqjCRWl2G7a49+hX5Tzk0Bng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3nSfZa5vWvrPlyF8ZK/VwMmwCrLs/ngwFMpRbcF4FQ0=;
 b=g0+98y0Z0tAs87T7T+5fpJNsVontClKNKmHHmCpQnmNI2Bi6uR1crE8ratlW2DiUcjD6vDP0IOZENYTUeo5V6Mg4rh2p9+eQTTxCf0OWIBE44S8SCPrM6uOknD/3grTII9J/7uMYycWhvPM+X+u5pS0pv7Sf/89nDsUnum7qKQch1S8SRtgrkHE5frxWOCYKq9k3C2KxSOKPARqP24Itwmz3MZMS40DsEqL93T8pbl9hk603KrgF3U4j+RQuAycGIvjiFnoauSlitJoLLQ5+Xn1SyUHelXiv7lYcpt0M1HG5ZGTBYqdXQ8wRfZsMwofhbLerCYD4kjZnSnZT5r9mcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3nSfZa5vWvrPlyF8ZK/VwMmwCrLs/ngwFMpRbcF4FQ0=;
 b=vR/X/IlbzGWiRMP61ccidMaRUObqA81oAakCo9TCTYr1Ks+myWQGpFjegY2KaFWlXDjtxrW06igeWebl99EZIDWk+DFPF/89XXGXQ40DUreOWVDT6/WzJOhl0Ei0DlBPBuOZxMDuyohpvbHBH9JEvgklSRUYxehkaA4APveGIus=
Received: from DM5PR07CA0112.namprd07.prod.outlook.com (2603:10b6:4:ae::41) by
 BY5PR12MB4936.namprd12.prod.outlook.com (2603:10b6:a03:1d4::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.9; Tue, 11 Jan
 2022 07:47:52 +0000
Received: from DM6NAM11FT064.eop-nam11.prod.protection.outlook.com
 (2603:10b6:4:ae:cafe::7) by DM5PR07CA0112.outlook.office365.com
 (2603:10b6:4:ae::41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.11 via Frontend
 Transport; Tue, 11 Jan 2022 07:47:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT064.mail.protection.outlook.com (10.13.172.234) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4867.7 via Frontend Transport; Tue, 11 Jan 2022 07:47:51 +0000
Received: from equan-buildpc.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Tue, 11 Jan
 2022 01:47:49 -0600
From: Evan Quan <evan.quan@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amd/pm: correct the checks for fan attributes support
Date: Tue, 11 Jan 2022 15:47:29 +0800
Message-ID: <20220111074729.40906-1-evan.quan@amd.com>
X-Mailer: git-send-email 2.29.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1667bc59-a8d0-4867-13e6-08d9d4d6abc3
X-MS-TrafficTypeDiagnostic: BY5PR12MB4936:EE_
X-Microsoft-Antispam-PRVS: <BY5PR12MB49364BF431A6F8D8446AB5BAE4519@BY5PR12MB4936.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2733;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /ZNL235FiWC+AHA7R7lzZlYyD5/CGqW68mlrtNsB+4P5SpLzh0GaEzk2hcthInSGBLMXl/h2LxKuOmB1h/9Y1dGVadSd3ptwAdU+Nq7mEntuwMejz/iYS6YOiG0DHHEjAbqyqL3yO5Ejb6hsw5M14eHLRiPgzZpcJlYDHw5qRiAjXIfkVr9wtPmuFYjJKM99Jx7FMYNCS1a6uEbkMabKyxykDTHXeT9+Us0F5GrwH7+tN/b4wV/BCt81Dd1K3PQ65cUwvxYTzC6ZnJjKUirdq+laHE8/llBsSUsGaoP/LIJxPJbv6GPLpHo3LB8IC1UUC1/bW22lAHpgO0YHE2RR31W8bR8sSojF9s8+xH/rhX4r36u3FWoqN3VQKsrGGy2yjimprQxigc6HgOGEnMrT6e330PSOunOECUVoV540bRdniQ2AnyN3NHlT4xpp9aukoO/DL2+Jz68G/99WzUFmxJTc/SPVyhb/UgmV/qBBZa3HiJ9Smdp59Jdml4hDwi7nPpa/4HTNju9mzNx5eSbT4z60i7cTgqIVnHlXHHldVSns0hULzhIMn29mFVEDwMSKhGmdDnKyGfd8O5GYb2RTia7eGyjaj3A9y1yFxSRdcvY666FqDQFXm5C+EEs1CqkzvLI6jHrODZgLWAXdCP7oa3cIRgZEAHGeRc/XRgTg/CNE2tIGb9KCt5x69sEms/Ce71j1LBkwlab2LreCOdQFleljbekEM12mGZWCLGaTrkfJKXSK9WqcHp2R3p87m6pnLd3ezAZ1uEiZ8IzcEfke2S18ea70MPmyKZ6JTi6CETs=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(40470700002)(36840700001)(70586007)(508600001)(36756003)(16526019)(86362001)(83380400001)(36860700001)(2906002)(186003)(44832011)(426003)(1076003)(30864003)(70206006)(54906003)(26005)(5660300002)(316002)(81166007)(8676002)(7696005)(6916009)(82310400004)(4326008)(6666004)(40460700001)(336012)(47076005)(8936002)(2616005)(356005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jan 2022 07:47:51.8633 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1667bc59-a8d0-4867-13e6-08d9d4d6abc3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT064.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4936
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
Cc: Alexander.Deucher@amd.com, Lijo.Lazar@amd.com,
 Evan Quan <evan.quan@amd.com>, Guchun.Chen@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On functionality unsupported, -EOPNOTSUPP will be returned. And we rely
on that to determine the fan attributes support.

Fixes: 801771de0331 ("drm/amd/pm: do not expose power implementation details to
amdgpu_pm.c")

Signed-off-by: Evan Quan <evan.quan@amd.com>
Change-Id: I95e7e0beebd678a446221a72234cd356e14f0fcd
---
 .../gpu/drm/amd/include/kgd_pp_interface.h    |   4 +-
 drivers/gpu/drm/amd/pm/amdgpu_dpm.c           |  31 ++++-
 drivers/gpu/drm/amd/pm/amdgpu_pm.c            |  21 ++--
 drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c    |  10 +-
 .../gpu/drm/amd/pm/powerplay/amd_powerplay.c  |  59 ++++-----
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c     | 115 +++++++++---------
 6 files changed, 132 insertions(+), 108 deletions(-)

diff --git a/drivers/gpu/drm/amd/include/kgd_pp_interface.h b/drivers/gpu/drm/amd/include/kgd_pp_interface.h
index a8eec91c0995..387120099493 100644
--- a/drivers/gpu/drm/amd/include/kgd_pp_interface.h
+++ b/drivers/gpu/drm/amd/include/kgd_pp_interface.h
@@ -315,8 +315,8 @@ struct amd_pm_funcs {
 				void  *rps,
 				bool  *equal);
 /* export for sysfs */
-	void (*set_fan_control_mode)(void *handle, u32 mode);
-	u32 (*get_fan_control_mode)(void *handle);
+	int (*set_fan_control_mode)(void *handle, u32 mode);
+	int (*get_fan_control_mode)(void *handle, u32 *fan_mode);
 	int (*set_fan_speed_pwm)(void *handle, u32 speed);
 	int (*get_fan_speed_pwm)(void *handle, u32 *speed);
 	int (*force_clock_level)(void *handle, enum pp_clock_type type, uint32_t mask);
diff --git a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
index 68d2e80a673b..fe69785df403 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
@@ -1030,15 +1030,20 @@ int amdgpu_dpm_get_fan_control_mode(struct amdgpu_device *adev,
 				    uint32_t *fan_mode)
 {
 	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
+	int ret = 0;
 
 	if (!pp_funcs->get_fan_control_mode)
 		return -EOPNOTSUPP;
 
+	if (!fan_mode)
+		return -EINVAL;
+
 	mutex_lock(&adev->pm.mutex);
-	*fan_mode = pp_funcs->get_fan_control_mode(adev->powerplay.pp_handle);
+	ret = pp_funcs->get_fan_control_mode(adev->powerplay.pp_handle,
+					     fan_mode);
 	mutex_unlock(&adev->pm.mutex);
 
-	return 0;
+	return ret;
 }
 
 int amdgpu_dpm_set_fan_speed_pwm(struct amdgpu_device *adev,
@@ -1048,6 +1053,9 @@ int amdgpu_dpm_set_fan_speed_pwm(struct amdgpu_device *adev,
 	int ret = 0;
 
 	if (!pp_funcs->set_fan_speed_pwm)
+		return -EOPNOTSUPP;
+
+	if (speed == U32_MAX)
 		return -EINVAL;
 
 	mutex_lock(&adev->pm.mutex);
@@ -1065,6 +1073,9 @@ int amdgpu_dpm_get_fan_speed_pwm(struct amdgpu_device *adev,
 	int ret = 0;
 
 	if (!pp_funcs->get_fan_speed_pwm)
+		return -EOPNOTSUPP;
+
+	if (!speed)
 		return -EINVAL;
 
 	mutex_lock(&adev->pm.mutex);
@@ -1082,6 +1093,9 @@ int amdgpu_dpm_get_fan_speed_rpm(struct amdgpu_device *adev,
 	int ret = 0;
 
 	if (!pp_funcs->get_fan_speed_rpm)
+		return -EOPNOTSUPP;
+
+	if (!speed)
 		return -EINVAL;
 
 	mutex_lock(&adev->pm.mutex);
@@ -1099,6 +1113,9 @@ int amdgpu_dpm_set_fan_speed_rpm(struct amdgpu_device *adev,
 	int ret = 0;
 
 	if (!pp_funcs->set_fan_speed_rpm)
+		return -EOPNOTSUPP;
+
+	if (speed == U32_MAX)
 		return -EINVAL;
 
 	mutex_lock(&adev->pm.mutex);
@@ -1113,16 +1130,20 @@ int amdgpu_dpm_set_fan_control_mode(struct amdgpu_device *adev,
 				    uint32_t mode)
 {
 	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
+	int ret = 0;
 
 	if (!pp_funcs->set_fan_control_mode)
 		return -EOPNOTSUPP;
 
+	if (mode == U32_MAX)
+		return -EINVAL;
+
 	mutex_lock(&adev->pm.mutex);
-	pp_funcs->set_fan_control_mode(adev->powerplay.pp_handle,
-				       mode);
+	ret = pp_funcs->set_fan_control_mode(adev->powerplay.pp_handle,
+					     mode);
 	mutex_unlock(&adev->pm.mutex);
 
-	return 0;
+	return ret;
 }
 
 int amdgpu_dpm_get_power_limit(struct amdgpu_device *adev,
diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
index d3eab245e0fe..940cbe751163 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
@@ -3197,7 +3197,6 @@ static umode_t hwmon_attributes_visible(struct kobject *kobj,
 	struct device *dev = kobj_to_dev(kobj);
 	struct amdgpu_device *adev = dev_get_drvdata(dev);
 	umode_t effective_mode = attr->mode;
-	uint32_t speed = 0;
 
 	/* under multi-vf mode, the hwmon attributes are all not supported */
 	if (amdgpu_sriov_vf(adev) && !amdgpu_sriov_is_pp_one_vf(adev))
@@ -3263,15 +3262,15 @@ static umode_t hwmon_attributes_visible(struct kobject *kobj,
 		return 0;
 
 	/* mask fan attributes if we have no bindings for this asic to expose */
-	if (((amdgpu_dpm_get_fan_speed_pwm(adev, &speed) == -EINVAL) &&
+	if (((amdgpu_dpm_get_fan_speed_pwm(adev, NULL) == -EOPNOTSUPP) &&
 	      attr == &sensor_dev_attr_pwm1.dev_attr.attr) || /* can't query fan */
-	    ((amdgpu_dpm_get_fan_control_mode(adev, &speed) == -EOPNOTSUPP) &&
+	    ((amdgpu_dpm_get_fan_control_mode(adev, NULL) == -EOPNOTSUPP) &&
 	     attr == &sensor_dev_attr_pwm1_enable.dev_attr.attr)) /* can't query state */
 		effective_mode &= ~S_IRUGO;
 
-	if (((amdgpu_dpm_set_fan_speed_pwm(adev, speed) == -EINVAL) &&
+	if (((amdgpu_dpm_set_fan_speed_pwm(adev, U32_MAX) == -EOPNOTSUPP) &&
 	      attr == &sensor_dev_attr_pwm1.dev_attr.attr) || /* can't manage fan */
-	      ((amdgpu_dpm_set_fan_control_mode(adev, speed) == -EOPNOTSUPP) &&
+	      ((amdgpu_dpm_set_fan_control_mode(adev, U32_MAX) == -EOPNOTSUPP) &&
 	      attr == &sensor_dev_attr_pwm1_enable.dev_attr.attr)) /* can't manage state */
 		effective_mode &= ~S_IWUSR;
 
@@ -3291,16 +3290,16 @@ static umode_t hwmon_attributes_visible(struct kobject *kobj,
 		return 0;
 
 	/* hide max/min values if we can't both query and manage the fan */
-	if (((amdgpu_dpm_set_fan_speed_pwm(adev, speed) == -EINVAL) &&
-	      (amdgpu_dpm_get_fan_speed_pwm(adev, &speed) == -EINVAL) &&
-	      (amdgpu_dpm_set_fan_speed_rpm(adev, speed) == -EINVAL) &&
-	      (amdgpu_dpm_get_fan_speed_rpm(adev, &speed) == -EINVAL)) &&
+	if (((amdgpu_dpm_set_fan_speed_pwm(adev, U32_MAX) == -EOPNOTSUPP) &&
+	      (amdgpu_dpm_get_fan_speed_pwm(adev, NULL) == -EOPNOTSUPP) &&
+	      (amdgpu_dpm_set_fan_speed_rpm(adev, U32_MAX) == -EOPNOTSUPP) &&
+	      (amdgpu_dpm_get_fan_speed_rpm(adev, NULL) == -EOPNOTSUPP)) &&
 	    (attr == &sensor_dev_attr_pwm1_max.dev_attr.attr ||
 	     attr == &sensor_dev_attr_pwm1_min.dev_attr.attr))
 		return 0;
 
-	if ((amdgpu_dpm_set_fan_speed_rpm(adev, speed) == -EINVAL) &&
-	     (amdgpu_dpm_get_fan_speed_rpm(adev, &speed) == -EINVAL) &&
+	if ((amdgpu_dpm_set_fan_speed_rpm(adev, U32_MAX) == -EOPNOTSUPP) &&
+	     (amdgpu_dpm_get_fan_speed_rpm(adev, NULL) == -EOPNOTSUPP) &&
 	     (attr == &sensor_dev_attr_fan1_max.dev_attr.attr ||
 	     attr == &sensor_dev_attr_fan1_min.dev_attr.attr))
 		return 0;
diff --git a/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c b/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c
index 92b987fb31d4..7677d3a21f8c 100644
--- a/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c
+++ b/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c
@@ -6669,7 +6669,7 @@ static int si_dpm_set_fan_speed_pwm(void *handle,
 	return 0;
 }
 
-static void si_dpm_set_fan_control_mode(void *handle, u32 mode)
+static int si_dpm_set_fan_control_mode(void *handle, u32 mode)
 {
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
 
@@ -6685,9 +6685,11 @@ static void si_dpm_set_fan_control_mode(void *handle, u32 mode)
 		else
 			si_fan_ctrl_set_default_mode(adev);
 	}
+
+	return 0;
 }
 
-static u32 si_dpm_get_fan_control_mode(void *handle)
+static int si_dpm_get_fan_control_mode(void *handle, u32 *fan_mode)
 {
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
 	struct si_power_info *si_pi = si_get_pi(adev);
@@ -6697,7 +6699,9 @@ static u32 si_dpm_get_fan_control_mode(void *handle)
 		return 0;
 
 	tmp = RREG32(CG_FDO_CTRL2) & FDO_PWM_MODE_MASK;
-	return (tmp >> FDO_PWM_MODE_SHIFT);
+	*fan_mode = (tmp >> FDO_PWM_MODE_SHIFT);
+
+	return 0;
 }
 
 #if 0
diff --git a/drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c b/drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c
index 89341729744d..57bc9405d6a9 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c
@@ -488,38 +488,37 @@ static enum amd_pm_state_type pp_dpm_get_current_power_state(void *handle)
 	return pm_type;
 }
 
-static void pp_dpm_set_fan_control_mode(void *handle, uint32_t mode)
+static int pp_dpm_set_fan_control_mode(void *handle, uint32_t mode)
 {
 	struct pp_hwmgr *hwmgr = handle;
 
 	if (!hwmgr || !hwmgr->pm_en)
-		return;
+		return -EOPNOTSUPP;
+
+	if (hwmgr->hwmgr_func->set_fan_control_mode == NULL)
+		return -EOPNOTSUPP;
 
-	if (hwmgr->hwmgr_func->set_fan_control_mode == NULL) {
-		pr_info_ratelimited("%s was not implemented.\n", __func__);
-		return;
-	}
 	mutex_lock(&hwmgr->smu_lock);
 	hwmgr->hwmgr_func->set_fan_control_mode(hwmgr, mode);
 	mutex_unlock(&hwmgr->smu_lock);
+
+	return 0;
 }
 
-static uint32_t pp_dpm_get_fan_control_mode(void *handle)
+static int pp_dpm_get_fan_control_mode(void *handle, uint32_t *fan_mode)
 {
 	struct pp_hwmgr *hwmgr = handle;
-	uint32_t mode = 0;
 
 	if (!hwmgr || !hwmgr->pm_en)
-		return 0;
+		return -EOPNOTSUPP;
+
+	if (hwmgr->hwmgr_func->get_fan_control_mode == NULL)
+		return -EOPNOTSUPP;
 
-	if (hwmgr->hwmgr_func->get_fan_control_mode == NULL) {
-		pr_info_ratelimited("%s was not implemented.\n", __func__);
-		return 0;
-	}
 	mutex_lock(&hwmgr->smu_lock);
-	mode = hwmgr->hwmgr_func->get_fan_control_mode(hwmgr);
+	*fan_mode = hwmgr->hwmgr_func->get_fan_control_mode(hwmgr);
 	mutex_unlock(&hwmgr->smu_lock);
-	return mode;
+	return 0;
 }
 
 static int pp_dpm_set_fan_speed_pwm(void *handle, uint32_t speed)
@@ -528,12 +527,11 @@ static int pp_dpm_set_fan_speed_pwm(void *handle, uint32_t speed)
 	int ret = 0;
 
 	if (!hwmgr || !hwmgr->pm_en)
-		return -EINVAL;
+		return -EOPNOTSUPP;
+
+	if (hwmgr->hwmgr_func->set_fan_speed_pwm == NULL)
+		return -EOPNOTSUPP;
 
-	if (hwmgr->hwmgr_func->set_fan_speed_pwm == NULL) {
-		pr_info_ratelimited("%s was not implemented.\n", __func__);
-		return 0;
-	}
 	mutex_lock(&hwmgr->smu_lock);
 	ret = hwmgr->hwmgr_func->set_fan_speed_pwm(hwmgr, speed);
 	mutex_unlock(&hwmgr->smu_lock);
@@ -546,12 +544,10 @@ static int pp_dpm_get_fan_speed_pwm(void *handle, uint32_t *speed)
 	int ret = 0;
 
 	if (!hwmgr || !hwmgr->pm_en)
-		return -EINVAL;
+		return -EOPNOTSUPP;
 
-	if (hwmgr->hwmgr_func->get_fan_speed_pwm == NULL) {
-		pr_info_ratelimited("%s was not implemented.\n", __func__);
-		return 0;
-	}
+	if (hwmgr->hwmgr_func->get_fan_speed_pwm == NULL)
+		return -EOPNOTSUPP;
 
 	mutex_lock(&hwmgr->smu_lock);
 	ret = hwmgr->hwmgr_func->get_fan_speed_pwm(hwmgr, speed);
@@ -565,10 +561,10 @@ static int pp_dpm_get_fan_speed_rpm(void *handle, uint32_t *rpm)
 	int ret = 0;
 
 	if (!hwmgr || !hwmgr->pm_en)
-		return -EINVAL;
+		return -EOPNOTSUPP;
 
 	if (hwmgr->hwmgr_func->get_fan_speed_rpm == NULL)
-		return -EINVAL;
+		return -EOPNOTSUPP;
 
 	mutex_lock(&hwmgr->smu_lock);
 	ret = hwmgr->hwmgr_func->get_fan_speed_rpm(hwmgr, rpm);
@@ -582,12 +578,11 @@ static int pp_dpm_set_fan_speed_rpm(void *handle, uint32_t rpm)
 	int ret = 0;
 
 	if (!hwmgr || !hwmgr->pm_en)
-		return -EINVAL;
+		return -EOPNOTSUPP;
+
+	if (hwmgr->hwmgr_func->set_fan_speed_rpm == NULL)
+		return -EOPNOTSUPP;
 
-	if (hwmgr->hwmgr_func->set_fan_speed_rpm == NULL) {
-		pr_info_ratelimited("%s was not implemented.\n", __func__);
-		return 0;
-	}
 	mutex_lock(&hwmgr->smu_lock);
 	ret = hwmgr->hwmgr_func->set_fan_speed_rpm(hwmgr, rpm);
 	mutex_unlock(&hwmgr->smu_lock);
diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
index c374c3067496..474f1f04cc96 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -59,7 +59,7 @@ static int smu_handle_task(struct smu_context *smu,
 			   bool lock_needed);
 static int smu_reset(struct smu_context *smu);
 static int smu_set_fan_speed_pwm(void *handle, u32 speed);
-static int smu_set_fan_control_mode(struct smu_context *smu, int value);
+static int smu_set_fan_control_mode(void *handle, u32 value);
 static int smu_set_power_limit(void *handle, uint32_t limit);
 static int smu_set_fan_speed_rpm(void *handle, uint32_t speed);
 static int smu_set_gfx_cgpg(struct smu_context *smu, bool enabled);
@@ -407,7 +407,7 @@ static void smu_restore_dpm_user_profile(struct smu_context *smu)
 	if (smu->user_dpm_profile.fan_mode == AMD_FAN_CTRL_MANUAL ||
 	    smu->user_dpm_profile.fan_mode == AMD_FAN_CTRL_NONE) {
 		ret = smu_set_fan_control_mode(smu, smu->user_dpm_profile.fan_mode);
-		if (ret) {
+		if (ret != -EOPNOTSUPP) {
 			smu->user_dpm_profile.fan_speed_pwm = 0;
 			smu->user_dpm_profile.fan_speed_rpm = 0;
 			smu->user_dpm_profile.fan_mode = AMD_FAN_CTRL_AUTO;
@@ -416,13 +416,13 @@ static void smu_restore_dpm_user_profile(struct smu_context *smu)
 
 		if (smu->user_dpm_profile.fan_speed_pwm) {
 			ret = smu_set_fan_speed_pwm(smu, smu->user_dpm_profile.fan_speed_pwm);
-			if (ret)
+			if (ret != -EOPNOTSUPP)
 				dev_err(smu->adev->dev, "Failed to set manual fan speed in pwm\n");
 		}
 
 		if (smu->user_dpm_profile.fan_speed_rpm) {
 			ret = smu_set_fan_speed_rpm(smu, smu->user_dpm_profile.fan_speed_rpm);
-			if (ret)
+			if (ret != -EOPNOTSUPP)
 				dev_err(smu->adev->dev, "Failed to set manual fan speed in rpm\n");
 		}
 	}
@@ -2218,18 +2218,19 @@ static int smu_set_fan_speed_rpm(void *handle, uint32_t speed)
 	if (!smu->pm_enabled || !smu->adev->pm.dpm_enabled)
 		return -EOPNOTSUPP;
 
+	if (!smu->ppt_funcs->set_fan_speed_rpm)
+		return -EOPNOTSUPP;
+
 	mutex_lock(&smu->mutex);
 
-	if (smu->ppt_funcs->set_fan_speed_rpm) {
-		ret = smu->ppt_funcs->set_fan_speed_rpm(smu, speed);
-		if (!ret && !(smu->user_dpm_profile.flags & SMU_DPM_USER_PROFILE_RESTORE)) {
-			smu->user_dpm_profile.flags |= SMU_CUSTOM_FAN_SPEED_RPM;
-			smu->user_dpm_profile.fan_speed_rpm = speed;
+	ret = smu->ppt_funcs->set_fan_speed_rpm(smu, speed);
+	if (!ret && !(smu->user_dpm_profile.flags & SMU_DPM_USER_PROFILE_RESTORE)) {
+		smu->user_dpm_profile.flags |= SMU_CUSTOM_FAN_SPEED_RPM;
+		smu->user_dpm_profile.fan_speed_rpm = speed;
 
-			/* Override custom PWM setting as they cannot co-exist */
-			smu->user_dpm_profile.flags &= ~SMU_CUSTOM_FAN_SPEED_PWM;
-			smu->user_dpm_profile.fan_speed_pwm = 0;
-		}
+		/* Override custom PWM setting as they cannot co-exist */
+		smu->user_dpm_profile.flags &= ~SMU_CUSTOM_FAN_SPEED_PWM;
+		smu->user_dpm_profile.fan_speed_pwm = 0;
 	}
 
 	mutex_unlock(&smu->mutex);
@@ -2562,60 +2563,59 @@ static int smu_set_power_profile_mode(void *handle,
 }
 
 
-static u32 smu_get_fan_control_mode(void *handle)
+static int smu_get_fan_control_mode(void *handle, u32 *fan_mode)
 {
 	struct smu_context *smu = handle;
-	u32 ret = 0;
 
 	if (!smu->pm_enabled || !smu->adev->pm.dpm_enabled)
-		return AMD_FAN_CTRL_NONE;
+		return -EOPNOTSUPP;
+
+	if (!smu->ppt_funcs->get_fan_control_mode)
+		return -EOPNOTSUPP;
 
 	mutex_lock(&smu->mutex);
 
-	if (smu->ppt_funcs->get_fan_control_mode)
-		ret = smu->ppt_funcs->get_fan_control_mode(smu);
+	*fan_mode = smu->ppt_funcs->get_fan_control_mode(smu);
 
 	mutex_unlock(&smu->mutex);
 
-	return ret;
+	return 0;
 }
 
-static int smu_set_fan_control_mode(struct smu_context *smu, int value)
+static int smu_set_fan_control_mode(void *handle, u32 value)
 {
+	struct smu_context *smu = handle;
 	int ret = 0;
 
 	if (!smu->pm_enabled || !smu->adev->pm.dpm_enabled)
-		return  -EOPNOTSUPP;
+		return -EOPNOTSUPP;
+
+	if (!smu->ppt_funcs->set_fan_control_mode)
+		return -EOPNOTSUPP;
 
 	mutex_lock(&smu->mutex);
 
-	if (smu->ppt_funcs->set_fan_control_mode) {
-		ret = smu->ppt_funcs->set_fan_control_mode(smu, value);
-		if (!ret && !(smu->user_dpm_profile.flags & SMU_DPM_USER_PROFILE_RESTORE))
-			smu->user_dpm_profile.fan_mode = value;
-	}
+	ret = smu->ppt_funcs->set_fan_control_mode(smu, value);
+	if (ret)
+		goto out;
 
-	mutex_unlock(&smu->mutex);
+	if (!(smu->user_dpm_profile.flags & SMU_DPM_USER_PROFILE_RESTORE)) {
+		smu->user_dpm_profile.fan_mode = value;
 
-	/* reset user dpm fan speed */
-	if (!ret && value != AMD_FAN_CTRL_MANUAL &&
-			!(smu->user_dpm_profile.flags & SMU_DPM_USER_PROFILE_RESTORE)) {
-		smu->user_dpm_profile.fan_speed_pwm = 0;
-		smu->user_dpm_profile.fan_speed_rpm = 0;
-		smu->user_dpm_profile.flags &= ~(SMU_CUSTOM_FAN_SPEED_RPM | SMU_CUSTOM_FAN_SPEED_PWM);
+		/* reset user dpm fan speed */
+		if (value != AMD_FAN_CTRL_MANUAL) {
+			smu->user_dpm_profile.fan_speed_pwm = 0;
+			smu->user_dpm_profile.fan_speed_rpm = 0;
+			smu->user_dpm_profile.flags &= ~(SMU_CUSTOM_FAN_SPEED_RPM | SMU_CUSTOM_FAN_SPEED_PWM);
+		}
 	}
 
-	return ret;
-}
-
-static void smu_pp_set_fan_control_mode(void *handle, u32 value)
-{
-	struct smu_context *smu = handle;
+out:
+	mutex_unlock(&smu->mutex);
 
-	smu_set_fan_control_mode(smu, value);
+	return ret;
 }
 
-
 static int smu_get_fan_speed_pwm(void *handle, u32 *speed)
 {
 	struct smu_context *smu = handle;
@@ -2624,10 +2624,12 @@ static int smu_get_fan_speed_pwm(void *handle, u32 *speed)
 	if (!smu->pm_enabled || !smu->adev->pm.dpm_enabled)
 		return -EOPNOTSUPP;
 
+	if (!smu->ppt_funcs->get_fan_speed_pwm)
+		return -EOPNOTSUPP;
+
 	mutex_lock(&smu->mutex);
 
-	if (smu->ppt_funcs->get_fan_speed_pwm)
-		ret = smu->ppt_funcs->get_fan_speed_pwm(smu, speed);
+	ret = smu->ppt_funcs->get_fan_speed_pwm(smu, speed);
 
 	mutex_unlock(&smu->mutex);
 
@@ -2642,18 +2644,19 @@ static int smu_set_fan_speed_pwm(void *handle, u32 speed)
 	if (!smu->pm_enabled || !smu->adev->pm.dpm_enabled)
 		return -EOPNOTSUPP;
 
+	if (!smu->ppt_funcs->set_fan_speed_pwm)
+		return -EOPNOTSUPP;
+
 	mutex_lock(&smu->mutex);
 
-	if (smu->ppt_funcs->set_fan_speed_pwm) {
-		ret = smu->ppt_funcs->set_fan_speed_pwm(smu, speed);
-		if (!ret && !(smu->user_dpm_profile.flags & SMU_DPM_USER_PROFILE_RESTORE)) {
-			smu->user_dpm_profile.flags |= SMU_CUSTOM_FAN_SPEED_PWM;
-			smu->user_dpm_profile.fan_speed_pwm = speed;
+	ret = smu->ppt_funcs->set_fan_speed_pwm(smu, speed);
+	if (!ret && !(smu->user_dpm_profile.flags & SMU_DPM_USER_PROFILE_RESTORE)) {
+		smu->user_dpm_profile.flags |= SMU_CUSTOM_FAN_SPEED_PWM;
+		smu->user_dpm_profile.fan_speed_pwm = speed;
 
-			/* Override custom RPM setting as they cannot co-exist */
-			smu->user_dpm_profile.flags &= ~SMU_CUSTOM_FAN_SPEED_RPM;
-			smu->user_dpm_profile.fan_speed_rpm = 0;
-		}
+		/* Override custom RPM setting as they cannot co-exist */
+		smu->user_dpm_profile.flags &= ~SMU_CUSTOM_FAN_SPEED_RPM;
+		smu->user_dpm_profile.fan_speed_rpm = 0;
 	}
 
 	mutex_unlock(&smu->mutex);
@@ -2669,10 +2672,12 @@ static int smu_get_fan_speed_rpm(void *handle, uint32_t *speed)
 	if (!smu->pm_enabled || !smu->adev->pm.dpm_enabled)
 		return -EOPNOTSUPP;
 
+	if (!smu->ppt_funcs->get_fan_speed_rpm)
+		return -EOPNOTSUPP;
+
 	mutex_lock(&smu->mutex);
 
-	if (smu->ppt_funcs->get_fan_speed_rpm)
-		ret = smu->ppt_funcs->get_fan_speed_rpm(smu, speed);
+	ret = smu->ppt_funcs->get_fan_speed_rpm(smu, speed);
 
 	mutex_unlock(&smu->mutex);
 
@@ -3101,7 +3106,7 @@ static int smu_get_prv_buffer_details(void *handle, void **addr, size_t *size)
 
 static const struct amd_pm_funcs swsmu_pm_funcs = {
 	/* export for sysfs */
-	.set_fan_control_mode    = smu_pp_set_fan_control_mode,
+	.set_fan_control_mode    = smu_set_fan_control_mode,
 	.get_fan_control_mode    = smu_get_fan_control_mode,
 	.set_fan_speed_pwm   = smu_set_fan_speed_pwm,
 	.get_fan_speed_pwm   = smu_get_fan_speed_pwm,
-- 
2.29.0

