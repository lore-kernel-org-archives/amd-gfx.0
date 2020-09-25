Return-Path: <SRS0=B05q=DC=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D666C4727F
	for <amd-gfx@archiver.kernel.org>; Fri, 25 Sep 2020 20:11:04 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 09B0A2399A
	for <amd-gfx@archiver.kernel.org>; Fri, 25 Sep 2020 20:11:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J7SuxsXF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 09B0A2399A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4813B6ED23;
	Fri, 25 Sep 2020 20:11:03 +0000 (UTC)
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com
 [IPv6:2607:f8b0:4864:20::f2e])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 403ED6ED13
 for <amd-gfx@lists.freedesktop.org>; Fri, 25 Sep 2020 20:11:01 +0000 (UTC)
Received: by mail-qv1-xf2e.google.com with SMTP id b13so2054120qvl.2
 for <amd-gfx@lists.freedesktop.org>; Fri, 25 Sep 2020 13:11:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=sBvxums6/a8+l1eKM8bdLlDX0A7LB+J/A8Vioh5J4ds=;
 b=J7SuxsXFu7MGKcEYXYL6EFmtk85Q+ygSN9N8mDAHNX4ra2qyf9s6sCthXpHDOde7uN
 G6vD9rtflMi4xbxdHuNM3laa5XrdoRvEG8hvkn5WJPrHUH2NCoGzUO632Q3nVSCbickH
 utyw59m4lbEzyKGUNpihXAxDYJHr0DHXozm50xeU/dFR+a8wlJO/p0GKtCBPZLqdYkaP
 ciMM2vAJX+cJEAPNHCotfEI8WlWNbwv0zPjmhw6ZDTDOVdcvhMr8pAaRheJzmv3vj+qi
 N1ShkczmtDVjA1DBnJRYCkJpZlna1GuY9sjaERLE9eUm9fJQHDDh+njWXfoK60u1rP5j
 zAqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=sBvxums6/a8+l1eKM8bdLlDX0A7LB+J/A8Vioh5J4ds=;
 b=fygevoz4gnWWRH7/S0Esiis8B2jfkyGwIBj08TvSarzeLfY/4bI+Zb+J4IPst066xT
 Mk5ql8QTH3wWmRrDkPZg4fYBvXavU3O1+dsKyocN0WPloiS+5PL47IEdBhhPycEKwByS
 lrAMWAQdwDKtsPNaisrgBvSP0JA7Zz3zxxDI7p9kEJ2G/jjUDyWh3EYUIdFYFJCQqMSw
 XYb3yimJNIGvUOZoNjoEw+9yE0djmUa6vhevMUyQ2Bb47EvcRZz3a1mq/SphxQenuvxU
 yxProrAvGyz770VPRfvfbV+PeLqFfDcXu04LRwkvD1cRZ8zzlrbjmAvFSWV+LEkNXM6T
 6BLA==
X-Gm-Message-State: AOAM532nZTeIBTqn3UhQODH4qZgZM7ggNZ9mPqY/icqfybd5qzu3WO1w
 l0keJrK7jSDcSI3mDihaAvIvouZpTxU=
X-Google-Smtp-Source: ABdhPJy/rGYY/+gAAWg+NKAKB9CQ0qxxFCDPt9VHIe4GjehBhUbGYlkqjJtcdBExONuce/uq3Jg9rw==
X-Received: by 2002:a0c:b902:: with SMTP id u2mr331362qvf.7.1601064658735;
 Fri, 25 Sep 2020 13:10:58 -0700 (PDT)
Received: from tr4.amd.com (atlvpn.amd.com. [165.204.84.11])
 by smtp.gmail.com with ESMTPSA id m67sm2301237qkf.98.2020.09.25.13.10.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Sep 2020 13:10:58 -0700 (PDT)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 00/45] Add support for vangoh
Date: Fri, 25 Sep 2020 16:09:45 -0400
Message-Id: <20200925201029.1738724-1-alexander.deucher@amd.com>
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

This patch set adds initial support for vangoh, a new GPU from
AMD.  I did not send out the register header change due to size.
The full patch set is available in git here:
https://cgit.freedesktop.org/~agd5f/linux/log/?h=amd-staging-drm-next-vangogh


Alex Deucher (3):
  drm/amdgpu/gfx10: add updated register offsets for VGH
  drm/amdgpu: IP discovery table is not ready yet for VG
  drm/amdgpu/mmhub2.3: print client id string for mmhub

