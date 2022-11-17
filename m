Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A80EC4332F
	for <amd-gfx@archiver.kernel.org>; Thu, 17 Nov 2022 15:55:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8DDD810E641;
	Thu, 17 Nov 2022 15:55:33 +0000 (UTC)
Received: from mail-oa1-x2d.google.com (mail-oa1-x2d.google.com
 [IPv6:2001:4860:4864:20::2d])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 94DA910E642
 for <amd-gfx@lists.freedesktop.org>; Thu, 17 Nov 2022 15:55:30 +0000 (UTC)
Received: by mail-oa1-x2d.google.com with SMTP id
 586e51a60fabf-13b6c1c89bdso2571996fac.13
 for <amd-gfx@lists.freedesktop.org>; Thu, 17 Nov 2022 07:55:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ChmUvSXCkQktxkWwFvIF8i2hGji06NSqTmii2L0yGLA=;
 b=MikH5UuySH76tLJFMbstvf5KWbVhh3HIdTvuD769q+uxXS9Sh9HNNnuelv/ieuc1DQ
 rwgInq963VpCXdglaeH7xchy+UM9abqdYfXL7rzmpGOPm+az0QP5rxBTYwwGU12wdY9h
 ExQGL7SqQdnMpzugWmtyKPjk3gayrojFx5EhbC+/cs4HPOPqJueGZwQWHbYF7vUsWRcX
 BmROgr0f571d/oI1WZ8N0JD/LX/iECuE4CwQBaOn48zd1QqUamGBaepaGVXryZ2tc0vu
 obLFN09GYLKPOhsCqC8J+Ze8qPVImcFslPQsTZZwhSlWvElluxEPREQd39kUm8L8Dgid
 NOOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ChmUvSXCkQktxkWwFvIF8i2hGji06NSqTmii2L0yGLA=;
 b=8RUMRj1N3UZ/KFoHEM80Dls2J3+eJpSX3XDCUGey8FNl6eEWRWL/3WKF2f4siZKUCA
 5jJDTzjmJYkfwkGPJ5bwwgdbgVdcO0J/06xzbG/5PK2nfGrDe1LB9Knvl7DtgGm9mlKT
 lJm8phPeco3Ek7grsENoQpLZAZreUq9wWhyeBy9Pg1HLrDzPACYT1xwIAtDYzunBuScN
 x/6xgOs7fmjZDUhSzJnGofHKAiOF+Wp1fL0V4dzWRHDZWgtvXkG8DLsz4BZ/TpSx9gna
 Gj3RPYqfDZ81arxCPI3AhdIzSUSqwsouLJJVBwVXhhCUVGFVgO9XyaQyIGGxZ9+rlFDl
 HS8Q==
X-Gm-Message-State: ANoB5pkv+vQUXbwQJGe/bz8PGvCkJiip3K+r8VExVBXU1CwcEpf35WIB
 UqVeUTrlhJ9BpeV7i4iC5m635Fb3a+O9HWe2GNg=
X-Google-Smtp-Source: AA0mqf6kDTYVB7Jxe/Rsq+rrh/g3xEbjgFbubP5P7zV2fOnEGNhcGqi/ne8jtCaIZSOYAWBvXKEoOrkH30LrmwRYrZs=
X-Received: by 2002:a05:6870:2b05:b0:12d:58c1:33f9 with SMTP id
 ld5-20020a0568702b0500b0012d58c133f9mr4831234oab.46.1668700529815; Thu, 17
 Nov 2022 07:55:29 -0800 (PST)
MIME-Version: 1.0
References: <20221116160111.3226-1-christian.koenig@amd.com>
 <20221116160111.3226-2-christian.koenig@amd.com>
 <CADnq5_MccS8DkM9kLmamDH3wcNeJZeczAqqHc+gfxFLRrb-GSQ@mail.gmail.com>
In-Reply-To: <CADnq5_MccS8DkM9kLmamDH3wcNeJZeczAqqHc+gfxFLRrb-GSQ@mail.gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 17 Nov 2022 10:55:18 -0500
Message-ID: <CADnq5_OtYNV2AtKxK1ZPsv_usM5kbwtm66PT5ZyCV657MHRfdA@mail.gmail.com>
Subject: Re: [PATCH 2/3] drm/amdgpu: stop freeing PSP buffers during suspend
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
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
Cc: amd-gfx@lists.freedesktop.org, arunpravin.paneerselvam@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Hey Christian,

