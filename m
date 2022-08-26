Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C48E0ECAAD4
	for <amd-gfx@archiver.kernel.org>; Sat, 27 Aug 2022 02:26:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 05AC810EB37;
	Sat, 27 Aug 2022 02:26:53 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2063.outbound.protection.outlook.com [40.107.92.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3602B10EB37
 for <amd-gfx@lists.freedesktop.org>; Sat, 27 Aug 2022 02:26:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mrT8QkwKMGMEyB7sCXfq8LKcfMkcxu8TDQ96YSG/mOR/RTWDb6fB2EN0CrgTmEuIl+4d4ZfsVxww9iSt/JNA27jgc3xHe2GYPDIl/+xcgNlHprlf7hYITNsQU+QFPdgyQshpuE6+V/wL7M1d0FF7NRVIDsfAdDBwZD1F11bN39CzW/sCe/dU3VHrNipXNQ4y9rq+wVnoyOH7SfW24h74ojvzVn40WGksDRsg7M8ynVj1N0tdB74KhC2kp6VYts278iqG4k8C8t1brDc45VBXe6SsG3wG8D6HI2SJQqPMul9tGb5zyO/NFV8gxd8BYok6F+YyUJu4J1uooYzTuh/vbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V3vIxW8M3sYN3+BDmdNz1Eqs6+Kc1KaZEowyDo/H5Ag=;
 b=D1smaNSDx1LDLMQ6KONhPNXxLBxXNR1u0UW/MfEjEjnzPyedQY99xquqWkn726nd8HTjE50N70PaqnRaI7AYUlJ2h/Kd+SPI9y5BH8hw38iRsffnare+vRpEt87J4hR2eGb0jsMQ0S5dAoaL4o3nIP0LRNrsMJUfERfQMOluuTH39r+n1v/bbf2rDzYroL3ZA2q4ll3ue02iCljFo0mQ3fHT/LFynr97oYoY0L6v+j6A0gqQUTX6ekHdEavTcGnNjUrOQxVklopWlBmA7ZOSw3mzrzYmrc6NM2prZut9YuswKpIs7Ujn7gVhsWTPjsrHAVQObtLoTvONaKwT2Ti8rQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V3vIxW8M3sYN3+BDmdNz1Eqs6+Kc1KaZEowyDo/H5Ag=;
 b=krxxwZ+ECFw9LPJsCR0Vx1Z7bZrv/5998gW9FpuuqSGP0tA9MX0j392XpYLIvk55n51KjS+S7PUdJ78MHwaR2CmafcIjwGcrWVOX487hAs+soNnUVhASmp/VN2HsgUZZkbeKd9a+ahvW+XR28x1QwIDMtT9TgrfTunxNtEhL1nQ=
Received: from BN0PR04CA0197.namprd04.prod.outlook.com (2603:10b6:408:e9::22)
 by DM5PR12MB1290.namprd12.prod.outlook.com (2603:10b6:3:74::9) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5566.15; Sat, 27 Aug 2022 02:26:41 +0000
Received: from BN8NAM11FT090.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e9:cafe::b8) by BN0PR04CA0197.outlook.office365.com
 (2603:10b6:408:e9::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.15 via Frontend
 Transport; Sat, 27 Aug 2022 02:26:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN8NAM11FT090.mail.protection.outlook.com (10.13.177.105) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5566.15 via Frontend Transport; Sat, 27 Aug 2022 02:26:41 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Fri, 26 Aug
 2022 21:26:37 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Fri, 26 Aug
 2022 21:26:37 -0500
Received: from brianchang-HP-EliteDesk-805-G6-Small-Form-Factor-PC.amd.com
 (10.180.168.240) by SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP
 Server id 15.1.2375.28 via Frontend Transport; Fri, 26 Aug 2022 21:26:34
 -0500
From: brichang <Brian.Chang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 00/33] DC Patches August 27 ,2022
Date: Sat, 27 Aug 2022 06:26:49 +0800
Message-ID: <20220826222722.1428063-1-Brian.Chang@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 627d72b2-9b92-43f6-85af-08da87d393ab
X-MS-TrafficTypeDiagnostic: DM5PR12MB1290:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hXjQHkV5/Ki8uSyND2p1ufv8b9goYyLjxwhAJ9PPMb9ONopbSmqHcVsqDAlW9wGX7XKrBiAqL66o8SLh/4JnU1O0HJlxxGxWNkA1dIQqHw/evxxKkrWPV8b5/KfsjoQJmTBILg9lBb0F4s3UsVG7TunX0u+ZrXaRw+u9G5HVNdp42/6djRPP1hoAJDqCwXRu7lSDRlRfapwhn3mllmMOXsWrsBpaXhh482mNLSIoJfXmIc3rsCjkaABYANU2WXHirXAIRiklSE26YdHGkyzJn83AlFh6kxdkbLYOJ1AdG5dYd2M3XFkzG+hmtWOeR07GQTZj2roqAeW9kpZmkkvuQaWu6EmAuFsy/WLyphKzMgaWyKvoXuPOQt4TJFJFaDvtFAjWv+g9/mWzsWD8VqEjDOlfsl9chO6eS9eVNchNEH9HkaOS7DrVPBpT1ptcEma6G+E2LX9+GcBSLplDPHfMvzdMHDrXVlh3PzGGzJFZQ5PPNjRB6zDgFKJQLz+rfwLM95r/fd5aq6mIWkt2aFFPuaRLsEJNcz6j3fBOhlBF/rgczVrvkD88Kglc66rampGftFv1g6cykuMPgQHefeJuRJaCbk9YsICJLtZyyvbc9pDLol7B2WBjURUExVJvwKX/AMvcnnTZbNJofOskIcj8CwPSo/t1LU00idX2I5L5bLcgag7/sbQEqmL7Io2b5AESj4KG0GBBrzOSwXtEWqtOQNsaVcYCnyIIYKByXgurnAOO4j0xJ27ow3dza1FKjUVB2Y3zfW5XwmlZGs/UNbF6kelcsfPxBmkJgCYkiNurX5igEUzLoNlTE8dtQyzhyP16bcBCZBgAdZ3scnYgOlk4Hw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(136003)(396003)(39860400002)(376002)(346002)(36840700001)(46966006)(40470700004)(40480700001)(70586007)(4326008)(8676002)(478600001)(70206006)(83380400001)(36756003)(26005)(6666004)(7696005)(2906002)(316002)(40460700003)(336012)(86362001)(2616005)(81166007)(8936002)(1076003)(186003)(356005)(54906003)(36860700001)(41300700001)(5660300002)(47076005)(82310400005)(82740400003)(426003)(6916009)(43062005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2022 02:26:41.1062 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 627d72b2-9b92-43f6-85af-08da87d393ab
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT090.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1290
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

* Correct cursor position on horizontal mirror;
* Fix black flash when switching from ODM2to1 to ODMBypass;
* Fix plane and stream check;
* Fix viewport after pipe merge;
* Correct plane for CAB cursor;
* Fix comment to correct visual confirm option;
* Fix SubVP related regression;
* Fix primary EDP link detection;
* Fix wrong register access;
* Fix cursor size allocation for DCN32/321;
* Fix display fresh edge case from MALL for DCN321;
* Add HPO instance;
* Refactor EDP codes;
* Add SubVP scaling case;
* Add support for visual confirm color;
* Fix PHY state update;
* Cleanup PSR flag;
* Fix cursor lag with PSR1 eDP;
* Add DC debug optioon for LTTPR mode;
* Add override flag for some dongle;
* Fix SubVP state after pipe programming;
* Remove assert from PHY state update;
* Fix dig fifo read level before reset;
* Add dcn35 basic suppoet;
* Fix OTG H timming for dcn314;
* Fix aux transaction;
* Fix DCN32 DPSTREAMCLK_CNTL programming;
* Fix SubVP scheduling issues;
* Set ODM policy.


Alvin Lee (3):
  drm/amd/display: Don't choose SubVP display if ActiveMargin > 0
  drm/amd/display: Only commit SubVP state after pipe programming
  drm/amd/display: SubVP missing scaling case

Anthony Koo (1):
  drm/amd/display: [FW Promotion] Release 0.0.132.0

Aric Cyr (1):
  drm/amd/display: 3.2.201

Aurabindo Pillai (5):
  drm/amd/display: Fix CAB cursor size allocation for DCN32/321
  drm/amd/display: disable display fresh from MALL on an edge case for
    DCN321
  drm/amd/display: use actual cursor size instead of max for CAB
    allocation
  drm/amd/display: Revert "program k1/k2 divider for virtual signal for
    DCN32"
  drm/amd/display: Use correct plane for CAB cursor size allocation

Charlene Liu (2):
  drm/amd/display: add dcn35 basic support
  drm/amd/display: fix wrong register access

Chen, Leo (1):
  drm/amd/display: add a override flag as wa for some specific dongle

Duncan Ma (1):
  drm/amd/display: Fix OTG H timing reset for dcn314

Ethan Wellenreiter (2):
  drm/amd/display: Re-initialize viewport after pipe merge
  drm/amd/display: Fix check for stream and plane

Gabe Teeger (2):
  drm/amd/display: Cursor lag with PSR1 eDP
  drm/amd/display: Cleanup PSR flag

George Shen (1):
  drm/amd/display: Fix DCN32 DPSTREAMCLK_CNTL programming

Ian Chen (2):
  drm/amd/display: Refactor edp dsc codes.
  drm/amd/display: Add comments.

Iswara Nagulendran (1):
  drm/amd/display: Fix primary EDP link detection

Leo (Hanghong) Ma (2):
  drm/amd/display: Add visual confirm color support for SubVP
  drm/amd/display: Add support for visual confirm color

Leo Chen (1):
  drm/amd/display: Missing HPO instance added

Lewis Huang (1):
  drm/amd/display: Refine aux transaction before retrieve caps

Martin Tsai (1):
  drm/amd/display: Correct cursor position on horizontal mirror

Michael Strauss (1):
  drm/amd/display: Add DC debug option to force LTTPR mode

Taimur Hassan (3):
  drm/amd/display: Set ODM policy based on number of DSC slices
  drm/amd/display: Remove assert from PHY state update
  drm/amd/display: Allow PHY state update between same states

Vladimir Stempen (1):
  drm/amd/display: Fix black flash when switching from ODM2to1 to
    ODMBypass

Wang Fudong (1):
  drm/amd/display: set dig fifo read start level to 7 before dig fifo
    reset

 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |  4 +-
 .../amd/display/amdgpu_dm/amdgpu_dm_helpers.c | 19 +++++
 .../drm/amd/display/dc/clk_mgr/Makefile.rej   | 17 ++++
 drivers/gpu/drm/amd/display/dc/core/dc.c      | 26 +++---
 .../drm/amd/display/dc/core/dc_hw_sequencer.c | 38 +++++++++
 drivers/gpu/drm/amd/display/dc/core/dc_link.c | 22 ++---
 .../gpu/drm/amd/display/dc/core/dc_link_dp.c  | 53 +++++++++---
 drivers/gpu/drm/amd/display/dc/dc.h           |  8 +-
 drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c  | 41 ++++++++-
 drivers/gpu/drm/amd/display/dc/dc_dmub_srv.h  |  1 +
 drivers/gpu/drm/amd/display/dc/dc_link.h      | 12 +++
 drivers/gpu/drm/amd/display/dc/dce/dce_abm.h  |  9 +-
 .../display/dc/dce110/dce110_hw_sequencer.c   | 13 +++
 .../gpu/drm/amd/display/dc/dcn10/dcn10_dpp.c  |  5 +-
 .../gpu/drm/amd/display/dc/dcn10/dcn10_hubp.c |  9 +-
 .../amd/display/dc/dcn10/dcn10_hw_sequencer.c | 83 +++++++++++++------
 .../display/dc/dcn10/dcn10_stream_encoder.h   |  1 +
 .../gpu/drm/amd/display/dc/dcn20/dcn20_hubp.c |  9 +-
 .../drm/amd/display/dc/dcn20/dcn20_hwseq.c    |  6 +-
 .../gpu/drm/amd/display/dc/dcn30/dcn30_dpp.h  |  3 +-
 .../display/dc/dcn31/dcn31_dio_link_encoder.c |  3 +
 .../dc/dcn31/dcn31_hpo_dp_link_encoder.h      | 10 ++-
 .../drm/amd/display/dc/dcn31/dcn31_resource.c |  1 -
 .../dc/dcn314/dcn314_dio_stream_encoder.c     |  1 +
 .../drm/amd/display/dc/dcn314/dcn314_optc.c   |  3 +-
 .../amd/display/dc/dcn314/dcn314_resource.c   |  2 +-
 .../amd/display/dc/dcn315/dcn315_resource.c   |  1 -
 .../amd/display/dc/dcn316/dcn316_resource.c   |  1 -
 .../gpu/drm/amd/display/dc/dcn32/dcn32_dccg.c |  8 +-
 .../dc/dcn32/dcn32_dio_stream_encoder.c       |  5 ++
 .../drm/amd/display/dc/dcn32/dcn32_hwseq.c    | 75 ++++++++++++-----
 .../display/dc/dcn32/dcn32_resource_helpers.c |  2 +-
 drivers/gpu/drm/amd/display/dc/dm_helpers.h   |  7 +-
 .../drm/amd/display/dc/dml/dcn32/dcn32_fpu.c  | 36 +++++++-
 .../dc/dml/dcn32/display_mode_vba_32.c        |  4 +-
 .../dc/dml/dcn32/display_mode_vba_util_32.c   |  7 +-
 .../dc/dml/dcn32/display_mode_vba_util_32.h   |  1 +
 .../drm/amd/display/dc/dml/display_mode_vba.h |  1 +
 .../gpu/drm/amd/display/dc/inc/hw_sequencer.h |  5 ++
 .../amd/display/dc/link/link_hwss_hpo_dp.c    |  4 +-
 drivers/gpu/drm/amd/display/dmub/dmub_srv.h   |  4 +-
 .../gpu/drm/amd/display/dmub/inc/dmub_cmd.h   | 47 ++++++++++-
 .../gpu/drm/amd/display/include/dal_types.h   |  1 +
 43 files changed, 469 insertions(+), 139 deletions(-)
 create mode 100644 drivers/gpu/drm/amd/display/dc/clk_mgr/Makefile.rej

-- 
2.25.1

