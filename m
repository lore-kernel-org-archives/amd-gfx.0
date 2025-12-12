Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 463FED59D79
	for <amd-gfx@archiver.kernel.org>; Fri, 12 Dec 2025 17:24:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E8B9610E2C9;
	Fri, 12 Dec 2025 17:24:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="HEJ7mkgt";
	dkim-atps=neutral
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com
 [209.85.216.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 313EB10E090
 for <amd-gfx@lists.freedesktop.org>; Fri, 12 Dec 2025 17:24:21 +0000 (UTC)
Received: by mail-pj1-f42.google.com with SMTP id
 98e67ed59e1d1-349e7fd4536so158567a91.3
 for <amd-gfx@lists.freedesktop.org>; Fri, 12 Dec 2025 09:24:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1765560260; x=1766165060; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=a/FZa/F4cdFSiTiFQR2b7zTzZUp/pnUZZUNUaCgLIbA=;
 b=HEJ7mkgt99bjwsyeIjkPnODlBVbmLjhHmVlhdqqpsDtWZUd8SCI628Gs8E9eVnkxfw
 hu+9/BFxM2QGnCw11WyTtS/+NhagAFfVWDjBXW+kAtWwtIwcamXfPTU46A8OJGnMgBLN
 edIbSmobGDwMSYHHCQFj+TQ2jffbvYtQ8+k43a8/n1GwrQ1pZg2cNgzYZv+fdLSr0Ssp
 qvey7E9AmjhUWpWOMSgwB9y3jO6+MSHH9CBBtvp2pQRg66mOxwYtMerz5qKQVpPYchPm
 g4h2/6lq997oz55gnIZq9ZPIUG19OZ3H4NGWgCNWTDQ2qxTDwkZCT7k25AV/Dg5sQ2c9
 jDyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765560260; x=1766165060;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=a/FZa/F4cdFSiTiFQR2b7zTzZUp/pnUZZUNUaCgLIbA=;
 b=rlILExkpNt0jOcIAtEvtEhAaVtpsTg4SyjN1YRvDNUchaQe4E7bUeFSU9Xe7r3rrgQ
 O6Q19hWA/Yi1KZ6E+OFpIQypnytFpYyA3FJq/KzMhmX5vLyPBuX7UYtejLRK+/RAWTx4
 Nm3Q5rgLkMQCSZUH5+VaRKNXdWFVF7xQxCEz3bzZakjba5CgMhtEv1RDq6TgOglzAObc
 S9cntujY+T6p6M1dTkERcYD7iFjqfidQV8A0ECDyL/j2mrjwmatyc4zwNEtjZZCrOHMI
 Yxk30Hpl3ZbWWKV2Xbd+v3IEhGB5Hnp5PkB+xUKPEDrinsewQquPR7o+A+qygGrD/AMN
 7YBw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWZ7GBllFutF05VABXIEUT5JhIp3+qtoMmFebKuKol4Y3pPahrUohyccDUd0YpA/58lSbCgCWth@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwjWlwOSAkb3UDLFG3p7+KWbChRI4Gbt1vN/23K4FroDUzUl8bn
 eRFSiQPJIVOLsmbR71i9e9Sw2Uwf7QjY9e4VPLsfcbVMsOtMcuWfptFSdMougCYndFsEO8rJbqu
 fnqaBg3aAPBaDkt2foN6Ao1ZC8K8paSE=
X-Gm-Gg: AY/fxX4F3K46NKJFCs4ypL2eIMsCKCGVLPa63v/9SBzIXCNdpDPUtjpkCCaU4H/XUIh
 Qs/I4ksEqr0XCcipaKHp7Y9X9bJPqfaIehOP6nJhaWDPa0+3+gxJVi5lRcGbsdHpPLPfYJDiK9s
 excaZwYSmMbJGsm0OWiYsDxNl3aZEpJ4DeOj2/EqfF8iatFLi/tQm6720kCuLESvn7XSosyzxBd
 HmQhnFgbnSp6IJTrSd7S5s1vdUy29KYEUMwH6B9zE4UE8ZUjzGILd0wC/MqL9QtaDi9qqA=
X-Google-Smtp-Source: AGHT+IHerdGvaBNth9TVI5g+Uh3tbNH8I01/hLG9oDu2NYGpTGxsk5t3qKctGW0quHILE8q43lyELGPfM4/u7lgBI6o=
X-Received: by 2002:a05:7022:248a:b0:11e:332:1e01 with SMTP id
 a92af1059eb24-11f34c07337mr1198242c88.3.1765560260375; Fri, 12 Dec 2025
 09:24:20 -0800 (PST)
MIME-Version: 1.0
References: <cover.1765519875.git.donettom@linux.ibm.com>
 <fbc164ab-964f-464d-b94a-80131016b5b8@amd.com>
 <871pl0567w.ritesh.list@gmail.com>
 <1f10b67a-ffdc-4962-af52-758247569e09@amd.com>
In-Reply-To: <1f10b67a-ffdc-4962-af52-758247569e09@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 12 Dec 2025 12:24:08 -0500
X-Gm-Features: AQt7F2qbc_I9Sn4dQlteWUCqSL4GpZaMAfJdpWToj-jYRRTgO3mkzHu01HBx-hM
Message-ID: <CADnq5_NbDzqucujDyW009+55mLXZz2PiyaSd9PKXXeXv4pYn0Q@mail.gmail.com>
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

On Fri, Dec 12, 2025 at 8:19=E2=80=AFAM Christian K=C3=B6nig
<christian.koenig@amd.com> wrote:
>
> On 12/12/25 11:45, Ritesh Harjani (IBM) wrote:
> > Christian K=C3=B6nig <christian.koenig@amd.com> writes:
> >>> Setup details:
> >>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >>> System details: Power10 LPAR using 64K pagesize.
> >>> AMD GPU:
> >>>   Name:                    gfx90a
> >>>   Marketing Name:          AMD Instinct MI210
> >>>
> >>> Queries:
> >>> =3D=3D=3D=3D=3D=3D=3D
> >>> 1. We currently ran rocr-debug agent tests [1]  and rccl unit tests [=
2] to test
> >>>    these changes. Is there anything else that you would suggest us to=
 run to
> >>>    shake out any other page size related issues w.r.t the kernel driv=
er?
> >>
> >> The ROCm team needs to answer that.
> >>
> >
> > Is there any separate mailing list or list of people whom we can cc
> > then?
>
> With Felix on CC you already got the right person, but he's on vacation a=
nd will not be back before the end of the year.
>
> I can check on Monday if some people are still around which could answer =
a couple of questions, but in general don't expect a quick response.
>
> >>> 2. Patch 1/8: We have a querry regarding eop buffer size Is this eop =
ring buffer
> >>>    size HW dependent? Should it be made PAGE_SIZE?
> >>
> >> Yes and no.
> >>
> >
> > If you could more elaborate on this please? I am assuming you would
> > anyway respond with more context / details on Patch-1 itself. If yes,
> > that would be great!
>
> Well, in general the EOP (End of Pipe) buffer contains in a ring buffer o=
f all the events and actions the CP should execute when shaders and cache f=
lushes finish.
>
> The size depends on the HW generation and configuration of the GPU etc...=
, but don't ask me for details how that is calculated.
>
> The point is that the size is completely unrelated to the CPU, so using P=
AGE_SIZE is clearly incorrect.
>
> >>>
> >>> 3. Patch 5/8: also have a query w.r.t the error paths when system pag=
e size > 4K.
> >>>    Do we need to lift this restriction and add MMIO remap support for=
 systems with
> >>>    non-4K page sizes?
> >>
> >> The problem is the HW can't do this.
> >>
> >
> > We aren't that familiar with the HW / SW stack here. Wanted to understa=
nd
> > what functionality will be unsupported due to this HW limitation then?
>
> The problem is that the CPU must map some of the registers/resources of t=
he GPU into the address space of the application and you run into security =
issues when you map more than 4k at a time.

Right.  There are some 4K pages with the MMIO register BAR which are
empty and registers can be remapped into them.  In this case we remap
the HDP flush registers into one of those register pages.  This allows
applications to flush the HDP write FIFO from either the CPU or
another device.  This is needed to flush data written by the CPU or
another device to the VRAM BAR out to VRAM (i.e., so the GPU can see
it).  This is flushed internally as part of the shader dispatch
packets, but there are certain cases where an application may want
more control.  This is probably not a showstopper for most ROCm apps.
That said, the region is only 4K so if you allow applications to map a
larger region they would get access to GPU register pages which they
shouldn't have access to.

Alex

>
> >>>
> >>> [1] ROCr debug agent tests: https://github.com/ROCm/rocr_debug_agent
> >>> [2] RCCL tests: https://github.com/ROCm/rccl/tree/develop/test
> >>>
> >>>
> >>> Please note that the changes in this series are on a best effort basi=
s from our
> >>> end. Therefore, requesting the amd-gfx community (who have deeper kno=
wledge of the
> >>> HW & SW stack) to kindly help with the review and provide feedback / =
comments on
> >>> these patches. The idea here is, to also have non-4K pagesize (e.g. 6=
4K) well
> >>> supported with amd gpu kernel driver.
> >>
> >> Well this is generally nice to have, but there are unfortunately some =
HW limitations which makes ROCm pretty much unusable on non 4k page size sy=
stems.
> >
> > That's a bummer :(
> > - Do we have some HW documentation around what are these limitations ar=
ound non-4K pagesize? Any links to such please?
>
> You already mentioned MMIO remap which obviously has that problem, but if=
 I'm not completely mistaken the PCIe doorbell BAR and some global seq coun=
ter resources will also cause problems here.
>
> This can all be worked around by delegating those MMIO accesses into the =
kernel, but that means tons of extra IOCTL overhead.
>
> Especially the cache flushes which are necessary to avoid corruption are =
really bad for performance in such an approach.
>
> > - Are there any latest AMD GPU versions which maybe lifts such restrict=
ions?
>
> Not that I know off any.
>
> >> What we can do is to support graphics and MM, but that should already =
work out of the box.
> >>
> >
> > - Maybe we should also document, what will work and what won't work due=
 to these HW limitations.
>
> Well pretty much everything, I need to double check how ROCm does HDP flu=
shing/invalidating when the MMIO remap isn't available.
>
> Could be that there is already a fallback path and that's the reason why =
this approach actually works at all.
>
> >> What we can do is to support graphics and MM, but that should already =
work out of the box.>
> > So these patches helped us resolve most of the issues like SDMA hangs
> > and GPU kernel page faults which we saw with rocr and rccl tests with
> > 64K pagesize. Meaning, we didn't see this working out of box perhaps
> > due to 64K pagesize.
>
> Yeah, but this is all for ROCm and not the graphics side.
>
> To be honest I'm not sure how ROCm even works when you have 64k pages at =
the moment. I would expect much more issue lurking in the kernel driver.
>
> > AFAIU, some of these patches may require re-work based on reviews, but
> > at least with these changes, we were able to see all the tests passing.
> >
> >> I need to talk with Alex and the ROCm team about it if workarounds can=
 be implemented for those issues.
> >>
> >
> > Thanks a lot! That would be super helpful!
> >
> >
> >> Regards,
> >> Christian.
> >>
> >
> > Thanks again for the quick response on the patch series.
>
> You are welcome, but since it's so near to the end of the year not all pe=
ople are available any more.
>
> Regards,
> Christian.
>
> >
> > -ritesh
>
