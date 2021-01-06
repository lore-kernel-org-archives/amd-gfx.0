Return-Path: <SRS0=majj=GJ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7671DC433DB
	for <amd-gfx@archiver.kernel.org>; Wed,  6 Jan 2021 06:35:46 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E05E423100
	for <amd-gfx@archiver.kernel.org>; Wed,  6 Jan 2021 06:35:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E05E423100
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5D1888935C;
	Wed,  6 Jan 2021 06:35:45 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam08on2048.outbound.protection.outlook.com [40.107.102.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 35F1C8935B;
 Wed,  6 Jan 2021 06:35:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B/e+j3o273iE/A2bizFJIe+9G9bvwPALRIYgr2RFa/EKuVAXRRVxCJnZznLrv2obJ221A29lsdUbFrK8kPDq/JAF3Bwoz26x/W55RbP22uuylcnBrgBdAEzmbzyKV9M9cVKDQeSOW65b/k/SC0X52B1Ab0xEEzJWxVsMXUwgGK5mQcrh4bGJJM373VBryPu99lZXI2tgmpXNamfZ4zErsPhK/eYBUq9bk7QXhZKWfOMfwHzEGPuKNrAyhSWq2TwTH/PsG3WLx/MfYTdAiKrtT/W3rG+fOggab8hPTiYoWWLeIS2UsLxVrcr0p0WRAr2qFy9wTi/JGJnfBFXxYztknQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mtet1YATetwlb/V7Tv+dnOY0DxfF4Zs9iE8XQYAd2sI=;
 b=MpBJGYoLnM/e52fsbnT3EP5PiK4uOXtDqmd4enHfKndyOdDXOtij2UWXQxk4MA42hzK2MMiLKjJDjy+YbcgvLi5pIGVRPi/jYXwmr0LMFrE/FfWqCvo3LN9rVjlN2UcS/ZbzE2B+Xlv8Exihz1EXZ53OGwecZCkGrGfbwW71NasEJzPs06CfkwvR4TGHKO6rk7JWcWRv3wGSqr+NqTBmX9JOqFMFHg/jyAGYouNTBUwjugto9ILKgTM7Y5DD2iZ2at4p2DMeVtiBv4Z0P72Evgw4VX78fULXKgr5TZ1h47W1bOgH181rb8CU8Nav0rP5y5xH9IxH//MKN+6sful1Nw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mtet1YATetwlb/V7Tv+dnOY0DxfF4Zs9iE8XQYAd2sI=;
 b=HHoAOMw5v2s7S7R3pyX4d0HQhqzXm7gJGH4XOWS0UK+EwAqORxxNljyKl3vjmd1NwXk2sNJTb52CbhoGx8qvKnmyzOlKxTwnmyEm4UEPQPNRa/R7jOx2kYS8sx/yGxfrvE9qzptqLDztXb3aMLh9W6uYs+7BLOSaTcuzi9FYU1U=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=amd.com;
Received: from MWHPR12MB1248.namprd12.prod.outlook.com (2603:10b6:300:12::21)
 by MW3PR12MB4425.namprd12.prod.outlook.com (2603:10b6:303:5e::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3742.6; Wed, 6 Jan
 2021 06:35:41 +0000
Received: from MWHPR12MB1248.namprd12.prod.outlook.com
 ([fe80::8c0d:7831:bfa8:d98]) by MWHPR12MB1248.namprd12.prod.outlook.com
 ([fe80::8c0d:7831:bfa8:d98%6]) with mapi id 15.20.3721.024; Wed, 6 Jan 2021
 06:35:40 +0000
Date: Wed, 6 Jan 2021 14:35:29 +0800
From: Huang Rui <ray.huang@amd.com>
To: Christian =?iso-8859-1?Q?K=F6nig?= <ckoenig.leichtzumerken@gmail.com>
Subject: Re: [PATCH 1/2] drm/radeon: stop re-init the TTM page pool
Message-ID: <20210106063529.GA479972@hr-amd>
References: <20210105182309.1362-1-christian.koenig@amd.com>
Content-Disposition: inline
In-Reply-To: <20210105182309.1362-1-christian.koenig@amd.com>
X-Originating-IP: [180.167.199.189]
X-ClientProxiedBy: HK0PR01CA0050.apcprd01.prod.exchangelabs.com
 (2603:1096:203:a6::14) To MWHPR12MB1248.namprd12.prod.outlook.com
 (2603:10b6:300:12::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from hr-amd (180.167.199.189) by
 HK0PR01CA0050.apcprd01.prod.exchangelabs.com (2603:1096:203:a6::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3742.6 via Frontend
 Transport; Wed, 6 Jan 2021 06:35:39 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: c800c185-8a78-4a44-dd4f-08d8b20d4967
X-MS-TrafficTypeDiagnostic: MW3PR12MB4425:
X-Microsoft-Antispam-PRVS: <MW3PR12MB4425C649B9D17EEFA8FCA56DECD00@MW3PR12MB4425.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:605;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wYJUvbCMA3Z7qkChtO8TxumyLBx1jp+HaC5O6E9LdAgt9GAEAfxgROMuTVdl/9VXyagrniJoj0zT98KTGdQCBEQRN/iPPdgyKb/H7gbWFQj4XgrdE6n5AtsyCRKPbkI8LiAJHi64gLJwvnYD5xfx6/ZTjcLR83IsoneDKptp/O8jcnc8n3KOvJuQ8pd4FxDg44uHrgVZ+YlEaIEkmVGY8k6kgMApiUuwYXdrKF6MaBWQuDgDFfz00LFLG2KaB+TlVmYYvfX5HJaMgTlYYogypa9DkBWjpmpXQRGRUMyBt5qB9GVXDdICqSvEI4/s5xMLuwHdd7OeWQceKNg38UzZHsdYRHzfv60R7FmRbiHw/MNxVyqFsMX3n2SM+fnscBAMEMOOmoAopm/kmDDECOaxcA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MWHPR12MB1248.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(376002)(366004)(136003)(396003)(346002)(6666004)(55016002)(33716001)(9686003)(4744005)(2906002)(956004)(5660300002)(26005)(16526019)(52116002)(1076003)(8676002)(186003)(66946007)(86362001)(33656002)(66556008)(66476007)(6496006)(54906003)(478600001)(316002)(83380400001)(6916009)(8936002)(4326008);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?iso-8859-1?Q?uaryNE3upiTe1E/JG4Ie7SMbPW9CULihNX1RSH43THl8ZgGzu54OQxaBjP?=
 =?iso-8859-1?Q?LUE5bvlOIgwHwV+4llp1Db+jsDDf5VhLwosMPPblFbykafp5VkgYneUgmI?=
 =?iso-8859-1?Q?tDVTtvAyvZ/FZnvZmw4L0QFYOlTRJep4opDkcyn2XJwpkEOoOF0AgkjJ3U?=
 =?iso-8859-1?Q?h6KV7s/+jYiSnPTE7wSmEW9IUmKrrMW4FmJId4I0/IKY+DuIwi/kfZdl/G?=
 =?iso-8859-1?Q?bBnZPCVZnR7oS/QND5dx+uXEe6VXfGSYtnVioHoQzxNisiQpqbXoGhlzjf?=
 =?iso-8859-1?Q?5sEosazJ2W0CC0P2g8D+kXd2ltrp1WHUSaeaCMibmAnYWTnM6uL+/Kh9HT?=
 =?iso-8859-1?Q?pzOcmpkUw7gJTlkYbYU1Il5icemIZZGpcUPpNwkNTuJZ4KUl8eMJuH4jFr?=
 =?iso-8859-1?Q?bMv3I4SBLMEN5gY78GDbB3MCcFhWbJRzw1aMh71mVqep4NY/1gfLrrRQS1?=
 =?iso-8859-1?Q?zRto1j++9rjYk33CbbadCTXrXEqPp4C37n4KUo/kkM2i6CcopAsjziBULR?=
 =?iso-8859-1?Q?sOyAkjzht+zy8uzxbVf7co4zNzpScchLMDeADp1B2X8sDghWEfm8eNuB/r?=
 =?iso-8859-1?Q?0CEpdh42n8ZcFpyu37h+ON3uSydICGa+/HKuJE4+FpGpg6OvcLSlbxeV2y?=
 =?iso-8859-1?Q?lDxI9tY+Vv+aPRy1OSjx83F8L+Zt/HSwF0Ef7ZuCVbUnXYc1KdgoGPA3tE?=
 =?iso-8859-1?Q?9PcBAGvDj56a38N8fjiDZqEcvWJII36neGZfW95Ovnsy5oc8SpkchZMeXM?=
 =?iso-8859-1?Q?m7F9orWyfFL6B6RnpkhsTx/87wuqk6VI/XKwEzj+dnXJcXv269LCP0yTim?=
 =?iso-8859-1?Q?4Oy7eBY9JBBz/i5QBJAEuLF8yn/4MmmHZwK8p53HM557+h0dlKZoCOWQz7?=
 =?iso-8859-1?Q?X+F+4WcTw9U9Nm4P8TRDTYjBG9Ay74uGO2aEfa7EVSOt2A+r/QyFIIDDrP?=
 =?iso-8859-1?Q?KqVV9Sq1ze1FcRSYXEoYROi2N+GmMd4x5OQhOJRYrbCKU1H84d/mVuiGxQ?=
 =?iso-8859-1?Q?rihT+IcLX3CBycp0eJrRaBCNmB/8LQo6l9p4H3?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthSource: MWHPR12MB1248.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jan 2021 06:35:40.7683 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-Network-Message-Id: c800c185-8a78-4a44-dd4f-08d8b20d4967
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XL+rPZ7J1ty9POtoCxWGBFPcj3OYxTbLkYtnHmnDeIMz/F5Z/nHDirKRZXsW4yTM/Lt0WMfAm6ijzyNDqpwyCg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4425
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
Cc: "bp@alien8.de" <bp@alien8.de>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Wed, Jan 06, 2021 at 02:23:08AM +0800, Christian K=F6nig wrote:
> Drivers are not supposed to init the page pool directly any more.
> =

> Signed-off-by: Christian K=F6nig <christian.koenig@amd.com>

Series are Reviewed-by: Huang Rui <ray.huang@amd.com>

> ---
>  drivers/gpu/drm/radeon/radeon_ttm.c | 3 ---
>  1 file changed, 3 deletions(-)
> =

> diff --git a/drivers/gpu/drm/radeon/radeon_ttm.c b/drivers/gpu/drm/radeon=
/radeon_ttm.c
> index d4328ff57757..35b715f82ed8 100644
> --- a/drivers/gpu/drm/radeon/radeon_ttm.c
> +++ b/drivers/gpu/drm/radeon/radeon_ttm.c
> @@ -729,9 +729,6 @@ int radeon_ttm_init(struct radeon_device *rdev)
>  	}
>  	rdev->mman.initialized =3D true;
>  =

> -	ttm_pool_init(&rdev->mman.bdev.pool, rdev->dev, rdev->need_swiotlb,
> -		      dma_addressing_limited(&rdev->pdev->dev));
> -
>  	r =3D radeon_ttm_init_vram(rdev);
>  	if (r) {
>  		DRM_ERROR("Failed initializing VRAM heap.\n");
> -- =

> 2.25.1
> =

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
