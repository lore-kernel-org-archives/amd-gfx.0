Return-Path: <SRS0=oJVB=J2=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC421C433ED
	for <amd-gfx@archiver.kernel.org>; Thu, 29 Apr 2021 23:07:08 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E25EE61445
	for <amd-gfx@archiver.kernel.org>; Thu, 29 Apr 2021 23:07:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E25EE61445
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=basnieuwenhuizen.nl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9634F6E30D;
	Thu, 29 Apr 2021 23:07:07 +0000 (UTC)
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com
 [IPv6:2607:f8b0:4864:20::12d])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1FF1E6E30D
 for <amd-gfx@lists.freedesktop.org>; Thu, 29 Apr 2021 23:07:05 +0000 (UTC)
Received: by mail-il1-x12d.google.com with SMTP id y10so14468809ilv.0
 for <amd-gfx@lists.freedesktop.org>; Thu, 29 Apr 2021 16:07:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=basnieuwenhuizen.nl; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=UDPjsbMzCkg9gR9GuDsAONN4azTQ4XV52g5T/dn6Mr4=;
 b=dkSaiQZErifVyv/7FcrFqPiZbIwBR7wryPOhllsurfg3NI2ja9guuU5iAW1xR3l1UE
 e61AP5fIRQ1vvb70hyUQW24R8P9lx6QejQ7IHnG3t40UAEsCDm9Yvwe6tWBUqmoy0RJp
 HEEO96YgwMF2DcTCb5iZs95wE/R5/Y3J0a7TJ7ZAjlB4kay+ZszbTkS5Om/roEOk74n+
 rVGxiT3I4wIVR63RlL/daAMxPDxRUuIRVTt6ubrb0OyQ7bm112CZN0Mua1EElZilH6us
 ifspKJVZmbgc7K9MT7sb6YfGoENpmjlkJfyTm5VBaPAKqYwbngy5vZX7d919euVHlHce
 ZH2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=UDPjsbMzCkg9gR9GuDsAONN4azTQ4XV52g5T/dn6Mr4=;
 b=NMkEq9tB7VbtuN9G4xb8WVzPDb5jCAPNlyg66MEyahIKrd9hOisda4YZwuZNZF8MS7
 o/JLOrtTAC+03Ri51j+hjG36kEliDxPiqI66rteIOyiHU4Ds/Dl0JolKbiUNh57Ect15
 8sat3qX8VVt641s5wJgUufKPNvcgXKwACM6G90b1Ls91VwhNyI+ZA6dL50TuwOA9mbpY
 Bae6OdlRU2eKX/U2i0U9Umk/lqv5DPU9Io/i4eWCgyW9iJJn941jLk6tn4kjHdxUHjdz
 XU/QOvugWMlDapRH0FH+Yx9dCW8TwYIKkMRFVYfosMUEcFIdkvJtHzCx50tL0VnHGlX+
 l8Rw==
X-Gm-Message-State: AOAM530PBSQfNcJjtFV5O0K8OOQG2nuBRBCZH9DReDS69MozzXO03u2s
 bVcz00t5HZusFChueVj7/+6gRUokmgKXorF1Ciw8RQ==
X-Google-Smtp-Source: ABdhPJzaYugrf58rPOOxjFfUjseBFxBQ5d0L6E0KSzEWCeTootw9rIwltz1Ir8tvDsfkeVuxW1gY1tobe9JNplsJZSg=
X-Received: by 2002:a92:6b05:: with SMTP id g5mr1764946ilc.40.1619737625245;
 Thu, 29 Apr 2021 16:07:05 -0700 (PDT)
MIME-Version: 1.0
References: <20210429205024.892894-1-bas@basnieuwenhuizen.nl>
 <CAJUqKUoGAjUQ211nOuuxwDjRLyFRUWO-gk2xhJXj59MXOeY0QA@mail.gmail.com>
In-Reply-To: <CAJUqKUoGAjUQ211nOuuxwDjRLyFRUWO-gk2xhJXj59MXOeY0QA@mail.gmail.com>
From: Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>
Date: Fri, 30 Apr 2021 01:06:56 +0200
Message-ID: <CAP+8YyF781KA81-RF+6Z2pUJ9=Z0HCUbY_GWdEx-u2jP4vLriQ@mail.gmail.com>
Subject: Re: [PATCH] Revert "drm/amdgpu: Verify bo size can fit framebuffer
 size on init."
