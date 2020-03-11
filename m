Return-Path: <SRS0=Izb8=44=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D76DDC0044D
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Mar 2020 20:14:11 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C4D8E20739
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Mar 2020 20:14:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="w6YiaqBb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C4D8E20739
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 349856E9F7;
	Wed, 11 Mar 2020 20:14:11 +0000 (UTC)
Received: from NAM04-CO1-obe.outbound.protection.outlook.com
 (mail-eopbgr690077.outbound.protection.outlook.com [40.107.69.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7D6606E9F7
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 Mar 2020 20:14:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DzehIjvVPCrfWE6aLd3ZxJaH4TdDoKTeormkxdxvbJzaMtqxrEY4iFNrvFeQKZFnKhhX5S8Y/BaK65giCONwfSB3EMeeuBLGXBM4JHQBvI0iov4m8txUVeMY6BxZg/veOqSXTbpVsj8/OB7T8VxgkUEpWURHWbPxssJLAKOZLOeOes1cCfwHqLGLuyaU+PAiSZCALKmn8VHzfacMx3C6X16fT0l1ueTUuHIH+GdWv5WR1peMeA8YqtmTZ28cjxiKKmNnVxP+RvLTFK4bJYrha+fgnw2lSFr+hLHk4sn0EDMAO4oZ+EzLMaOK3u7Kxj6XHhKW+rEJgTmZP5+zJVhYjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=efN/JSH7tcYZIC7YHWd8iXFtXnjmWPjUEGG6citNnc8=;
 b=T2QGuzJaLUZ4gPDUQXcmcP9dqYkU9m1nXaCR9Kw9L8TGpzX0szLXgXoig8iWC6mnJuMdwHf6MK6jIDi+Ex5lP4DDcONG90X3jNMWmxIHnyrcweICk4/X0d6Tgt+9K1+BQaQpOx6g87IRp88GghvoUfmr9Sd3zqFw9VA28vrOdx/gLNb8Pc3x8NBgxCr6oWyRZQ9uFRfaWVExdPHHyhDs+lxR2GHQxC0M3uOwUE5YtZZsT+xCHkNzt8z2x4reHn0fB3W58PIWEySWnHHSKHZbnqiExOES3DCZJsejzzLGl6qKh1+0RgOB0KNeTYBIpUtvAlLZ7/zC18vij45qEQLQuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=efN/JSH7tcYZIC7YHWd8iXFtXnjmWPjUEGG6citNnc8=;
 b=w6YiaqBbQQzn+80MA5SxLGrbaYH9gQW3vxwAT4pYFPfeYsn7Km6I0WXhqADWmxoNNA8uRKxUMeP2UUH0QwrIc/ic87CDDn69DOQsrCc6pHEx7ROFZ/x3FWpKZI+8BSd/KWsY60vq5sVYzT/hyIFEKJWLWc0D9e3Vnq4bT4mduKY=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=James.Zhu@amd.com; 
Received: from BYAPR12MB3285.namprd12.prod.outlook.com (2603:10b6:a03:134::14)
 by BYAPR12MB3030.namprd12.prod.outlook.com (2603:10b6:a03:ae::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2793.15; Wed, 11 Mar
 2020 20:14:09 +0000
Received: from BYAPR12MB3285.namprd12.prod.outlook.com
 ([fe80::7827:1c37:4c53:b74b]) by BYAPR12MB3285.namprd12.prod.outlook.com
 ([fe80::7827:1c37:4c53:b74b%7]) with mapi id 15.20.2793.018; Wed, 11 Mar 2020
 20:14:09 +0000
Subject: Re: [PATCH 1/1] drm/amdgpu: disable gpu_sched load balancer for vcn
 jobs
To: 20200311195759.49332-1-nirmoy.das@amd.com, amd-gfx@lists.freedesktop.org
References: <20200311200032.50502-1-nirmoy.das@amd.com>
From: James Zhu <jamesz@amd.com>
Organization: AMD RTG
Message-ID: <1f915a39-947b-bd06-7db0-8d748095fb52@amd.com>
Date: Wed, 11 Mar 2020 16:14:06 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
In-Reply-To: <20200311200032.50502-1-nirmoy.das@amd.com>
Content-Language: en-US
X-ClientProxiedBy: YT1PR01CA0026.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01::39)
 To BYAPR12MB3285.namprd12.prod.outlook.com
 (2603:10b6:a03:134::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.27.233.155] (165.204.55.251) by
 YT1PR01CA0026.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01::39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2793.15 via Frontend Transport; Wed, 11 Mar 2020 20:14:08 +0000
X-Originating-IP: [165.204.55.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 4fa67aa5-3edb-4e48-b041-08d7c5f8c1bb
X-MS-TrafficTypeDiagnostic: BYAPR12MB3030:|BYAPR12MB3030:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR12MB3030CA803C23E9D9DCA79C31E4FC0@BYAPR12MB3030.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:115;
X-Forefront-PRVS: 0339F89554
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(136003)(396003)(366004)(346002)(39860400002)(376002)(199004)(316002)(8936002)(81166006)(16576012)(6486002)(53546011)(36916002)(81156014)(31686004)(52116002)(478600001)(5660300002)(8676002)(4326008)(186003)(66946007)(956004)(66476007)(36756003)(2906002)(66556008)(2616005)(16526019)(26005)(31696002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:BYAPR12MB3030;
 H:BYAPR12MB3285.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PJ5RfpTbTAE7u8ezj1qWcIb5/2RLk9Jh+xQucj5KtNgJ/nS1Bx8YKPPbdCXJQ0sib9z4Upe6cH9fFldw5r45mXCDt5VA6Uyk6Z1lRoVb0KUdYjxOLLYXw0V3ncEo8qaEDszGLISKw3RiA6kHjAAPbjuMoZxNqKcAACRMEorGczBxcz8ijyMTEydfYESRcacqO1CktLAns7Or77Id4+kIdLArWTGtsyUaZtrPkDv+sq++vwaBgj2zMkff5BJo8Q0hC/Go7Q4br2KmPkiSCygKJB4U8f+tsEqjUfWePJKRZqnqEHjf3uYt2NqoPfVe7BhLGz2l3gVUlvQHYFdq5GjWmRnh5B1aDutHPWen8F1CzAiUhe0s1F3TYhvA/SThux2iqNs17n+Js4wQNdl5VklgUtd/NnljKZkol/FzYytAW46ItdB8YNEEG7+C+T5KR4v6
X-MS-Exchange-AntiSpam-MessageData: EGwIizvbCzNFGICRSJ+6Q8+XhmEtp23TrGBb5pHK0lCeZ+ZxKa1xBMv48jem9WARXjYHZbtaa4lsODMoPAk0FB5+GCirbGLfrtG6tQQ3nu4QOUyFVwGnmZbUkZXFTNycG+wkLjafNyYhdfr5d5f8Pw==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4fa67aa5-3edb-4e48-b041-08d7c5f8c1bb
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2020 20:14:09.2456 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2/kAilC5RyOpvvVD04rfizXRvW9//UK+rWhT+DNACYoyFiUuwiLrxRqJyBUxN8kJ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3030
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
Cc: Boyuan.Zhang@amd.com, nirmoy.das@amd.com, alexander.deucher@amd.com,
 James.Zhu@amd.com, Leo.Liu@amd.com, christian.koenig@amd.com
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>


On 2020-03-11 4:00 p.m., Nirmoy Das wrote:
> VCN HW  doesn't support dynamic load balance on multiple
> instances for a context. This patch modifies entity's
> sched_list to a sched_list consist of only one drm scheduler.
>
> Signed-off-by: Nirmoy Das <nirmoy.das@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c   |  4 ++++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c  | 13 +++++++++++++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.h  |  1 +
>   drivers/gpu/drm/amd/amdgpu/amdgpu_job.c  |  3 +++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h |  1 +
>   drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c    |  2 ++
>   drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c    |  2 ++
>   drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c    |  2 ++
>   8 files changed, 28 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> index 8304d0c87899..db0eef19c636 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> @@ -1203,6 +1203,7 @@ static int amdgpu_cs_submit(struct amdgpu_cs_parser *p,
>   			    union drm_amdgpu_cs *cs)
>   {
>   	struct amdgpu_fpriv *fpriv = p->filp->driver_priv;
> +	struct amdgpu_ring *ring = to_amdgpu_ring(p->entity->rq->sched);
>   	struct drm_sched_entity *entity = p->entity;
>   	enum drm_sched_priority priority;
>   	struct amdgpu_bo_list_entry *e;
> @@ -1257,6 +1258,9 @@ static int amdgpu_cs_submit(struct amdgpu_cs_parser *p,
>   	priority = job->base.s_priority;
>   	drm_sched_entity_push_job(&job->base, entity);
>   
> +	if (ring->funcs->no_gpu_sched_loadbalance)
> +		amdgpu_ctx_disable_gpu_sched_load_balance(entity);

Does this mean that only vcn IP instances 0 dec/enc will be scheduled?

Best Regards!

James

> +
>   	amdgpu_vm_move_to_lru_tail(p->adev, &fpriv->vm);
>   
>   	ttm_eu_fence_buffer_objects(&p->ticket, &p->validated, p->fence);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
> index fa575bdc03c8..1127e8f77721 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
> @@ -559,6 +559,19 @@ void amdgpu_ctx_priority_override(struct amdgpu_ctx *ctx,
>   	}
>   }
>   
> +/**
> + * amdgpu_ctx_disable_gpu_sched_load_balance - disable gpu_sched's load balancer
> + * @entity: entity on which load balancer will be disabled
> + */
> +void amdgpu_ctx_disable_gpu_sched_load_balance(struct drm_sched_entity *entity)
> +{
> +	struct drm_gpu_scheduler **scheds = &entity->rq->sched;
> +
> +	/* disable gpu_sched's job load balancer by assigning only one */
> +	/* drm scheduler to the entity */
> +	drm_sched_entity_modify_sched(entity, scheds, 1);
> +}
> +
>   int amdgpu_ctx_wait_prev_fence(struct amdgpu_ctx *ctx,
>   			       struct drm_sched_entity *entity)
>   {
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.h
> index de490f183af2..3a2f900b8000 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.h
> @@ -90,5 +90,6 @@ void amdgpu_ctx_mgr_fini(struct amdgpu_ctx_mgr *mgr);
>   
>   void amdgpu_ctx_init_sched(struct amdgpu_device *adev);
>   
> +void amdgpu_ctx_disable_gpu_sched_load_balance(struct drm_sched_entity *entity);
>   
>   #endif
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
> index 4981e443a884..64dad7ba74da 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
> @@ -140,6 +140,7 @@ void amdgpu_job_free(struct amdgpu_job *job)
>   int amdgpu_job_submit(struct amdgpu_job *job, struct drm_sched_entity *entity,
>   		      void *owner, struct dma_fence **f)
>   {
> +	struct amdgpu_ring *ring = to_amdgpu_ring(entity->rq->sched);
>   	enum drm_sched_priority priority;
>   	int r;
>   
> @@ -154,6 +155,8 @@ int amdgpu_job_submit(struct amdgpu_job *job, struct drm_sched_entity *entity,
>   	amdgpu_job_free_resources(job);
>   	priority = job->base.s_priority;
>   	drm_sched_entity_push_job(&job->base, entity);
> +	if (ring->funcs->no_gpu_sched_loadbalance)
> +		amdgpu_ctx_disable_gpu_sched_load_balance(entity);
>   
>   	return 0;
>   }
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> index 448c76cbf3ed..f78fe1a6912b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> @@ -115,6 +115,7 @@ struct amdgpu_ring_funcs {
>   	u32			nop;
>   	bool			support_64bit_ptrs;
>   	bool			no_user_fence;
> +	bool			no_gpu_sched_loadbalance;
>   	unsigned		vmhub;
>   	unsigned		extra_dw;
>   
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
> index 71f61afdc655..749ccdb5fbfb 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
> @@ -1871,6 +1871,7 @@ static const struct amdgpu_ring_funcs vcn_v1_0_dec_ring_vm_funcs = {
>   	.align_mask = 0xf,
>   	.support_64bit_ptrs = false,
>   	.no_user_fence = true,
> +	.no_gpu_sched_loadbalance = true,
>   	.vmhub = AMDGPU_MMHUB_0,
>   	.get_rptr = vcn_v1_0_dec_ring_get_rptr,
>   	.get_wptr = vcn_v1_0_dec_ring_get_wptr,
> @@ -1905,6 +1906,7 @@ static const struct amdgpu_ring_funcs vcn_v1_0_enc_ring_vm_funcs = {
>   	.nop = VCN_ENC_CMD_NO_OP,
>   	.support_64bit_ptrs = false,
>   	.no_user_fence = true,
> +	.no_gpu_sched_loadbalance = true,
>   	.vmhub = AMDGPU_MMHUB_0,
>   	.get_rptr = vcn_v1_0_enc_ring_get_rptr,
>   	.get_wptr = vcn_v1_0_enc_ring_get_wptr,
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
> index f2745fd1ddb3..c48423b54bc5 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
> @@ -1954,6 +1954,7 @@ static const struct amd_ip_funcs vcn_v2_0_ip_funcs = {
>   static const struct amdgpu_ring_funcs vcn_v2_0_dec_ring_vm_funcs = {
>   	.type = AMDGPU_RING_TYPE_VCN_DEC,
>   	.align_mask = 0xf,
> +	.no_gpu_sched_loadbalance = true,
>   	.vmhub = AMDGPU_MMHUB_0,
>   	.get_rptr = vcn_v2_0_dec_ring_get_rptr,
>   	.get_wptr = vcn_v2_0_dec_ring_get_wptr,
> @@ -1984,6 +1985,7 @@ static const struct amdgpu_ring_funcs vcn_v2_0_dec_ring_vm_funcs = {
>   static const struct amdgpu_ring_funcs vcn_v2_0_enc_ring_vm_funcs = {
>   	.type = AMDGPU_RING_TYPE_VCN_ENC,
>   	.align_mask = 0x3f,
> +	.no_gpu_sched_loadbalance = true,
>   	.nop = VCN_ENC_CMD_NO_OP,
>   	.vmhub = AMDGPU_MMHUB_0,
>   	.get_rptr = vcn_v2_0_enc_ring_get_rptr,
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
> index 9b22e2b55132..1cc8e1420fc8 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
> @@ -1478,6 +1478,7 @@ static void vcn_v2_5_dec_ring_set_wptr(struct amdgpu_ring *ring)
>   static const struct amdgpu_ring_funcs vcn_v2_5_dec_ring_vm_funcs = {
>   	.type = AMDGPU_RING_TYPE_VCN_DEC,
>   	.align_mask = 0xf,
> +	.no_gpu_sched_loadbalance = true,
>   	.vmhub = AMDGPU_MMHUB_1,
>   	.get_rptr = vcn_v2_5_dec_ring_get_rptr,
>   	.get_wptr = vcn_v2_5_dec_ring_get_wptr,
> @@ -1577,6 +1578,7 @@ static void vcn_v2_5_enc_ring_set_wptr(struct amdgpu_ring *ring)
>   static const struct amdgpu_ring_funcs vcn_v2_5_enc_ring_vm_funcs = {
>   	.type = AMDGPU_RING_TYPE_VCN_ENC,
>   	.align_mask = 0x3f,
> +	.no_gpu_sched_loadbalance = true,
>   	.nop = VCN_ENC_CMD_NO_OP,
>   	.vmhub = AMDGPU_MMHUB_1,
>   	.get_rptr = vcn_v2_5_enc_ring_get_rptr,
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
