Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 926EBC3065B
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Jul 2024 06:59:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0D42410E2F6;
	Mon,  1 Jul 2024 06:59:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="m0nnRPyx";
	dkim-atps=neutral
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com
 [209.85.208.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B268D10E155
 for <amd-gfx@lists.freedesktop.org>; Sun, 30 Jun 2024 07:04:17 +0000 (UTC)
Received: by mail-ed1-f48.google.com with SMTP id
 4fb4d7f45d1cf-57cbc66a0a6so1965679a12.1
 for <amd-gfx@lists.freedesktop.org>; Sun, 30 Jun 2024 00:04:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1719731056; x=1720335856; darn=lists.freedesktop.org;
 h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=r+2JhwhhcYmUlONdoqhbMCHdhahLYSDSMnL+ZYEH4CY=;
 b=m0nnRPyxknkeAvh6JnM3YXvQtaD248Ux3fN7lDB89cQmJ0/msaKoCbN7MRyp52F5N/
 j6MNhQCpbEgXkh2f1xMkUjlzTWw9+PfMvZN8FbfSnw4VX3TMvHZaX+MJ73IZi2sG1xu0
 fQnBpFYq0NOnVvLIr83ARBDtIRgR6JmzrdTBX65Ujb9Ysl5UNmJvu6D6lREFH0SpHUkY
 jxlzIhFXCdaPEcp2q4OLkIY1s7Dosbb6rJ2YEqqYFnAvcvyGRSckWw7sLlk7d9nipQ2x
 CE7WZtuUFcASr/UmAcG1uxJRsfExK6fjtSG9RVmchxXdTcsfVkrq2tuJUOppnaERGScG
 AkMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719731056; x=1720335856;
 h=to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=r+2JhwhhcYmUlONdoqhbMCHdhahLYSDSMnL+ZYEH4CY=;
 b=iYOE08ZJaqzHWKeZFlw+mR8nYzZN40qS3rnqfCEGf1FKi7UK7+1gO513dymJ6VKTqQ
 wy5uxBhQSTePi4RufZkQrOQBxrgyfaRRW9P1ioqe8n6m1svm8EB2Du3Ux0UAVmbvWgRB
 r5jpTrzgrhn/ZN0VvF7LXFm/kYs+wMQyUio/ez2PUt+ZO5aZ9pf0HRVM6g/TEBPjgVRO
 4WqxkfZmIt5wfwd9IFNfUfPwOW80ZaTDSVan+iWy9lSVPUM3zPckVpGS+J6zrdztOh4M
 Q/6BRtmBd4apT9D1jijARPn1LBxfLoBC/xoB9YL6YcLJC+Ck+omHPs2A2aSOD3iUz+2w
 CchA==
X-Gm-Message-State: AOJu0YzXIOXRSJU57Kvy11cgaLgj6bE855ZqPFtlFeR2oT3XsE2QsO0b
 KR/alz5q+CgryOXymrZdh7f5nhdNGh1z95CHPp0TWThPZU3OjZcN4VtCy+qmbqbUUkQbnRun3PF
 Hr7RJ5glzMgMn5mx9nVqFsSeDCfiK91n5
X-Google-Smtp-Source: AGHT+IGyvg5ixZr+d3W7Gk5mmoXK3rF3gZ+CgS70uGZizJd1Kw+79hJMVRpfhzulrkaoTFTyAIK3V8eQtFxZLxV/qU0=
X-Received: by 2002:a05:6402:22e3:b0:57c:ff0d:b781 with SMTP id
 4fb4d7f45d1cf-5865d4737cfmr4164202a12.16.1719731055648; Sun, 30 Jun 2024
 00:04:15 -0700 (PDT)
MIME-Version: 1.0
From: Jaroslav Pulchart <jaroslav.pulchart@gmail.com>
Date: Sun, 30 Jun 2024 09:03:59 +0200
Message-ID: <CADVcqdwr1mVW2rtKX7tMLw8o=eRVKS2-1JMy3PQ=maBCU2uH=g@mail.gmail.com>
Subject: High Power Consumption of AMD RX6800xt in Idle with Secondary Monitor
 Connected
To: amd-gfx@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Mon, 01 Jul 2024 06:59:56 +0000
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

Dear AMD GPU Kernel Maintainers,

I am writing to report an issue with high power consumption of my AMD
RX6800xt graphics card when a secondary monitor is connected.

Upon investigation, I observed that my desktop computer generates more
heat while idling. I determined that the high power consumption issue
arises when I connect a secondary monitor to my AMD RX6800xt card,
causing it to consume approximately 40W of power in idle state .

I checked the "GFX Clocks and Power:" in
/sys/kernel/debug/dri/1/amdgpu_pm_info of my RX6800xt during idle, and
here are the findings:

With the secondary monitor connected memory frequency is up and
constantly at 1000MHz:
        1000 MHz (MCLK)
        3 MHz (SCLK)
        1825 MHz (PSTATE_SCLK)
        1000 MHz (PSTATE_MCLK)
        856 mV (VDDGFX)
        45.00 W (average SoC)

Single monitor connected:
        96 MHz (MCLK)
        0 MHz (SCLK)
        1825 MHz (PSTATE_SCLK)
        1000 MHz (PSTATE_MCLK)
        6 mV (VDDGFX)
        8.00 W (average SoC)

The significant difference in power consumption between the two states
indicates a potential issue in power management that needs to be
addressed. Your assistance in resolving this matter would be greatly
appreciated.

Thank you for your attention to this issue.

Best regards,
Jaroslav Pulchart
