Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68EB6C433F5
	for <amd-gfx@archiver.kernel.org>; Tue,  5 Apr 2022 13:29:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 061BF10E73D;
	Tue,  5 Apr 2022 13:29:06 +0000 (UTC)
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com
 [IPv6:2607:f8b0:4864:20::236])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9E51910E73D
 for <amd-gfx@lists.freedesktop.org>; Tue,  5 Apr 2022 13:29:04 +0000 (UTC)
Received: by mail-oi1-x236.google.com with SMTP id r8so13392407oib.5
 for <amd-gfx@lists.freedesktop.org>; Tue, 05 Apr 2022 06:29:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=HfDPJG5LQf64pNkAPNuUMKhK3aySagThFn2xNVifFKw=;
 b=OxWpCd3Q9yTAcCSIgo60ecbIlvpcyKkFOY+uDegjpmy5v2KVCmGY/HtMcnBCl4NfRd
 SiP5U3z5+hjeZLFZe7zobI6dxkmwSMw7/MB9pOHo0Tz22naU4z8Q/fsckngvVMxbdO1Y
 J0LL7eQWAzyXgFlnVTGdpwS3W7E5LdFu050V2gSP+lSC77YEANSf5RYox2JOLtlJj4Sj
 10cSue2qIwZJX7WXlp3Xf6uHgCQygaI+gfrfdsYiOicV+jEmdNAp+bFnYBz9XCC0j2Pu
 aV2D47ecZzStkVCjQUthYRB3Jc4ZOcj7Tr+A2XvbbEisEfYxkpUQpFE1iUi7EYEdwa5H
 04XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=HfDPJG5LQf64pNkAPNuUMKhK3aySagThFn2xNVifFKw=;
 b=RWfYoL6TuXD3vGFRo/M2xmDoeuS/WjfO+PXrzN3Wf93zK//bANzDEbb5bUEejj3VS+
 5sPIiS9wJly5M197F0PufOEpLQxg4rNZQcsgFFxGjnT55pxLyfz58EXOZ3uIIHLLvvly
 cjU+cCxuW1pwNJIjkUmdSDTQ5oks8t2VCMhycxg6xiPBB9RbQAxG8CtFm2MD+b0WuvFA
 uuyNC4wUAQWVGShactUWgtSdd6iYG+Ka4kIFlZotbtVwR8F7vSkP5xvKAV0DR4pCKJ/e
 NlgaKBaBbyBdrZyDYmtBrFpuKchZb6XEiRzpJmtYhLOO2/KX/aEW40cF/0WVYSxfrasG
 3q7g==
X-Gm-Message-State: AOAM533wew3CsejjQpvzf58G6NHuWPky3KYK26r5Yf76HO6XqqJ+N/yn
 an8T+Tz/bfogmFGDVeS8D2tuSN4dgpBVvcah3SH/ojdz
X-Google-Smtp-Source: ABdhPJwBlBzpdiG2h9E8J08wAAsSBe3mREeYnHoKHaH2MzaUnlyVVLAHbfIAIgdSaRnfbRpuq6RG7cfqgO/ImmsOKWY=
X-Received: by 2002:a05:6808:df1:b0:2ec:b193:ad6c with SMTP id
 g49-20020a0568080df100b002ecb193ad6cmr1313077oic.200.1649165343970; Tue, 05
 Apr 2022 06:29:03 -0700 (PDT)
MIME-Version: 1.0
References: <20220323210826.1559499-1-info@benjaminmarty.ch>
In-Reply-To: <20220323210826.1559499-1-info@benjaminmarty.ch>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 5 Apr 2022 09:28:53 -0400
Message-ID: <CADnq5_OpdJ6o_EDf4vFyFHXda0yMFPFgsdmHNbs5T416k4pZkg@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu/display: change pipe policy for DCN 2.1
To: Benjamin Marty <info@benjaminmarty.ch>
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

Applied.  Thanks!

Alex

On Wed, Mar 23, 2022 at 5:42 PM Benjamin Marty <info@benjaminmarty.ch> wrote:
>
> Fixes crash on MST Hub disconnect.
>
> Bug: https://gitlab.freedesktop.org/drm/amd/-/issues/1849
> Fixes: ee2698cf79cc ("drm/amd/display: Changed pipe split policy to allow for multi-display pipe split")
> Signed-off-by: Benjamin Marty <info@benjaminmarty.ch>
> ---
>  drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c b/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c
> index e5cc6bf45743..ca1bbc942fd4 100644
> --- a/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c
> +++ b/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c
> @@ -873,7 +873,7 @@ static const struct dc_debug_options debug_defaults_drv = {
>                 .clock_trace = true,
>                 .disable_pplib_clock_request = true,
>                 .min_disp_clk_khz = 100000,
> -               .pipe_split_policy = MPC_SPLIT_DYNAMIC,
> +               .pipe_split_policy = MPC_SPLIT_AVOID_MULT_DISP,
>                 .force_single_disp_pipe_split = false,
>                 .disable_dcc = DCC_ENABLE,
>                 .vsr_support = true,
> --
> 2.35.1
>
