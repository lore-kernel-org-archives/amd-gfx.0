Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD88FCD11C2
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Apr 2024 21:28:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1397610EA41;
	Wed, 10 Apr 2024 21:28:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="P73UPOK/";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2060.outbound.protection.outlook.com [40.107.244.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9D1D210EA41
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 Apr 2024 21:27:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GT7cQajX0mZmqqyTBvVAHjt3ag2SWIdytzHIucinOxtKCDrHolbh4dB3yHNuicB75WIXUhHOeXDEzHuShh48QGznRDBL4ggcu8r/todarns/TcWbekrOc8Ez/NPmi7xtgfL4puXpBurzHLSji2fBPbHaYFs+vqF5y/+F7pW4nQWOU/ZcgaPfgDmprnlD+3z0Et1oqPRU5n1HKkBHB3jlGNXOrzPAUKY0sQgNKZWoFSM08RCnPCnG4HdgjbV5+ny+GZO1nRZN+A1S7nRaFJlv3e8Zq6HsfRLcizZ+HrYiVzFWYZkVCoEbHKi9Fmhr2+J5J1zZtnhkUaboGCgN/dBIow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0zgL4F3LbTzEcIVeU5AIwkG19cqBGqeEiSPKkH48aWA=;
 b=mO7fku6km5eseLd/YTyxFG4pgfRrQHwrJgdpzWM4ryoP7SUvb4kAB7DqGVVeRqLKWoXMkfeILidHRLVkAke2cAT+SVxxsdHuwKwXTcnGKIxpIcxvTxg+51cU7utJ65LPH9H/BaldOl5YQOQo58d8pI0NQf0zTNc909qOjXU0BLSD6LUIvw4/BbdqTJh5V3sq3Sfaib69VhumQ8dhKbpe0zd4TI4159TqbYaZNUk5U/LKSP+l3NmC7Zmqnws6aWn4SRVwPKg4HnI4Yqlfl1pHr+uqVOHUpj3ciG8fnCnNCysHixMjkfIh7sTKTYPEx3xi+dbqItNvIe1I1mTnuoBiUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0zgL4F3LbTzEcIVeU5AIwkG19cqBGqeEiSPKkH48aWA=;
 b=P73UPOK/yCMI30lb/hhgqcAWJSyooyJQqLUBoB/CtmyR52hnofo7ED89LLqPQkoI/ULHL6QAO5rRoNorq8KHjdxfnehB4FX1+zbEfyMGSspAqxC6pLAXwA15PlVd8xCH2ppiAW+MM9TXlrYpbGsIWO58hV3tZkQCzsL1fZCYG+M=
Received: from BN0PR04CA0125.namprd04.prod.outlook.com (2603:10b6:408:ed::10)
 by CYYPR12MB8963.namprd12.prod.outlook.com (2603:10b6:930:c3::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Wed, 10 Apr
 2024 21:27:52 +0000
Received: from BN2PEPF000044A7.namprd04.prod.outlook.com
 (2603:10b6:408:ed:cafe::e5) by BN0PR04CA0125.outlook.office365.com
 (2603:10b6:408:ed::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.19 via Frontend
 Transport; Wed, 10 Apr 2024 21:27:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF000044A7.mail.protection.outlook.com (10.167.243.101) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7452.22 via Frontend Transport; Wed, 10 Apr 2024 21:27:51 +0000
Received: from smtp.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 10 Apr
 2024 16:27:49 -0500
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <hersenxs.wu@amd.com>, <jerry.zuo@amd.com>, Daniel Wheeler
 <daniel.wheeler@amd.com>
Subject: [PATCH 00/25] DC Patches April 10, 2024
Date: Wed, 10 Apr 2024 15:25:49 -0600
Message-ID: <20240410212726.1312989-1-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A7:EE_|CYYPR12MB8963:EE_
X-MS-Office365-Filtering-Correlation-Id: c04e19cf-31c7-4a11-e843-08dc59a513dd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vegAd//euP+emGjXvHQWs09YD3sFepzrjzmfBap7qBTMUkErokUwdWmiYxBnmO/MuiUCR1Qroay7/kptIr8s7hp57fJLwSJMPsl5Ipd4kJ9/lXe4i79ho7p7BaZbUVkakIsOuBGvPnqSye4QRQMrRVLvcj1h7vCT8wQ0df3sWLmuzeMc//ts+vD4kH9wQzoTv9c1+eKHGnMshM582JHcqUT+rEsiknZ7Bixz+FrttGfVm/kXkXkcVA5cUzmHNukvaGbAt/GVQ19kWrT8UnkMECf2a7tS65qW2cDgUzAaWqv1mqw5WxUXdnPE8QoQmMdREu0F3aScdYmGQFcvhmi0ypTAfQoqylWgnNXg8lobJXBi3jDlLZesiK7NWepIdJu53h0PktCRaqlQ2eBAdLGCGcTOlC+IGo1kJMkBk8Tf9x2OZBgFZkVkGLmFCFSz0g38f7EVKn6geCczkxHMl57uhmJ93CdjmBQdYDVoizMWV20pJRNXLMkW/N/k1ty5b5a5i/1V8Ob7tsYrSvcvN7Y2GZDEYZDSFb+WFDBOtg0qY7MeWSC7Tnlc648FtU2iocTNOAy9dwNGL7Tw33Wj7pGMGjPgpLYGSrqsCuezgS2hb6vUwoEA1xS8scbosKsEPuN+Zcb+t8ZMe4lxyxu3oTyfPeYBzSGGsc3F7kDoxO5lgfxlV97nHotLXxmeiZQXrGUKw1HcgN6vlck3cSF2MPC7ukW9QMxOxXJarkWp9qdoS70I9eMmg5GcIVKaYfh3AgGc
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(376005)(1800799015)(82310400014)(36860700004); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2024 21:27:51.6147 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c04e19cf-31c7-4a11-e843-08dc59a513dd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000044A7.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8963
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
have:
 
* Expand dmub_cmd operations.
* Update DVI configuration.
* Modify power sequence.
* Enable Z10 flag for IPS.
* Multiple code cleanups.

Cc: Daniel Wheeler <daniel.wheeler@amd.com>

Thanks
Siqueira

Anthony Koo (1):
  drm/amd/display: Expand dmub_cmd operations

Aric Cyr (1):
  drm/amd/display: 3.2.281

Bitnun, Ethan (1):
  drm/amd/display: Improve the log precision

Chaitanya Dhere (1):
  drm/amd/display: Fix incorrect pointer assignment

Charlene Liu (1):
  drm/amd/display: limit the code change to ips enabled asic

Chris Park (1):
  drm/amd/display: Add a function for checking tmds mode

Eric Bernstein (1):
  drm/amd/display: Update FMT settings for 4:2:0

Mikita Lipski (1):
  drm/amd/display: Fix PSR command version passed

Nicholas Kazlauskas (1):
  drm/amd/display: Pass sequential ONO bit to DMCUB boot options

Rodrigo Siqueira (11):
  drm/amd/display: Use dce_version instead of chip_id
  drm/amd/display: Adjust headers
  drm/amd/display: Group scl_data together in
    resource_build_scaling_params
  drm/amd/display: Replace int with unsigned int
  drm/amd/display: Update some comments to improve the code readability
  drm/amd/display: Remove unnecessary code
  drm/amd/display: Rework dcn10_stream_encoder header
  drm/amd/display: Move REG sequence from program ogam to idle before
    connect
  drm/amd/display: Update DCN201 link encoder registers
  drm/amd/display: Add missing callback for init_watermarks in DCN 301
  drm/amd/display: Add missing replay field

Samson Tam (1):
  drm/amd/display: add support for chroma offset

Sung Joon Kim (4):
  drm/amd/display: Modify power sequence
  drm/amd/display: Modify resource allocation logic
  drm/amd/display: Enable Z10 flag for IPS FSM
  drm/amd/display: Rework power sequence and resource allocation logic

 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |   9 +
 .../gpu/drm/amd/display/dc/clk_mgr/clk_mgr.c  |   2 +-
 .../display/dc/clk_mgr/dcn32/dcn32_clk_mgr.c  |   3 +-
 drivers/gpu/drm/amd/display/dc/core/dc.c      |   8 +-
 .../gpu/drm/amd/display/dc/core/dc_resource.c |   5 +-
 .../gpu/drm/amd/display/dc/core/dc_state.c    |  10 +-
 .../gpu/drm/amd/display/dc/core/dc_stream.c   |   2 +-
 drivers/gpu/drm/amd/display/dc/dc.h           |  16 +-
 drivers/gpu/drm/amd/display/dc/dc_hw_types.h  |   7 +
 drivers/gpu/drm/amd/display/dc/dc_types.h     |   2 +
 .../gpu/drm/amd/display/dc/dce/dce_i2c_hw.c   |   6 -
 .../amd/display/dc/dcn10/dcn10_link_encoder.h |   6 -
 .../gpu/drm/amd/display/dc/dcn10/dcn10_opp.c  |   9 +-
 .../gpu/drm/amd/display/dc/dcn10/dcn10_opp.h  |   2 +
 .../display/dc/dcn10/dcn10_stream_encoder.h   |  10 +-
 .../gpu/drm/amd/display/dc/dcn20/dcn20_hubp.h |   2 +-
 .../gpu/drm/amd/display/dc/dcn20/dcn20_mpc.c  |  10 +-
 .../drm/amd/display/dc/dcn201/dcn201_hubp.c   |   5 +
 .../display/dc/dcn201/dcn201_link_encoder.h   |  14 +-
 .../gpu/drm/amd/display/dc/dcn30/dcn30_dccg.h |  18 --
 .../dc/dcn30/dcn30_dio_stream_encoder.c       |   1 -
 .../gpu/drm/amd/display/dc/dcn30/dcn30_dwb.c  |   2 -
 .../drm/amd/display/dc/dcn301/dcn301_hubbub.c |   1 +
 drivers/gpu/drm/amd/display/dc/hwss/Makefile  |   2 +-
 .../drm/amd/display/dc/hwss/dcn351/Makefile   |  25 ++-
 .../amd/display/dc/hwss/dcn351/dcn351_hwseq.c | 182 ++++++++++++++++++
 .../amd/display/dc/hwss/dcn351/dcn351_hwseq.h |  41 ++++
 .../amd/display/dc/hwss/dcn351/dcn351_init.c  |   1 +
 .../dc/resource/dcn32/dcn32_resource.c        |   4 +-
 .../dc/resource/dcn32/dcn32_resource.h        |   6 +
 .../dc/resource/dcn351/dcn351_resource.c      |   5 +-
 drivers/gpu/drm/amd/display/dmub/dmub_srv.h   |   1 +
 .../gpu/drm/amd/display/dmub/inc/dmub_cmd.h   |  53 ++++-
 .../gpu/drm/amd/display/dmub/src/dmub_dcn35.c |   1 +
 .../drm/amd/display/include/signal_types.h    |  13 ++
 35 files changed, 402 insertions(+), 82 deletions(-)
 create mode 100644 drivers/gpu/drm/amd/display/dc/hwss/dcn351/dcn351_hwseq.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/hwss/dcn351/dcn351_hwseq.h

-- 
2.43.0

