Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFF35C433EF
	for <amd-gfx@archiver.kernel.org>; Fri,  8 Jul 2022 16:36:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2279510E1BB;
	Fri,  8 Jul 2022 16:36:10 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2056.outbound.protection.outlook.com [40.107.223.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D30CF10E1BB
 for <amd-gfx@lists.freedesktop.org>; Fri,  8 Jul 2022 16:36:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DqysgUqSYVv03RumwsZs+Lk/3WSYD0vjCyRbVheCaKBa+NkF1kJZQSNg/ZCUT5v10tRfmXJOJtvXWLSIrs4uacv5yT6kYBoThFNEU7XKCfA0ymcXVP/cJ6tJwRvV58mZRDCVZHVpiUdgmrei2blMRH0vyjxDN/xWdbJ1A6UJO3ywkic9zTsOCK4bBQQFz8Gx1HVko2/+Z2c7CwQ/DXUODkZM1Aiz0kt1TSLkkAOIBpln/dlne45aA4iJrrPMW2TD/w9wpAH6Hr8BgebXiAYa9TAOSrGN/7nIXV5YUuFnNp8IlQyJtk0GGzryCrY1EmA2Kz0Dt2NXHgD8scUYj91tMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wKpp28Epgt1TzMUYJPCH1WR6zhfJyNoEB3GvhEF7Q+4=;
 b=NOq3KpU3II3r+mO2Y/+ICUm1AVcBvnxTW9dJU1t1yoJtQBlr7fdXw54LHfHOsAdDoyk6H3VUwl4Wkqm9R1E+6bWuvoG8j+o2QQaDdJUyL/ayVWGCHsLVBhk1TnHvgDJDTBBSSb9LPWKg4TwiAFVYTRKs+sUhnxIq2yWWHRhmgIuF+4V9f61ILWsplJ88+bMsEwoYFHMLmoiO1jrN913R1biiCmuG43appyQbSA+k1dtnDmdOqCBAgdWMWK8RA5Om4tG2l0hlldPx/Sd715lA2JZcgu4KwK+pnsQh+TbGCgrAW9+AGUY2mW1taVbJYhI7EWCZlPoC4RXKWueZ6zPfCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wKpp28Epgt1TzMUYJPCH1WR6zhfJyNoEB3GvhEF7Q+4=;
 b=v7T/ojkEThcO4HQNeu/U5m5Im/3c+Hz1crQlnvLaXwZUefLsgIl3y+kXiiW7iddSRteDG38zmBvhlZbqNhCOdlCxat8iJeT5j0czp6PyIf3Hin/VfwZ3pJ2tnT7dJbpLfzDMUI3KUOE19IjZDK4akz1Qp5PkYSEArOCCCo0WOmE=
Received: from MW4PR03CA0289.namprd03.prod.outlook.com (2603:10b6:303:b5::24)
 by DM6PR12MB2700.namprd12.prod.outlook.com (2603:10b6:5:4d::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.18; Fri, 8 Jul
 2022 16:36:06 +0000
Received: from CO1NAM11FT053.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b5:cafe::40) by MW4PR03CA0289.outlook.office365.com
 (2603:10b6:303:b5::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.19 via Frontend
 Transport; Fri, 8 Jul 2022 16:36:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT053.mail.protection.outlook.com (10.13.175.63) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5417.15 via Frontend Transport; Fri, 8 Jul 2022 16:36:05 +0000
Received: from ryzen32.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Fri, 8 Jul
 2022 11:36:00 -0500
From: Solomon Chiu <solomon.chiu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 00/21] DC Patches July 11, 2022
Date: Sat, 9 Jul 2022 00:35:08 +0800
Message-ID: <20220708163529.3534276-1-solomon.chiu@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8d86a554-4bd4-4432-f9cc-08da60fff425
X-MS-TrafficTypeDiagnostic: DM6PR12MB2700:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5J1C02+JGcvHW+0nI48133AvbSd5NmG6QI8H6RSBc9a9qHxE1j94iLUs1rbb7Zm7UY1BnGuv56OVkSS1v7VR70P69rYqWUiIHXtRShzUcv2CdsDznLLDO3zqc9UKWuMrSxjAaNx6AQEAqYJlYWYtCT55GTQu+lvPAPXUQjSxV39SDpMzICdWnIFO02+ZTX4xxsunt/dcKDMbOmi69T5IPSJrqjX9AfcGUrDd6AGToPYAzxptQHhxANUp8c212I3BvbbwJl3cOuy8SxXQ4OTRQMFBxHwDuyKIuTKEQu0g50OeP9PeyJH3Es1SG/pYxb+EMLSqD68wZquvKIAYanII5NlaoWKfgQvXAKY1zXhcWpfmO7FF/JNveae+GqeLHZKDC7TJnS0a7P8pd+Hfbh6WwazhfbJBO5COdMescVz/zdTFs46xcNcMOenogxfiOU8cjjTLvucQYZ8okECcaj32SxmQ/OhZpel5buQiHTvYVY7UkttXqeYxK0tMNS6hDO0lpcswlsANcRtS9VjUwDJxkeXaYWpsgs0OLOEGYoUgWJZF0/o5YG8QLalixS+cYk4Ejn+Ijxl6QuBVhGfek/GabQ564lEiRxVB4/sUtMRhtpU0s52+zck3RD79XzRhS6D6gHkdqPeK6rivVjQJ7iO90EbQrdBBO4dcRKt3tgO8Ln61yqQFTj4CjjHYSB32nALE82zGQOdKGZUllQFoHGJ6B73sXzQVUHLu0XvGlSvCwoTuVKe5Uu4l/Wjh1q688mzopX7XhHqUugmVia4E7RIJG/BQ4WyngItEhf1rU0WSS3DKGuHH5qhIDRvvYiywKHTBtdzop/+Z3J8pihgUHxKtIoQRcFXAI3qzPZXyngIbCqCL2LK43mTenTqSd34FHoGm
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(396003)(346002)(376002)(39860400002)(136003)(40470700004)(46966006)(36840700001)(81166007)(16526019)(5660300002)(47076005)(186003)(356005)(82310400005)(36860700001)(86362001)(83380400001)(34020700004)(426003)(8936002)(2616005)(44832011)(41300700001)(1076003)(7696005)(6916009)(316002)(336012)(8676002)(478600001)(36756003)(4326008)(26005)(2906002)(40480700001)(70206006)(54906003)(40460700003)(70586007)(82740400003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2022 16:36:05.3528 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d86a554-4bd4-4432-f9cc-08da60fff425
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT053.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2700
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
 solomon.chiu@amd.com, Aurabindo.Pillai@amd.com, wayne.lin@amd.com,
 Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This DC patchset brings improvements in multiple areas. In summary, we highlight:
 
- Fixes for MST, MPO, PSRSU, DP 2.0, Freesync and others
- Add register offsets of NBI and DCN.
- Improvement of ALPM
- Removing assert statement for Linux DM
- Re-implementing ARGB16161616 pixel format


Aric Cyr (2):
  drm/amd/display: 3.2.193
  drm/amd/display: 3.2.194

Aurabindo Pillai (1):
  drm/amd/display: Add NBIO reg offsets to DC

Charlene Liu (1):
  drm/amd/display: add system info table log

Chris Park (1):
  drm/amd/display: Reduce SCDC Status Flags Definition

Fangzhi Zuo (1):
  drm/amd/display: Ignore First MST Sideband Message Return Error

Harry Wentland (1):
  drm/amd/display: Add DCN reg offsets to DC

Ilya Bakoulin (1):
  drm/amd/display: Fix black screen when disabling Freesync in OSD

Lee, Alvin (1):
  drm/amd/display: Exit SubVP if MPO in use

Lei, Jun (1):
  drm/amd/display: update DML1 logic for unbounded req handling

Robin Chen (1):
  drm/amd/display: Disable PSRSU when DSC enabled on the specific sink

Rodrigo Siqueira (1):
  drm/amd/display: Fix wrong reference

Saaem Rizvi (1):
  drm/amd/display: Removing assert statements for Linux

Samson Tam (2):
  drm/amd/display: Fix windowed MPO video with ODM combine for DCN32
  drm/amd/display: Fix lag when moving windowed MPO across display using
    ODM 2:1 combine

Wayne Lin (2):
  drm/amd/display: Clear edid when unplug mst connector
  drm/amd/display: Grab dc_lock before detecting link

Wellenreiter, Ethan (1):
  drm/amd/display: Re-implementing ARGB16161616 pixel format as 22

Wenjing Liu (1):
  drm/amd/display: make enable link independent from verified link caps

Wesley Chalmers (1):
  drm/amd/display: Check for DP2.0 when checking ODM combine

muansari (1):
  drm/amd/display: Helper function for ALPM initialization

 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 115 +++++++++----
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h |   8 +
 .../amd/display/amdgpu_dm/amdgpu_dm_debugfs.c |  11 +-
 .../display/amdgpu_dm/amdgpu_dm_mst_types.c   |  19 +++
 .../drm/amd/display/dc/bios/bios_parser2.c    |  30 ++++
 .../dc/clk_mgr/dcn21/rn_clk_mgr_vbios_smu.c   |   8 +-
 .../display/dc/clk_mgr/dcn301/dcn301_smu.c    |   7 +-
 .../amd/display/dc/clk_mgr/dcn31/dcn31_smu.c  |   8 +-
 .../display/dc/clk_mgr/dcn315/dcn315_smu.c    |   8 +-
 .../display/dc/clk_mgr/dcn316/dcn316_smu.c    |   8 +-
 drivers/gpu/drm/amd/display/dc/core/dc.c      | 136 ++++++++++++++-
 .../gpu/drm/amd/display/dc/core/dc_debug.c    |   2 +
 drivers/gpu/drm/amd/display/dc/core/dc_link.c |  54 +++---
 .../gpu/drm/amd/display/dc/core/dc_link_ddc.c |   7 +-
 .../gpu/drm/amd/display/dc/core/dc_link_dp.c  |  45 ++---
 .../gpu/drm/amd/display/dc/core/dc_resource.c | 157 ++++++++++++++----
 drivers/gpu/drm/amd/display/dc/dc.h           |  16 +-
 drivers/gpu/drm/amd/display/dc/dc_link.h      |   2 +
 drivers/gpu/drm/amd/display/dc/dc_types.h     |   3 +-
 .../gpu/drm/amd/display/dc/dcn10/dcn10_dpp.c  |   2 +
 .../gpu/drm/amd/display/dc/dcn10/dcn10_hubp.c |   3 +
 .../amd/display/dc/dcn10/dcn10_hw_sequencer.c |   4 +-
 .../gpu/drm/amd/display/dc/dcn20/dcn20_dpp.c  |   2 +
 .../gpu/drm/amd/display/dc/dcn20/dcn20_hubp.c |   3 +
 .../drm/amd/display/dc/dcn20/dcn20_hwseq.c    |  72 +++++++-
 .../gpu/drm/amd/display/dc/dcn30/dcn30_dpp.c  |   2 +
 .../dc/dml/dcn31/display_mode_vba_31.c        |   1 +
 .../drm/amd/display/dc/dml/display_mode_vba.c |   9 +
 .../drm/amd/display/dc/dml/display_mode_vba.h |   9 +
 .../gpu/drm/amd/display/dc/inc/core_status.h  |   1 +
 .../gpu/drm/amd/display/dc/inc/core_types.h   |  37 +++++
 .../gpu/drm/amd/display/dc/inc/dc_link_dp.h   |   2 +-
 .../amd/display/modules/power/power_helpers.c |  33 ++--
 33 files changed, 660 insertions(+), 164 deletions(-)

-- 
2.25.1

