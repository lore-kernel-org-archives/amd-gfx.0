Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE3F5C43458
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Jul 2026 18:02:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B2F2C10F20A;
	Wed,  8 Jul 2026 18:02:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="NxtayGi7";
	dkim-atps=neutral
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com
 [209.85.214.172])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A49A510F20E
 for <amd-gfx@lists.freedesktop.org>; Wed,  8 Jul 2026 18:02:52 +0000 (UTC)
Received: by mail-pl1-f172.google.com with SMTP id
 d9443c01a7336-2ccdce28edeso1456815ad.0
 for <amd-gfx@lists.freedesktop.org>; Wed, 08 Jul 2026 11:02:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783533772; cv=none;
 d=google.com; s=arc-20260327;
 b=iE2Yn0UdweMgPhTg+bIhKYlu62YnUu5BRa2+DM7jilCCcSRZEz0cBWIymFZf5YFzul
 Aba63mMrkJeN5M30is8APZ1xk160z7e49KvEeABOdWn8lamvCQFIj0xkvrruGXLoHeCX
 u/PbQZE/d3wu/y0uMHXZK74XV8hnKpHmkEKRvuJKIJditFvwG7ppxjwQvcLDPPWkyCE/
 tUncOOacR0SOTtWNFXxvbmEYa1cehefguawHmNVib6ZRSqI8t2Ae4dzjtYU8hgniyu2r
 kbvffr8N+HzyLIW+Vc8Q981DuV8A0WwpzF7JxV9AOtWqrenZDDlJ09wjdKdRFjIROakv
 3tJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=FEh+4EcBFMGEIfYduhvV//Y/vK21ASSnlf6NhijwXog=;
 fh=hK0njCboIVFyGkudCY4xAPY1wbX0zQPtLvCYInY4nUU=;
 b=bDcXwi/Mkk5kfafhuUJjUSiyL7ih0BOItY0r0KfWOSRUJmyWqt0o3+ZLKJp8JqnW4Z
 RiA1jbPJXl8u/PruLaavNfw34SBQa4JTjyiEf3eyhj2CiIaf2QvYIKu2rChOdjS6M4DU
 kCKng15NOLzINK4tr25Nceec1XtSRoxeWyMHTkaDDsZnDANJxjpAaQODASKT4zkNsZ50
 UrnQAVOdPQJNe/cA0xMZNZakKPWjpXDsIy+bAYXnve+PZURBgFZiNWzyeU2fb/3LxKsb
 7uPcjrAqmzXSVerKhXEAjeNpEWQVo8H+yNUmWsBOlluYCsGhG2Uk0VaSRTxT5CdF2pL6
 p3WQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783533772; x=1784138572; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=FEh+4EcBFMGEIfYduhvV//Y/vK21ASSnlf6NhijwXog=;
 b=NxtayGi7k5bR8JWShEsvmUOprfCxD54cpLKhmr8mOeHWe1NbvVWgruPDEDdSIirLXT
 b1UOz1IBG6dcNRpIagDWJFkZncxBeimtA6PD+489VjQuAvq+bINNud0WVsNukJ2rQaTD
 u/43j99S8SU8b85yP9lA+aGB4/+IBac2buB2S6Wh7i/Al7WM0zCKx17g8K9PgknGY/qp
 rZXEUQ8I3gc8olCudw5xnoyRQGvJW11xD4uYLKGuXw2BYlKs1bhN6de49BHQoISZV5x4
 bPHVJZhynD0EeapZ4zo9Z1PStwsj1drQDvg8xuUa0f2Si82syf/1+pkU2nD6P/WY0Nrh
 VyDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783533772; x=1784138572;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=FEh+4EcBFMGEIfYduhvV//Y/vK21ASSnlf6NhijwXog=;
 b=B41sh351vU8Ew5QOYZSHk7Z5hA9IEbBgon8shPNZptSaExgn3DJn8PhgryXvbfs/zx
 IdvIrIImWI8z2bLAzzxuFWraJ9qtvoT7s2jdXgdu4IbbpbrPOM39jcqneBo/pJyZ6Xbd
 58wAaf1cxyhF9Pi0NLvBR75RHWeF0npeo17JpheEcGqUCgEU72Slba+of2MNfrziS87c
 nhRvHyodGdRdFqlcqCrMfTpifavzFn5c9X00EAS/HR8j4WnunNw59wNMyHznTRHqWrXG
 gEeE5VL/Ub7rS78nOwOqnkgi5qYtFSR9zu++MZ9P0xd6xTRGYH26euEYskKiT0u6cMlR
 FwiA==
