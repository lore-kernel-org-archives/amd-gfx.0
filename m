Return-Path: <SRS0=IbmW=MW=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2F1CC4320A
	for <amd-gfx@archiver.kernel.org>; Fri, 30 Jul 2021 02:41:16 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AD2DD60C3F
	for <amd-gfx@archiver.kernel.org>; Fri, 30 Jul 2021 02:41:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org AD2DD60C3F
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3E1C96F3A2;
	Fri, 30 Jul 2021 02:41:16 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2089.outbound.protection.outlook.com [40.107.93.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 837C96F3A0
 for <amd-gfx@lists.freedesktop.org>; Fri, 30 Jul 2021 02:41:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LnX18jn0nbpueHLZ0tQPRHXAJFFd12Th/9AgdDU/Y8+Im7ixniwdHdJ3fIV8a5OdY1s8wKvr4JxXNVGeBXwPS2CZP7fn32QiMkgG5UpAsRk5mc4wKhU/UnTJI5aEWp10ykPRkQuqc8dJlX5Kq/LdbirJ7YR0o7XlgUOBCl3g6kXafdEicFWg8VBJd1O1sWQKKA6INAGMHx32Sg+pu8/fjkA+laJGonL2m7/t+JeR/M0OFwwFtIw9DIkyiNpiIFT0bulamJcsCf8UuG/UR4ifyv5PyQ/D6Mnw9XVE7/lWlfT4ebuQ4uJiOYuDoc8OgmVgh08xh0SB6qOImN+ZLXe/9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ybZW3ROq1LQJTZBGJzHW/WBQvevVC+BgBU3FRqMWUcU=;
 b=lMaqlt5GYMg6ZgnqSyzifOTFGe42XTRUUKdbg+CCAgmgCRegrqN+htOvtDOCaaHVuDE7rP3J78VCMwl+EiAF1K7gA0rNUFsWB7MHIit40TzI3AiqNhh4YvzBnMTgbJnZtopLcGvt/weGPvZhmI+XbKA5aZzzOE6h77HPIClOM6PqFDi4kY2VutZR+t+hT6bOLlZpsKX41YvZX6JatDywOhD7z1egW2zW25okTbuisFAknNwvmUAgU/4TZsNGZtDxQiU3tLGwDnh7KdiYsy0WbyfOgLi1cRYw8r7ULBH5QFgBeIy/BLhsJuwEfqDDr1JeRs8JER3pKayoSnh8ZZlRTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ybZW3ROq1LQJTZBGJzHW/WBQvevVC+BgBU3FRqMWUcU=;
 b=hFw8IAdna9C7lMEwK4Vqk45O78tJKkucWMfYSdTBapP8gkX7ZphKDw1rknyD1kDlJgX6LTN6+SrnXL6EGdnYiyzk1JVAzRHbj3B55/QwIftSYO89NymvKUh3PA7sCdq5EH4mU+wdwCvs0pu735EU6CKYXMltjS9Szi5BzJILEGw=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB4510.namprd12.prod.outlook.com (2603:10b6:806:94::8)
 by SN6PR12MB2638.namprd12.prod.outlook.com (2603:10b6:805:6f::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.17; Fri, 30 Jul
 2021 02:41:11 +0000
Received: from SA0PR12MB4510.namprd12.prod.outlook.com
 ([fe80::c05f:7a93:601b:9861]) by SA0PR12MB4510.namprd12.prod.outlook.com
 ([fe80::c05f:7a93:601b:9861%7]) with mapi id 15.20.4373.025; Fri, 30 Jul 2021
 02:41:11 +0000
From: Mario Limonciello <mario.limonciello@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 1/3] drm/amd/pm: Don't output SMU version for smu13 every time
Date: Thu, 29 Jul 2021 21:40:48 -0500
Message-Id: <20210730024050.248-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.25.1
X-ClientProxiedBy: BN6PR21CA0005.namprd21.prod.outlook.com
 (2603:10b6:404:8e::15) To SA0PR12MB4510.namprd12.prod.outlook.com
 (2603:10b6:806:94::8)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from AUS-LX-MLIMONCI.amd.com (76.251.167.31) by
 BN6PR21CA0005.namprd21.prod.outlook.com (2603:10b6:404:8e::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4394.0 via Frontend Transport; Fri, 30 Jul 2021 02:41:10 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0c8fef84-7ee6-4ea2-ed02-08d953037db3
X-MS-TrafficTypeDiagnostic: SN6PR12MB2638:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN6PR12MB26384615C946BA085C0005EEE2EC9@SN6PR12MB2638.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sqGQbAVj4WbZ0BSProujJs5LBM5UbA7zlFma56pGAXh2CF1b8V30AJ7J12LykGlXu2mc38PzUOaLhydUn9C8NbBovGw7vq52n4aA1OwCVbpASR+pMzHnKSjaQv8HahpUnHCS8Btk9QbQzJDI6J9LI7aL9sMXOPjfeX1UCn9GKyArXjTqB4y4GY9ahGW3Hdoh3xH0pk9ekkViqimT8qnaAJZEPrVri3yYA+HUkxKn9C0Iakwta3H0dA3R2qKldipmHS8XTiJ95w+u8zyE9JYtBG5pCICs/+D5c4ByCA+lS9bAOa2dNQKW+tK18nBXsWAmOOlGXXgKkT6d9LkAQwiXOXzWLRTZskItBqS9mMahUt43l68D0B0W/1qucImoyXQ5MkdIX998aea478VrGW0v2azzNmxcW8RcfjQLqkk2kQHAAjNO1cWH3h1kG77VmfwgnHiv7mylR/lNNADaSXdrrB0bchQhThj23RBZt6Q8RdYK90J0+0jEd9maYyjaij65b+anBeehXacx3anTgb0D71Y/hX+ScqDxtaL9vw0g/2E1O/K857oVwinQMLEbr5qtM/PPTTkCCAa6h0gSzcnw68GbNTtyGT83BrA0KXw9SbSVwbNiQBeYO3uyvIb6PtG3/MWKsBCHKYI8zYn1coPq8MODmBJF5UwbV5T0J0gCLO5C3qGTQyJvDtYJKhQooBPbUaiiPlVBfwf3P+vUgT68CQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA0PR12MB4510.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(396003)(376002)(366004)(346002)(39860400002)(2906002)(83380400001)(6486002)(8676002)(478600001)(8936002)(52116002)(38350700002)(5660300002)(7696005)(4744005)(86362001)(38100700002)(316002)(4326008)(1076003)(44832011)(66556008)(6666004)(36756003)(186003)(66476007)(66946007)(26005)(956004)(2616005)(6916009);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?QkrZPwNzm/H33fAkfFIBRVtKJPxi3rsrLMgEHWBCGQCTewZktv1+AY07gT+L?=
 =?us-ascii?Q?EVokjkYRfCCVEK9aQVxGLiAY6C60wLxA6pfFc/jmi4p0SGlQ2ONF3jQzDJsR?=
 =?us-ascii?Q?Kd4wFwzFUI/Lu2WvDNM8Dc9Rr6hsWeqWbgwcMTTDBKJp8NTJIM3NNbCuGzNH?=
 =?us-ascii?Q?Rt/RzKksAbWoYN4TUoI54zFybLrnlhfb+uHFafV+T2lyufqsYT6AhTNmwqkY?=
 =?us-ascii?Q?fBTZ/m+rMkIStNpTw2eENdnet1A+PJ2rqmoaOAadA14GHxIdUC0WiVwVh9Z2?=
 =?us-ascii?Q?2Fcur0JLtRmWuvxIH/qjGqNdwAcDWlfVymvlXvXV66Q/tYtkFiSS8j9/t0u9?=
 =?us-ascii?Q?GaRzgzQavfRP8d8Mx0CsMIE7lAwsm5h7/SNkhioTXnwZt6tKAu+TrNPoeV6N?=
 =?us-ascii?Q?Y2AFXisK2Wjuv9wKwspniRBI2ONGJg19Z4ngCqABoH/Fuxx2soS+rnD6BkBB?=
 =?us-ascii?Q?tDd7V3tJrV58mJDnY/KI91wZor7xpbAL9C6OHA8tXY604bDYQqFnRQU6w0dv?=
 =?us-ascii?Q?ooRArIG0PkUXXDMxqOn6rpLHD3XazdryihfRmgZRR5oPX7Fa3ZEnaCdrmLMW?=
 =?us-ascii?Q?jhv6rgs0/CnPI/Puh0lLcGzjjEl/9kdvOtg3JX59Ufa7qBFK4mtcN3NJCOQa?=
 =?us-ascii?Q?vv5idAW+XGaJM+p8dAr4bVFr5GzP1QYeDPyWdXJLSLimUbNBI8tEyvCQr/TO?=
 =?us-ascii?Q?yp6TFRs6eI/EfgWi4IrF27iYAe+XnCLFdA99b84IOuayQum/37PNkB8nn9Om?=
 =?us-ascii?Q?s7bayo9f10Ug6Ca2PtH2OYvDbNsQgJgqK23XGwhakrZ9DDeu25SnesSpkc2e?=
 =?us-ascii?Q?n05EGslaW5xU+lJ6U0z67fMmbaqFjFtoyaDQBf/RsvDhCUTKiiAc2IsXC38M?=
 =?us-ascii?Q?MD50jVmYDEzujJUaQnpsoZWfrRGFfaoeVRP6o9z/LiGVVzPI9iv5HS8ZSVqT?=
 =?us-ascii?Q?fwMBUPwjPBK4cUEdyXdvKaLFL9IP5SYF8dYryKekMvXVxg+/J7TqOrAsxmpO?=
 =?us-ascii?Q?Vd0XvFQze+bx682YxbQYatkYVVKkZ+YidHLGKxoKUMqFBQtl66RDFPIU/jln?=
 =?us-ascii?Q?pfNajGPbjgNvJZ38JUJss3WongrNRWGCpdZEAseLHFxNRu3iUPAGWvXxMpA8?=
 =?us-ascii?Q?Na7FwrHqMMRiOJ1VO2D5557q41NW0hJ9cjKLzUgPu3FzlNdo3od9Z0TZ9e4J?=
 =?us-ascii?Q?AM0bItZ+/ODuohf7Pa447NWkTFGH7FqAOqIMhZVKQLvhjhdh3R9znclaQllZ?=
 =?us-ascii?Q?LKUgPDDKeZubnPrdGkSereZ25voEyIVpB2eR2Y11K4+O9CBkdJNofzcfW6sp?=
 =?us-ascii?Q?Kkk/8MsfjjWtx+/1j4NGbkvN?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c8fef84-7ee6-4ea2-ed02-08d953037db3
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB4510.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2021 02:41:11.1723 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WDkrpM3Scz3hjyC81Q94NyigPbjHxRgpbtWil/GKff2THqMe4CLKN/nRbRLh0KBooWn6Y5CfmolJaCga/rZKSQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2638
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
Cc: Mario Limonciello <mario.limonciello@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This adjusts SMU13 to match SMU11 and SMU12 behaviors in not showing
this message all the time.  It will still be accessible via
/sys/kernel/debug/dri/0/amdgpu_firmware_info

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
index a421ba85bd6d..9c99c51740a1 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
@@ -219,9 +219,6 @@ int smu_v13_0_check_fw_version(struct smu_context *smu)
 		break;
 	}
 
-	dev_info(smu->adev->dev, "smu fw reported version = 0x%08x (%d.%d.%d)\n",
-			 smu_version, smu_major, smu_minor, smu_debug);
-
 	/*
 	 * 1. if_version mismatch is not critical as our fw is designed
 	 * to be backward compatible.
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
