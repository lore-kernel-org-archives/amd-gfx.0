Return-Path: <SRS0=p2a1=3E=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF4CBC33CB1
	for <amd-gfx@archiver.kernel.org>; Wed, 15 Jan 2020 07:49:09 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C1A9C24655
	for <amd-gfx@archiver.kernel.org>; Wed, 15 Jan 2020 07:49:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="bzLM94/q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C1A9C24655
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 82F1F6E865;
	Wed, 15 Jan 2020 07:49:09 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2060b.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eaa::60b])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 213F36E862
 for <amd-gfx@lists.freedesktop.org>; Wed, 15 Jan 2020 07:49:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A/LcTKCcI83TJx+i7hCRXxQH4Y6CqZQr33Gv6gHkChGKiIGH+ZkJk39rs2PgkSrJ5An65Us+LptwpJeWyS8KWUeMiVd0+97WEeyIAeRMNTdMyixpqFmNvmH6NJ7oUD+DzA1YqEP2DlBJP51BGQloPBeaf76LJySrNKaMKtac+VJBevzW+72R4PxLXsNv+1P4191Lx3oplptMtWOLvwFfzmGL0ReMRxXkjToEnjl5QOMxTf4yR1YmAiLhfvVpznfdbmGLGX7O6kw4wyDJJ6KKxZF2lPcgMq8VIgweSwJg1Z33/z79dto1Rmaq7u3GSyb5HlqoWDGFRi40gVBSYg4OWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w3a+0e7hGMsB3X8TXN+qXG+Yj0k9J24CC641Y2nQ6IE=;
 b=GMUt0IrK3+vIN26SMdPfk7sBJNWFqYjoye2IbQ1azGkY9uo0x8saq1BB2RKBFdLOpnaPPfy/yhKKp869KWxDOSzVxU9xoLlcsWD5N49eiZBqdzlUSmVOAVHdt8BJXKzSRePySbsE4jEz0+Geo8Pr+E4YZwokzahA/foqZU9Hnt4VMfF5TO6iOKN6SLFkts+GpwqKF61BpakA9fAwoG96VsCCsWq/R719wjZxARxHjT0U1dcZbmvDVW0JfOWsBR8j2tbV0wNf/Uqs73psSyOI9X0J1wZf5KDROTuBCKcwYJv9gIpVPC7dRLW9iOhAPgkaFrIVF/DACnOzrP5u71Zlig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w3a+0e7hGMsB3X8TXN+qXG+Yj0k9J24CC641Y2nQ6IE=;
 b=bzLM94/qEMpe8+KxXloE7DPEdCTYMNK9eH4WDHkRZfZ9MjnaAPZJq21MOvSFBzkUVL0kbgJtbkNDVH/MjvLwBTooJxumZGnss0riI0Y49hK0VFhg8JMrJx286CprFk8W/F9dXjl9rv0NSAd/RO38IUXlr11e2UsmOt+zJ9NWhJg=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Ray.Huang@amd.com; 
Received: from MN2PR12MB3309.namprd12.prod.outlook.com (20.179.83.157) by
 MN2PR12MB4256.namprd12.prod.outlook.com (52.135.48.78) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2623.9; Wed, 15 Jan 2020 07:49:06 +0000
Received: from MN2PR12MB3309.namprd12.prod.outlook.com
 ([fe80::f945:5c4c:9c3f:930a]) by MN2PR12MB3309.namprd12.prod.outlook.com
 ([fe80::f945:5c4c:9c3f:930a%6]) with mapi id 15.20.2623.018; Wed, 15 Jan 2020
 07:49:06 +0000
Date: Wed, 15 Jan 2020 15:48:57 +0800
From: Huang Rui <ray.huang@amd.com>
To: "Koenig, Christian" <Christian.Koenig@amd.com>
Subject: Re: [PATCH] drm/amdgpu: fill the alignment for secure buffer
Message-ID: <20200115074856.GA20818@jenkins-Celadon-RN>
References: <1579072065-10883-1-git-send-email-ray.huang@amd.com>
 <0045cca4-5197-285c-3808-6c5c5b6eb3e4@amd.com>
Content-Disposition: inline
In-Reply-To: <0045cca4-5197-285c-3808-6c5c5b6eb3e4@amd.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: HK2PR02CA0199.apcprd02.prod.outlook.com
 (2603:1096:201:20::11) To MN2PR12MB3309.namprd12.prod.outlook.com
 (2603:10b6:208:106::29)
