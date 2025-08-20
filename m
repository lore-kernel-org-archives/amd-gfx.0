Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14ABFCA0EDC
	for <amd-gfx@archiver.kernel.org>; Wed, 20 Aug 2025 20:21:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9FCEB10E7F0;
	Wed, 20 Aug 2025 20:21:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="K2Or3aH3";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2043.outbound.protection.outlook.com [40.107.220.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E653710E7F0
 for <amd-gfx@lists.freedesktop.org>; Wed, 20 Aug 2025 20:21:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hKsC8K2EFVFzVQzMdOtrIzwraMMYZ8/DiuUsrTzgtnVh2ZL+6JeHKXomwoKy1czL5Mw4xjEzKvarS78+z02+Wd4MiKrmk3Ry8J2rznz+thv3sWQ3OmH9yEnnBGgIYa5T9EsUNQ0QTeC0ZtxCcl/p6z7xoy3X/f5Wx3v39cLpp6KeIebNfVEaweNAa+DNBBA9321rUpDPjCHc0eCcuMfp4UvHt05sAIvtIfY1cnwq8GdbGuy++Z1B5laBoA/suHtKqw7z83yDgl8XtgodXpxRaHpLDVw2+YygnSfLVnkU+xkutENaA/BWqPeb6GDy1hOhBLbKEK8iTkBW9RKBnrspkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UsyNoOuXjCWi7pUsbdpyjHAK2dSGPAV6qoFw5+hRvQU=;
 b=tZAAPHPh3+8MnZ0wiiIa9aPekyHF2vbsLPzh6frJv3gJ5IrnNWewXGOaZ+CG+Wfwbb1HjgfHi3A5ZdH+e0uF/FWSgC1INcPalDUalIhhF/EUyjWl8mou2256KTOxiDXzpOB9ZCOrLu7dq1mvdsUPE5aAmHaXAHRYyF4FCxkloKMM95GLB9C+e8Jp0fmSDi2suNvcIq3Ar6P4Q4BuaikfbfIrhbE1iDk2RPhuShaHLTrPRQdAwKhEH3bBkE+cS9mdz2GVVmyXIL8Hz4kjksjMbVf5dYBwW1tNXy5Kk7ZX1J1oCs6R9lfJmkqNg2bFmugJXSU7wzCllsLbg8f79jufOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UsyNoOuXjCWi7pUsbdpyjHAK2dSGPAV6qoFw5+hRvQU=;
 b=K2Or3aH3rJep6RHnJCbPc4213j6QBm96ZYUw7XyqzosnLhtHEEdLmMGXHP1VcDcKZl8bdka51iQQakPTwyl6oUcCb8gaQ5KzF6wqYV0PwcL7fJvBta/hm/4L+/Zy6t1st+bRPjE6A8FZCNt1UZYjekKtP5m8Baf+yEzZx7QxXDU=
Received: from DM6PR06CA0038.namprd06.prod.outlook.com (2603:10b6:5:54::15) by
 IA1PR12MB8468.namprd12.prod.outlook.com (2603:10b6:208:445::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.14; Wed, 20 Aug
 2025 20:21:11 +0000
Received: from CY4PEPF0000EE39.namprd03.prod.outlook.com
 (2603:10b6:5:54:cafe::d6) by DM6PR06CA0038.outlook.office365.com
 (2603:10b6:5:54::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9052.14 via Frontend Transport; Wed,
 20 Aug 2025 20:21:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CY4PEPF0000EE39.mail.protection.outlook.com (10.167.242.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9052.8 via Frontend Transport; Wed, 20 Aug 2025 20:21:11 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 20 Aug
 2025 15:21:08 -0500
Received: from aaurabin-tumbleweed.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Wed, 20 Aug 2025 15:21:07 -0500
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, Clay King <clayking@amd.com>, Joshua Aberback
 <joshua.aberback@amd.com>
Subject: [PATCH 06/12] drm/amd/display: Multiplication result converted to
 larger type
Date: Wed, 20 Aug 2025 16:19:56 -0400
Message-ID: <20250820202103.1122706-7-aurabindo.pillai@amd.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250820202103.1122706-1-aurabindo.pillai@amd.com>
References: <20250820202103.1122706-1-aurabindo.pillai@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: aurabindo.pillai@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE39:EE_|IA1PR12MB8468:EE_
X-MS-Office365-Filtering-Correlation-Id: ac11df5a-4b37-4630-86d7-08dde0271ae4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|30052699003|82310400026|376014|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?w24PvBUmXF5YWJAOVcidvJHl3yN+zmJkMAN+oJ8BRny1keNiATw6N3GSWUwy?=
 =?us-ascii?Q?KPUuCqqsWmZbkiisjyNLFokuTp24VZhJG94CqEk1VDpLlK2YjFuU43v5Du6v?=
 =?us-ascii?Q?0wdEMVcIGPH2Gk4p5iCVzgmUYWNPz3tmFjVlkBTnBeVdpRTE36IH3x2u0PIT?=
 =?us-ascii?Q?/32M66dsZ6dNsHGFQJBAvzxMJsQIR439JPbeVLD2ozoryirVIwPnPjU3Nsp/?=
 =?us-ascii?Q?q0CsSZlUC68MO5Oxk32Ya5sOk3rU17nK+o2D5+MfAwob4Eayz093vm364uz7?=
 =?us-ascii?Q?SmlVTLF/rqWxHgbkRIBBOXwbutXyg56gJr6ZTgrzbaB2vuFdpIMXlKw28i/J?=
 =?us-ascii?Q?duPSL2FIoM8DOYysFJ03BoUc6O4JuESz7/3StYiazJD3uGoTv8ey9o9wQwgo?=
 =?us-ascii?Q?Ue9aoIW/SS+Q/HbNk3Qlw8BRkCEdq2479HCj6RpgkeZFIxniM9WgZxGQw6xw?=
 =?us-ascii?Q?5FTtaoWfZwrQIbRFH+CvUFOimmUzaRJa4kkcVkkWlnDWf532GnmrdsV+PZPd?=
 =?us-ascii?Q?YCLb3VH1jPjQvcUE/aXs4tGI+xxwPq9v0fYHUhHo10lqVqNjjzCZscDwXqV4?=
 =?us-ascii?Q?KDh2Il4Kyf04M42CKooHhDT5zVpO1YcRJC1BX68WsLNE/PTIeVKK8jLLTU9q?=
 =?us-ascii?Q?6unoeZ0aP6lIZIb9lzBQrl0ipMUL5OM6AzmFYqT9KfhqpG1d0ctfl6VdRRbK?=
 =?us-ascii?Q?WZvWOEXfw4z9YXXnGVqEANCZRmUQPCRouw0EFmvY1nouPpyT/Y1IQodutJMl?=
 =?us-ascii?Q?2WW79qlV7VsgQ/WG/BeU0cnKu8fbWQh5fuqd33+3rqXI/9ETsPIFuatE1DyG?=
 =?us-ascii?Q?cuf74F8kbNB63jMLox8OxiITc+pHuvwZF9cnq9Nw9B+SqJW7mcMJ42crNoBD?=
 =?us-ascii?Q?cMKf5TZGMbqv6nKQDwebFQkkyCP/sifIbyev/YoFgVx+BjfCtam23E8jtdWg?=
 =?us-ascii?Q?FunJwi5Ii0xmdVrMrNKgShs+D1jew3VH5/LJDUtHbEFWeO3Vkcm9zCyqbJla?=
 =?us-ascii?Q?fGk1TcLVfpsJkI1mZuwJeBygWzEvoHBRC6IOYDGUME0sTVPVcWux/TIaiDFN?=
 =?us-ascii?Q?AgegZZKzTyumFb0Pk1JOHl8S+4eRywtAvPshebFore9Jr8MzG98PtbBe8aru?=
 =?us-ascii?Q?5qmHR78bRVbIEtxtvQRTHH0OT04KUgOtUKmdiKe808iI8+hmM1tYMxwyNxdh?=
 =?us-ascii?Q?QaTAQxS5WagpyaoTzYIULogX8qYclFHeyf4E/HyhsOQPp6frThZdLdmMRj/u?=
 =?us-ascii?Q?1Xh4DTeaxTL4iGiac3liOXSaJqRTWGBscEY7kezdGopGsuBD+VkOJ4P5/Bvx?=
 =?us-ascii?Q?bimu5DfUlNvxGRi2noQfLVj4linFVz8Pm5ULMLrUChiiAaWajNDAxS0NDzH7?=
 =?us-ascii?Q?5bue3PcmQWTjtZpPz5pl0sUUVKg7Qv+IoELuK89kFyqfSmsRh9Ic21YpbPKF?=
 =?us-ascii?Q?pPl0/Wk1MOHBEPLRm/BZrA5Ci0pr+5U9ht7cw89hp38Uf3DroM71Fe8hD5lD?=
 =?us-ascii?Q?8O6l5INPX1Ew7IgYctGEaxPlKXK6n3W5eAfz?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(30052699003)(82310400026)(376014)(36860700013)(1800799024);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2025 20:21:11.5113 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ac11df5a-4b37-4630-86d7-08dde0271ae4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE39.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8468
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

From: Clay King <clayking@amd.com>

Consolidating multiple CodeQL Fixes for alerts with rule id: cpp/integer-multiplication-cast-to-long

Reviewed-by: Joshua Aberback <joshua.aberback@amd.com>
Signed-off-by: Clay King <clayking@amd.com>
Signed-off-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
---
 drivers/gpu/drm/amd/display/dc/basics/dce_calcs.c    |  2 +-
 drivers/gpu/drm/amd/display/dc/basics/fixpt31_32.c   |  2 +-
 drivers/gpu/drm/amd/display/dc/basics/vector.c       |  6 +++---
 drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c |  2 +-
 .../amd/display/dc/mmhubbub/dcn20/dcn20_mmhubbub.c   |  2 +-
 .../amd/display/dc/resource/dce112/dce112_resource.c | 12 ++++++------
 .../amd/display/dc/resource/dce120/dce120_resource.c |  6 +++---
 7 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/basics/dce_calcs.c b/drivers/gpu/drm/amd/display/dc/basics/dce_calcs.c
index d897f8a30ede..4da5adab799c 100644
--- a/drivers/gpu/drm/amd/display/dc/basics/dce_calcs.c
+++ b/drivers/gpu/drm/amd/display/dc/basics/dce_calcs.c
@@ -1136,7 +1136,7 @@ static void calculate_bandwidth(
 			}
 		}
 	}
-	data->total_dmifmc_urgent_trips = bw_ceil2(bw_div(data->total_requests_for_adjusted_dmif_size, (bw_add(dceip->dmif_request_buffer_size, bw_int_to_fixed(vbios->number_of_request_slots_gmc_reserves_for_dmif_per_channel * data->number_of_dram_channels)))), bw_int_to_fixed(1));
+	data->total_dmifmc_urgent_trips = bw_ceil2(bw_div(data->total_requests_for_adjusted_dmif_size, (bw_add(dceip->dmif_request_buffer_size, bw_int_to_fixed((uint64_t)vbios->number_of_request_slots_gmc_reserves_for_dmif_per_channel * data->number_of_dram_channels)))), bw_int_to_fixed(1));
 	data->total_dmifmc_urgent_latency = bw_mul(vbios->dmifmc_urgent_latency, data->total_dmifmc_urgent_trips);
 	data->total_display_reads_required_data = bw_int_to_fixed(0);
 	data->total_display_reads_required_dram_access_data = bw_int_to_fixed(0);
diff --git a/drivers/gpu/drm/amd/display/dc/basics/fixpt31_32.c b/drivers/gpu/drm/amd/display/dc/basics/fixpt31_32.c
index 452206b5095e..6073cadde76c 100644
--- a/drivers/gpu/drm/amd/display/dc/basics/fixpt31_32.c
+++ b/drivers/gpu/drm/amd/display/dc/basics/fixpt31_32.c
@@ -284,7 +284,7 @@ struct fixed31_32 dc_fixpt_cos(struct fixed31_32 arg)
 				dc_fixpt_mul(
 					square,
 					res),
-				n * (n - 1)));
+				(long long)n * (n - 1)));
 
 		n -= 2;
 	} while (n != 0);
