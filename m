Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C043ECD6E4A
	for <amd-gfx@archiver.kernel.org>; Thu,  4 Jun 2026 14:54:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 54FDF11283A;
	Thu,  4 Jun 2026 14:54:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="J4o9+eXa";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011028.outbound.protection.outlook.com [52.101.62.28])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4077B11283A
 for <amd-gfx@lists.freedesktop.org>; Thu,  4 Jun 2026 14:54:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=czbTQorXMc7yn65DjUDbg+ZlezcmJCi+to4pKd7ZjayuQe+3rbGMCYBE11OyCKP114qZFhLYYLHEfDUlNpffhJPxhAcfrPKDNj60ucQtFzSIzoWOGo2XlOFzp5drLyTpx2aDI3huCn/5P50f7nI2aE5VSKUnx0sJQ6QkmxmlNNyisfN7LmlzCLjwGKjf7fMxIN6MVxtpqchU+CswnvaPGgs9ZiyfVG7Sp0Zj1C1D4EjcOd0G+43oSdXaGNASRxrxqWqSdWAHwTt1Mn0+WaxWLuk1guixlj6b4adPk6KgS+125UZYEqNRjN+nMa7d+Re9atfBynfWDxyGMe1UuSggLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Pz5YgNunkbSI6dZAuQqrFbuJw0UxVSQ7ltQAchIJexc=;
 b=xcsm2ivTefno3PkyQw9j6e+xp+QDmVKxUC7FMWSRtMnWH8yez6+uL1wxNpayJEKW4bSJzTOGrIEcz0/0KLR+r2dUbDbrLKoSIzYM5RPNzI1VTJAwv205lAiZeaCsGx8p5nU7/+zqO7oTlAEBlInYfdM/7XrsLfS9lGfq5ligzFhGn1oECjZN/9BeIR6g16Nm0Deo9foB3K4FqRptu1jncADNfU0S4kC2vDX4Et480abtZ+YeaAVBJq4vTeCWi/4oHUx/jBUyYFm4eqg223GQ/WAXIEfrA4pwqmtJOyOXIrGfnt0Y/ivQIgTnoadXrJlOXiynDvLsvqSz7ITdMmjBjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Pz5YgNunkbSI6dZAuQqrFbuJw0UxVSQ7ltQAchIJexc=;
 b=J4o9+eXa5w7EXG7F2YkXOtDvNOwcsFVhW0Z4y2KQMEhMwTZZ0YWduTXStOyi439JLmuDpRBo0J9QcljMumXyi34ub5QYNB3Y3SfEMYiHrm25cUJoi0vtJFf5YY63cpuoPZf2iT8I7m4tuMXZIlNkqSKNrIbd7HRYKGsP5axxi8Y=
