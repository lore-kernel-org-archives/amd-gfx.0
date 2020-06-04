Return-Path: <SRS0=gI7v=7R=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6506DC433E0
	for <amd-gfx@archiver.kernel.org>; Thu,  4 Jun 2020 04:46:50 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 36C702072E
	for <amd-gfx@archiver.kernel.org>; Thu,  4 Jun 2020 04:46:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="tAcTloqS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 36C702072E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8B43389F85;
	Thu,  4 Jun 2020 04:46:49 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2058.outbound.protection.outlook.com [40.107.223.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0A41489F85
 for <amd-gfx@lists.freedesktop.org>; Thu,  4 Jun 2020 04:46:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=btlAjNiSxtIx6pmA70+HCW/TteA5+Hj/L3vwnbpvOYdI1X3EL+XoJSFHw0JDNnQwR6Ct5t3mw7+lA1Nm368+OO0LCvxp1qMdu5PuhIJ4BMOg872O7l7IkDQ7oDuSDvfSP+JcwACWlgzJA3Xa63nc3g+OcReetLEvgnkAv9UXpm9vpidjKZGfZ2WvPFLtcTgXUqoUi2CALGuN4a8I2o4G/G4OH8hfklXZolv6FWk0XOvvNEtWptfgNVFCd5JFEsnpvEdn1Qs6II0K/b898IhGXKBD8i7aAxaAcwFvYdnTHZb1HQI8FXhf6sEhnqZdZzeYBU2vbznmXL14eay2SespTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=teoWZsnKIiXRaX3cQ7x/ryyOnNP+oxMdGutYciUCZOs=;
 b=DmjKC8uoeBtbGfdpMX5KAlhHMwYG3L07V78brwRf52nK1zUxaQkMlOnNoHgMgY1DujcR6IgSJviZMqWd80K8mNW9ELb7tok0ztRBCpWFrUJ9nNo+5KL+FZ8/HMTX7qfZBaLAvVBgV4/dzzakwf28uya+2ecKg6ViymEQdFr5IPo+T5RCBm2TpnkFA/cCcxczWP3HQ5scglL8t968IIrV3tPsCGScmYj60AnxIQ+TE5RmkBkenMD2VDbtuvN1epnp7gSZhRx3j3togaQdlNpn5EUxHLrGFzfnguzvarnm8V0z4LAddWYW9r2uc7x9i7cQGNNKE8LIfj+tQdu4AyAKsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=teoWZsnKIiXRaX3cQ7x/ryyOnNP+oxMdGutYciUCZOs=;
 b=tAcTloqS7xMiFx+l7xQCYmTNZ2mUa5e4deAWl435zywzL/jIDaxoB9Gm9PkjX+OOYWudfjARQShAz3Z7iKukT7i5X/SVXAG+FWIquKDa0I5qs6Af9c3Z4lAdrTR+2NFLph9lRzYWBKI0pZITCodoJnrxExRCEWMvINCQDcCADtg=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM6PR12MB3002.namprd12.prod.outlook.com (2603:10b6:5:117::15) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3066.18; Thu, 4 Jun 2020 04:46:45 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::c157:8999:dcc3:536f]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::c157:8999:dcc3:536f%3]) with mapi id 15.20.3045.022; Thu, 4 Jun 2020
 04:46:45 +0000
