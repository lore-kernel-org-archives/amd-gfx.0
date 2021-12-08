Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07F24C433EF
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Dec 2021 03:16:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 374FF6E093;
	Wed,  8 Dec 2021 03:16:43 +0000 (UTC)
Received: from mx1.riseup.net (mx1.riseup.net [198.252.153.129])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5056E6E162
 for <amd-gfx@lists.freedesktop.org>; Wed,  8 Dec 2021 01:32:47 +0000 (UTC)
Received: from fews1.riseup.net (fews1-pn.riseup.net [10.0.1.83])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256
 client-signature RSA-PSS (2048 bits) client-digest SHA256)
 (Client CN "mail.riseup.net", Issuer "R3" (not verified))
 by mx1.riseup.net (Postfix) with ESMTPS id 4J7zyg0pWCzF3Lh;
 Tue,  7 Dec 2021 17:26:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=riseup.net; s=squak;
 t=1638926779; bh=jNcBz2/OSZ0jlpl/XL9SZ8wqtK6X6uAMpq4k2RzGSf8=;
 h=From:To:Cc:Subject:Date:From;
 b=XkJ+8uXzM6UIyiyLHzJipo8Q3E0soGi4EPMRXpJ4ullyj5mkYNo/kA64BVlYQ0kR7
 o6x/XJ3r7uz1CTG57YgFm+10kYQjF+DJJRDcXJXxJnM86TzICGvsioV+rb/T6bSLu3
 PGBe1SfOVtZ9s/lZd3rQUbR8uR30PeuXBDJqTJn8=
X-Riseup-User-ID: C4CD0C5DF40727F6974666AB5A23F486FAD1924386CA5AEEB52FA73AC796A6E7
Received: from [127.0.0.1] (localhost [127.0.0.1])
 by fews1.riseup.net (Postfix) with ESMTPSA id 4J7zyc3B05z5vkY;
 Tue,  7 Dec 2021 17:26:16 -0800 (PST)
From: Isabella Basso <isabbasso@riseup.net>
To: alexander.deucher@amd.com, christian.koenig@amd.com, daniel@ffwll.ch,
 harry.wentland@amd.com, Rodrigo.Siqueira@amd.com, Felix.Kuehling@amd.com
Subject: [PATCH 00/10] drm/amd: fix various compilation warnings
Date: Tue,  7 Dec 2021 22:25:19 -0300
Message-Id: <20211208012529.372478-1-isabbasso@riseup.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 08 Dec 2021 03:16:41 +0000
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

[1] - https://pad.riseup.net/p/ZMkzoeO89Kt7R_IC4iAo-keep

