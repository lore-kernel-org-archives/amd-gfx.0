Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59204C02183
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Jan 2025 22:26:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 01B6810E036;
	Tue, 14 Jan 2025 22:26:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="bDqDRHKY";
	dkim-atps=neutral
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com
 [IPv6:2607:f8b0:4864:20::1034])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B7A1010E036
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Jan 2025 22:25:58 +0000 (UTC)
Received: by mail-pj1-x1034.google.com with SMTP id
 98e67ed59e1d1-2f2f5e91393so1264276a91.0
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Jan 2025 14:25:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1736893558; x=1737498358; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2hW4qE1CHrMPB7SkMFJvmtoyzdwMpu1IRjKcEzCHbY0=;
 b=bDqDRHKYRen2E5IMyLNQ3xZd6SCvtQWvWz4Jcx5zP4J1zEwEy26nNaq/KUsJWorJVT
 ud6lMu68jN/+GIhVO+6rFBbeUO2jDqJAkYJuNDrTkq/JkdhJPX9JAGDdLWCXHpZLC+1i
 GwKn704gtV2h5/0op1Twk0Xco1jE/1nsRlNJq2gUFOAkfZrmp6w78AYrFI+6Qe9zHgwd
 SHlYeXMSolDY+xskd/8oc/ExH7yBCQUIlJt8aqklun8KzxpdkEmxwjnZh/dqZuquaQr0
 szzOenK5hAM98gEryHy4sj5Ljy9rU4kvJ/11pggj515azboQaqelIPyoKm0SvtbnTkpX
 4GUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736893558; x=1737498358;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2hW4qE1CHrMPB7SkMFJvmtoyzdwMpu1IRjKcEzCHbY0=;
 b=M2ecJ45jJ5PddsT25gPcCWBPn5ZTlnXwtEUgFfqryfujVsx+HuJoiDsJsH72gdZguH
 jhZTDlbI0N6LuQyuMKuAQQ+QvHkbLR9sZxnufwbwoS1EXaZROA0jsMHa2cvUEdmQcaxa
 55+CQtwsUa2NUufP5OzeCX8ZdUEgulo4Y9hOKegRDRjIOPm+lKNpzghQz43d/YsrB25E
 M9wyVR4F3+zfEViXEYV/Y0X8KOhaa/uEWp2vBCbhwUE6ZTeIsDK1ewY+L8BbNJmoc0N8
 PgYs9tn+75KDApJxmJD8No5eW8LE1MRmOIkDFG3aqNTt4OIhM1vdCg8s8jWkEW1ie6AM
 nslg==
X-Gm-Message-State: AOJu0Yz27LfpblTXM2+sRR/QJjIjx+B9zubpQDx6o4v4jF/yOjAXUsek
 y2Xo3xy/Fk7GM3bhmmYJtcGc5yZ2Nitk/8Hdw7bOmv+cOLuMbGLtZ37cPSjgVx+E5fdMMQmtpkE
 P9mq/3bre7sL/sVzEplM2aSM7yqb1LQ==
X-Gm-Gg: ASbGncvJhpc8tcrYKSO7PHkaVIg83GlPWIyNPoAFQsif6QeFIvi4KBiN6aba/sEFmET
 cHSrku5HN8EfhzMPYBVhWNm6XSF6QIxWcNAgxHw==
X-Google-Smtp-Source: AGHT+IHkx7W93P3InWpiM/ck2zA8B4Y31pUw5YYYs6kiUy6L4jTBhRMmtQ7EAxN+ydnpGJXzN5FpC13L+A+xbnS47mQ=
X-Received: by 2002:a17:90a:f945:b0:2ee:acea:9ec4 with SMTP id
 98e67ed59e1d1-2f548eb3faamr13494166a91.3.1736893558092; Tue, 14 Jan 2025
 14:25:58 -0800 (PST)
MIME-Version: 1.0
References: <20250114213157.19de9009@ryz.dorfdsl.de>
In-Reply-To: <20250114213157.19de9009@ryz.dorfdsl.de>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 14 Jan 2025 17:25:46 -0500
X-Gm-Features: AbW1kvZZS8jvVqsEV1uxyHlJNQIXdFsAfi6PskBQl3qK_cVMr1yc8R8CU1UZF28
Message-ID: <CADnq5_MFq-OWn7dwTTPPcBbFKQmBHvD6qCi8ngiVumk2V1U40g@mail.gmail.com>
Subject: Re: amdgpu 100% CPU usage causing freeze 1002:15d8
To: Marco Moock <mm@dorfdsl.de>
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

