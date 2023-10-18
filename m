Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 706B4CDB47E
	for <amd-gfx@archiver.kernel.org>; Wed, 18 Oct 2023 17:41:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BBF0210E40B;
	Wed, 18 Oct 2023 17:41:56 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2042.outbound.protection.outlook.com [40.107.237.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9C92710E40B
 for <amd-gfx@lists.freedesktop.org>; Wed, 18 Oct 2023 17:41:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NeMYGkzzG7ngtCxh5wV0vNLQPbAGSfp9Ov0mSH8TSzWJafjmv1yV9hlHirn74dMq2VTJaeIgLJvyOTnuISFoXm8Ii5Psi/W+x3dPujTeWQxiFT0Cgs7QA9qpzuedCvfzNikjVG/2QgVGYGFxHxaMRSXAdIxpIXUi5U2wFyNTXrm5m9bXLLwLQq0D4q5aRescm7CQEPhqz9SrOQC0Ag472GIn/OPuSCtmLgwD8VSnBCWhOK1z1oLznVIU9eY7A0QKOAQSCggl0MGE/De4/MH4tiozZlHRRtojVH8SdHjOQcYeO62qOYu2t86ow4TFuhHj9YyjQoKVcX0/lGg5lRIDYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L0o/WvJvQuVKNJURktqDNIFFp1gNRSdDLY8NfzxF4IM=;
 b=kGSiDi9W5ge0AGcHnqOckV/NsV17xjgTwIeVdhkW/DG7wOVgxLeIWd2LSdNgBZtzG3MHXurHGq9hV+vXzm8sHllyJy4azermZP6vMUyoMTYHivngrYxkE25DKnXkdujuXyT3/hXkNkL56DioxXTPjCaPyQLwGJ/9P/pTam11zdZobnhper1aWMfKkD9jMX0kPEl251GcT3aFx3TrbG3K93kyjI8JwXDSd82JSSITnge3w6pnkTVG1tT8wqxgcrKvPjZYvUj8SejMS0YZ0QD0Zq+UeOEb85o2fVvyB9RbacJlSeesz65IfCpZPwaIFYHSvxuzTOij7O/8SvnzH0RrRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L0o/WvJvQuVKNJURktqDNIFFp1gNRSdDLY8NfzxF4IM=;
 b=fejTBdA/DOnw1Lw/1HLrqpTxC3IxUIhhndIK7JdWv7xPXN28UEhYu+41nLOlESgO+OQ2wfjhAQbUFdQE2C85ildaFo73wEVa0LdN07FHoMwIbzUZ2gLpAiFfQA62J0v9mBIJJxyb1kLueaj+bEug7FIdX19DFmyhDFpMlERwbwg=
Received: from CH0P221CA0036.NAMP221.PROD.OUTLOOK.COM (2603:10b6:610:11d::14)
 by PH7PR12MB5950.namprd12.prod.outlook.com (2603:10b6:510:1d9::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.24; Wed, 18 Oct
 2023 17:41:50 +0000
Received: from DS1PEPF00017094.namprd03.prod.outlook.com
 (2603:10b6:610:11d:cafe::b8) by CH0P221CA0036.outlook.office365.com
 (2603:10b6:610:11d::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.23 via Frontend
 Transport; Wed, 18 Oct 2023 17:41:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF00017094.mail.protection.outlook.com (10.167.17.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6907.21 via Frontend Transport; Wed, 18 Oct 2023 17:41:49 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 18 Oct
 2023 12:41:49 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 18 Oct
 2023 12:41:48 -0500
Received: from roman-vdev.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.27 via Frontend
 Transport; Wed, 18 Oct 2023 12:41:43 -0500
From: <Roman.Li@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 00/26] DC Patches October 18, 2023
Date: Wed, 18 Oct 2023 13:41:07 -0400
Message-ID: <20231018174133.1613439-1-Roman.Li@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00017094:EE_|PH7PR12MB5950:EE_
X-MS-Office365-Filtering-Correlation-Id: d06354ff-7367-4b3f-3253-08dbd0018200
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ynxFPD9mW7gyj/s3IBPBgpe2Jz2GklhxN7u/pgUddYBj6cmt6pLliHiLvZjtcWRgf+r18AOyoEs4mjJw1CbqaDpCXq+/XZEzWpYlZeq7jasEnbiWvQebvSYxSTa/BIIolBymZiF8QaGjvQRkjF5D9TOq9K+BAUxKHUEESwQQKbvfeIVP6pQnSYOGPoLBcQHnHHqntqL0EmO6IccTxbGkII2WdWlPk6KK2Pazj+fayTkFYLngVr0CXwffPt0XUWAfqJLdKxK2aLsRoGocr98xTcJDPo54KJibjT9Tosw2G2pdPRpdezZPqkax6nupmPzUF/B97FX+oCfzoN2snKjAXoksr5e6e42SpA6ZkYx+iGmIfV5Iy/eO55prahKXok9pbN9fk9icNXSwyMFazz4J/7s7meUUlFjUpKOOUmWePSGoKXXyq1oXNBWnrB7tCnMX73cSicO5Ee0JwChvGvuwljFXKTkZZL3XcYpG+qnLU//YKhXFUzky//pSSdPwaVHqWZtu4qOm8f9wEvOlBIzSkioVjKJcqXYm77lxBJShtnYkSIbWDuDLgM/JU/SlaES9kpU8Y+D4k8jraLTawZM524whPTImcHSlvau3UnNC114EbsZFoq+t/DbQsn21/0f6s+SiGnE2SraPTGK9xWqpw0k5r42aPVy2qnhnSEifdrBSy0z/cobeQZvB874mIwmWLZIk+W+HDKVMZ1mUg9KstZ/4wRdszTmXLroz/cQnZyd4SsDY6uWynKgeZ26X6Dw0xSD1/lM5XUa5KnW6+4fp7Q==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(136003)(396003)(376002)(39860400002)(346002)(230922051799003)(64100799003)(186009)(82310400011)(451199024)(1800799009)(40470700004)(36840700001)(46966006)(36860700001)(336012)(426003)(26005)(82740400003)(356005)(47076005)(40460700003)(83380400001)(41300700001)(70206006)(8936002)(70586007)(54906003)(8676002)(4326008)(5660300002)(2906002)(1076003)(6916009)(316002)(86362001)(2876002)(7696005)(478600001)(6666004)(40480700001)(81166007)(2616005)(36756003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2023 17:41:49.6871 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d06354ff-7367-4b3f-3253-08dbd0018200
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF00017094.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5950
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
 Rodrigo.Siqueira@amd.com, Roman Li <Roman.Li@amd.com>,
 Daniel Wheeler <daniel.wheeler@amd.com>, jerry.zuo@amd.com,
 Aurabindo.Pillai@amd.com, hersenxs.wu@amd.com, wayne.lin@amd.com,
 Harry.Wentland@amd.com, agustin.gutierrez@amd.com, kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Roman Li <Roman.Li@amd.com>

This DC patchset brings improvements in multiple areas. In summary, we
highlight:

* Fixes null-deref regression after
  "drm/amd/display: Update OPP counter from new interface"
* Fixes display flashing when VSR and HDR enabled on dcn32
* Fixes dcn3x intermittent hangs due to FPO
* Fixes MST Multi-Stream light up on dcn35
* Fixes green screen on DCN31x when DVI and HDMI monitors attached
* Adds DML2 improvements
* Adds idle power optimization improvements
* Accommodates panels with lower nit backlight
* Updates SDP VSC colorimetry from DP test automation request
* Reverts "drm/amd/display: allow edp updates for virtual signal"
* Removes duplicated edp relink to fastboot

Cc: Daniel Wheeler <daniel.wheeler@amd.com>

Agustin Gutierrez (1):
  drm/amd/display: Remove power sequencing check

Alex Hung (2):
  drm/amd/display: Revert "drm/amd/display: allow edp updates for
    virtual signal"
  drm/amd/display: Set emulated sink type to HDMI accordingly.

Alvin Lee (1):
  drm/amd/display: Update FAMS sequence for DCN30 & DCN32

Aric Cyr (1):
  drm/amd/display: 3.2.256

Aurabindo Pillai (1):
  drm/amd/display: add interface to query SubVP status

Chiawen Huang (1):
  drm/amd/display: remove duplicated edp relink to fastboot

Fangzhi Zuo (1):
  drm/amd/display: Fix MST Multi-Stream Not Lighting Up on dcn35

George Shen (1):
  drm/amd/display: Update SDP VSC colorimetry from DP test automation
    request

Hugo Hu (1):
  drm/amd/display: reprogram det size while seamless boot

Ilya Bakoulin (1):
  drm/amd/display: Fix shaper using bad LUT params

Iswara Nagulendran (1):
  drm/amd/display: Read before writing Backlight Mode Set Register

Michael Strauss (1):
  drm/amd/display: Disable SYMCLK32_SE RCO on DCN314

Nicholas Kazlauskas (2):
  drm/amd/display: Revert "Improve x86 and dmub ips handshake"
  drm/amd/display: Fix IPS handshake for idle optimizations

Qingqing Zhuo (1):
  drm/amd/display: fix compilation warning in dml2

Rodrigo Siqueira (3):
  drm/amd/display: Correct enum typo
  drm/amd/display: Add prefix to amdgpu crtc functions
  drm/amd/display: Add prefix for plane functions

Samson Tam (2):
  drm/amd/display: fix num_ways overflow error
  drm/amd/display: add null check for invalid opps

Sung Joon Kim (2):
  drm/amd/display: Add a check for idle power optimization
  drm/amd/display: Fix HDMI framepack 3D test issue

Swapnil Patel (1):
  drm/amd/display: Reduce default backlight min from 5 nits to 1 nits

Wenjing Liu (2):
  drm/amd/display: add pipe resource management callbacks to DML2
  drm/amd/display: implement map dc pipe with callback in DML2

 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |   5 +-
 .../amd/display/amdgpu_dm/amdgpu_dm_crtc.c    |  48 +-
 .../amd/display/amdgpu_dm/amdgpu_dm_debugfs.c |   4 +
 .../amd/display/amdgpu_dm/amdgpu_dm_plane.c   | 542 +++++++++---------
 .../amd/display/amdgpu_dm/amdgpu_dm_plane.h   |   2 +-
 drivers/gpu/drm/amd/display/dc/core/dc.c      |  88 +--
 .../gpu/drm/amd/display/dc/core/dc_resource.c |   2 +-
 drivers/gpu/drm/amd/display/dc/dc.h           |   4 +-
 drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c  |  26 +-
 .../drm/amd/display/dc/dcn31/dcn31_hubbub.c   |  23 +
 .../amd/display/dc/dcn314/dcn314_resource.c   |   2 +-
 .../gpu/drm/amd/display/dc/dcn32/dcn32_init.c |   2 +-
 .../drm/amd/display/dc/dcn32/dcn32_resource.c |   9 +-
 .../amd/display/dc/dcn321/dcn321_resource.c   |   8 +-
 .../drm/amd/display/dc/dcn35/dcn35_resource.c |   5 +
 .../display/dc/dml2/dml2_dc_resource_mgmt.c   | 146 +++++
 .../display/dc/dml2/dml2_translation_helper.c |   2 +
 .../drm/amd/display/dc/dml2/dml2_wrapper.h    |  16 +
 .../amd/display/dc/hwss/dce110/dce110_hwseq.c |   8 +-
 .../amd/display/dc/hwss/dcn20/dcn20_hwseq.c   |   6 +
 .../amd/display/dc/hwss/dcn30/dcn30_hwseq.c   |  21 +-
 .../amd/display/dc/hwss/dcn31/dcn31_hwseq.c   |  11 +
 .../amd/display/dc/hwss/dcn32/dcn32_hwseq.c   |  39 +-
 .../amd/display/dc/hwss/dcn32/dcn32_hwseq.h   |   3 +
 .../amd/display/dc/hwss/dcn35/dcn35_hwseq.c   |   8 +-
 .../gpu/drm/amd/display/dc/inc/hw/dchubbub.h  |   1 +
 drivers/gpu/drm/amd/display/dc/irq_types.h    |   6 +-
 .../display/dc/link/accessories/link_dp_cts.c |   6 +
 .../gpu/drm/amd/display/dc/link/link_dpms.c   |   3 +-
 .../link/protocols/link_edp_panel_control.c   |  11 +-
 .../gpu/drm/amd/display/dmub/src/dmub_srv.c   |   1 +
 .../drm/amd/display/include/signal_types.h    |   1 -
 32 files changed, 651 insertions(+), 408 deletions(-)

-- 
2.34.1

