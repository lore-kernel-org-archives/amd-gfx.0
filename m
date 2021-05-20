Return-Path: <SRS0=8Dg8=KP=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8737C433B4
	for <amd-gfx@archiver.kernel.org>; Thu, 20 May 2021 14:30:36 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 99039610A8
	for <amd-gfx@archiver.kernel.org>; Thu, 20 May 2021 14:30:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 99039610A8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 385D36F419;
	Thu, 20 May 2021 14:30:36 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2058.outbound.protection.outlook.com [40.107.92.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 595CD6E40C
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 May 2021 14:30:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aWAGXKjkrP+tT8rDlwO6RWox4iEL9q659NnWZuZHt9TDh6GSh0WiN4iLF8wvyDDnIMG5GWY1HcKLM4jCH06cFCfPwRqWh5jHrhbrCeTbo/jPrHWu4I9imkGJjePXZ4xGBNJO4PcaGJUbdYO8zVSakpnYyUusB2Ip1CJ+qR1vJ1xL5l0EPoylu9ZSjumn8i3JxtCYC5RWKPCLYM1ejKnBLpwcgNtQ2eENap5OMTZIv23pMMfXAmff6Q5E76CPl76EuGW+Ip6LKYS1UwXE+nHKXUkiCkvOMSZhHHVO60MgHcgmz4ILAsmFZOdwZ1bJ/KYjGI1ZvzQ5zO9Tq3cTnENr3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E3SsxPp9MwS5BrFpB3O48nXGlBUXoRi7lkwQdRCOago=;
 b=VeYGjF9ccb0RmrhmxN4joRqmTJwjQJLtGuajg7Cd0eXxr1G150XWxnAXpiltiSasK3gsbhNSBB8zgpyjbGCcjaY1oQpD5vVvPdxibiVNcQn9/VNM+UGbtKEiMgdDllHVg56xBeo8ZpZmNFBcG48xLwrTcBRMdiNMuxdAnkr631zKTOUILlGJOINnMPVJJEqc+rcRwrQWYl72EZhfDIgubDmzH2DfjGtEZU2UgNfvOuKU/AfxyLxWMLrC+zOC8yTWNGtBGtyKlgnnpdMjBRHHLcpdx5T220EXnaGmgFA0Fivcj5JfuZpf/mjjU+uFdfrAI34jcpyOaa57OWhlnUxbAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E3SsxPp9MwS5BrFpB3O48nXGlBUXoRi7lkwQdRCOago=;
 b=dHeiArBg8vb9yZ1YGBbT8IpR5ZvHgF2JaL6aMw+xxjVEG3yzWApWXZYkPDEVJ/Pn/XCntwGfijPxl7Ih1pBuCA5VC4/CKwNdyQRw5JcvhWBhJUcIrwN27NDgZ47VEYpBIRB8ts6MqUzksTqgB9CwSIS8FUVdzxECSCO9j2/JBx4=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3067.namprd12.prod.outlook.com (2603:10b6:5:115::10)
 by DM6PR12MB4579.namprd12.prod.outlook.com (2603:10b6:5:2ac::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.26; Thu, 20 May
 2021 14:30:22 +0000
Received: from DM6PR12MB3067.namprd12.prod.outlook.com
 ([fe80::5c8c:adff:ab42:9345]) by DM6PR12MB3067.namprd12.prod.outlook.com
 ([fe80::5c8c:adff:ab42:9345%6]) with mapi id 15.20.4129.035; Thu, 20 May 2021
 14:30:22 +0000
From: Graham Sider <Graham.Sider@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 3/6] drm/amd/pm: Add navi1x throttler translation
Date: Thu, 20 May 2021 10:29:27 -0400
Message-Id: <20210520142930.8369-3-Graham.Sider@amd.com>
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
 15.20.4108.31 via Frontend Transport; Thu, 20 May 2021 14:30:21 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c320d1b5-9d61-4fe4-50ba-08d91b9bccfa
X-MS-TrafficTypeDiagnostic: DM6PR12MB4579:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB457944D88E0975CAEA1647B08A2A9@DM6PR12MB4579.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2331;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: O3AjVrQPhvKOnEDpgIUy0AQ8/MrdG5Ig9MkmNytNZBo19JlDZLHkhTxD+Po1/0x0v//yerBj7uDYMHQrRAlVt5J9V8ukSXwZJJEXkHlLXhwJ2tdPMrfLAaosKmG0gMJ+GaejKawtdWz3HTsdKFwGMNqIEmDkoJUc37z50B8wcoLsZO/CBV2cbE7UUIbUbSMkyt/VoJ/+gfQm9YYf3xDKynBaq2vvE2cwNnBJc6fmPc9oIhBmdWF+ydKgZrFwtUzAiOvurBBBtoOmoGfe11HDmkinFgYeePZRKE3f4MKg93KeFcHwripJEmu3c5O1X7qrDnRoPd151p4YYcIwJd+vuxD1vRlJqLIrceCOM5TOxtZO7ntwhPX8wL0mLApEhLPEw8Z8/SehfoBazge8jUrcAA9tyf0sNayXxv3Y7yMRsrGN8of6NrK45LmO7tWj4rYdAZCUMR9tHCuxvs/y8ME1rgw0J+7fsSmRnkQmbKHQi47eFETDEvRvch+l+F/yh0wYIHNeg+ktK3kxThtgscqdxgnt62LpqxMAidoWi372hix80rNpqQ95c6azswBQIszvkQy8cEBon+f5DqZBVmOHCRF+W+W8ai63ekpcImUs7XgP1z/FBMuDr6hEHuHCdq7x6uTs79LBb8W3oh+Nj++et6aS2px+hrVbFA5JepiR9ZFVztWAzZ+k8vvcqIhrtMn3
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3067.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(136003)(366004)(346002)(376002)(396003)(2906002)(52116002)(38350700002)(7696005)(8936002)(38100700002)(316002)(66946007)(83380400001)(6916009)(8676002)(1076003)(478600001)(66556008)(66476007)(6486002)(86362001)(5660300002)(956004)(36756003)(2616005)(4326008)(16526019)(186003)(26005)(32563001)(357404004);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?TI5nO3bdNISS341eiFoza9ohTu/h24Y7ujCgIv0TCpqBfhqppXbCuyLv1ixo?=
 =?us-ascii?Q?oTu093x2UUyplsRGbMGIYrzIL2NbDtmHCPMfurHH3bmnDAeDU0u2/GdZlw+G?=
 =?us-ascii?Q?/7cOffPI1bugH0Ms3ZN15vVaaPWOc2QwvJ8v+9mPP4wHwklQ2adKasiauJhv?=
 =?us-ascii?Q?p+YVbsfpw3JfWC2QgQaEasU6EiC7iY0RjVPN3z4Z0JjjH5TH9gipaf3thZ8o?=
 =?us-ascii?Q?+jGgALHkrYoftsw9HGeyc7jA/AIRWDLwozKeYP3GvlNhGQaAXPJzchKkeyo8?=
 =?us-ascii?Q?QeOG6EhiaVTeYZxA5Z0CZUgxqNxeZfAHxuf2dvWweVu3Dwe21VanjK8E3ogJ?=
 =?us-ascii?Q?Yib6AuwSN5v2geWosXVCIOlwbEEc+wGh1hyxjgGhqLQ1dvcw+eItx75cX3NC?=
 =?us-ascii?Q?v0MWrVUOY6+ihwMrelWpUD642gHxzgeOd8ooqDxiNsoLtVy57SLXC4vu1XCX?=
 =?us-ascii?Q?7UDlOe96r7NMghIHyvysq7+51oMlDOQbWn24Rb8QoB5aGPexqT8Hnqaj/G6L?=
 =?us-ascii?Q?qs03wIs2Uf/0N8GB1WywpvLbci1FUaV3VFHt0hTtPxLakmtFuLDzF9/Oiiv6?=
 =?us-ascii?Q?1bEuockI6k5FoZZ5v2aNKqNuziy2LOCkG3Zz3t8IcAFi8aIT3RYuYcqhnERi?=
 =?us-ascii?Q?saLNYkfuUY8H5yENSdZ5aLK5veNMKmbr8ADNkSUrUIVrb5YR13RH0QrrZCYK?=
 =?us-ascii?Q?v2W3ay1qvy/PEhdMIGAZzWpUd+i/C/JcyNxLSBSvNKBML8eODwJxlh3tDtJY?=
 =?us-ascii?Q?Jdi4gqDdmuaNwCSrMNZ8PymJ5XS8g5pPfycElVg/0NBBXKDV1PiWXMqvmpjk?=
 =?us-ascii?Q?7agD+35vhIC/Nnj2M2KbJVANUnyweXhwLv/VXTXQbdIy+yH2XI+B/CB2ykyd?=
 =?us-ascii?Q?Qpx8/kG5qBmr42YndEkshRWaOjghlmLxa3oozkM30GraFkklGtEjJawQ67dV?=
 =?us-ascii?Q?yrtT+Vu/tz9mswkqBe1QqF9Jf5I9/6Ste0clh2kmMFx9d9Ghz/7gnsDY2Eno?=
 =?us-ascii?Q?MwXjTJjiT9/KgSih8WALv4HpuUw1ECp5wt/gEYgrvR0c2oqfv6+it93+yP8s?=
 =?us-ascii?Q?uXMMXdV/rBoSCr7Bu2yL42hcUJy45xBfBvB7mEven+cMrc8qPoFq2pF1ZZu0?=
 =?us-ascii?Q?Y/S1M/1AaGVnA08oLIc4JEuq+4kbJ17aekNQD1W1CuobK9WmQQXoDCZFTw/X?=
 =?us-ascii?Q?j9zDcFfh6IUPXvPg4ke5I2vceGPP6cEXba8Rgn19h+TK1L2oj4uFDGUecF5J?=
 =?us-ascii?Q?z4c/QcqVG+s8I6ASP+vkWlWget+wLAHGpT/4+/m3hGBG+dx1RdRPScbzOryZ?=
 =?us-ascii?Q?QCqLX+DKkgV3aKKDo+Qf8wbH?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c320d1b5-9d61-4fe4-50ba-08d91b9bccfa
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3067.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2021 14:30:22.4202 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KfB++bqAnYQwdcvu+jO0J2GJ9zhm95OAKRdxZN+tbIriqRstLWCOk8V6GiLMmjHEn6N3eUJknYbKnufCJ+HC4A==
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
navi1x (navi10, navi12).
---
 .../gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c   | 63 ++++++++++++++++---
 1 file changed, 55 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
index 78fe13183e8b..8d216c46d057 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
@@ -524,6 +524,49 @@ static int navi10_tables_init(struct smu_context *smu)
 	return -ENOMEM;
 }
 
