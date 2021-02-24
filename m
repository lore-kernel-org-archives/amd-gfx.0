Return-Path: <SRS0=z84W=H2=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60168C433DB
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Feb 2021 22:23:16 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1C43E64E05
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Feb 2021 22:23:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C43E64E05
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BA5986EC00;
	Wed, 24 Feb 2021 22:23:15 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2048.outbound.protection.outlook.com [40.107.243.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CD9A76EC00
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Feb 2021 22:23:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aKtbdmmFqgpRIdxq4E2cHemBmQfXMUPlDK2VooJH6AwVZAV7o16xB1dHAEGRR6WJp4jQDPkAKPcVxEWyJrDFMr8w5QXogtcDNGE9PlbyAycLOGw0ScgdxmgyW/yi/iP+/6PZqMLKFrGomjQYikH7tY+2gtDUKMn7E+HuR6EIgt7zWG2bUm2BVcwOY7kQSppb4VPtcEWZCbaSVG+PMBF1eciVyd32iHamOllrsrcRbnNwlPvqMqAxO/95w1XIS1+d4nswsRDPsLDRdcazUmcUdpa/AwgOcQPFR+gGVUznoME7pnZPFnaEe8WtTSunWKiX5RgHmHCuZIBYiAz0erlCxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h1xjmwJbuaZIeLM1Dm/W34P/Mn1vp65wVEo5QWk/2TM=;
 b=Q0IPdmirhMvItLFaeMicGhBbALdJPajjviAVjZ5U1WjF895ITB2PHy51GPhMsYJ1JlDbQslmyGdV1Q16IWbwRt7b+uJ0jdKDAUCnXty45Vj+28niYfoacsCL6ZI8jZbXKA3ncYtB+EuQX7rPsloE6CdnlHxFa0OrylOj57G6ANPnTQCRHX+xfYOgyptgZ42apv0UuxGbMQXfqBtnOGEla2IqFcmg+2q29e4wdI1gRQLqiV8U4bHV6CUg9Dop0k0xAow5djpuJ7NYFFZ8ROdoBqyU3Fa/VZ4Gt96vFsySVP1kPF9+Iw/EiFKdOdhrtByGzmFW1QdMKesVrdAT1L86lQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h1xjmwJbuaZIeLM1Dm/W34P/Mn1vp65wVEo5QWk/2TM=;
 b=VAx3E70M3L86UGn44pEhCdtvz0HAkqy22UQ3rWIlIhk4Iu9gPJ4tSeOl5ZeK8XLWetwM5lbVtlVgJSm4CXCnSABXMicic6et1KEkRbVoCPxwWh2zCEUYsWEkl05kZbsfboEOxh4x2P50LivY7YPjWIsKO+OmHlec8t4OeDtaI6k=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 by MN2PR12MB4831.namprd12.prod.outlook.com (2603:10b6:208:1b9::32)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3868.31; Wed, 24 Feb
 2021 22:23:12 +0000
Received: from MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::b0c4:9a8b:4c4c:76af]) by MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::b0c4:9a8b:4c4c:76af%7]) with mapi id 15.20.3868.033; Wed, 24 Feb 2021
 22:23:12 +0000
