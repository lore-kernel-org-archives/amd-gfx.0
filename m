Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2905ED10F4D
	for <amd-gfx@archiver.kernel.org>; Wed, 26 Nov 2025 13:30:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C4F8410E606;
	Wed, 26 Nov 2025 13:30:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="AMiZnR0U";
	dkim-atps=neutral
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com
 [209.85.221.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 413E110E5B5
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 Nov 2025 13:30:06 +0000 (UTC)
Received: by mail-wr1-f47.google.com with SMTP id
 ffacd0b85a97d-429ce7e79f8so3780124f8f.0
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 Nov 2025 05:30:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1764163805; x=1764768605; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CJh1lNRRxh8U9ANEhX+DCAlG9FWatka88uZRWrX9NKo=;
 b=AMiZnR0UTetCX4iMA/K26+TqToINOMAqXkC1L0ZtBGNO1qzDDrZag9CAL9CzjY08PV
 bWRXN4drkb5HqbliumcQM5g8PZnf0yDFcowVYpiw+Jpfs/1ZCgoVEcVIZOMhRaJVwcns
 zkpCM01NrKq0U5NMRjNjfu+9ehtczhd6pvvwrEwTVmInYXwIj27NwudsOjqb+16pXjrP
 vSbOGzsyt4Ld7KppDZuDG6jEiEjll7ksodgq+8YK2R6nuGfNGzu5vIpdNbqBdrkS3jtE
 U/Rw5Sy+ST65CFY4gg3x3YIDJFFRS5M2ZateFCFTq4RFUBW3vlmQUTJo/fZZBLLSBZkt
 2lWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764163805; x=1764768605;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=CJh1lNRRxh8U9ANEhX+DCAlG9FWatka88uZRWrX9NKo=;
 b=s9jYMT0jqdSckOAKEJyVLrxE3+txEv67AJMW/c8S2C5ie+eKqtPYTMcLtTxgCOxI3O
 YV4e5Lhku5oHoC1tL6sDuu/B0u9Bu1Mj/X1tF5pEiJ59msP+5CyjsywWu8QoMV8Wo+/X
 LGR4dza16UM2eQut90muR3RQchJlqZetGJO3MOTttJ/3shDm0PW1TEOW9r9Rd+wY/b0D
 HP2e+x3A7xLseLRkGp4IMD4Hh5N2txuXGcMEBneFfRhPfmBLMg4p+msQrLGHTCYoIQlc
 L1hdPHWsXyGMjBqBx37PSDepLOydOtA1TlWWJ5QsGEZuFuPbHlA9cODn7aEY7hxEt/NX
 lbaA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXdHxEgJYRh6hMEaNUSqTf5Wqz7usRULuiNh+pCC2jQ5HabUGQK+8x0mfdFOdYEjGabiUAtZmOV@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxYs7Pb9XAAxn54CK6pG46XK1tgoRUJVoyal9e7/PjgWfKDvZut
 WN0tmtfgd7RzkDodq3sWro6nSfBrPcrJB1NhSxYKEQmWgQHiSuQBi7fy
X-Gm-Gg: ASbGncu2wpqnUdNeZ2o5kBc50mozahVXSrWEyGx6KaCrW+JzwNWFwzpLSlhNf3yiFyc
 77oE4x2rKfCNhhpJATYM3PWNrRW/rYJhPmGbbO2ZidkAPJSljh9U7aZHFu3eHsu0jnUOua49Fv9
 ZDa7XhIXvDTHVe4BIw4j4t3V2HxtNonujHepKhK8nS3un3pdufNDvsqgpKjqjH3BfjBNOgWLFcw
 ZCOxAZsEPcpKG9YMdjBMBCKgULcfQRJz6JxPibvluKAygx4zgx0Rzu+cje13RKPrHeAk+BgJ76i
 lQbfiqaVnmNkLX91GcRLo3LstxoaXT6Rj44EsfCYIHWTuVK1k5fZJHoXa0pu0ACNnk6Ef6VtFs9
 5t9/Eg9rc3wWX/sNhw3k3wtiMCzN2T1NJz6zK0JIgzHLxETDaByLC+Y/kB+OcJFGItLr+v0Y2eY
 yiL7UuQLelB4XFs2dHe6+uZoTQdvai3Bl4onG/emATi3OEWM8lgC0whn9dMzpZ1qvryCqcdas5+
 i/rPPeGfmEeeNuyOO4=
X-Google-Smtp-Source: AGHT+IH/+lp11zEHFHCJZd3m2JDFNfe/49o29/NHWXa8lx1BwAytEC/4VKwJb80LZZ/2Fql83q4F4g==
X-Received: by 2002:a05:6000:2dc3:b0:42b:2e94:5a8f with SMTP id
 ffacd0b85a97d-42e0f35913amr6647228f8f.52.1764163804551; 
 Wed, 26 Nov 2025 05:30:04 -0800 (PST)
Received: from Timur-Hyperion.home
 (20014C4E24D8E6005908B7D279C7B6B2.dsl.pool.telekom.hu.
 [2001:4c4e:24d8:e600:5908:b7d2:79c7:b6b2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42cb7f2e454sm40537696f8f.2.2025.11.26.05.30.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Nov 2025 05:30:04 -0800 (PST)
From: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
Cc: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
Subject: [PATCH 09/10] drm/amdgpu/gmc7: Delegate VM faults to soft IRQ handler
 ring
Date: Wed, 26 Nov 2025 14:29:51 +0100
Message-ID: <20251126132952.150452-10-timur.kristof@gmail.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251126132952.150452-1-timur.kristof@gmail.com>
References: <20251126132952.150452-1-timur.kristof@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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

On old GPUs, it may be an issue that handling the interrupts from
VM faults is too slow and the interrupt handler (IH) ring may
overflow, which can cause an eventual hang.

Delegate the processing of all VM faults to the soft
IRQ handler ring.

As a result, we spend much less time in the IRQ handler that
interacts with the HW IH ring, which significantly reduces the
chance of hangs/reboots.

Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
index 0e5e54d0a9a5..fbd0bf147f50 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
@@ -1261,6 +1261,12 @@ static int gmc_v7_0_process_interrupt(struct amdgpu_device *adev,
 {
 	u32 addr, status, mc_client, vmid;
 
+	/* Delegate to the soft IRQ handler ring */
+	if (adev->irq.ih_soft.enabled && entry->ih != &adev->irq.ih_soft) {
+		amdgpu_irq_delegate(adev, entry, 4);
+		return 1;
+	}
+
 	addr = RREG32(mmVM_CONTEXT1_PROTECTION_FAULT_ADDR);
 	status = RREG32(mmVM_CONTEXT1_PROTECTION_FAULT_STATUS);
 	mc_client = RREG32(mmVM_CONTEXT1_PROTECTION_FAULT_MCCLIENT);
-- 
2.51.1

