Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F67EC5AE59
	for <amd-gfx@archiver.kernel.org>; Sat, 31 May 2025 17:18:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BC7B510E343;
	Sat, 31 May 2025 17:18:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="YaJwlKpo";
	dkim-atps=neutral
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com
 [209.85.216.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BECA910E343
 for <amd-gfx@lists.freedesktop.org>; Sat, 31 May 2025 17:18:26 +0000 (UTC)
Received: by mail-pj1-f43.google.com with SMTP id
 98e67ed59e1d1-30e5438316bso356153a91.1
 for <amd-gfx@lists.freedesktop.org>; Sat, 31 May 2025 10:18:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1748711905; x=1749316705; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yajKDvmSy3Hd7vmFDhk9At1+60Zej82i09/Vqe3tfGg=;
 b=YaJwlKpooNZMH8ho8SRZcOvvm/ir1jMJ8xQqpNGUO3kwQH3x/Zjbdrgu5DHMTwdJbn
 yLzqdwBfhetE8rztAZk7+wLXwvvP1ATUk1/RA3RYS31kAWAuuLZCxoewg5qoY+vyGn3/
 6zSFujPgLf9Fhde9Az3cdHwH6EXFuZf6M4F3F+tT+dw3fdJXSqFJBA8I2eqihoy1LVio
 f1ilS9SkgW2f4VGLJ5RIgT9nuURftZQbx8WJQWKjQq1niUdXPnO+FdITT9XNIhoC2ORh
 n/y3+kPUVBFPfyHdX5QSPCFgdknoLAGJfv2v7j2IfUDAHjgdMIPUM5LLKyHR5O0O2HjV
 2R8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748711905; x=1749316705;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yajKDvmSy3Hd7vmFDhk9At1+60Zej82i09/Vqe3tfGg=;
 b=Ve3jEusx2PhHU/WUDHcdwKfzyKHyg4skhWWTzHVN2z/Ncq3sJFcJmgceDOdqkvYwNO
 Rk9pCBQ3aRT9LedQOyDykzlf0l2J9DbCy8TGrt8lPYtSyWVUWQjdiOqoc/05D9eZ/ipB
 hUii4KLOAI67VS3HGs0tBbhU0hJU8tIsMZuPKuGC12QhWVeiqsczMA0NI0qHOTseCR5C
 uXqBQfJ/M124SoLaLygjpU/jGiBT15YyPMTXnjAhyLHYRBlzKtzak1qCjA7FaLZxiUh1
 ykXenf6MyfYUwdMSeeUBsB8BBSW5g3PayLvGld/QfdQq3e+8bPceLZ1xdJvd7tfm+686
 XY2w==
X-Gm-Message-State: AOJu0YyWldUqfX7r5SxWJ/2Yw/0+NuEwxhpIFfJRvtV7i95KuC9RUz2J
 iVH0DBoWrmzP/A7NaXgteetBqVj3KK0ueIbFR72b9RGEqs+Jha/UcJ/VPEdnr+PfSIDaZi9kYMX
 F7Yd+wE9hDnbcNP6pwC+uw0GYfjMDWmY=
X-Gm-Gg: ASbGncufTNjiOKuK34nbCbBmRGM5A8hbp81FDFdJWApF3J8PS+tqhhsfYc5wX/nVu1Z
 G7TviqZYDOxi9W6z55rXNWnQGyHlw55ZoLWZB7AbXHirPZ6WlW1w+PYHsR8SUtt6DyoLmpRhRG4
 xsdwKhjpK/PjA+CJzjxminzJHQKRm5lw91s5Pty8PXCblL
X-Google-Smtp-Source: AGHT+IFgmvhyaWQ6RGF/D5p9kNQV0nJxjHcvGRKcpLPBL+3kUAmUvEo7+g2ys7OGhQ9lJTt/GrmCWZWDRSjdV/Y9E8E=
X-Received: by 2002:a17:90b:180c:b0:312:ec:4116 with SMTP id
 98e67ed59e1d1-3124db44ad4mr3885104a91.8.1748711904610; Sat, 31 May 2025
 10:18:24 -0700 (PDT)
MIME-Version: 1.0
References: <20250529200758.6326-1-alexander.deucher@amd.com>
 <CADnq5_O9AwPJ_mKdLhkWmUEW5uJnb3SA=0wUGEk6562KZYc_Fg@mail.gmail.com>
In-Reply-To: <CADnq5_O9AwPJ_mKdLhkWmUEW5uJnb3SA=0wUGEk6562KZYc_Fg@mail.gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Sat, 31 May 2025 13:18:12 -0400
X-Gm-Features: AX0GCFsbS_AQA1lagtY-JnG2s1xX1YQSg_u3AxcRpw8X4sw4ebC52YHfrwPy1W0
Message-ID: <CADnq5_P=3v+u9sQNu8UOGohnEUeF5k59BOv0UKvvooZ-Hk0WMA@mail.gmail.com>
Subject: Re: [PATCH V5 00/28] Reset improvements for GC10+
To: Alex Deucher <alexander.deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org, christian.koenig@amd.com
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

On Thu, May 29, 2025 at 4:54=E2=80=AFPM Alex Deucher <alexdeucher@gmail.com=
> wrote:
>
> On Thu, May 29, 2025 at 4:08=E2=80=AFPM Alex Deucher <alexander.deucher@a=
md.com> wrote:
> >
> > This set improves per queue reset support for GC10+.
> > When we reset the queue, the queue is lost so we need
> > to re-emit the unprocessed state from subsequent submissions.
> > To that end, in order to make sure we actually restore
> > unprocessed state, we need to enable legacy enforce isolation
> > so that we can safely re-emit the unprocessed state.  If
> > we don't multiple jobs can run in parallel and we may not
> > end up resetting the correct one.  This is similar to how
> > windows handles queues.  This also gives us correct guilty
> > tracking for GC.
> >
> > Tested on GC 10 and 11 chips with a game running and
> > then running hang tests.  The game pauses when the
> > hang happens, then continues after the queue reset.
> >
> > I tried this same approach and GC8 and 9, but it
> > was not as reliable as soft recovery.  As such, I've dropped
> > the KGQ reset code for pre-GC10.
> >
> > The same approach is extended to SDMA and VCN.
> > They don't need enforce isolation because those engines
> > are single threaded so they always operate serially.
> >
> > Rework re-emit to signal the seq number of the bad job and
> > verify that to verify that the reset worked, then re-emit the
> > rest of the non-guilty state.  This way we are not waiting on
> > the rest of the state to complete, and if the subsequent state
> > also contains a bad job, we'll end up in queue reset again rather
> > than adapter reset.
>
> git tree available here:
> https://gitlab.freedesktop.org/agd5f/linux/-/commits/kq_resets?ref_type=
=3Dheads

I've pushed several fixes since I last sent this and will continue to
push updates.

Alex

>
> Alex
>
> >
> > v4: Drop explicit padding patches
> >     Drop new timeout macro
> >     Rework re-emit sequence
> > v5: Add a helper for reemit
> >     Convert VCN, JPEG, SDMA to use new helpers
> >
> > Alex Deucher (27):
> >   drm/amdgpu: enable legacy enforce isolation by default
> >   drm/amdgpu/gfx7: drop reset_kgq
> >   drm/amdgpu/gfx8: drop reset_kgq
> >   drm/amdgpu/gfx9: drop reset_kgq
> >   drm/amdgpu: move force completion into ring resets
> >   drm/amdgpu: track ring state associated with a job
> >   drm/amdgpu/gfx10: re-emit unprocessed state on ring reset
> >   drm/amdgpu/gfx11: re-emit unprocessed state on ring reset
> >   drm/amdgpu/gfx12: re-emit unprocessed state on ring reset
> >   drm/amdgpu/gfx9: re-emit unprocessed state on kcq reset
> >   drm/amdgpu/gfx9.4.3: re-emit unprocessed state on kcq reset
> >   drm/amdgpu/sdma5: re-emit unprocessed state on ring reset
> >   drm/amdgpu/sdma5.2: re-emit unprocessed state on ring reset
> >   drm/amdgpu/sdma6: re-emit unprocessed state on ring reset
> >   drm/amdgpu/sdma7: re-emit unprocessed state on ring reset
> >   drm/amdgpu/jpeg2: re-emit unprocessed state on ring reset
> >   drm/amdgpu/jpeg2.5: re-emit unprocessed state on ring reset
> >   drm/amdgpu/jpeg3: re-emit unprocessed state on ring reset
> >   drm/amdgpu/jpeg4: re-emit unprocessed state on ring reset
> >   drm/amdgpu/jpeg4.0.3: re-emit unprocessed state on ring reset
> >   drm/amdgpu/jpeg5.0.0: add queue reset
> >   drm/amdgpu/jpeg5: re-emit unprocessed state on ring reset
> >   drm/amdgpu/jpeg5.0.1: re-emit unprocessed state on ring reset
> >   drm/amdgpu/vcn4: re-emit unprocessed state on ring reset
> >   drm/amdgpu/vcn4.0.3: re-emit unprocessed state on ring reset
> >   drm/amdgpu/vcn4.0.5: re-emit unprocessed state on ring reset
> >   drm/amdgpu/vcn5: re-emit unprocessed state on ring reset
> >
> > Christian K=C3=B6nig (1):
> >   drm/amdgpu: rework queue reset scheduler interaction
> >
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c |  4 +-
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c  | 12 ++++
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c     |  6 ++
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_job.c    | 32 +++++-----
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_job.h    |  2 +
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c   | 46 ++++++++++++++
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h   |  8 +++
> >  drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c     | 31 ++--------
> >  drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c     | 21 +------
> >  drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c     | 21 +------
> >  drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c      | 71 ----------------------
> >  drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c      | 71 ----------------------
> >  drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c      | 51 +---------------
> >  drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c    |  6 +-
> >  drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c     |  3 +-
> >  drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c     |  3 +-
> >  drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c     |  3 +-
> >  drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c     |  3 +-
> >  drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c   |  3 +-
> >  drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c   | 12 ++++
> >  drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.c   |  3 +-
> >  drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c   |  4 ++
> >  drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c     |  7 ++-
> >  drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c     |  7 ++-
> >  drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c     |  6 +-
> >  drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c     |  6 +-
> >  drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c      |  2 +-
> >  drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c    |  3 +-
> >  drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c    |  2 +-
> >  drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c    |  2 +-
> >  30 files changed, 162 insertions(+), 289 deletions(-)
> >
> > --
> > 2.49.0
> >
