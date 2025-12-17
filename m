Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B355D65C49
	for <amd-gfx@archiver.kernel.org>; Wed, 17 Dec 2025 14:23:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 26CED10E791;
	Wed, 17 Dec 2025 14:23:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="QiYQmkei";
	dkim-atps=neutral
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com
 [209.85.214.170])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D993F10E791
 for <amd-gfx@lists.freedesktop.org>; Wed, 17 Dec 2025 14:23:29 +0000 (UTC)
Received: by mail-pl1-f170.google.com with SMTP id
 d9443c01a7336-2a097cc08d5so8727675ad.0
 for <amd-gfx@lists.freedesktop.org>; Wed, 17 Dec 2025 06:23:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1765981409; x=1766586209; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=A8t8Pm6WFYqM5+c3GWJBqyYFUXJCxzdJT2XLj6xNreo=;
 b=QiYQmkeibVv+AVE/7L7rx7EhI4BmfhtaRztbNE0OokhtCZ2FOH7rYA5ugdTsKTmE/O
 0z9+ndWjDigpfGOdICyhfp3nzOcPdBnAixlDQZ5k+d8hDekHVSJgS/Hsgxz85VLCNJVB
 bP2jOEcOweN2xn9HkQRNQn7oNjp9hSfyQIII5fzPGUXWu0+DrA5kEVqlZd/mdMF8bF3i
 JR3hQ/4oD42p7wMT4LjrASUT+RZ7VXjGWBdtG8I2bfoZxlVnPUc0tyLQxsT5woXgN5gX
 ry7ljGeiMgf67bTqBtsnLOHfs3EDjQrD3AzI9rLOC+AkDzPXPH+a+s8Ize6XUXZSfmel
 Ia8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765981409; x=1766586209;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=A8t8Pm6WFYqM5+c3GWJBqyYFUXJCxzdJT2XLj6xNreo=;
 b=sUbj5hi38qfEgbeiMON2KewfedzO3/0D4r4SUHMgYTFvknlgJVd8tMnNy04075Jhvn
 LBe0MHqF+6qkgNCA6xS3Lm9fg7pxQ7YkHNQXqOPo1gQk7PmM2dQdyzNWPgm2ukvRTGEA
 5YqYzAEeOt/KFfOXQmDDXbCeMUMhVerpG0r/640yL6eTeeRwXE6PqngMd/O8Ml03W6Jm
 6QzkGZiOWuetA0kHy56e+fPo+818wG9h3WtlG9Q+O4hcKU9R1P9GnQp4IB4EmAJNugdN
 IeXcsRiZ8PmjHxKhjEvB4w/5p32GFsickdGa7UFolL3o3bByIMunVVUdjv9wfox0NwDh
 Pc/g==
X-Forwarded-Encrypted: i=1;
 AJvYcCX8xs3shGyMfOrFqnecSIS4jibpy4QtWTd9a/FsAIqzwRh35UmlAOvMBYvqOP/cCRb2qc83ZtDf@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxcvlNkFrvdkMJsWZEaBJpJek2eL0MG6j4kIt2I7UTwySr3gDlD
 /+9Fa3tLwUYigboEJL4qTzlIo42pe1WP+6990AuoPmGOKZRgAKejjwjO/exb8S1Hx2MYN+gYiq8
 YxNQt+ztgv9xiEqwPT/OLBpOSAP1oQS4=
X-Gm-Gg: AY/fxX4jmUmKlyZRCR2CCv7OvPvdY97rDQNsfctRnzA7/9YbN02plv3MzZNoZiWVpHt
 zR8FGXbsXr9fCAX+t0/lEU9SFILsvDw7zn4irKNxwRlSlQBDTw0/ygTBKacYA40dL8DzWe4u3M7
 8ytENlysGyrWMV2FLABIbGdZF0jQgM/xOKaXt+zDY6IqC+LBOO4tOaOX1O4kRYEDr/vK8KZwSOp
 xNABwlihLVXoxO+txjOvZz0yXC6Q8jUTL/iXipQldLrGmhZTVI1digOqWi9PPJqn4WbEJTq
X-Google-Smtp-Source: AGHT+IFahX3iJzh6IvbddIs01MopI8Euo8WJZB4+x9uGu9n6w4CUULojvbDMSG8RFLK7NAYYbjr1Smx6O9naFQy1Dik=
X-Received: by 2002:a05:7022:989:b0:119:e56b:c3f3 with SMTP id
 a92af1059eb24-11f34c47c98mr6884157c88.3.1765981409160; Wed, 17 Dec 2025
 06:23:29 -0800 (PST)