From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 159/159] drm/amd/pm: add new data in metrics table
Date: Wed, 24 Feb 2021 17:18:59 -0500
Message-Id: <20210224221859.3068810-152-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210224221859.3068810-1-alexander.deucher@amd.com>
References: <20210224221859.3068810-1-alexander.deucher@amd.com>
X-Originating-IP: [192.161.79.246]
X-ClientProxiedBy: BLAPR03CA0027.namprd03.prod.outlook.com
 (2603:10b6:208:32b::32) To MN2PR12MB4488.namprd12.prod.outlook.com
 (2603:10b6:208:24e::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (192.161.79.246) by
 BLAPR03CA0027.namprd03.prod.outlook.com (2603:10b6:208:32b::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.19 via Frontend
 Transport; Wed, 24 Feb 2021 22:21:08 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 97662702-00b4-4928-b3a0-08d8d9127c2b
X-MS-TrafficTypeDiagnostic: MN2PR12MB4831:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB483154A131C44BE4159D337EF79F9@MN2PR12MB4831.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4303;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SzAEGU/4UQ97F++qZs7AKZAV8clsOuJ8zQoRQaWxWPxoKvBeTf9mon8KuX9PIEY+8sIbT8HCiXZ5UY19VGZDpWH8YWGWN0FvDG1SIkmyfo+keb7pH6rgY4u7njuBvKnS2Whx/idktNvFCYxdAQQ/HS6HNUCs8lM1DtE96b1tli+yUEZPQsKsUMq6xi13f6YLItXN2V+A3a0AtEellXQQZQgNL4W9tN/cMsMgIaHsx+VVN/tKTWRspOAfb1pBF9D4xZ1jz4KdycVetLRvPWcyT2QzIwnPit6p0ubngcRPSnBG1y0WuHKrRXZfxuXaBliGq5Alapx/gS42QVkghp4IIwlPcR98jLTbrO2yXrBu6PolCgbdrtjULzVW0umc0pnFfULI+sAPw5VicBYv7azz9OPig2YVFzekyqRoEC3w4wsE+CF/x6C53slnIyLJ3ztQrRoE9DSl6Y2wjE4xDAPPC4gMGs1iNzxsUmhYLeKXfIOyiehBaITh7mQXoYVS3KJtz3NyRXwBubqpAyJff/HmLtrBeG/l9LUfLBXHeADgO+PHRgAyDjQry3AUbrSiAz5K3R/zBnAvyVzmrht2axMINg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4488.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(396003)(346002)(39860400002)(366004)(376002)(5660300002)(6506007)(6486002)(83380400001)(316002)(6666004)(1076003)(52116002)(86362001)(478600001)(54906003)(6916009)(36756003)(8936002)(6512007)(4326008)(8676002)(69590400012)(66946007)(66556008)(956004)(2616005)(26005)(2906002)(16526019)(186003)(66476007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?nj62XNrGAVx03MSQBe/V3Gy3kED2R+xdjvxdKr78RD5WYqUmBmjjNVDTAGhR?=
 =?us-ascii?Q?QfpAUI4ldJzASE3MJi89xqIGSSUX/GbROOgUFYCqK5NSROYBsjLahmBQ6JBX?=
 =?us-ascii?Q?hQqQ7NS20vWGm0E9A9N0+aL15ua16qAkjPQ86moVu2fiEdK2aLHyFLnCWDdt?=
 =?us-ascii?Q?w2R8pbRDJKWpYdoqZxznYvU9g9pY4ZREGZ4FrEJ9LyHU3VPpdxFZ9kxhtahG?=
 =?us-ascii?Q?9FsdU0MmJlMmaWIQVTUE0JS5wHSLF22xhw5ym1YiFHjDeduhMNVqMooIBCoD?=
 =?us-ascii?Q?NmaJplrjtP6xDOy04wzh73lITuwN+caall0V+s9cBFih1X4JWAR2LzGgGRbQ?=
 =?us-ascii?Q?M1m1UGKSLFzSiZndb7/uBL4aoJcDqBI+WYIC2UeY06doaW77uXZnFOTv0eKh?=
 =?us-ascii?Q?HugDTCo8rCYzPFq87J28aAV/JY/j7SQI1NossXCAaaic9+bI9AECgmVhz9mX?=
 =?us-ascii?Q?T/+ExxyMuRfdrViidBXloyCVDxeIN5HJjODJPC+YoulHacOBPIlmDvBDu4KK?=
 =?us-ascii?Q?OHBASv/nWKevH9fQ/iPY5GPuXSQLasvx42LCwFaVhDWJT01tDH1agE/suyCI?=
 =?us-ascii?Q?rzbcV1SUHXVbBxFnOKaumeKE5WofUJlMwDNmQKdCt7YvA/f8EiQlZeoj4J3Q?=
 =?us-ascii?Q?qyVJnW/w8RGpqd+itB9vsZkK21hWLu5y5y+/k1ZTxbphSdqFUuqpLc2lSOLY?=
 =?us-ascii?Q?GsGlTwne6VeaPVRXMauQKRd8Rr6k/Er2X2KTbijRImQH3Y1qAv5xrBOaIR4l?=
 =?us-ascii?Q?6M8J1RkC4NcLxZnRYnhPQfnruaHBvV8LOWer3I1lSed1rBw6zI65nXMKnk3j?=
 =?us-ascii?Q?3pz1aftT+13/Jjtnrto3f2TC+ODlc1TS3DkMRc7NFMwdoyIFuwS4ByxV1s67?=
 =?us-ascii?Q?v57xEvPz5z1M4NIA/ECTTCnfsJUntjLpCEv5EvYjDNIhNkLhcacpnwNB9mDu?=
 =?us-ascii?Q?MQlFGD4JTTDcThEMzf1q/ozETvaWQ2WfDpg/kZ70/74LG8/BvwAr1+LxWfKr?=
 =?us-ascii?Q?FDwAQYUgMou1G2WwV1hzT4YiRQMYZ0DZmO592ghYCNO41YG02v53ey/vZU5A?=
 =?us-ascii?Q?NL/qgb5WH7GGzRa+7IOfTBY4x354XZnFo8c9eAW7Rvjw4LdAI3TFsZUpzqPT?=
 =?us-ascii?Q?mHOmVsopNMzu05rex1aSXrETemPY6v32puVvv7CS2itJ76MjE0iVMi+JJWHI?=
 =?us-ascii?Q?LOijPhCTXUY1SrnW8LtclojjpQX2JrU0j3lKOPu2lWEQJ8YVx3ERNtr8awFY?=
 =?us-ascii?Q?Auxjh4iCTC9B5R2yMxGJaquQY48qlWRJxrQhugYHell0/sYeFxjCyMH4YZUV?=
 =?us-ascii?Q?NafOgmlbxOYEhtaBi/Q0AciJ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 97662702-00b4-4928-b3a0-08d8d9127c2b
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4488.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2021 22:21:09.0744 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mAVXJaULjgatsJdwCvB4yvXRiJ8e6IP2WqgY3AbJwXd2jn3k1pUB1h8xxWbYaVlJTIaedhIzqRaux3iSOAAeGw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4831
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Kevin Wang <kevin1.wang@amd.com>,
 Kenneth Feng <kenneth.feng@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Kenneth Feng <kenneth.feng@amd.com>

Export new data in the metrics table for gfx and memory
utilization counter, and each hbm temperature as well.

v2:
change the metrics table version to v1.1

v3:
fix the coding style

Signed-off-by: Kenneth Feng <kenneth.feng@amd.com>
Reviewed-by: Kevin Wang <kevin1.wang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 .../gpu/drm/amd/include/kgd_pp_interface.h    | 11 ++++
 drivers/gpu/drm/amd/pm/inc/smu_v13_0.h        |  2 +
 .../drm/amd/pm/swsmu/smu13/aldebaran_ppt.c    | 55 +++++++++++--------
 .../gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c    | 12 ++++
 4 files changed, 56 insertions(+), 24 deletions(-)

diff --git a/drivers/gpu/drm/amd/include/kgd_pp_interface.h b/drivers/gpu/drm/amd/include/kgd_pp_interface.h
index c6b5c789abf0..ce01f012963b 100644
--- a/drivers/gpu/drm/amd/include/kgd_pp_interface.h
+++ b/drivers/gpu/drm/amd/include/kgd_pp_interface.h
@@ -227,6 +227,8 @@ enum pp_df_cstate {
 #define XGMI_MODE_PSTATE_D3 0
 #define XGMI_MODE_PSTATE_D0 1
 
+#define NUM_HBM_INSTANCES 4
+
 struct seq_file;
 enum amd_pp_clock_type;
 struct amd_pp_simple_clock_info;
@@ -389,6 +391,15 @@ struct gpu_metrics_v1_0 {
 	uint8_t				pcie_link_speed; // in 0.1 GT/s
 };
 
+struct gpu_metrics_v1_1 {
+	struct gpu_metrics_v1_0 v1_0;
+
+	uint32_t			gfx_activity_acc;
+	uint32_t			mem_activity_acc;
+
+	uint16_t			temperature_hbm[NUM_HBM_INSTANCES];
+};
+
 struct gpu_metrics_v2_0 {
 	struct metrics_table_header	common_header;
 
diff --git a/drivers/gpu/drm/amd/pm/inc/smu_v13_0.h b/drivers/gpu/drm/amd/pm/inc/smu_v13_0.h
index ef9dad9a51ff..b9f87285875f 100644
--- a/drivers/gpu/drm/amd/pm/inc/smu_v13_0.h
+++ b/drivers/gpu/drm/amd/pm/inc/smu_v13_0.h
@@ -267,6 +267,8 @@ int smu_v13_0_get_current_pcie_link_speed(struct smu_context *smu);
 
 void smu_v13_0_init_gpu_metrics_v1_0(struct gpu_metrics_v1_0 *gpu_metrics);
 
+void smu_v13_0_init_gpu_metrics_v1_1(struct gpu_metrics_v1_1 *gpu_metrics);
+
 int smu_v13_0_gfx_ulv_control(struct smu_context *smu,
 			      bool enablement);
 
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
index c463af1cafa0..1727de2b31bd 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
@@ -1296,10 +1296,11 @@ static ssize_t aldebaran_get_gpu_metrics(struct smu_context *smu,
 					 void **table)
 {
 	struct smu_table_context *smu_table = &smu->smu_table;
-	struct gpu_metrics_v1_0 *gpu_metrics =
-		(struct gpu_metrics_v1_0 *)smu_table->gpu_metrics_table;
+	struct gpu_metrics_v1_1 *gpu_metrics =
+		(struct gpu_metrics_v1_1 *)smu_table->gpu_metrics_table;
 	SmuMetrics_t metrics;
 	int ret = 0;
+	int i;
 
 	ret = smu_cmn_get_metrics_table(smu,
 					&metrics,
@@ -1307,40 +1308,46 @@ static ssize_t aldebaran_get_gpu_metrics(struct smu_context *smu,
 	if (ret)
 		return ret;
 
-	smu_v13_0_init_gpu_metrics_v1_0(gpu_metrics);
+	smu_v13_0_init_gpu_metrics_v1_1(gpu_metrics);
 
-	gpu_metrics->temperature_edge = metrics.TemperatureEdge;
-	gpu_metrics->temperature_hotspot = metrics.TemperatureHotspot;
-	gpu_metrics->temperature_mem = metrics.TemperatureHBM;
-	gpu_metrics->temperature_vrgfx = metrics.TemperatureVrGfx;
-	gpu_metrics->temperature_vrsoc = metrics.TemperatureVrSoc;
-	gpu_metrics->temperature_vrmem = metrics.TemperatureVrMem;
+	gpu_metrics->v1_0.temperature_edge = metrics.TemperatureEdge;
+	gpu_metrics->v1_0.temperature_hotspot = metrics.TemperatureHotspot;
+	gpu_metrics->v1_0.temperature_mem = metrics.TemperatureHBM;
+	gpu_metrics->v1_0.temperature_vrgfx = metrics.TemperatureVrGfx;
+	gpu_metrics->v1_0.temperature_vrsoc = metrics.TemperatureVrSoc;
+	gpu_metrics->v1_0.temperature_vrmem = metrics.TemperatureVrMem;
 
-	gpu_metrics->average_gfx_activity = metrics.AverageGfxActivity;
-	gpu_metrics->average_umc_activity = metrics.AverageUclkActivity;
+	gpu_metrics->v1_0.average_gfx_activity = metrics.AverageGfxActivity;
+	gpu_metrics->v1_0.average_umc_activity = metrics.AverageUclkActivity;
 
-	gpu_metrics->average_socket_power = metrics.AverageSocketPower;
+	gpu_metrics->v1_0.average_socket_power = metrics.AverageSocketPower;
 
-	gpu_metrics->average_gfxclk_frequency = metrics.AverageGfxclkFrequency;
-	gpu_metrics->average_socclk_frequency = metrics.AverageSocclkFrequency;
-	gpu_metrics->average_uclk_frequency = metrics.AverageUclkFrequency;
+	gpu_metrics->v1_0.average_gfxclk_frequency = metrics.AverageGfxclkFrequency;
+	gpu_metrics->v1_0.average_socclk_frequency = metrics.AverageSocclkFrequency;
+	gpu_metrics->v1_0.average_uclk_frequency = metrics.AverageUclkFrequency;
 
-	gpu_metrics->current_gfxclk = metrics.CurrClock[PPCLK_GFXCLK];
-	gpu_metrics->current_socclk = metrics.CurrClock[PPCLK_SOCCLK];
-	gpu_metrics->current_uclk = metrics.CurrClock[PPCLK_UCLK];
-	gpu_metrics->current_vclk0 = metrics.CurrClock[PPCLK_VCLK];
-	gpu_metrics->current_dclk0 = metrics.CurrClock[PPCLK_DCLK];
+	gpu_metrics->v1_0.current_gfxclk = metrics.CurrClock[PPCLK_GFXCLK];
+	gpu_metrics->v1_0.current_socclk = metrics.CurrClock[PPCLK_SOCCLK];
+	gpu_metrics->v1_0.current_uclk = metrics.CurrClock[PPCLK_UCLK];
+	gpu_metrics->v1_0.current_vclk0 = metrics.CurrClock[PPCLK_VCLK];
+	gpu_metrics->v1_0.current_dclk0 = metrics.CurrClock[PPCLK_DCLK];
 
-	gpu_metrics->throttle_status = metrics.ThrottlerStatus;
+	gpu_metrics->v1_0.throttle_status = metrics.ThrottlerStatus;
 
-	gpu_metrics->pcie_link_width =
+	gpu_metrics->v1_0.pcie_link_width =
 		smu_v13_0_get_current_pcie_link_width(smu);
-	gpu_metrics->pcie_link_speed =
+	gpu_metrics->v1_0.pcie_link_speed =
 		aldebaran_get_current_pcie_link_speed(smu);
 
+	gpu_metrics->gfx_activity_acc = metrics.GfxBusyAcc;
+	gpu_metrics->mem_activity_acc = metrics.DramBusyAcc;
+
+	for (i = 0; i < NUM_HBM_INSTANCES; i++)
+		gpu_metrics->temperature_hbm[i] = metrics.TemperatureAllHBM[i];
+
 	*table = (void *)gpu_metrics;
 
-	return sizeof(struct gpu_metrics_v1_0);
+	return sizeof(*gpu_metrics);
 }
 
 static bool aldebaran_is_mode1_reset_supported(struct smu_context *smu)
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
index ce160f233323..cde299c110b4 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
@@ -1820,3 +1820,15 @@ void smu_v13_0_init_gpu_metrics_v1_0(struct gpu_metrics_v1_0 *gpu_metrics)
 
 	gpu_metrics->system_clock_counter = ktime_get_boottime_ns();
 }
+
+void smu_v13_0_init_gpu_metrics_v1_1(struct gpu_metrics_v1_1 *gpu_metrics)
+{
+	memset(gpu_metrics, 0xFF, sizeof(struct gpu_metrics_v1_1));
+
+	gpu_metrics->v1_0.common_header.structure_size =
+		sizeof(struct gpu_metrics_v1_1);
+	gpu_metrics->v1_0.common_header.format_revision = 1;
+	gpu_metrics->v1_0.common_header.content_revision = 1;
+
+	gpu_metrics->v1_0.system_clock_counter = ktime_get_boottime_ns();
+}
-- 
2.29.2

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
