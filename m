Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B0C9C5AD49
	for <amd-gfx@archiver.kernel.org>; Thu, 29 May 2025 20:55:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F167810E0DB;
	Thu, 29 May 2025 20:55:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="lw9NDoYj";
	dkim-atps=neutral
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com
 [209.85.216.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AF0F310E0DB
 for <amd-gfx@lists.freedesktop.org>; Thu, 29 May 2025 20:55:03 +0000 (UTC)
Received: by mail-pj1-f49.google.com with SMTP id
 98e67ed59e1d1-31141a8e6c9so192140a91.3
 for <amd-gfx@lists.freedesktop.org>; Thu, 29 May 2025 13:55:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1748552103; x=1749156903; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WWE8kQOKfImHYLyjmtYR1OyukaS7fHsTBfhx9yMw60w=;
 b=lw9NDoYj18nZng8RipBIQcf3shRV6cR+IPMmojDtiw9+1wHNko2LbvxcugVTS8sixe
 Beu/J/dRxzkT9l45yFfvu4mVsziMglMDH4Y4vmogU5fChdppsneLdShKCP0fajUBrecp
 wTm15UCKN82VVEbzuMNKIhIqyuJoQVPOC42VvagxjT+Bz6UBwFmmnpnBX9RK5ebZ244z
 iHy7VKvmHOVkXOOsQaJpSlvyLFHrDS8bpkLh8RIi1SQvOzyT6NeEzmFJzxhRm5h4gfUk
 pQZ/7HmIKoxWEP+tkNC9GbUbXpK4t37eWGwTCSCtNRr1qAcztPT15VanO/Rz129UF/xp
 c5IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748552103; x=1749156903;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WWE8kQOKfImHYLyjmtYR1OyukaS7fHsTBfhx9yMw60w=;
 b=TcpO6pV26lBQ4LOIrxtctSP8ymLKj0hTZvhageUsue+MQYEWH3cWSz/UDrLpvHFdZr
 /LC52KgVShzNQketNAcNXacSHOJLSeNV0HIuFhbRFIR03616KLONpiNjuVNW58DwiYX7
 /kIsbgvvjR4LcOGa09GEu/+bHKcyYImxTRxuTePR2dFWanB3RXHcjbbUVM/7Ih73vFQQ
 wPIxOr9muP8XaCFu6iVoTOUx4XKE9ofXpsqy4oPae4ptZVlLF2sF7KV5qsHwiYngU8HR
 uHk82dARSNCwuwGJuB+MlY645AxbPtHZ9qe6LhhfJyp9/prFv9pcwcJw7JAXWHlcVi+j
 Nrfw==
X-Gm-Message-State: AOJu0YwHmJTJ10c1hkHl/h4CQN3Q0jgKumesg/H1pSA3n77hXzGA61nC
 8AuPYOKYgqLhc112j9uO3mvjQzgRYX1NajKtuBVqYTPakiUMJUBYAD7mNdx3hKBYYs/V17nAm41
 YPSaIz/Vwsb7o11BUz+K93VMjZ+KzjzWGjp/4
X-Gm-Gg: ASbGncuJUraoDdJh/NFoa8dGXPxTUaWdyrWvN5ayiGMb6tWdh3rYd/Xik7TIkjc0ZPp
 XoE9X/pK3+lmKm5prGQAmS1s/7k2IxLSPv/0Ghs4MHTsM3+zNKckmz2BJmD09iv/F7QpMvj7GBy
 4bRydDHdpGt/5W0dBkrDS2eRgD3MjpA/gmfw==
X-Google-Smtp-Source: AGHT+IEcKikJwzPzMM9i8Ga2LlBO6lQ/pUsTWWxxUHxzbImSPZ2hMhXxyWDvmLDEzQO9Ibp61hfcT8A5TI2NeITbCwc=
X-Received: by 2002:a17:90b:3cc5:b0:311:e9a6:332e with SMTP id
 98e67ed59e1d1-3124d0a0090mr13679a91.0.1748552103028; Thu, 29 May 2025
 13:55:03 -0700 (PDT)
MIME-Version: 1.0
References: <20250529200758.6326-1-alexander.deucher@amd.com>
In-Reply-To: <20250529200758.6326-1-alexander.deucher@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 29 May 2025 16:54:51 -0400
X-Gm-Features: AX0GCFsMN4vyfB4u7eZHYTYQiZIeJLJTnmsFh2OKoP9M3HCnByqZLsDtu3qzEzE
Message-ID: <CADnq5_O9AwPJ_mKdLhkWmUEW5uJnb3SA=0wUGEk6562KZYc_Fg@mail.gmail.com>
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

On Thu, May 29, 2025 at 4:08=E2=80=AFPM Alex Deucher <alexander.deucher@amd=
.com> wrote:
>
> This set improves per queue reset support for GC10+.
> When we reset the queue, the queue is lost so we need
> to re-emit the unprocessed state from subsequent submissions.
> To that end, in order to make sure we actually restore
> unprocessed state, we need to enable legacy enforce isolation
> so that we can safely re-emit the unprocessed state.  If
> we don't multiple jobs can run in parallel and we may not
> end up resetting the correct one.  This is similar to how
> windows handles queues.  This also gives us correct guilty
> tracking for GC.
>
> Tested on GC 10 and 11 chips with a game running and
> then running hang tests.  The game pauses when the
> hang happens, then continues after the queue reset.
>
> I tried this same approach and GC8 and 9, but it
> was not as reliable as soft recovery.  As such, I've dropped
> the KGQ reset code for pre-GC10.
>
> The same approach is extended to SDMA and VCN.
> They don't need enforce isolation because those engines
> are single threaded so they always operate serially.
>
> Rework re-emit to signal the seq number of the bad job and
> verify that to verify that the reset worked, then re-emit the
> rest of the non-guilty state.  This way we are not waiting on
> the rest of the state to complete, and if the subsequent state
> also contains a bad job, we'll end up in queue reset again rather
> than adapter reset.

git tree available here:
https://gitlab.freedesktop.org/agd5f/linux/-/commits/kq_resets?ref_type=3Dh=
eads

Alex

>
> v4: Drop explicit padding patches
>     Drop new timeout macro
>     Rework re-emit sequence
> v5: Add a helper for reemit
>     Convert VCN, JPEG, SDMA to use new helpers
>
> Alex Deucher (27):
>   drm/amdgpu: enable legacy enforce isolation by default
>   drm/amdgpu/gfx7: drop reset_kgq
>   drm/amdgpu/gfx8: drop reset_kgq
>   drm/amdgpu/gfx9: drop reset_kgq
>   drm/amdgpu: move force completion into ring resets
>   drm/amdgpu: track ring state associated with a job
>   drm/amdgpu/gfx10: re-emit unprocessed state on ring reset
>   drm/amdgpu/gfx11: re-emit unprocessed state on ring reset
>   drm/amdgpu/gfx12: re-emit unprocessed state on ring reset
>   drm/amdgpu/gfx9: re-emit unprocessed state on kcq reset
>   drm/amdgpu/gfx9.4.3: re-emit unprocessed state on kcq reset
>   drm/amdgpu/sdma5: re-emit unprocessed state on ring reset
>   drm/amdgpu/sdma5.2: re-emit unprocessed state on ring reset
>   drm/amdgpu/sdma6: re-emit unprocessed state on ring reset
>   drm/amdgpu/sdma7: re-emit unprocessed state on ring reset
>   drm/amdgpu/jpeg2: re-emit unprocessed state on ring reset
>   drm/amdgpu/jpeg2.5: re-emit unprocessed state on ring reset
>   drm/amdgpu/jpeg3: re-emit unprocessed state on ring reset
>   drm/amdgpu/jpeg4: re-emit unprocessed state on ring reset
>   drm/amdgpu/jpeg4.0.3: re-emit unprocessed state on ring reset
>   drm/amdgpu/jpeg5.0.0: add queue reset
>   drm/amdgpu/jpeg5: re-emit unprocessed state on ring reset
>   drm/amdgpu/jpeg5.0.1: re-emit unprocessed state on ring reset
>   drm/amdgpu/vcn4: re-emit unprocessed state on ring reset
>   drm/amdgpu/vcn4.0.3: re-emit unprocessed state on ring reset
>   drm/amdgpu/vcn4.0.5: re-emit unprocessed state on ring reset
>   drm/amdgpu/vcn5: re-emit unprocessed state on ring reset
>
> Christian K=C3=B6nig (1):
>   drm/amdgpu: rework queue reset scheduler interaction
>
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c |  4 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c  | 12 ++++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c     |  6 ++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_job.c    | 32 +++++-----
>  drivers/gpu/drm/amd/amdgpu/amdgpu_job.h    |  2 +
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c   | 46 ++++++++++++++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h   |  8 +++
>  drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c     | 31 ++--------
>  drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c     | 21 +------
>  drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c     | 21 +------
>  drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c      | 71 ----------------------
>  drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c      | 71 ----------------------
>  drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c      | 51 +---------------
>  drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c    |  6 +-
>  drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c     |  3 +-
>  drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c     |  3 +-
>  drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c     |  3 +-
>  drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c     |  3 +-
>  drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c   |  3 +-
>  drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c   | 12 ++++
>  drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.c   |  3 +-
>  drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c   |  4 ++
>  drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c     |  7 ++-
>  drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c     |  7 ++-
>  drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c     |  6 +-
>  drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c     |  6 +-
>  drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c      |  2 +-
>  drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c    |  3 +-
>  drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c    |  2 +-
>  drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c    |  2 +-
>  30 files changed, 162 insertions(+), 289 deletions(-)
>
> --
> 2.49.0
>
