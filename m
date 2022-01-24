Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B2FBC433EF
	for <amd-gfx@archiver.kernel.org>; Mon, 24 Jan 2022 20:08:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A137210E6A9;
	Mon, 24 Jan 2022 20:08:11 +0000 (UTC)
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com
 [IPv6:2607:f8b0:4864:20::332])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1DCC310E6A9
 for <amd-gfx@lists.freedesktop.org>; Mon, 24 Jan 2022 20:08:10 +0000 (UTC)
Received: by mail-ot1-x332.google.com with SMTP id
 10-20020a9d030a000000b0059f164f4a86so6349594otv.13
 for <amd-gfx@lists.freedesktop.org>; Mon, 24 Jan 2022 12:08:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=hCUiF5WpGKMLJQx8IUwagqrar5gdp+NGJ9joTPUwWVM=;
 b=EsfrtcdtIidLj6YDw4S+xCD5/lEWhLKTHK5ds+F86oE+2pomQDQaFj5yPTuGmUuPUf
 MZIzqSN3gfuUDPctU9FVvivqNxWbACyulYQQG+/BXyfPsHQGKRE48IFnss1NaqY7Wrst
 fA8Yek20lVNTU51XP3RE6zNyS8vV50h7NQQmksZDe/VN+pTH/hRgsllpeweNY1nV6uCM
 48hXKiPDbH3PJcF5+FWz8gXYGYGljKZhFJYTsyZNuBaoBQHJaCWqbrh/d/BXR+r1kMBo
 WsRmG07/cQpdB4HX7r8mBGfywCiqNBbue9trQWYoQnbKyWtTmNU1LAtImG7X5hWNwY5F
 ex8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=hCUiF5WpGKMLJQx8IUwagqrar5gdp+NGJ9joTPUwWVM=;
 b=HO7F+L0jDx0MCf4Ag41vY3CIcIVEJr8QyQmHutxlEvHOdpk/lCEpyMhFYo2xElpfCM
 YKBFiDCNxaQTW6USb1IhAi4bOsj95tFgaODlbNBg7dq9kMnMqknYltQTxT8JbBAl+9+x
 kc5vthAU7Dp40bq/3aX81ghLvJKfJ3yXkLp1Im8cZrUcFDSwSqiDvkCnfHQy4KRonQZe
 DzdwwZwOeaugQu1nNq9VXVMQlbvLAXIVkz3Xgkl2H6nbHXrHJ5DacUETkYU4iedBrni8
 0m1h6SAbJVT3TXkk0SJ6Fiu/FwmH62q4WlT0KjGUZEW84yN0pPLDikZXqn/FsX2L1faU
 TMDw==
X-Gm-Message-State: AOAM533rI3qzI0DIdBdJlrR7TLE6vh5U+nyJcP+LqyzTcaRmF2tXPMBr
 p+BpPagRU8CByfWgvfvOrtgLRPWojoWigyWke0U=
X-Google-Smtp-Source: ABdhPJyb2AgYEB6LsdwJzNSdZ4cBVFsjP6GRS8NSXw0soH6OT5uAZumUr8wbZ6HV+UuqZkLN3ax0EbFS/YzQjntnVkM=
X-Received: by 2002:a9d:601a:: with SMTP id h26mr3301015otj.357.1643054888437; 
 Mon, 24 Jan 2022 12:08:08 -0800 (PST)
MIME-Version: 1.0
References: <20220121161648.14729-1-jinhuieric.huang@amd.com>
In-Reply-To: <20220121161648.14729-1-jinhuieric.huang@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 24 Jan 2022 15:07:57 -0500
Message-ID: <CADnq5_MpZS7z7tjRXzXmGv7Dq6+O96a=89JY1TQ15=b7+bziKg@mail.gmail.com>
Subject: Re: [PATCH] drm/amdkfd: enable heavy-weight TLB flush on Vega20
To: Eric Huang <jinhuieric.huang@amd.com>
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
Cc: amd-gfx list <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Fri, Jan 21, 2022 at 11:17 AM Eric Huang <jinhuieric.huang@amd.com> wrote:
>
> It is to meet the requirement for memory allocation
> optimization on MI50.
>
> Signed-off-by: Eric Huang <jinhuieric.huang@amd.com>

Assuming there is no firmware version requirement, the patch is:
Acked-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdkfd/kfd_chardev.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> index 5b8ae0795c0a..d708f1a502cf 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> @@ -1582,7 +1582,8 @@ static int kfd_ioctl_free_memory_of_gpu(struct file *filep,
>  static bool kfd_flush_tlb_after_unmap(struct kfd_dev *dev) {
>         return KFD_GC_VERSION(dev) == IP_VERSION(9, 4, 2) ||
>                (KFD_GC_VERSION(dev) == IP_VERSION(9, 4, 1) &&
> -               dev->adev->sdma.instance[0].fw_version >= 18);
> +               dev->adev->sdma.instance[0].fw_version >= 18) ||
> +               KFD_GC_VERSION(dev) == IP_VERSION(9, 4, 0);
>  }
>
>  static int kfd_ioctl_map_memory_to_gpu(struct file *filep,
> --
> 2.25.1
>
