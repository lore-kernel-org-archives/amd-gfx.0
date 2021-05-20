Return-Path: <SRS0=8Dg8=KP=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFCBEC433B4
	for <amd-gfx@archiver.kernel.org>; Thu, 20 May 2021 14:30:34 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 69F91610A8
	for <amd-gfx@archiver.kernel.org>; Thu, 20 May 2021 14:30:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 69F91610A8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3862A6EEA1;
	Thu, 20 May 2021 14:30:33 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2058.outbound.protection.outlook.com [40.107.92.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2CEF06E40C
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 May 2021 14:30:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Jju7nqaB5rf7HE8YH3vQ+dTn0OkOorMndswGCFisssg5xdt5GBxv8rjYvqziX+Ej3WCInGYxLyN8UIN+wRchg5Gm2VPd5EQ4aEkZIR2pS1Xpt0D/5xPWi7w/vSORjuID8/2n5l6UcrxUF3WHYkJwFlqKyCfkLc38DZIAJGSgAn3X9CBwahINjC+vPt8FyFnfGyIcrpY5cRiWoYhkWGzvtWplbVRQZYEB9CYIPDVCi4VNzRHn/Mzdv6bydgCJ4L/NxGNfjSVnGBcVNy5Kzd4VpJ971zNT+nNkNW0MJemTqmlbGbMydnnw6RSyXpTiFXbdTPsRVrFydwFqS3r8M1+O6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vVfqy0lvfHG6ioavxfNrN0T+ukhHAyk1QVMr8RoSnH8=;
 b=Svf39tQ5OIYz9hs9KkQdM6PMJcmzl4gNt3yEF1S89C9x9Pp3dkUTszo2aW09ZnChCe/AOis2Vo0WDn4YVb+fddpmjrHrdXMC8gIU6ftfCo9wPaU3zsaEU96ZFTRwnMa6+2EIq2f5wFgnFudktRfUKku6+6LoR/ThSeqEhSYZP4GJY88CM+5fYOfs5UgaPt56WvXH5Hgjjdmhd2kbomv0ENhJd8P94mJwbLt0QpHx9lRQUK+6T7nRaYa7ISZBS5yFvivfVt9YGkyC21FBYf93PTFzkZjnowMT2mhakFNdM5diG5uEvM8DkmoqGjpc87/F6q7QwLM/WhuruMbTB/t3Yg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vVfqy0lvfHG6ioavxfNrN0T+ukhHAyk1QVMr8RoSnH8=;
 b=kCDjIxENQqW69IrpwhISq+U02z1RRV8RNd28QiI91WEKwgeI0awClzK5usa3W65Emngi+Z5vynXb0C+6F/IJfnXWb4pEjTLmFC46UlFbn+seZtnmnRju0459ywA8cCQV5HgJ08WGDAbLSiqdv/lwIcf40M4dO58g0s6duepibY0=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3067.namprd12.prod.outlook.com (2603:10b6:5:115::10)
 by DM6PR12MB4579.namprd12.prod.outlook.com (2603:10b6:5:2ac::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.26; Thu, 20 May
 2021 14:30:21 +0000
Received: from DM6PR12MB3067.namprd12.prod.outlook.com
 ([fe80::5c8c:adff:ab42:9345]) by DM6PR12MB3067.namprd12.prod.outlook.com
 ([fe80::5c8c:adff:ab42:9345%6]) with mapi id 15.20.4129.035; Thu, 20 May 2021
 14:30:21 +0000
From: Graham Sider <Graham.Sider@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 2/6] drm/amd/pm: Add arcturus throttler translation
Date: Thu, 20 May 2021 10:29:26 -0400
Message-Id: <20210520142930.8369-2-Graham.Sider@amd.com>
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
 15.20.4108.31 via Frontend Transport; Thu, 20 May 2021 14:30:20 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3425c9e7-87ef-4b52-07c2-08d91b9bcc75
X-MS-TrafficTypeDiagnostic: DM6PR12MB4579:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB4579B856EB15F3E8209D3A1D8A2A9@DM6PR12MB4579.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2512;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WkW0aoBarlvvr1++jcx+MtfcZ8gUHNOHMZTtaOOKQx1yqvaKTccY0dp4rWAXFuq0DVO2W4V8p/N5MV30PSYGmpy88R8jXJ3otLfOe4HQluw2UMRqfy68mZoHdwqYTsVppXwV9EM4oLgCg0mo73CGB06BKEEfiLPzBxAh7VV6vJLylKsEzoS/wGJQfZIp9jN0U5DUiSPYSilE8LnDcyQdzCWPl/tQPUWCxU74slYBJSb/4N6fgWLKg/7uyWVacZQk98NNnBSuE0QEckYNxBV05SVQG0quo3D9vmkeuetCDmdDmgLBiQzPn5oma2u3o99539g77OCPTlyt7m+nPE14n+TJfT/9wc67/SlZO03ctukX94xHcJwJCUc9n283JkIos0t6t12xSYmto0V3XdwdtxDN1Mb3Xzri0qfi7zH3OFRwDpfx14+eUSd3R4T+Pf2IJXtuhepeJfLb78MIv2Bcq7erEY4QA2oPuOKddvo7J1x/nyawuSx90jm0c8vRWRJ5IrXGAftiHTsZsrn0TOsw9ynv/HXv30l9JZrXChBkkmLgxKmg5NPfai4vtoyYx5cu7M6v5BRyblO7uybMVlLsbWSeX1Ora1YNW3jeFxON40wYHd3NK9IdQH6sUCTiSyglwjbP4J3kl4ViAYFAf7gUGA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3067.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(136003)(366004)(346002)(376002)(396003)(2906002)(52116002)(38350700002)(7696005)(8936002)(38100700002)(316002)(66946007)(83380400001)(6916009)(8676002)(1076003)(478600001)(66556008)(66476007)(6486002)(86362001)(5660300002)(956004)(36756003)(2616005)(4326008)(16526019)(186003)(26005);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?7SqwGUptud2EH7xk5/2Gae8hRbIOR2VZL+Az4c48ZgqP1J+s5z3WKX+Ec7QX?=
 =?us-ascii?Q?B3L0ISteYkaKOx7AvoQai4kzEnJke4eSe+UlqFM9vm/a+slFhXiF3sYzlaah?=
 =?us-ascii?Q?TqTedD4TLEkMrZoWnZ7U5LA6UQ/0h37Kv2yq9jXyVs9iqQow5X+5zVnzf+F3?=
 =?us-ascii?Q?CyN+kkcitTrfs27Kf65JaHyi4V9ESAfjPImwch4v2mmnyXrlZOT7Va8xyq39?=
 =?us-ascii?Q?0s8/UkdEZ1DWB524rL5/0YnxuJGCfneZwCblYSp8iL5hvuE1NUbGssRtBWvk?=
 =?us-ascii?Q?z89JX2kQQYiLtU2YIc4MbiC/I4mmAF0YCTqZ7POeVe3htMKZEeD58ktl0dSd?=
 =?us-ascii?Q?KixsUKHRirtvtcHJIuIDheVYzNhdEt3S0KUaAsyWEGodpypap/RLrZ1qABae?=
 =?us-ascii?Q?uQRXG4qPuLFuJr1A58lrGkjnYZVzX8AoWkqKazzVW7ObzYPDjkoXKBHlDl9N?=
 =?us-ascii?Q?DPvNKOvB/Z+vNRld/tqAmMf9Seertyywo9EyBh2P4OllJiM78ajwb5mn7jle?=
 =?us-ascii?Q?1aNhN4MXgOl4WwmDmtyQtZXL+Z0UIL9tHQTj67763G/y6c75BbourX9SnhCm?=
 =?us-ascii?Q?7CLGbmHvzLp+mcDAZfqeSQdk/o8Yb9aXIO2qp5KBz62LlAlvpxLmZagxcoEa?=
 =?us-ascii?Q?+JvSJoPq+st8OqfH9rjUFdUniRNdwvaEEd3hYOC55BAODCZm80REBCtrUjov?=
 =?us-ascii?Q?X3OrybdBGq5QjWiS9twZ7nO+iORStOlu0lz+7/twMiNiGZgcWoaTQqY69cqs?=
 =?us-ascii?Q?fl1UhSW2MEr1XhzFdF5R9SwbP+fuMO0fVmqpc+tI0Xxz2CpyoVlMASHGEJ4h?=
 =?us-ascii?Q?J+DWCj0a+ZP4PC/atTR/+DbFZrAqUy4F3te9gv+WhVQp+/09Mz8VEPkxZQ1z?=
 =?us-ascii?Q?mc1XZh5+gdI3HkQeERFJoPw4Inu3FlxfbTZTXWNtUCsQNpFe+1VrOxBnBy6u?=
 =?us-ascii?Q?axcfzPvoSUs6fyLKDWpRdyz8QDA4+BVPh7E4KuAwYtaW0fNlflJ13+9DZqYH?=
 =?us-ascii?Q?Dc4vrzzo859C9r+sFxFd1xoDlCo3YsH8koa1LTQkqtsWTxUwa7TfcHMHfsPF?=
 =?us-ascii?Q?nTAZ1OHMUuss7GIA0Jw8cWWfkCPwReYOFVNDIxLayQwHw8Qalb0dJGZki4OV?=
 =?us-ascii?Q?A1MPlWr3tHSxHEPIBOoud0sKsPvCqas3UYQkqTd1BZIBCOBK4XVdGe9TAvno?=
 =?us-ascii?Q?wPQBvYIRJZP+KnU0ZjK6R/9IeIqlUaxjOAHPqnEOE+HJY+PFdRooGGLXocdB?=
 =?us-ascii?Q?+OJpynwVCFwFp/o4eNZP3lV9eLc/OD6lgm2ati9EAYxaZQLF8N50gcaRuDoY?=
 =?us-ascii?Q?HJjdROs0IEwbMrmEpDIe20kh?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3425c9e7-87ef-4b52-07c2-08d91b9bcc75
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3067.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2021 14:30:21.5337 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aSymYnMv5VwitDV1fHid+bs7VdRF7UR5Jx+r2IF/dW7YYpgSIvwECQ++EduaM7HM/+sOBmI2EOUD4DpUL5bt5Q==
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
arcturus.
---
 .../gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c | 62 ++++++++++++++++---
 1 file changed, 53 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
index 1735a96dd307..7c01c0bf2073 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
@@ -540,6 +540,49 @@ static int arcturus_freqs_in_same_level(int32_t frequency1,
 	return (abs(frequency1 - frequency2) <= EPSILON);
 }
 
+static uint32_t arcturus_get_indep_throttler_status(
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
+		  test_bit(THROTTLER_TEMP_VR_MEM_BIT, &dep_throttler_status));
+	__assign_bit(INDEP_THROTTLER_TEMP_VR_SOC_BIT, &indep_throttler_status,
+		  test_bit(THROTTLER_TEMP_VR_SOC_BIT, &dep_throttler_status));
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
+	__assign_bit(INDEP_THROTTLER_PPM_BIT, &indep_throttler_status,
+		  test_bit(THROTTLER_PPM_BIT, &dep_throttler_status));
+	__assign_bit(INDEP_THROTTLER_FIT_BIT, &indep_throttler_status,
+		  test_bit(THROTTLER_FIT_BIT, &dep_throttler_status));
+	__assign_bit(INDEP_THROTTLER_APCC_BIT, &indep_throttler_status,
+		  test_bit(THROTTLER_APCC_BIT, &dep_throttler_status));
+	__assign_bit(INDEP_THROTTLER_VRHOT0_BIT, &indep_throttler_status,
+		  test_bit(THROTTLER_VRHOT0_BIT, &dep_throttler_status));
+	__assign_bit(INDEP_THROTTLER_VRHOT1_BIT, &indep_throttler_status,
+		  test_bit(THROTTLER_VRHOT1_BIT, &dep_throttler_status));
+
+	return (uint32_t)indep_throttler_status;
+}
+
 static int arcturus_get_smu_metrics_data(struct smu_context *smu,
 					 MetricsMember_t member,
 					 uint32_t *value)
