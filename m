Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF413CD4F21
	for <amd-gfx@archiver.kernel.org>; Wed, 13 May 2026 17:08:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 267EC10EF93;
	Wed, 13 May 2026 17:08:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="hhzPaDdU";
	dkim-atps=neutral
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com
 [209.85.128.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AD82B10EF93
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 May 2026 17:08:53 +0000 (UTC)
Received: by mail-wm1-f53.google.com with SMTP id
 5b1f17b1804b1-48a563e4ef7so64551745e9.0
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 May 2026 10:08:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778692132; x=1779296932; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=5SEExv/DNWtRSM2cIE4kXWDYnmeTCWFOY79QVR+AhLw=;
 b=hhzPaDdUeZ1c4/RMxaOkw0wg+l+6MtqUKaOb1gsJ5AaHH0CplcPjgyof/VzKiIB6yv
 ov2OrTLvFIUXoeP+JjFur9sy6zj7vV5ZJelgSap1rkAG1RQeRHm261Wqp7Dwcy0CsLQD
 ySez9S41yrlY9rd0d/XVQsE/AA5GSPvpFc9NJN/BvqITqlwZ9NewNzLrs+q2O4SMt+og
 k62nCzd2UySPwCMoTZOQLRahhz+3TA0n0DFeXlioijbGAa/exU/Y+yney67SWMei/dfd
 he+jNMugFJsxNqXNHGmy4SoDsfF9T3iV9mSFMMKAppQ8NsScs+O0Hw1tHnqIh+q6I86K
 iTqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778692132; x=1779296932;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5SEExv/DNWtRSM2cIE4kXWDYnmeTCWFOY79QVR+AhLw=;
 b=hdI/UG3GUbzxbUeIQ2FJ42UEOmVTGKLF4RTYnrHs2DjyT4QK9ID8O4LOrrL8jp/tJi
 XKU/1p4Ajw+fkg0gAZH3ASWjVavzL6w3+J/18BP6RdUJ9SOF/Z75GNiJ96WCXTvKjkOR
 d0Hb/5zifB2Sy3hmqaX11vjh7sm8eBpKOBy2REVoCCwNty9KWVcARzmTnN66yZ8CJ6lR
 fEmX5OUagErmxjXttYeyaAHa5dBixcr5yIQD8RSavYiOHW67PWLlcDtoAGabt7+nl6aW
 qQTIC/zT+HFrmySTvhCFqEkRAXgJWENKrYaSRYTe0zJ5vFLzGyi4q/Q1hQK/CkjRdLQM
 ansA==
X-Gm-Message-State: AOJu0YxDvJOkuE8gIhvigLsYgtmuFPC6eG7MBZtk4qTC0Ixh4DAATZYQ
 fcQNQo0eIIytGPEmr5/UtCACmlKvyuaRGTj8K7Ueqn03vxi7Oe7sUSZh1/00woS8
X-Gm-Gg: Acq92OGX7JMr6w3yQaT74eT93oRbT9GvkKw4/slDc1jnrUzcNqzP4gyZkkcSgFV0kmn
 U4DO2W3RgtZmH09XTve+v7bsUguuf+XmRoZC3TwQvL9ro52x4pxpzDUdjYu7/ZeQvTZk5ZtrI5H
 BC15Ku4j+IaOp0NvIbOMckUgMKwfVR7FtvMB8wO68NmmtZR3A4nPfjrbPgFUmFFHGHWj9sU/Lxn
 vscAGZg60LCE54VL9IZcbflDATYfPYeR4XmX7Hr3TXSGvEd7PfbGApTKe4O3H9RGujGaXOVWze0
 DtOK/QDQTPzHLrZrx0PdYEmnCdXoc64JH4TX99zW98ibBCzOhRy4PjRAB1o1ziI83egZGPCiK3f
 Nny19PwQbRAypfIx0IVb/TI/7PpAzE4tna6RUuCwuITMhengOQRbGgi3Kgu2GEtHK51fEnbDol2
 WG53RPS952D4O0Btxb2uELk0xe+dXvYqN+9tMCTdOi/gvj6LE1cbm7cLTAlQ==
X-Received: by 2002:a05:600c:4fcb:b0:485:9a50:3370 with SMTP id
 5b1f17b1804b1-48fc9a0ebc2mr64857655e9.8.1778692132130; 
 Wed, 13 May 2026 10:08:52 -0700 (PDT)
Received: from Timur-Hyperion (540017BE.dsl.pool.telekom.hu. [84.0.23.190])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48fd64a017esm4339175e9.9.2026.05.13.10.08.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 13 May 2026 10:08:51 -0700 (PDT)
From: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
To: amd-gfx@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>,
 christian.koenig@amd.com,
 =?UTF-8?q?Marek=20Ol=C5=A1=C3=A1k?= <maraeo@gmail.com>,
 Natalie Vock <natalie.vock@gmx.de>, Melissa Wen <mwen@igalia.com>,
 amir.shetaia@amd.com
Cc: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
Subject: [PATCH 0/3] Improve soft IH ring
Date: Wed, 13 May 2026 19:08:46 +0200
Message-ID: <20260513170849.27061-1-timur.kristof@gmail.com>
X-Mailer: git-send-email 2.54.0
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

The soft interrupt handler ring is used in scenarios
when it is beneficial to not process some interrupts
in the interrupt handler of the HW interrupts.

Fix some bugs in the soft IH ring, eg. the kernel should
not access HW registers when working with the soft IH ring
and improve its effectiveness by dispatching it on the
unbound workqueue.

These patches make it more feasible to use the soft IH
ring for handling retry page faults on GPUs that don't
have the filter CAM. The actual retry page fault
improvements are in a separate series.

Timur Kristóf (3):
  amdgpu/ih6.1: Fix minor version
  amdgpu/ih: Don't perturb HW registers when accessing soft IH ring
  drm/amdgpu: Use system unbound workqueue for soft IH ring

 drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c | 2 +-
 drivers/gpu/drm/amd/amdgpu/ih_v6_0.c    | 7 +++++++
 drivers/gpu/drm/amd/amdgpu/ih_v6_1.c    | 9 ++++++++-
 drivers/gpu/drm/amd/amdgpu/ih_v7_0.c    | 7 +++++++
 drivers/gpu/drm/amd/amdgpu/navi10_ih.c  | 4 ++++
 5 files changed, 27 insertions(+), 2 deletions(-)

-- 
2.54.0

