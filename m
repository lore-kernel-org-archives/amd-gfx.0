Return-Path: <SRS0=BT7C=ID=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A79BC433DB
	for <amd-gfx@archiver.kernel.org>; Fri,  5 Mar 2021 17:51:44 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E285364DEC
	for <amd-gfx@archiver.kernel.org>; Fri,  5 Mar 2021 17:51:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E285364DEC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 752D56EC06;
	Fri,  5 Mar 2021 17:51:43 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2060.outbound.protection.outlook.com [40.107.243.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 501766EC06
 for <amd-gfx@lists.freedesktop.org>; Fri,  5 Mar 2021 17:51:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RbqnfAFUvNjtVkFh7ywLHC0r7urjO+mim8dKRwQMlFuarFxOJMgBkKEKqsOgOr/GZ/kG0qaxWOzE3ZNjWFz/w3//O1mY/jq2UOrzzABAhYfC0qqJ5LWIbzenzHIYtYSPzskk/4WKZfNQ5VVZ3YuW4yzDNu8hYXGHIY151FVnoUBDB2QimvL+KGk3MUV3dcov7Tq0FQwO6hzPoh8F7xCErZWUD4w3n4vtJc/S4TRPrzBrWGS5rD6NlrpycDJf0hnZdZCT6jHcw+dxqRIXGhmDS+W/bDAjfQHInM6fDitCazrKkLXLA7o1byqpCFoqKkAbNZgiFDAVoJ/kprC4Y+wNhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=63OCSeN/tq3lhUHzH0EKC/JcpVhv7XpOqE0+McAatfE=;
 b=ZDI3SfoO5Pg7DDmINKxrvgikDDYzOnqrgW4hG/ivMqCIX34OFaK3PtOZWARY/EDhKkVKDTP+0OPm0uo1WkMaNmlJLEp0MedRdl5RCZpj8Nw9aeTC0WDgDLTxkmi3QmqpBNI6z0N7QSoioIZQzrppVnnLxhk0g/KBvjDaDmYZMOZKavyADZPm2VD5Ju71SfF9LZ+xKs85CVpVSpcDX13V9dTCtz5ZPIZmNJ8oEV406gZx7P7RHIIkeRp5bH+TAwLn3Non+ocbDihJjcu8tIOjx31nI7WrAcX7DAcAHGeyQC0BwOCHDTgYL8A1yIeSYEI0KQehW/nxKVJU0JhJ/H2A+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=63OCSeN/tq3lhUHzH0EKC/JcpVhv7XpOqE0+McAatfE=;
 b=musw9p9lqUCv4U0k3RSvzZ3PJSPu4yEjjuZAaUDZR9x+7f3xcweXBVPJRDOltlpCL/1RyVJSS1Apyv7xJvJYQNfJLISd04ZU4t3o6BAMC0S2z0EYMMOpit4HG3GMTczYQpOIf4TxZ2z1XZB223yRlUhIE2xG9mtN14xD2oUTE2w=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3835.namprd12.prod.outlook.com (2603:10b6:5:1c7::12)
 by DM5PR1201MB2491.namprd12.prod.outlook.com (2603:10b6:3:eb::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.19; Fri, 5 Mar
 2021 17:51:41 +0000
Received: from DM6PR12MB3835.namprd12.prod.outlook.com
 ([fe80::102:2c9a:54ce:63e9]) by DM6PR12MB3835.namprd12.prod.outlook.com
 ([fe80::102:2c9a:54ce:63e9%6]) with mapi id 15.20.3912.025; Fri, 5 Mar 2021
 17:51:40 +0000
From: shaoyunl <shaoyun.liu@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 1/5] drm/amdgpu: get xgmi info at eary_init
Date: Fri,  5 Mar 2021 12:51:28 -0500
Message-Id: <20210305175128.31970-1-shaoyun.liu@amd.com>
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [165.204.55.250]
X-ClientProxiedBy: YTXPR0101CA0066.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:1::43) To DM6PR12MB3835.namprd12.prod.outlook.com
 (2603:10b6:5:1c7::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from shaoyunl-dev1.amd.com (165.204.55.250) by
 YTXPR0101CA0066.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:1::43) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.28 via Frontend
 Transport; Fri, 5 Mar 2021 17:51:40 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: b929f085-6904-4fa0-6f37-08d8dfff54bc
