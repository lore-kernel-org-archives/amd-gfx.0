Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D66EC282EC
	for <amd-gfx@archiver.kernel.org>; Tue, 11 Mar 2025 20:05:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C789C10E687;
	Tue, 11 Mar 2025 20:05:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="kMsPXmY/";
	dkim-atps=neutral
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com
 [209.85.214.178])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5C79E10E5E4
 for <amd-gfx@lists.freedesktop.org>; Tue, 11 Mar 2025 20:05:49 +0000 (UTC)
Received: by mail-pl1-f178.google.com with SMTP id
 d9443c01a7336-22403c99457so12228635ad.3
 for <amd-gfx@lists.freedesktop.org>; Tue, 11 Mar 2025 13:05:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1741723549; x=1742328349; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QVI3IoBR9RweNlIVZCVt2vzOv+pmk/Xh1Ph6cxw33mQ=;
 b=kMsPXmY/Eev0BtMFIrvt06grELUVtfzD1amuAitOe9TA4jUUdJH53+8TujempvaCoc
 KaNMqqm6A85uTE/v6bt3zLVJ/Au0BbMlcrm8i2t2JT4abhC66HVXGy/jIVdwFAhaQs1P
 OxdkigmtiKOBPCWCljl7WggcpZ+DcDKyo2PCy2OFuP5wp84ahEywHYp4ERy5LMEefLzg
 Uf9X4fO2s7o2BGwcfwGCYFO7K13/0sfsxhoDIalx1TXK0+LoWN+c7PN06I59nfzWyCEV
 vhZskH3Nitrgkmua74MQw8fjAx62D90Q1ZoeCwr2tp8LgrHDCB3Fl5VxmYNbhwKrkWFj
 oNHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741723549; x=1742328349;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QVI3IoBR9RweNlIVZCVt2vzOv+pmk/Xh1Ph6cxw33mQ=;
 b=ApY8+WZ+6qWsXq/xt6d0FUyMIi8NqIAiaURlAstp2WAh3fv7DJNNfWed6MXmND6cRa
 b5cd6bRENfNvTLrlcZ4kLXs0OPX4B9PhREKeStYeTydXmTZ8Gvq4QKqtGI7N8Oy/u76W
 yhbie029nbLrPNpjFxkXUlqo0T+SbJ6nivexRxmyOaTfmySX++cTmhOjmV9Hd9E2PXz9
 JvEf61v2qgyYSAmQIJ/T84o5pNubSZEiIxA2afAUCvEdZY3M8EBxh/rAQ9/KEB18r77f
 gIUyDz39BsngWUm1DavlU6NuoNZTNbNJxB7C+niyozMvqa+Wt+NOkBLGnKoYEd8ArCfR
 NkXg==
X-Gm-Message-State: AOJu0YxcGUBwFbltuMIZ5pF57LADvdR2CvbYaMLjbq01gNzWuEJ5UJoA
 2ZzJ7GK02ET+pYFwWoZc5mz3RhgikwTwk4X1h3b8uyvB2l1UyjmO8rQ2vXQS+Z1NjQ2QutfrXfl
 DUvnswTliUeEE/bm7JH/Zu3pp2Cwizw==
X-Gm-Gg: ASbGncuNP+TjjhXTpdIEFaUE8ewASfNFdhu5WeFV8R6hAUSDGuE4whZ3/eocAPx1Icx
 7gT2lxVKKWR9g5A5F8zs6pC3QDGArhSBTPENlMGUNfStknNWSULaixsC+X3I08UywrbmCWIMtG9
 BSVmXRhkktjhVt8Ej0ouFDMux2Pw==
X-Google-Smtp-Source: AGHT+IGyswyRgQ6E9QagGESiIoX94cSQ1JNbry5m4am5apMrdFbjdkUXS6aBoMYPOIKseArwBmvTX1akZ+S3FrgYaVc=
X-Received: by 2002:a17:902:ced2:b0:224:13a2:ab9a with SMTP id
 d9443c01a7336-22593280808mr24253895ad.7.1741723548511; Tue, 11 Mar 2025
 13:05:48 -0700 (PDT)
MIME-Version: 1.0
References: <20250305205702.1234714-1-alexander.deucher@amd.com>
In-Reply-To: <20250305205702.1234714-1-alexander.deucher@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 11 Mar 2025 16:05:36 -0400
X-Gm-Features: AQ5f1Jpstda-gHfgzjbJnqyzChrezYj7IrAh6l6teTLh4Go1MoRlojf0RpvHWRQ
Message-ID: <CADnq5_Ov5SMAsz1yZLnUZNVdbSyX7C2959EOG1jjbudOb74qmw@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu/mes: remove unused functions
To: Alex Deucher <alexander.deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Ping?

