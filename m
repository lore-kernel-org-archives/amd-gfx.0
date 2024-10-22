Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 666B9D17159
	for <amd-gfx@archiver.kernel.org>; Tue, 22 Oct 2024 02:11:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F051910E088;
	Tue, 22 Oct 2024 02:11:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="W/soWD6w";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2075.outbound.protection.outlook.com [40.107.237.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 53B9910E088
 for <amd-gfx@lists.freedesktop.org>; Tue, 22 Oct 2024 02:11:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Bqle/BnO9W0SjjQgl7cCjefdyfvVfUV9ko4oP1nc+e4GR4D/DIIyuXdngJsZ74OOTzfbq2iJvk2bw9HftvjvmWhIy1aJuZsQSljRMpcPRqhJmz/YvYJVaWa8hfhiFToDol/v2CraBw7Am10lZDSAsfub99SzVVoCiBMO5SbAZMy/CkYkoJPyCe+iHiplCXaa19+gaZY3nM1FR4szvUBY2hUARN9YuZmvzyvPsqjx0Qi9yPG8J967skmwxY9cICktThXmbO7KZznabbDb7fFv3UrQuVorlCMQL3Zt6XrNOp+hGmyXaM1U4G0SV9ppyv7/ZFw/3HFVv5lZ5oVYXbqGhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HRJlq1pEDY0Q+IqO8UGsmQSi03uG3wjDP4kF53+/Eog=;
 b=B/F5n+FlC5TWAOy+PVd4bZgv4uDXXgi2oFfOjzt/Qa1cvK1VZc4pgBgJfbvme4MIR8SOQxioy5cNH/Eoe1vCCTyzKRHibDDKRaUoZhDsGRiiC7g3794jBBJB3BYu+o7dYrtU/fMur0piHb+wZD7wrS41PRe0aIimTRzQdsBhCJgrhWI8eypBj1sIskHB6F6/qLBi3yG/+xvCbNJcDMv4sYoDKn14IjTEMSsMErpXaT9PKHIOglC3UcL89fuRBwngRZvYqSV71PnW+vVxFSd4N3xqkt8OAay4WEDYgcNMpXSFSrMTjDfW9/BXQl/wBEk5gjhP0SNZNCsx/Z4iegs1Jw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HRJlq1pEDY0Q+IqO8UGsmQSi03uG3wjDP4kF53+/Eog=;
 b=W/soWD6wztEU0BN6sAq5xa9Yv33hlvt5BQDmgXjU+oyMboA2WdxJiExJ3sHANsxCNkmyVU8jqsR9uE4TSXJIFYSos3ZMBo/nPnHYJcNjWKiUpO/6iT3tbb7WTghQQit9kc4LqOduXjjo0/e1ojbMJZE9JaDfQF6xjsZvzt7wnnQ=
Received: from MN2PR19CA0004.namprd19.prod.outlook.com (2603:10b6:208:178::17)
 by DS0PR12MB7925.namprd12.prod.outlook.com (2603:10b6:8:14b::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.28; Tue, 22 Oct
 2024 02:11:15 +0000
Received: from BL6PEPF0001AB73.namprd02.prod.outlook.com
 (2603:10b6:208:178:cafe::f2) by MN2PR19CA0004.outlook.office365.com
 (2603:10b6:208:178::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.29 via Frontend
 Transport; Tue, 22 Oct 2024 02:11:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB73.mail.protection.outlook.com (10.167.242.166) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8093.14 via Frontend Transport; Tue, 22 Oct 2024 02:11:15 +0000
Received: from shaoyunl-dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 21 Oct
 2024 21:11:14 -0500
From: Shaoyun Liu <shaoyun.liu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Shaoyun Liu <shaoyun.liu@amd.com>
Subject: [PATCH] drm/amd : Update MES API header file for v11 & v12
Date: Mon, 21 Oct 2024 22:11:01 -0400
Message-ID: <20241022021101.761054-1-shaoyun.liu@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB73:EE_|DS0PR12MB7925:EE_
X-MS-Office365-Filtering-Correlation-Id: 122f79d4-14ed-4ee1-8f79-08dcf23ecedd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?j8ZVxmG0heP70OzXWkXTrLxkCokXdrkKi1g4t4XGdwoY/EG0WjSKHh1vMKZM?=
 =?us-ascii?Q?yknqWp+eJECSsr9Jkp4P4vSowdvztlrpopx/MhNjrsaJlW5lcP16hjnU5nPt?=
 =?us-ascii?Q?l1Jbfk3BSGaIRBzJsNDMcLWB/ZxXTHayMcI/YMVP061+NYbHG9ZLiM/jWlVN?=
 =?us-ascii?Q?nESlqgE48RdpRK50eUcLgGACNvHGIaN23hHZADiHyab9p3cZhowtvhHij+xd?=
 =?us-ascii?Q?wXXxUSrMq5xR+xjeHENzla2H6qky50tZoJv/4+2zUwOUZ9pwBgXpjgQqlBAS?=
 =?us-ascii?Q?LeF2z+0JvftB0UyF1bbnQqgXlsJe5bad8ADWdYp3GnIq50cVjUnddWy+1AYw?=
 =?us-ascii?Q?T8CPudqsTEohKMMvNhCiNop4c/g2B7kwyA24Mn2apNkzqfBEJ5MFaVishTdt?=
 =?us-ascii?Q?SrlV3mVS/iehmfgLfCg5JlKzXFe5AtmZddEe5R1SoLK7elE9RQzsNNghPVW5?=
 =?us-ascii?Q?qKtlPaL3VFAkYLDZmVWmGS8b9lSJmxXkK8+/x/bvO7NW6jComD7r9kh8pwxN?=
 =?us-ascii?Q?1sae9p+BnxiXvY3riRZcdFIeSdd5ngUnikFFUsm3xNzv5rPpthm96A5EOO1r?=
 =?us-ascii?Q?2Hvh+HB3fz0AVpHWfjgURfAyJt59Po6JGjRHxNFNk9b/lvClkkR23vfEAtED?=
 =?us-ascii?Q?SrgQ7iaOBVr/5ueOFRfJxNspBr9XeHXdmyQYmyMtxDQ/bUEJG7hKpJqNFTyF?=
 =?us-ascii?Q?pdhxkegRWYJlA72y4JfhgGd6MOhOL9X9c0WEcy2GBOUAg8eRNXIG+S2mJjrF?=
 =?us-ascii?Q?N/17/w2vV9j2/SXMCiE/ONIAIAnkRlRu64+YBmMOC/kS7Jm2KFKhI+VSXNRS?=
 =?us-ascii?Q?EXcwBeB0wo4LD4sk7xKY5vkf6uupqDLOrZlhMyCVf+sFqugrRuq4nyYjg9De?=
 =?us-ascii?Q?B5rennUcMmGiXqOBXZhV7pkFE6D9KeaADylElJIydFesx42LmGJpDB+9lyOA?=
 =?us-ascii?Q?gkwPMzDIlXYaXdVXps4bL+SH0iZzqx07j+Qp00zddRfWPN8jAif5AmqRyvQS?=
 =?us-ascii?Q?0mSzoXBmeQ4jc0u57G4FwlLXAVCBfmUtTkPGnDQLIJub79BRE+kPqqVDBdXj?=
 =?us-ascii?Q?qexEtjcBlm+9IjEhBwijzJaMZib6kf4nS9VoxuguZ0P1tFViUYGBb+iXmVSL?=
 =?us-ascii?Q?ZWDRWDufi660RzYeeCw4gdoc5cTDfabLyGIXGSmasO8uzIoHJkc3Bs0Y7AkG?=
 =?us-ascii?Q?ie//u480/hjzJwJVAzHwW7YE5bexo/UL2wpKwiiUTOihvs3MHi9sFGbiovzh?=
 =?us-ascii?Q?kOkPTXI3mQ13nFobgNmbudkKLecT5ngH6tQ+PP52JNj56yQRE083hjcdI8WO?=
 =?us-ascii?Q?nrIJ7CaeSmd75NZYIC+HlEVuMQD5YRTNARI1ssBIeC+6fD838PN8tyUO1JJA?=
 =?us-ascii?Q?R//HYGfrBI6sgek7PGW5wOq88oC201zs7QR3w5UfecAE6Zzxow=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2024 02:11:15.1507 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 122f79d4-14ed-4ee1-8f79-08dcf23ecedd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB73.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7925
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

New features require the new fields defines

Signed-off-by: Shaoyun Liu <shaoyun.liu@amd.com>
---
 drivers/gpu/drm/amd/include/mes_v11_api_def.h | 32 ++++++++++++++++-
 drivers/gpu/drm/amd/include/mes_v12_api_def.h | 34 ++++++++++++++++++-
 2 files changed, 64 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/include/mes_v11_api_def.h b/drivers/gpu/drm/amd/include/mes_v11_api_def.h
index 21ceafce1f9b..663f368eb4f0 100644
--- a/drivers/gpu/drm/amd/include/mes_v11_api_def.h
+++ b/drivers/gpu/drm/amd/include/mes_v11_api_def.h
@@ -230,13 +230,23 @@ union MESAPI_SET_HW_RESOURCES {
 				uint32_t disable_add_queue_wptr_mc_addr : 1;
 				uint32_t enable_mes_event_int_logging : 1;
 				uint32_t enable_reg_active_poll : 1;
-				uint32_t reserved	: 21;
+				uint32_t use_disable_queue_in_legacy_uq_preemption : 1;
+				uint32_t send_write_data : 1;
+				uint32_t os_tdr_timeout_override : 1;
+				uint32_t use_rs64mem_for_proc_gang_ctx : 1;
+				uint32_t use_add_queue_unmap_flag_addr : 1;
+				uint32_t enable_mes_sch_stb_log : 1;
+				uint32_t limit_single_process : 1;
+				uint32_t is_strix_tmz_wa_enabled  :1;
+				uint32_t reserved : 13;
 			};
 			uint32_t	uint32_t_all;
 		};
 		uint32_t	oversubscription_timer;
 		uint64_t        doorbell_info;
 		uint64_t        event_intr_history_gpu_mc_ptr;
+	        uint64_t	timestamp;
+		uint32_t	os_tdr_timeout_in_sec;
 	};
 
 	uint32_t	max_dwords_in_api[API_FRAME_SIZE_IN_DWORDS];
@@ -563,6 +573,11 @@ enum MESAPI_MISC_OPCODE {
 	MESAPI_MISC__READ_REG,
 	MESAPI_MISC__WAIT_REG_MEM,
 	MESAPI_MISC__SET_SHADER_DEBUGGER,
+	MESAPI_MISC__NOTIFY_WORK_ON_UNMAPPED_QUEUE,
+	MESAPI_MISC__NOTIFY_TO_UNMAP_PROCESSES,
+	MESAPI_MISC__CHANGE_CONFIG,
+	MESAPI_MISC__LAUNCH_CLEANER_SHADER,
+
 	MESAPI_MISC__MAX,
 };
 
@@ -617,6 +632,20 @@ struct SET_SHADER_DEBUGGER {
 	uint32_t trap_en;
 };
 
+struct CHANGE_CONFIG
+{
+    union
+    {
+        struct
+        {
+            uint32_t limit_single_process : 1;
+            uint32_t reserved : 31;
+        }bits;
+        uint32_t all;
+    }option;
+};
+
+
 union MESAPI__MISC {
 	struct {
 		union MES_API_HEADER	header;
@@ -631,6 +660,7 @@ union MESAPI__MISC {
 			struct          WAIT_REG_MEM wait_reg_mem;
 			struct		SET_SHADER_DEBUGGER set_shader_debugger;
 			enum MES_AMD_PRIORITY_LEVEL queue_sch_level;
+			struct		CHANGE_CONFIG change_config;
 
 			uint32_t	data[MISC_DATA_MAX_SIZE_IN_DWORDS];
 		};
diff --git a/drivers/gpu/drm/amd/include/mes_v12_api_def.h b/drivers/gpu/drm/amd/include/mes_v12_api_def.h
index 101e2fe962c6..62df832810ca 100644
--- a/drivers/gpu/drm/amd/include/mes_v12_api_def.h
+++ b/drivers/gpu/drm/amd/include/mes_v12_api_def.h
@@ -643,6 +643,10 @@ enum MESAPI_MISC_OPCODE {
 	MESAPI_MISC__SET_SHADER_DEBUGGER,
 	MESAPI_MISC__NOTIFY_WORK_ON_UNMAPPED_QUEUE,
 	MESAPI_MISC__NOTIFY_TO_UNMAP_PROCESSES,
+	MESAPI_MISC__QUERY_HUNG_ENGINE_ID,
+	MESAPI_MISC__CHANGE_CONFIG,
+	MESAPI_MISC__LAUNCH_CLEANER_SHADER,
+	MESAPI_MISC__SETUP_MES_DBGEXT,
 
 	MESAPI_MISC__MAX,
 };
@@ -713,6 +717,34 @@ struct SET_GANG_SUBMIT {
 	uint32_t slave_gang_context_array_index;
 };
 
+enum MESAPI_MISC__CHANGE_CONFIG_OPTION
+{
+	MESAPI_MISC__CHANGE_CONFIG_OPTION_LIMIT_SINGLE_PROCESS = 0,
+	MESAPI_MISC__CHANGE_CONFIG_OPTION_ENABLE_HWS_LOGGING_BUFFER = 1,
+	MESAPI_MISC__CHANGE_CONFIG_OPTION_CHANGE_TDR_CONFIG    = 2,
+
+	MESAPI_MISC__CHANGE_CONFIG_OPTION_MAX = 0x1F
+};
+
+struct CHANGE_CONFIG
+{
+	enum MESAPI_MISC__CHANGE_CONFIG_OPTION opcode;
+	union {
+		struct  {
+			uint32_t limit_single_process : 1;
+			uint32_t enable_hws_logging_buffer : 1;
+			uint32_t reserved : 30;
+		}bits;
+	        uint32_t all;
+	} option;
+
+	struct {
+		uint32_t tdr_level;
+		uint32_t tdr_delay;
+	} tdr_config;
+};
+
+
 union MESAPI__MISC {
 	struct {
 		union MES_API_HEADER	header;
@@ -726,7 +758,7 @@ union MESAPI__MISC {
 			struct WAIT_REG_MEM wait_reg_mem;
 			struct SET_SHADER_DEBUGGER set_shader_debugger;
 			enum MES_AMD_PRIORITY_LEVEL queue_sch_level;
-
+			struct CHANGE_CONFIG change_config;
 			uint32_t data[MISC_DATA_MAX_SIZE_IN_DWORDS];
 		};
 		uint64_t		timestamp;
-- 
2.34.1

