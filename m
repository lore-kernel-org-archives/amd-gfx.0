Return-Path: <SRS0=S/Du=4V=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BB06C3F2CD
	for <amd-gfx@archiver.kernel.org>; Wed,  4 Mar 2020 03:53:50 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F07BC2146E
	for <amd-gfx@archiver.kernel.org>; Wed,  4 Mar 2020 03:53:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="HvFSulAc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F07BC2146E
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8F4926E99F;
	Wed,  4 Mar 2020 03:53:49 +0000 (UTC)
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com
 [IPv6:2607:f8b0:4864:20::442])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 031276E95F
 for <amd-gfx@lists.freedesktop.org>; Tue,  3 Mar 2020 21:59:07 +0000 (UTC)
Received: by mail-pf1-x442.google.com with SMTP id j9so2175952pfa.8
 for <amd-gfx@lists.freedesktop.org>; Tue, 03 Mar 2020 13:59:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=ddapSUJt6ntLiYzzjDAEz3gG4fW9QkFbYIQvX7Nl4Wc=;
 b=HvFSulAcRQ9FH1nMyqzV2UlBduKJxbKupcWDMN6FDg342qavq7XRv4+kauubRe7OTf
 tpJHVbvlzT18i/r27rTEYINBnzpXMkhr1uHas5plyxkywdThRYkPbDsuMUaWbmR822aY
 hSNDw3l5DDYqBaG51Km/QULhrlNGyRDPM/LKMOs1/mNfuTyNM66y+opv9NXbB62zcmAF
 Ihu7ymArZ2+Jf1c9TA6FaFHstjgRfeCjxNdCKF5DN0IJS0o0Fm/85jn6TmD7BquCdDdk
 MWPtVQnns4SH1MqLxMGFcngWwdrSDQkOUWeHmcBc2cnJd8Tpp/jqjsVIf6kwSBOUe4HR
 ihZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=ddapSUJt6ntLiYzzjDAEz3gG4fW9QkFbYIQvX7Nl4Wc=;
 b=rg+6G5VeBfjOY3mdNaLkgy2Rle/RumXJeA3O9MrDA1zG8g/Ejpo4PtsDOHd8/UDhJZ
 teBFaaoqoRVjOr56/mjn7UnWVzAw5KhgTjtwZOZ9YHzkIPFmiux2+XYeB7KeGJHKwm4I
 RvCFaQdyz8qwhUMGPQa5Zie0Qn62E5F4g4tgo1z23O4Yk5gC+6HA0FRlFYCXwXI8zhrL
 9DeM61s27aC9mnHH9o/W8/snrMHcrCyO6FwhcKxdr2ueb9k13O5vyKRhTVHL7Mp9em/Y
 oLjrx/w9+/FPfCMUyXeCr0M3nk9pmkneXiP0tgA6wiWhbChKPjheVeX3vwhTmEA9IcAN
 he3w==
X-Gm-Message-State: ANhLgQ2RjmgyOI0iH1T4SBck+01CEutQrO2/pER+fy2dm24JMV3hqRW3
 UgeJx9GCMWxPOVEjIDjgZG4h3/xjOgP4PZXVRwBT1Q==
X-Google-Smtp-Source: ADFU+vuSSO5ovOYN0PsHWrzzb/fJClDu5pNQ9UPGolmosCGXWuIMIFmAgxO6x7bG2Tpjw+xFGeX17CX9X2YpTRcLBuc=
X-Received: by 2002:a63:4e22:: with SMTP id c34mr6056814pgb.263.1583272747246; 
 Tue, 03 Mar 2020 13:59:07 -0800 (PST)
MIME-Version: 1.0
References: <20200302224217.22590-1-natechancellor@gmail.com>
In-Reply-To: <20200302224217.22590-1-natechancellor@gmail.com>
From: Nick Desaulniers <ndesaulniers@google.com>
Date: Tue, 3 Mar 2020 13:58:56 -0800
Message-ID: <CAKwvOdkaiU39xmtEheM=754sdGMTB-sP1GRGacpW4DGkdjugfw@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/display: Remove pointless NULL checks in
 dmub_psr_copy_settings
To: Nathan Chancellor <natechancellor@gmail.com>
X-Mailman-Approved-At: Wed, 04 Mar 2020 03:53:49 +0000
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
Cc: "David \(ChunMing\) Zhou" <David1.Zhou@amd.com>,
 Leo Li <sunpeng.li@amd.com>, LKML <linux-kernel@vger.kernel.org>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>,
 clang-built-linux <clang-built-linux@googlegroups.com>,
 dri-devel <dri-devel@lists.freedesktop.org>,
 Alex Deucher <alexander.deucher@amd.com>,
 Harry Wentland <harry.wentland@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Mon, Mar 2, 2020 at 2:43 PM Nathan Chancellor
<natechancellor@gmail.com> wrote:
>
> Clang warns:
>
> drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dmub_psr.c:147:31: warning:
> address of 'pipe_ctx->plane_res' will always evaluate to 'true'
> [-Wpointer-bool-conversion]
>         if (!pipe_ctx || !&pipe_ctx->plane_res || !&pipe_ctx->stream_res)
>                          ~ ~~~~~~~~~~^~~~~~~~~
> drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dmub_psr.c:147:56: warning:
> address of 'pipe_ctx->stream_res' will always evaluate to 'true'
> [-Wpointer-bool-conversion]
>         if (!pipe_ctx || !&pipe_ctx->plane_res || !&pipe_ctx->stream_res)
>                                                   ~ ~~~~~~~~~~^~~~~~~~~~
> 2 warnings generated.
>
> As long as pipe_ctx is not NULL, the address of members in this struct
> cannot be NULL, which means these checks will always evaluate to false.
>
> Fixes: 4c1a1335dfe0 ("drm/amd/display: Driverside changes to support PSR in DMCUB")
> Link: https://github.com/ClangBuiltLinux/linux/issues/915
> Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>

Indeed, they are not pointers, and no members within `struct
plane_resource` or `struct stream_resource` seem to indicate that they
are somehow invalid.  Good job sleuthing out the correct fixes by tag.
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

> ---
>  drivers/gpu/drm/amd/display/dc/dce/dmub_psr.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/dce/dmub_psr.c b/drivers/gpu/drm/amd/display/dc/dce/dmub_psr.c
> index 2c932c29f1f9..a9e1c01e9d9b 100644
> --- a/drivers/gpu/drm/amd/display/dc/dce/dmub_psr.c
> +++ b/drivers/gpu/drm/amd/display/dc/dce/dmub_psr.c
> @@ -144,7 +144,7 @@ static bool dmub_psr_copy_settings(struct dmub_psr *dmub,
>                 }
>         }
>
> -       if (!pipe_ctx || !&pipe_ctx->plane_res || !&pipe_ctx->stream_res)
> +       if (!pipe_ctx)
>                 return false;
>
>         // First, set the psr version
> --
> 2.25.1
>


-- 
Thanks,
~Nick Desaulniers
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
