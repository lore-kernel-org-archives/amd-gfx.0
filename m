Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A6B5C4167D
	for <amd-gfx@archiver.kernel.org>; Wed, 23 Nov 2022 15:48:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2520C10E5A4;
	Wed, 23 Nov 2022 15:48:32 +0000 (UTC)
Received: from mail-oo1-xc2b.google.com (mail-oo1-xc2b.google.com
 [IPv6:2607:f8b0:4864:20::c2b])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 73ED810E5A4
 for <amd-gfx@lists.freedesktop.org>; Wed, 23 Nov 2022 15:48:29 +0000 (UTC)
Received: by mail-oo1-xc2b.google.com with SMTP id
 r10-20020a4aa2ca000000b0049dd7ad4128so2750937ool.13
 for <amd-gfx@lists.freedesktop.org>; Wed, 23 Nov 2022 07:48:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=URtPdizckGSzCQz6vC2bWXOgsWd2yx15WdbVIDj6XBY=;
 b=qI5AuRtvscsCylSci8T0qRhQO//lG4wyHx521pfcUuAnanx3xY/o/G1XJZiBKCL6ru
 Cn7Vz08WjbPQFmG5es1eQeSNhZLvUbWakT5lJQC7m2Rf7JAYt0kxwsEnpHTFRbHf7CsE
 3wvPMH0WJnT7wr/sIhqRK6CvRA/Ex5v3CUALovHWRPcgwa7ZIq0/dgvP/v9fTj0DFiMg
 X8Sbqa+X+Vj4HOddZqTx49jTVdtnbsafQnGptFy5D+A0BfBhBj9tMP3LZLCyCM3mqW9u
 xPYiLOwPH7+GC7lvFzmo0gyxVU6hPXIZQjAEg7ZBO6bYL0cuMdhg+xZRDEAgBAbsjX2J
 hMyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=URtPdizckGSzCQz6vC2bWXOgsWd2yx15WdbVIDj6XBY=;
 b=WC26wm3ulxyQ2ZRQw26kR1gCodU86lFw/+X2ffNg/Kic9ec10zpVVr0VDgtL1X89tx
 0iX/TBg2SjNnv5AkEMxP0osNAcMkDNuGUoEQuwzn4N5bYBbySgRLR+BPH68aGqS9lyUT
 VZAepJe87FbFQV6wMZmjBtK4xC7STy5IOq2T1C2HeeGMSD5Ap+t2yM6UIzEenMd9vYjV
 zjRxDU94lOKoNE98q+DKA0t5B3kzwaODsdE2vXXR1rpMuypKZ3EDCQ3e67gniDia7PLJ
 8moghJQkmNOe+Bvu47aW7vEwhwufgKv/6fFSRBIaqYg/tN7jFZ9Ez04emCZOnLqm1aet
 2pdg==
X-Gm-Message-State: ANoB5pkHYg5I3pnDPjPZg71C/258QMotvZSgMcBBz+K+MqfcFnDtmKPR
 JYCzGoiV3wqnAVi+2zTG4QFBjSbdh54HcwoqbsU=
X-Google-Smtp-Source: AA0mqf6eOcps2Un+ERXlxm1O4XV3ruVNIDwvoSpD4qfI26ngJnL+/zmi0PHsB3AHiTdICIlyE8Qej8rruq18K7yeoh4=
X-Received: by 2002:a4a:4005:0:b0:49f:4579:ccc8 with SMTP id
 n5-20020a4a4005000000b0049f4579ccc8mr3889637ooa.70.1669218508692; Wed, 23 Nov
 2022 07:48:28 -0800 (PST)
MIME-Version: 1.0
References: <622f20c5-5c24-d1c5-f874-6cb80b365e2e@collabora.com>
 <CADnq5_PKxfk9wEbQp8Mcxszp8R02qqe6ZtuonZ-TH4Zg9Lhrdg@mail.gmail.com>
 <PH7PR12MB5596F7B8DB291973C6190917930C9@PH7PR12MB5596.namprd12.prod.outlook.com>
In-Reply-To: <PH7PR12MB5596F7B8DB291973C6190917930C9@PH7PR12MB5596.namprd12.prod.outlook.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 23 Nov 2022 10:48:17 -0500
Message-ID: <CADnq5_PJBp0_MTbFYLXmsACBTSuiG_erJpE_s2hSxARcP6gL_Q@mail.gmail.com>
Subject: Re: Help debug amdgpu faults
To: "Khatri, Sunil" <Sunil.Khatri@amd.com>
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
Cc: Robert Beckett <bob.beckett@collabora.com>,
 Daniel Stone <daniels@collabora.com>,
 =?UTF-8?Q?Adri=C3=A1n_Mart=C3=ADnez_Larumbe?= <adrian.larumbe@collabora.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 Dmitrii Osipenko <dmitry.osipenko@collabora.com>, "Koenig,
 Christian" <Christian.Koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Wed, Nov 23, 2022 at 2:50 AM Khatri, Sunil <Sunil.Khatri@amd.com> wrote:
>
> [AMD Official Use Only - General]
>
> Hello Alex, Robert
>
> I too have similar issues which I am facing on chrome. Are there any tool=
s in linux environment which can help debug such issues like page faults, k=
ernel panic caused by invalid pointer access.
>
> I have used tools like ramdump parser which can be used to use the ramdum=
p after a crash and check a lot of static data in the memory and even the p=
age table could be checked by walking through them manually. We used to loa=
d the kernel symbols along with ramdump to go line by line.
>
> Appreciate if you can point to some document or some tools which is alrea=
dy used by linux graphics teams either UMD or KMD drivers so chrome team ca=
n also exploit those to debug issues.
>