Huang Rui (32):
  drm/amdgpu: add vangogh asic header files (v2)
  drm/amdgpu: add van gogh asic_type enum (v2)
  drm/amdgpu: add uapi to define van gogh series
  drm/amdgpu: add van gogh support for gpu_info and ip block setting
  drm/amdgpu: add vangogh_reg_base_init function for van gogh
  drm/amdgpu: add nv common ip block support for van gogh
  drm/amdgpu: skip sdma1 in nv_allowed_read_registers list for van gogh
    (v2)
  drm/amdgpu: add van gogh support for ih block
  drm/amdgpu: use gpu virtual address for interrupt packet write space
    for vangogh
  drm/amdgpu: add uapi to define van gogh memory type
  drm/amdgpu: update new memory types in atomfirmware header
  drm/amdgpu: get the correct vram type for van gogh
  drm/amdgpu: add gmc v10 supports for van gogh (v3)
  drm/amdgpu: set fw load type for van gogh
  drm/amdgpu: add gfx support for van gogh (v2)
  drm/amdgpu: add gfx golden settings for vangogh (v3)
  drm/amdgpu: add sdma support for van gogh
  drm/amdgpu: set ip blocks for van gogh
  drm/amdkfd: add Van Gogh KFD support
  drm/amdgpu: add mmhub v2.3 for vangogh (v4)
  drm/amdgpu: add pcie port indirect read and write on nv
  drm/amdgpu: add nbio v7.2 for vangogh (v2)
  drm/amd/powerplay: partially enable swsmu for vangogh
  drm/amd/powerplay: add vangogh ppt into swSMU
  drm/amdgpu: add smu ip block for vangogh
  drm/amdgpu: add TOC firmware definition
  drm/amdgpu: add TOC firmware support for apu (v2)
  drm/amdgpu: enable psp support for vangogh
  drm/amdgpu: disable gfxoff on vangogh for the moment (v2)
  drm/amdgpu: add gfx power gating for gfx10
  drm/amdgpu: enable gfx clock gating and power gating for vangogh
  drm/amdgpu: add van gogh pci id

Roman Li (3):
  drm/amdgpu/atomfirmware: Add edp and integrated info v2.1 tables
  drm/amd/display: Add dcn3.01 support to DC
  drm/amd/display: Add dcn3.01 support to DM

Thong Thai (1):
  drm/amdgpu: enable vcn3.0 for van gogh

