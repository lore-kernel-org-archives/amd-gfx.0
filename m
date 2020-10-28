Return-Path: <SRS0=QeQy=ED=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4199BC388F7
	for <amd-gfx@archiver.kernel.org>; Wed, 28 Oct 2020 15:36:44 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BB03024790
	for <amd-gfx@archiver.kernel.org>; Wed, 28 Oct 2020 15:36:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="awqcaTXd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB03024790
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3D65D6E47B;
	Wed, 28 Oct 2020 15:36:43 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2068.outbound.protection.outlook.com [40.107.220.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 36EBF6E47B
 for <amd-gfx@lists.freedesktop.org>; Wed, 28 Oct 2020 15:36:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XCvOHL9Db20X7cTzfryw+Zw9JZ7f7GAZ/cQRU5i3nKRnwYXjcMCuK+kwHSjQZ+a+51LIt2N2QmXzEJYNd6bVZXC+ZLf0snxSniu9uQNvQY/aqv6hkH6HrbXzC7+LaYNNPZqDie0DSAPv38OHPLKg3Yxt5g4MwjeuLI/GPZcmPEi/tCYCbYalEN6w87vPFnWhsyPDcpS+Jk9GNC7Fv8IxYA0JY3K5iuIglNdqSs0QIxp11CipQU4dgrg2D95KIDA/gaOJ3nYMYsbESdZcrfM4Q1hn9KZoW7b6LEyqDwd+PWD/zXDT7Shcgdb2qALuSVwVJ0fVWS2HNblDRh6wDIIStA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1wdvJ40qrk1fhyQiUvOTzuyftw4asbzodJ/nmgvPnCM=;
 b=m2d2de+OkjlFb7J+ufwSNlk69Ffc6vwF+IfWVWGDyZ5pGpbaag6EKj116OSV/hMEbKoOBqSSVglNeEQBcEJnQ4unAwPuFGQwwzVwq0nf0YTaCxAQzYE/VwwEN00WDiRRAGJO4oOuZB+KTOEfFm1G4DbWwZVJX9DaUJzjbBCazjg50xFhqlOFJk6RiOD4q+dGjpmxcwerlGoXbyvffo3raB9/cRSfyjGHhCwrr7N1QroWH8IyEzoC1HPX6r/EPaoshppXj2+SsVloZpH9RK+MWBNzCB+XyaZLVYWrVjmTpkQGvDKGKBAL9919xx/UMsj8TaaZTPbSIO9n8YFIlxfjhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1wdvJ40qrk1fhyQiUvOTzuyftw4asbzodJ/nmgvPnCM=;
 b=awqcaTXdUDVTbr6+LIm2DfP/3CA1JnL0Lz/1Ic4A9B6qyWJUid0ocwW3T+i6j1Ks4k3zemCigeRL2rg+gggHXBZ0+tT3MKrBTsiFbDSPbTqjZODBWU5bs+EnPFYJ7z4Q85OkOWLsUdytCWP9fo9b4r/of+tWIJiSPYJfQ+jamjc=
Received: from BN6PR1201MB0146.namprd12.prod.outlook.com
 (2603:10b6:405:59::18) by BN8PR12MB2979.namprd12.prod.outlook.com
 (2603:10b6:408:66::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.18; Wed, 28 Oct
 2020 15:36:40 +0000
Received: from BN6PR1201MB0146.namprd12.prod.outlook.com
 ([fe80::615d:bea9:8838:92be]) by BN6PR1201MB0146.namprd12.prod.outlook.com
 ([fe80::615d:bea9:8838:92be%4]) with mapi id 15.20.3477.029; Wed, 28 Oct 2020
 15:36:40 +0000
From: "Kim, Jonathan" <Jonathan.Kim@amd.com>
To: "Tuikov, Luben" <Luben.Tuikov@amd.com>, "Sierra Guiza, Alejandro (Alex)"
 <Alex.Sierra@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: Add kernel parameter to force no xgmi
Thread-Topic: [PATCH] drm/amdgpu: Add kernel parameter to force no xgmi
Thread-Index: AQHWrTplyJjYG0Q86EOM4B1VGzUmb6mtHv4AgAAFvLA=
Date: Wed, 28 Oct 2020 15:36:40 +0000
Message-ID: <BN6PR1201MB0146E58E581CAB0434E8010F85170@BN6PR1201MB0146.namprd12.prod.outlook.com>
References: <20201028145502.2703-1-alex.sierra@amd.com>
 <514739e3-1fcf-6dbb-0dd1-3ea91a54c838@amd.com>
In-Reply-To: <514739e3-1fcf-6dbb-0dd1-3ea91a54c838@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=6f961d1a-d467-4026-b478-cf6ff130b528;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Use Only - Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-10-28T15:32:50Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [2607:fea8:7a0:18d:6086:9ca2:5e9d:7730]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: aa95914d-b920-49d4-8838-08d87b5743c5
x-ms-traffictypediagnostic: BN8PR12MB2979:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BN8PR12MB2979BE19A0A5F99A53E7BC5785170@BN8PR12MB2979.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: rBozTjQfmxbOA/AxgfM5r8WNQh4Ta9z+I2Y+sx/x/fzrTm64s14Df1zwSDnH20hzYHjFAFzJGshb+LPAD2oR1yX996KZ6OHooGlZl1NXxXa1OMM/6B36Nm/kl749Rd8LhN9hC2M3z59DziV9+BwqhA1xmAnU/ciba2Wl0lGYhtgTUo7zuNIyJ+r4wl2IhdGjAZb2Scf5NxxmkrJD1KJIUBOoyqtVVrFljUMLjv5BgZxAayX3RR8PbU9gTqJWcFAcoNj0DR/jMApT3MOm0NhBMyZqmpTYFjBOAPGIyStj1XJLHBHMlgbv8/WCLUWUbw9Zxrhou1vr1MLF7DVFzhAfODU9C584iJX8iO4+sz9eOBCPN3QU+/IgCFT8U19hfFevktajYxPhaCZLDXKYNPXQSw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN6PR1201MB0146.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(346002)(396003)(136003)(39860400002)(366004)(52536014)(5660300002)(110136005)(55016002)(8676002)(7696005)(9686003)(86362001)(66556008)(76116006)(71200400001)(4001150100001)(66446008)(66476007)(64756008)(66946007)(8936002)(83380400001)(186003)(966005)(316002)(53546011)(2906002)(6506007)(478600001)(45080400002)(33656002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: 7lwJ6GS5j70wKTjRSIqJvo8JMcTEC+w8+LeUM5PIypEluziJbdLmDQnwCiYG/U4jjH4WPP6B4BCaHcMtswq5upsQzyOfTOSRYK/QlL2SfgiUibCv+FzvPnD55FqiHWHqnkF5ex3sxxn5wAVv4ik4a5l+Iad4PkvBzL+dCoPcDL1Qolyc5b7zB6w9HTgwuE6n5pFUolP8Ox30J1wLUYsbJzWTbnrQPkvtEKOu83ybQbUJyCT5ujt+skyC4pOK733lLp7GTxkJZ4Yp3phfWhXyry3G0DFF/KAV95Hhe3oBbeUEAmmdpWwD01EBYqq+ihZJVD7SvEUs0vlZ2mLZLrTPMlmmUcmyyaeN0TKA6Y7WaelybtVzyWbUBLYMOQPjt45/lN4+TmTV7WppHyVfrgxuBphv4/UtyBGWHj8ko3i3N8w7bVM5YO0rnKyTe0tC8dNyy7oV7csxtiTvf/zFBXrLQ3ySp9LC5NJkD+izEW9ijn+iRtcLXEog2K+NQJgNKOI76mBy0igTWnhVibIDerxrnZynjskoCCpBsm05m3ZBBYiYTZztkKACgvekWZbf2kVQH41aF4W/JV7//BHzDRVKobJHcop3pk4DlAQYOpeMLKe9C4lLviwMbiakLSGOZAj2JqUD1BEEpA83EaT4HKF+Mkm7tx+8bNGJUFrDGuIDdiHU1hcRaTkU4n3H/M1HuzgjQY4q25Lnc9WbygvsyBThoA==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN6PR1201MB0146.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aa95914d-b920-49d4-8838-08d87b5743c5
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Oct 2020 15:36:40.1175 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BP9Ak5Pfrp2jZx/1wWJLGp8HEvakSx3/Ias6/pa4ig2GyarPRqfp9LMNzaEU4caj
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB2979
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - Internal Distribution Only]

> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of
> Luben Tuikov
> Sent: Wednesday, October 28, 2020 11:12 AM
> To: Sierra Guiza, Alejandro (Alex) <Alex.Sierra@amd.com>; amd-
> gfx@lists.freedesktop.org
> Subject: Re: [PATCH] drm/amdgpu: Add kernel parameter to force no xgmi
>
> [CAUTION: External Email]
>
> On 2020-10-28 10:55, Alex Sierra wrote:
> > By enabling this parameter, the system will be forced to use pcie
> > interface only for p2p transactions.
> >
> > Signed-off-by: Alex Sierra <alex.sierra@amd.com>
> > ---
> >  drivers/gpu/drm/amd/amdgpu/amdgpu.h        | 1 +
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 2 +-
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c    | 9 +++++++++
> >  3 files changed, 11 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> > b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> > index ba65d4f2ab67..3645f00e9f61 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> > @@ -188,6 +188,7 @@ extern int amdgpu_discovery;  extern int
> > amdgpu_mes;  extern int amdgpu_noretry;  extern int
> > amdgpu_force_asic_type;
> > +extern int amdgpu_force_no_xgmi;
> >  #ifdef CONFIG_HSA_AMD
> >  extern int sched_policy;
> >  extern bool debug_evictions;
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> > b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> > index 1fe850e0a94d..0a5d97a84017 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> > @@ -2257,7 +2257,7 @@ static int amdgpu_device_ip_init(struct
> amdgpu_device *adev)
> >       if (r)
> >               goto init_failed;
> >
> > -     if (adev->gmc.xgmi.num_physical_nodes > 1)
> > +     if (!amdgpu_force_no_xgmi && adev->gmc.xgmi.num_physical_nodes
> >
> > + 1)
> >               amdgpu_xgmi_add_device(adev);
> >       amdgpu_amdkfd_device_init(adev);
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> > b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> > index 4b78ecfd35f7..22485067cf31 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> > @@ -160,6 +160,7 @@ int amdgpu_force_asic_type = -1;  int amdgpu_tmz
> =
> > 0;  int amdgpu_reset_method = -1; /* auto */  int amdgpu_num_kcq = -1;
> > +int amdgpu_force_no_xgmi = 0;
> >
> >  struct amdgpu_mgpu_info mgpu_info = {
> >       .mutex = __MUTEX_INITIALIZER(mgpu_info.mutex),
> > @@ -522,6 +523,14 @@ module_param_named(ras_enable,
> amdgpu_ras_enable,
> > int, 0444);  MODULE_PARM_DESC(ras_mask, "Mask of RAS features to
> > enable (default 0xffffffff), only valid when ras_enable == 1");
> > module_param_named(ras_mask, amdgpu_ras_mask, uint, 0444);
> >
> > +/**
> > + * DOC: force_no_xgmi (uint)
> > + * Forces not to use xgmi interface (0 = disable, 1 = enable).
>
> How about using human English here? Perhaps something like,
>
> "Forces not to use" ==> "Disables the use of the XGMI interface ..."
>
> Or, if you use the suggestion Christian posted, you could say something like,
>
> "Enable XGMI for P2P transactions."

I second the use of enable.  The fact that we can prevent xGMI init means we enable it by default.

Thanks,

Jon

>
> Regards,
> Luben
>
> > + * Default is 0 (disabled).
> > + */
> > +MODULE_PARM_DESC(force_no_xgmi, "Force not to use xgmi
> interface");
> > +module_param_named(force_no_xgmi, amdgpu_force_no_xgmi, int,
> 0600);
> > +
> >  /**
> >   * DOC: si_support (int)
> >   * Set SI support driver. This parameter works after set config
> > CONFIG_DRM_AMDGPU_SI. For SI asic, when radeon driver is enabled,
> >
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.
> freedesktop.org%2Fmailman%2Flistinfo%2Famd-
> gfx&amp;data=04%7C01%7Cjonathan.kim%40amd.com%7C7e0b2ac9a2ac4c7
> 8353008d87b53e1b3%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7
> C637394947518556523%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAw
> MDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sda
> ta=ve9KxUmOXYYYS8MQJBkzW7V%2FRxCORSVWxlUzhFRYxzw%3D&amp;re
> served=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
