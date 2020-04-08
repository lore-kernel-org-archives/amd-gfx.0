Return-Path: <SRS0=b+Zp=5Y=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A17C1C2BB54
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Apr 2020 02:48:40 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6987B20748
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Apr 2020 02:48:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="S/RKW/qP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6987B20748
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 266236E194;
	Wed,  8 Apr 2020 02:48:40 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2054.outbound.protection.outlook.com [40.107.223.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 547CA6E194
 for <amd-gfx@lists.freedesktop.org>; Wed,  8 Apr 2020 02:48:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PTW0u85/PKswyzAMWawfHc/RwRPesL9cgIMB5Q6nQ1HyfBX6vbWK44yCF3tnvkR0TEfrdnyzm9u4d4hj99mdr9TWDFNtVDzVQzxd7sSMPt7ZZ+eDnyN5NOET/RCaNn6bvVofi9ikJRke9gyOaPcCJd3BcVmxgw5qwnVn7KCCLio4pzIuTAUzjKDDwOAIi7YuqUoecrYCnIWRzYQkQh1aGznWhN2YK9JbX25Bl8fPAhPHmM3ePCPOvV0Fe7/sXs+edOq4SCl/tujX2R0JSmAnk0DGjpZN+hmI5s2gLuQq1roaqbWwuEH2DDsPM+0Isg05OqZhonJqZoFhWGJtjDGghA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ypipT2kqbxCg8BwHluS7EqyaMVNjDq3ZZtVrcfiS2MM=;
 b=m3lBBzFJ1YhgcU+/a0sj02xhi+RBuQFVclXL2AgGcgs57sj8XmloLavTQEHJr5sx6nioBxShgKS6ELGCTtCdN//EFAGLdSbikDhk86hhLz/GO3boS+Z76z2Q0vUQIePJVUWv3wRy5D8MBB+P05yc4l9nydrb5KFmWEbV2zWC0z2f+qLHrEVBGOA51tS8ExQyjpubR+GLiTerxY7VSxGJhPJLstgWzevTENEWKgcMwKx/TXRDUTnDJi7XucWGzZdJXfvxSRufuV11QJbEWPcXYFz124O4wV4K2eKI7tG/TO9CjgeDHrMm9c+f3KIZuRh4gzPw1AFuGtcRIsnmkRaOBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ypipT2kqbxCg8BwHluS7EqyaMVNjDq3ZZtVrcfiS2MM=;
 b=S/RKW/qP3DywpQGHRSOuSVGfYajskI0cS4FH2zuuQWKjQC5vDJktknjZBD5TA76rzB1ARg8LIP9bGXAb6USkqz4Y1ZCG5Mjqge8LitofAM6IXlxwRXDndgGVdNKgfPNQP0N0rd2l3gXwmjYhughpf6+2aCZzVAqIBfZljOL7uKQ=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Ray.Huang@amd.com; 
Received: from MN2PR12MB3309.namprd12.prod.outlook.com (2603:10b6:208:106::29)
 by MN2PR12MB3680.namprd12.prod.outlook.com (2603:10b6:208:169::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2878.16; Wed, 8 Apr
 2020 02:48:36 +0000
Received: from MN2PR12MB3309.namprd12.prod.outlook.com
 ([fe80::6417:7247:12ed:1d7b]) by MN2PR12MB3309.namprd12.prod.outlook.com
 ([fe80::6417:7247:12ed:1d7b%5]) with mapi id 15.20.2878.018; Wed, 8 Apr 2020
 02:48:36 +0000
Date: Wed, 8 Apr 2020 10:48:28 +0800
From: Huang Rui <ray.huang@amd.com>
To: "Kuehling, Felix" <Felix.Kuehling@amd.com>
Subject: Re: [PATCH] drm/amdgpu: fix gfx hang during suspend with video
 playback
Message-ID: <20200408024827.GA27688@jenkins-Celadon-RN>
References: <1585886873-22825-1-git-send-email-Prike.Liang@amd.com>
 <0233f59a-a225-75c0-22f6-7c61e3b70475@amd.com>
Content-Disposition: inline
In-Reply-To: <0233f59a-a225-75c0-22f6-7c61e3b70475@amd.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: HK0PR03CA0104.apcprd03.prod.outlook.com
 (2603:1096:203:b0::20) To MN2PR12MB3309.namprd12.prod.outlook.com
 (2603:10b6:208:106::29)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from jenkins-Celadon-RN (180.167.199.189) by
 HK0PR03CA0104.apcprd03.prod.outlook.com (2603:1096:203:b0::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2900.15 via Frontend Transport; Wed, 8 Apr 2020 02:48:34 +0000
X-Originating-IP: [180.167.199.189]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 902df41e-1dab-4979-2899-08d7db6755ac
X-MS-TrafficTypeDiagnostic: MN2PR12MB3680:|MN2PR12MB3680:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB36800ECF58C2947E33DFED73ECC00@MN2PR12MB3680.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:935;
X-Forefront-PRVS: 0367A50BB1
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB3309.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10009020)(4636009)(346002)(366004)(376002)(136003)(39860400002)(396003)(52116002)(26005)(15650500001)(6862004)(966005)(1076003)(66946007)(81166007)(478600001)(4326008)(6636002)(66476007)(8676002)(8936002)(6496006)(956004)(55016002)(33716001)(2906002)(316002)(86362001)(16526019)(5660300002)(186003)(33656002)(81156014)(54906003)(9686003)(6666004)(66556008);
 DIR:OUT; SFP:1101; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zGTlSuPIJ0LhOLGVokosgYK7pUsX37ztxlsTP9DN1yWX8y3BMnRu1Z5G+Ukp9fAs+qkFRxE7NebeVHhsmIaFKBLDBuyrZJ+waWOYCKsu//KSyAzIp/wQxDGWPhoF1Y7yV8Va3W2kIwclCeHRR+VxUgPwy5vTZBFdpvgxOEmODjbNGJhmFJ6rfFEsfdA2ms/6ozNN6WfZzjZNVNaoSZd/UCeOIS4RmJCN4BYr9OuUi5W+tfy1PnYX2EjGilZQJa6AeowBL3GRFozZy6zFan5tgQs6ZDeKw38xxiqC+RAs+5CYpATCpwUS6iNAXcMRrj7F+AtZwgy9H06W7BSIATLLLDGs2zomWHvy2Ll3yr6o9aInViu1YEcuVG8+/TTgtB+aLcH8dT8UNR/a/nwmZFs3ILwwbRXJBekBt7SlwCOuG7Eh+vxIw20fhyBwYHZHiHzwKsfpAZP6tkLtJa5pEOx4bW7cV+XndaHEjTFnSiXoC2Y=
X-MS-Exchange-AntiSpam-MessageData: TPOuWvmTNeyt7uLM65INqc/JRDNzPlXJwoduavGDGDRhAvA1tRiqNOr0zue2/dMDnP7VoUqxOCGURSdH9NlPsOfE6LH+XqHvfsjUuIKuKvr4fLmC8HCzGiGjlNVCQrm3KpVR8dEzXuulkygLKcKoUw==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 902df41e-1dab-4979-2899-08d7db6755ac
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2020 02:48:36.4223 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6J8Z7tPMXSCeiGvUhL3ZZD+fzqzvsojHYDQFjeSue+Q/eol6NE+7kFYrvWAmBIBzW/H8zqfh5W1AsgGwvA+Bcg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3680
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Liang,
 Prike" <Prike.Liang@amd.com>, "Quan, Evan" <Evan.Quan@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Tue, Apr 07, 2020 at 11:43:20PM +0800, Kuehling, Felix wrote:
> Sorry, I missed this email thread because the subject seemed irrelevant
> to me. I still don't get why this is causing a problem with
> suspend/resume with video playback.
> =

> The functions you're changing are mostly used when running without HWS.
> This should only be the case during bring-ups or while debugging HWS
> issues. Otherwise they're only used for setting up the HIQ. That means
> in normal operation, these functions should not be used for user mode
> queue mapping, which is handled by the HWS.

The issue is caused by destorying the queue with mmio under cgpg/gfxoff
enabled.

While we do suspend to S3, it will destory the HIQ under CGPG/GFXOFF is sti=
ll
enabled. At that time, we didn't have any commands under HWS, because of no
ROCm application is running. =


In this case, we have three ways to fix the issue:

1. Disable CGPG/GFXOFF before do kfd suspend.

https://lists.freedesktop.org/archives/amd-gfx/2020-April/048181.html

2. Destory the hiq queue under RLC save mode.
3. Using the UNMAP packet to unmap the hiq with kiq instead of mmio.

I think use #1 is more straightforward. For long term, I think we should use
kiq to map/unmap all cp/sdma queues.

> =

> Ray, I vaguely remember we discussed using KIQ for mapping the HIQ at
> some point. Did anyone ever propose a patch for that?
> =


Yes, that's patch is already upstream. However this issue is caused by
destorying the queue. (sorry, I should cover this case before)

commit 35cd89d5a658dc26687a7a6909d35fee19a6b173
Author: Aaron Liu <aaron.liu@amd.com>
Date:   Wed Dec 25 15:50:51 2019 +0800

    drm/amdkfd: use kiq to load the mqd of hiq queue for gfx v9 (v6)

    There is an issue that CP will check the HIQ queue to be configured and=
 mapped
    with KIQ ring, otherwise, it will be unable to read back the secure buf=
fer while
    the gfxoff is enabled even with trusted IP blocks.

    v1 -> v2:
    - Fix to remove surplus set_resources packets.
    - Fill the whole configuration in MQD.
    - Change the author as Aaron because he addressed the key point of this=
 issue.
    - Add kiq ring lock.

    v2 -> v3:
    - Free the lock while in error return case.
    - Remove the programming only needed by the queue is unmapped.

    v3 -> v4:
    - Remove doorbell programming because it's used for restarting queue.
    - Remove CP scheduler programming because map_queue packet will handle =
this.

    v4 -> v5:
    - Remove cp_hqd_active because mec ucode will enable it while use map_q=
ueues.
    - Revise goto out_unlock.
    - Correct the right doorbell offset for HIQ that kfd driver assigned in=
 the
      packet.

    v5 -> v6:
    - Merge Arcturus fix into this patch because it will get oops in Arctur=
us
      platform.

    Reported-by: Lisa Saturday <Lisa.Saturday@amd.com>
    Signed-off-by: Aaron Liu <aaron.liu@amd.com>
    Signed-off-by: Huang Rui <ray.huang@amd.com>
    Reviewed-and-Tested-by: Aaron Liu <aaron.liu@amd.com>
    Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>
    Signed-off-by: Alex Deucher <alexander.deucher@amd.com>

Thanks,
Ray

> Thanks,
> =A0 Felix
> =

> Am 2020-04-03 um 12:07 a.m. schrieb Prike Liang:
> > The system will be hang up during S3 as SMU is pending at GC not
> > respose the register CP_HQD_ACTIVE access request and this issue
> > can be fixed by adding RLC safe mode guard before each HQD
> > map/unmap retrive opt.
> >
> > Signed-off-by: Prike Liang <Prike.Liang@amd.com>
> > Tested-by: Mengbing Wang <Mengbing.Wang@amd.com>
> > ---
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c | 6 ++++++
> >  drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c             | 4 ++++
> >  2 files changed, 10 insertions(+)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c b/driver=
s/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
> > index df841c2..e265063 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
> > @@ -232,6 +232,7 @@ int kgd_gfx_v9_hqd_load(struct kgd_dev *kgd, void *=
mqd, uint32_t pipe_id,
> >  	uint32_t *mqd_hqd;
> >  	uint32_t reg, hqd_base, data;
> >  =

> > +	amdgpu_gfx_rlc_enter_safe_mode(adev);
> >  	m =3D get_mqd(mqd);
> >  =

> >  	acquire_queue(kgd, pipe_id, queue_id);
> > @@ -299,6 +300,7 @@ int kgd_gfx_v9_hqd_load(struct kgd_dev *kgd, void *=
mqd, uint32_t pipe_id,
> >  =

> >  	release_queue(kgd);
> >  =

> > +	amdgpu_gfx_rlc_exit_safe_mode(adev);
> >  	return 0;
> >  }
> >  =

> > @@ -497,6 +499,7 @@ bool kgd_gfx_v9_hqd_is_occupied(struct kgd_dev *kgd=
, uint64_t queue_address,
> >  	bool retval =3D false;
> >  	uint32_t low, high;
> >  =

> > +	amdgpu_gfx_rlc_enter_safe_mode(adev);
> >  	acquire_queue(kgd, pipe_id, queue_id);
> >  	act =3D RREG32(SOC15_REG_OFFSET(GC, 0, mmCP_HQD_ACTIVE));
> >  	if (act) {
> > @@ -508,6 +511,7 @@ bool kgd_gfx_v9_hqd_is_occupied(struct kgd_dev *kgd=
, uint64_t queue_address,
> >  			retval =3D true;
> >  	}
> >  	release_queue(kgd);
> > +	amdgpu_gfx_rlc_exit_safe_mode(adev);
> >  	return retval;
> >  }
> >  =

> > @@ -541,6 +545,7 @@ int kgd_gfx_v9_hqd_destroy(struct kgd_dev *kgd, voi=
d *mqd,
> >  	uint32_t temp;
> >  	struct v9_mqd *m =3D get_mqd(mqd);
> >  =

> > +	amdgpu_gfx_rlc_enter_safe_mode(adev);
> >  	if (adev->in_gpu_reset)
> >  		return -EIO;
> >  =

> > @@ -577,6 +582,7 @@ int kgd_gfx_v9_hqd_destroy(struct kgd_dev *kgd, voi=
d *mqd,
> >  	}
> >  =

> >  	release_queue(kgd);
> > +	amdgpu_gfx_rlc_exit_safe_mode(adev);
> >  	return 0;
> >  }
> >  =

> > diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/am=
d/amdgpu/gfx_v9_0.c
> > index 1fea077..ee107d9 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> > @@ -3533,6 +3533,7 @@ static int gfx_v9_0_kiq_init_register(struct amdg=
pu_ring *ring)
> >  	struct v9_mqd *mqd =3D ring->mqd_ptr;
> >  	int j;
> >  =

> > +	amdgpu_gfx_rlc_enter_safe_mode(adev);
> >  	/* disable wptr polling */
> >  	WREG32_FIELD15(GC, 0, CP_PQ_WPTR_POLL_CNTL, EN, 0);
> >  =

> > @@ -3629,6 +3630,7 @@ static int gfx_v9_0_kiq_init_register(struct amdg=
pu_ring *ring)
> >  	if (ring->use_doorbell)
> >  		WREG32_FIELD15(GC, 0, CP_PQ_STATUS, DOORBELL_ENABLE, 1);
> >  =

> > +	amdgpu_gfx_rlc_exit_safe_mode(adev);
> >  	return 0;
> >  }
> >  =

> > @@ -3637,6 +3639,7 @@ static int gfx_v9_0_kiq_fini_register(struct amdg=
pu_ring *ring)
> >  	struct amdgpu_device *adev =3D ring->adev;
> >  	int j;
> >  =

> > +	amdgpu_gfx_rlc_enter_safe_mode(adev);
> >  	/* disable the queue if it's active */
> >  	if (RREG32_SOC15(GC, 0, mmCP_HQD_ACTIVE) & 1) {
> >  =

> > @@ -3668,6 +3671,7 @@ static int gfx_v9_0_kiq_fini_register(struct amdg=
pu_ring *ring)
> >  	WREG32_SOC15_RLC(GC, 0, mmCP_HQD_PQ_WPTR_HI, 0);
> >  	WREG32_SOC15_RLC(GC, 0, mmCP_HQD_PQ_WPTR_LO, 0);
> >  =

> > +	amdgpu_gfx_rlc_exit_safe_mode(adev);
> >  	return 0;
> >  }
> >  =

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
