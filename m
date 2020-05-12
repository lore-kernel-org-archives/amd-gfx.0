Return-Path: <SRS0=6vDE=62=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C654C2D0F7
	for <amd-gfx@archiver.kernel.org>; Tue, 12 May 2020 20:15:54 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 09D6720740
	for <amd-gfx@archiver.kernel.org>; Tue, 12 May 2020 20:15:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="r1Uedi1/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 09D6720740
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7B6E36E97A;
	Tue, 12 May 2020 20:15:53 +0000 (UTC)
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com
 [IPv6:2a00:1450:4864:20::344])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0972C6E97A
 for <amd-gfx@lists.freedesktop.org>; Tue, 12 May 2020 20:15:51 +0000 (UTC)
Received: by mail-wm1-x344.google.com with SMTP id u16so25252894wmc.5
 for <amd-gfx@lists.freedesktop.org>; Tue, 12 May 2020 13:15:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=PIKtDsNjhu7JFAAcnChzykjQwWnAVLBfcVv31COCVDE=;
 b=r1Uedi1/+njuR38+d8V5HUG/Unfbckzzx8vd8AXnKWDfKD2lMxfOVjX08nImgj+BtE
 FQ1ilkULMczf+m9ze8hbtGe459kHKQug8VMhy2ZsWb+KWHM2bqbZf97A21LkcsPJLtfi
 n7Cl0UQm4vocWyA/Gkg7NepQYUB4IY/UV86ekIjtEF1wIs4wslwmu0npCHKZXdK3/0j7
 DJnOE81GHBI+XKYxLcZmdjWFsDREyccvs+qFNjb9eXPFaf4reRWGE67buNDoQEXJTUmT
 55IgNNvMfa8I1tG4RxIH6fbAtf+FAry/Gpcggz93/Knq3PD7UclXDucaMoVXEkLsb7Dp
 Vj7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=PIKtDsNjhu7JFAAcnChzykjQwWnAVLBfcVv31COCVDE=;
 b=DUogIuaBQSk2FrS0iBS9w+KbgaqliDz31H0lWCrYJOQNlaqChgneRbjKyDsepr9uvM
 Lq9hmjE+MWAyF6v3GnzI5Tnyr3X2y8O0rysNjMlWqcHCjdLC4+j/uAQgCEkO2n90kARp
 W5JUaFVTjjbRcw2QOhE88TDsZoiOFjasJhZ6gn4P7VcQBA0Du0rzHFcKdJNynHdzDfRE
 lR//5hdcfs0xtGJt7oSYxNCemfRu/WOOH0//zPAmCrRuoiEj8ZxoiHMfMgN5kZh1Y7cu
 mAr7/6l3oEBYLGf2XiKImPG2w2pJLOOAHq55h6oSELCZZCx7oZKhFjmKAbfE+lyQKBL2
 vo8w==
X-Gm-Message-State: AGi0Pua7yN+7Ny2vB62yKLvLF86ryfPOyhvuCTEiLOrm8JBcRFKeshSc
 F4+vBP7n600PlpjZl/gf6DGDwtkjiA1ZNhvMUUnk/w==
X-Google-Smtp-Source: APiQypLhrNwuhSg/dAnnezrC1bxHmpH8SQ0ytATw/EKk+4pEaqldIlpVzSAis2Hm2j6acqbYeMYcnT1tWkrQGvB/rqU=
X-Received: by 2002:a1c:1d41:: with SMTP id d62mr18707954wmd.79.1589314550250; 
 Tue, 12 May 2020 13:15:50 -0700 (PDT)
MIME-Version: 1.0
References: <20200505194812.185370-1-alexander.deucher@amd.com>
 <CADnq5_Oizm+QJjJ2FxQERWXdvWy_g=8=QMh2POGH5-tR44M7bA@mail.gmail.com>
In-Reply-To: <CADnq5_Oizm+QJjJ2FxQERWXdvWy_g=8=QMh2POGH5-tR44M7bA@mail.gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 12 May 2020 16:15:38 -0400
Message-ID: <CADnq5_MZAigZC_vOSTUiscnn_zrF61Es7HszD25YHh_wkstAcA@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: simplify ATIF backlight handling
To: amd-gfx list <amd-gfx@lists.freedesktop.org>
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
Cc: Alex Deucher <alexander.deucher@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Ping?

Alex

