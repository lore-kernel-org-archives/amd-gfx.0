Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81BF3CAC59A
	for <amd-gfx@archiver.kernel.org>; Fri, 19 Sep 2025 13:08:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0F3EC10E9FA;
	Fri, 19 Sep 2025 13:08:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="N1W5Nnmp";
	dkim-atps=neutral
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com
 [209.85.214.182])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 168B110E9FA
 for <amd-gfx@lists.freedesktop.org>; Fri, 19 Sep 2025 13:08:07 +0000 (UTC)
Received: by mail-pl1-f182.google.com with SMTP id
 d9443c01a7336-267dbd4e189so4609565ad.1
 for <amd-gfx@lists.freedesktop.org>; Fri, 19 Sep 2025 06:08:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1758287286; x=1758892086; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5tu/k7GNWlgszf2+SNXROxMGKfuE8Ll4FMHGjE7SOz4=;
 b=N1W5NnmpeF2q6k1/Te9VMkGCzKByKejXBPqU4m8DF4PjVfmWx4ESFIwXOs7qnSSAGR
 K9AP8UNzHWS79/z6+5HSfuENpiux5wnFpjN5N6pA0bfxMVmGPEzY2c67GaUVG3XkhMZv
 8AsBvZga88faYTYHXhetYPlB/r9BPAnNSZn4nps9If379h7ZMMinsNv+b2EYDtrloV3h
 rfdBeQccc729NMVuVdUcPtry1hK+G3tlC6p1OawMzCnaGv22G9aklaVHA/nPTip15WKs
 BuDtb/FaakNMzO3GIPyjWZFcxpP2R09vGW8dcnTAGujz6xGMlW7r6GqD8B+xgRLjYeaz
 UaUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758287286; x=1758892086;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5tu/k7GNWlgszf2+SNXROxMGKfuE8Ll4FMHGjE7SOz4=;
 b=WZUPc5kZhSpHCcXZuORO4NrQ9YeugeWq6cHYOoOQ1WN212yqoMb6Q4CcNM+W+EKASR
 rI4JTtddqUPaFUTG6vfW9+mUtguLlwkO57kZrw5ez6tkNbEVs6IEWk8+eURxi2OqPOri
 KuQcolt6wvvSflZuGh9CxW8dtoC5ztcdzk+BlSJhVQfCYZEJJ2/4NGHap7ER3Lq+POn+
 KLynGw8B6cJcoxrcH/bo3ejxpWoQwVOj+MSe8tx5k1x/iBR+XdBI5wZsj/Mg36pWlsf+
 1bQ5wuJS8XPJxdcN7Irq39U8XHCYg8RUnrpY/qIOQYrDKDbz0jiQcySIfEurIY8+m+jY
 fBtw==
X-Gm-Message-State: AOJu0Yzqy1ljhQbRyQR/7ek4t9sbHMmjRXmunfw6Rs8zf/QUaEUqx+FS
 2SR8AAAbbrVrB9tBOvfqedVeBEINmfxkWSM83vlz3U+/plqfZgiCRQ8OXxmc6jW6qlHEkWZ0FgE
 myzKbqRmTT8aEsfVOeyF1qB3Buqjgd0+mnQ==
X-Gm-Gg: ASbGncsXFR5L6L5ikAYUBDVwJ22VPpuO1LIvSBcztb6IqAgdP7L1dqTWvU0jK+KZRx2
 qYDOZYJxhctOMv7jlzdPGrP8GnwQ71DWV5LY8h8dyrzSIgYSM221LpAObbdCxXkv1mqQEpMpdCG
 rDgLyrDxODGrmwqPDje6Y8dCUyBRc/xqD4I/y0DhaXDBz4FwLt3E+stF1yzbEHmISIPFlZoq6XV
 PRX524=
X-Google-Smtp-Source: AGHT+IEIEdg/xbXQ0LYPZRVbSvZQgrz7xq85ThHREp3CGTCHjQ17yJ50NYB1ZaMoXUZTOit2WIl9IILjxylB3+/IiFw=
X-Received: by 2002:a17:903:1c3:b0:263:cd95:9c8a with SMTP id
 d9443c01a7336-269ba4675e8mr27470215ad.3.1758287286468; Fri, 19 Sep 2025
 06:08:06 -0700 (PDT)
MIME-Version: 1.0
References: <20250919004800.125555-1-superm1@kernel.org>
In-Reply-To: <20250919004800.125555-1-superm1@kernel.org>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 19 Sep 2025 09:07:54 -0400
X-Gm-Features: AS18NWCF8j4uVk3zBx7Fi3c9jJV7WCUYcM_zpZ0wWiMhz54G_QHuvoXffTR29h8
Message-ID: <CADnq5_Ocy21YobXERacyDYwpqfR_K6o+EUxc3_z+414FrOn7rw@mail.gmail.com>
Subject: Re: [PATCH v3] drm/amdgpu: Enable MES lr_compute_wa by default
To: "Mario Limonciello (AMD)" <superm1@kernel.org>
Cc: amd-gfx@lists.freedesktop.org, 
 Mario Limonciello <mario.limonciello@amd.com>,
 Yifan Zhang <yifan1.zhang@amd.com>
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

