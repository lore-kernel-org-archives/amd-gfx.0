Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1C7FC54EE9
	for <amd-gfx@archiver.kernel.org>; Tue, 20 Sep 2022 12:57:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 023D210E6B3;
	Tue, 20 Sep 2022 12:57:20 +0000 (UTC)
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com
 [IPv6:2607:f8b0:4864:20::235])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9565010E6B3
 for <amd-gfx@lists.freedesktop.org>; Tue, 20 Sep 2022 12:57:13 +0000 (UTC)
Received: by mail-oi1-x235.google.com with SMTP id j188so3629146oih.0
 for <amd-gfx@lists.freedesktop.org>; Tue, 20 Sep 2022 05:57:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date;
 bh=YV/TVF6CrKxt2wEnCTo2EUpTH8jcgOSc2gkccW0yTcc=;
 b=EzpJjZhRrvSqaF4U072I6YYEugNGIPuGFajVp4gJbGC1CcaMyzbRlQydSxJ/lBnbYy
 wAOL7tHQLQzoEuJ9+pb4ZJunvs9i5aheiA5eB74RzjcIrGlqPUBWwDP3i0sU0kBD8L3f
 ecr9rCHuU8fgj29aAoufRmJycCEopxHD+VA207+5z5LBVw9ZfUZ+Fk8/ajacjea0Utsm
 DuN6HGei+MjMLrxC2m92fsL7A8jOg/ZkeAFpMOcEUmEsoHFMJiXueGMJEMiZ8i37TvMd
 GYL+/vPHu+OOg/kf3h7uNFszaaHCoFNdW03ZiXmHFCRy6+jZe/K0u939jgkDgMG/Av7k
 S1UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date;
 bh=YV/TVF6CrKxt2wEnCTo2EUpTH8jcgOSc2gkccW0yTcc=;
 b=rHzg5/1beLoW3yxNl4c0b28A5+6rmjfk6reK2OC/uvHANLFbtn450rNLtFoWefxesF
 1iyQWqgR/pPYxoaRezVpK1w60lcJaIQjsu9r9jvVk3aHty86eL8Qt08K/ggFKGgipew6
 leANu5LUhFrB97C9PfTu55eM/69193LBwRyROazPIwg7KkghvZwykuDxbJW4b2mto2iE
 HCN40mJLgwNV1Y8s6js/WD9XKdKBjIBn0xyehWuWhE6lIR5db1s+j+jEewux1DajPgBD
 XbT6pZu0F9pPqj3qVVVzplFgmVTxcSziwTnO1u5JwYVIgOsjjHpiYQW9Ir022MNhEzX5
 amDg==
X-Gm-Message-State: ACrzQf2/PHZ2zHC3M0YeZ+CJKFrWuvgWrc5FOVfntT1ywQWwZKiJiG0x
 pMX9jYf8+7v2dgjRejpXy/f55CwpxRlbVB66e8U=
X-Google-Smtp-Source: AMsMyM4E12HkCLh2Ijvxf0SanOgLPt53Tw04RQ5PMiHhsDVAsrsux+cthHGlxwKRE/wO1TcAhZDfK1QXKsaRDRD8xKc=
X-Received: by 2002:a05:6808:2390:b0:350:5c6b:5ef9 with SMTP id
 bp16-20020a056808239000b003505c6b5ef9mr1529603oib.96.1663678632798; Tue, 20
 Sep 2022 05:57:12 -0700 (PDT)
MIME-Version: 1.0
References: <20220920125543.3965-1-christian.koenig@amd.com>
In-Reply-To: <20220920125543.3965-1-christian.koenig@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 20 Sep 2022 08:57:01 -0400
Message-ID: <CADnq5_OY7jB+7evPY_FfVeaTzmUL8rPUD8VuLnJ5Sys6PmS=2g@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: bump minor for gang submit
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
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
Cc: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Tue, Sep 20, 2022 at 8:55 AM Christian K=C3=B6nig
<ckoenig.leichtzumerken@gmail.com> wrote:
>
> Since that has now landed bump the minor to let userspace know about it.
>
> Signed-off-by: Christian K=C3=B6nig <christian.koenig@amd.com>

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_drv.c
> index 81b22c1bd8df..16f6a313335e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> @@ -102,9 +102,10 @@
>   * - 3.46.0 - To enable hot plug amdgpu tests in libdrm
>   * - 3.47.0 - Add AMDGPU_GEM_CREATE_DISCARDABLE and AMDGPU_VM_NOALLOC fl=
ags
>   * - 3.48.0 - Add IP discovery version info to HW INFO
> + *   3.49.0 - Add gang submit into CS IOCTL
>   */
>  #define KMS_DRIVER_MAJOR       3
> -#define KMS_DRIVER_MINOR       48
> +#define KMS_DRIVER_MINOR       49
>  #define KMS_DRIVER_PATCHLEVEL  0
>
>  int amdgpu_vram_limit;
> --
> 2.25.1
>
