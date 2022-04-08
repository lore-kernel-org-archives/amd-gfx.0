Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04F5EC433EF
	for <amd-gfx@archiver.kernel.org>; Fri,  8 Apr 2022 14:02:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B342C10F27C;
	Fri,  8 Apr 2022 14:02:32 +0000 (UTC)
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com
 [IPv6:2607:f8b0:4864:20::229])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1F02610F27C
 for <amd-gfx@lists.freedesktop.org>; Fri,  8 Apr 2022 14:02:31 +0000 (UTC)
Received: by mail-oi1-x229.google.com with SMTP id w127so8879654oig.10
 for <amd-gfx@lists.freedesktop.org>; Fri, 08 Apr 2022 07:02:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=jFGqCXqH3MTpE1Mx/51czqcjZb1H+U+kA5zrZ/TtwE8=;
 b=UfGJ0silzLnpr/TrwiWCwfuajiSx9FwipslzIHTWZCR+XTtPyDLGEnCC6/3tm5UbJ+
 +eEaBXMQBw31+zwr8pzeXQDPf5PA96dKDT9yG36z8qv+BUbRt6PlBgkhrJwU0qXE9M9R
 gdMQO8bLRPMOM6afA6hJcq7RNc2eNLrpvCuSMfK8fIuXw7Ddbq+2H1qgx6kCpLbea4f8
 7E2aZSK/S7AITyq0TxJ31GM+4uwQMxO1ZMJx8V3xe2kJn7przhAFMytOW9E6caw2R7n1
 xC/BowTl12b/TPj5fdfwfC7UTz8JpJ/1BhmiYLJ2mExQG4rN53/2i2LkajuLBFbvbehV
 4lSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=jFGqCXqH3MTpE1Mx/51czqcjZb1H+U+kA5zrZ/TtwE8=;
 b=NMlpGrLnnotQ4MYy5NQwykmeWYOc2VPB++gufxSfNQ2WTqV0L+eLtiREgUyPgnKIZi
 3FgS4nZXTzAtBhfLnPTDh5Uu3tqqdb4Yhdqjj4Yva1izLbkFkVd2xjx+KKwe9Vx56Off
 dfBbZTR/e8cuJpSmKt51ihq8BADumXvY4jAGP7ZWozeKolVjqiODXt16iCWj9dnSIJrS
 kBwkpr++9bIqWZW4Yb59F7bmJL5nb8l/Xti/k4Lrd7L/uKCqM5wZgTbvbyrDWi/UPM0k
 tmn0SSR3PQFuHeakMpUyv+ovkzF0jc2rgnXupoXy0Yvh8urzmeP3G0AwFSG5c0lJyZhP
 E9Rw==
X-Gm-Message-State: AOAM530Lq3dwlxSwTaf8ggaDMWx0JVrOt3xP76zxZfmRDg/PcpJCK+ox
 malJiDGl6Qr/WVR/rJBmKaxTsGdneZVZysDb7KU=
X-Google-Smtp-Source: ABdhPJxSwjr8KxZeu9AuGt8bUUd5aooKAbrY04tkALzc+Dtbt+ZP3fh6Qn0znXz3JlH6xyDWST9mXxg2BbxL7bxLps8=
X-Received: by 2002:a05:6808:199e:b0:2f9:d699:6ad0 with SMTP id
 bj30-20020a056808199e00b002f9d6996ad0mr770916oib.200.1649426548610; Fri, 08
 Apr 2022 07:02:28 -0700 (PDT)
MIME-Version: 1.0
References: <20220408135814.244798-1-yongqiang.sun@amd.com>
In-Reply-To: <20220408135814.244798-1-yongqiang.sun@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 8 Apr 2022 10:02:17 -0400
Message-ID: <CADnq5_NCm9rqZykjtcSi1yY8Oqn4BHoczULpSKyu6UAxUsh8Kg@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/amdgpu: Fix asm/hypervisor.h build error.
To: Yongqiang Sun <yongqiang.sun@amd.com>
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
Cc: "Deucher, Alexander" <alexander.deucher@amd.com>,
 kernel test robot <lkp@intel.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Fri, Apr 8, 2022 at 9:58 AM Yongqiang Sun <yongqiang.sun@amd.com> wrote:
>
> Add CONFIG_X86 check to fix the build error.
>
> Fixes: 67c7a4b1ec6c
> ("drm/amd/amdgpu: Only reserve vram for firmware with vega9 MS_HYPERV
> host.")
>
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Yongqiang Sun <yongqiang.sun@amd.com>

Acked-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> index c322daf9c734..569cc394e562 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> @@ -25,7 +25,9 @@
>   */
>
>  #include <linux/io-64-nonatomic-lo-hi.h>
> +#ifdef CONFIG_X86
>  #include <asm/hypervisor.h>
> +#endif
>
>  #include "amdgpu.h"
>  #include "amdgpu_gmc.h"
> @@ -671,10 +673,12 @@ void amdgpu_gmc_get_vbios_allocations(struct amdgpu_device *adev)
>                 /*
>                  * VEGA10 SRIOV VF with MS_HYPERV host needs some firmware reserved area.
>                  */
> +#ifdef CONFIG_X86
>                 if (amdgpu_sriov_vf(adev) && hypervisor_is_type(X86_HYPER_MS_HYPERV)) {
>                         adev->mman.stolen_reserved_offset = 0x500000;
>                         adev->mman.stolen_reserved_size = 0x200000;
>                 }
> +#endif
>                 break;
>         case CHIP_RAVEN:
>         case CHIP_RENOIR:
> --
> 2.25.1
>
