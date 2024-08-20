Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12C83C531DC
	for <amd-gfx@archiver.kernel.org>; Tue, 20 Aug 2024 12:55:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4637510E797;
	Tue, 20 Aug 2024 12:55:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ggVwKa0d";
	dkim-atps=neutral
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com
 [209.85.208.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2315310E347
 for <amd-gfx@lists.freedesktop.org>; Tue, 20 Aug 2024 07:48:23 +0000 (UTC)
Received: by mail-ed1-f44.google.com with SMTP id
 4fb4d7f45d1cf-5bec7ee6f44so4702051a12.0
 for <amd-gfx@lists.freedesktop.org>; Tue, 20 Aug 2024 00:48:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1724140101; x=1724744901; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=m2kkntmmMQEVioRh82ozDSh0797/kRy0mInaiYsPB3U=;
 b=ggVwKa0dCt6ez9sg/1SzuXD57u7tKDfIyGm30IoVY4iLKyIUn6+W4ssK3oCikoaroM
 kBl03NiolLCztIFK1fjwwpXnsvDB6Ug8mk+CBDtlguz0eu5bFxibBvZDbM/wTJBaznse
 pKfw/ZWAekYC/74HqMbBcK9ZiRumGEE+ZDYBRIaNbN5ZL/sSfv/Em84nMdqmHm5dHgF0
 h5T4ZvcvKFgHY19tg62fg0oknPWGAEvs81O1rVrmOs9VXMdfmNweSD5A5YqZ41JjJruA
 4Q5X01Gg2LjiCGoLNCBeHlVUfCrIoMHbktmeE4p7aL8kZ3V65f7tdqzguMjP4bMNEp0z
 VFTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724140101; x=1724744901;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=m2kkntmmMQEVioRh82ozDSh0797/kRy0mInaiYsPB3U=;
 b=FTrsDsconFzTy+2L2vsfpvilME7KCKaDy3FBeALSc9xbhxebdJpo//GwvmbnSapdDg
 5g+/oW4lqco/6SL0wQC2wkkY1bzhAXwv+meqACrIEmttKcmh4w7r1sTXR4PoXUlRnu7j
 IzWg34RESCk6LrRorqYVdo5v/q1mm8iuawV3y1XEBZ+YSXpJznz41ImNAOm/0Ev+hnL0
 S8oF8JznBAgN6xLK2sgrHelXcVvDFgvak7EgiOMkoMBWNmfWrliPN7sAZpclTVlkNPhy
 4uihB+Wen5Np+DcLY4xMmxt++SL1ED3NBABLrCwFxLStWAlR4Kx3gzf12RBOjVLox2uE
 qXTg==
X-Gm-Message-State: AOJu0YzD8haH9UXO4cpalyUmf2OWse5pMyz1L9gt/Zm3D93dF505PTLq
 JDwpKsdvf6kUZ2vsSU20bv6IejqDzh3iGGijxHBE/JY7tX2NKJ97pi1sqdlFhtbYgC6zeL6vN9P
 IMvItI0EQLs45h6n/k9szicoG44XTVDqO
X-Google-Smtp-Source: AGHT+IFYZ1Kthn+eudetbhiZXXY9n4LduR4qsyP73dLGCxXMgPd2TIH5xS+AXThV1/S/ZotkQSEd5jfFjWkmuSh0XsA=
X-Received: by 2002:a05:6402:1e8f:b0:5a1:faf:e5ac with SMTP id
 4fb4d7f45d1cf-5beca7b03e1mr9923741a12.26.1724140101048; Tue, 20 Aug 2024
 00:48:21 -0700 (PDT)
MIME-Version: 1.0
References: <CA+Y=x3n+X6PDza5KAG2fy2wLh0-w5mWQtvKbWvT3E3A0r_makg@mail.gmail.com>
 <CADnq5_N-pvp8czodNT=YDFsqRz-Tet4GHK-JWiDdHnfL-2YF-w@mail.gmail.com>
In-Reply-To: <CADnq5_N-pvp8czodNT=YDFsqRz-Tet4GHK-JWiDdHnfL-2YF-w@mail.gmail.com>
From: Andrew Worsley <amworsley@gmail.com>
Date: Tue, 20 Aug 2024 17:48:09 +1000
Message-ID: <CA+Y=x3kr1F4OVPK8priS6cJZx_4KAT4kiYTLXhGK6qcYSG9TXw@mail.gmail.com>
Subject: Re: v6.11-rc4 amdgpu regression from v6.10.0
To: Alex Deucher <alexdeucher@gmail.com>
Cc: amd-gfx@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Tue, 20 Aug 2024 12:55:35 +0000
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

I did a git bisect on from v6.10 .. v6.11-rc4 and found the exact
change when the problem appeared (see below)

The problem is introduced by this

commit f9d8c5c7855d
Author: Jack Xiao <Jack.Xiao@amd.com>
Date:   Thu Apr 25 15:28:48 2024 +0800

    drm/amdgpu/gfx: enable mes to map legacy queue support

    Enable mes to map legacy queue support.

    v2: kiq_set_resources is required.

    Signed-off-by: Jack Xiao <Jack.Xiao@amd.com>
    Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
    Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
    Signed-off-by: Alex Deucher <alexander.deucher@amd.com>

M    drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c


On Tue, 20 Aug 2024 at 00:13, Alex Deucher <alexdeucher@gmail.com> wrote:
>
> On Mon, Aug 19, 2024 at 9:55=E2=80=AFAM Andrew Worsley <amworsley@gmail.c=
om> wrote:
> >
> > The v6.11-rc4 linux hangs during amdgpu start up where as the v6.10.0
> > is fine. I had to take a photo of the screen (see attachment) from
> > which I generated
> > the following summary:
> >
> >     Booting linux v6.11-rc4 :
> > ...
> > amdgpu: Virtual CRAT table created for CPU
> > amdgpu: Topology: Add CPU node
> > initializing kernel modesetting (IP DISCOVERY 0x1002:0x15BF 0xF111:0x00=
05 0xC2).
> > register mmio base: 0x90500000
> > register mmio size: 524288
> > add ip block number 0 <soc21_common>
> > add ip block number 1 <gmc_v11_0>
> > add ip block number 2 <ih_v6_0>
> > add ip block number 3 <psp>
> > add ip block number 4 <smu>
> > add ip block number 5 <dm>
> > add ip block number 6 <gfx_v11_0>
> > add ip block number 7 <sdma_v6_0>
> > add ip block number 8 <vcn_v4_0>
> > add ip block number 9 <jpeg_v4_0>
> > add ip block number 10 <mes_v11_0>
> > amdgpu 0000:c1:00.0: amdgpu: Fetched VBIOS from VFCT
> > amdgpu: ATOM BIOS: 113-PHXGENERIC-001
> > amdgpu 0000:c1:00.0: Direct firmware load for
> > amdgpu/gc_11_0_1_mes_2.bin failed with error -2
> > amdgpu 0000:c1:00.0: amdgpu: try to fall back to amdgpu/gc_11_0_1_mes.b=
in

The full git bisect history is

git bisect start
# status: waiting for both good and bad commits
# good: [0c3836482481200ead7b416ca80c68a29cfdaabd] Linux 6.10
git bisect good 0c3836482481200ead7b416ca80c68a29cfdaabd
# status: waiting for bad commit, 1 good commit known
# bad: [47ac09b91befbb6a235ab620c32af719f8208399] Linux 6.11-rc4
git bisect bad 47ac09b91befbb6a235ab620c32af719f8208399
# bad: [de9c2c66ad8e787abec7c9d7eff4f8c3cdd28aed] Linux 6.11-rc2
git bisect bad de9c2c66ad8e787abec7c9d7eff4f8c3cdd28aed
# good: [280e36f0d5b997173d014c07484c03a7f7750668] nsfs: use cleanup guard
git bisect good 280e36f0d5b997173d014c07484c03a7f7750668
# bad: [a4f9285520584977127946a22eab2adfbc87d1bf] Merge tag
'clk-for-linus' of
git://git.kernel.org/pub/scm/linux/kernel/git/clk/linux
git bisect bad a4f9285520584977127946a22eab2adfbc87d1bf
# bad: [365aa9f573995b46ca14a24165d85e31160e47b9] Merge tag
'amd-drm-next-6.11-2024-06-22' of
https://gitlab.freedesktop.org/agd5f/linux into drm-next
git bisect bad 365aa9f573995b46ca14a24165d85e31160e47b9
# bad: [1ddaaa244021aba8496536a6627b4ad2bc0f936a] Merge tag
'amd-drm-next-6.11-2024-06-07' of
https://gitlab.freedesktop.org/agd5f/linux into drm-next
git bisect bad 1ddaaa244021aba8496536a6627b4ad2bc0f936a
# bad: [b72fa761fc6be316bbf3ef9af4b7f145a208b1f3] drm/amdgpu: fix
documentation errors in sdma v7.0
git bisect bad b72fa761fc6be316bbf3ef9af4b7f145a208b1f3
# bad: [03f4b8c3ca7ad34d812d5760f0712e5c126c64c6] drm/amdgpu/mes12:
disable logging output
git bisect bad 03f4b8c3ca7ad34d812d5760f0712e5c126c64c6
# bad: [17e3bea65cdc453695b2fe4ff26d25d17f5339e9] drm/amd/pm: fix
warning using uninitialized value of max_vid_step
git bisect bad 17e3bea65cdc453695b2fe4ff26d25d17f5339e9
# good: [7e0357bef402875425de0296800c34c41842ba82] drm/amdgpu: remove
unused MCA driver codes
git bisect good 7e0357bef402875425de0296800c34c41842ba82
# good: [523ee6f4419bbeccbe43399d999f37381b5958c7] drm/amd/display:
For FPO + Vactive check that all pipes support VA
git bisect good 523ee6f4419bbeccbe43399d999f37381b5958c7
# good: [8fb20d9551368f0b1ef5b31fa0b4634f4be37157] drm/amdgpu: add
amdgpu MCA bank dispatch function support
git bisect good 8fb20d9551368f0b1ef5b31fa0b4634f4be37157
# good: [579f0c21baec9e7506b6bb3f60f0a9b6d07693b4] drm/amdgpu/pm:
Check the return value of smum_send_msg_to_smc
git bisect good 579f0c21baec9e7506b6bb3f60f0a9b6d07693b4
# good: [d53ce02352058639cacccc88cdbdbf48f1ee3b5a] drm/amdkfd: Evict
BO itself for contiguous allocation
git bisect good d53ce02352058639cacccc88cdbdbf48f1ee3b5a

Andrew
