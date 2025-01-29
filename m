Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28655C0218A
	for <amd-gfx@archiver.kernel.org>; Wed, 29 Jan 2025 02:55:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B549B10E092;
	Wed, 29 Jan 2025 02:55:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Cnz/mC72";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2070.outbound.protection.outlook.com [40.107.243.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1A3D510E092
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 Jan 2025 02:55:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=b7hBSTaVlQ1iV+pBRQX9yvonHhah4zX81+qfkKIv+p4QevGQYKxJbGKd9d1T7rup+KfaUXiPlkbg9Cd5mdjb4BHbvbhFCYOom0wC/4oX0Ha4lDuqGeJvscXmW4EvmdEbp8mLF9u80ampK0/D9PzQNUM1D4Bb3eO0Ms00jv2KkFpB9yYcKn61RO116Dh25aR3cqI8HyvlqXX8Sa9UgavjgWflKxCRZzZf165kWvbOZhhLC7ARNmwDOnu18XNd5rBehYpk9dr1daX1r4a0kuyrnRQvJ3X2nq99e7jPXd2hogxc/i3DBXn8HulB+Fh3bKAa8GqZQ4haBq+Kc26E8YW3BA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V2wGx1UxyGhpaaf/NiLKmgG20L1N/3bZl4NYC+Qsol0=;
 b=Z+6r+MTQRRds+EXRqHwTy7YV4dLKK557zU/R21qZjR7+v5Cz1ZsRgYeHW4d+4I/dC8pQrQMhq8dK85vOMV0IFmfi/RyzatxjIk+klzNB4hwTU+/Zvhyts3Qio+pUIKHWjrGCcI91/REVeh4XpwgaFfYIU3/l+n5Y43whSQY5hut8KZdd/w7kl3TiG8EdJSlQWM2t4GqwYdEsYUPqOF8LBhtj6ZCB1VNqgGQEGQErXH4fxlMHnTo4axv5uSyLYLXZiAvdj0yIwoij0PgD0JYEj8768RbO6hm7Pr5Wr3ZRirz6ZvBmBg9y/3/WsBUsnq0mgV7JBQwyZ5VMPg5swRc9gA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V2wGx1UxyGhpaaf/NiLKmgG20L1N/3bZl4NYC+Qsol0=;
 b=Cnz/mC72ARbsL9uUOZhO/MJJ2uStikLp40+wvkeqatBQdpfiClvWpytm68Ep0XHewJhDa1BSqO4IJbWqFPxlk+oEI3RhrDt6Dt8fLAlsQuPrU8oCdNaB/43YyP3HGmjm740qHM4PyoRsPZdRxrA1gEc/mC0pkzFiL0FI4HXfE2A=
