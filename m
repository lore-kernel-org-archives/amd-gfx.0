Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B49C6109C059
	for <amd-gfx@archiver.kernel.org>; Wed, 25 Mar 2026 18:43:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1ACC310E903;
	Wed, 25 Mar 2026 18:43:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="hfUF5GAz";
	dkim-atps=neutral
Received: from mail-dy1-f169.google.com (mail-dy1-f169.google.com
 [74.125.82.169])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3789A10E903
 for <amd-gfx@lists.freedesktop.org>; Wed, 25 Mar 2026 18:43:06 +0000 (UTC)
Received: by mail-dy1-f169.google.com with SMTP id
 5a478bee46e88-2bd801b40dbso25208eec.0
 for <amd-gfx@lists.freedesktop.org>; Wed, 25 Mar 2026 11:43:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774464185; cv=none;
 d=google.com; s=arc-20240605;
 b=c3L9FxDmETzR4QcZM9yepynaNZSAv7eLmUin9EtY3EmsEGW7/hbQvEzg/vZ8a61fRl
 jwbcwGBeRYxx+sm4T02Mi83NEV+ZHMOwnJA8TUIwf4Ri0qeolVnMss4GiUauYJ3bHBiQ
 48bNHpJpv3oFZh8SdsltqoSK1moVfaQXz2phx9eMOMhCJO1+s1sN8tbrWiUICpdScx/W
 em27WpEukK+Vf8vU/s/VXvwJH2+ECil3w2KG4Ovn6uLzdnYz1dJMHfBLeaV7puR1Q700
 dlZtnpJpNB8Cx+3PqLHz9cC16h1FJTJtxPQamyztV4mgI7RYT+NiEJxnUUHc+4Igm5Wf
 If8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=LnmWpn003l3P6RzfHJYNcY1C9NMz8mx8GpI96MiRdNg=;
 fh=kOIX3rdLcletIFyenKiQmNrPe3nO1+ZZ2PL+Cwojm2s=;
 b=bGpzFmu2KnzrPJdpHtNObGBb2f9r/NjF16GRFQj31UI+ZzaOYVhkA8P3zaCNL6c/gj
 Lj45A39Sh6ZuvQXrBhuPjtVjbhTWBCYR17ucDriUf9/M29dRbBO2HTMr3h4FjCUFs9/R
 NYGxJ8P48gPp3Wow6QBBeYwNf/ABejUEK+geeW3GSdjh64c8jyUWoq3yyu7YylSBgoV5
 oAcGJHqAVCujeapf5JW45Jl8A7JW1tUPvC/IC0KxkLnVhSF0rVY+lr6vwWVaAjnoonpo
 /yX8jLcAvxkargwSfqPUuYX/ljF4vcH/B7Fy02OnR+LE4sYVLCo1cwtDDEw52Z1InRDX
 xWSQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1774464185; x=1775068985; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LnmWpn003l3P6RzfHJYNcY1C9NMz8mx8GpI96MiRdNg=;
 b=hfUF5GAzkzTrxnntixUi6wZRx2RHhqq903SBoF/zwz1z/XzFT4AbhcwdYQpygqXa5U
 2V4g6GmFpQQaIYe8uMhhjsKPvRJfGQSvD2YKyXKVnwghJbOjE8ar/51tx90TdkkutSTO
 hLWIoCDmnjmdD9RkpS0zDNEUaw1Fpa5ZKNPUuAsXVXokrhW9BNeAFPrbhDIQGWJB9KnB
 GzSTQ0oVq1Bi8WuQRK2cMb+cHoSzawivIp5HlLQHu1WHX4rdhM4ytvSBxaPxSiKoZ8wI
 rGugYzJl52I/x7GYFKmxrYa7gtbYHQAqY//czEiCULJcWd3X8bRC64HgpAJGnvnJCE6T
 FsSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774464185; x=1775068985;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=LnmWpn003l3P6RzfHJYNcY1C9NMz8mx8GpI96MiRdNg=;
 b=RxUGMJRrQMdQvjioBJkQ8amwpbM+SZE4j4ejfy+tgVTXcTIJxGWZjy6NpIqE2LBaax
 bqD3ta6SMnKdfbg1O+M0dzaw5S/fH/StFWSiRc5+/G35SbcpWewueYIY4CsyuW16yQ6F
 jHGLOQNw/xshTRSudjnmPsucHDppbe/64CFNVtk+ct/YGMKw7SkkAb2LTRzB0ewONRbc
 Lm1hFDgefjXVVPyd51huJWnqYNKMJxEh90N1kHZpRkEoWa4+b+Evfa0+XDxZsteblxVQ
 WQi+D6rCAVR4/MNV5C2076IBIVYbNuW9nGsmW6eTnqXtZNpwuqEVpygFSeH0lpyZSwx6
 REbg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUvINHj0/Irha7gJLsn5ILvp6TXSV/fYPiOvsO8v435DzwnEe5s8+R3o2DYZ5pwWklFdgSKitUd@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyAuipNqCJuoC4GXQJbN5lIRczzgB28H0jrq5QARThg1VLAfCB8
 l5MzaWp3zAJE4a/LPExzxXeqYceGigKSTSJuhLv8Qb45kmea1LsQiPMdbeZj//YH9tgq9kf0CMk
 VuYljgxazsM9JyJvkkXqgE6ChiX7kS2U=
