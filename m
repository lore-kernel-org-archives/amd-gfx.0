Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7C23ECAAD8
	for <amd-gfx@archiver.kernel.org>; Wed, 14 Sep 2022 03:25:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CD00F10E7DD;
	Wed, 14 Sep 2022 03:25:09 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2073.outbound.protection.outlook.com [40.107.220.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8067210E7DD
 for <amd-gfx@lists.freedesktop.org>; Wed, 14 Sep 2022 03:25:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Iio0tTaW7a7WtyaFCpGXih0Iwvgz0aIN+2wuclkK0r/WTZXl7SX7BzEbpcTmhQ8U2rzhx06v6X7ZNviuacPvTsr77awtgTZZNE0C1j8FIgT/M2ewSQMt7DENdIwUWENzjw4OyHRYw4NXLQ2/JpLNeCkD3Gjgu9uhreDXISdUp9h16uEyR0w5y7F2xRJjl+WTutD8BXsPk12UfcxbtQYb3LH7El0qv36wfMr0HdVlgR4Vqavi/n/nVK83KT6g4dSSLDGGG/eDOgOplVMGGkvIuXT0Vw5hkzBtkfNAWYX5D804j4b5FwacHz150bRLD2pjj2XWfr7j0lHsI6GejW32HA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JQQjZEh/NuzIG6vK6NyOSp5upmcV1HwcwkC08Wr98KE=;
 b=H8gq35GwRuCxhZfYMGnalOOEieSFPWbo24uFZA1QTy3/SIalbw6dOt294nnExvcolOEFTXSJypY9/EicjNXCpj0G3fAqLy91yRFRO2eK6lm7vI3L4AK9DtFi2hkC2IT3W/epCBk2+CA51b6RJYBIw5bhhJat86NBLZA16c4ygNDVT7kSus8jd495w25GLNXQR18MdkBk37BgglYGdq8SuPNxPVeljOBQf/fbSwFFmP17AG4f/HO8FWinxWif/y67pkY/lQXgkeOEv0S19mMyJEZ99lh6/HIgXrwDXyEhPt8NLVp79WjYxbV8896M5cBfUQsxJE75aek1lRpsywqtZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JQQjZEh/NuzIG6vK6NyOSp5upmcV1HwcwkC08Wr98KE=;
 b=4xNjt+vy1MC4XY3bYFp6l7xpo19F/E6/lM399A3Eiui1/uKyD350nUevblBQ/3LikbkgQxesBkOnOSoWzIUFUMDAtIxQN+vCmzx2ua3HrW9baitWjk0JsA77w4DEf7iETZVIrRkxkfMZGCdXIhpU0Xs7TXu1fE4fMPeVw5658nw=
Received: from DM6PR14CA0059.namprd14.prod.outlook.com (2603:10b6:5:18f::36)
 by CY5PR12MB6597.namprd12.prod.outlook.com (2603:10b6:930:43::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.22; Wed, 14 Sep
 2022 03:25:01 +0000
Received: from DM6NAM11FT070.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:18f:cafe::2c) by DM6PR14CA0059.outlook.office365.com
 (2603:10b6:5:18f::36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.14 via Frontend
 Transport; Wed, 14 Sep 2022 03:25:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DM6NAM11FT070.mail.protection.outlook.com (10.13.173.51) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5632.12 via Frontend Transport; Wed, 14 Sep 2022 03:25:00 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Tue, 13 Sep
 2022 22:25:00 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Tue, 13 Sep
 2022 20:25:00 -0700
Received: from wayne-dev-lnx.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.28 via Frontend
 Transport; Tue, 13 Sep 2022 22:24:50 -0500
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 00/47] DC Patches September 14, 2022
Date: Wed, 14 Sep 2022 11:23:54 +0800
Message-ID: <20220914032441.1075031-1-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT070:EE_|CY5PR12MB6597:EE_
X-MS-Office365-Filtering-Correlation-Id: ec177183-d77f-4cab-18a5-08da9600b517
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ese5FntaaLjmYbRF0YTKEfXGpb0HmkwpPRbHZ9sYh21TMk6lGlaOyCP2KSIhiGF+5aJOXfZSSlFeQiIC2GUNVQy9V9MfczeoeAQi6ruJ1aLfCOlTo467bi4siekrMsohrGUixZKEvOQOaMT5UZFj9Dmu9FcQ/OIMsWcPldpAh+auyou6rYxB0Fzud7/F8usUFECAN3491YbrKZRjO/SZ2WnbM+kad6XXb0Ik8BEesZ7x7A5pTqeH/iv4guyJJXKGP3dMFynSp7u+bnW1xnJSU/6ugP27ahk89PCRiKAO+0owIJRcdgOOHQu/1lisL4VEE2EsJi8O99LMjhJDwwmwU5hqSbxFq1g3qkUL3DdakHZo7qaliwPg+6TuqhE5mJ2Sc2HRaP7TXDQ4ADXpldE+7Rf6Yf2EUnRq8T61BW4zJWA3YG0lYhL/Ru0yHfRX1MdGNPg1APkpvjY9KS3983qOJuGK2dN7/ZHtmQZRIbQDbPf8Lbbi9BlJiZpD3hSrqpD7DF/dJ0xxmDlYVJa9kkXmGHxDGHEc+2cE229N/LUojJhBeSRTyotZwge0rXhgt/GXP2ofByxQ+YZZ+Nwlg6tzC5CKQy7eUwkvSDT84jtI+JB66bGAb6grBsbgTXbp3j6txytLz95rbADlFTfh/F9qdcafu1EhtppULrmj5QK+xvLy5cptFPmxL9365ACSs/9dnFM8XJiJvSJlHqZf81iO07FpaZU67HHHuJ6i3wz53fE7mfXCViCTKu31w6KOdop94cDFQpBTJ6tydzW/unynlUhPc6i6LsGrUTxygpXrba0=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(376002)(39860400002)(136003)(346002)(396003)(451199015)(46966006)(36840700001)(40470700004)(83380400001)(8936002)(82740400003)(36860700001)(6916009)(40460700003)(426003)(26005)(8676002)(70206006)(1076003)(7696005)(70586007)(186003)(86362001)(4326008)(40480700001)(81166007)(5660300002)(2616005)(82310400005)(54906003)(47076005)(36756003)(478600001)(2906002)(336012)(316002)(41300700001)(356005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2022 03:25:00.7608 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ec177183-d77f-4cab-18a5-08da9600b517
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT070.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6597
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
Cc: stylon.wang@amd.com, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com, roman.li@amd.com,
 solomon.chiu@amd.com, Daniel Wheeler <daniel.wheeler@amd.com>,
 Aurabindo.Pillai@amd.com, Wayne Lin <Wayne.Lin@amd.com>,
 Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This DC patchset brings improvements in multiple areas. In summary, we highlight:

For DC version 3.2.203
- Port DCN30 420 logic to DCN32
- Remove some unused definitions from DCN32/321
- Remove dp dig pixle rate div policy from dcn314
- Fix dcn315 reading of memory channel count and width
- Fix SubVP and ODM relevant issues
- Fix pipe split, MPO and ODM relevant issues
- Support proper mst payload removal when link is not in mst mode in dc
- Assume an LTTPR is always present on fixed_vs links
- Rework recent update PHY state commit
- Add debug option and logs

For DC version 3.2.204
- Fix urgent latency override for DCN32/DCN321
- Correct hostvm flag in DCN31
- Added new Asic Id for DCN301
- Adjust to 2 phys in DCN301
- Update dummy P-state search to use DCN32 DML
- Increase dcn315 pstate change latency
- Disable OTG WA for the plane_state NULL case on DCN314
- Update dccg based on HW delta
- Correct num_dsc for DCN314
- Fix DP DSC compliance failure with DCN314
- Refactor edp power sequencer codes
- update gamut remap if plane has changed
- Skip audio setup when audio stream is enabled
- Display distortion after hotplug LG Ultrafine 5K tiled display
- Fix DP MST timeslot issue when fallback happened
- Uncomment SubVP pipe split assignment in driver
- Enable committing subvp config
- Do second pass through DML for DET calculation
- Don't allocate DET for phantom pipes
- Modify DML to adjust Vstartup Position
- Ignore k1/k2 values for virtual signal to avoid assert
- Fix failures of disabling primary planes
- Do not compare integers of different widths
- Fix empty slot problem of EDID management
- Revise Sink device string ID width in dmub psr
- Log vertical interrupt 1 for debug

Cc: Daniel Wheeler <daniel.wheeler@amd.com>
---

Alex Hung (1):
  drm/amd/display: Fix failures of disabling primary plans

Alvin Lee (10):
  drm/amd/display: Fix pipe split prediction
  drm/amd/display: Only consider pixle rate div policy for DCN32+
  drm/amd/display: For ODM seamless transition require AUTO mode
  drm/amd/display: Add debug option for allocating extra way for cursor
  drm/amd/display: SubVP pipe split case
  drm/amd/display: Disable SubVP on driver disable
  drm/amd/display: Fix SubVP way calculation
  drm/amd/display: Uncomment SubVP pipe split assignment in driver
  drm/amd/display: Don't allocate DET for phantom pipes
  drm/amd/display: Do second pass through DML for DET calculation

Anthony Koo (1):
  drm/amd/display: [FW Promotion] Release 0.0.134.0

Aric Cyr (2):
  drm/amd/display: 3.2.203
  drm/amd/display: 3.2.204

Aurabindo Pillai (2):
  drm/amd/display: Remove some unused definitions from DCN32/321
  drm/amd/display: Enable committing subvp config

Charlene Liu (4):
  drm/amd/display: add debug option for dramclk_change_latency in apu
  drm/amd/display: Expose few dchubbub functions
  drm/amd/display: update dccg based on HW delta
  drm/amd/display: correct num_dsc based on HW cap

Chris Park (1):
  drm/amd/display: Port DCN30 420 logic to DCN32

Cruise Hung (1):
  drm/amd/display: Fix DP MST timeslot issue when fallback happened

Daniel Miess (1):
  drm/amd/display: Add shift and mask for ICH_RESET_AT_END_OF_LINE

Dmytro Laktyushkin (2):
  drm/amd/display: fix dcn315 memory channel count and width read
  drm/amd/display: increase dcn315 pstate change latency

George Shen (2):
  drm/amd/display: Fix urgent latency override for DCN32/DCN321
  drm/amd/display: Update dummy P-state search to use DCN32 DML

Hugo Hu (1):
  drm/amd/display: update gamut remap if plane has changed

Ian Chen (1):
  drm/amd/display: Refactor edp panel power sequencer(PPS) codes

Jaehyun Chung (1):
  drm/amd/display: Assume connectors are on single slot

Josip Pavic (2):
  drm/amd/display: do not compare integers of different widths
  drm/amd/display: log vertical interrupt 1 for debug

Leo Chen (1):
  drm/amd/display: Various logs added

Leo Li (1):
  drm/amd/display: Fix double cursor on non-video RGB MPO

Meenakshikumar Somasundaram (1):
  drm/amd/display: Display distortion after hotplug 5K tiled display

Michael Strauss (1):
  drm/amd/display: Assume an LTTPR is always present on fixed_vs links

Nicholas Kazlauskas (1):
  drm/amd/display: Disable OTG WA for the plane_state NULL case on
    DCN314

Pavle Kotarac (2):
  drm/amd/display: Added new DCN301 Asic Id
  drm/amd/display: Removing 2 phys

Robin Chen (1):
  drm/amd/display: Revise Sink device string ID

Rodrigo Siqueira (1):
  drm/amd/display: Ignore k1/k2 values for virtual signal

Sherry Wang (1):
  drm/amd/display: correct hostvm flag

Wenjing Liu (3):
  drm/amd/display: rework recent update PHY state commit
  drm/amd/display: support proper mst payload removal when link is not
    in mst mode in dc
  drm/amd/display: solve regression in update phy state refactor

muansari (1):
  drm/amd/display: Modify DML to adjust Vstartup Position

zhikzhai (1):
  drm/amd/display: skip audio setup when audio stream is enabled

 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |  12 +-
 .../amd/display/amdgpu_dm/amdgpu_dm_crtc.c    |  12 -
 .../amd/display/amdgpu_dm/amdgpu_dm_helpers.c |  11 +-
 .../drm/amd/display/dc/bios/bios_parser2.c    |  63 +++--
 .../display/dc/clk_mgr/dcn31/dcn31_clk_mgr.c  |  11 +-
 .../dc/clk_mgr/dcn314/dcn314_clk_mgr.c        |  14 +-
 .../dc/clk_mgr/dcn315/dcn315_clk_mgr.c        |  36 +--
 .../dc/clk_mgr/dcn316/dcn316_clk_mgr.c        |  11 +-
 drivers/gpu/drm/amd/display/dc/core/dc.c      |  19 +-
 drivers/gpu/drm/amd/display/dc/core/dc_link.c |  98 +++++---
 .../gpu/drm/amd/display/dc/core/dc_link_dp.c  | 119 +++-------
 .../gpu/drm/amd/display/dc/core/dc_resource.c |  39 ++++
 drivers/gpu/drm/amd/display/dc/dc.h           |   3 +-
 drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c  |  25 +-
 drivers/gpu/drm/amd/display/dc/dc_dmub_srv.h  |   1 +
 drivers/gpu/drm/amd/display/dc/dc_link.h      |  12 +-
 drivers/gpu/drm/amd/display/dc/dce/dmub_psr.c |   7 +-
 .../display/dc/dce110/dce110_hw_sequencer.c   | 170 ++++++++++++--
 .../display/dc/dce110/dce110_hw_sequencer.h   |  20 +-
 .../amd/display/dc/dcn10/dcn10_hw_sequencer.c |   9 +
 .../gpu/drm/amd/display/dc/dcn10/dcn10_init.c |   4 +
 .../gpu/drm/amd/display/dc/dcn10/dcn10_optc.c |   6 +
 .../gpu/drm/amd/display/dc/dcn10/dcn10_optc.h |   2 +
 .../gpu/drm/amd/display/dc/dcn20/dcn20_dccg.h |   1 +
 .../gpu/drm/amd/display/dc/dcn20/dcn20_dsc.h  | 220 ------------------
 .../drm/amd/display/dc/dcn20/dcn20_hwseq.c    |  44 +++-
 .../gpu/drm/amd/display/dc/dcn20/dcn20_init.c |   4 +
 .../drm/amd/display/dc/dcn201/dcn201_hwseq.c  |   3 +-
 .../drm/amd/display/dc/dcn201/dcn201_init.c   |   4 +
 .../gpu/drm/amd/display/dc/dcn21/dcn21_init.c |   4 +
 .../drm/amd/display/dc/dcn30/dcn30_hwseq.c    |  21 +-
 .../gpu/drm/amd/display/dc/dcn30/dcn30_init.c |   4 +
 .../drm/amd/display/dc/dcn301/dcn301_init.c   |   4 +
 .../amd/display/dc/dcn301/dcn301_resource.c   |   4 +-
 .../drm/amd/display/dc/dcn31/dcn31_hubbub.c   |   2 +-
 .../drm/amd/display/dc/dcn31/dcn31_hubbub.h   |   2 +
 .../drm/amd/display/dc/dcn31/dcn31_hwseq.c    |  11 +-
 .../gpu/drm/amd/display/dc/dcn31/dcn31_init.c |   4 +
 .../drm/amd/display/dc/dcn31/dcn31_resource.c |   2 +-
 .../drm/amd/display/dc/dcn314/dcn314_dccg.h   |  70 ++++--
 .../drm/amd/display/dc/dcn314/dcn314_hwseq.c  |  19 +-
 .../drm/amd/display/dc/dcn314/dcn314_hwseq.h  |   2 -
 .../drm/amd/display/dc/dcn314/dcn314_init.c   |   5 +-
 .../amd/display/dc/dcn314/dcn314_resource.c   |  11 +-
 .../drm/amd/display/dc/dcn32/dcn32_hubbub.c   |  10 +-
 .../drm/amd/display/dc/dcn32/dcn32_hubbub.h   |  29 +++
 .../drm/amd/display/dc/dcn32/dcn32_hwseq.c    | 100 +++++---
 .../drm/amd/display/dc/dcn32/dcn32_hwseq.h    |   5 +-
 .../gpu/drm/amd/display/dc/dcn32/dcn32_init.c |   5 +-
 .../drm/amd/display/dc/dcn32/dcn32_resource.c |  95 +++-----
 .../drm/amd/display/dc/dcn32/dcn32_resource.h |  11 +-
 .../display/dc/dcn32/dcn32_resource_helpers.c | 153 ++++++++++--
 .../amd/display/dc/dcn321/dcn321_resource.c   |  26 +--
 drivers/gpu/drm/amd/display/dc/dm_helpers.h   |   3 +-
 .../amd/display/dc/dml/dcn301/dcn301_fpu.c    |   5 +
 .../drm/amd/display/dc/dml/dcn31/dcn31_fpu.c  |  24 +-
 .../amd/display/dc/dml/dcn314/dcn314_fpu.c    |   7 +
 .../dc/dml/dcn314/display_mode_vba_314.c      |   2 +-
 .../drm/amd/display/dc/dml/dcn32/dcn32_fpu.c  | 172 +++++++++++---
 .../drm/amd/display/dc/dml/dcn32/dcn32_fpu.h  |  16 +-
 .../dc/dml/dcn32/display_mode_vba_32.c        |   2 +
 .../dc/dml/dcn32/display_mode_vba_util_32.c   |  26 +++
 .../dc/dml/dcn32/display_mode_vba_util_32.h   |   1 +
 .../amd/display/dc/dml/dcn321/dcn321_fpu.c    |   1 +
 .../amd/display/dc/dml/display_mode_structs.h |   1 +
 .../drm/amd/display/dc/dml/display_mode_vba.c |   1 +
 .../gpu/drm/amd/display/dc/inc/hw/hw_shared.h |  16 +-
 .../gpu/drm/amd/display/dc/inc/hw_sequencer.h |  23 +-
 .../gpu/drm/amd/display/dc/inc/link_hwss.h    |   6 +-
 drivers/gpu/drm/amd/display/dc/inc/resource.h |   6 +
 .../drm/amd/display/dc/link/link_hwss_dio.c   |   4 +-
 .../drm/amd/display/dc/link/link_hwss_dio.h   |   2 +-
 .../drm/amd/display/dc/link/link_hwss_dpia.c  |   2 +-
 .../amd/display/dc/link/link_hwss_hpo_dp.c    |   2 +-
 .../display/dc/virtual/virtual_link_hwss.c    |   8 +
 .../gpu/drm/amd/display/dmub/inc/dmub_cmd.h   |   3 +-
 .../gpu/drm/amd/display/include/dal_asic_id.h |   1 +
 .../amd/display/include/ddc_service_types.h   |   4 +-
 78 files changed, 1191 insertions(+), 726 deletions(-)

-- 
2.37.3

