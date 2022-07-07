Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BAB09C433EF
	for <amd-gfx@archiver.kernel.org>; Thu,  7 Jul 2022 18:47:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EC93E11A6DC;
	Thu,  7 Jul 2022 18:47:23 +0000 (UTC)
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com
 [IPv6:2a00:1450:4864:20::633])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A1B4511A206
 for <amd-gfx@lists.freedesktop.org>; Thu,  7 Jul 2022 18:47:22 +0000 (UTC)
Received: by mail-ej1-x633.google.com with SMTP id ez10so3810375ejc.13
 for <amd-gfx@lists.freedesktop.org>; Thu, 07 Jul 2022 11:47:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=XV/RTfge90lxT6YKY/Eo3wCmVU9M76jJqgLUPUL1r4U=;
 b=BtjriWigRthcrpFiBRbzvU2RDAz/XTSbCzrWKcWjREIpf+ovLZQ03sQrwnkYb2jdX2
 z+YBuQJqKwWo7RcwtknfBpmbi5P5s9H2TmeIa1jGZenEwIFoyVuFvfgqUj2FtG0cz9cj
 rutHe2D9JH03of0svUX44ouHhl2HQ7B7MxNBIDGjel5+GkEaxHKDJ3LjXgoyFXyrDG9l
 9C3JIAM5JSsDokdxzlSgN0JIXFfnCSzMRMkAonkCOEV8965CovYdGx+ThCm+e/8LOA3E
 7K0C1HE0O58Ib2gx6sssYF8CMMY+kKcs1VE6HHmHNaOWvsbtqclTOQSV2t3fMBdoEhhv
 wrfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=XV/RTfge90lxT6YKY/Eo3wCmVU9M76jJqgLUPUL1r4U=;
 b=4TCL/bfPyAGVy1kQ9NJAGur8ilgNGcqrD0m7TCIzUYbqXCDLTIXG6JT7C4ZWraCJcn
 VG+lzfYCqCfXjuVzjlXeH792lvCcPo1s9nBb6EO2p3Cyw5anWsrLXueOfDj+bgBcVHAW
 q7TF0i7uUzUtsb9I5rxsCwwSSovGqUUJhFgXyhP1NtE5/B5rFwqww9Gq06+BVUJQ4AYj
 SWVfGnKJZsj4oEzIQHlJUl2Hm9vIoS+wLR8ZX8fzeOB2tB4BMIKpqm+A2CjLmuj6BAF9
 n6F6FGSxc19jb7z7QgVxJr6cRFxwyjyQaSaXA3G7ItpVd0UBfK5Mn6BrcsVMgBORGA9g
 WjJg==
X-Gm-Message-State: AJIora9+NtJtVOwGE4aNUyXgByBT5lWX0fQa0HuiD0P5y4tOh4Sc9k/X
 vBjEFA8sIJ5q48KiKmtzznbjf/B6OaEHGKyu4ho=
X-Google-Smtp-Source: AGRyM1vXZuU+LktQcXKd7vpRlAcQGzB86zccgjq48xQp0j9Q+EI7IHVrkyL9/ObpH8umkLXnHuImhNGU3FkW0mAvFDg=
X-Received: by 2002:a17:907:2717:b0:72a:fbc7:fdbe with SMTP id
 w23-20020a170907271700b0072afbc7fdbemr9235377ejk.658.1657219641248; Thu, 07
 Jul 2022 11:47:21 -0700 (PDT)
MIME-Version: 1.0
References: <20220707184259.1610514-1-aurabindo.pillai@amd.com>
In-Reply-To: <20220707184259.1610514-1-aurabindo.pillai@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 7 Jul 2022 14:47:09 -0400
Message-ID: <CADnq5_M4XC3kEFZy7Jwep6d-aBVnQ4FX3q7wiMucYA72FEyWUw@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/display: Enable ODM combine default policy
To: Aurabindo Pillai <aurabindo.pillai@amd.com>
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
Cc: "Deucher, Alexander" <alexander.deucher@amd.com>, "Wentland,
 Harry" <Harry.Wentland@amd.com>, "Siqueira,
 Rodrigo" <Rodrigo.Siqueira@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Acked-by: Alex Deucher <alexander.deucher@amd.com>

On Thu, Jul 7, 2022 at 2:43 PM Aurabindo Pillai
<aurabindo.pillai@amd.com> wrote:
>
> [Why&How]
> Output Data Mapping is a power saving feature that allows us to run at
> reduced DPP and DISP clocks compared to what could be achieved with a
> single pipe.
>
> Set the default policy for single display use case to use 2 to 1 ODM combine.
> The options are queried by DC and appropriate register programming sequence
> is initiated to enable this feature.
>
> Fixes: e40fcd4afb3fc ("drm/amd/display: add DCN32/321 specific files for Display Core")
> Signed-off-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
> ---
>  drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c   | 4 +++-
>  drivers/gpu/drm/amd/display/dc/dcn321/dcn321_resource.c | 4 +++-
>  2 files changed, 6 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c
> index 86d1a0785a31..b166ab187264 100644
> --- a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c
> +++ b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c
> @@ -997,7 +997,9 @@ static const struct dc_debug_options debug_defaults_drv = {
>                 }
>         },
>         .use_max_lb = true,
> -       .force_disable_subvp = true
> +       .force_disable_subvp = true,
> +       .enable_single_display_2to1_odm_policy = true,
> +       .enable_dp_dig_pixel_rate_div_policy = 1,
>  };
>
>  static const struct dc_debug_options debug_defaults_diags = {
> diff --git a/drivers/gpu/drm/amd/display/dc/dcn321/dcn321_resource.c b/drivers/gpu/drm/amd/display/dc/dcn321/dcn321_resource.c
> index f8c9aceb2e85..f0eff4c94616 100644
> --- a/drivers/gpu/drm/amd/display/dc/dcn321/dcn321_resource.c
> +++ b/drivers/gpu/drm/amd/display/dc/dcn321/dcn321_resource.c
> @@ -994,7 +994,9 @@ static const struct dc_debug_options debug_defaults_drv = {
>                 }
>         },
>         .use_max_lb = true,
> -       .force_disable_subvp = true
> +       .force_disable_subvp = true,
> +       .enable_single_display_2to1_odm_policy = true,
> +       .enable_dp_dig_pixel_rate_div_policy = 1,
>  };
>
>  static const struct dc_debug_options debug_defaults_diags = {
> --
> 2.37.0
>
