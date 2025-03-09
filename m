Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D481FC28B2F
	for <amd-gfx@archiver.kernel.org>; Sun,  9 Mar 2025 16:57:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5B79B10E319;
	Sun,  9 Mar 2025 16:57:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="eimpf2k8";
	dkim-atps=neutral
Received: from mail-vk1-f176.google.com (mail-vk1-f176.google.com
 [209.85.221.176])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 94D5610E314
 for <amd-gfx@lists.freedesktop.org>; Sun,  9 Mar 2025 16:57:35 +0000 (UTC)
Received: by mail-vk1-f176.google.com with SMTP id
 71dfb90a1353d-523b8881d31so1259332e0c.2
 for <amd-gfx@lists.freedesktop.org>; Sun, 09 Mar 2025 09:57:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1741539454; x=1742144254; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yhfvxePxkVGlY830ofBy9MHbdXkT2cyPRu7NVc1wSJM=;
 b=eimpf2k8bvC6RnF5IA3BePvfjaWDZ1RiokIMsW1bAg7xKN6wb30qOs3UUEfwkqi49z
 N14T1BwVUZUFfSK8CZlYY7IriHcGHUZNhJlPGRfrz0EgP2VGyweEJYoemw1m95dQ6IW3
 v333NTckZaX9DdI/9AFh//cu5ZaLLSDjPX9W2tyGqU2vZ7ZOpkjR0AHVQUqe/D1W9EFK
 +HWndvAuihaNP+11LXmUZxMMSnX05aOmKbpDJMDsfjDsne8nS4tRqUNCBEiORiq1tNyQ
 3KWUQOeV94CMS9sjRNQGLyOIcapeWrqb41UJTKmXLSJP1WOUs1PbraP/dm+9BNHD18em
 rNOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741539454; x=1742144254;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yhfvxePxkVGlY830ofBy9MHbdXkT2cyPRu7NVc1wSJM=;
 b=sM+20JOR9wZ0w1F4malVyS/WHBK8ha4gYSxdHOse6zyu2QgAoGTJgOOlAIlYukO7Pk
 skFsmaz6iqYUbMMnkjBZq+YKSdjb60dx5+C/Q8otxeMRK/z45SSDovH33hvSa92cNZDB
 7GVK6t7LMzKxMj5jXI3w9xSvHoMV+A31K04UANAnoZqgv2FMWDf1xkJgv0nHG9HU8DKS
 yy6qTwoGQIzn5t2ZOwVT3eISPZ46LXSqL/fyKCbBdxRKUss1LvwGP0Vk4D9/JSkhmwl6
 3lwPqPxeboePSQ0/kXVq2uWgMjoNQqwbcbEx9PkkWeb8EM+XMbihqqsgyDno84N3G/5N
 m4/A==
X-Gm-Message-State: AOJu0YxCado7S/mWmBztHBd9e+GT/0xg7g51gGAD+4Vm/LjmGtPPNXjb
 c9XlbMHgSy3XDW3OF1EBzzsoNonozGD+fyoYrrVzpuT3vU3M6GPElpfpybDsiDri0/5m/2jJvGy
 9TjnQkf7xhAjQ611yOHh2rnuVTJ4hmg==
X-Gm-Gg: ASbGncsa7h8IIXLgBNo9NBUxIZLS76zvfmVvUJbW5x2kVlBRCtZ7NohdJ1cWn5eOx1e
 0vv/BIdtvEm83Dc7XxzljCTiTmn8wMvspVgwxiBgPrjImwGUhBTOyUibeyheM/gulwLOhM9hRAi
 3tqpk4oK0xzuJ41Rf5Sr+HnvKA/BQ2ViGldms=
X-Google-Smtp-Source: AGHT+IE8PEo3XsGK5TCRfmK5dnksT3RFDTgv+g/GZXJSYesoiaZ+CdhFul/SI/8rMlXuipOjN//zqp0H51jCieZWJ/M=
X-Received: by 2002:a05:6122:65a8:b0:520:6416:56f8 with SMTP id
 71dfb90a1353d-523e40245e9mr7315385e0c.3.1741539454569; Sun, 09 Mar 2025
 09:57:34 -0700 (PDT)
MIME-Version: 1.0
References: <CAPEhTTEfGK031+RiifE2RYMphms4dNMiXEJ49KkL3azq10UvDw@mail.gmail.com>
 <CADnq5_P35qyN1Po4Ofaop3K6rGxP71evXiPBDPaRbKjGQSg6ag@mail.gmail.com>
In-Reply-To: <CADnq5_P35qyN1Po4Ofaop3K6rGxP71evXiPBDPaRbKjGQSg6ag@mail.gmail.com>
From: Alexandre Demers <alexandre.f.demers@gmail.com>
Date: Sun, 9 Mar 2025 12:57:23 -0400
X-Gm-Features: AQ5f1JpBLbSEnDo5W49wiCjlztlDxhJh5nPkRTAnRDHMdhF564jZkL24KDakZoQ
Message-ID: <CAPEhTTFPBLqDid_yr+B1CHiARwQUwMZTYxUz9zjHAL4vo5SxBQ@mail.gmail.com>
Subject: Re: SI DMA: clarification on naming convention
To: Alex Deucher <alexdeucher@gmail.com>
Cc: Freedesktop - AMD-gfx <amd-gfx@lists.freedesktop.org>
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

On Sun, Mar 9, 2025 at 12:47=E2=80=AFPM Alex Deucher <alexdeucher@gmail.com=
> wrote:
>
> On Sat, Mar 8, 2025 at 3:39=E2=80=AFAM Alexandre Demers
> <alexandre.f.demers@gmail.com> wrote:
> >
> > Hi,
> >
> > While working on cleaning up sid.h, si_enums.h and some other SI
> > related files, I've been scratching my head about why SI DMA files and
> > variables were named "DMA" compared to CIK and over where "SDMA" is
> > used.
> >
> > While I understand that a new system DMA was introduced with CIK,
> > isn't SI DMA also a "system DMA"? Could we use the same naming
> > convention and talk about sDMA, name defines values, shifts and masks?
> > Could si_dma.c/.h be renamed to si_sdma.c/.h? Was the naming
> > difference introduced to CIK so different that the naming covention
> > needed to be modified?
>
> The SDMA IP was first added on CIK.  SI used the older paging DMA IP
> that first appeared on r6xx parts.  While they are conceptually
> similar (general purpose DMA copy/fill engines), the underlying
> hardware and firmware was much different.  I'm not sure what the
> advantage would be to renaming it at this point other than code churn.
>
> Alex

The only benefit would be to have closer define names, thus making
comparisons between chip families easier. But the differences are not
so important that they are actually preventing understanding what is
going on. I'll keep things as they are then.

Alexandre
