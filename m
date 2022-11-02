Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F933C4332F
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Nov 2022 16:02:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 74DF210E4D7;
	Wed,  2 Nov 2022 16:02:57 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2076.outbound.protection.outlook.com [40.107.100.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CB56010E4D7
 for <amd-gfx@lists.freedesktop.org>; Wed,  2 Nov 2022 16:02:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=afhbyUGX4zuXlIiJWG8S6SI/MvFktP6xhleQQd0j0IfQ4mFsMXzU6zdz5FE800rHt/a3xzzMABFqeOpE/QXrP2SCfXhKQ8Aes7ugqKHfq0w5HkseyhSI7BaQ1+FY7hqMdTFxal+ABwVgII2SbuyNdrG4bS4Llg96iDlxz+dDksJw7K/ielzpyjOwbDm74syaD/aLHTQFrXLW40m4oiLEpsEaQrauB9XMZEv3lRpZwXn9EKxBzywmbqjWJJHb3BRYbuE6/cxLArw0+ORAgzoDQgTdyz/BWa819WcaAlYevGm10lVl+9se6i1jm5R4yYbSaD1cSev2K86Abc5fjiepoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+RYgb8jbGJavEcBorEFDli5p8NZcNiHZ2RStUDxrEQc=;
 b=GKh1mxYrXUHXvrgSso9vRyyohGJ6Ici34oTKdRdtBSexejjd30yPpptTZHd1lkGXm/TZJPIn5JFvHVIS7E9pNdgKYpSIvRwnlxwy42jXHcwDjet6MYEAl3Lsxpgr7l1cN4zYUdPmoGgOn3wNHUVPpUIHUZcsfgPjKYIwNlRqvxwGqc6JvhB+TefiT7wSn9ME145CSxjy1f12mYp84UoAqI+6anUIe+Ye6+9jAjmwaOzyocXCi0F5spWJkehhcQiy0jlBU95T/Kr5LSCxq03X/PEhYBAH1SMCc6WFmMGNcH4lu3T0s132nn0jfYSR+V2xjiLsHxf6w5ZuKECcGS9+XA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+RYgb8jbGJavEcBorEFDli5p8NZcNiHZ2RStUDxrEQc=;
 b=cXmYbRVgAwqVxc0VCbxWAQUrIQh7ISv4k7Te3dD1ajyMzYFN6w0NbjgjGah0YKDiBxmiBGT+sLcUtT8GN518jW84agCuz9d0j0Qp6TzYD+cmeo5m2z9J76baWd7MUU1Ea1xw2XdBXX794fp0MzWg4h0peI5ACjHfGl0DK3Fj1eQ=
Received: from DS7PR03CA0144.namprd03.prod.outlook.com (2603:10b6:5:3b4::29)
 by DS7PR12MB6143.namprd12.prod.outlook.com (2603:10b6:8:99::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.19; Wed, 2 Nov
 2022 16:02:53 +0000
Received: from DM6NAM11FT107.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3b4:cafe::34) by DS7PR03CA0144.outlook.office365.com
 (2603:10b6:5:3b4::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.19 via Frontend
 Transport; Wed, 2 Nov 2022 16:02:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT107.mail.protection.outlook.com (10.13.172.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5791.20 via Frontend Transport; Wed, 2 Nov 2022 16:02:52 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Wed, 2 Nov
 2022 11:02:51 -0500
Received: from alan-new-dev.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2375.31 via Frontend
 Transport; Wed, 2 Nov 2022 11:02:48 -0500
From: Alan Liu <HaoPing.Liu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 00/22] DC Patches Nov 2, 2022
Date: Thu, 3 Nov 2022 00:00:55 +0800
Message-ID: <20221102160117.506511-1-HaoPing.Liu@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT107:EE_|DS7PR12MB6143:EE_
X-MS-Office365-Filtering-Correlation-Id: a874ccd4-0c42-43ae-6670-08dabcebb2cc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MEH7YPOllylgu48c8Mk4ElxUip0XL98iaqFR+QqmmDgSXoOMipYUXZfshW/o7We1vLlL0z4FFUPvpOimZFjVasqyXCIfsjxNwbP+lNCcM8LbUceBg/HDG75637UksAmgDXC0cOIuJzI12m9Mv+7MO2fVuHptixqyuRNB3q9k3OKdxMEbgE6TngYEmlQbu6qKhtVsG99rhefoHuNMo7UtQkq1/xkCC7q8pgzoqI4ESeP5aKsoLndJIHtsdq5XItGRGauaYrC257U1o0+ym7JnwVMSCBwAlqXD4KXhRXh/0oBr9hIfPJ8W/JlVK93JoiLA7onO7Pc8THw8Nhn8ciHmnt1Re88XWIrYPIY2btbrHOrxO09Wq0+Ter4fUyuryUUwhjLVocdfOvXRL0S62Rg2z3z6KJ+Xihy4K/iWpuMfMXpWT5siU1C17zD97/cJouehdHoeK3aX+yGWA7p4SpGRjy2cbAK3i/ReINJJ6LXBQiV+hhoVGevkJqwMzgKM4shUAIWUhI+2edaotIVnc+tvlrEmT/LkQb2s3aICOJHaKpCMGllTN9tusSALnz4ZJI+QncV6TBCwpt4JKjewM+hfxsFEgK+rI8Ogwnu/MfJEr9wX1JVFULQkyAfZ/fQ+maTtDK8ewDYku4YsPsupmcYcO1m9hWYLvoj7ILsAC4tFIJtQeyUGmoOblOxOStv1qtO7M+dtHtSUS5IHvrMCSS0Bz/EO4sNMdsNvsT6/M1GnrKRoOFbWd6iw1sP813UkXpuiRnfEW9g3mEahvL0J4b9FnYsS4IYErweG4UA9xqsAzDAjCS+tKktwDB16YRiqhLst
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(39860400002)(346002)(396003)(136003)(376002)(451199015)(36840700001)(40470700004)(46966006)(40480700001)(36756003)(70586007)(26005)(70206006)(47076005)(186003)(336012)(426003)(83380400001)(1076003)(8936002)(41300700001)(81166007)(2906002)(2616005)(356005)(478600001)(6916009)(82310400005)(316002)(86362001)(36860700001)(4326008)(8676002)(54906003)(5660300002)(82740400003)(7696005)(40460700003)(6666004)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2022 16:02:52.6141 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a874ccd4-0c42-43ae-6670-08dabcebb2cc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT107.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6143
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
Cc: stylon.wang@amd.com, Alan Liu <HaoPing.Liu@amd.com>, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 roman.li@amd.com, solomon.chiu@amd.com, Aurabindo.Pillai@amd.com,
 wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com,
 pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This DC patchset brings improvements in multiple areas. In summary, we have:

    - Wait for VBLANK during pipe programming
    - Adding HDMI SCDC DEVICE_ID define
    - Cursor update refactor: PSR-SU support condition
    - Update 709 gamma to 2.222 as stated in the standerd
    - Consider dp cable id only when data is non zero
    - Waiting for 1 frame to fix the flash issue on PSR1
    - Update SR watermarks for DCN314
    - Allow tuning DCN314 bounding box
    - Zeromem mypipe heap struct before using it
    - Use min transition for SubVP into MPO
    - Disable phantom OTG after enable for plane disable
    - Disable DRR actions during state commit
    - Fix fallback issues for DP LL 1.4a tests
    - Fix FCLK deviation and tool compile issues
    - Fix reg timeout in enc314_enable_fifo
    - Fix gpio port mapping issue
    - Only update link settings after successful MST link train
    - Enforce minimum prefetch time for low memclk on DCN32
    - Set correct EOTF and Gamut flag in VRR info
    - Add margin for max vblank time for SubVP + DRR
    - Populate DP2.0 output type for DML pipe

Below are the authors of each patch:

Alvin Lee (4):
  drm/amd/display: Wait for VBLANK during pipe programming
  drm/amd/display: Use min transition for SubVP into MPO
  drm/amd/display: Disable phantom OTG after enable for plane disable
  drm/amd/display: Add margin for max vblank time for SubVP + DRR

Aric Cyr (1):
  drm/amd/display: 3.2.211

Aurabindo Pillai (1):
  drm/amd/display: Zeromem mypipe heap struct before using it

Chaitanya Dhere (1):
  drm/amd/display: Fix FCLK deviation and tool compile issues

Dillon Varone (1):
  drm/amd/display: Enforce minimum prefetch time for low memclk on DCN32

George Shen (1):
  drm/amd/display: Populate DP2.0 output type for DML pipe

Leo Ma (1):
  drm/amd/display: Adding HDMI SCDC DEVICE_ID define

Max Tseng (1):
  drm/amd/display: Cursor update refactor: PSR-SU support condition

Michael Strauss (1):
  drm/amd/display: Only update link settings after successful MST link
    train

Mike Hsieh (1):
  drm/amd/display: Set correct EOTF and Gamut flag in VRR info

Mustapha Ghaddar (1):
  drm/amd/display: Fix fallback issues for DP LL 1.4a tests

Nawwar Ali (1):
  drm/amd/display: Update 709 gamma to 2.222 as stated in the standerd

Nicholas Kazlauskas (3):
  drm/amd/display: Update SR watermarks for DCN314
  drm/amd/display: Allow tuning DCN314 bounding box
  drm/amd/display: Fix reg timeout in enc314_enable_fifo

Ryan Lin (1):
  drm/amd/display: Waiting for 1 frame to fix the flash issue on PSR1

Steve Su (1):
  drm/amd/display: Fix gpio port mapping issue

Wenjing Liu (1):
  drm/amd/display: Consider dp cable id only when data is non zero

Wesley Chalmers (1):
  drm/amd/display: Disable DRR actions during state commit

 .../amd/display/amdgpu_dm/amdgpu_dm_helpers.c |  8 +++
 .../dc/clk_mgr/dcn314/dcn314_clk_mgr.c        | 32 +++++-----
 drivers/gpu/drm/amd/display/dc/core/dc.c      | 55 ++++++++++-------
 drivers/gpu/drm/amd/display/dc/core/dc_link.c |  4 ++
 .../gpu/drm/amd/display/dc/core/dc_link_ddc.c |  1 +
 .../gpu/drm/amd/display/dc/core/dc_link_dp.c  | 51 +++++++++++++---
 .../drm/amd/display/dc/core/dc_link_dpia.c    | 15 +++--
 drivers/gpu/drm/amd/display/dc/dc.h           |  4 +-
 drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c  | 60 ++++++++++++++++++-
 drivers/gpu/drm/amd/display/dc/dc_link.h      |  1 +
 drivers/gpu/drm/amd/display/dc/dce/dmub_psr.c |  5 ++
 .../drm/amd/display/dc/dcn20/dcn20_hwseq.c    |  1 +
 .../drm/amd/display/dc/dcn30/dcn30_hwseq.c    |  3 -
 .../dc/dcn314/dcn314_dio_stream_encoder.c     | 24 ++++++--
 .../gpu/drm/amd/display/dc/dcn32/dcn32_optc.c |  8 +++
 .../drm/amd/display/dc/dcn32/dcn32_resource.c |  2 +
 .../amd/display/dc/dcn321/dcn321_resource.c   |  2 +
 drivers/gpu/drm/amd/display/dc/dm_helpers.h   |  5 ++
 .../drm/amd/display/dc/dml/dcn20/dcn20_fpu.c  |  2 +
 .../amd/display/dc/dml/dcn314/dcn314_fpu.c    | 11 ++--
 .../drm/amd/display/dc/dml/dcn32/dcn32_fpu.c  |  2 +
 .../dc/dml/dcn32/display_mode_vba_32.c        |  5 ++
 .../dc/dml/dcn32/display_mode_vba_32.h        |  3 +
 .../dc/dml/dcn32/display_mode_vba_util_32.c   | 14 ++++-
 .../dc/dml/dcn32/display_mode_vba_util_32.h   |  3 +-
 .../amd/display/dc/dml/dcn321/dcn321_fpu.c    |  2 +
 .../amd/display/dc/dml/display_mode_structs.h |  1 +
 .../display/dc/gpio/dcn32/hw_factory_dcn32.c  | 14 +++++
 drivers/gpu/drm/amd/display/dc/gpio/hw_ddc.c  |  9 ++-
 .../amd/display/dc/inc/hw/timing_generator.h  |  1 +
 .../gpu/drm/amd/display/dmub/inc/dmub_cmd.h   |  6 +-
 .../amd/display/modules/color/color_gamma.c   |  2 +-
 .../amd/display/modules/freesync/freesync.c   |  8 +--
 33 files changed, 279 insertions(+), 85 deletions(-)

-- 
2.25.1

