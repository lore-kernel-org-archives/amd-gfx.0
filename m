Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CAFEC28D13
	for <amd-gfx@archiver.kernel.org>; Mon, 22 Aug 2022 13:57:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B609C8F075;
	Mon, 22 Aug 2022 13:57:21 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2081.outbound.protection.outlook.com [40.107.93.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6B3C68F047
 for <amd-gfx@lists.freedesktop.org>; Mon, 22 Aug 2022 13:57:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nJoLfKCP0dXriqmAPM8s8HkW9DYAPR/c6B8/Llgg/3DEs7nuRDgcsyGZeJX9HOOM+ncBb+bYSv3vGiLs11aOL58Wc3cWnNnK6i9rPBnDJppXhDoTEi+ylJ5I7AkS/QjOmOC5b8Qe0Q0gYjqWPQVU3cLMwGhvl5XDJGg/WAx/O0bujYiGRZzBaATVi1K1V6KLI6cqvyTG2tvmfrjGd/8GmZkXoZxgIuigptAyfU7sfnnwvdfp8YWjIl9/d/SEcY7o8J65zdYNlGYtBCPef5ZIDTehzBuL6C9+6CK2Dm2Fhb05Yo9CVAXCG8TeaAjJPZUNueAhMCutF3dAvZAfq6X1ug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fSSPuoHKqyZ2SZ7U3DdENESBc8AgVDfGs5+bqsp1fXE=;
 b=H0ntIaQkgMBznpbRUL05wKam6rcXDgyy3LT1Gp7Zks1KmU/dNEXWnxs7H6AC5pXcY8w6Le1e1zN+aBVWTrdmBthBcAjP6VI9uGrtLAlfxtoCHp1KR8L1oF8vaNBYT3WX+EDfadqXeEOPjt7Fvzk1+gJTl8CgWJRJEb3IXLRmdtlyMzL+rmM623J5dBjDE9bcsg+aNhPigvLHW3xXyv0vdVTbKYdko+HLhqINXAro3Jk9oipdtCYQeYqEJwMbLRK84j67+eokZFw+AxePfFFJkKRzvY+D46Qh1xeKtdW6sSOVL1ipDYn/UHhG3tOlTW9zv7UvtaNXxlbq9ZhB7B7acQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fSSPuoHKqyZ2SZ7U3DdENESBc8AgVDfGs5+bqsp1fXE=;
 b=v0vfAf2PV8AwmxvA9TzAULNtAYlphsYWiliksLHcY894vrYr6R5tM+6sp7p4X4lLuRPqjxlmXgrGvz7d0KUU5Nxc9jlf4MfV18ull3CLoNFB1he7zFA5hgszsC86hNmeydKSbVk4GQPtMMoWxrOQgR+mk8Miwfg/owjwXCw29uw=
Received: from DM6PR06CA0090.namprd06.prod.outlook.com (2603:10b6:5:336::23)
 by BN9PR12MB5384.namprd12.prod.outlook.com (2603:10b6:408:105::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5546.16; Mon, 22 Aug
 2022 13:57:10 +0000
Received: from DM6NAM11FT104.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:336:cafe::65) by DM6PR06CA0090.outlook.office365.com
 (2603:10b6:5:336::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5546.22 via Frontend
 Transport; Mon, 22 Aug 2022 13:57:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DM6NAM11FT104.mail.protection.outlook.com (10.13.173.232) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5546.7 via Frontend Transport; Mon, 22 Aug 2022 13:57:09 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Mon, 22 Aug
 2022 08:57:09 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Mon, 22 Aug
 2022 08:57:08 -0500
Received: from brianchang-HP-EliteDesk-805-G6-Small-Form-Factor-PC.amd.com
 (10.180.168.240) by SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP
 Server id 15.1.2375.28 via Frontend Transport; Mon, 22 Aug 2022 08:57:05
 -0500
From: brichang <Brian.Chang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 00/14]  DC Patches August 22, 2022
Date: Mon, 22 Aug 2022 17:57:38 +0800
Message-ID: <20220822095752.3750614-1-Brian.Chang@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3081208c-c877-4a87-52a4-08da84463509
X-MS-TrafficTypeDiagnostic: BN9PR12MB5384:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NmtYs2X+BpfDBH4eb1o9DxeSs/EhiEgyRAX20A7sPKcLlDfwi+V4nsA1WqmxRRZ3Q1NzfMzKmURvrq1OPlb9oivsDDc77RPN4aG0aL46PVZ0dzhp8P60lXXhqKLOSbmJvBc2yStEGqCyQSKC1t8ghyWZ0ItGTWhV4aWJ1RyuSO/SwRfvP7F9+pzKEgd5qP7vo2/ZRy7NRL9wMHeXwd/Iqvyzg4z9t9t8prS9UxONcbim/klxePyfjPzfxcfL0wVs5VdZ9SILULgqGlyF18C3n6AX/z7M8b0Q2Izel5WHeW9Xt27DsvmDJj8EmnL/oeuPCv0A90jCNniv93meMMfgsz6JNNnQGMTMZEE/YL33LwRYUTyzrSq1XSnMK3UND8gMB3Dvm6DLa4nz5T/yDAJ7cg9VpyB0kUfFoFjPks/wM7rMyWSPNVjjViilqZ31/YIH2F4FqT6w2ESV3qAHzJoUFcI1Uhp/QsvptBbYfYGB3RfNBjH8x2i6a1679fIEWX05APQDGi+XLnLt5ThAjmNO3Ch00b5UWxWV6qg+HfFocMPcYlc5zhrRLm8r1IwQrfiTOxl4H0fn4c5rZZ+SUYyL/2a2niFLtC90R+8kUQPvGaRlEkWlJVW1eR9rceSzJy24ESsvJZvgl9qufbjAZZOvgRtYrR5p3uA0KnFKzhyjLFlecrsU/W+6AhRQ1ie5xBfss+RiePEOtKnIwosscrAxexF93K7sZO9k/5PC0o7SRncWwI6VGnHIbQJFl7Gm3zxDwG1wsevdJZxbJ20CXBbvMAM83410oZthWeVuYaD0lcChJolfoG0zSWkMFLhQhkjG+r1MgkaZd8tnIZkiyFeYZg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(136003)(376002)(39860400002)(346002)(396003)(40470700004)(46966006)(36840700001)(83380400001)(336012)(1076003)(36860700001)(186003)(47076005)(2616005)(426003)(54906003)(36756003)(70206006)(70586007)(6916009)(8676002)(316002)(4326008)(2906002)(7696005)(26005)(40460700003)(5660300002)(8936002)(478600001)(41300700001)(40480700001)(82310400005)(86362001)(6666004)(82740400003)(356005)(81166007)(43062005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2022 13:57:09.7633 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3081208c-c877-4a87-52a4-08da84463509
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT104.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5384
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
 roman.li@amd.com, solomon.chiu@amd.com, Aurabindo.Pillai@amd.com,
 wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com,
 pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This DC patchset brings improvements in multiple areas. In summary, we have:

* Remove redundant check in atomic_check.
* Add log clock table for SMU.
* Add SubVP scaling.
* Add interface to track PHY state.
* Free phantom plane after removing from the context.
* Add k1/k2 driver for virtual signal for DCN32.
* Fix cursor flicker when entering PSRSU.
* Change reg offset for DCN321 and DCN32 during runtime initialization.
* Change AUX NACK behavior.
* Correct HDMI ODM combine policy.
* Fix odm 2:1 policy in 4k144 mode.
* Fix pipe split policy for RV2

Alvin Lee (2):
  drm/amd/display: Free phantom plane and stream properly
  drm/amd/display: Uncomment SubVP scaling case

Aric Cyr (1):
  drm/amd/display: 3.2.199

Aurabindo Pillai (3):
  drm/amd/display: change to runtime initialization for reg offsets for
    DCN32
  drm/amd/display: change to runtime initialization for reg offsets for
    DCN321
  drm/amd/display: program k1/k2 divider for virtual signal for DCN32

Derek Lai (1):
  drm/amd/display: do not change pipe split policy for RV2

Ilya Bakoulin (1):
  drm/amd/display: Change AUX NACK behavior

Leo Chen (1):
  drm/amd/display: Adding log clock table from SMU

Robin Chen (1):
  drm/amd/display: Cursor flicker when entering PSRSU

Roman Li (1):
  drm/amd/display: Remove redundant check in atomic_check

Saaem Rizvi (1):
  drm/amd/display: HDMI ODM Combine Policy Correction

Samson Tam (1):
  drm/amd/display: fix odm 2:1 policy not being applied consistently in
    4k144 modes

Taimur Hassan (1):
  drm/amd/display: Add interface to track PHY state

 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |   3 -
 .../display/dc/clk_mgr/dcn31/dcn31_clk_mgr.c  |  46 +
 .../dc/clk_mgr/dcn314/dcn314_clk_mgr.c        |  48 +
 .../dc/clk_mgr/dcn315/dcn315_clk_mgr.c        |  46 +
 drivers/gpu/drm/amd/display/dc/core/dc.c      |  27 +-
 .../gpu/drm/amd/display/dc/core/dc_link_dp.c  |  12 +-
 .../gpu/drm/amd/display/dc/core/dc_resource.c |   3 -
 drivers/gpu/drm/amd/display/dc/dc.h           |   3 +-
 drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c  |   5 +-
 drivers/gpu/drm/amd/display/dc/dc_link.h      |   1 +
 drivers/gpu/drm/amd/display/dc/dc_stream.h    |   2 -
 drivers/gpu/drm/amd/display/dc/dce/dce_aux.c  |  12 +-
 .../display/dc/dce110/dce110_hw_sequencer.c   |   8 +-
 .../amd/display/dc/dcn10/dcn10_hw_sequencer.c |   3 +
 .../drm/amd/display/dc/dcn10/dcn10_resource.c |  18 +
 .../drm/amd/display/dc/dcn20/dcn20_hwseq.c    |   9 +-
 .../drm/amd/display/dc/dcn31/dcn31_hwseq.c    |   9 +-
 .../drm/amd/display/dc/dcn32/dcn32_hwseq.c    |  34 +-
 .../drm/amd/display/dc/dcn32/dcn32_hwseq.h    |   3 +
 .../gpu/drm/amd/display/dc/dcn32/dcn32_init.c |   1 +
 .../drm/amd/display/dc/dcn32/dcn32_resource.c | 658 ++++++------
 .../drm/amd/display/dc/dcn32/dcn32_resource.h | 997 ++++++++++++++++++
 .../amd/display/dc/dcn321/dcn321_resource.c   | 638 ++++++-----
 .../drm/amd/display/dc/dml/calcs/dcn_calcs.c  |  32 +-
 .../drm/amd/display/dc/dml/dcn32/dcn32_fpu.c  |   5 +
 .../gpu/drm/amd/display/dc/inc/hw/hw_shared.h |   6 +
 .../gpu/drm/amd/display/dc/inc/hw_sequencer.h |   2 +
 27 files changed, 1979 insertions(+), 652 deletions(-)

-- 
2.25.1

