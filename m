Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E034E9E31B
	for <amd-gfx@archiver.kernel.org>; Thu, 12 Feb 2026 01:10:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CA40710E6AE;
	Thu, 12 Feb 2026 01:10:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="5SfTyNUO";
	dkim-atps=neutral
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013043.outbound.protection.outlook.com
 [40.93.196.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3D52210E15A
 for <amd-gfx@lists.freedesktop.org>; Thu, 12 Feb 2026 01:10:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=a6UiaDvmPV6lHHiF8zhpGdMJrKOsEFjZyhVCczxi/XXqWXldiqLnMKu9JFePkzZRBOo2sekm3Cl9QtMyGq2U8BqrNHEVI1NeBJCsn2Lio5Ss9OxH722Wm0ZoagB3QHYIFmiOqiIGNyDoYFyFyv9XAgLLc67Tu/AYTJ4qN2AovkOYUYb9mg8eps6kuHBIDqEn9om1LHVijTf9RjXLKSTSdrhvuZ6yWPu0oFiO2+idWFS/UWLdRzn6w00+3599Qu5Yh86aVoJhHKvSYpJeLUCapJK+ZVAPHmUHX4Ttm8qJ4D0/MF0o/R+gccivMsb81nikvXK5TMpbgzYOkts6YLN/9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LzfU+puhI+wPvmAQ1CPfCsCEw7PnSfX038mcy68Bdp8=;
 b=NjgqZaaXP6PuXoFen2XdRqLn+5TUX5nhddMg2xgHOvjiL9ZX6leC/wONtRF/Xa4QrcGGHhRhmOcAFgPqdp9oKj9W8wsOx473rUsejb1LvX007Jf8ZkWQwYAyTCdqWDK07iJaKUPn4JzqIXy4ohJc264e74cRlDX0SbbkdM9D+O1TVQtDz51wxLgKtY+4xbE2m6UzQ6wShIzF+eylPOoIeulvDbbcjlR+oEuL2jQc2JCICSElR0volZaxXj2bwM7AnFzNXKns5v4U7FXZhrUVYARZNDs4XkM5wTBrBl1XazK9OROUrPCtX521whvYmoJwtfSMq3Xn0zO/tx0We638dA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LzfU+puhI+wPvmAQ1CPfCsCEw7PnSfX038mcy68Bdp8=;
 b=5SfTyNUOidBZfCsTzAoRbsm1zCiNExZdE5Ug+EK3C6aG2UfNz+bI6eh1RcE2io0VpRLdnfl2NcJZ9dUq6I8p9zpv1NU4uomiXYaLVww29W0CgvuCjGmObKPcey7wlN0C35dybSA1HDCsF5omg8xuFdIOQFK8NsdwHSidVcjq+n4=
Received: from CH0PR04CA0026.namprd04.prod.outlook.com (2603:10b6:610:76::31)
 by SJ5PPF0C60B25BF.namprd12.prod.outlook.com
 (2603:10b6:a0f:fc02::98a) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.18; Thu, 12 Feb
 2026 01:09:54 +0000
Received: from CH3PEPF00000013.namprd21.prod.outlook.com
 (2603:10b6:610:76:cafe::76) by CH0PR04CA0026.outlook.office365.com
 (2603:10b6:610:76::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9611.10 via Frontend Transport; Thu,
 12 Feb 2026 01:09:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CH3PEPF00000013.mail.protection.outlook.com (10.167.244.118) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.0 via Frontend Transport; Thu, 12 Feb 2026 01:09:53 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 11 Feb
 2026 19:09:53 -0600
Received: from roman-vdev.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Wed, 11 Feb 2026 19:09:53 -0600
From: <Roman.Li@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>, Harry Wentland
 <harry.wentland@amd.com>, Pratik Vishwakarma <Pratik.Vishwakarma@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Ivan Lipski
 <ivan.lipski@amd.com>, Alex Hung <alex.hung@amd.com>, Roman Li
 <Roman.Li@amd.com>
Subject: [PATCH 0/7] Patch set to support dcn42
Date: Wed, 11 Feb 2026 20:09:42 -0500
Message-ID: <20260212010949.654686-1-Roman.Li@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF00000013:EE_|SJ5PPF0C60B25BF:EE_
X-MS-Office365-Filtering-Correlation-Id: 02c0de03-a731-418c-aa07-08de69d36e03
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?R6VJTmTrbx98akyULt4n+jTWWV/usdAWVWejovOC/y5ovYaQhOjxlOAvce9F?=
 =?us-ascii?Q?7Po7e/THq4O3tOt5LEgtLuWZfnamHFrjEwi6llF+QCukIBF0cL5++HFDVVkJ?=
 =?us-ascii?Q?15IFqfvYSMydVPr1Ex8LQf/M9GpnUM+PfaVb5+vfkPyiQToGdi1RcuKU2Cj0?=
 =?us-ascii?Q?pAoZrldp9xj0VfAsktnBAgUgWA6VmYaYsoTjXkKY0GFcR2snJDmpKW7S5rdy?=
 =?us-ascii?Q?FZiqIfktyILr4hBAAG4184RTjh63wXl16wXJTpS0YOwwEU4ODbk0HDY+55nT?=
 =?us-ascii?Q?pOoyWR//fCqaPAnOP+mWlw8Lt6vsB3jMknBI+yusgQK8zr82jHWosu2XjMmC?=
 =?us-ascii?Q?CabGrHMunGdlKQkjqf79go9TNsXsqFLwigvBzfGJYmBL9qP9dsN0JNOEhaYm?=
 =?us-ascii?Q?+l5S24bS30MB92kBoI61txmeBAoe6U7CMO6aH5m7503tk2+CmQzLBfT4g1oK?=
 =?us-ascii?Q?xOZfdL2/aMGmNVzETGKDMoSKT4LQEqPBrDe3LHMSdWUCxND1aBYS1UlJ4Ubs?=
 =?us-ascii?Q?E3B5A46yKF1+T49xOnxj2WoXoW7RNsGS2CU+Uw+N18IrcrPQbc77WiN7HWT4?=
 =?us-ascii?Q?VWUV3fgNMk2WGPiVhVbk33TJUXEh3du0hna4dNKSO2aKCemjFotHeiycj9IX?=
 =?us-ascii?Q?5unLkCoogFPHKPWnuu9deK+rXTW9qyZ18PClqetsEiSngiSGktcIBE7FYru4?=
 =?us-ascii?Q?hpvrCee9yGZYRBkudBjJvL0wzGRaF/aYGHphO0RZFmb/1LBJ7SpT60Ca+Hei?=
 =?us-ascii?Q?xKfahVICnG+PCvmrJygDvImazAqmIfeHA7LZLEEex0J8r6t+yVLUch3QzXT9?=
 =?us-ascii?Q?20U+cLOaJGSe5C3T1ATGLPaRazjqnRn9YiJB6W/+/BcN95yc5PCS72y3HBdu?=
 =?us-ascii?Q?Sirvtyn4EZbOy5zTt9ik4lkVMIPA0pDQKcxpxIEM0BOzEM4ZvDwKjgT2k2dV?=
 =?us-ascii?Q?0Mx02/N4PwPE6r84nZrBzBgam8XPT86n4cZ7TrY+IGRMre18lUsnHtOXJOvG?=
 =?us-ascii?Q?g8kZxyrthKqnpTqOR3/qEDYtpjOflkLnKXfTIisNglbZVkQvt4N+daIxxE3F?=
 =?us-ascii?Q?li7lO99Utx984vHqTKEk3ZM/bq8SiMkd6Th5ID+H/vNUa6ApRVXKPxkLUuaN?=
 =?us-ascii?Q?jcvX5Ao1JjFtNHZFShYdFyMpUx10HjbNdgUVeJigKJoVVJvnbHnW6SqXDoXZ?=
 =?us-ascii?Q?ZZfj/80Iru2tWBQp6ulUNVnH5FUMVR6Ede730WCrIxgENQhl0w8W5GO4DAIu?=
 =?us-ascii?Q?tpBT8ghswjqXmzpNzz6VEVKQImTDE1UjOq65MGvva+N2gRBzibYyP2joB1Qm?=
 =?us-ascii?Q?jlzQ+uXeJELd3RH/jxb0MOmCgg+rpy+1ALplC7IOKlHTIEGTbuys2YwoZnDi?=
 =?us-ascii?Q?/6lqlBopTCEG2Rfl036rM6y2ESP9Q22xpfSbr2XcGHuVbc/IqmEfV1yE9BR2?=
 =?us-ascii?Q?bi4xEUfYctoJaVWMaZwCW+3csEFBh67KXJNL/KA7wp8Cq3IjbX6L1L22nU8O?=
 =?us-ascii?Q?KTthBphCAbgqx/88qEpQ5QFUk8+UhWRsSC1ucg/yDz0sB2qcNWRgI3gyAb+4?=
 =?us-ascii?Q?cg9m1HXmS8NniMdPCoWuXKRb0BksykkmVwaUIQF3Iuj7gleen01rL6TtupTa?=
 =?us-ascii?Q?b7sb4PBoszMgRaQihhYr41mS4Nbn0Ju0mU0Szzr36AjddSZRzOmCG6Xo0Yl8?=
 =?us-ascii?Q?R3nGMw=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: sLeGOpPz/dPy+Z+bavwfZPETl7o1TleHIgBvjSip8JXQlBoOwTseb/16jNqagscqRHLrawl5ke6dqQl9HhUp3PMfBRTbAIubRSHQvmkrc0kmUzunC03v5CBOraLpVR1hfzuIRdOeO1ODcQTx3y9fRSyEs9EYuOpTT6K1LSGi0eS+EX2KaWJ9dnYQe81p3CrOT1C8WlB8gc30/IBFG1GpCSPcw2SNXkRFI7GwgYtM3Jx8azluaOUkgIi4++nmXgMcj7KkYTd2GdkACQddwh9AMfODmnruRAtvhocBn7nV+cxWCqtjLppZ3A6704ZgMJ2/DixHY3Lo8VQOr+fuv145Qea6b93+0mAAAKuYVSCyVW5+hYEDdXo+ubEr8E+QywZ3Ua5vGPi7MRACuk8WhXPg96zRvlrtkDN70B3y0k0vWiOM2MrWySD/kRpy00GPriF3
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Feb 2026 01:09:53.7626 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 02c0de03-a731-418c-aa07-08de69d36e03
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF00000013.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF0C60B25BF
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

From: Roman Li <Roman.Li@amd.com>

This series adds initial support for DCN 4.2.

Roman Li (7):
  drm/amd/display: Add dcn42 version identifiers
  drm/amd/display: Add dcn42 register headers
  drm/amd/display: Add dcn42 DC resources
  drm/amd/display: Add DMUB support for dcn42
  drm/amd/display: Enable dcn42 DMUB
  drm/amd/display: Enable dcn42 DC
  drm/amd/display: Enable dcn42 in DM

 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |    41 +-
 .../amd/display/amdgpu_dm/amdgpu_dm_plane.c   |     3 +-
 .../display/dc/bios/command_table_helper2.c   |     1 +
 .../gpu/drm/amd/display/dc/clk_mgr/Makefile   |    11 +-
 .../display/dc/clk_mgr/dcn42/dcn42_clk_mgr.c  |  1152 +
 .../display/dc/clk_mgr/dcn42/dcn42_clk_mgr.h  |    79 +
 .../amd/display/dc/clk_mgr/dcn42/dcn42_smu.c  |   431 +
 .../amd/display/dc/clk_mgr/dcn42/dcn42_smu.h  |   190 +
 .../drm/amd/display/dc/core/dc_hw_sequencer.c |    39 +-
 .../gpu/drm/amd/display/dc/core/dc_resource.c |     7 +
 drivers/gpu/drm/amd/display/dc/dc.h           |    10 +-
 drivers/gpu/drm/amd/display/dc/dc_helper.c    |     2 +
 drivers/gpu/drm/amd/display/dc/dc_hw_types.h  |    73 +
 drivers/gpu/drm/amd/display/dc/dc_types.h     |     6 +-
 drivers/gpu/drm/amd/display/dc/dccg/Makefile  |    11 +-
 .../amd/display/dc/dccg/dcn20/dcn20_dccg.h    |    15 +-
 .../amd/display/dc/dccg/dcn42/dcn42_dccg.c    |   278 +
 .../amd/display/dc/dccg/dcn42/dcn42_dccg.h    |   263 +
 drivers/gpu/drm/amd/display/dc/dce/dce_abm.h  |    60 +-
 drivers/gpu/drm/amd/display/dc/dio/Makefile   |    11 +-
 .../dc/dio/dcn10/dcn10_stream_encoder.h       |    10 +-
 .../dc/dio/dcn42/dcn42_dio_link_encoder.c     |   205 +
 .../dc/dio/dcn42/dcn42_dio_link_encoder.h     |   140 +
 .../dc/dio/dcn42/dcn42_dio_stream_encoder.c   |   522 +
 .../dc/dio/dcn42/dcn42_dio_stream_encoder.h   |   206 +
 drivers/gpu/drm/amd/display/dc/dpp/Makefile   |    10 +-
 .../amd/display/dc/dpp/dcn401/dcn401_dpp.h    |     5 +-
 .../drm/amd/display/dc/dpp/dcn42/dcn42_dpp.c  |   338 +
 .../drm/amd/display/dc/dpp/dcn42/dcn42_dpp.h  |   469 +
 drivers/gpu/drm/amd/display/dc/gpio/Makefile  |    13 +-
 .../display/dc/gpio/dcn42/hw_factory_dcn42.c  |   254 +
 .../display/dc/gpio/dcn42/hw_factory_dcn42.h  |    31 +
 .../dc/gpio/dcn42/hw_translate_dcn42.c        |   205 +
 .../dc/gpio/dcn42/hw_translate_dcn42.h        |    36 +
 .../gpu/drm/amd/display/dc/gpio/hw_factory.c  |     4 +
 .../drm/amd/display/dc/gpio/hw_translate.c    |     4 +
 drivers/gpu/drm/amd/display/dc/hpo/Makefile   |    11 +-
 .../hpo/dcn31/dcn31_hpo_dp_stream_encoder.h   |    10 +-
 .../dc/hpo/dcn42/dcn42_hpo_dp_link_encoder.c  |    93 +
 .../dc/hpo/dcn42/dcn42_hpo_dp_link_encoder.h  |    17 +
 .../gpu/drm/amd/display/dc/hubbub/Makefile    |    10 +-
 .../display/dc/hubbub/dcn10/dcn10_hubbub.h    |     6 +-
 .../display/dc/hubbub/dcn42/dcn42_hubbub.c    |   539 +
 .../display/dc/hubbub/dcn42/dcn42_hubbub.h    |   268 +
 drivers/gpu/drm/amd/display/dc/hubp/Makefile  |    10 +-
 .../amd/display/dc/hubp/dcn20/dcn20_hubp.h    |     8 +-
 .../amd/display/dc/hubp/dcn42/dcn42_hubp.c    |   643 +
 .../amd/display/dc/hubp/dcn42/dcn42_hubp.h    |    79 +
 drivers/gpu/drm/amd/display/dc/hwss/Makefile  |    12 +-
 .../drm/amd/display/dc/hwss/dce/dce_hwseq.h   |    13 +-
 .../amd/display/dc/hwss/dcn42/dcn42_hwseq.c   |  1476 +
 .../amd/display/dc/hwss/dcn42/dcn42_hwseq.h   |    53 +
 .../amd/display/dc/hwss/dcn42/dcn42_init.c    |   167 +
 .../amd/display/dc/hwss/dcn42/dcn42_init.h    |    11 +
 .../drm/amd/display/dc/hwss/hw_sequencer.h    |    17 +-
 .../display/dc/hwss/hw_sequencer_private.h    |     5 +-
 .../gpu/drm/amd/display/dc/inc/hw/clk_mgr.h   |    24 +-
 .../amd/display/dc/inc/hw/clk_mgr_internal.h  |    42 +-
 drivers/gpu/drm/amd/display/dc/inc/hw/dpp.h   |    10 +-
 drivers/gpu/drm/amd/display/dc/inc/hw/mpc.h   |    20 +-
 .../amd/display/dc/inc/hw/timing_generator.h  |     4 +-
 drivers/gpu/drm/amd/display/dc/irq/Makefile   |     9 +
 .../display/dc/irq/dcn42/irq_service_dcn42.c  |   412 +
 .../display/dc/irq/dcn42/irq_service_dcn42.h  |    15 +
 .../gpu/drm/amd/display/dc/mmhubbub/Makefile  |    10 +-
 .../dc/mmhubbub/dcn42/dcn42_mmhubbub.c        |    25 +
 .../dc/mmhubbub/dcn42/dcn42_mmhubbub.h        |    13 +
 drivers/gpu/drm/amd/display/dc/mpc/Makefile   |    10 +-
 .../amd/display/dc/mpc/dcn401/dcn401_mpc.c    |    13 +-
 .../amd/display/dc/mpc/dcn401/dcn401_mpc.h    |    10 +-
 .../drm/amd/display/dc/mpc/dcn42/dcn42_mpc.c  |  1121 +
 .../drm/amd/display/dc/mpc/dcn42/dcn42_mpc.h  |  1006 +
 drivers/gpu/drm/amd/display/dc/optc/Makefile  |    10 +-
 .../amd/display/dc/optc/dcn10/dcn10_optc.h    |    20 +-
 .../amd/display/dc/optc/dcn42/dcn42_optc.c    |   198 +
 .../amd/display/dc/optc/dcn42/dcn42_optc.h    |   211 +
 drivers/gpu/drm/amd/display/dc/pg/Makefile    |    10 +-
 .../amd/display/dc/pg/dcn42/dcn42_pg_cntl.c   |   648 +
 .../amd/display/dc/pg/dcn42/dcn42_pg_cntl.h   |   175 +
 .../gpu/drm/amd/display/dc/resource/Makefile  |    18 +
 .../dc/resource/dcn42/dcn42_resource.c        |  2337 +
 .../dc/resource/dcn42/dcn42_resource.h        |   588 +
 .../dc/resource/dcn42/dcn42_resource_fpu.c    |    47 +
 .../dc/resource/dcn42/dcn42_resource_fpu.h    |    33 +
 drivers/gpu/drm/amd/display/dmub/dmub_srv.h   |     5 +-
 drivers/gpu/drm/amd/display/dmub/src/Makefile |     3 +-
 .../gpu/drm/amd/display/dmub/src/dmub_dcn42.c |   752 +
 .../gpu/drm/amd/display/dmub/src/dmub_dcn42.h |   171 +
 .../gpu/drm/amd/display/dmub/src/dmub_srv.c   |    64 +-
 .../gpu/drm/amd/display/include/dal_asic_id.h |     1 +
 .../gpu/drm/amd/display/include/dal_types.h   |     1 +
 .../include/asic_reg/dcn/dcn_4_2_0_offset.h   | 17872 ++++
 .../include/asic_reg/dcn/dcn_4_2_0_sh_mask.h  | 67277 ++++++++++++++++
 .../include/asic_reg/dpcs/dpcs_4_0_0_offset.h |   142 +
 .../asic_reg/dpcs/dpcs_4_0_0_sh_mask.h        |   688 +
 95 files changed, 102551 insertions(+), 47 deletions(-)
 create mode 100644 drivers/gpu/drm/amd/display/dc/clk_mgr/dcn42/dcn42_clk_mgr.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/clk_mgr/dcn42/dcn42_clk_mgr.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/clk_mgr/dcn42/dcn42_smu.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/clk_mgr/dcn42/dcn42_smu.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/dccg/dcn42/dcn42_dccg.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/dccg/dcn42/dcn42_dccg.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/dio/dcn42/dcn42_dio_link_encoder.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/dio/dcn42/dcn42_dio_link_encoder.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/dio/dcn42/dcn42_dio_stream_encoder.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/dio/dcn42/dcn42_dio_stream_encoder.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/dpp/dcn42/dcn42_dpp.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/dpp/dcn42/dcn42_dpp.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/gpio/dcn42/hw_factory_dcn42.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/gpio/dcn42/hw_factory_dcn42.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/gpio/dcn42/hw_translate_dcn42.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/gpio/dcn42/hw_translate_dcn42.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/hpo/dcn42/dcn42_hpo_dp_link_encoder.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/hpo/dcn42/dcn42_hpo_dp_link_encoder.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/hubbub/dcn42/dcn42_hubbub.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/hubbub/dcn42/dcn42_hubbub.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/hubp/dcn42/dcn42_hubp.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/hubp/dcn42/dcn42_hubp.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/hwss/dcn42/dcn42_hwseq.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/hwss/dcn42/dcn42_hwseq.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/hwss/dcn42/dcn42_init.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/hwss/dcn42/dcn42_init.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/irq/dcn42/irq_service_dcn42.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/irq/dcn42/irq_service_dcn42.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/mmhubbub/dcn42/dcn42_mmhubbub.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/mmhubbub/dcn42/dcn42_mmhubbub.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/mpc/dcn42/dcn42_mpc.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/mpc/dcn42/dcn42_mpc.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/optc/dcn42/dcn42_optc.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/optc/dcn42/dcn42_optc.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/pg/dcn42/dcn42_pg_cntl.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/pg/dcn42/dcn42_pg_cntl.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/resource/dcn42/dcn42_resource.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/resource/dcn42/dcn42_resource.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/resource/dcn42/dcn42_resource_fpu.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/resource/dcn42/dcn42_resource_fpu.h
 create mode 100644 drivers/gpu/drm/amd/display/dmub/src/dmub_dcn42.c
 create mode 100644 drivers/gpu/drm/amd/display/dmub/src/dmub_dcn42.h
 create mode 100644 drivers/gpu/drm/amd/include/asic_reg/dcn/dcn_4_2_0_offset.h
 create mode 100644 drivers/gpu/drm/amd/include/asic_reg/dcn/dcn_4_2_0_sh_mask.h
 create mode 100644 drivers/gpu/drm/amd/include/asic_reg/dpcs/dpcs_4_0_0_offset.h
 create mode 100644 drivers/gpu/drm/amd/include/asic_reg/dpcs/dpcs_4_0_0_sh_mask.h

-- 
2.34.1

