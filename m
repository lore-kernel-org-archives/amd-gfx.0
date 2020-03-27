Return-Path: <SRS0=Hz3R=5M=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E906C43331
	for <amd-gfx@archiver.kernel.org>; Fri, 27 Mar 2020 03:42:04 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0B116206DB
	for <amd-gfx@archiver.kernel.org>; Fri, 27 Mar 2020 03:42:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="w7LgsZ9Y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B116206DB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C90A06E233;
	Fri, 27 Mar 2020 03:42:03 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2089.outbound.protection.outlook.com [40.107.223.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B83E96E233
 for <amd-gfx@lists.freedesktop.org>; Fri, 27 Mar 2020 03:42:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R6XAvhIEL7YS8FbyYuWIIzx3EF5AK5o99eKQCzk8Nu7XFwHGDBKvktZ+pFDtWBlcepiDPufVECMnH8pcZ1RPc5OxpKFhbLioOvStNNWsZtI4d+AS7QH9rjhl8f4OpeRUwkKzT01cb8iNYPqm+6XV5BPRY3G6WNQ5iNwb89jv0Luo/kscSpRlAWkp8/Sya/QSEp2APmJh4nkTCWOY/As9TBPMlmRLuV5VKS3RM9xZXkVNiuYk3bl3hk0hOyZopDp1ifv6+Zc8myvwrsTxlGvLpHZOcqcvVpI2t/gbN1xxzR6DHsUMhx/pN6eyq8ZwdUnc3cw3aNYPMGz0y5uG3D5/7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GBv2DWphP3S9Bsp5kI8tNiX0YD75iXn1oicHKM+SHBI=;
 b=m2g6QJmSgy+9+Bijmt5o33k8aLbTMxrB7YtpSC3S83wk0aTpDOmOyF4EvkjVdj72yXV55//PQBu8ybJAygWmz7YZKldgMsPLGZez/WRTFUDTp140TFG52REtCtGADTpIJxvI0gumhLsDpdyXGZPIm6bWPv2J6MfSqbLxCAAk3oKoKlE+Gxb2DebqgR0+c0GZwEIfArtjJ1szcH9jembuTgtYQnuaW6D8BE6RJbN4EyacyytJu1k9ei5+1w2GDEesMpJgTENCDkemld5z4H/iAPGxc7U3l5EqzInyUh/CDJt4EWjiWRKGRvL4X27UxwFVU5jy4ugSyPlJYrYIgKRxIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GBv2DWphP3S9Bsp5kI8tNiX0YD75iXn1oicHKM+SHBI=;
 b=w7LgsZ9YC19INU758/j8/8U1b6x2WM7HylXJfpcKzO5q02q8QwTpzyBS3YXKJvViIi1S/scLFPmdtnaH4mMZlmeYr5JXGTddgtA3Ji2tVqkKR9VemUcuEJrAlbKDvMRGHR7S1aT4ra0xaCW7gL4iya0pKqvnV4ViDHrmIwM2luI=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Evan.Quan@amd.com; 
Received: from MN2PR12MB3344.namprd12.prod.outlook.com (2603:10b6:208:c5::10)
 by MN2PR12MB4373.namprd12.prod.outlook.com (2603:10b6:208:261::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2856.19; Fri, 27 Mar
 2020 03:41:59 +0000
Received: from MN2PR12MB3344.namprd12.prod.outlook.com
 ([fe80::69c7:b493:690:2173]) by MN2PR12MB3344.namprd12.prod.outlook.com
 ([fe80::69c7:b493:690:2173%3]) with mapi id 15.20.2835.021; Fri, 27 Mar 2020
 03:41:59 +0000
From: Evan Quan <evan.quan@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 1/9] drm/amd/powerplay: avoid calling CI specific SMU message
 implemention
Date: Fri, 27 Mar 2020 11:41:30 +0800
Message-Id: <20200327034138.7653-1-evan.quan@amd.com>
X-Mailer: git-send-email 2.26.0
X-ClientProxiedBy: HK0PR01CA0063.apcprd01.prod.exchangelabs.com
 (2603:1096:203:a6::27) To MN2PR12MB3344.namprd12.prod.outlook.com
 (2603:10b6:208:c5::10)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from equan-buildpc.amd.com (180.167.199.189) by
 HK0PR01CA0063.apcprd01.prod.exchangelabs.com (2603:1096:203:a6::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2856.20 via Frontend
 Transport; Fri, 27 Mar 2020 03:41:58 +0000
X-Mailer: git-send-email 2.26.0
X-Originating-IP: [180.167.199.189]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: c7938667-baaa-4749-ac1a-08d7d200cdda
X-MS-TrafficTypeDiagnostic: MN2PR12MB4373:|MN2PR12MB4373:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB43731691ECF1FEC7858A5BBEE4CC0@MN2PR12MB4373.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2331;
X-Forefront-PRVS: 0355F3A3AE
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(366004)(136003)(396003)(346002)(39860400002)(376002)(6666004)(6486002)(26005)(81156014)(8676002)(6916009)(81166006)(16526019)(956004)(4326008)(15650500001)(186003)(36756003)(44832011)(2616005)(8936002)(52116002)(478600001)(86362001)(66946007)(66556008)(316002)(7696005)(2906002)(5660300002)(1076003)(66476007);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MN2PR12MB4373;
 H:MN2PR12MB3344.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: r4G7ynWbNSbTZjQd/z+F1/DqW2CHtJfma8afStj4ONTwepBXeLQcEDdcmARqrAsh3hSjLn6KzyBmllIlTSit/OBdfR1/Dbbk4XgMPZneTYObcyTvg+CGXdbvUO0y6MYHrgmye9ahGufA/EM9ddsw9o57D/ylgkVeY4SFVUtUwUQ0hHbP3v+el3S9k32+97ltL8XHtl+vzObWT/BJdEtCJ09TwD1pXdG+M6X+LE7Z0cH5uga4lHlcItZWN2yyREAC4oXT7HblbcmL3pMx2htEJW5guskPjQGFq8ynwiqSbKZpHZgTH4HAzyAPEoPBBg8A0KdkLvacA1tgrXI5Pu/ZfqVNNswDp9L7zkX1yjBSHM2gJF4I+KZd0a8c/B3/wZUzScafVtPe4A1HskAr0AAOBfizUQnF+eoCltZFIRurb0V+sqpUBAJRD9Ce0xo+f3sO
X-MS-Exchange-AntiSpam-MessageData: 9Xrp4wlWvkE7hIlQYNLBhSqmHV1SSD/6VheDtmMoGtnYwsEj2eJp4i30keLy0Xb+RBpY63zjsjzGXu0sr1oEZMJMJcm09P9ygUSM5eB3cbp8+nSnajrsJ6HAOz6Syu+BCUpBCk6NnffeR18gHpRf3w==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c7938667-baaa-4749-ac1a-08d7d200cdda
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2020 03:41:59.6654 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: g4n5IfRauEWYVEhTh/lSJnHo/sBQ6ELergBFS1DIzVqoogvKz2UkaxCpY2j3l22D
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4373
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
Cc: Evan Quan <evan.quan@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Prepare for coming lock protection for SMU message issuing.

Change-Id: If5f7615483d9967f9512fba49cc8454a1300ba6c
Signed-off-by: Evan Quan <evan.quan@amd.com>
---
 drivers/gpu/drm/amd/powerplay/smumgr/ci_smumgr.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/powerplay/smumgr/ci_smumgr.c b/drivers/gpu/drm/amd/powerplay/smumgr/ci_smumgr.c
index 868e2d5f6e62..66289884c8df 100644
--- a/drivers/gpu/drm/amd/powerplay/smumgr/ci_smumgr.c
+++ b/drivers/gpu/drm/amd/powerplay/smumgr/ci_smumgr.c
@@ -2881,7 +2881,7 @@ static int ci_update_uvd_smc_table(struct pp_hwmgr *hwmgr)
 		if (hwmgr->dpm_level & profile_mode_mask || !PP_CAP(PHM_PlatformCaps_UVDDPM))
 			break;
 	}
-	ci_send_msg_to_smc_with_parameter(hwmgr, PPSMC_MSG_UVDDPM_SetEnabledMask,
+	smum_send_msg_to_smc_with_parameter(hwmgr, PPSMC_MSG_UVDDPM_SetEnabledMask,
 				data->dpm_level_enable_mask.uvd_dpm_enable_mask);
 
 	return 0;
@@ -2912,7 +2912,7 @@ static int ci_update_vce_smc_table(struct pp_hwmgr *hwmgr)
 		if (hwmgr->dpm_level & profile_mode_mask || !PP_CAP(PHM_PlatformCaps_VCEDPM))
 			break;
 	}
-	ci_send_msg_to_smc_with_parameter(hwmgr, PPSMC_MSG_VCEDPM_SetEnabledMask,
+	smum_send_msg_to_smc_with_parameter(hwmgr, PPSMC_MSG_VCEDPM_SetEnabledMask,
 				data->dpm_level_enable_mask.vce_dpm_enable_mask);
 
 	return 0;
-- 
2.26.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
