Return-Path: <SRS0=Z8oe=5X=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FUZZY_PRICES,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A2FFC2BA16
	for <amd-gfx@archiver.kernel.org>; Tue,  7 Apr 2020 08:26:26 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B42AA206F5
	for <amd-gfx@archiver.kernel.org>; Tue,  7 Apr 2020 08:26:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="EgjX8QwP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B42AA206F5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7FDD589F73;
	Tue,  7 Apr 2020 08:26:25 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2042.outbound.protection.outlook.com [40.107.244.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C472589F73
 for <amd-gfx@lists.freedesktop.org>; Tue,  7 Apr 2020 08:26:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YUjXFzFzPSFKHBGYTUwhleJESJe9HmuczEUEV0DnZ2NegtUs0Cy0tRZmoHFPVVAzhtONdhrqqLocLMMw28I1Gyw80S64Y+UiOv+RDLjtkPH5huUPgCXZEGVWprFVaNQ8kuo1Vuhij4fW+Z6YTDCD/qoiZh2qV0hYRbkL7Fb9RsGhQkPbkvanZsTz7/liKoquklMk0v2eZKEp7ZQlm6iD6tLMhCMKn/0Wisp8uEwZEYue5ErFiS8sepXD0vpnATdljPty/TsImpnX1zvFCg4PI0y4rmoHbbh3zgx83b62SziwJVLjEg2YuLGEQLTN9Y/Ree/oZWUiTvWG3zUQzy29Fg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5/fnCAEGaz4Ty+UdA5HHOlTFkK/TZvGEaEodAQ3Nxk8=;
 b=BKPaZb+devst3afAPSmMqD1NDX/fCwW0RoBlxDKUSxJgurYvrrSZyVcu9tjdphSB/bLNLCR03uDWIphRUyuktQl+kb+KpSjIR3sOH4dOGI8xarN8kOfrxrIcn7Sj7g4HBjrG680usRkd8QsECghbeF71yCPDvHvx7Rq6a/RccK+uw7wA3j+H7aYe9WflxNE3oX2Na4Es+0DTCRhTGZHfIwPZjfwLvMPhTWVpCjBeb5RSjsb+tCYsObNXMY+hbSnc0WTnj6dzbSh8ia6qVcu3u3HABJB7/UPd13UZEa12SBi17Rhxn5v5i06gaeRE1nC9aRBJeDB1gwCK3nWaHkf+mg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5/fnCAEGaz4Ty+UdA5HHOlTFkK/TZvGEaEodAQ3Nxk8=;
 b=EgjX8QwP2O5O4Y+VjpZpUhT2daXC0vQUrnjpwNXHnls6UT82wAmyUED03dNlTjdlECj//2203AmXhVRRT6E8k+jvMz9bojGYajyadIhlv6AZaMVVXaPfNd7k3P96qRsZIeYy1+/j309JufzIZ+tsePzGsNusqnRT98aa3YE5+JI=
Received: from MN2PR12MB3536.namprd12.prod.outlook.com (2603:10b6:208:104::19)
 by MN2PR12MB3870.namprd12.prod.outlook.com (2603:10b6:208:166::29)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2878.19; Tue, 7 Apr
 2020 08:26:20 +0000
Received: from MN2PR12MB3536.namprd12.prod.outlook.com
 ([fe80::424:4ce2:f779:d08b]) by MN2PR12MB3536.namprd12.prod.outlook.com
 ([fe80::424:4ce2:f779:d08b%4]) with mapi id 15.20.2878.022; Tue, 7 Apr 2020
 08:26:20 +0000
From: "Liang, Prike" <Prike.Liang@amd.com>
To: "Huang, Ray" <Ray.Huang@amd.com>
Subject: RE: [PATCH] drm/amdgpu: fix gfx hang during suspend with video
 playback
Thread-Topic: [PATCH] drm/amdgpu: fix gfx hang during suspend with video
 playback
Thread-Index: AQHWCW1+xKCgFizMkEyLyz6Szs7fQqhm7tUAgAAUzsCAAChvgIAABlOAgAXzQtCAAC1ogIAABFlA
Date: Tue, 7 Apr 2020 08:26:19 +0000
Message-ID: <MN2PR12MB353690325FB658194DDFCB77FBC30@MN2PR12MB3536.namprd12.prod.outlook.com>
References: <1585886873-22825-1-git-send-email-Prike.Liang@amd.com>
 <20200403062642.GA9191@jenkins-Celadon-RN>
 <MN2PR12MB3536631520E378DE4DAACCAAFBC70@MN2PR12MB3536.namprd12.prod.outlook.com>
 <20200403100554.GA9721@jenkins-Celadon-RN>
 <20200403102832.GB9721@jenkins-Celadon-RN>
 <MN2PR12MB3536428C0B9FE390FC01C74CFBC30@MN2PR12MB3536.namprd12.prod.outlook.com>
 <20200407080300.GA27094@jenkins-Celadon-RN>
In-Reply-To: <20200407080300.GA27094@jenkins-Celadon-RN>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=fe064b66-ddf5-4cc6-8ab1-000064ea9d3a;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Use Only - Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-04-07T08:18:35Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Prike.Liang@amd.com; 
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 45747c17-a7bc-4d11-8bb6-08d7dacd5984
x-ms-traffictypediagnostic: MN2PR12MB3870:|MN2PR12MB3870:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB38708377B8B5E1679834447AFBC30@MN2PR12MB3870.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 036614DD9C
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB3536.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10009020)(4636009)(39860400002)(396003)(376002)(366004)(346002)(136003)(66446008)(4326008)(6506007)(6862004)(76116006)(53546011)(2906002)(86362001)(5660300002)(26005)(45080400002)(66946007)(186003)(66476007)(66556008)(64756008)(7696005)(966005)(33656002)(478600001)(71200400001)(81166006)(15650500001)(8676002)(52536014)(6636002)(55016002)(54906003)(8936002)(81156014)(316002)(9686003);
 DIR:OUT; SFP:1101; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: G8fS8QZI0pco5RYxUcnRN6bsaHg/cPo97xSGszMtcjq8WWxtJE2JrC/39SPDb1TKK00gJTIULKmWtGSWPi7zzi1DIrsFjoPb2B6i/I2ly1BwjPi+yPfkp0ZLOYMWpYg8GMkVFyKXcFI8xEzEVx8j4KjzG8kPOiifwnpbxHpvh/ghfAIH4G2+KzOK+p+9w8fIrJSBzEMkshEfOkDvQBA3k2MiW3cwFgboW0EERI0CNx+jOQIZEuiqMSIqUIEqJtIXHLGQohx8u13FHPyPO2lyWRfe2cgNJUiDWWshXfk4dCHyfWZ9n99BTgOFu5IZEi91Bn65o30HeTA4J5HqKY+k81XH6JCHk8jXqBuiaSEDs2h/12pTqjqnuGX/BAP4zEr7bctDn/MhZjt2uZxXS37tdbBwUPfc2e02jpMPOH/aP17lKsQT5DGgEEulGqIcS3szpCm5nBnQ0lSZZsOipNC4riqj2RRrV9Muu3h/cNAHZfh8ANdasZZIYfEReOcHtVKHehOaVifCF6/euRGPqS5FqA==
