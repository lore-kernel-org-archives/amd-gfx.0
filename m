Return-Path: <SRS0=C/bZ=FX=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F42BC2D0E4
	for <amd-gfx@archiver.kernel.org>; Sat, 19 Dec 2020 00:49:11 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EFBCE2343F
	for <amd-gfx@archiver.kernel.org>; Sat, 19 Dec 2020 00:49:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EFBCE2343F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2F13989CCE;
	Sat, 19 Dec 2020 00:49:09 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2070.outbound.protection.outlook.com [40.107.223.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 76E5C89C6A
 for <amd-gfx@lists.freedesktop.org>; Sat, 19 Dec 2020 00:49:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Pmg8ESV/vTlDjG38GxX0Bq8/ym0K0Z58n0hbLW/qgMjJTLFbNR/ExrNDnhC8Mv85mD4ymkgMlejT66Yw2akjjWW62RUa3Bs2T1zW8IZPSdB1OKcpQ8xEVDUcpGUH14/5alMusyvOMttwTKgu/aJs68lz3ABQliuoLSHt8Gv8aepHNOg3CdL4oMrMz8mFN3mMU5b6UsMBqNoYg8Ybs0oAyfeXdhpsG9ddf0tEY+qloA21gUWghgyEq6/YnYXWU5IK41iQl5m8L0zsplWqo8QKlcwDUYP942fSitP4VVYsh+2rnaQ9SEI689ILeWJHwSYuVFFieA4M/es/CqngSEhF+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5KK8TN0QE1+ks/koVfVIcz2zEeuRP3GsFE1ykOSRYk8=;
 b=TDk03Xf/NGE6WchO2Yil9AKMM/IRrVvMgwTikBtXATvrKFeufglWwxOL7a8b/KwewaBrZRsPkRFU3dlSZFBzOwkoNiVqLcVKl+9uyxaRub3ZpslGg9LdRIajCs/NG53ycCnaS+WAXTEx1tQi4dYU48/8ySaerL6KVL5phQJo/2IFW2YAjcoSBmoS74n2qlTp+1LgcU4sPhU2fymCsev/0lCQro1ZoQrLve4Vu/Sw3HvzpOqqLWIrPvcu4uZB5/xykrmFGrrwpxUX2nvdgdB14RXKshopplPXJ2eS8YbwbLiFDtFR2xP/+VjLgdjdVO+kCJOmyo1hrLU0NiOgP48wyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5KK8TN0QE1+ks/koVfVIcz2zEeuRP3GsFE1ykOSRYk8=;
 b=1bXBnORFH2noqvFX6WuGykWFVz6tcfXa/kIIpJ1olPwAjtYcHuAVJwiu1O31yI7R6e46fRIhh6HyWXvWcTF3ILpccBwFYBs75KoRpP5abbrxaWzZoOktY7QrO7coDGYL7t94WkTKCX/umtPjgCZpPPfLZKkQ1UgZb0KeBIDt9ek=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB2959.namprd12.prod.outlook.com (2603:10b6:208:ae::29)
 by MN2PR12MB3279.namprd12.prod.outlook.com (2603:10b6:208:105::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3654.15; Sat, 19 Dec
 2020 00:49:05 +0000
Received: from MN2PR12MB2959.namprd12.prod.outlook.com
 ([fe80::dd1e:ce4b:cd7e:2804]) by MN2PR12MB2959.namprd12.prod.outlook.com
 ([fe80::dd1e:ce4b:cd7e:2804%7]) with mapi id 15.20.3654.020; Sat, 19 Dec 2020
 00:49:05 +0000
From: Darren Powell <darren.powell@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 2/8] amdgpu/pm: Powerplay API for smu ,
 changed 6 dpm reset functions to use API
Date: Fri, 18 Dec 2020 19:48:25 -0500
Message-Id: <20201219004831.13527-3-darren.powell@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201219004831.13527-1-darren.powell@amd.com>
References: <20201219004831.13527-1-darren.powell@amd.com>
X-Originating-IP: [142.126.168.115]
X-ClientProxiedBy: YT1PR01CA0114.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2c::23) To MN2PR12MB2959.namprd12.prod.outlook.com
 (2603:10b6:208:ae::29)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (142.126.168.115) by
 YT1PR01CA0114.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:2c::23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3676.28 via Frontend Transport; Sat, 19 Dec 2020 00:49:05 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 87f97808-72fc-4793-8313-08d8a3b7e339
