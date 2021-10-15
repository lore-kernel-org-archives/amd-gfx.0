Return-Path: <SRS0=EPaF=PD=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2755FC433F5
	for <amd-gfx@archiver.kernel.org>; Fri, 15 Oct 2021 18:43:54 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DC99F60C4A
	for <amd-gfx@archiver.kernel.org>; Fri, 15 Oct 2021 18:43:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org DC99F60C4A
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 135D16E3C1;
	Fri, 15 Oct 2021 18:43:53 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2049.outbound.protection.outlook.com [40.107.220.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 03E81896E9
 for <amd-gfx@lists.freedesktop.org>; Fri, 15 Oct 2021 18:43:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X8WH1irqFBeBSz+suFZk/yDdck+4Q3G4Ccc48UqdImYd51iIoK1k+rTPjZIhNqRrUAsUDq0fe8DmYuUPDC/CEmTouF0nFwKZ2hKB65I9MGo+FhT+5qrcEa07B0bEsblyeOmwAdTcUWTyl+D5kzXpnFGU5s5R7G9GeyBAGsKrtKD53KEicENUtENQ9bn1dEweEMvk3SnxFrJ4TKQMFc/oPWWWSqkAFGw8qzerE3VH7XFLqksmUNfxrT/q0JE+0eR7oSaR5bx4L6hvppQd6UKzi4wXXNpwxVCCwwcARf5jhrAW6szzWb3+ErWbM+JmCtFW6saE3gIcbC+WqvIJDS3Iqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9jkFAVM8sp4iLdFtgA/qeNPVJu9h4FQLAuzHNnNATIY=;
 b=WY3WrcshVDzxqBvVhhO73d1y3UYoXFZpVNWkmO2aqdaFMr6oLnGbo+qorSO8uZfd7a3L5pHbF/okQ2m8Kseh8L0X4yMVa3hHTSjCLhpP87cOEKnN6kFNSUYwSDESm2r9kQGA1STanZBM0qPp98nWkuejvAkmRUsu567Rkd+1bAyN+Ots7+NRfZfUbXkbsOuPAcZ/GH0gNnsd5+B2oUDMpp2V+2gSxyQsXXuQpCDize6m9PxFBhZTFrbTB4NdoduglRAw6vczMBGctbqmTZQQZk5rZj/i1ZINhSvzDtFS00Iydz9+s97fOg1ukFHRMma2LZKxgMLYgrdy0bC5n2Funw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9jkFAVM8sp4iLdFtgA/qeNPVJu9h4FQLAuzHNnNATIY=;
 b=nm8KZw3AuzbbmR4xiUKOBCY1f3edIfeCJ7ntkU1eFgfrhxO4v6i4V7cHBI1CfZe7BjVo4Mn6iHt4zaeMOgaHj5zkl2vOAaoZqaBOkTqXGmRMwJxXL45a3mvDcVC54D5gklkcY5NVsarg1DQ1CJ0k5Db9/W8u+fJqUR23SbtTuCw=
Received: from DS7PR03CA0071.namprd03.prod.outlook.com (2603:10b6:5:3bb::16)
 by DM6PR12MB4515.namprd12.prod.outlook.com (2603:10b6:5:2a1::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.16; Fri, 15 Oct
 2021 18:43:48 +0000
Received: from DM6NAM11FT025.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3bb:cafe::88) by DS7PR03CA0071.outlook.office365.com
 (2603:10b6:5:3bb::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.15 via Frontend
 Transport; Fri, 15 Oct 2021 18:43:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT025.mail.protection.outlook.com (10.13.172.197) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4608.15 via Frontend Transport; Fri, 15 Oct 2021 18:43:48 +0000
Received: from ubuntu.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.15; Fri, 15 Oct
 2021 13:43:46 -0500
From: Agustin Gutierrez <agustin.gutierrez@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Bhawanpreet.Lakha@amd.com>, <Rodrigo.Siqueira@amd.com>,
 <Aurabindo.Pillai@amd.com>, <qingqing.zhuo@amd.com>, <mikita.lipski@amd.com>, 
 <roman.li@amd.com>, <Anson.Jacob@amd.com>, <wayne.lin@amd.com>,
 <stylon.wang@amd.com>, <solomon.chiu@amd.com>, <pavle.kotarac@amd.com>,
 <agustin.gutierrez@amd.com>, Daniel Wheeler <daniel.wheeler@amd.com>, "Mark
 Broadworth" <mark.broadworth@amd.com>
Subject: [PATCH 00/27] DC Patchset for October 15
Date: Fri, 15 Oct 2021 14:43:05 -0400
Message-ID: <20211015184332.221091-1-agustin.gutierrez@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 61583640-6c28-48e4-3c21-08d9900bb9b0
X-MS-TrafficTypeDiagnostic: DM6PR12MB4515:
X-Microsoft-Antispam-PRVS: <DM6PR12MB451577B4CE1C5109AEA62E64F5B99@DM6PR12MB4515.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: y126qX+skeikayuxf7dRLWOK5aKbWDiKtaWxFjm00LERlE664p4+Tq5nzh6Z8Z9l0KT3lx3FTxErZviV+HxapLsYeiI6RMYX1Lrq+DhPGU11/CqB0+WvpDrU1Dcmq89yX79efMXuTJxuvaad5kRsjhWgTT7XFibao+60Ely+Foa140+a11+NyPh6JwnWY1zQzC8/V0rP9OpgzWhnK/guDoN4OkdgIWr52fTK9x9hviM6upVfYQA7+nxIoD9lKjFPfgNz61nHF5xdO8THV4KVAN2Zc8B30VoeGC6k6oOjkaZ0OosckIdZ1PAYvmlJOj58eVbdrwv33LnR0UFKrvXs9/i2ZhYGzCIOb/GfUeYguSRux9QK+vVeSn42oJt9HEqDwP76PN/OEuYfSVAyLVc34aTKJ2aBmdCKm/yPk+ANHkPcLA/5nANuAIVghrOb3vXdtYuQEZ99Jc2M71n4RvhHwe9xkPNKdrU3B7lVi4IwQmV9/Q2YRKFkBjGt6tCrsTLOKDsi6Izo6q5Fa39Zjlc5+zUMMNCwH6qmzJcJP5+ZYyZ5MhS0aoxBLqTYSyxQkIE3WTjBw6pjNsLJWsXhYGNo0qH1HttDkzpKiG2HATxfwpvAKB3Cvqn4ymiM6qpLPMxzOnaAsivdnA5ZmkvL4DBQVAr2JEDsPSQpckcw4FHfE04YOEhNIEaZYnHfjZbHm2G++OYCQeiPXgMzUJYsv1QVpy5p//zMDITp2r+u1xQ6UNM=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(5660300002)(4326008)(82310400003)(2616005)(47076005)(36756003)(426003)(44832011)(356005)(36860700001)(26005)(81166007)(186003)(336012)(16526019)(316002)(508600001)(1076003)(70206006)(8676002)(86362001)(2906002)(83380400001)(6666004)(70586007)(6916009)(54906003)(8936002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2021 18:43:48.3276 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 61583640-6c28-48e4-3c21-08d9900bb9b0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT025.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4515
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

This DC patchset brings improvements in multiple areas. In summary, we
highlight:

* Fix some issues such as DP2 problem, prefetch bandwidth calculation
for DCN3.1 and others.
* Increased Z9 latency and removed z10 save after dsc disable.
* Revert a couple of bad changes.
* Added missing PSR state patch.

Cc: Daniel Wheeler <daniel.wheeler@amd.com>
Cc: Mark Broadworth <mark.broadworth@amd.com>

Agustin Gutierrez (2):
  Revert "drm/amd/display: Fix error in dmesg at boot"
  Revert "drm/amd/display: Add helper for blanking all dp displays"

Anthony Koo (2):
  drm/amd/display: Change initializer to single brace
  drm/amd/display: [FW Promotion] Release 0.0.88

Aric Cyr (2):
  drm/amd/display: Validate plane rects before use
  drm/amd/display: 3.2.157

Eric Yang (1):
  drm/amd/display: increase Z9 latency to workaround underflow in Z9

Hansen (1):
  drm/amd/display: Fix DP2 SE and LE SYMCLK selection for B0 PHY

Jake Wang (6):
  drm/amd/display: Disable dpp root clock when not being used
  drm/amd/display: Disable dsc root clock when not being used
  drm/amd/display: Disable dpstreamclk, symclk32_se, and symclk32_le
  drm/amd/display: Removed z10 save after dsc disable
  drm/amd/display: Moved dccg init to after bios golden init
  drm/amd/display: Disable hdmistream and hdmichar clocks

Jimmy Kizito (2):
  drm/amd/display: Clear encoder assignment for copied streams
  drm/amd/display: Do not skip link training on DP quick hot plug

Josip Pavic (1):
  drm/amd/display: do not compare integers of different widths

Lai, Derek (1):
  drm/amd/display: Removed power down on boot from DCN31

Michael Strauss (1):
  drm/amd/display: Clean Up VPG Low Mem Power

Mikita Lipski (1):
  drm/amd/display: Add missing PSR state

Nevenko Stupar (1):
  drm/amd/display: Add bios parser support for latest firmware_info

Nicholas Kazlauskas (2):
  drm/amd/display: Fix prefetch bandwidth calculation for DCN3.1
  drm/amd/display: Require immediate flip support for DCN3.1 planes

Nikola Cornij (2):
  drm/amd/display: Limit display scaling to up to true 4k for DCN 3.1
  drm/amd/display: Increase watermark latencies for DCN3.1

Wenjing Liu (2):
  drm/amd/display: add DP2.0 debug option to set MST_EN for SST stream
  drm/amd/display: correct apg audio channel enable golden value

 .../drm/amd/display/dc/bios/bios_parser2.c    |  90 ++++++-
 .../display/dc/clk_mgr/dcn31/dcn31_clk_mgr.c  |  21 +-
 drivers/gpu/drm/amd/display/dc/core/dc.c      |  10 -
 drivers/gpu/drm/amd/display/dc/core/dc_link.c |  63 +----
 .../gpu/drm/amd/display/dc/core/dc_link_ddc.c |   2 +-
 .../gpu/drm/amd/display/dc/core/dc_link_dp.c  |  32 +--
 .../drm/amd/display/dc/core/dc_link_enc_cfg.c |   9 +-
 .../gpu/drm/amd/display/dc/core/dc_resource.c |   5 +
 .../gpu/drm/amd/display/dc/core/dc_stream.c   |   4 +
 drivers/gpu/drm/amd/display/dc/dc.h           |   3 +-
 drivers/gpu/drm/amd/display/dc/dc_link.h      |   1 -
 drivers/gpu/drm/amd/display/dc/dc_types.h     |   1 +
 drivers/gpu/drm/amd/display/dc/dce/dmub_psr.c |   2 +
 .../display/dc/dce110/dce110_hw_sequencer.c   |  24 +-
 .../amd/display/dc/dcn10/dcn10_hw_sequencer.c |  49 +++-
 .../gpu/drm/amd/display/dc/dcn20/dcn20_dccg.h |  34 ++-
 .../drm/amd/display/dc/dcn20/dcn20_hwseq.c    |   4 +-
 .../drm/amd/display/dc/dcn30/dcn30_hwseq.c    |  39 ++-
 .../gpu/drm/amd/display/dc/dcn31/dcn31_apg.c  |   2 +-
 .../gpu/drm/amd/display/dc/dcn31/dcn31_dccg.c | 237 +++++++++++++++++-
 .../gpu/drm/amd/display/dc/dcn31/dcn31_dccg.h |  34 ++-
 .../drm/amd/display/dc/dcn31/dcn31_hwseq.c    | 114 +++++----
 .../drm/amd/display/dc/dcn31/dcn31_resource.c |  17 +-
 .../dc/dml/dcn31/display_mode_vba_31.c        |   6 +-
 drivers/gpu/drm/amd/display/dc/inc/hw/dccg.h  |   9 +
 .../gpu/drm/amd/display/dc/inc/link_enc_cfg.h |   2 +-
 .../gpu/drm/amd/display/dmub/inc/dmub_cmd.h   |   4 +-
 .../include/asic_reg/dcn/dcn_3_1_2_offset.h   |   2 +
 .../include/asic_reg/dcn/dcn_3_1_2_sh_mask.h  |   8 +
 29 files changed, 643 insertions(+), 185 deletions(-)

-- 
2.25.1

