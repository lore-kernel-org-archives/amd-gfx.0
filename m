Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74DBAC47073
	for <amd-gfx@archiver.kernel.org>; Thu,  4 Jan 2024 15:53:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0B01110E4AF;
	Thu,  4 Jan 2024 15:53:18 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3271D10E4AF
 for <amd-gfx@lists.freedesktop.org>; Thu,  4 Jan 2024 15:53:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MPDGZWYiu6K9/IJQO4fOJM2VEpVFY2lcZ+kCskanmoM8xZkE6MB2/FUNbTx0fZ7XVK3LHORuKub8rbpa+NntdAnUND4E0q+1cfzOlUcs5NYhStY/kjO/Hu6pZ53zhNSpIqOuFPb1lPGH8+oURE4WQP0oz+smkWJReeA4peUOf47glS4ZEEgQ161+HIL7jKt5lemvCUPNNVoZTqbR/0RCytNZ1hKwcUVkzCiHLNWrhayoAKgWt4gy/mOqw0tQEPhhat6lO8WC/l4al4r775rGezgCXrFg1Z8U+tE6f+U2qjy5VTlyidBSX429Gft0j9+tS6BIuq5ZzalbBrAMWJ4xlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YKsi2qHW+0hWIJs/OysiwFLOaiIAIlytdbWm7ecNn6M=;
 b=icnwC9NB/WEq5B59QzjjtjGplhD1JgzV7EAM2B07ZDZ5DQwqLSddRI/pNmDEWY1C8nsLKRZclo6JgkoA1GUtTcrCldhfjMxS2jNWbxLFj2eKwN12yHpZ+6wQyuuZI2umx7bmub2IPNjRUFxLQYJZtqVG40MJKIW4epjvcMAtfFTGcuI6/FsqpJJaJXSuxMVCkl7lg6bN4I2h+Ltt3BXHBGG1F2kxeAqrKushqJrRKNryvIJG98N8JfZtHiYFnPfowCS5QRSXN41cJ5aNY89rpg9HhCu4uhtrC8ZZSv8ogxwpPd7qNmaN9094X8T++2M7mn+rs2PwUpBvy5UExJoKqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YKsi2qHW+0hWIJs/OysiwFLOaiIAIlytdbWm7ecNn6M=;
 b=LIX6d3Bk9zSAuZkmW29jMcy9GlCqbW+sFGK1o7rZ2yeupgPH2anL3HBItzv2Jx8hPqElP+HWXCj3JgXOvFy0ihSAiVTt702mi7MBRt5HneOFu+sxCszDzsqIBVkZmSkiAYiZXjlfAqEqxRTzgSMxx2XzccsI0w+qnSMKpE0nqy8=
