Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46414C54E76
	for <amd-gfx@archiver.kernel.org>; Fri, 17 Nov 2023 03:07:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D4D9E10E104;
	Fri, 17 Nov 2023 03:07:42 +0000 (UTC)
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com
 [IPv6:2607:f8b0:4864:20::336])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DAC6710E104
 for <amd-gfx@lists.freedesktop.org>; Fri, 17 Nov 2023 03:07:40 +0000 (UTC)
Received: by mail-ot1-x336.google.com with SMTP id
 46e09a7af769-6ce2cf67be2so797358a34.2
 for <amd-gfx@lists.freedesktop.org>; Thu, 16 Nov 2023 19:07:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1700190460; x=1700795260; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=g9weXpnIVBxEYdf39HO2zNo2Jvvu7R57UuPdQ3KpDRE=;
 b=kTjxqThtEEGWmQN26IIvBWNfX1FIZLR7vsYKhTUCkS+7f8LBMSkIj6+G0svmP700zf
 Wg/oskCfx1bkbalQYWJ0Tcz3ZqcNLEuy9M+UpojUOGw8/3qyNFcnXP24FlscQRDHX8Uq
 XD3mgq69VdQvCHuuMvm4FURU08eAudmI/UnGI+SoewAgmiFtr164rJutjoKn1A0cvboI
 fMOijkdbG8+ZITQIN3GtmyN24hH3xUYSI/TqBpee2WwhQxfyczB10NEmZHtOIZuFBod7
 D9x9h6vbvZpgEloD4fkoV+4Ach3TSp7SY+1XFqs9RlRlQ8Ksy3RpWys67oozuZbeukm4
 t3Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700190460; x=1700795260;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=g9weXpnIVBxEYdf39HO2zNo2Jvvu7R57UuPdQ3KpDRE=;
 b=jhK3n3k19sulEX5QmLt1s+zkorzr8DQJtKUKrm9dfBpew4RGZhqfH4+WOiPhW2LcFU
 4IJf+RqFUrtuYN6yQVq5MhnplVscpFOB6FCoxLnW5O1boPLZC1ql70XB02ooY0D/twVw
 TD9bJVs3Wx3kurwXMuCjAUa2PyYp9V52Jipcl9Aa5xqBhm7sHjlZCExdKy8xARFGrSow
 uuNbDFVxASISOqtms0DfnXm+zdD9sUMmmV4KQWGK2OboTLp/kxEHYwb18Y/5BB5KHGb9
 RYfunWPOaPHy4q9YbI6k45gnFrxF5LVoOxSWR1EiuXVqOOB/I3pwWpOasl06uM91fnl7
 WFWQ==
X-Gm-Message-State: AOJu0YylGr5AB1uz70z2QVASCJ3XMotfpnMtHMzcpI/Rbq4sD+fJjpim
 sxJjOLFVam3kfQt+SmewnCvs0yrUvaWCrPs2rco=
X-Google-Smtp-Source: AGHT+IHvzlXZrtivAfFRdp+dTf7EhVn4pf4LUaNqv5SUbWv4ZGGBla0nRUIYKPs+B7ksDZ7b9MwlI/UP5oohABms+rs=
X-Received: by 2002:a05:6870:6494:b0:1f0:5e1f:4518 with SMTP id
 cz20-20020a056870649400b001f05e1f4518mr22474856oab.37.1700190459991; Thu, 16
 Nov 2023 19:07:39 -0800 (PST)
MIME-Version: 1.0
References: <20231109073701.1751965-1-Prike.Liang@amd.com>
 <BL1PR12MB5144F2D77CE97D32889DCBFCF7AFA@BL1PR12MB5144.namprd12.prod.outlook.com>
 <DS7PR12MB6005A5E74DC33F4D86BC6138FBB2A@DS7PR12MB6005.namprd12.prod.outlook.com>
