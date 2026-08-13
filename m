Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74174C5B572
	for <amd-gfx@archiver.kernel.org>; Thu, 13 Aug 2026 15:35:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E224910F3AF;
	Thu, 13 Aug 2026 15:35:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="pkY2XH63";
	dkim-atps=neutral
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com
 [209.85.215.177])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 16BA710F3AF
 for <amd-gfx@lists.freedesktop.org>; Thu, 13 Aug 2026 15:35:57 +0000 (UTC)
Received: by mail-pg1-f177.google.com with SMTP id
 41be03b00d2f7-cbedf082ba2so182284a12.1
 for <amd-gfx@lists.freedesktop.org>; Thu, 13 Aug 2026 08:35:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786635356; cv=none;
 d=google.com; s=arc-20260327;
 b=pwZ6Oa7ejFyXiita4yfUrhRlzSiD7bte0HC2xrKXoSZRxA0rhcKuQLMK2miFmUJivr
 47f3KiBHUrj6zoh0S4STkKsMhRRkm5v60It1A4MFIAsqU23KKj7PwvWrMv5RXLwSrlL0
 HsyKEE37amNINTN3F2NH7xbTJmhhGxonhYWDt3tK1RLmfHLnk+2ZEcI1hFtV5Lk3MXSv
 7MXIFdo0ARr4aES/jzwWQtk7payDrjIXrmM7D8XaC32nTKtip1ef7yIJht0Xxt7e8l80
 oSAVmW4cbJgKhvtw8k7h+edAUTslOI+SHm5BOHV2j77ONPQWzS8ey7hwbXsIO5mEq49h
 D14w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=ivDWIwnUxZc2AGdy9XRehIQ5EJ+ieiHqXBSWjR87Z2g=;
 fh=+eThy+SqkAKnFARuDzr1zv1dJvMsEMaVjoQ1eiAy49w=;
 b=WLH/iDDaj6QVh5a1tSLgBYdvQgkQPk+lHstRY862vLwgtnqux2wU0I/9LnuyBc9YZG
 RjbV3TNFhdjVwAQCiA7rWM0mnHclzKrtKuLMFYToRkQEMMnzQr2+yfVWaSWB+QfiDFjH
 DO3dRQLkxRCkDeMyq5gEBpxC8qDVObv45yHNAuaW7aV95GCB7R3W0d0j6/erUhkXXmAk
 Y2m/vh5H+YtuK4KOV/+wKWBBZcVKaqL+iP4JOoubZIJ9gAyNNpC4hLn05d2uiZ1a3A63
 7Voe5w9CqtZL6m4ZtxBVdDnz3xzy/Jk9yEzNHwD2otpmNMOc5XHRydbzyae7cTw/gLVv
 gJqA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786635356; x=1787240156; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=ivDWIwnUxZc2AGdy9XRehIQ5EJ+ieiHqXBSWjR87Z2g=;
 b=pkY2XH63UM7kyGK5HeloXtDz/Ull8aeovIDdswGuGmDjhbesBfcpVMSev88e8O+oFY
 fKX00cMosTH+D/TSTQbRqvUuRCvsIAZxBDHUje/DGMuGMrasJxJTcwdJi5COlmwgdyRm
 rTlh3tn3SM18elHY0X6FsTbSNFAmQCFwe8cc+/8uGjnlzc/BU0YP5vPbftwiBtFIxUph
 iWLvhePKyTgV9H4p0vNW3upJwYOeDvnoeTV53iUUqf3oTr/jIc0h20XjMU8DAlOtWNt1
 JAY4vRKjyEc0ZMggw2Xrp0+IXURrLeiWo1WlbZSZl7aB2ggX/TRt01ZHA5HqVM3cQ/pz
 c8sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786635356; x=1787240156;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ivDWIwnUxZc2AGdy9XRehIQ5EJ+ieiHqXBSWjR87Z2g=;
 b=Iy6kca/LbDsCOyOoFEMt9JbYuu9hxRzgnBd/1z33N5SSCNs2MZdI3UuVRmsUmkMVHh
 cr3W4pgnWpOFOQu3sRpYSiw4yhkSBTiH4lNo/llgAKg6GhqoQYHD0FVgA4sCJ+KBbwFc
 669oUGcill3oKgDSa9sKPm6lckeSKCUcLPuTZRxUon9DwETnCy+N9Tvb53wKNlIgDB+O
 PDcz0HEwIuL688GJCGuZT4Oh+kEBFpXG67nIrC1Bf3nyRbItioQr4MoNR0PF0gtjg950
 DCQy2JSxvRb9Ae9hfrdOYPrD7KM2UaxklTlQ7Su+upnrlogjdhaVY5RGMCqhxM2Zdpj6
 CPeg==
