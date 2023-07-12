Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83DC5EB64DA
	for <amd-gfx@archiver.kernel.org>; Wed, 12 Jul 2023 17:12:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 19CFC10E599;
	Wed, 12 Jul 2023 17:12:08 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 638D510E599
 for <amd-gfx@lists.freedesktop.org>; Wed, 12 Jul 2023 17:12:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jbC0U6RQYbOSl6lE8vb3xjGt0uWL6FZTOUtBVmh+2dxv3bEeXWdTu6dKmLSiYWX47SGeAG9k4VosTCu325L6cZT8euKb8V+RJxgLyDBtjkkm2oECRyMs+4YtxiIYXVq23ef9QrnNwth9jxwD42meg7idZZPnW93sPaTIvd0SY5Wysrs9hL3hVRCp+QTq7GH5Bol7xi/Cgh/dQ/mn/jx6R47REjOz7swyaBAHb5qV9EoRqj8iVDmqRK44wel+FIg3QDGQQR4j2vO1R0OsdQGmgwhmQ13jWTm6SlyTF+nTcAHCrIDrtxiRjeQn+e19SQRL9wboqDfRJD2eSkN+VwqGhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8NQ4KH1eoVmaeVDWwXm2onsAiUIJPtGs8+A4V8oFHzw=;
 b=QiuGc4zG7YCRSVZL+kkJO55/BacFiHcprpLbCHbnY5C7LVGsj5ZmCOl2LGBWhO05TuL0qrfOOSMhM+eCfZjNBnQcmG6kUbaymoEfny/oUu5BRJtVOZgRII1qiYDQqmoV5epe1CvUiEutwQoJIzH2CnxWsYPY4QaWBDKEB9tz6kzR45f5moHpZjHxi0nLR9SZrSJk4Ebt3VzW3ZpPXrxZv3VQLNPjqDAMv4Y4xZlhB0QCqxwd7VGMalSVGP3jT/JNZC59mPtm/h/SclztrKXs0reHjlkkxFBlf6Ee/72sZ4fdanwODlv0YSmXqtD/rGHCJrMlx6Fx5MPs51XYqT33Dg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8NQ4KH1eoVmaeVDWwXm2onsAiUIJPtGs8+A4V8oFHzw=;
 b=QqkO8fIg9c1oN86fx8F2S86/mPzgLfksa1+smWEpM6tKlq5BNz9P3twydOVCwHBgnJxsXzkXbP5RGpkuxppVqRYXjNB5ji5W4+9ah7ZRrWWFx473BdA51RZs3LptH+mv2XOMl/sMGl27YdMYrbDqUPV2ANu82mlJNSQgAU/1Jv0=
