Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 316DE10A62D5
	for <amd-gfx@archiver.kernel.org>; Thu, 26 Mar 2026 13:47:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C2B8F10E9CF;
	Thu, 26 Mar 2026 13:47:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="p8F2YGrO";
	dkim-atps=neutral
Received: from mail-dl1-f54.google.com (mail-dl1-f54.google.com [74.125.82.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D752E10E9CF
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Mar 2026 13:47:13 +0000 (UTC)
Received: by mail-dl1-f54.google.com with SMTP id
 a92af1059eb24-127148c2112so86606c88.3
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Mar 2026 06:47:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774532833; cv=none;
 d=google.com; s=arc-20240605;
 b=lP4IP5Xej783E6grCq02KiJlLEEUgeQo8e510z//uw5/7s2KQDOo07ZbGamQRBSlVC
 +6w/cvJCsn2QdwNomFjxHL7Urb7wpZXxnQXHntNXCqEF8eGawykP/4tGwXd9AvJJbkTo
 ySGLQShrwfcQHuiPQ1GZRR0QUcGmiAl4ib380chu23jPdqB9MNVIsz3tqEn5SubOnxLv
 2pqvA+Y+hn3yqjT84A8YAEGUyofLTByOusOZSMGtX4Kj1+WLxIKyEM+4dRCw87xub6wd
 NNpdvGhvU1ZnQoXBVwc7/4A/WRVAApUGc0zRNUlo8u3uaXe1lC9kZwMkj5WY+/1po9NI
 7JGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=jhgQIzT7uTXExNjxkHf9nhGfLv1V1ZXJvOpLwvnIT3s=;
 fh=7MqEIQXIpaYnX9CiStlmMPDclVLDCrvn2NG+Rym6iq8=;
 b=cA1v7er1YeIUnRJH4Oi+EMz6DTnsj/lokGMZygFtOMky60iQm9sfHniLcBaPgJQbNK
 c9oO64Jbdz6kickGaZeE6c72T3Qbog04Pb7w8e0DhdYO4tEu18Un7Cw6UidobtbxfkBf
 kNiei1ybNQwOqmfZ+oAQdNSPA6/I4o4R3OSoieFg5Pi7d4YSsrOcqrrVcOUqk3FxFX82
 uR94N3j+bkROUfoxgnJ5hWCNo5bMyYaps8M7gX3UWf4CxMhdyVqaT2sqVWJYL3CQb2yD
 GbYtpSLEH4dWVoxZbNiRfTEAcaOv3k/ub/CLgNHt7zD+oCt2GEhBGELDnYt8aKvCyeMl
 tx9Q==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1774532833; x=1775137633; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jhgQIzT7uTXExNjxkHf9nhGfLv1V1ZXJvOpLwvnIT3s=;
 b=p8F2YGrOAxi+qf6nWhUcPQ1i/OSeTPMU+LGikqTjomMVimc4UEvh9OEBCEhGq2v96X
 N7cE+OLpfkxJfWwHRCCK6OJE8GeFco3u+c5HdS17G/ECAOb63zCPcv6BeIAoVJg+zqKA
 R/9dsL71QTW2xFB5EpOJ2rmCq1bKdY8HLcaItVH1UNubZOHnp0cu15k+ZkXUGn4psPxS
 FSzP1RRabh4WLV7qLN3+Qo5VuKkRtsocoVBz1Wj60zgxBp+EB2Arm1rK/UGHWkbqgLxg
 g8D6JfRxAdNi/j87splNivlKTeaW1W/7jGMo43d7TP9ugGrivD5kR7PGDAqcRR9qKJ4m
 2gyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774532833; x=1775137633;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=jhgQIzT7uTXExNjxkHf9nhGfLv1V1ZXJvOpLwvnIT3s=;
 b=iYwwddaS6+SRhfo847rGCJyrEfZMMNNS4h38LDXrbLboXmvQoXYDEWn5ezuNasxHA8
 dCW4Yw6UGyMOuFDgcdWUzIeyplwbJzEpGjAaFYI2Q+GRK/c5fG8nMdaExr2KEAXkOB2N
 60GeowoDbfAALjk9E+1+YxPzzRlks0MYT8JpVViVuCb1wIVuIZu7U0wxCCac+Kfu5wiG
 ZThiEC/9XQM0rUBZiFEgqqVWCTQPxVFK+I9jgO+70AWdT5BGBvgA8zsh0ed7CEB8MKX2
 WB/w1gtdBA31j0Mz2KPk+g4Tq7Kss/lo1qiP/tI2R3962hQ7uiSDo0lB0NcQkF9oub3h
 doRA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUNiVOoLHDOjWO2Tda7jOgcISvSSjXT7Q/cK4DRnBZ04Yz2jEFpaYBbEiq8O30W+T7wfs54YgYg@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxLt2uhE/hey8imlLpkmiDbo+vF/SV77uoJd4SLwkNczbsP5qO+
 pMKeR3dRivPCTSIh9SZemrfCH9sHZphez5ASCbfH6WcNsP9FuX9wtKzu3rBoETwhRXREI88Wdu1
 LpCUVQpsON6yHbjEXqOfUx3Hsax38H+I=
X-Gm-Gg: ATEYQzxwNp/C8YY+nBdJ/EIyAfwGDQ+2ejnUKhW5b/9US1CvyTpBklcITVzySiskuNy
 +6IE0pFIKObE1g2gKjsytGSY+2dBAKWp04zIYEaugfBk+DOp7CNQDUD++nEGp/1RA+ruVNoedWC
 J6td3iTTVgaOR6IbMrGjCD1pPXbuHQcrDYES54e97924wkMjltEAh4tAyElH1orHydUBYDC+Kst
 aJFwimlD3PQhC/YTt55rNiWSXSjFzR6cArH9zm+rt45SnO4BKw/4WyZ2mFr5I9/ib/T279QhsJZ
 hWn2+l3BVXWI55sxqUsnmG9/WQq63+hv2NuUButkdEMB7uE1vV9dyHZK5rOufP7vp47leg==
X-Received: by 2002:a05:7022:ea2a:b0:127:3480:7ca5 with SMTP id
 a92af1059eb24-12a96e489ebmr2065500c88.2.1774532832955; Thu, 26 Mar 2026
 06:47:12 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1774521183.git.donettom@linux.ibm.com>
 <2e3d4c1dafc6d2780ca502c9d78e8ac250122d96.1774521183.git.donettom@linux.ibm.com>
 <9c9c73e1-abe4-4307-9d44-37544fbd1596@amd.com>
In-Reply-To: <9c9c73e1-abe4-4307-9d44-37544fbd1596@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 26 Mar 2026 09:47:01 -0400
X-Gm-Features: AQROBzAi2u3zFQCvcBtSmJhCwRwwjEJK-8GjhvwYzcT4D-8lUu-0oxPp55FelBo
Message-ID: <CADnq5_NWkGCb_WtaOk6Q4T4eG4EZc8ZNoLtxQkXowhYh3NaCVQ@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] drm/amdgpu: Change AMDGPU_VA_RESERVED_TRAP_SIZE to
 64KB
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc: Donet Tom <donettom@linux.ibm.com>, amd-gfx@lists.freedesktop.org, 
 Felix Kuehling <Felix.Kuehling@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>, 
 Philip Yang <yangp@amd.com>, David.YatSin@amd.com, Kent.Russell@amd.com, 
 Ritesh Harjani <ritesh.list@gmail.com>,
 Vaidyanathan Srinivasan <svaidy@linux.ibm.com>, stable@vger.kernel.org
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

Applied.  Thanks!

Alex

On Thu, Mar 26, 2026 at 8:36=E2=80=AFAM Christian K=C3=B6nig
<christian.koenig@amd.com> wrote:
>
> On 3/26/26 13:21, Donet Tom wrote:
> > Currently, AMDGPU_VA_RESERVED_TRAP_SIZE is hardcoded to 8KB, while
> > KFD_CWSR_TBA_TMA_SIZE is defined as 2 * PAGE_SIZE. On systems with
> > 4K pages, both values match (8KB), so allocation and reserved space
> > are consistent.
> >
> > However, on 64K page-size systems, KFD_CWSR_TBA_TMA_SIZE becomes 128KB,
> > while the reserved trap area remains 8KB. This mismatch causes the
> > kernel to crash when running rocminfo or rccl unit tests.
> >
> > Kernel attempted to read user page (2) - exploit attempt? (uid: 1001)
> > BUG: Kernel NULL pointer dereference on read at 0x00000002
> > Faulting instruction address: 0xc0000000002c8a64
> > Oops: Kernel access of bad area, sig: 11 [#1]
> > LE PAGE_SIZE=3D64K MMU=3DRadix SMP NR_CPUS=3D2048 NUMA pSeries
> > CPU: 34 UID: 1001 PID: 9379 Comm: rocminfo Tainted: G E
> > 6.19.0-rc4-amdgpu-00320-gf23176405700 #56 VOLUNTARY
> > Tainted: [E]=3DUNSIGNED_MODULE
> > Hardware name: IBM,9105-42A POWER10 (architected) 0x800200 0xf000006
> > of:IBM,FW1060.30 (ML1060_896) hv:phyp pSeries
> > NIP:  c0000000002c8a64 LR: c00000000125dbc8 CTR: c00000000125e730
> > REGS: c0000001e0957580 TRAP: 0300 Tainted: G E
> > MSR:  8000000000009033 <SF,EE,ME,IR,DR,RI,LE> CR: 24008268
> > XER: 00000036
> > CFAR: c00000000125dbc4 DAR: 0000000000000002 DSISR: 40000000
> > IRQMASK: 1
> > GPR00: c00000000125d908 c0000001e0957820 c0000000016e8100
> > c00000013d814540
> > GPR04: 0000000000000002 c00000013d814550 0000000000000045
> > 0000000000000000
> > GPR08: c00000013444d000 c00000013d814538 c00000013d814538
> > 0000000084002268
> > GPR12: c00000000125e730 c000007e2ffd5f00 ffffffffffffffff
> > 0000000000020000
> > GPR16: 0000000000000000 0000000000000002 c00000015f653000
> > 0000000000000000
> > GPR20: c000000138662400 c00000013d814540 0000000000000000
> > c00000013d814500
> > GPR24: 0000000000000000 0000000000000002 c0000001e0957888
> > c0000001e0957878
> > GPR28: c00000013d814548 0000000000000000 c00000013d814540
> > c0000001e0957888
> > NIP [c0000000002c8a64] __mutex_add_waiter+0x24/0xc0
> > LR [c00000000125dbc8] __mutex_lock.constprop.0+0x318/0xd00
> > Call Trace:
> > 0xc0000001e0957890 (unreliable)
> > __mutex_lock.constprop.0+0x58/0xd00
> > amdgpu_amdkfd_gpuvm_alloc_memory_of_gpu+0x6fc/0xb60 [amdgpu]
> > kfd_process_alloc_gpuvm+0x54/0x1f0 [amdgpu]
> > kfd_process_device_init_cwsr_dgpu+0xa4/0x1a0 [amdgpu]
> > kfd_process_device_init_vm+0xd8/0x2e0 [amdgpu]
> > kfd_ioctl_acquire_vm+0xd0/0x130 [amdgpu]
> > kfd_ioctl+0x514/0x670 [amdgpu]
> > sys_ioctl+0x134/0x180
> > system_call_exception+0x114/0x300
> > system_call_vectored_common+0x15c/0x2ec
> >
> > This patch changes AMDGPU_VA_RESERVED_TRAP_SIZE to 64 KB and
> > KFD_CWSR_TBA_TMA_SIZE to the AMD GPU page size. This means we reserve
> > 64 KB for the trap in the address space, but only allocate 8 KB within
> > it. With this approach, the allocation size never exceeds the reserved
> > area.
> >
> > cc: stable@vger.kernel.org
> > Fixes: 34a1de0f7935 ("drm/amdkfd: Relocate TBA/TMA to opposite side of =
VM hole")
> > Suggested-by: Felix Kuehling <felix.kuehling@amd.com>
> > Suggested-by: Christian K=C3=B6nig <christian.koenig@amd.com>
> > Signed-off-by: Donet Tom <donettom@linux.ibm.com>
>
> Reviewed-by: Christian K=C3=B6nig <christian.koenig@amd.com>
>
> > ---
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h | 2 +-
> >  drivers/gpu/drm/amd/amdkfd/kfd_priv.h  | 4 ++--
> >  2 files changed, 3 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_vm.h
> > index bb276c0ad06d..d5b7061556ba 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> > @@ -173,7 +173,7 @@ struct amdgpu_bo_vm;
> >  #define AMDGPU_VA_RESERVED_SEQ64_SIZE                (2ULL << 20)
> >  #define AMDGPU_VA_RESERVED_SEQ64_START(adev) (AMDGPU_VA_RESERVED_CSA_S=
TART(adev) \
> >                                                - AMDGPU_VA_RESERVED_SEQ=
64_SIZE)
> > -#define AMDGPU_VA_RESERVED_TRAP_SIZE         (2ULL << 12)
> > +#define AMDGPU_VA_RESERVED_TRAP_SIZE         (1ULL << 16)
> >  #define AMDGPU_VA_RESERVED_TRAP_START(adev)  (AMDGPU_VA_RESERVED_SEQ64=
_START(adev) \
> >                                                - AMDGPU_VA_RESERVED_TRA=
P_SIZE)
> >  #define AMDGPU_VA_RESERVED_BOTTOM            (1ULL << 16)
> > diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/am=
d/amdkfd/kfd_priv.h
> > index e5b56412931b..035687a17d89 100644
> > --- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> > +++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> > @@ -102,8 +102,8 @@
> >   * The first chunk is the TBA used for the CWSR ISA code. The second
> >   * chunk is used as TMA for user-mode trap handler setup in daisy-chai=
n mode.
> >   */
> > -#define KFD_CWSR_TBA_TMA_SIZE (PAGE_SIZE * 2)
> > -#define KFD_CWSR_TMA_OFFSET (PAGE_SIZE + 2048)
> > +#define KFD_CWSR_TBA_TMA_SIZE (AMDGPU_GPU_PAGE_SIZE * 2)
> > +#define KFD_CWSR_TMA_OFFSET (AMDGPU_GPU_PAGE_SIZE + 2048)
> >
> >  #define KFD_MAX_NUM_OF_QUEUES_PER_DEVICE             \
> >       (KFD_MAX_NUM_OF_PROCESSES *                     \
>
