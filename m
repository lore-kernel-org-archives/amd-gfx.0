Return-Path: <SRS0=tf5m=GQ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A75E8C433DB
	for <amd-gfx@archiver.kernel.org>; Wed, 13 Jan 2021 11:22:52 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4CB3C233A2
	for <amd-gfx@archiver.kernel.org>; Wed, 13 Jan 2021 11:22:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4CB3C233A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 99C1D6E54C;
	Wed, 13 Jan 2021 11:22:51 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2071.outbound.protection.outlook.com [40.107.243.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1EABB6E550
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 Jan 2021 11:22:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BVIhtja1qd3lKtfOmwKgVhEWI9NtpBrJqhYm9UbJdyjgQW/tR8z/Rr2fppzgg/Ux3/E7ggrD9H7tuNfRQ96RtxOa/VMFwluPvqe8uOHQFp12YdBTlWyi8QJfoaQENs0sL9g/i07i1Tgrny/GAoW03fmU0setOOxNH3XY711/bwKGPAj0tPwSVpFpyE6R5wSGGrt7gOH8/KslADf+UBKBXVBSFEGMCxYHbf+HJ3XSUCirWGWu8KWXHNKzpyjbsj3ISl75Wjk4OemJL68SYDQRL/ZqB+MTMBiK/2N7jAosKK1K/TCZdR9C3KTgEYsOmRWzh31u1qiiSDs1MIPcsEuSHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1EcYioh5MMFFv7qYNEbumnu3hCvPufG7/x8qEhSzKsk=;
 b=ULKLh64Eqte24U4bByiM9RjuNh9Du5/+bXwDiLsO0rLFZ5Bp+AzcA+dWA7hajqlHTrOLpCje+6H6fksl8NZaj/r+AQgsc4uAc06GNwhgSaXGCpMa/7Q3usgVrgcxRk5HjIhW4qVEdbAPHE3pU2SCGBVGNHyCODMaRtivehjPLIfsGXpuQ/SBpeX/DVGYtx7YBffrJqQ/3IDjTGszACqU2v8WUM1O0ONLYwsLzoSsSRinHzn40tOg8uDB8WR6/hyWQsCYQfWW6BBfPo6JlQvpYYMhEoSvYd2PcrB6z/dnrTIfZ+fFEVEbOF8T+kh32aGMkxh61JSbO1nS840564ozTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1EcYioh5MMFFv7qYNEbumnu3hCvPufG7/x8qEhSzKsk=;
 b=fzbIfAxLHMwxwjLqC+UoDuVDDY5ynrYMglSair/UWGoTqaUPnOcRm9sVJ8XQpaXP56VyZyeWWRZLYFhhMdjqjy47XsFascwGBwZxfVOmma7rZ95oNy5aNX1IV5vd9UcO4Ntql+4WLofbKx9nj9FLYr4iOO9EAZKSfak+zYBckoU=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from BN6PR12MB1124.namprd12.prod.outlook.com (2603:10b6:404:19::10)
 by BN7PR12MB2658.namprd12.prod.outlook.com (2603:10b6:408:25::31)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3742.8; Wed, 13 Jan
 2021 11:22:48 +0000
Received: from BN6PR12MB1124.namprd12.prod.outlook.com
 ([fe80::7cc1:989:4a2a:ab1e]) by BN6PR12MB1124.namprd12.prod.outlook.com
 ([fe80::7cc1:989:4a2a:ab1e%10]) with mapi id 15.20.3742.012; Wed, 13 Jan 2021
 11:22:48 +0000
From: Xiaojian Du <Xiaojian.Du@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 2/2] drm/amd/pm: modify the fine grain tuning function for
 vangogh
