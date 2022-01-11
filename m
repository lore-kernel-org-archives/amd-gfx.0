Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02D10C433EF
	for <amd-gfx@archiver.kernel.org>; Tue, 11 Jan 2022 12:41:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5878A10E306;
	Tue, 11 Jan 2022 12:41:34 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2080.outbound.protection.outlook.com [40.107.243.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BA4A710E306
 for <amd-gfx@lists.freedesktop.org>; Tue, 11 Jan 2022 12:41:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VnssV6de3N4HiuE91O/TX1bZwM8lfcTGl4XsjVlZrFv14XLAFHWnHAj1IsWQZ88ga2mYnzH8/9PMil06S8s+y+411nnHu+B7MVJaBUtxmyVPLkCV4ttDLWz1tN7XmZvQd42toN2+mLOsvAIO179Rc4nmgtoxEi/VpChc3T6q2VVshWQ30B4/dlM0IqHzczzVRHjUGKHG6ad7gIDQr2+AM97to1OTegRNYdtddoNHuvpvR65qLW7HSoIoL4FNYg7Eie+yAj4zK2nQzElHZRqh3ZHGOYlhbeFDGXcgvLJoIl0f/XY0lbKN7twarrUp2z0nDWp1sGv62gOlS8Id8KrEJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Zwjw6AgJvl44lrAgL9nC/G4Ti3Z0UNFf1RicB3JOVt0=;
 b=IfrV/sjX909O4JeiYbYX2RaQYi9+td+xWACmPPG3SlSvEFTij4TLSYbS5y5wO+r0F9SliYPEKzlkVm1tub73ni+WB1LUOuYkRIvTNj7y9aQDn3IYW/+j6YvLHRqQdeGCjrgSHbUYcgfucwGNltw6DGW/XqV3hE+HqezEHn5xm9PnLXGy9whrU8/cHX/fnv7hCzwB6CBlYPvkjULAAz8yFQVvruO03n18czlyLvvk7Dhr+rI0Gv7QeSJREce7j88kopWKtUQCFLKOV+1UVqJw3SBFrvdKOxydM8OHBJkILUaXkQaumCOekV6CBhsynPHd50A/DkcdQurqFCseHlbm7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zwjw6AgJvl44lrAgL9nC/G4Ti3Z0UNFf1RicB3JOVt0=;
 b=056HxNecyw4BQ+MekLtzIPczo3+XtjPLRKCy5yNjR28edK7P8Zy2aJeiPLi4VFdEx/Sl+/t+mbCcRa9JfGQDRD8sfuBz6VpUK0jkxjkNK8uT+B53DD6yeFOVfprwjOgVSoqEkYfw01x9UQFkOlMVTe+MEqWcU1C3t2U4xTwZdfM=
Received: from CO2PR07CA0078.namprd07.prod.outlook.com (2603:10b6:100::46) by
 CY4PR1201MB0040.namprd12.prod.outlook.com (2603:10b6:910:1b::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.9; Tue, 11 Jan
 2022 12:41:30 +0000
Received: from CO1NAM11FT024.eop-nam11.prod.protection.outlook.com
 (2603:10b6:100:0:cafe::e6) by CO2PR07CA0078.outlook.office365.com
 (2603:10b6:100::46) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.7 via Frontend
 Transport; Tue, 11 Jan 2022 12:41:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT024.mail.protection.outlook.com (10.13.174.162) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4867.7 via Frontend Transport; Tue, 11 Jan 2022 12:41:29 +0000
Received: from equan-buildpc.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Tue, 11 Jan
 2022 06:41:27 -0600
From: Evan Quan <evan.quan@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amd/pm: correct the checks for fan attributes support
Date: Tue, 11 Jan 2022 20:41:12 +0800
Message-ID: <20220111124112.52884-1-evan.quan@amd.com>
X-Mailer: git-send-email 2.29.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b01c04a7-0e31-4146-2a30-08d9d4ffb0e4
X-MS-TrafficTypeDiagnostic: CY4PR1201MB0040:EE_
X-Microsoft-Antispam-PRVS: <CY4PR1201MB00400563AEFB7820EDEA1B3AE4519@CY4PR1201MB0040.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9U1jvLrS57T0/ULZHJyjzHYEJ6sMRct3xMZRrny+kmZHyp6AxTrXxM9IF9KHdlxbw7tesOlwFxyeEBBjD/ohYdmMtvr2OmtebSRiLoQPR25LKMcQdRd4C4TpRe82dO4/HvppZWf2fp+Mbr1wUu3OQG9aVLULahRQSAW5/ieFtOUOAsCmqvI08EgXGWM1vjQMo7Xy6IsED0+PGq6DA4UT5n1v1McnlzptSRS48oew/iG4G5dPNET1Y+1Oai6n8qgA6CCECf9VGECFQGv/oyphqhJ90gEjG0vxyoKVKD6KeoyODH0Mu4FMEMohO5Mpc0htZUFosNwIyE2J0sjj9fAwl6PTyu8Coizh/dDcYBWMYhpl9L3fJ+za3fzsNJzsU6k4B88ifFQ3of1/TWPHoZNf33aFDQhaf2REIigjb9A3S0vFb9EvsXyuiqFiDNneOoDqtDSqJwB8y8t0rnLH44T6fhTQ9RVBNiuL8rE0l+U5heQZOEHKGo56cdJcRoCq65ZPlOhnbXWEbHU2snslKLbEs3SpkgZMoJmGr89aF4hdIkpRsU92A60NQ+AThZ+Cgf6xnQSSOvx56KoZSCm6vtko6NcZmzekmCfjqlBR/1t9Qmhtr9OPHqQvMsWpmohpibFFbvxRVCbvdWe8V24q0UwmLlnz7OK3QkhNX9TI8fD9MyA9QYeYFuFRhOG9MHxA0LAn8ufcIsfA8ZD3lBA2omaszO4tFNie0oVfBSMUuEs1sSD9XS6g3OOXr02EHWR3LH3wLkqH87bfUjATUldEvQK6dk6TI9arQEeYwZZ6bpZmaE0=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(40470700002)(46966006)(36840700001)(7696005)(2906002)(54906003)(81166007)(6916009)(336012)(36860700001)(508600001)(5660300002)(2616005)(316002)(1076003)(426003)(36756003)(4326008)(86362001)(8676002)(30864003)(6666004)(8936002)(26005)(70586007)(44832011)(83380400001)(356005)(70206006)(82310400004)(40460700001)(186003)(16526019)(47076005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jan 2022 12:41:29.7565 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b01c04a7-0e31-4146-2a30-08d9d4ffb0e4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT024.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1201MB0040
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
--
v1->v2:
  - move the checks for invalid inputs(null pointer, U32_MAX) to the
    layer down(Lijo)
---
 .../gpu/drm/amd/include/kgd_pp_interface.h    |   4 +-
 drivers/gpu/drm/amd/pm/amdgpu_dpm.c           |  21 +--
 drivers/gpu/drm/amd/pm/amdgpu_pm.c            |  21 ++-
 drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c    |  19 ++-
 .../gpu/drm/amd/pm/powerplay/amd_powerplay.c  |  71 ++++++----
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c     | 133 ++++++++++--------
 6 files changed, 160 insertions(+), 109 deletions(-)

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
index 68d2e80a673b..51d5d1a1717b 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
@@ -1030,15 +1030,17 @@ int amdgpu_dpm_get_fan_control_mode(struct amdgpu_device *adev,
 				    uint32_t *fan_mode)
 {
 	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
+	int ret = 0;
 
 	if (!pp_funcs->get_fan_control_mode)
 		return -EOPNOTSUPP;
 
 	mutex_lock(&adev->pm.mutex);
-	*fan_mode = pp_funcs->get_fan_control_mode(adev->powerplay.pp_handle);
+	ret = pp_funcs->get_fan_control_mode(adev->powerplay.pp_handle,
+					     fan_mode);
 	mutex_unlock(&adev->pm.mutex);
 
-	return 0;
+	return ret;
 }
 
 int amdgpu_dpm_set_fan_speed_pwm(struct amdgpu_device *adev,
@@ -1048,7 +1050,7 @@ int amdgpu_dpm_set_fan_speed_pwm(struct amdgpu_device *adev,
 	int ret = 0;
 
 	if (!pp_funcs->set_fan_speed_pwm)
-		return -EINVAL;
+		return -EOPNOTSUPP;
 
 	mutex_lock(&adev->pm.mutex);
 	ret = pp_funcs->set_fan_speed_pwm(adev->powerplay.pp_handle,
@@ -1065,7 +1067,7 @@ int amdgpu_dpm_get_fan_speed_pwm(struct amdgpu_device *adev,
 	int ret = 0;
 
 	if (!pp_funcs->get_fan_speed_pwm)
-		return -EINVAL;
+		return -EOPNOTSUPP;
 
 	mutex_lock(&adev->pm.mutex);
 	ret = pp_funcs->get_fan_speed_pwm(adev->powerplay.pp_handle,
@@ -1082,7 +1084,7 @@ int amdgpu_dpm_get_fan_speed_rpm(struct amdgpu_device *adev,
 	int ret = 0;
 
 	if (!pp_funcs->get_fan_speed_rpm)
-		return -EINVAL;
+		return -EOPNOTSUPP;
 
 	mutex_lock(&adev->pm.mutex);
 	ret = pp_funcs->get_fan_speed_rpm(adev->powerplay.pp_handle,
@@ -1099,7 +1101,7 @@ int amdgpu_dpm_set_fan_speed_rpm(struct amdgpu_device *adev,
 	int ret = 0;
 
 	if (!pp_funcs->set_fan_speed_rpm)
-		return -EINVAL;
+		return -EOPNOTSUPP;
 
 	mutex_lock(&adev->pm.mutex);
 	ret = pp_funcs->set_fan_speed_rpm(adev->powerplay.pp_handle,
@@ -1113,16 +1115,17 @@ int amdgpu_dpm_set_fan_control_mode(struct amdgpu_device *adev,
 				    uint32_t mode)
 {
 	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
+	int ret = 0;
 
 	if (!pp_funcs->set_fan_control_mode)
 		return -EOPNOTSUPP;
 
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
index 92b987fb31d4..23ff0d812e4b 100644
--- a/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c
+++ b/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c
@@ -6619,6 +6619,9 @@ static int si_dpm_get_fan_speed_pwm(void *handle,
 	u64 tmp64;
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
 
+	if (!speed)
+		return -EINVAL;
+
 	if (adev->pm.no_fan)
 		return -ENOENT;
 
@@ -6669,10 +6672,13 @@ static int si_dpm_set_fan_speed_pwm(void *handle,
 	return 0;
 }
 
-static void si_dpm_set_fan_control_mode(void *handle, u32 mode)
+static int si_dpm_set_fan_control_mode(void *handle, u32 mode)
 {
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
 
+	if (mode == U32_MAX)
+		return -EINVAL;
+
 	if (mode) {
 		/* stop auto-manage */
 		if (adev->pm.dpm.fan.ucode_fan_control)
@@ -6685,19 +6691,26 @@ static void si_dpm_set_fan_control_mode(void *handle, u32 mode)
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
 	u32 tmp;
 
+	if (!fan_mode)
+		return -EINVAL;
+
 	if (si_pi->fan_is_controlled_by_smc)
 		return 0;
 
 	tmp = RREG32(CG_FDO_CTRL2) & FDO_PWM_MODE_MASK;
-	return (tmp >> FDO_PWM_MODE_SHIFT);
+	*fan_mode = (tmp >> FDO_PWM_MODE_SHIFT);
+
+	return 0;
 }
 
 #if 0
diff --git a/drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c b/drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c
index 89341729744d..76c26ae368f9 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c
@@ -488,38 +488,43 @@ static enum amd_pm_state_type pp_dpm_get_current_power_state(void *handle)
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
+
+	if (mode == U32_MAX)
+		return -EINVAL;
 
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
+
+	if (!fan_mode)
+		return -EINVAL;
 
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
@@ -528,12 +533,14 @@ static int pp_dpm_set_fan_speed_pwm(void *handle, uint32_t speed)
 	int ret = 0;
 
 	if (!hwmgr || !hwmgr->pm_en)
+		return -EOPNOTSUPP;
+
+	if (hwmgr->hwmgr_func->set_fan_speed_pwm == NULL)
+		return -EOPNOTSUPP;
+
+	if (speed == U32_MAX)
 		return -EINVAL;
 
-	if (hwmgr->hwmgr_func->set_fan_speed_pwm == NULL) {
-		pr_info_ratelimited("%s was not implemented.\n", __func__);
-		return 0;
-	}
 	mutex_lock(&hwmgr->smu_lock);
 	ret = hwmgr->hwmgr_func->set_fan_speed_pwm(hwmgr, speed);
 	mutex_unlock(&hwmgr->smu_lock);
@@ -546,12 +553,13 @@ static int pp_dpm_get_fan_speed_pwm(void *handle, uint32_t *speed)
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
+
+	if (!speed)
+		return -EINVAL;
 
 	mutex_lock(&hwmgr->smu_lock);
 	ret = hwmgr->hwmgr_func->get_fan_speed_pwm(hwmgr, speed);
@@ -565,9 +573,12 @@ static int pp_dpm_get_fan_speed_rpm(void *handle, uint32_t *rpm)
 	int ret = 0;
 
 	if (!hwmgr || !hwmgr->pm_en)
-		return -EINVAL;
+		return -EOPNOTSUPP;
 
 	if (hwmgr->hwmgr_func->get_fan_speed_rpm == NULL)
+		return -EOPNOTSUPP;
+
+	if (!rpm)
 		return -EINVAL;
 
 	mutex_lock(&hwmgr->smu_lock);
@@ -582,12 +593,14 @@ static int pp_dpm_set_fan_speed_rpm(void *handle, uint32_t rpm)
 	int ret = 0;
 
 	if (!hwmgr || !hwmgr->pm_en)
+		return -EOPNOTSUPP;
+
+	if (hwmgr->hwmgr_func->set_fan_speed_rpm == NULL)
+		return -EOPNOTSUPP;
+
+	if (rpm == U32_MAX)
 		return -EINVAL;
 
-	if (hwmgr->hwmgr_func->set_fan_speed_rpm == NULL) {
-		pr_info_ratelimited("%s was not implemented.\n", __func__);
-		return 0;
-	}
 	mutex_lock(&hwmgr->smu_lock);
 	ret = hwmgr->hwmgr_func->set_fan_speed_rpm(hwmgr, rpm);
 	mutex_unlock(&hwmgr->smu_lock);
diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
index c374c3067496..828cb932f6a9 100644
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
@@ -2218,18 +2218,22 @@ static int smu_set_fan_speed_rpm(void *handle, uint32_t speed)
 	if (!smu->pm_enabled || !smu->adev->pm.dpm_enabled)
 		return -EOPNOTSUPP;
 
+	if (!smu->ppt_funcs->set_fan_speed_rpm)
+		return -EOPNOTSUPP;
+
+	if (speed == U32_MAX)
+		return -EINVAL;
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
@@ -2562,60 +2566,65 @@ static int smu_set_power_profile_mode(void *handle,
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
+
+	if (!fan_mode)
+		return -EINVAL;
 
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
+
+	if (value == U32_MAX)
+		return -EINVAL;
 
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
@@ -2624,10 +2633,15 @@ static int smu_get_fan_speed_pwm(void *handle, u32 *speed)
 	if (!smu->pm_enabled || !smu->adev->pm.dpm_enabled)
 		return -EOPNOTSUPP;
 
+	if (!smu->ppt_funcs->get_fan_speed_pwm)
+		return -EOPNOTSUPP;
+
+	if (!speed)
+		return -EINVAL;
+
 	mutex_lock(&smu->mutex);
 
-	if (smu->ppt_funcs->get_fan_speed_pwm)
-		ret = smu->ppt_funcs->get_fan_speed_pwm(smu, speed);
+	ret = smu->ppt_funcs->get_fan_speed_pwm(smu, speed);
 
 	mutex_unlock(&smu->mutex);
 
@@ -2642,18 +2656,22 @@ static int smu_set_fan_speed_pwm(void *handle, u32 speed)
 	if (!smu->pm_enabled || !smu->adev->pm.dpm_enabled)
 		return -EOPNOTSUPP;
 
+	if (!smu->ppt_funcs->set_fan_speed_pwm)
+		return -EOPNOTSUPP;
+
+	if (speed == U32_MAX)
+		return -EINVAL;
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
@@ -2669,10 +2687,15 @@ static int smu_get_fan_speed_rpm(void *handle, uint32_t *speed)
 	if (!smu->pm_enabled || !smu->adev->pm.dpm_enabled)
 		return -EOPNOTSUPP;
 
+	if (!smu->ppt_funcs->get_fan_speed_rpm)
+		return -EOPNOTSUPP;
+
+	if (!speed)
+		return -EINVAL;
+
 	mutex_lock(&smu->mutex);
 
-	if (smu->ppt_funcs->get_fan_speed_rpm)
-		ret = smu->ppt_funcs->get_fan_speed_rpm(smu, speed);
+	ret = smu->ppt_funcs->get_fan_speed_rpm(smu, speed);
 
 	mutex_unlock(&smu->mutex);
 
@@ -3101,7 +3124,7 @@ static int smu_get_prv_buffer_details(void *handle, void **addr, size_t *size)
 
 static const struct amd_pm_funcs swsmu_pm_funcs = {
 	/* export for sysfs */
-	.set_fan_control_mode    = smu_pp_set_fan_control_mode,
+	.set_fan_control_mode    = smu_set_fan_control_mode,
 	.get_fan_control_mode    = smu_get_fan_control_mode,
 	.set_fan_speed_pwm   = smu_set_fan_speed_pwm,
 	.get_fan_speed_pwm   = smu_get_fan_speed_pwm,
-- 
2.29.0