MIME-Version: 1.0
Received: from jenkins-Celadon-RN (180.167.199.189) by
 HK2PR02CA0199.apcprd02.prod.outlook.com (2603:1096:201:20::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2644.18 via Frontend Transport; Wed, 15 Jan 2020 07:49:03 +0000
X-Originating-IP: [180.167.199.189]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 8615628c-09f0-4b63-0a21-08d7998f656c
X-MS-TrafficTypeDiagnostic: MN2PR12MB4256:|MN2PR12MB4256:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB4256D700157F8024351F0918EC370@MN2PR12MB4256.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-Forefront-PRVS: 02830F0362
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(396003)(136003)(39860400002)(376002)(366004)(346002)(189003)(199004)(33716001)(316002)(33656002)(6636002)(956004)(478600001)(81156014)(54906003)(8676002)(6862004)(81166006)(8936002)(86362001)(4326008)(52116002)(66556008)(16526019)(186003)(1076003)(26005)(66476007)(9686003)(2906002)(5660300002)(55016002)(6666004)(66946007)(6496006)(21314003);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MN2PR12MB4256;
 H:MN2PR12MB3309.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ue22yI5nr0GIkhuMeecdsa1ryeA1yqIu43O9vBO21UyyT0cM0ZpwC9vXpOykPEzlKa2MOWc6GZZ5sFpb2WUcWMialQE08KT+VjUKZfmMceyHZea7yGtVt9eXhpD67pc3TjDftNXeLeHMM4fiGfbLVw9VXRW+/OS0g1VCs7tNz3dcUFmpDCg99GQnSGbfrPXiFn6y1ztv6LhbrGg7AzMmpu/Q67MSlSQ1zJ6dmHE0aasHvMPBmkjo9NWG1OmBvliTtwipelI68YDSy3u7fSsTJUYsBFm8ZyDCM9pgQCYeTcO2wfvsfBJMFpj43PCygK7sDVaWGw9R19CVkxEebNYx3nCemxzAaEVstdHlOH35gTncwVI/pdH49TJt/SyNMQY6WBq8gAyg6WwR7vH8ECTCYLQWBJlkqLkVxlkYde7bOSYb5KzG3BtS4WCUR3GJSUiOBHEncJySxap4cFc9UpuikF9IZ0o/k+ZJMgwN7JUydbEx9I9O5b6O+u5DwZnEr7PI
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8615628c-09f0-4b63-0a21-08d7998f656c
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jan 2020 07:49:05.9155 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tRoDJTvVBYuTb8ESgROxFWrifmx8zKQn7ebWA6SP96wuxwqUlbVzMxroeN1xY7Bi6rX62O7Pc4SGWEDxWZkzlg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4256
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Pelloux-prayer,
 Pierre-eric" <Pierre-eric.Pelloux-prayer@amd.com>, "Wentland,
 Harry" <Harry.Wentland@amd.com>, "Liu, Aaron" <Aaron.Liu@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Wed, Jan 15, 2020 at 03:45:50PM +0800, Koenig, Christian wrote:
> Am 15.01.20 um 08:07 schrieb Huang Rui:
> > The alignment should match the page size for secure buffer.
> 
> That is superfluous, buffer are aligned to a page size anyway.
> 

If use huge page, will buffer still be aligned?

Thanks,
Ray

> Christian.
> 
> >
> > Signed-off-by: Huang Rui <ray.huang@amd.com>
> > ---
> >   drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c | 7 ++++---
> >   1 file changed, 4 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> > index f39012e..a03eead 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> > @@ -261,9 +261,10 @@ int amdgpu_gem_create_ioctl(struct drm_device *dev, void *data,
> >   		resv = vm->root.base.bo->tbo.base.resv;
> >   	}
> >   
> > -	if (flags & AMDGPU_GEM_CREATE_ENCRYPTED) {
> > -		/* XXX: pad out alignment to meet TMZ requirements */
> > -	}
> > +	/* TMZ requires the secure buffer to align with page size at least */
> > +	if (flags & AMDGPU_GEM_CREATE_ENCRYPTED)
> > +		args->in.alignment = roundup(args->in.alignment,
> > +					     AMDGPU_GPU_PAGE_SIZE);
> >   
> >   	r = amdgpu_gem_object_create(adev, size, args->in.alignment,
> >   				     (u32)(0xffffffff & args->in.domains),
> 
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
