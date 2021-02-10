Return-Path: <SRS0=kdbD=HM=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EF2AC433E0
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Feb 2021 04:41:29 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CC90764E25
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Feb 2021 04:41:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CC90764E25
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4961A6E158;
	Wed, 10 Feb 2021 04:41:28 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2063.outbound.protection.outlook.com [40.107.220.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3E8EC6E156
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 Feb 2021 04:41:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a6XoCy7ZKZZhWthW/QalMFJku6Ib8pV8I4zZ4qX7QELsGW8suKkWryc+wXqsxJC9LDeRRMUpuFxQQlXur4Mz/E/J4q4wOzejE1hKZ0LmvzZ85vL1jnv2AThpJkZfiJQ1fGTP4wJzCc8oao4n7h/20XhTXsMflgbKbG9s0FxAEQnsRyoEezTNiIsgQKqnPSrdBY4uYF9717ZivA+eZEqoRVjs/HqKK8BIEsUeZPWgS+61mvur/r7etYkn2zHJ5pA0sR/jZpH1e+YCBjtf9XfHilhjoXz80hiJD8ZmM4sWYeC5U8CvlgmKFQWiAy0xu/+QFVyXndmFJwMFXmeuzyBleA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cJd9bxrpigQpdQ6QVXrlOIdeiWr2y1+SfXQ2PVgwhcs=;
 b=O1kOm1t1ioiPDPrjBo2CVACP5ytq57eGPZra0m946FWl8rkpH5f0e8yaYcniBm/T35tdhlzP8iEW/SPY9IUL8byZ7VFqQc3wUSCos/MUgFGqhku4ASUgt87zuzLXJtAlfZvBKaBX3ivpRyJVkIKxBlhYbvnEzz28dWclpKo397d1JMaGPP7CleLIoRCD9oJNIM28SC8jHTnMLzGLacKk5J77w6eX3FzDZ50XhJ5PPF+LX7AY32GR9YtcRr7gdgCc+DlBXyvN+fqpO/yeojARBHqhUbgBCQB32EHkDXWJZvNos79HTX8yK2DaPK4/BhFbxa23LmI2VIN9UJY0SNQ0DQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cJd9bxrpigQpdQ6QVXrlOIdeiWr2y1+SfXQ2PVgwhcs=;
 b=5NWlA0QIJv7QM9M8ohNpIDVl9uotIW/dGYdy13r7a6HR/86fMeafHf6lW7UtW8JCRKedVT/3XXxRPAGyvy70qYans8gvRSeRR5ge7C1G8CSjgyi/c1lraOcyzerLcKK7HPTH+BL6GY/eQxJOPBkJqzZChSQsOMj2/QOoqDsdzNk=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MWHPR12MB1248.namprd12.prod.outlook.com (2603:10b6:300:12::21)
 by MWHPR12MB1312.namprd12.prod.outlook.com (2603:10b6:300:11::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3825.30; Wed, 10 Feb
 2021 04:41:25 +0000
Received: from MWHPR12MB1248.namprd12.prod.outlook.com
 ([fe80::8c0d:7831:bfa8:d98]) by MWHPR12MB1248.namprd12.prod.outlook.com
 ([fe80::8c0d:7831:bfa8:d98%6]) with mapi id 15.20.3846.025; Wed, 10 Feb 2021
 04:41:24 +0000
From: Huang Rui <ray.huang@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amd/pm: do not issue message while write "r" into
 pp_od_clk_voltage
Date: Wed, 10 Feb 2021 12:41:04 +0800
Message-Id: <20210210044104.3941828-1-ray.huang@amd.com>
X-Mailer: git-send-email 2.25.1
X-Originating-IP: [180.167.199.189]
X-ClientProxiedBy: HK2PR02CA0193.apcprd02.prod.outlook.com
 (2603:1096:201:21::29) To MWHPR12MB1248.namprd12.prod.outlook.com
 (2603:10b6:300:12::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from hr-amd.amd.com (180.167.199.189) by
 HK2PR02CA0193.apcprd02.prod.outlook.com (2603:1096:201:21::29) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3846.27 via Frontend Transport; Wed, 10 Feb 2021 04:41:23 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 7d06c715-4f22-417a-1611-08d8cd7e1f1e
X-MS-TrafficTypeDiagnostic: MWHPR12MB1312:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MWHPR12MB13123CE22DFFA208BC5B96DAEC8D9@MWHPR12MB1312.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: p/AM7D98ZrfeSsvDnqRb7jvkx6fNT7r/FI4pNHIdKyxANSjUkV2qsAmRKe/agRKyWatLSEDgxs4GBH/a06v7+A4TEpN1bNgsp1yRtHOcYhva4sG1xzUJu1i7rRnzXw0mVh3jHWel3xw/fHOnzuYjnVFdahklKi/wzxewfvh+79IRbY52qfWkR2CgEX8dzV300xTiq63bxdn2h13pB2mWFGfRH715V9Qzj3lrw11elgq0j5x/0xolVn+HpkGbKbcAY7HWzaC/lNTnSSu3oXOSzVJteVMV7be3bjVlEDNPrUtnQxRdAuZ/RyYRQkyddBrGvUV6mL8XqbMwHsC3RZTRG5o6Ze7emiWW1msbM8OhWdDuaoxmrFyNkNecERhFtcF39PrELT0zGy/PGPN4s1kFWN3g1cOuNENEjJdFlCWrQHHZYg63guNX54oDseqrbQm0sHdrIKrsSzvdboDaGf0aS54nyS+vz6vekcrE3Vs/7j1aO5tQ6yddF1H8Z/LMfXUrZZfh7IcSpzlvueGKzloZEg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MWHPR12MB1248.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(346002)(366004)(376002)(396003)(136003)(2906002)(7696005)(52116002)(66946007)(6486002)(6666004)(66556008)(1076003)(66476007)(8676002)(86362001)(83380400001)(36756003)(2616005)(186003)(16526019)(5660300002)(956004)(6916009)(478600001)(26005)(54906003)(15650500001)(316002)(4326008)(8936002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?M4QWTuivGxzW1M50FXrFqqBPoYKOIfJGa+Ei1dgqFzmB++WXQRzdD8zZZ612?=
 =?us-ascii?Q?V2UKf1sHXlf7PNWL10ijnaB+xb80yB5yWcwb3JsjuZupUoja9gMlVBXhB3Mg?=
 =?us-ascii?Q?JSCyiQIoByCRQ/opbmegyzabsCF0D7G7ZE6rKrORw14PdwahAMsJ5PdSaxe/?=
 =?us-ascii?Q?xPEICR0K437oRuQydL0wYunRFlb7yiq+m0JuvSH39Dyh6SeFI/7U1KHK8MHh?=
 =?us-ascii?Q?N7s9JJI+dAr0AZKOWyuOCABKcszU1Q3u3Q3LvBE2SCcWCQZZk+gPR4uvBsaq?=
 =?us-ascii?Q?/4WJmefoOStLIDB5zdV+wHF27O3hcEShuQNzWrmDA+5kvYRaGNuoGv88mwok?=
 =?us-ascii?Q?lq8jjJ6JGrUNSKQ7KPQBGDQBswtC5L528hxr2Q8WveVbOXvWnmW8RZJJ+vEc?=
 =?us-ascii?Q?DTm5nr20f5fpBgZWMKlTWtekMHeqTgtfBZ9Afrg2NgXnMJ6iqKg/O57ISd3s?=
 =?us-ascii?Q?/sjH9dRghB750Fc0+465cX/5BGRpqS8Ur/w1tXm6e7bIe28k2d02kgBYfz2h?=
 =?us-ascii?Q?BXwSZobLXCCrmYo6hbBmruKhfRGLPeeeFC701L+VtXf3qdFwOCowtN2NFKnb?=
 =?us-ascii?Q?s9BGlMK9A6Jmtt1BoXIiqhktPvzJKZLUCCzQmij03oxjlH80RDy48kxFZPIa?=
 =?us-ascii?Q?zsy+uyQJxDBcTGS9SW+928yox8amSFpioEC+N4Mpg1ZmILZw5XFv7Dl8sRYl?=
 =?us-ascii?Q?LMMf6vuprwb/g05e2ecHEJK2BCzhKIEOOYEVU/lsnu6aZOBNkYuXSkp47/uP?=
 =?us-ascii?Q?MeJP/JKj06u8GsMDCBXLYxuv3AF5OctUz3epsyZyz9Pu3tg+VIRe4T1NHAe8?=
 =?us-ascii?Q?cbkq/SsmmaD79e3IueP6We679idi+whBc24M7SUea6F7eqv49GGrTyVg/HxA?=
 =?us-ascii?Q?nILeuTC9JIYII99BLup7LMEBB1iMB6QJjkFDe5dY69tD2BINqDj1hAhrbqOn?=
 =?us-ascii?Q?D7qIqWvBk6BUqhgVzGEgP+vA1EwKl5qfP/vvr30DVDh/+p8c0vXEWa1GStpz?=
 =?us-ascii?Q?8VcOHwo1gPvS1Ha62/9mk8iOLz5374V6oVYLPeRqdVvVBTxsK2MLtMwRbjes?=
 =?us-ascii?Q?DlROsdS2VHMRuEr6AxXXJ/xP4+reSPf58ocLaqzK0XS+tuZpGtZdl9/n3bNt?=
 =?us-ascii?Q?3EzWwaXziGFTejzz12e+tmtFAU17G/YP9Qa/PVtOXcGk6+c2cxPVzJpf73yY?=
 =?us-ascii?Q?zeqcLzbK/YwZn43R3cvOgNiXPMdhyzn1GVYa0dEd/K9PzqxgRvfgJDV2jDP1?=
 =?us-ascii?Q?TW9Eido///gsCVrCckUO4oV2OK/nSAN09UE1C/bcRnq7tQuovKiy74FRFhjA?=
 =?us-ascii?Q?B8uyhSKaI2zMpQyX4LLqagph?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d06c715-4f22-417a-1611-08d8cd7e1f1e
X-MS-Exchange-CrossTenant-AuthSource: MWHPR12MB1248.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2021 04:41:24.7602 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: k5bHZWOD0UPp0fdvQdthVWwpq0Fe2fdGFGNQyni/QEZSceYRqOcZZZlPDn2UNGGSKcNJgAEDK2HpSJY6Ybzdnw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1312
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Huang Rui <ray.huang@amd.com>,
 Xiaojian Du <xiaojian.du@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

We should commit the value after restore them back to default as well.

$ echo "r" > pp_od_clk_voltage
$ echo "c" > pp_od_clk_voltage

Signed-off-by: Huang Rui <ray.huang@amd.com>
---
 .../drm/amd/pm/powerplay/hwmgr/smu10_hwmgr.c  | 14 -------
 .../gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c  | 38 -------------------
 2 files changed, 52 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu10_hwmgr.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu10_hwmgr.c
index 88322781e447..ac7769087f98 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu10_hwmgr.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu10_hwmgr.c
@@ -1526,20 +1526,6 @@ static int smu10_set_fine_grain_clk_vol(struct pp_hwmgr *hwmgr,
 
 		smu10_data->gfx_actual_soft_min_freq = min_freq;
 		smu10_data->gfx_actual_soft_max_freq = max_freq;
-
-		ret = smum_send_msg_to_smc_with_parameter(hwmgr,
-					PPSMC_MSG_SetHardMinGfxClk,
-					min_freq,
-					NULL);
-		if (ret)
-			return ret;
-
-		ret = smum_send_msg_to_smc_with_parameter(hwmgr,
-					PPSMC_MSG_SetSoftMaxGfxClk,
-					max_freq,
-					NULL);
-		if (ret)
-			return ret;
 	} else if (type == PP_OD_COMMIT_DPM_TABLE) {
 		if (size != 0) {
 			pr_err("Input parameter number not correct\n");
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
index f0f06ef47b9e..9315f20da67f 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
@@ -1451,7 +1451,6 @@ static int vangogh_od_edit_dpm_table(struct smu_context *smu, enum PP_OD_DPM_TAB
 					long input[], uint32_t size)
 {
 	int ret = 0;
-	int i;
 	struct smu_dpm_context *smu_dpm_ctx = &(smu->smu_dpm);
 
 	if (!(smu_dpm_ctx->dpm_level == AMD_DPM_FORCED_LEVEL_MANUAL)) {
@@ -1523,43 +1522,6 @@ static int vangogh_od_edit_dpm_table(struct smu_context *smu, enum PP_OD_DPM_TAB
 			smu->gfx_actual_soft_max_freq = smu->gfx_default_soft_max_freq;
 			smu->cpu_actual_soft_min_freq = smu->cpu_default_soft_min_freq;
 			smu->cpu_actual_soft_max_freq = smu->cpu_default_soft_max_freq;
-
-			ret = smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_SetHardMinGfxClk,
-									smu->gfx_actual_hard_min_freq, NULL);
-			if (ret) {
-				dev_err(smu->adev->dev, "Restore the default hard min sclk failed!");
-				return ret;
-			}
-
-			ret = smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_SetSoftMaxGfxClk,
-									smu->gfx_actual_soft_max_freq, NULL);
-			if (ret) {
-				dev_err(smu->adev->dev, "Restore the default soft max sclk failed!");
-				return ret;
-			}
-
-			if (smu->adev->pm.fw_version < 0x43f1b00) {
-				dev_warn(smu->adev->dev, "CPUSoftMax/CPUSoftMin are not supported, please update SBIOS!\n");
-				break;
-			}
-
-			for (i = 0; i < smu->cpu_core_num; i++) {
-				ret = smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_SetSoftMinCclk,
-								      (i << 20) | smu->cpu_actual_soft_min_freq,
-								      NULL);
-				if (ret) {
-					dev_err(smu->adev->dev, "Set hard min cclk failed!");
-					return ret;
-				}
-
-				ret = smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_SetSoftMaxCclk,
-								      (i << 20) | smu->cpu_actual_soft_max_freq,
-								      NULL);
-				if (ret) {
-					dev_err(smu->adev->dev, "Set soft max cclk failed!");
-					return ret;
-				}
-			}
 		}
 		break;
 	case PP_OD_COMMIT_DPM_TABLE:
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
