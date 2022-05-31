Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB5F2C433EF
	for <amd-gfx@archiver.kernel.org>; Tue, 31 May 2022 21:22:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4E1AD10E5A6;
	Tue, 31 May 2022 21:22:38 +0000 (UTC)
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com
 [IPv6:2607:f8b0:4864:20::22b])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8BBC210E585;
 Tue, 31 May 2022 21:22:36 +0000 (UTC)
Received: by mail-oi1-x22b.google.com with SMTP id l84so81616oif.10;
 Tue, 31 May 2022 14:22:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=XNsVAgAOaHBeTW3uh6pa2YZZKM4GP68jx8jpyunwFns=;
 b=XjasywrCMQ2pl8wC1KYGo2pSOLjGyfKW/h8uK/C8gGc2ZwM07WIcx2WjPq4glWpVMk
 uQj3ixsCVywkyoraZKoNb3dym5R74OpRPyeQfm9N0XGL+knCvyK7N52ET6d5xqAYvZDY
 D+qHu6/O5dSbDzqLdvAOBFMdqUuusYPWkfj1Xj0Nbrs1VlVPoK+geDPWSqqxB+8GNIFH
 sE6HYEEOV9X2Xp8QMOE9fTaHAH2UWSMPhyppkkboq0/6Ae9H1y64CIiM4j9AbQXZCasu
 6jua8F6hw8uE6XNjOqjclD/eFH13AwZ31YdPgVes3M8g9t4jeVFTWj9Or08/qqP6QjpG
 sVDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=XNsVAgAOaHBeTW3uh6pa2YZZKM4GP68jx8jpyunwFns=;
 b=ocyVEC3PaaDUoe9DeQroUBpK494uwQMj9oFfPKzTX3Wo2gX2L0z/4qsUsu4nxj19Uu
 0EIeqdsVS8M0pHeeA/k8HXhd9gyQA3iZrA63+Geu5QHTF3gDq2y/7EUzwAb58iZaFp5b
 z0iVU2WyTzRLQyDUzDoIOpvC1Xe1cJa9fRqG4NHoe7rORTTHozgmT5BuJeF8IWsYEKSd
 DPeSfSN0bS98uezf90y/Q5xNnGLcWFoe1rceNNLtppg7W9Oz+rmIJa3HBaYklfY6omue
 jGUfn++ekXhPGR+pNDkH1cpwnewapDoAknEflNqDN8tqzGUJTs6jMr8vVOtrqQaoRiNZ
 ujMw==
X-Gm-Message-State: AOAM533OkWAbre+x1mjgtCpeygyHxc2BCeJOmHy2cM9S1qgbbqUDMp/t
 To4Lv54V2/hDchK2uhTeadKaM9y5ORX54auta7A=
X-Google-Smtp-Source: ABdhPJzh4fJZOKIURodl4DucHPyqo5K3DTZ+seM4qZE6q57I5p519DBcqrSHJnow/0/s07Cb7Hy539r0j9t7QEWPBN0=
X-Received: by 2002:a05:6808:114f:b0:32b:1be0:2316 with SMTP id
 u15-20020a056808114f00b0032b1be02316mr12747067oiu.200.1654032155821; Tue, 31
 May 2022 14:22:35 -0700 (PDT)
MIME-Version: 1.0
References: <20220529062631.304316-1-sunliming@kylinos.cn>
In-Reply-To: <20220529062631.304316-1-sunliming@kylinos.cn>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 31 May 2022 17:22:24 -0400
Message-ID: <CADnq5_N0SRW94Vvis16kyCmpZxLemOhPS5O-Yr2YQe=5BL6x8w@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: make gfx_v11_0_rlc_stop static
To: sunliming <sunliming@kylinos.cn>
Content-Type: text/plain; charset="UTF-8"
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
Cc: kernel test robot <lkp@intel.com>, Xiaojian Du <Xiaojian.Du@amd.com>,
 Dave Airlie <airlied@linux.ie>, kelulanainsley@gmail.com,
 xinhui pan <Xinhui.Pan@amd.com>, LKML <linux-kernel@vger.kernel.org>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>,
 Mike Lothian <mike@fireburn.co.uk>,
 Maling list - DRI developers <dri-devel@lists.freedesktop.org>,
 Daniel Vetter <daniel@ffwll.ch>, hristian.koenig@amd.com, "Deucher,
 Alexander" <alexander.deucher@amd.com>, "Quan, Evan" <evan.quan@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Applied.  Thanks!

Alex

On Sun, May 29, 2022 at 7:50 AM sunliming <sunliming@kylinos.cn> wrote:
>
> This symbol is not used outside of gfx_v11_0.c, so marks it static.
>
> Fixes the following w1 warning:
>
> drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c:1945:6: warning: no previous
> prototype for function 'gfx_v11_0_rlc_stop' [-Wmissing-prototypes].
>
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: sunliming <sunliming@kylinos.cn>
> ---
>  drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> index 8c0a3fc7aaa6..cb581cfc7464 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> @@ -1983,7 +1983,7 @@ static int gfx_v11_0_init_csb(struct amdgpu_device *adev)
>         return 0;
>  }
>
> -void gfx_v11_0_rlc_stop(struct amdgpu_device *adev)
> +static void gfx_v11_0_rlc_stop(struct amdgpu_device *adev)
>  {
>         u32 tmp = RREG32_SOC15(GC, 0, regRLC_CNTL);
>
> --
> 2.25.1
>
