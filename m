Return-Path: <SRS0=8Dg8=KP=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 886D5C433B4
	for <amd-gfx@archiver.kernel.org>; Thu, 20 May 2021 14:30:31 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4CB54610A8
	for <amd-gfx@archiver.kernel.org>; Thu, 20 May 2021 14:30:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4CB54610A8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 25D986EA9B;
	Thu, 20 May 2021 14:30:30 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam08on2043.outbound.protection.outlook.com [40.107.102.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4BFAC6EEA1
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 May 2021 14:30:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=msCCiQd8Uh6yhVsNWDnQXfCU+7CiRyYeRxSwy8wQnXR9NNPcfCxeLrzRnUu2LSrvY0ub5os+N/4mNg6b/5dzXbQvNoIkBy0cURG8cAQTsSB42EF51UBI6SHXNCKgqEp2eL+x5mauU8vbQ/jqHcP5QzANcoEY/i6fSghzOzcRP75HQX1aWQUB6XNnWSE1rAia5DbwQSI+zBHs1oydfXORFLDpXybwdGUkfsKsqNdWUfjBfrl/gR+nZSYjORuJFFgPiSg4OAJVrxx0VO+GSVrH9GLNXyASWa2k1YDkFW/Lzf2nbAC2q38GXaN1s6Jbgh6ly9Q/UORaQBq9QUUULYzxsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3+z75i0eZPGmO8X1OshgUGVS+PJyLODPsz/l9o5kuxE=;
 b=Qt0B4s1brkYQI7oKgn30Zd6xDHLzVpTabVQcuHDcUswEh6lxTvhLn7uwD7pfMuCuJf1czDJXkv/TUQbgkDcCqXl1XpVb9vfmtFLm32+uUHYxK2GkPMShInplncXLvZy5XRZvMfwQ1x0MJ/X5SjrtenppMXRmiWUNJK9wy+dWzM31oHHtzduEh6FzpipfcL1k5q9ii1xe3YnpOuGNR/Il1l5o5eCVU8agKVl9/w4y3fas84HXq3HT7yvXH2iDhST1GxcxQJn7nouAAB8Ohe5ZI3PehIGanJchkLqnx2lXER/7ACFUUs4mnTIFFt6VkEjBzM6JNYifmMkYZO1KeXABPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3+z75i0eZPGmO8X1OshgUGVS+PJyLODPsz/l9o5kuxE=;
 b=D9BV/WSW7m8UO6CumedjLQqZ2JIczscqGPhRGeF9j6xAK29gVOQVkR/VigvxZ9AvGRzRbSaInJQnlYjKHU4uyE/bXQl623Jn2hYjMzpKg/655Am19ucNuqzkr+mWl9Aj+Qvbs6roK7MP/M1jMTVVrjPJXN1MPwsZ+TsYzv+XpOM=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3067.namprd12.prod.outlook.com (2603:10b6:5:115::10)
 by DM6PR12MB2748.namprd12.prod.outlook.com (2603:10b6:5:43::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4150.23; Thu, 20 May
 2021 14:30:24 +0000
Received: from DM6PR12MB3067.namprd12.prod.outlook.com
 ([fe80::5c8c:adff:ab42:9345]) by DM6PR12MB3067.namprd12.prod.outlook.com
 ([fe80::5c8c:adff:ab42:9345%6]) with mapi id 15.20.4129.035; Thu, 20 May 2021
 14:30:24 +0000
From: Graham Sider <Graham.Sider@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 5/6] drm/amd/pm: Add vangogh throttler translation
Date: Thu, 20 May 2021 10:29:29 -0400
Message-Id: <20210520142930.8369-5-Graham.Sider@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210520142930.8369-1-Graham.Sider@amd.com>
References: <20210520142930.8369-1-Graham.Sider@amd.com>
X-Originating-IP: [165.204.54.211]
X-ClientProxiedBy: YT2PR01CA0018.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:38::23) To DM6PR12MB3067.namprd12.prod.outlook.com
 (2603:10b6:5:115::10)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from grasider-dev.amd.com (165.204.54.211) by
 YT2PR01CA0018.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:38::23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4108.31 via Frontend Transport; Thu, 20 May 2021 14:30:23 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1267ca8b-0bda-4f1c-f868-08d91b9bce03
