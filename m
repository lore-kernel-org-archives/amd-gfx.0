Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84139C52D7C
	for <amd-gfx@archiver.kernel.org>; Thu, 15 Aug 2024 18:18:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 23A9910E4E4;
	Thu, 15 Aug 2024 18:18:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Uwhg0LLN";
	dkim-atps=neutral
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com
 [209.85.214.178])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6B1F310E4E4
 for <amd-gfx@lists.freedesktop.org>; Thu, 15 Aug 2024 18:18:43 +0000 (UTC)
Received: by mail-pl1-f178.google.com with SMTP id
 d9443c01a7336-1fc65329979so12144055ad.0
 for <amd-gfx@lists.freedesktop.org>; Thu, 15 Aug 2024 11:18:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1723745923; x=1724350723; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yfs7gapmsYeyOtmLa0nYe3LYq+x+DyZqOS1GBJJ08Mo=;
 b=Uwhg0LLNng5SVZaSkeUzEpFyObTwrtMWS+669py+9/FGnKcUph0mOaoILW4unqd5t2
 j/V1aiyCEVeO+mvHg4w7wsMk+jsVVaKzEdP+emt1Tm8Xi0/shyHxZrY02j5pfVa+Kced
 495kf04KvusWBMaIHQjS41I6fS2h/BFGKlE6dmMoGyggJSAZXyQkjjY7z7ViCTe2u24z
 aH0v8lM+952j4JMaXQyUCvMSW9v3qTWc+1kiOqKmeW+MEqFb4KVDu8xhw0nBbbtirH0i
 TklRYAAGUGZCwvRxna7+twkjFn+TTnRH1aJpVOKT27dFR24LYUGrZgp74GD+Qd8Z7Q46
 yl+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723745923; x=1724350723;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yfs7gapmsYeyOtmLa0nYe3LYq+x+DyZqOS1GBJJ08Mo=;
 b=NOEMQxB68GGFgf4KyxuLiMHD+lzcxhRNj+iLcorEksw7IEFr8KY8gBL1Ys2vAdiGJu
 FVqB05PSMEljsaD4uqmQGH3eMlCk8pRvuGAtGWvLKFKlNw23Ydtd8lm08DQ42NYplRen
 rKqlsnLrS19k/dZ7jPyFtXanENYu/4cCbNICk3ss6tTrGB7OMPfwVFaFobvFZGCDFI4q
 tWoyU9yxPWlTr9dya+Wi5Leoh/a5sJMzcdrvFNzPD6UP5G5hmoQvB8cv6utVCSuuXKfA
 Flj2VCU4jzEeLzB7AxDRVX9tNO4i+WCWJ+5cgkHm61EigfkPQM6SUHY/QO5ccmvo3kwP
 6DsQ==
X-Gm-Message-State: AOJu0YzEX0pzF5CJD/kbQLLx8GTjVq7bNhTz0crkKw2KtLptdMdpJ+Qw
 FXcg/ylooLxrqev/J70VyTv9avW3PwjVLxDTuswsCloJ4kUx8aKLMirSi8ZXImN9N47/fDwH57Q
 f8FN8nBLe+D7UscJqItcpviwxxXk=
X-Google-Smtp-Source: AGHT+IEDjoO7cRHdWQgaFmtNKRfiqPwGAoQGsQ876nMTQj2gXrQ56sO03+IC+JCivN/1W7sSc9V4fzC+3GDp1Xt0yGY=
X-Received: by 2002:a17:903:18b:b0:1fc:5f3a:4d9a with SMTP id
 d9443c01a7336-20203f4be8fmr6233345ad.58.1723745922847; Thu, 15 Aug 2024
 11:18:42 -0700 (PDT)
MIME-Version: 1.0
References: <20240814232754.1119319-1-mukul.joshi@amd.com>
 <20240814232754.1119319-3-mukul.joshi@amd.com>
In-Reply-To: <20240814232754.1119319-3-mukul.joshi@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 15 Aug 2024 14:18:31 -0400
Message-ID: <CADnq5_NS2Ge8P-Hq0V5kiVRLGyweWdZ8-57+5UEhqXsqpxGMUg@mail.gmail.com>
Subject: Re: [PATCHv2 3/3] drm/amdkfd: Update BadOpcode Interrupt handling
 with MES
To: Mukul Joshi <mukul.joshi@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Felix.Kuehling@amd.com, 
 alexander.deucher@amd.com, 
 Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>
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

On Wed, Aug 14, 2024 at 7:28=E2=80=AFPM Mukul Joshi <mukul.joshi@amd.com> w=
rote:
>
> Based on the recommendation of MEC FW, update BadOpcode interrupt
> handling by unmapping all queues, removing the queue that got the
> interrupt from scheduling and remapping rest of the queues back when
> using MES scheduler. This is done to prevent the case where unmapping
> of the bad queue can fail thereby causing a GPU reset.
>
> Signed-off-by: Mukul Joshi <mukul.joshi@amd.com>
> Acked-by: Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>

Acked-by: Alex Deucher <alexander.deucher@amd.com>

