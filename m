Return-Path: <SRS0=u9ZA=5T=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FUZZY_PRICES,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22009C43331
	for <amd-gfx@archiver.kernel.org>; Fri,  3 Apr 2020 09:22:35 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DBE01206B8
	for <amd-gfx@archiver.kernel.org>; Fri,  3 Apr 2020 09:22:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="YH4GUZvq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DBE01206B8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ADDEB6EB42;
	Fri,  3 Apr 2020 09:22:34 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2076.outbound.protection.outlook.com [40.107.244.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 01A626EB42
 for <amd-gfx@lists.freedesktop.org>; Fri,  3 Apr 2020 09:22:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B6EZKmROgt1SHNou772P+ChU/Juv0l7NdfsmRdOvCmDAVYw/VJ0vO5jtfeBjgavGhfwoewqDRGb/PqLECGfIc1DdaQpXY022iypu1bJjljRU1RNtPheYBtXgjA5mBEoudpyT7jjBfERfPDJ5HRDc+Y6nP8z+w9+g5jxkjiqBNZ1MEIq2etzrveeg9+nY747r9EbzCOnmlqiZ67H+bVEzhWyzHtdUZXhkw63h7+Oh8tpNV5oktnINkINmIlhtabvZorjkc444UMLkjgLxT97EdHGkqCFeTaibfkiLccpCaGNzHzswqX0pLYenT1NoKM3FgTHkOFLYol0K/8sdO13dZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kP+UN/ya3lSza8KR8iFtGGbaxfXMQVV7iluzBh4CDA4=;
 b=Wmwv7J2FLg28UqCCpo4v03/N0uypocvf+OfBxlukVrkdgDzCBeGyyUO3laKf3CsZhI737GRmIl/mR6r3dzBe2BtLS+BV8EZ6Ugh5qq13dlynJuu7ssVmwd3H3bSkdgREKgxlYcy90F2386275Vm/o51UpzFO95Xf520zRg8IyyeobiiWQdw51n+qheK3RTA6NHwixCgbqiyWedTqmo8y6pYOND9ruK74hVXvC0h3FgVrQZwGrly8A0a1LL2spB12bEaehMaWyZUlXo1sSmuwzFiXjWTocGVgqOAU17UlbiLxV++Ul9KQ3S5qxvbwLm1w15ktbsFntPQHtLKBORLUPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kP+UN/ya3lSza8KR8iFtGGbaxfXMQVV7iluzBh4CDA4=;
 b=YH4GUZvqgF/H5uKS685SrA9ixD5xNL8z/QO/m04HUKHiRGZGJBR3knzeET3/rPV72tGRgZZa9JrTDIYX4ex1BWNUv1O8z0vtpMm7cIN0+euUPi25hG7PjpVYo5ZbmA0QOTDXCKY54feFMNIRwFyj0/Vxf3r/0wPcEi95LlmHpaM=
Received: from MN2PR12MB3536.namprd12.prod.outlook.com (2603:10b6:208:104::19)
 by MN2PR12MB3310.namprd12.prod.outlook.com (2603:10b6:208:aa::25)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2878.19; Fri, 3 Apr
 2020 09:22:28 +0000
Received: from MN2PR12MB3536.namprd12.prod.outlook.com
 ([fe80::424:4ce2:f779:d08b]) by MN2PR12MB3536.namprd12.prod.outlook.com
 ([fe80::424:4ce2:f779:d08b%4]) with mapi id 15.20.2878.014; Fri, 3 Apr 2020
 09:22:28 +0000
From: "Liang, Prike" <Prike.Liang@amd.com>
To: "Huang, Ray" <Ray.Huang@amd.com>
Subject: RE: [PATCH] drm/amdgpu: fix gfx hang during suspend with video
 playback
Thread-Topic: [PATCH] drm/amdgpu: fix gfx hang during suspend with video
 playback
Thread-Index: AQHWCW1+xKCgFizMkEyLyz6Szs7fQqhm7tUAgAAUzsA=
Date: Fri, 3 Apr 2020 09:22:28 +0000
Message-ID: <MN2PR12MB3536631520E378DE4DAACCAAFBC70@MN2PR12MB3536.namprd12.prod.outlook.com>
References: <1585886873-22825-1-git-send-email-Prike.Liang@amd.com>
 <20200403062642.GA9191@jenkins-Celadon-RN>
In-Reply-To: <20200403062642.GA9191@jenkins-Celadon-RN>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=ad955b78-82a0-48d8-8f92-00009cd31be6;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Use Only - Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-04-03T07:41:13Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Prike.Liang@amd.com; 
x-originating-ip: [139.226.16.52]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 756879ce-9d0c-4081-9672-08d7d7b0879c
x-ms-traffictypediagnostic: MN2PR12MB3310:|MN2PR12MB3310:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB33104F73A5D0C142DA3F473DFBC70@MN2PR12MB3310.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 0362BF9FDB
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB3536.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10009020)(4636009)(366004)(346002)(136003)(376002)(39860400002)(396003)(6862004)(53546011)(6506007)(52536014)(66946007)(54906003)(478600001)(86362001)(2906002)(6636002)(66476007)(7696005)(66556008)(64756008)(66446008)(316002)(76116006)(55016002)(26005)(81166006)(5660300002)(4326008)(9686003)(15650500001)(71200400001)(186003)(8936002)(33656002)(8676002)(81156014);
 DIR:OUT; SFP:1101; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: zE3YSsb/3vhH2xm+53hkddLSqIZmNFZygVB8svIJU01ccZ7Ll61YNH4mmGfeZzf/FA9p9tRrAOzBX87UqmBcbjP4fJlXMqiDp10YpeVvJWeNingmijpu8wwsZ3Gr+mkOZzSj3cZC9V98qhwZl7ayEzKRq40Mml2JOCYON3F+H0jYc2VlRd7KXD2SbUzhvoooVgEe3oukHdBfon7bwftLzcPUQ5RK1tYHiFDJY0GozKq9p3LeOxTM+3RjgvVWPmm1Kt4LygMHtFBZ8qz84QNhbMCntIAxJ5ABya2y05Nm0AwfP2oThfS2g100ZQs2STwRQ+Yx53WN9Pci1pYE5cC0Ao+VoQAveaxmreLB2eorYmDbEVlVKH4jw5rbjiJQQx+ELGS/NvJWsGwMqJgAwbslDgYphDS5fu/giKTo1zA3v1gZ2KHbVhYU0w9UV6fMICTg
