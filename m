Return-Path: <SRS0=b/N7=3C=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C70DC33CA8
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Jan 2020 09:07:33 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D51D2206D7
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Jan 2020 09:07:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="clEGCmdl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D51D2206D7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 929F489E14;
	Mon, 13 Jan 2020 09:07:32 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2072.outbound.protection.outlook.com [40.107.92.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4A9A989DF9
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 Jan 2020 09:07:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SWYHNiTB0Mn6yCT3UQyXP0YLFzuSPHCig3ltsqcdcxnysdUbXagswM3xfL132oiOApU3ELALS7W7dcSZcw26U9GHq3T+GuahCzsClr4hok8hA8kKGu8PpX47Vp+Yh6THSK9mwfBhDuM4FjV+isMQfGa5XR4szr4H3O6Z1gGTwLzqFgmBrbR6Tw8mOi4zFlExb0EuL3yZXDSjZjfQ16L/DdPlb+gIr3icL/yotoBiS5Bzf/FH4jFeIswCBnyPMvx0Y3d1hw2hU6cTgZ8sbuhhv5WTPTNlwioK8DNu1qjsiMx2wLIrHN30FBUBCSvBWbnzKcL08VPILbC0dKYlKrtCtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qXOO+KRTeG+rh6QYWmYK5WJU5luzp4fTrCmAS4RQ/FI=;
 b=Zge+UYyRDDZjmV3hlTk32ZJ/RElBo/emkBiU9KM6x1nBCCLH3XAiwLebQoaJUSft27k1lTEpg2KKxXLARgkbdjpd3UPuzHcrjjLlTNvg80VK0p7lJniA8ckDrnknCrULUuw9BaOEsfQalfJafj6Ig8tY4rcqUWZYWxRGQ0rlP30MuC6Y5y/3izESw3Zd0Wmp5nbHh+oRAoFNbeswW/vZGf/ngPmXtJMfmTcvrvE5Z1rKX2Y44ZoYevB/mhsTE67wwl2WpCwIesHg4sR17qzbFIAv4v9VtZuuq6eSwZmA9YMAa2mY0OrsAIEzRe1kcSLOvPUHMYtG8jz5/oPsXcbynw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qXOO+KRTeG+rh6QYWmYK5WJU5luzp4fTrCmAS4RQ/FI=;
 b=clEGCmdl7Ko2K9ZzlmK2Y2l9nB+UIX9KFeWv2Ip7ciJG+BxuPsuI6oM613D0G4VvIcDdV9NQUUgdbfgpiHHfymyPQP88xnhjgLM1MOY2FwNmW92m/vL2AnCecjYHdGUtXhqs6ipjKbDWIAurgw3hfinUiKxDnVmWoFk9qVOMl+g=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Ray.Huang@amd.com; 
Received: from MN2PR12MB3309.namprd12.prod.outlook.com (20.179.83.157) by
 MN2PR12MB3008.namprd12.prod.outlook.com (20.178.242.17) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2623.9; Mon, 13 Jan 2020 09:07:29 +0000
Received: from MN2PR12MB3309.namprd12.prod.outlook.com
 ([fe80::f945:5c4c:9c3f:930a]) by MN2PR12MB3309.namprd12.prod.outlook.com
 ([fe80::f945:5c4c:9c3f:930a%6]) with mapi id 15.20.2623.015; Mon, 13 Jan 2020
 09:07:29 +0000
Date: Mon, 13 Jan 2020 17:07:21 +0800
From: Huang Rui <ray.huang@amd.com>
To: "Kuehling, Felix" <Felix.Kuehling@amd.com>
Subject: Re: [PATCH 4/5] drm/amdkfd: use map_queues for hiq on gfx v10 as well
Message-ID: <20200113090720.GA24109@jenkins-Celadon-RN>
References: <1578638233-9357-1-git-send-email-ray.huang@amd.com>
 <1578638233-9357-4-git-send-email-ray.huang@amd.com>
 <7eaa7a0c-1008-b869-33cb-42f7418ed91e@amd.com>
Content-Disposition: inline
In-Reply-To: <7eaa7a0c-1008-b869-33cb-42f7418ed91e@amd.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: HK2PR06CA0019.apcprd06.prod.outlook.com
 (2603:1096:202:2e::31) To MN2PR12MB3309.namprd12.prod.outlook.com
 (2603:10b6:208:106::29)
MIME-Version: 1.0
Received: from jenkins-Celadon-RN (180.167.199.189) by
 HK2PR06CA0019.apcprd06.prod.outlook.com (2603:1096:202:2e::31) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2623.9 via Frontend Transport; Mon, 13 Jan 2020 09:07:27 +0000
X-Originating-IP: [180.167.199.189]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 3aeb47ff-e2ad-4a35-b413-08d7980803df
X-MS-TrafficTypeDiagnostic: MN2PR12MB3008:|MN2PR12MB3008:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB3008834438C44F89A3047798EC350@MN2PR12MB3008.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:23;
X-Forefront-PRVS: 028166BF91
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(396003)(136003)(366004)(376002)(39860400002)(346002)(199004)(189003)(51234002)(66476007)(9686003)(86362001)(33656002)(478600001)(53546011)(66556008)(6496006)(52116002)(4326008)(6862004)(26005)(55016002)(16526019)(186003)(66946007)(5660300002)(8676002)(81156014)(81166006)(54906003)(956004)(8936002)(316002)(6666004)(6636002)(2906002)(33716001)(1076003);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MN2PR12MB3008;
 H:MN2PR12MB3309.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IhwgtZL7bOlzDQwYnOQT5raN9yVZeZNVZLSZoG8AmPuYbEscbilC3amycTDD+eoZQ8e0DNg+R3z8s7iIO14ZcBi5JFcBwdTDXK9ys1OOcz5ic1DKqqEZpHtfyfrhi9G7ze1Di85Nx94eDJREa/++KazmcOIZfdRi934rTBYWbtmonTQGcvW6b1Xjka69wDagoZdJ0t/KmIhqM9f28iCOExXkXAW6rStojr9i0sbeoIA+Rq8upuvPAkSo6dA4uH1Xp5npGRMgzEtMwLfpoRjtkXWiaS8JRZRZuFuQhhclFWqgZWMW7OPFSIvVR6qZ/tubjqdCFzYwCFK5DEHkVVIXEu5xfa99gWe/8dk6kCwhV5JMDpsLydpe9EqY9bk3bn2CvW6CJ+BwGcY5nPfSFs9FunwtX8c+mXqtuXHP3EkH9L+LZC7F9eqT35U+iGKxiZg4Vx2hHlEwDdxjmkfOVFiIRPHnaFgcY64csh7R3fFoDj5xhXKH1vff/k9pvjLAEsxG
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3aeb47ff-e2ad-4a35-b413-08d7980803df
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2020 09:07:28.9926 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YM+KHwFnuUhqLoTmwteCHDm6/LgY6eRMUjX3pSRfBUV3lqDE3vKX+8jwGVDvxO1VNh0b5WN7JPsmz880cAnECw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3008
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Sat, Jan 11, 2020 at 07:08:42AM +0800, Kuehling, Felix wrote:
> On 2020-01-10 1:37 a.m., Huang Rui wrote:
> > To align with gfx v9, we use the map_queues packet to load hiq MQD.
> >
> > Signed-off-by: Huang Rui <ray.huang@amd.com>
> 
> Please make sure you test this on a GFXv10 GPU.
> 
> Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>
> 

I tested both navi14 and fiji card, gfx10 works well. But gfx8 failed with
page fault...

Thanks,
Ray

> 
> > ---
> >   drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.c | 82 ++++++++++++++++------
> >   drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v10.c   | 10 ++-
> >   2 files changed, 70 insertions(+), 22 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.c
> > index 61cd707..2a60f73 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.c
> > @@ -107,13 +107,13 @@ static void acquire_queue(struct kgd_dev *kgd, uint32_t pipe_id,
> >   	lock_srbm(kgd, mec, pipe, queue_id, 0);
> >   }
> >   
> > -static uint32_t get_queue_mask(struct amdgpu_device *adev,
> > +static uint64_t get_queue_mask(struct amdgpu_device *adev,
> >   			       uint32_t pipe_id, uint32_t queue_id)
> >   {
> > -	unsigned int bit = (pipe_id * adev->gfx.mec.num_queue_per_pipe +
> > -			    queue_id) & 31;
> > +	unsigned int bit = pipe_id * adev->gfx.mec.num_queue_per_pipe +
> > +			queue_id;
> >   
> > -	return ((uint32_t)1) << bit;
> > +	return 1ull << bit;
> >   }
> >   
> >   static void release_queue(struct kgd_dev *kgd)
> > @@ -268,21 +268,6 @@ static int kgd_hqd_load(struct kgd_dev *kgd, void *mqd, uint32_t pipe_id,
> >   	pr_debug("Load hqd of pipe %d queue %d\n", pipe_id, queue_id);
> >   	acquire_queue(kgd, pipe_id, queue_id);
> >   
> > -	/* HIQ is set during driver init period with vmid set to 0*/
> > -	if (m->cp_hqd_vmid == 0) {
> > -		uint32_t value, mec, pipe;
> > -
> > -		mec = (pipe_id / adev->gfx.mec.num_pipe_per_mec) + 1;
> > -		pipe = (pipe_id % adev->gfx.mec.num_pipe_per_mec);
> > -
> > -		pr_debug("kfd: set HIQ, mec:%d, pipe:%d, queue:%d.\n",
> > -			mec, pipe, queue_id);
> > -		value = RREG32(SOC15_REG_OFFSET(GC, 0, mmRLC_CP_SCHEDULERS));
> > -		value = REG_SET_FIELD(value, RLC_CP_SCHEDULERS, scheduler1,
> > -			((mec << 5) | (pipe << 3) | queue_id | 0x80));
> > -		WREG32(SOC15_REG_OFFSET(GC, 0, mmRLC_CP_SCHEDULERS), value);
> > -	}
> > -
> >   	/* HQD registers extend from CP_MQD_BASE_ADDR to CP_HQD_EOP_WPTR_MEM. */
> >   	mqd_hqd = &m->cp_mqd_base_addr_lo;
> >   	hqd_base = SOC15_REG_OFFSET(GC, 0, mmCP_MQD_BASE_ADDR);
> > @@ -332,9 +317,10 @@ static int kgd_hqd_load(struct kgd_dev *kgd, void *mqd, uint32_t pipe_id,
> >   		       lower_32_bits((uint64_t)wptr));
> >   		WREG32(SOC15_REG_OFFSET(GC, 0, mmCP_HQD_PQ_WPTR_POLL_ADDR_HI),
> >   		       upper_32_bits((uint64_t)wptr));
> > -		pr_debug("%s setting CP_PQ_WPTR_POLL_CNTL1 to %x\n", __func__, get_queue_mask(adev, pipe_id, queue_id));
> > +		pr_debug("%s setting CP_PQ_WPTR_POLL_CNTL1 to %x\n", __func__,
> > +			 (uint32_t)get_queue_mask(adev, pipe_id, queue_id));
> >   		WREG32(SOC15_REG_OFFSET(GC, 0, mmCP_PQ_WPTR_POLL_CNTL1),
> > -		       get_queue_mask(adev, pipe_id, queue_id));
> > +		       (uint32_t)get_queue_mask(adev, pipe_id, queue_id));
> >   	}
> >   
> >   	/* Start the EOP fetcher */
> > @@ -350,6 +336,59 @@ static int kgd_hqd_load(struct kgd_dev *kgd, void *mqd, uint32_t pipe_id,
> >   	return 0;
> >   }
> >   
> > +static int kgd_hiq_mqd_load(struct kgd_dev *kgd, void *mqd,
> > +			    uint32_t pipe_id, uint32_t queue_id,
> > +			    uint32_t doorbell_off)
> > +{
> > +	struct amdgpu_device *adev = get_amdgpu_device(kgd);
> > +	struct amdgpu_ring *kiq_ring = &adev->gfx.kiq.ring;
> > +	struct v10_compute_mqd *m;
> > +	uint32_t mec, pipe;
> > +	int r;
> > +
> > +	m = get_mqd(mqd);
> > +
> > +	acquire_queue(kgd, pipe_id, queue_id);
> > +
> > +	mec = (pipe_id / adev->gfx.mec.num_pipe_per_mec) + 1;
> > +	pipe = (pipe_id % adev->gfx.mec.num_pipe_per_mec);
> > +
> > +	pr_debug("kfd: set HIQ, mec:%d, pipe:%d, queue:%d.\n",
> > +		 mec, pipe, queue_id);
> > +
> > +	spin_lock(&adev->gfx.kiq.ring_lock);
> > +	r = amdgpu_ring_alloc(kiq_ring, 7);
> > +	if (r) {
> > +		pr_err("Failed to alloc KIQ (%d).\n", r);
> > +		goto out_unlock;
> > +	}
> > +
> > +	amdgpu_ring_write(kiq_ring, PACKET3(PACKET3_MAP_QUEUES, 5));
> > +	amdgpu_ring_write(kiq_ring,
> > +			  PACKET3_MAP_QUEUES_QUEUE_SEL(0) | /* Queue_Sel */
> > +			  PACKET3_MAP_QUEUES_VMID(m->cp_hqd_vmid) | /* VMID */
> > +			  PACKET3_MAP_QUEUES_QUEUE(queue_id) |
> > +			  PACKET3_MAP_QUEUES_PIPE(pipe) |
> > +			  PACKET3_MAP_QUEUES_ME((mec - 1)) |
> > +			  PACKET3_MAP_QUEUES_QUEUE_TYPE(0) | /*queue_type: normal compute queue */
> > +			  PACKET3_MAP_QUEUES_ALLOC_FORMAT(0) | /* alloc format: all_on_one_pipe */
> > +			  PACKET3_MAP_QUEUES_ENGINE_SEL(1) | /* engine_sel: hiq */
> > +			  PACKET3_MAP_QUEUES_NUM_QUEUES(1)); /* num_queues: must be 1 */
> > +	amdgpu_ring_write(kiq_ring,
> > +			  PACKET3_MAP_QUEUES_DOORBELL_OFFSET(doorbell_off));
> > +	amdgpu_ring_write(kiq_ring, m->cp_mqd_base_addr_lo);
> > +	amdgpu_ring_write(kiq_ring, m->cp_mqd_base_addr_hi);
> > +	amdgpu_ring_write(kiq_ring, m->cp_hqd_pq_wptr_poll_addr_lo);
> > +	amdgpu_ring_write(kiq_ring, m->cp_hqd_pq_wptr_poll_addr_hi);
> > +	amdgpu_ring_commit(kiq_ring);
> > +
> > +out_unlock:
> > +	spin_unlock(&adev->gfx.kiq.ring_lock);
> > +	release_queue(kgd);
> > +
> > +	return r;
> > +}
> > +
> >   static int kgd_hqd_dump(struct kgd_dev *kgd,
> >   			uint32_t pipe_id, uint32_t queue_id,
> >   			uint32_t (**dump)[2], uint32_t *n_regs)
> > @@ -817,6 +856,7 @@ const struct kfd2kgd_calls gfx_v10_kfd2kgd = {
> >   	.set_pasid_vmid_mapping = kgd_set_pasid_vmid_mapping,
> >   	.init_interrupts = kgd_init_interrupts,
> >   	.hqd_load = kgd_hqd_load,
> > +	.hiq_mqd_load = kgd_hiq_mqd_load,
> >   	.hqd_sdma_load = kgd_hqd_sdma_load,
> >   	.hqd_dump = kgd_hqd_dump,
> >   	.hqd_sdma_dump = kgd_hqd_sdma_dump,
> > diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v10.c b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v10.c
> > index 7832ec6..d1d68a5 100644
> > --- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v10.c
> > +++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v10.c
> > @@ -153,6 +153,14 @@ static int load_mqd(struct mqd_manager *mm, void *mqd,
> >   	return r;
> >   }
> >   
> > +static int hiq_load_mqd_kiq(struct mqd_manager *mm, void *mqd,
> > +			    uint32_t pipe_id, uint32_t queue_id,
> > +			    struct queue_properties *p, struct mm_struct *mms)
> > +{
> > +	return mm->dev->kfd2kgd->hiq_mqd_load(mm->dev->kgd, mqd, pipe_id,
> > +					      queue_id, p->doorbell_off);
> > +}
> > +
> >   static void update_mqd(struct mqd_manager *mm, void *mqd,
> >   		      struct queue_properties *q)
> >   {
> > @@ -409,7 +417,7 @@ struct mqd_manager *mqd_manager_init_v10(enum KFD_MQD_TYPE type,
> >   		mqd->allocate_mqd = allocate_hiq_mqd;
> >   		mqd->init_mqd = init_mqd_hiq;
> >   		mqd->free_mqd = free_mqd_hiq_sdma;
> > -		mqd->load_mqd = load_mqd;
> > +		mqd->load_mqd = hiq_load_mqd_kiq;
> >   		mqd->update_mqd = update_mqd;
> >   		mqd->destroy_mqd = destroy_mqd;
> >   		mqd->is_occupied = is_occupied;
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
