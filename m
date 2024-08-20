Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DB13C3DA4A
	for <amd-gfx@archiver.kernel.org>; Tue, 20 Aug 2024 13:09:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3DEBD10E287;
	Tue, 20 Aug 2024 13:09:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="DxLsgagp";
	dkim-atps=neutral
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com
 [209.85.214.182])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 71F6410E7D2
 for <amd-gfx@lists.freedesktop.org>; Tue, 20 Aug 2024 13:09:17 +0000 (UTC)
Received: by mail-pl1-f182.google.com with SMTP id
 d9443c01a7336-201f577d35aso2850255ad.1
 for <amd-gfx@lists.freedesktop.org>; Tue, 20 Aug 2024 06:09:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1724159357; x=1724764157; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7wENLxlmcieagYj63m9+kX5sP+5lkdu/NUeuQ19Odjg=;
 b=DxLsgagpjiBxUOz0HU2KEmdp5B5EHQfXEOkSxshT+lssKOaaqWfKbHQrh/VyskmhzM
 a7PEVOYtwDXjWCYV9LtTqlpz2c+i+awmKHOypnWU/ByMgBJix8HurrQ2/fPoA5F2kNCS
 i7dkSnWrhJ/ES5qUfkDJXB8dSBoYoqfGHPs0wa2UsPXgWk1j9QP6493Dpn4G/OnHYHzt
 8S9q2cHxpphgskcKQRDvDO3Hdn7k6hyb+e+v8E1WvOAhqXfqMcmea9+tMb4vBhqKY+yg
 eo0raa+sxwphALhF3kbIGwukHk7XxhiXtRpc6mMWc3LweOhm2SKxqz+98ZmBHtE2Wwox
 GZww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724159357; x=1724764157;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7wENLxlmcieagYj63m9+kX5sP+5lkdu/NUeuQ19Odjg=;
 b=HLdMNVDrtQoJ7SE1M7DxprStrDICilraOeP3ZuBw6Num8DFk6Oshi5sfDSk2uAq29J
 kZHCJEgTRD+Ti4FAYvy1b5IDCTjz3VEMoz1vHde1vZ3NBIH6uVR49+JNsZ8/8RtZ1VIh
 QAM1sOP+td0jm8rDpeHQXzIZ6JSoTBJGJJxL8Tq6mAXtVkmoy242Is8dAfYRYncHMqGr
 m23Io+ZmBD3inHDNys1ywJqJUc1F17kXS3pqhLaNX6LNqH6GmhnmzUfIp1Tc57s7pWZj
 3rLCtjPKDqf1x8EKotFiLqYnA5uGQz4hNyc4YL7cpT/K5+G0WLtQYeIMmol8uQx/T0uG
 pSmQ==
X-Gm-Message-State: AOJu0Yybn+xWrh+kpSs4k48tJmC57STYDoJE57efijH33V0vB1CkO/gF
 Q7lsB4TWKdxc2/bdg13y4qFT0jrMH/jjqDCH9RQstYdtb6eWyrCZyQ/jyHJIh+eAlWECKpsNWg/
 dauyFb7JDinnhUSZ1Rz7dGVFCpNM=
X-Google-Smtp-Source: AGHT+IE1YTok2ARYz64JT/kBfbB+WtIMxeXwBRaoECgaJQ5k5IGPdwOWBhaeyVzw5Do6el5yF4Q6B79yZfwS6hekjO4=
X-Received: by 2002:a17:902:d289:b0:202:13d7:9290 with SMTP id
 d9443c01a7336-20213d79b21mr82099215ad.8.1724159356545; Tue, 20 Aug 2024
 06:09:16 -0700 (PDT)
MIME-Version: 1.0
References: <CA+Y=x3n+X6PDza5KAG2fy2wLh0-w5mWQtvKbWvT3E3A0r_makg@mail.gmail.com>
 <CADnq5_N-pvp8czodNT=YDFsqRz-Tet4GHK-JWiDdHnfL-2YF-w@mail.gmail.com>
 <CA+Y=x3kr1F4OVPK8priS6cJZx_4KAT4kiYTLXhGK6qcYSG9TXw@mail.gmail.com>
In-Reply-To: <CA+Y=x3kr1F4OVPK8priS6cJZx_4KAT4kiYTLXhGK6qcYSG9TXw@mail.gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 20 Aug 2024 09:09:04 -0400
Message-ID: <CADnq5_PthnFSeyLxhLSRiWSU1Y2McrMuSC6LXC2CFW3hqmTwVw@mail.gmail.com>
Subject: Re: v6.11-rc4 amdgpu regression from v6.10.0
To: Andrew Worsley <amworsley@gmail.com>, Jack Xiao <Jack.Xiao@amd.com>
Cc: amd-gfx@lists.freedesktop.org
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

+ Jack

Looks like maybe some older firmware versions don't support this
properly.  @Jack Xiao Can you find out if there is a minimum firmware
version needed for legacy queue mapping and add the appropriate check?

@Andrew Worsley does it work correctly with a newer version of firmware?

Thanks,

Alex

