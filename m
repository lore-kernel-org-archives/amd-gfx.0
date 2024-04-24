Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF14DC07E8E
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Apr 2024 18:01:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 24CF5113CFB;
	Wed, 24 Apr 2024 18:01:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="KVWHc4Y5";
	dkim-atps=neutral
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com
 [209.85.215.172])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 01A72113CFB
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Apr 2024 18:01:25 +0000 (UTC)
Received: by mail-pg1-f172.google.com with SMTP id
 41be03b00d2f7-5c6bd3100fcso91538a12.3
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Apr 2024 11:01:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1713981685; x=1714586485; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oYnXiqjDr44li/cMqYtNCjorN+7E6Wr1yMEjjC9rcNs=;
 b=KVWHc4Y56fuLwTvmEkUAxPwtVIbA+wxSN+BAoq1D+D+4Tl1WRD3oFBW/aY0jvbNzT3
 T+m0Gqc7SqjU+Y6hY6z53divE7MaT1pevcaVN0s5HrDmnanwmITqrpk484dpyTE4KQ+D
 sAO1h5jYsRaMbIKpgL8VESi9BJ2v5/S6cHS+grLIRrMA4Jf6ayerfXlM9dEmELnFes/H
 vGFIpaXyYuU6TI6hjQEoPUxapxC9Gbp9Zm8cUccp54OT7OYncmr9j8hvqhv2crmKdAgD
 V9carvJIhU3phauLFFea0/7xDZ4FYulaYbXgx/52N5V6FS7PSZLwF+2MvlaCEDAQM1Oc
 0ZdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713981685; x=1714586485;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=oYnXiqjDr44li/cMqYtNCjorN+7E6Wr1yMEjjC9rcNs=;
 b=IV5HSsrjyjnYBuWcrszzHYFSunW0241q28giPR5/WhtmL0xHyKnCnlRY9BmPSiJ94/
 ojSf1ifntzx0fSQ7Q+ZmzrqDvoq/Q3CI1odHrsnj3asd1yubDIwvYpMUUCCeevTFJhJH
 Ff90JKWjjMGSg6BNGrfBpiuY6UQPZK6fD1bXeZTNfiuuxwwic2hNdMa1uVsRtPdL7MOA
 msplWBad9yGRPS7HJmiVskaqpHC1j1YsvDJkKxF7/JpIegVzfk4AaWS+WUxVwbx+JYpF
 LTb1oMKDfN+yUctLShFAHhkoDU1VEp4SUaRq1ouabO3nvIJ6Sflb1owWN1uc9xD1KqCx
 G+9A==
X-Gm-Message-State: AOJu0YyEwbQpk3lJ4dyDwRKqp9LaiqKs4ZfSr1JsSNa4XICWnyijumuX
 B8Hv4qmPoeqS5WZlWYxCrany/V9KD7DkAPjIeJDbNQ8slA48EZvtfPbMnevUWiRepS6igcK288s
 ld9cUrCaOeQ5x2CX+epabqf06OsX2uQ==
X-Google-Smtp-Source: AGHT+IFFVNAHjkQJBviMG5l3w5TzblmXuEMbEgI057frfGQ7IYywps2MOOIoHhEfG6WxpLhlfFxKSubMjoZ+ExYyjpw=
X-Received: by 2002:a17:90b:4c12:b0:2af:8959:2cc with SMTP id
 na18-20020a17090b4c1200b002af895902ccmr1352797pjb.9.1713981685180; Wed, 24
 Apr 2024 11:01:25 -0700 (PDT)
MIME-Version: 1.0
References: <20240424174038.840827-1-Harish.Kasiviswanathan@amd.com>
In-Reply-To: <20240424174038.840827-1-Harish.Kasiviswanathan@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 24 Apr 2024 14:01:12 -0400
Message-ID: <CADnq5_O-fyEKeGUJOEiQdV9tPLYZBigHZPZd0ygkAM-jJFTZpQ@mail.gmail.com>
Subject: Re: [PATCH] drm/amdkfd: Enforce queue BO's adev
To: Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>
Cc: amd-gfx@lists.freedesktop.org
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

On Wed, Apr 24, 2024 at 1:57=E2=80=AFPM Harish Kasiviswanathan
<Harish.Kasiviswanathan@amd.com> wrote:
>
> Queue buffer, though it is in system memory, has to be created using the
> correct amdgpu device. Enforce this as the BO needs to mapped to the
> GART for MES Hardware scheduler to access it.
>
> Signed-off-by: Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdkfd/kfd_chardev.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/a=
md/amdkfd/kfd_chardev.c
> index 8fd5e0da628c..963cf6d657cb 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> @@ -373,6 +373,11 @@ static int kfd_ioctl_create_queue(struct file *filep=
, struct kfd_process *p,
>                         err =3D -EINVAL;
>                         goto err_wptr_map_gart;
>                 }
> +               if (dev->adev !=3D amdgpu_ttm_adev(wptr_bo->tbo.bdev)) {
> +                       pr_err("Queue memory allocated to wrong device\n"=
);
> +                       err =3D -EINVAL;
> +                       goto err_wptr_map_gart;
> +               }
>
>                 err =3D amdgpu_amdkfd_map_gtt_bo_to_gart(dev->adev, wptr_=
bo);
>                 if (err) {
> --
> 2.34.1
>
