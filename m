Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20F7FCD4F21
	for <amd-gfx@archiver.kernel.org>; Wed, 13 May 2026 14:33:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B4C2310EED4;
	Wed, 13 May 2026 14:32:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="dxBop4PS";
	dkim-atps=neutral
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012032.outbound.protection.outlook.com
 [40.107.200.32])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6B94210EED1
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 May 2026 14:32:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wm3Aong1M4kS0s11gFNEK4VOD5pB9U5yh0cQxnMMuiuPxMps0/nbbSKv23Xy0/t6xBjXYMFtm7OfAhPPWKVIhesR0AOUfoa6s+b9NRW8Jqxfdw/JIdErzjnpOrKYUOaOlTv0cm07oDZtoFqnyrwo2V4LlvhP6t+jJ1uUoSeVIiBncCzl6VQPCVo9Dpn9XsTMWEQbCQNqFlBm0bIYc5DiSyQFQMpvOR8P4usfn0dEwd2qi/hsMKZaWv5/z5uhzeWA5KVOikny8NnKE/eaJZMaVCjC3VOERXi6ZOqJrDF2jjGYQu5d28uJWvLQVqxHoWCRuSxKndjo1Cb542BmugoBTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cb5MwApws8sqTEyHHpk9mWKTl6lKMpoll4BACoGRRJs=;
 b=IOfEN3y7u+D2plLDnlBW0CD3RoQe9/x4kN+gpSVi7ad6AZC8NeRYMJQvkAmnJ3WNihcVhxd8nqzVIIgBPYoWla8GiS+U3hRkfSoYCI9AULKxMNPm2tF77A4hK8SXKgWacj8nCqyRuAbBs4BYSuswSbrxK3L7WyZTrjRZkDIEb4FlyD7EXFlqn4MYxaQj694BngdTDWx19nPexysqKhFWwaTn+myIOHlWeljq3KkCe3q7UFsDG4h9MbQR+lOzJtThm7idNTgZFDxSoQU3VU8Ug9tF3qvnIZG3ZPSDbHFDbyYWTpFJjx4+/r2QCQV5Szt08nLzwMWIliNBWdw4i9dz8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cb5MwApws8sqTEyHHpk9mWKTl6lKMpoll4BACoGRRJs=;
 b=dxBop4PSKGtDDgcXcPNT/Yd3AiTr2OQYqEkxlnutDIcu2w6zBRzTZsqpzOXIU5PX6QUPE0omqNrqVzXpCT4uXtUtpA3lk/IIF0Mgi6ydOeWZ851BkC2KcOWYS2xgz3xsrRenZzzmf4LSdyra2TKmXT2/DKJZe7qHZb7G5QkQWxI=
Received: from MW4P220CA0013.NAMP220.PROD.OUTLOOK.COM (2603:10b6:303:115::18)
 by CH1PPF946CC24FA.namprd12.prod.outlook.com
 (2603:10b6:61f:fc00::61c) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.12; Wed, 13 May
 2026 14:32:55 +0000
