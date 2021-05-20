Return-Path: <SRS0=8Dg8=KP=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F403C43460
	for <amd-gfx@archiver.kernel.org>; Thu, 20 May 2021 14:30:38 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3935861002
	for <amd-gfx@archiver.kernel.org>; Thu, 20 May 2021 14:30:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3935861002
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C9FE16E303;
	Thu, 20 May 2021 14:30:37 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2058.outbound.protection.outlook.com [40.107.92.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 33E9B6E303
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 May 2021 14:30:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VkJq1G1o+pxF3tlG3F5fl7ra/N0BU//0bDGcDxxhJ4kptvLx3KE3PVMmWLUKFeQhzEnTWjFCj80BRAwTRzAwj90mnsQ3r8leoWPQ+uq9o/qFRp47myH3zcrsto2+qR6iGozKn0oTRJrQNZroHv/RLtVZWehDS8bvVpGRfElONqSx0uU6zrNqrWBeLh9stmro3NW5kp2KPOjBGlNz57A600U4tca/l3WeX40K6Sp4n16BzmklZMdm8o1QdVURZRunsFTH9LaoPWVmqoNI8CMijj55AScZyDqXGA//tJFuiYTMH2daXnYLKFdHkHSqQVKrimcvF3uWFTA+53z6KrjQIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lDngvyicWaX3cseGYjdO5N9WulJV7qsDlrScSGbdN3k=;
 b=mh6dNiBLvkTHPA+Rog6u1YZkmGyOjeMBctUvAMbU4y9kP7P9vsIqiR2gZHh3zE3NexB19AdXmD0yqF5iZ3d6EgQZz3qDXl5mrGyBUTU2rMhSvaTqxQpGE/3/IpRBfQBcSofvDBnDakHy7jf+XCjiNDsZdjXAur4BufziHKOUW4d3HyMB9MpLKAKlsCwT+lg8jTYuk02cDwAJh/VvHXhWm3LewIFd8J42yeBfvV3miqPlWDZEL/QMUsS91bhbglTiKkdRAhKaokMc2olzQ9dR7ydaM1gXKAeivMH39r5sft+T1qeg/5RENBzfbW+O7GaVzPksH0d+fwgG3Nlcj43ctw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lDngvyicWaX3cseGYjdO5N9WulJV7qsDlrScSGbdN3k=;
 b=QqYleBLfxbPeQox//ukrM2jmv/0glisUf+f5pa0jtYfcvA2jekppkI2p+BoopdIIyJ9c8MUpG6NAN6/sVkuHLc020APLUppXTA/yV1/cJgMW4dULS/8uTzfS1GMmKu3rBk/jVjVwlI9NRY4uOVdxL3DmrwAJlCRu4ue5a7gmNPM=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3067.namprd12.prod.outlook.com (2603:10b6:5:115::10)
 by DM6PR12MB4579.namprd12.prod.outlook.com (2603:10b6:5:2ac::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.26; Thu, 20 May
 2021 14:30:25 +0000
Received: from DM6PR12MB3067.namprd12.prod.outlook.com
 ([fe80::5c8c:adff:ab42:9345]) by DM6PR12MB3067.namprd12.prod.outlook.com
 ([fe80::5c8c:adff:ab42:9345%6]) with mapi id 15.20.4129.035; Thu, 20 May 2021
 14:30:25 +0000
From: Graham Sider <Graham.Sider@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 6/6] drm/amd/pm: Add aldebaran throttler translation
Date: Thu, 20 May 2021 10:29:30 -0400
Message-Id: <20210520142930.8369-6-Graham.Sider@amd.com>
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
 15.20.4108.31 via Frontend Transport; Thu, 20 May 2021 14:30:24 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2b4f3c79-9f25-4df0-0900-08d91b9bce88
X-MS-TrafficTypeDiagnostic: DM6PR12MB4579:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB4579DA84499F3682E2328F6C8A2A9@DM6PR12MB4579.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2512;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YSE/azGHIdfjtPtohLeLWoQ7/Oj3xFsXnD7B3PAAKFxXasdBTBwFfDhinS5sOymg1IhTVrW5j+/V/8uFTwKuwnCD3UFwFk9OoYn1xup0SXyPlpylGCarKG1ikpx74wIJG2xy72fbAkuWkpL5G+CM5rdOLK6e/Nfssq/Q34WitYxF15sxc0kwyItgpj8qtAfD5+TXLfnTOGTOiNEh5dumUxAxi4cXRos1dQ5p4yMWvmViXuvxdVdDU0MYcIzvOY1ejwHf0c2ceVX8X1snmNg7H+TRp0viY5mqpzh5+8t5iZoRBxmB7cChgs3O/lurhJ/K5vqefQsa4i3SmjBtqnIMnlZNTXr8ANRl975XR5ikzQzKlXbOvdPI3KrQdxTCimcGH6YP/e/8FeHtuTyxE7ToUE8l6hHq0ZRYP/uJJrSN+gpvbJM+kGuIbZPm/JcEq+UydlexlBNfwaQjXkXLiAFGjg5S1eycpnIVfEh1wIn13jGWy/dQyK/eXI+Rt5QoNPIHYSUoAqtXcL7HcY9EEUto/tYhIJs1nhkbJpVRoJdSZEOTXPpWW9jA2+nTzzoCgR+6sxtbu9JHU/rsodY2IE1A592RsA0vNuNdYc4Os+7na+M5YbBvR8H2dIf1AxIsH2BKOmP2P2iDyvFJikErGD4QpQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3067.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(136003)(366004)(346002)(376002)(396003)(2906002)(52116002)(38350700002)(7696005)(8936002)(38100700002)(316002)(66946007)(83380400001)(6916009)(8676002)(1076003)(478600001)(66556008)(66476007)(6486002)(86362001)(5660300002)(956004)(36756003)(2616005)(4326008)(16526019)(186003)(6666004)(26005);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?0OUndlz2BCJACgF1hXmxaADf9dVVxy592y6wLHKBVaA9owJ2VAERAmop3oXI?=
 =?us-ascii?Q?HzQMowIALDECED8NEoFsdzL8/1TjA+fJnyI3Q0CyR4bk4gfbK6pNZe/tY5FT?=
 =?us-ascii?Q?dHYf1cb6+8EXR7bikaIx4TLgfunRvClJSkciR7lsS/a9z1SGXW/Q34SvkMoq?=
 =?us-ascii?Q?pAtI3g+wgEAJZRGo2bZxHsvnFp38iD5Xl+XCuvIJUJLdvwM00dhK3raLJ6r9?=
 =?us-ascii?Q?RJiHQsUNk1jNevaD74MV1fPlbn7tFO1RVz5R1f8in5FzZQJrXjxUcftvB/1N?=
 =?us-ascii?Q?zODsaAQulY3u8cD2oIX8jMFCmQDnZkAhZZP3ocJ5cahXWsLmZpy0FuCiAp8g?=
 =?us-ascii?Q?6qBJBjOUoj3pVSIABn2iBpJk2m399EnLA82coOus/FcuVqwkjCiHKWj5UKqG?=
 =?us-ascii?Q?VNOd37H7BFWI4QZ7Igt1muLbk5lFdpB3oXsCcI22j+CIPHJsw2119PORPmiC?=
 =?us-ascii?Q?Tm7oOqi4AXwguJjGRpTkeAzkzng+nAYb6lffzvGTBvhc9Kq/7rC1bdjrY0G2?=
 =?us-ascii?Q?szaG1tF6tdjcslEvvE1DfD5tjhmcq29tOSLW7LyrpaIx3dddrZ3HXnXJUFjR?=
 =?us-ascii?Q?B3bQIspPuH55x3lGbLNBwzZz28kLdpxlvP5hKapfc4rlBVcadvHpmphZdB2H?=
 =?us-ascii?Q?RV9sGjJxyjj+sYGelvaWrKoUQu5kCgy2dgWwPDKzZ/rpWrnvV2E0U65jLgCm?=
 =?us-ascii?Q?iI1Q+WfbRaaSBzs8X1Vjl0y12bJ1rV8MmcBqua0GHAervEc8PwyV+jGElZGy?=
 =?us-ascii?Q?JIgyOG7a5uv61dHhecUJ75KXW9epkNZ3BkBrKzieYjslJZeCXQ7nUxG1NrlS?=
 =?us-ascii?Q?ptDDgesQWmac8HERuY2Lyge+igmoyoP7Z0UH12F4V+vOJ1EcOCLDxV5yMVzs?=
 =?us-ascii?Q?+hyOxl8449j7+DycPIzuVIy2rTytR6Wy10gEAcgIt66FABu31aVQO1zzzUjN?=
 =?us-ascii?Q?2Tn9FKLje3zWMZzNQj0h2QlEQpetSVzteL9KKUW+IO2BbCI0lk+lV+5FxOm+?=
 =?us-ascii?Q?S3dXLc1HmMpPBHAszwZjPqB9xpEfYIycvhmINCo6O16A13pu13+EbKVpx8iV?=
 =?us-ascii?Q?h3Nntn32B7xYBJ5BCAiZCxR/MEpO6HKuuce49eZseHsH3LPnN1c8dwU+X1L3?=
 =?us-ascii?Q?zpJ32pyNeIa25/2GC85BxZBK9l/hK7TYy2NUXMj2iLrIOBrx4sQ1WRVKv7er?=
 =?us-ascii?Q?KpIG4upxZcAq3OobB+Pxp02/QZXJpgR7ZDnk8rWKBVgUqHHPWYelyKB5qtsK?=
 =?us-ascii?Q?QizX9RD8wVTtF+snh3vqfEAeR3r7XWT40aOJDsU6ulTfwodkGKZR7b6eeUgy?=
 =?us-ascii?Q?TLju3O0CrE7L17WGpiOr2WIG?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b4f3c79-9f25-4df0-0900-08d91b9bce88
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3067.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2021 14:30:25.0187 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tAmHUvPB18S5oJmJuWJ4pnSNUN1UjRB7w03bve/wE/nDVv5vPsQarAiU69/RK+7pMi+DaodUOPyt0vmxqnjvjA==
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
aldebaran.
---
 .../drm/amd/pm/swsmu/smu13/aldebaran_ppt.c    | 44 ++++++++++++++++---
 1 file changed, 38 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
index fb744f3e17d7..1281c74980b7 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
@@ -511,6 +511,37 @@ static int aldebaran_freqs_in_same_level(int32_t frequency1,
 	return (abs(frequency1 - frequency2) <= EPSILON);
 }
 
+static uint32_t aldebaran_get_indep_throttler_status(
+					unsigned long dep_throttler_status)
+{
+	unsigned long indep_throttler_status = 0;
+
+	__assign_bit(INDEP_THROTTLER_PPT0_BIT, &indep_throttler_status,
+		  test_bit(THROTTLER_PPT0_BIT, &dep_throttler_status));
+	__assign_bit(INDEP_THROTTLER_PPT1_BIT, &indep_throttler_status,
+		  test_bit(THROTTLER_PPT1_BIT, &dep_throttler_status));
+	__assign_bit(INDEP_THROTTLER_TDC_GFX_BIT, &indep_throttler_status,
+		  test_bit(THROTTLER_TDC_GFX_BIT, &dep_throttler_status));
+	__assign_bit(INDEP_THROTTLER_TDC_SOC_BIT, &indep_throttler_status,
+		  test_bit(THROTTLER_TDC_SOC_BIT, &dep_throttler_status));
+	__assign_bit(INDEP_THROTTLER_TDC_HBM_BIT, &indep_throttler_status,
+		  test_bit(THROTTLER_TDC_HBM_BIT, &dep_throttler_status));
+	__assign_bit(INDEP_THROTTLER_TEMP_GPU_BIT, &indep_throttler_status,
+		  test_bit(THROTTLER_TEMP_GPU_BIT, &dep_throttler_status));
+	__assign_bit(INDEP_THROTTLER_TEMP_MEM_BIT, &indep_throttler_status,
+		  test_bit(THROTTLER_TEMP_MEM_BIT, &dep_throttler_status));
+	__assign_bit(INDEP_THROTTLER_TEMP_VR_GFX_BIT, &indep_throttler_status,
+		  test_bit(THROTTLER_TEMP_VR_GFX_BIT, &dep_throttler_status));
+	__assign_bit(INDEP_THROTTLER_TEMP_VR_SOC_BIT, &indep_throttler_status,
+		  test_bit(THROTTLER_TEMP_VR_SOC_BIT, &dep_throttler_status));
+	__assign_bit(INDEP_THROTTLER_TEMP_VR_MEM_BIT, &indep_throttler_status,
+		  test_bit(THROTTLER_TEMP_VR_MEM_BIT, &dep_throttler_status));
+	__assign_bit(INDEP_THROTTLER_APCC_BIT, &indep_throttler_status,
+		  test_bit(THROTTLER_APCC_BIT, &dep_throttler_status));
+
+	return (uint32_t)indep_throttler_status;
+}
+
 static int aldebaran_get_smu_metrics_data(struct smu_context *smu,
 					  MetricsMember_t member,
 					  uint32_t *value)
@@ -591,7 +622,7 @@ static int aldebaran_get_smu_metrics_data(struct smu_context *smu,
 			SMU_TEMPERATURE_UNITS_PER_CENTIGRADES;
 		break;
 	case METRICS_THROTTLER_STATUS:
-		*value = metrics->ThrottlerStatus;
+		*value = aldebaran_get_indep_throttler_status(metrics->ThrottlerStatus);
 		break;
 	default:
 		*value = UINT_MAX;
@@ -1645,10 +1676,10 @@ static const struct throttling_logging_label {
 	uint32_t feature_mask;
 	const char *label;
 } logging_label[] = {
-	{(1U << THROTTLER_TEMP_MEM_BIT), "HBM"},
-	{(1U << THROTTLER_TEMP_VR_GFX_BIT), "VR of GFX rail"},
-	{(1U << THROTTLER_TEMP_VR_MEM_BIT), "VR of HBM rail"},
-	{(1U << THROTTLER_TEMP_VR_SOC_BIT), "VR of SOC rail"},
+	{(1U << INDEP_THROTTLER_TEMP_MEM_BIT), "HBM"},
+	{(1U << INDEP_THROTTLER_TEMP_VR_GFX_BIT), "VR of GFX rail"},
+	{(1U << INDEP_THROTTLER_TEMP_VR_MEM_BIT), "VR of HBM rail"},
+	{(1U << INDEP_THROTTLER_TEMP_VR_SOC_BIT), "VR of SOC rail"},
 };
 static void aldebaran_log_thermal_throttling_event(struct smu_context *smu)
 {
@@ -1745,7 +1776,8 @@ static ssize_t aldebaran_get_gpu_metrics(struct smu_context *smu,
 	gpu_metrics->current_vclk0 = metrics.CurrClock[PPCLK_VCLK];
 	gpu_metrics->current_dclk0 = metrics.CurrClock[PPCLK_DCLK];
 
-	gpu_metrics->throttle_status = metrics.ThrottlerStatus;
+	gpu_metrics->throttle_status =
+			aldebaran_get_indep_throttler_status(metrics.ThrottlerStatus);
 
 	gpu_metrics->current_fan_speed = 0;
 
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
