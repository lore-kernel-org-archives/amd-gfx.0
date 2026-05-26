Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29936CD5BCF
	for <amd-gfx@archiver.kernel.org>; Tue, 26 May 2026 07:14:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BC2A010E4CD;
	Tue, 26 May 2026 07:14:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="pk0aM4RZ";
	dkim-atps=neutral
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012029.outbound.protection.outlook.com [40.107.209.29])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C9DFA10E0E0
 for <amd-gfx@lists.freedesktop.org>; Tue, 26 May 2026 07:14:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WIp1I7RlZwq+KEKpkGkgesxDsIQDhFYgD0RbOsHpT+uWkY3C8mhAYQbCGezUgOAyO7nGTWpnsuzaMusTIP3NFkG4VKWm/HXuyQvG0eC1sglBP3w08lLANifI/X8cBQEmW+ISUL+z84mDJU/CMBVL+f1g5YRuHI9x5jx96P7ctoLU9LsZbnXYfZteQKMXRzJpKiDw18cRZy0JptJsLGh5sa0fHOHjmbItHIttwf8OiuHr1vH/ffj57Leq97Edozsx6ijAWSJO9xqzvZ5VPepy6qCiRUnKuzuXLhUSCcv2J7YQY6DbOhI91JWsI58uox8pT7tcCIwhLgwmrO07jw9nHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CgedfZXKpOwixuVj53djfadU+dflb7YywjQbroOtiOs=;
 b=PEGNRk9roPGHNa180ugRr0AgFf5F9QaJXO7NAax58YlKNUQUgdanU/v6mEoGgr3xiDspuznpqCCKjv2L2yoXb0ZugnkXes+2QVi67Wc4C+p20UFInibspeKxAUGIRzdRNUtVme8xMNM1sT7f92cmnkVYjmYRXX3ydiTmxLdJCUnwz2LQ8AtlNfYa15FhftyOKo7aLxEU2iKHBPw3DuyL0lpQVrxSG+NsCs7hGAijtRlVbhnL5ab7qjG/kYW8+FZMMpOak2bZkIfEY/9E5g/WL5M6C/uw1xsAlRLdQyvp+xtEIhp60mk3SQIM1uj5pfbhoR3g6cqMUah+U9pkjLLmFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CgedfZXKpOwixuVj53djfadU+dflb7YywjQbroOtiOs=;
 b=pk0aM4RZItgkGUTNwovJtQuArWGRLJs8BxDum8az3fg07h/aCJOi3SUFOzrMBvz8fX2IBaxlUHj3kej8teVVcWrJDQEn8L5bZPpjXvnJsnTDudeCmDnkfaCBMvvk+X1XLHQaTvmp7zXn3lLFsf/+xYAXEyanLlKRivPyZZYMzg0=
