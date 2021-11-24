Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF335C433EF
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Nov 2021 18:55:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 87B026E0D5;
	Wed, 24 Nov 2021 18:55:44 +0000 (UTC)
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com
 [IPv6:2607:f8b0:4864:20::32b])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8AD7C6E0D5
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Nov 2021 18:55:43 +0000 (UTC)
Received: by mail-ot1-x32b.google.com with SMTP id
 n104-20020a9d2071000000b005799790cf0bso5780578ota.5
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Nov 2021 10:55:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=4X6uJ6ua6U82EDTudRPuI7U613MoSt7t/sScP9uzWFE=;
 b=RLeEKDzoPnkTsS3ppjBcu90fL6EwehHGOaiVhosVvUAZD/2mhbu+2nVRzpIkurT51q
 49VxaBZzQJHVknly3kSB6US5ev+yRJjvOHs2CPvFonXvh5so7fmw15vnGauejBtlSc2A
 RVJSTCFBj9MqRQVJuP5tbjYCiBC2bUcHKgT568WD+pliRhP+lrb4wDet5K2thkipmmKB
 S2OqphanHIg4JNIIidRbcffbML584SESu5yaewM5QdEtLCxrYb5zBv0ReH3YmD1HuQAP
 3iBEs7P2TrZIRWOQKAKW/ozMrDQw5YRdGhhmDKNaHP16Od7Xst0Lrt3dXUInbWOK6aCJ
 k8mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=4X6uJ6ua6U82EDTudRPuI7U613MoSt7t/sScP9uzWFE=;
 b=JBCMhpQgXoT5whQcV9SDSCwc44F6cmc3nxWTjA7DcTzOGME3lemAZo53qTx8xDuIBM
 mN4+o2hzKJWohIGC/wkU4VYv+/2uM/IR5SwWMpOmeRfpIZN2yqORB4i2w24tMQ6VBHJX
 oDv5wzjTBRsdD6zPRcbx91Qdc4g3Q3PZeweG2d253J0XqPHnLqLIwjZj6pHYAy8G3a9j
 /Rc4cWJxe2QwrEBB1ckvZo/h0bE4LrMsidEcKkTqKR0vgQ0TtUShbcV3yEQ2NP/pPQcv
 8A+yN1/U3BD2A/PKdBqyhY8fidZkT4s7dMBgl/t+HzbTqkcOvCQh7XmE6dvDLL5OiI9a
 4QNA==
X-Gm-Message-State: AOAM5300QJ4qgAX4GVa1NjQm/Vvg4lRfSQL27Tr09VvbcxoqltBak0Xs
 1X6z+Q39+99neF/iUzcNJFZfnV2jUG3cwzXpHT4=
X-Google-Smtp-Source: ABdhPJzLaIz+f/P5T6DPxu5flGMtJ/YHnEaWOWBmPAjKloaV4dZj4ymKw2M/FkPfsl3vrHu1TCDHWIkCwD8AmTbbbXE=
X-Received: by 2002:a05:6830:1bcf:: with SMTP id
 v15mr15780043ota.200.1637780142827; 
 Wed, 24 Nov 2021 10:55:42 -0800 (PST)
MIME-Version: 1.0
References: <20211124163612.2728640-1-alexander.deucher@amd.com>
 <b110e60d-8f0a-7ce6-5e88-0f7beff66533@amd.com>
In-Reply-To: <b110e60d-8f0a-7ce6-5e88-0f7beff66533@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 24 Nov 2021 13:55:31 -0500
Message-ID: <CADnq5_PpWO3Qui3kyjBP-+sTa7SaAbpFYaapKgTd3uP1bq5c3A@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/display: update bios scratch when setting
 backlight
