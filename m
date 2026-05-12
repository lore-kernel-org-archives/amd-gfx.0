Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D3D6CD4851
	for <amd-gfx@archiver.kernel.org>; Tue, 12 May 2026 14:23:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E171B10EB1E;
	Tue, 12 May 2026 14:23:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="T+8KvPs9";
	dkim-atps=neutral
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012021.outbound.protection.outlook.com [52.101.53.21])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 296C910E0B5
 for <amd-gfx@lists.freedesktop.org>; Tue, 12 May 2026 14:23:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=r5g9Tb4b2Vvg55aFRMV7K0JvpKvvWZNxESPWM3IRL+9p6O7n6FVmgfbUEa2fEss39kZV1FD+vIJJpZMOwzeTY9jajzRv3TH/h0BMzoEEnqMWxNl2FMsu+FlXKJ0L3JF7pPSwrM00hi4c5k31TgsQtW4FRFuSVY+abGjSnj9NiiEaxvlyFvYK+ZuuwMciLbnZJKweygQid0s8UQNgMz2/UUnxBMiY/XTPp9E8fXazl/l2cfEwqrQ+vByew8fyeyiWUSz0KFU70V2fEhCPiWHDTgJadcdCLC0ERs6x6x11tnpx5r5zIqfvMvV4y38dwDLYm29qV/ObTrFXI0aibCf35g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GFQrn7+7CcuVDh0TreyHv1dZbwVrw57J/YAh6tM7ci0=;
 b=yL3tU7JgB29IWDVd88Y5aQEA6/d5kNCQ2y7arWpmyJqAMvnOUXKmj5VjcoDzerlvbzRGLarlduz+K/NlcM2CCj2yDavt0ynZWFo8zHnInm90qrqNtqdf5CtaqaLRyVEJlMQn0dN0G75p+XuQ/xM8UbPiG+sshkgbT2ITZEuLGRAtcm0hkrAwbpPzWXz/1rricaX0Ynbo4H+d8Q2pAwtNawAjRO7rCy/u7SavkE6Fl+MmbfI7CpO/SdYJP750vCj4capJZIZ/AxUPyYK8dno86EXcIsaSEq6rC8BRFOPO40RgsbJee8fXSBgcwgeGUQmSovvs/kdGvIVGkqQOTatqPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GFQrn7+7CcuVDh0TreyHv1dZbwVrw57J/YAh6tM7ci0=;
 b=T+8KvPs9oeKrGTFv1qvmzo7drgkb8k9vYa8g0HdrqhqqNoUmBYG74NofI8VQ8U4XoLb5SPqN4wYMcQsV9DgwyK/zHqHrxEXath1d1yopUGF5Mxpw9zb++rPr6f4JszyjFizKqjcAIW8A2KQzpmzwpt/KKm7UN7SlKAVLBDs4Uo4=