diff --git a/drivers/gpu/drm/amd/display/dc/basics/vector.c b/drivers/gpu/drm/amd/display/dc/basics/vector.c
index 6d2924114a3e..b413a672c2c0 100644
--- a/drivers/gpu/drm/amd/display/dc/basics/vector.c
+++ b/drivers/gpu/drm/amd/display/dc/basics/vector.c
@@ -170,7 +170,7 @@ bool dal_vector_remove_at_index(
 		memmove(
 			vector->container + (index * vector->struct_size),
 			vector->container + ((index + 1) * vector->struct_size),
-			(vector->count - index - 1) * vector->struct_size);
+			(size_t)(vector->count - index - 1) * vector->struct_size);
 	vector->count -= 1;
 
 	return true;
@@ -219,7 +219,7 @@ bool dal_vector_insert_at(
 		memmove(
 			insert_address + vector->struct_size,
 			insert_address,
-			vector->struct_size * (vector->count - position));
+			(size_t)vector->struct_size * (vector->count - position));
 
 	memmove(
 		insert_address,
@@ -271,7 +271,7 @@ struct vector *dal_vector_clone(
 
 	/* copy vector's data */
 	memmove(vec_cloned->container, vector->container,
-			vec_cloned->struct_size * vec_cloned->capacity);
+			(size_t)vec_cloned->struct_size * vec_cloned->capacity);
 
 	return vec_cloned;
 }
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c b/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
index 6160952245b4..7cd7bddea423 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
@@ -3401,7 +3401,7 @@ bool dcn32_allow_subvp_with_active_margin(struct pipe_ctx *pipe)
 		uint32_t height = subvp_active_margin_list.res[i].height;
 
 		refresh_rate = (pipe->stream->timing.pix_clk_100hz * (uint64_t)100 +
-			pipe->stream->timing.v_total * pipe->stream->timing.h_total - (uint64_t)1);
+			(uint64_t)pipe->stream->timing.v_total * pipe->stream->timing.h_total - (uint64_t)1);
 		refresh_rate = div_u64(refresh_rate, pipe->stream->timing.v_total);
 		refresh_rate = div_u64(refresh_rate, pipe->stream->timing.h_total);
 
