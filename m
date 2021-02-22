Return-Path: <SRS0=DoF4=HY=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85622C433E0
	for <amd-gfx@archiver.kernel.org>; Mon, 22 Feb 2021 21:42:28 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 22DF264D74
	for <amd-gfx@archiver.kernel.org>; Mon, 22 Feb 2021 21:42:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 22DF264D74
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4B7906E7EC;
	Mon, 22 Feb 2021 21:42:26 +0000 (UTC)
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com
 [IPv6:2607:f8b0:4864:20::22a])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 89FE36E7E5;
 Mon, 22 Feb 2021 21:42:24 +0000 (UTC)
Received: by mail-oi1-x22a.google.com with SMTP id d20so15556657oiw.10;
 Mon, 22 Feb 2021 13:42:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=dhUE+BTyH6wr+/ARgGP1BN/9HRGnBQw8k+/gXIcdf18=;
 b=gXpXfWLtRd8OhqYCVObAF80z+Z9L3DgNYOXxh71eUxW8XtXwJo9yWZZPNkv7hUeRDM
 cvv0M0uar+jrYvY1VF9/ECl5v2SxQI/0yy63bkWs1ClHqiVyGLAnEZhc6UgOsAd5EIQs
 9YnHIDzrcvwpVmJgDEyax6WNyK/QYF0/YY3EBYl+K574RIkHb2leAa6I+ks+nlFq2+6d
 DWenUQ/Y0Qd1ecoVksVXxytUE/yoJo41ZVkmMifRXJRgMeQ0ZTRTFW6Ao0NOR85LDWOr
 MtaR3OYxw3NRTrOsnyJ2Tu1NY1DySmTbeVA1lqX/oL2viu3jNk37FuMX1YnZmL87nMxj
 hV1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=dhUE+BTyH6wr+/ARgGP1BN/9HRGnBQw8k+/gXIcdf18=;
 b=PnnhN2GZZPip0ksOEIhSTdBjALf+4SPyVvFhQGownI1IfAU8L8qmuDIeo1vwuuPQc7
 zAA3k3lIDey/2+eVtTMQ1rM0Rd9QwTHrGPqZyF7O2nOIqMG3FrgruZ+jol8KARH6avfz
 B/wcTJqqxdSMG77+GbK7igQk12qEmqWf+SchSmGmmU5xUHwrAIqSqXYotEcMZE4tzsXS
 QlaJCbhV12SRhJ5T/q0O8D9iXFkgrcn0SecLecQs+dZMKE03mDsOW4qXQvJBnFbx51EP
 RzVEoWaabv4/mW4MDb8saaaS/ZD4h3IpAutjoTAOfWAHoBxVbd7XpYh79pSShzahkkkG
 CmIw==
X-Gm-Message-State: AOAM532Z94pqtnHtpkJD5xyK/mjr/IMC+dEm7ZcN8it2l/I+zXs1A2w9
 CmByVf+SB79TYl85/pnUfLABjxT+pmb/S3ICxCQ=
X-Google-Smtp-Source: ABdhPJzfn71SCwifR8WX+lGVU6vR4TxYHBxjwhj+i0lE4Rz9jlSnoSrSHzTX8keOZeXzlF+kiI3NxJkcunNeDOVGPzE=
X-Received: by 2002:aca:f485:: with SMTP id s127mr4991211oih.120.1614030143812; 
 Mon, 22 Feb 2021 13:42:23 -0800 (PST)
MIME-Version: 1.0
References: <1613810110-106402-1-git-send-email-jiapeng.chong@linux.alibaba.com>
In-Reply-To: <1613810110-106402-1-git-send-email-jiapeng.chong@linux.alibaba.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 22 Feb 2021 16:42:12 -0500
Message-ID: <CADnq5_OS3KNQU1QWP=0Y8U0hDSf6uL087wj=prLQQrOf6DZYeQ@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu/sdma5.2: Remove unnecessary conversion to bool
To: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
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
Cc: Dave Airlie <airlied@linux.ie>, LKML <linux-kernel@vger.kernel.org>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>,
 "moderated list:DMA BUFFER SHARING FRAMEWORK" <linaro-mm-sig@lists.linaro.org>,
 Maling list - DRI developers <dri-devel@lists.freedesktop.org>, "Deucher,
 Alexander" <alexander.deucher@amd.com>,
 Christian Koenig <christian.koenig@amd.com>,
 linux-media <linux-media@vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Applied.  Thanks!

Alex

On Sat, Feb 20, 2021 at 3:35 AM Jiapeng Chong
<jiapeng.chong@linux.alibaba.com> wrote:
>
> Fix the following coccicheck warnings:
>
> ./drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c:1621:40-45: WARNING: conversion
> to bool not needed here.
>
> ./drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c:1619:40-45: WARNING: conversion
> to bool not needed here.
>
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
> index f1ba36a..9ed79a9 100644
> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
> @@ -1616,9 +1616,9 @@ static int sdma_v5_2_set_clockgating_state(void *handle,
>         case CHIP_VANGOGH:
>         case CHIP_DIMGREY_CAVEFISH:
>                 sdma_v5_2_update_medium_grain_clock_gating(adev,
> -                               state == AMD_CG_STATE_GATE ? true : false);
> +                               state == AMD_CG_STATE_GATE);
>                 sdma_v5_2_update_medium_grain_light_sleep(adev,
> -                               state == AMD_CG_STATE_GATE ? true : false);
> +                               state == AMD_CG_STATE_GATE);
>                 break;
>         default:
>                 break;
> --
> 1.8.3.1
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