Received: from PH7PR17CA0005.namprd17.prod.outlook.com (2603:10b6:510:324::14)
 by LV8PR12MB9230.namprd12.prod.outlook.com (2603:10b6:408:186::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.11; Tue, 26 May
 2026 07:14:28 +0000
Received: from CY4PEPF0000E9D8.namprd05.prod.outlook.com
 (2603:10b6:510:324:cafe::a) by PH7PR17CA0005.outlook.office365.com
 (2603:10b6:510:324::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.11 via Frontend Transport; Tue, 26
 May 2026 07:14:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000E9D8.mail.protection.outlook.com (10.167.241.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.71.7 via Frontend Transport; Tue, 26 May 2026 07:14:27 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 26 May
 2026 02:14:26 -0500
Received: from ray-Ubuntu.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Tue, 26 May 2026 02:14:18 -0500
From: Ray Wu <ray.wu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Ray Wu <ray.wu@amd.com>
Subject: [PATCH 00/41] DC Patches June 1 2026
Date: Tue, 26 May 2026 15:01:23 +0800
Message-ID: <20260526071413.2181251-1-ray.wu@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D8:EE_|LV8PR12MB9230:EE_
X-MS-Office365-Filtering-Correlation-Id: fe951cc3-7415-4452-fffb-08debaf66c2f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700016|376014|3023799007|11063799006|6133799003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: agUPO/jk9h4KMintPBl59Cj+gYiYwc4YLV3A2UYdZpeXAlfEhoSGjQMjmrTSwpBDrhQV6Am5st4by+8+1FTt9+dCNK/1bBqX6PRW91sp1x7OmtZAQSAs3uPdJt17j/1ko45XEbolByB1siaNBA7uuXr+iIkf3vHAaZ0NlCjeCyfQDzhoIyZDTheWzl19wjT8t6s7K7qw9ti4ulOZqbiWtnG8w2o/QDF8fJrQ7xuYV9wp43ElGyY99GojI1+88J2YbfNvhg2xq4JOJbz9K647iLhskA83luiVvh2mWl+uqeS2pC0tTBvs8T9PWmRQKFMj+8dOfrmaKsNtrbpYPwCwjIZ1E4dV+zgnBc1EvQD8W22S6DXrGBKctcvI5X3CmL8HQ5wkvzyXO5LoXVYm4wG7pLuY4q/xy9zvGrhr/AH8VVlOEjjk0v2hZuBjOMDm2DBf0KjQQS/5kJ955tWFlp4LX9MnYrDzOhfB8fZ+XBPEWzJtkkeNC4znRp3YqVWkTDYYFQfxwhH4K/1MuaLqjSFhm85831mrjfmxZLd8VRjSUetDZM/ChqonOJGTkQcT1+CumLra+A6I4jc3MiILGNEf80VJgS1Bkfh/PL5b+JrqQpz37Hme+1kfMDTIcaNO+WlgVmd3P4p8MldzEL9qmkezHpMn/Qz0u5HtV/Vy5yEAMDSEMtLOurjQhbeN7qj2Y3DeT/4JW3Aj9HVXUtLUtfRMh+qN3KAd4I6kUuuZtTGWqgI=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700016)(376014)(3023799007)(11063799006)(6133799003)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: c0r5qRcNm1/G7W7o0Y5U7VnsMSlp4bgcp8LNtDQDp7cndPMGlgfBrO3zQnBPVGcymMMq2zAs6HVlWfHO/eCtc1hBTDn4U0k1YEB4eHmeTq3dvwEm5PitR5TKTr2MFfmWWKlxxJGfrpNa0ebxQG40p1UpblyNFysiZOpdmJcl3eQbitKpY3g7P2hESssOUEcYa+cLZ8TBzR8F2g8yDAodHCKyw2thSZTLXXcHBmJeUbXThHDAefpQZ87VVGcgvWnQ7AQsTmbfX4VSlfCnCYFmQgH6Kjn3xapGsyolsEqKycWbOgVczgmu98KDHoCuRAYfkoNCDyLI7aP0sygWonFeTEs9/8epYxNlTegPt+fOElLx0LIkUC41AQmKno6rowecISOeSPqCMn9qEZq8E/QXyW4W9fiaFDEVYSaLUitw6ML/5xdkER1REtq1prbdoYNZ
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 May 2026 07:14:27.2132 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fe951cc3-7415-4452-fffb-08debaf66c2f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9D8.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9230
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

This DC patchset brings improvements in multiple areas. In summary, we highlight:

- Enable DCN 4.2.1:
  * Add register header files for DCN42B
  * Add DCN42B DC resource files
  * Add DCN42B DMUB support
  * Add DCN42B code to DC and dcn42b_soc_bb to DML2
  * Add DCN42 PMO init_for_pstate_support
  * Enable DCN42 PMO policy and pstate pmo
  * Enable DCN 4.2.1 in amdgpu_dm
  * Enable DM for DCN 4.2.1
- Add no_native_i2c codepath
- Add amdgpu_dm KUnit tests for:
  * amdgpu_dm_psr_set_event
  * dm_ism_dispatch_next_event and additional ISM functions
  * amdgpu_dm_colorop
  * color LUT functions and transfer function helpers
- Enable gcov coverage for amdgpu_dm KUnit builds
- Extract dm_ism_dispatch_next_event and transfer function helpers
- Refactor amdgpu_dm_initialize_default_pipeline
- Clean up PSR helper functions
- Fix gamma 2.2 colorop TF direction in tests
- Handle aux_inst for connectors without DDC pin
- Fix DP_PIXEL_FORMAT fields & update clk_src for DCN4x
- Avoid DPMS-on for phantom stream
- Change default driver setting for "Force ODM2:1 for eDP" policy
- Add DC_VALIDATE_MODE_AND_PROGRAMMING condition check for force odm2:1
- Check for sharpening case when calculating max vtaps for scaler
- Add DRAM table fields to clk_mgr_internal
- Enable frame skipping in 0x37B
- Bound VBIOS record-chain walk loops
- Clamp HDMI HDCP2 rx_id_list read to buffer size
- Clamp VBIOS HDMI retimer register count to array size
- Reject gpio_bitshift >= 32 in bios_parser_get_gpio_pin_info()
- Use krealloc_array() in dal_vector_reserve()
- Fix NULL deref and buffer over-read in SDP debugfs
- Fix out-of-bounds read in dp_get_eq_aux_rd_interval()
- FW Release 0.1.61.0

Cc: Daniel Wheeler <daniel.wheeler@amd.com>

Alex Hung (12):
  drm/amd/display: Enable gcov coverage for amdgpu_dm KUnit builds
  drm/amd/display: Add KUnit tests for color LUT functions
  drm/amd/display: Extract transfer function helpers
  drm/amd/display: Add more color KUnit tests
  drm/amd/display: Refactor amdgpu_dm_initialize_default_pipeline
  drm/amd/display: Fix gamma 2.2 colorop TF direction in tests
  drm/amd/display: Add KUnit tests for amdgpu_dm_colorop
  drm/amd/display: Add more KUnit tests for amdgpu_dm_ism
  drm/amd/display: Extract dm_ism_dispatch_next_event
  drm/amd/display: Add KUnit tests for dm_ism_dispatch_next_event
  drm/amd/display: Add KUnit tests for amdgpu_dm_psr_set_event
  drm/amd/display: Clean up PSR helper functions

Charlene Liu (1):
  drm/amd/display: Add DC_VALIDATE_MODE_AND_PROGRAMMING condition check
    for force odm2:1

Chuntao Tso (1):
  drm/amd/display: Enable frame skipping in 0x37B

Dmytro Laktyushkin (2):
  drm/amd/display: Enable dcn42 pstate pmo
  drm/amd/display: Add DCN42 PMO init_for_pstate_support

Gabe Teeger (1):
  drm/amd/display: Handle aux_inst for connectors without DDC pin

Harry Wentland (7):
  drm/amd/display: Fix out-of-bounds read in dp_get_eq_aux_rd_interval()
  drm/amd/display: Clamp VBIOS HDMI retimer register count to array size
  drm/amd/display: Fix NULL deref and buffer over-read in SDP debugfs
  drm/amd/display: Use krealloc_array() in dal_vector_reserve()
  drm/amd/display: Reject gpio_bitshift >= 32 in
    bios_parser_get_gpio_pin_info()
  drm/amd/display: Clamp HDMI HDCP2 rx_id_list read to buffer size
  drm/amd/display: Bound VBIOS record-chain walk loops

Ilya Bakoulin (1):
  drm/amd/display: Avoid DPMS-on for phantom stream

Matthew Stewart (8):
  drm/amd/display: Add no_native_i2c codepath
  drm/amd: Add register header files for DCN42B
  drm/amd/display: Add DCN42B DC resource files
  drm/amd/display: Add dcn42b_soc_bb to DML2
  drm/amd/display: Add DCN42B code to DC
  drm/amd/display: Add DCN42B DMUB support
  drm/amd/display: Enable DCN 4.2.1 in amdgpu_dm
  drm/amd/display: Enable DM for DCN 4.2.1

Nicholas Kazlauskas (1):
  drm/amd/display: Enable DCN42 PMO policy

Ovidiu Bunea (3):
  drm/amd/display: Update get_pixel_clk_frequency() for DCN4x DCCG DP
    DTO
  drm/amd/display: Change default driver setting for "Force ODM2:1 for
    eDP" policy
  drm/amd/display: Fix DP_PIXEL_FORMAT fields & update clk_src for DCN4x

Samson Tam (1):
  drm/amd/display: Check for sharpening case when calculating max vtaps
    for scaler

Taimur Hassan (2):
  ddrm/amd/display: [FW Promotion] Release 0.1.61.0
  drm/amd/display: Promote DC to 3.2.384

Wenjing Liu (1):
  drm/amd/display: Add DRAM table fields to clk_mgr_internal

 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c |     1 +
 drivers/gpu/drm/amd/display/Kconfig           |     2 +-
 .../gpu/drm/amd/display/amdgpu_dm/Makefile    |     3 +
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |    29 +-
 .../amd/display/amdgpu_dm/amdgpu_dm_color.c   |    69 +-
 .../amd/display/amdgpu_dm/amdgpu_dm_color.h   |    29 +
 .../amd/display/amdgpu_dm/amdgpu_dm_colorop.c |    22 +-
 .../amd/display/amdgpu_dm/amdgpu_dm_colorop.h |     5 +
 .../amd/display/amdgpu_dm/amdgpu_dm_debugfs.c |     5 +
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_ism.c |    83 +-
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_ism.h |     7 +
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_psr.c |    20 +-
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_psr.h |     4 +-
 .../amd/display/amdgpu_dm/tests/.kunitconfig  |     8 +
 .../amdgpu_dm/tests/amdgpu_dm_color_test.c    |   568 +
 .../amdgpu_dm/tests/amdgpu_dm_colorop_test.c  |   102 +-
 .../amdgpu_dm/tests/amdgpu_dm_ism_test.c      |   302 +
 .../amdgpu_dm/tests/amdgpu_dm_psr_test.c      |    46 +-
 .../gpu/drm/amd/display/dc/basics/vector.c    |     4 +-
 .../gpu/drm/amd/display/dc/bios/bios_parser.c |    15 +-
 .../drm/amd/display/dc/bios/bios_parser2.c    |   148 +-
 .../amd/display/dc/bios/bios_parser_helper.h  |     5 +
 .../display/dc/bios/command_table_helper2.c   |     1 +
 .../gpu/drm/amd/display/dc/clk_mgr/Makefile   |    10 +
 .../gpu/drm/amd/display/dc/clk_mgr/clk_mgr.c  |    15 +
 .../dc/clk_mgr/dcn42b/dcn42b_clk_mgr.c        |   483 +
 .../dc/clk_mgr/dcn42b/dcn42b_clk_mgr.h        |    48 +
 drivers/gpu/drm/amd/display/dc/core/dc.c      |     4 +-
 .../gpu/drm/amd/display/dc/core/dc_resource.c |     6 +
 drivers/gpu/drm/amd/display/dc/dc.h           |    10 +-
 .../gpu/drm/amd/display/dc/dc_bios_types.h    |     4 +
 drivers/gpu/drm/amd/display/dc/dc_dp_types.h  |     7 +-
 drivers/gpu/drm/amd/display/dc/dc_fused_io.c  |     4 +-
 drivers/gpu/drm/amd/display/dc/dc_helper.c    |     2 +
 .../gpu/drm/amd/display/dc/dc_spl_translate.c |     1 +
 drivers/gpu/drm/amd/display/dc/dce/dce_aux.c  |   181 +-
 drivers/gpu/drm/amd/display/dc/dce/dce_aux.h  |     4 +
 .../drm/amd/display/dc/dce/dce_clock_source.c |    83 +-
 .../drm/amd/display/dc/dce/dce_clock_source.h |    26 +-
 .../gpu/drm/amd/display/dc/dcn31/dcn31_apg.h  |    13 +
 .../dc/dio/dcn42/dcn42_dio_link_encoder.h     |    95 +
 .../dc/dio/dcn42/dcn42_dio_stream_encoder.c   |    64 +-
 .../dc/dio/dcn42/dcn42_dio_stream_encoder.h   |     6 +
 .../dml2_0/dml21/dml21_translation_helper.c   |     5 +-
 .../dml21/inc/bounding_boxes/dcn42b_soc_bb.h  |   227 +
 .../dc/dml2_0/dml21/inc/dml_top_types.h       |     1 +
 .../dml21/src/dml2_pmo/dml2_pmo_dcn42.c       |   223 +-
 .../dml21/src/dml2_pmo/dml2_pmo_dcn42.h       |     2 +
 .../dml21/src/dml2_pmo/dml2_pmo_dcn4_fams2.c  |    30 +-
 .../dml21/src/dml2_pmo/dml2_pmo_dcn4_fams2.h  |    46 +-
 .../dml21/src/dml2_pmo/dml2_pmo_factory.c     |    16 +
 .../dml21/src/dml2_top/dml2_top_soc15.c       |    30 +-
 .../drm/amd/display/dc/dml2_0/dml2_wrapper.h  |     1 +
 .../amd/display/dc/dpp/dcn401/dcn401_dpp.c    |     8 +-
 drivers/gpu/drm/amd/display/dc/gpio/Makefile  |     8 +
 .../dc/gpio/dcn42b/hw_factory_dcn42b.c        |   313 +
 .../dc/gpio/dcn42b/hw_factory_dcn42b.h        |    11 +
 .../dc/gpio/dcn42b/hw_translate_dcn42b.c      |   192 +
 .../dc/gpio/dcn42b/hw_translate_dcn42b.h      |    13 +
 .../gpu/drm/amd/display/dc/gpio/hw_factory.c  |     4 +
 .../drm/amd/display/dc/gpio/hw_translate.c    |     4 +
 .../hpo/dcn31/dcn31_hpo_dp_stream_encoder.h   |    47 +
 .../display/dc/hubbub/dcn35/dcn35_hubbub.h    |   198 +
 .../amd/display/dc/hubp/dcn42/dcn42_hubp.h    |    19 +
 drivers/gpu/drm/amd/display/dc/hwss/Makefile  |     8 +
 .../amd/display/dc/hwss/dcn10/dcn10_hwseq.c   |     4 +-
 .../amd/display/dc/hwss/dcn401/dcn401_hwseq.c |    27 +
 .../amd/display/dc/hwss/dcn42b/dcn42b_hwseq.c |   238 +
 .../amd/display/dc/hwss/dcn42b/dcn42b_hwseq.h |    15 +
 .../amd/display/dc/hwss/dcn42b/dcn42b_init.c  |    20 +
 .../amd/display/dc/hwss/dcn42b/dcn42b_init.h  |    14 +
 .../gpu/drm/amd/display/dc/inc/clock_source.h |     4 +-
 .../gpu/drm/amd/display/dc/inc/hw/clk_mgr.h   |    21 +
 .../amd/display/dc/inc/hw/clk_mgr_internal.h  |    44 +-
 drivers/gpu/drm/amd/display/dc/inc/resource.h |     2 +
 .../display/dc/link/accessories/link_dp_cts.c |     2 +
 .../drm/amd/display/dc/link/link_factory.c    |    86 +-
 .../amd/display/dc/link/protocols/link_ddc.c  |    60 +-
 .../dc/link/protocols/link_dp_capability.c    |     6 +
 .../link/protocols/link_edp_panel_control.c   |     7 +-
 .../amd/display/dc/optc/dcn42/dcn42_optc.h    |   179 +
 .../amd/display/dc/pg/dcn42/dcn42_pg_cntl.h   |    86 +
 .../gpu/drm/amd/display/dc/resource/Makefile  |     7 +
 .../dc/resource/dcn401/dcn401_resource.c      |     4 +-
 .../dc/resource/dcn42/dcn42_resource.c        |    17 +-
 .../dc/resource/dcn42/dcn42_resource.h        |     3 +-
 .../dc/resource/dcn42b/dcn42b_resource.c      |  2404 +
 .../dc/resource/dcn42b/dcn42b_resource.h      |   672 +
 .../dcn42/dcn42_soc_and_ip_translator.c       |     6 +-
 .../soc_and_ip_translator.c                   |     1 +
 drivers/gpu/drm/amd/display/dmub/dmub_srv.h   |     1 +
 .../gpu/drm/amd/display/dmub/inc/dmub_cmd.h   |   606 +-
 drivers/gpu/drm/amd/display/dmub/src/Makefile |     1 +
 .../drm/amd/display/dmub/src/dmub_dcn42b.c    |    34 +
 .../drm/amd/display/dmub/src/dmub_dcn42b.h    |    13 +
 .../gpu/drm/amd/display/dmub/src/dmub_srv.c   |     4 +
 .../amd/display/include/bios_parser_types.h   |     1 +
 .../gpu/drm/amd/display/include/dal_asic_id.h |     3 +
 .../gpu/drm/amd/display/include/dal_types.h   |     1 +
 .../drm/amd/display/modules/hdcp/hdcp_ddc.c   |     3 +-
 .../gpu/drm/amd/display/modules/power/power.c |     9 +-
 .../drm/amd/display/modules/power/power_abm.c |    16 +-
 .../include/asic_reg/clk/clk_15_0_5_offset.h  |    41 +
 .../include/asic_reg/clk/clk_15_0_5_sh_mask.h |    44 +
 .../include/asic_reg/dcn/dcn_4_2_1_offset.h   | 16304 +++++
 .../include/asic_reg/dcn/dcn_4_2_1_sh_mask.h  | 60622 ++++++++++++++++
 .../include/asic_reg/dpcs/dpcs_4_0_1_offset.h |   108 +
 .../asic_reg/dpcs/dpcs_4_0_1_sh_mask.h        |   412 +
 108 files changed, 85760 insertions(+), 342 deletions(-)
 create mode 100644 drivers/gpu/drm/amd/display/dc/clk_mgr/dcn42b/dcn42b_clk_mgr.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/clk_mgr/dcn42b/dcn42b_clk_mgr.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/dml2_0/dml21/inc/bounding_boxes/dcn42b_soc_bb.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/gpio/dcn42b/hw_factory_dcn42b.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/gpio/dcn42b/hw_factory_dcn42b.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/gpio/dcn42b/hw_translate_dcn42b.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/gpio/dcn42b/hw_translate_dcn42b.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/hwss/dcn42b/dcn42b_hwseq.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/hwss/dcn42b/dcn42b_hwseq.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/hwss/dcn42b/dcn42b_init.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/hwss/dcn42b/dcn42b_init.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/resource/dcn42b/dcn42b_resource.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/resource/dcn42b/dcn42b_resource.h
 create mode 100644 drivers/gpu/drm/amd/display/dmub/src/dmub_dcn42b.c
 create mode 100644 drivers/gpu/drm/amd/display/dmub/src/dmub_dcn42b.h
 create mode 100644 drivers/gpu/drm/amd/include/asic_reg/clk/clk_15_0_5_offset.h
 create mode 100644 drivers/gpu/drm/amd/include/asic_reg/clk/clk_15_0_5_sh_mask.h
 create mode 100644 drivers/gpu/drm/amd/include/asic_reg/dcn/dcn_4_2_1_offset.h
 create mode 100644 drivers/gpu/drm/amd/include/asic_reg/dcn/dcn_4_2_1_sh_mask.h
 create mode 100644 drivers/gpu/drm/amd/include/asic_reg/dpcs/dpcs_4_0_1_offset.h
 create mode 100644 drivers/gpu/drm/amd/include/asic_reg/dpcs/dpcs_4_0_1_sh_mask.h

-- 
2.43.0