diff --git a/drivers/gpu/drm/amd/display/dc/mmhubbub/dcn20/dcn20_mmhubbub.c b/drivers/gpu/drm/amd/display/dc/mmhubbub/dcn20/dcn20_mmhubbub.c
index 259a98e4ee2c..2a422e223bf2 100644
--- a/drivers/gpu/drm/amd/display/dc/mmhubbub/dcn20/dcn20_mmhubbub.c
+++ b/drivers/gpu/drm/amd/display/dc/mmhubbub/dcn20/dcn20_mmhubbub.c
@@ -284,7 +284,7 @@ void mcifwb2_dump_frame(struct mcif_wb *mcif_wb,
 
 	REG_UPDATE(MCIF_WB_BUFMGR_SW_CONTROL, MCIF_WB_BUFMGR_SW_LOCK, 0xf);
 
-	memcpy(dest_luma_buffer,   luma_buffer,   mcif_params->luma_pitch * dest_height);
+	memcpy(dest_luma_buffer,   luma_buffer,   (size_t)mcif_params->luma_pitch * dest_height);
 	memcpy(dest_chroma_buffer, chroma_buffer, mcif_params->chroma_pitch * dest_height / 2);
 
 	REG_UPDATE(MCIF_WB_BUFMGR_SW_CONTROL, MCIF_WB_BUFMGR_SW_LOCK, 0x0);
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dce112/dce112_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dce112/dce112_resource.c
index 164ba796f64c..869a8e515fc0 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dce112/dce112_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dce112/dce112_resource.c
@@ -1111,12 +1111,12 @@ static void bw_calcs_data_update_from_pplib(struct dc *dc)
 				&clks);
 
 		dc->bw_vbios->low_yclk = bw_frc_to_fixed(
-			clks.clocks_in_khz[0] * memory_type_multiplier, 1000);
+			(int64_t)clks.clocks_in_khz[0] * memory_type_multiplier, 1000);
 		dc->bw_vbios->mid_yclk = bw_frc_to_fixed(
-			clks.clocks_in_khz[clks.num_levels>>1] * memory_type_multiplier,
+			(int64_t)clks.clocks_in_khz[clks.num_levels>>1] * memory_type_multiplier,
 			1000);
 		dc->bw_vbios->high_yclk = bw_frc_to_fixed(
-			clks.clocks_in_khz[clks.num_levels-1] * memory_type_multiplier,
+			(int64_t)clks.clocks_in_khz[clks.num_levels-1] * memory_type_multiplier,
 			1000);
 
 		return;
