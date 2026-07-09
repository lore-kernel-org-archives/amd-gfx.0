Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA1C6C43458
	for <amd-gfx@archiver.kernel.org>; Thu,  9 Jul 2026 21:01:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2B30D10E0D4;
	Thu,  9 Jul 2026 21:01:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="lLC9mvLV";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013029.outbound.protection.outlook.com
 [40.93.201.29])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6AFDD10E0D4
 for <amd-gfx@lists.freedesktop.org>; Thu,  9 Jul 2026 21:01:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vVNSd2VdiaoaLRphs1Jax4vhMB0Tw7KEvVZ5rAuDm1bKNPlF58SxeqyyMrb1v3p2pkKVEpepGeGjnYMY75LQ+XpY/xwYKRNLktUsr74nCkx8EiXO/0w+laNQt99dG3Oo+ivhNZFFAcEAieEfDmEmdGAEsieUjfswvynEgqRLvUzaZE3/2hWVG7okU+a+CLLrKd4B5le/VVDm2AgF9zhUlxn+mKGt1S71oJUSjIxNjZGGYxwKWaWWXHPo/uoVr1FXZ141jaANw9uIly+3YeH/QwsnJQ7L3XHCd7jr4jxqjlAWjb4ZzmxDz5QuazwyfxU8rUOYbueyJalbAiYctZn5HA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QCsy0dVwrOY/Cl1zpOmv/hOAGQlwox1CQqwWDLcidWQ=;
 b=o6osFMpLsjKFxNNDZLjt3/WQB5QT+d+mRv/S+/k5pJFiCVmpMqyo7cJi3f7OcIIdRxBCv9g0wI8ij5SpL6R+h+84JhmQNgOFa8Z+5+r/9yavtbd3WunVwp4Gc0eqJbu4uoxM5WYnrdj8xv3/A7fz+kg6MkXGJbqy1AeTh3FrFj+fh08q3h9rvkBvSNe7wCKJj2npS7JnM77yXTgy7YHeqG06X0RP90tFAkPmjS3ns5hn912FddYAUYQQBSLYM7V9XmMCkHWfwrhSCTMb3AvVsOkKayeHrRdOg/1MeBCNP5uzgX49nJbrR3F8SMuPAi++ZTJm7jDeqImipC4XfDTs7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QCsy0dVwrOY/Cl1zpOmv/hOAGQlwox1CQqwWDLcidWQ=;
 b=lLC9mvLVsuSKRGKudeW+vYezxEsxf0fIBVbT6+/mnIJRSV0ISTsizR/ZNFqCAd132Fl+rupnlnPXw9wrOum2OTz4E33KX/kmr/ZSv+zsV85ZznxG4mcuKX83jO32IiryVZuFIAB/EXIlocxDwItJAV6sDmzeNBemEULnJA8UeLM=