Received: from PH0P220CA0009.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:d3::13)
 by BL1PR12MB5142.namprd12.prod.outlook.com (2603:10b6:208:312::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.13; Thu, 4 Jan
 2024 15:53:13 +0000
Received: from SA2PEPF000015CC.namprd03.prod.outlook.com
 (2603:10b6:510:d3:cafe::a3) by PH0P220CA0009.outlook.office365.com
 (2603:10b6:510:d3::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.13 via Frontend
 Transport; Thu, 4 Jan 2024 15:53:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF000015CC.mail.protection.outlook.com (10.167.241.202) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7159.9 via Frontend Transport; Thu, 4 Jan 2024 15:53:12 +0000
Received: from smtp.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Thu, 4 Jan
 2024 09:53:09 -0600
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 00/10] DC Patches Jan 04, 2024
Date: Thu, 4 Jan 2024 08:50:56 -0700
Message-ID: <20240104155238.454117-1-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF000015CC:EE_|BL1PR12MB5142:EE_
X-MS-Office365-Filtering-Correlation-Id: 20daca20-b5f7-417e-ddd6-08dc0d3d4207
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: J/NAbiyot7K+Z58PFcMUmX4RDtLsXQq77DpSHI01sg7vS0pTpob54VRigaSk+O1xLATNX8lvg3SwoXsRJYxyy88ny5CbUsCaMHPNvzs1u7V7vkx3KiZUi0xSK58IRgrQOlG8c1WctWpgjysHZ2T7oUXDi+0dZhVgxFqpt5Pae+Mv4DyahY9gV9QP+/9oj5g9ikzJHmHf86x6pphwcBUjqBiVc33BNnH/1+FmD3+iMvmL0pH8EkxClSYdpljTNkMtGRb3cGtkodBxDJhyychpWnvuF3uhbxgTuBBfcsmbTo/ygF+M4B266kNLUQAtB9aq6Nlb1S9uwH8mH6l7BPNhsSWWKiBTffLQ/ppWbSrYfQqAc5EeObDea79XeUQp9e+/HbJpUdETPaa3ItqxQlWP2U+wzTpL8GtkFddyGhjLP5lKe57ndoJVEmUgxB1LF0iHykIGqKkU5d1nVlS1hiDJCToQb+eJ1eaKM8TWZAjGs7lJbHN1pJTNe+BFka3BAGQdWE1CZoWDJ6XR4JwnqWHoSfy6lAFiEX6b6wflWRoc3LaEBa7p0Q2BTD9ErJYDhid6G7avgvU1gFWxt0mL4s2XSPMw+4LHXW4R3fLGo3FRnEgTB6iSzFew1Sckm/aDW6E7jwzeHJDNaeZVz7K/EreCAcXaqxW1Fb97L0A79jWbzIO9zBtvtBmCo4/ouhp0LZp7KD8q0moHYaCCoCsK+4pAvNT18Y0vX8fGKU2whWYejYGYYnbg3uTjoJjii0wueUjJcxY3Psl9Yg6XbBVEOZKV2w==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(346002)(376002)(396003)(39860400002)(136003)(230922051799003)(64100799003)(186009)(451199024)(1800799012)(82310400011)(40470700004)(46966006)(36840700001)(316002)(54906003)(478600001)(6916009)(6666004)(8676002)(8936002)(70206006)(70586007)(47076005)(41300700001)(36860700001)(1076003)(26005)(83380400001)(426003)(16526019)(336012)(5660300002)(4326008)(2906002)(36756003)(82740400003)(81166007)(356005)(86362001)(2616005)(40480700001)(40460700003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jan 2024 15:53:12.9089 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 20daca20-b5f7-417e-ddd6-08dc0d3d4207
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF000015CC.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5142
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
Cc: stylon.wang@amd.com, jerry.zuo@amd.com, Sunpeng.Li@amd.com,
 Rodrigo.Siqueira@amd.com, roman.li@amd.com, solomon.chiu@amd.com,
 Daniel Wheeler <daniel.wheeler@amd.com>, Aurabindo.Pillai@amd.com,
 hamza.mahfooz@amd.com, wayne.lin@amd.com, Harry.Wentland@amd.com,
 agustin.gutierrez@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This DC patchset brings improvements in multiple areas. In summary, we
have:

- Improve z8/z10 support
- Revert some of the VRR optimization
- Improve usb4 when using MST

Thanks
Siqueira

Cc: Daniel Wheeler <daniel.wheeler@amd.com>

Aric Cyr (1):
  drm/amd/display: 3.2.266

Charlene Liu (2):
  drm/amd/display: allow z8/z10 from driver
  drm/amd/display: Update z8 latency

Daniel Miess (1):
  Revert "drm/amd/display: Fix conversions between bytes and KB"

George Shen (1):
  drm/amd/display: Disconnect phantom pipe OPP from OPTC being disabled

Martin Leung (2):
  drm/amd/display: revert "for FPO & SubVP/DRR config program vmin/max"
  drm/amd/display: revert "Optimize VRR updates to only necessary ones"

Martin Tsai (1):
  drm/amd/display: To adjust dprefclk by down spread percentage

Meenakshikumar Somasundaram (1):
  drm/amd/display: Dpia hpd status not in sync after S4

Peichen Huang (1):
  drm/amd/display: Request usb4 bw for mst streams

 .../dc/clk_mgr/dcn314/dcn314_clk_mgr.c        | 71 ++++++++++++++++++-
 .../dc/clk_mgr/dcn314/dcn314_clk_mgr.h        | 11 +++
 drivers/gpu/drm/amd/display/dc/core/dc.c      | 14 ++--
 .../gpu/drm/amd/display/dc/core/dc_resource.c | 14 ----
 drivers/gpu/drm/amd/display/dc/dc.h           |  3 +-
 drivers/gpu/drm/amd/display/dc/dc_stream.h    |  2 +
 drivers/gpu/drm/amd/display/dc/dc_types.h     | 12 ++--
 .../gpu/drm/amd/display/dc/dce/dce_audio.c    |  2 +-
 .../drm/amd/display/dc/dce/dce_clock_source.c |  9 ++-
 .../display/dc/dcn32/dcn32_resource_helpers.c | 14 ++++
 .../drm/amd/display/dc/dml/dcn32/dcn32_fpu.c  | 11 ++-
 .../drm/amd/display/dc/dml/dcn35/dcn35_fpu.c  |  6 +-
 .../amd/display/dc/dml2/display_mode_core.c   | 18 ++---
 .../drm/amd/display/dc/dml2/dml2_wrapper.c    |  2 +
 .../amd/display/dc/hwss/dce110/dce110_hwseq.c |  2 +-
 .../amd/display/dc/hwss/dcn10/dcn10_hwseq.c   |  2 +-
 .../amd/display/dc/hwss/dcn20/dcn20_hwseq.c   | 45 ++----------
 .../gpu/drm/amd/display/dc/inc/hw/clk_mgr.h   |  1 +
 drivers/gpu/drm/amd/display/dc/inc/resource.h |  3 -
 .../gpu/drm/amd/display/dc/link/link_dpms.c   | 42 ++++++++---
 .../drm/amd/display/dc/link/link_validation.c | 60 +++++++++++++---
 .../display/dc/link/protocols/link_dp_dpia.c  | 36 ++++++----
 .../dc/link/protocols/link_dp_dpia_bw.c       | 59 +++++++++++----
 .../dc/link/protocols/link_dp_dpia_bw.h       |  9 +++
 .../amd/display/dc/optc/dcn32/dcn32_optc.c    | 19 +++--
 .../amd/display/dc/optc/dcn35/dcn35_optc.c    | 12 ++--
 .../dc/resource/dcn32/dcn32_resource.c        |  2 +-
 .../dc/resource/dcn32/dcn32_resource.h        |  3 +
 .../dc/resource/dcn321/dcn321_resource.c      |  2 +-
 .../gpu/drm/amd/display/include/audio_types.h |  2 +-
 30 files changed, 334 insertions(+), 154 deletions(-)

-- 
2.43.0

