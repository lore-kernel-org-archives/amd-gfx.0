Return-Path: <SRS0=oeKV=KJ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A4BAC433ED
	for <amd-gfx@archiver.kernel.org>; Fri, 14 May 2021 21:01:53 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 61B8A60FDB
	for <amd-gfx@archiver.kernel.org>; Fri, 14 May 2021 21:01:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 61B8A60FDB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1C6AE6E301;
	Fri, 14 May 2021 21:01:53 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam08on2064.outbound.protection.outlook.com [40.107.101.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9929B6E30F
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 May 2021 21:01:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eDrr65VnS4s9r67AUmgYFcZcT7HomuBAfw+EDIC9RWBToiglGMaI8iR+ynnLnVI+c2nHwX9uKyhUgUsWSx/y1nzJ3vK5omF+E+z3OnfIToVx5+iNEheFnUscXWFr7q2izDm2gkFdCpym/0xsnlHiPEFKbAYQdPNknc7txwGuX5Udvw/ww2gDcHnLyvBrhEv13vlHaqEsPxwq3yNP1j64xYmoLu+YtNVvcfB1kSblClq0Ju6l/kWFiZ3cJPor2Ut2I7+OC9byieX4W4F1loy40YnpLExuFel3BuSzcbUvIpgQ/4Ga0Hj0vzr1/pnxxYKBYYcZ5HTcWaKFdtR9MScjgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UPS2VCddzgS54KO8pQ9uNeAyitHfBcskY6zgv6Cd6bg=;
 b=OaIk6VQsATUJdLuxC96hHztplV30gc1LD5klnM/iieJmr6GFfmPa6w0xewnSU3KkLjKMFDuZNLY30qL3710RXb8lUicGtBiF0m7OElCXJoI6VXVzvTY5XdmQpV3+E3REjwOTsEM8MIqoyGQHJAYqvJh9reCBBEINHKO0+okZgBJ2wwNAH7u8Z/fKyunLqNCXkrLMjXNq1mgCyLchQYYaD1Wfjq8rRQyVvOHfjlOGR+qSWrngi9hOiOxStSl9G8X4HdRNakOr/mbgKLPd216a70a1AlC51KBnvRAKDEqFgGyZFZ0deMfVxd3LNbtPvZ1+CkywVVDaX9VQ6GhN98nJdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UPS2VCddzgS54KO8pQ9uNeAyitHfBcskY6zgv6Cd6bg=;
 b=WaM3eneHo4DR01rKnwusDABwoy3FoLn3m6xRX1joRxVaKikprXOB/qaweq747XQKK6U0KLhKZikAhUPNuAe8+sHg2OFQNDpIHEOkCOzot5nFPqbijGRgpAv8sY+ohSWQK9zi0hCHDf7EMtbootHCYr4GwWsmCOty43fIKcysRGQ=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB2840.namprd12.prod.outlook.com (2603:10b6:a03:62::32)
 by BYAPR12MB4695.namprd12.prod.outlook.com (2603:10b6:a03:a4::28)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.28; Fri, 14 May
 2021 21:01:48 +0000
Received: from BYAPR12MB2840.namprd12.prod.outlook.com
 ([fe80::7c65:7181:6d1d:8616]) by BYAPR12MB2840.namprd12.prod.outlook.com
 ([fe80::7c65:7181:6d1d:8616%7]) with mapi id 15.20.4129.028; Fri, 14 May 2021
 21:01:48 +0000
From: David M Nieto <david.nieto@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 2/2] drm/amdgpu/pm: add new fields for Navi1x
Date: Fri, 14 May 2021 14:01:35 -0700
Message-Id: <20210514210135.14079-2-david.nieto@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210514210135.14079-1-david.nieto@amd.com>
References: <20210514210135.14079-1-david.nieto@amd.com>
X-Originating-IP: [165.204.53.123]
X-ClientProxiedBy: BY3PR04CA0009.namprd04.prod.outlook.com
 (2603:10b6:a03:217::14) To BYAPR12MB2840.namprd12.prod.outlook.com
 (2603:10b6:a03:62::32)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from loud-cracker.amd.com (165.204.53.123) by
 BY3PR04CA0009.namprd04.prod.outlook.com (2603:10b6:a03:217::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.25 via Frontend
 Transport; Fri, 14 May 2021 21:01:48 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4dc40f81-c1c3-4651-06b4-08d9171b7d2f
X-MS-TrafficTypeDiagnostic: BYAPR12MB4695:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR12MB46955DC9255004EA2E7BE09FF4509@BYAPR12MB4695.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:346;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qb4cawth+OSpij18ZU3F/dn4HdB53yVfmZkrFvIVfhzncx6zUf57nydpVaCYM1OZNK0U8rH5w5SEWSzlz5fkmOzh+qYJtKKOu2k/1OmWKmxC+t6/dA1EjQ5xpqTtHcfcG095nfXa6J/VA5DdX/1w1b5yq/W3vt4ZnH04KEE1MjO3qj0Q2IVtxkzvs5+YufG/OYWwY4S0JbgdJYhJTAnJFoIm5ji19PPey/3KYTUM5VJeLCDU/HedAYKhXBVAx4fc/8dce2NEsE2XnJCasRCozhGDzqI7Pc/zY1w6sW279EITG5b4VPIfWxfH4o65zkObc05RjbSKu7b1870VLuJldNLOBA3q/6ozUXw25HeDFGVbl6KqwRn34+bk5JXqLdUb1CcpOAfGaWgr9VNEtjv9zHKK8wKhUZSGQ9Y40nFHrKb8kyFlm1oLD0CCXVJLMO3+SJRfQmt9dbLEQh1HnJRhQ+wE/RekcIQWl753y/v82NECbp4S6pbEAKjmVH/DMZbCDZBL1b7m8CuBxjrOunhg6UsEDk3cAFCIbQngO+N3JfhDlYsoQebI0YSIEeqhNWsS+WR0WokCqzx9hh6deBuI8PB4O36Y83hSj1qaFn9wrjUXAAjDKRLTAlHawq+eJ61SE1eK5pMmF8KpEb+CrB7qngIrG+g98Km4ScYpyYAuXxh6fi0H5YPAtPFKp8h7wqh2
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB2840.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(396003)(39860400002)(376002)(346002)(136003)(26005)(8676002)(16526019)(6666004)(2616005)(186003)(6916009)(5660300002)(478600001)(316002)(6486002)(1076003)(66556008)(38350700002)(8936002)(19627235002)(30864003)(956004)(2906002)(7696005)(52116002)(83380400001)(36756003)(66946007)(66476007)(4326008)(86362001)(38100700002)(32563001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?qaAux+/VVbjnKu+hYU+SVuLeJft548JiNSFC/eTkKpN30f/0m1mLPml68+Z3?=
 =?us-ascii?Q?uAAbT0at9Yt1szw96vnOYxkEp24rcwnCXMd/LtjJZWtdnua2/J/MSionEs59?=
 =?us-ascii?Q?G9I6d43quzuTNv7Bp9GQR9xE58qwF/eu8GhcZUAMn2u13ay+HSoYrlhdQOiz?=
 =?us-ascii?Q?OfEjryedtswIVmEos0zfOoxEkceeKKjQSR64xGfPLFRqiz4Tt+mtovfUrmTc?=
 =?us-ascii?Q?Yvv9lmlqnjLh21ds5pUhkpvI+3SLgcBTYjelHEh33tKOI0QibSEHfs6Ctex6?=
 =?us-ascii?Q?s5GHupi/2MzJ+CD8915wUzQYQO6y/HfQbTiZakaU3PDdxHBQ/t1L7SKWjYBB?=
 =?us-ascii?Q?XxtzeppBFFr5rI4bJwhcvwptzs4PwvaoPpUfhIK0hu+sDzWnvhu9X/MKv/Ox?=
 =?us-ascii?Q?BR9hg7ulFYCuTQ3wjNCUorR3kbcyZ28oHPSVyC2ZAdZkHk7KFaMNX7xAc2W3?=
 =?us-ascii?Q?cFErx1iS6oXkGeHa0SIHYTB0oPhg33cevHfn3O0gAPlCsyBVS+gPG3oThkft?=
 =?us-ascii?Q?/8uerY3SAvoxV6xUXfHfpK5IXR0iNB98HgiB3QedimZcUYdvPe6hoUh6PJk1?=
 =?us-ascii?Q?uAJZi8q07ZNi7gSZspxS+JwzDWW9tcynSG5WpgqzrqlASt+a3cn4BxORKxzZ?=
 =?us-ascii?Q?PuSlX/I5WYY1vNuctrMnh/xPs8xidFcV4OuYE5WUTA9FejSzoqEtSMxLZJ2n?=
 =?us-ascii?Q?74ti0lUsnl3r/s9VGZdkO3WJK4sbzRrCG5yrI+HdKW2DHpZQHRUk2ohsxXjj?=
 =?us-ascii?Q?m7w10LM3dp5deLHTqnBpV4uVXNRR8AlcB0qsTmVvxs2FdA7HbgWjP6GlfOKP?=
 =?us-ascii?Q?uXsRaGNWOuLFa6fgwEuFCXpmVPPjt0AFewxsKt9yMZiUZ6wnNewETQCHiL9z?=
 =?us-ascii?Q?7+uzIOHJNilXERF866fQaqjgamyI5BGovu8pzoQAKRIVt6X+dHMmEwDUyli4?=
 =?us-ascii?Q?BlRVW2Svlna09HMysUESn/1QrhsnBsJiYbddwj67/Fm98eGMB5b8pMa67RmL?=
 =?us-ascii?Q?RKA/LPdn11kEm1Zcvtt5F4ASGaLNuC9iI76a04IRZ8zgB0ID/49R3HnaGMBP?=
 =?us-ascii?Q?n5IJ+zQvOPiJkTkOzdHiP772Casporww797fS4YxQ4pVY+X00QdZj8JxYIjK?=
 =?us-ascii?Q?sgJ/OkmvZ7zXWLocdHMd/A1Suw1Xr01nQUeSf0mntIO5uA+AEliM/N3yBzfr?=
 =?us-ascii?Q?rueIHhIsdU0HhyxPVJflJOML6vE5DBOFIVtNP0WFiZzxa9CcwAv1zy1pmIPo?=
 =?us-ascii?Q?ULcCGJ6dwqoK3s7FXhdg1sVwjEh9UhiC1wLNYE8s5p3I5+vq7ecx5yYWQp5J?=
 =?us-ascii?Q?y47/NKW4E4bOFdU4tDKfHewW?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4dc40f81-c1c3-4651-06b4-08d9171b7d2f
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB2840.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2021 21:01:48.2564 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rbAG5rtiDZd17e8PQZMPK71uMby0f6AYUeZC77TsxWCpRnFUoasU9dNtJZcdk854
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB4695
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

Fill voltage and frequency ranges fields

Signed-off-by: David M Nieto <david.nieto@amd.com>
Change-Id: I07f926dea46e80a96e1c972ba9dbc804b812d503
---
 .../gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c   | 434 +++++++++++++++++-
 1 file changed, 417 insertions(+), 17 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
index ac13042672ea..a412fa9a95ec 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
@@ -505,7 +505,7 @@ static int navi10_tables_init(struct smu_context *smu)
 		goto err0_out;
 	smu_table->metrics_time = 0;
 
-	smu_table->gpu_metrics_table_size = sizeof(struct gpu_metrics_v1_1);
+	smu_table->gpu_metrics_table_size = sizeof(struct gpu_metrics_v1_3);
 	smu_table->gpu_metrics_table = kzalloc(smu_table->gpu_metrics_table_size, GFP_KERNEL);
 	if (!smu_table->gpu_metrics_table)
 		goto err1_out;
@@ -2627,10 +2627,11 @@ static ssize_t navi10_get_legacy_gpu_metrics(struct smu_context *smu,
 					     void **table)
 {
 	struct smu_table_context *smu_table = &smu->smu_table;
-	struct gpu_metrics_v1_1 *gpu_metrics =
-		(struct gpu_metrics_v1_1 *)smu_table->gpu_metrics_table;
+	struct gpu_metrics_v1_3 *gpu_metrics =
+		(struct gpu_metrics_v1_3 *)smu_table->gpu_metrics_table;
 	SmuMetrics_legacy_t metrics;
 	int ret = 0;
+	int freq = 0, dpm = 0;
 
 	mutex_lock(&smu->metrics_lock);
 
@@ -2646,7 +2647,7 @@ static ssize_t navi10_get_legacy_gpu_metrics(struct smu_context *smu,
 
 	mutex_unlock(&smu->metrics_lock);
 
-	smu_cmn_init_soft_gpu_metrics(gpu_metrics, 1, 1);
+	smu_cmn_init_soft_gpu_metrics(gpu_metrics, 1, 3);
 
 	gpu_metrics->temperature_edge = metrics.TemperatureEdge;
 	gpu_metrics->temperature_hotspot = metrics.TemperatureHotspot;
@@ -2681,19 +2682,119 @@ static ssize_t navi10_get_legacy_gpu_metrics(struct smu_context *smu,
 
 	gpu_metrics->system_clock_counter = ktime_get_boottime_ns();
 
+	gpu_metrics->voltage_gfx = (155000 - 625 * metrics.CurrGfxVoltageOffset) / 100;
+	gpu_metrics->voltage_mem = (155000 - 625 * metrics.CurrMemVidOffset) / 100;
+	gpu_metrics->voltage_soc = (155000 - 625 * metrics.CurrSocVoltageOffset) / 100;
+
+	gpu_metrics->max_socket_power = smu->power_limit;
+
+	/* Frequency and DPM ranges */
+
+	ret = smu_v11_0_get_dpm_freq_by_index(smu, SMU_GFXCLK, 0, &freq);
+	if (ret)
+		goto out;
+	gpu_metrics->min_gfxclk_frequency = freq;
+
+	ret = smu_v11_0_get_dpm_freq_by_index(smu, SMU_SOCCLK, 0, &freq);
+	if (ret)
+		goto out;
+	gpu_metrics->min_socclk_frequency = freq;
+
+	ret = smu_v11_0_get_dpm_freq_by_index(smu, SMU_UCLK, 0, &freq);
+	if (ret)
+		goto out;
+	gpu_metrics->min_uclk_frequency = freq;
+
+	ret = smu_v11_0_get_dpm_freq_by_index(smu, SMU_VCLK, 0, &freq);
+	if (ret)
+		goto out;
+	gpu_metrics->min_vclk0_frequency = freq;
+
+	ret = smu_v11_0_get_dpm_freq_by_index(smu, SMU_DCLK, 0, &freq);
+	if (ret)
+		goto out;
+	gpu_metrics->min_dclk0_frequency = freq;
+
+	ret = smu_v11_0_get_dpm_level_count(smu, SMU_GFXCLK, &dpm);
+	if (ret)
+		goto out;
+	gpu_metrics->max_gfxclk_dpm = dpm;
+
+	ret = smu_v11_0_get_dpm_freq_by_index(smu, SMU_GFXCLK,
+			gpu_metrics->max_gfxclk_dpm - 1, &freq);
+	if (ret)
+		goto out;
+
+	gpu_metrics->max_gfxclk_frequency = freq;
+
+	ret = smu_v11_0_get_dpm_level_count(smu, SMU_SOCCLK, &dpm);
+	if (ret)
+		goto out;
+
+	gpu_metrics->max_socclk_dpm = dpm;
+
+	ret = smu_v11_0_get_dpm_freq_by_index(smu, SMU_SOCCLK,
+			gpu_metrics->max_socclk_dpm - 1, &freq);
+	if (ret)
+		goto out;
+
+	gpu_metrics->max_socclk_frequency = freq;
+
+	ret = smu_v11_0_get_dpm_level_count(smu, SMU_UCLK, &dpm);
+	if (ret)
+		goto out;
+
+	gpu_metrics->max_uclk_dpm = dpm;
+
+	ret = smu_v11_0_get_dpm_freq_by_index(smu, SMU_UCLK,
+			gpu_metrics->max_uclk_dpm - 1, &freq);
+	if (ret)
+		goto out;
+
+	gpu_metrics->max_uclk_frequency = freq;
+
+	ret = smu_v11_0_get_dpm_level_count(smu, SMU_VCLK, &dpm);
+	if (ret)
+		goto out;
+
+	gpu_metrics->max_vclk0_dpm = dpm;
+
+	ret = smu_v11_0_get_dpm_freq_by_index(smu, SMU_VCLK,
+			gpu_metrics->max_vclk0_dpm - 1, &freq);
+	if (ret)
+		goto out;
+
+	gpu_metrics->max_vclk0_frequency = freq;
+
+	ret = smu_v11_0_get_dpm_level_count(smu, SMU_DCLK, &dpm);
+	if (ret)
+		goto out;
+
+	gpu_metrics->max_dclk0_dpm = dpm;
+
+	ret = smu_v11_0_get_dpm_freq_by_index(smu, SMU_DCLK,
+			gpu_metrics->max_dclk0_dpm - 1, &freq);
+	if (ret)
+		goto out;
+
+	gpu_metrics->max_dclk0_frequency = freq;
+
 	*table = (void *)gpu_metrics;
 
-	return sizeof(struct gpu_metrics_v1_1);
+	return sizeof(struct gpu_metrics_v1_3);
+out:
+	return ret;
 }
 
 static ssize_t navi10_get_gpu_metrics(struct smu_context *smu,
 				      void **table)
 {
 	struct smu_table_context *smu_table = &smu->smu_table;
-	struct gpu_metrics_v1_1 *gpu_metrics =
-		(struct gpu_metrics_v1_1 *)smu_table->gpu_metrics_table;
+	struct gpu_metrics_v1_3 *gpu_metrics =
+		(struct gpu_metrics_v1_3 *)smu_table->gpu_metrics_table;
 	SmuMetrics_t metrics;
 	int ret = 0;
+	int freq = 0, dpm = 0;
 
 	mutex_lock(&smu->metrics_lock);
 
@@ -2709,7 +2810,7 @@ static ssize_t navi10_get_gpu_metrics(struct smu_context *smu,
 
 	mutex_unlock(&smu->metrics_lock);
 
-	smu_cmn_init_soft_gpu_metrics(gpu_metrics, 1, 1);
+	smu_cmn_init_soft_gpu_metrics(gpu_metrics, 1, 3);
 
 	gpu_metrics->temperature_edge = metrics.TemperatureEdge;
 	gpu_metrics->temperature_hotspot = metrics.TemperatureHotspot;
@@ -2746,19 +2847,119 @@ static ssize_t navi10_get_gpu_metrics(struct smu_context *smu,
 
 	gpu_metrics->system_clock_counter = ktime_get_boottime_ns();
 
+	gpu_metrics->voltage_gfx = (155000 - 625 * metrics.CurrGfxVoltageOffset) / 100;
+	gpu_metrics->voltage_mem = (155000 - 625 * metrics.CurrMemVidOffset) / 100;
+	gpu_metrics->voltage_soc = (155000 - 625 * metrics.CurrSocVoltageOffset) / 100;
+
+	gpu_metrics->max_socket_power = smu->power_limit;
+
+	/* Frequency and DPM ranges */
+
+	ret = smu_v11_0_get_dpm_freq_by_index(smu, SMU_GFXCLK, 0, &freq);
+	if (ret)
+		goto out;
+	gpu_metrics->min_gfxclk_frequency = freq;
+
+	ret = smu_v11_0_get_dpm_freq_by_index(smu, SMU_SOCCLK, 0, &freq);
+	if (ret)
+		goto out;
+	gpu_metrics->min_socclk_frequency = freq;
+
+	ret = smu_v11_0_get_dpm_freq_by_index(smu, SMU_UCLK, 0, &freq);
+	if (ret)
+		goto out;
+	gpu_metrics->min_uclk_frequency = freq;
+
+	ret = smu_v11_0_get_dpm_freq_by_index(smu, SMU_VCLK, 0, &freq);
+	if (ret)
+		goto out;
+	gpu_metrics->min_vclk0_frequency = freq;
+
+	ret = smu_v11_0_get_dpm_freq_by_index(smu, SMU_DCLK, 0, &freq);
+	if (ret)
+		goto out;
+	gpu_metrics->min_dclk0_frequency = freq;
+
+	ret = smu_v11_0_get_dpm_level_count(smu, SMU_GFXCLK, &dpm);
+	if (ret)
+		goto out;
+	gpu_metrics->max_gfxclk_dpm = dpm;
+
+	ret = smu_v11_0_get_dpm_freq_by_index(smu, SMU_GFXCLK,
+			gpu_metrics->max_gfxclk_dpm - 1, &freq);
+	if (ret)
+		goto out;
+
+	gpu_metrics->max_gfxclk_frequency = freq;
+
+	ret = smu_v11_0_get_dpm_level_count(smu, SMU_SOCCLK, &dpm);
+	if (ret)
+		goto out;
+
+	gpu_metrics->max_socclk_dpm = dpm;
+
+	ret = smu_v11_0_get_dpm_freq_by_index(smu, SMU_SOCCLK,
+			gpu_metrics->max_socclk_dpm - 1, &freq);
+	if (ret)
+		goto out;
+
+	gpu_metrics->max_socclk_frequency = freq;
+
+	ret = smu_v11_0_get_dpm_level_count(smu, SMU_UCLK, &dpm);
+	if (ret)
+		goto out;
+
+	gpu_metrics->max_uclk_dpm = dpm;
+
+	ret = smu_v11_0_get_dpm_freq_by_index(smu, SMU_UCLK,
+			gpu_metrics->max_uclk_dpm - 1, &freq);
+	if (ret)
+		goto out;
+
+	gpu_metrics->max_uclk_frequency = freq;
+
+	ret = smu_v11_0_get_dpm_level_count(smu, SMU_VCLK, &dpm);
+	if (ret)
+		goto out;
+
+	gpu_metrics->max_vclk0_dpm = dpm;
+
+	ret = smu_v11_0_get_dpm_freq_by_index(smu, SMU_VCLK,
+			gpu_metrics->max_vclk0_dpm - 1, &freq);
+	if (ret)
+		goto out;
+
+	gpu_metrics->max_vclk0_frequency = freq;
+
+	ret = smu_v11_0_get_dpm_level_count(smu, SMU_DCLK, &dpm);
+	if (ret)
+		goto out;
+
+	gpu_metrics->max_dclk0_dpm = dpm;
+
+	ret = smu_v11_0_get_dpm_freq_by_index(smu, SMU_DCLK,
+			gpu_metrics->max_dclk0_dpm - 1, &freq);
+	if (ret)
+		goto out;
+
+	gpu_metrics->max_dclk0_frequency = freq;
+
 	*table = (void *)gpu_metrics;
 
-	return sizeof(struct gpu_metrics_v1_1);
+	return sizeof(struct gpu_metrics_v1_3);
+out:
+	return ret;
 }
 
 static ssize_t navi12_get_legacy_gpu_metrics(struct smu_context *smu,
 					     void **table)
 {
 	struct smu_table_context *smu_table = &smu->smu_table;
-	struct gpu_metrics_v1_1 *gpu_metrics =
-		(struct gpu_metrics_v1_1 *)smu_table->gpu_metrics_table;
+	struct gpu_metrics_v1_3 *gpu_metrics =
+		(struct gpu_metrics_v1_3 *)smu_table->gpu_metrics_table;
 	SmuMetrics_NV12_legacy_t metrics;
 	int ret = 0;
+	int freq = 0, dpm = 0;
 
 	mutex_lock(&smu->metrics_lock);
 
@@ -2774,7 +2975,7 @@ static ssize_t navi12_get_legacy_gpu_metrics(struct smu_context *smu,
 
 	mutex_unlock(&smu->metrics_lock);
 
-	smu_cmn_init_soft_gpu_metrics(gpu_metrics, 1, 1);
+	smu_cmn_init_soft_gpu_metrics(gpu_metrics, 1, 3);
 
 	gpu_metrics->temperature_edge = metrics.TemperatureEdge;
 	gpu_metrics->temperature_hotspot = metrics.TemperatureHotspot;
@@ -2814,19 +3015,119 @@ static ssize_t navi12_get_legacy_gpu_metrics(struct smu_context *smu,
 
 	gpu_metrics->system_clock_counter = ktime_get_boottime_ns();
 
+	gpu_metrics->voltage_gfx = (155000 - 625 * metrics.CurrGfxVoltageOffset) / 100;
+	gpu_metrics->voltage_mem = (155000 - 625 * metrics.CurrMemVidOffset) / 100;
+	gpu_metrics->voltage_soc = (155000 - 625 * metrics.CurrSocVoltageOffset) / 100;
+
+	gpu_metrics->max_socket_power = smu->power_limit;
+
+	/* Frequency and DPM ranges */
+
+	ret = smu_v11_0_get_dpm_freq_by_index(smu, SMU_GFXCLK, 0, &freq);
+	if (ret)
+		goto out;
+	gpu_metrics->min_gfxclk_frequency = freq;
+
+	ret = smu_v11_0_get_dpm_freq_by_index(smu, SMU_SOCCLK, 0, &freq);
+	if (ret)
+		goto out;
+	gpu_metrics->min_socclk_frequency = freq;
+
+	ret = smu_v11_0_get_dpm_freq_by_index(smu, SMU_UCLK, 0, &freq);
+	if (ret)
+		goto out;
+	gpu_metrics->min_uclk_frequency = freq;
+
+	ret = smu_v11_0_get_dpm_freq_by_index(smu, SMU_VCLK, 0, &freq);
+	if (ret)
+		goto out;
+	gpu_metrics->min_vclk0_frequency = freq;
+
+	ret = smu_v11_0_get_dpm_freq_by_index(smu, SMU_DCLK, 0, &freq);
+	if (ret)
+		goto out;
+	gpu_metrics->min_dclk0_frequency = freq;
+
+	ret = smu_v11_0_get_dpm_level_count(smu, SMU_GFXCLK, &dpm);
+	if (ret)
+		goto out;
+	gpu_metrics->max_gfxclk_dpm = dpm;
+
+	ret = smu_v11_0_get_dpm_freq_by_index(smu, SMU_GFXCLK,
+			gpu_metrics->max_gfxclk_dpm - 1, &freq);
+	if (ret)
+		goto out;
+
+	gpu_metrics->max_gfxclk_frequency = freq;
+
+	ret = smu_v11_0_get_dpm_level_count(smu, SMU_SOCCLK, &dpm);
+	if (ret)
+		goto out;
+
+	gpu_metrics->max_socclk_dpm = dpm;
+
+	ret = smu_v11_0_get_dpm_freq_by_index(smu, SMU_SOCCLK,
+			gpu_metrics->max_socclk_dpm - 1, &freq);
+	if (ret)
+		goto out;
+
+	gpu_metrics->max_socclk_frequency = freq;
+
+	ret = smu_v11_0_get_dpm_level_count(smu, SMU_UCLK, &dpm);
+	if (ret)
+		goto out;
+
+	gpu_metrics->max_uclk_dpm = dpm;
+
+	ret = smu_v11_0_get_dpm_freq_by_index(smu, SMU_UCLK,
+			gpu_metrics->max_uclk_dpm - 1, &freq);
+	if (ret)
+		goto out;
+
+	gpu_metrics->max_uclk_frequency = freq;
+
+	ret = smu_v11_0_get_dpm_level_count(smu, SMU_VCLK, &dpm);
+	if (ret)
+		goto out;
+
+	gpu_metrics->max_vclk0_dpm = dpm;
+
+	ret = smu_v11_0_get_dpm_freq_by_index(smu, SMU_VCLK,
+			gpu_metrics->max_vclk0_dpm - 1, &freq);
+	if (ret)
+		goto out;
+
+	gpu_metrics->max_vclk0_frequency = freq;
+
+	ret = smu_v11_0_get_dpm_level_count(smu, SMU_DCLK, &dpm);
+	if (ret)
+		goto out;
+
+	gpu_metrics->max_dclk0_dpm = dpm;
+
+	ret = smu_v11_0_get_dpm_freq_by_index(smu, SMU_DCLK,
+			gpu_metrics->max_dclk0_dpm - 1, &freq);
+	if (ret)
+		goto out;
+
+	gpu_metrics->max_dclk0_frequency = freq;
+
 	*table = (void *)gpu_metrics;
 
-	return sizeof(struct gpu_metrics_v1_1);
+	return sizeof(struct gpu_metrics_v1_3);
+out:
+	return ret;
 }
 
 static ssize_t navi12_get_gpu_metrics(struct smu_context *smu,
 				      void **table)
 {
 	struct smu_table_context *smu_table = &smu->smu_table;
-	struct gpu_metrics_v1_1 *gpu_metrics =
-		(struct gpu_metrics_v1_1 *)smu_table->gpu_metrics_table;
+	struct gpu_metrics_v1_3 *gpu_metrics =
+		(struct gpu_metrics_v1_3 *)smu_table->gpu_metrics_table;
 	SmuMetrics_NV12_t metrics;
 	int ret = 0;
+	int freq = 0, dpm = 0;
 
 	mutex_lock(&smu->metrics_lock);
 
@@ -2842,7 +3143,7 @@ static ssize_t navi12_get_gpu_metrics(struct smu_context *smu,
 
 	mutex_unlock(&smu->metrics_lock);
 
-	smu_cmn_init_soft_gpu_metrics(gpu_metrics, 1, 1);
+	smu_cmn_init_soft_gpu_metrics(gpu_metrics, 1, 3);
 
 	gpu_metrics->temperature_edge = metrics.TemperatureEdge;
 	gpu_metrics->temperature_hotspot = metrics.TemperatureHotspot;
@@ -2884,9 +3185,108 @@ static ssize_t navi12_get_gpu_metrics(struct smu_context *smu,
 
 	gpu_metrics->system_clock_counter = ktime_get_boottime_ns();
 
+	gpu_metrics->voltage_gfx = (155000 - 625 * metrics.CurrGfxVoltageOffset) / 100;
+	gpu_metrics->voltage_mem = (155000 - 625 * metrics.CurrMemVidOffset) / 100;
+	gpu_metrics->voltage_soc = (155000 - 625 * metrics.CurrSocVoltageOffset) / 100;
+
+	gpu_metrics->max_socket_power = smu->power_limit;
+
+	/* Frequency and DPM ranges */
+
+	ret = smu_v11_0_get_dpm_freq_by_index(smu, SMU_GFXCLK, 0, &freq);
+	if (ret)
+		goto out;
+	gpu_metrics->min_gfxclk_frequency = freq;
+
+	ret = smu_v11_0_get_dpm_freq_by_index(smu, SMU_SOCCLK, 0, &freq);
+	if (ret)
+		goto out;
+	gpu_metrics->min_socclk_frequency = freq;
+
+	ret = smu_v11_0_get_dpm_freq_by_index(smu, SMU_UCLK, 0, &freq);
+	if (ret)
+		goto out;
+	gpu_metrics->min_uclk_frequency = freq;
+
+	ret = smu_v11_0_get_dpm_freq_by_index(smu, SMU_VCLK, 0, &freq);
+	if (ret)
+		goto out;
+	gpu_metrics->min_vclk0_frequency = freq;
+
+	ret = smu_v11_0_get_dpm_freq_by_index(smu, SMU_DCLK, 0, &freq);
+	if (ret)
+		goto out;
+	gpu_metrics->min_dclk0_frequency = freq;
+
+	ret = smu_v11_0_get_dpm_level_count(smu, SMU_GFXCLK, &dpm);
+	if (ret)
+		goto out;
+	gpu_metrics->max_gfxclk_dpm = dpm;
+
+	ret = smu_v11_0_get_dpm_freq_by_index(smu, SMU_GFXCLK,
+			gpu_metrics->max_gfxclk_dpm - 1, &freq);
+	if (ret)
+		goto out;
+
+	gpu_metrics->max_gfxclk_frequency = freq;
+
+	ret = smu_v11_0_get_dpm_level_count(smu, SMU_SOCCLK, &dpm);
+	if (ret)
+		goto out;
+
+	gpu_metrics->max_socclk_dpm = dpm;
+
+	ret = smu_v11_0_get_dpm_freq_by_index(smu, SMU_SOCCLK,
+			gpu_metrics->max_socclk_dpm - 1, &freq);
+	if (ret)
+		goto out;
+
+	gpu_metrics->max_socclk_frequency = freq;
+
+	ret = smu_v11_0_get_dpm_level_count(smu, SMU_UCLK, &dpm);
+	if (ret)
+		goto out;
+
+	gpu_metrics->max_uclk_dpm = dpm;
+
+	ret = smu_v11_0_get_dpm_freq_by_index(smu, SMU_UCLK,
+			gpu_metrics->max_uclk_dpm - 1, &freq);
+	if (ret)
+		goto out;
+
+	gpu_metrics->max_uclk_frequency = freq;
+
+	ret = smu_v11_0_get_dpm_level_count(smu, SMU_VCLK, &dpm);
+	if (ret)
+		goto out;
+
+	gpu_metrics->max_vclk0_dpm = dpm;
+
+	ret = smu_v11_0_get_dpm_freq_by_index(smu, SMU_VCLK,
+			gpu_metrics->max_vclk0_dpm - 1, &freq);
+	if (ret)
+		goto out;
+
+	gpu_metrics->max_vclk0_frequency = freq;
+
+	ret = smu_v11_0_get_dpm_level_count(smu, SMU_DCLK, &dpm);
+	if (ret)
+		goto out;
+
+	gpu_metrics->max_dclk0_dpm = dpm;
+
+	ret = smu_v11_0_get_dpm_freq_by_index(smu, SMU_DCLK,
+			gpu_metrics->max_dclk0_dpm - 1, &freq);
+	if (ret)
+		goto out;
+
+	gpu_metrics->max_dclk0_frequency = freq;
+
 	*table = (void *)gpu_metrics;
 
-	return sizeof(struct gpu_metrics_v1_1);
+	return sizeof(struct gpu_metrics_v1_3);
+out:
+	return ret;
 }
 
 static ssize_t navi1x_get_gpu_metrics(struct smu_context *smu,
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
