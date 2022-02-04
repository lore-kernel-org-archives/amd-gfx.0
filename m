Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58B2AC433F5
	for <amd-gfx@archiver.kernel.org>; Fri,  4 Feb 2022 19:04:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DB3A810E352;
	Fri,  4 Feb 2022 19:04:19 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2070.outbound.protection.outlook.com [40.107.237.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D752B10E352
 for <amd-gfx@lists.freedesktop.org>; Fri,  4 Feb 2022 19:04:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OU473kXqtXZ05zRnhfI9bAN0B4Ts1vZqWKCF2GAXfjcgvDiqAIC8h8BQXg0iVAEI5BzfT6DxJXncsHohwpNMfe2ZmDw/Yw9IJ382PSK7mhxDuAMk3ObnKPWTJ7SQchSqiAwbOxmtpi07N06te2rwzJFu4Z/MjgQKBz3/oZLlKlEGcwZ9uD0aczbsfnM0UOZUX674GppwDAJtXuGuAkC3235vhWYXU35yV3or4rs7jUw6Jzbs/9JYHiqfsm3Gy3kbJiW4asV8yQG+mikQqey/5li0m/P8J30q3Y15YmKMLluYB8Q6KPQ2AGtptqOlJaDsGO5ZQFojaXVvEbs0UMQGWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qPBdmjUDGhQSPASqFXtPTp5kk3fwoKc3mnQ340yAcgg=;
 b=VYkJpr40Y9OSUZkByyi26WKLNKRgeers53UaL8omKNd/uUGzEyp5EFmnUo0K2sNi76wEN6/gK+4UjHfoVxktxHgGgZITS0LYaNqvBCrtGSGzb0p/lsIt9DNoK3Ugco52WgVesypxBxJhNAQjO4ly7VAmUzik2/ZOSUINccoyb1UTC5e4p7sP4IwCKMDINGhzdVGiSL0R8i3LvTt624Vp29hvV4D/+SzPSkhMoKEDRtDEvWDYrJ9F6v3f7OrQ6/UoSPxEcjnYG7eSQWuyKunbuy4DwXOJfO+ozq31GG5XXko3zLXvQTS6/lZXxutI0hVFRsi6hWm9n+OdVVNUwzJzgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qPBdmjUDGhQSPASqFXtPTp5kk3fwoKc3mnQ340yAcgg=;
 b=cHDu6qX7vowYnViW08Rj8iRefhAPE1g/VAA7XBFIPMdV+dwV1/YZZxep8JsWVPUoLDl86OsfpVdeTViQtN1uM31sVppt5seei8nBntAJ+H8j7O+ZCrmT8iRI8PS5wkL5c4re7cjbyWrSDKvTrg+z56iXRTolCPrXduJ0k4bPAaY=
Received: from MW4P223CA0020.NAMP223.PROD.OUTLOOK.COM (2603:10b6:303:80::25)
 by BYAPR12MB4757.namprd12.prod.outlook.com (2603:10b6:a03:97::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.12; Fri, 4 Feb
 2022 19:04:15 +0000
Received: from CO1NAM11FT033.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:80:cafe::1) by MW4P223CA0020.outlook.office365.com
 (2603:10b6:303:80::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.12 via Frontend
 Transport; Fri, 4 Feb 2022 19:04:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT033.mail.protection.outlook.com (10.13.174.247) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4951.12 via Frontend Transport; Fri, 4 Feb 2022 19:04:15 +0000
Received: from jasdeep-System-Product-Name.hitronhub.home (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.18; Fri, 4 Feb 2022 13:04:12 -0600
From: Jasdeep Dhillon <jdhillon@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 00/13] DC Patches Feburary 7, 2022
Date: Fri, 4 Feb 2022 14:03:44 -0500
Message-ID: <20220204190357.94538-1-jdhillon@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a6889785-da60-4cd0-ab29-08d9e811233e
X-MS-TrafficTypeDiagnostic: BYAPR12MB4757:EE_
X-Microsoft-Antispam-PRVS: <BYAPR12MB4757172997E52E72D36BFAA1FB299@BYAPR12MB4757.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7YK6aNTBvFX2bS+g+wQWbxWzZ43sTTuV7DL7XabdcIyQybcQcAEKKxV02nQOI6S4N+1ANa/BcShop2p5a9MEvzrdgtSK8vXUHT/6Evh4+tp3fashJGSs7dPksxIrky+gVq1nBgvHfe4DCjszscFazzqn4T0xnhHSjzHa9Tpt+DopUJDt+vFDlwYh56TIptRKG/HNUitM+5+lzLakzfYcHMKb3iI5BzYjrNDCj43qGrjlcxKgSaKxZ/mrrz9waktlXEJdM5G2SveRK2+CJUtnu2GzIYEE6thM9enuOrP2HryN8y/BK16t7nmhKGftFhBayYjvUJ8+8iExXE4dz7ZzRlDZsvrwRyLDzkPGk8B1W12yjxUohah/vuxSXCQR7WALd7PXEy4fZyQ8OG9l0hhjBjNrZ+Gl8Ys111d7WlGDJb4gplcgaEnwowNyreLOtWmHyc5Xtxj9xLMdNycxiMKthxjp5PXKLKKu2pOusHO1v+YEYxBwyi5AlYsyi/Hct51Ss5O5pq39doEIRKv6WebDSCNKdWCdeifFgNwNZcw2IMWZx+JxawprdP4jAMP7HdUenQOsQzYWce2wLGipQDrmc4QpnCXO80wbnZCX+vptGej1Cpf3i1r+InW6yqHfak5QqIYwG3PKv7gLdkWWkkDO4B/Zz9AbnaUtJEMpeB7r236TSPUijHDNQwOekNRZrahU2rYSHLZHfs3+QiCVSMgwSg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(36840700001)(46966006)(40470700004)(6916009)(83380400001)(26005)(54906003)(4326008)(70206006)(8676002)(8936002)(316002)(82310400004)(336012)(508600001)(6666004)(70586007)(186003)(426003)(2906002)(356005)(1076003)(81166007)(36860700001)(16526019)(2616005)(5660300002)(36756003)(40460700003)(47076005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2022 19:04:15.1158 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a6889785-da60-4cd0-ab29-08d9e811233e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT033.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB4757
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
 Aurabindo.Pillai@amd.com, wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com,
 agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This DC patchset brings improvements in multiple areas. In summary, we have:
-fix for build failure uninitalized error
-Bug fix for DP2 using uncertified cable
-limit unbounded request to 5k
-fix DP LT sequence on EQ fail
-Bug fixes for S3/S4

Anthony Koo (1):
  drm/amd/display: [FW Promotion] Release 0.0.103.0

Aric Cyr (1):
  drm/amd/display: 3.2.172

Dmytro Laktyushkin (2):
  drm/amd/display: limit unbounded requesting to 5k
  drm/amd/display: fix yellow carp wm clamping

Eric Bernstein (2):
  drm/amd/display: Fix for variable may be used uninitialized error
  drm/amd/display: remove static from optc31_set_drr

Guo, Bing (1):
  dc: do blocked MST topology discovery at resume from S3/S4

Ilya (1):
  drm/amd/display: Fix DP LT sequence on EQ fail

Martin Tsai (1):
  drm/amd/display: handle null link encoder

Nicholas Kazlauskas (1):
  drm/amd/display: Fix stream->link_enc unassigned during stream removal

Oliver Logush (1):
  drm/amd/display: Basic support with device ID

Paul Hsieh (1):
  drm/amd/display: change fastboot timing validation

Zhan Liu (1):
  drm/amd/display: keep eDP Vdd on when eDP stream is already enabled

 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 24 +++++++-
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h |  2 +-
 .../gpu/drm/amd/display/dc/clk_mgr/clk_mgr.c  |  2 +-
 drivers/gpu/drm/amd/display/dc/core/dc.c      |  2 +-
 drivers/gpu/drm/amd/display/dc/core/dc_link.c | 27 ++------
 .../gpu/drm/amd/display/dc/core/dc_link_dp.c  |  4 +-
 .../gpu/drm/amd/display/dc/core/dc_resource.c |  8 +--
 drivers/gpu/drm/amd/display/dc/dc.h           |  4 +-
 drivers/gpu/drm/amd/display/dc/dc_link.h      |  1 +
 .../display/dc/dce110/dce110_hw_sequencer.c   | 27 +++++++-
 .../drm/amd/display/dc/dcn20/dcn20_resource.c | 11 +---
 .../drm/amd/display/dc/dcn31/dcn31_hubbub.c   | 61 ++++++++++---------
 .../gpu/drm/amd/display/dc/dcn31/dcn31_optc.c |  2 +-
 .../gpu/drm/amd/display/dc/dcn31/dcn31_optc.h |  2 +
 .../drm/amd/display/dc/dcn31/dcn31_resource.c |  3 +-
 .../gpu/drm/amd/display/dmub/inc/dmub_cmd.h   |  4 +-
 .../gpu/drm/amd/display/include/dal_asic_id.h |  3 +-
 17 files changed, 104 insertions(+), 83 deletions(-)

-- 
2.25.1

