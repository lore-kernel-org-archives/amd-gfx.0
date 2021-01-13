Return-Path: <SRS0=tf5m=GQ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3474FC433E9
	for <amd-gfx@archiver.kernel.org>; Wed, 13 Jan 2021 03:28:11 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C5C5922EBE
	for <amd-gfx@archiver.kernel.org>; Wed, 13 Jan 2021 03:28:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C5C5922EBE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0011089B22;
	Wed, 13 Jan 2021 03:28:07 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2060.outbound.protection.outlook.com [40.107.236.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A195D89B22
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 Jan 2021 03:28:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FpxNfa1ic+r7DY/t8GRpksD9lEkZo9rUKmlGaBvN+jOnuUl8s0EG1W24q7/fU+/AQRknpp6ZdxO/W6SMtNlhxRggQam7pH6CdpojYW9hpZRLIeTjKmQVL41IfhFge618d+ByQ8qimnx15s6INOM0i8ppBP3mDJf9CWUDwnaHkZlhsgQwS3LbkbSV0nb77DKLDLUFczOGBpz/HtENi64yQnCkQ1Ikt4OM5tmdtFLIByzceYzxHjZTl4jmkaqRkyZWvpKKbbq17PMlIh6gqin4JKh613URVJMg9n/YSyDRLlsdtyflXjX3nzyLALZLcTMtxURTcpno1i4ZGFVHakXg7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TwKSApX0PwIo/p5htcdem/Z9l+3TzLUvbYuEpiZr3Yk=;
 b=YdbIGZ5coeCRLmK9TMMpAbMXfsNmktlz/jvT7bOWWdFIduKmF/nFDUz72mIcGRLbdbKAArhGhtGhUJP8qoDWo0+ctjo5IFz8PMKCuYd0be+ZUKUk9VnwqLuUZUKmmmsbdVDC9tZHf5Wot/FbTMxHS3LxBa7eXJdwK+/+MofbwPxR1O/xRPgyqRX1jWeHGzE5Fm21uHkrOU0NvXDrgGim8KTtzV5SpixuodaWDDa59ou6KGcvF0jjt3pltzo59dppoyjaj+fuQiE05Ja5ppQkiXi+s8C1t2FB3YspOmw/DdUdWwNDWb/ijs//NtcG1aZoeKEl4fcYX5U9Io2Obgge5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TwKSApX0PwIo/p5htcdem/Z9l+3TzLUvbYuEpiZr3Yk=;
 b=MlguU+L+7478xurRRpTSnK6R1yIBkWF0g1jBQayPPDyZOg5avRYFG2JxmLdnsN68VEAuH1+/FNf3T/dgOBEAISwiU1n9HQ5DwhBvbb8/2yPjswkyHOxoCbwGYW6hnt9zJFoNxVd1rHjuvXNMd3hEKwBgZSgJIp6HoBFMWaOoedM=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2954.namprd12.prod.outlook.com (2603:10b6:5:188::22)
 by DM6PR12MB3817.namprd12.prod.outlook.com (2603:10b6:5:1c9::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3742.6; Wed, 13 Jan
 2021 03:28:04 +0000
Received: from DM6PR12MB2954.namprd12.prod.outlook.com
 ([fe80::19b:66f9:83d9:7cb1]) by DM6PR12MB2954.namprd12.prod.outlook.com
 ([fe80::19b:66f9:83d9:7cb1%3]) with mapi id 15.20.3742.012; Wed, 13 Jan 2021
 03:28:04 +0000
From: Darren Powell <darren.powell@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 2/8] amdgpu/pm: Powerplay API for smu ,
 changed 6 dpm reset functions to use API
Date: Tue, 12 Jan 2021 22:27:20 -0500
Message-Id: <20210113032726.2475-3-darren.powell@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210113032726.2475-1-darren.powell@amd.com>
References: <20210113032726.2475-1-darren.powell@amd.com>
X-Originating-IP: [142.126.168.115]
X-ClientProxiedBy: YT1PR01CA0155.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2f::34) To DM6PR12MB2954.namprd12.prod.outlook.com
 (2603:10b6:5:188::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (142.126.168.115) by
 YT1PR01CA0155.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:2f::34) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3763.9 via Frontend Transport; Wed, 13 Jan 2021 03:28:03 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 9b1b1ef1-e1de-4673-3d5c-08d8b7733cd6
