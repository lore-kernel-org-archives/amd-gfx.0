Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71788FB44CA
	for <amd-gfx@archiver.kernel.org>; Fri, 24 Apr 2026 08:20:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1F75A10F422;
	Fri, 24 Apr 2026 08:20:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="BuNXI0rE";
	dkim-atps=neutral
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010063.outbound.protection.outlook.com [52.101.85.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C4D1910F422
 for <amd-gfx@lists.freedesktop.org>; Fri, 24 Apr 2026 08:20:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GC2BFPfV0mYzeYWRLbgxduqVDXIuUYQ+3i0WhFMo4YXYvPBHHS05IPHsbpr0bjn9JSTpnFPLHc9a9bwYdJKMfMnrlPz3nbYI3RNY6Ifm2Kycunnu6kcueOqjsRtrGAKCeUBcKNvh7OlL78baArdMl8eLQCwUU+bXVBTpMFcsGvkEtxtLOdmYTjLEwsuJZWILv36At1xGbDZnKju4Jt+89s+6uGsnE6/zCNgZHF9hV/Faq1MHJUro5gYr3UyYzXoHXaGjGaUxlkyZJTFIA2IX2ebKiSzNa3B/i7lpX+otk3XWmFTgm4qgMKCBxd7E1cdV4wGcPfolt7EOLLhG1fWSPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l2STnvvHoSePmcuob4MMvs9lUTpDg5a+L+GEGJJGE0M=;
 b=BJxfGgBbfynTPJ55cSpSkq5R1mmlq4JQoe6Z8kp9TWwD3h8GSF8sp0GSA9cUaqz+fmvJ86nPJJ238DwGvcllz1UuiY1B4roYr3Pr76VQEmC5ksZEUBjYyBrJg/CuNnDH7fn2vt8Wr0p7vdpLJ5bhW0qGKdWOw2oFgMuoxoxGyvO88gRHdvLsZkcNopNdo97Wrg0XUITDg60hffQuzwR2wyk8+6+Nq90XyV1heOyXayS6Mj/iPPFRX74sIrhFdO5MHM3LW0ea3CVr6nCt/rSzwiHwJ98TgNgo9wqU11Q2koBRKT6CRySysRyesRK1Xt9JXqmXm0o+05ChHxNtj6ys/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l2STnvvHoSePmcuob4MMvs9lUTpDg5a+L+GEGJJGE0M=;
 b=BuNXI0rETXnkzwPNnxn1Spki1+0/VLlrdxefOej+E4elo1YjTIvbzi4v/18XNiShsisDwexy/xzIXLVLtoxJM/XQJoUNGXrpQnu6G/G2ClVgDvhV6vTxC59C283VcTqOu426z086K3t5c8SdzAoixefoe2iw6bvOImPWGxLvTac=
Received: from BL1PR13CA0433.namprd13.prod.outlook.com (2603:10b6:208:2c3::18)
 by PH7PR12MB7456.namprd12.prod.outlook.com (2603:10b6:510:20f::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.21; Fri, 24 Apr
 2026 08:20:38 +0000
Received: from MN1PEPF0000F0E0.namprd04.prod.outlook.com
 (2603:10b6:208:2c3:cafe::1e) by BL1PR13CA0433.outlook.office365.com
 (2603:10b6:208:2c3::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9846.22 via Frontend Transport; Fri,
 24 Apr 2026 08:20:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MN1PEPF0000F0E0.mail.protection.outlook.com (10.167.242.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9846.18 via Frontend Transport; Fri, 24 Apr 2026 08:20:37 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Fri, 24 Apr
 2026 03:20:37 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 24 Apr
 2026 03:20:36 -0500
Received: from JesseDEV.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Fri, 24 Apr 2026 03:20:30 -0500
From: Jesse Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 Jesse.zhang <Jesse.zhang@amd.com>, Jesse Zhang <Jesse.Zhang@amd.com>
Subject: [PATCH 06/10] drm/amdgpu/mes: add NOTIFY_WORK_ON_UNMAPPED_QUEUE op +
 ADD_QUEUE fields
Date: Fri, 24 Apr 2026 16:18:51 +0800
Message-ID: <20260424081955.873090-6-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260424081955.873090-1-Jesse.Zhang@amd.com>
References: <20260424081955.873090-1-Jesse.Zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: Jesse.Zhang@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0E0:EE_|PH7PR12MB7456:EE_
X-MS-Office365-Filtering-Correlation-Id: ea6bc8b7-846a-4364-2b6a-08dea1da5d4c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|36860700016|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info: IpgddrBaq6L9ppQlpVq6IYD4QCS1a0r+BWNLVAF289ZecRzTurGuz29N5jE6RozWCuNg4cDBcfm9UxYAo/BlQBhASkg6BQepwPgG+aNMr/S4A6jqv+qX3Oj7XzrfvGwP6uAUdSIeQhv+/oa8jiSvhzmHN1GhcmUqJQcmdZfz/YhClUX7TUIT5VVbYeGg7nxCg25S+bs86p6dQPYtazuNwcgBoZwHsjZ4Q0TrdONZ96eEtz65r22VOWRU75+OuqLev8JFz5Hx9GKc00H4K2hk13BObTsqJapdODOeqUaG27dYH6DPWRvRnCWxw/trGv/xIuZ+358lGdHhjM4Easl8k9M3OWbdmS1Qe7hu2XIZdWATVLD7kB7qZtnQPY8e+q26HC2ci0FhbNlzt3N8Lp9CzR8oqu5pMwFszZdGHjbHp/UJMPrfhIlUo0Dhr6qXIo0cACT7jLcbeMS9G8VT3VyrdzNqpi/KyleMC1aXFoC3Mxz9iWXeOdhpYwNe8IMIgCsRjoBM4qyxQRFcwmVUz7FBQgsc1Fpc9eWaDQbPO0/to6n2AqLVEKDH89A67++O/qr89l8BJi3G+4iHuOeH31tl52Z/HnuKRjoYNjisrgDUH5pIKkLsWQExZqLTelGwdLn93ri/J9k8N8nP7CbmB7gLnBta7UJ8j0tpbng0wIxuCBbsv6TZHQbxXmRby8eI5i5o/tSQ3zqdYYAZgGl1PzpBGB7WHSUoTowYMEsNVYAsTM1+IeoRxOvsTtpfiz/WIwKqANvnKL4FNZ/HJGvia/lGZg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(376014)(36860700016)(18002099003)(56012099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: z7NHwKnlxT2D88BNMSQLC2RAHQsBGqwz08G3pGM/rKe9JXyvjbdlD6ALMKOOfZLcVPcbhNry5o2vRgwkzoIZxZKtPUgvbFo8yBpXVl/cOCooc7so1XACSopMkO24UNdscyFv1dvvO71ehkU3GBJWBaZb+ng83oq3ymyuYSfPBBJEYJ8onVSOQ3auZEsBOEENL9mWsKQS0oXvroXi9eqNtnizO1IkPv1W91ZfhhnOSuN1wZ+XauGUaA30YqT8FVKoCR3oYntz3LpbKS7nSo49ZIs9lG17n8UVlESPd39wdS5f/7xuTOMRjBBhiDK7nAA74oRvZ0lF2o7zwti7dxobwBOhDTWHfqisC71uDx7PhlsIme/K2i4Ggvyoi+MQQqNF/IJzQlsl51rceM/aYGpthhVw3NzOFaoACehjKBHcrlxZ5S6WdukapDJOe7IA35NF
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2026 08:20:37.2976 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ea6bc8b7-846a-4364-2b6a-08dea1da5d4c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000F0E0.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7456
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

From: "Jesse.zhang" <Jesse.zhang@amd.com>

Kernel-side abstraction work for the SDMA usermode-queue plumbing
landed in subsequent per-engine patches:

- mes_add_queue_input gains is_user_mode_submission and
  unmap_flag_addr.  Without is_user_mode_submission MES treats SDMA
  queues as kernel-managed and uses the end-of-MQD slot for the unmap
  flag, so PROTECTED_FENCE at the tail of every SDMA IB looks like a
  "queue done" signal and MES gangs the queue out forever.

- mes_misc_opcode gains MES_MISC_OP_NOTIFY_WORK_ON_UNMAPPED_QUEUE
  with a notify_work.priority_level payload.  This wakes a gangs-out
  SDMA UMQ so subsequent IBs get re-mapped (SDMA has no
  CP_UNMAPPED_DOORBELL HW intercept).

Also surface the matching firmware bits in mes_v12_api_def.h:
is_user_mode_submission / enable_perf_profiling /
exclude_process_limit / is_video_blit_queue bitfields in
MESAPI__ADD_QUEUE, and the unmap_flag_addr packet field.

Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h       |  7 +++++++
 drivers/gpu/drm/amd/include/mes_v12_api_def.h | 12 +++++++++++-
 2 files changed, 18 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
index cafc5caae822..705056de94b0 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
@@ -265,6 +265,8 @@ struct mes_add_queue_input {
 	uint32_t	exclusively_scheduled;
 	uint32_t	sh_mem_config_data;
 	uint32_t	vm_cntx_cntl;
+	uint32_t	is_user_mode_submission;
+	uint64_t	unmap_flag_addr;
 };
 
 struct mes_remove_queue_input {
@@ -343,6 +345,7 @@ enum mes_misc_opcode {
 	MES_MISC_OP_WRM_REG_WR_WAIT,
 	MES_MISC_OP_SET_SHADER_DEBUGGER,
 	MES_MISC_OP_CHANGE_CONFIG,
+	MES_MISC_OP_NOTIFY_WORK_ON_UNMAPPED_QUEUE,
 };
 
 struct mes_misc_op_input {
@@ -397,6 +400,10 @@ struct mes_misc_op_input {
 				uint32_t tdr_delay;
 			} tdr_config;
 		} change_config;
+
+		struct {
+			uint32_t priority_level;
+		} notify_work;
 	};
 };
 
diff --git a/drivers/gpu/drm/amd/include/mes_v12_api_def.h b/drivers/gpu/drm/amd/include/mes_v12_api_def.h
index e541a43714a1..cd6e60184a06 100644
--- a/drivers/gpu/drm/amd/include/mes_v12_api_def.h
+++ b/drivers/gpu/drm/amd/include/mes_v12_api_def.h
@@ -381,7 +381,11 @@ union MESAPI__ADD_QUEUE {
 			uint32_t exclusively_scheduled : 1;
 			uint32_t is_long_running : 1;
 			uint32_t is_dwm_queue : 1;
-			uint32_t reserved	 : 15;
+			uint32_t is_video_blit_queue : 1;
+			uint32_t is_user_mode_submission : 1;
+			uint32_t enable_perf_profiling : 1;
+			uint32_t exclude_process_limit : 1;
+			uint32_t reserved	 : 11;
 		};
 		struct MES_API_STATUS	api_status;
 		uint64_t		tma_addr;
@@ -393,6 +397,12 @@ union MESAPI__ADD_QUEUE {
 		uint32_t		queue_id;
 		uint32_t		alignment_mode_setting;
 		uint32_t		full_sh_mem_config_data;
+		/*
+		 * MC addr where MES writes 1 when it unmaps the queue.  Used
+		 * by user-mode SDMA UMQs so the kernel/userspace can detect
+		 * the unmapped state and re-arm work via NOTIFY_WORK_ON_UNMAPPED_QUEUE.
+		 */
+		uint64_t		unmap_flag_addr;
 	};
 
 	uint32_t max_dwords_in_api[API_FRAME_SIZE_IN_DWORDS];
-- 
2.49.0