MIME-Version: 1.0
References: <cover.1765519875.git.donettom@linux.ibm.com>
 <fbc164ab-964f-464d-b94a-80131016b5b8@amd.com>
 <871pl0567w.ritesh.list@gmail.com>
 <1f10b67a-ffdc-4962-af52-758247569e09@amd.com>
 <CADnq5_NbDzqucujDyW009+55mLXZz2PiyaSd9PKXXeXv4pYn0Q@mail.gmail.com>
 <996ef75a-71b3-4ba7-a255-40516c5e9acd@amd.com>
 <CADnq5_PvMm0hqqFTmDONEoYnUiHSCTZWUVkcf_PoFP3jDXuCKA@mail.gmail.com>
 <bed34fa1-5971-416a-a3d4-7824d0387e02@linux.ibm.com>
 <CADnq5_Owfg0fG5mUo7NDZUNeB+QNas2EL+sK=42_deVSxiGfQQ@mail.gmail.com>
 <1f2a0b14-9cff-40cd-bdbc-71fae06c34b1@linux.ibm.com>
In-Reply-To: <1f2a0b14-9cff-40cd-bdbc-71fae06c34b1@linux.ibm.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 17 Dec 2025 09:23:17 -0500
X-Gm-Features: AQt7F2qOjvt_U7qhc33p-KpgZ6S5_3tM3ifdD-iqmJSEwn0L1RGDn-vUQjI7eK8
Message-ID: <CADnq5_OiCrFn=hPbxfBu5_Oj0pk-fQ1tN6ju2QhbLTY5BCAwEg@mail.gmail.com>
Subject: Re: [RFC PATCH v1 0/8] amdgpu/amdkfd: Add support for non-4K page
 size systems
To: Donet Tom <donettom@linux.ibm.com>, David Yat Sin <david.yatsin@amd.com>
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

On Wed, Dec 17, 2025 at 4:03=E2=80=AFAM Donet Tom <donettom@linux.ibm.com> =
wrote:
>
>
> On 12/16/25 7:32 PM, Alex Deucher wrote:
> > On Tue, Dec 16, 2025 at 8:55=E2=80=AFAM Donet Tom <donettom@linux.ibm.c=
om> wrote:
> >>
> >> On 12/15/25 7:39 PM, Alex Deucher wrote:
> >>> On Mon, Dec 15, 2025 at 4:47=E2=80=AFAM Christian K=C3=B6nig
> >>> <christian.koenig@amd.com> wrote:
> >>>> On 12/12/25 18:24, Alex Deucher wrote:
> >>>>> On Fri, Dec 12, 2025 at 8:19=E2=80=AFAM Christian K=C3=B6nig
> >>>>> <christian.koenig@amd.com> wrote:
> >>>>>> On 12/12/25 11:45, Ritesh Harjani (IBM) wrote:
> >>>>>>> Christian K=C3=B6nig <christian.koenig@amd.com> writes:
> >>>>>>>>> Setup details:
> >>>>>>>>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >>>>>>>>> System details: Power10 LPAR using 64K pagesize.
> >>>>>>>>> AMD GPU:
> >>>>>>>>>     Name:                    gfx90a
> >>>>>>>>>     Marketing Name:          AMD Instinct MI210
> >>>>>>>>>
> >>>>>>>>> Queries:
> >>>>>>>>> =3D=3D=3D=3D=3D=3D=3D
> >>>>>>>>> 1. We currently ran rocr-debug agent tests [1]  and rccl unit t=
ests [2] to test
> >>>>>>>>>      these changes. Is there anything else that you would sugge=
st us to run to
> >>>>>>>>>      shake out any other page size related issues w.r.t the ker=
nel driver?
> >>>>>>>> The ROCm team needs to answer that.
> >>>>>>>>
> >>>>>>> Is there any separate mailing list or list of people whom we can =
cc
> >>>>>>> then?
> >>>>>> With Felix on CC you already got the right person, but he's on vac=
ation and will not be back before the end of the year.
> >>>>>>
> >>>>>> I can check on Monday if some people are still around which could =
answer a couple of questions, but in general don't expect a quick response.
> >>>>>>
> >>>>>>>>> 2. Patch 1/8: We have a querry regarding eop buffer size Is thi=
s eop ring buffer
> >>>>>>>>>      size HW dependent? Should it be made PAGE_SIZE?
> >>>>>>>> Yes and no.
> >>>>>>>>
> >>>>>>> If you could more elaborate on this please? I am assuming you wou=
ld
> >>>>>>> anyway respond with more context / details on Patch-1 itself. If =
yes,
> >>>>>>> that would be great!
> >>>>>> Well, in general the EOP (End of Pipe) buffer contains in a ring b=
uffer of all the events and actions the CP should execute when shaders and =
cache flushes finish.
> >>>>>>
> >>>>>> The size depends on the HW generation and configuration of the GPU=
 etc..., but don't ask me for details how that is calculated.
