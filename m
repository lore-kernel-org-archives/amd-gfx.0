Return-Path: <SRS0=drzA=JM=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3C88C433ED
	for <amd-gfx@archiver.kernel.org>; Thu, 15 Apr 2021 14:26:50 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8075661139
	for <amd-gfx@archiver.kernel.org>; Thu, 15 Apr 2021 14:26:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8075661139
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B200C6EA53;
	Thu, 15 Apr 2021 14:26:49 +0000 (UTC)
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com
 [IPv6:2a00:1450:4864:20::129])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8128B6EA57
 for <amd-gfx@lists.freedesktop.org>; Thu, 15 Apr 2021 14:20:31 +0000 (UTC)
Received: by mail-lf1-x129.google.com with SMTP id x20so9189289lfu.6
 for <amd-gfx@lists.freedesktop.org>; Thu, 15 Apr 2021 07:20:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=cDaxPwwJbb7rxMzKv1tcvmFJzfDrxU+w+RYuKxeoCgU=;
 b=Z9K5+6adgUmm31o6zFSeBSVPJbr7vfDI36Bkm4ktl1K1S1tmUs6RbG+b/6aUZcQbTz
 gT6DWlFa3CsDPJUo7SQbBFGqF6aoqjBC66M6dCLZKJUAP4w0q1wmoS2NK+Gu8esV2Ypy
 UCwQ9OlDkd9A/XRKjIA+PIO1GR3+bF/F130l4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=cDaxPwwJbb7rxMzKv1tcvmFJzfDrxU+w+RYuKxeoCgU=;
 b=qmwPnPMOZIlu8mr3aSWxuVRa8KHfxhwrEx2kt31h4kIyNZHkGq3zQLB02AR+iBBsb6
 wY17e1p5u6J3Q3c614oCtG1nKUuscn9vST4nHd60y3M+jqYcMLwasretU6Grb5vgijz8
 Jjm0hzVVXDqd3RnOpCtnIWkXfzWbQ8ile/NbYu4eIAZ6oQq/jY/U672xmbPt1340Mtcz
 vccuBYQd/ign2IbhkoRF0LobW3bFq16kk1eX1kgEwv8ViUrwD8pmy75SDcXUjABr1nyu
 emfLIPmjPRfZXWBsYiCDRDha6XyUQDV5DrSlmvrq3RNss33FmKLzUK3eZOMK6q4SMY+4
 WOvA==
X-Gm-Message-State: AOAM533I5vZcNfwtKhUlFzqGxuXNul1nzKV5SI4s2vd5hu44FkhURC8x
 c3ms3T+eSYBZ5WqeE/rzL4J9jYR2IEEuAdVqwFffJg==
X-Google-Smtp-Source: ABdhPJzA/7o0Q8zfJb2aDTqlzQBmr9F0kFrcThsMg+OoE7sBel4uN/6iUYWEUXx39j/z74JrdKCwOLvRF6T/5pckA6g=
X-Received: by 2002:ac2:5302:: with SMTP id c2mr2885830lfh.75.1618496429908;
 Thu, 15 Apr 2021 07:20:29 -0700 (PDT)
MIME-Version: 1.0
References: <20210414233533.24012-1-qingqing.zhuo@amd.com>
 <20210414233533.24012-2-qingqing.zhuo@amd.com>
In-Reply-To: <20210414233533.24012-2-qingqing.zhuo@amd.com>
From: Mark Yacoub <markyacoub@chromium.org>
Date: Thu, 15 Apr 2021 10:20:18 -0400
Message-ID: <CAJUqKUpvTZ0Z+afrVZb1pgu7Z1Oi1St2fUs_ac39bf79xOcBJQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] Revert "Revert "drm/amdgpu: Ensure that the modifier
 requested is supported by plane.""
To: Qingqing Zhuo <qingqing.zhuo@amd.com>
X-Mailman-Approved-At: Thu, 15 Apr 2021 14:26:49 +0000
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
Cc: Rodrigo.Siqueira@amd.com, amd-gfx list <amd-gfx@lists.freedesktop.org>,
 daniel.wheeler@amd.com, Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>, "Deucher,
 Alexander" <alexander.deucher@amd.com>, nicholas.kazlauskas@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

looks like a safe reland to me. lgtm.

On Wed, Apr 14, 2021 at 7:35 PM Qingqing Zhuo <qingqing.zhuo@amd.com> wrote:
>
> This reverts commit bc3e72b3c3f20ab1583a8464e64f1a68169a28c5.
>
> The regression caused by the original patch has been
> cleared, thus introduce back the change.
>
> Signed-off-by: Qingqing Zhuo <qingqing.zhuo@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_display.c    | 13 +++++++++++++
>  .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c  | 18 +++++++++++++++---
>  2 files changed, 28 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
> index 6304a49b02fd..0f17984fdea4 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
> @@ -908,6 +908,19 @@ int amdgpu_display_gem_fb_verify_and_init(
>                                          &amdgpu_fb_funcs);
>         if (ret)
>                 goto err;
> +       /* Verify that the modifier is supported. */
> +       if (!drm_any_plane_has_format(dev, mode_cmd->pixel_format,
> +                                     mode_cmd->modifier[0])) {
> +               struct drm_format_name_buf format_name;
> +               drm_dbg_kms(dev,
> +                           "unsupported pixel format %s / modifier 0x%llx\n",
> +                           drm_get_format_name(mode_cmd->pixel_format,
> +                                               &format_name),
> +                           mode_cmd->modifier[0]);
> +
> +               ret = -EINVAL;
> +               goto err;
> +       }
>
>         ret = amdgpu_display_framebuffer_init(dev, rfb, mode_cmd, obj);
>         if (ret)
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index c3cbc3d298e7..11cd441c033f 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -4306,6 +4306,7 @@ static bool dm_plane_format_mod_supported(struct drm_plane *plane,
>  {
>         struct amdgpu_device *adev = drm_to_adev(plane->dev);
>         const struct drm_format_info *info = drm_format_info(format);
> +       int i;
>
>         enum dm_micro_swizzle microtile = modifier_gfx9_swizzle_mode(modifier) & 3;
>
> @@ -4313,11 +4314,22 @@ static bool dm_plane_format_mod_supported(struct drm_plane *plane,
>                 return false;
>
>         /*
> -        * We always have to allow this modifier, because core DRM still
> -        * checks LINEAR support if userspace does not provide modifers.
> +        * We always have to allow these modifiers:
> +        * 1. Core DRM checks for LINEAR support if userspace does not provide modifiers.
> +        * 2. Not passing any modifiers is the same as explicitly passing INVALID.
>          */
> -       if (modifier == DRM_FORMAT_MOD_LINEAR)
> +       if (modifier == DRM_FORMAT_MOD_LINEAR ||
> +           modifier == DRM_FORMAT_MOD_INVALID) {
>                 return true;
> +       }
> +
> +       /* Check that the modifier is on the list of the plane's supported modifiers. */
> +       for (i = 0; i < plane->modifier_count; i++) {
> +               if (modifier == plane->modifiers[i])
> +                       break;
> +       }
> +       if (i == plane->modifier_count)
> +               return false;
>
>         /*
>          * The arbitrary tiling support for multiplane formats has not been hooked
> --
> 2.17.1
>
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
