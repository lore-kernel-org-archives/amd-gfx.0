Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE525C433EF
	for <amd-gfx@archiver.kernel.org>; Thu, 23 Jun 2022 18:38:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 55A0210E2F9;
	Thu, 23 Jun 2022 18:38:25 +0000 (UTC)
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com
 [IPv6:2a00:1450:4864:20::62a])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4C28010E2F9
 for <amd-gfx@lists.freedesktop.org>; Thu, 23 Jun 2022 18:38:24 +0000 (UTC)
Received: by mail-ej1-x62a.google.com with SMTP id pk21so53157ejb.2
 for <amd-gfx@lists.freedesktop.org>; Thu, 23 Jun 2022 11:38:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=uEvg8ksP884FCPRUrfk7RX07DEGGBNtrMwnYfPAZ8/k=;
 b=DT+9GCvPnBwOniueHmEgIFAM10NElA8hs7d4oGgM1fDdsUt1SrZnmliaYJ7qrbn+2s
 H4iJ5+vT/C/0RGmG7q1/ZYWd9zEqPTU5d4myzlmwAO2ldMwPQ2EpNcAMlRkzyUZurTcU
 djOrM4GqQB6jCtkBa8Iur22Cjm/krCpL6uDkap17WqYKBAmAXz95FS3g3U37DsSjPYcP
 GozF76i2JRPthUnM9kWp5Dhm/bbFy026P6SWFkqzI6Ur0iHE6ey51FUf4ThVg4s4Lay4
 KXC4mmyRvJGTC3S+d90PWtPzfGev5+m2qlB0IbYU8Z4TqzGHphocP06QZPdcAW89JIM+
 7FQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=uEvg8ksP884FCPRUrfk7RX07DEGGBNtrMwnYfPAZ8/k=;
 b=Bm8L3OrkoJmMfd/ajnxYRgDYECYPHv90LVMK5QCg2kw/XBOrMx931BAAJ4ZDDrbY0T
 DgEgfyc5AwNbwV8BNTE8nof65fUPDUJ14GLemrCJ5tvixzQYPX8MLYy0I5aMC8+AfwtP
 OyW1Uy2Gi3chwRceU+kbukMweohRgoDJfeH/XnFCFc3RMVqIESy/yjmRLKQFC9g/j3T0
 F7yiR2i0/5wGSvNLFNAj+a+CY6tiQTjxp/uJGFYAVL6kNCcp5HRidQ+VqqsbKr6f2wof
 E/64yLrFfiRaxkknp294rndp1d7ONtYP++mkITjt5N6etZwaHjH6F708eeF5pQlnJeb+
 UqXQ==
X-Gm-Message-State: AJIora/dc+yLt2xw+qojtPnunzGacVzDaJ/XeVd9adZ8W0/Dgag+W/gd
 Y19pNRrw5bN7nshy0QqgjfaUDU6JDgxeNCRLCxhAZPZB
X-Google-Smtp-Source: AGRyM1s6Wd10QJcUeis+tBaBtqp5ASnqrAuz/XbjK9wLksFRSSxYxjiFA/+XZH7akhJ5rhk/GbmcQ+2jMx0XmghA7fY=
X-Received: by 2002:a17:907:7f1c:b0:711:f3b4:da5 with SMTP id
 qf28-20020a1709077f1c00b00711f3b40da5mr9426383ejc.508.1656009502745; Thu, 23
 Jun 2022 11:38:22 -0700 (PDT)
MIME-Version: 1.0
References: <20220620003720.2049653-1-bas@basnieuwenhuizen.nl>
 <63049cc5-d963-4cb1-d10a-230462ef1aff@amd.com>
In-Reply-To: <63049cc5-d963-4cb1-d10a-230462ef1aff@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 23 Jun 2022 14:38:10 -0400
Message-ID: <CADnq5_Nahg3n-FEW+crk_ST5YaLU1gyuWzW3Dob=xeY5pDvdXw@mail.gmail.com>
Subject: Re: [PATCH] Revert "drm/amd/display: ignore modifiers when checking
 for format support"
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
Cc: "Deucher, Alexander" <alexander.deucher@amd.com>,
 =?UTF-8?B?TWFyZWsgT2zFocOhaw==?= <marek.olsak@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>,
 Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Applied.  Thanks!

Alex

