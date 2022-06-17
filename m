Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81431C43334
	for <amd-gfx@archiver.kernel.org>; Fri, 17 Jun 2022 06:34:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C5BD31125D8;
	Fri, 17 Jun 2022 06:34:30 +0000 (UTC)
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com
 [IPv6:2a00:1450:4864:20::62f])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5159A1125D8
 for <amd-gfx@lists.freedesktop.org>; Fri, 17 Jun 2022 06:34:29 +0000 (UTC)
Received: by mail-ej1-x62f.google.com with SMTP id me5so6917251ejb.2
 for <amd-gfx@lists.freedesktop.org>; Thu, 16 Jun 2022 23:34:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=message-id:date:mime-version:user-agent:subject:content-language:to
 :cc:references:from:in-reply-to:content-transfer-encoding;
 bh=y8BD+9XpQ+UzeK9v5ILr+QXZP/hmi4FdwshIuFa/7vg=;
 b=YDQAja7F42Ujcevhh3sl7pRgPlu9o8oSEvDzZ5JqcI8EKsXA+hxsnkHPkWYnjZPFAN
 kwF3xrl9r7doNpT/h2quzUpt2mR/IwxshjGrZwY/mFdkpGUVJTAPb05t4Ab4rm7yObZS
 KyLTroKa7mDVHtdZQqs6+3uKqw7jeBQxj3rZxnyzE3wmmf02xHCn524WOFVxVdg/fR/W
 AToil2x6nrh0Z5HLtx6gzz25h3Jy8Kz8GMEku6CmuOq6M0acYFnjdZtiQKJkozhmY/Fx
 D8UWgH8+JWr9DN5uVxiDmQ6zTINHwAZV8nS4Vyl6vgcUKmXkcQeg6e08ye4XM7iPAedB
 ifEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=y8BD+9XpQ+UzeK9v5ILr+QXZP/hmi4FdwshIuFa/7vg=;
 b=EwTJeTGSvEWbZbojYWBb34ntjyF8uahRVok/h5mOr1PX4MpJfijON3kXyDT80xCbYB
 UWXcPJMO3sYVBkDH86UnAZ4/oh7JbZh3khuwWdVh4Z1qSpOi+HBNLbAzFsKlQ307waW1
 20TivWCVuaMUly0TnOpc4ZnkCIaKv0olzJLO/JDF5/Oi2FE3EkZjns4BJgagCyeZfxtF
 fpwnChuNtTrBkCKEF+tOJeaWu8sysWAnvTI+8rDILoxv20UxJ3En8fpAQbBLtI1Zexio
 kU/nk8x72+7TepiCeVfJQk82BYQ4cyiq+dM9ARpCkJVAB6iOlSHwrx4B/oDOq1s8C1Z6
 Y1Aw==
X-Gm-Message-State: AJIora/5yw27CrZ1K+5FWb8Gv3mPwhVBfWoSrqoKGosiDIeuf0FcKJSG
 PeM7110Vfb0gu3tpXCL5c9w=
X-Google-Smtp-Source: AGRyM1sBMAzQOM1IW59fNDmPvsOriDwHYqgq8hHWMCcoePtiX7kZN+B/HX5TnaKeuAtT1S7NOdKZOg==
X-Received: by 2002:a17:906:1d5:b0:715:78c9:df83 with SMTP id
 21-20020a17090601d500b0071578c9df83mr7835689ejj.285.1655447666267; 
 Thu, 16 Jun 2022 23:34:26 -0700 (PDT)
Received: from ?IPV6:2a02:908:1256:79a0:b1f8:cf55:95c3:a816?
 ([2a02:908:1256:79a0:b1f8:cf55:95c3:a816])
 by smtp.gmail.com with ESMTPSA id
 9-20020a170906310900b0071cbc7487e1sm1008902ejx.69.2022.06.16.23.34.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 16 Jun 2022 23:34:23 -0700 (PDT)
Message-ID: <edcea168-d3b9-3701-188f-3bc186037e0a@gmail.com>
Date: Fri, 17 Jun 2022 08:34:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v3 2/3] drm/amdkfd: Enable GFX11 usermode queue
 oversubscription
