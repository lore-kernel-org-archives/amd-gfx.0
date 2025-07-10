Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B5A0C83F17
	for <amd-gfx@archiver.kernel.org>; Thu, 10 Jul 2025 21:30:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 39A5E10E961;
	Thu, 10 Jul 2025 21:30:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="5Oj33N/S";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2051.outbound.protection.outlook.com [40.107.223.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0F6D610E960
 for <amd-gfx@lists.freedesktop.org>; Thu, 10 Jul 2025 21:29:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=axV4GSwzBrSMmDzM4bnbwZ2pZqYBMjmfopuwcTWvMauUuVCPMn/tuf+mpJsCJUxXGSZkSfRYpWUtllAJy/pQgPikZAKaf/sqF+ZdlyJxj+XpI7rpVMjdDlr+emmNGEVxQ+kyBLy/AQhp5tvDm2Gjr8qxyjhclx7WPj4BOZW6lLazhfCulHOzo3CbnqOc3wstrMuo+iTAaOBelFdqCgqOww7SDW0uVGhVrpvLiGxV+EZmnGnT4bwgYBI2PLJl2QaS23g72HzVCDflvMfZ0L96hdgDtTzWYDLKhdiV+fCOeJUwmoMxcrQ56NYtmMY3eL/KYht9YUicE8ED+4B/esIu+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/gijSHWBBnB4blxSaObGvahOJeiWfJtucwLjgiFllpE=;
 b=FJeOdUmcS7vuEW8D/jGRcyu0hY5UtXxrc5UNWOeggqXzbgQWqXQwPATgYxPK4EvqPqeksV0e7cAQN5SBJmipZh4IQfA8LaQDRS4mljUrXroGyGOqDbLT5+UnYqCQyNAXnwtzfDVtKG8SEvslc2jgHawDhh7LFTEwceYtqs896OocCWECcJyojm2c72mDlRfvswFwlY939wGid+KsZOR/Q1GFDHyTCW7o5uoudjpwvRzY4rEuYuD9GTc/2YdhtfUfXtcUHsmmu+oL3YNYbOWVkm0ZtgLO289MUOsiIl2O9h2Qm6a8SF0JlcPe5NQdvuibVlSiloTOm2sm1tvyt7e1Bw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/gijSHWBBnB4blxSaObGvahOJeiWfJtucwLjgiFllpE=;
 b=5Oj33N/Sc9ua1WLhik12dC7T7y00BmQ43k7L7sQGt7Eq48JhYK5404ssFPuaDxRZmoZf1VDUXp3XLgaX2VLfMmJZd/vQdWCgQBNOhe6y4UAQ+3vTZlDs9R9/U3+JCBCE48gutiLAhbw7I8ptRwzYcy3ec0nsJ8xCh7/X84qNrAU=
Received: from CH2PR20CA0007.namprd20.prod.outlook.com (2603:10b6:610:58::17)
 by DS0PR12MB9274.namprd12.prod.outlook.com (2603:10b6:8:1a9::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.29; Thu, 10 Jul
 2025 21:29:54 +0000
Received: from CH1PEPF0000AD75.namprd04.prod.outlook.com
 (2603:10b6:610:58:cafe::88) by CH2PR20CA0007.outlook.office365.com
 (2603:10b6:610:58::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8922.21 via Frontend Transport; Thu,
 10 Jul 2025 21:29:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH1PEPF0000AD75.mail.protection.outlook.com (10.167.244.54) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8922.22 via Frontend Transport; Thu, 10 Jul 2025 21:29:54 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 10 Jul
 2025 16:29:54 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 10 Jul
 2025 16:29:53 -0500
Received: from box-0.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Thu, 10 Jul 2025 16:29:53 -0500
From: <IVAN.LIPSKI@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Daniel Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Alex Hung <alex.hung@amd.com>, Ivan Lipski
 <ivan.lipski@amd.com>
Subject: [PATCH 00/18] DC Patches July 7, 2025
Date: Thu, 10 Jul 2025 17:25:33 -0400
Message-ID: <20250710212941.630259-1-IVAN.LIPSKI@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD75:EE_|DS0PR12MB9274:EE_
X-MS-Office365-Filtering-Correlation-Id: 476163b5-0a12-4bfc-6b59-08ddbff8e966
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?gq9Ry4cVIm5xoNBNd6+dFnCerP/h2Mh2E4FELcidbRwj+j690ozfI7tGkLgO?=
 =?us-ascii?Q?tWinA7dUD4EKO23BmLZVxXlS4fYpbFP8byR91p55wT+hc66vudcpW8As7X+h?=
 =?us-ascii?Q?ZBUgQDJPD6TmxtBJiCh625kYPy2nMv0m26+9qhTALOLqQpZ7BP1PSyjqU3hT?=
 =?us-ascii?Q?v+MaWGTJyYtpkisMnjCYJh7ZG2NNCn7TXsY7FHJZLeVvOyqOsq0lsgtScFr3?=
 =?us-ascii?Q?Shwwg6Hu7PUEp0bRcUCbt9nSMymvxOvrR8nX0RjaLxKcfQjIxgJGhHLK2ObH?=
 =?us-ascii?Q?J6MSj9kbAV/OTXcC/uLjgJFuMsKNjHtRUXE13XUUyvolrVBseay+nnLIOEm0?=
 =?us-ascii?Q?nHOC4cONSBiOx7kq+ZBn79t90Kv3h0prR8iGvLXQwtDJuimx8lekAI/sqhXL?=
 =?us-ascii?Q?0AQoFbdQCMtP0E/ayMFH6XcY27LkU0sFnaT0T4NWDqd4+tbOpvddlguhu3+T?=
 =?us-ascii?Q?/bk9RyC+AEvfcw/eQUQGyh4hqXlv8mWlQ9KeXc7VaKydI4fmTCDZKRaJDXMU?=
 =?us-ascii?Q?6qNk4xGfs1mSqvqvpm5xy/RnqaPlSaTsyDzgB2NcsHsKJQ5hLS2hcSIV73Xp?=
 =?us-ascii?Q?d5jkbLSUw/E45DOlwY+CYBhakqtPT/Dvol1zUzIM/ZD1VKfha5YptgDcm4+v?=
 =?us-ascii?Q?UZj7Xoyt2FKQN1F6qym6Wli46kHgpagsjTEsR5lcNjKmZ/aaebGvZ535RkGX?=
 =?us-ascii?Q?Ed+/3ftF6OXFVtYYgq48FeWfIGy2yZ81Yie7I0QiivlgYl7DyR0bw2s7KL+t?=
 =?us-ascii?Q?iecvvqtkyWndqDOrS/12BTxAoz93XsoxwyS+MxcVA0m9no3OB3WYq7+egO2I?=
 =?us-ascii?Q?xQKJLb0mHOEUGClZHAiqNR+MlBtuekL4cbSy3OpnZ/vHVj++nW/RlhcyHyBs?=
 =?us-ascii?Q?JuyLS0lCL4OJSv2zduSLIX7DnomJaKmIH+Ks6i5UuJ+QtKmI4Fd5loFIfT3E?=
 =?us-ascii?Q?WbtRp8wMcOocqrxcqZvBQ7hCoSBVLALSS9uCH+Tja1Tjtv9bOXwlltLZfKMT?=
 =?us-ascii?Q?dV5nZ7Ff+CQqcNVL5XZTju/UbcdI58i/NoYFYMve3bh2ZhYki+hWSeycuc7Z?=
 =?us-ascii?Q?HptUjHWjJmRDtu+9pmYGaf3Bwq1VwrIajV5DvrrJaW2OI8hjkQOqR3DHg9ul?=
 =?us-ascii?Q?rcdIbOtOkvTuWhqZucIuQonaRL8yiilym3rnDLPgWlOKjpKhxjQY2rNm1MkL?=
 =?us-ascii?Q?tmtN5kLrd+zTWZPrJ4FTEMnKs08aTGf/nT9otO3oqzJWScQus6D55M1YXkpC?=
 =?us-ascii?Q?JPR8XJjM2vLKYN84TypC53PPr8FLQA5+Q6LD+QaIkYRsPfpXNQfABBrNJYrf?=
 =?us-ascii?Q?UG27+kIKXJEB3p35b7spS7hyeEzJyS6GppixsQ9Sf97kd6vBR7jmlTiAEe7c?=
 =?us-ascii?Q?GC2fcTIAUAk1Erk5bVf4RF4LJ6rvLU20NZaEC2+fGDqj9Y28z2E3PAG8+KV/?=
 =?us-ascii?Q?2cK7wPWSZ7qT6X5hFuOd9YAvuRsxn2jZaV/4cinNneuW4Q8t1GAdKEBy9uP2?=
 =?us-ascii?Q?QisXufi5ufOM3KgG9HSlOhnwGzi9Xkn/29Xv?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2025 21:29:54.4535 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 476163b5-0a12-4bfc-6b59-08ddbff8e966
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000AD75.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9274
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

Title: DC Patches July 7, 2025

This DC patchset brings improvements in multiple areas. In summary, we highlight:

* Fixes for DCN401, DCN32;
* Initial support of SmartMux;
* Improvements for Replay, IPS, and IPS2;
* Refactor of DSC;


Cc: Daniel Wheeler <daniel.wheeler@amd.com>



Aurabindo Pillai (1):
  drm/amd/display: Initial support for SmartMux

Charlene Liu (1):
  drm/amd/display: limit clear_update_flags to dcn32 and above

Clayton King (1):
  drm/amd/display: Free memory allocation

Dillon Varone (1):
  drm/amd/display: Refactor DSC cap calculations

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

Karthi Kandasamy (1):
  drm/amd/display: Make dcn401_initialize_min_clocks() available to
    other compilation units

Leo Chen (3):
  drm/amd/display: Adding missing driver code for IPSv2.0
  drm/amd/display: Add static pg implementations for future use
  drm/amd/display: New Behavior for debug option disable_ips_in_vpb

Melissa Wen (1):
  drm/amd/display: Disable CRTC degamma LUT for DCN401

Michael Strauss (1):
  drm/amd/display: Fix FIXED_VS retimer clock gen source override

Ovidiu Bunea (2):
  drm/amd/display: Add support for Panel Replay on DP1 eDP
    (panel_inst=1)
  drm/amd/display: Add HPO encoder support to Replay

Yihan Zhu (1):
  drm/amd/display: MPC basic allocation logic and TMZ

 .../amd/display/amdgpu_dm/amdgpu_dm_crtc.c    |  11 +-
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
 67 files changed, 912 insertions(+), 125 deletions(-)
 create mode 100644 drivers/gpu/drm/amd/display/dc/clk_mgr/dcn30/dcn30m_clk_mgr.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/clk_mgr/dcn30/dcn30m_clk_mgr.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/clk_mgr/dcn30/dcn30m_clk_mgr_smu_msg.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/clk_mgr/dcn30/dcn30m_clk_mgr_smu_msg.h

-- 
2.43.0

