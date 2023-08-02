Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8F30C001DF
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Aug 2023 06:51:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 79F9210E4A8;
	Wed,  2 Aug 2023 06:51:49 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2084.outbound.protection.outlook.com [40.107.102.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 24B4B10E4A8
 for <amd-gfx@lists.freedesktop.org>; Wed,  2 Aug 2023 06:51:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=As+G95UnTUW+XcaNd+lJ6uLC4uE52MW3TbA8LGqL2nhgnOchO8Hd0Ept49onv/Ve6JcYK9qlrKrx17pW8sd/2V20YWrvJ56CZY2t3EoAmbjERSaJV+kxbNbdIRMMbHPLKs2iFxJLe1uFZhnMX77nzB552cgM2ur0q11eupOd4BywO/KybSWkRdBcxasBuFXsmHoA/lMnBFf5na8P8BnxGV7JAk3Opk7gi2cyeXTl3slx2Lj3YtMUoFDVcSqonIDrBgcWYk9ixcL/eA5ASlefnOsnEZmU+SPCYvacQFkpDdC0SykiXTtSYiMKBMGfkXFeN8GOfxxRlvF/52OOOiG9fA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HdEbyAAv1/9lC4EZIYLTCjw4KxQU3gmKXFViypbxfx0=;
 b=VGrf1Qc2GnFgUeF/wPgvRBjffVfX3NSJNuT1YrsmX3t1XHv6JcFad9XflRNO4nHYA06SmZVH43s+TiQAoWuHPZoLcs6zUARirajAG/ooUnAT3qjL9QUK5CEtLwlTcNrc9EJ5qRcUt9JOS4JxBQx2WJlYDCzVXH95cJ7XBcBokrQioi264nnieBh07WGpb2zMVhgH1yYVPv8BLr+hPekc40/mLxISVPW5QKpuwh9g8oslGXN3LP6U58EDj1CsVV1aJlAGK+WQGPb1oNA8RWa/iMgbY4604zlJK+THAqAQyYuZ9TbOxz40rh8PW9mNKZXjqN3bmkgQCHFJSgxBxqamtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HdEbyAAv1/9lC4EZIYLTCjw4KxQU3gmKXFViypbxfx0=;
 b=EfVJGWMu2Km4niUvCkl+YS2Z+uJh2MhNZyyDh1/uu7+9zQ6DLv8Httrbcan6mNvVz5pXJKEOKghY9qxGxc8sbrxpDUWbC92NJjmG6WElLFk5KktfEiOro5N9dm/Ro0bfhLz6xxHomvJtEs7Zx3pz0H1/Yd2glf9kfVNVtKoCtUQ=
Received: from CYXPR02CA0040.namprd02.prod.outlook.com (2603:10b6:930:cc::25)
 by SA3PR12MB7880.namprd12.prod.outlook.com (2603:10b6:806:305::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29; Wed, 2 Aug
 2023 06:51:45 +0000
Received: from CY4PEPF0000EE38.namprd03.prod.outlook.com
 (2603:10b6:930:cc:cafe::a5) by CYXPR02CA0040.outlook.office365.com
 (2603:10b6:930:cc::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.19 via Frontend
 Transport; Wed, 2 Aug 2023 06:51:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CY4PEPF0000EE38.mail.protection.outlook.com (10.167.242.12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6652.19 via Frontend Transport; Wed, 2 Aug 2023 06:51:45 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 2 Aug
 2023 01:51:44 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 1 Aug
 2023 23:51:44 -0700
Received: from tom-HP.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.27 via Frontend
 Transport; Wed, 2 Aug 2023 01:51:40 -0500
From: Tom Chung <chiahsuan.chung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 00/22] DC Patches Aug 04 2023
Date: Wed, 2 Aug 2023 14:51:10 +0800
Message-ID: <20230802065132.3129932-1-chiahsuan.chung@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE38:EE_|SA3PR12MB7880:EE_
X-MS-Office365-Filtering-Correlation-Id: eb908beb-9240-4596-54dd-08db9324efc1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1T4oSJLxOZiv/KZRAUSxqcRRnCAQL8hV+OW71G9kd+Ap+YIOmp+73jcpT62DIKeF2/tg0MCyZdxt9pPcFkKi3UKBxD6jlvt/uhmHhHZctF5zQYQV+Pvw4lQbXdNChqtW3IIaOpZcw+pXdX3ArqvF3PK6Ve9fytLKwNRyATstwI0Yq1vk8HeoDli47z4hHzBJxqEIzxROXoz8JV/HbmYlhc9RY0lKP6yxBbIbwYR3ooepUQxWfkERZnuipUaVdeRvgprGgGc9Vv7BzKSGfcpjBzFOTHpl7oy6b7aSq4LsuOpI9so47e1q8IAsbxvsXWvdDC2qFduPpiwVFygZv799QxwhiDVwBXtBpelPzMc0TkaTuUpBKURupzde03yUBCQd/CmKu/whhdyPEULE8Qe31AV6B4HAyi2mP6HuSV/3myD6rL/3OE3d8sWoDbGiubU3ZUwFtY6IYaqFVbQlqXGocDcJmp8H9quGGlEo1xWZ7m6qh1dHG9RxF92e1bMRjY4MZg4TQzFd8zS+9+XQzfklQLGvGi72i/iDrtu2c6xKZ0cvjH24DsFiDuUWWxCsNgg5FhaMSxtCO0peSA9D+tuSf5VP3+wNkB0DaaHdv7KgeoDFNxIt+rTO0GL7tCMq0GXyuIoSIepPBKG4pZ2npkFRVrECbt+5AE31RMI7PXAn+0BIPGat4AD23A65hvFqm1vDuEMfblo/74Y+uKQR3F5j4EJMutb3r27NkD4SaMIIHOfyDX5iy8Qe+3hzV+5zofQ/Blz9JfyjEry0rIPJTjC5MA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(346002)(39860400002)(396003)(136003)(451199021)(82310400008)(46966006)(40470700004)(36840700001)(81166007)(6666004)(7696005)(1076003)(26005)(186003)(2616005)(336012)(356005)(478600001)(54906003)(82740400003)(4326008)(47076005)(83380400001)(426003)(6916009)(36860700001)(70206006)(70586007)(40460700003)(8676002)(8936002)(41300700001)(2906002)(86362001)(40480700001)(5660300002)(36756003)(316002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Aug 2023 06:51:45.2493 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: eb908beb-9240-4596-54dd-08db9324efc1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE38.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7880
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

- Fix a regression in blank pixel data caused by coding mistake
- Fix a bug when searching for insert_above_mpcc
- Fix backlight off cmd for OLED panel
- Update add plane to context logic with a new algorithm
- Adjust visual confirm dpp height offset to be 1/240 of v addressable
- Add interface to enable DPIA trace
- Support plane clip with zero recout size
- Blocking invalid 420 modes on HDMI TMDS for DCN31 and DCN314
- Make mpc32 functions available to future DCNs
- Change HDCP update sequence for DM

Cc: Daniel Wheeler <daniel.wheeler@amd.com>

Alvin Lee (1):
  drm/amd/display: Use max memclk variable when setting max memclk

Austin Zheng (2):
  drm/amd/display: Set Stream Update Flags in commit_state_no_check
  drm/amd/display: Use DTBCLK as refclk instead of DPREFCLK

Bhawanpreet Lakha (1):
  drm/amd/display: Change HDCP update sequence for DM

Leo Chen (3):
  drm/amd/display: Revert "dc: read down-spread percentage from lut to
    adjust dprefclk"
  drm/amd/display: Blocking invalid 420 modes on HDMI TMDS for DCN31
  drm/amd/display: Blocking invalid 420 modes on HDMI TMDS for DCN314

Martin Leung (1):
  drm/amd/display: Promote DAL to 3.2.246

Mike Hsieh (1):
  drm/amd/display: Add vendor Id for reference

Stylon Wang (2):
  drm/amd/display: Add interface to enable DPIA trace
  drm/amd/display: Enable DPIA trace with DC debug mask

Swapnil Patel (1):
  drm/amd/display: Fix backlight off cmd for OLED panel

Wenjing Liu (8):
  drm/amd/display: fix a regression in blank pixel data caused by coding
    mistake
  drm/amd/display: support plane clip with zero recout size
  drm/amd/display: always acquire MPO pipe for every blending tree
  drm/amd/display: update add plane to context logic with a new
    algorithm
  drm/amd/display: adjust visual confirm dpp height offset to be 1/240
    of v addressable
  drm/amd/display: do not treat clip_rect size change as a scaling
    change
  drm/amd/display: move idle pipe allocation logic into dcn specific
    layer
  drm/amd/display: rename acquire_idle_pipe_for_layer to
    acquire_free_pipe_as_sec_dpp_pipe

Wesley Chalmers (2):
  drm/amd/display: Fix a bug when searching for insert_above_mpcc
  drm/amd/display: Make mpc32 functions available to future DCNs

 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |   7 +-
 .../amd/display/amdgpu_dm/amdgpu_dm_hdcp.c    |  80 ++-
 .../dc/clk_mgr/dcn314/dcn314_clk_mgr.c        |  32 +-
 .../dc/clk_mgr/dcn314/dcn314_clk_mgr.h        |   7 -
 .../display/dc/clk_mgr/dcn32/dcn32_clk_mgr.c  |   2 +-
 drivers/gpu/drm/amd/display/dc/core/dc.c      | 111 +---
 .../gpu/drm/amd/display/dc/core/dc_resource.c | 589 ++++++++----------
 drivers/gpu/drm/amd/display/dc/dc.h           |   2 +-
 drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c  |  29 +
 drivers/gpu/drm/amd/display/dc/dc_dmub_srv.h  |   3 +
 .../display/dc/dce110/dce110_hw_sequencer.c   |   3 +-
 .../amd/display/dc/dce110/dce110_resource.c   |  12 +-
 .../gpu/drm/amd/display/dc/dcn10/dcn10_mpc.c  |   5 +-
 .../drm/amd/display/dc/dcn10/dcn10_resource.c |  15 +-
 .../drm/amd/display/dc/dcn20/dcn20_hwseq.c    |   2 +-
 .../drm/amd/display/dc/dcn20/dcn20_resource.c |  15 +-
 .../drm/amd/display/dc/dcn20/dcn20_resource.h |   7 +-
 .../amd/display/dc/dcn201/dcn201_resource.c   |  15 +-
 .../drm/amd/display/dc/dcn21/dcn21_resource.c |   2 +-
 .../drm/amd/display/dc/dcn30/dcn30_resource.c |   2 +-
 .../amd/display/dc/dcn301/dcn301_resource.c   |   2 +-
 .../amd/display/dc/dcn302/dcn302_resource.c   |   2 +-
 .../amd/display/dc/dcn303/dcn303_resource.c   |   2 +-
 .../drm/amd/display/dc/dcn31/dcn31_resource.c |   2 +-
 .../amd/display/dc/dcn314/dcn314_resource.c   |   2 +-
 .../amd/display/dc/dcn315/dcn315_resource.c   |   2 +-
 .../amd/display/dc/dcn316/dcn316_resource.c   |   2 +-
 .../gpu/drm/amd/display/dc/dcn32/dcn32_dccg.c |   3 +-
 .../gpu/drm/amd/display/dc/dcn32/dcn32_mpc.c  |  28 +-
 .../gpu/drm/amd/display/dc/dcn32/dcn32_mpc.h  |  61 ++
 .../drm/amd/display/dc/dcn32/dcn32_resource.c | 188 +++---
 .../drm/amd/display/dc/dcn32/dcn32_resource.h |   8 +-
 .../amd/display/dc/dcn321/dcn321_resource.c   |   2 +-
 .../drm/amd/display/dc/dml/calcs/dcn_calcs.c  |   2 +-
 .../dc/dml/dcn31/display_mode_vba_31.c        |   4 +-
 .../dc/dml/dcn314/display_mode_vba_314.c      |   4 +-
 .../gpu/drm/amd/display/dc/inc/core_types.h   |  38 +-
 drivers/gpu/drm/amd/display/dc/inc/link.h     |   1 +
 drivers/gpu/drm/amd/display/dc/inc/resource.h |  21 +-
 .../display/dc/link/accessories/link_dp_cts.c |   2 +-
 .../drm/amd/display/dc/link/link_factory.c    |   1 +
 .../link/protocols/link_edp_panel_control.c   |  19 +
 .../link/protocols/link_edp_panel_control.h   |   1 +
 .../gpu/drm/amd/display/dmub/inc/dmub_cmd.h   |  18 +
 .../amd/display/include/ddc_service_types.h   |   1 +
 45 files changed, 651 insertions(+), 705 deletions(-)

-- 
2.25.1