> ---
> v1->v2:
> - No change.
>
>  .../drm/amd/amdkfd/kfd_device_queue_manager.c | 51 +++++++++++++++++++
>  .../gpu/drm/amd/amdkfd/kfd_int_process_v11.c  |  9 ++--
>  drivers/gpu/drm/amd/amdkfd/kfd_priv.h         |  1 +
>  3 files changed, 58 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/driv=
ers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> index cb5b866eee3b..67b97d86e65e 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> @@ -2871,6 +2871,57 @@ void device_queue_manager_uninit(struct device_que=
ue_manager *dqm)
>         kfree(dqm);
>  }
>
> +int kfd_dqm_suspend_bad_queue_mes(struct kfd_node *knode, u32 pasid, u32=
 doorbell_id)
> +{
> +       struct kfd_process_device *pdd;
> +       struct kfd_process *p =3D kfd_lookup_process_by_pasid(pasid);
> +       struct device_queue_manager *dqm =3D knode->dqm;
> +       struct device *dev =3D dqm->dev->adev->dev;
> +       struct qcm_process_device *qpd;
> +       struct queue *q =3D NULL;
> +       int ret =3D 0;
> +
> +       if (!p)
> +               return -EINVAL;
> +
> +       dqm_lock(dqm);
> +
> +       pdd =3D kfd_get_process_device_data(dqm->dev, p);
> +       if (pdd) {
> +               qpd =3D &pdd->qpd;
> +
> +               list_for_each_entry(q, &qpd->queues_list, list) {
> +                       if (q->doorbell_id =3D=3D doorbell_id && q->prope=
rties.is_active) {
> +                               ret =3D suspend_all_queues_mes(dqm);
> +                               if (ret) {
> +                                       dev_err(dev, "Suspending all queu=
es failed");
> +                                       goto out;
> +                               }
> +
> +                               q->properties.is_evicted =3D true;
> +                               q->properties.is_active =3D false;
> +                               decrement_queue_count(dqm, qpd, q);
> +
> +                               ret =3D remove_queue_mes(dqm, q, qpd);
> +                               if (ret) {
> +                                       dev_err(dev, "Removing bad queue =
failed");
> +                                       goto out;
> +                               }
> +
> +                               ret =3D resume_all_queues_mes(dqm);
> +                               if (ret)
> +                                       dev_err(dev, "Resuming all queues=
 failed");
> +
> +                               break;
> +                       }
> +               }
> +       }
> +
> +out:
> +       dqm_unlock(dqm);
> +       return ret;
> +}
> +
>  static int kfd_dqm_evict_pasid_mes(struct device_queue_manager *dqm,
>                                    struct qcm_process_device *qpd)
>  {
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v11.c b/drivers/g=
pu/drm/amd/amdkfd/kfd_int_process_v11.c
> index f524a55eee11..b3f988b275a8 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v11.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v11.c
> @@ -330,11 +330,14 @@ static void event_interrupt_wq_v11(struct kfd_node =
*dev,
>                 if (source_id =3D=3D SOC15_INTSRC_CP_END_OF_PIPE)
>                         kfd_signal_event_interrupt(pasid, context_id0, 32=
);
>                 else if (source_id =3D=3D SOC15_INTSRC_CP_BAD_OPCODE &&
> -                        KFD_DBG_EC_TYPE_IS_PACKET(KFD_CTXID0_CP_BAD_OP_E=
CODE(context_id0)))
> -                       kfd_set_dbg_ev_from_interrupt(dev, pasid,
> -                               KFD_CTXID0_DOORBELL_ID(context_id0),
> +                        KFD_DBG_EC_TYPE_IS_PACKET(KFD_CTXID0_CP_BAD_OP_E=
CODE(context_id0))) {
> +                       u32 doorbell_id =3D KFD_CTXID0_DOORBELL_ID(contex=
t_id0);
> +
> +                       kfd_set_dbg_ev_from_interrupt(dev, pasid, doorbel=
l_id,
>                                 KFD_EC_MASK(KFD_CTXID0_CP_BAD_OP_ECODE(co=
ntext_id0)),
>                                 NULL, 0);
> +                       kfd_dqm_suspend_bad_queue_mes(dev, pasid, doorbel=
l_id);
> +               }
>
>                 /* SDMA */
>                 else if (source_id =3D=3D SOC21_INTSRC_SDMA_TRAP)
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/=
amdkfd/kfd_priv.h
> index f7c12d4f0abb..7bba6bed2f48 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> @@ -1324,6 +1324,7 @@ struct kernel_queue *kernel_queue_init(struct kfd_n=
ode *dev,
>                                         enum kfd_queue_type type);
>  void kernel_queue_uninit(struct kernel_queue *kq);
>  int kfd_dqm_evict_pasid(struct device_queue_manager *dqm, u32 pasid);
> +int kfd_dqm_suspend_bad_queue_mes(struct kfd_node *knode, u32 pasid, u32=
 doorbell_id);
>
>  /* Process Queue Manager */
>  struct process_queue_node {
> --
> 2.35.1
>
