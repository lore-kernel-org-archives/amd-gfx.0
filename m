Return-Path: <SRS0=i8pd=27=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 889DAC282DD
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Jan 2020 18:47:33 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 542C32082E
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Jan 2020 18:47:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="qISgUoYw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 542C32082E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0A9A46EA8A;
	Fri, 10 Jan 2020 18:47:33 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2049.outbound.protection.outlook.com [40.107.243.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ABDAC6EA8A
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Jan 2020 18:47:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O86jgJcp+KsalwX2EBIgUYCkNKAOZTSVWvJfeZFP8eNM6VHtk2G+orXRokc9B1XV4jlxOdri45XtWRnIf1R98so2wRMYkx7eLZoUXJrYFZKKZc2MRuGyn4tXL4oP0LmLm3lgXQ7MxO4t7gOp0hcZgd2LQfHw0xiT1p5TmB2fpQlBvZemtJ3PhMtqTxO62gqEi/8GfTl9VuYq89FJMopnAAzxihqRD1m9sEjYuLMZN+AWHDcqhyS5ia1nOJFU7cqujaUfTzFFN+LeaQjnZli12MynpoxE05nK0E11icbO3bloq3XEwciCMNin0qKXF1Dv7s/OkC8nGRB/xnFwhgysgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nRSHqlpW1/HDBdgUlf7QRgtWXSYriD8C1iSACPpRt2A=;
 b=oDD5PfXmU3Az2sFikZ5MFN1E59lrGVNWTwwYO38IWM/04Lmty1DvD8Jy8cWM1RgFlQvv17BdPEWSgoDM713s3iP4BMGhNWe57PKDoFP6N41rLWv0BojBQxauzN3PC6WlBQivJAhGYgtmjZrkNqQAPaBhV4+mLZzIaruy+WflbToKZgFgHmlKN+Xln77jDPDnUTmAX6owZGCrTef5/YnNnZ050UPKE+QS602UU8pckVPSGSc5q2qJ864F5OHaOvPRreXvyPVvCfVHG5rtfkpt9VtU+zX3FD3lj0kmL3rK/SjINv4d8rfcOirfm2YRNnFk0tv6I8YLpsT7CzIkNqNWNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nRSHqlpW1/HDBdgUlf7QRgtWXSYriD8C1iSACPpRt2A=;
 b=qISgUoYwpTVNhcF4vm6SPNYqLsfHaQQKNg3rMURGM8SiBStL+9x6ja65F4hBXB+mN4b/rwp7I9CLmh5T1DZ8fh93apC1rxnT0JojMTnZQXMwst870knfnDEbalJdpkX6NAkN30cv1z0JdTHyHEkU3RvrgTJ601IPxEQybvMhopc=
Received: from DM5PR1201MB2554.namprd12.prod.outlook.com (10.172.92.14) by
 DM5PR1201MB0105.namprd12.prod.outlook.com (10.174.106.23) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2623.13; Fri, 10 Jan 2020 18:47:30 +0000
Received: from DM5PR1201MB2554.namprd12.prod.outlook.com
 ([fe80::918b:7720:5da1:d845]) by DM5PR1201MB2554.namprd12.prod.outlook.com
 ([fe80::918b:7720:5da1:d845%9]) with mapi id 15.20.2623.013; Fri, 10 Jan 2020
 18:47:29 +0000
From: "Liu, Zhan" <Zhan.Liu@amd.com>
To: "Koenig, Christian" <Christian.Koenig@amd.com>, "Siqueira, Rodrigo"
 <Rodrigo.Siqueira@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 39/43] drm/amd/display: Use udelay to avoid context switch
Thread-Topic: [PATCH 39/43] drm/amd/display: Use udelay to avoid context switch
Thread-Index: AQHVx8UI3mqWC9HEtUWLAlgEWcGNWqfj/jYAgAA9/6A=
Date: Fri, 10 Jan 2020 18:47:29 +0000
Message-ID: <DM5PR1201MB25546012AE5DE4AB84B38BAD9E380@DM5PR1201MB2554.namprd12.prod.outlook.com>
References: <20200110144655.55845-1-Rodrigo.Siqueira@amd.com>
 <20200110144655.55845-40-Rodrigo.Siqueira@amd.com>
 <e5846131-ed59-2790-30c1-c44b19ad8914@gmail.com>
