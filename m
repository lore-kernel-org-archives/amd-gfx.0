Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F0A4C83F07
	for <amd-gfx@archiver.kernel.org>; Mon,  7 Jul 2025 13:29:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2968F10E177;
	Mon,  7 Jul 2025 13:29:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Jla5cT2c";
	dkim-atps=neutral
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com
 [209.85.216.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9744C10E177
 for <amd-gfx@lists.freedesktop.org>; Mon,  7 Jul 2025 13:28:58 +0000 (UTC)
Received: by mail-pj1-f44.google.com with SMTP id
 98e67ed59e1d1-313756c602fso610637a91.3
 for <amd-gfx@lists.freedesktop.org>; Mon, 07 Jul 2025 06:28:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1751894938; x=1752499738; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UZNDO4+oENT59K0ggRb0HMLHup6bLfWV2eWYMy3xnv0=;
 b=Jla5cT2ceKwyYgslceLpPpZZu9t/x9EHkk2WZ6aP5VuHjKk75LqrI5IkNV92ggGyks
 vT9pV7NGlIDIT5HEwjDf1GWCtfU2BsTZReTVgpmFYPPePzq+ZK25qn6uAoRxWneDxC3A
 BAOBM5hKm9JtKAcvjQZVQUDJ6aYAP6293RoHckoMgnsR8MWoxTSE/DSsFuWTztGW6zxn
 Kktxc6MnDwcxZHiTqOfjgbLNQSvkO2IPQh4S/j1pbG98+n/2bEJ6qDAHdUhXVP4jML8k
 AqLDKQdh9v4YHIGg+Z//o+fi9/SKBxPHprfMEy8HCzcizsRz2DbSmiiSjUcDa3n9FeRw
 CQmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751894938; x=1752499738;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UZNDO4+oENT59K0ggRb0HMLHup6bLfWV2eWYMy3xnv0=;
 b=fZWf05529SAleOBSInptLnrVv0SIaxOCDO2PSZOHmzNoQwZFtNixZAfri7JxYnwRBT
 +DRFSj4r0XkgKClK2DTFLE4q6IfynrAzPBbYg8FtOl6sqpGWbQEH0dr0bw0h6jZJ6tCU
 bylmY4bepScAJ7PfVq2bW2tBlHqzKq7t0uhorzeiHuRqt0BSEVUnd9gDj0c3mRuQElE8
 +yvZysduC8sKIPuNqOl2EKICHaW5RTOrm+6X0nRy6EO+hBtDdp0iBq+neU7n2b076qYu
 n0lEyPUW/13b2BylYg6OLUidH+099DtfY8aaiGmJsdMRWCF+jVJknbHk1ykcGHUuymPS
 ltvg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWBCvLCGc2554v6PdfIv6lK8aMf6iim/ZgX80ESkISwGkI1qi1aYRZfmaY6uyquaE/Se2Dj9KU3@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyRcp5as+SNLnVtLWljSP4H78kDyJfGya5xbIgdcdROk6B3VWpc
 Z0/VXv9Ndr/PtSB9X9vJ2XST2cCJC33ruQbOfI52Ut10gRTqlYyDTdoVeiFi4CXQDCbP6VOsSjd
 WX1fen8/NgZvSI0motKAMqGazdhviWGQ=
X-Gm-Gg: ASbGncsX8Apl8ZjpkYPxdv1NQkCxSdO2AjYzHUo6EU1usAgSTbhWVehzZxQDx8eeqY/
 y1OGmZTQKA/XhUrEbJJYJVQaMZCP5LHVed3/oPzOwC3w8hXX53LeFP1hJA1LOtH8GK4N3zEnPUe
 /cdxgauk6Lo5qSJfFnJIubNdr3rltaMDExK9pGisQ8Sp+L
X-Google-Smtp-Source: AGHT+IHtAci0HoGOrk8+CuaBZbfLFV4bptzcGYbgVMjksJyrBJCfjJZNJHe4nZokNKkA184cz78r+bW/3AOTT1N1gZc=
X-Received: by 2002:a17:90b:5744:b0:311:e8cc:4250 with SMTP id
 98e67ed59e1d1-31aacc13f07mr6525508a91.3.1751894937874; Mon, 07 Jul 2025
 06:28:57 -0700 (PDT)
MIME-Version: 1.0
References: <20250701184451.11868-1-alexander.deucher@amd.com>
 <bcmfbiiod2gyn3u2fyimfbglvqt2ui2ouozklsoyskn3n6txmi@bvavettvg4lw>
In-Reply-To: <bcmfbiiod2gyn3u2fyimfbglvqt2ui2ouozklsoyskn3n6txmi@bvavettvg4lw>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 7 Jul 2025 09:28:45 -0400
X-Gm-Features: Ac12FXxVzLSuL_dQkV0USvXq7wmCO5ROjMhFZh5MJXufXtoaLRROmtPAzGI6rO4
Message-ID: <CADnq5_P+MK+g6PsthkVLuZ=321e_-ZtE_hJwtzKfbAaCcmW0ZQ@mail.gmail.com>
Subject: Re: [PATCH V13 00/28] Reset improvements
To: Rodrigo Siqueira <siqueira@igalia.com>
Cc: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org, 
 christian.koenig@amd.com, sasundar@amd.com
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

On Sun, Jul 6, 2025 at 11:05=E2=80=AFAM Rodrigo Siqueira <siqueira@igalia.c=
om> wrote:
>
> On 07/01, Alex Deucher wrote:
> > This set improves per queue reset support for a number of IPs.
> > When we reset the queue, the queue is lost so we need
> > to re-emit the unprocessed state from subsequent submissions.
> > This is handled in gfx/compute queues via switch buffer and
> > pipeline sync packets.  However, you can still end up with
> > parallel execution across queues.  For correctness in that
> > cause, enforce isolation needs to be enabled.  That can
> > impact certain use cases however and in most cases, the
> > guilty job is correctly identified even without enforce isolation.
> >
> > Tested on GC 10 and 11 chips with a game running and
> > then running hang tests.  The game pauses when the
>
> Hi Alex,
>
> Which hang test did you run?

The hang tests in HangTestSuite and IGT.

Alex

>
> Thanks
>
> > hang happens, then continues after the queue reset.
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
> >
> > Patches apply to the amd-staging-drm-next or drm-next branches in my
> > git tree.
> >
> > Git tree:
> > https://gitlab.freedesktop.org/agd5f/linux/-/commits/kq_resets?ref_type=
=3Dheads
> >
> > The IGT deadlock tests need the following fixes to properly handle -ETI=
ME fences:
> > https://patchwork.freedesktop.org/series/150724/
> >
> > v4: Drop explicit padding patches
> >     Drop new timeout macro
> >     Rework re-emit sequence
> > v5: Add a helper for reemit
> >     Convert VCN, JPEG, SDMA to use new helpers
> > v6: Update SDMA 4.4.2 to use new helpers
> >     Move ptr tracking to amdgpu_fence
> >     Skip all jobs from the bad context on the ring
> > v7: Rework the backup logic
> >     Move and clean up the guilty logic for engine resets
> >     Integrate suggestions from Christian
> >     Add JPEG 4.0.5 support
> > v8: Add non-guilty ring backup handling
> >     Clean up new function signatures
> >     Reorder some bug fixes to the start of the series
> > v9: Clean up fence_emit
> >     SDMA 5.x fixes
> >     Add new reset helpers
> >     sched wqueue stop/start cleanup
> >     Add support for VCNs without unified queues
> > v10: Drop enforce isolation default change
> >      Add more documentation
> >      Clean up ring backup logic
> > v11: SDMA6/7 fixes
> > v12: Ring backup and reemit fixes
> >      SDMA cleanups
> >      SDMA5.x reemit support
> >      GFX10 KGQ reset fix
> > v13: drop SDMA cleaups, they caused regressions in some IGT tests
> >
> > Alex Deucher (28):
> >   drm/amdgpu/sdma: consolidate engine reset handling
> >   drm/amdgpu/sdma: allow caller to handle kernel rings in engine reset
> >   drm/amdgpu: track ring state associated with a fence
> >   drm/amdgpu/gfx9: re-emit unprocessed state on kcq reset
> >   drm/amdgpu/gfx9.4.3: re-emit unprocessed state on kcq reset
> >   drm/amdgpu/gfx10: re-emit unprocessed state on ring reset
> >   drm/amdgpu/gfx11: re-emit unprocessed state on ring reset
> >   drm/amdgpu/gfx12: re-emit unprocessed state on ring reset
> >   drm/amdgpu/sdma5: re-emit unprocessed state on ring reset
> >   drm/amdgpu/sdma5.2: re-emit unprocessed state on ring reset
> >   drm/amdgpu/sdma6: re-emit unprocessed state on ring reset
> >   drm/amdgpu/sdma7: re-emit unprocessed state on ring reset
> >   drm/amdgpu/jpeg2: re-emit unprocessed state on ring reset
> >   drm/amdgpu/jpeg2.5: re-emit unprocessed state on ring reset
> >   drm/amdgpu/jpeg3: re-emit unprocessed state on ring reset
> >   drm/amdgpu/jpeg4: re-emit unprocessed state on ring reset
> >   drm/amdgpu/jpeg4.0.3: re-emit unprocessed state on ring reset
> >   drm/amdgpu/jpeg4.0.5: add queue reset
> >   drm/amdgpu/jpeg5: add queue reset
> >   drm/amdgpu/jpeg5.0.1: re-emit unprocessed state on ring reset
> >   drm/amdgpu/vcn4: re-emit unprocessed state on ring reset
> >   drm/amdgpu/vcn4.0.3: re-emit unprocessed state on ring reset
> >   drm/amdgpu/vcn4.0.5: re-emit unprocessed state on ring reset
> >   drm/amdgpu/vcn5: re-emit unprocessed state on ring reset
> >   drm/amdgpu/vcn: add a helper framework for engine resets
> >   drm/amdgpu/vcn2: implement ring reset
> >   drm/amdgpu/vcn2.5: implement ring reset
> >   drm/amdgpu/vcn3: implement ring reset
> >
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c     | 90 +++++++++++++++++++
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c        | 15 +++-
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_job.c       |  4 +-
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c      | 67 ++++++++++++++
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h      | 18 ++++
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c      | 43 +++++----
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h      |  3 +-
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c       | 76 ++++++++++++++++
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h       |  6 +-
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c        |  4 +
> >  drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c        | 41 ++-------
> >  drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c        | 35 +-------
> >  drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c        | 35 +-------
> >  drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c         | 12 +--
> >  drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c       | 12 +--
> >  drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c        | 11 +--
> >  drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c        | 11 +--
> >  drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c        | 11 +--
> >  drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c        | 11 +--
> >  drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c      | 11 +--
> >  drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_5.c      | 11 +++
> >  drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c      | 14 +++
> >  drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.c      | 11 +--
> >  drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c      | 19 +---
> >  drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c        | 23 +++--
> >  drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c        | 23 +++--
> >  drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c        | 18 ++--
> >  drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c        | 18 ++--
> >  drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c         | 12 +++
> >  drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c         | 11 +++
> >  drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c         | 13 +++
> >  drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c         | 11 +--
> >  drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c       | 10 +--
> >  drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c       | 11 +--
> >  drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c       | 11 +--
> >  .../drm/amd/amdkfd/kfd_device_queue_manager.c |  2 +-
> >  36 files changed, 454 insertions(+), 280 deletions(-)
> >
> > --
> > 2.50.0
> >
>
> --
> Rodrigo Siqueira
