Return-Path: <SRS0=majj=GJ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86C14C433E0
	for <amd-gfx@archiver.kernel.org>; Wed,  6 Jan 2021 19:47:04 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 414FD23132
	for <amd-gfx@archiver.kernel.org>; Wed,  6 Jan 2021 19:47:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 414FD23132
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D87936E215;
	Wed,  6 Jan 2021 19:47:03 +0000 (UTC)
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com
 [IPv6:2607:f8b0:4864:20::22f])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DF87F6E215
 for <amd-gfx@lists.freedesktop.org>; Wed,  6 Jan 2021 19:47:02 +0000 (UTC)
Received: by mail-oi1-x22f.google.com with SMTP id 15so4708986oix.8
 for <amd-gfx@lists.freedesktop.org>; Wed, 06 Jan 2021 11:47:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=EcuR2m34d+LEwDpwRySSgmlj7QNdml6FPx9oB2il9us=;
 b=m4vnPdNw8zFAgXtL4AcDG53ZGvjEpYdWDw0AcTKpZNJXPsAd6JxlXSpFu0ENj1DeK1
 l55K0G/rohwJrRo3rnK//KQx8HW3De84DWoNXNTdl7W6t8Hw4ynW89XjSqQFOn82MLE7
 rzi5sN2h2HxbxEcDJoXV8LD5D03E5mVFRpwnprMkQTeInPGirEYVe7QR2DDx9hXC7/TO
 9sCQXbaKA5zKmDUUkGZZeHT7t/BM2rnB2atHdxkQUIKYH3zutuAgy1N5HNj1KVoyTZXO
 u2zxuenHahCWz9ba4wj8CGSzqbZiRIyajvriOz6D6BqY1dQaY+1fbXp98xcajDAAPLp1
 KhaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=EcuR2m34d+LEwDpwRySSgmlj7QNdml6FPx9oB2il9us=;
 b=PrKqf7zd/k7fUnzi3PqsbXJFCBZ3PNvuULI//KWiwgu7/Xx2qethfC4pmLiItZKqmI
 N7DRSTzhxa/0G4lvH5tMmsmEegqn4hvMYaSxv5ZcDSUqOLN13Z/uuv1HQE4ihUG3Jt5q
 yspgLVDf4T06o5KrftrA0y7fTrQZaQp+ZJIKMmjUCCuVdm2vBAp0X88sIR1dqGAN6JQC
 e2j0SDZW/Vr2A2nAcBXFx0BKGfYz07oO3PQiTTSk3G5DZAqUt8QgWo4acbun/RvFF6ZT
 htHaW0BE4rf9ba27BBnFypr44ouLmulQHs3MX9ZM1NYcu77Ii+mIHSJHD+fxrfggq03z
 t2Pg==
X-Gm-Message-State: AOAM5328ho5i1/IGoZqgJqMbSs+cqBuOoax03d7tkExcZhFtdpvd81pR
 arMALa3twTu9QLqkET9Nrz5g3VJ/lfcSUsiYztIvG2czfhc=
X-Google-Smtp-Source: ABdhPJzUpwKV31GZNarf1Ceb96d6ZKst319iPyjan/AzAKipltrismnuSnjeee1XJEm8R7nSwW7XjExgk6mBwZMQqAo=
X-Received: by 2002:a54:4083:: with SMTP id i3mr4262491oii.120.1609962422357; 
 Wed, 06 Jan 2021 11:47:02 -0800 (PST)
MIME-Version: 1.0
References: <20210106010515.486545-1-Emily.Deng@amd.com>
 <20210106010515.486545-2-Emily.Deng@amd.com>
In-Reply-To: <20210106010515.486545-2-Emily.Deng@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 6 Jan 2021 14:46:51 -0500
Message-ID: <CADnq5_Mm=pJTW2e1cR6kRfTT2xbB44SHz3=8Ug63z_KfJDBO4w@mail.gmail.com>
Subject: Re: [PATCH 2/3] drm/amdgpu: Correct the read sclk for navi10
To: "Emily.Deng" <Emily.Deng@amd.com>
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Tue, Jan 5, 2021 at 8:05 PM Emily.Deng <Emily.Deng@amd.com> wrote:
>
> According to hw, after navi10,it runs in dfll mode, and should
> read sclk from AverageGfxclkFrequency.
>
> Signed-off-by: Emily.Deng <Emily.Deng@amd.com>

Acked-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
> index 51e83123f72a..7ebf9588983f 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
> @@ -1673,7 +1673,7 @@ static int navi10_read_sensor(struct smu_context *smu,
>                 *size = 4;
>                 break;
>         case AMDGPU_PP_SENSOR_GFX_SCLK:
> -               ret = navi10_get_current_clk_freq_by_table(smu, SMU_GFXCLK, (uint32_t *)data);
> +               ret = navi10_get_smu_metrics_data(smu, METRICS_AVERAGE_GFXCLK, (uint32_t *)data);
>                 *(uint32_t *)data *= 100;
>                 *size = 4;
>                 break;
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
