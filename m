Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE874C531CC
	for <amd-gfx@archiver.kernel.org>; Thu, 23 Jul 2026 20:18:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EDEA610E5EC;
	Thu, 23 Jul 2026 20:18:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="OCfOigwl";
	dkim-atps=neutral
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010067.outbound.protection.outlook.com [52.101.85.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ABA6210E5EC
 for <amd-gfx@lists.freedesktop.org>; Thu, 23 Jul 2026 20:18:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qByyEGeN3Z2JKitt58uvIoqwApKaDkPBZDvez9FE+3R/rkTViWDH1lKcw3pqv30GS9eIkN8qbWXp16/Y29/ulDDY7jievd9HzKyyus1GlF90ZPkmFY/kjti1B0i5SuAZ6VZqgGgoUJyYYVh/kEO8Y85eVc+9ciaCj9y1nYjSNji8M1daTn2odcFK+gbwT3FnHywCZNntEpgwl3fRUzhgGviTktWZKgnO1fL4q/WXdpLinxFvGlJCy7hVQnHERON7lIpb25Olma1c16rRgcy4vEfDH2rMMelhnORSdqY90ftwgqc3NA7/EIqB1Mva2uNCFTaWN7zJkgBTEqTjrHcP8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MSWjGMQLDRtALcmcByebTDrp5qTYS0R2DmbKw48qiRc=;
 b=HjibOi1x9ml23B88UY5BWzMjeRuEYGc/KBRy5QMePqC9p2ztXedwaAptazbmXm5OCpWM7HtfRy+ohSA/ztZaIHewRhEbbUNO8Hmba1BW1UWJmEk6piw8JGs3kOg8ZOYlqHFYuGe29rWafsWaR3VuMT/9/XAwKtZS22Xle2ehYHGHTIg1WOCEYdqRtMNE/nTrDo3nHQmeMiCyaJvjwH5iuSFIKv9fFM2+aCdcWF4K4jB2QgQxF5gWA6HtK+Xtd+e3ffgvf/G0+Q4VjzbLjWZZjbi4nOoY1hDdfZFDoU8WNxuPwigRYnBR7aGfoeh6g0gn18k4PW01bCU1j5nZwgHGzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MSWjGMQLDRtALcmcByebTDrp5qTYS0R2DmbKw48qiRc=;
 b=OCfOigwlTIELOdvFqU/EPM5iBJTjTUIUazxhsCrUcTVfbFsNGvh2pyuHpOmKfaMLi1iTOd66w1Iqpdc6Wx2xvy7n/MQX4a2XzklzsxJ3qPgALG1rnAl+V62oQFgPQjpHChZbdB/TWxPpQ2PiWrVKlQZJW35VnBlcSbGCYeD9210=
Received: from MN0P223CA0024.NAMP223.PROD.OUTLOOK.COM (2603:10b6:208:52b::31)
 by SAVPR12MB999144.namprd12.prod.outlook.com (2603:10b6:806:4e6::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.10; Thu, 23 Jul
 2026 20:18:51 +0000
Received: from BL02EPF00021F6D.namprd02.prod.outlook.com
 (2603:10b6:208:52b:cafe::58) by MN0P223CA0024.outlook.office365.com
 (2603:10b6:208:52b::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.245.11 via Frontend Transport; Thu,
 23 Jul 2026 20:18:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL02EPF00021F6D.mail.protection.outlook.com (10.167.249.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.270.5 via Frontend Transport; Thu, 23 Jul 2026 20:18:49 +0000
Received: from jzuo.laptop (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 23 Jul
 2026 15:18:47 -0500
From: Fangzhi Zuo <jerry.zuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>
Subject: [PATCH 00/49] DC Patches July 20th, 2026
Date: Thu, 23 Jul 2026 16:13:08 -0400
Message-ID: <20260723201908.373300-1-jerry.zuo@amd.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF00021F6D:EE_|SAVPR12MB999144:EE_
X-MS-Office365-Filtering-Correlation-Id: 16873fb1-fcb9-45a1-4b04-08dee8f79b40
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|376014|23010399003|82310400026|1800799024|56012099006|11063799006|10067099003|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info: tIGGNatUAGi1wbv1vqNt5utFwxsVFQqca2aZJA1iQgD+AFubkAM9/ORNYXmhxUtiNRJyqunmFQHm2FvosvmqQ+9irmf12wlE80vCDJ+5ilDwaKbD0bb5+qKwgIXzoV4w5s8gHFyqD6EXQZZQ4taHIWm3b4Em5rOBSUQioIENXsFrcBfNKQccMv2F6aDqQFIIi8ihGGxoC3XeLJauFUxrNaNlRMDhDlnhG+sra8u9lnlxBmIvr66+ZwaBXbPIIsIigaVwi9r9OZMIMXGGwU4jmJCe5j/QSoN2wpoUvDQnLgW5eUBiHwhq+kIPJeOtOG+US8lj7TtvyA48TNYb+J3XAeQTYyqz9Tw5cxyBohOO0eO7UbOAjtBlhpE7dSxXUen7CIecz8zp/cYu+paIMqxuH5SNXK2JritI+hZdpSNHeUfMFKomnHbnebp4Eu+5intENbcyNBkD7edw0XM9tnJuL89U4mFmP6APZUQz1KLYdps/4+EXJvlm6cQv/6jtf9dXEY/00DRQBasB5vEHv+Vh45ssZKZWTXW59LaQtcTajADnBazg/D1Gb7rvo+y4rQ9YIzi3JIoyTQ9DnItzsCIgrTO6ACskXE4bbnG9ECSJws07S/r25N1NmCTLu32DkJgjKJwfFwNbIC2VWn0YItKAOPJS6MWXy6MCPkUpZ8TQDXNUmjIAXWRFjALYo3mBtqpMkFQT5T4d4znXcI2Zptki7Q==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(376014)(23010399003)(82310400026)(1800799024)(56012099006)(11063799006)(10067099003)(18002099003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: bRRYTp69gzQ/jHFdxqVjIv5nkDmH/zcaC5qC6hxvMXnv2LcYYkeoCgoeCGQe5GlRdllJF7HgrVCBmGBJ0LrZb2qTPUO74mnxhR3uI6ZDOWzBuw8YJYm3lH6qAWjkGStBIxWkmg/Rrsl6r+QaRK0lt+Ke9woG2NB5Cb+nCkOZXYmBKUzbCbM/IsUP/sb+vK+gRfWWteqAMskfDGJemWX/SGU3Taz99Yn4h40j7uAdZArEQvQAu3UcbZra4WQxqmYdNesVJIVZI35DBGtAxSFkmXln1WsoKxUKCQkUiO0XGYC9CctpORZ8B21mVMj2P23MJfJb/k+oakYojfdof6dOeKmvm2b/db/NidvDPRgRjUj+yrecWN98CLwYdKZ5WB46TRUhC6V2GW9fTci8qL1V4XmOOBJJGMAL99Rjht5lVUYo86hHTc16a56CKLIiOxgn
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2026 20:18:49.1999 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 16873fb1-fcb9-45a1-4b04-08dee8f79b40
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF00021F6D.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SAVPR12MB999144
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
* Expand KUnit test
* dm refactor ongoing
* Fix apple 5k tiled monitor light up
* Fix frl dsc upstream mistake
* dcn42 fixes

Alex Deucher (1):
  drm/amd/display: check if dml21_add_phantom_plane() is successful

Alex Hung (16):
  drm/amd/display: share common DM KUnit helpers
  drm/amd/display: move scaling helper to connector
  drm/amd/display: move stutter quirk to quirks file
  drm/amd/display: move watermarks table to pp_smu
  drm/amd/display: move GPU mem helpers to services
  drm/amd/display: add FreeSync/VRR module
  drm/amd/display: add cursor module
  drm/amd/display: add KUnit tests for audio component get_eld
  drm/amd/display: add KUnit tests for audio commit path
  drm/amd/display: Add KUnit test for native backlight registration
  drm/amd/display: Add color transfer-function tests
  drm/amd/display: Add atomic transfer-function tests
  drm/amd/display: Add CRTC and plane degamma tests
  drm/amd/display: Add legacy plane LUT tests
  drm/amd/display: Add truncated colorop tests
  drm/amd/display: Add colorop LUT programming tests

Alexander Chechik (2):
  drm/amd/display: enforce UCLK pstate support in mode_support
  drm/amd/display: plumb PMO per-plane pstate methods into mode_support

Bhawanpreet Lakha (13):
  drm/amd/display: Add KUnit tests for link_lock and psp SRM helpers
  drm/amd/display: Add KUnit tests for HDCP display helpers
  drm/amd/display: Add KUnit tests for event_callback
  drm/amd/display: Add KUnit tests for event_property_validate
  drm/amd/display: Add KUnit tests for watchdog and cpirq events
  drm/amd/display: Add KUnit tests for hdcp_destroy
  drm/amd/display: Add KUnit tests for enable_assr
  drm/amd/display: Add KUnit tests for update_config
  drm/amd/display: Add KUnit tests for hdcp_create_workqueue
  drm/amd/display: Add KUnit tests for srm_data_write and srm_data_read
  drm/amd/display: Add KUnit tests for HDCP DDC link adapters
  drm/amd/display: Add initialized-branch test for psp_set_srm
  drm/amd/display: Add deeper event_property_update tests

Charlene Liu (2):
  drm/amd/display: revert "convert dcn42 GPIO translation to lookup
    tables"
  drm/amd/display: change dcc_rate from 1 to 2 for log use only

Clay King (1):
  drm/amd/display: adjust floating point format for gamut remap when
    needed

Dillon Varone (1):
  drm/amd/display: Port DCN4+ MCIF ARB programming to new format

Fangzhi Zuo (2):
  drm/amd/display: Prune per-tile Timing from Apple Studio Display
    Primary Tile
  drm/amd/display: dispatch compressed FRL cap check inside
    dml1_frl_cap_chk_inter

George Zhang (1):
  drm/amd/display: Fix divide-by-zero in calculate_mcache_setting on
    zero viewport

Huang, Leon (1):
  drm/amd/display: Add get replay residency function

Justin Chen (1):
  drm/amd/display: add DalForceMaxDisplayClock debug option to DML2

Matthew Stewart (2):
  drm/amd/display: Fixes for dcn42b_soc_bb.h
  drm/amd/display: Fix rounding errors in CalculatePrefetchSchedule

Nicholas Carbones (2):
  drm/amd/display: Correct vblank_end calc for fams cmd packet
  drm/amd/display: Reintroduce "convert dcn42 GPIO translation to lookup
    tables"

Ray Wu (1):
  drm/amd/display: Add AV mute wait frames to dce110_set_avmute

Relja Vojvodic (1):
  drm/amd/display: Fix force FRL rate debug setting

Santhosh, Ashwin (1):
  drm/amd/display: Promote DC to 3.2.391

Tomasz Siemek (1):
  drm/amd/display: Use current mpc pipe in set output transfer func

 .../gpu/drm/amd/display/amdgpu_dm/Makefile    |    4 +-
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |  981 +-------
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h |   37 +-
 .../amd/display/amdgpu_dm/amdgpu_dm_audio.c   |    1 +
 .../amd/display/amdgpu_dm/amdgpu_dm_color.c   |   36 +-
 .../amd/display/amdgpu_dm/amdgpu_dm_color.h   |   14 +
 .../display/amdgpu_dm/amdgpu_dm_connector.c   |  100 +
 .../amd/display/amdgpu_dm/amdgpu_dm_cursor.c  |  443 ++++
 .../amd/display/amdgpu_dm/amdgpu_dm_cursor.h  |   52 +
 .../display/amdgpu_dm/amdgpu_dm_freesync.c    |  362 +++
 .../display/amdgpu_dm/amdgpu_dm_freesync.h    |   65 +
 .../amd/display/amdgpu_dm/amdgpu_dm_hdcp.c    |   99 +-
 .../amd/display/amdgpu_dm/amdgpu_dm_hdcp.h    |   37 +
 .../amd/display/amdgpu_dm/amdgpu_dm_pp_smu.c  |   52 +
 .../amd/display/amdgpu_dm/amdgpu_dm_pp_smu.h  |    3 +
 .../amd/display/amdgpu_dm/amdgpu_dm_quirks.c  |   32 +
 .../display/amdgpu_dm/amdgpu_dm_services.c    |   53 +
 .../drm/amd/display/amdgpu_dm/tests/Makefile  |    2 +
 .../amdgpu_dm/tests/amdgpu_dm_audio_test.c    |  651 ++++++
 .../tests/amdgpu_dm_backlight_test.c          |   61 +-
 .../amdgpu_dm/tests/amdgpu_dm_color_test.c    |  602 +++++
 .../tests/amdgpu_dm_connector_test.c          |  209 ++
 .../amdgpu_dm/tests/amdgpu_dm_crtc_test.c     |   30 +-
 .../amdgpu_dm/tests/amdgpu_dm_cursor_test.c   |  268 +++
 .../amdgpu_dm/tests/amdgpu_dm_freesync_test.c |  453 ++++
 .../amdgpu_dm/tests/amdgpu_dm_hdcp_test.c     | 2063 ++++++++++++++++-
 .../amdgpu_dm/tests/amdgpu_dm_irq_test.c      |   32 +-
 .../amdgpu_dm/tests/amdgpu_dm_kunit_helpers.c |   39 +-
 .../tests/amdgpu_dm_kunit_test_helpers.h      |    4 +
 .../amdgpu_dm/tests/amdgpu_dm_pp_smu_test.c   |   20 +
 .../amdgpu_dm/tests/amdgpu_dm_psr_test.c      |   15 +-
 .../amdgpu_dm/tests/amdgpu_dm_quirks_test.c   |   65 +
 .../display/amdgpu_dm/tests/amdgpu_dm_test.c  |  937 --------
 .../drm/amd/display/dc/basics/conversion.c    |   61 +-
 .../drm/amd/display/dc/basics/conversion.h    |   12 +-
 .../drm/amd/display/dc/core/dc_hw_sequencer.c |    4 +-
 .../drm/amd/display/dc/core/dc_link_exports.c |    7 +
 .../gpu/drm/amd/display/dc/core/dc_stream.c   |    4 +-
 drivers/gpu/drm/amd/display/dc/dc.h           |   11 +-
 .../drm/amd/display/dc/dce/dce_transform.c    |    4 +-
 .../drm/amd/display/dc/dml/dml1_frl_cap_chk.c |   10 +-
 .../dml2_0/dml21/dml21_translation_helper.c   |    8 +-
 .../amd/display/dc/dml2_0/dml21/dml21_utils.c |   15 +-
 .../dc/dml2_0/dml21/dml21_wrapper_fpu.c       |    5 +
 .../dml21/inc/bounding_boxes/dcn42b_soc_bb.h  |    4 +-
 .../dml21/src/dml2_core/dml2_core_dcn4.c      |    4 +
 .../src/dml2_core/dml2_core_dcn4_calcs.c      |   67 +-
 .../src/dml2_core/dml2_core_shared_types.h    |    1 +
 .../dml21/src/dml2_pmo/dml2_pmo_dcn42.c       |   32 +-
 .../dml21/src/dml2_pmo/dml2_pmo_dcn4_fams2.c  |    2 +-
 .../amd/display/dc/dpp/dcn10/dcn10_dpp_cm.c   |    8 +-
 .../amd/display/dc/dpp/dcn20/dcn20_dpp_cm.c   |    8 +-
 .../amd/display/dc/dpp/dcn30/dcn30_dpp_cm.c   |    8 +-
 .../amd/display/dc/dwb/dcn30/dcn30_dwb_cm.c   |    3 +-
 .../dc/gpio/dcn42/hw_translate_dcn42.c.orig   |  206 ++
 .../amd/display/dc/hwss/dce110/dce110_hwseq.c |   21 +-
 .../display/dc/link/protocols/link_hdmi_frl.c |    2 +-
 .../gpu/drm/amd/display/dc/mmhubbub/Makefile  |   10 +
 .../dc/mmhubbub/dcn32/dcn32_mmhubbub.c        |    4 +-
 .../dc/mmhubbub/dcn32/dcn32_mmhubbub.h        |    5 +
 .../dc/mmhubbub/dcn401/dcn401_mmhubbub.c      |  135 ++
 .../dc/mmhubbub/dcn401/dcn401_mmhubbub.h      |   40 +
 .../dc/mmhubbub/dcn42/dcn42_mmhubbub.h        |    1 +
 .../drm/amd/display/dc/mpc/dcn30/dcn30_mpc.c  |   44 +-
 .../amd/display/dc/mpc/dcn401/dcn401_mpc.c    |   69 +-
 .../amd/display/dc/mpc/dcn401/dcn401_mpc.h    |    6 +-
 .../dc/resource/dcn30/dcn30_resource.c        |    2 +
 .../dc/resource/dcn301/dcn301_resource.c      |    2 +
 .../dc/resource/dcn302/dcn302_resource.c      |    2 +
 .../dc/resource/dcn303/dcn303_resource.c      |    2 +
 .../dc/resource/dcn31/dcn31_resource.c        |    2 +
 .../dc/resource/dcn314/dcn314_resource.c      |    2 +
 .../dc/resource/dcn315/dcn315_resource.c      |    2 +
 .../dc/resource/dcn316/dcn316_resource.c      |    2 +
 .../dc/resource/dcn32/dcn32_resource.c        |    2 +
 .../dc/resource/dcn321/dcn321_resource.c      |    2 +
 .../dc/resource/dcn35/dcn35_resource.c        |    2 +
 .../dc/resource/dcn351/dcn351_resource.c      |    2 +
 .../dc/resource/dcn36/dcn36_resource.c        |    2 +
 .../dc/resource/dcn401/dcn401_resource.c      |   31 +-
 .../dc/resource/dcn401/dcn401_resource.h      |    4 +
 .../dc/resource/dcn42/dcn42_resource.c        |   30 +-
 .../dc/resource/dcn42b/dcn42b_resource.c      |    2 +
 83 files changed, 6482 insertions(+), 2254 deletions(-)
 create mode 100644 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_cursor.c
 create mode 100644 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_cursor.h
 create mode 100644 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_freesync.c
 create mode 100644 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_freesync.h
 create mode 100644 drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_cursor_test.c
 create mode 100644 drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_freesync_test.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/gpio/dcn42/hw_translate_dcn42.c.orig
 create mode 100644 drivers/gpu/drm/amd/display/dc/mmhubbub/dcn401/dcn401_mmhubbub.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/mmhubbub/dcn401/dcn401_mmhubbub.h

-- 
2.53.0

