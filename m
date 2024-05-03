Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 464DAC4345F
	for <amd-gfx@archiver.kernel.org>; Fri,  3 May 2024 14:28:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B86FB10E324;
	Fri,  3 May 2024 14:28:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="XFZ11hNo";
	dkim-atps=neutral
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com
 [209.85.214.172])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6E06510E324
 for <amd-gfx@lists.freedesktop.org>; Fri,  3 May 2024 14:28:25 +0000 (UTC)
Received: by mail-pl1-f172.google.com with SMTP id
 d9443c01a7336-1ec41d82b8bso41909715ad.2
 for <amd-gfx@lists.freedesktop.org>; Fri, 03 May 2024 07:28:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1714746505; x=1715351305; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8V366m5I7+Obef8VZYM3f8sNrE6Vx5CDfObAaXctWJQ=;
 b=XFZ11hNoao1UjOlboS6ZX5EthsOalYriLh2fB38X8JnyeXvAl9o7SPOqc+Re9q0yOB
 nx3kgEca8Ly1LVLCnCnAKU83Oxi/uBHt20RlgqWg+v0CO7qKN2bRxwRqDYutrLpNB6bU
 F1FKDjwbV1/mmGRK90U7YIMtxqk8ThP1m7jUfkHjKSaKTVQJiTf9r5j2GSoLuTD0UoPc
 1mv6jh2i8htckEkdROT8x933nfOzMTQmOk1yAzBTL78u9e5fNg4xkeTls67iXK8DxL9M
 nVd72+7d+hGQuH7S4y6MjUhIg6uOCqH9knXNaRgeLf+6Gurz1wT5DwWnlrHjgRin7btK
 QjMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714746505; x=1715351305;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8V366m5I7+Obef8VZYM3f8sNrE6Vx5CDfObAaXctWJQ=;
 b=MQ9ACqvSe1r7ctI8voqt/LL+T3wN4vlHwYiAhRc3m8Qp+FboNf48yeDx1BXuQFAVLo
 RcyxfGNQes1u+MlbUH80s4fz1/LXlO/XCbCEORYnXbkTxRLhQ2He/yo0zZtZnOvQ8adO
 Sxe7c4av7TsfmxFOjbQkjD597BVXidCWFL/ttckr/fUOsLewZlioPuIh6tvTP4XAWOEE
 lw+/G+aUZjffYPwcidI8+ey22kwfNZTiG5QYCymDZv1y+T3orrLqbBDR7d/5xNFJMSoD
 EnHH5VSU2CgUUXr7/5USGaMZJK265fLpy8AWsYqkY+ENolG4j8dQGgIciD0QfUWJGB7P
 guBQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVqXZrbRNcko0vjCBlICt+PJOtBXEqtdIpPMBtx1cXGu20tQmDyWJOZk1A9nnppfx+AvxjS2mt9TMtcrJeGAjJtL70/r6HEsyu9aNoLpw==
X-Gm-Message-State: AOJu0YxO+X6prMizzSd9lRDLVaqGDGytXyUWoqocgaqRqi+alwF+23oo
 YsY8c16zht2ypfVfBPQ62iPcCzgCue1/gEKRvQIXfwZp2peMzLCnTRbCClxjyxZXdff53I6zd5l
 kS1aWrIYe1S3NZMdMWOTFrDOQrnA=
X-Google-Smtp-Source: AGHT+IHW1VrI02zH99V4Uau8EgUb1ippvVUYy7F2daVn2PTicAsljqxPLVjsVv2gajM6NmHpEkQqpb8d1xRA20uESow=
X-Received: by 2002:a17:903:249:b0:1eb:d70c:e69f with SMTP id
 j9-20020a170903024900b001ebd70ce69fmr3015700plh.63.1714746504635; Fri, 03 May
 2024 07:28:24 -0700 (PDT)
MIME-Version: 1.0
References: <20240430172748.61576-1-tursulin@igalia.com>
 <CADnq5_Mzn8gesfqfNncJMWGgawFR3upgcy9MG=UwHw4i5GoZTg@mail.gmail.com>
 <cd9f1e27-2448-4803-ab73-9b71c5482027@igalia.com>
 <eae2f6bb-6c6f-4a85-a0dd-ad1898d638b5@gmail.com>
 <51a28e5c-392f-4093-9782-a81849474034@igalia.com>
 <CADnq5_PYN-QBx1VB7tTgpFsBqgrLKBNsOwGaG7u8TSXw539sjA@mail.gmail.com>
 <3030b87c-120b-4ef1-b0f9-9a1a7ef62e70@igalia.com>
In-Reply-To: <3030b87c-120b-4ef1-b0f9-9a1a7ef62e70@igalia.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 3 May 2024 10:28:12 -0400
Message-ID: <CADnq5_Nw3wNQzXQ0Oq0k4++JAESkUJD3vSEeWcGTu+88xMxwuA@mail.gmail.com>
Subject: Re: [RFC 0/5] Add capacity key to fdinfo
To: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
Cc: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>, 
 Tvrtko Ursulin <tursulin@igalia.com>, amd-gfx@lists.freedesktop.org,
 kernel-dev@igalia.com
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

