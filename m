Return-Path: <SRS0=yJoC=B3=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 124E7C433E1
	for <amd-gfx@archiver.kernel.org>; Mon, 17 Aug 2020 17:59:42 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D50A62063A
	for <amd-gfx@archiver.kernel.org>; Mon, 17 Aug 2020 17:59:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h6ZG5ld+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D50A62063A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7764989DF7;
	Mon, 17 Aug 2020 17:59:41 +0000 (UTC)
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com
 [IPv6:2a00:1450:4864:20::344])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 057B189DF7
 for <amd-gfx@lists.freedesktop.org>; Mon, 17 Aug 2020 17:59:41 +0000 (UTC)
Received: by mail-wm1-x344.google.com with SMTP id x5so13988573wmi.2
 for <amd-gfx@lists.freedesktop.org>; Mon, 17 Aug 2020 10:59:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=xpqTsrG3Vt+9rDMAnpoJVGMbucsRUJ6l/Nbc7i/7gDA=;
 b=h6ZG5ld+KvETec+uQL+lRN1c5eWYIQtVdKcid3x29ZR6yoRvAKfH5SNMoqyuhoXHqY
 vn3Yq0Mkz234dFO8/B7pWQ72jTjCf39QvXhvWIoqLGReggdC6HOPcQdWBUE5OcN3yN2J
 k0GMO2isL+iYSCyS8Ki6wat/iJPKx1SGR8a5mfMBmStrFeNgQk4/DGy6a/7gEtB46B5Z
 RUTbyfgnL1BUp1/FciwUEhZjN4snWastUJ6yA5f1r+HPzORjvhbblR1O6qIG0aQz8Skk
 Q8W/nc1k6kjrufjywWABDg81yz4UpSwLugQq6Mh4GvuHGCUBh8jIm130wFdVCFH8Axmr
 bUEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=xpqTsrG3Vt+9rDMAnpoJVGMbucsRUJ6l/Nbc7i/7gDA=;
 b=iegGhhH98cX3l4kOqrUxDygVLx048VTFe6+NwQYaMoI9YAm0EdcYWAC9ZHNBbi1W88
 qVTjZUcAP++xGL9l9v+lPPFiLr1WZnwSgTi4BXlPIls1wD06Oj5RdEniW0Ylpsydpb51
 mtPX0pBzG2xtd3PAdedIGxHpyj/RMxhvy18bZoWtcuo9b7DQdD90jZI6I8ZsM5Gi20SF
 O0Qbi/qTlvbKrl/chjpfz6HhHyVWa81DemNB0MTtIbw3E41TDFe+QJ5CJN5PWZnLphHo
 /4iZt+3B/OY3iIB6UswB+NkvoY7hzewMh8UMEtbnPv2Rx/4qVI7eFYW6Al/LnFYqa1Fg
 hpQg==
X-Gm-Message-State: AOAM530hitHANdT4Nmx49x05fsMWfwkkccBnG9GkPBCiuNjiJFxaat8V
 lKCT+WQbbUhdK4oikbGO88NLm1Ixfvwoogzc6t8=
X-Google-Smtp-Source: ABdhPJybgXSXlNHDmYFUVQMVyBXKeZlv0ylOpLrcNbwC8oQGiSf5RCUwjbU9ykGlb6A3yx619pF76myTqoQg/AUf36I=
X-Received: by 2002:a7b:c941:: with SMTP id i1mr15423755wml.73.1597687179587; 
 Mon, 17 Aug 2020 10:59:39 -0700 (PDT)
MIME-Version: 1.0
References: <20200804201313.6464-1-amonakov@ispras.ru>
 <alpine.LNX.2.20.13.2008161149010.7727@monopod.intra.ispras.ru>
In-Reply-To: <alpine.LNX.2.20.13.2008161149010.7727@monopod.intra.ispras.ru>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 17 Aug 2020 13:59:28 -0400
Message-ID: <CADnq5_OaTdfVGCvENTr3tDrU+9jR0VYo-49sjByOQR4EwDWwPA@mail.gmail.com>
Subject: Re: [PATCH v2] drm/amd/display: use correct scale for
 actual_brightness
To: Alexander Monakov <amonakov@ispras.ru>
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 LKML <linux-kernel@vger.kernel.org>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>,
 Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Mon, Aug 17, 2020 at 3:09 AM Alexander Monakov <amonakov@ispras.ru> wrote:
>
> Ping.

Patch looks good to me:
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

Nick, unless you have any objections, I'll go ahead and apply it.

Alex