X-MS-TrafficTypeDiagnostic: DM6PR12MB2748:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB2748AF3203D1FA671A9BE42F8A2A9@DM6PR12MB2748.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2331;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7zUCH9TmhW2cGEyBNH66tmontaUY7GbtLIBRyxUYCdp+S4DbHDubKsWlP5482rhKGTDMShHXLPRStVQafewj8pGn+AFAI2/ThSm72tBAS9aLUf4N9u7XFEPuRfFOyUC/SAdKhURXaE6Q7QfXtyy58FlbK0VBMu42GPU4xzdEqz2JV0Cu38axRjvqFmdMHIVlgH0JiZNWMRZvRc1rBQObIEgszAHjDDdSau6qJ75kfYAKCKf1ZCjflDM/YDci7CGXHtK3YGZmRPfd3rEGP4aJwIX1czKWIkcqjosJp6UAEVivkWSEoM96MrSvg/d0BFEWKPmBs7X1rNT6j8ui4FWFAEYinN6MMKI2Q5Oer2CGl4wMjd7alfDXRsXEN8rTCyiEESc8cHrA+hW0y23l2izm2U+AB8XU+6soQouTQOGebLXOkD0itoeESYtu5bQ2KhNwCRG3b1tA0Hl8UfE1Q17MCa67uv4EBGVCTroJ3vRqnbg/iVlvZVvvq6dj3H7/AtzDVlabwneyrBwaU5gkdddnueTDpf82nWigCgVWWXSK4Vb3S+tMUCPitXTxlDDlQ6eGnis2WnnZbsAgELBbxI3K+Rdp2ykpLiiBXR551uFTojNH1V5boLfayhVRYKB/f8O/EDYZoiFeUMzqETQUK9Q10g==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3067.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(396003)(366004)(346002)(39860400002)(136003)(36756003)(478600001)(8676002)(66556008)(16526019)(1076003)(66476007)(38350700002)(38100700002)(86362001)(316002)(66946007)(5660300002)(186003)(8936002)(2906002)(26005)(52116002)(83380400001)(7696005)(6486002)(6916009)(4326008)(2616005)(956004);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?utkOuOSsIUM+lql8Rvy3kYW1H1JvbpMHgXJ+sW3hQ1E0KqFoLbigX1FVuV2I?=
 =?us-ascii?Q?NVwvt2OWeNG+TJlTmY4ICtn4J4jzKnUke4dYpv+13OC5h6rSTJV4Gp3RCxE3?=
 =?us-ascii?Q?wyV1KiTzPEoElsa22jetBDsLmxBsEN5LrBQJsgJIdJBM+MbPNWvLORSQumUV?=
 =?us-ascii?Q?66kx3LOrHaTfVzCvvRBF4g5N+0aggozlSzkPbmsBPQ3Zo6R1Y7X9z/8LkbcR?=
 =?us-ascii?Q?7U1W/cIrNzRAf0JzeXM7ZKGJ/muWg3rCWrKct1xVywcxJf76N36YtVzKB1yj?=
 =?us-ascii?Q?4R/l1UrLVIuI6AgDg/HakRsBkGXdBgHuJWXISkRTa9aydfUlxxZpjhgDcUmF?=
 =?us-ascii?Q?SiGFb5PSl3Z/YXoTNskfnMiK9TOivIrRzdXfEGq5GdeTA2E9JtQYj0Y2XPdm?=
 =?us-ascii?Q?vknBIIvk9b8b4fuWPNq9I67cqjb6Lf0641ECvtDj9aKAWJVZe8twK0yKaF1G?=
 =?us-ascii?Q?/ZeFlO8yw77M4rK1Hi3qEpaGXIKGur9L1Iqrfo6pO+aCQ+ni8MevrNYsKfDP?=
 =?us-ascii?Q?ds8lfFlbZJRZQo5Ny2Z7aKTENj35tW6+BD0D3Dml0Z4SHYwYHKZxLrYs8azx?=
 =?us-ascii?Q?ZuQu1GMVOC/3i/P/Uj0G74Lj8sFUsjl3+MczVokJ2/5FU9gcJxoKwltfse95?=
 =?us-ascii?Q?HDi76Jc4uH1VjsHnh4pX6jf9trG6yJn06C6ZWiSG+S+GwfWZbIviO2I8HweM?=
 =?us-ascii?Q?UI2bLeC036PMthTJ773fbDJFtZ0bm6PpxPDs3U02c4MqKGe1xByWAh+csmmT?=
 =?us-ascii?Q?SN1E+C4AnmQPx1xe0N1YZUENOcfmgT4Ci7Tu7ufm6WQBKr5Jziy9Bjuabuyf?=
 =?us-ascii?Q?FxclyAyRM8O0yEWVABPtg+pRtYsHyIHm+V2OeE0LpziuqWU7IHmkl8rMASWC?=
 =?us-ascii?Q?tQPaBGgFjqodvwNH+wX9wfJh+KN3+3R9wuhrxTD4MUyQc4ceoxewzeZfkDn6?=
 =?us-ascii?Q?pNKChhpojOkuKMC+rR1ikHZaNoD4LfMCJ1eX2EHM8l5u4dJW+Hd1niKYmFWG?=
 =?us-ascii?Q?AJMauqxvuFtE3dIXvfeIHOPdYou1veM2XWiKx2ChDGWWfI2cvhW/Qw39ATnz?=
 =?us-ascii?Q?f18qNEh52Ed/+vZ1qg3veadZRB8bW7ixMaGaWu8AwGjQ/vsnL1CT9PB/NyKI?=
 =?us-ascii?Q?mepZvegUh+v3R5CqLO/36DVIm2Jy/1LnM06MpCP+Oh21M40iS25UFFRbVC0H?=
 =?us-ascii?Q?/OLPcJvRKfJEnSorzeHws/N5d3dkzeyIw1lge9duoZF98oxWSwSBZl4OSY9v?=
 =?us-ascii?Q?SnnLJmFz3vXPVo7vtfHzWqwWRCBY69ftOoF8BVxvLsqUlmsyxLmPt8MqwqpT?=
 =?us-ascii?Q?Jgh2IB1AnHdS41i6GVBPoPwD?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1267ca8b-0bda-4f1c-f868-08d91b9bce03
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3067.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2021 14:30:24.1692 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IrbVdtqridbR/w+Q9lwkpRTqpD4nSlj1/MopPUY0b8U0G5k8kWz9rJ3GJeT9Be0s/p4ojMKhFa0xbR6F7NeyJg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2748
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
Cc: Harish.Kasiviswanathan@amd.com, Graham Sider <Graham.Sider@amd.com>,
 Elena.Sakhnovitch@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Perform dependent to independent throttle status translation for
