Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E92A3CD13D3
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Apr 2026 16:12:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1953910E0E2;
	Thu, 30 Apr 2026 16:12:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Voa3Z8G+";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011044.outbound.protection.outlook.com [52.101.62.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3250F10E0E2
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Apr 2026 16:12:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Xyr2LN65h1TRSD0BgmC/wf5o6q7vSkdlt7FQxH6zKzjNyzebXDDMCGby/P9Afv21NMCZ72Fyy0IQ3AcNzZ5hSfiU5FNV85rZW8O5S23kRx5f2w57u+bcjaHzgbhekhC2uJlREIdnWE+FGGqgJclr6Jheh0+MalfXXN2G7yp1T9Ro1v6ozs4rsr0F7ocsYSwtwgIwmXXH5bjqsCVGFy14Sp8ZOLaOpmaXHmUGGEJHpnFGHS4r+rMidYytNm0OPPZXoM0LwcBIBts06Rb7duVrewQYSKgWXF2A9nLJvm3Jzi+8ve8d7WO4k8olXEuS82pAhYbXTq+Vc0w/CFyUkNhTqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l2STnvvHoSePmcuob4MMvs9lUTpDg5a+L+GEGJJGE0M=;
 b=TXBLP68FOvscgTch9JXMKIWc4aqM2mBz+Ws6rPe3ndapChI6PLQD2ueJVBElKGsoX36lNd/+62IEOagXIGj6DACq6zkyguxH2+t5gX613q8JR/fbA39Mw80khzjtkoS819Mo6HhmF0V/b1AQkiu1521LzxdLKWm200THYYv0XOlK1cqYyTrYhpiGZmEXTHkuAwveF9NKW/BwcAJOVkr537akki9Z3IUPKcDhRORvg1me7okBDrf+3LR5qkOqUt881DSKChzPPdt1Xe+QqSuGRds2Y9dbGCme8I0nz6enbzKqJu+w1M2RKISATVuGhVRM36rQuLBsfLptY9oIIfGbQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l2STnvvHoSePmcuob4MMvs9lUTpDg5a+L+GEGJJGE0M=;
 b=Voa3Z8G+jiR3IQ0M45JOj/zE/hBFY71Mb6ewRO7A8WCqjl8WXgnxivfJnz7zxvAhZX8sEhsgq01KO3RSmFWGH83UOewXQtOIA3zgyZJPUeD7S6ybdDxWCxiPq1/RVNOrtE2COd4x3xZmdy3Miivv6Lcs5CKjQ4kbjwrqQ4ztIJw=
Received: from CH0PR13CA0025.namprd13.prod.outlook.com (2603:10b6:610:b1::30)
 by PH7PR12MB7454.namprd12.prod.outlook.com (2603:10b6:510:20d::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.20; Thu, 30 Apr
 2026 16:11:59 +0000
Received: from DS2PEPF00003445.namprd04.prod.outlook.com
 (2603:10b6:610:b1:cafe::62) by CH0PR13CA0025.outlook.office365.com
 (2603:10b6:610:b1::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9870.22 via Frontend Transport; Thu,
 30 Apr 2026 16:11:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS2PEPF00003445.mail.protection.outlook.com (10.167.17.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9870.22 via Frontend Transport; Thu, 30 Apr 2026 16:11:58 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 30 Apr
 2026 11:11:58 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 30 Apr
 2026 11:11:58 -0500
Received: from JesseDEV.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Thu, 30 Apr 2026 11:11:52 -0500
From: Jesse Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 Jesse.zhang <Jesse.zhang@amd.com>, Jesse Zhang <Jesse.Zhang@amd.com>
Subject: [PATCH v4 01/10] drm/amdgpu/mes: add NOTIFY_WORK_ON_UNMAPPED_QUEUE op
 + ADD_QUEUE fields
Date: Fri, 1 May 2026 00:03:29 +0800
Message-ID: <20260430161146.2851078-1-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003445:EE_|PH7PR12MB7454:EE_
X-MS-Office365-Filtering-Correlation-Id: 96ed7d47-9602-41ef-5688-08dea6d334ec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|82310400026|376014|1800799024|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: ZRGfJvFSUk1cLldA5iorKOchAQN0vT1Ry553hwHDefxPiveBegXkapYa+p/XyOHhJur3zKcvY5/u+UwDuZ5XkvFTFw2Pa4DCON+TRFH0Vuj/MnC7lFi9MK92rF4JvC7hWhAZYaBhEomJErabMiMblu2hxW3Fv0ksnXNbYAdkFZTbhd95fgNihWACE8pF1fEIEFFn6pF+ZQly1d17MXI20jDlqfVZ2LgOL5k23xI6JmFIqjwtCdOb48xTg5VQmgCkwtYA0obckDME8ub+hSZctzkKLqnpEQI4DaQge8AySHhes2mJlcNe9K8ILQzhvqw9TqRF/EsmgYiIhXLy8+9BEJ8xwK93MSuQCtQIzqp2QASPCyu6AQcMDI2WFkQZ+T78VG37heb4q6W8H45W+ozIE2TDDcBJ46zHis6E1qpB9AARMhW/etSDqMo9YTS/8lIpaQC5TVaUwr/fAIM51g05DZQ4uPd4owF6ce9W+VfykryXy7u/k1RogGVJa6G0zvo1NmJ0nZ74nCyKPumQqVlUfcVzZML1YngUJAXjk/R0m1ani50UE3+n6lmmXfjlikBUjYEQ1ww7zdzhU1ggL6ndql8fyL3Gfv6321XeKkktTbKrQAiQxCwONPWC9mZ29oKzTRP70PZ4w5pLWDDUYU0rjBZFT+BZgBYsICEh9W/fIvEMqwGpe9ODacrbheminTVq4tVFG5UEiRESQ2pF4TEn2R2s3o832KbIsQCZZAmu5I1d1xClFx0hruiwLnga+k1oigcUtmSigK8fTSC0pG7nIA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(82310400026)(376014)(1800799024)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: Fiedx6nEtHloDQQnY0bLodxNeTd7oWROodwMg7kmus39tt5ewycyQ2L/JrmFhg8Jce0iHiWZXBoITELNK00CTl7GNeknIzG1n2xPTM0kKNQSpQLxfwDOFUtN61awcmEkALXUySQxxsLkV9wGX2aLkwuSNREOmXdykaL4E2QKVk6qRBUV5rG5P18rivR6i1tCu1Z+24ccIgIBF5rVwxvcB6r87RSv7wVAk9h5TlVmipwOQEeA1Yek5Mgv41DaGhSzQnZZEV7ixrZBxewQGvuP+dmg8Zd1lawzJuz/qOjMNusLcgvAt6OCaUhFf/3/aZJGNGBMnXmh2O/ROPqirx2Zo5DYcob+WXt5l/7wntO+108leY4KMI1EIc7QsDrHs4HxOdHy4/JqfRK2NuO3xEspCXzycmbb2P8YDpsCUXEF9NSLe1eII4zytl3JVsHkIWJV
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2026 16:11:58.8855 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 96ed7d47-9602-41ef-5688-08dea6d334ec
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF00003445.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7454
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