X-Forwarded-Encrypted: i=1;
 AHgh+RrHacAXo3ucX/8H6aG6uaztRhEVspcOii9TGOwQ3eJCSVBFQ1CvviAHU7znac+2YGOGc6Z/xKXk@lists.freedesktop.org
X-Gm-Message-State: AOJu0YybfAHDFcJTwYQ0q0gQwb2clO1rYS5plttFFmkuKX1RXO5p2VPc
 e/ckY8YzxfyQlHxGeKiWggJ2D4+/RaYkgsi7D+sk9UNzeKPKeDuc/mN9x0z4ixcERNGTY6SdYN7
 to2nTOHFePxiaiUjafcPUPto3qmap/Cg=
X-Gm-Gg: AfdE7cmPyBLP/3OUFzqRY+j+xyzsxLky2w/TGna2ocuqCnfThE9R5pvllz7i0/xjlmv
 nzshiJQ5gxJYwpAl2cVts9TcpwR7xpHJeOuFUgVvT2T4MyF8+IxrSp3Q2OtbBmqWobxePTV9A3V
 zD1s0XB7MAczZQuH41OGaLdAu0544N8SJiTPVjtcknpICFHlBAogaBuUbG9EXdz0oAjmB9aql4S
 lGV0tiiOJiU5UJiKBufQfPgEdu9YnDoaBSCe7d3KOVtUZrk59yiV+2UR+E037iQ/edPzegMThHq
 TuYfeIQFREhR1yiQcpU+xjXQIz9EkysqyYgiRlwx7G5DgUnGBU6GgGHHazc=
X-Received: by 2002:a17:902:dacd:b0:2c9:fbde:ab68 with SMTP id
 d9443c01a7336-2ccea3f7e6cmr28601695ad.3.1783533772026; Wed, 08 Jul 2026
 11:02:52 -0700 (PDT)
MIME-Version: 1.0
References: <716a31c5-0484-4ef9-b49e-b71310f92d86@amd.com>
 <20260705100436.6877-1-oz@shift-computing.de>
 <a8339282-e3ef-4a4f-a135-968f94855e76@amd.com>
 <42e07bbb-9384-4871-a345-e0fd6c00a772@shift-computing.de>
 <bd1f1632-f53d-4bfd-9d28-5b66e466366c@amd.com>
 <80f34509-9781-421e-b60f-1b8c772a01a9@shift-computing.de>
 <8dd56d76-e46d-43b6-831d-27e66fa2879a@amd.com>
 <cc849fb3-224e-43c0-bc50-67fd025009e7@shift-computing.de>
 <0478bdcd-dc55-4eeb-b7a3-6c5e625ac5c1@amd.com>
 <6e2eaccf-823b-4db2-a4f3-451e5753af8d@shift-computing.de>
 <bc1dbadd-a3ea-4ff9-826e-6826c20bb54e@amd.com>
 <d224d046-0480-4e38-9e93-29a0d37f3331@shift-computing.de>
 <fc0fbda4-87a1-4a58-a66f-728274b4df92@amd.com>
In-Reply-To: <fc0fbda4-87a1-4a58-a66f-728274b4df92@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 8 Jul 2026 14:02:40 -0400
X-Gm-Features: AVVi8CeZnKc_eZrwGViGliXNNNfOnAbTKHaH0XuyV9KvzQSgox-hPCDhzUTP0XI
Message-ID: <CADnq5_Niga7=B9DqPAOJLkBGMqf25jfcexeCXzBO5_4Cu-Lfhg@mail.gmail.com>
Subject: Re: [PATCH v2] drm/amd/amdgpu: add firmware file fallback for APU
 VBIOS discovery
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: Oz Tiram <oz@shift-computing.de>, amd-gfx@lists.freedesktop.org, 
 alexander.deucher@amd.com, christian.koenig@amd.com, airlied@gmail.com, 
 simona@ffwll.ch, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org
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

