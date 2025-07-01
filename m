Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4728C7EE30
	for <amd-gfx@archiver.kernel.org>; Tue,  1 Jul 2025 18:52:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7C94F10E640;
	Tue,  1 Jul 2025 18:52:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="PECMGjt6";
	dkim-atps=neutral
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com
 [209.85.216.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7B68F10E634;
 Tue,  1 Jul 2025 18:52:40 +0000 (UTC)
Received: by mail-pj1-f47.google.com with SMTP id
 98e67ed59e1d1-3138e64fc73so875759a91.2; 
 Tue, 01 Jul 2025 11:52:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1751395960; x=1752000760; darn=lists.freedesktop.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=L6/2QDcUd+BuLhy26L8CwtizFOS8qyx61q1YP4an3WA=;
 b=PECMGjt63zn258YPgL/Axy3S8oU+SFH5dPnhlTJAcXhoCq76KMAodDUI3wVhzfYNT7
 T/duU1Ik3wB3821IULavgkAuZ2KeRiXFKUpbTq6a+CEDjeRZc0G3H2zjwOOzzQ1M0eAW
 RpW3AhgcBPF/AoU2NNg7aUlK9YpPu+TERBu9AKFM1wcx4LPdz/oa7fTn3l2ocI1iRDXm
 XEBrOVyJRT5krq7bi1D9LHLOdX0gGs8SG8amjBVsNu014F7bsmo9fQtRW+Vl4h6mDQUJ
 dOkUyLWyKiJ2A2Mm4Mflcw/7di/645/vkJH6D+AEavymYjKgp+1p195U/JFxG2/Sjh9v
 bW5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751395960; x=1752000760;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=L6/2QDcUd+BuLhy26L8CwtizFOS8qyx61q1YP4an3WA=;
 b=ibiNAYqEVHLcR/ykr+Jbm+mBpAacLx48HVLXSL+6zWeapBG0xptoK7hKVy2MSPcxJW
 mD8JE1SdiebDjBASPH0CRAk5ihAa51yE2uQa8BxaU+2TcHcgtgtpgrZgGLOdzrSiwFjz
 rz9bLDnpCQN3n1//s8ZPLk+Sx3QTV+t/UH1apRIyu2fs5swcoSbEfrsYOXf7+oRVT1rv
 NvzsvwreyrJDNLjiNtxcaTyLoleye5dhi5XePyahRnxWK+36meUHtlDNpptz4gqgQwuB
 AmscwM+Nx+p8p2bCMZURehdkXvZ8TloqrlEhiYW3MCWFoX7BcRWMvy3j/bkI5bVB7nNa
 WUHQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUlFHnVKGq/IxvMYjUSr34Llt8/wrbRMprWBIHXSJIWbJ1Zf+xTVucT3gjHvQdf8dUYHmx6MEx6iU1uyk6T@lists.freedesktop.org,
 AJvYcCV6cbUf5nHbZMbCrpkUrxvU1EXNMvvQfZhXyefgjJRvDs9mAcooMgUF9YRLeqjyyj9/z6n23HF/Tw==@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yx5YuppmioDHrZPln0O6DxI38oL5FQMkUZnSQJU1SheqDRxles6
 ieas9frmf4dWub2g0wayccaJiYjE8PIeSTmG6qPRNvuZVfkD1M9FpT7zEQtixMQp+B9mVfPeJeV
 rKTTWj7HJzp3CuNt1IMkMSHV9cmn7Tds=
X-Gm-Gg: ASbGncvrrJCTZYnC26By5XOSlopi/hCkFw5wV72iHs19klOVE/ZQIu0MXRV41FSEprj
 DpXh5NWhYUqZIMSXrsdYe82iXwiVBIq90j7VLyvnlA7law7fr9tmI2jf97yPFlYb/ihlm5nMlZD
 8StkoJricyMR9V037wlqfFS003fvdrkIJzWDTqzQ62j7dX
X-Google-Smtp-Source: AGHT+IGkQ8mCCmR4JjVXW5iuZS8vaedAJkA9RsCQCR7WLKSjgSmTzGv8Iqae07UmyHHcfhUZ8lyjBz3vf6R6NtZn5so=
X-Received: by 2002:a17:90b:2f48:b0:311:c939:c842 with SMTP id
 98e67ed59e1d1-31a90c45d3emr46689a91.7.1751395959654; Tue, 01 Jul 2025
 11:52:39 -0700 (PDT)
MIME-Version: 1.0
References: <CAOR=gxQahs8SXmObsj-6-ux3BMpTZc=8WrSZ83hikpoBZR3OZg@mail.gmail.com>
 <CADnq5_P-60BpvNJf5W16TPbFDXRM5wtHh10iiZm2z6DEDFqn=g@mail.gmail.com>
 <72408fd5-bd8d-4f86-9856-b3b7858f0b9b@amd.com>
 <CAOR=gxRKU3guoXBLi-CBngaWgFa+vgkwzejLQW1aZmrrJL_bxw@mail.gmail.com>
 <CAOR=gxRf0DALhdV_8mRU_7OeYwGX25ccyUvgrDxakwFtB7jDjg@mail.gmail.com>
In-Reply-To: <CAOR=gxRf0DALhdV_8mRU_7OeYwGX25ccyUvgrDxakwFtB7jDjg@mail.gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 1 Jul 2025 14:52:28 -0400
X-Gm-Features: Ac12FXwPAKcKgCM_7iMZuqWQ-nlvgZKxa5zzsvfbz35HpW-xIw89hxWLaqK_LWo
Message-ID: <CADnq5_NbYNgUciE9gFepXLhPNwu1Mfr8BLQowSGkv8caHSE4Tw@mail.gmail.com>
Subject: =?UTF-8?B?UmU6IFtSRUdSRVNTSU9OXSBSWC01ODAgKGdmeDgwMykgR1BVIGhhbmdzIHNpbmNlIH52Ng==?=
 =?UTF-8?B?LjE0LjEg4oCTIOKAnHNjaGVkdWxlciBjb21wXzEuMS4xIGlzIG5vdCByZWFkeeKAnSAvIFJPQ20gNS43?=
 =?UTF-8?B?LTYuNCsgYnJva2Vu?=
To: Johl Brown <johlbrown@gmail.com>
Cc: Felix Kuehling <felix.kuehling@amd.com>, amd-gfx@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, amd-gfx-owner@lists.freedesktop.org
Content-Type: multipart/alternative; boundary="000000000000094cd30638e2a6d1"
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

--000000000000094cd30638e2a6d1
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

That's a GPU page fault.  Something in the userspace command stream to the
GPU accessed a non-mapped page with the GPU.

Alex

On Tue, Jul 1, 2025 at 5:39=E2=80=AFAM Johl Brown <johlbrown@gmail.com> wro=
te:

> Hi all, hoping I'm still on-side... Thank you for your consideration.
> Linux archb 6.14.0-rt3-arch1-1-rt #1 SMP PREEMPT_RT Wed, 21 May 2025
> 13:21:26 +0000 x86_64 GNU/Linux
>
> AMDGPU sequence
> Time Message
> 19:29:29 *GPU fault detected* (0x00020802) for process *kdeconnect-app
> (pid 2285)*; VM fault at page 2048, write from *TC0*.
> 19:29:29 Second fault (0x0000880c) for same process; VM fault at page 0,
> read from *TC6*.
> 19:29:39 *ring gfx timeout* (signaled seq 699, emitted seq 701) =E2=86=92
> =E2=80=9CStarting gfx ring reset=E2=80=9D =E2=86=92 *Ring gfx reset failu=
re*.
> 19:29:40 Self-tests: ring comp_1.0.1 test failed (-110) and ring
> comp_1.2.1 test failed (-110).
>
>
> On Thu, 26 Jun 2025 at 10:38, Johl Brown <johlbrown@gmail.com> wrote:
>
>> Apologies, I believe it was attached to one of the above posts. Please
>> find complete dmesg attached.
>>
>> I had previously attempted to GDB/Ghidra at (
>> https://github.com/lamikr/rocm_sdk_builder/issues/173 ) while
>> experiencing segfaults on previous kernels/roc.
>> Around Nov 3, 2024 (I can't see any comment I made there about kernel
>> version but currently Linux archb 6.14.0-rt3-arch1-1-rt #1 SMP PREEMPT_R=
T
>> Wed, 21 May 2025 13:21:26 +0000 x86_64 GNU/Linux. I'm just testing rt du=
e
>> to easyeffects glitches but generally I run mainline kernel and update
>> roughly weekly so the kernel should be current for that time period)
>> eg:
>>
>> /opt/rocm_sdk_612/bin/hipcc hello_world.o -fPIE -o hello_world
>> ./hello_world
>>  System minor: 0
>>  System major: 8
>>  Agent name: AMD Radeon RX 580 Series
>> Kernel input: GdkknVnqkc
>> Expecting that kernel increases each character from input string by one
>> make: *** [Makefile:18: test] Segmentation fault (core dumped)
>>  System minor: 0
>>  System major: 8
>>  Agent name: AMD Radeon RX 580 Series
>> Kernel input: GdkknVnqkc
>> Expecting that kernel increases each character from input string by one
>> Segmentation fault (core dumped)
>>
>>
>> [New Thread 0x7fffecaea6c0 (LWP 2980691)]
>>
>> [New Thread 0x7fffe7fff6c0 (LWP 2980692)]
>>
>> [Thread 0x7fffe7fff6c0 (LWP 2980692) exited]
>>
>>  System minor: 0
>>
>>  System major: 8
>>
>>  Agent name: AMD Radeon RX 580 Series
>>
>> Kernel input: GdkknVnqkc
>>
>> Expecting that kernel increases each character from input string by one
>>
>>
>> Thread 1 "hello_world" received signal SIGSEGV, Segmentation fault.
>>
>> 0x00007ffff7db0fbd in ?? ()
>>
>>    from /opt/rocm_sdk_612/lib64/libamdhip64.so.6
>>
>> (gdb) bt
>>
>> #0  0x00007ffff7db0fbd in ?? ()
>>
>>    from /opt/rocm_sdk_612/lib64/libamdhip64.so.6
>>
>> #1  0x00007ffff7c1497f in ?? ()
>>
>>    from /opt/rocm_sdk_612/lib64/libamdhip64.so.6
>>
>> #2  0x00007ffff7c14c74 in ?? ()
>>
>>    from /opt/rocm_sdk_612/lib64/libamdhip64.so.6
>>
>> #3  0x00007ffff7c14e3e in ?? ()
>>
>>    from /opt/rocm_sdk_612/lib64/libamdhip64.so.6
>>
>> #4  0x00005555555555bf in main (argc=3D<optimized out>,
>>
>>     argv=3D<optimized out>) at hello_world.cpp:69
>>
>> (gdb)
>>
>> Line 69 (nice) is res =3D hipMemcpy(inputBuffer, input, (strlength + 1) =
*
>> sizeof(char), hipMemcpyHostToDevice); (see attached file jb_gdb_tester)
>>
>>
>>
>> https://github.com/robertrosenbusch/gfx803_rocm/issues/35
>>
>>
>> One love!!
>>
>> On Thu, 26 Jun 2025 at 10:10, Felix Kuehling <felix.kuehling@amd.com>
>> wrote:
>>
>>> I couldn't find a dmesg attched to the linked bug reports. I was going
>>> to look for a kernel oops from calling an uninitialized function pointe=
r.
>>> Your patch addresses just that.
>>>
>>> I'm not sure how =E2=80=9Cdrm/amdkfd: Improve signal event slow path=E2=
=80=9D is
>>> implicated. I don't see anything in that patch that would break
>>> specifically on gfx v803.
>>>
>>> Regards,
>>>   Felix
>>>
>>> On 2025-06-25 18:21, Alex Deucher wrote:
>>> > Adding folks from the KFD team to take a look.  Thank you for
>>> > bisecting.  Does the attached patch fix it?
>>> >
>>> > Thanks,
>>> >
>>> > Alex
>>> >
>>> > On Wed, Jun 25, 2025 at 12:33=E2=80=AFAM Johl Brown <johlbrown@gmail.=
com>
>>> wrote:
>>> >> Good Afternoon and best wishes!
>>> >> This is my first attempt at upstreaming an issue after dailying arch
>>> for a full year now :)
>>> >> Please forgive me, a lot of this is pushing my comfort zone, but
>>> preventing needless e-waste is important to me personally :) with this =
in
>>> mind, I will save your eyeballs and let you know I did use gpt to help
>>> compile the below, but I have proofread it several times (which means y=
ou
>>> can't be mad :p ).
>>> >>
>>> >>
>>> >> https://github.com/ROCm/ROCm/issues/4965
>>> >>
>>> https://github.com/robertrosenbusch/gfx803_rocm/issues/35#issuecomment-=
2996884779
>>> >>
>>> >>
>>> >> Hello Kernel, AMD GPU, & ROCm maintainers,
>>> >>
>>> >> TL;DR: My Polaris (RX-580, gfx803) freezes under compute load on a
>>> number of kernels since v6.14 and newer. This was not previously the ca=
se
>>> prior to 6.15 for ROCm 6.4.0 on gfx803 cards.
>>> >>
>>> >> The issue has been successfully mitigated within an older version of
>>> ROC under kernel 6.16rc2 by reverting two specific commits:
>>> >>
>>> >> de84484c6f8b (=E2=80=9Cdrm/amdkfd: Improve signal event slow path=E2=
=80=9D,
>>> 2024-12-19)
>>> >>
>>> >> bac38ca057fe (=E2=80=9Cdrm/amdkfd: implement per queue sdma reset fo=
r gfx
>>> 9.4+=E2=80=9D, 2025-03-06)
>>> >>
>>> >> Reverting both commits on top of v6.16-rc3 restores full stability
>>> and allows ROCm 5.7 workloads (e.g., Stable-Diffusion, faster-whisper) =
to
>>> run. Instability is usually immediately obvious via eg models failing t=
o
>>> initialise, no errors (other than host dmesg)/segfault reported, which =
is
>>> the usual failure method under previous kernels.
>>> >>
>>> >> ________________________________
>>> >>
>>> >> Problem Description
>>> >>
>>> >> A number of users report GPU hangs when initialising compute loads,
>>> specifically with ROCm 5.7+ workloads. This issue appears to be a
>>> regression, as it was not present in earlier kernel versions.
>>> >>
>>> >> System Information:
>>> >>
>>> >> OS: Arch Linux
>>> >>
>>> >> CPU: Intel(R) Core(TM) i7-7700K CPU @ 4.20GHz
>>> >>
>>> >> GPU: AMD Radeon RX 580 Series (gfx803)
>>> >>
>>> >> ROCm Version: Runtime Version: 1.1, Runtime Ext Version: 1.7 (as per
>>> rocminfo --support)
>>> >>
>>> >> ________________________________
>>> >>
>>> >> Affected Kernels and Regression Details
>>> >>
>>> >> The problem consistently occurs on v6.14.1-rc1 and newer kernels.
>>> >>
>>> >> Last known good: v6.11
>>> >>
>>> >> First known bad: v6.12
>>> >>
>>> >> The regression has been bisected to the following two commits, as
>>> reverting them resolves the issue:
>>> >>
>>> >> de84484c6f8b (=E2=80=9Cdrm/amdkfd: Improve signal event slow path=E2=
=80=9D,
>>> 2024-12-19)
>>> >>
>>> >> bac38ca057fe (=E2=80=9Cdrm/amdkfd: implement per queue sdma reset =
=E2=80=A6=E2=80=9D,
>>> 2025-03-06)
>>> >>
>>> >> Both patches touch amdkfd queue reset paths and are first included i=
n
>>> the exact releases where the regression appears.
>>> >>
>>> >> Here's a summary of kernel results:
>>> >>
>>> >> Kernel | Result | Note
>>> >>
>>> >> ------- | -------- | --------
>>> >>
>>> >> 6.13.y (LTS) | OK |
>>> >>
>>> >> 6.14.0 | OK | Baseline - my last working kernel, though I am not
>>> exactly sure which subver
>>> >>
>>> >> 6.14.1-rc1 | BAD | First hang
>>> >>
>>> >> 6.15-rc1 | BAD | Hang
>>> >>
>>> >> 6.15.8 | BAD | Hang
>>> >>
>>> >> 6.16-rc3 | BAD | Hang
>>> >>
>>> >> 6.16-rc3 =E2=80=93 revert de84484 + bac38ca | OK | Full stability re=
stored,
>>> ROCm workloads run for hours.
>>> >>
>>> >> ________________________________
>>> >>
>>> >> Reproduction Steps
>>> >>
>>> >> Boot the system with a kernel version exhibiting the issue (e.g.,
>>> v6.14.1-rc1 or newer without the reverts).
>>> >>
>>> >> Run a ROCm workload that creates several compute queues, for example=
:
>>> >>
>>> >> python stable-diffusion.py
>>> >>
>>> >> faster-whisper --model medium ...
>>> >>
>>> >> Upon model initialization, an immediate driver crash occurs. This is
>>> visible on the host machine via dmesg logs.
>>> >>
>>> >> Observed Error Messages (dmesg):
>>> >>
>>> >> [drm] scheduler comp_1.1.1 is not ready, skipping
>>> >> [drm:sched_job_timedout] ERROR ring comp_1.1.1 timeout
>>> >> [message continues ad-infinitum while system functions generally]
>>> >>
>>> >> This is followed by a hard GPU reset (visible in logs, no visual
>>> artifacts), which reliably leads to a full system lockup. Python or Doc=
ker
>>> processes become unkillable, requiring a manual reboot. Over time, the
>>> desktop slowly loses interactivity.
>>> >>
>>> >> ________________________________
>>> >>
>>> >> Bisect Details
>>> >>
>>> >> I previously attempted a git bisect (limited to drivers/gpu/drm/amd)
>>> between v6.12 and v6.15-rc1, which identified some further potentially
>>> problematic commits, however due to undersized /boot/ partition was
>>> experiencing some difficulties. In the interim, it seems a user on  the
>>> gfx803 compatibilty repo discovered the below regarding ROC 5.7:
>>> >>
>>> >> de84484c6f8b07ad0850d6c4  bad
>>> >> bac38ca057fef2c8c024fe9e  bad
>>> >>
>>> >> Cherry-picking reverts of both commits on top of v6.16-rc3 restores
>>> normal behavior; leaving either patch in place reproduces the hang.
>>> >>
>>> >> ________________________________
>>> >>
>>> >> Relevant Log Excerpts
>>> >>
>>> >> (Full dmesg logs can be attached separately if needed)
>>> >>
>>> >> [drm] scheduler comp_1.1.1 is not ready, skipping
>>> >> [ 97.602622] amdgpu 0000:08:00.0: amdgpu: ring comp_1.1.1 timeout,
>>> signaled seq=3D123456 emitted seq=3D123459
>>> >> [ 97.602630] amdgpu 0000:08:00.0: amdgpu: GPU recover succeeded,
>>> reset domain time =3D 2ms
>>> >>
>>> >> ________________________________
>>> >> References:
>>> >>
>>> >> It's back: Log spam: [drm] scheduler comp_1.0.2 is not ready,
>>> skipping ... (https://bbs.archlinux.org/viewtopic.php?id=3D302729)
>>> >>
>>> >> Observations about HSA and KFD backends in TinyGrad =C2=B7 GitHub (
>>> https://gist.github.com/fxkamd/ffd02d66a2863e444ec208ea4f3adc48)
>>> >>
>>> >> AMD RX580 system freeze on maximum VRAM speed (
>>> https://discussion.fedoraproject.org/t/amd-rx580-system-freeze-on-maxim=
um-vram-speed/136639
>>> )
>>> >>
>>> >> LKML: Linus Torvalds: Re: [git pull] drm fixes for 6.15-rc1 (
>>> https://lkml.org/lkml/2025/4/5/394)
>>> >>
>>> >> Commits =C2=B7 torvalds/linux - GitHub (Link for commit de84484) (
>>> https://github.com/torvalds/linux/commits?before=3D805ba04cb7ccfc7d72e8=
34ebd796e043142156ba+6335
>>> )
>>> >>
>>> >> Commits =C2=B7 torvalds/linux - GitHub (Link for commit bac38ca) (
>>> https://github.com/torvalds/linux/commits?before=3D5bc1018675ec28a8a60d=
83b378d8c3991faa5a27+7980
>>> )
>>> >>
>>> >> ROCm-For-RX580/README.md at main - GitHub (
>>> https://github.com/woodrex83/ROCm-For-RX580/blob/main/README.md)
>>> >>
>>> >> ROCm 4.6.0 for gfx803 - GitHub (
>>> https://github.com/robertrosenbusch/gfx803_rocm/issues/35#issuecomment-=
2996884779
>>> )
>>> >>
>>> >> Compatibility matrices =E2=80=94 Use ROCm on Radeon GPUs - AMD (
>>> https://rocm.docs.amd.com/projects/radeon/en/latest/docs/compatibility.=
html
>>> )
>>> >>
>>> >>
>>> >> ________________________________
>>> >>
>>> >> Why this matters
>>> >>
>>> >> Although gfx803 is End-of-Life (EOL) for official ROCm support, larg=
e
>>> user communities (Stable-Diffusion, Whisper, Tinygrad) still depend on =
it.
>>> Community builds (e.g., github.com/robertrosenbusch/gfx803_rocm/)
>>> demonstrate that ROCm 6.4+ and RX-580 are fully functional on a number =
of
>>> relatively recent kernels. This regression significantly impacts the
>>> usability of these cards for compute workloads.
>>> >>
>>> >> ________________________________
>>> >>
>>> >> Proposed Next Steps
>>> >>
>>> >> I suggest the following for further investigation:
>>> >>
>>> >> Review the interaction between the new KFD signal-event slow-path an=
d
>>> legacy GPUs that may lack valid event IDs.
>>> >>
>>> >> Confirm whether hqd_sdma_get_doorbell() logic (added in bac38ca)
>>> returns stale doorbells on gfx803, potentially causing false positives.
>>> >>
>>> >> Consider back-outs for 6.15-stable / 6.16-rc while a proper fix is
>>> developed.
>>> >>
>>> >> Please let me know if you require any further diagnostics or testing=
.
>>> I can easily rebuild kernels and provide annotated traces.
>>> >>
>>> >> Please find my working document:
>>> https://chatgpt.com/share/6854bef2-c69c-8002-a243-a06c67a2c066
>>> >>
>>> >> Thanks for your time!
>>> >>
>>> >> Best regards, big love,
>>> >>
>>> >> Johl Brown
>>> >>
>>> >> johlbrown@gmail.com
>>>
>>

--000000000000094cd30638e2a6d1
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>That&#39;s a GPU page fault.=C2=A0 Something in the u=
serspace command stream to the GPU accessed a non-mapped page with the GPU.=
</div><div><br></div><div>Alex</div><br><div class=3D"gmail_quote gmail_quo=
te_container"><div dir=3D"ltr" class=3D"gmail_attr">On Tue, Jul 1, 2025 at =
5:39=E2=80=AFAM Johl Brown &lt;<a href=3D"mailto:johlbrown@gmail.com">johlb=
rown@gmail.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" st=
yle=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padd=
ing-left:1ex"><div dir=3D"ltr"><h4><span style=3D"font-weight:normal">Hi al=
l, hoping I&#39;m still on-side... Thank you for your consideration.</span>=
</h4><h4><br>Linux archb 6.14.0-rt3-arch1-1-rt #1 SMP PREEMPT_RT Wed, 21 Ma=
y 2025 13:21:26 +0000 x86_64 GNU/Linux<br><br>AMDGPU sequence</h4>
<div><div><table><thead><tr><th>Time</th><th>Message</th></tr></thead><tbod=
y><tr><td>19:29:29</td><td><b>GPU fault detected</b> (<code>0x00020802</cod=
e>) for process <b>kdeconnect-app (pid 2285)</b>; VM fault at page 2048, wr=
ite from <b>TC0</b>.</td></tr><tr><td>19:29:29</td><td>Second fault (<code>=
0x0000880c</code>) for same process; VM fault at page 0, read from <b>TC6</=
b>.</td></tr><tr><td>19:29:39</td><td><b>ring gfx timeout</b> (<code>signal=
ed seq 699, emitted seq 701</code>) =E2=86=92 =E2=80=9CStarting gfx ring re=
set=E2=80=9D =E2=86=92 <b>Ring gfx reset failure</b>.</td></tr><tr><td>19:2=
9:40</td><td>Self-tests: <code>ring comp_1.0.1 test failed (-110)</code> an=
d <code>ring comp_1.2.1 test failed (-110)</code>.</td></tr></tbody></table=
></div></div><br></div><br><div class=3D"gmail_quote"><div dir=3D"ltr" clas=
s=3D"gmail_attr">On Thu, 26 Jun 2025 at 10:38, Johl Brown &lt;<a href=3D"ma=
ilto:johlbrown@gmail.com" target=3D"_blank">johlbrown@gmail.com</a>&gt; wro=
te:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px =
0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex"><div dir=3D"=
ltr"><div>Apologies, I believe it was attached to one of the above posts. P=
lease find complete dmesg attached.<br><br>I had previously attempted to GD=
B/Ghidra at ( <a href=3D"https://github.com/lamikr/rocm_sdk_builder/issues/=
173" target=3D"_blank">https://github.com/lamikr/rocm_sdk_builder/issues/17=
3</a> ) while experiencing segfaults on previous kernels/roc.<br></div><div=
>Around Nov 3, 2024 (I can&#39;t see any comment I made there about kernel =
version but currently=C2=A0Linux archb 6.14.0-rt3-arch1-1-rt #1 SMP PREEMPT=
_RT Wed, 21 May 2025 13:21:26 +0000 x86_64 GNU/Linux. I&#39;m just testing =
rt due to easyeffects glitches but generally I run mainline kernel and upda=
te roughly weekly so the kernel should be current for that time period)</di=
v>eg:=C2=A0<pre><code>/opt/rocm_sdk_612/bin/hipcc hello_world.o -fPIE -o he=
llo_world
./hello_world
 System minor: 0
 System major: 8
 Agent name: AMD Radeon RX 580 Series
Kernel input: GdkknVnqkc
Expecting that kernel increases each character from input string by one
make: *** [Makefile:18: test] Segmentation fault (core dumped)
 System minor: 0
 System major: 8
 Agent name: AMD Radeon RX 580 Series
Kernel input: GdkknVnqkc
Expecting that kernel increases each character from input string by one
Segmentation fault (core dumped)<br><br><br></code><code>[New Thread 0x7fff=
ecaea6c0 (LWP 2980691)]                            =20

[New Thread 0x7fffe7fff6c0 (LWP 2980692)]

[Thread 0x7fffe7fff6c0 (LWP 2980692) exited]

 System minor: 0

 System major: 8

 Agent name: AMD Radeon RX 580 Series

Kernel input: GdkknVnqkc

Expecting that kernel increases each character from input string by one


Thread 1 &quot;hello_world&quot; received signal SIGSEGV, Segmentation faul=
t.

0x00007ffff7db0fbd in ?? ()

   from /opt/rocm_sdk_612/lib64/libamdhip64.so.6

(gdb) bt

#0  0x00007ffff7db0fbd in ?? ()

   from /opt/rocm_sdk_612/lib64/libamdhip64.so.6

#1  0x00007ffff7c1497f in ?? ()

   from /opt/rocm_sdk_612/lib64/libamdhip64.so.6

#2  0x00007ffff7c14c74 in ?? ()

   from /opt/rocm_sdk_612/lib64/libamdhip64.so.6

#3  0x00007ffff7c14e3e in ?? ()

   from /opt/rocm_sdk_612/lib64/libamdhip64.so.6

#4  0x00005555555555bf in main (argc=3D&lt;optimized out&gt;,

    argv=3D&lt;optimized out&gt;) at hello_world.cpp:69

(gdb) <br><br></code></pre><p dir=3D"auto"><code>Line 69 (nice) is res =3D =
hipMemcpy(inputBuffer, input, (strlength + 1) * sizeof(char), hipMemcpyHost=
ToDevice); (see attached file jb_gdb_tester)</code></p><pre><br></pre><div>=
<br><a href=3D"https://github.com/robertrosenbusch/gfx803_rocm/issues/35" t=
arget=3D"_blank">https://github.com/robertrosenbusch/gfx803_rocm/issues/35<=
/a><br><br><br></div><div>One love!!</div></div><br><div class=3D"gmail_quo=
te"><div dir=3D"ltr" class=3D"gmail_attr">On Thu, 26 Jun 2025 at 10:10, Fel=
ix Kuehling &lt;<a href=3D"mailto:felix.kuehling@amd.com" target=3D"_blank"=
>felix.kuehling@amd.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_=
quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,=
204);padding-left:1ex">I couldn&#39;t find a dmesg attched to the linked bu=
g reports. I was going to look for a kernel oops from calling an uninitiali=
zed function pointer. Your patch addresses just that.<br>
<br>
I&#39;m not sure how =E2=80=9Cdrm/amdkfd: Improve signal event slow path=E2=
=80=9D is implicated. I don&#39;t see anything in that patch that would bre=
ak specifically on gfx v803.<br>
<br>
Regards,<br>
=C2=A0 Felix<br>
<br>
On 2025-06-25 18:21, Alex Deucher wrote:<br>
&gt; Adding folks from the KFD team to take a look.=C2=A0 Thank you for<br>
&gt; bisecting.=C2=A0 Does the attached patch fix it?<br>
&gt;<br>
&gt; Thanks,<br>
&gt;<br>
&gt; Alex<br>
&gt;<br>
&gt; On Wed, Jun 25, 2025 at 12:33=E2=80=AFAM Johl Brown &lt;<a href=3D"mai=
lto:johlbrown@gmail.com" target=3D"_blank">johlbrown@gmail.com</a>&gt; wrot=
e:<br>
&gt;&gt; Good Afternoon and best wishes!<br>
&gt;&gt; This is my first attempt at upstreaming an issue after dailying ar=
ch for a full year now :)<br>
&gt;&gt; Please forgive me, a lot of this is pushing my comfort zone, but p=
reventing needless e-waste is important to me personally :) with this in mi=
nd, I will save your eyeballs and let you know I did use gpt to help compil=
e the below, but I have proofread it several times (which means you can&#39=
;t be mad :p ).<br>
&gt;&gt;<br>
&gt;&gt;<br>
&gt;&gt; <a href=3D"https://github.com/ROCm/ROCm/issues/4965" rel=3D"norefe=
rrer" target=3D"_blank">https://github.com/ROCm/ROCm/issues/4965</a><br>
&gt;&gt; <a href=3D"https://github.com/robertrosenbusch/gfx803_rocm/issues/=
35#issuecomment-2996884779" rel=3D"noreferrer" target=3D"_blank">https://gi=
thub.com/robertrosenbusch/gfx803_rocm/issues/35#issuecomment-2996884779</a>=
<br>
&gt;&gt;<br>
&gt;&gt;<br>
&gt;&gt; Hello Kernel, AMD GPU, &amp; ROCm maintainers,<br>
&gt;&gt;<br>
&gt;&gt; TL;DR: My Polaris (RX-580, gfx803) freezes under compute load on a=
 number of kernels since v6.14 and newer. This was not previously the case =
prior to 6.15 for ROCm 6.4.0 on gfx803 cards.<br>
&gt;&gt;<br>
&gt;&gt; The issue has been successfully mitigated within an older version =
of ROC under kernel 6.16rc2 by reverting two specific commits:<br>
&gt;&gt;<br>
&gt;&gt; de84484c6f8b (=E2=80=9Cdrm/amdkfd: Improve signal event slow path=
=E2=80=9D, 2024-12-19)<br>
&gt;&gt;<br>
&gt;&gt; bac38ca057fe (=E2=80=9Cdrm/amdkfd: implement per queue sdma reset =
for gfx 9.4+=E2=80=9D, 2025-03-06)<br>
&gt;&gt;<br>
&gt;&gt; Reverting both commits on top of v6.16-rc3 restores full stability=
 and allows ROCm 5.7 workloads (e.g., Stable-Diffusion, faster-whisper) to =
run. Instability is usually immediately obvious via eg models failing to in=
itialise, no errors (other than host dmesg)/segfault reported, which is the=
 usual failure method under previous kernels.<br>
&gt;&gt;<br>
&gt;&gt; ________________________________<br>
&gt;&gt;<br>
&gt;&gt; Problem Description<br>
&gt;&gt;<br>
&gt;&gt; A number of users report GPU hangs when initialising compute loads=
, specifically with ROCm 5.7+ workloads. This issue appears to be a regress=
ion, as it was not present in earlier kernel versions.<br>
&gt;&gt;<br>
&gt;&gt; System Information:<br>
&gt;&gt;<br>
&gt;&gt; OS: Arch Linux<br>
&gt;&gt;<br>
&gt;&gt; CPU: Intel(R) Core(TM) i7-7700K CPU @ 4.20GHz<br>
&gt;&gt;<br>
&gt;&gt; GPU: AMD Radeon RX 580 Series (gfx803)<br>
&gt;&gt;<br>
&gt;&gt; ROCm Version: Runtime Version: 1.1, Runtime Ext Version: 1.7 (as p=
er rocminfo --support)<br>
&gt;&gt;<br>
&gt;&gt; ________________________________<br>
&gt;&gt;<br>
&gt;&gt; Affected Kernels and Regression Details<br>
&gt;&gt;<br>
&gt;&gt; The problem consistently occurs on v6.14.1-rc1 and newer kernels.<=
br>
&gt;&gt;<br>
&gt;&gt; Last known good: v6.11<br>
&gt;&gt;<br>
&gt;&gt; First known bad: v6.12<br>
&gt;&gt;<br>
&gt;&gt; The regression has been bisected to the following two commits, as =
reverting them resolves the issue:<br>
&gt;&gt;<br>
&gt;&gt; de84484c6f8b (=E2=80=9Cdrm/amdkfd: Improve signal event slow path=
=E2=80=9D, 2024-12-19)<br>
&gt;&gt;<br>
&gt;&gt; bac38ca057fe (=E2=80=9Cdrm/amdkfd: implement per queue sdma reset =
=E2=80=A6=E2=80=9D, 2025-03-06)<br>
&gt;&gt;<br>
&gt;&gt; Both patches touch amdkfd queue reset paths and are first included=
 in the exact releases where the regression appears.<br>
&gt;&gt;<br>
&gt;&gt; Here&#39;s a summary of kernel results:<br>
&gt;&gt;<br>
&gt;&gt; Kernel | Result | Note<br>
&gt;&gt;<br>
&gt;&gt; ------- | -------- | --------<br>
&gt;&gt;<br>
&gt;&gt; 6.13.y (LTS) | OK |<br>
&gt;&gt;<br>
&gt;&gt; 6.14.0 | OK | Baseline - my last working kernel, though I am not e=
xactly sure which subver<br>
&gt;&gt;<br>
&gt;&gt; 6.14.1-rc1 | BAD | First hang<br>
&gt;&gt;<br>
&gt;&gt; 6.15-rc1 | BAD | Hang<br>
&gt;&gt;<br>
&gt;&gt; 6.15.8 | BAD | Hang<br>
&gt;&gt;<br>
&gt;&gt; 6.16-rc3 | BAD | Hang<br>
&gt;&gt;<br>
&gt;&gt; 6.16-rc3 =E2=80=93 revert de84484 + bac38ca | OK | Full stability =
restored, ROCm workloads run for hours.<br>
&gt;&gt;<br>
&gt;&gt; ________________________________<br>
&gt;&gt;<br>
&gt;&gt; Reproduction Steps<br>
&gt;&gt;<br>
&gt;&gt; Boot the system with a kernel version exhibiting the issue (e.g., =
v6.14.1-rc1 or newer without the reverts).<br>
&gt;&gt;<br>
&gt;&gt; Run a ROCm workload that creates several compute queues, for examp=
le:<br>
&gt;&gt;<br>
&gt;&gt; python stable-diffusion.py<br>
&gt;&gt;<br>
&gt;&gt; faster-whisper --model medium ...<br>
&gt;&gt;<br>
&gt;&gt; Upon model initialization, an immediate driver crash occurs. This =
is visible on the host machine via dmesg logs.<br>
&gt;&gt;<br>
&gt;&gt; Observed Error Messages (dmesg):<br>
&gt;&gt;<br>
&gt;&gt; [drm] scheduler comp_1.1.1 is not ready, skipping<br>
&gt;&gt; [drm:sched_job_timedout] ERROR ring comp_1.1.1 timeout<br>
&gt;&gt; [message continues ad-infinitum while system functions generally]<=
br>
&gt;&gt;<br>
&gt;&gt; This is followed by a hard GPU reset (visible in logs, no visual a=
rtifacts), which reliably leads to a full system lockup. Python or Docker p=
rocesses become unkillable, requiring a manual reboot. Over time, the deskt=
op slowly loses interactivity.<br>
&gt;&gt;<br>
&gt;&gt; ________________________________<br>
&gt;&gt;<br>
&gt;&gt; Bisect Details<br>
&gt;&gt;<br>
&gt;&gt; I previously attempted a git bisect (limited to drivers/gpu/drm/am=
d) between v6.12 and v6.15-rc1, which identified some further potentially p=
roblematic commits, however due to undersized /boot/ partition was experien=
cing some difficulties. In the interim, it seems a user on=C2=A0 the gfx803=
 compatibilty repo discovered the below regarding ROC 5.7:<br>
&gt;&gt;<br>
&gt;&gt; de84484c6f8b07ad0850d6c4=C2=A0 bad<br>
&gt;&gt; bac38ca057fef2c8c024fe9e=C2=A0 bad<br>
&gt;&gt;<br>
&gt;&gt; Cherry-picking reverts of both commits on top of v6.16-rc3 restore=
s normal behavior; leaving either patch in place reproduces the hang.<br>
&gt;&gt;<br>
&gt;&gt; ________________________________<br>
&gt;&gt;<br>
&gt;&gt; Relevant Log Excerpts<br>
&gt;&gt;<br>
&gt;&gt; (Full dmesg logs can be attached separately if needed)<br>
&gt;&gt;<br>
&gt;&gt; [drm] scheduler comp_1.1.1 is not ready, skipping<br>
&gt;&gt; [ 97.602622] amdgpu 0000:08:00.0: amdgpu: ring comp_1.1.1 timeout,=
 signaled seq=3D123456 emitted seq=3D123459<br>
&gt;&gt; [ 97.602630] amdgpu 0000:08:00.0: amdgpu: GPU recover succeeded, r=
eset domain time =3D 2ms<br>
&gt;&gt;<br>
&gt;&gt; ________________________________<br>
&gt;&gt; References:<br>
&gt;&gt;<br>
&gt;&gt; It&#39;s back: Log spam: [drm] scheduler comp_1.0.2 is not ready, =
skipping ... (<a href=3D"https://bbs.archlinux.org/viewtopic.php?id=3D30272=
9" rel=3D"noreferrer" target=3D"_blank">https://bbs.archlinux.org/viewtopic=
.php?id=3D302729</a>)<br>
&gt;&gt;<br>
&gt;&gt; Observations about HSA and KFD backends in TinyGrad =C2=B7 GitHub =
(<a href=3D"https://gist.github.com/fxkamd/ffd02d66a2863e444ec208ea4f3adc48=
" rel=3D"noreferrer" target=3D"_blank">https://gist.github.com/fxkamd/ffd02=
d66a2863e444ec208ea4f3adc48</a>)<br>
&gt;&gt;<br>
&gt;&gt; AMD RX580 system freeze on maximum VRAM speed (<a href=3D"https://=
discussion.fedoraproject.org/t/amd-rx580-system-freeze-on-maximum-vram-spee=
d/136639" rel=3D"noreferrer" target=3D"_blank">https://discussion.fedorapro=
ject.org/t/amd-rx580-system-freeze-on-maximum-vram-speed/136639</a>)<br>
&gt;&gt;<br>
&gt;&gt; LKML: Linus Torvalds: Re: [git pull] drm fixes for 6.15-rc1 (<a hr=
ef=3D"https://lkml.org/lkml/2025/4/5/394" rel=3D"noreferrer" target=3D"_bla=
nk">https://lkml.org/lkml/2025/4/5/394</a>)<br>
&gt;&gt;<br>
&gt;&gt; Commits =C2=B7 torvalds/linux - GitHub (Link for commit de84484) (=
<a href=3D"https://github.com/torvalds/linux/commits?before=3D805ba04cb7ccf=
c7d72e834ebd796e043142156ba+6335" rel=3D"noreferrer" target=3D"_blank">http=
s://github.com/torvalds/linux/commits?before=3D805ba04cb7ccfc7d72e834ebd796=
e043142156ba+6335</a>)<br>
&gt;&gt;<br>
&gt;&gt; Commits =C2=B7 torvalds/linux - GitHub (Link for commit bac38ca) (=
<a href=3D"https://github.com/torvalds/linux/commits?before=3D5bc1018675ec2=
8a8a60d83b378d8c3991faa5a27+7980" rel=3D"noreferrer" target=3D"_blank">http=
s://github.com/torvalds/linux/commits?before=3D5bc1018675ec28a8a60d83b378d8=
c3991faa5a27+7980</a>)<br>
&gt;&gt;<br>
&gt;&gt; ROCm-For-RX580/README.md at main - GitHub (<a href=3D"https://gith=
ub.com/woodrex83/ROCm-For-RX580/blob/main/README.md" rel=3D"noreferrer" tar=
get=3D"_blank">https://github.com/woodrex83/ROCm-For-RX580/blob/main/README=
.md</a>)<br>
&gt;&gt;<br>
&gt;&gt; ROCm 4.6.0 for gfx803 - GitHub (<a href=3D"https://github.com/robe=
rtrosenbusch/gfx803_rocm/issues/35#issuecomment-2996884779" rel=3D"noreferr=
er" target=3D"_blank">https://github.com/robertrosenbusch/gfx803_rocm/issue=
s/35#issuecomment-2996884779</a>)<br>
&gt;&gt;<br>
&gt;&gt; Compatibility matrices =E2=80=94 Use ROCm on Radeon GPUs - AMD (<a=
 href=3D"https://rocm.docs.amd.com/projects/radeon/en/latest/docs/compatibi=
lity.html" rel=3D"noreferrer" target=3D"_blank">https://rocm.docs.amd.com/p=
rojects/radeon/en/latest/docs/compatibility.html</a>)<br>
&gt;&gt;<br>
&gt;&gt;<br>
&gt;&gt; ________________________________<br>
&gt;&gt;<br>
&gt;&gt; Why this matters<br>
&gt;&gt;<br>
&gt;&gt; Although gfx803 is End-of-Life (EOL) for official ROCm support, la=
rge user communities (Stable-Diffusion, Whisper, Tinygrad) still depend on =
it. Community builds (e.g., <a href=3D"http://github.com/robertrosenbusch/g=
fx803_rocm/" rel=3D"noreferrer" target=3D"_blank">github.com/robertrosenbus=
ch/gfx803_rocm/</a>) demonstrate that ROCm 6.4+ and RX-580 are fully functi=
onal on a number of relatively recent kernels. This regression significantl=
y impacts the usability of these cards for compute workloads.<br>
&gt;&gt;<br>
&gt;&gt; ________________________________<br>
&gt;&gt;<br>
&gt;&gt; Proposed Next Steps<br>
&gt;&gt;<br>
&gt;&gt; I suggest the following for further investigation:<br>
&gt;&gt;<br>
&gt;&gt; Review the interaction between the new KFD signal-event slow-path =
and legacy GPUs that may lack valid event IDs.<br>
&gt;&gt;<br>
&gt;&gt; Confirm whether hqd_sdma_get_doorbell() logic (added in bac38ca) r=
eturns stale doorbells on gfx803, potentially causing false positives.<br>
&gt;&gt;<br>
&gt;&gt; Consider back-outs for 6.15-stable / 6.16-rc while a proper fix is=
 developed.<br>
&gt;&gt;<br>
&gt;&gt; Please let me know if you require any further diagnostics or testi=
ng. I can easily rebuild kernels and provide annotated traces.<br>
&gt;&gt;<br>
&gt;&gt; Please find my working document: <a href=3D"https://chatgpt.com/sh=
are/6854bef2-c69c-8002-a243-a06c67a2c066" rel=3D"noreferrer" target=3D"_bla=
nk">https://chatgpt.com/share/6854bef2-c69c-8002-a243-a06c67a2c066</a><br>
&gt;&gt;<br>
&gt;&gt; Thanks for your time!<br>
&gt;&gt;<br>
&gt;&gt; Best regards, big love,<br>
&gt;&gt;<br>
&gt;&gt; Johl Brown<br>
&gt;&gt;<br>
&gt;&gt; <a href=3D"mailto:johlbrown@gmail.com" target=3D"_blank">johlbrown=
@gmail.com</a><br>
</blockquote></div>
</blockquote></div>
</blockquote></div></div>

--000000000000094cd30638e2a6d1--
