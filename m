Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BB66C433EF
	for <amd-gfx@archiver.kernel.org>; Tue, 15 Feb 2022 14:09:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6901810E545;
	Tue, 15 Feb 2022 14:09:10 +0000 (UTC)
Received: from mail-il1-x134.google.com (mail-il1-x134.google.com
 [IPv6:2607:f8b0:4864:20::134])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E070010E497
 for <amd-gfx@lists.freedesktop.org>; Tue, 15 Feb 2022 13:08:42 +0000 (UTC)
Received: by mail-il1-x134.google.com with SMTP id p11so14761663ils.1
 for <amd-gfx@lists.freedesktop.org>; Tue, 15 Feb 2022 05:08:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=h8vn3ZFW8UjLnMLsgl86dcA80MaxOlksJ/pmKV8vWGU=;
 b=Xw6MjLP9Kt6wH/XPSkTrQGGvUPWDpKraFYxM4d6yH3RKbYA/YECy72aCJttKSuP587
 10FtshqY75bNZ0wPI428PCyMW2OAb6yh/TT1o8uOiXl/AYRQtBPDYcnJeIpx7cQYKuhp
 wqae+oOmMT9dVZpOYgXDUMAKab0DYkhYdVNJ0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=h8vn3ZFW8UjLnMLsgl86dcA80MaxOlksJ/pmKV8vWGU=;
 b=fTAFONWGEaDPjPs35uJeUf/ll0ALM6VhYBGTqjgEtOf6pSBtmYsLsrp/ER4Y3owfuX
 IjnRNN7uXcRJKQ1IJYz/St7ImKqB7ah/tSsPyIlcvk5k3DfogN9AgezKWKlZWZgUvZPT
 T1+VFegdH43u0YQ/lA2K4DtDMY9cHK6EmEIRp7izWC19a7Dx6wKKVmsqE4T3E5BYn06w
 QOjVrro7wHcXLT7PmxqdSh0Y4BTYVddYF1brw+1y3ME9wiLepi6aXfYXLy8FjkU3Htk7
 +EpS/vnFOnqflcFGqkre+MPcZ8CkSREJ4ykcF790qZXGMTe2oTE7CaV2qLpaoCxuX0AL
 Z9YQ==
X-Gm-Message-State: AOAM531BVPPGPE/K108Vvsy4cvcO2GXGgTqkH+4le1BstPSSF8U+PJK5
 pfklEG1ySbG4p999UxnEVZ/iFaY80/eolSegvBq0kw==
X-Google-Smtp-Source: ABdhPJyn0t3qtaQoYKT56xmJWFr+oDNaEgC/gP1GxkSxrJmyzV5aD6tH7GwuIxyug6WO9KvMRXh2z7t2mVNvKMkI28E=
X-Received: by 2002:a05:6e02:18c6:: with SMTP id
 s6mr2544341ilu.230.1644930522121; 
 Tue, 15 Feb 2022 05:08:42 -0800 (PST)
MIME-Version: 1.0
References: <20220208084234.1684930-1-hsinyi@chromium.org>
 <87leydhqt3.fsf@collabora.com>
 <CAJMQK-igpiYj-pkgG9amrQuVzf1Mc9BDDOwOdKLUbceKr=CHiQ@mail.gmail.com>
 <87czjoixno.fsf@collabora.com>
In-Reply-To: <87czjoixno.fsf@collabora.com>
From: Hsin-Yi Wang <hsinyi@chromium.org>
Date: Tue, 15 Feb 2022 21:08:16 +0800
Message-ID: <CAJMQK-gvvvhj2dsu8bkT6ytj=0MZaRFmsVOqJVrtVo4Y+XCEdQ@mail.gmail.com>
Subject: Re: [PATCH v8 1/3] gpu: drm: separate panel orientation property
 creating and value setting
To: Gabriel Krisman Bertazi <krisman@collabora.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Tue, 15 Feb 2022 14:09:09 +0000
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
Cc: Maxime Ripard <mripard@kernel.org>, Chun-Kuang Hu <chunkuang.hu@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, devicetree@vger.kernel.org,
 David Airlie <airlied@linux.ie>, Simon Ser <contact@emersion.fr>,
 intel-gfx@lists.freedesktop.org,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org,
 Alex Deucher <alexander.deucher@amd.com>,
 Jani Nikula <jani.nikula@linux.intel.com>, Rob Herring <robh+dt@kernel.org>,
 linux-mediatek@lists.infradead.org, dri-devel@lists.freedesktop.org,
 Daniel Vetter <daniel@ffwll.ch>, Harry Wentland <harry.wentland@amd.com>,
 Matthias Brugger <matthias.bgg@gmail.com>, Sean Paul <sean@poorly.run>,
 linux-arm-kernel@lists.infradead.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Tue, Feb 15, 2022 at 12:03 PM Gabriel Krisman Bertazi
