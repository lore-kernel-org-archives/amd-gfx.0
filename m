Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C046DD5E15A
	for <amd-gfx@archiver.kernel.org>; Tue, 16 Dec 2025 14:02:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3F6E110E7F0;
	Tue, 16 Dec 2025 14:02:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Zk73+dfb";
	dkim-atps=neutral
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com
 [209.85.215.181])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9FEE310E78E
 for <amd-gfx@lists.freedesktop.org>; Tue, 16 Dec 2025 14:02:43 +0000 (UTC)
Received: by mail-pg1-f181.google.com with SMTP id
 41be03b00d2f7-b9da0ae5763so284940a12.0
 for <amd-gfx@lists.freedesktop.org>; Tue, 16 Dec 2025 06:02:43 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1765893763; cv=none;
 d=google.com; s=arc-20240605;
 b=euCMe4O2VosHxcLnNqLbgVEWVBLOKRmCsN/Ilbvl10ySgePn8PuYb52tZ4o/ekdFt7
 u2H1zYjBVChwY6bQIlnGLSfVSI4kKxPehYJajE0JkmVzejXD+punrXq0oRKiL2tK4DJL
 dkQi2wWTcNj8/QVa8v/6fK04Io4NRwpeeCzJU7fcYGD5IHtj1R7gDxfV5rC0ecxFj3ks
 ItbpLcZ3hspwTI9Rmjb7KqdA39UCDoKm0yxEkYJc7MBy1x7Ws4OagyQt9If04HdGBiq2
 grnK7qPR+YhYUoKchuIXl2IaeLLpa9nF7JAXnfA7j6a1HDA2fOK70rz1C+m6ajlZ5Sg1
 BrOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=w5xiqodwBJb3/lOK1s004d2mTYzmp6Iiuy5B5Oh6giA=;
 fh=RJ3KKrTYwVRn+x9riKjskclVqCHHL+UX/1ZbmV+UNH8=;
 b=EKn1acOmzXoFbN8S9AdAnW1kh4pC8F9nnypZQ1X2sj8p1NR7aObDJGZr2mJpMK73Ha
 kl+vCi37Cbwv3/jdNYtFOMAgkzU7/C7QQJtqC4zZIxFgfpvM+CZcQKraIIot/vWnyCly
 tqcFeHzlGnVLnqrAZCXuXUDXyN67grSRf6lwLfvhMDHnDsnSIhZ6trKYBiZ7nscFzT6l
 r7xLWMuYYFMhiZ6jZ8CUz+8sJeCFyyP7AgDCCE+NK2uTNytkG504n8Fs1Dkba+G0Kh3L
 v92rit0g2cxTdKXl+Yihx8F6rwLdzAVRQ3NCYEk5D+tLUMBf8Rhrp4fDyB0kr31BV/cB
 PwNg==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1765893763; x=1766498563; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=w5xiqodwBJb3/lOK1s004d2mTYzmp6Iiuy5B5Oh6giA=;
 b=Zk73+dfbdh6Zuxal1h1EPycgoygWyVGxGkdq6tn/UAV2/cl/ceJ3J6j91yjPeWZvyd
 zUMN8Rto9k56f7gS7VgqF2KxpcEuxsgo9J8vXdXkEg6JRlyFLurgDzpvdDnqBwf+V6hM
 zD/6DZRomBs7/I+FOMvRHn9kz8A/ssOze4juGj3FyyhhjJSxN7YHLpVAcTZdKOPqCosj
 dgdqC5SK6ukVfGKOvRRaRHd6tH00S9ZO/5QAb6FDi34i1EMu0G/OKwuylSyW8dX6CjxS
 /TmsjySOSGIWhNkREC2kWTlyPMx5i9MzkAnfge6DcLuZwbg2b4+oQLacd0G+bYhGW624
 rHAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765893763; x=1766498563;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=w5xiqodwBJb3/lOK1s004d2mTYzmp6Iiuy5B5Oh6giA=;
 b=v633NoekMKH1jECpTEhkWORXfi6TlbIfuko0jPYq8ycZSg31ZbOaWrZ9FIZ2j94wB2
 52mYbmslag6x2dSW1MyjO/6E2ozHU8UzY2BUu6PO7Bt2+gvZHXp2D/CInEYlvJ2Bm8nO
 iQH7mG/uzd3i/XfGR/nWCmt9AW2w/ssym0zn04X7MaO5VlPT0s/TUYlKB9Mp+1c0HVg7
 BLXQmnFR7QADixv92bf6DTJf3ivmDKJvIu2AFCwYTOq9KRilUSnUFoVO044CmeP2WluW
 vV020Prz5hRkWJDUJt0fugB333c5+8v/3YUeOb3EgpKzUrKLbPlATxAtrxMD4hI3QLeG
 mweA==
