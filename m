Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 519EFC4345F
	for <amd-gfx@archiver.kernel.org>; Wed, 17 Apr 2024 15:52:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B68DF10F6F2;
	Wed, 17 Apr 2024 15:52:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="nK2s3jyS";
	dkim-atps=neutral
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com
 [209.85.215.182])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 35E5F10F6F2
 for <amd-gfx@lists.freedesktop.org>; Wed, 17 Apr 2024 15:52:37 +0000 (UTC)
Received: by mail-pg1-f182.google.com with SMTP id
 41be03b00d2f7-5cddfe0cb64so3337475a12.0
 for <amd-gfx@lists.freedesktop.org>; Wed, 17 Apr 2024 08:52:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1713369156; x=1713973956; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PmzH2BnM2Zmd2FNBTNmJTu0HZlqhgKeESG/BA4tPqic=;
 b=nK2s3jySLTzlYDUfLDou8epmsfWqLW3+70ySDFxcFXWPme9CmlbsMRAX89bKVHYh8c
 83rUurisC+ksqKEt1Pg7F7xna1RqxE1BQ/Xojakt2p2OK2nqyAiE2hQ3N1SSdNquhWgy
 MEaGRn7zSHIFpAFNMYJ1PfFztnYN3uxf+2KU7BRAgXL9wsk9rR38R+fBKfZUTQnFzvSc
 MGWGNNKimU0lm4e3V97VbvrqTIEG6q5PlpgZr4moja3H0f9cVS2oIHkHopCIKUoX0Fc9
 +XhiVX5y0EimUQ/cEtRN9YB9OQ4gCfb5vb1EwlR8mKRHcVnpbbMLbNCz1zuukNOGnGe2
 XRnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713369156; x=1713973956;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PmzH2BnM2Zmd2FNBTNmJTu0HZlqhgKeESG/BA4tPqic=;
 b=QJvrAqsV/Ua4UTQA4O5mRyAAC6i5+wF5EJtNrNSD62ycvWA2JiZsVIZVGM/+EgNGMZ
 Um3txmvlxtIA3LZ8hV8MIqaDC0cX96MW8lIc7Ht2L4JOoUM9twnQK5lahyX/xbjAkWCd
 ekKisuZBW7vyLFnimuBO1rgpQzzMfZyY/UBi4nAgGEuLfnJljN44qIbr+6Haet0yYnEZ
 v/LdvHkj6hzAI/g/dkij64Ue819W75d3KKcukgj5ss2TvEjg+MCUbiKBoGVCdyBba+nD
 XOxaOdZXnVj4QLHr4W1ORNolYTmBp4SxD0mZFTPaun0zW5W6sl6Xi3A3hFDeWSWccoCL
 KHpg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWdpUNUCE2zo3ysZP9+30Wle92xDtausTZZiQZLc+TGIZGES9VP+YcAj1VeYH46Qzq7w4Kj6Oy5BLQpq8bYJwWaYedHtgV8xFnBVfLcUw==
X-Gm-Message-State: AOJu0YxTW56jeBMR60usFGdj7nHV5c+A+fnpol1Ws2zFf8Jdj8gvdZpK
 R9VcgJOXWBDHmXBJGBJ2gf6KNfOEc8RsPjZTRjmq53hzpdoANmyUND79TsUlhFCLpOCjWwuiUmU
 Dzo363R13BU6V0Sc493VWSIPP717YXlZ+
X-Google-Smtp-Source: AGHT+IFXGP8cpL7NzCN39XWvjr833S7rFe3mHmMBPDJRfkiMeqLXafDq8jWDyGLKCzS+jPJjHC3EpgUtewSI+weRv1g=
X-Received: by 2002:a17:90a:1b82:b0:2a9:ef6b:9b82 with SMTP id
 w2-20020a17090a1b8200b002a9ef6b9b82mr8532392pjc.38.1713369156472; Wed, 17 Apr
 2024 08:52:36 -0700 (PDT)
MIME-Version: 1.0
References: <20240417093809.168002-1-sunil.khatri@amd.com>
 <20240417093809.168002-5-sunil.khatri@amd.com>
In-Reply-To: <20240417093809.168002-5-sunil.khatri@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 17 Apr 2024 11:52:25 -0400
Message-ID: <CADnq5_OGCybphwvZYJ_fz0g2LAt0tcc0K2RBX-aad6PRCRchHg@mail.gmail.com>
Subject: Re: [PATCH v5 5/6] drm/amdgpu: dump ip state before reset for each ip
To: Sunil Khatri <sunil.khatri@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>, 
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

On Wed, Apr 17, 2024 at 5:38=E2=80=AFAM Sunil Khatri <sunil.khatri@amd.com>=
 wrote:
>
> Invoke the dump_ip_state function for each ip before
> the asic resets and save the register values for
> debugging via devcoredump.
>
> Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm=
/amd/amdgpu/amdgpu_device.c
> index f3b7cb18fd46..f8a34db5d9e3 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -5353,6 +5353,7 @@ int amdgpu_do_asic_reset(struct list_head *device_l=
ist_handle,
>         struct amdgpu_device *tmp_adev =3D NULL;
>         bool need_full_reset, skip_hw_reset, vram_lost =3D false;
>         int r =3D 0;
> +       uint32_t i;
>
>         /* Try reset handler method first */
>         tmp_adev =3D list_first_entry(device_list_handle, struct amdgpu_d=
evice,
> @@ -5361,6 +5362,12 @@ int amdgpu_do_asic_reset(struct list_head *device_=
list_handle,
>         if (!test_bit(AMDGPU_SKIP_COREDUMP, &reset_context->flags))
>                 amdgpu_reset_reg_dumps(tmp_adev);
>
> +       /* Trigger ip dump before we reset the asic */
> +       for (i =3D 0; i < tmp_adev->num_ip_blocks; i++)
> +               if (tmp_adev->ip_blocks[i].version->funcs->dump_ip_state)
> +                       tmp_adev->ip_blocks[i].version->funcs->dump_ip_st=
ate(
> +                               (void *)tmp_adev);
> +
>         reset_context->reset_device_list =3D device_list_handle;
>         r =3D amdgpu_reset_perform_reset(tmp_adev, reset_context);
>         /* If reset handler not implemented, continue; otherwise return *=
/
> --
> 2.34.1
>
