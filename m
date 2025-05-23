Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1BC3C54ED1
	for <amd-gfx@archiver.kernel.org>; Fri, 23 May 2025 13:58:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 24EDF10E7F5;
	Fri, 23 May 2025 13:58:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="EnzxDokn";
	dkim-atps=neutral
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com
 [209.85.215.171])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 295B310E7F5
 for <amd-gfx@lists.freedesktop.org>; Fri, 23 May 2025 13:58:20 +0000 (UTC)
Received: by mail-pg1-f171.google.com with SMTP id
 41be03b00d2f7-b1f2a3bf3c8so910055a12.1
 for <amd-gfx@lists.freedesktop.org>; Fri, 23 May 2025 06:58:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1748008694; x=1748613494; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WUAc6RAkva+BAe0jZE8PPHL2N51xoGzgHtzR3zlJ1w4=;
 b=EnzxDoknheE8xV7L8xeCMY8Aphm7ZTGIq4iPha6nW6sfKslvyZ8nn0sD0ci/Wd4PtB
 FeZwFMrAWkCpvsZc/jiOKBXfYaXiLtB1FhBpBEIq2Zvek88OsWX55vT/ZccNusYl6q6r
 Dn1jgbYHOZG8o070Zdp7XOxohBLCKqwBxmxVfBkIOGphR+2ZuyzPwLrfxWLDmQJASTBA
 CAWNp+v3ooJjq9Wq9EemtljWLogFk1J13zQhqt32h4ayfpeY0hdXSLxAjphaymXKftrw
 k3ByGfpLkWU0NIw395v3IZaattlk5oWt8xJgwVjSueVXtOTL2HSQd1ZNAf/A4uq6fuc5
 oNFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748008694; x=1748613494;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WUAc6RAkva+BAe0jZE8PPHL2N51xoGzgHtzR3zlJ1w4=;
 b=ASMuMNIU5CqOkXgS2rdVd4A5jpwXeTKnbfd9e08pFe3FQIHsgv/0fdCMkQEbkp4poW
 dvkaGQXPjuWueQImaiB/M0Xc269Pr/TtIF2eAUIDzRR+sb2K0PzVimEB1K5xv2SyJbM+
 J9abWzWl9sfmGh1zAwjueTRVaaNxtlBBUPTy2HgYGdS4A9gYZ5kpKjH8s6GnzDQ4tfDD
 zevJGRCsp/eQCSv44ZcOQstUODoi30RfZgul+75G9aY6kTBb17CDOWP0qgbDCjJX15Dx
 k5pTJxAu01aPDWsJ0E7c/7nePRGpsZ6Q6p7QgOjXIBok6MpNY/2+77H6UuQkoOMapGk3
 Nsmw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXFX1pgsBHgdKSA47RecqoCsrZBbngDGniTklA2X0X4k7Oo3N/7paWrR1IKS8a4kAO3S+woQTjN@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxZEhV6avPdsPGh0/9kOwNPkxT5n1N02Ts8qgMasrJVpuAHSKyE
 U4Av4kajb5RbFdgzNS6pWjJl+uN8HBLTTW+BQZiBlOZB8WTltBxtxfUXb2PqE/yroZQrtGbyc7i
 R9gjbTyqI5ezpIZ7F9XbMKM4mCA/quT8=
X-Gm-Gg: ASbGncvMyR76KweqMDw20exwWvI3A1GcRfx3c7lq6RHJbUMKq3c6w0yav5pqUE3JOyL
 kEQ9FvgADCt2MYtXFalN8udH5+M+pzZykcajBuE3Vy903FBSjWlJ9r/xpYBkWp89jBjcqWM+xOf
 FjAXGQwZBl6WnkJFex3TbO/+0938KWthfnbA==
X-Google-Smtp-Source: AGHT+IFANpx/ggTRj9An/3hmtxizXXjpeq3zsz16woUQNwAiV94Ajv4s+Car7lyWAQ0pitLCjoZSeSsk6SBVxLA6QK8=
X-Received: by 2002:a17:902:cf0a:b0:21d:cdb7:876c with SMTP id
 d9443c01a7336-233f3658f6cmr18197385ad.3.1748008694063; Fri, 23 May 2025
 06:58:14 -0700 (PDT)