On Wed, Jul 8, 2026 at 1:59=E2=80=AFPM Mario Limonciello
<mario.limonciello@amd.com> wrote:
>
>
>
> On 7/8/26 12:52, Oz Tiram wrote:
> > Hi Mario,
> >
> > Tested on 7.2-rc2 with your patch applied. The mismatch condition is
> > unchanged from 6.18.35:
> >
> >    amdgpu 0000:0b:00.0: VFCT bus number mismatch: table 106 !=3D runtim=
e 11,
> >        matching by device identity (vendor 0x1002 device 0x1900)
> >    amdgpu 0000:0b:00.0: Fetched VBIOS from VFCT
> >
> > Both GPUs initialise fully with your patch.
> >
> > I also tested 7.2-rc2 without pci=3Drealloc,assign-busses to check whet=
her
> > the pci/realloc changes fixed the dGPU probe failure. They did not -- t=
he
> > dGPU still fails on 7.2-rc2:
> >
> >    amdgpu 0000:03:00.0: Fatal error during GPU init
> >    amdgpu 0000:03:00.0: probe with driver amdgpu failed with error -12
> >
> > Without the kernel argument the iGPU sits at its POST bus (0x6A), VFCT
> > matches directly, and it works fine -- but the dGPU is unusable.
> > pci=3Drealloc,assign-busses remains necessary for this machine on 7.2-r=
c2,
> > which means the VFCT mismatch persists and your patch is still needed.
> >
> > Thank you for not giving up on me so quickly!
> > This is my first time working on such issue. It feels
> > daunting to modify kernel code.
>
> OK, in that case I will clean up and post the patches shortly.  You'll
> be able to use them for a workaround if everyone else is aligned.  The
> part I'm worried about with these is how they would interplay with a
> system with multiple of the same GPU.  But I don't believe we would be
> fetching VBIOS from VFCT in that case most likely?  Not sure.

It's allowed by the spec.  A number of apple systems use VFCT for
multu-GPU systems with the same GPU.

Alex

