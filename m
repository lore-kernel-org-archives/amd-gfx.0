Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06027C021B5
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Feb 2025 15:43:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A6CC410EAAF;
	Fri, 21 Feb 2025 15:43:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="uHvrWdaW";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2050.outbound.protection.outlook.com [40.107.237.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7D64910EAA3
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Feb 2025 15:43:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pTILMQZgkXnoMTwUK8M/uaIsvPjkmKVQkPGiEn9FlZnWk7JSRwHJyweH21VbtwpL0RhYV0ehujkx6ULS5qYMSH8DqRdjgzvir3ogRFgULNPpv5DFdY4XEITdT2Wg7e1nQ9hMN1XZLHCFBjGwchT4O/0T2d3cJaEh44CPPA4DYn1OJ/g/fbwo0J9SYMWcA4sAVIkfU6Dnvuinv8ND/BpmgHgAZEbeewVyf9PS+03eP8DWqXgxp9B4wtHPEgfXtaOrXF6YwQKaMUTTSyhpwQ65u/aKoSb2VndhQc+43NS13a2gTnG6d/cp33VHpaucqt5g+daYMkWeMj2HiqVck4fdZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OLQmiF+hmbPkSH4EoA+yDOhruXL0MrZYurVJlRGAZpw=;
 b=w0KPuMbTpAXXY0pUwmzEQq6PjVjLFe8A/t+P4ZDYSF3ZAglhykNl35afm9b5g6rlV/bZPAz8ato98W0nvaVddWE+HuwbxT3jdfARX/eWSRPgkkPpqGiDC0GTQHiU5hof1uzuTsY+Ji1Zg9seARHI82oEmcP1pw7VxzMStxLG1oNS32GjLkJsCUM0bV2hgODthJyoH2mWcNZssG+Rdq9YxsmQ3ChzJ2gDNhdzN8sZv9DqCupZqj+Lt4WrqaOkdgU0SseR6ngGhUpmdU3a7XNy/VxaksKtDI8ohXSsCuoZVq2UwgBCRl/XSNVoAgagjjdaUeI5wkQlsb807OCAbWoRzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OLQmiF+hmbPkSH4EoA+yDOhruXL0MrZYurVJlRGAZpw=;
 b=uHvrWdaWS5qXYmUIU8ibajdK+UM0rZorsQhBmrxpIreiaxMvHk4J4nb0MGnub9PRpDJWpeKG5jUncEU91/stDk8D8Jq388ogXyjAQ1B47GTz3831WSIiegjAOFkiryRlPzR9HLmiWC1E2yjdTAUxOLo2CfuGYe3/kSD4ns0THfA=
Received: from SJ0PR05CA0141.namprd05.prod.outlook.com (2603:10b6:a03:33d::26)
 by PH0PR12MB8821.namprd12.prod.outlook.com (2603:10b6:510:28d::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.16; Fri, 21 Feb
 2025 15:43:34 +0000
Received: from CO1PEPF000066EB.namprd05.prod.outlook.com
 (2603:10b6:a03:33d:cafe::11) by SJ0PR05CA0141.outlook.office365.com
 (2603:10b6:a03:33d::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8466.15 via Frontend Transport; Fri,
 21 Feb 2025 15:43:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000066EB.mail.protection.outlook.com (10.167.249.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8466.11 via Frontend Transport; Fri, 21 Feb 2025 15:43:33 +0000
Received: from mkmmarleung05.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 21 Feb
 2025 09:43:31 -0600
From: Zaeem Mohamed <zaeem.mohamed@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Zaeem Mohamed <zaeem.mohamed@amd.com>, Solomon Chiu
 <solomon.chiu@amd.com>, Daniel Wheeler <daniel.wheeler@amd.com>, Alex Hung
 <alex.hung@amd.com>
Subject: [PATCH 00/24] DC Patches FEBRUARY 18, 2025
Date: Fri, 21 Feb 2025 10:42:48 -0500
Message-ID: <20250221154312.1720736-1-zaeem.mohamed@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000066EB:EE_|PH0PR12MB8821:EE_
X-MS-Office365-Filtering-Correlation-Id: 45dc08b8-7114-4292-255d-08dd528e7fdc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Hfy96BGF9SFXQpsFE6Cr9WAfcv38SP0fbnz5SMI8xYU3W5h6FGxPFkaIEA6q?=
 =?us-ascii?Q?Qx8ArQ/djtUNzR/XsN79plICyWI9ldYCkPYrLUnN/PPtJ5KnKruDdBhtmN0I?=
 =?us-ascii?Q?q1/arFEEoOQwTmB7gOAXrRaNvA114xfTIYfsYOwyaf5sjjfAasW0QImA7fen?=
 =?us-ascii?Q?TBAHGvdSYzSeOanb+gLUJ/P0RPAdet/0RFoy0eQgty+wcZbuhAVxQUTQG1Ty?=
 =?us-ascii?Q?92mKjA+yNLY2MPY2yB1QL7MGD1Aq2Gn0EX3mFUjgQIpszPLHgf4GkP5I1lHK?=
 =?us-ascii?Q?eWkNpJlpqd1vqMH9qNLyOaSqxpCXUvT6fJ52DoJGPfPRaLrhsbaRKhQwlSU6?=
 =?us-ascii?Q?LupauVM84RZXcGW+hBP2ywdhomx7Ls5gvmnyiKyuNsvOV5C/qrLBwQeH1MCv?=
 =?us-ascii?Q?3qK6SBcLxoghDBmuGLia4SBMFg/0jT0PZdBMMVfn9rL2bH7BcP9JYqe5q2EW?=
 =?us-ascii?Q?NsmAZN2myk289EgAIgg+7hhXL/c+Cy0fphUGoHl1a4CkiEzUmM9VYK8fvw0y?=
 =?us-ascii?Q?9r0uSYbF13B3IIyBqRThKXMWQQulKaYTcDpMUDprDtb6MmoAVYfegVdgFJqc?=
 =?us-ascii?Q?2hriHe3YrYjshXLcaKHmqlY6CazEkcNGpL941xPfSMqY8iALfCOgUCzjCkhA?=
 =?us-ascii?Q?EpkCcqPKDssY/BP0f2IN7gk78KHifNMHMVtXxrThWPbAn59KNyakucu6NeI9?=
 =?us-ascii?Q?eYjnFpzKXUgB9PBWfXEuZLRLWR3G7RSDRwugMI7wXVve2KmGcPZjPibZYbgi?=
 =?us-ascii?Q?C/UkzK3uY+PIzVq9LB4Ob0Q6GYiIyEIBaYTIgEH8ggLx5iBJHLqrnHkgQVLL?=
 =?us-ascii?Q?eRn8jZG1RJSAVV2u/Si7Z4QTVcej2oRZZg+hFC9R3WfTG9jP6T8nKUwTrqe1?=
 =?us-ascii?Q?n0GrvkKW4xs/BPLYmy37cqozeH0P/7m7IHvzs4pqkJYIE24EajJJ9LJ5Xma9?=
 =?us-ascii?Q?ern+LqVFwsB/xK2m7z7BvPXNHUOLOhtrnlgfDcdCrtNrqq0eptcEk3sYTLZu?=
 =?us-ascii?Q?8fCGl9kRLftwIO4rXpULpKZQRP88g/OEJJ9w9VwLJ/G/Srd+hvtQPwpEzC0m?=
 =?us-ascii?Q?FjwZfAFitpoVGrNBNGeM0Qf1jO9KI5Icqs79L43YytkyVhasXlcoltSd/Vn+?=
 =?us-ascii?Q?9yuB6z7lzx1ZAdTGEmDoAyNH5lITd3rqr49+mXkKaaBiHTsYYFC6eSau4QvS?=
 =?us-ascii?Q?6MaGYdUmUXen1OCDZgCE62QJAVyB4qKHQCpKsp/I+7pE7OVYXE0K1Oytd2r9?=
 =?us-ascii?Q?JW3gqfaWRT2/htYZy3eOT3pNfr9NURPIWqK536Iub2BLbX92unBkUtb7tPQN?=
 =?us-ascii?Q?lOEMUrn3R3803TTL+Vn/0kBdiyzS8PgqkRJ9W/TIFy26j8skA18xOzMWDZ/a?=
 =?us-ascii?Q?Kt02qzQ9IIbQ+dZTDbHLLcrJg+g9DZHQARrxViXKDpqy7Guw5pwG1X5aF4Rq?=
 =?us-ascii?Q?MQ17a2blAfMdZr1FT+6SVW1CN9TzG8KPrKWaDo0vxbw0M8iKU4s6HnKLf+sh?=
 =?us-ascii?Q?DxH+1OGD4JlvyCQ=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2025 15:43:33.8883 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 45dc08b8-7114-4292-255d-08dd528e7fdc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000066EB.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8821
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

This DC patchset brings iprovements in multiple areas. In summary, we have:
 
- Disable PSR-SU on eDP panels
- Fix HPD after GPU reset
- Fixes on dcn4x init, DML2 state policy on DCN36
- Various minor logic fixes
  
 
Cc: Daniel Wheeler <daniel.wheeler@amd.com>

Alex Hung (1):
  drm/amd/display: update incorrect cursor buffer size

Assadian, Navid (1):
  drm/amd/display: Fix mismatch type comparison

Aurabindo Pillai (1):
  drm/amd/display: Temporarily disable hostvm on DCN31

Charlene Liu (1):
  drm/amd/display: fix dcn4x init failed

Krunoslav Kovac (1):
  drm/amd/display: Remove unused header

Michael Strauss (1):
  drm/amd/display: Update FIXED_VS Link Rate Toggle Workaround Usage

Mike Katsnelson (1):
  drm/amd/display: stop DML2 from removing pipes based on planes

Navid Assadian (2):
  drm/amd/display: Add opp recout adjustment
  drm/amd/display: Add SPL namespace

Nicholas Kazlauskas (2):
  drm/amd/display: Apply DCN35 DML2 state policy for DCN36 too
  drm/amd/display: Increase halt timeout for DMCUB to 1s

Ostrowski, Rafal (1):
  drm/amd/display: ACPI Re-timer Programming

Patel, Swapnil (1):
  Refactor DCN4x and related code

Peichen Huang (1):
  drm/amd/display: replace dio encoder access

Roman Li (1):
  drm/amd/display: Fix HPD after gpu reset

Samson Tam (3):
  drm/amd/display: Fix mismatch type comparison in custom_float
  drm/amd/display: fix check for identity ratio
  drm/amd/display: Fix unit test failure

Taimur Hassan (2):
  drm/amd/display: [FW Promotion] Release 0.0.255.0
  drm/amd/display: Promote DAL to 3.2.322

Tom Chung (2):
  drm/amd/display: Revert "Disable PSR-SU on some OLED panel"
  drm/amd/display: Disable PSR-SU on eDP panels

Yihan Zhu (1):
  drm/amd/display: handle max_downscale_src_width fail check

Yilin Chen (1):
  drm/amd/display: add a quirk to enable eDP0 on DP1

 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |  76 +++++-
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c |  14 ++
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_psr.c |  23 +-
 .../drm/amd/display/dc/bios/command_table2.c  |  56 ++++-
 .../display/dc/bios/command_table_helper2.c   |   3 +-
 .../gpu/drm/amd/display/dc/core/dc_resource.c |   2 +-
 drivers/gpu/drm/amd/display/dc/dc.h           |   4 +-
 drivers/gpu/drm/amd/display/dc/dc_dp_types.h  |   8 +
 .../amd/display/dc/dccg/dcn20/dcn20_dccg.h    |  94 ++++----
 .../amd/display/dc/dccg/dcn401/dcn401_dccg.c  |   2 +-
 .../amd/display/dc/dccg/dcn401/dcn401_dccg.h  |   5 +-
 .../dc/dio/dcn401/dcn401_dio_stream_encoder.c |   2 +-
 .../dc/dio/dcn401/dcn401_dio_stream_encoder.h |   5 +
 drivers/gpu/drm/amd/display/dc/dm_services.h  |   7 +
 .../drm/amd/display/dc/dm_services_types.h    |  26 +++
 .../dml2/dml21/src/dml2_core/dml2_core_dcn4.c |   2 +-
 .../display/dc/dml2/dml2_dc_resource_mgmt.c   |  26 ---
 .../display/dc/dml2/dml2_translation_helper.c |   1 +
 .../drm/amd/display/dc/dml2/dml2_wrapper.c    |   3 +-
 .../drm/amd/display/dc/dpp/dcn30/dcn30_dpp.c  |  11 +-
 .../amd/display/dc/dpp/dcn401/dcn401_dpp.h    | 148 ++++++------
 .../dc/hpo/dcn31/dcn31_hpo_dp_link_encoder.c  |  10 +-
 .../dc/hpo/dcn31/dcn31_hpo_dp_link_encoder.h  |   6 +
 .../dc/hpo/dcn32/dcn32_hpo_dp_link_encoder.h  |   3 +
 .../drm/amd/display/dc/hwss/dce/dce_hwseq.h   |   1 +
 .../amd/display/dc/hwss/dce110/dce110_hwseq.c |   5 +-
 .../amd/display/dc/hwss/dcn20/dcn20_hwseq.c   |   5 +-
 .../amd/display/dc/hwss/dcn401/dcn401_hwseq.c |   5 +-
 drivers/gpu/drm/amd/display/dc/inc/resource.h |   5 +
 .../amd/display/dc/link/hwss/link_hwss_dio.c  |  66 +++++-
 .../hwss/link_hwss_dio_fixed_vs_pe_retimer.c  |   5 +-
 .../amd/display/dc/link/hwss/link_hwss_dpia.c |  20 +-
 .../gpu/drm/amd/display/dc/link/link_dpms.c   |  15 +-
 .../dc/link/protocols/link_dp_capability.c    |  33 ++-
 .../dc/link/protocols/link_dp_capability.h    |   1 +
 .../display/dc/link/protocols/link_dp_phy.c   |  16 +-
 .../display/dc/link/protocols/link_dp_phy.h   |   3 +-
 .../dc/link/protocols/link_dp_training.c      |  20 +-
 .../dc/link/protocols/link_dp_training.h      |   2 +
 .../protocols/link_dp_training_128b_132b.c    |   4 +-
 .../protocols/link_dp_training_128b_132b.h    |   1 +
 .../link/protocols/link_dp_training_8b_10b.c  |   5 +-
 .../link/protocols/link_dp_training_8b_10b.h  |   3 +-
 .../link/protocols/link_dp_training_auxless.c |   1 +
 .../dc/link/protocols/link_dp_training_dpia.c |   1 +
 .../link_dp_training_fixed_vs_pe_retimer.c    |   3 +-
 .../amd/display/dc/mpc/dcn401/dcn401_mpc.h    |  31 ++-
 .../amd/display/dc/optc/dcn10/dcn10_optc.h    | 221 +++++++++---------
 .../dc/resource/dcn20/dcn20_resource.c        |   5 +-
 .../dc/resource/dcn31/dcn31_resource.c        |   2 +-
 .../dc/resource/dcn401/dcn401_resource.c      |   5 +-
 drivers/gpu/drm/amd/display/dc/sspl/dc_spl.c  |  71 ++++--
 drivers/gpu/drm/amd/display/dc/sspl/dc_spl.h  |  16 +-
 .../drm/amd/display/dc/sspl/dc_spl_types.h    |  12 +-
 .../drm/amd/display/dc/sspl/spl_fixpt31_32.c  |   2 +-
 .../drm/amd/display/dc/sspl/spl_fixpt31_32.h  |   4 +-
 .../gpu/drm/amd/display/dmub/inc/dmub_cmd.h   |  76 ++++++
 .../gpu/drm/amd/display/dmub/src/dmub_dcn31.c |  15 +-
 .../gpu/drm/amd/display/dmub/src/dmub_dcn35.c |   2 +-
 59 files changed, 813 insertions(+), 406 deletions(-)

-- 
2.34.1

