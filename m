Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 849FBECE58A
	for <amd-gfx@archiver.kernel.org>; Mon,  9 Sep 2024 21:29:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2FD4310E65A;
	Mon,  9 Sep 2024 21:29:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="UDU5kaRo";
	dkim-atps=neutral
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com
 [209.85.210.176])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 25BD010E65A
 for <amd-gfx@lists.freedesktop.org>; Mon,  9 Sep 2024 21:29:53 +0000 (UTC)
Received: by mail-pf1-f176.google.com with SMTP id
 d2e1a72fcca58-718e0421143so597786b3a.0
 for <amd-gfx@lists.freedesktop.org>; Mon, 09 Sep 2024 14:29:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1725917392; x=1726522192; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MxCfaWp/qePhGAWCgEImS/398sZWZ32TVJCA49D/i4I=;
 b=UDU5kaRoXbtquYiRcKUb9J0dvAc0eqDrEKuWiFZ0LOKjX0LRYt935I7xtp6mAYMCJL
 Y3erWc6yMftm81mr931+XP64IXhezKfg/5h1WVq30k5xeAXiXedtvof3JvzEA5BPK1gX
 kXrweVuTxDDqUVjSuCrban+yWCQKrz7RyrzfuJEHa/6+dpnapyVm5JjNmS64JMuypjFa
 yOdejO+4ly2zQSj5fIXNve1xc/uFXH+/cTQ3pNDG+tx6zq0gD0oPlUKX5xV9KDePAwDC
 /kXK2xy77P+Qh76AeGYaq9dMUgW5I0e6EVSZ0Vd6g0a0RlX7Z9oT/VyW9KJzWG0NUlGu
 zo+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725917393; x=1726522193;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MxCfaWp/qePhGAWCgEImS/398sZWZ32TVJCA49D/i4I=;
 b=CVMLYLXMqTwfbrGWLN6c3IM2cktICC3RACaWERQ5XiSNb4lJr3PrvfOSeOWWxTIvKK
 Nt4kIytx9NtvV+GDTRWygK4lbMtXYZDOmvRSwZm+P+oW0Oicu2U5jT/7i8ut712iMJEG
 ZGSjbckis5/iuhHVFjE4UWKz7phiOuyINLARjplrH28rgtLHKKIZAgYx2PdrkMXprch8
 7f6sW8U3O1Kqux0tN0hiFB+Zw4sIRdo9djIl88xjeVrbQj+mIkv5nMVVtgjOZlM3o5R7
 Zq8BEGjku8vstAKyT7rP9FH/HfEl/x8aQSqjglf07Jl4UgpRwXyGK8Fj6g0p3LowfH2l
 pfmQ==
X-Gm-Message-State: AOJu0Yw5upqDMxMiloTfkTPpgLgsFKvh7Uq9TgOdBoUdkV5MysPaeEJ7
 99b/fRkg4GZFDfyyfXUfvzZg3EPoOkc2e9rKVNqJAnYVemMEJREuoLNZmLQFpDOTD/L1ED9Q01c
 DLjQRLdM89B7WC6FCY1n+Yotr+jVdpw==
X-Google-Smtp-Source: AGHT+IEZ4Mwfcdj25oPd06uvhU2Ifuj4OwUIT3ZT1yTVdTvKRl94mAnMzL2Iec3qcp7uf5oZQUxiMfVmgYEd1wMJZgA=
X-Received: by 2002:a05:6a00:928a:b0:70b:705f:8c5d with SMTP id
 d2e1a72fcca58-718d5f3888emr6544391b3a.4.1725917392374; Mon, 09 Sep 2024
 14:29:52 -0700 (PDT)
MIME-Version: 1.0
References: <20240902073417.2025971-1-lijo.lazar@amd.com>
 <20240902073417.2025971-6-lijo.lazar@amd.com>
In-Reply-To: <20240902073417.2025971-6-lijo.lazar@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 9 Sep 2024 17:29:40 -0400
Message-ID: <CADnq5_N-qCv1aswCNA=QFCiLQBnjawv+DtuTpa9XAfkF4gXS_A@mail.gmail.com>
Subject: Re: [PATCH 05/10] drm/amdgpu: Add helper to initialize badpage info
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