MIME-Version: 1.0
References: <20250522215559.14677-1-alexander.deucher@amd.com>
 <CADnq5_MYYR4c8_QW0jo=Gd7w3dnkCFXpgDZAxnSEuhmRpwqZyw@mail.gmail.com>
 <c859107d-c09c-404c-8021-75ad3df7d54f@amd.com>
In-Reply-To: <c859107d-c09c-404c-8021-75ad3df7d54f@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 23 May 2025 09:58:02 -0400
X-Gm-Features: AX0GCFv9F7VTLgNaw5-AaWv7Yoq-bF4F3dYbzPlGU4UkUbVleps4de9cmGWILu4
Message-ID: <CADnq5_OWWUjaKXnwugo1-mpYOp9pdpk0pjgD8_sb5QNJOCMZSA@mail.gmail.com>
Subject: Re: [PATCH V2 00/10] Reset improvements for GC10+
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
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

On Fri, May 23, 2025 at 9:27=E2=80=AFAM Christian K=C3=B6nig
<christian.koenig@amd.com> wrote:
>
> On 5/23/25 05:04, Alex Deucher wrote:
> > On Thu, May 22, 2025 at 5:57=E2=80=AFPM Alex Deucher <alexander.deucher=
@amd.com> wrote:
> >>
> >> This set improves per queue reset support for GC10+.
> >> This uses vmid resets for GFX.  GFX resets all state
> >> associated with a vmid and then continues where it
> >> left off.  Since once the IB uses the vmid, only
> >> the IB is reset and execution continues after the IB.
> >> Tested on GC 10 and 11 chips with a game running and
> >> then running hang tests.  The game pauses when the
> >> hang happens, then continues after the queue reset.
> >
> > After further investigation, this appears to work as expected, but
> > only by chance.  The ring is reset, but any pipelined content in the
> > ring after the job is lost.  We either need to limit the ring to one
> > job or patch in the subsequent packets after resetting.
>
> Yeah, I feared that this wouldn't work.
>
> Any idea why the VMID based reset isn't working?

I think it works similarly to the preemption sequence.  E.g., see
gfx_v9_0_ring_preempt_ib(), but with a reset rather than a preemption,
but I don't think this will be easily portable to gfx11 and newer as
they no longer have direct access to the HWS.

>
> On the other hand we could just restart from the ring RPTR again.

I think that's probably the best option.  I was thinking we could
mirror the ring frames for each gang and after a reset, we submit the
unprocessed frames again.  That way we can still do a ring test to
make sure the ring is functional after the reset and then submit the
unprocessed work.

Alex

>
> Regards,
> Christian.
>
> >
> > Alex
> >
> >>
> >> I tried this same approach and GC8 and 9, but it
> >> was not as reliable as soft recovery.  I also compared
> >> this to Christian's reset patches, but I was not
> >> able to make them work as reliably as this series.
> >>
> >> Alex Deucher (9):
> >>   Revert "drm/amd/amdgpu: add pipe1 hardware support"
> >>   drm/amdgpu: add AMDGPU_QUEUE_RESET_TIMEOUT
> >>   drm/amdgpu: set the exec flag on the IB fence
> >>   drm/amdgpu/gfx11: adjust ring reset sequences
> >>   drm/amdgpu/gfx11: drop soft recovery
> >>   drm/amdgpu/gfx12: adjust ring reset sequences
> >>   drm/amdgpu/gfx12: drop soft recovery
> >>   drm/amdgpu/gfx10: adjust ring reset sequences
> >>   drm/amdgpu/gfx10: drop soft recovery
> >>
> >> Christian K=C3=B6nig (1):
> >>   drm/amdgpu: rework queue reset scheduler interaction
> >>
> >>  drivers/gpu/drm/amd/amdgpu/amdgpu.h     |  1 +
> >>  drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c  |  3 +-
> >>  drivers/gpu/drm/amd/amdgpu/amdgpu_job.c | 26 ++++++++--------
> >>  drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c  | 41 ++++++++----------------=
-
> >>  drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c  | 35 ++++++---------------
> >>  drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c  | 35 ++++++---------------
> >>  drivers/gpu/drm/amd/amdgpu/nvd.h        |  1 +
> >>  7 files changed, 50 insertions(+), 92 deletions(-)
> >>
> >> --
> >> 2.49.0
> >>
>
