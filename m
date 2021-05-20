Return-Path: <SRS0=8Dg8=KP=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02262C43461
	for <amd-gfx@archiver.kernel.org>; Thu, 20 May 2021 14:30:41 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B921061002
	for <amd-gfx@archiver.kernel.org>; Thu, 20 May 2021 14:30:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B921061002
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3A23E6E40C;
	Thu, 20 May 2021 14:30:40 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2058.outbound.protection.outlook.com [40.107.92.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C8C656E303
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 May 2021 14:30:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SpJVSCxJY4XeWpGAQboGbBfs2MXF7uU8o190kWN8P5lMvXutWD3NSdkptMstoZsBxyJj4Pm2DscQmHmxAZYlyqsexHkj4QcnZ+/ZvwzgsgoBwlBw9d61cscVkCxYCRQHm1fgfcKN5xhDVQRhMzfe8lK4TWkNDH2wbEzD5LpEfdcQfsMmyOXMbjHaRd+pOALclQj09xZ7uYqr/TWNDCb1DXXbG9LK1UDZiMchtsRO09Z2jClNnvkOCQYWYZcYszQXjeW+qHEgKKoQw2yop0u8CVAnmPQDpdhoKDY2Ray3pRpDbSPy7qjQK7+QFnnnAVAFaX661iJhIDdIHKOy0M/pRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ESFjITAuALhX+qLCpjvdP6owSb/3CvdTHPNMGjSpy28=;
 b=QMt6HJ6z6lyq2WMHlfLYJnGqcdfmQt6j/QR7ne57sxGACVLwfwuMzkRdh2ugUlZrS61sVoRMZE2RHpw0QYRYbGDamT9s2Ir7kOcHjCwzfCouOfNYI2KjzGzLuT1XjQdpPuo+4qwy7A1GNCIbPObaCxFHyquiT4khX4iObblusughGNi2zNT/vnTlBS02tuVbigzSj1dw6J3hVonJKU4UP9rhONaGdfhpwPIe6rjNmOeN4SQp7F5/tG6qpdhOS6lKtaWK1iWAdfXwUSQtBqDN39RK8YIpRS2qa7Mc8h+9Dbpd5W4P/57p12Kbo/iUQStkHxNMXGXjrckYkYL0DPa9aA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ESFjITAuALhX+qLCpjvdP6owSb/3CvdTHPNMGjSpy28=;
 b=5rRkGJWe1fz+fBtgZ3crQP0FZtzFm74xdAuLq64d+2LdwVDacgGrfcLWGHHidsn7qJVLd4k4/hZD/FtELjfyocpCkMkKyahX0wdGC0ZIERdqxk+CmzQxlQWbEqvGtRZBousj0Xj0+8PKMr+mFKMwOOLiiRQlox2gnUWFq3pa1hM=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3067.namprd12.prod.outlook.com (2603:10b6:5:115::10)
 by DM6PR12MB4579.namprd12.prod.outlook.com (2603:10b6:5:2ac::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.26; Thu, 20 May
 2021 14:30:23 +0000
Received: from DM6PR12MB3067.namprd12.prod.outlook.com
 ([fe80::5c8c:adff:ab42:9345]) by DM6PR12MB3067.namprd12.prod.outlook.com
 ([fe80::5c8c:adff:ab42:9345%6]) with mapi id 15.20.4129.035; Thu, 20 May 2021
 14:30:23 +0000
From: Graham Sider <Graham.Sider@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 4/6] drm/amd/pm: Add sienna cichlid throttler translation
Date: Thu, 20 May 2021 10:29:28 -0400
Message-Id: <20210520142930.8369-4-Graham.Sider@amd.com>
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
 15.20.4108.31 via Frontend Transport; Thu, 20 May 2021 14:30:22 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ab0c6f43-d340-430a-aaf0-08d91b9bcd80
X-MS-TrafficTypeDiagnostic: DM6PR12MB4579:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB45799991F5C314A266C5E5018A2A9@DM6PR12MB4579.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2331;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DEetIUoYTp7KarYj7XKGhxVVbfTF9TDCWF9tLhksdqKPkAa/sPodW/kgwwLU07B6LGJNdO05bvxviTHBue1ylJOJWDA+iFJP53J//1VgWv5RbItcytSgelU1MYpA7oE4sQ9kynfRqKwm8vBTEKsbtJH0qtqPvK/JT1+ccxmZmwYDlV2zIxT4ebx/C0D9i8SYEzoL/bbq5NAd20qYIJPTd5Ufj7Bgz+94pvv+hnnacEE/e8R45oXvYLl3JMNXqrJYoXsa/o7+gvWy1PKVFdIbrNH90iSOZlreIuGTHGIbvaE0y6vIt6oiJiAxzYQUA9wXMNXeMKKhlBruNnUPloaV+92nG361CBBuZRrr6AfDNJiuFM7idQiEmOW/NlM01tIqNbTVNYsdeA4g0E0z/r6aDXkDyYeQuNzJ/m8ujLkuvtSeUzJZxdii0MgbAsWk3yYMg+GhCugVm79xN5kFSTu96NTIxjtvYiR/DrcCuC1Spt3IJrDpI0vp069Ma+Od+MLmoFgyRAixIC2AIQcvkul++wNnNmROAQ73hFv7gkxBI4h202EHjQd0UyziAfTAjuhOEPaz5hASyQL/wg53mnT8JchpSPTetchoL7zGbnilVJuFVqo5fOyS7FO1flAFNPierwapbY8xU+8imDvcdqrrXw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3067.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(136003)(366004)(346002)(376002)(396003)(2906002)(52116002)(38350700002)(7696005)(8936002)(38100700002)(316002)(66946007)(83380400001)(6916009)(8676002)(1076003)(478600001)(66556008)(66476007)(6486002)(86362001)(5660300002)(956004)(36756003)(2616005)(4326008)(16526019)(186003)(26005);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?A0k6ab6Q4dUQg1QPllc/9/qg/UfImpKPm0vN0USVj0IgeEB0Nw0HABeM2tfH?=
 =?us-ascii?Q?xpkgytTzyQ06qJwpS64JOHGOLLN/Psu9nQGSwLsCrpQvTkx+2eh4ycKnkX0Q?=
 =?us-ascii?Q?I7MM2ks41lwMVpbBzcgwJ3hJG47X5tnb9pThy0SD4VqSDY0Z7NtyVI6rxL31?=
 =?us-ascii?Q?KPDe2Eg808v838YOhqy9e7ypwA2ZdgkFecicSztRaKubf0VHCznABZVYT709?=
 =?us-ascii?Q?L1FqIhifSnN7+11inqbSuylApDba2RxHtv1k4DZ15FsyDo1jKlzcmv2xZ1Ik?=
 =?us-ascii?Q?3D0rlhxSphPSLCKmgZAp/YtiRkfD2KsMp/3xdFF7lasezqn1hg5ODIBizEGo?=
 =?us-ascii?Q?cDNCSfOIJCkH9pyzCb1Sha6W9g8pG8ltIYjQyFgYIzWccrjOcyccuig0Ew1m?=
 =?us-ascii?Q?eRM18DWt6omyLK4mTEopxgk/NVW+dgHlh+S0NpK65MDXqMK7wbx+EX6X873b?=
 =?us-ascii?Q?glYKH/RZbteUly0jiVcThM/HBIVY/rteCog1hjHO22wsuAZeCK3Ijs/viqXX?=
 =?us-ascii?Q?2Qe2q0fs5gMGG5SKqgnjtFeOCUiBXk0xJ55IR/ZGveRT0pGV7WBH8z7GvY9U?=
 =?us-ascii?Q?myPcqSutnRAm16EjKYt3PA0UwhTBOihuWNB9HDN49NP4XAAZc/YT5h/bgn7l?=
 =?us-ascii?Q?8rerUPvZtntcHJ7dMEpqWx/HR8uEHubefnNvoIFyRJ7PJORy5ZRcwaww4XmE?=
 =?us-ascii?Q?vkRzQdUI1bIaY03SULeCTgykc9ouAkHDv0iz8ET6S7/GjwfxNrQXAEInC0mm?=
 =?us-ascii?Q?7UeSQ7dw+DAHE5RsVKpCXk8upE1zyAwuWQfnFFTY8Ek42Aks9KOwCot8KaKW?=
 =?us-ascii?Q?BzRRD7Lb4sO0nd0tHb7FKGfn/s45io9501rAxEgNmgS7/LE3bQPkttmfcE4L?=
 =?us-ascii?Q?Jfa1CprV4YG2nmsJ5Xc3c0HUNI3FIYlur/6xBd/YJTpq6+ZkxFyiau+D5YbJ?=
 =?us-ascii?Q?BB+YiETuCNXZ6HteABI0tcrcTIzC66e5Mp29ByVYjVqktzQRbDtN/HuQrzg4?=
 =?us-ascii?Q?IKNVVaRxpul5opJMeqa5G+eNHmSH8oHoik0gqNZZ0xUmZvZ5EqYvyb9Y9KZO?=
 =?us-ascii?Q?qjaZanFuHYHXEr0f4j+Ul+QDmih2OoukXadr8Nktq5v93S1y8oqRb1k5t53a?=
 =?us-ascii?Q?YSPtXz0PZvQWN9NQOgDZ8sOLho9JX6JQJ+cRAXKpT3c4pZZjputre7uevjgu?=
 =?us-ascii?Q?tzxBqBiGCNv5XcsWxm/NsOm5LX9thn5JBEekRl4Rkjqoy7b+U+tn2lLitXqi?=
 =?us-ascii?Q?0tut+2HhKZHc7rZLhXjHg/u89kLpXITynRIQ4iRyE9W+d6ADF1/UfOiyixfm?=
 =?us-ascii?Q?Y1BtD8cPmZA2FDihFg45dUa3?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ab0c6f43-d340-430a-aaf0-08d91b9bcd80
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3067.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2021 14:30:23.2987 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +vfNL3cwCUl2XLGAPN4+HVDan4QPRNH5Dml100g8KR7Vc0XcF7Zj30r2Zo44X2X5xIg82XhcIBgRZj+yWv3/dg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4579
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
sienna cichlid.
---
 .../amd/pm/swsmu/smu11/sienna_cichlid_ppt.c   | 48 ++++++++++++++++++-
 1 file changed, 46 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
index 75acdb80c499..023b10306c3e 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
@@ -453,6 +453,49 @@ static int sienna_cichlid_tables_init(struct smu_context *smu)
 	return -ENOMEM;
 }
 
