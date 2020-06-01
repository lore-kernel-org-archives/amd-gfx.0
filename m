Return-Path: <SRS0=+jgF=7O=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10B30C433DF
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Jun 2020 07:31:06 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D1BFF206C3
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Jun 2020 07:31:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="LQ0bAB77"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D1BFF206C3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9EADD6E196;
	Mon,  1 Jun 2020 07:31:05 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2064.outbound.protection.outlook.com [40.107.223.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EB6A26E196
 for <amd-gfx@lists.freedesktop.org>; Mon,  1 Jun 2020 07:31:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nacExiw99fYV8OJVyblvegrD+/tXZZYGe0uw8okomK2cI3e4LxTQ+dxtDpQdRTdeJRfbmvmln4wUfpfjpZDTaIQ05T0LL70XkrGhQpIIfZg6Ov/SlLAdEFi1kxBJmEeGWaI1KUBEq/P/cxY6VqPsYlmadawrk0vmu0+Nv978MqbaHqWU06hLNzkAxZyv5Zyx0CaHlgLYIC8aGEZ8Wia7kyka518FUST22YGeJUwlpT0wjzqi4QjHK+4dsD98VZjB26nLbG6lQ75egjaF43ZcQPohX4pw0eeKX43oJpKydARBZflYZe7RZEydyoXD/ITkfMhEjQbBRaWRcAiBkc2XxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ysdCNkj0tonV2/KiaGgFNQIPnTlBkkjBt137QcCUYPI=;
 b=a4B2YLXvyLXmAyEuzaWLxxqVuzcU3oDszo47tiBjwdY/nqJkQe0HuQHQ/NnOhjFcVgUU3GYm1DVIXw9J2PS6JpbqabgdvW1xocvCCoKX91pQ43fNL1KuGnVX4LgjVsmKUcEkTe6WOvn4JYjecuUqXym5y2zOcVlelZlId/2VoXA2TP62ZZ7rLIVvjyHuEpCcfsRvZqRW3btF1cRqEmQargxZD61GmHbCvLuqLDP+eSaabokfOPxc8bQb6eqvzpKrV36EYo1POUnlzq75M/abHv3vslFNGwDypaFiYlS2eL5M3VZdKYidGQ2UNmddSBnFit7s3u8XYL9XpayJ1MK7yQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ysdCNkj0tonV2/KiaGgFNQIPnTlBkkjBt137QcCUYPI=;
 b=LQ0bAB77zdp7Hil04EDNxNrLkhVWlSoJ7AynoR/KZC8rSLzutfUHn489hzQKNaqkxpSX68451wzQgiOdf4P/+HnkGcVu1RwSXqJDiraeBqHgvTinj20j+YRha4WExUAaXbpswYTwyf/Ys+veVvGbTqRLoThEzJQC+LVxE/0zj9E=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM6PR12MB3803.namprd12.prod.outlook.com (2603:10b6:5:1ce::20) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3045.19; Mon, 1 Jun 2020 07:31:03 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::c157:8999:dcc3:536f]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::c157:8999:dcc3:536f%3]) with mapi id 15.20.3045.022; Mon, 1 Jun 2020
 07:31:03 +0000
