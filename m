Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63E2AC3DA70
	for <amd-gfx@archiver.kernel.org>; Fri, 26 Jul 2024 13:12:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EC1F510E98D;
	Fri, 26 Jul 2024 13:12:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ImGObLhc";
	dkim-atps=neutral
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com
 [209.85.215.182])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D981A10E976
 for <amd-gfx@lists.freedesktop.org>; Fri, 26 Jul 2024 13:12:16 +0000 (UTC)
Received: by mail-pg1-f182.google.com with SMTP id
 41be03b00d2f7-7a0e8b76813so638148a12.3
 for <amd-gfx@lists.freedesktop.org>; Fri, 26 Jul 2024 06:12:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1721999536; x=1722604336; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iWLvkNwMsF05ZVVEmt5jMFwAzfQC/IYqC4H/yTBxTAA=;
 b=ImGObLhcyNKzgDwHcc1T+G+zQSx1smiaG3fdxWIaUUUbRJnctkeseF4fFJBOISeQ8I
 lDtFQ8CVXhA2CJTGfrQF8YoPXRrMp+Hqmfkquk0u5LVPbSpZpo0yXmx/N6ii8hYj2g46
 Yuoys3qrJ0MWeIC0E5skexDgBsGJxTxkiYt3xg9rXOtt7GLYEnrcwORBtalY4b13f5Yj
 NofHlMU30vDmYATwtk69wzKHi1atHsQWmiOyAeK4iJuQeCbMKpvqgWtJ2h1ke+8mjWfK
 JzM7geGATVQLWXnB9rOyebzK4A0FIfURPQndZ+ALJkcsZwfOuJGy+dAVXKkORhUnqWiq
 /pvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721999536; x=1722604336;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=iWLvkNwMsF05ZVVEmt5jMFwAzfQC/IYqC4H/yTBxTAA=;
 b=wGOCJOD/gt2ECbiMgsFhubFAoAC33HOVKK8hvEplhEDcVxMUVJmWoemlugaEdTUJCN
 0PYYP7D/jcj86k+bKgnMu+T5Z+oiAsWn4PtPyMlQwlHWsJS9LzmB7OrASry5UBvmlCzD
 vuBjNB4HlvJgvblbcpnnD1Z39591GGktWh9o9f4hVwV2yFDPMuni+sLeWm9olrXE70lt
 H+1/OUF91sC2crnSpeOCA+05XUAGIbNnwSQtHkV2/Ye8q7RYuw7KGYJ5kbwOK2pgCcTC
 nw0b5N2b9HQz6RmKvJSZ03tS8+2l7Ruq9DwzgzYVI5vRtTyxi+yLjVkyGP1vAyqsSM1L
 MF8A==
X-Forwarded-Encrypted: i=1;
 AJvYcCW4vSBIk5e8e0AhI1dV/NQzXyJudqF7y5gkt1fxCfYeutdUfboYlCxWqGFEXYtu2ECXhN0fAsQ/xhkLobR+V2OyG28+xpSaGl3ijD19WA==
X-Gm-Message-State: AOJu0YwPS50nK3rz55+MWvE9/jTk+S2SVd0LOa+2emrbBz/3Ua0h0/XQ
 vfDla2pCIvc+Uou00vSJmOpr77HSMw5xxC3wzw4SnLgWVWarxobsx20JIAhSFmSUnZgbv1wZsYa
 ePI+VakhTb1PMGyGj0D2VIlWtuOvCIA==
X-Google-Smtp-Source: AGHT+IF1LwdX+J3iH2m7vbYMQt0Qjgr+LuYYd5jLN/MGTLYjYegF6n9TxaK8NP9xFlGtThypHXkxJjjZvXHW27+biE4=
X-Received: by 2002:a17:90a:4dc4:b0:2c9:9fcd:aa51 with SMTP id
 98e67ed59e1d1-2cf2e9cfdb6mr5848698a91.5.1721999536237; Fri, 26 Jul 2024
 06:12:16 -0700 (PDT)
MIME-Version: 1.0
References: <20240726124751.3121312-1-sunil.khatri@amd.com>
 <20240726124751.3121312-2-sunil.khatri@amd.com>
In-Reply-To: <20240726124751.3121312-2-sunil.khatri@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 26 Jul 2024 09:12:04 -0400
Message-ID: <CADnq5_NdYiwGGvyVvg3_0aUuH9YLL_kUgNUpjEad8z8E1xWfMQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] drm/amdgpu: trigger ip dump before suspend of IP's
To: Sunil Khatri <sunil.khatri@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>, Liu Leo <Leo.Liu@amd.com>, 
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 amd-gfx@lists.freedesktop.org
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

On Fri, Jul 26, 2024 at 8:48=E2=80=AFAM Sunil Khatri <sunil.khatri@amd.com>=
 wrote:
>
> Problem:
> IP dump right now is done post suspend of
> all IP's which for some IP's could change power
> state and software state too which we do not want
> to reflect in the dump as it might not be same at
> the time of hang.
>
> Solution:
> IP should be dumped as close to the HW state when
> the GPU was in hung state without trying to reinitialize
> any resource.
>
> Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>