+static uint32_t navi1x_get_indep_throttler_status(
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
 static int navi10_get_legacy_smu_metrics_data(struct smu_context *smu,
 					      MetricsMember_t member,
 					      uint32_t *value)
@@ -601,7 +644,7 @@ static int navi10_get_legacy_smu_metrics_data(struct smu_context *smu,
 			SMU_TEMPERATURE_UNITS_PER_CENTIGRADES;
 		break;
 	case METRICS_THROTTLER_STATUS:
-		*value = metrics->ThrottlerStatus;
+		*value = navi1x_get_indep_throttler_status(metrics->ThrottlerStatus);
 		break;
 	case METRICS_CURR_FANSPEED:
 		*value = metrics->CurrFanSpeed;
@@ -696,7 +739,7 @@ static int navi10_get_smu_metrics_data(struct smu_context *smu,
 			SMU_TEMPERATURE_UNITS_PER_CENTIGRADES;
 		break;
 	case METRICS_THROTTLER_STATUS:
-		*value = metrics->ThrottlerStatus;
+		*value = navi1x_get_indep_throttler_status(metrics->ThrottlerStatus);
 		break;
 	case METRICS_CURR_FANSPEED:
 		*value = metrics->CurrFanSpeed;
@@ -788,7 +831,7 @@ static int navi12_get_legacy_smu_metrics_data(struct smu_context *smu,
 			SMU_TEMPERATURE_UNITS_PER_CENTIGRADES;
 		break;
 	case METRICS_THROTTLER_STATUS:
-		*value = metrics->ThrottlerStatus;
+		*value = navi1x_get_indep_throttler_status(metrics->ThrottlerStatus);
 		break;
 	case METRICS_CURR_FANSPEED:
 		*value = metrics->CurrFanSpeed;
@@ -883,7 +926,7 @@ static int navi12_get_smu_metrics_data(struct smu_context *smu,
 			SMU_TEMPERATURE_UNITS_PER_CENTIGRADES;
 		break;
 	case METRICS_THROTTLER_STATUS:
-		*value = metrics->ThrottlerStatus;
+		*value = navi1x_get_indep_throttler_status(metrics->ThrottlerStatus);
 		break;
 	case METRICS_CURR_FANSPEED:
 		*value = metrics->CurrFanSpeed;
@@ -2672,7 +2715,8 @@ static ssize_t navi10_get_legacy_gpu_metrics(struct smu_context *smu,
 	gpu_metrics->current_vclk0 = metrics.CurrClock[PPCLK_VCLK];
 	gpu_metrics->current_dclk0 = metrics.CurrClock[PPCLK_DCLK];
 
-	gpu_metrics->throttle_status = metrics.ThrottlerStatus;
+	gpu_metrics->throttle_status =
+			navi1x_get_indep_throttler_status(metrics.ThrottlerStatus);
 
 	gpu_metrics->current_fan_speed = metrics.CurrFanSpeed;
 
@@ -2749,7 +2793,8 @@ static ssize_t navi10_get_gpu_metrics(struct smu_context *smu,
 	gpu_metrics->current_vclk0 = metrics.CurrClock[PPCLK_VCLK];
 	gpu_metrics->current_dclk0 = metrics.CurrClock[PPCLK_DCLK];
 
-	gpu_metrics->throttle_status = metrics.ThrottlerStatus;
+	gpu_metrics->throttle_status =
+			navi1x_get_indep_throttler_status(metrics.ThrottlerStatus);
 
 	gpu_metrics->current_fan_speed = metrics.CurrFanSpeed;
 
@@ -2825,7 +2870,8 @@ static ssize_t navi12_get_legacy_gpu_metrics(struct smu_context *smu,
 	gpu_metrics->current_vclk0 = metrics.CurrClock[PPCLK_VCLK];
 	gpu_metrics->current_dclk0 = metrics.CurrClock[PPCLK_DCLK];
 
-	gpu_metrics->throttle_status = metrics.ThrottlerStatus;
+	gpu_metrics->throttle_status =
+			navi1x_get_indep_throttler_status(metrics.ThrottlerStatus);
 
 	gpu_metrics->current_fan_speed = metrics.CurrFanSpeed;
 
@@ -2907,7 +2953,8 @@ static ssize_t navi12_get_gpu_metrics(struct smu_context *smu,
 	gpu_metrics->current_vclk0 = metrics.CurrClock[PPCLK_VCLK];
 	gpu_metrics->current_dclk0 = metrics.CurrClock[PPCLK_DCLK];
 
-	gpu_metrics->throttle_status = metrics.ThrottlerStatus;
+	gpu_metrics->throttle_status =
+			navi1x_get_indep_throttler_status(metrics.ThrottlerStatus);
 
 	gpu_metrics->current_fan_speed = metrics.CurrFanSpeed;
 
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
