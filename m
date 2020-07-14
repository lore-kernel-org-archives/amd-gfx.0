Return-Path: <SRS0=Dt/2=AZ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7225AC433E2
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Jul 2020 18:24:10 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 43F5E223C6
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Jul 2020 18:24:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XQTi96N0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 43F5E223C6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E9B786E5A2;
	Tue, 14 Jul 2020 18:24:09 +0000 (UTC)
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com
 [IPv6:2607:f8b0:4864:20::733])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7C4C36E5A2
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Jul 2020 18:24:08 +0000 (UTC)
Received: by mail-qk1-x733.google.com with SMTP id j80so16542923qke.0
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Jul 2020 11:24:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=bcceYwZ40lTOD+0aqHbMstXn9E8dUqseU9+Gvrz3EVg=;
 b=XQTi96N0mxH2DCD+pG0LjLyzgc+yldSa5bdyAgrVYb64WfqDMSyTsoXS4I6VBakaaq
 5N8HufgC4EDDVWitdrkqiJ++XFVWGt3dXIvWsODvsb+bw/WOTlRMpknK+FqjXFDEXA1V
 /hxJkFyjp3X/ggvcgOAEU27qCMxk4jRxpSDxyqDL+nkEfvcgnLjSodD3kSnX25YqSuej
 nV8NdRVUksHu2IOwlUszNoNBjDVozpjwXFcbpv8GaQojRJ4+aLI+gx4sS29enyVGGvG0
 W7YfDa0hsIyyVRYPmdxnHZ20ggOqEo20C1QH6mB1REudUMPE9lKX33r0WlF6t1pDZXyB
 TfaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=bcceYwZ40lTOD+0aqHbMstXn9E8dUqseU9+Gvrz3EVg=;
 b=bmgVWjVMNv+iZBVkJH8wQS8DceAtpsSzCRmq7rRYxHhF/bTPB43udSGGnbyyxEuOlp
 /CpaE5Kzbn45fA/suLWix+4emO21GShDFoDGURCJ8dTwMvkRWx/gcDKIppDWoc9yYkjA
 JhHc4QUnEZ4DB8QM3fyLTToh5hBSfagt9Iqy8X/VPpEKxkqEoY2rqyvyi+JUVGBZ4zM4
 1f0VtuyVdi/VEuIIHiMIfY++F6VZRGU+8xvl+7YNVpghA6FTe/imtwImo3c/ks2EO+5C
 E3RDtA8cCGaVgR/tAxW+vWAIw5IUofQmMTQ1Oil8r8W//q8WkKdoFYZrivE3tf2BEFSo
 qaTw==
X-Gm-Message-State: AOAM533YjhYUkaybH9kwP3IloOPJpIzvi4/jYePC7E8x300oOyISoupy
 eZUbZSZirrFt43K7m1KXc50n4PuN
X-Google-Smtp-Source: ABdhPJwo6NTp6c2dl+fEqnCOAayRK5iH8VdH/NLXxgd0z2zZAkmrWWp8Lk1DB3EcYdaQBaZ2phaiXg==
X-Received: by 2002:a37:7803:: with SMTP id t3mr5914003qkc.358.1594751047338; 
 Tue, 14 Jul 2020 11:24:07 -0700 (PDT)
Received: from tr4.amd.com (atlvpn.amd.com. [165.204.84.11])
 by smtp.gmail.com with ESMTPSA id d53sm26046456qtc.47.2020.07.14.11.24.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Jul 2020 11:24:06 -0700 (PDT)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 00/42] Navy Flounder support
Date: Tue, 14 Jul 2020 14:23:11 -0400
Message-Id: <20200714182353.2164930-1-alexander.deucher@amd.com>
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

This patch set adds initial support for Navy Flounder GPUs.

Bhawanpreet Lakha (1):
  drm/amd/display: add DC support for navy flounder

Boyuan Zhang (5):
  drm/amdgpu: add navy_flounder vcn firmware support
  drm/amdgpu: add vcn ip block for navy_flounder
  drm/amdgpu: enable VCN3.0 PG and CG for navy_flounder
  drm/amdgpu: enable VCN3.0 DPG for navy_flounder
  drm/amdgpu: enable JPEG3.0 PG and CG for navy_flounder

