Return-Path: <SRS0=Z8oe=5X=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FUZZY_PRICES,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 170A1C2BA16
	for <amd-gfx@archiver.kernel.org>; Tue,  7 Apr 2020 05:49:49 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DFD8120747
	for <amd-gfx@archiver.kernel.org>; Tue,  7 Apr 2020 05:49:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="Zs8x7VY1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DFD8120747
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3A95A6E2EF;
	Tue,  7 Apr 2020 05:49:48 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2085.outbound.protection.outlook.com [40.107.236.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 51FF06E2EF
 for <amd-gfx@lists.freedesktop.org>; Tue,  7 Apr 2020 05:49:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AxtVAdViBxcK5DnvLSSg8g4yHnNcswVudIfvFKY3CNqo2QK12h8HSosveOIIGiA8TnaeFWoLHHNOyzAuzcbD6drsZP4/z/moiA77gdv/Y/Muynpr2xboLEO4OTG7/6iSwF/ge/egFiDruLKYzA4tinWwFZO6WrUkjdXha4gHgY8KzqghOTUHqS0Ih6nDDVog2KUEDwEgE8ophv+ZPDSp4qViC8MbcKD57YM6mdtNPeTnrlvhbyMzejTh1WF9TRm+hyWkzs3K+OKNZGQ+r4QZVPb53Y7gNko1IV//reZlMLUhjQBAdPnmSqAxD6sVVTrlAEwrPU7R2h7wpjvum63dNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qc7siOtIaG8lYRiNh1kzS9lpbnuHNEfe05rlh8wilik=;
 b=JmJCbK8te2cy6H35JBrraqDgzcjDryGqd5HkYJ1GqYK4F6eDlpiu8DLDsEswb7tMmtGXrzf7iM5yTDdFk3ogitMPHK7pV8y5S2oA3xKwNqCLHO7yWpLHxWJAeuQJZKmvauccTsBvldWEBlHRuVFf12nA6Lgj4aT8x75ygp/QxeGMDKG2+zsxsRV/1k3EujWiNowDbABHKOOXOuS1DtQ3BBvuK/5M/mufXBr6a4jj5VaErCnt/r9TFkNQy/3UYFzgH8PGA7gHtT9t7Fd8X0Sn+/gmZqeIn+PTdAmMgC6qgoU2q454N3FXRnvfml4PHUeVW5iEqijtbDqjnvBQ931KFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qc7siOtIaG8lYRiNh1kzS9lpbnuHNEfe05rlh8wilik=;
 b=Zs8x7VY17OsQDvRvdumLa1CLsq6nwErEcYMDA8/4mFs9d8Q8o2fMwTRZFsVk9sB/0eISlDaTxRDiRextZw+od5Bj8Ll2WZFqXfIH+4q6GyXzxBo28nSj2Kn0TXCn7Viwm7KLRxkFW9Pi2rt+3MolUgPcT4KKRSeBn4R3kBOjvio=
Received: from MN2PR12MB3536.namprd12.prod.outlook.com (2603:10b6:208:104::19)
 by MN2PR12MB3183.namprd12.prod.outlook.com (2603:10b6:208:101::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2878.15; Tue, 7 Apr
 2020 05:49:44 +0000
Received: from MN2PR12MB3536.namprd12.prod.outlook.com
 ([fe80::424:4ce2:f779:d08b]) by MN2PR12MB3536.namprd12.prod.outlook.com
 ([fe80::424:4ce2:f779:d08b%4]) with mapi id 15.20.2878.022; Tue, 7 Apr 2020
 05:49:43 +0000
From: "Liang, Prike" <Prike.Liang@amd.com>
To: "Huang, Ray" <Ray.Huang@amd.com>
Subject: RE: [PATCH] drm/amdgpu: fix gfx hang during suspend with video
 playback
Thread-Topic: [PATCH] drm/amdgpu: fix gfx hang during suspend with video
 playback
Thread-Index: AQHWCW1+xKCgFizMkEyLyz6Szs7fQqhm7tUAgAAUzsCAAChvgIAABlOAgAXzQtA=
Date: Tue, 7 Apr 2020 05:49:43 +0000
Message-ID: <MN2PR12MB3536428C0B9FE390FC01C74CFBC30@MN2PR12MB3536.namprd12.prod.outlook.com>
References: <1585886873-22825-1-git-send-email-Prike.Liang@amd.com>
 <20200403062642.GA9191@jenkins-Celadon-RN>
 <MN2PR12MB3536631520E378DE4DAACCAAFBC70@MN2PR12MB3536.namprd12.prod.outlook.com>
 <20200403100554.GA9721@jenkins-Celadon-RN>
 <20200403102832.GB9721@jenkins-Celadon-RN>
In-Reply-To: <20200403102832.GB9721@jenkins-Celadon-RN>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=6db3746e-e942-4629-bd79-0000d6e98047;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Use Only - Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-04-07T05:20:31Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Prike.Liang@amd.com; 
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 501df3cd-04e9-4324-7d3a-08d7dab778f8
x-ms-traffictypediagnostic: MN2PR12MB3183:|MN2PR12MB3183:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB31830D272BA9A1F3F2047A71FBC30@MN2PR12MB3183.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 036614DD9C
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB3536.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10009020)(4636009)(376002)(396003)(39860400002)(366004)(346002)(136003)(55016002)(53546011)(2906002)(6862004)(7696005)(54906003)(8936002)(4326008)(8676002)(81166006)(966005)(86362001)(81156014)(316002)(66476007)(66556008)(15650500001)(66446008)(186003)(76116006)(71200400001)(6506007)(33656002)(45080400002)(66946007)(64756008)(478600001)(52536014)(26005)(5660300002)(6636002)(9686003);
 DIR:OUT; SFP:1101; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: FnPxAo+DBVBRGQ0vi5XIdA3rsscyoqa0Pc2kvzmwlXfRCNl/Fn1Y3d55hJvbug8wHtP2iblsbUHlxnBRctcsjlwWl25MKBznrv3B6ydYu5IKDkIQy0cfBHft7LHDpRDk1XcK72ulc2DmMGpNzXfPVyiT51wkHoh+fIwWyTJf9+1lKW1LL+pDXY1OHIulqedzNHKfHVKgDKpG0w3RmIBA7BQs0TV0ZqSklwi2r6EN5p5ysA+f/P2YGm7NHa9ETbyeK14Fgv8OFbZhJfMooBtHu3pQkS7J3sqmkx1mi53QwPofXSP8r5UiXWCTtGGLEtoyz4QGHXK5Rat6EignczoTqkETgiYbbBUYg3BIRJHAvOPS+PICid8XLg/Ls3UUBB8yXgKblWAulArlikmTMi5u7juwIdAgjwerC8bRvf+aGk4L0fFbwLYis5BXG7bvp8axgc6P6NfFEEO4jA4/BiRzc/p9LtQ9n+CB5Yazw7sQXrUfWZaYE4/cJCnGDAbq26TLF9yKlTDnKLBzcyp4hCsSMA==
x-ms-exchange-antispam-messagedata: UGBSt0tXt+0uzM8jV7LuoLrP5dOORqtpjgrw1TJSkCT+cc8uvskqVY7LE/xKiMp4rb6lemtQaYBYe8X+pasEVq+Mr8a3trxnh7miPGoDSgG8d+0QHrWqLdXl0dG9ES8x/j97yyyVUHcp2phkHzHd9w==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 501df3cd-04e9-4324-7d3a-08d7dab778f8
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Apr 2020 05:49:43.6797 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9n3bRQha7MuoxYTL3Ka5EDt51e1u2ye7L2cQqFbgX8P4WzMNbvi5q4c8IAdXviR8
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3183
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
> Sent: Friday, April 3, 2020 6:29 PM
> To: Liang, Prike <Prike.Liang@amd.com>
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Kuehling, Felix
> <Felix.Kuehling@amd.com>; Quan, Evan <Evan.Quan@amd.com>; amd-
> gfx@lists.freedesktop.org
> Subject: Re: [PATCH] drm/amdgpu: fix gfx hang during suspend with video
> playback
> 
> On Fri, Apr 03, 2020 at 06:05:55PM +0800, Huang Rui wrote:
> > On Fri, Apr 03, 2020 at 05:22:28PM +0800, Liang, Prike wrote:
> > >
> > > > -----Original Message-----
> > > > From: Huang, Ray <Ray.Huang@amd.com>
> > > > Sent: Friday, April 3, 2020 2:27 PM
> > > > To: Liang, Prike <Prike.Liang@amd.com>
> > > > Cc: amd-gfx@lists.freedesktop.org; Quan, Evan
> <Evan.Quan@amd.com>;
> > > > Deucher, Alexander <Alexander.Deucher@amd.com>; Kuehling, Felix
> > > > <Felix.Kuehling@amd.com>
> > > > Subject: Re: [PATCH] drm/amdgpu: fix gfx hang during suspend with
> > > > video playback
> > > >
> > > > (+ Felix)
> > > >
> > > > On Fri, Apr 03, 2020 at 12:07:53PM +0800, Liang, Prike wrote:
> > > > > The system will be hang up during S3 as SMU is pending at GC not
> > > > > respose the register CP_HQD_ACTIVE access request and this issue
> > > > > can be fixed by adding RLC safe mode guard before each HQD
> > > > > map/unmap retrive opt.
> > > >
> > > > We need more information for the issue, does the map/unmap is
> > > > required for MAP_QUEUES/UNMAP_QUEUES packets or writing with
> MMIO or both?
> > > >
> > > [Prike]  The issue hang up at MP1 was trying to read register
> > > RSMU_RESIDENCY_COUNTER_GC but did not get response from GFX,
> since GFX was busy at reading register CP_HQD_ACTIVE.
> > > Moreover, when disabled GFXOFF this issue also can't see so there is
> > > likely to perform register accessed at GFXOFF CGPG/CGCG enter stage.
> > > As for only  this issue, that seems just MMIO  access failed case which
> occurred under QUEUE map/unmap status check.
> > >
> >
> > While we start to do S3, we will disable gfxoff at start of suspend.
> > Then in this point, the gfx should be always in "on" state.
> >
> > > > From your patch, you just protect the kernel kiq and user queue.
> > > > What about other kernel compute queues? HIQ?
> > > >
> > > [Prike] So far just find the KIQ/CPQ/DIQ map/unmap will inquire the
> > > CP_HQD_ACTIVE status by MMIO accessing, therefore just guard the KIQ
> and some type user queue now. Regarding HIQ map and ummap which used
> the method of submitting configuration packet.
> > >
> >
> > KIQ itself init/unit should be always under gfx on state. Can you give
> > a check the result if not add enter/exit rlc safe mode around it?
> 
> Wait... In your case, the system didn't load any user queues because no
> ROCm based application is running. So the issue is probably caused by KIQ
> itself init/unit, can you confirm?
[Prike]  This  improper register access is under performing MQD destroy
during amdkfd suspend period. For the KIQ UNI process may not need the RLC
guard as GFX CGPG has been disabled at the early suspend period.  

If have concern the other case over guard will send a patch for simplify it.
> 
> Thanks,
> Ray
> 
> >
> > Hi Felix, maybe we need to use packets with kiq to map all user queues.
> >
> > Thanks,
> > Ray
> >
> > > > Thanks,
> > > > Ray
> > > >
> > > > >
> > > > > Signed-off-by: Prike Liang <Prike.Liang@amd.com>
> > > > > Tested-by: Mengbing Wang <Mengbing.Wang@amd.com>
> > > > > ---
> > > > >  drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c | 6
> ++++++
> > > > >  drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c             | 4 ++++
> > > > >  2 files changed, 10 insertions(+)
> > > > >
> > > > > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
> > > > > b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
> > > > > index df841c2..e265063 100644
> > > > > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
> > > > > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
> > > > > @@ -232,6 +232,7 @@ int kgd_gfx_v9_hqd_load(struct kgd_dev *kgd,
> > > > > void
> > > > *mqd, uint32_t pipe_id,
> > > > >  	uint32_t *mqd_hqd;
> > > > >  	uint32_t reg, hqd_base, data;
> > > > >
> > > > > +	amdgpu_gfx_rlc_enter_safe_mode(adev);
> > > > >  	m = get_mqd(mqd);
> > > > >
> > > > >  	acquire_queue(kgd, pipe_id, queue_id); @@ -299,6 +300,7 @@ int
> > > > > kgd_gfx_v9_hqd_load(struct kgd_dev *kgd, void *mqd, uint32_t
> > > > > pipe_id,
> > > > >
> > > > >  	release_queue(kgd);
> > > > >
> > > > > +	amdgpu_gfx_rlc_exit_safe_mode(adev);
> > > > >  	return 0;
> > > > >  }
> > > > >
> > > > > @@ -497,6 +499,7 @@ bool kgd_gfx_v9_hqd_is_occupied(struct
> > > > > kgd_dev
> > > > *kgd, uint64_t queue_address,
> > > > >  	bool retval = false;
> > > > >  	uint32_t low, high;
> > > > >
> > > > > +	amdgpu_gfx_rlc_enter_safe_mode(adev);
> > > > >  	acquire_queue(kgd, pipe_id, queue_id);
> > > > >  	act = RREG32(SOC15_REG_OFFSET(GC, 0, mmCP_HQD_ACTIVE));
> > > > >  	if (act) {
> > > > > @@ -508,6 +511,7 @@ bool kgd_gfx_v9_hqd_is_occupied(struct
> > > > > kgd_dev
> > > > *kgd, uint64_t queue_address,
> > > > >  			retval = true;
> > > > >  	}
> > > > >  	release_queue(kgd);
> > > > > +	amdgpu_gfx_rlc_exit_safe_mode(adev);
> > > > >  	return retval;
> > > > >  }
> > > > >
> > > > > @@ -541,6 +545,7 @@ int kgd_gfx_v9_hqd_destroy(struct kgd_dev
> > > > > *kgd,
> > > > void *mqd,
> > > > >  	uint32_t temp;
> > > > >  	struct v9_mqd *m = get_mqd(mqd);
> > > > >
> > > > > +	amdgpu_gfx_rlc_enter_safe_mode(adev);
> > > > >  	if (adev->in_gpu_reset)
> > > > >  		return -EIO;
> > > > >
> > > > > @@ -577,6 +582,7 @@ int kgd_gfx_v9_hqd_destroy(struct kgd_dev
> > > > > *kgd,
> > > > void *mqd,
> > > > >  	}
> > > > >
> > > > >  	release_queue(kgd);
> > > > > +	amdgpu_gfx_rlc_exit_safe_mode(adev);
> > > > >  	return 0;
> > > > >  }
> > > > >
> > > > > diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> > > > > b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> > > > > index 1fea077..ee107d9 100644
> > > > > --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> > > > > +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> > > > > @@ -3533,6 +3533,7 @@ static int
> > > > > gfx_v9_0_kiq_init_register(struct
> > > > amdgpu_ring *ring)
> > > > >  	struct v9_mqd *mqd = ring->mqd_ptr;
> > > > >  	int j;
> > > > >
> > > > > +	amdgpu_gfx_rlc_enter_safe_mode(adev);
> > > > >  	/* disable wptr polling */
> > > > >  	WREG32_FIELD15(GC, 0, CP_PQ_WPTR_POLL_CNTL, EN, 0);
> > > > >
> > > > > @@ -3629,6 +3630,7 @@ static int
> > > > > gfx_v9_0_kiq_init_register(struct
> > > > amdgpu_ring *ring)
> > > > >  	if (ring->use_doorbell)
> > > > >  		WREG32_FIELD15(GC, 0, CP_PQ_STATUS, DOORBELL_ENABLE,
> > > > 1);
> > > > >
> > > > > +	amdgpu_gfx_rlc_exit_safe_mode(adev);
> > > > >  	return 0;
> > > > >  }
> > > > >
> > > > > @@ -3637,6 +3639,7 @@ static int
> > > > > gfx_v9_0_kiq_fini_register(struct
> > > > amdgpu_ring *ring)
> > > > >  	struct amdgpu_device *adev = ring->adev;
> > > > >  	int j;
> > > > >
> > > > > +	amdgpu_gfx_rlc_enter_safe_mode(adev);
> > > > >  	/* disable the queue if it's active */
> > > > >  	if (RREG32_SOC15(GC, 0, mmCP_HQD_ACTIVE) & 1) {
> > > > >
> > > > > @@ -3668,6 +3671,7 @@ static int
> > > > > gfx_v9_0_kiq_fini_register(struct
> > > > amdgpu_ring *ring)
> > > > >  	WREG32_SOC15_RLC(GC, 0, mmCP_HQD_PQ_WPTR_HI, 0);
> > > > >  	WREG32_SOC15_RLC(GC, 0, mmCP_HQD_PQ_WPTR_LO, 0);
> > > > >
> > > > > +	amdgpu_gfx_rlc_exit_safe_mode(adev);
> > > > >  	return 0;
> > > > >  }
> > > > >
> > > > > --
> > > > > 2.7.4
> > > > >
> > _______________________________________________
> > amd-gfx mailing list
> > amd-gfx@lists.freedesktop.org
> > https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flist
> > s.freedesktop.org%2Fmailman%2Flistinfo%2Famd-
> gfx&amp;data=02%7C01%7Cra
> >
> y.huang%40amd.com%7C040563ff26374383ec6108d7d7b6a2bb%7C3dd8961
> fe4884e6
> >
> 08e11a82d994e183d%7C0%7C0%7C637215053543776633&amp;sdata=COMv
> G7W4%2Fl7
> > aKDAV8Qgbl%2F3myW0HCSz7qk014OLUzrY%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