X-MS-TrafficTypeDiagnostic: MN2PR12MB3279:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB3279A5945361FD0E684016C7F0C20@MN2PR12MB3279.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dVXCqCihxiRGORUZFKKBUKVftduAHL5LTrlNrKdFD/9Lo/PdDx0gv9iUD8oaAdZQ0dvBNwaXTO3+f81e6X7iYtpIMYh0N5BPFaAqrtlpMrLzFJKfr4Ldh9rpItaoxkiJwF/lj1VZftWvQpcfucCDXSIz0L7NrfLcNTdjzTmaRWmh1wZO0yoSAA5pQyJ1x2GpX7gf46W79ZksPiTh0IQPOV9DmxvEXpSk81g1V0Wgvj4QZAdT/CxlKJ2ZUT0p/ldql27ECb9NUvTJ11yp7380fRDrx77ZjTPvuix/dL+wrVfeOCdYbUfSdj2FwScRY0k9OxRYXmpAHgUdPdj9Wd+7rpdT2pGEC22fIG4b33I5ocr6mcHkVE+ATMSf5zRVyvk1
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB2959.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(366004)(396003)(346002)(39860400002)(376002)(956004)(2616005)(44832011)(26005)(66476007)(66946007)(6506007)(6666004)(86362001)(66556008)(5660300002)(69590400008)(36756003)(1076003)(83380400001)(186003)(316002)(16526019)(52116002)(6916009)(2906002)(4326008)(8936002)(6512007)(8676002)(6486002)(478600001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?stdBVCEFYa7iBygtDrJSW/CQztskeLEFoF1TiMUVwCR654VMhvuCgYG88kRx?=
 =?us-ascii?Q?c4R7IhZ/oj+7TX+P+xqUZymIvkZ2Lt7TZapuCfXspaGuhafbDYeC13DXFSa6?=
 =?us-ascii?Q?tcYrWO6lPrjuDj9sviIJlvTbJ1U9qu/64KZeZZioQf9hEyTA4wFiTrikNUVd?=
 =?us-ascii?Q?XrGquuj351oJbIgraibaBm5sq/Yiq0cwHzetaZv4f27vRK0a8j2fAuOJRqC8?=
 =?us-ascii?Q?+wf7QWNkKpVbxKefG9qR88SU7slQTXePcxWp/g2VJg9CAY1VR3yvZfqOUcNL?=
 =?us-ascii?Q?sOfoQqLtrWVd9QrqzDiYJr33K4pA4BRVihtRuWulYivfMoOiyFW75n7j8QlB?=
 =?us-ascii?Q?cX4LL32in+SmliOD0cWwYcBHMqsCpRFPzNY+3d0oZ8Q1kBatgfYtNz7MkekT?=
 =?us-ascii?Q?DNdT2fA7bsdhyQx9aa3O7xuX16PLBodalJtV/JNihoOs+nNS5TLdZz5gdtZe?=
 =?us-ascii?Q?Wf7dL8tgbc1C/h9hxhukkuV3hl1ytfRXcellYI2NtVj5D0A7YM3GB0aA6/QW?=
 =?us-ascii?Q?GHxEd/aD38dXeZFWF7F1h4dktwqGVZQ0h1cMsdq46zzSUkSFnn4/4C1ttDGH?=
 =?us-ascii?Q?v+nB9+ho5nv4Lgyuo3hNtU/styBIcNZSM6wfKUIea3i/kFW/kpKdPHQTtlDp?=
 =?us-ascii?Q?+drpXgbwzeGMxiC2FKjBxY5BtSh3/HWkb5MrVXNO/4J0FzyqgUEGF+Gyh8Qc?=
 =?us-ascii?Q?XaHtr1xvHCLN1M6nqbWJXY1Ah0iBULYElN3KCtBS7h3uRxwUEfLOCT1/gKRa?=
 =?us-ascii?Q?oJvpYL2W56KuZz0xA04ldm16RCvWIeF0Ztc+I1Uakt6XLg4wmSWth1zjkD0y?=
 =?us-ascii?Q?UiL36h0SN/5KJWobSkeT/2eHE62b3rn2ApuOJ56Qgl2DDZQRMptemsxBJSto?=
 =?us-ascii?Q?1BRI4MVhyuSaMhChtSylGWX7wsIUpmiNrFMSY56/jqwGMNl2vl4S2y5AayKb?=
 =?us-ascii?Q?JFoXH3E2epZNs8xW5og6wDYq8h3bvP0+B8F8dRTblCr4fCm7kewfoBi5Utfx?=
 =?us-ascii?Q?hcHH?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB2959.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Dec 2020 00:49:05.5157 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-Network-Message-Id: 87f97808-72fc-4793-8313-08d8a3b7e339
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Q0nnqHiwZRpjyJ9uOXXJdkGgBRVBtjcRFfBI/fsPIkHJzTkGKbGOYXayLkmoqz+Tjj6KnNKppxoRrzHA2VZlsA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3279
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
Cc: Darren Powell <darren.powell@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Modified Functions
  smu_set_xgmi_pstate()       - modifed arg0 to match Powerplay API set_xgmi_pstate
  smu_mode2_reset()           - modifed arg0 to match Powerplay API asic_reset_mode_2
  smu_switch_power_profile()  - modifed arg0 to match Powerplay API switch_power_profile
  smu_set_mp1_state()         - modifed arg0 to match Powerplay API set_mp1_state
  smu_set_df_cstate()         - modifed arg0 to match Powerplay API set_df_cstate
  smu_enable_mgpu_fan_boost() - modifed arg0 to match Powerplay API enable_mgpu_fan_boost

Other Changes
  added above smu reset Powerplay functions to swsmu_dpm_funcs
  removed special smu handling of above functions and called through Powerplay API

Signed-off-by: Darren Powell <darren.powell@amd.com>
---
 drivers/gpu/drm/amd/pm/amdgpu_dpm.c       | 46 +++++++----------------
 drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h   | 12 +++---
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c | 27 ++++++++++---
 3 files changed, 41 insertions(+), 44 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
index 8fb12afe3c96..df5e7b573428 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
@@ -1059,12 +1059,10 @@ int amdgpu_dpm_set_mp1_state(struct amdgpu_device *adev,
 			     enum pp_mp1_state mp1_state)
 {
 	int ret = 0;
+	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
 
-	if (is_support_sw_smu(adev)) {
-		ret = smu_set_mp1_state(&adev->smu, mp1_state);
-	} else if (adev->powerplay.pp_funcs &&
-		   adev->powerplay.pp_funcs->set_mp1_state) {
-		ret = adev->powerplay.pp_funcs->set_mp1_state(
+	if (pp_funcs && pp_funcs->set_mp1_state) {
+		ret = pp_funcs->set_mp1_state(
 				adev->powerplay.pp_handle,
 				mp1_state);
 	}
@@ -1096,16 +1094,11 @@ int amdgpu_dpm_mode2_reset(struct amdgpu_device *adev)
 {
 	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
 	void *pp_handle = adev->powerplay.pp_handle;
-	struct smu_context *smu = &adev->smu;
 
-	if (is_support_sw_smu(adev)) {
-		return smu_mode2_reset(smu);
-	} else {
-		if (!pp_funcs || !pp_funcs->asic_reset_mode_2)
-			return -ENOENT;
+	if (!pp_funcs || !pp_funcs->asic_reset_mode_2)
+		return -ENOENT;
 
-		return pp_funcs->asic_reset_mode_2(pp_handle);
-	}
+	return pp_funcs->asic_reset_mode_2(pp_handle);
 }
 
 int amdgpu_dpm_baco_reset(struct amdgpu_device *adev)
@@ -1166,16 +1159,14 @@ int amdgpu_dpm_switch_power_profile(struct amdgpu_device *adev,
 				    enum PP_SMC_POWER_PROFILE type,
 				    bool en)
 {
+	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
 	int ret = 0;
 
 	if (amdgpu_sriov_vf(adev))
 		return 0;
 
-	if (is_support_sw_smu(adev))
-		ret = smu_switch_power_profile(&adev->smu, type, en);
-	else if (adev->powerplay.pp_funcs &&
-		 adev->powerplay.pp_funcs->switch_power_profile)
-		ret = adev->powerplay.pp_funcs->switch_power_profile(
+	if (pp_funcs && pp_funcs->switch_power_profile)
+		ret = pp_funcs->switch_power_profile(
 			adev->powerplay.pp_handle, type, en);
 
 	return ret;
@@ -1184,13 +1175,11 @@ int amdgpu_dpm_switch_power_profile(struct amdgpu_device *adev,
 int amdgpu_dpm_set_xgmi_pstate(struct amdgpu_device *adev,
 			       uint32_t pstate)
 {
+	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
 	int ret = 0;
 
-	if (is_support_sw_smu(adev))
-		ret = smu_set_xgmi_pstate(&adev->smu, pstate);
-	else if (adev->powerplay.pp_funcs &&
-		 adev->powerplay.pp_funcs->set_xgmi_pstate)
-		ret = adev->powerplay.pp_funcs->set_xgmi_pstate(adev->powerplay.pp_handle,
+	if (pp_funcs && pp_funcs->set_xgmi_pstate)
+		ret = pp_funcs->set_xgmi_pstate(adev->powerplay.pp_handle,
 								pstate);
 
 	return ret;
@@ -1202,12 +1191,8 @@ int amdgpu_dpm_set_df_cstate(struct amdgpu_device *adev,
 	int ret = 0;
 	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
 	void *pp_handle = adev->powerplay.pp_handle;
-	struct smu_context *smu = &adev->smu;
 
-	if (is_support_sw_smu(adev))
-		ret = smu_set_df_cstate(smu, cstate);
-	else if (pp_funcs &&
-		 pp_funcs->set_df_cstate)
+	if (pp_funcs && pp_funcs->set_df_cstate)
 		ret = pp_funcs->set_df_cstate(pp_handle, cstate);
 
 	return ret;
@@ -1228,12 +1213,9 @@ int amdgpu_dpm_enable_mgpu_fan_boost(struct amdgpu_device *adev)
 	void *pp_handle = adev->powerplay.pp_handle;
 	const struct amd_pm_funcs *pp_funcs =
 			adev->powerplay.pp_funcs;
-	struct smu_context *smu = &adev->smu;
 	int ret = 0;
 
-	if (is_support_sw_smu(adev))
-		ret = smu_enable_mgpu_fan_boost(smu);
-	else if (pp_funcs && pp_funcs->enable_mgpu_fan_boost)
+	if (pp_funcs && pp_funcs->enable_mgpu_fan_boost)
 		ret = pp_funcs->enable_mgpu_fan_boost(pp_handle);
 
 	return ret;
diff --git a/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h b/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
index 10914f3438ac..6713f28c5fde 100644
--- a/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
+++ b/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
@@ -695,7 +695,7 @@ int smu_display_clock_voltage_request(struct smu_context *smu,
 				      struct pp_display_clock_request *clock_req);
 int smu_display_disable_memory_clock_switch(struct smu_context *smu, bool disable_memory_clock_switch);
 
-int smu_set_xgmi_pstate(struct smu_context *smu,
+int smu_set_xgmi_pstate(void *handle,
 			uint32_t pstate);
 
 int smu_set_azalia_d3_pme(struct smu_context *smu);
@@ -709,7 +709,7 @@ int smu_baco_exit(struct smu_context *smu);
 
 bool smu_mode1_reset_is_support(struct smu_context *smu);
 int smu_mode1_reset(struct smu_context *smu);
-int smu_mode2_reset(struct smu_context *smu);
+int smu_mode2_reset(void *handle);
 
 extern const struct amd_ip_funcs smu_ip_funcs;
 
@@ -736,7 +736,7 @@ extern int smu_handle_task(struct smu_context *smu,
 			   enum amd_dpm_forced_level level,
 			   enum amd_pp_task task_id,
 			   bool lock_needed);
-int smu_switch_power_profile(struct smu_context *smu,
+int smu_switch_power_profile(void *handle,
 			     enum PP_SMC_POWER_PROFILE type,
 			     bool en);
 int smu_get_dpm_freq_range(struct smu_context *smu, enum smu_clk_type clk_type,
@@ -752,9 +752,9 @@ int smu_sys_set_pp_feature_mask(struct smu_context *smu, uint64_t new_mask);
 int smu_force_clk_levels(struct smu_context *smu,
 			 enum smu_clk_type clk_type,
 			 uint32_t mask);
-int smu_set_mp1_state(struct smu_context *smu,
+int smu_set_mp1_state(void *handle,
 		      enum pp_mp1_state mp1_state);
-int smu_set_df_cstate(struct smu_context *smu,
+int smu_set_df_cstate(void *handle,
 		      enum pp_df_cstate state);
 int smu_allow_xgmi_power_down(struct smu_context *smu, bool en);
 
@@ -772,7 +772,7 @@ int smu_get_status_gfxoff(struct amdgpu_device *adev, uint32_t *value);
 
 ssize_t smu_sys_get_gpu_metrics(struct smu_context *smu, void **table);
 
-int smu_enable_mgpu_fan_boost(struct smu_context *smu);
+int smu_enable_mgpu_fan_boost(void *handle);
 int smu_gfx_state_change_set(struct smu_context *smu, uint32_t state);
 
 #endif
diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
index 36d18668ec99..5f33439782c4 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -1538,10 +1538,11 @@ int smu_handle_task(struct smu_context *smu,
 	return ret;
 }
 
-int smu_switch_power_profile(struct smu_context *smu,
+int smu_switch_power_profile(void *handle,
 			     enum PP_SMC_POWER_PROFILE type,
 			     bool en)
 {
+	struct smu_context *smu = handle;
 	struct smu_dpm_context *smu_dpm_ctx = &(smu->smu_dpm);
 	long workload;
 	uint32_t index;
@@ -1667,9 +1668,10 @@ int smu_force_clk_levels(struct smu_context *smu,
  * However, the mp1 state setting should still be granted
  * even if the dpm_enabled cleared.
  */
-int smu_set_mp1_state(struct smu_context *smu,
+int smu_set_mp1_state(void *handle,
 		      enum pp_mp1_state mp1_state)
 {
+	struct smu_context *smu = handle;
 	uint16_t msg;
 	int ret;
 
@@ -1706,9 +1708,10 @@ int smu_set_mp1_state(struct smu_context *smu,
 	return ret;
 }
 
-int smu_set_df_cstate(struct smu_context *smu,
+int smu_set_df_cstate(void *handle,
 		      enum pp_df_cstate state)
 {
+	struct smu_context *smu = handle;
 	int ret = 0;
 
 	if (!smu->pm_enabled || !smu->adev->pm.dpm_enabled)
@@ -2266,9 +2269,10 @@ int smu_display_disable_memory_clock_switch(struct smu_context *smu, bool disabl
 	return ret;
 }
 
-int smu_set_xgmi_pstate(struct smu_context *smu,
+int smu_set_xgmi_pstate(void *handle,
 			uint32_t pstate)
 {
+	struct smu_context *smu = handle;
 	int ret = 0;
 
 	if (!smu->pm_enabled || !smu->adev->pm.dpm_enabled)
@@ -2415,8 +2419,9 @@ int smu_mode1_reset(struct smu_context *smu)
 	return ret;
 }
 
-int smu_mode2_reset(struct smu_context *smu)
+int smu_mode2_reset(void *handle)
 {
+	struct smu_context *smu = handle;
 	int ret = 0;
 
 	if (!smu->pm_enabled)
@@ -2527,8 +2532,9 @@ ssize_t smu_sys_get_gpu_metrics(struct smu_context *smu,
 	return size;
 }
 
-int smu_enable_mgpu_fan_boost(struct smu_context *smu)
+int smu_enable_mgpu_fan_boost(void *handle)
 {
+	struct smu_context *smu = handle;
 	int ret = 0;
 
 	if (!smu->pm_enabled || !smu->adev->pm.dpm_enabled)
@@ -2557,5 +2563,14 @@ int smu_gfx_state_change_set(struct smu_context *smu, uint32_t state)
 }
 
 static const struct amd_pm_funcs swsmu_dpm_funcs = {
+	/* export for sysfs */
 	.get_performance_level = smu_get_performance_level,
+	.switch_power_profile  = smu_switch_power_profile,
+	/* export to amdgpu */
+	.set_mp1_state         = smu_set_mp1_state,
+	/* export to DC */
+	.enable_mgpu_fan_boost = smu_enable_mgpu_fan_boost,
+	.asic_reset_mode_2     = smu_mode2_reset,
+	.set_df_cstate         = smu_set_df_cstate,
+	.set_xgmi_pstate       = smu_set_xgmi_pstate,
 };
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
