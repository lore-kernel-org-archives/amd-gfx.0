Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 982D7F483D7
	for <amd-gfx@archiver.kernel.org>; Mon, 23 Mar 2026 19:21:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 33C3D10E44E;
	Mon, 23 Mar 2026 19:21:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="fT/nOPM3";
	dkim-atps=neutral
Received: from mail-dy1-f174.google.com (mail-dy1-f174.google.com
 [74.125.82.174])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7CA2910E44E
 for <amd-gfx@lists.freedesktop.org>; Mon, 23 Mar 2026 19:21:27 +0000 (UTC)
Received: by mail-dy1-f174.google.com with SMTP id
 5a478bee46e88-2c0ccfcbee3so258337eec.0
 for <amd-gfx@lists.freedesktop.org>; Mon, 23 Mar 2026 12:21:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774293687; cv=none;
 d=google.com; s=arc-20240605;
 b=FOY5arAr4kDtnXK8/ALObBUSGQ40THUSo/qIKAQSQLN+paN8aw1giuU/4n1EhaXp6/
 UHS31fRlmQZNL5n8dE0n4Pir5BXLbCMlL/7hEOHJns5Zb86LaFL+HgFUny+XjT/F8SFp
 eH4NX5Z6dNLHvGOEcumYSh2brnXOPu85RROxlxJC6Umpff8lykgxzgK2XnC7jagiZpMJ
 EejdRNQnuG0D7jqaJ+n0TrD71dNkjAeCeyC0ffTmSp5dc/FwvS4cfQPwGCWZjxnv7Tx2
 1g1OynlU+b757kSs0oHwFxI23Yg1U+3rBYA+0HfO2O8DiPINgmHx4QRCvkRalCbkZjlm
 hdXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=Bxxj2Y9sKFu2Ib9m5+J86HC0T3CRyJML92Y75Ail1WI=;
 fh=OvKzi3YaVdYQcj/ttN/1Uz8prEoy1Xr2B3QHReZfFdY=;
 b=DeVQ/Ldk95bfniTZWW+F7PHMZZ6hWwZiX78saV9qQaIRCx7UsddjK8ym8trHXoJ+i6
 zZtey23EkEWprCEQC0JQI2IWvpMBSIjsol1oChs5ojBaOZk2HmyKfSp8fmLA2GASQl6L
 4HrdDtmgXS2NTyEZYiLg+107lgXN4aNwj+Bp++jO5pK6oWQTBSRHAdgfUl/6CkOETd0d
 ps9Uc5goHp2q7jlEZtUt8FkqWsgVee9U1pJ88vjv8bDnhCYeXI1DxKwUb1znJ1aMz9yQ
 tNhgjWCb9zTHjKOaFTLKxAxPPBu8NOx9ZIH7jtv2Kj4enwlchOGjyx7FIXRDFSFvMqag
 e3/g==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1774293687; x=1774898487; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Bxxj2Y9sKFu2Ib9m5+J86HC0T3CRyJML92Y75Ail1WI=;
 b=fT/nOPM3Md4arnZ3lKXpefoWhkvwl7DnPhufZx3vyNIU992MjQP8kUKzFw+1X/PA0Z
 PU623880TEBK7Sv3TvjbaSceN4s9CbcZx+UUjXf9WCvKOguo0iGQGIBPQqL6ctZaW5im
 ZXSjj73+lVTEkhL/sXa3LOYrdhq6DfUj7x+PL6lK3eaI/pvvK4dyX77uYDZHQxqjunmT
 J1yd8mbM9RkXmYZnsTv2ewUHanwrF1/O3n21YCChTGnApwG9rMJoR2g0wyHyLlcTvbbn
 d48xcE3h1nojlwroUiF7fX5pQqZhvvmPkD7GzyaDCrMKVeljGDVthm23TSerINN/Blsx
 xE/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774293687; x=1774898487;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Bxxj2Y9sKFu2Ib9m5+J86HC0T3CRyJML92Y75Ail1WI=;
 b=YsA229PliRjZB70i+IVr/0ueS+XloXz+TjytlBkwP5bgVn/Jm46tETTtnQepz98hLh
 KBJkHyUeNuco31hOqmURcTk3SVoPQnNJ9AaoTSsWqPTwfRbTpMfduMnsXyH1q+x5beYw
 oUD4BYln77aMcuWbv2M42XIkXga1Viz5et2O9GMAL10lxDSSiuUg+zg0Y0V8ADLzEkvG
 3YrhXTwJWv+z2Gsx5IJdgjD4u8aAdyeG7kot/w312YAh1Qh+gc0fhkMlByzdMv/bIrx2
 zv4MwCE3mlqqWWk08AL4tt89nMOmgxy0uslmoEb9SgIZvOZyXc9ipOdgw5XWL4ZHgMSP
 MtUQ==
