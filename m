Return-Path: <SRS0=awHg=KH=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75DB9C433B4
	for <amd-gfx@archiver.kernel.org>; Wed, 12 May 2021 03:35:43 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 377B7611BE
	for <amd-gfx@archiver.kernel.org>; Wed, 12 May 2021 03:35:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 377B7611BE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D66556EB42;
	Wed, 12 May 2021 03:35:42 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2081.outbound.protection.outlook.com [40.107.236.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 457266EB42
 for <amd-gfx@lists.freedesktop.org>; Wed, 12 May 2021 03:35:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JW+A0L0F8mAi2p8/wSRm7lU0WczkjIRnjRzrmRn1xJXjzZmMAOfMudU3bZ3ZRkKQ1xRsCJSUvyRu4+A1aJJnNWKB/L6aODUm6PG4Q0oDc2pmg0paUTJFxAsHLNyQ5K6tZ3wCgF1pOmFMzo/sGIZMs5DfprxRHiP3fAhWTXN+YRohNbkKjfVPGH9PNIrhNwpDz2NYmUQUDOF9+uNV8QZP3/iYkLfku7w9cjoppbw0NMPubNcZwBbJsEy4nph1qKstLHHaF1h/oP+lEgsue8lVKPHC/vpFFYPpfJ9MMG9haEDRivhdEDoQYmyvkvXwe8wkfPcmEieW6E1PC81DejVtkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UxFpWBCOMLMrYtEnTnALr4bXr7d90FOxa9UanCrPGP0=;
 b=aEDk144iA8N2UlXsAm/xxjQx3Lrfo/+4n/5ygeSYRu5bHJ4gWSQ1aJPHzO8ehlhFppYtBYhExMb6+pVZWIi1sE+crO/ma7anrPgS+RJqXXHoHlHZaHGVeRsB1p/d5lMRYKmf604XHXNaPj3dea0og618ncTk0FPqpC3zGHogk345wX3KYrB4LzvbLCAWJPeFtKb+YR2WOMma20URlNlt4C+WPgJawzqULoh8uOFoHbMAtgIk+7OEIH05MGtLcItOH4v8ofpeJlD7tx8aZEgS7sR6OGqUt0X1vVUfNwhMLIS+uhkDrhov56lwZSyTajiaDQyQr68GJ2VPyPZCPXJz5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UxFpWBCOMLMrYtEnTnALr4bXr7d90FOxa9UanCrPGP0=;
 b=vQsh39JYEXHQh2Cresos/1Lx14Z1ji2hRZOkq5Yuk4k79uDWPtCGftE0aR0DEHMEFoEOQt6anx/pprH3xN+bHNeTuLVPAn/CqRWsZLdFwMDcp+rHErAoDDo4nyqGegrq0LjTzEWbBHJfwo8g78ukKNA3XdP/ueP0DktthUUq6kE=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from MWHPR12MB1248.namprd12.prod.outlook.com (2603:10b6:300:12::21)
 by MW3PR12MB4380.namprd12.prod.outlook.com (2603:10b6:303:5a::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.28; Wed, 12 May
 2021 03:35:39 +0000
Received: from MWHPR12MB1248.namprd12.prod.outlook.com
 ([fe80::f07c:dc0f:e7e8:416c]) by MWHPR12MB1248.namprd12.prod.outlook.com
 ([fe80::f07c:dc0f:e7e8:416c%4]) with mapi id 15.20.4129.026; Wed, 12 May 2021
 03:35:39 +0000
Date: Wed, 12 May 2021 11:35:30 +0800
From: Huang Rui <ray.huang@amd.com>
To: "Su, Jinzhou (Joe)" <Jinzhou.Su@amd.com>
Subject: Re: [PATCH] drm/amdgpu: Add compile flag for securedisplay
Message-ID: <20210512033530.GA1385931@hr-amd>
References: <20210512015121.2122807-1-Jinzhou.Su@amd.com>
Content-Disposition: inline
In-Reply-To: <20210512015121.2122807-1-Jinzhou.Su@amd.com>
X-Originating-IP: [165.204.134.251]
X-ClientProxiedBy: HK2PR03CA0065.apcprd03.prod.outlook.com
 (2603:1096:202:17::35) To MWHPR12MB1248.namprd12.prod.outlook.com
 (2603:10b6:300:12::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from hr-amd (165.204.134.251) by
 HK2PR03CA0065.apcprd03.prod.outlook.com (2603:1096:202:17::35) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4129.12 via Frontend Transport; Wed, 12 May 2021 03:35:37 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d77cd0f1-0851-4944-8e09-08d914f702f1
X-MS-TrafficTypeDiagnostic: MW3PR12MB4380:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MW3PR12MB43800377882D8FCCDA16EAB2EC529@MW3PR12MB4380.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1265;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XFGZr3yLYSUcgGh1ro6gT4pnLLKzR5/gY95wYwLMhm0HO71ALqzFJsvkwKGxVezxGhi/sLiql/gAc65I014J96ZfObxNDf1n4yLIDSozeQoacQhQrFvOikAuHhptDXYp9lYGVPjhbVsvpTvIE7Y0byDj5J2wJD3OGdpGW9BR5xAssru9QzEVg5coE6oM/xVcRWkcww74mP8qUbhvP6RpNWoFpGLs5FYmzu/k7fGHBklNeIe+gA9D/h9j4JhyxU8lrCik15uRq7fNKQaqvBt8vfxTylgCseOwd78KShmqEoBIf0xR3KKJPR2Z9TCsWHe/4irgL/24olqMmKXkTNVsJQu0cgxaIrEQWeiCyCxWLyFXa1N4GGBPdJuzLpsACLd39/otpJpN8nPq6/7WOGRlEbTlOvdnc7spBuO41lt3qSP89gCXXtuHiTmhVxZIVlxRHX1p1L+6WV5WTRzeBe/vDL/Z/39JlA8SPI4AvHZLAWDqTV8U1G+zgEteoHt/NMbfCFu9Wc5GDO0MtImSsT/Fw7dDZYHCCixmdcJftO45KzzqKMO6uwbXlFFy7li5gzH9ZcIqqeeeAzL+rpP1mSHTivfkjyhF1/vV+NjMK0FawsazljxMkqm+Oo58XZGnDzXOz0oRB4bx5e8wnfUxcq1CsViqBdrA57IVfGVBAhDCATk=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MWHPR12MB1248.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(396003)(136003)(39860400002)(366004)(376002)(38350700002)(6636002)(4326008)(38100700002)(8676002)(86362001)(956004)(6862004)(26005)(83380400001)(52116002)(66946007)(66476007)(33656002)(5660300002)(478600001)(1076003)(9686003)(55016002)(2906002)(6496006)(16526019)(186003)(316002)(8936002)(6666004)(66556008)(33716001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?rTnVXDGYycmaR4mA2Zv+vMlyR3dgEPnRZJCVHb0tGpjfabQunQFyEygmh2w6?=
 =?us-ascii?Q?k8AirWWoj+2HFMj2A5uzlJfH+9gQXQ2oVjDkfCycawelOso5kdMfyFZ7N3q9?=
 =?us-ascii?Q?Nn9gTkHpSpHTbudRr80ZK9n4NqAT3K/dgrlAaNykbBjMQr0lOhKeK5QPgMse?=
 =?us-ascii?Q?43dr96eqPxDnN7woWUh0XrwhHi9p0YLEJxceWJat3idA4e1xwmUFi/AugVwa?=
 =?us-ascii?Q?oK4FKq15U9n2H/TXaCH1uGmblwtuiMx7GQl4ozSzpk8LWzpcoSOsCPT6HWra?=
 =?us-ascii?Q?CrqOuyDDxgS17m+WDMcbXcfkqUZBb4atf71XnhQ9O9GTCvGG+QrN+x2kLUkp?=
 =?us-ascii?Q?hg1+P+3UXFzp2ix9zfZxL9MlluEg2hDorLn7ZTRZSLvQuJBylJFOu3ihmmjs?=
 =?us-ascii?Q?GSjTCIpdS983ppbUVpZJXv3m1x9ClynyHFvII7WJQA8eBMwqWT7q68s1NHLz?=
 =?us-ascii?Q?abjkR0M0fK+XycYvZbnZAUP8gxsE9FgAuE7iU7cxvhDkXDx2F9dF1+XDWLnk?=
 =?us-ascii?Q?xoz5J9RemmwWKF5iLWYQJYxR1ide5KpuUtHh8nZY5WtpBC/GpV38LX86j4rp?=
 =?us-ascii?Q?NQnWPzlMUrjxk2aSsHFOKm21Wzf3I+qPdyDPYpMhIt4TGCE6Y6jEX2hPAA7W?=
 =?us-ascii?Q?yuTQSBuRF7Dfe/ECjyWYFXJmAlqYNV51ZzPZrnxRjOvgihbaoIManVrRpVwX?=
 =?us-ascii?Q?y3p00si80orMmg6WjxxXrBjQ/xpuESPNOS5cxBS3voaSlBUDoAAi0U0COs3Y?=
 =?us-ascii?Q?E/FQXGbxhq/T5nEmatLpzG7iF76NiqqCZ6aeofg+NxTPEb2+HTrhTVCBKz95?=
 =?us-ascii?Q?v7KZMOaH+tbfSbBbsIMav6CsRYi4m2UMzn/oHTd/Bysy5lLEAR7qLwhaogUU?=
 =?us-ascii?Q?jua+7P2lqX39pEcenBgSjNBuxscpiU7GYvgP36qMoTLVGjpgdelgZtzYp97B?=
 =?us-ascii?Q?QKK9OY2dMrki0ti23Yqm05GAY5e09ejUYxwTfVqsO7/OQDsnrez9+y4TjeqI?=
 =?us-ascii?Q?RT3nPN542/tr/Dth8yNnYTMFOBT/Ynv/Nh4ozkgvN4gWce/gYzDKwax9Oo6A?=
 =?us-ascii?Q?57q35s6XF1VFRhWdZ38aYwlo9BUPZ4Upiq11MyqSF7kwuiYfBt08gAcyHgYc?=
 =?us-ascii?Q?2oT17+6FKeEmetjZu9JTPRcnL2wb5iFF/j64nTubBIMRCOU6FYnCyF4tokX0?=
 =?us-ascii?Q?BOEq9F1Fzb9pxx9w6Bz5wQ1viqYsndeH8nZI3Rhbslt2X1HIPalbAn7JmOA7?=
 =?us-ascii?Q?PwiiGJYOKsbMPWwGuvzjPqQlCwyud+1vwcIqgqWYRxboxyemiK7NUmoD9OzY?=
 =?us-ascii?Q?cVu2SSFYgh2vatR2uYz59WD0?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d77cd0f1-0851-4944-8e09-08d914f702f1
X-MS-Exchange-CrossTenant-AuthSource: MWHPR12MB1248.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2021 03:35:39.2426 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qERizQ+HQ2zQ5EWFmkWgd1mkAoTft4UTwZJZHSzUlaBRnmyyTEYutNuhilIaKhQbS2mUXp4e8mkQJ4fh0m3fhQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4380
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
Cc: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Wed, May 12, 2021 at 09:51:21AM +0800, Su, Jinzhou (Joe) wrote:
> Add compile flag CONFIG_DEBUG_FS to clear the warning:
> unused variable 'amdgpu_securedisplay_debugfs_ops'
> 
> Signed-off-by: Jinzhou Su <Jinzhou.Su@amd.com>

According to the 0 day's robot mail, please feel free to add below
reported-by:

        "Reported-by: kernel test robot <lkp@intel.com>"

Patch is Acked-by: Huang Rui <ray.huang@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_securedisplay.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_securedisplay.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_securedisplay.c
> index 5369c8dd0764..123453999093 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_securedisplay.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_securedisplay.c
> @@ -86,6 +86,8 @@ void psp_prep_securedisplay_cmd_buf(struct psp_context *psp, struct securedispla
>  	(*cmd)->cmd_id = command_id;
>  }
>  
> +#if defined(CONFIG_DEBUG_FS)
> +
>  static ssize_t amdgpu_securedisplay_debugfs_write(struct file *f, const char __user *buf,
>  		size_t size, loff_t *pos)
>  {
> @@ -162,6 +164,8 @@ static const struct file_operations amdgpu_securedisplay_debugfs_ops = {
>  	.llseek = default_llseek
>  };
>  
> +#endif
> +
>  void amdgpu_securedisplay_debugfs_init(struct amdgpu_device *adev)
>  {
>  #if defined(CONFIG_DEBUG_FS)
> -- 
> 2.27.0
> 
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
