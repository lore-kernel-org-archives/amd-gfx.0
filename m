Return-Path: <SRS0=r7JW=B7=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E249C433E1
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Aug 2020 01:29:34 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4506A20738
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Aug 2020 01:29:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="f8SsBjUF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4506A20738
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E80FB6E08E;
	Fri, 21 Aug 2020 01:29:33 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2040.outbound.protection.outlook.com [40.107.94.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3C7D56E08E
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Aug 2020 01:29:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l3/sNxrskrDefT2+o5hyLsT2+YBVhX7ikbgeMBr8nqRzlI8sYJjils5ptPKFauhw6Y/B6LEu5Ut8eob6w1qyP+9PR4GQjXHkWj2M5w7BpRJXvCMpVzVakFiyl8LMME6Oh/zsXbdKrgiT4HI/pDak1lfMOpe16mNGamcGwQEcRTdIHS20tfYjewB4KfUJWnbAj5yuy8BlMgq/qr/SCfVpgeVTV9z23tRf3c33H49gjr1Q9Xfy14Bjk+RAbGuez38LTKGHmIzrQ1gT+T79EGxMaUlf0jizuMwXvUI0v9LsC3HMyACeQo0nnx1QFWgKHEqjQkrhsublUs9jwHWRfDEAxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5OgUPmYjpz9L1cjHQCAEB6ulcdJuf6jNGgxB//3+wGE=;
 b=bG1SBX2dULA9930IEZcs48AFRcX2j9mJtqkTth4yB11Pnpkxdsp/1NZHvcwr981xef8CTYsoTxiX6a6L1weqCKfLDQjznGZPkKRS37dQ5YuSE2Qnnc4hie43zyil3ft/XR7mMKS8yspHcofe5lXZpZ0gZaZbYCtek5OWcUGI6q4n3dtl0YjJknD4nrOBPCsu0yXxGe88CA508uI64qUl9MRW1R/n1oHco0LYn+tYXB9U2IsBZH1EbPS3uJytEUMneyEFwhipBcaizwWnlsiVyy4YUDpQlneVOjzM8YrOCLmYdbsnHbQHwx65hp3HGbXFGGyhiSV+JdDroOTL1CwwWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5OgUPmYjpz9L1cjHQCAEB6ulcdJuf6jNGgxB//3+wGE=;
 b=f8SsBjUFDtP9Rar+BPSBujTObqSnAUzfGt44dMnnymImZsCQVSmelxRx8TR3kAau59QOXEfNsUhM21ZT76ehHUw6K4GSKH0ERGiahVeHy1mRrmNP8ASxfRMZL7YhYg2ACLbJt9NNEIPZVSsbcXHIm/hYR01JJ9XDzak+4gyW8lU=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3774.namprd12.prod.outlook.com (2603:10b6:208:16a::13)
 by MN2PR12MB3837.namprd12.prod.outlook.com (2603:10b6:208:166::30)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.25; Fri, 21 Aug
 2020 01:29:23 +0000
Received: from MN2PR12MB3774.namprd12.prod.outlook.com
 ([fe80::9cd:9d82:d316:9285]) by MN2PR12MB3774.namprd12.prod.outlook.com
 ([fe80::9cd:9d82:d316:9285%4]) with mapi id 15.20.3283.028; Fri, 21 Aug 2020
 01:29:23 +0000
Date: Fri, 21 Aug 2020 09:29:13 +0800
From: Huang Rui <ray.huang@amd.com>
To: Alex Deucher <alexdeucher@gmail.com>
Subject: Re: [PATCH] drm/amdgpu: enable ATHUB clock gatting
Message-ID: <20200821012913.GA322098@hr-amd>
References: <20200820210504.1311186-1-alexander.deucher@amd.com>
Content-Disposition: inline
In-Reply-To: <20200820210504.1311186-1-alexander.deucher@amd.com>
X-ClientProxiedBy: HK2PR02CA0187.apcprd02.prod.outlook.com
 (2603:1096:201:21::23) To MN2PR12MB3774.namprd12.prod.outlook.com
 (2603:10b6:208:16a::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from hr-amd (58.247.170.242) by
 HK2PR02CA0187.apcprd02.prod.outlook.com (2603:1096:201:21::23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3305.24 via Frontend Transport; Fri, 21 Aug 2020 01:29:21 +0000
X-Originating-IP: [58.247.170.242]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 1eed2189-47be-4ac3-2b1d-08d84571a24e
X-MS-TrafficTypeDiagnostic: MN2PR12MB3837:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB3837209B90F66C24958B6584EC5B0@MN2PR12MB3837.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:376;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ggjkfDj3K74xuW882umXCprljuGu3S8X2Zg9vMu99ivqFESuq1trAwpofovIia661jY3K1SgCllNlyUVjrpaavm8pIBBD8QzwA4JlOl+2NJ4XaA6A27HvUzQcPErF5BHPc1iTDZ3tKtWiUGpCpqdC9Yotj7jF+iXu79ICNCUoemooNJFRuYYewmqhzKbIDdVt1m34z4M0mDGgfFHjw7yukKz3VUuU+OHW94dKXYB78GQbHRx9md39J5C5Zgy5sqiO5cil2W+WerhuFjObRZNwV14U96U0c5db/YRMbBlcWqKIkEO2OWZF1EjWHYPbH+pq6TSxOZ8hrj5wqxy6YDxHg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB3774.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(136003)(366004)(376002)(39860400002)(346002)(6496006)(8676002)(54906003)(66556008)(956004)(52116002)(66946007)(5660300002)(2906002)(33716001)(6916009)(66476007)(83380400001)(4326008)(86362001)(26005)(55016002)(316002)(186003)(9686003)(33656002)(6666004)(16526019)(1076003)(478600001)(8936002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: N3VMUCjNozWeVjp6Oz1KwVsHR7aKlrDelUCJ2DhPUa4l2C1VuRO4SF6FXlYhrucRQtjRQsX0WXWeFgbX1+Usbozv+pnrPXgF098M6POYSMCUUG7NIwz9BoHtH/xWDq5dYmOfDzxheeJT8QOzSHxE5PkoZis2M/xu4qi+WXn44H8G8bOCbsGykvDBlXHjtz2C+nT/yqhcuei86+WTa4dDTeUWT/oVA05puRX4l2Im3l4NRZSKG9vMJQSYcmwwM8ghlSK8jVW0l6iI/2grKx3iQvYzzNg1nn7ZyrVjw6EBSxTHrqojuyw/JlIqporgl0ZEVxanI/7ohVXhbrfRmJ3kqw4M7mtf0NsXo7s6FD5SmR0zDEtXnoAW1p8cW7zyUySrijhl165aBHiMEKrjPA1hjPlto5LNimwq5QG4RMWFMyOE9cjRwyHE8jPVeK8HeHM3wVZ3Ib1HrmwvhVsPYU0Iyh1bjxjdx6iPKUTGh1FqLiotUStaCRyU2lmluBxYc3yPi2JqbdRPqZUEsYG9lwSFFjHq3MR1H+G9KaabXRyaI1Ki2f6oPaLuiFb5ppw3jr4+mI+z/5uP1cKNyp1SExfQ3PxBj9RufuXDM5LvSKOstQ9X/UzYM8rxBtl4OKY0j3ONqNg5BJ2BdcW8tViwfcBxJg==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1eed2189-47be-4ac3-2b1d-08d84571a24e
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3774.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2020 01:29:23.1137 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zmocky1qz8EVAsk+RR3Rh4UMutAkj2pI+JQdZr3Hi3+13OyznCqozI2LM7rILC3hD/awijVNh1EImslBQAoF2w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3837
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Liang,
 Prike" <Prike.Liang@amd.com>, "Quan, Evan" <Evan.Quan@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Series are Reviewed-by: Huang Rui <ray.huang@amd.com>

On Fri, Aug 21, 2020 at 05:05:03AM +0800, Alex Deucher wrote:
> From: "Prike.Liang" <Prike.Liang@amd.com>
> 
> Enable ATHUB clock gatting set in Renoir series.
> 
> Signed-off-by: Prike.Liang <Prike.Liang@amd.com>
> Reviewed-by: Evan Quan <evan.quan@amd.com>
> Reviewed-by: Huang Rui <ray.huang@amd.com>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/athub_v1_0.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/athub_v1_0.c b/drivers/gpu/drm/amd/amdgpu/athub_v1_0.c
> index 847ca9b3ce4e..3ea557864320 100644
> --- a/drivers/gpu/drm/amd/amdgpu/athub_v1_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/athub_v1_0.c
> @@ -73,6 +73,7 @@ int athub_v1_0_set_clockgating(struct amdgpu_device *adev,
>  	case CHIP_VEGA12:
>  	case CHIP_VEGA20:
>  	case CHIP_RAVEN:
> +	case CHIP_RENOIR:
>  		athub_update_medium_grain_clock_gating(adev,
>  				state == AMD_CG_STATE_GATE);
>  		athub_update_medium_grain_light_sleep(adev,
> -- 
> 2.25.4
> 
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