Received: from MWH0EPF000C6191.namprd02.prod.outlook.com
 (2603:10b6:303:115:cafe::40) by MW4P220CA0013.outlook.office365.com
 (2603:10b6:303:115::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9913.11 via Frontend Transport; Wed,
 13 May 2026 14:32:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MWH0EPF000C6191.mail.protection.outlook.com (10.167.249.106) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.25.13 via Frontend Transport; Wed, 13 May 2026 14:32:55 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 13 May
 2026 09:32:54 -0500
Received: from box-0.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Wed, 13 May 2026 09:32:54 -0500
From: <IVAN.LIPSKI@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>
Subject: [PATCH 00/28] DC Patches May 13, 2026
Date: Wed, 13 May 2026 10:29:22 -0400
Message-ID: <20260513143213.1852892-2-IVAN.LIPSKI@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000C6191:EE_|CH1PPF946CC24FA:EE_
X-MS-Office365-Filtering-Correlation-Id: 1b50c94d-b4a3-44d3-0e16-08deb0fc85a6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700016|376014|11063799003|56012099003|18002099003|3023799003;
X-Microsoft-Antispam-Message-Info: S/LZQX1CxnRDniE49zrqBl8bEeSJDIbajhLLy9weMzMYCw7jRdVXlz6qFoFKqzwNnENisDhe/5RXjrHnjEc+OrBRx5KZ+P5GZRvxULFGgKKyl0vxc+9NFAmJwmb7h0mkVcqUyuLgkfCkKufnIUsjJlSHI1ZNHz441HS2nPUqm6+x+uENRLng4nO5+ySnDVvemIeXL88IYOTV/iT0G+kVUsfpBRFLUX/mDMXGy0zCNk7Ex6K1HeGUQ5rcGbF3bd4RO3xvihqwcHgFyFrmJVicIcY2jXVc+uJlB/Wie7lUP9RqD7pNJU9oVubvMRUp6cMr7SOG7Wy4HZBmHXIJW1/rxiyGIAsIzGu5pb0qc97RHzmWL9Y5JdnlTAcw6nvufkcNVkj9ofI7afhhUCk1NV1euWHiCmEYZAVu4nYMf5ANXDY5dgu1DktzbVLizJVS1zV+wp2abWxVjcUmeGzrTWQhR7uQcZIg7J6nGAMhUCrmWIN7mZlsWGz32UaXcP/V38FFd/k/2uzT5b6zPqsaU+yq57iYAwp1MtXKxMdHKoWO4BKnbzrIc0jNVxq6SskdzOGPAXYUJ1vb24TEHcOTErZvLaDShsT/eCMIQaGYKiVCnazW4fhX6FPfDmVYOQUdf+3Px73qR3+L2NNvq34aFOOoCqt7vJds0XjiX7FFR/XHkxjcK4pqUxksJanT2ohwIJo4CcUMWYcq5gQdlWsFnD+fjYA7vdXNugKACd0aH+oniro=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700016)(376014)(11063799003)(56012099003)(18002099003)(3023799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: Jaxq8c7CRzQ/9FVXwhS2LZo3U9TUI76r9n1+GJpDd3XiIfYp0bdPYCiHib9V+l2waLEsqTeQn6pXYi32fSNzj7sf+GlFDg6WTS2int/WGDrdZVovD5S7UmUmN/jq2qT3Fs4jVkJMabINR5vuNnSzj+p1sixZy1Ayoa+o+SGs1x5UwuHkw6cuhcr67Xc6ElHTPNKqWanPVeveZGJ0vm4FmA94ZC5CIHNl2R5I+d3OzjJoXzV0zc4gxk3VFaY+NT1RD3MbcNq4JhCoJFVCwkotI8OmBMjLJl+MG/ZqIZGDgAQMzf7n8WbEBLgmjYQczi19q9QeBjXMDt4pTfru5XkiIZJ/4ByhoBKOIP95vDofBak4GdauO4G99KxizmZA2pQF0gNKqrwlr/A8D7Qg37YVuHswZvtExV/Rr52qf5QPV21EjS8PcTbjRB18N9/tfdhQ
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2026 14:32:55.2391 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b50c94d-b4a3-44d3-0e16-08deb0fc85a6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000C6191.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PPF946CC24FA
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

From: Ivan Lipski <ivan.lipski@amd.com>

This DC patchset brings improvements in multiple areas. In summary, we highlight:

 - Add amdgpu_dm KUnit test for:
   * CRC function
   * HDCP process_output
   * colorop TF bitmasks
   * color helpers
   * PSR and Replay functions
   * ISM functions
 - Fix eDP receiver ready status check in T7 sequence
 - Enable dcn42 pstate pmo
 - Refactor PSR. Replay and ABM functionality into dedicated power modules
 - Fix assertion due to disable/enable CM blocks
 - Enable additional wait for pipe pending checks
 - Fix ISM dc_lock deadlock during suspend
 - Use lockdep_assert_held() for dc_lock check
 - Fix clear PSR config flow
 - Exclude the MST overhead from BW deallocation
 - Allow power up even w/ powergating disabled on DCN42
 - Fix integer overflow in bios_get_image()
 - Validate GPIO pin LUT table size before iterating
 - Add Auxless-ALPM support in VESA Panel Replay
 - Add debug option for replay ESD recovery
 - Validate payload length and link_index in dc_process_dmub_aux_transfer_async
 - Add ADDR3 swizzle modes


Cc: Dan Wheeler <daniel.wheeler@amd.com>


Alex Hung (6):
  drm/amd/display: Add KUnit test for HDCP process_output
  drm/amd/display: Add KUnit test for colorop TF bitmasks
  drm/amd/display: Add KUnit test for color helpers
  drm/amd/display: Add KUnit test for PSR function
  drm/amd/display: Add KUnit test for replay
  drm/amd/display: Add KUnit test for ISM functions

Aric Cyr (2):
  drm/amd/display: Fix assertion due to disable/enable CM blocks
  drm/amd/display: Enable additional wait for pipe pending checks

Aurabindo Pillai (1):
  drm/amd/display: Add KUnit test for CRC function

Charlene Liu (1):
  drm/amd/display: Allow power up when PG disallowed in driver

Cruise Hung (1):
  drm/amd/display: Exclude the MST overhead from BW deallocation

Dmytro Laktyushkin (1):
  drm/amd/display: Enable dcn42 pstate pmo

Harry Wentland (3):
  drm/amd/display: Fix integer overflow in bios_get_image()
  drm/amd/display: Validate GPIO pin LUT table size before iterating
  drm/amd/display: Validate payload length and link_index in
    dc_process_dmub_aux_transfer_async

James Lin (2):
  drm/amd/display: Add some missing code for dcn42
  Revert "drm/amd/display: dmub_cmd.h: add missing kernel-doc for enums"

Leon Huang (2):
  drm/amd/display: Fix clear PSR config flow
  drm/amd/display: Add Auxless-ALPM support in VESA Panel Replay

Lohita Mudimela (2):
  drm/amd/display: Refactor PSR functionality into dedicated power_psr
    module
  drm/amd/display: Refactor Replay functionality into dedicated
    power_replay module

Nicholas Kazlauskas (1):
  drm/amd/display: Enable DCN42 PMO policy

Ray Wu (2):
  drm/amd/display: Fix ISM dc_lock deadlock during suspend
  drm/amd/display: Use lockdep_assert_held() for dc_lock check

Sung-huai Wang (1):
  drm/amd/display: Fix eDP receiver ready status check in T7 sequence

Taimur Hassan (1):
  drm/amd/display: Promote DC to 3.2.383

Wei-Guang Li (1):
  drm/amd/display: Add debug option for replay ESD recovery

Wenxian Wang (1):
  drm/amd/display: Add ADDR3 swizzle modes

 drivers/gpu/drm/amd/display/Kconfig           |   12 +
 .../gpu/drm/amd/display/amdgpu_dm/Makefile    |    5 +
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |   25 +-
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h |    2 -
 .../amd/display/amdgpu_dm/amdgpu_dm_color.c   |   65 +-
 .../amd/display/amdgpu_dm/amdgpu_dm_color.h   |   89 ++
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_crc.c |   17 +-
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_crc.h |    7 +
 .../amd/display/amdgpu_dm/amdgpu_dm_hdcp.c    |    5 +-
 .../amd/display/amdgpu_dm/amdgpu_dm_hdcp.h    |   13 +-
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_ism.c |   80 +-
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_ism.h |   11 +
 .../amdgpu_dm/amdgpu_dm_kunit_helpers.h       |   19 +
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_psr.c |    6 +-
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_psr.h |    5 +
 .../amd/display/amdgpu_dm/amdgpu_dm_replay.c  |    3 +
 .../amd/display/amdgpu_dm/tests/.kunitconfig  |   14 +
 .../drm/amd/display/amdgpu_dm/tests/Makefile  |   18 +
 .../amdgpu_dm/tests/amdgpu_dm_color_test.c    | 1071 +++++++++++++
 .../amdgpu_dm/tests/amdgpu_dm_colorop_test.c  |  161 ++
 .../amdgpu_dm/tests/amdgpu_dm_crc_test.c      |  121 ++
 .../amdgpu_dm/tests/amdgpu_dm_hdcp_test.c     |  175 +++
 .../amdgpu_dm/tests/amdgpu_dm_ism_test.c      |  636 ++++++++
 .../amdgpu_dm/tests/amdgpu_dm_psr_test.c      |  255 ++++
 .../amdgpu_dm/tests/amdgpu_dm_replay_test.c   |  206 +++
 .../drm/amd/display/dc/bios/bios_parser2.c    |    9 +
 .../amd/display/dc/bios/bios_parser_helper.c  |    9 +-
 .../display/dc/clk_mgr/dcn42/dcn42_clk_mgr.c  |    2 +
 drivers/gpu/drm/amd/display/dc/core/dc.c      |    6 +-
 drivers/gpu/drm/amd/display/dc/dc.h           |    3 +-
 drivers/gpu/drm/amd/display/dc/dc_hw_types.h  |    4 +-
 .../dml2_0/dml21/dml21_translation_helper.c   |    5 +-
 .../dc/dml2_0/dml21/inc/dml_top_types.h       |    1 +
 .../dml21/src/dml2_pmo/dml2_pmo_dcn42.c       |  144 +-
 .../dml21/src/dml2_pmo/dml2_pmo_dcn42.h       |    1 +
 .../dml21/src/dml2_pmo/dml2_pmo_dcn4_fams2.c  |    4 -
 .../dml21/src/dml2_pmo/dml2_pmo_factory.c     |   16 +
 .../dml21/src/dml2_top/dml2_top_soc15.c       |   30 +-
 .../drm/amd/display/dc/dml2_0/dml2_wrapper.h  |    1 +
 .../drm/amd/display/dc/dpp/dcn30/dcn30_dpp.c  |    3 +
 .../amd/display/dc/dpp/dcn30/dcn30_dpp_cm.c   |    1 +
 .../display/dc/dpp/dcn401/dcn401_dpp_dscl.c   |    1 +
 .../display/dc/hubbub/dcn401/dcn401_hubbub.c  |    2 +
 .../amd/display/dc/hwss/dcn10/dcn10_hwseq.c   |    8 +-
 .../amd/display/dc/hwss/dcn10/dcn10_init.c    |    2 +
 .../amd/display/dc/hwss/dcn20/dcn20_init.c    |    2 +
 .../amd/display/dc/hwss/dcn30/dcn30_init.c    |    2 +
 .../amd/display/dc/hwss/dcn301/dcn301_init.c  |    2 +
 .../amd/display/dc/hwss/dcn31/dcn31_init.c    |    2 +
 .../amd/display/dc/hwss/dcn314/dcn314_init.c  |    2 +
 .../amd/display/dc/hwss/dcn32/dcn32_init.c    |    2 +
 .../amd/display/dc/hwss/dcn401/dcn401_init.c  |    2 +
 .../amd/display/dc/hwss/dcn42/dcn42_hwseq.c   |    5 +-
 drivers/gpu/drm/amd/display/dc/inc/hw/optc.h  |    1 -
 .../gpu/drm/amd/display/dc/link/link_dpms.c   |   41 +-
 .../dc/link/protocols/link_dp_irq_handler.c   |   14 +-
 .../dc/link/protocols/link_dp_panel_replay.c  |   13 +
 .../link/protocols/link_edp_panel_control.c   |   26 +-
 .../amd/display/dc/optc/dcn35/dcn35_optc.c    |    1 -
 .../amd/display/dc/optc/dcn42/dcn42_optc.c    |    2 -
 .../amd/display/dc/pg/dcn42/dcn42_pg_cntl.c   |   43 +-
 .../dc/resource/dcn42/dcn42_resource.c        |   12 +-
 .../dc/resource/dcn42/dcn42_resource.h        |    7 +
 .../gpu/drm/amd/display/dmub/inc/dmub_cmd.h   |  156 +-
 .../drm/amd/display/modules/inc/mod_power.h   |   23 -
 .../drm/amd/display/modules/power/Makefile    |    4 +-
 .../gpu/drm/amd/display/modules/power/power.c | 1343 +----------------
 .../drm/amd/display/modules/power/power_abm.c |   98 --
 .../amd/display/modules/power/power_helpers.c |  250 ---
 .../amd/display/modules/power/power_helpers.h |  121 ++
 .../drm/amd/display/modules/power/power_psr.c |  665 ++++++++
 .../amd/display/modules/power/power_replay.c  |  911 +++++++++++
 72 files changed, 5060 insertions(+), 1963 deletions(-)
 create mode 100644 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.h
 create mode 100644 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_kunit_helpers.h
 create mode 100644 drivers/gpu/drm/amd/display/amdgpu_dm/tests/.kunitconfig
 create mode 100644 drivers/gpu/drm/amd/display/amdgpu_dm/tests/Makefile
 create mode 100644 drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_color_test.c
 create mode 100644 drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_colorop_test.c
 create mode 100644 drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_crc_test.c
 create mode 100644 drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_hdcp_test.c
 create mode 100644 drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_ism_test.c
 create mode 100644 drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_psr_test.c
 create mode 100644 drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_replay_test.c
 create mode 100644 drivers/gpu/drm/amd/display/modules/power/power_psr.c
 create mode 100644 drivers/gpu/drm/amd/display/modules/power/power_replay.c

-- 
2.43.0

