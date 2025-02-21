Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E3DFC021B3
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Feb 2025 15:57:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F043910EABF;
	Fri, 21 Feb 2025 15:57:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="mJ/gxyg+";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2046.outbound.protection.outlook.com [40.107.94.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6F2FB10EABF
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Feb 2025 15:57:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XCaK+phsh68eHIyPMkt5LD5UE2bkCWv/Mk1o6zLa4k1w+jrUTPNpxPpwJeRNkPIbT5szUY0Mds5JiYDf25jmdFKo34s1u/1T/ztZfKFedt+bp0+srg3f0rFvhuO9VAvZB5tZrWztWUQj+CIQQSDStM8OCf6ekVaZz+U+9UKixEByJADV8X9ZIWLEnegMNqWOODXb5VJoCC571Kcv+Vsh7rFEf2Mh2WfUN0Zz8UfeEG/WVUDGvpXEButOqrZyXxYOzbySSRXPCaXU1eaxDtPM0yMm7sQP6ZXVbOfCdUhgs8U+5xON0YnXTWf9Ie5t+j0K4IxwSbr8vdd3pl4jWII9Nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RBp+Lx/TU/XiI/VNESlMuI8q/2MBmpMt6Kv/y6OWCAo=;
 b=tQXHrItt/MqK7gYQ4rINqUiHI1DEQVquaVQcoEyN+qpb07FUuf1EGfed+vO/ukddRf5Oc584DJR1DmEYXxKkOeMwm2gVHKpBohSl0vTIab94NvTajaXA38/EH6hX3UxZjrZNtTgmE5CJHNJWyQmLWmR6wgznBYeJItfmVxNZH0/SEES0ba+l6VKyg9yW9wOB6H143M2OQa3HrZjcF1HSHwtk2YF9YxFA7GVoixlvwR6gVhnjVXudQTQ+U4/WbUeDafz/7oRTfa7kj2lLJg/Dke/jP0pBrhuaXoLF5VUnrNBYqcZ+iZ4PEuUqQ0QwVvmsCxHPcZp7jDOSZxtt5rncfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RBp+Lx/TU/XiI/VNESlMuI8q/2MBmpMt6Kv/y6OWCAo=;
 b=mJ/gxyg+2xZSxKwGEoxjTjgLM+24mW/j+v/nUOI1K4EM4s4yhGG+74xBvNBq7Wb6Gtn99DpOPJpDG9B0UkvkrV/c2lGPztt15awk3r52O16/Y+VYCaJ4lg27tDcNDdj25N7TX5dLAFezhYMIYlJ74KN686ylIrs4HF9HR9ERS3M=
Received: from BL1PR13CA0001.namprd13.prod.outlook.com (2603:10b6:208:256::6)
 by DM6PR12MB4108.namprd12.prod.outlook.com (2603:10b6:5:220::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.18; Fri, 21 Feb
 2025 15:57:48 +0000
Received: from BN3PEPF0000B076.namprd04.prod.outlook.com
 (2603:10b6:208:256:cafe::27) by BL1PR13CA0001.outlook.office365.com
 (2603:10b6:208:256::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8466.16 via Frontend Transport; Fri,
 21 Feb 2025 15:57:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B076.mail.protection.outlook.com (10.167.243.121) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8466.11 via Frontend Transport; Fri, 21 Feb 2025 15:57:47 +0000
Received: from mkmmarleung05.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 21 Feb
 2025 09:57:42 -0600
From: Zaeem Mohamed <zaeem.mohamed@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Zaeem Mohamed <zaeem.mohamed@amd.com>, Solomon Chiu
 <solomon.chiu@amd.com>, Daniel Wheeler <daniel.wheeler@amd.com>, Alex Hung
 <alex.hung@amd.com>
Subject: [PATCH 00/24] DC Patches FEBRUARY 18, 2025 V2
Date: Fri, 21 Feb 2025 10:56:57 -0500
Message-ID: <20250221155721.1727682-1-zaeem.mohamed@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B076:EE_|DM6PR12MB4108:EE_
X-MS-Office365-Filtering-Correlation-Id: b74ceb9c-0f5d-46f9-a348-08dd52907c98
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?fAcEP/u9nGDuHGhNxB6PzmZuDcND/PR2QRcauDO1ID3VKeko6a/HJom7PKxH?=
 =?us-ascii?Q?ApEm0FO7SF8RdZhjDORCkLMpbpWY0n56t5NYoMojRj/HVfin3A6HRKeJwyq6?=
 =?us-ascii?Q?m9WUa4CxIa5vjigpuQoTv6/Vu3lRT5xZlj117xEdl0pENmKF5poOEqp9QsYG?=
 =?us-ascii?Q?dRXS0uE2seOugdBJ3MptmZW03FqWYykY14L9JCkiWGobKAXLwshUGwe1LR8e?=
 =?us-ascii?Q?YyzhBvPn3lDiqX7SkDCK81qP9TemMrsDj5gZJfzhzQrr9LA03+Ti9S6OxLSc?=
 =?us-ascii?Q?uPfq1Vqf6dUF9HH5fFranle9e4SixnZsEOIR05D/4Ixs7qm81+bx4GmeGEWc?=
 =?us-ascii?Q?Z2i17uBLxR27zzKxOxZ1NAOgBMmcvpqQndcgHZuBISgZvHG342+sbMPHqGfr?=
 =?us-ascii?Q?9QsTF8L9pR/5FI9Wpu4LBR2MpX9mbFO0MvCs1BWKXWdlgsR9aEah8IaaELGX?=
 =?us-ascii?Q?345XKap8xSZwN+us5YWxeNIj6ZpQ5jPTdeOJm3TsxP7sW3YGQEpa92VCWclM?=
 =?us-ascii?Q?vxeTIY6CCLXDAYWjcyzIdnmw/OSVdZ5Gec5Xigj5wIF95dwkSb0dEYCfezlb?=
 =?us-ascii?Q?PjpBX2GXwMPrMI6OfPXFJBZl2DsueKcwvkAVS14nx50u4a4XT0xm1DwPfII2?=
 =?us-ascii?Q?kpYLsppnCnRDkmFBA+D8faoMiIGX+3p/fsx1iQKT0ZH7ZMsehTeHsPakMze2?=
 =?us-ascii?Q?+lwhSzkChWzdDd0xGSn9vZfdhy59YqABJQPSAx6PPYh8xaE2FD386jFn5++Z?=
 =?us-ascii?Q?vT5PHD1wrfhF+/Q/Swp/wF6UbAzctlYNNCtIBPuKRFFVp3yjc3hbm5rKM9e3?=
 =?us-ascii?Q?ZHKcsH2G58MqXyhNVeEDUD6t00ZD4YfO70xd7A5DjtSQFSqpvBk3SwJl88z8?=
 =?us-ascii?Q?ysv2o+zZQjKTAOwlcb9ukyME8UMBOg69yG4C1ZQNSbTb39q/Gr6GXYxDDzA7?=
 =?us-ascii?Q?H0ywkjI88YlcJ+5QxlR/dSSU1VJanfLS8N6eEFeqSkPNagJUeT7KmM7+0dpd?=
 =?us-ascii?Q?sJof9ipHPebOiKnTwMnpMQfeSsmcgMW8ROL49CfPnixF1/njO8qrLNwduNvd?=
 =?us-ascii?Q?wLLgMl5aZPKCVOlNQqpjUqrpdsm5rdCHe2jv1/7xFhdYi3dNZMnQr68ANDjk?=
 =?us-ascii?Q?ZfAXLDUe3nMHe9bMLGwC2NhwShKH4knkrknJ2An4PxUBhlmLn0DoyqAkayCy?=
 =?us-ascii?Q?Go5KdN0ggPXcwAyZEAc7PEBJrO1Bp6be0x/us02T8WyGv4POEH47n7Qp0kBj?=
 =?us-ascii?Q?vziwc0aS0dSssp9JEIEdMkCDQ1J2GtU9smgjBotw2zYhFkQ2wowk4PxkywMe?=
 =?us-ascii?Q?YdDAkQ0Dbq8g/r3KvIy3It7yCy4GN1YUIFoR0JhPQGQ1ShnBaYWn+sVfFINp?=
 =?us-ascii?Q?BCfSMOL0jck3poc6Zylz0hg1LO3mrqTP+EkbWTpFN8siiKdlb5XgNHYpIUWt?=
 =?us-ascii?Q?2Sxb6OYdqsDSU3J3GPD1oRJztNhp79BgDt3M0sT72YJkB+ucTJdgPnRh9WA5?=
 =?us-ascii?Q?IOhdzETlMI78mI8=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2025 15:57:47.4843 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b74ceb9c-0f5d-46f9-a348-08dd52907c98
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B076.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4108
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
  drm/amd/display: Refactor DCN4x and related code

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

