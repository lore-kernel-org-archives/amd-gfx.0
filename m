Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C156AC7618E
	for <amd-gfx@archiver.kernel.org>; Thu, 20 Apr 2023 23:50:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4A34D10ED3F;
	Thu, 20 Apr 2023 23:50:14 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on20611.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eab::611])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E55A610ED3F
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 Apr 2023 23:50:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UiXpYYq/Oxqx0bUm/vAZU2TgLR+qdtb2ZOwwIGpk9PrWUQ9ZUKSl+FuWjAZBveJVICcnsfNA/MyQXLmIR5IlsJwxGzo5JsGk5Yxyh43x7AeRC25+83VLadI4TU6uFmRvkoxurzTMNsO/tNaUUn+y9psT0M6y17LNIYKJo0o2rmdQUwwu3/RZJuDOSciI60qWk1lfMM4+KO9TWvlrOGQlAgwvdrX42mGCotRZTxcrnvnT0NeAzDox+A9NDK02wzOak63+zYcNG9qgHeJIwENzMh2Nmiwx0mMi6iQT+dPyvsZIc4tOturqMaUtqPv079ce6cm2tFttlPzyuHYHhvtSYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V+txkBOQ0Ci+ZFr1jE5LFQyrw82ljwGrQ8UrAbODMfQ=;
 b=XDSsWbhUn+Xip85bAAzbxQCWhhl+H2WHZ0WjIF9dbJM/Zp2rtQEJyiA4Z84MxNxHOQZ2Gm5Yxa/mdqiszkkMryY3VsGExkv43BJSnqst7hK6UiqyLXLkMASROs2X5yHa4IWS2bg8qaFLOQ+b8dEcNZW/puutUd+pQI/QN0G+OKYlMn3Azdg9qOw/n9m4CNuLogB1QKMPUAp62DGAzmu+FoBUWnWE3gCpIO7RGRG+7olUyzNe7uwdUv0VMvjuZfoBy0U5dvQtVuJ/Tfiu6SJg2CcKq00L1Ocanxo8txsO5LHrzL35PeoBFfuODb4PI/JqbOMevJIgAJuzXqLB8HFjtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V+txkBOQ0Ci+ZFr1jE5LFQyrw82ljwGrQ8UrAbODMfQ=;
 b=2kha1YWZfjuugv0HaABbsPuF0sJu9V5OhF3GHp+FnQtnjw1VVi+qWQ0U9LtVNdcC7iok1aIb7IM082a2lMKDm7/oU43Y74ePyr1b0TGn8PHdiOhOUUWDpov80UuluZsq2sW7+GNWNZfb1Sv6E3a1lVUvu7fZRtRRWd05EEeitHY=
