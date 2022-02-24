Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E707EC433EF
	for <amd-gfx@archiver.kernel.org>; Thu, 24 Feb 2022 15:58:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6C11110EA1D;
	Thu, 24 Feb 2022 15:58:27 +0000 (UTC)
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com
 [IPv6:2607:f8b0:4864:20::334])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D5D9210EA0B
 for <amd-gfx@lists.freedesktop.org>; Thu, 24 Feb 2022 15:58:25 +0000 (UTC)
Received: by mail-ot1-x334.google.com with SMTP id
 j8-20020a056830014800b005ad00ef6d5dso1588736otp.0
 for <amd-gfx@lists.freedesktop.org>; Thu, 24 Feb 2022 07:58:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=Hoqv87KVKjSOPD2jD8jIFFttEKy2Psx+hLKvES9T8x4=;
 b=jsJm2n/WctiyVQ4Ri0z2woPuz086JzcZh9ZWPoVbe5cfIIAIxxDi8KXzRRJi7NckeE
 rl8ynnOFtqRvVry4KJtUG0IrJ61CR7+DXdrxT+HSuXHKuj0CeNZF7Sm5ss7Lwav1vYb7
 Tq5F+9PS5Ode3SEVjYkOohukudrTvtr+q/8KwJDelNzofanuqONbQttf4Kp5nlZqk3RC
 M5NezdI27YsffL8P/MZH6WIEnFyaq9RMBMbJvYg7kfozeQPYOp4DO0lWSNFFYcKjQkXG
 JW8n/CZ9PWldMt6u67S2v8bPKx7JD02zasQ0UQBi2DinsLKHxqHrc4k9tacnFwzhuJgX
 x+Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Hoqv87KVKjSOPD2jD8jIFFttEKy2Psx+hLKvES9T8x4=;
 b=N6b5ywxLTIXKhmC2iq3tfszYVqSq5/9eS8aeXaMUZTPP7gRqBtaQf87bc455sgLgQI
 tq6CcYnvyQWeMtKHbJUS2MbNswmxBiQNPkpb5mODFCcTz5SkIrb23IkAyH5yP+IXYxFg
 RbMx9uXnnJgTZ5oWDOJGapf1NBBQtg/qtBRjk4rfA3SnCipB2ZeYNDzgRzRdkZUyQc/W
 /CYljuSLm2og/8ovSQKGqOwy5PdDppUQpOG3axmW5h3/qGewrDP7iAXq0al+mYWjGW0A
 Ac6tOaqemFNi6HpFDhCOLdjm1tetVWsmB/ntLLu97YZ5/EX8nxkR0YiyjI0YmGVgyHbc
 F8YQ==
X-Gm-Message-State: AOAM533WjWgInxrQdHpQa7LgbsEX/KzZo0QjzE/Y2zMt7tWQZbX97eoL
 UY3ThG04qcOsKivxzIV3TdWbG54XoVtYmfAGCiU=
X-Google-Smtp-Source: ABdhPJzBiatmrSdTXV0rWRfKjL8NKeM+3Do5QsKVnG5SrjvE8VUog4NBfdILn6qCgk66GgYDywoTZHp1OsAKQbwnJ/A=
X-Received: by 2002:a4a:1b43:0:b0:31b:aa93:dd7d with SMTP id
 64-20020a4a1b43000000b0031baa93dd7dmr1123507oop.68.1645718305086; Thu, 24 Feb
 2022 07:58:25 -0800 (PST)
MIME-Version: 1.0
References: <20220222150731.16954-1-guchun.chen@amd.com>
In-Reply-To: <20220222150731.16954-1-guchun.chen@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 24 Feb 2022 10:58:14 -0500
Message-ID: <CADnq5_MHoxvwf0Zg+3Wu1w_yq+RTHtBG=f4FRv4H+Pp+kHDiqA@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: limit harvest bit read on several ASICs
To: Guchun Chen <guchun.chen@amd.com>
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
 xinhui pan <xinhui.pan@amd.com>, Christian Koenig <christian.koenig@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>,
 Hawking Zhang <hawking.zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Tue, Feb 22, 2022 at 10:07 AM Guchun Chen <guchun.chen@amd.com> wrote:
>
> Due to faulty VBIOS out there, harvest bit setting is not
> consistently correct especially for display IP. So far,
> it's hard to work out a solution on all the legacy Navi1x
> ASICs in a short time, so to avoid regression, limit harvest
> bit read on several ASICs. Will revisit later once VBIOS has
> corrected it in long term.
>
> Fixes: b3f4ea887d5f("drm/amdgpu: read harvest bit per IP data on legacy GPUs")
> Signed-off-by: Guchun Chen <guchun.chen@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 18 +++++++++++++-----
>  1 file changed, 13 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> index 11255290f117..2e0ff1ace6fc 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> @@ -1129,12 +1129,20 @@ void amdgpu_discovery_harvest_ip(struct amdgpu_device *adev)
>          * so read harvest bit per IP data structure to set
>          * harvest configuration.
>          */
> -       if (adev->ip_versions[GC_HWIP][0] < IP_VERSION(10, 2, 0))
> -               amdgpu_discovery_read_harvest_bit_per_ip(adev,
> -                                                       &vcn_harvest_count);
> -       else
> +       if (adev->ip_versions[GC_HWIP][0] < IP_VERSION(10, 2, 0)) {
> +               if ((adev->pdev->device == 0x731E &&
> +                       (adev->pdev->revision == 0xC6 ||
> +                        adev->pdev->revision == 0xC7)) ||
> +                       (adev->pdev->device == 0x7340 &&
> +                        adev->pdev->revision == 0xC9) ||
> +                       (adev->pdev->device == 0x7360 &&
> +                        adev->pdev->revision == 0xC7))
> +                       amdgpu_discovery_read_harvest_bit_per_ip(adev,
> +                               &vcn_harvest_count);

Now that we have this code in place, can we drop the hardcoded harvest
settings below?  E.g.,

        if ((adev->pdev->device == 0x731E &&
             (adev->pdev->revision == 0xC6 || adev->pdev->revision == 0xC7)) ||
            (adev->pdev->device == 0x7340 && adev->pdev->revision == 0xC9)  ||
            (adev->pdev->device == 0x7360 && adev->pdev->revision == 0xC7)) {
                adev->harvest_ip_mask |= AMD_HARVEST_IP_VCN_MASK;
                adev->harvest_ip_mask |= AMD_HARVEST_IP_JPEG_MASK;
        }

Looks like the same board variants in both places.

Alex

> +       } else {
>                 amdgpu_disocvery_read_from_harvest_table(adev,
> -                                                       &vcn_harvest_count);
> +                       &vcn_harvest_count);
> +       }
>
>         amdgpu_discovery_harvest_config_quirk(adev);
>
> --
> 2.17.1
>
