Return-Path: <SRS0=2fSF=IP=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B85EAC433DB
	for <amd-gfx@archiver.kernel.org>; Wed, 17 Mar 2021 13:44:58 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3D43864F50
	for <amd-gfx@archiver.kernel.org>; Wed, 17 Mar 2021 13:44:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D43864F50
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AF19C89C0A;
	Wed, 17 Mar 2021 13:44:57 +0000 (UTC)
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com
 [IPv6:2607:f8b0:4864:20::32f])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DD14789C0A
 for <amd-gfx@lists.freedesktop.org>; Wed, 17 Mar 2021 13:44:56 +0000 (UTC)
Received: by mail-ot1-x32f.google.com with SMTP id
 k14-20020a9d7dce0000b02901b866632f29so1814438otn.1
 for <amd-gfx@lists.freedesktop.org>; Wed, 17 Mar 2021 06:44:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=mlpwXhDcuFmOCnvFD1abRbgCIlPyWNtv6D7uqMDg8/4=;
 b=R5zLI3CobU3DsZjCnQEr+nBP1niHfk2+AJI3TdlRwl7KjWDgfBQoLXgioy5y1Q9OF8
 MKxJ10e2Q7Hqh6Y1LzSKc1J8ob7r4t6D96MNX642J3V54hUxVKYPBU7wwhMvQIfW6+iI
 9sRM6oYJq7OBFkHWQ5CDiZSYTjPlt2JSuR1Q1QK9EReQZRyno8xe894yCRP84hyUj52r
 B0p+y+IW6s1B6gAXTpLDvMqI2BYmeJQOkavvfgf8f7E6NVkt/HTDdrHVNM7eDE5TFkAY
 gHleK4h3k0mywI1NJBkTTePZ/hUUoJff1TWYms1QqC0o7WNWBC10Pe+2LHV1wEb09jvX
 Up+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=mlpwXhDcuFmOCnvFD1abRbgCIlPyWNtv6D7uqMDg8/4=;
 b=hSOQyF0Jc5xKZEBr4q27VIedYkA/qTJnmY+eTWZT1110anIJjV1+KuLJpP67T6A0xt
 ufUITBE4KVuG/MF2kf2Fb1+lhArQPbgfjvMrK+HRZ4LoaFVrxztx8H1s6f6CMx2N346a
 gQ7F28FH6hdJf1aiJwByISUZFqNPK+7oy0OMYT9SbutUZZq4qmEm/cLx50jIOEcTif04
 Xw5HdeB38MEnyBmzgixaU9/bogh9IjwJIvlIwx2nJlvxg1FzYIxKkXexP+8/9S5wrfT8
 FT2aS3oavBEdJwM328kL+QtgtCYW0XD9vWu9lQPgpQpMuzN37DE7BOn6PTaisE2vdxS4
 4Jwg==
X-Gm-Message-State: AOAM531SuP23+YrBEHNnrqWcvZlbI7IT1s/ms6s3LciVgB7L5iRMgm7A
 qX3F/l6XWUPxeoamFbh26XNEi5Xd7AeI/TUJ5E4=
X-Google-Smtp-Source: ABdhPJxfefvsvHDpEr89J/tC77B9ZnNmmhle5x72dTeTNnSWSU6brrpe1F5AGoPIGh92isw+Dh/gqdJh7YndegqZaJ8=
X-Received: by 2002:a9d:d89:: with SMTP id 9mr1233135ots.23.1615988696142;
 Wed, 17 Mar 2021 06:44:56 -0700 (PDT)
MIME-Version: 1.0
References: <20210317095539.12309-1-xinhui.pan@amd.com>
In-Reply-To: <20210317095539.12309-1-xinhui.pan@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 17 Mar 2021 09:44:45 -0400
Message-ID: <CADnq5_M5d5+WZn-ajf52_6T5xDyds-GtF6mieJohMYthL7XuwA@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: Fix memory leak
To: xinhui pan <xinhui.pan@amd.com>
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
Cc: "Deucher, Alexander" <alexander.deucher@amd.com>, "Kazlauskas,
 Nicholas" <nicholas.kazlauskas@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Wed, Mar 17, 2021 at 5:56 AM xinhui pan <xinhui.pan@amd.com> wrote:
>
> drm_gem_object_put() should be paired with drm_gem_object_lookup().
>
> All gem objs are saved in fb->base.obj[]. Need put the old first before
> assign a new obj.
>
> Trigger VRAM leak by running command below
> $ service gdm restart
>
> Signed-off-by: xinhui pan <xinhui.pan@amd.com>

Acked-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_display.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
> index bebed0f307a1..46dafea8da8b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
> @@ -955,8 +955,9 @@ int amdgpu_display_framebuffer_init(struct drm_device *dev,
>         }
>
>         for (i = 1; i < rfb->base.format->num_planes; ++i) {
> +               drm_gem_object_get(rfb->base.obj[0]);
> +               drm_gem_object_put(rfb->base.obj[i]);
>                 rfb->base.obj[i] = rfb->base.obj[0];
> -               drm_gem_object_get(rfb->base.obj[i]);
>         }
>
>         return 0;
> @@ -1002,6 +1003,7 @@ amdgpu_display_user_framebuffer_create(struct drm_device *dev,
>                 return ERR_PTR(ret);
>         }
>
> +       drm_gem_object_put(obj);
>         return &amdgpu_fb->base;
>  }
>
> --
> 2.25.1
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
