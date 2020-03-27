Return-Path: <SRS0=Hz3R=5M=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E2E4C2D0E9
	for <amd-gfx@archiver.kernel.org>; Fri, 27 Mar 2020 03:42:06 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 44324206DB
	for <amd-gfx@archiver.kernel.org>; Fri, 27 Mar 2020 03:42:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="mXbhDksI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 44324206DB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0B67C6E235;
	Fri, 27 Mar 2020 03:42:06 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2068.outbound.protection.outlook.com [40.107.223.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D942A6E235
 for <amd-gfx@lists.freedesktop.org>; Fri, 27 Mar 2020 03:42:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GjlwswCxOIUe+BfuNzUwSOvZr8ctc6CjiOE/UJ6V6RViaEQf3BB2A45VU/8ZfQvqbz3AXD2PDLSgu2I8JwMo+XhvJl2C6PaUMadd0GzOlNSA09lHVHjVbQLeUKfu1rzCYJZvWDTgLvyypJ/RjS7MpdBVawZVAMzC5zisZh18JjjLdN3eYrGtqHfSGcqYkj11w7bgHlG3AB8rZ7Vte7KG5MurjWWM5fzyEvu6IwtpRzct7fGdlII9U8ma7r6BDVJpicpyVDxoyeeXD/3K9Lr91lKgURxfYtlL77jYNAa4MCmjOOh05wgTSxJqc1iGZLrlQN8lBVoIgVE+HPplxfJAsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UKk7wRmXdBPKQWBUSYYa7RZKxs4CF0qTdDTtQKCMHaI=;
 b=JxqilAnhaGYJ+sjagCz0iHhNdGc9HcFIWttx7ANz/ecsBeG1ZTsVrY0ZZzbjNkxtEZXFaMCD7W52/lGJmi80+s6JjgUTzbrQhYkOaeEIjoTtbegN5vsTOVdZlXo2+uj6PmkZqaBgWZgiW6ic5nA7mt28/IZicX68sVTwMISfN2iqFTDkq8O1DGLev3rtMvVuRlN0kE2WDprrNg8tHenzLIgPSIBPXAzgoUFFx8wc7ft0ZJcV1jXzzko5OXpiJBBOIGV++zprgv4oSTFQnKRODf80t0xGmGvVc08/jmpo+fxYO7ojeLhkL34hE6vmVtdZIhAZ0Jv5QhI5M72TZzf+lw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UKk7wRmXdBPKQWBUSYYa7RZKxs4CF0qTdDTtQKCMHaI=;
 b=mXbhDksIF75ULswlA+uZMipGzuVTfy2mBYl5xdw9HT1FmdnELhWKBEmP8s1mfsgUrWDMnIzFiIwmZ/qdEEvco+rqlja9UTCp8Git3c8AQw2QZROemvru3xduD+OkyC15nMQ90Ieg3UNqFiq7zrKsM+TXDRBNbOjUMHqGfEwCdBE=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Evan.Quan@amd.com; 
Received: from MN2PR12MB3344.namprd12.prod.outlook.com (2603:10b6:208:c5::10)
 by MN2PR12MB4373.namprd12.prod.outlook.com (2603:10b6:208:261::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2856.19; Fri, 27 Mar
 2020 03:42:03 +0000
Received: from MN2PR12MB3344.namprd12.prod.outlook.com
 ([fe80::69c7:b493:690:2173]) by MN2PR12MB3344.namprd12.prod.outlook.com
 ([fe80::69c7:b493:690:2173%3]) with mapi id 15.20.2835.021; Fri, 27 Mar 2020
 03:42:03 +0000
From: Evan Quan <evan.quan@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 2/9] drm/amd/powerplay: avoid calling SMU7 specific SMU
 message implemention
Date: Fri, 27 Mar 2020 11:41:31 +0800
Message-Id: <20200327034138.7653-2-evan.quan@amd.com>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200327034138.7653-1-evan.quan@amd.com>
References: <20200327034138.7653-1-evan.quan@amd.com>
X-ClientProxiedBy: HK0PR01CA0063.apcprd01.prod.exchangelabs.com
 (2603:1096:203:a6::27) To MN2PR12MB3344.namprd12.prod.outlook.com
 (2603:10b6:208:c5::10)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from equan-buildpc.amd.com (180.167.199.189) by
 HK0PR01CA0063.apcprd01.prod.exchangelabs.com (2603:1096:203:a6::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2856.20 via Frontend
 Transport; Fri, 27 Mar 2020 03:42:02 +0000
X-Mailer: git-send-email 2.26.0
X-Originating-IP: [180.167.199.189]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 7f8aae71-da74-4e53-5e4d-08d7d200d04c
X-MS-TrafficTypeDiagnostic: MN2PR12MB4373:|MN2PR12MB4373:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB4373B713F0CBA18FB23F0ED2E4CC0@MN2PR12MB4373.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:285;
X-Forefront-PRVS: 0355F3A3AE
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(366004)(136003)(396003)(346002)(39860400002)(376002)(6666004)(6486002)(26005)(81156014)(8676002)(6916009)(81166006)(16526019)(956004)(4326008)(15650500001)(186003)(36756003)(44832011)(2616005)(8936002)(52116002)(478600001)(86362001)(66946007)(66556008)(316002)(7696005)(2906002)(30864003)(5660300002)(1076003)(66476007)(66574012);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MN2PR12MB4373;
 H:MN2PR12MB3344.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DJrukCuEg741zd5JNOlJj8VVPnH+VoBYA8g3sc0a5XB6B6CopaKeqO3omII0B2JG+O2HIW7gQb4GvtmtULterAqOtf1/5Qaxj1Z7uciJqHRKx7RW9FgQLelWBsME/4qeqOFxY2Tr6U6sSWY2ok+wObs6hsVLDplB2ttCKj30i2/NPvRkOe5g7U9ftip/vq+1hc5mkb0sA7XBw+DyRJhAhQ/vNVm+fFHJIez61V3Pn6nixaiBRU1PlSQMFzCfvAHiC5gwzdLWHOmaR0MejIWAb62D9/XOrBkDWPLjnmMv5pM9zLDuQXRmR2OtZE9XQ61pmpcTyv6NFjJYBxCsbcAJ8WK5srWE0UGrtrcTsJciPfT+nu4a92ayr7mR+hQDw4qy8LNPc22Zds7BVe7oojMgCnIBOThi4omE+++Rv5xz06VqMUa8m3455J9X1gS9CFZH
X-MS-Exchange-AntiSpam-MessageData: JRzXN4lPZ9Afo8TK54fEbPUeE9OX/PGfFlHcZFtT8J4dFuRhgj5ItY48mo2sVLXx3zZD+F3R910+nRUq4ggVpUAYE6Lswqn2zfxnfatojPYtkELtQYVWZlKuy2rifoeysR6HnsD0cr0kjBKGvb2quw==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f8aae71-da74-4e53-5e4d-08d7d200d04c
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2020 03:42:03.5341 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: F2CS0IRJIeMepofw8geOrBpeRjOiP3BzS3XTAAhoAX1mH7Jeok9TcZJTNpG/+Zag
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4373
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
Cc: Evan Quan <evan.quan@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Prepare for coming lock protection for SMU message issuing.

Change-Id: Ie1365f350abcde4c4474e9bbdaf7742349a0534d
Signed-off-by: Evan Quan <evan.quan@amd.com>
---
 .../gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr.c  | 10 +++----
 .../drm/amd/powerplay/hwmgr/smu7_thermal.c    |  8 +++---
 .../drm/amd/powerplay/smumgr/fiji_smumgr.c    |  7 +++--
 .../drm/amd/powerplay/smumgr/iceland_smumgr.c |  1 +
 .../amd/powerplay/smumgr/polaris10_smumgr.c   |  3 ++-
 .../drm/amd/powerplay/smumgr/smu7_smumgr.c    | 26 ++++++++-----------
 .../drm/amd/powerplay/smumgr/smu7_smumgr.h    |  1 +
 .../drm/amd/powerplay/smumgr/tonga_smumgr.c   |  1 +
 .../drm/amd/powerplay/smumgr/vegam_smumgr.c   |  1 +
 9 files changed, 29 insertions(+), 29 deletions(-)

diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr.c b/drivers/gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr.c
index 7740488999df..fc4e6dd2aa82 100644
--- a/drivers/gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr.c
+++ b/drivers/gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr.c
@@ -3496,7 +3496,7 @@ static int smu7_get_gpu_power(struct pp_hwmgr *hwmgr, u32 *query)
 	    (adev->asic_type != CHIP_FIJI) &&
 	    (adev->asic_type != CHIP_TONGA)) {
 		smum_send_msg_to_smc_with_parameter(hwmgr, PPSMC_MSG_GetCurrPkgPwr, 0);
-		tmp = cgs_read_register(hwmgr->device, mmSMC_MSG_ARG_0);
+		tmp = smum_get_argument(hwmgr);
 		*query = tmp;
 
 		if (tmp != 0)
@@ -3535,13 +3535,13 @@ static int smu7_read_sensor(struct pp_hwmgr *hwmgr, int idx,
 	switch (idx) {
 	case AMDGPU_PP_SENSOR_GFX_SCLK:
 		smum_send_msg_to_smc(hwmgr, PPSMC_MSG_API_GetSclkFrequency);
-		sclk = cgs_read_register(hwmgr->device, mmSMC_MSG_ARG_0);
+		sclk = smum_get_argument(hwmgr);
 		*((uint32_t *)value) = sclk;
 		*size = 4;
 		return 0;
 	case AMDGPU_PP_SENSOR_GFX_MCLK:
 		smum_send_msg_to_smc(hwmgr, PPSMC_MSG_API_GetMclkFrequency);
-		mclk = cgs_read_register(hwmgr->device, mmSMC_MSG_ARG_0);
+		mclk = smum_get_argument(hwmgr);
 		*((uint32_t *)value) = mclk;
 		*size = 4;
 		return 0;
@@ -4455,7 +4455,7 @@ static int smu7_print_clock_levels(struct pp_hwmgr *hwmgr,
 	switch (type) {
 	case PP_SCLK:
 		smum_send_msg_to_smc(hwmgr, PPSMC_MSG_API_GetSclkFrequency);
-		clock = cgs_read_register(hwmgr->device, mmSMC_MSG_ARG_0);
+		clock = smum_get_argument(hwmgr);
 
 		for (i = 0; i < sclk_table->count; i++) {
 			if (clock > sclk_table->dpm_levels[i].value)
@@ -4471,7 +4471,7 @@ static int smu7_print_clock_levels(struct pp_hwmgr *hwmgr,
 		break;
 	case PP_MCLK:
 		smum_send_msg_to_smc(hwmgr, PPSMC_MSG_API_GetMclkFrequency);
-		clock = cgs_read_register(hwmgr->device, mmSMC_MSG_ARG_0);
+		clock = smum_get_argument(hwmgr);
 
 		for (i = 0; i < mclk_table->count; i++) {
 			if (clock > mclk_table->dpm_levels[i].value)
diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/smu7_thermal.c b/drivers/gpu/drm/amd/powerplay/hwmgr/smu7_thermal.c
index 5bdc0df5a9f4..dd4f450d1199 100644
--- a/drivers/gpu/drm/amd/powerplay/hwmgr/smu7_thermal.c
+++ b/drivers/gpu/drm/amd/powerplay/hwmgr/smu7_thermal.c
@@ -151,8 +151,8 @@ int smu7_fan_ctrl_start_smc_fan_control(struct pp_hwmgr *hwmgr)
 	int result;
 
 	if (PP_CAP(PHM_PlatformCaps_ODFuzzyFanControlSupport)) {
-		cgs_write_register(hwmgr->device, mmSMC_MSG_ARG_0, FAN_CONTROL_FUZZY);
-		result = smum_send_msg_to_smc(hwmgr, PPSMC_StartFanControl);
+		result = smum_send_msg_to_smc_with_parameter(hwmgr, PPSMC_StartFanControl,
+					FAN_CONTROL_FUZZY);
 
 		if (PP_CAP(PHM_PlatformCaps_FanSpeedInTableIsRPM))
 			hwmgr->hwmgr_func->set_max_fan_rpm_output(hwmgr,
@@ -164,8 +164,8 @@ int smu7_fan_ctrl_start_smc_fan_control(struct pp_hwmgr *hwmgr)
 					advanceFanControlParameters.usMaxFanPWM);
 
 	} else {
-		cgs_write_register(hwmgr->device, mmSMC_MSG_ARG_0, FAN_CONTROL_TABLE);
-		result = smum_send_msg_to_smc(hwmgr, PPSMC_StartFanControl);
+		result = smum_send_msg_to_smc_with_parameter(hwmgr, PPSMC_StartFanControl,
+					FAN_CONTROL_TABLE);
 	}
 
 	if (!result && hwmgr->thermal_controller.
diff --git a/drivers/gpu/drm/amd/powerplay/smumgr/fiji_smumgr.c b/drivers/gpu/drm/amd/powerplay/smumgr/fiji_smumgr.c
index 32ebb383c456..ab35e4619d15 100644
--- a/drivers/gpu/drm/amd/powerplay/smumgr/fiji_smumgr.c
+++ b/drivers/gpu/drm/amd/powerplay/smumgr/fiji_smumgr.c
@@ -137,9 +137,7 @@ static int fiji_start_smu_in_protection_mode(struct pp_hwmgr *hwmgr)
 	PHM_WAIT_VFPF_INDIRECT_FIELD(hwmgr, SMC_IND, RCU_UC_EVENTS,
 			INTERRUPTS_ENABLED, 1);
 
-	cgs_write_register(hwmgr->device, mmSMC_MSG_ARG_0, 0x20000);
-	cgs_write_register(hwmgr->device, mmSMC_MESSAGE_0, PPSMC_MSG_Test);
-	PHM_WAIT_FIELD_UNEQUAL(hwmgr, SMC_RESP_0, SMC_RESP, 0);
+	smum_send_msg_to_smc_with_parameter(hwmgr, PPSMC_MSG_Test, 0x20000);
 
 	/* Wait for done bit to be set */
 	PHM_WAIT_VFPF_INDIRECT_FIELD_UNEQUAL(hwmgr, SMC_IND,
@@ -203,7 +201,7 @@ static int fiji_start_avfs_btc(struct pp_hwmgr *hwmgr)
 	struct smu7_smumgr *smu_data = (struct smu7_smumgr *)(hwmgr->smu_backend);
 
 	if (0 != smu_data->avfs_btc_param) {
-		if (0 != smu7_send_msg_to_smc_with_parameter(hwmgr,
+		if (0 != smum_send_msg_to_smc_with_parameter(hwmgr,
 				PPSMC_MSG_PerformBtc, smu_data->avfs_btc_param)) {
 			pr_info("[AVFS][Fiji_PerformBtc] PerformBTC SMU msg failed");
 			result = -EINVAL;
@@ -2649,6 +2647,7 @@ const struct pp_smumgr_func fiji_smu_funcs = {
 	.request_smu_load_specific_fw = NULL,
 	.send_msg_to_smc = &smu7_send_msg_to_smc,
 	.send_msg_to_smc_with_parameter = &smu7_send_msg_to_smc_with_parameter,
+	.get_argument = smu7_get_argument,
 	.download_pptable_settings = NULL,
 	.upload_pptable_settings = NULL,
 	.update_smc_table = fiji_update_smc_table,
diff --git a/drivers/gpu/drm/amd/powerplay/smumgr/iceland_smumgr.c b/drivers/gpu/drm/amd/powerplay/smumgr/iceland_smumgr.c
index 732005c03a82..431ad2fd38df 100644
--- a/drivers/gpu/drm/amd/powerplay/smumgr/iceland_smumgr.c
+++ b/drivers/gpu/drm/amd/powerplay/smumgr/iceland_smumgr.c
@@ -2669,6 +2669,7 @@ const struct pp_smumgr_func iceland_smu_funcs = {
 	.request_smu_load_specific_fw = &iceland_request_smu_load_specific_fw,
 	.send_msg_to_smc = &smu7_send_msg_to_smc,
 	.send_msg_to_smc_with_parameter = &smu7_send_msg_to_smc_with_parameter,
+	.get_argument = smu7_get_argument,
 	.download_pptable_settings = NULL,
 	.upload_pptable_settings = NULL,
 	.get_offsetof = iceland_get_offsetof,
diff --git a/drivers/gpu/drm/amd/powerplay/smumgr/polaris10_smumgr.c b/drivers/gpu/drm/amd/powerplay/smumgr/polaris10_smumgr.c
index 23c12018dbc1..aaf9fd87d8ed 100644
--- a/drivers/gpu/drm/amd/powerplay/smumgr/polaris10_smumgr.c
+++ b/drivers/gpu/drm/amd/powerplay/smumgr/polaris10_smumgr.c
@@ -99,7 +99,7 @@ static int polaris10_perform_btc(struct pp_hwmgr *hwmgr)
 	struct smu7_smumgr *smu_data = (struct smu7_smumgr *)(hwmgr->smu_backend);
 
 	if (0 != smu_data->avfs_btc_param) {
-		if (0 != smu7_send_msg_to_smc_with_parameter(hwmgr, PPSMC_MSG_PerformBtc, smu_data->avfs_btc_param)) {
+		if (0 != smum_send_msg_to_smc_with_parameter(hwmgr, PPSMC_MSG_PerformBtc, smu_data->avfs_btc_param)) {
 			pr_info("[AVFS][SmuPolaris10_PerformBtc] PerformBTC SMU msg failed");
 			result = -1;
 		}
@@ -2565,6 +2565,7 @@ const struct pp_smumgr_func polaris10_smu_funcs = {
 	.request_smu_load_specific_fw = NULL,
 	.send_msg_to_smc = smu7_send_msg_to_smc,
 	.send_msg_to_smc_with_parameter = smu7_send_msg_to_smc_with_parameter,
+	.get_argument = smu7_get_argument,
 	.download_pptable_settings = NULL,
 	.upload_pptable_settings = NULL,
 	.update_smc_table = polaris10_update_smc_table,
diff --git a/drivers/gpu/drm/amd/powerplay/smumgr/smu7_smumgr.c b/drivers/gpu/drm/amd/powerplay/smumgr/smu7_smumgr.c
index 3f51d545e8ff..07460ac74ac5 100644
--- a/drivers/gpu/drm/amd/powerplay/smumgr/smu7_smumgr.c
+++ b/drivers/gpu/drm/amd/powerplay/smumgr/smu7_smumgr.c
@@ -214,18 +214,14 @@ int smu7_send_msg_to_smc_with_parameter_without_waiting(struct pp_hwmgr *hwmgr,
 	return smu7_send_msg_to_smc_without_waiting(hwmgr, msg);
 }
 
-int smu7_send_msg_to_smc_offset(struct pp_hwmgr *hwmgr)
+uint32_t smu7_get_argument(struct pp_hwmgr *hwmgr)
 {
-	cgs_write_register(hwmgr->device, mmSMC_MSG_ARG_0, 0x20000);
-
-	cgs_write_register(hwmgr->device, mmSMC_MESSAGE_0, PPSMC_MSG_Test);
-
-	PHM_WAIT_FIELD_UNEQUAL(hwmgr, SMC_RESP_0, SMC_RESP, 0);
-
-	if (1 != PHM_READ_FIELD(hwmgr->device, SMC_RESP_0, SMC_RESP))
-		pr_info("Failed to send Message.\n");
+	return cgs_read_register(hwmgr->device, mmSMC_MSG_ARG_0);
+}
 
-	return 0;
+int smu7_send_msg_to_smc_offset(struct pp_hwmgr *hwmgr)
+{
+	return smum_send_msg_to_smc_with_parameter(hwmgr, PPSMC_MSG_Test, 0x20000);
 }
 
 enum cgs_ucode_id smu7_convert_fw_type_to_cgs(uint32_t fw_type)
@@ -353,10 +349,10 @@ int smu7_request_smu_load_fw(struct pp_hwmgr *hwmgr)
 
 	if (hwmgr->chip_id > CHIP_TOPAZ) { /* add support for Topaz */
 		if (hwmgr->not_vf) {
-			smu7_send_msg_to_smc_with_parameter(hwmgr,
+			smum_send_msg_to_smc_with_parameter(hwmgr,
 						PPSMC_MSG_SMU_DRAM_ADDR_HI,
 						upper_32_bits(smu_data->smu_buffer.mc_addr));
-			smu7_send_msg_to_smc_with_parameter(hwmgr,
+			smum_send_msg_to_smc_with_parameter(hwmgr,
 						PPSMC_MSG_SMU_DRAM_ADDR_LO,
 						lower_32_bits(smu_data->smu_buffer.mc_addr));
 		}
@@ -423,10 +419,10 @@ int smu7_request_smu_load_fw(struct pp_hwmgr *hwmgr)
 	}
 	memcpy_toio(smu_data->header_buffer.kaddr, smu_data->toc,
 		    sizeof(struct SMU_DRAMData_TOC));
-	smu7_send_msg_to_smc_with_parameter(hwmgr, PPSMC_MSG_DRV_DRAM_ADDR_HI, upper_32_bits(smu_data->header_buffer.mc_addr));
-	smu7_send_msg_to_smc_with_parameter(hwmgr, PPSMC_MSG_DRV_DRAM_ADDR_LO, lower_32_bits(smu_data->header_buffer.mc_addr));
+	smum_send_msg_to_smc_with_parameter(hwmgr, PPSMC_MSG_DRV_DRAM_ADDR_HI, upper_32_bits(smu_data->header_buffer.mc_addr));
+	smum_send_msg_to_smc_with_parameter(hwmgr, PPSMC_MSG_DRV_DRAM_ADDR_LO, lower_32_bits(smu_data->header_buffer.mc_addr));
 
-	smu7_send_msg_to_smc_with_parameter(hwmgr, PPSMC_MSG_LoadUcodes, fw_to_load);
+	smum_send_msg_to_smc_with_parameter(hwmgr, PPSMC_MSG_LoadUcodes, fw_to_load);
 
 	r = smu7_check_fw_load_finish(hwmgr, fw_to_load);
 	if (!r)
diff --git a/drivers/gpu/drm/amd/powerplay/smumgr/smu7_smumgr.h b/drivers/gpu/drm/amd/powerplay/smumgr/smu7_smumgr.h
index 01f0538fba6b..fe27f46d2f5d 100644
--- a/drivers/gpu/drm/amd/powerplay/smumgr/smu7_smumgr.h
+++ b/drivers/gpu/drm/amd/powerplay/smumgr/smu7_smumgr.h
@@ -65,6 +65,7 @@ int smu7_send_msg_to_smc_with_parameter(struct pp_hwmgr *hwmgr, uint16_t msg,
 						uint32_t parameter);
 int smu7_send_msg_to_smc_with_parameter_without_waiting(struct pp_hwmgr *hwmgr,
 						uint16_t msg, uint32_t parameter);
+uint32_t smu7_get_argument(struct pp_hwmgr *hwmgr);
 int smu7_send_msg_to_smc_offset(struct pp_hwmgr *hwmgr);
 
 enum cgs_ucode_id smu7_convert_fw_type_to_cgs(uint32_t fw_type);
diff --git a/drivers/gpu/drm/amd/powerplay/smumgr/tonga_smumgr.c b/drivers/gpu/drm/amd/powerplay/smumgr/tonga_smumgr.c
index f19bac7ef7ba..6317434ad6b3 100644
--- a/drivers/gpu/drm/amd/powerplay/smumgr/tonga_smumgr.c
+++ b/drivers/gpu/drm/amd/powerplay/smumgr/tonga_smumgr.c
@@ -3248,6 +3248,7 @@ const struct pp_smumgr_func tonga_smu_funcs = {
 	.request_smu_load_specific_fw = NULL,
 	.send_msg_to_smc = &smu7_send_msg_to_smc,
 	.send_msg_to_smc_with_parameter = &smu7_send_msg_to_smc_with_parameter,
+	.get_argument = smu7_get_argument,
 	.download_pptable_settings = NULL,
 	.upload_pptable_settings = NULL,
 	.update_smc_table = tonga_update_smc_table,
diff --git a/drivers/gpu/drm/amd/powerplay/smumgr/vegam_smumgr.c b/drivers/gpu/drm/amd/powerplay/smumgr/vegam_smumgr.c
index b0e0d67cd54b..0f38d5183985 100644
--- a/drivers/gpu/drm/amd/powerplay/smumgr/vegam_smumgr.c
+++ b/drivers/gpu/drm/amd/powerplay/smumgr/vegam_smumgr.c
@@ -2279,6 +2279,7 @@ const struct pp_smumgr_func vegam_smu_funcs = {
 	.request_smu_load_specific_fw = NULL,
 	.send_msg_to_smc = smu7_send_msg_to_smc,
 	.send_msg_to_smc_with_parameter = smu7_send_msg_to_smc_with_parameter,
+	.get_argument = smu7_get_argument,
 	.process_firmware_header = vegam_process_firmware_header,
 	.is_dpm_running = vegam_is_dpm_running,
 	.get_mac_definition = vegam_get_mac_definition,
-- 
2.26.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
