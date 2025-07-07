Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61DDAC8303C
	for <amd-gfx@archiver.kernel.org>; Mon,  7 Jul 2025 19:44:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F39D810E552;
	Mon,  7 Jul 2025 19:44:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ejbQDxOH";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2040.outbound.protection.outlook.com [40.107.94.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 36DA310E33C
 for <amd-gfx@lists.freedesktop.org>; Mon,  7 Jul 2025 19:44:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uyRnTURohyIz/uWco9AmFWoruOLQrjbLlKj7ppBA7sCE5HIx+o+BZM74XwR7VJBYVPe+ZZBnjVEgw/Rsijc1rCbvnMEk25c/O4jEH+Ut4FypIV3vidiPiegPeujdv/U+HZQt8UWpO/zjIL8nqalMcOcsgbfT2v92KqFjYhuSWyETSdAhVhaJ5fWche9rJSdt3PU6pLRC37H4v4U9ADWOCvrGV8R968EkyjR7q7itOah30G08xehtrz5PTwvJOzvpTSEwoCltnkPnyPw2CFV8ABpn3UYni3pfy4IKNaD9znGHy5Vv2XBA7DSod+ZKF7vooahtD2FEi9htplcTo99tCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=59oGkjXDOv/fr97nTBfogGiryBCfuSjoEaAkFJksgcQ=;
 b=dEK0DACocZVQHoGiwrLj35X/xPbDUM5fvTgefpL4AiLAr4/q9tzUPm9m4neKKPU+B91P2zn0yNgmACScVS+bbUuYgDxe5mmTrU8IY4cMNFARR0QqgZpOtXKvsSfBuoezrTbip1/UJOV9mrGZ9/QFpeABB6NTRRLcUW7HIO615D8HQGtQ7kvS9ipbGi8vUsCLaL9zr38xwDXDENuKALb7hir9vAXbHPjDSJ6YNO4swwZQ1FQG6QdTqlga9gkwMXRqvhDUbDlo09fscC2cAR/xAOgxfBj4hjQ0w7W6/8/Od4avYOPPGjhQg8wWygzNOGEI/QqFtscGhQobLYIp8c6D8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=59oGkjXDOv/fr97nTBfogGiryBCfuSjoEaAkFJksgcQ=;
 b=ejbQDxOHUby82xseNnzF3C6xF+lAE5GUcaErYIURY5toazED4fNgijss33P9qyMYQtf8x6pLUjwx4k7MD6h0+c73HhV1jNtdiv5keP+JTawQC6mH+xtn1RGBN9XLS7ZBQRt8zUAkMTWOG/Vo9YY+F0fjDmWRRwJNynhlPFLP+zI=
