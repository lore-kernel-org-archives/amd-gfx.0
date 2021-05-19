Return-Path: <SRS0=RLY9=KO=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19D1AC433ED
	for <amd-gfx@archiver.kernel.org>; Wed, 19 May 2021 06:03:14 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CDA9261364
	for <amd-gfx@archiver.kernel.org>; Wed, 19 May 2021 06:03:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CDA9261364
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 330676E202;
	Wed, 19 May 2021 06:03:12 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2070.outbound.protection.outlook.com [40.107.94.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A3AB36E219
 for <amd-gfx@lists.freedesktop.org>; Wed, 19 May 2021 06:03:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L75g/ZpysDrWiLX64fK/wKJ0LlmYZo37bRRKOEXmZKGhhyUJhVG3werlhkznFcjrbO+mqElmOyvAZ6ujwHmJB4p7o0WGhTxOIug3mUnjs2Tl001DU5M7Xym0OYRZl3xE4dJl4WN998ZIth2HA30H/2xeTon1pRGYZUSlvxlQK2Dpx6pr6Wdz2tkO61DN0341OoWhoHb/K8k9vx9cJV0QThb2zGaL3ty0K2RoBu9XzAUK2W2RDAcMGUJa9dXity8FR8jrkDdNJ0TaSltj/lSiiGjl2UHUrnx2Q0ZfeXe1tfaMutFfNsDeSHkpOfbSKwCphV3/bdbMY6U0V1SLld6IfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pBb6Bz1mFZEdh9nhoBvIBsZJ7IVuZDHa+jUaZYSmCp4=;
 b=kl0yLLMOBncwrTe97qrdSz8ItJU/XjNihBG3/cf0Hlz9Rf4la3J0NrRRf6A/bI9/KeqTz0QEcHbDW+O/fv28BUbFo5AOIg9m1zNuaHW2tU6n+K5QaZE1ULDSHMaILB0x1oVQuOcSF4O3S5gfp7JgUd0ouInDPVYL4VyUaKk3uDMfdH+KdAw1+s+ZiSr4ORJriJJ5VKa3nL3EWDlHT+EXMS1A6cCONSXQTYtMCSNqNql+L/K0CTkcXFgGBW5BOw7lCozgyehzdKAfS2wv35MSyEc0mzy+5mnLQt1lMZRa+OSVIQXruNv+YexRjhHj7FjxAMW2spig/sEjaBOc4kQshA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pBb6Bz1mFZEdh9nhoBvIBsZJ7IVuZDHa+jUaZYSmCp4=;
 b=195qWFuVLjTGYn6Ihcl0iygU5cLcrelxVxlMm/5XBwjw6RhiXqptF16cqSJ5PXNqSkWRdK0wf45WP0M8Q5metVPGMc+bIXvbtb5AjYmV3+JhCcwKFZ+S4qdUJoHbZd9cW9bXfxbpAtdzk5/LGD2vfaUR/BgOFAkOp3SS4FCuOF4=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB2840.namprd12.prod.outlook.com (2603:10b6:a03:62::32)
 by BYAPR12MB3287.namprd12.prod.outlook.com (2603:10b6:a03:131::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.25; Wed, 19 May
 2021 06:03:09 +0000
Received: from BYAPR12MB2840.namprd12.prod.outlook.com
 ([fe80::7c65:7181:6d1d:8616]) by BYAPR12MB2840.namprd12.prod.outlook.com
 ([fe80::7c65:7181:6d1d:8616%7]) with mapi id 15.20.4129.031; Wed, 19 May 2021
 06:03:09 +0000
From: David M Nieto <david.nieto@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 2/3] drm/amdgpu/pm: add new fields for Navi1x
Date: Tue, 18 May 2021 23:02:32 -0700
Message-Id: <20210519060233.13597-2-david.nieto@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210519060233.13597-1-david.nieto@amd.com>
References: <476f8809-5521-98b4-e08f-1d06fc099468@amd.com>
 <20210519060233.13597-1-david.nieto@amd.com>
X-Originating-IP: [165.204.53.123]
X-ClientProxiedBy: SJ0PR13CA0130.namprd13.prod.outlook.com
 (2603:10b6:a03:2c6::15) To BYAPR12MB2840.namprd12.prod.outlook.com
 (2603:10b6:a03:62::32)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from loud-cracker.amd.com (165.204.53.123) by
 SJ0PR13CA0130.namprd13.prod.outlook.com (2603:10b6:a03:2c6::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4150.11 via Frontend
 Transport; Wed, 19 May 2021 06:03:08 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bfa9c832-f8e1-4863-2d69-08d91a8bc6b2
X-MS-TrafficTypeDiagnostic: BYAPR12MB3287:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR12MB32873CBEF73F5B5449E04A26F42B9@BYAPR12MB3287.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1060;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UraUTThD787SQejFdTukFBEjBmoTt1Rnp44lnqLraGCSGX9QFZzaZf2kQow4Ovx+JhUhSmWIlCpKZWzyrgfO7JNKaRqqgxFqOOSt4ndT+rjNHkipruWGLgn4UEXsCJDHN+Q5BUnktnt7e/dgmdNwM3tGVAaSeON2wslTJN7HoCxnaHWSEoqibYuNkOxmgScUjvIg5pGtROojlS8wT7bZcc2GedwI9XXWR3SihsTaK+5HhF+wxIKGOFtjLzQ8RxP5h4SFcehF2wt6d3gfqQtwjh0g1dcbY/zCDWvMATPf+nx1t3toGo6QaXFkuTWrlTNxavCHhaAzipfkbre+quKAQYoL4aHSgQEFxcENOuEExhGLQ4rHYNvSENH2cgOaEgpgBY5x0j8CKl7PpuJVZPcF9DtjGaSEvp133TPBi3sc1pQLsCP11rGVT4HdlX/ZaD7Eg54PsvGtTU47jJZT73XwuA9iaHoCWR7CTM6ZAD7e/Cf7kBB++iyMS2EbXLS/lWMPGpayqcKwzc6we8U8IPuTV8njxa3eeQz4+XPBaUUXOu3G8SWzha/r2+RE/PFc+Molab8Y1Fcz1bYGDP+tFxRDRXkRSbMWVtp07AK7xmbc2pofLcgvDbtw1PkmLCLvX8NPIIrVxwD0Oja9huGKxAVMclQ6LqNwzVlKBIu4E8QPovji8mGVv2p2k5r+fti8PAe5
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB2840.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(136003)(366004)(39860400002)(346002)(376002)(5660300002)(38100700002)(66476007)(38350700002)(316002)(66556008)(6486002)(8676002)(66946007)(8936002)(6916009)(2906002)(7696005)(52116002)(19627235002)(956004)(2616005)(26005)(83380400001)(86362001)(478600001)(36756003)(1076003)(186003)(4326008)(6666004)(16526019)(32563001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?Dp5Q9ncXsEXa+rIV3N6gqn4WqPl7MGj88CaYbg33Wl5fO95PXk3A29015NN0?=
 =?us-ascii?Q?YM7TYjTeNkU17PdharYKPKxKb8JJ410YPrcjK8pBn26sIaw4rdCkvZxQlGJa?=
 =?us-ascii?Q?TOvsEsV4VcZubpzICsvVbUGNsOi67XS3vvg5bPw4F/lCrBxJ38bktSqc7e+C?=
 =?us-ascii?Q?xkDub64sT5gqfXgp7vF7IERinTptJGGHN+HnaRs4fxJRq2+RONulzw32n2E7?=
 =?us-ascii?Q?2H7zVXWt5K7MBK8GuMncjOMiaxl4us1hJnWNreLN2OjFHLdxY3hAy4lLLffT?=
 =?us-ascii?Q?pRswjmHONi3FjStaCf17eIABQ8zX+rmuFHU2J/cLRPZQQuzQ8y96Po9Kue8c?=
 =?us-ascii?Q?Flf9X2pnxlHGQ+6tfwdQqE2yfmoqhqHQDGGCEYweaMaM6v78Szz0NBdfYeiy?=
 =?us-ascii?Q?wE99IRuVYN8wkhEkbOJl4qqc0eSoy6WbNtOUCCNBiZce7gn8DoQPG/hscrJG?=
 =?us-ascii?Q?vpS9vIveH73x0JpzWbOKMeDl11wlKZO8HD/qcTUfvOzjs4xKyNjOtO/IIxVL?=
 =?us-ascii?Q?j4r+p4qcRwfVH+5Fmt7e8jjbzQf4WRMAeAHqvYo0S9QOOH1zllsMun+HHIjo?=
 =?us-ascii?Q?Yw4HmDtzbKFlH3PGP86l8HgUW0umyIhMiF7KvNWD3dAidDeViIdq3EAnyFRF?=
 =?us-ascii?Q?JoM6ffpnqNamaEidti3EnXtd8nAXxixv2JM69eQHiZ2466tFVpjaUYqRyaKa?=
 =?us-ascii?Q?MKRiFldmeMhrsjo6Nutp5KisscqvewlnSNeE3oKEoKyffWUi5cIsXQXO5jvl?=
 =?us-ascii?Q?92TFNFpW3FK4SfshC4nkiIUwrEkVWpNnjCJPr87iYecVipSfszDkYZZKj9at?=
 =?us-ascii?Q?FsaiMdBlTexA9hgIFIbUgN3WTqlSyDX/uH1fnrHxj7QN5PRCzxYB/u9XSARN?=
 =?us-ascii?Q?C1EW5831Txv1KQG2ZBRTgKHnGaXmUHSFVxoPa17A/Ut680XlS/8/KASO/1JR?=
 =?us-ascii?Q?OwoVdgnkZcbOS/6I/uzAkX3BHnEOHUIZIQjAY0x+wfxhfjj2GEsA2rQcLO9l?=
 =?us-ascii?Q?QInalePpjLRVMDetFA/DBvA3NTcjEOODIJbtt2CaT7EeFjZuyWzm2aiQBv1T?=
 =?us-ascii?Q?4ygz6+QSHoxbhh/Jlehwc8Q2/PGibONajl2CARAku5qslkzNqxUzxMstUX3u?=
 =?us-ascii?Q?9TeYYEKOy356fy7JO7nLtbS4HFxVxGSX62wQgCiGVb1Y0tc1EERBhEJod/hm?=
 =?us-ascii?Q?Y76covZWMbBenCmQTl4XDkjxXU1uv7/dfSNwyYzXpHsy65ZZr0zTnUAQzWFF?=
 =?us-ascii?Q?s/VWStAmVZNvzslg55Sk65ScoS4UtVA+giy1Sb4jSZzVxRYqD8dBnsjKECxh?=
 =?us-ascii?Q?p8AzCGzNPHOCVKcpH2KqDsDk?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bfa9c832-f8e1-4863-2d69-08d91a8bc6b2
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB2840.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2021 06:03:08.7846 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AB73zRlebsw/6mTBwsun2/A3el0JAvotaNOCMsSbej5R1VeHzhVWSfX5UTsoLyCi
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3287
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

Fill voltage fields in metrics table

Signed-off-by: David M Nieto <david.nieto@amd.com>
---
 .../gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c   | 58 +++++++++++++------
 1 file changed, 41 insertions(+), 17 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
index ac13042672ea..b8971303a873 100644
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
@@ -2627,8 +2627,8 @@ static ssize_t navi10_get_legacy_gpu_metrics(struct smu_context *smu,
 					     void **table)
 {
 	struct smu_table_context *smu_table = &smu->smu_table;
-	struct gpu_metrics_v1_1 *gpu_metrics =
-		(struct gpu_metrics_v1_1 *)smu_table->gpu_metrics_table;
+	struct gpu_metrics_v1_3 *gpu_metrics =
+		(struct gpu_metrics_v1_3 *)smu_table->gpu_metrics_table;
 	SmuMetrics_legacy_t metrics;
 	int ret = 0;
 
@@ -2646,7 +2646,7 @@ static ssize_t navi10_get_legacy_gpu_metrics(struct smu_context *smu,
 
 	mutex_unlock(&smu->metrics_lock);
 
-	smu_cmn_init_soft_gpu_metrics(gpu_metrics, 1, 1);
+	smu_cmn_init_soft_gpu_metrics(gpu_metrics, 1, 3);
 
 	gpu_metrics->temperature_edge = metrics.TemperatureEdge;
 	gpu_metrics->temperature_hotspot = metrics.TemperatureHotspot;
@@ -2681,17 +2681,23 @@ static ssize_t navi10_get_legacy_gpu_metrics(struct smu_context *smu,
 
 	gpu_metrics->system_clock_counter = ktime_get_boottime_ns();
 
+	gpu_metrics->voltage_gfx = (155000 - 625 * metrics.CurrGfxVoltageOffset) / 100;
+	gpu_metrics->voltage_mem = (155000 - 625 * metrics.CurrMemVidOffset) / 100;
+	gpu_metrics->voltage_soc = (155000 - 625 * metrics.CurrSocVoltageOffset) / 100;
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
 
@@ -2709,7 +2715,7 @@ static ssize_t navi10_get_gpu_metrics(struct smu_context *smu,
 
 	mutex_unlock(&smu->metrics_lock);
 
-	smu_cmn_init_soft_gpu_metrics(gpu_metrics, 1, 1);
+	smu_cmn_init_soft_gpu_metrics(gpu_metrics, 1, 3);
 
 	gpu_metrics->temperature_edge = metrics.TemperatureEdge;
 	gpu_metrics->temperature_hotspot = metrics.TemperatureHotspot;
@@ -2746,17 +2752,23 @@ static ssize_t navi10_get_gpu_metrics(struct smu_context *smu,
 
 	gpu_metrics->system_clock_counter = ktime_get_boottime_ns();
 
+	gpu_metrics->voltage_gfx = (155000 - 625 * metrics.CurrGfxVoltageOffset) / 100;
+	gpu_metrics->voltage_mem = (155000 - 625 * metrics.CurrMemVidOffset) / 100;
+	gpu_metrics->voltage_soc = (155000 - 625 * metrics.CurrSocVoltageOffset) / 100;
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
 
@@ -2774,7 +2786,7 @@ static ssize_t navi12_get_legacy_gpu_metrics(struct smu_context *smu,
 
 	mutex_unlock(&smu->metrics_lock);
 
-	smu_cmn_init_soft_gpu_metrics(gpu_metrics, 1, 1);
+	smu_cmn_init_soft_gpu_metrics(gpu_metrics, 1, 3);
 
 	gpu_metrics->temperature_edge = metrics.TemperatureEdge;
 	gpu_metrics->temperature_hotspot = metrics.TemperatureHotspot;
@@ -2814,17 +2826,23 @@ static ssize_t navi12_get_legacy_gpu_metrics(struct smu_context *smu,
 
 	gpu_metrics->system_clock_counter = ktime_get_boottime_ns();
 
+	gpu_metrics->voltage_gfx = (155000 - 625 * metrics.CurrGfxVoltageOffset) / 100;
+	gpu_metrics->voltage_mem = (155000 - 625 * metrics.CurrMemVidOffset) / 100;
+	gpu_metrics->voltage_soc = (155000 - 625 * metrics.CurrSocVoltageOffset) / 100;
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
 
@@ -2842,7 +2860,7 @@ static ssize_t navi12_get_gpu_metrics(struct smu_context *smu,
 
 	mutex_unlock(&smu->metrics_lock);
 
-	smu_cmn_init_soft_gpu_metrics(gpu_metrics, 1, 1);
+	smu_cmn_init_soft_gpu_metrics(gpu_metrics, 1, 3);
 
 	gpu_metrics->temperature_edge = metrics.TemperatureEdge;
 	gpu_metrics->temperature_hotspot = metrics.TemperatureHotspot;
@@ -2884,9 +2902,15 @@ static ssize_t navi12_get_gpu_metrics(struct smu_context *smu,
 
 	gpu_metrics->system_clock_counter = ktime_get_boottime_ns();
 
+	gpu_metrics->voltage_gfx = (155000 - 625 * metrics.CurrGfxVoltageOffset) / 100;
+	gpu_metrics->voltage_mem = (155000 - 625 * metrics.CurrMemVidOffset) / 100;
+	gpu_metrics->voltage_soc = (155000 - 625 * metrics.CurrSocVoltageOffset) / 100;
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
