Return-Path: <SRS0=rgj7=4G=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 864B5C34026
	for <amd-gfx@archiver.kernel.org>; Tue, 18 Feb 2020 08:55:21 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5A171206E2
	for <amd-gfx@archiver.kernel.org>; Tue, 18 Feb 2020 08:55:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="ovNXNjk1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A171206E2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 124C46E9BE;
	Tue, 18 Feb 2020 08:55:21 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2050.outbound.protection.outlook.com [40.107.92.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BF87E6E9BE
 for <amd-gfx@lists.freedesktop.org>; Tue, 18 Feb 2020 08:55:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AEvCjGTikhzTPVCiOH8hyKDEyuyHU0dbJbsw+Bts1pGIeZV1AgouTmTkL7IRnYoyldRvU93tmB1ZFidKr2JMHvQKQD/nbJPpifWoCAYRBp9CJRLaEWJ3DBoXc7gsmit6DhKIxdS3+KCerh5gjpMOCEkfLULZ3/R/94YpK0XkN/rGQHho/kpD078/xusqSLJVvTKVayKQWX9eK4DWTjXxcE6NuAD1N6Aq+qx3ZzcvYM+BUpSR0Q/PzFcEGhbuFAOfTHrgiPi7YK0Sqb1PCegeGXrfG4sedrnV/KK20chBpfgpHVwIBA/jGvKdKruq2C1HRBMOyyexaCFSC8XWbYvu0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bi+ePNqmWFTmUZNFzjJJ5rsS8w+2uAYdlMc9TgY/KwY=;
 b=JrtNVGz5JndxyE4V488POhKqStp7AIc3KXQCfdRN0Od7/sOSgy0mcfBFkmvXVBRd2maH7FeCDwRNdVl+q9nBPKD1afFtAGg9GfVOWD3GQ8Wpqz+TFUcN7v+0MfBWEvcJybcxel7p+QeSv5DmjTc3JZof6axpUxQbxg9x0OKd8mX3eujOvykkUHCRLDHESqtdcnW7AKYfPjnZ/n6T/nFzNtWrmPAxzpcBRCycJibZmU8cjwggYIBuxQghVjOAoFTotWIVP+bD5QIK+HbkOrTx3ldt+mKa7qHQxIrZqoqMTUH6ngxFdnj1FWQv9d65GJZIhn+IJXXKbd+AfBWc3ObMCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bi+ePNqmWFTmUZNFzjJJ5rsS8w+2uAYdlMc9TgY/KwY=;
 b=ovNXNjk1lKV7I5GtnSeJJzENRZHMlizMPaVPXB5TMjUjBQ5GTkEyn1uY0CLp98d7sNZxPTP1Sb/bLLtybfvAA+8g0wsYJkBxFy9DnF/u9tse9m/rRWf9pWPFNtOafFDC0qfwdFoFpdnzmSUuY7YpTOLbkrHgkX1VbkvZ9+S+kZo=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Ray.Huang@amd.com; 
Received: from MN2PR12MB3309.namprd12.prod.outlook.com (20.179.83.157) by
 MN2PR12MB3648.namprd12.prod.outlook.com (20.178.240.92) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2729.25; Tue, 18 Feb 2020 08:55:18 +0000
Received: from MN2PR12MB3309.namprd12.prod.outlook.com
 ([fe80::f945:5c4c:9c3f:930a]) by MN2PR12MB3309.namprd12.prod.outlook.com
 ([fe80::f945:5c4c:9c3f:930a%6]) with mapi id 15.20.2729.032; Tue, 18 Feb 2020
 08:55:18 +0000
Date: Tue, 18 Feb 2020 16:55:08 +0800
From: Huang Rui <ray.huang@amd.com>
To: "Koenig, Christian" <Christian.Koenig@amd.com>
Subject: Re: [PATCH v2] drm/amdgpu: fix the wrong logic checking when secure
 buffer is created (v2)
Message-ID: <20200218085507.GB6610@jenkins-Celadon-RN>
References: <1582014600-7147-1-git-send-email-ray.huang@amd.com>
 <879e7606-eedb-5b54-5600-8132df620933@amd.com>
Content-Disposition: inline
In-Reply-To: <879e7606-eedb-5b54-5600-8132df620933@amd.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: HK2PR04CA0078.apcprd04.prod.outlook.com
 (2603:1096:202:15::22) To MN2PR12MB3309.namprd12.prod.outlook.com
 (2603:10b6:208:106::29)
MIME-Version: 1.0
Received: from jenkins-Celadon-RN (180.167.199.189) by
 HK2PR04CA0078.apcprd04.prod.outlook.com (2603:1096:202:15::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2729.25 via Frontend Transport; Tue, 18 Feb 2020 08:55:15 +0000
X-Originating-IP: [180.167.199.189]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: b52140c0-6554-4082-5155-08d7b4504711
X-MS-TrafficTypeDiagnostic: MN2PR12MB3648:|MN2PR12MB3648:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB3648BAFCF42848CDAEBF0E1FEC110@MN2PR12MB3648.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-Forefront-PRVS: 031763BCAF
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(346002)(39860400002)(376002)(136003)(396003)(366004)(199004)(189003)(6636002)(6862004)(9686003)(33656002)(2906002)(26005)(33716001)(478600001)(55016002)(1076003)(316002)(5660300002)(8936002)(4326008)(86362001)(8676002)(81156014)(16526019)(956004)(66556008)(6666004)(81166006)(66946007)(66476007)(52116002)(54906003)(6496006)(186003);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MN2PR12MB3648;
 H:MN2PR12MB3309.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8RP2pV3x3ua4JcFvKmQvnK5BoD+jaKSnZBrBgc4ZE8bDKKkmqjRZ4hUhDlErzOSV09c9yGeIJX1zVHUzq/akmOAYx+6lw65VOtaBkP0LmI7cftGsI0WpWzpWgqRArPzCjVtK5aeEtJW7pK4s4qrHMCqz/hh2oJ0fejA/bxXhuQ2lUBFhHE9c4uJzR07eRNLPwRVaihNbGLeEiNNfiA0XVFxElmR4YegJzOdcdvU529ylS/aZxSiL/Q4tFe0bcMCxnrzJ3+8p8hnQreY5Y5WNCxefZUpWgJTPfjUTQ3lY2Y341g32x3v+tGdPwXo6OAKjXQxWzqFIScBhFxCiOeBgCZfdqgh5nioov/0A+K7ZiKjEhxBKmS3iChd/TCZwMPGK3yLLigZZpFC/hQC/fRV1DqF9/gTYYhif05Nk/PxpbE9jwS9L0eVeFXkBasgelmst
X-MS-Exchange-AntiSpam-MessageData: cAoYEnfmnJMVOneydQghZ8Xm3sc7/MNLgejX6hsoWMRFTxqGCtyOKnAC8MRSNxJ1fIGCzy4Rx8H3bxYesvLE4QhZ0YEJrhhlvQHwc/jd4roNuLCuDrKH/ObETCEHZ2J4IgWIQsCnCG77r1gHySnJAw==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b52140c0-6554-4082-5155-08d7b4504711
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2020 08:55:18.0544 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jnpzA+uToPOACrIM4McuQjtem8VTyxK624EOOPRkqRCMDRTgY8YrqMeMvAfCRbKAsvT4pKosVWTZ2wXLUArkmQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3648
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Tuikov,
 Luben" <Luben.Tuikov@amd.com>, "Liu, Aaron" <Aaron.Liu@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Tue, Feb 18, 2020 at 04:50:01PM +0800, Koenig, Christian wrote:
> Am 18.02.20 um 09:30 schrieb Huang Rui:
> > While the current amdgpu doesn't support TMZ, it will return the error if user
> > mode would like to allocate secure buffer.
> >
> > Fixes: 17d907c drm/amdgpu: implement TMZ accessor (v3)
> >
> > v2: we didn't need this checking anymore.
> 
> You misunderstood me.
> 

ok...

> >
> > Signed-off-by: Huang Rui <ray.huang@amd.com>
> > ---
> >   drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c | 5 -----
> >   1 file changed, 5 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> > index b51a060..5cbc63a 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> > @@ -235,11 +235,6 @@ int amdgpu_gem_create_ioctl(struct drm_device *dev, void *data,
> >   	if (args->in.domains & ~AMDGPU_GEM_DOMAIN_MASK)
> >   		return -EINVAL;
> >   
> > -	if (amdgpu_is_tmz(adev) && (flags & AMDGPU_GEM_CREATE_ENCRYPTED)) {
> > -		DRM_ERROR("Cannot allocate secure buffer since TMZ is disabled\n");
> 
> Only the error message should be removed, but we still need to test the 
> flag.
> 
> E.g. in general we should never log that userspace sends invalid parameters.
> 

Why? It probably can help userspace to understand what wrong input it is.

Thanks,
Ray
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