X-Gm-Gg: ATEYQzzCF9iRfgsOFeYErRWqwJt1nMdJVSrVjRrOskAxvwMEsSsmRaUmmljfz+uoKkZ
 IGFxh/hbdCBHNC2NjRM5cAz+ZpKmWQ/+x0i12Lt+Kx7Yrj7EpFVcmVs/F2R+7DLXaqmNEMppUnd
 e+EERNoTB+8Le9l/+tbO3vQHk6wRO75D8NkPfzQhBzHtiY2wa8EObMp0gfAD5O4PTM0WwQta4ee
 Al0/2hjt+jJiqezUbydtiT/DYIoyugmI3T7K2GIFNNlH3eWSP0drO565p3OlEtyT9NuDhJMFDMY
 8iIx8nrv/b0YS+Goc1ajfTT/mHYQyA4TxXehbkgmbp2LQbJZdbu+57OvLB3+igqcRuNgYC7dSJW
 jiOiQ
X-Received: by 2002:a05:7022:425:b0:128:d279:b8ea with SMTP id
 a92af1059eb24-12a96eef505mr965501c88.5.1774464185459; Wed, 25 Mar 2026
 11:43:05 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1774239489.git.donettom@linux.ibm.com>
 <9b5d3040f6ce7d99be2c656f68055c8c7529b34a.1774239489.git.donettom@linux.ibm.com>
 <6d7390fb-e609-47f2-a40a-371c15ce54f2@amd.com>
In-Reply-To: <6d7390fb-e609-47f2-a40a-371c15ce54f2@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 25 Mar 2026 14:42:53 -0400
X-Gm-Features: AaiRm50mgFDu67jYGR6EoY6tzGAqwaKNLV4rPrSGkTHavZYFtgs1CFQBvFh3xjM
Message-ID: <CADnq5_OB8KksnoJi64iKnBgqGZBbR8EMR3VhdReL4qtoQ5cMeQ@mail.gmail.com>
Subject: Re: [RESEND RFC PATCH v3 6/6] drm/amdkfd: Fix queue
 preemption/eviction failures by aligning control stack size to GPU page size
To: "Kuehling, Felix" <felix.kuehling@amd.com>
Cc: Donet Tom <donettom@linux.ibm.com>, amd-gfx@lists.freedesktop.org, 
 Alex Deucher <alexander.deucher@amd.com>, christian.koenig@amd.com, 
 Philip Yang <yangp@amd.com>, David.YatSin@amd.com, Kent.Russell@amd.com, 
 Ritesh Harjani <ritesh.list@gmail.com>,
 Vaidyanathan Srinivasan <svaidy@linux.ibm.com>
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

