Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0C5FC433F5
	for <amd-gfx@archiver.kernel.org>; Tue,  1 Mar 2022 15:12:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 01EDC10E57C;
	Tue,  1 Mar 2022 15:12:00 +0000 (UTC)
Received: from mail-oo1-xc30.google.com (mail-oo1-xc30.google.com
 [IPv6:2607:f8b0:4864:20::c30])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A8BBA10E57C
 for <amd-gfx@lists.freedesktop.org>; Tue,  1 Mar 2022 15:11:58 +0000 (UTC)
Received: by mail-oo1-xc30.google.com with SMTP id
 n5-20020a4a9545000000b0031d45a442feso15153787ooi.3
 for <amd-gfx@lists.freedesktop.org>; Tue, 01 Mar 2022 07:11:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=kSZo3NSYN2E5O9WOxtuCJib3VKMWGf1Nk8btahjzd7c=;
 b=ajXs3sdLbmr8a+g7GfnyLHJnZxj/EDkJNW+OuvEy8x9CHS4OgXYGJTp94ZbjN1yyTK
 BGz3H1mQjL9Q6BRHn3Dzk2ERfNwD6f5OfRTT9Q9ptBkNi1DPSx3V4hI3ZFPUcZOl0uv/
 i4B46oAao0FbbOWWYAfBwel4k2RBqw7T+lqkzkPOSTPK9hw32Xo3TKNRDktZbivRqvQ1
 0ATfJZ8SqH0DM5pZr52oA8CyWhb1f1QFIHf3/M6E4du8yYwXD9qEdIeCMscdp8u8S7aQ
 /HkxQa3TR6c9ZVYXZs9B3SbTyzAKRQwDwCfun58h6GTJtsJSTto8vEbtNkEY4R/Z0Hfe
 s2IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=kSZo3NSYN2E5O9WOxtuCJib3VKMWGf1Nk8btahjzd7c=;
 b=ZRIJtJi/aZjFmGHVwnMUlWvzsPKgveRSxaK29lIaYSX3lZ/qKV/PlyzyweJsn1Lr0x
 Z2kvTA8ocs4I6UUaAJv3Ho0m5YERh0YW5WyjMLWY30kEsJUEnN8lLHoRz2DGzOIW1gtv
 2YOF5Bk5jRFVpaHJmObo27l+mIxp/JCwIeq5JptDj4fkicfBzN31BF0aYLIHS9zQXuEv
 AMttIizk2DmpHwpDmotpzZ7itIuUvbOBrSm8ntXSywmCNAHKv7I2kFCThbKRJPBOCRir
 m8YEsPiFuVUSdDjPT1x4lE/9mEv6hFCgTZBvBAjW+MZZCinRFrEgchAh0P2mJ14WkjYt
 7QLg==
X-Gm-Message-State: AOAM5316/8ZYSuUQ5K7NjnMcmFhJCZV3Y/3oJiY2Z6fHIfN7ZdU75M7Y
 /mdbzA89hH2N9TOcTpVEQho06OuUm9mCIqAxY6w=
X-Google-Smtp-Source: ABdhPJxUGhAP4dOka53xzlYVxxvxbGJn0dyn/rfdPa4owAGaWzhwVTiVAGWnUYNJNxFL4jkhigG4dNz6dH7iAFdRvAY=
X-Received: by 2002:a05:6870:1b85:b0:d6:feda:913f with SMTP id
 hm5-20020a0568701b8500b000d6feda913fmr4218062oab.123.1646147517928; Tue, 01
 Mar 2022 07:11:57 -0800 (PST)
MIME-Version: 1.0
References: <20220301150121.3785743-1-yifan1.zhang@amd.com>
In-Reply-To: <20220301150121.3785743-1-yifan1.zhang@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 1 Mar 2022 10:11:47 -0500
Message-ID: <CADnq5_MEzjYEnB6BtacemOSNj7WG5EQ18vQD8XUhVpY80yBH=w@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] drm/amdgpu: move amdgpu_gmc_noretry_set after
 ip_versions populated
To: Yifan Zhang <yifan1.zhang@amd.com>
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 Huang Rui <Ray.Huang@amd.com>, Christian Koenig <christian.koenig@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Series is:
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

On Tue, Mar 1, 2022 at 10:02 AM Yifan Zhang <yifan1.zhang@amd.com> wrote:
>
> otherwise adev->ip_versions is still empty when amdgpu_gmc_noretry_set
> is called.
>
> Signed-off-by: Yifan Zhang <yifan1.zhang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index 6113ddc765a7..61a6a7920c76 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -1554,7 +1554,6 @@ static int amdgpu_device_check_arguments(struct amdgpu_device *adev)
>
>         amdgpu_gmc_tmz_set(adev);
>
> -       amdgpu_gmc_noretry_set(adev);
>
>         return 0;
>  }
> @@ -3641,6 +3640,7 @@ int amdgpu_device_init(struct amdgpu_device *adev,
>         if (r)
>                 return r;
>
> +       amdgpu_gmc_noretry_set(adev);
>         /* Need to get xgmi info early to decide the reset behavior*/
>         if (adev->gmc.xgmi.supported) {
>                 r = adev->gfxhub.funcs->get_xgmi_info(adev);
> --
> 2.25.1
>