On Fri, May 3, 2024 at 7:50=E2=80=AFAM Tvrtko Ursulin <tvrtko.ursulin@igali=
a.com> wrote:
>
>
> On 02/05/2024 16:00, Alex Deucher wrote:
> > On Thu, May 2, 2024 at 10:43=E2=80=AFAM Tvrtko Ursulin
> > <tvrtko.ursulin@igalia.com> wrote:
> >>
> >>
> >> On 02/05/2024 14:07, Christian K=C3=B6nig wrote:
> >>> Am 01.05.24 um 15:27 schrieb Tvrtko Ursulin:
> >>>>
> >>>> Hi Alex,
> >>>>
> >>>> On 30/04/2024 19:32, Alex Deucher wrote:
> >>>>> On Tue, Apr 30, 2024 at 1:27=E2=80=AFPM Tvrtko Ursulin <tursulin@ig=
alia.com>
> >>>>> wrote:
> >>>>>>
> >>>>>> From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
> >>>>>>
> >>>>>> I have noticed AMD GPUs can have more than one "engine" (ring?) of
> >>>>>> the same type
> >>>>>> but amdgpu is not reporting that in fdinfo using the capacity engi=
ne
> >>>>>> tag.
> >>>>>>
> >>>>>> This series is therefore an attempt to improve that, but only an R=
FC
> >>>>>> since it is
> >>>>>> quite likely I got stuff wrong on the first attempt. Or if not wro=
ng
> >>>>>> it may not
> >>>>>> be very beneficial in AMDs case.
> >>>>>>
> >>>>>> So I tried to figure out how to count and store the number of
> >>>>>> instances of an
> >>>>>> "engine" type and spotted that could perhaps be used in more than
> >>>>>> one place in
> >>>>>> the driver. I was more than a little bit confused by the ip_instan=
ce
> >>>>>> and uapi
> >>>>>> rings, then how rings are selected to context entities internally.
> >>>>>> Anyway..
> >>>>>> hopefully it is a simple enough series to easily spot any such lar=
ge
> >>>>>> misses.
> >>>>>>
> >>>>>> End result should be that, assuming two "engine" instances, one
> >>>>>> fully loaded and
> >>>>>> one idle will only report client using 50% of that engine type.
> >>>>>
> >>>>> That would only be true if there are multiple instantiations of the=
 IP
> >>>>> on the chip which in most cases is not true.  In most cases there i=
s
> >>>>> one instance of the IP that can be fed from multiple rings. E.g. fo=
r
> >>>>> graphics and compute, all of the rings ultimately feed into the sam=
e
> >>>>> compute units on the chip.  So if you have a gfx ring and a compute
> >>>>> rings, you can schedule work to them asynchronously, but ultimately
> >>>>> whether they execute serially or in parallel depends on the actual
> >>>>> shader code in the command buffers and the extent to which it can
> >>>>> utilize the available compute units in the shader cores.
> >>>>
> >>>> This is the same as with Intel/i915. Fdinfo is not intended to provi=
de
> >>>> utilisation of EUs and such, just how busy are the "entities" kernel
> >>>> submits to. So doing something like in this series would make the
> >>>> reporting more similar between the two drivers.
> >>>>
> >>>> I think both the 0-800% or 0-100% range (taking 8 ring compute as an
> >>>> example) can be misleading for different workloads. Neither <800% in
> >>>> the former means one can send more work and same for <100% in the la=
tter.
> >>>
> >>> Yeah, I think that's what Alex tries to describe. By using 8 compute
> >>> rings your 800% load is actually incorrect and quite misleading.
> >>>
> >>> Background is that those 8 compute rings won't be active all at the s=
ame
> >>> time, but rather waiting on each other for resources.
> >>>
> >>> But this "waiting" is unfortunately considered execution time since t=
he
> >>> used approach is actually not really capable of separating waiting an=
d
> >>> execution time.
> >>
> >> Right, so 800% is what gputop could be suggesting today, by the virtue=
 8
> >> context/clients can each use 100% if they only use a subset of compute
> >> units. I was proposing to expose the capacity in fdinfo so it can be
> >> scaled down and then dicussing how both situation have pros and cons.
> >>
> >>>> There is also a parallel with the CPU world here and hyper threading=
,
> >>>> if not wider, where "What does 100% actually mean?" is also wishy-wa=
shy.
> >>>>
> >>>> Also note that the reporting of actual time based values in fdinfo
> >>>> would not changing with this series.
> >>>>
> >>>> Of if you can guide me towards how to distinguish real vs fake
> >>>> parallelism in HW IP blocks I could modify the series to only add
> >>>> capacity tags where there are truly independent blocks. That would b=
e
> >>>> different from i915 though were I did not bother with that
> >>>> distinction. (For reasons that assignment of for instance EUs to
> >>>> compute "rings" (command streamers in i915) was supposed to be
> >>>> possible to re-configure on the fly. So it did not make sense to try
> >>>> and be super smart in fdinfo.)
> >>>
> >>> Well exactly that's the point we don't really have truly independent
> >>> blocks on AMD hardware.
> >>>
> >>> There are things like independent SDMA instances, but those a meant t=
o
> >>> be used like the first instance for uploads and the second for downlo=
ads
> >>> etc.. When you use both instances for the same job they will pretty m=
uch
> >>> limit each other because of a single resource.
> >>
> >> So _never_ multiple instances of the same IP block? No video decode,
> >> encode, anything?
> >
> > Some chips have multiple encode/decode IP blocks that are actually
> > separate instances, however, we load balance between them so userspace
> > sees just one engine.  Also in some cases they are asymmetric (e.g.,
> > different sets of supported CODECs on each instance).  The driver
> > handles this by inspecting the command buffer and scheduling on the
> > appropriate instance based on the requested CODEC.  SDMA also supports
> > multiple IP blocks that are independent.
>
> Similar to i915 just that we don't inspect buffers but expose the
> instance capabilities and userspace is responsible to set up the load
> balancing engine with the correct physical mask.

