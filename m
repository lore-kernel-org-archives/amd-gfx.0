Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6472C433EF
	for <amd-gfx@archiver.kernel.org>; Tue, 17 May 2022 21:27:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5D75E10E86E;
	Tue, 17 May 2022 21:27:58 +0000 (UTC)
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com
 [IPv6:2607:f8b0:4864:20::232])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6B25A10E86E
 for <amd-gfx@lists.freedesktop.org>; Tue, 17 May 2022 21:27:57 +0000 (UTC)
Received: by mail-oi1-x232.google.com with SMTP id e189so403048oia.8
 for <amd-gfx@lists.freedesktop.org>; Tue, 17 May 2022 14:27:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=llwRBL/j86bQQ1Sm22bCiNWHr9k5US7Nk+d6siqJWFw=;
 b=kLWa0KjhaXotQI/vwlD8D1uhHLtnjszOnnZ05d7SDkSYDxuF3vGg41VQb7XMZiPKFo
 I9zb6PSCjMgHNJS/qzomB8AG4YMeWgLChPIr8ik6VNPCFKMzZuBrPUXeSWWcNqCzcsxO
 E14F8B9b/+qKwsGqzBakJd5q2alWo/uDc78snImm4iDnkrUIXM3eLDgF5kPAqSbjKgd6
 A/zYY029W5SvTT4bTia88AOgua8Gffassg5QEKyCrhHzDGnepQ+e/4QcvFEAvKL/5IPk
 fJsStMv8Dm4yworcpmXGRrKy+V0AYYaD1oAb+mi35nQLaoqRmg3JPGW1zko0c10ipG/J
 9rRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=llwRBL/j86bQQ1Sm22bCiNWHr9k5US7Nk+d6siqJWFw=;
 b=sDBb8Y6eT9w5ux1dbKi1W5zBJCRuRb9ZwVWscbgDwQKMkLY2AhBCFRofotSbS3gb6w
 /TO/bNpv+FZWYsuFd9faSsmBQX8bLr74Mg3udcdlk98SeKRT6J1SusBjzbY8FJydh62E
 0m9poFv5pg7atvojD/yQ7Aii+EQCQ4udUW/1m50U3kooyrDYsygCaAaWqYXkJ4/PexUj
 VguIJW0s2MWfI/h2x1KxjHLdRqirdPqodK9PHX0tyQHDsfLN5jSg5wf4Cbj8RvgR+IOt
 PmuWp8rNfZe9A0/kMPuXKs/iP/Y638yCLR3dc1iMV8aanL0fqd/3poBjroQekKZHc6Ez
 K4uA==
X-Gm-Message-State: AOAM530B/kZtpxqtJdqYxL9n3Gmx7tumOcf+IGbf3ENh7fgVAKtrZ8t4
 ZTBW0H779/Aj/EhBC2BaYhvfHsfF8obHNQeFrv8=
X-Google-Smtp-Source: ABdhPJz8KkE1rg5USBFH6sa+d287l8H6HANFNuXD4U6OTPaTn9XHbzCIm9BjG7xBoRt3N6QXuOLHwmt1rEz/Pb8hMzQ=
X-Received: by 2002:a05:6808:f8e:b0:328:a601:a425 with SMTP id
 o14-20020a0568080f8e00b00328a601a425mr12233214oiw.253.1652822876657; Tue, 17
 May 2022 14:27:56 -0700 (PDT)
MIME-Version: 1.0
References: <20220517162854.1017207-1-sunil.khatri@amd.com>
 <20220517162854.1017207-3-sunil.khatri@amd.com>
In-Reply-To: <20220517162854.1017207-3-sunil.khatri@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 17 May 2022 17:27:45 -0400
Message-ID: <CADnq5_MdSBK7YnqF_fnHOek+NVTjJ4LmUzFF6ZHOXL1_zfnH-g@mail.gmail.com>
Subject: Re: [PATCH 3/3] dmr/amdgpu: add support of tmz for GC 10.3.7
To: Sunil Khatri <sunil.khatri@amd.com>
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Pan Xinhui <Xinhui.Pan@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Series is:
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

On Tue, May 17, 2022 at 12:29 PM Sunil Khatri <sunil.khatri@amd.com> wrote:
>
> Add support of IP GC 10.3.7 in amdgpu_gmc_tmz_set.
>
> Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> index 7e55ee61f84c..798c56214a23 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> @@ -540,6 +540,8 @@ void amdgpu_gmc_tmz_set(struct amdgpu_device *adev)
>         case IP_VERSION(10, 3, 1):
>         /* YELLOW_CARP*/
>         case IP_VERSION(10, 3, 3):
> +       /* GC 10.3.7 */
> +       case IP_VERSION(10, 3, 7):
>                 /* Don't enable it by default yet.
>                  */
>                 if (amdgpu_tmz < 1) {
> --
> 2.25.1
>