<krisman@collabora.com> wrote:
>
> Hsin-Yi Wang <hsinyi@chromium.org> writes:
>
> > On Tue, Feb 15, 2022 at 9:17 AM Gabriel Krisman Bertazi
> > <krisman@collabora.com> wrote:
> >>
> >> Hsin-Yi Wang <hsinyi@chromium.org> writes:
> >>
> >> > drm_dev_register() sets connector->registration_state to
> >> > DRM_CONNECTOR_REGISTERED and dev->registered to true. If
> >> > drm_connector_set_panel_orientation() is first called after
> >> > drm_dev_register(), it will fail several checks and results in following
> >> > warning.
> >>
> >> Hi,
> >>
> >> I stumbled upon this when investigating the same WARN_ON on amdgpu.
> >> Thanks for the patch :)
> >>
> >> > diff --git a/drivers/gpu/drm/drm_connector.c b/drivers/gpu/drm/drm_connector.c
> >> > index a50c82bc2b2fec..572ead7ac10690 100644
> >> > --- a/drivers/gpu/drm/drm_connector.c
> >> > +++ b/drivers/gpu/drm/drm_connector.c
> >> > @@ -1252,7 +1252,7 @@ static const struct drm_prop_enum_list dp_colorspaces[] = {
> >> >   *   INPUT_PROP_DIRECT) will still map 1:1 to the actual LCD panel
> >> >   *   coordinates, so if userspace rotates the picture to adjust for
> >> >   *   the orientation it must also apply the same transformation to the
> >> > - *   touchscreen input coordinates. This property is initialized by calling
> >> > + *   touchscreen input coordinates. This property value is set by calling
> >> >   *   drm_connector_set_panel_orientation() or
> >> >   *   drm_connector_set_panel_orientation_with_quirk()
> >> >   *
> >> > @@ -2341,8 +2341,8 @@ EXPORT_SYMBOL(drm_connector_set_vrr_capable_property);
> >> >   * @connector: connector for which to set the panel-orientation property.
> >> >   * @panel_orientation: drm_panel_orientation value to set
> >> >   *
> >> > - * This function sets the connector's panel_orientation and attaches
> >> > - * a "panel orientation" property to the connector.
> >> > + * This function sets the connector's panel_orientation value. If the property
> >> > + * doesn't exist, it will try to create one.
> >> >   *
> >> >   * Calling this function on a connector where the panel_orientation has
> >> >   * already been set is a no-op (e.g. the orientation has been overridden with
> >> > @@ -2373,19 +2373,12 @@ int drm_connector_set_panel_orientation(
> >> >       info->panel_orientation = panel_orientation;
> >> >
> >> >       prop = dev->mode_config.panel_orientation_property;
> >> > -     if (!prop) {
> >> > -             prop = drm_property_create_enum(dev, DRM_MODE_PROP_IMMUTABLE,
> >> > -                             "panel orientation",
> >> > -                             drm_panel_orientation_enum_list,
> >> > -                             ARRAY_SIZE(drm_panel_orientation_enum_list));
> >> > -             if (!prop)
> >> > -                     return -ENOMEM;
> >> > -
> >> > -             dev->mode_config.panel_orientation_property = prop;
> >> > -     }
> >> > +     if (!prop &&
> >> > +         drm_connector_init_panel_orientation_property(connector) < 0)
> >> > +             return -ENOMEM;
> >> >
> >>
> >> In the case where the property has not been created beforehand, you
> >> forgot to reinitialize prop here, after calling
> >> drm_connector_init_panel_orientation_property().  This means
> > hi Gabriel,
> >
> > drm_connector_init_panel_orientation_property() will create prop if
> > it's null. If prop fails to be created there, it will return -ENOMEM.
>
> Yes.  But *after the property is successfully created*, the prop variable is still
> NULL.  And then you call the following, using prop, which is still NULL:
>
> >> > +     drm_object_property_set_value(&connector->base, prop,
> >> > +                                   info->panel_orientation);
>
> This will do property->dev right on the first line of code, and dereference the
> null prop pointer.

Ah, right. Sorry that I totally missed this.
I'll fix it in the next version if the idea of this patch is accepted.
There might be another preferred solution for this.

>
> You must do
>
>   prop = dev->mode_config.panel_orientation_property;
>
> again after drm_connector_init_panel_orientation_property successfully
> returns, or call drm_object_property_set_value using
> dev->mode_config.panel_orientation_property directly:
>
>   drm_object_property_set_value(&connector->base,
>                         dev->mode_config.panel_orientation_property
>                         info->panel_orientation);
>
> --
> Gabriel Krisman Bertazi
