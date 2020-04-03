Return-Path: <SRS0=u9ZA=5T=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FUZZY_PRICES,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30009C43331
	for <amd-gfx@archiver.kernel.org>; Fri,  3 Apr 2020 10:06:10 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B4D29208E4
	for <amd-gfx@archiver.kernel.org>; Fri,  3 Apr 2020 10:06:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="LuQ1OJIJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B4D29208E4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 804806EB5B;
	Fri,  3 Apr 2020 10:06:09 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2057.outbound.protection.outlook.com [40.107.243.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7DD3A6EB5B
 for <amd-gfx@lists.freedesktop.org>; Fri,  3 Apr 2020 10:06:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EQCTj7+rx0Dr1cBVF5NlkWrmnLXnUE7QLHDwl4zDTselUpIf8brk2uDOhy7mb6T/1YhsWWZjs4aa+2um6p1BCneXwheTKeSKDO1Tuzl4dlAG6Boq4TPcmSA82QbLcrww4WBumOMegeS0UbRDgpnoSJ7gQyBR+WvdrFkGLjkVkcFbg1SdkwWVKjc2DcDo/GXKH06/Qph/nUUb1BRLDHyxTHd1MpcPW/8HEuGaOCrXLhO5xKajQnjUcCQl8FH24rbEmStbtjXMdukXoOI5zuqRvGJkYBFshLSbOdkK6JWhM+Cn27Lgu7iAdnr3DuSvI4RercqsHlel2s/77UvBZILZHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tsbPHVl6W7grBU04FOlPXPHcptRr25IuxFOW2tUvVlw=;
 b=Ge2Hy2ZE7hJnHRm0jHkMMG8Lvk+frB4peeHn30jTn5CJgqGbWKnRlcemgSmHt1A0VlutDsrh4TfKCI48lU9wPHK0MPmQKUGwTuITB2fo+CBGYR8kcCxto6yV8D2Gj/Rc2ihJivDxUVbo3SNs1MwhmYqoqNu6KjAOnbs+4QzT/J5pOsx2amd50sb6JN7jncSFla8gsSr8vuiB8ZmIp4RclXbrTrPyDN3gIIjCPbqiRnY2wyf9Z0Eeu/7W/qr/CaMS4NscS2qm3Kq5qaa3EGArsFJPtRYKqEinRXRiJLE2QK+p02/554argpJITvv+pGP6QHMHG6lUIeckHMGEzr487g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tsbPHVl6W7grBU04FOlPXPHcptRr25IuxFOW2tUvVlw=;
 b=LuQ1OJIJpebu/zO/0pMg509xgs+CCWZw/BWHg2bkOBRyjWRx6XkwPfWeROB0rO6nonqnr5K/YVFJ00VtwdXa0pp7xKutVFU2fG1UcCXzJNu12sTXT7DAaJHb8tntAI8RqlPJAMwoDdR6ESanwn+gWEOtKwG4MO9S556B1S5cUN4=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Ray.Huang@amd.com; 
Received: from MN2PR12MB3309.namprd12.prod.outlook.com (2603:10b6:208:106::29)
 by MN2PR12MB4144.namprd12.prod.outlook.com (2603:10b6:208:15f::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2878.16; Fri, 3 Apr
 2020 10:06:06 +0000
Received: from MN2PR12MB3309.namprd12.prod.outlook.com
 ([fe80::6417:7247:12ed:1d7b]) by MN2PR12MB3309.namprd12.prod.outlook.com
 ([fe80::6417:7247:12ed:1d7b%5]) with mapi id 15.20.2856.019; Fri, 3 Apr 2020
 10:06:06 +0000
Date: Fri, 3 Apr 2020 18:05:55 +0800
From: Huang Rui <ray.huang@amd.com>
To: "Liang, Prike" <Prike.Liang@amd.com>
Subject: Re: [PATCH] drm/amdgpu: fix gfx hang during suspend with video
 playback
Message-ID: <20200403100554.GA9721@jenkins-Celadon-RN>
References: <1585886873-22825-1-git-send-email-Prike.Liang@amd.com>
 <20200403062642.GA9191@jenkins-Celadon-RN>
 <MN2PR12MB3536631520E378DE4DAACCAAFBC70@MN2PR12MB3536.namprd12.prod.outlook.com>
Content-Disposition: inline
In-Reply-To: <MN2PR12MB3536631520E378DE4DAACCAAFBC70@MN2PR12MB3536.namprd12.prod.outlook.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: HK2PR04CA0063.apcprd04.prod.outlook.com
 (2603:1096:202:14::31) To MN2PR12MB3309.namprd12.prod.outlook.com
 (2603:10b6:208:106::29)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from jenkins-Celadon-RN (180.167.199.189) by
 HK2PR04CA0063.apcprd04.prod.outlook.com (2603:1096:202:14::31) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2878.15 via Frontend Transport; Fri, 3 Apr 2020 10:06:03 +0000
X-Originating-IP: [180.167.199.189]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: c94cac5e-17c7-4841-1735-08d7d7b69f47
X-MS-TrafficTypeDiagnostic: MN2PR12MB4144:|MN2PR12MB4144:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB414435C7D55C3D9288D9BE26ECC70@MN2PR12MB4144.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-Forefront-PRVS: 0362BF9FDB
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB3309.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10009020)(4636009)(39850400004)(396003)(366004)(136003)(346002)(376002)(186003)(8936002)(1076003)(9686003)(956004)(6636002)(66946007)(66556008)(33656002)(52116002)(66476007)(81156014)(55016002)(6496006)(53546011)(15650500001)(8676002)(81166006)(86362001)(54906003)(316002)(5660300002)(6666004)(2906002)(16526019)(26005)(33716001)(478600001)(6862004)(4326008);
 DIR:OUT; SFP:1101; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LKZVPc3YvZivby89Wtyb2bbjdyUyrG25WLimqC5KjXTDwQfHv/MTDWF5cEUdJ7g5P8NigKtg79AH1mxwO4BmUaT2q2iI/wbZSoGzLVUiKTfzwDn7f0i5IdV9BHxYgaV4Zjflo2NOxvIK5IuUdInFo6xe1r1/iR1HnMwbigEvDiZ4rEUxz6PkTmiZc35GTEQGfLLoZWBn54KLOTedtiv/pmdSVjLAiKInpBqgA+t5Hj1Jaci46NqG/txxNfqyhLZcIBAh4Ws8qXGzyP5lNDx6qU5EwVZ6yp6D3jc0m3A8CY4RSUehA+0lk5F2qmrKgL4h0drpBTpXyEaWlglghEvXMyjT06IufbCPZ78oCpQnIHAXm28nv/1XiCnU42w4/I4AEvpUSGmBR07W7onC1iZOvIXtO25HR2Tv6SSnZ0A58erxQuDnj29yszVZArNKoFRW
X-MS-Exchange-AntiSpam-MessageData: +DJ0011OUhvPwi2qAFUnqbyt76VLbzAfDrq3iF0hcjQwHbWXX3+An3+VlD+4nCmer8VtIt5FdlEcgH7mYVGNYOI/c/ybfZBYOsI6z6f+Q8dCatiuULGItDsb6u7yUSzl8QyuHd8BzlUrIKVnnm5WAw==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c94cac5e-17c7-4841-1735-08d7d7b69f47
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Apr 2020 10:06:05.4089 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: X5KcgXklE+IqyuxjZfAvQopg6sBWV1LC/j++iNYthG/l9yT1cCUBPS2XD58OlC7vp8P6pEqaZ6zvBZZBOX8yPg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4144
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

On Fri, Apr 03, 2020 at 05:22:28PM +0800, Liang, Prike wrote:
> 
> > -----Original Message-----
> > From: Huang, Ray <Ray.Huang@amd.com>
> > Sent: Friday, April 3, 2020 2:27 PM
> > To: Liang, Prike <Prike.Liang@amd.com>
> > Cc: amd-gfx@lists.freedesktop.org; Quan, Evan <Evan.Quan@amd.com>;
> > Deucher, Alexander <Alexander.Deucher@amd.com>; Kuehling, Felix
> > <Felix.Kuehling@amd.com>
> > Subject: Re: [PATCH] drm/amdgpu: fix gfx hang during suspend with video
> > playback
> > 
> > (+ Felix)
> > 
> > On Fri, Apr 03, 2020 at 12:07:53PM +0800, Liang, Prike wrote:
> > > The system will be hang up during S3 as SMU is pending at GC not
> > > respose the register CP_HQD_ACTIVE access request and this issue can
> > > be fixed by adding RLC safe mode guard before each HQD map/unmap
> > > retrive opt.
> > 
> > We need more information for the issue, does the map/unmap is required
> > for MAP_QUEUES/UNMAP_QUEUES packets or writing with MMIO or both?
> > 
> [Prike]  The issue hang up at MP1 was trying to read register RSMU_RESIDENCY_COUNTER_GC 
> but did not get response from GFX, since GFX was busy at reading register CP_HQD_ACTIVE.
> Moreover, when disabled GFXOFF this issue also can't see so there is likely to perform 
> register accessed at GFXOFF CGPG/CGCG enter stage.  As for only  this issue, that seems just 
> MMIO  access failed case which occurred under QUEUE map/unmap status check. 
> 

While we start to do S3, we will disable gfxoff at start of suspend. Then
in this point, the gfx should be always in "on" state. 

> > From your patch, you just protect the kernel kiq and user queue. What about
> > other kernel compute queues? HIQ?
> > 
> [Prike] So far just find the KIQ/CPQ/DIQ map/unmap will inquire the CP_HQD_ACTIVE status by MMIO accessing,
> therefore just guard the KIQ  and some type user queue now. Regarding HIQ map and ummap which used the method of submitting configuration packet.  
> 

KIQ itself init/unit should be always under gfx on state. Can you give a
check the result if not add enter/exit rlc safe mode around it?

Hi Felix, maybe we need to use packets with kiq to map all user queues.

Thanks,
Ray

> > Thanks,
> > Ray
> > 
> > >
> > > Signed-off-by: Prike Liang <Prike.Liang@amd.com>
> > > Tested-by: Mengbing Wang <Mengbing.Wang@amd.com>
> > > ---
> > >  drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c | 6 ++++++
> > >  drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c             | 4 ++++
> > >  2 files changed, 10 insertions(+)
> > >
> > > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
> > > b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
> > > index df841c2..e265063 100644
> > > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
> > > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
> > > @@ -232,6 +232,7 @@ int kgd_gfx_v9_hqd_load(struct kgd_dev *kgd, void
> > *mqd, uint32_t pipe_id,
> > >  	uint32_t *mqd_hqd;
> > >  	uint32_t reg, hqd_base, data;
> > >
> > > +	amdgpu_gfx_rlc_enter_safe_mode(adev);
> > >  	m = get_mqd(mqd);
> > >
> > >  	acquire_queue(kgd, pipe_id, queue_id); @@ -299,6 +300,7 @@ int
> > > kgd_gfx_v9_hqd_load(struct kgd_dev *kgd, void *mqd, uint32_t pipe_id,
> > >
> > >  	release_queue(kgd);
> > >
> > > +	amdgpu_gfx_rlc_exit_safe_mode(adev);
> > >  	return 0;
> > >  }
> > >
> > > @@ -497,6 +499,7 @@ bool kgd_gfx_v9_hqd_is_occupied(struct kgd_dev
> > *kgd, uint64_t queue_address,
> > >  	bool retval = false;
> > >  	uint32_t low, high;
> > >
> > > +	amdgpu_gfx_rlc_enter_safe_mode(adev);
> > >  	acquire_queue(kgd, pipe_id, queue_id);
> > >  	act = RREG32(SOC15_REG_OFFSET(GC, 0, mmCP_HQD_ACTIVE));
> > >  	if (act) {
> > > @@ -508,6 +511,7 @@ bool kgd_gfx_v9_hqd_is_occupied(struct kgd_dev
> > *kgd, uint64_t queue_address,
> > >  			retval = true;
> > >  	}
> > >  	release_queue(kgd);
> > > +	amdgpu_gfx_rlc_exit_safe_mode(adev);
> > >  	return retval;
> > >  }
> > >
> > > @@ -541,6 +545,7 @@ int kgd_gfx_v9_hqd_destroy(struct kgd_dev *kgd,
> > void *mqd,
> > >  	uint32_t temp;
> > >  	struct v9_mqd *m = get_mqd(mqd);
> > >
> > > +	amdgpu_gfx_rlc_enter_safe_mode(adev);
> > >  	if (adev->in_gpu_reset)
> > >  		return -EIO;
> > >
> > > @@ -577,6 +582,7 @@ int kgd_gfx_v9_hqd_destroy(struct kgd_dev *kgd,
> > void *mqd,
> > >  	}
> > >
> > >  	release_queue(kgd);
> > > +	amdgpu_gfx_rlc_exit_safe_mode(adev);
> > >  	return 0;
> > >  }
> > >
> > > diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> > > b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> > > index 1fea077..ee107d9 100644
> > > --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> > > +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> > > @@ -3533,6 +3533,7 @@ static int gfx_v9_0_kiq_init_register(struct
> > amdgpu_ring *ring)
> > >  	struct v9_mqd *mqd = ring->mqd_ptr;
> > >  	int j;
> > >
> > > +	amdgpu_gfx_rlc_enter_safe_mode(adev);
> > >  	/* disable wptr polling */
> > >  	WREG32_FIELD15(GC, 0, CP_PQ_WPTR_POLL_CNTL, EN, 0);
> > >
> > > @@ -3629,6 +3630,7 @@ static int gfx_v9_0_kiq_init_register(struct
> > amdgpu_ring *ring)
> > >  	if (ring->use_doorbell)
> > >  		WREG32_FIELD15(GC, 0, CP_PQ_STATUS, DOORBELL_ENABLE,
> > 1);
> > >
> > > +	amdgpu_gfx_rlc_exit_safe_mode(adev);
> > >  	return 0;
> > >  }
> > >
> > > @@ -3637,6 +3639,7 @@ static int gfx_v9_0_kiq_fini_register(struct
> > amdgpu_ring *ring)
> > >  	struct amdgpu_device *adev = ring->adev;
> > >  	int j;
> > >
> > > +	amdgpu_gfx_rlc_enter_safe_mode(adev);
> > >  	/* disable the queue if it's active */
> > >  	if (RREG32_SOC15(GC, 0, mmCP_HQD_ACTIVE) & 1) {
> > >
> > > @@ -3668,6 +3671,7 @@ static int gfx_v9_0_kiq_fini_register(struct
> > amdgpu_ring *ring)
> > >  	WREG32_SOC15_RLC(GC, 0, mmCP_HQD_PQ_WPTR_HI, 0);
> > >  	WREG32_SOC15_RLC(GC, 0, mmCP_HQD_PQ_WPTR_LO, 0);
> > >
> > > +	amdgpu_gfx_rlc_exit_safe_mode(adev);
> > >  	return 0;
> > >  }
> > >
> > > --
> > > 2.7.4
> > >
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
