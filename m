Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43326C77B75
	for <amd-gfx@archiver.kernel.org>; Wed, 17 May 2023 11:37:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AE73E10E3EC;
	Wed, 17 May 2023 11:37:57 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2052.outbound.protection.outlook.com [40.107.100.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 934B210E3EC
 for <amd-gfx@lists.freedesktop.org>; Wed, 17 May 2023 11:37:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gl9QlvG7S1ZuFRF6X8HIDIJc0zUKMNKwBxwjxJdyyOzW/tjW5pqgKNqN7dwJwZlP1idZokFyx/HTZKG24AR3RWXsxxVN8BijXIItJFl9B0AfMgQnk0inybxlPpKntqygnX/2TowQkipwwQSHvrdrqIJlqT2agr6CIIPP1WRMwiW9l8F9Mo2JsrVg93uS6P8lJlhRzvyzTUVfS0L1ECWR7T3R7D3fd0mpAiy+lek0toNZJLam5gjgnKDo2HuOjqvNuhkV5jI58Rfp17SU18ocj1UFBXm37jXSCgfq8/vhpnGJk1arBiMeihinZTOCU+TTEMYa22cvRE36OPCB7NAKAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VDo/zOH1Rardv/snJttINFd+FGZUT/BiefQUKh3HUuw=;
 b=RviiVZC8IZla1iK8VtrJfhd4ncI0GIppJNNmKxcSHwI4qRUwlQWkmR0l2/x/eUVRBiKfhb6jFuicqV/fherw7rn8Zim4YjzMhGOKoKarLO3hltoa3zXDaf0zWs+/+juZ4w0s26ydvFZ9qTWCTPnjatFvP9WmcO+OxisfYLV3as9EUGVkZKt8pt6Jv88WYV4FGxMHmNSDVadEMhxaQ4a0aYKK/CV+ulxxFORDlyYFhu8LxG9Wi/LEO9h5NXB5w8Dkz1uEAEnCSSnYG6fdcJRepKzzXF2/JtrcdmSLm5hdmvHRzGPLXGgFcd1OJZelWTlL1ZWk/VEiGlDoUePx3V2J4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VDo/zOH1Rardv/snJttINFd+FGZUT/BiefQUKh3HUuw=;
 b=cApNMQC+cWNGcyy8aGJXMn/DVk9Lo4ZZH+bIABQ3xnt++NUu/7zzMfRQwzWttakTjkHLBgtbbB1wN0xCJ1GogshBXl5zWgkeRnFqUqdyt2XNxgj4yOrNuYXKucV0gp0RoaUItpTgjZXNNLTtEcZ/yFfCJRbK1SA2BpNyXjpI1qs=
Received: from MW4PR04CA0295.namprd04.prod.outlook.com (2603:10b6:303:89::30)
 by PH8PR12MB6915.namprd12.prod.outlook.com (2603:10b6:510:1bc::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.17; Wed, 17 May
 2023 11:37:51 +0000
Received: from CO1NAM11FT016.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:89:cafe::c) by MW4PR04CA0295.outlook.office365.com
 (2603:10b6:303:89::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.18 via Frontend
 Transport; Wed, 17 May 2023 11:37:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT016.mail.protection.outlook.com (10.13.175.141) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6411.17 via Frontend Transport; Wed, 17 May 2023 11:37:51 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 17 May
 2023 06:37:50 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 17 May
 2023 04:37:49 -0700
Received: from tom-HP.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.34 via Frontend
 Transport; Wed, 17 May 2023 06:37:45 -0500
From: Tom Chung <chiahsuan.chung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 00/18] DC Patches May 19 2023
Date: Wed, 17 May 2023 19:37:05 +0800
Message-ID: <20230517113723.1757259-1-chiahsuan.chung@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT016:EE_|PH8PR12MB6915:EE_
X-MS-Office365-Filtering-Correlation-Id: c809af55-43a0-4f73-7ee3-08db56cb2599
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GxMDoW+oCTBvwQK0kZG3VxEvmJTjz0mZxcd/3yMjDxlP4SLYXUFy2L4AOH8XXr/Kr9DW50wNLH2jFf2wGrCXQxVbo7BGcK3RXerb4kWquE1QfiwDc750M0tjQPRfH2qanObqIqrRsuvkDaGqNSL/bNO10I8AQWOFg9h7lDqEYO/OjFiGEdANO6KvbUXL23eZy4ktrqcP9ieESgb6CNnf26Mk5FoiDIIiRpsMsc+zqgkRfgg4kko1C0k65Ac+NMXexeTpxoJJMhi/GEGUTP6Ddr9n+hXZhxSkjas+d7TfMA+cHoDVzA/S+SdWPNVjQGVbxCaXnSMaCPVaYc4GQswNjLf+Y/r0j/PL/a7LXCC37CCX101ZSGtdASvITUnPOTF9Q4Qs3/UqJRFtxxIBUAs7qPYUjUnhCovbs7WXWKunXyQctjZIJmH4dMANNL4Rdjqsi5h9NiQeD+glSm6nGyB0o/9GNrJaFTVj4LPL2ZQIcFk+vItgskeP0u2RDEzdLRv3JnrRyKUQHM8PMJ7wnTPURa5v7+CoJkokeAcSnyh74SQjeXMLynnbAj4UyAhA7Jis6H41c4aDMDMOMoGxV5XXO7TL298zUS0WIVeydLnevA8YvVB3WFiFcFudD8Rf8LG2A5BB5rsXPDNye4u93lkHyUCsIbrnTpEq9bmMBJ2I/ZM94xz8yYLUrNNIeR11902vvix5xcsZ0sxm6zMcGVrapK/EmpoPgiVEm/ZYAlEbq0+1q/Kd9kshPUWtn4UVoR3wuTMhAOSWxxJGBIfgABH5Sw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(396003)(39860400002)(136003)(346002)(451199021)(40470700004)(46966006)(36840700001)(82310400005)(1076003)(2906002)(186003)(40460700003)(86362001)(26005)(83380400001)(40480700001)(2616005)(336012)(426003)(36860700001)(36756003)(47076005)(81166007)(356005)(82740400003)(6666004)(41300700001)(7696005)(4326008)(6916009)(70586007)(70206006)(316002)(54906003)(478600001)(5660300002)(8676002)(8936002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 May 2023 11:37:51.0817 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c809af55-43a0-4f73-7ee3-08db56cb2599
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT016.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6915
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
Cc: stylon.wang@amd.com, Tom Chung <chiahsuan.chung@amd.com>,
 Sunpeng.Li@amd.com, Harry.Wentland@amd.com, qingqing.zhuo@amd.com,
 Rodrigo.Siqueira@amd.com, roman.li@amd.com, solomon.chiu@amd.com,
 Daniel Wheeler <daniel.wheeler@amd.com>, Aurabindo.Pillai@amd.com,
 wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com,
 pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This DC patchset brings improvements in multiple areas. In summary, we have:

- Improve the message printed
- Disable dcn315 pixel rate crb when scaling
- Update SR watermarks for DCN314
- Fix dcn315 pixel rate crb scaling check
- Reset CRTC State Before Restore from S2idle
- Have Payload Properly Created After Resume
- Trigger DIO FIFO resync on commit streams
- Revert vblank change that causes null pointer crash
- Fix possible underflow for displays with large vblank
- Apply 60us prefetch for DCFCLK <= 300Mhz
- Update correct DCN314 register header

Cc: Daniel Wheeler <daniel.wheeler@amd.com>

Alan Liu (1):
  drm/amd/display: Fix warning in disabling vblank irq

Alvin Lee (1):
  drm/amd/display: Apply 60us prefetch for DCFCLK <= 300Mhz

Aric Cyr (1):
  drm/amd/display: 3.2.237

Aurabindo Pillai (1):
  drm/amd/display: improve the message printed when loading DC

Cruise Hung (2):
  drm/amd/display: Fix DMUB debugging print issue
  drm/amd/display: Update correct DCN314 register header

Daniel Miess (2):
  drm/amd/display: Revert vblank change that causes null pointer crash
  drm/amd/display: Fix possible underflow for displays with large vblank

Dmytro Laktyushkin (2):
  drm/amd/display: disable dcn315 pixel rate crb when scaling
  drm/amd/display: fix dcn315 pixel rate crb scaling check

Fangzhi Zuo (1):
  drm/amd/display: Have Payload Properly Created After Resume

Hersen Wu (1):
  drm/amd/display: lower dp link training message level

Josip Pavic (1):
  drm/amd/display: cache trace buffer size

Nicholas Kazlauskas (1):
  drm/amd/display: Update SR watermarks for DCN314

Qingqing Zhuo (1):
  drm/amd/display: Clean FPGA code in dc

Rodrigo Siqueira (1):
  drm/amd/display: Reorganize DCN30 Makefile

Saaem Rizvi (2):
  drm/amd/display: Trigger DIO FIFO resync on commit streams
  drm/amd/display: Trigger DIO FIFO resync on commit streams for DCN32

 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |  30 +++--
 .../amd/display/amdgpu_dm/amdgpu_dm_crtc.c    |  16 +--
 .../dc/clk_mgr/dce112/dce112_clk_mgr.c        |   8 +-
 .../dc/clk_mgr/dcn10/rv1_clk_mgr_vbios_smu.c  |   2 -
 .../display/dc/clk_mgr/dcn20/dcn20_clk_mgr.c  |  22 ++--
 .../dc/clk_mgr/dcn201/dcn201_clk_mgr.c        |   6 -
 .../amd/display/dc/clk_mgr/dcn21/rn_clk_mgr.c |  13 +--
 .../dc/clk_mgr/dcn21/rn_clk_mgr_vbios_smu.c   |   5 -
 .../display/dc/clk_mgr/dcn30/dcn30_clk_mgr.c  |  10 +-
 .../display/dc/clk_mgr/dcn301/vg_clk_mgr.c    |  18 +--
 .../display/dc/clk_mgr/dcn31/dcn31_clk_mgr.c  |  10 +-
 .../dc/clk_mgr/dcn314/dcn314_clk_mgr.c        |  26 ++---
 .../dc/clk_mgr/dcn315/dcn315_clk_mgr.c        |  10 +-
 .../dc/clk_mgr/dcn316/dcn316_clk_mgr.c        |  11 +-
 .../display/dc/clk_mgr/dcn32/dcn32_clk_mgr.c  |   1 -
 drivers/gpu/drm/amd/display/dc/core/dc.c      |  14 ++-
 .../gpu/drm/amd/display/dc/core/dc_stream.c   |  30 -----
 drivers/gpu/drm/amd/display/dc/dc.h           |   4 +-
 drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c  | 103 ++++++------------
 drivers/gpu/drm/amd/display/dc/dc_helper.c    |   4 +-
 drivers/gpu/drm/amd/display/dc/dc_types.h     |   7 --
 .../drm/amd/display/dc/dce/dce_clock_source.c |  38 -------
 drivers/gpu/drm/amd/display/dc/dce/dce_dmcu.c |   2 -
 .../display/dc/dce110/dce110_hw_sequencer.c   |   6 +-
 .../display/dc/dce112/dce112_hw_sequencer.c   |   3 -
 .../display/dc/dce120/dce120_hw_sequencer.c   |   3 -
 .../amd/display/dc/dcn10/dcn10_hw_sequencer.c |  36 +-----
 .../gpu/drm/amd/display/dc/dcn10/dcn10_optc.c |   2 -
 .../drm/amd/display/dc/dcn10/dcn10_resource.c |   5 +-
 .../gpu/drm/amd/display/dc/dcn20/dcn20_dccg.h |   4 +-
 .../drm/amd/display/dc/dcn20/dcn20_hwseq.c    |   5 -
 .../gpu/drm/amd/display/dc/dcn20/dcn20_init.c |   4 -
 .../gpu/drm/amd/display/dc/dcn20/dcn20_optc.c |   1 -
 .../drm/amd/display/dc/dcn20/dcn20_resource.c |  15 +--
 .../drm/amd/display/dc/dcn201/dcn201_hwseq.c  |  20 +---
 .../drm/amd/display/dc/dcn201/dcn201_optc.c   |   1 -
 .../amd/display/dc/dcn201/dcn201_resource.c   |   5 +-
 .../gpu/drm/amd/display/dc/dcn21/dcn21_init.c |   4 -
 .../drm/amd/display/dc/dcn21/dcn21_resource.c |  10 +-
 drivers/gpu/drm/amd/display/dc/dcn30/Makefile |  38 +++++--
 .../drm/amd/display/dc/dcn30/dcn30_hwseq.c    |  28 -----
 .../gpu/drm/amd/display/dc/dcn30/dcn30_init.c |   4 -
 .../gpu/drm/amd/display/dc/dcn30/dcn30_optc.c |   1 -
 .../drm/amd/display/dc/dcn30/dcn30_resource.c |   8 +-
 .../amd/display/dc/dcn301/dcn301_resource.c   |  10 +-
 .../amd/display/dc/dcn302/dcn302_resource.c   |   5 +-
 .../amd/display/dc/dcn303/dcn303_resource.c   |   5 +-
 .../drm/amd/display/dc/dcn31/dcn31_hwseq.c    |  31 +-----
 .../gpu/drm/amd/display/dc/dcn31/dcn31_init.c |   4 -
 .../drm/amd/display/dc/dcn31/dcn31_resource.c |  17 +--
 .../drm/amd/display/dc/dcn314/dcn314_dccg.c   |  11 ++
 .../drm/amd/display/dc/dcn314/dcn314_dccg.h   |   5 +-
 .../drm/amd/display/dc/dcn314/dcn314_hwseq.c  |  27 +++++
 .../drm/amd/display/dc/dcn314/dcn314_hwseq.h  |   2 +
 .../drm/amd/display/dc/dcn314/dcn314_init.c   |   5 +-
 .../amd/display/dc/dcn314/dcn314_resource.c   |  10 +-
 .../amd/display/dc/dcn315/dcn315_resource.c   |  30 ++---
 .../amd/display/dc/dcn316/dcn316_resource.c   |  17 +--
 .../gpu/drm/amd/display/dc/dcn32/dcn32_dccg.c |  21 +---
 .../gpu/drm/amd/display/dc/dcn32/dcn32_dccg.h |   5 +-
 .../drm/amd/display/dc/dcn32/dcn32_hwseq.c    |  27 +++++
 .../drm/amd/display/dc/dcn32/dcn32_hwseq.h    |   2 +
 .../gpu/drm/amd/display/dc/dcn32/dcn32_init.c |   5 +-
 .../drm/amd/display/dc/dcn32/dcn32_resource.c |  11 +-
 .../amd/display/dc/dcn321/dcn321_resource.c   |  11 +-
 .../amd/display/dc/dml/dcn301/dcn301_fpu.c    |   2 -
 .../drm/amd/display/dc/dml/dcn31/dcn31_fpu.c  |  17 +--
 .../dc/dml/dcn31/display_rq_dlg_calc_31.c     |   8 --
 .../amd/display/dc/dml/dcn314/dcn314_fpu.c    |   6 +-
 .../dc/dml/dcn314/display_rq_dlg_calc_314.c   |   8 --
 .../drm/amd/display/dc/dml/dcn32/dcn32_fpu.c  |   4 +-
 .../dc/dml/dcn32/display_mode_vba_32.c        |   4 +-
 .../dc/dml/dcn32/display_mode_vba_32.h        |   2 +-
 .../amd/display/dc/dml/dcn321/dcn321_fpu.c    |   4 -
 .../drm/amd/display/dc/dml/display_mode_lib.c |   1 -
 .../drm/amd/display/dc/dml/display_mode_lib.h |   1 -
 drivers/gpu/drm/amd/display/dc/inc/hw/dccg.h  |   3 +
 .../amd/display/dc/inc/hw_sequencer_private.h |   2 +
 .../display/dc/link/hwss/link_hwss_hpo_dp.c   |  73 -------------
 .../gpu/drm/amd/display/dc/link/link_dpms.c   |  35 ++----
 .../dc/link/protocols/link_dp_capability.c    |   3 +-
 .../dc/link/protocols/link_dp_training.c      |  17 ++-
 drivers/gpu/drm/amd/display/dmub/dmub_srv.h   |   1 +
 drivers/gpu/drm/amd/display/dmub/src/Makefile |   2 +-
 .../drm/amd/display/dmub/src/dmub_dcn314.c    |  62 +++++++++++
 .../drm/amd/display/dmub/src/dmub_dcn314.h    |  33 ++++++
 .../gpu/drm/amd/display/dmub/src/dmub_srv.c   |   7 +-
 87 files changed, 409 insertions(+), 740 deletions(-)
 create mode 100644 drivers/gpu/drm/amd/display/dmub/src/dmub_dcn314.c
 create mode 100644 drivers/gpu/drm/amd/display/dmub/src/dmub_dcn314.h

-- 
2.25.1