> >>>>>>
> >>>>>> The point is that the size is completely unrelated to the CPU, so =
using PAGE_SIZE is clearly incorrect.
> >>>>>>
> >>>>>>>>> 3. Patch 5/8: also have a query w.r.t the error paths when syst=
em page size > 4K.
> >>>>>>>>>      Do we need to lift this restriction and add MMIO remap sup=
port for systems with
> >>>>>>>>>      non-4K page sizes?
> >>>>>>>> The problem is the HW can't do this.
> >>>>>>>>
> >>>>>>> We aren't that familiar with the HW / SW stack here. Wanted to un=
derstand
> >>>>>>> what functionality will be unsupported due to this HW limitation =
then?
> >>>>>> The problem is that the CPU must map some of the registers/resourc=
es of the GPU into the address space of the application and you run into se=
curity issues when you map more than 4k at a time.
> >>>>> Right.  There are some 4K pages with the MMIO register BAR which ar=
e
> >>>>> empty and registers can be remapped into them.  In this case we rem=
ap
> >>>>> the HDP flush registers into one of those register pages.  This all=
ows
> >>>>> applications to flush the HDP write FIFO from either the CPU or
> >>>>> another device.  This is needed to flush data written by the CPU or
> >>>>> another device to the VRAM BAR out to VRAM (i.e., so the GPU can se=
e
> >>>>> it).  This is flushed internally as part of the shader dispatch
> >>>>> packets,
> >>>> As far as I know this is only done for graphics shader submissions t=
o the classic CS interface, but not for compute dispatches through ROCm que=
ues.
> >>> There is an explicit PM4 packet to flush the HDP cache for userqs and
> >>> for AQL the flush is handled via one of the flags in the dispatch
> >>> packet.  The MMIO remap is needed for more fine grained use cases
> >>> where you might have the CPU or another device operating in a gang
> >>> like scenario with the GPU.
> >>
> >> Thank you, Alex.
> >>
> >> We were encountering an issue while running the RCCL unit tests. With =
2
> >> GPUs, all tests passed successfully; however, when running with more
> >> than 2 GPUs, the tests began to fail at random points with the followi=
ng
> >> errors:
> >>
> >> [  598.576821] amdgpu 0048:0f:00.0: amdgpu: Queue preemption failed fo=
r
> >> queue with doorbell_id: 80030008
> >> [  606.696820] amdgpu 0048:0f:00.0: amdgpu: Failed to evict process qu=
eues
> >> [  606.696826] amdgpu 0048:0f:00.0: amdgpu: GPU reset begin!. Source: =
4
> >> [  610.696852] amdgpu 0048:0f:00.0: amdgpu: Queue preemption failed fo=
r
> >> queue with doorbell_id: 80030008
> >> [  610.696869] amdgpu 0048:0f:00.0: amdgpu: Failed to evict process qu=
eues
> >> [  610.696942] amdgpu 0048:0f:00.0: amdgpu: Failed to restore process =
queues
> >>
> >>
> >> After applying patches 7/8 and 8/8, we are no longer seeing this issue=
.
> >>
> >> One question I have is: we only started observing this problem when th=
e
> >> number of GPUs increased. Could this be related to MMIO remapping not
> >> being available?
> > It could be.  E.g., if the CPU or a GPU writes data to VRAM on another
> > GPU, you will need to flush the HDP to make sure that data hits VRAM
> > before the GPU attached to the VRAM can see it.
>
>
> Thanks Alex
>
> I am now suspecting that the queue preemption issue may be related to
> the unavailability of MMIO remapping. I am not very familiar with this ar=
ea.
>
> Could you please point me to the relevant code path where the PM4 packet
> is issued to flush the HDP cache?

+ David who is more familiar with the ROCm runtime.

PM4 has a packet called HDP_FLUSH which flushes the HDP.  For AQL,
it's handled by one of the flags I think.  Most things in ROCm use
AQL.

@David Yat Sin Can you point to how HDP flushes are handled in the ROCm run=
time?

Alex

>
> I am consistently able to reproduce this issue on my system when using
> more than three GPUs if patches 7/8 and 8/8 are not applied. In your
> opinion, is there anything that can be done to speed up the HDP flush or
> to avoid this situation altogether?
>
>
>
> >
> > Alex
> >
> >>
> >>> Alex
> >>>
> >>>> That's the reason why ROCm needs the remapped MMIO register BAR.
> >>>>
> >>>>> but there are certain cases where an application may want
> >>>>> more control.  This is probably not a showstopper for most ROCm app=
s.
> >>>> Well the problem is that you absolutely need the HDP flush/invalidat=
ion for 100% correctness. It does work most of the time without it, but you=
 then risk data corruption.