X-Gm-Message-State: AOJu0YyDMA+fp/LDBVUrbGKVoa1GBVTK02hDLltlYHi+W7JtjhKyq7re
 r0TgxjoMFE137NrRoBuQk0f3pU/jLYBZw6cLbArVAcdvkf9CI+XdfQ+PRqQSpsJu0Tekr3Gw6Iu
 V2hRByjG8epwGqd82iDC91Mt2Lm2FyD4=
X-Gm-Gg: ATEYQzzcVcC/VQr1MXYoNyAefPRgKVgsnwHSeOr69tZjwmgUgAgWVLkegKB5pohhcWb
 dxjcGJLfYc4aSS9YbiIORN8L2RsOuWwqxslFDfPiDcKfUJ1vMey+963Oqt0nISrNC6MeqtkPzU2
 TFvZZNOX2/OuGmAYwoYpgoOUjq8Fewv9Vj5R6kFJ1bU9D+pxV3cDu2D5Eep/vILSIMYmaXi+n8k
 wjJKmfSW3UAa40mAQIOHeJGgOXcOZwnrFIMcYRrtDdUtl3Tf2fwy8A2kmy3UYPdmoD0QYsy2gXh
 R312k8/wv2n3Rvwgth9HPkfTovbtOedVkl+a0llNrgJHMFi1006NfWLxcowUo+BiPFd5BKm6bwQ
 wapVk
X-Received: by 2002:a05:7022:45a1:b0:12a:6cde:fd0c with SMTP id
 a92af1059eb24-12a726de3abmr2928843c88.7.1774293686544; Mon, 23 Mar 2026
 12:21:26 -0700 (PDT)
MIME-Version: 1.0
References: <20260320200208.1188307-1-Amber.Lin@amd.com>
 <20260320200208.1188307-9-Amber.Lin@amd.com>
In-Reply-To: <20260320200208.1188307-9-Amber.Lin@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 23 Mar 2026 15:21:15 -0400
X-Gm-Features: AaiRm50gN7xqD6d5j_lqI-SjnHavfYENe_fVfxbTqoWUrjRDbU5_pedOE2kgbvc
Message-ID: <CADnq5_OmEwONb2pc3g90zr4BwicYhqdj2O--ACWux3gGgtoG3A@mail.gmail.com>
Subject: Re: [PATCH 8/8] drm/amdkfd: Reset queue/pipe in MES
To: Amber Lin <Amber.Lin@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Shaoyun.Liu@amd.com, Michael.Chen@amd.com, 
 Jesse.Zhang@amd.com, Jonathan Kim <jonathan.kim@amd.com>
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