Received: from DS7P222CA0016.NAMP222.PROD.OUTLOOK.COM (2603:10b6:8:2e::8) by
 IA1PR12MB6043.namprd12.prod.outlook.com (2603:10b6:208:3d5::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.25; Mon, 7 Jul
 2025 19:44:37 +0000
Received: from CY4PEPF0000EDD4.namprd03.prod.outlook.com
 (2603:10b6:8:2e:cafe::47) by DS7P222CA0016.outlook.office365.com
 (2603:10b6:8:2e::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8901.26 via Frontend Transport; Mon,
 7 Jul 2025 19:44:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CY4PEPF0000EDD4.mail.protection.outlook.com (10.167.241.200) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8901.15 via Frontend Transport; Mon, 7 Jul 2025 19:44:36 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 7 Jul
 2025 14:44:35 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 7 Jul
 2025 14:44:35 -0500
Received: from box-0.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Mon, 7 Jul 2025 14:44:34 -0500
From: <IVAN.LIPSKI@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Daniel Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Alex Hung <alex.hung@amd.com>, Ivan Lipski
 <ivan.lipski@amd.com>
Subject: [PATCH 00/17] DC Patches July 7, 2025
Date: Mon, 7 Jul 2025 15:41:20 -0400
Message-ID: <20250707194358.1185190-1-IVAN.LIPSKI@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: IVAN.LIPSKI@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD4:EE_|IA1PR12MB6043:EE_
X-MS-Office365-Filtering-Correlation-Id: 924fe219-acba-443a-1b98-08ddbd8eb47f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?GaIApXvI+DfXGymRuYmZLKMcje8rCi3rpK96AS7dnBSEHFClFTdrSbgjW1Kj?=
 =?us-ascii?Q?besVeOCA0n27+Df94nXbdPQS0KTQJSAPjuyQSmT0C5H9mF1gGtqQzgUJFBIN?=
 =?us-ascii?Q?k6ielytQUHzndMMlBiyI+Cg9Pf80AxCHr/z5LHANSwBe7nxxpQnOnAoPeNo3?=
 =?us-ascii?Q?UON3z0bFxyjwZWMoAZBmqAfSk9IP0MbnojNk+ltfleEXKb9b/bO5GfNKnF+T?=
 =?us-ascii?Q?PqVe+LMk85kC7A2Ix9KLEnoDBUVzmfZIeih4xZfZB7ZlS3qQv0Gkx9dYmoO5?=
 =?us-ascii?Q?iayD1zl6t4YcbJkC+lkL305B9BxIhBjcTLcWliLQCArqrkpqSnREznuB93o6?=
 =?us-ascii?Q?cQoNkcJhgrIEPyBYNf168SOVwUnn6cslbKroH/dItR41fdmkUOazAVGcVYze?=
 =?us-ascii?Q?QLugR4q6ecLwYlY5ybejd5v6wJ6xJ/1s0DRvsHRuVr7aXTlVomENeu0qnOxp?=
 =?us-ascii?Q?QHTQAm1JA7dG8seEcR7d1FPV1AOEjBIj+9fwHM+yVbWelc0+tbtoWAXtJ8Km?=
 =?us-ascii?Q?TBQ9bdgaBpx+SU91Dga/L4WXPp/2Pz6ryed8XaxaKyvUZwEcsR+d7/6qAQtP?=
 =?us-ascii?Q?B8274KcD4mUNXOVu6WAEu2ugxsf3XPPf9gOKmrJLWMjQYVyKS61gamHkgVd+?=
 =?us-ascii?Q?r9N/v3XYLaRKTiNe+g6XLkgpj4RfXLGtq3AsXRN0pnCNPt4QFflUXiZSxo5j?=
 =?us-ascii?Q?Erb3Ie+GXfqHD3RXjprS1Fx9rKC6h1uJTPxJgEYmi/odRQZdd6mbHHZzKEsq?=
 =?us-ascii?Q?MPsrx/0aiJLmrB1Z9jGIOunGTj2ahNNqhxCk15I++DZofUFtftbu5wK792Dv?=
 =?us-ascii?Q?2oi9yyx8BHsEFnrSFTOYauP4v/g1Xbow+4q/JBZeJMMF1KALNaMsnCVnptuL?=
 =?us-ascii?Q?QFyUcP0wKBl3IlnX6SRd055KwUC2B5V7ABbCa/CCmmVKoOhE9ry4WUTyYFmx?=
 =?us-ascii?Q?Dg2WVfZl84C4bHrOSvo2ZDpoyUvvERkfduT24m4EWeAR59bgw3/+sCvAQGhV?=
 =?us-ascii?Q?hYhXy1ovfciT+mKbe4RHz0Ae/zfHxzawpsRdAALBnOEmaa0eD34x+GrQi3sY?=
 =?us-ascii?Q?SjatmaEYPXX9746s+jTdBMunx7hOKwXfQ4s/soWcvZjFVB3g7oYRdxwEIn5X?=
 =?us-ascii?Q?bMTyQQ5lCwmL8hHmrX/TwrABkKHV/ckY/XEXNFOp0XOH90FDLudjfoTaOvfK?=
 =?us-ascii?Q?KoRyV1EyJh4hyhaxiuHj2GGxtQHvmmJOwm2dgbxSP75XvCNl0jK2rf27YKly?=
 =?us-ascii?Q?yaLtQuWFTUrRtJcon9Z3aHUSYb36DU55enyjbwe2ZFOg2VwxJdfA34GtNwjl?=
 =?us-ascii?Q?gA2eP+PN3s469yGhuJ4Vy4jjGQMKOu8LpePrwXYfhKe2eixCJDyeWXQluyeY?=
 =?us-ascii?Q?21aDJVJLqpL4HfCkz1nPIqmxOOU+hE3eOoGL4ZtBtfCejV+HkDtCw8YyYfKL?=
 =?us-ascii?Q?Dz/MsE/rHuftwKYgIe0p8oXRa6fHpEYUT1T2ubGWJ32ZbxmPMecoAq7onM5J?=
 =?us-ascii?Q?sYVwhYMf5op4K/06VqVbvXoxrPyjJ5u9Vgns?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2025 19:44:36.6739 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 924fe219-acba-443a-1b98-08ddbd8eb47f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EDD4.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6043
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

start from:
  261fdc003175671fbda47d94d2244ba8c22934f5
  Workaround for stuck I2C arbitrage

Stopped at:
  a69637b2e3b0ee50bd1bd10552115bbe1dfe2793
  Revert "Add DPP & HUBP reset if power gate enabled on DCN314"

Please, pay extra attention to the following patches:

1) drm/amd/display: MPC basic allocation logic and TMZ
        Changed the commit message.

2) IP_CHECK_BODY drm/amd/display: refactor DSC cap calculations
        This commit message was pointed out with IP_CHECK_BODY; however,
        everything looks fine to me. Please take extra attention to this
        patch.

