Return-Path: <SRS0=z84W=H2=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1563C433DB
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Feb 2021 02:21:55 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9080E64E09
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Feb 2021 02:21:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9080E64E09
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E26046E3E5;
	Wed, 24 Feb 2021 02:21:54 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr770044.outbound.protection.outlook.com [40.107.77.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8F4E16E3E5
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Feb 2021 02:21:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k3Lq2i0T7j3MGy/NpvYEMMHg3V6b6wpsg1B4oSNUXeaglUT/biN51+V2sOx+aVtZUXtemAaFiGX/+44oIHLfcjoXUV7PjoTupfl9i2E628J+ecxzD/gdLc6Kkt5bjXNa+io4jaryj0AiVezNE5G7Kc6ZhbcZJLUhZ0VrFLb3U/VJOb6D92brQv/3j0WE6YrnqN9zvto+EM2Z5Yz+0IgBrWotexDJdfYE4XrB9BG2NID3l9buaBRXtBqzpquDMY4Uem0RcHk3Qr+YrDs34hj3SVXmLWXG/jbW5VHjTf08pr3IMQ1MzhVwhyv4wPYbmXQmSsZnuUbiPl7IWfwbf9nwAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=63OCSeN/tq3lhUHzH0EKC/JcpVhv7XpOqE0+McAatfE=;
 b=W/KYRqCkXIQEDZ5SQMSC234h6LjzXOrs8xFixRS8bLzbwcXU63Js8jkpZQdkXn7AN7pj6jtJJrjfigWf8OqIaXdVX4+uHSgM4Xaa73dFiBvAlSMCmazFBiVxyjRfuMxoymIdSGPQG4CMtb27JSQUZn/jaAeXyLjcywUCGvX0H2e0nwh/VeT5p6PM3t0khqffPp2U2epsuVmLlk5Yu8AW8BL21ERbYvb6L+LtS5dPemD9QVWi1s7nsc6W+OPcphDyv9E+17upc3/7E2Ju8dW1lPHI/09U/3IDOECYEltjo8OzSstFGrmLo8bDIohMGh5dbiktSU5fa253s6Cj1VDF1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=63OCSeN/tq3lhUHzH0EKC/JcpVhv7XpOqE0+McAatfE=;
 b=St3+PTEB1Iabx3pVNnyIS4ONqbwFSFGdx4YM1xUgKDbFHm2DNcW0YHPaN8+0Cu3pmhk88MO50OZux1O5m1VFgA0QVpElRPFbZEpyU5iKmtvV9S39yy00IetgkeSzMnOgAb7IWKdhHHbBbATqRDE9suTZZquMklIYio9exP8nOKY=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3835.namprd12.prod.outlook.com (2603:10b6:5:1c7::12)
 by DM6PR12MB3594.namprd12.prod.outlook.com (2603:10b6:5:11f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3868.33; Wed, 24 Feb
 2021 02:21:51 +0000
Received: from DM6PR12MB3835.namprd12.prod.outlook.com
 ([fe80::102:2c9a:54ce:63e9]) by DM6PR12MB3835.namprd12.prod.outlook.com
 ([fe80::102:2c9a:54ce:63e9%6]) with mapi id 15.20.3846.046; Wed, 24 Feb 2021
 02:21:51 +0000
From: shaoyunl <shaoyun.liu@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 1/4] drm/amdgpu: get xgmi info at eary_init
Date: Tue, 23 Feb 2021 21:21:37 -0500
Message-Id: <20210224022137.23273-1-shaoyun.liu@amd.com>
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [165.204.55.250]
X-ClientProxiedBy: YTBPR01CA0015.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:14::28) To DM6PR12MB3835.namprd12.prod.outlook.com
 (2603:10b6:5:1c7::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from shaoyunl-dev1.amd.com (165.204.55.250) by
 YTBPR01CA0015.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:14::28) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3868.31 via Frontend Transport; Wed, 24 Feb 2021 02:21:50 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 40191a1f-b6d0-4254-2c1d-08d8d86af1bb
