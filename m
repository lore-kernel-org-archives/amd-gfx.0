Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D677EC7115A
	for <amd-gfx@archiver.kernel.org>; Wed, 18 Jun 2025 15:54:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7A8BA10E8C3;
	Wed, 18 Jun 2025 15:54:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="znEY+q2i";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2052.outbound.protection.outlook.com [40.107.94.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1EE2D10E069
 for <amd-gfx@lists.freedesktop.org>; Wed, 18 Jun 2025 15:54:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wMjlMT2yFtA6byBQmcx5gPpz8bcBHHS1zy0TVkNxRFw4JDWVBAiip/xW6USICcHjz7N06id08MFF3XHx6suuTJbPw6X5DUfBRlsf600A7tAvV3GpK02Rjp+v6r8N15EMxb/oj1DCoh4TtvP3BKo/TaOduQeixfxfy3MEwm2Th5xEOWlWKK1l5F1N83yn5+qAzEPXT5TDOLxzYFSFxDfxV7NOyGERfCFu6ojCXueKKvzptIahQAYzqhMC15EqYbkZefHokpyobrak2GjESSwfRhUAlHdMC9dIpmYhI+dpZBVMB8U8OSWRB8s51rc1C7wGFRT/Nv78RxPRJjzCP1G0aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9XAltVWbwz8Ugck7X52HyH37t9Gv2klDhv3ZUUqMZtg=;
 b=TcAA+AyPIIVgLBtxbgiKuuX9onMYbdttr1pD4rfpcEm3s92uL6x8De5rn3IawmWdL6sNRjmRtE9IKxRA+aN37kIGMxCOOtAq9P2F00yA0Uzt6oejU7iKogwOVm+MHsHeK8Zn61rOK4DnzV3Arg75RMOwh+G3vP1OG8o77EnEoTHyu8Xf0nkHzEavOnLQVrIOVY8kaAQeID/bvPPS/AnwLfJmn09ZUuhJyev9Sn3jcYl7cP1Qc8x2cjxjz3PQmgCJkg/VLdd28VlH66AVsKW1XVtEtQH9yfgbQRQLkPXGA/rvlCrdJ4NjijwgA344f4PhLT+f7Q+7zAPJ0Yc9fkU/5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9XAltVWbwz8Ugck7X52HyH37t9Gv2klDhv3ZUUqMZtg=;
 b=znEY+q2iw0EaCEignvryA55rj3MRgZekvthBQ/TLYZhMIydZdV5CjOQCwXeO0FhHu3V+bYdGg0cZT+xjsEa3N5Ggewg1qT+hP0xQzI8GDlBoaa7K+KcQgGiSF3DpjRGYQClg9bVAqmQ+k29DG/tMcrBYyK8hLA81b/86aHrbS34=
Received: from CH2PR07CA0009.namprd07.prod.outlook.com (2603:10b6:610:20::22)
 by DS0PR12MB7948.namprd12.prod.outlook.com (2603:10b6:8:152::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.27; Wed, 18 Jun
 2025 15:54:49 +0000
Received: from CH1PEPF0000AD75.namprd04.prod.outlook.com
 (2603:10b6:610:20:cafe::33) by CH2PR07CA0009.outlook.office365.com
 (2603:10b6:610:20::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8835.30 via Frontend Transport; Wed,
 18 Jun 2025 15:54:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CH1PEPF0000AD75.mail.protection.outlook.com (10.167.244.54) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8857.21 via Frontend Transport; Wed, 18 Jun 2025 15:54:48 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 18 Jun
 2025 10:54:48 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 18 Jun
 2025 10:54:47 -0500
Received: from jzuo-linux.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Wed, 18 Jun 2025 10:54:42 -0500
From: Fangzhi Zuo <Jerry.Zuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Daniel Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Alex Hung <alex.hung@amd.com>, Fangzhi Zuo
 <Jerry.Zuo@amd.com>
Subject: [PATCH 00/13] DC Patches June 16, 2025
Date: Wed, 18 Jun 2025 11:33:48 -0400
Message-ID: <20250618153936.6472-1-Jerry.Zuo@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: Jerry.Zuo@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD75:EE_|DS0PR12MB7948:EE_
X-MS-Office365-Filtering-Correlation-Id: c50db667-ec92-492a-393c-08ddae807444
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?qHfylYFTnkV2g6gsaqpDZdCJ6vYG9sE6MC36NNr4mFd8p1TMO7yLfDxZeF64?=
 =?us-ascii?Q?VPe3cHxo8BMQnd0Zbo76hg1nUtnK56AiC9DJ+SuR69SCalGQAubRTuyKglr4?=
 =?us-ascii?Q?2lonwcwNC4Ybp80GTQaX+e7T6SFlVKusw7DTcOHsvk9yJ2Q+KWHmOxnRs9z0?=
 =?us-ascii?Q?naJtUhVOw1xp5v9/SpzfeNlH2vXD40emOrZ58iDuWOjGF4hiz+ljouENpFRI?=
 =?us-ascii?Q?/kpyGrggDITcwpFaePw1Jo7waXdIaB08bR3aFfVnHC1LlQVsqX9pYqjvD3pO?=
 =?us-ascii?Q?aM3LhaU1zGdpQMkieXvJzgVeImfYDxH30aJ2l10cdwBiApCu7gi9aThfVclY?=
 =?us-ascii?Q?4VzzF08tNdd2zYy+32xgEO+tB6Jedx+3aHOuiibpRo+hTKYPYrwGfu9TpjLa?=
 =?us-ascii?Q?j7ryuOIkiz3VbdZslLodLnLQHIRon7jVnlpJPgCKVVnc/66asxgi8zs2qjLx?=
 =?us-ascii?Q?/9jxk5106q/M1t1Wo3Hfru8gIlD6q6exEegqbgX/rxCdiY2JJ8PJTrNqpX7G?=
 =?us-ascii?Q?WgUr9TvuxwH4cy7UuW9CCpZAzKk92/i0NijUFCz4dy7mAkUoUQUhpA/b6IXy?=
 =?us-ascii?Q?Gbd80hUbIKLRCjSpQDPFeG3jNUD18Ga+VoVJpAvO3zCzYnDUyHJcEhyV64/w?=
 =?us-ascii?Q?d6Ujj3725ecap3bgWmK0Gwpr0tLyqGpSWg1pszlVcTs/hIA/Hl9dVJGj8mYp?=
 =?us-ascii?Q?HwtHAr0SMP5R+IeGstVSte9kawaY2UVlcsbwRuZ9EGPfLv7ntwsiASz3ovaX?=
 =?us-ascii?Q?QJ4jT5zwkr29Q/Llw7PXE+KmewqscJOdGl6nKlVFNl9jLt+A7oP6TqZG4t8q?=
 =?us-ascii?Q?meWD3u0v3IYXoDDIntavNIyQYg1bEW2cPMnnZkg2SLrxLuFPfP/Jf/TO5all?=
 =?us-ascii?Q?cpG7pv0KKf1K1Ya75IcVvg1UwljkA8hy3Gt2iGobKg0bWecZLH9iSQFWUr6A?=
 =?us-ascii?Q?mZIVtIwCD9YvvNKOB03emPSRf9Tq/Gb0joUzruwsFFglIh/9faWC2NYCUbjw?=
 =?us-ascii?Q?WXkCNL3BCkBjCxD2GOMITH2wYPqoIKyNXg4glCxniCj7Q28wJwlbMqdkNll9?=
 =?us-ascii?Q?xdDSZzUeg15DVZf25m26DPzWHG9xdx3OvunCCFo5h12OxS0wgZIJgF6wHSDw?=
 =?us-ascii?Q?Xamzsdpd+jd4HXqrs9ITNUWsD5jZRGwX+E2o9ktQce6kVlnRFK8RiI0bBr8v?=
 =?us-ascii?Q?OSvdZwmjsjK1FhnZwoytJFOM3EcGjdR0ZX2+nWOqTya6owB0kPjUF8w/IHS3?=
 =?us-ascii?Q?sSM9bebweUupldVqXHUqBZwLZqMe/APQyo2A8koi4pO4LsR24NcjQTGG5zjE?=
 =?us-ascii?Q?6IenN80sg6Q94BC2WoydAn8iNZNMnNoEieU0H2ToemNMPp/NN95O5qjWE5Su?=
 =?us-ascii?Q?HzgNe7MIs/jel81KjPC5LSAhK9opIs6rqf9WW8IJxwHL121DR8/d497XR5S4?=
 =?us-ascii?Q?xicD6sMyrKo5yMDxuAYQSxy8XVFAamY6dUQxOXsLjUQaH+fP7FqmHwdw+YcY?=
 =?us-ascii?Q?kExfMh6shhETLb8Ylgaxf9/KUxZOCNQiATLR?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2025 15:54:48.5590 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c50db667-ec92-492a-393c-08ddae807444
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000AD75.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7948
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

This DC patchset brings improvements in multiple areas.
In summary, we highlight:
    
* Improve USB4 bandwidth validation
* dml clock calcuation with EQU Prefetch included
* Tweaking udelay time to fix "failed to blank crtc!" error
* Add LSDMA support to DMUB
* Fix Coverity issue

Cc: Daniel Wheeler <daniel.wheeler@amd.com>

Alex Hung (1):
  drm/amd/display: Initialize mode_select to 0

Alvin Lee (1):
  drm/amd/display: Removed unnecessary comment

Austin Zheng (2):
  drm/amd/display: Include EQU Prefetch Bandwidth For Bandwidth
    Calculations
  drm/amd/display: DML21 Reintegration

Cruise Hung (1):
  drm/amd/display: Add new DP tunnel bandwidth validation

Fangzhi Zuo (1):
  drm/amd/display: Rewording Mode Validation Result

Ilya Bakoulin (1):
  drm/amd/display: Add num_slices_h to set_dto_dscclk signature

Ostrowski, Rafal (1):
  drm/amd/display: LSDMA support

Ovidiu Bunea (1):
  drm/amd/display: Add DMUB IPS command support for IPS residency tools

Taimur Hassan (2):
  drm/amd/display: [FW Promotion] Release 0.1.16.0
  drm/amd/display: Promote DAL to 3.2.339

Wen Chen (1):
  drm/amd/display: Fix 'failed to blank crtc!'

Weiguang Li (1):
  drm/amd/display: Remove redundant macro of refresh rate

 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |   2 +-
 .../gpu/drm/amd/display/dc/core/dc_debug.c    |   2 +
 .../drm/amd/display/dc/core/dc_link_exports.c |   6 +
 drivers/gpu/drm/amd/display/dc/dc.h           |  16 +-
 drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c  | 297 ++++++++++++++----
 drivers/gpu/drm/amd/display/dc/dc_dmub_srv.h  |  77 ++++-
 drivers/gpu/drm/amd/display/dc/dc_dp_types.h  |  15 +
 drivers/gpu/drm/amd/display/dc/dc_types.h     |   7 +
 .../amd/display/dc/dccg/dcn401/dcn401_dccg.c  |   2 +-
 .../amd/display/dc/dccg/dcn401/dcn401_dccg.h  |   3 +-
 .../dc/dml2/dml21/dml21_translation_helper.c  |   1 -
 .../dml2/dml21/inc/dml_top_dchub_registers.h  |   1 +
 .../dml21/inc/dml_top_display_cfg_types.h     |   2 +
 .../dml21/inc/dml_top_soc_parameter_types.h   |   1 +
 .../display/dc/dml2/dml21/inc/dml_top_types.h |   4 +-
 .../src/dml2_core/dml2_core_dcn4_calcs.c      |  46 +--
 .../src/dml2_core/dml2_core_shared_types.h    |  99 +++++-
 .../dc/dml2/dml21/src/inc/dml2_debug.h        | 149 ++++++++-
 .../amd/display/dc/hwss/dcn20/dcn20_hwseq.c   |   2 +-
 .../amd/display/dc/hwss/dcn32/dcn32_hwseq.c   |   6 +-
 .../gpu/drm/amd/display/dc/inc/core_status.h  |   1 +
 drivers/gpu/drm/amd/display/dc/inc/hw/dccg.h  |   2 +-
 drivers/gpu/drm/amd/display/dc/inc/link.h     |   3 +
 .../gpu/drm/amd/display/dc/link/link_dpms.c   |  10 +-
 .../drm/amd/display/dc/link/link_factory.c    |   1 +
 .../drm/amd/display/dc/link/link_validation.c |  85 ++++-
 .../drm/amd/display/dc/link/link_validation.h |   3 +
 .../display/dc/link/protocols/link_dp_dpia.c  |  15 +-
 .../dc/link/protocols/link_dp_dpia_bw.c       | 169 +++++++---
 .../dc/link/protocols/link_dp_dpia_bw.h       |  27 +-
 .../amd/display/dc/mpc/dcn401/dcn401_mpc.c    |   2 +-
 drivers/gpu/drm/amd/display/dmub/dmub_srv.h   |  10 +-
 .../gpu/drm/amd/display/dmub/inc/dmub_cmd.h   | 101 +++++-
 .../gpu/drm/amd/display/dmub/src/dmub_srv.c   |   4 +
 .../amd/display/modules/freesync/freesync.c   |   2 +-
 35 files changed, 970 insertions(+), 203 deletions(-)

-- 
2.43.0