Date: Wed, 13 Jan 2021 19:22:04 +0800
Message-Id: <20210113112204.25469-2-Xiaojian.Du@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210113112204.25469-1-Xiaojian.Du@amd.com>
References: <20210113112204.25469-1-Xiaojian.Du@amd.com>
X-Originating-IP: [180.167.199.189]
X-ClientProxiedBy: HK2PR03CA0063.apcprd03.prod.outlook.com
 (2603:1096:202:17::33) To BN6PR12MB1124.namprd12.prod.outlook.com
 (2603:10b6:404:19::10)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from jenkins-System-Product-Name.amd.com (180.167.199.189) by
 HK2PR03CA0063.apcprd03.prod.outlook.com (2603:1096:202:17::33) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3763.2 via Frontend Transport; Wed, 13 Jan 2021 11:22:46 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 2ffd6602-115e-4fe1-b6ec-08d8b7b58ec5
X-MS-TrafficTypeDiagnostic: BN7PR12MB2658:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN7PR12MB2658E816A901384D91FB8E42F1A90@BN7PR12MB2658.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:576;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NdPo8KddC157zrJwlALhynsFncMOWjvY1hYHapemERo8F1wa/mYZjs8Loip4ygUSMTGIz0KG886c4riaLMRfTBD1wLDrLPavBfWM5peHrueSO7Zh444LXHbTF0/iOML0Wri2l4gypjxRGxKrbgpXdIUN3C/0xW7kYiY5cNIVtRXxQ7XyAfmITCdq00LzAlgy6rVn/L+4iGAtmWSJyzJuDHoLiA65UUwQ6VnHsZLDS/T2yFiDWNOPwhO7DxsiBXvMy1drj8PnFIhOHkfQoz9++AaHMh4myY0t16Mcsl0XVB/FQAfSN+WJIfgR5Vy3PgQ1saoTjDIaGsnDzPi4df1KRVXlXdovrcWYnPrN9oIBP6EZC0Elt/oyK6qaBswvzbBy/1Sh4WFjkDNhsQxkocDyog==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN6PR12MB1124.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(366004)(376002)(39860400002)(346002)(396003)(8676002)(8936002)(83380400001)(66476007)(478600001)(4326008)(186003)(36756003)(66556008)(16526019)(5660300002)(86362001)(316002)(7696005)(1076003)(6916009)(956004)(2906002)(2616005)(66946007)(26005)(52116002)(6666004)(6486002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?tIy+AjXdQ53bm5+liUGxpiFRHFXDLYDTxcg+P40Xc97OaeZcDfciRwFPqYMW?=
 =?us-ascii?Q?tNYy5MAr0a2q8PT1AyAOmcoJvhbZuIIp8N8QjW4RgK7XxBZiw0LM8b/GH+BY?=
 =?us-ascii?Q?P5kSOhYWUjCN48qZssNIVFNQTkp2O1JVoWNo+y01iLw5U9syAZAIj0yLYPYg?=
 =?us-ascii?Q?KqaIeyhoIZYmONkcto+F5Z+zUB5yVlP7KfQWmRl9PZYNkyFEVXZo3zEAQRLE?=
 =?us-ascii?Q?5W+XiawK0Ii2ckgaKIy0UY7jpJ9ycCkpu5Z61byjnLHgB2qp4BPun1Y0VVgt?=
 =?us-ascii?Q?zIR09ZRjAxK9u/GKHlWMwp9QVrcnjpAyfk2LtfaVOJ5yM2oC3/6FsG/4Utsc?=
 =?us-ascii?Q?AjkINT8wmsdBAvdEcivF4dRNIxXPrADg5yoUiiT6necGdUTaAZ5FH/yKI/82?=
 =?us-ascii?Q?OLk11A07lKcA2p2bjd3bgEMDIxbkC/X4uytfqHtr8HBDPFqP6Mpx0xkCyK9m?=
 =?us-ascii?Q?YagL0ChxXf2hkJu/DLulGpkFPYi4bODuUOMP1gLylCXpH+kWhQJJvvfgOrdt?=
 =?us-ascii?Q?EzlmEVJ0H6DnIHKQSu8sKo1FJmV7Lel6zfwZB6kDZGRtVp9YU4hBLnPTypta?=
 =?us-ascii?Q?D9rzOI9f9QSQYcp0Jb2YzrwGYJ0jgQQVFSe2cyN+ouNUAiY4z2i98Lc03pvT?=
 =?us-ascii?Q?uGqL/7e4aNWU1hSCiRqgmfQTSs0ntWDr9xnUvgmcRSFL3ws924znAiRqf8XH?=
 =?us-ascii?Q?vv94+gxdn19YJYFKhOtoDh85Fwq12M0Vz2q/of1mmROHcrck18EemP0UydR7?=
 =?us-ascii?Q?maB2gKAZF0tpWGXMguPfZaAa8yw6IiLMGjLUi4t3x8Bcc8BKNqxVvyFJK3M4?=
 =?us-ascii?Q?aJ1+uEwkZ78J8twrSknPxDIvgtdu0epSzhw+MYPNLwuJ7GvycPJH4GX9Q2QA?=
 =?us-ascii?Q?E0nfDf3W1DSfhY+ybiO69LRFxKFovHh59cbMN6PDePzjQo1xsFt0mILXjWaV?=
 =?us-ascii?Q?cgE0Aq04LX/FuDxS9e5O821KmR9tDcY6MKEV6kxFgklRLuvUWeVQCXKk4W3W?=
 =?us-ascii?Q?afGy?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthSource: BN6PR12MB1124.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2021 11:22:48.3541 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ffd6602-115e-4fe1-b6ec-08d8b7b58ec5
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ifdrXkJF30dWmSRnRlXCf/OqJt6GfOMMv3MrStxodBp0MAnoawp4zJ9r0FMZ7l6mSgR8aDULEF0R2XdDypX5oQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR12MB2658
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
Cc: lijo.lazar@amd.com, kevin1.wang@amd.com, ray.huang@amd.com,
 Xiaojian Du <Xiaojian.Du@amd.com>, evan.quan@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This patch is to modify the fine grain tuning function for vangogh.
It is risky to add two new flags to common smu struct.
So this patch uses the existing old flag to make the two sysfs files
work separately -- "power_dpm_force_performance_level" and
"pp_od_clk_voltage".
Only the power_dpm_force_performance_level is switched to "manual"
mode, the fine grain tuning function will be started.
In other mode, including "high","low","min_sclk","min_mclk",
"standard" and "peak", the fine grain tuning function will be shut down,
and the frequency range of gfx and cpu clock will be restored the
default values.

Signed-off-by: Xiaojian Du <Xiaojian.Du@amd.com>
---
 drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h       |  3 --
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c     |  2 -
 .../gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c  | 52 +++++++++++++++++--
 3 files changed, 48 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h b/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
index 277559e80961..25ee9f51813b 100644
--- a/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
+++ b/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
@@ -466,9 +466,6 @@ struct smu_context
 	uint32_t gfx_actual_hard_min_freq;
 	uint32_t gfx_actual_soft_max_freq;
 
-	bool fine_grain_enabled;
-	bool fine_grain_started;
-
 	uint32_t cpu_default_soft_min_freq;
 	uint32_t cpu_default_soft_max_freq;
 	uint32_t cpu_actual_soft_min_freq;
diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
index 976a9105aecc..7fe61ad3ed10 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -419,8 +419,6 @@ static int smu_set_funcs(struct amdgpu_device *adev)
 		break;
 	case CHIP_VANGOGH:
 		vangogh_set_ppt_funcs(smu);
-		/* enable the OD by default to allow the fine grain tuning function */
-		smu->od_enabled = true;
 		break;
 	default:
 		return -EINVAL;
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
index b49044825680..3e32b223d47b 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
@@ -438,6 +438,7 @@ static int vangogh_print_fine_grain_clk(struct smu_context *smu,
 {
 	DpmClocks_t *clk_table = smu->smu_table.clocks_table;
 	SmuMetrics_t metrics;
+	struct smu_dpm_context *smu_dpm_ctx = &(smu->smu_dpm);
 	int i, size = 0, ret = 0;
 	uint32_t cur_value = 0, value = 0, count = 0;
 	bool cur_value_match_level = false;
@@ -450,7 +451,7 @@ static int vangogh_print_fine_grain_clk(struct smu_context *smu,
 
 	switch (clk_type) {
 	case SMU_OD_SCLK:
-		if (smu->od_enabled) {
+		if (smu_dpm_ctx->dpm_level == AMD_DPM_FORCED_LEVEL_MANUAL) {
 			size = sprintf(buf, "%s:\n", "OD_SCLK");
 			size += sprintf(buf + size, "0: %10uMhz\n",
 			(smu->gfx_actual_hard_min_freq > 0) ? smu->gfx_actual_hard_min_freq : smu->gfx_default_hard_min_freq);
@@ -459,7 +460,7 @@ static int vangogh_print_fine_grain_clk(struct smu_context *smu,
 		}
 		break;
 	case SMU_OD_CCLK:
-		if (smu->od_enabled) {
+		if (smu_dpm_ctx->dpm_level == AMD_DPM_FORCED_LEVEL_MANUAL) {
 			size = sprintf(buf, "CCLK_RANGE in Core%d:\n",  smu->cpu_core_id_select);
 			size += sprintf(buf + size, "0: %10uMhz\n",
 			(smu->cpu_actual_soft_min_freq > 0) ? smu->cpu_actual_soft_min_freq : smu->cpu_default_soft_min_freq);
@@ -468,7 +469,7 @@ static int vangogh_print_fine_grain_clk(struct smu_context *smu,
 		}
 		break;
 	case SMU_OD_RANGE:
-		if (smu->od_enabled) {
+		if (smu_dpm_ctx->dpm_level == AMD_DPM_FORCED_LEVEL_MANUAL) {
 			size = sprintf(buf, "%s:\n", "OD_RANGE");
 			size += sprintf(buf + size, "SCLK: %7uMhz %10uMhz\n",
 				smu->gfx_default_hard_min_freq, smu->gfx_default_soft_max_freq);
@@ -1127,15 +1128,39 @@ static int vangogh_set_performance_level(struct smu_context *smu,
 
 	switch (level) {
 	case AMD_DPM_FORCED_LEVEL_HIGH:
+		smu->gfx_actual_hard_min_freq = smu->gfx_default_hard_min_freq;
+		smu->gfx_actual_soft_max_freq = smu->gfx_default_soft_max_freq;
+
+		smu->cpu_actual_soft_min_freq = smu->cpu_default_soft_min_freq;
+		smu->cpu_actual_soft_max_freq = smu->cpu_default_soft_max_freq;
+
 		ret = vangogh_force_dpm_limit_value(smu, true);
 		break;
 	case AMD_DPM_FORCED_LEVEL_LOW:
+		smu->gfx_actual_hard_min_freq = smu->gfx_default_hard_min_freq;
+		smu->gfx_actual_soft_max_freq = smu->gfx_default_soft_max_freq;
+
+		smu->cpu_actual_soft_min_freq = smu->cpu_default_soft_min_freq;
+		smu->cpu_actual_soft_max_freq = smu->cpu_default_soft_max_freq;
+
 		ret = vangogh_force_dpm_limit_value(smu, false);
 		break;
 	case AMD_DPM_FORCED_LEVEL_AUTO:
+		smu->gfx_actual_hard_min_freq = smu->gfx_default_hard_min_freq;
+		smu->gfx_actual_soft_max_freq = smu->gfx_default_soft_max_freq;
+
+		smu->cpu_actual_soft_min_freq = smu->cpu_default_soft_min_freq;
+		smu->cpu_actual_soft_max_freq = smu->cpu_default_soft_max_freq;
+
 		ret = vangogh_unforce_dpm_levels(smu);
 		break;
 	case AMD_DPM_FORCED_LEVEL_PROFILE_STANDARD:
+		smu->gfx_actual_hard_min_freq = smu->gfx_default_hard_min_freq;
+		smu->gfx_actual_soft_max_freq = smu->gfx_default_soft_max_freq;
+
+		smu->cpu_actual_soft_min_freq = smu->cpu_default_soft_min_freq;
+		smu->cpu_actual_soft_max_freq = smu->cpu_default_soft_max_freq;
+
 		ret = smu_cmn_send_smc_msg_with_param(smu,
 					SMU_MSG_SetHardMinGfxClk,
 					VANGOGH_UMD_PSTATE_STANDARD_GFXCLK, NULL);
@@ -1165,6 +1190,12 @@ static int vangogh_set_performance_level(struct smu_context *smu,
 
 		break;
 	case AMD_DPM_FORCED_LEVEL_PROFILE_MIN_SCLK:
+		smu->gfx_actual_hard_min_freq = smu->gfx_default_hard_min_freq;
+		smu->gfx_actual_soft_max_freq = smu->gfx_default_soft_max_freq;
+
+		smu->cpu_actual_soft_min_freq = smu->cpu_default_soft_min_freq;
+		smu->cpu_actual_soft_max_freq = smu->cpu_default_soft_max_freq;
+
 		ret = smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_SetHardMinVcn,
 								VANGOGH_UMD_PSTATE_PEAK_DCLK, NULL);
 		if (ret)
@@ -1176,6 +1207,12 @@ static int vangogh_set_performance_level(struct smu_context *smu,
 			return ret;
 		break;
 	case AMD_DPM_FORCED_LEVEL_PROFILE_MIN_MCLK:
+		smu->gfx_actual_hard_min_freq = smu->gfx_default_hard_min_freq;
+		smu->gfx_actual_soft_max_freq = smu->gfx_default_soft_max_freq;
+
+		smu->cpu_actual_soft_min_freq = smu->cpu_default_soft_min_freq;
+		smu->cpu_actual_soft_max_freq = smu->cpu_default_soft_max_freq;
+
 		ret = vangogh_get_profiling_clk_mask(smu, level,
 							NULL,
 							NULL,
@@ -1189,6 +1226,12 @@ static int vangogh_set_performance_level(struct smu_context *smu,
 		vangogh_force_clk_levels(smu, SMU_FCLK, 1 << fclk_mask);
 		break;
 	case AMD_DPM_FORCED_LEVEL_PROFILE_PEAK:
+		smu->gfx_actual_hard_min_freq = smu->gfx_default_hard_min_freq;
+		smu->gfx_actual_soft_max_freq = smu->gfx_default_soft_max_freq;
+
+		smu->cpu_actual_soft_min_freq = smu->cpu_default_soft_min_freq;
+		smu->cpu_actual_soft_max_freq = smu->cpu_default_soft_max_freq;
+
 		ret = smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_SetHardMinGfxClk,
 				VANGOGH_UMD_PSTATE_PEAK_GFXCLK, NULL);
 		if (ret)
@@ -1401,8 +1444,9 @@ static int vangogh_od_edit_dpm_table(struct smu_context *smu, enum PP_OD_DPM_TAB
 {
 	int ret = 0;
 	int i;
+	struct smu_dpm_context *smu_dpm_ctx = &(smu->smu_dpm);
 
-	if (!smu->od_enabled) {
+	if (!(smu_dpm_ctx->dpm_level == AMD_DPM_FORCED_LEVEL_MANUAL)) {
 		dev_warn(smu->adev->dev, "Fine grain is not enabled!\n");
 		return -EINVAL;
 	}
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
