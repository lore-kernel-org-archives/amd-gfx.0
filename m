Return-Path: <SRS0=FlJ6=I6=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE1D0C4161D
	for <amd-gfx@archiver.kernel.org>; Thu,  1 Apr 2021 18:17:49 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7F297611CE
	for <amd-gfx@archiver.kernel.org>; Thu,  1 Apr 2021 18:17:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F297611CE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3D3886ECFB;
	Thu,  1 Apr 2021 18:17:49 +0000 (UTC)
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com
 [IPv6:2607:f8b0:4864:20::329])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B99E36ECFB
 for <amd-gfx@lists.freedesktop.org>; Thu,  1 Apr 2021 18:17:48 +0000 (UTC)
Received: by mail-ot1-x329.google.com with SMTP id
 g8-20020a9d6c480000b02901b65ca2432cso2932967otq.3
 for <amd-gfx@lists.freedesktop.org>; Thu, 01 Apr 2021 11:17:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=DAty5ReERIgZgLrVcWtowIpdJ97mXwcseEghuyz78qQ=;
 b=s2zEwwK0X1kqhYdRqTkprLj3z9Ap1/PMJOcvQIWsMonIYWSZV4EhTZ8yaVsgziIG55
 2ZaLC+9+VPB8h4/JkOW6gq0S7FBzszl3n4ReHUuzjwZ5wBKckQkJBxeWBAbNNDxTScps
 jg/yCczXTns0nK3bW4iZChKLqzXDt8cfXVk6SgbsPiAjM5wSgpBJcONu6f1HyAIV3Suk
 SGJT9COcxzsfYqWgrsoAKcv1GbqREtowbwUTCSuUg1v93JRAWOI8cZwZNPtiL/eHguMf
 7/JQZdZW6JtKN9fWjV1jbfBFffrjRiUz6UOjIMhdksjdRbqBiwWfLNz/SdYWSBenklhI
 C/7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=DAty5ReERIgZgLrVcWtowIpdJ97mXwcseEghuyz78qQ=;
 b=UZlOHrXx7VmMXn+lmIO4PNMM1Dr2SshDNS2ZKbiKQlVQFSG0azJpagyd5wH3BVfeWN
 pemkDSj1Bwbs7SjwhH+y4h4Mcy6EKbAY1GMqNfQ42Kpcv2djVqiDg6dS0xeSLMnWGLk3
 4gdUTxMpbfFkxU5ZwE46JvSd2gLUfeMsCvdyio4rggFh594+MD1AcM7WPZjK92rh4RYN
 pW0dIHxisSzNvatGiqGuz3iS/7wj7cDHNMPmvJI7OsAtwvKACSWe060Mk9RpfDkD2iLJ
 PSmd1/sr4Y3hSA2d+DmylyWDlQDn3ObnCSOQ8Cyrm9Z55CsTpjTQpeDjYpTZ/6OifD8d
 2GCA==
X-Gm-Message-State: AOAM531oqefeLWCwUdBcBNNnV3RhyLLCR+/+U5jD3LX9/7yCWCxCHTCR
 gqFGBqv1d0POhBJE29vKPh3ZVmgkaooOvaM0y/LC+EYEeMo=
X-Google-Smtp-Source: ABdhPJxNBeILnGvl6gUOKLX5PhfUMtm3bIDwRzfc98Wn505kp/oZew+XsoRI3Udj2ZM4t9cQ8dJERGMCGHv/gvLpy+8=
X-Received: by 2002:a9d:7288:: with SMTP id t8mr8351172otj.132.1617301068037; 
 Thu, 01 Apr 2021 11:17:48 -0700 (PDT)
MIME-Version: 1.0
References: <20210331022810.2590493-1-alexander.deucher@amd.com>
In-Reply-To: <20210331022810.2590493-1-alexander.deucher@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 1 Apr 2021 14:17:36 -0400
Message-ID: <CADnq5_MWsDKbn+k5Rr1UTmYxKcjhfD+vo7=M7zBLX8hMi1hfLQ@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu/display: guard ttu_regs with
 CONFIG_DRM_AMD_DC_DCN
To: Alex Deucher <alexander.deucher@amd.com>, Harry Wentland <hwentlan@amd.com>,
 "Siqueira, Rodrigo" <Rodrigo.Siqueira@amd.com>
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
 Wesley Chalmers <Wesley.Chalmers@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Ping?

On Tue, Mar 30, 2021 at 10:28 PM Alex Deucher <alexander.deucher@amd.com> wrote:
>
> Missing check for CONFIG_DRM_AMD_DC_DCN.
>
> Fixes: 752106f5c5cd ("drm/amd/display: Set max TTU on DPG enable")
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> Cc: Wesley Chalmers <Wesley.Chalmers@amd.com>
> Cc: Stephen Rothwell <sfr@canb.auug.org.au>
> ---
>  drivers/gpu/drm/amd/display/dc/core/dc.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
> index d9ab134a178f..a270879cbaba 100644
> --- a/drivers/gpu/drm/amd/display/dc/core/dc.c
> +++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
> @@ -2599,6 +2599,7 @@ static void commit_planes_for_stream(struct dc *dc,
>                 }
>         }
>
> +#ifdef CONFIG_DRM_AMD_DC_DCN
>         if (stream->test_pattern.type != DP_TEST_PATTERN_VIDEO_MODE) {
>                 struct pipe_ctx *mpcc_pipe;
>                 struct pipe_ctx *odm_pipe;
> @@ -2607,7 +2608,7 @@ static void commit_planes_for_stream(struct dc *dc,
>                         for (odm_pipe = mpcc_pipe; odm_pipe; odm_pipe = odm_pipe->next_odm_pipe)
>                                 odm_pipe->ttu_regs.min_ttu_vblank = MAX_TTU;
>         }
> -
> +#endif
>
>         if ((update_type != UPDATE_TYPE_FAST) && stream->update_flags.bits.dsc_changed)
>                 if (top_pipe_to_program->stream_res.tg->funcs->lock_doublebuffer_enable) {
> --
> 2.30.2
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
