Return-Path: <SRS0=miQW=OD=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA7E1C433F5
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Sep 2021 18:09:48 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B9C1460EE9
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Sep 2021 18:09:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org B9C1460EE9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 445006E212;
	Mon, 13 Sep 2021 18:09:48 +0000 (UTC)
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com
 [IPv6:2607:f8b0:4864:20::332])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 67CEA6E212
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 Sep 2021 18:09:46 +0000 (UTC)
Received: by mail-ot1-x332.google.com with SMTP id
 a20-20020a0568300b9400b0051b8ca82dfcso14549214otv.3
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 Sep 2021 11:09:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=7pJ8Cw0sJ5ENa4BDF7oOfCx1q0tC5knuntJvET7/1go=;
 b=IMmcerr7c3JzesOzLy8B3TE2AvmlwFmdN1qbdbGrWhpsPT3Lhdu2mDZzp0DurZ+yox
 krOdPEaIbXUYyUC6bPhBdoAL72+HFWs0rkckkVl/F1Ou8v9wMlVluYkh8dE7V30097Sc
 kSj9hLjaVALGCcbc7v/g8rpKAs1XatF16V3cRDVuhwyjYBAjrLzt+yYtf3K2TOTHn+fK
 sfdBslHFKPDKZjlHRne+L/xe5S3KXxUvd3t0fa3yU6hfU92Nl1FLGa/0Jrd2RARd4FvI
 4RPwLu1uiU7kl8sr/KJ1duc2vpGmSQD4LLTtzMHf76v/FXYSHDqe1soKEvlEPKX3GdPF
 kc8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=7pJ8Cw0sJ5ENa4BDF7oOfCx1q0tC5knuntJvET7/1go=;
 b=BlpJxYcPU3KglxgF6Z9w/Ukk3wNSK6FmOXwdy24kXhKGoCyMUY1N/3c43uBZUCvThr
 xctf9cgQtwPZiwNZBYT1G9J5zM2I9/1f/0YMJ63BRYa9+nbgKerKtliGemUwyUK8O4gH
 ZUOFlYEEkPlAxrL3dIEIR/fhYUAB/n/EB8uS79MAZgYuElKzbujpLVXV2dX1OTr1a3Fe
 2RUMyftg5kjT/+OVR7x1L0rbTcgXY05O4O8esnZv/uOERVPOMxeunzZ1i9/TtxVU+vfr
 sqF+2ZKLtQo72gw+mwVkR/mYBEUDuBlWyaBy+a7cJprTF3lftl7wdE2eDwku+PjGyTQd
 B1dg==
X-Gm-Message-State: AOAM532L6VluxEx62s+uqpmgiZoE43+VUF2LAckwalqXZid2JpS1xWtJ
 wsNnh3jeru5EQb0D+NZ16LYNOslp4+nu+ENqoG4=
X-Google-Smtp-Source: ABdhPJy2MqI85uALoyJ6vetinmKkBq8+rX2xyIDFdJHBzGsECUoD9kb391d4WjE9/sgGYgx9koya/imefpi0doA6AKI=
X-Received: by 2002:a05:6830:25d3:: with SMTP id
 d19mr11272797otu.357.1631556585475; 
 Mon, 13 Sep 2021 11:09:45 -0700 (PDT)
MIME-Version: 1.0
References: <20210910153728.250947-1-contact@emersion.fr>
 <1a2aad48-7ecb-c6c3-9964-0ad1f8a7c36a@amd.com>
In-Reply-To: <1a2aad48-7ecb-c6c3-9964-0ad1f8a7c36a@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 13 Sep 2021 14:09:34 -0400
Message-ID: <CADnq5_MxO1yD=jS_VcTzGLnzVkVu26uSTGcqyvW7DVH4=Qj4EA@mail.gmail.com>
Subject: Re: [PATCH] amd/display: enable panel orientation quirks
To: Harry Wentland <harry.wentland@amd.com>
Cc: Simon Ser <contact@emersion.fr>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>, 
 Alex Deucher <alexander.deucher@amd.com>, Harry Wentland <hwentlan@amd.com>, 
 Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Applied.  Thanks!

Alex

On Mon, Sep 13, 2021 at 11:24 AM Harry Wentland <harry.wentland@amd.com> wrote:
>
> On 2021-09-10 11:37 a.m., Simon Ser wrote:
> > This patch allows panel orientation quirks from DRM core to be
> > used. They attach a DRM connector property "panel orientation"
> > which indicates in which direction the panel has been mounted.
> > Some machines have the internal screen mounted with a rotation.
> >
> > Since the panel orientation quirks need the native mode from the
> > EDID, check for it in amdgpu_dm_connector_ddc_get_modes.
> >
> > Signed-off-by: Simon Ser <contact@emersion.fr>
> > Cc: Alex Deucher <alexander.deucher@amd.com>
> > Cc: Harry Wentland <hwentlan@amd.com>
> > Cc: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
>
> Reviewed-by: Harry Wentland <harry.wentland@amd.com>
>
> Harry
>
> > ---
> >  .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 28 +++++++++++++++++++
> >  1 file changed, 28 insertions(+)
> >
> > diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> > index 53363728dbbd..a420602f1794 100644
> > --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> > +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> > @@ -7680,6 +7680,32 @@ static void amdgpu_dm_connector_add_common_modes(struct drm_encoder *encoder,
> >       }
> >  }
> >
> > +static void amdgpu_set_panel_orientation(struct drm_connector *connector)
> > +{
> > +     struct drm_encoder *encoder;
> > +     struct amdgpu_encoder *amdgpu_encoder;
> > +     const struct drm_display_mode *native_mode;
> > +
> > +     if (connector->connector_type != DRM_MODE_CONNECTOR_eDP &&
> > +         connector->connector_type != DRM_MODE_CONNECTOR_LVDS)
> > +             return;
> > +
> > +     encoder = amdgpu_dm_connector_to_encoder(connector);
> > +     if (!encoder)
> > +             return;
> > +
> > +     amdgpu_encoder = to_amdgpu_encoder(encoder);
> > +
> > +     native_mode = &amdgpu_encoder->native_mode;
> > +     if (native_mode->hdisplay == 0 || native_mode->vdisplay == 0)
> > +             return;
> > +
> > +     drm_connector_set_panel_orientation_with_quirk(connector,
> > +                                                    DRM_MODE_PANEL_ORIENTATION_UNKNOWN,
> > +                                                    native_mode->hdisplay,
> > +                                                    native_mode->vdisplay);
> > +}
> > +
> >  static void amdgpu_dm_connector_ddc_get_modes(struct drm_connector *connector,
> >                                             struct edid *edid)
> >  {
> > @@ -7708,6 +7734,8 @@ static void amdgpu_dm_connector_ddc_get_modes(struct drm_connector *connector,
> >                * restored here.
> >                */
> >               amdgpu_dm_update_freesync_caps(connector, edid);
> > +
> > +             amdgpu_set_panel_orientation(connector);
> >       } else {
> >               amdgpu_dm_connector->num_modes = 0;
> >       }
> >
>
