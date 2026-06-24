Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11CBCCDB47F
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Jun 2026 18:09:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9DBF610F080;
	Wed, 24 Jun 2026 18:09:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="PJ6QK60d";
	dkim-atps=neutral
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012071.outbound.protection.outlook.com [52.101.48.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A536010F080
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Jun 2026 18:09:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H+/w1cGfqlRMqOupgpbWF9vqG6ZHXlBIAUkAeuIfcnGgn5Y7CYVAcmHSAjA8lFnTYtd28fb6CJ77Wy9MPj5xwUXcqng6rMYdUH/3hbVi/gll5VR5WN3Dlcd/8rQ8vd275HOIrIxSfrOpYgPxvnUUxbnfz8iVj4BWt1lxm6HQ+PnyfzlCJqkKr7sH/7TZC5KhZLvPltPAMIjw41hpB3u9oytxtG5qR8oNFKMWAHR/0EsAbDhhgFc2JYhG0CTywBvGuckHC4w0pnAzfCydPglC+x3Jvl9i45HGIC5oVRrsPikyrxmXgyIGgoCT2wu14bfrtEQqDkI5SpR8ARNtvfrJGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d15xpKqpGlpFaiH5czE7ul7TR/jjSaToEqsslqub3/o=;
 b=kgfNn9XsOSG3SKnu9ij3RHf0Mp9ZGvdVskE7zN66/xg+3xwh0ELFnPuCWNN8MArTrUU/mA6MFwgDA07XgnYtqLT55vOdB+m575I8u9uEhB3mJfvvHwAh1iHs489oesfw6AwrUc0gj55c5H4xNM/Oi4/qN9cjZdZZWzoCuhuoqtFKCKKniS1mgndTW2bnWrS+8iU/t+Pd1PaDiCPoband+W5YAERApkwIBlaIxUjums2DxK9ln3daMR1GOwY8EXcH/cPx/nMz7kpavKo/OvIZEZlfGmEPvDvBEK1UB7+xcjYBB3Hf2bdfTNuzS/TVZQbYTQgf+SQPueGN9KwvwHV0QA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d15xpKqpGlpFaiH5czE7ul7TR/jjSaToEqsslqub3/o=;
 b=PJ6QK60d7EoUgHp0iAeEP8vm+vQBK+OKjMv7xB0d3NDwSlvQdi4zv4ZsSeih5ei/NG4Qx4Z1WCI+QYhAnaETJ4hkDl834aKYQDgmCtctVwa+EEdTQNS/59LZD8HPo0YVnZtYAWtI5K+mskAXEAYorcXDPtM2DJ195EoKqnMUncM=
Received: from SJ0PR05CA0201.namprd05.prod.outlook.com (2603:10b6:a03:330::26)
 by BN7PPFEDA8E6F1A.namprd12.prod.outlook.com
 (2603:10b6:40f:fc02::6e8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.13; Wed, 24 Jun
 2026 18:09:00 +0000
Received: from SJ5PEPF000001CB.namprd05.prod.outlook.com
 (2603:10b6:a03:330:cafe::65) by SJ0PR05CA0201.outlook.office365.com
 (2603:10b6:a03:330::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.139.9 via Frontend Transport; Wed, 24
 Jun 2026 18:08:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001CB.mail.protection.outlook.com (10.167.242.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Wed, 24 Jun 2026 18:08:58 +0000
Received: from MKMGEORZHAN02.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 24 Jun
 2026 13:08:55 -0500
From: George Zhang <george.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, George Zhang <george.zhang@amd.com>
Subject: [PATCH 00/28] DC Patches Jun 24, 2026
Date: Wed, 24 Jun 2026 14:02:58 -0400
Message-ID: <20260624180829.4775-1-george.zhang@amd.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001CB:EE_|BN7PPFEDA8E6F1A:EE_
X-MS-Office365-Filtering-Correlation-Id: 2f60f463-b1a2-4b1e-40cc-08ded21ba965
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|1800799024|23010399003|376014|6133799003|3023799007|18002099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: ryNJ6mD/fZQLfWWXfIWyuHlWKN6oZjFnEkQ7MawN56gbS5GoLr5A4QLf7/yQQxXsmJ1/hCSSsjXJJapRfNmpnNjJiQNJuX1v3fvkQGHk9bV2/hqoHp1fzTLmjRK3/zn0p8wyV5JwOl8g1eG9RZgIuZJGPLph+bItXFs2wZ2GHjg0XthTgb9XOzuqwbn2FIqhVg1DB0K1U9dxxHdpZTF6Q87uxC7amxu78ub80PKjYRqVH4/NdvxW6GrSFqNWVU3BoeSksKIeGdhqIZ5Y+72eLpGVrAlvdEUBAWtNgU4AFD+MFpMfrnreC7EsiDn60OF2cmJWg09tbta7VY5onoR8vpGhFshejKnFeW9PhIEjz1ikLwI83qtCpnh9riPIXXrdtsJivjOham9BMsqk8QQLYtMKZ4isnDAXP8yE2oj2hdnOE1nTpAY88YAObVIhA6BRsyypOuafPAV6CTeNxjYkPCg9GSRJddBK4WLMpbH/b9sZIuSurNDxXc1Pf3C4bXsZ7dcT6W8zU3DocO6t8suGEMeUEreqf44XqMaxLPHE5yNbV8uDcuvl8R5RROn+xr45NaHS7412dgKWvv9JE5qHsmlCzuZxoDcUWui3it+Dpsm7W9gV0KcxfZ6QG2Rv7P8fA0KVQtga3HB9PnZoWSYsktO7rByOgpUUM9xxoyp1F6BM7tY5UjN9hpOyIyLLHrXXuSBFfE6rRJzF1nFT5GWI3Q==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(1800799024)(23010399003)(376014)(6133799003)(3023799007)(18002099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: DHFDFLtiFCieF5zPsc8fMHbppBX0lIqoM14gF2LaOcyL0GDZtkvY+Rmetzc8XTxg6KvhLYAh2t923JXfuzCOCbHdkaTZugehpIsupZz0oZebbRlyS/CYQukKgpho6ycAyrb/3mJfFngiNnwHNAVTHZUOivay36fGdMvhNp8TlDa0MsQnf4IzA6OORf1QoLHNOBNV2IJ/ywduk43m0O+I7IVdnDeeiRF6IJmREm50sXb5lwElBF/f75eANt+DTMLfEcHc2Q+SX3FJE0YzCPbZP997/G8K5OCHTmxTx0kAri+kvS8TfW8TXWNS1tcEUsCSTHO995y5RnZGJ/LYh54Q20TvDO34evYRRxhk7iKlORXoeNGXp6a1MbCaGXwpPSy5x3QfbWWUUxhG5JFSfc9LpQzQv/ZRouE2e6IIhRWCZwnEfkkwNMkG06a1Rdo3dQ1J
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2026 18:08:58.0016 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f60f463-b1a2-4b1e-40cc-08ded21ba965
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001CB.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PPFEDA8E6F1A
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

This DC patchset brings improvements in multiple areas. In summary, we have:

* Fixes on DCN4, encoder, debugfs output, and others
* Enhanced KUnit coverage
* Code cleanup

Alex Hung (12):
  drm/amd/display: Extract backlight helpers for KUnit tests
  drm/amd/display: Add more KUnit tests for amdgpu_dm_colorop
  drm/amd/display: Simplify boolean checks
  drm/amd/display: Simplify DMUB notify registration
  drm/amd/display: Fix KUnit test crash after global alpha change
  drm/amd/display: Add KUnit test for amdgpu_dm_wb
  drm/amd/display: Add KUnit tests for amdgpu_dm_replay
  drm/amd/display: Add KUnit tests for amdgpu_dm_psr
  drm/amd/display: Add KUnit tests for amdgpu_dm_pp_smu
  drm/amd/display: Add KUnit tests for mst_types
  drm/amd/display: Extract shared KUnit test helpers
  drm/amd/amdgpu: Fix stack frame size warnings in KUnit tests

Andrew Lichmanov (1):
  drm/amd/display: Disable mem gating for DCHVM on DCHVM init

Austin Zheng (1):
  drm/amd/display: Revert "Add Debug Option To Enable Per-DPM De-rate
    Usage"

Bhawanpreet Lakha (1):
  drm/amd/display: Add kunit tests for amdgpu_dm_plane

Bhuvanachandra Pinninti (2):
  drm/amd/display: Cleaned up headers
  drm/amd/display: Add block sequence support for bandwidth programming
    operations

Charlene Liu (1):
  drm/amd/display: remove dead code related to forcevrr

Harry Wentland (4):
  drm/amd/display: fix malformed link_settings debugfs output
  drm/amd/display: clamp DMUB AUX reply length to payload buffer
  drm/amd/display: guard against overflow in HDCP message dump
  drm/amd/display: hold a vblank ref while writeback is pending

James Lin (1):
  drm/amd/display: scale plane global alpha to 12 bits on DCN 4.2

Leo Chen (1):
  drm/amd/display: revert "Enable HUBP/DPP power gate for DCN42"

Peichen Huang (1):
  drm/amd/display: correct encoder minimal creation

Relja Vojvodic (1):
  drm/amd/display: Update link bw

Taimur Hassan (1):
  drm/amd/display: Promote DC to 3.2.388

Wenjing Liu (1):
  drm/amd/display: Replace repeated no-native-i2c checks with
    force_i2c_over_aux field

 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |   64 +-
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h |    2 +
 .../display/amdgpu_dm/amdgpu_dm_backlight.c   |   84 +-
 .../display/amdgpu_dm/amdgpu_dm_backlight.h   |    8 +
 .../amd/display/amdgpu_dm/amdgpu_dm_colorop.c |    1 +
 .../display/amdgpu_dm/amdgpu_dm_connector.c   |    2 +-
 .../amd/display/amdgpu_dm/amdgpu_dm_debugfs.c |   20 +-
 .../amd/display/amdgpu_dm/amdgpu_dm_dmub.c    |   32 +-
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c |   53 +-
 .../display/amdgpu_dm/amdgpu_dm_mst_types.c   |   19 +-
 .../display/amdgpu_dm/amdgpu_dm_mst_types.h   |    7 +
 .../amd/display/amdgpu_dm/amdgpu_dm_plane.c   |  127 +-
 .../amd/display/amdgpu_dm/amdgpu_dm_plane.h   |   51 +
 .../amd/display/amdgpu_dm/amdgpu_dm_pp_smu.c  |   52 +-
 .../amd/display/amdgpu_dm/amdgpu_dm_pp_smu.h  |   23 +
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_psr.c |   51 +-
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_psr.h |    5 +
 .../amd/display/amdgpu_dm/amdgpu_dm_replay.c  |    3 +
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_wb.c  |    1 +
 .../amd/display/amdgpu_dm/tests/.kunitconfig  |    3 +
 .../drm/amd/display/amdgpu_dm/tests/Makefile  |    3 +
 .../tests/amdgpu_dm_backlight_test.c          |  140 +-
 .../amdgpu_dm/tests/amdgpu_dm_colorop_test.c  |  140 +-
 .../tests/amdgpu_dm_connector_test.c          |   64 +-
 .../amdgpu_dm/tests/amdgpu_dm_crtc_test.c     |   15 +-
 .../amdgpu_dm/tests/amdgpu_dm_helpers_test.c  |   19 +-
 .../amdgpu_dm/tests/amdgpu_dm_irq_test.c      |   37 +-
 .../amdgpu_dm/tests/amdgpu_dm_ism_test.c      |   39 +-
 .../amdgpu_dm/tests/amdgpu_dm_kunit_helpers.c |  142 ++
 .../tests/amdgpu_dm_kunit_test_helpers.h      |   32 +
 .../tests/amdgpu_dm_mst_types_test.c          |  643 ++++++-
 .../amdgpu_dm/tests/amdgpu_dm_plane_test.c    | 1228 +++++++++++++
 .../amdgpu_dm/tests/amdgpu_dm_pp_smu_test.c   | 1535 ++++++++++++++++-
 .../amdgpu_dm/tests/amdgpu_dm_psr_test.c      |  518 +++++-
 .../amdgpu_dm/tests/amdgpu_dm_replay_test.c   |  432 ++++-
 .../display/amdgpu_dm/tests/amdgpu_dm_test.c  |   72 +-
 .../amdgpu_dm/tests/amdgpu_dm_wb_test.c       |   56 +
 .../dc/clk_mgr/dcn401/dcn401_clk_mgr.c        |   57 +-
 .../dc/clk_mgr/dcn401/dcn401_clk_mgr.h        |    9 +
 drivers/gpu/drm/amd/display/dc/core/dc.c      |    4 +-
 .../drm/amd/display/dc/core/dc_hw_sequencer.c |  154 ++
 drivers/gpu/drm/amd/display/dc/dc.h           |    9 +-
 drivers/gpu/drm/amd/display/dc/dce/dce_aux.c  |    9 +-
 .../amd/display/dc/dce110/dce110_compressor.c |    2 -
 .../display/dc/dce110/dce110_mem_input_v.c    |    2 -
 .../amd/display/dc/dce112/dce112_compressor.c |    8 +-
 .../dc/dio/dcn31/dcn31_dio_link_encoder.c     |    4 +
 .../dc/dio/dcn31/dcn31_dio_link_encoder.h     |    2 +
 .../dc/gpio/dce80/hw_translate_dce80.c        |    5 +-
 .../display/dc/hubbub/dcn35/dcn35_hubbub.c    |    2 +-
 .../amd/display/dc/hwss/dcn401/dcn401_hwseq.c |   97 +-
 .../amd/display/dc/hwss/dcn401/dcn401_hwseq.h |   10 +
 .../amd/display/dc/hwss/dcn401/dcn401_init.c  |    2 +
 .../drm/amd/display/dc/hwss/hw_sequencer.h    |   82 +
 .../gpu/drm/amd/display/dc/inc/hw/clk_mgr.h   |    8 +
 .../gpu/drm/amd/display/dc/inc/link_service.h |    1 +
 .../drm/amd/display/dc/link/link_factory.c    |    7 +-
 .../amd/display/dc/link/protocols/link_ddc.c  |   20 +-
 .../amd/display/dc/link/protocols/link_ddc.h  |    2 +
 .../dc/link/protocols/link_dp_capability.c    |    8 +-
 .../dc/link/protocols/link_dp_panel_replay.c  |    7 +-
 .../link/protocols/link_edp_panel_control.c   |   13 +-
 .../dc/resource/dcn31/dcn31_resource.c        |    4 +-
 .../dc/resource/dcn314/dcn314_resource.c      |    4 +-
 .../dc/resource/dcn315/dcn315_resource.c      |    4 +-
 .../dc/resource/dcn316/dcn316_resource.c      |    4 +-
 .../dc/resource/dcn35/dcn35_resource.c        |    4 +-
 .../dc/resource/dcn351/dcn351_resource.c      |    4 +-
 .../dc/resource/dcn36/dcn36_resource.c        |    4 +-
 .../dc/resource/dcn42/dcn42_resource.c        |    8 +-
 .../dc/resource/dcn42b/dcn42b_resource.c      |    4 +-
 .../dcn401/dcn401_soc_and_ip_translator.c     |   16 -
 .../drm/amd/display/modules/hdcp/hdcp_log.c   |   30 +-
 .../gpu/drm/amd/display/modules/power/power.c |    7 +-
 .../drm/amd/display/modules/power/power_abm.c |   14 +-
 75 files changed, 5875 insertions(+), 479 deletions(-)
 create mode 100644 drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_kunit_helpers.c
 create mode 100644 drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_kunit_test_helpers.h
 create mode 100644 drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_plane_test.c

-- 
2.53.0