UMR has a number of tools for dumping GPU page tables and debugging page fa=
ults:
https://gitlab.freedesktop.org/tomstdenis/umr

Alex


> Regards
> Sunil Khatri
>
> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Alex D=
eucher
> Sent: Tuesday, November 22, 2022 7:42 PM
> To: Robert Beckett <bob.beckett@collabora.com>
> Cc: Dmitrii Osipenko <dmitry.osipenko@collabora.com>; Adri=C3=A1n Mart=C3=
=ADnez Larumbe <adrian.larumbe@collabora.com>; Koenig, Christian <Christian=
.Koenig@amd.com>; amd-gfx@lists.freedesktop.org; Daniel Stone <daniels@coll=
abora.com>
> Subject: Re: Help debug amdgpu faults
>
> On Tue, Nov 22, 2022 at 6:53 AM Robert Beckett <bob.beckett@collabora.com=
> wrote:
> >
> > Hi,
> >
> >
> > does anyone know any documentation, or can provide advice on debugging =
amdgpu fault reports?
>
> This is a GPU page fault so it refers the the GPU virtual address space o=
f the application .  Each process (well fd really), gets its own GPU virtua=
l address space into which system memory, system mmio space, or vram can be=
 mapped.  The user mode drivers control their GPU virtual address space.
>
> >
> >
> > e.g:
> >
> > Nov 21 19:17:06 fedora kernel: amdgpu 0000:01:00.0: amdgpu: [gfxhub]
> > page fault (src_id:0 ring:8 vmid:1 pasid:32769, for process vkcube pid
> > 999 thread vkcube pid 999)
>
> This is the process that caused the fault.
>
> > Nov 21 19:17:06 fedora kernel: amdgpu 0000:01:00.0: amdgpu:   in page s=
tarting at address 0x0000800100700000 from client 0x1b (UTCL2)
>
> This is the virtual address that faulted.
>
> > Nov 21 19:17:06 fedora kernel: amdgpu 0000:01:00.0: amdgpu: GCVM_L2_PRO=
TECTION_FAULT_STATUS:0x00101A10
> > Nov 21 19:17:06 fedora kernel: amdgpu 0000:01:00.0: amdgpu:          Fa=
ulty UTCL2 client ID: SDMA0 (0xd)
>
> The fault came from the SDMA engine.
>
> > Nov 21 19:17:06 fedora kernel: amdgpu 0000:01:00.0: amdgpu:          MO=
RE_FAULTS: 0x0
> > Nov 21 19:17:06 fedora kernel: amdgpu 0000:01:00.0: amdgpu:          WA=
LKER_ERROR: 0x0
> > Nov 21 19:17:06 fedora kernel: amdgpu 0000:01:00.0: amdgpu:          PE=
RMISSION_FAULTS: 0x1
>
> The page was not marked as valid in the GPU page table.
>
> > Nov 21 19:17:06 fedora kernel: amdgpu 0000:01:00.0: amdgpu:          MA=
PPING_ERROR: 0x0
> > Nov 21 19:17:06 fedora kernel: amdgpu 0000:01:00.0: amdgpu:          RW=
: 0x0
>
> SDMA attempted to read an invalid page.
>
> >
> >
> >
> > see https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2=
Fgitlab.freedesktop.org%2Fdrm%2Famd%2F-%2Fissues%2F2267&amp;data=3D05%7C01%=
7Csunil.khatri%40amd.com%7Cd7778c40bff6443c2af708dacc9394c6%7C3dd8961fe4884=
e608e11a82d994e183d%7C0%7C0%7C638047231486449634%7CUnknown%7CTWFpbGZsb3d8ey=
JWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%=
7C%7C&amp;sdata=3Dvep6PKgDjRz02A3xYI8f7600QV2%2B7GYXsx%2FVYPY1M2I%3D&amp;re=
served=3D0 for more context.
> >
> > We have a complicated setup involving rendering then blitting to virtio=
-gpu exported dmabufs, with plenty of hacks in the mesa and xwayland stacks=
, so we are considering this our issue to debug, and not an issue with the =
driver at this point.
> > However, having debugged all the interesting parts leading to these fau=
lts, I am unable to decode the fault report to correlate to a buffer.
> >
> > in the fault report, what address space is the address from?
> > given that the fault handler shifts the reported addres up by 12, I ass=
ume it is a 4K pfn which makes me assume a physical address is this correct=
?
> > if so, is that a vram pa or a host system memory pa?
> > is there any documentation for the other fields reported like the fault=
 status etc?
>
> See the comments above.  There is some kernel doc as well:
> https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fdocs.=
kernel.org%2Fgpu%2Famdgpu%2Fdriver-core.html%23amdgpu-virtual-memory&amp;da=
ta=3D05%7C01%7Csunil.khatri%40amd.com%7Cd7778c40bff6443c2af708dacc9394c6%7C=
3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C638047231486449634%7CUnknown%7CT=
WFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%=
3D%7C3000%7C%7C%7C&amp;sdata=3Ddd971OoEZSJl%2FJif4%2Bypv9Dp0deeMVsQuCMc2o9B=
gQk%3D&amp;reserved=3D0
>
> >
> > I'd appreciate any advice you could give to help us debug further.
>
> Some operation you are doing in the user mode driver is reading an invali=
d page.  Possibly reading past the end of a buffer or something mis-aligned=
.  Compare the faulting GPU address to the GPU virtual address space in the=
 application and you should be able to track down what is happening.
>
> Alex
>
> >
> > Thanks
> >
> > Bob
> >
