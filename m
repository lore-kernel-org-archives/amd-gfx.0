Return-Path: <SRS0=la1b=GT=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFD21C433E0
	for <amd-gfx@archiver.kernel.org>; Sat, 16 Jan 2021 11:58:44 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4F3E521D7A
	for <amd-gfx@archiver.kernel.org>; Sat, 16 Jan 2021 11:58:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F3E521D7A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 573FE6E088;
	Sat, 16 Jan 2021 11:58:43 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2068.outbound.protection.outlook.com [40.107.223.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9105E6E088
 for <amd-gfx@lists.freedesktop.org>; Sat, 16 Jan 2021 11:58:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FT3PU7cConNw+ump3AFFmfu7gVnU7gFZSwIhDCi2vOpeoNQMett6EUBYdIN2tL7HMRTq6i5l4gkSi7r/991bPF0i9xhALajLFX326bjT0OXNpRoUNVZ7AQsbGIZtwIeocjzVky0nr4eyahl6ZPFB2PTe6TRG/8Umdt8MlBllSoxnc94H88qNPW/eJu5gjdfr0ASgQWCsMOEF7Ep9YqQIxltapAQTVeuBK5yZ5XuqFR1i+JKKwtiXaGvaToHjFsQHcKCgTTKN0XrwHz980uE9BzZexu1B5tos7AYAeqfRIk0kNO3pgiet9R1IxXbTlxITgqJ6NlgjaaD86emqe0LhqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yc317Ma/eMqeElqy7wycyULqIil4tjmNQLVWjHouHD4=;
 b=eRPrbmBpr/qhiNNSjNQxu7cngJFm4XUW+/s05WehtKAxHbfUae179ZXwrKTjMXo9t8jsyUam96HMvYmbfjCUrHOiAQoVjlVg+esKkzwg8d9o8ilLi3FqWQZctUcHLvuuQ5YlG1YFmHUoeBWyi6dJAofUBHBceOLVK3jI53Nh3PkLmK52hSeIunfdoLrJ3ffvu6q3Kj1TepLNvEwP6nfHE2YD0Xk4yJByp40UKsr4p4HY48iz/tfRb6EggGixedldnJqaEEc1C3mVj8ShS1ucQC1znWCD3v+4w9HwL5wMPDVaAHhX/1w+eRqYgyEVqzscl06n+gSqIUcmXcu8onUvAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yc317Ma/eMqeElqy7wycyULqIil4tjmNQLVWjHouHD4=;
 b=Ls6uJnkk/zbhzs3I9tBcxchPyJO1gzg3l9B0K+zuq1EzWWM+TriOjh3cpgf9oK6KPnw12oMh/HjXchU0r+IRixtwMhuFV5WeMie+d6Zb6xVu7NnPHWGubxIqi6PTRUNIkbTLvTlulXReOhb+2v3bWKQMkzJiJS84djxh/N3zeYk=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3022.namprd12.prod.outlook.com (2603:10b6:208:ce::32)
 by MN2PR12MB2877.namprd12.prod.outlook.com (2603:10b6:208:ae::32)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3742.6; Sat, 16 Jan
 2021 11:58:39 +0000
Received: from MN2PR12MB3022.namprd12.prod.outlook.com
 ([fe80::709e:b0ae:fbde:fcc6]) by MN2PR12MB3022.namprd12.prod.outlook.com
 ([fe80::709e:b0ae:fbde:fcc6%7]) with mapi id 15.20.3742.012; Sat, 16 Jan 2021
 11:58:39 +0000
From: Kevin Wang <kevin1.wang@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amd/pm: remove unused message SMU_MSG_SpareX
Date: Sat, 16 Jan 2021 19:58:29 +0800
Message-Id: <20210116115829.20135-1-kevin1.wang@amd.com>
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [58.247.170.245]
X-ClientProxiedBy: HK2PR02CA0147.apcprd02.prod.outlook.com
 (2603:1096:202:16::31) To MN2PR12MB3022.namprd12.prod.outlook.com
 (2603:10b6:208:ce::32)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kevin-u1804-kvm.amd.com (58.247.170.245) by
 HK2PR02CA0147.apcprd02.prod.outlook.com (2603:1096:202:16::31) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3763.9 via Frontend Transport; Sat, 16 Jan 2021 11:58:38 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: f9916e51-4a5d-4226-83a7-08d8ba16101a
X-MS-TrafficTypeDiagnostic: MN2PR12MB2877:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB28776BB887B142DB5763E114A2A60@MN2PR12MB2877.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:862;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eaqR1yMaej5sCcf9kbvmNagcFpfZerjgfene1eKauAvmwfnH8sSPFQtHJ1q6ybLpd9jDErZhiFvByXxQ3OJxqUtjBzNsVY97nrHQrbFhY4HNyU7qnFBz6L+7nGr198CUu/f5UbehjEa4YnCAd7kq1pR1dEMzazfTYjM1oJj4oXZ+EG2wvSr7EywtSdMEmP8RCeRGEiOvqg4ItQmo3zKUAF6VF0M348iavUV5yBRW01pYztCvw5z5aCiW4LIdK0VA6kRkpIuXJS00IBvLj/Dl4MoHfT8zikYlbhD5WRajeujpEmu2XC4xz0slx9xUSrTqKRqlufuq2WwZ1rdr+Bnivp4vCUgvS66kHVwvkutCUgqKVRwRedGk0N6ExBm2q8r4eZ9tFlEhL9j3IOQwEDeShQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB3022.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(366004)(346002)(396003)(376002)(39860400002)(956004)(36756003)(16526019)(478600001)(186003)(2616005)(26005)(4326008)(6486002)(7696005)(8936002)(6916009)(1076003)(8676002)(2906002)(86362001)(83380400001)(6666004)(5660300002)(66556008)(66476007)(316002)(66946007)(52116002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?wZwkyNelUhY685CzDtDvvWjEOfqQF0kqV5LgySmN++1O3yga/5joMeoeMzaZ?=
 =?us-ascii?Q?NGAr/5VwYaVl9qadxfu35SJboN6kXjoI1eqV5UwE8vB7iiSd624awxepX81F?=
 =?us-ascii?Q?Z4P3DKggaRVkvNzh30G7V6O4QmLO9hGYmxZ9/GfISURvCyfeEicqHRM7Moco?=
 =?us-ascii?Q?hRh6nlcNhBKBoFyTB+nANeTs893E8qYZs72D0zV8/BOaag4X/V3R9IIaAwDK?=
 =?us-ascii?Q?pOHq1POe5wdwtz1M68Ix35odfOeNTOjURLwWPJVRRIDX5dAJmTCMRyTAzTLS?=
 =?us-ascii?Q?xfxFUZJnHAjR51teU6ppT+p8XX+OuDKRGhubrSYIE0cBaH8pgHyZkgR/PONa?=
 =?us-ascii?Q?qLCPMbaBu5n6rhKrx4I4Gu1SD/1Nz6/0R64K0RrUFux05DKsPsbPYhwgJQs0?=
 =?us-ascii?Q?pEeu7YBmTbAhSyh/j19xr7y6+oPLqcHi027RCr4ByYFfVBhEw8xXzE4y8+zX?=
 =?us-ascii?Q?hfuSDPSwwNlbYiwnUtAU9GCAvfompV0XdzGEZXliEDF8rFE3nEOVv/xCHTwr?=
 =?us-ascii?Q?dxHGsNyj9M9G5h9WLryfCQ2Scv/DDoCjxAYjCuYmNupjnUNnzGTGQg+MYEfd?=
 =?us-ascii?Q?1azTwalGg3RRH38M65pXA/vMpD2R1d0MrYf72doAimyfTuFgu8UmsWmAhLpG?=
 =?us-ascii?Q?DxdWMZRszfS9stnz9+d3w9M6oRuxxLEWqZe9qH01uukn+rHAbVjEAurHBiYj?=
 =?us-ascii?Q?vW6DDZTuUzvxYONqSHowoOpUWe1BU6SIHWMiY2d7uZ6S1vebgXSHDJnPRGvD?=
 =?us-ascii?Q?gfalQ9Cs3KNZUQmCK44m9lUiAffzK8m1k82ePesPEOHJlDX+CBga+CHu4wf5?=
 =?us-ascii?Q?Qhdq++7C6lGTMVHXTKyrd6tLMR76UpypzUpl516VrqFN3sTwR2Q5n2ZA3LEz?=
 =?us-ascii?Q?n2pdaOY5bKPXoIgsanEkoSEmnm6/baHLc+Lg2x3s8iTouXXKgJv0IC6am7SV?=
 =?us-ascii?Q?wH0jFqDXOKUIw6upLhe6QUNLl/gTuoIZ6iUFWuSqX3owN8Yt+jsrRp1oDcaq?=
 =?us-ascii?Q?Ueyj?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f9916e51-4a5d-4226-83a7-08d8ba16101a
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3022.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2021 11:58:39.7233 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nx7nJZqP8/LzY2kBrM6yGe7/HGggQmeAJETOXxO1+LSWQsWI0UZ82Yh/Bm+l3Lql
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB2877
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
Cc: Kevin Wang <kevin1.wang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

the SpareX is reserved by SMU firmwared,
the driver never use it.

Signed-off-by: Kevin Wang <kevin1.wang@amd.com>
---
 drivers/gpu/drm/amd/pm/inc/smu_types.h           | 2 --
 drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c | 2 --
 drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c  | 2 --
 3 files changed, 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/inc/smu_types.h b/drivers/gpu/drm/amd/pm/inc/smu_types.h
index b76270e8767c..68c87d4b1ce3 100644
--- a/drivers/gpu/drm/amd/pm/inc/smu_types.h
+++ b/drivers/gpu/drm/amd/pm/inc/smu_types.h
@@ -133,8 +133,6 @@
 	__SMU_DUMMY_MAP(PowerUpSdma),                 \
 	__SMU_DUMMY_MAP(SetHardMinIspclkByFreq),      \
 	__SMU_DUMMY_MAP(SetHardMinVcn),               \
-	__SMU_DUMMY_MAP(Spare1),                      \
-	__SMU_DUMMY_MAP(Spare2),           	      \
 	__SMU_DUMMY_MAP(SetAllowFclkSwitch),          \
 	__SMU_DUMMY_MAP(SetMinVideoGfxclkFreq),       \
 	__SMU_DUMMY_MAP(ActiveProcessNotify),         \
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
index 2f0cb0ea243b..3d639c530e2f 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
@@ -81,7 +81,6 @@ static struct cmn2asic_msg_mapping vangogh_message_map[SMU_MSG_MAX_COUNT] = {
 	MSG_MAP(TransferTableDram2Smu,          PPSMC_MSG_TransferTableDram2Smu,	0),
 	MSG_MAP(GfxDeviceDriverReset,           PPSMC_MSG_GfxDeviceDriverReset,		0),
 	MSG_MAP(GetEnabledSmuFeatures,          PPSMC_MSG_GetEnabledSmuFeatures,	0),
-	MSG_MAP(Spare1,                         PPSMC_MSG_spare1,					0),
 	MSG_MAP(SetHardMinSocclkByFreq,         PPSMC_MSG_SetHardMinSocclkByFreq,	0),
 	MSG_MAP(SetSoftMinFclk,                 PPSMC_MSG_SetSoftMinFclk,		0),
 	MSG_MAP(SetSoftMinVcn,                  PPSMC_MSG_SetSoftMinVcn,		0),
@@ -93,7 +92,6 @@ static struct cmn2asic_msg_mapping vangogh_message_map[SMU_MSG_MAX_COUNT] = {
 	MSG_MAP(SetSoftMaxSocclkByFreq,         PPSMC_MSG_SetSoftMaxSocclkByFreq,	0),
 	MSG_MAP(SetSoftMaxFclkByFreq,           PPSMC_MSG_SetSoftMaxFclkByFreq,		0),
 	MSG_MAP(SetSoftMaxVcn,                  PPSMC_MSG_SetSoftMaxVcn,			0),
-	MSG_MAP(Spare2,                         PPSMC_MSG_spare2,					0),
 	MSG_MAP(SetPowerLimitPercentage,        PPSMC_MSG_SetPowerLimitPercentage,	0),
 	MSG_MAP(PowerDownJpeg,                  PPSMC_MSG_PowerDownJpeg,			0),
 	MSG_MAP(PowerUpJpeg,                    PPSMC_MSG_PowerUpJpeg,				0),
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c
index 6c8a8ccd2f84..dfe4eeeb4596 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c
@@ -56,8 +56,6 @@ static struct cmn2asic_msg_mapping renoir_message_map[SMU_MSG_MAX_COUNT] = {
 	MSG_MAP(PowerUpSdma,                    PPSMC_MSG_PowerUpSdma,                  1),
 	MSG_MAP(SetHardMinIspclkByFreq,         PPSMC_MSG_SetHardMinIspclkByFreq,       1),
 	MSG_MAP(SetHardMinVcn,                  PPSMC_MSG_SetHardMinVcn,                1),
-	MSG_MAP(Spare1,                         PPSMC_MSG_spare1,                       1),
-	MSG_MAP(Spare2,                         PPSMC_MSG_spare2,                       1),
 	MSG_MAP(SetAllowFclkSwitch,             PPSMC_MSG_SetAllowFclkSwitch,           1),
 	MSG_MAP(SetMinVideoGfxclkFreq,          PPSMC_MSG_SetMinVideoGfxclkFreq,        1),
 	MSG_MAP(ActiveProcessNotify,            PPSMC_MSG_ActiveProcessNotify,          1),
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