On Tue, Mar 24, 2026 at 11:00=E2=80=AFPM Kuehling, Felix <felix.kuehling@am=
d.com> wrote:
>
>
> On 2026-03-23 00:28, Donet Tom wrote:
> > The control stack size is calculated based on the number of CUs and
> > waves, and is then aligned to PAGE_SIZE. When the resulting control
> > stack size is aligned to 64 KB, GPU hangs and queue preemption
> > failures are observed while running RCCL unit tests on systems with
> > more than two GPUs.
> >
> > amdgpu 0048:0f:00.0: amdgpu: Queue preemption failed for queue with
> > doorbell_id: 80030008
> > amdgpu 0048:0f:00.0: amdgpu: Failed to evict process queues
> > amdgpu 0048:0f:00.0: amdgpu: GPU reset begin!. Source: 4
> > amdgpu 0048:0f:00.0: amdgpu: Queue preemption failed for queue with
> > doorbell_id: 80030008
> > amdgpu 0048:0f:00.0: amdgpu: Failed to evict process queues
> > amdgpu 0048:0f:00.0: amdgpu: Failed to restore process queues
> >
> > This issue is observed on both 4 KB and 64 KB system page-size
> > configurations.
> >
> > This patch fixes the issue by aligning the control stack size to
> > AMDGPU_GPU_PAGE_SIZE instead of PAGE_SIZE, so the control stack size
> > will not be 64 KB on systems with a 64 KB page size and queue
> > preemption works correctly.
> >
> > Additionally, In the current code, wg_data_size is aligned to PAGE_SIZE=
,
> > which can waste memory if the system page size is large. In this patch,
> > wg_data_size is aligned to AMDGPU_GPU_PAGE_SIZE. The cwsr_size, calcula=
ted
> > from wg_data_size and the control stack size, is aligned to PAGE_SIZE.
> >
> > Signed-off-by: Donet Tom <donettom@linux.ibm.com>
>
> Reviewed-by: Felix Kuehling <felix.kuehling@amd.com>
>
>
> > ---
> >   drivers/gpu/drm/amd/amdkfd/kfd_queue.c | 7 ++++---
> >   1 file changed, 4 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_queue.c b/drivers/gpu/drm/a=
md/amdkfd/kfd_queue.c
> > index 572b21e39e83..9d4838461168 100644
> > --- a/drivers/gpu/drm/amd/amdkfd/kfd_queue.c
> > +++ b/drivers/gpu/drm/amd/amdkfd/kfd_queue.c
> > @@ -492,10 +492,11 @@ void kfd_queue_ctx_save_restore_size(struct kfd_t=
opology_device *dev)
> >       cu_num =3D props->simd_count / props->simd_per_cu / NUM_XCC(dev->=
gpu->xcc_mask);
> >       wave_num =3D get_num_waves(props, gfxv, cu_num);
> >
> > -     wg_data_size =3D ALIGN(cu_num * WG_CONTEXT_DATA_SIZE_PER_CU(gfxv,=
 props), PAGE_SIZE);
> > +     wg_data_size =3D ALIGN(cu_num * WG_CONTEXT_DATA_SIZE_PER_CU(gfxv,=
 props),
> > +                             AMDGPU_GPU_PAGE_SIZE);
> >       ctl_stack_size =3D wave_num * CNTL_STACK_BYTES_PER_WAVE(gfxv) + 8=
;
> >       ctl_stack_size =3D ALIGN(SIZEOF_HSA_USER_CONTEXT_SAVE_AREA_HEADER=
 + ctl_stack_size,
> > -                            PAGE_SIZE);
> > +                            AMDGPU_GPU_PAGE_SIZE);
> >
> >       if ((gfxv / 10000 * 10000) =3D=3D 100000) {
> >               /* HW design limits control stack size to 0x7000.
> > @@ -507,7 +508,7 @@ void kfd_queue_ctx_save_restore_size(struct kfd_top=
ology_device *dev)
> >
> >       props->ctl_stack_size =3D ctl_stack_size;
> >       props->debug_memory_size =3D ALIGN(wave_num * DEBUGGER_BYTES_PER_=
WAVE, DEBUGGER_BYTES_ALIGN);
> > -     props->cwsr_size =3D ctl_stack_size + wg_data_size;
> > +     props->cwsr_size =3D ALIGN(ctl_stack_size + wg_data_size, PAGE_SI=
ZE);
> >
> >       if (gfxv =3D=3D 80002)      /* GFX_VERSION_TONGA */
> >               props->eop_buffer_size =3D 0x8000;
