Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A63D4CA101F
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Sep 2025 05:33:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3E76810E850;
	Wed, 10 Sep 2025 05:33:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="vct6etb3";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2061.outbound.protection.outlook.com [40.107.243.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 31A7A10E850
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 Sep 2025 05:33:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=f7ILdQJ2bLqY2kYW2HmF04r0IJiV4g/Ah3fI8+PfX7nHdK4fIcg8yQ7W7rBvGZoCvgvL1O1SBkBR5RZmz2KDvrWwZnS+U0R8ssnauUdwpHjH7LlNySRHrIVjnwpPdphviJmoV3jn63R2kKFW0VgJutAWxLfd91akKaYhpH+p/6KeD3pGgEs9NDvaS8xbJExtf/97CzW5SKUeGT933SvaPaA71p/VrBtVPL+EesTD/S8UtTefnIN4sqTldQOC72mv2FfPiyfhLlusRUGofeM7UwnwVIW/MWac6BlY6D+BE2gzylGVtD9Aq1Gx3Y8A/JJsut1ujedTX6heFMAvVt4/DQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hZRqntKMoJ0nG/CpAJp8n05+dXPCZcoI7J4F0fow9fo=;
 b=ni6Yiy6nIPVJyGrrknGLOcTHBNLzu3SKa1404U5CXT6qa1oSrhbUqDjurIkx461ZjTm5/DpqXavxa4TrLUz741i/mytM7NU/hhVhtbnwf48mW8+dqlhvBxx5M0AaGJh9LIN7XPsiuoBW0innZhymQE2l6kO2OnWAGLDjYpALONRXYCRl4oZGsLi/BKyaLQGP7ToX5JiiSusOfL+jF/3TPDo9X8uKM/fZ25vUCtdWf1VwPnj6BdXBwI7ZD9qtt1olIH82XCMMfUmxXZlpcXMtWaLz0kSbrCbSKfjzxmtkpK6mTAMKCvpCuF5REQOIUzG4n16poXh9ReMyYnkINaH6aA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hZRqntKMoJ0nG/CpAJp8n05+dXPCZcoI7J4F0fow9fo=;
 b=vct6etb3vSW208d7TOvDnASKupSsKXFHP/VrE7kYPdjjTm//kOLBdYKCEBsmRzcbF1wNS/MUVidBOn/B1zhhALO2620qbVFsSE4oX6Poxe5+kV+MenRu/3rBjs9xvRTSZbzf4wjKgjwfAB6V8WsZJMVoDQjpVKkW+xnJToBCpXE=
Received: from CH0PR04CA0067.namprd04.prod.outlook.com (2603:10b6:610:74::12)
 by LV3PR12MB9260.namprd12.prod.outlook.com (2603:10b6:408:1b4::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Wed, 10 Sep
 2025 05:33:02 +0000
Received: from DS3PEPF0000C37F.namprd04.prod.outlook.com
 (2603:10b6:610:74:cafe::14) by CH0PR04CA0067.outlook.office365.com
 (2603:10b6:610:74::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9115.16 via Frontend Transport; Wed,
 10 Sep 2025 05:33:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 DS3PEPF0000C37F.mail.protection.outlook.com (10.167.23.9) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9115.13 via Frontend Transport; Wed, 10 Sep 2025 05:33:01 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 9 Sep
 2025 22:33:00 -0700
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 9 Sep
 2025 22:33:00 -0700
Received: from ray-Ubuntu.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Tue, 9 Sep 2025 22:32:57 -0700
From: Ray Wu <ray.wu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Zaeem Mohamed <zaeem.mohamed@amd.com>, "Daniel
 Wheeler" <daniel.wheeler@amd.com>, Alex Hung <alex.hung@amd.com>, "Wesley
 Chalmers" <Wesley.Chalmers@amd.com>, Alvin Lee <alvin.lee2@amd.com>, Ray Wu
 <ray.wu@amd.com>
Subject: [PATCH 04/15] drm/amd/display: Rename header file link.h to
 link_service.h
Date: Wed, 10 Sep 2025 13:30:27 +0800
Message-ID: <20250910053222.2884632-5-ray.wu@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250910053222.2884632-1-ray.wu@amd.com>
References: <20250910053222.2884632-1-ray.wu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF0000C37F:EE_|LV3PR12MB9260:EE_
X-MS-Office365-Filtering-Correlation-Id: 03bf28f0-365e-4d54-5461-08ddf02b8223
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?yp3/RDnXpN85EkVfDWDJIRsoFl6RuDtl/OJhYHClu73LQoi8Z25ZYgVqXb0i?=
 =?us-ascii?Q?jJL2BLkE/so0udLnI6AgpKtdbbHM1Ff9f8J94/lcsBkTpSIYbjc191aV18i2?=
 =?us-ascii?Q?Gvsrj/J+TRbNSWkCpNmZalxxNC0zPfd2ggmdlAL4P2jlX5t6Qx1i6bem9M8Q?=
 =?us-ascii?Q?0p7QFhCHvAQfasW0tgY347mjlg8G4MkmSoFSlozNaquAJ2xWbayVZF10qNbh?=
 =?us-ascii?Q?LUMEIed+/Y93WGwgeiBj8/0g2io66vdKr/8sM014InQDKX1Hr861VjYEjol6?=
 =?us-ascii?Q?vN25wEN/rLlqHkdNqXuvvHoH2q/ZCU/QCuYeL0+Gke7q3EDhuxu9LNwRlJdf?=
 =?us-ascii?Q?W5hs+wjDoETpeAg15X8YHlDfWnNEn1NhkqN5+UEvjDSqwxLcHh0IJ2dqYSG/?=
 =?us-ascii?Q?mLU7y1eCr8DHBx6rSU0b30sQ8ugcCPmLO1shXaV9FsMOJVEcuJsSnBfZa/AQ?=
 =?us-ascii?Q?5LkkuOQdI04ttWW4oHNCcdcj6o8pR69+xLVvUX1ED4B4AYNC/4QTPLkP/9zO?=
 =?us-ascii?Q?WOVBVx4Ybvy6EY3F3t1MyuMD8MOgOKielqi3Epih/03AWI3meF7T3KyvXebA?=
 =?us-ascii?Q?2sGhZNi5kEII6Of3i09IyxT5p+/qyzEFqQ9t9h8+/LpV9dOYhOf8aXhe2lDj?=
 =?us-ascii?Q?mAEVAqd0/zBKVPb4E6tsyGgzxXXP/6LiGuGYF9m5YNu27PdJCzvdjk07sMff?=
 =?us-ascii?Q?KAuZVmwzWKsJwgzhi+YwF1hRTdhyAEzRc0u+0anjSXISx2mL0H7KcF+r8iWA?=
 =?us-ascii?Q?/cnOh6ysaChBzF4mUw9KPdXKfGp83/A9uQrBsGU0YFyIXNeV7vPqnnvaY69f?=
 =?us-ascii?Q?6y33ip1O5ywRbJM4dbhylCTCasVZ5xmSiN3jK1kYJ8Lwxay7jKG5mfpSZ2ak?=
 =?us-ascii?Q?Y4GWrWN9AH2utOatAbetBPXJU/QQjSyFYAI/OQ45qmgWcV7CNSR61eUUX2rX?=
 =?us-ascii?Q?5iwH0doPNQuNOJm7EXmgiHuY+AV0TX6I0kNoUGzpiZvQRRykh4HkE2+i3tjF?=
 =?us-ascii?Q?zand0uinASsbo2le5BBM8s3kA+MarVVh/aA/LvQLLtIRq3BQ5RKWCPCXTzjW?=
 =?us-ascii?Q?xwMcpbw3h6RUASFRL02cHICYnPhJ0DVZVmjaWyHUw2GuB06xihREoQCDQmsB?=
 =?us-ascii?Q?Nn3QBMoj+Qk8SQmo6WWGR/gV/XoOeE5GCfT8apcOHxx4+i+tyRZxcFVnoi0V?=
 =?us-ascii?Q?aHSuKt38tQBqDjidX6s3pfI0UbaIjV/Pfd4CUxd8TVHaeiLFXDS4JVQXh7Gu?=
 =?us-ascii?Q?suPuZ253xFaRDAkRYWvzVnWaIKkV0+Il6HtnUDKE47pPokFaAb/sD5s8zCZy?=
 =?us-ascii?Q?RslIoUSSOlAYL+xBKC8SGO+VQ4INRRPekf+oPHSR/fT0uxH0LMS5YITT3VxC?=
 =?us-ascii?Q?uizjAcfp+Hk9qzTKoD86E5RR/R4ZNl1u8WLVK6ohdTjNiYp1vLyzYMhx/sOp?=
 =?us-ascii?Q?KSeD1LN9HXq2jNOpcIAPfwB/kaVr/7LGkXg04Tt1NNDmIezTEw7lvwAzl+Zo?=
 =?us-ascii?Q?wd6c2Vbf74VFb3rG3h8YwT/GdiyCBFx9EkdN?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2025 05:33:01.3278 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 03bf28f0-365e-4d54-5461-08ddf02b8223
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF0000C37F.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9260
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

From: Wesley Chalmers <Wesley.Chalmers@amd.com>

[WHY]
Header file name "link.h" collides with system header when dc is
compiled as a user-mode library

[WHAT]
Rename link.h to link_service.h to avoid name collision

Reviewed-by: Alvin Lee <alvin.lee2@amd.com>
Signed-off-by: Wesley Chalmers <Wesley.Chalmers@amd.com>
Signed-off-by: Ray Wu <ray.wu@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_replay.c    | 2 +-
 drivers/gpu/drm/amd/display/dc/clk_mgr/clk_mgr.c            | 2 +-
 .../gpu/drm/amd/display/dc/clk_mgr/dcn31/dcn31_clk_mgr.c    | 2 +-
 .../gpu/drm/amd/display/dc/clk_mgr/dcn314/dcn314_clk_mgr.c  | 2 +-
 .../gpu/drm/amd/display/dc/clk_mgr/dcn315/dcn315_clk_mgr.c  | 2 +-
 .../gpu/drm/amd/display/dc/clk_mgr/dcn316/dcn316_clk_mgr.c  | 2 +-
 .../gpu/drm/amd/display/dc/clk_mgr/dcn32/dcn32_clk_mgr.c    | 2 +-
 .../gpu/drm/amd/display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c    | 2 +-
 .../gpu/drm/amd/display/dc/clk_mgr/dcn401/dcn401_clk_mgr.c  | 2 +-
 drivers/gpu/drm/amd/display/dc/core/dc.c                    | 2 +-
 drivers/gpu/drm/amd/display/dc/core/dc_link_enc_cfg.c       | 2 +-
 drivers/gpu/drm/amd/display/dc/core/dc_link_exports.c       | 3 ++-
 drivers/gpu/drm/amd/display/dc/core/dc_resource.c           | 2 +-
 drivers/gpu/drm/amd/display/dc/dce/dmub_replay.c            | 2 +-
 .../gpu/drm/amd/display/dc/dio/dcn10/dcn10_stream_encoder.c | 2 +-
 .../gpu/drm/amd/display/dc/dio/dcn20/dcn20_stream_encoder.c | 2 +-
 .../drm/amd/display/dc/dio/dcn31/dcn31_dio_link_encoder.c   | 2 +-
 .../amd/display/dc/dio/dcn314/dcn314_dio_stream_encoder.c   | 2 +-
 .../drm/amd/display/dc/dio/dcn32/dcn32_dio_stream_encoder.c | 2 +-
 .../drm/amd/display/dc/dio/dcn35/dcn35_dio_stream_encoder.c | 2 +-
 .../amd/display/dc/dio/dcn401/dcn401_dio_stream_encoder.c   | 2 +-
 drivers/gpu/drm/amd/display/dc/dml/dcn20/dcn20_fpu.c        | 3 +--
 drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c        | 2 +-
 drivers/gpu/drm/amd/display/dc/dml/dcn35/dcn35_fpu.c        | 2 +-
 drivers/gpu/drm/amd/display/dc/dml/dcn351/dcn351_fpu.c      | 2 +-
 drivers/gpu/drm/amd/display/dc/hdcp/hdcp_msg.c              | 2 +-
 drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c   | 2 +-
 drivers/gpu/drm/amd/display/dc/hwss/dcn10/dcn10_hwseq.c     | 2 +-
 drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c     | 2 +-
 drivers/gpu/drm/amd/display/dc/hwss/dcn21/dcn21_hwseq.c     | 2 +-
 drivers/gpu/drm/amd/display/dc/hwss/dcn30/dcn30_hwseq.c     | 2 +-
 drivers/gpu/drm/amd/display/dc/hwss/dcn31/dcn31_hwseq.c     | 2 +-
 drivers/gpu/drm/amd/display/dc/hwss/dcn314/dcn314_hwseq.c   | 2 +-
 drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.c     | 2 +-
 drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.c     | 2 +-
 drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c   | 2 +-
 .../gpu/drm/amd/display/dc/inc/{link.h => link_service.h}   | 6 +++---
 .../gpu/drm/amd/display/dc/link/accessories/link_dp_cts.h   | 2 +-
 .../gpu/drm/amd/display/dc/link/accessories/link_dp_trace.h | 2 +-
 drivers/gpu/drm/amd/display/dc/link/hwss/link_hwss_dio.h    | 2 +-
 .../dc/link/hwss/link_hwss_dio_fixed_vs_pe_retimer.h        | 2 +-
 drivers/gpu/drm/amd/display/dc/link/hwss/link_hwss_hpo_dp.h | 2 +-
 .../dc/link/hwss/link_hwss_hpo_fixed_vs_pe_retimer_dp.h     | 2 +-
 drivers/gpu/drm/amd/display/dc/link/link_detection.h        | 2 +-
 drivers/gpu/drm/amd/display/dc/link/link_dpms.h             | 2 +-
 drivers/gpu/drm/amd/display/dc/link/link_factory.h          | 2 +-
 drivers/gpu/drm/amd/display/dc/link/link_resource.h         | 2 +-
 drivers/gpu/drm/amd/display/dc/link/link_validation.h       | 2 +-
 drivers/gpu/drm/amd/display/dc/link/protocols/link_ddc.h    | 2 +-
 .../drm/amd/display/dc/link/protocols/link_dp_capability.h  | 2 +-
 .../gpu/drm/amd/display/dc/link/protocols/link_dp_dpia.h    | 2 +-
 .../gpu/drm/amd/display/dc/link/protocols/link_dp_dpia_bw.h | 2 +-
 .../drm/amd/display/dc/link/protocols/link_dp_irq_handler.h | 2 +-
 drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_phy.h | 2 +-
 .../drm/amd/display/dc/link/protocols/link_dp_training.h    | 2 +-
 drivers/gpu/drm/amd/display/dc/link/protocols/link_dpcd.h   | 2 +-
 .../amd/display/dc/link/protocols/link_edp_panel_control.h  | 2 +-
 drivers/gpu/drm/amd/display/dc/link/protocols/link_hpd.h    | 2 +-
 .../drm/amd/display/dc/resource/dce120/dce120_resource.c    | 2 +-
 .../gpu/drm/amd/display/dc/resource/dcn20/dcn20_resource.c  | 2 +-
 .../gpu/drm/amd/display/dc/resource/dcn30/dcn30_resource.c  | 2 +-
 .../drm/amd/display/dc/resource/dcn302/dcn302_resource.c    | 3 ++-
 .../drm/amd/display/dc/resource/dcn303/dcn303_resource.c    | 2 +-
 .../gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.c  | 2 +-
 .../drm/amd/display/dc/resource/dcn321/dcn321_resource.c    | 2 +-
 .../gpu/drm/amd/display/dc/resource/dcn35/dcn35_resource.c  | 2 +-
 .../drm/amd/display/dc/resource/dcn351/dcn351_resource.c    | 2 +-
 .../gpu/drm/amd/display/dc/resource/dcn36/dcn36_resource.c  | 2 +-
 .../drm/amd/display/dc/resource/dcn401/dcn401_resource.c    | 2 +-
 69 files changed, 73 insertions(+), 72 deletions(-)
 rename drivers/gpu/drm/amd/display/dc/inc/{link.h => link_service.h} (98%)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_replay.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_replay.c
index 82ea3fe5e764..80704d709e44 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_replay.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_replay.c
@@ -31,7 +31,7 @@
 #include "amdgpu_dm.h"
 #include "modules/power/power_helpers.h"
 #include "dmub/inc/dmub_cmd.h"
-#include "dc/inc/link.h"
+#include "dc/inc/link_service.h"
 
 /*
  * amdgpu_dm_link_supports_replay() - check if the link supports replay
diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/clk_mgr.c
index 4071851f9e86..15cf13ec5302 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/clk_mgr.c
@@ -28,7 +28,7 @@
 #include "dccg.h"
 #include "clk_mgr_internal.h"
 #include "dc_state_priv.h"
-#include "link.h"
+#include "link_service.h"
 
 #include "dce100/dce_clk_mgr.h"
 #include "dce110/dce110_clk_mgr.h"
diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn31/dcn31_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn31/dcn31_clk_mgr.c
index bc123f1884da..051052bd10c9 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn31/dcn31_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn31/dcn31_clk_mgr.c
@@ -47,7 +47,7 @@
 #include "dcn30/dcn30_clk_mgr.h"
 
 #include "dc_dmub_srv.h"
-#include "link.h"
+#include "link_service.h"
 
 #include "logger_types.h"
 
diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn314/dcn314_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn314/dcn314_clk_mgr.c
index 91d872d6d392..790bbd8235b1 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn314/dcn314_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn314/dcn314_clk_mgr.c
@@ -48,7 +48,7 @@
 #include "dcn31/dcn31_clk_mgr.h"
 
 #include "dc_dmub_srv.h"
-#include "link.h"
+#include "link_service.h"
 #include "dcn314_smu.h"
 
 
diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn315/dcn315_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn315/dcn315_clk_mgr.c
index e4d22f74f986..b315ed91e010 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn315/dcn315_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn315/dcn315_clk_mgr.c
@@ -46,7 +46,7 @@
 #define DC_LOGGER \
 	clk_mgr->base.base.ctx->logger
 
-#include "link.h"
+#include "link_service.h"
 
 #define TO_CLK_MGR_DCN315(clk_mgr)\
 	container_of(clk_mgr, struct clk_mgr_dcn315, base)
diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn316/dcn316_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn316/dcn316_clk_mgr.c
index 49efea0c8fcf..1769b1f26e75 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn316/dcn316_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn316/dcn316_clk_mgr.c
@@ -39,7 +39,7 @@
 #include "dcn316_smu.h"
 #include "dm_helpers.h"
 #include "dc_dmub_srv.h"
-#include "link.h"
+#include "link_service.h"
 
 // DCN316 this is CLK1 instance
 #define MAX_INSTANCE                                        7
diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn32/dcn32_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn32/dcn32_clk_mgr.c
index 8376e2b0e73d..7da7b41bd092 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn32/dcn32_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn32/dcn32_clk_mgr.c
@@ -33,7 +33,7 @@
 #include "reg_helper.h"
 #include "core_types.h"
 #include "dm_helpers.h"
-#include "link.h"
+#include "link_service.h"
 #include "dc_state_priv.h"
 #include "atomfirmware.h"
 #include "dcn32_smu13_driver_if.h"
diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c
index bb1ac12a2b09..86edf11b8c5a 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c
@@ -44,7 +44,7 @@
 #include "dcn31/dcn31_clk_mgr.h"
 
 #include "dc_dmub_srv.h"
-#include "link.h"
+#include "link_service.h"
 #include "logger_types.h"
 
 #undef DC_LOGGER
diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn401/dcn401_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn401/dcn401_clk_mgr.c
index 47ff4c965d76..47461f249e83 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn401/dcn401_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn401/dcn401_clk_mgr.c
@@ -13,7 +13,7 @@
 #include "reg_helper.h"
 #include "core_types.h"
 #include "dm_helpers.h"
-#include "link.h"
+#include "link_service.h"
 #include "dc_state_priv.h"
 #include "atomfirmware.h"
 
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index 5963019d1e74..269206ebee60 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -60,7 +60,7 @@
 #include "link_encoder.h"
 #include "link_enc_cfg.h"
 
-#include "link.h"
+#include "link_service.h"
 #include "dm_helpers.h"
 #include "mem_input.h"
 
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link_enc_cfg.c b/drivers/gpu/drm/amd/display/dc/core/dc_link_enc_cfg.c
index 814f68d76257..a180f68f711c 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link_enc_cfg.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link_enc_cfg.c
@@ -24,7 +24,7 @@
 
 #include "link_enc_cfg.h"
 #include "resource.h"
-#include "link.h"
+#include "link_service.h"
 
 #define DC_LOGGER dc->ctx->logger
 
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link_exports.c b/drivers/gpu/drm/amd/display/dc/core/dc_link_exports.c
index b7a5de4ecb61..9acd30019717 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link_exports.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link_exports.c
@@ -33,8 +33,9 @@
  * dc.h with detail interface documentation, then add function implementation
  * in this file which calls link functions.
  */
-#include "link.h"
+#include "link_service.h"
 #include "dce/dce_i2c.h"
+
 struct dc_link *dc_get_link_at_index(struct dc *dc, uint32_t link_index)
 {
 	if (link_index >= MAX_LINKS)
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
index d712548b1927..89c805457ed8 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
@@ -40,7 +40,7 @@
 #include "virtual/virtual_stream_encoder.h"
 #include "dpcd_defs.h"
 #include "link_enc_cfg.h"
-#include "link.h"
+#include "link_service.h"
 #include "clk_mgr.h"
 #include "dc_state_priv.h"
 #include "dc_stream_priv.h"
diff --git a/drivers/gpu/drm/amd/display/dc/dce/dmub_replay.c b/drivers/gpu/drm/amd/display/dc/dce/dmub_replay.c
index 65b979617b0c..9e2a473a8852 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dmub_replay.c
+++ b/drivers/gpu/drm/amd/display/dc/dce/dmub_replay.c
@@ -3,7 +3,7 @@
 // Copyright 2024 Advanced Micro Devices, Inc.
 
 #include "dc.h"
-#include "link.h"
+#include "link_service.h"
 #include "dc_dmub_srv.h"
 #include "dmub/dmub_srv.h"
 #include "core_types.h"
diff --git a/drivers/gpu/drm/amd/display/dc/dio/dcn10/dcn10_stream_encoder.c b/drivers/gpu/drm/amd/display/dc/dio/dcn10/dcn10_stream_encoder.c
index 22e66b375a7f..d928b4dcf6b8 100644
--- a/drivers/gpu/drm/amd/display/dc/dio/dcn10/dcn10_stream_encoder.c
+++ b/drivers/gpu/drm/amd/display/dc/dio/dcn10/dcn10_stream_encoder.c
@@ -28,7 +28,7 @@
 #include "dcn10_stream_encoder.h"
 #include "reg_helper.h"
 #include "hw_shared.h"
-#include "link.h"
+#include "link_service.h"
 #include "dpcd_defs.h"
 #include "dcn30/dcn30_afmt.h"
 
diff --git a/drivers/gpu/drm/amd/display/dc/dio/dcn20/dcn20_stream_encoder.c b/drivers/gpu/drm/amd/display/dc/dio/dcn20/dcn20_stream_encoder.c
index 0b47aeb60e79..bec0b4aaeb2b 100644
--- a/drivers/gpu/drm/amd/display/dc/dio/dcn20/dcn20_stream_encoder.c
+++ b/drivers/gpu/drm/amd/display/dc/dio/dcn20/dcn20_stream_encoder.c
@@ -29,7 +29,7 @@
 #include "dcn20_stream_encoder.h"
 #include "reg_helper.h"
 #include "hw_shared.h"
-#include "link.h"
+#include "link_service.h"
 #include "dpcd_defs.h"
 
 #define DC_LOGGER \
diff --git a/drivers/gpu/drm/amd/display/dc/dio/dcn31/dcn31_dio_link_encoder.c b/drivers/gpu/drm/amd/display/dc/dio/dcn31/dcn31_dio_link_encoder.c
index 9a92f73d5b7f..84cc2ddc52fe 100644
--- a/drivers/gpu/drm/amd/display/dc/dio/dcn31/dcn31_dio_link_encoder.c
+++ b/drivers/gpu/drm/amd/display/dc/dio/dcn31/dcn31_dio_link_encoder.c
@@ -37,7 +37,7 @@
 #include "link_enc_cfg.h"
 #include "dc_dmub_srv.h"
 #include "dal_asic_id.h"
-#include "link.h"
+#include "link_service.h"
 
 #define CTX \
 	enc10->base.ctx
diff --git a/drivers/gpu/drm/amd/display/dc/dio/dcn314/dcn314_dio_stream_encoder.c b/drivers/gpu/drm/amd/display/dc/dio/dcn314/dcn314_dio_stream_encoder.c
index ae81451a3a72..3e85e9c3d2cb 100644
--- a/drivers/gpu/drm/amd/display/dc/dio/dcn314/dcn314_dio_stream_encoder.c
+++ b/drivers/gpu/drm/amd/display/dc/dio/dcn314/dcn314_dio_stream_encoder.c
@@ -30,7 +30,7 @@
 #include "dcn314_dio_stream_encoder.h"
 #include "reg_helper.h"
 #include "hw_shared.h"
-#include "link.h"
+#include "link_service.h"
 #include "dpcd_defs.h"
 
 #define DC_LOGGER \
diff --git a/drivers/gpu/drm/amd/display/dc/dio/dcn32/dcn32_dio_stream_encoder.c b/drivers/gpu/drm/amd/display/dc/dio/dcn32/dcn32_dio_stream_encoder.c
index 1a9bb614c41e..3523d1cdc1a3 100644
--- a/drivers/gpu/drm/amd/display/dc/dio/dcn32/dcn32_dio_stream_encoder.c
+++ b/drivers/gpu/drm/amd/display/dc/dio/dcn32/dcn32_dio_stream_encoder.c
@@ -29,7 +29,7 @@
 #include "dcn32_dio_stream_encoder.h"
 #include "reg_helper.h"
 #include "hw_shared.h"
-#include "link.h"
+#include "link_service.h"
 #include "dpcd_defs.h"
 
 #define DC_LOGGER \
diff --git a/drivers/gpu/drm/amd/display/dc/dio/dcn35/dcn35_dio_stream_encoder.c b/drivers/gpu/drm/amd/display/dc/dio/dcn35/dcn35_dio_stream_encoder.c
index 6f30b6cc3c76..fd5d1dbf9dc6 100644
--- a/drivers/gpu/drm/amd/display/dc/dio/dcn35/dcn35_dio_stream_encoder.c
+++ b/drivers/gpu/drm/amd/display/dc/dio/dcn35/dcn35_dio_stream_encoder.c
@@ -29,7 +29,7 @@
 #include "dcn35_dio_stream_encoder.h"
 #include "reg_helper.h"
 #include "hw_shared.h"
-#include "link.h"
+#include "link_service.h"
 #include "dpcd_defs.h"
 
 #define DC_LOGGER \
diff --git a/drivers/gpu/drm/amd/display/dc/dio/dcn401/dcn401_dio_stream_encoder.c b/drivers/gpu/drm/amd/display/dc/dio/dcn401/dcn401_dio_stream_encoder.c
index d5fa551dd3c9..99aab70ef3e1 100644
--- a/drivers/gpu/drm/amd/display/dc/dio/dcn401/dcn401_dio_stream_encoder.c
+++ b/drivers/gpu/drm/amd/display/dc/dio/dcn401/dcn401_dio_stream_encoder.c
@@ -32,7 +32,7 @@
 #include "dcn401_dio_stream_encoder.h"
 #include "reg_helper.h"
 #include "hw_shared.h"
-#include "link.h"
+#include "link_service.h"
 #include "dpcd_defs.h"
 
 #define DC_LOGGER \
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn20/dcn20_fpu.c b/drivers/gpu/drm/amd/display/dc/dml/dcn20/dcn20_fpu.c
index 2a2eaf6adf26..7aaf13bbd4e4 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn20/dcn20_fpu.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn20/dcn20_fpu.c
@@ -30,8 +30,7 @@
 #include "dcn20/dcn20_resource.h"
 #include "dcn21/dcn21_resource.h"
 #include "clk_mgr/dcn21/rn_clk_mgr.h"
-
-#include "link.h"
+#include "link_service.h"
 #include "dcn20_fpu.h"
 #include "dc_state_priv.h"
 
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c b/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
index 18388fb00be8..8a0f128722b0 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
@@ -31,7 +31,7 @@
 // We need this includes for WATERMARKS_* defines
 #include "clk_mgr/dcn32/dcn32_smu13_driver_if.h"
 #include "dcn30/dcn30_resource.h"
-#include "link.h"
+#include "link_service.h"
 #include "dc_state_priv.h"
 
 #define DC_LOGGER_INIT(logger)
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn35/dcn35_fpu.c b/drivers/gpu/drm/amd/display/dc/dml/dcn35/dcn35_fpu.c
index 5d73efa2f0c9..c9dd920744c9 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn35/dcn35_fpu.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn35/dcn35_fpu.c
@@ -31,7 +31,7 @@
 #include "dml/dcn31/dcn31_fpu.h"
 #include "dml/dml_inline_defs.h"
 
-#include "link.h"
+#include "link_service.h"
 
 #define DC_LOGGER_INIT(logger)
 
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn351/dcn351_fpu.c b/drivers/gpu/drm/amd/display/dc/dml/dcn351/dcn351_fpu.c
index 6f516af82956..8cda18ce1a76 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn351/dcn351_fpu.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn351/dcn351_fpu.c
@@ -10,7 +10,7 @@
 #include "dml/dcn35/dcn35_fpu.h"
 #include "dml/dml_inline_defs.h"
 
-#include "link.h"
+#include "link_service.h"
 
 #define DC_LOGGER_INIT(logger)
 
diff --git a/drivers/gpu/drm/amd/display/dc/hdcp/hdcp_msg.c b/drivers/gpu/drm/amd/display/dc/hdcp/hdcp_msg.c
index 1313a7c5d87b..73a1e6a03719 100644
--- a/drivers/gpu/drm/amd/display/dc/hdcp/hdcp_msg.c
+++ b/drivers/gpu/drm/amd/display/dc/hdcp/hdcp_msg.c
@@ -28,7 +28,7 @@
 #include "include/hdcp_msg_types.h"
 #include "include/signal_types.h"
 #include "core_types.h"
-#include "link.h"
+#include "link_service.h"
 #include "link_hwss.h"
 #include "link/protocols/link_dpcd.h"
 
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c
index 153d68375fa3..ea904d52af20 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c
@@ -48,7 +48,7 @@
 #include "link_encoder.h"
 #include "link_enc_cfg.h"
 #include "link_hwss.h"
-#include "link.h"
+#include "link_service.h"
 #include "dccg.h"
 #include "clock_source.h"
 #include "clk_mgr.h"
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn10/dcn10_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn10/dcn10_hwseq.c
index 506c3bbbf221..74f5e05f9cb4 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn10/dcn10_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn10/dcn10_hwseq.c
@@ -55,7 +55,7 @@
 #include "dce/dmub_hw_lock_mgr.h"
 #include "dc_trace.h"
 #include "dce/dmub_outbox.h"
-#include "link.h"
+#include "link_service.h"
 #include "dc_state_priv.h"
 
 #define DC_LOGGER \
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c
index cc377fcda6ff..417f2679723e 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c
@@ -54,7 +54,7 @@
 #include "dpcd_defs.h"
 #include "inc/link_enc_cfg.h"
 #include "link_hwss.h"
-#include "link.h"
+#include "link_service.h"
 #include "dc_state_priv.h"
 
 #define DC_LOGGER \
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn21/dcn21_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn21/dcn21_hwseq.c
index 61efb15572ff..e2269211553c 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn21/dcn21_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn21/dcn21_hwseq.c
@@ -35,7 +35,7 @@
 #include "hw/clk_mgr.h"
 #include "dc_dmub_srv.h"
 #include "abm.h"
-#include "link.h"
+#include "link_service.h"
 
 #define DC_LOGGER_INIT(logger)
 
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn30/dcn30_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn30/dcn30_hwseq.c
index 139a63101488..e47ed5571dfd 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn30/dcn30_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn30/dcn30_hwseq.c
@@ -50,7 +50,7 @@
 #include "dpcd_defs.h"
 #include "dcn20/dcn20_hwseq.h"
 #include "dcn30/dcn30_resource.h"
-#include "link.h"
+#include "link_service.h"
 #include "dc_state_priv.h"
 
 
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn31/dcn31_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn31/dcn31_hwseq.c
index 8ba934b83957..b822f2dffff0 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn31/dcn31_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn31/dcn31_hwseq.c
@@ -45,7 +45,7 @@
 #include "link_hwss.h"
 #include "dpcd_defs.h"
 #include "dce/dmub_outbox.h"
-#include "link.h"
+#include "link_service.h"
 #include "dcn10/dcn10_hwseq.h"
 #include "dcn21/dcn21_hwseq.h"
 #include "inc/link_enc_cfg.h"
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn314/dcn314_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn314/dcn314_hwseq.c
index 560984533950..f925f669f2a4 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn314/dcn314_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn314/dcn314_hwseq.c
@@ -46,7 +46,7 @@
 #include "link_hwss.h"
 #include "dpcd_defs.h"
 #include "dce/dmub_outbox.h"
-#include "link.h"
+#include "link_service.h"
 #include "dcn10/dcn10_hwseq.h"
 #include "inc/link_enc_cfg.h"
 #include "dcn30/dcn30_vpg.h"
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.c
index 416b1dca3dac..3a6f946643ef 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.c
@@ -49,7 +49,7 @@
 #include "dcn20/dcn20_optc.h"
 #include "dce/dmub_hw_lock_mgr.h"
 #include "dcn32/dcn32_resource.h"
-#include "link.h"
+#include "link_service.h"
 #include "../dcn20/dcn20_hwseq.h"
 #include "dc_state_priv.h"
 
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.c
index 764eff6a4ec6..05011061822c 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.c
@@ -46,7 +46,7 @@
 #include "link_hwss.h"
 #include "dpcd_defs.h"
 #include "dce/dmub_outbox.h"
-#include "link.h"
+#include "link_service.h"
 #include "dcn10/dcn10_hwseq.h"
 #include "inc/link_enc_cfg.h"
 #include "dcn30/dcn30_vpg.h"
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c
index d5b5e2ce6ff6..9956145e3d18 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c
@@ -25,7 +25,7 @@
 #include "dpcd_defs.h"
 #include "clk_mgr.h"
 #include "dsc.h"
-#include "link.h"
+#include "link_service.h"
 
 #include "dce/dmub_hw_lock_mgr.h"
 #include "dcn10/dcn10_cm_common.h"
diff --git a/drivers/gpu/drm/amd/display/dc/inc/link.h b/drivers/gpu/drm/amd/display/dc/inc/link_service.h
similarity index 98%
rename from drivers/gpu/drm/amd/display/dc/inc/link.h
rename to drivers/gpu/drm/amd/display/dc/inc/link_service.h
index 0cce49d95e26..1e34e84160aa 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/link.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/link_service.h
@@ -42,8 +42,8 @@
  * dc_link_exports.c or other dc files implement dc.h
  *
  * DC to Link:
- * dc_link_exports.c or other dc files include link.h
- * link_factory.c implements link.h
+ * dc_link_exports.c or other dc files include link_service.h
+ * link_factory.c implements link_service.h
  *
  * Link sub-component to Link sub-component:
  * link_factory.c includes --> link_xxx.h
@@ -73,7 +73,7 @@
  * 2. Implement your function in the suitable link_xxx.c file.
  * 3. Assign the function to link_service in link_factory.c
  * 4. NEVER include link_xxx.h headers outside link component.
- * 5. NEVER include link.h on DM side.
+ * 5. NEVER include link_service.h on DM side.
  */
 #include "core_types.h"
 
diff --git a/drivers/gpu/drm/amd/display/dc/link/accessories/link_dp_cts.h b/drivers/gpu/drm/amd/display/dc/link/accessories/link_dp_cts.h
index eae23ea7f6ec..033650cdb811 100644
--- a/drivers/gpu/drm/amd/display/dc/link/accessories/link_dp_cts.h
+++ b/drivers/gpu/drm/amd/display/dc/link/accessories/link_dp_cts.h
@@ -24,7 +24,7 @@
  */
 #ifndef __LINK_DP_CTS_H__
 #define __LINK_DP_CTS_H__
-#include "link.h"
+#include "link_service.h"
 void dp_handle_automated_test(struct dc_link *link);
 bool dp_set_test_pattern(
 		struct dc_link *link,
diff --git a/drivers/gpu/drm/amd/display/dc/link/accessories/link_dp_trace.h b/drivers/gpu/drm/amd/display/dc/link/accessories/link_dp_trace.h
index ab437a0c9101..9ff4a6c46a2b 100644
--- a/drivers/gpu/drm/amd/display/dc/link/accessories/link_dp_trace.h
+++ b/drivers/gpu/drm/amd/display/dc/link/accessories/link_dp_trace.h
@@ -24,7 +24,7 @@
  */
 #ifndef __LINK_DP_TRACE_H__
 #define __LINK_DP_TRACE_H__
-#include "link.h"
+#include "link_service.h"
 
 void dp_trace_init(struct dc_link *link);
 void dp_trace_reset(struct dc_link *link);
diff --git a/drivers/gpu/drm/amd/display/dc/link/hwss/link_hwss_dio.h b/drivers/gpu/drm/amd/display/dc/link/hwss/link_hwss_dio.h
index 45f0e091fcb0..4a25210a344f 100644
--- a/drivers/gpu/drm/amd/display/dc/link/hwss/link_hwss_dio.h
+++ b/drivers/gpu/drm/amd/display/dc/link/hwss/link_hwss_dio.h
@@ -27,7 +27,7 @@
 #define __LINK_HWSS_DIO_H__
 
 #include "link_hwss.h"
-#include "link.h"
+#include "link_service.h"
 
 const struct link_hwss *get_dio_link_hwss(void);
 bool can_use_dio_link_hwss(const struct dc_link *link,
diff --git a/drivers/gpu/drm/amd/display/dc/link/hwss/link_hwss_dio_fixed_vs_pe_retimer.h b/drivers/gpu/drm/amd/display/dc/link/hwss/link_hwss_dio_fixed_vs_pe_retimer.h
index 9ac08a332540..cf578a8662a4 100644
--- a/drivers/gpu/drm/amd/display/dc/link/hwss/link_hwss_dio_fixed_vs_pe_retimer.h
+++ b/drivers/gpu/drm/amd/display/dc/link/hwss/link_hwss_dio_fixed_vs_pe_retimer.h
@@ -25,7 +25,7 @@
 #ifndef __LINK_HWSS_DIO_FIXED_VS_PE_RETIMER_H__
 #define __LINK_HWSS_DIO_FIXED_VS_PE_RETIMER_H__
 
-#include "link.h"
+#include "link_service.h"
 
 uint32_t dp_dio_fixed_vs_pe_retimer_get_lttpr_write_address(struct dc_link *link);
 uint8_t dp_dio_fixed_vs_pe_retimer_lane_cfg_to_hw_cfg(struct dc_link *link);
diff --git a/drivers/gpu/drm/amd/display/dc/link/hwss/link_hwss_hpo_dp.h b/drivers/gpu/drm/amd/display/dc/link/hwss/link_hwss_hpo_dp.h
index 1d3ed8ca83b5..7c9005bc2587 100644
--- a/drivers/gpu/drm/amd/display/dc/link/hwss/link_hwss_hpo_dp.h
+++ b/drivers/gpu/drm/amd/display/dc/link/hwss/link_hwss_hpo_dp.h
@@ -26,7 +26,7 @@
 #define __LINK_HWSS_HPO_DP_H__
 
 #include "link_hwss.h"
-#include "link.h"
+#include "link_service.h"
 
 void set_hpo_dp_throttled_vcp_size(struct pipe_ctx *pipe_ctx,
 		struct fixed31_32 throttled_vcp_size);
diff --git a/drivers/gpu/drm/amd/display/dc/link/hwss/link_hwss_hpo_fixed_vs_pe_retimer_dp.h b/drivers/gpu/drm/amd/display/dc/link/hwss/link_hwss_hpo_fixed_vs_pe_retimer_dp.h
index 82301187bc7c..8bf36827ecfb 100644
--- a/drivers/gpu/drm/amd/display/dc/link/hwss/link_hwss_hpo_fixed_vs_pe_retimer_dp.h
+++ b/drivers/gpu/drm/amd/display/dc/link/hwss/link_hwss_hpo_fixed_vs_pe_retimer_dp.h
@@ -25,7 +25,7 @@
 #ifndef __LINK_HWSS_HPO_FIXED_VS_PE_RETIMER_DP_H__
 #define __LINK_HWSS_HPO_FIXED_VS_PE_RETIMER_DP_H__
 
-#include "link.h"
+#include "link_service.h"
 
 bool requires_fixed_vs_pe_retimer_hpo_link_hwss(const struct dc_link *link);
 const struct link_hwss *get_hpo_fixed_vs_pe_retimer_dp_link_hwss(void);
diff --git a/drivers/gpu/drm/amd/display/dc/link/link_detection.h b/drivers/gpu/drm/amd/display/dc/link/link_detection.h
index 7da05078721e..1ab29476060b 100644
--- a/drivers/gpu/drm/amd/display/dc/link/link_detection.h
+++ b/drivers/gpu/drm/amd/display/dc/link/link_detection.h
@@ -25,7 +25,7 @@
 
 #ifndef __DC_LINK_DETECTION_H__
 #define __DC_LINK_DETECTION_H__
-#include "link.h"
+#include "link_service.h"
 bool link_detect(struct dc_link *link, enum dc_detect_reason reason);
 bool link_detect_connection_type(struct dc_link *link,
 		enum dc_connection_type *type);
diff --git a/drivers/gpu/drm/amd/display/dc/link/link_dpms.h b/drivers/gpu/drm/amd/display/dc/link/link_dpms.h
index 9398f9c1666a..bd6fc63064a3 100644
--- a/drivers/gpu/drm/amd/display/dc/link/link_dpms.h
+++ b/drivers/gpu/drm/amd/display/dc/link/link_dpms.h
@@ -26,7 +26,7 @@
 #ifndef __DC_LINK_DPMS_H__
 #define __DC_LINK_DPMS_H__
 
-#include "link.h"
+#include "link_service.h"
 void link_set_dpms_on(
 		struct dc_state *state,
 		struct pipe_ctx *pipe_ctx);
diff --git a/drivers/gpu/drm/amd/display/dc/link/link_factory.h b/drivers/gpu/drm/amd/display/dc/link/link_factory.h
index e96220d48d03..aad36ca1a31c 100644
--- a/drivers/gpu/drm/amd/display/dc/link/link_factory.h
+++ b/drivers/gpu/drm/amd/display/dc/link/link_factory.h
@@ -24,7 +24,7 @@
  */
 #ifndef __LINK_FACTORY_H__
 #define __LINK_FACTORY_H__
-#include "link.h"
+#include "link_service.h"
 struct dc_link *link_create(const struct link_init_data *init_params);
 void link_destroy(struct dc_link **link);
 
diff --git a/drivers/gpu/drm/amd/display/dc/link/link_resource.h b/drivers/gpu/drm/amd/display/dc/link/link_resource.h
index 1907bda3cb6e..f7aa3bc3a93a 100644
--- a/drivers/gpu/drm/amd/display/dc/link/link_resource.h
+++ b/drivers/gpu/drm/amd/display/dc/link/link_resource.h
@@ -24,7 +24,7 @@
  */
 #ifndef __LINK_RESOURCE_H__
 #define __LINK_RESOURCE_H__
-#include "link.h"
+#include "link_service.h"
 void link_get_cur_res_map(const struct dc *dc, uint32_t *map);
 void link_restore_res_map(const struct dc *dc, uint32_t *map);
 void link_get_cur_link_res(const struct dc_link *link,
diff --git a/drivers/gpu/drm/amd/display/dc/link/link_validation.h b/drivers/gpu/drm/amd/display/dc/link/link_validation.h
index 9553c81053fe..595774e76453 100644
--- a/drivers/gpu/drm/amd/display/dc/link/link_validation.h
+++ b/drivers/gpu/drm/amd/display/dc/link/link_validation.h
@@ -24,7 +24,7 @@
  */
 #ifndef __LINK_VALIDATION_H__
 #define __LINK_VALIDATION_H__
-#include "link.h"
+#include "link_service.h"
 
 enum dc_status link_validate_mode_timing(
 		const struct dc_stream_state *stream,
diff --git a/drivers/gpu/drm/amd/display/dc/link/protocols/link_ddc.h b/drivers/gpu/drm/amd/display/dc/link/protocols/link_ddc.h
index a3e25e55bed6..d3e6f01a6a90 100644
--- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_ddc.h
+++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_ddc.h
@@ -26,7 +26,7 @@
 #ifndef __DAL_DDC_SERVICE_H__
 #define __DAL_DDC_SERVICE_H__
 
-#include "link.h"
+#include "link_service.h"
 
 #define AUX_POWER_UP_WA_DELAY 500
 #define I2C_OVER_AUX_DEFER_WA_DELAY 70
diff --git a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_capability.h b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_capability.h
index 7170db5a1c13..6e17f72a752f 100644
--- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_capability.h
+++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_capability.h
@@ -26,7 +26,7 @@
 #ifndef __DC_LINK_DP_CAPABILITY_H__
 #define __DC_LINK_DP_CAPABILITY_H__
 
-#include "link.h"
+#include "link_service.h"
 
 bool detect_dp_sink_caps(struct dc_link *link);
 
diff --git a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_dpia.h b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_dpia.h
index a61edfc9ca7a..7cd03fa4892b 100644
--- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_dpia.h
+++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_dpia.h
@@ -27,7 +27,7 @@
 #ifndef __DC_LINK_DPIA_H__
 #define __DC_LINK_DPIA_H__
 
-#include "link.h"
+#include "link_service.h"
 
 /* Read tunneling device capability from DPCD and update link capability
  * accordingly.
diff --git a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_dpia_bw.h b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_dpia_bw.h
index 41efcb3e44e2..30cd8e2b9d35 100644
--- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_dpia_bw.h
+++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_dpia_bw.h
@@ -26,7 +26,7 @@
 #ifndef DC_INC_LINK_DP_DPIA_BW_H_
 #define DC_INC_LINK_DP_DPIA_BW_H_
 
-#include "link.h"
+#include "link_service.h"
 
 
 /*
diff --git a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_irq_handler.h b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_irq_handler.h
index ac33730fedd4..87516fb3b45a 100644
--- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_irq_handler.h
+++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_irq_handler.h
@@ -26,7 +26,7 @@
 #ifndef __DC_LINK_DP_IRQ_HANDLER_H__
 #define __DC_LINK_DP_IRQ_HANDLER_H__
 
-#include "link.h"
+#include "link_service.h"
 bool dp_parse_link_loss_status(
 	struct dc_link *link,
 	union hpd_irq_data *hpd_irq_dpcd_data);
diff --git a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_phy.h b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_phy.h
index ab1c1f8f1f8b..58e154494582 100644
--- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_phy.h
+++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_phy.h
@@ -26,7 +26,7 @@
 #ifndef __DC_LINK_DP_PHY_H__
 #define __DC_LINK_DP_PHY_H__
 
-#include "link.h"
+#include "link_service.h"
 void dp_enable_link_phy(
 	struct dc_link *link,
 	const struct link_resource *link_res,
diff --git a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_training.h b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_training.h
index 574b083e0936..ce52de22ab7a 100644
--- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_training.h
+++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_training.h
@@ -26,7 +26,7 @@
 
 #ifndef __DC_LINK_DP_TRAINING_H__
 #define __DC_LINK_DP_TRAINING_H__
-#include "link.h"
+#include "link_service.h"
 
 bool perform_link_training_with_retries(
 	const struct dc_link_settings *link_setting,
diff --git a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dpcd.h b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dpcd.h
index 08d787a1e451..c2717c678c72 100644
--- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dpcd.h
+++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dpcd.h
@@ -25,7 +25,7 @@
 
 #ifndef __LINK_DPCD_H__
 #define __LINK_DPCD_H__
-#include "link.h"
+#include "link_service.h"
 #include "dpcd_defs.h"
 
 enum dc_status core_link_read_dpcd(
diff --git a/drivers/gpu/drm/amd/display/dc/link/protocols/link_edp_panel_control.h b/drivers/gpu/drm/amd/display/dc/link/protocols/link_edp_panel_control.h
index 4a475d5b9dde..62a6344e613e 100644
--- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_edp_panel_control.h
+++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_edp_panel_control.h
@@ -25,7 +25,7 @@
 
 #ifndef __DC_LINK_EDP_PANEL_CONTROL_H__
 #define __DC_LINK_EDP_PANEL_CONTROL_H__
-#include "link.h"
+#include "link_service.h"
 
 enum dp_panel_mode dp_get_panel_mode(struct dc_link *link);
 void dp_set_panel_mode(struct dc_link *link, enum dp_panel_mode panel_mode);
diff --git a/drivers/gpu/drm/amd/display/dc/link/protocols/link_hpd.h b/drivers/gpu/drm/amd/display/dc/link/protocols/link_hpd.h
index 4fb526b264f9..af529328ba17 100644
--- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_hpd.h
+++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_hpd.h
@@ -26,7 +26,7 @@
 
 #ifndef __DC_LINK_HPD_H__
 #define __DC_LINK_HPD_H__
-#include "link.h"
+#include "link_service.h"
 
 enum hpd_source_id get_hpd_line(struct dc_link *link);
 /*
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dce120/dce120_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dce120/dce120_resource.c
index 2f23cc6df571..540e04ec1e2d 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dce120/dce120_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dce120/dce120_resource.c
@@ -67,7 +67,7 @@
 #include "reg_helper.h"
 
 #include "dce100/dce100_resource.h"
-#include "link.h"
+#include "link_service.h"
 
 #ifndef mmDP0_DP_DPHY_INTERNAL_CTRL
 	#define mmDP0_DP_DPHY_INTERNAL_CTRL		0x210f
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn20/dcn20_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn20/dcn20_resource.c
index f9cbdad3ef37..84b38d2d6967 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn20/dcn20_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn20/dcn20_resource.c
@@ -85,7 +85,7 @@
 #include "vm_helper.h"
 
 #include "link_enc_cfg.h"
-#include "link.h"
+#include "link_service.h"
 
 #define DC_LOGGER_INIT(logger)
 
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn30/dcn30_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn30/dcn30_resource.c
index 201ed863b69e..ff63f59ff928 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn30/dcn30_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn30/dcn30_resource.c
@@ -60,7 +60,7 @@
 #include "dml/display_mode_vba.h"
 #include "dcn30/dcn30_dccg.h"
 #include "dcn10/dcn10_resource.h"
-#include "link.h"
+#include "link_service.h"
 #include "dce/dce_panel_cntl.h"
 
 #include "dcn30/dcn30_dwb.h"
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn302/dcn302_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn302/dcn302_resource.c
index 3345068a878c..61623cb518d9 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn302/dcn302_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn302/dcn302_resource.c
@@ -47,7 +47,8 @@
 
 #include "dcn10/dcn10_resource.h"
 
-#include "link.h"
+#include "link_service.h"
+
 #include "dce/dce_abm.h"
 #include "dce/dce_audio.h"
 #include "dce/dce_aux.h"
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn303/dcn303_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn303/dcn303_resource.c
index 3479e1eab4cd..02b9a84f2db3 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn303/dcn303_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn303/dcn303_resource.c
@@ -47,7 +47,7 @@
 
 #include "dcn10/dcn10_resource.h"
 
-#include "link.h"
+#include "link_service.h"
 
 #include "dce/dce_abm.h"
 #include "dce/dce_audio.h"
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.c
index 9917b366f00c..4acd97b3e4c9 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.c
@@ -69,7 +69,7 @@
 #include "dml/display_mode_vba.h"
 #include "dcn32/dcn32_dccg.h"
 #include "dcn10/dcn10_resource.h"
-#include "link.h"
+#include "link_service.h"
 #include "dcn31/dcn31_panel_cntl.h"
 
 #include "dcn30/dcn30_dwb.h"
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn321/dcn321_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn321/dcn321_resource.c
index 061c0907d802..ad214986f7ac 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn321/dcn321_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn321/dcn321_resource.c
@@ -72,7 +72,7 @@
 #include "dml/display_mode_vba.h"
 #include "dcn32/dcn32_dccg.h"
 #include "dcn10/dcn10_resource.h"
-#include "link.h"
+#include "link_service.h"
 #include "dcn31/dcn31_panel_cntl.h"
 
 #include "dcn30/dcn30_dwb.h"
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn35/dcn35_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn35/dcn35_resource.c
index 1d1a002f6d54..07552445e424 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn35/dcn35_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn35/dcn35_resource.c
@@ -61,7 +61,7 @@
 #include "dcn31/dcn31_hpo_dp_stream_encoder.h"
 #include "dcn31/dcn31_hpo_dp_link_encoder.h"
 #include "dcn32/dcn32_hpo_dp_link_encoder.h"
-#include "link.h"
+#include "link_service.h"
 #include "dcn31/dcn31_apg.h"
 #include "dcn32/dcn32_dio_link_encoder.h"
 #include "dcn31/dcn31_vpg.h"
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn351/dcn351_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn351/dcn351_resource.c
index 47912e0861a2..cb0478a9a34d 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn351/dcn351_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn351/dcn351_resource.c
@@ -40,7 +40,7 @@
 #include "dcn31/dcn31_hpo_dp_stream_encoder.h"
 #include "dcn31/dcn31_hpo_dp_link_encoder.h"
 #include "dcn32/dcn32_hpo_dp_link_encoder.h"
-#include "link.h"
+#include "link_service.h"
 #include "dcn31/dcn31_apg.h"
 #include "dcn32/dcn32_dio_link_encoder.h"
 #include "dcn31/dcn31_vpg.h"
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn36/dcn36_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn36/dcn36_resource.c
index 9ba91e214dda..126090c9bb8a 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn36/dcn36_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn36/dcn36_resource.c
@@ -40,7 +40,7 @@
 #include "dcn31/dcn31_hpo_dp_stream_encoder.h"
 #include "dcn31/dcn31_hpo_dp_link_encoder.h"
 #include "dcn32/dcn32_hpo_dp_link_encoder.h"
-#include "link.h"
+#include "link_service.h"
 #include "dcn31/dcn31_apg.h"
 #include "dcn32/dcn32_dio_link_encoder.h"
 #include "dcn31/dcn31_vpg.h"
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn401/dcn401_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn401/dcn401_resource.c
index 068c123ea8a8..d498c0983d74 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn401/dcn401_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn401/dcn401_resource.c
@@ -50,7 +50,7 @@
 #include "dml/display_mode_vba.h"
 #include "dcn401/dcn401_dccg.h"
 #include "dcn10/dcn10_resource.h"
-#include "link.h"
+#include "link_service.h"
 #include "link_enc_cfg.h"
 #include "dcn31/dcn31_panel_cntl.h"
 
-- 
2.43.0

