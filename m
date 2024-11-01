Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A70BE6B278
	for <amd-gfx@archiver.kernel.org>; Fri,  1 Nov 2024 13:50:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9F11B10E2E0;
	Fri,  1 Nov 2024 13:50:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="MyKVgIDo";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2062.outbound.protection.outlook.com [40.107.93.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D7A9110E2E0
 for <amd-gfx@lists.freedesktop.org>; Fri,  1 Nov 2024 13:50:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=frCoxNr5w+TjIOVnFUclGjVBsgUFu9SqR8BrawSilEA0jCJdj9jbgJVOrLGMUpT+njihhrFa34YaUv1pxiff+GdpzKd288Xl5b8KW0by80Msn7wlMBRrFVc9fxr9h98VjR8H8giAwsuFVxOmYqzLaWmONrXKOO+nPYT/G9tphmTNyaDLbMkpBQ7BCzR9TsPManyC/G2okZ2CtUlWilFSDbzxXkQSzjEuVF7MTaBrDeOsa7iCJLC5uzr2xJKoKBSuOpqAHLG3CFh9FNPKPFn3yWTUH9ZHHrtf42GIERC6VODNejhnfwS31FauyUSnm3QhRB3/c88GbrepMw2VOlhj5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qZuQLXlHE/Ax59nv2TblX2R+K95yjtYaOtZOcpNLkKI=;
 b=YRDOsGOCszCQ+dLuYOA/kKX504wXcYIpzy1WCDQ8l/zKNa+iugS2hggrVBj0btBbHaGINztNKVIpuTQ+PEpc91yY1FavKw40IvKhtATZLSpkPAosBzu4kDmqO+BVVzahHlnX6eKHQJbLcm7emV5rm1TpxnP6PnquLJ3CxPtu4X06rWBI0mV47Mfp81ndYlzhWYpXsfDUlXB+1obx/gK98UDvK1PhvbxtLVWOkWT1dWCIbMzVMr4KHXemf4M3ir9IuVuE2JU8SnfX+sxCwBF9rtgC5YEYxOtopkhKHn6IO3x32NiiaPH5ZvL4n3Iz8j9JtUAkHE7jHgoICWntvc8PaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qZuQLXlHE/Ax59nv2TblX2R+K95yjtYaOtZOcpNLkKI=;
 b=MyKVgIDoFjlgmqjsC0wQAJBNKjOX/m9SMlgvKKUQqeuqsLfBRfkCUq2sfzcBSsKURCFOJh7fynqmEUvwt9uzVV2H45KjGmo4OeP7QAZlIulkzCRNxmKkWbV304UubQMWhcGfX4po1f5rUvNDQs31PFCGqPza0pC+auJgOgpYjXQ=
Received: from BN9PR03CA0658.namprd03.prod.outlook.com (2603:10b6:408:13b::33)
 by SJ2PR12MB8941.namprd12.prod.outlook.com (2603:10b6:a03:542::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.20; Fri, 1 Nov
 2024 13:50:04 +0000
Received: from BN1PEPF00004687.namprd05.prod.outlook.com
 (2603:10b6:408:13b:cafe::69) by BN9PR03CA0658.outlook.office365.com
 (2603:10b6:408:13b::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.23 via Frontend
 Transport; Fri, 1 Nov 2024 13:50:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN1PEPF00004687.mail.protection.outlook.com (10.167.243.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8114.16 via Frontend Transport; Fri, 1 Nov 2024 13:50:03 +0000
Received: from mkmmarleung05.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 1 Nov
 2024 08:50:01 -0500
From: Zaeem Mohamed <zaeem.mohamed@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <rodrigo.siqueira@amd.com>, Hamza Mahfooz
 <hamza.mahfooz@amd.com>, Aurabindo Pillai <aurabindo.pillai@amd.com>, "Roman
 Li" <roman.li@amd.com>, Wayne Lin <wayne.lin@amd.com>, Tom Chung
 <chiahsuan.chung@amd.com>, Fangzhi Zuo <jerry.zuo@amd.com>, Zaeem Mohamed
 <zaeem.mohamed@amd.com>, Solomon Chiu <solomon.chiu@amd.com>, Daniel Wheeler
 <daniel.wheeler@amd.com>
Subject: [PATCH 00/17] DC Patches October 28, 2024
Date: Fri, 1 Nov 2024 09:49:23 -0400
Message-ID: <20241101134940.1426653-1-zaeem.mohamed@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00004687:EE_|SJ2PR12MB8941:EE_
X-MS-Office365-Filtering-Correlation-Id: 5426366b-f83d-426e-546d-08dcfa7c1661
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Lkyv2iD9C5eoPdWeKhcp7LJEQoXmJAx8ysri5JSCkMjt5IPUlXVTk5GUvmKU?=
 =?us-ascii?Q?bJ4UaCgTahtj5zvGHhxIaetNC2JQkP6CAPrp8jaU2uo7khdjU/0qSNfjTpPg?=
 =?us-ascii?Q?xWIusRS8tkdsWKTPAatWTx/QNYc+X5lQJcQCtA6PkC2qI/F3lsj9lqNcJEs2?=
 =?us-ascii?Q?t/80/M/LSsyCK+aoIZHmkvUPswscZDg//qCHQeMd+AX2L6CQDwd98OrbJBFE?=
 =?us-ascii?Q?CskugNX+hmCIBhhD0vmO/rgt87SmkM59hIOVWpvfIBXWSyEMJ6wS06LEo2yR?=
 =?us-ascii?Q?GDkVSpJ/8hGUEyOm+mRrm1aOKWDq1n5Sv+HzIDUigqDVFbTttRaWtxPW6QZ/?=
 =?us-ascii?Q?XbbM6sVWYRbjS7MKVzD9KOjXhHXK/9Hog5rRnL8aUq3Yx7hW1UrxdGxHalpG?=
 =?us-ascii?Q?6pIUi4zbXaxN9PpVoOlDA/R9zWmVD9QGGJmiGxnxqKUgCzJNd1MMb4WG1u9a?=
 =?us-ascii?Q?Vg3cdv9lkUH+5sOhVGMTOXlDLvqkbSCk4t5bN7cXYwhTYXRehMVjNm2zW3qI?=
 =?us-ascii?Q?9pCdbaORYlX2ug/cet6b9RcIwhVtHGbdbdzgdQ0MyH9OynxwajO3iW8o6G71?=
 =?us-ascii?Q?ZdABYBkvpJfY2DhDysyj/xg+olaFiPpISTuGfFJfltI29WSVfkOMMoBUpzIc?=
 =?us-ascii?Q?gXfB5rdXZWeDBewemVgjrwz6tbflr+b0TCpfumCcOBjxLfSVDybjN8q+HA3q?=
 =?us-ascii?Q?TJdCHkRnHhXTejTDSQrxfwBeUtK0Vmqcdall9+sta/ByxqdD9s7eeRTqWH2S?=
 =?us-ascii?Q?wXX4NsiD3USeYpBRpHl09sbDdKk66DjZuXj/0fNiKNGCrRajDBDHFnZrIThJ?=
 =?us-ascii?Q?XCzdu0VRkrbIYeZ8/ZRkeSePKZT5eGa3JwgIbb/fHqwhs/4rmFLU5ORBKCYB?=
 =?us-ascii?Q?IS9ZBCpBO8UFR6qwR60dd4qwY/MJKn2hULStJEjr50Gr8FTd3fS/DRpm8Nvl?=
 =?us-ascii?Q?xNXzRy2xvevS/IHPbizH4bBosCKYD1VstswXHElg+izX4TAEh0IfQG0lDFwJ?=
 =?us-ascii?Q?4zkykucTtnjY4yM9X13SdIm6Z3S/uyqW3Uv44HeIUDMUvxkdVSJrJqx8BvdM?=
 =?us-ascii?Q?/+J0yf4Cfm5mgGDRXeztcdW898LSAjnpYQG8vM45GPahX1dS4c16C76tN5kk?=
 =?us-ascii?Q?blKIoXSa1OaF72eF7B2p/e2WG+PFft6dbueXqzHuqmaYTkIPQIC5fbephYGz?=
 =?us-ascii?Q?VrtBI7DZGDvVNW69taqtQ33/2KXrd+M/dbiEqV3F7SN+wtK+fDhoL+RANc5C?=
 =?us-ascii?Q?xBAQnKU9ridMUD1BiGRjM0yqXYfGO7yRyV4UIHai+Bo+uYTWzZMUzTPSQs0W?=
 =?us-ascii?Q?FKOp+VFmtXElQplqwcFrF74gc6itKt+seZb9xePySl4i0JGmbLspxQoG233d?=
 =?us-ascii?Q?ZXxlLfR+GDVH8u8HW4B/j+Mun60ggTJpWeDgH2pHITyNnlKt3A=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Nov 2024 13:50:03.7508 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5426366b-f83d-426e-546d-08dcfa7c1661
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00004687.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8941
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
 
- Prune Invalid Modes for HDMI Output
- SPL Cleanup
- Fix brightness level not retained over reboot
- Remove inaccessible registers from DMU diagnostics
 
Cc: Daniel Wheeler <daniel.wheeler@amd.com>

Aric Cyr (1):
  drm/amd/display: 3.2.308

Aurabindo Pillai (1):
  drm/amd/display: parse umc_info or vram_info based on ASIC

Ausef Yousof (3):
  Revert "drm/amd/display: Block UHBR Based On USB-C PD Cable ID"
  drm/amd/display: Remove hw w/a toggle if on DP2/HPO
  drm/amd/display: Remove otg w/a toggling on HPO interfaces

Austin Zheng (1):
  drm/amd/display: Do Not Fallback To SW Cursor If HW Cursor Required

Charlene Liu (1):
  drm/amd/display: avoid divided by zero

Dominik Kaszewski (1):
  drm/amd/display: fix rxstatus_msg_sz type narrowing

Fangzhi Zuo (1):
  drm/amd/display: Prune Invalid Modes For HDMI Output

Ilya Bakoulin (1):
  drm/amd/display: Minimize wait for pending updates

Kaitlyn Tse (1):
  drm/amd/display: Implement new backlight_level_params structure

Nicholas Kazlauskas (1):
  drm/amd/display: Remove inaccessible registers from DMU diagnostics

Samson Tam (2):
  drm/amd/display: fix asserts in SPL during bootup
  drm/amd/display: SPL cleanup

Taimur Hassan (1):
  drm/amd/display: [FW Promotion] Release 0.0.241.0

Tom Chung (1):
  drm/amd/display: Fix brightness level not retained over reboot

Wayne Lin (1):
  drm/amd/display: Don't write DP_MSTM_CTRL after LT

 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 57 ++++++++----
 .../drm/amd/display/dc/bios/bios_parser2.c    |  4 +-
 .../display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c  | 19 +++-
 drivers/gpu/drm/amd/display/dc/core/dc.c      |  5 +-
 .../gpu/drm/amd/display/dc/core/dc_debug.c    | 40 +++++++++
 .../drm/amd/display/dc/core/dc_link_exports.c |  5 +-
 .../gpu/drm/amd/display/dc/core/dc_stream.c   | 10 ++-
 drivers/gpu/drm/amd/display/dc/dc.h           |  6 +-
 .../gpu/drm/amd/display/dc/dc_spl_translate.c | 14 +--
 drivers/gpu/drm/amd/display/dc/dc_types.h     | 27 ++++++
 .../amd/display/dc/hwss/dce110/dce110_hwseq.c |  6 +-
 .../amd/display/dc/hwss/dcn21/dcn21_hwseq.c   | 16 ++--
 .../amd/display/dc/hwss/dcn21/dcn21_hwseq.h   |  2 +
 .../amd/display/dc/hwss/dcn31/dcn31_hwseq.c   | 49 +++++++++++
 .../amd/display/dc/hwss/dcn31/dcn31_hwseq.h   |  3 +-
 .../amd/display/dc/hwss/dcn31/dcn31_init.c    |  2 +-
 .../amd/display/dc/hwss/dcn314/dcn314_init.c  |  2 +-
 .../amd/display/dc/hwss/dcn32/dcn32_init.c    |  2 +-
 .../amd/display/dc/hwss/dcn35/dcn35_hwseq.c   |  1 +
 .../amd/display/dc/hwss/dcn35/dcn35_init.c    |  2 +-
 .../amd/display/dc/hwss/dcn351/dcn351_init.c  |  2 +-
 .../amd/display/dc/hwss/dcn401/dcn401_init.c  |  2 +-
 .../drm/amd/display/dc/hwss/hw_sequencer.h    |  5 --
 .../gpu/drm/amd/display/dc/inc/core_status.h  |  2 +
 drivers/gpu/drm/amd/display/dc/inc/link.h     |  3 +-
 .../dc/link/protocols/link_dp_capability.c    | 22 ++---
 .../link/protocols/link_edp_panel_control.c   | 17 ++--
 .../link/protocols/link_edp_panel_control.h   |  3 +-
 drivers/gpu/drm/amd/display/dc/spl/dc_spl.c   | 88 +++++++++++--------
 .../gpu/drm/amd/display/dc/spl/dc_spl_types.h |  4 +-
 .../drm/amd/display/dc/spl/spl_fixpt31_32.c   | 34 +++----
 .../gpu/drm/amd/display/dmub/inc/dmub_cmd.h   |  7 +-
 .../gpu/drm/amd/display/dmub/src/dmub_dcn35.c |  5 +-
 .../amd/display/modules/freesync/freesync.c   |  3 +
 .../display/modules/hdcp/hdcp2_execution.c    | 31 +++----
 35 files changed, 326 insertions(+), 174 deletions(-)

-- 
2.34.1