@@ -1152,12 +1152,12 @@ static void bw_calcs_data_update_from_pplib(struct dc *dc)
 	 * YCLK = UMACLK*m_memoryTypeMultiplier
 	 */
 	dc->bw_vbios->low_yclk = bw_frc_to_fixed(
-		mem_clks.data[0].clocks_in_khz * memory_type_multiplier, 1000);
+		(int64_t)mem_clks.data[0].clocks_in_khz * memory_type_multiplier, 1000);
 	dc->bw_vbios->mid_yclk = bw_frc_to_fixed(
-		mem_clks.data[mem_clks.num_levels>>1].clocks_in_khz * memory_type_multiplier,
+		(int64_t)mem_clks.data[mem_clks.num_levels>>1].clocks_in_khz * memory_type_multiplier,
 		1000);
 	dc->bw_vbios->high_yclk = bw_frc_to_fixed(
-		mem_clks.data[mem_clks.num_levels-1].clocks_in_khz * memory_type_multiplier,
+		(int64_t)mem_clks.data[mem_clks.num_levels-1].clocks_in_khz * memory_type_multiplier,
 		1000);
 
 	/* Now notify PPLib/SMU about which Watermarks sets they should select
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dce120/dce120_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dce120/dce120_resource.c
index eb1e158d3436..2f23cc6df571 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dce120/dce120_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dce120/dce120_resource.c
@@ -990,12 +990,12 @@ static void bw_calcs_data_update_from_pplib(struct dc *dc)
 		memory_type_multiplier = MEMORY_TYPE_HBM;
 
 	dc->bw_vbios->low_yclk = bw_frc_to_fixed(
-		mem_clks.data[0].clocks_in_khz * memory_type_multiplier, 1000);
+		(int64_t)mem_clks.data[0].clocks_in_khz * memory_type_multiplier, 1000);
 	dc->bw_vbios->mid_yclk = bw_frc_to_fixed(
-		mem_clks.data[mem_clks.num_levels>>1].clocks_in_khz * memory_type_multiplier,
+		(int64_t)mem_clks.data[mem_clks.num_levels>>1].clocks_in_khz * memory_type_multiplier,
 		1000);
 	dc->bw_vbios->high_yclk = bw_frc_to_fixed(
-		mem_clks.data[mem_clks.num_levels-1].clocks_in_khz * memory_type_multiplier,
+		(int64_t)mem_clks.data[mem_clks.num_levels-1].clocks_in_khz * memory_type_multiplier,
 		1000);
 
 	/* Now notify PPLib/SMU about which Watermarks sets they should select
-- 
2.50.1

