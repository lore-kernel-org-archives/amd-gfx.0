Return-Path: <SRS0=770C=P7=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 876B1C433F5
	for <amd-gfx@archiver.kernel.org>; Fri, 12 Nov 2021 16:20:12 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 43D6261029
	for <amd-gfx@archiver.kernel.org>; Fri, 12 Nov 2021 16:20:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 43D6261029
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B0C336E0A2;
	Fri, 12 Nov 2021 16:20:11 +0000 (UTC)
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com
 [IPv6:2607:f8b0:4864:20::336])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DCC2E6E158
 for <amd-gfx@lists.freedesktop.org>; Fri, 12 Nov 2021 16:20:10 +0000 (UTC)
Received: by mail-ot1-x336.google.com with SMTP id
 u18-20020a9d7212000000b00560cb1dc10bso14543299otj.11
 for <amd-gfx@lists.freedesktop.org>; Fri, 12 Nov 2021 08:20:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=cW4qawefD/2G/tbbLBs2vqkfiKr4MQsLmJ3B1QMFU9A=;
 b=RXEn4rFdOatq7hPYaogwovT2Dq8pr2uAsyuBtM6akx1nZy+JTKEbIGmUggHYkiS+cR
 qE8XLYG+Z7OecCuicuTOIhQEpVUONldZMWIIyMQqZbsU7wAj9jiSwaVAfWGFyHFxd2a4
 T5G6fT5RooqyuKgQbtZdICH6OED4Z5Xu2X3BBmSacSfbok6upQNLZRXwoCN+cOrn1BaP
 CSYmaY6U4KxH9B0FXppn/MTyt2px6tq6Ti2GXa7YI7vdWJBPkWevYvSKq1tFU3HZbeTj
 m+ghr9Fa5AF1sNgVU6GgIRUSJUAVqzAtu83nSSpbyNTtjDuNhtj9yn3DcuL4Sf8Msowx
 Vjjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=cW4qawefD/2G/tbbLBs2vqkfiKr4MQsLmJ3B1QMFU9A=;
 b=TykJOP+YoSuCzTkIdNVmuovMDgNS51jfcbPl85LCdZ//hGkd4APbjEbfj9+SMq7Csv
 iezX8bVugXWMzXW+s2wN4MroDYL4QshsfLVym373/SHNrNTn3lBGr78H6tmJgNmmTdBV
 il0gli96WAihkxSOdQqW4iaLNV677wdKLUog/Q0IT7KF4kI6dHP8FLcUJyyaSZreH/3r
 R3FfsqAF5wopch+ZwOefJHnz6PE97wBVQnDSzNZ4/yRPJ0cFfpl8FX+gtstwgMWqjx2e
 l5fPzRhm+KJwaU/QmlAxKflmQ42R2bB7fr6OM8lM6ZUZZv6qSsiFsIC7R8ejDdAqFc1X
 hfFA==
X-Gm-Message-State: AOAM531YRAPb7M3usBR0zeJgxk63ewW+woNUpc+vRZkhSRHJmuEac+AW
 49F+eVL4Bv63ZlzeitPBkgGO7UhzOF8s6UoElyb/Gacn
X-Google-Smtp-Source: ABdhPJys48lE40WKRWPDek5IMhhHdzmY6tJnmBjfG88vJbFuZ7oyTSinP3TOMeQu/4aogY7wcwx9DxN4XxMNMQqo0nA=
X-Received: by 2002:a05:6830:1bcf:: with SMTP id
 v15mr13541114ota.200.1636734010121; 
 Fri, 12 Nov 2021 08:20:10 -0800 (PST)
MIME-Version: 1.0
References: <20211112161737.135848-1-alexander.deucher@amd.com>
In-Reply-To: <20211112161737.135848-1-alexander.deucher@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 12 Nov 2021 11:19:59 -0500
Message-ID: <CADnq5_OR7u2FuTbvuysZAHJ+gEso8NzKFaMN3U4fSTOqtft1XQ@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: always reset the asic in suspend
To: Alex Deucher <alexander.deucher@amd.com>
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

Actually, ignore this for now.  This will likely cause problems with S0ix.

Alex

On Fri, Nov 12, 2021 at 11:18 AM Alex Deucher <alexander.deucher@amd.com> wrote:
>
> If the platform suspend happens to fail and the power rail
> is not turned off, the GPU will be in an unknown state on
> resume, so reset the asic so that it will be in a known
> good state on resume even if the platform suspend failed.
>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> index 1db76429a673..42af3d88e0ba 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> @@ -2165,8 +2165,9 @@ static int amdgpu_pmops_suspend(struct device *dev)
>         adev->in_s3 = true;
>         r = amdgpu_device_suspend(drm_dev, true);
>         adev->in_s3 = false;
> -
> -       return r;
> +       if (r)
> +               return r;
> +       return amdgpu_asic_reset(adev);
>  }
>
>  static int amdgpu_pmops_resume(struct device *dev)
> --
> 2.31.1
>
