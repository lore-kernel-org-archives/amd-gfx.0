Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89DD6C5478C
	for <amd-gfx@archiver.kernel.org>; Wed, 28 Feb 2024 14:23:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2AC5210E8F1;
	Wed, 28 Feb 2024 14:23:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="NehI6dJp";
	dkim-atps=neutral
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com
 [209.85.214.176])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8253B10E8F1
 for <amd-gfx@lists.freedesktop.org>; Wed, 28 Feb 2024 14:23:38 +0000 (UTC)
Received: by mail-pl1-f176.google.com with SMTP id
 d9443c01a7336-1dc1ff58fe4so48780355ad.1
 for <amd-gfx@lists.freedesktop.org>; Wed, 28 Feb 2024 06:23:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1709130218; x=1709735018; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oMQtDJfJbz2657iDozmqBfKfWEHJ3kHXMiT6CxUyEPE=;
 b=NehI6dJpd5D+gmx7QBjXM/QnfndieEZoq4ZKBIR1UN6tyhZfD7WbxFJgGeXOaDVjdv
 wywTXdyixgafnHWpywQnkiE35mUts2lOahOsMxST+KWe27GY6nX4BoLD1xzVWbf6jkjb
 BIQNc1CeHls0EvcgsEAXy6avjMA56L4Rz4SJ/8qeXcpyYLLCQ4W/AFE3Av1GHEwHFO/b
 C8Vq+jAF106wPWs5n7Ukmr42zuLbIEi7GELEepOlxufnozd82/VuMd+hExooe78CIII7
 ok2HDIJ6pg1Nx/x00cxVzURSK8FD0HyC447U/IgDWEkMjSG3o8mew8YZ4KGMD8ekaKdS
 mKLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709130218; x=1709735018;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=oMQtDJfJbz2657iDozmqBfKfWEHJ3kHXMiT6CxUyEPE=;
 b=b64Bxd0fyanlVfw4mikcwjUllMR/l5bGbuJgLSOt7Kz9gWwEMY4vr9DDaLdVh5Gjgv
 D6zl/QFfSVftDl9z9VWSsR5OUSeqBO8xIcPkd8oh8QMzjJcutRhhHpHa8iyDwrdXnNJw
 KPtSobUh5xNrxEoy0uZDFSXUcDg4dQEtYayCTrpsA70o7aRHno//fp0+cc48RI96mDdp
 uTx4Cj6zZj8MN/FkHCEYzYF78vy906s6EbQNjluyJ5BmSTrO0Kh2G5ls444MGSQhVlog
 R4tQ88X+gty/msie9jpz8JfPdW4fIb6yd/eiAZRTeI+Elgx8u+tXhuvpmKvhm9x3hQLp
 tY1Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCXheFxjL35RVNUdOcWivomvP1DU+Tf9cplvMsoWpdM67hJCTduVdLsHZwa/u/D8IsGexZ5GsapmtIY5aHifj9VSBVGk8s50ilsiDIeDhg==
X-Gm-Message-State: AOJu0YwpxWK0pX5UxGSz0S03/cFtKw68qenRTzBqJYqHGoQzT7zvnRrO
 bImd8EyQqGB6ngk2NmMx+0X1oJZ1VscW4qXo6Kp+pskrQ5wlxSmwiO/pfxILhgMORuoM8HjN2tV
 sCE892mOoGIz/wdYeCPFfYA8FIm4=
X-Google-Smtp-Source: AGHT+IHd6OLBdC48lkckalJ/dMijX71lsPb2eumRxNVpYiANAhobqRchBxJ59n+mETJ1T4u9e8xelRn/3Wdckd/AtPY=
X-Received: by 2002:a17:90a:d60d:b0:29a:71e7:ef68 with SMTP id
 w13-20020a17090ad60d00b0029a71e7ef68mr10475362pju.1.1709130217607; Wed, 28
 Feb 2024 06:23:37 -0800 (PST)
MIME-Version: 1.0
References: <20240227184847.3078099-1-alexander.deucher@amd.com>
 <7e13e8d8-e486-4739-9844-f0b95861d34c@gmail.com>
