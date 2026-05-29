Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81064CD6E43
	for <amd-gfx@archiver.kernel.org>; Fri, 29 May 2026 10:31:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2687010FCAE;
	Fri, 29 May 2026 10:31:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="gTgxvWHi";
	dkim-atps=neutral
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com
 [209.85.128.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DF9DE10FCAE
 for <amd-gfx@lists.freedesktop.org>; Fri, 29 May 2026 10:31:04 +0000 (UTC)
Received: by mail-wm1-f47.google.com with SMTP id
 5b1f17b1804b1-49039a8851fso81584135e9.2
 for <amd-gfx@lists.freedesktop.org>; Fri, 29 May 2026 03:31:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780050663; x=1780655463; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=zHNrS1wNQwomHNLbSiuiF+1bBI2Ez1Q2qSLTpEDvO4M=;
 b=gTgxvWHinVoynOzsh58EuMr+57F74ZXodqsO2IUw6LuldxRrVDUfRN3pozi0RbKwiC
 uBzqI4cQLbjn2jvm4i1U3dUA1Oc/iNmaryVOh1v6qlYOIx2fHL96fzkP6lNt1wF2IcgU
 YPzuN+D8m4bVgCkWcdenPji/QwhSW7aodrvshZZEqW9O036a6pfG/k6lIlczMyXyLju8
 VsWJPuL72e0u0uv1Iwa8U7ZT2AdBnN3+oNjL1aTfzwBeD1ruC5ul7Gd//+EgynYkVU/X
 Rr77cMlS+35V+McC7JSve8qM16s79N1SkklnDe0dvSWIzk48lb5fuHd7JcEPMhQ0wFp+
 OFVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780050663; x=1780655463;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zHNrS1wNQwomHNLbSiuiF+1bBI2Ez1Q2qSLTpEDvO4M=;
 b=Rw0wvXkTSioAsYnv6agDOroamyVj0j+I4CfPtfygsqrN5LZYkmk/pQT5LW8ewmM7nx
 fe/tkCvgQFF12wHL23HHy6bmgje86vBkEAJL3IvMPjWoq0R/TCibn8UwkfacYGh1uVBj
 Z5l/FGdkkIsioSTlaSlTxLTa/xd36pDwXZdEMp4W1Pz2vmOQuWnv9jbtwG+5rbmaYdf2
 BYGRi1hcF9MQl4f9UG723DSBf589P23quFAYz7+00NMMq0d/UWTx5voJsM+uYOBnwlU5
 CR2I+NcXM6r6vwLrOcC7Dp+lxhF2fgxb24v3QNOR4JGaXs3fruXnFJr3qbMsVgXAEmb2
 q02A==
X-Gm-Message-State: AOJu0Yzly+pP5/CYtDyyTa7BlJR4K2sRiaGgIgMyAASt4I04jT2tUXiX
 ZgOUT+BC3uwSmC3L0d+tTG/nzwQJXZhQjPVE1hUKqd3bwKEOJuUuclWA7Y57GrKLHxQ=
X-Gm-Gg: Acq92OEX371UGPhdJna8cxwQQfDL3MsKqqR5zeTzyO/kC0bYepbKfQgeO8X1OT+ptIt
 g9vE527PX1VaIC8eqUw+Sm4sYyD9f5MYyiAHmjVtc1Hi/CXXr4MGa1lD9+JdbR3PsCq7eJRyQVK
 Ksl5IM4hgcmT2N0+bgnDNLtcCz1pPd+yIVRp30pzcW4JehDcwArbcG0LZP1rczywbQJAIRe7wRL
 bdaX1udMI+ruXU1ruNfmOx38EAYY+xNfsxtII8eomkiP6zEH7DntL0rVmv83uOifQv4C1JAcXVm
 u92ZUw/ioGmvY9AywTq3N9tBnVEDrsCXF26PbLNNRIjrc/CyWjavtgYdaxAkUnWPRtMd8uUDWSD
 WWEUPXxyT3QgB2x4qhTBhSqp2XwbIDyjUVzwhH1lT8xca6MEx325OJeBhNQamCVPf0+rrUC1drM
 TWMlWXJOqKi/4B+7OiuTwPtK+dBUtsvw+zHWiFh96scPn9zjs3Mdp8ms51dbfhk9nYoL77NVxqi
 BQ5WS9G82Oytr8Y
X-Received: by 2002:a05:600c:6008:b0:490:44eb:c1e0 with SMTP id
 5b1f17b1804b1-4909c0ac911mr31600065e9.21.1780050663172; 
 Fri, 29 May 2026 03:31:03 -0700 (PDT)
Received: from Timur-Max.c.hoisthospitality.com (184.31.0.109.rev.sfr.net.
 [109.0.31.184]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4909d6a0a89sm40895945e9.7.2026.05.29.03.31.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 May 2026 03:31:02 -0700 (PDT)
From: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
To: amd-gfx@lists.freedesktop.org, Alexander.Deucher@amd.com,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Natalie Vock <natalie.vock@gmx.de>, Amir Shetaia <Amir.Shetaia@amd.com>,
 =?UTF-8?q?Marek=20Ol=C5=A1=C3=A1k?= <maraeo@gmail.com>,
 Mario Limonciello <mario.limonciello@amd.com>
Cc: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
Subject: [PATCH 0/7] drm/amdgpu: Implement retry faults on Navi 4
Date: Fri, 29 May 2026 12:30:52 +0200
Message-ID: <20260529103059.21470-1-timur.kristof@gmail.com>
X-Mailer: git-send-email 2.53.0
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

Implement retry faults on Navi 4 in order to mitigate VM faults.
Based on my previous series (required for correct operation):

* Improve retry fault handling (v2)
* Improve soft IH ring

Solve a race condition between the VM update
performed by amdgpu_vm_handle_fault() and retry_cam_ack()
to make sure the ACK is always done after the VM update.

Adjust soft IH ring size on Navi 4. Note that Navi 4
seems to send the retry fault interrupts on the first
IH ring so they end up being dispatched on the soft
IH ring.

Adjust the PTE flags to make the VM update work correctly
on Navi 4. Without that, the update seems to be stuck in
a cache and can't resolve the fault.

Enable the retry CAM on Navi 4 as well in order to filter
the retry fault interrupts. Change the IH v7.0 code to
use the MMIO based ACK rather than a doorbell.
The doorbell seems to just not work at all on Navi 4
just like it also doesn't work Navi 3.

With this series, the kernel is able to mitigate VM faults
when amdgpu.noretry=0 is specified on the kernel command line.

Timur Kristóf (7):
  drm/amdgpu/vm: Add fence argument to amdgpu_vm_handle_fault()
  drm/amdgpu: ACK the retry CAM after VM update finishes
  drm/amdgpu/ih7.0: Use MMIO ACK instead of doorbell for retry CAM on IH
    7.0
  drm/amdgpu/ih7.0: Use IH_SW_RING_SIZE for soft IH ring instead of
    PAGE_SIZE
  drm/amdgpu/gmc12.0: Use AMDGPU_PTE_IS_PTE flag for init_pte_flags on
    GFX12.0
  drm/amdgpu/vm: Use init PTE flags, and NOALLOC in
    amdgpu_vm_handle_fault()
  drm/amdgpu/gmc12: Pass cam_index to retry fault handler

 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c     | 30 ++++++++++++++++++---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h     |  8 ++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c      | 10 +++++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h      |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c |  2 +-
 drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c      |  8 ++++--
 drivers/gpu/drm/amd/amdgpu/gmc_v12_1.c      |  4 +--
 drivers/gpu/drm/amd/amdgpu/ih_v7_0.c        | 25 +++--------------
 8 files changed, 57 insertions(+), 32 deletions(-)

-- 
2.53.0

