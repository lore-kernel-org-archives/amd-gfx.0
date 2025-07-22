Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7EC4C83F1A
	for <amd-gfx@archiver.kernel.org>; Tue, 22 Jul 2025 22:39:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2487C10E325;
	Tue, 22 Jul 2025 22:39:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="2zDp044Q";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2083.outbound.protection.outlook.com [40.107.244.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D827210E325
 for <amd-gfx@lists.freedesktop.org>; Tue, 22 Jul 2025 22:39:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OC6rEh2TNiL5mr5iM2KBzPL0kayyS+JP56+Qar0yieyP84Eu2FCzxSlnvHedcXjsZdfOhPX+C7JrOfJPZ1fUDV2ZZ5y4CiWZETUV6BGYimF3T71skyvNimns+THaPvlOs7n3qecoJOC/Wgo8UrYmY9ZqdTvaLhfCiXKrE2wfQ0205/2d7ap8YygdIXlqJxx2w8JR+PRfuBdiUY64QK312Ud5FZtEmh+gu1sDgWUVjp9lXARc5nHxcuSu4fes3HrM4iBG5kHJhJKX/w/uSwddLZhiSRGfjFKNk+orWha2xov8NDEz69oegJWYi5u2WmgO8MrcW8stuVoYYh3Y5SyWmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uiiT3BId95/mLNS2l+ABQSykORd+XN3N2WpB4tn8X1g=;
 b=lkqr1p0Xsk+cq2hH7IIBMbV0zw/UCVD6sVZgYumJn4m7PGHrAA/5qRUj9r2g+IjoeoX3fvfxzr1BoMnVx0ugxkul+n992UzRnYjwGsiiw65wRCudezMAZPrEGcuKnwX6NbYryKIYErP1qavxsnj2WaZt4MMmvEPAEucoyp+T4XvMgd8lEXz3bjFGzlIkMF7eNg1I8pvkMmTIlUGbpeQIMpbZ/6pRmrHZ/BtCNGtamM6z0DUiCc89bsAXVXoSXeHLsoXJPunaEhwv5U9Vqrolkjl6Oy4gwmPlnNfHbaLQGLUuyAIVAQLJE2c4hXxIPP9Zpxdzx16E/zj3On8aqfFMbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uiiT3BId95/mLNS2l+ABQSykORd+XN3N2WpB4tn8X1g=;
 b=2zDp044Q8MPJR8pAe/9fcutYyh21b5OHXw/dBCJ/jWMCMH2uS4rD5RJzOwr8WZ36PO9U8Utn26Rx0LtQVlQ0lISLkZEnehe1NGJGGM9k6Pmveu+27L80Ma6RsCkfCMqp9VuoW6zV8vhl6e2SplYYNiznPP1pXxfjADeNViZxx5c=
Received: from MN2PR05CA0007.namprd05.prod.outlook.com (2603:10b6:208:c0::20)
 by SA3PR12MB7879.namprd12.prod.outlook.com (2603:10b6:806:306::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.21; Tue, 22 Jul
 2025 22:39:19 +0000
Received: from BL6PEPF0001AB53.namprd02.prod.outlook.com
 (2603:10b6:208:c0:cafe::1e) by MN2PR05CA0007.outlook.office365.com
 (2603:10b6:208:c0::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8964.21 via Frontend Transport; Tue,
 22 Jul 2025 22:39:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BL6PEPF0001AB53.mail.protection.outlook.com (10.167.241.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8964.20 via Frontend Transport; Tue, 22 Jul 2025 22:39:15 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 22 Jul
 2025 17:39:14 -0500
Received: from box-0.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Tue, 22 Jul 2025 17:39:14 -0500
From: <IVAN.LIPSKI@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Daniel Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Alex Hung <alex.hung@amd.com>, Ivan Lipski
 <ivan.lipski@amd.com>
Subject: [PATCH 00/25] DC Patches July 21, 2025
Date: Tue, 22 Jul 2025 18:36:06 -0400
Message-ID: <20250722223911.2655505-1-IVAN.LIPSKI@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: IVAN.LIPSKI@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB53:EE_|SA3PR12MB7879:EE_
X-MS-Office365-Filtering-Correlation-Id: ac92902a-ad8e-4e03-8d61-08ddc97096c5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?zBbzxbaZWCrLLhX1fw04c1/cavZscFLQjJFs39PweR2takxnU7jQvlyeRoek?=
 =?us-ascii?Q?yIGrnYBgWaa7C/22PJ71EUW7lO357ztgyKDItHcZ3SKLCBbY3zQqAbq6gDr7?=
 =?us-ascii?Q?OY2V8IJyIeGl/uXB+yN89Oxi64fM86Ej31+yVhHPDjS9lTRsfISI+/MJzr+k?=
 =?us-ascii?Q?U47htmnSDn4afvxJzs57wp1UZ/0OERj2IxKOcS+BhIyO53rKW2t+UW9WXht3?=
 =?us-ascii?Q?OxmzKsAY4r3oPXJtjV1gfbIbKupHwGKvxr6YmU3pFWONWg5mC88NNQiTDy8K?=
 =?us-ascii?Q?l4YsB+aP/tEye1kUTLCN0HPne7QX+bEqfskx6dM3HOA9ut9EpM22EH90YSye?=
 =?us-ascii?Q?TPeblnwI19BhZLVTPP7tagGB4lhRXuSjSxF865Ut3MT+xjyvmjp/20MWEQGR?=
 =?us-ascii?Q?6wa3dCjiqxOV2XFLOxiovYClVTJDOYKGsHsOF6tlWb9XIBWwLzDMgACaMtpN?=
 =?us-ascii?Q?tsFx7MYXdRgBc6YE/V0j/hibS0IPecjAM3FGMmi6TpQzU97IVpEjJcwL4mXQ?=
 =?us-ascii?Q?nUoo882DxHhsExmUX1BQAO6xNn+VtwzyPcZjZSy8xHPCOx5Nf3Knut5N/GYD?=
 =?us-ascii?Q?I69sw6qzUwDMP9liIRjqd01+5sQ5NKoqDxezb8PTg2F5FEwUGsqxKhU1tNrI?=
 =?us-ascii?Q?O462MjITK0YEMpTj/QUTC69JsZc7bFMzBz84ddBmyqf85uoA1Z12p9MuQF4h?=
 =?us-ascii?Q?B1glqkO+MeJt9qssXzqID+5bl4sM2TulQfDvsbGu+3iC2+K9arxqi3poetg1?=
 =?us-ascii?Q?quyIf94JclI4dFxbGq0cUuEUuBXOYMD95LJ0Bxw88nR4ptCSStxXHI7x565s?=
 =?us-ascii?Q?NFNz42HVuWfp0Av1Pf2a116hMUThbZLMWVVXBx/RktAWLIktWEjTei1NmCJ3?=
 =?us-ascii?Q?pE3915aQxS0d0GsKqGVpELI7gSkGSRKqZQ/HwqfQvfl7ImuwKhYdjJabDnQP?=
 =?us-ascii?Q?++cPwXwTsVpVP7gaz6rByWgE82wJKLZ1ZR9d0uzRhfXRaeVTk4I2O8S9ky9e?=
 =?us-ascii?Q?22ixcGPSoYoICeAZixNy1lBX0FT/Vw69qDODIiGjFi+0E8HeJwia8M0z7lMz?=
 =?us-ascii?Q?IKJq9Eiv8uEEws0r7nGc737+TRa15lw7EkOgHDYJIkBq/WGcdv6l+fvR1z6J?=
 =?us-ascii?Q?jf3V84p7FiJSo8DYI8EwhouqdOOQqgoeTxwQBFGbk8bCWAsArtuxMxk5CJJn?=
 =?us-ascii?Q?Dmvbkkzj6O454pZfVlTtqibJlBBse0hk2BX/VDrC9lYesXlL1vWSfd/g4NqJ?=
 =?us-ascii?Q?IrAkvj4rfUntHMdD78y4UAuAssQiRoE82K7uISeaawrUHOBFQfNQjbKbE40o?=
 =?us-ascii?Q?AOHFNCMRBvtVmUkso4dMDUCh/tEG9s7zyDo3d0nSngHtswsfPsUC87+jPG5e?=
 =?us-ascii?Q?SkGRVY0KvY7TEb8Ba5+N0L4A5ysBs8Et0hHZZkPSchNsIZAG66koXKdejNK3?=
 =?us-ascii?Q?Ruc++G9CS7TnZsGaIQI4JzY9Mmzr7vlJwlvPepJ1BXV31kw25HPHpt6Nwc1c?=
 =?us-ascii?Q?U5jSo5hQQird1adiSVV2FQyjWg46RHWmdwMd?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2025 22:39:15.9101 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ac92902a-ad8e-4e03-8d61-08ddc97096c5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB53.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7879
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

From: Ivan Lipski <ivan.lipski@amd.com>

This DC patchset brings improvements in multiple areas. In summary, we highlight:
 
* Fixes on DCN314 and DCN301
* Fixes on DMUB command alignment
* Addition of debugfs for Replay, and debug option for BW allocation mode
* Refactor of amdgpu_dm code

Cc: Daniel Wheeler <daniel.wheeler@amd.com>

Alvin Lee (1):
  drm/amd/display: Add comma to last entry of enum for consistency

Chiang, Richard (1):
  drm/amd/display: Remove update_planes_and_stream_v1 sequence

Cruise Hung (2):
  drm/amd/display: Remove check DPIA HPD status for BW Allocation
  drm/amd/display: Add debug option to control BW Allocation mode

Duncan Ma (1):
  drm/amd/display: Add eDP AUXless ALPM

Ivan Lipski (1):
  drm/amd/display: Allow DCN301 to clear update flags

Jingwen Zhu (1):
  drm/amd/display: Add a config flag for limited_pll_vco

Karthi Kandasamy (1):
  drm/amd/display: Add DC EDID read policy struct

Mario Limonciello (8):
  drm/amd/display: Add missing SPDX license identifier
  drm/amd/display: Drop unused include
  drm/amd/display: Remove unnecessary whitespace
  drm/amd/display: Remove unnecessary includes
  drm/amd/display: Avoid configuring PSR granularity if PSR-SU not
    supported
  drm/amd/display: Only finalize atomic_obj if it was initialized
  drm/amd/display: Rename dcn31 string shown to user
  drm/amd/display: Pass up errors for reset GPU that fails to init HW

Michael Strauss (3):
  drm/amd/display: Move setup_stream_attribute
  drm/amd/display: Increase AUX Intra-Hop Done Max Wait Duration
  drm/amd/display: Cache streams targeting link when performing LT
    automation

Ovidiu Bunea (2):
  drm/amd/display: Revert "Add a config flag for limited_pll_vco"
  drm/amd/display: Fix dmub_cmd header alignment

Ray Wu (1):
  drm/amd/display: Add Replay residency in debugfs

Relja Vojvodic (1):
  drm/amd/display: Allow for sharing of some link and audio link
    functions

Roman Li (1):
  drm/amd/display: Disable dsc_power_gate for dcn314 by default

Taimur Hassan (1):
  drm/amd/display: Promote DAL to 3.2.343

 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |  27 ++--
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h |   1 +
 .../amd/display/amdgpu_dm/amdgpu_dm_color.c   |   2 +-
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_crc.c |   1 +
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_crc.h |   1 +
 .../amd/display/amdgpu_dm/amdgpu_dm_debugfs.c |  35 ++++-
 .../amd/display/amdgpu_dm/amdgpu_dm_debugfs.h |   1 +
 .../amd/display/amdgpu_dm/amdgpu_dm_hdcp.c    |   1 +
 .../amd/display/amdgpu_dm/amdgpu_dm_hdcp.h    |   1 +
 .../amd/display/amdgpu_dm/amdgpu_dm_helpers.c |   1 +
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c |   1 +
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_irq.h |   1 +
 .../display/amdgpu_dm/amdgpu_dm_irq_params.h  |   1 +
 .../display/amdgpu_dm/amdgpu_dm_mst_types.c   |   1 +
 .../display/amdgpu_dm/amdgpu_dm_mst_types.h   |   1 +
 .../amd/display/amdgpu_dm/amdgpu_dm_pp_smu.c  |   1 +
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_psr.c |   8 +-
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_psr.h |   1 +
 .../amd/display/amdgpu_dm/amdgpu_dm_replay.c  |   1 +
 .../amd/display/amdgpu_dm/amdgpu_dm_replay.h  |   1 +
 .../display/amdgpu_dm/amdgpu_dm_services.c    |   1 +
 .../amd/display/amdgpu_dm/amdgpu_dm_trace.h   |   1 +
 drivers/gpu/drm/amd/display/dc/core/dc.c      | 132 +-----------------
 .../drm/amd/display/dc/core/dc_link_exports.c |   7 +
 drivers/gpu/drm/amd/display/dc/dc.h           |  16 ++-
 drivers/gpu/drm/amd/display/dc/dc_dp_types.h  |  16 ++-
 drivers/gpu/drm/amd/display/dc/dc_helper.c    |   2 +-
 drivers/gpu/drm/amd/display/dc/dc_types.h     |  14 ++
 .../gpu/drm/amd/display/dc/dce/dmub_replay.c  |  13 ++
 .../amd/display/dc/hwss/dce110/dce110_hwseq.c |   7 +-
 .../amd/display/dc/hwss/dce110/dce110_hwseq.h |   7 +
 .../amd/display/dc/hwss/dcn20/dcn20_hwseq.c   |   2 +
 .../amd/display/dc/hwss/dcn401/dcn401_hwseq.c |   2 +
 .../gpu/drm/amd/display/dc/inc/core_types.h   |   2 +-
 drivers/gpu/drm/amd/display/dc/inc/link.h     |   5 +-
 .../display/dc/link/accessories/link_dp_cts.c |  17 ++-
 .../gpu/drm/amd/display/dc/link/link_dpms.c   |   3 -
 .../drm/amd/display/dc/link/link_factory.c    |   2 +
 .../drm/amd/display/dc/link/link_validation.c |   6 +-
 .../dc/link/protocols/link_dp_capability.c    |  37 +++++
 .../dc/link/protocols/link_dp_capability.h    |   6 +
 .../dc/link/protocols/link_dp_dpia_bw.c       |  65 ++++-----
 .../dc/link/protocols/link_dp_training.c      |   9 +-
 .../link/protocols/link_edp_panel_control.c   |   8 +-
 .../dc/resource/dcn314/dcn314_resource.c      |   1 +
 .../dc/virtual/virtual_stream_encoder.c       |   7 +
 .../gpu/drm/amd/display/dmub/inc/dmub_cmd.h   |  20 +--
 47 files changed, 281 insertions(+), 215 deletions(-)

-- 
2.43.0

