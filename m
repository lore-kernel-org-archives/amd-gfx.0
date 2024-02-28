Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0EC8C47DD9
	for <amd-gfx@archiver.kernel.org>; Wed, 28 Feb 2024 18:40:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1FD1A10E062;
	Wed, 28 Feb 2024 18:40:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="qu0znbKC";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2059.outbound.protection.outlook.com [40.107.92.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1532910E318
 for <amd-gfx@lists.freedesktop.org>; Wed, 28 Feb 2024 18:40:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kOU4U6TsIZVphjFg+7rykJsJTT4jkgYB22pNLMZX8UYBzpSGwXAna0OeZtyAWmFiDZBbcF2o3Bgb82aHjJkIrieXmYovBfOcVVEHMqBUTsC2+3/YRcFNweMEoXFnHQVyd5uKdRZL8tDTnkb2Yt/Vd6PJK8b3pBaYPFSSkicjfR3z9X7iXxYwbet44TrdcjDyPYAo+M7YpsATULOoTORYqRXvBtFNsGmNot+w/zXqPel9FqYLR/HWmV4RM5Yyxh4wG3bDLNbiM2YfvxED0yOqTHnMHLt+TMkrlVdBLmgsjGzg2xDeB+yzK2u6Drjb8gPxyBcIxP9UVbAOI8yE5tr0PA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZyD7psIV85RDsuDxT4Boyu8VBewvMAFEc/C691NmyU8=;
 b=Jyz6/HBeAtAZY8MIbwouzra72uQBcqYQcARSQ7O1P4EoUOqapO16dfPcbp6xlss/hdWGwvM4+OccUMTalUVLimk6HhteJ5tN5eMuVw5jkiDQ7mIx/EUxYHQZ2i1ezIT8mflhms7B52EM8oVlDh032ysTN28crKQIiwnADmMG3bso3wO8oT36FJaGe1h/URwJdXcpzr+fyxh1xbq21BQQLCNLKwcV0dFqaIimhsWV0Sjoa9z0NY/k9V/tZXofnqnP3Dk5vmxbP2Tia6n+Stf9dzjzC/j9kZW0vbMAplgLbibKS2YQlpIQr4t80wQigSsGiy+L1wEI6FRzLPpbK4DW3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZyD7psIV85RDsuDxT4Boyu8VBewvMAFEc/C691NmyU8=;
 b=qu0znbKC710O2hrTpJ3UXd9QkuIAQU+E3e4cTinbHYvRXjRd/JKa2Y7ueyojUQNGzICblKvUMIt9P9hAYGWAzVrEqM/TdH4oljzK4Rz5h1v//tCMvQUGq7ehi0EhIgd/+pKTvYmL66cRWS89LaXQuu7xx37Q3Q1RrsB+CWkcQw4=
Received: from SJ0PR03CA0205.namprd03.prod.outlook.com (2603:10b6:a03:2ef::30)
 by SA1PR12MB6917.namprd12.prod.outlook.com (2603:10b6:806:24c::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.39; Wed, 28 Feb
 2024 18:40:47 +0000
Received: from MWH0EPF000971E7.namprd02.prod.outlook.com
 (2603:10b6:a03:2ef:cafe::40) by SJ0PR03CA0205.outlook.office365.com
 (2603:10b6:a03:2ef::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.28 via Frontend
 Transport; Wed, 28 Feb 2024 18:40:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000971E7.mail.protection.outlook.com (10.167.243.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7292.25 via Frontend Transport; Wed, 28 Feb 2024 18:40:46 +0000
Received: from dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 28 Feb
 2024 12:40:44 -0600
From: Alex Hung <alex.hung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <hersenxs.wu@amd.com>, <jerry.zuo@amd.com>, Alex Hung <alex.hung@amd.com>,
 Daniel Wheeler <daniel.wheeler@amd.com>
Subject: [PATCH 00/34] DC Patches Feb 28, 2020
Date: Wed, 28 Feb 2024 11:39:06 -0700
Message-ID: <20240228183940.1883742-1-alex.hung@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E7:EE_|SA1PR12MB6917:EE_
X-MS-Office365-Filtering-Correlation-Id: ed7adae8-ee3c-4493-ae90-08dc388cc750
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ANgWeSxU5gNVIkPwq9daREJtvF/RLyU4fsMxN3phuR8jjILchTSGyOqvmC0LJL+XXp2S9Z/vKKqH1BOgq3toTzKBfGu+YG0ce+vQzqCJ112dJ8S1q95V7g5CE5iq6un5GcbL8K4ffWaDW4hk7opHTAZYH4XOO1mnNJ/X54ddgrf/4vzyS9p3QntmMu4ABQW2DhCg9DrtpLw2lA2a2gk5hBhouTd6Xe7iFoHlpnYUB4KT9d8q3ilC3zRoJWwBeaKTs7wX2rhCMemd4ZFc+O3mi+R0BLvwQ8VonmMtbaJbNzqeIyfaPkrEqeQAgsbRq1kdJ2A1S46/TVpxGOG4FxJdiPi8jf0BL/8NgRDxDsRwah6z/nUxgYUXbLR20aV6uMR1fTMTOITYPlZl6+1u7Bpbiy0d/M833pMsJXKeGUsfmffMoBshTZVFjo9LgZS3rIJpHiSDDevFNO1c6iFnUjMX+8C999tiVU12xpy9gpd88hKwn9HeQXsGokohQw5BCPRRQ6YHFwx3oMyaR6jaL9+zT4A8En3Og0VaFtG6gBsj6eaCldb+A3BaHeDDj66ePvjWKu9sZec9ce80VSmPjKVRJNcRinNDwwhjnlO6wYi/ZqhNZMfsiY5BXdVj4sIPsEJPEMKUhIBOilZTEp8c+E4gdgU+cVmbXof71qxQbH9ECOA5b6zFPoXhyLwxwjIx8WV74fRtM3iym8O7yStZAWKBec5QTXXS8FN8K6jFIeQFS3artgajN5a6cSkNNfM9dizb
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(36860700004)(82310400014); DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2024 18:40:46.8735 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ed7adae8-ee3c-4493-ae90-08dc388cc750
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000971E7.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6917
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This DC patchset brings improvements in multiple areas. In summary, we highlight:

* Fixes on HDCP, eDP and FW idle check.
* Enhancement in debug messages
* Improvement on updates sequences
* DPP refactoring to a new directory
* Enhancements in DMUB

Cc: Daniel Wheeler <daniel.wheeler@amd.com>

Allen Pan (1):
  drm/amd/display: Add a dc_state NULL check in dc_state_release

Alvin Lee (1):
  drm/amd/display: Backup and restore only on full updates

Anthony Koo (2):
  drm/amd/display: Add entry and exit counters
  drm/amd/display: Update DMUB flags and definitions

Aric Cyr (2):
  drm/amd/display: 3.2.274
  drm/amd/display: 3.2.275

Aurabindo Pillai (3):
  drm/amd/display: Enable DML2 debug flags
  drm/amd/display: Add some forward declarations
  drm/amd/display: Add DML2 folder to include path

ChunTao Tso (1):
  drm/amd/display: Amend coasting vtotal for replay low hz

Dillon Varone (1):
  drm/amd/display: Init DPPCLK from SMU on dcn32

George Shen (1):
  drm/amd/display: Add left edge pixel for YCbCr422/420 + ODM pipe split

Josip Pavic (1):
  drm/amd/display: Allow dirty rects to be sent to dmub when abm is
    active

Muhammad Ahmed (2):
  drm/amd/display: Add debug key to allow disabling dtbclk
  drm/amd/display: Set the power_down_on_boot function pointer to null

Nicholas Kazlauskas (6):
  drm/amd/display: Add debug prints for IPS testing
  drm/amd/display: Exit idle optimizations before HDCP execution
  drm/amd/display: Fix idle check for shared firmware state
  drm/amd/display: Add guards for idle on reg read/write
  drm/amd/display: Guard cursor idle reallow by DC debug option
  drm/amd/display: Add debug counters to IPS exit prints

Revalla Hari Krishna (1):
  drm/amd/display: Refactor DPP into a component directory

Robin Chen (1):
  drm/amd/display: Support long vblank feature

Rodrigo Siqueira (2):
  drm/amd/display: Return the correct HDCP error code
  drm/amd/display: Add comments to v_total calculation and drop legacy
    TODO

Roman Li (1):
  drm/amd/display: Fix function banner for amdgpu_dm_psr_disable_all()

Ryan Lin (1):
  drm/amd/display: Add monitor patch for specific eDP

Sohaib Nadeem (1):
  drm/amd/display: Override min required DCFCLK in dml1_validate

Swapnil Patel (1):
  drm/amd/display: Change default size for dummy plane in DML2

Wenjing Liu (4):
  drm/amd/display: Update odm when ODM combine is changed on an otg
    master pipe with no plane
  drm/amd/display: Implement update_planes_and_stream_v3 sequence
  drm/amd/display: Lock all enabled otg pipes even with no planes
  drm/amd/display: Implement wait_for_odm_update_pending_complete

Xi Liu (1):
  drm/amd/display: Set DCN351 BB and IP the same as DCN35

 drivers/gpu/drm/amd/display/Makefile          |   1 +
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |   3 +
 .../amd/display/amdgpu_dm/amdgpu_dm_helpers.c |   6 +-
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_psr.c |   2 +-
 drivers/gpu/drm/amd/display/dc/Makefile       |   2 +-
 .../display/dc/clk_mgr/dcn32/dcn32_clk_mgr.c  |  14 +
 .../display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c  |   3 +-
 drivers/gpu/drm/amd/display/dc/core/dc.c      | 824 ++++++++++++------
 .../gpu/drm/amd/display/dc/core/dc_resource.c |  37 +
 .../gpu/drm/amd/display/dc/core/dc_state.c    |   4 +-
 .../gpu/drm/amd/display/dc/core/dc_stream.c   |   4 +-
 drivers/gpu/drm/amd/display/dc/dc.h           | 174 ++--
 drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c  |  94 ++
 drivers/gpu/drm/amd/display/dc/dc_dmub_srv.h  |   1 +
 drivers/gpu/drm/amd/display/dc/dc_hw_types.h  |   1 +
 drivers/gpu/drm/amd/display/dc/dc_types.h     |   4 +-
 .../gpu/drm/amd/display/dc/dce/dmub_replay.c  |   2 +-
 drivers/gpu/drm/amd/display/dc/dcn10/Makefile |   4 +-
 .../amd/display/dc/dcn10/dcn10_cm_common.c    |   2 +-
 .../gpu/drm/amd/display/dc/dcn10/dcn10_opp.c  |   1 +
 drivers/gpu/drm/amd/display/dc/dcn20/Makefile |   2 +-
 .../gpu/drm/amd/display/dc/dcn20/dcn20_opp.c  |  14 +
 .../gpu/drm/amd/display/dc/dcn20/dcn20_opp.h  |   2 +
 .../gpu/drm/amd/display/dc/dcn201/Makefile    |   2 +-
 .../drm/amd/display/dc/dcn201/dcn201_opp.c    |   1 +
 drivers/gpu/drm/amd/display/dc/dcn30/Makefile |   2 -
 .../amd/display/dc/dcn30/dcn30_cm_common.c    |   2 +-
 drivers/gpu/drm/amd/display/dc/dcn32/Makefile |   2 +-
 .../display/dc/dcn32/dcn32_resource_helpers.c |   6 +
 drivers/gpu/drm/amd/display/dc/dcn35/Makefile |   2 +-
 drivers/gpu/drm/amd/display/dc/dml2/Makefile  |   1 +
 .../display/dc/dml2/dml2_dc_resource_mgmt.h   |   2 +
 .../display/dc/dml2/dml2_translation_helper.c |  24 +-
 .../drm/amd/display/dc/dml2/dml2_wrapper.c    |  28 +-
 .../drm/amd/display/dc/dml2/dml2_wrapper.h    |   3 +
 drivers/gpu/drm/amd/display/dc/dpp/Makefile   |  77 ++
 .../amd/display/dc/dpp/dcn10/CMakeLists.txt   |   6 +
 .../display/dc/{ => dpp}/dcn10/dcn10_dpp.c    |   2 +-
 .../display/dc/{ => dpp}/dcn10/dcn10_dpp.h    |   0
 .../display/dc/{ => dpp}/dcn10/dcn10_dpp_cm.c |   4 +-
 .../dc/{ => dpp}/dcn10/dcn10_dpp_dscl.c       |   2 +-
 .../amd/display/dc/dpp/dcn20/CMakeLists.txt   |   5 +
 .../display/dc/{ => dpp}/dcn20/dcn20_dpp.c    |   2 +-
 .../display/dc/{ => dpp}/dcn20/dcn20_dpp.h    |   0
 .../display/dc/{ => dpp}/dcn20/dcn20_dpp_cm.c |   2 +-
 .../amd/display/dc/dpp/dcn201/CMakeLists.txt  |   4 +
 .../display/dc/{ => dpp}/dcn201/dcn201_dpp.c  |   2 +-
 .../display/dc/{ => dpp}/dcn201/dcn201_dpp.h  |   0
 .../amd/display/dc/dpp/dcn30/CMakeLists.txt   |   5 +
 .../display/dc/{ => dpp}/dcn30/dcn30_dpp.c    |   4 +-
 .../display/dc/{ => dpp}/dcn30/dcn30_dpp.h    |   0
 .../display/dc/{ => dpp}/dcn30/dcn30_dpp_cm.c |   4 +-
 .../amd/display/dc/dpp/dcn32/CMakeLists.txt   |   4 +
 .../display/dc/{ => dpp}/dcn32/dcn32_dpp.c    |   2 +-
 .../display/dc/{ => dpp}/dcn32/dcn32_dpp.h    |   0
 .../amd/display/dc/dpp/dcn35/CMakeLists.txt   |   4 +
 .../display/dc/{ => dpp}/dcn35/dcn35_dpp.c    |   2 +-
 .../display/dc/{ => dpp}/dcn35/dcn35_dpp.h    |   0
 .../amd/display/dc/hwss/dcn20/dcn20_hwseq.c   |  55 +-
 .../amd/display/dc/hwss/dcn32/dcn32_hwseq.c   |  30 +
 .../amd/display/dc/hwss/dcn32/dcn32_hwseq.h   |   2 +
 .../amd/display/dc/hwss/dcn32/dcn32_init.c    |   2 +-
 .../amd/display/dc/hwss/dcn35/dcn35_hwseq.c   |  28 +
 .../amd/display/dc/hwss/dcn35/dcn35_hwseq.h   |   3 +
 .../amd/display/dc/hwss/dcn35/dcn35_init.c    |   5 +-
 .../drm/amd/display/dc/hwss/hw_sequencer.h    |   1 +
 .../gpu/drm/amd/display/dc/inc/core_types.h   |  24 +-
 drivers/gpu/drm/amd/display/dc/inc/hw/opp.h   |   3 +
 .../amd/display/dc/inc/hw/timing_generator.h  |   8 +
 drivers/gpu/drm/amd/display/dc/inc/link.h     |   4 +-
 drivers/gpu/drm/amd/display/dc/inc/resource.h |   4 +
 .../link/protocols/link_edp_panel_control.c   |   4 +-
 .../link/protocols/link_edp_panel_control.h   |   4 +-
 .../amd/display/dc/optc/dcn10/dcn10_optc.h    |   9 +-
 .../amd/display/dc/optc/dcn32/dcn32_optc.c    |   8 +
 .../amd/display/dc/optc/dcn32/dcn32_optc.h    |   1 +
 .../amd/display/dc/optc/dcn35/dcn35_optc.c    | 165 +++-
 .../amd/display/dc/optc/dcn35/dcn35_optc.h    |   6 +-
 .../dc/resource/dcn32/dcn32_resource.c        |   3 +
 .../dc/resource/dcn32/dcn32_resource.h        |   3 +
 .../dc/resource/dcn321/dcn321_resource.c      |   2 +
 .../dc/resource/dcn35/dcn35_resource.h        |   2 +
 .../gpu/drm/amd/display/dmub/inc/dmub_cmd.h   |  56 +-
 .../amd/display/include/link_service_types.h  |   1 -
 .../drm/amd/display/include/logger_types.h    |   1 +
 .../amd/display/modules/freesync/freesync.c   |   6 +-
 .../gpu/drm/amd/display/modules/hdcp/hdcp.c   |  10 +
 .../drm/amd/display/modules/hdcp/hdcp_psp.c   |   3 +
 .../drm/amd/display/modules/inc/mod_hdcp.h    |   8 +
 .../amd/display/modules/power/power_helpers.c |   2 +-
 .../amd/display/modules/power/power_helpers.h |   2 +-
 91 files changed, 1436 insertions(+), 436 deletions(-)
 create mode 100644 drivers/gpu/drm/amd/display/dc/dpp/Makefile
 create mode 100644 drivers/gpu/drm/amd/display/dc/dpp/dcn10/CMakeLists.txt
 rename drivers/gpu/drm/amd/display/dc/{ => dpp}/dcn10/dcn10_dpp.c (99%)
 rename drivers/gpu/drm/amd/display/dc/{ => dpp}/dcn10/dcn10_dpp.h (100%)
 rename drivers/gpu/drm/amd/display/dc/{ => dpp}/dcn10/dcn10_dpp_cm.c (99%)
 rename drivers/gpu/drm/amd/display/dc/{ => dpp}/dcn10/dcn10_dpp_dscl.c (99%)
 create mode 100644 drivers/gpu/drm/amd/display/dc/dpp/dcn20/CMakeLists.txt
 rename drivers/gpu/drm/amd/display/dc/{ => dpp}/dcn20/dcn20_dpp.c (99%)
 rename drivers/gpu/drm/amd/display/dc/{ => dpp}/dcn20/dcn20_dpp.h (100%)
 rename drivers/gpu/drm/amd/display/dc/{ => dpp}/dcn20/dcn20_dpp_cm.c (99%)
 create mode 100644 drivers/gpu/drm/amd/display/dc/dpp/dcn201/CMakeLists.txt
 rename drivers/gpu/drm/amd/display/dc/{ => dpp}/dcn201/dcn201_dpp.c (99%)
 rename drivers/gpu/drm/amd/display/dc/{ => dpp}/dcn201/dcn201_dpp.h (100%)
 create mode 100644 drivers/gpu/drm/amd/display/dc/dpp/dcn30/CMakeLists.txt
 rename drivers/gpu/drm/amd/display/dc/{ => dpp}/dcn30/dcn30_dpp.c (99%)
 rename drivers/gpu/drm/amd/display/dc/{ => dpp}/dcn30/dcn30_dpp.h (100%)
 rename drivers/gpu/drm/amd/display/dc/{ => dpp}/dcn30/dcn30_dpp_cm.c (99%)
 create mode 100644 drivers/gpu/drm/amd/display/dc/dpp/dcn32/CMakeLists.txt
 rename drivers/gpu/drm/amd/display/dc/{ => dpp}/dcn32/dcn32_dpp.c (99%)
 rename drivers/gpu/drm/amd/display/dc/{ => dpp}/dcn32/dcn32_dpp.h (100%)
 create mode 100644 drivers/gpu/drm/amd/display/dc/dpp/dcn35/CMakeLists.txt
 rename drivers/gpu/drm/amd/display/dc/{ => dpp}/dcn35/dcn35_dpp.c (98%)
 rename drivers/gpu/drm/amd/display/dc/{ => dpp}/dcn35/dcn35_dpp.h (100%)

-- 
2.34.1

