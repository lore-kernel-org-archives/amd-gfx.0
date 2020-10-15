Return-Path: <SRS0=r20P=DW=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2A9AC433E7
	for <amd-gfx@archiver.kernel.org>; Thu, 15 Oct 2020 14:30:38 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3DB6F22256
	for <amd-gfx@archiver.kernel.org>; Thu, 15 Oct 2020 14:30:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="1wkogdhL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3DB6F22256
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 700366ED20;
	Thu, 15 Oct 2020 14:30:37 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2062.outbound.protection.outlook.com [40.107.94.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 411D66ED20
 for <amd-gfx@lists.freedesktop.org>; Thu, 15 Oct 2020 14:30:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RkbJPYJMZTLNI5cinRpFcAoJOXDIRQQWPk25RQb4wAHduCkNNyK18zSOYWvvlQW97tr54haO8Fw00QTjBeTpL1og2fHa1yr4NyyzF0LXkikS2Zi4F6+AWE1QeCElQqQvy39u2qD6seC6B4J8feqHXmNGbwKf78ix+YiYjJ8HIj7zHwBQUURGj/Upng/2xCsEJoCMlUltojqRiJ6+mF5ERZZS+tA0kYn29QyX2LolW8sOMiqPjAOit3NxHJJgXORX3QiJMc0jJpmOJvwCh2fgJkicGZSpn7qFn+uuFf/agZiALzxpOFH0gAxik6csu9y/fjQosa15SbzOPjtzOnBvGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gZO2zSObR99jBbP+5Z2hdeIm4FH9isrVtoNNfCOLAyg=;
 b=Dh0LDajYtfFUNhSI7TIuIvJ5HXax0oy0BVyKFOPw8sntiZckLgd/o2MJm6HBHzFP9kJe+wrjNfxQTowGngqPn3ACBt3Dc2vMiWkF9J1X+zWJn2dQi0wquwenvx4bqtprt0e7xANhkGPp6AbtICOXjUP8plawpqJp1xJFLnEVqzZBimxTAGMSPkAlsC7VB4SZVeHgjf2XZHRWr9xRNSl2FY0aScVvzdVHYula4JV+cyA5nQSDrmI+t+clHyeGHInhKU0bq+N7GjUWZpGmeNslyY+Bkrm3eDSQFxqL6N8TY+1j5+tKlNzWOouTIkzeirD39kY33wMhh/55oecfNWdMIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gZO2zSObR99jBbP+5Z2hdeIm4FH9isrVtoNNfCOLAyg=;
 b=1wkogdhLjdsELvlFKq4xiXCx8zPNFwOHtmAjWk3VLTQld5fNb45QDzyKFst43Z794VowwUn2iQCzqSj0i8f3GiiT9/mFDIuGqRR36a03NLDWCPbOrCukLUo6TCJCadFFFkUp57WpZgNs1Yz3q2NPbF/AXT2OLbR0bpnErywOwN4=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from BL0PR12MB4948.namprd12.prod.outlook.com (2603:10b6:208:1cc::20)
 by MN2PR12MB4389.namprd12.prod.outlook.com (2603:10b6:208:262::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3455.21; Thu, 15 Oct
 2020 14:30:35 +0000
Received: from BL0PR12MB4948.namprd12.prod.outlook.com
 ([fe80::b07d:ede5:2f45:5de8]) by BL0PR12MB4948.namprd12.prod.outlook.com
 ([fe80::b07d:ede5:2f45:5de8%9]) with mapi id 15.20.3477.021; Thu, 15 Oct 2020
 14:30:35 +0000
Subject: Re: [PATCH v3] drm/amd/amdgpu: set the default value of noretry to 1
 for some dGPUs
To: Chengming Gui <Jack.Gui@amd.com>, amd-gfx@lists.freedesktop.org,
 Alexander.Deucher@amd.com
References: <20201015033557.3046-1-Jack.Gui@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Message-ID: <ccd27274-44e1-3bfc-24a8-e24750889efe@amd.com>
Date: Thu, 15 Oct 2020 10:30:33 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <20201015033557.3046-1-Jack.Gui@amd.com>
Content-Language: en-US
X-Originating-IP: [142.116.113.11]
X-ClientProxiedBy: YTXPR0101CA0064.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:1::41) To BL0PR12MB4948.namprd12.prod.outlook.com
 (2603:10b6:208:1cc::20)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.2.100] (142.116.113.11) by
 YTXPR0101CA0064.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:1::41) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.21 via Frontend
 Transport; Thu, 15 Oct 2020 14:30:34 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: c43fb545-51ae-495c-4921-08d87116e0c8
