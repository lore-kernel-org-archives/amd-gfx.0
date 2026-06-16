Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7422CD98E7
	for <amd-gfx@archiver.kernel.org>; Tue, 16 Jun 2026 12:49:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7194310EB85;
	Tue, 16 Jun 2026 12:49:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=usp.br header.i=@usp.br header.b="AMhZzWEL";
	dkim-atps=neutral
Received: from mail-vk1-f179.google.com (mail-vk1-f179.google.com
 [209.85.221.179])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E3B1510E7B0
 for <amd-gfx@lists.freedesktop.org>; Tue, 16 Jun 2026 02:12:18 +0000 (UTC)
Received: by mail-vk1-f179.google.com with SMTP id
 71dfb90a1353d-59ebde7d704so1365927e0c.2
 for <amd-gfx@lists.freedesktop.org>; Mon, 15 Jun 2026 19:12:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=usp.br; s=usp-google; t=1781575937; x=1782180737; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=1/I+pZwMOrzhrEepnB/LVQxD8E3WFxc/6DwgKc4sW9c=;
 b=AMhZzWELwHT6DhSc+nggUqqDUbeSU9NYjpkNYAW/NYZTqdE/8HJVbJ8AuUS2HalIAJ
 alvqzLUqyLC10/f96sd8WBrkVhoIqjXkkKv55K0asxr104QjnAuRlkfrEOeiWCGGgdyD
 4FWkU3IoTi9QOm+Mb0du5JTp8SlU61lkbdcZLaKayxSoRy2pLyCn8lAJZ+gh1SPyw8HZ
 iOC26baZUzbFRDx0aVycEoiybDy/+LyMjVG5DZuU7SryNq0gIt3KKtxh2Q2pq65gqmpQ
 NAy/shEnDm0yZgbE4IvI7MRMZFmEQJvCOt0v5EAxBgu/uNjnAROM/xdZPJi7/cmYr8bu
 XgRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781575937; x=1782180737;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1/I+pZwMOrzhrEepnB/LVQxD8E3WFxc/6DwgKc4sW9c=;
 b=gB5ARZ2aZk/1xO9jJz9Dqre8+zsyN83IuVXhQgB26biVLg/vdSFiGGlEdbmkGA+XpV
 oMKcNAG/V/C/YJAusNmPRI7uMk1aBohDBALzQnUdFub/2d1txaBtkqt963XUh6wfkVgl
 wt9zkFNoTTP6IZ+nibO6Lj+VF24u5TStaSaePfxZaOSEz1s4PV0w55b4hhWEdMeRjLq5
 lg0/x3/DkxOs4KoWqIDQQSmuW1Cvq87qpz8BzEEImkLc/GPDntBw5+2NPyeO05YB/l1H
 xm/bWE1cUGiVhmLJjfz+WDB+5vnPLsbJD9eBJCi1b59SWBDPf91Y7lrR9IYGcYX2ytNd
 S1Jg==
X-Gm-Message-State: AOJu0Yx4K8ruvXWoIwmZJ67Bfb283zmpsQBPC9W+2GanyL1tIInAvGIW
 nIQyj0RaUnnhRz6eWOEOZqWOQW5dg6HLQvHFdBywI9Gn4uC9YjLheaGVCsTe9PzMkb+pVbEX4QC
 XuOdK
X-Gm-Gg: Acq92OF9aPAOjkuEGK/ll8GtzKVvMHVE3Nl5SDb0pJYel/Ix46ePa67eFq3BjjZkWhx
 8mjx5MSO13Olcvs3pWl0GONIxD6W46Q0xi1gpkUuMFkTeYAooRydA9HExOC3YiFtupUCEC2UuPI
 BGoqu3Sm64FKdBTudSEfxmiqeX0TQby9Az1S1SLxnePa9df/plZiK1046B1uY90K3p/GRrdcsl0
 fxz9NVB3lbBGQeKWxgRDMhXjT93+L+4tf/kv63decKewYgtsDnL0AY1MmquZs3Njcdx5CCOsJZ1
 QuS+Wsz8O6+onB2amYCiiBOOBxvE3/KbtbeBGh6v3c9gr4hMrznv7qYbFw9E+txusT8vt56INsK
 A8PWE6Hyb1gsLwn/2fpBQ9XzkQqRLknZ8qoAxI0babLPU4idNpLAYZgjraDhyLY6gdbApTZOdLT
 bWLXYO2qQHpVPCX68OerzucSr359ZbAJ7KxYmRH5D9DCNHeXCHDDLsRveGIuRqVeht7AHIkqpBf
 24B8o8jBUWFmMAHEg==
X-Received: by 2002:a05:6122:32c5:b0:56e:f071:d4ef with SMTP id
 71dfb90a1353d-5bbadf16a2fmr898972e0c.8.1781575937306; 
 Mon, 15 Jun 2026 19:12:17 -0700 (PDT)
Received: from voyager.. ([179.119.39.86]) by smtp.gmail.com with ESMTPSA id
 71dfb90a1353d-5bb900138e8sm5514855e0c.6.2026.06.15.19.12.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Jun 2026 19:12:16 -0700 (PDT)
From: Tiago Dourado <tiagodourado@usp.br>
To: amd-gfx@lists.freedesktop.org
Cc: luiz.f.f.fernandes@usp.br,
	Tiago Dourado <tiagodourado@usp.br>
Subject: [PATCH RESEND 0/2] drm/amdgpu/jpeg: deduplicate process_interrupt
 across JPEG versions
Date: Mon, 15 Jun 2026 23:08:29 -0300
Message-ID: <20260616020942.18980-1-tiagodourado@usp.br>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 16 Jun 2026 12:49:33 +0000
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

The JPEG versions v3_0 and v5_3_0 have process_interrupt implementations identical to their predecessor versions (v2_0, v5_0_0 respectively). This patchset removes these duplicates by exporting the original functions and reusing them via macro aliases.

Tiago Dourado (2):
  drm/amdgpu/jpeg: deduplicate jpeg_v3_0 process_interrupt
  drm/amdgpu/jpeg: deduplicate jpeg_v5_3_0 process_interrupt

 drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c   |  2 +-
 drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.h   |  4 ++++
 drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c   | 21 ++-------------------
 drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c |  2 +-
 drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.h |  4 ++++
 drivers/gpu/drm/amd/amdgpu/jpeg_v5_3_0.c | 22 +++-------------------
 6 files changed, 15 insertions(+), 40 deletions(-)

-- 
2.43.0

