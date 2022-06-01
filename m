Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6DFCEC433EF
	for <amd-gfx@archiver.kernel.org>; Wed,  1 Jun 2022 18:02:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0E99110F1DC;
	Wed,  1 Jun 2022 18:02:02 +0000 (UTC)
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com
 [IPv6:2607:f8b0:4864:20::234])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D3B6710F1DC
 for <amd-gfx@lists.freedesktop.org>; Wed,  1 Jun 2022 18:02:00 +0000 (UTC)
Received: by mail-oi1-x234.google.com with SMTP id y131so3632973oia.6
 for <amd-gfx@lists.freedesktop.org>; Wed, 01 Jun 2022 11:02:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=823SzKqbXepwWSVAXMblLQvXwWBi4gaHNkcX1sCtsKI=;
 b=l+j201cgVCN9KAcU6wnU2RWsrdNHmawGbrAnhENb8+kn2Tdvs83U0RmdwOKyzbMKup
 TJq3EiG96JAWmiJmPmk3QrseBIMzui5GeeJyOAJSNNl1jADY/y69hBN5NSKP6CVdMDEv
 nJgVD5qGOPeYMOjTvDrNt4aweCfp6WelSARZ3CTMTLyztv1V1YbvZTLdjQbiZmuY2F38
 6AVvISvdZP140CCfB9tDWW3xVL1Mcpi+/om6fSFNr/Ep1FvPPOetgygPR/IvJ5pSx+a6
 71X0KuWPkfvnuuBC407h4LTbjqOUFz2M7jq2HUJ+8CcWaleggSm06y/bO2sm7dB3jt+O
 HMBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=823SzKqbXepwWSVAXMblLQvXwWBi4gaHNkcX1sCtsKI=;
 b=Meoev1yvhvAnTHIsnnNZRzOY4GqSFEUaaN7H5pYCs7IY1tG6d/fHvtbgOOXuREQyoZ
 dxoui6nnzki8cFEWzwcGUp/HXOzrGj5CJ5u53lDaJPovPDWzdqbdpoMN6pnirKkL2QNr
 BjNUhCwI5jWTywzPmNxapQpErGY+8GqKRSD4Tyi58ysLBpMGSRp+7/cIlIliQdr2/29G
 BHnFc5bgoh6QAUBlY9nac4thywAmzpeLXgsBTIW96AniBmZ+4J6utBMWDdDED4qoCldW
 v8wH4uKVxtB/BDEAMsu0B1tpeEFv+PjOKpcfzhEujFUkzug6w11pAzHeFQr6bYwsVfrj
 47fg==
X-Gm-Message-State: AOAM530AUMI0l2V3Whi3Q1MEIMuq0OrX9ws0YlKlC5F9vop9iaN0OYBp
 0rOmdXIRgXsa7BmO1ZwOJRMjiSbYTolsjYPKs4UfpoCY
X-Google-Smtp-Source: ABdhPJz7KvWvabvo7f/eVG9yUPzrNA4iEge7dkCuoyvtKt085wQcCUthei1sZYSc9XfkYhi7FuGZcLSVaonf1LUTBOo=
X-Received: by 2002:a05:6808:15a7:b0:32b:aeac:84d0 with SMTP id
 t39-20020a05680815a700b0032baeac84d0mr381859oiw.253.1654106519728; Wed, 01
 Jun 2022 11:01:59 -0700 (PDT)
MIME-Version: 1.0
References: <20220601175610.28448-1-candice.li@amd.com>
 <CADnq5_NbW5PvP=-VpFY7w1RaUTCM16RS+YoaRft8D5HoGLfsSw@mail.gmail.com>
In-Reply-To: <CADnq5_NbW5PvP=-VpFY7w1RaUTCM16RS+YoaRft8D5HoGLfsSw@mail.gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 1 Jun 2022 14:01:48 -0400
Message-ID: <CADnq5_PGWok_hBnYde5uW_g9ynk6cdE5BMzV7fuNkYxPW0rokg@mail.gmail.com>
Subject: Re: [PATCH v2] drm/amdgpu: Resolve RAS GFX error count issue v2
To: Candice Li <candice.li@amd.com>
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
Cc: amd-gfx list <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Wed, Jun 1, 2022 at 2:01 PM Alex Deucher <alexdeucher@gmail.com> wrote:
>
> On Wed, Jun 1, 2022 at 1:57 PM Candice Li <candice.li@amd.com> wrote:
> >
> > Fix misleading indentation and add ras unsupported checking
> > for gfx ras late init.
> >
> > Signed-off-by: Candice Li <candice.li@amd.com>
>
> Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

Also, if this was a recent change, a Fixes: tag would be nice.

Alex

>
> > ---
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c | 8 +++++---
> >  1 file changed, 5 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> > index 99c1a2d3dae84d..16699158e00d8c 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> > @@ -599,13 +599,15 @@ int amdgpu_gfx_ras_late_init(struct amdgpu_device *adev, struct ras_common_if *r
> >                 if (!amdgpu_persistent_edc_harvesting_supported(adev))
> >                         amdgpu_ras_reset_error_status(adev, AMDGPU_RAS_BLOCK__GFX);
> >
> > -       r = amdgpu_ras_block_late_init(adev, ras_block);
> > -       if (r)
> > -               return r;
> > +               r = amdgpu_ras_block_late_init(adev, ras_block);
> > +               if (r)
> > +                       return r;
> >
> >                 r = amdgpu_irq_get(adev, &adev->gfx.cp_ecc_error_irq, 0);
> >                 if (r)
> >                         goto late_fini;
> > +       } else {
> > +               amdgpu_ras_feature_enable_on_boot(adev, ras_block, 0);
> >         }
> >
> >         return 0;
> > --
> > 2.17.1
> >
