Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5A1AC77B73
	for <amd-gfx@archiver.kernel.org>; Wed, 19 Apr 2023 13:33:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 49A7310E17B;
	Wed, 19 Apr 2023 13:33:38 +0000 (UTC)
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com
 [IPv6:2607:f8b0:4864:20::234])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A459C10E17B
 for <amd-gfx@lists.freedesktop.org>; Wed, 19 Apr 2023 13:33:36 +0000 (UTC)
Received: by mail-oi1-x234.google.com with SMTP id
 5614622812f47-38dfa5ab847so1199945b6e.1
 for <amd-gfx@lists.freedesktop.org>; Wed, 19 Apr 2023 06:33:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1681911215; x=1684503215;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iw34Da3muYNE3dn9HcLsTe8ysCVbhNBKCi5MreWMSiQ=;
 b=Qe0RzbF9d/5EGsGsrHKxdASS5JosPgYUokuUZCYC1vaCyxfjWARm6sRAqg0BEXWZeL
 E4buO684quLnS5PVyRYp0hmUREYF1nU5k/DT0dS6fyuMzZ1ZQq7cQWD9cNGLJIf+iLaz
 VjZLwxTIiTt8hbt5VHuQedJet2aZ9h8kTS8ltr7ogI3PDSAJs/Hov7w+eD/05bInyHGc
 8p1XEcI4zK7wUaapmuyqV2+GRVIZNElZuqwdec5kb11+Z6UUcRoR+nBzuNuH5mewPQSa
 Zv5uLB/YxfcCfTCWfTegimN7rJhRgFU1F7KuugMrrAXsZvLPoGo2l/aOII2OulFndIw8
 bkxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1681911215; x=1684503215;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=iw34Da3muYNE3dn9HcLsTe8ysCVbhNBKCi5MreWMSiQ=;
 b=jemPo7+qX5NIgMiaVg2kQ6j7YI4oKaui/Wv+Tu00UA4yeYzZ+Jtld5NaCeGqtxhG/V
 TGaUBgzsRl3vj6GP0lKKrU+DvDgJNTc4BNTKme5BWXU5GVUlpD7fwBokRsoxLhfjEb+s
 VJ/3ojmbrLe0aZEUY5t4bsX7B9Q9RgKg0cL2fL//y2aebM53ugPrt9Y8HD3hSrNUc8bB
 1M4l0fPEJheJJhokuMan7Yp3wNg39iSchoaX6h05OgBQVJT/XkRBV0XQ0J/vndSf+Yk5
 qRHDDC+aGbtIs1+fdk8VKBCIU0gfVB5bZSTg1PPUzsnEgwubWv80jifqtYzMN102J22B
 DqBA==
X-Gm-Message-State: AAQBX9dkj5CqS0Tk02RMq4pbFGJGtAlKQL94KrN9IKs9aN5X3XQZRFTc
 vjF/h+mCcvUksLjYgE3WzSxj9PxXsjRmhj62g/Y=
X-Google-Smtp-Source: AKy350bSTNFi93YrZlJ/PBaIhnOCds+GZes9kB3jKiI/QokwH/Nwbl6npRBKGCHzBh6C8LgeXX/ZvzII1fP8r39educ=
X-Received: by 2002:a05:6808:5d8:b0:38d:e3dc:fd05 with SMTP id
 d24-20020a05680805d800b0038de3dcfd05mr2672597oij.48.1681911215363; Wed, 19
 Apr 2023 06:33:35 -0700 (PDT)
MIME-Version: 1.0
References: <20230419131518.234133-1-srinivasan.shanmugam@amd.com>
In-Reply-To: <20230419131518.234133-1-srinivasan.shanmugam@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 19 Apr 2023 09:33:24 -0400
Message-ID: <CADnq5_PSQ8BqtRhk96h=zhJ1UJ6+KV9xipmDNTsqag3TbcarKA@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/amdgpu: Fix style issues in amdgpu_discovery.c
To: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 amd-gfx@lists.freedesktop.org, Mario Limonciello <mario.limonciello@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Wed, Apr 19, 2023 at 9:15=E2=80=AFAM Srinivasan Shanmugam
<srinivasan.shanmugam@amd.com> wrote:
>
> Fix following checkpatch errors in amdgpu_discovery.c
>
> ERROR: space required after that ',' (ctx:VxV)
> ERROR: space required before the open parenthesis '('
> ERROR: code indent should use tabs where possible
>
> Cc: Christian K=C3=B6nig <christian.koenig@amd.com>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: Mario Limonciello <mario.limonciello@amd.com>
> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/=
drm/amd/amdgpu/amdgpu_discovery.c
> index 0ecce0b92b82..0ba013275dc1 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> @@ -311,7 +311,7 @@ static int amdgpu_discovery_init(struct amdgpu_device=
 *adev)
>         if (!amdgpu_discovery_verify_binary_signature(adev->mman.discover=
y_bin) || amdgpu_discovery =3D=3D 2) {
>                 /* ignore the discovery binary from vram if discovery=3D2=
 in kernel module parameter */
>                 if (amdgpu_discovery =3D=3D 2)
> -                       dev_info(adev->dev,"force read ip discovery binar=
y from file");
> +                       dev_info(adev->dev, "force read ip discovery bina=
ry from file");
>                 else
>                         dev_warn(adev->dev, "get invalid ip discovery bin=
ary signature from vram\n");
>
> @@ -323,7 +323,7 @@ static int amdgpu_discovery_init(struct amdgpu_device=
 *adev)
>                         goto out;
>                 }
>                 /* check the ip discovery binary signature */
> -               if(!amdgpu_discovery_verify_binary_signature(adev->mman.d=
iscovery_bin)) {
> +               if (!amdgpu_discovery_verify_binary_signature(adev->mman.=
discovery_bin)) {
>                         dev_warn(adev->dev, "get invalid ip discovery bin=
ary signature from file\n");
>                         r =3D -EINVAL;
>                         goto out;
> @@ -529,8 +529,8 @@ static void amdgpu_discovery_read_harvest_bit_per_ip(=
struct amdgpu_device *adev,
>                                         break;
>                                 default:
>                                         break;
> -                                }
> -                        }
> +                               }
> +                       }
>  next_ip:
>                         ip_offset +=3D struct_size(ip, base_address, ip->=
num_base_address);
>                 }
> --
> 2.25.1
>