X-MS-TrafficTypeDiagnostic: DM6PR12MB3817:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB38177009D50D72E1C7D8C789F0A90@DM6PR12MB3817.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: j9jTdsuywTUlE842j1WW1UccIei84+6u1kt4DCuX3Zq7pb+JjFcypz8CRWz2r0g5uuNZAGT7rFBYxCZL4GHEWIcxynYVDwCAJArs1kgqgiz6YjtzWYU/2qpvEf1xlhIwAKgCfoI/xxn6zbM5pRTyeuWllEH4Jol7/ba2DYd3yGYbc34iRgje7mUMwYgoVOsvRDuV70O7xKDUWngxR9j3ONLnuOjwGcEfLQFDbMExHEHV5zVjeTNPXzrT0JE4oHRgMsdvRFZdYnKLP6Ifgze6hruuHNNOTg9K07mI13wCrvgKrZ8AoSyTG0sJdmEPxxo9T0N+ISD47u+78MnKd+ebgULVKKxwZ3tJI/Ud2jo5BGEP3sqM1/VwM/5eQRDu+IIMD6LpAPKn6kinq3PkDbTaOmxnzqLnLFBmwSJ9Jh02C7M+01yHi9lG49jwqD9LtF8nkhJ/D0BdW6KpYh5Xfxc0wA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2954.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(346002)(366004)(39860400002)(376002)(136003)(5660300002)(69590400011)(66556008)(4326008)(6506007)(8936002)(36756003)(8676002)(6512007)(6486002)(6916009)(66476007)(186003)(44832011)(66946007)(86362001)(1076003)(26005)(956004)(52116002)(478600001)(16526019)(316002)(2616005)(6666004)(2906002)(83380400001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?D/PipwHzA1FIDakmpMIDio7i1eSRV4gYQtquHTga48brdCn8Q+BYh2xnTo4J?=
 =?us-ascii?Q?c/BHAnkhdnioPSHyKx1sdtOlFUMMdkxUANGdEzQW9cxyHoIStcuUHqubhW7T?=
 =?us-ascii?Q?wY6YyyqDZzlaBafBzNujhtKTuKufWw3W9vn2fz3HGe2GOpRDTgrWGl03PeUW?=
 =?us-ascii?Q?GVZgacCwfneLMVz5yQjUVP85Ifbq9fpmDZY+9Od7N8d3K957C/4H8ytLzugt?=
 =?us-ascii?Q?o4f7ci6x1fGYZ0I6FCiP/rjuZEyYwjDp5yaB+n5W1ByCnvWBiSnWcNkG93eL?=
 =?us-ascii?Q?lPgMhPa7qX69zCUgRuRLHclfTw1zJrL2rHLTT5UtQ0pNeTp59ZFlfSId7zw4?=
 =?us-ascii?Q?9srU0lErO8W28LiWple8g+Uzd5p9eyY/MqNQOlj/+89JXIhujC98u3QWOq9U?=
 =?us-ascii?Q?QVRQ2lGPDduOJsMYvT9134H17rlQb9rVZ4+7l8Tz+83GOvvrbOcwsOHKzrky?=
 =?us-ascii?Q?ACrxyV1SzaUva/Ne8FzaZGdMr6hrU9CD4cZdgrRbQvTcVrXreoqJeg0A8xwJ?=
 =?us-ascii?Q?e7byZrouvqKucdssMQzL06mDMaxZsCrJt2cmTWSClVSiAfMA4mfQACIVQQ27?=
 =?us-ascii?Q?Nxk9DRbhaPwvI4mEUvcuG26hx5twF9jkmK80jHznU7Pnq+zbJroL3tE5aB+R?=
 =?us-ascii?Q?0wNUX9URLlVaSOK13DtbqymDfyreKUYBQrJ+v2X+Rt2ol3MdNnYdVchaz5HV?=
 =?us-ascii?Q?0iiRtPWePjrioTGWDf2X0hdoa4Ol22VgJIuxYWUlb9HLGov9EFbACKlIZs1l?=
 =?us-ascii?Q?PPsPWGJxxxaHPMtEdDQ4aXwuJJtgZ70a0gwh/hVKCW9g2ljJXJnFacxIZzpm?=
 =?us-ascii?Q?d+i7zmpCc23Z98SJ441Uz9c7XLtZl3PKXQ4/8J+3d3oSpulTSQbzzUiaEZQ2?=
 =?us-ascii?Q?h7N5j6Lq1cXoE3EyxZjM2ctXJ6gxYH0QBMjycOTr2sQf/GzhsjLpyrtjmwX3?=
 =?us-ascii?Q?Br5WxtgDP0ATBmCpM6Yb42cYNJHI7pPedZOlYEY2sLX2ZOAuKv7qY3Wh7StK?=
 =?us-ascii?Q?rBLH?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2954.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2021 03:28:04.1991 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b1b1ef1-e1de-4673-3d5c-08d8b7733cd6
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XoVpJoUwU4Pgr1b0Vx/ATEm8AIWxeohzwK5WOcK/0QSLCebU+aHbWATSd4A2SpV/VEvw19edaqFhjV47x0VseQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3817
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
index d86535016b23..41ce7e07d744 100644
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
 
 static const struct amd_pm_funcs swsmu_pm_funcs = {
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
