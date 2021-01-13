Return-Path: <SRS0=tf5m=GQ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 127DBC433DB
	for <amd-gfx@archiver.kernel.org>; Wed, 13 Jan 2021 11:22:50 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A85EB2336F
	for <amd-gfx@archiver.kernel.org>; Wed, 13 Jan 2021 11:22:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A85EB2336F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 232626E544;
	Wed, 13 Jan 2021 11:22:49 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2082.outbound.protection.outlook.com [40.107.93.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 17E206E544
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 Jan 2021 11:22:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aBX/cqOugDjD/Qc+InpnwwS4pVLpL9s/MvmqQKZ3sKbS4YI1G3zIMOqkXG/ukS3xErdyubVqi74wZGeEzocejHR6ucNhlVadPaEglJcBsmEPdMDri5jE5EdAP+t/83x2vEBlXnVeO0tfbNky5f9v6OOQ2TrvkguKx85dMQryn9sTI/1jLONsttfk/8eTYxWagppN3mRM323aO1bDsKgSSu+KwJs+20cDwZsxr3152/VqeEYzoF2xq7Vbf/zB2j70lKJFl8AEL2tmESOl3pTVW9GdivZS8I0ryaHb7kqEW7847wTcyhYw95iv3azSSUgacrK0396Mg8qqfcHD7G79Ag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cCY3ZeQPVrTPPGxKFDlQnEMvpftF9GgQs3AgYvDqrCE=;
 b=H1PASZLENtGDHCr2V7n5rn3NZ/1ee0RL/D4uows7N15RamZHl8/2KTMQtHYICUtf4E6qiEI3zNN9ijzbPCK4zyFABMRxd5VHg+ucQBUr98a3sGooK0WHUfyDdXbKgbDmwDOWh5GpFDBjY6MLBjSZrqJ62iffNjCpVZAP/bDhvNMXX1jR/L+964QfKQRkfxiit4dhxLqBl8UWYYkH0FIDD0pzkU/iDeh7A+yTMeLUL3vV7mdkY2hpEFtTmS8HWCfjeuLJo2wwz6WqFBGFIRIlVUgDKQ4+N3f5E+PkAcZBRs6OXxhUd6JmcbNLUmQA91AEyQP5GT8MsgxqSM7VhOsr3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cCY3ZeQPVrTPPGxKFDlQnEMvpftF9GgQs3AgYvDqrCE=;
 b=GjLEzfn9lSE/iJqt2to56L+VIeroMtjpgE7AXqc5xC7X+zuCXRR8JLK4htHOfs2SikCe/3ZzDweznAwCRT3q7BTg0Sw8nvF0XjZgEwcyvimYby76wTLEcukFKAgYoA4QIgS7inOG321zLChDsPM52v7ln49TgCUcdV+eReAy+lA=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from BN6PR12MB1124.namprd12.prod.outlook.com (2603:10b6:404:19::10)
 by BN7PR12MB2658.namprd12.prod.outlook.com (2603:10b6:408:25::31)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3742.8; Wed, 13 Jan
 2021 11:22:46 +0000
Received: from BN6PR12MB1124.namprd12.prod.outlook.com
 ([fe80::7cc1:989:4a2a:ab1e]) by BN6PR12MB1124.namprd12.prod.outlook.com
 ([fe80::7cc1:989:4a2a:ab1e%10]) with mapi id 15.20.3742.012; Wed, 13 Jan 2021
 11:22:46 +0000
From: Xiaojian Du <Xiaojian.Du@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 1/2] drm/amd/pm: modify the fine grain tuning function for
 Renoir
Date: Wed, 13 Jan 2021 19:22:03 +0800
Message-Id: <20210113112204.25469-1-Xiaojian.Du@amd.com>
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [180.167.199.189]
X-ClientProxiedBy: HK2PR03CA0063.apcprd03.prod.outlook.com
 (2603:1096:202:17::33) To BN6PR12MB1124.namprd12.prod.outlook.com
 (2603:10b6:404:19::10)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from jenkins-System-Product-Name.amd.com (180.167.199.189) by
 HK2PR03CA0063.apcprd03.prod.outlook.com (2603:1096:202:17::33) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3763.2 via Frontend Transport; Wed, 13 Jan 2021 11:22:43 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: c8ae85ce-87cd-44f6-4319-08d8b7b58d48