How do you handle load balancing across applications?

>
> Anyway, back to the main point - are you interested at all for me to add
> the capacity flags to at least the IP blocks which are probed to exist
> more than a singleton? And if yes, could you please suggest how to do it.

I don't have a particularly strong opinion.  I should note that this
does not take into account time spent on user mode queues.  Since
those are in userspace, we don't currently have a way to track the
time on the engines.  We've been working with the HW/FW teams to try
and come up with a scheme to handle them.

>
> For instance should I use adev->sdma.num_instances,
> adev->uvd.num_uvd_inst, adev->vcn.num_vcn_inst,
> adev->jpeg.num_jpeg_inst? Or maybe adev->num_ip_blocks and count by
> hw_ip type?

The former.  The latter was how we had intended to handle these
situations, but it didn't work out as well as we had hoped in practice
due to quirks of the hardware implementations.

>
> Patch 3/5 interesting or not to skip all the empty array walking (in
> amdgpu_ctx_entity_time mostly)?

The first 3 patches seem like a nice clean up to me.

Thanks!

Alex

>
> Regards,
>
> Tvrtko
>
> >
> > Alex
> >
> >>
> >>>>> As for the UAPI portion of this, we generally expose a limited numb=
er
> >>>>> of rings to user space and then we use the GPU scheduler to load
> >>>>> balance between all of the available rings of a type to try and
> >>>>> extract as much parallelism as we can.
> >>>>
> >>>> The part I do not understand is the purpose of the ring argument in
> >>>> for instance drm_amdgpu_cs_chunk_ib. It appears userspace can create
> >>>> up to N scheduling entities using different ring id's, but internall=
y
> >>>> they can map to 1:N same scheduler instances (depending on IP type,
> >>>> can be that each userspace ring maps to same N hw rings, or for ring=
s
> >>>> with no drm sched load balancing userspace ring also does not appear
> >>>> to have a relation to the picked drm sched instance.).
> >>>>
> >>>> So I neither understand how this ring is useful, or how it does not
> >>>> create a problem for IP types which use drm_sched_pick_best. It
> >>>> appears even if userspace created two scheduling entities with
> >>>> different ring ids they could randomly map to same drm sched aka sam=
e
> >>>> hw ring, no?
> >>>
> >>> Yeah, that is correct. The multimedia instances have to use a "fixed"
> >>> load balancing because of lack of firmware support. That should have
> >>> been fixed by now but we never found time to actually validate it.
> >>
> >> Gotcha.
> >>
> >>> Regarding the "ring" parameter in CS, that is basically just for
> >>> backward compatibility with older userspace. E.g. that we don't map a=
ll
> >>> SDMA jobs to the same instance when only once context is used.
> >>
> >> I see. In that sense "limits" for compute in amdgpu_ctx_num_entities a=
re
> >> arbitrary, or related to some old userspace expectation?
> >>
> >> Regards,
> >>
> >> Tvrtko
> >>
> >>> Regards,
> >>> Christian.
> >>>
> >>>>
> >>>> Regards,
> >>>>
> >>>> Tvrtko
> >>>>
> >>>>> Alex
> >>>>>
> >>>>>
> >>>>>>
> >>>>>> Tvrtko Ursulin (5):
> >>>>>>     drm/amdgpu: Cache number of rings per hw ip type
> >>>>>>     drm/amdgpu: Use cached number of rings from the
> >>>>>> AMDGPU_INFO_HW_IP_INFO
> >>>>>>       ioctl
> >>>>>>     drm/amdgpu: Skip not present rings in amdgpu_ctx_mgr_usage
> >>>>>>     drm/amdgpu: Show engine capacity in fdinfo
> >>>>>>     drm/amdgpu: Only show VRAM in fdinfo if it exists
> >>>>>>
> >>>>>>    drivers/gpu/drm/amd/amdgpu/amdgpu.h        |  1 +
> >>>>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c    |  3 ++
> >>>>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 14 +++++
> >>>>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_fdinfo.c | 39 +++++++++-----
> >>>>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c    | 62
> >>>>>> +++-------------------
> >>>>>>    5 files changed, 49 insertions(+), 70 deletions(-)
> >>>>>>
> >>>>>> --
> >>>>>> 2.44.0
> >>>