X-Forwarded-Encrypted: i=1;
 AJvYcCU/7Jlef9tI/AJraOOJBZRqpYW/0a1nFWmXu+JPR6h3haln4CsfVYy3xu51WjsIAXGy101QzjMQ@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzeJMqhrCacEBK6Oslrd4vGpxZgC5ZD7kf07mj8caY1pQaLDUDr
 7zKvUwulEJqRDSCS5RU5PuWm3FpJ0zUIElRSoCFYUtZBB/0neCdVgUgfuYxKKv+3bUJ1ZM+n1pS
 Ml28jHMfXf3ZG/mxUdC9SsodQJTT0tLs=
X-Gm-Gg: AY/fxX4SR/jgW2vXbCe/b1SaPzq05xeiYCEaKj+SmIxae6EvK04rSVquFXwcbi2g2eF
 SeW2w5Mpq//wY8sN/igAjv835D2EmLfwhiBlJnY9K+HMFsSCIeVYbxf/2MxIkZC4H2Ac6AYf2n2
 VZXB0GMPAdM6pUvPBNCdh2miA6HRI8/ZyvlWwgPD+6eZgDHdzxpK7E42gulvmehpAGfqNecUNpW
 O+clcn89f+4NWgVs8bGqbyfSN3D8Mmwi280NScygaF+irOYka+yNP6OomPSZuvD8EDwIrEv4++z
 yEXLCrU=
X-Google-Smtp-Source: AGHT+IFTtB25kte0v9YKFJOQ5u/UTpBIcwAhMn3g+fHle8+IQJez579cRo67DpL/5iFoZSCGJEmcVcMEArWrJbftvW8=
X-Received: by 2002:a05:7300:6c25:b0:2ac:30b:36a0 with SMTP id
 5a478bee46e88-2ac2f87d38dmr6448442eec.2.1765893762801; Tue, 16 Dec 2025
 06:02:42 -0800 (PST)
MIME-Version: 1.0
References: <cover.1765519875.git.donettom@linux.ibm.com>
 <fbc164ab-964f-464d-b94a-80131016b5b8@amd.com>
 <871pl0567w.ritesh.list@gmail.com>
 <1f10b67a-ffdc-4962-af52-758247569e09@amd.com>
 <CADnq5_NbDzqucujDyW009+55mLXZz2PiyaSd9PKXXeXv4pYn0Q@mail.gmail.com>
 <996ef75a-71b3-4ba7-a255-40516c5e9acd@amd.com>
 <CADnq5_PvMm0hqqFTmDONEoYnUiHSCTZWUVkcf_PoFP3jDXuCKA@mail.gmail.com>
 <bed34fa1-5971-416a-a3d4-7824d0387e02@linux.ibm.com>
