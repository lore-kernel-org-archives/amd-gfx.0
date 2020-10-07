Return-Path: <SRS0=8cN+=DO=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F7FEC47423
	for <amd-gfx@archiver.kernel.org>; Wed,  7 Oct 2020 16:31:47 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A8A752064E
	for <amd-gfx@archiver.kernel.org>; Wed,  7 Oct 2020 16:31:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rkVhkf6u"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A8A752064E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D2B7B6E0E7;
	Wed,  7 Oct 2020 16:31:45 +0000 (UTC)
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com
 [IPv6:2607:f8b0:4864:20::72a])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8C5356E0E7
 for <amd-gfx@lists.freedesktop.org>; Wed,  7 Oct 2020 16:31:45 +0000 (UTC)
Received: by mail-qk1-x72a.google.com with SMTP id a23so3400427qkg.13
 for <amd-gfx@lists.freedesktop.org>; Wed, 07 Oct 2020 09:31:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=vm3oOooCPElBsKtHdqP5jrWuPyVgd+c//Ad6Xh7X7sY=;
 b=rkVhkf6uzhdK1yVtbs8jRacBHaDuN3zmQqYNTLfNUAUMKKAdaT5/ZS15k2eTIfk2QE
 6n47s/k+r+EW5g+rFQ8PcDucWYokHJ4LKbipX8NDeBgyfnsocW21a1zdD8eREJlnPMlG
 zfipS5PFcaT/fOFbEyv0/6llwQkphF3gmn7wNi4WmstVgEgrwSIbxKaUtzD0v84sg5gJ
 McaIMVpL6c4kVraaPLY/Y0Vn3+oHglt5gjZ6FyASf/2Gv3xWnjsBaotibdPcai3cJCrC
 B6EslymnfBbSI8nzefaXRzXsoZ3ZAsbq0F0d1yuHHE1oTypZFdjkGZ6UOY7NSRtQwqZF
 2Bag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=vm3oOooCPElBsKtHdqP5jrWuPyVgd+c//Ad6Xh7X7sY=;
 b=nPXxd38cFvUr+bEhY4aF5k7jUNIZT2VuRoc72yGXfb5OPKRaLhcMjwqKGs5wkLCiar
 G7uH4qRSlNsWPX90eHDSnXK44KjFa78aAbrY+KIB7jKLswwHDvpHmgnhRNuzQS4X0Zgu
 fU8kHUbFPdge3wOfFZlHwZkur6yIZ92wWu5V6T9sidsIzHe+1vh7dB89nE5+z597c7pY
 JZYdIuGZgzlpK7aHA00bXwDZQVaPQHXAPFYoDBOHRCaBqkfqH3mCTChaG0vIa0T+K25c
 MqMobukWqb/obEaxRuaF0xBpY6N+IInZRtrknROTo79JHxw3X00jCNQ+tAX+fpRVPwtz
 4bJQ==
X-Gm-Message-State: AOAM531Qa/Dp6UHOwSTy/3wFlH736h+koEUR3rneZWjwap899i9bXRzK
 3pbMD5ivXJSAdzQlr/nhQXl0eSd9nGI=
X-Google-Smtp-Source: ABdhPJyCLPr6Xm/5BwfZAgphx0iDvoB974+FJvwVtufPOtnZ/vgk5wgK/Y4BX2y+D47NHgMiMyF8iw==
X-Received: by 2002:a37:6285:: with SMTP id w127mr3865991qkb.454.1602088304383; 
 Wed, 07 Oct 2020 09:31:44 -0700 (PDT)
Received: from tr4.amd.com (atlvpn.amd.com. [165.204.84.11])
 by smtp.gmail.com with ESMTPSA id l19sm1725576qkk.99.2020.10.07.09.31.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Oct 2020 09:31:43 -0700 (PDT)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 00/50] Add support for Dimgrey Cavefish
Date: Wed,  7 Oct 2020 12:30:45 -0400
Message-Id: <20201007163135.1944186-1-alexander.deucher@amd.com>
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

This series adds initial support for Dimgrey Cavefish.

Bhawanpreet Lakha (2):
  drm/amd/display: Add support for DCN302 (v2)
  drm/amd/display: Add DCN302 support in amdgpu_dm (v2)

Chengming Gui (2):
  drm/amdkfd: Support dimgrey_cavefish KFD (v2)
  drm/amdkfd: Add kfd2kgd_funcs for dimgrey_cavefish kfd support

