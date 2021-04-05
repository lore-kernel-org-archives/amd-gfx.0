Return-Path: <SRS0=xdDd=JC=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEA12C433B4
	for <amd-gfx@archiver.kernel.org>; Mon,  5 Apr 2021 16:18:53 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 878C361279
	for <amd-gfx@archiver.kernel.org>; Mon,  5 Apr 2021 16:18:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 878C361279
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4280D89DBF;
	Mon,  5 Apr 2021 16:18:53 +0000 (UTC)
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com
 [IPv6:2607:f8b0:4864:20::432])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ABCC289F89
 for <amd-gfx@lists.freedesktop.org>; Mon,  5 Apr 2021 16:14:49 +0000 (UTC)
Received: by mail-pf1-x432.google.com with SMTP id c204so4705132pfc.4
 for <amd-gfx@lists.freedesktop.org>; Mon, 05 Apr 2021 09:14:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=DwMPmbMMFEN25sIOtYqWoH1ZFZKpYubY3tm+vXsIpYc=;
 b=JoxKc90LqU2Bpdmx4eMrSYXWAbXkVMjd3QMlmzMzHJI7OCE93VgQtm3i7DczfQ/TTc
 PzS7ar5tvOZlOYRQnP3Pa2aWD9OOhTQMP1ZVReorF2JLZgjpWbWnaTg28euVy71aBa4K
 21wp49zROsz09Je4E8kthjBWpv+vXGKBvyevC8xyqA4gj8r86bmUN8reG60pBS4QSUj3
 4tmc8+wpGvO0qFpuDTVPTac4pwL7vUi/qx2YMZq4Z7nTExnbwIWX3RQ7VatZzwsYKfPK
 PKEEEC5vlvsr71L9lVkHrxVoFtmPd9Te40efGkUlvDsG1ryzQxnEE+H8a19ahVV6LRym
 uhVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=DwMPmbMMFEN25sIOtYqWoH1ZFZKpYubY3tm+vXsIpYc=;
 b=tWGdZZ9pga6vhpuZCUc5ZuDKd6I2K422r6S1fQmgzl34tXCU5jxb14yb6ZjYkonJPT
 ETt+KY8zaBGV+ibwBpUPIoUfyf5PUf2T4hi7KXNO6+O1C+z8UN/WHkarzin2mUB7cBNL
 vUdQn43S0VB+elTDpG65VTUZUfKjkHqWafypWMyze+/3ye+iouoShRJQlJOkZnhliqzL
 5Hncwalj/wEy9ySGOLtu+kHQ4FdQO3Ln5RoD4YkFMAK7SoeN4osscM1eHkaoToLpn84+
 9ridnZHfNrhvRhrvZNrc84vlYhOV8rdV6Ca4qJSY/UgVfrAcCZpxfDUiQR2NvtA45Ym/
 h2ow==
X-Gm-Message-State: AOAM532K99uKefoB8U8NpDwZIet3qFUf6deWSBB9Oe0SkE3kOarq+dbs
 HkC+ZWwDQz0DsNCoywlTa2AgzuSoPDg2g3eIeJHflA==
X-Google-Smtp-Source: ABdhPJxkU7KJRSz7yHIgDVAPwYDU6H+vcb1+9cEVhnTTuHVDXLZJJyNBpf19HEhU2tuwy5LfZtY52vFZuFjvh47z5Eo=
X-Received: by 2002:a63:4502:: with SMTP id s2mr24562855pga.94.1617639289075; 
 Mon, 05 Apr 2021 09:14:49 -0700 (PDT)
MIME-Version: 1.0
References: <20210405150834.3942-1-qingqing.zhuo@amd.com>
 <20210405161023.b4bygttkpq2ttfnq@outlook.office365.com>
In-Reply-To: <20210405161023.b4bygttkpq2ttfnq@outlook.office365.com>
From: Mark Yacoub <markyacoub@google.com>
Date: Mon, 5 Apr 2021 12:14:38 -0400
Message-ID: <CAC0gqY7ejs2iBCkMTHbVSQ5vnd-UJqmU2AXgs8OL+S4=EwstMg@mail.gmail.com>
Subject: Re: [PATCH] Revert "drm/amdgpu: Ensure that the modifier requested is
 supported by plane."
