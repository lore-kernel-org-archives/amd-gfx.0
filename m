Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87C06CA0EF8
	for <amd-gfx@archiver.kernel.org>; Thu, 21 Aug 2025 12:57:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2808110E985;
	Thu, 21 Aug 2025 12:57:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="MJ5kI7RI";
	dkim-atps=neutral
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com
 [209.85.215.178])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0158110E985
 for <amd-gfx@lists.freedesktop.org>; Thu, 21 Aug 2025 12:57:47 +0000 (UTC)
Received: by mail-pg1-f178.google.com with SMTP id
 41be03b00d2f7-b47175fc02fso51253a12.3
 for <amd-gfx@lists.freedesktop.org>; Thu, 21 Aug 2025 05:57:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1755781067; x=1756385867; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tEbDa6/FfxUBgVY0EvVca1iE9nSXv81fI+Yts38Nu3w=;
 b=MJ5kI7RIHTIxmxdyzWESyoiqXhQZ8Zm3xm6g1fNf2yf1aDfzxia0QNjDvr0bNugOZ+
 ldIB1WoO6SiVzpTYgfZNX9g6LIky0zkPgTVKCnqu6J4Ir4grptMofACLi/HZZsg69COJ
 L5Vc1XSUJ/VBCofHEyuNbLVvHurVEq9hPaSIP+QlqF1rJ5Du/Gl3sFBXWOUa1ShS9s+a
 AKWL2Z4NyxNBrQK4LpntyIHGEdtbZKZzD26XU891DUTOfLvJE/iQXmR+PgcCZg1GRu8K
 gOKAewu9FxrEh1n8gbrMtQ5gdFaS3iOp8xXdaVppiCn/aGj73xmp+QGyksoj2xpj5T/w
 uZsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755781067; x=1756385867;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tEbDa6/FfxUBgVY0EvVca1iE9nSXv81fI+Yts38Nu3w=;
 b=Pdf5pmAKhc7kb1mGmhsxUkp+wi+e3FAZSy6FlvMlse3WCRT51O9LnR0sE7QvHDunP2
 Aim/4pE+2PmMipGn9ZJOtBFix42WW68TANomwhfLlJTVRWgqoxx8huzmQEWjRwCG8DpB
 tUIbXKM3o0yTFuqKpqiufueVpJiIUxVUOaKeoIqwfW5al54Ak/QvzLWBPfXWg/DTs4sV
 PaGooRhNdEZ+aXCwKekE1eMJ5AB2jthwCjf3wy74EYF97WM8Bza5yXzFlznz+KWIzjWw
 KWlMOG3uzbkdFKg35Babv+GJ4QLUw4PPAnG0vNzXKbVfSBOedUvLqUUoaQ6mlxbuukro
 58UQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUeR3JCGGokTc+B8nNQb91yYRUmoSd+jRSx+YSljPHqZRnRrUBDq+6feSXH+6zAI0N09Hp8EyoV@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxWk3jQlWK5yftjovoPl3GdUrPusZOj7oXpQf9ijikFuaDKQJ9+
 zm8XoJAozXsw9mx3BIM7ve7vwcn52q8kW+QujqiNYPffvmVtvBBw6BBzLdSYPEaTmpu6QNAXuuT
 TFgA3ZXjzNkbqcX58p7oCkR8ABxumZe40vg==
X-Gm-Gg: ASbGnctZKqeIMcWO+YF2rGJpUjoAN6IOG+qwmSktKUkPw8s67MMJepguucwvG2XToQe
 OjxWQz2MyCaGcI2zgrb/rRy/fzUyA60Foxr5PMMvu9PwN+ofIF6zYVgX9POhr9iDT90n1nHDkYJ
 N04nUKrXrvjHgVAwZUnqyms48lW09klVqifGVm8AzAcjTNbwSrglGmxnIM7qeSDJMyz2HqnSwa9
 r8mzOU=
X-Google-Smtp-Source: AGHT+IEaDgjojQXT0f+86goS1sUFLqfnLEpIzwuRMGhN7O5/A1segGuxawt1Vbj75jE7Iaa0odLHSvAc6DTI7UBbX7c=
X-Received: by 2002:a17:90b:1b05:b0:310:8d54:3209 with SMTP id
 98e67ed59e1d1-324ed0be106mr1625458a91.2.1755781067369; Thu, 21 Aug 2025
 05:57:47 -0700 (PDT)
