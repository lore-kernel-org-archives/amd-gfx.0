Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7EE65C433EF
	for <amd-gfx@archiver.kernel.org>; Tue, 24 May 2022 17:47:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1D53610F8C6;
	Tue, 24 May 2022 17:47:26 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2086.outbound.protection.outlook.com [40.107.93.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2057C10F8DF
 for <amd-gfx@lists.freedesktop.org>; Tue, 24 May 2022 17:47:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CbUvzxwiKQTCifNqQev2sAKgidLQPAKj7nzCR5DrbqF3fONHs7Ov9BQ5iMAKROXx/YlwFWp/+O140xFBXjUaG2O/etK9SDD7YQJEs0w6rFHjbMgUkzFx9EbIkLEiWvwV9M8K7NCLF5qD0528zlnFxD4XFATjFlY67LJFUQdIy8bFjNwjnE4hJVd2S0r+aT1Ns0lZ4GinwiqFHZhpw44Ot4/HOlSKjVcplmzOZsw+gPTF2qyjnlzkEISKHkn4eGOE+FRZxVvpx222KMDwbyo9yqDLeQuTJ3hwWkXKqqDmy+LNTVf5PJsu5isPqdK70PMZTmcd8VzWAFlErhRfKqecMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Sv9nfLpqAbM+oYyc+e4s1PJgYb+/hNhkLv/gJh7eGFA=;
 b=O8inPjstHdqK7oWlPS4jM/SxP7cD25xdl2iTJq5jD+c72vPnvvBv8WewQ7mxTwdeCvvW4jn+MgeeCiza6zlDb1TtVPYIZmpLmXuLeCF0V5oAS7ePErTRl+L8bfq32FPbUSuo5u1qLSP3c0P3gppT+RyASPxMXA4gwOqlZBJmiweWNY6n4JLnlm4HaGsRI3Kxk9qvwe04M/NNnj0syQKE0GrLJx7A2knr+ydPsniaVQcgEJm0eHlVq6HF/Zgt+OPCVgpWiUwZZqvbh+qpjAQCt7Q0QWhsLzwEwYdSeBdbePOBB+Tfb5izEDGBCGtu4DSP3DJi7PNlpUGpjOCLJUIZBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Sv9nfLpqAbM+oYyc+e4s1PJgYb+/hNhkLv/gJh7eGFA=;
 b=aEucQ2TRKaTgxvv8ak3svmobkTbqobsVXR7bZc8RrFXL09zk5KskefEnhJQ8XCalbzPzjWBjXH0xTPpERtHJtPzlaWGEPp6Ej/vZDXKZCaypcfUETYb1ueJcwgDaZZGI5NPLCCG4ubb8NsWq3cobASOs9fBBlSM/TP06E0ZpPMY=
Received: from MW4PR03CA0144.namprd03.prod.outlook.com (2603:10b6:303:8c::29)
 by BL0PR12MB2481.namprd12.prod.outlook.com (2603:10b6:207:40::25)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.14; Tue, 24 May
 2022 17:47:23 +0000
Received: from CO1NAM11FT027.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8c:cafe::27) by MW4PR03CA0144.outlook.office365.com
 (2603:10b6:303:8c::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.15 via Frontend
 Transport; Tue, 24 May 2022 17:47:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT027.mail.protection.outlook.com (10.13.174.224) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5273.14 via Frontend Transport; Tue, 24 May 2022 17:47:22 +0000
Received: from jasdeep-System-Product-Name.phub.net.cable.rogers.com
 (10.180.168.240) by SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 24 May 2022 12:47:19 -0500
From: Jasdeep Dhillon <jdhillon@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 0/8] May 24, 2022
Date: Tue, 24 May 2022 13:46:56 -0400
Message-ID: <20220524174704.124902-1-jdhillon@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0201469f-21bb-46ac-894e-08da3dad74d3
X-MS-TrafficTypeDiagnostic: BL0PR12MB2481:EE_
X-Microsoft-Antispam-PRVS: <BL0PR12MB2481643F8D9E3009BD0D203FFBD79@BL0PR12MB2481.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Oyy7mPKJ/ik4F1Ww+2D9zNXKxtLHqa8RR/5w6Acfebstm5Em+kZe0zfmHWSWMmtEpZ8RBI2B1HBpyvhu1D73IoL8kMaVxBQ4I9J+OnuzHnnR5tRJP7C/pF1UBh1N0l0mZwnwhhMe3NcUpretGWZQtK/LaCCVHm9bMpjdF9OEaNyM3Sp3U+Hh8tcrXJ6Lf5VM/vZIbE3DtRvhcpr/ZkA3fcirHnAw3U1cx4l+WqY7AydvgWxJfVZ78JrpPoP6Pw6RG5Fkt4Qqhv38mT1LM8DlyA5Ogfw/sDSTTSd+gZJitxgLjx2InmA8dGtxTCXIaiKlnpwy5deF5oLyvZDwxpSmoO8spYTdCsexRdSPrIQLjdngC5LAeSrYhaLGYmIcsqmRQMpskkFQCmYXgn5yWc/RjPux4b5/8aRWUySZSAHbCJQ3PhzjwKfXojPRf8SnDpycJMkXM3ABfvBY6s/3zY9v3HBGtHKoDIrmbbqg6t+2SCjKpvO9s4qyZhAR8hlbw5FUCe3Qhnirds4CgnEN1GJoCDr78xjc5V4ccAqPTYquL9TX/9woC1OOLWTScqoS2bbD93Hlway9KK7fIkpOxqvXiS4ZVhWZLyGDabrU2SK+VJu92uj/6jL+nxcMQ3A8TnRPPSDDM75AU089fCAkPWLGQ5LWlIK2LLT94UjjLn+Q/INd/Z95IEptHTMfF5wGW95lig9hR3q/ZR+Yr/Eiw5Z9Sw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(40470700004)(46966006)(36840700001)(26005)(82310400005)(5660300002)(2906002)(36756003)(54906003)(4326008)(6666004)(70586007)(70206006)(8676002)(508600001)(8936002)(316002)(36860700001)(6916009)(1076003)(186003)(2616005)(426003)(47076005)(336012)(16526019)(40460700003)(83380400001)(81166007)(356005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 May 2022 17:47:22.3128 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0201469f-21bb-46ac-894e-08da3dad74d3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT027.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB2481
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

This DC patchset brings improvements in multiple areas. In summary, we highlight:

*Changes to DP LT fallback behavior to more closely match the DP standard
*Added new interfaces for lut pipeline
*Restore ref_dtblck value when clk struct is cleared in init_clocks
*Fixes DMUB outbox trace in S4
*Fixes lingering DIO FIFO errors when DIO no longer enabled
*Reads Golden Settings Table from VBIOS

Alvin (1):
  drm/amd/display: Don't clear ref_dtbclk value

Aric Cyr (1):
  drm/amd/display: 3.2.187

Hung, Cruise (1):
  drm/amd/display: Fix DMUB outbox trace in S4 (#4465)

Ilya (1):
  drm/amd/display: Fix possible infinite loop in DP LT fallback

Leung, Martin (2):
  drm/amd/display: revert Blank eDP on disable/enable drv
  Prepare for new interfaces

Nicholas Kazlauskas (1):
  drm/amd/display: Pass the new context into disable OTG WA

hengzhou (1):
  drm/amd/display: Wait DMCUB to idle state before reset.

 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |   2 +
 .../display/dc/clk_mgr/dcn31/dcn31_clk_mgr.c  |  19 ++-
 .../display/dc/clk_mgr/dcn31/dcn31_clk_mgr.h  |   2 +
 .../dc/clk_mgr/dcn315/dcn315_clk_mgr.c        |  13 +-
 .../dc/clk_mgr/dcn316/dcn316_clk_mgr.c        |  11 +-
 drivers/gpu/drm/amd/display/dc/core/dc_link.c |  17 +-
 .../gpu/drm/amd/display/dc/core/dc_link_dp.c  | 158 +++++++++---------
 drivers/gpu/drm/amd/display/dc/dc.h           |   6 +-
 .../display/dc/dce110/dce110_hw_sequencer.c   |  23 ++-
 .../gpu/drm/amd/display/dc/dcn31/dcn31_dccg.c |  79 ++++-----
 .../gpu/drm/amd/display/dc/dcn31/dcn31_dccg.h |   2 +-
 .../gpu/drm/amd/display/dc/inc/hw/clk_mgr.h   |   1 +
 drivers/gpu/drm/amd/display/dc/inc/hw/dccg.h  |  20 ++-
 drivers/gpu/drm/amd/display/dc/inc/hw/mpc.h   |   5 +
 .../amd/display/dc/inc/hw_sequencer_private.h |   2 +
 .../amd/display/dc/link/link_hwss_hpo_dp.c    |  19 ++-
 .../gpu/drm/amd/display/dmub/src/dmub_dcn31.c |  11 +-
 .../gpu/drm/amd/display/dmub/src/dmub_dcn31.h |   3 +-
 .../amd/display/include/ddc_service_types.h   |   2 +
 19 files changed, 233 insertions(+), 162 deletions(-)

-- 
2.25.1

