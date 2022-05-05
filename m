Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C794C433F5
	for <amd-gfx@archiver.kernel.org>; Thu,  5 May 2022 14:23:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6C83510E0F6;
	Thu,  5 May 2022 14:23:44 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2064.outbound.protection.outlook.com [40.107.92.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3BCBA10E040
 for <amd-gfx@lists.freedesktop.org>; Thu,  5 May 2022 14:23:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BC9uBSZMYJs5VyF5x92PMdbHuMmeomOGL6Cyq0Ke2P9sB7yYm/PhEXb2CPGeyEzXtoRTJ/JrNiLDIMpjQFwq7DEkv4oXMzdL/ytXq7d+irK2rHRzrquWGzOdG9/sUQbtjePHLzPBLaUFWulbOJyjGP6HhPGybOcDXFuUKmgpmLZoVs89+ummock6JDy98MW8yz/hFFFgZH3jvOcH6IgVo1l60+a6WEpHPjCvKgEnHuNqjj/URz6z3a0w2fDGq8Rs+LhIOru5qVHmsEP1mpvcdGI3kpFwI40yuMqN0Ssyz6cUxEsLl1D6Rs6zyhkf0kBMWVXVNCEKIWTVsRhC2AceNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B+irNNfaDpbwwoeUakQZRUV+HH8ycM2iGb6ZvRsrlP0=;
 b=JcAK7xmAn3/5K4HVxL6JH6l2mTRryYWk0Q3cN+A6VsDrPdQLht03XZtakLpCUR+cKuHz7U/31K8mqDQI49uiElb8y56CCUpqIkPa00uwLrEhTrxt+u2aoe7X9yy46b/UsC04lbwjPC/4YgrY9NwFL8k5L+wYnFST9DDpdevA1gxeU931lEmGW9pUf9ykWCVcTVOJtSTGAC4GNPyvBSP/qi5Es6H6dYtSSScQhBpmnUfgeNO3rnyMTx0hMNe1inVgaqwgoHEo5da+puT4AjreWUQJO6GEgLDyALDLbOWaMvW5EHlc1ACb2etWgCU2U/+rZt0AeWbzZScVhnfRDblq0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B+irNNfaDpbwwoeUakQZRUV+HH8ycM2iGb6ZvRsrlP0=;
 b=gwXb2CWGlpD8uUhGI8DkIkBvjTVjrF6aPrtrYMfR86DJZ1PQxgU1LTC7LFbg4Y14Up7R0oTDrxVQ2R1t0yaVLkJRF/gCLpizP/ylpqerLeUR3ftd/FE9//UJh7X9uJw+DYFqjU2zvQ5Jekf1dFvRKqKqNVh6ELs/yuRbGYC+VaA=
Received: from DS7PR03CA0076.namprd03.prod.outlook.com (2603:10b6:5:3bb::21)
 by IA1PR12MB6236.namprd12.prod.outlook.com (2603:10b6:208:3e4::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.25; Thu, 5 May
 2022 14:23:40 +0000
Received: from DM6NAM11FT020.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3bb:cafe::42) by DS7PR03CA0076.outlook.office365.com
 (2603:10b6:5:3bb::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.13 via Frontend
 Transport; Thu, 5 May 2022 14:23:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT020.mail.protection.outlook.com (10.13.172.224) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5227.15 via Frontend Transport; Thu, 5 May 2022 14:23:39 +0000
Received: from Gundam.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Thu, 5 May
 2022 09:23:38 -0500
From: David Zhang <dingchen.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 00/17] enable PSR-SU MPO for amdpgu
Date: Thu, 5 May 2022 10:23:06 -0400
Message-ID: <20220505142323.2566949-1-dingchen.zhang@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 37dca8fe-4372-4a11-7dd8-08da2ea2d9b6
X-MS-TrafficTypeDiagnostic: IA1PR12MB6236:EE_
X-Microsoft-Antispam-PRVS: <IA1PR12MB6236DB51990171543561E7618DC29@IA1PR12MB6236.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xjh74nqZcV0lGFt9W8X139Ru5VXGhrrM82mgJ0LlY1bcLq2LUDAS3Xead+80bvFdIZPDsqY9n6EuwUDc6IJOk5oW7E8iCF6nGsZ+nc3myyTtChdHiuAmldQ+LMBRFXtEGPcTQdwORCRxvVBssfwWiynuoO2ZYnhUYyfUEHMsmdRjpcIHNuVieW0xfdG0D/p/JYcLx5R9DdQ11ojmKneVHKsYOtwSwFzaYfJShQja44LTzHEqF8hDA+FM7fgd4E6YDgYiTDH9FkZvi1c68prbwwe1t0gHiWa0W8z3Yu4fHCEZz1B3vPfC92KHR5vHFLepSN3CuBhQ82aXbG6lhkqEPtR2BmtGgvVVzhDYc7UTgAei0/5wgH48SUDMBjMC+Ohh+1gKUwJdIBy+RoOM6ynxu2LptlAYr7Yl6bg51edbCAsnsu0OfsW3spvBxzK6j6qgaG5tg4JtwGZK7wcQrLuSR6HshazDDGGGUdqd6fUwWheZdgpDAZYPzI8Z1C6Lz2SwISwX3RHv2EiQ6cWKOPEXO8rqbAvDI1iG/W5O0XCY6mhk1EUPjTu7FURxq2clIjQj0Gueer64uQSPNffwEt0SOX12gDJC6GU0nEwTSsFVsEi7Q+rXbpxQ4GXmF27wkcgiw60frszkSYyifdd6rPw6S0QmjCNlwrc3qO0mFtrzKOG+QbuoPIC6Sk5+0y82IzKA5f1d0y1loN3MqPsX5zBXpw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(36840700001)(46966006)(40470700004)(47076005)(426003)(336012)(5660300002)(70206006)(70586007)(82310400005)(81166007)(8936002)(54906003)(86362001)(6916009)(40460700003)(2906002)(316002)(4326008)(8676002)(36860700001)(26005)(36756003)(2616005)(186003)(7696005)(508600001)(1076003)(356005)(6666004)(83380400001)(16526019)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2022 14:23:39.7448 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 37dca8fe-4372-4a11-7dd8-08da2ea2d9b6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT020.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6236
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
 wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com,
 pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



David Zhang (16):
  drm/amd/display: align dmub cmd header to latest dmub FW to support
    PSR-SU
  drm/amd/display: feed PSR-SU as psr version to dmub FW
  drm/amd/display: combine dirty rectangles in DMUB FW
  drm/amd/display: update GSP1 generic info packet for PSRSU
  drm/amd/display: revise Start/End SDP data
  drm/amd/display: program PSR2 DPCD Configuration
  drm/amd/display: Passing Y-granularity to dmub fw
  drm/amd/display: Set default value of line_capture_indication
  drm/amd/display: add vline time in micro sec to PSR context
  drm/amd/display: fix system hang when PSR exits
  drm/amd/display: Set PSR level to enable ALPM by default
  drm/amd/display: use HW lock mgr for PSR-SU
  drm/amd/display: PSRSU+DSC WA for specific TCON
  drm/amd/display: add shared helpers to update psr config fields to
    power module
  drm/amd/display: calculate psr config settings in runtime in DM
  drm/amd/display: update cursor position to DMUB FW

Leo Li (1):
  drm/amd/display: Implement MPO PSR SU

 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 142 +++++++++-
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_psr.c |  21 +-
 drivers/gpu/drm/amd/display/dc/core/dc.c      |  54 ++++
 drivers/gpu/drm/amd/display/dc/core/dc_link.c |  33 ++-
 drivers/gpu/drm/amd/display/dc/dc.h           |   3 +
 drivers/gpu/drm/amd/display/dc/dc_link.h      |   1 +
 drivers/gpu/drm/amd/display/dc/dc_stream.h    |   5 +
 drivers/gpu/drm/amd/display/dc/dc_types.h     |  21 +-
 .../drm/amd/display/dc/dce/dmub_hw_lock_mgr.c |   2 +
 drivers/gpu/drm/amd/display/dc/dce/dmub_psr.c |  41 +++
 .../gpu/drm/amd/display/dc/dcn10/dcn10_hubp.c |   2 +
 .../amd/display/dc/dcn10/dcn10_hw_sequencer.c | 131 +++++++++
 .../gpu/drm/amd/display/dc/dcn20/dcn20_hubp.c |   2 +
 .../dc/dcn30/dcn30_dio_stream_encoder.c       |  15 ++
 drivers/gpu/drm/amd/display/dc/inc/hw/hubp.h  |   1 +
 .../drm/amd/display/dc/inc/hw/link_encoder.h  |  13 +-
 .../gpu/drm/amd/display/dmub/inc/dmub_cmd.h   | 250 +++++++++++++++++-
 .../display/modules/info_packet/info_packet.c |  29 +-
 .../amd/display/modules/power/power_helpers.c |  73 +++++
 .../amd/display/modules/power/power_helpers.h |   6 +
 20 files changed, 826 insertions(+), 19 deletions(-)

-- 
2.25.1