Xiaojian Du (6):
  drm/amdgpu/powerplay: add new smu messages and feature masks for
    vangogh (v2)
  drm/admgpu/powerplay: add smu v11.5 driver interface header for
    vangogh
  drm/amdgpu/powerplay: add smu v11.5 firmware header for vangogh (v2)
  drm/amdgpu/powerplay: add smu v11.5 smc header for vangogh
  drm/amdgpu/powerplay: add vangogh asic name in smu v11 (v2)
  drm/amdgpu/powerplay: add smu initialize funcitons for vangogh (v2)

 drivers/gpu/drm/amd/amdgpu/Makefile           |      5 +-
 .../gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c  |      4 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c    |     11 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c       |      3 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c       |     11 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_nbio.h      |      2 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.c    |      1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c       |     37 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h       |      7 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c     |      1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c       |      8 +
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c        |    109 +-
 drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c        |     43 +-
 drivers/gpu/drm/amd/amdgpu/mmhub_v2_3.c       |    589 +
 drivers/gpu/drm/amd/amdgpu/mmhub_v2_3.h       |     28 +
 drivers/gpu/drm/amd/amdgpu/navi10_ih.c        |      6 +-
 drivers/gpu/drm/amd/amdgpu/nbio_v7_2.c        |    341 +
 drivers/gpu/drm/amd/amdgpu/nbio_v7_2.h        |     32 +
 drivers/gpu/drm/amd/amdgpu/nv.c               |     74 +-
 drivers/gpu/drm/amd/amdgpu/nv.h               |      1 +
 drivers/gpu/drm/amd/amdgpu/psp_v11_0.c        |     38 +-
 drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c        |     10 +
 drivers/gpu/drm/amd/amdgpu/vangogh_reg_init.c |     51 +
 drivers/gpu/drm/amd/amdkfd/kfd_crat.c         |      5 +
 drivers/gpu/drm/amd/amdkfd/kfd_device.c       |     20 +
 .../drm/amd/amdkfd/kfd_device_queue_manager.c |      1 +
 drivers/gpu/drm/amd/amdkfd/kfd_flat_memory.c  |      1 +
 .../gpu/drm/amd/amdkfd/kfd_packet_manager.c   |      1 +
 drivers/gpu/drm/amd/amdkfd/kfd_topology.c     |      1 +
 drivers/gpu/drm/amd/display/Kconfig           |      9 +
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |     26 +
 drivers/gpu/drm/amd/display/dc/Makefile       |      4 +
 .../drm/amd/display/dc/bios/bios_parser2.c    |    187 +
 .../display/dc/bios/command_table_helper2.c   |      6 +-
 .../gpu/drm/amd/display/dc/clk_mgr/Makefile   |     10 +
 .../gpu/drm/amd/display/dc/clk_mgr/clk_mgr.c  |     21 +-
 .../display/dc/clk_mgr/dcn301/dcn301_smu.c    |    241 +
 .../display/dc/clk_mgr/dcn301/dcn301_smu.h    |    164 +
 .../display/dc/clk_mgr/dcn301/vg_clk_mgr.c    |    834 +
 .../display/dc/clk_mgr/dcn301/vg_clk_mgr.h    |     43 +
 .../gpu/drm/amd/display/dc/core/dc_resource.c |     14 +
 drivers/gpu/drm/amd/display/dc/dce/dce_abm.h  |     18 +-
 .../drm/amd/display/dc/dce/dce_clock_source.c |     18 +
 .../drm/amd/display/dc/dce/dce_clock_source.h |     29 +
 .../gpu/drm/amd/display/dc/dce/dce_hwseq.h    |    191 +-
 .../amd/display/dc/dcn10/dcn10_link_encoder.h |     18 +
 .../drm/amd/display/dc/dcn30/dcn30_hubbub.c   |     11 +
 .../drm/amd/display/dc/dcn30/dcn30_hubbub.h   |      3 +
 .../gpu/drm/amd/display/dc/dcn30/dcn30_hubp.h |      5 +
 .../drm/amd/display/dc/dcn30/dcn30_resource.c |      2 +-
 .../drm/amd/display/dc/dcn30/dcn30_resource.h |      5 +
 .../gpu/drm/amd/display/dc/dcn301/Makefile    |     47 +
 .../drm/amd/display/dc/dcn301/dcn301_dccg.c   |     75 +
 .../drm/amd/display/dc/dcn301/dcn301_dccg.h   |     65 +
 .../dc/dcn301/dcn301_dio_link_encoder.c       |    192 +
 .../dc/dcn301/dcn301_dio_link_encoder.h       |     82 +
 .../drm/amd/display/dc/dcn301/dcn301_hubbub.c |     81 +
 .../drm/amd/display/dc/dcn301/dcn301_hubbub.h |     60 +
 .../drm/amd/display/dc/dcn301/dcn301_hwseq.c  |     42 +
 .../drm/amd/display/dc/dcn301/dcn301_hwseq.h  |     32 +
 .../drm/amd/display/dc/dcn301/dcn301_init.c   |    145 +
 .../drm/amd/display/dc/dcn301/dcn301_init.h   |     33 +
 .../amd/display/dc/dcn301/dcn301_panel_cntl.c |    218 +
 .../amd/display/dc/dcn301/dcn301_panel_cntl.h |     97 +
 .../amd/display/dc/dcn301/dcn301_resource.c   |   2011 +
 .../amd/display/dc/dcn301/dcn301_resource.h   |     42 +
 drivers/gpu/drm/amd/display/dc/dm_pp_smu.h    |     26 +-
 .../gpu/drm/amd/display/dc/gpio/hw_factory.c  |      3 +
 .../drm/amd/display/dc/gpio/hw_translate.c    |      3 +
 .../gpu/drm/amd/display/dc/inc/hw/clk_mgr.h   |     33 +
 .../gpu/drm/amd/display/dc/inc/hw/dchubbub.h  |      4 +
 drivers/gpu/drm/amd/display/dc/inc/hw/hubp.h  |      5 +
 drivers/gpu/drm/amd/display/dmub/dmub_srv.h   |      3 +
 drivers/gpu/drm/amd/display/dmub/src/Makefile |      2 +-
 .../drm/amd/display/dmub/src/dmub_dcn301.c    |     55 +
 .../drm/amd/display/dmub/src/dmub_dcn301.h    |     37 +
 .../gpu/drm/amd/display/dmub/src/dmub_srv.c   |     14 +
 .../gpu/drm/amd/display/include/dal_asic_id.h |     10 +
 .../gpu/drm/amd/display/include/dal_types.h   |      5 +
 .../display/include/grph_object_ctrl_defs.h   |     17 +
 .../include/asic_reg/clk/clk_11_5_0_offset.h  |     50 +
 .../include/asic_reg/clk/clk_11_5_0_sh_mask.h |     70 +
 .../include/asic_reg/dcn/dcn_3_0_1_offset.h   |  13271 ++
 .../include/asic_reg/dcn/dcn_3_0_1_sh_mask.h  |  53357 +++++
 .../asic_reg/mmhub/mmhub_2_3_0_default.h      |   1253 +
 .../asic_reg/mmhub/mmhub_2_3_0_offset.h       |   2439 +
 .../asic_reg/mmhub/mmhub_2_3_0_sh_mask.h      |  10331 +
 .../include/asic_reg/mp/mp_11_5_0_offset.h    |    400 +
 .../include/asic_reg/mp/mp_11_5_0_sh_mask.h   |    942 +
 .../include/asic_reg/nbio/nbio_7_2_0_offset.h |  31873 +++
 .../asic_reg/nbio/nbio_7_2_0_sh_mask.h        | 152495 +++++++++++++++
 drivers/gpu/drm/amd/include/atomfirmware.h    |     67 +-
 .../gpu/drm/amd/include/vangogh_ip_offset.h   |   1516 +
 .../drm/amd/pm/inc/smu11_driver_if_vangogh.h  |    239 +
 drivers/gpu/drm/amd/pm/inc/smu_types.h        |     53 +-
 drivers/gpu/drm/amd/pm/inc/smu_v11_0.h        |      1 +
 drivers/gpu/drm/amd/pm/inc/smu_v11_5_pmfw.h   |    120 +
 drivers/gpu/drm/amd/pm/inc/smu_v11_5_ppsmc.h  |     86 +
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c     |     10 +
 drivers/gpu/drm/amd/pm/swsmu/smu11/Makefile   |      1 +
 .../gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c    |      3 +
 .../gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c  |    355 +
 .../gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.h  |     30 +
 include/drm/amd_asic_type.h                   |      1 +
 include/uapi/drm/amdgpu_drm.h                 |      4 +
 105 files changed, 275638 insertions(+), 68 deletions(-)
 mode change 100644 => 100755 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
 create mode 100644 drivers/gpu/drm/amd/amdgpu/mmhub_v2_3.c
 create mode 100644 drivers/gpu/drm/amd/amdgpu/mmhub_v2_3.h
 create mode 100644 drivers/gpu/drm/amd/amdgpu/nbio_v7_2.c
 create mode 100644 drivers/gpu/drm/amd/amdgpu/nbio_v7_2.h
 create mode 100644 drivers/gpu/drm/amd/amdgpu/vangogh_reg_init.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/clk_mgr/dcn301/dcn301_smu.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/clk_mgr/dcn301/dcn301_smu.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/clk_mgr/dcn301/vg_clk_mgr.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/clk_mgr/dcn301/vg_clk_mgr.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/dcn301/Makefile
 create mode 100644 drivers/gpu/drm/amd/display/dc/dcn301/dcn301_dccg.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/dcn301/dcn301_dccg.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/dcn301/dcn301_dio_link_encoder.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/dcn301/dcn301_dio_link_encoder.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/dcn301/dcn301_hubbub.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/dcn301/dcn301_hubbub.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/dcn301/dcn301_hwseq.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/dcn301/dcn301_hwseq.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/dcn301/dcn301_init.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/dcn301/dcn301_init.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/dcn301/dcn301_panel_cntl.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/dcn301/dcn301_panel_cntl.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/dcn301/dcn301_resource.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/dcn301/dcn301_resource.h
 create mode 100644 drivers/gpu/drm/amd/display/dmub/src/dmub_dcn301.c
 create mode 100644 drivers/gpu/drm/amd/display/dmub/src/dmub_dcn301.h
 create mode 100644 drivers/gpu/drm/amd/include/asic_reg/clk/clk_11_5_0_offset.h
 create mode 100644 drivers/gpu/drm/amd/include/asic_reg/clk/clk_11_5_0_sh_mask.h
 create mode 100644 drivers/gpu/drm/amd/include/asic_reg/dcn/dcn_3_0_1_offset.h
 create mode 100644 drivers/gpu/drm/amd/include/asic_reg/dcn/dcn_3_0_1_sh_mask.h
 create mode 100644 drivers/gpu/drm/amd/include/asic_reg/mmhub/mmhub_2_3_0_default.h
 create mode 100644 drivers/gpu/drm/amd/include/asic_reg/mmhub/mmhub_2_3_0_offset.h
 create mode 100644 drivers/gpu/drm/amd/include/asic_reg/mmhub/mmhub_2_3_0_sh_mask.h
 create mode 100644 drivers/gpu/drm/amd/include/asic_reg/mp/mp_11_5_0_offset.h
 create mode 100644 drivers/gpu/drm/amd/include/asic_reg/mp/mp_11_5_0_sh_mask.h
 create mode 100644 drivers/gpu/drm/amd/include/asic_reg/nbio/nbio_7_2_0_offset.h
 create mode 100644 drivers/gpu/drm/amd/include/asic_reg/nbio/nbio_7_2_0_sh_mask.h
 create mode 100644 drivers/gpu/drm/amd/include/vangogh_ip_offset.h
 create mode 100644 drivers/gpu/drm/amd/pm/inc/smu11_driver_if_vangogh.h
 create mode 100644 drivers/gpu/drm/amd/pm/inc/smu_v11_5_pmfw.h
 create mode 100644 drivers/gpu/drm/amd/pm/inc/smu_v11_5_ppsmc.h
 create mode 100644 drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
 create mode 100644 drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.h

-- 
2.25.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