> >>>>
> >>>> Apart from making the flush/invalidate an IOCTL I think we could als=
o just use a global dummy page in VRAM.
> >>>>
> >>>> If you make two 32bit writes which are apart from each other and the=
n a read back a 32bit value from VRAM that should invalidate the HDP as wel=
l. It's less efficient than the MMIO BAR remap but still much better than g=
oing though an IOCTL.
> >>>>
> >>>> The only tricky part is that you need to get the HW barriers with th=
e doorbell write right.....
> >>>>
> >>>>> That said, the region is only 4K so if you allow applications to ma=
p a
> >>>>> larger region they would get access to GPU register pages which the=
y
> >>>>> shouldn't have access to.
> >>>> But don't we also have problems with the doorbell? E.g. the global a=
ggregated one needs to be 4k as well, or is it ok to over allocate there?
> >>>>
> >>>> Thinking more about it there is also a major problem with page table=
s. Those are 4k by default on modern systems as well and while over allocat=
ing them to 64k is possible that not only wastes some VRAM but can also res=
ult in OOM situations because we can't allocate the necessary page tables t=
o switch from 2MiB to 4k pages in some cases.
> >>>>
> >>>> Christian.
> >>>>
> >>>>> Alex
> >>>>>
> >>>>>>>>> [1] ROCr debug agent tests: https://github.com/ROCm/rocr_debug_=
agent
> >>>>>>>>> [2] RCCL tests: https://github.com/ROCm/rccl/tree/develop/test
> >>>>>>>>>
> >>>>>>>>>
> >>>>>>>>> Please note that the changes in this series are on a best effor=
t basis from our
> >>>>>>>>> end. Therefore, requesting the amd-gfx community (who have deep=
er knowledge of the
> >>>>>>>>> HW & SW stack) to kindly help with the review and provide feedb=
ack / comments on
> >>>>>>>>> these patches. The idea here is, to also have non-4K pagesize (=
e.g. 64K) well
> >>>>>>>>> supported with amd gpu kernel driver.
> >>>>>>>> Well this is generally nice to have, but there are unfortunately=
 some HW limitations which makes ROCm pretty much unusable on non 4k page s=
ize systems.
> >>>>>>> That's a bummer :(
> >>>>>>> - Do we have some HW documentation around what are these limitati=
ons around non-4K pagesize? Any links to such please?
> >>>>>> You already mentioned MMIO remap which obviously has that problem,=
 but if I'm not completely mistaken the PCIe doorbell BAR and some global s=
eq counter resources will also cause problems here.
> >>>>>>
> >>>>>> This can all be worked around by delegating those MMIO accesses in=
to the kernel, but that means tons of extra IOCTL overhead.
> >>>>>>
> >>>>>> Especially the cache flushes which are necessary to avoid corrupti=
on are really bad for performance in such an approach.
> >>>>>>
> >>>>>>> - Are there any latest AMD GPU versions which maybe lifts such re=
strictions?
> >>>>>> Not that I know off any.
> >>>>>>
> >>>>>>>> What we can do is to support graphics and MM, but that should al=
ready work out of the box.
> >>>>>>>>
> >>>>>>> - Maybe we should also document, what will work and what won't wo=
rk due to these HW limitations.
> >>>>>> Well pretty much everything, I need to double check how ROCm does =
HDP flushing/invalidating when the MMIO remap isn't available.
> >>>>>>
> >>>>>> Could be that there is already a fallback path and that's the reas=
on why this approach actually works at all.
> >>>>>>
> >>>>>>>> What we can do is to support graphics and MM, but that should al=
ready work out of the box.>
> >>>>>>> So these patches helped us resolve most of the issues like SDMA h=
angs
> >>>>>>> and GPU kernel page faults which we saw with rocr and rccl tests =
with
> >>>>>>> 64K pagesize. Meaning, we didn't see this working out of box perh=
aps
> >>>>>>> due to 64K pagesize.
> >>>>>> Yeah, but this is all for ROCm and not the graphics side.
> >>>>>>
> >>>>>> To be honest I'm not sure how ROCm even works when you have 64k pa=
ges at the moment. I would expect much more issue lurking in the kernel dri=
ver.
> >>>>>>
> >>>>>>> AFAIU, some of these patches may require re-work based on reviews=
, but
> >>>>>>> at least with these changes, we were able to see all the tests pa=
ssing.
> >>>>>>>
> >>>>>>>> I need to talk with Alex and the ROCm team about it if workaroun=
ds can be implemented for those issues.
> >>>>>>>>
> >>>>>>> Thanks a lot! That would be super helpful!
> >>>>>>>
> >>>>>>>
> >>>>>>>> Regards,
> >>>>>>>> Christian.
> >>>>>>>>
> >>>>>>> Thanks again for the quick response on the patch series.
> >>>>>> You are welcome, but since it's so near to the end of the year not=
 all people are available any more.
> >>>>>>
> >>>>>> Regards,
> >>>>>> Christian.
> >>>>>>
> >>>>>>> -ritesh