Received: from SJ0PR03CA0122.namprd03.prod.outlook.com (2603:10b6:a03:33c::7)
 by CYYPR12MB8654.namprd12.prod.outlook.com (2603:10b6:930:c9::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.21; Tue, 12 May
 2026 14:23:17 +0000
Received: from SJ5PEPF000001CC.namprd05.prod.outlook.com
 (2603:10b6:a03:33c:cafe::fa) by SJ0PR03CA0122.outlook.office365.com
 (2603:10b6:a03:33c::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9891.23 via Frontend Transport; Tue,
 12 May 2026 14:23:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SJ5PEPF000001CC.mail.protection.outlook.com (10.167.242.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.25.13 via Frontend Transport; Tue, 12 May 2026 14:23:17 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.41; Tue, 12 May
 2026 09:23:15 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 12 May
 2026 09:23:15 -0500
Received: from hwentlanryzen (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Tue, 12 May 2026 09:23:14 -0500
From: Harry Wentland <harry.wentland@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Jerry.Zuo@amd.com>, Harry Wentland <harry.wentland@amd.com>, "Rodrigo
 Siqueira" <siqueira@igalia.com>, =?UTF-8?q?Tomasz=20Paku=C5=82a?=
 <tomasz.pakula.oficjalny@gmail.com>
Subject: [PATCH v4 00/13] HDMI FRL and DSC Support for amdgpu
Date: Tue, 12 May 2026 10:22:54 -0400
Message-ID: <20260512142308.131260-1-harry.wentland@amd.com>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Received-SPF: None (SATLEXMB04.amd.com: harry.wentland@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001CC:EE_|CYYPR12MB8654:EE_
X-MS-Office365-Filtering-Correlation-Id: 251219ba-6d49-450a-7f50-08deb032029e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700016|1800799024|82310400026|3023799003|18002099003|11063799003|56012099003;
X-Microsoft-Antispam-Message-Info: QH9qV/UU+OTunSZDTO/WeeIAZhbkIDTp5pYUbmAki+9FcqWtqXg7yKCQFPliDKaX88e0FxV+lHy8x43LYcDgpGOSjz5flxagrCvNGwnI14Qo3GKa2tjMMQCz5WyJ5QmzASanAd+VoCbnz+0la82RJY7Hx4Rt7xZ3VMnB0/wiXGfPrmr+x3iw48GuPi/CLzRLZ0fMIs09yTLmuKaoYS4ERTsTaSeL3p+KrgTRNgqiHTw28WNj8Yw62PoD6ABLog23WexCUCvs5qRISSRHvGZ5ECM9EMjOwKx+JX+Q58CJAphLA/XTEjCwDkGY8dTX60fH4HansdHGPpBeLvkMe51ZulrTqaNuZtuMctyUCqFj8tnKL1bkFLNQ5r3BKCqF5yFK0dC7Pdw2JU79/HOB1TyORsgngdwY4P3xZmc9B+rBmGHKyOYuKtrZGzN7lGarcbQac/MU+1w5Lr4/j0frafoPWKQHr+oJ2pjFE8cfQ5nChKdR6j2Pb7Yf0KT/LZHnud90gM0b5MhiebjffIoA6Yx46IjtzwNccdKiUmOwA794A+SDI5EZlJabCwokpWHvCqlRzgTkJYqF3OtV4jAGzMG9cjA4iHnj46tctxL39SE/z89xpZdpVtn9SpIao/DQlNl2W3ruQRrKAWgPVsNT3AEvMcOxHZRs+EN/A3DDuzZuLCuTXmJIYL8wL/sp+HtDbrykYfwxbJoUODroA6blrzAsG4Yir08eEdzW5peewupK6zM=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700016)(1800799024)(82310400026)(3023799003)(18002099003)(11063799003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: NddnKjzJ+OWN/W0STC3maGI9wHtIVSTYahVrKgRiMjim3T4Tlyi9EIyi/37RnpW9tpwm33PmaY29w2XHrnmeE2jXrGbu593OMBNUVgDYddSAeXfbQRNS6k5x0Y0s+RTizRM7zFoialctVnD99yk9mqegIVZhw4IIchDp3CA6KRfVMUr4PgY8XQGA3KvY1hQTHRatAnphoYKvFUYEVVAOSakR3L/WQUNPN1cdQYBtxGXbCHO0pxi8xWqVB/yKrwv8/9t08qspg8AXmmt9RWPVGCXKGojIHJHeXPM0x2PFAdmFbHq2SH4siNlxPxWWRNW1GypiELf2uzHlJUQ7i1RFB4ewTI+FFcgMgOej+glJPsmWMZAzNfNHAEkEzFcXmbtKmS4aJRjZZJP5ety/WRvnuYVp/hKBwBdgbeZGS8W5HzAI4ZJaqlKm9szU63UNdefY
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2026 14:23:17.0638 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 251219ba-6d49-450a-7f50-08deb032029e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001CC.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8654
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

This patch series adds HDMI FRL and FRL DSC support to the amdgpu
display driver.

This work passed a representative subset of HDMI compliance and a full
compliance run on this branch is in the works. We don't expect the full
run to show any failures since it passes in other environments.

Thanks to Siqueira who prepared this work a couple years back and
unfortunately didn't manage to send them while he was still working
at AMD.

Thanks to Jerry who has been making this code solid on Linux and
running the compliance tests.

The first patch in the series isn't related to HDMI 2.1 but included
here because it moved the code around some key bits of the HDMI 2.1
stuff around too much. It will land with the next DC Patch series.

v4:
- Disable FRL over DP MST due to lack of testing
- FP compilation fix
- squash fixup commit

v3:
- Add missing DML2 bits
- Merged register headers to asdn and removed from patchset

v2:
- Add missing function pointers on DCN 3.x
- Add DSC

Cc: Rodrigo Siqueira <siqueira@igalia.com>
Cc: Zuo, Jerry <Jerry.Zuo@amd.com>
Cc: Tomasz Pakuła <tomasz.pakula.oficjalny@gmail.com>

Fangzhi Zuo (1):
  drm/amd/display: add HDMI 2.1 Compliance Support

Harry Wentland (12):
  drm/amd/display: Add HDMI FRL definitions to includes
  drm/amd/display: Add DML changes to support HDMI FRL
  drm/amd/display: add HDMI 2.1 FRL base support to DML 2.0
  drm/amd/display: Add DCCG DIO, HPO, OPP, and OPTC support for FRL
  drm/amd/display: Add FRL support to clk_mgr, dsc, hdcp
  drm/amd/display: Tie FRL programming together in HWSS
  drm/amd/display: Add DC resource support for FRL
  drm/amd/display Add DC link support for FRL
  drm/amd/display: Add support for FRL to DC core
  drm/amd/display: Update HDCP and info_packet modules for FRL
  drm/amd/display: Tie FRL support into amdgpu_dm
  drm/amd/display: add HDMI 2.1 DSC over FRL support

 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |  160 ++-
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h |   11 +
 .../amd/display/amdgpu_dm/amdgpu_dm_debugfs.c |   28 +
 .../amd/display/amdgpu_dm/amdgpu_dm_hdcp.c    |    2 +
 .../amd/display/amdgpu_dm/amdgpu_dm_helpers.c |   68 +-
 .../display/amdgpu_dm/amdgpu_dm_mst_types.c   |   79 ++
 .../drm/amd/display/dc/bios/bios_parser2.c    |   21 +
 .../drm/amd/display/dc/bios/command_table2.c  |    6 +
 .../dce112/command_table_helper2_dce112.c     |    3 +
 .../bios/dce112/command_table_helper_dce112.c |    3 +
 .../display/dc/clk_mgr/dcn31/dcn31_clk_mgr.c  |    3 +
 .../dc/clk_mgr/dcn314/dcn314_clk_mgr.c        |    3 +
 .../dc/clk_mgr/dcn315/dcn315_clk_mgr.c        |    3 +
 .../dc/clk_mgr/dcn316/dcn316_clk_mgr.c        |    3 +
 .../display/dc/clk_mgr/dcn32/dcn32_clk_mgr.c  |   12 +
 .../display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c  |   14 +
 .../dc/clk_mgr/dcn401/dcn401_clk_mgr.c        |   18 +
 drivers/gpu/drm/amd/display/dc/core/dc.c      |   32 +-
 .../gpu/drm/amd/display/dc/core/dc_debug.c    |    4 +
 .../drm/amd/display/dc/core/dc_hw_sequencer.c |   49 +
 .../drm/amd/display/dc/core/dc_link_enc_cfg.c |    3 +
 .../drm/amd/display/dc/core/dc_link_exports.c |   45 +
 .../gpu/drm/amd/display/dc/core/dc_resource.c |  289 ++++
 .../gpu/drm/amd/display/dc/core/dc_stream.c   |   35 +
 drivers/gpu/drm/amd/display/dc/dc.h           |  128 ++
 drivers/gpu/drm/amd/display/dc/dc_dsc.h       |    8 +
 .../gpu/drm/amd/display/dc/dc_hdmi_types.h    |  164 ++-
 drivers/gpu/drm/amd/display/dc/dc_hw_types.h  |    8 +
 drivers/gpu/drm/amd/display/dc/dc_types.h     |   24 +
 .../amd/display/dc/dccg/dcn30/dcn30_dccg.c    |   40 +
 .../amd/display/dc/dccg/dcn30/dcn30_dccg.h    |    8 +
 .../amd/display/dc/dccg/dcn31/dcn31_dccg.c    |   88 ++
 .../amd/display/dc/dccg/dcn31/dcn31_dccg.h    |   13 +
 .../amd/display/dc/dccg/dcn314/dcn314_dccg.c  |   25 +
 .../amd/display/dc/dccg/dcn32/dcn32_dccg.c    |   68 +
 .../amd/display/dc/dccg/dcn35/dcn35_dccg.c    |  321 +++++
 .../amd/display/dc/dccg/dcn401/dcn401_dccg.c  |   73 +
 .../amd/display/dc/dccg/dcn401/dcn401_dccg.h  |    4 +
 .../amd/display/dc/dccg/dcn42/dcn42_dccg.c    |   33 +
 .../gpu/drm/amd/display/dc/dce/dce_audio.c    |    8 +
 .../drm/amd/display/dc/dce/dce_clock_source.c |   30 +-
 .../display/dc/dio/dcn10/dcn10_link_encoder.c |    3 +-
 .../display/dc/dio/dcn20/dcn20_link_encoder.h |    1 +
 .../dc/dio/dcn30/dcn30_dio_link_encoder.c     |  250 ++++
 .../dc/dio/dcn30/dcn30_dio_link_encoder.h     |   17 +
 .../dc/dio/dcn301/dcn301_dio_link_encoder.c   |   18 +
 .../dc/dio/dcn31/dcn31_dio_link_encoder.c     |  114 ++
 .../dc/dio/dcn31/dcn31_dio_link_encoder.h     |    8 +
 .../dc/dio/dcn32/dcn32_dio_link_encoder.c     |  214 +++
 .../dc/dio/dcn32/dcn32_dio_link_encoder.h     |   16 +
 .../dc/dio/dcn321/dcn321_dio_link_encoder.c   |   20 +
 .../dc/dio/dcn35/dcn35_dio_link_encoder.c     |   21 +
 .../dc/dio/dcn401/dcn401_dio_link_encoder.c   |  220 +++
 .../dc/dio/dcn401/dcn401_dio_link_encoder.h   |   16 +
 .../dc/dio/dcn42/dcn42_dio_link_encoder.c     |   21 +
 drivers/gpu/drm/amd/display/dc/dm_cp_psp.h    |    1 +
 .../drm/amd/display/dc/dm_services_types.h    |    1 +
 drivers/gpu/drm/amd/display/dc/dml/Makefile   |    3 +
 .../drm/amd/display/dc/dml/dcn20/dcn20_fpu.c  |    5 +
 .../drm/amd/display/dc/dml/dcn30/dcn30_fpu.c  |  127 ++
 .../drm/amd/display/dc/dml/dcn30/dcn30_fpu.h  |   22 +
 .../dc/dml/dcn30/display_mode_vba_30.c        |  280 +++-
 .../amd/display/dc/dml/dcn302/dcn302_fpu.c    |    1 +
 .../amd/display/dc/dml/dcn303/dcn303_fpu.c    |    1 +
 .../dc/dml/dcn31/display_mode_vba_31.c        |  243 ++++
 .../dc/dml/dcn314/display_mode_vba_314.c      |  241 ++++
 .../drm/amd/display/dc/dml/dcn32/dcn32_fpu.c  |   10 +
 .../drm/amd/display/dc/dml/dcn32/dcn32_fpu.h  |    2 +
 .../dc/dml/dcn32/display_mode_vba_32.c        |   16 +-
 .../dc/dml/dcn32/display_mode_vba_util_32.c   |  127 +-
 .../amd/display/dc/dml/display_mode_enums.h   |    1 +
 .../drm/amd/display/dc/dml/dml1_frl_cap_chk.c |  786 +++++++++++
 .../drm/amd/display/dc/dml/dml1_frl_cap_chk.h |  173 +++
 .../gpu/drm/amd/display/dc/dml2_0/Makefile    |    2 +
 .../amd/display/dc/dml2_0/display_mode_core.c |  104 +-
 .../amd/display/dc/dml2_0/display_mode_util.c |    3 +
 .../dml2_0/dml21/dml21_translation_helper.c   |    4 +
 .../dml21/src/dml2_core/dml2_core_dcn4.c      |    1 +
 .../src/dml2_core/dml2_core_dcn4_calcs.c      |   29 +-
 .../src/dml2_core/dml2_core_shared_types.h    |    3 +
 .../lib_frl_cap_check.c                       |  396 ++++++
 .../lib_frl_cap_check.h                       |   90 ++
 .../dc/dml2_0/dml2_translation_helper.c       |    4 +
 .../drm/amd/display/dc/dml2_0/dml2_utils.c    |    2 +
 .../amd/display/dc/dml2_0/dml_frl_cap_chk.c   |  413 ++++++
 .../amd/display/dc/dml2_0/dml_frl_cap_chk.h   |  109 ++
 drivers/gpu/drm/amd/display/dc/dsc/dc_dsc.c   |  704 ++++++++++
 drivers/gpu/drm/amd/display/dc/dsc/dsc.h      |    5 +
 .../gpu/drm/amd/display/dc/hdcp/hdcp_msg.c    |    1 +
 drivers/gpu/drm/amd/display/dc/hpo/Makefile   |   10 +
 .../dc/hpo/dcn30/dcn30_hpo_frl_link_encoder.c |  286 ++++
 .../dc/hpo/dcn30/dcn30_hpo_frl_link_encoder.h |  146 ++
 .../hpo/dcn30/dcn30_hpo_frl_stream_encoder.c  | 1043 +++++++++++++++
 .../hpo/dcn30/dcn30_hpo_frl_stream_encoder.h  |  436 ++++++
 .../dcn401/dcn401_hpo_frl_stream_encoder.c    |  907 +++++++++++++
 .../dcn401/dcn401_hpo_frl_stream_encoder.h    |  335 +++++
 .../hpo/dcn42/dcn42_hpo_frl_stream_encoder.c  |  207 +++
 .../hpo/dcn42/dcn42_hpo_frl_stream_encoder.h  |   59 +
 .../amd/display/dc/hwss/dce110/dce110_hwseq.c |   99 +-
 .../amd/display/dc/hwss/dcn10/dcn10_hwseq.c   |   37 +
 .../amd/display/dc/hwss/dcn20/dcn20_hwseq.c   |   19 +-
 .../amd/display/dc/hwss/dcn30/dcn30_hwseq.c   |   49 +-
 .../amd/display/dc/hwss/dcn30/dcn30_hwseq.h   |   13 +
 .../amd/display/dc/hwss/dcn30/dcn30_init.c    |    1 +
 .../amd/display/dc/hwss/dcn31/dcn31_hwseq.c   |   13 +-
 .../amd/display/dc/hwss/dcn31/dcn31_init.c    |    1 +
 .../amd/display/dc/hwss/dcn314/dcn314_hwseq.c |    3 +-
 .../amd/display/dc/hwss/dcn314/dcn314_init.c  |    1 +
 .../amd/display/dc/hwss/dcn32/dcn32_hwseq.c   |   13 +-
 .../amd/display/dc/hwss/dcn32/dcn32_init.c    |    3 +
 .../amd/display/dc/hwss/dcn35/dcn35_hwseq.c   |   42 +
 .../amd/display/dc/hwss/dcn35/dcn35_hwseq.h   |    2 +
 .../amd/display/dc/hwss/dcn35/dcn35_init.c    |    2 +
 .../amd/display/dc/hwss/dcn351/dcn351_init.c  |    2 +
 .../amd/display/dc/hwss/dcn401/dcn401_hwseq.c |   13 +
 .../amd/display/dc/hwss/dcn401/dcn401_init.c  |    1 +
 .../amd/display/dc/hwss/dcn42/dcn42_hwseq.c   |   38 +-
 .../amd/display/dc/hwss/dcn42/dcn42_init.c    |    2 +
 .../drm/amd/display/dc/hwss/hw_sequencer.h    |   34 +
 .../display/dc/hwss/hw_sequencer_private.h    |    3 +
 .../gpu/drm/amd/display/dc/inc/core_status.h  |    2 +
 .../gpu/drm/amd/display/dc/inc/core_types.h   |   12 +
 drivers/gpu/drm/amd/display/dc/inc/hw/dccg.h  |   10 +
 .../gpu/drm/amd/display/dc/inc/hw/hw_shared.h |    1 +
 .../drm/amd/display/dc/inc/hw/link_encoder.h  |  176 +++
 .../amd/display/dc/inc/hw/stream_encoder.h    |  231 ++++
 .../amd/display/dc/inc/hw/timing_generator.h  |    5 +
 .../gpu/drm/amd/display/dc/inc/link_service.h |   15 +
 drivers/gpu/drm/amd/display/dc/inc/resource.h |    7 +
 drivers/gpu/drm/amd/display/dc/link/Makefile  |    2 +
 .../display/dc/link/hwss/link_hwss_hpo_frl.c  |  113 ++
 .../display/dc/link/hwss/link_hwss_hpo_frl.h  |   34 +
 .../drm/amd/display/dc/link/link_detection.c  |  111 ++
 .../gpu/drm/amd/display/dc/link/link_dpms.c   |  223 +++-
 .../gpu/drm/amd/display/dc/link/link_dpms.h   |    1 +
 .../drm/amd/display/dc/link/link_factory.c    |   44 +
 .../drm/amd/display/dc/link/link_validation.c |  298 +++++
 .../drm/amd/display/dc/link/link_validation.h |   13 +
 .../amd/display/dc/link/protocols/link_ddc.c  |   90 ++
 .../amd/display/dc/link/protocols/link_ddc.h  |    4 +
 .../display/dc/link/protocols/link_hdmi_frl.c | 1185 +++++++++++++++++
 .../display/dc/link/protocols/link_hdmi_frl.h |   53 +
 .../amd/display/dc/link/protocols/link_hpd.c  |    1 +
 .../drm/amd/display/dc/opp/dcn10/dcn10_opp.c  |    1 +
 .../amd/display/dc/optc/dcn10/dcn10_optc.h    |    5 +-
 .../amd/display/dc/optc/dcn30/dcn30_optc.c    |    8 +-
 .../amd/display/dc/optc/dcn30/dcn30_optc.h    |    8 +-
 .../amd/display/dc/optc/dcn31/dcn31_optc.c    |    2 +
 .../amd/display/dc/optc/dcn401/dcn401_optc.c  |    2 +
 .../dc/resource/dce112/dce112_resource.c      |    3 +
 .../dc/resource/dcn30/dcn30_resource.c        |  126 ++
 .../dc/resource/dcn301/dcn301_resource.c      |    1 +
 .../dc/resource/dcn302/dcn302_resource.c      |  109 ++
 .../dc/resource/dcn303/dcn303_resource.c      |  109 ++
 .../dc/resource/dcn31/dcn31_resource.c        |  127 ++
 .../dc/resource/dcn314/dcn314_resource.c      |  127 ++
 .../dc/resource/dcn315/dcn315_resource.c      |  128 ++
 .../dc/resource/dcn316/dcn316_resource.c      |  126 ++
 .../dc/resource/dcn32/dcn32_resource.c        |  131 ++
 .../dc/resource/dcn32/dcn32_resource.h        |   79 +-
 .../dc/resource/dcn321/dcn321_resource.c      |  132 ++
 .../dc/resource/dcn35/dcn35_resource.c        |  121 ++
 .../dc/resource/dcn351/dcn351_resource.c      |  121 ++
 .../dc/resource/dcn36/dcn36_resource.c        |  121 ++
 .../dc/resource/dcn401/dcn401_resource.c      |  121 ++
 .../dc/resource/dcn42/dcn42_resource.c        |  121 ++
 .../gpu/drm/amd/display/dmub/inc/dmub_cmd.h   |    5 +-
 .../gpu/drm/amd/display/include/audio_types.h |    1 +
 .../amd/display/include/bios_parser_types.h   |   14 +-
 .../drm/amd/display/include/logger_types.h    |    2 +
 .../drm/amd/display/include/signal_types.h    |   12 +-
 .../gpu/drm/amd/display/modules/hdcp/hdcp.c   |    2 +
 .../gpu/drm/amd/display/modules/hdcp/hdcp.h   |    6 +
 .../drm/amd/display/modules/hdcp/hdcp_psp.c   |    2 +
 .../drm/amd/display/modules/hdcp/hdcp_psp.h   |    2 +
 .../amd/display/modules/inc/mod_freesync.h    |    3 +
 .../drm/amd/display/modules/inc/mod_hdcp.h    |    1 +
 .../amd/display/modules/inc/mod_info_packet.h |    2 +-
 .../display/modules/info_packet/info_packet.c |  122 +-
 179 files changed, 15127 insertions(+), 113 deletions(-)
 create mode 100644 drivers/gpu/drm/amd/display/dc/dml/dml1_frl_cap_chk.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/dml/dml1_frl_cap_chk.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_standalone_libraries/lib_frl_cap_check.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_standalone_libraries/lib_frl_cap_check.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/dml2_0/dml_frl_cap_chk.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/dml2_0/dml_frl_cap_chk.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/hpo/dcn30/dcn30_hpo_frl_link_encoder.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/hpo/dcn30/dcn30_hpo_frl_link_encoder.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/hpo/dcn30/dcn30_hpo_frl_stream_encoder.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/hpo/dcn30/dcn30_hpo_frl_stream_encoder.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/hpo/dcn401/dcn401_hpo_frl_stream_encoder.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/hpo/dcn401/dcn401_hpo_frl_stream_encoder.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/hpo/dcn42/dcn42_hpo_frl_stream_encoder.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/hpo/dcn42/dcn42_hpo_frl_stream_encoder.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/link/hwss/link_hwss_hpo_frl.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/link/hwss/link_hwss_hpo_frl.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/link/protocols/link_hdmi_frl.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/link/protocols/link_hdmi_frl.h

--
2.54.0