Received: from BY3PR05CA0002.namprd05.prod.outlook.com (2603:10b6:a03:254::7)
 by SA1PR12MB7247.namprd12.prod.outlook.com (2603:10b6:806:2bb::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.17; Wed, 29 Jan
 2025 02:55:15 +0000
Received: from MWH0EPF000971E4.namprd02.prod.outlook.com
 (2603:10b6:a03:254:cafe::cf) by BY3PR05CA0002.outlook.office365.com
 (2603:10b6:a03:254::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.15 via Frontend Transport; Wed,
 29 Jan 2025 02:55:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000971E4.mail.protection.outlook.com (10.167.243.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8398.14 via Frontend Transport; Wed, 29 Jan 2025 02:55:14 +0000
Received: from smtp.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 28 Jan
 2025 20:55:11 -0600
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
Date: Tue, 28 Jan 2025 19:53:44 -0700
Message-ID: <20250129025458.2120268-1-alex.hung@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E4:EE_|SA1PR12MB7247:EE_
X-MS-Office365-Filtering-Correlation-Id: 1b8dbbd3-fb94-424e-0e1d-08dd40105ac0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?CfBq72MYre/zcQ7xJrKIt6MK510o8FwZHU1rn0no11O3d9j+dGiR529YNflo?=
 =?us-ascii?Q?1EUB+0EopbG4JUSICNXZjew5gFkDVQuu+XzzkgQhVLlRLgNLH8jRuMy8L9IP?=
 =?us-ascii?Q?Np99wjHecI92brxOhneeZsifkWKzurfnMLzFZj1aXq1GhRsYLJVZXp4sOFEz?=
 =?us-ascii?Q?ABiPLdtOXS37r/KloJzyHpwE70kg6IxCSsjQ+fc3BacqsUeXEHJE4vysVyxU?=
 =?us-ascii?Q?/pEOZtjDi+bML6GIVQDmBpNUHqOw9OttImci5E+/Ybe+Azsn+iqUQvwq2lDU?=
 =?us-ascii?Q?iwNnvpbG/5L1cnVhQ5U6/RPsrJHVsP1LCxvlc+Eg70kCyeowOhAhwsgpBEeA?=
 =?us-ascii?Q?1kbaikOG65s89K14jCRICh+HyW8CLyPhYNWRDm97Rcbeiz677ZTOBVIoZPS4?=
 =?us-ascii?Q?5T0McrH0D1QIe66vVxc78hGzz6H4b/ZVJFa1vXSGXZmfUpz8hleK1Jl0HkV+?=
 =?us-ascii?Q?He+UDU0dVR7KtQAsyjiiDNYSpvVt+wynpMvmn5gX2zGY2NVqo2zqEqpgBGQI?=
 =?us-ascii?Q?y/lCly307bAmrpVF+f6mIz6i4cX7Qk822zemcX48ML1e2b8h52aODZcdsSu6?=
 =?us-ascii?Q?rUdb07mHS2ORkgkJlA8luK6zJsFhvK9YwVSMfM6o+b7MHVyXToqjoqRK2AeZ?=
 =?us-ascii?Q?QTHaBvGT3ghe5KL2SoWufPYAuhPFwQxAAhrib59HG1UXnLTQN8/Xd5+JQk3g?=
 =?us-ascii?Q?qzmX0osq3rGhoPSDrldFXv3e07+wv6sPIQupioauGOghc/Cnb5ZXcIqpGkk7?=
 =?us-ascii?Q?61+/mO9CyDzash4jOghjMrthWYFmZs25qH3DHeu0wM7y/ciBy9FebqwWq6KF?=
 =?us-ascii?Q?RY3M16DCB6wzIgPPMdN99lXRSll4Ho1ftnRv2VZ6ZIBecLPL9TusogdM1LfS?=
 =?us-ascii?Q?ufPbEMqET+CPH8JoPjalaSOwSTMfb/WhUShDn3GDYxxoRCtimf6Ipuj5eRNu?=
 =?us-ascii?Q?ZgrD/a2UfHr2rZWMrIIER1vIHh+VswGsNzjI5vWtm1Ay3D2ldHCg2fxv//mH?=
 =?us-ascii?Q?xCCScuG0SB4+vyeLl9bumP6UIheUgMhlH6KiVhdpcVUXJ5veBdHDe+gQzFjD?=
 =?us-ascii?Q?lcl0wGM8YIiHRMx5cxw42aF0mgvILIFkAQ3Ch6CSgy3c3gPg6l4ejyKH42Xh?=
 =?us-ascii?Q?I1L82T8FIveMrZC7xcq8KjBZDTmgFkxvcUNNbBhzNEIa4kzt3am79HoxOao+?=
 =?us-ascii?Q?U2ic7lo2U+0vOzRP7lbjrdkLJ43X1GZp2PKQCri1Qzttql5W6CuGvdvy6TcU?=
 =?us-ascii?Q?Tk71tqPRmJzJoXyVCfuRKYJf213YJ4zJNGFtISkwpcHo4VgvefBvAakQZB4H?=
 =?us-ascii?Q?WeSWbxUhUfob6rrWhYHbybRwTpISlBwIyZIgljKZmE9+RqADeTd6oagcSGWm?=
 =?us-ascii?Q?y8H21MI+ES8423PxPeDF5QIG67QTFjzSfyrHSExkIb9IWRZfj78wLz6U8J/l?=
 =?us-ascii?Q?GMQmpxFVj2cReN7In98e5f+0tlWLZVB3kGg0mXE6JnXD+KV4H8CbafPPAXaX?=
 =?us-ascii?Q?+9PICrJH4wvUeBM=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jan 2025 02:55:14.1106 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b8dbbd3-fb94-424e-0e1d-08dd40105ac0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000971E4.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7247
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

** resend the patchset because only 5 of 10 patches were sent successully **

This DC patchset brings improvements in multiple areas. In summary, we highlight:

* Fixes on DCN3.2 and DCN4
* Code factoring for SPL module
* Various bug fixes

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

