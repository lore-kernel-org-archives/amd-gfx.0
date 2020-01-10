Return-Path: <SRS0=i8pd=27=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70272C282DD
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Jan 2020 23:09:17 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 41CCF20721
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Jan 2020 23:09:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="O4nQasJ7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 41CCF20721
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EDBD86E138;
	Fri, 10 Jan 2020 23:09:16 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2076.outbound.protection.outlook.com [40.107.237.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ED2D86E117
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Jan 2020 23:09:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ye629Vw4hBj0/yVTpus5qKWh5Nan4EKWhKuCH54+o7qIpkrZ9jgqPsEpi2/7zcbMGG0x2fcbz1Tp4mWlT+I/iXAIg3QXiCaRiGS5RSntkdNN2dE/RfVnHP/zts4x9qZKKnDQxPa6Ii56hvN6Is+XR8rlAP9qQ48MnaRkRU7EKis5/lice2vsmDLMxYGwW3HernimboYcX4pSubfSrE+pkILP0Fbyhud4Rucw157DtXsvS/yJuA1PO96AsBmuZLzkTQFxhgLDiUcpLpiBMVZsTcdfFxTbDqV+sph0Z7BnB5q4sbpSFqbP4yxUK3exPyRs44TBp5CdhJdWMqVxhVmqRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TQ8QYXg3PMDGG3Vg2mM1uh4qwh+6jz4GyFpiBMLn8+w=;
 b=oRqVOyY32TFu4NcVaBtxNXZzTe1KmVG7W4BFKF5dOuQ4XYBnJsvxtpZjR+hzJqGXuJXUOAiK94yG2Bdh/m0NFp9b89+ijw9R5x+UPboL92GOhImXqrZHVjkMIp4uDNNLst7UqYfnAazfyHz1bgnHR7LN8QngHks99gds4349NewrXZaGAKkaEnD1kWxcgHI3ZhVQyWs8mLanDEPBMPkD5zDLAEUksjkjLCzXLIz32VzioKecG80H3wv6cZwf5v9aQkeFR+DPkVvEKEZ+fKkXLxjEWByU/U7asHlIpJaPsXkh1Fhc4RCjoTMu4oy2TB+kypxrDSuVc8leIKEuVvvkZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TQ8QYXg3PMDGG3Vg2mM1uh4qwh+6jz4GyFpiBMLn8+w=;
 b=O4nQasJ7yAHuFOSKDVjh3azABt5nONmXmSfeDrEKYfHdupwmL51nmibR/NYlLwUdO4iftlXCsNeCGlxN5A8zybDK5r2hjvnnlusPLMmiiDHZ8/Cg7JsLq8xEs5npDiqqUKyaWL+/99IMtxCwsxZdHZahrgjqoV7u2R8VrA7b8vA=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Felix.Kuehling@amd.com; 
Received: from DM5PR1201MB0090.namprd12.prod.outlook.com (10.174.105.140) by
 DM5PR1201MB2536.namprd12.prod.outlook.com (10.172.90.140) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2623.8; Fri, 10 Jan 2020 23:09:13 +0000
Received: from DM5PR1201MB0090.namprd12.prod.outlook.com
 ([fe80::7119:ff0:b3eb:619c]) by DM5PR1201MB0090.namprd12.prod.outlook.com
 ([fe80::7119:ff0:b3eb:619c%4]) with mapi id 15.20.2623.014; Fri, 10 Jan 2020
 23:09:13 +0000
Subject: Re: [PATCH 5/5] drm/amdkfd: use map_queues for hiq on gfx v8 as well
To: Huang Rui <ray.huang@amd.com>, amd-gfx@lists.freedesktop.org
References: <1578638233-9357-1-git-send-email-ray.huang@amd.com>
 <1578638233-9357-5-git-send-email-ray.huang@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
Message-ID: <eab82daa-7333-7d03-3d6b-1185b5f36db3@amd.com>
Date: Fri, 10 Jan 2020 18:09:12 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
In-Reply-To: <1578638233-9357-5-git-send-email-ray.huang@amd.com>
Content-Language: en-US
X-ClientProxiedBy: YTOPR0101CA0066.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:14::43) To DM5PR1201MB0090.namprd12.prod.outlook.com
 (2603:10b6:4:53::12)
MIME-Version: 1.0
Received: from [172.27.226.80] (165.204.55.251) by
 YTOPR0101CA0066.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:14::43) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2623.10 via Frontend
 Transport; Fri, 10 Jan 2020 23:09:13 +0000