In-Reply-To: <DS7PR12MB6005A5E74DC33F4D86BC6138FBB2A@DS7PR12MB6005.namprd12.prod.outlook.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 16 Nov 2023 22:07:28 -0500
Message-ID: <CADnq5_NTV-q7fMg8L4Gy=D6bkJ5NvWsDGh36CB1f+a_AJLa0KQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] drm/amdgpu: correct the amdgpu runtime dereference
 usage count
To: "Liang, Prike" <Prike.Liang@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Mon, Nov 13, 2023 at 10:02=E2=80=AFPM Liang, Prike <Prike.Liang@amd.com>=
 wrote:
>
> [Public]
>
> > -----Original Message-----
> > From: Deucher, Alexander <Alexander.Deucher@amd.com>
> > Sent: Friday, November 10, 2023 5:46 AM
> > To: Liang, Prike <Prike.Liang@amd.com>; amd-gfx@lists.freedesktop.org
> > Subject: RE: [PATCH 1/2] drm/amdgpu: correct the amdgpu runtime
> > dereference usage count
> >
> > [Public]
> >
> > > -----Original Message-----
> > > From: Liang, Prike <Prike.Liang@amd.com>
> > > Sent: Thursday, November 9, 2023 2:37 AM
> > > To: amd-gfx@lists.freedesktop.org
> > > Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Liang, Prike
> > > <Prike.Liang@amd.com>
> > > Subject: [PATCH 1/2] drm/amdgpu: correct the amdgpu runtime
> > > dereference usage count
> > >
> > > Fix the amdgpu runpm dereference usage count.
> > >
> > > Signed-off-by: Prike Liang <Prike.Liang@amd.com>
> > > ---
> > >  drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c | 2 +-
> > > drivers/gpu/drm/amd/amdgpu/amdgpu_display.c | 1 +
> > >  2 files changed, 2 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
> > > b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
> > > index a53f436fa9f1..f6bbbbe5d9f7 100644
> > > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
> > > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
> > > @@ -1992,7 +1992,7 @@ static int amdgpu_debugfs_sclk_set(void *data,
> > > u64 val)
> > >
> > >       ret =3D amdgpu_dpm_set_soft_freq_range(adev, PP_SCLK,
> > > (uint32_t)val, (uint32_t)val);
> > >       if (ret)
> > > -             ret =3D -EINVAL;
> > > +             goto out;
> >
> > I think this hunk can be dropped.  It doesn't really change anything.  =
Or you
> > could just drop the whole ret check since we just return ret at the end
> > anyway.  Not sure if changing the error code is important here or not.
> >
> [Prike] Thanks for pointing it out, revisit this part that seems ok for r=
eassign the return value when the caller function can't return a proper err=
or type.
> I will keep this part as the unmodified since this has no problem for der=
eferencing the runpm usage.
> > >
> > >  out:
> > >       pm_runtime_mark_last_busy(adev_to_drm(adev)->dev);
> > > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
> > > b/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
> > > index 0cacd0b9f8be..ff1f42ae6d8e 100644
> > > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
> > > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
> > > @@ -346,6 +346,7 @@ int amdgpu_display_crtc_set_config(struct
> > > drm_mode_set *set,
> > >       if (!active && adev->have_disp_power_ref) {
> > >               pm_runtime_put_autosuspend(dev->dev);
> > >               adev->have_disp_power_ref =3D false;
> > > +             return ret;
> > >       }
> >
> > I think it would be cleaner to just drop the runtime_put above and upda=
te
> > the comment.  We'll just fall through to the end of the function.
> >
> > Alex
> >
> [Prike]  Do you mean something like as the following? I will submit a new=
 patch for this.

Just drop the goto out.  E.g.

         if (!active && adev->have_disp_power_ref)
                adev->have_disp_power_ref =3D false;

Alex

>
> -       /* if we have no active crtcs, then drop the power ref
> -        * we got before
> +       /* if we have no active crtcs, then go to
> +        * drop the power ref we got before
>          */
>         if (!active && adev->have_disp_power_ref) {
> -               pm_runtime_put_autosuspend(dev->dev);
>                 adev->have_disp_power_ref =3D false;
> +               goto out;
>         }
> > >
> > >  out:
> > > --
> > > 2.34.1
> >
>
