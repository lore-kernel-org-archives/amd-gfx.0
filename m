Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D63FDD5B16C
	for <amd-gfx@archiver.kernel.org>; Mon, 15 Dec 2025 14:09:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4D51B10E044;
	Mon, 15 Dec 2025 14:09:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="P0K5Yd5f";
	dkim-atps=neutral
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com
 [209.85.216.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1610C10E044
 for <amd-gfx@lists.freedesktop.org>; Mon, 15 Dec 2025 14:09:18 +0000 (UTC)
Received: by mail-pj1-f43.google.com with SMTP id
 98e67ed59e1d1-34aa1d063d5so381280a91.0
 for <amd-gfx@lists.freedesktop.org>; Mon, 15 Dec 2025 06:09:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1765807757; x=1766412557; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EvvyakCXFdGbWJpgHjcGC1PB4viB9GzwOnVIZbEHWnY=;
 b=P0K5Yd5fPJ1T9Vtp5a8OrfOL1ryC3cvHkDpLm1fkrOnD7LG5rhyAjrlwCIYyXig760
 lovAn3jDB1N6C1S8CFoovCK+eaJZjmizwK8p77mDT4UWaslNrmTWUye0WeEsWYiBAB39
 JHBcccBXhioZREKk4KlQ5BYGBaxrdgIdfrmRh+NUc5Qc4YXjagAJv4gfQIOKt6UWm2XX
 dMq8ThMzqSRPPbum54g7YakzSmUDKvSLMsavFUJeA0hqNn3CI5ppYDw6bAVn9QJsW8r+
 mnNywP9rsJZWVsyH19FKLZ8d3mXrp+km3GrMpPKGvivXgmS2SQSExa+tsS4X8fGOIrMg
 l5dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765807757; x=1766412557;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=EvvyakCXFdGbWJpgHjcGC1PB4viB9GzwOnVIZbEHWnY=;
 b=eEuuNeB+H8+sEVXnlWm5NuoAsX45/zAPMuqHV6G8jPFim2CLFqkOS+eoprFf6xwmSz
 OKiiR/EcZx/rULPS9hDHJLXyZfEOnA7R57tr0QMJqJDmPRgUTBtGIp3Nu00YfXGwm9BU
 TJ9AWVQO7rrz1JDrOwqcfUnHPG9ExATfzEcDK/HjwBfk30Xbxi5x/SP0F864+ZqcIFWq
 YSkeLDGVPOLbtlFP51B8Asnqq6wBr1xGNB1t/R2uJUg8U6AYaYx5Alq0GVsZEHjwgLS9
 qQ5YPxpJuh9QepeLdfcRuQ4y3Ned0ZICO4Fj2EnGdclqG9I482DsjxkeivotPSiW38f0
 BDBg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUOIzkkxBEVMQ4IyZhlz4kNrXLcvj92vhAa2B8PZPy9ItwA4VYu7xp1Z/0DGTBKatkNcFPpE9FL@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzXZ0gaOg6lLfmvoXckC5PqH5JZJTxxNPKSP06xC9+PGw1W5DUY
 nG8vFroHCLtvo84UJubRFXIsbAkiDO0pXPLGhSiOyOSiGDqaV6tGScNz/oWk8nLq+84gJXT13xO
 aBq8D6man0h1wHk0KWIS7LdnLVPuoqwPi+g==
X-Gm-Gg: AY/fxX6lNN9fSo/3ovRWlipm14FkbeZ6bl5ttbr7LMrwWmiJFfzYySn1ztgtSPmMwy/
 tpIGwBhDK45SPWf4fX4tcNR6U3YnI8BjG3enYE7KZjtjaVz2DmCRbjF25h0oyzarhuV4HKIeT4Y
 PQhmCGE/Vsyg8etiDH+ptKLsjGpSriHZq3G7P9jWZWCpMwE1cTijDZQ1sIuD1jNvY2O/iNjuwxe
 /AYRoue5uEjJCK0H/gWMBNQtxSKZFhZnYawAJvahiWzK/0srCJP+mNLlQUxxbS68yxkMDtZ
X-Google-Smtp-Source: AGHT+IH9kxXlCVyGxLN+lGDMmBreennS+3QptlyuHTjhqnjFIBKtFmqM3jFmnlXiRmPr3af4OEM5clqFboPXSC+DrP8=
X-Received: by 2002:a05:7022:7e84:b0:11e:3e9:3e98 with SMTP id
 a92af1059eb24-11f34c4b85dmr4105893c88.7.1765807757312; Mon, 15 Dec 2025
 06:09:17 -0800 (PST)
MIME-Version: 1.0
References: <cover.1765519875.git.donettom@linux.ibm.com>
 <fbc164ab-964f-464d-b94a-80131016b5b8@amd.com>
 <871pl0567w.ritesh.list@gmail.com>
 <1f10b67a-ffdc-4962-af52-758247569e09@amd.com>
 <CADnq5_NbDzqucujDyW009+55mLXZz2PiyaSd9PKXXeXv4pYn0Q@mail.gmail.com>
 <996ef75a-71b3-4ba7-a255-40516c5e9acd@amd.com>
In-Reply-To: <996ef75a-71b3-4ba7-a255-40516c5e9acd@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 15 Dec 2025 09:09:05 -0500
X-Gm-Features: AQt7F2pd9UATiH26H9TTWWTFF851M-LRBE6MzpbqU55XPQjvKwoDovIKcA0MASw
Message-ID: <CADnq5_PvMm0hqqFTmDONEoYnUiHSCTZWUVkcf_PoFP3jDXuCKA@mail.gmail.com>
Subject: Re: [RFC PATCH v1 0/8] amdgpu/amdkfd: Add support for non-4K page
 size systems
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
 Donet Tom <donettom@linux.ibm.com>, 
 amd-gfx@lists.freedesktop.org, Felix Kuehling <Felix.Kuehling@amd.com>, 
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

On Mon, Dec 15, 2025 at 4:47=E2=80=AFAM Christian K=C3=B6nig
<christian.koenig@amd.com> wrote:
>
> On 12/12/25 18:24, Alex Deucher wrote:
> > On Fri, Dec 12, 2025 at 8:19=E2=80=AFAM Christian K=C3=B6nig
> > <christian.koenig@amd.com> wrote:
> >>
> >> On 12/12/25 11:45, Ritesh Harjani (IBM) wrote:
> >>> Christian K=C3=B6nig <christian.koenig@amd.com> writes:
> >>>>> Setup details:
> >>>>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >>>>> System details: Power10 LPAR using 64K pagesize.
> >>>>> AMD GPU:
> >>>>>   Name:                    gfx90a
> >>>>>   Marketing Name:          AMD Instinct MI210
> >>>>>
> >>>>> Queries:
> >>>>> =3D=3D=3D=3D=3D=3D=3D
> >>>>> 1. We currently ran rocr-debug agent tests [1]  and rccl unit tests=
 [2] to test
> >>>>>    these changes. Is there anything else that you would suggest us =
to run to
> >>>>>    shake out any other page size related issues w.r.t the kernel dr=
iver?
> >>>>
> >>>> The ROCm team needs to answer that.
> >>>>
> >>>
> >>> Is there any separate mailing list or list of people whom we can cc
> >>> then?
> >>
> >> With Felix on CC you already got the right person, but he's on vacatio=
n and will not be back before the end of the year.
> >>
> >> I can check on Monday if some people are still around which could answ=
er a couple of questions, but in general don't expect a quick response.
> >>
> >>>>> 2. Patch 1/8: We have a querry regarding eop buffer size Is this eo=
p ring buffer
> >>>>>    size HW dependent? Should it be made PAGE_SIZE?
> >>>>
> >>>> Yes and no.
> >>>>
> >>>
> >>> If you could more elaborate on this please? I am assuming you would
> >>> anyway respond with more context / details on Patch-1 itself. If yes,
> >>> that would be great!
> >>
> >> Well, in general the EOP (End of Pipe) buffer contains in a ring buffe=
r of all the events and actions the CP should execute when shaders and cach=
e flushes finish.
> >>
> >> The size depends on the HW generation and configuration of the GPU etc=
..., but don't ask me for details how that is calculated.
> >>
> >> The point is that the size is completely unrelated to the CPU, so usin=
g PAGE_SIZE is clearly incorrect.
> >>
> >>>>>
> >>>>> 3. Patch 5/8: also have a query w.r.t the error paths when system p=
age size > 4K.
> >>>>>    Do we need to lift this restriction and add MMIO remap support f=
or systems with
> >>>>>    non-4K page sizes?
> >>>>
> >>>> The problem is the HW can't do this.
> >>>>
> >>>
> >>> We aren't that familiar with the HW / SW stack here. Wanted to unders=
tand
> >>> what functionality will be unsupported due to this HW limitation then=
?
> >>
> >> The problem is that the CPU must map some of the registers/resources o=
f the GPU into the address space of the application and you run into securi=
ty issues when you map more than 4k at a time.
> >
> > Right.  There are some 4K pages with the MMIO register BAR which are
> > empty and registers can be remapped into them.  In this case we remap
> > the HDP flush registers into one of those register pages.  This allows
> > applications to flush the HDP write FIFO from either the CPU or
> > another device.  This is needed to flush data written by the CPU or
> > another device to the VRAM BAR out to VRAM (i.e., so the GPU can see
> > it).  This is flushed internally as part of the shader dispatch
> > packets,
>
> As far as I know this is only done for graphics shader submissions to the=
 classic CS interface, but not for compute dispatches through ROCm queues.

There is an explicit PM4 packet to flush the HDP cache for userqs and
for AQL the flush is handled via one of the flags in the dispatch
packet.  The MMIO remap is needed for more fine grained use cases
where you might have the CPU or another device operating in a gang
like scenario with the GPU.

Alex

>
> That's the reason why ROCm needs the remapped MMIO register BAR.
>
> > but there are certain cases where an application may want
> > more control.  This is probably not a showstopper for most ROCm apps.
>
> Well the problem is that you absolutely need the HDP flush/invalidation f=
or 100% correctness. It does work most of the time without it, but you then=
 risk data corruption.
>
> Apart from making the flush/invalidate an IOCTL I think we could also jus=
t use a global dummy page in VRAM.
>
> If you make two 32bit writes which are apart from each other and then a r=
ead back a 32bit value from VRAM that should invalidate the HDP as well. It=
's less efficient than the MMIO BAR remap but still much better than going =
though an IOCTL.
>
> The only tricky part is that you need to get the HW barriers with the doo=
rbell write right.....
>
> > That said, the region is only 4K so if you allow applications to map a
> > larger region they would get access to GPU register pages which they
> > shouldn't have access to.
>
> But don't we also have problems with the doorbell? E.g. the global aggreg=
ated one needs to be 4k as well, or is it ok to over allocate there?
>
> Thinking more about it there is also a major problem with page tables. Th=
ose are 4k by default on modern systems as well and while over allocating t=
hem to 64k is possible that not only wastes some VRAM but can also result i=
n OOM situations because we can't allocate the necessary page tables to swi=
tch from 2MiB to 4k pages in some cases.
>
> Christian.
>
> >
> > Alex
> >
> >>
> >>>>>
> >>>>> [1] ROCr debug agent tests: https://github.com/ROCm/rocr_debug_agen=
t
> >>>>> [2] RCCL tests: https://github.com/ROCm/rccl/tree/develop/test
> >>>>>
> >>>>>
> >>>>> Please note that the changes in this series are on a best effort ba=
sis from our
> >>>>> end. Therefore, requesting the amd-gfx community (who have deeper k=
nowledge of the
> >>>>> HW & SW stack) to kindly help with the review and provide feedback =
/ comments on
> >>>>> these patches. The idea here is, to also have non-4K pagesize (e.g.=
 64K) well
> >>>>> supported with amd gpu kernel driver.
> >>>>
> >>>> Well this is generally nice to have, but there are unfortunately som=
e HW limitations which makes ROCm pretty much unusable on non 4k page size =
systems.
> >>>
> >>> That's a bummer :(
> >>> - Do we have some HW documentation around what are these limitations =
around non-4K pagesize? Any links to such please?
> >>
> >> You already mentioned MMIO remap which obviously has that problem, but=
 if I'm not completely mistaken the PCIe doorbell BAR and some global seq c=
ounter resources will also cause problems here.
> >>
> >> This can all be worked around by delegating those MMIO accesses into t=
he kernel, but that means tons of extra IOCTL overhead.
> >>
> >> Especially the cache flushes which are necessary to avoid corruption a=
re really bad for performance in such an approach.
> >>
> >>> - Are there any latest AMD GPU versions which maybe lifts such restri=
ctions?
> >>
> >> Not that I know off any.
> >>
> >>>> What we can do is to support graphics and MM, but that should alread=
y work out of the box.
> >>>>
> >>>
> >>> - Maybe we should also document, what will work and what won't work d=
ue to these HW limitations.
> >>
> >> Well pretty much everything, I need to double check how ROCm does HDP =
flushing/invalidating when the MMIO remap isn't available.
> >>
> >> Could be that there is already a fallback path and that's the reason w=
hy this approach actually works at all.
> >>
> >>>> What we can do is to support graphics and MM, but that should alread=
y work out of the box.>
> >>> So these patches helped us resolve most of the issues like SDMA hangs
> >>> and GPU kernel page faults which we saw with rocr and rccl tests with
> >>> 64K pagesize. Meaning, we didn't see this working out of box perhaps
> >>> due to 64K pagesize.
> >>
> >> Yeah, but this is all for ROCm and not the graphics side.
> >>
> >> To be honest I'm not sure how ROCm even works when you have 64k pages =
at the moment. I would expect much more issue lurking in the kernel driver.
> >>
> >>> AFAIU, some of these patches may require re-work based on reviews, bu=
t
> >>> at least with these changes, we were able to see all the tests passin=
g.
> >>>
> >>>> I need to talk with Alex and the ROCm team about it if workarounds c=
an be implemented for those issues.
> >>>>
> >>>
> >>> Thanks a lot! That would be super helpful!
> >>>
> >>>
> >>>> Regards,
> >>>> Christian.
> >>>>
> >>>
> >>> Thanks again for the quick response on the patch series.
> >>
> >> You are welcome, but since it's so near to the end of the year not all=
 people are available any more.
> >>
> >> Regards,
> >> Christian.
> >>
> >>>
> >>> -ritesh
> >>
>
