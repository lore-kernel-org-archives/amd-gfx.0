Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93BECC6FD18
	for <amd-gfx@archiver.kernel.org>; Wed, 29 Mar 2023 13:15:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 171F910EAA2;
	Wed, 29 Mar 2023 13:15:27 +0000 (UTC)
Received: from mail-oo1-xc2b.google.com (mail-oo1-xc2b.google.com
 [IPv6:2607:f8b0:4864:20::c2b])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BD6BE10EAA2
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 Mar 2023 13:15:25 +0000 (UTC)
Received: by mail-oo1-xc2b.google.com with SMTP id
 m6-20020a4ae846000000b0053b9059edd5so2413350oom.3
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 Mar 2023 06:15:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20210112; t=1680095725;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Q8SipV3Qq9vrgx3AoG9VAtYOW2WSJfWzgMu2Bq9TJps=;
 b=BWe+mo0gCJLjqesYA9e69ajnGi4IO4NOcwfA4c6eEg1nbYg7NelGB3yBfS/0QTJ2BF
 j+eW5LS1xiTLsU1knqDX69zKf+SWorV5rM3VkZ0bEhKNPkOyQjqxWZgoEjx8APfOPIKM
 pd1TVuPR5mmG+pp4UTZ0DqoHmFBU1sx3zyYUHR2SSHYjOuM8kzSAaXQdY2h8iqjoDg1q
 mQq4xAWie1Uv4TZOcNHMzBsce9/Yxy/wRbw2lF5rWU3mNgA5vqj9OhR1d0rD7pTxYTFp
 fYayseaTwLj/xgXfLNZX7A+5i4U5IhNnBDnoN5odkNjDWAv0J70Iz7LVgpEHTj8U5WLI
 LgIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1680095725;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Q8SipV3Qq9vrgx3AoG9VAtYOW2WSJfWzgMu2Bq9TJps=;
 b=wT+UZ+jlDdpqu6fvtqDvUXOtog3fdfPUHZxdf4GnwPUHTkrDkmvYofY9oQq1Qshgbj
 o+UZQZAgC/GjemVN37I9IZhnk9Q3LzMlPk9BS13s+XIgG7TMdfXAC89ktMDZiPKEFsJX
 PjxcvDBV+WsEfH/otecwUkfSHdhJ7L1QlJJ8bKI3YY9zbMWiT+QAWemWyCChfEBlE21j
 niTvBTZ64FK6/NnxGUIIeT6BlMdWRY0KWA3R6dMUT4b/SZQRdJo2ri6j8U5SsqNQ5xh5
 txUoWH4As8n7siWfx3lCPwkbFyKrP9rw3kRkWVEwyz6/ruRJwYlnKqyQS9GcQ/5n0lG4
 S5nA==
X-Gm-Message-State: AO0yUKX8UIup94/vLJE/Q5IOB3VT5NR+d3cjlkQ13Agh9u8ncjrjXPPa
 g4qiduhY6kK6WsEzPtUznQF0eFnx20pkFf5gXLE=
X-Google-Smtp-Source: AK7set8rhxgn5tQlcytp3lAs4s2e0tb1dfoLI9I7cu7fr5HOo4M5siyCPdHhda89LZgT745K8x3iMaYohf/71qN00vY=
X-Received: by 2002:a4a:de11:0:b0:53b:7a81:fe64 with SMTP id
 y17-20020a4ade11000000b0053b7a81fe64mr6030461oot.0.1680095724919; Wed, 29 Mar
 2023 06:15:24 -0700 (PDT)
MIME-Version: 1.0
References: <20230329101033.2581741-1-Jack.Xiao@amd.com>
In-Reply-To: <20230329101033.2581741-1-Jack.Xiao@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 29 Mar 2023 09:15:13 -0400
Message-ID: <CADnq5_MQFvxM6+YQW5MGfyBa7S=o_QdNtiNXoizWoCmNJqVuOg@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/amdgpu: introduce gc_*_mes_2.bin
To: Jack Xiao <Jack.Xiao@amd.com>
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
Cc: Alexander.Deucher@amd.com, amd-gfx@lists.freedesktop.org,
 Hawking.Zhang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Wed, Mar 29, 2023 at 6:11=E2=80=AFAM Jack Xiao <Jack.Xiao@amd.com> wrote=
:
>
> To avoid new mes fw running with old driver, rename
> mes schq fw to gc_*_mes_2.bin.
>
> Signed-off-by: Jack Xiao <Jack.Xiao@amd.com>

Please add the necessary MODULE_FIRMWARE() declaration as well.  With
that, the patch is:
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c | 26 +++++++++++++++++++++----
>  1 file changed, 22 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_mes.c
> index 0e55823ef6ca..f0f00466b59f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
> @@ -1434,13 +1434,31 @@ int amdgpu_mes_init_microcode(struct amdgpu_devic=
e *adev, int pipe)
>         struct amdgpu_firmware_info *info;
>         char ucode_prefix[30];
>         char fw_name[40];
> +       bool need_retry =3D false;
>         int r;
>
> -       amdgpu_ucode_ip_version_decode(adev, GC_HWIP, ucode_prefix, sizeo=
f(ucode_prefix));
> -       snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_mes%s.bin",
> -               ucode_prefix,
> -               pipe =3D=3D AMDGPU_MES_SCHED_PIPE ? "" : "1");
> +       amdgpu_ucode_ip_version_decode(adev, GC_HWIP, ucode_prefix,
> +                                      sizeof(ucode_prefix));
> +       if (adev->ip_versions[GC_HWIP][0] >=3D IP_VERSION(11, 0, 0)) {
> +               snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_mes%s.bin",
> +                        ucode_prefix,
> +                        pipe =3D=3D AMDGPU_MES_SCHED_PIPE ? "_2" : "1");
> +               need_retry =3D true;
> +       } else {
> +               snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_mes%s.bin",
> +                        ucode_prefix,
> +                        pipe =3D=3D AMDGPU_MES_SCHED_PIPE ? "" : "1");
> +       }
> +
>         r =3D amdgpu_ucode_request(adev, &adev->mes.fw[pipe], fw_name);
> +       if (r && need_retry && pipe =3D=3D AMDGPU_MES_SCHED_PIPE) {
> +               snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_mes.bin",
> +                        ucode_prefix);
> +               DRM_INFO("try to fall back to %s\n", fw_name);
> +               r =3D amdgpu_ucode_request(adev, &adev->mes.fw[pipe],
> +                                        fw_name);
> +       }
> +
>         if (r)
>                 goto out;
>
> --
> 2.37.3
>