MIME-Version: 1.0
References: <20250816162806.1301791-1-siqueira@igalia.com>
 <20250816162806.1301791-2-siqueira@igalia.com>
 <CADnq5_OqL2PnQQBY+1UQy26AhH0yG5PGsKDVv7zY1+fZqha89w@mail.gmail.com>
 <wxag4tn4ruescninedpkjgezfh73yoas4jribjiom35wpby2ez@tkwr6qmbq6qx>
In-Reply-To: <wxag4tn4ruescninedpkjgezfh73yoas4jribjiom35wpby2ez@tkwr6qmbq6qx>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 21 Aug 2025 08:57:35 -0400
X-Gm-Features: Ac12FXxjhULtRnC1pTEIqWSVd172Lq4tm12PXCxsyl9knMjVzf-KdUDjKFR47bs
Message-ID: <CADnq5_PM6xT5hrMnadGyYH+_9-0SZKmcpAe=VBOJRAS0mVqZGw@mail.gmail.com>
Subject: Re: [PATCH 1/3] drm/amdgpu/vcn: Use the correct irq for the ring
 initialization
To: Rodrigo Siqueira <siqueira@igalia.com>
Cc: Alex Deucher <alexander.deucher@amd.com>, 
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 James Zhu <James.Zhu@amd.com>, Jesse Zhang <jesse.zhang@amd.com>,
 amd-gfx@lists.freedesktop.org, kernel-dev@igalia.com
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

On Wed, Aug 20, 2025 at 6:09=E2=80=AFPM Rodrigo Siqueira <siqueira@igalia.c=
om> wrote:
>
> On 08/18, Alex Deucher wrote:
> > On Sat, Aug 16, 2025 at 12:28=E2=80=AFPM Rodrigo Siqueira <siqueira@iga=
lia.com> wrote:
> > >
> > > In the loop that iterates over the different VCN instances from VCN
> > > 4.0.3, the same irq source has been passed for different instances.
> > > This commit addresses the issue by adding the missing index to the ar=
ray
> > > access for the IRQ.
> >
> > This is on purpose.  There are no per instance source ids on 4.0.3.
> > The IH packets on this chip have a separate field to differentiate the
> > instances.
>
> Thanks for the explanation. Is this rationale also valid for VCN 1.0 and
> VCN 2.0?

VCN 1.0 and 2.0 only exist as single instances.  There are no chips
with multiple instances of them.

>
> Also, do you think it is worth making this hardware difference more
> evident in the code with something like this:
>
> -               r =3D amdgpu_ring_init(adev, ring, 512, &adev->vcn.inst[i=
].irq, 0,
> +
> +               // There are no per-instance source IDs on 4.0.3, the IH
> +               // packets use a separate field to differentiate instance=
s.

If you think it's helpful.  You may want to clarify that this comment
refers to the irqs ("per-instance irq source IDs").  Also, please use
C style comments.

Alex

> +               r =3D amdgpu_ring_init(adev, ring, 512, &adev->vcn.inst[0=
].irq, 0,
>
> Thanks
>
> >
> > Alex
> >
> > >
> > > Signed-off-by: Rodrigo Siqueira <siqueira@igalia.com>
> > > ---
> > >  drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c b/drivers/gpu/dr=
m/amd/amdgpu/vcn_v4_0_3.c
> > > index a63a1e3435ab..018a526a8801 100644
> > > --- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
> > > +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
> > > @@ -212,7 +212,7 @@ static int vcn_v4_0_3_sw_init(struct amdgpu_ip_bl=
ock *ip_block)
> > >
> > >                 ring->vm_hub =3D AMDGPU_MMHUB0(adev->vcn.inst[i].aid_=
id);
> > >                 sprintf(ring->name, "vcn_unified_%d", adev->vcn.inst[=
i].aid_id);
> > > -               r =3D amdgpu_ring_init(adev, ring, 512, &adev->vcn.in=
st->irq, 0,
> > > +               r =3D amdgpu_ring_init(adev, ring, 512, &adev->vcn.in=
st[i].irq, 0,
> > >                                      AMDGPU_RING_PRIO_DEFAULT,
> > >                                      &adev->vcn.inst[i].sched_score);
> > >                 if (r)
> > > --
> > > 2.47.2
> > >
>
> --
> Rodrigo Siqueira