James Zhu (6):
  drm/amdgpu/vcn: add firmware support for dimgrey_cavefish
  drm/amdgpu/vcn: enable VCN DPG mode for dimgrey_cavefish
  drm/amdgpu: enable VCN3.0 PG and CG for dimgrey_cavefish
  drm/amdgpu: enable jpeg3.0 PG and CG for dimgrey_cavefish
  drm/amdgpu: enable vcn3.0 for dimgrey_cavefis
  drm/amdgpu: enable jpeg3.0 for dimgrey_cavefish

Tao Zhou (40):
  drm/amdgpu: add dimgrey_cavefish asic type
  drm/amdgpu: add dimgrey_cavefish gpu info firmware
  drm/amdgpu: set fw load type for dimgrey_cavefish
  drm/amdgpu: set asic family and ip blocks for dimgrey_cavefish
  drm/amdgpu: add support for dimgrey_cavefish firmware
  drm/amdgpu: add gmc support for dimgrey_cavefish
  drm/amdgpu: add gfx clock gating support for dimgrey_cavefish
  drm/amdgpu: add common support for dimgrey_cavefish
  drm/amdgpu: initialize IP offset for dimgrey_cavefish
  drm/amdgpu: add mmhub support for dimgrey_cavefish
  drm/amdgpu: add common ip block for dimgrey_cavefish
  drm/amdgpu: add gmc ip block for dimgrey_cavefish
  drm/amdgpu: add ih ip block for dimgrey_cavefish
  drm/amdgpu: add gfx ip block for dimgrey_cavefish
  drm/amdgpu: add sdma ip block for dimgrey_cavefish
  drm/amdgpu: configure dimgrey_cavefish gfx according to gfx 10.3's
    definition
  drm/amdgpu: add virtual display support for dimgrey_cavefish
  drm/amdgpu: force pa_sc_tile_steering_override to 0 for
    dimgrey_cavefish
  drm/amdgpu: add gmc cg support for dimgrey_cavefish
  drm/amdgpu/swsmu: increase size for smu fw_name string
  drm/amdgpu/swsmu: add smu support for dimgrey_cavefish(v2)
  drm/amdgpu: increase size of psp fw_name string(v2)
  drm/amdgpu: add psp support for dimgrey_cavefish(v2)
  drm/amdgpu: skip reroute ih for some ASICs
  drm/amdgpu: support cp_fw_write_wait for dimgrey_cavefish
  drm/amdgpu: add gc golden setting for dimgrey_cavefish
  drm/amdgpu: enable front door loading for dimgrey_cavefish
  drm/amdgpu: support athub cg setting for dimgrey_cavefish
  drm/amdgpu/swsmu: update driver if version for dimgrey_cavefish
  drm/amdgpu: enable GFX clock gating for dimgrey_cavefish
  drm/amdgpu: enable mc CG and LS for dimgrey_cavefish
  drm/amdgpu: enable athub/mmhub PG for dimgrey_cavefish
  drm/amdgpu/swsmu: update driver if version for dimgrey_cavefish
  drm/amdgpu/swsmu: update driver if version for dimgrey_cavefish
  drm/amdgpu/swsmu: update driver if version for dimgrey_cavefish(v2)
  drm/amdgpu: add psp and smu block for dimgrey_cavefish
  drm/amdgpu: enable hdp CG and LS for dimgrey_cavefish
  drm/amdgpu: enable ih CG for dimgrey_cavefish
  drm/amdgpu: remove gpu_info fw support for dimgrey_cavefish
  drm/amdgpu/swsmu: update driver if version for dimgrey_cavefish

 drivers/gpu/drm/amd/amdgpu/Makefile           |    2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c    |    3 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c       |    9 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h       |    1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c     |    1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c       |    5 +
 drivers/gpu/drm/amd/amdgpu/athub_v2_1.c       |    1 +
 .../amd/amdgpu/dimgrey_cavefish_reg_init.c    |   54 +
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c        |   68 +
 drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c        |   12 +-
 drivers/gpu/drm/amd/amdgpu/mmhub_v2_0.c       |    6 +
 drivers/gpu/drm/amd/amdgpu/navi10_ih.c        |    1 +
 drivers/gpu/drm/amd/amdgpu/nv.c               |   38 +
 drivers/gpu/drm/amd/amdgpu/nv.h               |    1 +
 drivers/gpu/drm/amd/amdgpu/psp_v11_0.c        |   19 +-
 drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c        |   11 +-
 drivers/gpu/drm/amd/amdkfd/kfd_crat.c         |    1 +
 drivers/gpu/drm/amd/amdkfd/kfd_device.c       |   21 +
 .../drm/amd/amdkfd/kfd_device_queue_manager.c |    1 +
 drivers/gpu/drm/amd/amdkfd/kfd_flat_memory.c  |    1 +
 .../gpu/drm/amd/amdkfd/kfd_packet_manager.c   |    1 +
 drivers/gpu/drm/amd/amdkfd/kfd_topology.c     |    1 +
 drivers/gpu/drm/amd/display/Kconfig           |    7 +
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |   25 +-
 drivers/gpu/drm/amd/display/dc/Makefile       |    5 +
 .../display/dc/bios/command_table_helper2.c   |    5 +
 .../gpu/drm/amd/display/dc/clk_mgr/clk_mgr.c  |    6 +
 .../gpu/drm/amd/display/dc/core/dc_resource.c |   13 +
 .../drm/amd/display/dc/dce/dce_clock_source.h |   20 +
 .../gpu/drm/amd/display/dc/dce/dce_hwseq.h    |  134 ++
 .../gpu/drm/amd/display/dc/dcn302/Makefile    |   17 +
 .../drm/amd/display/dc/dcn302/dcn302_dccg.h   |   41 +
 .../drm/amd/display/dc/dcn302/dcn302_hwseq.c  |  233 +++
 .../drm/amd/display/dc/dcn302/dcn302_hwseq.h  |   35 +
 .../drm/amd/display/dc/dcn302/dcn302_init.c   |   39 +
 .../drm/amd/display/dc/dcn302/dcn302_init.h   |   33 +
 .../amd/display/dc/dcn302/dcn302_resource.c   | 1619 +++++++++++++++++
 .../amd/display/dc/dcn302/dcn302_resource.h   |   33 +
 .../gpu/drm/amd/display/dc/gpio/hw_factory.c  |    3 +
 .../drm/amd/display/dc/gpio/hw_translate.c    |    3 +
 drivers/gpu/drm/amd/display/dc/irq/Makefile   |   10 +
 .../dc/irq/dcn302/irq_service_dcn302.c        |  344 ++++
 .../dc/irq/dcn302/irq_service_dcn302.h        |   33 +
 drivers/gpu/drm/amd/display/dmub/dmub_srv.h   |    3 +
 drivers/gpu/drm/amd/display/dmub/src/Makefile |    3 +
 .../drm/amd/display/dmub/src/dmub_dcn302.c    |   55 +
 .../drm/amd/display/dmub/src/dmub_dcn302.h    |   37 +
 .../gpu/drm/amd/display/dmub/src/dmub_srv.c   |   14 +
 .../gpu/drm/amd/display/include/dal_asic_id.h |    6 +-
 .../gpu/drm/amd/display/include/dal_types.h   |    3 +
 .../amd/include/dimgrey_cavefish_ip_offset.h  | 1049 +++++++++++
 drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h       |    1 +
 drivers/gpu/drm/amd/pm/inc/smu_v11_0.h        |    1 +
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c     |    1 +
 .../gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c    |   19 +-
 include/drm/amd_asic_type.h                   |    1 +
 56 files changed, 4089 insertions(+), 20 deletions(-)
 create mode 100755 drivers/gpu/drm/amd/amdgpu/dimgrey_cavefish_reg_init.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/dcn302/Makefile
 create mode 100644 drivers/gpu/drm/amd/display/dc/dcn302/dcn302_dccg.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/dcn302/dcn302_hwseq.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/dcn302/dcn302_hwseq.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/dcn302/dcn302_init.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/dcn302/dcn302_init.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/dcn302/dcn302_resource.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/dcn302/dcn302_resource.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/irq/dcn302/irq_service_dcn302.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/irq/dcn302/irq_service_dcn302.h
 create mode 100644 drivers/gpu/drm/amd/display/dmub/src/dmub_dcn302.c
 create mode 100644 drivers/gpu/drm/amd/display/dmub/src/dmub_dcn302.h
 create mode 100644 drivers/gpu/drm/amd/include/dimgrey_cavefish_ip_offset.h

-- 
2.25.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