Received: from BN0PR03CA0024.namprd03.prod.outlook.com (2603:10b6:408:e6::29)
 by CH3PR12MB8330.namprd12.prod.outlook.com (2603:10b6:610:12c::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.22; Wed, 12 Jul
 2023 17:12:03 +0000
Received: from BN8NAM11FT031.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e6:cafe::44) by BN0PR03CA0024.outlook.office365.com
 (2603:10b6:408:e6::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.20 via Frontend
 Transport; Wed, 12 Jul 2023 17:12:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN8NAM11FT031.mail.protection.outlook.com (10.13.177.25) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6588.22 via Frontend Transport; Wed, 12 Jul 2023 17:12:02 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Wed, 12 Jul
 2023 12:11:57 -0500
Received: from alan-new-dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.23 via Frontend
 Transport; Wed, 12 Jul 2023 12:11:54 -0500
From: Alan Liu <HaoPing.Liu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 00/33] DC Patches July 12, 2023
Date: Thu, 13 Jul 2023 01:11:04 +0800
Message-ID: <20230712171137.3398344-1-HaoPing.Liu@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT031:EE_|CH3PR12MB8330:EE_
X-MS-Office365-Filtering-Correlation-Id: 934aaac0-9df2-441a-1b04-08db82fb1c6b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CDfSOiRGPCn1gh+LWpu3H0DdNgyyVLVeWJhP28c90GKex2Vx0PXRhS5OJCsLSF/geqKga4Jz4qvY1E7yXJOmV0qTx36wb+Mh3dE7r03UP0D/yCCdYPeslfDNz/SuWNT5K3pdNpxX9Ny8GhHVOyQLJp6hFkldly3axLt2yDDbdNXGysr85ur91Zsq5m2sw6eiX0rgDr+1Y67oG9V/sAlfvMY2U242HBHJD3dv69LAktHsQHJDPTlMq1NINc2YDyx8HGiKdcukL+2ktfmSlXjKH33XtmrK6TMMkMebxkOoFH+ZJ4w45dfUpF6P9hsQB9QwC6iwZQHYlQVSGBLJ3R6sm+VRERFmc72YR/FYh+hou+akWOP5T8sFrvxbA1hbCfsrd5O4rA5hSH7OsmJGEqT9cf37UpDRR1HzA2aQDjLeUdmQMSl9bYbzh6ovMOKonj4S6qrzy+cvdIcclm0MXX1phZ8Lo6YVwc/hfThYcM6aC2GYd6+kFy0SLBINPm23mNSEhyPNE3GaEN0t/PlbNMl0bthC6F2FRLOORwOLcXKnu+8ghyCW363VrgxMx0caBHjl3aSypjkFdGcCYY6umtoexlGXnuyBdkJWG+IAJDymXfc7hL622gEmiPknhOqb+7Y5HIyzezbiBeR8oALYQopIAphVI5siivjdCzXkGUd3fqT3Ljh4KJ1Q64Jc7m8IjAX3UDbiLuHUqx76xIC+YB/trstwIXc57G00RzgezsMNHQY/+4jeJaoQJeU4XvgNSp1Sd1BoNW9YMhQo4djb6B0cKw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(136003)(39860400002)(396003)(346002)(451199021)(40470700004)(36840700001)(46966006)(6666004)(7696005)(478600001)(54906003)(186003)(26005)(1076003)(82310400005)(70206006)(2906002)(41300700001)(4326008)(6916009)(316002)(5660300002)(70586007)(8936002)(8676002)(82740400003)(356005)(81166007)(40460700003)(86362001)(36756003)(36860700001)(47076005)(426003)(336012)(2616005)(83380400001)(40480700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2023 17:12:02.7771 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 934aaac0-9df2-441a-1b04-08db82fb1c6b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT031.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8330
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
 roman.li@amd.com, solomon.chiu@amd.com,
 Daniel Wheeler <daniel.wheeler@amd.com>, Aurabindo.Pillai@amd.com,
 wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com,
 pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This DC patchset brings improvements in multiple areas. In summary, we have:

* Setup stream encoder before link enable for TMDS
* Use is_dig_enable function instead of dcn10 hardcode
* Re-add aux intercept disable delay generically for 2+ LTTPRs
* Add polling method to handle MST reply packet
* Improve the include of header file
* Remove unused function
* Add missing static
* Hardcode vco_freq for dcn316
* Reduce stack size
* Skip enabling DMCUB when using emulation
* check TG is non-null before checking if enabled
* Update scaler recout data for visual confirm
* Skip querying caps when DMCUB emulation is in use
* Update 128b/132b downspread factor to 0.3%
* Add helpers to get DMUB FW boot options
* Initialize necessary uninitialized variables
* Add stream overhead in BW calculations for 128b/132b
* Add link encoding to timing BW calculation parameters
* Prevent vtotal from being set to 0
* Fix race condition when turning off an output alone
* Keep PHY active for DP displays on DCN31
* Fix ASIC check in aux timeout workaround
* ABM pause toggle
* Add missing triggers for full updates
* Disable MPC split by default on special asic
* add additional refresh rate conditions for SubVP cases
* Fix DP2 link training failure with RCO
* Reenable all root clock gating options
* Cache backlight_millinits in link structure and setting brightness accordingly
* refine to decide the verified link setting
* Update SW cursor fallback for subvp high refresh

Cc: Daniel Wheeler <daniel.wheeler@amd.com>

Alan Liu (2):
  drm/amd/display: Hardcode vco_freq for dcn316
  drm/amd/display: Fix race condition when turning off an output alone

Alvin Lee (2):
  drm/amd/display: Add missing triggers for full updates
  drm/amd/display: Update SW cursor fallback for subvp high refresh

Aric Cyr (2):
  drm/amd/display: Promote DAL to 3.2.242
  drm/amd/display: Promote DAL to 3.2.243

Cruise Hung (1):
  drm/amd/display: Add helpers to get DMUB FW boot options

Daniel Miess (3):
  drm/amd/display: Prevent vtotal from being set to 0
  drm/amd/display: Fix DP2 link training failure with RCO
  drm/amd/display: Reenable all root clock gating options

George Shen (3):
  drm/amd/display: Update 128b/132b downspread factor to 0.3%
  drm/amd/display: Add stream overhead in BW calculations for 128b/132b
  drm/amd/display: Add link encoding to timing BW calculation parameters

JinZe Xu (1):
  drm/amd/display: Setup stream encoder before link enable for TMDS

Leo Ma (1):
  drm/amd/display: Update scaler recout data for visual confirm

Meera Patel (1):
  drm/amd/display: Initialize necessary uninitialized variables

Michael Strauss (1):
  drm/amd/display: Re-add aux intercept disable delay generically for 2+
    LTTPRs

Nicholas Kazlauskas (3):
  drm/amd/display: Use is_dig_enable function instead of dcn10 hardcode
  drm/amd/display: Skip querying caps when DMCUB emulation is in use
  drm/amd/display: Keep PHY active for DP displays on DCN31

Nicholas Susanto (1):
  drm/amd/display: Cache backlight_millinits in link structure and
    setting brightness accordingly

Reza Amini (1):
  drm/amd/display: ABM pause toggle

Rodrigo Siqueira (4):
  drm/amd/display: Improve the include of header file
  drm/amd/display: Remove unused function
  drm/amd/display: Add missing static
  drm/amd/display: Reduce stack size

Samson Tam (1):
  drm/amd/display: add additional refresh rate conditions for SubVP
    cases

Taimur Hassan (3):
  drm/amd/display: Skip enabling DMCUB when using emulation
  drm/amd/display: check TG is non-null before checking if enabled
  drm/amd/display: Fix ASIC check in aux timeout workaround

Wayne Lin (1):
  drm/amd/display: Add polling method to handle MST reply packet

Zhikai Zhai (2):
  drm/amd/display: Disable MPC split by default on special asic
  drm/amd/display: refine to decide the verified link setting

 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 244 +++++++-----------
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h |   7 +
 .../display/amdgpu_dm/amdgpu_dm_mst_types.c   | 124 ++++++++-
 .../display/amdgpu_dm/amdgpu_dm_mst_types.h   |  11 +
 .../drm/amd/display/dc/basics/conversion.c    |   2 +-
 .../gpu/drm/amd/display/dc/basics/vector.c    |  11 +-
 .../gpu/drm/amd/display/dc/bios/bios_parser.c |  16 +-
 .../drm/amd/display/dc/bios/bios_parser2.c    |  20 +-
 .../display/dc/clk_mgr/dcn31/dcn31_clk_mgr.c  |   5 +
 .../dc/clk_mgr/dcn316/dcn316_clk_mgr.c        |  44 +---
 .../display/dc/clk_mgr/dcn32/dcn32_clk_mgr.c  |   2 +-
 drivers/gpu/drm/amd/display/dc/core/dc.c      |  94 +++++--
 .../drm/amd/display/dc/core/dc_hw_sequencer.c |   1 +
 .../drm/amd/display/dc/core/dc_link_exports.c |  18 ++
 .../gpu/drm/amd/display/dc/core/dc_resource.c |  22 ++
 .../gpu/drm/amd/display/dc/core/dc_stream.c   |  35 ++-
 drivers/gpu/drm/amd/display/dc/dc.h           |  25 +-
 drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c  |   3 +
 drivers/gpu/drm/amd/display/dc/dc_dsc.h       |   2 +
 drivers/gpu/drm/amd/display/dc/dc_types.h     |  15 +-
 drivers/gpu/drm/amd/display/dc/dce/dce_dmcu.c |   6 +-
 .../gpu/drm/amd/display/dc/dce/dce_i2c_hw.c   |  16 +-
 .../gpu/drm/amd/display/dc/dce/dce_i2c_sw.c   |  16 +-
 drivers/gpu/drm/amd/display/dc/dce/dmub_abm.c |  28 ++
 .../gpu/drm/amd/display/dc/dce/dmub_abm_lcd.c |  46 ++++
 .../gpu/drm/amd/display/dc/dce/dmub_abm_lcd.h |   6 +
 .../drm/amd/display/dc/dce80/dce80_resource.c |   4 +-
 .../drm/amd/display/dc/dcn10/dcn10_dpp_dscl.c |  18 +-
 .../amd/display/dc/dcn10/dcn10_hw_sequencer.c |   3 +-
 .../amd/display/dc/dcn10/dcn10_link_encoder.c |   2 +-
 .../gpu/drm/amd/display/dc/dcn21/dcn21_dccg.c |   2 +-
 .../gpu/drm/amd/display/dc/dcn21/dcn21_dccg.h |   1 -
 .../amd/display/dc/dcn303/dcn303_resource.c   |   2 +-
 .../gpu/drm/amd/display/dc/dcn31/dcn31_dccg.c |  49 ++--
 .../gpu/drm/amd/display/dc/dcn31/dcn31_dccg.h |   5 +
 .../display/dc/dcn31/dcn31_dio_link_encoder.c |   2 +-
 .../drm/amd/display/dc/dcn314/dcn314_dccg.c   |   1 +
 .../amd/display/dc/dcn314/dcn314_resource.c   |  18 +-
 .../amd/display/dc/dcn315/dcn315_resource.c   |   2 +-
 .../drm/amd/display/dc/dcn32/dcn32_resource.c |   2 +-
 .../display/dc/dcn32/dcn32_resource_helpers.c |  24 +-
 .../dc/dml/dcn21/display_mode_vba_21.c        |   2 +-
 .../dc/dml/dcn31/display_mode_vba_31.c        |   2 +-
 .../amd/display/dc/dml/dcn314/dcn314_fpu.c    |   6 +-
 .../dc/dml/dcn314/display_mode_vba_314.c      |   2 +-
 .../drm/amd/display/dc/dml/dcn32/dcn32_fpu.c  |  20 +-
 .../dc/dml/dcn32/display_mode_vba_util_32.c   |   2 +-
 drivers/gpu/drm/amd/display/dc/dsc/dc_dsc.c   |  66 ++++-
 drivers/gpu/drm/amd/display/dc/inc/hw/abm.h   |   6 +
 .../drm/amd/display/dc/inc/hw/aux_engine.h    |   2 -
 drivers/gpu/drm/amd/display/dc/inc/hw/dccg.h  |   5 +
 .../dc/irq/dcn314/irq_service_dcn314.c        |   7 +-
 .../display/dc/link/hwss/link_hwss_hpo_dp.c   |  10 +
 .../drm/amd/display/dc/link/link_detection.c  |   3 +-
 .../gpu/drm/amd/display/dc/link/link_dpms.c   |  21 +-
 .../drm/amd/display/dc/link/link_validation.c |   8 +-
 .../amd/display/dc/link/protocols/link_ddc.c  |   2 +-
 .../dc/link/protocols/link_dp_capability.c    |  22 +-
 .../dc/link/protocols/link_dp_training.c      |   9 +-
 .../link_dp_training_fixed_vs_pe_retimer.c    |  25 +-
 .../link/protocols/link_edp_panel_control.c   |  13 +-
 .../link/protocols/link_edp_panel_control.h   |   1 +
 drivers/gpu/drm/amd/display/dmub/dmub_srv.h   |   4 +
 .../gpu/drm/amd/display/dmub/inc/dmub_cmd.h   | 131 ++++++++++
 .../gpu/drm/amd/display/dmub/src/dmub_dcn31.c |   8 +
 .../gpu/drm/amd/display/dmub/src/dmub_dcn31.h |   2 +
 .../gpu/drm/amd/display/dmub/src/dmub_srv.c   |  19 +-
 .../amd/display/include/link_service_types.h  |   2 +-
 68 files changed, 966 insertions(+), 388 deletions(-)

-- 
2.34.1

