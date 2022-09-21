Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39C65ECAAD8
	for <amd-gfx@archiver.kernel.org>; Wed, 21 Sep 2022 23:17:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 26B3C10E986;
	Wed, 21 Sep 2022 23:17:40 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2046.outbound.protection.outlook.com [40.107.92.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7223710E98F
 for <amd-gfx@lists.freedesktop.org>; Wed, 21 Sep 2022 23:17:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oWKiKZFvp+t9AYNKECvtfLc3woJ5Y6dgFtpNsHvTw5/M9m1RGoOxf8vGHGpscDflqlUADfSwvKHhvzAQlJWTKYPTejwMher0w0rouzocnJCtvG3cPLgt1q/GaGrlOJ1loBUa1wYZoBZSzk20UrGP+O6Eg8v6Sb/v+dcL/EZribPQ08qOXdwfx7qsFAU8b3t1xnZe9GglCh6s1hHJg7GyrcamuQzjnJJ4sRK5Mhm9OTOqCrEuuZicLvoG9xyz76f6JNU26nWgfIuaOhgrSH7s9K6GQmpb0o3jeuz4KoaAfq7eyi3RoCcN1ofP21MnqYBShKMBqlKH1hXaMUvH3JLMyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4dcmEHvQd8NuQNv1z8WeV0JkHdt9hVHn9Hfd5cWvqgw=;
 b=gETWyzRuTVre1cdJ+Lx3ZAvX/mRNuxpOpam/55T3vClHWr4OG8Hci69TzD/7SS6GEtD72qF4Ehypi1PzP5kqekQtVW8wdq5yx5eRbLptAyeHJ9mtDyz52MyY8QDtapzszsUDenyIF1e+deQ51ur57NLq1X7PlTbeQ/yEgA9QVBBQUgsgEMlDi8lYbu6N3HABbnWTyAxVmwzNseEOv2v9m0xVY1tRUT/2hhwLoQYPNnZvrUfzcrSOJZ+31jBxbco0Gh0sebZ1/Z/LWqOa7tlakepLenLbA4/t8nWC6k3PrQtGgwIvXwziX+GLn1tykFkxl2ck9NteEgDK00i8T4R9NQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4dcmEHvQd8NuQNv1z8WeV0JkHdt9hVHn9Hfd5cWvqgw=;
 b=eVIzuh0ZuhudVDzNWPv7MI3pwmwQ3SFKYBhiCN4ZOJGpYBsBUfv+TxoQ6YyRrFGYC5bfNCFLj7JSpan/R7iNsMZbGZakbGdBYzrfBi7FjhDnBdgM3D0vlA+0eSvDBYF8CLPEcyb/n033cIMXcbzgmp3c3KmeGr6ooonhRY8CeY4=
Received: from MW4PR03CA0023.namprd03.prod.outlook.com (2603:10b6:303:8f::28)
 by SN7PR12MB7298.namprd12.prod.outlook.com (2603:10b6:806:2ae::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.16; Wed, 21 Sep
 2022 23:17:32 +0000
Received: from CO1NAM11FT115.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8f:cafe::1) by MW4PR03CA0023.outlook.office365.com
 (2603:10b6:303:8f::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.16 via Frontend
 Transport; Wed, 21 Sep 2022 23:17:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT115.mail.protection.outlook.com (10.13.174.211) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5654.14 via Frontend Transport; Wed, 21 Sep 2022 23:17:31 +0000
Received: from jasdeep-System-Product-Name.phub.net.cable.rogers.com
 (10.180.168.240) by SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Wed, 21 Sep 2022 18:17:29 -0500
From: Jasdeep Dhillon <jdhillon@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 00/31] DC Patches Sept 20, 2022
Date: Wed, 21 Sep 2022 19:16:43 -0400
Message-ID: <20220921231714.303727-1-jdhillon@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT115:EE_|SN7PR12MB7298:EE_
X-MS-Office365-Filtering-Correlation-Id: 8be4f23f-df3b-42aa-b751-08da9c2775da
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wp4goeU9R9jYV1EPjPmnweboX621CifaF72P0wzD8FOsbRbnQDGamSk+8xunPdHMfTPu1L8PgxOj2CQ3t5siMvS55QtIip4v9yi4EZX8Rr4nvEKLfE9KB/GSTQjtnOrZwzHzJd7cibFGY4c2zzM0c1YmGBVNdwK+aqmXLEgSw/bQTPk1WKqQxRoZRfR4AI+X347SHnM2re+Ncp6Ob7iyX+1j/KBF1ldHp6YilZnkFgGRwVEmBquEbd1uWRoovjXPwB0s/WXaH8EqvaTeB+QMTUlWYtuduG8Mx5bzMkigXSSZ/TyUVd/h4SIkJuPtb5ELOAywMPe+V9lGuRRHXIIK5aKX8hUvqWelvwbWTLEtfVerhVhJiAkEzJ8+286Iqa2eusOetAmJzAFU00oXSlQ8Fj/hX1RlJdLlMSL6F2o3oc2f+0O/rz26q4sFvzfBt8t/lgyf7T0mimsjBOtuBl32OM9ILOQYHcAGioWmoW0O8Z+10fCRUrjim0+aA9+WW+yQYh8eDw+tNAMs4OfpPuSyfclcKGDxoTS0h/8ccAKNnwx0AJ5HtgvywROQZDT1hF6RND7IKf9LUyCaEn0EqB1+Ry+gid8K+6azS/WziiIUc4A89sxlm16hqflhMUD692L0N1560hQIpC0qS4tBt4Dsc0NezBixj8V+7TaewKvGuWTEUH3471yCn3GPZpIcTlP8glUk2QZ//o6UwssJn82CGZi0kX/N/zGKHbAuhqHxdI2kYxG8NR6pCao2EPMHYwqutL7jUJuvddme0x9pEfDgazRvgiWCUw8tU20/uzrfWdV1Px8HHBVLOy16yYmIE6gT
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(39860400002)(136003)(346002)(376002)(396003)(451199015)(40470700004)(36840700001)(46966006)(2906002)(36756003)(1076003)(47076005)(2616005)(426003)(336012)(16526019)(186003)(4326008)(8676002)(6666004)(5660300002)(41300700001)(26005)(8936002)(82740400003)(40460700003)(81166007)(356005)(82310400005)(83380400001)(36860700001)(40480700001)(6916009)(54906003)(316002)(478600001)(70586007)(70206006)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2022 23:17:31.9397 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8be4f23f-df3b-42aa-b751-08da9c2775da
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT115.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7298
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
 qingqing.zhuo@amd.com, Jasdeep Dhillon <jdhillon@amd.com>,
 Rodrigo.Siqueira@amd.com, roman.li@amd.com, solomon.chiu@amd.com,
 Daniel Wheeler <daniel.wheeler@amd.com>, Aurabindo.Pillai@amd.com,
 wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com,
 pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Subject: DC Patches MONTH DAY, YEAR
 
This DC patchset brings improvements in multiple areas. In summary, we have:
 
    - LTTPR mode can be be dynamically changed
    - features able to use same interface to update cursor info 
    - fixes for llvm compilation issues
    - Fixes DIO FIFO underflow and other FIFO errors
    - Partially valid EDIDs handled properly 
    - Phatom pipes are skipped when checking pending flip
    - Fixed audio on display after unplugging
 
Cc: Daniel Wheeler <daniel.wheeler@amd.com>

Alvin Lee (4):
  drm/amd/display: Update DCN32 to use new SR latencies
  drm/amd/display: Update MALL SS NumWays calculation
  drm/amd/display: Disable MALL when TMZ surface
  drm/amd/display: Fix CAB allocation calculation

Aric Cyr (3):
  drm/amd/display: Remove interface for periodic interrupt 1
  drm/amd/display: Fix audio on display after unplugging another
  drm/amd/display: 3.2.205

Aurabindo Pillai (2):
  drm/amd/display: skip phantom pipes when checking for pending flip
  drm/amd/display: fix a divide by zero error

Brandon Syu (1):
  Add debug option for exiting idle optimizations on cursor updates

Charlene Liu (1):
  drm/amd/display: add debug keys for override bios settings.

Dillon Varone (1):
  drm/amd/display: Fix various dynamic ODM transitions on DCN32

Eric Bernstein (1):
  drm/amd/display: Remove assert for odm transition case

Ian Chen (1):
  Add ABM control to panel_config struct.

Ilya Bakoulin (1):
  drm/amd/display: Change EDID fallback condition

Max Tseng (1):
  drm/amd/display: Cursor Info Update refactor

Michael Strauss (1):
  drm/amd/display: Refactor LTTPR mode selection

Nathan Chancellor (2):
  drm/amd/display: Reduce number of arguments of dml314's
    CalculateWatermarksAndDRAMSpeedChangeSupport()
  drm/amd/display: Reduce number of arguments of dml314's
    CalculateFlipSchedule()

Nicholas Kazlauskas (3):
  drm/amd/display: Wrap OTG disable workaround with FIFO control
  drm/amd/display: Add explicit FIFO disable for DP blank
  drm/amd/display: Do DIO FIFO enable after DP video stream enable

Samson Tam (1):
  drm/amd/display: fill in clock values when DPM is not enabled

Taimur Hassan (3):
  drm/amd/display: Avoid avoid unnecessary pixel rate divider
    programming
  drm/amd/display: Fix typo in get_pixel_rate_div
  drm/amd/display: Avoid unnecessary pixel rate divider programming

Tom Rix (3):
  drm/amd/display: remove redundant CalculateTWait's
  drm/amd/display: refactor CalculateWriteBackDelay to use vba_vars_st
    ptr
  drm/amd/display: remove redundant CalculateRemoteSurfaceFlipDelay's

Wenjing Liu (2):
  drm/amd/display: add missing null check
  drm/amd/display: polling vid stream status in hpo dp blank

 .../drm/amd/display/dc/bios/bios_parser2.c    |  21 +-
 .../dc/clk_mgr/dcn314/dcn314_clk_mgr.c        |  11 +-
 .../display/dc/clk_mgr/dcn32/dcn32_clk_mgr.c  |  14 +
 drivers/gpu/drm/amd/display/dc/core/dc.c      | 127 +++--
 .../gpu/drm/amd/display/dc/core/dc_link_ddc.c |  19 +
 .../gpu/drm/amd/display/dc/core/dc_link_dp.c  | 301 ++++++-----
 .../drm/amd/display/dc/core/dc_link_dpia.c    |  34 +-
 .../gpu/drm/amd/display/dc/core/dc_stream.c   |   1 +
 drivers/gpu/drm/amd/display/dc/dc.h           |   8 +-
 drivers/gpu/drm/amd/display/dc/dc_link.h      |   7 +-
 drivers/gpu/drm/amd/display/dc/dc_stream.h    |   6 +-
 .../display/dc/dce110/dce110_hw_sequencer.c   |   6 +-
 .../amd/display/dc/dcn10/dcn10_hw_sequencer.c |  35 +-
 .../amd/display/dc/dcn10/dcn10_hw_sequencer.h |   3 +-
 .../drm/amd/display/dc/dcn30/dcn30_resource.c |   3 +-
 .../amd/display/dc/dcn301/dcn301_resource.c   |   1 +
 .../amd/display/dc/dcn302/dcn302_resource.c   |   3 +-
 .../amd/display/dc/dcn303/dcn303_resource.c   |   1 +
 .../dc/dcn31/dcn31_hpo_dp_stream_encoder.c    |   6 +-
 .../drm/amd/display/dc/dcn314/dcn314_dccg.c   |  47 ++
 .../dc/dcn314/dcn314_dio_stream_encoder.c     |  25 +-
 .../gpu/drm/amd/display/dc/dcn32/dcn32_dccg.c |  53 ++
 .../drm/amd/display/dc/dcn32/dcn32_hubbub.c   |  10 +-
 .../drm/amd/display/dc/dcn32/dcn32_hwseq.c    | 280 ++++++----
 .../drm/amd/display/dc/dcn32/dcn32_hwseq.h    |   8 +
 .../gpu/drm/amd/display/dc/dcn32/dcn32_init.c |   2 +
 .../drm/amd/display/dc/dcn32/dcn32_resource.c |  27 +-
 .../display/dc/dcn32/dcn32_resource_helpers.c |   2 +-
 .../amd/display/dc/dcn321/dcn321_resource.c   |   3 +
 .../dc/dml/dcn20/display_mode_vba_20.c        |  98 +---
 .../dc/dml/dcn20/display_mode_vba_20v2.c      | 176 +-----
 .../dc/dml/dcn21/display_mode_vba_21.c        | 173 +-----
 .../dc/dml/dcn30/display_mode_vba_30.c        |  92 +---
 .../dc/dml/dcn31/display_mode_vba_31.c        |  89 +--
 .../dc/dml/dcn314/display_mode_vba_314.c      | 509 ++++--------------
 .../drm/amd/display/dc/dml/dcn32/dcn32_fpu.c  |  70 ++-
 .../drm/amd/display/dc/dml/dcn32/dcn32_fpu.h  |   2 +
 .../dc/dml/dcn32/display_mode_vba_32.c        |  42 +-
 .../dc/dml/dcn32/display_mode_vba_util_32.c   |  30 --
 .../dc/dml/dcn32/display_mode_vba_util_32.h   |  10 +-
 .../gpu/drm/amd/display/dc/inc/dc_link_dp.h   |   5 +
 .../amd/display/dc/inc/hw/clk_mgr_internal.h  |   2 +
 .../gpu/drm/amd/display/dc/inc/hw_sequencer.h |   9 +-
 .../amd/display/dc/inc/hw_sequencer_private.h |   2 +
 .../gpu/drm/amd/display/dmub/inc/dmub_cmd.h   |   5 +
 .../amd/display/include/link_service_types.h  |   1 +
 scripts/extract-cert                          | Bin 0 -> 18320 bytes
 47 files changed, 952 insertions(+), 1427 deletions(-)
 create mode 100755 scripts/extract-cert

-- 
2.25.1

