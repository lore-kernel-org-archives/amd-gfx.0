Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68A61CEFC31
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Oct 2024 16:39:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1E23B10E592;
	Tue,  8 Oct 2024 16:39:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ew6yRFkZ";
	dkim-atps=neutral
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com
 [209.85.214.176])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F295410E592
 for <amd-gfx@lists.freedesktop.org>; Tue,  8 Oct 2024 16:39:39 +0000 (UTC)
Received: by mail-pl1-f176.google.com with SMTP id
 d9443c01a7336-20b5f6a885dso1745355ad.0
 for <amd-gfx@lists.freedesktop.org>; Tue, 08 Oct 2024 09:39:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1728405579; x=1729010379; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LLKt+XKaQ/pPskkpqm8X99ObbixeQwjlsCaOnlPbonk=;
 b=ew6yRFkZ7m1+akb9G/XkNzWADdyzvYBon4jqkOa/GR5jFZgJfRndfEyIphXLG5M6HH
 eA1M6ITuKSZcNtVAQOWFHeEIRdeIBtXMMNVPETyZ5V1Xh8NU89wtt5AYSw2svKI+DhLD
 iTvbkejGhXACkZqlk+Nr/WdL5GrexsJvCqiePf/jlSW5r/o7Nu7b+bNepwVNyQKGSXHe
 IvScm1MFYnIYa6gm+qT0lCkxqnf4CxI0yoGVfq9WDdSWTidmzj5ifQBMGzwBShJYOwmd
 bvm3LdF/dCic2ZJXcB3Y9kHU8PTTDVpH6w1vIsaE2lWDHeP1FipAR3x74bWmlNOt+lSs
 nJHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728405579; x=1729010379;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LLKt+XKaQ/pPskkpqm8X99ObbixeQwjlsCaOnlPbonk=;
 b=mZ4GNtumZkp7UhMWe3yZPUV3TAHnj9RQ+IJTamPhXdNQCxyHgO4rjfOr0NtLcGXMQD
 LxZ/N8XmiDGixTBCWA8eLTu9GJny8dDnoF9xnbasIiroJNnnG1Zpc6TfqVLJ0tu7pId/
 jhmYxyRSQ6oetbFle/riw00kjW86CjgUUjUomtjczZZQIXQVqhY1vicu9NtWUSlwDphi
 sNoVmw6wrtq2yYbtxHr/G/D0EARntE5/C42qiyfncmq7hx81FS9C3W1f/z7bBQagiCuq
 3DlMc1IUiuCB0sFeBsbepPlhJ0BwqyGXq7SKpvaXnDaJTOPD+qsB+mvgjvyuaAmQdHIE
 VBvQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUUnT1YUfR6igVaF6QNzVOeCC+HQi7VixKxCFugB9kdEtGbUdQ5nPFT0eO6aYuiVjKS5a5yef+x@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yw8xGk5+Lw/WiVyukAoX6p7RstLA0DFkIV8xs5No8TVSkEmJ6+S
 fZe3l5MyVRM8FbKDxeKlxsJC7kA8PakznqR39PixxgHWmf7YrnEpK9ihXlohcBvvBjezm0jDKr4
 HkRMhdUPZOE6uDnVv/V9ABsWa1+libuzA
X-Google-Smtp-Source: AGHT+IHvnGSAF3uX57Z7LBW2rv6ZsiIGcjlYCymsCk9dSkX8QHQ/4uxlg6CnCQ2iBE74vdMXVoEEIY6CRK5sBlVlrUQ=
X-Received: by 2002:a17:90b:3906:b0:2d8:e2eb:31da with SMTP id
 98e67ed59e1d1-2e1e620e116mr7741773a91.2.1728405579366; Tue, 08 Oct 2024
 09:39:39 -0700 (PDT)
MIME-Version: 1.0
References: <20241008150532.23661-1-tursulin@igalia.com>
 <20241008150532.23661-5-tursulin@igalia.com>
 <02141366-ce3a-4b9b-9185-1cf1bcdc23d1@gmail.com>
In-Reply-To: <02141366-ce3a-4b9b-9185-1cf1bcdc23d1@gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 8 Oct 2024 12:39:27 -0400
Message-ID: <CADnq5_NQGTdqxguPvnQ7Fg_D-UUS4SF8vGh-tc3SyLb80gZeaQ@mail.gmail.com>
Subject: Re: [RFC 4/4] drm/amdgpu: Document the magic big endian bit
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
Cc: Tvrtko Ursulin <tursulin@igalia.com>, amd-gfx@lists.freedesktop.org, 
 kernel-dev@igalia.com, Tvrtko Ursulin <tvrtko.ursulin@igalia.com>, 
 Sunil Khatri <sunil.khatri@amd.com>
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

