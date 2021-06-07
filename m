Return-Path: <SRS0=JNIh=LB=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB5AAC47094
	for <amd-gfx@archiver.kernel.org>; Mon,  7 Jun 2021 15:36:22 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 69A4D60FF1
	for <amd-gfx@archiver.kernel.org>; Mon,  7 Jun 2021 15:36:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 69A4D60FF1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 146216E8F3;
	Mon,  7 Jun 2021 15:36:22 +0000 (UTC)
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com
 [IPv6:2a00:1450:4864:20::129])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B35E36E8ED
 for <amd-gfx@lists.freedesktop.org>; Mon,  7 Jun 2021 14:53:42 +0000 (UTC)
Received: by mail-lf1-x129.google.com with SMTP id a2so26723731lfc.9
 for <amd-gfx@lists.freedesktop.org>; Mon, 07 Jun 2021 07:53:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=INKLbiuJYjEywt64RdttZc9jVzqxRCyCbSXkESaaHpc=;
 b=fI1FtBPJyNVoRMpc6ag27O0FM3KP/fvdIVXWekR5z0TioU1tbbq+3fdZoJmrWTkl0v
 4t/NYFIbs3LF/2ROSyB0+sDAbT72kCSYnMootkeLe0Sv5TeEHzK3agiDAy85OVw81+S9
 YJxiRsAl876P9eT33giqpZJFlZuxSZ2ItVmr8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=INKLbiuJYjEywt64RdttZc9jVzqxRCyCbSXkESaaHpc=;
 b=l71XDYsUmIh8z5/kyquy0NdidcL1hHlHpLFMnYdZ0YFVgcIxxKABUP6Rjohr2kVM/x
 06PjNwk/kLeXJF5Jj01Zczq7OraszW4zElxXOZ0bsnz73HsbYY81IcKNwbt2LP+wyaMa
 wojZYFXTs3Pq1MoPm4w4Jsa/Jp412pOyNmVcdSdyzXAXxqp3Wzauh3aySzCx5nlIlEbk
 PLuGK17goQGpSLpG4JjqgVdSa7cxIH3oUIzL7pidy4/swimU46pGjC0fOtpcaiqy8LTK
 lFV4GNdC2oKsIMjIsyE5yRi3x+/l7sCLF1jaW7/hNQgrLglxgtXIOV8mEkJQRSxfWPXB
 wCtQ==
X-Gm-Message-State: AOAM530Wa7+VUVzmBpPTilCoxVzFrgL96689oeUXxgn6TkLph0jTjDdA
 lbCIYonJSbuXgEsRzrUcJv7/dJh9/pmeDfObN9rCzw==
X-Google-Smtp-Source: ABdhPJwzZjZ1n0TxHFP55UDL6MSx71JDKGMCE/PTMfRrywxzSzmpjJU8v3E6lywes1V1NHfTb6TKBDaD75JPpaWY9Zs=
X-Received: by 2002:ac2:4c06:: with SMTP id t6mr6336233lfq.366.1623077621140; 
 Mon, 07 Jun 2021 07:53:41 -0700 (PDT)
MIME-Version: 1.0
References: <20210604170107.2023162-1-markyacoub@chromium.org>
 <906d0ab3-ddca-8cb9-68f5-1b495cc4be5c@amd.com>
In-Reply-To: <906d0ab3-ddca-8cb9-68f5-1b495cc4be5c@amd.com>
From: Mark Yacoub <markyacoub@chromium.org>
Date: Mon, 7 Jun 2021 10:53:30 -0400
Message-ID: <CAJUqKUr-s+r1Q-CEO6avH-X5T_Lwt3ZaG5tukygo0joHi8kCpA@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/display: Verify Gamma & Degamma LUT sizes in
 amdgpu_dm_atomic_check
To: Harry Wentland <harry.wentland@amd.com>
X-Mailman-Approved-At: Mon, 07 Jun 2021 15:36:20 +0000
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
Cc: "Siqueira, Rodrigo" <rodrigo.siqueira@amd.com>,
 Maling list - DRI developers <dri-devel@lists.freedesktop.org>,
 Sean Paul <seanpaul@chromium.org>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>, "Deucher,
 Alexander" <alexander.deucher@amd.com>, Mark Yacoub <markyacoub@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Fri, Jun 4, 2021 at 4:17 PM Harry Wentland <harry.wentland@amd.com> wrote:
