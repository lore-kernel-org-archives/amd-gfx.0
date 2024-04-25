Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F217C4345F
	for <amd-gfx@archiver.kernel.org>; Thu, 25 Apr 2024 13:28:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B1DCD10F005;
	Thu, 25 Apr 2024 13:28:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="hfM+4v/v";
	dkim-atps=neutral
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com
 [209.85.215.171])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 205EE10E0B9
 for <amd-gfx@lists.freedesktop.org>; Thu, 25 Apr 2024 13:28:18 +0000 (UTC)
Received: by mail-pg1-f171.google.com with SMTP id
 41be03b00d2f7-517ab9a4a13so730293a12.1
 for <amd-gfx@lists.freedesktop.org>; Thu, 25 Apr 2024 06:28:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1714051697; x=1714656497; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mExCpp3DB+gEft5T9Ba4raToZqQJpOB9oxbrTKL60MQ=;
 b=hfM+4v/vxTZcbDZapLGFnoYtL9n8dAQqLqZ+nvq3zN4jp09jrkY1gHESKuI//DXaXy
 ZDE5JtF4g2LT9kPRWQm0LYm5DgxSNgJCpoxTYBPgECSYe40Uo91uQYsGOQYD9nhXM7E4
 5/bqImJAJ0QYKgo4NAv5jrYmVQV+8rrD0UGpALewSti0qco9sxhb+BjF1O3X99YpB3/1
 0LuA4Tj7oEg7cjh6w21ZFf7BElFPNpNHxxJ3XV6U8nPFx5Mst+Jw59m6ebv/pqrpFlm1
 VGEbBGRctP4vBuoXUCesHKa/BCMxzTYS1DcxtPLOs2huKmxGIztdw6C4ZontzXw+CuoS
 G+DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714051697; x=1714656497;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mExCpp3DB+gEft5T9Ba4raToZqQJpOB9oxbrTKL60MQ=;
 b=uDN5ryGAAP55k/jL75fTNsQDz72TgOtJuNIZxstrh2eb/n+m/N7bywGVP9tv3393Li
 Hg9PwiDg934YLiWZrWToLFQUk+0gHBpv/mklx6lVUJ1RnO1DbWKFTGKAeOr2zWOX0lZk
 bd3B38o9TPF9R01XE3PztUAMOv9+Ju9OmMho8q56WAqiXmeiBuSN+WOjoVmpDZ2EKX2Q
 kX0OvTGSdufD10ktrANPqsd55V9bxzxpWRvAl04J7t6arthB9HYiNgLbuIUG1nq4pRoq
 4xMYy1B3OBtQJtlkFjyBiLUK6pkvU+y+jYgfusXb9uxwQ/4urjGNA2w3UTICgQrYCiYC
 pQ/Q==
X-Gm-Message-State: AOJu0YynPe60llvRj/Pz+iYA0fAP1h+I5KAGGyHyhFkeSK3wai/7x2zN
 Jftq7H4Q786pC/7jbt+qqkey19OCQU04Dnp6qQ+pI3xN20on0Xt4/WE7MSBjdhFDmoqQAGwWJIe
 Ov6i7voh7gRmj6UY8nmzZj2F/CrrxLw==
X-Google-Smtp-Source: AGHT+IHor0e8ZP0cQoiGmU++KbS7LY4tWn/V+YFYw42JqOw+XHM2UPTsOeSSb9RhTUiypTdbJd5Wd8MZPR/uURoTudg=
X-Received: by 2002:a17:90b:4acc:b0:2a2:c16:d673 with SMTP id
 mh12-20020a17090b4acc00b002a20c16d673mr6031599pjb.36.1714051697350; Thu, 25
 Apr 2024 06:28:17 -0700 (PDT)
MIME-Version: 1.0
References: <20240425070226.1315866-1-tim.huang@amd.com>
In-Reply-To: <20240425070226.1315866-1-tim.huang@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 25 Apr 2024 09:28:06 -0400
Message-ID: <CADnq5_MY_dT=OMffMO8wXuiTUdnMYA1r2W7R-+HDXNeODMoibA@mail.gmail.com>
Subject: Re: [PATCH v2] drm/amdgpu: fix overflowed array index read warning
To: Tim Huang <tim.huang@amd.com>
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

On Thu, Apr 25, 2024 at 3:22=E2=80=AFAM Tim Huang <tim.huang@amd.com> wrote=
:
>
> From: Tim Huang <Tim.Huang@amd.com>
>
> Clear warning that cast operation might have overflowed.
>
> v2: keep reverse xmas tree order to declare "int r;" (Christian)
>
> Signed-off-by: Tim Huang <Tim.Huang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_ring.c
> index 06f0a6534a94..8cf60acb2970 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
> @@ -473,8 +473,8 @@ static ssize_t amdgpu_debugfs_ring_read(struct file *=
f, char __user *buf,
>                                         size_t size, loff_t *pos)
>  {
>         struct amdgpu_ring *ring =3D file_inode(f)->i_private;
> -       int r, i;
>         uint32_t value, result, early[3];
> +       int r;
>
>         if (*pos & 3 || size & 3)
>                 return -EINVAL;
> @@ -485,7 +485,7 @@ static ssize_t amdgpu_debugfs_ring_read(struct file *=
f, char __user *buf,
>                 early[0] =3D amdgpu_ring_get_rptr(ring) & ring->buf_mask;
>                 early[1] =3D amdgpu_ring_get_wptr(ring) & ring->buf_mask;
>                 early[2] =3D ring->wptr & ring->buf_mask;
> -               for (i =3D *pos / 4; i < 3 && size; i++) {
> +               for (loff_t i =3D *pos / 4; i < 3 && size; i++) {

Some older compilers complain about declarations mixed with code like
this.  Not sure how big a deal that would be.

Alex

>                         r =3D put_user(early[i], (uint32_t *)buf);
>                         if (r)
>                                 return r;
> --
> 2.39.2
>
