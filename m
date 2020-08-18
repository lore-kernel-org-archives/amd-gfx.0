Return-Path: <SRS0=CyhX=B4=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60106C433DF
	for <amd-gfx@archiver.kernel.org>; Tue, 18 Aug 2020 16:15:14 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 332B820674
	for <amd-gfx@archiver.kernel.org>; Tue, 18 Aug 2020 16:15:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dihfpwnQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 332B820674
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D012C89CCB;
	Tue, 18 Aug 2020 16:15:13 +0000 (UTC)
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com
 [IPv6:2a00:1450:4864:20::342])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D4F0E89CCB
 for <amd-gfx@lists.freedesktop.org>; Tue, 18 Aug 2020 16:15:12 +0000 (UTC)
Received: by mail-wm1-x342.google.com with SMTP id k20so17540878wmi.5
 for <amd-gfx@lists.freedesktop.org>; Tue, 18 Aug 2020 09:15:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=MD0WasgG03TrhhYMJzHb0FMrtn0p93coirKOwAZR27Y=;
 b=dihfpwnQdoFUda9CNn7wtSuikai/grPSocD6eMkdCLAi2UofDniIjWFWDuk/RcSnKw
 4Z7o8aHMW8tpZuS0D3dXNQfq6/4FOamr/deLDhwuMwlNN+aEYbwiT4SsT6FsOxkvWwEZ
 9qdnGgsnbHVV920zWlTARUUM7KcIDcmmZX71ehWCwcZmmOfNC+hv3oU+ML3S8te89RZ3
 1+X1F9x5bQYFN8tRU3MxDViSN/WLgSv4Q3Icf9Y2055wbhNirqQVCk1BP4JwT85ZiBNA
 Hu0LS5gW+JbuwEWH0364DHwwiwY9IUmOEGR0ct9f8ESQr16ZLAM8aoEdzht902SSo4T+
 +WBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=MD0WasgG03TrhhYMJzHb0FMrtn0p93coirKOwAZR27Y=;
 b=lIJG3vp53lygKYFwhiK4NjyVUq+GP6/dfTmEerKq9SUMXbPD6UJMA7MjuNvAnwT73X
 hIZ1OlKjA7X+2ZsCJW4c75aWI3r0Gc5drHbwiGYjqKySuzW2ZjZ7Q5RXdlLNrj4CFPB9
 hN9fXWhshBFk0abr0cnx8USfu6Gia3mHjRKyJBp6XPLC2BmdFjzkpc6o6Xk1AlFUDne8
 /BB21CCA9EZp0vRPrAmDpujGpz+ajJ9bbJ3CQtaKdky7z3psJnV1+K4L9/RITo31gyfc
 y6sAxIku9k7cYf02Vz46b+Dn5NKFyF3emjp7Z4YH1eUFVa+yQuvzhvv/PozSqMFdTIAh
 +UzQ==
X-Gm-Message-State: AOAM533yRZ+mjgr6cjHTRh4Pbc9MaDxEkOlkuu1x9uR+sTe7hqH0EAyH
 +juIP7XuqBJprDUFOz8fx9l92FB5dfivBAA6cTo=
X-Google-Smtp-Source: ABdhPJwIdti2EEGYmcEL+OcevMuVfhpWoVoEpi9z79KlW+KNgMJDBC+YXfvHCkfwpwIJp5EhPok5BqPOVNuRAwlFi2M=
X-Received: by 2002:a1c:f70a:: with SMTP id v10mr628012wmh.39.1597767311435;
 Tue, 18 Aug 2020 09:15:11 -0700 (PDT)
MIME-Version: 1.0
References: <20200804201313.6464-1-amonakov@ispras.ru>
 <alpine.LNX.2.20.13.2008161149010.7727@monopod.intra.ispras.ru>
 <CADnq5_OaTdfVGCvENTr3tDrU+9jR0VYo-49sjByOQR4EwDWwPA@mail.gmail.com>
In-Reply-To: <CADnq5_OaTdfVGCvENTr3tDrU+9jR0VYo-49sjByOQR4EwDWwPA@mail.gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 18 Aug 2020 12:15:00 -0400
Message-ID: <CADnq5_OqtuHy6oAQkuZvDxR4OsLSZRDoLazXxD15m7y0hWtH2w@mail.gmail.com>
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

Applied.  Thanks!

Alex