On Tue, Jan 14, 2025 at 3:49=E2=80=AFPM Marco Moock <mm@dorfdsl.de> wrote:
>
> Hello!
>
> This might be related to
> https://lists.freedesktop.org/archives/amd-gfx/2025-January/118759.html
> As I subscribed just now, I can't reply there and can't get the
> Message-I
>
>        description: Motherboard
>        product: Pro A520M-C II
>        vendor: ASUSTeK COMPUTER INC.
>        physical id: 0
>        version: Rev X.0x
>        slot: Default string
>      *-firmware
>           description: BIOS
>           vendor: American Megatrends Inc.
>           physical id: 0
>           version: 3612
>           date: 12/03/2024
>
> I updated the UEFI yesterday to the latest version, problem still
> exists.
>
> 08:00.0 VGA compatible controller [0300]: Advanced Micro Devices, Inc.
> [AMD/ATI] Picasso/Raven 2 [Radeon Vega Series / Radeon Vega Mobile
> Series] [1002:15d8] (rev c9) Subsystem: ASUSTeK Computer Inc. Device
> [1043:876b] Kernel driver in use: amdgpu Kernel modules: amdgpu
>
> Linux ryz 6.12.9-amd64 #1 SMP PREEMPT_DYNAMIC Debian 6.12.9-1
> (2025-01-10) x86_64 GNU/Linux
>
> un  mesa-common-dev           <none>       <none>       (no description a=
vailable)
> un  mesa-glide2-dev           <none>       <none>       (no description a=
vailable)
> ii  mesa-libgallium:amd64     24.3.3-1     amd64        shared infrastruc=
ture for Mesa drivers
> ii  mesa-libgallium:i386      24.3.3-1     i386         shared infrastruc=
ture for Mesa drivers
> un  mesa-opencl-icd           <none>       <none>       (no description a=
vailable)
> ii  mesa-utils                9.0.0-2+b1   amd64        Miscellaneous Mes=
a utilities -- symlinks
> ii  mesa-utils-bin:amd64      9.0.0-2+b1   amd64        Miscellaneous Mes=
a utilities -- native applications
> un  mesa-utils-extra          <none>       <none>       (no description a=
vailable)
> ii  mesa-va-drivers:amd64     24.3.3-1     amd64        Mesa VA-API video=
 acceleration drivers
> ii  mesa-vdpau-drivers:amd64  24.3.3-1     amd64        Mesa VDPAU video =
acceleration drivers
> ii  mesa-vulkan-drivers:amd64 24.3.3-1     amd64        Mesa Vulkan graph=
ics drivers
> ii  mesa-vulkan-drivers:i386  24.3.3-1     i386         Mesa Vulkan graph=
ics drivers
> un  mesag-dev                 <none>       <none>       (no description a=
vailable)
> un  mesag3                    <none>       <none>       (no description a=
vailable)
> un  mesag3+ggi-dev            <none>       <none>       (no description
> available)
>
>
> I am running Debian Unstable and encounter 100% CPU usage after some
> hours, reproducible. I have to shut off the system with sysrq, I can't
> shut it down the normal way as it is non-responsive.
>
> I tried 6.12.9 and 6.12.8.
>
> 6.12.8 gave some dmesg error messages:
>
> Jan 13 11:09:44 ryz kernel: amdgpu 0000:08:00.0: amdgpu: Dumping IP State
> Jan 13 11:09:48 ryz kernel: [drm:amdgpu_dm_atomic_check [amdgpu]] *ERROR*=
 [CRTC:73:crtc-0] hw_done or flip_done timed out
> Jan 13 11:09:55 ryz kernel: amdgpu 0000:08:00.0: amdgpu: failed to write =
reg 28b4 wait reg 28c6
> Jan 13 11:10:00 ryz kernel: sysrq: Keyboard mode set to system default
> Jan 13 11:10:00 ryz kernel: sysrq: This sysrq operation is disabled.
> Jan 13 11:10:00 ryz kernel: sysrq: This sysrq operation is disabled.
> Jan 13 11:10:01 ryz kernel: sysrq: Emergency Sync
>
>
> 6.12.9 doesn't gave me them, but it doesn't list sysrq calls either, so
> I assume it didn't manage to store them in dmesg.
>
> I remember the first occurrence last Friday, some mesa packages were
> updated and I assume it was running 6.12.8 according to the apt logs.
>
>
>
>
> Please tell me which further info you need to track down the issue.

What kernel version(s) is it working properly with?  Can you bisect?

Alex