3) drm/amd/display: Notify display idle on D3
        The patch seems to be more related to DCN42.

4) drm/amd/display: Adding missing driver code for IPSv2.0
        The patch seems to be more related to DCN42.

5) drm/amd/display: Notify DMUB on HW Release
        The patch seems to be more related to DCN42.

6) drm/amd/display: Added static pg implementations for future use
        Changed the commit message.
        The patch seems to be more related to DCN42.

7) drm/amd/display: Free memory allocation
        Was initially SOB'd by Jenkins Infra account (sw.jenkins),
        changed it to Clayton King

8) IP_CHECK_BODY drm/amd/display: initial support for SmartMux
        Manually added 4 files:
        - dcn30m_clk_mgr.c
        - dcn30m_clk_mgr.h
        - dcn30m_clk_mgr_smu_msg.c
        - dcn30m_clk_mgr_smu_msg.h
        This commit message was pointed out with IP_CHECK_BODY; however,
        everything looks fine to me. Please take extra attention to this
        patch.


Extra Note:
1) IP_CHECK_BODY drm/amd/display: unit test framework with xmake.
        Dropped this patch.

2) PROMOTION_SUBMODULE_PREFIX-dc/sspl-END- IP_CHECK_MSG
        Dropped this patch.



Aurabindo Pillai (1):
  IP_CHECK_BODY drm/amd/display: initial support for SmartMux

Charlene Liu (1):
  drm/amd/display: limit clear_update_flags to dcn32 and above

Dillon Varone (1):
  IP_CHECK_BODY drm/amd/display: refactor DSC cap calculations

Duncan Ma (2):
  drm/amd/display: Notify display idle on D3
  drm/amd/display: Notify DMUB on HW Release

Fudongwang (1):
  drm/amd/display: Monitor patch to ignore EDID audio SAB check

Ilya Bakoulin (1):
  drm/amd/display: Add definitions to support DID Type5 descriptors

Ivan Lipski (1):
  drm/amd/display: Revert "Add DPP & HUBP reset if power gate enabled on
    DCN314"

Jenkins, Sw (1):
  drm/amd/display: Free memory allocation

Karthi Kandasamy (1):
  drm/amd/display: prepare for new platform

Leo Chen (3):
  drm/amd/display: Adding missing driver code for IPSv2.0
  drm/amd/display: Added static pg implementations for future use
  drm/amd/display: New Behavior for debug option disable_ips_in_vpb

Michael Strauss (1):
  drm/amd/display: Fix FIXED_VS retimer clock gen source override

Ovidiu Bunea (2):
  drm/amd/display: Add support for Panel Replay on DP1 eDP
    (panel_inst=1)
  drm/amd/display: Add HPO encoder support to Replay

