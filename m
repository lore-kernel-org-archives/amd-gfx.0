Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36576F3D315
	for <amd-gfx@archiver.kernel.org>; Thu,  5 Mar 2026 16:06:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CC1AC10E1E5;
	Thu,  5 Mar 2026 16:06:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="QA4v2zAS";
	dkim-atps=neutral
Received: from mail-dl1-f52.google.com (mail-dl1-f52.google.com [74.125.82.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DD3B110E1E5
 for <amd-gfx@lists.freedesktop.org>; Thu,  5 Mar 2026 16:06:03 +0000 (UTC)
Received: by mail-dl1-f52.google.com with SMTP id
 a92af1059eb24-12736a0147cso418577c88.1
 for <amd-gfx@lists.freedesktop.org>; Thu, 05 Mar 2026 08:06:03 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772726763; cv=none;
 d=google.com; s=arc-20240605;
 b=DAMBhizBXKIDDqqG0ESdQujeu9rOE1rLe0ZTxlmJRIMxCL4ejKukBLuTGZa2TWQJ8p
 6Kf+hkmM58OLQwEZsM/Je6O6DPW9A/FHT978+aeDLCiavf3bqCtpN33TkvMrcAtXdlGu
 N2wPfSPyFks/eK37oQCWPZV+/JDc7Q5nN8tq+8A54QO/9F5JvbNVZGVOZpyjvByqg/J4
 7d8CxAvNsYpQS9fIkA7EWsRyoNYnJtgrG0i857BZmV9siXrQWQwbFlF/+a9A/uNvTSvJ
 A4+YelqaeR9Dz5jkahDbVGMFocRnQ0OqeC8MnI9KBmlaHjWbS0++8FdgM6TM0ptoe7Ll
 AjEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=M3Kd20gVvSlVv4+Nt1TrsuAV0KsHbJ2Dir1Z/N6WLkg=;
 fh=Q8XfLa/HsYYJ909fZsdcfL9dG6jXKK0n9+vL1EIokXc=;
 b=A+fQ8m27mzZweMKGOLgK84LZ20gQ3pGmnmacvbuqjE/VHgxBQmNUZvYnoIEEvwRppt
 zb86Q172iL6fzyv/zBAZufIgKJIUHY24htnF1D9V2y52850qggoCXI9RQj/+g1VFb68l
 tJb1A253BLH7qVqYHNMOmfwzfEOol1ly6FeNv4UMH5WsCDGiMJeehsag5tdhzTAHIHMK
 12HUWgTqi7JMSOc/ziLbGx962wlps6jljF86Ts+1JqFtFUWaft7AGcdkbhM1b5aPrvgJ
 jVxi1WqW5K6pkH5B7M7GHPWwSDsxQRqeASITxzcKoGuguOgeTJTiawDroc2+6YsACFoi
 l59w==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1772726763; x=1773331563; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=M3Kd20gVvSlVv4+Nt1TrsuAV0KsHbJ2Dir1Z/N6WLkg=;
 b=QA4v2zASvBgO/P4QmDHEmQL1eQ+loVavQ8Vyh70E3hM2xWpwH3xwgyuvalUFvwomyM
 5YmpP0evgRQtxTOOXJ3vWgUxPCKtloCdaYufCoKLfuZl6AiFTAo4/zC3w/3S+ce4CINO
 snxJqS0Z3YUyMumxB/jICzgPazcmVWk+7/wjJck52JE7ujCRBbRFsejLM0ace5Xg4UXG
 hDBQzDrOxVopFIB6PPqLAYM28M9SZQgHFWO9xE4AI+mGhM+38HaEBKIcPOMtlwvktkyd
 0P0d8EBJ++qay1Ui4Jk4OwTHKN+dxEwMHuZ0eIED5c8SX3inc7If3vzzbSygOoFaquZ+
 wscg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772726763; x=1773331563;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=M3Kd20gVvSlVv4+Nt1TrsuAV0KsHbJ2Dir1Z/N6WLkg=;
 b=omS29ckXKqmS11Z2v/hEUvbnokSxnxB4bq9sixTVic5L7wTKY9p5VJoZtQRMOCHhBB
 Bi8A4qsEBEgE47ANd03wg2aSdlZYQefnO7RyurOGng2rWzz5sgmd1khio6CBXShqd/Wj
 oZYpc2HuwyzKUArAJKzu5jKEz8nJbS0+3487nO+gmOMdXVSlbeHgpvbDYWYftcDMiz6g
 tVetO3TJ91lxHb+h1VgMJlblRIgTEppxWKBYtOilPiwaN0qmSRSefXOkNoXU2k/dYBaE
 SDXqHHpgMFMiZNakDUs1/2lsdT0VMEbM+Cs+8PsYjSdGk0Fd1Y31MtpJxZiPIfSOLKR4
 DxHQ==
X-Gm-Message-State: AOJu0YzqkVaHi4u77D1NMmamSe1kmbmDzxry1mV9lDRuRmV/uJYdMRTk
 bdD80ODEPmrV+1UMGukFof/ifpdNnhIDd4FKCsaH0tIftmxQuq4S/X3sPWfCxHi/QXevh3I9SkM
 rdzhZLaluBSdxl3Nsrcxz4+5zgnAT0I8=
X-Gm-Gg: ATEYQzxFbvcx74OGTi+KqqIZajfnhuuKR3u4rwau/q5uwm9MtXOwZGVTF6phVZan9+A
 qr8IW2Upw1uUBn8fW/3NOdR2+SDSQn9TpoX3AQrUUqQUh8wMNvcEc4C2k5iukxoRe8cxl3HHNNv
 wRAlTPyh8/SxeH81JCsvbOBtRiBf5r5GntK7TkIdz0r3ydqtvfRBEiC2yNeIYLTqfMd2y9AiDTn
 1uTLfcgR7eiDbKW/dcd0Trt1fOio2uJSwUx0/ykYRsWvwz5AVavt0BX2S9ZM2tEn+MxjKE1yXtG
 +0u1Rc8yoYTRrdruj1qi4gy83tmT0JVUld/8Uu2508npQ6KZqYQdXSBiCyLZqtpYqoMzWw==
X-Received: by 2002:a05:7022:ec84:b0:127:3480:7ca5 with SMTP id
 a92af1059eb24-128b7066dbbmr1593978c88.2.1772726762868; Thu, 05 Mar 2026
 08:06:02 -0800 (PST)
MIME-Version: 1.0
References: <20260304183303.1116307-1-David.Francis@amd.com>
In-Reply-To: <20260304183303.1116307-1-David.Francis@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 5 Mar 2026 11:05:51 -0500
X-Gm-Features: AaiRm506feDZKBNAy-WT1RuODc9-pDbT55JembkQ4n6J1Bvy8BoD9jF-4NDHKLU
Message-ID: <CADnq5_PjHB5R916dz7+kVRkxzUDHA9J-Kp+5cJfZ87Vnu38USw@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: Check for multiplication overflow in
 checkpoint stack size
To: David Francis <David.Francis@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Alexander.Deucher@amd.com
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

On Wed, Mar 4, 2026 at 1:33=E2=80=AFPM David Francis <David.Francis@amd.com=
> wrote:
>
> get_checkpoint_info() in kfd_mqd_manager_v9.c finds 32-bit value
> ctl_stack_size by multiplying two 32-bit values. This can overflow to a
> lower value, which could result in copying outside the bounds of
> a buffer in checkpoint_mqd() in the same file.
>
> Put in a check for the overflow, and fail with -EINVAL if detected.
>
> v2: use check_mul_overflow()
>
> Signed-off-by: David Francis <David.Francis@amd.com>

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c  | 7 +++++--
>  drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.h  | 2 +-
>  drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.h           | 3 ++-
>  drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c        | 7 +++++--
>  drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_vi.c        | 3 ++-
>  drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c | 8 +++++++-
>  6 files changed, 22 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/driv=
ers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> index 804851632c4c..18bc5ba25f8f 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> @@ -2720,7 +2720,7 @@ static int get_wave_state(struct device_queue_manag=
er *dqm,
>                         ctl_stack, ctl_stack_used_size, save_area_used_si=
ze);
>  }
>
> -static void get_queue_checkpoint_info(struct device_queue_manager *dqm,
> +static int get_queue_checkpoint_info(struct device_queue_manager *dqm,
>                         const struct queue *q,
>                         u32 *mqd_size,
>                         u32 *ctl_stack_size)
> @@ -2728,6 +2728,7 @@ static void get_queue_checkpoint_info(struct device=
_queue_manager *dqm,
>         struct mqd_manager *mqd_mgr;
>         enum KFD_MQD_TYPE mqd_type =3D
>                         get_mqd_type_from_queue_type(q->properties.type);
> +       int ret =3D 0;
>
>         dqm_lock(dqm);
>         mqd_mgr =3D dqm->mqd_mgrs[mqd_type];
> @@ -2735,9 +2736,11 @@ static void get_queue_checkpoint_info(struct devic=
e_queue_manager *dqm,
>         *ctl_stack_size =3D 0;
>
>         if (q->properties.type =3D=3D KFD_QUEUE_TYPE_COMPUTE && mqd_mgr->=
get_checkpoint_info)
> -               mqd_mgr->get_checkpoint_info(mqd_mgr, q->mqd, ctl_stack_s=
ize);
> +               ret =3D mqd_mgr->get_checkpoint_info(mqd_mgr, q->mqd, ctl=
_stack_size);
>
>         dqm_unlock(dqm);
> +
> +       return ret;
>  }
>
>  static int checkpoint_mqd(struct device_queue_manager *dqm,
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.h b/driv=
ers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.h
> index ef07e44916f8..3272328da11f 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.h
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.h
> @@ -192,7 +192,7 @@ struct device_queue_manager_ops {
>
>         int (*reset_queues)(struct device_queue_manager *dqm,
>                                         uint16_t pasid);
> -       void    (*get_queue_checkpoint_info)(struct device_queue_manager =
*dqm,
> +       int     (*get_queue_checkpoint_info)(struct device_queue_manager =
*dqm,
>                                   const struct queue *q, u32 *mqd_size,
>                                   u32 *ctl_stack_size);
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.h b/drivers/gpu/d=
rm/amd/amdkfd/kfd_mqd_manager.h
> index 2429d278ef0e..06ca6235ff1b 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.h
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.h
> @@ -102,7 +102,8 @@ struct mqd_manager {
>                                   u32 *ctl_stack_used_size,
>                                   u32 *save_area_used_size);
>
> -       void    (*get_checkpoint_info)(struct mqd_manager *mm, void *mqd,=
 uint32_t *ctl_stack_size);
> +       int     (*get_checkpoint_info)(struct mqd_manager *mm, void *mqd,
> +                                      uint32_t *ctl_stack_size);
>
>         void    (*checkpoint_mqd)(struct mqd_manager *mm,
>                                   void *mqd,
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c b/drivers/gp=
u/drm/amd/amdkfd/kfd_mqd_manager_v9.c
> index 273d52c8d332..8630f679a5d4 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
> @@ -385,11 +385,14 @@ static int get_wave_state(struct mqd_manager *mm, v=
oid *mqd,
>         return 0;
>  }
>
> -static void get_checkpoint_info(struct mqd_manager *mm, void *mqd, u32 *=
ctl_stack_size)
> +static int get_checkpoint_info(struct mqd_manager *mm, void *mqd, u32 *c=
tl_stack_size)
>  {
>         struct v9_mqd *m =3D get_mqd(mqd);
>
> -       *ctl_stack_size =3D m->cp_hqd_cntl_stack_size * NUM_XCC(mm->dev->=
xcc_mask);
> +       if (check_mul_overflow(m->cp_hqd_cntl_stack_size, NUM_XCC(mm->dev=
->xcc_mask), ctl_stack_size))
> +               return -EINVAL;
> +
> +       return 0;
>  }
>
>  static void checkpoint_mqd(struct mqd_manager *mm, void *mqd, void *mqd_=
dst, void *ctl_stack_dst)
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_vi.c b/drivers/gp=
u/drm/amd/amdkfd/kfd_mqd_manager_vi.c
> index c192c66a5c7b..499d366db91c 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_vi.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_vi.c
> @@ -274,10 +274,11 @@ static int get_wave_state(struct mqd_manager *mm, v=
oid *mqd,
>         return 0;
>  }
>
> -static void get_checkpoint_info(struct mqd_manager *mm, void *mqd, u32 *=
ctl_stack_size)
> +static int get_checkpoint_info(struct mqd_manager *mm, void *mqd, u32 *c=
tl_stack_size)
>  {
>         /* Control stack is stored in user mode */
>         *ctl_stack_size =3D 0;
> +       return 0;
>  }
>
>  static void checkpoint_mqd(struct mqd_manager *mm, void *mqd, void *mqd_=
dst, void *ctl_stack_dst)
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c b/dri=
vers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
> index 449be58e884c..cb2416687137 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
> @@ -1069,6 +1069,7 @@ int pqm_get_queue_checkpoint_info(struct process_qu=
eue_manager *pqm,
>                                   uint32_t *ctl_stack_size)
>  {
>         struct process_queue_node *pqn;
> +       int ret;
>
>         pqn =3D get_queue_by_qid(pqm, qid);
>         if (!pqn) {
> @@ -1081,9 +1082,14 @@ int pqm_get_queue_checkpoint_info(struct process_q=
ueue_manager *pqm,
>                 return -EOPNOTSUPP;
>         }
>
> -       pqn->q->device->dqm->ops.get_queue_checkpoint_info(pqn->q->device=
->dqm,
> +       ret =3D pqn->q->device->dqm->ops.get_queue_checkpoint_info(pqn->q=
->device->dqm,
>                                                        pqn->q, mqd_size,
>                                                        ctl_stack_size);
> +       if (ret) {
> +               pr_debug("amdkfd: Overflow while computing stack size for=
 queue %d\n", qid);
> +               return ret;
> +       }
> +
>         return 0;
>  }
>
> --
> 2.34.1
>
