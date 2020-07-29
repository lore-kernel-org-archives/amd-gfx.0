Return-Path: <SRS0=V/Q8=BI=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C64BC433DF
	for <amd-gfx@archiver.kernel.org>; Wed, 29 Jul 2020 17:34:49 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 00A05207F5
	for <amd-gfx@archiver.kernel.org>; Wed, 29 Jul 2020 17:34:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jtf4Vq6W"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 00A05207F5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 87A206E5BD;
	Wed, 29 Jul 2020 17:34:48 +0000 (UTC)
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com
 [IPv6:2607:f8b0:4864:20::743])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8453F6E5BD
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 Jul 2020 17:34:47 +0000 (UTC)
Received: by mail-qk1-x743.google.com with SMTP id b79so22977303qkg.9
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 Jul 2020 10:34:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=JVgnZa1DWrUCR5Vysp+6H62/RqpUH7nebFFSu7sqxoE=;
 b=jtf4Vq6WFBrOBFzPP6WGfzAYRxEhMjE8jGszfc16+EUm1miamjL1+kqOPDqlY4hRrF
 tsTRtRDE7SQj6WPkiGsfLfo3EC/rzzJolatwTneLwr163/d42q9FeBhM1EMwZ9/hrpP+
 RjT5ooI9YlB6lDo1Tm1qDrjpkVeqVn7ZezCCSzuKkrgVNeMicCQPCq6gBYdnRedKLF1x
 W3gQQBJ/NWNZek3Bqg/8CCj5yMVHetMbdx9s1Oi3MqOhx9v09tB605Ie/T7kcF5hXdGC
 1R8y+OKGdosvkaejh6BYbxFG/9rzjkScHJNHA8KRGp1esRwiT7w0g7k3/ZlyNknlcLND
 EgGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=JVgnZa1DWrUCR5Vysp+6H62/RqpUH7nebFFSu7sqxoE=;
 b=n9K7FU3Y0+CBs+mfX0F4FfIrLSFgIFcoXOsYqkKuHryoDyvXIA5vcHTVdldV7EX60O
 xiW4ks47VT97W9C/eFxmPRwGjxwgcIoUzkE4HftWIOgU6hlavPR+jCSk2GoSzN5ClO3G
 U3Z/ZLHtxDGoyRSrQCROku+Lae8VF3BUfz/EcR18s1HPqvu9arg0lPhtLYKtmUjsQn9R
 J710xHINuKsWLpY9CkfeuTZEeg0EECor5Em2JPFAMTNutXvd38k0ULpMpl9Amx944xFq
 NeM9l2521DqkMF7PYhRC4zJcBVQW3+TbrzdjqQY0Jf8d2Rkrg+aVoLe8tPI57g71LwYc
 rYwg==
X-Gm-Message-State: AOAM533TPNsxPUfAUWkgieuUBbBwd3Gw3vmkBn2ZayHCUPPk3nx9Kyr8
 /Yj+9QmAE+jdwgE83CfxJs/4LBZs
X-Google-Smtp-Source: ABdhPJzEdn1p7zcYERRSrRVtGEEFQ9/YToPQFwOX50llQgBPABbmOHhZzQqG+5LbAkRQ18fwuwDUrA==
X-Received: by 2002:a05:620a:a51:: with SMTP id
 j17mr34793849qka.379.1596044086311; 
 Wed, 29 Jul 2020 10:34:46 -0700 (PDT)
Received: from localhost.localdomain ([71.219.66.138])
 by smtp.gmail.com with ESMTPSA id z72sm2132956qka.107.2020.07.29.10.34.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Jul 2020 10:34:45 -0700 (PDT)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 00/17] rework stolen pre-OS fb allocation handling (v2)
Date: Wed, 29 Jul 2020 13:34:22 -0400
Message-Id: <20200729173439.3698-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
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
Cc: Alex Deucher <alexander.deucher@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Split the allocations into two so we can still support the S3
workarounds required on some platforms while also avoiding
any artifacts when transitioning from bios to driver.

In the future we could integrate handling of the ip discovery
data and other vbios allocations into this helper function
to consolidate handling of all of the vbios reservations.

v2: Check if bo object is NULL rather than checking size
    Move all vbios/firmware allocations into mman structure

Alex Deucher (17):
  drm/amdgpu: handle bo size 0 in amdgpu_bo_create_kernel_at (v2)
  drm/amdgpu: use create_at for the stolen pre-OS buffer
  drm/amdgpu: use a define for the memory size of the vga emulator
  drm/amdgpu: move stolen vga bo from amdgpu to amdgpu.gmc
  drm/amdgpu: move keep stolen memory check into gmc core
  drm/amdgpu: add support for extended stolen vga memory
  drm/amdgpu/gmc: add new helper to get the FB size used by pre-OS
    console
  drm/amdgpu/gmc6: switch to using amdgpu_gmc_get_vbios_allocations
  drm/amdgpu/gmc7: switch to using amdgpu_gmc_get_vbios_allocations
  drm/amdgpu/gmc8: switch to using amdgpu_gmc_get_vbios_allocations
  drm/amdgpu/gmc9: switch to using amdgpu_gmc_get_vbios_allocations
  drm/amdgpu/gmc10: switch to using amdgpu_gmc_get_vbios_allocations
  drm/amdgpu: drop the CPU pointers for the stolen vga bos
  drm/amdgpu/gmc: disable keep_stolen_vga_memory on arcturus
  drm/amdgpu: move stolen memory from gmc to mman
  drm/amdgpu: move IP discovery data to mman
  drm/amdgpu: move vram usage by vbios to mman

 drivers/gpu/drm/amd/amdgpu/amdgpu.h           |  20 +--
 drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.c  |   4 +-
 .../gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c  |   4 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c    |   4 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c |  54 ++++----
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c       |  42 +++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h       |   6 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.c    |   3 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c       |  64 ++++++----
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h       |  24 ++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c      |   6 +-
 drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c        |  57 ++++-----
 drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c         |   8 +-
 drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c         |  11 +-
 drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c         |  11 +-
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c         | 119 ++++++------------
 16 files changed, 226 insertions(+), 211 deletions(-)

-- 
2.25.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
