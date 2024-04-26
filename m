Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F37DC4345F
	for <amd-gfx@archiver.kernel.org>; Fri, 26 Apr 2024 01:06:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7064611A92D;
	Fri, 26 Apr 2024 01:06:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="kzv/a+db";
	dkim-atps=neutral
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com
 [209.85.214.174])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 34AB411A92D
 for <amd-gfx@lists.freedesktop.org>; Fri, 26 Apr 2024 01:06:14 +0000 (UTC)
Received: by mail-pl1-f174.google.com with SMTP id
 d9443c01a7336-1e36b7e7dd2so14139625ad.1
 for <amd-gfx@lists.freedesktop.org>; Thu, 25 Apr 2024 18:06:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1714093573; x=1714698373; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gC5q8R8z6tysII6oMMDPGDBxkS7aVeOACjZ9HbT9khY=;
 b=kzv/a+dbfak8C6WN1LBT8arknGIgdOGPtqt7QL1PhhdHw+jRpPH+lpIoq45EvbYGZN
 izGFjgLwFBMV6M/ZwFNBo+Us0Jto4BXn2hn5WVeTt36pzkiKTND5m0H6kCr4GAn8Nasy
 VWu5uw1qYQsxHQGGuw5VcSo+4XhkIYR2xr53z1EgyZhskqkB7UcMbogKulm1/k2WyW36
 kBrg/a4r8C9erkq9e7k5cKGYxgKu6P3q2ibWzpbGcSZeP845itQNorVUtk53Xys/jJnG
 6zlhTTQe8DsHePxlSnZGW0xxXh8ISSJ2AAhl3kQCURH41rq0scv7RotFisAXtTi21Cn5
 L72Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714093573; x=1714698373;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gC5q8R8z6tysII6oMMDPGDBxkS7aVeOACjZ9HbT9khY=;
 b=ezj0FZJcTmf5ItY/v/OZv1iL3Rr9/wK7bUj5dkM2RnyeMcnoPdEz9IdJyuNiEz3H6r
 xespK7gYJzQvZdHVYa6Wx2v/q69HxRJAonyRvT5GOZFdIN/s5mCbmnvALPU1w4jfD+GS
 kW/+DJissWrK8/KnUmwFVwyBPWJmjPTpWNJDRm/7+ie4hXF9Iv4OKZfRMp8fJc9Ob7ML
 XQmTYhMcOQWrdDNOR5dhg3EhzHE0foSmdwkBMDjfkNedpJtuDQAxWU8srRh1lxGX/zF7
 W4cQ7NwC2INCjBJxsU9LmWZnrTbUppHURlwgWteZeDPh9QKR2h0Q5q8SH1Qo4C1Bw6kk
 EjYw==
X-Gm-Message-State: AOJu0YyCpVZFScXUUQfJgTGUOyOuRLY93smLeIY9mycED423ApHy0nb6
 mebbasElE+eafZIN/XMbYx0B6RjHBxGQUtrGKJg1N4vvUO6D1q3t1djkPwyj29o0Ge6DoWWp7d0
 8JvVcitPWMs7f0kzx45LUIxqZHU54MA==
X-Google-Smtp-Source: AGHT+IGdsQSBNuH58cRekKSMnUIuEN80c73bqvMFlMnz9bQpJDGjmSBiprVjknDDwvTbqfbw+yDyaN6SDMVCnQd/YPA=
X-Received: by 2002:a17:90a:6686:b0:2ad:3688:fcea with SMTP id
 m6-20020a17090a668600b002ad3688fceamr1362600pjj.18.1714093573265; Thu, 25 Apr
 2024 18:06:13 -0700 (PDT)
MIME-Version: 1.0
References: <20240426002719.1329953-1-Tim.Huang@amd.com>
In-Reply-To: <20240426002719.1329953-1-Tim.Huang@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 25 Apr 2024 21:06:01 -0400
Message-ID: <CADnq5_Oqejq5FDDUBfw8YMfA7bMo5gMtrzWReNQLt3_fpzvR9g@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: fix overflowed array index read warning
To: Tim Huang <Tim.Huang@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Alexander.Deucher@amd.com, 
 christian.koenig@amd.com
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

On Thu, Apr 25, 2024 at 8:37=E2=80=AFPM Tim Huang <Tim.Huang@amd.com> wrote=
:
>
> Clear overflowed array index read warning by cast operation.
>
> Signed-off-by: Tim Huang <Tim.Huang@amd.com>

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_ring.c
> index 06f0a6534a94..15c240656470 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
> @@ -473,8 +473,9 @@ static ssize_t amdgpu_debugfs_ring_read(struct file *=
f, char __user *buf,
>                                         size_t size, loff_t *pos)
>  {
>         struct amdgpu_ring *ring =3D file_inode(f)->i_private;
> -       int r, i;
>         uint32_t value, result, early[3];
> +       loff_t i;
> +       int r;
>
>         if (*pos & 3 || size & 3)
>                 return -EINVAL;
> --
> 2.39.2
>
