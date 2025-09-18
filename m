Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9549CAC59A
	for <amd-gfx@archiver.kernel.org>; Thu, 18 Sep 2025 13:17:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 70DB810E190;
	Thu, 18 Sep 2025 13:17:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="v8NhRz6j";
	dkim-atps=neutral
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010010.outbound.protection.outlook.com
 [40.93.198.10])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4E78F10E190
 for <amd-gfx@lists.freedesktop.org>; Thu, 18 Sep 2025 13:17:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KbwLvM2nVCcr4KDhqJB7VYudTQ1MxgVaPloZ9A4tAsm3VLV3Y2mBBrboWQUlkK8hurzjidBAT0JIQL2DjMaSMqLMG4p0bjTOQNjgHuBYzvpw80pk3GkQbI6HPxUgSb9NOnQw9pkCAkJp6lC5hEC7Yfhxpn+hQi9NGrUvg+NjXDbz39R19m7E+TbFXj36hQJybHe8+xSgRt8vIqeRvmGVkAudgy+vEf9dP4q+zknD3CleeHVKULn5tAHZPc5iWUQQB1WLj3ln6/vZstl3lUUim6bMjelp0GD7FtqUeUPrxQBli82wQjng9w4FejvfyOO6dSLE5yW2LuxsrArDl6ZroA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QODk943yZl68xkv0E9RCvkJ/B9rSAoan9PFpojWFrN0=;
 b=BT8SAYqQROUI/CcMFYDALTIX6N9Oa3epcpURpir58iPkO9I1DgpR6A/8WU2Kjqbd/HepOqqZV9N/KmQ+KqgimCGxAr/x+hK0KHLIj6XjW/m5ZEDdM1Zsur5xw2Banbnz9I7MrMoZCe1JXSiyNlSAkMf7ty2ebdbmzztpoNjIcBfl3xNMPYxQUTe3UxcbOWfb0AGtm59jy/7VXBRYCoAa3g4/Q3hgqcjXD4Y9wQH48pAbX5ZedUlm00xj8BZwRgD7HcwfaZgQfUBJgkHmgEbCyAMTga0C8omLVmmJCscLH0USS4Om7LTSxrsGCD9e1YXoMtUvRVZ4VyhrHp/OJ2xBsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QODk943yZl68xkv0E9RCvkJ/B9rSAoan9PFpojWFrN0=;
 b=v8NhRz6j9f8xiGL4RSh74Ou4d4Y46c9Bh4o9af5XsIJbZ1JBaXxGCVuB7CMHcL7rGodL83gWmNb5nYdlesXEmd6DJlcspZSQ+N7t6HXnwRfHMk8cfLCrZbcoS1mlCcvjNlyHXVtNych8lsC4LAdGnGPnzw8azT8ZGLB8pP0bSQ0=