On Wed, Mar 5, 2025 at 4:08=E2=80=AFPM Alex Deucher <alexander.deucher@amd.=
com> wrote:
>
> Leftover from the MES self tests that were removed previously.
>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c | 800 ------------------------
>  drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h |  41 --
>  2 files changed, 841 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_mes.c
> index e2007759f5b4c..3d80ed8529619 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
> @@ -39,42 +39,6 @@ int amdgpu_mes_doorbell_process_slice(struct amdgpu_de=
vice *adev)
>                        PAGE_SIZE);
>  }
>
> -static int amdgpu_mes_kernel_doorbell_get(struct amdgpu_device *adev,
> -                                        int ip_type, uint64_t *doorbell_=
index)
> -{
> -       unsigned int offset, found;
> -       struct amdgpu_mes *mes =3D &adev->mes;
> -
> -       if (ip_type =3D=3D AMDGPU_RING_TYPE_SDMA)
> -               offset =3D adev->doorbell_index.sdma_engine[0];
> -       else
> -               offset =3D 0;
> -
> -       found =3D find_next_zero_bit(mes->doorbell_bitmap, mes->num_mes_d=
bs, offset);
> -       if (found >=3D mes->num_mes_dbs) {
> -               DRM_WARN("No doorbell available\n");
> -               return -ENOSPC;
> -       }
> -
> -       set_bit(found, mes->doorbell_bitmap);
> -
> -       /* Get the absolute doorbell index on BAR */
> -       *doorbell_index =3D mes->db_start_dw_offset + found * 2;
> -       return 0;
> -}
> -
> -static void amdgpu_mes_kernel_doorbell_free(struct amdgpu_device *adev,
> -                                          uint32_t doorbell_index)
> -{
> -       unsigned int old, rel_index;
> -       struct amdgpu_mes *mes =3D &adev->mes;
> -
> -       /* Find the relative index of the doorbell in this object */
> -       rel_index =3D (doorbell_index - mes->db_start_dw_offset) / 2;
> -       old =3D test_and_clear_bit(rel_index, mes->doorbell_bitmap);
> -       WARN_ON(!old);
> -}
> -
>  static int amdgpu_mes_doorbell_init(struct amdgpu_device *adev)
>  {
>         int i;
> @@ -267,244 +231,6 @@ void amdgpu_mes_fini(struct amdgpu_device *adev)
>         mutex_destroy(&adev->mes.mutex_hidden);
>  }
>
> -static void amdgpu_mes_queue_free_mqd(struct amdgpu_mes_queue *q)
> -{
> -       amdgpu_bo_free_kernel(&q->mqd_obj,
> -                             &q->mqd_gpu_addr,
> -                             &q->mqd_cpu_ptr);
> -}
> -
> -int amdgpu_mes_create_process(struct amdgpu_device *adev, int pasid,
> -                             struct amdgpu_vm *vm)
> -{
> -       struct amdgpu_mes_process *process;
> -       int r;
> -
> -       /* allocate the mes process buffer */
> -       process =3D kzalloc(sizeof(struct amdgpu_mes_process), GFP_KERNEL=
);
> -       if (!process) {
> -               DRM_ERROR("no more memory to create mes process\n");
> -               return -ENOMEM;
> -       }
> -
> -       /* allocate the process context bo and map it */
> -       r =3D amdgpu_bo_create_kernel(adev, AMDGPU_MES_PROC_CTX_SIZE, PAG=
E_SIZE,
> -                                   AMDGPU_GEM_DOMAIN_GTT,
> -                                   &process->proc_ctx_bo,
> -                                   &process->proc_ctx_gpu_addr,
> -                                   &process->proc_ctx_cpu_ptr);
> -       if (r) {
> -               DRM_ERROR("failed to allocate process context bo\n");
> -               goto clean_up_memory;
> -       }
> -       memset(process->proc_ctx_cpu_ptr, 0, AMDGPU_MES_PROC_CTX_SIZE);
> -
> -       /*
> -        * Avoid taking any other locks under MES lock to avoid circular
> -        * lock dependencies.
> -        */
> -       amdgpu_mes_lock(&adev->mes);
> -
> -       /* add the mes process to idr list */
> -       r =3D idr_alloc(&adev->mes.pasid_idr, process, pasid, pasid + 1,
> -                     GFP_KERNEL);
> -       if (r < 0) {
> -               DRM_ERROR("failed to lock pasid=3D%d\n", pasid);
> -               goto clean_up_ctx;
> -       }
> -
> -       INIT_LIST_HEAD(&process->gang_list);
> -       process->vm =3D vm;
> -       process->pasid =3D pasid;
> -       process->process_quantum =3D adev->mes.default_process_quantum;
> -       process->pd_gpu_addr =3D amdgpu_bo_gpu_offset(vm->root.bo);
> -
> -       amdgpu_mes_unlock(&adev->mes);
> -       return 0;
> -
> -clean_up_ctx:
> -       amdgpu_mes_unlock(&adev->mes);
> -       amdgpu_bo_free_kernel(&process->proc_ctx_bo,
> -                             &process->proc_ctx_gpu_addr,
> -                             &process->proc_ctx_cpu_ptr);
> -clean_up_memory:
> -       kfree(process);
> -       return r;
> -}
> -
> -void amdgpu_mes_destroy_process(struct amdgpu_device *adev, int pasid)
> -{
> -       struct amdgpu_mes_process *process;
> -       struct amdgpu_mes_gang *gang, *tmp1;
> -       struct amdgpu_mes_queue *queue, *tmp2;
> -       struct mes_remove_queue_input queue_input;
> -       unsigned long flags;
> -       int r;
> -
> -       /*
> -        * Avoid taking any other locks under MES lock to avoid circular
> -        * lock dependencies.
> -        */
> -       amdgpu_mes_lock(&adev->mes);
> -
> -       process =3D idr_find(&adev->mes.pasid_idr, pasid);
> -       if (!process) {
> -               DRM_WARN("pasid %d doesn't exist\n", pasid);
> -               amdgpu_mes_unlock(&adev->mes);
> -               return;
> -       }
> -
> -       /* Remove all queues from hardware */
> -       list_for_each_entry_safe(gang, tmp1, &process->gang_list, list) {
> -               list_for_each_entry_safe(queue, tmp2, &gang->queue_list, =
list) {
> -                       spin_lock_irqsave(&adev->mes.queue_id_lock, flags=
);
> -                       idr_remove(&adev->mes.queue_id_idr, queue->queue_=
id);
> -                       spin_unlock_irqrestore(&adev->mes.queue_id_lock, =
flags);
> -
> -                       queue_input.doorbell_offset =3D queue->doorbell_o=
ff;
> -                       queue_input.gang_context_addr =3D gang->gang_ctx_=
gpu_addr;
> -
> -                       r =3D adev->mes.funcs->remove_hw_queue(&adev->mes=
,
> -                                                            &queue_input=
);
> -                       if (r)
> -                               DRM_WARN("failed to remove hardware queue=
\n");
> -               }
> -
> -               idr_remove(&adev->mes.gang_id_idr, gang->gang_id);
> -       }
> -
> -       idr_remove(&adev->mes.pasid_idr, pasid);
> -       amdgpu_mes_unlock(&adev->mes);
> -
> -       /* free all memory allocated by the process */
> -       list_for_each_entry_safe(gang, tmp1, &process->gang_list, list) {
> -               /* free all queues in the gang */
> -               list_for_each_entry_safe(queue, tmp2, &gang->queue_list, =
list) {
> -                       amdgpu_mes_queue_free_mqd(queue);
> -                       list_del(&queue->list);
> -                       kfree(queue);
> -               }
> -               amdgpu_bo_free_kernel(&gang->gang_ctx_bo,
> -                                     &gang->gang_ctx_gpu_addr,
> -                                     &gang->gang_ctx_cpu_ptr);
> -               list_del(&gang->list);
> -               kfree(gang);
> -
> -       }
> -       amdgpu_bo_free_kernel(&process->proc_ctx_bo,
> -                             &process->proc_ctx_gpu_addr,
> -                             &process->proc_ctx_cpu_ptr);
> -       kfree(process);
> -}
> -
> -int amdgpu_mes_add_gang(struct amdgpu_device *adev, int pasid,
> -                       struct amdgpu_mes_gang_properties *gprops,
> -                       int *gang_id)
> -{
> -       struct amdgpu_mes_process *process;
> -       struct amdgpu_mes_gang *gang;
> -       int r;
> -
> -       /* allocate the mes gang buffer */
> -       gang =3D kzalloc(sizeof(struct amdgpu_mes_gang), GFP_KERNEL);
> -       if (!gang) {
> -               return -ENOMEM;
> -       }
> -
> -       /* allocate the gang context bo and map it to cpu space */
> -       r =3D amdgpu_bo_create_kernel(adev, AMDGPU_MES_GANG_CTX_SIZE, PAG=
E_SIZE,
> -                                   AMDGPU_GEM_DOMAIN_GTT,
> -                                   &gang->gang_ctx_bo,
> -                                   &gang->gang_ctx_gpu_addr,
> -                                   &gang->gang_ctx_cpu_ptr);
> -       if (r) {
> -               DRM_ERROR("failed to allocate process context bo\n");
> -               goto clean_up_mem;
> -       }
> -       memset(gang->gang_ctx_cpu_ptr, 0, AMDGPU_MES_GANG_CTX_SIZE);
> -
> -       /*
> -        * Avoid taking any other locks under MES lock to avoid circular
> -        * lock dependencies.
> -        */
> -       amdgpu_mes_lock(&adev->mes);
> -
> -       process =3D idr_find(&adev->mes.pasid_idr, pasid);
> -       if (!process) {
> -               DRM_ERROR("pasid %d doesn't exist\n", pasid);
> -               r =3D -EINVAL;
> -               goto clean_up_ctx;
> -       }
> -
> -       /* add the mes gang to idr list */
> -       r =3D idr_alloc(&adev->mes.gang_id_idr, gang, 1, 0,
> -                     GFP_KERNEL);
> -       if (r < 0) {
> -               DRM_ERROR("failed to allocate idr for gang\n");
> -               goto clean_up_ctx;
> -       }
> -
> -       gang->gang_id =3D r;
> -       *gang_id =3D r;
> -
> -       INIT_LIST_HEAD(&gang->queue_list);
> -       gang->process =3D process;
> -       gang->priority =3D gprops->priority;
> -       gang->gang_quantum =3D gprops->gang_quantum ?
> -               gprops->gang_quantum : adev->mes.default_gang_quantum;
> -       gang->global_priority_level =3D gprops->global_priority_level;
> -       gang->inprocess_gang_priority =3D gprops->inprocess_gang_priority=
;
> -       list_add_tail(&gang->list, &process->gang_list);
> -
> -       amdgpu_mes_unlock(&adev->mes);
> -       return 0;
> -
> -clean_up_ctx:
> -       amdgpu_mes_unlock(&adev->mes);
> -       amdgpu_bo_free_kernel(&gang->gang_ctx_bo,
> -                             &gang->gang_ctx_gpu_addr,
> -                             &gang->gang_ctx_cpu_ptr);
> -clean_up_mem:
> -       kfree(gang);
> -       return r;
> -}
> -
> -int amdgpu_mes_remove_gang(struct amdgpu_device *adev, int gang_id)
> -{
> -       struct amdgpu_mes_gang *gang;
> -
> -       /*
> -        * Avoid taking any other locks under MES lock to avoid circular
> -        * lock dependencies.
> -        */
> -       amdgpu_mes_lock(&adev->mes);
> -
> -       gang =3D idr_find(&adev->mes.gang_id_idr, gang_id);
> -       if (!gang) {
> -               DRM_ERROR("gang id %d doesn't exist\n", gang_id);
> -               amdgpu_mes_unlock(&adev->mes);
> -               return -EINVAL;
> -       }
> -
> -       if (!list_empty(&gang->queue_list)) {
> -               DRM_ERROR("queue list is not empty\n");
> -               amdgpu_mes_unlock(&adev->mes);
> -               return -EBUSY;
> -       }
> -
> -       idr_remove(&adev->mes.gang_id_idr, gang->gang_id);
> -       list_del(&gang->list);
> -       amdgpu_mes_unlock(&adev->mes);
> -
> -       amdgpu_bo_free_kernel(&gang->gang_ctx_bo,
> -                             &gang->gang_ctx_gpu_addr,
> -                             &gang->gang_ctx_cpu_ptr);
> -
> -       kfree(gang);
> -
> -       return 0;
> -}
> -
>  int amdgpu_mes_suspend(struct amdgpu_device *adev)
>  {
>         struct mes_suspend_gang_input input;
> @@ -553,241 +279,6 @@ int amdgpu_mes_resume(struct amdgpu_device *adev)
>         return r;
>  }
>
> -static int amdgpu_mes_queue_alloc_mqd(struct amdgpu_device *adev,
> -                                    struct amdgpu_mes_queue *q,
> -                                    struct amdgpu_mes_queue_properties *=
p)
> -{
> -       struct amdgpu_mqd *mqd_mgr =3D &adev->mqds[p->queue_type];
> -       u32 mqd_size =3D mqd_mgr->mqd_size;
> -       int r;
> -
> -       r =3D amdgpu_bo_create_kernel(adev, mqd_size, PAGE_SIZE,
> -                                   AMDGPU_GEM_DOMAIN_GTT,
> -                                   &q->mqd_obj,
> -                                   &q->mqd_gpu_addr, &q->mqd_cpu_ptr);
> -       if (r) {
> -               dev_warn(adev->dev, "failed to create queue mqd bo (%d)",=
 r);
> -               return r;
> -       }
> -       memset(q->mqd_cpu_ptr, 0, mqd_size);
> -
> -       r =3D amdgpu_bo_reserve(q->mqd_obj, false);
> -       if (unlikely(r !=3D 0))
> -               goto clean_up;
> -
> -       return 0;
> -
> -clean_up:
> -       amdgpu_bo_free_kernel(&q->mqd_obj,
> -                             &q->mqd_gpu_addr,
> -                             &q->mqd_cpu_ptr);
> -       return r;
> -}
> -
> -static void amdgpu_mes_queue_init_mqd(struct amdgpu_device *adev,
> -                                    struct amdgpu_mes_queue *q,
> -                                    struct amdgpu_mes_queue_properties *=
p)
> -{
> -       struct amdgpu_mqd *mqd_mgr =3D &adev->mqds[p->queue_type];
> -       struct amdgpu_mqd_prop mqd_prop =3D {0};
> -
> -       mqd_prop.mqd_gpu_addr =3D q->mqd_gpu_addr;
> -       mqd_prop.hqd_base_gpu_addr =3D p->hqd_base_gpu_addr;
> -       mqd_prop.rptr_gpu_addr =3D p->rptr_gpu_addr;
> -       mqd_prop.wptr_gpu_addr =3D p->wptr_gpu_addr;
> -       mqd_prop.queue_size =3D p->queue_size;
> -       mqd_prop.use_doorbell =3D true;
> -       mqd_prop.doorbell_index =3D p->doorbell_off;
> -       mqd_prop.eop_gpu_addr =3D p->eop_gpu_addr;
> -       mqd_prop.hqd_pipe_priority =3D p->hqd_pipe_priority;
> -       mqd_prop.hqd_queue_priority =3D p->hqd_queue_priority;
> -       mqd_prop.hqd_active =3D false;
> -
> -       if (p->queue_type =3D=3D AMDGPU_RING_TYPE_GFX ||
> -           p->queue_type =3D=3D AMDGPU_RING_TYPE_COMPUTE) {
> -               mutex_lock(&adev->srbm_mutex);
> -               amdgpu_gfx_select_me_pipe_q(adev, p->ring->me, p->ring->p=
ipe, 0, 0, 0);
> -       }
> -
> -       mqd_mgr->init_mqd(adev, q->mqd_cpu_ptr, &mqd_prop);
> -
> -       if (p->queue_type =3D=3D AMDGPU_RING_TYPE_GFX ||
> -           p->queue_type =3D=3D AMDGPU_RING_TYPE_COMPUTE) {
> -               amdgpu_gfx_select_me_pipe_q(adev, 0, 0, 0, 0, 0);
> -               mutex_unlock(&adev->srbm_mutex);
> -       }
> -
> -       amdgpu_bo_unreserve(q->mqd_obj);
> -}
> -
> -int amdgpu_mes_add_hw_queue(struct amdgpu_device *adev, int gang_id,
> -                           struct amdgpu_mes_queue_properties *qprops,
> -                           int *queue_id)
> -{
> -       struct amdgpu_mes_queue *queue;
> -       struct amdgpu_mes_gang *gang;
> -       struct mes_add_queue_input queue_input;
> -       unsigned long flags;
> -       int r;
> -
> -       memset(&queue_input, 0, sizeof(struct mes_add_queue_input));
> -
> -       /* allocate the mes queue buffer */
> -       queue =3D kzalloc(sizeof(struct amdgpu_mes_queue), GFP_KERNEL);
> -       if (!queue) {
> -               DRM_ERROR("Failed to allocate memory for queue\n");
> -               return -ENOMEM;
> -       }
> -
> -       /* Allocate the queue mqd */
> -       r =3D amdgpu_mes_queue_alloc_mqd(adev, queue, qprops);
> -       if (r)
> -               goto clean_up_memory;
> -
> -       /*
> -        * Avoid taking any other locks under MES lock to avoid circular
> -        * lock dependencies.
> -        */
> -       amdgpu_mes_lock(&adev->mes);
> -
> -       gang =3D idr_find(&adev->mes.gang_id_idr, gang_id);
> -       if (!gang) {
> -               DRM_ERROR("gang id %d doesn't exist\n", gang_id);
> -               r =3D -EINVAL;
> -               goto clean_up_mqd;
> -       }
> -
> -       /* add the mes gang to idr list */
> -       spin_lock_irqsave(&adev->mes.queue_id_lock, flags);
> -       r =3D idr_alloc(&adev->mes.queue_id_idr, queue, 1, 0,
> -                     GFP_ATOMIC);
> -       if (r < 0) {
> -               spin_unlock_irqrestore(&adev->mes.queue_id_lock, flags);
> -               goto clean_up_mqd;
> -       }
> -       spin_unlock_irqrestore(&adev->mes.queue_id_lock, flags);
> -       *queue_id =3D queue->queue_id =3D r;
> -
> -       /* allocate a doorbell index for the queue */
> -       r =3D amdgpu_mes_kernel_doorbell_get(adev,
> -                                         qprops->queue_type,
> -                                         &qprops->doorbell_off);
> -       if (r)
> -               goto clean_up_queue_id;
> -
> -       /* initialize the queue mqd */
> -       amdgpu_mes_queue_init_mqd(adev, queue, qprops);
> -
> -       /* add hw queue to mes */
> -       queue_input.process_id =3D gang->process->pasid;
> -
> -       queue_input.page_table_base_addr =3D
> -               adev->vm_manager.vram_base_offset + gang->process->pd_gpu=
_addr -
> -               adev->gmc.vram_start;
> -
> -       queue_input.process_va_start =3D 0;
> -       queue_input.process_va_end =3D adev->vm_manager.max_pfn - 1;
> -       queue_input.process_quantum =3D gang->process->process_quantum;
> -       queue_input.process_context_addr =3D gang->process->proc_ctx_gpu_=
addr;
> -       queue_input.gang_quantum =3D gang->gang_quantum;
> -       queue_input.gang_context_addr =3D gang->gang_ctx_gpu_addr;
> -       queue_input.inprocess_gang_priority =3D gang->inprocess_gang_prio=
rity;
> -       queue_input.gang_global_priority_level =3D gang->global_priority_=
level;
> -       queue_input.doorbell_offset =3D qprops->doorbell_off;
> -       queue_input.mqd_addr =3D queue->mqd_gpu_addr;
> -       queue_input.wptr_addr =3D qprops->wptr_gpu_addr;
> -       queue_input.wptr_mc_addr =3D qprops->wptr_mc_addr;
> -       queue_input.queue_type =3D qprops->queue_type;
> -       queue_input.paging =3D qprops->paging;
> -       queue_input.is_kfd_process =3D 0;
> -
> -       r =3D adev->mes.funcs->add_hw_queue(&adev->mes, &queue_input);
> -       if (r) {
> -               DRM_ERROR("failed to add hardware queue to MES, doorbell=
=3D0x%llx\n",
> -                         qprops->doorbell_off);
> -               goto clean_up_doorbell;
> -       }
> -
> -       DRM_DEBUG("MES hw queue was added, pasid=3D%d, gang id=3D%d, "
> -                 "queue type=3D%d, doorbell=3D0x%llx\n",
> -                 gang->process->pasid, gang_id, qprops->queue_type,
> -                 qprops->doorbell_off);
> -
> -       queue->ring =3D qprops->ring;
> -       queue->doorbell_off =3D qprops->doorbell_off;
> -       queue->wptr_gpu_addr =3D qprops->wptr_gpu_addr;
> -       queue->queue_type =3D qprops->queue_type;
> -       queue->paging =3D qprops->paging;
> -       queue->gang =3D gang;
> -       queue->ring->mqd_ptr =3D queue->mqd_cpu_ptr;
> -       list_add_tail(&queue->list, &gang->queue_list);
> -
> -       amdgpu_mes_unlock(&adev->mes);
> -       return 0;
> -
> -clean_up_doorbell:
> -       amdgpu_mes_kernel_doorbell_free(adev, qprops->doorbell_off);
> -clean_up_queue_id:
> -       spin_lock_irqsave(&adev->mes.queue_id_lock, flags);
> -       idr_remove(&adev->mes.queue_id_idr, queue->queue_id);
> -       spin_unlock_irqrestore(&adev->mes.queue_id_lock, flags);
> -clean_up_mqd:
> -       amdgpu_mes_unlock(&adev->mes);
> -       amdgpu_mes_queue_free_mqd(queue);
> -clean_up_memory:
> -       kfree(queue);
> -       return r;
> -}
> -
> -int amdgpu_mes_remove_hw_queue(struct amdgpu_device *adev, int queue_id)
> -{
> -       unsigned long flags;
> -       struct amdgpu_mes_queue *queue;
> -       struct amdgpu_mes_gang *gang;
> -       struct mes_remove_queue_input queue_input;
> -       int r;
> -
> -       /*
> -        * Avoid taking any other locks under MES lock to avoid circular
> -        * lock dependencies.
> -        */
> -       amdgpu_mes_lock(&adev->mes);
> -
> -       /* remove the mes gang from idr list */
> -       spin_lock_irqsave(&adev->mes.queue_id_lock, flags);
> -
> -       queue =3D idr_find(&adev->mes.queue_id_idr, queue_id);
> -       if (!queue) {
> -               spin_unlock_irqrestore(&adev->mes.queue_id_lock, flags);
> -               amdgpu_mes_unlock(&adev->mes);
> -               DRM_ERROR("queue id %d doesn't exist\n", queue_id);
> -               return -EINVAL;
> -       }
> -
> -       idr_remove(&adev->mes.queue_id_idr, queue_id);
> -       spin_unlock_irqrestore(&adev->mes.queue_id_lock, flags);
> -
> -       DRM_DEBUG("try to remove queue, doorbell off =3D 0x%llx\n",
> -                 queue->doorbell_off);
> -
> -       gang =3D queue->gang;
> -       queue_input.doorbell_offset =3D queue->doorbell_off;
> -       queue_input.gang_context_addr =3D gang->gang_ctx_gpu_addr;
> -
> -       r =3D adev->mes.funcs->remove_hw_queue(&adev->mes, &queue_input);
> -       if (r)
> -               DRM_ERROR("failed to remove hardware queue, queue id =3D =
%d\n",
> -                         queue_id);
> -
> -       list_del(&queue->list);
> -       amdgpu_mes_kernel_doorbell_free(adev, queue->doorbell_off);
> -       amdgpu_mes_unlock(&adev->mes);
> -
> -       amdgpu_mes_queue_free_mqd(queue);
> -       kfree(queue);
> -       return 0;
> -}
> -
>  int amdgpu_mes_reset_hw_queue(struct amdgpu_device *adev, int queue_id)
>  {
>         unsigned long flags;
> @@ -1101,25 +592,6 @@ int amdgpu_mes_flush_shader_debugger(struct amdgpu_=
device *adev,
>         return r;
>  }
>
> -static void
> -amdgpu_mes_ring_to_queue_props(struct amdgpu_device *adev,
> -                              struct amdgpu_ring *ring,
> -                              struct amdgpu_mes_queue_properties *props)
> -{
> -       props->queue_type =3D ring->funcs->type;
> -       props->hqd_base_gpu_addr =3D ring->gpu_addr;
> -       props->rptr_gpu_addr =3D ring->rptr_gpu_addr;
> -       props->wptr_gpu_addr =3D ring->wptr_gpu_addr;
> -       props->wptr_mc_addr =3D
> -               ring->mes_ctx->meta_data_mc_addr + ring->wptr_offs;
> -       props->queue_size =3D ring->ring_size;
> -       props->eop_gpu_addr =3D ring->eop_gpu_addr;
> -       props->hqd_pipe_priority =3D AMDGPU_GFX_PIPE_PRIO_NORMAL;
> -       props->hqd_queue_priority =3D AMDGPU_GFX_QUEUE_PRIORITY_MINIMUM;
> -       props->paging =3D false;
> -       props->ring =3D ring;
> -}
> -
>  #define DEFINE_AMDGPU_MES_CTX_GET_OFFS_ENG(_eng)                       \
>  do {                                                                   \
>         if (id_offs < AMDGPU_MES_CTX_MAX_OFFS)                          \
> @@ -1156,284 +628,12 @@ int amdgpu_mes_ctx_get_offs(struct amdgpu_ring *r=
ing, unsigned int id_offs)
>         return -EINVAL;
>  }
>
> -int amdgpu_mes_add_ring(struct amdgpu_device *adev, int gang_id,
> -                       int queue_type, int idx,
> -                       struct amdgpu_mes_ctx_data *ctx_data,
> -                       struct amdgpu_ring **out)
> -{
> -       struct amdgpu_ring *ring;
> -       struct amdgpu_mes_gang *gang;
> -       struct amdgpu_mes_queue_properties qprops =3D {0};
> -       int r, queue_id, pasid;
> -
> -       /*
> -        * Avoid taking any other locks under MES lock to avoid circular
> -        * lock dependencies.
> -        */
> -       amdgpu_mes_lock(&adev->mes);
> -       gang =3D idr_find(&adev->mes.gang_id_idr, gang_id);
> -       if (!gang) {
> -               DRM_ERROR("gang id %d doesn't exist\n", gang_id);
> -               amdgpu_mes_unlock(&adev->mes);
> -               return -EINVAL;
> -       }
> -       pasid =3D gang->process->pasid;
> -
> -       ring =3D kzalloc(sizeof(struct amdgpu_ring), GFP_KERNEL);
> -       if (!ring) {
> -               amdgpu_mes_unlock(&adev->mes);
> -               return -ENOMEM;
> -       }
> -
> -       ring->ring_obj =3D NULL;
> -       ring->use_doorbell =3D true;
> -       ring->is_mes_queue =3D true;
> -       ring->mes_ctx =3D ctx_data;
> -       ring->idx =3D idx;
> -       ring->no_scheduler =3D true;
> -
> -       if (queue_type =3D=3D AMDGPU_RING_TYPE_COMPUTE) {
> -               int offset =3D offsetof(struct amdgpu_mes_ctx_meta_data,
> -                                     compute[ring->idx].mec_hpd);
> -               ring->eop_gpu_addr =3D
> -                       amdgpu_mes_ctx_get_offs_gpu_addr(ring, offset);
> -       }
> -
> -       switch (queue_type) {
> -       case AMDGPU_RING_TYPE_GFX:
> -               ring->funcs =3D adev->gfx.gfx_ring[0].funcs;
> -               ring->me =3D adev->gfx.gfx_ring[0].me;
> -               ring->pipe =3D adev->gfx.gfx_ring[0].pipe;
> -               break;
> -       case AMDGPU_RING_TYPE_COMPUTE:
> -               ring->funcs =3D adev->gfx.compute_ring[0].funcs;
> -               ring->me =3D adev->gfx.compute_ring[0].me;
> -               ring->pipe =3D adev->gfx.compute_ring[0].pipe;
> -               break;
> -       case AMDGPU_RING_TYPE_SDMA:
> -               ring->funcs =3D adev->sdma.instance[0].ring.funcs;
> -               break;
> -       default:
> -               BUG();
> -       }
> -
> -       r =3D amdgpu_ring_init(adev, ring, 1024, NULL, 0,
> -                            AMDGPU_RING_PRIO_DEFAULT, NULL);
> -       if (r) {
> -               amdgpu_mes_unlock(&adev->mes);
> -               goto clean_up_memory;
> -       }
> -
> -       amdgpu_mes_ring_to_queue_props(adev, ring, &qprops);
> -
> -       dma_fence_wait(gang->process->vm->last_update, false);
> -       dma_fence_wait(ctx_data->meta_data_va->last_pt_update, false);
> -       amdgpu_mes_unlock(&adev->mes);
> -
> -       r =3D amdgpu_mes_add_hw_queue(adev, gang_id, &qprops, &queue_id);
> -       if (r)
> -               goto clean_up_ring;
> -
> -       ring->hw_queue_id =3D queue_id;
> -       ring->doorbell_index =3D qprops.doorbell_off;
> -
> -       if (queue_type =3D=3D AMDGPU_RING_TYPE_GFX)
> -               sprintf(ring->name, "gfx_%d.%d.%d", pasid, gang_id, queue=
_id);
> -       else if (queue_type =3D=3D AMDGPU_RING_TYPE_COMPUTE)
> -               sprintf(ring->name, "compute_%d.%d.%d", pasid, gang_id,
> -                       queue_id);
> -       else if (queue_type =3D=3D AMDGPU_RING_TYPE_SDMA)
> -               sprintf(ring->name, "sdma_%d.%d.%d", pasid, gang_id,
> -                       queue_id);
> -       else
> -               BUG();
> -
> -       *out =3D ring;
> -       return 0;
> -
> -clean_up_ring:
> -       amdgpu_ring_fini(ring);
> -clean_up_memory:
> -       kfree(ring);
> -       return r;
> -}
> -
> -void amdgpu_mes_remove_ring(struct amdgpu_device *adev,
> -                           struct amdgpu_ring *ring)
> -{
> -       if (!ring)
> -               return;
> -
> -       amdgpu_mes_remove_hw_queue(adev, ring->hw_queue_id);
> -       del_timer_sync(&ring->fence_drv.fallback_timer);
> -       amdgpu_ring_fini(ring);
> -       kfree(ring);
> -}
> -
>  uint32_t amdgpu_mes_get_aggregated_doorbell_index(struct amdgpu_device *=
adev,
>                                                    enum amdgpu_mes_priori=
ty_level prio)
>  {
>         return adev->mes.aggregated_doorbells[prio];
>  }
>
> -int amdgpu_mes_ctx_alloc_meta_data(struct amdgpu_device *adev,
> -                                  struct amdgpu_mes_ctx_data *ctx_data)
> -{
> -       int r;
> -
> -       r =3D amdgpu_bo_create_kernel(adev,
> -                           sizeof(struct amdgpu_mes_ctx_meta_data),
> -                           PAGE_SIZE, AMDGPU_GEM_DOMAIN_GTT,
> -                           &ctx_data->meta_data_obj,
> -                           &ctx_data->meta_data_mc_addr,
> -                           &ctx_data->meta_data_ptr);
> -       if (r) {
> -               dev_warn(adev->dev, "(%d) create CTX bo failed\n", r);
> -               return r;
> -       }
> -
> -       if (!ctx_data->meta_data_obj)
> -               return -ENOMEM;
> -
> -       memset(ctx_data->meta_data_ptr, 0,
> -              sizeof(struct amdgpu_mes_ctx_meta_data));
> -
> -       return 0;
> -}
> -
> -void amdgpu_mes_ctx_free_meta_data(struct amdgpu_mes_ctx_data *ctx_data)
> -{
> -       if (ctx_data->meta_data_obj)
> -               amdgpu_bo_free_kernel(&ctx_data->meta_data_obj,
> -                                     &ctx_data->meta_data_mc_addr,
> -                                     &ctx_data->meta_data_ptr);
> -}
> -
> -int amdgpu_mes_ctx_map_meta_data(struct amdgpu_device *adev,
> -                                struct amdgpu_vm *vm,
> -                                struct amdgpu_mes_ctx_data *ctx_data)
> -{
> -       struct amdgpu_bo_va *bo_va;
> -       struct amdgpu_sync sync;
> -       struct drm_exec exec;
> -       int r;
> -
> -       amdgpu_sync_create(&sync);
> -
> -       drm_exec_init(&exec, 0, 0);
> -       drm_exec_until_all_locked(&exec) {
> -               r =3D drm_exec_lock_obj(&exec,
> -                                     &ctx_data->meta_data_obj->tbo.base)=
;
> -               drm_exec_retry_on_contention(&exec);
> -               if (unlikely(r))
> -                       goto error_fini_exec;
> -
> -               r =3D amdgpu_vm_lock_pd(vm, &exec, 0);
> -               drm_exec_retry_on_contention(&exec);
> -               if (unlikely(r))
> -                       goto error_fini_exec;
> -       }
> -
> -       bo_va =3D amdgpu_vm_bo_add(adev, vm, ctx_data->meta_data_obj);
> -       if (!bo_va) {
> -               DRM_ERROR("failed to create bo_va for meta data BO\n");
> -               r =3D -ENOMEM;
> -               goto error_fini_exec;
> -       }
> -
> -       r =3D amdgpu_vm_bo_map(adev, bo_va, ctx_data->meta_data_gpu_addr,=
 0,
> -                            sizeof(struct amdgpu_mes_ctx_meta_data),
> -                            AMDGPU_PTE_READABLE | AMDGPU_PTE_WRITEABLE |
> -                            AMDGPU_PTE_EXECUTABLE);
> -
> -       if (r) {
> -               DRM_ERROR("failed to do bo_map on meta data, err=3D%d\n",=
 r);
> -               goto error_del_bo_va;
> -       }
> -
> -       r =3D amdgpu_vm_bo_update(adev, bo_va, false);
> -       if (r) {
> -               DRM_ERROR("failed to do vm_bo_update on meta data\n");
> -               goto error_del_bo_va;
> -       }
> -       amdgpu_sync_fence(&sync, bo_va->last_pt_update);
> -
> -       r =3D amdgpu_vm_update_pdes(adev, vm, false);
> -       if (r) {
> -               DRM_ERROR("failed to update pdes on meta data\n");
> -               goto error_del_bo_va;
> -       }
> -       amdgpu_sync_fence(&sync, vm->last_update);
> -
> -       amdgpu_sync_wait(&sync, false);
> -       drm_exec_fini(&exec);
> -
> -       amdgpu_sync_free(&sync);
> -       ctx_data->meta_data_va =3D bo_va;
> -       return 0;
> -
> -error_del_bo_va:
> -       amdgpu_vm_bo_del(adev, bo_va);
> -
> -error_fini_exec:
> -       drm_exec_fini(&exec);
> -       amdgpu_sync_free(&sync);
> -       return r;
> -}
> -
> -int amdgpu_mes_ctx_unmap_meta_data(struct amdgpu_device *adev,
> -                                  struct amdgpu_mes_ctx_data *ctx_data)
> -{
> -       struct amdgpu_bo_va *bo_va =3D ctx_data->meta_data_va;
> -       struct amdgpu_bo *bo =3D ctx_data->meta_data_obj;
> -       struct amdgpu_vm *vm =3D bo_va->base.vm;
> -       struct dma_fence *fence;
> -       struct drm_exec exec;
> -       long r;
> -
> -       drm_exec_init(&exec, 0, 0);
> -       drm_exec_until_all_locked(&exec) {
> -               r =3D drm_exec_lock_obj(&exec,
> -                                     &ctx_data->meta_data_obj->tbo.base)=
;
> -               drm_exec_retry_on_contention(&exec);
> -               if (unlikely(r))
> -                       goto out_unlock;
> -
> -               r =3D amdgpu_vm_lock_pd(vm, &exec, 0);
> -               drm_exec_retry_on_contention(&exec);
> -               if (unlikely(r))
> -                       goto out_unlock;
> -       }
> -
> -       amdgpu_vm_bo_del(adev, bo_va);
> -       if (!amdgpu_vm_ready(vm))
> -               goto out_unlock;
> -
> -       r =3D dma_resv_get_singleton(bo->tbo.base.resv, DMA_RESV_USAGE_BO=
OKKEEP,
> -                                  &fence);
> -       if (r)
> -               goto out_unlock;
> -       if (fence) {
> -               amdgpu_bo_fence(bo, fence, true);
> -               fence =3D NULL;
> -       }
> -
> -       r =3D amdgpu_vm_clear_freed(adev, vm, &fence);
> -       if (r || !fence)
> -               goto out_unlock;
> -
> -       dma_fence_wait(fence, false);
> -       amdgpu_bo_fence(bo, fence, true);
> -       dma_fence_put(fence);
> -
> -out_unlock:
> -       if (unlikely(r < 0))
> -               dev_err(adev->dev, "failed to clear page tables (%ld)\n",=
 r);
> -       drm_exec_fini(&exec);
> -
> -       return r;
> -}
> -
>  int amdgpu_mes_init_microcode(struct amdgpu_device *adev, int pipe)
>  {
>         const struct mes_firmware_header_v1_0 *mes_hdr;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_mes.h
> index 4391b3383f0c3..98b9c3738a12d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
> @@ -149,19 +149,6 @@ struct amdgpu_mes {
>
>  };
>
> -struct amdgpu_mes_process {
> -       int                     pasid;
> -       struct                  amdgpu_vm *vm;
> -       uint64_t                pd_gpu_addr;
> -       struct amdgpu_bo        *proc_ctx_bo;
> -       uint64_t                proc_ctx_gpu_addr;
> -       void                    *proc_ctx_cpu_ptr;
> -       uint64_t                process_quantum;
> -       struct                  list_head gang_list;
> -       uint32_t                doorbell_index;
> -       struct mutex            doorbell_lock;
> -};
> -
>  struct amdgpu_mes_gang {
>         int                             gang_id;
>         int                             priority;
> @@ -404,22 +391,9 @@ int amdgpu_mes_init_microcode(struct amdgpu_device *=
adev, int pipe);
>  int amdgpu_mes_init(struct amdgpu_device *adev);
>  void amdgpu_mes_fini(struct amdgpu_device *adev);
>
> -int amdgpu_mes_create_process(struct amdgpu_device *adev, int pasid,
> -                             struct amdgpu_vm *vm);
> -void amdgpu_mes_destroy_process(struct amdgpu_device *adev, int pasid);
> -
> -int amdgpu_mes_add_gang(struct amdgpu_device *adev, int pasid,
> -                       struct amdgpu_mes_gang_properties *gprops,
> -                       int *gang_id);
> -int amdgpu_mes_remove_gang(struct amdgpu_device *adev, int gang_id);
> -
>  int amdgpu_mes_suspend(struct amdgpu_device *adev);
>  int amdgpu_mes_resume(struct amdgpu_device *adev);
>
> -int amdgpu_mes_add_hw_queue(struct amdgpu_device *adev, int gang_id,
> -                           struct amdgpu_mes_queue_properties *qprops,
> -                           int *queue_id);
> -int amdgpu_mes_remove_hw_queue(struct amdgpu_device *adev, int queue_id)=
;
>  int amdgpu_mes_reset_hw_queue(struct amdgpu_device *adev, int queue_id);
>  int amdgpu_mes_reset_hw_queue_mmio(struct amdgpu_device *adev, int queue=
_type,
>                                    int me_id, int pipe_id, int queue_id, =
int vmid);
> @@ -451,25 +425,10 @@ int amdgpu_mes_set_shader_debugger(struct amdgpu_de=
vice *adev,
>                                 bool trap_en);
>  int amdgpu_mes_flush_shader_debugger(struct amdgpu_device *adev,
>                                 uint64_t process_context_addr);
> -int amdgpu_mes_add_ring(struct amdgpu_device *adev, int gang_id,
> -                       int queue_type, int idx,
> -                       struct amdgpu_mes_ctx_data *ctx_data,
> -                       struct amdgpu_ring **out);
> -void amdgpu_mes_remove_ring(struct amdgpu_device *adev,
> -                           struct amdgpu_ring *ring);
>
>  uint32_t amdgpu_mes_get_aggregated_doorbell_index(struct amdgpu_device *=
adev,
>                                                    enum amdgpu_mes_priori=
ty_level prio);
>
> -int amdgpu_mes_ctx_alloc_meta_data(struct amdgpu_device *adev,
> -                                  struct amdgpu_mes_ctx_data *ctx_data);
> -void amdgpu_mes_ctx_free_meta_data(struct amdgpu_mes_ctx_data *ctx_data)=
;
> -int amdgpu_mes_ctx_map_meta_data(struct amdgpu_device *adev,
> -                                struct amdgpu_vm *vm,
> -                                struct amdgpu_mes_ctx_data *ctx_data);
> -int amdgpu_mes_ctx_unmap_meta_data(struct amdgpu_device *adev,
> -                                  struct amdgpu_mes_ctx_data *ctx_data);
> -
>  int amdgpu_mes_doorbell_process_slice(struct amdgpu_device *adev);
>
>  /*
> --
> 2.48.1
>
