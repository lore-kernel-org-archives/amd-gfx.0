Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E68D010AB803
	for <amd-gfx@archiver.kernel.org>; Thu, 26 Mar 2026 18:52:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 610A910EB7D;
	Thu, 26 Mar 2026 18:52:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="FucFUOcX";
	dkim-atps=neutral
Received: from mail-dl1-f46.google.com (mail-dl1-f46.google.com [74.125.82.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9B9AC10E28A
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Mar 2026 18:52:09 +0000 (UTC)
Received: by mail-dl1-f46.google.com with SMTP id
 a92af1059eb24-12a6b260693so181648c88.2
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Mar 2026 11:52:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774551129; cv=none;
 d=google.com; s=arc-20240605;
 b=a193UT6ZN+oK8gIjnjOadr+sb68O9vm8Ua+Oaq7RJveuJBT6bPjaNlSvD2EFw4Oqxk
 a79H/TtzXQUnvtSLF8BrlCp0zaCVpeHELGYSyjsb+R5naLfCkhPF9jJUg8Z6XsD8go6S
 1UE+MwoL7o9z3a0nDeQqMvAS6MNAshgAgc5nQomChJTphX3C/R2J+3odsvAYZWt64MP1
 h8BEYONuYF+uzQSaRh1inB9hVRmoyYl2EyO6466LQe1qoeZr31+6zbqkqu2BDpIYQlrx
 JsgD0ppnW53fnZRGN22SVCaMs3rSmUunHPa0c433OBy5UyEBBRF+5I6P3FXOerTso5MX
 Sy4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=2SEWuc7DUF9J7yE64zkLSowYvph1gOMZmEnpddmCi24=;
 fh=OvKzi3YaVdYQcj/ttN/1Uz8prEoy1Xr2B3QHReZfFdY=;
 b=iRTSST4kMkSQtGtYXQ5iImZrWsSvANwcVXY648AskUX6UltpbM9hmbsAUgmAINuvxu
 OJ1ZyHqrupwTjE3JOBmX+fO9PNWkKTLVwSSEQ+OpRJXXgd5GenLX4a5c21rjyHkNRVPQ
 2U2OBtzb2J3tTq5XibtNlUfqpvETvvsym7+RACI6J0srGBFk31lPSDEPTHGY0hLFHGWS
 4Wguff5LYjkI9u3UQ0uTCc1ZogKV1u4cY8ZBII+MZ03KM++ejmJPsVnHvj/7tG2NmNJ9
 IjhjUnZNMxK6BdDhkbHgXUdhSa78TUrfn1Oj51IMobu60tA03HL6386Giqf2x0o3Xmyo
 jpVA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1774551129; x=1775155929; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2SEWuc7DUF9J7yE64zkLSowYvph1gOMZmEnpddmCi24=;
 b=FucFUOcXpAM/kHtIe31K0sp1XM3b28CJCsBog3vbOGmyUTjQfDmezi3Hcs4vICVZcZ
 HF8/83x7DupGGMFBjkkRtMbne2bBvu8r/+nEfESNjUXKLbcXtzSozRP64AY0hIp1ZEVV
 RXPXrL0hn92tmDkUCJzr9Rh1619uOKXGWkGp63AAd2pBt6uI9uRU4nmSnHXlBP4mODQZ
 UcDZPoSrZHucAIJUWX0W3IP94WKnpGdW373fizVGNhC7wppLQaLmBMZlicMEwWM1ly2x
 12JbM+SIuIpF/c9sgJ7Cs3zgN1ORdmoxbM6GSz0JEZl1nJWwkrCXdnT2YxgA6LDyPYI6
 Yd3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774551129; x=1775155929;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=2SEWuc7DUF9J7yE64zkLSowYvph1gOMZmEnpddmCi24=;
 b=nsUb1vWCc0HBQwIU5UbM3u5S5I9YR7XDwaPmwYRirIU2UiDHmKSPoYTiX7qVEo+hT0
 Gfj81QV1grOVvjTMCugW6t8XUz8lbfaLH3vUvz5gnE8EnsbYyXHDg+CL1nep6kaWfWC8
 bVMtkx7GmknO79XJ5tNYANPgk1DbN2ywld3K9oJyL6NjhBn6ZEsJaDFjXhDoKOjuWjxg
 F2FOSfVCDIWaKc1dmzh3ZtkRq2NxmvPZxgt92pO5nc5buGMBZDqESSyM76bFVGHC0gvr
 +x3ZtsAjSgYfQCjHFjZ7AcKiDbIh1P9LXT9NIKdObkLwR8qcqSh6zuZzPyt92tAFT/HI
 5JnA==
X-Gm-Message-State: AOJu0YwsX5OFqWPk3pKaREKiCEcQy4Vu8V3/46WcWiuWJvqJUcQ3OomU
 L4mGovHTO0Zm99aFy5kmQIJ+v+VLSWzWI5UJYFr0hjmBwf5eGRdyvoTRgCdqenTCntS7BOYVIUt
 9Hwl/9pxSjqsGDUUtQhnCvcuCUIcG21U=
X-Gm-Gg: ATEYQzzQTYAKjIupwNZFQVv5VJcF9gTZDx+lI/EjgNQ/oFSrh3fbTZ0CnFH8bw/uUy2
 N5q9Ygia0QoaBYb6n8PDmpKfulfOxRJ7JFpX6+pd/oGte4jVZwkJH1vGrLTrCO6T9AMwcluBQVh
 6iQBW/9M/Sj47uAEqNZh+z25lY4G6bVvrw87+T//6VL+FEx5VdJeYggtudUQ589x56LEIxpTIMQ
 Ch3M6Pw6QUmClZaWhKBQs5uvGTBvyedsxUeYIf/CWPJXY0wB4Fn9728UH6l+X7Jo2rKuE1Zr/kr
 kJRuaeQs9Y2+fjJZ/eRNGH864IQynp/y3t16oYM4ll4mRxplyxr0SzLLtHdz23GjERR4tw==
X-Received: by 2002:a05:7022:4388:b0:119:e56b:46b6 with SMTP id
 a92af1059eb24-12a96b8bd61mr2407165c88.0.1774551128658; Thu, 26 Mar 2026
 11:52:08 -0700 (PDT)
MIME-Version: 1.0
References: <20260324175653.1325754-1-Amber.Lin@amd.com>
 <20260324175653.1325754-10-Amber.Lin@amd.com>
In-Reply-To: <20260324175653.1325754-10-Amber.Lin@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 26 Mar 2026 14:51:57 -0400
X-Gm-Features: AQROBzDGnTaHbXekLIc4Xt37m4ooy9TVIAycITghQw4_auAR-StsHxFqVTZE0dg
Message-ID: <CADnq5_N87OnPXugvJJhnKuG4O6NZN5PdxBBYJVYA9nRP_msDyg@mail.gmail.com>
Subject: Re: [PATCH v2 09/10] drm/amdkfd: Reset queue/pipe in MES
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

On Tue, Mar 24, 2026 at 1:57=E2=80=AFPM Amber Lin <Amber.Lin@amd.com> wrote=
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
>  4 files changed, 153 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_mes.c
> index f3a4ae1fd521..7cf4b3d6fc93 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
> @@ -793,6 +793,12 @@ bool amdgpu_mes_suspend_resume_all_supported(struct =
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

We should avoid allocating memory in the reset paths as they can
deadlock if the kernel is waiting on the reset to get the memory
needed for the allocation.  Can you preallocate this somehow?

Alex

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
> --
> 2.43.0
>
