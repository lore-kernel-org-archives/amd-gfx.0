Return-Path: <SRS0=0i2d=KW=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DC95C47089
	for <amd-gfx@archiver.kernel.org>; Thu, 27 May 2021 12:15:02 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1C7F361378
	for <amd-gfx@archiver.kernel.org>; Thu, 27 May 2021 12:15:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C7F361378
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BF6B56EEAA;
	Thu, 27 May 2021 12:15:01 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam08on2059.outbound.protection.outlook.com [40.107.101.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 97CA66EEAA
 for <amd-gfx@lists.freedesktop.org>; Thu, 27 May 2021 12:15:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Lr90LtXnOM0a8oy6kvnnUuqp2jDoRYDVx0T222ebLenrCGNkGrBXWtMVV8JMYirHTGzYBEBDgeXLlO7Fi924N/0akE7J8AJIB7k9m1iBPtbFUfYSjAGSmjLcncjPfJSfE7lQtFZUZR0inAQ0z0BPWESJuyr9+itygVcSQYqVtjJ0LU00fJUomjUmLAtd2dQjWR1S8E/gne0tpkXJCckf/UI0jiUNuviK8pe6LkK28xiV8JKwC0qStMngudTTadiA8Urnf6b3arnZuB9tRtQYLKcNxFJCDiudDrMb7FarMiksdZ+I2LLYo3MOEKkmQY08L0UmbScMDK5DGC2V4KhBBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0CC9R6jxZryFe5sheRNvRLq6z9MvU9Ng+g+qgMItlTE=;
 b=boFyF0zk++yCzDFBFYf8clXyO1+e2jDz7QasMcGcfoo2ejUSOhjXfRdmszpAu/FQVoR+XcMDmjO0oxKj397Dy/izINT8ci/72X5GMacSWt8aaC5SSxAsxg9KJviazUFcUjMt8t8h6SxDUb9KkCG3Qzah7YBEBOO8bA9XgE7WL8vef0mmuc9FUGo/fztRqkp3UOrL5FERkb7CpR5nX6zFaLAW3H2IX3zXNdCIc54syUHVQkxshl2IFiSmelSOTxt7UZgDaB9UYIXyRAf+P/GN8Ur+HQpxthRIUx7zq5At1asOOGW5ExLe1nQAi4KCwz8SYeXAk72st2faaOQn9bXGjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0CC9R6jxZryFe5sheRNvRLq6z9MvU9Ng+g+qgMItlTE=;
 b=qQdHClAmWVlkdvYAki4CA3zXPcC85gpRvX+c+6j+sqJyYdqlhgVqsjpbBhA7nf3SJxi85WPFCNyURc4PbAkOd0D8dSb5fgSKUKWC0r7U4Opx1TOfrwSNG8wUS93n56myLEc7j98WDbQkjpg/Qqus0li+f9UjANZGwZEIJbNRe2E=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5136.namprd12.prod.outlook.com (2603:10b6:5:393::23)
 by DM4PR12MB5200.namprd12.prod.outlook.com (2603:10b6:5:397::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.22; Thu, 27 May
 2021 12:14:59 +0000
Received: from DM4PR12MB5136.namprd12.prod.outlook.com
 ([fe80::4074:4943:244:a5fa]) by DM4PR12MB5136.namprd12.prod.outlook.com
 ([fe80::4074:4943:244:a5fa%6]) with mapi id 15.20.4173.022; Thu, 27 May 2021
 12:14:59 +0000
From: Nirmoy Das <nirmoy.das@amd.com>
To: harry.wentland@amd.com
Subject: [PATCH 1/1] drm/amd/display: WARN_ON cleanups
Date: Thu, 27 May 2021 14:14:48 +0200
Message-Id: <20210527121448.33713-1-nirmoy.das@amd.com>
X-Mailer: git-send-email 2.31.1
X-Originating-IP: [217.86.111.109]
X-ClientProxiedBy: AM0PR02CA0006.eurprd02.prod.outlook.com
 (2603:10a6:208:3e::19) To DM4PR12MB5136.namprd12.prod.outlook.com
 (2603:10b6:5:393::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from brihaspati.fritz.box (217.86.111.109) by
 AM0PR02CA0006.eurprd02.prod.outlook.com (2603:10a6:208:3e::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4173.20 via Frontend Transport; Thu, 27 May 2021 12:14:58 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 93e9b01e-b9ed-4211-32a7-08d921090c51
X-MS-TrafficTypeDiagnostic: DM4PR12MB5200:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM4PR12MB5200C4264FD8179434451D428B239@DM4PR12MB5200.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:346;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KMC2McX0ueiB9ztBLDMz5GeAGXdstIfrO8CZ2Bv8ooTRr6mnP2yrcSufPqD4uadpoS0HB4arQ17ouR/YpTeCamGW/iPJhItVuFP2c2ndlHNsIFd7xr3CanWl1mlU+gvOuwFU9KeeY6M/YUgy1sstoHT8mQrwZsA4P6LZGfiLhQiXGSsuYJ0Dd8sP1kI1SujrZIC+ojYZvkwZ2QD6aGRUc06kArAboOkWR9RdhYEiWSjqT3BsZhIZ70U47j1TWbQbeUbKt9HlkcZjoFbtVq0zHsoKc2VqxpvBbhdb5la1VE9nKb4mHoNHbAgdOJ4j4ZpUumd0rmy8J2hk7wHOqcF1VFHLuWYuWVddMAfEeGyR+2c5eZ83gGYnpx6ScIDmOh8SlAGUbGsVVUC9AOVO0KLULv3/AoNG2D+ePg38QUh/p4VdS++1ub8cxizI1i03xSCJxmc/nXE6owuTN1QFmACtoOS6LB6d1m1nE2pGYP9SQbnbyqd/XWmkdHyP9s37R4UBIbHOsUKazDWyFlgZ6DKqQqa1K/x77WudYfgx+cpSm/8i8ikdXMgbJmqYr093epCB1kW8YGtmTMmWt/ThW7/GjQnEePWcj19fvpItunclWfZYXjYExoM/SRH7Fp/SXBAznHGFw9wplxUxHZBUeSTjIz52KeQF0XvKLh9cTcGmolI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5136.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(396003)(136003)(39860400002)(346002)(376002)(52116002)(6506007)(38350700002)(38100700002)(37006003)(83380400001)(86362001)(34206002)(478600001)(4326008)(6512007)(8676002)(6666004)(6636002)(8936002)(316002)(36756003)(44832011)(2616005)(956004)(6486002)(16526019)(186003)(26005)(2906002)(66476007)(66556008)(66946007)(1076003)(5660300002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?I38aryvQ1qwPsVXTzTafU2AW/2fQHD+IPiALmSs5IkT1tiC7B/ZMOCddksGW?=
 =?us-ascii?Q?E+Jh2aTjyRr7UhbNxNQ1j9hEbB/Oegpp3Jqs3VtMA9rXh4TJjksSeA4rJxEE?=
 =?us-ascii?Q?NE9krxgShuITI5rI/mQxerC1rAVmnVlW2Ll+Liq8PRNtorZR/Zaju1x3ZiQq?=
 =?us-ascii?Q?2foTNxqMghTm7yE4RkB6qSkDeJTYvzlHPB8sJV7nYRFBYImeCyk2nR5IkIdJ?=
 =?us-ascii?Q?8E1LZLjItP1NtJ0cr/UkQasjtXlRmDiO8XYsbudQgTa+z+q+Vz/3wcwXYhHn?=
 =?us-ascii?Q?96O4B5vWuZ1TnsIgPo6//czlZUQ+U6jUMHGfDmlBe+5IyfkJhMN9VZuKfJr3?=
 =?us-ascii?Q?d1VtkHaduIOL4ldMM+W3JcSlLcDZJc32SuPGfG57lDYPhSYx269s3E6CexMF?=
 =?us-ascii?Q?hwMA13lyDNcUSm4TEVgD5v05swJ60CiJxNbHOkQk4f37C6gpaQiInT2kihph?=
 =?us-ascii?Q?KlZ/MKosgjzchuUdEhb6QvLjZqoCgJvvD5UpeNFMoRGyH4W0S0C1MIT2ZMuy?=
 =?us-ascii?Q?ZyH2kBMr7m7TAXD9qXWgOKiKOEo0eBCHazmQ713SFERs33cQ8GoiNe9ztKFB?=
 =?us-ascii?Q?mnghLlWekhx70Lg0MjOwxg+9iO9fm+p8KhaDroSI6HWWn23te/bfcaH7ei0P?=
 =?us-ascii?Q?X3x07ad4XKUlA05H6vVSAF8ll7kTRqH5DQb/kFz6cI/fMCcK7bTp/woMNSx+?=
 =?us-ascii?Q?2ZkPu5RQqljz1VZoesjC2KTsbW1aPK7vXLFzcbtWdVVPL55OUjvIuedYAcPa?=
 =?us-ascii?Q?bF5gnBtX2TMrlFDZocCMqER0APnuBeHhI139TYdKwJURoa5m1swI3UyfSNTh?=
 =?us-ascii?Q?l9tw6kLnQVBfITzUubDoIQlR1FniAU3KNdbAXp8n1W9KpQYYhYqGscNNhTb8?=
 =?us-ascii?Q?/Onw22TxQb7w73IRJN4EcvvEXHmxTp1uSS0884RZ9nCNcyKs0GT72LpWC8/+?=
 =?us-ascii?Q?ELaoHT/AlEoNOcrCp0YJ1/JMEhjF5rFFzdQiM22Vz9jlV66istR6TuY5rwwI?=
 =?us-ascii?Q?yhxFQ2tFlr2knLNHWCBNMqynTD0hoWLfD1NzM3RcQay/WpUjiK5Hf6n2c/Qo?=
 =?us-ascii?Q?EZGPqgpLC3/Ykg+Dc/vOOTqfq6M3DS2uSZ50TgT6/Vw5upvWaomNiBx4vPqQ?=
 =?us-ascii?Q?WC+MVA+wytE752QZ0c3ccWYGTAiAJHOl2b+qiVjGxLUbiaLeZowO6dv+/te1?=
 =?us-ascii?Q?jWS5w4zkk+FvB9kUhc8ThcGN741Z8DpHPwX8yNcov16PzOCty+uIfGkWXeAn?=
 =?us-ascii?Q?mOpHm8O6y7W7DX7erIqsLUSo+Mt5k2zWOnZfC70AWzxk9rvBgxwZVCwAGqNK?=
 =?us-ascii?Q?4obMmX5jibGwf01jBmpylcCd?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 93e9b01e-b9ed-4211-32a7-08d921090c51
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5136.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 May 2021 12:14:59.5622 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: S1go++qHhG3LA+Z1Q4zhzgF7y6JPYk+5epH7BkIyGB9JM5xC5Y04X053qdYTLHxHsK8tdoi0K7QPihcfmnrzUw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5200
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
Cc: alexander.deucher@amd.com, Nirmoy Das <nirmoy.das@amd.com>,
 christian.koenig@amd.com, amd-gfx@lists.freedesktop.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Uuse WARN_ON() inside if-condition when possible.

Signed-off-by: Nirmoy Das <nirmoy.das@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index f2ed51484980..736eb537a8e4 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -315,8 +315,7 @@ get_crtc_by_otg_inst(struct amdgpu_device *adev,
 	struct drm_crtc *crtc;
 	struct amdgpu_crtc *amdgpu_crtc;
 
-	if (otg_inst == -1) {
-		WARN_ON(1);
+	if (WARN_ON(otg_inst == -1)) {
 		return adev->mode_info.crtcs[0];
 	}
 
@@ -397,8 +396,7 @@ static void dm_pflip_high_irq(void *interrupt_params)
 	e = amdgpu_crtc->event;
 	amdgpu_crtc->event = NULL;
 
-	if (!e)
-		WARN_ON(1);
+	WARN_ON(!e);
 
 	vrr_active = amdgpu_dm_vrr_active_irq(amdgpu_crtc);
 
@@ -6698,9 +6696,8 @@ static int dm_crtc_helper_atomic_check(struct drm_crtc *crtc,
 
 	dm_update_crtc_active_planes(crtc, crtc_state);
 
-	if (unlikely(!dm_crtc_state->stream &&
-		     modeset_required(crtc_state, NULL, dm_crtc_state->stream))) {
-		WARN_ON(1);
+	if (WARN_ON(unlikely(!dm_crtc_state->stream &&
+		     modeset_required(crtc_state, NULL, dm_crtc_state->stream)))) {
 		return ret;
 	}
 
-- 
2.31.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