To: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
X-Mailman-Approved-At: Mon, 05 Apr 2021 16:18:52 +0000
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
Cc: Mark Yacoub <markyacoub@chromium.org>,
 Qingqing Zhuo <qingqing.zhuo@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>, daniel.wheeler@amd.com,
 Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>,
 Alex Deucher <alexander.deucher@amd.com>,
 Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Not really, I can't think what this patch breaks yet, I'll need to
investigate further. But if it's found to be the culprit for the bugs,
I'm all for reverting right now and I'll debug further later.

On Mon, Apr 5, 2021 at 12:10 PM Rodrigo Siqueira
<Rodrigo.Siqueira@amd.com> wrote:
>
> In general lgtm.
>
> Reviewed-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
>
> Mark Yacoub, do you have any comment?
>
> On 04/05, Qingqing Zhuo wrote:
> > This reverts commit 9f81b5d40ca2c689334ad8288a4ddca4722a6e10.
> >
> > The original commit was found to cause the following two issues
> > on sienna cichlid:
> > 1. Refresh rate locked during vrrdemo
> > 2. Display sticks on flipped landscape mode after changing
> >    orientation, and cannot be changed back to regular landscape
> >
> > Signed-off-by: Qingqing Zhuo <qingqing.zhuo@amd.com>
> > ---
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_display.c    | 13 -------------
> >  .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c  | 18 +++---------------
> >  2 files changed, 3 insertions(+), 28 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
> > index 0f17984fdea4..6304a49b02fd 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
> > @@ -908,19 +908,6 @@ int amdgpu_display_gem_fb_verify_and_init(
> >                                        &amdgpu_fb_funcs);
> >       if (ret)
> >               goto err;
> > -     /* Verify that the modifier is supported. */
> > -     if (!drm_any_plane_has_format(dev, mode_cmd->pixel_format,
> > -                                   mode_cmd->modifier[0])) {
> > -             struct drm_format_name_buf format_name;
> > -             drm_dbg_kms(dev,
> > -                         "unsupported pixel format %s / modifier 0x%llx\n",
> > -                         drm_get_format_name(mode_cmd->pixel_format,
> > -                                             &format_name),
> > -                         mode_cmd->modifier[0]);
> > -
> > -             ret = -EINVAL;
> > -             goto err;
> > -     }
> >
> >       ret = amdgpu_display_framebuffer_init(dev, rfb, mode_cmd, obj);
> >       if (ret)
> > diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> > index 54ef0f3f37b7..ac6ab35f89b2 100644
> > --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> > +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> > @@ -4299,7 +4299,6 @@ static bool dm_plane_format_mod_supported(struct drm_plane *plane,
> >  {
> >       struct amdgpu_device *adev = drm_to_adev(plane->dev);
> >       const struct drm_format_info *info = drm_format_info(format);
> > -     int i;
> >
> >       enum dm_micro_swizzle microtile = modifier_gfx9_swizzle_mode(modifier) & 3;
> >
> > @@ -4307,22 +4306,11 @@ static bool dm_plane_format_mod_supported(struct drm_plane *plane,
> >               return false;
> >
> >       /*
> > -      * We always have to allow these modifiers:
> > -      * 1. Core DRM checks for LINEAR support if userspace does not provide modifiers.
> > -      * 2. Not passing any modifiers is the same as explicitly passing INVALID.
> > +      * We always have to allow this modifier, because core DRM still
> > +      * checks LINEAR support if userspace does not provide modifers.
> >        */
> > -     if (modifier == DRM_FORMAT_MOD_LINEAR ||
> > -         modifier == DRM_FORMAT_MOD_INVALID) {
> > +     if (modifier == DRM_FORMAT_MOD_LINEAR)
> >               return true;
> > -     }
> > -
> > -     /* Check that the modifier is on the list of the plane's supported modifiers. */
> > -     for (i = 0; i < plane->modifier_count; i++) {
> > -             if (modifier == plane->modifiers[i])
> > -                     break;
> > -     }
> > -     if (i == plane->modifier_count)
> > -             return false;
> >
> >       /*
> >        * The arbitrary tiling support for multiplane formats has not been hooked
> > --
> > 2.17.1
> >
>
> --
> Rodrigo Siqueira
> https://siqueira.tech
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
