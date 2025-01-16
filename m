Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A27FCC02183
	for <amd-gfx@archiver.kernel.org>; Thu, 16 Jan 2025 16:33:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2DAEC10E9C8;
	Thu, 16 Jan 2025 16:33:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="g8Jel3VK";
	dkim-atps=neutral
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com
 [209.85.214.182])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7A00B10E9C8
 for <amd-gfx@lists.freedesktop.org>; Thu, 16 Jan 2025 16:33:54 +0000 (UTC)
Received: by mail-pl1-f182.google.com with SMTP id
 d9443c01a7336-2162b5d2e1fso2427945ad.3
 for <amd-gfx@lists.freedesktop.org>; Thu, 16 Jan 2025 08:33:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1737045174; x=1737649974; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dcaSfQK/ZgNt2O51u9SK7k2oYNTgZBcp7V0F0etTu+c=;
 b=g8Jel3VKuQmXFQxYe+y/3nHB60K2jN9tSbejDmXxkQV3Ca9oRKfYQcvPtfUWLNduvn
 1JjzYqRXnfCewXOaxsP2kXjuzhn9rdVNmSXJJuS1L94REHWRk6ZOYR3h52TWvBs2JHT1
 8bGRpaiF6etml3o8if18QGFRxUQO/3K62VjFTwZ5ouxLlPG4sqYhu0u21awgNY3MoabX
 V6a0bfnHbf2iHvWIIoPar4e39763/Ur3yLooTY5BSOk75TA2TFUqCaKsyRAu3v3+fdM4
 Q3+dQ8w9p80jiE5a9jBgP580+Zri2FW74EHsgAp4yCEjFFiIvui0FQnhzlEAyCEUhFXq
 5KYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737045174; x=1737649974;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dcaSfQK/ZgNt2O51u9SK7k2oYNTgZBcp7V0F0etTu+c=;
 b=AX9/uy49cBnThVtUONYYQftIKISGt+OJ3u96ULQ7aGcCd9mdgufeArLBskmSV6oSg3
 lHCRL2pAIteTldr0JLwVSWdgnIMOBbFFSDeJkDyegqeisCA+0R7Ar4ldpEMbAwHZgFy7
 MR0PCrPc5h/mcDtlKzaWfl5B1yfIQkKBdd58WZWYhYXbvKuSWJ5ntBl28JTdCi6Ezob/
 zjVVGb1D0miu7uJW5UiKj9bnWM1BG7zCP/nylqOgt6EfYt8QVx8HVoFrf5Qe+10BjhT1
 ErItxiCzqq1AGtvU/yzOvk6Fn/O3TGS89rQb+BpV3i5bY4KQQ0D77CwrSDg5QnN67zQl
 X7vQ==
X-Gm-Message-State: AOJu0YyLlPxT+fbM0doXwK2Of0IroBwy0mwxb19juR1D+uGuUPvoyUcg
 B28QT8VZI9lYw+ojFipFTEHJxBrdltNPKcGwBY5QweAllQODdU2TGms3ziaQCgNDHCCWNY1+YAx
 X+FKRjLphLvy5F/1x7lCdpGL2SJ8=
X-Gm-Gg: ASbGncvmD6OhgLeCw1aRp5NcHL165+Mb6p9IU8M0xl1CMa8OWYQFSsbac/AMLrUGnRY
 0oL0Kzp1EotI+B3qsr0lap0fWA4NnsxhET1+g3w==
X-Google-Smtp-Source: AGHT+IFsCZjAL4JJPFwB0VxW6m7Gn3kDCYwnecB/rCIR/rtvN6FjyQG0EqIlIVam4/xCL1EDAoUlTPCExhBLNopjd2c=
X-Received: by 2002:a17:90b:2c8c:b0:2ee:b665:12ce with SMTP id
 98e67ed59e1d1-2f548f05913mr19122840a91.1.1737045174038; Thu, 16 Jan 2025
 08:32:54 -0800 (PST)
MIME-Version: 1.0
References: <20250114213157.19de9009@ryz.dorfdsl.de>
 <CADnq5_MFq-OWn7dwTTPPcBbFKQmBHvD6qCi8ngiVumk2V1U40g@mail.gmail.com>
 <20250115160834.033e8aad@ryz.dorfdsl.de> <20250115211039.09e6e69e@zbook>
 <CADnq5_MY+cN0dPTis582HY0a80rNiO86kz9Ha=e=HS2Toim=4w@mail.gmail.com>
 <20250115213511.2feaa331@zbook>
 <CADnq5_MbeTRb642qwb0Q7JbL=2UsnK6RnLm6NWTeVLZOEuyn4A@mail.gmail.com>
 <20250116172916.0dba9ff6@ryz.dorfdsl.de>
In-Reply-To: <20250116172916.0dba9ff6@ryz.dorfdsl.de>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 16 Jan 2025 11:32:42 -0500
X-Gm-Features: AbW1kvZTqj9ioi4cMFcAh5_rdQKk518CxtAuqixA5uCVNFyED7x6AZWiKeu_BNk
Message-ID: <CADnq5_NU-stpay1uFHXD9fVemg4snyE-eZZ4rfyg2Mc3x2OLyg@mail.gmail.com>
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

On Thu, Jan 16, 2025 at 11:31=E2=80=AFAM Marco Moock <mm@dorfdsl.de> wrote:
>
> Am 16.01.2025 um 11:21:11 Uhr schrieb Alex Deucher:
>
> > On Wed, Jan 15, 2025 at 4:02=E2=80=AFPM Marco Moock <mm@dorfdsl.de> wro=
te:
> > >
> > > Am Wed, 15 Jan 2025 15:27:00 -0500
> > > schrieb Alex Deucher <alexdeucher@gmail.com>:
> > >
> > > > On Wed, Jan 15, 2025 at 3:22=E2=80=AFPM Marco Moock <mm@dorfdsl.de>
> > > > wrote:
> > > > >
> > > > > Am Wed, 15 Jan 2025 16:08:34 +0100
> > > > > schrieb Marco Moock <mm@dorfdsl.de>:
> > > > >
> > > > > > I assume it was 6.12.6, but Debian doesn't have the old
> > > > > > packages anymore and it has been purged from my system
> > > > > > already.
> > > > >
> > > > > I've now tried 6.12.6, same situation.
> > > > >
> > > > > Any further ideas what could cause this?
> > > >
> > > > Can you provide more details about what you are seeing?  What
> > > > does `ps aux` or `top` show as using all of the CPU time?
> > >
> > > I saw
> > >    2977 root      20   0       0      0      0 R  99,3   0,0
> > > 5:18.68 kworker/u16:39+amdgpu-reset-dev
> > >
> > > But the system is almost unusable, it takes seconds to print the
> > > characters in terminal when connecting from a remote machine. Local,
> > > the system doesn't care about keyboard anymore, except Sysrq.
> > > Switching to another tty wasn't possible.
> > >
> > > In some cases, even the sysrq keystroke won't be recognized and I
> > > need to use the reset switch on the case.
> >
> > Can you get the dmesg output when this happens?  Might be easier to
> > get it over a remote connection like ssh if possible.
>
> Jan 15 20:40:26 ryz kernel: amdgpu 0000:08:00.0: amdgpu: Dumping IP
> State

I'd like to see the driver messages leading up to that.

Alex

>
> This is the only message that is related to the problem.
> After that are some firewall messages, I doubt that they are useful to
> be posted here.
>
> --
> Gru=C3=9F
> Marco
