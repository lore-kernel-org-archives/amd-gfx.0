Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6218BC433EF
	for <amd-gfx@archiver.kernel.org>; Fri, 29 Apr 2022 20:38:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0385210FA90;
	Fri, 29 Apr 2022 20:38:54 +0000 (UTC)
Received: from mail-oa1-x2c.google.com (mail-oa1-x2c.google.com
 [IPv6:2001:4860:4864:20::2c])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D27AA10FA90
 for <amd-gfx@lists.freedesktop.org>; Fri, 29 Apr 2022 20:38:52 +0000 (UTC)
Received: by mail-oa1-x2c.google.com with SMTP id
 586e51a60fabf-e68392d626so9270662fac.4
 for <amd-gfx@lists.freedesktop.org>; Fri, 29 Apr 2022 13:38:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=8qOqm4QrY4iPrSqElXreY9Jj5ui1As6uPDOW3aBQHl4=;
 b=blo+AePd6hT747riZ6H96xzbcmH3l9rlpYNrhbOfznsCQqRy4IUxBHFwhlz3NN6rI0
 uA1Wix/RVIGfI9BcZEgQb1PD3ahk5ZOd1BWQoiOJDgVLsj+qcv1FNkhTc1qANwiP0dvI
 QIyv6ttk/1Z+/XgBN9WgS+7YDVfm3qJcJBUdPiH0ksQ84B5c8Mhv0j1cdBbXgYJ3mHbx
 V1cIOmJ5L9fA8hyZTWP5hn0vFywgBxGeMl3s+An1NFSiTutO0ONMdYjbrmAPZjqTXVkQ
 2/sUUHvZgPGAQWhr7YAtw53lyCovUTFgeq19QiIwAc26Tv5ozEUmuRWVsgci4E17SBhK
 IZtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=8qOqm4QrY4iPrSqElXreY9Jj5ui1As6uPDOW3aBQHl4=;
 b=38PgxfksMGe8nFHbLoqHzukPwGYJtEyYLRniJc9h+8GRrBwysweI1S7EeRsZZks95v
 tixgAsfAE5lZISUyQBV2aN5TEeapn6Ac2F5SDtCDJUYkwiKH671jfErZnnyJhQJ4tUKb
 XepBriVRWHJ/vu6mRZ1Zo4HA7MPdgHE9VDWf9j011FgDxlKB5MKMGQRcPFVNsd+wTMDT
 5RCUmPt9xvpQG3hKIuouKjRgx9k9ifpPRb0UeHIDkS+sH/Z0Y0w9tiq80fszXavT+W+3
 DpHXD/DvHfQ1NUJJpiMNBT4Z9sWuBjhsSwRuzwlWK467yOBdBfDJ+vuCypDjSPeIz2zd
 hIhg==
X-Gm-Message-State: AOAM531bKtS9Cat4uZkgtE7PrybRFedMIeEP9bZh6xusFTG6pZP/w+dW
 bxdmGoasVzjvhK9ncxbplm0aVM9wE+FAApg7K1xJjzY0
X-Google-Smtp-Source: ABdhPJyfXBeUU9NI5+kLmbP9gxQ2hRMjUK/LyY/8BddLR7Q0L8IsYcmdaX7n4gcc6uQzrkmtGeFdN36zRpDKYOQYdsw=
X-Received: by 2002:a05:6870:d683:b0:de:eaa2:3550 with SMTP id
 z3-20020a056870d68300b000deeaa23550mr516442oap.253.1651264732138; Fri, 29 Apr
 2022 13:38:52 -0700 (PDT)
MIME-Version: 1.0
References: <20220429201546.129362-1-shiwei.wong@amd.com>
In-Reply-To: <20220429201546.129362-1-shiwei.wong@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 29 Apr 2022 16:38:40 -0400
Message-ID: <CADnq5_P-uasH8kJyuF9EfVMyKr94Vj2OXNUD+Tjd9a8G0XWkEg@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu/ucode: Remove firmware load type check in
 amdgpu_ucode_free_bo
To: Alice Wong <shiwei.wong@amd.com>
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

On Fri, Apr 29, 2022 at 4:16 PM Alice Wong <shiwei.wong@amd.com> wrote:
>
> When psp_hw_init failed, it will set the load_type to AMDGPU_FW_LOAD_DIRECT.
> During amdgpu_device_ip_fini, amdgpu_ucode_free_bo checks that load_type is
> AMDGPU_FW_LOAD_DIRECT and skips deallocating fw_buf causing memory leak.
> Remove load_type check in amdgpu_ucode_free_bo.
>
> Signed-off-by: Alice Wong <shiwei.wong@amd.com>

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c
> index ca3350502618..aebafbc327fb 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c
> @@ -714,8 +714,7 @@ int amdgpu_ucode_create_bo(struct amdgpu_device *adev)
>
>  void amdgpu_ucode_free_bo(struct amdgpu_device *adev)
>  {
> -       if (adev->firmware.load_type != AMDGPU_FW_LOAD_DIRECT)
> -               amdgpu_bo_free_kernel(&adev->firmware.fw_buf,
> +       amdgpu_bo_free_kernel(&adev->firmware.fw_buf,
>                 &adev->firmware.fw_buf_mc,
>                 &adev->firmware.fw_buf_ptr);
>  }
> --
> 2.25.1
>