In-Reply-To: <e5846131-ed59-2790-30c1-c44b19ad8914@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Zhan.Liu@amd.com; 
x-originating-ip: [165.204.55.250]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 803e424e-fc4e-4563-d7dc-08d795fd8bb0
x-ms-traffictypediagnostic: DM5PR1201MB0105:|DM5PR1201MB0105:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR1201MB0105579FA99EBDD6498A42489E380@DM5PR1201MB0105.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2512;
x-forefront-prvs: 02788FF38E
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(376002)(346002)(366004)(396003)(39860400002)(136003)(199004)(189003)(7696005)(54906003)(2906002)(26005)(6506007)(110136005)(53546011)(71200400001)(55016002)(316002)(86362001)(8676002)(81166006)(66574012)(81156014)(33656002)(8936002)(4326008)(186003)(64756008)(66476007)(66556008)(66946007)(9686003)(66446008)(478600001)(5660300002)(76116006)(52536014);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM5PR1201MB0105;
 H:DM5PR1201MB2554.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0FfXJQQyeilv23q+slp4s+romqr1OcKkmhA92clGL1sCi5yvpX42oyVMGPJHycrzFxB42m3UL3/hiYiwLIpQ7zrJTTvjCQ6xqNpm6KCZVcsA2Q+N8QtcCFP33tRxCfts+qWMXoZ6xGqQHv3FAxGYSNNPp6bTgbQNyLsnt2tfzZ3nadH7GyTgcE8fNsJSgOjIRJvKPSHMG08nz4Sgt9BO6DLzoux3Z4S3ldnbyAfb4E6vhkknyRrWYJvzSPN/zlYceF/soqeG/6PIMR4nDEfL0prbPtrTndKM1SEC753mffbDQzst3DiGLyNb8A1M2IUv0ZSSNlQk/kxWbbukI5ZtnmYHu5hnwYu+Sxir8E8lIyLU5mFm/15WCUVlPFAskXAo9ZgZxp3Toy2j9r4LA139IVtPuwx0Jbv9RCz7/Z9RKjFO0s0hGMaUz3gE64jQxHcP
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 803e424e-fc4e-4563-d7dc-08d795fd8bb0
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jan 2020 18:47:29.6442 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6+fSMmO3iuWkrjFinJuce4lOLYC+wEuPNV50K+H0B4VZEs8ye5kxa02moXoHrUol
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB0105
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
Cc: "Li, Sun peng \(Leo\)" <Sunpeng.Li@amd.com>, "Tsai,
 Martin" <Martin.Tsai@amd.com>, "Lakha, 
 Bhawanpreet" <Bhawanpreet.Lakha@amd.com>, "Cheng, Tony" <Tony.Cheng@amd.com>,
 "Wentland, Harry" <Harry.Wentland@amd.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of
> Christian K=F6nig
> Sent: 2020/January/10, Friday 10:02 AM
> To: Siqueira, Rodrigo <Rodrigo.Siqueira@amd.com>; amd-
> gfx@lists.freedesktop.org
> Cc: Li, Sun peng (Leo) <Sunpeng.Li@amd.com>; Cheng, Tony
> <Tony.Cheng@amd.com>; Tsai, Martin <Martin.Tsai@amd.com>; Lakha,
> Bhawanpreet <Bhawanpreet.Lakha@amd.com>; Wentland, Harry
> <Harry.Wentland@amd.com>
> Subject: Re: [PATCH 39/43] drm/amd/display: Use udelay to avoid context
> switch
> =

> Am 10.01.20 um 15:46 schrieb Rodrigo Siqueira:
> > From: Martin Tsai <martin.tsai@amd.com>
> >
> > [why]
> > The rapid msleep operation causes the white line garbage when DAL
> > check flip pending status in SetVidPnSourceVisibility.
> > To execute this msleep will induce context switch, and longer delay
> > could cause worse garbage situation.
> >
> > [how]
> > To replace msleep with udelay.
> >
> > Signed-off-by: Martin Tsai <martin.tsai@amd.com>
> > Reviewed-by: Tony Cheng <Tony.Cheng@amd.com>
> > Acked-by: Harry Wentland <harry.wentland@amd.com>
> > Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
> > ---
> >   drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c | 4 ++--
> >   1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
> > b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
> > index 89920924a154..0dc652e76848 100644
> > --- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
> > +++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
> > @@ -1642,9 +1642,9 @@ void dcn20_program_front_end_for_ctx(
> >   			struct hubp *hubp =3D pipe->plane_res.hubp;
> >   			int j =3D 0;
> >
> > -			for (j =3D 0; j < TIMEOUT_FOR_PIPE_ENABLE_MS
> > +			for (j =3D 0; j < TIMEOUT_FOR_PIPE_ENABLE_MS*1000
> >   					&& hubp->funcs-
> >hubp_is_flip_pending(hubp); j++)
> > -				msleep(1);
> > +				udelay(1);
> =

> Why not using mdelay() here?

As far as I know, mdelay() is only defined on Linux side.

This piece of code is shared by both Linux and Windows, so we have to use a=
 function that's available on both platforms.

Zhan

> =

> Christian.
> =

> >   		}
> >   	}
> >
> =

> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
