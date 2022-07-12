Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 361AFCCA47F
	for <amd-gfx@archiver.kernel.org>; Tue, 12 Jul 2022 13:46:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9EBAE2B58A;
	Tue, 12 Jul 2022 13:46:54 +0000 (UTC)
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com
 [IPv6:2a00:1450:4864:20::52f])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 609E82BFA7
 for <amd-gfx@lists.freedesktop.org>; Tue, 12 Jul 2022 13:46:53 +0000 (UTC)
Received: by mail-ed1-x52f.google.com with SMTP id m16so10149953edb.11
 for <amd-gfx@lists.freedesktop.org>; Tue, 12 Jul 2022 06:46:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=2Ab9ZkVIKFrpDZnI1OuJopd0Hn7dTwUdS+UWUPy/NAo=;
 b=KZCAdY2cCOXn7sqIhij8hfb+YXm+rLaK3sVk4rXaMhDM65Kq3ajF7qQ/9AxWZPAVXw
 DaYKWL6fugJSKWEA8jnbjN1HGTe0zT20jWAeGdSTfVA4cAYqnRdRwheNiJq8mKo8Bwts
 nqtTUoWXD4a7yCFNSA777Ikxpj4K3yOHOpJP+VszD+4evpsjOUEyMLk8O9+cZb0COA8o
 bYgHtJPsXU+S/Ysq8cqJIjecWVIEfkH78PYP5luCWtVosuqvVFu5rtk4BLl0OeDnu8Mz
 pYg8ENAx5la052PDSmZzxrn1rxSxttJ5kiOzlG5dkp9L2CEIy+40uvMtiQ/1Ht39uuMn
 niCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=2Ab9ZkVIKFrpDZnI1OuJopd0Hn7dTwUdS+UWUPy/NAo=;
 b=SEP+1RixJb1U0Bm08DoFKiW7RUe1cAuUcE29iZRTnADP1q7BCENjfDT/RPh2Mscs7M
 bW11wMLEEuUA44wK3wPauuOiiQ19RdRlky5L86ptgKwKh+f9Xws7ARBQ9j7BgduPSzSj
 +oq/H96E4L9wxiWUBTL7lq4ygNQlUjNwuVwTdzklLv1C6s1MV8NoAhgLvUAo/EbRUd7U
 2vNIy6hNRjO0pmJ2JqEfIJXp2dUXpFXYtq2r6pMLlrKZEm/qaQZIMPbBnGZzjifu6Iaq
 KyTJgrlj5taeb1kR9WV5x/gId6Rm16TuZYvSHQ3hGNX07xfswBl30XWMZjOQg4MKCGJs
 NA1Q==
X-Gm-Message-State: AJIora9zqM0PB3xHrzYLFwwMWmdLq1VSsyO4QafLKUPdkUeXCKkamkL/
 1Vb9FgdwvFcpUwPODGhI91GkV9KowyLkBIBg/CI=
X-Google-Smtp-Source: AGRyM1s4IWZbohj2WbOzT2lPt2yShTZBSnzj2tssjMatPAQuQLsnRSQVoODgzDzf/SYnp26uwISoJVZYXlW9IXnWzr8=
X-Received: by 2002:a05:6402:380a:b0:437:d11f:b8b0 with SMTP id
 es10-20020a056402380a00b00437d11fb8b0mr32377970edb.425.1657633611920; Tue, 12
 Jul 2022 06:46:51 -0700 (PDT)
MIME-Version: 1.0
References: <20220711224443.1157747-1-sunpeng.li@amd.com>
 <bd018180-a1b1-2d26-ab88-7cb00a60a85a@amd.com>
In-Reply-To: <bd018180-a1b1-2d26-ab88-7cb00a60a85a@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 12 Jul 2022 09:46:40 -0400
Message-ID: <CADnq5_Pmtp8KV9hwEkmxcxL4Sn+7wHe2YGH=UE=JvU+rfRKBRA@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: Check BO's requested pinning domains against
 its preferred_domains
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
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
Cc: "Leo \(Sunpeng\) Li" <sunpeng.li@amd.com>, Leo Liu <Leo.Liu@amd.com>,
 =?UTF-8?B?TWFyZWsgT2zFocOhaw==?= <Marek.Olsak@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>, "Deucher,
 Alexander" <Alexander.Deucher@amd.com>, "Wentland,
 Harry" <Harry.Wentland@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Tue, Jul 12, 2022 at 3:28 AM Christian K=C3=B6nig
<christian.koenig@amd.com> wrote:
>
> Am 12.07.22 um 00:44 schrieb sunpeng.li@amd.com:
> > From: Leo Li <sunpeng.li@amd.com>
> >
> > When pinning a buffer, we should check to see if there are any
> > additional restrictions imposed by bo->preferred_domains. This will
> > prevent the BO from being moved to an invalid domain when pinning.
> >
> > For example, this can happen if the user requests to create a BO in GTT
> > domain for display scanout. amdgpu_dm will allow pinning to either VRAM
> > or GTT domains, since DCN can scanout from either or. However, in
> > amdgpu_bo_pin_restricted(), pinning to VRAM is preferred if there is
> > adequate carveout. This can lead to pinning to VRAM despite the user
> > requesting GTT placement for the BO.
> >
> > Signed-off-by: Leo Li <sunpeng.li@amd.com>
> > ---
> >   drivers/gpu/drm/amd/amdgpu/amdgpu_object.c | 3 +++
> >   1 file changed, 3 insertions(+)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/d=
rm/amd/amdgpu/amdgpu_object.c
> > index 8a7b0f6162da..50400d70ef12 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> > @@ -883,6 +883,9 @@ int amdgpu_bo_pin_restricted(struct amdgpu_bo *bo, =
u32 domain,
> >       if (WARN_ON_ONCE(min_offset > max_offset))
> >               return -EINVAL;
> >
> > +     /* Check domain to be pinned to against preferred domains */
> > +     domain =3D bo->preferred_domains & domain
>
> Please guard that with an "if (bo->preferred_domains & domain)" to
> handle the case when the kernel needs to override the pin domain. That
> can happen when we export a BO to a V4L camera (for example).
>
> Apart from that looks like a rather nice bugfix.
>
> Alex should we add a CC stable to this?

Yes, I can add a stable tag.

Alex


>
> Regards,
> Christian.
>
> > +
> >       /* A shared bo cannot be migrated to VRAM */
> >       if (bo->tbo.base.import_attach) {
> >               if (domain & AMDGPU_GEM_DOMAIN_GTT)
>