>
> On Tue, 4 Aug 2020, Alexander Monakov wrote:
>
> > Documentation for sysfs backlight level interface requires that
> > values in both 'brightness' and 'actual_brightness' files are
> > interpreted to be in range from 0 to the value given in the
> > 'max_brightness' file.
> >
> > With amdgpu, max_brightness gives 255, and values written by the user
> > into 'brightness' are internally rescaled to a wider range. However,
> > reading from 'actual_brightness' gives the raw register value without
> > inverse rescaling. This causes issues for various userspace tools such
> > as PowerTop and systemd that expect the value to be in the correct
> > range.
> >
> > Introduce a helper to retrieve internal backlight range. Use it to
> > reimplement 'convert_brightness' as 'convert_brightness_from_user' and
> > introduce 'convert_brightness_to_user'.
> >
> > Bug: https://bugzilla.kernel.org/show_bug.cgi?id=203905
> > Bug: https://gitlab.freedesktop.org/drm/amd/-/issues/1242
> > Cc: Alex Deucher <alexander.deucher@amd.com>
> > Cc: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
> > Signed-off-by: Alexander Monakov <amonakov@ispras.ru>
> > ---
> > v2: split convert_brightness to &_from_user and &_to_user (Nicholas)
> >
> >  .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 81 +++++++++----------
> >  1 file changed, 40 insertions(+), 41 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> > index 710edc70e37e..b60a763f3f95 100644
> > --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> > +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> > @@ -2881,51 +2881,50 @@ static int set_backlight_via_aux(struct dc_link *link, uint32_t brightness)
> >       return rc ? 0 : 1;
> >  }
> >
> > -static u32 convert_brightness(const struct amdgpu_dm_backlight_caps *caps,
> > -                           const uint32_t user_brightness)
> > +static int get_brightness_range(const struct amdgpu_dm_backlight_caps *caps,
> > +                             unsigned *min, unsigned *max)
> >  {
> > -     u32 min, max, conversion_pace;
> > -     u32 brightness = user_brightness;
> > -
> >       if (!caps)
> > -             goto out;
> > +             return 0;
> >
> > -     if (!caps->aux_support) {
> > -             max = caps->max_input_signal;
> > -             min = caps->min_input_signal;
> > -             /*
> > -              * The brightness input is in the range 0-255
> > -              * It needs to be rescaled to be between the
> > -              * requested min and max input signal
> > -              * It also needs to be scaled up by 0x101 to
> > -              * match the DC interface which has a range of
> > -              * 0 to 0xffff
> > -              */
> > -             conversion_pace = 0x101;
> > -             brightness =
> > -                     user_brightness
> > -                     * conversion_pace
> > -                     * (max - min)
> > -                     / AMDGPU_MAX_BL_LEVEL
> > -                     + min * conversion_pace;
> > +     if (caps->aux_support) {
> > +             // Firmware limits are in nits, DC API wants millinits.
> > +             *max = 1000 * caps->aux_max_input_signal;
> > +             *min = 1000 * caps->aux_min_input_signal;
> >       } else {
> > -             /* TODO
> > -              * We are doing a linear interpolation here, which is OK but
> > -              * does not provide the optimal result. We probably want
> > -              * something close to the Perceptual Quantizer (PQ) curve.
> > -              */
> > -             max = caps->aux_max_input_signal;
> > -             min = caps->aux_min_input_signal;
> > -
> > -             brightness = (AMDGPU_MAX_BL_LEVEL - user_brightness) * min
> > -                            + user_brightness * max;
> > -             // Multiple the value by 1000 since we use millinits
> > -             brightness *= 1000;
> > -             brightness = DIV_ROUND_CLOSEST(brightness, AMDGPU_MAX_BL_LEVEL);
> > +             // Firmware limits are 8-bit, PWM control is 16-bit.
> > +             *max = 0x101 * caps->max_input_signal;
> > +             *min = 0x101 * caps->min_input_signal;
> >       }
> > +     return 1;
> > +}
> >
> > -out:
> > -     return brightness;
> > +static u32 convert_brightness_from_user(const struct amdgpu_dm_backlight_caps *caps,
> > +                                     uint32_t brightness)
> > +{
> > +     unsigned min, max;
> > +
> > +     if (!get_brightness_range(caps, &min, &max))
> > +             return brightness;
> > +
> > +     // Rescale 0..255 to min..max
> > +     return min + DIV_ROUND_CLOSEST((max - min) * brightness,
> > +                                    AMDGPU_MAX_BL_LEVEL);
> > +}
> > +
> > +static u32 convert_brightness_to_user(const struct amdgpu_dm_backlight_caps *caps,
> > +                                   uint32_t brightness)
> > +{
> > +     unsigned min, max;
> > +
> > +     if (!get_brightness_range(caps, &min, &max))
> > +             return brightness;
> > +
> > +     if (brightness < min)
> > +             return 0;
> > +     // Rescale min..max to 0..255
> > +     return DIV_ROUND_CLOSEST(AMDGPU_MAX_BL_LEVEL * (brightness - min),
> > +                              max - min);
> >  }
> >
> >  static int amdgpu_dm_backlight_update_status(struct backlight_device *bd)
> > @@ -2941,7 +2940,7 @@ static int amdgpu_dm_backlight_update_status(struct backlight_device *bd)
> >
> >       link = (struct dc_link *)dm->backlight_link;
> >
> > -     brightness = convert_brightness(&caps, bd->props.brightness);
> > +     brightness = convert_brightness_from_user(&caps, bd->props.brightness);
> >       // Change brightness based on AUX property
> >       if (caps.aux_support)
> >               return set_backlight_via_aux(link, brightness);
> > @@ -2958,7 +2957,7 @@ static int amdgpu_dm_backlight_get_brightness(struct backlight_device *bd)
> >
> >       if (ret == DC_ERROR_UNEXPECTED)
> >               return bd->props.brightness;
> > -     return ret;
> > +     return convert_brightness_to_user(&dm->backlight_caps, ret);
> >  }
> >
> >  static const struct backlight_ops amdgpu_dm_backlight_ops = {
> >
> > base-commit: bcf876870b95592b52519ed4aafcf9d95999bc9c
> >
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