+static uint32_t sienna_cichlid_get_indep_throttler_status(
+					unsigned long dep_throttler_status)
+{
+	unsigned long indep_throttler_status = 0;
+
+	__assign_bit(INDEP_THROTTLER_TEMP_EDGE_BIT, &indep_throttler_status,
+		  test_bit(THROTTLER_TEMP_EDGE_BIT, &dep_throttler_status));
+	__assign_bit(INDEP_THROTTLER_TEMP_HOTSPOT_BIT, &indep_throttler_status,
+		  test_bit(THROTTLER_TEMP_HOTSPOT_BIT, &dep_throttler_status));
+	__assign_bit(INDEP_THROTTLER_TEMP_MEM_BIT, &indep_throttler_status,
+		  test_bit(THROTTLER_TEMP_MEM_BIT, &dep_throttler_status));
+	__assign_bit(INDEP_THROTTLER_TEMP_VR_GFX_BIT, &indep_throttler_status,
+		  test_bit(THROTTLER_TEMP_VR_GFX_BIT, &dep_throttler_status));
+	__assign_bit(INDEP_THROTTLER_TEMP_VR_MEM_BIT, &indep_throttler_status,
+		  test_bit(THROTTLER_TEMP_VR_MEM0_BIT, &dep_throttler_status) ||
+		  test_bit(THROTTLER_TEMP_VR_MEM1_BIT, &dep_throttler_status));
+	__assign_bit(INDEP_THROTTLER_TEMP_VR_SOC_BIT, &indep_throttler_status,
+		  test_bit(THROTTLER_TEMP_VR_SOC_BIT, &dep_throttler_status));
+	__assign_bit(INDEP_THROTTLER_TEMP_LIQUID_BIT, &indep_throttler_status,
+		  test_bit(THROTTLER_TEMP_LIQUID0_BIT, &dep_throttler_status) ||
+		  test_bit(THROTTLER_TEMP_LIQUID1_BIT, &dep_throttler_status));
+	__assign_bit(INDEP_THROTTLER_TDC_GFX_BIT, &indep_throttler_status,
+		  test_bit(THROTTLER_TDC_GFX_BIT, &dep_throttler_status));
+	__assign_bit(INDEP_THROTTLER_TDC_SOC_BIT, &indep_throttler_status,
+		  test_bit(THROTTLER_TDC_SOC_BIT, &dep_throttler_status));
+	__assign_bit(INDEP_THROTTLER_PPT0_BIT, &indep_throttler_status,
+		  test_bit(THROTTLER_PPT0_BIT, &dep_throttler_status));
+	__assign_bit(INDEP_THROTTLER_PPT1_BIT, &indep_throttler_status,
+		  test_bit(THROTTLER_PPT1_BIT, &dep_throttler_status));
+	__assign_bit(INDEP_THROTTLER_PPT2_BIT, &indep_throttler_status,
+		  test_bit(THROTTLER_PPT2_BIT, &dep_throttler_status));
+	__assign_bit(INDEP_THROTTLER_PPT3_BIT, &indep_throttler_status,
+		  test_bit(THROTTLER_PPT3_BIT, &dep_throttler_status));
+	__assign_bit(INDEP_THROTTLER_FIT_BIT, &indep_throttler_status,
+		  test_bit(THROTTLER_FIT_BIT, &dep_throttler_status));
+	__assign_bit(INDEP_THROTTLER_PPM_BIT, &indep_throttler_status,
+		  test_bit(THROTTLER_PPM_BIT, &dep_throttler_status));
+	__assign_bit(INDEP_THROTTLER_APCC_BIT, &indep_throttler_status,
+		  test_bit(THROTTLER_APCC_BIT, &dep_throttler_status));
+
+	return (uint32_t)indep_throttler_status;
+}
+
 static int sienna_cichlid_get_smu_metrics_data(struct smu_context *smu,
 					       MetricsMember_t member,
 					       uint32_t *value)
@@ -542,7 +585,7 @@ static int sienna_cichlid_get_smu_metrics_data(struct smu_context *smu,
 			SMU_TEMPERATURE_UNITS_PER_CENTIGRADES;
 		break;
 	case METRICS_THROTTLER_STATUS:
-		*value = metrics->ThrottlerStatus;
+		*value = sienna_cichlid_get_indep_throttler_status(metrics->ThrottlerStatus);
 		break;
 	case METRICS_CURR_FANSPEED:
 		*value = metrics->CurrFanSpeed;
@@ -3666,7 +3709,8 @@ static ssize_t sienna_cichlid_get_gpu_metrics(struct smu_context *smu,
 	gpu_metrics->current_vclk1 = metrics->CurrClock[PPCLK_VCLK_1];
 	gpu_metrics->current_dclk1 = metrics->CurrClock[PPCLK_DCLK_1];
 
-	gpu_metrics->throttle_status = metrics->ThrottlerStatus;
+	gpu_metrics->throttle_status =
+			sienna_cichlid_get_indep_throttler_status(metrics->ThrottlerStatus);
 
 	gpu_metrics->current_fan_speed = metrics->CurrFanSpeed;
 
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