vangogh.
---
 .../gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c  | 41 +++++++++++++++++--
 1 file changed, 37 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
index 77f532a49e37..6e3cfb4bda1d 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
@@ -251,6 +251,37 @@ static int vangogh_tables_init(struct smu_context *smu)
 	return -ENOMEM;
 }
 
+static uint32_t vangogh_get_indep_throttler_status(
+					unsigned long dep_throttler_status)
+{
+	unsigned long indep_throttler_status = 0;
+
+	__assign_bit(INDEP_THROTTLER_STATUS_BIT_SPL, &indep_throttler_status,
+		  test_bit(THROTTLER_STATUS_BIT_SPL, &dep_throttler_status));
+	__assign_bit(INDEP_THROTTLER_STATUS_BIT_FPPT, &indep_throttler_status,
+		  test_bit(THROTTLER_STATUS_BIT_FPPT, &dep_throttler_status));
+	__assign_bit(INDEP_THROTTLER_STATUS_BIT_SPPT, &indep_throttler_status,
+		  test_bit(THROTTLER_STATUS_BIT_SPPT, &dep_throttler_status));
+	__assign_bit(INDEP_THROTTLER_STATUS_BIT_SPPT_APU, &indep_throttler_status,
+		  test_bit(THROTTLER_STATUS_BIT_SPPT_APU, &dep_throttler_status));
+	__assign_bit(INDEP_THROTTLER_STATUS_BIT_THM_CORE, &indep_throttler_status,
+		  test_bit(THROTTLER_STATUS_BIT_THM_CORE, &dep_throttler_status));
+	__assign_bit(INDEP_THROTTLER_STATUS_BIT_THM_GFX, &indep_throttler_status,
+		  test_bit(THROTTLER_STATUS_BIT_THM_GFX, &dep_throttler_status));
+	__assign_bit(INDEP_THROTTLER_STATUS_BIT_THM_SOC, &indep_throttler_status,
+		  test_bit(THROTTLER_STATUS_BIT_THM_SOC, &dep_throttler_status));
+	__assign_bit(INDEP_THROTTLER_STATUS_BIT_TDC_VDD, &indep_throttler_status,
+		  test_bit(THROTTLER_STATUS_BIT_TDC_VDD, &dep_throttler_status));
+	__assign_bit(INDEP_THROTTLER_STATUS_BIT_TDC_SOC, &indep_throttler_status,
+		  test_bit(THROTTLER_STATUS_BIT_TDC_SOC, &dep_throttler_status));
+	__assign_bit(INDEP_THROTTLER_STATUS_BIT_TDC_GFX, &indep_throttler_status,
+		  test_bit(THROTTLER_STATUS_BIT_TDC_GFX, &dep_throttler_status));
+	__assign_bit(INDEP_THROTTLER_STATUS_BIT_TDC_CVIP, &indep_throttler_status,
+		  test_bit(THROTTLER_STATUS_BIT_TDC_CVIP, &dep_throttler_status));
+
+	return (uint32_t)indep_throttler_status;
+}
+
 static int vangogh_get_legacy_smu_metrics_data(struct smu_context *smu,
 				       MetricsMember_t member,
 				       uint32_t *value)