On Thu, Jun 23, 2022 at 9:34 AM Aurabindo Pillai
<aurabindo.pillai@amd.com> wrote:
>
>
>
> On 2022-06-19 20:37, Bas Nieuwenhuizen wrote:
> > This reverts commit 5089c4a8ebea3c3ad9eedf038dad7098ebc06131.
> >
> > This breaks validation and enumeration of display capable modifiers.
> >
> > The early return true means the rest of the validation code never gets
> > executed, and we need that to enumerate the right modifiers to userspace
> > for the format.
> >
> > The modifiers that are in the initial list generated for a plane are the
> > superset for all formats and we need the proper checks in this function
> > to filter some of them out for formats with which they're invalid to be
> > used.
> >
> > Furthermore, the safety contract here is that we validate the incoming
> > modifiers to ensure the kernel can handle them and the display hardware
> > can handle them. This includes e.g. rejecting multi-plane images with DCC.
> >
> > Note that the legacy swizzle mechanism allows encoding more swizzles, and
> > at fb creation time we convert them to modifiers and reject those with
> > no corresponding modifiers. If we are seeing rejections I'm happy to
> > help define modifiers that correspond to those, or if absolutely needed
> > implement a fallback path to allow for less strict validation of the
> > legacy path.
> >
> > However, I'd like to revert this patch, since any of these is going to
> > be a significant rework of the patch, and I'd rather not the regression
> > gets into a release or forgotten in the meantime.
> >
> > Signed-off-by: Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>
> > ---
> >   .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 53 +++----------------
> >   1 file changed, 7 insertions(+), 46 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> > index 60fb99b74713..698741fd39f4 100644
> > --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> > +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> > @@ -4936,7 +4936,8 @@ static bool dm_plane_format_mod_supported(struct drm_plane *plane,
> >   {
> >       struct amdgpu_device *adev = drm_to_adev(plane->dev);
> >       const struct drm_format_info *info = drm_format_info(format);
> > -     struct hw_asic_id asic_id = adev->dm.dc->ctx->asic_id;
> > +     int i;
> > +
> >       enum dm_micro_swizzle microtile = modifier_gfx9_swizzle_mode(modifier) & 3;
> >
> >       if (!info)
> > @@ -4952,53 +4953,13 @@ static bool dm_plane_format_mod_supported(struct drm_plane *plane,
> >               return true;
> >       }
> >
> > -     /* check if swizzle mode is supported by this version of DCN */
> > -     switch (asic_id.chip_family) {
> > -             case FAMILY_SI:
> > -             case FAMILY_CI:
> > -             case FAMILY_KV:
> > -             case FAMILY_CZ:
> > -             case FAMILY_VI:
> > -                     /* asics before AI does not have modifier support */
> > -                     return false;
> > -                     break;
> > -             case FAMILY_AI:
> > -             case FAMILY_RV:
> > -             case FAMILY_NV:
> > -             case FAMILY_VGH:
> > -             case FAMILY_YELLOW_CARP:
> > -             case AMDGPU_FAMILY_GC_10_3_6:
> > -             case AMDGPU_FAMILY_GC_10_3_7:
> > -                     switch (AMD_FMT_MOD_GET(TILE, modifier)) {
> > -                             case AMD_FMT_MOD_TILE_GFX9_64K_R_X:
> > -                             case AMD_FMT_MOD_TILE_GFX9_64K_D_X:
> > -                             case AMD_FMT_MOD_TILE_GFX9_64K_S_X:
> > -                             case AMD_FMT_MOD_TILE_GFX9_64K_D:
> > -                                     return true;
> > -                                     break;
> > -                             default:
> > -                                     return false;
> > -                                     break;
> > -                     }
> > -                     break;
> > -             case AMDGPU_FAMILY_GC_11_0_0:
> > -                     switch (AMD_FMT_MOD_GET(TILE, modifier)) {
> > -                             case AMD_FMT_MOD_TILE_GFX11_256K_R_X:
> > -                             case AMD_FMT_MOD_TILE_GFX9_64K_R_X:
> > -                             case AMD_FMT_MOD_TILE_GFX9_64K_D_X:
> > -                             case AMD_FMT_MOD_TILE_GFX9_64K_S_X:
> > -                             case AMD_FMT_MOD_TILE_GFX9_64K_D:
> > -                                     return true;
> > -                                     break;
> > -                             default:
> > -                                     return false;
> > -                                     break;
> > -                     }
> > -                     break;
> > -             default:
> > -                     ASSERT(0); /* Unknown asic */
> > +     /* Check that the modifier is on the list of the plane's supported modifiers. */
> > +     for (i = 0; i < plane->modifier_count; i++) {
> > +             if (modifier == plane->modifiers[i])
> >                       break;
> >       }
> > +     if (i == plane->modifier_count)
> > +             return false;
> >
> >       /*
> >        * For D swizzle the canonical modifier depends on the bpp, so check
>
> We can expose an additional swizzle mode to work around the original
> problem with usermode which doesn't support modifiers but supports
> swizzle modes.
>
> Reviewed-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