From: Evan Quan <evan.quan@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 01/16] drm/amd/powerplay: eliminate asic type check
Date: Thu,  4 Jun 2020 12:46:04 +0800
Message-Id: <20200604044619.18658-1-evan.quan@amd.com>
X-Mailer: git-send-email 2.27.0
X-ClientProxiedBy: HK0PR01CA0071.apcprd01.prod.exchangelabs.com
 (2603:1096:203:a6::35) To DM6PR12MB2619.namprd12.prod.outlook.com
 (2603:10b6:5:45::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from equan-buildpc.amd.com (58.247.170.242) by
 HK0PR01CA0071.apcprd01.prod.exchangelabs.com (2603:1096:203:a6::35) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3066.18 via Frontend
 Transport; Thu, 4 Jun 2020 04:46:43 +0000
X-Mailer: git-send-email 2.27.0
X-Originating-IP: [58.247.170.242]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 3b9a6023-6c06-4a35-e89f-08d808424861
X-MS-TrafficTypeDiagnostic: DM6PR12MB3002:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB3002494907809CB0815B9838E4890@DM6PR12MB3002.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2043;
X-Forefront-PRVS: 04244E0DC5
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QIQ5KUzHsOweMpA07DMDo1T9ja6hxL7UM01shcqcPxcUawWAHUi9jwsElUnVYLCJPKZvId6j7KpPMGZ2fuTumCoTW34cLM+I6a1RzoGAYdME+o68/ZDiPjlmchDm61qtiUN8RjdczS28EsFfjQZr9qTt9hKcUYs2WLlmJvMpB4YEVoEdjGyz7QtJpLIfmn5UzUyh+1jgRzk1fhN90GELOpwFCT/M6e+KiwMRgtHVS8VE/sD6PcLQS7Em91V5ZsSHu7G5hqCchV0DKPwzBu5NYcNLVRxrJEDybEnf/JsjFKChJPfJPjq8fCo5e0te+y2x9sGvCDZa+RYwvXlH9OnibQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(39860400002)(366004)(346002)(396003)(376002)(136003)(7696005)(1076003)(52116002)(36756003)(2616005)(26005)(316002)(16526019)(83380400001)(6666004)(6486002)(86362001)(5660300002)(186003)(956004)(6916009)(4326008)(66946007)(2906002)(44832011)(8936002)(66476007)(66556008)(478600001)(8676002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: oQv9dKiEHVyC/jy/YygQvyNZmuF+oAdfwct3L9SU5xuGNHiv3oyHUtrVW+ZIZHfq5LqJnHQtkO/23rUoHgVcSLljfFtxFj+Ck3tNskHGosUkxHQ4rH1ou8V1xC8TnMYN3DGJOeF/mq/pvUurenUlOypjl1QPWcjvUcv2xZF0M5i4e7iUiYie2/RZPY7jMfyJzCyWve/Ls3KXe9FsdENgD8EMG8PFxlnZw5xQlFqOv5luqKOsFi+LzvLIWlZ4p9ijC20vFVFTv6nY/m3bcUccvbA9dgSPtDilqVaoEAcX5qPRp9NPTDNWhwMhxdwEwYZIqacSIJACC1wl62ysQPeQImJHK9NuZtdmR9Lv2wVi5UstEi73OqjOYwYHIMo3GTo5BjVE+S4ov4/jW0pPMFhxOOfYOYKkjy82VeEhHmuPA6z8KgevJcn04E8fYhKwbsvm81PHoQc+31GZhxEuHlPwt0e0vZWfymfQI1U10oj8b79gZlbU+ijnNKpBpfNVnW3/
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b9a6023-6c06-4a35-e89f-08d808424861
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2020 04:46:44.9754 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gKuRZzAttfkBqtAfk163zKib8wtnClEldG/k1B6QbM62mWRR8X6BJihpkNqWPBz2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3002
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

By moving ASIC specific code into its own file.

Change-Id: Ib6775c1c8c5211ea45db6c3fb604a8279411ab37
Signed-off-by: Evan Quan <evan.quan@amd.com>
---
 drivers/gpu/drm/amd/powerplay/amdgpu_smu.c    | 59 +++++++------------
 drivers/gpu/drm/amd/powerplay/arcturus_ppt.c  |  8 +--
 drivers/gpu/drm/amd/powerplay/navi10_ppt.c    | 18 ++++++
 .../drm/amd/powerplay/sienna_cichlid_ppt.c    |  6 +-
 drivers/gpu/drm/amd/powerplay/smu_v11_0.c     |  5 --
 5 files changed, 45 insertions(+), 51 deletions(-)

diff --git a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
index 78ab0d46eddd..b2c1ad95edf7 100644
--- a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
@@ -1055,12 +1055,9 @@ static int smu_smc_table_hw_init(struct smu_context *smu,
 		return 0;
 	}
 
-	if (adev->asic_type != CHIP_ARCTURUS &&
-	    adev->asic_type != CHIP_SIENNA_CICHLID) {
-		ret = smu_init_display_count(smu, 0);
-		if (ret)
-			return ret;
-	}
+	ret = smu_init_display_count(smu, 0);
+	if (ret)
+		return ret;
 
 	if (initialize) {
 		/* get boot_values from vbios to set revision, gfxclk, and etc. */
@@ -1134,21 +1131,10 @@ static int smu_smc_table_hw_init(struct smu_context *smu,
 	if (ret)
 		return ret;
 
-	if (adev->asic_type == CHIP_NAVI10) {
-		if ((adev->pdev->device == 0x731f && (adev->pdev->revision == 0xc2 ||
-						      adev->pdev->revision == 0xc3 ||
-						      adev->pdev->revision == 0xca ||
-						      adev->pdev->revision == 0xcb)) ||
-		    (adev->pdev->device == 0x66af && (adev->pdev->revision == 0xf3 ||
-						      adev->pdev->revision == 0xf4 ||
-						      adev->pdev->revision == 0xf5 ||
-						      adev->pdev->revision == 0xf6))) {
-			ret = smu_disable_umc_cdr_12gbps_workaround(smu);
-			if (ret) {
-				pr_err("Workaround failed to disable UMC CDR feature on 12Gbps SKU!\n");
-				return ret;
-			}
-		}
+	ret = smu_disable_umc_cdr_12gbps_workaround(smu);
+	if (ret) {
+		pr_err("Workaround failed to disable UMC CDR feature on 12Gbps SKU!\n");
+		return ret;
 	}
 
 	if (smu->ppt_funcs->set_power_source) {
@@ -1166,20 +1152,17 @@ static int smu_smc_table_hw_init(struct smu_context *smu,
 		}
 	}
 
-	if (adev->asic_type != CHIP_ARCTURUS &&
-	    adev->asic_type != CHIP_SIENNA_CICHLID) {
-		ret = smu_notify_display_change(smu);
-		if (ret)
-			return ret;
+	ret = smu_notify_display_change(smu);
+	if (ret)
+		return ret;
 
-		/*
-		 * Set min deep sleep dce fclk with bootup value from vbios via
-		 * SetMinDeepSleepDcefclk MSG.
-		 */
-		ret = smu_set_min_dcef_deep_sleep(smu);
-		if (ret)
-			return ret;
-	}
+	/*
+	 * Set min deep sleep dce fclk with bootup value from vbios via
+	 * SetMinDeepSleepDcefclk MSG.
+	 */
+	ret = smu_set_min_dcef_deep_sleep(smu);
+	if (ret)
+		return ret;
 
 	/*
 	 * Set initialized values (get from vbios) to dpm tables context such as
@@ -1196,11 +1179,9 @@ static int smu_smc_table_hw_init(struct smu_context *smu,
 			return ret;
 	}
 
-	if (adev->asic_type != CHIP_ARCTURUS) {
-		ret = smu_override_pcie_parameters(smu);
-		if (ret)
-			return ret;
-	}
+	ret = smu_override_pcie_parameters(smu);
+	if (ret)
+		return ret;
 
 	ret = smu_set_default_od_settings(smu, initialize);
 	if (ret)
diff --git a/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c b/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c
index df7b408319f7..1de5304d12bf 100644
--- a/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c
+++ b/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c
@@ -2463,16 +2463,16 @@ static const struct pptable_funcs arcturus_ppt_funcs = {
 	.populate_smc_tables = smu_v11_0_populate_smc_pptable,
 	.check_fw_version = smu_v11_0_check_fw_version,
 	.write_pptable = smu_v11_0_write_pptable,
-	.set_min_dcef_deep_sleep = smu_v11_0_set_min_dcef_deep_sleep,
+	.set_min_dcef_deep_sleep = NULL,
 	.set_driver_table_location = smu_v11_0_set_driver_table_location,
 	.set_tool_table_location = smu_v11_0_set_tool_table_location,
 	.notify_memory_pool_location = smu_v11_0_notify_memory_pool_location,
 	.system_features_control = smu_v11_0_system_features_control,
 	.send_smc_msg_with_param = smu_v11_0_send_msg_with_param,
-	.init_display_count = smu_v11_0_init_display_count,
+	.init_display_count = NULL,
 	.set_allowed_mask = smu_v11_0_set_allowed_mask,
 	.get_enabled_mask = smu_v11_0_get_enabled_mask,
-	.notify_display_change = smu_v11_0_notify_display_change,
+	.notify_display_change = NULL,
 	.set_power_limit = smu_v11_0_set_power_limit,
 	.get_current_clk_freq = smu_v11_0_get_current_clk_freq,
 	.init_max_sustainable_clocks = smu_v11_0_init_max_sustainable_clocks,
@@ -2496,7 +2496,7 @@ static const struct pptable_funcs arcturus_ppt_funcs = {
 	.baco_exit = smu_v11_0_baco_exit,
 	.get_dpm_ultimate_freq = smu_v11_0_get_dpm_ultimate_freq,
 	.set_soft_freq_limited_range = smu_v11_0_set_soft_freq_limited_range,
-	.override_pcie_parameters = smu_v11_0_override_pcie_parameters,
+	.override_pcie_parameters = NULL,
 	.get_pptable_power_limit = arcturus_get_pptable_power_limit,
 	.set_df_cstate = arcturus_set_df_cstate,
 	.allow_xgmi_power_down = arcturus_allow_xgmi_power_down,
diff --git a/drivers/gpu/drm/amd/powerplay/navi10_ppt.c b/drivers/gpu/drm/amd/powerplay/navi10_ppt.c
index 68142f6798c6..a43c16befffd 100644
--- a/drivers/gpu/drm/amd/powerplay/navi10_ppt.c
+++ b/drivers/gpu/drm/amd/powerplay/navi10_ppt.c
@@ -2209,12 +2209,30 @@ static int navi10_dummy_pstate_control(struct smu_context *smu, bool enable)
 	return result;
 }
 
+static inline bool navi10_need_umc_cdr_12gbps_workaround(struct amdgpu_device *adev)
+{
+	if (adev->asic_type != CHIP_NAVI10)
+		return false;
+
+	if (adev->pdev->device == 0x731f &&
+	    (adev->pdev->revision == 0xc2 ||
+	     adev->pdev->revision == 0xc3 ||
+	     adev->pdev->revision == 0xca ||
+	     adev->pdev->revision == 0xcb))
+		return true;
+	else
+		return false;
+}
+
 static int navi10_disable_umc_cdr_12gbps_workaround(struct smu_context *smu)
 {
 	uint32_t uclk_count, uclk_min, uclk_max;
 	uint32_t smu_version;
 	int ret = 0;
 
+	if (!navi10_need_umc_cdr_12gbps_workaround(smu->adev))
+		return 0;
+
 	ret = smu_get_smc_version(smu, NULL, &smu_version);
 	if (ret)
 		return ret;
diff --git a/drivers/gpu/drm/amd/powerplay/sienna_cichlid_ppt.c b/drivers/gpu/drm/amd/powerplay/sienna_cichlid_ppt.c
index ce16cabb0780..f83df6adcbce 100644
--- a/drivers/gpu/drm/amd/powerplay/sienna_cichlid_ppt.c
+++ b/drivers/gpu/drm/amd/powerplay/sienna_cichlid_ppt.c
@@ -2463,16 +2463,16 @@ static const struct pptable_funcs sienna_cichlid_ppt_funcs = {
 	.populate_smc_tables = smu_v11_0_populate_smc_pptable,
 	.check_fw_version = smu_v11_0_check_fw_version,
 	.write_pptable = smu_v11_0_write_pptable,
-	.set_min_dcef_deep_sleep = smu_v11_0_set_min_dcef_deep_sleep,
+	.set_min_dcef_deep_sleep = NULL,
 	.set_driver_table_location = smu_v11_0_set_driver_table_location,
 	.set_tool_table_location = smu_v11_0_set_tool_table_location,
 	.notify_memory_pool_location = smu_v11_0_notify_memory_pool_location,
 	.system_features_control = smu_v11_0_system_features_control,
 	.send_smc_msg_with_param = smu_v11_0_send_msg_with_param,
-	.init_display_count = smu_v11_0_init_display_count,
+	.init_display_count = NULL,
 	.set_allowed_mask = smu_v11_0_set_allowed_mask,
 	.get_enabled_mask = smu_v11_0_get_enabled_mask,
-	.notify_display_change = smu_v11_0_notify_display_change,
+	.notify_display_change = NULL,
 	.set_power_limit = smu_v11_0_set_power_limit,
 	.get_current_clk_freq = smu_v11_0_get_current_clk_freq,
 	.init_max_sustainable_clocks = smu_v11_0_init_max_sustainable_clocks,
diff --git a/drivers/gpu/drm/amd/powerplay/smu_v11_0.c b/drivers/gpu/drm/amd/powerplay/smu_v11_0.c
index 06b376a1396d..d4509ceb7854 100644
--- a/drivers/gpu/drm/amd/powerplay/smu_v11_0.c
+++ b/drivers/gpu/drm/amd/powerplay/smu_v11_0.c
@@ -836,11 +836,6 @@ int smu_v11_0_set_tool_table_location(struct smu_context *smu)
 int smu_v11_0_init_display_count(struct smu_context *smu, uint32_t count)
 {
 	int ret = 0;
-	struct amdgpu_device *adev = smu->adev;
-
-	/* Sienna_Cichlid do not support to change display num currently */
-	if (adev->asic_type == CHIP_SIENNA_CICHLID)
-		return 0;
 
 	if (!smu->pm_enabled)
 		return ret;
-- 
2.27.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
