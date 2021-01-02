Return-Path: <SRS0=sK2M=GF=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D125C433E0
	for <amd-gfx@archiver.kernel.org>; Sat,  2 Jan 2021 14:03:25 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 462CB224D4
	for <amd-gfx@archiver.kernel.org>; Sat,  2 Jan 2021 14:03:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 462CB224D4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=basnieuwenhuizen.nl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C99FD8979D;
	Sat,  2 Jan 2021 14:03:24 +0000 (UTC)
Received: from mail-il1-x132.google.com (mail-il1-x132.google.com
 [IPv6:2607:f8b0:4864:20::132])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 26D438979D
 for <amd-gfx@lists.freedesktop.org>; Sat,  2 Jan 2021 14:03:23 +0000 (UTC)
Received: by mail-il1-x132.google.com with SMTP id k8so21222797ilr.4
 for <amd-gfx@lists.freedesktop.org>; Sat, 02 Jan 2021 06:03:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=basnieuwenhuizen.nl; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=WqcjFn9/6asK/GUVbCvS0Q/1wZ+bX+FVv6IfRwU27X8=;
 b=iuGAOqmGtQqFYbRPDlUGYDS95rmd3tuG5ZNsSPS/EpucxS1gJnQYB0BadsVD+2KLxK
 rTzet2wVy6X5PdIcivYScUqFEe2GK4R7taVSS/ON0sAkHOwYDIxd9V8UBygkwRnHLM60
 3M5gjy3NKCAm50LgF8yvyTWGWUzXmgy0AZP4VtTwyh3J3NBzz01NmvHlZSaFfw/GF/sd
 Ww2bdxRyQiwYYIabdJVeOF77QCOD6gx4MQqLzNatwdXLPydEl3ucAjQRkOSuKXybAYb4
 blg1ChdvlNcPnZsEMutD4Q3tqcN9rmXogxTrn8HnG1DdndXvLBBwfAMqqGZyToD5b8ZT
 7FrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=WqcjFn9/6asK/GUVbCvS0Q/1wZ+bX+FVv6IfRwU27X8=;
 b=IxkmPAX1+T8gLXFZr8rLPy4Q/6CKDiimSXVNCyuKSwuC5jUTMAo/OVQmHlpAa7Vgev
 luofazv2U+48F0hezXEsIytDiqgs93tehNLucAX875kIeZKla7nQT6W8wHCSR3IxMSxO
 KeexOJzsl+S8n1A4SPLqVVRUo4nRdNtCBXADdTHGB5gz2IO+XWQ7HBrBs4BuRkoWWu2X
 SNcEn1U/8fxgYzsJi6mquKMnWtCIm7iP+IuozFaB+kwUInVKD6MA3HOanpStaUMZeQK0
 9DH/1NvOAZtv0jVoKpTdH15kTgg4zbTPNe3JfUdRee6Frm/ADPdteU2LINyxDp9TcYZl
 9jYg==
X-Gm-Message-State: AOAM532WUCnogXDJMNL/W6EtJ9rHqTCTfL/fwODrSkXmXhjFr9KGx9m1
 qGlNXjBF7lAs2Gdrq6IvYDSAQpSFrszQZo0uBXFuMQ==
X-Google-Smtp-Source: ABdhPJxertt5i6Ofz9QvYjD4RSkaUE0UZRvReulPRDWAN/kAT+E1C3SPkj3zUXH0mSeiD6AAPq1b2FWH0MM1oBvvuRo=
X-Received: by 2002:a92:ba42:: with SMTP id o63mr64539931ili.93.1609596202423; 
 Sat, 02 Jan 2021 06:03:22 -0800 (PST)
MIME-Version: 1.0
References: <20201222031812.67228-1-zhan.liu@amd.com>
In-Reply-To: <20201222031812.67228-1-zhan.liu@amd.com>
From: Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>
Date: Sat, 2 Jan 2021 15:03:33 +0100
Message-ID: <CAP+8YyGUnApixsN994v8v6FX8oS8CX6o2figZhp21HbFxhx6wg@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: Do not change amdgpu framebuffer format
 during page flip
To: Zhan Liu <zhan.liu@amd.com>
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
Cc: Stylon.Wang@amd.com, Chao-kai.Wang@amd.com,
 amd-gfx mailing list <amd-gfx@lists.freedesktop.org>, Nikola.Cornij@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

https://lists.freedesktop.org/archives/dri-devel/2021-January/292761.html
is my alternative patch.

On Tue, Dec 22, 2020 at 4:18 AM Zhan Liu <zhan.liu@amd.com> wrote:
>
> [Why]
> Driver cannot change amdgpu framebuffer (afb) format while doing
> page flip. Force system doing so will cause ioctl error, and result in
> breaking several functionalities including FreeSync.
>
> If afb format is forced to change during page flip, following message
> will appear in dmesg.log:
>
> "[drm:drm_mode_page_flip_ioctl [drm]]
> Page flip is not allowed to change frame buffer format."
>
> [How]
> Do not change afb format while doing page flip. It is okay to check
> whether afb format is valid here, however, forcing afb format change
> shouldn't happen here.
>
> Signed-off-by: Zhan Liu <zhan.liu@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_display.c | 2 --
>  1 file changed, 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
> index a638709e9c92..0efebd592b65 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
> @@ -831,8 +831,6 @@ static int convert_tiling_flags_to_modifier(struct amdgpu_framebuffer *afb)
>                                                                 modifier);
>                         if (!format_info)
>                                 return -EINVAL;
> -
> -                       afb->base.format = format_info;
>                 }
>         }
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