x-ms-exchange-antispam-messagedata: 11UzpT8udlaXmqm47+2w6T0U1MnSXuodaTCKgHuiGDoOQAma+un5hA1RFBT1wSZGep6vpzJHCZHESEIHhADPvpiDyFwx9OZFZDRJ7f/O9vhIe7YOF+m2Zjmawk3uVfVXDYHCtq/gzE+Si5WQD+KKLA==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 45747c17-a7bc-4d11-8bb6-08d7dacd5984
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Apr 2020 08:26:19.9415 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: n3JjdTRINBpFwz3DMBv+sVnti0WX0kvroQwkZn58koyQvW78bYEgVXK1sRwvBywA
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3870
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Kuehling,
 Felix" <Felix.Kuehling@amd.com>, "Quan, Evan" <Evan.Quan@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



> -----Original Message-----
> From: Huang, Ray <Ray.Huang@amd.com>
> Sent: Tuesday, April 7, 2020 4:03 PM
> To: Liang, Prike <Prike.Liang@amd.com>
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Kuehling, Felix
> <Felix.Kuehling@amd.com>; Quan, Evan <Evan.Quan@amd.com>; amd-
> gfx@lists.freedesktop.org
> Subject: Re: [PATCH] drm/amdgpu: fix gfx hang during suspend with video
> playback
> 
> On Tue, Apr 07, 2020 at 01:49:43PM +0800, Liang, Prike wrote:
> >
> > > -----Original Message-----
> > > From: Huang, Ray <Ray.Huang@amd.com>
> > > Sent: Friday, April 3, 2020 6:29 PM
> > > To: Liang, Prike <Prike.Liang@amd.com>
> > > Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Kuehling, Felix
> > > <Felix.Kuehling@amd.com>; Quan, Evan <Evan.Quan@amd.com>; amd-
> > > gfx@lists.freedesktop.org
> > > Subject: Re: [PATCH] drm/amdgpu: fix gfx hang during suspend with
> > > video playback
> > >
> > > On Fri, Apr 03, 2020 at 06:05:55PM +0800, Huang Rui wrote:
> > > > On Fri, Apr 03, 2020 at 05:22:28PM +0800, Liang, Prike wrote:
> > > > >
> > > > > > -----Original Message-----
> > > > > > From: Huang, Ray <Ray.Huang@amd.com>
> > > > > > Sent: Friday, April 3, 2020 2:27 PM
> > > > > > To: Liang, Prike <Prike.Liang@amd.com>
> > > > > > Cc: amd-gfx@lists.freedesktop.org; Quan, Evan
> > > <Evan.Quan@amd.com>;
> > > > > > Deucher, Alexander <Alexander.Deucher@amd.com>; Kuehling,
> > > > > > Felix <Felix.Kuehling@amd.com>
> > > > > > Subject: Re: [PATCH] drm/amdgpu: fix gfx hang during suspend
> > > > > > with video playback
> > > > > >
> > > > > > (+ Felix)
> > > > > >
> > > > > > On Fri, Apr 03, 2020 at 12:07:53PM +0800, Liang, Prike wrote:
> > > > > > > The system will be hang up during S3 as SMU is pending at GC
> > > > > > > not respose the register CP_HQD_ACTIVE access request and
> > > > > > > this issue can be fixed by adding RLC safe mode guard before
> > > > > > > each HQD map/unmap retrive opt.
> > > > > >
> > > > > > We need more information for the issue, does the map/unmap is
> > > > > > required for MAP_QUEUES/UNMAP_QUEUES packets or writing with
> > > MMIO or both?
> > > > > >
> > > > > [Prike]  The issue hang up at MP1 was trying to read register
> > > > > RSMU_RESIDENCY_COUNTER_GC but did not get response from GFX,
> > > since GFX was busy at reading register CP_HQD_ACTIVE.
> > > > > Moreover, when disabled GFXOFF this issue also can't see so
> > > > > there is likely to perform register accessed at GFXOFF CGPG/CGCG
> enter stage.
> > > > > As for only  this issue, that seems just MMIO  access failed
> > > > > case which
> > > occurred under QUEUE map/unmap status check.
> > > > >
> > > >
> > > > While we start to do S3, we will disable gfxoff at start of suspend.
> > > > Then in this point, the gfx should be always in "on" state.
> > > >
> > > > > > From your patch, you just protect the kernel kiq and user queue.
> > > > > > What about other kernel compute queues? HIQ?
> > > > > >
> > > > > [Prike] So far just find the KIQ/CPQ/DIQ map/unmap will inquire
> > > > > the CP_HQD_ACTIVE status by MMIO accessing, therefore just guard
> > > > > the KIQ
> > > and some type user queue now. Regarding HIQ map and ummap which
> used
> > > the method of submitting configuration packet.
> > > > >
> > > >
> > > > KIQ itself init/unit should be always under gfx on state. Can you
> > > > give a check the result if not add enter/exit rlc safe mode around it?
> > >
> > > Wait... In your case, the system didn't load any user queues because
> > > no ROCm based application is running. So the issue is probably
> > > caused by KIQ itself init/unit, can you confirm?
> > [Prike]  This  improper register access is under performing MQD
> > destroy during amdkfd suspend period. For the KIQ UNI process may not
> > need the RLC guard as GFX CGPG has been disabled at the early suspend
> period.
> 
> How about move below gfxoff/cgpg disabling ahead of
> amdgpu_amdkfd_suspend?
> 
>         amdgpu_device_set_pg_state(adev, AMD_PG_STATE_UNGATE);
>         amdgpu_device_set_cg_state(adev, AMD_CG_STATE_UNGATE);
> 
>         amdgpu_amdkfd_suspend(adev, !fbcon);
> 
> We should disable the gfxoff/cgpg at first to avoid mmio access.
> 
[Prike]  Generally speaking that's fine to un-gate the CGPG before each GFX MMIO access.
 That's should be no different to enter RLC safe mode.
