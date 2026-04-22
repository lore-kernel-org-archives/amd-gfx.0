Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD36CF94CC2
	for <amd-gfx@archiver.kernel.org>; Wed, 22 Apr 2026 03:56:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 66FCA10E02C;
	Wed, 22 Apr 2026 03:56:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="IrJyoFXZ";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010005.outbound.protection.outlook.com [52.101.201.5])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C0E7010E02C
 for <amd-gfx@lists.freedesktop.org>; Wed, 22 Apr 2026 03:56:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WZOo8VX9byRhu3zkUHF2/baoBNOTSltm5bD0W0RaaoGEU/8E0lZwVqE8GdOLZsWaRgxzweNQvN+xLiu3xojE82BH1uOw0cu0W7QYi9yhmuONuNJMoyNMKOL7pUO+H6G3kh2dAj7Ln/zAr51PWfGoBo2Q0DUvSotDSgPZDRnlKjsW+fuxhzhPU/20Dl3BvXSSGGddNLn+WPpMfoYoWB3qxYCBGXNRrF9KHDi0P/rWHAbttUhW7Bq3KEqxqTvOSUXUTQRM7Mlexju90klQMIEPgTkDcOb3Li0lX8IJ4sPSjzEGEY5Xwb4cF41CvZnH0KGAPpkcoLYaj1Tc7OuqBLB04g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y4TwY492VOPgA991HPcOgOrhBIEUVKeQ1h1NMf1zstU=;
 b=jCLFSXJfzhZLNwK2fzsEFovMn9bd38BtofoLK7pn3meOEFK8vFSFVi0WBW3e0VDMFzLjBPZxGEJr4vllZxfA9IzjlFSvhc6yySER2Myysr7nLshgtbdDQss9fec+3hiwyteVoTey3qaAWkwDK2nzZBHxPyyzHwkONv9o/EdjvfPA1EvwOYBzYxrPSKI+4tyaN8Q4Mtl20GdClI82rnT8dL0ar7qo6HSq0wLCKgyjslUhd9QjxhwtgBxOZfu66K+2zgdVWEDSuKhcQy6CvwSWWLZMqADcVEGTWR2cwU+Fy4a+SgG7G4Nt8EkLc1jbNj/diXnYtkr1hiG8Z4+BW2Oi2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y4TwY492VOPgA991HPcOgOrhBIEUVKeQ1h1NMf1zstU=;
 b=IrJyoFXZreBpN3ezXgrvIGTtamVDzYIoTq5yrQmlE9R9/XmXRAZS3VDwh6XJtu1OzMbnuDwLnIMDKAWuFC4Xu29rxNAqWpaC7Y/m4LzmEe8MO3VlQHTlTM15DLL+mPNgcfmz1WfxMn8aocXeN8AbB6wR2vIJJZ16H5RKRs4riVQ=
Received: from CY5PR13CA0002.namprd13.prod.outlook.com (2603:10b6:930::10) by
 DM4PR12MB6447.namprd12.prod.outlook.com (2603:10b6:8:bf::16) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9846.16; Wed, 22 Apr 2026 03:56:24 +0000
