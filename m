Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2529BC4332F
	for <amd-gfx@archiver.kernel.org>; Thu,  9 Dec 2021 17:00:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DC01A10EB93;
	Thu,  9 Dec 2021 16:54:31 +0000 (UTC)
Received: from mx1.riseup.net (mx1.riseup.net [198.252.153.129])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 115BE10E130
 for <amd-gfx@lists.freedesktop.org>; Thu,  9 Dec 2021 15:47:48 +0000 (UTC)
Received: from fews2.riseup.net (fews2-pn.riseup.net [10.0.1.84])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256
 client-signature RSA-PSS (2048 bits) client-digest SHA256)
 (Client CN "mail.riseup.net", Issuer "R3" (not verified))
 by mx1.riseup.net (Postfix) with ESMTPS id 4J8z2C52GkzDxXc;
 Thu,  9 Dec 2021 07:47:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=riseup.net; s=squak;
 t=1639064867; bh=D0drADm+XmCuVc5qz66VbTUTt97sDZU4jLJ/NbCuRog=;
 h=From:To:Cc:Subject:Date:From;
 b=GvQDSxmfGYI4y82gZJ2x5ymMOf+3cs+VwMYsf5BESaMOeToDU2Wipom2OU2P4xddj
 zMaVl2339vaEBHOoJBOtekjBXz8HdOPbu79pYq9fPhb/g1PPomNYZ83mzZ/jJj6peU
 MogCNWAdPy4FhOnlDfk4nQsSf9xoPllNjWmBbSOg=
X-Riseup-User-ID: 455F0AD2CAF7C28ACAF9B4CEE69D3DE350DA89968C097C427FDF03DD05B30D75
Received: from [127.0.0.1] (localhost [127.0.0.1])
 by fews2.riseup.net (Postfix) with ESMTPSA id 4J8z286Lcyz20Ts;
 Thu,  9 Dec 2021 07:47:44 -0800 (PST)
From: Isabella Basso <isabbasso@riseup.net>
To: alexander.deucher@amd.com, christian.koenig@amd.com, daniel@ffwll.ch,
 harry.wentland@amd.com, Rodrigo.Siqueira@amd.com, Felix.Kuehling@amd.com
Subject: [PATCH v2 00/10] drm/amd: fix various compilation warnings
Date: Thu,  9 Dec 2021 12:47:18 -0300
Message-Id: <20211209154722.4018279-1-isabbasso@riseup.net>
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
Cc: ~lkcamp/patches@lists.sr.ht, Isabella Basso <isabbasso@riseup.net>,
 amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This patchset aims at fixing various compilation warnings in the AMD GPU
driver. All warnings were generated using gcc and the W=1 flag. I
decided to deal with them in the same order as the issues were presented
in the log, with the exception of those that were about the lack of
protypes, which were gathered by a script [1].

Some of these patches were already applied [2], so not all are being
sent in this new version.

Changes since v1:
- Made amdgpu_ras_mca_query_error_status static instead of prototyping
  it in patch 3/10
- Rewrote function signatures in patch 6/10
- Removed unused functions in patch 6/10
- Removed more unecessary code in patch 9/10
- Reduced patch 10/10 to a minimum

[1] - https://pad.riseup.net/p/ZMkzoeO89Kt7R_IC4iAo-keep
[2] - https://patchwork.freedesktop.org/series/97701