To: Mark Yacoub <markyacoub@chromium.org>
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
Cc: Alex Deucher <alexdeucher@gmail.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Thu, Apr 29, 2021 at 11:27 PM Mark Yacoub <markyacoub@chromium.org> wrote:
>
> On Thu, Apr 29, 2021 at 4:50 PM Bas Nieuwenhuizen
> <bas@basnieuwenhuizen.nl> wrote:
> >
> > This reverts commit f258907fdd835e1aed6d666b00cdd0f186676b7c.
> >
> > Same problem as "drm/amdgpu: Verify bo size can fit framebuffer size",
> > but because it gets checked earlier it now only triggers on the
> > modifiers case.
> >
> > There are a couple of reasons why the DRM core BO size check won't
> > work for AMDGPU, especially around DCC planes.
> >
> Can you tell us more about those reasons? Last time this was reverted
> due to a failure on ubuntu was due to a userspace bug that was fixed.
> So I'm thinking we might wanna fix what broke instead of removing the
> check.

Agree on having the check in the end, just wasn't sure if fixes (or
when I started looking at it, I thought stable) was the right place
given some of the tiling complexity.

So the core problems:

1) In the format structs we don't do set any of the tilesize / blocks
etc. to avoid having format arrays per modifier/GPU
2) The pitch on the main plane is pixel_pitch * bytes_per_pixel even
for tiled ...
3) The pitch for the DCC planes is really the pixel pitch of the main
surface that would be covered by it ...

1 is changeable by refactoring but sadly 2 and 3 are hard to change by
now (would need to bump the modifier version). And all 3 mean that the
default computation in the core drm helper is not the right check for
BO size.

