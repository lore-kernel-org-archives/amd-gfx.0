Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE46ECD98C7
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Jun 2026 09:48:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 804E210E854;
	Wed, 10 Jun 2026 09:48:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="sYnCNUZj";
	dkim-atps=neutral
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011047.outbound.protection.outlook.com [40.107.208.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2C09A10E4FF
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 Jun 2026 09:48:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Nu/ndF2AbA88l5HRXE/v6nS0+32E1b1YrhhBacRpjSTPpRUnQi9fY8zwdWKycvpiIv4MJgFixQOXuiL7os0IDwmXxZ/X79XjWqPLiOQt/zZBLIjCQuybG8lxi6JAReHHYGXO9UB16MkEaZi3JT0VE/b+YjwrNyKG2JThU8mX9wI9zHpynYjH8ER1aOYHI4fYRCv+jqxsfhDLzxw/OJrsKUBYA1RtIXv9pJExpgtzuLuPF7bHtZJaY1gpdvVWsEuSk/GYbG+wImFIV8ZtnOeWSzDPtTQHheGd9qM9P092ZmYu2De0zi6eMwlf8EVOXn8DaJOhsJA8b7PrtUhPzBlwCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M2gK7nxKYV2bq9XTrl7h9usBP64FE+xaGVonA0WW5FA=;
 b=RTjtofxeMPGZhede/5/bJ84Xjts5zbUmh3lDoRHvlLk8I+mf0rw0ECsZzHM7E3jdKnQ1XhEfQ43MxKmNhQP4Qvex5/sN5mc5gqacLEos152dgIuGZd75HHEx+TOlHWUf9CBLCq5QwKV6XKWhqt3uIlqkLkus8n39mH7kBIwxBQ7wpuvkSR+yyo1N2n5/PM3xKmnZs8V+YqRGCHWOU4UkVhnb0YcuE6i91SZEXwmLbhrF5pRMB9Ueax5nr2GaEIpbuTOrcZ+3On6Fd/L/MskCh58f3JSNAM0+dJL5yLHJCrx0cRVCLmz0pyvZOZfcbKUboudNypgEUfG2PtO+/lN8Gw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M2gK7nxKYV2bq9XTrl7h9usBP64FE+xaGVonA0WW5FA=;
 b=sYnCNUZjvg9cYoI11IG0+C0HNwCCQ5TASbetjy4cmzIiIEOyuu75P55hei9fIbTJcokog5+TuNMGmqB84JvJHTJsGgU6GXw/XUOSvTUjD1T5+2N7YpznG2sYSCbVvGeI4E/nq5C+99cZv4SwN2NfCtEF0T2grB/HM9dz4QB28Wc=
Received: from MN2PR22CA0028.namprd22.prod.outlook.com (2603:10b6:208:238::33)
 by PH7PR12MB7114.namprd12.prod.outlook.com (2603:10b6:510:1ed::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.11; Wed, 10 Jun
 2026 09:47:58 +0000
Received: from BN2PEPF00004FBB.namprd04.prod.outlook.com
 (2603:10b6:208:238:cafe::a3) by MN2PR22CA0028.outlook.office365.com
 (2603:10b6:208:238::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.113.10 via Frontend Transport; Wed,
 10 Jun 2026 09:47:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF00004FBB.mail.protection.outlook.com (10.167.243.181) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.113.7 via Frontend Transport; Wed, 10 Jun 2026 09:47:57 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 10 Jun
 2026 04:47:56 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 10 Jun
 2026 04:47:56 -0500
Received: from chenyu-station.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Wed, 10 Jun 2026 04:47:48 -0500
From: Chenyu Chen <chen-yu.chen@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Chenyu Chen <chen-yu.chen@amd.com>
Subject: [PATCH 00/32] DC Patches Jun 15 2026
Date: Wed, 10 Jun 2026 17:44:44 +0800
Message-ID: <20260610094639.1965367-1-chen-yu.chen@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF00004FBB:EE_|PH7PR12MB7114:EE_
X-MS-Office365-Filtering-Correlation-Id: bada56d9-73ae-4229-4bc4-08dec6d559ed
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|376014|1800799024|23010399003|82310400026|11063799006|56012099006|3023799007|6133799003|18002099003;
X-Microsoft-Antispam-Message-Info: ciSTN7idFsQ2g16SdtlKpNDbV7rfpM/cyrtfyMq+qHlOvxWORbFdLVeQ1LeJfgiJAa81SqF3Fb7khaY/M2yjOlPs1rPSbyOxKlTQKJI4DvgP6uauQOTod4dSdxdD6/3w3ynqV7Pmwz/M7Xphr0Lv671pqTzfeEtacvqMvjTYQSkSfRFksQIhkUSNoDyN8HfpAyNGZVk1PrkXESc8e3FmEfU8rCH1Rw9QyYacrjrAPYjPCc+wt4K6yi9xwQ7SmkB+44iSkiI8Uv5pC5gRpcF+UuwktAcoBFT4qIDDcoWojLr7oyWEBG6ItyefP7p4HR3piM4DJVsJGCMaWPplvjxlv4F+b4aWELfHeXi4V+1PfYporxbFgJV2cQ2pImRS/Io7enAUTcv9MXOsKQ0AcLeHkGrJ5N8VvxP0mz2jww/lhlMW2WMvbf4bN6SGfjbIRBaYlkbaENx0A3Ls/4kCRgKQZ2xUs38BgtSUBYUd4o4WDQdGMZwjWh6bamBcHKenNbpKocGr+Jy26opKVOqgGIaUGmeQj1V9BSJKzfGGPeSs922wZWEB05yH9yJd+pjtP9Sium9/j48LwvwqP6vc5mL5XVweZ3ZBpFWqGENcRn60Lttymr006n2Fhq/smI6AhuMaD7wggpFmum65ciNpGq27F1SOqlU2ncZiuKppYZsF3cmBiJFl7AAWFBJVPc0/ksZSsA9iwV8U5fENE98wl36i/XH1w1MOA0EeAu3ovcenBvI=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(376014)(1800799024)(23010399003)(82310400026)(11063799006)(56012099006)(3023799007)(6133799003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: QaCpV/Cg6GJzR4QHdk2CAQOV//xjq8mrU0t0xjyVtIpAF26nqj1C1qX3PVFKpFQL0JAduS5Rn8PH3hTyNW+08uJb7lddwjAtlTvDWFfZhpH4Rgax+PQVev94mb4t1V448KpIP08wizgCo7EfJAhmZSoxOVECCml5eucbtv0Hi99eNYwpg+2X6/TYT60gb6AVDFQRnAZfktHfCWLrHBC2gqq5XjyFOMNP2h61rsgghHlByNIBe6cCI3VfsLRFU3Niuywv86GUKiJYNdDWoJjka8h0gdokmQp7T4amOCkIJpCMLFxLdFX4V6zMUUUF8UspaqVu9vveN0q9NGt64OQWR7j4HbG6ONXhc2YzpsRm2squ7tNaj4JaKYWcs/NyBdtXic1Nfx2QwUMf9soos0DA+Yggnd3yqy08ElF/Orn6UWIZeTrMeigCvPk+TAcgT/84
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2026 09:47:57.1820 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bada56d9-73ae-4229-4bc4-08dec6d559ed
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF00004FBB.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7114
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

 - Major amdgpu_dm refactoring into modular components
   (backlight, audio, DMUB, IRQ, connector)
 - Enhancements in clock management and DCN4 pstate handling
 - HDMI pipeline cleanup and compliance automation support
 - Introduction of dc_plane_cm and surface update refactor
 - Backlight handling improvements without ACPI dependency
 - Addition of KUnit tests to improve test coverage
 - Firmware update to version 0.1.63.0

Cc: Daniel Wheeler <daniel.wheeler@amd.com>

Alex Hung (19):
  drm/amd/display: Extract backlight code to amdgpu_dm_backlight
  drm/amd/display: Extract audio code to amdgpu_dm_audio
  drm/amd/display: Extract DMUB code to amdgpu_dm_dmub
  drm/amd/display: Move HPD and IRQ handler code to amdgpu_dm_irq
  drm/amd/display: Extract connector and encoder code to
    amdgpu_dm_connector
  drm/amd/display: Fix conflicting types for dc_plane_cm functions
  drm/amd/display: Add KUnit tests for amdgpu_dm
  drm/amd/display: Add KUnit tests for amdgpu_dm_backlight
  drm/amd/display: Add KUnit tests for amdgpu_dm_audio
  drm/amd/display: Add KUnit tests for amdgpu_dm_dmub
  drm/amd/display: Add KUnit tests for amdgpu_dm_connector
  drm/amd/display: Add KUnit tests for amdgpu_dm_irq
  drm/amd/display: Add KUnit tests for amdgpu_dm_crtc
  drm/amd/display: Add KUnit tests for amdgpu_dm_services
  drm/amd/display: Add KUnit tests for amdgpu_dm_helpers
  drm/amd/display: Add KUnit tests for amdgpu_dm_quirks
  drm/amd/display: Add more KUnit tests for amdgpu_dm_pp_smu
  drm/amd/display: Add more KUnit tests for amdgpu_dm_mst_types
  drm/amd/display: Move backlight macros to backlight header

Fangzhi Zuo (1):
  drm/amd/display: Add Support for HDMI Compliance Automation

Gabe Teeger (2):
  drm/amd/display: Increase dcn42b uclk value
  drm/amd/display: Enable pstate for DCN4 non-emulation builds

Mario Limonciello (1):
  drm/amd/display: Set default backlight without ACPI support

Nicholas Kazlauskas (1):
  drm/amd/display: Add a new interface to set idle opts in clock manager

Rafal Ostrowski (2):
  drm/amd/display: Introduce dc_plane_cm and migrate surface update
    color path
  drm/amd/display: Refactor surface_update_flags to flat struct with
    helpers

Robin Chen (1):
  drm/amd/display: Add PSR Active VTotal Control capability

Taimur Hassan (2):
  drm/amd/display: [FW Promotion] Release 0.1.63.0
  drm/amd/display: Promote DC to 3.2.386

Wenjing Liu (3):
  drm/amd/display: Add utm_qos_model pointer to clk_bw_params
  drm/amd/display: Remove get_utm_qos_model from soc_and_ip_translator
  drm/amd/display: Remove unused project_id from DML2 core instance

 .../gpu/drm/amd/display/amdgpu_dm/Makefile    |     6 +-
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 11981 ++++------------
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h |    79 +-
 .../amd/display/amdgpu_dm/amdgpu_dm_audio.c   |   323 +
 .../amd/display/amdgpu_dm/amdgpu_dm_audio.h   |    56 +
 .../display/amdgpu_dm/amdgpu_dm_backlight.c   |   704 +
 .../display/amdgpu_dm/amdgpu_dm_backlight.h   |    67 +
 .../amd/display/amdgpu_dm/amdgpu_dm_color.c   |    69 +-
 .../amd/display/amdgpu_dm/amdgpu_dm_color.h   |     8 +-
 .../display/amdgpu_dm/amdgpu_dm_connector.c   |  3581 +++++
 .../display/amdgpu_dm/amdgpu_dm_connector.h   |   162 +
 .../amd/display/amdgpu_dm/amdgpu_dm_crtc.c    |    14 +-
 .../amd/display/amdgpu_dm/amdgpu_dm_crtc.h    |     6 +
 .../amd/display/amdgpu_dm/amdgpu_dm_debugfs.c |    69 +-
 .../amd/display/amdgpu_dm/amdgpu_dm_dmub.c    |   934 ++
 .../amd/display/amdgpu_dm/amdgpu_dm_dmub.h    |    68 +
 .../amd/display/amdgpu_dm/amdgpu_dm_helpers.c |    64 +-
 .../amd/display/amdgpu_dm/amdgpu_dm_helpers.h |    20 +
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c |  1511 +-
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_irq.h |    27 +
 .../amdgpu_dm/amdgpu_dm_kunit_helpers.h       |     1 +
 .../display/amdgpu_dm/amdgpu_dm_mst_types.c   |   145 +-
 .../display/amdgpu_dm/amdgpu_dm_mst_types.h   |    12 +
 .../amd/display/amdgpu_dm/amdgpu_dm_pp_smu.c  |   234 +-
 .../amd/display/amdgpu_dm/amdgpu_dm_pp_smu.h  |    22 +
 .../amd/display/amdgpu_dm/amdgpu_dm_quirks.c  |     2 +
 .../display/amdgpu_dm/amdgpu_dm_services.c    |     7 +
 .../drm/amd/display/amdgpu_dm/tests/Makefile  |    11 +
 .../amdgpu_dm/tests/amdgpu_dm_audio_test.c    |   490 +
 .../tests/amdgpu_dm_backlight_test.c          |  1128 ++
 .../amdgpu_dm/tests/amdgpu_dm_color_test.c    |    64 +-
 .../tests/amdgpu_dm_connector_test.c          |  2142 +++
 .../amdgpu_dm/tests/amdgpu_dm_crtc_test.c     |   532 +
 .../amdgpu_dm/tests/amdgpu_dm_dmub_test.c     |   600 +
 .../amdgpu_dm/tests/amdgpu_dm_helpers_test.c  |   645 +
 .../amdgpu_dm/tests/amdgpu_dm_irq_test.c      |   934 ++
 .../tests/amdgpu_dm_mst_types_test.c          |   385 +
 .../amdgpu_dm/tests/amdgpu_dm_pp_smu_test.c   |   736 +
 .../amdgpu_dm/tests/amdgpu_dm_quirks_test.c   |   103 +
 .../amdgpu_dm/tests/amdgpu_dm_services_test.c |   313 +
 .../display/amdgpu_dm/tests/amdgpu_dm_test.c  |   929 ++
 drivers/gpu/drm/amd/display/dc/core/dc.c      |   287 +-
 .../drm/amd/display/dc/core/dc_hw_sequencer.c |    20 +-
 .../gpu/drm/amd/display/dc/core/dc_surface.c  |    44 +-
 drivers/gpu/drm/amd/display/dc/dc.h           |   227 +-
 drivers/gpu/drm/amd/display/dc/dc_dp_types.h  |     1 +
 drivers/gpu/drm/amd/display/dc/dc_stream.h    |    29 +
 drivers/gpu/drm/amd/display/dc/dc_types.h     |    66 +-
 .../drm/amd/display/dc/dml/calcs/dcn_calcs.c  |     2 +-
 .../dml21/inc/bounding_boxes/dcn42b_soc_bb.h  |     2 +-
 .../dml21/src/dml2_core/dml2_core_factory.c   |     2 -
 .../src/dml2_core/dml2_core_shared_types.h    |     2 -
 .../src/inc/dml2_internal_shared_types.h      |     1 -
 .../amd/display/dc/hubp/dcn401/dcn401_hubp.c  |     2 +-
 .../amd/display/dc/hwss/dce110/dce110_hwseq.c |     8 +-
 .../amd/display/dc/hwss/dce60/dce60_hwseq.c   |     8 +-
 .../amd/display/dc/hwss/dcn10/dcn10_hwseq.c   |    62 +-
 .../amd/display/dc/hwss/dcn20/dcn20_hwseq.c   |    76 +-
 .../amd/display/dc/hwss/dcn201/dcn201_hwseq.c |     2 +-
 .../amd/display/dc/hwss/dcn30/dcn30_hwseq.c   |    10 +-
 .../amd/display/dc/hwss/dcn32/dcn32_hwseq.c   |    33 +-
 .../amd/display/dc/hwss/dcn401/dcn401_hwseq.c |   244 +-
 .../amd/display/dc/hwss/dcn401/dcn401_hwseq.h |     2 +-
 .../amd/display/dc/hwss/dcn42/dcn42_hwseq.c   |   318 +-
 .../amd/display/dc/hwss/dcn42/dcn42_hwseq.h   |     5 +-
 .../display/dc/hwss/hw_sequencer_private.h    |     3 +-
 .../gpu/drm/amd/display/dc/inc/hw/clk_mgr.h   |     4 +
 drivers/gpu/drm/amd/display/dc/inc/hw/hubp.h  |     2 +-
 .../display/dc/inc/soc_and_ip_translator.h    |    14 -
 .../dc/link/protocols/link_dp_capability.c    |     6 +-
 .../dc/resource/dcn42b/dcn42b_resource.c      |     2 +-
 .../gpu/drm/amd/display/dmub/inc/dmub_cmd.h   |   178 +-
 .../amd/display/include/ddc_service_types.h   |     1 +
 73 files changed, 20422 insertions(+), 10425 deletions(-)
 create mode 100644 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_audio.c
 create mode 100644 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_audio.h
 create mode 100644 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_backlight.c
 create mode 100644 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_backlight.h
 create mode 100644 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c
 create mode 100644 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.h
 create mode 100644 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_dmub.c
 create mode 100644 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_dmub.h
 create mode 100644 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.h
 create mode 100644 drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_audio_test.c
 create mode 100644 drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_backlight_test.c
 create mode 100644 drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_connector_test.c
 create mode 100644 drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_crtc_test.c
 create mode 100644 drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_dmub_test.c
 create mode 100644 drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_helpers_test.c
 create mode 100644 drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_irq_test.c
 create mode 100644 drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_quirks_test.c
 create mode 100644 drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_services_test.c
 create mode 100644 drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_test.c

-- 
2.43.0

