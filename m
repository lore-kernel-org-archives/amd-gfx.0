Return-Path: <SRS0=uNpP=FM=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A0E9C4361B
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Dec 2020 11:20:36 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2211D229C7
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Dec 2020 11:20:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2211D229C7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A4BF46E92D;
	Tue,  8 Dec 2020 11:20:35 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2054.outbound.protection.outlook.com [40.107.244.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 939A06E92D
 for <amd-gfx@lists.freedesktop.org>; Tue,  8 Dec 2020 11:20:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Zc6hpyb46atkWLiD/7RMrdOAe5kuVnvSBo5BIEkR96rkUc8LpGbRhJay+UtN69xOTSC3YsoAnMCte4Jzup6cD9484Dk6XxbPJDHQz4x5ylNa6w+w79cCvPT/vfgi3lo3AuXhvsB9CXeiQQVNpnwPpL6Ba1Xuhk7TT9J/6q3ilAm3XDUPMpEikYsgAKO26ZKLj0/ll0K9KIY/dSmjz6kEnQVwKLf7NVpJdwWRUw0RBJ67P7NJKr0guoeToP20gCOfbi97QzV/ACQMg58bQOshB6fqv/RHTCdHwhP3KTYK+qAdOuIXy7Svgjy2tMGoozs09eHXDR3DwyWSVD9Bfmfy1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5JOvUJg1o4mGBiPWA2xTJjvJZz6FUNWt54FUCcwGfwQ=;
 b=QtdRwlqQeU+vPhwAmQpxcdKkxRGpTzs4h/ksMdYl3rp7wchc1mFifjwvreEmttAP1MzLx0h6Hurb2Kkb5SsgnvfbxQjOuIm6jO336F7c4FMNjTs/H6tOU/q4ddQm3rrIGgyXHkrJcV489MIyYJvLEhxEtCBYTu+9HY47S0FpvQrlWKSo8MSrsJT0Ji/Fsfkbr+OBZ0Sj2wfipOyFY8JX4V2mdpyjA1sa1/K9FCTcEcZuAIk8GGNVJarP8MpWkcKe5ORxfzNvYny/UWo9WZg6349HbJGYB+vMq/ukxzpF9QeXrHmeCGhtV8HDItPamu412N29FivocuVkPBOtYlBu9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5JOvUJg1o4mGBiPWA2xTJjvJZz6FUNWt54FUCcwGfwQ=;
 b=JLknmFjuO1DHpTGEaaTnuXE5CzdkVZqJ0FIg2eg7ONKnUgPveNfjtMiDggHWTzF42oQGq++7dRp2ef3Eojh5ab+x2rdURdYy/olIDzrwxjx6wOXJ7YJUE6INKXWFre4d3BrGH3kS5VReIhIv+HghoTU8cogDurpoYCM7mhsfLiU=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3807.namprd12.prod.outlook.com (2603:10b6:208:16c::30)
 by MN2PR12MB4270.namprd12.prod.outlook.com (2603:10b6:208:1d9::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3654.12; Tue, 8 Dec
 2020 11:20:32 +0000
Received: from MN2PR12MB3807.namprd12.prod.outlook.com
 ([fe80::40bf:bffc:e8b3:2067]) by MN2PR12MB3807.namprd12.prod.outlook.com
 ([fe80::40bf:bffc:e8b3:2067%7]) with mapi id 15.20.3632.018; Tue, 8 Dec 2020
 11:20:32 +0000
From: Xiaomeng Hou <Xiaomeng.Hou@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 2/3] drm/amd/pm: add interface to notify RLC status for vangogh
Date: Tue,  8 Dec 2020 19:19:41 +0800
Message-Id: <20201208111942.6292-2-Xiaomeng.Hou@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201208111942.6292-1-Xiaomeng.Hou@amd.com>
References: <20201208111942.6292-1-Xiaomeng.Hou@amd.com>
X-Originating-IP: [180.167.199.189]
X-ClientProxiedBy: HK0PR03CA0119.apcprd03.prod.outlook.com
 (2603:1096:203:b0::35) To MN2PR12MB3807.namprd12.prod.outlook.com
 (2603:10b6:208:16c::30)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from code-machine.amd.com (180.167.199.189) by
 HK0PR03CA0119.apcprd03.prod.outlook.com (2603:1096:203:b0::35) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3632.17 via Frontend Transport; Tue, 8 Dec 2020 11:20:31 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: fd2aac7f-573a-4504-abf5-08d89b6b471d
X-MS-TrafficTypeDiagnostic: MN2PR12MB4270:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB4270485E8880EE329436A3C99FCD0@MN2PR12MB4270.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2958;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: a0so0jo+PBDGivRkGExzyx6+EqJeqo2Nto61YPXEI4nFWLLDN6hqEJaQ8MVu5T8NoiFwYk41lIBcLlKm/J37CoRngxH+YzHPKOkDZt7HPdTqWO0GsAYDOiyiD9f5c0NpHnNEZn6nK9ew6YC0UVULBUYGiMt8yuW37X32jfoSYNHJWmwKTyRm9iu6OLCIdP6xLkoFwM6X8h9FpOZfGHoJf5fWQLgwKYP9rGfp4IJ43uEP0BMcaxWGUYkx93LkqyWa8I4f+r/a7/uWyzy4EMJdhsWbqIBQLAw1v5kqF0A46Arw7h9vEt16r7AxVGIpR2r0Cecjx2rUZ6NnF0dLA+pjFw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB3807.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(396003)(346002)(136003)(366004)(376002)(316002)(1076003)(26005)(6666004)(186003)(8936002)(2616005)(7696005)(66556008)(66476007)(66946007)(86362001)(6916009)(5660300002)(2906002)(52116002)(6486002)(36756003)(8676002)(956004)(4326008)(83380400001)(478600001)(16526019);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?wcmxTelW5ec7PTvLDeQOwH2wt5eNqNjmm81Ylt9iDKlKpEmF8Y0Ldlvy1Dl0?=
 =?us-ascii?Q?D2WEB7zr3MS8nP2HEg5dH1PxUwT0a/Qn4gTBzYaoSMJ3vi1UuHPO7SgbhAgR?=
 =?us-ascii?Q?iATiA5PUw5liAf2u2LktTK/zqkovXJZ80kE5mNzKI8u+TqwCoiAnIMWcBgZ9?=
 =?us-ascii?Q?eAq3w8bRXOi+kFpgIE+jkHbCQU3x0gydTUAT/vDUvIdIIM1JLVECtW8FfdSG?=
 =?us-ascii?Q?YPWbIqo1bfjojbhdVqE/+Mg1omRyf4VgTuU1vfMSc80Zoci0kLU0GbpHdJA5?=
 =?us-ascii?Q?LyBlj7kg3NweYozi7I2bcAADT013MbuYD/+sf/mjViabe0Tc5Q1VyWJHz4xM?=
 =?us-ascii?Q?szKIt5bGu7CrgxthFlAcVcA92gihXKnPmHzL4MQv1m+TfAxt3XW18uOM0/xX?=
 =?us-ascii?Q?OIIHZRRKMCV6xk47pHz/zntkHyf/CWErxTOygE4v8NfBKcLW9ZVgjiUh7CNc?=
 =?us-ascii?Q?v7YDYuwdNXA4v3ls0db4RzbLYtbUU/dlZSYqj5cXRWf4sZI/tVk89d3Mt2mn?=
 =?us-ascii?Q?vYHbwzE2zVF4Wjau0p8J8YyjMWOc2Avl4z81FLoCAvpiT1yI+u/yhkTYbcis?=
 =?us-ascii?Q?0E6uxHhYxzJdqmtOt5t3eSEz8Ww5Q/JtZRYYGC7BbC6GKAGC9G2HAqwlGq5Q?=
 =?us-ascii?Q?AIjSfZyD1RykIpEn8OHagFEeuxFJwvN/G8occbUfBeReEWfH8xYF5k9/ckW+?=
 =?us-ascii?Q?Pr7khOTRPIlkUJZlJUZUlKr0hwsxx4XjQif09HKc48QMuTtRYvw+37RWF6ol?=
 =?us-ascii?Q?/Vbu4rA7NV3elVglcbB3QAw7r5UxLPTttpxwpph1nVVSGqqAmY5e5LPJ5bDj?=
 =?us-ascii?Q?hs5AhQWWxEycggWK3IMTP1/1chWgEEtwhtqh0EjnuU3dLUWelCSzYVhzIVq4?=
 =?us-ascii?Q?3AebQInO82CSjL3XENk7up6N56rvvGyLVhZ6XPiY/W4z0hKjkuHyWupk+/tI?=
 =?us-ascii?Q?0GBDYLNYlDsdxbdcdyM+PZxyXb1nzZe+eTEMgeivpwMSYQEJz1W0HpaQcCQU?=
 =?us-ascii?Q?m6jf?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3807.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Dec 2020 11:20:32.8878 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-Network-Message-Id: fd2aac7f-573a-4504-abf5-08d89b6b471d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JomDPNXLWwY+MV716ZR8yGqdgWsp1vfATi07VCgr2X5Yimtc65P9hdNL/Hf8uD+NKSKbkwsfZCIX3o3zUIXUyQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4270
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
Cc: Alexander.Deucher@amd.com, Ray.Huang@amd.com,
 Xiaomeng Hou <Xiaomeng.Hou@amd.com>, Evan.Quan@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Add this interface to notify PMFW the status (Normal/Off) of RLC engine.

Before notify RLC status normal, need check its current status first. Send the
message only when current status is still off.

Signed-off-by: Xiaomeng Hou <Xiaomeng.Hou@amd.com>
Change-Id: I2f1a7de23df7315a7b220ba6d0a4bcaa75c93fea
---
 drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h       |  1 +
 .../gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c  | 24 ++++++++++++++++++-
 .../gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.h  |  4 ++++
 drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c        | 13 ++++++++++
 drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h        |  2 ++
 drivers/gpu/drm/amd/pm/swsmu/smu_internal.h   |  1 +
 6 files changed, 44 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h b/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
index 89be49a43500..0da00a92b478 100644
--- a/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
+++ b/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
@@ -583,6 +583,7 @@ struct pptable_funcs {
 	int (*gpo_control)(struct smu_context *smu, bool enablement);
 	int (*gfx_state_change_set)(struct smu_context *smu, uint32_t state);
 	int (*set_fine_grain_gfx_freq_parameters)(struct smu_context *smu);
+	int (*notify_rlc_status)(struct smu_context *smu, uint32_t status);
 };
 
 typedef enum {
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
index ddaa6a705fa6..03c2cd7a52a9 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
@@ -64,7 +64,7 @@ static struct cmn2asic_msg_mapping vangogh_message_map[SMU_MSG_MAX_COUNT] = {
 	MSG_MAP(PowerUpIspByTile,               PPSMC_MSG_PowerUpIspByTile,		0),
 	MSG_MAP(PowerDownVcn,                   PPSMC_MSG_PowerDownVcn,			0),
 	MSG_MAP(PowerUpVcn,                     PPSMC_MSG_PowerUpVcn,			0),
-	MSG_MAP(Spare,                          PPSMC_MSG_spare,				0),
+	MSG_MAP(RlcPowerNotify,                 PPSMC_MSG_RlcPowerNotify,		0),
 	MSG_MAP(SetHardMinVcn,                  PPSMC_MSG_SetHardMinVcn,		0),
 	MSG_MAP(SetSoftMinGfxclk,               PPSMC_MSG_SetSoftMinGfxclk,		0),
 	MSG_MAP(ActiveProcessNotify,            PPSMC_MSG_ActiveProcessNotify,		0),
@@ -722,6 +722,27 @@ static int vangogh_set_fine_grain_gfx_freq_parameters(struct smu_context *smu)
 	return 0;
 }
 
+static int vangogh_notify_rlc_status(struct smu_context *smu, uint32_t status)
+{
+	int ret = 0;
+
+	switch (status)
+	{
+	case RLC_STATUS_OFF:
+		ret = smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_RlcPowerNotify, status, NULL);
+		break;
+	case RLC_STATUS_NORMAL:
+		if (smu_cmn_get_rlc_status(smu) == 0)
+			ret = smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_RlcPowerNotify, status, NULL);
+		break;
+	default:
+		dev_err(smu->adev->dev, "Unknown rlc status\n");
+		return -EINVAL;
+	}
+
+	return ret;
+}
+
 static const struct pptable_funcs vangogh_ppt_funcs = {
 
 	.check_fw_status = smu_v11_0_check_fw_status,
@@ -750,6 +771,7 @@ static const struct pptable_funcs vangogh_ppt_funcs = {
 	.print_clk_levels = vangogh_print_fine_grain_clk,
 	.set_default_dpm_table = vangogh_set_default_dpm_tables,
 	.set_fine_grain_gfx_freq_parameters = vangogh_set_fine_grain_gfx_freq_parameters,
+	.notify_rlc_status = vangogh_notify_rlc_status,
 };
 
 void vangogh_set_ppt_funcs(struct smu_context *smu)
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.h b/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.h
index 8756766296cd..eab455493076 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.h
@@ -32,4 +32,8 @@ extern void vangogh_set_ppt_funcs(struct smu_context *smu);
 #define VANGOGH_UMD_PSTATE_SOCCLK       678
 #define VANGOGH_UMD_PSTATE_FCLK         800
 
+/* RLC Power Status */
+#define RLC_STATUS_OFF          0
+#define RLC_STATUS_NORMAL       1
+
 #endif
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
index f8260769061c..2f3e66b03dd2 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
@@ -42,6 +42,9 @@
  * They share the same definitions and values. That makes common
  * APIs for SMC messages issuing for all ASICs possible.
  */
+#define mmMP1_SMN_C2PMSG_63                                                                            0x027f
+#define mmMP1_SMN_C2PMSG_63_BASE_IDX                                                                   0
+
 #define mmMP1_SMN_C2PMSG_66                                                                            0x0282
 #define mmMP1_SMN_C2PMSG_66_BASE_IDX                                                                   0
 
@@ -731,3 +734,13 @@ int smu_cmn_get_metrics_table(struct smu_context *smu,
 
 	return ret;
 }
+
+int smu_cmn_get_rlc_status(struct smu_context *smu)
+{
+	struct amdgpu_device *adev = smu->adev;
+	uint32_t val;
+
+	val = RREG32_SOC15_NO_KIQ(MP1, 0, mmMP1_SMN_C2PMSG_63);
+
+	return val;
+}
\ No newline at end of file
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h
index 01e825d83d8d..7584089ef15f 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h
@@ -95,5 +95,7 @@ int smu_cmn_get_metrics_table(struct smu_context *smu,
 			      void *metrics_table,
 			      bool bypass_cache);
 
+int smu_cmn_get_rlc_status(struct smu_context *smu);
+
 #endif
 #endif
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_internal.h b/drivers/gpu/drm/amd/pm/swsmu/smu_internal.h
index 68d9464ababc..8ef3713f7f3c 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu_internal.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu_internal.h
@@ -91,6 +91,7 @@
 #define smu_post_init(smu)						smu_ppt_funcs(post_init, 0, smu)
 #define smu_gpo_control(smu, enablement)				smu_ppt_funcs(gpo_control, 0, smu, enablement)
 #define smu_set_fine_grain_gfx_freq_parameters(smu)					smu_ppt_funcs(set_fine_grain_gfx_freq_parameters, 0, smu)
+#define smu_notify_rlc_status(smu, status)					smu_ppt_funcs(notify_rlc_status, 0, smu, status)
 
 #endif
 #endif
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
