Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F525C433EF
	for <amd-gfx@archiver.kernel.org>; Tue, 24 May 2022 13:19:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D5C2410ECDD;
	Tue, 24 May 2022 13:19:57 +0000 (UTC)
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com
 [IPv6:2607:f8b0:4864:20::231])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D4B0610ECDD
 for <amd-gfx@lists.freedesktop.org>; Tue, 24 May 2022 13:19:55 +0000 (UTC)
Received: by mail-oi1-x231.google.com with SMTP id s188so17554704oie.4
 for <amd-gfx@lists.freedesktop.org>; Tue, 24 May 2022 06:19:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=g3umjpRng4x2/ojsEM5WPMn4tD1tKrjOQCCa/rws3ao=;
 b=aeGSlZt2IYNOlGCVSbEdMEu2buF5hn10W7T4o7x9Oea1Sqi/cV1Lxs1JYsc9XSYsXd
 HaCtWUuqZNsRLXv7LqxEr8YwhF+ZxX3/QwW/6S49qODsTpDM+AzI8HsvcNPcq1bRQFbO
 UW9TTJfZ9g/4recfPr+EkncYH0tqFPDOxTMJt2oiDLo0owoT0etTwN1+b2JOwnOk1Rso
 DlZLtMpIrIo+XGjPLerMLy3OxbitrasmZYtHL+67OlUCzJoTH5k8Vor1apfU4oUDmPv0
 w146ar4OJqEq/H56Vw7jlR+KS9XNsg5P5/w6wRIbsJ1X3NHJexjA29nu52hMn8udestq
 nyOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=g3umjpRng4x2/ojsEM5WPMn4tD1tKrjOQCCa/rws3ao=;
 b=vR3fqG0RuBOaBnCvF2vgSlKiA6dQ9an2iDgHMjybpz8raEZZ6OLAh83pkOLIzv0zV0
 nLv9zZhW5OowwLb2CJ3JaSUCWSRPrmxDUGPpEJ3zHm5YlQBvuTnEZp2GS0rvYPC8/80f
 bNxnad9K/6bOw8ZbRXbZdzY7KnXACZ+QpTE6dUCb+LxC5b4Eowv1XTZ4VBa2/2Ngams3
 BHcwUC7WA803bjJgRASIZ067KtC61MRw9ggOPbUhFoqIFFkgFFoO/Vd1lSjj0cxCeoiC
 9iiwRnYHj++dDcBK6j4CIwoAyFQfn3gFKJboGLkupTWKipTaY4+6CMurdeuu2cB1S0H+
 YHUQ==
X-Gm-Message-State: AOAM530UOgl/YFYmfppOW+6p5hbtCRVHT7AMoxJLt9EewGHTZqWETY2k
 m0kW5G/MIEWlqwehyge9mqvqzAzilePKc/OL+cw=
X-Google-Smtp-Source: ABdhPJxuQ2k2NcraqIWji8MYYaQ0pKDIpa4uIACxoFxniEK9wHOgN/lJwY5PudBB06OTmQqUoYzf9uf3ytxPZBXWzj8=
X-Received: by 2002:a05:6808:114f:b0:32b:1be0:2316 with SMTP id
 u15-20020a056808114f00b0032b1be02316mr2186959oiu.200.1653398393946; Tue, 24
 May 2022 06:19:53 -0700 (PDT)
MIME-Version: 1.0
References: <20220524123614.1487039-1-lijo.lazar@amd.com>
In-Reply-To: <20220524123614.1487039-1-lijo.lazar@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 24 May 2022 09:19:43 -0400
Message-ID: <CADnq5_MHNLHuxLrKheqgcB4_AsaVGrJRGB+1y7LgbHLnV=4ftw@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/pm: Return auto perf level, if unsupported
To: Lijo Lazar <lijo.lazar@amd.com>
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Tue, May 24, 2022 at 8:36 AM Lijo Lazar <lijo.lazar@amd.com> wrote:
>
> When powerplay is not enabled, return AUTO as default level.
>
> Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
> ---
>  drivers/gpu/drm/amd/pm/amdgpu_dpm.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
> index 5472f9936feb..d1bf073adf54 100644
> --- a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
> +++ b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
> @@ -770,6 +770,9 @@ enum amd_dpm_forced_level amdgpu_dpm_get_performance_level(struct amdgpu_device
>         const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
>         enum amd_dpm_forced_level level;
>
> +       if (!pp_funcs)
> +               return AMD_DPM_FORCED_LEVEL_AUTO;

Maybe LOW?  Either way,
Acked-by: Alex Deucher <alexander.deucher@amd.com>

> +
>         mutex_lock(&adev->pm.mutex);
>         if (pp_funcs->get_performance_level)
>                 level = pp_funcs->get_performance_level(adev->powerplay.pp_handle);
> --
> 2.25.1
>