Yihan Zhu (1):
  drm/amd/display: MPC basic allocation logic and TMZ

 .../gpu/drm/amd/display/dc/clk_mgr/Makefile   |   2 +-
 .../gpu/drm/amd/display/dc/clk_mgr/clk_mgr.c  |   2 +-
 .../drm/amd/display/dc/clk_mgr/dcn30/dalsmc.h |   3 +-
 .../display/dc/clk_mgr/dcn30/dcn30_clk_mgr.c  |   4 +-
 .../display/dc/clk_mgr/dcn30/dcn30m_clk_mgr.c |  36 ++++
 .../display/dc/clk_mgr/dcn30/dcn30m_clk_mgr.h |  31 +++
 .../dc/clk_mgr/dcn30/dcn30m_clk_mgr_smu_msg.c | 118 +++++++++++
 .../dc/clk_mgr/dcn30/dcn30m_clk_mgr_smu_msg.h |  34 ++++
 .../dc/clk_mgr/dcn401/dcn401_clk_mgr.c        |  33 ++-
 .../dc/clk_mgr/dcn401/dcn401_clk_mgr.h        |   2 +
 drivers/gpu/drm/amd/display/dc/core/dc.c      |  16 +-
 .../drm/amd/display/dc/core/dc_hw_sequencer.c |  26 +++
 .../gpu/drm/amd/display/dc/core/dc_resource.c |   4 +-
 .../gpu/drm/amd/display/dc/core/dc_state.c    |   2 +
 .../gpu/drm/amd/display/dc/core/dc_stream.c   |  67 ++++++
 drivers/gpu/drm/amd/display/dc/dc.h           |  23 +++
 drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c  |  75 +++++--
 drivers/gpu/drm/amd/display/dc/dc_dmub_srv.h  |   6 +
 drivers/gpu/drm/amd/display/dc/dc_stream.h    |  11 +
 drivers/gpu/drm/amd/display/dc/dc_types.h     |   3 +
 .../gpu/drm/amd/display/dc/dce/dmub_replay.c  |  43 +++-
 .../gpu/drm/amd/display/dc/dce/dmub_replay.h  |   2 +-
 drivers/gpu/drm/amd/display/dc/dsc/dc_dsc.c   | 192 +++++++++++++++---
 .../amd/display/dc/dsc/dcn401/dcn401_dsc.c    |  24 +--
 .../amd/display/dc/dsc/dcn401/dcn401_dsc.h    |   1 -
 drivers/gpu/drm/amd/display/dc/dsc/dsc.h      |   1 +
 .../amd/display/dc/hubp/dcn401/dcn401_hubp.c  |   4 +-
 .../amd/display/dc/hubp/dcn401/dcn401_hubp.h  |   2 +-
 .../amd/display/dc/hwss/dce110/dce110_hwseq.c |  24 +++
 .../amd/display/dc/hwss/dcn10/dcn10_hwseq.c   |   2 +-
 .../amd/display/dc/hwss/dcn31/dcn31_hwseq.c   |  13 ++
 .../amd/display/dc/hwss/dcn314/dcn314_hwseq.c |  37 +---
 .../amd/display/dc/hwss/dcn314/dcn314_hwseq.h |   2 -
 .../amd/display/dc/hwss/dcn314/dcn314_init.c  |   2 +-
 .../amd/display/dc/hwss/dcn401/dcn401_hwseq.c |  14 +-
 .../amd/display/dc/hwss/dcn401/dcn401_hwseq.h |   1 +
 .../drm/amd/display/dc/hwss/hw_sequencer.h    |   3 +
 .../gpu/drm/amd/display/dc/inc/core_types.h   |   3 +
 .../gpu/drm/amd/display/dc/inc/hw/clk_mgr.h   |  14 ++
 drivers/gpu/drm/amd/display/dc/inc/hw/hubp.h  |   2 +-
 .../gpu/drm/amd/display/dc/inc/hw/pg_cntl.h   |   2 +
 .../link_hwss_hpo_fixed_vs_pe_retimer_dp.c    |   2 +-
 .../gpu/drm/amd/display/dc/link/link_dpms.c   |  19 +-
 .../drm/amd/display/dc/link/link_factory.c    |   8 +-
 .../dc/link/protocols/link_dp_capability.c    |  19 ++
 .../link/protocols/link_edp_panel_control.c   |  19 +-
 .../link/protocols/link_edp_panel_control.h   |   1 +
 .../dc/resource/dcn20/dcn20_resource.c        |   2 +
 .../dc/resource/dcn201/dcn201_resource.c      |   2 +
 .../dc/resource/dcn21/dcn21_resource.c        |   2 +
 .../dc/resource/dcn30/dcn30_resource.c        |   2 +
 .../dc/resource/dcn301/dcn301_resource.c      |   2 +
 .../dc/resource/dcn302/dcn302_resource.c      |   2 +
 .../dc/resource/dcn303/dcn303_resource.c      |   2 +
 .../dc/resource/dcn31/dcn31_resource.c        |   2 +
 .../dc/resource/dcn314/dcn314_resource.c      |   2 +
 .../dc/resource/dcn315/dcn315_resource.c      |   2 +
 .../dc/resource/dcn316/dcn316_resource.c      |   2 +
 .../dc/resource/dcn32/dcn32_resource.c        |   2 +
 .../dc/resource/dcn321/dcn321_resource.c      |   2 +
 .../dc/resource/dcn35/dcn35_resource.c        |   2 +
 .../dc/resource/dcn351/dcn351_resource.c      |   2 +
 .../dc/resource/dcn36/dcn36_resource.c        |   2 +
 .../dc/resource/dcn401/dcn401_resource.c      |   2 +
 .../gpu/drm/amd/display/dmub/inc/dmub_cmd.h   |  36 +++-
 .../amd/display/modules/power/power_helpers.h |   2 +
 66 files changed, 902 insertions(+), 124 deletions(-)
 create mode 100644 drivers/gpu/drm/amd/display/dc/clk_mgr/dcn30/dcn30m_clk_mgr.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/clk_mgr/dcn30/dcn30m_clk_mgr.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/clk_mgr/dcn30/dcn30m_clk_mgr_smu_msg.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/clk_mgr/dcn30/dcn30m_clk_mgr_smu_msg.h

-- 
2.43.0

