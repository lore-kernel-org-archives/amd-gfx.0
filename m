Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B22BFECAAD5
	for <amd-gfx@archiver.kernel.org>; Sat, 27 Aug 2022 02:50:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 87D3D10EB51;
	Sat, 27 Aug 2022 02:50:16 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2055.outbound.protection.outlook.com [40.107.237.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 968AC10EB52
 for <amd-gfx@lists.freedesktop.org>; Sat, 27 Aug 2022 02:50:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PUHYyHNQbQSauR5DNHBuPNaQOeQHtEGan/02ChlQDvCq8+0KjB76qVR8nN/cbSWpm11m33xOxYgd5IYMxH4TbFukxzU8bnKAtbNzYByL1YAeWTgM2+KyKNvrgo1fFRhKGV/IzLzHKOcSo1Fzq4AytX9rX7rs4Mmf0PcamDocwKXpuP7/jUxVfHkwJ6RY6EU64+6asrSV2o86xh+GmGLInlyzusMLeS6L9g0v/j+FLZ8jFnIrkebf7csvYxGXV8J6xH8nVpXI3C1CqJbDStegX2kUuNzGvhVpO2qLt8JJLR1JDt21uPO0e0Brh9CI6lO6L7HFn6Tw3TWVQaMeqLyKFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V3vIxW8M3sYN3+BDmdNz1Eqs6+Kc1KaZEowyDo/H5Ag=;
 b=H3gnl5y/tDyO3ovKqBYDEWfXfTIutb4kEczmaq+eOwifPKRj95UWUHSFFKrzzJ6KkWcKn1IpULi6XFw3Fkhcludh3C6D/97OKwZIcmSesfZ9UnEeMHTOWU0LEheRgVTXRcAmTPEGnOqKodX7X35rmDo1ysiR4NBw1fsfLmFDYHUd7eyOMEoiZ7Hf8J6sg166diDwOG2dfPothwSdkTsfYB9IkpgCWwiBrO/UYbBg3wOhvdJG1RF3ZG/5dNatyxHaVw1EGkwKKAIbn/wFrvVzSXEdZx+iZE3eA/glQoPr+6BuIuZHfCbFQq1gwUvEcYjNkMzUwAYcBWT9YOmnStRDRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V3vIxW8M3sYN3+BDmdNz1Eqs6+Kc1KaZEowyDo/H5Ag=;
 b=E+iioTfm25h+gTg3ioAxo6PtTPOzg3bjsrcfItTquXbGlokAlGPZRn/gdgBMPWSUOMQ3r13PXp8pmTfMFlkgNl9U0l8X06LnkxLjgqLJFgk0+KInNCv5uNYA2vx6G4WLmxXbPSdiBkPnajBbDikCf1y+mwaPY7iMg7WVJRVA7lo=
Received: from CY5PR15CA0209.namprd15.prod.outlook.com (2603:10b6:930:82::27)
 by DS0PR12MB6631.namprd12.prod.outlook.com (2603:10b6:8:d1::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.14; Sat, 27 Aug
 2022 02:50:11 +0000
Received: from CY4PEPF0000B8EA.namprd05.prod.outlook.com
 (2603:10b6:930:82:cafe::4) by CY5PR15CA0209.outlook.office365.com
 (2603:10b6:930:82::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.18 via Frontend
 Transport; Sat, 27 Aug 2022 02:50:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CY4PEPF0000B8EA.mail.protection.outlook.com (10.167.241.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5566.14 via Frontend Transport; Sat, 27 Aug 2022 02:50:08 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Fri, 26 Aug
 2022 21:50:08 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Fri, 26 Aug
 2022 19:50:08 -0700
Received: from brianchang-HP-EliteDesk-805-G6-Small-Form-Factor-PC.amd.com
 (10.180.168.240) by SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP
 Server id 15.1.2375.28 via Frontend Transport; Fri, 26 Aug 2022 21:50:04
 -0500
From: brichang <Brian.Chang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 00/33] DC Patches August 27 ,2022
Date: Sat, 27 Aug 2022 06:50:20 +0800
Message-ID: <20220826225053.1435588-1-Brian.Chang@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 57de4990-e74f-46fd-727b-08da87d6dad4
X-MS-TrafficTypeDiagnostic: DS0PR12MB6631:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DxvQm1nHJ89oA4kkX7QDzyUfssGEgx/iuDMgcihOgrCfgnEBJmwsFCEouyh1+SaTTOF2SDZwmsoNHW1zGzDulvrMK2CxJJSU5gf2aV7hQlB2ptlVDQfXV89JOT0gjynraMchIgaTNChfmPvolDTf6+Z4tScItA9BSuuQForKXFnbheTetyL+RYVGfgyQ+U4Vrzvm4R1w6Swpj9qXhwsS6yUZ0T/DqftdYs+es/XYQhzri8phyIQ6mqxtq2RJ5F58atILFR0lg/Uq5uQRudwZdRSnXCSGAHlnIGOYO9LTQjCjH2N14l+2P01c0Rk833lQvGWnn/0/8Pyg8+4zZJ2HgORx33M/TOfj95TeQEGajf6p36ZiS2BJ/ngChOUutH9BFJtbbAroWc0i/1PvqHSxRr+ATMUvFmtnICJQXaPG3zO7p2CA4V0CTqLfrJrqIW0PsJR4yoT90qCegnd1uDAU4ECP1lGxSqmY6EV8/Nfc6gbSQ7Bh9t4oafkeCumGCOW3DVSrkv+E6vsqO5XhSLl4dWXPxGUB6q4TEAgM99GN5X8GVuSHSrB8m2AsNVhLD06ehGmuzB6b9DbmLZT+P1XX2sWNihlBzgI1CznSvAYWSqUp2h1aUx7GSZRdltNEHrAEWwsqCtPjaRu9mIAsN3v6ojHIirokD1xRy63RKxIA+RyisL83UGYfCutfTnhysN9RQTuVDkQvhfMcoedzCUtWeaGcMUMXILJ3BN82RYMZ1xpPH7PsXGc6of1hfCBm4Myktml2hZfljtkdZocUUJ5RvfTLlDjZgAWrMpxOwyYqPjUZCqg1Di0qDomBJOGfS60NF+WA/6t4jL0Ijyy6PWHqQA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(376002)(136003)(39860400002)(346002)(396003)(36840700001)(40470700004)(46966006)(336012)(47076005)(2906002)(26005)(2616005)(1076003)(186003)(86362001)(82310400005)(40460700003)(426003)(83380400001)(82740400003)(7696005)(81166007)(6666004)(356005)(5660300002)(36860700001)(40480700001)(478600001)(8936002)(316002)(41300700001)(54906003)(36756003)(6916009)(70206006)(8676002)(4326008)(70586007)(43062005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2022 02:50:08.9359 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 57de4990-e74f-46fd-727b-08da87d6dad4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000B8EA.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6631
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

