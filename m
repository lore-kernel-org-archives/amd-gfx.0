Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06898C433EF
	for <amd-gfx@archiver.kernel.org>; Fri, 17 Jun 2022 19:35:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A4E5B10F28F;
	Fri, 17 Jun 2022 19:35:40 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1anam02on2041.outbound.protection.outlook.com [40.107.96.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9909510F28F
 for <amd-gfx@lists.freedesktop.org>; Fri, 17 Jun 2022 19:35:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XqkvHJtuz3pAV04OceGTS9Y26evLTUjDOixSRaHRP8Zj7lIerFBLxoogAvIT0jCkrCqKkUWRhMGsvYAXto3faq6CTvDzFro2pep8SfB7/df8p0BqoDOi1jOtDfJgWsK80ayb7hvlkbvFKEpOTMjXHZ7a73LTdmkrPml2HUItspihW2Ej+cNf/Pe1J5HQLKkeNsx5a0QSQHvoq0OYT58riypBqljjzBb++Z59USWZcWptuXG7gUZUH5cKTqUmpJeMkKrjGyR73SqJeR8jry2BIzeQhx4rDwcUrYYtGhqBJ5fgKw6T8LUI3cPi3pVp/889SML5/B6lUCPE75azRo7hLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zgrZFPxpQjOuYMJhfyhSDR8hGORSCzzJeG0mybJz224=;
 b=WkhkwBUPIZ3H5BriC9672Rgx2dGJFnDEIiEN8YExJfn1sDA6OID6yvlGqXmPbRCY2Pd16pbCVrFwFVR0DSfJC9fo7iJbLXqQwMK5hsXKxmrMaunsmxddfImL4F7mNz2Nq3LoJ8JeJI6q+A6KgYAH/TMYHgna4PlZrP5CEUlkdCHPCuHxtg0tO3f1MSPJBEsUjV4Z08PP6z3EyMC4LIrV6mqUePGrR04sojY179hd425fAYLP/tHbhS7sXN8BUXP9xiEiSxfuJkU0nXrYreYvcyGo3IU2dOvqRWMfv2JRb6esxuttUNuYXSb0/GAZ7MxQEjSGsTD+r5l0Qx7U7959VQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zgrZFPxpQjOuYMJhfyhSDR8hGORSCzzJeG0mybJz224=;
 b=ZgKqrk3F84KKG0bRgqnm3WMGBHCDMVKWY/WM62cY/9w6iexnQ0yhNpgBbcglUsIuhz1Vu7X8l5aFcnS1FuaYQwfkjoeE4SWHgffGOIESFvzrt0zK7Wz+DJpp150JRrDApth1sxpC9aBHoEDj+lxd8xyyHJ2d/ujhRbHALtbHLek=
Received: from BN6PR14CA0034.namprd14.prod.outlook.com (2603:10b6:404:13f::20)
 by BN9PR12MB5052.namprd12.prod.outlook.com (2603:10b6:408:135::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.15; Fri, 17 Jun
 2022 19:35:36 +0000
Received: from BN8NAM11FT021.eop-nam11.prod.protection.outlook.com
 (2603:10b6:404:13f:cafe::92) by BN6PR14CA0034.outlook.office365.com
 (2603:10b6:404:13f::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.14 via Frontend
 Transport; Fri, 17 Jun 2022 19:35:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT021.mail.protection.outlook.com (10.13.177.114) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5353.14 via Frontend Transport; Fri, 17 Jun 2022 19:35:36 +0000
Received: from atma2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Fri, 17 Jun
 2022 14:35:35 -0500
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 00/31] DC Patches June 17, 2022
Date: Fri, 17 Jun 2022 15:34:41 -0400
Message-ID: <20220617193512.3471076-1-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d364999a-88b2-4590-dfdf-08da50988d8a
X-MS-TrafficTypeDiagnostic: BN9PR12MB5052:EE_
X-Microsoft-Antispam-PRVS: <BN9PR12MB505255CE5D94F17C38D45B1E98AF9@BN9PR12MB5052.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: c4LBFmQQeERteZoCe7cei5qhQUWJMmEgTvQvpXj07fix14RpspoZs3njm0jrg2geb2wlGM2miM3rPJKQW21oo6e3fH8MCVWlJq7M8rORKHRLCHH6V2vj2U9YWTk/ln19DZnGKT1TmOiVi846cfYVM/joYILjNACqHQHBUjVs6hIh5pWmvFc+f2OkFCVJ/4c8hUD6HCGEIIiVf2YCG5ADdzZ51xdtsMW9Br9b1k+bL2BlejmPrdMhClRHfU1rAwMtuJV+LYQwWAGLWmUkjAKWrjDc+YJqLBi5Em08Vpfn0ZaH7r1xfuLYfnAboYfkai+nfUF/pozgVbMhNsuKvCCloWH+acIf3l3+t5cMxz/wOpisdJf/l+PhuxQ6CrFt8Ouy/04Y0832jL+wN7K+z/vtvvAHLuOqZcvfJVaq8tVyPNiqT73XuhnA+b+aefv8wK/RyKrIhhbobeMtNBeSqWSulJj51isMZb2Sr+deqsueQOmxRmFXw6573MOIUrg3xh7zRv0QeheLhwguuV7f/fcStb2l145vzTv1xSBNppu9Ou1knmsmw88JaJpnV9zVYSoEiNS/4WeF8kdzvPM/fcAnc3+I2kQBsorvKt02oq4rb13I3dx1XUX+79IPzPCKMGTgbFBHmyu4Sa3MzRq8ggwkSv8oB4KJ0wXi5/7jfxEoFQ04xz+/HnUqTJAJeI5GFCM4ImlFBmgLUlA0U/3/mvCOxw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(46966006)(40470700004)(36840700001)(2616005)(2906002)(26005)(7696005)(6666004)(186003)(40460700003)(83380400001)(426003)(336012)(47076005)(8936002)(1076003)(5660300002)(86362001)(16526019)(36860700001)(498600001)(6916009)(356005)(70206006)(36756003)(54906003)(316002)(81166007)(82310400005)(70586007)(8676002)(4326008)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2022 19:35:36.5661 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d364999a-88b2-4590-dfdf-08da50988d8a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT021.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5052
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
 solomon.chiu@amd.com, jerry.zuo@amd.com, Aurabindo.Pillai@amd.com,
 hamza.mahfooz@amd.com, wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com,
 agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This DC patchset brings improvements in multiple areas. In summary, we
have:

- Remove unnecessary code;
- Small fixes (compilation warnings, typos, etc);
- Improvements in the DPMS code;
- Fix eDP issues;
- Improvements in the MST code.

Thanks
Siqueira

Alvin Lee (2):
  drm/amd/display: Update DPPCLK programming sequence
  drm/amd/display: Update SW state correctly for FCLK

Aric Cyr (2):
  drm/amd/display: Change initializer to single brace
  drm/amd/display: 3.2.191

Chaitanya Dhere (1):
  drm/amd/display: Implement a pme workaround function

Cruise Hung (1):
  drm/amd/display: Remove compiler warning

Dmytro Laktyushkin (1):
  drm/amd/display: Fix in dp link-training when updating payload
    allocation table

George Shen (5):
  drm/amd/display: Fix in overriding DP drive settings
  drm/amd/display: Fix typo in override_lane_settings
  drm/amd/display: Handle downstream LTTPR with fixed VS sequence
  drm/amd/display: Remove unused vendor specific w/a
  drm/amd/display: Fix divide-by-zero in DPPCLK and DISPCLK calculation

Ian Chen (1):
  drm/amd/display: Drop unnecessary detect link code

JinZe.Xu (1):
  drm/amd/display: Change HDMI judgement condition.

Nicholas Choi (1):
  drm/amd/display: refactor function transmitter_to_phy_id

Qingqing Zhuo (1):
  drm/amd/display: Fix DC warning at driver load

Rodrigo Siqueira (4):
  drm/amd/display: Check minimum disp_clk and dpp_clk debug option
  drm/amd/display: Get VCO frequency from registers
  drm/amd/display: Update hook dcn32_funcs
  drm/amd/display: Drop duplicate define

Saaem Rizvi (1):
  drm/amd/display: Add SMU logging code

Sung Joon Kim (2):
  drm/amd/display: Fix eDP not light up on resume
  drm/amd/display: Turn off internal backlight when plugging external
    monitor

Wayne Lin (4):
  drm/amd/display: Revert "drm/amd/display: Add flag to detect dpms
    force off during HPD"
  drm/amd/display: Revert "drm/amd/display: turn DPMS off on connector
    unplug"
  drm/amd/display: Release remote dc_sink under mst scenario
  drm/amd/display: Take emulated dc_sink into account for HDCP

Wenjing Liu (3):
  drm/amd/display: Enrich the log in MST payload update
  drm/amd/display: rename lane_settings to hw_lane_settings
  drm/amd/display: extract update stream allocation to link_hwss

hersen wu (1):
  drm/amd/display: add mst port output bw check

 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |  57 +----
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h |   5 +-
 .../amd/display/amdgpu_dm/amdgpu_dm_debugfs.c |   8 +-
 .../amd/display/amdgpu_dm/amdgpu_dm_hdcp.c    |   1 +
 .../amd/display/amdgpu_dm/amdgpu_dm_helpers.c |  18 +-
 .../display/amdgpu_dm/amdgpu_dm_mst_types.c   |  70 +++++-
 .../display/amdgpu_dm/amdgpu_dm_mst_types.h   |   4 +
 .../dc/clk_mgr/dcn21/rn_clk_mgr_vbios_smu.c   |  12 +
 .../display/dc/clk_mgr/dcn301/dcn301_smu.c    |  12 +
 .../amd/display/dc/clk_mgr/dcn31/dcn31_smu.c  |   8 +
 .../dc/clk_mgr/dcn315/dcn315_clk_mgr.c        |   2 +-
 .../display/dc/clk_mgr/dcn315/dcn315_smu.c    |   8 +
 .../display/dc/clk_mgr/dcn316/dcn316_smu.c    |   8 +
 .../display/dc/clk_mgr/dcn32/dcn32_clk_mgr.c  | 151 +++++++++++-
 .../dc/clk_mgr/dcn32/dcn32_clk_mgr_smu_msg.c  |  10 +-
 .../dc/clk_mgr/dcn32/dcn32_clk_mgr_smu_msg.h  |   1 +
 drivers/gpu/drm/amd/display/dc/core/dc.c      |  13 -
 drivers/gpu/drm/amd/display/dc/core/dc_link.c |  43 ++--
 .../gpu/drm/amd/display/dc/core/dc_link_dp.c  | 222 ++++++------------
 .../drm/amd/display/dc/core/dc_link_dpia.c    |  38 +--
 drivers/gpu/drm/amd/display/dc/dc.h           |   6 +-
 drivers/gpu/drm/amd/display/dc/dc_stream.h    |   1 -
 .../drm/amd/display/dc/dcn31/dcn31_resource.c |   1 -
 .../gpu/drm/amd/display/dc/inc/hw/clk_mgr.h   |   3 +
 .../gpu/drm/amd/display/dc/inc/link_hwss.h    |   6 +-
 .../gpu/drm/amd/display/include/fixed31_32.h  |   2 +-
 .../amd/display/include/link_service_types.h  |   1 -
 27 files changed, 421 insertions(+), 290 deletions(-)

-- 
2.25.1

