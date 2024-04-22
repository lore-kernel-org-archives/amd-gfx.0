Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9EDCEC4345F
	for <amd-gfx@archiver.kernel.org>; Mon, 22 Apr 2024 15:28:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3CAB110EA96;
	Mon, 22 Apr 2024 15:28:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="r42EC3dv";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2072.outbound.protection.outlook.com [40.107.236.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DF5E210EA96
 for <amd-gfx@lists.freedesktop.org>; Mon, 22 Apr 2024 15:28:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Pu6itHZNuRBRbcZlPC/dt6MnkU+2EmTI1yrRKlSQ1yCLoUkb5d8LXGDQ9hNtm9IwTbSD7CQpCwqw4XPqIr5ghbN1+7jzml+dOd/E39C5zeDS76sBO0fX6sLaj8t8ylc/Ejox5NO+gk7yl7p+YSWdwLTtROjbOg5KJPqOFromG/YdiH/9t3f4bZBOMOaj11YvyqcppkvwO9+p7MWqbyMhGcomf15h5730Iw39U9GJMmo/j6mu95Vr5nuU0U58f0CXjAd8+05M0PSgcWHzmo5/w4B80N/xb8ScNORYK83zI37p2ho8ri7z6cEVQJH+XGlAkvpdnX29NbjRde16jhW93g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6ca+aUvLtG6pa21a16VGfAsrTb8FGYT8Fy2r4NDPN/0=;
 b=RpkGya0p56iagc3nXn1LwSEvoxcvPwLvLA5biuqJ9mIz0SAOQ+q8gQD4DzObK1X9IP2xbGbUbrlXZBxWh+GmYAIQKA5fyBJTedkuAFsJNf7ZQ0998SS5WzgRt72RQcybgWkvjSlFy5LE+NErDcqrwKhrCZe0zZ2FZ3ZdWbaUk/UXbhoRdeYL4rD+XjFR90aPRdg0uco2SVUHBOY2qpdv7okPjnfz0CQi/qKuc7F5QX7+E2CC/8e7Dzbk0cT6xSRjXYQ6smPbS7GkCP7XXBvloxJahr1of8YPAouKFBGS1pEFuZVQHhS2ODlb9iooLq66gEZz2dsVXuJukdtXKTMiHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6ca+aUvLtG6pa21a16VGfAsrTb8FGYT8Fy2r4NDPN/0=;
 b=r42EC3dvDvQYqtiG7yAjuktQEo0po6uLakbQ5RGNLq4x0rtCbUV5Jo1Kbph6bf4u4Nqflk9YqbeoeKNGFEWx78bAk2WnESJXATSh5kLWEQcQ4g4jOnHBMg0uuY6dHPVygeh4C/e/TP0/jsvjdYgTkbYbByNGEDPwoAkmnG7nY3c=
Received: from PH0PR07CA0050.namprd07.prod.outlook.com (2603:10b6:510:e::25)
 by DS7PR12MB6309.namprd12.prod.outlook.com (2603:10b6:8:96::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Mon, 22 Apr
 2024 15:28:24 +0000
Received: from SN1PEPF00036F40.namprd05.prod.outlook.com
 (2603:10b6:510:e:cafe::c1) by PH0PR07CA0050.outlook.office365.com
 (2603:10b6:510:e::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7495.33 via Frontend
 Transport; Mon, 22 Apr 2024 15:28:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SN1PEPF00036F40.mail.protection.outlook.com (10.167.248.24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7519.19 via Frontend Transport; Mon, 22 Apr 2024 15:28:24 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 22 Apr
 2024 10:28:23 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 22 Apr
 2024 10:28:23 -0500
Received: from aaurabin-suse.king-squeaker.ts.net (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.35
 via Frontend Transport; Mon, 22 Apr 2024 10:28:18 -0500
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <hersenxs.wu@amd.com>, <jerry.zuo@amd.com>, Aurabindo Pillai
 <aurabindo.pillai@amd.com>
Subject: [PATCH 00/37] DC Patches April 22, 2024
Date: Mon, 22 Apr 2024 11:27:09 -0400
Message-ID: <20240422152817.2765349-1-aurabindo.pillai@amd.com>
X-Mailer: git-send-email 2.44.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF00036F40:EE_|DS7PR12MB6309:EE_
X-MS-Office365-Filtering-Correlation-Id: 19617306-f3b3-47fd-799f-08dc62e0d99c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?KFGHYsYGxx9NknFzPCZL6KUUNbFlCeN/zuNfBo5o5gTXJJUC/KzoxJMpCHRh?=
 =?us-ascii?Q?GLkG0+e9g3rUeb2TaJT2avo4LUx/mdGutCoQ7teMPDHlJQfY0qQBw6svhO6b?=
 =?us-ascii?Q?5PpHQpu+SyDdpWAtbcdKm8WFyJ2G2OaUo9piZYdkmV62+/o3ZDGwQnJBVZ8v?=
 =?us-ascii?Q?D2YNYrh9ZHsS7m8YQIkap4FrmSE3t3GNAG0Qhmd45J4ZRwkDIk9YGAlYeJr+?=
 =?us-ascii?Q?aODkkNE9DYs33gnOUB6Tl+3td0icSL5+owfcCCn12KBVah94qRpEVvym2mV2?=
 =?us-ascii?Q?2r7ZvzKNY/AqopfJzqZDxDn/vtL9h12DSy1abPMao2OeoQ10mGpCcoS/YSP+?=
 =?us-ascii?Q?IT8tAfUa5VEWYgkg6Dd9OQrjFGV4oP2pPyaPPsvG3Iy05hPgDyeOUxiDG8Vq?=
 =?us-ascii?Q?+GRWJ4cfXlCR/Zd1/aryImMz4UuYjdrEQ4u29mw3hMnv2o/6baekwN3XRLyZ?=
 =?us-ascii?Q?I3Z1XlDCNXBNrKFTLbFR0UKqfzO9YW1LcwAtfSHXyHamQTmPTdilBXYRj83q?=
 =?us-ascii?Q?lkJJJBMslVz8ka32Eh0A7Ftxcz2WWVVFbdrVwmkncNuzovFP6ySeCOvsAqKn?=
 =?us-ascii?Q?JUkYOo682y2/M6+Q28afrpcj49sq77xr66nd2Xj1q8gmT/QZg0BgEiMRgVcf?=
 =?us-ascii?Q?fYf0cqJG1ySsQYhU3Z9DkZRyXxFC48R1RlGcIQ6M0Agp5nkh6bMgld+QllYS?=
 =?us-ascii?Q?ST6rkwMvVNuC13/4wiwUFo3TLqj47znCqom21N7cDMb06z+0q5MqHw8w2028?=
 =?us-ascii?Q?S7ugYZv7uMA5DVuCUPmnSWYw0omY3bQs1FMMxE/rCi1/y2FQynVb7H2RhQyR?=
 =?us-ascii?Q?9rXI0sbkL/4/SjaybuBvKT88roV0M5DOmCAy1zKZMYNCwRQjAhv9myzVu8B6?=
 =?us-ascii?Q?hA4oqVEWQfVAgyAkD+jYNxWA3iy1GZRyo2FkJH76023KUX45htqpNWC6Tzfi?=
 =?us-ascii?Q?s4MRCO8N6Ua+DTprg14FYnnpC9SglxsvuSP+L30BGZXjA92+vM0ov7uPasBh?=
 =?us-ascii?Q?AATP1TRne0Hfr4DeMFrI5XQ+0vgiYy9fke9dWE3e3zmW9aGDA46Ap1kazExk?=
 =?us-ascii?Q?RZty9MxR6R4l1xTBakA9GpjEby+RPkTXogOi73REDPSNCh0M16wduMNZ+3N6?=
 =?us-ascii?Q?Am6oER7Two8Uu0EYCekuNuRYlQz9z+VEgNeoc6ZXxZFXg9FeSPPExwnl2k4w?=
 =?us-ascii?Q?b4v82BVmSBiWfnfBXw8joahtnOtVUUl4qrcLQM7CNenVdhxxreS8RPd9s/oD?=
 =?us-ascii?Q?xiX7tWqWekwebCMcnPoV7jQXFrFJzpqDvgQdbrZLUsPDJRMIKoGVu/GwqidS?=
 =?us-ascii?Q?KjXzI2Wf7zp+7Ms1sKI8SuIosmoaYBQT+tyejhXN+UFOw/NKQ6M01w/fmR9y?=
 =?us-ascii?Q?56phjbbo3J7pAJcbnTkcI7w/TA3z?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(36860700004)(82310400014)(376005)(1800799015); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2024 15:28:24.2249 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 19617306-f3b3-47fd-799f-08dc62e0d99c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF00036F40.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6309
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
    
    * Changes across DSC, MST, DMCUB, Panel Replay and misc fixes.
    * Fixes to cursor programming sequence
    * Add some missing register defs
    * Formatting/Sytle fixes

==========

Anthony Koo (1):
  drm/amd/display: [FW Promotion] Release 0.0.214.0

Aric Cyr (1):
  drm/amd/display: 3.2.282

Cruise (1):
  drm/amd/display: Disable error correction if it's not supported

Dennis Chan (1):
  drm/amd/display: Fix Replay Desync Error Test

Dmytro Laktyushkin (1):
  drm/amd/display: Increase SAT_UPDATE_PENDING timeout

Ethan Bitnun (1):
  drm/amd/display: Block FPO According to Luminance Delta

Gabe Teeger (1):
  drm/amd/display: Atom Integrated System Info v2_2 for DCN35

George Shen (2):
  drm/amd/display: Handle Y carry-over in VCP X.Y calculation
  drm/amd/display: Skip SST ACT polling when sink_count is 0

Harry Wentland (2):
  drm/amd/display: Separate setting and programming of cursor
  drm/amd/display: Set cursor attributes before position

Hersen Wu (1):
  drm/amd/display: Fix incorrect DSC instance for MST

Ilya Bakoulin (1):
  drm/amd/display: Add condition for dp_set_dsc_config call

Joshua Aberback (1):
  Revert "drm/amd/display: Fix incorrect pointer assignment"

Meenakshikumar Somasundaram (1):
  drm/amd/display: Allocate zero bw after bw alloc enable

Michael Strauss (1):
  drm/amd/display: Add delay to improve LTTPR UHBR interop

Natanel Roizenman (1):
  drm/amd/display: Add null check in resource_log_pipe_topology_update

Nicholas Kazlauskas (1):
  drm/amd/display: Force flush after write to IPS driver signals

Rodrigo Siqueira (13):
  drm/amd/display: Add missing debug registers for DCN2/3/3.1
  drm/amd/display: Add missing dwb registers
  drm/amd/display: Add TMDS DC balancer control
  drm/amd/display: Add some missing HDMI registers for DCN3x
  drm/amd/display: Clean up code in DC
  drm/amd/display: Adjust registers sequence in the DIO list
  drm/amd/display: Code style adjustments
  drm/amd/display: Add some HDCP registers DCN35 list
  drm/amd/display: Update comments in DC
  drm/amd/display: Ensure that dmcub support flag is set for DCN20
  drm/amd/display: Add missing IRQ types
  drm/amd/display: Drop unnecessary semicolon
  drm/amd/display: Replace uint8_t with u8 for
    dp_hdmi_dongle_signature_str

Sung Joon Kim (3):
  drm/amd/display: Reuse the modified power sequence
  drm/amd/display: Fix recout calculation for stereo side-by-side
  drm/amd/display: Update dcn351 debug flags and function pointers

Sung-huai Wang (1):
  drm/amd/display: Handle HPD_IRQ for internal link

Swapnil Patel (1):
  drm/amd/display: Add dtbclk access to dcn315

yi-lchen (1):
  drm/amd/display: Keep VBios pixel rate div setting util next mode set

 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |   2 +-
 .../amd/display/amdgpu_dm/amdgpu_dm_debugfs.c |  48 ++-
 .../amd/display/amdgpu_dm/amdgpu_dm_plane.c   |   6 +-
 .../drm/amd/display/dc/bios/bios_parser2.c    |   1 +
 .../dc/clk_mgr/dcn315/dcn315_clk_mgr.c        |   8 +
 .../gpu/drm/amd/display/dc/core/dc_resource.c |  11 +
 .../gpu/drm/amd/display/dc/core/dc_state.c    |  10 +-
 .../gpu/drm/amd/display/dc/core/dc_stream.c   | 315 ++++++++++++++++--
 drivers/gpu/drm/amd/display/dc/dc.h           |   3 +-
 drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c  |   2 +
 drivers/gpu/drm/amd/display/dc/dc_dmub_srv.h  |   1 +
 drivers/gpu/drm/amd/display/dc/dc_stream.h    |  22 ++
 .../gpu/drm/amd/display/dc/dc_stream_priv.h   |  24 ++
 drivers/gpu/drm/amd/display/dc/dc_types.h     |   1 +
 .../drm/amd/display/dc/dce/dce_transform.h    |   1 -
 .../amd/display/dc/dcn20/dcn20_link_encoder.h |   5 +-
 .../drm/amd/display/dc/dcn201/dcn201_opp.h    |   3 +-
 .../gpu/drm/amd/display/dc/dcn30/dcn30_dccg.h |   3 +
 .../display/dc/dcn30/dcn30_dio_link_encoder.h |   3 +-
 .../gpu/drm/amd/display/dc/dcn30/dcn30_dwb.h  |  14 +-
 .../gpu/drm/amd/display/dc/dcn31/dcn31_dccg.h |   6 +
 .../display/dc/dcn31/dcn31_dio_link_encoder.h |   2 +
 .../dc/dcn31/dcn31_hpo_dp_link_encoder.c      |   8 +-
 .../drm/amd/display/dc/dcn314/dcn314_dccg.c   |  12 +-
 .../gpu/drm/amd/display/dc/dcn32/dcn32_dccg.c |  13 +-
 .../display/dc/dcn32/dcn32_dio_link_encoder.c |   6 +-
 .../display/dc/dcn32/dcn32_dio_link_encoder.h |  10 +-
 .../dc/dcn32/dcn32_dio_stream_encoder.c       |  40 +--
 .../dc/dcn32/dcn32_dio_stream_encoder.h       |   5 +-
 .../display/dc/dcn32/dcn32_resource_helpers.c |   9 +-
 .../dc/dcn321/dcn321_dio_link_encoder.c       |   8 +-
 .../gpu/drm/amd/display/dc/dcn35/dcn35_dccg.c |   8 +-
 .../display/dc/dcn35/dcn35_dio_link_encoder.h |  12 +-
 .../dc/dcn35/dcn35_dio_stream_encoder.c       |  36 +-
 drivers/gpu/drm/amd/display/dc/dm_helpers.h   |   3 +-
 .../drm/amd/display/dc/dml/dcn10/dcn10_fpu.h  |   2 +-
 .../amd/display/dc/dpp/dcn201/dcn201_dpp.c    |  13 +-
 .../dc/gpio/dcn21/hw_translate_dcn21.c        |   2 +-
 .../amd/display/dc/hwss/dce110/dce110_hwseq.c |  24 +-
 .../amd/display/dc/hwss/dcn10/dcn10_hwseq.c   |   2 +-
 .../amd/display/dc/hwss/dcn20/dcn20_hwseq.c   |  23 +-
 .../amd/display/dc/hwss/dcn30/dcn30_hwseq.c   |   2 +-
 .../amd/display/dc/hwss/dcn314/dcn314_hwseq.c |  23 ++
 .../amd/display/dc/hwss/dcn314/dcn314_hwseq.h |   4 +
 .../amd/display/dc/hwss/dcn314/dcn314_init.c  |   1 +
 .../amd/display/dc/hwss/dcn32/dcn32_hwseq.c   |  44 ++-
 .../amd/display/dc/hwss/dcn32/dcn32_hwseq.h   |   4 +
 .../amd/display/dc/hwss/dcn32/dcn32_init.c    |   1 +
 .../amd/display/dc/hwss/dcn35/dcn35_init.c    |   1 +
 .../amd/display/dc/hwss/dcn351/dcn351_init.c  |  10 +-
 .../display/dc/hwss/hw_sequencer_private.h    |   3 +
 .../gpu/drm/amd/display/dc/inc/core_types.h   |   7 +
 drivers/gpu/drm/amd/display/dc/inc/hw/dccg.h  |   5 +
 .../drm/amd/display/dc/inc/hw/link_encoder.h  |   3 +-
 .../amd/display/dc/inc/hw/stream_encoder.h    |   1 +
 drivers/gpu/drm/amd/display/dc/irq_types.h    |   8 +
 .../link_hwss_hpo_fixed_vs_pe_retimer_dp.c    |   5 +
 .../drm/amd/display/dc/link/link_detection.c  |   2 +-
 .../gpu/drm/amd/display/dc/link/link_dpms.c   |  22 +-
 .../dc/link/protocols/link_dp_dpia_bw.c       |  10 +-
 .../dc/link/protocols/link_dp_irq_handler.c   |  25 +-
 .../display/dc/link/protocols/link_dp_phy.c   |  47 ++-
 .../dc/resource/dcn20/dcn20_resource.c        |  13 +-
 .../dc/resource/dcn30/dcn30_resource.c        |   2 +-
 .../dc/resource/dcn351/dcn351_resource.c      |   4 +-
 .../gpu/drm/amd/display/dmub/inc/dmub_cmd.h   |   2 +-
 .../include/asic_reg/dcn/dcn_3_0_0_offset.h   |   4 +
 .../include/asic_reg/dcn/dcn_3_0_0_sh_mask.h  |   5 +
 .../include/asic_reg/dcn/dcn_3_1_5_offset.h   |   4 +
 .../include/asic_reg/dcn/dcn_3_1_5_sh_mask.h  |  10 +
 .../include/asic_reg/dpcs/dpcs_3_0_0_offset.h |  24 ++
 .../asic_reg/dpcs/dpcs_3_0_0_sh_mask.h        |   4 +-
 72 files changed, 763 insertions(+), 264 deletions(-)

-- 
2.44.0