Received: from PH8P221CA0054.NAMP221.PROD.OUTLOOK.COM (2603:10b6:510:346::24)
 by DM4PR12MB7720.namprd12.prod.outlook.com (2603:10b6:8:100::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.16; Thu, 9 Jul
 2026 21:01:32 +0000
Received: from SA2PEPF00003F64.namprd04.prod.outlook.com
 (2603:10b6:510:346:cafe::aa) by PH8P221CA0054.outlook.office365.com
 (2603:10b6:510:346::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.202.11 via Frontend Transport; Thu, 9
 Jul 2026 21:01:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SA2PEPF00003F64.mail.protection.outlook.com (10.167.248.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Thu, 9 Jul 2026 21:01:31 +0000
Received: from georzhanmkm.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 9 Jul
 2026 16:00:12 -0500
From: George Zhang <george.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, George Zhang <george.zhang@amd.com>
Subject: [PATCH 00/80] DC Patches July 09, 2026
Date: Thu, 9 Jul 2026 16:47:28 -0400
Message-ID: <20260709205936.5719-1-george.zhang@amd.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003F64:EE_|DM4PR12MB7720:EE_
X-MS-Office365-Filtering-Correlation-Id: 04cc0888-b3be-4910-cb82-08deddfd40dd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|23010399003|82310400026|1800799024|376014|18002099003|56012099006|5023799004|11063799006|6133799003|3023799007;
X-Microsoft-Antispam-Message-Info: O8YFo6f3XgpXKzBwMXtnrPeHVgJ/m0zYosN2SVw8kQNO6XEHBZl0wyVnTLrXqqVIHS1Q4mycxfn0ISlpkGtDrq0Pl1kVmb3vlWiU+vkrsL0afkWXkoEn2w4MoXT1KMIEnrOyIpVkL65OuHjnJXWug1VKgdwYypHpGm7KuqhG9nbtsKDMnAOSgGK64kekfMBSwLvjY2/UyHbkzdTnhsTc75gipdYxjpjFxOrUcyHHA2xlY0l9mfXUFHu0m6Q2jsfxu3PZ6T6FHIAVVS8XYClyabTFuq7n142MZDgxSZIzN5lpW0TrYgcsVj8uDLU0SZ5S9eYL+85EwF0qc/H3dBEjW+kpB75yDEgmF56E6VykuF1Dw8aaLaIn/xX7WRCpFFSm5gr8XAXkWPNmUQ+ReVLCsPWU3VmmdWjHvuIg6eeUNEB0oe0K7aIATDt2maTCbGON1jkAcGA8nhmrkgjmAqWJHosa7iJ8JkPMO5Ye/GS6wipIyroYqFTfBXshEsK8sEJdBXnLt+AkrU/NVDEX8JWdKK1UsdnRnlHq/N+5r8JW6pI0fA91ku+mf6JhcbJm/bM8k1do8LxSA2GbLAGredzbO0NC4Ssh1rUgzuX4HUWdyK8gyANmKhQ466nFrN7eP5n7tPe7AY5TNA/1Fmo4Ucgv+OjKbGXUA4QvWoTOSDd0rCkpoUJV7G4ME91rUlqaxiqgKNn2MVfFfrXxf4b2tjzPfQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(23010399003)(82310400026)(1800799024)(376014)(18002099003)(56012099006)(5023799004)(11063799006)(6133799003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: b2CuOnsFmc41XJOnpbhByHkcuVl4mNGx72cm2o+NvfwWbgxRmv/26NTbdxeM4rQ2G/lFBC058grAFOq4/Su6nG5jRQvTBArdOUy+rL80MGuBERpX/xkLwUYtvTjg+wBmqbzFD1ogJp1rns9rQaTV+Q+NGa744p0tjU7jpnzy2hJnIhCO8488Iu5odp/tplbs8sn5uE1Tu1gKPJGtiJJNxYF/dR5Z+GFuBTf6o1+BRFIASR32xIGeGK15lfE/IKQAp25tKqD7x8qKYFvAMMb0aU13DQDXH5LS3Yq5EIiA4k25rn7PfQT5LLy2i/bTKLtga/YP8xi1qUegHm5tM2ONAWE579C+okAF10hUrjZN5cDrCx4eCbk99KCdYJjMA7n5Nd8pMCKsszAu+WA2GLcpNq83Aj9CxwHU1lzy9OYPE2kBmfVxGydULwMLNUxiBRyf
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2026 21:01:31.7539 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 04cc0888-b3be-4910-cb82-08deddfd40dd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00003F64.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7720
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

* Fixes on EDID 8K parsing, cursor mode, backlight, OLED/VABC, and HDR to SDR
* Improvements on DCN42 clocking, det allocation, and power gating
* Greatly enhanced KUnit coverage across amdgpu_dm
* Code cleanup

Cc: Dan Wheeler <daniel.wheeler@amd.com>

Alex Hung (32):
  drm/amd/display: Fix KUnit backlight tests for CACP
  drm/amd/display: Add KUnit tests for ism
  drm/amd/display: Test EDID and ACPI/VBIOS readers
  drm/amd/display: Test DPCD AUX and Synaptics helpers
  drm/amd/display: Test MST start/stop and panel settings
  drm/amd/display: Test I2C, stubs and MST early returns
  drm/amd/display: Test MCCS FreeSync VCP helpers
  drm/amd/display: Test MST payload and DSC enable helpers
  drm/amd/display: Test irq funcs/suspend/workqueue
  drm/amd/display: Test irq state setters and work
  drm/amd/display: Test HPD init/fini
  drm/amd/display: Test HPD interrupt handling
  drm/amd/display: Test dmub HPD callbacks and handlers
  drm/amd/display: Test high-IRQ and handler registration
  drm/amd/display: Test top-level IRQ handler and vmin/vmax worker
  drm/amd/display: Test format info and blending
  drm/amd/display: Test GFX9/GFX10 plane modifiers
  drm/amd/display: Test GFX11/GFX12 plane modifiers
  drm/amd/display: Test plane scaling info paths
  drm/amd/display: Test plane buffer attributes
  drm/amd/display: Test GFX9 DCC plane attributes
  drm/amd/display: Test GFX12 DCC plane attributes
  drm/amd/display: Test DCC and cursor edge cases
  drm/amd/display: Test helper_check_state rejects
  drm/amd/display: Test plane atomic check and hooks
  drm/amd/display: Add KUnit test for wb jobs
  drm/amd/display: Test MST coverage gaps
  drm/amd/display: Test backlight level programming path
  drm/amd/display: Test backlight level readback path
  drm/amd/display: Test backlight device registration
  drm/amd/display: Test panel power savings sysfs
  drm/amd/display: Test backlight ABM property attach

Austin Zheng (1):
  drm/amd/display: Add Debug Option To Enable Per-DPM De-rate Usage

Bhawanpreet Lakha (9):
  drm/amd/display: Add more tests for HDCP
  drm/amd/display: More Kunit tests for audio
  drm/amd/display: Add color space and timing tests for connector
  drm/amd/display: Add subconnector property tests for connector
  drm/amd/display: Add FBC init tests for connector
  drm/amd/display: Add MST link detection tests for connector
  drm/amd/display: Add crtc matching and panel type tests for connector
  drm/amd/display: Add CACP caps tests for connector
  drm/amd/display: Add stream property tests for connector

Bhuvanachandra Pinninti (1):
  drm/amd/display: Fix dc_stream_remove_writeback dropping wrong
    writeback entries.

Charlene Liu (6):
  drm/amd/display: add null pointer access check
  drm/amd/display: ensure dtbclk clk_src selected before
    hdmistream_clk_en
  drm/amd/display: limit reuse dsc capable bootup timing
  drm/amd/display: enable hdmistreamclk_rcg by default for dcn42
  drm/amd/display: add DST_Y_DELTA_DRQ_LIMIT reg macro for later use
  drm/amd/display: add DST_Y_DELTA_DRQ_LIMIT hw programming

Chenyu Chen (3):
  drm/amd/display: Enable CACP on Linux
  drm/amd/display: Fix dead-code panel type detection from DID
  drm/amd/display: Add KUnit tests for CACP on Linux

Dillon Varone (1):
  drm/amd/display: Generalize DMUB memory flushes from host

Dmytro Laktyushkin (4):
  drm/amd/display: update memclk clock table read for dcn42
  drm/amd/display: remove unused dcn42 socbb values
  drm/amd/display: fix dcn42 det allocation order
  drm/amd/display: fix dcn42b det allocation order

Dominik Kaszewski (2):
  drm/amd/display: Remove sink usage from DPMS
  drm/amd/display: Fix indenting of dpms on

Fangzhi Zuo (3):
  drm/amd/display: Fix 8K Mode Not Parsed by EDID
  drm/amd/display: Allocate DCN32/1 dmub memory to GTT
  drm/amd/display: Skip Update HDCP Config In Transition State

Gabe Teeger (3):
  drm/amd/display: Enable PSR and Replay on DCN4 variant [Part 2]
  drm/amd/display: Enable IPS support for DCN4 Variant
  drm/amd/display: Enable zstate support and fix seamless boot

Iswara Nagulendran (1):
  drm/amd/display: Fix VABC Init and OLED Support

James Lin (4):
  drm/amd/display: program dither on all OPP heads under ODM combine
  drm/amd/display: Add MALL status readback support for DCN 4.0.1
  drm/amd/display: Re-evaluate cursor mode on plane position/size change
  drm/amd/display: don't re-evaluate cursor mode on cursor plane
    movement

Karthi Kandasamy (1):
  drm/amd/display: Fix DMSS not triggering for HDR to SDR transition

Leo Chen (1):
  drm/amd/display: Enable HUBP/DPP Driver PG for DCN42

Mario Limonciello (1):
  drm/amd/display: Fix backlight max_brightness to match exported range

Matthew Stewart (3):
  drm/amd/display: Fix DCN42B null registers & register masks
  drm/amd/display: Add passive dongle handling in force_to_use_aux case
  drm/amd/display: Add DCN42B VID_CRC_CONTROL and HBLANK_CONTROL
    registers

Nicholas Kazlauskas (1):
  drm/amd/display: Exit LS for ISHARP before coefficient write

Srinivasan Shanmugam (1):
  drm/amd/display: Check dc_link before applying DSC policy

Taimur Hassan (1):
  drm/amd/display: Promote DC to 3.2.389

Tom Chung (1):
  drm/amd/display: Tear down dangling pipe on boot to fix s0i3

 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |   33 +
 .../amd/display/amdgpu_dm/amdgpu_dm_audio.c   |   36 +-
 .../amd/display/amdgpu_dm/amdgpu_dm_audio.h   |    2 +
 .../display/amdgpu_dm/amdgpu_dm_backlight.c   |   64 +-
 .../display/amdgpu_dm/amdgpu_dm_backlight.h   |   15 +
 .../display/amdgpu_dm/amdgpu_dm_connector.c   |   80 +-
 .../display/amdgpu_dm/amdgpu_dm_connector.h   |   15 +
 .../amd/display/amdgpu_dm/amdgpu_dm_dmub.c    |   16 +-
 .../amd/display/amdgpu_dm/amdgpu_dm_hdcp.c    |   76 +-
 .../amd/display/amdgpu_dm/amdgpu_dm_hdcp.h    |    5 +
 .../amd/display/amdgpu_dm/amdgpu_dm_helpers.c |   90 +-
 .../amd/display/amdgpu_dm/amdgpu_dm_helpers.h |   41 +
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c |   84 +-
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_irq.h |   57 +
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_ism.c |    4 +
 .../display/amdgpu_dm/amdgpu_dm_mst_types.c   |    4 +-
 .../display/amdgpu_dm/amdgpu_dm_mst_types.h   |    1 +
 .../amd/display/amdgpu_dm/amdgpu_dm_plane.c   |   25 +-
 .../amd/display/amdgpu_dm/amdgpu_dm_plane.h   |    9 +
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_wb.c  |    6 +-
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_wb.h  |    4 +
 .../amdgpu_dm/tests/amdgpu_dm_audio_test.c    |  118 +
 .../tests/amdgpu_dm_backlight_test.c          |  734 +++-
 .../tests/amdgpu_dm_connector_test.c          | 1655 +++++++
 .../amdgpu_dm/tests/amdgpu_dm_hdcp_test.c     |  240 +
 .../amdgpu_dm/tests/amdgpu_dm_helpers_test.c  | 3867 +++++++++++++++--
 .../amdgpu_dm/tests/amdgpu_dm_irq_test.c      | 3201 +++++++++++++-
 .../amdgpu_dm/tests/amdgpu_dm_ism_test.c      |  353 ++
 .../tests/amdgpu_dm_mst_types_test.c          |  371 +-
 .../amdgpu_dm/tests/amdgpu_dm_plane_test.c    | 2070 ++++++++-
 .../amdgpu_dm/tests/amdgpu_dm_wb_test.c       |   44 +
 .../display/dc/clk_mgr/dcn42/dcn42_clk_mgr.c  |   16 +-
 drivers/gpu/drm/amd/display/dc/core/dc.c      |  169 +-
 .../gpu/drm/amd/display/dc/core/dc_stream.c   |   21 +-
 drivers/gpu/drm/amd/display/dc/dc.h           |    7 +-
 drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c  |    4 +-
 drivers/gpu/drm/amd/display/dc/dc_types.h     |    8 +
 .../amd/display/dc/dccg/dcn35/dcn35_dccg.c    |    9 +-
 .../amd/display/dc/dccg/dcn35/dcn35_dccg.h    |    5 +-
 .../amd/display/dc/dccg/dcn42/dcn42_dccg.c    |    2 +-
 drivers/gpu/drm/amd/display/dc/dce/Makefile   |    4 +-
 drivers/gpu/drm/amd/display/dc/dce/dmub_abm.c |   73 +-
 .../drm/amd/display/dc/dce/dmub_abm_cacp.c    |  213 +
 .../drm/amd/display/dc/dce/dmub_abm_cacp.h    |   20 +
 .../gpu/drm/amd/display/dc/dce/dmub_abm_lcd.c |    4 +-
 .../display/dc/dio/dcn10/dcn10_link_encoder.c |   10 +-
 .../dml21/inc/bounding_boxes/dcn42_soc_bb.h   |    6 -
 .../display/dc/dpp/dcn401/dcn401_dpp_dscl.c   |   25 +-
 .../display/dc/hubbub/dcn401/dcn401_hubbub.c  |    3 +-
 .../display/dc/hubbub/dcn401/dcn401_hubbub.h  |    4 +-
 .../amd/display/dc/hubp/dcn20/dcn20_hubp.h    |    3 +-
 .../amd/display/dc/hubp/dcn42/dcn42_hubp.c    |   51 +-
 .../amd/display/dc/hubp/dcn42/dcn42_hubp.h    |    5 +
 .../amd/display/dc/hwss/dce110/dce110_hwseq.c |   12 +-
 .../amd/display/dc/hwss/dcn21/dcn21_hwseq.c   |   40 +-
 .../amd/display/dc/hwss/dcn21/dcn21_hwseq.h   |    2 +
 .../amd/display/dc/hwss/dcn31/dcn31_hwseq.c   |   70 +-
 .../amd/display/dc/hwss/dcn35/dcn35_hwseq.c   |   15 +-
 .../amd/display/dc/hwss/dcn401/dcn401_hwseq.c |   23 +-
 .../amd/display/dc/hwss/dcn42/dcn42_hwseq.c   |    2 +
 drivers/gpu/drm/amd/display/dc/inc/hw/abm.h   |    3 +
 .../drm/amd/display/dc/link/link_detection.c  |   25 +-
 .../gpu/drm/amd/display/dc/link/link_dpms.c   |  192 +-
 .../link/protocols/link_edp_panel_control.c   |   13 +-
 .../dc/resource/dcn401/dcn401_resource.h      |    3 +-
 .../dc/resource/dcn42/dcn42_resource.c        |    7 +-
 .../dc/resource/dcn42/dcn42_resource.h        |    1 +
 .../dc/resource/dcn42b/dcn42b_resource.c      |   53 +-
 .../dc/resource/dcn42b/dcn42b_resource.h      |  159 +-
 .../dcn401/dcn401_soc_and_ip_translator.c     |   16 +
 drivers/gpu/drm/amd/display/dmub/dmub_srv.h   |    9 +-
 .../gpu/drm/amd/display/dmub/src/dmub_srv.c   |   55 +-
 .../drm/amd/display/modules/inc/mod_power.h   |   11 +
 .../drm/amd/display/modules/power/power_abm.c |  136 +-
 .../amd/display/modules/power/power_helpers.h |   10 +
 .../drm/amd/display/modules/power/power_psr.c |    7 +
 .../amd/display/modules/power/power_replay.c  |    7 +
 77 files changed, 13975 insertions(+), 878 deletions(-)
 create mode 100644 drivers/gpu/drm/amd/display/dc/dce/dmub_abm_cacp.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/dce/dmub_abm_cacp.h

--
2.55.0

