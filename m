Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C4CFC3DA42
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Jul 2024 19:39:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 27CF610E8BB;
	Wed, 10 Jul 2024 19:39:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="vxRgXFGC";
	dkim-atps=neutral
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2052.outbound.protection.outlook.com [40.107.96.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1690910E8BB
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 Jul 2024 19:39:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BDSsM6WpLv/DLAUS1uuo8U2QK3GaVICzFduNkxaPXi9vEf/SOS6o6HOX63GBA9OVTkxQcN675bBKBtzT2j+DTAwzYrUbhfdodatzmVYuDKncf/G7ohcBXT2SNhYRjrPuVT4Gz6Hqz/xZ4C6FLxjfLUVNTJgQGI8m14L2orM9hWD+K/bPdpBbvV/9UFmBu7CRAoUhhg4M5TFioZqysoRbIxdlTG9PhJ75op6h+huhGagztwg12dloXrqRlAjd5hzjX8kiVO8Bvro0aERLBlx1LtM3vq5KnuLbbad9mBqY255I1v50qaBNsOKV2eRLjh+o9W40+pua1fgjJ2BnYcgOZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8qBfXB8rzCyMhSYfg6eGOs/H6GqIO/+DcIxeU6pZqUA=;
 b=e0G2DuciUN1X1iP8NuQvYfPrTcIJ3W8JquL7CzRkSmP7Rxw2g6WwLA/+IlkvMiYpzeDLLbL5JBaWCYhvwO32vvzWBc/8PGck26/vhG39lnzKWx26x9UlFUuGMwxorzFO6hEfBon23IOv407EfGOFAz7YYYAitypf6H9rCSM7/+/38Bg0lXeVKEFinJgl7aEgqQZRgld0OoVGyksW6jMymR7k/tqOxXg3SVe7WYk+RwVp43N2vfaULd5bK7ohGnU1RX/BB0dUlbjnpJ4UshGCv7D5vn7r4m2PW73jT/nte2/xL9rflUXYN6WfOfSWVZ3vQgCgBXmvkayTzJVFCmGJ5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8qBfXB8rzCyMhSYfg6eGOs/H6GqIO/+DcIxeU6pZqUA=;
 b=vxRgXFGC/SL4Qm3uHDhwvs0EV8kISurRHTBDPjYR+JjnWG5zooQlrc0Hg3QekUpo9ah729jm8KPImHIo2C6ZFwZw3pZY2ZqaHO189nUeHMBFZP/Mj7ObVZ18IkZbunw5HiMUFp1PtZwInlQRycLxJqhNkjDd5BD6+0CcVlNpHms=
Received: from MN2PR22CA0003.namprd22.prod.outlook.com (2603:10b6:208:238::8)
 by SA1PR12MB6702.namprd12.prod.outlook.com (2603:10b6:806:252::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.19; Wed, 10 Jul
 2024 19:39:36 +0000
Received: from MN1PEPF0000ECD7.namprd02.prod.outlook.com
 (2603:10b6:208:238:cafe::73) by MN2PR22CA0003.outlook.office365.com
 (2603:10b6:208:238::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.36 via Frontend
 Transport; Wed, 10 Jul 2024 19:39:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MN1PEPF0000ECD7.mail.protection.outlook.com (10.167.242.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7762.17 via Frontend Transport; Wed, 10 Jul 2024 19:39:35 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 10 Jul
 2024 14:39:34 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 10 Jul
 2024 14:39:34 -0500
Received: from smtp.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Wed, 10 Jul 2024 14:39:33 -0500
From: Fangzhi Zuo <Jerry.Zuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <jerry.zuo@amd.com>, Dillon Varone <dillon.varone@amd.com>, Chaitanya Dhere
 <chaitanya.dhere@amd.com>
Subject: [PATCH 30/50] drm/amd/display: Add blanked streams override to DML2.1
Date: Wed, 10 Jul 2024 15:36:47 -0400
Message-ID: <20240710193707.43754-31-Jerry.Zuo@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240710193707.43754-1-Jerry.Zuo@amd.com>
References: <20240710193707.43754-1-Jerry.Zuo@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: Jerry.Zuo@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD7:EE_|SA1PR12MB6702:EE_
X-MS-Office365-Filtering-Correlation-Id: 395ebba0-9eca-4967-6c29-08dca1180797
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?UKZ1Ge5g68khOOsjnLwbnN4rFJfLbPmAodilm7w+NI6ijEigi+qJaGVF3qvz?=
 =?us-ascii?Q?GH5XYyo1sWwYVvQZaiJh5SevugOvLATlCsV/su7QLt2TYCY+IYQE/c8NAMcV?=
 =?us-ascii?Q?PKVJ251W+ZZZWs4NbGwGsf+CaYTgibWiIUBoUFtJx18KOVI6TJ6PjwkY/uMe?=
 =?us-ascii?Q?T3If1fS4M6E3ZF+EsJI6a6VF/aFHydkBR97QCZ4vV+6nPhfNyHINr1epIOA3?=
 =?us-ascii?Q?A9Dnrboj/8GvpeWOXk0KtaPAxnuqqe+U0KPsgpI+MwV5u0sgOBu0KUlOTZ5v?=
 =?us-ascii?Q?01+jSih9Sk5c5MhLe72MzL5Wygz3ZafVT+RKxPqKIPcKIMgqBq2E58Wpu5LG?=
 =?us-ascii?Q?PUSya6Osy+L+ffNFD0s0ZDB7sfyDQcJQhkU4R2ycOfsktmSfrLrMmww8oeu6?=
 =?us-ascii?Q?cp+kgXNAqlNAwe6V+eMubpZnXIrUfQHtCnCa3RTKyCQsl3nj6KYw9toNitvo?=
 =?us-ascii?Q?SM55deNq5Dyuhqn3iQeIgZJPWUf7OkA3CoVbqHBRz5EZcJsPX+CJwIzetQ8k?=
 =?us-ascii?Q?K96uCxLQJymacjsJoIN0dHPmgqR+hF4lnLIxiKEg7LyEGACwyYBE+0W9O1l0?=
 =?us-ascii?Q?aO9TzmcJZMeTNzzRNXHvDGXJNE1qpw2Aspk5UbTI3LS8f1gj05vM5SuTPGyh?=
 =?us-ascii?Q?+spgeXOe4dbQ+pQsBk27nU4rDRUudVTuLOfTFz8ZYGfnNqftQYWTdgUXHl17?=
 =?us-ascii?Q?o4LPtUDCv2N3Jd/bt393e+NYijxm8sPDkkKOYncJBmh/8ftD2EZUAtCVyzQd?=
 =?us-ascii?Q?9FMgRE8OB3vENkxdxKuG6WFuT/u+eVoUCy7f8aRF8rU/mK6nEnNbOE6Zam00?=
 =?us-ascii?Q?dzSK8Guk4uZbyXTJxrrjJKyitFXyJSmBngAt/uW73JNWn1RO169yaJfQZ6zY?=
 =?us-ascii?Q?N/GKkWOyaUuB4qt0I9P96M+BdvMhDIwBLBQmIGO0TWmhAofROwaMKDaN0Gb1?=
 =?us-ascii?Q?uwKbucprtk+22ELbpLYd5mBBUVTrqLitIDTcZ0VAcaTr4cZJAohOvSCf2Lap?=
 =?us-ascii?Q?9isF23MeLXr77QV0T4wCoFRkcn7lHpSGgk0vcJgdR+cEj1ogDdwjkJo3gwJk?=
 =?us-ascii?Q?h3cG2uVRDgOpZI29ND6tPEKNJPtRY49SfnP1xhq23wf0CVVnZZ+Sml0efuZt?=
 =?us-ascii?Q?Q6184B5hQzzXMO98MqWT+zELhcZ6dDnUypQBsXWJjZCeCzdCIGVL2kCbavMr?=
 =?us-ascii?Q?sgMYKqtR9jBmZBEmAuPehyJuYGWe0BzWHjKNe96KiPPjObuOd+InXqL6TIiC?=
 =?us-ascii?Q?lPEpaQ7BEKe5fbmY4DZR9p1rmj5JdkYs3E6vP9OPKYpBX2dJ/iREkTqsi53Z?=
 =?us-ascii?Q?39ONXXBw1j7Nqcyxn6vnJpwQNgPV2Wi2qGkgRjn4HR6lsh5yLIHtWaC2RPKN?=
 =?us-ascii?Q?Be+b7Jtepp5fcODFMAfhiKHN2vDaUGDe3/iPjtYVv2xSg5qBah/9sILTo9/W?=
 =?us-ascii?Q?KFXdwvV5c1MrjfbYHb90AEVNYRk4zRW0?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2024 19:39:35.6075 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 395ebba0-9eca-4967-6c29-08dca1180797
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000ECD7.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6702
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

From: Dillon Varone <dillon.varone@amd.com>

[WHY]
DML2.1 currently has no concept of a "blanked" stream. For cases like DPMS off,
things like UCLK p-state is always allowed, so PMO is not required to optimize
for it.

[HOW]
Add flag to DML2.1 display configuration to indicate all streams are blanked,
so certain operations and optimizations can be skipped for optimal programming
when displays are blanked.

Reviewed-by: Chaitanya Dhere <chaitanya.dhere@amd.com>
Signed-off-by: Jerry Zuo <jerry.zuo@amd.com>
Signed-off-by: Dillon Varone <dillon.varone@amd.com>
---
 .../amd/display/dc/dml2/dml21/dml21_translation_helper.c   | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dml2/dml21/dml21_translation_helper.c b/drivers/gpu/drm/amd/display/dc/dml2/dml21/dml21_translation_helper.c
index 405544920f3b..e9647f068ee4 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2/dml21/dml21_translation_helper.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2/dml21/dml21_translation_helper.c
@@ -957,6 +957,7 @@ bool dml21_map_dc_state_into_dml_display_cfg(const struct dc *in_dc, struct dc_s
 	int stream_index, plane_index;
 	int disp_cfg_stream_location, disp_cfg_plane_location;
 	struct dml2_display_cfg *dml_dispcfg = &dml_ctx->v21.display_config;
+	unsigned int plane_count = 0;
 
 	memset(&dml_ctx->v21.dml_to_dc_pipe_mapping, 0, sizeof(struct dml2_dml_to_dc_pipe_mapping));
 
@@ -1010,10 +1011,16 @@ bool dml21_map_dc_state_into_dml_display_cfg(const struct dc *in_dc, struct dc_s
 					dml_dispcfg->plane_descriptors[disp_cfg_plane_location].overrides.uclk_pstate_change_strategy =
 							dml21_force_pstate_method_to_uclk_state_change_strategy(dml_ctx->config.pmo.force_pstate_method_values[stream_index]);
 				}
+
+				plane_count++;
 			}
 		}
 	}
 
+	if (plane_count == 0) {
+		dml_dispcfg->overrides.all_streams_blanked = true;
+	}
+
 	return true;
 }
 
-- 
2.34.1

