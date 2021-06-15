Return-Path: <SRS0=xdlw=LJ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB6A6C48BE5
	for <amd-gfx@archiver.kernel.org>; Tue, 15 Jun 2021 14:01:06 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7827761477
	for <amd-gfx@archiver.kernel.org>; Tue, 15 Jun 2021 14:01:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7827761477
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E09B689C08;
	Tue, 15 Jun 2021 14:01:05 +0000 (UTC)
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com
 [IPv6:2607:f8b0:4864:20::330])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6AB0789C08
 for <amd-gfx@lists.freedesktop.org>; Tue, 15 Jun 2021 14:01:05 +0000 (UTC)
Received: by mail-ot1-x330.google.com with SMTP id
 h24-20020a9d64180000b029036edcf8f9a6so14368121otl.3
 for <amd-gfx@lists.freedesktop.org>; Tue, 15 Jun 2021 07:01:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=STBRHc+kC9mclTnv0334YdVt+gdugpg23qTGg/GjvFg=;
 b=GRowioW1Jix33NCz8ttVZ4eMbC3W68hO2hfixTsQX8IvgChBOOdHYpglUtTG3AnXFw
 H8pPV06HkkGNSzvOm1y3U+69tbBysYmEk2IOByhuh5RhRnY3btUgCZxsxpjInT4oCdpb
 Y2ZRGzoeD5WI8EMzaUvOAVQkS6rOS0VMILknRk8VbwLMvBxm7BnWhHMm5tI/Qm3hFJB2
 nqyoSX1jBsQwmAZ/m0qnCnFUdUjYNG+a/K+Z4PdaTVS6+Q5Es9Z2hJd2qN5EY7DZ8VGj
 Yo5LiL+MuLYrCDHLPae+tLqqEMtPUPleYl26eebJozLroyHlMyN4jOurvXydfZE0KGkq
 UG3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=STBRHc+kC9mclTnv0334YdVt+gdugpg23qTGg/GjvFg=;
 b=TLJZtL67T/vmStWULKPFEfcnC2tRBCzIe19iQkc5TxDQXXG5lX1xmTtmDYLKwqqSld
 R0Kl+T0CTj3B+0OTkqlzMLCr7wa8EFuEcCRqSSMh2joGI4I+TQ6cymvNaAZXwJyo5qSQ
 sR+n6gEVKLf3kjR6K6oS/dMSK0X9nWeU32Ccl9rmz6x2x8FymdwjZRCSs7iR483RxPfQ
 MWDChrDe81ANB2tpxHJyoTUlYr/TaqnaGfdIYIYVXxB/9AvhfXgq27o0DN1bNVUrTPr2
 ypdnUhgAcElAzCPcdqp81NR0zEvM1wDlMRc/F95t/1d/7FLHn/TtMgRrV8HsZV+XvONX
 ZwcQ==
X-Gm-Message-State: AOAM531fQOezzcVJME3ASdDnXDsstNY/Q5fKGhY8LC612Dh9BU4kA9CT
 sX/+OFzvNkEGvOxX7DkECAF1riEdrLvK0cmsHQQ=
X-Google-Smtp-Source: ABdhPJyMwMhJcEyZrGnq3vtdyg4gBxw04SaB0f/8nnt6h0r5WSxi05KdNRJNRNsmCcWPuiKeUXKDDDXqi9fex6XY2h4=
X-Received: by 2002:a9d:6287:: with SMTP id x7mr18576575otk.132.1623765664463; 
 Tue, 15 Jun 2021 07:01:04 -0700 (PDT)
MIME-Version: 1.0
References: <20210615100412.1334220-1-yifan1.zhang@amd.com>
In-Reply-To: <20210615100412.1334220-1-yifan1.zhang@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 15 Jun 2021 10:00:53 -0400
Message-ID: <CADnq5_N0KWkUxpwVK+Dcq0SFb-n3wiAPkDZyiHNxdwW99AuNvA@mail.gmail.com>
Subject: Re: [PATCH 1/2] drm/amdgpu/gfx9: fix the doorbell missing when in
 CGPG issue.
To: Yifan Zhang <yifan1.zhang@amd.com>
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
Cc: Felix Kuehling <Felix.Kuehling@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Series is:
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

On Tue, Jun 15, 2021 at 6:04 AM Yifan Zhang <yifan1.zhang@amd.com> wrote:
>
> If GC has entered CGPG, ringing doorbell > first page doesn't wakeup GC.
> Enlarge CP_MEC_DOORBELL_RANGE_UPPER to workaround this issue.
>
> Signed-off-by: Yifan Zhang <yifan1.zhang@amd.com>
> Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> index 044076ec1d03..922420a2c102 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> @@ -3675,8 +3675,12 @@ static int gfx_v9_0_kiq_init_register(struct amdgpu_ring *ring)
>         if (ring->use_doorbell) {
>                 WREG32_SOC15(GC, 0, mmCP_MEC_DOORBELL_RANGE_LOWER,
>                                         (adev->doorbell_index.kiq * 2) << 2);
> +               /* If GC has entered CGPG, ringing doorbell > first page doesn't
> +                * wakeup GC. Enlarge CP_MEC_DOORBELL_RANGE_UPPER to workaround
> +                * this issue.
> +                */
>                 WREG32_SOC15(GC, 0, mmCP_MEC_DOORBELL_RANGE_UPPER,
> -                                       (adev->doorbell_index.userqueue_end * 2) << 2);
> +                                       (adev->doorbell.size - 4));
>         }
>
>         WREG32_SOC15_RLC(GC, 0, mmCP_HQD_PQ_DOORBELL_CONTROL,
> --
> 2.25.1
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