Received: from DM6PR04CA0027.namprd04.prod.outlook.com (2603:10b6:5:334::32)
 by IA1PR12MB7760.namprd12.prod.outlook.com (2603:10b6:208:422::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.22; Thu, 20 Apr
 2023 23:50:07 +0000
Received: from DM6NAM11FT039.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:334:cafe::89) by DM6PR04CA0027.outlook.office365.com
 (2603:10b6:5:334::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.25 via Frontend
 Transport; Thu, 20 Apr 2023 23:50:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT039.mail.protection.outlook.com (10.13.172.83) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6319.26 via Frontend Transport; Thu, 20 Apr 2023 23:50:07 +0000
Received: from smtp.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 20 Apr
 2023 18:50:05 -0500
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 00/21] DC Patches April 20, 2023
Date: Thu, 20 Apr 2023 17:49:30 -0600
Message-ID: <20230420234951.1772270-1-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT039:EE_|IA1PR12MB7760:EE_
X-MS-Office365-Filtering-Correlation-Id: e85707a3-a437-44da-f821-08db41f9f896
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WwQdzbWqD+kKoobcUYcsgJ+M/6Mo7N1Vw0PdpymoZI3OR98XAZtrPprHgxG4zzs36bSWWQCFaR0QlZ8dY3EysWpCdzs2i8VKMqPJMvNAr1nzygNdVwxfEWeXVpgQlL/PNnZgXL0xRiZC5+SEzSIK+f9hQTtovdSamoKecxt/jnP5iNzQlMRVfFGoTn9jwsTSkTHOdAoU4crq7/Fp9oSJTxJ2tCcJ8nQ+7cNvoDrtq07q21UePjK5A8sg26kTLG1zhnkoDZrtog95XGpFawiBDQfi5DJugGoNRA+PUNU1eDTKM+WooMBMUz+Aq5D2+48ecPCI4LCMt8EdL7uxqUCB+Ww/YUrNVJh3epOwe1C2X2q35yLFEMuNZ5UiUxZqeLrqIfpPRG49MjPcEUBP3ihjzLPPccb4+WzCMVJCemFcIz1n8CBPXJh1VDcHrzjRvU8FBCe6kPyPziInXgyJxGRGKXcjxGQXzh2stAeJTp1jTWQCOp3mlZWOhta0RwIrXBvMgegdK9uQk0Kc3TcAS5cX1K7t+ZQ0JPQPbp9YXIuvUKaGCROVAIeFIbaee8Fg6x/2UM+FKUH/7FoLlZewfmBcqgEgetG5Xu6CVG+n0ISqEnqqyD8U5Q8/Kk3kbfOZxaZlxFlyt8gFNSwZeA8KrmKFJ6xQtvjkzq4gIckjbMFAZfyJ/X5LJ1ueCyr6VGq4gS9W9DYXZ+PiAkuaBo8mBNg7bI5OXX0JhS7zE5Z+VuOF+X8=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(39860400002)(376002)(346002)(136003)(451199021)(36840700001)(46966006)(40470700004)(40460700003)(2906002)(8936002)(8676002)(86362001)(356005)(81166007)(5660300002)(82310400005)(36756003)(41300700001)(40480700001)(1076003)(6666004)(26005)(54906003)(82740400003)(478600001)(2616005)(36860700001)(47076005)(83380400001)(426003)(336012)(186003)(16526019)(316002)(70586007)(6916009)(4326008)(70206006)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Apr 2023 23:50:07.5581 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e85707a3-a437-44da-f821-08db41f9f896
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT039.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7760
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

This DC patchset brings improvements in multiple areas. In summary, we
highlight:

- Improvements in the SubVP feature
- Keep disabling aux-i delay as 0
- Add p-state debugging and improvements
- Fix in secure display context creation
- add an option to use custom backlight caps
- Lowering min Z8 residency time
- Restore rptr/wptr for DMCUB as a workaround
- Update FW feature caps struct 

Cc: Daniel Wheeler <daniel.wheeler@amd.com>

Alan Liu (1):
  drm/amd/display: Fix in secure display context creation

Alex Hung (1):
  drm/amd/display: implement force function in amdgpu_dm_connector_funcs

Alvin Lee (6):
  drm/amd/display: Update FW feature caps struct
  drm/amd/display: Limit DCN32 8 channel or less parts to DPM1 for FPO
  drm/amd/display: Enable SubVP on PSR panels if single stream
  drm/amd/display: For no plane case set pstate support in validation
  drm/amd/display: Query GECC enable for SubVP disable
  drm/amd/display: Enable SubVP for high refresh rate displays

Anthony Koo (1):
  drm/amd/display: [FW Promotion] Release 0.0.163.0

Aric Cyr (2):
  drm/amd/display: 3.2.232
  drm/amd/display: 3.2.233

Dmytro Laktyushkin (1):
  drm/amd/display: add pixel rate based CRB allocation support

Gabe Teeger (1):
  drm/amd/display: update extended blank for dcn314 onwards

Hersen Wu (1):
  drm/amd/display: assign edid_blob_ptr with edid from debugfs

JinZe.Xu (1):
  drm/amd/display: Restore rptr/wptr for DMCUB as workaround

Josip Pavic (1):
  drm/amd/display: add option to use custom backlight caps

Leo (Hanghong) Ma (1):
  drm/amd/display: Update scaler recout data for visual confirm

Leo Chen (1):
  drm/amd/display: Lowering min Z8 residency time

Michael Strauss (2):
  drm/amd/display: Convert Delaying Aux-I Disable To Monitor Patch
  drm/amd/display: Keep disable aux-i delay as 0

