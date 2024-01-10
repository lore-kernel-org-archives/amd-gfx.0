Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBBDFC47073
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Jan 2024 21:53:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 389DE10E634;
	Wed, 10 Jan 2024 21:53:51 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2055.outbound.protection.outlook.com [40.107.102.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 05D2410E634
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 Jan 2024 21:53:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VXtRoE7amCULHk1twYwhKwFj5Rjv42E7s5pYd/MP/Z/GMhnmqy4GjTFA5SPX4qMmhRaFhrAatGTGJDGYNBsd1wMmoSTRMtv7zZODBSaBIPEQbi03WNmxDsJCsq3koxFfDyI0cOnk4yV4i13k3qsPgVJ2qa6Emm/2YN66j4oDvTulwBSTi6UQdpLalQUExaNXzzX1HaHjj1qwru89hu+alf6oKe4nL3Tmv64X8TnTo9f6rwadp3vPUTJRjDWY878VY8YSfksQg2cOQ/XbBMYJJv/550vkWdxw/V9xV4bgWw6k1AZD+PWKFR4HoECmuCqSdwSn7/g5k2tz7yNGx/wSPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=55nb6M/3RkIawH514Apvzn1rJO44+4CKDQIIbF2EMaw=;
 b=e64IbEOz+epVfidGLA2QABSFU1PxbN4YTYhuBlkmqR2AIgDyjI4jE329xVdhOT/YgOEq6r6dfNptCYMts36sqwkjRVwK4lqmJpot+QR9YflVeSxQzUk/sMgUFHqQyPqP/Bxtf1/+kIiFY59zf7jgvsdrZIEpvgazv5fxAOsdPBWKuagd3h3sWz8qnKS9Ehc5ZRvI+ZPCEKRIZXG2jTlIri65RDYSG75xU3nIyTaQmaOaEfLT92S64ToB5Uezjw2YtDgQmfKzFeZ5OXT7K/cHLd/37vSTSx1+0cahVJKrSVrjPgpYgGz4G6iOex39Q9qBz6WHXw/HXELnZ+H5X/BqAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=55nb6M/3RkIawH514Apvzn1rJO44+4CKDQIIbF2EMaw=;
 b=hImClyaAtQcCCIUYTehjknwBmUMRvLakeiU+cterV5HiD48qIxSGRVWEEvM8GTNuxRXutsbZIyooIWLLmd1FWD+qXYD45KzkCjwN9sTlAtsM2Yn4mGNwac4CDcjP3J8gqitMI6JRuVNiOsqhtr6MX5ZRu/AiiSj3LPbgORbPhgA=
Received: from MW4PR03CA0104.namprd03.prod.outlook.com (2603:10b6:303:b7::19)
 by DM8PR12MB5399.namprd12.prod.outlook.com (2603:10b6:8:34::5) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7181.17; Wed, 10 Jan 2024 21:53:45 +0000
Received: from MWH0EPF000989EB.namprd02.prod.outlook.com
 (2603:10b6:303:b7:cafe::87) by MW4PR03CA0104.outlook.office365.com
 (2603:10b6:303:b7::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.18 via Frontend
 Transport; Wed, 10 Jan 2024 21:53:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000989EB.mail.protection.outlook.com (10.167.241.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7181.14 via Frontend Transport; Wed, 10 Jan 2024 21:53:44 +0000
Received: from dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Wed, 10 Jan
 2024 15:53:42 -0600
From: Alex Hung <alex.hung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 00/19] DC Patches January 10, 2024
Date: Wed, 10 Jan 2024 14:52:43 -0700
Message-ID: <20240110215302.2116049-1-alex.hung@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000989EB:EE_|DM8PR12MB5399:EE_
X-MS-Office365-Filtering-Correlation-Id: c28b7680-6b3b-4975-8d00-08dc12269e26
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: T3XD5BUINHineQc0wkmTA7r6FO0T0di7sN43n/q5eHrumVGTQThCZNnuh928WHiptz/8RSjZZpkAaQzJ2RSRGWLPEDVEPBH9fgmFhb2YdH7UKHTijXbqSqi7nuApXGMYhnINOHf6QRWMkN/6gjBywA2VmWAmAS4wIJXNRFZncW4t0wwmFgoOqvSguBKjUR6Bn26fkbIO2LFg693gT/z6FuOLkwZENpbFXfDME0YlcsZGc2AJFENe8qb2Fq+AtGBbAS2BcF8Kq1Na5ahmCU/gLgykUbxyJ083zM1pTVjYT3tzfDTSy4TlgkWVBrhYG2eWAZWJmLeZbc8304hVO8rFH7Bv4f/6W5+mJk7+T7eDoidt4crvz6N07L2bKgCWsedI57ExCk37LC8LcUwHftiiPfsCpoerJ75iXzjFfO7iVXij1u/KDKMizkxrRqziDLBdqU4WqSQvshetske+AMi8aTlxkpxKlIYbZWTYjWyJZfkxNDS3K4kfEgNqqBMosK+jToPTwdmMslznGg2OYWVJqqajM2Br4Kyhb8Mft08nwp1VghpA6eEhaqh1noyrlO71CUW7hq13Dlc/+k5IMkV+D3vsUIBV/ZoCnlyS+nQf9cXNqLw96djIhUps6MEGJloMJ8yFrVHWd5YCJJdH40P9gkw4ooyLPCJd/sk0iNyxmLldMkfa0LWGKNTbiOp4xsqSDGyuwHKfXI83ecyicxLZRuEvfRqm3ZV0uZYmqV6kwTsHL+rZFU8OYl31DYx6VPw0XS1ewH9+JQqrvUd2UPiSKA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(39860400002)(136003)(346002)(376002)(396003)(230922051799003)(1800799012)(451199024)(186009)(82310400011)(64100799003)(46966006)(36840700001)(40470700004)(44832011)(36756003)(5660300002)(8936002)(8676002)(4326008)(2906002)(41300700001)(36860700001)(478600001)(82740400003)(26005)(336012)(426003)(1076003)(16526019)(40460700003)(83380400001)(7696005)(70586007)(40480700001)(47076005)(70206006)(6916009)(2616005)(316002)(54906003)(81166007)(86362001)(356005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2024 21:53:44.9589 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c28b7680-6b3b-4975-8d00-08dc12269e26
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000989EB.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR12MB5399
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
Cc: stylon.wang@amd.com, chiahsuan.chung@amd.com, Sunpeng.Li@amd.com,
 Rodrigo.Siqueira@amd.com, roman.li@amd.com,
 Daniel Wheeler <daniel.wheeler@amd.com>, Alex
 Hung <alex.hung@amd.com>, jerry.zuo@amd.com, Aurabindo.Pillai@amd.com,
 hersenxs.wu@amd.com, wayne.lin@amd.com, Harry.Wentland@amd.com,
 agustin.gutierrez@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This DC patchset brings improvements in multiple areas. In summary, we highlight:

* Fixes on DCN35 and DML2.
* Enhancements in DMUB.
* Improvements on IPS, DP and MPO and others.

Cc: Daniel Wheeler <daniel.wheeler@amd.com>

Alvin Lee (2):
  drm/amd/display: Add Replay IPS register for DMUB command table
  drm/amd/display: Ensure populate uclk in bb construction

Charlene Liu (2):
  drm/amd/display: Add logging resource checks
  drm/amd/display: Update P010 scaling cap

Dillon Varone (1):
  drm/amd/display: Init link enc resources in dc_state only if res_pool
    presents

Dmytro Laktyushkin (1):
  drm/amd/display: Fix dml2 assigned pipe search

George Shen (1):
  drm/amd/display: Add DP audio BW validation

Ilya Bakoulin (1):
  drm/amd/display: Clear OPTC mem select on disable

Martin Leung (1):
  drm/amd/display: 3.2.267

Nicholas Kazlauskas (5):
  drm/amd/display: Allow IPS2 during Replay
  drm/amd/display: Port DENTIST hang and TDR fixes to OTG disable W/A
  drm/amd/display: Rework DC Z10 restore
  drm/amd/display: Set default Z8 minimum residency for DCN35
  drm/amd/display: Allow Z8 for multiplane configurations on DCN35

Ovidiu Bunea (1):
  drm/amd/display: Fix DML2 watermark calculation

Tom Chung (1):
  drm/amd/display: Enable Panel Replay for static screen use case

Wayne Lin (1):
  drm/amd/display: Align the returned error code with legacy DP

Wenjing Liu (2):
  drm/amd/display: Floor to mhz when requesting dpp disp clock changes
    to SMU
  drm/amd/display: Reenable windowed mpo odm support

 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |  44 ++-
 .../amd/display/amdgpu_dm/amdgpu_dm_crtc.c    |  59 +++-
 .../amd/display/amdgpu_dm/amdgpu_dm_helpers.c |   5 +
 .../amd/display/amdgpu_dm/amdgpu_dm_replay.c  | 119 +++++---
 .../amd/display/amdgpu_dm/amdgpu_dm_replay.h  |   4 +-
 .../dc/clk_mgr/dcn314/dcn314_clk_mgr.c        |  21 +-
 .../display/dc/clk_mgr/dcn32/dcn32_clk_mgr.c  |  40 ++-
 .../display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c  |  25 +-
 drivers/gpu/drm/amd/display/dc/core/dc.c      |  15 +-
 .../gpu/drm/amd/display/dc/core/dc_resource.c |   4 +
 .../gpu/drm/amd/display/dc/core/dc_state.c    |   8 +-
 .../gpu/drm/amd/display/dc/core/dc_stream.c   |   9 +-
 drivers/gpu/drm/amd/display/dc/dc.h           |   3 +-
 .../gpu/drm/amd/display/dc/dce/dce_audio.c    | 288 +++++++++++++++++-
 .../gpu/drm/amd/display/dc/dce/dce_audio.h    |   3 +-
 .../dc/dml/dcn30/display_mode_vba_30.c        |  16 +-
 .../amd/display/dc/dml/dcn303/dcn303_fpu.c    |  11 +
 .../drm/amd/display/dc/dml/dcn35/dcn35_fpu.c  |   4 +-
 .../amd/display/dc/dml2/display_mode_core.c   |  14 +-
 .../display/dc/dml2/dml2_dc_resource_mgmt.c   |  36 ++-
 .../amd/display/dc/hwss/dce110/dce110_hwseq.c |  56 +++-
 .../amd/display/dc/hwss/dcn35/dcn35_hwseq.c   |  11 +-
 drivers/gpu/drm/amd/display/dc/inc/hw/audio.h |   3 +-
 .../amd/display/dc/inc/hw/clk_mgr_internal.h  |   5 +
 .../amd/display/dc/optc/dcn32/dcn32_optc.c    |   3 +
 .../amd/display/dc/optc/dcn35/dcn35_optc.c    |   3 +
 .../dc/resource/dcn30/dcn30_resource.c        |  11 +
 .../dc/resource/dcn32/dcn32_resource.c        |   1 +
 .../dc/resource/dcn321/dcn321_resource.c      |   1 +
 .../dc/resource/dcn35/dcn35_resource.c        |   3 +-
 .../gpu/drm/amd/display/dmub/inc/dmub_cmd.h   |   1 +
 .../gpu/drm/amd/display/include/audio_types.h |  15 +
 32 files changed, 689 insertions(+), 152 deletions(-)

-- 
2.34.1