On Tue, Oct 8, 2024 at 11:10=E2=80=AFAM Christian K=C3=B6nig
<ckoenig.leichtzumerken@gmail.com> wrote:
>
> Am 08.10.24 um 17:05 schrieb Tvrtko Ursulin:
> > From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
> >
> > Similar to the previous patch but with the addition of a magic bit1 set=
 on
> > big endian platforms. No idea what it is but maybe adding a helper and
> > giving both it and the magic bit a proper name would be worth it.
>
> As far as I know that bit is deprecated and not guaranteed to work any
> more in the CP engine.
>
> I think we should just completely drop trying to use the bigendian
> support like that.

Agreed.  Those are mostly just copy and paste leftovers from when the
driver was forked from radeon.

For reference, back when the hardware supported it, most blocks had a
field that used the following:
ENDIAN_NONE 0
ENDIAN_8IN16 1
ENDIAN_8IN32 2
See the radeon driver for examples.  I think the last generation where
endian swapping was actually validated was probably r5xx.  I think a
few of the fields persisted through r6xx and newer, but they weren't
validated any more by the hw teams.

Alex

>
> Regards,
> Christian.
>
> >
> > Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
> > Cc: Christian K=C3=B6nig <ckoenig.leichtzumerken@gmail.com>
> > Cc: Sunil Khatri <sunil.khatri@amd.com>
> > ---
> >   drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h | 13 +++++++++++++
> >   drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c   | 14 ++------------
> >   2 files changed, 15 insertions(+), 12 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h b/drivers/gpu/drm=
/amd/amdgpu/amdgpu_ring.h
> > index aeab6fe21db6..68f3799f173c 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> > @@ -503,6 +503,19 @@ static inline void amdgpu_ring_write_addr(struct a=
mdgpu_ring *ring, u64 addr)
> >       amdgpu_ring_write64(ring, v);
> >   }
> >
> > +static inline void
> > +amdgpu_ring_write_addr_xbe(struct amdgpu_ring *ring, u64 addr)
> > +{
> > +     u64 v;
> > +
> > +#ifdef __BIG_ENDIAN
> > +     v =3D (u64)lower_32_bits(addr) << 32 | upper_32_bits(addr) | (2 <=
< 0); /* Magic bit name? */
> > +#else
> > +     v =3D addr;
> > +#endif
> > +     amdgpu_ring_write64(ring, v);
> > +}
> > +
> >   /**
> >    * amdgpu_ring_patch_cond_exec - patch dw count of conditional execut=
e
> >    * @ring: amdgpu_ring structure
> > diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/a=
md/amdgpu/gfx_v10_0.c
> > index 24fb58543041..de1909c1de49 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> > @@ -8549,12 +8549,7 @@ static void gfx_v10_0_ring_emit_ib_gfx(struct am=
dgpu_ring *ring,
> >
> >       amdgpu_ring_write(ring, header);
> >       BUG_ON(ib->gpu_addr & 0x3); /* Dword align */
> > -     amdgpu_ring_write(ring,
> > -#ifdef __BIG_ENDIAN
> > -             (2 << 0) |
> > -#endif
> > -             lower_32_bits(ib->gpu_addr));
> > -     amdgpu_ring_write(ring, upper_32_bits(ib->gpu_addr));
> > +     amdgpu_ring_write_addr_xbe(ring, ib->gpu_addr);
> >       amdgpu_ring_write(ring, control);
> >   }
> >
> > @@ -8584,12 +8579,7 @@ static void gfx_v10_0_ring_emit_ib_compute(struc=
t amdgpu_ring *ring,
> >
> >       amdgpu_ring_write(ring, PACKET3(PACKET3_INDIRECT_BUFFER, 2));
> >       BUG_ON(ib->gpu_addr & 0x3); /* Dword align */
> > -     amdgpu_ring_write(ring,
> > -#ifdef __BIG_ENDIAN
> > -                             (2 << 0) |
> > -#endif
> > -                             lower_32_bits(ib->gpu_addr));
> > -     amdgpu_ring_write(ring, upper_32_bits(ib->gpu_addr));
> > +     amdgpu_ring_write_addr_xbe(ring, ib->gpu_addr);
> >       amdgpu_ring_write(ring, control);
> >   }
> >
>
