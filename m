Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85F27FF8868
	for <amd-gfx@archiver.kernel.org>; Tue, 28 Apr 2026 10:03:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 313F910EAF1;
	Tue, 28 Apr 2026 10:03:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Lzc7OBzi";
	dkim-atps=neutral
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012019.outbound.protection.outlook.com [52.101.53.19])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 489B810EAF1
 for <amd-gfx@lists.freedesktop.org>; Tue, 28 Apr 2026 10:03:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tsYVwlXAxy5qOicU1BpXXJGySoVkc7YdcOl2RPOzxeyRk8cPLvZY+X6NAh62RPIfaGoAGWsbi86LCcqnWvJ1XmsppRWoofg5N5h2UQnaxpUbfHkAs/2H93ol6gm1C/yrtpzYVf6p1CykVzuK8tMmo2PbV8Hg53Ua0c0/IBBbIoP3Z3X4IPIUrWScwCHTLDlV7qL29guMPSh8s+UMPQyMXvPjUTD9Q9RwLC2XYV9jb3WUErKugEKP2Yx7inVhkQhzl1And7a+exie99pMsDn9euMtxbSSAdAClqJukJ+hrMRq4WTeZyotXgb1UlR84eoiKcRxoDtyUakGfHqFy+A6/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J5iuskYKZVxY1IgF1BRxx4ROzhwLBf9F5LjjATSe6Dg=;
 b=Hqkr+S6R/aunHSILazkEG+O4SCaeAlSyDM7ECp0Fuws4wA2jm0BvQxTFB0pCGNV4e0lms8L3DujgIeV9QmzOj6Hnqrni69qYRevSMnuHEiF2iTSKgbR8maGRXQZqpJOYHcbAYiiS//9v9LIaklzE/HoHCdCT1HqKlPF4u2sXvOgGlIH27muOH5KCA8Fh11VuL68yn207CrVyHr++b20jodwaqCNeiOlrWD+1NMLoA0nl6p7uIghf2FshnTACLADpt4arLHyOpjV0WHKaC1c1oLziPY3BUpGv5d5nWUV/HbT5YuKPJ274mXuO/LBsowV8JeWZFs70ym+FsJtq3R+lEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J5iuskYKZVxY1IgF1BRxx4ROzhwLBf9F5LjjATSe6Dg=;
 b=Lzc7OBziHdLcPooQO0fTFIq1Shr1+kXygE8aa6Zng0Pr0Y7lug5ObJ1Q8LrpiGlDdQJQMRcuAGDhVqGcqIIn3GhVS7rr6OAlqVWzUgYdh+RzvhcCcSPotbPwRJSm7TrBKD5yj4u7brbzcBLGKU1FJdAwBqUcS6mQ3ZTbTLbeZMc=
Received: from CH0PR03CA0192.namprd03.prod.outlook.com (2603:10b6:610:e4::17)
 by PH7PR12MB9256.namprd12.prod.outlook.com (2603:10b6:510:2fe::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.15; Tue, 28 Apr
 2026 10:03:29 +0000
Received: from DS2PEPF000061C6.namprd02.prod.outlook.com
 (2603:10b6:610:e4:cafe::cd) by CH0PR03CA0192.outlook.office365.com
 (2603:10b6:610:e4::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9846.26 via Frontend Transport; Tue,
 28 Apr 2026 10:03:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS2PEPF000061C6.mail.protection.outlook.com (10.167.23.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9846.18 via Frontend Transport; Tue, 28 Apr 2026 10:03:28 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 28 Apr
 2026 05:03:20 -0500
Received: from JesseDEV.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Tue, 28 Apr 2026 05:03:14 -0500
From: Jesse Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 Jesse.zhang <Jesse.zhang@amd.com>, Jesse Zhang <Jesse.Zhang@amd.com>
Subject: [PATCH v3 06/11] drm/amdgpu/mes: add NOTIFY_WORK_ON_UNMAPPED_QUEUE op
 + ADD_QUEUE fields
Date: Tue, 28 Apr 2026 17:58:47 +0800
Message-ID: <20260428100239.1609179-6-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260428100239.1609179-1-Jesse.Zhang@amd.com>
References: <20260428100239.1609179-1-Jesse.Zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF000061C6:EE_|PH7PR12MB9256:EE_
X-MS-Office365-Filtering-Correlation-Id: 793fbe45-c64c-4403-ebba-08dea50d6582
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|82310400026|1800799024|376014|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info: 7FvSP1mcAADhrMO/KEZFIcAbQFbDXvx5nLiGtd4X9h9EuPZzdM6gt04z5Yvd0Ua2N0OveS7T8fZg10Qbxlmu/WpytV4Q18sm2yLaoG91UwEJYapHdcyYfAmtqYf7xl2ynXRGoxN3eQkkmMjdHs05QcrA6bM1kYTifOOgfgcLmUV3bY5BDaMY0ktoO9trvcOGmjkurXtuFVnpvkewlzCLE6NQ39YAt3dX8RUsCv2YB66baX2q03LIqZ4tWb2o/w2BZw6GZo0IenrcGFFacUpSWB/f1EnQXbcZcvMBC3aF2QHWWuX12dRy1kU8jn42KWziKSIIgv05PcbzFF82QwzbwRZLvjqg4kf/YSSn/m9CsKkZcELDG00tNCJXMQdXf3TXsP/+kCGNExpsIvp8+jXGjlgHA7HrzCUJ5kOCoMxdiP7MrVleUA5wE/8/A6Ai5A4eKwNA5cfCsat4SIRgAkJthga2nr+bPRmPn9CSRVvopO5WorhhJ/e7twgWTbNP0WrkJuEa6LBJyil+m+fwDMrEbhy422mMV/RUh98ptmxAB413XZcQfMiPSTuvZewRAUxXsl3lan0WoKvy/B9QGU+4ycYkiQ0C0OSiFmCqXIonE2oRei3SdxLZb1lstpaSSxOSDl5dLZVjgVfaU+P4RLsK70SejSKsGxiUaDIAvXQbFtrEQ19JgiC1vsg7JG/XpImkm/VLFxu/GsAMUzm3aGJX3hV/OttvqPhHK0BikvdG7SRUoCBG/H6y/PMjgtnGqzIZOiWo45sAaDeB508GyxFzBA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(82310400026)(1800799024)(376014)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: TS2z0MO3ef9RVkV72wydL6krqRBphFT8jbaqN+j3SMUV0KKyQsS2/xgWK/yT5R7XdVNsNqdRz8kWs+kMnvVxATSqUkmLtTtHGuBFreyltPDJAR7GrLRBAbwRD3JmD5+eRy8l0D1pPAtZodZeYo1G4XipTW1kSMTEZKgmZYfuK5vGCNT2W98AcAYQM92ax8PlncDXsG8R68xYk50PO420tLJLxPbUeYs/wZZpw2ZlGaYA6hvR4o9j58BV5+UnsgfOGkuMxmN51WuH6XMO3KcZ02XOQHrrIg8+YXHvAT9xvjaPCL+rOZuhmcOuwMos1nwL7X5JLvKk1rdyAd0riMqfYyOR7znpjJmr6sffkbzlWAtUGgrKbmIY8Wa+bjX5mCanHK/ReB2ynfNompyt9BbLpx1Fk2h9tzRW+r/4Iq68ssOhAHe+h3ID3pAFZc4lfKFl
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2026 10:03:28.9060 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 793fbe45-c64c-4403-ebba-08dea50d6582
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF000061C6.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9256
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