On Fri, Mar 20, 2026 at 4:19=E2=80=AFPM Amber Lin <Amber.Lin@amd.com> wrote=
:
>
> When removing queues fails, KFD calls amdgpu_mes to detect and reset
> hung queues, then cleans up those hung queues in KFD.
>
> Suggested-by: Jonathan Kim <jonathan.kim@amd.com>
> Signed-off-by: Amber Lin <Amber.Lin@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c       |   6 +
>  drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h       |   1 +
>  .../drm/amd/amdkfd/kfd_device_queue_manager.c | 147 +++++++++++++++++-
>  drivers/gpu/drm/amd/amdkfd/kfd_priv.h         |   1 +
>  drivers/gpu/drm/amd/amdkfd/kfd_topology.c     |   1 +
>  5 files changed, 154 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_mes.c
> index 4f44b933e373..fd6b40d9da58 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
> @@ -795,6 +795,12 @@ bool amdgpu_mes_suspend_resume_all_supported(struct =
amdgpu_device *adev)
>                 amdgpu_ip_version(adev, GC_HWIP, 0) >=3D IP_VERSION(12, 0=
, 0));
>  }
>
> +bool amdgpu_mes_queue_reset_by_mes_supported(struct amdgpu_device *adev)
> +{
> +       return (amdgpu_ip_version(adev, GC_HWIP, 0) =3D=3D IP_VERSION(12,=
 1, 0) &&
> +               (adev->mes.sched_version & AMDGPU_MES_VERSION_MASK) >=3D =
0x73);
> +}
> +
>  /* Fix me -- node_id is used to identify the correct MES instances in th=
e future */
>  static int amdgpu_mes_set_enforce_isolation(struct amdgpu_device *adev,
>                                             uint32_t node_id, bool enable=
)
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_mes.h
> index 643b4f8d757a..44fa4d73bce8 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
> @@ -548,6 +548,7 @@ static inline void amdgpu_mes_unlock(struct amdgpu_me=
s *mes)
>  }
>
>  bool amdgpu_mes_suspend_resume_all_supported(struct amdgpu_device *adev)=
;
> +bool amdgpu_mes_queue_reset_by_mes_supported(struct amdgpu_device *adev)=
;
>
>  int amdgpu_mes_update_enforce_isolation(struct amdgpu_device *adev);
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/driv=
ers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> index ec8d7f4be840..1c9c350bfffe 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> @@ -71,6 +71,12 @@ static int allocate_sdma_queue(struct device_queue_man=
ager *dqm,
>                                 struct queue *q, const uint32_t *restore_=
sdma_id);
>
>  static int reset_queues_on_hws_hang(struct device_queue_manager *dqm, bo=
ol is_sdma);
> +static int resume_all_queues_mes(struct device_queue_manager *dqm);
> +static int suspend_all_queues_mes(struct device_queue_manager *dqm);
> +static struct queue *find_queue_by_doorbell_offset(struct device_queue_m=
anager *dqm,
> +                                                  uint32_t doorbell_offs=
et);
> +static void set_queue_as_reset(struct device_queue_manager *dqm, struct =
queue *q,
> +                              struct qcm_process_device *qpd);
>
>  static inline
>  enum KFD_MQD_TYPE get_mqd_type_from_queue_type(enum kfd_queue_type type)
> @@ -273,13 +279,19 @@ static int add_queue_mes(struct device_queue_manage=
r *dqm, struct queue *q,
>         return r;
>  }
>
> -static int remove_queue_mes(struct device_queue_manager *dqm, struct que=
ue *q,
> -                       struct qcm_process_device *qpd)
> +static int remove_queue_mes_on_reset_option(struct device_queue_manager =
*dqm, struct queue *q,
> +                                           struct qcm_process_device *qp=
d,
> +                                           bool is_for_reset,
> +                                           bool flush_mes_queue)
>  {
>         struct amdgpu_device *adev =3D (struct amdgpu_device *)dqm->dev->=
adev;
>         int r;
>         struct mes_remove_queue_input queue_input;
>
> +       /* queue was already removed during reset */
> +       if (q->properties.is_reset)
> +               return 0;
> +
>         if (!dqm->sched_running || dqm->sched_halt)
>                 return 0;
>         if (!down_read_trylock(&adev->reset_domain->sem))
> @@ -288,6 +300,7 @@ static int remove_queue_mes(struct device_queue_manag=
er *dqm, struct queue *q,
>         memset(&queue_input, 0x0, sizeof(struct mes_remove_queue_input));
>         queue_input.doorbell_offset =3D q->properties.doorbell_off;
>         queue_input.gang_context_addr =3D q->gang_ctx_gpu_addr;
> +       queue_input.remove_queue_after_reset =3D flush_mes_queue;
>         queue_input.xcc_id =3D ffs(dqm->dev->xcc_mask) - 1;
>
>         amdgpu_mes_lock(&adev->mes);
> @@ -295,7 +308,13 @@ static int remove_queue_mes(struct device_queue_mana=
ger *dqm, struct queue *q,
>         amdgpu_mes_unlock(&adev->mes);
>         up_read(&adev->reset_domain->sem);
>
> +       if (is_for_reset)
> +               return r;
> +
>         if (r) {
> +               if (!suspend_all_queues_mes(dqm))
> +                       return resume_all_queues_mes(dqm);
> +
>                 dev_err(adev->dev, "failed to remove hardware queue from =
MES, doorbell=3D0x%x\n",
>                         q->properties.doorbell_off);
>                 dev_err(adev->dev, "MES might be in unrecoverable state, =
issue a GPU reset\n");
> @@ -305,6 +324,12 @@ static int remove_queue_mes(struct device_queue_mana=
ger *dqm, struct queue *q,
>         return r;
>  }
>
> +static int remove_queue_mes(struct device_queue_manager *dqm, struct que=
ue *q,
> +                           struct qcm_process_device *qpd)
> +{
> +       return remove_queue_mes_on_reset_option(dqm, q, qpd, false, false=
);
> +}
> +
>  static int remove_all_kfd_queues_mes(struct device_queue_manager *dqm)
>  {
>         struct device_process_node *cur;
> @@ -359,6 +384,103 @@ static int add_all_kfd_queues_mes(struct device_que=
ue_manager *dqm)
>         return retval;
>  }
>
> +static int reset_queues_mes(struct device_queue_manager *dqm)
> +{
> +       struct amdgpu_device *adev =3D (struct amdgpu_device *)dqm->dev->=
adev;
> +       struct amdgpu_mes_hung_queue_hqd_info *hqd_info;
> +       int hqd_info_size =3D adev->mes.hung_queue_hqd_info_offset;
> +       int num_hung =3D 0, r =3D 0, i, pipe, queue, queue_type;
> +       uint32_t *hung_array;
> +       struct kfd_process_device *pdd;
> +       struct queue *q;
> +
> +       if (!amdgpu_mes_queue_reset_by_mes_supported(adev)) {
> +               r =3D -ENOTRECOVERABLE;
> +               goto fail;
> +       }
> +
> +       /* reset should be used only in dqm locked queue reset */
> +       if (WARN_ON(dqm->detect_hang_count > 0))
> +               return 0;
> +
> +       if (!amdgpu_gpu_recovery) {
> +               r =3D -ENOTRECOVERABLE;
> +               goto fail;
> +       }
> +
> +       hung_array =3D kzalloc(adev->mes.hung_queue_db_array_size * sizeo=
f(uint32_t), GFP_KERNEL);
> +       if (!hung_array) {
> +               r =3D -ENOMEM;
> +               goto fail;
> +       }
> +
> +       hqd_info =3D kzalloc(hqd_info_size * sizeof(struct amdgpu_mes_hun=
g_queue_hqd_info), GFP_KERNEL);
> +       if (!hqd_info) {
> +               r =3D -ENOMEM;
> +               goto free_hung_array;
> +       }
> +
> +       memset(hqd_info, 0, hqd_info_size * sizeof(struct amdgpu_mes_hung=
_queue_hqd_info));
> +
> +       /*
> +        * AMDGPU_RING_TYPE_COMPUTE parameter does not matter if called
> +        * post suspend_all as reset & detect will return all hung queue =
types.
> +        *
> +        * Passed parameter is for targeting queues not scheduled by MES =
add_queue.
> +        */
> +       r =3D  amdgpu_mes_detect_and_reset_hung_queues(adev, AMDGPU_RING_=
TYPE_COMPUTE,
> +               false, &num_hung, hung_array, ffs(dqm->dev->xcc_mask) - 1=
);
> +
> +       if (!num_hung || r) {
> +               r =3D -ENOTRECOVERABLE;
> +               goto free_hqd_info;
> +       }
> +
> +       /* MES reset resets queue/pipe and cleans up internally  */
> +       for (i =3D 0; i < num_hung; i++) {
> +               hqd_info[i].bit0_31 =3D hung_array[i + hqd_info_size];
> +               pipe =3D hqd_info[i].pipe_index;
> +               queue =3D hqd_info[i].queue_index;
> +               queue_type =3D hqd_info[i].queue_type;
> +
> +               if (queue_type !=3D MES_QUEUE_TYPE_COMPUTE &&
> +                   queue_type !=3D MES_QUEUE_TYPE_SDMA) {
> +                       pr_warn("Unsupported hung queue reset type: %d\n"=
, queue_type);
> +                       hung_array[i] =3D AMDGPU_MES_INVALID_DB_OFFSET;
> +                       continue;
> +               }
> +
> +               q =3D find_queue_by_doorbell_offset(dqm, hung_array[i]);
> +               if (!q) {
> +                       r =3D -ENOTRECOVERABLE;
> +                       goto free_hqd_info;
> +               }
> +
> +               pdd =3D kfd_get_process_device_data(q->device, q->process=
);
> +               if (!pdd) {
> +                       r =3D -ENODEV;
> +                       goto free_hqd_info;
> +               }
> +
> +               pr_warn("Hang detected doorbell %x pipe %d queue %d type =
%d\n",
> +                               hung_array[i], pipe, queue, queue_type);
> +               /* Proceed remove_queue with reset=3Dtrue */
> +               remove_queue_mes_on_reset_option(dqm, q, &pdd->qpd, true,=
 false);
> +               set_queue_as_reset(dqm, q, &pdd->qpd);
> +       }
> +
> +       dqm->detect_hang_count =3D num_hung;
> +       kfd_signal_reset_event(dqm->dev);
> +
> +free_hqd_info:
> +       kfree(hqd_info);
> +free_hung_array:
> +       kfree(hung_array);
> +fail:
> +       dqm->detect_hang_count =3D 0;
> +       return r;
> +}
> +
>  static int suspend_all_queues_mes(struct device_queue_manager *dqm)
>  {
>         struct amdgpu_device *adev =3D (struct amdgpu_device *)dqm->dev->=
adev;
> @@ -371,6 +493,9 @@ static int suspend_all_queues_mes(struct device_queue=
_manager *dqm)
>         up_read(&adev->reset_domain->sem);
>
>         if (r) {
> +               if (!reset_queues_mes(dqm))
> +                       return 0;
> +
>                 dev_err(adev->dev, "failed to suspend gangs from MES\n");
>                 dev_err(adev->dev, "MES might be in unrecoverable state, =
issue a GPU reset\n");
>                 kfd_hws_hang(dqm);
> @@ -2137,6 +2262,7 @@ static void set_queue_as_reset(struct device_queue_=
manager *dqm, struct queue *q
>                 q->properties.queue_id, pdd->process->lead_thread->pid);
>
>         pdd->has_reset_queue =3D true;
> +       q->properties.is_reset =3D true;
>         if (q->properties.is_active) {
>                 q->properties.is_active =3D false;
>                 decrement_queue_count(dqm, qpd, q);
> @@ -2203,6 +2329,23 @@ static struct queue *find_queue_by_address(struct =
device_queue_manager *dqm, uin
>         return NULL;
>  }
>
> +static struct queue *find_queue_by_doorbell_offset(struct device_queue_m=
anager *dqm, uint32_t doorbell_offset)
> +{
> +       struct device_process_node *cur;
> +       struct qcm_process_device *qpd;
> +       struct queue *q;
> +
> +       list_for_each_entry(cur, &dqm->queues, list) {
> +               qpd =3D cur->qpd;
> +               list_for_each_entry(q, &qpd->queues_list, list) {
> +                       if (doorbell_offset =3D=3D q->properties.doorbell=
_off)
> +                               return q;
> +               }
> +       }
> +
> +       return NULL;
> +}
> +
>  static int reset_hung_queues(struct device_queue_manager *dqm)
>  {
>         int r =3D 0, reset_count =3D 0, i;
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/=
amdkfd/kfd_priv.h
> index 27e4859e4ad7..6cb33f6d71e2 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> @@ -523,6 +523,7 @@ struct queue_properties {
>         uint32_t pm4_target_xcc;
>         bool is_dbg_wa;
>         bool is_user_cu_masked;
> +       bool is_reset;
>         /* Not relevant for user mode queues in cp scheduling */
>         unsigned int vmid;
>         /* Relevant only for sdma queues*/
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c b/drivers/gpu/drm/=
amd/amdkfd/kfd_topology.c
> index 1ccd4514d3ee..4c52819aef9e 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
> @@ -2027,6 +2027,7 @@ static void kfd_topology_set_capabilities(struct kf=
d_topology_device *dev)
>                 if (KFD_GC_VERSION(dev->gpu) >=3D IP_VERSION(12, 1, 0)) {
>                         dev->node_props.capability |=3D
>                                 HSA_CAP_TRAP_DEBUG_PRECISE_MEMORY_OPERATI=
ONS_SUPPORTED;
> +                       dev->node_props.capability |=3D HSA_CAP_PER_QUEUE=
_RESET_SUPPORTED;

Should this hunk be a separate patch?  Isn't this already supported on
existing parts using MES?

Alex

>                         dev->node_props.capability2 |=3D
>                                 HSA_CAP2_TRAP_DEBUG_LDS_OUT_OF_ADDR_RANGE=
_SUPPORTED;
>                 }
> --
> 2.43.0
>
