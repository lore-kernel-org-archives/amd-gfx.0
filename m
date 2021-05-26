Return-Path: <SRS0=Zxj3=KV=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B59C6C47088
	for <amd-gfx@archiver.kernel.org>; Wed, 26 May 2021 03:26:37 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8031E61132
	for <amd-gfx@archiver.kernel.org>; Wed, 26 May 2021 03:26:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8031E61132
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2976A6EB78;
	Wed, 26 May 2021 03:26:33 +0000 (UTC)
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com
 [IPv6:2607:f8b0:4864:20::233])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9457F6E484;
 Wed, 26 May 2021 03:26:31 +0000 (UTC)
Received: by mail-oi1-x233.google.com with SMTP id b25so236975oic.0;
 Tue, 25 May 2021 20:26:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=Z2yP+ku7QrjLWJX/oew2T5TuLTAx5mCKhqruiqxpqcQ=;
 b=O3ljL1lRtGVQnjW8rsxilo9NnYYFVfvcU+/khpdunoVIfI4W84MTpwjJpkRuZbfsge
 3iRAMojK5fRFYnr8kf7Bnpgv3HdrtTrqKyui+mPtqtRCkxK+W3ULjS7ao6aDizRBrb1n
 ldhJJ/bd31Fjy/4L7em6LUoHtABC3P9AiHM2xocsyiCcWF+AcRdBDXGc4sque9YUFVx6
 3bR5etFDyuYjjlNQd6SGH4QGj5o8kS2QKh4rDugerss7iwrGzoxfdYpeq0DynpcFnxiJ
 URGMYAaPOXtt9HdNfEzwiOHrpiUP8UjG0ClNE7KwmJPxaU+7Q0QWbREmzQsd12xGANjo
 vmzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Z2yP+ku7QrjLWJX/oew2T5TuLTAx5mCKhqruiqxpqcQ=;
 b=LBPIyyqcL21m/atewRaOFaa3/+blGCqdMEYPStauc43HXXFBlyF5/4Zzmph799Y5S0
 PY+2+ccSflenCcDa9nUyCltqs49dUuccqMo9F7VCcm8dTSbQ7ZJTVg006MVGrpFSkMCv
 RMT0dq3T4A3pF4H4/OK2OhWVHiZAeXMyQCrmuJTTWXH1JJ8KfIE+G6RQWOctk/yBJQZV
 2FGyL8bJeFXPF/uNKvjn+0Yce4O8aGvJRUyt8v2TITJaXwVTLe2gEjOt1PuOrp70dgCg
 ZM+aa2JfpKZlBUxv9yfZ2W8RBrScjJGQ+eG+hHU2w2PimQD3Cz07RzLRCrTf65KbtXE8
 uvTw==
X-Gm-Message-State: AOAM531gLi01OdCK9aR6LFveguCwR5+7Qv8PFgqfOdwotYK0GVa6UdlX
 jvIc2JShO4dDDzytlnpM7G/ESL5txrVYdPYFnZU=
X-Google-Smtp-Source: ABdhPJxEn4U0hetnvUphpr602aW+SAytDbAyj62ON2cN8CxvAmsHRKjnWPf8sPqYl5WXvOCS/SkUjrUOINKlFV1GAME=
X-Received: by 2002:a05:6808:1592:: with SMTP id
 t18mr501125oiw.123.1621999590741; 
 Tue, 25 May 2021 20:26:30 -0700 (PDT)
MIME-Version: 1.0
References: <1621997748-127963-1-git-send-email-yang.lee@linux.alibaba.com>
In-Reply-To: <1621997748-127963-1-git-send-email-yang.lee@linux.alibaba.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 25 May 2021 23:26:19 -0400
Message-ID: <CADnq5_PseP5LDdLY7=v6K7VZ-d_hZW_diuRh721S8gDHmaoYNg@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: Fix kernel-doc
To: Yang Li <yang.lee@linux.alibaba.com>
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
 Maling list - DRI developers <dri-devel@lists.freedesktop.org>, "Deucher,
 Alexander" <alexander.deucher@amd.com>,
 Christian Koenig <christian.koenig@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Tue, May 25, 2021 at 10:56 PM Yang Li <yang.lee@linux.alibaba.com> wrote:
>
> Fix function name in sdma_v5_2.c kernel-doc comment
> to remove a warning found by clang_w1.
>
> drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c:528: warning: expecting prototype
> for sdma_v_0_ctx_switch_enable(). Prototype was for
> sdma_v5_2_ctx_switch_enable() instead.
>
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>

Already fixed:
https://gitlab.freedesktop.org/agd5f/linux/-/commit/ef6f76407cd7796bdeec31305c435162ab54c030

Thanks,

Alex

> ---
>  drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
> index 240596b..db79ee5 100644
> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
> @@ -512,7 +512,7 @@ static void sdma_v5_2_rlc_stop(struct amdgpu_device *adev)
>  }
>
>  /**
> - * sdma_v_0_ctx_switch_enable - stop the async dma engines context switch
> + * sdma_v5_2_ctx_switch_enable - stop the async dma engines context switch
>   *
>   * @adev: amdgpu_device pointer
>   * @enable: enable/disable the DMA MEs context switch.
> --
> 1.8.3.1
>
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