Content-Language: en-US
To: philip yang <yangp@amd.com>, =?UTF-8?Q?Christian_K=c3=b6nig?=
 <christian.koenig@amd.com>, "Sider, Graham" <Graham.Sider@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20220613152001.3045911-1-Graham.Sider@amd.com>
 <20220613152001.3045911-2-Graham.Sider@amd.com>
 <453d57bf-e1b1-9dcb-9022-21444d2c64a8@amd.com>
 <DM6PR12MB30675F77909B21063CD01B8A8AAD9@DM6PR12MB3067.namprd12.prod.outlook.com>
 <26836141-d84a-363e-32c8-bd65dc8cdd22@amd.com>
 <63a5f706-6d6e-d30a-ad12-7308d44a6984@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <63a5f706-6d6e-d30a-ad12-7308d44a6984@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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
Cc: "Joshi, Mukul" <Mukul.Joshi@amd.com>, "Kuehling,
 Felix" <Felix.Kuehling@amd.com>, "Yang, Philip" <Philip.Yang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Hi Philip,

Am 16.06.22 um 00:41 schrieb philip yang:
> [SNIP]
>>>>> +    ret = amdgpu_bo_pin(bo, AMDGPU_GEM_DOMAIN_GTT);
>>>>> +    if (ret) {
>>>>> +        pr_err("Failed to pin bo. ret %d\n", ret);
>>>>> +        goto err_pin_bo_failed;
>>>>> +    }
>>>>
>>>> Oh! Is that something we do for every MQD? When yes that here is 
>>>> pretty
>>>> much a NAK.
>>>>
>>>> We can't do this or create a trivial deny of service attack against 
>>>> the kernel
>>>> driver.
>>>>
>>>> Regards,
>>>> Christian.
>>>>
>>> Hi Christian, could you elaborate on this? Right now this is only 
>>> being used to pin the queue wptr BO.
>>
>> Well is this wptr BO per process, per queue or global?
>>
>> amdgpu_bo_pin() is only allowed if we pin global resources, otherwise 
>> I have to reject that.
>
> wptr BO is per queue, allocated as queue structure, 1 page size on 
> system memory.
>

Yeah, I was hoping for this explanation as well. My status was still 
that the WPTR and RPTR are part of the ring buffer.

We should add a check that we really only pin a buffer with 1 page size 
here, then that should be ok.

Regards,
Christian.

