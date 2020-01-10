Return-Path: <SRS0=i8pd=27=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F2EDC282DD
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Jan 2020 23:08:47 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E2EF320721
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Jan 2020 23:08:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="q7yT58Ir"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E2EF320721
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9A5D26E0F4;
	Fri, 10 Jan 2020 23:08:46 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2073.outbound.protection.outlook.com [40.107.244.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 88F236E0F4
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Jan 2020 23:08:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ntVPo0JYc0UNAJKO56gfTPRR3bDLb2myYZMJFXPIxuSoehtYDuJXepDetJ4Ql886yoUOLkeaZBPM7+HpRCzi3JvzqBeIMvh3TRUAvZB/w/fo0qVpBAqqq3Jc9VCpwh8UPMAml38ykAkrDupw8m/7qpI7t8hZu5wclm+c073z6SbfmXCAovuXO+E45U9lH/6XCK8cZ6lgIkKxWP6xfV6ZVtTbfsrMdt7YWUksw0IgV8jPJ6mSYQxbsXD/mPCijKJpblyCyuMwoBsAaNyS53wKyhVo4YzCsJx4yRMCnro9AN0kePDgiuVY6uVAfHPlxcGxo6Os9ssc2R+DPI1JYvLMOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PBabITHPRGxBYQnSo+6qsFxeRRayZZe0vhcQuEqVJh4=;
 b=cpRP2fikoq3J6HRBiRsZBr0AHNskMzNU5Hq/b1PHS/hoqY/QAAaH/Bc9KLpXta7VFyV7hTFMNJyXf+y8A9wAMNZxKg8wGFFaS6NtkVSNoNHOoKcDDtZ3CKmdJUZmTR1IYlGqc4nSFSKPPoli9xBiG7NpGryy/CYvUYqBY0yDE0Gb5+ZrpAQHB9Ac0C4GKmbLhxJl1xiskdNQDhN50n0cAPDUPc89E+qLyMSQFAaXUuCMp2G9GfZ32ADuuRz1MlYRHuU4VKW85+GWzoz7ZsS7mTYjqZjCa1Noi6pdReN9b3eu0WtqcfVvY8xDKaLSL1FnlXi5SHF6RpzAwj6Fx9XivQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PBabITHPRGxBYQnSo+6qsFxeRRayZZe0vhcQuEqVJh4=;
 b=q7yT58IrJb/LrtMSYcL0o937CfBfZTCRBq1lCqaMoloeQxZVOrCuFMeZX/SYVSmr/mcwzLDNq5qpH/hjCgKeCTztIjS1a5ajJsAw7AfJ9CSicxHut1v8KgwyL98E3wylHeQNAmKIh7GP6brJQIoLSTBKZ2pzEpbQtjSby1KeT04=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Felix.Kuehling@amd.com; 
Received: from DM5PR1201MB0090.namprd12.prod.outlook.com (10.174.105.140) by
 DM5PR1201MB2536.namprd12.prod.outlook.com (10.172.90.140) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2623.8; Fri, 10 Jan 2020 23:08:43 +0000
Received: from DM5PR1201MB0090.namprd12.prod.outlook.com
 ([fe80::7119:ff0:b3eb:619c]) by DM5PR1201MB0090.namprd12.prod.outlook.com
 ([fe80::7119:ff0:b3eb:619c%4]) with mapi id 15.20.2623.014; Fri, 10 Jan 2020
 23:08:43 +0000
Subject: Re: [PATCH 4/5] drm/amdkfd: use map_queues for hiq on gfx v10 as well
To: Huang Rui <ray.huang@amd.com>, amd-gfx@lists.freedesktop.org
References: <1578638233-9357-1-git-send-email-ray.huang@amd.com>
 <1578638233-9357-4-git-send-email-ray.huang@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
Message-ID: <7eaa7a0c-1008-b869-33cb-42f7418ed91e@amd.com>
Date: Fri, 10 Jan 2020 18:08:42 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
In-Reply-To: <1578638233-9357-4-git-send-email-ray.huang@amd.com>
Content-Language: en-US
X-ClientProxiedBy: YTOPR0101CA0045.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:14::22) To DM5PR1201MB0090.namprd12.prod.outlook.com
 (2603:10b6:4:53::12)
