Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A8FEC433FE
	for <amd-gfx@archiver.kernel.org>; Mon, 25 Apr 2022 18:00:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 14EF610E44F;
	Mon, 25 Apr 2022 18:00:02 +0000 (UTC)
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com
 [IPv6:2607:f8b0:4864:20::231])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2EEE910E44F
 for <amd-gfx@lists.freedesktop.org>; Mon, 25 Apr 2022 18:00:01 +0000 (UTC)
Received: by mail-oi1-x231.google.com with SMTP id e189so17966713oia.8
 for <amd-gfx@lists.freedesktop.org>; Mon, 25 Apr 2022 11:00:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=SMX9UWU0yqKxfn6GeUb7hV+9AtoUgQJfGIdDKT1mg6w=;
 b=lHdthzfP4rvW8Qr4U86+P6pQuoZh7Uwi6D+5hJ3AATSjSnWLy6bHciQA6v3IF2DyHO
 aMp1+Ucn0jPWPvbTxIIQA93XMk0ugWZAMZrbKkNYm5suigEQdt/8RNBx8XhUndkpXGjZ
 yMPLXcKNGx0THsYTHXNul/52YNRnK2ModuTHjlBDoX2STgof2XE6wBASp3yaVF4saT9d
 bQ5aDQlsFgngPvpTXtMW7dN8T5yN7cAV+GMYBC2kv/Smt97r9Oi9dPD5wdIra9vBIDP8
 OUiwRBx4mbgeVhWk2RqAMVtxb2e8AuA7McNPrhTtcqaUO+cRoL7+ekQmncHqdPYQbpO5
 Mm6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=SMX9UWU0yqKxfn6GeUb7hV+9AtoUgQJfGIdDKT1mg6w=;
 b=jCrCl+25ti3HiUhBwUjLhpwk1eWbJuzN80JfrtMnwdgKqHw+3gR8U5cOb2vgqDFg4A
 v9Wt9uYXUonXqFRMqq5Cfoaq9a157JFkKIQhmyBPXs1u2Mxyczu84OFnLom/ov1QkOYM
 7Sut8qPRS74UvGrC08jBVXMR8lh9XS/S68v3cNMMtGl1Tk8EkaNqfw0TdH9M5codQphi
 xZvRg44Pb/chYEH28vQPOM/iPmNF6d1B+yyoHI81HF6IeQ00VEVIaJaYdd8m+QIkzg36
 jIndplUdUSIXfYUyu7HUoZvZnCdOfbhRwkiIg2eyQcsU2L76Ot/2ar9uFGcz4v1IA6g9
 dfug==
X-Gm-Message-State: AOAM5319wbkgmHu7FKc4Ho6xx07TKkASLyAj5h8zjNk8JSAtfMINND/7
 x8/GN6Z2qUuexHDX53Wq3Odvn7gHGT750sv8680=
X-Google-Smtp-Source: ABdhPJz5ApyGWXy+Y+rtiZg6gK0CtlMYKpeVDVA8/pa/LmIsndj0VP6/BwqNUcD0txQy0Y39SWVLxM9rU8DMaLvATwQ=
X-Received: by 2002:a05:6808:f8d:b0:325:1e81:ffe5 with SMTP id
 o13-20020a0568080f8d00b003251e81ffe5mr4257672oiw.253.1650909600548; Mon, 25
 Apr 2022 11:00:00 -0700 (PDT)
MIME-Version: 1.0
References: <CAHpOOhHucS2QJSW3-jyGg8v8AMoCp2nV0h7T2rL_TQf6EHRvaA@mail.gmail.com>
 <f4b9dc03-2d2c-28f6-fe72-7bf0e6bcf203@gmail.com>
 <CAHpOOhHHzUD2Hw-W_9apXfc+43N1D9M3xXueaqyJh+xyfq3kiQ@mail.gmail.com>
In-Reply-To: <CAHpOOhHHzUD2Hw-W_9apXfc+43N1D9M3xXueaqyJh+xyfq3kiQ@mail.gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 25 Apr 2022 13:59:49 -0400
Message-ID: <CADnq5_PyQKuis=sbe+WWrWQe18hhiE7L2P1vkw=Z76K8_3k+kA@mail.gmail.com>
Subject: Re: [PATCH] Fix out-of-bound access for gfx_v10_0_ring_test_ib()
To: Haohui Mai <ricetons@gmail.com>
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
Cc: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>, Emily Deng <emily.deng@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Applied, but please fix your mailer.  Also, please prepend patch
titles with "drm/amdgpu".

Thanks,

Alex


On Mon, Apr 25, 2022 at 7:03 AM Haohui Mai <ricetons@gmail.com> wrote:
>
> Thanks for the prompt reviews. Here is the updated patch.
>
> Signed-off-by: Haohui Mai <ricetons@gmail.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> index 9426e252d8aa..c15549bbe636 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> @@ -3830,8 +3830,7 @@ static int gfx_v10_0_ring_test_ib(struct
> amdgpu_ring *ring, long timeout)
>         gpu_addr =3D adev->wb.gpu_addr + (index * 4);
>         adev->wb.wb[index] =3D cpu_to_le32(0xCAFEDEAD);
>         memset(&ib, 0, sizeof(ib));
> -       r =3D amdgpu_ib_get(adev, NULL, 16,
> -                                       AMDGPU_IB_POOL_DIRECT, &ib);
> +       r =3D amdgpu_ib_get(adev, NULL, 20, AMDGPU_IB_POOL_DIRECT, &ib);
>         if (r)
>                 goto err1;
>
> --
> 2.25.1
>
> On Mon, Apr 25, 2022 at 6:52 PM Christian K=C3=B6nig
> <ckoenig.leichtzumerken@gmail.com> wrote:
> >
> > Am 25.04.22 um 10:56 schrieb Haohui Mai:
> > > The gfx_v10_0_ring_test_ib() function uses 20 bytes instead of 16
> > > bytes during the test. The patch sets the size of the allocation to b=
e
> > > 4-byte larger to match the actual usage.
> > >
> > > Signed-off-by: Haohui Mai <ricetons@gmail.com>
> > > ---
> > >   drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c | 2 +-
> > >   1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> > > b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> > > index 9426e252d8aa..b131235826b1 100644
> > > --- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> > > +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> > > @@ -3830,7 +3830,7 @@ static int gfx_v10_0_ring_test_ib(struct
> > > amdgpu_ring *ring, long timeout)
> > >          gpu_addr =3D adev->wb.gpu_addr + (index * 4);
> > >          adev->wb.wb[index] =3D cpu_to_le32(0xCAFEDEAD);
> > >          memset(&ib, 0, sizeof(ib));
> > > -       r =3D amdgpu_ib_get(adev, NULL, 16,
> > > +       r =3D amdgpu_ib_get(adev, NULL, 20,
> > >                                          AMDGPU_IB_POOL_DIRECT, &ib);
> >
> > Good catch, but while at it please fix the coding style and move the
> > "AMDGPU_IB_POOL_DIRECT, &ib);" on the same line as well.
> >
> > With that done, the patch is Reviewed-by: Christian K=C3=B6nig
> > <christian.koenig@amd.com>
> >
> > >          if (r)
> > >                  goto err1;
> > > --
> > > 2.25.1
> >
