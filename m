Return-Path: <SRS0=chDG=IV=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BD5AC433C1
	for <amd-gfx@archiver.kernel.org>; Tue, 23 Mar 2021 15:34:53 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2EFC1619A9
	for <amd-gfx@archiver.kernel.org>; Tue, 23 Mar 2021 15:34:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2EFC1619A9
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DCC136EA0D;
	Tue, 23 Mar 2021 15:34:52 +0000 (UTC)
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com
 [IPv6:2607:f8b0:4864:20::1029])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2334C6EA09
 for <amd-gfx@lists.freedesktop.org>; Tue, 23 Mar 2021 15:32:13 +0000 (UTC)
Received: by mail-pj1-x1029.google.com with SMTP id ha17so10259875pjb.2
 for <amd-gfx@lists.freedesktop.org>; Tue, 23 Mar 2021 08:32:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=g/Cz6+lI4apo80sn1DnT1qYl9f9fU+dp+JkTkb3512U=;
 b=vEWOnzcPAb3XUs9wWbP9lku+DAFgzlcDzRRhAoL9Hasc1Vf51F/7RUnk5o7GPtWmPe
 D6/pgD7ntmtrmUHaSjol8wz4b6Yyj/AW+md6HZW146wl5iLEaH01R0c6ld3FLPxV9i0N
 8/Q+slZm3CUwfTIL3rrzSOWBp0mbjTBBO7G5jjRBOxI98GyJgod6Ie+5YVfGk9qWWXIf
 eP56ZyyW3/Yfwe41p9aa9bOR0VzwKCn/2Jk9YV0i6LmNHXDpQwPj6XFRVxrjkj1Mra2h
 N/pamD57wqsIKMvWj/Y75snolN+PKxnmwk9tYlRPPzpLt/+Y7KMf+MaW/55MfAqaLCuY
 82eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=g/Cz6+lI4apo80sn1DnT1qYl9f9fU+dp+JkTkb3512U=;
 b=iy6ROwzCvzTTZmgS3bj31CTWkh+PWx+E09FiCViwY8wacBcyZ0u8QHRCxxRKZanqN9
 geFtH+K+nLFDOLn0jsKm36ufWJvL0ZznV0ydYW1jCWg07cEGC9YLQFmi+lJGgC1HCxV6
 xklOKRFodRks0jeqRaK3z+l6RnTRxBoZwmNaLH/LrICvjrcNRzO8kL2P/rDlj8LPB23p
 ENHopeHLlLQHCborzJfOlsNd62RjiXNMT8hUiYXU6wUN+yLuB1hJNaAX3s0d3q8lkku/
 pNfl0EMph6gUXuP1W2ry13ThhBjF3GzAiycHmP2jvbqVpfeCLDXXiyXAkqJlQlNY1+Uf
 BHng==
X-Gm-Message-State: AOAM532vNtAZURPlbgc3xuxras8ws0Czz5M7Ts1hlN4GLiIjQVBZRlJh
 oXJAqgZRvFLykhQFdzkryc8d+HvRieeG3fgIotmlmw==
X-Google-Smtp-Source: ABdhPJzybHQSeUegRVEbcZgHuCKOtLDObMB/kMd16TadUSXkT8HdE3FF4Uh+STfdxV7alw6Di2Al9VuqakcsmQBSEVo=
X-Received: by 2002:a17:90a:4005:: with SMTP id u5mr5039685pjc.6.1616513532457; 
 Tue, 23 Mar 2021 08:32:12 -0700 (PDT)
MIME-Version: 1.0
References: <20210310161444.1015500-1-markyacoub@chromium.org>
 <CADnq5_P9aYcedOP2qduSz7VN1fCSnmQEtPa+FdjYu9Co7TwPog@mail.gmail.com>
In-Reply-To: <CADnq5_P9aYcedOP2qduSz7VN1fCSnmQEtPa+FdjYu9Co7TwPog@mail.gmail.com>
From: Mark Yacoub <markyacoub@google.com>
Date: Tue, 23 Mar 2021 11:32:01 -0400
Message-ID: <CAC0gqY7Y2WxtAZ3GnWmASPYq7ahYTfmPhOHAAX5UjMNS9k098w@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: Ensure that the modifier requested is
 supported by plane.
