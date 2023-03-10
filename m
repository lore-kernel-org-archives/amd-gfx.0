Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C524EC6FD1E
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Mar 2023 09:31:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 331E610E9A1;
	Fri, 10 Mar 2023 09:31:52 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2059.outbound.protection.outlook.com [40.107.220.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5FBC510E9A0
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Mar 2023 09:31:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KleMESb7ULfwwT9uFCG1nZMpEw0wZkxYWhsT97MFsaD16hHQHXC4GEwCZCf4yVo0nJyHOC9e+S347h8WKpwkBrTAhmD/hTo/JD4fulTyV/UCIsdJMWybdUMMrudBKblfrLbB1Q46xB+yHfJN7PpKzuBpeYI6Cwb5+JFWFECw7dmN3q3+7g6EnjjeK2QqvyRX61KoUE/gVjri7ZlQTRyOnFehKqBWiiwj3FhjWuNdANXra8W2xnEM4f3GFSCPe4M15WlYXapaUNP/v5IZTuKcZ3O60Eb6KzNEpEMzuRrYHxYZiz1hsm5DZyOXU+i3ME83yNADFKKFV+fbeBbcH9O1VQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HQtkC5vtIBIyc2y/4cUHewrerQfNtDh81Yaw/bEzJ/k=;
 b=gOylKQsyB/SObMHhPSYAxoMBrQIY/cbBYLFshuqTiBj9gav4zCi+Afy0tYlkUhYomOvL6FLGuTLKBxxwIBYGfoMhi5hiU7t4OuKtY1O6lOr9jYyBnYoo6YsyxX9uXxilnzTt4bDJHzRVHP0Xmf0V6RBl+E5ezCbKIgv5wMHJrrZJHuARjk21hquRQXCt+tJdosSrNFKhgADTClm28DTHQ8M/J/Gw3uqmrr4N959lh2FHvzYJ/xjke9xK5Ku+/jMHQhWHPr82duKw9aNTYfOmXuQ3K1Xs7XjyCVRnRDUjkQwixQ6aT2ZaFg+m3PZHkHrjfwRX/IrgMXXtNRJBJYNuJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HQtkC5vtIBIyc2y/4cUHewrerQfNtDh81Yaw/bEzJ/k=;
 b=RQa2DnnkQS8UQ1nXY5E+cwBB84YNw9LG1fPlPeOasVleDHJLSK4CySitz7bQrPeZ8xTBR7xlbb5pXONn4TAxTnZRcVgzTCiz74G0N7bghhd7REZ6NpX7nNYgotnNUAqBCGDNszWtpmqunBh5h2ZkwjElB9EHLBoKMvaEUocBQSw=
Received: from CY5PR19CA0066.namprd19.prod.outlook.com (2603:10b6:930:69::12)
 by MW4PR12MB6730.namprd12.prod.outlook.com (2603:10b6:303:1ec::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.19; Fri, 10 Mar
 2023 09:31:48 +0000
Received: from CY4PEPF0000C976.namprd02.prod.outlook.com
 (2603:10b6:930:69:cafe::8) by CY5PR19CA0066.outlook.office365.com
 (2603:10b6:930:69::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.20 via Frontend
 Transport; Fri, 10 Mar 2023 09:31:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000C976.mail.protection.outlook.com (10.167.241.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6178.13 via Frontend Transport; Fri, 10 Mar 2023 09:31:47 +0000
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 10 Mar
 2023 03:31:42 -0600
From: Qingqing Zhuo <qingqing.zhuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 00/19] DC Patches Mar 13rd, 2023
Date: Fri, 10 Mar 2023 04:30:58 -0500
Message-ID: <20230310093117.3030-1-qingqing.zhuo@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000C976:EE_|MW4PR12MB6730:EE_
X-MS-Office365-Filtering-Correlation-Id: d8b84f1b-8e09-4e91-e53a-08db214a458a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: io7HNug0niOPnJmPf4SGVsQfqj9jC1PyPD8Kqk3ZQA/CpGYEVhCCTwQx0GBSqgCHz0mJJm7HCDMY/k2NEmHY/EC8wBd6vdShykGIG6+cxRpml8GRf0I9Mv9/40rI4i+dwFAt1i9dRdlMar4MnxjLZJeN69F6j36rTd+JYtUS7sAuMbPbz6YZKVj1a9/dU6xJplJKqG3WjshGa9nUT+EUlciEMiRIQOSRShpNtSPKFvJMu+1tYFpgTK5aTYnQ0vXMc3j48Sjpv4Zk1qXI0xq0y9F40HE+Qsc/4rWBd8kFA2gvxDF3RSI/NapOWBIA+Y4TwW8PXIABTRCjVX4BQMuZrMNjLzX7jPqMHnGddoCAUQu6syTETMAH1fAGCtHb265CaV7FlmRTF5U7I+pc/q0YoEvnfQWmdq3KMRldSwRhOD35gsxR1JTMQBt/SuWZjJNIiFRd6MkkI2Pxl6i+cwbx0eB34MoQS52uZ/jXZic4jFUZaQEILCz1o10Zq/jSk/YKOVE0eYfJSM1hfOtN3jXMkK3HhYXXDO0neFzVgtqc22y59jDM4kDQAQ1mYAKQLuJN9BTPNhllfxq4EkrJSn8X6LfR+jTJPoFgukqlfBKexYVpHo43xdpmNUBK1z9jy4C9ormCj88MzdmIO2A5w7CDpnn3h+CgK6YW7CU08ATYE5dwklHoKiXEIvfZmt7GO2bOF6TelE4cSEEbPi0sSHeYe9tZ+LOPLCNoPI+7lKdqiWQ=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230025)(4636009)(376002)(39860400002)(346002)(396003)(136003)(451199018)(46966006)(36840700001)(40470700004)(82310400005)(36756003)(82740400003)(36860700001)(6666004)(47076005)(83380400001)(426003)(478600001)(40480700001)(54906003)(81166007)(356005)(316002)(336012)(2616005)(40460700003)(26005)(186003)(16526019)(1076003)(2906002)(70586007)(5660300002)(44832011)(70206006)(8676002)(8936002)(6916009)(41300700001)(4326008)(86362001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2023 09:31:47.9990 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d8b84f1b-8e09-4e91-e53a-08db214a458a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000C976.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6730
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

This DC patchset brings improvements in multiple areas. In summary, we highlight:
- FW Release 0.0.158.0
- Fixes to HDCP, DP MST and more
- Improvements on USB4 links and more
- Code re-architecture on link.h

Cc: Daniel Wheeler <daniel.wheeler@amd.com>

Alvin Lee (1):
  drm/amd/display: Use DPP inst instead of pipe idx for DPP DTO
    programming

Anthony Koo (1):
  drm/amd/display: [FW Promotion] Release 0.0.158.0

Aric Cyr (1):
  drm/amd/display: 3.2.227

Ayush Gupta (1):
  drm/amd/display: disconnect MPCC only on OTG change

Bhawanpreet Lakha (1):
  drm/amd/display: Fix HDCP failing to enable after suspend

Cruise Hung (1):
  drm/amd/display: Fix DP MST sinks removal issue

Fangzhi Zuo (2):
  drm/amd/display: Add DSC Support for Synaptics Cascaded MST Hub
  drm/amd/display: Take FEC Overhead into Timeslot Calculation

Mustapha Ghaddar (1):
  drm/amd/display: Add Validate BW for USB4 Links

Robin Chen (1):
  drm/amd/display: hpd rx irq not working with eDP interface

Saaem Rizvi (1):
  drm/amd/display: Remove OTG DIV register write for Virtual signals.

Samson Tam (2):
  drm/amd/display: reallocate DET for dual displays with high pixel rate
    ratio
  drm/amd/display: fix assert condition

Stylon Wang (1):
  drm/amd/display: Clearly states if long or short HPD event in dmesg
    logs

Swapnil Patel (1):
  drm/amd/display: default values for luminance range if they are 0

Wenjing Liu (1):
  drm/amd/display: convert link.h functions to function pointer style

Wesley Chalmers (2):
  drm/amd/display: Do not set DRR on pipe Commit
  drm/amd/display: Make DCN32 functions available to future DCNs

Zhikai Zhai (1):
  drm/amd/display: reset the scaler boundary mode

 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |  22 +-
 .../amd/display/amdgpu_dm/amdgpu_dm_hdcp.c    |   2 +-
 .../display/amdgpu_dm/amdgpu_dm_mst_types.c   |  51 ++-
 .../display/amdgpu_dm/amdgpu_dm_mst_types.h   |  15 +
 .../gpu/drm/amd/display/dc/clk_mgr/clk_mgr.c  |   4 +-
 .../display/dc/clk_mgr/dcn32/dcn32_clk_mgr.c  |  38 ++-
 .../display/dc/clk_mgr/dcn32/dcn32_clk_mgr.h  |   3 +
 drivers/gpu/drm/amd/display/dc/core/dc.c      |  33 +-
 .../drm/amd/display/dc/core/dc_link_enc_cfg.c |   2 +-
 .../drm/amd/display/dc/core/dc_link_exports.c |  34 +-
 .../gpu/drm/amd/display/dc/core/dc_resource.c |  13 +-
 drivers/gpu/drm/amd/display/dc/dc.h           |  15 +-
 drivers/gpu/drm/amd/display/dc/dc_types.h     |   7 +
 .../display/dc/dce110/dce110_hw_sequencer.c   |  60 ++--
 .../gpu/drm/amd/display/dc/dcn10/dcn10_dpp.h  |   4 +
 .../drm/amd/display/dc/dcn10/dcn10_dpp_dscl.c |   4 +
 .../amd/display/dc/dcn10/dcn10_hw_sequencer.c |   6 +-
 .../display/dc/dcn10/dcn10_stream_encoder.c   |   7 +-
 .../drm/amd/display/dc/dcn20/dcn20_hwseq.c    |  14 +-
 .../drm/amd/display/dc/dcn20/dcn20_resource.c |   9 +-
 .../display/dc/dcn20/dcn20_stream_encoder.c   |   3 +-
 .../drm/amd/display/dc/dcn21/dcn21_hwseq.c    |   4 +-
 .../gpu/drm/amd/display/dc/dcn30/dcn30_dpp.h  |   2 +
 .../drm/amd/display/dc/dcn30/dcn30_hwseq.c    |   5 +-
 .../drm/amd/display/dc/dcn30/dcn30_resource.c |   9 +-
 .../amd/display/dc/dcn302/dcn302_resource.c   |   9 +-
 .../amd/display/dc/dcn303/dcn303_resource.c   |   9 +-
 .../drm/amd/display/dc/dcn31/dcn31_hwseq.c    |  10 +-
 .../dc/dcn314/dcn314_dio_stream_encoder.c     |   2 +-
 .../drm/amd/display/dc/dcn314/dcn314_hwseq.c  |   2 +-
 .../dc/dcn32/dcn32_dio_stream_encoder.c       |   2 +-
 .../drm/amd/display/dc/dcn32/dcn32_hwseq.c    |  15 +-
 .../gpu/drm/amd/display/dc/dcn32/dcn32_mpc.c  |   8 +-
 .../gpu/drm/amd/display/dc/dcn32/dcn32_mpc.h  |  13 +
 .../drm/amd/display/dc/dcn32/dcn32_resource.c |  15 +-
 .../display/dc/dcn32/dcn32_resource_helpers.c |  43 ++-
 .../amd/display/dc/dcn321/dcn321_resource.c   |   9 +-
 .../drm/amd/display/dc/dml/dcn20/dcn20_fpu.c  |   4 +-
 .../drm/amd/display/dc/dml/dcn32/dcn32_fpu.c  |   2 +-
 drivers/gpu/drm/amd/display/dc/dsc/dc_dsc.c   |  53 +++
 drivers/gpu/drm/amd/display/dc/inc/link.h     | 314 ++++++++++-------
 .../display/dc/link/accessories/link_dp_cts.c |   1 +
 .../dc/link/accessories/link_dp_trace.c       |   8 +-
 .../dc/link/accessories/link_dp_trace.h       |   5 +
 .../amd/display/dc/link/hwss/link_hwss_dio.c  |  22 +-
 .../display/dc/link/hwss/link_hwss_hpo_dp.c   |   8 +-
 .../drm/amd/display/dc/link/link_detection.c  |  10 +-
 .../drm/amd/display/dc/link/link_detection.h  |   9 +-
 .../gpu/drm/amd/display/dc/link/link_dpms.c   |  43 +--
 .../gpu/drm/amd/display/dc/link/link_dpms.h   |  23 +-
 .../drm/amd/display/dc/link/link_factory.c    | 322 ++++++++++++++----
 .../drm/amd/display/dc/link/link_factory.h    |   2 +
 .../drm/amd/display/dc/link/link_resource.h   |   4 +
 .../drm/amd/display/dc/link/link_validation.c |   5 +-
 .../drm/amd/display/dc/link/link_validation.h |   7 +
 .../amd/display/dc/link/protocols/link_ddc.h  |  28 ++
 .../dc/link/protocols/link_dp_capability.c    |  10 +-
 .../dc/link/protocols/link_dp_capability.h    |   9 +
 .../dc/link/protocols/link_dp_dpia_bw.c       |  34 ++
 .../dc/link/protocols/link_dp_dpia_bw.h       |  14 +
 .../display/dc/link/protocols/link_dp_phy.h   |   5 +
 .../dc/link/protocols/link_dp_training.c      |   6 +-
 .../link/protocols/link_edp_panel_control.c   |  20 +-
 .../link/protocols/link_edp_panel_control.h   |  10 +
 .../amd/display/dc/link/protocols/link_hpd.h  |   3 +
 .../gpu/drm/amd/display/dmub/inc/dmub_cmd.h   |   4 +-
 66 files changed, 1067 insertions(+), 421 deletions(-)

-- 
2.34.1

