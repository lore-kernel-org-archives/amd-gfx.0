Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88B72C43334
	for <amd-gfx@archiver.kernel.org>; Mon, 27 Jun 2022 21:40:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2AD9610E9FA;
	Mon, 27 Jun 2022 21:40:56 +0000 (UTC)
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com
 [IPv6:2a00:1450:4864:20::532])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7955310E9FA
 for <amd-gfx@lists.freedesktop.org>; Mon, 27 Jun 2022 21:40:55 +0000 (UTC)
Received: by mail-ed1-x532.google.com with SMTP id fd6so14926842edb.5
 for <amd-gfx@lists.freedesktop.org>; Mon, 27 Jun 2022 14:40:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=nPaD1wyxXxnwTqG4vfRfjz7EAhQ12JPi8iLHYI9BbwQ=;
 b=bzv27uX32g443Z/dSwsKuLzM9AuY36Zp8zAwEmjNAe3rfguJZ0a+sQ7Ssqn49jHjcG
 JFLv5qcUpm6zg9wrUs0METHmgF5/5Ip59V/8WT1C4UZiwwRfNgDP09KgG6UND1Ehkr09
 NgZOtRk+NLUTBauBTpFRF1rLND1oufDVXdYxBiMkgYIbS/ZyrCpM5DnyXGjKU+K1NW7R
 Yy1BPXRsiNcw8Eu1BtDa2Hn8h0KpZ5nFbkN6FLzgg0YKV7hn7pkxj1RjYazfmrXvVYai
 5zzKf9+FniU4rZNFF6S9vMcT/PLDjrVoIGTlJ63q8qXm0fNygAQtbKLZKNbUiuFp/XZx
 78QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=nPaD1wyxXxnwTqG4vfRfjz7EAhQ12JPi8iLHYI9BbwQ=;
 b=SrkvsKfxApwGRZgyqaOzQFYio4/4EcUO4l7SggdZkI5AEZFZtzmsWkMgpKQ+N+Dz8c
 ebRuuI0GoDGEf3b+eUwpyUffxJfIyTyCp8A0VdeHCo2TiCbBEzWC6I2aICK8P6R6t61/
 vVumZmUGofChqA4GiBmncokFEhmDd9bAhHqbzo/XC5vMIf/O8dWjl/zlE4gR45huj3WD
 srZF4muN/s0pXtsGhERcUHB13ruoU3pVyHQVEOibhlhADcYTbr+W6dJKffyIJ979+biI
 rMlcGfZHqYbjkJPUnUuh1efBg00iUraUdmK2WH0UyYeGnoKk1YTx4qVBfHzdKtXURfIN
 wyag==
X-Gm-Message-State: AJIora9Ae2xd3CjYJwkiUYpy5krYy8aC3QYa2aZXxqEbZdbyC1EDJzJr
 BEY8Fdx2KS6HG9E3Lwlf0eeQy6XFIH5CKIqZkpEy8iZR
X-Google-Smtp-Source: AGRyM1s4ZWemcmOp+5058nseonjrCs3viaK736zxrN5lcafIWEMO5E+rT6ftuVbk0lHKQxVrwmSjPNfxfyQp1GmCjbQ=
X-Received: by 2002:a05:6402:50ce:b0:435:9249:dfe9 with SMTP id
 h14-20020a05640250ce00b004359249dfe9mr19067269edb.310.1656366054031; Mon, 27
 Jun 2022 14:40:54 -0700 (PDT)
MIME-Version: 1.0
References: <20220623164113.1503249-1-alexander.deucher@amd.com>
 <20220623164113.1503249-2-alexander.deucher@amd.com>
In-Reply-To: <20220623164113.1503249-2-alexander.deucher@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 27 Jun 2022 17:40:42 -0400
Message-ID: <CADnq5_ML3Hu-fhFigqUHGnArKHY1-n2z=_dzYKkg5kHeXNSu5g@mail.gmail.com>
Subject: Re: [PATCH 2/2] drm/amdgpu: fix documentation warning
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
Cc: Stephen Rothwell <sfr@canb.auug.org.au>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Ping?

On Thu, Jun 23, 2022 at 12:41 PM Alex Deucher <alexander.deucher@amd.com> wrote:
>
> Fixes this issue:
> drivers/gpu/drm/amd/amdgpu/amdgpu_device.c:5094: warning: expecting prototype for amdgpu_device_gpu_recover_imp(). Prototype was for amdgpu_device_gpu_recover() instead
>
> Fixes: cf727044144d ("drm/amdgpu: Rename amdgpu_device_gpu_recover_imp back to amdgpu_device_gpu_recover")
> Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index f2a4c268ac72..6c0fbc662b3a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -5079,7 +5079,7 @@ static inline void amdggpu_device_stop_pedning_resets(struct amdgpu_device *adev
>
>
>  /**
> - * amdgpu_device_gpu_recover_imp - reset the asic and recover scheduler
> + * amdgpu_device_gpu_recover - reset the asic and recover scheduler
>   *
>   * @adev: amdgpu_device pointer
>   * @job: which job trigger hang
> --
> 2.35.3
>
