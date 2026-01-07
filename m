Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38556CFD647
	for <amd-gfx@archiver.kernel.org>; Wed,  7 Jan 2026 15:57:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CEDC910E625;
	Wed,  7 Jan 2026 15:57:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="lsdlCD+/";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013071.outbound.protection.outlook.com
 [40.93.201.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8A94210E624
 for <amd-gfx@lists.freedesktop.org>; Wed,  7 Jan 2026 15:57:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gkk+ljcpAa7hOI54neQoBWEhgex/zykBWW3XykjSFRNhPYn/QuTgsTv6WScHC7/JSyRlnaxvq5URIP627NftCycuD5+ojke7ylxBCdBECBlvTwFXpQdROUIBEIkqdNXxenQW+FcGYIwG+ImGp3BFsQucMR7izwuAI1gAN3rePtmJ3dKIEErRChNxXCqp4PFvco9kaq5r8xGlu953XTuplvqLvkfYo6oPuiTbdPcR94go9hrXqROFLpeaPLwuUjLsdAb10wzydxLgthzbj66wF1h6bfTAhSE2GDNDRRp6+AmftQ0g5JzZwdu5b8zV4YaxR0RhwRnauYONldVuXEWr1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h7x3BBvP7o6AX7E1EzQrNqdBILZGZz2dDL6rjZx3fB0=;
 b=QhufFm0nvcsHDC9gHt4m+jRLYjZuU90z7zKlIO4wFBwERfcmSZ2rEfhUqNsDfCjjYMVTdL3wBaNOhiXCBKkY6dDzrRro0FGWXYtEI/YF6qk8w6qfk2tn4UKnlxck6CYgS2/sFfwHLiomkzYkrSLZCD6xcO0y3Q7kUHVOnq2ahM8zrPxlibH/n0xDWiWrsyNk9NDLNjdEoo5v8lC+65KldB9okDfx2Qp4tTr2GVIlRKno5+5pt861vG57mvyhAzGNL3KEwwdLv7HrLEvbwvskcsMCTi0PJx4gEencR2YDPpvDTsePBoZwM7YTe22nqdyNhEWsOKyt14F0linqjrpFTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h7x3BBvP7o6AX7E1EzQrNqdBILZGZz2dDL6rjZx3fB0=;
 b=lsdlCD+/AyJgv02BVomCIW/EVtWObrWby9Prr8V4ojeujdarJXmN2eB3iNDoffIzIAUh/Xn5+3PYtrfDl+rDL+j6K6A29+kJXx07ksCI2UTsDvBbJ9WvdJV3Uk75h4zDMRs6LYanT3EQe5NrglmY4C3RmEagkTDm3rEdTptnt1M=
Received: from SJ0PR13CA0187.namprd13.prod.outlook.com (2603:10b6:a03:2c3::12)
 by BN7PPF28614436A.namprd12.prod.outlook.com
 (2603:10b6:40f:fc02::6c9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.2; Wed, 7 Jan
 2026 15:57:48 +0000
Received: from SJ5PEPF000001CA.namprd05.prod.outlook.com
 (2603:10b6:a03:2c3:cafe::94) by SJ0PR13CA0187.outlook.office365.com
 (2603:10b6:a03:2c3::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9520.0 via Frontend Transport; Wed, 7
 Jan 2026 15:57:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001CA.mail.protection.outlook.com (10.167.242.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9499.1 via Frontend Transport; Wed, 7 Jan 2026 15:57:46 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 7 Jan
 2026 09:57:45 -0600
Received: from mkmmattstew-dt.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Wed, 7 Jan 2026 09:57:45 -0600
From: Matthew Stewart <Matthew.Stewart2@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, Matthew Stewart <Matthew.Stewart2@amd.com>
Subject: [PATCH 00/21] DC Patches Jan 12, 2026
Date: Wed, 7 Jan 2026 10:47:52 -0500
Message-ID: <20260107155421.1999951-1-Matthew.Stewart2@amd.com>
X-Mailer: git-send-email 2.52.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001CA:EE_|BN7PPF28614436A:EE_
X-MS-Office365-Filtering-Correlation-Id: 326bdacc-1876-47d5-c3dc-08de4e058038
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?8IJPLsH7/oPIwJTDgW22tK7p5xL9S7YSD2W6kF0V/HO2hofNtRnSKSRH6soG?=
 =?us-ascii?Q?mRyFgj4SUhNeCeFkftFPJe81653FUZHi2FkII/mNI8J7aqQ1y/D9WnZm0jOs?=
 =?us-ascii?Q?h2BBEZafS2VhFCDFzfaxyahnl1iSCIJuvoIvebngFQq0fZ30igWCRknTgCt4?=
 =?us-ascii?Q?k51io0KjPpxA1j3papNpDuuf343jbum5aBoa/BGS5VOVYnFDZs9JZfw0HXsd?=
 =?us-ascii?Q?m/9HEmDskYQdar8oTGg7tK1znE9QEfEirQzbyVbCa/DfFXNXRPZmyQ6+sdqC?=
 =?us-ascii?Q?4n5rLrt6VlqAXn/alMBdCsx/Gh8+5Skp6T4SVU9Nyxr42mf/hQdNtcFpGB5N?=
 =?us-ascii?Q?5+lhC3dPrxI3cwalNDpsb8T6+IboyRxvNvJds6amJw8Bhcgd0aQ14HuI9Zjp?=
 =?us-ascii?Q?mrKLQpKk9I28vztJrWrkXcnV0TYg3bR/mrNKKjOdtf13DhipAYBiCve8AVn1?=
 =?us-ascii?Q?Qb0w62qPzfyRL4pJR+sfp5yExB/LG271e+UxKePrT2MarOS7fLPbBEOjdl9X?=
 =?us-ascii?Q?eihuYFRF0AKHhOsvWAiXOGKQMyePXdlvyIpe1x8JGICzTToqObEhbSqrzD2t?=
 =?us-ascii?Q?zcQDO4CzbOUG47qVi2LNsS/NqA9pJO9PIvloTQ/wCGLy4YUlBJ0Sp581AZ/I?=
 =?us-ascii?Q?6cmmEI9HLO1EKszwNcePfB+UiINz7GB0Njp3nxZwQCmvC5NhslWL5gTfYFeH?=
 =?us-ascii?Q?Aj96SKbWwtA7Icekt/OfYLS6p+m+5F6EDGnjLuzlp0aXF5BNBvrcEmCT64oS?=
 =?us-ascii?Q?s6gcI4HpGUoX5PAJdvAqM/97hTJ6i2hD1W24oPTE15zBdIOWsgSGLcc/iFLg?=
 =?us-ascii?Q?6ZfMjwoQR6AXVc6nL9Z0ZfRQb5+Y8nt7GBLsdEEi0/iybte3vvo9I0Mer55G?=
 =?us-ascii?Q?DJWP3hiuHKt1rdSjF3qlmngONvlPP83zybKSbx+CPD4E235vdIgjEZCuvlq1?=
 =?us-ascii?Q?6U0r6YF3n7GZ7EdbRx6ZNmJLKGPqhJR5bkIe2QsnW2aPZJAVT9S4GulZIhKh?=
 =?us-ascii?Q?X7ARQisSPmU6fTuqpJ4uZ9FoADoMjW3Its+RnQ7o9a7lDveebLOxrAeMj/17?=
 =?us-ascii?Q?LlEl0WUuPWYCvMwNly1ztP/0yuVRtC0YKcInxArYGGLsI998gxK19icFNV35?=
 =?us-ascii?Q?z2MANABhx3URQqfltGzpW4kUd19achiXLL22Ki/vKyDbopjYw/5rg4UC0jXj?=
 =?us-ascii?Q?+tf8PFNNcN0oykQyWStEvmpCw5v7sAbyy5WI2WWt6+5WVmrxjMCnqgP7avZf?=
 =?us-ascii?Q?5qHGswVzVOkYh07HZPgCHkQL5UjmCLOM+gkfMlxz4aWnNUAVYTnOcGlcu8Oi?=
 =?us-ascii?Q?3ifio+OID35NXFuRgiTnOqA6q0EGsu2FfJinSa3q8HlRCr9Ruojx91R3pIom?=
 =?us-ascii?Q?rmMtdo9uuiNYETXlkvruhdoW307UZZI21qmQQ0zcWwAg3hBGyyg3/ZrTZhlh?=
 =?us-ascii?Q?ikUT04fL43eGPznMhE8vDnvoS/KL0GvsXmeHCLhBC9mgzmy92VWVWa9Isy0y?=
 =?us-ascii?Q?bmKvV21OtU9YSIh5OzPp1KcHjHkGbKtfvXIgc6o4H1ng5CgZ+aywKWuV5vpS?=
 =?us-ascii?Q?vqEBm7L24Vt3jA7JqJw=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jan 2026 15:57:46.5326 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 326bdacc-1876-47d5-c3dc-08de4e058038
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001CA.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PPF28614436A
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

- Cleanup, refactoring of panel replay code to prepare for non-eDP replay
- Switch to drm_dbg_macros instead of DRM_DEBUG variants
- Add pwait status to DMCUB debug logging
- Adjust PHY FSM transition to TX_EN-to-PLL_ON for TMDS on DCN35
- Always update divider settings for DP tunnel
- correct clip x assignment in cursor programming
- Bump the HDMI clock to 340MHz

Cc: Dan Wheeler <daniel.wheeler@amd.com> 

Aurabindo Pillai (2):
  drm/amd/display: switch to drm_dbg_kms() from DRM_DEBUG_KMS
  drm/amd/display: switch to drm_dbg_ macros instead of DRM_DEBUG_
    variants

Ausef Yousof (1):
  drm/amd/display: correct clip x assignment in cursor programming

Cruise Hung (1):
  drm/amd/display: Always update divider settings for DP tunnel

Derek Lai (1):
  drm/amd/display: revert "write default Vesa Aux backlight control in
    dmub"

Dmytro Laktyushkin (1):
  drm/amd/display: only power down dig on phy endpoints

Jack Chang (2):
  drm/amd/display: DPCD for Selective Update
  drm/amd/display: PR error HPD_IRQ handling

Joshua Aberback (1):
  drm/amd/display: Re-implement minimal transition deferral

Leo Chen (1):
  drm/amd/display: Add global fgcg function prototype to DCCG

Mario Limonciello (1):
  drm/amd/display: Bump the HDMI clock to 340MHz

Mario Limonciello (AMD) (1):
  drm/amd/display: Show link name in PSR status message

Nicholas Kazlauskas (2):
  drm/amd/display: Adjust PHY FSM transition to TX_EN-to-PLL_ON for TMDS
    on DCN35
  drm/amd/display: Add pwait status to DMCUB debug logging

Peichen Huang (3):
  drm/amd/display: move panel replay out from edp
  drm/amd/display: init code for external panel replay
  drm/amd/display: Add replay_events in replay settings

Ray Wu (1):
  drm/amd/display: disable replay when crc source is enabled

Robin Chen (1):
  drm/amd/display: Remove unused DMUB replay commands

Taimur Hassan (2):
  drm/amd/display: [FW Promotion] Release 0.1.42.0
  drm/amd/display: Promote DC to 3.2.365

 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |  58 +--
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h |   1 +
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_crc.c |  25 +-
 .../amd/display/amdgpu_dm/amdgpu_dm_replay.c  |   9 +-
 drivers/gpu/drm/amd/display/dc/core/dc.c      |  49 ++-
 .../drm/amd/display/dc/core/dc_link_exports.c |   9 +-
 drivers/gpu/drm/amd/display/dc/dc.h           |   2 +-
 drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c  |   1 +
 drivers/gpu/drm/amd/display/dc/dc_dp_types.h  |  34 +-
 .../gpu/drm/amd/display/dc/dc_hdmi_types.h    |   2 +-
 drivers/gpu/drm/amd/display/dc/dc_hw_types.h  |   6 +
 drivers/gpu/drm/amd/display/dc/dc_types.h     |   3 +-
 .../drm/amd/display/dc/dce/dmub_hw_lock_mgr.c |   2 +-
 .../gpu/drm/amd/display/dc/dce/dmub_replay.c  |  13 -
 .../amd/display/dc/hwss/dcn10/dcn10_hwseq.c   |   6 +-
 .../amd/display/dc/hwss/dcn35/dcn35_hwseq.c   |  52 +++
 .../amd/display/dc/hwss/dcn35/dcn35_hwseq.h   |   3 +
 .../amd/display/dc/hwss/dcn35/dcn35_init.c    |   2 +-
 .../amd/display/dc/hwss/dcn401/dcn401_hwseq.c |   2 +
 drivers/gpu/drm/amd/display/dc/inc/hw/dccg.h  |   1 +
 .../gpu/drm/amd/display/dc/inc/link_service.h |  12 +-
 drivers/gpu/drm/amd/display/dc/link/Makefile  |   2 +-
 .../display/dc/link/accessories/link_dp_cts.c |   7 +-
 .../drm/amd/display/dc/link/link_detection.c  |   6 +-
 .../gpu/drm/amd/display/dc/link/link_dpms.c   |   8 +-
 .../drm/amd/display/dc/link/link_factory.c    |  19 +-
 .../dc/link/protocols/link_dp_capability.c    |  49 ++-
 .../dc/link/protocols/link_dp_irq_handler.c   |  43 +++
 .../dc/link/protocols/link_dp_panel_replay.c  | 343 ++++++++++++++++++
 .../dc/link/protocols/link_dp_panel_replay.h  |  38 ++
 .../link/protocols/link_edp_panel_control.c   | 297 +--------------
 .../link/protocols/link_edp_panel_control.h   |  10 +-
 .../dc/resource/dcn31/dcn31_resource.c        |  11 +-
 .../gpu/drm/amd/display/dmub/inc/dmub_cmd.h   |  54 +--
 .../gpu/drm/amd/display/include/dpcd_defs.h   |  30 ++
 35 files changed, 763 insertions(+), 446 deletions(-)
 create mode 100644 drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_panel_replay.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_panel_replay.h

-- 
2.52.0

