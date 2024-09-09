Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D46F9ECE58A
	for <amd-gfx@archiver.kernel.org>; Mon,  9 Sep 2024 21:13:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6B79810E6C3;
	Mon,  9 Sep 2024 21:13:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="gG2d/hVO";
	dkim-atps=neutral
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com
 [209.85.214.174])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5F75B10E6C3
 for <amd-gfx@lists.freedesktop.org>; Mon,  9 Sep 2024 21:13:21 +0000 (UTC)
Received: by mail-pl1-f174.google.com with SMTP id
 d9443c01a7336-2056129a6d7so2420325ad.3
 for <amd-gfx@lists.freedesktop.org>; Mon, 09 Sep 2024 14:13:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1725916401; x=1726521201; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6HSi6qcmHPwCx8iQ4gocacLKY6CXt2kgzk1aZpWCeSI=;
 b=gG2d/hVORqveZVHYuy/hykS38lDjc00PwNkYOHHefJILIzukL4n2sDWMO/pTNYRNjF
 sgQ6VE1ti0JGaAp6hOIf4NiIuA8IbgpBe36u74OqOknJW9ekX910TOS2MOsilHiI2ELr
 8VvMk8OhgZJZbYoT/x8DtaDpjOjhdnEcfpkM7RCX1XHU++vbb1dOTMw66f2pVxEDv+jv
 NJgRWrMQYSp4JH+h5P8TbYWwKBdDWTxyaamjltoZELr6xqp4c7D82F6a1HxECzG3mC6J
 bh0Rffo7uNZKbvBku3xoyYSxxbHsC6MWHs2R/20m72NelXArCu5ilrMssjj2b0hoPgad
 7yAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725916401; x=1726521201;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6HSi6qcmHPwCx8iQ4gocacLKY6CXt2kgzk1aZpWCeSI=;
 b=E/Kx0oAeuiPpLQJ6e/xytK3G92FP1yRgzGW/sI/6B2ILYv6FrEB2zSiI4kt7otKp/l
 9uP99cMnqJwjKO4mdRjsG9FjQy+owTEEcUcrQuNb62tn12YJWkN6Z2/iYQGQzpEJjXmB
 LV50NKc+oLaAzVlgIno1tY1TqsnA5NPIUnN5QcWWlM4gJ6xQ2u49YQm3G8KVfKTWFh0L
 YJtWvj4PuoVCAKGKzrRddZ6jsctXBHG6rAg+4gjhXEQgSk3Um8K3TprUq3jqnoV6henD
 +TxYvtPYT021d/foTmAvJCp/AClZvYgNy/2YxMk5yrk0S50Uwwywt5dTk0dhfWzI/Vlf
 9UmA==
X-Gm-Message-State: AOJu0YwNyygbcE5kGcfLST1MDYSETCYelxklnNjzqk7NTnENd2mlJ6gQ
 ZcXlBQH+XyKVomxT44hkdJgbCriicxNO8rrTQ8sz8LYLPuwakfb937eZ5iM4P5fDx8pybOcerLO
 FchmHajptECYdlIhHl1LlMow146M=
X-Google-Smtp-Source: AGHT+IHJJA2dYHP7jQbAcRLmD7mvlWgN5nKh8etlPQv6Z8v1H+IsrQrJ5LodmrD5ObJu1vSqqcmsJqhi646HNQRe9WE=
X-Received: by 2002:a17:903:41cf:b0:205:76f3:fc13 with SMTP id
 d9443c01a7336-206f05faf7bmr65335995ad.7.1725916400801; Mon, 09 Sep 2024
 14:13:20 -0700 (PDT)
MIME-Version: 1.0
References: <20240902073417.2025971-1-lijo.lazar@amd.com>
 <20240902073417.2025971-4-lijo.lazar@amd.com>
In-Reply-To: <20240902073417.2025971-4-lijo.lazar@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 9 Sep 2024 17:13:07 -0400
Message-ID: <CADnq5_P7LN60A=Ds-RDuXs3WT9X_X2n_KgM_zpu8=8dnJtA2Pw@mail.gmail.com>
Subject: Re: [PATCH 03/10] drm/amdgpu: Separate reinitialization after reset
To: Lijo Lazar <lijo.lazar@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Hawking.Zhang@amd.com, 
 Alexander.Deucher@amd.com, Christian.Koenig@amd.com
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

On Mon, Sep 2, 2024 at 3:34=E2=80=AFAM Lijo Lazar <lijo.lazar@amd.com> wrot=
e:
>
> Move the reinitialization part after a reset to another function. No
> functional changes.
>
> Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>