Isabella Basso (10):
  drm/amd: Mark IP_BASE definition as __maybe_unused
  drm/amd: fix improper docstring syntax
  drm/amdgpu: fix amdgpu_ras_mca_query_error_status scope
  drm/amdgpu: fix function scopes
  drm/amdkfd: fix function scopes
  drm/amd/display: fix function scopes
  drm/amd: append missing includes
  drm/amdgpu: fix location of prototype for amdgpu_kms_compat_ioctl
  drm/amdgpu: remove unnecessary variables
  drm/amdgpu: re-format file header comments

 drivers/gpu/drm/amd/amdgpu/amdgpu.h           |  2 -
 .../gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c  |  4 +-
 .../gpu/drm/amd/amdgpu/amdgpu_atpx_handler.c  |  3 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c    |  4 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.h       |  3 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_ioc32.c     |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c       |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_pll.c       |  2 +
 .../gpu/drm/amd/amdgpu/amdgpu_preempt_mgr.c   |  4 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c       | 12 +--
 drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c       |  1 -
 drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c      |  4 +-
 drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c        |  2 -
 drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c        |  2 -
 drivers/gpu/drm/amd/amdkfd/kfd_migrate.c      |  4 +-
 .../drm/amd/amdkfd/kfd_packet_manager_vi.c    |  4 +-
 drivers/gpu/drm/amd/amdkfd/kfd_process.c      |  5 +-
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c          | 11 ++-
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 18 ++--
 .../amd/display/amdgpu_dm/amdgpu_dm_color.c   |  4 +
 .../gpu/drm/amd/display/dc/calcs/dcn_calcs.c  |  4 +-
 .../display/dc/clk_mgr/dcn10/rv1_clk_mgr.c    |  2 +-
 .../dc/clk_mgr/dcn10/rv1_clk_mgr_vbios_smu.c  |  2 +
 .../display/dc/clk_mgr/dcn20/dcn20_clk_mgr.c  |  2 +-
 .../dc/clk_mgr/dcn201/dcn201_clk_mgr.c        | 43 +-------
 .../amd/display/dc/clk_mgr/dcn21/rn_clk_mgr.c | 23 +----
 .../dc/clk_mgr/dcn21/rn_clk_mgr_vbios_smu.c   |  6 +-
 .../display/dc/clk_mgr/dcn301/dcn301_smu.c    |  6 +-
 .../display/dc/clk_mgr/dcn301/vg_clk_mgr.c    | 20 +---
 .../display/dc/clk_mgr/dcn31/dcn31_clk_mgr.c  |  7 +-
 .../amd/display/dc/clk_mgr/dcn31/dcn31_smu.c  |  6 +-
 drivers/gpu/drm/amd/display/dc/core/dc_link.c |  3 +-
 .../display/dc/dce110/dce110_hw_sequencer.c   |  2 +
 .../gpu/drm/amd/display/dc/dcn10/dcn10_dpp.c  |  8 --
 .../drm/amd/display/dc/dcn10/dcn10_dpp_dscl.c | 97 -------------------
 .../amd/display/dc/dcn10/dcn10_hw_sequencer.c | 29 +++---
 .../gpu/drm/amd/display/dc/dcn10/dcn10_opp.c  | 30 ------
 .../gpu/drm/amd/display/dc/dcn10/dcn10_optc.c | 20 +---
 .../drm/amd/display/dc/dcn10/dcn10_resource.c | 18 ++--
 .../gpu/drm/amd/display/dc/dcn20/dcn20_dpp.c  | 14 ---
 .../drm/amd/display/dc/dcn20/dcn20_dwb_scl.c  |  4 +-
 .../gpu/drm/amd/display/dc/dcn20/dcn20_hubp.c |  7 +-
 .../drm/amd/display/dc/dcn20/dcn20_hwseq.c    |  6 +-
 .../gpu/drm/amd/display/dc/dcn20/dcn20_init.c |  2 +
 .../gpu/drm/amd/display/dc/dcn20/dcn20_mpc.c  |  9 +-
 .../gpu/drm/amd/display/dc/dcn20/dcn20_optc.c | 57 +----------
 .../drm/amd/display/dc/dcn201/dcn201_dccg.c   |  3 +-
 .../drm/amd/display/dc/dcn201/dcn201_hubp.c   |  7 +-
 .../display/dc/dcn201/dcn201_link_encoder.c   |  6 +-
 .../amd/display/dc/dcn201/dcn201_resource.c   | 16 ++-
 .../drm/amd/display/dc/dcn21/dcn21_hubbub.c   |  2 +-
 .../gpu/drm/amd/display/dc/dcn21/dcn21_hubp.c | 15 +--
 .../gpu/drm/amd/display/dc/dcn21/dcn21_init.c |  2 +
 .../amd/display/dc/dcn21/dcn21_link_encoder.c |  9 +-
 .../drm/amd/display/dc/dcn21/dcn21_resource.c | 31 +++---
 .../dc/dcn30/dcn30_dio_stream_encoder.c       | 18 +---
 .../gpu/drm/amd/display/dc/dcn30/dcn30_dpp.c  | 36 ++-----
 .../gpu/drm/amd/display/dc/dcn30/dcn30_init.c |  2 +
 .../drm/amd/display/dc/dcn30/dcn30_mmhubbub.c |  2 +-
 .../gpu/drm/amd/display/dc/dcn30/dcn30_mpc.c  |  2 +-
 .../drm/amd/display/dc/dcn30/dcn30_resource.c | 12 +--
 .../drm/amd/display/dc/dcn301/dcn301_init.c   |  2 +
 .../amd/display/dc/dcn301/dcn301_panel_cntl.c | 10 +-
 .../amd/display/dc/dcn301/dcn301_resource.c   | 45 ++++-----
 .../drm/amd/display/dc/dcn302/dcn302_init.c   |  2 +
 .../drm/amd/display/dc/dcn303/dcn303_init.c   |  2 +
 .../gpu/drm/amd/display/dc/dcn31/dcn31_dccg.c |  2 +-
 .../display/dc/dcn31/dcn31_dio_link_encoder.c |  2 +-
 .../gpu/drm/amd/display/dc/dcn31/dcn31_init.c |  2 +
 .../amd/display/dc/dcn31/dcn31_panel_cntl.c   | 10 +-
 .../drm/amd/display/dc/dcn31/dcn31_resource.c |  2 +-
 .../dc/dml/dcn21/display_rq_dlg_calc_21.c     |  8 --
 .../display/dc/irq/dcn10/irq_service_dcn10.c  |  7 +-
 .../dc/irq/dcn201/irq_service_dcn201.c        |  7 +-
 .../display/dc/irq/dcn21/irq_service_dcn21.c  |  7 +-
 .../display/dc/irq/dcn31/irq_service_dcn31.c  |  7 +-
 .../amd/include/cyan_skillfish_ip_offset.h    | 10 +-
 .../gpu/drm/amd/include/yellow_carp_offset.h  |  4 +-
 drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c        |  2 +-
 79 files changed, 248 insertions(+), 566 deletions(-)

-- 
2.34.1

