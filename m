Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D821CC433F5
	for <amd-gfx@archiver.kernel.org>; Mon, 29 Nov 2021 17:49:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 176466E499;
	Mon, 29 Nov 2021 17:49:06 +0000 (UTC)
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com
 [IPv6:2607:f8b0:4864:20::32c])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2D8776E499
 for <amd-gfx@lists.freedesktop.org>; Mon, 29 Nov 2021 17:49:05 +0000 (UTC)
Received: by mail-ot1-x32c.google.com with SMTP id
 u18-20020a9d7212000000b00560cb1dc10bso26575608otj.11
 for <amd-gfx@lists.freedesktop.org>; Mon, 29 Nov 2021 09:49:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=rRPbbmaphFHoF1M3DFdDBdQ+KhPrrrKcRT6rpsZdoDs=;
 b=Nr4RiPJhpT4EuN4pcD0uapkAuwizT1XJmAcJh8ID296OGFS8A5y2joEbp3XZG1Qnk5
 7VyXi6TdHBEaF3m5IJDI8o3N/QYn5p/WESaRKdIJ3gNw1Q6703m6RoEsg2sug+hPIN8K
 nHmraGQ2JyF3sRypfs1bMwq9c13RIWQ5zzfA7SQVg7F1MoKL7vSzupUEPL5VMPS7TGS9
 YEgOEdDtjsEl0Pkk525dNlXxlnYmDUkiDk7tyMMJe/9LWPD+UOKgKRR0o3Z7v4IXCggk
 PGhP7qj6xw3W7q4MiTaTqXcumRlaO75D2TtxToSqFRO1udpeBKdQ8YeVU5Mo1n7B9zXt
 +jeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=rRPbbmaphFHoF1M3DFdDBdQ+KhPrrrKcRT6rpsZdoDs=;
 b=wxl8mlsfcVvP2qLKoWMqLe87AV/8bWn740B4cYRTytukMIFpGH4cRSRx58nqWW77+I
 5K9VDaXFsoth5TQ/iNAqY2hFNrLMo7fxsCkSI03NH7eXPuKuvOReTn+iHpNMuHRvtZFp
 Lj6mNt7iA+FcHwGBup2Lj/G/a7hTo50ZfPUIlf4gB6kl31FCeAT8FrBu0QTCeA+gbHMu
 6UUkft8Pa4iAwMYgO2fKx9z4u07SaACVFdjp++x5OvscC3Lyir1CcFBUcvlb2fKp7BgL
 NjPOFpa06UdG6xhSv9R5uLSkosb4tMb72Fd42ve9AjaPTLbp/+yNIg8ywvu8IIPynVSY
 0fhA==
X-Gm-Message-State: AOAM531ilVgCl/VIlMd6vbY94Dd4M3onnjsRRksakeHMU82uVfaQnpMP
 v8yfarZIENTZyZ/bQt+BVnCz+/S4Ox9ztDsPyu8=
X-Google-Smtp-Source: ABdhPJz7aXk9tumAG41Lz8bL4P4sXBm0hOmDgCEXpOd2JpdBcDqvqVWRwBca/zHPUxyIg5r590d2ecmcQ+bvNz+j9AU=
X-Received: by 2002:a9d:6855:: with SMTP id c21mr47717883oto.357.1638208144435; 
 Mon, 29 Nov 2021 09:49:04 -0800 (PST)
MIME-Version: 1.0
References: <20211128163120.11092-1-ydirson@free.fr>
In-Reply-To: <20211128163120.11092-1-ydirson@free.fr>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 29 Nov 2021 12:48:53 -0500
Message-ID: <CADnq5_M-tZCMentbKNyMkDj6Dpi8KGgUc4DtSGE1qUznS9X3BQ@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: update fw_load_type module parameter doc to
 match code
To: Yann Dirson <ydirson@free.fr>
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

On Sun, Nov 28, 2021 at 11:31 AM Yann Dirson <ydirson@free.fr> wrote:
>
> amdgpu_ucode_get_load_type() does not interpret this parameter as
> documented.  It is ignored for many ASIC types (which presumably
> only support one load_type), and when not ignored it is only used
> to force direct loading instead of PSP loading.  SMU loading is
> only available for ASICs for which the parameter is ignored.
>
> Signed-off-by: Yann Dirson <ydirson@free.fr>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> index ecdec75fdf69..8ab12368b3b6 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> @@ -315,9 +315,12 @@ module_param_named(dpm, amdgpu_dpm, int, 0444);
>
>  /**
>   * DOC: fw_load_type (int)
> - * Set different firmware loading type for debugging (0 = direct, 1 = SMU, 2 = PSP). The default is -1 (auto).
> + * Set different firmware loading type for debugging, if supported.
> + * Set to 0 to force direct loading if supported by the ASIC.  All
> + * other values select the default loading mode as defined by the
> + * driver.  The default is -1 (auto).
>   */
> -MODULE_PARM_DESC(fw_load_type, "firmware loading type (0 = direct, 1 = SMU, 2 = PSP, -1 = auto)");
> +MODULE_PARM_DESC(fw_load_type, "firmware loading type (0 = force direct if supported, non-zero = auto)");

Please change the documentation to 0 for direct and -1 for auto in
case other methods get added in the future.

Alex

>  module_param_named(fw_load_type, amdgpu_fw_load_type, int, 0444);
>
>  /**
> --
> 2.31.1
>
