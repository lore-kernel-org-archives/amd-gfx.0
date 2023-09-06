Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19BD7EB8FC0
	for <amd-gfx@archiver.kernel.org>; Wed,  6 Sep 2023 12:49:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 97D0410E61F;
	Wed,  6 Sep 2023 12:49:08 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2063.outbound.protection.outlook.com [40.107.243.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 022CF10E61F
 for <amd-gfx@lists.freedesktop.org>; Wed,  6 Sep 2023 12:49:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FBBRTNOUnLDUY9zJMxVh27S88XXEEf1K5nqbDmpZPm84VJd0tQyYIDB5MJ5U3fIRyHbguCWjDBLwvgQn0jRBy+8bdRzYWFNcLzZbXOcmSrBsFNwypmaG1HAKrrx20Gf5P5NZvydfxlGGYBdq9gBZdMO1I2S+7xoDYLCSaWup219z0iu0a1Oa1Rj3R1oM9YfXoW3Oi23ZWMyxgfoobpGEf99HZ2IAddLuWjehTiouP6pRn6ftprVW2qy99T4s06PxEMTiqtHUoNml7TbkYGN1eHrpBs8OtXIk6DaTnQIpaP58inkD9xpMV3uDss/TLGXYKzsu6RHgupWyt7Q/oOaIDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IYaVfSvf/TtfyjgjasKX9FzYc/NEjs25UByWpfrcW7o=;
 b=k6y5TG0MuN6qaYVgW2FZFQhHzSCh84Az7RPJSf/gs3BYfhCKqBXfP45sdIHdwi7zr7n4Pm/GD3fWICU+HnbSJM9p6rBfITreYVjyjBiK02C18htJPg9w4lq+T8bAHvjpmItS2se1uRlX9GaVVDJmBpJdHFWg1WXD7gT/5fVrk0fgZVo6+01cm5CuLmELBABWnq2V+4FL1TqDX9XUuDOKtlj7iHXIN/OPaTCL4mkeMu7ySlx8lCv4KpYcmSAGmXvVbsYU5b+cl0b2V8y0Ckr78Nnv2ua9PVxRL6fES6BLCBEtiz8b7esTPsvib7dvyu1vuOuo9w0LX+0fZE0PbLBRkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IYaVfSvf/TtfyjgjasKX9FzYc/NEjs25UByWpfrcW7o=;
 b=Nnskizy33MLkTsZ+PChqb76EWU7OeKtRo8FQBErtj9njZXkEfSuZ4xUPAee2AuXT5mJsvwR47Mf5HdcMSY5tGW+gwe/IV/CjcXKNlS8LXg6Ku/0ntctH7+hCtwmkx32BS5LoHansJmAZrPC+aviXfzgu1b9ElhjrehCo9HYXczA=
Received: from CYXPR02CA0004.namprd02.prod.outlook.com (2603:10b6:930:cf::7)
 by MN0PR12MB6150.namprd12.prod.outlook.com (2603:10b6:208:3c6::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.33; Wed, 6 Sep
 2023 12:49:04 +0000
Received: from CY4PEPF0000EDD5.namprd03.prod.outlook.com
 (2603:10b6:930:cf:cafe::cf) by CYXPR02CA0004.outlook.office365.com
 (2603:10b6:930:cf::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.36 via Frontend
 Transport; Wed, 6 Sep 2023 12:49:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EDD5.mail.protection.outlook.com (10.167.241.209) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6768.25 via Frontend Transport; Wed, 6 Sep 2023 12:49:03 +0000
Received: from stylon-EliteDesk.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 6 Sep
 2023 07:48:59 -0500
From: Stylon Wang <stylon.wang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 00/28] DC Patches Sep 8, 2023
Date: Wed, 6 Sep 2023 20:28:05 +0800
Message-ID: <20230906124915.586250-1-stylon.wang@amd.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD5:EE_|MN0PR12MB6150:EE_
X-MS-Office365-Filtering-Correlation-Id: 84b659d5-20fd-49c9-af45-08dbaed7a65e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6e98ePKebXLQjhBFBz9Qv+51X5ytDaQlMbmzXGCoK4FK3HGU28KPrC151L3tJg3lWjesG/P+mfQRxjldR0ZO3caIWf9D9CNzs1uQoOJ4M1p6x1WLrWBx2lmzpVyMmjnhLaeEckQeOvnmeZ2V3C/5jWUoT6wX3cz1NJWPn3DqMQBGWx9iau0HnurUf1Kzs3RkiC8MQxBlCxlbA0Duots9WmMZKqRALIh0SEQcCFqJPi3UetAMPTNCDr2NAGiXAcLyIcZuCXeTiFLgptHmRh1vqli0RQKd7PJK9+oFkrOwxrhQWbhU5jfA1Yz51Bh8h8Z1MM6dY14wio9pQxGhTxrGVhKiDrHdxW+URrasfbBdr+vYlkGPKyckKLU+btKmlKSjvlsDavCvPJcqRt1OZi5rNTM0nWJhJLQhrOOYUOdMfwhQVN8OJ5q0LMavRbrMw5R0s3RCmjmLQSdjfXmf4y+AD4f84EmabUirI5oRw8q8z5hoiF40tMS0OuRHFDBbqahBUha6SHUox21ARd+oDmcMWGoF6yoOE9oTjs+r7RVogqcPaezxwb5vp8oJXbWzlLxZ7olGQWH3s0lbhoi8KPHZ8Iai5Rtyvm6XGKYPq1HJiDpOdHQZDPB0ePAyjoX8plOnEcfu/HXU7Fa4kq9SZPKaWYdEFsAIKlNX61Vugnw2cqXU9/9dnkYDLlc5eRObEID6dCCmdYDuso69hc+OzQ2YvkFTxU2R+yrO2dNNq7pJENaK8Qu/DTVsxwAJ9yqX0a/UuGCssZ1mxS+SrmLAU1N7FA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(346002)(396003)(376002)(39860400002)(136003)(186009)(1800799009)(82310400011)(451199024)(36840700001)(40470700004)(46966006)(83380400001)(40460700003)(426003)(336012)(36756003)(81166007)(356005)(2906002)(36860700001)(47076005)(70206006)(82740400003)(40480700001)(316002)(41300700001)(6916009)(54906003)(70586007)(86362001)(5660300002)(6666004)(478600001)(7696005)(8676002)(4326008)(8936002)(2616005)(1076003)(44832011)(26005)(16526019)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Sep 2023 12:49:03.4388 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 84b659d5-20fd-49c9-af45-08dbaed7a65e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EDD5.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6150
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
 solomon.chiu@amd.com, Daniel Wheeler <daniel.wheeler@amd.com>,
 Aurabindo.Pillai@amd.com, wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com,
 agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This DC patchset brings improvements in multiple areas. In summary, we have:
- Fix MST bugs
- Fix ODM combine debugfs
- Fix DML calculations
- Fix 2nd DPIA encoder issue
- Fix AUX-based backlight control
- Fix on MPO+ODM use case
- Fix DCCG clock programming
- Improvements on replay
- Improvements on logging and reporting
- Improvements on pipe and OTG handling
- Improvements and bug fixes on power optimization
- Improvements on VRR
- Code clean up and fix un-initialized values

Cc: Daniel Wheeler <daniel.wheeler@amd.com>

Alvin Lee (2):
  drm/amd/display: Blank phantom OTG before enabling
  drm/amd/display: Don't lock phantom pipe on disabling

Anthony Koo (1):
  drm/amd/display: [FW Promotion] Release 0.0.181.0

Aric Cyr (1):
  drm/amd/display: 3.2.250

Aurabindo Pillai (2):
  drm/amd/display: set default return value for ODM Combine debugfs
  drm/amd/display: Add DCHUBBUB callback to report MALL status

Austin Zheng (1):
  drm/amd/display: Add check for vrr_active_fixed

Bhawanpreet Lakha (1):
  drm/amd/display: Add dirty rect support for Replay

Charlene Liu (1):
  drm/amd/display: fix some non-initialized register mask and setting

Dillon Varone (1):
  drm/amd/display: add dp dto programming function to dccg

Ethan Bitnun (1):
  drm/amd/display: Add new logs for AutoDPMTest

Ian Chen (1):
  drm/amd/display: add skip_implict_edp_power_control flag for dcn32

Muhammad Ahmed (1):
  drm/amd/display: Fix MST recognizes connected displays as one

Mustapha Ghaddar (1):
  drm/amd/display: Fix 2nd DPIA encoder Assignment

Nicholas Susanto (1):
  drm/amd/display: Fix DML calculation errors

Paul Hsieh (1):
  drm/amd/display: support main link off before specific vertical line

Qingqing Zhuo (1):
  drm/amd/display: Drop unused registers

Sridevi Arvindekar (1):
  drm/amd/display: dc cleanup for tests

Swapnil Patel (1):
  drm/amd/display: Don't check registers, if using AUX BL control

Wayne Lin (1):
  drm/amd/display: Adjust the MST resume flow

Wenjing Liu (8):
  drm/amd/display: do not block ODM + OPM on one side of the screen
  drm/amd/display: remove a function that does complex calculation in
    every frame but not used
  drm/amd/display: do not attempt ODM power optimization if minimal
    transition doesn't exist
  drm/amd/display: only allow ODM power optimization if surface is
    within guaranteed viewport size
  drm/amd/display: do not skip ODM minimal transition based on new state
  drm/amd/display: minior logging improvements
  drm/amd/display: add seamless pipe topology transition check
  drm/amd/display: move odm power optimization decision after subvp
    optimization

 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |  96 ++-
 .../amd/display/amdgpu_dm/amdgpu_dm_debugfs.c |  15 +-
 .../display/dc/clk_mgr/dcn32/dcn32_clk_mgr.c  |  64 ++
 drivers/gpu/drm/amd/display/dc/core/dc.c      | 107 ++--
 .../drm/amd/display/dc/core/dc_link_enc_cfg.c |   4 +-
 .../gpu/drm/amd/display/dc/core/dc_resource.c |   7 -
 drivers/gpu/drm/amd/display/dc/dc.h           |   3 +-
 drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c  |   4 +-
 .../drm/amd/display/dc/dce/dce_clock_source.c |   1 +
 drivers/gpu/drm/amd/display/dc/dce/dmub_psr.c |  10 +-
 .../display/dc/dce110/dce110_hw_sequencer.c   |  34 +-
 .../drm/amd/display/dc/dcn10/dcn10_hubbub.h   |   5 +-
 .../amd/display/dc/dcn10/dcn10_hw_sequencer.c |   3 +-
 .../display/dc/dcn10/dcn10_stream_encoder.h   |   5 +-
 .../drm/amd/display/dc/dcn20/dcn20_hwseq.c    |  20 +-
 .../drm/amd/display/dc/dcn32/dcn32_hubbub.c   |  14 +-
 .../drm/amd/display/dc/dcn32/dcn32_hubbub.h   |   6 +-
 .../drm/amd/display/dc/dcn32/dcn32_hwseq.c    | 104 ++-
 .../drm/amd/display/dc/dcn32/dcn32_hwseq.h    |   9 +
 .../gpu/drm/amd/display/dc/dcn32/dcn32_init.c |   2 +
 .../gpu/drm/amd/display/dc/dcn32/dcn32_mpc.c  |   2 +-
 .../drm/amd/display/dc/dcn32/dcn32_resource.c |  79 +--
 .../drm/amd/display/dc/dcn32/dcn32_resource.h |   1 +
 .../display/dc/dcn32/dcn32_resource_helpers.c |   4 +-
 .../drm/amd/display/dc/dcn35/dcn35_hubbub.h   |   2 -
 .../dc/dml/dcn314/display_mode_vba_314.c      |   2 +
 .../drm/amd/display/dc/dml/dcn32/dcn32_fpu.c  | 601 ++++++++++--------
 .../drm/amd/display/dc/dml/dcn32/dcn32_fpu.h  |   3 -
 .../gpu/drm/amd/display/dc/inc/hw/clk_mgr.h   |   6 +-
 .../amd/display/dc/inc/hw/clk_mgr_internal.h  |  16 +-
 drivers/gpu/drm/amd/display/dc/inc/hw/dccg.h  |  10 +
 .../gpu/drm/amd/display/dc/inc/hw/dchubbub.h  |   1 +
 .../gpu/drm/amd/display/dc/inc/hw_sequencer.h |   8 +
 .../gpu/drm/amd/display/dc/link/link_dpms.c   |  10 +-
 .../gpu/drm/amd/display/dmub/inc/dmub_cmd.h   |   6 +-
 .../amd/display/include/ddc_service_types.h   |   1 +
 .../drm/amd/display/include/logger_types.h    |   5 +-
 37 files changed, 793 insertions(+), 477 deletions(-)

-- 
2.42.0

