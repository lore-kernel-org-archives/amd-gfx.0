Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC591C44515
	for <amd-gfx@archiver.kernel.org>; Fri, 17 Jul 2026 19:58:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8A82B10E4C8;
	Fri, 17 Jul 2026 19:58:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="f+g5esH3";
	dkim-atps=neutral
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com
 [209.85.214.180])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A0FDC10E4C8
 for <amd-gfx@lists.freedesktop.org>; Fri, 17 Jul 2026 19:58:02 +0000 (UTC)
Received: by mail-pl1-f180.google.com with SMTP id
 d9443c01a7336-2cf49dc28ccso105195ad.0
 for <amd-gfx@lists.freedesktop.org>; Fri, 17 Jul 2026 12:58:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784318282; cv=none;
 d=google.com; s=arc-20260327;
 b=NhibTfSl+SA5Nh5sSoyf/QrFYH0jGLn6IHB5G/yHi0aMyGyctZaQPX9Ebc2R1Kj2P9
 PynvtyeZOj7wfB5YJBVwXu5b7OTWclemk45Wud6mbzvrGhNWhLLBDsTrSd2feze1NPdb
 JEo1b4ToXAwX9DJRaGllNjgdwlksdDEiDkyaWyrLRbh9DfC89KxTTUes11/pcbjGY0IY
 kch7dSAgd6rycNRq8P8Xi1JzlzMJZYDMQvpcynpkPvXiCcCZdK7mCVav2Rr9macLQFUt
 VsHTlpfUqNNSfKiaZ1DKwoLK2c6paEutA89vQ3z2CDkbxkTK+CH2L3EDynJ45nHmQciF
 DVoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=Ah1Vg71hR+8QIOlYHXuzMDsOUY/+05kUpgXczkgY/nA=;
 fh=ms0c+sWQcwD0Br1a5TPc/w37ZIIvWZ30Ii1SvEf0gYc=;
 b=HhZPtTtd/1vp+4EYdMbtO2rIYdS+M3KW9rKwz3IkjXWzDZPvHbZ1Qowuad/oVXmtGA
 yiYmtLpqKW8pGG8Z1ZBXGPk/+731Pu4waWemY5U1sqCba/Aj5MuOIIO2vw8Gw/FKEkl6
 br3pA3x4eDUkfY6Yt8aO0ZMfbWmae8FK9QKQ2qDP4SEdXQ/PBP4/qNsLMYMeoPn+o8dH
 LkVjCd8LHgEwLNrX4Exehd/b+G32g9JQd3FGXAPNH1QE9nVi7mhLdzqArq/alOdSI+1t
 JlebLoih0DlCaUzewiW9yan7m5wXiDntllnq2F0FWs+oTp2grNSe1llMi3slqbzekBju
 YaDQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784318282; x=1784923082; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Ah1Vg71hR+8QIOlYHXuzMDsOUY/+05kUpgXczkgY/nA=;
 b=f+g5esH3baqVmtlf3tN6QUBQi1jRvXqcBSHhTCL0tnR+s2Uds/RT4bMzvbZOKIV010
 ONk4d+vq0jadCME74Op56TR9MzyPa/ctuYB5BQDExBy9Z8OVkKjVZpSENCHdcRg1HurT
 H65CQzoLL7FsJxXfkAu7ip3vKv7+2AFZlfIOT430299KqP/13/THMAy4S3UxQXYGzen4
 fF98nMUrXC+5yT+w3gY/gm5+p6/SARjugCh+aVF+9cU2FAcP/SgUecoeUjP20dGDrxOW
 M7/r4ZGv4wf/Xks29TptyRLXBwDk2PZRJJ8Ib6ZfCT9Rr2MKLAlklhxVT8PdeC9SeIdl
 v11w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784318282; x=1784923082;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Ah1Vg71hR+8QIOlYHXuzMDsOUY/+05kUpgXczkgY/nA=;
 b=AIq6VzBljFkT3aE9gg802V+jX+Oqc4QgAVecYFmE/QhcxDT8ZR/ELPCXL5atefi+F+
 GRyMtQc7luM5eue5CeH6HSryEPjC/Ev4INKb7fCO4tBorfRTLfZR2SCRdbaYh5HzSrN6
 ZD2DazvoPPrYnK/H+MLkTBtEgKAWvDEyxHWaP9Zdl+Cm/vCHWXOqe/ZnfEvqkS+EzFJI
 4tdSWKehyJutxfjtA0aqK2K/PHNzMyeIR7X23tSvXcEpWE1ndsDJen8sq/8RZtaTeCRz
 9DqhZ6tt56jjh+NZI9CfvxV/Cm7ydqPZwb5+p12arviZwztqA+2qPguzvMJR/aQ/bGHF
 ErmA==