In-Reply-To: <bed34fa1-5971-416a-a3d4-7824d0387e02@linux.ibm.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 16 Dec 2025 09:02:30 -0500
X-Gm-Features: AQt7F2rKFIgcYC8mmhyrS8Ws3MYssMvfHdcBm19T4EbQ008hmmoARJOCyRX3TVg
Message-ID: <CADnq5_Owfg0fG5mUo7NDZUNeB+QNas2EL+sK=42_deVSxiGfQQ@mail.gmail.com>
Subject: Re: [RFC PATCH v1 0/8] amdgpu/amdkfd: Add support for non-4K page
 size systems
To: Donet Tom <donettom@linux.ibm.com>
Cc: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>, amd-gfx@lists.freedesktop.org, 
 Felix Kuehling <Felix.Kuehling@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>, Kent.Russell@amd.com, 
 Vaidyanathan Srinivasan <svaidy@linux.ibm.com>,
 Mukesh Kumar Chaurasiya <mkchauras@linux.ibm.com>
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

On Tue, Dec 16, 2025 at 8:55=E2=80=AFAM Donet Tom <donettom@linux.ibm.com> =
wrote:
>
>
> On 12/15/25 7:39 PM, Alex Deucher wrote:
> > On Mon, Dec 15, 2025 at 4:47=E2=80=AFAM Christian K=C3=B6nig
> > <christian.koenig@amd.com> wrote:
> >> On 12/12/25 18:24, Alex Deucher wrote:
> >>> On Fri, Dec 12, 2025 at 8:19=E2=80=AFAM Christian K=C3=B6nig
> >>> <christian.koenig@amd.com> wrote:
> >>>> On 12/12/25 11:45, Ritesh Harjani (IBM) wrote:
> >>>>> Christian K=C3=B6nig <christian.koenig@amd.com> writes:
> >>>>>>> Setup details:
> >>>>>>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >>>>>>> System details: Power10 LPAR using 64K pagesize.
> >>>>>>> AMD GPU:
> >>>>>>>    Name:                    gfx90a
> >>>>>>>    Marketing Name:          AMD Instinct MI210
> >>>>>>>
> >>>>>>> Queries:
> >>>>>>> =3D=3D=3D=3D=3D=3D=3D
> >>>>>>> 1. We currently ran rocr-debug agent tests [1]  and rccl unit tes=
ts [2] to test
> >>>>>>>     these changes. Is there anything else that you would suggest =
us to run to
> >>>>>>>     shake out any other page size related issues w.r.t the kernel=
 driver?
> >>>>>> The ROCm team needs to answer that.
> >>>>>>
> >>>>> Is there any separate mailing list or list of people whom we can cc
> >>>>> then?
> >>>> With Felix on CC you already got the right person, but he's on vacat=
ion and will not be back before the end of the year.
> >>>>
> >>>> I can check on Monday if some people are still around which could an=
swer a couple of questions, but in general don't expect a quick response.
> >>>>
> >>>>>>> 2. Patch 1/8: We have a querry regarding eop buffer size Is this =
eop ring buffer
> >>>>>>>     size HW dependent? Should it be made PAGE_SIZE?
> >>>>>> Yes and no.
> >>>>>>
> >>>>> If you could more elaborate on this please? I am assuming you would
> >>>>> anyway respond with more context / details on Patch-1 itself. If ye=
s,
> >>>>> that would be great!
> >>>> Well, in general the EOP (End of Pipe) buffer contains in a ring buf=
fer of all the events and actions the CP should execute when shaders and ca=
che flushes finish.
> >>>>
> >>>> The size depends on the HW generation and configuration of the GPU e=
tc..., but don't ask me for details how that is calculated.
> >>>>
> >>>> The point is that the size is completely unrelated to the CPU, so us=
ing PAGE_SIZE is clearly incorrect.
> >>>>
> >>>>>>> 3. Patch 5/8: also have a query w.r.t the error paths when system=
 page size > 4K.
