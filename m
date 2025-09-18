Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0B38CA1013
	for <amd-gfx@archiver.kernel.org>; Thu, 18 Sep 2025 18:42:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 32CE310E8DF;
	Thu, 18 Sep 2025 18:42:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="DEQ0uCWu";
	dkim-atps=neutral
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010047.outbound.protection.outlook.com
 [52.101.193.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 85B0210E8DF
 for <amd-gfx@lists.freedesktop.org>; Thu, 18 Sep 2025 18:42:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rh7hf2fxzRm+0sOTY3NoepeCIl/nb20e6JuespwiQ1t1RMnJqhG2MSA/wb2Kak/gkccL5PT3IIT9lPhTdgqjMiURXF004/mMhfCJFxJ3M/jgiXwsAmnLEyPIfhUgMkfL7rZHeRuMIfXxyGApW63IGyqocZgcxJjWf4Jq7rrITi2yVvmVh1dUScboJJuKAbZJohKBkeXLQCrGMe1Hyj9xVeYlchX4nJLGGWzlHxUH9JF2Wd56QaNmNMh/TjEDMiJW/rbZIHc785oBS5CJMUeEDZlPNMHccMTSzNhdoiQ99K1wMUOFo7eESQDUd2PWZgBtgdEmiyEUduI6LPmZq0WheQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GgwRRsQ4Kx7zgA9OEhqB3WvuahYyF+ByPnEfPVPXPAM=;
 b=cJwFaKhJoIZZBtTvlEyQ554/RzsbgTHLyKfSu/JNN67cWzGAPKG4nr+m/aDeMRvHfZ5i86NuxchAG3pU6i2mLZj4V/yUh5XqCFfzFcKPqp0LeVB722mqR2y4Wd5Aql6p20d/R0yh/4VreIVxNVzIeOjzHPDhLgahY7re5dgGv+PvX0/otfOY4mej8suj3i0avDkTQeJuz7omkou4C5I4NR7s+lbTcBOWdZu1cwwAjlvPzkrGH0srVU0Q+oIVtovfaO4kBBtLgwdNcTVmWtnV0P650ePNgtyftjQGy371x54u5y7qeo2WJ7eCbfHvFF4EED+1Mai5JOzhRkyz84wsVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GgwRRsQ4Kx7zgA9OEhqB3WvuahYyF+ByPnEfPVPXPAM=;
 b=DEQ0uCWucadUbEyvW9c/+GSX75eUzoCEQMsMe0gqIAEnYXPA5Xr8ZqJRZ47R86wxRottb7Ekv+0T32zVCauKjGCJgtQeFX1rdA9tQ/N/2dQi4MK0S34b/81Qlcx0pXfVTXS6+dCoRxvvq4A0YJItNd0GVa0obIuWsNvh+L80FXQ=
Received: from PH7PR02CA0013.namprd02.prod.outlook.com (2603:10b6:510:33d::21)
 by MN0PR12MB6029.namprd12.prod.outlook.com (2603:10b6:208:3cf::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.13; Thu, 18 Sep
 2025 18:42:40 +0000
Received: from SJ1PEPF000026C3.namprd04.prod.outlook.com
 (2603:10b6:510:33d:cafe::74) by PH7PR02CA0013.outlook.office365.com
 (2603:10b6:510:33d::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.13 via Frontend Transport; Thu,
 18 Sep 2025 18:42:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF000026C3.mail.protection.outlook.com (10.167.244.100) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9137.12 via Frontend Transport; Thu, 18 Sep 2025 18:42:39 +0000
Received: from dogwood-dvt-marlim.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 18 Sep 2025 11:42:39 -0700
From: Mario Limonciello <mario.limonciello@amd.com>
To: <mario.limonciello@amd.com>, <amd-gfx@lists.freedesktop.org>
CC: Yifan Zhang <yifan1.zhang@amd.com>
Subject: [PATCH v2] drm/amdgpu: Enable MES lr_compute_wa by default
Date: Thu, 18 Sep 2025 13:41:50 -0500
Message-ID: <20250918184150.394532-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000026C3:EE_|MN0PR12MB6029:EE_
X-MS-Office365-Filtering-Correlation-Id: 9c0e6967-3e18-498a-32c2-08ddf6e3253a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ylyvVFx5xmZl5v0bsO4B2MHSRLY+Sf5dRjuam0/JlWE0bg4OWYoAIh4xjIBi?=
 =?us-ascii?Q?BUCvcB4NXXtXP5I4YU8l4JtTrlw7rwmtWBUKAO5UDumBmr74O0d9Wkw2BpR/?=
 =?us-ascii?Q?ryH4w0fonHGPgUgZOcZVIg+h/GNjGZB7BItYbBCZi82nqcsIfRHeYuB36fpK?=
 =?us-ascii?Q?YQzPsUOvdis44EpUgpZ7wHxFghrlA8N/cKe9+8nAkT22YgwtIWhyrwL0B3SM?=
 =?us-ascii?Q?Q1LrgNZIO9k7ECVGdUZnyMb0zyi1qpiGZhtia7hB2C2rOOXUq6o2oWAGrboX?=
 =?us-ascii?Q?x6QP0WiV/YPiPq39R1ET1dag/+SEFn8Q4PLLju69X3Zk2wMqKjqcpVNNhjz7?=
 =?us-ascii?Q?EBRooAjyIPI3Mycq2UJcrtGbD6M5qUU6/8WYutSUlOezh38hQM3zxvEVuatT?=
 =?us-ascii?Q?6+kupYxuwc8ITOTKNBiz+KuZh5eZOWIlawSko4isO4fWba6euLJ7A9OT+NPp?=
 =?us-ascii?Q?ZwZtSUOgW5LY2FoyRjmZ6xAsYTDTnBacuWHXidoRd74PcKf3o2BupexMXitV?=
 =?us-ascii?Q?m8h0npzXJPrM5ixNNrp0s+c9ZN17oBFlJ4VVfqYfGFTMxI073wUE3yYA2Wat?=
 =?us-ascii?Q?4iyicIQLnUIpuSHX8iEN/MZtiZ77wrV/dWmCxmImMjHYSWGkzay++APYLD6d?=
 =?us-ascii?Q?iUSlqHkvCHo5M//fQ+Y71fBqfkKYb0BbSLsHR/X0U4iy2wzb2VXgZBquJGTD?=
 =?us-ascii?Q?NcSTTbAOD9FHTNq7US1OJzw0VyEBH0YAVm90vFaWUup+omxwmga+bxeLGdaP?=
 =?us-ascii?Q?onsyrwuE94Da+IMr58Fb0N/rnHHKob4O9SD5pjGs58aJ0jv8ygUB1hRNL0C0?=
 =?us-ascii?Q?S56ryHC+h4Eivhmqru1FgsCMZqQJp3e4aLMM1nqCXhlfvFr3n6XV10vqtbTQ?=
 =?us-ascii?Q?lhpzXcsn0tlSxOd/94xSgOrcvs8mZeD0fkxxiYnuXmb0Xmgfqlx4spfAYUNs?=
 =?us-ascii?Q?h3+rFiejRk5ZVYf/J1RkjLkYYGtSo/m5SYiQozf4z8ulQW8MBVWVoGjn6Z3e?=
 =?us-ascii?Q?Nfq4GT7zPt/s9IDb5dhpZb5OG3kagj9b/XQqkT9o86sqCHKye9NMLIYAeGtB?=
 =?us-ascii?Q?9KhE+AOdjmxe64EVSexnprVGvmF9+U7rTZ4xCy6VSxxpRnMpss5vI7WXYN07?=
 =?us-ascii?Q?+XQIfC/DevR3WhbMpMHH8O1i7DnhMXcY/2ExSM2rxGI1kfbrfG+ynMRTs0HM?=
 =?us-ascii?Q?9o4SS/buCt4T/rqzsfo/7Aa/p3u2BWREIKcoGPFXixXMmIDKNAM6X8v0bt0D?=
 =?us-ascii?Q?ZpD5kduQd5C9xkqM+kmTPlSVNY4jEUymQkmvyvFel4Z+yv1Q7D02mQWAmD5S?=
 =?us-ascii?Q?i27Moiw9edNibUxdU5lkaBwBdsEwH6MrLILZvYplmKfLwuwzlynkiPi/FOyL?=
 =?us-ascii?Q?KoeVHquAo+3BavRiDlWN1oJrgnrnm1aK9pzxUZDeLtoS/ddeAtYUOuYBCUD3?=
 =?us-ascii?Q?xOCWaIlLBv32xy5hevvgyE5jO1ovCeXISqQ0mJ8TD8remZj15etRP8gaALGb?=
 =?us-ascii?Q?BInnyyPhWJpbVEvnZ3kjLGHZmr8V3qMT7Yv9?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2025 18:42:39.7717 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c0e6967-3e18-498a-32c2-08ddf6e3253a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000026C3.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6029
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

The MES set resources packet has an optional bit 'lr_compute_wa'
which can be used for preventing MES hangs on long compute jobs.

Set this bit by default.

Co-developed-by: Yifan Zhang <yifan1.zhang@amd.com>
Signed-off-by: Yifan Zhang <yifan1.zhang@amd.com>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
v2:
 * drop module parameter
 * add more description to commit text
---
 drivers/gpu/drm/amd/amdgpu/mes_v11_0.c        | 2 ++
 drivers/gpu/drm/amd/amdgpu/mes_v12_0.c        | 1 +
 drivers/gpu/drm/amd/include/mes_v11_api_def.h | 3 ++-
 drivers/gpu/drm/amd/include/mes_v12_api_def.h | 3 ++-
 4 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
index 3b91ea601add..540b514312b1 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
@@ -713,6 +713,8 @@ static int mes_v11_0_set_hw_resources(struct amdgpu_mes *mes)
 	mes_set_hw_res_pkt.enable_reg_active_poll = 1;
 	mes_set_hw_res_pkt.enable_level_process_quantum_check = 1;
 	mes_set_hw_res_pkt.oversubscription_timer = 50;
+	mes_set_hw_res_pkt.enable_lr_compute_wa = 1;
+
 	if (amdgpu_mes_log_enable) {
 		mes_set_hw_res_pkt.enable_mes_event_int_logging = 1;
 		mes_set_hw_res_pkt.event_intr_history_gpu_mc_ptr =
diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c b/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
index 998893dff08e..01266eef65cb 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
@@ -769,6 +769,7 @@ static int mes_v12_0_set_hw_resources(struct amdgpu_mes *mes, int pipe)
 	mes_set_hw_res_pkt.use_different_vmid_compute = 1;
 	mes_set_hw_res_pkt.enable_reg_active_poll = 1;
 	mes_set_hw_res_pkt.enable_level_process_quantum_check = 1;
+	mes_set_hw_res_pkt.enable_lr_compute_wa = 1;
 
 	/*
 	 * Keep oversubscribe timer for sdma . When we have unmapped doorbell
diff --git a/drivers/gpu/drm/amd/include/mes_v11_api_def.h b/drivers/gpu/drm/amd/include/mes_v11_api_def.h
index 15680c3f4970..ab1cfc92dbeb 100644
--- a/drivers/gpu/drm/amd/include/mes_v11_api_def.h
+++ b/drivers/gpu/drm/amd/include/mes_v11_api_def.h
@@ -238,7 +238,8 @@ union MESAPI_SET_HW_RESOURCES {
 				uint32_t enable_mes_sch_stb_log : 1;
 				uint32_t limit_single_process : 1;
 				uint32_t is_strix_tmz_wa_enabled  :1;
-				uint32_t reserved : 13;
+				uint32_t enable_lr_compute_wa : 1;
+				uint32_t reserved : 12;
 			};
 			uint32_t	uint32_t_all;
 		};
diff --git a/drivers/gpu/drm/amd/include/mes_v12_api_def.h b/drivers/gpu/drm/amd/include/mes_v12_api_def.h
index c04bd351b250..69611c7e30e3 100644
--- a/drivers/gpu/drm/amd/include/mes_v12_api_def.h
+++ b/drivers/gpu/drm/amd/include/mes_v12_api_def.h
@@ -287,7 +287,8 @@ union MESAPI_SET_HW_RESOURCES {
 				uint32_t limit_single_process : 1;
 				uint32_t unmapped_doorbell_handling: 2;
 				uint32_t enable_mes_fence_int: 1;
-				uint32_t reserved : 10;
+				uint32_t enable_lr_compute_wa : 1;
+				uint32_t reserved : 9;
 			};
 			uint32_t uint32_all;
 		};
-- 
2.49.0

