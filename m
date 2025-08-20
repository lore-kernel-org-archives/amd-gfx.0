Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3DE6CA0EF8
	for <amd-gfx@archiver.kernel.org>; Wed, 20 Aug 2025 20:21:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A0EE810E7E3;
	Wed, 20 Aug 2025 20:21:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="2PZy5Z01";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2057.outbound.protection.outlook.com [40.107.94.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DD84610E7E3
 for <amd-gfx@lists.freedesktop.org>; Wed, 20 Aug 2025 20:21:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ta5bBGcHmqhEg6KdVN8CSJPWDvRt4pTXuSl4RQ8HmGHdRi/eIz3PBjlkCZVNzpgGKiMKfzBlBXB6stfMHb3Gd6rUrbxk99HMTgJXaODBZMLBeefxUPIQTvE5Xld9Do65wOWw6BURng5VGDtpwGfr2XIwLPJwwbPUDJ6sty5R7GpRVfMiQMSz+pmtXfYWjat5PhtAVzzdx0FK6DR767qAh8f/6rrSzE9KOeDAUjXn5UrwGbEy1QwNAR5UAmuCHEP9c78hGzBHr18uLhEsUgYwi/waacAAaE1SDXmwKye/5dVaD2YKqrsJ8U3nYZ6byMD+uS2N3RHwDygE8JrXv33MQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+hYnrftDMT7DDVJOsg3ACepGuV21DIkR4Uo466ApHHc=;
 b=LPs+lpo1sHJpHLTKrnnfy1e9SMhf0OFvvuU6UaqGImLkB+kvpk/zcHGPqQhJYW7C3eeLzz50wtq7STyY5Rq7mZkQaAgVjCUgwTXsnxfzSI3iJW6g8bkKxTOUm4bETLIugeSddHiZNBnoyOlWdcGmq1ysisS7cKDgjU6eLGz3zA9u0f0FTzlA+ZYkG2Ziycu5nUScFezF7On4Cn2czYFnfs6tiGwK68ZIPw2G9xuW0TiBICQ6jJwlro4F1TFsERRWXnOhjtNdl7KPLsVTgMg6ls8mEhMIcHzuBlqxspGTw5Feka9vSrGt6Eab8fANaNVcIZ77z1vFu9QaK0jPF8NthA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+hYnrftDMT7DDVJOsg3ACepGuV21DIkR4Uo466ApHHc=;
 b=2PZy5Z01lNvPGnmLassGUYSTrNPKvcZIjOr3N/9pOL15IWldj4mAwru95l1wHSwVRxN1gxTXTUSZ0IWKv/hgfoWt0CpefOqXaNsea4I/B1NKWXeyX5PmFDNmuO539kFvwinFUrCWsPEWoGXaJiW8BDehhZUOpEQsfBezqdObK+8=
Received: from DM6PR06CA0069.namprd06.prod.outlook.com (2603:10b6:5:54::46) by
 PH0PR12MB5648.namprd12.prod.outlook.com (2603:10b6:510:14b::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9052.14; Wed, 20 Aug 2025 20:21:09 +0000
Received: from CY4PEPF0000EE39.namprd03.prod.outlook.com
 (2603:10b6:5:54:cafe::bb) by DM6PR06CA0069.outlook.office365.com
 (2603:10b6:5:54::46) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9052.14 via Frontend Transport; Wed,
 20 Aug 2025 20:21:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CY4PEPF0000EE39.mail.protection.outlook.com (10.167.242.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9052.8 via Frontend Transport; Wed, 20 Aug 2025 20:21:08 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 20 Aug
 2025 15:21:04 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.1748.10; Wed, 20 Aug
 2025 13:21:04 -0700
Received: from aaurabin-tumbleweed.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Wed, 20 Aug 2025 15:21:03 -0500
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>
Subject: [PATCH 00/12] DC Patches for 25 Aug 2025
Date: Wed, 20 Aug 2025 16:19:50 -0400
Message-ID: <20250820202103.1122706-1-aurabindo.pillai@amd.com>
X-Mailer: git-send-email 2.50.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE39:EE_|PH0PR12MB5648:EE_
X-MS-Office365-Filtering-Correlation-Id: 77212ae7-6215-4627-8257-08dde027195d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?mASzapGWIgaljWkv8hluCE05hd8hCSxHiIZH3MQsWc83VuZ35SnCqrPJGVBw?=
 =?us-ascii?Q?PkWKbZTB4ac/Ez/0Szt7Ab2T3EAYAuvO5o8mg7I69r7D8keqBOCMO+VbKVNK?=
 =?us-ascii?Q?UaVO/ljHnL/VnN0XZ3gyS6JKAZbLqNCQ5meeAuHDp+P24YyasZA0EKRsHHbF?=
 =?us-ascii?Q?L299DcMKCE4MVd5caUgTgSHxv8q3DYrFje80OpsUgqPq2SYUnUPUFEEdqZV3?=
 =?us-ascii?Q?x6aWD0q+dfWUh+Pp39z0BWqT2zgT9L9VP0zx62v9esi3wpAUoo4VbYp6vLWH?=
 =?us-ascii?Q?SSZqHePUyaaSbb97Bmkprbavk5YtIBgg2DvnJhbM9zGW51vwMke5R2AvD3up?=
 =?us-ascii?Q?0diqBrqws4dDiyFFSq9rHiuxXDpfZd6XRu/+e5yEOqVGUd1MUWL5KgMJbpNf?=
 =?us-ascii?Q?Rn9VR0pinl2XTCg+v8WpAe3up0+qb0XKOp59crmMc0hwX8J84Gs2Eh2cQmRk?=
 =?us-ascii?Q?0AKNAn+If2MjcnUYAZF5pKfVEgapxMMaqH9+jjv215uoGjjLk97leeWjG3pA?=
 =?us-ascii?Q?Mf6emRroHWftKJsxIn43I0day00M6LhOlAZQ+4P+QXpV5638T+lKEV/1P+cM?=
 =?us-ascii?Q?k2uaKsGvgOKqXQkULGe9znnyuZrTTrmdLwLr1sNOCAHBFltk5OPQV5UnmFrR?=
 =?us-ascii?Q?+suh89gtqebcmHbAvsylOVYzgh459jjphwJWcKCkG9FUl36iSoS/bWvWeO2e?=
 =?us-ascii?Q?4jYFxqmi4j+MmdEQgVgUnVOX/fDFV2DvzUhoH208cG751T5XUsmekmluhAjn?=
 =?us-ascii?Q?WaAGAfvZA1gSs+K7wUAH7LaNHciVBP5ujRssO5T9/N6Gg6aguIJ/LEh74HRZ?=
 =?us-ascii?Q?A/Om/vq7r5Ma5JRwa5AFsV6yjpUJWfr4uvucmmmrWeQXSAqus7KGLWpcuQY2?=
 =?us-ascii?Q?A5St0L0AC1uLD6qTohsyrWrfPrwBdNvSA/zGHYkfMyGp8poYZ2Ep9b7doPuS?=
 =?us-ascii?Q?39kmz/o1F2ESWL37pFzgKPGq1I47D2eo0tQ8p7XMfijXM4o0QHFnZ8psVmuX?=
 =?us-ascii?Q?S+nyPUdMtl55eK/cwoCb/M3sx85iibx4YvpSa4C0XHp6BtYRxYyBxex7y5lA?=
 =?us-ascii?Q?xpMVb6ztlyl4MD6MJcTrnbkEMI3WyPCKp3D0Wh+OuCVgA/H+F1yX037E74Wk?=
 =?us-ascii?Q?1yqPuXuhdQf71hg9vlYkDJHmA7d2izEjloJ2VbSBu3gtW6clYXWswAwngJjG?=
 =?us-ascii?Q?FOjUvko7wzWcYinINSDfAHFfeRPHaGzJDbG2Ho+cMxW3aSUpaQYZVsmudFLx?=
 =?us-ascii?Q?D1cYQcS1gVLxl6v1yqHhinipRa4rhR0/tsX6AMJBav0TKSOlMQaCCLryFU0z?=
 =?us-ascii?Q?2ssrmyHBsXpM0mdnkrnqnq2EV6xf3urhdWXivILG0N5sWFr24sy6DhX12Qp3?=
 =?us-ascii?Q?f8YCbB5KALUm+UqD0O8uvZNO5pPYVIlwCOVlvOyoi+6KII206p6GJ2GtT3UO?=
 =?us-ascii?Q?cITJNWFjB4jWE2F9RnKzEQgbmiI5pvYbt2kC/EWncdud9N3Ht/dQe5LKfydq?=
 =?us-ascii?Q?UrFxPhxgUatubkpg0m9H9+gLnSMqah+wpr1J?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2025 20:21:08.9488 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 77212ae7-6215-4627-8257-08dde027195d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE39.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5648
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

     * Firmware releases for multiple asics
     * CodeQL fixes
     * Fix for double cursor with 180 degree rotation on large resolutions
     * Misc bug fixes for DSC, PSR/Replay, DPIA etc.

___

Ausef Yousof (1):
  drm/amd/display: track dpia support

Clay King (3):
  drm/amd/display: Multiplication result converted to larger type
  drm/amd/display: Incorrect 'not' operator usage
  drm/amd/display: Array offset used before range check

Cruise Hung (1):
  drm/amd/display: Reserve instance index notified by DMUB

Dillon Varone (1):
  drm/amd/display: Consider sink max slice width limitation for dsc

Ivan Lipski (1):
  drm/amd/display: Support HW cursor 180 rot for any number of pipe
    splits

Karthi Kandasamy (1):
  drm/amd/display: Add control flags to force PSR / replay

Nicholas Carbones (1):
  drm/amd/display: DC v3.2.347

Reza Amini (1):
  drm/amd/display: Decrease stack size in logging path

Taimur Hassan (1):
  drm/amd/display: [FW Promotion] Release 0.1.24.0

Yihan Zhu (1):
  drm/amd/display: wait for otg update pending latch before clock
    optimization

 .../gpu/drm/amd/display/dc/basics/dce_calcs.c |  2 +-
 .../drm/amd/display/dc/basics/fixpt31_32.c    |  2 +-
 .../gpu/drm/amd/display/dc/basics/vector.c    |  6 +-
 .../drm/amd/display/dc/core/dc_hw_sequencer.c |  2 +
 drivers/gpu/drm/amd/display/dc/core/dc_stat.c |  2 +-
 drivers/gpu/drm/amd/display/dc/dc.h           |  2 +-
 drivers/gpu/drm/amd/display/dc/dc_types.h     |  4 +
 .../gpu/drm/amd/display/dc/dce/dce_i2c_hw.c   |  2 +-
 .../gpu/drm/amd/display/dc/dce/dce_i2c_sw.c   |  2 +-
 drivers/gpu/drm/amd/display/dc/dce/dmub_psr.c |  2 +-
 .../dc/dml/dcn20/display_rq_dlg_calc_20.c     |  2 +-
 .../dc/dml/dcn20/display_rq_dlg_calc_20v2.c   |  2 +-
 .../dc/dml/dcn21/display_rq_dlg_calc_21.c     |  2 +-
 .../dc/dml/dcn30/display_rq_dlg_calc_30.c     |  2 +-
 .../amd/display/dc/dml/dcn302/dcn302_fpu.c    |  2 +-
 .../amd/display/dc/dml/dcn303/dcn303_fpu.c    |  2 +-
 .../dc/dml/dcn31/display_rq_dlg_calc_31.c     |  2 +-
 .../dc/dml/dcn314/display_rq_dlg_calc_314.c   |  2 +-
 .../drm/amd/display/dc/dml/dcn32/dcn32_fpu.c  |  4 +-
 .../amd/display/dc/dml/dcn321/dcn321_fpu.c    |  2 +-
 drivers/gpu/drm/amd/display/dc/dsc/dc_dsc.c   |  5 ++
 .../amd/display/dc/hwss/dcn10/dcn10_hwseq.c   | 77 +++++++------------
 .../gpu/drm/amd/display/dc/inc/core_types.h   |  1 +
 .../amd/display/dc/inc/hw/timing_generator.h  |  1 +
 .../link/protocols/link_edp_panel_control.c   |  4 +
 .../dc/mmhubbub/dcn20/dcn20_mmhubbub.c        |  2 +-
 .../amd/display/dc/optc/dcn32/dcn32_optc.h    |  1 +
 .../amd/display/dc/optc/dcn35/dcn35_optc.c    | 18 +++++
 .../dc/resource/dce112/dce112_resource.c      | 12 +--
 .../dc/resource/dce120/dce120_resource.c      |  6 +-
 .../dc/resource/dcn30/dcn30_resource.c        |  2 +-
 drivers/gpu/drm/amd/display/dmub/dmub_srv.h   |  3 +
 .../gpu/drm/amd/display/dmub/inc/dmub_cmd.h   |  4 +
 .../gpu/drm/amd/display/dmub/src/dmub_dcn35.c |  7 +-
 .../drm/amd/display/dmub/src/dmub_srv_stat.c  |  8 +-
 35 files changed, 112 insertions(+), 87 deletions(-)

-- 
2.50.1