X-MS-TrafficTypeDiagnostic: DM6PR12MB3594:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB35948B226EE9C41902A158EBF49F9@DM6PR12MB3594.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1850;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0qjsLAKoWpDus09DROZkyWQBa7PlD/0LRr2Ok6xTzia+f0Hp6vO/N6XEHNEhnsU3v5NWwChz+O91XJ6dgfMjGEaeobSkdUqC+ToSl81ZyPa/Dn7QyBjOo4FMwTWOwtaSKkiviMeAZ/J8RpTlRp6EprnmLDx6iA9R59brUKqcgyzTarBYNQDuk4vOXGs3kyQOycWQGcQNwOMAiy5v0DGTf5ZfLoGzm13g3/Ug2U2+qoribY3TiS906GPI3Rq3yIvapvLKwB+F0G/9bNcQTzvJH4PrNVXloGjDaqxbodUeLT/Nviinj2kIor6/kULcc5fFjoInowKenoEL7CAlPwWifAffAXlGUmCubMvXEanLCLj8R25wrn3m1maKoOEDldn4ekMrMafXol3Or9Zh2VMUipefhg/+9NNEPplZR4kOdkm3hpz+mN2oxPMfn8/pfNMMJgr6Wi0tNhIgRIaUrBkB7POdyvFEGqiPm8cufNrR4Lci9vktGUpqf77/dNxPUgU51gimd4lx1JsYn/q37CtHYEmsYOCt1y00D3g/yjsOpFUhNrQv32PqL7vq6QUN0I2J
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3835.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(366004)(39850400004)(136003)(376002)(396003)(316002)(6486002)(16526019)(956004)(86362001)(8936002)(66476007)(66946007)(186003)(8676002)(83380400001)(2906002)(2616005)(1076003)(6666004)(4326008)(66556008)(6916009)(26005)(7696005)(478600001)(36756003)(52116002)(5660300002)(43062004);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?dgt7G36jmIwIeagGziIyGKhIH/Vug+ffMhmnRR9U/nVzENFAO77+LN5eq2lK?=
 =?us-ascii?Q?guWOTPLYn+mJSRHI8aKCcDBMaWV6Lm/tRSnk4CsnFcUvgXUs7Krq+VJIGke8?=
 =?us-ascii?Q?f+iV596YUH7QWR+qKDHFL0wqFrRv22xFt91QGlfwwNL5qtYwCtG4APb1+EtA?=
 =?us-ascii?Q?JaUwkX5WpLKRXFVFkdFBpBTchMi86eQWuxV7Qo9xoC+lJAbFo0MmLNHfw45H?=
 =?us-ascii?Q?2CcUgyqDjVAhKHGC5/TYLSpWqj5ANdBtMgOnY9TqZAtt+OPKizw5TrJEDne8?=
 =?us-ascii?Q?gBtbkW9SubmgJZTrRucqckucuXeuvmKuBtafKv0dhEbfjMiR8PEpZOUR47Fl?=
 =?us-ascii?Q?3CuXsJD5MD1U/FxZ3a0olp0l3rH2Bpg82kC/RDp3rHEqOJbRJIDRK9Qf4B9Y?=
 =?us-ascii?Q?8koYip+LqQNhljny/Fbs+rjWX0a3gSfn3JIS6xTTHJEXdr/peWjrUDvsxqVZ?=
 =?us-ascii?Q?Cl4zhAsrwCVeTFfUqXA9uwgBLPZ2hNc2ULLTT5AqsglYeTXDKLMJ5XX1mWTu?=
 =?us-ascii?Q?Bjv8PZ/9lcP14YeAiA8r62EW2eTmlBxWJQOzsja4c3E3OQjG06l/yRq+qRLg?=
 =?us-ascii?Q?VlUCLJ/ZWs8TexnHiH2OykJKQ+F8T1I02BcF7W72+qSYKkp8rlaAiHuthWaw?=
 =?us-ascii?Q?hxS330nouUI+onkzBzLuKhcKMaB6roxtX4E9TKoUw7yiCbo/Smjl1uyi+taU?=
 =?us-ascii?Q?+JzVVLoKtYanmMsDJZlYymN/w0X/fRggTv74S671HjN4YsU7pFkBNlEkD1fS?=
 =?us-ascii?Q?83yn+WMZA35YY1KPZHn3SgOLNsskgG55klPQN9Xdaim4SJOmJjOqWKPeNfZh?=
 =?us-ascii?Q?+9xHUOhYUiO8cRYka/3zkLHNR7fvkhjTVWiCKIzPu6kIMMtfNINJGFBvU55j?=
 =?us-ascii?Q?kJGmkqiVLtmFRcJCNO0/Kvc69FvSS0J1Qq63AVP51nPipwy45kNgexAEZjvg?=
 =?us-ascii?Q?MC5ti0/4GZvViHwkY/HBqm+6tUqpFG/UIY3lwgH07OhyPNE0eGB5h5mK049X?=
 =?us-ascii?Q?N/up74mTWen0vf2+/Db2dVBxm8wGn6ZHxWACQNp/wOi4P8Jjfue3m/uD/q3E?=
 =?us-ascii?Q?POU5JxT3l00SPbPZF4xzz+wiTo0qYqv+qcUuYS1buq+OalaVZifTIpEbbHnB?=
 =?us-ascii?Q?0k1itHSZlqHMP9hwsvQI/FLNfJ7bsR83eWD8Mcmm5hDlGpcArnlUBCAntIoX?=
 =?us-ascii?Q?NpRukUqvENegHjREhCWudyZeTwHQkDWExaKafcl5uETvAIk+l7Bw0nV+qaQ9?=
 =?us-ascii?Q?hAzk7vK2/gTDCjWvbDBlk0gmQhnj9cTO2pnSQqsTy+MEU7+bhfoCjt4Tr/2E?=
 =?us-ascii?Q?sUcxUmv8GitodLc3RfvY++M/?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 40191a1f-b6d0-4254-2c1d-08d8d86af1bb
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3835.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2021 02:21:51.0451 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 71+4hP9oat5+BycguNSc9P+x6vhznkU3UbX1E5bvBb/rfOzQcyJ/agpb0gNIZXyUCbycF6uGORzbP3uCPAp99w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3594
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
