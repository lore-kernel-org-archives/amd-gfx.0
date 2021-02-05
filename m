Return-Path: <SRS0=LS4N=HH=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF6CAC433E0
	for <amd-gfx@archiver.kernel.org>; Fri,  5 Feb 2021 16:37:02 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3E56064EE2
	for <amd-gfx@archiver.kernel.org>; Fri,  5 Feb 2021 16:37:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E56064EE2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C3F9B6F48B;
	Fri,  5 Feb 2021 16:36:57 +0000 (UTC)
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com
 [IPv6:2607:f8b0:4864:20::236])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 722166E334;
 Fri,  5 Feb 2021 16:36:56 +0000 (UTC)
Received: by mail-oi1-x236.google.com with SMTP id y199so6059430oia.4;
 Fri, 05 Feb 2021 08:36:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=VJbZMxQGRqPBHqp/8sTE7G9X+wuG0Qr4bREtYk0sVkI=;
 b=BeSCCk+Dsb+HVG4gLLErAnYShuN6AS2TSa6G5fhRC39pSUh+97c3OdwJxGJEHj2LiB
 DPUackk/hy7MPj/tbsHbJ8Ar4LvKu99bIoUQa7mGh6Q8nr81FwJgpq8KtrV1CAsH6zdQ
 R4Bh2qB9ewHo3MLYxJXepR4PJanA8yKkyffSiFQpWL7lqH8zjUSjw1MZmLiiWQZD9Bj2
 97BjH38Q4FXEdN51HdZ4bzMbbaFPBwDmV8BOFXfc3V8mmvYB8Oq4wBbMzQoaIJSPwRnT
 jyP02mATw6RdcB/oZMna/Ryy3XxOAPogUgT1obU9gFNBdWYymZZnCwGHoo2qx2SpfR7f
 adyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=VJbZMxQGRqPBHqp/8sTE7G9X+wuG0Qr4bREtYk0sVkI=;
 b=tQVH+P2rpUqqjjn3CSFBokYLHOzlkzmskhHh7GrVdMt6aJYGOn2DgdVit9rDYMUz+U
 9J++M8YstcBOd9fvS47LUktuJY3JSGeCZzKRepT3p5/wRKUM0HqUUnRu2L97xLIJz1Cl
 Mojbj9ZKscZfwXdzADgthzxrUr68RGnB6YLPIA1fKrivykmnsbomcPLL5T3NrpwYyvMO
 /miKKuwHr5yitrpR7b2d0qG6GI7P4YJdkHJ2ECCS+L7AltSwTC9u2+M0QfpjwFSF6/0+
 i74vgjXVYj7m07Z5LCxr7fhGzoJC8cc7vmu6WZ1eSwnd2gD7D7Lp9dn1sobun8t57Fgq
 OT7A==
X-Gm-Message-State: AOAM5302qbD8+7ZK3WyXW6MVmirsFDaqqdrhvh+9GkkMsoVS+vu4cjAf
 IRAMGE6F4bbOXNSYt2ZjLSOdFLeZkqwSe0OzqpY=
X-Google-Smtp-Source: ABdhPJzUfUcEXIhVf829RIgdIbRDiylPbwz8Ndf7+DD1Csqfto7ktf0wjXWuphlzZmAWAU5pfoWW1yUojKwwMbIdVl4=
X-Received: by 2002:aca:1a17:: with SMTP id a23mr3534468oia.120.1612543015865; 
 Fri, 05 Feb 2021 08:36:55 -0800 (PST)
MIME-Version: 1.0
References: <20210203124241.8512-1-tiwai@suse.de>
 <20210203124241.8512-2-tiwai@suse.de>
In-Reply-To: <20210203124241.8512-2-tiwai@suse.de>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 5 Feb 2021 11:36:44 -0500
Message-ID: <CADnq5_PZFcXG2E28O2PrJRm+twp6Stq71EE+yckEOZbE7NUW6Q@mail.gmail.com>
Subject: Re: [PATCH 1/2] drm/amd/display: Fix the brightness read via aux
To: Takashi Iwai <tiwai@suse.de>
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
Cc: Leo Li <sunpeng.li@amd.com>, amd-gfx list <amd-gfx@lists.freedesktop.org>,
 Maling list - DRI developers <dri-devel@lists.freedesktop.org>,
 Alex Deucher <alexander.deucher@amd.com>,
 Harry Wentland <harry.wentland@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Wed, Feb 3, 2021 at 7:42 AM Takashi Iwai <tiwai@suse.de> wrote:
>
> The current code tries to read the brightness value via
> dc_link_get_backlight_level() no matter whether it's controlled via
> aux or not, and this results in a bogus value returned.
> Fix it to read the current value via
> dc_link_get_backlight_level_nits() for the aux.
>
> BugLink: https://bugzilla.opensuse.org/show_bug.cgi?id=1180749
> BugLink: https://gitlab.freedesktop.org/drm/amd/-/issues/1438
> Signed-off-by: Takashi Iwai <tiwai@suse.de>

This looks fine to me.  FWIW, I have a similar patch set here:
https://cgit.freedesktop.org/~agd5f/linux/log/?h=backlight_wip

Alex

> ---
>  .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c   | 17 ++++++++++++++++-
>  1 file changed, 16 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index c6da89df055d..fb62886ae013 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -3140,6 +3140,16 @@ static int set_backlight_via_aux(struct dc_link *link, uint32_t brightness)
>         return rc ? 0 : 1;
>  }
>
> +static int get_backlight_via_aux(struct dc_link *link)
> +{
> +       uint32_t avg, peak;
> +
> +       if (!link ||
> +           !dc_link_get_backlight_level_nits(link, &avg, &peak))
> +               return DC_ERROR_UNEXPECTED;
> +       return avg;
> +}
> +
>  static int get_brightness_range(const struct amdgpu_dm_backlight_caps *caps,
>                                 unsigned *min, unsigned *max)
>  {
> @@ -3212,8 +3222,13 @@ static int amdgpu_dm_backlight_update_status(struct backlight_device *bd)
>  static int amdgpu_dm_backlight_get_brightness(struct backlight_device *bd)
>  {
>         struct amdgpu_display_manager *dm = bl_get_data(bd);
> -       int ret = dc_link_get_backlight_level(dm->backlight_link);
> +       struct dc_link *link = (struct dc_link *)dm->backlight_link;
> +       int ret;
>
> +       if (dm->backlight_caps.aux_support)
> +               ret = get_backlight_via_aux(link);
> +       else
> +               ret = dc_link_get_backlight_level(link);
>         if (ret == DC_ERROR_UNEXPECTED)
>                 return bd->props.brightness;
>         return convert_brightness_to_user(&dm->backlight_caps, ret);
> --
> 2.26.2
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
