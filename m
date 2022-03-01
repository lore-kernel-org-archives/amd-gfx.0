Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C9A7C433F5
	for <amd-gfx@archiver.kernel.org>; Tue,  1 Mar 2022 18:35:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 254B610E3A1;
	Tue,  1 Mar 2022 18:35:01 +0000 (UTC)
Received: from mail-oo1-xc36.google.com (mail-oo1-xc36.google.com
 [IPv6:2607:f8b0:4864:20::c36])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AEDC210E6D5
 for <amd-gfx@lists.freedesktop.org>; Tue,  1 Mar 2022 18:34:59 +0000 (UTC)
Received: by mail-oo1-xc36.google.com with SMTP id
 w3-20020a4ac183000000b0031d806bbd7eso7774699oop.13
 for <amd-gfx@lists.freedesktop.org>; Tue, 01 Mar 2022 10:34:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=z0ULRRPXtH7mL/HrUqIVxlBAwHmJIlLjuOwGinShgso=;
 b=jO8hWHCUftks2gPv/g+iKlOfaOYcZ65AbXSzobeTNzNvRHkjDQl6EcUHX6Q1Wzjj//
 lmj2wJZPTWkj41O69d3tVa2ziAtD4ljj+rlWgQzlLlX4R/sijSY7/DLKGUvP38tFWr0m
 2x2neV+aT3LW6pC8hDfd3hyELhjNsmxGv3D0IXDO9rx+xuNrD6ZhqjAVToraXus3a085
 o5EDRIRjv/svI6wR3/zJka6UgDlwtuDAivUFcu7R+gzQr8w9AP7cQe/14+v/fQAc0KgA
 cefwBop5rn6cJL7roP+OE46f9yARuHAnqsjQ1FX54C3zSSLjju8Cb37+PiHwavJgHB41
 YF1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=z0ULRRPXtH7mL/HrUqIVxlBAwHmJIlLjuOwGinShgso=;
 b=S8TXlB6HWBn388guWxqxj8Dfecw/6o9O5UgvBnCAnQAwoWX4AD1mUn8uA9A8sp3T39
 67Tbk8dyY3S85RhV1kY9lCB0VCj0DiHaZGqiHHrYINUADi3JlOMMIsDKmVmaP1m/PToF
 lJn+JvmOWLD7LHUpNnPjSFcPtmSawDRdmwZ1NmxLucdQDkcKnvLp238Z9aE1FO9UZHSP
 cSm/KBkf/fPMg6PpSvOIboJwA4As7u6yTfonUNu1OH5XqSj/N0laDEQCY8BYHpvc79Or
 rRdXdtXjltE+BWpAswgrThvva+qW/eqHrLf/AzP+hTXG2Eg0Ib15QLwn1vTEJR3Zni1R
 74lQ==
X-Gm-Message-State: AOAM530VC37hXzfXq10JbBOf3fMHtUz1UM5qSeeSYJPp2tFCqf0ciAYa
 kFvZhW3TBDh0pR81cJDIHZPspkaQ0Rsc/mDF0MtF6GZQ
X-Google-Smtp-Source: ABdhPJx1JniZpcUBiGH27rmeALGNi7dUzeyHXmXfeLbBDSquLEwWIEzntqwXXjTB/3rVhqyuenhMXGtoxGAzF8niPQs=
X-Received: by 2002:a05:6870:1b85:b0:d6:feda:913f with SMTP id
 hm5-20020a0568701b8500b000d6feda913fmr4919384oab.123.1646159698759; Tue, 01
 Mar 2022 10:34:58 -0800 (PST)
MIME-Version: 1.0
References: <20220301180800.1781042-1-andrey.grodzovsky@amd.com>
 <20220301180800.1781042-2-andrey.grodzovsky@amd.com>
In-Reply-To: <20220301180800.1781042-2-andrey.grodzovsky@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 1 Mar 2022 13:34:47 -0500
Message-ID: <CADnq5_P0GJ7wpFWoT8XYat-4RDyBCtgrpZ19cXG2b=5DGwszww@mail.gmail.com>
Subject: Re: [PATCH 2/2] drm/amdgpu: Bump minor version for hot plug tests
 enabliing.
To: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Tue, Mar 1, 2022 at 1:08 PM Andrey Grodzovsky
<andrey.grodzovsky@amd.com> wrote:
>
> This will allow to enable the tests only after latest fix
> after which the tests passed on my system.
>
> I tested on NV21 standalone and Vega 10 and Polaris as
> pair with DRI_PRIME.
>
> It's possible there might be still issues on ASICs i don't
> have at my posession but that that the point of enbling
> the tests finally - if other people during testing will
> encounter errors they will report and I will be able to fix.
>
> The releated merge request for enabling libdrm tests suite  is in
> https://gitlab.freedesktop.org/mesa/drm/-/merge_requests/227
>
> Signed-off-by: Andrey Grodzovsky <andrey.grodzovsky@amd.com>

Typo in the title: enabliing -> enabling

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> index 415ecf8b2e05..be4adda8d674 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> @@ -100,9 +100,10 @@
>   * - 3.43.0 - Add device hot plug/unplug support
>   * - 3.44.0 - DCN3 supports DCC independent block settings: !64B && 128B, 64B && 128B
>   * - 3.45.0 - Add context ioctl stable pstate interface
> + * * 3.46.0 - Add context ioctl stable pstate interface

Please update the comment here to say something like bump for hotplug
handing.  With the typo and this fixed, series is:
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>


>   */
>  #define KMS_DRIVER_MAJOR       3
> -#define KMS_DRIVER_MINOR       45
> +#define KMS_DRIVER_MINOR       46
>  #define KMS_DRIVER_PATCHLEVEL  0
>
>  int amdgpu_vram_limit;
> --
> 2.25.1
>