From: Evan Quan <evan.quan@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 7/9] drm/amd/powerplay: clean up the SMU hw setup operations
Date: Mon,  1 Jun 2020 15:30:01 +0800
Message-Id: <20200601073003.13044-7-evan.quan@amd.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200601073003.13044-1-evan.quan@amd.com>
References: <20200601073003.13044-1-evan.quan@amd.com>
X-ClientProxiedBy: HK2PR0302CA0020.apcprd03.prod.outlook.com
 (2603:1096:202::30) To DM6PR12MB2619.namprd12.prod.outlook.com
 (2603:10b6:5:45::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from equan-buildpc.amd.com (58.247.170.242) by
 HK2PR0302CA0020.apcprd03.prod.outlook.com (2603:1096:202::30) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3066.7 via Frontend Transport; Mon, 1 Jun 2020 07:31:02 +0000
X-Mailer: git-send-email 2.26.2
X-Originating-IP: [58.247.170.242]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 34f330d3-ade2-4245-7a7c-08d805fdbd52
X-MS-TrafficTypeDiagnostic: DM6PR12MB3803:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB38030F5957E1A2ACD6567743E48A0@DM6PR12MB3803.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:213;
X-Forefront-PRVS: 0421BF7135
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nMvPeKu7MRUe94b3FmSWaKhRfCYbvls8Jms33hRqdseLSr1g3Ev9z1SPpvyuBrIgfzG1HQ/WGCXbCQd7EwtLE/J86XdaVosRDXbvsWWL/3pOwlcekQhg0pcffJ7UPAi45qcEcCUCNe/MnQxS/CgFQhs0nqcSXt73BWtJY5g/AMh+rcgCHXBZwAHis3ZCp0p7E8A8oTmLaLpp2n24vvPspkFKIu/zRAK2p9Z+zz8oLyIQ+jIhwEe96M1q0Ykg+MJy2NdYVd6RuhwutNmww5p5ZM2sxp4egZxlPPvfUqM+b7Z9n1HM6IsLLxGcU687E8TDb6pyKNVmKSEEZeZValJWSQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(366004)(396003)(39860400002)(346002)(376002)(136003)(52116002)(6916009)(1076003)(316002)(7696005)(8936002)(478600001)(30864003)(16526019)(83380400001)(2906002)(44832011)(6486002)(186003)(26005)(4326008)(66574014)(86362001)(2616005)(8676002)(956004)(36756003)(5660300002)(66946007)(66476007)(66556008);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: cVGP8tnhlEqOcnj1lgdsAwC4uH5G+8LLHRT1cYgbM/063iNC2L4DJNWRKeo0Kpu2p5GmD+uNo2uRvqODwtIGl5ia+wf1NMh42JV/WXAbS6m75eJ0jpzTEmKQHTGBzLiha3AataJ4NNZWNnh8MogxBCDILT8Co1xMp0RflOx1b345+Hl6N2+sHXUIHg0JygXM5IsJW4pizUAK5H2eeaelKXRiAAyLnGRiXTXIPDDptN1dkEisaymgx8hifgB5OpETwVkWvwGWWS9tx70YgOSdJSiWsDyUJYFjwmB17oiRkUE4Ju7n+GchgPfwaYjL0Ev5H7LE56Vh1Bq13smV56w+VHNcrDaly43jnafoiYi4A9FjhNmQOLXifTc0Yq4ybMGUake2dVolHQecElE9B9JntRhr8VobnEEeMJNZ8iTIpBo3mmrfe11Nhpc3M89cuvNvjyB+WSEOV3bqupV/+AMuT479o58yjjZKilhstRPhUp32S1z3F3hEkHzLZyPhJYWE
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 34f330d3-ade2-4245-7a7c-08d805fdbd52
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2020 07:31:03.6657 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qxpTw026yJWkZb2ncpGug9sjWdWeQ7H0g0Fp4d6zJXe2xnf2iJPy4c+nGXIlbODl
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3803
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
Cc: alexander.deucher@amd.com, Evan Quan <evan.quan@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Postpone some operations which are not must for hw setup to
late_init. Thus, code sharing is possible between hw_init/fini and
suspend/resume. Also this makes code more clean and readable.

Change-Id: Id3996fd9e2dbf2ff59d8a6032cc5f6730db1295c
Signed-off-by: Evan Quan <evan.quan@amd.com>
---
 drivers/gpu/drm/amd/powerplay/amdgpu_smu.c | 327 ++++++++++-----------
 1 file changed, 157 insertions(+), 170 deletions(-)

diff --git a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
index 9b81b6519a96..e55c6458b212 100644
--- a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
@@ -789,10 +789,36 @@ static int smu_late_init(void *handle)
 {
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
 	struct smu_context *smu = &adev->smu;
+	int ret = 0;
 
 	if (!smu->pm_enabled)
 		return 0;
 
+	ret = smu_set_default_od_settings(smu);
+	if (ret)
+		return ret;
+
+	/*
+	 * Set initialized values (get from vbios) to dpm tables context such as
+	 * gfxclk, memclk, dcefclk, and etc. And enable the DPM feature for each
+	 * type of clks.
+	 */
+	ret = smu_populate_smc_tables(smu);
+	if (ret)
+		return ret;
+
+	ret = smu_init_max_sustainable_clocks(smu);
+	if (ret)
+		return ret;
+
+	ret = smu_populate_umd_state_clk(smu);
+	if (ret)
+		return ret;
+
+	ret = smu_get_power_limit(smu, &smu->default_power_limit, false, false);
+	if (ret)
+		return ret;
+
 	smu_handle_task(&adev->smu,
 			smu->smu_dpm.dpm_level,
 			AMD_PP_TASK_COMPLETE_INIT,
@@ -1107,8 +1133,7 @@ static int smu_sw_fini(void *handle)
 	return 0;
 }
 
-static int smu_smc_table_hw_init(struct smu_context *smu,
-				 bool initialize)
+static int smu_internal_hw_setup(struct smu_context *smu)
 {
 	struct amdgpu_device *adev = smu->adev;
 	int ret;
@@ -1122,26 +1147,22 @@ static int smu_smc_table_hw_init(struct smu_context *smu,
 	if (ret)
 		return ret;
 
-	if (initialize) {
-		/* get boot_values from vbios to set revision, gfxclk, and etc. */
-		ret = smu_get_vbios_bootup_values(smu);
-		if (ret)
-			return ret;
-
-		ret = smu_setup_pptable(smu);
-		if (ret)
-			return ret;
+	ret = smu_set_driver_table_location(smu);
+	if (ret)
+		return ret;
 
-		/*
-		 * Send msg GetDriverIfVersion to check if the return value is equal
-		 * with DRIVER_IF_VERSION of smc header.
-		 */
-		ret = smu_check_fw_version(smu);
-		if (ret)
-			return ret;
-	}
+	/*
+	 * Set PMSTATUSLOG table bo address with SetToolsDramAddr MSG for tools.
+	 */
+	ret = smu_set_tool_table_location(smu);
+	if (ret)
+		return ret;
 
-	ret = smu_set_driver_table_location(smu);
+	/*
+	 * Use msg SetSystemVirtualDramAddr and DramLogSetDramAddr can notify
+	 * pool location.
+	 */
+	ret = smu_notify_memory_pool_location(smu);
 	if (ret)
 		return ret;
 
@@ -1158,6 +1179,11 @@ static int smu_smc_table_hw_init(struct smu_context *smu,
 	ret = smu_run_btc(smu);
 	if (ret)
 		return ret;
+
+	ret = smu_feature_init_dpm(smu);
+	if (ret)
+		return ret;
+
 	ret = smu_feature_set_allowed_mask(smu);
 	if (ret)
 		return ret;
@@ -1166,12 +1192,19 @@ static int smu_smc_table_hw_init(struct smu_context *smu,
 	if (ret)
 		return ret;
 
+	if (!smu_is_dpm_running(smu))
+		pr_info("dpm has been disabled\n");
+
 	ret = smu_disable_umc_cdr_12gbps_workaround(smu);
 	if (ret) {
 		pr_err("Workaround failed to disable UMC CDR feature on 12Gbps SKU!\n");
 		return ret;
 	}
 
+	ret = smu_override_pcie_parameters(smu);
+	if (ret)
+		return ret;
+
 	/*
 	 * For Navi1X, manually switch it to AC mode as PMFW
 	 * may boot it with DC mode.
@@ -1184,6 +1217,14 @@ static int smu_smc_table_hw_init(struct smu_context *smu,
 		return ret;
 	}
 
+	ret = smu_enable_thermal_alert(smu);
+	if (ret)
+		return ret;
+
+	ret = smu_i2c_eeprom_init(smu, &adev->pm.smu_i2c);
+	if (ret)
+		return ret;
+
 	ret = smu_notify_display_change(smu);
 	if (ret)
 		return ret;
@@ -1193,51 +1234,89 @@ static int smu_smc_table_hw_init(struct smu_context *smu,
 	 * SetMinDeepSleepDcefclk MSG.
 	 */
 	ret = smu_set_min_dcef_deep_sleep(smu);
-	if (ret)
-		return ret;
+
+	return ret;
+}
+
+static int smu_disable_dpms(struct smu_context *smu)
+{
+	struct amdgpu_device *adev = smu->adev;
+	int ret = 0;
+	bool use_baco = !smu->is_apu &&
+		((adev->in_gpu_reset &&
+		  (amdgpu_asic_reset_method(adev) == AMD_RESET_METHOD_BACO)) ||
+		 ((adev->in_runpm || adev->in_hibernate) && amdgpu_asic_supports_baco(adev)));
 
 	/*
-	 * Set initialized values (get from vbios) to dpm tables context such as
-	 * gfxclk, memclk, dcefclk, and etc. And enable the DPM feature for each
-	 * type of clks.
+	 * For custom pptable uploading, skip the DPM features
+	 * disable process on Navi1x ASICs.
+	 *   - As the gfx related features are under control of
+	 *     RLC on those ASICs. RLC reinitialization will be
+	 *     needed to reenable them. That will cost much more
+	 *     efforts.
+	 *
+	 *   - SMU firmware can handle the DPM reenablement
+	 *     properly.
 	 */
-	if (initialize) {
-		ret = smu_populate_smc_tables(smu);
-		if (ret)
-			return ret;
+	if (smu->uploading_custom_pp_table &&
+	    (adev->asic_type >= CHIP_NAVI10) &&
+	    (adev->asic_type <= CHIP_NAVI12))
+		return 0;
 
-		ret = smu_init_max_sustainable_clocks(smu);
-		if (ret)
+	/*
+	 * Disable all enabled SMU features.
+	 * This should be handled in SMU FW, as a backup
+	 * driver can issue call to SMU FW until sequence
+	 * in SMU FW is operational.
+	 */
+	ret = smu_system_features_control(smu, false);
+	if (ret) {
+		pr_err("Failed to disable smu features.\n");
+		return ret;
+	}
+
+	/*
+	 * For baco, need to leave BACO feature enabled
+	 *
+	 * Correct the way for checking whether SMU_FEATURE_BACO_BIT
+	 * is supported.
+	 *
+	 * Since 'smu_feature_is_enabled(smu, SMU_FEATURE_BACO_BIT)' will
+	 * always return false as the 'smu_system_features_control(smu, false)'
+	 * was just issued above which disabled all SMU features.
+	 *
+	 * Thus 'smu_feature_get_index(smu, SMU_FEATURE_BACO_BIT)' is used
+	 * now for the checking.
+	 */
+	if (use_baco && (smu_feature_get_index(smu, SMU_FEATURE_BACO_BIT) >= 0)) {
+		ret = smu_feature_set_enabled(smu, SMU_FEATURE_BACO_BIT, true);
+		if (ret) {
+			pr_warn("set BACO feature enabled failed, return %d\n", ret);
 			return ret;
+		}
 	}
 
-	ret = smu_override_pcie_parameters(smu);
-	if (ret)
-		return ret;
+	return ret;
+}
 
-	ret = smu_set_default_od_settings(smu);
-	if (ret)
-		return ret;
+static int smu_internal_hw_cleanup(struct smu_context *smu)
+{
+	struct amdgpu_device *adev = smu->adev;
+	int ret = 0;
 
-	if (initialize) {
-		ret = smu_populate_umd_state_clk(smu);
-		if (ret)
-			return ret;
+	smu_i2c_eeprom_fini(smu, &adev->pm.smu_i2c);
 
-		ret = smu_get_power_limit(smu, &smu->default_power_limit, false, false);
-		if (ret)
-			return ret;
+	ret = smu_disable_thermal_alert(smu);
+	if (ret) {
+		pr_warn("Fail to stop thermal control!\n");
+		return ret;
 	}
 
-	/*
-	 * Set PMSTATUSLOG table bo address with SetToolsDramAddr MSG for tools.
-	 */
-	ret = smu_set_tool_table_location(smu);
-
-	if (!smu_is_dpm_running(smu))
-		pr_info("dpm has been disabled\n");
+	ret = smu_disable_dpms(smu);
+	if (ret)
+		return ret;
 
-	return ret;
+	return 0;
 }
 
 static int smu_start_smc_engine(struct smu_context *smu)
@@ -1257,10 +1336,20 @@ static int smu_start_smc_engine(struct smu_context *smu)
 
 	if (smu->ppt_funcs->check_fw_status) {
 		ret = smu->ppt_funcs->check_fw_status(smu);
-		if (ret)
+		if (ret) {
 			pr_err("SMC is not ready\n");
+			return ret;
+		}
 	}
 
+	/*
+	 * Send msg GetDriverIfVersion to check if the return value is equal
+	 * with DRIVER_IF_VERSION of smc header.
+	 */
+	ret = smu_check_fw_version(smu);
+	if (ret)
+		return ret;
+
 	return ret;
 }
 
@@ -1289,99 +1378,24 @@ static int smu_hw_init(void *handle)
 	if (!smu->pm_enabled)
 		return 0;
 
-	ret = smu_feature_init_dpm(smu);
-	if (ret)
-		goto failed;
-
-	ret = smu_smc_table_hw_init(smu, true);
-	if (ret)
-		goto failed;
-
-	/*
-	 * Use msg SetSystemVirtualDramAddr and DramLogSetDramAddr can notify
-	 * pool location.
-	 */
-	ret = smu_notify_memory_pool_location(smu);
+	/* get boot_values from vbios to set revision, gfxclk, and etc. */
+	ret = smu_get_vbios_bootup_values(smu);
 	if (ret)
-		goto failed;
+		return ret;
 
-	ret = smu_enable_thermal_alert(smu);
+	ret = smu_setup_pptable(smu);
 	if (ret)
-		goto failed;
+		return ret;
 
-	ret = smu_i2c_eeprom_init(smu, &adev->pm.smu_i2c);
+	ret = smu_internal_hw_setup(smu);
 	if (ret)
-		goto failed;
+		return ret;
 
 	adev->pm.dpm_enabled = true;
 
 	pr_info("SMU is initialized successfully!\n");
 
 	return 0;
-
-failed:
-	return ret;
-}
-
-static int smu_disable_dpms(struct smu_context *smu)
-{
-	struct amdgpu_device *adev = smu->adev;
-	int ret = 0;
-	bool use_baco = !smu->is_apu &&
-		((adev->in_gpu_reset &&
-		  (amdgpu_asic_reset_method(adev) == AMD_RESET_METHOD_BACO)) ||
-		 ((adev->in_runpm || adev->in_hibernate) && amdgpu_asic_supports_baco(adev)));
-
-	/*
-	 * For custom pptable uploading, skip the DPM features
-	 * disable process on Navi1x ASICs.
-	 *   - As the gfx related features are under control of
-	 *     RLC on those ASICs. RLC reinitialization will be
-	 *     needed to reenable them. That will cost much more
-	 *     efforts.
-	 *
-	 *   - SMU firmware can handle the DPM reenablement
-	 *     properly.
-	 */
-	if (smu->uploading_custom_pp_table &&
-	    (adev->asic_type >= CHIP_NAVI10) &&
-	    (adev->asic_type <= CHIP_NAVI12))
-		return 0;
-
-	/*
-	 * Disable all enabled SMU features.
-	 * This should be handled in SMU FW, as a backup
-	 * driver can issue call to SMU FW until sequence
-	 * in SMU FW is operational.
-	 */
-	ret = smu_system_features_control(smu, false);
-	if (ret) {
-		pr_err("Failed to disable smu features.\n");
-		return ret;
-	}
-
-	/*
-	 * For baco, need to leave BACO feature enabled
-	 *
-	 * Correct the way for checking whether SMU_FEATURE_BACO_BIT
-	 * is supported.
-	 *
-	 * Since 'smu_feature_is_enabled(smu, SMU_FEATURE_BACO_BIT)' will
-	 * always return false as the 'smu_system_features_control(smu, false)'
-	 * was just issued above which disabled all SMU features.
-	 *
-	 * Thus 'smu_feature_get_index(smu, SMU_FEATURE_BACO_BIT)' is used
-	 * now for the checking.
-	 */
-	if (use_baco && (smu_feature_get_index(smu, SMU_FEATURE_BACO_BIT) >= 0)) {
-		ret = smu_feature_set_enabled(smu, SMU_FEATURE_BACO_BIT, true);
-		if (ret) {
-			pr_warn("set BACO feature enabled failed, return %d\n", ret);
-			return ret;
-		}
-	}
-
-	return ret;
 }
 
 static int smu_hw_fini(void *handle)
@@ -1404,19 +1418,9 @@ static int smu_hw_fini(void *handle)
 
 	adev->pm.dpm_enabled = false;
 
-	smu_i2c_eeprom_fini(smu, &adev->pm.smu_i2c);
-
-	ret = smu_disable_thermal_alert(smu);
-	if (ret) {
-		pr_warn("Fail to stop thermal control!\n");
-		return ret;
-	}
-
-	ret = smu_disable_dpms(smu);
-	if (ret) {
-		pr_warn("Fail to stop Dpms!\n");
+	ret = smu_internal_hw_cleanup(smu);
+	if (ret)
 		return ret;
-	}
 
 	return 0;
 }
@@ -1434,6 +1438,8 @@ int smu_reset(struct smu_context *smu)
 	if (ret)
 		return ret;
 
+	ret = smu_late_init(adev);
+
 	return ret;
 }
 
@@ -1451,15 +1457,7 @@ static int smu_suspend(void *handle)
 
 	adev->pm.dpm_enabled = false;
 
-	smu_i2c_eeprom_fini(smu, &adev->pm.smu_i2c);
-
-	ret = smu_disable_thermal_alert(smu);
-	if (ret) {
-		pr_warn("Fail to stop thermal control!\n");
-		return ret;
-	}
-
-	ret = smu_disable_dpms(smu);
+	ret = smu_internal_hw_cleanup(smu);
 	if (ret)
 		return ret;
 
@@ -1491,20 +1489,12 @@ static int smu_resume(void *handle)
 	ret = smu_start_smc_engine(smu);
 	if (ret) {
 		pr_err("SMU is not ready yet!\n");
-		goto failed;
+		return ret;
 	}
 
-	ret = smu_smc_table_hw_init(smu, false);
-	if (ret)
-		goto failed;
-
-	ret = smu_enable_thermal_alert(smu);
-	if (ret)
-		goto failed;
-
-	ret = smu_i2c_eeprom_init(smu, &adev->pm.smu_i2c);
+	ret = smu_internal_hw_setup(smu);
 	if (ret)
-		goto failed;
+		return ret;
 
 	if (smu->is_apu)
 		smu_set_gfx_cgpg(&adev->smu, true);
@@ -1516,9 +1506,6 @@ static int smu_resume(void *handle)
 	pr_info("SMU is resumed successfully!\n");
 
 	return 0;
-
-failed:
-	return ret;
 }
 
 int smu_display_configuration_change(struct smu_context *smu,
-- 
2.26.2

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