Sung Lee (1):
  drm/amd/display: Add p-state debugging

 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 56 ++++++++---
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_crc.h |  2 +-
 .../display/dc/clk_mgr/dcn30/dcn30_clk_mgr.c  |  4 +-
 .../display/dc/clk_mgr/dcn32/dcn32_clk_mgr.c  |  7 +-
 drivers/gpu/drm/amd/display/dc/core/dc.c      | 21 ----
 .../gpu/drm/amd/display/dc/core/dc_resource.c | 18 ++++
 drivers/gpu/drm/amd/display/dc/dc.h           |  8 +-
 drivers/gpu/drm/amd/display/dc/dc_types.h     |  1 +
 .../drm/amd/display/dc/dcn10/dcn10_dpp_dscl.c | 18 +---
 .../drm/amd/display/dc/dcn20/dcn20_hubbub.c   |  5 +
 .../drm/amd/display/dc/dcn20/dcn20_hwseq.c    |  4 +-
 .../drm/amd/display/dc/dcn31/dcn31_hubbub.c   |  1 +
 .../amd/display/dc/dcn314/dcn314_resource.c   |  2 +-
 .../amd/display/dc/dcn315/dcn315_resource.c   | 97 ++++++++++++++++++-
 .../drm/amd/display/dc/dcn32/dcn32_hwseq.c    |  2 +
 .../drm/amd/display/dc/dcn32/dcn32_resource.c |  3 +
 .../drm/amd/display/dc/dcn32/dcn32_resource.h | 14 +++
 .../display/dc/dcn32/dcn32_resource_helpers.c | 15 +++
 .../amd/display/dc/dcn321/dcn321_resource.c   |  1 +
 .../drm/amd/display/dc/dml/dcn20/dcn20_fpu.c  | 31 +++---
 .../drm/amd/display/dc/dml/dcn31/dcn31_fpu.c  | 25 ++++-
 .../drm/amd/display/dc/dml/dcn31/dcn31_fpu.h  |  3 +
 .../dc/dml/dcn31/display_mode_vba_31.c        | 39 +++++---
 .../dc/dml/dcn31/display_rq_dlg_calc_31.c     |  3 +-
 .../amd/display/dc/dml/dcn314/dcn314_fpu.c    | 14 ++-
 .../dc/dml/dcn314/display_rq_dlg_calc_314.c   | 16 +--
 .../drm/amd/display/dc/dml/dcn32/dcn32_fpu.c  | 83 +++++++++++++++-
 .../drm/amd/display/dc/dml/dcn32/dcn32_fpu.h  |  2 +
 .../dc/dml/dcn32/display_mode_vba_32.c        | 12 ++-
 .../amd/display/dc/dml/display_mode_structs.h |  3 +-
 .../drm/amd/display/dc/dml/display_mode_vba.c |  6 ++
 .../gpu/drm/amd/display/dc/inc/hw/dchubbub.h  |  1 +
 .../link_dp_training_fixed_vs_pe_retimer.c    | 23 +++--
 drivers/gpu/drm/amd/display/dmub/dmub_srv.h   | 17 +++-
 .../gpu/drm/amd/display/dmub/inc/dmub_cmd.h   |  4 +-
 .../gpu/drm/amd/display/dmub/src/dmub_dcn20.c |  5 +
 .../gpu/drm/amd/display/dmub/src/dmub_dcn20.h |  2 +
 .../gpu/drm/amd/display/dmub/src/dmub_dcn31.c |  5 +
 .../gpu/drm/amd/display/dmub/src/dmub_dcn31.h |  2 +
 .../gpu/drm/amd/display/dmub/src/dmub_dcn32.c |  8 ++
 .../gpu/drm/amd/display/dmub/src/dmub_dcn32.h |  3 +
 .../gpu/drm/amd/display/dmub/src/dmub_srv.c   | 17 ++++
 .../amd/display/modules/power/power_helpers.c | 43 ++++++++
 .../amd/display/modules/power/power_helpers.h |  3 +
 44 files changed, 518 insertions(+), 131 deletions(-)

-- 
2.39.2