Received: from CY4PEPF0000EDD6.namprd03.prod.outlook.com
 (2603:10b6:930:0:cafe::dc) by CY5PR13CA0002.outlook.office365.com
 (2603:10b6:930::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9846.15 via Frontend Transport; Wed,
 22 Apr 2026 03:56:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000EDD6.mail.protection.outlook.com (10.167.241.202) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9846.18 via Frontend Transport; Wed, 22 Apr 2026 03:56:23 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Tue, 21 Apr
 2026 22:56:23 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 21 Apr
 2026 22:56:22 -0500
Received: from tom-r5.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Tue, 21 Apr 2026 22:56:20 -0500
From: Tom Chung <chiahsuan.chung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>
Subject: [PATCH 00/14] DC Patches Apr 27 2026
Date: Wed, 22 Apr 2026 11:52:38 +0800
Message-ID: <20260422035611.1870316-1-chiahsuan.chung@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: chiahsuan.chung@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD6:EE_|DM4PR12MB6447:EE_
X-MS-Office365-Filtering-Correlation-Id: 8a9bb129-8d8c-4d66-dc54-08dea0231eff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|1800799024|376014|82310400026|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: RoiYzOdkvrgm/sUUCEbtURrD4CsKhfj61DoQCPL1r5ODuKOpLkrTbSU7DSp2FPe7oNGQk0srQOf5vZDq8/9M51f35foQjCFn9lyfZyjV9JSKVdbW86ggkRmf194Bi+j4EwMU2CO9GWv6pfEqbT4RJC/TyS/qW0o6RCW/wNNXhXe2knx382blgJ7tjTHg48VF/eiGHUi6IodY9eHtrFmB+R53Z0880OUheAu+yqPdAoeG2bqhLTibQSnTab8vFcAfaptJCGe+CDrAC2zfLV/oU9WIAac/Nid0/WCxsKm6L98gAn6+Og6CZP1YtEtX+sLC209EBS1cHJOk3V/Pk24i43DJxJ64pufV25INITKG+9fr2XCFw8dxcIdc1eaNqHvH5EoKkGhDz38cHLJGbJXJ/wGg2M25EMuGE83ZTcteLscpDfru17IuFxUSDEyjGegL2ekCSq2jLJgIEImPagB9ILJc2EBKpnq6SlNdI8lK6+97YFux5aRSy2yOZAI0LB/weM7r3VuCYLkg7IOx5v1TKaLJc81YSwdTYMWG9Ooi0GTptJLohJXGAEnAjIm352eMilsCMJ/gQhYzll5JkvzBA4D9mlJcyDC2sLkcCzOMQW7Ns6cJ/esXKdIGho5RMNeuJBmtdUe+TsABYEshRTMIy+ZSeOUWPikGkpvHK2jWVWsTPvOfYLZfZiYz+vDS/moQ5iYf/n85+WYTlfAEoePNoNcFXw7PRMnAranxTmjV2smx/KiABXfLBK4Td295QB+fzqFjnPqJtJK7COMMpQ5nBQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(1800799024)(376014)(82310400026)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: ZM5cemdaMjkApQLN37DlrHCurVoxxj8xynkZcCGYhP7n15Ur4YnVXttxmgSQaKUDaBBJp+JVse9ddSNe+ZYsFyhv+JjPxlgkBofzWvRLArL64HmojEOFGLKJLp6emQh1cobySe7wbvWkGaGB2rOxW3yOYWVMk1GSoS659nZH7Xf1+OZMc7ifdfHaRbUddwwD5aLSDXuHcxvkdhC4Br4wb2w64PncmS1IX5QbRl8bzgB3SRGFLz7ggOhUM0m/Z09TRkLW2fs/hrtxLgFNA1T8T1dfve/wwc0HpbtzERODwUSelGJJlpqoc5BkuVCiJXp2ynATViGu/kHkf8JpgVPIMA+Ya/u05qOAnC1m4L5H5zjw/+tXJOwydENMsv9/sD7RnMx1tKaq4VbXmCTRTOdV1iRBofiafuHL8imzWMTydRSIyRYNEN9eg1N88nL611JG
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2026 03:56:23.6701 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a9bb129-8d8c-4d66-dc54-08dea0231eff
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EDD6.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6447
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

This DC patchset brings improvements in multiple areas. In summary, we have:

-Fix root clock disabled when DSC power gate disabled for DCN314
-Enable RCG on DCN42
-Enable/Disable some power gating
-Remove Mall, SubVP and MCLK from DCN42
-Unify fast update classification paths
-Fix narrowing boundaries in dml
-Update MCIF_ADDR macro to address IGT DWB regression
-Fix dual cursor shows on extend desktop
-Fix hubp tmz field define mismatch


Cc: Daniel Wheeler <daniel.wheeler@amd.com>

Charlene Liu (2):
  drm/amd/display: fix hubp tmz field define mismatch
  drm/amd/display: fix dual cursor shows on extend desktop

Gaghik Khachatrian (3):
  drm/amd/display: Update MCIF_ADDR macro to address IGT DWB regression
  drm/amd/display: Fix implicit conversion warning
  drm/amd/display: Fix narrowing boundaries in dml

Ivan Lipski (2):
  drm/amd/display: Remove Mall, SubVP and MCLK from DCN42
  drm/amd/display: Enable RCG on DCN42

Jing Zhou (1):
  drm/amd/display: fix root clock disabled when DSC power gate disabled
    for DCN314

Leo Chen (3):
  drm/amd/display: Enable driver power gating
  drm/amd/display: Enable HUBP/OPTC/DPP power gating
  drm/amd/display: Disable hpo power gate

Rafal Ostrowski (1):
  drm/amd/display: Unify fast update classification paths

Taimur Hassan (2):
  drm/amd/display: [FW Promotion] Release 0.1.57.0
  drm/amd/display: Promote DC to 3.2.380

 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |    4 +-
 drivers/gpu/drm/amd/display/dc/core/dc.c      |  252 +--
 .../drm/amd/display/dc/core/dc_hw_sequencer.c |   14 +-
 drivers/gpu/drm/amd/display/dc/dc.h           |   38 +-
 drivers/gpu/drm/amd/display/dc/dc_stream.h    |    3 +
 .../drm/amd/display/dc/dcn30/dcn30_mmhubbub.c |   20 +-
 .../amd/display/dc/dml/calcs/dcn_calc_auto.c  | 1854 ++++++++---------
 .../amd/display/dc/dml/calcs/dcn_calc_math.c  |    6 +-
 .../drm/amd/display/dc/dml/calcs/dcn_calcs.c  |  280 +--
 .../drm/amd/display/dc/dml/dcn20/dcn20_fpu.c  |  112 +-
 .../dc/dml/dcn20/display_mode_vba_20.c        |  292 ++-
 .../dc/dml/dcn20/display_mode_vba_20v2.c      |  290 ++-
 .../dc/dml/dcn20/display_rq_dlg_calc_20.c     |  164 +-
 .../dc/dml/dcn20/display_rq_dlg_calc_20v2.c   |  164 +-
 .../dc/dml/dcn21/display_mode_vba_21.c        |  296 ++-
 .../dc/dml/dcn21/display_rq_dlg_calc_21.c     |   80 +-
 .../drm/amd/display/dc/dml/dcn30/dcn30_fpu.c  |   74 +-
 .../dc/dml/dcn30/display_mode_vba_30.c        |  328 +--
 .../dc/dml/dcn30/display_rq_dlg_calc_30.c     |   82 +-
 .../amd/display/dc/dml/dcn301/dcn301_fpu.c    |   20 +-
 .../amd/display/dc/dml/dcn302/dcn302_fpu.c    |   16 +-
 .../amd/display/dc/dml/dcn303/dcn303_fpu.c    |   16 +-
 .../drm/amd/display/dc/dml/dcn31/dcn31_fpu.c  |   26 +-
 .../dc/dml/dcn31/display_mode_vba_31.c        |  354 ++--
 .../dc/dml/dcn31/display_rq_dlg_calc_31.c     |   76 +-
 .../amd/display/dc/dml/dcn314/dcn314_fpu.c    |    8 +-
 .../dc/dml/dcn314/display_mode_vba_314.c      |  358 ++--
 .../dc/dml/dcn314/display_rq_dlg_calc_314.c   |   80 +-
 .../drm/amd/display/dc/dml/dcn32/dcn32_fpu.c  |  291 +--
 .../dc/dml/dcn32/display_mode_vba_32.c        |  174 +-
 .../dc/dml/dcn32/display_mode_vba_util_32.c   |  324 +--
 .../dc/dml/dcn32/display_rq_dlg_calc_32.c     |  138 +-
 .../amd/display/dc/dml/dcn321/dcn321_fpu.c    |   49 +-
 .../drm/amd/display/dc/dml/dcn35/dcn35_fpu.c  |   22 +-
 .../amd/display/dc/dml/dcn351/dcn351_fpu.c    |   22 +-
 .../drm/amd/display/dc/dml/display_mode_vba.c |    4 +-
 .../display/dc/dml/dml1_display_rq_dlg_calc.c |   32 +-
 .../drm/amd/display/dc/dml/dsc/rc_calc_fpu.c  |   82 +-
 .../drm/amd/display/dc/dpp/dcn42/dcn42_dpp.c  |    9 +
 .../amd/display/dc/hwss/dcn314/dcn314_hwseq.c |   90 +-
 .../amd/display/dc/hwss/dcn35/dcn35_hwseq.c   |    7 +
 drivers/gpu/drm/amd/display/dc/inc/hw/hubp.h  |    2 +-
 .../dc/resource/dcn42/dcn42_resource.c        |   53 +-
 .../gpu/drm/amd/display/dmub/inc/dmub_cmd.h   |   26 +-
 44 files changed, 3092 insertions(+), 3540 deletions(-)

-- 
2.43.0