> > Signed-off-by: Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>
> > ---
> >
> > For -fixes. Might have some conflicts with
> > "drm/amdgpu: Ensure that the modifier requested is supported by plane"
> > for amd-staging-drm-next
> >
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_display.c | 68 ++++-----------------
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_fb.c      |  4 +-
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_mode.h    |  8 ---
> >  3 files changed, 15 insertions(+), 65 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
> > index 9a2f811450ed..cbe050436c7b 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
> > @@ -870,62 +870,17 @@ static int amdgpu_display_get_fb_info(const struct amdgpu_framebuffer *amdgpu_fb
> >         return r;
> >  }
> >
> > -int amdgpu_display_gem_fb_init(struct drm_device *dev,
> > -                              struct amdgpu_framebuffer *rfb,
> > -                              const struct drm_mode_fb_cmd2 *mode_cmd,
> > -                              struct drm_gem_object *obj)
> > -{
> > -       int ret;
> > -
> > -       rfb->base.obj[0] = obj;
> > -       drm_helper_mode_fill_fb_struct(dev, &rfb->base, mode_cmd);
> > -       ret = drm_framebuffer_init(dev, &rfb->base, &amdgpu_fb_funcs);
> > -       if (ret)
> > -               goto err;
> > -
> > -       ret = amdgpu_display_framebuffer_init(dev, rfb, mode_cmd, obj);
> > -       if (ret)
> > -               goto err;
> > -
> > -       return 0;
> > -err:
> > -       drm_err(dev, "Failed to init gem fb: %d\n", ret);
> > -       rfb->base.obj[0] = NULL;
> > -       return ret;
> > -}
> > -
> > -int amdgpu_display_gem_fb_verify_and_init(
> > -       struct drm_device *dev, struct amdgpu_framebuffer *rfb,
> > -       struct drm_file *file_priv, const struct drm_mode_fb_cmd2 *mode_cmd,
> > -       struct drm_gem_object *obj)
> > -{
> > -       int ret;
> > -
> > -       rfb->base.obj[0] = obj;
> > -
> > -       /* Verify that bo size can fit the fb size. */
> > -       ret = drm_gem_fb_init_with_funcs(dev, &rfb->base, file_priv, mode_cmd,
> > -                                        &amdgpu_fb_funcs);
> > -       if (ret)
> > -               goto err;
> > -
> > -       ret = amdgpu_display_framebuffer_init(dev, rfb, mode_cmd, obj);
> > -       if (ret)
> > -               goto err;
> > -
> > -       return 0;
> > -err:
> > -       drm_err(dev, "Failed to verify and init gem fb: %d\n", ret);
> > -       rfb->base.obj[0] = NULL;
> > -       return ret;
> > -}
> > -
> >  int amdgpu_display_framebuffer_init(struct drm_device *dev,
> >                                     struct amdgpu_framebuffer *rfb,
> >                                     const struct drm_mode_fb_cmd2 *mode_cmd,
> >                                     struct drm_gem_object *obj)
> >  {
> >         int ret, i;
> > +       rfb->base.obj[0] = obj;
> > +       drm_helper_mode_fill_fb_struct(dev, &rfb->base, mode_cmd);
> > +       ret = drm_framebuffer_init(dev, &rfb->base, &amdgpu_fb_funcs);
> > +       if (ret)
> > +               goto fail;
> >
> >         /*
> >          * This needs to happen before modifier conversion as that might change
> > @@ -936,13 +891,13 @@ int amdgpu_display_framebuffer_init(struct drm_device *dev,
> >                         drm_dbg_kms(dev, "Plane 0 and %d have different BOs: %u vs. %u\n",
> >                                     i, mode_cmd->handles[0], mode_cmd->handles[i]);
> >                         ret = -EINVAL;
> > -                       return ret;
> > +                       goto fail;
> >                 }
> >         }
> >
> >         ret = amdgpu_display_get_fb_info(rfb, &rfb->tiling_flags, &rfb->tmz_surface);
> >         if (ret)
> > -               return ret;
> > +               goto fail;
> >
> >         if (dev->mode_config.allow_fb_modifiers &&
> >             !(rfb->base.flags & DRM_MODE_FB_MODIFIERS)) {
> > @@ -950,7 +905,7 @@ int amdgpu_display_framebuffer_init(struct drm_device *dev,
> >                 if (ret) {
> >                         drm_dbg_kms(dev, "Failed to convert tiling flags 0x%llX to a modifier",
> >                                     rfb->tiling_flags);
> > -                       return ret;
> > +                       goto fail;
> >                 }
> >         }
> >
> > @@ -961,6 +916,10 @@ int amdgpu_display_framebuffer_init(struct drm_device *dev,
> >         }
> >
> >         return 0;
> > +
> > +fail:
> > +       rfb->base.obj[0] = NULL;
> > +       return ret;
> >  }
> >
> >  struct drm_framebuffer *
> > @@ -995,8 +954,7 @@ amdgpu_display_user_framebuffer_create(struct drm_device *dev,
> >                 return ERR_PTR(-ENOMEM);
> >         }
> >
> > -       ret = amdgpu_display_gem_fb_verify_and_init(dev, amdgpu_fb, file_priv,
> > -                                                   mode_cmd, obj);
> > +       ret = amdgpu_display_framebuffer_init(dev, amdgpu_fb, mode_cmd, obj);
> >         if (ret) {
> >                 kfree(amdgpu_fb);
> >                 drm_gem_object_put(obj);
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fb.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_fb.c
> > index 4c5c19820d37..24010cacf7d0 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fb.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fb.c
> > @@ -232,8 +232,8 @@ static int amdgpufb_create(struct drm_fb_helper *helper,
> >                 goto out;
> >         }
> >
> > -       ret = amdgpu_display_gem_fb_init(adev_to_drm(adev), &rfbdev->rfb,
> > -                                        &mode_cmd, gobj);
> > +       ret = amdgpu_display_framebuffer_init(adev_to_drm(adev), &rfbdev->rfb,
> > +                                             &mode_cmd, gobj);
> >         if (ret) {
> >                 DRM_ERROR("failed to initialize framebuffer %d\n", ret);
> >                 goto out;
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mode.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_mode.h
> > index cb0b581bbce7..319cb19e1b99 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mode.h
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mode.h
> > @@ -602,14 +602,6 @@ int amdgpu_display_get_crtc_scanoutpos(struct drm_device *dev,
> >                         int *hpos, ktime_t *stime, ktime_t *etime,
> >                         const struct drm_display_mode *mode);
> >
> > -int amdgpu_display_gem_fb_init(struct drm_device *dev,
> > -                              struct amdgpu_framebuffer *rfb,
> > -                              const struct drm_mode_fb_cmd2 *mode_cmd,
> > -                              struct drm_gem_object *obj);
> > -int amdgpu_display_gem_fb_verify_and_init(
> > -       struct drm_device *dev, struct amdgpu_framebuffer *rfb,
> > -       struct drm_file *file_priv, const struct drm_mode_fb_cmd2 *mode_cmd,
> > -       struct drm_gem_object *obj);
> >  int amdgpu_display_framebuffer_init(struct drm_device *dev,
> >                                     struct amdgpu_framebuffer *rfb,
> >                                     const struct drm_mode_fb_cmd2 *mode_cmd,
> > --
> > 2.31.1
> >
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