To: Harry Wentland <harry.wentland@amd.com>
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Wed, Nov 24, 2021 at 1:52 PM Harry Wentland <harry.wentland@amd.com> wrote:
>
> On 2021-11-24 11:36, Alex Deucher wrote:
> > Update the bios scratch register when updating the backlight
> > level.  Some platforms apparently read this scratch register
> > and do additional operations in their hotkey handlers.
> >
> > Bug: https://gitlab.freedesktop.org/drm/amd/-/issues/1518
> > Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
>
> Maybe dce_driver_set_backlight should handle this but doing this
> in amdgpu also works. I don't know if I have a preference either
> way.

Might be helpful for other OSes unless they handle the bios scratch
registers some other way.  Also does dce_driver_set_backlight() handle
OLED and aux controlled backlights?

Alex

>
> Reviewed-by: Harry Wentland <harry.wentland@amd.com>
>
> Harry
>
> > ---
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.c      | 12 ++++++++++++
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.h      |  2 ++
> >  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |  4 ++++
> >  3 files changed, 18 insertions(+)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.c
> > index 96b7bb13a2dd..12a6b1c99c93 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.c
> > @@ -1569,6 +1569,18 @@ void amdgpu_atombios_scratch_regs_engine_hung(struct amdgpu_device *adev,
> >       WREG32(adev->bios_scratch_reg_offset + 3, tmp);
> >  }
> >
> > +void amdgpu_atombios_scratch_regs_set_backlight_level(struct amdgpu_device *adev,
> > +                                                   u32 backlight_level)
> > +{
> > +     u32 tmp = RREG32(adev->bios_scratch_reg_offset + 2);
> > +
> > +     tmp &= ~ATOM_S2_CURRENT_BL_LEVEL_MASK;
> > +     tmp |= (backlight_level << ATOM_S2_CURRENT_BL_LEVEL_SHIFT) &
> > +             ATOM_S2_CURRENT_BL_LEVEL_MASK;
> > +
> > +     WREG32(adev->bios_scratch_reg_offset + 2, tmp);
> > +}
> > +
> >  bool amdgpu_atombios_scratch_need_asic_init(struct amdgpu_device *adev)
> >  {
> >       u32 tmp = RREG32(adev->bios_scratch_reg_offset + 7);
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.h
> > index 8cc0222dba19..27e74b1fc260 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.h
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.h
> > @@ -185,6 +185,8 @@ bool amdgpu_atombios_has_gpu_virtualization_table(struct amdgpu_device *adev);
> >  void amdgpu_atombios_scratch_regs_lock(struct amdgpu_device *adev, bool lock);
> >  void amdgpu_atombios_scratch_regs_engine_hung(struct amdgpu_device *adev,
> >                                             bool hung);
> > +void amdgpu_atombios_scratch_regs_set_backlight_level(struct amdgpu_device *adev,
> > +                                                   u32 backlight_level);
> >  bool amdgpu_atombios_scratch_need_asic_init(struct amdgpu_device *adev);
> >
> >  void amdgpu_atombios_copy_swap(u8 *dst, u8 *src, u8 num_bytes, bool to_le);
> > diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> > index 40a4269770fa..05e4a0952a2b 100644
> > --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> > +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> > @@ -51,6 +51,7 @@
> >  #include <drm/drm_hdcp.h>
> >  #endif
> >  #include "amdgpu_pm.h"
> > +#include "amdgpu_atombios.h"
> >
> >  #include "amd_shared.h"
> >  #include "amdgpu_dm_irq.h"
> > @@ -3918,6 +3919,9 @@ static int amdgpu_dm_backlight_set_level(struct amdgpu_display_manager *dm,
> >       caps = dm->backlight_caps[bl_idx];
> >
> >       dm->brightness[bl_idx] = user_brightness;
> > +     /* update scratch register */
> > +     if (bl_idx == 0)
> > +             amdgpu_atombios_scratch_regs_set_backlight_level(dm->adev, dm->brightness[bl_idx]);
> >       brightness = convert_brightness_from_user(&caps, dm->brightness[bl_idx]);
> >       link = (struct dc_link *)dm->backlight_link[bl_idx];
> >
> >
>