To: Alex Deucher <alexdeucher@gmail.com>
X-Mailman-Approved-At: Tue, 23 Mar 2021 15:34:51 +0000
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
Cc: "Deucher, Alexander" <alexander.deucher@amd.com>,
 Mark Yacoub <markyacoub@chromium.org>,
 Maling list - DRI developers <dri-devel@lists.freedesktop.org>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>,
 Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Tue, Mar 23, 2021 at 11:02 AM Alex Deucher <alexdeucher@gmail.com> wrote:
>
> On Wed, Mar 10, 2021 at 11:15 AM Mark Yacoub <markyacoub@chromium.org> wrote:
> >
> > From: Mark Yacoub <markyacoub@google.com>
> >
> > On initializing the framebuffer, call drm_any_plane_has_format to do a
> > check if the modifier is supported. drm_any_plane_has_format calls
> > dm_plane_format_mod_supported which is extended to validate that the
> > modifier is on the list of the plane's supported modifiers.
> >
> > The bug was caught using igt-gpu-tools test: kms_addfb_basic.addfb25-bad-modifier
> >
> > Tested on ChromeOS Zork by turning on the display, running an overlay
> > test, and running a YT video.
> >
> > Cc: Alex Deucher <alexander.deucher@amd.com>
> > Cc: Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>
> > Signed-off-by: default avatarMark Yacoub <markyacoub@chromium.org>
>
> I'm not an expert with modifiers yet.  Will this break chips which
> don't currently support modifiers?
No it shouldn't. When you don't support modifiers yet, your will
default to Linear Modifier (DRM_FORMAT_MOD_LINEAR),
which is later checked in amdgpu_dm.c::dm_plane_format_mod_supported()
    /*
    * We always have to allow this modifier, because core DRM still
    * checks LINEAR support if userspace does not provide modifiers.
    */
    if (modifier == DRM_FORMAT_MOD_LINEAR)
        return true;

>
> Alex
>
>
> > ---
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_display.c       | 13 +++++++++++++
> >  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |  9 +++++++++
> >  2 files changed, 22 insertions(+)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
> > index afa5f8ad0f563..a947b5aa420d2 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
> > @@ -908,6 +908,19 @@ int amdgpu_display_gem_fb_verify_and_init(
> >                                          &amdgpu_fb_funcs);
> >         if (ret)
> >                 goto err;
> > +       /* Verify that the modifier is supported. */
> > +       if (!drm_any_plane_has_format(dev, mode_cmd->pixel_format,
> > +                                     mode_cmd->modifier[0])) {
> > +               struct drm_format_name_buf format_name;
> > +               drm_dbg_kms(dev,
> > +                           "unsupported pixel format %s / modifier 0x%llx\n",
> > +                           drm_get_format_name(mode_cmd->pixel_format,
> > +                                               &format_name),
> > +                           mode_cmd->modifier[0]);
> > +
> > +               ret = -EINVAL;
> > +               goto err;
> > +       }
> >
> >         ret = amdgpu_display_framebuffer_init(dev, rfb, mode_cmd, obj);
> >         if (ret)
> > diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> > index 961abf1cf040c..21314024a83ce 100644
> > --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> > +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> > @@ -3939,6 +3939,7 @@ static bool dm_plane_format_mod_supported(struct drm_plane *plane,
> >  {
> >         struct amdgpu_device *adev = drm_to_adev(plane->dev);
> >         const struct drm_format_info *info = drm_format_info(format);
> > +       int i;
> >
> >         enum dm_micro_swizzle microtile = modifier_gfx9_swizzle_mode(modifier) & 3;
> >
> > @@ -3952,6 +3953,14 @@ static bool dm_plane_format_mod_supported(struct drm_plane *plane,
> >         if (modifier == DRM_FORMAT_MOD_LINEAR)
> >                 return true;
> >
> > +       /* Check that the modifier is on the list of the plane's supported modifiers. */
> > +       for (i = 0; i < plane->modifier_count; i++) {
> > +               if (modifier == plane->modifiers[i])
> > +                       break;
> > +       }
> > +       if (i == plane->modifier_count)
> > +               return false;
> > +
> >         /*
> >          * The arbitrary tiling support for multiplane formats has not been hooked
> >          * up.
> > --
> > 2.30.1.766.gb4fecdf3b7-goog
> >
> > _______________________________________________
> > dri-devel mailing list
> > dri-devel@lists.freedesktop.org
> > https://lists.freedesktop.org/mailman/listinfo/dri-devel
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
