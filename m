Return-Path: <SRS0=BheJ=2B=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1405C43603
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Dec 2019 14:42:46 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 96D54208C3
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Dec 2019 14:42:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V787UdvB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 96D54208C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5B6346EB65;
	Wed, 11 Dec 2019 14:42:46 +0000 (UTC)
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com
 [IPv6:2a00:1450:4864:20::441])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0C29C6EB65
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 Dec 2019 14:42:45 +0000 (UTC)
Received: by mail-wr1-x441.google.com with SMTP id t2so24337408wrr.1
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 Dec 2019 06:42:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=6aRFMJf1gQ3qg6Rk60kjGCi9dGFSwgkXlnLD6fbjlY4=;
 b=V787UdvB/ioGuCZOjvEcRgyUygdVcvXeFBsI34kJZ4U5kcEUwppe0sDR1Nl/Uno+tv
 x1LAnrWnHuJmPv2aNnhO4+mflLoEvMf3okjCphvl5pc66QRKZYVDYVCVFr2tjGKiEkD5
 JL+qGsWofvZ26XvvCeYeUJmRZZlVfR8u2qX+CczrVPOZxPaPs5jUJreXLTILKWHbO19a
 KFm/dg/DKQE/skvbehOgcgop35ofrE9iawYDx5NDywSkPIfgPUf0DOFCVhyN3gFtbXNL
 nq6M6ZZ6WHH8LC6FiEpyAisRRo4m5qrzpM3g/oxVMDgwRKb4/iGECumzIDB/pE87ecId
 dnTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=6aRFMJf1gQ3qg6Rk60kjGCi9dGFSwgkXlnLD6fbjlY4=;
 b=cCWU3D9HnZcZRXh3L+fj45KEbt8lMnBACdM90/aoN8k3AqbnX2TVAWNyz3eJshk+yH
 3qnLK45WEfMqJlLGpSriCIsJ8l/H0aSJvIddOXbhCS7rwopyWjJ+ZGEg58sJZsrTPTxj
 StIhVwsNWKqibiK/XPqTHm0Q9bU+WRqvzRXkW6/kSvr37hnjLKEnK33ZkoB75Y4Hhvh8
 XrEOdtj0N0EjSlfAtri0CsgJVt16ipJ5jxhwsoP63SxYd4S9NWrHprGld4c5p3DNTSjU
 bJ5fryL34wyyczmjeAP9Ss9Lkb6UjO/xaYBPI6lrGuPcURzm1+JX++m85SuT2EUjlQOs
 F8LQ==
X-Gm-Message-State: APjAAAXqt5/O4mfDW6+VFDFuwWPTMBPVuF0+dawn9ma+JaY72Y/8NJaA
 XM220HkBGMV3PqYdKOuwrcinvj5KIDjML4lLkF527Q==
X-Google-Smtp-Source: APXvYqzMYCfsWEVnF6klJ1ybGL6O2Pzekzlb2c+UU4s3O2hQ/8s6csFtYXVQityFvPIZejYGN3zr1HxZmZiz9vHgnJM=
X-Received: by 2002:a5d:46c7:: with SMTP id g7mr132204wrs.11.1576075363483;
 Wed, 11 Dec 2019 06:42:43 -0800 (PST)
MIME-Version: 1.0
References: <UPyARDn3GLmg4q9nl7gAuUjBHqg6GfvZOTyyRlyU1U-X-I1HD4Bo2AxZmmXWbRS3g35B_bD8Hm5WcJAqlwAsd-jcAz4Dij4AO0iA0Jpnjv8=@emersion.fr>
In-Reply-To: <UPyARDn3GLmg4q9nl7gAuUjBHqg6GfvZOTyyRlyU1U-X-I1HD4Bo2AxZmmXWbRS3g35B_bD8Hm5WcJAqlwAsd-jcAz4Dij4AO0iA0Jpnjv8=@emersion.fr>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 11 Dec 2019 09:42:30 -0500
Message-ID: <CADnq5_PA5r1DrnwKfdbJRBCr=i14Kkb++YOEr_wWoS6o7bfW1w@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: log when amdgpu.dc=1 but ASIC is unsupported
To: Simon Ser <contact@emersion.fr>
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Harry Wentland <hwentlan@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Wed, Dec 11, 2019 at 5:27 AM Simon Ser <contact@emersion.fr> wrote:
>
> This makes it easier to figure out whether the kernel parameter has been
> taken into account.
>
> Signed-off-by: Simon Ser <contact@emersion.fr>
> Cc: Harry Wentland <hwentlan@amd.com>
> Cc: Alex Deucher <alexander.deucher@amd.com>

Applied. thanks.

Alex


> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index 7a6c837c0a85..10618353383f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -2525,6 +2525,9 @@ bool amdgpu_device_asic_has_dc_support(enum amd_asic_type asic_type)
>                 return amdgpu_dc != 0;
>  #endif
>         default:
> +               if (amdgpu_dc > 0)
> +                       DRM_INFO("Display Core has been requested via kernel parameter "
> +                                        "but isn't supported by ASIC, ignoring\n");
>                 return false;
>         }
>  }
> --
> 2.24.0
>
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
