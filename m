Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B94DC433F5
	for <amd-gfx@archiver.kernel.org>; Wed,  1 Dec 2021 19:59:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 01F7D6E8A2;
	Wed,  1 Dec 2021 19:59:47 +0000 (UTC)
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com
 [IPv6:2607:f8b0:4864:20::32d])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6D9FB6E8A2
 for <amd-gfx@lists.freedesktop.org>; Wed,  1 Dec 2021 19:59:45 +0000 (UTC)
Received: by mail-ot1-x32d.google.com with SMTP id
 v15-20020a9d604f000000b0056cdb373b82so36814359otj.7
 for <amd-gfx@lists.freedesktop.org>; Wed, 01 Dec 2021 11:59:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=chDU8gxYQGtDuzkDrvxxOshBxomMyIWwN3fh4Z045Dc=;
 b=B7pSO+pr+RVhy8Q4wuzlc7ofS1MDsmpJQMcYy7ztbDaLgZwi/RpyYcqyqb1Ck0s5KZ
 NdbAGrkMXaT1qOswD2g7K4h5G3JeDF6E1E/K50KNksZTzD2csMEHk6yxahYNJRci70/e
 7Ps+dukaY7r9gK6KC1pc2GENrzBptW58RFjn8XDXjrmZvlv+KbjvIly374QGws4OKHvu
 nyv58U2dtkvBVS9P1pQ4xX0O7RQJKXAUpGD+IRubysq59caV6FuG34nvJQz5kcKKB9Te
 TMxPGBviNA9SF/4kexrMHxWIx2+szILncf9xThiXd1Bv4F3i1mQsifUDLOXUvxE5fF5g
 O5Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=chDU8gxYQGtDuzkDrvxxOshBxomMyIWwN3fh4Z045Dc=;
 b=qt7P39nzdA0nFsPBXXxmy2+1HWEmgIvJ4UJ5GUsPd60AsdA0ENPMg3rTH85C10KN64
 wGg9GvCZySxzCEttC7sZgaKySbOL6YV9K6NyeGsaPiFe0BN3HddRcELU7wM/qKgQvdaY
 uENYTtPfpVRzOGp/fr9usXymXmnsLkfS0aTB7p/761YgXGKj5sLUkRq6xcsUarl7RNKO
 OvXZR2HRrG4/jLBMcAjxQw6TMw2q3yFgWAHL83iCysNuy6tjWW2vMsd387X6KsvPlQRz
 8B2qqVmZJ1ko6JGku9kDAIM4uggnP+tcMiSPCXPSoyzKm96aGjX/w2zuC+lPZmE7kcia
 Cd4Q==
X-Gm-Message-State: AOAM531PK2iZQRtkYAD9dy6xG6GO4mXRz/1OASIlHDyY06Wpsjdo+/av
 TcrAIut6bm8S11mxFK5/2GATSauw0ekokDGfD5Tvyh5S
X-Google-Smtp-Source: ABdhPJz5DBKIMyriBoujShIm/bkdpBm9AJIy2tOyQeNYv0suK5WEiQtmwYbIQQOhv/HfoGZe2QwsrQYDaQ6qvzEBYLc=
X-Received: by 2002:a9d:6855:: with SMTP id c21mr7821639oto.357.1638388784441; 
 Wed, 01 Dec 2021 11:59:44 -0800 (PST)
MIME-Version: 1.0
References: <20211129200857.3247-1-ydirson@free.fr>
In-Reply-To: <20211129200857.3247-1-ydirson@free.fr>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 1 Dec 2021 14:59:33 -0500
Message-ID: <CADnq5_PS+fbXbU1Tt4JGco8qT1_YG3ThQ_CY4sd8Kf+7AUwh7A@mail.gmail.com>
Subject: Re: [PATCH v2] drm/amdgpu: update fw_load_type module parameter doc
 to match code
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

Applied.  Thanks!

On Mon, Nov 29, 2021 at 3:09 PM Yann Dirson <ydirson@free.fr> wrote:
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
> index ecdec75fdf69..64881068b115 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> @@ -315,9 +315,12 @@ module_param_named(dpm, amdgpu_dpm, int, 0444);
>
>  /**
>   * DOC: fw_load_type (int)
> - * Set different firmware loading type for debugging (0 = direct, 1 = SMU, 2 = PSP). The default is -1 (auto).
> + * Set different firmware loading type for debugging, if supported.
> + * Set to 0 to force direct loading if supported by the ASIC.  Set
> + * to -1 to select the default loading mode for the ASIC, as defined
> + * by the driver.  The default is -1 (auto).
>   */
> -MODULE_PARM_DESC(fw_load_type, "firmware loading type (0 = direct, 1 = SMU, 2 = PSP, -1 = auto)");
> +MODULE_PARM_DESC(fw_load_type, "firmware loading type (0 = force direct if supported, -1 = auto)");
>  module_param_named(fw_load_type, amdgpu_fw_load_type, int, 0444);
>
>  /**
> --
> 2.31.1
>
