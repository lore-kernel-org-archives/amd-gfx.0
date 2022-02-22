Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00E16C43217
	for <amd-gfx@archiver.kernel.org>; Tue, 22 Feb 2022 14:06:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CAD8210E82F;
	Tue, 22 Feb 2022 14:06:43 +0000 (UTC)
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com
 [IPv6:2607:f8b0:4864:20::331])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A17C110E616
 for <amd-gfx@lists.freedesktop.org>; Tue, 22 Feb 2022 13:17:31 +0000 (UTC)
Received: by mail-ot1-x331.google.com with SMTP id
 j3-20020a9d7683000000b005aeed94f4e9so6207200otl.6
 for <amd-gfx@lists.freedesktop.org>; Tue, 22 Feb 2022 05:17:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=usp.br; s=usp-google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=7bcSxnOgYRWuwEWYsw+jDqFwC/iPiLyo1fAK+m7rTBM=;
 b=FARwwudhrbiHNm+ymHkQ0oMqAOKF0Vf42hLTkLPVD7ODdcqqajzRrQGBdwOih/K0bb
 RUxopYSwKuxLMBZiJ79Q+DgoMrhCzQOsjQmLPvgQINoXR0wtyLlPZYzuYRPIZ8swe962
 ZgigI+e6snret4Jj4aG3OOyEc4M9wSawdbeC545UbyBvOExwqEX5bbLbG/As/xk4zLhr
 Gp/IMdQXMT73GBWuxTLlts5DVT60AgyXaAZeMf+VwrX0ptevIAl+8aj9IDEteHsTkRJH
 BN24yfy/ysLfDcXaCnkXr4TUHMV7v22mVn0BKE3jLi4rzvrC/KeNn/IfwhiVcKcW0gOD
 Ni2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=7bcSxnOgYRWuwEWYsw+jDqFwC/iPiLyo1fAK+m7rTBM=;
 b=qpg7AnUeFr1bsv7Xc21V5RRDVMNzlnoiJ6YKjGxElKCvQ/FPJJw1VMmqEheTc/ljkS
 B0bMOdtSxOf3zNG0m+wciiDiJafn3xgDxUoEAEeP2zuN/Hjl6dPqpEkivk25fT/UAgug
 znr0u0y5uv2UHVIZKas/s6BKS5srAx1wlvNHKHOlWzg6iRqt7qIGBaMRIEA2MapFPFcT
 d/rTKbal0Q/sKcMipaYuFHEocvK6fnWsMDRqPIW/wXPhoESmqNG87N/RLG6uOM3cfvvv
 S/YDzjC/0uCI/XXsz79Xt3PYZ3kdfTO+68qkxrO7BdWBGKpRgH/eTNjQuzyuiG12CuhX
 xKAw==
X-Gm-Message-State: AOAM531cXYgFw6ggldwa7cRe2MZICNH3NDD4BvCVEBWFEThNHyn/hiqt
 skerElGhbfu3dg4wKRrIp31tpA==
X-Google-Smtp-Source: ABdhPJwd8xzR9s0jcNwaKdd2s6R5udAwjLK2LLk1zR46KzB4XuGEtlKmrg0YPTU0KivbVcgwBzB58Q==
X-Received: by 2002:a05:6830:268c:b0:5ad:1000:397e with SMTP id
 l12-20020a056830268c00b005ad1000397emr8446171otu.35.1645535851081; 
 Tue, 22 Feb 2022 05:17:31 -0800 (PST)
Received: from fedora.. ([187.36.236.204])
 by smtp.gmail.com with ESMTPSA id c9sm6325050otd.26.2022.02.22.05.17.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Feb 2022 05:17:30 -0800 (PST)
From: =?UTF-8?q?Ma=C3=ADra=20Canal?= <maira.canal@usp.br>
To: alexander.deucher@amd.com, christian.koenig@amd.com, Xinhui.Pan@amd.com,
 Hawking.Zhang@amd.com, john.clements@amd.com, tao.zhou1@amd.com,
 YiPeng.Chai@amd.com, luben.tuikov@amd.com, Stanley.Yang@amd.com,
 Dennis.Li@amd.com, mukul.joshi@amd.com, harry.wentland@amd.com,
 sunpeng.li@amd.com, Rodrigo.Siqueira@amd.com, Anthony.Koo@amd.com
Subject: [PATCH 00/10] Fix multiple compilation warnings
Date: Tue, 22 Feb 2022 10:16:51 -0300
Message-Id: <20220222131701.356117-1-maira.canal@usp.br>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 22 Feb 2022 14:06:42 +0000
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
Cc: magalilemes00@gmail.com,
 =?UTF-8?q?Ma=C3=ADra=20Canal?= <maira.canal@usp.br>,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, mwen@igalia.com,
 amd-gfx@lists.freedesktop.org, isabbasso@riseup.net
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This patchset intends to deal with a couple of warnings in the AMD graphic
drivers. All warnings were generated with Clang and W=1 flag.

Maíra Canal (10):
  drm/amdgpu: Change amdgpu_ras_block_late_init_default function scope
  drm/amdgpu: Remove tmp unused variable
  drm/amdgpu: Remove unused get_umc_v8_7_channel_index function
  drm/amd/display: Remove unused temp variable
  drm/amd/display: Remove unused dcn316_smu_set_voltage_via_phyclk
    function
  drm/amd/display: Remove vupdate_int_entry definition
  drm/amd/display: Remove unused dmub_outbox_irq_info_funcs variable
  drm/amd/display: Remove unused variable
  drm/amd/display: Add missing prototypes to dcn201_init
  drm/amd/display: Turn global functions into static functions

 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c        |  2 +-
 drivers/gpu/drm/amd/amdgpu/dce_v6_0.c          |  4 +---
 drivers/gpu/drm/amd/amdgpu/dce_v8_0.c          |  4 +---
 drivers/gpu/drm/amd/amdgpu/umc_v8_7.c          |  7 -------
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c  |  4 ++--
 .../display/amdgpu_dm/amdgpu_dm_mst_types.c    |  2 +-
 .../dc/clk_mgr/dcn10/rv1_clk_mgr_vbios_smu.c   |  3 ++-
 .../display/dc/clk_mgr/dcn316/dcn316_clk_mgr.c |  2 +-
 .../amd/display/dc/clk_mgr/dcn316/dcn316_smu.c | 18 +-----------------
 .../gpu/drm/amd/display/dc/core/dc_resource.c  |  2 +-
 .../amd/display/dc/dcn10/dcn10_hw_sequencer.c  |  3 ---
 .../drm/amd/display/dc/dcn201/dcn201_init.c    |  1 +
 .../display/dc/irq/dcn20/irq_service_dcn20.c   |  2 +-
 .../display/dc/irq/dcn201/irq_service_dcn201.c |  5 -----
 .../display/dc/irq/dcn21/irq_service_dcn21.c   | 14 --------------
 .../display/dc/irq/dcn30/irq_service_dcn30.c   |  2 +-
 .../gpu/drm/amd/display/dmub/inc/dmub_cmd.h    |  5 +----
 17 files changed, 15 insertions(+), 65 deletions(-)

-- 
2.35.1