X-Gm-Message-State: AOJu0Ywc920JuSwERt2VB2lvMwijWgZhiuZgcC72DYfEkqPikm1rRl9w
 KyJkak7r1N/FET1kjtup9RMFfDWKXYFv/yLNv7foxZ0p1dpaz/CSmwBgrfMZCCXT6yiIKU3/fMs
 HWRoWiB6qdbiGn4Jp4+VWFEqWRtNwpqw=
X-Gm-Gg: AR+sD12N0EC9kCe7IKp+KIwk0SSLfkrVQxQzkcwHYuOO/rjxiDf3Irqgutv9gCqYwSM
 Gfn0d6bpCDfUD7K4kR3/hV0EgPc/7yIEij6PBtZWYrQZe6GMsz9uPNmMF7sbwL0a7jZVYg9XPQR
 tKHLqwHCIZsRRSfoW5OK0NE+V1OLRh2nCUGVmsmVcHzs/9m07B0PUWO4TOogG8Xs5Idf4okfWmS
 b7xP5JheEV+cD7Zy5vv/UAVSe0ZVSHbHZTwiet/doHypWoGUHvY8JfpdQxxVSQ3bPjfRsk6SShL
 c/QuYB6eQ7Nyuf51FJTRb7uGZo9PG6QPCkkkh8wKbl9HHo+wevxWq6RtkXcfsDlyWrGAyZrZ9yg
 6YwzonW100XJE5UocpbWNolpO4GFifRjNRsAXo5B7Ig==
X-Received: by 2002:a17:90b:4fc2:b0:38e:6a7c:abbc with SMTP id
 98e67ed59e1d1-3932333a526mr4358506a91.3.1786635356331; Thu, 13 Aug 2026
 08:35:56 -0700 (PDT)
MIME-Version: 1.0
References: <20260805212722.247508-1-jinhuieric.huang@amd.com>
 <20260805212722.247508-2-jinhuieric.huang@amd.com>
In-Reply-To: <20260805212722.247508-2-jinhuieric.huang@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 13 Aug 2026 11:35:44 -0400
X-Gm-Features: AUfX_mx83DCFn58an-kbXR-SvGrGlbiS-mZP2PZh2P65o88oBbyYvSYm5Dh0cDM
Message-ID: <CADnq5_MHUxZodPfV1qDrAQirf4xP3=RpReNGaFUrfEGEHofGxQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] drm/amdkfd: workaround 100% gpu usage issue for gfx11
To: Eric Huang <jinhuieric.huang@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Tishko.Araz@amd.com
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

On Wed, Aug 5, 2026 at 6:23=E2=80=AFPM Eric Huang <jinhuieric.huang@amd.com=
> wrote:
>
> the issue only happens with oversubscription when gpu has no
> workload, the root cause is mes oversubscription timer, so
> disable mes timer and make a similar timer in kfd to resolve
> the issue.

This should only be enabled on FW versions which support it.
Additionally, we need similar treatment for KGD userqs if we make this
change.

Alex