Isabella Basso (10):
  drm/amd: Mark IP_BASE definition as __maybe_unused
  drm/amd: fix improper docstring syntax
  drm/amdgpu: add missing function prototype for
    amdgpu_ras_mca_query_error_status
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
 drivers/gpu/drm/amd/amdgpu/amdgpu_ioc32.c     | 16 +++---
 drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c       |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_pll.c       |  2 +
 .../gpu/drm/amd/amdgpu/amdgpu_preempt_mgr.c   |  4 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c       |  6 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h       |  4 ++
 drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c       |  1 -
 drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c      |  4 +-
 drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c        |  2 -
 drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c        |  2 -
 drivers/gpu/drm/amd/amdkfd/kfd_migrate.c      |  4 +-
 .../drm/amd/amdkfd/kfd_packet_manager_vi.c    |  4 +-
 drivers/gpu/drm/amd/amdkfd/kfd_process.c      |  5 +-
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c          | 10 +++-
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 19 +++++--
 .../amd/display/amdgpu_dm/amdgpu_dm_color.c   |  4 ++
 .../gpu/drm/amd/display/dc/calcs/dcn_calcs.c  |  4 +-
 .../display/dc/clk_mgr/dcn10/rv1_clk_mgr.c    |  2 +-
 .../dc/clk_mgr/dcn10/rv1_clk_mgr_vbios_smu.c  |  2 +
 .../display/dc/clk_mgr/dcn20/dcn20_clk_mgr.c  |  2 +-
 .../dc/clk_mgr/dcn201/dcn201_clk_mgr.c        |  9 +--
 .../amd/display/dc/clk_mgr/dcn21/rn_clk_mgr.c | 14 ++---
 .../dc/clk_mgr/dcn21/rn_clk_mgr_vbios_smu.c   |  6 +-
 .../display/dc/clk_mgr/dcn301/dcn301_smu.c    |  6 +-
 .../display/dc/clk_mgr/dcn301/vg_clk_mgr.c    | 10 ++--
 .../display/dc/clk_mgr/dcn31/dcn31_clk_mgr.c  |  9 +--
 .../amd/display/dc/clk_mgr/dcn31/dcn31_smu.c  |  6 +-
 drivers/gpu/drm/amd/display/dc/core/dc_link.c |  3 +-
 .../display/dc/dce110/dce110_hw_sequencer.c   |  2 +
 .../gpu/drm/amd/display/dc/dcn10/dcn10_dpp.c  |  2 +-
 .../drm/amd/display/dc/dcn10/dcn10_dpp_dscl.c |  5 +-
 .../amd/display/dc/dcn10/dcn10_hw_sequencer.c | 16 +++---
 .../gpu/drm/amd/display/dc/dcn10/dcn10_opp.c  |  5 +-
 .../gpu/drm/amd/display/dc/dcn10/dcn10_optc.c |  8 +--
 .../drm/amd/display/dc/dcn10/dcn10_resource.c | 21 ++++---
 .../gpu/drm/amd/display/dc/dcn20/dcn20_dpp.c  |  5 +-
 .../drm/amd/display/dc/dcn20/dcn20_dwb_scl.c  |  4 +-
 .../gpu/drm/amd/display/dc/dcn20/dcn20_hubp.c |  7 +--
 .../drm/amd/display/dc/dcn20/dcn20_hwseq.c    |  6 +-
 .../gpu/drm/amd/display/dc/dcn20/dcn20_init.c |  2 +
 .../gpu/drm/amd/display/dc/dcn20/dcn20_mpc.c  |  8 +--
 .../gpu/drm/amd/display/dc/dcn20/dcn20_optc.c | 21 ++++---
 .../drm/amd/display/dc/dcn201/dcn201_dccg.c   |  3 +-
 .../drm/amd/display/dc/dcn201/dcn201_hubp.c   |  7 +--
 .../display/dc/dcn201/dcn201_link_encoder.c   |  7 ++-
 .../amd/display/dc/dcn201/dcn201_resource.c   | 19 +++----
 .../drm/amd/display/dc/dcn21/dcn21_hubbub.c   |  2 +-
 .../gpu/drm/amd/display/dc/dcn21/dcn21_hubp.c | 16 +++---
 .../gpu/drm/amd/display/dc/dcn21/dcn21_init.c |  2 +
 .../amd/display/dc/dcn21/dcn21_link_encoder.c |  9 ++-
 .../drm/amd/display/dc/dcn21/dcn21_resource.c | 34 +++++------
 .../dc/dcn30/dcn30_dio_stream_encoder.c       |  8 +--
 .../gpu/drm/amd/display/dc/dcn30/dcn30_dpp.c  | 27 ++++-----
 .../gpu/drm/amd/display/dc/dcn30/dcn30_init.c |  2 +
 .../drm/amd/display/dc/dcn30/dcn30_mmhubbub.c |  2 +-
 .../gpu/drm/amd/display/dc/dcn30/dcn30_mpc.c  |  2 +-
 .../drm/amd/display/dc/dcn30/dcn30_resource.c | 13 ++---
 .../drm/amd/display/dc/dcn301/dcn301_init.c   |  2 +
 .../amd/display/dc/dcn301/dcn301_panel_cntl.c | 10 ++--
 .../amd/display/dc/dcn301/dcn301_resource.c   | 56 +++++++++----------
 .../drm/amd/display/dc/dcn302/dcn302_init.c   |  2 +
 .../drm/amd/display/dc/dcn303/dcn303_init.c   |  2 +
 .../gpu/drm/amd/display/dc/dcn31/dcn31_dccg.c |  2 +-
 .../display/dc/dcn31/dcn31_dio_link_encoder.c |  2 +-
 .../gpu/drm/amd/display/dc/dcn31/dcn31_init.c |  2 +
 .../amd/display/dc/dcn31/dcn31_panel_cntl.c   | 10 ++--
 .../drm/amd/display/dc/dcn31/dcn31_resource.c |  4 +-
 .../dc/dml/dcn21/display_rq_dlg_calc_21.c     |  3 +-
 .../display/dc/irq/dcn10/irq_service_dcn10.c  |  7 +--
 .../dc/irq/dcn201/irq_service_dcn201.c        |  7 +--
 .../display/dc/irq/dcn21/irq_service_dcn21.c  |  7 +--
 .../display/dc/irq/dcn31/irq_service_dcn31.c  |  7 +--
 .../amd/include/cyan_skillfish_ip_offset.h    | 10 ++--
 .../gpu/drm/amd/include/yellow_carp_offset.h  |  4 +-
 drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c        |  2 +-
 80 files changed, 303 insertions(+), 279 deletions(-)

-- 
2.34.1