@@ -304,7 +335,7 @@ static int vangogh_get_legacy_smu_metrics_data(struct smu_context *smu,
 		SMU_TEMPERATURE_UNITS_PER_CENTIGRADES;
 		break;
 	case METRICS_THROTTLER_STATUS:
-		*value = metrics->ThrottlerStatus;
+		*value = vangogh_get_indep_throttler_status(metrics->ThrottlerStatus);
 		break;
 	case METRICS_VOLTAGE_VDDGFX:
 		*value = metrics->Voltage[2];
@@ -379,7 +410,7 @@ static int vangogh_get_smu_metrics_data(struct smu_context *smu,
 		SMU_TEMPERATURE_UNITS_PER_CENTIGRADES;
 		break;
 	case METRICS_THROTTLER_STATUS:
-		*value = metrics->Current.ThrottlerStatus;
+		*value = vangogh_get_indep_throttler_status(metrics->Current.ThrottlerStatus);
 		break;
 	case METRICS_VOLTAGE_VDDGFX:
 		*value = metrics->Current.Voltage[2];
@@ -1673,7 +1704,8 @@ static ssize_t vangogh_get_legacy_gpu_metrics(struct smu_context *smu,
 		sizeof(uint16_t) * 4);
 	gpu_metrics->current_l3clk[0] = metrics.L3Frequency[0];
 
-	gpu_metrics->throttle_status = metrics.ThrottlerStatus;
+	gpu_metrics->throttle_status =
+			vangogh_get_indep_throttler_status(metrics.ThrottlerStatus);
 
 	gpu_metrics->system_clock_counter = ktime_get_boottime_ns();
 
@@ -1734,7 +1766,8 @@ static ssize_t vangogh_get_gpu_metrics(struct smu_context *smu,
 		sizeof(uint16_t) * 4);
 	gpu_metrics->current_l3clk[0] = metrics.Current.L3Frequency[0];
 
-	gpu_metrics->throttle_status = metrics.Current.ThrottlerStatus;
+	gpu_metrics->throttle_status =
+			vangogh_get_indep_throttler_status(metrics.Current.ThrottlerStatus);
 
 	gpu_metrics->system_clock_counter = ktime_get_boottime_ns();
 
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
