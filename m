Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82746C4708D
	for <amd-gfx@archiver.kernel.org>; Thu,  5 Jan 2023 03:23:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 19AEF10E62E;
	Thu,  5 Jan 2023 03:23:30 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2075.outbound.protection.outlook.com [40.107.94.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D84B110E62B
 for <amd-gfx@lists.freedesktop.org>; Thu,  5 Jan 2023 03:23:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ggLEt2LNZG1irCTuAQ9Ffqyz2oE5dXvzdyT2MqOZ7o/y1mRXXHZH6Al/ncI0f9UFSydn3c5nKUzksOM4ZLz1cD/iCscleQQYK0wASicDNTp0Q6vHuyXSkrulWw0EnL5qXBfoRGO03CgAAeih9QTFb7L10bZQgldtmBAqpX+/OqcR0p7qtDbz21azB8+1JCHrDuiXgEoQl9RzqAnpaD3g4+HAnbi7JjHQQrJ0WtfuyD+PqIanC6c1Vc2Hj9zz4Bq9XFucMlMRzrdy8PCUx2mIgMyBWRS2//jEJyx1JfyukysXM5MoJDJKqULYp3aUI7h6nuxBzvRUfUvTRq88sMN1/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/k14noM7BclBBwHSfPVKaQdQrwCGoEbBBqeCWVb0Iec=;
 b=i3eRGn++hOtbltQPmUDE4dGV7vz8xHIN7spiU66zrDS22P18LOd1iLpKb4ytgiB9pGhe1t8uneJ4GdB/mtnSvmVEyko1pTiN16Sy82pSOYsb+j8k2pIJpt+aMiz2vruuteSy3faWycNpRDT5gN3SHh3sbqToyycXuw5oouUPxC6n7FygY4DE/IUp5aDcwfN7nU/DrQGEuKHuXySePPjVuyyvMSQb60Jz7Oh5vk6vsXnqvZlp99K3k8EdS+DUvFp4t5H6nxn3io43cGvcJwiGFtdusyS4rg05UZX2Ad5vZFao79hD5tPPDtXhI+Bo2BqoNn5b/qO260Y+rvNXb3dX/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/k14noM7BclBBwHSfPVKaQdQrwCGoEbBBqeCWVb0Iec=;
 b=l4EWrlGM1ewYBaDfJgfhoQCGWln59wqQRufFrOUbsCRxX7wv0OmwLgZ8mwNHo5ScLr4leYr/xtEZKQPHwvnjwplY0lZBuXEW5+swLt7SezPtqA4zMgSwfh2HCnTdXEdzD4UpMT4WL0eFEXILVxREFrWninxOAzncYzUDl9/O8T8=
Received: from BN0PR07CA0021.namprd07.prod.outlook.com (2603:10b6:408:141::16)
 by IA1PR12MB6331.namprd12.prod.outlook.com (2603:10b6:208:3e3::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.16; Thu, 5 Jan
 2023 03:23:25 +0000
Received: from BN8NAM11FT050.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:141:cafe::9d) by BN0PR07CA0021.outlook.office365.com
 (2603:10b6:408:141::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.14 via Frontend
 Transport; Thu, 5 Jan 2023 03:23:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT050.mail.protection.outlook.com (10.13.177.5) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5944.17 via Frontend Transport; Thu, 5 Jan 2023 03:23:25 +0000
Received: from equan-buildpc.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 4 Jan
 2023 21:23:23 -0600
From: Evan Quan <evan.quan@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 5/8] drm/amdgpu: add bitmask controll for hwmon related
 interfaces
Date: Thu, 5 Jan 2023 11:22:56 +0800
Message-ID: <20230105032259.2032789-5-evan.quan@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN8NAM11FT050:EE_|IA1PR12MB6331:EE_
X-MS-Office365-Filtering-Correlation-Id: 6f210c32-f3f7-421e-dd80-08daeecc34c8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UdTo4xsWrq0FGoV0qnkS2/yFHVjDLHUEHCajSGHH/lPNbvf7CPTUbmoPMYohH8VjHoK2A1K5RAfd69PL4CFzk+E6Ysuvl4yVmTwjvQbca3AAwRf7kp1VOnYZw3RX/+8Q4llbBclKcd8l5CW3QVbk/eCJRkhf/d8QvL3lS7HTCsMdhwuu7OTbQI4vhraxNET67WaozBlM/eWe7Wkb3OLpOvyDGVO9+0YR1KtVVpH9O1yGEwSxFTuvjfSGlljw38P0/iDayrBmeVCqhE3JYnKTSbqNO10WN2VfUUCuP/hc4jLpzcM8qoToTuzfciv5muxVyVsj9U6DznuNoK/5KjLAwj3x+AjyZKmcSoGRiI/YncniW3w1F86Al+JmhiRqYGnajfnBrhdmwJ9ymjFTkZ1MsSssYP5OUweLgbFbkQSq44Fs1JAUy9JpKu2ygldtBsZhm3g40U5GSMmZD4ZA88K5CSJJeXQUnShY6onr/B178rmN9QThtJTtnMQTuVtTCNXEU5ytVvCXCpgpr2oWCYuUrPCg0QqI0D9a5QG00stnZ8d7FHzqaPY1gqXmOl5jL7XeSpUp4PmV0yqmA7SWtGTS1Zp4DS07K6YplvEXkklBuVLNCOkI946mqwEEqdAkCHWhAfAu3182tHv6Sk1EPYKPeIETRYVqG17/fbPGAT+MWr6NS9onNfu6fsV4FsxusCRMqa6U7J2ymHZLcNv0I3EKLvrGOljY7/HVmkpFNWprYlQ=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(39860400002)(396003)(136003)(376002)(346002)(451199015)(36840700001)(46966006)(40470700004)(8676002)(70586007)(26005)(70206006)(44832011)(82740400003)(478600001)(316002)(86362001)(40460700003)(41300700001)(426003)(8936002)(82310400005)(40480700001)(47076005)(81166007)(83380400001)(6916009)(4326008)(356005)(16526019)(336012)(36756003)(5660300002)(54906003)(186003)(2616005)(2906002)(6666004)(1076003)(36860700001)(7696005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jan 2023 03:23:25.2195 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f210c32-f3f7-421e-dd80-08daeecc34c8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT050.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6331
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

Via this, the logic for adding/dropping the support for some specific
hwmon interface can be greatly simplified.

Signed-off-by: Evan Quan <evan.quan@amd.com>
Change-Id: Ia85082c964d80d1c43dd2d8bf51592aba968e364
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c |  7 ++-
 drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h    | 52 ++++++++++++++++++++++
 2 files changed, 57 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index b1943336551f..c7c95b3c370e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -3640,13 +3640,16 @@ int amdgpu_device_init(struct amdgpu_device *adev,
 	ratelimit_set_flags(&adev->throttling_logging_rs, RATELIMIT_MSG_ON_RELEASE);
 
 	/*
-	 * At default, all sysfs interfaces are claimed to be supported.
-	 * And every sysfs interface is readable and writable. However,
+	 * At default, all sysfs and hwmon interfaces are claimed to be supported.
+	 * And every interface is readable and writable. However,
 	 * each ASIC can have its own setting by overriding these.
 	 */
 	adev->pm.sysfs_if_supported = AMD_SYSFS_IF_BITMASK_ALL_SUPPORTED;
 	for (i = 0; i < AMD_MAX_NUMBER_OF_SYSFS_IF_SUPPORTED; i++)
 		adev->pm.sysfs_if_attr_mode[i] = S_IRUGO | S_IWUGO;
+	adev->pm.hwmon_if_supported = AMD_HWMON_IF_BITMASK_ALL_SUPPORTED;
+	for (i = 0; i < AMD_MAX_NUMBER_OF_HWMON_IF_SUPPORTED; i++)
+		adev->pm.hwmon_if_attr_mode[i] = S_IRUGO | S_IWUSR;
 
 	/* Registers mapping */
 	/* TODO: block userspace mapping of io register */
diff --git a/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h b/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
index bbee77087226..5635ac74bf62 100644
--- a/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
+++ b/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
@@ -345,6 +345,54 @@ struct config_table_setting
 #define AMD_SYSFS_IF_BITMASK(if_bit)				(1ULL << (if_bit))
 #define AMD_SYSFS_IF_BITMASK_ALL_SUPPORTED			ULLONG_MAX
 
+/* Bitmasks for controlling which hwmon interface to support */
+#define AMD_HWMON_IF_TEMP1_INPUT_BIT				0U
+#define AMD_HWMON_IF_TEMP1_CRIT_BIT				1U
+#define AMD_HWMON_IF_TEMP1_CRIT_HYST_BIT			2U
+#define AMD_HWMON_IF_TEMP2_INPUT_BIT				3U
+#define AMD_HWMON_IF_TEMP2_CRIT_BIT				4U
+#define AMD_HWMON_IF_TEMP2_CRIT_HYST_BIT			5U
+#define AMD_HWMON_IF_TEMP3_INPUT_BIT				6U
+#define AMD_HWMON_IF_TEMP3_CRIT_BIT				7U
+#define AMD_HWMON_IF_TEMP3_CRIT_HYST_BIT			8U
+#define AMD_HWMON_IF_TEMP1_EMERGENCY_BIT			9U
+#define AMD_HWMON_IF_TEMP2_EMERGENCY_BIT			10U
+#define AMD_HWMON_IF_TEMP3_EMERGENCY_BIT			11U
+#define AMD_HWMON_IF_TEMP1_LABEL_BIT				12U
+#define AMD_HWMON_IF_TEMP2_LABEL_BIT				13U
+#define AMD_HWMON_IF_TEMP3_LABEL_BIT				14U
+#define AMD_HWMON_IF_PWM1_BIT					15U
+#define AMD_HWMON_IF_PWM1_ENABLE_BIT				16U
+#define AMD_HWMON_IF_PWM1_MIN_BIT				17U
+#define AMD_HWMON_IF_PWM1_MAX_BIT				18U
+#define AMD_HWMON_IF_FAN1_INPUT_BIT				19U
+#define AMD_HWMON_IF_FAN1_MIN_BIT				20U
+#define AMD_HWMON_IF_FAN1_MAX_BIT				21U
+#define AMD_HWMON_IF_FAN1_TARGET_BIT				22U
+#define AMD_HWMON_IF_FAN1_ENABLE_BIT				23U
+#define AMD_HWMON_IF_IN0_INPUT_BIT				24U
+#define AMD_HWMON_IF_IN0_LABEL_BIT				25U
+#define AMD_HWMON_IF_IN1_INPUT_BIT				26U
+#define AMD_HWMON_IF_IN1_LABEL_BIT				27U
+#define AMD_HWMON_IF_POWER1_AVERAGE_BIT				28U
+#define AMD_HWMON_IF_POWER1_CAP_MAX_BIT				29U
+#define AMD_HWMON_IF_POWER1_CAP_MIN_BIT				30U
+#define AMD_HWMON_IF_POWER1_CAP_BIT				31U
+#define AMD_HWMON_IF_POWER1_CAP_DEFAULT_BIT			32U
+#define AMD_HWMON_IF_POWER1_LABEL_BIT				33U
+#define AMD_HWMON_IF_POWER2_AVERAGE_BIT				34U
+#define AMD_HWMON_IF_POWER2_CAP_MAX_BIT				35U
+#define AMD_HWMON_IF_POWER2_CAP_MIN_BIT				36U
+#define AMD_HWMON_IF_POWER2_CAP_BIT				37U
+#define AMD_HWMON_IF_POWER2_CAP_DEFAULT_BIT			38U
+#define AMD_HWMON_IF_POWER2_LABEL_BIT				39U
+#define AMD_HWMON_IF_FREQ1_INPUT_BIT				40U
+#define AMD_HWMON_IF_FREQ1_LABEL_BIT				41U
+#define AMD_HWMON_IF_FREQ2_INPUT_BIT				42U
+#define AMD_HWMON_IF_FREQ2_LABEL_BIT				43U
+#define AMD_MAX_NUMBER_OF_HWMON_IF_SUPPORTED			64U
+#define AMD_HWMON_IF_BITMASK_ALL_SUPPORTED			ULLONG_MAX
+
 struct amdgpu_pm {
 	struct mutex		mutex;
 	u32                     current_sclk;
@@ -401,6 +449,10 @@ struct amdgpu_pm {
 	/* bitmasks for clarifying which sysfs interfaces supported */
 	uint64_t		sysfs_if_supported;
 	umode_t			sysfs_if_attr_mode[AMD_MAX_NUMBER_OF_SYSFS_IF_SUPPORTED];
+
+	/* bitmasks for clarifying which hwmon interfaces supported */
+	uint64_t		hwmon_if_supported;
+	umode_t			hwmon_if_attr_mode[AMD_MAX_NUMBER_OF_HWMON_IF_SUPPORTED];
 };
 
 int amdgpu_dpm_read_sensor(struct amdgpu_device *adev, enum amd_pp_sensors sensor,
-- 
2.34.1

