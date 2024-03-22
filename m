Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C692AC54E58
	for <amd-gfx@archiver.kernel.org>; Fri, 22 Mar 2024 02:54:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 36DAD10F1DE;
	Fri, 22 Mar 2024 02:54:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="wHfL8P/T";
	dkim-atps=neutral
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2051.outbound.protection.outlook.com [40.107.101.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D1C7610F1DE
 for <amd-gfx@lists.freedesktop.org>; Fri, 22 Mar 2024 02:54:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VdGs96XqBZXT1PO45sRPoTfJmEf7TM0W4WXa1a+1UzaYfRzOqKwA30VUVZIIFw0L4ECuBJHPtJ9C5O59cXk/NtM+kTMGXJNxtnIEzY4aDKhHISfDCRml0yWYM7bo1H+ej2pgNwj+GyIE2AiOoglSPbXgpHQ1fxJdLDdfS+T8po2HxDwzm2UDtcQl9P3G5TYdGNruZgAdLkLumjJMFf0p5HDwmb4HOGX+TKA+MQIXfHjKFi4rbmn9zMPxASHfrJ93Q4wJczat7wE28SWsX70pJ9KZMxUSXaAlP3e3g44whmf+xwz2zd1SRcmUpECvwbprxRGlmoqFz1Gt3wH4RTMsCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5qAXmLJCkojl1ROT1RlK5lZIHARa/rlhoAe4dz/KyiU=;
 b=YzkeVNOm+uhnyE6SXNG/ajdgjNYlDfU8HYOqAc/fbpDOagBe1PMos+s65LWrKvtihl60CzuC3UPobNm3xqdnU+qIhiwtjg7D5lMBM6GmRBeifbjUPTLMSi7wdOImXiNVmtTBXyXYff4gvfGeJI2zDw3boCT6Hbw07eLgqqTzzbUXlL4FYX5OfpuZAhmf8NfcbMHXlj09Q2ZErHcChf8uGB/ishr/5l5qjtagQG0d9zVPRoJcildMrydSHvULaYrcQNZAA1U9W/H0i+GQdH3NtvU0Itq5jRMYGqmJp75wIamfENEqcvaeTNeTXMELUErSM83EPd/vfxTbzAdy3luLuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5qAXmLJCkojl1ROT1RlK5lZIHARa/rlhoAe4dz/KyiU=;
 b=wHfL8P/TUMwQzz5oFO905zMLaG5jSBtWRqePd8CBiWsp94FCMJRqvPBBVh9JKvCbenNsxrlMDpDlVYS9W4KoWTs0Y4I6GcC0X0pf75XQuWQ5YMiaVsdvdWtWMSepvCZxbiM7rP7dBzQTgi/lQjwTlL3OSByyd9VcIU57jWvJoVc=
Received: from SJ0PR05CA0080.namprd05.prod.outlook.com (2603:10b6:a03:332::25)
 by SA0PR12MB7002.namprd12.prod.outlook.com (2603:10b6:806:2c0::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.34; Fri, 22 Mar
 2024 02:53:59 +0000
Received: from SJ5PEPF000001D4.namprd05.prod.outlook.com
 (2603:10b6:a03:332:cafe::76) by SJ0PR05CA0080.outlook.office365.com
 (2603:10b6:a03:332::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.12 via Frontend
 Transport; Fri, 22 Mar 2024 02:53:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF000001D4.mail.protection.outlook.com (10.167.242.56) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7409.10 via Frontend Transport; Fri, 22 Mar 2024 02:53:59 +0000
Received: from lang-desktop.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 21 Mar
 2024 21:53:56 -0500
From: Lang Yu <Lang.Yu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Lang Yu <Lang.Yu@amd.com>, Veerabadhran Gopalakrishnan
 <Veerabadhran.Gopalakrishnan@amd.com>
Subject: [PATCH 1/2] drm/amdgpu/umsch: update UMSCH 4.0 FW interface
Date: Fri, 22 Mar 2024 10:53:13 +0800
Message-ID: <20240322025314.3104595-1-Lang.Yu@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D4:EE_|SA0PR12MB7002:EE_
X-MS-Office365-Filtering-Correlation-Id: 3ca5c286-daec-410e-edfb-08dc4a1b52d8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: N1qpicGCmKPhlQiOeOJAwsf5CUvyedK/JvdSOd7JP17XCALwygAVR9dqRyH/su+YEgg/UZ+ZO09taMPbB3rGwb0gjfusWvYIjDLTCH3QM+ETHeT3qjIqk91rxC11ZcEHZuNIMzJ3R8tReKm/aN2rPzI56D7NUc0EqamTrHnRUkJW1HNfSOI5vvio0UVGwSxIT/VqX2iwsIDqqLYqRie354TiEtpMxuXAhJs6LXQqM7cm4cu7e6bV8iAahz4bCBywSwAs+IbF7ro7coDHXuoQByWpICFpjRKbIexeY0xxGYaKKI029COlx/P8GjSEBJsTVBfAysbEgbss18jlSpFodHCnCwjDGMuItA2NoUd1fkZzBa9sqCg5X9YyVO0k4+I6mLc512pYxxlv5MJcvRAh3gvXVR2qR98SzfmV/1eE097fFZYB6xMbleJWt0Tt0u+zWrBGq+Sj7vRX4Qy8jP2VxGwxqt7E9nHLOa/V/2qImTIUpJqzruRL29sRlDTb4rgm5m8WiVITjYKjo8Me4nt/qRZ3Zk2odqhjFnlh81HwBiEakIaEfyHyTYL/B3wYZwZv/u9VxpQTi/2jBBiJDlaVj5inlh3WYBpfIpMfuLMKvMt2b1jXgNpjVak2uIOJMxCEwe62BHJtIj3LoTp/VAlBIUqZvwpVVrbKTMiRWKh5Dbl9w2JwFBYOznWZFRIvBb6Xd2FoWR1iHh58+3B209gyQOPfkWZ7k+zUBhLhmQE108z+sB2V1wWnkyrvMcIh76wx
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(1800799015)(376005)(82310400014)(36860700004); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Mar 2024 02:53:59.3038 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ca5c286-daec-410e-edfb-08dc4a1b52d8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001D4.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB7002
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

Align with FW changes.

Signed-off-by: Lang Yu <Lang.Yu@amd.com>
Reviewed-by: Veerabadhran Gopalakrishnan <Veerabadhran.Gopalakrishnan@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_umsch_mm.h  | 20 +++++++++----------
 .../drm/amd/include/umsch_mm_4_0_api_def.h    | 13 ++++++++++--
 2 files changed, 21 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_umsch_mm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_umsch_mm.h
index 8258a43a6236..5014b5af95fd 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_umsch_mm.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_umsch_mm.h
@@ -33,13 +33,6 @@ enum UMSCH_SWIP_ENGINE_TYPE {
 	UMSCH_SWIP_ENGINE_TYPE_MAX
 };
 
-enum UMSCH_SWIP_AFFINITY_TYPE {
-	UMSCH_SWIP_AFFINITY_TYPE_ANY = 0,
-	UMSCH_SWIP_AFFINITY_TYPE_VCN0 = 1,
-	UMSCH_SWIP_AFFINITY_TYPE_VCN1 = 2,
-	UMSCH_SWIP_AFFINITY_TYPE_MAX
-};
-
 enum UMSCH_CONTEXT_PRIORITY_LEVEL {
 	CONTEXT_PRIORITY_LEVEL_IDLE = 0,
 	CONTEXT_PRIORITY_LEVEL_NORMAL = 1,
@@ -51,13 +44,15 @@ enum UMSCH_CONTEXT_PRIORITY_LEVEL {
 struct umsch_mm_set_resource_input {
 	uint32_t vmid_mask_mm_vcn;
 	uint32_t vmid_mask_mm_vpe;
+	uint32_t collaboration_mask_vpe;
 	uint32_t logging_vmid;
 	uint32_t engine_mask;
 	union {
 		struct {
 			uint32_t disable_reset : 1;
 			uint32_t disable_umsch_mm_log : 1;
-			uint32_t reserved : 30;
+			uint32_t use_rs64mem_for_proc_ctx_csa : 1;
+			uint32_t reserved : 29;
 		};
 		uint32_t uint32_all;
 	};
@@ -78,15 +73,18 @@ struct umsch_mm_add_queue_input {
 	uint32_t doorbell_offset_1;
 	enum UMSCH_SWIP_ENGINE_TYPE engine_type;
 	uint32_t affinity;
-	enum UMSCH_SWIP_AFFINITY_TYPE affinity_type;
 	uint64_t mqd_addr;
 	uint64_t h_context;
 	uint64_t h_queue;
 	uint32_t vm_context_cntl;
 
+	uint32_t process_csa_array_index;
+	uint32_t context_csa_array_index;
+
 	struct {
 		uint32_t is_context_suspended : 1;
-		uint32_t reserved : 31;
+		uint32_t collaboration_mode : 1;
+		uint32_t reserved : 30;
 	};
 };
 
@@ -94,6 +92,7 @@ struct umsch_mm_remove_queue_input {
 	uint32_t doorbell_offset_0;
 	uint32_t doorbell_offset_1;
 	uint64_t context_csa_addr;
+	uint32_t context_csa_array_index;
 };
 
 struct MQD_INFO {
@@ -103,6 +102,7 @@ struct MQD_INFO {
 	uint32_t wptr_val;
 	uint32_t rptr_val;
 	uint32_t unmapped;
+	uint32_t vmid;
 };
 
 struct amdgpu_umsch_mm;
diff --git a/drivers/gpu/drm/amd/include/umsch_mm_4_0_api_def.h b/drivers/gpu/drm/amd/include/umsch_mm_4_0_api_def.h
index beadb9e42850..ca83e9e5c3ff 100644
--- a/drivers/gpu/drm/amd/include/umsch_mm_4_0_api_def.h
+++ b/drivers/gpu/drm/amd/include/umsch_mm_4_0_api_def.h
@@ -234,7 +234,8 @@ union UMSCHAPI__SET_HW_RESOURCES {
 				uint32_t enable_level_process_quantum_check : 1;
 				uint32_t is_vcn0_enabled : 1;
 				uint32_t is_vcn1_enabled : 1;
-				uint32_t reserved : 27;
+				uint32_t use_rs64mem_for_proc_ctx_csa : 1;
+				uint32_t reserved : 26;
 			};
 			uint32_t uint32_all;
 		};
@@ -297,9 +298,12 @@ union UMSCHAPI__ADD_QUEUE {
 
 		struct {
 			uint32_t is_context_suspended : 1;
-			uint32_t reserved : 31;
+			uint32_t collaboration_mode : 1;
+			uint32_t reserved : 30;
 		};
 		struct UMSCH_API_STATUS api_status;
+		uint32_t process_csa_array_index;
+		uint32_t context_csa_array_index;
 	};
 
 	uint32_t max_dwords_in_api[API_FRAME_SIZE_IN_DWORDS];
@@ -314,6 +318,7 @@ union UMSCHAPI__REMOVE_QUEUE {
 		uint64_t context_csa_addr;
 
 		struct UMSCH_API_STATUS api_status;
+		uint32_t context_csa_array_index;
 	};
 
 	uint32_t max_dwords_in_api[API_FRAME_SIZE_IN_DWORDS];
@@ -337,6 +342,7 @@ union UMSCHAPI__SUSPEND {
 		uint32_t suspend_fence_value;
 
 		struct UMSCH_API_STATUS api_status;
+		uint32_t context_csa_array_index;
 	};
 
 	uint32_t max_dwords_in_api[API_FRAME_SIZE_IN_DWORDS];
@@ -356,6 +362,7 @@ union UMSCHAPI__RESUME {
 		enum UMSCH_ENGINE_TYPE engine_type;
 
 		struct UMSCH_API_STATUS api_status;
+		uint32_t context_csa_array_index;
 	};
 
 	uint32_t max_dwords_in_api[API_FRAME_SIZE_IN_DWORDS];
@@ -404,6 +411,7 @@ union UMSCHAPI__UPDATE_AFFINITY {
 		union UMSCH_AFFINITY affinity;
 		uint64_t context_csa_addr;
 		struct UMSCH_API_STATUS api_status;
+		uint32_t context_csa_array_index;
 	};
 
 	uint32_t max_dwords_in_api[API_FRAME_SIZE_IN_DWORDS];
@@ -417,6 +425,7 @@ union UMSCHAPI__CHANGE_CONTEXT_PRIORITY_LEVEL {
 		uint64_t context_quantum;
 		uint64_t context_csa_addr;
 		struct UMSCH_API_STATUS api_status;
+		uint32_t context_csa_array_index;
 	};
 
 	uint32_t max_dwords_in_api[API_FRAME_SIZE_IN_DWORDS];
-- 
2.25.1

