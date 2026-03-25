Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E284FEA817
	for <amd-gfx@archiver.kernel.org>; Wed, 25 Mar 2026 07:08:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DAA7C10E793;
	Wed, 25 Mar 2026 07:08:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="NbgC1LRd";
	dkim-atps=neutral
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011022.outbound.protection.outlook.com [40.107.208.22])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9FE7810E793
 for <amd-gfx@lists.freedesktop.org>; Wed, 25 Mar 2026 07:08:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QrA7Ox6XMgpv3+1BCgc3142KOnx8Wk5Im4f3aVcEinsDf+vB+NWI2N0PHDx5aP/4Xl0Aryd/FwUw+x4w6Q2XhmmGg9FLmx9Q12I8gV6wWKkcpDE/y+Dfy9WUzpv+CEjXMacgUXcEh9ySfBRAJ8PiLFCm2q/aCT6Lhs+ElFI8FbMHvHHcNBzZO2is+ewoHBRCBKO6kLmfe9z/LmTXN9RfK3C2vFB2GTk4fQF254QGBAwYsl68aZetiVIeJTQ93ucsdweMncWXj/MeWwpY7MTFCZ7QIU4QEdndB0TGtw9kGhtphmSH7rCWLE9lHYY9ZeARFbIgCjrnldcmwXu7iis/DQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3Gth6yRdX9jm/dS8KARjHoMUebw2iZRz8DuVVE+xyzA=;
 b=mbD0BG6xisYRY+aRqVa2mVEP21W14VIFBmQT7WZgvJ0N5n0YGbpZ96GMD3FPotmyrlRVwOypSKwIAUKWEbZuQTttjmq5guvgPbIqMVLsF0Q7wx+YrPevq9Zu9xwBBeZ3regNiZl5gaArOjU4pZlu8QtrPfZyIOmsBNkTZYJ8gqPIGTTeAJMdy4QJpIOxe00GdJ7rP0o+ug+gclYCx6AoYGqPUeD7s5ZRXxih9D4iOMKjdZwPhZGZV1hKc432NL+tG0N+/8VEH60U55MaVxXWg4085T3/Qt1x/Mxo3iWYrPUtmQlGMZdli3ggD+dBMCqDOknmshI+Oq1k///whtmbcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3Gth6yRdX9jm/dS8KARjHoMUebw2iZRz8DuVVE+xyzA=;
 b=NbgC1LRdcBKOSVZo8IrNtXADm18T9lUn0m5jGT5WHHw9H5vjRI2ZLLiq2q6AczdE/r8xWptlEX0rakeu/ivgFFOQogKfvfJcdqFhBTETSZ59L7sSwLe1jty4zdM2ivc1sRks7UM55cHpjiaspvOf0hv9Qwbxo4OdO/XLEO2bdSA=