Received: from CH0PR03CA0240.namprd03.prod.outlook.com (2603:10b6:610:e7::35)
 by DM4PR12MB6304.namprd12.prod.outlook.com (2603:10b6:8:a2::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9137.13; Thu, 18 Sep 2025 13:17:23 +0000
Received: from CH1PEPF0000A347.namprd04.prod.outlook.com
 (2603:10b6:610:e7:cafe::15) by CH0PR03CA0240.outlook.office365.com
 (2603:10b6:610:e7::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.14 via Frontend Transport; Thu,
 18 Sep 2025 13:17:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH1PEPF0000A347.mail.protection.outlook.com (10.167.244.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9137.12 via Frontend Transport; Thu, 18 Sep 2025 13:17:22 +0000
Received: from yifan.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 18 Sep
 2025 06:17:20 -0700
From: Yifan Zhang <yifan1.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <Christian.Koenig@amd.com>,
 <Mario.Limonciello@amd.com>, Yifan Zhang <yifan1.zhang@amd.com>
Subject: [PATCH] drm/amdgpu: add module parameter enable_lr_compute_wa
Date: Thu, 18 Sep 2025 21:16:50 +0800
Message-ID: <20250918131650.943412-1-yifan1.zhang@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000A347:EE_|DM4PR12MB6304:EE_
X-MS-Office365-Filtering-Correlation-Id: 03d01bc4-315d-42f6-cc0e-08ddf6b5b443
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?JzXXqh13XRGbpi2vbsNMPtWVxav3v6/V2tYvN0IxodInl7Zut66ijga0QEJt?=
 =?us-ascii?Q?yC2wDTqCU5J+MPWBJZjlC9eY2mK0WVxCXJnV0QtoGVempanOR5yKsiuxH8CA?=
 =?us-ascii?Q?v177rKnUtEUHZ2bJfR0gWnK4pd015gM11A2ZCnIP5/cKG43ijGiEXQ7oF9nj?=
 =?us-ascii?Q?gOTsICoFgDeQTUd5Mps688SsR2pZ5btvIYzPY9yvQnQBNempsjzVG/ZSC2GF?=
 =?us-ascii?Q?XdvKpjnaeBk1wvgZKOVu6xq3XxHzfUEEBKAeDmxVYi4IlxTB3JaCnvOHcTQR?=
 =?us-ascii?Q?Tufpvkh/VwtSae+ZlwG+deKDGiQabPwq0eizjMYEFTdBLY//AB0c4GRHnBUX?=
 =?us-ascii?Q?C/Dwa1YtAiL+gaUjrowltkxkakAVH9ioDi9GWrmbNJiEaztjnOljPsOa+4WK?=
 =?us-ascii?Q?Rd0luPQAf1Zccw1F3E2kTTaHF/aDjnMkUwOo8Iu0Gbkny/Ewjado0JJJ213v?=
 =?us-ascii?Q?qBq2B+YlbT6zVqvoQa1b9bb3xChIV8Tmo8PlvFkg81JbSU/5hEZv8SN+nlXw?=
 =?us-ascii?Q?G3s2O6JeVTWzZ+MW+wS53wkelqEbLuqRymuYTC/2tpxRXTb5LQhynnWSqfGd?=
 =?us-ascii?Q?eOP8E//HPmkOAw5WNuEZi9UD6cS3MBWFdoUDbPsGb2+pDgeBYlUSZ8c0aePH?=
 =?us-ascii?Q?YyIINrrtxYq4oq18cIV9+PCa/Xzq2XWfiu1nWtJdh1hcaz/+fdrwN3N95tao?=
 =?us-ascii?Q?nMkEKRSFdLTPjip4LFXzJYrhFGYCeERAGPbSMWrht6n8Kb1Bg2SklgJrVXeN?=
 =?us-ascii?Q?U8QxTgee7IMY0FnPlP+HX+l+F5GOT5NxmoZdCR/iJ4VVKeASpx/AFc+YCGKj?=
 =?us-ascii?Q?d0+Jv7eJEO99CNYn4/uP07f8W0qnIV4kmmeSvFPXZnsz0sGc4JVT6fIJeOeZ?=
 =?us-ascii?Q?/MNfN/8YGN3xfNVvfiy/zUlxQVUK937gmsHco/LXfc9tR3GgXPEuGSl32lR+?=
 =?us-ascii?Q?NFW9QpXvbSFfQd6uFUz4LOEOjRnmWbSrC+KF9A4vO3/ZWfU2wMZmVy76ptpf?=
 =?us-ascii?Q?Vew9V1OjDG1DpqIvxAwUMZZYJlAARP5ZGyhyUJuVdru4p7V52dbL8FV/Lk4v?=
 =?us-ascii?Q?fj9kr2nHjESzGKKDRil3bAwHUsAt917uNR0hSZZHOUvqCZzBEzYAv0oV+3RB?=
 =?us-ascii?Q?GAtN8++br5/5VYgp+a6WueVWvTzW+r5j0X2eCnzqtVTbhdX8UAkHLscGewwC?=
 =?us-ascii?Q?6qr6nUYunYypu8yzc2+B/fhk5xCRNBOabtWKE6vuDp0amlW17LYkdfclmIdS?=
 =?us-ascii?Q?QD6QwpIVohWsOZexU/v1GKJkQQz7b9RTB+p2X4RskdykPWzqFbDacpa28x9N?=
 =?us-ascii?Q?98wiRlIIVrHwu588/rBd4XLfMNlILvuI/EewIcVDKTez+lflw/yp6pmcE18u?=
 =?us-ascii?Q?IGI1WAfF97VbUTkrNWCG9oeA070G3IQaa1QQflwBxgXQhsKVPMiFWN1eIcWD?=
 =?us-ascii?Q?qg8N2HYa8Z2bVm6L/BW4xLAu+bmg639O2ax2qmCzrcRoiVNmb4U1w5rpl20U?=
 =?us-ascii?Q?mceXlBBNHtEPYj2neGI1TM6OiK8LnAizvf9s?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2025 13:17:22.9597 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 03d01bc4-315d-42f6-cc0e-08ddf6b5b443
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000A347.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6304
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

Default value is 0. No functional change with this patch.

Signed-off-by: Yifan Zhang <yifan1.zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h           |  1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c       | 11 +++++++++++
 drivers/gpu/drm/amd/amdgpu/mes_v11_0.c        |  2 ++
 drivers/gpu/drm/amd/amdgpu/mes_v12_0.c        |  1 +
 drivers/gpu/drm/amd/include/mes_v11_api_def.h |  3 ++-
 drivers/gpu/drm/amd/include/mes_v12_api_def.h |  3 ++-
 6 files changed, 19 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index 2a0df4cabb99..6d520d0fa195 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -226,6 +226,7 @@ extern int amdgpu_mes;
 extern int amdgpu_mes_log_enable;
 extern int amdgpu_mes_kiq;
 extern int amdgpu_uni_mes;
+extern int amdgpu_enable_lr_compute_wa;
 extern int amdgpu_noretry;
 extern int amdgpu_force_asic_type;
 extern int amdgpu_smartshift_bias;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index ece251cbe8c3..18fad4d78331 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -224,6 +224,7 @@ int amdgpu_discovery = -1;
 int amdgpu_mes;
 int amdgpu_mes_log_enable = 0;
 int amdgpu_mes_kiq;
+int amdgpu_enable_lr_compute_wa;
 int amdgpu_uni_mes = 1;
 int amdgpu_noretry = -1;
 int amdgpu_force_asic_type = -1;
@@ -729,6 +730,16 @@ MODULE_PARM_DESC(uni_mes,
 	"Enable Unified Micro Engine Scheduler (0 = disabled, 1 = enabled(default)");
 module_param_named(uni_mes, amdgpu_uni_mes, int, 0444);
 
+/**
+ * DOC: mes_lr_compute_wa (int)
+ * Long Running Compute WA.
+ * (0 = disabled (default), 1 = enabled)
+ */
+MODULE_PARM_DESC(enable_lr_compute_wa,
+	"Enable MES Long Run Compute WA (0 = disabled(default), 1 = enabled");
+module_param_named(enable_lr_compute_wa, amdgpu_enable_lr_compute_wa, int, 0444);
+
+
 /**
  * DOC: noretry (int)
  * Disable XNACK retry in the SQ by default on GFXv9 hardware. On ASICs that
diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
index 3b91ea601add..1156a19e02dd 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
@@ -713,6 +713,8 @@ static int mes_v11_0_set_hw_resources(struct amdgpu_mes *mes)
 	mes_set_hw_res_pkt.enable_reg_active_poll = 1;
 	mes_set_hw_res_pkt.enable_level_process_quantum_check = 1;
 	mes_set_hw_res_pkt.oversubscription_timer = 50;
+	mes_set_hw_res_pkt.enable_lr_compute_wa = amdgpu_enable_lr_compute_wa;
+
 	if (amdgpu_mes_log_enable) {
 		mes_set_hw_res_pkt.enable_mes_event_int_logging = 1;
 		mes_set_hw_res_pkt.event_intr_history_gpu_mc_ptr =
diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c b/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
index 998893dff08e..354f6e29a18f 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
@@ -769,6 +769,7 @@ static int mes_v12_0_set_hw_resources(struct amdgpu_mes *mes, int pipe)
 	mes_set_hw_res_pkt.use_different_vmid_compute = 1;
 	mes_set_hw_res_pkt.enable_reg_active_poll = 1;
 	mes_set_hw_res_pkt.enable_level_process_quantum_check = 1;
+	mes_set_hw_res_pkt.enable_lr_compute_wa = amdgpu_enable_lr_compute_wa;
 
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
2.43.0

