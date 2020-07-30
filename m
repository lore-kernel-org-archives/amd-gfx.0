Return-Path: <SRS0=EB5G=BJ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AA9FC433E1
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Jul 2020 20:04:26 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1FA6D2074B
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Jul 2020 20:04:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cHMYSYeX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1FA6D2074B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 815716E95C;
	Thu, 30 Jul 2020 20:04:25 +0000 (UTC)
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com
 [IPv6:2607:f8b0:4864:20::841])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 462B86E959
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Jul 2020 20:04:24 +0000 (UTC)
Received: by mail-qt1-x841.google.com with SMTP id b25so21320655qto.2
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Jul 2020 13:04:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=b5bcuCJpeW3IczAg1ncwMpvvTD1iDA0cFhsvO4LfUR4=;
 b=cHMYSYeXNfP8PZmWthOLRzbvAeUm4dOmLUvTgKw52eoKDPaDHKj09cFwqQY7WyMBvr
 rnyEC0aHc68fXqrwllIh8WmMnDLmc8iaOwoHh2ihbXnfW+bosuqUozWbcndsSeCCElBz
 zhhCMNj1muCrqftBPpw/oYqTo2UIwLgFhWEJXKHivYaEFqdlz/TGgDqM6Nm3c4XCrSZe
 szbzcdAc97UZDvcr8Svhg6PcjmnY9dbxtICC3/tB+DVs9ZdkfyT7bhx5+uxhIFvIp4Z0
 LyBtTfJD2w0zOwQg1YNKwfzH5exs7XX7VdrcWDhhVMFdW55zn1qLt2Jwd6BHQZGItWxO
 kVVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=b5bcuCJpeW3IczAg1ncwMpvvTD1iDA0cFhsvO4LfUR4=;
 b=p2hM4i93DWEj9c3J58iICF9o+39PwL+Ccd4eNDgnyCXZ+e+tOhQVrTqrJcZ8J2VMra
 1tlHsV9KEKyLn/dRDWwvJp6Mgxti82tJ+I6Qr0vlYlct2h3F/yT8euaLmbW97mvsJ/Jo
 P+8b3AqgxOKtV8J+4bJ9ialalCFNdV4UF0QJdDthewwjyGX4dAqlFLrzx/slXOiMgkiO
 BjucO3dXALik/fkB6dsayFbGR0sIJvwPi+jJishP/Vfrpd36WccRougJmQuNWpPpYsS6
 H2u00kL8oc+wmpWZp/7Seety0hIn9KPtKLuaTy2cRyrqW+EEcGPr2Rf8o4eEnrvWaFsU
 HBtw==
X-Gm-Message-State: AOAM531mpsxGtwDASdq5j8XMC4/iXM2tSeRnENn7xM5/mFrsISGFLK3Q
 aigy2MxcnNpfixAdEElSslISn0Pb
X-Google-Smtp-Source: ABdhPJwKSEeS5PVYRxrNAA8/poyV4YrcjLt3ME9FTXTXpsKfQoUEd/Idq/OetrvL/gBd0gCjHBuffA==
X-Received: by 2002:ac8:7b94:: with SMTP id p20mr348096qtu.312.1596139462208; 
 Thu, 30 Jul 2020 13:04:22 -0700 (PDT)
Received: from localhost.localdomain ([71.219.66.138])
 by smtp.gmail.com with ESMTPSA id d8sm5652757qtr.12.2020.07.30.13.04.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Jul 2020 13:04:21 -0700 (PDT)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 00/17] rework stolen pre-OS fb allocation handling (v3)
Date: Thu, 30 Jul 2020 16:03:57 -0400
Message-Id: <20200730200414.40485-1-alexander.deucher@amd.com>
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
v3: Inline fw vram usage structure

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
  drm/amdgpu: move vram usage by vbios to mman (v2)

 drivers/gpu/drm/amd/amdgpu/amdgpu.h           |  20 +--
 drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.c  |   4 +-
 .../gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c  |   4 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c    |   4 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c |  54 ++++----
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c       |  42 +++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h       |   6 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.c    |   3 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c       |  64 ++++++----
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h       |  17 +++
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c      |   6 +-
 drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c        |  57 ++++-----
 drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c         |   8 +-
 drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c         |  11 +-
 drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c         |  11 +-
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c         | 119 ++++++------------
 16 files changed, 219 insertions(+), 211 deletions(-)

-- 
2.25.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
