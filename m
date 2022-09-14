Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFAAFECAAD8
	for <amd-gfx@archiver.kernel.org>; Wed, 14 Sep 2022 05:11:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CB64310E176;
	Wed, 14 Sep 2022 05:11:44 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2060.outbound.protection.outlook.com [40.107.94.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2750A10E176
 for <amd-gfx@lists.freedesktop.org>; Wed, 14 Sep 2022 05:11:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cWoYOOY/tKy9DY2Wyw4pfUW1QDvZbEpa8rPxnMAGFZAAJDQ0pP9nV9hGzy/jXPldHmBv7t7do7stFsfhVWicIv78KgTvto2NQHiWvv6ujfKuocqNKcc5sJy54rHIpG8tzlhApW9Pqavn8HDtC3jFWFUm+Y/2Ug9hnYfvcypJqD+ZNaL1kQV3oGvuFGU3xlBzf/2bHG+agqRWBNx5F6loI/+LGC/+xe7c2IhK1vIW+hCT5OIC8L2hstcHFoREwuJMY8y91/uDovOjek8YH48YY8Vk33EAY6CgQMWutgG4U2wSvWvfqLwL2cFl/cyix0y+rN77CYilsGl4MfyoJcOyPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8/PlMaKhkknjuMR1GJTFrc8FQyj+af6x7WKQ6AsV1fw=;
 b=CWNkssuHTip3oRAUM5LpMHFcMUF9O4UHOV625+FAlVn4HYtl6kAK5h77R+t3eCA07tMhVUypJs2Bj40LnF9PF80fZCVwCf+lJKFXf/8uJw9hFwDTk3oZKCQqNjQVyFMwiYtE2uLYub0oVOfm9GRclZveI2UF4bJ4FrVsgKXzpPs+AKgw24V7/bNDY40ZYSb9UK6aw+RfCT99V5cGkApEGAH06m2Zt22NmZIzZ/KCBkTeobbyDXkIFjIpy3lfzpbQJ1tZavR4V6UGmHRwZCB3m235g+lso+4u7as/+jNBhWyc76a3B9hGqXN93t1ksUbMyxndxHL5pXdbOrdF3CO5pA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8/PlMaKhkknjuMR1GJTFrc8FQyj+af6x7WKQ6AsV1fw=;
 b=4+VbSjJyRdzst9i/L+5ir93nZWSk8HVe8YRYMY/kwEz3eicEFSXSbQMl7/1GGc8dBA2lJYp0AanpMeKLvXxvhEXZMB0NIFcUpceYYjKuXoU1sZeAaMLjJR46yeJy3zaqVzIUE2dK2VSkdy7HnoGoR+s9JNLplY/hlBvUE/mVj5o=
Received: from MW4PR04CA0206.namprd04.prod.outlook.com (2603:10b6:303:86::31)
 by IA1PR12MB6601.namprd12.prod.outlook.com (2603:10b6:208:3a3::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.22; Wed, 14 Sep
 2022 05:11:37 +0000
Received: from CO1NAM11FT070.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:86:cafe::a5) by MW4PR04CA0206.outlook.office365.com
 (2603:10b6:303:86::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.18 via Frontend
 Transport; Wed, 14 Sep 2022 05:11:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT070.mail.protection.outlook.com (10.13.175.20) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5632.12 via Frontend Transport; Wed, 14 Sep 2022 05:11:36 +0000
Received: from SATLEXMB07.amd.com (10.181.41.45) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Wed, 14 Sep
 2022 00:11:31 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB07.amd.com
 (10.181.41.45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Tue, 13 Sep
 2022 22:11:28 -0700
Received: from wayne-dev-lnx.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.28 via Frontend
 Transport; Wed, 14 Sep 2022 00:11:19 -0500
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH V3 00/47] DC Patches September 14, 2022
Date: Wed, 14 Sep 2022 13:09:59 +0800
Message-ID: <20220914051046.1131186-1-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT070:EE_|IA1PR12MB6601:EE_
X-MS-Office365-Filtering-Correlation-Id: f4fcba99-862e-451e-f901-08da960f992f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IK8AOMEa5mJ1NvHCW/X+8eMB/FcQPuPG3HFtvlCmwmJtWaIpNA/L2E1kRulZFji+DmEhh5AINMObtXzuqcX8fJlf1KipUjwwxAmzVXLq0I4TAgfciB1UYX/kFTFAGCskmy4Rf74+mHoXu/jDNkqaO89gu6rA2BSFcLBYGXV3HdpVfrRVhNlB4Z2BGP8ao/swZoxa4tUExhAj0KJ0oTal09/XvSx7NW8ZzF4NHXeaBsE1iQqufD8SiB94F1hQvKV+iZjsEO89ZKpcpNNdG1EMWDVfzB5J/uYYsDE1dz/pr8BfdW+8B7X/ta0JtZ0y30e2rr8GHLm8tUdFpmCoWg3AwdZ0+T6pJ2BUo0j6an8+eGF/2LM7fDIEplFkRRRmm9C1dhBn+OHstPAUh9uC2YU9vsI6/Cu+j4ghDtjkjSZgHINCKcABUYkmkH4TpBi4Xk5NzjkLzb0QstwcNG8TsntH1NfG00MhzQ3XdoVaYUWzjTknOG/GB6brf5EOunRqRlNEwJNDhyk5w9ih3RUpyx1139g/PoPr+WbIJTcwCf9faIfluSZQlMqXuAGItm4CtwbYDQYMGA4hymJH6kYCZRCGK5KoLeRHm3b+Vk+11rvpm8IjIY3ydCoeCLg2bzA71kyXP4iG7PYcyA2HSHXYHs5ogFcjCEbXNfm+ooo1WxU+8lVbkh3aA8TNyzCW0tk8OhI0cVDG+rw6XH2HrskXIFsJISsXb/u3rVfQiPgpcih7keRu/qK7g6Kw3veicJr4fpYV7CYEvud9E5xWksosqbhSvWHItCGKfvrJUhCO4F+b4pM=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(376002)(396003)(346002)(136003)(39860400002)(451199015)(46966006)(40470700004)(36840700001)(82310400005)(426003)(47076005)(40460700003)(54906003)(86362001)(356005)(6916009)(478600001)(41300700001)(7696005)(316002)(336012)(36860700001)(83380400001)(2906002)(26005)(82740400003)(2616005)(186003)(5660300002)(36756003)(1076003)(8936002)(40480700001)(81166007)(70206006)(4326008)(6666004)(8676002)(70586007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2022 05:11:36.3205 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f4fcba99-862e-451e-f901-08da960f992f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT070.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6601
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

Sorry for spamming..
Resend again due to network issues.

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