X-MS-TrafficTypeDiagnostic: DM5PR1201MB2491:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR1201MB2491E82D4ED8C4E63856EFE4F4969@DM5PR1201MB2491.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1850;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HQhth9CVAQvdd98NJIP5jcJGX8v+QfPchRZqpmvoltuHAqCEzpXlQZsV+Hqq/CkobNqgG+YqZUJ0tQKmB+7GnLbk/SCeMAXYmhVVf2ST01NtBw8YQK4SJUbJ+3/SXk1RFUp5V1WbuOjsnCQZDcfafZzc1riFDtCIkAUU70osKm7bq8WMWRSU37X21zv23ky0TK2gtb35m9w5vnOtcGOL2f0WxX5sz+6RD+s0mZy5MibQKefGuFvR4pWajCHGdJ2hRdQSyIJLMgrWfP4ZEZWy9+FnWgvVp+H4srOPjperjiAuF1siUfYI54q+GsB1NT697ykTR/nqVL4aq/dvQjX4yyJBepTOqt4VcybBM31/OcIu+TAr6/gCz/N3Tl6OqbqezFx3GnHbyaDcXSWpD5Csy9fTsx+iBnw468BHTxwxGZlT4RdZZ54QOiK/br3VUUYG4tgWTDKbQV1V6tu5XLJrZ5xjVFTY2ihdBR+jTl1tX4OGeMRpe5wRwsK/MT2+H0Wfg5v82x8KpJjpbFtF/snozcahEO+AUUFQIe6QH/qc9rV3or62VleMS0JBFWSAXS2w
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3835.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(396003)(136003)(346002)(376002)(366004)(956004)(26005)(6916009)(6666004)(83380400001)(8936002)(2616005)(86362001)(52116002)(478600001)(8676002)(186003)(4326008)(316002)(36756003)(7696005)(66476007)(66556008)(66946007)(16526019)(2906002)(5660300002)(1076003)(6486002)(43062004);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?QmZPUW+b4ZGl/tRoPUqhqHRZYlz2gwPJUPgMICwO36JJaKcu9rYLvw/eS7Ow?=
 =?us-ascii?Q?wCbChlMnoMU0HEeyZh1fi8khQKBfVRq/emkaJG3cctGCKiiwRRQqHOBh06+R?=
 =?us-ascii?Q?F631aX6EA0b4H3btcOIzTHEF9OcEDQemewvy8qWAtjMoY5SLWB+vx/7+1mx4?=
 =?us-ascii?Q?s6jAX3/GdxRDxX8C2Is3tLlRIqycf0TXTdW8uwfov10kwbHfKNJma5RY+nba?=
 =?us-ascii?Q?WRFdkjwGQuhmMtwMb0nQNkvsJ1KKskuGok8RsziGZKubP23xQ5NtC/qoz77i?=
 =?us-ascii?Q?AYrGepRq86H7LtDGsE3Bj+pyol7+rtHSgnNGNftnTUkhO5nC9f2WeCleNGwt?=
 =?us-ascii?Q?L6Tts4+r0RlHSzDFN883Cn7pR/Yxf3dFeq+8OU61UBNff5d4eD5I7OQUUFcA?=
 =?us-ascii?Q?f+Vt2rgRTMlyvAtg5GS91xciMeT9D/Evyl2hRrb46fcCWV4uWdyqBysQpCd9?=
 =?us-ascii?Q?v/GcrgLGYBRNFOnN8Ljddc6nUZeVi3Q8yWrCBrY+T5xxGGukgc3r7qrhXQhE?=
 =?us-ascii?Q?WZg2YVhClDuZEsr+sdQL0mjqBOHNt7nn1H9gPn/44Bs4NA6bz+z6UPc28p/M?=
 =?us-ascii?Q?N1+22QHYjh32EMZXAXb2QiiTWvZyAYEZeGtFbyKoIje6CHgOh1CoEiZ8xVFZ?=
 =?us-ascii?Q?XpDweY9CyENzMJquWIUi5ROoR6Q5/Roim4vCsCQ7Y1v5Af/pEYtXRM6fmQot?=
 =?us-ascii?Q?POTWlUd7poPwpkaOay4Ex/4Mcaj5XTi592xG7fi1T5qbrviLzxraZRm7iVp5?=
 =?us-ascii?Q?kvDrj8RwjCXwWs2GPL+Ug29NQJx/KHdqyqadNT5cPJSRjESFLHVqjmIiJ8hW?=
 =?us-ascii?Q?fcHnyYLQj+/RLdFUnSA0kePU5vMoOP5y1reGGrsE9dgD0jneh0f024nvd5rR?=
 =?us-ascii?Q?pJhhAZcxU+B+cb5XFp8QsIl3Eqz8NmSvFGSYhwA+cWLezaZh+vBMZHhEWQiV?=
 =?us-ascii?Q?4JDJWDF4GuoFhbckDuZnONU/9PWMKIfvYEHr95ALofeLHDz4F+uAK+0oi68I?=
 =?us-ascii?Q?5bB0r/Wfjm+pl/a2kOHPK0uEpE2M7g8KYLA/7bXiertBRwGqmY+9xwRm2pT5?=
 =?us-ascii?Q?Mhtk2dQoWyNH0JR4hNVOZ5xuyNoBMGuY0RwKIcExNz5rY4fm7GC2qiKl+wHf?=
 =?us-ascii?Q?kg5R9LqZ7khyikCi8F8llwUIGHhFWUwja4G46DwD7U69jffZEkCepetgXX7a?=
 =?us-ascii?Q?DGJ+iSe/MYXeoOS7426Rbv09eEysnkYUFiMOv2q6J88jkR53Kq4zM4ETQN9V?=
 =?us-ascii?Q?XUKl8rdp7qnkYcYLga4T6Ikw3DYml+mCp3uJbVY21IYlbRFxQD2qjsAwdZRq?=
 =?us-ascii?Q?IlaQIm8E6i4gha/mQn94wqRo?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b929f085-6904-4fa0-6f37-08d8dfff54bc
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3835.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2021 17:51:40.7393 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UmVr7ooZbPoxDOowEv3T3OEHdSxpfcxzAR+XxWWp85xvpKVfNkE/ZrY1PphJoUp/u2P8cKOYwMuXeslHihNJ9g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB2491
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
Cc: shaoyunl <shaoyun.liu@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Driver need to get XGMI info function earlier before ip_init since driver need to check
the XGMI setting to determine how to perform reset during init

Signed-off-by: shaoyunl <shaoyun.liu@amd.com>
Acked-by: Alex Deucher <alexander.deucher@amd.com>
Change-Id: Ic37276bbb6640bb4e9360220fed99494cedd3ef5
---
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
index 3686e777c76c..3e6bfab5b855 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
@@ -1151,6 +1151,10 @@ static int gmc_v9_0_early_init(void *handle)
 	adev->gmc.private_aperture_end =
 		adev->gmc.private_aperture_start + (4ULL << 30) - 1;
 
+	/* Need to get xgmi info earlier to decide the reset behavior*/
+	if (adev->gmc.xgmi.supported)
+		adev->gfxhub.funcs->get_xgmi_info(adev);
+
 	return 0;
 }
 
@@ -1416,12 +1420,6 @@ static int gmc_v9_0_sw_init(void *handle)
 	}
 	adev->need_swiotlb = drm_need_swiotlb(44);
 
-	if (adev->gmc.xgmi.supported) {
-		r = adev->gfxhub.funcs->get_xgmi_info(adev);
-		if (r)
-			return r;
-	}
-
 	r = gmc_v9_0_mc_init(adev);
 	if (r)
 		return r;
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
