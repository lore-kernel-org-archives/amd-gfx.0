Return-Path: <SRS0=AQd/=IN=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DA11C433E0
	for <amd-gfx@archiver.kernel.org>; Mon, 15 Mar 2021 18:27:32 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EAAF264F42
	for <amd-gfx@archiver.kernel.org>; Mon, 15 Mar 2021 18:27:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EAAF264F42
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A6E4589003;
	Mon, 15 Mar 2021 18:27:31 +0000 (UTC)
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com
 [IPv6:2607:f8b0:4864:20::22e])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 46DDC89003;
 Mon, 15 Mar 2021 18:27:31 +0000 (UTC)
Received: by mail-oi1-x22e.google.com with SMTP id w195so28806934oif.11;
 Mon, 15 Mar 2021 11:27:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=YBq3gzSWM4PAYPU03bItAvmuL/jkDE66lmjkbZXjRp8=;
 b=an85zbY+atXgMmpRQQBVfLZXYZx7DbYuH6si3dsaJ4RZ750Mj6Pj9AV8KmzMw8NoBm
 c/6EqiaKL3RPUCd55n0wSCiRx68GVJECcqxYEexFcnhJ2QSIqSKjD/5zZAklkIHyRrd6
 zdb/qGWJL4AtNo0AkKQ4GSqDRNBV4m6edi9Z3YAYZm0v5zJgWW/B/eX7Dk574k4pxXNE
 Q2UPBuzzhaummRHcKdd/AI1MXXqogFcfZHpGxMw3pxfWNkCTb6LiLosFs79FAi/Wdnn0
 REWTqaTseDkF6WuhlPrDigCc9L4gB6Q8waiklbrWRchYn8lCd9/4iKfA04y1LUNKi+JF
 KnVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=YBq3gzSWM4PAYPU03bItAvmuL/jkDE66lmjkbZXjRp8=;
 b=iXDv6E8qIqbu/vyITPGWSJzUbnyU8Xw7HorbDeuJt5pwfklpOHXCAvfRLpWL8apyQG
 bR4S3mfLxHD1MnbEnQhYutsD76lSwQcPcKGONiFjIQjSdn9eU0CaTXBXaUHKMNLRpiMu
 5CB2qGlUzUOkl+8two9CpMDuV2XBCgIv0y1kvvsFGZPUvlDUmFGDcK/faaVNs+ko6bnB
 ZO8ASESoQwowW9882eAoei4edwT+nTdxGIRgWwGMO6OTBiNVacZgV48l1oomeTB4qG5P
 eNWL5CzNWzxnnai3SShYh2+hg7VhFsjw2ilbGgzIOzCAzD1jL2B6ROJzHAj9thr20qm2
 jrNg==
X-Gm-Message-State: AOAM532jU6Y+JUQPwRlCc/BB/zrGFxp2z3UVufKGONdQ+aSKgzLRCBAE
 dYz23JMwYWVidzn/WNyOOhPoVVrhebmSVFsTOatar8+Q
X-Google-Smtp-Source: ABdhPJzUvNXxxTNXCmAj+6pzsw62g0KyCooJD4yymr3eHweuglmQ2mI2iPUzEuPjQMKBqm+SAgUsJOzl+wwI9LYJLSU=
X-Received: by 2002:aca:af10:: with SMTP id y16mr331070oie.120.1615832850600; 
 Mon, 15 Mar 2021 11:27:30 -0700 (PDT)
MIME-Version: 1.0
References: <1615796522-21363-1-git-send-email-jiapeng.chong@linux.alibaba.com>
In-Reply-To: <1615796522-21363-1-git-send-email-jiapeng.chong@linux.alibaba.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 15 Mar 2021 14:27:19 -0400
Message-ID: <CADnq5_MEqZZV1qRWzJM0PefBjCAnEDODzgrXn_8C3qzWqmZJYA@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/display: Remove unnecessary conversion to bool
To: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
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
Cc: "Leo \(Sunpeng\) Li" <sunpeng.li@amd.com>,
 LKML <linux-kernel@vger.kernel.org>,
 Maling list - DRI developers <dri-devel@lists.freedesktop.org>,
 Dave Airlie <airlied@linux.ie>, amd-gfx list <amd-gfx@lists.freedesktop.org>,
 "Deucher, Alexander" <alexander.deucher@amd.com>, "Wentland,
 Harry" <harry.wentland@amd.com>, Christian Koenig <christian.koenig@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Applied.  Thanks!

Alex

On Mon, Mar 15, 2021 at 4:22 AM Jiapeng Chong
<jiapeng.chong@linux.alibaba.com> wrote:
>
> Fix the following coccicheck warnings:
>
> ./drivers/gpu/drm/amd/display/dc/dcn30/dcn30_mpc.c:358:69-74: WARNING:
> conversion to bool not needed here.
>
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
> ---
>  drivers/gpu/drm/amd/display/dc/dcn30/dcn30_mpc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_mpc.c b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_mpc.c
> index 3e6f760..e153109 100644
> --- a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_mpc.c
> +++ b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_mpc.c
> @@ -355,7 +355,7 @@ void mpc3_set_output_gamma(
>                 next_mode = LUT_RAM_A;
>
>         mpc3_power_on_ogam_lut(mpc, mpcc_id, true);
> -       mpc3_configure_ogam_lut(mpc, mpcc_id, next_mode == LUT_RAM_A ? true:false);
> +       mpc3_configure_ogam_lut(mpc, mpcc_id, next_mode == LUT_RAM_A);
>
>         if (next_mode == LUT_RAM_A)
>                 mpc3_program_luta(mpc, mpcc_id, params);
> --
> 1.8.3.1
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