On Mon, Sep 2, 2024 at 3:53=E2=80=AFAM Lijo Lazar <lijo.lazar@amd.com> wrot=
e:
>
> Add a separate function to read badpage data during initialization.
> Reading bad pages will need hardware access and cannot be done during
> reset. Hence in cases where device needs a full reset during
> init itself, attempting to read will cause a deadlock.
>
> Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c |  2 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c    | 56 +++++++++++++++-------
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h    |  4 +-
>  3 files changed, 41 insertions(+), 21 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm=
/amd/amdgpu/amdgpu_device.c
> index e28227869307..468c4f590183 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -2945,7 +2945,7 @@ static int amdgpu_device_ip_init(struct amdgpu_devi=
ce *adev)
>          * Note: theoretically, this should be called before all vram all=
ocations
>          * to protect retired page from abusing
>          */
> -       r =3D amdgpu_ras_recovery_init(adev);
> +       r =3D amdgpu_ras_recovery_init(adev, true);
>         if (r)
>                 goto init_failed;
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_ras.c
> index 2076f157cb6a..65c891b6b999 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> @@ -3146,7 +3146,42 @@ static int amdgpu_ras_page_retirement_thread(void =
*param)
>         return 0;
>  }
>
> -int amdgpu_ras_recovery_init(struct amdgpu_device *adev)
> +int amdgpu_ras_init_badpage_info(struct amdgpu_device *adev)
> +{
> +       struct amdgpu_ras *con =3D amdgpu_ras_get_context(adev);
> +       int ret;
> +
> +       if (!con || amdgpu_sriov_vf(adev))
> +               return 0;
> +
> +       ret =3D amdgpu_ras_eeprom_init(&con->eeprom_control);
> +
> +       if (ret)
> +               return ret;
> +
> +       /* HW not usable */
> +       if (amdgpu_ras_is_rma(adev))
> +               return -EHWPOISON;
> +
> +       if (con->eeprom_control.ras_num_recs) {
> +               ret =3D amdgpu_ras_load_bad_pages(adev);
> +               if (ret)
> +                       return ret;
> +
> +               amdgpu_dpm_send_hbm_bad_pages_num(
> +                       adev, con->eeprom_control.ras_num_recs);
> +
> +               if (con->update_channel_flag =3D=3D true) {
> +                       amdgpu_dpm_send_hbm_bad_channel_flag(
> +                               adev, con->eeprom_control.bad_channel_bit=
map);
> +                       con->update_channel_flag =3D false;
> +               }
> +       }
> +
> +       return ret;
> +}
> +
> +int amdgpu_ras_recovery_init(struct amdgpu_device *adev, bool init_bp_in=
fo)
>  {
>         struct amdgpu_ras *con =3D amdgpu_ras_get_context(adev);
>         struct ras_err_handler_data **data;
> @@ -3187,25 +3222,10 @@ int amdgpu_ras_recovery_init(struct amdgpu_device=
 *adev)
>          */
>         if (adev->init_lvl->level =3D=3D AMDGPU_INIT_LEVEL_MINIMAL)
>                 return 0;
> -       ret =3D amdgpu_ras_eeprom_init(&con->eeprom_control);
> -       /*
> -        * This calling fails when is_rma is true or
> -        * ret !=3D 0.
> -        */
> -       if (amdgpu_ras_is_rma(adev) || ret)
> -               goto free;
> -
> -       if (con->eeprom_control.ras_num_recs) {
> -               ret =3D amdgpu_ras_load_bad_pages(adev);
> +       if (init_bp_info) {
> +               ret =3D amdgpu_ras_init_badpage_info(adev);
>                 if (ret)
>                         goto free;
> -
> -               amdgpu_dpm_send_hbm_bad_pages_num(adev, con->eeprom_contr=
ol.ras_num_recs);
> -
> -               if (con->update_channel_flag =3D=3D true) {
> -                       amdgpu_dpm_send_hbm_bad_channel_flag(adev, con->e=
eprom_control.bad_channel_bitmap);
> -                       con->update_channel_flag =3D false;
> -               }
>         }
>
>         mutex_init(&con->page_rsv_lock);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_ras.h
> index 669720a9c60a..871b2d6278e0 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
> @@ -736,8 +736,8 @@ struct amdgpu_ras_block_hw_ops {
>   * 8: feature disable
>   */
>
> -
> -int amdgpu_ras_recovery_init(struct amdgpu_device *adev);
> +int amdgpu_ras_init_badpage_info(struct amdgpu_device *adev);
> +int amdgpu_ras_recovery_init(struct amdgpu_device *adev, bool init_bp_in=
fo);
>
>  void amdgpu_ras_resume(struct amdgpu_device *adev);
>  void amdgpu_ras_suspend(struct amdgpu_device *adev);
> --
> 2.25.1
>