Chengming Gui (2):
  drm/amdkfd: Support navy_flounder KFD
  drm/amdkfd: Add kfd2kgd_funcs for navy_flounder kfd support

Huang Rui (1):
  drm/amdgpu: expand to add multiple trap event irq id

Jiansong Chen (32):
  drm/amdgpu: add navy_flounder asic type
  drm/amdgpu: add navy_flounder gpu info firmware
  drm/amdgpu: set fw load type for navy_flounder
  drm/amdgpu: set asic family and ip blocks for navy_flounder
  drm/amdgpu/gfx10: add support for navy_flounder firmware
  drm/amdgpu/gmc10: add navy_flounder support
  drm/amdgpu/gfx10: add clockgating support for navy_flounder
  drm/amdgpu/soc15: add support for navy_flounder
  drm/amdgpu: initialize IP offset for navy_flounder
  drm/amdgpu: add support on mmhub for navy_flounder
  drm/amdgpu: add common ip block for navy_flounder
  drm/amdgpu: add gmc ip block for navy_flounder
  drm/amdgpu: add ih ip block for navy_flounder
  drm/amdgpu: add gfx ip block for navy_flounder
  drm/amdgpu: add sdma ip block for navy_flounder
  drm/amdgpu: add virtual display support for navy_flounder.
  drm/amdgpu: force pa_sc_tile_steering_override to 0 for navy_flounder
  drm/amdgpu: add gmc cg support for navy_flounder
  drm/amdgpu/powerplay: add smu support for navy_flounder
  drm/amdgpu: add smu block for navy_flounder
  drm/amdgpu: add psp support for navy_flounder
  drm/amdgpu: add psp block for navy_flounder
  drm/amdgpu: use front door firmware loading for navy_flounder
  drm/amdgpu/gfx10: add gc golden setting for navy_flounder
  drm/amdgpu: enable cp_fw_write_wait for navy_flounder
  drm/amdgpu: enable GFX clock gating for navy_flounder
  drm/amdgpu: support athub cg setting for navy_flounder
  drm/amd/powerplay: set VCN1 pg only for sienna_cichlid
  drm/amdgpu: enable athub/mmhub PG for navy_flounder
  drm/amdgpu: enable mc CG and LS for navy_flounder
  drm/amdgpu: enable hdp CG and LS for navy_flounder
  drm/amdgpu: enable ih CG for navy_flounder

Tao Zhou (1):
  drm/amdgpu: configure navy_flounder gfx according to gfx 10.3

 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c    |  7 ++
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c       |  8 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c     |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c       |  8 ++
 drivers/gpu/drm/amd/amdgpu/athub_v2_1.c       |  1 +
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c        | 76 +++++++++++++++-
 drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c        | 27 ++++--
 drivers/gpu/drm/amd/amdgpu/mmhub_v2_0.c       |  6 ++
 drivers/gpu/drm/amd/amdgpu/navi10_ih.c        |  1 +
 drivers/gpu/drm/amd/amdgpu/nv.c               | 44 ++++++++++
 drivers/gpu/drm/amd/amdgpu/psp_v11_0.c        | 12 ++-
 drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c        | 87 +++++++++++++------
 drivers/gpu/drm/amd/amdkfd/kfd_crat.c         |  1 +
 drivers/gpu/drm/amd/amdkfd/kfd_device.c       | 20 +++++
 .../drm/amd/amdkfd/kfd_device_queue_manager.c |  1 +
 drivers/gpu/drm/amd/amdkfd/kfd_flat_memory.c  |  1 +
 .../gpu/drm/amd/amdkfd/kfd_packet_manager.c   |  1 +
 drivers/gpu/drm/amd/amdkfd/kfd_topology.c     |  1 +
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |  9 +-
 drivers/gpu/drm/amd/powerplay/amdgpu_smu.c    |  1 +
 drivers/gpu/drm/amd/powerplay/inc/smu_v11_0.h |  1 +
 .../drm/amd/powerplay/sienna_cichlid_ppt.c    | 20 +++--
 drivers/gpu/drm/amd/powerplay/smu_v11_0.c     | 15 +++-
 include/drm/amd_asic_type.h                   |  1 +
 24 files changed, 300 insertions(+), 51 deletions(-)

-- 
2.25.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