> >>>>>>>     Do we need to lift this restriction and add MMIO remap suppor=
t for systems with
> >>>>>>>     non-4K page sizes?
> >>>>>> The problem is the HW can't do this.
> >>>>>>
> >>>>> We aren't that familiar with the HW / SW stack here. Wanted to unde=
rstand
> >>>>> what functionality will be unsupported due to this HW limitation th=
en?
> >>>> The problem is that the CPU must map some of the registers/resources=
 of the GPU into the address space of the application and you run into secu=
rity issues when you map more than 4k at a time.
> >>> Right.  There are some 4K pages with the MMIO register BAR which are
> >>> empty and registers can be remapped into them.  In this case we remap
> >>> the HDP flush registers into one of those register pages.  This allow=
s
> >>> applications to flush the HDP write FIFO from either the CPU or
> >>> another device.  This is needed to flush data written by the CPU or
> >>> another device to the VRAM BAR out to VRAM (i.e., so the GPU can see
> >>> it).  This is flushed internally as part of the shader dispatch
> >>> packets,
> >> As far as I know this is only done for graphics shader submissions to =
the classic CS interface, but not for compute dispatches through ROCm queue=
s.
> > There is an explicit PM4 packet to flush the HDP cache for userqs and
> > for AQL the flush is handled via one of the flags in the dispatch
> > packet.  The MMIO remap is needed for more fine grained use cases
> > where you might have the CPU or another device operating in a gang
> > like scenario with the GPU.
>
>
> Thank you, Alex.
>
> We were encountering an issue while running the RCCL unit tests. With 2
> GPUs, all tests passed successfully; however, when running with more
> than 2 GPUs, the tests began to fail at random points with the following
> errors:
>
> [  598.576821] amdgpu 0048:0f:00.0: amdgpu: Queue preemption failed for
> queue with doorbell_id: 80030008
> [  606.696820] amdgpu 0048:0f:00.0: amdgpu: Failed to evict process queue=
s
> [  606.696826] amdgpu 0048:0f:00.0: amdgpu: GPU reset begin!. Source: 4
> [  610.696852] amdgpu 0048:0f:00.0: amdgpu: Queue preemption failed for
> queue with doorbell_id: 80030008
> [  610.696869] amdgpu 0048:0f:00.0: amdgpu: Failed to evict process queue=
s
> [  610.696942] amdgpu 0048:0f:00.0: amdgpu: Failed to restore process que=
ues
>
>
> After applying patches 7/8 and 8/8, we are no longer seeing this issue.
>
> One question I have is: we only started observing this problem when the
> number of GPUs increased. Could this be related to MMIO remapping not
> being available?

It could be.  E.g., if the CPU or a GPU writes data to VRAM on another
GPU, you will need to flush the HDP to make sure that data hits VRAM
before the GPU attached to the VRAM can see it.

Alex

>
>
> > Alex
> >
> >> That's the reason why ROCm needs the remapped MMIO register BAR.
> >>
> >>> but there are certain cases where an application may want
> >>> more control.  This is probably not a showstopper for most ROCm apps.
> >> Well the problem is that you absolutely need the HDP flush/invalidatio=
n for 100% correctness. It does work most of the time without it, but you t=
hen risk data corruption.
> >>
> >> Apart from making the flush/invalidate an IOCTL I think we could also =
just use a global dummy page in VRAM.
> >>
> >> If you make two 32bit writes which are apart from each other and then =
a read back a 32bit value from VRAM that should invalidate the HDP as well.=
 It's less efficient than the MMIO BAR remap but still much better than goi=
ng though an IOCTL.
> >>
> >> The only tricky part is that you need to get the HW barriers with the =
doorbell write right.....
> >>
> >>> That said, the region is only 4K so if you allow applications to map =
a
> >>> larger region they would get access to GPU register pages which they
> >>> shouldn't have access to.
> >> But don't we also have problems with the doorbell? E.g. the global agg=
regated one needs to be 4k as well, or is it ok to over allocate there?
> >>
> >> Thinking more about it there is also a major problem with page tables.=
 Those are 4k by default on modern systems as well and while over allocatin=
