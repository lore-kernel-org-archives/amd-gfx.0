Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E66B7FF8861
	for <amd-gfx@archiver.kernel.org>; Mon, 27 Apr 2026 08:36:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8572C10E60F;
	Mon, 27 Apr 2026 08:36:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Jdy3MzGc";
	dkim-atps=neutral
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011003.outbound.protection.outlook.com
 [40.93.194.3])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CE75410E60F
 for <amd-gfx@lists.freedesktop.org>; Mon, 27 Apr 2026 08:36:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H1Orc3JYVdLVdPknkqFwoQweaSLadsYFSw80334kFMEXlFV9DOSGfLAWm7exRo3uFzDK1iizvEhhwcd52YI6PzyzXEeE1Rc3iYkEABtA/Anq2YiJjNMIgi7umYo/AHV9dMeAAD+854pVRXT18qIsmGhir3Hh4cRjQMtVoHOEqEWO0cykPKESd2iUpBXuEapQqyh8ACZr/kfugkAJZRmpj5NLQX8JE3w/uhLxc2dp+KUKNUCnuguD6NDlSQPxD5ugcrW0cSNTjl+as+FFwjdcxZ8a6lWZh3i2qrygHk+WH7zvsKN6/ZwWMwoc0L6InX3lha0Sag+erfmY5NOxZVhiCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l2STnvvHoSePmcuob4MMvs9lUTpDg5a+L+GEGJJGE0M=;
 b=Vlx11b70HPhpVn+JAze8GMNGmEnI67hDKFpkAnhevl4hCO6DkGR/tbYgVVrXgfOnsomCgHM4M+3CY8pj90YFRn+Q5VPpstDDtDPdvPg1sHDVzUw49HnJp/EUG1HM7WgoCI1T/Oe2lsBQ6nF0mK1VU2WB1OKd5QOYrjVacgt6umJinEA7bw1ng0owPfnoO6C8pMh4WdZhMTuDV0g1a7kh/58B7/4FuENvlqqB79wdPXDuHoEaY8GtFkp+Em6IWcy4IuNOJMrWlpNTjpD5VD78QQodIkiM/5nfEvTy4i37SBu7ROpa+oMy9ho+r7x029w2LEGiKSnWgiCFxXx00ZDRnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l2STnvvHoSePmcuob4MMvs9lUTpDg5a+L+GEGJJGE0M=;
 b=Jdy3MzGcsba9025TZAiZ5itOJg9wJxfGPB6bOxyfTP6IiOsa5zaTShu2KQyRWoz+ekr0eJQidl3Ov8n7UV7wU+grXM6bnG7nmwaPZbLUFAJIdVpew0xWmBiCpdYq7daIwge5UnlQGJx7kcw91N996P0xCgGgro8zxQnIzk4l0w8=
Received: from MW4P222CA0007.NAMP222.PROD.OUTLOOK.COM (2603:10b6:303:114::12)
 by DS0PR12MB7995.namprd12.prod.outlook.com (2603:10b6:8:14e::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.16; Mon, 27 Apr
 2026 08:36:27 +0000
Received: from CO1PEPF00012E61.namprd05.prod.outlook.com
 (2603:10b6:303:114:cafe::a4) by MW4P222CA0007.outlook.office365.com
 (2603:10b6:303:114::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9846.26 via Frontend Transport; Mon,
 27 Apr 2026 08:36:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CO1PEPF00012E61.mail.protection.outlook.com (10.167.249.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9846.18 via Frontend Transport; Mon, 27 Apr 2026 08:36:26 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 27 Apr
 2026 03:36:26 -0500
Received: from JesseDEV.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Mon, 27 Apr 2026 03:36:20 -0500
From: Jesse Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 Jesse.zhang <Jesse.zhang@amd.com>, Jesse Zhang <Jesse.Zhang@amd.com>
Subject: [PATCH v2 07/11] drm/amdgpu/mes: add NOTIFY_WORK_ON_UNMAPPED_QUEUE op
 + ADD_QUEUE fields
Date: Mon, 27 Apr 2026 16:34:33 +0800
Message-ID: <20260427083543.1328533-7-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260427083543.1328533-1-Jesse.Zhang@amd.com>
References: <20260427083543.1328533-1-Jesse.Zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF00012E61:EE_|DS0PR12MB7995:EE_
X-MS-Office365-Filtering-Correlation-Id: 4744646a-1aa8-46e2-b013-08dea438128f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|82310400026|36860700016|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 76c2+Wi777C4iKtn/WmHi5Wti0GK3ozhBXGLubJpWhjH/8ZYjbrUnRehZf0YlrdlvEppJfDMVmDfFmPruhSpsPTBmyYLcwR0cCfgsvnmf/LAGBYL2rIJAvT8O2nElZTuBOnaLQePkVxJTWqLOjOo/TbO6sCeYOqYL9FKc1KM9ipk+dVBuIBh7Kr1qJt//tdrpKJeFzB8xt4/tOVBl0w8C9AmvkV9X7wbNUcUF6thNhLNRUGHqXVkJTlU2K38aG+Tx5WNWVIu8dhMi5tHyOO5c7LzDqlied7HkQPBSnalYMavmI7nvlOUPzDaMdQRTYvhhJ8xwJDLL3h+I4qvlTZPybJx83WFXbGUXAQ0Fi7+rXHD0TpaHt4lwqmkPoPxKR4LpZ84G15p7fxRBYQb6xUiRtv5qxewjxgUSlRsEGKnsZdxSVOH9DEWoHD+vWce7n1OJy7ULqzP6Bpau4EeyINjnMc83PYHoO0zt+1aULfhnu43FQjnP5mj8xn/upSW8iSclWdleS6++xWrbcFWmx6XZvcN2qSe34NmjaMxSPYqMjNJd2bQq5BfW0p8oqwizzUYSyHOF5kupFTqVdhExkDN5jeYuQtaSFI1apKOYU9EhdPvkzLjfS8l/pUOBc7QrJzydqc3GUeiwhHKZxrO8N4013ly1hoenZskaxijzLzpyZRgjEUvKyzeIfrCKx6X8dfQpBznNrlcpwHkP1ywl+HS9/WLYSKHFNL9b2o3+l7CsDfB2Iu2JfJPUtfYbyl302gSyR5ZsP6aY5tOQ+6rkv2hQA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(82310400026)(36860700016)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: jOkASMcl2z+sQkM62bkVzzeXtp27a/X93CwxWTmGdZEPgMO7ug0/TZFG4YLFgInpy83/LzIoYglCzKpHmVy5IfykbdwQHluxChG6qT/pbRfKTegvlsXoTQ0rzDIyMi2H/XQzlY6aeMoABwdkYYBEikv4I3dA12PEvEfgmAd2gvXRgjCC9PggIg71/AVa4ugzPaLG65gf2dg6aFXWZ+AlYWsDOQkLxZLHIktEn8HMFN2zI4/1MvW1KsqBsQ0976gU/UgomunEvO4GvSNv5UguEQ/oKnbgtIlgcjW5KK2LsImEJNT3PqvBHCPUwBTSFDe1r+6nutiCUbZ2I+qiV1d3ogzEiX7WH3AajYkn0F+xth5Rr4wYimQpkWpDZ+nHSSh5Z8RcW+LjzRIlLTM/imK7t4eOy6o0xYYrw3bHtJNvhC3sX8p8hj7ic85yI2D41eWA
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2026 08:36:26.8554 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4744646a-1aa8-46e2-b013-08dea438128f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF00012E61.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7995
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

