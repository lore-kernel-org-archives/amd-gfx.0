Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C94C3C54EBD
	for <amd-gfx@archiver.kernel.org>; Thu,  5 Jan 2023 03:23:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9A92F10E62B;
	Thu,  5 Jan 2023 03:23:32 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2050.outbound.protection.outlook.com [40.107.92.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C264E10E62B
 for <amd-gfx@lists.freedesktop.org>; Thu,  5 Jan 2023 03:23:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MsmQIi3/T6xwnq3WqRj9PRj7X5OvgpiV8/SPfYl5ABD02PPjnOED/wG2j4IFyZk9CGoQOWLZN4EM54CTq7KdR/IL4xP4rYy+or4ehtpkEdkzoiBexX6JJ8NoNrPCQywJnIRavHzhDu4FQJNBDbFtpH3KUKGER9udpo/xsGg0n+m3zH5FKAiISshK4sIG/I8x6jDsbdMdvOwoBqPhO0Fbe/j5WA+ZN0cNRuuAUIpyIXhHctiMiqMW+1zS/CpElggnHn4xnywNRX+towpgrwLPsYLDA88uCRomg3MB1MH47/ZYLu8xQ3xIT/3qb4Ht2Md0fT24D68frAXoBCIXpf7bZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WstTIANg/6qy0gj6FHMFaRhsaX1tDWA5Oz4r9fuvOBk=;
 b=lMbtEjbPeOJeZAeO2q5IYhevV5MktS795bBRDyqPIJaA5pO7mxDBk9am69l3Tb1gbiZJTgIFzO5TV3jI0m6RiVQ0HM/PHSNgwKptLKVoJYZEVpIBTYzXJx48973kKFi/cq1fwHm6Vlx5f7tupmKech9gbiQ6yxoWHNf90aGQD4Jg7GGh88eK0WwvSqO1Jg/X7rgh0N5WnABExY6uZrJPKLVGr5BnGVosvh1u9lZkbFvs92vXWBQfEvRrBajMdKFgtsDt/Y2qyugcImQkwp0SbD89e2/fULd07YTk3gPgSfIX8PhJwz17Zd0iMjiyZ4gQ5L5yFJEqX8f4a85xByP+Qw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WstTIANg/6qy0gj6FHMFaRhsaX1tDWA5Oz4r9fuvOBk=;
 b=IAAQkFzaL8cruK2XGtghlaFTjyoar+bvh7f9gnADag2lnsMUfpCHPKWawo0A+q8h99oV/e1o00R/SaXSNTErxPQ0vfjPoQLTNyDEvcrCU6tM7sJNCp45SRdxdvNgnW5WSJpsK8Lowx8Mv8jdwcEo2KG0QC/4/KbjQWVpvAxqnoE=
Received: from BN8PR03CA0022.namprd03.prod.outlook.com (2603:10b6:408:94::35)
 by CY5PR12MB6455.namprd12.prod.outlook.com (2603:10b6:930:35::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.19; Thu, 5 Jan
 2023 03:23:27 +0000
Received: from BN8NAM11FT008.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:94:cafe::e6) by BN8PR03CA0022.outlook.office365.com
 (2603:10b6:408:94::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.14 via Frontend
 Transport; Thu, 5 Jan 2023 03:23:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT008.mail.protection.outlook.com (10.13.177.95) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5986.14 via Frontend Transport; Thu, 5 Jan 2023 03:23:26 +0000
Received: from equan-buildpc.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 4 Jan
 2023 21:23:25 -0600
From: Evan Quan <evan.quan@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 6/8] drm/amd/pm: refine the checks for hwmon interfaces support
Date: Thu, 5 Jan 2023 11:22:57 +0800
Message-ID: <20230105032259.2032789-6-evan.quan@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230105032259.2032789-1-evan.quan@amd.com>
References: <20230105032259.2032789-1-evan.quan@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT008:EE_|CY5PR12MB6455:EE_
X-MS-Office365-Filtering-Correlation-Id: d38a8a1c-8ad0-443d-e233-08daeecc35b5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: krb+xiRL4yKbvwPY417gbMrP5HXq11OpEtHvfn1wnMsF8Rxph4J29WZDOpM0DZ4a+/K3kYaRV/SYRNjOm29bRJgwTciJi7mkomd8av0SmN79/C8jFDzRCdu2A9tSqu2fjgiGovS0Fm1bWeTby8Uvr1X02/kNcirwhlRqDDQe6dn3WPu0e9Q22I1gjRtZOnPfa4sAlqI1SNUYzXK1+iM9pgK3Znaj3skSmhjVFIKKSmY1TK7LifERnyZ3tpwVISHa5siCGzZKx7mXEwDrCmL40x8CFl+97YFT3nOUnkTRUmc2kdQdr06Cf5Vk0mqRgYELOtrd46LvlKXXMizMpLURsI3+N/XRUt4lXUKxdomKuRVjWsvUuwNI+l9eWU0UQb/BhK2lhelnImZr+t3344R1pcC+Ru/Dh3vLSiZ/eWRyU2jT1qH0UtuSpCPVfRlMA/DHm7D9JBta3yMa2JisFb+kSdfHOFJUdCdmNFIvzlJud2/sd5X7I4QitPsXX24G0uyHKBna12pL026qEZuGrPpUNtmVcLo0MH1aVXdmxEicZm0qQbu0PLujtH9riYK8WeWPScJg110K4SGXnhdaW/h3PNJXFYctPtyhO1uBK5ZfTzfREQkyq+3/8797MfGDrEnmJShOhN/emCvKNwia4tVS2eXzCBPR79EHEh2xBxam8h+hEZCTw6H5Rs5Gf9FEHQ9M1BvVZCfwSvrWCB1fpWdET0pXy4N8jsZNBOmc4ft5AdA=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(39860400002)(346002)(136003)(396003)(376002)(451199015)(40470700004)(46966006)(36840700001)(36860700001)(47076005)(83380400001)(426003)(86362001)(41300700001)(356005)(44832011)(8936002)(82740400003)(2906002)(30864003)(5660300002)(40460700003)(82310400005)(6666004)(40480700001)(7696005)(4326008)(186003)(316002)(26005)(336012)(8676002)(16526019)(1076003)(2616005)(478600001)(70586007)(6916009)(54906003)(70206006)(81166007)(36756003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jan 2023 03:23:26.7729 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d38a8a1c-8ad0-443d-e233-08daeecc35b5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT008.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6455
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

Make the code more clean and readable with no real logics
change.

Signed-off-by: Evan Quan <evan.quan@amd.com>
Change-Id: I2c9e661ed6b855ea6ddd8554dd4f975cd2faa24f
---
 drivers/gpu/drm/amd/pm/amdgpu_pm.c | 329 ++++++++++++++++++-----------
 1 file changed, 206 insertions(+), 123 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
index c69db29eea24..dcfc0d605fc5 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
@@ -3155,161 +3155,242 @@ static umode_t hwmon_attributes_visible(struct kobject *kobj,
 	struct device *dev = kobj_to_dev(kobj);
 	struct amdgpu_device *adev = dev_get_drvdata(dev);
 	umode_t effective_mode = attr->mode;
+	uint32_t if_bit;
+
+	if (attr == &sensor_dev_attr_temp1_input.dev_attr.attr)
+		if_bit = AMD_HWMON_IF_TEMP1_INPUT_BIT;
+	else if (attr == &sensor_dev_attr_temp1_crit.dev_attr.attr)
+		if_bit = AMD_HWMON_IF_TEMP1_CRIT_BIT;
+	else if (attr == &sensor_dev_attr_temp1_crit_hyst.dev_attr.attr)
+		if_bit = AMD_HWMON_IF_TEMP1_CRIT_HYST_BIT;
+	else if (attr == &sensor_dev_attr_temp2_input.dev_attr.attr)
+		if_bit = AMD_HWMON_IF_TEMP2_INPUT_BIT;
+	else if (attr == &sensor_dev_attr_temp2_crit.dev_attr.attr)
+		if_bit = AMD_HWMON_IF_TEMP2_CRIT_BIT;
+	else if (attr == &sensor_dev_attr_temp2_crit_hyst.dev_attr.attr)
+		if_bit = AMD_HWMON_IF_TEMP2_CRIT_HYST_BIT;
+	else if (attr == &sensor_dev_attr_temp3_input.dev_attr.attr)
+		if_bit = AMD_HWMON_IF_TEMP3_INPUT_BIT;
+	else if (attr == &sensor_dev_attr_temp3_crit.dev_attr.attr)
+		if_bit = AMD_HWMON_IF_TEMP3_CRIT_BIT;
+	else if (attr == &sensor_dev_attr_temp3_crit_hyst.dev_attr.attr)
+		if_bit = AMD_HWMON_IF_TEMP3_CRIT_HYST_BIT;
+	else if (attr == &sensor_dev_attr_temp1_emergency.dev_attr.attr)
+		if_bit = AMD_HWMON_IF_TEMP1_EMERGENCY_BIT;
+	else if (attr == &sensor_dev_attr_temp2_emergency.dev_attr.attr)
+		if_bit = AMD_HWMON_IF_TEMP2_EMERGENCY_BIT;
+	else if (attr == &sensor_dev_attr_temp3_emergency.dev_attr.attr)
+		if_bit = AMD_HWMON_IF_TEMP3_EMERGENCY_BIT;
+	else if (attr == &sensor_dev_attr_temp1_label.dev_attr.attr)
+		if_bit = AMD_HWMON_IF_TEMP1_LABEL_BIT;
+	else if (attr == &sensor_dev_attr_temp2_label.dev_attr.attr)
+		if_bit = AMD_HWMON_IF_TEMP2_LABEL_BIT;
+	else if (attr == &sensor_dev_attr_temp3_label.dev_attr.attr)
+		if_bit = AMD_HWMON_IF_TEMP3_LABEL_BIT;
+	else if (attr == &sensor_dev_attr_pwm1.dev_attr.attr)
+		if_bit = AMD_HWMON_IF_PWM1_BIT;
+	else if (attr == &sensor_dev_attr_pwm1_enable.dev_attr.attr)
+		if_bit = AMD_HWMON_IF_PWM1_ENABLE_BIT;
+	else if (attr == &sensor_dev_attr_pwm1_min.dev_attr.attr)
+		if_bit = AMD_HWMON_IF_PWM1_MIN_BIT;
+	else if (attr == &sensor_dev_attr_pwm1_max.dev_attr.attr)
+		if_bit = AMD_HWMON_IF_PWM1_MAX_BIT;
+	else if (attr == &sensor_dev_attr_fan1_input.dev_attr.attr)
+		if_bit = AMD_HWMON_IF_FAN1_INPUT_BIT;
+	else if (attr == &sensor_dev_attr_fan1_min.dev_attr.attr)
+		if_bit = AMD_HWMON_IF_FAN1_MIN_BIT;
+	else if (attr == &sensor_dev_attr_fan1_max.dev_attr.attr)
+		if_bit = AMD_HWMON_IF_FAN1_MAX_BIT;
+	else if (attr == &sensor_dev_attr_fan1_target.dev_attr.attr)
+		if_bit = AMD_HWMON_IF_FAN1_TARGET_BIT;
+	else if (attr == &sensor_dev_attr_fan1_enable.dev_attr.attr)
+		if_bit = AMD_HWMON_IF_FAN1_ENABLE_BIT;
+	else if (attr == &sensor_dev_attr_in0_input.dev_attr.attr)
+		if_bit = AMD_HWMON_IF_IN0_INPUT_BIT;
+	else if (attr == &sensor_dev_attr_in0_label.dev_attr.attr)
+		if_bit = AMD_HWMON_IF_IN0_LABEL_BIT;
+	else if (attr == &sensor_dev_attr_in1_input.dev_attr.attr)
+		if_bit = AMD_HWMON_IF_IN1_INPUT_BIT;
+	else if (attr == &sensor_dev_attr_in1_label.dev_attr.attr)
+		if_bit = AMD_HWMON_IF_IN1_LABEL_BIT;
+	else if (attr == &sensor_dev_attr_power1_average.dev_attr.attr)
+		if_bit = AMD_HWMON_IF_POWER1_AVERAGE_BIT;
+	else if (attr == &sensor_dev_attr_power1_cap_max.dev_attr.attr)
+		if_bit = AMD_HWMON_IF_POWER1_CAP_MAX_BIT;
+	else if (attr == &sensor_dev_attr_power1_cap_min.dev_attr.attr)
+		if_bit = AMD_HWMON_IF_POWER1_CAP_MIN_BIT;
+	else if (attr == &sensor_dev_attr_power1_cap.dev_attr.attr)
+		if_bit = AMD_HWMON_IF_POWER1_CAP_BIT;
+	else if (attr == &sensor_dev_attr_power1_cap_default.dev_attr.attr)
+		if_bit = AMD_HWMON_IF_POWER1_CAP_DEFAULT_BIT;
+	else if (attr == &sensor_dev_attr_power1_label.dev_attr.attr)
+		if_bit = AMD_HWMON_IF_POWER1_LABEL_BIT;
+	else if (attr == &sensor_dev_attr_power2_average.dev_attr.attr)
+		if_bit = AMD_HWMON_IF_POWER2_AVERAGE_BIT;
+	else if (attr == &sensor_dev_attr_power2_cap_max.dev_attr.attr)
+		if_bit = AMD_HWMON_IF_POWER2_CAP_MAX_BIT;
+	else if (attr == &sensor_dev_attr_power2_cap_min.dev_attr.attr)
+		if_bit = AMD_HWMON_IF_POWER2_CAP_MIN_BIT;
+	else if (attr == &sensor_dev_attr_power2_cap.dev_attr.attr)
+		if_bit = AMD_HWMON_IF_POWER2_CAP_BIT;
+	else if (attr == &sensor_dev_attr_power2_cap_default.dev_attr.attr)
+		if_bit = AMD_HWMON_IF_POWER2_CAP_DEFAULT_BIT;
+	else if (attr == &sensor_dev_attr_power2_label.dev_attr.attr)
+		if_bit = AMD_HWMON_IF_POWER2_LABEL_BIT;
+	else if (attr == &sensor_dev_attr_freq1_input.dev_attr.attr)
+		if_bit = AMD_HWMON_IF_FREQ1_INPUT_BIT;
+	else if (attr == &sensor_dev_attr_freq1_label.dev_attr.attr)
+		if_bit = AMD_HWMON_IF_FREQ1_LABEL_BIT;
+	else if (attr == &sensor_dev_attr_freq2_input.dev_attr.attr)
+		if_bit = AMD_HWMON_IF_FREQ2_INPUT_BIT;
+	else if (attr == &sensor_dev_attr_freq2_label.dev_attr.attr)
+		if_bit = AMD_HWMON_IF_FREQ2_LABEL_BIT;
+
+	if (!(adev->pm.hwmon_if_supported & BIT_ULL(if_bit)))
+		return 0;
+
+	effective_mode &= adev->pm.hwmon_if_attr_mode[if_bit];
+
+	return effective_mode;
+}
+
+static const struct attribute_group hwmon_attrgroup = {
+	.attrs = hwmon_attributes,
+	.is_visible = hwmon_attributes_visible,
+};
+
+static const struct attribute_group *hwmon_groups[] = {
+	&hwmon_attrgroup,
+	NULL
+};
+
+static void amdgpu_hwmon_if_support_check(struct amdgpu_device *adev)
+{
 	uint32_t gc_ver = adev->ip_versions[GC_HWIP][0];
+	int i;
 
 	/* under multi-vf mode, the hwmon attributes are all not supported */
-	if (amdgpu_sriov_vf(adev) && !amdgpu_sriov_is_pp_one_vf(adev))
-		return 0;
+	if (amdgpu_sriov_vf(adev) &&
+	    !amdgpu_sriov_is_pp_one_vf(adev)) {
+		adev->pm.hwmon_if_supported = 0;
+		return;
+	}
 
 	/* under pp one vf mode manage of hwmon attributes is not supported */
-	if (amdgpu_sriov_is_pp_one_vf(adev))
-		effective_mode &= ~S_IWUSR;
+	if (amdgpu_sriov_is_pp_one_vf(adev)) {
+		for (i = 0; i < AMD_MAX_NUMBER_OF_HWMON_IF_SUPPORTED; i++)
+			adev->pm.hwmon_if_attr_mode[i] &= ~S_IWUSR;
+	}
 
 	/* Skip fan attributes if fan is not present */
-	if (adev->pm.no_fan && (attr == &sensor_dev_attr_pwm1.dev_attr.attr ||
-	    attr == &sensor_dev_attr_pwm1_enable.dev_attr.attr ||
-	    attr == &sensor_dev_attr_pwm1_max.dev_attr.attr ||
-	    attr == &sensor_dev_attr_pwm1_min.dev_attr.attr ||
-	    attr == &sensor_dev_attr_fan1_input.dev_attr.attr ||
-	    attr == &sensor_dev_attr_fan1_min.dev_attr.attr ||
-	    attr == &sensor_dev_attr_fan1_max.dev_attr.attr ||
-	    attr == &sensor_dev_attr_fan1_target.dev_attr.attr ||
-	    attr == &sensor_dev_attr_fan1_enable.dev_attr.attr))
-		return 0;
-
-	/* Skip fan attributes on APU */
-	if ((adev->flags & AMD_IS_APU) &&
-	    (attr == &sensor_dev_attr_pwm1.dev_attr.attr ||
-	     attr == &sensor_dev_attr_pwm1_enable.dev_attr.attr ||
-	     attr == &sensor_dev_attr_pwm1_max.dev_attr.attr ||
-	     attr == &sensor_dev_attr_pwm1_min.dev_attr.attr ||
-	     attr == &sensor_dev_attr_fan1_input.dev_attr.attr ||
-	     attr == &sensor_dev_attr_fan1_min.dev_attr.attr ||
-	     attr == &sensor_dev_attr_fan1_max.dev_attr.attr ||
-	     attr == &sensor_dev_attr_fan1_target.dev_attr.attr ||
-	     attr == &sensor_dev_attr_fan1_enable.dev_attr.attr))
-		return 0;
+	if (adev->pm.no_fan ||
+	    (adev->flags & AMD_IS_APU))
+		adev->pm.hwmon_if_supported &= ~(BIT_ULL(AMD_HWMON_IF_PWM1_BIT) |
+						 BIT_ULL(AMD_HWMON_IF_PWM1_ENABLE_BIT) |
+						 BIT_ULL(AMD_HWMON_IF_PWM1_MAX_BIT) |
+						 BIT_ULL(AMD_HWMON_IF_PWM1_MIN_BIT) |
+						 BIT_ULL(AMD_HWMON_IF_FAN1_INPUT_BIT) |
+						 BIT_ULL(AMD_HWMON_IF_FAN1_MIN_BIT) |
+						 BIT_ULL(AMD_HWMON_IF_FAN1_MAX_BIT) |
+						 BIT_ULL(AMD_HWMON_IF_FAN1_TARGET_BIT) |
+						 BIT_ULL(AMD_HWMON_IF_FAN1_ENABLE_BIT));
 
 	/* Skip crit temp on APU */
-	if ((adev->flags & AMD_IS_APU) && (adev->family >= AMDGPU_FAMILY_CZ) &&
-	    (attr == &sensor_dev_attr_temp1_crit.dev_attr.attr ||
-	     attr == &sensor_dev_attr_temp1_crit_hyst.dev_attr.attr))
-		return 0;
+	if ((adev->flags & AMD_IS_APU) &&
+	     (adev->family >= AMDGPU_FAMILY_CZ))
+		adev->pm.hwmon_if_supported &= ~(BIT_ULL(AMD_HWMON_IF_TEMP1_CRIT_BIT) |
+						 BIT_ULL(AMD_HWMON_IF_TEMP1_CRIT_HYST_BIT));
 
 	/* Skip limit attributes if DPM is not enabled */
-	if (!adev->pm.dpm_enabled &&
-	    (attr == &sensor_dev_attr_temp1_crit.dev_attr.attr ||
-	     attr == &sensor_dev_attr_temp1_crit_hyst.dev_attr.attr ||
-	     attr == &sensor_dev_attr_pwm1.dev_attr.attr ||
-	     attr == &sensor_dev_attr_pwm1_enable.dev_attr.attr ||
-	     attr == &sensor_dev_attr_pwm1_max.dev_attr.attr ||
-	     attr == &sensor_dev_attr_pwm1_min.dev_attr.attr ||
-	     attr == &sensor_dev_attr_fan1_input.dev_attr.attr ||
-	     attr == &sensor_dev_attr_fan1_min.dev_attr.attr ||
-	     attr == &sensor_dev_attr_fan1_max.dev_attr.attr ||
-	     attr == &sensor_dev_attr_fan1_target.dev_attr.attr ||
-	     attr == &sensor_dev_attr_fan1_enable.dev_attr.attr))
-		return 0;
+	if (!adev->pm.dpm_enabled)
+		adev->pm.hwmon_if_supported &= ~(BIT_ULL(AMD_HWMON_IF_TEMP1_CRIT_BIT) |
+						 BIT_ULL(AMD_HWMON_IF_TEMP1_CRIT_HYST_BIT) |
+						 BIT_ULL(AMD_HWMON_IF_PWM1_BIT) |
+						 BIT_ULL(AMD_HWMON_IF_PWM1_ENABLE_BIT) |
+						 BIT_ULL(AMD_HWMON_IF_PWM1_MAX_BIT) |
+						 BIT_ULL(AMD_HWMON_IF_PWM1_MIN_BIT) |
+						 BIT_ULL(AMD_HWMON_IF_FAN1_INPUT_BIT) |
+						 BIT_ULL(AMD_HWMON_IF_FAN1_MIN_BIT) |
+						 BIT_ULL(AMD_HWMON_IF_FAN1_MAX_BIT) |
+						 BIT_ULL(AMD_HWMON_IF_FAN1_TARGET_BIT) |
+						 BIT_ULL(AMD_HWMON_IF_FAN1_ENABLE_BIT));
 
 	/* mask fan attributes if we have no bindings for this asic to expose */
-	if (((amdgpu_dpm_get_fan_speed_pwm(adev, NULL) == -EOPNOTSUPP) &&
-	      attr == &sensor_dev_attr_pwm1.dev_attr.attr) || /* can't query fan */
-	    ((amdgpu_dpm_get_fan_control_mode(adev, NULL) == -EOPNOTSUPP) &&
-	     attr == &sensor_dev_attr_pwm1_enable.dev_attr.attr)) /* can't query state */
-		effective_mode &= ~S_IRUGO;
-
-	if (((amdgpu_dpm_set_fan_speed_pwm(adev, U32_MAX) == -EOPNOTSUPP) &&
-	      attr == &sensor_dev_attr_pwm1.dev_attr.attr) || /* can't manage fan */
-	      ((amdgpu_dpm_set_fan_control_mode(adev, U32_MAX) == -EOPNOTSUPP) &&
-	      attr == &sensor_dev_attr_pwm1_enable.dev_attr.attr)) /* can't manage state */
-		effective_mode &= ~S_IWUSR;
+	if (amdgpu_dpm_get_fan_speed_pwm(adev, NULL) == -EOPNOTSUPP)
+		adev->pm.hwmon_if_attr_mode[AMD_HWMON_IF_PWM1_BIT] &= ~S_IRUGO;
+	if (amdgpu_dpm_get_fan_control_mode(adev, NULL) == -EOPNOTSUPP)
+		adev->pm.hwmon_if_attr_mode[AMD_HWMON_IF_PWM1_ENABLE_BIT] &= ~S_IRUGO;
+	if (amdgpu_dpm_set_fan_speed_pwm(adev, U32_MAX) == -EOPNOTSUPP)
+		adev->pm.hwmon_if_attr_mode[AMD_HWMON_IF_PWM1_BIT] &= ~S_IWUSR;
+	if (amdgpu_dpm_set_fan_control_mode(adev, U32_MAX) == -EOPNOTSUPP)
+		adev->pm.hwmon_if_attr_mode[AMD_HWMON_IF_PWM1_ENABLE_BIT] &= ~S_IWUSR;
 
 	/* not implemented yet for GC 10.3.1 APUs */
-	if (((adev->family == AMDGPU_FAMILY_SI) ||
-	     ((adev->flags & AMD_IS_APU) && (gc_ver != IP_VERSION(10, 3, 1)))) &&
-	    (attr == &sensor_dev_attr_power1_cap_max.dev_attr.attr ||
-	     attr == &sensor_dev_attr_power1_cap_min.dev_attr.attr ||
-	     attr == &sensor_dev_attr_power1_cap.dev_attr.attr ||
-	     attr == &sensor_dev_attr_power1_cap_default.dev_attr.attr))
-		return 0;
+	if ((adev->family == AMDGPU_FAMILY_SI) ||
+	     ((adev->flags & AMD_IS_APU) && (gc_ver != IP_VERSION(10, 3, 1))))
+		adev->pm.hwmon_if_supported &= ~(BIT_ULL(AMD_HWMON_IF_POWER1_CAP_MAX_BIT) |
+						 BIT_ULL(AMD_HWMON_IF_POWER1_CAP_MIN_BIT) |
+						 BIT_ULL(AMD_HWMON_IF_POWER1_CAP_BIT) |
+						 BIT_ULL(AMD_HWMON_IF_POWER1_CAP_DEFAULT_BIT));
 
 	/* not implemented yet for APUs having <= GC 9.3.0 */
-	if (((adev->family == AMDGPU_FAMILY_SI) ||
-	     ((adev->flags & AMD_IS_APU) && (gc_ver < IP_VERSION(9, 3, 0)))) &&
-	    (attr == &sensor_dev_attr_power1_average.dev_attr.attr))
-		return 0;
+	if ((adev->family == AMDGPU_FAMILY_SI) ||
+	     ((adev->flags & AMD_IS_APU) && (gc_ver < IP_VERSION(9, 3, 0))))
+		adev->pm.hwmon_if_supported &= ~BIT_ULL(AMD_HWMON_IF_POWER1_AVERAGE_BIT);
 
 	/* hide max/min values if we can't both query and manage the fan */
-	if (((amdgpu_dpm_set_fan_speed_pwm(adev, U32_MAX) == -EOPNOTSUPP) &&
-	      (amdgpu_dpm_get_fan_speed_pwm(adev, NULL) == -EOPNOTSUPP) &&
-	      (amdgpu_dpm_set_fan_speed_rpm(adev, U32_MAX) == -EOPNOTSUPP) &&
-	      (amdgpu_dpm_get_fan_speed_rpm(adev, NULL) == -EOPNOTSUPP)) &&
-	    (attr == &sensor_dev_attr_pwm1_max.dev_attr.attr ||
-	     attr == &sensor_dev_attr_pwm1_min.dev_attr.attr))
-		return 0;
+	if ((amdgpu_dpm_set_fan_speed_pwm(adev, U32_MAX) == -EOPNOTSUPP) &&
+	     (amdgpu_dpm_get_fan_speed_pwm(adev, NULL) == -EOPNOTSUPP) &&
+	     (amdgpu_dpm_set_fan_speed_rpm(adev, U32_MAX) == -EOPNOTSUPP) &&
+	     (amdgpu_dpm_get_fan_speed_rpm(adev, NULL) == -EOPNOTSUPP))
+		adev->pm.hwmon_if_supported &= ~(BIT_ULL(AMD_HWMON_IF_PWM1_MAX_BIT) |
+						 BIT_ULL(AMD_HWMON_IF_PWM1_MIN_BIT));
 
 	if ((amdgpu_dpm_set_fan_speed_rpm(adev, U32_MAX) == -EOPNOTSUPP) &&
-	     (amdgpu_dpm_get_fan_speed_rpm(adev, NULL) == -EOPNOTSUPP) &&
-	     (attr == &sensor_dev_attr_fan1_max.dev_attr.attr ||
-	     attr == &sensor_dev_attr_fan1_min.dev_attr.attr))
-		return 0;
+	     (amdgpu_dpm_get_fan_speed_rpm(adev, NULL) == -EOPNOTSUPP))
+		adev->pm.hwmon_if_supported &= ~(BIT_ULL(AMD_HWMON_IF_FAN1_MAX_BIT) |
+						 BIT_ULL(AMD_HWMON_IF_FAN1_MIN_BIT));
 
-	if ((adev->family == AMDGPU_FAMILY_SI ||	/* not implemented yet */
-	     adev->family == AMDGPU_FAMILY_KV) &&	/* not implemented yet */
-	    (attr == &sensor_dev_attr_in0_input.dev_attr.attr ||
-	     attr == &sensor_dev_attr_in0_label.dev_attr.attr))
-		return 0;
+	if (adev->family == AMDGPU_FAMILY_SI ||
+	    adev->family == AMDGPU_FAMILY_KV)
+		adev->pm.hwmon_if_supported &= ~(BIT_ULL(AMD_HWMON_IF_IN0_INPUT_BIT) |
+						 BIT_ULL(AMD_HWMON_IF_IN0_LABEL_BIT));
 
 	/* only APUs have vddnb */
-	if (!(adev->flags & AMD_IS_APU) &&
-	    (attr == &sensor_dev_attr_in1_input.dev_attr.attr ||
-	     attr == &sensor_dev_attr_in1_label.dev_attr.attr))
-		return 0;
+	if (!(adev->flags & AMD_IS_APU))
+		adev->pm.hwmon_if_supported &= ~(BIT_ULL(AMD_HWMON_IF_IN1_INPUT_BIT) |
+						 BIT_ULL(AMD_HWMON_IF_IN1_LABEL_BIT));
 
 	/* no mclk on APUs */
-	if ((adev->flags & AMD_IS_APU) &&
-	    (attr == &sensor_dev_attr_freq2_input.dev_attr.attr ||
-	     attr == &sensor_dev_attr_freq2_label.dev_attr.attr))
-		return 0;
+	if (adev->flags & AMD_IS_APU)
+		adev->pm.hwmon_if_supported &= ~(BIT_ULL(AMD_HWMON_IF_FREQ2_INPUT_BIT) |
+						 BIT_ULL(AMD_HWMON_IF_FREQ2_LABEL_BIT));
 
 	/* only SOC15 dGPUs support hotspot and mem temperatures */
-	if (((adev->flags & AMD_IS_APU) || gc_ver < IP_VERSION(9, 0, 0)) &&
-	    (attr == &sensor_dev_attr_temp2_crit.dev_attr.attr ||
-	     attr == &sensor_dev_attr_temp2_crit_hyst.dev_attr.attr ||
-	     attr == &sensor_dev_attr_temp3_crit.dev_attr.attr ||
-	     attr == &sensor_dev_attr_temp3_crit_hyst.dev_attr.attr ||
-	     attr == &sensor_dev_attr_temp1_emergency.dev_attr.attr ||
-	     attr == &sensor_dev_attr_temp2_emergency.dev_attr.attr ||
-	     attr == &sensor_dev_attr_temp3_emergency.dev_attr.attr ||
-	     attr == &sensor_dev_attr_temp2_input.dev_attr.attr ||
-	     attr == &sensor_dev_attr_temp3_input.dev_attr.attr ||
-	     attr == &sensor_dev_attr_temp2_label.dev_attr.attr ||
-	     attr == &sensor_dev_attr_temp3_label.dev_attr.attr))
-		return 0;
+	if ((adev->flags & AMD_IS_APU) ||
+	     gc_ver < IP_VERSION(9, 0, 0))
+		adev->pm.hwmon_if_supported &= ~(BIT_ULL(AMD_HWMON_IF_TEMP2_CRIT_BIT) |
+						 BIT_ULL(AMD_HWMON_IF_TEMP2_CRIT_HYST_BIT) |
+						 BIT_ULL(AMD_HWMON_IF_TEMP3_CRIT_BIT) |
+						 BIT_ULL(AMD_HWMON_IF_TEMP3_CRIT_HYST_BIT) |
+						 BIT_ULL(AMD_HWMON_IF_TEMP1_EMERGENCY_BIT) |
+						 BIT_ULL(AMD_HWMON_IF_TEMP2_EMERGENCY_BIT) |
+						 BIT_ULL(AMD_HWMON_IF_TEMP3_EMERGENCY_BIT) |
+						 BIT_ULL(AMD_HWMON_IF_TEMP2_INPUT_BIT) |
+						 BIT_ULL(AMD_HWMON_IF_TEMP3_INPUT_BIT) |
+						 BIT_ULL(AMD_HWMON_IF_TEMP2_LABEL_BIT) |
+						 BIT_ULL(AMD_HWMON_IF_TEMP3_LABEL_BIT));
 
 	/* only Vangogh has fast PPT limit and power labels */
-	if (!(gc_ver == IP_VERSION(10, 3, 1)) &&
-	    (attr == &sensor_dev_attr_power2_average.dev_attr.attr ||
-	     attr == &sensor_dev_attr_power2_cap_max.dev_attr.attr ||
-	     attr == &sensor_dev_attr_power2_cap_min.dev_attr.attr ||
-	     attr == &sensor_dev_attr_power2_cap.dev_attr.attr ||
-	     attr == &sensor_dev_attr_power2_cap_default.dev_attr.attr ||
-	     attr == &sensor_dev_attr_power2_label.dev_attr.attr))
-		return 0;
-
-	return effective_mode;
+	if (gc_ver != IP_VERSION(10, 3, 1))
+		adev->pm.hwmon_if_supported &= ~(BIT_ULL(AMD_HWMON_IF_POWER2_AVERAGE_BIT) |
+						 BIT_ULL(AMD_HWMON_IF_POWER2_CAP_MAX_BIT) |
+						 BIT_ULL(AMD_HWMON_IF_POWER2_CAP_MIN_BIT) |
+						 BIT_ULL(AMD_HWMON_IF_POWER2_CAP_BIT) |
+						 BIT_ULL(AMD_HWMON_IF_POWER2_CAP_DEFAULT_BIT) |
+						 BIT_ULL(AMD_HWMON_IF_POWER2_LABEL_BIT));
 }
 
-static const struct attribute_group hwmon_attrgroup = {
-	.attrs = hwmon_attributes,
-	.is_visible = hwmon_attributes_visible,
-};
-
-static const struct attribute_group *hwmon_groups[] = {
-	&hwmon_attrgroup,
-	NULL
-};
-
 static void amdgpu_sysfs_if_support_check(struct amdgpu_device *adev)
 {
 	uint64_t *sysfs_if_supported = &adev->pm.sysfs_if_supported;
@@ -3418,6 +3499,8 @@ int amdgpu_pm_sysfs_init(struct amdgpu_device *adev)
 	if (adev->pm.dpm_enabled == 0)
 		return 0;
 
+	amdgpu_hwmon_if_support_check(adev);
+
 	amdgpu_sysfs_if_support_check(adev);
 
 	adev->pm.int_hwmon_dev = hwmon_device_register_with_groups(adev->dev,
-- 
2.34.1