g them to 64k is possible that not only wastes some VRAM but can also resul=
t in OOM situations because we can't allocate the necessary page tables to =
switch from 2MiB to 4k pages in some cases.
> >>
> >> Christian.
> >>
> >>> Alex
> >>>
> >>>>>>> [1] ROCr debug agent tests: https://github.com/ROCm/rocr_debug_ag=
ent
> >>>>>>> [2] RCCL tests: https://github.com/ROCm/rccl/tree/develop/test
> >>>>>>>
> >>>>>>>
> >>>>>>> Please note that the changes in this series are on a best effort =
basis from our
> >>>>>>> end. Therefore, requesting the amd-gfx community (who have deeper=
 knowledge of the
> >>>>>>> HW & SW stack) to kindly help with the review and provide feedbac=
k / comments on
> >>>>>>> these patches. The idea here is, to also have non-4K pagesize (e.=
g. 64K) well
> >>>>>>> supported with amd gpu kernel driver.
> >>>>>> Well this is generally nice to have, but there are unfortunately s=
ome HW limitations which makes ROCm pretty much unusable on non 4k page siz=
e systems.
> >>>>> That's a bummer :(
> >>>>> - Do we have some HW documentation around what are these limitation=
s around non-4K pagesize? Any links to such please?
> >>>> You already mentioned MMIO remap which obviously has that problem, b=
ut if I'm not completely mistaken the PCIe doorbell BAR and some global seq=
 counter resources will also cause problems here.
> >>>>
> >>>> This can all be worked around by delegating those MMIO accesses into=
 the kernel, but that means tons of extra IOCTL overhead.
> >>>>
> >>>> Especially the cache flushes which are necessary to avoid corruption=
 are really bad for performance in such an approach.
> >>>>
> >>>>> - Are there any latest AMD GPU versions which maybe lifts such rest=
rictions?
> >>>> Not that I know off any.
> >>>>
> >>>>>> What we can do is to support graphics and MM, but that should alre=
ady work out of the box.
> >>>>>>
> >>>>> - Maybe we should also document, what will work and what won't work=
 due to these HW limitations.
> >>>> Well pretty much everything, I need to double check how ROCm does HD=
P flushing/invalidating when the MMIO remap isn't available.
> >>>>
> >>>> Could be that there is already a fallback path and that's the reason=
 why this approach actually works at all.
> >>>>
> >>>>>> What we can do is to support graphics and MM, but that should alre=
ady work out of the box.>
> >>>>> So these patches helped us resolve most of the issues like SDMA han=
gs
> >>>>> and GPU kernel page faults which we saw with rocr and rccl tests wi=
th
> >>>>> 64K pagesize. Meaning, we didn't see this working out of box perhap=
s
> >>>>> due to 64K pagesize.
> >>>> Yeah, but this is all for ROCm and not the graphics side.
> >>>>
> >>>> To be honest I'm not sure how ROCm even works when you have 64k page=
s at the moment. I would expect much more issue lurking in the kernel drive=
r.
> >>>>
> >>>>> AFAIU, some of these patches may require re-work based on reviews, =
but
> >>>>> at least with these changes, we were able to see all the tests pass=
ing.
> >>>>>
> >>>>>> I need to talk with Alex and the ROCm team about it if workarounds=
 can be implemented for those issues.
> >>>>>>
> >>>>> Thanks a lot! That would be super helpful!
> >>>>>
> >>>>>
> >>>>>> Regards,
> >>>>>> Christian.
> >>>>>>
> >>>>> Thanks again for the quick response on the patch series.
> >>>> You are welcome, but since it's so near to the end of the year not a=
ll people are available any more.
> >>>>
> >>>> Regards,
> >>>> Christian.
> >>>>
> >>>>> -ritesh