>
> We really shouldn't have to set pci=3Drealloc,assign-busses on a design
> with all internal PCIe devices.  We should adjust resource allocation
> code for this case.
>
> So please start another another thread with the linux-pci mailing list
> on this issue, include a full dmesg showing what happens when you don't
> add the parameters and then what happens when you do (feel free to
> include/reference this patch in that thread too).
>
> If you want to use one, this is the kind of thing an LLM with access to
> a kernel checkout and both those dmesgs might be good at helping to
> propose a draft for a solution to the resource allocation code too.
>
> You can CC me on that linux-pci mailing list submission, and we'll see
> if we can come up with a better solution for you.
>
> >
> > Oz
> >
> >
> > On 7/8/26 18:39, Mario Limonciello wrote:
> >> On 7/8/26 11:35, Oz Tiram wrote:
> >>> Hi Mario,
> >>>
> >>> The GPU is internal. It's an AMD RADEON PRO W7800 48GB.
> >>> The kernel is built from gentoo-sources-6.18.35.
> >>>
> >>> I will test the latest sys-kernel/vanilla-sources (7.1.3) and let you
> >>> know.
> >>>
> >>> Best regards,
> >>
> >> Thanks. Can you please test 7.2-rc2?
> >>
> >> I'll clean up the workaround and propose it for review in parallel.
> >>
> >>>
> >>> Oz
> >>>
> >>> On 7/8/26 15:13, Mario Limonciello wrote:
> >>>>
> >>>> On 7/8/26 08:10, Oz Tiram wrote:
> >>>>> Hi Mario,
> >>>>>
> >>>>>  > If you drop that - does this notice still come up?
> >>>>>
> >>>>> No, the notice does not appear without pci=3Drealloc,assign-busses.
> >>>>> The iGPU  stays at its POST bus (0x6A =3D 106), VFCT matches
> >>>>> directly, and it fetches the VBIOS without any mismatch.
> >>>>>
> >>>>> However, dropping the kernel argument is not an option on this
> >>>>> machine:
> >>>>> without it the discrete GPU (0x7449) fails to probe entirely:
> >>>>>
> >>>>>    amdgpu 0000:03:00.0: amdgpu: Fatal error during GPU init
> >>>>>    amdgpu 0000:03:00.0: probe with driver amdgpu failed with error =
-12
> >>>>>
> >>>>> The firmware BARs cannot be mapped without resource reallocation, s=
o
> >>>>> pci=3Drealloc,assign-busses is required for the dGPU, which in turn
> >>>>> reassigns
> >>>>> the iGPU to bus 0x0B and triggers the mismatch your patch resolves.
> >>>>
> >>>> Got it; thanks for clarifying.  I would like to dig a little bit
> >>>> futher into that though.  What kernel are you finding this behavior
> >>>> and can it still reproduce with 7.2-rc2 if it's older? There was a
> >>>> bunch of pci/realloc changes that happened in the last cycle that
> >>>> might have helped this.
> >>>>
> >>>> Also; is it an eGPU (external) or dGPU (internal)?
> >>>>
> >>>> If it's an dGPU IMO this is arguably a BIOS issue that not enough
> >>>> resources were applied in the first place.
> >>>>
> >>>> Thanks,
> >>>>
> >>>>>
> >>>>>
> >>>>> Thank you,
> >>>>>
> >>>>> Oz
> >>>>>
> >>>>>
> >>>>> On 7/8/26 14:55, Mario Limonciello wrote:
> >>>>>> Hi Oz,
> >>>>>>
> >>>>>> On 7/8/26 07:36, Oz Tiram wrote:
> >>>>>>> Hi Mario,
> >>>>>>>
> >>>>>>> Tested on a Morefine MNAS X1 AI Workstation (AMD Ryzen 7 Pro
> >>>>>>> 8845HS / Radeon 780M iGPU) with pci=3Drealloc,assign-busses.
> >>>>>>>
> >>>>>>> The VFCT entry for the iGPU has PCIBus=3D106 (0x6A, recorded at
> >>>>>>> POST) while the
> >>>>>>> runtime bus is 11 (0x0B). Your patch fires exactly as expected:
> >>>>>>>
> >>>>>>>    amdgpu 0000:0b:00.0: amdgpu: VFCT bus number mismatch: table
> >>>>>>> 106 ! =3D runtime 11,
> >>>>>>>        matching by device identity (vendor 0x1002 device 0x1900)
> >>>>>>>    amdgpu 0000:0b:00.0: amdgpu: Fetched VBIOS from VFCT
> >>>>>>>
> >>>>>>> The iGPU initialises fully and drives the framebuffer.
> >>>>>>>
> >>>>>>> One minor nit: the dev_notice format string ends with \\n (two
> >>>>>>> characters) rather
> >>>>>>> than \n. The resulting kernel message has a literal "\n" at the
> >>>>>>> end. Same issue
> >>>>>>> exists in the nearby "too short #2" dev_info -- not introduced by
> >>>>>>> your patch, but
> >>>>>>> might be worth cleaning up.
> >>>>>>>
> >>>>>>> Tested-by: Oz Tiram <oz@shift-computing.de>
> >>>>>>>
> >>>>>>
> >>>>>> Thanks for confirming.  Before I split up this patch and post it
> >>>>>> in smaller logical pieces can you confirm my proposed root cause
> >>>>>> is right that this issue happens because "pci=3Drealloc,assign-
> >>>>>> busses" was on your kernel command line?
> >>>>>>
> >>>>>> If you drop that - does this notice still come up?
> >>>>>>
> >>>>>> Thanks,
> >>>>>>
> >>>>>>> On 7/6/26 02:56, Mario Limonciello wrote:
> >>>>>>>>
> >>>>>>>>
> >>>>>>>> On 7/5/26 14:10, Oz Tiram wrote:
> >>>>>>>>> Hi Mario,
> >>>>>>>>>
> >>>>>>>>>    To make sure I understand correctly: are you suggesting that
> >>>>>>>>> the bus
> >>>>>>>>>    number in the VFCT was legitimate at BIOS POST time, and tha=
t
> >>>>>>>>>    pci=3Drealloc,assign-busses is what changes it at runtime,
> >>>>>>>>> causing the
> >>>>>>>>>    mismatch?
> >>>>>>>>
> >>>>>>>> That's what it sounds like right now.  You can easily drop all
> >>>>>>>> the superfluous kernel command line optiosn and see.
> >>>>>>>>
> >>>>>>>>>
> >>>>>>>>>    I'm not familiar enough with the PCI subsystem to know the
> >>>>>>>>> right way to
> >>>>>>>>>    implement that =E2=80=94 could you point me in the right dir=
ection?
> >>>>>>>>
> >>>>>>>> Well there's a variety of ways to do it.  But how about we start
> >>>>>>>> here - if we make that specific busnr match optional and instead
> >>>>>>>> make a VID/DID match.
> >>>>>>>>
> >>>>>>>> See if the attached patch helps.
> >>>>>>>>
> >>>>>>>>>
> >>>>>>>>>    Oz
> >>>>>>>>>
> >>>>>>>>> On 7/5/26 20:37, Mario Limonciello wrote:
> >>>>>>>>>>
> >>>>>>>>>>
> >>>>>>>>>> On 7/5/26 05:04, Oz Tiram wrote:
> >>>>>>>>>>> APUs (e.g. AMD Radeon 780M / HawkPoint, PCI 1002:1900) have n=
o
> >>>>>>>>>>> dedicated VBIOS ROM chip.  amdgpu_get_bios_apu() attempts
> >>>>>>>>>>> four paths
> >>>>>>>>>>> before giving up:
> >>>>>>>>>>>
> >>>>>>>>>>>    1. ACPI VFCT table
> >>>>>>>>>>>    2. VRAM BAR read
> >>>>>>>>>>>    3. ROM BAR read
> >>>>>>>>>>>    4. platform BIOS
> >>>>>>>>>>>
> >>>>>>>>>>> On some systems all four fail.  The specific case motivating
> >>>>>>>>>>> this patch
> >>>>>>>>>>> is a hybrid graphics machine (dGPU + APU) where:
> >>>>>>>>>>>
> >>>>>>>>>>>    - The VFCT table contains the iGPU entry but with a stale
> >>>>>>>>>>> PCIBus value
> >>>>>>>>>>>      from BIOS POST time (0x6A).  When the kernel boots with
> >>>>>>>>>>>      pci=3Drealloc,assign-busses, PCI bus numbers are
> >>>>>>>>>>> reassigned dynamically
> >>>>>>>>>>>      and the iGPU lands on bus 0x0B at runtime.
> >>>>>>>>>>> amdgpu_acpi_vfct_bios()
> >>>>>>>>>>>      matches entries by bus number, so the entry is never fou=
nd.
> >>>>>>>>>>>    - The VRAM BAR is unmapped at probe time.
> >>>>>>>>>>>    - The ROM BAR is zero (PCI firmware did not assign it).
> >>>>>>>>>>>    - No platform BIOS mapping exists.
> >>>>>>>>>>>
> >>>>>>>>>>> The UEFI GOP driver initialises the iGPU successfully for
> >>>>>>>>>>> early display,
> >>>>>>>>>>> confirming the hardware is functional.  The VBIOS image data
> >>>>>>>>>>> embedded in
> >>>>>>>>>>> the VFCT is also valid; only the PCIBus metadata is wrong.
> >>>>>>>>>>
> >>>>>>>>>> So the BIOS on this machine is actually totally fine; it's
> >>>>>>>>>> just when the kernel is booted to reassign busses there is a
> >>>>>>>>>> problem?
> >>>>>>>>>>
> >>>>>>>>>> In that case; why not detect the kernel was booted this way
> >>>>>>>>>> and keep track of the original bus number when reassigned to
> >>>>>>>>>> avoid the issue?
> >>>>>>>>>>
> >>>>>>>>>>> The firmware
> >>>>>>>>>>> file can be extracted directly from the VFCT using dd:
> >>>>>>>>>>>
> >>>>>>>>>>>    dd if=3D/sys/firmware/acpi/tables/VFCT bs=3D1 skip=3D$((0x=
68))
> >>>>>>>>>>> count=3D16896 \
> >>>>>>>>>>>       of=3D/lib/firmware/amdgpu/1002_1900.bin
> >>>>>>>>>>>
> >>>>>>>>>>> (0x68 is the byte offset of the VBIOS image after the ACPI
> >>>>>>>>>>> table header
> >>>>>>>>>>> and VFCT_IMAGE_HEADER; the image length 16896 comes from the
> >>>>>>>>>>> ImageLength
> >>>>>>>>>>> field in VFCT_IMAGE_HEADER.)
> >>>>>>>>>>>
> >>>>>>>>>>> The driver then prints "Unable to locate a BIOS ROM" and
> >>>>>>>>>>> refuses to
> >>>>>>>>>>> bind, leaving the APU completely unusable under Linux.
> >>>>>>>>>>>
> >>>>>>>>>>> Add a fifth fallback: request a firmware file named
> >>>>>>>>>>> "amdgpu/<vendor>_<device>.bin" (e.g. "amdgpu/1002_1900.bin") =
via
> >>>>>>>>>>> request_firmware().  This allows a VBIOS image extracted as
> >>>>>>>>>>> above to be
> >>>>>>>>>>> placed in /lib/firmware/ and makes the binding succeed
> >>>>>>>>>>> without patching
> >>>>>>>>>>> ACPI tables or BIOS.
> >>>>>>>>>>>
> >>>>>>>>>>> The fallback is only reached if all existing paths have
> >>>>>>>>>>> already failed,
> >>>>>>>>>>> so there is no regression risk for boards where VFCT or ROM
> >>>>>>>>>>> BAR work.
> >>>>>>>>>>
> >>>>>>>>>> What happens if the VBIOS changes in another way one boot to
> >>>>>>>>>> another? You might have some other stateful information that
> >>>>>>>>>> isn't updated.
> >>>>>>>>>>
> >>>>>>>>>> The whole thing to me feels like a hack for a behavior we can
> >>>>>>>>>> control in the kernel when doing reassignments.
> >>>>>>>>>>>
> >>>>>>>>>>> Signed-off-by: Oz Tiram <oz@shift-computing.de>
> >>>>>>>>>>> ---
> >>>>>>>>>>> v2: Fix commit message: clarify that VFCT contains the iGPU
> >>>>>>>>>>> entry but
> >>>>>>>>>>>      with a stale PCIBus from BIOS POST that mismatches the
> >>>>>>>>>>> runtime bus
> >>>>>>>>>>>      number assigned by pci=3Drealloc,assign-busses. Explain
> >>>>>>>>>>> that the VBIOS
> >>>>>>>>>>>      image data is valid and document the dd extraction
> >>>>>>>>>>> command and byte
> >>>>>>>>>>>      offsets.  Note that the UEFI GOP driver initialises the
> >>>>>>>>>>> iGPU
> >>>>>>>>>>>      successfully, confirming the hardware is functional.
> >>>>>>>>>>>
> >>>>>>>>>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c | 23 +++++++++++++
> >>>>>>>>>>> ++ ++ ++ ++++
> >>>>>>>>>>>   1 file changed, 23 insertions(+)
> >>>>>>>>>>>
> >>>>>>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c b/
> >>>>>>>>>>> drivers/ gpu/ drm/amd/amdgpu/amdgpu_bios.c
> >>>>>>>>>>> index aa039e148a5e..86064c753b09 100644
> >>>>>>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c
> >>>>>>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c
> >>>>>>>>>>> @@ -26,6 +26,7 @@
> >>>>>>>>>>>    *          Jerome Glisse
> >>>>>>>>>>>    */
> >>>>>>>>>>>   +#include <linux/firmware.h>
> >>>>>>>>>>>   #include "amdgpu.h"
> >>>>>>>>>>>   #include "atom.h"
> >>>>>>>>>>>   @@ -457,6 +458,28 @@ static bool amdgpu_get_bios_apu(struct
> >>>>>>>>>>> amdgpu_device *adev)
> >>>>>>>>>>>           goto success;
> >>>>>>>>>>>       }
> >>>>>>>>>>>   +    {
> >>>>>>>>>>> +        const struct firmware *fw;
> >>>>>>>>>>> +        char fw_name[32];
> >>>>>>>>>>> +        size_t fw_size;
> >>>>>>>>>>> +
> >>>>>>>>>>> +        snprintf(fw_name, sizeof(fw_name), "amdgpu/
> >>>>>>>>>>> %04x_%04x.bin",
> >>>>>>>>>>> +             adev->pdev->vendor, adev->pdev->device);
> >>>>>>>>>>> +        if (request_firmware(&fw, fw_name, adev->dev) =3D=3D=
 0) {
> >>>>>>>>>>> +            adev->bios =3D kmemdup(fw->data, fw->size,
> >>>>>>>>>>> GFP_KERNEL);
> >>>>>>>>>>> +            fw_size =3D fw->size;
> >>>>>>>>>>> +            release_firmware(fw);
> >>>>>>>>>>> +            if (!adev->bios || !check_atom_bios(adev,
> >>>>>>>>>>> fw_size)) {
> >>>>>>>>>>> +                amdgpu_bios_release(adev);
> >>>>>>>>>>> +            } else {
> >>>>>>>>>>> +                adev->bios_size =3D fw_size;
> >>>>>>>>>>> +                dev_info(adev->dev, "Fetched VBIOS from
> >>>>>>>>>>> firmware file %s\n",
> >>>>>>>>>>> +                     fw_name);
> >>>>>>>>>>> +                goto success;
> >>>>>>>>>>> +            }
> >>>>>>>>>>> +        }
> >>>>>>>>>>> +    }
> >>>>>>>>>>> +
> >>>>>>>>>>>       dev_err(adev->dev, "Unable to locate a BIOS ROM\n");
> >>>>>>>>>>>       return false;
> >>>>>>>>>>
> >>>>>>
> >>>>
> >>
>
