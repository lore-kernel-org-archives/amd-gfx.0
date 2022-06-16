Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06973C43334
	for <amd-gfx@archiver.kernel.org>; Thu, 16 Jun 2022 18:21:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9D70211251C;
	Thu, 16 Jun 2022 18:21:53 +0000 (UTC)
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com
 [IPv6:2607:f8b0:4864:20::1130])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EFB3011251C
 for <amd-gfx@lists.freedesktop.org>; Thu, 16 Jun 2022 18:21:52 +0000 (UTC)
Received: by mail-yw1-x1130.google.com with SMTP id
 00721157ae682-3177e60d980so174457b3.12
 for <amd-gfx@lists.freedesktop.org>; Thu, 16 Jun 2022 11:21:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=lY/ZGLxP+KX0v9g/rLrVp/4ytwgbyUEXmv+smULUuCo=;
 b=E53OG9IcRhhA/N9j4q18vk28YjnLkbWROb2LetzUeRqSGjVrVoyE0RkipFCbOzZ5qj
 WH8sKLRCdmYVTmxr4VGXXufuGKJTUxZMItvguJKsRjhgRS94+UknFOcYDUKV7hSt78AV
 fUQX2g4RjNWYhie8+pOIUu28AjoIg26LplHzw4ZTvK9xurw0SHUO+uHJBAC2oweG7Uz4
 TZ35OFl8RUCjU7SiUuLdpy9Lmz4qwnYQjFaCD9VEp8l9OFHKlXAKLVkda7sKJOrJzNTe
 4ZDKaSDCmJ7PSgxnw+zkC479WRXB6d8o9Oc0LOW7ZBmQ5nDXxVAPuGETEeJNF+ge2BHx
 0mGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=lY/ZGLxP+KX0v9g/rLrVp/4ytwgbyUEXmv+smULUuCo=;
 b=2SzDOuYxSlPrmeMFxyaxddv/5uTBxHkKEeZjjETduXnBQsBQNZHY6PzktkiIP2hm2V
 lESGqoWH36Ll9MqBm9BMEOdZzBGdPormuzpjpeSzITT/3vz5pZbqLIa1nz181zwslvMI
 13OfnYshCj+hk+LCF4PJwIoYoMp8bNweaFQD9nqdwpX05QBx1fcuwxUDanhMIgKMPvRz
 5IDUwKNstsu+gerdapEJXs6/MyDGFaXQo38MywI69M1Ctpfh2qJZWl5r68ncaA/vgqJJ
 Bkhczci4jv0jr4FkHAMnNgvifI6ieA/Uyjk6m128950xnQrDa+367JP1zwrX3oHZCDUA
 Zf8g==
X-Gm-Message-State: AJIora/TIqFAnoAQObpWjf9pumEcAOw+nxOifm6Z3akJX98C/TZXv37c
 6rawJWdSd37vEQk6laTWgzyqBxxlLI749X1V8EE=
X-Google-Smtp-Source: AGRyM1tck3puhz5U7OtWg0Ci61zT6EDoN6pKm6zdnqcdOtaiG4Nefsr4UZRv4RdWMh2FmbjscSBQ2EwwqcKbfGDy8Zc=
X-Received: by 2002:a0d:e252:0:b0:30c:2ff7:dd88 with SMTP id
 l79-20020a0de252000000b0030c2ff7dd88mr7150565ywe.506.1655403711996; Thu, 16
 Jun 2022 11:21:51 -0700 (PDT)
MIME-Version: 1.0
References: <20220613152001.3045911-1-Graham.Sider@amd.com>
 <20220613152001.3045911-2-Graham.Sider@amd.com>
 <453d57bf-e1b1-9dcb-9022-21444d2c64a8@amd.com>
 <DM6PR12MB30675F77909B21063CD01B8A8AAD9@DM6PR12MB3067.namprd12.prod.outlook.com>
 <26836141-d84a-363e-32c8-bd65dc8cdd22@amd.com>
 <63a5f706-6d6e-d30a-ad12-7308d44a6984@amd.com>
In-Reply-To: <63a5f706-6d6e-d30a-ad12-7308d44a6984@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 16 Jun 2022 14:21:40 -0400
Message-ID: <CADnq5_O9tJOTk3g6vxg+wstUpGYpc9Vf=7shwai9OvOyvnFJLQ@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] drm/amdkfd: Enable GFX11 usermode queue
 oversubscription
