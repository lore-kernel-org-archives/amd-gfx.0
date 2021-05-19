Return-Path: <SRS0=RLY9=KO=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42DFCC433ED
	for <amd-gfx@archiver.kernel.org>; Wed, 19 May 2021 17:39:25 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D6F6B610A2
	for <amd-gfx@archiver.kernel.org>; Wed, 19 May 2021 17:39:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D6F6B610A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ED6BF6EAC2;
	Wed, 19 May 2021 17:39:22 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1anam02on2056.outbound.protection.outlook.com [40.107.96.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5ED396E0CB
 for <amd-gfx@lists.freedesktop.org>; Wed, 19 May 2021 17:39:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Xw0vq4sNhl0T96XWUNOFJaZaVq9yYplZVYtH+U4bxPtBE+PzG13k0jxf41qSWouu3jeSYdQZQdzXKp4oy/jGiuDRDoIJkR18ULYk2klDBTyHfM2Cq/CRf6vPdHXMZjr4rUPXVWl0NmsmWCowJz+/fqA2mx6ZFYc5+df5OQVLYQ6UMbhk/bcyHQjyHctfr63O+tchxagPT3WSb4lF2O0Qrb3yPO6hVmXqowF4kdLBwBRQQKXY9BKLd0aJeMmv7ORIOi1JEhjsgP6oC2buHCY8aDP34+Ug/akjMvHrIXSTko7HWs08DYll6Y5Cn8CUB35/hu2QHYBVs3H2k0x9385AhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B8x+hF8mKGlYxMrBthNuDYH8flm0QhQOjIKUIFOpIbw=;
 b=TCtOvz+0vF9fi16oZACf23hPy9b/Ba91qRgycK+rPSKx0C8DiVG1JNG3tHDKjI8rsJLx8IfmR7J9RAOCJA/4IyMofHVpd7mj+1V0nUncDaHwh+kIThnSltePAW+xkDQCz36yd1GRBzJ3GSVNwvKeyyMveTXb1OsOlipTbQIeTotiEQzVD5J6ETqNiO+2xG8uR3ACYdGOe8ijXpJhnjP4ZqwpuUfaWMNZW8c/Y0JNm12r48e0COmYrGnhl1PazPM0L7aOv+EmvpPjiRa0WTNDJaMITOCbtowwPMQx/VkRIEwnzgMNAOnXWBtLzOGrV39+FVcLKStKBLcfefiTQbe8tQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B8x+hF8mKGlYxMrBthNuDYH8flm0QhQOjIKUIFOpIbw=;
 b=dS9Jkuib/XbryaMAWiQd6l4P9//WMZ+KIWwgnY4mg0f9OD+allSipHyRLd3ol6BgwvrKn5lRVfFg1+97W2LedGseE3AQGmGWyRlXxy3svIIceSwLPuQZovHK5PENWd7RZRT44OQwNaMCG4OUH7T27Pvn3RuaobQj2qQwmncjWZg=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB2840.namprd12.prod.outlook.com (2603:10b6:a03:62::32)
 by BYAPR12MB3063.namprd12.prod.outlook.com (2603:10b6:a03:d6::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.28; Wed, 19 May
 2021 17:39:17 +0000
Received: from BYAPR12MB2840.namprd12.prod.outlook.com
 ([fe80::7c65:7181:6d1d:8616]) by BYAPR12MB2840.namprd12.prod.outlook.com
 ([fe80::7c65:7181:6d1d:8616%7]) with mapi id 15.20.4129.031; Wed, 19 May 2021
 17:39:17 +0000
From: David M Nieto <david.nieto@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 2/3] drm/amdgpu/pm: add new fields for Navi1x (v3)
Date: Wed, 19 May 2021 10:39:05 -0700
Message-Id: <20210519173906.32504-2-david.nieto@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210519173906.32504-1-david.nieto@amd.com>
References: <476f8809-5521-98b4-e08f-1d06fc099468@amd.com>
 <20210519173906.32504-1-david.nieto@amd.com>
X-Originating-IP: [165.204.53.123]
X-ClientProxiedBy: SJ0PR13CA0087.namprd13.prod.outlook.com
 (2603:10b6:a03:2c4::32) To BYAPR12MB2840.namprd12.prod.outlook.com
 (2603:10b6:a03:62::32)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from loud-cracker.amd.com (165.204.53.123) by
 SJ0PR13CA0087.namprd13.prod.outlook.com (2603:10b6:a03:2c4::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.11 via Frontend
 Transport; Wed, 19 May 2021 17:39:16 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b138bf0e-655b-4642-e58b-08d91aed0660
X-MS-TrafficTypeDiagnostic: BYAPR12MB3063:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR12MB3063621CF0F46BB51FAB60C7F42B9@BYAPR12MB3063.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3044;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LvFjKXRxH/Ws7RKfiOruypDksfHocmUuK5L/KAKqXd0ogRlfz+fGBF4oSKPHQwfTDUF8O8OuOgzmuv66V08wR5gQ+86LXb15EI9H20wnIlmBDwj1ACgm0sOUSB+TW8Y36yHA8bqM+vOkCsahIA1a13SfvPHERjsHarDT++P8AjE8bNYcNSAAVaDxDad72sugUZjRA4M4JBkNbgEDuSZ8FrO9vX2JDm330fRuH9rLCgg2zK26MW3m78lwvSKts5Z+FCnMvOPCQo0FVvV8f5aqwSF5diuDE76HUbR+VTYoORJe1d3mzyRKk1fr7IdFBiAGovntzYvIBe6Ga2EOmq+GyXSF29w4Jdp6uzZqd3rgverLRVJq8h29Xs2em8E1LZ8lceT2gAbmArHawcmA0bmx7D87JpibaohOhqz2a4X7aDjGyUBIoHY6kYI3jgzSyVJ1uCk6C5lkHe+QA08x9M0oVGP2h0+8xeSd5aCji2Ju0rQGKagN86MbR9INZxYW4cCmby4ZZTxHSzvSC/s3lx4EsUPsDyg7VZrWkAqmYKVmqaDcV2VOX3ISsR76GQ/+vRLe3gxdFqBKgTugeGYzNuatNBpWd52sfEpa4V+W2MBCf13Qci8MGdDkh4Hl0LimWJUTZgYgPmUzEkV8keSZtmBiC+lrboQBP5vwdBB190aqDxQo+GBzhejEiXcgxOkWL0xS
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB2840.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(346002)(39860400002)(366004)(376002)(396003)(4326008)(478600001)(8936002)(1076003)(8676002)(316002)(6916009)(6486002)(66946007)(5660300002)(86362001)(7696005)(26005)(186003)(2616005)(16526019)(52116002)(66556008)(66476007)(2906002)(38350700002)(36756003)(38100700002)(83380400001)(956004)(6666004)(19627235002)(32563001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?RloZo03hGhj1AZPXTGikX0fcT7we/9nfp2Xo1wD1PwolfaGDkPE08oYSeah1?=
 =?us-ascii?Q?w8hDtld5ZLCnS/lJvqPwkVkT6zN7Klp2gqQOiimBlETkcqy3ap8Ma4d4Am58?=
 =?us-ascii?Q?i3wGwGxYrkqcKaXZNcXclexQrkq2Zs2YU7xJM6Qzju7VTu8uVuNc8dJuqPv0?=
 =?us-ascii?Q?bUYPeS/gv7ObowxGOQKMa1eGDp2wsujgs/Qd29aq01l0nnwXARdPJI3fwAL2?=
 =?us-ascii?Q?sM8LxZFOx3LsC+V6QnNq3Vc9oQyVHBnoePNCafjJSI5Cyasz72heSSBr6li9?=
 =?us-ascii?Q?lj9qkDSNKkNH2pD579aHQXSM7UyV2snsOXNqWofTbHq6mWT/CFTvSpCCaO3r?=
 =?us-ascii?Q?8/7WnF5wiIC07Rns8EmKoRKqFL/zcTZ/7v47Yaz02yBQy8Gr2D/pWPQVN2rO?=
 =?us-ascii?Q?jzhOOkGV4c5VnKOr6LwNPeHXFwZana8C0GN+bxFjR1CGHXAJNNsCDWtOHNED?=
 =?us-ascii?Q?rhPCfzqTS8QMC9sKBoMwM6xHouLPhvJ8VPSSF4J3AMwAoxiEn7EB2A9Nf9T2?=
 =?us-ascii?Q?MRue5S4nYfsaLgS8lF4lTu0dFfcoOGqxg4ZRTg152twqcCtpaMRdXfV8dmVd?=
 =?us-ascii?Q?R909ST5Ey0sX6w1rorDrb6MkXippumOMa3zn4defHjZfH2CgrUo8jWk0+nY1?=
 =?us-ascii?Q?VkUiJJtbk9+hQO+NLbnOYzL8hQxrowkD6+Mc0N8ghVtGJOzOt20ma1tRVALW?=
 =?us-ascii?Q?gxXtWlZBeBOWgIdg3uJwhelkNWJ2fTX0Fkoi3rKrwosX8VjeCBHRptHLM5FK?=
 =?us-ascii?Q?/FoUj7yfXKEk/LY1n+ebBupQGVYTlmZq4jkOfHutN4OYEoZGrXNhg3e5J7Oy?=
 =?us-ascii?Q?9hEI95NJG4a1DrSEw7+A9w5eBPNedM6kOIzOXCo2DovQouWp4Cf+WbjjNMTu?=
 =?us-ascii?Q?hvUgkX1jyuISdHp4r1DnHEwUHRHhCFqYv4A1ZdyRquGlJIIr1NsoJQ5CAbEt?=
 =?us-ascii?Q?oV+eC7lA6a64FX1TfomAtqNmwu4LUMvPiRkrxl6qNql4lKwTdM+9chq59YBk?=
 =?us-ascii?Q?uCE35cwTL0y3I+ujXW/Hp+Tg53Sg0LtTUA1RxajjV0XYB/Pj69J3W1YJGi4U?=
 =?us-ascii?Q?6W0m5UWdQDuqNvOuHIh+Hx6YCsJmO9CwrHzXcop5gadQhIRi3hRRK/l0OfZ+?=
 =?us-ascii?Q?UN/TZirmjd+bNtKFoMU3soIQUHwBkjl1ktiEys+j0+K18kJD9iplVbFoWXyo?=
 =?us-ascii?Q?XlbIzQ0RyVYBgdVn2VHU85v9TJIOUn/1xxAIA8D3xaQwoIbGQFOOhkhw4o7R?=
 =?us-ascii?Q?AQPsXEeG+fqCxFU2OS2iNaD16t1D3j4AKhEYamAdX262hPoJ3ExZNe/VZuQ2?=
 =?us-ascii?Q?gEccp/PJUNWPgv6MBlbaCh7u?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b138bf0e-655b-4642-e58b-08d91aed0660
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB2840.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2021 17:39:16.8139 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WzoXjNzYjyT1wwYPHxF6L5h5Q1meio0Tydouu4rMmqos8WusVY3BR1n136DHAtbx
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3063
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

v2: Removed dpm and freq ranges info
v3: Added check to ensure volrage offset is not zero

Signed-off-by: David M Nieto <david.nieto@amd.com>
Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>
---
 .../gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c   | 82 +++++++++++++++----
 1 file changed, 65 insertions(+), 17 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
index ac13042672ea..30f585afeddd 100644
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
@@ -2681,17 +2681,29 @@ static ssize_t navi10_get_legacy_gpu_metrics(struct smu_context *smu,
 
 	gpu_metrics->system_clock_counter = ktime_get_boottime_ns();
 
+	if (metrics.CurrGfxVoltageOffset)
+		gpu_metrics->voltage_gfx =
+			(155000 - 625 * metrics.CurrGfxVoltageOffset) / 100;
+	if (metrics.CurrMemVidOffset)
+		gpu_metrics->voltage_mem =
+			(155000 - 625 * metrics.CurrMemVidOffset) / 100;
+	if (metrics.CurrSocVoltageOffset)
+		gpu_metrics->voltage_soc =
+			(155000 - 625 * metrics.CurrSocVoltageOffset) / 100;
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
 
@@ -2709,7 +2721,7 @@ static ssize_t navi10_get_gpu_metrics(struct smu_context *smu,
 
 	mutex_unlock(&smu->metrics_lock);
 
-	smu_cmn_init_soft_gpu_metrics(gpu_metrics, 1, 1);
+	smu_cmn_init_soft_gpu_metrics(gpu_metrics, 1, 3);
 
 	gpu_metrics->temperature_edge = metrics.TemperatureEdge;
 	gpu_metrics->temperature_hotspot = metrics.TemperatureHotspot;
@@ -2746,17 +2758,29 @@ static ssize_t navi10_get_gpu_metrics(struct smu_context *smu,
 
 	gpu_metrics->system_clock_counter = ktime_get_boottime_ns();
 
+	if (metrics.CurrGfxVoltageOffset)
+		gpu_metrics->voltage_gfx =
+			(155000 - 625 * metrics.CurrGfxVoltageOffset) / 100;
+	if (metrics.CurrMemVidOffset)
+		gpu_metrics->voltage_mem =
+			(155000 - 625 * metrics.CurrMemVidOffset) / 100;
+	if (metrics.CurrSocVoltageOffset)
+		gpu_metrics->voltage_soc =
+			(155000 - 625 * metrics.CurrSocVoltageOffset) / 100;
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
 
@@ -2774,7 +2798,7 @@ static ssize_t navi12_get_legacy_gpu_metrics(struct smu_context *smu,
 
 	mutex_unlock(&smu->metrics_lock);
 
-	smu_cmn_init_soft_gpu_metrics(gpu_metrics, 1, 1);
+	smu_cmn_init_soft_gpu_metrics(gpu_metrics, 1, 3);
 
 	gpu_metrics->temperature_edge = metrics.TemperatureEdge;
 	gpu_metrics->temperature_hotspot = metrics.TemperatureHotspot;
@@ -2814,17 +2838,29 @@ static ssize_t navi12_get_legacy_gpu_metrics(struct smu_context *smu,
 
 	gpu_metrics->system_clock_counter = ktime_get_boottime_ns();
 
+	if (metrics.CurrGfxVoltageOffset)
+		gpu_metrics->voltage_gfx =
+			(155000 - 625 * metrics.CurrGfxVoltageOffset) / 100;
+	if (metrics.CurrMemVidOffset)
+		gpu_metrics->voltage_mem =
+			(155000 - 625 * metrics.CurrMemVidOffset) / 100;
+	if (metrics.CurrSocVoltageOffset)
+		gpu_metrics->voltage_soc =
+			(155000 - 625 * metrics.CurrSocVoltageOffset) / 100;
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
 
@@ -2842,7 +2878,7 @@ static ssize_t navi12_get_gpu_metrics(struct smu_context *smu,
 
 	mutex_unlock(&smu->metrics_lock);
 
-	smu_cmn_init_soft_gpu_metrics(gpu_metrics, 1, 1);
+	smu_cmn_init_soft_gpu_metrics(gpu_metrics, 1, 3);
 
 	gpu_metrics->temperature_edge = metrics.TemperatureEdge;
 	gpu_metrics->temperature_hotspot = metrics.TemperatureHotspot;
@@ -2884,9 +2920,21 @@ static ssize_t navi12_get_gpu_metrics(struct smu_context *smu,
 
 	gpu_metrics->system_clock_counter = ktime_get_boottime_ns();
 
+	if (metrics.CurrGfxVoltageOffset)
+		gpu_metrics->voltage_gfx =
+			(155000 - 625 * metrics.CurrGfxVoltageOffset) / 100;
+	if (metrics.CurrMemVidOffset)
+		gpu_metrics->voltage_mem =
+			(155000 - 625 * metrics.CurrMemVidOffset) / 100;
+	if (metrics.CurrSocVoltageOffset)
+		gpu_metrics->voltage_soc =
+			(155000 - 625 * metrics.CurrSocVoltageOffset) / 100;
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