> KFD limit number of queues globally, max_queues = 127; /* HWS limit 
> */, so this will pin max 508KB and take max 127 GART page mapping.
>
> wptr is updated by app and read by HWS, if we don't pin wptr, we have 
> to evict queue when wptr bo is moved on system memory, then update 
> GART mapping and restore queue.
>
> Regards,
>
> Philip
>
>>
>> Regards,
>> Christian.
>>
>>>
>>> Best,
>>> Graham
>>>
>>>>> +
>>>>> +    ret = amdgpu_ttm_alloc_gart(&bo->tbo);
>>>>> +    if (ret) {
>>>>> +        pr_err("Failed to bind bo to GART. ret %d\n", ret);
>>>>> +        goto err_map_bo_gart_failed;
>>>>> +    }
>>>>> +
>>>>> +    amdgpu_amdkfd_remove_eviction_fence(
>>>>> +        bo, bo->kfd_bo->process_info->eviction_fence);
>>>>> + list_del_init(&bo->kfd_bo->validate_list.head);
>>>>> +
>>>>> +    amdgpu_bo_unreserve(bo);
>>>>> +
>>>>> +    bo = amdgpu_bo_ref(bo);
>>>>> +
>>>>> +    return 0;
>>>>> +
>>>>> +err_map_bo_gart_failed:
>>>>> +    amdgpu_bo_unpin(bo);
>>>>> +err_pin_bo_failed:
>>>>> +    amdgpu_bo_unreserve(bo);
>>>>> +err_reserve_bo_failed:
>>>>> +
>>>>> +    return ret;
>>>>> +}
>>>>> +
>>>>>    int amdgpu_amdkfd_gpuvm_map_gtt_bo_to_kernel(struct
>>>> amdgpu_device *adev,
>>>>>            struct kgd_mem *mem, void **kptr, uint64_t *size)
>>>>>    {
>>>>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
>>>>> b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
>>>>> index e9766e165c38..1789ed8b79f5 100644
>>>>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
>>>>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
>>>>> @@ -289,6 +289,7 @@ static int kfd_ioctl_create_queue(struct file 
>>>>> *filep,
>>>> struct kfd_process *p,
>>>>>        struct kfd_process_device *pdd;
>>>>>        struct queue_properties q_properties;
>>>>>        uint32_t doorbell_offset_in_process = 0;
>>>>> +    struct amdgpu_bo *wptr_bo = NULL;
>>>>>
>>>>>        memset(&q_properties, 0, sizeof(struct queue_properties));
>>>>>
>>>>> @@ -316,12 +317,41 @@ static int kfd_ioctl_create_queue(struct file
>>>> *filep, struct kfd_process *p,
>>>>>            goto err_bind_process;
>>>>>        }
>>>>>
>>>>> +    /* Starting with GFX11, wptr BOs must be mapped to GART for MES
>>>> to determine work
>>>>> +     * on unmapped queues for usermode queue oversubscription (no
>>>> aggregated doorbell)
>>>>> +     */
>>>>> +    if (dev->shared_resources.enable_mes && (dev->adev-
>>>>> mes.sched_version & 0xff) >= 3) {
>>>>> +        struct amdgpu_bo_va_mapping *wptr_mapping;
>>>>> +        struct amdgpu_vm *wptr_vm;
>>>>> +
>>>>> +        wptr_vm = drm_priv_to_vm(pdd->drm_priv);
>>>>> +        err = amdgpu_bo_reserve(wptr_vm->root.bo, false);
>>>>> +        if (err)
>>>>> +            goto err_wptr_map_gart;
>>>>> +
>>>>> +        wptr_mapping = amdgpu_vm_bo_lookup_mapping(
>>>>> +                wptr_vm, args->write_pointer_address >>
>>>> PAGE_SHIFT);
>>>>> + amdgpu_bo_unreserve(wptr_vm->root.bo);
>>>>> +        if (!wptr_mapping) {
>>>>> +            pr_err("Failed to lookup wptr bo\n");
>>>>> +            err = -EINVAL;
>>>>> +            goto err_wptr_map_gart;
>>>>> +        }
>>>>> +
>>>>> +        wptr_bo = wptr_mapping->bo_va->base.bo;
>>>>> +        err = amdgpu_amdkfd_map_gtt_bo_to_gart(dev->adev,
>>>> wptr_bo);
>>>>> +        if (err) {
>>>>> +            pr_err("Failed to map wptr bo to GART\n");
>>>>> +            goto err_wptr_map_gart;
>>>>> +        }
>>>>> +    }
>>>>> +
>>>>>        pr_debug("Creating queue for PASID 0x%x on gpu 0x%x\n",
>>>>>                p->pasid,
>>>>>                dev->id);
>>>>>
>>>>> -    err = pqm_create_queue(&p->pqm, dev, filep, &q_properties,
>>>> &queue_id, NULL, NULL, NULL,
>>>>> - &doorbell_offset_in_process);
>>>>> +    err = pqm_create_queue(&p->pqm, dev, filep, &q_properties,
>>>> &queue_id, wptr_bo,
>>>>> +            NULL, NULL, NULL, &doorbell_offset_in_process);
>>>>>        if (err != 0)
>>>>>            goto err_create_queue;
>>>>>
>>>>> @@ -354,6 +384,9 @@ static int kfd_ioctl_create_queue(struct file 
>>>>> *filep,
>>>> struct kfd_process *p,
>>>>>        return 0;
>>>>>
>>>>>    err_create_queue:
>>>>> +    if (wptr_bo)
>>>>> +        amdgpu_amdkfd_free_gtt_mem(dev->adev, wptr_bo);
>>>>> +err_wptr_map_gart:
>>>>>    err_bind_process:
>>>>>    err_pdd:
>>>>>        mutex_unlock(&p->mutex);
>>>>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
>>>>> b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
>>>>> index b39d89c52887..d8de2fbdfc7d 100644
>>>>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
>>>>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
>>>>> @@ -208,6 +208,7 @@ static int add_queue_mes(struct
>>>> device_queue_manager *dqm, struct queue *q,
>>>>>        struct kfd_process_device *pdd = qpd_to_pdd(qpd);
>>>>>        struct mes_add_queue_input queue_input;
>>>>>        int r, queue_type;
>>>>> +    uint64_t wptr_addr_off;
>>>>>
>>>>>        if (dqm->is_hws_hang)
>>>>>            return -EIO;
>>>>> @@ -227,7 +228,13 @@ static int add_queue_mes(struct
>>>> device_queue_manager *dqm, struct queue *q,
>>>>     AMDGPU_MES_PRIORITY_LEVEL_NORMAL;
>>>>>        queue_input.doorbell_offset = q->properties.doorbell_off;
>>>>>        queue_input.mqd_addr = q->gart_mqd_addr;
>>>>> -    queue_input.wptr_addr = (uint64_t)q->properties.write_ptr;
>>>>> +
>>>>> +    if (q->wptr_bo) {
>>>>> +        wptr_addr_off = (uint64_t)q->properties.write_ptr -
>>>> (uint64_t)q->wptr_bo->kfd_bo->va;
>>>>> +        queue_input.wptr_addr = ((uint64_t)q->wptr_bo-
>>>>> tbo.resource->start << PAGE_SHIFT) + wptr_addr_off;
>>>>> +    } else
>>>>> +        queue_input.wptr_addr = (uint64_t)q-
>>>>> properties.write_ptr;
>>>>> +
>>>>>        queue_input.paging = false;
>>>>>        queue_input.tba_addr = qpd->tba_addr;
>>>>>        queue_input.tma_addr = qpd->tma_addr; diff --git
>>>>> a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v11.c
>>>>> b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v11.c
>>>>> index f1654b4da856..35e74bdd81da 100644
>>>>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v11.c
>>>>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v11.c
>>>>> @@ -377,6 +377,8 @@ static void update_mqd_sdma(struct mqd_manager
>>>> *mm, void *mqd,
>>>>>        m->sdmax_rlcx_rb_base_hi = upper_32_bits(q->queue_address >>
>>>> 8);
>>>>> m->sdmax_rlcx_rb_rptr_addr_lo = lower_32_bits((uint64_t)q-
>>>>> read_ptr);
>>>>>        m->sdmax_rlcx_rb_rptr_addr_hi =
>>>>> upper_32_bits((uint64_t)q->read_ptr);
>>>>> +    m->sdmax_rlcx_rb_wptr_poll_addr_lo = lower_32_bits((uint64_t)q-
>>>>> write_ptr);
>>>>> +    m->sdmax_rlcx_rb_wptr_poll_addr_hi =
>>>>> +upper_32_bits((uint64_t)q->write_ptr);
>>>>>        m->sdmax_rlcx_doorbell_offset =
>>>>>            q->doorbell_off <<
>>>> SDMA0_QUEUE0_DOORBELL_OFFSET__OFFSET__SHIFT;
>>>>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
>>>>> b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
>>>>> index a5d3963537d7..dcddee0d6f06 100644
>>>>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
>>>>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
>>>>> @@ -639,6 +639,8 @@ struct queue {
>>>>>        void *gang_ctx_bo;
>>>>>        uint64_t gang_ctx_gpu_addr;
>>>>>        void *gang_ctx_cpu_ptr;
>>>>> +
>>>>> +    struct amdgpu_bo *wptr_bo;
>>>>>    };
>>>>>
>>>>>    enum KFD_MQD_TYPE {
>>>>> @@ -1404,6 +1406,7 @@ int pqm_create_queue(struct
>>>> process_queue_manager *pqm,
>>>>>                    struct file *f,
>>>>>                    struct queue_properties *properties,
>>>>>                    unsigned int *qid,
>>>>> +                struct amdgpu_bo *wptr_bo,
>>>>>                    const struct kfd_criu_queue_priv_data *q_data,
>>>>>                    const void *restore_mqd,
>>>>>                    const void *restore_ctl_stack, diff --git
>>>>> a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
>>>>> b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
>>>>> index f99e09dc43ea..3a17c1ebc527 100644
>>>>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
>>>>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
>>>>> @@ -190,7 +190,8 @@ void pqm_uninit(struct process_queue_manager
>>>> *pqm)
>>>>>    static int init_user_queue(struct process_queue_manager *pqm,
>>>>>                    struct kfd_dev *dev, struct queue **q,
>>>>>                    struct queue_properties *q_properties,
>>>>> -                struct file *f, unsigned int qid)
>>>>> +                struct file *f, struct amdgpu_bo *wptr_bo,
>>>>> +                unsigned int qid)
>>>>>    {
>>>>>        int retval;
>>>>>
>>>>> @@ -221,6 +222,7 @@ static int init_user_queue(struct
>>>> process_queue_manager *pqm,
>>>>>                goto cleanup;
>>>>>            }
>>>>>            memset((*q)->gang_ctx_cpu_ptr, 0,
>>>> AMDGPU_MES_GANG_CTX_SIZE);
>>>>> +        (*q)->wptr_bo = wptr_bo;
>>>>>        }
>>>>>
>>>>>        pr_debug("PQM After init queue");
>>>>> @@ -237,6 +239,7 @@ int pqm_create_queue(struct
>>>> process_queue_manager *pqm,
>>>>>                    struct file *f,
>>>>>                    struct queue_properties *properties,
>>>>>                    unsigned int *qid,
>>>>> +                struct amdgpu_bo *wptr_bo,
>>>>>                    const struct kfd_criu_queue_priv_data *q_data,
>>>>>                    const void *restore_mqd,
>>>>>                    const void *restore_ctl_stack, @@ -299,7 +302,7
>>>> @@ int
>>>>> pqm_create_queue(struct process_queue_manager *pqm,
>>>>>             * allocate_sdma_queue() in create_queue() has the
>>>>>             * corresponding check logic.
>>>>>             */
>>>>> -        retval = init_user_queue(pqm, dev, &q, properties, f, *qid);
>>>>> +        retval = init_user_queue(pqm, dev, &q, properties, f,
>>>> wptr_bo,
>>>>> +*qid);
>>>>>            if (retval != 0)
>>>>>                goto err_create_queue;
>>>>>            pqn->q = q;
>>>>> @@ -320,7 +323,7 @@ int pqm_create_queue(struct
>>>> process_queue_manager *pqm,
>>>>>                goto err_create_queue;
>>>>>            }
>>>>>
>>>>> -        retval = init_user_queue(pqm, dev, &q, properties, f, *qid);
>>>>> +        retval = init_user_queue(pqm, dev, &q, properties, f,
>>>> wptr_bo,
>>>>> +*qid);
>>>>>            if (retval != 0)
>>>>>                goto err_create_queue;
>>>>>            pqn->q = q;
>>>>> @@ -457,9 +460,13 @@ int pqm_destroy_queue(struct
>>>> process_queue_manager *pqm, unsigned int qid)
>>>>>                pdd->qpd.num_gws = 0;
>>>>>            }
>>>>>
>>>>> -        if (dev->shared_resources.enable_mes)
>>>>> +        if (dev->shared_resources.enable_mes) {
>>>>>                amdgpu_amdkfd_free_gtt_mem(dev->adev,
>>>>>                               pqn->q->gang_ctx_bo);
>>>>> +            if (pqn->q->wptr_bo)
>>>>> +                amdgpu_amdkfd_free_gtt_mem(dev-
>>>>> adev, pqn->q->wptr_bo);
>>>>> +
>>>>> +        }
>>>>>            uninit_queue(pqn->q);
>>>>>        }
>>>>>
>>>>> @@ -900,7 +907,7 @@ int kfd_criu_restore_queue(struct kfd_process *p,
>>>>>
>>>>>        print_queue_properties(&qp);
>>>>>
>>>>> -    ret = pqm_create_queue(&p->pqm, pdd->dev, NULL, &qp,
>>>> &queue_id, q_data, mqd, ctl_stack,
>>>>> +    ret = pqm_create_queue(&p->pqm, pdd->dev, NULL, &qp,
>>>> &queue_id,
>>>>> +NULL, q_data, mqd, ctl_stack,
>>>>>                    NULL);
>>>>>        if (ret) {
>>>>>            pr_err("Failed to create new queue err:%d\n", ret);
>>

