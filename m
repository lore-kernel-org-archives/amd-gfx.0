Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F8CFC4321E
	for <amd-gfx@archiver.kernel.org>; Wed, 30 Nov 2022 06:39:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 850C010E28A;
	Wed, 30 Nov 2022 06:39:13 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2062.outbound.protection.outlook.com [40.107.94.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6C9EE10E28A
 for <amd-gfx@lists.freedesktop.org>; Wed, 30 Nov 2022 06:39:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=azVS1AguA4hCNGe7ETq7BGHIYUiGZs5EF8/Um5oBiLZ/RXTiqIvoK97bVWNxarxHi3t5mPkYp9DCBuU2tSoc0XYt7gl5PT4jskgmUX2IF9PRKKEEg4St8+Mdh0d2p+BFScYFe4JgsdgeKVuAQ3qg2mgKwN9x3KI4cNqFThG+tPqj9OSc/DJyRcqs/F3+JnB8+Wwrg4GmreqRHdnK+PKDbrHUtIYVBLb0Pncp/uSbs9UbCebpcDWE2Gn6hnhhXkeonzW3FyA3ZbZyjSdf8fKFw1IaVjwkM0U7QKZghr0LUmxCZP0R6zzXixJuy3CeySdPybx8sDC4Dy0PF/T9addZqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iyMjPewqvIIeS7OWLDfPX/LChxYGQXO5Eqwc+pudScA=;
 b=ZlTs3KmXpqyzu9O+p6hEOUT+pAfSN4skGA13H6hw4iq7IELNGHqw1MLXDVocaIqXSpopOprKfHaiTGW0ZrurFlxCL2i0zL/yCIJCOgZlDzDtZTz+p+4lG3J3jIADXS1n8sEsyJMLKgFiqVu5LLw6OYgdM9UQRsfVNI5wmAy8F/2auflFyEzT7SWTGhJXz+qfRwXcZAgm36a/OMMJcb94QUuq7UxNuCtUb6+5ITzskGK7dklZ4uJ31tgF48RslydyBu4gtQZTZ+3YTUFv7iLTf7OWXV4AdlovurY6AeYMQHo6beJfD2xb55ZXCDEI7UUCM/NEeq8deZzUSXomp5Is+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iyMjPewqvIIeS7OWLDfPX/LChxYGQXO5Eqwc+pudScA=;
 b=I8bwjfJsCRYSZHYotocdgXoy9Z0KPYKNF4wW/4l3DYDvTu8kBl4SuIV7zfhdT4NlNURAAFu97953ioI8xdx+RM4TCZCaGOZs9Xoa5ayCtmGbxQhtD5Uv7uGGpAZHmKjjKwiIN2C1UPLYnexcTdgdUgBrS2+ix11lWSjLUXO5jH4=
Received: from MW4PR04CA0110.namprd04.prod.outlook.com (2603:10b6:303:83::25)
 by SJ1PR12MB6170.namprd12.prod.outlook.com (2603:10b6:a03:45b::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.23; Wed, 30 Nov
 2022 06:39:08 +0000
Received: from CO1NAM11FT027.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:83:cafe::ef) by MW4PR04CA0110.outlook.office365.com
 (2603:10b6:303:83::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.23 via Frontend
 Transport; Wed, 30 Nov 2022 06:39:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT027.mail.protection.outlook.com (10.13.174.224) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5880.8 via Frontend Transport; Wed, 30 Nov 2022 06:39:07 +0000
Received: from stylon-EliteDesk.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 30 Nov
 2022 00:39:02 -0600
From: Stylon Wang <stylon.wang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 00/14] DC Patches December 5 2022
Date: Wed, 30 Nov 2022 14:36:13 +0800
Message-ID: <20221130063627.2398341-1-stylon.wang@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT027:EE_|SJ1PR12MB6170:EE_
X-MS-Office365-Filtering-Correlation-Id: e9cec9b6-7ee7-42e7-358b-08dad29d950a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RuDNou1EU8ogSrS2jATl9QFcL/v1Uc8DshjY14zNxX4d9YyHbLZOInLp5Qj0m4RRap536sK1qVu1qzqp72R4bIqSLaV98ePEVGhlzAVz1sJ52neBYy+cw80tSm4DbKJsWWdUKeHedYhb6+CtXmCtPk9ZTLKoOfRuO7i1GjTtuYxUPe6pIJDx1PCoDBMjOfGPnPjgwfLEpVgWbx3owMD+wYIYc0MXLpoQPX6CF31eRwhhtOHyAzcQbelOKe7fgaj1kH2u2gMa/zy11imXoMuitORaJJ+cYBNn8RVHFQ/CJ9kPEVR1OVTnABD2BujkyuRset3vq4lBm0qSDCFFyjQ3mKWC67pCzIunK4QuTmMut8TEDa4kRfATnQnBh4aRxUWnqkRKvJ3Di8VFMuLzTM6DLMsteg4Bgvr7dJX/PqWg+vmGwA0awM9TxM1EwTNx2sVDY1jjW9tX63g/CVeAmdyfeeGU0sIzGp/BNMaF5mEd7s737F4xxFH3OAhckh9vo1aoP1vuDHIrhQK6Rj9F24EcIuKihjlPfuCFPz4/5EQ2b0MafETIpzGQIPRVGIrKf6yuvpBMI2hMJFL/dioh95XYxaMIcOEWV75GDL2Vp+S1H/tu3ysbWZu0MZ2t2pgEiKazwSvvCUMzfBbvmjEVQ2aZ4tRWAHosyU0APeuUhusVXjl9qNB4VUNqMBBrgviwKKheLWcgKSKEBmhXOQT90sFsr3jnrQk8kO3erqFxdD79NWY=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(396003)(136003)(346002)(376002)(39860400002)(451199015)(46966006)(40470700004)(36840700001)(40460700003)(40480700001)(336012)(70586007)(36756003)(1076003)(16526019)(41300700001)(2616005)(70206006)(186003)(86362001)(4326008)(44832011)(8676002)(7696005)(426003)(47076005)(5660300002)(6666004)(316002)(478600001)(8936002)(6916009)(54906003)(82740400003)(26005)(82310400005)(81166007)(356005)(83380400001)(2906002)(36860700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Nov 2022 06:39:07.6800 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e9cec9b6-7ee7-42e7-358b-08dad29d950a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT027.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6170
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
 solomon.chiu@amd.com, Daniel Wheeler <daniel.wheeler@amd.com>,
 Aurabindo.Pillai@amd.com, wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com,
 agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This DC patchset brings improvements in multiple areas. In summary, we have:

* Improvements on PSR-SU
* Improvements and fixes on DML calculation
* Fix on Dynamic Refresh Rate for DCN 3.1.4
* Fix on DC commit streams
* Fix on DDC GPIO pin
* Fix on Sub-ViewPort
* Fix on DSC
* Enable DP HDMI 2.1 PCON
* Fix on seamless boot
* Fix on OTG programming
* Fix on DTB clock


Cc: Daniel Wheeler <daniel.wheeler@amd.com>


Alvin Lee (1):
  drm/amd/display: Ensure commit_streams returns the DC return code

Aric Cyr (1):
  drm/amd/display: 3.2.215

Aurabindo Pillai (1):
  drm/amd/display: trigger timing sync only if TG is running

Charlene Liu (1):
  drm/amd/display: correct static_screen_event_mask

Chris Park (1):
  drm/amd/display: Remove DTB DTO on CLK update

David Galiffi (1):
  drm/amd/display: Enable dp_hdmi21_pcon support

Dillon Varone (3):
  drm/amd/display: Disable uclk pstate for subvp pipes
  drm/amd/display: Bypass DET swath fill check for max clocks
  drm/amd/display: set optimized required for comp buf changes

Dmytro Laktyushkin (1):
  drm/amd/display: prevent seamless boot on displays that don't have the
    preferred dig

Michael Strauss (1):
  drm/amd/display: Fix DCN2.1 default DSC clocks

Nicholas Kazlauskas (1):
  drm/amd/display: Add debug option to skip PSR CRTC disable

Paul Hsieh (1):
  drm/amd/display: read invalid ddc pin status cause engine busy

Zhongwei (1):
  drm/amd/display: correct DML calc error of UrgentLatency

 .../display/dc/clk_mgr/dcn32/dcn32_clk_mgr.c  | 37 -----------------
 drivers/gpu/drm/amd/display/dc/core/dc.c      |  5 ++-
 drivers/gpu/drm/amd/display/dc/core/dc_link.c |  2 +-
 drivers/gpu/drm/amd/display/dc/dc.h           |  3 +-
 .../amd/display/dc/dcn10/dcn10_hw_sequencer.c |  6 +++
 .../drm/amd/display/dc/dcn20/dcn20_hwseq.c    |  7 +++-
 .../amd/display/dc/dcn301/dcn301_resource.c   |  2 +
 .../amd/display/dc/dcn302/dcn302_resource.c   |  2 +
 .../amd/display/dc/dcn303/dcn303_resource.c   |  2 +
 .../drm/amd/display/dc/dcn31/dcn31_hwseq.c    | 40 +++++++++++++++++++
 .../drm/amd/display/dc/dcn31/dcn31_hwseq.h    |  4 ++
 .../gpu/drm/amd/display/dc/dcn31/dcn31_init.c |  4 +-
 .../gpu/drm/amd/display/dc/dcn31/dcn31_optc.c | 29 +++++++++++++-
 .../gpu/drm/amd/display/dc/dcn31/dcn31_optc.h |  5 ++-
 .../drm/amd/display/dc/dcn314/dcn314_init.c   |  4 +-
 .../drm/amd/display/dc/dcn314/dcn314_optc.c   |  2 +-
 .../amd/display/dc/dcn314/dcn314_resource.c   |  1 +
 .../drm/amd/display/dc/dcn32/dcn32_hwseq.c    | 10 ++---
 .../amd/display/dc/dcn321/dcn321_resource.c   |  2 +-
 .../drm/amd/display/dc/dml/dcn20/dcn20_fpu.c  |  6 +--
 .../dc/dml/dcn30/display_mode_vba_30.c        |  2 +-
 .../dc/dml/dcn31/display_mode_vba_31.c        |  2 +-
 .../dc/dml/dcn314/display_mode_vba_314.c      |  2 +-
 .../dc/dml/dcn32/display_mode_vba_32.c        |  3 +-
 .../display/dc/gpio/dcn32/hw_factory_dcn32.c  |  4 +-
 25 files changed, 122 insertions(+), 64 deletions(-)

-- 
2.25.1

