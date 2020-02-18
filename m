Return-Path: <SRS0=rgj7=4G=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F209DC34031
	for <amd-gfx@archiver.kernel.org>; Tue, 18 Feb 2020 08:27:16 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C1F7E21D56
	for <amd-gfx@archiver.kernel.org>; Tue, 18 Feb 2020 08:27:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="VBljI17o"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C1F7E21D56
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 77CAB6E17E;
	Tue, 18 Feb 2020 08:27:16 +0000 (UTC)
Received: from NAM04-CO1-obe.outbound.protection.outlook.com
 (mail-eopbgr690065.outbound.protection.outlook.com [40.107.69.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 98C516E17E
 for <amd-gfx@lists.freedesktop.org>; Tue, 18 Feb 2020 08:27:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U+EENUDlvAvoxNZL7KjgiGmoAoySSg7rZXbGkIek+DEVpe6ZeeVeZfmFUqlWuX92Hpm9uQNwh1bQGhqRN9arOx7HUgGGAa7pUwNPp5BQScCMuToiIzBzdrymvlnCA7YNLQYMG/s/8tGhyZHG9DQTIl8q3g9Ep6C5QJhKCC5iGFTNfcsP7KJ+oNGr6P2Z53czMeL0gOMbc4G+urxzowubpjolKgK1jgIusuW0OMlWpiFHH0K7DHcd0b8C07FSUeWhlguxdLEjXeCPe8WLpZor2yz5PGQnjiBPkXxq14XIcMwjXGvtznbxrEy/QcJuGP/dVG6dcsYueO4ajfNyCb+s8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rJzW1g8ndGE+Y1OCx+4aVCk21gKkj1bpMS6yX5gEBNU=;
 b=agEDJXUjRKZdMVWjgNso+d+Gnafd1IKonZAm16IenS5yh4hrh8iyEqfvd+Nckam3WcQAo8HOqEt9sMdDtC7iUeXiIdAileKNdq9965UhaQmMOXlZ682EuqpBOcY0FLgNez+qwJF1nqx9kG/SHOFd9rNVLQg5WI0T/SWQWWG+yMDqkTOV51uL33+xpqyloGeQ+NXL0X5JRI/vsty7UF+41SlB+t9eeE8NX+kn76Ne/8MofB0g2UYPNJhEfAME3K9ZWYzVXVNbV1P5WdsY6BUZ2PwgCtWbyEJql2H+Cw8lnKh0s3PYethViPKlG7QpinLSROsSe3rxooHy3l0TySEw4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rJzW1g8ndGE+Y1OCx+4aVCk21gKkj1bpMS6yX5gEBNU=;
 b=VBljI17oBnkiXpQ50poj93Bi8knmOYZ+oHj7BhsVEwk4oFz4/1frxFJLOgsoJasKFhQCgrLMaM/H7ABhZZFdajtZndjykePvlcY/pXnl83oaWhsXzI7KnuXdx5N4UiP3KdTk/ZZnkwKcNrGLq84bloEN3KZ7P/h4azIDfHeQMSY=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Ray.Huang@amd.com; 
Received: from MN2PR12MB3309.namprd12.prod.outlook.com (20.179.83.157) by
 MN2PR12MB4016.namprd12.prod.outlook.com (10.255.238.158) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2729.23; Tue, 18 Feb 2020 08:27:13 +0000
Received: from MN2PR12MB3309.namprd12.prod.outlook.com
 ([fe80::f945:5c4c:9c3f:930a]) by MN2PR12MB3309.namprd12.prod.outlook.com
 ([fe80::f945:5c4c:9c3f:930a%6]) with mapi id 15.20.2729.032; Tue, 18 Feb 2020
 08:27:13 +0000
Date: Tue, 18 Feb 2020 16:27:04 +0800
From: Huang Rui <ray.huang@amd.com>
To: "Koenig, Christian" <Christian.Koenig@amd.com>
Subject: Re: [PATCH] drm/amdgpu: fix the wrong logic checking when secure
 buffer is created
Message-ID: <20200218082703.GA6610@jenkins-Celadon-RN>
References: <1582006331-32356-1-git-send-email-ray.huang@amd.com>
 <d4595b32-a5a2-483b-117b-606c9e28ce25@amd.com>
Content-Disposition: inline
In-Reply-To: <d4595b32-a5a2-483b-117b-606c9e28ce25@amd.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: HK2PR0401CA0005.apcprd04.prod.outlook.com
 (2603:1096:202:2::15) To MN2PR12MB3309.namprd12.prod.outlook.com
 (2603:10b6:208:106::29)
MIME-Version: 1.0
Received: from jenkins-Celadon-RN (180.167.199.189) by
 HK2PR0401CA0005.apcprd04.prod.outlook.com (2603:1096:202:2::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2729.24 via Frontend
 Transport; Tue, 18 Feb 2020 08:27:11 +0000
X-Originating-IP: [180.167.199.189]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 8edb5831-7766-46ec-260e-08d7b44c5b25
X-MS-TrafficTypeDiagnostic: MN2PR12MB4016:|MN2PR12MB4016:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB40163CD7790C79898433C229EC110@MN2PR12MB4016.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-Forefront-PRVS: 031763BCAF
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(39860400002)(396003)(366004)(346002)(136003)(376002)(189003)(199004)(478600001)(6666004)(52116002)(86362001)(6496006)(186003)(5660300002)(16526019)(33716001)(956004)(66556008)(4326008)(33656002)(316002)(9686003)(54906003)(2906002)(66946007)(55016002)(66476007)(6862004)(8676002)(6636002)(1076003)(66574012)(26005)(81166006)(8936002)(81156014);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MN2PR12MB4016;
 H:MN2PR12MB3309.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7Jst5S3EFh+EXqW34RoQacji8R+0oSIuoF78GQphfvKd11pV+ITefW1lm4poDFpxmiR5BzbqvFxJestNnbr5t97R9YraVIbXESb5l8Z7tX3+pLr9AB8Js1xmtvJvrqoVHnA4L7Cw0OLdH8C2FisKZAgJs7PlDtI5wrTfPJ7nY+ImHCrGYT8/VkFDdZS1c+wm/hYurfpZkgYZphg/c7TuL13qId/tkuXORtzdbjqPRG4wZPVI7qhpZwzLz3llp02NDsgbxPLnxZDu9SLVc40ncem7vxkOefZuN9pKWuJ+LYnQCwaMKUWpdhvV6CwK7C+SwfRVv/RhlQh3sLYfQl5OX3Cilf+ChmphJ9LBYCEj1KK122eFEqx2Mx6YvTS8TIjbR3/up0m8nm3AjX6ykTMErVPGwoxPBiH+BQ9dqNm+B4PZ+Lr8cR+JCkUSIHmR8i9G
X-MS-Exchange-AntiSpam-MessageData: rvKgtfB0ZJAXKScZ1mDmmeEEDb3Stn6hEP0z7RqXJ5HO/819huAypl6nh8vQxm6e3iXs7mxDLq29wyY4UezUITAf6Q8aW/Pq1hbxLynphbB49+F8xaVTHoC+HItrKHRgHoshRfiHvRV+FOnP4xhdvg==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8edb5831-7766-46ec-260e-08d7b44c5b25
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2020 08:27:13.7548 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZsZGeaKXg2Why6vbTfT5sc5pSH2nxPTtgjC1QWF/fm4V0WmI/X3PFDLsxKXs5Q4F6ZNEZRRyEWWI2sPIXDCNwA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4016
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
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Tue, Feb 18, 2020 at 04:04:15PM +0800, Koenig, Christian wrote:
> Am 18.02.20 um 07:12 schrieb Huang Rui:
> > While the current amdgpu doesn't support TMZ, it will return the error =
if user
> > mode would like to allocate secure buffer.
> >
> > Fixes: 17d907c drm/amdgpu: implement TMZ accessor (v3)
> >
> > Signed-off-by: Huang Rui <ray.huang@amd.com>
> =

> Reviewed-by: Christian K=F6nig <christian.koenig@amd.com>
> =

> > ---
> >   drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_gem.c
> > index b51a060..91e4235 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> > @@ -235,7 +235,7 @@ int amdgpu_gem_create_ioctl(struct drm_device *dev,=
 void *data,
> >   	if (args->in.domains & ~AMDGPU_GEM_DOMAIN_MASK)
> >   		return -EINVAL;
> >   =

> > -	if (amdgpu_is_tmz(adev) && (flags & AMDGPU_GEM_CREATE_ENCRYPTED)) {
> > +	if (!amdgpu_is_tmz(adev) && (flags & AMDGPU_GEM_CREATE_ENCRYPTED)) {
> >   		DRM_ERROR("Cannot allocate secure buffer since TMZ is disabled\n");
> =

> BTW: This message should be removed because it allows userspace to spam =

> the logs.
> =


Fine. This can be removed.

Thanks,
Ray

> >   		return -EINVAL;
> >   	}
> =

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
