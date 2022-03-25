Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A33BC433EF
	for <amd-gfx@archiver.kernel.org>; Fri, 25 Mar 2022 18:11:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2FDD010E928;
	Fri, 25 Mar 2022 18:11:27 +0000 (UTC)
Received: from mail-oa1-x35.google.com (mail-oa1-x35.google.com
 [IPv6:2001:4860:4864:20::35])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2F70F10E928
 for <amd-gfx@lists.freedesktop.org>; Fri, 25 Mar 2022 18:11:26 +0000 (UTC)
Received: by mail-oa1-x35.google.com with SMTP id
 586e51a60fabf-de2cb87f6aso8856818fac.10
 for <amd-gfx@lists.freedesktop.org>; Fri, 25 Mar 2022 11:11:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=tzPicqx5MvcbPKYAltxjlt/7wo3zOpeo9BOLhP9vFDA=;
 b=RT7R9snssOhIwTQMVvuIyBP280nP/9qeHidghpg/W9SNj41/gphvv9Zi+ELhBoc2Xn
 3XCe9htwF8KFsuVl2+XrVbSNtsD28BJE72Hw/z/c8SMCVElfaw2tFyPKpNKaHD9f1NYn
 EwgNG7ztdu3wgccifvc83SqhF7XNwt5ohtPznIlmL5YOzp0d/1bJzL+jizqNqPIIK1I5
 OaXBG7yANSh62aBvKXGelUEXFIBGir0FMDFSEX4Q1SC5Grzkgoi3LRsQ8ym2pbyJr5g4
 e1xKUrwF7S7pcrFygk+7O1zFNigVdcVwaZAngDdF/U/zhsUptlKUVdSuFDyRHz21TFnZ
 iGSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=tzPicqx5MvcbPKYAltxjlt/7wo3zOpeo9BOLhP9vFDA=;
 b=yQiLXLQlDm9brryWoqFkFoGXH/GkXNPjzfH3wmM45BEX0h6p321wpJveOZlCLhL5g9
 qv/EuViuRZD1CxghfEfTOKWzNCkcc+dMyL7LavXYNTt6DEZ+lI2FgaxFO6m9OA2NbRfB
 KW72jSfmXUxBCVMCJReWRM1F0HlygS5A+aLbZjqO+TlZGfYmRQqzm0ouePqlAHunUyOY
 JF+pJGIQIt0KzRcDAK4QOjuxk19z2r7fqle7RWqowfsLrSGKucGPRv1g18m4Zhh79JZo
 4RnwXgO1IfR041o95C472mz+3TuvjXpVlCw5GtCo/GzG8m4BKTTX9G4niwo1lEAco655
 7r1A==
X-Gm-Message-State: AOAM533NQx+TbqIoGInEf27oX0ZYHezb7oEaGyWtYlKLzyrEelu+zraz
 o2hU3ZMtKUAs1Gbg5iOk4V0lbciOH4q2NFNtY+U=
X-Google-Smtp-Source: ABdhPJwc2M73j0Hufxy76skeixvseyWtePqnGvoKmpBkac3a7uj6O7MkPWZzoHw7wXfhif2RrICTNRNftZ0PvBfnr9g=
X-Received: by 2002:a05:6870:630c:b0:da:b3f:324d with SMTP id
 s12-20020a056870630c00b000da0b3f324dmr5608234oao.253.1648231885432; Fri, 25
 Mar 2022 11:11:25 -0700 (PDT)
MIME-Version: 1.0
References: <20220323211801.1569848-1-info@benjaminmarty.ch>
In-Reply-To: <20220323211801.1569848-1-info@benjaminmarty.ch>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 25 Mar 2022 14:11:14 -0400
Message-ID: <CADnq5_Pr=FvJoqeLoyx7A6pr_fr9NZi9e8BfgrnVeVLt_BSbFw@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu/display: change pipe policy for DCN 2.1
To: Benjamin Marty <info@benjaminmarty.ch>, "Siqueira,
 Rodrigo" <Rodrigo.Siqueira@amd.com>, 
 "Wheeler, Daniel" <Daniel.Wheeler@amd.com>
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

@Wheeler, Daniel
 @Siqueira, Rodrigo were you able to repro this?  Any ideas?  Any
downsides to picking this up for now?

Alex

On Wed, Mar 23, 2022 at 5:18 PM Benjamin Marty <info@benjaminmarty.ch> wrote:
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
