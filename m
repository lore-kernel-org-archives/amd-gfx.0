Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7383FC433F5
	for <amd-gfx@archiver.kernel.org>; Fri, 30 Sep 2022 21:18:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C7BEF10EDB8;
	Fri, 30 Sep 2022 21:18:20 +0000 (UTC)
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com
 [IPv6:2607:f8b0:4864:20::232])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C4F7510EDB8
 for <amd-gfx@lists.freedesktop.org>; Fri, 30 Sep 2022 21:18:16 +0000 (UTC)
Received: by mail-oi1-x232.google.com with SMTP id m130so5961902oif.6
 for <amd-gfx@lists.freedesktop.org>; Fri, 30 Sep 2022 14:18:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date;
 bh=NANxhkI+OnMcwZiPUAW38E7y7bQV8crozbHOcBBbi7I=;
 b=MAAlKtpd8nbcnBQFCPoDkvYN2BnXayIJRIu/pBH1oTut7KUxaXiDYmdP/T5zIb5s7d
 ODKGvCvBqKGinzWcUzDDg9N40GGbHl8xdGL9Fys1nG/dMP2TXUbkSW+EshAp/nTryOzE
 X6BHwW6pJnrACiOdHoTPXBJeVK9yor7mQkVZX5v+VLIWs85rt1Wx2QfJyfWJqNsUhwb3
 F9yyeFpGmBYz+L2K6CL9LxHVQK8Css6eotiHyvyjfslAnov8aOa+xHEE1SV3d677aaO8
 PJhmUPWrUVG3lfjrFdqeAqj757rZCrzEezZNfc0IQCjSp1zmM8vlHgE1tnoxM47kxC1M
 CHSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date;
 bh=NANxhkI+OnMcwZiPUAW38E7y7bQV8crozbHOcBBbi7I=;
 b=OnZsi6IUo+IWif/2yIsWIa7q7zcvPEKQLdmT9+5pHdwfdn7qdO34/RVjVpR2KPOMq4
 gLMO+xuNcNvADQMhxjbdzPcaE5vqyL8y3ZyCDYdCaMW6GIRr5V8DxJsP+eBP1CyQJW80
 suiaENr+d+rcewAGYOGH3a8QzaJu/ENdEx7OkE6n79q//3BfnRKV7D3fXQXCGZeUaqAI
 +A75PCMPmGlf3naXikbWNzf+yaErP+A1vGhkSuhR9Cy2NLK+M8+mObwcT0fXOjVKMEse
 87V4og3N5dCObjYMvu9cFVbub3bc8VTi9jzF5Dc3MubIT2g0xcEMG7nm68JlTO7i6QZ4
 4eTw==
X-Gm-Message-State: ACrzQf0i3P8C0V+2AWt8+saNkiL6uuSB4laZCxC08UZTKwMEcx251+rT
 PCg/0EtWoaztSkeqELtjG1m9spQAeyX3c3hZckh8b3F/
X-Google-Smtp-Source: AMsMyM5GUPCB5danjM8O2Z1O5je7d3XOF0pVYILjshgq4pl4INNXtg7F/TUK0KLy2TzqSCH3FVeWwN7fpWTu9xiVW14=
X-Received: by 2002:a05:6808:2194:b0:350:cb3d:ecd2 with SMTP id
 be20-20020a056808219400b00350cb3decd2mr82483oib.46.1664572696095; Fri, 30 Sep
 2022 14:18:16 -0700 (PDT)
MIME-Version: 1.0
References: <20220930202650.9550-1-sonny.jiang@amd.com>
In-Reply-To: <20220930202650.9550-1-sonny.jiang@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 30 Sep 2022 17:18:04 -0400
Message-ID: <CADnq5_NB=7nJDAc0by+N2XWQZ+Bs5VydsiugVZXGvY_aBtNj5Q@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: Enable VCN PG on GC11_0_1
To: Sonny Jiang <sonny.jiang@amd.com>
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
Cc: amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Fri, Sep 30, 2022 at 4:27 PM Sonny Jiang <sonny.jiang@amd.com> wrote:
>
> Enable VCN PG on GC11_0_1
>
> Signed-off-by: Sonny Jiang <sonny.jiang@amd.com>

Acked-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/soc21.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/soc21.c b/drivers/gpu/drm/amd/amdgpu/soc21.c
> index 16b757664a35..795706b3b092 100644
> --- a/drivers/gpu/drm/amd/amdgpu/soc21.c
> +++ b/drivers/gpu/drm/amd/amdgpu/soc21.c
> @@ -629,6 +629,7 @@ static int soc21_common_early_init(void *handle)
>                         AMD_CG_SUPPORT_JPEG_MGCG;
>                 adev->pg_flags =
>                         AMD_PG_SUPPORT_GFX_PG |
> +                       AMD_PG_SUPPORT_VCN |
>                         AMD_PG_SUPPORT_VCN_DPG |
>                         AMD_PG_SUPPORT_JPEG;
>                 adev->external_rev_id = adev->rev_id + 0x1;
> --
> 2.36.1
>