X-Gm-Message-State: AOJu0YyVCkAiRbr+sWbm5LFUg2mWk01g2pS/9FLyfk0I6pcjdN/LbiyQ
 Cn1lUHhlrsjUPU4bZ1rz1skInwzzlwrcP+PQqq8DgSk6AOZ/LAu8B+olxDo8Jd/DmwueOStVmYu
 TdQfZH5NeODV6+VK8pD5Ym24y7Ybc3t8=
X-Gm-Gg: AfdE7ckGv3TNnCn5ggjVs03hqIkYg6cB1Sc2CEnPR1YFXUaTIVX70wlfyDuOjnWu6WF
 dYTXXP6LJdBQopy7H3f/6A4+6PKXGDSwI8+u//RhpDE5LeH1xp2QJFfzwB5aAbIY1kcx9kmcuIa
 RjVIyamqJvvUxhWCUWjg2xJ/x/tlawIJw/nAs6vPuyILTQqhCMrYEk6NMS/7X0c4u8r8RtLKFin
 9wSwOZ6v5zIvEPvO8t2eMlB5GeiNpYcOa3v/5WeUkP8fdVuITZJAWCVZ/9IniCXCD5n2SrZsTJY
 F8wCxT5rpnPOb4M/a+GqYzFJ75ReQ3d3u2gccEa5g3jhwQ3y
X-Received: by 2002:a17:902:e549:b0:2ca:de3:15eb with SMTP id
 d9443c01a7336-2cf346316a0mr38328965ad.0.1784318281977; Fri, 17 Jul 2026
 12:58:01 -0700 (PDT)
MIME-Version: 1.0
References: <12933316.O9o76ZdvQC@gea-pc>
In-Reply-To: <12933316.O9o76ZdvQC@gea-pc>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 17 Jul 2026 15:57:50 -0400
X-Gm-Features: AUfX_mxcbRh71VH1OHCNrgUbv3-w8R_UVtHBTxGYEghm57RqLjui31AIO3p8Lsg
Message-ID: <CADnq5_NEVs91yRY_X-rUwfe3CnGU-kL4GzNRf5a1M4gdo71Abg@mail.gmail.com>
Subject: Re: [RDNA4] RX 9060 XT - Pageflip timed out causes complete desktop
 lockup under KDE Wayland
To: Gabriel Elias de Aquino <gabriel.aquino86@gmail.com>
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

On Fri, Jul 17, 2026 at 3:14=E2=80=AFPM Gabriel Elias de Aquino
<gabriel.aquino86@gmail.com> wrote:
>
> Brief summary of the problem:
>
> The desktop randomly freezes. Kernel log shows: Pageflip timed out! This =
is a bug in the amdgpu kernel driver followed by: flip_done timed out commi=
t wait timed out Initially I was able to recover by switching to another VT=
 and restarting SDDM. The issue became worse. Now the machine often cannot =
switch to another VT anymore and requires a hard reset.
>
> Already tested: amdgpu.dcdebugmask=3D0x10, amdgpu.dcdebugmask=3D0x12 amdg=
pu.runpm=3D0, 180Hz, 144Hz Issue still occurs. Testing amdgpu.dc=3D0 result=
s in a black screen during boot.
>
> Hardware description:
>
> GPU: AMD Radeon RX 9060 XT 16GB
> CPU: Ryzen 7 9800X3D
> DisplayPort 1920x1080 180Hz
>
> System information:
>
> Distro name and Version: Debian GNU/Linux 13.6 (trixie)
> Kernel version: 7.0.13 from Debian Stable Backports
> Custom kernel: N/A
> Desktop: KDE Plasma Wayland
> AMD official driver version: Mesa 26.1.2, Firmware 20260519 (from Debian)=
, amdgpu version 7.0.13
>
> How to reproduce the issue:
>
> Cannot reproduce as it is totally unpredictable and random. I can work al=
l day without a single ocurrence and the other day it can happen twice. One=
 thing though: it ALWAYS occurs on low GPU workload, e.g. while moving the =
mouse around, browsing the web, reading e-mails, etc. It never happened whe=
n the GPU is working really hard, like while playing games.
>

Should be fixed with these patches:
https://gitlab.freedesktop.org/agd5f/linux/-/commit/d094bc1f17783d148b81723=
39d05a12095e13dd4
https://gitlab.freedesktop.org/agd5f/linux/-/commit/d73f4e118dc4c688fe7d198=
83027d0ef14822c61
https://gitlab.freedesktop.org/agd5f/linux/-/commit/c9ab9622f5b2799fe624a4a=
134e60112149271dd

Alex

> Attached files:
>
> Log files (for system lockups / game freezes / crashes)
>
> Dmesg log (full log)
>
> dmesg.txt
>
> Any other log
>
> inxi.txt
>
> journal.txt
>
> kwin.txt
>
>
> --
>
> Gabriel Elias de Aquino
>
> gabriel.aquino86@gmail.com
