Return-Path: <SRS0=8Dg8=KP=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1B82C433B4
	for <amd-gfx@archiver.kernel.org>; Thu, 20 May 2021 05:16:25 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7496D611BD
	for <amd-gfx@archiver.kernel.org>; Thu, 20 May 2021 05:16:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7496D611BD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 95E916EEA0;
	Thu, 20 May 2021 05:16:24 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2089.outbound.protection.outlook.com [40.107.243.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E9A976E0C2
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 May 2021 05:16:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IrE6Mlivz3XFwECmYP0gNtjKsFln00FiWsvFEhJVal0AfQsn2Wl/pO+JzRhjncQnBZloxQXwOlg9EVqNByGHf5evIp6FL1wsxwazInxuwmjd4Rg3CgpXH+rRHAHLz93yVooHB8avPQHmNne6asTU6HcmaUYSrrWl6vN/q/nrgZ3ofEa0KyP6WvckY6elwBDLOKknGedv5DFhPIRo+mmVmik8Z/V2K2Dzmd4Wf4OSGGgOLzqJxZIOT4TQE2kD0Esn/Pi5DQ7kGf72C7HuEss6XkpJz/3QrzRJMIOZvrWYaZLHYgSABa6XvWYB7mX1zcS+cRzHzpDIV6f0AyD7FcqdAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BTmGHs7d5uPo9t4iyWmgvnKbsYwkBUI6H+31idFUYd0=;
 b=XQ6wwfWh8dFjdj6oNmp1YBVx3vkpOzv1utI0XP7MO15DhM2aiwzqwNpdBL9ndYq6wW9tk1/aKttatK0kULu0XowMOyeDmo1GzCXz9Cfd9KB1etHEP6X0Lia8yrIaXNSPPRGt9spaBWj3lSykOnIXjS3SDC/DFoQS1wK8xydFygzVIgCPQNAZRl30Ojrt9LDSPfLfOtPmGC6TR/WgMdarmN1WWOlEpndA2x2bK2zBwY5sr8XD+gwzWe+9T4LzrmDxef8mFNPOt+3+AlVu1GrgljOt5yEUDSVEv5vKxbBkrMvU07X2aABdXtC3HJJ82YvZwOKEx3oVXw756wFKD8xXBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BTmGHs7d5uPo9t4iyWmgvnKbsYwkBUI6H+31idFUYd0=;
 b=C5Kb1zPFXR8y0pgqWh9Jk7Yumm8VY8s1G+ztDXN/pnvaxQT9WPntgz0JcyKihK4AOTRiARMmYd2+H8NHBfKV6s3gY62cSSox6y3jWeAmxvYVUfh0V+pRaPDZI6Jk+JLGmIuSTqc/CcjdMGSleSqUWIoy92MwJ7eliF0SHSDum+Y=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB2840.namprd12.prod.outlook.com (2603:10b6:a03:62::32)
 by BYAPR12MB3127.namprd12.prod.outlook.com (2603:10b6:a03:d8::33)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.28; Thu, 20 May
 2021 05:16:20 +0000
Received: from BYAPR12MB2840.namprd12.prod.outlook.com
 ([fe80::7c65:7181:6d1d:8616]) by BYAPR12MB2840.namprd12.prod.outlook.com
 ([fe80::7c65:7181:6d1d:8616%7]) with mapi id 15.20.4129.034; Thu, 20 May 2021
 05:16:20 +0000
From: David M Nieto <david.nieto@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdgpu/pm: display vcn pp dpm (v4)
Date: Wed, 19 May 2021 22:16:05 -0700
Message-Id: <20210520051605.24746-1-david.nieto@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <476f8809-5521-98b4-e08f-1d06fc099468@amd.com>
References: <476f8809-5521-98b4-e08f-1d06fc099468@amd.com>
X-Originating-IP: [165.204.53.123]
X-ClientProxiedBy: SJ0PR05CA0177.namprd05.prod.outlook.com
 (2603:10b6:a03:339::32) To BYAPR12MB2840.namprd12.prod.outlook.com
 (2603:10b6:a03:62::32)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from loud-cracker.amd.com (165.204.53.123) by
 SJ0PR05CA0177.namprd05.prod.outlook.com (2603:10b6:a03:339::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.12 via Frontend
 Transport; Thu, 20 May 2021 05:16:20 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: aecf4630-a088-497d-af96-08d91b4e672b
X-MS-TrafficTypeDiagnostic: BYAPR12MB3127:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR12MB3127D3F6831063DCC70E5F64F42A9@BYAPR12MB3127.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:45;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DnxCGfo7//ZxkO0aN8YldUFBrAkFP/xvWqLlDrzoRcrlNiA4C2T4fbeflrKfgaqkXWAWxYfFSeUWV49K1h8hHfuNHzZ8iW5anFTTklgHz18WzLMKD+/AlsG856Dkb4hFUTP0u4EOCzpJBJKlI0voxGXPBNZNSPURdEKs5vlEeKspYmjPhnqOClOlmlugN6rhjhUNGMYdOGAwhDGbNKXauS/oPSuDZjfx4rI7RjwSVaYSKnrPUe5u7nU3CJsq0g1hpohDORu96eQFO7L1nEzs1PGDvNeNC7cMnnr9q98+RUXaPirRWDHlOnr+PG2zcc9kau8CE8qK+bFQReL0DRUZmebA92ossoZT6kT4xNEWsqsDP0utw3FYHqxjJydeTXSn0t6xlO9bAH8dFfLli/LiOiYktGttAlErzMgAOD6gktIIHuLCF6TkzQwu0yvcnqGSg0gDdM+8I03tR0JWo42Da8jZXcb2IHtH50ullGgOYGR+dyjR8HEBs5+6p5RcTsaR5b6isOQFNd+Nxe6RIUKdgdFP8SsPDRK69RDmiUQ+SoCgwchaRS+lXAvrbTdlMtpv672ifQF3pJB8GU4ECjIfqr+Kz7ngoRsArP2sffmCJnYXI0ZziklgWpNKKILAsSIevIOxK47Aw8qwLXdbi+EiCA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB2840.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(376002)(366004)(39860400002)(396003)(136003)(8936002)(8676002)(86362001)(316002)(478600001)(4326008)(2616005)(956004)(1076003)(6666004)(6486002)(186003)(6916009)(2906002)(7696005)(52116002)(16526019)(26005)(66946007)(36756003)(5660300002)(66556008)(83380400001)(38350700002)(66476007)(38100700002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?eS1I2xfef1/tA6hEXDrvKlSrE9cyXH2bdqz5jfenKioNo8NoYwVy7Z64qZg4?=
 =?us-ascii?Q?ao5pT6RCpt4y/ZKpLDzgzqcVJKFPZe9X4MNQRwV+KWE8vZQtguOFTD3RFKEK?=
 =?us-ascii?Q?C5Z3BRHr5LvTTDUCzFMlQk32JZSqqLM9pPwat+XFfcrpr/6vgwuzlf+brWW+?=
 =?us-ascii?Q?gvBfUcjRDKn+UH/PVz9f4dMjqCX3JLq0ZUXkAsBrscAMs5aYN3WzOdYPIpbH?=
 =?us-ascii?Q?glmUR/FDDn56vbw3QpaQMOzeM0ZXu8h2I1jNeFhWbbcF17FdmioSlJsv1NXq?=
 =?us-ascii?Q?BTHYtUXUbqr+tJqBEmNHOI4lu7by2dBjGkFhkOmmu+qzNKcQ4aW8ThAYdD9N?=
 =?us-ascii?Q?ds5zTiRa8E0Zk20ZuMvFx/LmCEFti0EL3D7q8Tw12GqO9vuvXNsnz1h/6BKa?=
 =?us-ascii?Q?YnlCV3pdgeJChkxKsQG/8Pcs4CxTFvj62u9riASOrIJfEs7tTOzmi/wqQwEG?=
 =?us-ascii?Q?k9F29B+TeGTzTreIpcVMg3oubh/lDgX6dPae8Js5LKpACk8cbrMxUfPWDga3?=
 =?us-ascii?Q?SWtZgOH/OscRV1vqw6Ipr1rQ9ZXEvQHCBUbvF8UlVv2l8y8IRPXrjCoQKKAe?=
 =?us-ascii?Q?a+pCfbamudkR+CUzIwQc3X7vDdrS0yYWVE5r+ZuISxtwkCmXztMoFgWPUZht?=
 =?us-ascii?Q?IoVDg+a5pFu8JpiYakyYszNLN8fVEySHmQOQJjsOO1xdpt4oRv7Bn5TIlakN?=
 =?us-ascii?Q?GOkhiYsjGefiJZzzIoKBHy2qpYTzmiy/aurwDI9+3ALmuOOq7SNGtFIjAUkS?=
 =?us-ascii?Q?Pw0Fw2NMY1/sBWMdrSEct9m81El/599SgM1jQmaemPd0jZBFJ+Oobg9NBU6G?=
 =?us-ascii?Q?B7JstKpOGFJgW1DKchJQivibYSWu7vfUqnxCZSgT6WC2TK6EAdMJHtDqyMjn?=
 =?us-ascii?Q?2cOrTnrDvt71Zty18brOwXhIKNC31hTd5WU2BZjYT8aMT0Wq3zfN5mrYelOD?=
 =?us-ascii?Q?0pPmkuIJTOY+cqcPQilp5ULDHFaVQf1mWQksZD/g8vIlZSfRTvczqSQ5Lm22?=
 =?us-ascii?Q?jHxb8xQHEVcOG7x0uxXxIGEkGwFs5CTU1inGfQUBW5NwyKjkoTFEwM6lDca4?=
 =?us-ascii?Q?Q4IcfQVwnhOW2qFQyzexYzK8rhyhcymfbzZ18PErIIk+ySXocQ3t48buJdqe?=
 =?us-ascii?Q?N6Bd2o8fW4V0vPia88LUe1/+e0Qh/09DBMFeWireuov0OxCcJa7dwl5fLYi4?=
 =?us-ascii?Q?JCD5hCbVjf/4g+zJ6gy12fZP3ndZTCgPhe/lYlpL9XFqMYGG9+gNuUXQT98A?=
 =?us-ascii?Q?XkRh7IXQjOkRZzWSVvmihZlxkWp5B/HFOSB1f9pl63mBjGuEF+2iibsSZHt3?=
 =?us-ascii?Q?irTi7gJkkoUuYMSgR0j/yxbH?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aecf4630-a088-497d-af96-08d91b4e672b
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB2840.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2021 05:16:20.6178 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +UhX+gNpvcFdyvSxW3K6EuvoBcmo7elWWECntxOfI79nxz7XzqcxaXjuKOCT5rUX
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3127
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
Cc: David M Nieto <david.nieto@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Enable displaying DPM levels for VCN clocks
in swsmu supported ASICs

v2: removed set functions for navi, renoir
v3: removed set function from arcturus
v4: added missing defines in drm_table and remove
 uneeded goto label in navi10_ppt.c

Signed-off-by: David M Nieto <david.nieto@amd.com>
Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>
Change-Id: I01959a97b02aa87a6deb4a89010858cc93838cd7
---
 drivers/gpu/drm/amd/display/dc/dm_pp_smu.h    |  4 ++
 .../gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c | 46 +++++++++++++++++++
 .../gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c   | 10 +---
 .../amd/pm/swsmu/smu11/sienna_cichlid_ppt.c   |  4 ++
 .../gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c   | 33 +++++++++++++
 .../drm/amd/pm/swsmu/smu13/aldebaran_ppt.c    | 46 +++++++++++++++++++
 6 files changed, 135 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dm_pp_smu.h b/drivers/gpu/drm/amd/display/dc/dm_pp_smu.h
index fb41140e8381..4440d08743aa 100644
--- a/drivers/gpu/drm/amd/display/dc/dm_pp_smu.h
+++ b/drivers/gpu/drm/amd/display/dc/dm_pp_smu.h
@@ -245,6 +245,8 @@ struct pp_smu_funcs_nv {
 #define PP_SMU_NUM_DCFCLK_DPM_LEVELS  8
 #define PP_SMU_NUM_FCLK_DPM_LEVELS    4
 #define PP_SMU_NUM_MEMCLK_DPM_LEVELS  4
+#define PP_SMU_NUM_DCLK_DPM_LEVELS    8
+#define PP_SMU_NUM_VCLK_DPM_LEVELS    8
 
 struct dpm_clock {
   uint32_t  Freq;    // In MHz
@@ -258,6 +260,8 @@ struct dpm_clocks {
 	struct dpm_clock SocClocks[PP_SMU_NUM_SOCCLK_DPM_LEVELS];
 	struct dpm_clock FClocks[PP_SMU_NUM_FCLK_DPM_LEVELS];
 	struct dpm_clock MemClocks[PP_SMU_NUM_MEMCLK_DPM_LEVELS];
+	struct dpm_clock VClocks[PP_SMU_NUM_VCLK_DPM_LEVELS];
+	struct dpm_clock DClocks[PP_SMU_NUM_DCLK_DPM_LEVELS];
 };
 
 
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
index 77693bf0840c..1735a96dd307 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
@@ -822,6 +822,52 @@ static int arcturus_print_clk_levels(struct smu_context *smu,
 				now) ? "*" : ""));
 		break;
 
+	case SMU_VCLK:
+		ret = arcturus_get_current_clk_freq_by_table(smu, SMU_VCLK, &now);
+		if (ret) {
+			dev_err(smu->adev->dev, "Attempt to get current vclk Failed!");
+			return ret;
+		}
+
+		single_dpm_table = &(dpm_context->dpm_tables.vclk_table);
+		ret = arcturus_get_clk_table(smu, &clocks, single_dpm_table);
+		if (ret) {
+			dev_err(smu->adev->dev, "Attempt to get vclk levels Failed!");
+			return ret;
+		}
+
+		for (i = 0; i < single_dpm_table->count; i++)
+			size += sprintf(buf + size, "%d: %uMhz %s\n",
+				i, single_dpm_table->dpm_levels[i].value,
+				(clocks.num_levels == 1) ? "*" :
+				(arcturus_freqs_in_same_level(
+				clocks.data[i].clocks_in_khz / 1000,
+				now) ? "*" : ""));
+		break;
+
+	case SMU_DCLK:
+		ret = arcturus_get_current_clk_freq_by_table(smu, SMU_DCLK, &now);
+		if (ret) {
+			dev_err(smu->adev->dev, "Attempt to get current dclk Failed!");
+			return ret;
+		}
+
+		single_dpm_table = &(dpm_context->dpm_tables.dclk_table);
+		ret = arcturus_get_clk_table(smu, &clocks, single_dpm_table);
+		if (ret) {
+			dev_err(smu->adev->dev, "Attempt to get dclk levels Failed!");
+			return ret;
+		}
+
+		for (i = 0; i < single_dpm_table->count; i++)
+			size += sprintf(buf + size, "%d: %uMhz %s\n",
+				i, single_dpm_table->dpm_levels[i].value,
+				(clocks.num_levels == 1) ? "*" :
+				(arcturus_freqs_in_same_level(
+				clocks.data[i].clocks_in_khz / 1000,
+				now) ? "*" : ""));
+		break;
+
 	case SMU_PCIE:
 		gen_speed = smu_v11_0_get_current_pcie_link_speed_level(smu);
 		lane_width = smu_v11_0_get_current_pcie_link_width_level(smu);
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
index 770b181239a3..78fe13183e8b 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
@@ -1273,6 +1273,8 @@ static int navi10_print_clk_levels(struct smu_context *smu,
 	case SMU_MCLK:
 	case SMU_UCLK:
 	case SMU_FCLK:
+	case SMU_VCLK:
+	case SMU_DCLK:
 	case SMU_DCEFCLK:
 		ret = navi10_get_current_clk_freq_by_table(smu, clk_type, &cur_value);
 		if (ret)
@@ -2694,8 +2696,6 @@ static ssize_t navi10_get_legacy_gpu_metrics(struct smu_context *smu,
 	*table = (void *)gpu_metrics;
 
 	return sizeof(struct gpu_metrics_v1_3);
-out:
-	return ret;
 }
 
 static ssize_t navi10_get_gpu_metrics(struct smu_context *smu,
@@ -2771,8 +2771,6 @@ static ssize_t navi10_get_gpu_metrics(struct smu_context *smu,
 	*table = (void *)gpu_metrics;
 
 	return sizeof(struct gpu_metrics_v1_3);
-out:
-	return ret;
 }
 
 static ssize_t navi12_get_legacy_gpu_metrics(struct smu_context *smu,
@@ -2851,8 +2849,6 @@ static ssize_t navi12_get_legacy_gpu_metrics(struct smu_context *smu,
 	*table = (void *)gpu_metrics;
 
 	return sizeof(struct gpu_metrics_v1_3);
-out:
-	return ret;
 }
 
 static ssize_t navi12_get_gpu_metrics(struct smu_context *smu,
@@ -2933,8 +2929,6 @@ static ssize_t navi12_get_gpu_metrics(struct smu_context *smu,
 	*table = (void *)gpu_metrics;
 
 	return sizeof(struct gpu_metrics_v1_3);
-out:
-	return ret;
 }
 
 static ssize_t navi1x_get_gpu_metrics(struct smu_context *smu,
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
index d98fb8bc084b..75acdb80c499 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
@@ -987,6 +987,10 @@ static int sienna_cichlid_print_clk_levels(struct smu_context *smu,
 	case SMU_MCLK:
 	case SMU_UCLK:
 	case SMU_FCLK:
+	case SMU_VCLK:
+	case SMU_VCLK1:
+	case SMU_DCLK:
+	case SMU_DCLK1:
 	case SMU_DCEFCLK:
 		ret = sienna_cichlid_get_current_clk_freq_by_table(smu, clk_type, &cur_value);
 		if (ret)
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c
index f43b4c623685..1c399c4ab4dc 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c
@@ -109,6 +109,8 @@ static struct cmn2asic_mapping renoir_clk_map[SMU_CLK_COUNT] = {
 	CLK_MAP(SOCCLK, CLOCK_SOCCLK),
 	CLK_MAP(UCLK, CLOCK_FCLK),
 	CLK_MAP(MCLK, CLOCK_FCLK),
+	CLK_MAP(VCLK, CLOCK_VCLK),
+	CLK_MAP(DCLK, CLOCK_DCLK),
 };
 
 static struct cmn2asic_mapping renoir_table_map[SMU_TABLE_COUNT] = {
@@ -202,6 +204,17 @@ static int renoir_get_dpm_clk_limited(struct smu_context *smu, enum smu_clk_type
 			return -EINVAL;
 		*freq = clk_table->FClocks[dpm_level].Freq;
 		break;
+	case SMU_VCLK:
+		if (dpm_level >= NUM_VCN_DPM_LEVELS)
+			return -EINVAL;
+		*freq = clk_table->VClocks[dpm_level].Freq;
+		break;
+	case SMU_DCLK:
+		if (dpm_level >= NUM_VCN_DPM_LEVELS)
+			return -EINVAL;
+		*freq = clk_table->DClocks[dpm_level].Freq;
+		break;
+
 	default:
 		return -EINVAL;
 	}
@@ -532,6 +545,14 @@ static int renoir_print_clk_levels(struct smu_context *smu,
 		count = NUM_FCLK_DPM_LEVELS;
 		cur_value = metrics.ClockFrequency[CLOCK_FCLK];
 		break;
+	case SMU_VCLK:
+		count = NUM_VCN_DPM_LEVELS;
+		cur_value = metrics.ClockFrequency[CLOCK_VCLK];
+		break;
+	case SMU_DCLK:
+		count = NUM_VCN_DPM_LEVELS;
+		cur_value = metrics.ClockFrequency[CLOCK_DCLK];
+		break;
 	default:
 		break;
 	}
@@ -543,6 +564,8 @@ static int renoir_print_clk_levels(struct smu_context *smu,
 	case SMU_MCLK:
 	case SMU_DCEFCLK:
 	case SMU_FCLK:
+	case SMU_VCLK:
+	case SMU_DCLK:
 		for (i = 0; i < count; i++) {
 			ret = renoir_get_dpm_clk_limited(smu, clk_type, i, &value);
 			if (ret)
@@ -730,6 +753,16 @@ static int renoir_get_dpm_clock_table(struct smu_context *smu, struct dpm_clocks
 		clock_table->MemClocks[i].Vol = table->MemClocks[i].Vol;
 	}
 
+	for (i = 0; i < NUM_VCN_DPM_LEVELS; i++) {
+		clock_table->VClocks[i].Freq = table->VClocks[i].Freq;
+		clock_table->VClocks[i].Vol = table->VClocks[i].Vol;
+	}
+
+	for (i = 0; i < NUM_VCN_DPM_LEVELS; i++) {
+		clock_table->DClocks[i].Freq = table->DClocks[i].Freq;
+		clock_table->DClocks[i].Vol = table->DClocks[i].Vol;
+	}
+
 	return 0;
 }
 
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
index 7c191a5d6db9..fb744f3e17d7 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
@@ -816,6 +816,52 @@ static int aldebaran_print_clk_levels(struct smu_context *smu,
 								       now) ? "*" : ""));
 		break;
 
+	case SMU_VCLK:
+		ret = aldebaran_get_current_clk_freq_by_table(smu, SMU_VCLK, &now);
+		if (ret) {
+			dev_err(smu->adev->dev, "Attempt to get current vclk Failed!");
+			return ret;
+		}
+
+		single_dpm_table = &(dpm_context->dpm_tables.vclk_table);
+		ret = aldebaran_get_clk_table(smu, &clocks, single_dpm_table);
+		if (ret) {
+			dev_err(smu->adev->dev, "Attempt to get vclk levels Failed!");
+			return ret;
+		}
+
+		for (i = 0; i < single_dpm_table->count; i++)
+			size += sprintf(buf + size, "%d: %uMhz %s\n",
+					i, single_dpm_table->dpm_levels[i].value,
+					(clocks.num_levels == 1) ? "*" :
+					(aldebaran_freqs_in_same_level(
+								       clocks.data[i].clocks_in_khz / 1000,
+								       now) ? "*" : ""));
+		break;
+
+	case SMU_DCLK:
+		ret = aldebaran_get_current_clk_freq_by_table(smu, SMU_DCLK, &now);
+		if (ret) {
+			dev_err(smu->adev->dev, "Attempt to get current dclk Failed!");
+			return ret;
+		}
+
+		single_dpm_table = &(dpm_context->dpm_tables.dclk_table);
+		ret = aldebaran_get_clk_table(smu, &clocks, single_dpm_table);
+		if (ret) {
+			dev_err(smu->adev->dev, "Attempt to get dclk levels Failed!");
+			return ret;
+		}
+
+		for (i = 0; i < single_dpm_table->count; i++)
+			size += sprintf(buf + size, "%d: %uMhz %s\n",
+					i, single_dpm_table->dpm_levels[i].value,
+					(clocks.num_levels == 1) ? "*" :
+					(aldebaran_freqs_in_same_level(
+								       clocks.data[i].clocks_in_khz / 1000,
+								       now) ? "*" : ""));
+		break;
+
 	default:
 		break;
 	}
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