MIME-Version: 1.0
Received: from [172.27.226.80] (165.204.55.251) by
 YTOPR0101CA0045.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:14::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2623.9 via Frontend
 Transport; Fri, 10 Jan 2020 23:08:42 +0000
X-Originating-IP: [165.204.55.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 01cc1667-56d6-4b50-e7ed-08d79622099c
X-MS-TrafficTypeDiagnostic: DM5PR1201MB2536:|DM5PR1201MB2536:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR1201MB2536DB532A48DBB7EE2197BE92380@DM5PR1201MB2536.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:31;
X-Forefront-PRVS: 02788FF38E
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(39860400002)(366004)(376002)(346002)(136003)(396003)(51234002)(199004)(189003)(316002)(31696002)(186003)(4326008)(53546011)(8676002)(36756003)(2906002)(2616005)(5660300002)(26005)(44832011)(478600001)(16576012)(6486002)(31686004)(52116002)(81156014)(36916002)(8936002)(16526019)(66556008)(81166006)(66946007)(66476007)(956004)(86362001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM5PR1201MB2536;
 H:DM5PR1201MB0090.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LHlElgcec9w26I5KP+YzJc/BG4KGTv4t9vUrFO0wOhRONRPMYnFgZnDnDM+yup6Rugb68O80J135Tm4yAoQemDJTUWoN9bQQNr4cjk0IRKk3/PQBPDzUyTGkHQb67UrkLR//zJYI63q6z66ScxjTiNvkfMRgsgz1aC+ba7uJBtA7O+yv2KW7kXloV4Pnq4MkUHva6P7VpyhZWNzjK5goPMTwjJeyBurweOXjQizdYb9UXvO0WTcFAqBNiWsHRfg7T8KwuqXTlhTY6lTtQJss3X+wTv5VPnHmzK8cJyWhrobCR/ltgHFFsiys6l6B84xY3ZVN/+fW1tuykiEK4tAXReJD+55G5WujZSphr4cz1Dw4B6c/bTzZ6jnHdEekhKtLa+jGGP+Bz09AiybIj4c/+YLGHSQeZY+d/lBVP66pOLIH7S96xh9MxxMCnrotTRbiLPvfXQjiexr79gD75GdtmZc8tnufJNoOOC6L2RuhF1vWhNNankg1iK4I7kPkTcGr
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 01cc1667-56d6-4b50-e7ed-08d79622099c
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2020 23:08:43.2406 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dzT27RqN/mzA03eOzYqV62x9TbfUkPBUL6gmfMfPMqS2n3iQMNbM853LnGXh+PYBJVmWu7Bdso7k+YIU2PkqUg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB2536
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
Cc: Alex Deucher <alexander.deucher@amd.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 2020-01-10 1:37 a.m., Huang Rui wrote:
> To align with gfx v9, we use the map_queues packet to load hiq MQD.
>
> Signed-off-by: Huang Rui <ray.huang@amd.com>

Please make sure you test this on a GFXv10 GPU.

Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>


> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.c | 82 ++++++++++++++++------
>   drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v10.c   | 10 ++-
>   2 files changed, 70 insertions(+), 22 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.c
> index 61cd707..2a60f73 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.c
> @@ -107,13 +107,13 @@ static void acquire_queue(struct kgd_dev *kgd, uint32_t pipe_id,
>   	lock_srbm(kgd, mec, pipe, queue_id, 0);
>   }
>   
> -static uint32_t get_queue_mask(struct amdgpu_device *adev,
> +static uint64_t get_queue_mask(struct amdgpu_device *adev,
>   			       uint32_t pipe_id, uint32_t queue_id)
>   {
> -	unsigned int bit = (pipe_id * adev->gfx.mec.num_queue_per_pipe +
> -			    queue_id) & 31;
> +	unsigned int bit = pipe_id * adev->gfx.mec.num_queue_per_pipe +
> +			queue_id;
>   
> -	return ((uint32_t)1) << bit;
> +	return 1ull << bit;
>   }
>   
>   static void release_queue(struct kgd_dev *kgd)
> @@ -268,21 +268,6 @@ static int kgd_hqd_load(struct kgd_dev *kgd, void *mqd, uint32_t pipe_id,
>   	pr_debug("Load hqd of pipe %d queue %d\n", pipe_id, queue_id);
>   	acquire_queue(kgd, pipe_id, queue_id);
>   
> -	/* HIQ is set during driver init period with vmid set to 0*/
> -	if (m->cp_hqd_vmid == 0) {
> -		uint32_t value, mec, pipe;
> -
> -		mec = (pipe_id / adev->gfx.mec.num_pipe_per_mec) + 1;
> -		pipe = (pipe_id % adev->gfx.mec.num_pipe_per_mec);
> -
> -		pr_debug("kfd: set HIQ, mec:%d, pipe:%d, queue:%d.\n",
> -			mec, pipe, queue_id);
> -		value = RREG32(SOC15_REG_OFFSET(GC, 0, mmRLC_CP_SCHEDULERS));
> -		value = REG_SET_FIELD(value, RLC_CP_SCHEDULERS, scheduler1,
> -			((mec << 5) | (pipe << 3) | queue_id | 0x80));
> -		WREG32(SOC15_REG_OFFSET(GC, 0, mmRLC_CP_SCHEDULERS), value);
> -	}
> -
>   	/* HQD registers extend from CP_MQD_BASE_ADDR to CP_HQD_EOP_WPTR_MEM. */
>   	mqd_hqd = &m->cp_mqd_base_addr_lo;
>   	hqd_base = SOC15_REG_OFFSET(GC, 0, mmCP_MQD_BASE_ADDR);
> @@ -332,9 +317,10 @@ static int kgd_hqd_load(struct kgd_dev *kgd, void *mqd, uint32_t pipe_id,
>   		       lower_32_bits((uint64_t)wptr));
>   		WREG32(SOC15_REG_OFFSET(GC, 0, mmCP_HQD_PQ_WPTR_POLL_ADDR_HI),
>   		       upper_32_bits((uint64_t)wptr));
> -		pr_debug("%s setting CP_PQ_WPTR_POLL_CNTL1 to %x\n", __func__, get_queue_mask(adev, pipe_id, queue_id));
> +		pr_debug("%s setting CP_PQ_WPTR_POLL_CNTL1 to %x\n", __func__,
> +			 (uint32_t)get_queue_mask(adev, pipe_id, queue_id));
>   		WREG32(SOC15_REG_OFFSET(GC, 0, mmCP_PQ_WPTR_POLL_CNTL1),
> -		       get_queue_mask(adev, pipe_id, queue_id));
> +		       (uint32_t)get_queue_mask(adev, pipe_id, queue_id));
>   	}
>   
>   	/* Start the EOP fetcher */
> @@ -350,6 +336,59 @@ static int kgd_hqd_load(struct kgd_dev *kgd, void *mqd, uint32_t pipe_id,
>   	return 0;
>   }
>   
> +static int kgd_hiq_mqd_load(struct kgd_dev *kgd, void *mqd,
> +			    uint32_t pipe_id, uint32_t queue_id,
> +			    uint32_t doorbell_off)
> +{
> +	struct amdgpu_device *adev = get_amdgpu_device(kgd);
> +	struct amdgpu_ring *kiq_ring = &adev->gfx.kiq.ring;
> +	struct v10_compute_mqd *m;
> +	uint32_t mec, pipe;
> +	int r;
> +
> +	m = get_mqd(mqd);
> +
> +	acquire_queue(kgd, pipe_id, queue_id);
> +
> +	mec = (pipe_id / adev->gfx.mec.num_pipe_per_mec) + 1;
> +	pipe = (pipe_id % adev->gfx.mec.num_pipe_per_mec);
> +
> +	pr_debug("kfd: set HIQ, mec:%d, pipe:%d, queue:%d.\n",
> +		 mec, pipe, queue_id);
> +
> +	spin_lock(&adev->gfx.kiq.ring_lock);
> +	r = amdgpu_ring_alloc(kiq_ring, 7);
> +	if (r) {
> +		pr_err("Failed to alloc KIQ (%d).\n", r);
> +		goto out_unlock;
> +	}
> +
> +	amdgpu_ring_write(kiq_ring, PACKET3(PACKET3_MAP_QUEUES, 5));
> +	amdgpu_ring_write(kiq_ring,
> +			  PACKET3_MAP_QUEUES_QUEUE_SEL(0) | /* Queue_Sel */
> +			  PACKET3_MAP_QUEUES_VMID(m->cp_hqd_vmid) | /* VMID */
> +			  PACKET3_MAP_QUEUES_QUEUE(queue_id) |
> +			  PACKET3_MAP_QUEUES_PIPE(pipe) |
> +			  PACKET3_MAP_QUEUES_ME((mec - 1)) |
> +			  PACKET3_MAP_QUEUES_QUEUE_TYPE(0) | /*queue_type: normal compute queue */
> +			  PACKET3_MAP_QUEUES_ALLOC_FORMAT(0) | /* alloc format: all_on_one_pipe */
> +			  PACKET3_MAP_QUEUES_ENGINE_SEL(1) | /* engine_sel: hiq */
> +			  PACKET3_MAP_QUEUES_NUM_QUEUES(1)); /* num_queues: must be 1 */
> +	amdgpu_ring_write(kiq_ring,
> +			  PACKET3_MAP_QUEUES_DOORBELL_OFFSET(doorbell_off));
> +	amdgpu_ring_write(kiq_ring, m->cp_mqd_base_addr_lo);
> +	amdgpu_ring_write(kiq_ring, m->cp_mqd_base_addr_hi);
> +	amdgpu_ring_write(kiq_ring, m->cp_hqd_pq_wptr_poll_addr_lo);
> +	amdgpu_ring_write(kiq_ring, m->cp_hqd_pq_wptr_poll_addr_hi);
> +	amdgpu_ring_commit(kiq_ring);
> +
> +out_unlock:
> +	spin_unlock(&adev->gfx.kiq.ring_lock);
> +	release_queue(kgd);
> +
> +	return r;
> +}
> +
>   static int kgd_hqd_dump(struct kgd_dev *kgd,
>   			uint32_t pipe_id, uint32_t queue_id,
>   			uint32_t (**dump)[2], uint32_t *n_regs)
> @@ -817,6 +856,7 @@ const struct kfd2kgd_calls gfx_v10_kfd2kgd = {
>   	.set_pasid_vmid_mapping = kgd_set_pasid_vmid_mapping,
>   	.init_interrupts = kgd_init_interrupts,
>   	.hqd_load = kgd_hqd_load,
> +	.hiq_mqd_load = kgd_hiq_mqd_load,
>   	.hqd_sdma_load = kgd_hqd_sdma_load,
>   	.hqd_dump = kgd_hqd_dump,
>   	.hqd_sdma_dump = kgd_hqd_sdma_dump,
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v10.c b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v10.c
> index 7832ec6..d1d68a5 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v10.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v10.c
> @@ -153,6 +153,14 @@ static int load_mqd(struct mqd_manager *mm, void *mqd,
>   	return r;
>   }
>   
> +static int hiq_load_mqd_kiq(struct mqd_manager *mm, void *mqd,
> +			    uint32_t pipe_id, uint32_t queue_id,
> +			    struct queue_properties *p, struct mm_struct *mms)
> +{
> +	return mm->dev->kfd2kgd->hiq_mqd_load(mm->dev->kgd, mqd, pipe_id,
> +					      queue_id, p->doorbell_off);
> +}
> +
>   static void update_mqd(struct mqd_manager *mm, void *mqd,
>   		      struct queue_properties *q)
>   {
> @@ -409,7 +417,7 @@ struct mqd_manager *mqd_manager_init_v10(enum KFD_MQD_TYPE type,
>   		mqd->allocate_mqd = allocate_hiq_mqd;
>   		mqd->init_mqd = init_mqd_hiq;
>   		mqd->free_mqd = free_mqd_hiq_sdma;
> -		mqd->load_mqd = load_mqd;
> +		mqd->load_mqd = hiq_load_mqd_kiq;
>   		mqd->update_mqd = update_mqd;
>   		mqd->destroy_mqd = destroy_mqd;
>   		mqd->is_occupied = is_occupied;
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
