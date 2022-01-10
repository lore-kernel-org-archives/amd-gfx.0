Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F203C433F5
	for <amd-gfx@archiver.kernel.org>; Mon, 10 Jan 2022 06:01:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 79DFE11B8B5;
	Mon, 10 Jan 2022 06:01:02 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2089.outbound.protection.outlook.com [40.107.94.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1833A11B965
 for <amd-gfx@lists.freedesktop.org>; Mon, 10 Jan 2022 06:01:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VZrrytgnRmGq1b3HMPC1Gouk1PNWWUo7Ks8IgnONnBrOlKNxKEZojPl27bWavqAEv4lS4WcHeT+ZWWP6ZWYUOWpj9g4MuVHVNjAmTQ8c0KJVtQKyw++2BzpAKD9FnVCR3buJ/stW6w+jJDFrQDf8Uz4kKmCE1dseLd20F8DeCuJ0DESTYoz036lImH6St0lqOkFIP5cnC4jxNd4aJ8qFlroBOhKpmPcUGDQ8I2A8Tdsz9jmMs5KDNNCt0AWTz4StdsvzZhk6fXcxlTmUueIfeGaZGXduCsw9ZLCjcCF0jxHxoUS1vPplbDQqicgc8wkKc0i//QI7znA/et0zy79arA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WyVYaF0MOYEe/AwSIN2vAco2SmZfJQd0Rf2IhDxSRCw=;
 b=FBe61Be66zX8VCOhR2kQI+P/ZJNZKZecWPg3morXAtQEFhnUWjXJkmkIeKXJzIwCN1Ve98Aotd3HP/w8vJyUiXSU+kimOVAEj5wEbLld9SXKZKbTwOkf0rf+1YA+ujvHi18smFs+BTF0XfC+dreDH+9G4CzLnLmsXUcnKtF/h3uhy2d31lNiB4CfdU2M2/Oro6KzNMQ+q9m5svV4DXqGRuXjRZmT+vAvLCOejT5r5uVYjrXJxr9C5LQWV51Zvv070VNrtc/DA1RoBuj7xUacGP6PD5ZOr3OW7HTP/HwFAJibV1sJVe8O8LgXcX/Yojw7c77b+4SLs+urpwojsOCASA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WyVYaF0MOYEe/AwSIN2vAco2SmZfJQd0Rf2IhDxSRCw=;
 b=Rlc2YFS3q80takKDPNlAUO+spDfh97EDSmkdwrtXOqxexvSNwWgLSnOEzgjC0WbrnmUPSUZoR++Dkzqj20adzVnIJk0vqJGt5uNKDbMswVrITyGAlS+B05qD0S0k+s6nelJVkWAXVRSdbI2qSYKOE0jGc3nf+Kvo36Ns5ZmOsn4=
Received: from CO2PR04CA0176.namprd04.prod.outlook.com (2603:10b6:104:4::30)
 by DM4PR12MB5118.namprd12.prod.outlook.com (2603:10b6:5:391::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.11; Mon, 10 Jan
 2022 06:00:59 +0000
Received: from CO1NAM11FT041.eop-nam11.prod.protection.outlook.com
 (2603:10b6:104:4:cafe::3c) by CO2PR04CA0176.outlook.office365.com
 (2603:10b6:104:4::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.9 via Frontend
 Transport; Mon, 10 Jan 2022 06:00:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT041.mail.protection.outlook.com (10.13.174.217) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4867.7 via Frontend Transport; Mon, 10 Jan 2022 06:00:59 +0000
Received: from equan-buildpc.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Mon, 10 Jan
 2022 00:00:57 -0600
From: Evan Quan <evan.quan@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amd/pm: correct the checks for fan attributes support
Date: Mon, 10 Jan 2022 14:00:42 +0800
Message-ID: <20220110060042.3159997-1-evan.quan@amd.com>
X-Mailer: git-send-email 2.29.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f5058305-cd77-415e-0f98-08d9d3fe9347
X-MS-TrafficTypeDiagnostic: DM4PR12MB5118:EE_
X-Microsoft-Antispam-PRVS: <DM4PR12MB5118B8E5F7D772BBCAED45CCE4509@DM4PR12MB5118.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9uXF9GrJGIgY5atfIvWFPGb67oa+rgYsG21e0eb/TJ+No99gZM+tx/9fPUE+tivxoaE2DWHB3rFlR3EDmEBx5gWKdLaf00z2+IF5Z+ox54kLF649uSy/AkNob2mBDZEFjPLan3QjzIZyUWOiGKt35u1znVHpX/dnORWcCWkJWcuPWk6/xOtkYNEDvVEfB9yasOcBTbkJzQxoZz9EnUdTMxDLo8HSOwf+9bYy5JB2MSE0tT3Ndr7jCAg0w5OQV678BfHeJ6F/kthq1rTvZxPXap3AuI1FCEf6mnbmTABIrtACMU9IPnInJpyFYZjUG7PfwueOMd6LcgL48yNbrGNEDuC4ScgbJsU0pBbpO7UhET5TpN0q/RBQgM8J37+iT6opejoCjJkFsmdv9eNPSAezVrtbVeK/sX8t9BaBd+VFpSt4+saQFJahCN8Ept6nGyYJIdCOVIly5577ZciEJRJ29scOu4C9CYTDKNxiGaKFoj3+4L3IdsiFJlK28kYLdJKANwE1BX9R37Jy7FjOQ7oDK2x8JMMYNpFIUKC+04E/PKBw3UXsyqisYqwnRpwXv1owWjDD7ju7/qTeR8XBSfoEmdGiDDV3w63CdZFoKA/PjQd8hxIXvv3Bt0FepTiTYvnw1g4LGa0FMYvjijqeEeh4o65EvqpFiG9FCq1yzYZeFV/ziI+Hb3o9cp6fGS0/llpjeQ3ZbMidN4d00Da3HLgaJAaChfRW8p1/uzmDBxY88pQBtStmNlhxEcjqmo9FvI3uOsf66tgQgTrA/n97icn/svdTzOM0BA4zRhJc8xswPXU=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(40470700002)(46966006)(1076003)(54906003)(2906002)(8676002)(356005)(40460700001)(36756003)(44832011)(70206006)(16526019)(508600001)(5660300002)(8936002)(7696005)(47076005)(86362001)(26005)(83380400001)(186003)(70586007)(82310400004)(36860700001)(316002)(6916009)(81166007)(336012)(426003)(4326008)(2616005)(6666004)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2022 06:00:59.4135 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f5058305-cd77-415e-0f98-08d9d3fe9347
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT041.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5118
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
Cc: Alexander.Deucher@amd.com, Evan Quan <evan.quan@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Before we relied on the return values from the corresponding interfaces.
That is with low efficiency. And the wrong intermediate variable used
makes the fan mode stuck at manual mode which then causes overheating in
3D graphics tests.

Signed-off-by: Evan Quan <evan.quan@amd.com>
Change-Id: Ia93ccf3b929c12e6d10b50c8f3596783ac63f0e3
---
 drivers/gpu/drm/amd/pm/amdgpu_dpm.c     | 23 +++++++++++++++++++++++
 drivers/gpu/drm/amd/pm/amdgpu_pm.c      | 20 ++++++++++----------
 drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h | 12 ++++++++++++
 3 files changed, 45 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
index 68d2e80a673b..e732418a9558 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
@@ -1547,3 +1547,26 @@ int amdgpu_dpm_get_dpm_clock_table(struct amdgpu_device *adev,
 
 	return ret;
 }
+
+int amdgpu_dpm_is_fan_operation_supported(struct amdgpu_device *adev,
+					  enum fan_operation_id id)
+{
+	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
+
+	switch (id) {
+	case FAN_CONTROL_MODE_RETRIEVING:
+		return pp_funcs->get_fan_control_mode ? 1 : 0;
+	case FAN_CONTROL_MODE_SETTING:
+		return pp_funcs->set_fan_control_mode ? 1 : 0;
+	case FAN_SPEED_PWM_RETRIEVING:
+		return pp_funcs->get_fan_speed_pwm ? 1 : 0;
+	case FAN_SPEED_PWM_SETTING:
+		return pp_funcs->set_fan_speed_pwm ? 1 : 0;
+	case FAN_SPEED_RPM_RETRIEVING:
+		return pp_funcs->get_fan_speed_rpm ? 1 : 0;
+	case FAN_SPEED_RPM_SETTING:
+		return pp_funcs->set_fan_speed_rpm ? 1 : 0;
+	default:
+		return 0;
+	}
+}
diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
index d3eab245e0fe..57721750c51a 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
@@ -3263,15 +3263,15 @@ static umode_t hwmon_attributes_visible(struct kobject *kobj,
 		return 0;
 
 	/* mask fan attributes if we have no bindings for this asic to expose */
-	if (((amdgpu_dpm_get_fan_speed_pwm(adev, &speed) == -EINVAL) &&
+	if ((!amdgpu_dpm_is_fan_operation_supported(adev, FAN_SPEED_PWM_RETRIEVING) &&
 	      attr == &sensor_dev_attr_pwm1.dev_attr.attr) || /* can't query fan */
-	    ((amdgpu_dpm_get_fan_control_mode(adev, &speed) == -EOPNOTSUPP) &&
+	    (!amdgpu_dpm_is_fan_operation_supported(adev, FAN_CONTROL_MODE_RETRIEVING) &&
 	     attr == &sensor_dev_attr_pwm1_enable.dev_attr.attr)) /* can't query state */
 		effective_mode &= ~S_IRUGO;
 
-	if (((amdgpu_dpm_set_fan_speed_pwm(adev, speed) == -EINVAL) &&
+	if ((!amdgpu_dpm_is_fan_operation_supported(adev, FAN_SPEED_PWM_SETTING) &&
 	      attr == &sensor_dev_attr_pwm1.dev_attr.attr) || /* can't manage fan */
-	      ((amdgpu_dpm_set_fan_control_mode(adev, speed) == -EOPNOTSUPP) &&
+	    (!amdgpu_dpm_is_fan_operation_supported(adev, FAN_CONTROL_MODE_SETTING) &&
 	      attr == &sensor_dev_attr_pwm1_enable.dev_attr.attr)) /* can't manage state */
 		effective_mode &= ~S_IWUSR;
 
@@ -3291,16 +3291,16 @@ static umode_t hwmon_attributes_visible(struct kobject *kobj,
 		return 0;
 
 	/* hide max/min values if we can't both query and manage the fan */
-	if (((amdgpu_dpm_set_fan_speed_pwm(adev, speed) == -EINVAL) &&
-	      (amdgpu_dpm_get_fan_speed_pwm(adev, &speed) == -EINVAL) &&
-	      (amdgpu_dpm_set_fan_speed_rpm(adev, speed) == -EINVAL) &&
-	      (amdgpu_dpm_get_fan_speed_rpm(adev, &speed) == -EINVAL)) &&
+	if ((!amdgpu_dpm_is_fan_operation_supported(adev, FAN_SPEED_PWM_SETTING) &&
+	     !amdgpu_dpm_is_fan_operation_supported(adev, FAN_SPEED_PWM_RETRIEVING) &&
+	     !amdgpu_dpm_is_fan_operation_supported(adev, FAN_SPEED_RPM_SETTING) &&
+	     !amdgpu_dpm_is_fan_operation_supported(adev, FAN_SPEED_RPM_RETRIEVING)) &&
 	    (attr == &sensor_dev_attr_pwm1_max.dev_attr.attr ||
 	     attr == &sensor_dev_attr_pwm1_min.dev_attr.attr))
 		return 0;
 
-	if ((amdgpu_dpm_set_fan_speed_rpm(adev, speed) == -EINVAL) &&
-	     (amdgpu_dpm_get_fan_speed_rpm(adev, &speed) == -EINVAL) &&
+	if ((!amdgpu_dpm_is_fan_operation_supported(adev, FAN_SPEED_RPM_SETTING) &&
+	     !amdgpu_dpm_is_fan_operation_supported(adev, FAN_SPEED_RPM_RETRIEVING)) &&
 	     (attr == &sensor_dev_attr_fan1_max.dev_attr.attr ||
 	     attr == &sensor_dev_attr_fan1_min.dev_attr.attr))
 		return 0;
diff --git a/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h b/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
index ba857ca75392..9e18151a3c46 100644
--- a/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
+++ b/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
@@ -330,6 +330,16 @@ struct amdgpu_pm {
 	bool			pp_force_state_enabled;
 };
 
+enum fan_operation_id
+{
+	FAN_CONTROL_MODE_RETRIEVING = 0,
+	FAN_CONTROL_MODE_SETTING    = 1,
+	FAN_SPEED_PWM_RETRIEVING    = 2,
+	FAN_SPEED_PWM_SETTING       = 3,
+	FAN_SPEED_RPM_RETRIEVING    = 4,
+	FAN_SPEED_RPM_SETTING       = 5,
+};
+
 u32 amdgpu_dpm_get_vblank_time(struct amdgpu_device *adev);
 int amdgpu_dpm_read_sensor(struct amdgpu_device *adev, enum amd_pp_sensors sensor,
 			   void *data, uint32_t *size);
@@ -510,4 +520,6 @@ enum pp_smu_status amdgpu_dpm_get_uclk_dpm_states(struct amdgpu_device *adev,
 						  unsigned int *num_states);
 int amdgpu_dpm_get_dpm_clock_table(struct amdgpu_device *adev,
 				   struct dpm_clocks *clock_table);
+int amdgpu_dpm_is_fan_operation_supported(struct amdgpu_device *adev,
+					  enum fan_operation_id id);
 #endif
-- 
2.29.0

