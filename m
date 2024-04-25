Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC511C4345F
	for <amd-gfx@archiver.kernel.org>; Thu, 25 Apr 2024 13:29:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2EB9211A46D;
	Thu, 25 Apr 2024 13:29:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Kvk4RjGk";
	dkim-atps=neutral
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com
 [209.85.215.178])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 170EF11A46D
 for <amd-gfx@lists.freedesktop.org>; Thu, 25 Apr 2024 13:29:57 +0000 (UTC)
Received: by mail-pg1-f178.google.com with SMTP id
 41be03b00d2f7-53fa455cd94so739098a12.2
 for <amd-gfx@lists.freedesktop.org>; Thu, 25 Apr 2024 06:29:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1714051796; x=1714656596; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3Y2ZQiCvp/0piWjVZobwsBGtjGzvGlH9waCrqsfoi8w=;
 b=Kvk4RjGkaUahh7kIUX2W2HOcOS7Vuh9NtZ0Am1v+a9YUo/OLvBj2ZyadQUfP26Nx6g
 +4VoGeVpBP513yfS1yPVKeco5S096UQPBBeslNG5vllleL6u2cqBFa6J/qBT9VxzSqeG
 Ch95B8g3aGg1FwCkQlfp9QvimFWkRS7dPxUzvxr8DGpKl6WtRpyr3tCxeHp7CzPf4M3z
 8b1pDBK3dtP7xpY2VKXtqaIvbng96UxNMVgdZobX3Pz09/NvIM98pe98AM0nE5aA9gp6
 7aojJEwULdrJ1ST1tQT/wIkL7MiAJib7MxdGYjS9RnB3/OFNtAPOXZPUAHQM5wC0s7vw
 c3Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714051796; x=1714656596;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3Y2ZQiCvp/0piWjVZobwsBGtjGzvGlH9waCrqsfoi8w=;
 b=r1sZ4AZgxi4psmQVvdceUP7Y0gT12Oey1J05DmE6g/UdXWZ1MJuGTh9JOBQKZWHpIm
 onxMfOsTLRaYJ3joff655yVNvXnp+YXyBP7RGxAON8obm3aC1h1AgYIM9iCeghmL0UqL
 MYP7MMKdRsOOevu0fBEP+3LLnfV24fIGB6szvLXGKL5y4to/y1X2nQBoV/uwQt+Y7T6w
 AY0Cz5h/YiJ3JG1KAGXqHSQQxjelH2iOuN/TMOppUQyJpUUuRw/TNucOZpCo4w/dJ6G3
 TvxglNBxbqq4PATvKfvJPjM0QOteyS+RYw/c0eZLHM1BaxS6kaKoApR1F1SZmOFQKHZy
 4q7Q==
X-Gm-Message-State: AOJu0YzykKgBQtz2bndF5K1tgUw34QV8ItzrQDOl43e8yY4JdJCNWX6s
 PS1sa5yA0PTN0xSM8ulAi7QFWkj/D65IT8D7QGsa9LGn1lfH7SmT7eii3XiMVMBUwDQSfb7YYkM
 sZAiCDqTOMe2oSOwb5CDtn6E2Qb4=
X-Google-Smtp-Source: AGHT+IFdUifdVnZH2Vf23KgBBaOiRqHrpXSv220tQnYdtWTCz8MXdIiPGlXJI9xal8JYJDH9C4uD2G7K3jdC3qlRBZI=
X-Received: by 2002:a17:90a:d30a:b0:2a9:f861:223e with SMTP id
 p10-20020a17090ad30a00b002a9f861223emr5250885pju.29.1714051796432; Thu, 25
 Apr 2024 06:29:56 -0700 (PDT)
MIME-Version: 1.0
References: <20240425071736.907300-1-jesse.zhang@amd.com>
In-Reply-To: <20240425071736.907300-1-jesse.zhang@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 25 Apr 2024 09:29:45 -0400
Message-ID: <CADnq5_P=T4OQTrk+0=RTR9caxN7QNVMp2HkkDLG_dBQmxCLFcw@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: fix the warning about the expression
 (int)size - len
To: Jesse Zhang <jesse.zhang@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Alexander.Deucher@amd.com, 
 Christian Koenig <christian.koenig@amd.com>, Tim.Huang@amd.com
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

On Thu, Apr 25, 2024 at 3:37=E2=80=AFAM Jesse Zhang <jesse.zhang@amd.com> w=
rote:
>
> Converting size from size_t to int may overflow.
> v2: keep reverse xmas tree order (Christian)
>
> Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c b/drivers/gpu/dr=
m/amd/amdgpu/amdgpu_debugfs.c
> index f5d0fa207a88..b62ae3c91a9d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
> @@ -2065,12 +2065,13 @@ static ssize_t amdgpu_reset_dump_register_list_wr=
ite(struct file *f,
>         struct amdgpu_device *adev =3D (struct amdgpu_device *)file_inode=
(f)->i_private;
>         char reg_offset[11];
>         uint32_t *new =3D NULL, *tmp =3D NULL;
> -       int ret, i =3D 0, len =3D 0;
> +       unsigned int len =3D 0;
> +       int ret, i =3D 0;
>
>         do {
>                 memset(reg_offset, 0, 11);
>                 if (copy_from_user(reg_offset, buf + len,
> -                                       min(10, ((int)size-len)))) {
> +                                       min(10, (size-len)))) {
>                         ret =3D -EFAULT;
>                         goto error_free;
>                 }
> --
> 2.25.1
>
