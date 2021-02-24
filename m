Return-Path: <SRS0=z84W=H2=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD7A7C4332B
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Feb 2021 22:21:55 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9370864EDD
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Feb 2021 22:21:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9370864EDD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AE8566EB89;
	Wed, 24 Feb 2021 22:21:51 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2087.outbound.protection.outlook.com [40.107.94.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 24B326EB72
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Feb 2021 22:21:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UTITp507j5NpVe2x9ARvaBNdXfKcHWP+kCYxQcN0jYatq2FY1GiCfVrof6A2MOiL1cNlnC9f0xnJKjEdmvyAAaKTjHJNj27vamckZFuW7B2CQdot7LSHWzcpjN6zLUHO7unq6jpDqqmnY83Z+Wf2VqWjiCsYq+u1hIZsYwXi0zv2aoCg2hj7mS062Z6tY/hsiWReBuZAnnrupw/7IyR16XSarkfFa/cA0YuS5ydWFD8000BgSzvwQHdL7svt67ilotakOJ9CdNFkFnL33nKkeSRNUog64+3toom0lNx/gM7j8nJvsl51SMtsggnH5jQidpcXdV0MUW3BVizpxxIxtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=idISm4S8rtC6oL29GaJLKFDkzXGYm3CK7FHOpKns+jk=;
 b=DImum8XsljIiBA8enjpGk1AnabBi2CIC6YYRsxqMJUiPRb0EscCDblPKAQan2vPlJrdYCBDcXwCoNbpZcskmq8xUQoJdIJV5gj3kuW1S5GYaMkTu7HbXpeCMaQbg/1syUfPyxDwPkBZMxTTR/0iQ0nEPlw1nEf1ARtpjl+QC4AI53mDNPPnHhVZC5ldfbBYvwdFM1zOVrD9SGMbUj25PDmbSsmhoCJdo4fkH8/84P3v2XYXONpQCl9Ep+2vyr6WBKxhj9//XXl+KmPhHO3mcNQegX2K+G8Gh+LmQw/gD4FzdWlGKkwyNeUDFzzAA6aGDBFX1uO5g8PiWZnoMzK9y1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=idISm4S8rtC6oL29GaJLKFDkzXGYm3CK7FHOpKns+jk=;
 b=pFVzle4XQm1fzdi1rJPwn7a2YrdT0WixxNjaLMST4yW7xqRp1MaL2UuM2H2Zhq70HbrG3b3nZY/nuYS2a15sb+nc5sLt4fxu15e5Ngwg2wOpzMOtL+hks4lafDTi8aJcfuv+gpBrZRFsH/b/e2kPp0hVawUvOtZZKmIjVTvg9yc=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 by MN2PR12MB4046.namprd12.prod.outlook.com (2603:10b6:208:1da::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.19; Wed, 24 Feb
 2021 22:21:47 +0000
Received: from MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::b0c4:9a8b:4c4c:76af]) by MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::b0c4:9a8b:4c4c:76af%7]) with mapi id 15.20.3868.033; Wed, 24 Feb 2021
 22:21:47 +0000
From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 113/159] drm/amdgpu/pm: Remove redundant generic message index
Date: Wed, 24 Feb 2021 17:18:13 -0500
Message-Id: <20210224221859.3068810-106-alexander.deucher@amd.com>
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
 Transport; Wed, 24 Feb 2021 22:20:40 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 18ccfab4-67d9-4d33-f9cd-08d8d9126b5e