On Thu, May 7, 2020 at 12:09 PM Alex Deucher <alexdeucher@gmail.com> wrote:
>
> Ping?
>
> On Tue, May 5, 2020 at 3:48 PM Alex Deucher <alexdeucher@gmail.com> wrote:
> >
> > Just register the a pointer to the backlight device and use
> > that. Unifies the DC and non-DC handling.
> >
> > Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> > ---
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c | 73 ++++++++++--------------
> >  1 file changed, 30 insertions(+), 43 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
> > index 956cbbda4793..913c8f0513bd 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
> > @@ -64,7 +64,9 @@ struct amdgpu_atif {
> >         struct amdgpu_atif_notifications notifications;
> >         struct amdgpu_atif_functions functions;
> >         struct amdgpu_atif_notification_cfg notification_cfg;
> > -       struct amdgpu_encoder *encoder_for_bl;
> > +#if defined(CONFIG_BACKLIGHT_CLASS_DEVICE) || defined(CONFIG_BACKLIGHT_CLASS_DEVICE_MODULE)
> > +       struct backlight_device *bd;
> > +#endif
> >         struct amdgpu_dm_backlight_caps backlight_caps;
> >  };
> >
> > @@ -444,45 +446,21 @@ static int amdgpu_atif_handler(struct amdgpu_device *adev,
> >
> >                 DRM_DEBUG_DRIVER("ATIF: %d pending SBIOS requests\n", count);
> >
> > -               if ((req.pending & ATIF_PANEL_BRIGHTNESS_CHANGE_REQUEST) &&
> > -                   !amdgpu_device_has_dc_support(adev)) {
> > -                       struct amdgpu_encoder *enc = atif->encoder_for_bl;
> > -
> > -                       if (enc) {
> > -                               struct amdgpu_encoder_atom_dig *dig = enc->enc_priv;
> > -
> > -                               DRM_DEBUG_DRIVER("Changing brightness to %d\n",
> > -                                                req.backlight_level);
> > -
> > -                               amdgpu_display_backlight_set_level(adev, enc, req.backlight_level);
> > -
> > -#if defined(CONFIG_BACKLIGHT_CLASS_DEVICE) || defined(CONFIG_BACKLIGHT_CLASS_DEVICE_MODULE)
> > -                               backlight_force_update(dig->bl_dev,
> > -                                                      BACKLIGHT_UPDATE_HOTKEY);
> > -#endif
> > -                       }
> > -               }
> > -#if defined(CONFIG_DRM_AMD_DC)
> > +               if (req.pending & ATIF_PANEL_BRIGHTNESS_CHANGE_REQUEST) {
> >  #if defined(CONFIG_BACKLIGHT_CLASS_DEVICE) || defined(CONFIG_BACKLIGHT_CLASS_DEVICE_MODULE)
> > -               if ((req.pending & ATIF_PANEL_BRIGHTNESS_CHANGE_REQUEST) &&
> > -                   amdgpu_device_has_dc_support(adev)) {
> > -                       struct amdgpu_display_manager *dm = &adev->dm;
> > -                       struct backlight_device *bd = dm->backlight_dev;
> > -
> > -                       if (bd) {
> > +                       if (atif->bd) {
> >                                 DRM_DEBUG_DRIVER("Changing brightness to %d\n",
> >                                                  req.backlight_level);
> > -
> >                                 /*
> >                                  * XXX backlight_device_set_brightness() is
> >                                  * hardwired to post BACKLIGHT_UPDATE_SYSFS.
> >                                  * It probably should accept 'reason' parameter.
> >                                  */
> > -                               backlight_device_set_brightness(bd, req.backlight_level);
> > +                               backlight_device_set_brightness(atif->bd, req.backlight_level);
> >                         }
> > -               }
> > -#endif
> >  #endif
> > +               }
> > +
> >                 if (req.pending & ATIF_DGPU_DISPLAY_EVENT) {
> >                         if (adev->flags & AMD_IS_PX) {
> >                                 pm_runtime_get_sync(adev->ddev->dev);
> > @@ -829,23 +807,32 @@ int amdgpu_acpi_init(struct amdgpu_device *adev)
> >         adev->atif = atif;
> >
> >         if (atif->notifications.brightness_change) {
> > -               struct drm_encoder *tmp;
> > -
> > -               /* Find the encoder controlling the brightness */
> > -               list_for_each_entry(tmp, &adev->ddev->mode_config.encoder_list,
> > -                               head) {
> > -                       struct amdgpu_encoder *enc = to_amdgpu_encoder(tmp);
> > -
> > -                       if ((enc->devices & (ATOM_DEVICE_LCD_SUPPORT)) &&
> > -                           enc->enc_priv) {
> > -                               struct amdgpu_encoder_atom_dig *dig = enc->enc_priv;
> > -                               if (dig->bl_dev) {
> > -                                       atif->encoder_for_bl = enc;
> > -                                       break;
> > +#if defined(CONFIG_BACKLIGHT_CLASS_DEVICE) || defined(CONFIG_BACKLIGHT_CLASS_DEVICE_MODULE)
> > +               if (amdgpu_device_has_dc_support(adev)) {
> > +#if defined(CONFIG_DRM_AMD_DC)
> > +                       struct amdgpu_display_manager *dm = &adev->dm;
> > +                       atif->bd = dm->backlight_dev;
> > +#endif
> > +               } else {
> > +                       struct drm_encoder *tmp;
> > +
> > +                       /* Find the encoder controlling the brightness */
> > +                       list_for_each_entry(tmp, &adev->ddev->mode_config.encoder_list,
> > +                                           head) {
> > +                               struct amdgpu_encoder *enc = to_amdgpu_encoder(tmp);
> > +
> > +                               if ((enc->devices & (ATOM_DEVICE_LCD_SUPPORT)) &&
> > +                                   enc->enc_priv) {
> > +                                       struct amdgpu_encoder_atom_dig *dig = enc->enc_priv;
> > +                                       if (dig->bl_dev) {
> > +                                               atif->bd = dig->bl_dev;
> > +                                               break;
> > +                                       }
> >                                 }
> >                         }
> >                 }
> >         }
> > +#endif
> >
> >         if (atif->functions.sbios_requests && !atif->functions.system_params) {
> >                 /* XXX check this workraround, if sbios request function is
> > --
> > 2.25.4
> >
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