So do you prefer the solution to move the CGPG ungated at suspend early time right ? 

> Thanks,
> Ray
> 
> >
> > If have concern the other case over guard will send a patch for simplify it.
> > >
> > > Thanks,
> > > Ray
> > >
> > > >
> > > > Hi Felix, maybe we need to use packets with kiq to map all user queues.
> > > >
> > > > Thanks,
> > > > Ray
> > > >
> > > > > > Thanks,
> > > > > > Ray
> > > > > >
> > > > > > >
> > > > > > > Signed-off-by: Prike Liang <Prike.Liang@amd.com>
> > > > > > > Tested-by: Mengbing Wang <Mengbing.Wang@amd.com>
> > > > > > > ---
> > > > > > >  drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c | 6
> > > ++++++
> > > > > > >  drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c             | 4 ++++
> > > > > > >  2 files changed, 10 insertions(+)
> > > > > > >
> > > > > > > diff --git
> > > > > > > a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
> > > > > > > b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
> > > > > > > index df841c2..e265063 100644
> > > > > > > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
> > > > > > > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
> > > > > > > @@ -232,6 +232,7 @@ int kgd_gfx_v9_hqd_load(struct kgd_dev
> > > > > > > *kgd, void
> > > > > > *mqd, uint32_t pipe_id,
> > > > > > >  	uint32_t *mqd_hqd;
> > > > > > >  	uint32_t reg, hqd_base, data;
> > > > > > >
> > > > > > > +	amdgpu_gfx_rlc_enter_safe_mode(adev);
> > > > > > >  	m = get_mqd(mqd);
> > > > > > >
> > > > > > >  	acquire_queue(kgd, pipe_id, queue_id); @@ -299,6 +300,7
> @@
> > > > > > > int kgd_gfx_v9_hqd_load(struct kgd_dev *kgd, void *mqd,
> > > > > > > uint32_t pipe_id,
> > > > > > >
> > > > > > >  	release_queue(kgd);
> > > > > > >
> > > > > > > +	amdgpu_gfx_rlc_exit_safe_mode(adev);
> > > > > > >  	return 0;
> > > > > > >  }
> > > > > > >
> > > > > > > @@ -497,6 +499,7 @@ bool kgd_gfx_v9_hqd_is_occupied(struct
> > > > > > > kgd_dev
> > > > > > *kgd, uint64_t queue_address,
> > > > > > >  	bool retval = false;
> > > > > > >  	uint32_t low, high;
> > > > > > >
> > > > > > > +	amdgpu_gfx_rlc_enter_safe_mode(adev);
> > > > > > >  	acquire_queue(kgd, pipe_id, queue_id);
> > > > > > >  	act = RREG32(SOC15_REG_OFFSET(GC, 0,
> mmCP_HQD_ACTIVE));
> > > > > > >  	if (act) {
> > > > > > > @@ -508,6 +511,7 @@ bool kgd_gfx_v9_hqd_is_occupied(struct
> > > > > > > kgd_dev
> > > > > > *kgd, uint64_t queue_address,
> > > > > > >  			retval = true;
> > > > > > >  	}
> > > > > > >  	release_queue(kgd);
> > > > > > > +	amdgpu_gfx_rlc_exit_safe_mode(adev);
> > > > > > >  	return retval;
> > > > > > >  }
> > > > > > >
> > > > > > > @@ -541,6 +545,7 @@ int kgd_gfx_v9_hqd_destroy(struct
> > > > > > > kgd_dev *kgd,
> > > > > > void *mqd,
> > > > > > >  	uint32_t temp;
> > > > > > >  	struct v9_mqd *m = get_mqd(mqd);
> > > > > > >
> > > > > > > +	amdgpu_gfx_rlc_enter_safe_mode(adev);
> > > > > > >  	if (adev->in_gpu_reset)
> > > > > > >  		return -EIO;
> > > > > > >
> > > > > > > @@ -577,6 +582,7 @@ int kgd_gfx_v9_hqd_destroy(struct
> > > > > > > kgd_dev *kgd,
> > > > > > void *mqd,
> > > > > > >  	}
> > > > > > >
> > > > > > >  	release_queue(kgd);
> > > > > > > +	amdgpu_gfx_rlc_exit_safe_mode(adev);
> > > > > > >  	return 0;
> > > > > > >  }
> > > > > > >
> > > > > > > diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> > > > > > > b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> > > > > > > index 1fea077..ee107d9 100644
> > > > > > > --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> > > > > > > +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> > > > > > > @@ -3533,6 +3533,7 @@ static int
> > > > > > > gfx_v9_0_kiq_init_register(struct
> > > > > > amdgpu_ring *ring)
> > > > > > >  	struct v9_mqd *mqd = ring->mqd_ptr;
> > > > > > >  	int j;
> > > > > > >
> > > > > > > +	amdgpu_gfx_rlc_enter_safe_mode(adev);
> > > > > > >  	/* disable wptr polling */
> > > > > > >  	WREG32_FIELD15(GC, 0, CP_PQ_WPTR_POLL_CNTL, EN, 0);
> > > > > > >
> > > > > > > @@ -3629,6 +3630,7 @@ static int
> > > > > > > gfx_v9_0_kiq_init_register(struct
> > > > > > amdgpu_ring *ring)
> > > > > > >  	if (ring->use_doorbell)
> > > > > > >  		WREG32_FIELD15(GC, 0, CP_PQ_STATUS,
> DOORBELL_ENABLE,
> > > > > > 1);
> > > > > > >
> > > > > > > +	amdgpu_gfx_rlc_exit_safe_mode(adev);
> > > > > > >  	return 0;
> > > > > > >  }
> > > > > > >
> > > > > > > @@ -3637,6 +3639,7 @@ static int
> > > > > > > gfx_v9_0_kiq_fini_register(struct
> > > > > > amdgpu_ring *ring)
> > > > > > >  	struct amdgpu_device *adev = ring->adev;
> > > > > > >  	int j;
> > > > > > >
> > > > > > > +	amdgpu_gfx_rlc_enter_safe_mode(adev);
> > > > > > >  	/* disable the queue if it's active */
> > > > > > >  	if (RREG32_SOC15(GC, 0, mmCP_HQD_ACTIVE) & 1) {
> > > > > > >
> > > > > > > @@ -3668,6 +3671,7 @@ static int
> > > > > > > gfx_v9_0_kiq_fini_register(struct
> > > > > > amdgpu_ring *ring)
> > > > > > >  	WREG32_SOC15_RLC(GC, 0, mmCP_HQD_PQ_WPTR_HI, 0);
> > > > > > >  	WREG32_SOC15_RLC(GC, 0, mmCP_HQD_PQ_WPTR_LO, 0);
> > > > > > >
> > > > > > > +	amdgpu_gfx_rlc_exit_safe_mode(adev);
> > > > > > >  	return 0;
> > > > > > >  }
> > > > > > >
> > > > > > > --
> > > > > > > 2.7.4
> > > > > > >
> > > > _______________________________________________
> > > > amd-gfx mailing list
> > > > amd-gfx@lists.freedesktop.org
> > > > https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2F
> > > > list
> > > > s.freedesktop.org%2Fmailman%2Flistinfo%2Famd-
> > > gfx&amp;data=02%7C01%7Cra
> > > >
> > >
> y.huang%40amd.com%7C040563ff26374383ec6108d7d7b6a2bb%7C3dd8961
> > > fe4884e6
> > > >
> > >
> 08e11a82d994e183d%7C0%7C0%7C637215053543776633&amp;sdata=COMv
> > > G7W4%2Fl7
> > > > aKDAV8Qgbl%2F3myW0HCSz7qk014OLUzrY%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