X-MS-TrafficTypeDiagnostic: MN2PR12MB4046:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB40464612004680DEC2C1DD27F79F9@MN2PR12MB4046.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1284;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lYb/ZZBo/LgZh8kd9ZLlXsIz7u3xm+Rkz9VtFN73njKEK6PZM1iJnRoGa2ZmlupiohuGlJ/Vf6nAQmP+E0OkhptWNDfgG1iZaQ3NYRH9wM2aA0yHWqaZ+KARewj3Wj2x37UE8A4nGlgIZSES0hbv/KKEZgucU0CU+xit+4inA6I6+hVYbbx/O5ezbpcZF0Sy8Ly5+iDj+zHfSPDruiWvO+Vu5PRE8hyvVPK+/ftw/KJpH2Ej5mBmOYVmYikf6p6vqv/yfLTbotPwnrI4RS1WR8gG8emYUInYT1pRScnqzZQFksoAzOUeel2kmOV7DeS6RO2l9KcxWDTZM/AHdI/PATirumZsUhY1eSLiys93YxzUE4rrbEZr/FWCCwyYZbaQK/RNkugJK/pS8+yz4j48rW/MyMsN6xmlHqkR/avUM6oa80wJaeHw0ClDNaFR4dhCDwmdPOcJU60BJGlSMr8jWsWUGjt4krvkxClBSK0RLjgUlsbKKy2U0HuUI1gC0LKrGQ9IAMvVat8hclJ0aIlw/8bQMc70/Augc2dVdmq9tZfu2O0fjzmJjiBjlOMqYAhd/9GQ9foUBUryZ1g+LG84XOAYfJuqLXfKW9pSA8+fjGI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4488.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(366004)(346002)(39860400002)(396003)(136003)(83380400001)(86362001)(4326008)(956004)(2906002)(6486002)(2616005)(478600001)(69590400012)(6916009)(8676002)(8936002)(1076003)(6512007)(66556008)(66946007)(5660300002)(66476007)(4744005)(26005)(6666004)(186003)(52116002)(6506007)(54906003)(36756003)(316002)(16526019)(41533002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?S4YNEbVgHS8bejZ2ZaQHm62ozsRw4Q5VMzan7AOwNGqQfIHLUxJl1Lx4l921?=
 =?us-ascii?Q?iFEDlUuvxBLKO0j6kwyhJHvjS49+FmRrTkklDDA14alfJ2+S0rCsS5gFdxm2?=
 =?us-ascii?Q?E/WuAAjanRDogqcWfI1ERrWpTUIzKYLoRZn1g8DgLRt6kGsGW0QTc2Lds4HP?=
 =?us-ascii?Q?UnBDoq3gN7jutq16fvHdWcWXxHz+mox2vaJqE9W9um+v6Xpf6FfU3yYgDJyg?=
 =?us-ascii?Q?w49Ef8oDTlYjulbNaRMNN2Wa+AAdIlWdTIujY4IoBYUxX7GeJjBh+H/PCtZ+?=
 =?us-ascii?Q?B9UhbH2/lMVS7jU2tqMlJ3Bda3Fl7ucFFxm5KXmBrRBe5I/k69Hdi1CA+Oy8?=
 =?us-ascii?Q?SiXzwbUKP8RQqothJflkOwHfpiYr/4g4xTIptvE80nl/9vBXir/uuX/JAbRV?=
 =?us-ascii?Q?SxqZAwGfbxFpkp9YjmLdx/1nZwCrNqUKqhQGsf3N4RE2m67OQJQ8VaGq1B9L?=
 =?us-ascii?Q?RZgV3HLjJoO4yVPa441OEhF8+pCUSAyuMQIuCRB6Dsji5z5KbGCwMUU5GMub?=
 =?us-ascii?Q?N68A0k/0GRTcDTd3PkGhQimWnci8ML1+OKqZwMn/7L8gTgPXEnG1RByZcNiX?=
 =?us-ascii?Q?kCZC+Ls61lPoXk/ob024kZUnRTP23zoNbwjOCtAEulMqqZIpFy1sPMoNY69t?=
 =?us-ascii?Q?Ad38Zj5oeeK+Ehgw8xUAQ33CGNj/iTH5AXsXOkiNXZoWmZrvEZM5i+vajn/l?=
 =?us-ascii?Q?NuF7HtbsdlOIHLV4gKp8xXg31U6kWosFYvRLTXHo9ShcyJ/ZlC62iitySDDE?=
 =?us-ascii?Q?g9bB5vgPCCPJNWENC9i/8WMUkOZ6mQk571GimY2c5/UU+Qq+37GjDUSgTXO9?=
 =?us-ascii?Q?BRTUKFrPbk8pxclAjGjp2IGCMo07ZxPA/4v0Gscqg0C504Ce4pTVSMSOU5M+?=
 =?us-ascii?Q?N6pYaZrZUVXft4jMPWDDnkS5zEv+U+njUsKv0BnXryPLFr2iIgFYWYr0j+hD?=
 =?us-ascii?Q?EZG9WfiGLkPpA+HLcNqoIxqEJgEliX3kiEZGtd6oB7UapZEXYNkfeGlLCkXc?=
 =?us-ascii?Q?1RGLgQDfAAn3XXPT3U0HEBcrJytxyWB/whalF/LcnJFP0kb6eMPiKU58iK0L?=
 =?us-ascii?Q?V/Ii8eC0EEC9IpN1lfke91mlvAt3Mar5OpsE9LYe2NMGJGDmKldhRuWIjgcj?=
 =?us-ascii?Q?AW76umNIcu4n2QoWpTCe+AYjpNh6iBuXHND1zzsG6swvPl2OAXlLiYXWXUIw?=
 =?us-ascii?Q?pCHFJBsNbgPhGabFADoYlL8lNQJH6bNqVkAuLBpbPcC6Ll7B7JQ6v+LRIcG8?=
 =?us-ascii?Q?RViAZp4Mx5d5ytvjGjSAyXa5S0bCg69O1alRnN2JwCGlt0xy+a+SwT3v/JXo?=
 =?us-ascii?Q?2gVVvoDFrH1m8nKz52kxoe/0?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 18ccfab4-67d9-4d33-f9cd-08d8d9126b5e
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4488.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2021 22:20:40.8911 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: shAZoa9oRNccoINiVY2o8Ex4mb4TGF16qsO20oEAKVbY5OJQ/SMlte5BdlsTKlE18PE+kZZqLEj13IFWkQpRmg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4046
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Feifei Xu <Feifei.Xu@amd.com>,
 Lijo Lazar <lijo.lazar@amd.com>, Kevin Wang <kevin1.wang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Lijo Lazar <lijo.lazar@amd.com>

Remove SMU_MSG_GfxDriverReset generic index.
Always use SMU_MSG_GfxDeviceDriverReset as the generic index for reset.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
Reviewed-by: Feifei Xu <Feifei.Xu@amd.com>
Reviewed-by: Kevin Wang <kevin1.wang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/pm/inc/smu_types.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/inc/smu_types.h b/drivers/gpu/drm/amd/pm/inc/smu_types.h
index 207d5d923c9e..e9a0bda98fd7 100644
--- a/drivers/gpu/drm/amd/pm/inc/smu_types.h
+++ b/drivers/gpu/drm/amd/pm/inc/smu_types.h
@@ -184,7 +184,6 @@
 	__SMU_DUMMY_MAP(GET_UMC_FW_WA), \
 	__SMU_DUMMY_MAP(Mode1Reset), \
 	__SMU_DUMMY_MAP(RlcPowerNotify),                 \
-	__SMU_DUMMY_MAP(GfxDriverReset), \
 	__SMU_DUMMY_MAP(SetHardMinIspiclkByFreq),        \
 	__SMU_DUMMY_MAP(SetHardMinIspxclkByFreq),        \
 	__SMU_DUMMY_MAP(SetSoftMinSocclkByFreq),         \
-- 
2.29.2

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