>
>
>
> On 2021-06-04 1:01 p.m., Mark Yacoub wrote:
> > From: Mark Yacoub <markyacoub@google.com>
> >
> > For each CRTC state, check the size of Gamma and Degamma LUTs  so
> > unexpected and larger sizes wouldn't slip through.
> >
> > TEST: IGT:kms_color::pipe-invalid-gamma-lut-sizes
> >
> > Signed-off-by: Mark Yacoub <markyacoub@chromium.org>
> > Change-Id: I9d513a38e8ac2af1b4bf802e1feb1a4d726fba4c
> > ---
> >  .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |  3 ++
> >  .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h |  1 +
> >  .../amd/display/amdgpu_dm/amdgpu_dm_color.c   | 40 ++++++++++++++++---
> >  3 files changed, 38 insertions(+), 6 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> > index 38d497d30dba8..f6cd522b42a80 100644
> > --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> > +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> > @@ -9402,6 +9402,9 @@ static int amdgpu_dm_atomic_check(struct drm_device *dev,
> >                       dm_old_crtc_state->dsc_force_changed == false)
> >                       continue;
> >
> > +             if ((ret = amdgpu_dm_verify_lut_sizes(new_crtc_state)))
> > +                     goto fail;
> > +
> >               if (!new_crtc_state->enable)
> >                       continue;
> >
> > diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
> > index 8bfe901cf2374..1b77cd2612691 100644
> > --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
> > +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
> > @@ -541,6 +541,7 @@ void amdgpu_dm_trigger_timing_sync(struct drm_device *dev);
> >  #define MAX_COLOR_LEGACY_LUT_ENTRIES 256
> >
> >  void amdgpu_dm_init_color_mod(void);
> > +int amdgpu_dm_verify_lut_sizes(const struct drm_crtc_state *crtc_state);
> >  int amdgpu_dm_update_crtc_color_mgmt(struct dm_crtc_state *crtc);
> >  int amdgpu_dm_update_plane_color_mgmt(struct dm_crtc_state *crtc,
> >                                     struct dc_plane_state *dc_plane_state);
> > diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.c
> > index 157fe4efbb599..da6f9fcc0b415 100644
> > --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.c
> > +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.c
> > @@ -284,6 +284,37 @@ static int __set_input_tf(struct dc_transfer_func *func,
> >       return res ? 0 : -ENOMEM;
> >  }
> >
> > +/**
> > + * Verifies that the Degamma and Gamma LUTs attached to the |crtc_state| are of
> > + * the expected size.
> > + * Returns 0 on success.
> > + */
> > +int amdgpu_dm_verify_lut_sizes(const struct drm_crtc_state *crtc_state)
> > +{
> > +     const struct drm_color_lut *lut = NULL;
> > +     uint32_t size = 0;
> > +
> > +     lut = __extract_blob_lut(crtc_state->degamma_lut, &size);
> > +     if (lut && size != MAX_COLOR_LUT_ENTRIES) {
>
> Isn't the point of the LUT size that it can be variable? Did you observe any
> problems with LUTs that are not of size 4096?
Is it supposed to be variable?
I'm basing my knowledge of LUTs on this IGT Test:
https://gitlab.freedesktop.org/drm/igt-gpu-tools/-/blob/master/tests/kms_color_helper.c#L281
It does check for invalid sizes and for the exact size, giving me the
impression that it's not too flexible.
Is variability of size an AMD specific behavior or should it be a DRM behavior?
>
> Legacy X-based userspace will give us 256 size LUTs. We can't break support for
> that. See MAX_COLOR_LEGACY_LUT_ENTRIES.
In the new function `amdgpu_dm_verify_lut_sizes`, I maintained parity
with the old behavior. In `amdgpu_dm_update_crtc_color_mgmt`, the
degamma size is only checked against `MAX_COLOR_LUT_ENTRIES` while
regamma_size size is checked against both MAX_COLOR_LUT_ENTRIES and
MAX_COLOR_LEGACY_LUT_ENTRIES:
https://gitlab.freedesktop.org/agd5f/linux/-/blob/amd-staging-drm-next/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.c#L321
Also, in the definition of MAX_COLOR_LEGACY_LUT_ENTRIES, it mentions
"Legacy gamm[sic] LUT" not degamma:
https://gitlab.freedesktop.org/agd5f/linux/-/blame/amd-staging-drm-next/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h#L616
As well as the commit when it was introduced, it seems to be handling
gammas rather than degamma LUTs:
https://gitlab.freedesktop.org/agd5f/linux/-/commit/086247a4b2fba49800b27807f22bb894cd8363fb
Let me know if this would be a bug in the old behavior and I can fix
it, or if i'm missing something.
>
> Harry
>
> > +             DRM_DEBUG_DRIVER(
> > +                     "Invalid Degamma LUT size. Should be %u but got %u.\n",
> > +                     MAX_COLOR_LUT_ENTRIES, size);
> > +             return -EINVAL;
> > +     }
> > +
> > +     lut = __extract_blob_lut(crtc_state->gamma_lut, &size);
> > +     if (lut && size != MAX_COLOR_LUT_ENTRIES &&
> > +         size != MAX_COLOR_LEGACY_LUT_ENTRIES) {
> > +             DRM_DEBUG_DRIVER(
> > +                     "Invalid Gamma LUT size. Should be %u (or %u for legacy) but got %u.\n",
> > +                     MAX_COLOR_LUT_ENTRIES, MAX_COLOR_LEGACY_LUT_ENTRIES,
> > +                     size);
> > +             return -EINVAL;
> > +     }
> > +
> > +     return 0;
> > +}
> > +
> >  /**
> >   * amdgpu_dm_update_crtc_color_mgmt: Maps DRM color management to DC stream.
> >   * @crtc: amdgpu_dm crtc state
> > @@ -317,14 +348,11 @@ int amdgpu_dm_update_crtc_color_mgmt(struct dm_crtc_state *crtc)
> >       bool is_legacy;
> >       int r;
> >
> > -     degamma_lut = __extract_blob_lut(crtc->base.degamma_lut, &degamma_size);
> > -     if (degamma_lut && degamma_size != MAX_COLOR_LUT_ENTRIES)
> > -             return -EINVAL;
> > +     if ((r = amdgpu_dm_verify_lut_sizes(&crtc->base)))
> > +             return r;
> >
> > +     degamma_lut = __extract_blob_lut(crtc->base.degamma_lut, &degamma_size);
> >       regamma_lut = __extract_blob_lut(crtc->base.gamma_lut, &regamma_size);
> > -     if (regamma_lut && regamma_size != MAX_COLOR_LUT_ENTRIES &&
> > -         regamma_size != MAX_COLOR_LEGACY_LUT_ENTRIES)
> > -             return -EINVAL;
> >
> >       has_degamma =
> >               degamma_lut && !__is_lut_linear(degamma_lut, degamma_size);
> >
>
-Mark
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
