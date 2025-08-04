Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D9DCC87FCB
	for <amd-gfx@archiver.kernel.org>; Mon,  4 Aug 2025 15:51:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A017D10E5EE;
	Mon,  4 Aug 2025 15:51:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="nIvsBFvx";
	dkim-atps=neutral
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com
 [209.85.215.173])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9CDF010E5EE
 for <amd-gfx@lists.freedesktop.org>; Mon,  4 Aug 2025 15:51:09 +0000 (UTC)
Received: by mail-pg1-f173.google.com with SMTP id
 41be03b00d2f7-b3badf1afc0so716756a12.3
 for <amd-gfx@lists.freedesktop.org>; Mon, 04 Aug 2025 08:51:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1754322669; x=1754927469; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zCkfJFI3TW1IrK381m5MWcyKCs1vhS8Y7+Z9XDxkIP4=;
 b=nIvsBFvxnvAVK1AIPVaIvV33EFc6DEGtyYjQjqzJcWZnI2CV0lfOT31jsCKvcJ+pvG
 ZL896l9l1ktItYUWgs53ZNcdvvV4MXQh7WS1rD29TtLSci5cWLtk2UMmKfp4FNMG1Rt/
 VZIqzeYDnqPppeh76b9EVj8SJ2lGs7j5i83usEbH2TIR9oUdyOp8EtdAWAiyErHL8fsa
 bk2j8saqDrTpJdUD7Dr0SHy5UQxXRI67GNSqwj2wH522OPBnXyX55BesntA8VaIuzCpu
 j5Z+VT/6PwJn+5uAUYEmqTudZ44bOqY2RkS7vns7Qmx+FHqNgywp96w1m5/RXIWLDtsz
 XQDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754322669; x=1754927469;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zCkfJFI3TW1IrK381m5MWcyKCs1vhS8Y7+Z9XDxkIP4=;
 b=MTMK1ripLUeCGUrWgLxXCPNR8Eys6MfI1ei8laT+r8tbjX+h/riemB92vY1UKrB99r
 GVuygDDI+znxiKwNtVtQ0rOYNxEEqdYxF7mLlmHcz+j/f7nAypQvVqNWS8MZ4UQ6T6In
 znTcAifwBJWS41aKsD6r6AoClazggei2+nNnaPekn4rx1ccTmagtAbAxS/hQIeZD+lqU
 ia8ofMFLayvD4sBhBi3O47d1Nc5A4VdqWK17mM58vKIsZoUZZXCs9OQuu/OoN/5dySx0
 6TrDV1k3tXjx8ekZ2VVHUoJ6oAFgUG41KoQ9VPcitVBRfQmp/KTA/qKhjYw+dgdkWY4H
 quBw==
X-Gm-Message-State: AOJu0Yy6RwBAduxeVZ9oN4aG0mND8Pxo3oXeGOWzHxqAegikrd++I95d
 +te5ZfQtSsCngF9m/8ZZ+TAHp++iyKGVdV0yiqbOFx/asQEgm3qwI9eyzalvsznjRKtyi1m5nGL
 kADebUW3DZkMWb/1759r8zO7CCLMlvx8=
X-Gm-Gg: ASbGncs4L+9GkC3Cyl4nqDKotivryg47YgrPf/aDNL8vgLCsKRTH2dxwTnpVRYmSZJJ
 p5f4HXp2inF94IT2YKNNgDdvYQUeB+n2x1VpBOk4JJdGYZvNdZ76Ulw6wQ/KFMALaqm01BuEB+w
 QcANEr9yBlV5FL+pDQD6R6EIu+Pg7HbtPuZKoWXkYLiHh051JFY8zhFdj9EUv85FZGHG7JyC2K/
 vBgZKOL
X-Google-Smtp-Source: AGHT+IF/otF+drLM3AWsjtmXwGW061qTvVbFx7U3Gv9WQmVVWurqas9BJI9HoVXLH9QIis5orYNTz57/5CsDh/Yph4c=
X-Received: by 2002:a17:90b:33c5:b0:31e:a421:4dda with SMTP id
 98e67ed59e1d1-321162ce3d6mr5947640a91.6.1754322668715; Mon, 04 Aug 2025
 08:51:08 -0700 (PDT)
MIME-Version: 1.0
References: <20250802160602.12698-1-timur.kristof@gmail.com>
In-Reply-To: <20250802160602.12698-1-timur.kristof@gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 4 Aug 2025 11:50:56 -0400
X-Gm-Features: Ac12FXzAGCqSvNu1iAD9R9ELkE1lN1Sf9Z4RMPfpGvZ0clsJrGqopi8zJiBb7Ss
Message-ID: <CADnq5_N6Y7V6qQ_GO00uWWmC8+OtvRjBWH=HFTfQE0VH+MN4OA@mail.gmail.com>
Subject: Re: [PATCH 0/3] DC: Fix page flip timeouts on DCE 6
To: =?UTF-8?Q?Timur_Krist=C3=B3f?= <timur.kristof@gmail.com>, 
 "Wentland, Harry" <Harry.Wentland@amd.com>,
 "Leo (Sunpeng) Li" <Sunpeng.Li@amd.com>
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

On Sat, Aug 2, 2025 at 12:23=E2=80=AFPM Timur Krist=C3=B3f <timur.kristof@g=
mail.com> wrote:
>
> Currently when using DC on DCE 6, it produces a page flip timeout
> after a suspend/resume.
>
> After some investigation, it turns out that the issue is because
> DC uses different interrupts between DCE 6 and newer HW versions,
> and it assumes that the VUPDATE interrupt is always present, when
> in fact it's not. It also assumes that the HW is capable of VRR
> when a VRR capable monitor is plugged in, when in fact this is
> not the case.
>
> This series marks VRR as unsupported on DCE 6 even when a VRR
> capable monitor is plugged in. Furthermore, it fixes the code
> trying to access the unregistered VUPDATE interrupt.
>
> As a side note, I also attempted to actually use the same
> interrupts as newer DCE versions, but this didn't work.
> Apparently DCE 6 was not advertised with VRR support anyway.
>
> Finally, there is also a patch to disable fast boot mode
> on DCE 6. The rationale is that this already didn't work
> on DCE 8, and even if it did I have no means to test it.
>
> Timur Krist=C3=B3f (3):
>   drm/amd/display: Disable fastboot on DCE 6 too.
>   drm/amd/display: Disable VRR on DCE 6
>   drm/amd/display: Don't use non-registered VUPDATE on DCE 6

Series looks good to me, but it would be good to get an ack from the
display team as well.  Series is:
Acked-by: Alex Deucher <alexander.deucher@amd.com>

>
>  .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 26 ++++++++++++-------
>  .../amd/display/amdgpu_dm/amdgpu_dm_crtc.c    | 16 +++++++-----
>  drivers/gpu/drm/amd/display/dc/dc_helper.c    |  5 ++++
>  drivers/gpu/drm/amd/display/dc/dm_services.h  |  2 ++
>  .../amd/display/dc/hwss/dce110/dce110_hwseq.c |  6 ++---
>  5 files changed, 35 insertions(+), 20 deletions(-)
>
> --
> 2.50.1
>
