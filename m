Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC51110F92E5
	for <amd-gfx@archiver.kernel.org>; Tue, 31 Mar 2026 16:23:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8FD3A10E976;
	Tue, 31 Mar 2026 16:23:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="D5Ukrtpc";
	dkim-atps=neutral
Received: from mail-dl1-f43.google.com (mail-dl1-f43.google.com [74.125.82.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 618DD10E970
 for <amd-gfx@lists.freedesktop.org>; Tue, 31 Mar 2026 16:23:44 +0000 (UTC)
Received: by mail-dl1-f43.google.com with SMTP id
 a92af1059eb24-1273c690e5bso267783c88.2
 for <amd-gfx@lists.freedesktop.org>; Tue, 31 Mar 2026 09:23:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774974224; cv=none;
 d=google.com; s=arc-20240605;
 b=YUlqEBlguE8U92NLEqmCyflPw0hRorzwamsfk+oUCdd3RVm/3Xy9nE5G5gikFjGytT
 JVz8FFwFeW7Xtj8JYaOHJ8C8yr2ZMpYgSulIGfTNl1FPfcomMX0JgeOwglA5hAd/bnAx
 kf0MmW4f3rk1Kq2c2G2V328GZ/6uovMdM7+8WnhK8r+JQYXc6k9+CrRDKF6T0gn1LbOy
 BVMTXT0wkalJFEKsLUHrC0TkD15ZQxd7Rv+5812K4mOVhq2MPNv1A1lODRpAjPcXKcxR
 QWG94hXxEE8KIdXwL617vcWozbMJGuX3ZWdFuWHmrnolxtDzbq7jNPnv77Lakl2V0K2k
 eUzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=PYOPD176N7TTMWPcKL29AcCJHgMHZkMmMu2KkH5SLkA=;
 fh=5/FDHmCDSK8XEPPNaPWLb6eKx52Erxl9W0yrYZ/YtLE=;
 b=HUXluTt/YsJnqqHCT0z/P4K4XFalXlOEOh2v0OsFqJS57l2M8VikL0MrNiTaR3HV/i
 u9NrQj0W+w15d8qUoM4TqOk9bmrdl2kqsxdJfVnRNovk/uHDUc9Mx8UU8IYQW++fVYzm
 c2fdRjqMMaNoy1GM2RCJSXV8L07necaL8q1qfZhlEtbssIP4OHgViXbwsSfJibQeTNhC
 zixjM644ju/aFc5/7nt8kwL6hZmVEoOgvXqvHCCxkM9gvTj1ZWYihOGMp0Stv41YCLoW
 UXGRTVATdTwgi8qhcMty5Gqy+Sd6Wr7DrdZC9B9F056HKY/40aBCHbYzRpWX7f3x4bvt
 4XCA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1774974224; x=1775579024; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PYOPD176N7TTMWPcKL29AcCJHgMHZkMmMu2KkH5SLkA=;
 b=D5UkrtpcpduNq5wiNXITu+l4rMtsdMh08tmpdgSloGNvaAFoGjz5cRyhRCI9s7Vjfw
 QNHBcxUEVw3GqhHu3kjX6SS+diIHm6e5tKl6QH8GgrL8xdELFW6mqCb7bGX/OkON7Fni
 teMHWFitqlgiFETQgClJCAMLp6wSvUJPzzwybems/bYXVhfo9h9ZgLaTLbA76EbPqiIe
 aoXlKNgE/prIaMj/dxQxxKJ49bCGEFtxQLXnMCR9MNcN/WxVYjrYpaMX9iIlZz8IJpyj
 zDLq6U1Lr+AMUI8EBRsns2560rUc3/32xt+HMfYjnUkVSHmBP0n2p6RT1rVQNnM1lyYd
 RImw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774974224; x=1775579024;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=PYOPD176N7TTMWPcKL29AcCJHgMHZkMmMu2KkH5SLkA=;
 b=BHjriQWnyMVLkTDnxpUjDzeRvJZBVk0An8HNPNFc70Tx2JMyfJPcgeye4uDpt/1XkF
 LXEKS1dNXRmOxz38T0EPemma9BwQKptK/UqLTEZg/6p5EiHL1/v/uWsDBBuZ81PD7Tgl
 A3Nh8Mra7+EV+zpWRIJshyD1hKaJCpGEQqx9Cc/Zz0IwSmBp659FADAKWjGWKl1DkFuR
 crBejFgpOPa8ia3pyNuoAiQYW9SpiiA9mvnYIo9qd61zDsbTQaL6/1D/yMhzl57VPULX
 184VvhIP/s4B7VelYmnZu4dpdBZNyEFTCfmWlhrPy3RmYJmq7ldnqpVuToxZ9NhKFxoz
 sq8w==
X-Gm-Message-State: AOJu0YyusopvDoqMeaU4V89vQEsQap0UTbdmDF2HdOa4YlECuqu4M41p
 f14R2RH7Z8TWKrhqWgcULnbVzsbjID2G/PRh4LmZYcquQUW6YcGW+Ma9LhNeKxEKYXw8vxBEUg9
 l9qPpdWuBAwE9oZpUIDM/p7EwULg058E=
X-Gm-Gg: ATEYQzzQ1Ue2HaiJStDy4pmbmyKSeVQtTxXj2HqiEgggUVidTPc5S1noPW/QVPiZJ7f
 ZWjicxfh6oBOYJddz3YvY4dOtI3xGDP2JGxJ247KsEQQero6ex1tQyrYNQBo45siGElxRU2WkiW
 ExcQq0uYztizFY0Pp52nPbQARO21g4hT8ngOJCiMeDDj1QGoD0Up9b6kwdggzza/JH4nsXEEKVI
 9u0lfmQ9KCRj4WLKfqbLyAgdiveEeJZ3n3tP5KXvwBtnMDEeyNE7SAU8uNIHQ0uUJdFl4MeJZf+
 X87L+gL4LEs/VxVLhlwOBGb/wOToZjNsMpJJYue5B1UshxagadCnnarcc15PL/plwKz8QK4u49Q
 HH9r6
X-Received: by 2002:a05:7022:b92:b0:128:d0cb:7a97 with SMTP id
 a92af1059eb24-12be65999cdmr19949c88.3.1774974223392; Tue, 31 Mar 2026
 09:23:43 -0700 (PDT)
MIME-Version: 1.0
References: <20260327203152.1578828-1-Amber.Lin@amd.com>
 <20260327203152.1578828-2-Amber.Lin@amd.com>
In-Reply-To: <20260327203152.1578828-2-Amber.Lin@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 31 Mar 2026 12:23:32 -0400
X-Gm-Features: AQROBzD_xG_sECEXiktOXgXZ7haa4fUOz-jED7pITajWG9CKIUIkWD1-OLvUDhI
Message-ID: <CADnq5_NgD=ZAx___W=Ub1TF8tye4J__Qfpv3_PY2B1=bCDwskA@mail.gmail.com>
Subject: Re: [PATCH v3 09/10] drm/amdkfd: Reset queue/pipe in MES
To: Amber Lin <Amber.Lin@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Jonathan Kim <jonathan.kim@amd.com>
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

On Fri, Mar 27, 2026 at 4:32=E2=80=AFPM Amber Lin <Amber.Lin@amd.com> wrote=
:
>
> When removing queues fails, KFD calls amdgpu_mes to detect and reset
> hung queues, then cleans up those hung queues in KFD.
>
> Suggested-by: Jonathan Kim <jonathan.kim@amd.com>
> Signed-off-by: Amber Lin <Amber.Lin@amd.com>

This will need greater coordination with KGD user queues on GPUs that
support it, but for now:

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c       |   6 +
>  drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h       |   1 +
>  .../drm/amd/amdkfd/kfd_device_queue_manager.c | 147 +++++++++++++++++-
>  .../drm/amd/amdkfd/kfd_device_queue_manager.h |   4 +-
>  drivers/gpu/drm/amd/amdkfd/kfd_priv.h         |   1 +
>  5 files changed, 156 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_mes.c
> index fb7fdf5d0973..75720d247b4a 100644
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
> index ec8d7f4be840..2670741f3e53 100644
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
> @@ -359,6 +384,92 @@ static int add_all_kfd_queues_mes(struct device_queu=
e_manager *dqm)
>         return retval;
>  }
>
> +static int reset_queues_mes(struct device_queue_manager *dqm)
> +{
> +       struct amdgpu_device *adev =3D (struct amdgpu_device *)dqm->dev->=
adev;
> +       int hqd_info_size =3D adev->mes.hung_queue_hqd_info_offset;
> +       int num_hung =3D 0, r =3D 0, i, pipe, queue, queue_type;
> +       uint32_t *hung_array =3D dqm->hung_db_array;
> +       struct amdgpu_mes_hung_queue_hqd_info *hqd_info =3D dqm->hqd_info=
;
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
> +       if (!hung_array || !hqd_info) {
> +               r =3D -ENOMEM;
> +               goto fail;
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
> +               goto fail;
> +       }
> +
> +       /* MES resets queue/pipe and cleans up internally */
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
> +                       goto fail;
> +               }
> +
> +               pdd =3D kfd_get_process_device_data(q->device, q->process=
);
> +               if (!pdd) {
> +                       r =3D -ENODEV;
> +                       goto fail;
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
> +fail:
> +       dqm->detect_hang_count =3D 0;
> +       return r;
> +}
> +
>  static int suspend_all_queues_mes(struct device_queue_manager *dqm)
>  {
>         struct amdgpu_device *adev =3D (struct amdgpu_device *)dqm->dev->=
adev;
> @@ -371,6 +482,9 @@ static int suspend_all_queues_mes(struct device_queue=
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
> @@ -1821,6 +1935,9 @@ static int start_cpsch(struct device_queue_manager =
*dqm)
>  {
>         struct device *dev =3D dqm->dev->adev->dev;
>         int retval, num_hw_queue_slots;
> +       struct amdgpu_device *adev =3D (struct amdgpu_device *)dqm->dev->=
adev;
> +       int hung_array_size =3D amdgpu_mes_get_hung_queue_db_array_size(a=
dev);
> +       int hqd_info_size =3D adev->mes.hung_queue_hqd_info_offset;
>
>         dqm_lock(dqm);
>
> @@ -1870,6 +1987,11 @@ static int start_cpsch(struct device_queue_manager=
 *dqm)
>                 goto fail_detect_hang_buffer;
>         }
>
> +       dqm->hung_db_array =3D kzalloc(hung_array_size * sizeof(uint32_t)=
, GFP_KERNEL);
> +       dqm->hqd_info =3D kzalloc(
> +               hqd_info_size * sizeof(struct amdgpu_mes_hung_queue_hqd_i=
nfo),
> +               GFP_KERNEL);
> +
>         dqm_unlock(dqm);
>
>         return 0;
> @@ -1910,6 +2032,9 @@ static int stop_cpsch(struct device_queue_manager *=
dqm)
>                 pm_uninit(&dqm->packet_mgr);
>         kfree(dqm->detect_hang_info);
>         dqm->detect_hang_info =3D NULL;
> +       kfree(dqm->hung_db_array);
> +       kfree(dqm->hqd_info);
> +
>         dqm_unlock(dqm);
>
>         return ret;
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
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.h b/driv=
ers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.h
> index 3272328da11f..e6eca38cae4e 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.h
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.h
> @@ -32,7 +32,6 @@
>  #include "kfd_priv.h"
>  #include "kfd_mqd_manager.h"
>
> -
>  #define VMID_NUM 16
>
>  #define KFD_MES_PROCESS_QUANTUM                100000
> @@ -285,6 +284,9 @@ struct device_queue_manager {
>         struct dqm_detect_hang_info *detect_hang_info;
>         size_t detect_hang_info_size;
>         int detect_hang_count;
> +       /* for per-queue reset with mes */
> +       uint32_t *hung_db_array;
> +       struct amdgpu_mes_hung_queue_hqd_info *hqd_info;
>  };
>
>  void device_queue_manager_init_cik(
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
