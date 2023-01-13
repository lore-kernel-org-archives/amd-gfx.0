Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FC39C54EBD
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Jan 2023 19:07:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6D3A310EA93;
	Fri, 13 Jan 2023 19:07:58 +0000 (UTC)
Received: from mail-oa1-x31.google.com (mail-oa1-x31.google.com
 [IPv6:2001:4860:4864:20::31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5E90610EA93
 for <amd-gfx@lists.freedesktop.org>; Fri, 13 Jan 2023 19:07:55 +0000 (UTC)
Received: by mail-oa1-x31.google.com with SMTP id
 586e51a60fabf-1322d768ba7so23264286fac.5
 for <amd-gfx@lists.freedesktop.org>; Fri, 13 Jan 2023 11:07:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=9/++tYBx4/CS9oFbvJdyuPyBg3xARMphBR/Ge5oHz/4=;
 b=EqT8rCrUXsb83eM5PH27bLad2RfhDACW+8ErSCKO8faaPXz+l0tBcqpkQ8J4eDQ5nn
 dZOYMgCldb6f1soJS5MVB5gm7Qzux+3xtZuqzlx+rSgQDw2Z7g3pRsHMEA7lRr+CfCEB
 JShMsWbab0bGtYIm6eFi0qNUxAPml8sO/F7GXKEqTEgQ3k0XgWBxHB4bDnKN0m7Rn1nK
 VQBzjgw2AzMs/Z0SYJtB9/nsm8nnV7vTKfOxJS0c/hb5YQEI87WXsHEunl7Jolao2bkY
 xg7yuKn/xRpu2Wuu5jnIP23S9+rSO/tJVgaky6Kn3Gh9X2RhLrY5ByfYD33aC2kM8mLv
 ZV1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=9/++tYBx4/CS9oFbvJdyuPyBg3xARMphBR/Ge5oHz/4=;
 b=Tvrqys/kUdyCNRFmN1jx9CFnqyMrzwFKi88hcB3iuTsF8xMXKoWnma0Ta7P5Wi8LRT
 e3Zf60Qa68/D57FadtnodFDoJSs2cZx4qcdgt7y3qIzQCAlo33d3EAkfRMFEFisapJtq
 qqEpZfjpJFniE3B6/dSVSyS06Zrc4JPptjOU5/LglsHeL0zkkjMkQqk93oqrKrGdW0uz
 nEiZlD65pp+oKRQzijp4WMFmRxDuHWll9SgA231yhzhi5bHiG/bXGsrwlixEBCV5cyul
 Pkzc2wNeWhPEAkewdffoKSnj/ApTl7QofQljUcGvYIoTtE3NipXdcjMLcnWGBYDvurZX
 /J4w==
X-Gm-Message-State: AFqh2kozzO+J3FqxL1dFkHcOtpb9b6zD1OzuAbzWNeoAIoCLSMpcUH7+
 qswZSaqb9B3BzpsyGGRcrGydFqdP3aj9eQaSyNI=
X-Google-Smtp-Source: AMrXdXtpQSgU1PV1XJK3cFJA5lOvfVijyOp0bzqMhFGbsrzplgtF8yyrzgqJYOzu3JV43x8bPHa3IO8vZQkZkeX+fJw=
X-Received: by 2002:a05:6870:c59c:b0:150:d9aa:4011 with SMTP id
 ba28-20020a056870c59c00b00150d9aa4011mr3293252oab.96.1673636874615; Fri, 13
 Jan 2023 11:07:54 -0800 (PST)
MIME-Version: 1.0
References: <Y8EtbpVGFJSDxM/m@kili>
In-Reply-To: <Y8EtbpVGFJSDxM/m@kili>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 13 Jan 2023 14:07:43 -0500
Message-ID: <CADnq5_PvyeKXopyUA4JQFRs7ftfZUuaj6juWvE4B0Cy6Yrt2JQ@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: Add a missing tab
To: Dan Carpenter <error27@gmail.com>
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
Cc: Jack Xiao <Jack.Xiao@amd.com>, "Pan, Xinhui" <Xinhui.Pan@amd.com>,
 Haohui Mai <ricetons@gmail.com>, Felix Kuehling <Felix.Kuehling@amd.com>,
 Lijo Lazar <lijo.lazar@amd.com>, kernel-janitors@vger.kernel.org,
 Lang Yu <Lang.Yu@amd.com>, amd-gfx@lists.freedesktop.org,
 Mario Limonciello <mario.limonciello@amd.com>, Daniel Vetter <daniel@ffwll.ch>,
 Alex Deucher <alexander.deucher@amd.com>, Evan Quan <evan.quan@amd.com>,
 David Airlie <airlied@gmail.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Applied.  Thanks!

Alex

On Fri, Jan 13, 2023 at 9:46 AM Dan Carpenter <error27@gmail.com> wrote:
>
> This tab was deleted accidentally and triggers a Smatch warning:
>
>     drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c:1006 gfx_v8_0_init_microcode()
>     warn: inconsistent indenting
>
> Add it back.
>
> Fixes: 0aaafb7359d2 ("drm/amd: Use `amdgpu_ucode_*` helpers for GFX8")
> Signed-off-by: Dan Carpenter <error27@gmail.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
> index 4fb577d047fd..b1f2684d854a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
> @@ -1003,7 +1003,7 @@ static int gfx_v8_0_init_microcode(struct amdgpu_device *adev)
>                 err = amdgpu_ucode_request(adev, &adev->gfx.me_fw, fw_name);
>                 if (err == -ENODEV) {
>                         snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_me.bin", chip_name);
> -               err = amdgpu_ucode_request(adev, &adev->gfx.me_fw, fw_name);
> +                       err = amdgpu_ucode_request(adev, &adev->gfx.me_fw, fw_name);
>                 }
>         } else {
>                 snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_me.bin", chip_name);
> --
> 2.35.1