x-ms-exchange-antispam-messagedata: 8rPOPBJ/gvAFGcc0TLR2nD474Adm+vPpXgl6P8uQfcgszyTkClYsrFRLwwoSszMtllSVDdwxgyCt2s6FadtVHpK+Xz/neOYvmR3oehHyeWd4xOzbTgtVl1Yy5dN8VUAz2eq7VR/jJyJ+niiq0chIUQ==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 756879ce-9d0c-4081-9672-08d7d7b0879c
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Apr 2020 09:22:28.3947 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xE46XxgUNCH5PtcuYyqfdsO2olDS/S7EjF6TY6XxSRqmKtQCrRgR/SWRTbHdpLW4
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3310
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
> Sent: Friday, April 3, 2020 2:27 PM
> To: Liang, Prike <Prike.Liang@amd.com>
> Cc: amd-gfx@lists.freedesktop.org; Quan, Evan <Evan.Quan@amd.com>;
> Deucher, Alexander <Alexander.Deucher@amd.com>; Kuehling, Felix
> <Felix.Kuehling@amd.com>
> Subject: Re: [PATCH] drm/amdgpu: fix gfx hang during suspend with video
> playback
> 
> (+ Felix)
> 
> On Fri, Apr 03, 2020 at 12:07:53PM +0800, Liang, Prike wrote:
> > The system will be hang up during S3 as SMU is pending at GC not
> > respose the register CP_HQD_ACTIVE access request and this issue can
> > be fixed by adding RLC safe mode guard before each HQD map/unmap
> > retrive opt.
> 
> We need more information for the issue, does the map/unmap is required
> for MAP_QUEUES/UNMAP_QUEUES packets or writing with MMIO or both?
> 
[Prike]  The issue hang up at MP1 was trying to read register RSMU_RESIDENCY_COUNTER_GC 
but did not get response from GFX, since GFX was busy at reading register CP_HQD_ACTIVE.
Moreover, when disabled GFXOFF this issue also can't see so there is likely to perform 
register accessed at GFXOFF CGPG/CGCG enter stage.  As for only  this issue, that seems just 
MMIO  access failed case which occurred under QUEUE map/unmap status check. 

> From your patch, you just protect the kernel kiq and user queue. What about
> other kernel compute queues? HIQ?
> 
[Prike] So far just find the KIQ/CPQ/DIQ map/unmap will inquire the CP_HQD_ACTIVE status by MMIO accessing,
therefore just guard the KIQ  and some type user queue now. Regarding HIQ map and ummap which used the method of submitting configuration packet.  