On Thu, Sep 18, 2025 at 9:04=E2=80=AFPM Mario Limonciello (AMD)
<superm1@kernel.org> wrote:
>
> From: Mario Limonciello <mario.limonciello@amd.com>
>
> The MES set resources packet has an optional bit 'lr_compute_wa'
> which can be used for preventing MES hangs on long compute jobs.
>
> Set this bit by default.
>
> Co-developed-by: Yifan Zhang <yifan1.zhang@amd.com>
> Signed-off-by: Yifan Zhang <yifan1.zhang@amd.com>
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>

Acked-by: Alex Deucher <alexander.deucher@amd.com>

> ---
> v3:
>  * gate on fw version
> v2:
>  * drop module parameter
>  * add more description to commit text
> ---
>  drivers/gpu/drm/amd/amdgpu/mes_v11_0.c        | 6 ++++++
>  drivers/gpu/drm/amd/amdgpu/mes_v12_0.c        | 5 +++++
>  drivers/gpu/drm/amd/include/mes_v11_api_def.h | 3 ++-
>  drivers/gpu/drm/amd/include/mes_v12_api_def.h | 3 ++-
>  4 files changed, 15 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c b/drivers/gpu/drm/amd=
/amdgpu/mes_v11_0.c
> index 3b91ea601add4..e82188431f796 100644
> --- a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
> @@ -713,6 +713,12 @@ static int mes_v11_0_set_hw_resources(struct amdgpu_=
mes *mes)
>         mes_set_hw_res_pkt.enable_reg_active_poll =3D 1;
>         mes_set_hw_res_pkt.enable_level_process_quantum_check =3D 1;
>         mes_set_hw_res_pkt.oversubscription_timer =3D 50;
> +       if ((mes->adev->mes.sched_version & AMDGPU_MES_VERSION_MASK) >=3D=
 0x7f)
> +               mes_set_hw_res_pkt.enable_lr_compute_wa =3D 1;
> +       else
> +               dev_info_once(mes->adev->dev,
> +                             "MES FW version must be >=3D 0x7f to enable=
 LR compute workaround.\n");
> +
>         if (amdgpu_mes_log_enable) {
>                 mes_set_hw_res_pkt.enable_mes_event_int_logging =3D 1;
>                 mes_set_hw_res_pkt.event_intr_history_gpu_mc_ptr =3D
> diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c b/drivers/gpu/drm/amd=
/amdgpu/mes_v12_0.c
> index 998893dff08e9..aff06f06aeeec 100644
> --- a/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
> @@ -769,6 +769,11 @@ static int mes_v12_0_set_hw_resources(struct amdgpu_=
mes *mes, int pipe)
>         mes_set_hw_res_pkt.use_different_vmid_compute =3D 1;
>         mes_set_hw_res_pkt.enable_reg_active_poll =3D 1;
>         mes_set_hw_res_pkt.enable_level_process_quantum_check =3D 1;
> +       if ((mes->adev->mes.sched_version & AMDGPU_MES_VERSION_MASK) >=3D=
 0x82)
> +               mes_set_hw_res_pkt.enable_lr_compute_wa =3D 1;
> +       else
> +               dev_info_once(adev->dev,
> +                             "MES FW version must be >=3D 0x82 to enable=
 LR compute workaround.\n");
>
>         /*
>          * Keep oversubscribe timer for sdma . When we have unmapped door=
bell
> diff --git a/drivers/gpu/drm/amd/include/mes_v11_api_def.h b/drivers/gpu/=
drm/amd/include/mes_v11_api_def.h
> index 15680c3f49704..ab1cfc92dbeb1 100644
> --- a/drivers/gpu/drm/amd/include/mes_v11_api_def.h
> +++ b/drivers/gpu/drm/amd/include/mes_v11_api_def.h
> @@ -238,7 +238,8 @@ union MESAPI_SET_HW_RESOURCES {
>                                 uint32_t enable_mes_sch_stb_log : 1;
>                                 uint32_t limit_single_process : 1;
>                                 uint32_t is_strix_tmz_wa_enabled  :1;
> -                               uint32_t reserved : 13;
> +                               uint32_t enable_lr_compute_wa : 1;
> +                               uint32_t reserved : 12;
>                         };
>                         uint32_t        uint32_t_all;
>                 };
> diff --git a/drivers/gpu/drm/amd/include/mes_v12_api_def.h b/drivers/gpu/=
drm/amd/include/mes_v12_api_def.h
> index c04bd351b2505..69611c7e30e35 100644
> --- a/drivers/gpu/drm/amd/include/mes_v12_api_def.h
> +++ b/drivers/gpu/drm/amd/include/mes_v12_api_def.h
> @@ -287,7 +287,8 @@ union MESAPI_SET_HW_RESOURCES {
>                                 uint32_t limit_single_process : 1;
>                                 uint32_t unmapped_doorbell_handling: 2;
>                                 uint32_t enable_mes_fence_int: 1;
> -                               uint32_t reserved : 10;
> +                               uint32_t enable_lr_compute_wa : 1;
> +                               uint32_t reserved : 9;
>                         };
>                         uint32_t uint32_all;
>                 };
> --
> 2.43.0
>