@@ -629,7 +672,7 @@ static int arcturus_get_smu_metrics_data(struct smu_context *smu,
 			SMU_TEMPERATURE_UNITS_PER_CENTIGRADES;
 		break;
 	case METRICS_THROTTLER_STATUS:
-		*value = metrics->ThrottlerStatus;
+		*value = arcturus_get_indep_throttler_status(metrics->ThrottlerStatus);
 		break;
 	case METRICS_CURR_FANSPEED:
 		*value = metrics->CurrFanSpeed;
@@ -2213,13 +2256,13 @@ static const struct throttling_logging_label {
 	uint32_t feature_mask;
 	const char *label;
 } logging_label[] = {
-	{(1U << THROTTLER_TEMP_HOTSPOT_BIT), "GPU"},
-	{(1U << THROTTLER_TEMP_MEM_BIT), "HBM"},
-	{(1U << THROTTLER_TEMP_VR_GFX_BIT), "VR of GFX rail"},
-	{(1U << THROTTLER_TEMP_VR_MEM_BIT), "VR of HBM rail"},
-	{(1U << THROTTLER_TEMP_VR_SOC_BIT), "VR of SOC rail"},
-	{(1U << THROTTLER_VRHOT0_BIT), "VR0 HOT"},
-	{(1U << THROTTLER_VRHOT1_BIT), "VR1 HOT"},
+	{(1U << INDEP_THROTTLER_TEMP_HOTSPOT_BIT), "GPU"},
+	{(1U << INDEP_THROTTLER_TEMP_MEM_BIT), "HBM"},
+	{(1U << INDEP_THROTTLER_TEMP_VR_GFX_BIT), "VR of GFX rail"},
+	{(1U << INDEP_THROTTLER_TEMP_VR_MEM_BIT), "VR of HBM rail"},
+	{(1U << INDEP_THROTTLER_TEMP_VR_SOC_BIT), "VR of SOC rail"},
+	{(1U << INDEP_THROTTLER_VRHOT0_BIT), "VR0 HOT"},
+	{(1U << INDEP_THROTTLER_VRHOT1_BIT), "VR1 HOT"},
 };
 static void arcturus_log_thermal_throttling_event(struct smu_context *smu)
 {
@@ -2314,7 +2357,8 @@ static ssize_t arcturus_get_gpu_metrics(struct smu_context *smu,
 	gpu_metrics->current_vclk0 = metrics.CurrClock[PPCLK_VCLK];
 	gpu_metrics->current_dclk0 = metrics.CurrClock[PPCLK_DCLK];
 
-	gpu_metrics->throttle_status = metrics.ThrottlerStatus;
+	gpu_metrics->throttle_status =
+			arcturus_get_indep_throttler_status(metrics.ThrottlerStatus);
 
 	gpu_metrics->current_fan_speed = metrics.CurrFanSpeed;
 
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
