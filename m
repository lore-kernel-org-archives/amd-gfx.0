Return-Path: <SRS0=DoF4=HY=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26F7CC433DB
	for <amd-gfx@archiver.kernel.org>; Mon, 22 Feb 2021 03:56:55 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B685164E64
	for <amd-gfx@archiver.kernel.org>; Mon, 22 Feb 2021 03:56:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B685164E64
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 13FCD6E4AB;
	Mon, 22 Feb 2021 03:56:54 +0000 (UTC)
Received: from NAM04-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr700053.outbound.protection.outlook.com [40.107.70.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 09FC66E4AB
 for <amd-gfx@lists.freedesktop.org>; Mon, 22 Feb 2021 03:56:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H+/THRI0zf37Jp/0pT6W/Fupu542a+JIFHAhNmRH6bpkNHPzKwShvRaztVnSZx8N+hLRGzK3E2RZ8HH97udgN2jKgxrwqW7qKvE+LB26/AC9yTu5ERY0i/gUd1NFI5I0ysFBCRK0U8FBHn+u2rXcy+pcGaFYWBiY9atCCS62fjcgHzW204IAxQQZl/cbaQICaEZnuSe+jB+OcdVKiHzuQnMHDIU9CpvdkiKqsrQGCCorMX8wHBCmSB1MSPwgVTAKE4inDp3yyJTsBv35jGRcEJDOWKp698nCNGx7DSTwA7T4ypAyFI5NBo2yNDCF/x8jFjIZ49apU1zN2w92BfSzWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aBFdZlNuvUrMSU3tLdofOesHVYjeFelszMVH6Lp0/LM=;
 b=kHL6oj9HvpAuemSDW31ddlLfqbrk5vdfFLWCzoxc0fprwKr/LyCYXWBrMISHjPh83jpSijr7JQcMQgdzhLKzaJ3UUZsRWgUpM6+OfnNH1GZou0OZIMzwWi5Tgl3TnVLwBOzaR2I+mXQ1TDV0QUWS4ESGWEYwefmmd1ET+zDeg3jYnWQR/R+RBn+bld+zMkvMaTwdRn4AXZ50Pi7h86CNmOlNAzAFcnIVQJWeXOdt1qkLNOj8vFe3L/UkbhPxmVznBJCR3lAt8OO15fKOUL+vE2wya+NtHqk2iGOW4AHNVxYH8dRyHPf3wm5VPGiWG4XpYyh2FzHz8PhwiW1CRF6fJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aBFdZlNuvUrMSU3tLdofOesHVYjeFelszMVH6Lp0/LM=;
 b=LGMNttTU1KxK6pjc96wl4ohC2iP7tVO4/RE9Lq8W+fhUBMXipHGiXotAciHvbjANxxashnHKOpBo2nQgen379Gxz/lmYKidedhM6NkDJZ4VyZHZccCC7ezF+s1H4yHPy9Dgx3sWUqjsXinXdZw/MMLdFvO+iK/v0PQN4oON7fYc=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM6PR12MB4748.namprd12.prod.outlook.com (2603:10b6:5:33::15) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3868.33; Mon, 22 Feb 2021 03:56:51 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::11e6:53ff:8e98:31f0]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::11e6:53ff:8e98:31f0%3]) with mapi id 15.20.3868.032; Mon, 22 Feb 2021
 03:56:50 +0000
From: Evan Quan <evan.quan@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amd/pm: bump Navi1x driver if version and related data
 structures
