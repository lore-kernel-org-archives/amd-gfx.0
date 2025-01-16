Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A132C02183
	for <amd-gfx@archiver.kernel.org>; Thu, 16 Jan 2025 16:22:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DEED510E9BC;
	Thu, 16 Jan 2025 16:22:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="IGh4T33X";
	dkim-atps=neutral
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com
 [209.85.216.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 479F110E9BC
 for <amd-gfx@lists.freedesktop.org>; Thu, 16 Jan 2025 16:22:25 +0000 (UTC)
Received: by mail-pj1-f43.google.com with SMTP id
 98e67ed59e1d1-2f45526dea0so249076a91.1
 for <amd-gfx@lists.freedesktop.org>; Thu, 16 Jan 2025 08:22:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1737044485; x=1737649285; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=geXXdr3ypT/KeEnHFJryRPy49s3CDabZDwouiwb2vY0=;
 b=IGh4T33XU4f9cb77T/sLrRfQ5eWRVkjNLgVf6XTXsSMpoEyWZ0LIMd63o38PKg0Zv2
 PyO5Yv17ZRj98klbgDlpn32hnnY/2GKewSB8IfvRrfdc0AAV6rUl8QQMOtiFXeu5U8/Z
 iFCAyzo6CQTV+t5topQ0c8/MPIrLv32SRI3BFSaokP0UJ0K8T7M4RQdvi7KWKXORi/f7
 VJlH4tV4NAFdeirG+fow2opTnYyzipleHBA+0vTNZOmF4jdG7kRoWPx20Fn46VDJun2B
 n3cXbKlC+mTxeBItYykybzP+gxBIyC96IjY9lj+BZd88PjAWkfkCXaXdYXT9lnWQ/6FJ
 RzWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737044485; x=1737649285;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=geXXdr3ypT/KeEnHFJryRPy49s3CDabZDwouiwb2vY0=;
 b=gmHzTosjv7TebJqRfSmSPamVRbRrEFrSk/F5znQ8wt9ksf0nF5QewlbN+PNfIoyvTu
 xmwuU4QdC8rJhnro7IkZQknQk11GYJWsdWwnp5ppy+cB76r8rbDGAX1U/Gg1zLFWlxCs
 gZX8K/ZXsKUR1HD6ZIl4tCL5HDMzqiREvOYx7jeZ772DMYM6bZSx87X/BUXxhdv9qTsd
 LJtKcYiP2/IOT1a2vzzcacbYZ9xAFoMxSBu1SoqGF6+9yw8N0NDPufO3Y7YB62FVn5Nf
 g0/g5lxgtGF4klfDZCRc7XudG2y1F5oOO06y/Iu3RB3udSrqmycTlXQmo4KrBRxWdks4
 J5KA==
X-Gm-Message-State: AOJu0YzDXeAgZvpkZfojg7lEJOrNHnxKkyBzAQs86ocD2v2U+fylEwPr
 tdU5WqIv9jm7T2vrkvdMrzmCxBgYiwAoMJiquR/fiVUcH/QCogumBjkkb6ejYZuFS2YagV8/LqY
 C+PBO8lNVaP/ID5xbSySGmp/KLZp1UA==
X-Gm-Gg: ASbGncunc1SCBwloQjahn4ZLzFmT+XxvLeN+SixnoPWUOVDRjzEvTOu0wxi2luNQbVk
 IpNa6wr6zTYzYqqTGSop+c8MaSajagIJKXmNPFg==
X-Google-Smtp-Source: AGHT+IFVHRoGaxTLcQFftd4BC1yqLu14o+YAARh4Q/bVT+g7P8u1KIz6J9CrFUZB37Vx/EvP5R1Q/a8rNG+/i60sDLI=
X-Received: by 2002:a17:90a:dfcb:b0:2f4:447b:f095 with SMTP id
 98e67ed59e1d1-2f5490a9faamr18805176a91.4.1737044484719; Thu, 16 Jan 2025
 08:21:24 -0800 (PST)
MIME-Version: 1.0
References: <20250114213157.19de9009@ryz.dorfdsl.de>
 <CADnq5_MFq-OWn7dwTTPPcBbFKQmBHvD6qCi8ngiVumk2V1U40g@mail.gmail.com>
 <20250115160834.033e8aad@ryz.dorfdsl.de> <20250115211039.09e6e69e@zbook>
 <CADnq5_MY+cN0dPTis582HY0a80rNiO86kz9Ha=e=HS2Toim=4w@mail.gmail.com>
 <20250115213511.2feaa331@zbook>
In-Reply-To: <20250115213511.2feaa331@zbook>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 16 Jan 2025 11:21:11 -0500
X-Gm-Features: AbW1kvZTqXZnZaQEHjHU4Of1nExi2rGCJ_eslV47YcRbXdD1NwiPNNdG47MxmsM
Message-ID: <CADnq5_MbeTRb642qwb0Q7JbL=2UsnK6RnLm6NWTeVLZOEuyn4A@mail.gmail.com>
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

On Wed, Jan 15, 2025 at 4:02=E2=80=AFPM Marco Moock <mm@dorfdsl.de> wrote:
>
> Am Wed, 15 Jan 2025 15:27:00 -0500
> schrieb Alex Deucher <alexdeucher@gmail.com>:
>
> > On Wed, Jan 15, 2025 at 3:22=E2=80=AFPM Marco Moock <mm@dorfdsl.de> wro=
te:
> > >
> > > Am Wed, 15 Jan 2025 16:08:34 +0100
> > > schrieb Marco Moock <mm@dorfdsl.de>:
> > >
> > > > I assume it was 6.12.6, but Debian doesn't have the old packages
> > > > anymore and it has been purged from my system already.
> > >
> > > I've now tried 6.12.6, same situation.
> > >
> > > Any further ideas what could cause this?
> >
> > Can you provide more details about what you are seeing?  What does `ps
> > aux` or `top` show as using all of the CPU time?
>
> I saw
>    2977 root      20   0       0      0      0 R  99,3   0,0   5:18.68
>    kworker/u16:39+amdgpu-reset-dev
>
> But the system is almost unusable, it takes seconds to print the
> characters in terminal when connecting from a remote machine. Local,
> the system doesn't care about keyboard anymore, except Sysrq.
> Switching to another tty wasn't possible.
>
> In some cases, even the sysrq keystroke won't be recognized and I need
> to use the reset switch on the case.

Can you get the dmesg output when this happens?  Might be easier to
get it over a remote connection like ssh if possible.

Thanks,

Alex
