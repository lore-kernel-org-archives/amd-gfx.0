Return-Path: <SRS0=majj=GJ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C1ACC433E0
	for <amd-gfx@archiver.kernel.org>; Wed,  6 Jan 2021 23:46:47 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E98BA2313E
	for <amd-gfx@archiver.kernel.org>; Wed,  6 Jan 2021 23:46:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E98BA2313E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9960C6E364;
	Wed,  6 Jan 2021 23:46:46 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr770050.outbound.protection.outlook.com [40.107.77.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6214D6E364
 for <amd-gfx@lists.freedesktop.org>; Wed,  6 Jan 2021 23:46:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DKl2dY9aL8M5HfoE6pVDQhH5u4ejS/NlWOtIEoEHDMxPWZrD4Fqe+bdDi3Aw+XycZ6bnEmG27JTVGbCSP6yAO45LeBxqykRjhvy7DrW5pYKGoQR9bO0jA/LFcDhrUUjG0PxTpXqePcqpmNKNCoZzDnNQndnPTyzyjMRnEJ4/nlJVp87VYlvVnoSM/34Z1qfsxxWZ282xEuoxWqgUG3mxWIjh+i19YmMzkDOEvkENbnsI7Y3hm2yT8b0WgdO8Aha+WMW1bXpJcCmG2VP6Em/vXSJ/u5eVURBueINPRRVtUISIfpRQ9xvCEg0rIRr4kPuX7ZO9gOvXwG/rbtkgxAcqpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=80BrF8aXIWwCtUodkerO29SHASjf6zBB7y/HQvSDB1s=;
 b=TFfPG5y8m5TeBCpciC+UGRUXoluHUz0JD6m8mozDQxPnrHgIu8HNj/dDl/tSWsLKX3nU3w9l0eo+bx5SFVRVkLoGF16ibud0ICpnE8wl8fsUchmFgp8vQ7vUTXNPPPVRpgdpU3ctYgUheUNWUt5+Qy3OFYYQlRc3Szc4p6QeNTGr31unummjfKgXYeqo3LujCTJjP+nubammC24Yul1JzRQCiPYSbJoa8bxIJkKzDE/Wp4kAFE/B2SjT3fkqU1WB0x18Kyr1jOZeFrkA6jg2K/O8Zf08AAdM7my8Ow3lolY0gz/lDa8FTTQqeFOEyx+2ZwaEU6aFqV9L4EOB4xGbdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=80BrF8aXIWwCtUodkerO29SHASjf6zBB7y/HQvSDB1s=;
 b=OzuoJBgoDO2CWvGUrs2KHWpvQFRdPoEvxMvdS/kGN/HkQPF9z4H+dVM+amHR5Ua3IYP+KrYY4KbrYmhg4LREhTMiHUL7iCKZFef1BbYuVKpAuV8wNETF2ua1rsy2HkvTBt5vLDP9+7t3krNwGyMslSHFqdvIqMRjaG0mZ+y2S+o=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB3221.namprd12.prod.outlook.com (2603:10b6:a03:135::29)
 by BY5PR12MB4148.namprd12.prod.outlook.com (2603:10b6:a03:208::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3721.20; Wed, 6 Jan
 2021 23:46:43 +0000
Received: from BYAPR12MB3221.namprd12.prod.outlook.com
 ([fe80::f0b3:5ddc:5ec1:1728]) by BYAPR12MB3221.namprd12.prod.outlook.com
 ([fe80::f0b3:5ddc:5ec1:1728%4]) with mapi id 15.20.3742.006; Wed, 6 Jan 2021
 23:46:43 +0000
From: Ryan Taylor <Ryan.Taylor@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amd/pm: add swsmu init documentation
Date: Wed,  6 Jan 2021 15:44:59 -0800
Message-Id: <20210106234459.34325-1-Ryan.Taylor@amd.com>
X-Mailer: git-send-email 2.29.2
X-Originating-IP: [2600:1700:9260:7260::18]
X-ClientProxiedBy: BN6PR04CA0066.namprd04.prod.outlook.com
 (2603:10b6:404:8d::16) To BYAPR12MB3221.namprd12.prod.outlook.com
 (2603:10b6:a03:135::29)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from devbox.attlocal.net (2600:1700:9260:7260::18) by
 BN6PR04CA0066.namprd04.prod.outlook.com (2603:10b6:404:8d::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3742.6 via Frontend Transport; Wed, 6 Jan 2021 23:46:42 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 8524f26e-bacb-404f-4573-08d8b29d5252
X-MS-TrafficTypeDiagnostic: BY5PR12MB4148:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BY5PR12MB4148A9B73CE0CD00268C7124EAD00@BY5PR12MB4148.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cXsnWHU2TNxpJRD3deNQl5Yy1nL566phnAGL/txufbqiQw/7BPrKSBsNsWExnj7EEBg9UR6GoWz7p7dPjqUqyhxZFdoEzZIHOsCgBHA/sEUta7JpjB7l8zpuwk18/q20s1vY4WDQVPXqUcXl4zjjM0W9GXhuc245+URihDgjra7oJhQ72i5LrYOdqEiLq+zft87P/w3lshUsqSyJMffqdo43r315fX4LvLzfA6jjIjvwm5YeitBFNBZiUTXQq8QaVPm1LTmQj3kKnz4H+G2PJ2iKw+bDHMZgbkz6FzLEg3ktjBtKJ1ScFQOLy8Pa2BHEDq6+1e5TmrPvyXayzLDSJl0zvLu2BftsWPr1vfd4lLqKju3UVEeXyrhxWFqLWlwUJyZQYlIKaNntIacQPTfN80bM6rglO2mMg/+ZSfthRlwhDzwldVi7OES5KZdp/Gq/
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB3221.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(376002)(39860400002)(366004)(396003)(136003)(4326008)(478600001)(16526019)(2616005)(6486002)(6512007)(36756003)(8676002)(83380400001)(6666004)(6506007)(54906003)(6916009)(66556008)(5660300002)(316002)(66476007)(186003)(86362001)(66946007)(1076003)(52116002)(2906002)(8936002)(309714004);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?jhli29eQTli6isk6dMFZdmZ8LzwvPbQL48oWeEgqNhX7DxOUGFGC92+UuiHt?=
 =?us-ascii?Q?BVGQ/QbA6em8jcrT8KcIoxkbdxjE33l+ROEtlpQo1mwo5+ywLWr1UUP4z2v5?=
 =?us-ascii?Q?AJRQxMxxI/4S9V1A0A4cUtd+zjoNtBQs3L5o46QXVKtBglf5Y6XsfbbvU4q5?=
 =?us-ascii?Q?HCe6JkI+uGm4IDalQxfI+/6t3TwBu0xBmu8DKGtx4RzqWQTJjuN1q24aM4WZ?=
 =?us-ascii?Q?LdfUVqp8vwPQrB7ZKAbX1m2NAjZ8IDUu4mIJEp1RtGiVe7K+8oyztb4WcAmf?=
 =?us-ascii?Q?phjlCcZ6jPggy5FSai0hVOxAgFvp/POPefeZTTtJiVqBKyiJrjEq+I272os4?=
 =?us-ascii?Q?JjGXnwtOr9NBBlTvyp1rNIxrWl9UMV6DPs4QHtluy4YtpZzVk5/M8DKjvfL6?=
 =?us-ascii?Q?q7JQyJx/kZDURcK+F+8HwJj5sBd0NVnDA0wAhKxbRJqR3ej8rNexIseMQLG+?=
 =?us-ascii?Q?MP4pK4qE1F5yFMAXgnmVGvKUvHJjeW26VXFbek7Aqfe1I6OU5szaGG4RxwoH?=
 =?us-ascii?Q?XJa3H5j1vJsdo+Vj97ZdBNX/EkiIfY4qaCOZLKg08Gj/QGNShQe91N/I1R0C?=
 =?us-ascii?Q?MQ1dg0wG700k1RStLvUCS3cVDo2prPAXHuNRq/MoOl2Vp2PcC/CnsGN+tiot?=
 =?us-ascii?Q?cYs87o0RBMLXKMm1tmGjWF0HHgT/MYDPCnQEAGJQBwjzgUxTRZXrdP+/7B7r?=
 =?us-ascii?Q?OsICMmAV6g98KsYdz4SvUSMzz+LsRijUB59hFozkAQuCTmQOGKZKrtU7zW74?=
 =?us-ascii?Q?2nSqay7H2KIX5yldHIF1kecwamR237z4hzjwIcwjOvSybCmTHtloEbESZZen?=
 =?us-ascii?Q?RPnr9ZmB0FNobeIHtNdVrwcaloSffvvinKGCzYJTJAJXfP2qsomQAE+Rwzm/?=
 =?us-ascii?Q?OZDUlywX/Kj+hfOXs06QEnDxmiiEn7eNGDYV//TUFeNmapS2xB9WHcPTSsRm?=
 =?us-ascii?Q?OZ2T0ZmN0eMSPj7seInHX86ezOLxeDC8rRmU/2iZ241xcM2VVcW9DtuQm/F6?=
 =?us-ascii?Q?lTZplnevfF/JsOlJ3TtcT3rV7w=3D=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3221.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jan 2021 23:46:43.2308 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-Network-Message-Id: 8524f26e-bacb-404f-4573-08d8b29d5252
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hrL0edSzsWD1YFA9f0UgH7VDpaTL8uCqrzKIL+NgVHnN1Am60H67xme3m6ig8GW8W/yMKY+u3q5T0mmpk0DDiA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4148
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Ryan Taylor <Ryan.Taylor@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Documents functions used in swsmu initialization.

Signed-off-by: Ryan Taylor <Ryan.Taylor@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c | 94 ++++++++++++++++++++++-
 1 file changed, 93 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
index d80f7f8efdcd..82099cb3d00a 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -376,6 +376,15 @@ static int smu_get_driver_allowed_feature_mask(struct smu_context *smu)
 	return ret;
 }
 
+/**
+ * smu_set_funcs - Set ASIC specific SMU communication tools and data.
+ * @adev: amdgpu_device pointer
+ *
+ * Set hooks (&struct pptable_funcs), maps (&struct cmn2asic_mapping) and
+ * basic ASIC information (is_apu, od_enabled, etc.).
+ *
+ * Returns 0 on success, negative error code on failure.
+ */
 static int smu_set_funcs(struct amdgpu_device *adev)
 {
 	struct smu_context *smu = &adev->smu;
@@ -417,6 +426,15 @@ static int smu_set_funcs(struct amdgpu_device *adev)
 	return 0;
 }
 
+/**
+ * smu_early_init - Early init for the SMU IP block.
+ * @handle: amdgpu_device pointer
+ *
+ * Perform basic initialization of &struct smu_context. Set ASIC specific SMU
+ * communication tools and data using smu_set_funcs().
+ *
+ * Return: 0 on success, negative error code on failure.
+ */
 static int smu_early_init(void *handle)
 {
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
@@ -424,10 +442,12 @@ static int smu_early_init(void *handle)
 
 	smu->adev = adev;
 	smu->pm_enabled = !!amdgpu_dpm;
+	/* Assume ASIC is not an APU until updated in smu_set_funcs(). */
 	smu->is_apu = false;
 	mutex_init(&smu->mutex);
 	mutex_init(&smu->smu_baco.mutex);
 	smu->smu_baco.state = SMU_BACO_STATE_EXIT;
+	/* Disable baco support until the SMU engine is running. */
 	smu->smu_baco.platform_support = false;
 
 	return smu_set_funcs(adev);
@@ -472,6 +492,17 @@ static int smu_set_default_dpm_table(struct smu_context *smu)
 	return ret;
 }
 
+
+/**
+ * smu_late_init - Finish setting up the SMU IP block.
+ * @adev: amdgpu_device pointer
+ *
+ * Setup SMU tables/values used by other driver subsystems and in userspace
+ * (Overdrive, UMD power states, etc.). Perform final SMU configuration (set
+ * performance level, update display config etc.).
+ *
+ * Returns 0 on success, negative error code on failure.
+ */
 static int smu_late_init(void *handle)
 {
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
@@ -514,6 +545,8 @@ static int smu_late_init(void *handle)
 
 	smu_get_fan_parameters(smu);
 
+	/* Sets performance level, power profile mode and display
+	 * configuration. */
 	smu_handle_task(&adev->smu,
 			smu->smu_dpm.dpm_level,
 			AMD_PP_TASK_COMPLETE_INIT,
@@ -601,7 +634,7 @@ static int smu_fini_fb_allocations(struct smu_context *smu)
 /**
  * smu_alloc_memory_pool - allocate memory pool in the system memory
  *
- * @smu: amdgpu_device pointer
+ * @smu: smu_context pointer
  *
  * This memory pool will be used for SMC use and msg SetSystemVirtualDramAddr
  * and DramLogSetDramAddr can notify it changed.
@@ -701,6 +734,15 @@ static void smu_free_dummy_read_table(struct smu_context *smu)
 	memset(dummy_read_1_table, 0, sizeof(struct smu_table));
 }
 
+/**
+ * smu_smc_table_sw_init -  Initialize shared driver/SMU communication tools.
+ * @smu: smu_context pointer
+ *
+ * Allocate VRAM/DRAM for shared memory objects (SMU tables, memory pool, etc.).
+ * Initialize i2c.
+ *
+ * Returns 0 on success, negative error code on failure.
+ */
 static int smu_smc_table_sw_init(struct smu_context *smu)
 {
 	int ret;
@@ -799,6 +841,18 @@ static void smu_interrupt_work_fn(struct work_struct *work)
 	mutex_unlock(&smu->mutex);
 }
 
+/**
+ * smu_sw_init - Software init for the SMU IP block.
+ * @handle: amdgpu_device pointer
+ *
+ * Configure &struct smu_context with boot default performance profiles (power
+ * profile, workload, etc.) and power savings optimizations (powergate
+ * VCN/JPEG). Request the SMU's firmware from the kernel. Initialize features,
+ * locks, and kernel work queues. Initialize driver/SMU communication tools
+ * using smu_smc_table_sw_init(). Register the interrupt handler.
+ *
+ * Returns 0 on success, negative error code on failure.
+ */
 static int smu_sw_init(void *handle)
 {
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
@@ -820,6 +874,7 @@ static int smu_sw_init(void *handle)
 	INIT_WORK(&smu->interrupt_work, smu_interrupt_work_fn);
 	atomic64_set(&smu->throttle_int_counter, 0);
 	smu->watermarks_bitmap = 0;
+
 	smu->power_profile_mode = PP_SMC_POWER_PROFILE_BOOTUP_DEFAULT;
 	smu->default_power_profile_mode = PP_SMC_POWER_PROFILE_BOOTUP_DEFAULT;
 
@@ -914,6 +969,18 @@ static int smu_get_thermal_temperature_range(struct smu_context *smu)
 	return ret;
 }
 
+/**
+ * smu_smc_hw_setup - Configure SMU hardware for boot/resume.
+ * @smu: smu_context pointer
+ *
+ * Configure the following SMU hardware parameters: voltage frequency curve,
+ * power play table, features, system PCIe capabilities and shared memory
+ * locations. Use the configured SMU to setup thermal interrupts and populate
+ * the DPM tables. Finally, prepare the SMU for display component
+ * synchronization.
+ *
+ * Returns 0 on success, negative error code on failure.
+ */
 static int smu_smc_hw_setup(struct smu_context *smu)
 {
 	struct amdgpu_device *adev = smu->adev;
@@ -929,6 +996,7 @@ static int smu_smc_hw_setup(struct smu_context *smu)
 		return ret;
 	}
 
+	/* Disables display tracking. */
 	ret = smu_init_display_count(smu, 0);
 	if (ret) {
 		dev_info(adev->dev, "Failed to pre-set display count as 0!\n");
@@ -991,6 +1059,7 @@ static int smu_smc_hw_setup(struct smu_context *smu)
 	if (!smu_is_dpm_running(smu))
 		dev_info(adev->dev, "dpm has been disabled\n");
 
+	/* Get the system's PCIE capabilities. */
 	if (adev->pm.pcie_gen_mask & CAIL_PCIE_LINK_SPEED_SUPPORT_GEN4)
 		pcie_gen = 3;
 	else if (adev->pm.pcie_gen_mask & CAIL_PCIE_LINK_SPEED_SUPPORT_GEN3)
@@ -1061,6 +1130,16 @@ static int smu_smc_hw_setup(struct smu_context *smu)
 	return ret;
 }
 
+/**
+ * smu_start_smc_engine - Start the SMU engine.
+ * @smu: smu_context pointer
+ *
+ * Load SMU firmware if not loaded by PSP. Verify that firmware was
+ * loaded successfully. Check SMU firmware interface version (version mismatch
+ * is not a critical failure).
+ *
+ * Returns 0 on success, negative error code on failure.
+ */
 static int smu_start_smc_engine(struct smu_context *smu)
 {
 	struct amdgpu_device *adev = smu->adev;
@@ -1095,6 +1174,17 @@ static int smu_start_smc_engine(struct smu_context *smu)
 	return ret;
 }
 
+/**
+ * smu_hw_init - Hardware init for the SMU IP block.
+ * @handle: amdgpu_device pointer
+ *
+ * Start the SMU engine using smu_start_smc_engine(). Setup SMU configuration
+ * information (pptable, boot values, features). Configure SMU hardware for
+ * boot/resume using smu_smc_hw_setup(). Get table of maximum sustainable clock
+ * speeds from the SMU.
+ *
+ * Returns 0 on success, negative error code on failure.
+ */
 static int smu_hw_init(void *handle)
 {
 	int ret;
@@ -1112,6 +1202,8 @@ static int smu_hw_init(void *handle)
 		return ret;
 	}
 
+	/* APUs boot with several components turned off to save power. Enable
+	 * these IP blocks so that APUs are in the same state as other ASICs. */
 	if (smu->is_apu) {
 		smu_powergate_sdma(&adev->smu, false);
 		smu_dpm_set_vcn_enable(smu, true);
-- 
2.29.2

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
