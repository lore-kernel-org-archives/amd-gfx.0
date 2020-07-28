Return-Path: <SRS0=z2P7=BH=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D079C433E3
	for <amd-gfx@archiver.kernel.org>; Tue, 28 Jul 2020 22:46:35 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D1629207E8
	for <amd-gfx@archiver.kernel.org>; Tue, 28 Jul 2020 22:46:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EahJGeOt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D1629207E8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 72FD96E42B;
	Tue, 28 Jul 2020 22:46:34 +0000 (UTC)
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com
 [IPv6:2607:f8b0:4864:20::731])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 20C686E42B
 for <amd-gfx@lists.freedesktop.org>; Tue, 28 Jul 2020 22:46:33 +0000 (UTC)
Received: by mail-qk1-x731.google.com with SMTP id u64so20390320qka.12
 for <amd-gfx@lists.freedesktop.org>; Tue, 28 Jul 2020 15:46:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=tSvVyydIDc42wIs5fafISeJb61IfSNb+wv4+9iqvlF8=;
 b=EahJGeOtMFEX2Tjb+VdEGzSSQnTcrow66JRK3P5+0W5YCi5twq4BSFV0Ep4B3VkEDF
 FDQFt14xGk3diLPu+Pdbq+vswOXeOzOzEzAyPCILncmV3vdChiT+hS9GCG0q7vo5dt33
 AcvEquc3oTBI+3hTmC9rla4liLqHrV1UNMPKK/X/TYNRHD57zjVTfUf1i1PkLVgdOKR4
 OZLOsihqs1w3eiprrU9i3ctUvdMxlLsmRdItjczTaobsNzuKEMnUtKI5xoQ0mc/EHHus
 TxNWFctA3j+k1vMi4/nNeXIlIzpalfEEeZP574ndwI/qa5dWURdzTLoynzP+QGn8+saD
 mToA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=tSvVyydIDc42wIs5fafISeJb61IfSNb+wv4+9iqvlF8=;
 b=bAx15DI8kGnq8hSp9O37IMXzCG/eAB/dOqPWbM1rl6VdG2pqpILaut+vlLEvuRtJHL
 Qaj4Me1O9O5122aMq+G07msJTRQIH8PapsI4pyA4trrPcwhJEIb9gX6sn2zrVMX2PkWH
 +ff1+6SDUwIGF9ffu1472WTt48pLp88+TN6X2i61idiJi+CE2hAc3x4J2Iz+M/RM69hl
 mPaoPtPWU8czom45fqFKKpX+kpRXwY3qi9mNhK08XJmsdouGxYOx1elosVg/a7uBQ4LB
 iKCbNxicwnCsfaMVFoB1BDQz+kn5jxX3kJNLtfRBoDoKLkz3ZPk78+/0qN3BS6C+Fie7
 RXZA==
X-Gm-Message-State: AOAM532MSk66fUAJxtaXSg6iUETZBS8CSRtAgbvergQSFoIj+XNyCs1B
 lAHFSrT5G3JEnZczWR+Rf0Rug2Mt
X-Google-Smtp-Source: ABdhPJxJY1OimaDwHc62i7IPavijl+fz0hmeNim4yvXYb/JIg7HkDeSl3p0fhRxRbJP+cAjMh2O2kw==
X-Received: by 2002:a37:8f07:: with SMTP id r7mr8665312qkd.480.1595976391985; 
 Tue, 28 Jul 2020 15:46:31 -0700 (PDT)
Received: from localhost.localdomain ([71.219.66.138])
 by smtp.gmail.com with ESMTPSA id o17sm189233qtr.13.2020.07.28.15.46.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Jul 2020 15:46:31 -0700 (PDT)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 00/14] rework stolen pre-OS fb allocation handling
Date: Tue, 28 Jul 2020 18:45:51 -0400
Message-Id: <20200728224605.3919-1-alexander.deucher@amd.com>
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

Alex Deucher (14):
  drm/amdgpu: handle bo size 0 in amdgpu_bo_create_kernel_at
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

 drivers/gpu/drm/amd/amdgpu/amdgpu.h        |   3 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c    |  42 ++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h    |  11 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.c |   5 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c    |  24 +++--
 drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c     |  57 +++++-----
 drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c      |   8 +-
 drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c      |  11 +-
 drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c      |  11 +-
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c      | 119 +++++++--------------
 10 files changed, 153 insertions(+), 138 deletions(-)

-- 
2.25.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
