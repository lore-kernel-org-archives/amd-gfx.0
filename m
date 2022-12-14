Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E282EC4332F
	for <amd-gfx@archiver.kernel.org>; Wed, 14 Dec 2022 20:21:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3027810E050;
	Wed, 14 Dec 2022 20:21:52 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2052.outbound.protection.outlook.com [40.107.93.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 491AD10E050
 for <amd-gfx@lists.freedesktop.org>; Wed, 14 Dec 2022 20:21:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HyUhi493MLqqaiGX3yraz7Iore9b4O67+KV8Sgj+tSFYNboGs3l8rokuFXjxC5o0hqUB8tF0fU86ro8/uPnh5DiB4QrZSbNUheEqHX8L8f/XhqCPeiA3htR4vvHT7+FgLMRSyyOIP9M8JaOUa3q6sDknBYpZyzlqnXb0nZbCEo6S1Nirgq8/hv+lhRBjuQISjlr9uhdsBuUQ0fBxwBj5PZAwxbNsh3D7MiwsadQPm0TVfQ2PVXpj9BZmxH3ae++yCI08IaXo0b7Wcq5hz//JpyT2F03vfU7bq+TPhNPEjXzxN1dz4n4CnD3gR8EM3AhLCMjpQllixKxUawLFN0BGYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Zzr5cSeDsNd+EQsEFBvXeDxEEJMqSjWZfcKKuebsdgU=;
 b=Mb2+azmtxeH0cWOPWCUkeOTK9kfTpL2ypfyH5eBVqVOB6XBnZUBaf/vjhbyJ15RqhORDDA+pkRLEqNzKkOVQ2HqtJOCzLmWbD+R5BW0x9Rvb9BrUWlO03BUyTHpbZkdUc3BLGvcq3lWvC399d66Kxt9RUw25xZpbybmqkrH7UfFeaR4Eok/PZ/1IyacBO+faMbUOBEbPySLrylxQj90Vcybu6sTwW3Gd7mqvhSVFe+fh771jCZ8xMJmNv/izWMXUeznUrxAsY4bHKkbO8y+6tU7uhBFfUKXqCcXUEwJu7Acu8f+GhMRprK5wb3MY6V2PyTyvJtsib/LG+QoHFl/qYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zzr5cSeDsNd+EQsEFBvXeDxEEJMqSjWZfcKKuebsdgU=;
 b=VxewhgBfFt6Jx6rvmbLsyDiwn/yRlNje08PSsu+cmmI5WGi8LFEWiBv8PO5MopCKwTDADZ0WrCLZjjqjI81xv/BfUbPbRQqhftAviIXj+Zt4tKarZ9qvfx7UO3qKhpk4rLZw6XkSAqqRdiBWvcQ7SlNOYtf/+SDJdhvsZ3rW3CY=
Received: from MW4PR03CA0184.namprd03.prod.outlook.com (2603:10b6:303:b8::9)
 by CY8PR12MB7633.namprd12.prod.outlook.com (2603:10b6:930:9c::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.19; Wed, 14 Dec
 2022 20:21:44 +0000
Received: from CO1NAM11FT030.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b8:cafe::59) by MW4PR03CA0184.outlook.office365.com
 (2603:10b6:303:b8::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.11 via Frontend
 Transport; Wed, 14 Dec 2022 20:21:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT030.mail.protection.outlook.com (10.13.174.125) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5924.11 via Frontend Transport; Wed, 14 Dec 2022 20:21:44 +0000
Received: from SATLEXMB07.amd.com (10.181.41.45) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 14 Dec
 2022 14:21:43 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB07.amd.com
 (10.181.41.45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 14 Dec
 2022 12:21:42 -0800
Received: from aaurabin-elitedesk-arch.amd.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2375.34
 via Frontend Transport; Wed, 14 Dec 2022 14:21:42 -0600
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 00/18] DC Patches for Dec 19, 2022
Date: Wed, 14 Dec 2022 15:21:23 -0500
Message-ID: <20221214202141.1721178-1-aurabindo.pillai@amd.com>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT030:EE_|CY8PR12MB7633:EE_
X-MS-Office365-Filtering-Correlation-Id: c16010d8-8cb4-4314-1914-08dade10d192
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kXIbLL98C/ekrmhlrkI6uZS1vIUziZ7iidwAt5iKgVBEfRbu2HDkqvEg6GndBuK56SrNR2RHu+5xVGv+7xnOl0UqMMfjsuPFdO0eJJLLvwixhaVGB6ofev59Ob1ULxhFstfD/U+W4Ij6iTNaGFudEn5XogZaSwJpPdJ38QWTAqcSNSVKc4krZxQzLkZamUYGbQTNeKSFs1dHeXM9t3bXpyUHawFyDn+tz9852mqB+RfK8XILC3HdxzpHCcMvgNNyj92UQRsBLSo8a+WjIeIcc81bw53jzjFxFdEo1zZ7V4lIr6GnVeo67b96HCQD0bZZa9Vbrn75mCrqNL16I3FagOPk3E3E4RjJQBBxskeMFd4tH74AAVqUEcz01bA2LEPjpbQH56hpL/pMn870zKs5fNNN73fzsFF3a0eiqw8BaGpDgG5EQjD0KZ1dMiXl0P0eP7oDatQnAAFA6yIMmu9XtkullwH0ZSRoaoXAtnbWQYcKRJmCeWdyDdJ3DrrPmqYGhdJZFuS9l7E41dw+OTqU5SFP+/pn/lu+f7DGCrhTa2y3K9jTk5L7AYJhgUg0wT6X/eQO5fy/PFY7KZNQINAc8hrnIcbgKRimmi74VkeH7l2tmreTRie+yt+aRjxuy/nDSqahItgV3F1pKmLOspEVBB0t3khJsQ5uo/nmDY0hctQkK8DFOK5lbrsUB5vBQsZHWiVIysJcYiLQfrQL1+EWWEUTcXet9WmfuOgjqSzQ6Dc=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:CA; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(376002)(396003)(39860400002)(346002)(136003)(451199015)(40470700004)(46966006)(36840700001)(6666004)(7696005)(316002)(6916009)(54906003)(478600001)(336012)(2906002)(47076005)(70586007)(186003)(70206006)(4326008)(1076003)(8676002)(41300700001)(2616005)(426003)(83380400001)(5660300002)(44832011)(8936002)(40480700001)(82310400005)(36860700001)(26005)(86362001)(82740400003)(36756003)(40460700003)(81166007)(356005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Dec 2022 20:21:44.1639 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c16010d8-8cb4-4314-1914-08dade10d192
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT030.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7633
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
 solomon.chiu@amd.com, Aurabindo.Pillai@amd.com, wayne.lin@amd.com,
 Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This DC patchset brings improvements in multiple areas. In summary, we have:

* Fixes for various features like SubVP, ABM, HDCP, Secure display
* Fix a stability issue when running IGT test suite
* Improvements for eDP panels

-----

Alan Liu (1):
  drm/amd/display: Improvements in secure display

Alex Hung (1):
  drm/amd/display: Use mdelay to avoid crashes

Aric Cyr (2):
  drm/amd/display: Reorder dc_state fields to optimize clearing the
    struct
  drm/amd/display: 3.2.217

Aurabindo Pillai (1):
  drm/amd/display: set ignore msa parameter only if freesync is enabled

Dmytro Laktyushkin (1):
  drm/amd/display: fix dc_get_edp_link_panel_inst to only consider links
    with panels

Lee, Alvin (1):
  drm/amd/display: Turn on phantom OTG before disabling phantom pipe

Leo Chen (1):
  drm/amd/display: Adding braces to prepare for future changes to
    behavior of if block

Leon Huang (2):
  drm/amd/display: Refactor ABM code flow
  drm/amd/display: Fix crash when setting ABM pipe/backlight

Nicholas Kazlauskas (1):
  drm/amd/display: Defer DIG FIFO disable after VID stream enable

Samson Tam (1):
  drm/amd/display: Uninitialized variables causing 4k60 UCLK to stay at
    DPM1 and not DPM0

Swapnil Patel (1):
  drm/amd/display: patch cases with unknown plane state to prevent
    warning

Wenjing Liu (3):
  drm/amd/display: move dccg programming from link hwss hpo dp to hwss
  drm/amd/display: update pixel rate div in enable stream
  drm/amd/display: allow hpo and dio encoder switching during dp retrain
    test

hersen wu (2):
  drm/amd/display: save restore hdcp state when display is unplugged
    from mst hub
  drm/amd/display: phase3 mst hdcp for multiple displays

 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 219 ++++++++++++---
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_crc.c |   6 +
 .../amd/display/amdgpu_dm/amdgpu_dm_hdcp.h    |  14 +
 .../display/amdgpu_dm/amdgpu_dm_mst_types.c   |  26 ++
 drivers/gpu/drm/amd/display/dc/core/dc.c      |  61 ++---
 drivers/gpu/drm/amd/display/dc/core/dc_link.c |   3 -
 .../gpu/drm/amd/display/dc/core/dc_link_dp.c  |  64 ++---
 .../gpu/drm/amd/display/dc/core/dc_resource.c |  39 +++
 drivers/gpu/drm/amd/display/dc/dc.h           |   6 +-
 drivers/gpu/drm/amd/display/dc/dc_link.h      |  15 +-
 drivers/gpu/drm/amd/display/dc/dce/Makefile   |   3 +-
 drivers/gpu/drm/amd/display/dc/dce/dmub_abm.c | 249 +++++++----------
 .../gpu/drm/amd/display/dc/dce/dmub_abm_lcd.c | 259 ++++++++++++++++++
 .../gpu/drm/amd/display/dc/dce/dmub_abm_lcd.h |  45 +++
 .../display/dc/dce110/dce110_hw_sequencer.c   |  15 +-
 .../drm/amd/display/dc/dcn20/dcn20_hwseq.c    |  86 ++++++
 .../drm/amd/display/dc/dcn21/dcn21_hwseq.c    |  69 +++--
 .../amd/display/dc/dcn301/dcn301_resource.c   |   3 +-
 .../dc/dcn314/dcn314_dio_stream_encoder.c     |   6 +-
 .../drm/amd/display/dc/dcn32/dcn32_hwseq.c    |  36 +++
 .../drm/amd/display/dc/dcn32/dcn32_hwseq.h    |   2 +
 .../gpu/drm/amd/display/dc/dcn32/dcn32_init.c |   1 +
 .../dc/dml/dcn32/display_mode_vba_util_32.c   |   6 +-
 .../gpu/drm/amd/display/dc/inc/core_types.h   |  18 +-
 drivers/gpu/drm/amd/display/dc/inc/hw/abm.h   |   6 +
 .../gpu/drm/amd/display/dc/inc/hw_sequencer.h |   1 +
 drivers/gpu/drm/amd/display/dc/inc/resource.h |   9 +
 .../amd/display/dc/link/link_hwss_hpo_dp.c    |  37 ---
 28 files changed, 946 insertions(+), 358 deletions(-)
 create mode 100644 drivers/gpu/drm/amd/display/dc/dce/dmub_abm_lcd.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/dce/dmub_abm_lcd.h

-- 
2.39.0