Acked-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 60 +++++++++++-----------
>  1 file changed, 30 insertions(+), 30 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm=
/amd/amdgpu/amdgpu_device.c
> index 730dae77570c..74f6f15e73b5 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -5277,11 +5277,29 @@ int amdgpu_device_mode1_reset(struct amdgpu_devic=
e *adev)
>         return ret;
>  }
>
> +static int amdgpu_reset_reg_dumps(struct amdgpu_device *adev)
> +{
> +       int i;
> +
> +       lockdep_assert_held(&adev->reset_domain->sem);
> +
> +       for (i =3D 0; i < adev->reset_info.num_regs; i++) {
> +               adev->reset_info.reset_dump_reg_value[i] =3D
> +                       RREG32(adev->reset_info.reset_dump_reg_list[i]);
> +
> +               trace_amdgpu_reset_reg_dumps(adev->reset_info.reset_dump_=
reg_list[i],
> +                                            adev->reset_info.reset_dump_=
reg_value[i]);
> +       }
> +
> +       return 0;
> +}
> +
>  int amdgpu_device_pre_asic_reset(struct amdgpu_device *adev,
>                                  struct amdgpu_reset_context *reset_conte=
xt)
>  {
>         int i, r =3D 0;
>         struct amdgpu_job *job =3D NULL;
> +       struct amdgpu_device *tmp_adev =3D reset_context->reset_req_dev;
>         bool need_full_reset =3D
>                 test_bit(AMDGPU_NEED_FULL_RESET, &reset_context->flags);
>
> @@ -5340,6 +5358,18 @@ int amdgpu_device_pre_asic_reset(struct amdgpu_dev=
ice *adev,
>                         }
>                 }
>
> +               if (!test_bit(AMDGPU_SKIP_COREDUMP, &reset_context->flags=
)) {
> +                       amdgpu_reset_reg_dumps(tmp_adev);
> +
> +                       dev_info(tmp_adev->dev, "Dumping IP State\n");
> +                       /* Trigger ip dump before we reset the asic */
> +                       for (i =3D 0; i < tmp_adev->num_ip_blocks; i++)
> +                               if (tmp_adev->ip_blocks[i].version->funcs=
->dump_ip_state)
> +                                       tmp_adev->ip_blocks[i].version->f=
uncs->dump_ip_state(
> +                                                       (void *)tmp_adev)=
;
> +                       dev_info(tmp_adev->dev, "Dumping IP State Complet=
ed\n");
> +               }
> +
>                 if (need_full_reset)
>                         r =3D amdgpu_device_ip_suspend(adev);
>                 if (need_full_reset)
> @@ -5352,47 +5382,17 @@ int amdgpu_device_pre_asic_reset(struct amdgpu_de=
vice *adev,
>         return r;
>  }
>
> -static int amdgpu_reset_reg_dumps(struct amdgpu_device *adev)
> -{
> -       int i;
> -
> -       lockdep_assert_held(&adev->reset_domain->sem);
> -
> -       for (i =3D 0; i < adev->reset_info.num_regs; i++) {
> -               adev->reset_info.reset_dump_reg_value[i] =3D
> -                       RREG32(adev->reset_info.reset_dump_reg_list[i]);
> -
> -               trace_amdgpu_reset_reg_dumps(adev->reset_info.reset_dump_=
reg_list[i],
> -                                            adev->reset_info.reset_dump_=
reg_value[i]);
> -       }
> -
> -       return 0;
> -}
> -
>  int amdgpu_do_asic_reset(struct list_head *device_list_handle,
>                          struct amdgpu_reset_context *reset_context)
>  {
>         struct amdgpu_device *tmp_adev =3D NULL;
>         bool need_full_reset, skip_hw_reset, vram_lost =3D false;
>         int r =3D 0;
> -       uint32_t i;
>
>         /* Try reset handler method first */
>         tmp_adev =3D list_first_entry(device_list_handle, struct amdgpu_d=
evice,
>                                     reset_list);
>
> -       if (!test_bit(AMDGPU_SKIP_COREDUMP, &reset_context->flags)) {
> -               amdgpu_reset_reg_dumps(tmp_adev);
> -
> -               dev_info(tmp_adev->dev, "Dumping IP State\n");
> -               /* Trigger ip dump before we reset the asic */
> -               for (i =3D 0; i < tmp_adev->num_ip_blocks; i++)
> -                       if (tmp_adev->ip_blocks[i].version->funcs->dump_i=
p_state)
> -                               tmp_adev->ip_blocks[i].version->funcs
> -                               ->dump_ip_state((void *)tmp_adev);
> -               dev_info(tmp_adev->dev, "Dumping IP State Completed\n");
> -       }
> -
>         reset_context->reset_device_list =3D device_list_handle;
>         r =3D amdgpu_reset_perform_reset(tmp_adev, reset_context);
>         /* If reset handler not implemented, continue; otherwise return *=
/
> --
> 2.34.1
>