> Thanks,
> Ray
> 
> >
> > Signed-off-by: Prike Liang <Prike.Liang@amd.com>
> > Tested-by: Mengbing Wang <Mengbing.Wang@amd.com>
> > ---
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c | 6 ++++++
> >  drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c             | 4 ++++
> >  2 files changed, 10 insertions(+)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
> > b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
> > index df841c2..e265063 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
> > @@ -232,6 +232,7 @@ int kgd_gfx_v9_hqd_load(struct kgd_dev *kgd, void
> *mqd, uint32_t pipe_id,
> >  	uint32_t *mqd_hqd;
> >  	uint32_t reg, hqd_base, data;
> >
> > +	amdgpu_gfx_rlc_enter_safe_mode(adev);
> >  	m = get_mqd(mqd);
> >
> >  	acquire_queue(kgd, pipe_id, queue_id); @@ -299,6 +300,7 @@ int
> > kgd_gfx_v9_hqd_load(struct kgd_dev *kgd, void *mqd, uint32_t pipe_id,
> >
> >  	release_queue(kgd);
> >
> > +	amdgpu_gfx_rlc_exit_safe_mode(adev);
> >  	return 0;
> >  }
> >
> > @@ -497,6 +499,7 @@ bool kgd_gfx_v9_hqd_is_occupied(struct kgd_dev
> *kgd, uint64_t queue_address,
> >  	bool retval = false;
> >  	uint32_t low, high;
> >
> > +	amdgpu_gfx_rlc_enter_safe_mode(adev);
> >  	acquire_queue(kgd, pipe_id, queue_id);
> >  	act = RREG32(SOC15_REG_OFFSET(GC, 0, mmCP_HQD_ACTIVE));
> >  	if (act) {
> > @@ -508,6 +511,7 @@ bool kgd_gfx_v9_hqd_is_occupied(struct kgd_dev
> *kgd, uint64_t queue_address,
> >  			retval = true;
> >  	}
> >  	release_queue(kgd);
> > +	amdgpu_gfx_rlc_exit_safe_mode(adev);
> >  	return retval;
> >  }
> >
> > @@ -541,6 +545,7 @@ int kgd_gfx_v9_hqd_destroy(struct kgd_dev *kgd,
> void *mqd,
> >  	uint32_t temp;
> >  	struct v9_mqd *m = get_mqd(mqd);
> >
> > +	amdgpu_gfx_rlc_enter_safe_mode(adev);
> >  	if (adev->in_gpu_reset)
> >  		return -EIO;
> >
> > @@ -577,6 +582,7 @@ int kgd_gfx_v9_hqd_destroy(struct kgd_dev *kgd,
> void *mqd,
> >  	}
> >
> >  	release_queue(kgd);
> > +	amdgpu_gfx_rlc_exit_safe_mode(adev);
> >  	return 0;
> >  }
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> > b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> > index 1fea077..ee107d9 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> > @@ -3533,6 +3533,7 @@ static int gfx_v9_0_kiq_init_register(struct
> amdgpu_ring *ring)
> >  	struct v9_mqd *mqd = ring->mqd_ptr;
> >  	int j;
> >
> > +	amdgpu_gfx_rlc_enter_safe_mode(adev);
> >  	/* disable wptr polling */
> >  	WREG32_FIELD15(GC, 0, CP_PQ_WPTR_POLL_CNTL, EN, 0);
> >
> > @@ -3629,6 +3630,7 @@ static int gfx_v9_0_kiq_init_register(struct
> amdgpu_ring *ring)
> >  	if (ring->use_doorbell)
> >  		WREG32_FIELD15(GC, 0, CP_PQ_STATUS, DOORBELL_ENABLE,
> 1);
> >
> > +	amdgpu_gfx_rlc_exit_safe_mode(adev);
> >  	return 0;
> >  }
> >
> > @@ -3637,6 +3639,7 @@ static int gfx_v9_0_kiq_fini_register(struct
> amdgpu_ring *ring)
> >  	struct amdgpu_device *adev = ring->adev;
> >  	int j;
> >
> > +	amdgpu_gfx_rlc_enter_safe_mode(adev);
> >  	/* disable the queue if it's active */
> >  	if (RREG32_SOC15(GC, 0, mmCP_HQD_ACTIVE) & 1) {
> >
> > @@ -3668,6 +3671,7 @@ static int gfx_v9_0_kiq_fini_register(struct
> amdgpu_ring *ring)
> >  	WREG32_SOC15_RLC(GC, 0, mmCP_HQD_PQ_WPTR_HI, 0);
> >  	WREG32_SOC15_RLC(GC, 0, mmCP_HQD_PQ_WPTR_LO, 0);
> >
> > +	amdgpu_gfx_rlc_exit_safe_mode(adev);
> >  	return 0;
> >  }
> >
> > --
> > 2.7.4
> >
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
