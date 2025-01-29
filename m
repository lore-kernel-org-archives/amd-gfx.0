Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF757C0218A
	for <amd-gfx@archiver.kernel.org>; Wed, 29 Jan 2025 02:45:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 72E7810E292;
	Wed, 29 Jan 2025 02:45:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="dAU3rTSz";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2061.outbound.protection.outlook.com [40.107.243.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 56C1810E292
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 Jan 2025 02:45:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BEjb9V6n4kMyxXtZOAlcObLbts1dGRNulnM0AwenCpmKCdkKNbT5ZR+cb3/erELlh/yGtbrLQZRpLRWhmQPmw0GFVOoHV+4Hx5uKY4MQz7Hz+LB2wO8shP8A022yp4Rj7YbU/XdLFwbmzI5nY1+AyGD8J40FBgDngTVXt9fyrr4pkkM5Zbv9xhf9IguVwHG7GS1SIH7uS7Skb3kRqqKk5k57r7jEmMkbiRN8jOGnF3BBVincou2mxvEQ7KRE5NY95xZOeAPmu1P4a0ZoJUeHnrury8/KlKoumJ9XzbbSA6vh9aUxKc1HdPjoieeN0lSUNfhFEz83VM7fo9BH1Dh6PA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZH3pJVr1JmeiXi4UFdWhBXecaG/hW2lXozVzaEMVaCM=;
 b=XujUgAHsqEH3K0HZzsL+Sj96sjrcrCKuaF+gsgsP6o3b2E3I6snlsJZLUp89UDYxMhfpDR3juwSp8BiwsELCquV9u5T8C3DxX6buiQErFcinHPJkGpe+4+QMBeqGi41Ays4Ma3TFUnSJzCogFrZJMf+wIf9B0yT11pec+CNROGwxcHNjFklkFnCNgyq5GuAAvVH3JS23F4dD0LRSawRKzJKFUkzRfRBNzPZs1Ansbq9vZd1A2eEsohsITl60MIa7zHSi77T10GSz/ZdwylP7JafUuVEAUlB5BduGBXIvZ5ye2WDRH0qvN1gXPPlSV+3JIBGITzN9NGLasLX3ycaq3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZH3pJVr1JmeiXi4UFdWhBXecaG/hW2lXozVzaEMVaCM=;
 b=dAU3rTSza36BEOwMoI+9XiaqHy0GV1OM/aT16TNCtMOqUIUEv1g4IwAnUG9PgjUXcGWTeEQuFZDiBzk2HIhbgWMKPKPXmXYdbjXsTYNRIRYqpqPpzXdWTnUbxzyix8LhrDUQx9W09DTq9cHa40o3iudLxZEvXosIZARSLVVApnQ=
Received: from BL0PR0102CA0033.prod.exchangelabs.com (2603:10b6:207:18::46) by
 SJ2PR12MB7895.namprd12.prod.outlook.com (2603:10b6:a03:4c6::6) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8377.22; Wed, 29 Jan 2025 02:45:03 +0000
Received: from BN2PEPF000044A4.namprd02.prod.outlook.com
 (2603:10b6:207:18:cafe::ea) by BL0PR0102CA0033.outlook.office365.com
 (2603:10b6:207:18::46) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8377.22 via Frontend Transport; Wed,
 29 Jan 2025 02:45:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF000044A4.mail.protection.outlook.com (10.167.243.155) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8398.14 via Frontend Transport; Wed, 29 Jan 2025 02:45:03 +0000
Received: from smtp.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 28 Jan
 2025 20:44:59 -0600
From: Alex Hung <alex.hung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <rodrigo.siqueira@amd.com>, Aurabindo Pillai
 <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>, Wayne Lin
 <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, Fangzhi Zuo
 <jerry.zuo@amd.com>, Zaeem Mohamed <zaeem.mohamed@amd.com>, Solomon Chiu
 <solomon.chiu@amd.com>, Daniel Wheeler <daniel.wheeler@amd.com>, Alex Hung
 <alex.hung@amd.com>
Subject: [PATCH 00/10] DC Patches Jan 28, 2025
Date: Tue, 28 Jan 2025 19:41:36 -0700
Message-ID: <20250129024432.2107937-1-alex.hung@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A4:EE_|SJ2PR12MB7895:EE_
X-MS-Office365-Filtering-Correlation-Id: 0d43bbff-3fa5-4e6d-8139-08dd400eee96
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?sm/UfzHrXBwV/w98/+xjlWzqrB7vmPuJluxES7om2XNtpUZKbMLVyaCM6/cO?=
 =?us-ascii?Q?/zc5BERfwV0kh6j0mDry66/ZLuhx0mvwQZlh3CktrwngH9C2ntzMEp+BKd7S?=
 =?us-ascii?Q?IpIlXMJsD8pKpSEwFzl4jutDeWw+WNEbN7hJ5FzGwjWDvzpz4BiDZKO7fBxX?=
 =?us-ascii?Q?tydSwNx5KqT4420F1S5t12giVjXEkHedx+TzKIlyJksqODINkCM/ovHyUO+h?=
 =?us-ascii?Q?+gfT5WicKDrY30R5pWymLKL+2J26I4bqYZpGpvoW2sQNn6lcd8svQpkefqpC?=
 =?us-ascii?Q?sSzQFYB95daibhTl03UrHHzpdLy+RiqqMGE8zgp+k8W2SGFjyA99w6VWt+rH?=
 =?us-ascii?Q?bhQb7OkPAdQlGee7g/j4dYUJfPZ3FrNX26TkAQ4Ra0nIqKam/1eRoRyzyK0Q?=
 =?us-ascii?Q?xMr9fpcUlsyivbRfwdVvBtsJAEC6gyHnBaeKMZKAND1DHEnQH6fLbFtVovli?=
 =?us-ascii?Q?TmWl8oYbjVKiFaAoS+5vt8KU1Wp5cuDtq2xPbC/OwY/ahDwQ/+MhgG7NASRw?=
 =?us-ascii?Q?T7WtlIswAisfwb2t4LZzGWaEksMO9fCi7G0Lebiyr7vLTJMKzpknkHw1SMIu?=
 =?us-ascii?Q?eHXbGvntITllDGAt37pcFa7fTnS94t6XW07ErkX9EtE26rDEDWG20/CvZvDQ?=
 =?us-ascii?Q?wz1wAumGZERN+xSkHmqQm84JFzwCZig/CG45FL8j3HsroOR557KGCrBM9qLr?=
 =?us-ascii?Q?GpkMk8Y8r7y4vvu2BmdIKCNZL8dOOwjU2W+7M4R4Nw3E1rB9QgSlGuFs7YKg?=
 =?us-ascii?Q?03dH9me9biG0fh76BtoOmY3Dv+ZkA2eiHEYkil9rdo+AuXgV+I2oJYeRrnTL?=
 =?us-ascii?Q?dYiT3VX8pzCtYm+7m5s5L/NqyMLJa2KPnQy4/8uwaZQ3fzSa8+fWbEMjkEp1?=
 =?us-ascii?Q?q+dJt+DnfC1Ke7grb2QxEahh0kyBuqTIdKC6637qqVT6ODmanyycfuiOpiPJ?=
 =?us-ascii?Q?MWzt5DdY1AvcdfEsuEDgnvBdZyGt4fyCF7hc1GUXBMthX8k22yuUhQcjFLtM?=
 =?us-ascii?Q?tp/BbNiZeRkS0xbAhZ3cmBqSbJ8SvUH4Sih+qtkuM7DYJVkbui53XSuq2HEn?=
 =?us-ascii?Q?DFvSrmc4jlm29+YY+vgnr7ZeoNSJxiQS62RuLaAhTE14kb2Ko6rJbdUPeGww?=
 =?us-ascii?Q?ZQjCWmYjl1rsfpUlMTwndcW3lfubY9NDlsoLNu2ydqXWVmbfQX58B7TI4XW5?=
 =?us-ascii?Q?oLCtel3mQvTR1taUkdmdBtfGNTmNk+ntpEtDoBIs1VxbauZkPj8qzOWaXLjk?=
 =?us-ascii?Q?kM7ySdJRAgbTlMk9hkY5k15ARGlbZUF+YLZ8kjvCULxnmPhgywX6IiGlP1UW?=
 =?us-ascii?Q?51YmhPN8A2HKuls4/QttGpaN8Y+ivbhYPWnPGB3zjjq4YQhRJDKnIXT1d96q?=
 =?us-ascii?Q?cDJnmxWVNuQ6hXu5NGCl9wN3lK6Tzn+elMniFEWsQ6wIImrMJek4cdQqycEy?=
 =?us-ascii?Q?FJCwvRYld7cQJXz+UOUHD8kglndeC4rWtFMOes+zuHNj78j2gVTN3g=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jan 2025 02:45:03.2414 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d43bbff-3fa5-4e6d-8139-08dd400eee96
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000044A4.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7895
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

* Fixes on DCN3.2 and DCN4
* Code factoring for SPL module
* Various bug fixes

Cc: Daniel Wheeler <daniel.wheeler@amd.com>

Ahmed, Muhammad (1):
  drm/amd/display: Enable odm 4:1 when debug key is set

Alex Hung (1):
  drm/amd/display: Fix out-of-bound accesses

Aric Cyr (1):
  drm/amd/display: Request HW cursor on DCN3.2 with SubVP

Brandon Syu (1):
  Revert "drm/amd/display: Exit idle optimizations before attempt to
    access PHY"

Dillon Varone (1):
  drm/amd/display: Fixes for mcache programming in DML21

Dmytro (1):
  drm/amd/display: Allow reuse of of DCN4x code

Lo-an Chen (1):
  drm/amd/display: Fix seamless boot sequence

Martin Tsai (1):
  drm/amd/display: Support multiple options during psr entry.

Samson Tam (1):
  drm/amd/display: Move SPL to a new path

Taimur Hassan (1):
  drm/amd/display: 3.2.319

 drivers/gpu/drm/amd/display/dc/Makefile       |  2 +-
 drivers/gpu/drm/amd/display/dc/core/dc.c      |  2 +-
 drivers/gpu/drm/amd/display/dc/dc.h           |  4 +-
 .../gpu/drm/amd/display/dc/dc_spl_translate.c |  1 -
 drivers/gpu/drm/amd/display/dc/dc_types.h     |  7 ++++
 .../amd/display/dc/dccg/dcn401/dcn401_dccg.c  | 24 +++++------
 .../amd/display/dc/dccg/dcn401/dcn401_dccg.h  | 40 ++++++++++++++++++-
 drivers/gpu/drm/amd/display/dc/dce/dmub_psr.c |  4 ++
 .../dc/dio/dcn30/dcn30_dio_stream_encoder.c   |  2 +-
 .../dc/dio/dcn30/dcn30_dio_stream_encoder.h   |  6 ++-
 .../dc/dio/dcn401/dcn401_dio_stream_encoder.c | 12 +++---
 .../dc/dio/dcn401/dcn401_dio_stream_encoder.h | 18 +++++++++
 .../amd/display/dc/dml/dcn314/dcn314_fpu.c    |  3 ++
 .../drm/amd/display/dc/dml/dcn32/dcn32_fpu.c  |  1 +
 .../dc/dml2/dml21/dml21_translation_helper.c  |  4 +-
 .../amd/display/dc/dml2/dml21/dml21_utils.c   |  1 -
 .../amd/display/dc/dml2/dml21/dml21_wrapper.c | 14 +++++++
 .../display/dc/dml2/dml21/inc/dml_top_types.h |  1 +
 .../dml2/dml21/src/dml2_core/dml2_core_dcn4.c | 30 +++++++++++++-
 .../src/dml2_core/dml2_core_dcn4_calcs.c      |  3 ++
 .../dml21/src/dml2_pmo/dml2_pmo_dcn4_fams2.c  | 21 ++++++++++
 .../dml2/dml21/src/dml2_top/dml2_top_soc15.c  |  8 ----
 .../display/dc/dml2/dml2_translation_helper.c |  6 +--
 .../drm/amd/display/dc/dml2/dml2_wrapper.c    |  5 ++-
 .../drm/amd/display/dc/dpp/dcn20/dcn20_dpp.h  |  1 -
 .../drm/amd/display/dc/dpp/dcn32/dcn32_dpp.h  |  1 -
 .../amd/display/dc/dsc/dcn401/dcn401_dsc.c    | 19 +++------
 .../amd/display/dc/dsc/dcn401/dcn401_dsc.h    |  7 ++++
 .../dc/hpo/dcn32/dcn32_hpo_dp_link_encoder.c  |  2 +-
 .../dc/hpo/dcn32/dcn32_hpo_dp_link_encoder.h  |  1 +
 .../display/dc/hubbub/dcn30/dcn30_hubbub.c    |  3 +-
 .../display/dc/hubbub/dcn31/dcn31_hubbub.c    |  3 +-
 .../display/dc/hubbub/dcn32/dcn32_hubbub.c    |  3 +-
 .../display/dc/hubbub/dcn35/dcn35_hubbub.c    | 17 ++++----
 .../display/dc/hubbub/dcn35/dcn35_hubbub.h    | 16 ++++++++
 .../amd/display/dc/hubp/dcn20/dcn20_hubp.h    |  5 +--
 .../amd/display/dc/hubp/dcn30/dcn30_hubp.c    |  2 +
 .../amd/display/dc/hubp/dcn32/dcn32_hubp.c    |  2 +
 .../amd/display/dc/hubp/dcn35/dcn35_hubp.c    |  2 +-
 .../amd/display/dc/hubp/dcn35/dcn35_hubp.h    |  1 +
 .../drm/amd/display/dc/hwss/dce/dce_hwseq.h   |  8 ++++
 .../amd/display/dc/hwss/dce110/dce110_hwseq.c |  5 ---
 .../amd/display/dc/hwss/dcn20/dcn20_hwseq.c   |  3 +-
 .../amd/display/dc/hwss/dcn32/dcn32_hwseq.c   |  3 +-
 .../amd/display/dc/hwss/dcn35/dcn35_hwseq.c   |  3 +-
 .../gpu/drm/amd/display/dc/inc/core_types.h   |  2 +-
 .../gpu/drm/amd/display/dc/inc/hw/transform.h |  2 +-
 drivers/gpu/drm/amd/display/dc/inc/resource.h |  1 -
 .../gpu/drm/amd/display/dc/mmhubbub/Makefile  |  2 +-
 drivers/gpu/drm/amd/display/dc/mpc/Makefile   |  2 +-
 .../amd/display/dc/mpc/dcn401/dcn401_mpc.c    |  4 +-
 .../amd/display/dc/mpc/dcn401/dcn401_mpc.h    |  5 ++-
 .../amd/display/dc/optc/dcn10/dcn10_optc.h    | 14 +++++--
 .../amd/display/dc/optc/dcn401/dcn401_optc.c  | 22 +++++-----
 .../amd/display/dc/optc/dcn401/dcn401_optc.h  | 19 +++++++++
 .../dc/resource/dcn401/dcn401_resource.c      |  4 +-
 .../drm/amd/display/dc/{spl => sspl}/Makefile |  2 +-
 .../drm/amd/display/dc/{spl => sspl}/dc_spl.c |  0
 .../drm/amd/display/dc/{spl => sspl}/dc_spl.h |  0
 .../display/dc/{spl => sspl}/dc_spl_filters.c |  0
 .../display/dc/{spl => sspl}/dc_spl_filters.h |  0
 .../dc/{spl => sspl}/dc_spl_isharp_filters.c  |  0
 .../dc/{spl => sspl}/dc_spl_isharp_filters.h  |  0
 .../{spl => sspl}/dc_spl_scl_easf_filters.c   |  0
 .../{spl => sspl}/dc_spl_scl_easf_filters.h   |  0
 .../dc/{spl => sspl}/dc_spl_scl_filters.c     |  0
 .../dc/{spl => sspl}/dc_spl_scl_filters.h     |  0
 .../display/dc/{spl => sspl}/dc_spl_types.h   |  0
 .../dc/{spl => sspl}/spl_custom_float.c       |  0
 .../dc/{spl => sspl}/spl_custom_float.h       |  0
 .../amd/display/dc/{spl => sspl}/spl_debug.h  |  0
 .../display/dc/{spl => sspl}/spl_fixpt31_32.c |  0
 .../display/dc/{spl => sspl}/spl_fixpt31_32.h |  0
 .../display/dc/{spl => sspl}/spl_os_types.h   |  0
 .../gpu/drm/amd/display/dmub/inc/dmub_cmd.h   |  6 +++
 75 files changed, 304 insertions(+), 107 deletions(-)
 rename drivers/gpu/drm/amd/display/dc/{spl => sspl}/Makefile (96%)
 rename drivers/gpu/drm/amd/display/dc/{spl => sspl}/dc_spl.c (100%)
 rename drivers/gpu/drm/amd/display/dc/{spl => sspl}/dc_spl.h (100%)
 rename drivers/gpu/drm/amd/display/dc/{spl => sspl}/dc_spl_filters.c (100%)
 rename drivers/gpu/drm/amd/display/dc/{spl => sspl}/dc_spl_filters.h (100%)
 rename drivers/gpu/drm/amd/display/dc/{spl => sspl}/dc_spl_isharp_filters.c (100%)
 rename drivers/gpu/drm/amd/display/dc/{spl => sspl}/dc_spl_isharp_filters.h (100%)
 rename drivers/gpu/drm/amd/display/dc/{spl => sspl}/dc_spl_scl_easf_filters.c (100%)
 rename drivers/gpu/drm/amd/display/dc/{spl => sspl}/dc_spl_scl_easf_filters.h (100%)
 rename drivers/gpu/drm/amd/display/dc/{spl => sspl}/dc_spl_scl_filters.c (100%)
 rename drivers/gpu/drm/amd/display/dc/{spl => sspl}/dc_spl_scl_filters.h (100%)
 rename drivers/gpu/drm/amd/display/dc/{spl => sspl}/dc_spl_types.h (100%)
 rename drivers/gpu/drm/amd/display/dc/{spl => sspl}/spl_custom_float.c (100%)
 rename drivers/gpu/drm/amd/display/dc/{spl => sspl}/spl_custom_float.h (100%)
 rename drivers/gpu/drm/amd/display/dc/{spl => sspl}/spl_debug.h (100%)
 rename drivers/gpu/drm/amd/display/dc/{spl => sspl}/spl_fixpt31_32.c (100%)
 rename drivers/gpu/drm/amd/display/dc/{spl => sspl}/spl_fixpt31_32.h (100%)
 rename drivers/gpu/drm/amd/display/dc/{spl => sspl}/spl_os_types.h (100%)

-- 
2.43.0

