Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3BE9C4332F
	for <amd-gfx@archiver.kernel.org>; Fri, 18 Nov 2022 16:59:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0284310E77D;
	Fri, 18 Nov 2022 16:59:28 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2072.outbound.protection.outlook.com [40.107.220.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A03A710E77D
 for <amd-gfx@lists.freedesktop.org>; Fri, 18 Nov 2022 16:59:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bnX8cNCd+u5yAtm77FGX9t/hCHRqtAAGcjdkzsJ3blFUM32u1IW6EDjATN5EWMQytLQjvlXRkHkVIgKay778NQHx/gcX0cgphoDd0p+aeBj3Ynz94fHuPofXNN+JpZFVySbPFaeno/vinIuXA/kukLCf3vffEFf1d2j2VEAW7Ad13aIw8xO0YbSbUkniRUZqQHqWRYhcmG013pfivVJvgbcXY5NDY1UApvo0zPSiQTwSn9czSDIC/UxtgLu/f3QU8fwF2fYvpx5s4t7vdmwEqWuZTHE66g/SxakUzmD6jweNeLvlEj7IhKQE2lSg0gXpqBBwNw4QZ+XTzjWasDqJZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2b15Vm8c/DFpkEKcqt30UsPCJkNmVICiwo0cOQviMBk=;
 b=PqDpL2ucHEXzqux/LQkm+VcO4Eqvyu5mDB7fKOsjPFMe4YXw+VJ6BclCka1H4kE/x/AlY0nGdwpI9arJna9o/yt1EzTDAEozpkpeURad0RBWD53bvWGci5P1ZA5T8HR2t2nCLTXinZovLbAxMyMnr2vOFIdK22AFD0d9i/rC/bTSuOsKft3Y0jDUq8Ay6sVqWeQ8NzSz2BKmoZQZRnUKGSSoEF71DS3c0Sl2AuABL9NTLQP0Z9aYrR5iAs7gibM//TYk/hM+kp1Hhi2M+Au3zskNBK/vYppdaTtAZsSh712tmJy91aMOciI+4kUredr2ltbxCNu6UnMxQXxSYYAnAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2b15Vm8c/DFpkEKcqt30UsPCJkNmVICiwo0cOQviMBk=;
 b=qOe4zCDATGk4BDE35LibZe0R3P02DQOsP6Bvpwoo0GmSmPH1Y1kn3K4mjKYm9SWoBCFgO4SmLCrp8kJeL186UgYzApNsBhrcHMU831DDcq7ZcayQqIm1qD15uL1px6OKV1gJ+m0iYWQoFcB6dG0hbLGleCcahx3EoW/3OmMC3xo=
Received: from MW4PR04CA0353.namprd04.prod.outlook.com (2603:10b6:303:8a::28)
 by LV2PR12MB5752.namprd12.prod.outlook.com (2603:10b6:408:14d::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.19; Fri, 18 Nov
 2022 16:59:14 +0000
Received: from CO1NAM11FT037.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8a:cafe::e1) by MW4PR04CA0353.outlook.office365.com
 (2603:10b6:303:8a::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.20 via Frontend
 Transport; Fri, 18 Nov 2022 16:59:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1NAM11FT037.mail.protection.outlook.com (10.13.174.91) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5834.8 via Frontend Transport; Fri, 18 Nov 2022 16:59:14 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 18 Nov
 2022 10:59:10 -0600
Received: from brianchang-HP-EliteDesk-805-G6-Small-Form-Factor-PC.amd.com
 (10.180.168.240) by SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP
 Server id 15.1.2375.34 via Frontend Transport; Fri, 18 Nov 2022 10:59:06
 -0600
From: brichang <Brian.Chang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 00/22] DC Patches November 19, 2022
Date: Fri, 18 Nov 2022 20:59:13 +0800
Message-ID: <20221118125935.4013669-1-Brian.Chang@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT037:EE_|LV2PR12MB5752:EE_
X-MS-Office365-Filtering-Correlation-Id: b1019bf2-5c88-4ff4-c342-08dac9863909
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: x0y+5e6Sm3oAcLpFGZtccitvgmALBwi7qxspmAtyImL3kUWWhSM3JrGd1tSvJv62KDQXtnpQPf5GrsjaQJsBGrylCzjzK154eG+VRHhAhDZWotrlfDECfIw7ThZmkGXCQuBjrSwti8W2MWk9PKyQpX8nQzYsBm3do2Kprn0dinqOChtaPvfEdgGka2ofI4K9C6bDcoMKgre6lJAIHAElxe79MRzOTXqRTMtkTg1qhh5PAWqBuJRt9rpDM8fbYxHieyW8JiStxmRn6qqmTgnT5RW/JugH+PFDAomp9tlY+BGHeqY5aBvLl13GuF8UshT/0CQATWCdAKYEaBbsTF46QzN2A/60Z5Yamq3+l5ureMbRDfWvRM7xF1w0djv0IT2z1Q56JRkFNfXx6FIF1I1gRQ6Sa2KYmm4Hwh/biDvigXWS/BaKNNzsEUZknoxokZ8d7tbld9kuUFTAd1wbqP9oDlxsVKSv1zb0sK4yvRlKOSsm1yY0ms48gomYU5+MRVCkewZMPlakvJlHoq3k6IMvzmf32yElV6Nh94ZZNVogMuXnFk2FbNik+Xg27Nzjg3fDH7UEIXIAOceM9CrC6ZN5q7NmugNPCObAT0De4j6Nshqw2HWyjhNSzwiSDRzTQ96K4AS8DSOru9xhJtnB05UbFaSPYUqyYLacmTvXfffMRdKXgH/dsRPhJEffBvwfGN0s0ErMr7rt5uVuSaVTzacMZs8TcjUv76/BLmQdFhhs2tp6INKJCzQgHyRw8vbD4+Nr
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(39860400002)(376002)(136003)(346002)(396003)(451199015)(46966006)(36840700001)(40470700004)(36860700001)(83380400001)(86362001)(82740400003)(356005)(81166007)(8936002)(2906002)(4326008)(40480700001)(82310400005)(8676002)(40460700003)(41300700001)(5660300002)(26005)(70206006)(7696005)(6666004)(186003)(336012)(2616005)(426003)(316002)(70586007)(6916009)(54906003)(1076003)(47076005)(478600001)(36756003)(43062005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2022 16:59:14.4369 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b1019bf2-5c88-4ff4-c342-08dac9863909
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT037.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5752
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
Cc: stylon.wang@amd.com, brichang <Brian.Chang@amd.com>, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 roman.li@amd.com, solomon.chiu@amd.com,
 Daniel Wheeler <daniel.wheeler@amd.com>, Aurabindo.Pillai@amd.com,
 wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com,
 pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This DC patchset brings improvements in multiple areas. In summary, we highlight:

*Add configuration 2 for ABM 2.3/2.4.
*Add margin for HUBP for SubVp + DRR.
*Fix no display after resume from WB/CB.
*Limit HW cursor size to be less than 64 x 64 bytes when the stream is >= 4K.
*Lower watermarks for enter/enter+exit latency.
*Update support types for DCN314 to include z8 only and z8_z10 only state.
*Add new value for soc bounding box and dummy pstate.
*Override fclk chang latency when calculating prefetch schedule for subvp with low uclk.
*Add check for DET fetch latency for dcn32.
*Add check if PSR enabled when entering MALL.
*Use base MALL allocation size calculations off vewport height.
*Add YCBCR2020 to CSC matrix.
*Implement DP-Tx portion to interact with DPIA.
*Add debug option for increasing phantom lines.
*Fix phantom plane/stream retain after fail validation.
*Fix display corruption with VSR enable.
*Set valid divider value for virtual and FRL/DP2.
*Add new num clk levels struct for max mclk index.
*Fix check for phantom BPP.

Cc: Daniel Wheeler <daniel.wheeler@amd.com>

Alvin Lee (5):
  drm/amd/display: Limit HW cursor size of >= 4k
  drm/amd/display: Check if PSR enabled when entering MALL
  drm/amd/display: Add debug options for increasing phantom lines
  drm/amd/display: Retain phantom plane/stream if validation fails
  drm/amd/display: Revert check for phantom BPP

Aric Cyr (1):
  SWDEV-1 - dc: 3.2.213

Camille Cho (1):
  drm/amd/display: new ABM config 2

David Galiffi (1):
  drm/amd/display: Fix rotated cursor offset calculation

Dillon Varone (5):
  drm/amd/display: Update soc bounding box for dcn32/dcn321
  drm/amd/display: Use dummy pstate latency for subvp when needed on
    dcn32
  drm/amd/display: Add check for DET fetch latency hiding for dcn32
  drm/amd/display: Use viewport height for subvp mall allocation size
  drm/amd/display: Use new num clk levels struct for max mclk index

Ilya Bakoulin (1):
  drm/amd/display: Fix display corruption w/ VSR enable

Lee, Alvin (1):
  drm/amd/display: Add margin on DRR vblank start for subvp

Mustapha Ghaddar (1):
  drm/amd/display: Phase 1 Add Bw Allocation source and header files

Nicholas Kazlauskas (2):
  drm/amd/display: Update Z8 watermarks for DCN314
  drm/amd/display: Add Z8 allow states to z-state support list

Rodrigo Siqueira (1):
  drm/amd/display: Add YCBCR2020 coefficients to CSC matrix

Taimur Hassan (1):
  drm/amd/display: Avoid setting pixel rate divider to N/A

Tsung-hua Lin (2):
  drm/amd/display: No display after resume from WB/CB
  drm/amd/display: No display after resume from WB/CB[modify]

 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 37 ++++++++++
 .../amd/display/dc/clk_mgr/dcn31/dcn31_smu.c  |  4 +-
 .../display/dc/clk_mgr/dcn314/dcn314_smu.c    | 12 +++-
 drivers/gpu/drm/amd/display/dc/core/dc.c      | 31 +++++++-
 .../gpu/drm/amd/display/dc/core/dc_stream.c   | 16 ++++-
 drivers/gpu/drm/amd/display/dc/dc.h           |  6 +-
 drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c  |  1 +
 drivers/gpu/drm/amd/display/dc/dc_link.h      | 14 ++++
 drivers/gpu/drm/amd/display/dc/dc_stream.h    |  2 +-
 .../display/dc/dce110/dce110_hw_sequencer.c   |  9 ++-
 .../gpu/drm/amd/display/dc/dcn10/dcn10_dpp.c  | 34 ++++++---
 .../gpu/drm/amd/display/dc/dcn10/dcn10_hubp.c | 28 +++++---
 .../gpu/drm/amd/display/dc/dcn20/dcn20_hubp.c | 32 ++++++---
 .../drm/amd/display/dc/dcn314/dcn314_dccg.c   |  7 ++
 .../drm/amd/display/dc/dcn314/dcn314_hwseq.c  |  6 +-
 .../gpu/drm/amd/display/dc/dcn32/dcn32_dccg.c |  4 +-
 .../drm/amd/display/dc/dcn32/dcn32_hwseq.c    | 11 +--
 .../drm/amd/display/dc/dcn32/dcn32_resource.c | 27 ++++++-
 .../drm/amd/display/dc/dcn32/dcn32_resource.h |  3 +
 .../display/dc/dcn32/dcn32_resource_helpers.c |  2 +-
 .../amd/display/dc/dcn321/dcn321_resource.c   |  4 +-
 .../drm/amd/display/dc/dml/dcn20/dcn20_fpu.c  | 12 +++-
 .../amd/display/dc/dml/dcn314/dcn314_fpu.c    |  4 +-
 .../drm/amd/display/dc/dml/dcn32/dcn32_fpu.c  | 72 ++++++++++++++-----
 .../dc/dml/dcn32/display_mode_vba_32.c        | 41 ++++++++++-
 .../dc/dml/dcn32/display_mode_vba_util_32.c   | 69 ++++++++++++++++++
 .../dc/dml/dcn32/display_mode_vba_util_32.h   | 18 +++++
 .../amd/display/dc/dml/dcn321/dcn321_fpu.c    |  8 +--
 .../drm/amd/display/dc/dml/display_mode_vba.h |  2 +
 .../gpu/drm/amd/display/dc/inc/core_types.h   |  1 +
 drivers/gpu/drm/amd/display/dc/inc/hw/dpp.h   |  9 ++-
 .../drm/amd/display/dc/link/link_dp_dpia_bw.c | 28 ++++++++
 .../drm/amd/display/dc/link/link_dp_dpia_bw.h | 69 ++++++++++++++++++
 .../gpu/drm/amd/display/dmub/inc/dmub_cmd.h   |  3 +-
 .../amd/display/modules/power/power_helpers.c |  9 +++
 35 files changed, 552 insertions(+), 83 deletions(-)
 create mode 100644 drivers/gpu/drm/amd/display/dc/link/link_dp_dpia_bw.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/link/link_dp_dpia_bw.h

-- 
2.25.1

