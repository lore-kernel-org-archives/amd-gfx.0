Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88DDBC4708D
	for <amd-gfx@archiver.kernel.org>; Thu,  5 Jan 2023 03:23:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 33C3810E62A;
	Thu,  5 Jan 2023 03:23:27 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2048.outbound.protection.outlook.com [40.107.92.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0BF7810E62A
 for <amd-gfx@lists.freedesktop.org>; Thu,  5 Jan 2023 03:23:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZbgVbfq8NWIOP0rQ2Z4YYdsKfGU4Z1vtevv6i8FoxTXiuxLVECM9IGHHQ7Nxc4JmA3u6+nUAKHmleMOCiELxyova6CrD8IbzRClQa6iOXxLMOvjXfZLWFVhXOZjvloVBtmgCFWzyRXeH7rzFdqUarnyi0XrdNsOwk4fwPjaBB8IJZidr0bjjTcL2/9YB/mEIXd461HJMxPJiU1knnng6imEnUE1qWUeG9NpmHH9fdZWJbt+BZmv7DUEtGa0Ipy4B4BJfoMYR7Oo/hxlsaRswYXHLvNhuy44RYyD4rnr/iCSG9/1FoshAXGXjJv1aCSFtHP0I7ffrTx/RXxAflMNUzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FfxlXafYRlTuguj6HYKDvgf67iOBfqxUqipF7H1gOI4=;
 b=DtugDEFRCPw3gsEugONMPx/8GqXpNsPhw2OCSY2DY/lwsQzY33p/jgR1aeuq7UmS2SA6IQThwYVUgV6k5wgmrOMYhI+haAtNBBQfa3qUdx3lVUrQX45+nue6N4R9zCcr+V9YzY1c6hJUH/uz9CcaiU4o1BJ8oJT5cwB3WtuMQeNAQUuPXMw7G2SBU4OL0gmXmeHebyBj390wEoKIWrP4g8OU99cTYXJVA+XAhxXAVhVb0Pl1clTMeSlpp+ul60hw3IqGV4Drz6XEXbWX6qpH+7kuuG/ppQmEdWJ28+i7sAeB+C3cjVUq5dgNgq93jsczCkkE7NYKC05c/QaQ8c4LuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FfxlXafYRlTuguj6HYKDvgf67iOBfqxUqipF7H1gOI4=;
 b=LUAje/RHCbm4QTwQMYQd5m+SExcWicEcr5QF9LeLXdfS0ObJyaiCN/fPYyFnFX53XtwwkAhG2qUvs91rRgpql8N5ONpdnqDWf382DcoR7brf26d0lAanOCP2wc94Trv5RiI3+ZSuePZVgtHhwM6whGEzQg3Uteeos7Fl//ADfeo=
Received: from BN9PR03CA0603.namprd03.prod.outlook.com (2603:10b6:408:106::8)
 by IA1PR12MB7566.namprd12.prod.outlook.com (2603:10b6:208:42e::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.19; Thu, 5 Jan
 2023 03:23:21 +0000
Received: from BN8NAM11FT094.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:106:cafe::78) by BN9PR03CA0603.outlook.office365.com
 (2603:10b6:408:106::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.14 via Frontend
 Transport; Thu, 5 Jan 2023 03:23:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT094.mail.protection.outlook.com (10.13.176.131) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5944.17 via Frontend Transport; Thu, 5 Jan 2023 03:23:21 +0000
Received: from equan-buildpc.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 4 Jan
 2023 21:23:18 -0600
From: Evan Quan <evan.quan@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/8] drm/amdgpu: add bitmask controll for power related sysfs
 interfaces
Date: Thu, 5 Jan 2023 11:22:52 +0800
Message-ID: <20230105032259.2032789-1-evan.quan@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT094:EE_|IA1PR12MB7566:EE_
X-MS-Office365-Filtering-Correlation-Id: 9ddb5591-8f75-4c82-290a-08daeecc329d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1cDaXkWv0/89U0BzohFvN95kzWpyOoGRMopORzo1RjH6J6hJAZtM9stfJKl4vdDtFQ12cYi2RU7+BFYjvNLiNaqiPFykHsNpbHZQpMWi7oJ7QBjGRdVykZIXV6/9vbGewqvs2tf6yNPPkDQb/l8LviyDGi2GOz242p705hyCW2Q1bxjLgaW5/f1ksYipXlLEq/mXkT1wAlWKQWKogmGNZaXHfIQi8abg55OFba+mnbPFIaHx1yjvqHT+FfwHUb5G+VBwBKfczoNHz3L1pux7hBKAsiwH1aQsQf+zpPOErGxIPUscg5ImgVPFj1GzDuRePbUbsjLTavCtLMVXWpzF5TJYNECCUk54IAwAqKWnf1VM5Uk/wmhJbrE653qwwjTKjRnI4gwiUbmPM4bHuPuQQK8cqJsabluris5r2Wi/DlSbHZChXPbFOgk4Gr8XMCh3ZRQ2RDUKKz21k0+uzr3ufBVZDgwvP9SIg898j7QlS8oiMZHMA98XEHB0b98lgzFgaSauETLWyZw35rhUiV2YuHzPW6dZ3WXQJgoNa3/76S1YUM5Ox0cSwODdyn3eXyaiTc+sRmZibcgSflZ03IoyoJDUeG8Ea+Go6FfSlpMSZn0Xd69OX0ixk2lEuCXKAWgnFW83aLxxnHla3673d00FY6WbqT+NsuLYaNeDHzvjGxpKrrSLVHYj3SVWmKbcd0E+SbSBHTdbJY6tmaZPS2rXxsiy7D8nIRrqOE5Qhz4x7JQ=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(346002)(396003)(39860400002)(376002)(136003)(451199015)(40470700004)(36840700001)(46966006)(40460700003)(5660300002)(8676002)(316002)(70586007)(70206006)(6666004)(4326008)(41300700001)(8936002)(7696005)(2906002)(6916009)(54906003)(478600001)(30864003)(356005)(336012)(81166007)(82740400003)(186003)(1076003)(426003)(47076005)(16526019)(26005)(2616005)(36860700001)(36756003)(40480700001)(44832011)(86362001)(82310400005)(83380400001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jan 2023 03:23:21.5777 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ddb5591-8f75-4c82-290a-08daeecc329d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT094.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7566
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
sysfs interface can be greatly simplified.

Signed-off-by: Evan Quan <evan.quan@amd.com>
Change-Id: Ica470cb8afd5b6cf7cc2a47b8310746b6c3b6f97
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c |   9 ++
 drivers/gpu/drm/amd/pm/amdgpu_pm.c         | 115 +++++++++++++++------
 drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h    |  37 +++++++
 drivers/gpu/drm/amd/pm/inc/amdgpu_pm.h     |  16 +--
 4 files changed, 141 insertions(+), 36 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 2017b3466612..b1943336551f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -3639,6 +3639,15 @@ int amdgpu_device_init(struct amdgpu_device *adev,
 	ratelimit_state_init(&adev->throttling_logging_rs, (60 - 1) * HZ, 1);
 	ratelimit_set_flags(&adev->throttling_logging_rs, RATELIMIT_MSG_ON_RELEASE);
 
+	/*
+	 * At default, all sysfs interfaces are claimed to be supported.
+	 * And every sysfs interface is readable and writable. However,
+	 * each ASIC can have its own setting by overriding these.
+	 */
+	adev->pm.sysfs_if_supported = AMD_SYSFS_IF_BITMASK_ALL_SUPPORTED;
+	for (i = 0; i < AMD_MAX_NUMBER_OF_SYSFS_IF_SUPPORTED; i++)
+		adev->pm.sysfs_if_attr_mode[i] = S_IRUGO | S_IWUGO;
+
 	/* Registers mapping */
 	/* TODO: block userspace mapping of io register */
 	if (adev->asic_type >= CHIP_BONAIRE) {
diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
index 236657eece47..fb6a7d45693a 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
@@ -1913,36 +1913,92 @@ static int ss_bias_attr_update(struct amdgpu_device *adev, struct amdgpu_device_
 }
 
 static struct amdgpu_device_attr amdgpu_device_attrs[] = {
-	AMDGPU_DEVICE_ATTR_RW(power_dpm_state,				ATTR_FLAG_BASIC|ATTR_FLAG_ONEVF),
-	AMDGPU_DEVICE_ATTR_RW(power_dpm_force_performance_level,	ATTR_FLAG_BASIC|ATTR_FLAG_ONEVF),
-	AMDGPU_DEVICE_ATTR_RO(pp_num_states,				ATTR_FLAG_BASIC|ATTR_FLAG_ONEVF),
-	AMDGPU_DEVICE_ATTR_RO(pp_cur_state,				ATTR_FLAG_BASIC|ATTR_FLAG_ONEVF),
-	AMDGPU_DEVICE_ATTR_RW(pp_force_state,				ATTR_FLAG_BASIC|ATTR_FLAG_ONEVF),
-	AMDGPU_DEVICE_ATTR_RW(pp_table,					ATTR_FLAG_BASIC|ATTR_FLAG_ONEVF),
-	AMDGPU_DEVICE_ATTR_RW(pp_dpm_sclk,				ATTR_FLAG_BASIC|ATTR_FLAG_ONEVF),
-	AMDGPU_DEVICE_ATTR_RW(pp_dpm_mclk,				ATTR_FLAG_BASIC|ATTR_FLAG_ONEVF),
-	AMDGPU_DEVICE_ATTR_RW(pp_dpm_socclk,				ATTR_FLAG_BASIC|ATTR_FLAG_ONEVF),
-	AMDGPU_DEVICE_ATTR_RW(pp_dpm_fclk,				ATTR_FLAG_BASIC|ATTR_FLAG_ONEVF),
-	AMDGPU_DEVICE_ATTR_RW(pp_dpm_vclk,				ATTR_FLAG_BASIC|ATTR_FLAG_ONEVF),
-	AMDGPU_DEVICE_ATTR_RW(pp_dpm_dclk,				ATTR_FLAG_BASIC|ATTR_FLAG_ONEVF),
-	AMDGPU_DEVICE_ATTR_RW(pp_dpm_dcefclk,				ATTR_FLAG_BASIC|ATTR_FLAG_ONEVF),
-	AMDGPU_DEVICE_ATTR_RW(pp_dpm_pcie,				ATTR_FLAG_BASIC|ATTR_FLAG_ONEVF),
-	AMDGPU_DEVICE_ATTR_RW(pp_sclk_od,				ATTR_FLAG_BASIC),
-	AMDGPU_DEVICE_ATTR_RW(pp_mclk_od,				ATTR_FLAG_BASIC),
-	AMDGPU_DEVICE_ATTR_RW(pp_power_profile_mode,			ATTR_FLAG_BASIC|ATTR_FLAG_ONEVF),
-	AMDGPU_DEVICE_ATTR_RW(pp_od_clk_voltage,			ATTR_FLAG_BASIC),
-	AMDGPU_DEVICE_ATTR_RO(gpu_busy_percent,				ATTR_FLAG_BASIC|ATTR_FLAG_ONEVF),
-	AMDGPU_DEVICE_ATTR_RO(mem_busy_percent,				ATTR_FLAG_BASIC|ATTR_FLAG_ONEVF),
-	AMDGPU_DEVICE_ATTR_RO(pcie_bw,					ATTR_FLAG_BASIC),
-	AMDGPU_DEVICE_ATTR_RW(pp_features,				ATTR_FLAG_BASIC|ATTR_FLAG_ONEVF),
-	AMDGPU_DEVICE_ATTR_RO(unique_id,				ATTR_FLAG_BASIC|ATTR_FLAG_ONEVF),
-	AMDGPU_DEVICE_ATTR_RW(thermal_throttling_logging,		ATTR_FLAG_BASIC|ATTR_FLAG_ONEVF),
-	AMDGPU_DEVICE_ATTR_RO(gpu_metrics,				ATTR_FLAG_BASIC|ATTR_FLAG_ONEVF),
-	AMDGPU_DEVICE_ATTR_RO(smartshift_apu_power,			ATTR_FLAG_BASIC,
+	AMDGPU_DEVICE_ATTR_RW(power_dpm_state,
+			      AMD_SYSFS_IF_POWER_DPM_STATE_BIT,
+			      ATTR_FLAG_BASIC|ATTR_FLAG_ONEVF),
+	AMDGPU_DEVICE_ATTR_RW(power_dpm_force_performance_level,
+			      AMD_SYSFS_IF_POWER_DPM_FORCE_PERFORMANCE_LEVEL_BIT,
+			      ATTR_FLAG_BASIC|ATTR_FLAG_ONEVF),
+	AMDGPU_DEVICE_ATTR_RO(pp_num_states,
+			      AMD_SYSFS_IF_PP_NUM_STATES_BIT,
+			      ATTR_FLAG_BASIC|ATTR_FLAG_ONEVF),
+	AMDGPU_DEVICE_ATTR_RO(pp_cur_state,
+			      AMD_SYSFS_IF_PP_CUR_STATE_BIT,
+			      ATTR_FLAG_BASIC|ATTR_FLAG_ONEVF),
+	AMDGPU_DEVICE_ATTR_RW(pp_force_state,
+			      AMD_SYSFS_IF_PP_FORCE_STATE_BIT,
+			      ATTR_FLAG_BASIC|ATTR_FLAG_ONEVF),
+	AMDGPU_DEVICE_ATTR_RW(pp_table,
+			      AMD_SYSFS_IF_PP_TABLE_BIT,
+			      ATTR_FLAG_BASIC|ATTR_FLAG_ONEVF),
+	AMDGPU_DEVICE_ATTR_RW(pp_dpm_sclk,
+			      AMD_SYSFS_IF_PP_DPM_SCLK_BIT,
+			      ATTR_FLAG_BASIC|ATTR_FLAG_ONEVF),
+	AMDGPU_DEVICE_ATTR_RW(pp_dpm_mclk,
+			      AMD_SYSFS_IF_PP_DPM_MCLK_BIT,
+			      ATTR_FLAG_BASIC|ATTR_FLAG_ONEVF),
+	AMDGPU_DEVICE_ATTR_RW(pp_dpm_socclk,
+			      AMD_SYSFS_IF_PP_DPM_SOCCLK_BIT,
+			      ATTR_FLAG_BASIC|ATTR_FLAG_ONEVF),
+	AMDGPU_DEVICE_ATTR_RW(pp_dpm_fclk,
+			      AMD_SYSFS_IF_PP_DPM_FCLK_BIT,
+			      ATTR_FLAG_BASIC|ATTR_FLAG_ONEVF),
+	AMDGPU_DEVICE_ATTR_RW(pp_dpm_vclk,
+			      AMD_SYSFS_IF_PP_DPM_VCLK_BIT,
+			      ATTR_FLAG_BASIC|ATTR_FLAG_ONEVF),
+	AMDGPU_DEVICE_ATTR_RW(pp_dpm_dclk,
+			      AMD_SYSFS_IF_PP_DPM_DCLK_BIT,
+			      ATTR_FLAG_BASIC|ATTR_FLAG_ONEVF),
+	AMDGPU_DEVICE_ATTR_RW(pp_dpm_dcefclk,
+			      AMD_SYSFS_IF_PP_DPM_DCEFCLK_BIT,
+			      ATTR_FLAG_BASIC|ATTR_FLAG_ONEVF),
+	AMDGPU_DEVICE_ATTR_RW(pp_dpm_pcie,
+			      AMD_SYSFS_IF_PP_DPM_PCIE_BIT,
+			      ATTR_FLAG_BASIC|ATTR_FLAG_ONEVF),
+	AMDGPU_DEVICE_ATTR_RW(pp_sclk_od,
+			      AMD_SYSFS_IF_PP_SCLK_OD_BIT,
+			      ATTR_FLAG_BASIC),
+	AMDGPU_DEVICE_ATTR_RW(pp_mclk_od,
+			      AMD_SYSFS_IF_PP_MCLK_OD_BIT,
+			      ATTR_FLAG_BASIC),
+	AMDGPU_DEVICE_ATTR_RW(pp_power_profile_mode,
+			      AMD_SYSFS_IF_PP_POWER_PROFILE_MODE_BIT,
+			      ATTR_FLAG_BASIC|ATTR_FLAG_ONEVF),
+	AMDGPU_DEVICE_ATTR_RW(pp_od_clk_voltage,
+			      AMD_SYSFS_IF_PP_OD_CLK_VOLTAGE_BIT,
+			      ATTR_FLAG_BASIC),
+	AMDGPU_DEVICE_ATTR_RO(gpu_busy_percent,
+			      AMD_SYSFS_IF_GPU_BUSY_PERCENT_BIT,
+			      ATTR_FLAG_BASIC|ATTR_FLAG_ONEVF),
+	AMDGPU_DEVICE_ATTR_RO(mem_busy_percent,
+			      AMD_SYSFS_IF_MEM_BUSY_PERCENT_BIT,
+			      ATTR_FLAG_BASIC|ATTR_FLAG_ONEVF),
+	AMDGPU_DEVICE_ATTR_RO(pcie_bw,
+			      AMD_SYSFS_IF_PCIE_BW_BIT,
+			      ATTR_FLAG_BASIC),
+	AMDGPU_DEVICE_ATTR_RW(pp_features,
+			      AMD_SYSFS_IF_PP_FEATURES_BIT,
+			      ATTR_FLAG_BASIC|ATTR_FLAG_ONEVF),
+	AMDGPU_DEVICE_ATTR_RO(unique_id,
+			      AMD_SYSFS_IF_UNIQUE_ID_BIT,
+			      ATTR_FLAG_BASIC|ATTR_FLAG_ONEVF),
+	AMDGPU_DEVICE_ATTR_RW(thermal_throttling_logging,
+			      AMD_SYSFS_IF_THERMAL_THROTTLING_LOGGING_BIT,
+			      ATTR_FLAG_BASIC|ATTR_FLAG_ONEVF),
+	AMDGPU_DEVICE_ATTR_RO(gpu_metrics,
+			      AMD_SYSFS_IF_GPU_METRICS_BIT,
+			      ATTR_FLAG_BASIC|ATTR_FLAG_ONEVF),
+	AMDGPU_DEVICE_ATTR_RO(smartshift_apu_power,
+			      AMD_SYSFS_IF_SMARTSHIFT_APU_POWER_BIT,
+			      ATTR_FLAG_BASIC,
 			      .attr_update = ss_power_attr_update),
-	AMDGPU_DEVICE_ATTR_RO(smartshift_dgpu_power,			ATTR_FLAG_BASIC,
+	AMDGPU_DEVICE_ATTR_RO(smartshift_dgpu_power,
+			      AMD_SYSFS_IF_SMARTSHIFT_DGPU_POWER_BIT,
+			      ATTR_FLAG_BASIC,
 			      .attr_update = ss_power_attr_update),
-	AMDGPU_DEVICE_ATTR_RW(smartshift_bias,				ATTR_FLAG_BASIC,
+	AMDGPU_DEVICE_ATTR_RW(smartshift_bias,
+			      AMD_SYSFS_IF_SMARTSHIFT_BIAS_BIT,
+			      ATTR_FLAG_BASIC,
 			      .attr_update = ss_bias_attr_update),
 };
 
@@ -1954,7 +2010,8 @@ static int default_attr_update(struct amdgpu_device *adev, struct amdgpu_device_
 	uint32_t gc_ver = adev->ip_versions[GC_HWIP][0];
 	const char *attr_name = dev_attr->attr.name;
 
-	if (!(attr->flags & mask)) {
+	if (!(attr->flags & mask) ||
+	      !(AMD_SYSFS_IF_BITMASK(attr->if_bit) & adev->pm.sysfs_if_supported))  {
 		*states = ATTR_STATE_UNSUPPORTED;
 		return 0;
 	}
diff --git a/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h b/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
index cb5b9df78b4d..bbee77087226 100644
--- a/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
+++ b/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
@@ -312,6 +312,39 @@ struct config_table_setting
 	uint16_t fclk_average_tau;
 };
 
+/* Bitmasks for controlling which Sysfs interface to support */
+#define AMD_SYSFS_IF_POWER_DPM_STATE_BIT			0U
+#define AMD_SYSFS_IF_POWER_DPM_FORCE_PERFORMANCE_LEVEL_BIT	1U
+#define AMD_SYSFS_IF_PP_NUM_STATES_BIT				2U
+#define AMD_SYSFS_IF_PP_CUR_STATE_BIT				3U
+#define AMD_SYSFS_IF_PP_FORCE_STATE_BIT				4U
+#define AMD_SYSFS_IF_PP_TABLE_BIT				5U
+#define AMD_SYSFS_IF_PP_DPM_SCLK_BIT				6U
+#define AMD_SYSFS_IF_PP_DPM_MCLK_BIT				7U
+#define AMD_SYSFS_IF_PP_DPM_SOCCLK_BIT				8U
+#define AMD_SYSFS_IF_PP_DPM_FCLK_BIT				9U
+#define AMD_SYSFS_IF_PP_DPM_VCLK_BIT				10U
+#define AMD_SYSFS_IF_PP_DPM_DCLK_BIT				11U
+#define AMD_SYSFS_IF_PP_DPM_DCEFCLK_BIT				12U
+#define AMD_SYSFS_IF_PP_DPM_PCIE_BIT				13U
+#define AMD_SYSFS_IF_PP_SCLK_OD_BIT				14U
+#define AMD_SYSFS_IF_PP_MCLK_OD_BIT				15U
+#define AMD_SYSFS_IF_PP_POWER_PROFILE_MODE_BIT			16U
+#define AMD_SYSFS_IF_PP_OD_CLK_VOLTAGE_BIT			17U
+#define AMD_SYSFS_IF_GPU_BUSY_PERCENT_BIT			18U
+#define AMD_SYSFS_IF_MEM_BUSY_PERCENT_BIT			19U
+#define AMD_SYSFS_IF_PCIE_BW_BIT				20U
+#define AMD_SYSFS_IF_PP_FEATURES_BIT				21U
+#define AMD_SYSFS_IF_UNIQUE_ID_BIT				22U
+#define AMD_SYSFS_IF_THERMAL_THROTTLING_LOGGING_BIT		23U
+#define AMD_SYSFS_IF_GPU_METRICS_BIT				24U
+#define AMD_SYSFS_IF_SMARTSHIFT_APU_POWER_BIT			25U
+#define AMD_SYSFS_IF_SMARTSHIFT_DGPU_POWER_BIT			26U
+#define AMD_SYSFS_IF_SMARTSHIFT_BIAS_BIT			27U
+#define AMD_MAX_NUMBER_OF_SYSFS_IF_SUPPORTED			64U
+#define AMD_SYSFS_IF_BITMASK(if_bit)				(1ULL << (if_bit))
+#define AMD_SYSFS_IF_BITMASK_ALL_SUPPORTED			ULLONG_MAX
+
 struct amdgpu_pm {
 	struct mutex		mutex;
 	u32                     current_sclk;
@@ -364,6 +397,10 @@ struct amdgpu_pm {
 	struct config_table_setting config_table;
 	/* runtime mode */
 	enum amdgpu_runpm_mode rpm_mode;
+
+	/* bitmasks for clarifying which sysfs interfaces supported */
+	uint64_t		sysfs_if_supported;
+	umode_t			sysfs_if_attr_mode[AMD_MAX_NUMBER_OF_SYSFS_IF_SUPPORTED];
 };
 
 int amdgpu_dpm_read_sensor(struct amdgpu_device *adev, enum amd_pp_sensors sensor,
diff --git a/drivers/gpu/drm/amd/pm/inc/amdgpu_pm.h b/drivers/gpu/drm/amd/pm/inc/amdgpu_pm.h
index 52045ad59bed..bffc1bc94641 100644
--- a/drivers/gpu/drm/amd/pm/inc/amdgpu_pm.h
+++ b/drivers/gpu/drm/amd/pm/inc/amdgpu_pm.h
@@ -46,6 +46,7 @@ enum amdgpu_device_attr_states {
 
 struct amdgpu_device_attr {
 	struct device_attribute dev_attr;
+	uint64_t if_bit;
 	enum amdgpu_device_attr_flags flags;
 	int (*attr_update)(struct amdgpu_device *adev, struct amdgpu_device_attr *attr,
 			   uint32_t mask, enum amdgpu_device_attr_states *states);
@@ -60,24 +61,25 @@ struct amdgpu_device_attr_entry {
 #define to_amdgpu_device_attr(_dev_attr) \
 	container_of(_dev_attr, struct amdgpu_device_attr, dev_attr)
 
-#define __AMDGPU_DEVICE_ATTR(_name, _mode, _show, _store, _flags, ...)	\
+#define __AMDGPU_DEVICE_ATTR(_name, _mode, _show, _store, _bit, _flags, ...)	\
 	{ .dev_attr = __ATTR(_name, _mode, _show, _store),		\
+	  .if_bit = _bit,					\
 	  .flags = _flags,						\
 	  ##__VA_ARGS__, }
 
-#define AMDGPU_DEVICE_ATTR(_name, _mode, _flags, ...)			\
+#define AMDGPU_DEVICE_ATTR(_name, _mode, _bit, _flags, ...)		\
 	__AMDGPU_DEVICE_ATTR(_name, _mode,				\
 			     amdgpu_get_##_name, amdgpu_set_##_name,	\
-			     _flags, ##__VA_ARGS__)
+			     _bit, _flags, ##__VA_ARGS__)
 
-#define AMDGPU_DEVICE_ATTR_RW(_name, _flags, ...)			\
+#define AMDGPU_DEVICE_ATTR_RW(_name, _bit, _flags, ...)		\
 	AMDGPU_DEVICE_ATTR(_name, S_IRUGO | S_IWUSR,			\
-			   _flags, ##__VA_ARGS__)
+			   _bit, _flags, ##__VA_ARGS__)
 
-#define AMDGPU_DEVICE_ATTR_RO(_name, _flags, ...)			\
+#define AMDGPU_DEVICE_ATTR_RO(_name, _bit, _flags, ...)		\
 	__AMDGPU_DEVICE_ATTR(_name, S_IRUGO,				\
 			     amdgpu_get_##_name, NULL,			\
-			     _flags, ##__VA_ARGS__)
+			     _bit, _flags, ##__VA_ARGS__)
 
 int amdgpu_pm_sysfs_init(struct amdgpu_device *adev);
 int amdgpu_pm_virt_sysfs_init(struct amdgpu_device *adev);
-- 
2.34.1

