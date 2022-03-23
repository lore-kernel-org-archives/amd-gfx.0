Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD338C433EF
	for <amd-gfx@archiver.kernel.org>; Wed, 23 Mar 2022 13:21:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 52B1B10E6DA;
	Wed, 23 Mar 2022 13:21:19 +0000 (UTC)
Received: from mail-oa1-x35.google.com (mail-oa1-x35.google.com
 [IPv6:2001:4860:4864:20::35])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F24A710E6DA
 for <amd-gfx@lists.freedesktop.org>; Wed, 23 Mar 2022 13:21:17 +0000 (UTC)
Received: by mail-oa1-x35.google.com with SMTP id
 586e51a60fabf-d39f741b2bso1634468fac.6
 for <amd-gfx@lists.freedesktop.org>; Wed, 23 Mar 2022 06:21:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=Ssbs8mp3R2S/fxblQohgt6CwKnJPdDZaEU1mtSf2SNo=;
 b=X+gBSSztYpyeEYLbsFXrwkndn1Hp78/qbnvN2KjjBG+iR/peboJSYuasq5tdiIfEct
 rDzMU7rKl2gdRrYv/1Y6FtNAhFkz57vUo91jz7EHb4hgZQk5VSP4uCSR1M1ZAIkCVkfE
 yt14N5jUSnrQitBanvt0LTQC4obUVSTcHX7/3TSpwOKaiIsAFx/maf5GoQBrvvSCauPj
 sIEdl6cnl8CnIozNURqVu0OQVDcN/C1RFQeT9sjwtf1nMCFC0A5G/dyDY7E95QmzHBD3
 9DzBwTNy/Jf0Hf4qpT7vlbSDNaFy+9bF6OdPAbi/ucJ122tBmz4QiBh6HiXgAt3m2OgV
 k6hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Ssbs8mp3R2S/fxblQohgt6CwKnJPdDZaEU1mtSf2SNo=;
 b=2OrnkJJmHS+lc/L2PKfthnrV3pwNmUKrMqH11ebk96/bYyOnNsM4XhxUWPZcyl6r1l
 9Fd5YFFnSy3GrYpanIAv8pJB+cvxG+Wmflv9J5DGREnyuefeCGF+cJbdQor+mUvakXZP
 /apmop6tF25vC7Bu3Wd/2woC14E7/dZ3GfVFdniIZ7GpiOprfH/HEGSsWNqozlLyolDr
 ctVrunCFn9kdpxoW7lBMD3AddPSnyLNgW4ITV9Y958LziaSgQ5l2Gqe8ORjvYc4IuiQG
 lKUsp3yQJpqm1/n+zUSgAFyXnq1t+jhamqFDfYXkHr3dlfNNycMztHYFAHkebo1UtWS0
 +GeA==
X-Gm-Message-State: AOAM531QxkyKAAkYaBj434vMG+j+aGutNjyBEJR3tQZlRQt+ROAknSER
 j2FbuIxUzMDL09XLNmObtacIn4i2D3msmigpr/8=
X-Google-Smtp-Source: ABdhPJxGfphGcX/K72mqsHQ13fFU5v/rldZu1fYl7Vywtm95gMesAQKvBGjYZTwWHj8H5chuxDGXpAZoLAlvu1oKIAk=
X-Received: by 2002:a05:6871:8ab:b0:dd:b74b:409a with SMTP id
 r43-20020a05687108ab00b000ddb74b409amr3898065oaq.200.1648041676952; Wed, 23
 Mar 2022 06:21:16 -0700 (PDT)
MIME-Version: 1.0
References: <1648023118-29619-1-git-send-email-Prike.Liang@amd.com>
In-Reply-To: <1648023118-29619-1-git-send-email-Prike.Liang@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 23 Mar 2022 09:21:06 -0400
Message-ID: <CADnq5_MPoeFHW+894ysW916rby=imyMPemwsvABx_oXZoAtz2w@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: set noretry for gfx 10.3.7
To: Prike Liang <Prike.Liang@amd.com>
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
 Yifan Zhang <yifan1.zhang@amd.com>, Huang Rui <ray.huang@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Wed, Mar 23, 2022 at 4:15 AM Prike Liang <Prike.Liang@amd.com> wrote:
>
> Disable xnack on the isa gfx10.3.6.

typo: gfx10.3.6 -> gfx10.3.7

With that fixed:
Acked-by: Alex Deucher <alexander.deucher@amd.com>

>
> Signed-off-by: Prike Liang <Prike.Liang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> index e1635a3f2553..a66a0881a934 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> @@ -569,6 +569,7 @@ void amdgpu_gmc_noretry_set(struct amdgpu_device *adev)
>         case IP_VERSION(10, 3, 4):
>         case IP_VERSION(10, 3, 5):
>         case IP_VERSION(10, 3, 6):
> +       case IP_VERSION(10, 3, 7):
>                 /*
>                  * noretry = 0 will cause kfd page fault tests fail
>                  * for some ASICs, so set default to 1 for these ASICs.
> --
> 2.25.1
>
