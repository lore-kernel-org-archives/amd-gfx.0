Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28E91C433EF
	for <amd-gfx@archiver.kernel.org>; Sat,  5 Feb 2022 09:47:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BB9FD10F50F;
	Sat,  5 Feb 2022 09:47:26 +0000 (UTC)
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com
 [IPv6:2607:f8b0:4864:20::b35])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B4B1310F50F
 for <amd-gfx@lists.freedesktop.org>; Sat,  5 Feb 2022 09:47:25 +0000 (UTC)
Received: by mail-yb1-xb35.google.com with SMTP id v47so746407ybi.4
 for <amd-gfx@lists.freedesktop.org>; Sat, 05 Feb 2022 01:47:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:from:date:message-id:subject:to;
 bh=FpyAySwvrObMCbcWam2B2wOWheB6L6Tz7J9kt9VATec=;
 b=k0TesdSxTmPKCq8fPQ/s7cjofAHeVD3ZJg4haKHc1/vCTEWtYUCKUHh9VxMlFaq/hB
 ZYPXFPIKreffHkVJK7wCN6JMKPqAuJZJf7GXl0ae/rF7B535Rubv3d6p85G6Z4WTltix
 gpIDy3PhELBb+CTCS3QLWxj4ufxdusH8+9bEkI4nilSRhJrWKnTvPh8sywrUKVSjdH1O
 UvDo/QUM6zHFvgkUSXstMRUOQEhrTqTUTcXh6gHJa7tWaJmkvWg2L5W/1QUWHIiT+IH+
 vt2NmjLmxwdFqu1VbMBJf9Rpn28N0wMiO2OVXRMHFAt/L9imOgC3JpF/HrGCYLXg7MgV
 Rrxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
 bh=FpyAySwvrObMCbcWam2B2wOWheB6L6Tz7J9kt9VATec=;
 b=d4uBU11lmWOuUuI+pSJVlgjfpPQuCo8etKJ75Wo/6p9Af/joAXL939lcaeERbhm234
 5CaG10f2vrgFjiByYqL7Ch7dz3Iqv6t6tfr9ZuvMRacVVyRBa7h0tyB1dcSuP4YUMitU
 ICxRrsdAk583YK0ztS3cIUaA7WRYyHMEQNDe8kbaSMHzNu/LkSr8vKiUQEn2/w+PwgVb
 IA4zkMoOzERNwejnZWNMm4/cpszJ559gm+oQYUmKuMTNayxCV2YOetny10DIKm2OjXXK
 gOY9BMLRCRMB8fkGlhRB0rIYkpSCHrow3ot/VgcnDqLdqIvl5/RkQ+mu4Acah8AFCIb4
 CEwA==
X-Gm-Message-State: AOAM530qVSkUremo6RclDRec9ROe0AYbUHxBVY1zpoKSiy4zY59Jy3wg
 WRp1CDPa3Cqn8hRohedVV6Rww/lc/CACMjfSz9cjZcGhjZU=
X-Google-Smtp-Source: ABdhPJwFXuaYP+UsJMQk26mJfJcxcaX2yPpYNkL/lZR0Xi6rPqjlEvbvC8eYtLKyBn5kE4pZfJkwc+vy7XVde19ZP6o=
X-Received: by 2002:a25:202:: with SMTP id 2mr2758967ybc.442.1644054444656;
 Sat, 05 Feb 2022 01:47:24 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a05:7000:8683:0:0:0:0 with HTTP; Sat, 5 Feb 2022 01:47:24
 -0800 (PST)
From: Amol <suratiamol@gmail.com>
Date: Sat, 5 Feb 2022 15:17:24 +0530
Message-ID: <CA+nuEB_u4G-Nf_nHODoY86anP6s0vRyh=0-yPxphbksbCPJ1Yg@mail.gmail.com>
Subject: Minimal GPU setup
To: amd-gfx@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
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

Hello,

I am learning to program Radeon HD 7350 by reading the radeon
driver source in Linux, and the guides/manuals from AMD.

I understand the general flow of initialization the driver performs. I
have also been able to understand and re-implement the ATOM
BIOS virtual machine.

I am trying to program the device up from scratch (i.e. bare-metal).
Do I need to perform all those steps that the driver does? Reading
the evergreen_gpu_init function is demotivating; it initializes many
fields and registers which I suspect may not be required for a minimal
setup.

Is posting the BIOS and loading the microcode enough to get me started
with running basic tasks (DMA transfers, simple packet processing, etc.)?

Thanks,
Amol