>
> Signed-off-by: Eric Huang <jinhuieric.huang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/mes_v11_0.c        |  1 -
>  .../drm/amd/amdkfd/kfd_device_queue_manager.c | 39 ++++++++++++++++++-
>  .../drm/amd/amdkfd/kfd_device_queue_manager.h |  1 +
>  3 files changed, 39 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c b/drivers/gpu/drm/amd=
/amdgpu/mes_v11_0.c
> index bc0ee6ccfca7..40683db66a13 100644
> --- a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
> @@ -1019,7 +1019,6 @@ static int mes_v11_0_set_hw_resources(struct amdgpu=
_mes *mes)
>         mes_set_hw_res_pkt.use_different_vmid_compute =3D 1;
>         mes_set_hw_res_pkt.enable_reg_active_poll =3D 1;
>         mes_set_hw_res_pkt.enable_level_process_quantum_check =3D 1;
> -       mes_set_hw_res_pkt.oversubscription_timer =3D 50;
>         if (adev->mes.use_rs64mem)
>                 mes_set_hw_res_pkt.use_rs64mem_for_proc_gang_ctx =3D 1;
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/driv=
ers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> index ea9d87450eae..350e0ce308d3 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> @@ -47,6 +47,9 @@
>  /* See unmap_queues_cpsch() */
>  #define USE_DEFAULT_GRACE_PERIOD 0xffffffff
>
> +/* Interval for notifying MES of work on unmapped queues during oversubs=
cription */
> +#define DQM_MES_UNMAP_NOTIFY_DELAY_MS 50
> +
>  static int set_pasid_vmid_mapping(struct device_queue_manager *dqm,
>                                   u32 pasid, unsigned int vmid);
>
> @@ -276,8 +279,16 @@ static int add_queue_mes(struct device_queue_manager=
 *dqm, struct queue *q,
>                         q->properties.doorbell_off);
>                 dev_err(adev->dev, "MES might be in unrecoverable state, =
issue a GPU reset\n");
>                 kfd_hws_hang(dqm);
> +               return r;
>         }
>
> +       /* GFX11: start notify timer only once when oversubscription begi=
ns */
> +       if (KFD_GC_VERSION(dqm->dev) >=3D IP_VERSION(11, 0, 0) &&
> +           KFD_GC_VERSION(dqm->dev) < IP_VERSION(12, 0, 0) &&
> +           dqm->active_cp_queue_count > get_cp_queues_num(dqm))
> +               queue_delayed_work(system_wq, &dqm->notify_unmap_work,
> +                                  msecs_to_jiffies(DQM_MES_UNMAP_NOTIFY_=
DELAY_MS));
> +
>         return r;
>  }
>
> @@ -354,7 +365,16 @@ static void set_perfcount(struct device_queue_manage=
r *dqm, int enable)
>  static int remove_queue_mes(struct device_queue_manager *dqm, struct que=
ue *q,
>                             struct qcm_process_device *qpd)
>  {
> -       return remove_queue_mes_on_reset_option(dqm, q, qpd, false, false=
);
> +       int r =3D remove_queue_mes_on_reset_option(dqm, q, qpd, false, fa=
lse);
> +
> +       /* GFX11: stop notify timer when oversubscription clears */
> +       if (!r &&
> +           KFD_GC_VERSION(dqm->dev) >=3D IP_VERSION(11, 0, 0) &&
> +           KFD_GC_VERSION(dqm->dev) < IP_VERSION(12, 0, 0) &&
> +           dqm->active_cp_queue_count <=3D get_cp_queues_num(dqm))
> +               cancel_delayed_work(&dqm->notify_unmap_work);
> +
> +       return r;
>  }
>
>  static int remove_all_kfd_queues_mes(struct device_queue_manager *dqm)
> @@ -3088,6 +3108,20 @@ static void deallocate_hiq_sdma_mqd(struct kfd_nod=
e *dev,
>         amdgpu_amdkfd_free_kernel_mem(dev->adev, &mqd->mem);
>  }
>
> +static void mes_notify_unmap_work_handler(struct work_struct *work)
> +{
> +       struct device_queue_manager *dqm =3D
> +               container_of(work, struct device_queue_manager,
> +                            notify_unmap_work.work);
> +
> +       amdgpu_mes_notify_unmap_queue((struct amdgpu_device *)dqm->dev->a=
dev);
> +
> +       /* Re-arm if still oversubscribed */
> +       if (READ_ONCE(dqm->active_cp_queue_count) > get_cp_queues_num(dqm=
))
> +               queue_delayed_work(system_wq, &dqm->notify_unmap_work,
> +                                  msecs_to_jiffies(DQM_MES_UNMAP_NOTIFY_=
DELAY_MS));
> +}
> +
>  struct device_queue_manager *device_queue_manager_init(struct kfd_node *=
dev)
>  {
>         struct device_queue_manager *dqm;
> @@ -3213,6 +3247,8 @@ struct device_queue_manager *device_queue_manager_i=
nit(struct kfd_node *dev)
>
>         if (!dqm->ops.initialize(dqm)) {
>                 init_waitqueue_head(&dqm->destroy_wait);
> +               INIT_DELAYED_WORK(&dqm->notify_unmap_work,
> +                                 mes_notify_unmap_work_handler);
>                 return dqm;
>         }
>
> @@ -3229,6 +3265,7 @@ struct device_queue_manager *device_queue_manager_i=
nit(struct kfd_node *dev)
>
>  void device_queue_manager_uninit(struct device_queue_manager *dqm)
>  {
> +       cancel_delayed_work_sync(&dqm->notify_unmap_work);
>         dqm->ops.stop(dqm);
>         dqm->ops.uninitialize(dqm);
>         if (!dqm->dev->kfd->shared_resources.enable_mes)
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.h b/driv=
ers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.h
> index c9f9f7a87111..21cf3c16f3f9 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.h
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.h
> @@ -281,6 +281,7 @@ struct device_queue_manager {
>         uint32_t                wait_times;
>
>         wait_queue_head_t       destroy_wait;
> +       struct delayed_work     notify_unmap_work;
>
>         /* for per-queue reset support */
>         struct dqm_detect_hang_info *detect_hang_info;
> --
> 2.34.1
>
