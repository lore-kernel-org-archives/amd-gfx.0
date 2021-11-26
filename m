Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDE51C433F5
	for <amd-gfx@archiver.kernel.org>; Fri, 26 Nov 2021 19:49:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 233FC6E09C;
	Fri, 26 Nov 2021 19:49:30 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2042.outbound.protection.outlook.com [40.107.244.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8F4CD6E09C
 for <amd-gfx@lists.freedesktop.org>; Fri, 26 Nov 2021 19:49:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SSZ+bv8bsYtKekoJs0ce3WaPFZ8rMXbWkU3SkVmvIQIQNMUHbnPLRWGPwQZXcSNU5nDOmgyMBS6bXi1EYWF7gD9qvP6oBY7YU5r4gYMd2ZQcUYvsMncGr6PBZ5sgZh/FpmxK1MeA9ankjWBnkakMD+Ab3TrpvS6hq0F99FJ60q+XUYVxtCCBfuIUT/Gg2mS2JBkMCjDez2kjCtRwWGzxlc20u3idYLHE1YesdR3+ObLFwjErDAZpNkBu4t2Lxa2t/f3SeBFpc1LEWLupJ9B/W/ps2uXb2K2r90BZTEs3eWL7w1KPsu7l1YlZw9U7NlpNGAob16HIUtSVmuP2Q5WEqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=33Qvp6ZT89nTCF+jPfTTTiFo1UZgaA5nEGfK7Cn6ZWQ=;
 b=dgR+cn6wtYPoMXdZdc1CAmf3G4Dwu05TITF0GcCImPLdZ1oxyHYbOKKV6BUnfujgZxv40FALBmnSGoalRoRhUKtPpz/PwyYAvbL3qA/WDTK9Q/wCA57+Qi1NARx2qUDbeeBTci4erwFiESp50m9mnL4G7Jmc+y3pB09d4h30Q2c6QKTZCPJ5TLb5VcUStnBah1Ty3seDTyGuEmjhoi1M9pYLg4Wzte55wsD+OUUM6ONHi/w6HwX8rnluAZ8V9fidd4pXvvCjJt5GVeRDtCJRhkVuYHyNIOtQEF3O6RtsW2GtxCUhNBOT4gE1S7W7vP0FeIPIppjbmXWuHNq/l0jiqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=33Qvp6ZT89nTCF+jPfTTTiFo1UZgaA5nEGfK7Cn6ZWQ=;
 b=ltGficr7SYJEcHmBeZ1XhMAOjzfyxwYqBu1OJeeo8G/mXBO6VGVeoCMCL7ehFdxGR0P9J0MoZV8c1GViulHu7gSmuQyxfZwn09xAVWAtg3rTInEVz1ibTCwfpt0udciO5XfOX3yESSALPELSXo3vy4esCnietPuDcGdK+SJvXk8=
Received: from BN1PR12CA0021.namprd12.prod.outlook.com (2603:10b6:408:e1::26)
 by BN8PR12MB4627.namprd12.prod.outlook.com (2603:10b6:408:a9::31)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.22; Fri, 26 Nov
 2021 19:49:25 +0000
Received: from BN8NAM11FT053.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e1:cafe::d8) by BN1PR12CA0021.outlook.office365.com
 (2603:10b6:408:e1::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.20 via Frontend
 Transport; Fri, 26 Nov 2021 19:49:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT053.mail.protection.outlook.com (10.13.177.209) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4734.22 via Frontend Transport; Fri, 26 Nov 2021 19:49:25 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Fri, 26 Nov
 2021 13:49:25 -0600
Received: from blakha.ht.home (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.17 via Frontend
 Transport; Fri, 26 Nov 2021 13:49:24 -0600
From: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 00/16] DC Patches Nov 26, 2021
Date: Fri, 26 Nov 2021 14:49:06 -0500
Message-ID: <20211126194922.816835-1-Bhawanpreet.Lakha@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1e89bc1b-eef9-47e4-86dc-08d9b115d9d0
X-MS-TrafficTypeDiagnostic: BN8PR12MB4627:
X-Microsoft-Antispam-PRVS: <BN8PR12MB4627025543F2BCC500E17ACFF9639@BN8PR12MB4627.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4MbDRBvlUs86lPBXNCs7zdewCwahIxC1jf1O5OsX74x1leXUqzjAngV49yRIley+VvTfFtM3ZKwQNwk80ozvL49n4PqsZs5JWz0LskW3K4pjQA9gr4rExgGkuvZvh7zDENhaf3lLEGxANYQsj4sj3epZbI004jA6W5wJAlaAvJHuf2o1gLrhPD2umpKdbOlq2LeuXu6zY0wKrhgRviqb2NNWKEQtk45b7zaKvfUUUrbeQ3etZWYcU6RO51Rxfg9OrnPv5TrGQ82QzCJ2cZx48xmc7JeHhqskHmhSzftGGKFD7kAtoKJT4esXndeRcKJofNjTVyQYZqemwVQxbMiPTON6IS6G8InbHg2PanfYKqkwA6sYYAY+OwGKiYuAP4iMHN04Kl5Pruw4n53sYvGyl/RDtSsAwjj46kutLEi9XpEG7C9W90WZ23QOUS/t1djNA3H5/Y/WfH0Yd4SsrfARKrQGbgC/HzZwWEkpeqxN6Kf4CDVntyvaPeZ7aVPTYeYjLaazZuFIFLUQMtzS8bBjRW1L/J3AWMP+7sIMg3OO8u7ZjTkMz8/OtazbZwRaGmLwPg8viyGWW/noxhax86EbfYllTAWTxGNsNWwCDp+dRKephVM5McQOaHK2osQeM35XoKPgrIux6ZmzH54M3xHNWYkX0L+U7Mm8t/hh+1yKQ/JQvLAW72/P/BvPN5utcdMTjx+u0vjsTvw3fBmdrappRtljbDWQVp5XKkzurKcd8Fw=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(70206006)(356005)(36756003)(6666004)(1076003)(508600001)(2906002)(26005)(8936002)(82310400004)(2616005)(6916009)(36860700001)(186003)(83380400001)(70586007)(81166007)(54906003)(316002)(426003)(336012)(47076005)(5660300002)(4326008)(8676002)(86362001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2021 19:49:25.5967 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e89bc1b-eef9-47e4-86dc-08d9b115d9d0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT053.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB4627
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
Cc: stylon.wang@amd.com, solomon.chiu@amd.com, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 roman.li@amd.com, Anson.Jacob@amd.com, Aurabindo.Pillai@amd.com,
 wayne.lin@amd.com, mikita.lipski@amd.com, Bhawanpreet.Lakha@amd.com,
 agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This DC patchset brings improvements in multiple areas. In summary, we have:
- FW promotion to 0.0.95
- DSC fixes for supported Docks
- Fixes eDP display issue
- Vendor LTTR workarounds
- Fixes Tiled display audio issue


Anthony Koo (1):
  drm/amd/display: [FW Promotion] Release 0.0.95

Aric Cyr (1):
  drm/amd/display: 3.2.164

Brandon Syu (1):
  drm/amd/display: Fix dual eDP abnormal display issue

Dale Zhao (1):
  drm/amd/display: add hdmi disable debug check

Evgenii Krasnikov (1):
  drm/amd/display: add function for eDP and backlight power on

George Shen (3):
  drm/amd/display: Add vendor specific LTTPR workarounds for DCN31
  drm/amd/display: Skip vendor specific LTTPR w/a outside link training
  drm/amd/display: Add 16ms AUX RD interval W/A for specific LTTPR

Jimmy Kizito (1):
  drm/amd/display: Add work around for tunneled MST.

Meenakshikumar Somasundaram (1):
  drm/amd/display: Fix for otg synchronization logic

Michael Strauss (1):
  drm/amd/display: Add force detile buffer size debug flag

Mikita Lipski (1):
  drm/amd/display: PSR panel capability debugfs

Mustapha Ghaddar (1):
  drm/amd/display: Fix for the no Audio bug with Tiled Displays

Nicholas Kazlauskas (1):
  drm/amd/display: Allow DSC on supported MST branch devices

Shen, George (1):
  drm/amd/display: Clear DPCD lane settings after repeater training

Stylon Wang (1):
  drm/amd/display: Enable P010 for DCN3x ASICs

 .../amd/display/amdgpu_dm/amdgpu_dm_debugfs.c |  44 ++++
 .../display/amdgpu_dm/amdgpu_dm_mst_types.c   |  20 +-
 drivers/gpu/drm/amd/display/dc/core/dc.c      |  35 +--
 drivers/gpu/drm/amd/display/dc/core/dc_link.c |  16 ++
 .../gpu/drm/amd/display/dc/core/dc_link_dp.c  | 227 +++++++++++++++++-
 .../gpu/drm/amd/display/dc/core/dc_resource.c |  78 +++++-
 drivers/gpu/drm/amd/display/dc/dc.h           |  19 +-
 drivers/gpu/drm/amd/display/dc/dc_link.h      |   6 +
 .../drm/amd/display/dc/dce/dce_link_encoder.c |   5 +-
 .../display/dc/dce110/dce110_hw_sequencer.c   |  16 +-
 .../amd/display/dc/dcn10/dcn10_link_encoder.c |   5 +-
 .../drm/amd/display/dc/dcn30/dcn30_resource.c |   2 +-
 .../amd/display/dc/dcn301/dcn301_resource.c   |   2 +-
 .../amd/display/dc/dcn302/dcn302_resource.c   |   2 +-
 .../amd/display/dc/dcn303/dcn303_resource.c   |   2 +-
 .../drm/amd/display/dc/dcn31/dcn31_resource.c |   9 +-
 .../gpu/drm/amd/display/dc/inc/core_types.h   |   1 +
 .../gpu/drm/amd/display/dc/inc/dc_link_dp.h   |   1 +
 drivers/gpu/drm/amd/display/dc/inc/resource.h |  11 +
 .../gpu/drm/amd/display/dmub/inc/dmub_cmd.h   |   4 +-
 20 files changed, 457 insertions(+), 48 deletions(-)

-- 
2.25.1

