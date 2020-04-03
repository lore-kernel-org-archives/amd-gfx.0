Return-Path: <SRS0=u9ZA=5T=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FUZZY_PRICES,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40CEDC2D0E8
	for <amd-gfx@archiver.kernel.org>; Fri,  3 Apr 2020 10:28:47 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0F49C2073B
	for <amd-gfx@archiver.kernel.org>; Fri,  3 Apr 2020 10:28:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="Mimbx1HF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F49C2073B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C59086EB65;
	Fri,  3 Apr 2020 10:28:46 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2070.outbound.protection.outlook.com [40.107.236.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 918806EB65
 for <amd-gfx@lists.freedesktop.org>; Fri,  3 Apr 2020 10:28:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nn25j3ifC5VT4hbwWcSKKW/w+KYgC/+kW01HtZFqiU9Klto/RPYUvFHtsmVMDB/kgDQd+h+Al0/7lNFjdadWQMtuA8ZuKfaL8IiLPRDELAN/iPu0Y4vnHwfr9zZLzdF73J0EOR3DXiUooXlS6YecbE40e/xrUpFri+tg6mG23wsD6QqtHdBgPUGnVhsc0xvM+63Yo+4c/N7ZulgF+fnPXReljlkHUBiOoeL1IizEY5FM1nt2BHytFc4+2fuBmHDf1KROAVxel3sq36heOCHkCw+47hkB6r8GOETNVEuJMi6AVqohAD0hVDMZpofnE5qA5zQFTmeB4zBGW2xn+uj4dA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZzEAxRgbBFAXOn/EhvA1LJIILklE0eY1gpNjosqEjLA=;
 b=EK840/WkKp3OUD26ZqrqS0cVlw66NZESemi+fIyhMKYVzPVI4lXxhRE21IXntLm55z5uENBPkJgPEarQUHuanzXbd+7NeoSZSrVon/3ME3W1m3GpQaM2VJl/MimknR0bXI0YdjH/xeVUvrTOuugKB8jPvAbiVn4JYYvaTyxPB9VqC/B6mhTmbrUXCsH87wDgTTI16Le7zWEkmcfsuUWA+YyRb1zpfoBAS5Ys+a3F8BafzDs9KxRxNhRb1zSTZNi65cnZZAXa7nsvUgzl8TEXG8klAnQjX9H1ljPhRxJczk8edJo6zk8L8fmpJesorEKTs83t9mF0zws8T1dpfggbqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZzEAxRgbBFAXOn/EhvA1LJIILklE0eY1gpNjosqEjLA=;
 b=Mimbx1HF9iZbW8SZ6SC+htDqgPJYTfvWWQb0CTIzHtj2Qj7LKlCAvH+pcLaG0/7bZjdDjzyWy+dXchY32XAO9b6HkfxVhZmKpv8/ibUl/d5pi1T4RcSZL5hYcRc2k5j6tQgioUosoUVTdW5QuKuivWIsN4T0bAlBZvCUcX+WrPg=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Ray.Huang@amd.com; 
Received: from MN2PR12MB3309.namprd12.prod.outlook.com (2603:10b6:208:106::29)
 by MN2PR12MB4047.namprd12.prod.outlook.com (2603:10b6:208:1de::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2878.19; Fri, 3 Apr
 2020 10:28:41 +0000
Received: from MN2PR12MB3309.namprd12.prod.outlook.com
 ([fe80::6417:7247:12ed:1d7b]) by MN2PR12MB3309.namprd12.prod.outlook.com
 ([fe80::6417:7247:12ed:1d7b%5]) with mapi id 15.20.2856.019; Fri, 3 Apr 2020
 10:28:41 +0000
Date: Fri, 3 Apr 2020 18:28:33 +0800
From: Huang Rui <ray.huang@amd.com>
To: "Liang, Prike" <Prike.Liang@amd.com>
Subject: Re: [PATCH] drm/amdgpu: fix gfx hang during suspend with video
 playback
Message-ID: <20200403102832.GB9721@jenkins-Celadon-RN>
References: <1585886873-22825-1-git-send-email-Prike.Liang@amd.com>
 <20200403062642.GA9191@jenkins-Celadon-RN>
 <MN2PR12MB3536631520E378DE4DAACCAAFBC70@MN2PR12MB3536.namprd12.prod.outlook.com>
 <20200403100554.GA9721@jenkins-Celadon-RN>
Content-Disposition: inline
In-Reply-To: <20200403100554.GA9721@jenkins-Celadon-RN>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: HK2P15301CA0022.APCP153.PROD.OUTLOOK.COM
 (2603:1096:202:1::32) To MN2PR12MB3309.namprd12.prod.outlook.com
 (2603:10b6:208:106::29)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from jenkins-Celadon-RN (180.167.199.189) by
 HK2P15301CA0022.APCP153.PROD.OUTLOOK.COM (2603:1096:202:1::32) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2900.0 via Frontend Transport; Fri, 3 Apr 2020 10:28:39 +0000
X-Originating-IP: [180.167.199.189]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 123ddece-a37b-4a6d-367c-08d7d7b9c78b
X-MS-TrafficTypeDiagnostic: MN2PR12MB4047:|MN2PR12MB4047:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB4047D02D10C1E0A5B6A5CA21ECC70@MN2PR12MB4047.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-Forefront-PRVS: 0362BF9FDB
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB3309.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10009020)(4636009)(39850400004)(366004)(136003)(396003)(376002)(346002)(86362001)(45080400002)(478600001)(6636002)(33656002)(966005)(6666004)(15650500001)(66946007)(8676002)(81166006)(66556008)(6862004)(66476007)(1076003)(316002)(8936002)(54906003)(81156014)(2906002)(956004)(16526019)(4326008)(5660300002)(55016002)(52116002)(26005)(186003)(53546011)(9686003)(33716001)(6496006);
 DIR:OUT; SFP:1101; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tzUu+eXXl2BIDmS4Quoccse8d9oTKMLnJVj5lN9QtGyXSpPJ67w2CX0sQiID8dP+HYb7MbRvbQlB+EWTgZwb9blNaQuTruQR8rwSkgkao8i411DBfBAuF39ywYzBhVQRIZcT+/fEjyW6+Tl4MC5GclfX6AuArfcsyGIlg0j929c7+qcKZ7t4HDPYh2EK46tQzvWOugpNbG1xZwBipPnsxheKJDoxBGSiP+82SYLOvHMHLqF9Yl2qv0nA8j1mD6skTzcbYhFo3C8RJgKRnd8YtPTX1nfNyxmkOJ9tXDVCQxmA3of58208UOF0Ud6QmC7Ga+7I06cWiKpt5RrnFI49b41BTIxq7cF2zzIqGp4tlcgpPXIihmjvWzrk2aGqhdkXqheFCrmkO0bJOLW1RL0vypZCLb0lvFp5Pa2WFE0S0QRvWUyYIJ9ba7/+cqeEfBLkdH+SvIQwsdSUIoHWYzoI840rR8QIi2wGFdSUsSws5g4=
X-MS-Exchange-AntiSpam-MessageData: hClKLWWkesB4kd39iyXG9u0GJ+30VD2MvYUxdizXbAcuncjZyV34Mtx5+J99TaI9b2G6Nl7EWs9N3WDagERzUXtFah62MwlPY7wOdpEtiAqhP/+HZ8xyviQwt1eQ6xQeRi8e59eJXsFy3zuQBUsFBA==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 123ddece-a37b-4a6d-367c-08d7d7b9c78b
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Apr 2020 10:28:41.4514 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: W1ODOgPW+zFK5LNmMYOhH4y6abFqNAP1scPuRbG8g1tYXPBb3LKqdawXKS3OX+BLhY4bzQy1OqjekoqXfDhAgw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4047
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

On Fri, Apr 03, 2020 at 06:05:55PM +0800, Huang Rui wrote:
> On Fri, Apr 03, 2020 at 05:22:28PM +0800, Liang, Prike wrote:
> > 
> > > -----Original Message-----
> > > From: Huang, Ray <Ray.Huang@amd.com>
> > > Sent: Friday, April 3, 2020 2:27 PM
> > > To: Liang, Prike <Prike.Liang@amd.com>
> > > Cc: amd-gfx@lists.freedesktop.org; Quan, Evan <Evan.Quan@amd.com>;
> > > Deucher, Alexander <Alexander.Deucher@amd.com>; Kuehling, Felix
> > > <Felix.Kuehling@amd.com>
> > > Subject: Re: [PATCH] drm/amdgpu: fix gfx hang during suspend with video
> > > playback
> > > 
> > > (+ Felix)
> > > 
> > > On Fri, Apr 03, 2020 at 12:07:53PM +0800, Liang, Prike wrote:
> > > > The system will be hang up during S3 as SMU is pending at GC not
> > > > respose the register CP_HQD_ACTIVE access request and this issue can
> > > > be fixed by adding RLC safe mode guard before each HQD map/unmap
> > > > retrive opt.
> > > 
> > > We need more information for the issue, does the map/unmap is required
> > > for MAP_QUEUES/UNMAP_QUEUES packets or writing with MMIO or both?
> > > 
> > [Prike]  The issue hang up at MP1 was trying to read register RSMU_RESIDENCY_COUNTER_GC 
> > but did not get response from GFX, since GFX was busy at reading register CP_HQD_ACTIVE.
> > Moreover, when disabled GFXOFF this issue also can't see so there is likely to perform 
> > register accessed at GFXOFF CGPG/CGCG enter stage.  As for only  this issue, that seems just 
> > MMIO  access failed case which occurred under QUEUE map/unmap status check. 
> > 
> 
> While we start to do S3, we will disable gfxoff at start of suspend. Then
> in this point, the gfx should be always in "on" state. 
> 
> > > From your patch, you just protect the kernel kiq and user queue. What about
> > > other kernel compute queues? HIQ?
> > > 
> > [Prike] So far just find the KIQ/CPQ/DIQ map/unmap will inquire the CP_HQD_ACTIVE status by MMIO accessing,
> > therefore just guard the KIQ  and some type user queue now. Regarding HIQ map and ummap which used the method of submitting configuration packet.  
> > 
> 
> KIQ itself init/unit should be always under gfx on state. Can you give a
> check the result if not add enter/exit rlc safe mode around it?

Wait... In your case, the system didn't load any user queues because no
ROCm based application is running. So the issue is probably caused by KIQ
itself init/unit, can you confirm?

Thanks,
Ray

> 
> Hi Felix, maybe we need to use packets with kiq to map all user queues.
> 
> Thanks,
> Ray
> 
> > > Thanks,
> > > Ray
> > > 
> > > >
> > > > Signed-off-by: Prike Liang <Prike.Liang@amd.com>
> > > > Tested-by: Mengbing Wang <Mengbing.Wang@amd.com>
> > > > ---
> > > >  drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c | 6 ++++++
> > > >  drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c             | 4 ++++
> > > >  2 files changed, 10 insertions(+)
> > > >
> > > > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
> > > > b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
> > > > index df841c2..e265063 100644
> > > > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
> > > > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
> > > > @@ -232,6 +232,7 @@ int kgd_gfx_v9_hqd_load(struct kgd_dev *kgd, void
> > > *mqd, uint32_t pipe_id,
> > > >  	uint32_t *mqd_hqd;
> > > >  	uint32_t reg, hqd_base, data;
> > > >
> > > > +	amdgpu_gfx_rlc_enter_safe_mode(adev);
> > > >  	m = get_mqd(mqd);
> > > >
> > > >  	acquire_queue(kgd, pipe_id, queue_id); @@ -299,6 +300,7 @@ int
> > > > kgd_gfx_v9_hqd_load(struct kgd_dev *kgd, void *mqd, uint32_t pipe_id,
> > > >
> > > >  	release_queue(kgd);
> > > >
> > > > +	amdgpu_gfx_rlc_exit_safe_mode(adev);
> > > >  	return 0;
> > > >  }
> > > >
> > > > @@ -497,6 +499,7 @@ bool kgd_gfx_v9_hqd_is_occupied(struct kgd_dev
> > > *kgd, uint64_t queue_address,
> > > >  	bool retval = false;
> > > >  	uint32_t low, high;
> > > >
> > > > +	amdgpu_gfx_rlc_enter_safe_mode(adev);
> > > >  	acquire_queue(kgd, pipe_id, queue_id);
> > > >  	act = RREG32(SOC15_REG_OFFSET(GC, 0, mmCP_HQD_ACTIVE));
> > > >  	if (act) {
> > > > @@ -508,6 +511,7 @@ bool kgd_gfx_v9_hqd_is_occupied(struct kgd_dev
> > > *kgd, uint64_t queue_address,
> > > >  			retval = true;
> > > >  	}
> > > >  	release_queue(kgd);
> > > > +	amdgpu_gfx_rlc_exit_safe_mode(adev);
> > > >  	return retval;
> > > >  }
> > > >
> > > > @@ -541,6 +545,7 @@ int kgd_gfx_v9_hqd_destroy(struct kgd_dev *kgd,
> > > void *mqd,
> > > >  	uint32_t temp;
> > > >  	struct v9_mqd *m = get_mqd(mqd);
> > > >
> > > > +	amdgpu_gfx_rlc_enter_safe_mode(adev);
> > > >  	if (adev->in_gpu_reset)
> > > >  		return -EIO;
> > > >
> > > > @@ -577,6 +582,7 @@ int kgd_gfx_v9_hqd_destroy(struct kgd_dev *kgd,
> > > void *mqd,
> > > >  	}
> > > >
> > > >  	release_queue(kgd);
> > > > +	amdgpu_gfx_rlc_exit_safe_mode(adev);
> > > >  	return 0;
> > > >  }
> > > >
> > > > diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> > > > b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> > > > index 1fea077..ee107d9 100644
> > > > --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> > > > +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> > > > @@ -3533,6 +3533,7 @@ static int gfx_v9_0_kiq_init_register(struct
> > > amdgpu_ring *ring)
> > > >  	struct v9_mqd *mqd = ring->mqd_ptr;
> > > >  	int j;
> > > >
> > > > +	amdgpu_gfx_rlc_enter_safe_mode(adev);
> > > >  	/* disable wptr polling */
> > > >  	WREG32_FIELD15(GC, 0, CP_PQ_WPTR_POLL_CNTL, EN, 0);
> > > >
> > > > @@ -3629,6 +3630,7 @@ static int gfx_v9_0_kiq_init_register(struct
> > > amdgpu_ring *ring)
> > > >  	if (ring->use_doorbell)
> > > >  		WREG32_FIELD15(GC, 0, CP_PQ_STATUS, DOORBELL_ENABLE,
> > > 1);
> > > >
> > > > +	amdgpu_gfx_rlc_exit_safe_mode(adev);
> > > >  	return 0;
> > > >  }
> > > >
> > > > @@ -3637,6 +3639,7 @@ static int gfx_v9_0_kiq_fini_register(struct
> > > amdgpu_ring *ring)
> > > >  	struct amdgpu_device *adev = ring->adev;
> > > >  	int j;
> > > >
> > > > +	amdgpu_gfx_rlc_enter_safe_mode(adev);
> > > >  	/* disable the queue if it's active */
> > > >  	if (RREG32_SOC15(GC, 0, mmCP_HQD_ACTIVE) & 1) {
> > > >
> > > > @@ -3668,6 +3671,7 @@ static int gfx_v9_0_kiq_fini_register(struct
> > > amdgpu_ring *ring)
> > > >  	WREG32_SOC15_RLC(GC, 0, mmCP_HQD_PQ_WPTR_HI, 0);
> > > >  	WREG32_SOC15_RLC(GC, 0, mmCP_HQD_PQ_WPTR_LO, 0);
> > > >
> > > > +	amdgpu_gfx_rlc_exit_safe_mode(adev);
> > > >  	return 0;
> > > >  }
> > > >
> > > > --
> > > > 2.7.4
> > > >
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=02%7C01%7Cray.huang%40amd.com%7C040563ff26374383ec6108d7d7b6a2bb%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637215053543776633&amp;sdata=COMvG7W4%2Fl7aKDAV8Qgbl%2F3myW0HCSz7qk014OLUzrY%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