On Tue, Aug 20, 2024 at 3:48=E2=80=AFAM Andrew Worsley <amworsley@gmail.com=
> wrote:
>
> I did a git bisect on from v6.10 .. v6.11-rc4 and found the exact
> change when the problem appeared (see below)
>
> The problem is introduced by this
>
> commit f9d8c5c7855d
> Author: Jack Xiao <Jack.Xiao@amd.com>
> Date:   Thu Apr 25 15:28:48 2024 +0800
>
>     drm/amdgpu/gfx: enable mes to map legacy queue support
>
>     Enable mes to map legacy queue support.
>
>     v2: kiq_set_resources is required.
>
>     Signed-off-by: Jack Xiao <Jack.Xiao@amd.com>
>     Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
>     Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
>     Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
>
> M    drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
>
>
> On Tue, 20 Aug 2024 at 00:13, Alex Deucher <alexdeucher@gmail.com> wrote:
> >
> > On Mon, Aug 19, 2024 at 9:55=E2=80=AFAM Andrew Worsley <amworsley@gmail=
.com> wrote:
> > >
> > > The v6.11-rc4 linux hangs during amdgpu start up where as the v6.10.0
> > > is fine. I had to take a photo of the screen (see attachment) from
> > > which I generated
> > > the following summary:
> > >
> > >     Booting linux v6.11-rc4 :
> > > ...
> > > amdgpu: Virtual CRAT table created for CPU
> > > amdgpu: Topology: Add CPU node
> > > initializing kernel modesetting (IP DISCOVERY 0x1002:0x15BF 0xF111:0x=
0005 0xC2).
> > > register mmio base: 0x90500000
> > > register mmio size: 524288
> > > add ip block number 0 <soc21_common>
> > > add ip block number 1 <gmc_v11_0>
> > > add ip block number 2 <ih_v6_0>
> > > add ip block number 3 <psp>
> > > add ip block number 4 <smu>
> > > add ip block number 5 <dm>
> > > add ip block number 6 <gfx_v11_0>
> > > add ip block number 7 <sdma_v6_0>
> > > add ip block number 8 <vcn_v4_0>
> > > add ip block number 9 <jpeg_v4_0>
> > > add ip block number 10 <mes_v11_0>
> > > amdgpu 0000:c1:00.0: amdgpu: Fetched VBIOS from VFCT
> > > amdgpu: ATOM BIOS: 113-PHXGENERIC-001
> > > amdgpu 0000:c1:00.0: Direct firmware load for
> > > amdgpu/gc_11_0_1_mes_2.bin failed with error -2
> > > amdgpu 0000:c1:00.0: amdgpu: try to fall back to amdgpu/gc_11_0_1_mes=
.bin
>
> The full git bisect history is
>
> git bisect start
> # status: waiting for both good and bad commits
> # good: [0c3836482481200ead7b416ca80c68a29cfdaabd] Linux 6.10
> git bisect good 0c3836482481200ead7b416ca80c68a29cfdaabd
> # status: waiting for bad commit, 1 good commit known
> # bad: [47ac09b91befbb6a235ab620c32af719f8208399] Linux 6.11-rc4
> git bisect bad 47ac09b91befbb6a235ab620c32af719f8208399
> # bad: [de9c2c66ad8e787abec7c9d7eff4f8c3cdd28aed] Linux 6.11-rc2
> git bisect bad de9c2c66ad8e787abec7c9d7eff4f8c3cdd28aed
> # good: [280e36f0d5b997173d014c07484c03a7f7750668] nsfs: use cleanup guar=
d
> git bisect good 280e36f0d5b997173d014c07484c03a7f7750668
> # bad: [a4f9285520584977127946a22eab2adfbc87d1bf] Merge tag
> 'clk-for-linus' of
> git://git.kernel.org/pub/scm/linux/kernel/git/clk/linux
> git bisect bad a4f9285520584977127946a22eab2adfbc87d1bf
> # bad: [365aa9f573995b46ca14a24165d85e31160e47b9] Merge tag
> 'amd-drm-next-6.11-2024-06-22' of
> https://gitlab.freedesktop.org/agd5f/linux into drm-next
> git bisect bad 365aa9f573995b46ca14a24165d85e31160e47b9
> # bad: [1ddaaa244021aba8496536a6627b4ad2bc0f936a] Merge tag
> 'amd-drm-next-6.11-2024-06-07' of
> https://gitlab.freedesktop.org/agd5f/linux into drm-next
> git bisect bad 1ddaaa244021aba8496536a6627b4ad2bc0f936a
> # bad: [b72fa761fc6be316bbf3ef9af4b7f145a208b1f3] drm/amdgpu: fix
> documentation errors in sdma v7.0
> git bisect bad b72fa761fc6be316bbf3ef9af4b7f145a208b1f3
> # bad: [03f4b8c3ca7ad34d812d5760f0712e5c126c64c6] drm/amdgpu/mes12:
> disable logging output
> git bisect bad 03f4b8c3ca7ad34d812d5760f0712e5c126c64c6
> # bad: [17e3bea65cdc453695b2fe4ff26d25d17f5339e9] drm/amd/pm: fix
> warning using uninitialized value of max_vid_step
> git bisect bad 17e3bea65cdc453695b2fe4ff26d25d17f5339e9
> # good: [7e0357bef402875425de0296800c34c41842ba82] drm/amdgpu: remove
> unused MCA driver codes
> git bisect good 7e0357bef402875425de0296800c34c41842ba82
> # good: [523ee6f4419bbeccbe43399d999f37381b5958c7] drm/amd/display:
> For FPO + Vactive check that all pipes support VA
> git bisect good 523ee6f4419bbeccbe43399d999f37381b5958c7
> # good: [8fb20d9551368f0b1ef5b31fa0b4634f4be37157] drm/amdgpu: add
> amdgpu MCA bank dispatch function support
> git bisect good 8fb20d9551368f0b1ef5b31fa0b4634f4be37157
> # good: [579f0c21baec9e7506b6bb3f60f0a9b6d07693b4] drm/amdgpu/pm:
> Check the return value of smum_send_msg_to_smc
> git bisect good 579f0c21baec9e7506b6bb3f60f0a9b6d07693b4
> # good: [d53ce02352058639cacccc88cdbdbf48f1ee3b5a] drm/amdkfd: Evict
> BO itself for contiguous allocation
> git bisect good d53ce02352058639cacccc88cdbdbf48f1ee3b5a
>
> Andrew