X-MS-TrafficTypeDiagnostic: BN7PR12MB2658:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN7PR12MB265873FE4618D02E63513869F1A90@BN7PR12MB2658.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8gwG2D3hKvPUEps73Z7i+IYmjgHUqd1+urpuH1xJAmZb/2X+9Yk/PSVJn9SbEZ5lT0nAGn5s+6JXjuIRHpND/X3gdmHwcuzl4hx3HAvxdA271nv/pEZMiNWTmTETBE3RVaV3kwI7T+pFZdMbz46TXNEtNklYG85CoZDlxhVg/mJpsfpxa6mF6Db1hd5QFD6DzcGyu1H/JPzK9pEvevfg9zoIrGhE+fOC9pqJ5EHh931mjrsZynYGuVEyeM9UJlQCSv5e4imbFzqsm8LTFfcgIbvgIJtmilY49ryQlpEi8BIUTxXRxAlWtCKjMtAEbVrS6Mzxx89SrA7ziiL1OVmotVGGHshrfpfUjOqKyPDDcUOq1n5EAPJShy+ys64aSpuPqmvIofCuoqmla4wLGn7Ibg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN6PR12MB1124.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(366004)(376002)(39860400002)(346002)(396003)(8676002)(8936002)(83380400001)(66476007)(478600001)(4326008)(186003)(36756003)(66556008)(16526019)(5660300002)(86362001)(316002)(7696005)(1076003)(6916009)(956004)(2906002)(2616005)(66946007)(26005)(52116002)(6666004)(6486002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?Ur1ikMSuJN0WAAT6OrZS81OC53hMSV4MUqb/mUFdsv2Jy3UlEJ6O4KmyFR5T?=
 =?us-ascii?Q?10pk5yiNNAEN8ue/voQspSVG56Cj4uYeP+O/AYRolY5flxUderwOc9kg2xhe?=
 =?us-ascii?Q?oqMpSnEEb4yEYbAexEQ92mWszmunECP60bi8amwJt4ixClFlpkJD+r3IyRT9?=
 =?us-ascii?Q?+0l99b+6gD1cz2eTG+3Dm8C65e8N+02Nh5WxlOShf/vT5rFWMHDxxtbxqFCg?=
 =?us-ascii?Q?OLL208p1YM5zJAEYSJZuG7StkidcUX9icMNsE+K/giXf8khBOx1pBuVbwBqx?=
 =?us-ascii?Q?9z1NQp4a2hkNhsoOas0gfqZxuM/6ON4/+dQAGsMs5wJYEFAqKbokIBU2f1oG?=
 =?us-ascii?Q?QcbtD+VCX/2PInsQ0OnY43xW1iyq0PF6e+unY9ntQwzwh/qIB5vmgr/+3/iZ?=
 =?us-ascii?Q?6n6JWewIyPhRQOssFpA6QtmE8eb9lKtSrdDTleRC355tlYBWJPF6jSzas3nD?=
 =?us-ascii?Q?nf/VXRvCuBYyLurpbyySCyYOAXAAgYsBHhoaiIemhmJ7t6RW0YSXfJByxFKU?=
 =?us-ascii?Q?Cr1h3pqV4ckD18bLrS4RmxIa1vkUSfdRs6okrvfh53jKpUL6UlL8CdEb73+6?=
 =?us-ascii?Q?evwoz/W5CydCXIftrOkJbzUUjVfNWKnKdtSc6is3rADZBqbP/6TGFmbPvGCX?=
 =?us-ascii?Q?lRIiAnR1viNwp9G8UrRtneaQBsDnsR4Chc/wyHbwsLoIFiXchXLIwuuv8Q3V?=
 =?us-ascii?Q?HCZQ40qi+9mG/ib40fjLI1Arz2UfMSo3x4F16IW1rejiih3EOvP3JNPl73Pc?=
 =?us-ascii?Q?91QJG2rNh9q5YLfj1o1LlRzSVQUJ576C7m20pzY/yqlqFy6eV9o4TThQZXur?=
 =?us-ascii?Q?QnKJWSEqlLZovzQ1tdl++U4YuA7CximqvSzQ47hkXkWx5C2Rjv7k3SK8wvID?=
 =?us-ascii?Q?Z/L9YBwoYDLrnhzggsDu7JYtd6nw2/kkAATvTJHV6FQIQLH34KYQfDRgrHwv?=
 =?us-ascii?Q?SSYJ3YOZyD+OusdZvPTUAEfutKWUdInaqwYF4Az4r6lPEW/Eq2on/LgtSAc9?=
 =?us-ascii?Q?q1/l?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthSource: BN6PR12MB1124.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2021 11:22:45.9042 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-Network-Message-Id: c8ae85ce-87cd-44f6-4319-08d8b7b58d48
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: h8uyUgVckknVz9p3M635yKMRD+81nOmw0W/L753WGYFwAyurkTE6BYSZJzblWR1Xnf1GuesJg6r5DhjSBkfsMg==
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

This patch is to modify the fine grain tuning function for Renoir.
The fine grain tuning function uses the sysfs node -- pp_od_clk_voltage
to config gfxclk. Meanwhile, another sysfs
node -- power_dpm_force_perfomance_level also affects the gfx clk.
It will cause confusion when these two sysfs nodes works
together.
This patch uses the existing flag to make these two sysfs nodes works
separately. Only when power_dpm_force_perfomance_level is changed
to "manual" mode, the fine grain function will be started.
In other profile modes, including "auto", "high", "low", "profile_peak",
"profile_standard", "profile_min_sclk", "profile_min_mclk",
the fine grain tuning function will be shut down and the frequency range
of gfx will be restored the default value.

Signed-off-by: Xiaojian Du <Xiaojian.Du@amd.com>
---
 drivers/gpu/drm/amd/pm/amdgpu_pm.c            |  2 +-
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c     |  4 ----
 .../gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c   | 20 +++++--------------
 3 files changed, 6 insertions(+), 20 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
index ecd72d896b49..80d6298912aa 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
@@ -2221,7 +2221,7 @@ static int default_attr_update(struct amdgpu_device *adev, struct amdgpu_device_
 	} else if (DEVICE_ATTR_IS(pp_od_clk_voltage)) {
 		*states = ATTR_STATE_UNSUPPORTED;
 		if ((is_support_sw_smu(adev) && adev->smu.od_enabled) ||
-		    (is_support_sw_smu(adev) && adev->smu.fine_grain_enabled) ||
+		    (is_support_sw_smu(adev) && adev->smu.is_apu) ||
 			(!is_support_sw_smu(adev) && hwmgr->od_enabled))
 			*states = ATTR_STATE_SUPPORTED;
 	} else if (DEVICE_ATTR_IS(mem_busy_percent)) {
diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
index e94d1b4551b4..976a9105aecc 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -416,10 +416,6 @@ static int smu_set_funcs(struct amdgpu_device *adev)
 		break;
 	case CHIP_RENOIR:
 		renoir_set_ppt_funcs(smu);
-		/* enable the fine grain tuning function by default */
-		smu->fine_grain_enabled = true;
-		/* close the fine grain tuning function by default */
-		smu->fine_grain_started = false;
 		break;
 	case CHIP_VANGOGH:
 		vangogh_set_ppt_funcs(smu);
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c
index f33f5141cbe1..6c8a8ccd2f84 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c
@@ -349,17 +349,13 @@ static int renoir_od_edit_dpm_table(struct smu_context *smu,
 							long input[], uint32_t size)
 {
 	int ret = 0;
+	struct smu_dpm_context *smu_dpm_ctx = &(smu->smu_dpm);
 
-	if (!smu->fine_grain_enabled) {
+	if (!(smu_dpm_ctx->dpm_level == AMD_DPM_FORCED_LEVEL_MANUAL)) {
 		dev_warn(smu->adev->dev, "Fine grain is not enabled!\n");
 		return -EINVAL;
 	}
 
-	if (!smu->fine_grain_started) {
-		dev_warn(smu->adev->dev, "Fine grain is enabled but not started!\n");
-		return -EINVAL;
-	}
-
 	switch (type) {
 	case PP_OD_EDIT_SCLK_VDDC_TABLE:
 		if (size != 2) {
@@ -482,6 +478,7 @@ static int renoir_print_clk_levels(struct smu_context *smu,
 	int i, size = 0, ret = 0;
 	uint32_t cur_value = 0, value = 0, count = 0, min = 0, max = 0;
 	SmuMetrics_t metrics;
+	struct smu_dpm_context *smu_dpm_ctx = &(smu->smu_dpm);
 	bool cur_value_match_level = false;
 
 	memset(&metrics, 0, sizeof(metrics));
@@ -492,7 +489,7 @@ static int renoir_print_clk_levels(struct smu_context *smu,
 
 	switch (clk_type) {
 	case SMU_OD_RANGE:
-		if (smu->fine_grain_enabled) {
+		if (smu_dpm_ctx->dpm_level == AMD_DPM_FORCED_LEVEL_MANUAL) {
 			ret = smu_cmn_send_smc_msg_with_param(smu,
 						SMU_MSG_GetMinGfxclkFrequency,
 						0, &min);
@@ -507,7 +504,7 @@ static int renoir_print_clk_levels(struct smu_context *smu,
 		}
 		break;
 	case SMU_OD_SCLK:
-		if (smu->fine_grain_enabled) {
+		if (smu_dpm_ctx->dpm_level == AMD_DPM_FORCED_LEVEL_MANUAL) {
 			min = (smu->gfx_actual_hard_min_freq > 0) ? smu->gfx_actual_hard_min_freq : smu->gfx_default_hard_min_freq;
 			max = (smu->gfx_actual_soft_max_freq > 0) ? smu->gfx_actual_soft_max_freq : smu->gfx_default_soft_max_freq;
 			size += sprintf(buf + size, "OD_SCLK\n");
@@ -897,28 +894,24 @@ static int renoir_set_performance_level(struct smu_context *smu,
 
 	switch (level) {
 	case AMD_DPM_FORCED_LEVEL_HIGH:
-		smu->fine_grain_started = 0;
 		smu->gfx_actual_hard_min_freq = smu->gfx_default_hard_min_freq;
 		smu->gfx_actual_soft_max_freq = smu->gfx_default_soft_max_freq;
 
 		ret = renoir_force_dpm_limit_value(smu, true);
 		break;
 	case AMD_DPM_FORCED_LEVEL_LOW:
-		smu->fine_grain_started = 0;
 		smu->gfx_actual_hard_min_freq = smu->gfx_default_hard_min_freq;
 		smu->gfx_actual_soft_max_freq = smu->gfx_default_soft_max_freq;
 
 		ret = renoir_force_dpm_limit_value(smu, false);
 		break;
 	case AMD_DPM_FORCED_LEVEL_AUTO:
-		smu->fine_grain_started = 0;
 		smu->gfx_actual_hard_min_freq = smu->gfx_default_hard_min_freq;
 		smu->gfx_actual_soft_max_freq = smu->gfx_default_soft_max_freq;
 
 		ret = renoir_unforce_dpm_levels(smu);
 		break;
 	case AMD_DPM_FORCED_LEVEL_PROFILE_STANDARD:
-		smu->fine_grain_started = 0;
 		smu->gfx_actual_hard_min_freq = smu->gfx_default_hard_min_freq;
 		smu->gfx_actual_soft_max_freq = smu->gfx_default_soft_max_freq;
 
@@ -974,7 +967,6 @@ static int renoir_set_performance_level(struct smu_context *smu,
 		break;
 	case AMD_DPM_FORCED_LEVEL_PROFILE_MIN_SCLK:
 	case AMD_DPM_FORCED_LEVEL_PROFILE_MIN_MCLK:
-		smu->fine_grain_started = 0;
 		smu->gfx_actual_hard_min_freq = smu->gfx_default_hard_min_freq;
 		smu->gfx_actual_soft_max_freq = smu->gfx_default_soft_max_freq;
 
@@ -989,14 +981,12 @@ static int renoir_set_performance_level(struct smu_context *smu,
 		renoir_force_clk_levels(smu, SMU_SOCCLK, 1 << soc_mask);
 		break;
 	case AMD_DPM_FORCED_LEVEL_PROFILE_PEAK:
-		smu->fine_grain_started = 0;
 		smu->gfx_actual_hard_min_freq = smu->gfx_default_hard_min_freq;
 		smu->gfx_actual_soft_max_freq = smu->gfx_default_soft_max_freq;
 
 		ret = renoir_set_peak_clock_by_device(smu);
 		break;
 	case AMD_DPM_FORCED_LEVEL_MANUAL:
-		smu->fine_grain_started = 1;
 	case AMD_DPM_FORCED_LEVEL_PROFILE_EXIT:
 	default:
 		break;
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