On Mon, Aug 17, 2020 at 1:59 PM Alex Deucher <alexdeucher@gmail.com> wrote:
>
> On Mon, Aug 17, 2020 at 3:09 AM Alexander Monakov <amonakov@ispras.ru> wrote:
> >
> > Ping.
>
> Patch looks good to me:
> Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
>
> Nick, unless you have any objections, I'll go ahead and apply it.
>
> Alex
>
> >
> > On Tue, 4 Aug 2020, Alexander Monakov wrote:
> >
> > > Documentation for sysfs backlight level interface requires that
> > > values in both 'brightness' and 'actual_brightness' files are
> > > interpreted to be in range from 0 to the value given in the
> > > 'max_brightness' file.
> > >
> > > With amdgpu, max_brightness gives 255, and values written by the user
> > > into 'brightness' are internally rescaled to a wider range. However,
> > > reading from 'actual_brightness' gives the raw register value without
> > > inverse rescaling. This causes issues for various userspace tools such
> > > as PowerTop and systemd that expect the value to be in the correct
> > > range.
> > >
> > > Introduce a helper to retrieve internal backlight range. Use it to
> > > reimplement 'convert_brightness' as 'convert_brightness_from_user' and
> > > introduce 'convert_brightness_to_user'.
> > >
> > > Bug: https://bugzilla.kernel.org/show_bug.cgi?id=203905
> > > Bug: https://gitlab.freedesktop.org/drm/amd/-/issues/1242
> > > Cc: Alex Deucher <alexander.deucher@amd.com>
> > > Cc: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
> > > Signed-off-by: Alexander Monakov <amonakov@ispras.ru>
> > > ---
> > > v2: split convert_brightness to &_from_user and &_to_user (Nicholas)
> > >
> > >  .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 81 +++++++++----------
> > >  1 file changed, 40 insertions(+), 41 deletions(-)
> > >
> > > diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> > > index 710edc70e37e..b60a763f3f95 100644
> > > --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> > > +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> > > @@ -2881,51 +2881,50 @@ static int set_backlight_via_aux(struct dc_link *link, uint32_t brightness)
> > >       return rc ? 0 : 1;
> > >  }
> > >
> > > -static u32 convert_brightness(const struct amdgpu_dm_backlight_caps *caps,
> > > -                           const uint32_t user_brightness)
> > > +static int get_brightness_range(const struct amdgpu_dm_backlight_caps *caps,
> > > +                             unsigned *min, unsigned *max)
> > >  {
> > > -     u32 min, max, conversion_pace;
> > > -     u32 brightness = user_brightness;
> > > -
> > >       if (!caps)
> > > -             goto out;
> > > +             return 0;
> > >
> > > -     if (!caps->aux_support) {
> > > -             max = caps->max_input_signal;
> > > -             min = caps->min_input_signal;
> > > -             /*
> > > -              * The brightness input is in the range 0-255
> > > -              * It needs to be rescaled to be between the
> > > -              * requested min and max input signal
> > > -              * It also needs to be scaled up by 0x101 to
> > > -              * match the DC interface which has a range of
> > > -              * 0 to 0xffff
> > > -              */
> > > -             conversion_pace = 0x101;
> > > -             brightness =
> > > -                     user_brightness
> > > -                     * conversion_pace
> > > -                     * (max - min)
> > > -                     / AMDGPU_MAX_BL_LEVEL
> > > -                     + min * conversion_pace;
> > > +     if (caps->aux_support) {
> > > +             // Firmware limits are in nits, DC API wants millinits.
> > > +             *max = 1000 * caps->aux_max_input_signal;
> > > +             *min = 1000 * caps->aux_min_input_signal;
> > >       } else {
> > > -             /* TODO
> > > -              * We are doing a linear interpolation here, which is OK but
> > > -              * does not provide the optimal result. We probably want
> > > -              * something close to the Perceptual Quantizer (PQ) curve.
> > > -              */
> > > -             max = caps->aux_max_input_signal;
> > > -             min = caps->aux_min_input_signal;
> > > -
> > > -             brightness = (AMDGPU_MAX_BL_LEVEL - user_brightness) * min
> > > -                            + user_brightness * max;
> > > -             // Multiple the value by 1000 since we use millinits
> > > -             brightness *= 1000;
> > > -             brightness = DIV_ROUND_CLOSEST(brightness, AMDGPU_MAX_BL_LEVEL);
> > > +             // Firmware limits are 8-bit, PWM control is 16-bit.
> > > +             *max = 0x101 * caps->max_input_signal;
> > > +             *min = 0x101 * caps->min_input_signal;
> > >       }
> > > +     return 1;
> > > +}
> > >
> > > -out:
> > > -     return brightness;
> > > +static u32 convert_brightness_from_user(const struct amdgpu_dm_backlight_caps *caps,
> > > +                                     uint32_t brightness)
> > > +{
> > > +     unsigned min, max;
> > > +
> > > +     if (!get_brightness_range(caps, &min, &max))
> > > +             return brightness;
> > > +
> > > +     // Rescale 0..255 to min..max
> > > +     return min + DIV_ROUND_CLOSEST((max - min) * brightness,
> > > +                                    AMDGPU_MAX_BL_LEVEL);
> > > +}
> > > +
> > > +static u32 convert_brightness_to_user(const struct amdgpu_dm_backlight_caps *caps,
> > > +                                   uint32_t brightness)
> > > +{
> > > +     unsigned min, max;
> > > +
> > > +     if (!get_brightness_range(caps, &min, &max))
> > > +             return brightness;
> > > +
> > > +     if (brightness < min)
> > > +             return 0;
> > > +     // Rescale min..max to 0..255
> > > +     return DIV_ROUND_CLOSEST(AMDGPU_MAX_BL_LEVEL * (brightness - min),
> > > +                              max - min);
> > >  }
> > >
> > >  static int amdgpu_dm_backlight_update_status(struct backlight_device *bd)
> > > @@ -2941,7 +2940,7 @@ static int amdgpu_dm_backlight_update_status(struct backlight_device *bd)
> > >
> > >       link = (struct dc_link *)dm->backlight_link;
> > >
> > > -     brightness = convert_brightness(&caps, bd->props.brightness);
> > > +     brightness = convert_brightness_from_user(&caps, bd->props.brightness);
> > >       // Change brightness based on AUX property
> > >       if (caps.aux_support)
> > >               return set_backlight_via_aux(link, brightness);
> > > @@ -2958,7 +2957,7 @@ static int amdgpu_dm_backlight_get_brightness(struct backlight_device *bd)
> > >
> > >       if (ret == DC_ERROR_UNEXPECTED)
> > >               return bd->props.brightness;
> > > -     return ret;
> > > +     return convert_brightness_to_user(&dm->backlight_caps, ret);
> > >  }
> > >
> > >  static const struct backlight_ops amdgpu_dm_backlight_ops = {
> > >
> > > base-commit: bcf876870b95592b52519ed4aafcf9d95999bc9c
> > >
> > _______________________________________________
> > amd-gfx mailing list
> > amd-gfx@lists.freedesktop.org
> > https://lists.freedesktop.org/mailman/listinfo/amd-gfx
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