To: philip yang <yangp@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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
Cc: "Joshi, Mukul" <Mukul.Joshi@amd.com>, "Yang, Philip" <Philip.Yang@amd.com>,
 "Kuehling, Felix" <Felix.Kuehling@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, "Sider,
 Graham" <Graham.Sider@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Wed, Jun 15, 2022 at 6:41 PM philip yang <yangp@amd.com> wrote:
>
>
> On 2022-06-15 10:06, Christian K=C3=B6nig wrote:
>
> Am 15.06.22 um 15:17 schrieb Sider, Graham:
>
> [AMD Official Use Only - General]
>
> -----Original Message-----
> From: Koenig, Christian <Christian.Koenig@amd.com>
> Sent: Wednesday, June 15, 2022 3:29 AM
> To: Sider, Graham <Graham.Sider@amd.com>; amd-
> gfx@lists.freedesktop.org
> Cc: Joshi, Mukul <Mukul.Joshi@amd.com>; Kuehling, Felix
> <Felix.Kuehling@amd.com>; Yang, Philip <Philip.Yang@amd.com>
> Subject: Re: [PATCH v3 2/3] drm/amdkfd: Enable GFX11 usermode queue
> oversubscription
>
>
>
> Am 13.06.22 um 17:20 schrieb Graham Sider:
>
> Starting with GFX11, MES requires wptr BOs to be GTT allocated/mapped
> to GART for usermode queues in order to support oversubscription. In
> the case that work is submitted to an unmapped queue, MES must have a
> GART wptr address to determine whether the queue should be mapped.
>
> This change is accompanied with changes in MES and is applicable for
> MES_VERSION >=3D 3.
>
> v2:
> - Update MES_VERSION check from 2 to 3.
> v3:
> - Use amdgpu_vm_bo_lookup_mapping for wptr_bo mapping lookup
> - Move wptr_bo refcount increment to
>
> amdgpu_amdkfd_map_gtt_bo_to_gart
>
> - Remove list_del_init from amdgpu_amdkfd_map_gtt_bo_to_gart
> - Cleanup/fix create_queue wptr_bo error handling
>
> Signed-off-by: Graham Sider <Graham.Sider@amd.com>
> ---
>    drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h    |  1 +
>    .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c  | 49
>
> +++++++++++++++++++
>
>    drivers/gpu/drm/amd/amdkfd/kfd_chardev.c      | 37 +++++++++++++-
>    .../drm/amd/amdkfd/kfd_device_queue_manager.c |  9 +++-
>    .../gpu/drm/amd/amdkfd/kfd_mqd_manager_v11.c  |  2 +
>    drivers/gpu/drm/amd/amdkfd/kfd_priv.h         |  3 ++
>    .../amd/amdkfd/kfd_process_queue_manager.c    | 17 +++++--
>    7 files changed, 110 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
> index 429b16ba10bf..dba26d1e3be9 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
> @@ -301,6 +301,7 @@ int
>
> amdgpu_amdkfd_gpuvm_map_gtt_bo_to_kernel(struct amdgpu_device
> *adev,
>
>            struct kgd_mem *mem, void **kptr, uint64_t *size);
>    void amdgpu_amdkfd_gpuvm_unmap_gtt_bo_from_kernel(struct
>
> amdgpu_device *adev,
>
>            struct kgd_mem *mem);
> +int amdgpu_amdkfd_map_gtt_bo_to_gart(struct amdgpu_device *adev,
> +struct amdgpu_bo *bo);
>
>    int amdgpu_amdkfd_gpuvm_restore_process_bos(void *process_info,
>                            struct dma_fence **ef);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> index efab923056f4..888d08128a94 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> @@ -2030,6 +2030,55 @@ int amdgpu_amdkfd_gpuvm_sync_memory(
>        return ret;
>    }
>
> +/**
> + * amdgpu_amdkfd_map_gtt_bo_to_gart - Map BO to GART and
>
> increment
>
> +reference count
> + * @adev: Device to which allocated BO belongs
> + * @bo: Buffer object to be mapped
> + *
> + * Before return, bo reference count is incremented. To release the
> +reference and unpin/
> + * unmap the BO, call amdgpu_amdkfd_free_gtt_mem.
> + */
> +int amdgpu_amdkfd_map_gtt_bo_to_gart(struct amdgpu_device *adev,
> +struct amdgpu_bo *bo) {
> +    int ret;
> +
> +    ret =3D amdgpu_bo_reserve(bo, true);
> +    if (ret) {
> +        pr_err("Failed to reserve bo. ret %d\n", ret);
> +        goto err_reserve_bo_failed;
> +    }
> +
> +    ret =3D amdgpu_bo_pin(bo, AMDGPU_GEM_DOMAIN_GTT);
> +    if (ret) {
> +        pr_err("Failed to pin bo. ret %d\n", ret);
> +        goto err_pin_bo_failed;
> +    }
>
>
> Oh! Is that something we do for every MQD? When yes that here is pretty
> much a NAK.
>
> We can't do this or create a trivial deny of service attack against the k=
ernel
> driver.
>
> Regards,
> Christian.
>
> Hi Christian, could you elaborate on this? Right now this is only being u=
sed to pin the queue wptr BO.
>
>
> Well is this wptr BO per process, per queue or global?
>
> amdgpu_bo_pin() is only allowed if we pin global resources, otherwise I h=
ave to reject that.
>
> wptr BO is per queue, allocated as queue structure, 1 page size on system=
 memory.
>
> KFD limit number of queues globally, max_queues =3D 127; /* HWS limit */,=
 so this will pin max 508KB and take max 127 GART page mapping.
>
> wptr is updated by app and read by HWS, if we don't pin wptr, we have to =
evict queue when wptr bo is moved on system memory, then update GART mappin=
g and restore queue.
>

I talked to Graham about this a bit off line.  This is a requirement
due to changes in the hardware and the way KFD doorbells work.  The
fact that we are limited by the max queues supported by the hardware
scheduler prevents this from getting out of hand.  We would need this
space whether the queues were kernel managed or user managed.

Acked-by: Alex Deucher <alexander.deucher@amd.com>

> Regards,
>
> Philip
>
>
> Regards,
> Christian.
>
>
> Best,
> Graham
>
> +
> +    ret =3D amdgpu_ttm_alloc_gart(&bo->tbo);
> +    if (ret) {
> +        pr_err("Failed to bind bo to GART. ret %d\n", ret);
> +        goto err_map_bo_gart_failed;
> +    }
> +
> +    amdgpu_amdkfd_remove_eviction_fence(
> +        bo, bo->kfd_bo->process_info->eviction_fence);
> +    list_del_init(&bo->kfd_bo->validate_list.head);
> +
> +    amdgpu_bo_unreserve(bo);
> +
> +    bo =3D amdgpu_bo_ref(bo);
> +
> +    return 0;
> +
> +err_map_bo_gart_failed:
> +    amdgpu_bo_unpin(bo);
> +err_pin_bo_failed:
> +    amdgpu_bo_unreserve(bo);
> +err_reserve_bo_failed:
> +
> +    return ret;
> +}
> +
>    int amdgpu_amdkfd_gpuvm_map_gtt_bo_to_kernel(struct
>
> amdgpu_device *adev,
>
>            struct kgd_mem *mem, void **kptr, uint64_t *size)
>    {
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> index e9766e165c38..1789ed8b79f5 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> @@ -289,6 +289,7 @@ static int kfd_ioctl_create_queue(struct file *filep,
>
> struct kfd_process *p,
>
>        struct kfd_process_device *pdd;
>        struct queue_properties q_properties;
>        uint32_t doorbell_offset_in_process =3D 0;
> +    struct amdgpu_bo *wptr_bo =3D NULL;
>
>        memset(&q_properties, 0, sizeof(struct queue_properties));
>
> @@ -316,12 +317,41 @@ static int kfd_ioctl_create_queue(struct file
>
> *filep, struct kfd_process *p,
>
>            goto err_bind_process;
>        }
>
> +    /* Starting with GFX11, wptr BOs must be mapped to GART for MES
>
> to determine work
>
> +     * on unmapped queues for usermode queue oversubscription (no
>
> aggregated doorbell)
>
> +     */
> +    if (dev->shared_resources.enable_mes && (dev->adev-
> mes.sched_version & 0xff) >=3D 3) {
> +        struct amdgpu_bo_va_mapping *wptr_mapping;
> +        struct amdgpu_vm *wptr_vm;
> +
> +        wptr_vm =3D drm_priv_to_vm(pdd->drm_priv);
> +        err =3D amdgpu_bo_reserve(wptr_vm->root.bo, false);
> +        if (err)
> +            goto err_wptr_map_gart;
> +
> +        wptr_mapping =3D amdgpu_vm_bo_lookup_mapping(
> +                wptr_vm, args->write_pointer_address >>
>
> PAGE_SHIFT);
>
> +        amdgpu_bo_unreserve(wptr_vm->root.bo);
> +        if (!wptr_mapping) {
> +            pr_err("Failed to lookup wptr bo\n");
> +            err =3D -EINVAL;
> +            goto err_wptr_map_gart;
> +        }
> +
> +        wptr_bo =3D wptr_mapping->bo_va->base.bo;
> +        err =3D amdgpu_amdkfd_map_gtt_bo_to_gart(dev->adev,
>
> wptr_bo);
>
> +        if (err) {
> +            pr_err("Failed to map wptr bo to GART\n");
> +            goto err_wptr_map_gart;
> +        }
> +    }
> +
>        pr_debug("Creating queue for PASID 0x%x on gpu 0x%x\n",
>                p->pasid,
>                dev->id);
>
> -    err =3D pqm_create_queue(&p->pqm, dev, filep, &q_properties,
>
> &queue_id, NULL, NULL, NULL,
>
> -            &doorbell_offset_in_process);
> +    err =3D pqm_create_queue(&p->pqm, dev, filep, &q_properties,
>
> &queue_id, wptr_bo,
>
> +            NULL, NULL, NULL, &doorbell_offset_in_process);
>        if (err !=3D 0)
>            goto err_create_queue;
>
> @@ -354,6 +384,9 @@ static int kfd_ioctl_create_queue(struct file *filep,
>
> struct kfd_process *p,
>
>        return 0;
>
>    err_create_queue:
> +    if (wptr_bo)
> +        amdgpu_amdkfd_free_gtt_mem(dev->adev, wptr_bo);
> +err_wptr_map_gart:
>    err_bind_process:
>    err_pdd:
>        mutex_unlock(&p->mutex);
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> index b39d89c52887..d8de2fbdfc7d 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> @@ -208,6 +208,7 @@ static int add_queue_mes(struct
>
> device_queue_manager *dqm, struct queue *q,
>
>        struct kfd_process_device *pdd =3D qpd_to_pdd(qpd);
>        struct mes_add_queue_input queue_input;
>        int r, queue_type;
> +    uint64_t wptr_addr_off;
>
>        if (dqm->is_hws_hang)
>            return -EIO;
> @@ -227,7 +228,13 @@ static int add_queue_mes(struct
>
> device_queue_manager *dqm, struct queue *q,
>     AMDGPU_MES_PRIORITY_LEVEL_NORMAL;
>
>        queue_input.doorbell_offset =3D q->properties.doorbell_off;
>        queue_input.mqd_addr =3D q->gart_mqd_addr;
> -    queue_input.wptr_addr =3D (uint64_t)q->properties.write_ptr;
> +
> +    if (q->wptr_bo) {
> +        wptr_addr_off =3D (uint64_t)q->properties.write_ptr -
>
> (uint64_t)q->wptr_bo->kfd_bo->va;
>
> +        queue_input.wptr_addr =3D ((uint64_t)q->wptr_bo-
> tbo.resource->start << PAGE_SHIFT) + wptr_addr_off;
> +    } else
> +        queue_input.wptr_addr =3D (uint64_t)q-
> properties.write_ptr;
> +
>        queue_input.paging =3D false;
>        queue_input.tba_addr =3D qpd->tba_addr;
>        queue_input.tma_addr =3D qpd->tma_addr; diff --git
> a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v11.c
> b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v11.c
> index f1654b4da856..35e74bdd81da 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v11.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v11.c
> @@ -377,6 +377,8 @@ static void update_mqd_sdma(struct mqd_manager
>
> *mm, void *mqd,
>
>        m->sdmax_rlcx_rb_base_hi =3D upper_32_bits(q->queue_address >>
>
> 8);
>
>        m->sdmax_rlcx_rb_rptr_addr_lo =3D lower_32_bits((uint64_t)q-
> read_ptr);
>        m->sdmax_rlcx_rb_rptr_addr_hi =3D
> upper_32_bits((uint64_t)q->read_ptr);
> +    m->sdmax_rlcx_rb_wptr_poll_addr_lo =3D lower_32_bits((uint64_t)q-
> write_ptr);
> +    m->sdmax_rlcx_rb_wptr_poll_addr_hi =3D
> +upper_32_bits((uint64_t)q->write_ptr);
>        m->sdmax_rlcx_doorbell_offset =3D
>            q->doorbell_off <<
>
> SDMA0_QUEUE0_DOORBELL_OFFSET__OFFSET__SHIFT;
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> index a5d3963537d7..dcddee0d6f06 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> @@ -639,6 +639,8 @@ struct queue {
>        void *gang_ctx_bo;
>        uint64_t gang_ctx_gpu_addr;
>        void *gang_ctx_cpu_ptr;
> +
> +    struct amdgpu_bo *wptr_bo;
>    };
>
>    enum KFD_MQD_TYPE {
> @@ -1404,6 +1406,7 @@ int pqm_create_queue(struct
>
> process_queue_manager *pqm,
>
>                    struct file *f,
>                    struct queue_properties *properties,
>                    unsigned int *qid,
> +                struct amdgpu_bo *wptr_bo,
>                    const struct kfd_criu_queue_priv_data *q_data,
>                    const void *restore_mqd,
>                    const void *restore_ctl_stack, diff --git
> a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
> b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
> index f99e09dc43ea..3a17c1ebc527 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
> @@ -190,7 +190,8 @@ void pqm_uninit(struct process_queue_manager
>
> *pqm)
>
>    static int init_user_queue(struct process_queue_manager *pqm,
>                    struct kfd_dev *dev, struct queue **q,
>                    struct queue_properties *q_properties,
> -                struct file *f, unsigned int qid)
> +                struct file *f, struct amdgpu_bo *wptr_bo,
> +                unsigned int qid)
>    {
>        int retval;
>
> @@ -221,6 +222,7 @@ static int init_user_queue(struct
>
> process_queue_manager *pqm,
>
>                goto cleanup;
>            }
>            memset((*q)->gang_ctx_cpu_ptr, 0,
>
> AMDGPU_MES_GANG_CTX_SIZE);
>
> +        (*q)->wptr_bo =3D wptr_bo;
>        }
>
>        pr_debug("PQM After init queue");
> @@ -237,6 +239,7 @@ int pqm_create_queue(struct
>
> process_queue_manager *pqm,
>
>                    struct file *f,
>                    struct queue_properties *properties,
>                    unsigned int *qid,
> +                struct amdgpu_bo *wptr_bo,
>                    const struct kfd_criu_queue_priv_data *q_data,
>                    const void *restore_mqd,
>                    const void *restore_ctl_stack, @@ -299,7 +302,7
>
> @@ int
>
> pqm_create_queue(struct process_queue_manager *pqm,
>             * allocate_sdma_queue() in create_queue() has the
>             * corresponding check logic.
>             */
> -        retval =3D init_user_queue(pqm, dev, &q, properties, f, *qid);
> +        retval =3D init_user_queue(pqm, dev, &q, properties, f,
>
> wptr_bo,
>
> +*qid);
>            if (retval !=3D 0)
>                goto err_create_queue;
>            pqn->q =3D q;
> @@ -320,7 +323,7 @@ int pqm_create_queue(struct
>
> process_queue_manager *pqm,
>
>                goto err_create_queue;
>            }
>
> -        retval =3D init_user_queue(pqm, dev, &q, properties, f, *qid);
> +        retval =3D init_user_queue(pqm, dev, &q, properties, f,
>
> wptr_bo,
>
> +*qid);
>            if (retval !=3D 0)
>                goto err_create_queue;
>            pqn->q =3D q;
> @@ -457,9 +460,13 @@ int pqm_destroy_queue(struct
>
> process_queue_manager *pqm, unsigned int qid)
>
>                pdd->qpd.num_gws =3D 0;
>            }
>
> -        if (dev->shared_resources.enable_mes)
> +        if (dev->shared_resources.enable_mes) {
>                amdgpu_amdkfd_free_gtt_mem(dev->adev,
>                               pqn->q->gang_ctx_bo);
> +            if (pqn->q->wptr_bo)
> +                amdgpu_amdkfd_free_gtt_mem(dev-
> adev, pqn->q->wptr_bo);
> +
> +        }
>            uninit_queue(pqn->q);
>        }
>
> @@ -900,7 +907,7 @@ int kfd_criu_restore_queue(struct kfd_process *p,
>
>        print_queue_properties(&qp);
>
> -    ret =3D pqm_create_queue(&p->pqm, pdd->dev, NULL, &qp,
>
> &queue_id, q_data, mqd, ctl_stack,
>
> +    ret =3D pqm_create_queue(&p->pqm, pdd->dev, NULL, &qp,
>
> &queue_id,
>
> +NULL, q_data, mqd, ctl_stack,
>                    NULL);
>        if (ret) {
>            pr_err("Failed to create new queue err:%d\n", ret);
>
>
