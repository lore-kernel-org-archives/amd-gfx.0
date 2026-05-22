Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C912BCD5BAF
	for <amd-gfx@archiver.kernel.org>; Fri, 22 May 2026 00:22:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5F63610F47A;
	Fri, 22 May 2026 00:22:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="xsF6bgVd";
	dkim-atps=neutral
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010055.outbound.protection.outlook.com
 [52.101.193.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D910910F4A3
 for <amd-gfx@lists.freedesktop.org>; Fri, 22 May 2026 00:22:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FOLtunE3TNC5TDBrS9VQXWQ6wyJiTch0meFlDkxlaTMDD37fH3CUxBxPNRDc21bXs+04rUx46t290Jg+1egna79KlSq99W3EDzIMeeW5aYNekV5Q0lY0vblkLCddLONRvInzbiZL4b0zJpQOCMmNsz34wdDBCff/XDbard/Uhcvy7m3ZTHzKpWuIHONecndDXD7RiU+OOm3xhIwACRx/K4wdvm7LEDOo7PRocPaUqtvo38xDwUs8UEqFPeZg9ZeWJteb9AXKzf3LBg/F3tQFreU96ft8/4DfZAhkAznEwdWA0VaCE2/+pDkrrow8bq9OkTGQAV+N6xF5DbCgJ0+sHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8JGSWSW6VhuVcwbMepiMV49ZIL3tgRVBCc0N3PCMxJE=;
 b=lL4QOW1a8fuWl0f3GsTlB2RA8UBY6G9XZHlJU+GFdk4SWoXyrSUMwcRLkM0aF5ECmoAa9eYGYBJlffy0lF6cew3Ra/pLDh/YGnK0HNW1Zvk1HCjBPsh4r9acXAeVdS2+8U/g19sSt9PTnBVXr/EKm7IK2tyZtWt7TseItJmwZAVnQcO814psUb12H/HtfCJ+gT2qponRD4NxiVzSoc9UeIaCpaJli7yQWdaogqENDaUImtc24n3GebEW/vPhkPhjv6UY+ftDEsLlKVhLqAuoHnZZJPgHxwEl8DwBiG94kW09ww5EOp74bL8Qd3W7NCiT9aigloK4OywBL/M6t9trtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8JGSWSW6VhuVcwbMepiMV49ZIL3tgRVBCc0N3PCMxJE=;
 b=xsF6bgVdHJe5OJFfJn5g3fnPPaUywYz+d1itr4jQkzyO1HsdhSoPd/qG1FhKDSaEyfQhvR8pa9tnOlRDdwbTMlq1yAe9C4HggvSrXa6I9yixPPe7lao1D4q+Qs8VZnpwZFIkAaesPDnLDeUOkT97Pbkvt4CRoy32oew5Md6p5lQ=
Received: from CH2PR07CA0053.namprd07.prod.outlook.com (2603:10b6:610:5b::27)
 by IA0PPF73BED5E32.namprd12.prod.outlook.com
 (2603:10b6:20f:fc04::bd2) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.21; Fri, 22 May
 2026 00:22:07 +0000
Received: from CH1PEPF0000A34C.namprd04.prod.outlook.com (2603:10b6:610:5b::4)
 by CH2PR07CA0053.outlook.office365.com (2603:10b6:610:5b::27) with
 Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.48.17
 via Frontend Transport; Fri, 22 May 2026 00:22:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CH1PEPF0000A34C.mail.protection.outlook.com (10.167.244.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.71.7 via Frontend Transport; Fri, 22 May 2026 00:22:06 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 21 May
 2026 19:22:02 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 21 May
 2026 19:22:02 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Thu, 21 May 2026 19:21:56 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>,
 <sunil.khatri@amd.com>, <Amber.Lin@amd.com>, <Jesse.Zhang@amd.com>,
 <Shaoyun.Liu@amd.com>
CC: Shaoyun Liu <shaoyun.liu@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 24/42] drm/amd/amdgpu/include : update mes api header v11/v12
Date: Thu, 21 May 2026 20:20:30 -0400
Message-ID: <20260522002048.98506-25-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260522002048.98506-1-alexander.deucher@amd.com>
References: <20260522002048.98506-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000A34C:EE_|IA0PPF73BED5E32:EE_
X-MS-Office365-Filtering-Correlation-Id: 39cb2b36-1a19-44db-4505-08deb7982801
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|1800799024|376014|82310400026|18002099003|56012099003|11063799006|22082099003;
X-Microsoft-Antispam-Message-Info: OYgdQdMSRGR7oW+VxwQWSmZq7ceHP+rnevVqqrvydPZZHPTirptwVzpAKNmtWz3FoNRkU592ikXjM8vo8GCE8ZCE5oEUnDp3hKaZIzdX8AvyJwEGRV7Gsbt60rr4oovTrtQiGb+/LX2WFMv5LEwbxVo/UrF9706aKY8Akgim8Ii0OOLSB5PpCejbSCx8qbTaaPi1XG4zzvwvdz4dauGHqXmYUCHEDKHtWYjoXFJHQJzWlY//70UiBLV1U/VvbzAHv+ag/mFochPfPJKJGeW9xNAMQlHfKXHmGDlYM3dMuJ+OJXNJ0qOG/Qq034AScXmT3/nhQFuKS0pHht4e6txiHQn9xdb2H0/PjxfrH3zwMwNGM3esBgvts79bHPgxPAIkw48zhMRz2cvVUZE/NAB2yO7ZmD7glJWt6rtUNd7GG172fwvYljk+cyDsFMESsovsCCi13o4J5CemQbZOzGTNklQQLrDzakMT1olydNv+9XKZ6xzyojIc7lhFvsXloTBqRXhLi5XA+uhHzU1V7ZpbqlWphVUCEVOOVWpFhtbNEfi6BzhdSti6wCt45WwL1ZaO2CqwoL5KzGf59zB+Gh0gLyMfe6xRpn6rxnbrnCZeLqowNR3D+7fCrtGMQyly6WNLVQNZuDPLgLLNh5JTAquSZOSfZ46/wlkTp7oMBQaP68nVMpoKWe95B9PKA0DjIM9hEMmhxV/5stxr41MsPFFknoQ0pNo9+kEm3hVcQU8wsLE=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(1800799024)(376014)(82310400026)(18002099003)(56012099003)(11063799006)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: pzZodUk97vwcwLRMn5mP9sVJKj+8rwUZO0XH2d6Xg2gCgkfd4yynEHFp4KK0uCGR27UmRA+la6q4BFcjDGKFDcbYvJGQno3hTx+Ut2weJdZYWM2Kr2sU/myy0rqxWh2t4RSbGMYjKyBhnvUoxj9rxjVuqx3v4ZDmHmdmkfupcI4Ytu83s0+KZDiWQhT/+Mlp0HeFaH72EghkEGDIR3iuculvsYGeVrUjd999YsxbcY2x8YPZMOBId8X0OHslll7A9cvY090Bz22vgl/X2PYdGQM7jtESwp4TvWji1W3qvFJx+93pMY8tIZuja9VnpRbziNrRJmscmVe7+XHxCFVD01QrHAuNVywpfze/mbQTRmGmItH4T6U0/G1KjWs2X53PQD4252kjQz8yLpBI5u8FFleb9AALzsT6sB7MVB8F9wzTXnLGs8f/UGbb6QHzSZLm
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2026 00:22:06.6734 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 39cb2b36-1a19-44db-4505-08deb7982801
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000A34C.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PPF73BED5E32
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

From: Shaoyun Liu <shaoyun.liu@amd.com>

Update the parameter in SET_HW_RESOURCES API 1. Align with the setting
of enable_lr_compute_wa 2. Add enable_compute_pipe_reset to enable
pipe reset when compute queue reset failes

v2: add driver flags to track when we enable it

Signed-off-by: Shaoyun Liu <shaoyun.liu@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h       | 3 +++
 drivers/gpu/drm/amd/include/mes_v11_api_def.h | 5 +++--
 drivers/gpu/drm/amd/include/mes_v12_api_def.h | 5 +++--
 3 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
index de7307ef60c13..edcfaa5b3e255 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
@@ -168,6 +168,9 @@ struct amdgpu_mes {
 	int                 master_xcc_ids[AMDGPU_MAX_MES_INST_PIPES];
 	struct amdgpu_bo    *shared_cmd_buf_obj[AMDGPU_MAX_MES_INST_PIPES];
 	uint64_t            shared_cmd_buf_gpu_addr[AMDGPU_MAX_MES_INST_PIPES];
+
+	bool			compute_pipe_reset_enabled;
+	bool			gfx_pipe_reset_enabled;
 };
 
 struct amdgpu_mes_hung_queue_hqd_info {
diff --git a/drivers/gpu/drm/amd/include/mes_v11_api_def.h b/drivers/gpu/drm/amd/include/mes_v11_api_def.h
index f9629d42ada27..6644fabeb0b78 100644
--- a/drivers/gpu/drm/amd/include/mes_v11_api_def.h
+++ b/drivers/gpu/drm/amd/include/mes_v11_api_def.h
@@ -238,8 +238,9 @@ union MESAPI_SET_HW_RESOURCES {
 				uint32_t enable_mes_sch_stb_log : 1;
 				uint32_t limit_single_process : 1;
 				uint32_t is_strix_tmz_wa_enabled  :1;
-				uint32_t enable_lr_compute_wa : 1;
-				uint32_t reserved : 12;
+				uint32_t enable_lr_compute_wa : 2;
+				uint32_t enable_compute_pipe_reset : 1;
+				uint32_t reserved : 10;
 			};
 			uint32_t	uint32_t_all;
 		};
diff --git a/drivers/gpu/drm/amd/include/mes_v12_api_def.h b/drivers/gpu/drm/amd/include/mes_v12_api_def.h
index e541a43714a10..cb7ebdfffeeb7 100644
--- a/drivers/gpu/drm/amd/include/mes_v12_api_def.h
+++ b/drivers/gpu/drm/amd/include/mes_v12_api_def.h
@@ -294,8 +294,9 @@ union MESAPI_SET_HW_RESOURCES {
 				uint32_t limit_single_process : 1;
 				uint32_t unmapped_doorbell_handling: 2;
 				uint32_t enable_mes_fence_int: 1;
-				uint32_t enable_lr_compute_wa : 1;
-				uint32_t reserved : 9;
+				uint32_t enable_lr_compute_wa : 2;
+				uint32_t enable_compute_pipe_reset : 1;
+				uint32_t reserved : 7;
 			};
 			uint32_t uint32_all;
 		};
-- 
2.54.0