In-Reply-To: <7e13e8d8-e486-4739-9844-f0b95861d34c@gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 28 Feb 2024 09:23:25 -0500
Message-ID: <CADnq5_OSLcbSX2H4b72YRVGz7GQqHg-8bcNWxdUdcoqAwP=dsg@mail.gmail.com>
Subject: Re: [PATCH 1/2] Revert "drm/amd: Remove freesync video mode amdgpu
 parameter"
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
Cc: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Wed, Feb 28, 2024 at 2:03=E2=80=AFAM Christian K=C3=B6nig
<ckoenig.leichtzumerken@gmail.com> wrote:
>
> Am 27.02.24 um 19:48 schrieb Alex Deucher:
> > This reverts commit e94e787e37b99645e7c02d20d0a1ba0f8a18a82a.
> >
> > This conflicts with how compositors want to handle VRR.  Now
> > that compositors actually handle VRR, we probably don't need
> > freesync video.
> >
> > Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/2985
>
> Scratching my head what actually happens here? Doesn't the problem then
> just depend on a module parameter?

Yes.  The problem is that when freesync video is enabled, compositors
don't know which modes are actual modes and which are a VRR video
mode.  There are still customers that want the vrr video mode smooth
video playback, but compositors don't want this by default.  I guess
the alternative is to just drop this feature altogether now that
compositors and media players are starting to support this properly.

Alex

>
> Regards,
> Christian.
>
> > Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> > ---
> >   drivers/gpu/drm/amd/amdgpu/amdgpu.h     |  1 +
> >   drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 27 ++++++++++++++++++++++++=
+
> >   2 files changed, 28 insertions(+)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/=
amdgpu/amdgpu.h
> > index 0e365cadcc3fc..925026c183f41 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> > @@ -194,6 +194,7 @@ extern int amdgpu_emu_mode;
> >   extern uint amdgpu_smu_memory_pool_size;
> >   extern int amdgpu_smu_pptable_id;
> >   extern uint amdgpu_dc_feature_mask;
> > +extern uint amdgpu_freesync_vid_mode;
> >   extern uint amdgpu_dc_debug_mask;
> >   extern uint amdgpu_dc_visual_confirm;
> >   extern int amdgpu_dm_abm_level;
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_drv.c
> > index 15a8a64fc4e28..82b154b103f43 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> > @@ -199,6 +199,7 @@ int amdgpu_mes_kiq;
> >   int amdgpu_noretry =3D -1;
> >   int amdgpu_force_asic_type =3D -1;
> >   int amdgpu_tmz =3D -1; /* auto */
> > +uint amdgpu_freesync_vid_mode;
> >   int amdgpu_reset_method =3D -1; /* auto */
> >   int amdgpu_num_kcq =3D -1;
> >   int amdgpu_smartshift_bias;
> > @@ -883,6 +884,32 @@ module_param_named(damageclips, amdgpu_damage_clip=
s, int, 0444);
> >   MODULE_PARM_DESC(tmz, "Enable TMZ feature (-1 =3D auto (default), 0 =
=3D off, 1 =3D on)");
> >   module_param_named(tmz, amdgpu_tmz, int, 0444);
> >
> > +/**
> > + * DOC: freesync_video (uint)
> > + * Enable the optimization to adjust front porch timing to achieve sea=
mless
> > + * mode change experience when setting a freesync supported mode for w=
hich full
> > + * modeset is not needed.
> > + *
> > + * The Display Core will add a set of modes derived from the base Free=
Sync
> > + * video mode into the corresponding connector's mode list based on co=
mmonly
> > + * used refresh rates and VRR range of the connected display, when use=
rs enable
> > + * this feature. From the userspace perspective, they can see a seamle=
ss mode
> > + * change experience when the change between different refresh rates u=
nder the
> > + * same resolution. Additionally, userspace applications such as Video=
 playback
> > + * can read this modeset list and change the refresh rate based on the=
 video
> > + * frame rate. Finally, the userspace can also derive an appropriate m=
ode for a
> > + * particular refresh rate based on the FreeSync Mode and add it to th=
e
> > + * connector's mode list.
> > + *
> > + * Note: This is an experimental feature.
> > + *
> > + * The default value: 0 (off).
> > + */
> > +MODULE_PARM_DESC(
> > +     freesync_video,
> > +     "Enable freesync modesetting optimization feature (0 =3D off (def=
ault), 1 =3D on)");
> > +module_param_named(freesync_video, amdgpu_freesync_vid_mode, uint, 044=
4);
> > +
> >   /**
> >    * DOC: reset_method (int)
> >    * GPU reset method (-1 =3D auto (default), 0 =3D legacy, 1 =3D mode0=
, 2 =3D mode1, 3 =3D mode2, 4 =3D baco)
>