Received: from BL1PR13CA0234.namprd13.prod.outlook.com (2603:10b6:208:2bf::29)
 by DS7PR12MB5910.namprd12.prod.outlook.com (2603:10b6:8:7b::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.71.15; Thu, 4 Jun 2026 14:54:35 +0000
Received: from MN1PEPF0000F0E1.namprd04.prod.outlook.com
 (2603:10b6:208:2bf:cafe::a6) by BL1PR13CA0234.outlook.office365.com
 (2603:10b6:208:2bf::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.92.8 via Frontend Transport; Thu, 4
 Jun 2026 14:54:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 MN1PEPF0000F0E1.mail.protection.outlook.com (10.167.242.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.5 via Frontend Transport; Thu, 4 Jun 2026 14:54:35 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 4 Jun
 2026 09:54:34 -0500
Received: from aaurabin-tumbleweed.king-squeaker.ts.net (10.180.168.240) by
 satlexmb08.amd.com (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41
 via Frontend Transport; Thu, 4 Jun 2026 09:54:33 -0500
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>
Subject: [PATCH 00/24] DC Patches for 8 June 2026
Date: Thu, 4 Jun 2026 10:51:54 -0400
Message-ID: <20260604145428.809959-1-aurabindo.pillai@amd.com>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0E1:EE_|DS7PR12MB5910:EE_
X-MS-Office365-Filtering-Correlation-Id: a51064ac-fe0e-4041-c0f8-08dec24931a3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|82310400026|376014|1800799024|18002099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: nhFM4Wz9FOwVXivQuWKzzm08ldWF6la+HkiV09ooQWJ9bNB8aqnSdfoyC0wKQjfPX5gmUhWkdx+ZYIjSm0/V+6GvYU217gxMgoDpox/+hNq9n+8E54EUoDFesekcqYchlN/zweN6gQee1NVUGE29Z00fYJ0XerJ0FCz/g3nkCyAsc9Q/JkfzOkZaNLdLU82/53pz6jrITvdaUrKZfwCMoiWccFyiVBl05jE1qndA8Og9nwtwQozenKUcCZ9h8Q3nLN1qFgmPo/8/lpJb83SdC1m7YHeG/euKeT+4lNEsJol5aPzOBFETmNt+MKLPLpxBJaQvqOo6Nz/6H3DY62cFk+LKJzBL2enpODI5h6PjAHvYsB8nfYr1J+Mb3J8QoSl/RvFGrc+CLFFoklmPAqhbIwuJ0VtIlbEXPRV3xeMVEVCx7zOGvRUy9dkU4auIjxFRkyoGDOONsKCjZSDDsFzP2R+U+4SRbRDbWT56u4+atI/pKjGylFdfnVlhBN5YzMSliI8F0zmtDndD+3FGFtNvfQ7/Wm8uiw1wkKHV3E1xrNrSHaeWgu/vXwL68aGc8pcQnCAcIcen80cQUGNFyOxVjAuTWmRUHf/b1uxJ9CzY9cG9dDrIHNfxfJQe8sQRk9xBbPENYJF7snpRLdF7np3vpouzgbfrrOCGgVXDbk+AcgErQ2yxopWChadI+ce+CGu8P9KuHEmwEheQw+VQQPO2RL0lWjz7h8HbdQxVAxm7Lkk=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(82310400026)(376014)(1800799024)(18002099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: hD8BXmYIou8UsbG23uvGn9gYApPKVqNW8RGD3Pdvwp4sOtIJcxpCGaMHjt4AZfKwmYtv0H5kdmqmjFDuUsTRQCp5r4QATnLqtu9+s9jRbodZTUWU1p3OQbazO355r9CUvbAW44uDs85jshXG3KJZm3rBOfmn7kHRhPkdsTZufkhA5pxvAC9MlHwxQUAWIWjkC0nVJQI65nSFtT+z42zfrJxV+SlRcQbV4M8huxLdb25esUbHw5lNnB+IQCnwGQ+4H/pNROnUaIJ0uVb09HWew6y6jZb48Ns4BOoy3S5EuvEMIMWQil2q0ppfCHE4U2sHB8PE5pxGIdN5OtG575LjPdfxIq9E18Q5K7lv8qSBiXDsV9dD1g/ybaLhlONlmcLk2UYlRd3lDOQV/Tz9wtb2P+mt2DDMVI6DXredaQ++bgYz4IqC9JX403Vvvy+gZTo+
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2026 14:54:35.3975 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a51064ac-fe0e-4041-c0f8-08dec24931a3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000F0E1.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5910
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

Summary:

  * Display connectivity & HPD:
    - Retry link detection on resume, boot, and hotplug
    - Refactor HPD RX to use handle_hpd_irq_helper with detect reason
    - Always create delayed HPD work queue
    - Restore periodic detection for DCN35

  * DCN42B support:
    - Fix DCN42B version detection
    - Add DCN42B to dml21_translation_helper

  * KUnit testing infrastructure:
    - Add KUnit tests for amdgpu_dm_pp_smu, amdgpu_dm_mst_types,
      and writeback connector
    - Extract HDCP and DPRX CRC transition helpers for KUnit
    - Export symbols for KUnit test modules
    - Enable warnings as errors for KUnit tests

  * Fixes & cleanups:
    - Fix compressed buffer config routine waiting time
    - Fix incorrect logic in CRC source handling
    - Fix writeback format loop and variable init
    - Fix max dispclk_khz/dppclk_khz double 1000
    - Remove duplicate pp_rn_set_wm_ranges
    - Remove dead code in dm_dp_mst_get_modes
    - Remove redundant code in amdgpu_dm_replay
    - Skip PHY SSC reduction on some 8K panels
    - Temp disable repeater FGCG as workaround
    - Deprecate DMUB register offload functionality
    - TEST_HARNESS FSN could be 0

  * Firmware:
    - DMUB FW promotion to 0.1.62.0

---

Alex Hung (11):
  drm/amd/display: Fix writeback format loop and variable init
  drm/amd/display: Add KUnit tests for writeback connector
  drm/amd/display: remove redundant code in amdgpu_dm_replay
  drm/amd/display: Enable warnings as errors for KUnit tests
  drm/amd/display: Remove dead code in dm_dp_mst_get_modes
  drm/amd/display: Add KUnit tests for amdgpu_dm_mst_types
  drm/amd/display: Fix incorrect logic in CRC source handling
  drm/amd/display: Extract DPRX CRC transition helpers for KUnit testing
  drm/amd/display: Extract HDCP testable helpers for KUnit
  drm/amd/display: Remove duplicate pp_rn_set_wm_ranges
  drm/amd/display: Add KUnit tests for amdgpu_dm_pp_smu

Antonio Quartulli (1):
  drm/amd/display: fix compressed buffer config routine waiting time

Austin Zheng (1):
  drm/amd/display: Deprecate DMUB register offload functionality

Charlene Liu (1):
  drm/amd/display: fix max dispclk_khz/dppclk_khz double 1000

ChunTao Tso (1):
  drm/amd/display: TEST_HARNESS FSN could be 0

Ivan Lipski (1):
  drm/amd/display: Restore periodic detection for DCN35

Ovidiu Bunea (1):
  drm/amd/display: Temp disable repeater FGCG as workaround

Roman Li (1):
  drm/amd/display: Skip PHY SSC reduction on some 8K panels

Taimur Hassan (1):
  drm/amd/display: Promote DC to 3.2.385

Timur Kristóf (5):
  drm/amd/display: Add detect reason to handle_hpd_irq_helper
  drm/amd/display: Use handle_hpd_irq_helper for HPD RX
  drm/amd/display: Always create delayed HPD work queue
  drm/amd/display: Retry link detection on hotplug
  drm/amd/display: Retry link detection on resume and boot

 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 224 ++++++++----
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h |  16 +
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_crc.c | 100 ++++--
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_crc.h |   6 +
 .../amd/display/amdgpu_dm/amdgpu_dm_hdcp.c    | 115 ++++--
 .../amd/display/amdgpu_dm/amdgpu_dm_hdcp.h    |  12 +
 .../amd/display/amdgpu_dm/amdgpu_dm_helpers.c |  13 +-
 .../display/amdgpu_dm/amdgpu_dm_mst_types.c   |  25 +-
 .../display/amdgpu_dm/amdgpu_dm_mst_types.h   |   6 +
 .../amd/display/amdgpu_dm/amdgpu_dm_pp_smu.c  |  21 +-
 .../amd/display/amdgpu_dm/amdgpu_dm_pp_smu.h  |  16 +
 .../amd/display/amdgpu_dm/amdgpu_dm_replay.c  |   7 +-
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_wb.c  |  15 +-
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_wb.h  |  13 +
 .../amd/display/amdgpu_dm/tests/.kunitconfig  |   3 +
 .../drm/amd/display/amdgpu_dm/tests/Makefile  |   4 +
 .../amdgpu_dm/tests/amdgpu_dm_crc_test.c      | 122 +++++++
 .../amdgpu_dm/tests/amdgpu_dm_hdcp_test.c     | 297 +++++++++++++++-
 .../tests/amdgpu_dm_mst_types_test.c          | 124 +++++++
 .../amdgpu_dm/tests/amdgpu_dm_pp_smu_test.c   | 241 +++++++++++++
 .../amdgpu_dm/tests/amdgpu_dm_wb_test.c       | 336 ++++++++++++++++++
 .../display/dc/clk_mgr/dcn31/dcn31_clk_mgr.c  |   2 -
 .../dc/clk_mgr/dcn314/dcn314_clk_mgr.c        |   2 -
 .../display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c  |   2 +
 drivers/gpu/drm/amd/display/dc/dc.h           |   6 +-
 drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c  |  12 -
 drivers/gpu/drm/amd/display/dc/dc_dmub_srv.h  |   9 -
 drivers/gpu/drm/amd/display/dc/dc_helper.c    | 226 ------------
 .../amd/display/dc/dccg/dcn42/dcn42_dccg.c    |   6 +-
 drivers/gpu/drm/amd/display/dc/dm_services.h  |   4 -
 .../dc/dml2_0/dml21/dml21_wrapper_fpu.c       |   8 +-
 .../amd/display/dc/dpp/dcn10/dcn10_dpp_cm.c   |   5 -
 .../display/dc/hubbub/dcn31/dcn31_hubbub.c    |   8 +-
 .../amd/display/dc/hubp/dcn42/dcn42_hubp.c    |   6 +
 .../amd/display/dc/hwss/dcn35/dcn35_hwseq.c   |   3 -
 .../amd/display/dc/hwss/dcn42/dcn42_hwseq.c   |   9 +-
 .../gpu/drm/amd/display/dc/inc/reg_helper.h   |  19 -
 .../drm/amd/display/dc/mpc/dcn20/dcn20_mpc.c  |   4 -
 .../amd/display/dc/optc/dcn10/dcn10_optc.c    |   5 -
 .../amd/display/dc/optc/dcn20/dcn20_optc.c    |   5 -
 .../amd/display/dc/optc/dcn31/dcn31_optc.c    |   5 -
 .../amd/display/dc/optc/dcn314/dcn314_optc.c  |   5 -
 .../amd/display/dc/optc/dcn32/dcn32_optc.c    |   5 -
 .../amd/display/dc/optc/dcn35/dcn35_optc.c    |   5 -
 .../amd/display/dc/optc/dcn401/dcn401_optc.c  |   5 -
 .../dc/resource/dcn35/dcn35_resource.c        |   1 -
 .../dc/resource/dcn351/dcn351_resource.c      |   1 -
 .../dc/resource/dcn36/dcn36_resource.c        |   1 -
 .../dc/resource/dcn42/dcn42_resource.c        |   1 +
 .../amd/display/modules/power/power_replay.c  |   9 +-
 50 files changed, 1576 insertions(+), 519 deletions(-)
 create mode 100644 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_pp_smu.h
 create mode 100644 drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_mst_types_test.c
 create mode 100644 drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_pp_smu_test.c
 create mode 100644 drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_wb_test.c

-- 
2.54.0