Date: Mon, 22 Feb 2021 11:56:25 +0800
Message-Id: <20210222035625.1280702-1-evan.quan@amd.com>
X-Mailer: git-send-email 2.29.0
X-Originating-IP: [180.167.199.189]
X-ClientProxiedBy: HK2PR03CA0062.apcprd03.prod.outlook.com
 (2603:1096:202:17::32) To DM6PR12MB2619.namprd12.prod.outlook.com
 (2603:10b6:5:45::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from equan-buildpc.amd.com (180.167.199.189) by
 HK2PR03CA0062.apcprd03.prod.outlook.com (2603:1096:202:17::32) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3890.10 via Frontend Transport; Mon, 22 Feb 2021 03:56:49 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: ca00c284-a198-4eb0-a846-08d8d6e5e236
X-MS-TrafficTypeDiagnostic: DM6PR12MB4748:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB47481B6632E766CCB37F14C6E4819@DM6PR12MB4748.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ybuu2AEB/jspjaXlTSuGzEfvHbQ201Ltv7SZZQsgkmk4fPG0+HFLilUK+BdVccwWklPdyGrv19k/kx5KkvAG2dp9+kVf8BLEGpjQoxz2wEblvgkem3xEXrU8lqpGsKE9yxj2C7T8l9Ufu/lIJjfEzsnk1zAY+n0TcjpNy1fHQJoQM8DsKyJ1So/CekIYmEIKCXgWwmnYiENvRbfRwwt4/W6xF5cn9tHHqqG8wCnA0DQU+9JD5YhJseR/4wYihQS3gTI1hjD9/MExExzXOcwrYbMBgWrLdGt5db99ndX476cNkN7gom1IFtpxFhoVx+VqP/mrv9C0/vtw7FzXS7mrHHtQyxYOzdL519sOHnyzGl3t9K7e4veZ0rEwp8YgknIj4G4KZWmuHxuI6K7v+VKYINmgtP8Q3a/A/Wya0rkDBcQayKAHb42N04d1WekWtKxHpNfBN1CosOwpI7og3vXAjUpDKbj+d1HNvIrsnshGgKAG8iYHw3V4Y+E9tZdjrKjALSUzhLQIWej05b7WjA/GfuqDBhxENoQdWoOaSiT3HJ4I5qaRYEw2Ezz5oPVaqEEk
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(346002)(39860400002)(366004)(396003)(376002)(66946007)(478600001)(66556008)(86362001)(66476007)(8676002)(8936002)(2906002)(1076003)(6916009)(4326008)(316002)(36756003)(956004)(5660300002)(6486002)(83380400001)(52116002)(7696005)(2616005)(26005)(44832011)(186003)(6666004)(16526019)(32563001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?Ci4XalqApvKkkRlUJsEM6kZ0yvN8XgNYgeO2gDESwExokECzjTzPob2MSIq/?=
 =?us-ascii?Q?ST0roLUG5OIQZdB2l3eomAaa6qzH4OKVykjDcpqkOtkXzRfG8oLLWBn76sbj?=
 =?us-ascii?Q?PrRBfmgedVWBOP58O4uqbN+AtQ3AZmk4rq7eSDxpCu1a+YvAMSnke1RwNbou?=
 =?us-ascii?Q?h19iGbDqg/JqY4xdqFEP6AnQKHVBEdroCHDpZVxb1pfp/OGuLNNXJLnC7Tty?=
 =?us-ascii?Q?kdbxneKhkJsA8vbAQy4l7ZrpSD0vYVHgjWwfU2TO5h8T+RLpCHnOgUByhffR?=
 =?us-ascii?Q?zlxeYmOAril4vnAJZ+prtz7vLc4YoAw3TwZM/IJP5z+F23roCwPS4YpdoBfc?=
 =?us-ascii?Q?TnsxQs3Exruut8GLYxaJN14P/FAgBuLzfc2rwUEj7tBp9FVYnYaa+cTw9Gku?=
 =?us-ascii?Q?ZEJETJcdXVUBq/3ioPNynOJ5zmMpECadtSQQcYXcDuDxOFlNeQYYwF6ZiElm?=
 =?us-ascii?Q?3Akb5flnQNqfwbW2LZpqNYbajwnPNbGqxz/9DN6n5PSI+zo0w4bzos+kdHem?=
 =?us-ascii?Q?vk/ejm1EEpVtyY370QAziJdSzTrGorTaodIt+dnc5eZRvs6wYCQVS1vQaxZD?=
 =?us-ascii?Q?NrEDzp9zYn3NT9n+6lD56DodAaWVN9ONVWBAHrwKdcI0W93H/oABvduVmPwR?=
 =?us-ascii?Q?GJ8JW/wzTo8qNZSxAz/4ImunABs+cVrpRHn5/IOstnIm6KP45TKXZG1SjvkY?=
 =?us-ascii?Q?j5MgHlDbgwOmUCplvEF/Au1c8PSpDIXjWj43uxWPFMoX197hy6MdtHoftT0x?=
 =?us-ascii?Q?kNH5ILFM1KQiD0BjA4nLsZ9+ZBEX6pPZwmCKefI0eq0rXu3p+KklO1vrB6rA?=
 =?us-ascii?Q?HTWgjstTuAUbfeMiATb7FeD2kXRWfWqood4fvpdkQG18YhdHxhLhR9sQkeuH?=
 =?us-ascii?Q?WUmulJ0I/9KuwZqzxX+JAYTYiqQn/CgM5Z8wd0lcwGdVpDl4INx2cav/92d5?=
 =?us-ascii?Q?nWnUi2sWZFrP7meN33jNHj9SrC6Xv37QcsDh0q5whQ0sqA3/hXvJaa8Z27uS?=
 =?us-ascii?Q?dnpK7YJ6feA9xAORlbO0ZsxFI1CEkRmVEGmVomyO7DZwYZUPJywj3WTjswLM?=
 =?us-ascii?Q?Da7VpsnTARxx+1KX4hSVmSe2b9h/y/GSkfwA0RJrHWYZY8yG/mmB5JepMGGw?=
 =?us-ascii?Q?mQn91la69n5a21fTbgW/nsxnHIyctyjiCI/bd8ezz2zBJEIbQJp2vTzLE2pF?=
 =?us-ascii?Q?Q2L8QGKsNESjm2ZxcsuwpUGxekD7sRcipZdBGl1URsYyjBRy/KSclhYffoHo?=
 =?us-ascii?Q?+vEp1MYC30bsACG8xfT2Mi5a5ygSujBN49MA9Wu3q82pJr9Icwouu3psKRoV?=
 =?us-ascii?Q?TVfpzJgMVI4xblpMHD0wnAVK?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ca00c284-a198-4eb0-a846-08d8d6e5e236
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Feb 2021 03:56:50.8910 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jUxsqim8Q9/UCQNRyfncKagoiXrJ8YAXH1PcThixha1Y/Pov+fk3Ro3ejFwJmDw6
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4748
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
Cc: Alexander.Deucher@amd.com, Evan Quan <evan.quan@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

New changes were involved for the SmuMetrics strucutre.

Change-Id: Ib45443db03977ccd18618bcfdfd3574ac13d50d1
Signed-off-by: Evan Quan <evan.quan@amd.com>
---
 .../drm/amd/pm/inc/smu11_driver_if_navi10.h   | 31 ++++++++----
 drivers/gpu/drm/amd/pm/inc/smu_v11_0.h        |  6 +--
 .../gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c   | 48 +++++++++++++++++--
 3 files changed, 70 insertions(+), 15 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/inc/smu11_driver_if_navi10.h b/drivers/gpu/drm/amd/pm/inc/smu11_driver_if_navi10.h
index 246d3951a78a..84d12da19c90 100644
--- a/drivers/gpu/drm/amd/pm/inc/smu11_driver_if_navi10.h
+++ b/drivers/gpu/drm/amd/pm/inc/smu11_driver_if_navi10.h
@@ -843,19 +843,23 @@ typedef struct {
   uint16_t      FanMaximumRpm;
   uint16_t      FanMinimumPwm;
   uint16_t      FanTargetTemperature; // Degree Celcius 
+  uint16_t      FanMode;
+  uint16_t      FanMaxPwm;
+  uint16_t      FanMinPwm;
+  uint16_t      FanMaxTemp; // Degree Celcius
+  uint16_t      FanMinTemp; // Degree Celcius
   uint16_t      MaxOpTemp;            // Degree Celcius
   uint16_t      FanZeroRpmEnable;
-  uint16_t      Padding;
 
-  uint32_t     MmHubPadding[8]; // SMU internal use  
+  uint32_t     MmHubPadding[6]; // SMU internal use
 
 } OverDriveTable_t; 
 
 typedef struct {
   uint16_t CurrClock[PPCLK_COUNT];
-  uint16_t AverageGfxclkFrequency;
+  uint16_t AverageGfxclkFrequencyPostDs;
   uint16_t AverageSocclkFrequency;
-  uint16_t AverageUclkFrequency  ;
+  uint16_t AverageUclkFrequencyPostDs;
   uint16_t AverageGfxActivity    ;
   uint16_t AverageUclkActivity   ;
   uint8_t  CurrSocVoltageOffset  ;
@@ -880,15 +884,21 @@ typedef struct {
   uint8_t  Padding8_2;
   uint16_t CurrFanSpeed;
 
+  uint16_t AverageGfxclkFrequencyPreDs;
+  uint16_t AverageUclkFrequencyPreDs;
+  uint8_t  PcieRate;
+  uint8_t  PcieWidth;
+  uint8_t  Padding8_3[2];
+
   // Padding - ignore
   uint32_t     MmHubPadding[8]; // SMU internal use
 } SmuMetrics_t;
 
 typedef struct {
   uint16_t CurrClock[PPCLK_COUNT];
-  uint16_t AverageGfxclkFrequency;
+  uint16_t AverageGfxclkFrequencyPostDs;
   uint16_t AverageSocclkFrequency;
-  uint16_t AverageUclkFrequency  ;
+  uint16_t AverageUclkFrequencyPostDs;
   uint16_t AverageGfxActivity    ;
   uint16_t AverageUclkActivity   ;
   uint8_t  CurrSocVoltageOffset  ;
@@ -913,11 +923,16 @@ typedef struct {
   uint8_t  Padding8_2;
   uint16_t CurrFanSpeed;
 
-  uint32_t EnergyAccumulator;
   uint16_t AverageVclkFrequency  ;
   uint16_t AverageDclkFrequency  ;
   uint16_t VcnActivityPercentage ;
-  uint16_t padding16_2;
+  uint16_t AverageGfxclkFrequencyPreDs;
+  uint16_t AverageUclkFrequencyPreDs;
+  uint8_t  PcieRate;
+  uint8_t  PcieWidth;
+
+  uint32_t Padding32_1;
+  uint64_t EnergyAccumulator;
 
   // Padding - ignore
   uint32_t     MmHubPadding[8]; // SMU internal use
diff --git a/drivers/gpu/drm/amd/pm/inc/smu_v11_0.h b/drivers/gpu/drm/amd/pm/inc/smu_v11_0.h
index 281835f23f6d..50dd1529b994 100644
--- a/drivers/gpu/drm/amd/pm/inc/smu_v11_0.h
+++ b/drivers/gpu/drm/amd/pm/inc/smu_v11_0.h
@@ -27,9 +27,9 @@
 
 #define SMU11_DRIVER_IF_VERSION_INV 0xFFFFFFFF
 #define SMU11_DRIVER_IF_VERSION_ARCT 0x17
-#define SMU11_DRIVER_IF_VERSION_NV10 0x36
-#define SMU11_DRIVER_IF_VERSION_NV12 0x36
-#define SMU11_DRIVER_IF_VERSION_NV14 0x36
+#define SMU11_DRIVER_IF_VERSION_NV10 0x37
+#define SMU11_DRIVER_IF_VERSION_NV12 0x38
+#define SMU11_DRIVER_IF_VERSION_NV14 0x38
 #define SMU11_DRIVER_IF_VERSION_Sienna_Cichlid 0x3D
 #define SMU11_DRIVER_IF_VERSION_Navy_Flounder 0xE
 #define SMU11_DRIVER_IF_VERSION_VANGOGH 0x02
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
index 6ec842811cbc..29e04f33f276 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
@@ -70,6 +70,8 @@
 	FEATURE_MASK(FEATURE_DPM_LINK_BIT)	 | \
 	FEATURE_MASK(FEATURE_DPM_DCEFCLK_BIT))
 
+#define SMU_11_0_GFX_BUSY_THRESHOLD 15
+
 static struct cmn2asic_msg_mapping navi10_message_map[SMU_MSG_MAX_COUNT] = {
 	MSG_MAP(TestMessage,			PPSMC_MSG_TestMessage,			1),
 	MSG_MAP(GetSmuVersion,			PPSMC_MSG_GetSmuVersion,		1),
@@ -515,6 +517,8 @@ static int navi10_get_smu_metrics_data(struct smu_context *smu,
 	 * same offsets for the heading parts(those members used here).
 	 */
 	SmuMetrics_t *metrics = (SmuMetrics_t *)smu_table->metrics_table;
+	struct amdgpu_device *adev = smu->adev;
+	uint32_t smu_version;
 	int ret = 0;
 
 	mutex_lock(&smu->metrics_lock);
@@ -547,13 +551,30 @@ static int navi10_get_smu_metrics_data(struct smu_context *smu,
 		*value = metrics->CurrClock[PPCLK_DCEFCLK];
 		break;
 	case METRICS_AVERAGE_GFXCLK:
-		*value = metrics->AverageGfxclkFrequency;
+		ret = smu_cmn_get_smc_version(smu, NULL, &smu_version);
+		if (ret) {
+			dev_err(adev->dev, "Failed to get smu version!\n");
+			return ret;
+		}
+		/*
+		 * The PreDs is supported by:
+		 *   - Navi10 PMFW 42.60 and onwards
+		 *   - Navi12 PMFW 52.29 and onwards
+		 *   - Navi14 PMFW 53.31 and onwards
+		 */
+		if ((metrics->AverageGfxActivity > SMU_11_0_GFX_BUSY_THRESHOLD) &&
+		     (((adev->asic_type == CHIP_NAVI14) && smu_version > 0x00351F00) ||
+		     ((adev->asic_type == CHIP_NAVI12) && smu_version > 0x00341C00) ||
+		     ((adev->asic_type == CHIP_NAVI10) && smu_version > 0x002A3B00)))
+			*value = metrics->AverageGfxclkFrequencyPreDs;
+		else
+			*value = metrics->AverageGfxclkFrequencyPostDs;
 		break;
 	case METRICS_AVERAGE_SOCCLK:
 		*value = metrics->AverageSocclkFrequency;
 		break;
 	case METRICS_AVERAGE_UCLK:
-		*value = metrics->AverageUclkFrequency;
+		*value = metrics->AverageUclkFrequencyPostDs;
 		break;
 	case METRICS_AVERAGE_GFXACTIVITY:
 		*value = metrics->AverageGfxActivity;
@@ -2298,6 +2319,7 @@ static ssize_t navi10_get_gpu_metrics(struct smu_context *smu,
 	struct amdgpu_device *adev = smu->adev;
 	SmuMetrics_NV12_t nv12_metrics = { 0 };
 	SmuMetrics_t metrics;
+	uint32_t smu_version;
 	int ret = 0;
 
 	mutex_lock(&smu->metrics_lock);
@@ -2330,9 +2352,27 @@ static ssize_t navi10_get_gpu_metrics(struct smu_context *smu,
 
 	gpu_metrics->average_socket_power = metrics.AverageSocketPower;
 
-	gpu_metrics->average_gfxclk_frequency = metrics.AverageGfxclkFrequency;
+	ret = smu_cmn_get_smc_version(smu, NULL, &smu_version);
+	if (ret) {
+		dev_err(adev->dev, "Failed to get smu version!\n");
+		return ret;
+	}
+	/*
+	 * The PreDs is supported by:
+	 *   - Navi10 PMFW 42.60 and onwards
+	 *   - Navi12 PMFW 52.29 and onwards
+	 *   - Navi14 PMFW 53.31 and onwards
+	 */
+	if ((metrics.AverageGfxActivity > SMU_11_0_GFX_BUSY_THRESHOLD) &&
+	     (((adev->asic_type == CHIP_NAVI14) && smu_version > 0x00351F00) ||
+	     ((adev->asic_type == CHIP_NAVI12) && smu_version > 0x00341C00) ||
+	     ((adev->asic_type == CHIP_NAVI10) && smu_version > 0x002A3B00)))
+		gpu_metrics->average_gfxclk_frequency = metrics.AverageGfxclkFrequencyPreDs;
+	else
+		gpu_metrics->average_gfxclk_frequency = metrics.AverageGfxclkFrequencyPostDs;
+
 	gpu_metrics->average_socclk_frequency = metrics.AverageSocclkFrequency;
-	gpu_metrics->average_uclk_frequency = metrics.AverageUclkFrequency;
+	gpu_metrics->average_uclk_frequency = metrics.AverageUclkFrequencyPostDs;
 
 	if (adev->asic_type == CHIP_NAVI12) {
 		gpu_metrics->energy_accumulator = nv12_metrics.EnergyAccumulator;
-- 
2.29.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
