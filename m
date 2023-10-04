Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A613E936E7
	for <amd-gfx@archiver.kernel.org>; Wed,  4 Oct 2023 21:21:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1193810E3BC;
	Wed,  4 Oct 2023 21:21:44 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2069.outbound.protection.outlook.com [40.107.96.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2890010E3BB
 for <amd-gfx@lists.freedesktop.org>; Wed,  4 Oct 2023 21:21:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DuyyhIpbrDJKBYrP4FJujY0eQDSkNXXPbiOt+wh8lTh15TW7VGEZCZzYqq8EEoegaCDmTKnjBq3sZmyfxNoJBOVL/qSGM2fWYKQy4Ztwz+5rZg+a+VedNaadwB8otZCvzE+PBhbgvkuUTHWyi+2QmR/xzPcn8P/cqLsknTsSyrP042vcRJYqBA08FMkQ9PmsDHnceijN4K5rocE+UZ2XGGyvSkMGY3aC6mh99tbuGoFZ2D9lT4AITZWriQRLMAFPFL9WmQbFTeBBW8wt1UsX9RKzij7Ne63atgqEiK/TtejzBHkfQEDMFTjeLC0ByNTHPkuuu6Y/ZX2SUeRejvON0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MPGHb9TdO0jOViTZO7bHiougJFKjtBHSiDcgIU5eEUc=;
 b=O/16FpsEgwQ8NHOUJhqBU4ForMkwAS3hSpg4a8qSbLhQ4u9Jj2WOo7X0AeFTlAmfB/qZDUi+v+xosHQhKZ/44jq/lbHAJrHFPfgsBS2r6/Zzm19kHVqgcm5IKSKSdnOxMCNp6Ws/z0ZQaKunkSx/X/l0uo/X7kfPI+m28TONriD4P6Kf9JTyR292cFmtTyNH+QS2GYqkiOrjzC4htmF9Z9pD1vV0PUrXGJZmHoet/AgCTSvFoUWKri43NVI3RZ8WFI7OL84GFomJa2ur+VF1c0YrItWTkqNln0UVGcBDLOlmJ0RLLSKLbl/bpE0+OR329BtHOYeaoEQC72wjg4wGpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MPGHb9TdO0jOViTZO7bHiougJFKjtBHSiDcgIU5eEUc=;
 b=YZEZjIJj9Gv5d8i2IsdarPlwu0vOtxTRZMDvxbZxhG0BZBGvBzc2ebAQg2diluhm5hPk7rF8OMtL6r5WhrfX9mwYAudAApBk2F0E+WB7AJCrkLwkAyVmrrowwbcAr1RpXrF7P0gsp1Q4AVIlWd1Ji7KodYXyHBjoc3nKwfjR5Gs=
Received: from MN2PR11CA0025.namprd11.prod.outlook.com (2603:10b6:208:23b::30)
 by MW4PR12MB5641.namprd12.prod.outlook.com (2603:10b6:303:186::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.23; Wed, 4 Oct
 2023 21:21:38 +0000
Received: from BL02EPF0001A108.namprd05.prod.outlook.com
 (2603:10b6:208:23b:cafe::94) by MN2PR11CA0025.outlook.office365.com
 (2603:10b6:208:23b::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.25 via Frontend
 Transport; Wed, 4 Oct 2023 21:21:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0001A108.mail.protection.outlook.com (10.167.241.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.14 via Frontend Transport; Wed, 4 Oct 2023 21:21:38 +0000
Received: from smtp.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 4 Oct
 2023 16:21:34 -0500
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v3 00/16] Introduce DML version 2
Date: Wed, 4 Oct 2023 15:20:54 -0600
Message-ID: <20231004212110.3753955-1-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A108:EE_|MW4PR12MB5641:EE_
X-MS-Office365-Filtering-Correlation-Id: f0a4c1c7-fb1d-4dd0-0908-08dbc51fe512
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: I2yj8rJpuK7+2ZrDPNL4GFRQTZC1imUUfjOhoEdGVmH+T3GLHZJSa1+7aaXSfuhmBNmrymGcqrionVLUvX743669VCsTeaJQK2Ivn/jRkhTxT8p9+yVrM4xWOlakhwVPSSxlvdpWhtxzggGn1tXSpRmLXqGI7oGIEcpUz6ujP+TPu+0adSps75GF1fR5z/VlXCnuyOuhOIDfhDOuuINGo090gmW2JmF7OQc23JRpzyDxnstNUXy2KafOvt+Teh5gSSigkdsgk4CFlsR3pQaxvCsbfqmfA5dIbaiX2VZfDyfHVrRcBV//vxYhlfWSCQo3F7ovMf/nSO9Ww9MNPP8tFOJtZBzAHwhJ1ksTD3hWaWj6t2MhlWX6soY8EICG5hiLRqBxhnEIAiUzzB2wNaC2RmTPnvYm3xHk5NwiCX8oSba/2/gYS48l2DHx50bhSVZvIVsHW6qdmMO/rmppxcdiy335B6YxnRr9Xb0uzt39efUSe3OMGu3fZpWD3FnTRLgaB0WhUT5/yu+FiNSX35+AHITMsEEdCyjkvrrT3Wj+I0ndw+6d45LXpLeS4iVzKtHghq1Iqqq42SyQKR7aw9p+5ddsVyuaoGuaCVCMaQBLuy4Ez0mVgX1Bo9PUCSYsPX1D8AGTwrbYZB7j2GMIgEFTee21wISl+9Y97ILBb8TaSFez0GOW22EReyQPw9UWIzNGOTNiiChSRKfnrnRnD03OYmqKAcXndBIDBLF3kbrRy6KOpRBVaNk3rM5WvHh2XE5PGmRhWRRerNKUvguwV6ZJKw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(346002)(39860400002)(396003)(136003)(376002)(230922051799003)(451199024)(186009)(82310400011)(1800799009)(64100799003)(46966006)(36840700001)(40470700004)(47076005)(2906002)(83380400001)(40460700003)(81166007)(82740400003)(86362001)(356005)(36756003)(36860700001)(40480700001)(1076003)(16526019)(6666004)(26005)(70586007)(54906003)(70206006)(6916009)(2616005)(5660300002)(41300700001)(4326008)(8936002)(8676002)(478600001)(426003)(316002)(336012)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2023 21:21:38.0410 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f0a4c1c7-fb1d-4dd0-0908-08dbc51fe512
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A108.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB5641
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
Cc: Sunpeng.Li@amd.com, richard.gong@amd.com, qingqing.zhuo@amd.com,
 Rodrigo.Siqueira@amd.com, roman.li@amd.com, jerry.zuo@amd.com,
 Aurabindo.Pillai@amd.com, hamza.mahfooz@amd.com, wayne.lin@amd.com,
 Alex Deucher <alexander.deucher@amd.com>, Harry.Wentland@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This patchset introduces a new version of DML that will be used for some
already available ASIC based on DCN3x and future devices. This new
version of the DML is more reliable, provide a better programming model
for hardware/software, and is more flexible for creating new tools for
automation/validation (e.g., unit test). This first version is a
transition step for new ASICs, meaning that we will keep improving this
new component. Finally, it is important to highlight that a large part
of the DML code is generated.

This patchset starts with a code refactor in the DML to improve the code
isolation and avoid compilation issues when using some 32-bit
architecture such as ARM and PPC. Next, it is introduced the basic code
for DML2. Finally, the end of this patchset enables DML2 for some
specific ASICs followed by patches that improve DML when used with
specific devices.

Thanks
Siqueira

Charlene Liu (2):
  drm/amd/display: Add z8_marks in dml
  drm/amd/display: correct dml2 input and dlg_refclk

Daniel Miess (1):
  drm/amd/display: Port replay vblank logic to DML2

Gabe Teeger (1):
  drm/amd/display: add check in validate_only in dml2

Qingqing Zhuo (2):
  drm/amd/display: Introduce DML2
  drm/amd/display: Add DCN35 DML2 support

Rodrigo Siqueira (4):
  drm/amd/display: Move dce_calcs from DML folder
  drm/amd/display: Move custom_float outside DML
  drm/amd/display: Move bw_fixed outside DML folder
  drm/amd/display: Move dml code under CONFIG_DRM_AMD_DC_FP guard

Saaem Rizvi (1):
  drm/amd/display: Modify Pipe Selection for Policy for ODM

Sung Joon Kim (3):
  drm/amd/display: Handle multiple streams sourcing same surface
  drm/amd/display: Use fixed DET Buffer Size
  drm/amd/display: Fix Chroma Surface height/width initialization

Taimur Hassan (2):
  drm/amd/display: Split pipe for stereo timings
  drm/amd/display: Move stereo timing check to helper

 drivers/gpu/drm/amd/display/dc/Makefile       |     6 +-
 .../gpu/drm/amd/display/dc/basics/Makefile    |     9 +-
 .../dc/{dml/calcs => basics}/bw_fixed.c       |    13 +-
 .../dc/{dml/calcs => basics}/calcs_logger.h   |     0
 .../dc/{dml/calcs => basics}/custom_float.c   |    90 +-
 .../dc/{dml/calcs => basics}/dce_calcs.c      |     0
 drivers/gpu/drm/amd/display/dc/core/dc.c      |    39 +
 .../gpu/drm/amd/display/dc/core/dc_resource.c |    20 +
 drivers/gpu/drm/amd/display/dc/dc.h           |     5 +
 .../drm/amd/display/dc/dcn32/dcn32_resource.c |    61 +-
 .../amd/display/dc/dcn321/dcn321_resource.c   |    41 +
 .../drm/amd/display/dc/dcn35/dcn35_resource.c |    24 +-
 drivers/gpu/drm/amd/display/dc/dml/Makefile   |     2 -
 .../drm/amd/display/dc/dml/dcn32/dcn32_fpu.c  |    80 +
 .../amd/display/dc/dml/dcn321/dcn321_fpu.c    |    81 +
 drivers/gpu/drm/amd/display/dc/dml2/Makefile  |    91 +
 .../gpu/drm/amd/display/dc/dml2/cmntypes.h    |    92 +
 .../amd/display/dc/dml2/display_mode_core.c   | 10296 ++++++++++++++++
 .../amd/display/dc/dml2/display_mode_core.h   |   201 +
 .../dc/dml2/display_mode_core_structs.h       |  1970 +++
 .../dc/dml2/display_mode_lib_defines.h        |    75 +
 .../amd/display/dc/dml2/display_mode_util.c   |   796 ++
 .../amd/display/dc/dml2/display_mode_util.h   |    74 +
 .../display/dc/dml2/dml2_dc_resource_mgmt.c   |   861 ++
 .../display/dc/dml2/dml2_dc_resource_mgmt.h   |    48 +
 .../drm/amd/display/dc/dml2/dml2_dc_types.h   |    40 +
 .../amd/display/dc/dml2/dml2_internal_types.h |   121 +
 .../amd/display/dc/dml2/dml2_mall_phantom.c   |   913 ++
 .../amd/display/dc/dml2/dml2_mall_phantom.h   |    50 +
 .../gpu/drm/amd/display/dc/dml2/dml2_policy.c |   308 +
 .../gpu/drm/amd/display/dc/dml2/dml2_policy.h |    47 +
 .../display/dc/dml2/dml2_translation_helper.c |  1201 ++
 .../display/dc/dml2/dml2_translation_helper.h |    39 +
 .../gpu/drm/amd/display/dc/dml2/dml2_utils.c  |   480 +
 .../gpu/drm/amd/display/dc/dml2/dml2_utils.h  |   144 +
 .../drm/amd/display/dc/dml2/dml2_wrapper.c    |   745 ++
 .../drm/amd/display/dc/dml2/dml2_wrapper.h    |   212 +
 .../gpu/drm/amd/display/dc/dml2/dml_assert.h  |    30 +
 .../drm/amd/display/dc/dml2/dml_depedencies.h |    31 +
 .../display/dc/dml2/dml_display_rq_dlg_calc.c |   585 +
 .../display/dc/dml2/dml_display_rq_dlg_calc.h |    63 +
 .../gpu/drm/amd/display/dc/dml2/dml_logging.h |    29 +
 .../gpu/drm/amd/display/dc/inc/core_types.h   |     1 +
 43 files changed, 19931 insertions(+), 83 deletions(-)
 rename drivers/gpu/drm/amd/display/dc/{dml/calcs => basics}/bw_fixed.c (94%)
 rename drivers/gpu/drm/amd/display/dc/{dml/calcs => basics}/calcs_logger.h (100%)
 rename drivers/gpu/drm/amd/display/dc/{dml/calcs => basics}/custom_float.c (66%)
 rename drivers/gpu/drm/amd/display/dc/{dml/calcs => basics}/dce_calcs.c (100%)
 create mode 100644 drivers/gpu/drm/amd/display/dc/dml2/Makefile
 create mode 100644 drivers/gpu/drm/amd/display/dc/dml2/cmntypes.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/dml2/display_mode_core.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/dml2/display_mode_core.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/dml2/display_mode_core_structs.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/dml2/display_mode_lib_defines.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/dml2/display_mode_util.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/dml2/display_mode_util.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/dml2/dml2_dc_resource_mgmt.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/dml2/dml2_dc_resource_mgmt.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/dml2/dml2_dc_types.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/dml2/dml2_internal_types.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/dml2/dml2_mall_phantom.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/dml2/dml2_mall_phantom.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/dml2/dml2_policy.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/dml2/dml2_policy.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/dml2/dml2_translation_helper.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/dml2/dml2_translation_helper.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/dml2/dml2_utils.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/dml2/dml2_utils.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/dml2/dml2_wrapper.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/dml2/dml2_wrapper.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/dml2/dml_assert.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/dml2/dml_depedencies.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/dml2/dml_display_rq_dlg_calc.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/dml2/dml_display_rq_dlg_calc.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/dml2/dml_logging.h

-- 
2.40.1