Received: from BL0PR05CA0011.namprd05.prod.outlook.com (2603:10b6:208:91::21)
 by DM4PR12MB5961.namprd12.prod.outlook.com (2603:10b6:8:68::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Wed, 25 Mar
 2026 07:08:35 +0000
Received: from BL02EPF00021F6C.namprd02.prod.outlook.com
 (2603:10b6:208:91:cafe::a5) by BL0PR05CA0011.outlook.office365.com
 (2603:10b6:208:91::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9723.31 via Frontend Transport; Wed,
 25 Mar 2026 07:08:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL02EPF00021F6C.mail.protection.outlook.com (10.167.249.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9723.19 via Frontend Transport; Wed, 25 Mar 2026 07:08:35 +0000
Received: from maxMSI.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 25 Mar
 2026 02:08:31 -0500
From: ChuanYu Tseng <ChuanYu.Tseng@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, ChuanYu Tseng <ChuanYu.Tseng@amd.com>
Subject: [PATCH 00/29] DC Patches March 25, 2026
Date: Wed, 25 Mar 2026 15:06:06 +0800
Message-ID: <20260325071003.4022594-1-ChuanYu.Tseng@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF00021F6C:EE_|DM4PR12MB5961:EE_
X-MS-Office365-Filtering-Correlation-Id: 7aab3176-5e94-4353-0f2a-08de8a3d54e0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|36860700016|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: KbN0B2AKwrbVz73FKswQRyZCrGXupJCFs6G4JmvM1tIX7M7YDy8J32rFAA6FQ1rrmDrP3lljoRl5/Oh9yQgeh1PMAv2cy0niBbLLmCSNLL6LHRmrQsrnRgWaSmdmz1FiBAaAiM49U1kXGFnHIavW923gQ1HBlRZLSKHTkPUWw7K5Z9jgS1UMT0rNMzasIOxzyUYCSpKMX0JeVmUBLs7Ugjtq/n0ohgqklTBaAG4IjOejOB3iPLCIphYZ1q+5usNZ/vyHf5OT9M1S/CDCmvVD96DzMMbvaCxw/oBETuDprnKUB03Sz4AMn8/1cJ4UA7RfoXstYgZcbCRwmWWwMVqYW4EkthDezYLtlYfBHihPfOpf1rgXMAprCwUPgWp86EjXysH0fb2CV6ihawQABahsyPNOa9NS/PXcWgSVcUN3J1lhhrGyil+4Ag4uBtUqldUlpj+ihINqa+Jrt4+YXX/IHoBUywZWaJbDirMEaURCoZRZBACwT0xg2WxTLV6m9Qjb45QLam4/VKxAMsf22ZikpKN0N5Wj0FkW6ud1IzdqT89Dhei65DvsqHpP3ubBURJdNqtfje7Lql2/v1q3eP1Qy465TCep45dariSUWRRZ1Q+t4eq6LQmb97UjynQ02DhUiC/80V2KHA4BD/Exl1wuUmBN9O1xACWrqSYrrL+Qvn3SHo6iDacC9t1w5bTU0nYPTmgxOl0se5fUAxIglXg4u/x34ddbhODxOiOnHTVk05gf0GZIwr5H1534CUZ9cudOxZS0AGElSZBE4q2y+MjBhA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(36860700016)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: f3au2peSt8QEVybnTulFECrxJBssaPacjiQPOwvLPgAhhq3ZjV5ZKvhI2wszOu4paSfxx545yC275Zm7mTUKCNfnX92/iBs0El8MsbMFtt++7KPPurjGgUKz+KKBJfSMCHFK64Jnad8QGV8iyVT2k6t8juOnT7YeUn+pqnzUN4lFgAZ/gthpIFZYGs4Hud54Tw8VSz1+g/Ibol3PX5XuvUgufxP789ZluIN9fMDrVGon6JiNAeXrf16qzHuoWagmg6mmOBhJmETUBxRpnypl40jtfHn0PhQ4PQnE4Fnfy/8xJj0sMUdow7nixXrF8sFeZi8ZLH8vG/ckerJhbKOwQAJNjdN0nNzsN48gZ2kxKh2psrqosvO5tRoZ7ManCEbFRS7ch12HbgeF6GFBb5Lcu1Gg8kY4s78D2SLJsZotKCTo5Tt9JMEiC0RPQ3Pwy2jU
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2026 07:08:35.4435 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7aab3176-5e94-4353-0f2a-08de8a3d54e0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF00021F6C.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5961
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

- correct unknown plane state patch
- Revert "Refactor DC update checks"
- Revert "Add 3DLUT DMA broadcast support"
- Remove invalid DPSTREAMCLK mask usage
- enable eDP DSC seamless boot support
- Revert "Rework HDMI link training and YCbCr422 with DSC policy"
- Disable PSR & Replay CRTC disable by default
- Fix Silence Compiler Warnings
- Add link output control for DPIA
- eliminate clock manager code duplication
- Don't set 4to1MPC config dynamically
- Merge pipes for validate
- Fix bounds checking in dml2_0 clock table array
- Avoid turning off the PHY when OTG is running for DVI
- Should support p-state under dcn21
- Enable Replay support for dcn42
- Remove check for DC_DMCUB_ENABLE on DCN42

Cc: Daniel Wheeler <daniel.wheeler@amd.com>

Charlene Liu (1):
  drm/amd/display: correct unknown plane state patch

Clay King (2):
  drm/amd/display: Fix silence signed/unsigned mismatch warnings in dml
  drm/amd/display: Fixed silence signed/unsigned mismatch warnings

Dillon Varone (3):
  drm/amd/display: using cm structure for lut3d related info
  Revert "drm/amd/display: Add 3DLUT DMA broadcast support"
  Revert "drm/amd/display: Refactor DC update checks"

Gabe Teeger (2):
  drm/amd/display: Fix bounds checking in dml2_0 clock table array
  drm/amd/display: eliminate clock manager code duplication

Gaghik Khachatrian (6):
  drm/amd/display: Fix Compiler Warning - unused func parameters
  drm/amd/display: Fix Silence Conversion Warnings in Dmub
  drm/amd/display: Fix Silence signed/unsighed mismatch warning in dc
  drm/amd/display: Fixed Silence complier warnings in dc
  drm/amd/display: Fix Compiler warnings in dmub
  drm/amd/display: Silence type conversion warnings in dml2

Harry Wentland (2):
  drm/amd/display: Merge pipes for validate
  drm/amd/display: Don't set 4to1MPC config dynamically

Lincheng Ku (1):
  drm/amd/dc: Add link output control for DPIA

Mohit Bawa (1):
  drm/amd/display: enable eDP DSC seamless boot support

Nicholas Kazlauskas (1):
  drm/amd/display: Avoid turning off the PHY when OTG is running for DVI

Ovidiu Bunea (1):
  drm/amd/dc: Disable PSR & Replay CRTC disable by default

Rafal Ostrowski (3):
  drm/amd/display: Move FPU Guards From DML To DC - Part 1
  drm/amd/display: Move FPU Guards From DML To DC - Part 2
  drm/amd/display: Move FPU Guards From DML To DC - Part 3

Relja Vojvodic (1):
  Revert "drm/amd/display: Rework YCbCr422 DSC policy"

Roman Li (2):
  drm/amd/display: Enable Replay support for dcn42
  drm/amd/display: Remove invalid DPSTREAMCLK mask usage

Taimur Hassan (2):
  drm/amd/display: [FW Promotion] Release 0.1.53.0
  drm/amd/display: Promote DC to 3.2.376

Wayne Lin (1):
  drm/amd/display: Should support p-state under dcn21

 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |   7 +-
 .../amd/display/amdgpu_dm/amdgpu_dm_crtc.c    |   2 +-
 .../gpu/drm/amd/display/amdgpu_dm/dc_fpu.c    |  25 +-
 .../gpu/drm/amd/display/amdgpu_dm/dc_fpu.h    |  17 +-
 .../gpu/drm/amd/display/dc/basics/dce_calcs.c |   8 +-
 .../drm/amd/display/dc/basics/fixpt31_32.c    |   1 +
 .../gpu/drm/amd/display/dc/basics/vector.c    |   1 +
 .../gpu/drm/amd/display/dc/bios/bios_parser.c |   1 +
 .../drm/amd/display/dc/bios/bios_parser2.c    |   9 +
 .../drm/amd/display/dc/bios/command_table2.c  |   2 +
 .../bios/dce110/command_table_helper_dce110.c |   1 +
 .../dce112/command_table_helper2_dce112.c     |   1 +
 .../bios/dce112/command_table_helper_dce112.c |   1 +
 .../gpu/drm/amd/display/dc/clk_mgr/clk_mgr.c  |   5 +-
 .../dc/clk_mgr/dce110/dce110_clk_mgr.c        |   2 +-
 .../display/dc/clk_mgr/dcn30/dcn30_clk_mgr.c  |   3 +-
 .../display/dc/clk_mgr/dcn31/dcn31_clk_mgr.c  |   3 +
 .../dc/clk_mgr/dcn314/dcn314_clk_mgr.c        |   3 +
 .../dc/clk_mgr/dcn315/dcn315_clk_mgr.c        |   3 +
 .../dc/clk_mgr/dcn316/dcn316_clk_mgr.c        |   3 +
 .../display/dc/clk_mgr/dcn32/dcn32_clk_mgr.c  |   4 +-
 .../dc/clk_mgr/dcn401/dcn401_clk_mgr.c        |   3 +
 .../display/dc/clk_mgr/dcn42/dcn42_clk_mgr.c  |  31 +-
 .../display/dc/clk_mgr/dcn42/dcn42_clk_mgr.h  |   9 +-
 drivers/gpu/drm/amd/display/dc/core/dc.c      | 580 +++++++++++-------
 .../drm/amd/display/dc/core/dc_hw_sequencer.c |   1 +
 .../drm/amd/display/dc/core/dc_link_exports.c |   4 +-
 .../gpu/drm/amd/display/dc/core/dc_resource.c |   9 +-
 .../gpu/drm/amd/display/dc/core/dc_state.c    |  77 ++-
 .../gpu/drm/amd/display/dc/core/dc_stream.c   |  13 +-
 .../gpu/drm/amd/display/dc/core/dc_surface.c  |   1 +
 drivers/gpu/drm/amd/display/dc/dc.h           |  30 +-
 drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c  |   1 +
 drivers/gpu/drm/amd/display/dc/dc_dsc.h       |   1 -
 drivers/gpu/drm/amd/display/dc/dc_helper.c    |   1 +
 .../amd/display/dc/dccg/dcn31/dcn31_dccg.c    |   2 +
 .../amd/display/dc/dccg/dcn32/dcn32_dccg.c    |   1 +
 .../amd/display/dc/dccg/dcn35/dcn35_dccg.c    |   2 +
 .../amd/display/dc/dccg/dcn401/dcn401_dccg.c  |   8 +-
 .../amd/display/dc/dccg/dcn42/dcn42_dccg.c    |   1 +
 drivers/gpu/drm/amd/display/dc/dce/dce_abm.c  |   1 +
 .../gpu/drm/amd/display/dc/dce/dce_audio.c    |   3 +
 .../drm/amd/display/dc/dce/dce_clock_source.c |  10 +-
 drivers/gpu/drm/amd/display/dc/dce/dce_dmcu.c |   1 +
 drivers/gpu/drm/amd/display/dc/dce/dce_i2c.c  |   1 +
 .../gpu/drm/amd/display/dc/dce/dce_i2c_hw.c   |   2 +
 .../gpu/drm/amd/display/dc/dce/dce_i2c_sw.c   |   3 +
 drivers/gpu/drm/amd/display/dc/dce/dce_ipp.c  |   1 +
 .../drm/amd/display/dc/dce/dce_link_encoder.c |   1 +
 .../drm/amd/display/dc/dce/dce_mem_input.c    |   4 +
 drivers/gpu/drm/amd/display/dc/dce/dce_opp.c  |   1 +
 .../amd/display/dc/dce/dce_stream_encoder.c   |   4 +
 .../drm/amd/display/dc/dce/dce_transform.c    |   2 +
 drivers/gpu/drm/amd/display/dc/dce/dmub_abm.c |   4 +-
 .../gpu/drm/amd/display/dc/dce/dmub_abm_lcd.c |   1 +
 .../drm/amd/display/dc/dce/dmub_hw_lock_mgr.c |   2 +-
 .../gpu/drm/amd/display/dc/dce/dmub_replay.c  |   1 +
 .../display/dc/dce110/dce110_mem_input_v.c    |  10 +
 .../amd/display/dc/dce110/dce110_opp_csc_v.c  |   1 +
 .../display/dc/dce110/dce110_opp_regamma_v.c  |   2 +
 .../dc/dce110/dce110_timing_generator.c       |   9 +
 .../dc/dce110/dce110_timing_generator_v.c     |   9 +
 .../display/dc/dce110/dce110_transform_v.c    |   6 +
 .../amd/display/dc/dce112/dce112_compressor.c |   1 +
 .../dc/dce120/dce120_timing_generator.c       |   7 +
 .../display/dc/dce80/dce80_timing_generator.c |   6 +
 .../amd/display/dc/dcn10/dcn10_cm_common.c    |   8 +-
 .../gpu/drm/amd/display/dc/dcn10/dcn10_dwb.c  |   2 +
 .../drm/amd/display/dc/dcn20/dcn20_dwb_scl.c  |   4 +-
 .../amd/display/dc/dcn30/dcn30_cm_common.c    |   4 +-
 .../gpu/drm/amd/display/dc/dcn31/dcn31_apg.c  |   1 +
 .../dc/dio/dcn10/dcn10_stream_encoder.c       |   2 +
 .../dc/dio/dcn314/dcn314_dio_stream_encoder.c |   2 +
 .../dc/dio/dcn32/dcn32_dio_stream_encoder.c   |   2 +
 .../dc/dio/dcn35/dcn35_dio_stream_encoder.c   |   1 +
 .../dc/dio/dcn401/dcn401_dio_stream_encoder.c |   3 +
 .../dc/dio/virtual/virtual_link_encoder.c     |  65 +-
 .../dc/dio/virtual/virtual_stream_encoder.c   | 111 +++-
 .../drm/amd/display/dc/dml/calcs/dcn_calcs.c  |   1 +
 .../drm/amd/display/dc/dml/dcn10/dcn10_fpu.c  |   2 +-
 .../drm/amd/display/dc/dml/dcn20/dcn20_fpu.c  |   3 +-
 .../dc/dml/dcn20/display_mode_vba_20.c        |   4 +
 .../dc/dml/dcn20/display_mode_vba_20v2.c      |   5 +
 .../dc/dml/dcn20/display_rq_dlg_calc_20.c     |   5 +
 .../dc/dml/dcn20/display_rq_dlg_calc_20v2.c   |   5 +
 .../dc/dml/dcn21/display_mode_vba_21.c        |  19 +
 .../dc/dml/dcn21/display_rq_dlg_calc_21.c     |   5 +
 .../drm/amd/display/dc/dml/dcn30/dcn30_fpu.c  |   2 +
 .../dc/dml/dcn30/display_mode_vba_30.c        |  23 +
 .../dc/dml/dcn30/display_rq_dlg_calc_30.c     |   5 +
 .../dc/dml/dcn31/display_mode_vba_31.c        |  24 +
 .../dc/dml/dcn31/display_rq_dlg_calc_31.c     |   8 +
 .../amd/display/dc/dml/dcn314/dcn314_fpu.c    |   6 +-
 .../dc/dml/dcn314/display_mode_vba_314.c      |  24 +
 .../dc/dml/dcn314/display_rq_dlg_calc_314.c   |   8 +
 .../drm/amd/display/dc/dml/dcn32/dcn32_fpu.c  |   2 +
 .../dc/dml/dcn32/display_mode_vba_util_32.c   |  23 +
 .../drm/amd/display/dc/dml/dcn35/dcn35_fpu.c  |   8 +-
 .../amd/display/dc/dml/dcn351/dcn351_fpu.c    |   7 +-
 .../drm/amd/display/dc/dml/display_mode_lib.c |   1 +
 .../display/dc/dml/display_rq_dlg_helpers.c   |  14 +
 .../display/dc/dml/dml1_display_rq_dlg_calc.c |   3 +
 .../gpu/drm/amd/display/dc/dml2_0/Makefile    |  74 +--
 .../dml2_0/dml21/dml21_translation_helper.c   |  39 +-
 .../amd/display/dc/dml2_0/dml21/dml21_utils.c |  15 +-
 .../display/dc/dml2_0/dml21/dml21_wrapper.c   | 380 +-----------
 .../display/dc/dml2_0/dml21/dml21_wrapper.h   |  30 -
 .../dc/dml2_0/dml21/dml21_wrapper_fpu.c       | 381 ++++++++++++
 .../dc/dml2_0/dml21/dml21_wrapper_fpu.h       |  60 ++
 .../dml21/src/dml2_dpmm/dml2_dpmm_dcn4.c      |  20 +
 .../dml2_0/dml21/src/dml2_mcg/dml2_mcg_dcn4.c |   9 +-
 .../dml21/src/dml2_mcg/dml2_mcg_dcn42.c       |   9 +-
 .../display/dc/dml2_0/dml2_dc_resource_mgmt.c |  28 +-
 .../amd/display/dc/dml2_0/dml2_mall_phantom.c |   3 +-
 .../dc/dml2_0/dml2_translation_helper.c       |   6 +-
 .../drm/amd/display/dc/dml2_0/dml2_utils.c    |   3 +-
 .../drm/amd/display/dc/dml2_0/dml2_wrapper.c  |  23 +-
 .../amd/display/dc/dml2_0/dml2_wrapper_fpu.c  |   9 +-
 .../drm/amd/display/dc/dpp/dcn10/dcn10_dpp.c  |   1 +
 .../drm/amd/display/dc/dpp/dcn20/dcn20_dpp.c  |  11 +-
 .../amd/display/dc/dpp/dcn20/dcn20_dpp_cm.c   |   1 +
 .../drm/amd/display/dc/dpp/dcn30/dcn30_dpp.c  |   1 +
 .../amd/display/dc/dpp/dcn30/dcn30_dpp_cm.c   |   1 +
 .../amd/display/dc/dpp/dcn401/dcn401_dpp_cm.c |   5 +
 drivers/gpu/drm/amd/display/dc/dsc/dc_dsc.c   |  13 +-
 .../drm/amd/display/dc/dsc/dcn20/dcn20_dsc.c  |   2 +-
 .../drm/amd/display/dc/dsc/dcn35/dcn35_dsc.c  |   2 +-
 .../amd/display/dc/dsc/dcn401/dcn401_dsc.c    |   7 +-
 drivers/gpu/drm/amd/display/dc/dsc/dsc.h      |   5 +
 .../drm/amd/display/dc/dwb/dcn30/dcn30_dwb.c  |   1 +
 .../dc/gpio/dcn42/hw_translate_dcn42.c        |   1 +
 .../gpu/drm/amd/display/dc/gpio/hw_factory.c  |   1 +
 drivers/gpu/drm/amd/display/dc/gpio/hw_gpio.c |   1 +
 .../drm/amd/display/dc/gpio/hw_translate.c    |   1 +
 .../display/dc/hubbub/dcn31/dcn31_hubbub.c    |   1 +
 .../display/dc/hubbub/dcn35/dcn35_hubbub.c    |   1 +
 .../display/dc/hubbub/dcn401/dcn401_hubbub.c  |   4 +
 .../display/dc/hubbub/dcn42/dcn42_hubbub.c    |   2 +
 .../amd/display/dc/hubp/dcn10/dcn10_hubp.c    |   2 +
 .../amd/display/dc/hubp/dcn20/dcn20_hubp.c    |   2 +
 .../amd/display/dc/hubp/dcn30/dcn30_hubp.c    |   2 +
 .../amd/display/dc/hubp/dcn35/dcn35_hubp.c    |   1 +
 .../amd/display/dc/hubp/dcn401/dcn401_hubp.c  |   3 +
 .../amd/display/dc/hubp/dcn42/dcn42_hubp.c    |   1 +
 .../amd/display/dc/hwss/dce110/dce110_hwseq.c |  40 +-
 .../amd/display/dc/hwss/dce120/dce120_hwseq.c |   4 +
 .../amd/display/dc/hwss/dcn10/dcn10_hwseq.c   |  23 +-
 .../amd/display/dc/hwss/dcn20/dcn20_hwseq.c   |  13 +-
 .../amd/display/dc/hwss/dcn30/dcn30_hwseq.c   |   5 +-
 .../amd/display/dc/hwss/dcn303/dcn303_hwseq.c |  11 +
 .../amd/display/dc/hwss/dcn31/dcn31_hwseq.c   |   4 +-
 .../amd/display/dc/hwss/dcn314/dcn314_hwseq.c |   1 +
 .../amd/display/dc/hwss/dcn32/dcn32_hwseq.c   |   4 +-
 .../amd/display/dc/hwss/dcn35/dcn35_hwseq.c   |   6 +-
 .../amd/display/dc/hwss/dcn401/dcn401_hwseq.c | 122 ++--
 .../amd/display/dc/hwss/dcn401/dcn401_hwseq.h |   3 +-
 .../amd/display/dc/hwss/dcn42/dcn42_hwseq.c   |   6 +-
 .../drm/amd/display/dc/hwss/hw_sequencer.h    |   2 +-
 .../dc/irq/dce110/irq_service_dce110.c        |  12 +-
 .../dc/irq/dce120/irq_service_dce120.c        |   2 +-
 .../display/dc/irq/dce80/irq_service_dce80.c  |  10 +-
 .../display/dc/irq/dcn10/irq_service_dcn10.c  |   5 +-
 .../display/dc/irq/dcn20/irq_service_dcn20.c  |   5 +-
 .../display/dc/irq/dcn21/irq_service_dcn21.c  |   5 +-
 .../display/dc/irq/dcn30/irq_service_dcn30.c  |   5 +-
 .../dc/irq/dcn302/irq_service_dcn302.c        |   7 +-
 .../dc/irq/dcn303/irq_service_dcn303.c        |   5 +-
 .../display/dc/irq/dcn31/irq_service_dcn31.c  |   7 +-
 .../dc/irq/dcn314/irq_service_dcn314.c        |   7 +-
 .../dc/irq/dcn315/irq_service_dcn315.c        |   7 +-
 .../display/dc/irq/dcn32/irq_service_dcn32.c  |   7 +-
 .../display/dc/irq/dcn35/irq_service_dcn35.c  |   7 +-
 .../dc/irq/dcn351/irq_service_dcn351.c        |   7 +-
 .../display/dc/irq/dcn36/irq_service_dcn36.c  |   7 +-
 .../dc/irq/dcn401/irq_service_dcn401.c        |   7 +-
 .../display/dc/irq/dcn42/irq_service_dcn42.c  |   7 +-
 .../display/dc/link/accessories/link_dp_cts.c |   2 +
 .../amd/display/dc/link/hwss/link_hwss_dpia.c |  22 +-
 .../display/dc/link/hwss/link_hwss_hpo_dp.c   |   6 +
 .../link_hwss_hpo_fixed_vs_pe_retimer_dp.c    |   1 +
 .../display/dc/link/hwss/link_hwss_virtual.c  |   6 +
 .../drm/amd/display/dc/link/link_detection.c  |  12 +-
 .../gpu/drm/amd/display/dc/link/link_dpms.c   |   3 +-
 .../drm/amd/display/dc/link/link_validation.c |   1 +
 .../dc/link/protocols/link_dp_training.c      |   2 +
 .../protocols/link_dp_training_128b_132b.c    |   1 +
 .../dc/link/protocols/link_dp_training_dpia.c |   6 +
 .../amd/display/dc/link/protocols/link_dpcd.c |   1 +
 .../drm/amd/display/dc/mpc/dcn30/dcn30_mpc.c  |   6 +-
 .../drm/amd/display/dc/mpc/dcn32/dcn32_mpc.c  |   1 +
 .../drm/amd/display/dc/opp/dcn10/dcn10_opp.c  |   1 +
 .../amd/display/dc/optc/dcn10/dcn10_optc.c    |   4 +
 .../amd/display/dc/optc/dcn20/dcn20_optc.c    |   2 +
 .../amd/display/dc/optc/dcn30/dcn30_optc.c    |   1 +
 .../amd/display/dc/optc/dcn31/dcn31_optc.c    |   1 +
 .../amd/display/dc/optc/dcn314/dcn314_optc.c  |   1 +
 .../amd/display/dc/optc/dcn32/dcn32_optc.c    |   1 +
 .../amd/display/dc/optc/dcn35/dcn35_optc.c    |   1 +
 .../dc/resource/dce100/dce100_resource.c      |   9 +-
 .../dc/resource/dce110/dce110_resource.c      |   6 +
 .../dc/resource/dce112/dce112_resource.c      |   7 +-
 .../dc/resource/dce120/dce120_resource.c      |   3 +-
 .../dc/resource/dce80/dce80_resource.c        |   7 +-
 .../dc/resource/dcn10/dcn10_resource.c        |   5 +-
 .../dc/resource/dcn20/dcn20_resource.c        |  24 +-
 .../dc/resource/dcn21/dcn21_resource.c        |  33 +-
 .../dc/resource/dcn21/dcn21_resource.h        |   3 +-
 .../dc/resource/dcn30/dcn30_resource.c        |   5 +-
 .../dc/resource/dcn301/dcn301_resource.c      |   3 +-
 .../dc/resource/dcn302/dcn302_resource.c      |   3 +-
 .../dc/resource/dcn303/dcn303_resource.c      |   3 +-
 .../dc/resource/dcn31/dcn31_resource.c        |  16 +-
 .../dc/resource/dcn314/dcn314_resource.c      |   6 +-
 .../dc/resource/dcn315/dcn315_resource.c      |  10 +-
 .../dc/resource/dcn316/dcn316_resource.c      |   9 +-
 .../dc/resource/dcn32/dcn32_resource.c        |   2 +-
 .../resource/dcn32/dcn32_resource_helpers.c   |   1 +
 .../dc/resource/dcn321/dcn321_resource.c      |   2 +-
 .../dc/resource/dcn35/dcn35_resource.c        |  15 +-
 .../dc/resource/dcn35/dcn35_resource.h        |   1 +
 .../dc/resource/dcn351/dcn351_resource.c      |  15 +-
 .../dc/resource/dcn36/dcn36_resource.c        |   6 +-
 .../dc/resource/dcn401/dcn401_resource.c      |  32 +-
 .../dc/resource/dcn42/dcn42_resource.c        |  34 +-
 .../dcn42/dcn42_soc_and_ip_translator.c       |   1 +
 .../gpu/drm/amd/display/dmub/inc/dmub_cmd.h   |   1 +
 .../gpu/drm/amd/display/dmub/src/dmub_dcn20.c |  20 +-
 .../gpu/drm/amd/display/dmub/src/dmub_dcn30.c |   1 +
 .../gpu/drm/amd/display/dmub/src/dmub_dcn31.c |  23 +-
 .../gpu/drm/amd/display/dmub/src/dmub_dcn32.c |  17 +-
 .../gpu/drm/amd/display/dmub/src/dmub_dcn35.c |  18 +-
 .../drm/amd/display/dmub/src/dmub_dcn401.c    |  22 +-
 .../gpu/drm/amd/display/dmub/src/dmub_dcn42.c |  24 +-
 .../gpu/drm/amd/display/dmub/src/dmub_reg.c   |   4 +-
 .../gpu/drm/amd/display/dmub/src/dmub_srv.c   |   8 +-
 235 files changed, 2259 insertions(+), 1129 deletions(-)
 create mode 100644 drivers/gpu/drm/amd/display/dc/dml2_0/dml21/dml21_wrapper_fpu.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/dml2_0/dml21/dml21_wrapper_fpu.h

-- 
2.43.0