Do you have a preference on which solution we go with?  I'm inclined
to go with my patch just because it's more self-contained and easier
to deal with for stable, but I could be convinced otherwise.

Alex

On Wed, Nov 16, 2022 at 11:38 AM Alex Deucher <alexdeucher@gmail.com> wrote=
:
>
> I was thinking something like this would be more straightforward.
>
> Alex
>
> On Wed, Nov 16, 2022 at 11:01 AM Christian K=C3=B6nig
> <ckoenig.leichtzumerken@gmail.com> wrote:
> >
> > That the PSP code tries to free the memory during suspend is quite
> > broken and leads to problems during resume.
> >
> > Signed-off-by: Christian K=C3=B6nig <christian.koenig@amd.com>
> > ---
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 30 ++++++++++---------------
> >  1 file changed, 12 insertions(+), 18 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_psp.c
> > index 0a8c30475dda..470cd660c450 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> > @@ -511,11 +511,10 @@ static int psp_sw_fini(void *handle)
> >         kfree(cmd);
> >         cmd =3D NULL;
> >
> > -       if (psp->km_ring.ring_mem)
> > -               amdgpu_bo_free_kernel(&adev->firmware.rbuf,
> > -                                     &psp->km_ring.ring_mem_mc_addr,
> > -                                     (void **)&psp->km_ring.ring_mem);
> > -
> > +       psp_free_shared_bufs(psp);
> > +       amdgpu_bo_free_kernel(&adev->firmware.rbuf,
> > +                             &psp->km_ring.ring_mem_mc_addr,
> > +                             (void **)&psp->km_ring.ring_mem);
> >         amdgpu_bo_free_kernel(&psp->fw_pri_bo,
> >                               &psp->fw_pri_mc_addr, &psp->fw_pri_buf);
> >         amdgpu_bo_free_kernel(&psp->fence_buf_bo,
> > @@ -2635,8 +2634,6 @@ static int psp_hw_fini(void *handle)
> >
> >         psp_ring_destroy(psp, PSP_RING_TYPE__KM);
> >
> > -       psp_free_shared_bufs(psp);
> > -
> >         return 0;
> >  }
> >
> > @@ -2651,7 +2648,7 @@ static int psp_suspend(void *handle)
> >                 ret =3D psp_xgmi_terminate(psp);
> >                 if (ret) {
> >                         DRM_ERROR("Failed to terminate xgmi ta\n");
> > -                       goto out;
> > +                       return ret;
> >                 }
> >         }
> >
> > @@ -2659,40 +2656,40 @@ static int psp_suspend(void *handle)
> >                 ret =3D psp_ras_terminate(psp);
> >                 if (ret) {
> >                         DRM_ERROR("Failed to terminate ras ta\n");
> > -                       goto out;
> > +                       return ret;
> >                 }
> >                 ret =3D psp_hdcp_terminate(psp);
> >                 if (ret) {
> >                         DRM_ERROR("Failed to terminate hdcp ta\n");
> > -                       goto out;
> > +                       return ret;
> >                 }
> >                 ret =3D psp_dtm_terminate(psp);
> >                 if (ret) {
> >                         DRM_ERROR("Failed to terminate dtm ta\n");
> > -                       goto out;
> > +                       return ret;
> >                 }
> >                 ret =3D psp_rap_terminate(psp);
> >                 if (ret) {
> >                         DRM_ERROR("Failed to terminate rap ta\n");
> > -                       goto out;
> > +                       return ret;
> >                 }
> >                 ret =3D psp_securedisplay_terminate(psp);
> >                 if (ret) {
> >                         DRM_ERROR("Failed to terminate securedisplay ta=
\n");
> > -                       goto out;
> > +                       return ret;
> >                 }
> >         }
> >
> >         ret =3D psp_asd_terminate(psp);
> >         if (ret) {
> >                 DRM_ERROR("Failed to terminate asd\n");
> > -               goto out;
> > +               return ret;
> >         }
> >
> >         ret =3D psp_tmr_terminate(psp);
> >         if (ret) {
> >                 DRM_ERROR("Failed to terminate tmr\n");
> > -               goto out;
> > +               return ret;
> >         }
> >
> >         ret =3D psp_ring_stop(psp, PSP_RING_TYPE__KM);
> > @@ -2700,9 +2697,6 @@ static int psp_suspend(void *handle)
> >                 DRM_ERROR("PSP ring stop failed\n");
> >         }
> >
> > -out:
> > -       psp_free_shared_bufs(psp);
> > -
> >         return ret;
> >  }
> >
> > --
> > 2.34.1
> >