X-Originating-IP: [165.204.55.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 6e8af1f4-411c-4754-73e3-08d796221baf
X-MS-TrafficTypeDiagnostic: DM5PR1201MB2536:|DM5PR1201MB2536:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR1201MB253652F55920764A7D7E46B792380@DM5PR1201MB2536.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:81;
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
X-Microsoft-Antispam-Message-Info: Z/+J290lmHGkEYHtHy7BsFTj1P5O1YNqb1vokTrfmZLmLNGckgHSEfDYtoCbUVG7JwFQPu2mlLfKf/Kzi5N18vjwC4XmB0uf2DdWBsSs+zHRIM/t3w0IAELaPIxAbdZr+jfH8t5J3XHXJmqUlgf57K3b8CiapEc/UcWwpaN6SVLN+ZmjDgaOK+HH5VvkPkQLCrRwl18UoUpZxGcPPMjFhf8X1yG2e7JOi6b/8yKzk/SuI1O1exEA3WzO84wP7GHrBpvH6LQp31vLQV/EZhDXJP7G4nNj5FYYawYIiZuz7uD9oQ7eGIjHZfFJhzZ30DTCl690jF3a4W4iUyvnt0r0EbJV2oNdFzppNHel45+CExaiHfc3N7fjc/zOH6XROMZOZMqonYfb+Ef0o+wN0TDqPLa6UgC6LZVyAV9ICnHoxq+AU2C+z1u0rqC8lvxuQjcm/WNEfYZavcydpvAfdCoPOFnYchG7NXOF2DcEHrglQjdKawSCs+rcr0hGlNtaczzJ
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e8af1f4-411c-4754-73e3-08d796221baf
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2020 23:09:13.5361 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SPac2LWnq2LtC1mLTdKaw8LvhrmvzXB5aXskMJEwKLKLCs4eYOBNFqWRJHQYSfiLoMZZforo47ggSFscxstkJw==
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
> Align with gfx v9, use map_queues packet to load hiq MQD.
>
> Signed-off-by: Huang Rui <ray.huang@amd.com>
Please make sure you test this on a GFXv8 GPU.

Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>


> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v8.c | 69 ++++++++++++++++++-----
>   drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_vi.c   | 10 +++-
>   2 files changed, 63 insertions(+), 16 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v8.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v8.c
> index bfbdded..6adac95 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v8.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v8.c
> @@ -207,21 +207,6 @@ static int kgd_hqd_load(struct kgd_dev *kgd, void *mqd, uint32_t pipe_id,
>   
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
> -		value = RREG32(mmRLC_CP_SCHEDULERS);
> -		value = REG_SET_FIELD(value, RLC_CP_SCHEDULERS, scheduler1,
> -			((mec << 5) | (pipe << 3) | queue_id | 0x80));
> -		WREG32(mmRLC_CP_SCHEDULERS, value);
> -	}
> -
>   	/* HQD registers extend from CP_MQD_BASE_ADDR to CP_HQD_EOP_WPTR_MEM. */
>   	mqd_hqd = &m->cp_mqd_base_addr_lo;
>   
> @@ -267,6 +252,59 @@ static int kgd_hqd_load(struct kgd_dev *kgd, void *mqd, uint32_t pipe_id,
>   	return 0;
>   }
>   
> +static int kgd_hiq_mqd_load(struct kgd_dev *kgd, void *mqd,
> +			    uint32_t pipe_id, uint32_t queue_id,
> +			    uint32_t doorbell_off)
> +{
> +	struct amdgpu_device *adev = get_amdgpu_device(kgd);
> +	struct amdgpu_ring *kiq_ring = &adev->gfx.kiq.ring;
> +	struct vi_mqd *m;
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
> @@ -701,6 +739,7 @@ const struct kfd2kgd_calls gfx_v8_kfd2kgd = {
>   	.set_pasid_vmid_mapping = kgd_set_pasid_vmid_mapping,
>   	.init_interrupts = kgd_init_interrupts,
>   	.hqd_load = kgd_hqd_load,
> +	.hiq_mqd_load = kgd_hiq_mqd_load,
>   	.hqd_sdma_load = kgd_hqd_sdma_load,
>   	.hqd_dump = kgd_hqd_dump,
>   	.hqd_sdma_dump = kgd_hqd_sdma_dump,
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_vi.c b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_vi.c
> index a5e8ff1..15cbfd4 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_vi.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_vi.c
> @@ -166,6 +166,14 @@ static int load_mqd(struct mqd_manager *mm, void *mqd,
>   					  wptr_shift, wptr_mask, mms);
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
>   static void __update_mqd(struct mqd_manager *mm, void *mqd,
>   			struct queue_properties *q, unsigned int mtype,
>   			unsigned int atc_bit)
> @@ -438,7 +446,7 @@ struct mqd_manager *mqd_manager_init_vi(enum KFD_MQD_TYPE type,
>   		mqd->allocate_mqd = allocate_hiq_mqd;
>   		mqd->init_mqd = init_mqd_hiq;
>   		mqd->free_mqd = free_mqd_hiq_sdma;
> -		mqd->load_mqd = load_mqd;
> +		mqd->load_mqd = hiq_load_mqd_kiq;
>   		mqd->update_mqd = update_mqd_hiq;
>   		mqd->destroy_mqd = destroy_mqd;
>   		mqd->is_occupied = is_occupied;
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
