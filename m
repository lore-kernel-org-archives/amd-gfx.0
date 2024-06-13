Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FF6FC27C75
	for <amd-gfx@archiver.kernel.org>; Thu, 13 Jun 2024 09:28:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 40F4810E9AE;
	Thu, 13 Jun 2024 09:28:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="c41XnPCJ";
	dkim-atps=neutral
Received: from mail-oa1-f47.google.com (mail-oa1-f47.google.com
 [209.85.160.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8F89C10E0E8
 for <amd-gfx@lists.freedesktop.org>; Thu, 13 Jun 2024 00:17:53 +0000 (UTC)
Received: by mail-oa1-f47.google.com with SMTP id
 586e51a60fabf-25488f4e55aso145702fac.0
 for <amd-gfx@lists.freedesktop.org>; Wed, 12 Jun 2024 17:17:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1718237872; x=1718842672; darn=lists.freedesktop.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=lSoJWHvUA0MxBM4dBpTvlZVMaXvPJG14GngXn8bXELs=;
 b=c41XnPCJrwjUWG/GARM5Z2j1YooNqt2+FvBCfMZLDEV7gsch8z7FdiRa3jHtabw8fy
 lsg4O5ZJaNwba2aax44iQ2JRbz2tgT4Rdwib7IUXHv1i9cYRYGkYhzV35d/JciLcJ4uq
 zKHJgH26kDZKQGOxgO2U/yl3Kkjslb9XXAew8EVD684o0Su9zbyzpWembQUgKohIdXnn
 XPDFh92abD/dtAXlNUSIXGLXY3D2+c0gapeugfUvna5rJOpocgGzBQaggL/e/wJ0SA9M
 vBB+freuZhLy5qTcq/qxbEggSsIDIdPZ6eu5vznUQedQCFpRgVB7gLh29/YAI9w2ddQz
 u48A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718237872; x=1718842672;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=lSoJWHvUA0MxBM4dBpTvlZVMaXvPJG14GngXn8bXELs=;
 b=JocrwUyySmw/MoYUwn5QupYBFFNSuH3SLgkJA44Thii7wi+TUy79nAp1UkifDaSJdf
 XGnE6tKCbgkXy2d6Zbb0M6cXzAf0r6YCHTSo8uwG1DMzePJO4ohXsqnhL/8cK6tJJh2R
 yItxDZNUUobE7khctp492EpfKERke8xJ5eaSoZKVbsyXfZTmOmKepSejeSXyC+fpjqdq
 Wrr3D0mmqcMJWxoouFQsO1p52aHBg4rktrlkgXJapjoJng3M2e0dZTYx+Fud8cbG0U0w
 vwgqSj5Skgr8RgCqEw26lN5d99sAg3b2KGqRSwF788+bkjbP6BJfkqRsaJN+ojvWvb8d
 AAWA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWf5uKH5qiom0luQlRJfLPySs2rmwGymOpnhiI8Fr9xoZSS/S7KshYBTX1Jo/5EDv/GrYloNIb8x34lVXgryx9YrQvsXuRqkLfE1UJDwg==
X-Gm-Message-State: AOJu0Yz3kszLMm+ovurmWkAALRbSSCuoXp0kgar4Mpyc4ftQFtlmKDqs
 GW85/Ui8bHhkbTudTBn2V0uvPZe6teB/vh2G9c7qaqe/iUZ1muRc7OYXhfXY4HUdJJjgQaEcYpy
 1/8dGX2l2K+9leC4TDXu6w2qXhkU=
X-Google-Smtp-Source: AGHT+IGRX8ExRYc+4VZq3vs0WX0pk2sWRIZxWFzw5D7jl7PTc4pSR3MgL1g4pfBF2CyS8KVu5el5ICai4tjMv9Sw6yo=
X-Received: by 2002:a05:6870:b013:b0:250:8141:9210 with SMTP id
 586e51a60fabf-25514b35bb3mr3637876fac.9.1718237872034; Wed, 12 Jun 2024
 17:17:52 -0700 (PDT)
MIME-Version: 1.0
References: <CAMOvFfkQscju1spNKHmEC_Rut+2=qfhKGZSvGhCk_nd5VhuDkg@mail.gmail.com>
 <4ce90767-7d85-47b0-9187-4eb8d257e7e0@leemhuis.info>
 <44dc1df5f5a1b740b76d1efbf607c49f9d50dda0.camel@sjtu.edu.cn>
In-Reply-To: <44dc1df5f5a1b740b76d1efbf607c49f9d50dda0.camel@sjtu.edu.cn>
From: Winston Ma <winstonhyypia@gmail.com>
Date: Thu, 13 Jun 2024 08:17:40 +0800
Message-ID: <CAMOvFfmjOntu8amyRb8MNoDkw1x-HmrwSkgRy4_BgPy0Yfr6uw@mail.gmail.com>
Subject: Re: [bug report] drm/amdgpu: amdgpu crash on playing videos,
 linux 6.10-rc
To: mac-wang@sjtu.edu.cn, regressions@lists.linux.dev
Cc: Felix.Kuehling@amd.com, Xinhui.Pan@amd.com, alexander.deucher@amd.com, 
 amd-gfx@lists.freedesktop.org, christian.koenig@amd.com, 
 linux-kernel@vger.kernel.org
Content-Type: multipart/alternative; boundary="00000000000000a05e061aba6e71"
X-Mailman-Approved-At: Thu, 13 Jun 2024 09:28:51 +0000
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

--00000000000000a05e061aba6e71
Content-Type: text/plain; charset="UTF-8"

Hi Thorsten,


I come to kernel 6.10 because I would like to run stable diffusion on my
APU, which should related to the following commit:


Handle memory limitations on small APUs


https://lore.kernel.org/dri-devel/CAPM=9txzvSpHASKuse2VFjbdVKftTfWNtPP8Jibck6jC_n_c1Q@mail.gmail.com/


Coincidentally Yunchen and I use APU machine, so just wonder if video
playing issue happens on dedicated AMD graphic card?

On Thu, Jun 13, 2024, 12:55 AM Wang Yunchen <mac-wang@sjtu.edu.cn> wrote:

> On Wed, 2024-06-12 at 15:14 +0200, Linux regression tracking (Thorsten
> Leemhuis) wrote:
> > On 06.06.24 05:06, Winston Ma wrote:
> > > Hi I got the same problem on Linux Kernel 6.10-rc2. I got the problem
> by
> > > following the procedure below:
> > >
> > >  1. Boot Linux Kernel 6.10-rc2
> > >  2. Open Firefox (Any browser should work)
> > >  3. Open a Youtube Video
> > >  4. On the playing video, toggle fullscreen quickly Then after 10-20
> > >     times of fullscreen toggling, the screen would enter freeze mode.
> > >     This is the log that I captured using the above method.
> >
> > Hmm, seems nothing happened here for a while. Could you maybe try to
> > bisect this
> > (
> https://docs.kernel.org/admin-guide/verify-bugs-and-bisect-regressions.html
> > )?
> >
> > @amd-gfx devs: Or is this unneeded, as the cause found or maybe even
> > fixed meanwhile?
> >
> > Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
> > --
> > Everything you wanna know about Linux kernel regression tracking:
> > https://linux-regtracking.leemhuis.info/about/#tldr
> > If I did something stupid, please tell me, as explained on that page.
> >
> > #regzbot poke
> >
> > > This is the kernel log
> > >
> > > 2024-06-06T10:26:40.747576+08:00 kernel: gmc_v10_0_process_interrupt:
> 6 callbacks suppressed
> > > 2024-06-06T10:26:40.747618+08:00 kernel: amdgpu 0000:03:00.0: amdgpu:
> [mmhub] page fault (src_id:0 ring:8 vmid:2
> > > pasid:32789)
> > > 2024-06-06T10:26:40.747623+08:00 kernel: amdgpu 0000:03:00.0: amdgpu:
> in process RDD Process pid 39524 thread
> > > firefox-bi:cs0 pid 40342
> > > 2024-06-06T10:26:40.747625+08:00 kernel: amdgpu 0000:03:00.0:
> amdgpu:   in page starting at address
> > > 0x0000800106ffe000 from client 0x12 (VMC)
> > > 2024-06-06T10:26:40.747628+08:00 kernel: amdgpu 0000:03:00.0: amdgpu:
> MMVM_L2_PROTECTION_FAULT_STATUS:0x00203811
> > > 2024-06-06T10:26:40.747629+08:00 kernel: amdgpu 0000:03:00.0:
> amdgpu:        Faulty UTCL2 client ID: VCN (0x1c)
> > > 2024-06-06T10:26:40.747631+08:00 kernel: amdgpu 0000:03:00.0:
> amdgpu:        MORE_FAULTS: 0x1
> > > 2024-06-06T10:26:40.747651+08:00 kernel: amdgpu 0000:03:00.0:
> amdgpu:        WALKER_ERROR: 0x0
> > > 2024-06-06T10:26:40.747653+08:00 kernel: amdgpu 0000:03:00.0:
> amdgpu:        PERMISSION_FAULTS: 0x1
> > > 2024-06-06T10:26:40.747655+08:00 kernel: amdgpu 0000:03:00.0:
> amdgpu:        MAPPING_ERROR: 0x0
> > > 2024-06-06T10:26:40.747656+08:00 kernel: amdgpu 0000:03:00.0:
> amdgpu:        RW: 0x0
> > > 2024-06-06T10:26:40.747658+08:00 kernel: amdgpu 0000:03:00.0: amdgpu:
> [mmhub] page fault (src_id:0 ring:8 vmid:2
> > > pasid:32789)
> > > 2024-06-06T10:26:40.747660+08:00 kernel: amdgpu 0000:03:00.0: amdgpu:
> in process RDD Process pid 39524 thread
> > > firefox-bi:cs0 pid 40342
> > > 2024-06-06T10:26:40.747662+08:00 kernel: amdgpu 0000:03:00.0:
> amdgpu:   in page starting at address
> > > 0x0000800106e00000 from client 0x12 (VMC)
> > > 2024-06-06T10:26:40.747663+08:00 kernel: amdgpu 0000:03:00.0: amdgpu:
> MMVM_L2_PROTECTION_FAULT_STATUS:0x00000000
> > > 2024-06-06T10:26:40.747664+08:00 kernel: amdgpu 0000:03:00.0:
> amdgpu:        Faulty UTCL2 client ID: MP0 (0x0)
> > > 2024-06-06T10:26:40.747666+08:00 kernel: amdgpu 0000:03:00.0:
> amdgpu:        MORE_FAULTS: 0x0
> > > 2024-06-06T10:26:40.747667+08:00 kernel: amdgpu 0000:03:00.0:
> amdgpu:        WALKER_ERROR: 0x0
> > > 2024-06-06T10:26:40.747668+08:00 kernel: amdgpu 0000:03:00.0:
> amdgpu:        PERMISSION_FAULTS: 0x0
> > > 2024-06-06T10:26:40.747670+08:00 kernel: amdgpu 0000:03:00.0:
> amdgpu:        MAPPING_ERROR: 0x0
> > > 2024-06-06T10:26:40.747671+08:00 kernel: amdgpu 0000:03:00.0:
> amdgpu:        RW: 0x0
> > > 2024-06-06T10:26:40.747674+08:00 kernel: amdgpu 0000:03:00.0: amdgpu:
> [mmhub] page fault (src_id:0 ring:8 vmid:2
> > > pasid:32789)
> > > 2024-06-06T10:26:40.747677+08:00 kernel: amdgpu 0000:03:00.0: amdgpu:
> in process RDD Process pid 39524 thread
> > > firefox-bi:cs0 pid 40342
> > > 2024-06-06T10:26:40.747680+08:00 kernel: amdgpu 0000:03:00.0:
> amdgpu:   in page starting at address
> > > 0x0000800106e07000 from client 0x12 (VMC)
> > > 2024-06-06T10:26:40.747683+08:00 kernel: amdgpu 0000:03:00.0: amdgpu:
> MMVM_L2_PROTECTION_FAULT_STATUS:0x00000000
> > > 2024-06-06T10:26:40.747686+08:00 kernel: amdgpu 0000:03:00.0:
> amdgpu:        Faulty UTCL2 client ID: MP0 (0x0)
> > > 2024-06-06T10:26:40.747688+08:00 kernel: amdgpu 0000:03:00.0:
> amdgpu:        MORE_FAULTS: 0x0
> > > 2024-06-06T10:26:40.747691+08:00 kernel: amdgpu 0000:03:00.0:
> amdgpu:        WALKER_ERROR: 0x0
> > > 2024-06-06T10:26:40.747693+08:00 kernel: amdgpu 0000:03:00.0:
> amdgpu:        PERMISSION_FAULTS: 0x0
> > > 2024-06-06T10:26:40.747696+08:00 kernel: amdgpu 0000:03:00.0:
> amdgpu:        MAPPING_ERROR: 0x0
> > > 2024-06-06T10:26:40.747698+08:00 kernel: amdgpu 0000:03:00.0:
> amdgpu:        RW: 0x0
> > > 2024-06-06T10:26:40.747700+08:00 kernel: amdgpu 0000:03:00.0: amdgpu:
> [mmhub] page fault (src_id:0 ring:8 vmid:2
> > > pasid:32789)
> > > 2024-06-06T10:26:40.747703+08:00 kernel: amdgpu 0000:03:00.0: amdgpu:
> in process RDD Process pid 39524 thread
> > > firefox-bi:cs0 pid 40342
> > > 2024-06-06T10:26:40.747705+08:00 kernel: amdgpu 0000:03:00.0:
> amdgpu:   in page starting at address
> > > 0x0000800107001000 from client 0x12 (VMC)
> > > 2024-06-06T10:26:40.747707+08:00 kernel: amdgpu 0000:03:00.0: amdgpu:
> MMVM_L2_PROTECTION_FAULT_STATUS:0x00000000
> > > 2024-06-06T10:26:40.747710+08:00 kernel: amdgpu 0000:03:00.0:
> amdgpu:        Faulty UTCL2 client ID: MP0 (0x0)
> > > 2024-06-06T10:26:40.747713+08:00 kernel: amdgpu 0000:03:00.0:
> amdgpu:        MORE_FAULTS: 0x0
> > > 2024-06-06T10:26:40.747716+08:00 kernel: amdgpu 0000:03:00.0:
> amdgpu:        WALKER_ERROR: 0x0
> > > 2024-06-06T10:26:40.747718+08:00 kernel: amdgpu 0000:03:00.0:
> amdgpu:        PERMISSION_FAULTS: 0x0
> > > 2024-06-06T10:26:40.747721+08:00 kernel: amdgpu 0000:03:00.0:
> amdgpu:        MAPPING_ERROR: 0x0
> > > 2024-06-06T10:26:40.747723+08:00 kernel: amdgpu 0000:03:00.0:
> amdgpu:        RW: 0x0
> > > 2024-06-06T10:26:51.094991+08:00 kernel: [drm:amdgpu_job_timedout
> [amdgpu]] *ERROR* ring vcn_dec_0 timeout,
> > > signaled seq=24897, emitted seq=24898
> > > 2024-06-06T10:26:51.095023+08:00 kernel: [drm:amdgpu_job_timedout
> [amdgpu]] *ERROR* Process information: process
> > > RDD Process pid 39524 thread firefox-bi:cs0 pid 40342
> > > 2024-06-06T10:26:51.095025+08:00 kernel: amdgpu 0000:03:00.0: amdgpu:
> GPU reset begin!
> > > 2024-06-06T10:26:52.305509+08:00 kernel: [drm] Register(0)
> [mmUVD_POWER_STATUS] failed to reach value 0x00000001
> > > != 0x00000002n
> > > 2024-06-06T10:26:52.586019+08:00 kernel: [drm] Register(0)
> [mmUVD_RBC_RB_RPTR] failed to reach value 0x000003c0 !=
> > > 0x00000360n
> > > 2024-06-06T10:26:52.639506+08:00 kernel: [drm] Register(0)
> [mmUVD_POWER_STATUS] failed to reach value 0x00000001
> > > != 0x00000002n
> > > 2024-06-06T10:26:52.639521+08:00 kernel: amdgpu 0000:03:00.0: amdgpu:
> MODE2 reset
> > > 2024-06-06T10:26:52.650614+08:00 kernel: amdgpu 0000:03:00.0: amdgpu:
> GPU reset succeeded, trying to resume
> > > 2024-06-06T10:26:52.650633+08:00 kernel: [drm] PCIE GART of 1024M
> enabled (table at 0x000000F41FC00000).
> > > 2024-06-06T10:26:52.650637+08:00 kernel: [drm] VRAM is lost due to GPU
> reset!
> > > 2024-06-06T10:26:52.650641+08:00 kernel: amdgpu 0000:03:00.0: amdgpu:
> PSP is resuming...
> > > 2024-06-06T10:26:52.673474+08:00 kernel: amdgpu 0000:03:00.0: amdgpu:
> reserve 0xa00000 from 0xf41e000000 for PSP
> > > TMR
> > > 2024-06-06T10:26:53.001513+08:00 kernel: amdgpu 0000:03:00.0: amdgpu:
> RAS: optional ras ta ucode is not available
> > > 2024-06-06T10:26:53.013802+08:00 kernel: amdgpu 0000:03:00.0: amdgpu:
> RAP: optional rap ta ucode is not available
> > > 2024-06-06T10:26:53.013816+08:00 kernel: amdgpu 0000:03:00.0: amdgpu:
> SECUREDISPLAY: securedisplay ta ucode is not
> > > available
> > > 2024-06-06T10:26:53.013819+08:00 kernel: amdgpu 0000:03:00.0: amdgpu:
> SMU is resuming...
> > > 2024-06-06T10:26:53.016519+08:00 kernel: amdgpu 0000:03:00.0: amdgpu:
> SMU is resumed successfully!
> > > 2024-06-06T10:26:53.017502+08:00 kernel: [drm] DMUB hardware
> initialized: version=0x04000044
> > > 2024-06-06T10:26:53.677511+08:00 kernel: [drm] kiq ring mec 2 pipe 1 q
> 0
> > > 2024-06-06T10:26:53.958512+08:00 kernel: amdgpu 0000:03:00.0:
> [drm:amdgpu_ring_test_helper [amdgpu]] *ERROR* ring
> > > vcn_dec_0 test failed (-110)
> > > 2024-06-06T10:26:53.958536+08:00 kernel:
> [drm:amdgpu_device_ip_resume_phase2 [amdgpu]] *ERROR* resume of IP block
> > > <vcn_v3_0> failed -110
> > > 2024-06-06T10:26:53.958539+08:00 kernel: amdgpu 0000:03:00.0: amdgpu:
> GPU reset(1) failed
> > > 2024-06-06T10:26:53.958541+08:00 kernel: amdgpu 0000:03:00.0: amdgpu:
> GPU reset end with ret = -110
> > > 2024-06-06T10:26:53.959180+08:00 kernel: [drm:amdgpu_job_timedout
> [amdgpu]] *ERROR* GPU Recovery Failed: -110
> > > 2024-06-06T10:26:55.261509+08:00 kernel: [drm] Register(0)
> [mmUVD_POWER_STATUS] failed to reach value 0x00000001
> > > != 0x00000002n
> > > 2024-06-06T10:26:55.540507+08:00 kernel: [drm] Register(0)
> [mmUVD_RBC_RB_RPTR] failed to reach value 0x00000010 !=
> > > 0x00000000n
> > > 2024-06-06T10:27:04.407149+08:00 kernel: [drm] Register(0)
> [mmUVD_POWER_STATUS] failed to reach value 0x00000001
> > > != 0x00000002n
> > > 2024-06-06T10:27:04.407252+08:00 kernel: [drm:amdgpu_job_timedout
> [amdgpu]] *ERROR* ring vcn_dec_0 timeout,
> > > signaled seq=24898, emitted seq=24898
> > > 2024-06-06T10:27:04.407257+08:00 kernel: [drm:amdgpu_job_timedout
> [amdgpu]] *ERROR* Process information: process
> > > RDD Process pid 39524 thread firefox-bi:cs0 pid 40342
> > > 2024-06-06T10:27:04.407259+08:00 kernel: amdgpu 0000:03:00.0: amdgpu:
> GPU reset begin!
> > > 2024-06-06T10:27:05.033745+08:00 kernel: ------------[ cut here
> ]------------
> > > 2024-06-06T10:27:05.033773+08:00 kernel: WARNING: CPU: 8 PID: 47039 at
> drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c:630
> > > amdgpu_irq_put+0x9c/0xb0 [amdgpu]
> > > 2024-06-06T10:27:05.033777+08:00 kernel: Modules linked in:
> nft_reject_inet nf_reject_ipv4 nf_reject_ipv6
> > > nft_reject xt_conntrack nft_chain_nat xt_MASQUERADE nf_nat
> nf_conntrack_netlink nf_conntrack nf_defrag_ipv6
> > > nf_defrag_ipv4 xt_addrtype nft_compat nf_tables libcrc32c br_netfilter
> bridge stp llc hid_logitech_hidpp usbhid
> > > xfrm_interface xfrm6_tunnel tunnel4 tunnel6 xfrm_user xfrm_algo uhid
> rfcomm snd_seq_dummy snd_hrtimer cmac
> > > algif_hash algif_skcipher af_alg overlay qrtr bnep binfmt_misc
> uvcvideo videobuf2_vmalloc uvc videobuf2_memops
> > > videobuf2_v4l2 btusb btrtl videodev btintel btbcm snd_acp6x_pdm_dma
> snd_soc_dmic snd_soc_acp6x_mach amd_atl
> > > intel_rapl_msr btmtk videobuf2_common bluetooth mc intel_rapl_common
> snd_sof_amd_acp63 snd_sof_amd_vangogh
> > > snd_sof_amd_rembrandt iwlmvm snd_sof_amd_renoir snd_sof_amd_acp
> snd_sof_pci snd_sof_xtensa_dsp amdgpu snd_sof
> > > edac_mce_amd mac80211 snd_sof_utils snd_pci_ps snd_hda_codec_realtek
> snd_amd_sdw_acpi kvm_amd soundwire_amd
> > > snd_hda_codec_generic soundwire_generic_allocation soundwire_bus
> > > 2024-06-06T10:27:05.033782+08:00 kernel:  snd_hda_scodec_cs35l41_spi
> nls_iso8859_1 snd_hda_codec_hdmi
> > > snd_hda_scodec_component libarc4 kvm snd_soc_core snd_hda_intel
> snd_ctl_led snd_intel_dspcfg snd_compress
> > > snd_intel_sdw_acpi amdxcp snd_seq_midi ac97_bus crct10dif_pclmul
> drm_exec snd_hda_codec polyval_clmulni
> > > snd_pcm_dmaengine snd_seq_midi_event gpu_sched polyval_generic iwlwifi
> ghash_clmulni_intel snd_rpl_pci_acp6x
> > > drm_buddy sha256_ssse3 snd_hda_core snd_rawmidi snd_acp_pci
> drm_suballoc_helper snd_hda_scodec_cs35l41_i2c
> > > sha1_ssse3 drm_ttm_helper snd_acp_legacy_common snd_hwdep
> snd_hda_scodec_cs35l41 aesni_intel snd_pci_acp6x amd_pmf
> > > snd_hda_cs_dsp_ctls ttm crypto_simd snd_pci_acp5x snd_soc_cs_amp_lib
> asus_nb_wmi cs_dsp cryptd amdtee snd_seq
> > > snd_rn_pci_acp3x drm_display_helper snd_pcm asus_wmi snd_acp_config
> rapl wmi_bmof sparse_keymap snd_seq_device
> > > cfg80211 snd_soc_cs35l41_lib cec snd_soc_acpi ccp rc_core snd_timer
> i2c_algo_bit i2c_piix4 snd_pci_acp3x k10temp
> > > amd_sfh tee snd platform_profile soundcore serial_multi_instantiate
> amd_pmc acpi_tad
> > > 2024-06-06T10:27:05.033784+08:00 kernel:  joydev input_leds mac_hid
> serio_raw parport_pc ppdev lp parport
> > > efi_pstore nfnetlink dmi_sysfs ip_tables x_tables autofs4
> hid_multitouch nvme video ucsi_acpi hid_generic
> > > crc32_pclmul nvme_core typec_ucsi xhci_pci i2c_hid_acpi
> xhci_pci_renesas nvme_auth typec i2c_hid wmi hid 8250_dw
> > > 2024-06-06T10:27:05.033785+08:00 kernel: CPU: 8 PID: 47039 Comm:
> kworker/u64:0 Tainted: G        W
> > > 6.10.0-061000rc2-generic #202406022333
> > > 2024-06-06T10:27:05.033787+08:00 kernel: Hardware name: ASUSTeK
> COMPUTER INC. Zenbook UM5302TA_UM5302TA/UM5302TA,
> > > BIOS UM5302TA.311 01/17/2023
> > > 2024-06-06T10:27:05.033788+08:00 kernel: Workqueue: amdgpu-reset-dev
> drm_sched_job_timedout [gpu_sched]
> > > 2024-06-06T10:27:05.033789+08:00 kernel: RIP:
> 0010:amdgpu_irq_put+0x9c/0xb0 [amdgpu]
> > > 2024-06-06T10:27:05.033790+08:00 kernel: Code: 31 f6 31 ff e9 c0 05 2f
> e6 44 89 e2 48 89 de 4c 89 f7 e8 97 fc ff
> > > ff 5b 41 5c 41 5d 41 5e 5d 31 d2 31 f6 31 ff e9 9f 05 2f e6 <0f> 0b b8
> ea ff ff ff eb c3 b8 fe ff ff ff eb bc 0f
> > > 1f 40 00 90 90
> > > 2024-06-06T10:27:05.033791+08:00 kernel: RSP: 0018:ffffb65847227c18
> EFLAGS: 00010246
> > > 2024-06-06T10:27:05.033793+08:00 kernel: RAX: 0000000000000000 RBX:
> ffff9ac0a0280c60 RCX: 0000000000000000
> > > 2024-06-06T10:27:05.033794+08:00 kernel: RDX: 0000000000000000 RSI:
> 0000000000000000 RDI: 0000000000000000
> > > 2024-06-06T10:27:05.033796+08:00 kernel: RBP: ffffb65847227c38 R08:
> 0000000000000000 R09: 0000000000000000
> > > 2024-06-06T10:27:05.033797+08:00 kernel: R10: 0000000000000000 R11:
> 0000000000000000 R12: 0000000000000000
> > > 2024-06-06T10:27:05.033798+08:00 kernel: R13: 0000000000000001 R14:
> ffff9ac0a0280000 R15: ffff9ac0a0280000
> > > 2024-06-06T10:27:05.033799+08:00 kernel: FS:  0000000000000000(0000)
> GS:ffff9ac38e600000(0000)
> > > knlGS:0000000000000000
> > > 2024-06-06T10:27:05.033800+08:00 kernel: CS:  0010 DS: 0000 ES: 0000
> CR0: 0000000080050033
> > > 2024-06-06T10:27:05.033802+08:00 kernel: CR2: 00007d1a5edfe000 CR3:
> 000000001863c000 CR4: 0000000000f50ef0
> > > 2024-06-06T10:27:05.033803+08:00 kernel: PKRU: 55555554
> > > 2024-06-06T10:27:05.033805+08:00 kernel: Call Trace:
> > > 2024-06-06T10:27:05.033806+08:00 kernel:  <TASK>
> > > 2024-06-06T10:27:05.033807+08:00 kernel:  ? show_regs+0x6c/0x80
> > > 2024-06-06T10:27:05.033845+08:00 kernel:  ? __warn+0x88/0x140
> > > 2024-06-06T10:27:05.034598+08:00 kernel:  ? amdgpu_irq_put+0x9c/0xb0
> [amdgpu]
> > > 2024-06-06T10:27:05.034615+08:00 kernel:  ? report_bug+0x182/0x1b0
> > > 2024-06-06T10:27:05.034618+08:00 kernel:  ? handle_bug+0x51/0xa0
> > > 2024-06-06T10:27:05.034619+08:00 kernel:  ? exc_invalid_op+0x18/0x80
> > > 2024-06-06T10:27:05.034620+08:00 kernel:  ?
> asm_exc_invalid_op+0x1b/0x20
> > > 2024-06-06T10:27:05.034621+08:00 kernel:  ? amdgpu_irq_put+0x9c/0xb0
> [amdgpu]
> > > 2024-06-06T10:27:05.034623+08:00 kernel:  ? amdgpu_irq_put+0x55/0xb0
> [amdgpu]
> > > 2024-06-06T10:27:05.035573+08:00 kernel:  gmc_v10_0_hw_fini+0x67/0xe0
> [amdgpu]
> > > 2024-06-06T10:27:05.035580+08:00 kernel:  gmc_v10_0_suspend+0xe/0x20
> [amdgpu]
> > > 2024-06-06T10:27:05.035581+08:00 kernel:
> amdgpu_device_ip_suspend_phase2+0x251/0x480 [amdgpu]
> > > 2024-06-06T10:27:05.035582+08:00 kernel:
> amdgpu_device_ip_suspend+0x49/0x80 [amdgpu]
> > > 2024-06-06T10:27:05.036529+08:00 kernel:
> amdgpu_device_pre_asic_reset+0xd1/0x490 [amdgpu]
> > > 2024-06-06T10:27:05.036546+08:00 kernel:
> amdgpu_device_gpu_recover+0x406/0xa30 [amdgpu]
> > > 2024-06-06T10:27:05.036548+08:00 kernel:
> amdgpu_job_timedout+0x141/0x200 [amdgpu]
> > > 2024-06-06T10:27:05.036550+08:00 kernel:
> drm_sched_job_timedout+0x70/0x110 [gpu_sched]
> > > 2024-06-06T10:27:05.036551+08:00 kernel:  process_one_work+0x186/0x3e0
> > > 2024-06-06T10:27:05.036552+08:00 kernel:  worker_thread+0x304/0x440
> > > 2024-06-06T10:27:05.036554+08:00 kernel:  ?
> srso_alias_return_thunk+0x5/0xfbef5
> > > 2024-06-06T10:27:05.036555+08:00 kernel:  ?
> _raw_spin_lock_irqsave+0xe/0x20
> > > 2024-06-06T10:27:05.036556+08:00 kernel:  ?
> __pfx_worker_thread+0x10/0x10
> > > 2024-06-06T10:27:05.036557+08:00 kernel:  kthread+0xe4/0x110
> > > 2024-06-06T10:27:05.036558+08:00 kernel:  ? __pfx_kthread+0x10/0x10
> > > 2024-06-06T10:27:05.036559+08:00 kernel:  ret_from_fork+0x47/0x70
> > > 2024-06-06T10:27:05.036561+08:00 kernel:  ? __pfx_kthread+0x10/0x10
> > > 2024-06-06T10:27:05.036562+08:00 kernel:  ret_from_fork_asm+0x1a/0x30
> > > 2024-06-06T10:27:05.036563+08:00 kernel:  </TASK>
> > > 2024-06-06T10:27:05.036564+08:00 kernel: ---[ end trace
> 0000000000000000 ]---
> > > 2024-06-06T10:27:05.036565+08:00 kernel: amdgpu 0000:03:00.0: amdgpu:
> MODE2 reset
> > > 2024-06-06T10:27:05.046502+08:00 kernel: amdgpu 0000:03:00.0: amdgpu:
> GPU reset succeeded, trying to resume
> > > 2024-06-06T10:27:05.047516+08:00 kernel: [drm] PCIE GART of 1024M
> enabled (table at 0x000000F41FC00000).
> > > 2024-06-06T10:27:05.047533+08:00 kernel: [drm] VRAM is lost due to GPU
> reset!
> > > 2024-06-06T10:27:05.047538+08:00 kernel: amdgpu 0000:03:00.0: amdgpu:
> PSP is resuming...
> > > 2024-06-06T10:27:05.070481+08:00 kernel: amdgpu 0000:03:00.0: amdgpu:
> reserve 0xa00000 from 0xf41e000000 for PSP
> > > TMR
> > > 2024-06-06T10:27:05.397519+08:00 kernel: amdgpu 0000:03:00.0: amdgpu:
> RAS: optional ras ta ucode is not available
> > > 2024-06-06T10:27:05.409509+08:00 kernel: amdgpu 0000:03:00.0: amdgpu:
> RAP: optional rap ta ucode is not available
> > > 2024-06-06T10:27:05.409517+08:00 kernel: amdgpu 0000:03:00.0: amdgpu:
> SECUREDISPLAY: securedisplay ta ucode is not
> > > available
> > > 2024-06-06T10:27:05.409518+08:00 kernel: amdgpu 0000:03:00.0: amdgpu:
> SMU is resuming...
> > > 2024-06-06T10:27:05.411482+08:00 kernel: amdgpu 0000:03:00.0: amdgpu:
> SMU is resumed successfully!
> > > 2024-06-06T10:27:05.413504+08:00 kernel: [drm] DMUB hardware
> initialized: version=0x04000044
> > > 2024-06-06T10:27:06.055474+08:00 kernel: [drm] kiq ring mec 2 pipe 1 q
> 0
> > > 2024-06-06T10:27:06.335476+08:00 kernel: amdgpu 0000:03:00.0:
> [drm:amdgpu_ring_test_helper [amdgpu]] *ERROR* ring
> > > vcn_dec_0 test failed (-110)
> > > 2024-06-06T10:27:06.335495+08:00 kernel:
> [drm:amdgpu_device_ip_resume_phase2 [amdgpu]] *ERROR* resume of IP block
> > > <vcn_v3_0> failed -110
> > > 2024-06-06T10:27:06.335498+08:00 kernel: amdgpu 0000:03:00.0: amdgpu:
> GPU reset(2) failed
> > > 2024-06-06T10:27:06.335499+08:00 kernel: amdgpu 0000:03:00.0: amdgpu:
> GPU reset end with ret = -110
> > > 2024-06-06T10:27:06.335631+08:00 kernel: [drm:amdgpu_job_timedout
> [amdgpu]] *ERROR* GPU Recovery Failed: -110
> > >
> Hi Thorsten,
>
> It seems that the issue persists on 6.10 rc3.
>

--00000000000000a05e061aba6e71
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><p dir=3D"ltr">Hi=C2=A0Thorsten,</p><p dir=3D"ltr"><br></=
p><p dir=3D"ltr">I come to kernel 6.10 because I would like to run stable d=
iffusion on my APU, which should related to the following commit:</p><pre><=
br></pre><pre>Handle memory limitations on small APUs

</pre><p dir=3D"ltr"><a href=3D"https://lore.kernel.org/dri-devel/CAPM=3D9t=
xzvSpHASKuse2VFjbdVKftTfWNtPP8Jibck6jC_n_c1Q@mail.gmail.com/" rel=3D"norefe=
rrer noreferrer noreferrer" target=3D"_blank">https://lore.kernel.org/dri-d=
evel/CAPM=3D9txzvSpHASKuse2VFjbdVKftTfWNtPP8Jibck6jC_n_c1Q@mail.gmail.com/<=
/a><br></p><p dir=3D"ltr"><br></p><p dir=3D"ltr">Coincidentally Yunchen and=
 I use APU machine, so just wonder if video playing issue happens on dedica=
ted AMD graphic card?=C2=A0</p></div>
<br><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Thu=
, Jun 13, 2024, 12:55 AM Wang Yunchen &lt;<a href=3D"mailto:mac-wang@sjtu.e=
du.cn" rel=3D"noreferrer noreferrer noreferrer noreferrer noreferrer" targe=
t=3D"_blank">mac-wang@sjtu.edu.cn</a>&gt; wrote:<br></div><blockquote class=
=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padd=
ing-left:1ex">On Wed, 2024-06-12 at 15:14 +0200, Linux regression tracking =
(Thorsten Leemhuis) wrote:<br>
&gt; On 06.06.24 05:06, Winston Ma wrote:<br>
&gt; &gt; Hi I got the same problem on Linux Kernel 6.10-rc2. I got the pro=
blem by<br>
&gt; &gt; following the procedure below:<br>
&gt; &gt; <br>
&gt; &gt; =C2=A01. Boot Linux Kernel 6.10-rc2<br>
&gt; &gt; =C2=A02. Open Firefox (Any browser should work)<br>
&gt; &gt; =C2=A03. Open a Youtube Video<br>
&gt; &gt; =C2=A04. On the playing video, toggle fullscreen quickly Then aft=
er 10-20<br>
&gt; &gt; =C2=A0=C2=A0=C2=A0 times of fullscreen toggling, the screen would=
 enter freeze mode.<br>
&gt; &gt; =C2=A0=C2=A0=C2=A0 This is the log that I captured using the abov=
e method.<br>
&gt; <br>
&gt; Hmm, seems nothing happened here for a while. Could you maybe try to<b=
r>
&gt; bisect this<br>
&gt; (<a href=3D"https://docs.kernel.org/admin-guide/verify-bugs-and-bisect=
-regressions.html" rel=3D"noreferrer noreferrer noreferrer noreferrer noref=
errer noreferrer noreferrer" target=3D"_blank">https://docs.kernel.org/admi=
n-guide/verify-bugs-and-bisect-regressions.html</a><br>
&gt; )?<br>
&gt; <br>
&gt; @amd-gfx devs: Or is this unneeded, as the cause found or maybe even<b=
r>
&gt; fixed meanwhile?<br>
&gt; <br>
&gt; Ciao, Thorsten (wearing his &#39;the Linux kernel&#39;s regression tra=
cker&#39; hat)<br>
&gt; --<br>
&gt; Everything you wanna know about Linux kernel regression tracking:<br>
&gt; <a href=3D"https://linux-regtracking.leemhuis.info/about/#tldr" rel=3D=
"noreferrer noreferrer noreferrer noreferrer noreferrer noreferrer noreferr=
er" target=3D"_blank">https://linux-regtracking.leemhuis.info/about/#tldr</=
a><br>
&gt; If I did something stupid, please tell me, as explained on that page.<=
br>
&gt; <br>
&gt; #regzbot poke<br>
&gt; <br>
&gt; &gt; This is the kernel log<br>
&gt; &gt; <br>
&gt; &gt; 2024-06-06T10:26:40.747576+08:00 kernel: gmc_v10_0_process_interr=
upt: 6 callbacks suppressed<br>
&gt; &gt; 2024-06-06T10:26:40.747618+08:00 kernel: amdgpu 0000:03:00.0: amd=
gpu: [mmhub] page fault (src_id:0 ring:8 vmid:2<br>
&gt; &gt; pasid:32789)<br>
&gt; &gt; 2024-06-06T10:26:40.747623+08:00 kernel: amdgpu 0000:03:00.0: amd=
gpu:=C2=A0 in process RDD Process pid 39524 thread<br>
&gt; &gt; firefox-bi:cs0 pid 40342<br>
&gt; &gt; 2024-06-06T10:26:40.747625+08:00 kernel: amdgpu 0000:03:00.0: amd=
gpu:=C2=A0=C2=A0 in page starting at address<br>
&gt; &gt; 0x0000800106ffe000 from client 0x12 (VMC)<br>
&gt; &gt; 2024-06-06T10:26:40.747628+08:00 kernel: amdgpu 0000:03:00.0: amd=
gpu: MMVM_L2_PROTECTION_FAULT_STATUS:0x00203811<br>
&gt; &gt; 2024-06-06T10:26:40.747629+08:00 kernel: amdgpu 0000:03:00.0: amd=
gpu:=C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0Faulty UTCL2 client ID: VCN (0x1c)<br>
&gt; &gt; 2024-06-06T10:26:40.747631+08:00 kernel: amdgpu 0000:03:00.0: amd=
gpu:=C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0MORE_FAULTS: 0x1<br>
&gt; &gt; 2024-06-06T10:26:40.747651+08:00 kernel: amdgpu 0000:03:00.0: amd=
gpu:=C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0WALKER_ERROR: 0x0<br>
&gt; &gt; 2024-06-06T10:26:40.747653+08:00 kernel: amdgpu 0000:03:00.0: amd=
gpu:=C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0PERMISSION_FAULTS: 0x1<br>
&gt; &gt; 2024-06-06T10:26:40.747655+08:00 kernel: amdgpu 0000:03:00.0: amd=
gpu:=C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0MAPPING_ERROR: 0x0<br>
&gt; &gt; 2024-06-06T10:26:40.747656+08:00 kernel: amdgpu 0000:03:00.0: amd=
gpu:=C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0RW: 0x0<br>
&gt; &gt; 2024-06-06T10:26:40.747658+08:00 kernel: amdgpu 0000:03:00.0: amd=
gpu: [mmhub] page fault (src_id:0 ring:8 vmid:2<br>
&gt; &gt; pasid:32789)<br>
&gt; &gt; 2024-06-06T10:26:40.747660+08:00 kernel: amdgpu 0000:03:00.0: amd=
gpu:=C2=A0 in process RDD Process pid 39524 thread<br>
&gt; &gt; firefox-bi:cs0 pid 40342<br>
&gt; &gt; 2024-06-06T10:26:40.747662+08:00 kernel: amdgpu 0000:03:00.0: amd=
gpu:=C2=A0=C2=A0 in page starting at address<br>
&gt; &gt; 0x0000800106e00000 from client 0x12 (VMC)<br>
&gt; &gt; 2024-06-06T10:26:40.747663+08:00 kernel: amdgpu 0000:03:00.0: amd=
gpu: MMVM_L2_PROTECTION_FAULT_STATUS:0x00000000<br>
&gt; &gt; 2024-06-06T10:26:40.747664+08:00 kernel: amdgpu 0000:03:00.0: amd=
gpu:=C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0Faulty UTCL2 client ID: MP0 (0x0)<br>
&gt; &gt; 2024-06-06T10:26:40.747666+08:00 kernel: amdgpu 0000:03:00.0: amd=
gpu:=C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0MORE_FAULTS: 0x0<br>
&gt; &gt; 2024-06-06T10:26:40.747667+08:00 kernel: amdgpu 0000:03:00.0: amd=
gpu:=C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0WALKER_ERROR: 0x0<br>
&gt; &gt; 2024-06-06T10:26:40.747668+08:00 kernel: amdgpu 0000:03:00.0: amd=
gpu:=C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0PERMISSION_FAULTS: 0x0<br>
&gt; &gt; 2024-06-06T10:26:40.747670+08:00 kernel: amdgpu 0000:03:00.0: amd=
gpu:=C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0MAPPING_ERROR: 0x0<br>
&gt; &gt; 2024-06-06T10:26:40.747671+08:00 kernel: amdgpu 0000:03:00.0: amd=
gpu:=C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0RW: 0x0<br>
&gt; &gt; 2024-06-06T10:26:40.747674+08:00 kernel: amdgpu 0000:03:00.0: amd=
gpu: [mmhub] page fault (src_id:0 ring:8 vmid:2<br>
&gt; &gt; pasid:32789)<br>
&gt; &gt; 2024-06-06T10:26:40.747677+08:00 kernel: amdgpu 0000:03:00.0: amd=
gpu:=C2=A0 in process RDD Process pid 39524 thread<br>
&gt; &gt; firefox-bi:cs0 pid 40342<br>
&gt; &gt; 2024-06-06T10:26:40.747680+08:00 kernel: amdgpu 0000:03:00.0: amd=
gpu:=C2=A0=C2=A0 in page starting at address<br>
&gt; &gt; 0x0000800106e07000 from client 0x12 (VMC)<br>
&gt; &gt; 2024-06-06T10:26:40.747683+08:00 kernel: amdgpu 0000:03:00.0: amd=
gpu: MMVM_L2_PROTECTION_FAULT_STATUS:0x00000000<br>
&gt; &gt; 2024-06-06T10:26:40.747686+08:00 kernel: amdgpu 0000:03:00.0: amd=
gpu:=C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0Faulty UTCL2 client ID: MP0 (0x0)<br>
&gt; &gt; 2024-06-06T10:26:40.747688+08:00 kernel: amdgpu 0000:03:00.0: amd=
gpu:=C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0MORE_FAULTS: 0x0<br>
&gt; &gt; 2024-06-06T10:26:40.747691+08:00 kernel: amdgpu 0000:03:00.0: amd=
gpu:=C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0WALKER_ERROR: 0x0<br>
&gt; &gt; 2024-06-06T10:26:40.747693+08:00 kernel: amdgpu 0000:03:00.0: amd=
gpu:=C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0PERMISSION_FAULTS: 0x0<br>
&gt; &gt; 2024-06-06T10:26:40.747696+08:00 kernel: amdgpu 0000:03:00.0: amd=
gpu:=C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0MAPPING_ERROR: 0x0<br>
&gt; &gt; 2024-06-06T10:26:40.747698+08:00 kernel: amdgpu 0000:03:00.0: amd=
gpu:=C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0RW: 0x0<br>
&gt; &gt; 2024-06-06T10:26:40.747700+08:00 kernel: amdgpu 0000:03:00.0: amd=
gpu: [mmhub] page fault (src_id:0 ring:8 vmid:2<br>
&gt; &gt; pasid:32789)<br>
&gt; &gt; 2024-06-06T10:26:40.747703+08:00 kernel: amdgpu 0000:03:00.0: amd=
gpu:=C2=A0 in process RDD Process pid 39524 thread<br>
&gt; &gt; firefox-bi:cs0 pid 40342<br>
&gt; &gt; 2024-06-06T10:26:40.747705+08:00 kernel: amdgpu 0000:03:00.0: amd=
gpu:=C2=A0=C2=A0 in page starting at address<br>
&gt; &gt; 0x0000800107001000 from client 0x12 (VMC)<br>
&gt; &gt; 2024-06-06T10:26:40.747707+08:00 kernel: amdgpu 0000:03:00.0: amd=
gpu: MMVM_L2_PROTECTION_FAULT_STATUS:0x00000000<br>
&gt; &gt; 2024-06-06T10:26:40.747710+08:00 kernel: amdgpu 0000:03:00.0: amd=
gpu:=C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0Faulty UTCL2 client ID: MP0 (0x0)<br>
&gt; &gt; 2024-06-06T10:26:40.747713+08:00 kernel: amdgpu 0000:03:00.0: amd=
gpu:=C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0MORE_FAULTS: 0x0<br>
&gt; &gt; 2024-06-06T10:26:40.747716+08:00 kernel: amdgpu 0000:03:00.0: amd=
gpu:=C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0WALKER_ERROR: 0x0<br>
&gt; &gt; 2024-06-06T10:26:40.747718+08:00 kernel: amdgpu 0000:03:00.0: amd=
gpu:=C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0PERMISSION_FAULTS: 0x0<br>
&gt; &gt; 2024-06-06T10:26:40.747721+08:00 kernel: amdgpu 0000:03:00.0: amd=
gpu:=C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0MAPPING_ERROR: 0x0<br>
&gt; &gt; 2024-06-06T10:26:40.747723+08:00 kernel: amdgpu 0000:03:00.0: amd=
gpu:=C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0RW: 0x0<br>
&gt; &gt; 2024-06-06T10:26:51.094991+08:00 kernel: [drm:amdgpu_job_timedout=
 [amdgpu]] *ERROR* ring vcn_dec_0 timeout,<br>
&gt; &gt; signaled seq=3D24897, emitted seq=3D24898<br>
&gt; &gt; 2024-06-06T10:26:51.095023+08:00 kernel: [drm:amdgpu_job_timedout=
 [amdgpu]] *ERROR* Process information: process<br>
&gt; &gt; RDD Process pid 39524 thread firefox-bi:cs0 pid 40342<br>
&gt; &gt; 2024-06-06T10:26:51.095025+08:00 kernel: amdgpu 0000:03:00.0: amd=
gpu: GPU reset begin!<br>
&gt; &gt; 2024-06-06T10:26:52.305509+08:00 kernel: [drm] Register(0) [mmUVD=
_POWER_STATUS] failed to reach value 0x00000001<br>
&gt; &gt; !=3D 0x00000002n<br>
&gt; &gt; 2024-06-06T10:26:52.586019+08:00 kernel: [drm] Register(0) [mmUVD=
_RBC_RB_RPTR] failed to reach value 0x000003c0 !=3D<br>
&gt; &gt; 0x00000360n<br>
&gt; &gt; 2024-06-06T10:26:52.639506+08:00 kernel: [drm] Register(0) [mmUVD=
_POWER_STATUS] failed to reach value 0x00000001<br>
&gt; &gt; !=3D 0x00000002n<br>
&gt; &gt; 2024-06-06T10:26:52.639521+08:00 kernel: amdgpu 0000:03:00.0: amd=
gpu: MODE2 reset<br>
&gt; &gt; 2024-06-06T10:26:52.650614+08:00 kernel: amdgpu 0000:03:00.0: amd=
gpu: GPU reset succeeded, trying to resume<br>
&gt; &gt; 2024-06-06T10:26:52.650633+08:00 kernel: [drm] PCIE GART of 1024M=
 enabled (table at 0x000000F41FC00000).<br>
&gt; &gt; 2024-06-06T10:26:52.650637+08:00 kernel: [drm] VRAM is lost due t=
o GPU reset!<br>
&gt; &gt; 2024-06-06T10:26:52.650641+08:00 kernel: amdgpu 0000:03:00.0: amd=
gpu: PSP is resuming...<br>
&gt; &gt; 2024-06-06T10:26:52.673474+08:00 kernel: amdgpu 0000:03:00.0: amd=
gpu: reserve 0xa00000 from 0xf41e000000 for PSP<br>
&gt; &gt; TMR<br>
&gt; &gt; 2024-06-06T10:26:53.001513+08:00 kernel: amdgpu 0000:03:00.0: amd=
gpu: RAS: optional ras ta ucode is not available<br>
&gt; &gt; 2024-06-06T10:26:53.013802+08:00 kernel: amdgpu 0000:03:00.0: amd=
gpu: RAP: optional rap ta ucode is not available<br>
&gt; &gt; 2024-06-06T10:26:53.013816+08:00 kernel: amdgpu 0000:03:00.0: amd=
gpu: SECUREDISPLAY: securedisplay ta ucode is not<br>
&gt; &gt; available<br>
&gt; &gt; 2024-06-06T10:26:53.013819+08:00 kernel: amdgpu 0000:03:00.0: amd=
gpu: SMU is resuming...<br>
&gt; &gt; 2024-06-06T10:26:53.016519+08:00 kernel: amdgpu 0000:03:00.0: amd=
gpu: SMU is resumed successfully!<br>
&gt; &gt; 2024-06-06T10:26:53.017502+08:00 kernel: [drm] DMUB hardware init=
ialized: version=3D0x04000044<br>
&gt; &gt; 2024-06-06T10:26:53.677511+08:00 kernel: [drm] kiq ring mec 2 pip=
e 1 q 0<br>
&gt; &gt; 2024-06-06T10:26:53.958512+08:00 kernel: amdgpu 0000:03:00.0: [dr=
m:amdgpu_ring_test_helper [amdgpu]] *ERROR* ring<br>
&gt; &gt; vcn_dec_0 test failed (-110)<br>
&gt; &gt; 2024-06-06T10:26:53.958536+08:00 kernel: [drm:amdgpu_device_ip_re=
sume_phase2 [amdgpu]] *ERROR* resume of IP block<br>
&gt; &gt; &lt;vcn_v3_0&gt; failed -110<br>
&gt; &gt; 2024-06-06T10:26:53.958539+08:00 kernel: amdgpu 0000:03:00.0: amd=
gpu: GPU reset(1) failed<br>
&gt; &gt; 2024-06-06T10:26:53.958541+08:00 kernel: amdgpu 0000:03:00.0: amd=
gpu: GPU reset end with ret =3D -110<br>
&gt; &gt; 2024-06-06T10:26:53.959180+08:00 kernel: [drm:amdgpu_job_timedout=
 [amdgpu]] *ERROR* GPU Recovery Failed: -110<br>
&gt; &gt; 2024-06-06T10:26:55.261509+08:00 kernel: [drm] Register(0) [mmUVD=
_POWER_STATUS] failed to reach value 0x00000001<br>
&gt; &gt; !=3D 0x00000002n<br>
&gt; &gt; 2024-06-06T10:26:55.540507+08:00 kernel: [drm] Register(0) [mmUVD=
_RBC_RB_RPTR] failed to reach value 0x00000010 !=3D<br>
&gt; &gt; 0x00000000n<br>
&gt; &gt; 2024-06-06T10:27:04.407149+08:00 kernel: [drm] Register(0) [mmUVD=
_POWER_STATUS] failed to reach value 0x00000001<br>
&gt; &gt; !=3D 0x00000002n<br>
&gt; &gt; 2024-06-06T10:27:04.407252+08:00 kernel: [drm:amdgpu_job_timedout=
 [amdgpu]] *ERROR* ring vcn_dec_0 timeout,<br>
&gt; &gt; signaled seq=3D24898, emitted seq=3D24898<br>
&gt; &gt; 2024-06-06T10:27:04.407257+08:00 kernel: [drm:amdgpu_job_timedout=
 [amdgpu]] *ERROR* Process information: process<br>
&gt; &gt; RDD Process pid 39524 thread firefox-bi:cs0 pid 40342<br>
&gt; &gt; 2024-06-06T10:27:04.407259+08:00 kernel: amdgpu 0000:03:00.0: amd=
gpu: GPU reset begin!<br>
&gt; &gt; 2024-06-06T10:27:05.033745+08:00 kernel: ------------[ cut here ]=
------------<br>
&gt; &gt; 2024-06-06T10:27:05.033773+08:00 kernel: WARNING: CPU: 8 PID: 470=
39 at drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c:630<br>
&gt; &gt; amdgpu_irq_put+0x9c/0xb0 [amdgpu]<br>
&gt; &gt; 2024-06-06T10:27:05.033777+08:00 kernel: Modules linked in: nft_r=
eject_inet nf_reject_ipv4 nf_reject_ipv6<br>
&gt; &gt; nft_reject xt_conntrack nft_chain_nat xt_MASQUERADE nf_nat nf_con=
ntrack_netlink nf_conntrack nf_defrag_ipv6<br>
&gt; &gt; nf_defrag_ipv4 xt_addrtype nft_compat nf_tables libcrc32c br_netf=
ilter bridge stp llc hid_logitech_hidpp usbhid<br>
&gt; &gt; xfrm_interface xfrm6_tunnel tunnel4 tunnel6 xfrm_user xfrm_algo u=
hid rfcomm snd_seq_dummy snd_hrtimer cmac<br>
&gt; &gt; algif_hash algif_skcipher af_alg overlay qrtr bnep binfmt_misc uv=
cvideo videobuf2_vmalloc uvc videobuf2_memops<br>
&gt; &gt; videobuf2_v4l2 btusb btrtl videodev btintel btbcm snd_acp6x_pdm_d=
ma snd_soc_dmic snd_soc_acp6x_mach amd_atl<br>
&gt; &gt; intel_rapl_msr btmtk videobuf2_common bluetooth mc intel_rapl_com=
mon snd_sof_amd_acp63 snd_sof_amd_vangogh<br>
&gt; &gt; snd_sof_amd_rembrandt iwlmvm snd_sof_amd_renoir snd_sof_amd_acp s=
nd_sof_pci snd_sof_xtensa_dsp amdgpu snd_sof<br>
&gt; &gt; edac_mce_amd mac80211 snd_sof_utils snd_pci_ps snd_hda_codec_real=
tek snd_amd_sdw_acpi kvm_amd soundwire_amd<br>
&gt; &gt; snd_hda_codec_generic soundwire_generic_allocation soundwire_bus<=
br>
&gt; &gt; 2024-06-06T10:27:05.033782+08:00 kernel:=C2=A0 snd_hda_scodec_cs3=
5l41_spi nls_iso8859_1 snd_hda_codec_hdmi<br>
&gt; &gt; snd_hda_scodec_component libarc4 kvm snd_soc_core snd_hda_intel s=
nd_ctl_led snd_intel_dspcfg snd_compress<br>
&gt; &gt; snd_intel_sdw_acpi amdxcp snd_seq_midi ac97_bus crct10dif_pclmul =
drm_exec snd_hda_codec polyval_clmulni<br>
&gt; &gt; snd_pcm_dmaengine snd_seq_midi_event gpu_sched polyval_generic iw=
lwifi ghash_clmulni_intel snd_rpl_pci_acp6x<br>
&gt; &gt; drm_buddy sha256_ssse3 snd_hda_core snd_rawmidi snd_acp_pci drm_s=
uballoc_helper snd_hda_scodec_cs35l41_i2c<br>
&gt; &gt; sha1_ssse3 drm_ttm_helper snd_acp_legacy_common snd_hwdep snd_hda=
_scodec_cs35l41 aesni_intel snd_pci_acp6x amd_pmf<br>
&gt; &gt; snd_hda_cs_dsp_ctls ttm crypto_simd snd_pci_acp5x snd_soc_cs_amp_=
lib asus_nb_wmi cs_dsp cryptd amdtee snd_seq<br>
&gt; &gt; snd_rn_pci_acp3x drm_display_helper snd_pcm asus_wmi snd_acp_conf=
ig rapl wmi_bmof sparse_keymap snd_seq_device<br>
&gt; &gt; cfg80211 snd_soc_cs35l41_lib cec snd_soc_acpi ccp rc_core snd_tim=
er i2c_algo_bit i2c_piix4 snd_pci_acp3x k10temp<br>
&gt; &gt; amd_sfh tee snd platform_profile soundcore serial_multi_instantia=
te amd_pmc acpi_tad<br>
&gt; &gt; 2024-06-06T10:27:05.033784+08:00 kernel:=C2=A0 joydev input_leds =
mac_hid serio_raw parport_pc ppdev lp parport<br>
&gt; &gt; efi_pstore nfnetlink dmi_sysfs ip_tables x_tables autofs4 hid_mul=
titouch nvme video ucsi_acpi hid_generic<br>
&gt; &gt; crc32_pclmul nvme_core typec_ucsi xhci_pci i2c_hid_acpi xhci_pci_=
renesas nvme_auth typec i2c_hid wmi hid 8250_dw<br>
&gt; &gt; 2024-06-06T10:27:05.033785+08:00 kernel: CPU: 8 PID: 47039 Comm: =
kworker/u64:0 Tainted: G=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 W=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0<br>
&gt; &gt; 6.10.0-061000rc2-generic #202406022333<br>
&gt; &gt; 2024-06-06T10:27:05.033787+08:00 kernel: Hardware name: ASUSTeK C=
OMPUTER INC. Zenbook UM5302TA_UM5302TA/UM5302TA,<br>
&gt; &gt; BIOS UM5302TA.311 01/17/2023<br>
&gt; &gt; 2024-06-06T10:27:05.033788+08:00 kernel: Workqueue: amdgpu-reset-=
dev drm_sched_job_timedout [gpu_sched]<br>
&gt; &gt; 2024-06-06T10:27:05.033789+08:00 kernel: RIP: 0010:amdgpu_irq_put=
+0x9c/0xb0 [amdgpu]<br>
&gt; &gt; 2024-06-06T10:27:05.033790+08:00 kernel: Code: 31 f6 31 ff e9 c0 =
05 2f e6 44 89 e2 48 89 de 4c 89 f7 e8 97 fc ff<br>
&gt; &gt; ff 5b 41 5c 41 5d 41 5e 5d 31 d2 31 f6 31 ff e9 9f 05 2f e6 &lt;0=
f&gt; 0b b8 ea ff ff ff eb c3 b8 fe ff ff ff eb bc 0f<br>
&gt; &gt; 1f 40 00 90 90<br>
&gt; &gt; 2024-06-06T10:27:05.033791+08:00 kernel: RSP: 0018:ffffb65847227c=
18 EFLAGS: 00010246<br>
&gt; &gt; 2024-06-06T10:27:05.033793+08:00 kernel: RAX: 0000000000000000 RB=
X: ffff9ac0a0280c60 RCX: 0000000000000000<br>
&gt; &gt; 2024-06-06T10:27:05.033794+08:00 kernel: RDX: 0000000000000000 RS=
I: 0000000000000000 RDI: 0000000000000000<br>
&gt; &gt; 2024-06-06T10:27:05.033796+08:00 kernel: RBP: ffffb65847227c38 R0=
8: 0000000000000000 R09: 0000000000000000<br>
&gt; &gt; 2024-06-06T10:27:05.033797+08:00 kernel: R10: 0000000000000000 R1=
1: 0000000000000000 R12: 0000000000000000<br>
&gt; &gt; 2024-06-06T10:27:05.033798+08:00 kernel: R13: 0000000000000001 R1=
4: ffff9ac0a0280000 R15: ffff9ac0a0280000<br>
&gt; &gt; 2024-06-06T10:27:05.033799+08:00 kernel: FS:=C2=A0 00000000000000=
00(0000) GS:ffff9ac38e600000(0000)<br>
&gt; &gt; knlGS:0000000000000000<br>
&gt; &gt; 2024-06-06T10:27:05.033800+08:00 kernel: CS:=C2=A0 0010 DS: 0000 =
ES: 0000 CR0: 0000000080050033<br>
&gt; &gt; 2024-06-06T10:27:05.033802+08:00 kernel: CR2: 00007d1a5edfe000 CR=
3: 000000001863c000 CR4: 0000000000f50ef0<br>
&gt; &gt; 2024-06-06T10:27:05.033803+08:00 kernel: PKRU: 55555554<br>
&gt; &gt; 2024-06-06T10:27:05.033805+08:00 kernel: Call Trace:<br>
&gt; &gt; 2024-06-06T10:27:05.033806+08:00 kernel:=C2=A0 &lt;TASK&gt;<br>
&gt; &gt; 2024-06-06T10:27:05.033807+08:00 kernel:=C2=A0 ? show_regs+0x6c/0=
x80<br>
&gt; &gt; 2024-06-06T10:27:05.033845+08:00 kernel:=C2=A0 ? __warn+0x88/0x14=
0<br>
&gt; &gt; 2024-06-06T10:27:05.034598+08:00 kernel:=C2=A0 ? amdgpu_irq_put+0=
x9c/0xb0 [amdgpu]<br>
&gt; &gt; 2024-06-06T10:27:05.034615+08:00 kernel:=C2=A0 ? report_bug+0x182=
/0x1b0<br>
&gt; &gt; 2024-06-06T10:27:05.034618+08:00 kernel:=C2=A0 ? handle_bug+0x51/=
0xa0<br>
&gt; &gt; 2024-06-06T10:27:05.034619+08:00 kernel:=C2=A0 ? exc_invalid_op+0=
x18/0x80<br>
&gt; &gt; 2024-06-06T10:27:05.034620+08:00 kernel:=C2=A0 ? asm_exc_invalid_=
op+0x1b/0x20<br>
&gt; &gt; 2024-06-06T10:27:05.034621+08:00 kernel:=C2=A0 ? amdgpu_irq_put+0=
x9c/0xb0 [amdgpu]<br>
&gt; &gt; 2024-06-06T10:27:05.034623+08:00 kernel:=C2=A0 ? amdgpu_irq_put+0=
x55/0xb0 [amdgpu]<br>
&gt; &gt; 2024-06-06T10:27:05.035573+08:00 kernel:=C2=A0 gmc_v10_0_hw_fini+=
0x67/0xe0 [amdgpu]<br>
&gt; &gt; 2024-06-06T10:27:05.035580+08:00 kernel:=C2=A0 gmc_v10_0_suspend+=
0xe/0x20 [amdgpu]<br>
&gt; &gt; 2024-06-06T10:27:05.035581+08:00 kernel:=C2=A0 amdgpu_device_ip_s=
uspend_phase2+0x251/0x480 [amdgpu]<br>
&gt; &gt; 2024-06-06T10:27:05.035582+08:00 kernel:=C2=A0 amdgpu_device_ip_s=
uspend+0x49/0x80 [amdgpu]<br>
&gt; &gt; 2024-06-06T10:27:05.036529+08:00 kernel:=C2=A0 amdgpu_device_pre_=
asic_reset+0xd1/0x490 [amdgpu]<br>
&gt; &gt; 2024-06-06T10:27:05.036546+08:00 kernel:=C2=A0 amdgpu_device_gpu_=
recover+0x406/0xa30 [amdgpu]<br>
&gt; &gt; 2024-06-06T10:27:05.036548+08:00 kernel:=C2=A0 amdgpu_job_timedou=
t+0x141/0x200 [amdgpu]<br>
&gt; &gt; 2024-06-06T10:27:05.036550+08:00 kernel:=C2=A0 drm_sched_job_time=
dout+0x70/0x110 [gpu_sched]<br>
&gt; &gt; 2024-06-06T10:27:05.036551+08:00 kernel:=C2=A0 process_one_work+0=
x186/0x3e0<br>
&gt; &gt; 2024-06-06T10:27:05.036552+08:00 kernel:=C2=A0 worker_thread+0x30=
4/0x440<br>
&gt; &gt; 2024-06-06T10:27:05.036554+08:00 kernel:=C2=A0 ? srso_alias_retur=
n_thunk+0x5/0xfbef5<br>
&gt; &gt; 2024-06-06T10:27:05.036555+08:00 kernel:=C2=A0 ? _raw_spin_lock_i=
rqsave+0xe/0x20<br>
&gt; &gt; 2024-06-06T10:27:05.036556+08:00 kernel:=C2=A0 ? __pfx_worker_thr=
ead+0x10/0x10<br>
&gt; &gt; 2024-06-06T10:27:05.036557+08:00 kernel:=C2=A0 kthread+0xe4/0x110=
<br>
&gt; &gt; 2024-06-06T10:27:05.036558+08:00 kernel:=C2=A0 ? __pfx_kthread+0x=
10/0x10<br>
&gt; &gt; 2024-06-06T10:27:05.036559+08:00 kernel:=C2=A0 ret_from_fork+0x47=
/0x70<br>
&gt; &gt; 2024-06-06T10:27:05.036561+08:00 kernel:=C2=A0 ? __pfx_kthread+0x=
10/0x10<br>
&gt; &gt; 2024-06-06T10:27:05.036562+08:00 kernel:=C2=A0 ret_from_fork_asm+=
0x1a/0x30<br>
&gt; &gt; 2024-06-06T10:27:05.036563+08:00 kernel:=C2=A0 &lt;/TASK&gt;<br>
&gt; &gt; 2024-06-06T10:27:05.036564+08:00 kernel: ---[ end trace 000000000=
0000000 ]---<br>
&gt; &gt; 2024-06-06T10:27:05.036565+08:00 kernel: amdgpu 0000:03:00.0: amd=
gpu: MODE2 reset<br>
&gt; &gt; 2024-06-06T10:27:05.046502+08:00 kernel: amdgpu 0000:03:00.0: amd=
gpu: GPU reset succeeded, trying to resume<br>
&gt; &gt; 2024-06-06T10:27:05.047516+08:00 kernel: [drm] PCIE GART of 1024M=
 enabled (table at 0x000000F41FC00000).<br>
&gt; &gt; 2024-06-06T10:27:05.047533+08:00 kernel: [drm] VRAM is lost due t=
o GPU reset!<br>
&gt; &gt; 2024-06-06T10:27:05.047538+08:00 kernel: amdgpu 0000:03:00.0: amd=
gpu: PSP is resuming...<br>
&gt; &gt; 2024-06-06T10:27:05.070481+08:00 kernel: amdgpu 0000:03:00.0: amd=
gpu: reserve 0xa00000 from 0xf41e000000 for PSP<br>
&gt; &gt; TMR<br>
&gt; &gt; 2024-06-06T10:27:05.397519+08:00 kernel: amdgpu 0000:03:00.0: amd=
gpu: RAS: optional ras ta ucode is not available<br>
&gt; &gt; 2024-06-06T10:27:05.409509+08:00 kernel: amdgpu 0000:03:00.0: amd=
gpu: RAP: optional rap ta ucode is not available<br>
&gt; &gt; 2024-06-06T10:27:05.409517+08:00 kernel: amdgpu 0000:03:00.0: amd=
gpu: SECUREDISPLAY: securedisplay ta ucode is not<br>
&gt; &gt; available<br>
&gt; &gt; 2024-06-06T10:27:05.409518+08:00 kernel: amdgpu 0000:03:00.0: amd=
gpu: SMU is resuming...<br>
&gt; &gt; 2024-06-06T10:27:05.411482+08:00 kernel: amdgpu 0000:03:00.0: amd=
gpu: SMU is resumed successfully!<br>
&gt; &gt; 2024-06-06T10:27:05.413504+08:00 kernel: [drm] DMUB hardware init=
ialized: version=3D0x04000044<br>
&gt; &gt; 2024-06-06T10:27:06.055474+08:00 kernel: [drm] kiq ring mec 2 pip=
e 1 q 0<br>
&gt; &gt; 2024-06-06T10:27:06.335476+08:00 kernel: amdgpu 0000:03:00.0: [dr=
m:amdgpu_ring_test_helper [amdgpu]] *ERROR* ring<br>
&gt; &gt; vcn_dec_0 test failed (-110)<br>
&gt; &gt; 2024-06-06T10:27:06.335495+08:00 kernel: [drm:amdgpu_device_ip_re=
sume_phase2 [amdgpu]] *ERROR* resume of IP block<br>
&gt; &gt; &lt;vcn_v3_0&gt; failed -110<br>
&gt; &gt; 2024-06-06T10:27:06.335498+08:00 kernel: amdgpu 0000:03:00.0: amd=
gpu: GPU reset(2) failed<br>
&gt; &gt; 2024-06-06T10:27:06.335499+08:00 kernel: amdgpu 0000:03:00.0: amd=
gpu: GPU reset end with ret =3D -110<br>
&gt; &gt; 2024-06-06T10:27:06.335631+08:00 kernel: [drm:amdgpu_job_timedout=
 [amdgpu]] *ERROR* GPU Recovery Failed: -110<br>
&gt; &gt; <br>
Hi Thorsten,<br>
<br>
It seems that the issue persists on 6.10 rc3.<br>
</blockquote></div>

--00000000000000a05e061aba6e71--