X-MS-TrafficTypeDiagnostic: MN2PR12MB4389:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB4389600FF873B00EA411F1B792020@MN2PR12MB4389.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fEd3paeeduEBBG25mVUBaO6oY1+fu1Zm4wJT3Jd8wEEgSuLMREGC3jpxMHqxkcQ7YTj40CCGmsXkzLczyh4QxLfxaMsqBM7Vujds95yCf4TT4CmJ4YZZZz6VgA8V9asi7Tfslzvvh6Vyp7g1+RHuhyzJwdXjjfPd5MZtKP/Uov1IsLX/Nw/lVSUIz3jXcOmpSpfC8LKhBuyksdTJtvC5nvvKC3fqfqZmA9NsaFfSVPCgaraSm7GWjVcsTA/+XMO9X+dRRqU42hwbYPCUwfHKkTsvSysfJafn/YdvgaOZ/VviXnjelYoJAkeQPhxmTrveDHplvvPaPXIV7w/8mj93A+TbIefAe3/W0n/9m7RNnsLJSglXcML/5+wPGI80aoxf6n5aenrRp93TOw1dJswmAhYRmAOiwLCosGZKimG1BG4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR12MB4948.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(376002)(346002)(136003)(366004)(396003)(478600001)(66946007)(31686004)(66556008)(4326008)(34490700002)(6636002)(2906002)(52116002)(36756003)(83380400001)(8936002)(44832011)(86362001)(8676002)(186003)(66476007)(26005)(31696002)(956004)(6486002)(16576012)(16526019)(2616005)(5660300002)(316002)(4001150100001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: yq6jrJRzh5xGp5jSGLGs6Lc0h6Z9+5LYU3RTe9DxXr/8j0Yft5IGjfDtkI03f6eQi30w91Yryx1csS8nVnZ3n5qH0bEBezFyvvdrwbfuQFYzUxObwOJ+pACuT6V+/MNgUBblJR4kWxBnh+U1yEfYInzpWV6UNBvRjCR6Iwmh8xewEQU6K/lWmmhqvdvEmN5QTIsIEaPDv8NjOS0831chbSRBJnE3a21dG/TRY4jMpIwDg8Ve7+av51UOAw0EEIDbOhputtrkEKiQAFVHilTJ9bvTZiB/HAfeOrONEN08HWh8v74Px2mgkfQC1dJ2ZG/0f/KzXw0mS7Iqquz+4D91pWU9IecBRdmNu+jaSLb1aOc3boWU5iGZLlCvSiMnvpiLQfRp6yvPBI0fKcq3yBcE4wDRrijt3AtcG7g8Mq7x1cHswzui13xtWekxYSV9rpSG8MzrPxh4BSEyovLi9gaMJTMZ8lCj2yeIsRBqEE05JgQVdu0iUNFXbkyO0CkZYIUDtK5P3LVoAQgTaBu08B01MbowIwvSuPUKgnE1V4vK2SuMrVul5UebnPdLYVOXlM0XCNdpfPBcOGcyaF3HG0+IydqEa88E6TUepuPm8Rm+MwMPrwKya8sWZP+wHg88/Y5kqIOykysZBFEvy5U2w5WSQQ==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c43fb545-51ae-495c-4921-08d87116e0c8
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB4948.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2020 14:30:34.8949 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Zcdk3EUYOUDRCUr4ZBuQJxTc+H6vRjlu3Js5s3FKGOC8sb43Nfk8An3JeUNWTUOdu6ml3mLREbGMjbDzUcBkjg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4389
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
Cc: Tao.Zhou1@amd.com, Ray.Huang@amd.com, Guchun.Chen@amd.com,
 Hawking.Zhang@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 2020-10-14 um 11:35 p.m. schrieb Chengming Gui:
> noretry = 0 cause some dGPU's kfd page fault tests fail,
> so set noretry to 1 for these special ASICs:
> vega20/navi10/navi14/ARCTURUS
>
> v2: merge raven and default case due to the same setting
> v3: remove ARCTURUS
>
> Signed-off-by: Chengming Gui <Jack.Gui@amd.com>
> Change-Id: I3be70f463a49b0cd5c56456431d6c2cb98b13872

Acked-by: Felix Kuhling <Felix.Kuehling@amd.com>


> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c | 23 +++++++++++++++--------
>  1 file changed, 15 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> index 36604d751d62..f26eb4e54b12 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> @@ -425,20 +425,27 @@ void amdgpu_gmc_noretry_set(struct amdgpu_device *adev)
>  	struct amdgpu_gmc *gmc = &adev->gmc;
>  
>  	switch (adev->asic_type) {
> -	case CHIP_RAVEN:
> -		/* Raven currently has issues with noretry
> -		 * regardless of what we decide for other
> -		 * asics, we should leave raven with
> -		 * noretry = 0 until we root cause the
> -		 * issues.
> +	case CHIP_VEGA20:
> +	case CHIP_NAVI10:
> +	case CHIP_NAVI14:
> +		/*
> +		 * noretry = 0 will cause kfd page fault tests fail
> +		 * for some ASICs, so set default to 1 for these ASICs.
>  		 */
>  		if (amdgpu_noretry == -1)
> -			gmc->noretry = 0;
> +			gmc->noretry = 1;
>  		else
>  			gmc->noretry = amdgpu_noretry;
>  		break;
> +	case CHIP_RAVEN:
>  	default:
> -		/* default this to 0 for now, but we may want
> +		/* Raven currently has issues with noretry
> +		 * regardless of what we decide for other
> +		 * asics, we should leave raven with
> +		 * noretry = 0 until we root cause the
> +		 * issues.
> +		 *
> +		 * default this to 0 for now, but we may want
>  		 * to change this in the future for certain
>  		 * GPUs as it can increase performance in
>  		 * certain cases.
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