Acked-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu.h        |   2 +
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 150 ++++++++++++---------
>  2 files changed, 89 insertions(+), 63 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/am=
dgpu/amdgpu.h
> index fefdace22894..e1ae898b42eb 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> @@ -1276,6 +1276,8 @@ int amdgpu_device_pre_asic_reset(struct amdgpu_devi=
ce *adev,
>  int amdgpu_do_asic_reset(struct list_head *device_list_handle,
>                          struct amdgpu_reset_context *reset_context);
>
> +int amdgpu_device_reinit_after_reset(struct amdgpu_reset_context *reset_=
context);
> +
>  int emu_soc_asic_init(struct amdgpu_device *adev);
>
>  /*
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm=
/amd/amdgpu/amdgpu_device.c
> index db5046e8b10d..e28227869307 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -5440,75 +5440,25 @@ int amdgpu_device_pre_asic_reset(struct amdgpu_de=
vice *adev,
>         return r;
>  }
>
> -int amdgpu_do_asic_reset(struct list_head *device_list_handle,
> -                        struct amdgpu_reset_context *reset_context)
> +int amdgpu_device_reinit_after_reset(struct amdgpu_reset_context *reset_=
context)
>  {
> -       struct amdgpu_device *tmp_adev =3D NULL;
> -       bool need_full_reset, skip_hw_reset, vram_lost =3D false;
> -       int r =3D 0;
> -
> -       /* Try reset handler method first */
> -       tmp_adev =3D list_first_entry(device_list_handle, struct amdgpu_d=
evice,
> -                                   reset_list);
> -
> -       reset_context->reset_device_list =3D device_list_handle;
> -       r =3D amdgpu_reset_perform_reset(tmp_adev, reset_context);
> -       /* If reset handler not implemented, continue; otherwise return *=
/
> -       if (r =3D=3D -EOPNOTSUPP)
> -               r =3D 0;
> -       else
> -               return r;
> -
> -       /* Reset handler not implemented, use the default method */
> -       need_full_reset =3D
> -               test_bit(AMDGPU_NEED_FULL_RESET, &reset_context->flags);
> -       skip_hw_reset =3D test_bit(AMDGPU_SKIP_HW_RESET, &reset_context->=
flags);
> -
> -       /*
> -        * ASIC reset has to be done on all XGMI hive nodes ASAP
> -        * to allow proper links negotiation in FW (within 1 sec)
> -        */
> -       if (!skip_hw_reset && need_full_reset) {
> -               list_for_each_entry(tmp_adev, device_list_handle, reset_l=
ist) {
> -                       /* For XGMI run all resets in parallel to speed u=
p the process */
> -                       if (tmp_adev->gmc.xgmi.num_physical_nodes > 1) {
> -                               if (!queue_work(system_unbound_wq, &tmp_a=
dev->xgmi_reset_work))
> -                                       r =3D -EALREADY;
> -                       } else
> -                               r =3D amdgpu_asic_reset(tmp_adev);
> -
> -                       if (r) {
> -                               dev_err(tmp_adev->dev, "ASIC reset failed=
 with error, %d for drm dev, %s",
> -                                        r, adev_to_drm(tmp_adev)->unique=
);
> -                               goto out;
> -                       }
> -               }
> +       struct list_head *device_list_handle;
> +       bool full_reset, vram_lost =3D false;
> +       struct amdgpu_device *tmp_adev;
> +       int r;
>
> -               /* For XGMI wait for all resets to complete before procee=
d */
> -               if (!r) {
> -                       list_for_each_entry(tmp_adev, device_list_handle,=
 reset_list) {
> -                               if (tmp_adev->gmc.xgmi.num_physical_nodes=
 > 1) {
> -                                       flush_work(&tmp_adev->xgmi_reset_=
work);
> -                                       r =3D tmp_adev->asic_reset_res;
> -                                       if (r)
> -                                               break;
> -                               }
> -                       }
> -               }
> -       }
> +       device_list_handle =3D reset_context->reset_device_list;
>
> -       if (!r && amdgpu_ras_intr_triggered()) {
> -               list_for_each_entry(tmp_adev, device_list_handle, reset_l=
ist) {
> -                       amdgpu_ras_reset_error_count(tmp_adev, AMDGPU_RAS=
_BLOCK__MMHUB);
> -               }
> +       if (!device_list_handle)
> +               return -EINVAL;
>
> -               amdgpu_ras_intr_cleared();
> -       }
> +       full_reset =3D test_bit(AMDGPU_NEED_FULL_RESET, &reset_context->f=
lags);
>
> +       r =3D 0;
>         list_for_each_entry(tmp_adev, device_list_handle, reset_list) {
>                 /* After reset, it's default init level */
>                 amdgpu_set_init_level(tmp_adev, AMDGPU_INIT_LEVEL_DEFAULT=
);
> -               if (need_full_reset) {
> +               if (full_reset) {
>                         /* post card */
>                         amdgpu_ras_set_fed(tmp_adev, false);
>                         r =3D amdgpu_device_asic_init(tmp_adev);
> @@ -5598,7 +5548,6 @@ int amdgpu_do_asic_reset(struct list_head *device_l=
ist_handle,
>                         r =3D amdgpu_ib_ring_tests(tmp_adev);
>                         if (r) {
>                                 dev_err(tmp_adev->dev, "ib ring test fail=
ed (%d).\n", r);
> -                               need_full_reset =3D true;
>                                 r =3D -EAGAIN;
>                                 goto end;
>                         }
> @@ -5611,10 +5560,85 @@ int amdgpu_do_asic_reset(struct list_head *device=
_list_handle,
>         }
>
>  end:
> -       if (need_full_reset)
> +       return r;
> +}
> +
> +int amdgpu_do_asic_reset(struct list_head *device_list_handle,
> +                        struct amdgpu_reset_context *reset_context)
> +{
> +       struct amdgpu_device *tmp_adev =3D NULL;
> +       bool need_full_reset, skip_hw_reset;
> +       int r =3D 0;
> +
> +       /* Try reset handler method first */
> +       tmp_adev =3D list_first_entry(device_list_handle, struct amdgpu_d=
evice,
> +                                   reset_list);
> +
> +       reset_context->reset_device_list =3D device_list_handle;
> +       r =3D amdgpu_reset_perform_reset(tmp_adev, reset_context);
> +       /* If reset handler not implemented, continue; otherwise return *=
/
> +       if (r =3D=3D -EOPNOTSUPP)
> +               r =3D 0;
> +       else
> +               return r;
> +
> +       /* Reset handler not implemented, use the default method */
> +       need_full_reset =3D
> +               test_bit(AMDGPU_NEED_FULL_RESET, &reset_context->flags);
> +       skip_hw_reset =3D test_bit(AMDGPU_SKIP_HW_RESET, &reset_context->=
flags);
> +
> +       /*
> +        * ASIC reset has to be done on all XGMI hive nodes ASAP
> +        * to allow proper links negotiation in FW (within 1 sec)
> +        */
> +       if (!skip_hw_reset && need_full_reset) {
> +               list_for_each_entry(tmp_adev, device_list_handle, reset_l=
ist) {
> +                       /* For XGMI run all resets in parallel to speed u=
p the process */
> +                       if (tmp_adev->gmc.xgmi.num_physical_nodes > 1) {
> +                               if (!queue_work(system_unbound_wq,
> +                                               &tmp_adev->xgmi_reset_wor=
k))
> +                                       r =3D -EALREADY;
> +                       } else
> +                               r =3D amdgpu_asic_reset(tmp_adev);
> +
> +                       if (r) {
> +                               dev_err(tmp_adev->dev,
> +                                       "ASIC reset failed with error, %d=
 for drm dev, %s",
> +                                       r, adev_to_drm(tmp_adev)->unique)=
;
> +                               goto out;
> +                       }
> +               }
> +
> +               /* For XGMI wait for all resets to complete before procee=
d */
> +               if (!r) {
> +                       list_for_each_entry(tmp_adev, device_list_handle,
> +                                           reset_list) {
> +                               if (tmp_adev->gmc.xgmi.num_physical_nodes=
 > 1) {
> +                                       flush_work(&tmp_adev->xgmi_reset_=
work);
> +                                       r =3D tmp_adev->asic_reset_res;
> +                                       if (r)
> +                                               break;
> +                               }
> +                       }
> +               }
> +       }
> +
> +       if (!r && amdgpu_ras_intr_triggered()) {
> +               list_for_each_entry(tmp_adev, device_list_handle, reset_l=
ist) {
> +                       amdgpu_ras_reset_error_count(tmp_adev,
> +                                                    AMDGPU_RAS_BLOCK__MM=
HUB);
> +               }
> +
> +               amdgpu_ras_intr_cleared();
> +       }
> +
> +       r =3D amdgpu_device_reinit_after_reset(reset_context);
> +       if (r =3D=3D -EAGAIN)
>                 set_bit(AMDGPU_NEED_FULL_RESET, &reset_context->flags);
>         else
>                 clear_bit(AMDGPU_NEED_FULL_RESET, &reset_context->flags);
> +
> +out:
>         return r;
>  }
>
> --
> 2.25.1
>
