Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1742DD5CCA5
	for <amd-gfx@archiver.kernel.org>; Tue, 16 Dec 2025 09:57:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B002E10E2A6;
	Tue, 16 Dec 2025 09:57:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="vhmaoLlB";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011045.outbound.protection.outlook.com [52.101.62.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E3C2D10E2A6
 for <amd-gfx@lists.freedesktop.org>; Tue, 16 Dec 2025 09:57:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IBMy1sbXwewIUUle060vBdj9LwImFJp6QyQY1Z5HTMnB4yHmPIJ3mc5orij6BqhcSDg8jKHM5vphDpANmlRja/7ULbdlvEqNIIA4v0hipQWQ/0mN0efFs1nyCdhqs1m7CEZCT8HBo/zW37JcwSonPec+SRNMBz1vLagDyErchwsQHCvLvelt13JCvV+Ucpy4tb/3AOkDUEDGJC5saLMYIiUmaFOHFB1Tr+kSWRTMZwcorLbXb3dLGA/rEBFYzlMfY6ANsDS9fxMGlHdc0dg+sggPyWgfClv8XjM8+FH1PJLkRWS0hEUQ4DDtMVS34Dtu7DQNB+9DJy17MgFIrH6x+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BX2LgP9nBBTMuVUNvL/S4hlBUf3RpH0ibem6ynPP5Uw=;
 b=fAmpVPMsvswgEzMAovJukKpQtEJniju+qxxEawpn7US/YP6LYcnEcwA4TDDeJwb2TxD6E1Uh4xlaaMALN7eyJ6mIA+IHS8KGcALmBQn0j26917RRjKdpcq5itT/5uzqcQQQPYboSDVW8/LaHsX0MmueC6qNy3LpEvsJzRAqf8e9VEjVbPeMcrUBSrEekUrmZw2pm0FrOzVF2Y9NLDrMWWA8sWdOpDpup4VdfrlVTnmoLzV9zug/KvmyJN/9qNDy53jWQSPjOuf52bbJGsRAOKlUBuowAKdOpbxcAmROQXBS59kG69Kz9k5VeI6ujy+Sin0AeX1/5DtJJLUqzMSla9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BX2LgP9nBBTMuVUNvL/S4hlBUf3RpH0ibem6ynPP5Uw=;
 b=vhmaoLlB3I4/mHupUmwF0fk+xQ8l4Dl545K7avjxEuS4Q5uFusYfWWdG/94s6+qiWREXiCUnkQ/b/5IA1RrRGzPplfKIVnm9B8ihiwx9bg3br1WqW7+JWi+opUt7V/xlBcAZbvBCGd3yr2Wzl6PbCbFbN6RF8LCRIyuWTJRhDVA=
Received: from SA1PR02CA0002.namprd02.prod.outlook.com (2603:10b6:806:2cf::6)
 by DM4PR12MB7768.namprd12.prod.outlook.com (2603:10b6:8:102::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.13; Tue, 16 Dec
 2025 09:57:30 +0000
Received: from SN1PEPF0002636E.namprd02.prod.outlook.com
 (2603:10b6:806:2cf:cafe::c7) by SA1PR02CA0002.outlook.office365.com
 (2603:10b6:806:2cf::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9412.13 via Frontend Transport; Tue,
 16 Dec 2025 09:57:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF0002636E.mail.protection.outlook.com (10.167.241.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9434.6 via Frontend Transport; Tue, 16 Dec 2025 09:57:30 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 16 Dec
 2025 03:57:30 -0600
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 16 Dec
 2025 03:57:29 -0600
Received: from chenyu-station.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Tue, 16 Dec 2025 01:57:26 -0800
From: Chenyu Chen <chen-yu.chen@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, Chenyu Chen <chen-yu.chen@amd.com>
Subject: [PATCH 00/16] DC Patches Dec 22 2025
Date: Tue, 16 Dec 2025 17:56:00 +0800
Message-ID: <20251216095723.39018-1-chen-yu.chen@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002636E:EE_|DM4PR12MB7768:EE_
X-MS-Office365-Filtering-Correlation-Id: 09927ada-9213-4c1e-1c1a-08de3c8986ea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?77aGtuM9HfKODPEmVSrAqBd/sh5EEBwzzm4g95eHG0cgIYkpMGHylvJ9z9Zh?=
 =?us-ascii?Q?2Q2T4ICqpDv0H4axkRwe2SHHXPlcEE8IlA4cb1CbLu/6HRTgr7L5IolSujHK?=
 =?us-ascii?Q?HzdKTP9E15rddpr2QYPYJsIUMy09PdjTMC/uIKDtJUohz0P194A4L3hu4APA?=
 =?us-ascii?Q?FwjKR6jRs+XBGdxrKilIiUDoqmkg6En8kCzxF3dxxKcft9RWsiPjIeh5RL81?=
 =?us-ascii?Q?gTrd5NynbnvLYPMofljCBdnOMj1hXuh+y6M/MOhQc03X/hA/W5PJZ5tYC6vL?=
 =?us-ascii?Q?Cvimci1ViUcO4Y0vw7h5HpFN3whRN+KN8XDArGFQSLLI0fmyVG8pPwaRiWff?=
 =?us-ascii?Q?WCiz1ekxu4GB+ivMarJ1icx9isQ6FFI8Jb8FHHOyCp+qd+P6jHaBZiyqcXdJ?=
 =?us-ascii?Q?tHYt1a8yobKBQfKpulmHXNYM5gMmyRB/lxfw0Zp6oNg7LEas91EDRuknmU6w?=
 =?us-ascii?Q?Qxro0EBFWNNR7vQRWJCiO3U7O+AJxXBu2e6DpVZU6abuupquKfmVoY/Z35di?=
 =?us-ascii?Q?zVAtvvVd+dKh6HT2+bVBoP7ry3P0SsHW3OYBHbhKac9lXHGq/ft+i0SCHx6+?=
 =?us-ascii?Q?VgH4pwtSrJTt9DNcI3srMzUrNL3SzyGX4Bewl7wBSpSMeah7TGc4cDgPaCa9?=
 =?us-ascii?Q?YaFsqApXBL7rXmqVFZKW1rBDTfG+VRDxCm2CSvvHHI7/DsURK9dWoUHRN7ab?=
 =?us-ascii?Q?naZb1ERCKHuatAZrPdgOmuihAFWHARtiqZEXAU1Zf2/nhNtNQ7el7JYzFKzA?=
 =?us-ascii?Q?tk/9ww8uD75CpH3qQZqDEt2sQ9FPSCwJ4uGPy+4kWwnwIjwOmO/NYDYs/Vgi?=
 =?us-ascii?Q?25BWXx/2UTgmUJ530elLnJJsaVmuUQH2aN+1ikb+uqUoqgpHUpXtWM5dJOvP?=
 =?us-ascii?Q?V1pKf5Pw8Zr8sUSPiVemOZKOygr8GmcVGuCfatK/OmeBEU2Lh/qS2wZvY8on?=
 =?us-ascii?Q?44i/pcKneDgj2VOQgM0lJauSY6fo6mKtKWxvGSqyKDP7Ho5TWX214waQVc2n?=
 =?us-ascii?Q?yPNsIxYx5e7ds24ktB4MFsgQIaobAx+e+FNeLirQgzPla+wNY0xKqPVbISHA?=
 =?us-ascii?Q?WlEb7Ov2fIOHHxSddvOEicr6Ws/qxEu22nsx51CSjqPh3zVBErQAS/g3nm6t?=
 =?us-ascii?Q?YwGflDIo/Vpwr3wH2pK9OS+mQiNVkGO8jpGkZ4XxNEujzGQ52vDkk2oljfSP?=
 =?us-ascii?Q?TbnULiLUeLCzixRUxij6SCiHyn4Ldqegw2C36JbRJ01fXditjeBPrXYidlQU?=
 =?us-ascii?Q?IXazi9NLwecTX2Uqo9/p47W61JBCAmhOPjCdQpHRpWG6wx8C3YDrpKM+awLJ?=
 =?us-ascii?Q?yQDyzLWzlta5B8/mAyzaPVBw/aYybItvtlc3IOv9qjl9UXikJBBsOX1RsFTQ?=
 =?us-ascii?Q?YgvJYSBzoihc2keqyir2N3WXtY7TLmUgj9r+fxdvZjK20MFgjwY9yanRFCLk?=
 =?us-ascii?Q?vi8czWycsWNCSocWfTGTSteo+wcKGCxkAcaoifKtQXBMQLcWWl23jKumpFqI?=
 =?us-ascii?Q?5kN7nYBpodjgdryWnmjhcEvVDfVJLSsr3rAKrhUZHqb/IT23clcMsgp/rYcI?=
 =?us-ascii?Q?ofsPT8eZS95iPDfOxhs=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2025 09:57:30.4274 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 09927ada-9213-4c1e-1c1a-08de3c8986ea
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002636E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7768
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

This DC patchset brings improvements in multiple areas. In summary, we highlight:

 - Add frame skip feature support flag.
 - Add sink EDID data null check.
 - Update function name to link_detect_connection_type_analog.
 - Fix mismatched unlock for DMUB HW lock in HWSS fast path.
 - Fix P010, NV12, YUY2 scale down by four times failure.
 - Fix and reenable UPDATE_V3_FLOW_NEW_CONTEXT_MINIMAL.
 - Consolidate dmub fb info to a single struct.
 - Add new fields to fams2 config.
 - Update timing source enums.
 - Add signal type check for dcn401 get_phyd32clk_src.
 - Fix dsc eDP issue.
 - Remove unnecessary divider update flag.
 - Update dc_connection_dac_load to dc_connection_analog_load.
 - Check NULL before calling dac_load_detection.
 - Replace log macro for analog display detection.

Cc: Daniel Wheeler <daniel.wheeler@amd.com>

Alex Hung (4):
  drm/amd/display: Update function name to
    link_detect_connection_type_analog
  drm/amd/display: Update dc_connection_dac_load to
    dc_connection_analog_load
  drm/amd/display: Check NULL before calling dac_load_detection
  drm/amd/display: Replace log macro for analog display detection

Charlene Liu (1):
  drm/amd/display: Fix dsc eDP issue

ChunTao Tso (1):
  drm/amd/display: Add frame skip feature support flag

Clay King (1):
  drm/amd/display: Update timing source enums

Cruise Hung (1):
  drm/amd/display: Remove unnecessary divider update flag

Dillon Varone (2):
  drm/amd/display: Consolidate dmub fb info to a single struct
  drm/amd/display: Add new fields to fams2 config

Dmytro Laktyushkin (1):
  drm/amd/display: Add signal type check for dcn401 get_phyd32clk_src

Dominik Kaszewski (1):
  drm/amd/display: Fix and reenable UPDATE_V3_FLOW_NEW_CONTEXT_MINIMAL

Kaier Hsueg (1):
  drm/amd/display: Fix P010, NV12, YUY2 scale down by four times failure

Nicholas Kazlauskas (1):
  drm/amd/display: Fix mismatched unlock for DMUB HW lock in HWSS fast
    path

Richard Chiang (1):
  drm/amd/display: sink EDID data null check

Taimur Hassan (1):
  drm/amd/display: Promote DC to 3.2.364

 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |  6 +-
 drivers/gpu/drm/amd/display/dc/core/dc.c      | 80 +++++++++----------
 .../drm/amd/display/dc/core/dc_hw_sequencer.c | 10 ++-
 drivers/gpu/drm/amd/display/dc/dc.h           |  2 +-
 drivers/gpu/drm/amd/display/dc/dc_types.h     |  5 +-
 .../amd/display/dc/hwss/dce110/dce110_hwseq.c | 12 ++-
 .../amd/display/dc/hwss/dcn401/dcn401_hwseq.c |  6 +-
 .../display/dc/link/accessories/link_dp_cts.c |  6 +-
 .../drm/amd/display/dc/link/link_detection.c  | 27 ++++---
 drivers/gpu/drm/amd/display/dc/sspl/dc_spl.c  |  3 +-
 drivers/gpu/drm/amd/display/dmub/dmub_srv.h   | 16 +++-
 .../gpu/drm/amd/display/dmub/src/dmub_dcn20.c |  6 +-
 .../gpu/drm/amd/display/dmub/src/dmub_dcn30.c |  6 +-
 .../gpu/drm/amd/display/dmub/src/dmub_dcn31.c |  6 +-
 .../gpu/drm/amd/display/dmub/src/dmub_dcn32.c |  6 +-
 .../gpu/drm/amd/display/dmub/src/dmub_dcn35.c |  6 +-
 .../drm/amd/display/dmub/src/dmub_dcn401.c    |  6 +-
 .../gpu/drm/amd/display/dmub/src/dmub_srv.c   |  7 +-
 .../amd/display/modules/power/power_helpers.c |  3 +
 19 files changed, 121 insertions(+), 98 deletions(-)

-- 
2.43.0

