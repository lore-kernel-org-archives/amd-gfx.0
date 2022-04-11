Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B26CC4332F
	for <amd-gfx@archiver.kernel.org>; Mon, 11 Apr 2022 15:22:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9359410E224;
	Mon, 11 Apr 2022 15:22:48 +0000 (UTC)
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com
 [IPv6:2607:f8b0:4864:20::22e])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 51E8A10E10D
 for <amd-gfx@lists.freedesktop.org>; Mon, 11 Apr 2022 15:22:47 +0000 (UTC)
Received: by mail-oi1-x22e.google.com with SMTP id v75so16221715oie.1
 for <amd-gfx@lists.freedesktop.org>; Mon, 11 Apr 2022 08:22:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=Xt3WItY+6+yEC4M2LxDeijfAEFDT3PYFZV/uwjnz3XI=;
 b=SsoimXnCGd6/WyCYKIffmB4aDy2AlYsIoDhAahcxmYk+vZm6NaRVULMemoi2K6a1Gw
 mnVCFJ8qakqxrOfC5Mmtl1VJWNZNhLztK/YEeIF6zBg6nF6l42GorsyFPB1DOp9rP/mL
 m0MKYACd9fNmftBIh3emMn9OiaaNirvuZM2L9Ag1I33JyTfIK4+SYIufL8hhxZJOh8T3
 8haTaUuGx8q5W/TNc7AFFv2HtXW3GrA9NTZX9LMh3EZ6C55slYoS201jreQ23qZrBJ8M
 sm05JAtYR7EiknyEtCu7jF4JJgsDfooM6iT9CvxjurDn2FYptzH01H0WDsL5TOSIa4J6
 P1Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Xt3WItY+6+yEC4M2LxDeijfAEFDT3PYFZV/uwjnz3XI=;
 b=U+JUwpzk++3ajKB9hsNDln8C8PdtohauRzbgccvl31tYpS+USPcoOuePFoBCCgjEIs
 EbP++vcCLHu66IaHFUSntSymL860w0S1kB6i9Cc1MctfkOK8CN0xbRjtjcg1ar96um5N
 4Xo/TJdTt3o+1ixQuQEYwx3QwZs4vUH+6bo9QPiJHncgjwWhOEdRmuMZPHgLIu18wCFG
 1SA40UkTnngd3f9JlQ0Y3skompDfkVjKgoeSrdOZCXUpX4vNHO+o8RN1aIC3ER4qU8nm
 LgdkomGsdcckLSRfncnBlMlGwkj3aTKgS+8ftwDNr9jhCK+srSkfV6TIZGjPtZz73TaG
 VBYg==
X-Gm-Message-State: AOAM530uvIARmveNAAhEKPapiadKGUWhTInAbky2iHPNy0YqNJ/SGqyV
 /adZZlZCuaQYc2/2FyvGESUX/Rwd1Xe4r2fJpl0=
X-Google-Smtp-Source: ABdhPJyniu6NZndc7Jo1BHcGbKyvLWDnsjgo8eb93TuzS0oG752PVXRi8+DT4+AL2Bde6/OOwrR+ZhqIVjeuZ3Dn5lQ=
X-Received: by 2002:a05:6808:1486:b0:2f9:e821:51d9 with SMTP id
 e6-20020a056808148600b002f9e82151d9mr5350072oiw.253.1649690566335; Mon, 11
 Apr 2022 08:22:46 -0700 (PDT)
MIME-Version: 1.0
References: <20220411135209.905421-1-yongqiang.sun@amd.com>
In-Reply-To: <20220411135209.905421-1-yongqiang.sun@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 11 Apr 2022 11:22:35 -0400
Message-ID: <CADnq5_M=SfgME0n-yHBicgpv_0JxPZpL9d-P7tnyDP5GA+oCGA@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/amdgpu: Not request init data for MS_HYPERV with
 vega10
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
Cc: Jingwen Chen <jingwen.chen2@amd.com>, "monk.liu" <monk.liu@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Mon, Apr 11, 2022 at 9:52 AM Yongqiang Sun <yongqiang.sun@amd.com> wrote:
>
> MS_HYPERV with vega10 doesn't have the interface to process
> request init data msg.
> Check hypervisor type to not send the request for MS_HYPERV.
>
> Signed-off-by: Yongqiang Sun <yongqiang.sun@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c | 12 ++++++++++--
>  1 file changed, 10 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
> index 933c41f77c92..56b130ec44a9 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
> @@ -23,6 +23,10 @@
>
>  #include <linux/module.h>
>
> +#ifdef CONFIG_X86
> +#include <asm/hypervisor.h>
> +#endif
> +
>  #include <drm/drm_drv.h>
>
>  #include "amdgpu.h"
> @@ -721,8 +725,12 @@ void amdgpu_detect_virtualization(struct amdgpu_device *adev)
>                         break;
>                 case CHIP_VEGA10:
>                         soc15_set_virt_ops(adev);
> -                       /* send a dummy GPU_INIT_DATA request to host on vega10 */
> -                       amdgpu_virt_request_init_data(adev);
> +#ifdef CONFIG_X86
> +                       /* not send GPU_INIT_DATA with MS_HYPERV*/
> +                       if (hypervisor_is_type(X86_HYPER_MS_HYPERV) == false)

Preferred coding style would be:
if (!hypervisor_is_type(X86_HYPER_MS_HYPERV))
With that fixed:
Acked-by: Alex Deucher <alexander.deucher@amd.com>

> +#endif
> +                               /* send a dummy GPU_INIT_DATA request to host on vega10 */
> +                               amdgpu_virt_request_init_data(adev);
>                         break;
>                 case CHIP_VEGA20:
>                 case CHIP_ARCTURUS:
> --
> 2.25.1
>
