Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CDBCC433F5
	for <amd-gfx@archiver.kernel.org>; Thu,  5 May 2022 02:22:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 788EB10ED31;
	Thu,  5 May 2022 02:22:09 +0000 (UTC)
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com
 [IPv6:2607:f8b0:4864:20::22d])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2344F10ED31
 for <amd-gfx@lists.freedesktop.org>; Thu,  5 May 2022 02:22:08 +0000 (UTC)
Received: by mail-oi1-x22d.google.com with SMTP id m25so3066109oih.2
 for <amd-gfx@lists.freedesktop.org>; Wed, 04 May 2022 19:22:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=RLwwz1hmLzLVo72mZyQYz/b9Oc0u2pa4zAwGH6/u5uU=;
 b=CKLE1ZWV2K2FBb9mdLIWSEDlsiYf/qfJyvwAqC/zFmiOuTlRdFO5eDo3Ta0N4jNdPd
 J/OTyvkjUSk1ap2/lSp+YQxvKcOOO0hd36Om6D6yCx9pJ+dWPOJSh0lcO15QOHDcSGRg
 25bI9jP/+1WEy4XivRkc1wQd2+PnF+7LMw2z1zk+bgJ46ngHRYf5sevKrqJkqPNKt/MQ
 qPjpLrxD6G2dPVqPnlJe+Iglky5NHIrGSiiIUuLcyXIPIJFmG7BbFX3DuWqwD+gF5vWq
 femEF18bDsKfn56iplHpQGL6bXVl4SUiLG+AB4ss/+Xl0wB9NPctPTq5nARTd0yRbEnM
 v0fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=RLwwz1hmLzLVo72mZyQYz/b9Oc0u2pa4zAwGH6/u5uU=;
 b=WuRn11/zKHxw/L5Rv+YTy9AhFtxIb9Siu2RDn8Kg9VgWib4aQMcqwpD8+j6NrTGVcA
 8TSqYqMRMEfmo9YnnX7d0UcHPyl0MfSCkC467gfoAfdlBmecYqkT3K0VbfSpu1sGE2Jx
 n1unGMoeOImdS9tBYta3knRy9gtBJEz0QP0z2rRWhTu6yvQWmdeub1nxAThKk06gNsiA
 6MiybjCQdZUQiVdmCv7TH+19g//H0kysE+DcWaPAQaBHvExxWeenqJzZW0NuFC3Nn+xL
 92kvUxwjWSifz/4RFn53VB7tBTnm2EDyI6IUfSfruR4hbeGt/FEWk3jVhjFXxW/eblB+
 k4Ig==
X-Gm-Message-State: AOAM5312CIllegpWieO45acqwYOH4C6Im5rb3yi5adjsLmj6jdXbh/7u
 OvMCXY8ePeBZF/bnf2KFVRbc0DtFM8eg0BCHMRe8JeY8
X-Google-Smtp-Source: ABdhPJxu+2GsIhJLXZY16V95WEQCol1QLFozm7PscPSSDe6QvNW0xVPi4qCb5CB75vdJ7d0wx6gc6a44CZ5hgP6NCQU=
X-Received: by 2002:a05:6808:f8d:b0:325:1e81:ffe5 with SMTP id
 o13-20020a0568080f8d00b003251e81ffe5mr1291253oiw.253.1651717327422; Wed, 04
 May 2022 19:22:07 -0700 (PDT)
MIME-Version: 1.0
References: <20220504222414.95884-1-mike@fireburn.co.uk>
 <20220504222414.95884-3-mike@fireburn.co.uk>
In-Reply-To: <20220504222414.95884-3-mike@fireburn.co.uk>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 4 May 2022 22:21:56 -0400
Message-ID: <CADnq5_NafUq9BWuMBJJ-fSAzXP__YQmd2L=mRm5GBOoi7wgJfA@mail.gmail.com>
Subject: Re: [PATCH 2/2] drm/amdgpu/gfx11: Avoid uninitialised variable 'index'
To: Mike Lothian <mike@fireburn.co.uk>
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

Applied the series.  Thanks!

Alex

On Wed, May 4, 2022 at 6:24 PM Mike Lothian <mike@fireburn.co.uk> wrote:
>
> This stops clang complaining:
>
> drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c:376:6: warning: variable 'index' is used uninitialized whenever 'if' condition is true [-Wsometimes-uninitialized]
>         if (ring->is_mes_queue) {
>             ^~~~~~~~~~~~~~~~~~
> drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c:433:30: note: uninitialized use occurs here
>         amdgpu_device_wb_free(adev, index);
>                                     ^~~~~
> drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c:376:2: note: remove the 'if' if its condition is always false
>         if (ring->is_mes_queue) {
>         ^~~~~~~~~~~~~~~~~~~~~~~~~
> drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c:364:16: note: initialize the variable 'index' to silence this warning
>         unsigned index;
>                       ^
>                        = 0
>
> Signed-off-by: Mike Lothian <mike@fireburn.co.uk>
> ---
>  drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> index 141c64636577..c5655128fd9c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> @@ -430,7 +430,8 @@ static int gfx_v11_0_ring_test_ib(struct amdgpu_ring *ring, long timeout)
>                 amdgpu_ib_free(adev, &ib, NULL);
>         dma_fence_put(f);
>  err1:
> -       amdgpu_device_wb_free(adev, index);
> +       if (!ring->is_mes_queue)
> +               amdgpu_device_wb_free(adev, index);
>         return r;
>  }
>
> --
> 2.35.1
>
