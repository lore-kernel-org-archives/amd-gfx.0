Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B13F6D17159
	for <amd-gfx@archiver.kernel.org>; Tue, 22 Oct 2024 02:27:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 42EFA10E2E4;
	Tue, 22 Oct 2024 02:27:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ulwNWfmA";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2059.outbound.protection.outlook.com [40.107.94.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EBDD010E2E4
 for <amd-gfx@lists.freedesktop.org>; Tue, 22 Oct 2024 02:27:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Tfvr+Jdfl9731NC4+xBEKaaCBekvLQlbDXc1KUEfpGmdfm25Sz8T95SO+1NU2TDuE3ZJudpR4JYy0F9fAe7DXKvRrf5apJ0XYLlCWcnzhgXecsenQ2uFbPm93rxm7hodEWNBeowmbVjXthyGbNQglkBMUStb+dgFp6S6v0PGUXDnPIk9cfUlBY9uaijHDiSCQZaWgXbDOM9kdL43KdKEK6agdQv5Z/Abfd0Q+gbK2R5bECrHaGe3+qI/4NoIRCSv58LEzHr+mRvUVa6tUj35G7ueOlnmgc7f3XjpHer/kRrwsj9tAeTnrbRsfzjHL0ap9CU4usYAF1nVX0yNNprQdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m0OMTKKc+1D0Hv1G8xNcgtHTbGi+6YeTPO0s9Yl1gHI=;
 b=xAYCyRFF6wZ+rMvlIi+HKkSXqjhDQFTHMeZKICiIwsepHpKNglQBiBE/VQBYdUj0WXM8URHJ1jiaN2M1OejTSyPK3/WI06V88zmOhIVjZo0Q+4r0oy19yhkor540iAwNS7bcL7FEpxXInZanvnl9fcLNi2se579a+AiHf3lQFzHd9wmGLACGqdltQj1q8/JTiEduyCrtj9ZC9yStRGNfkEDZJ2vLjsQqSDPmG5zyTbPexXDO1yp5LyCAWNDmytGm5dWifvVp0fWqBmZPR8Z1ZjfJv2TDvoMd/GjegPstlTjAk6z0qohXMiZwGFxaPBMeSTzpnCUnMH4wR9N6CsbFsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m0OMTKKc+1D0Hv1G8xNcgtHTbGi+6YeTPO0s9Yl1gHI=;
 b=ulwNWfmAHKioUwBinUCloDkF8wRM7vVGiYdgq1AdsVDT/AxBNZk2BR8ARRAimPLZmrGq0F3HH1wAzzuAtijAta74t91J69Vr1hdkk7SrYHpZddsILiw126KaBffAiwiiUb8mxm5bJ+CQu5sZasSgLg0yj6m7TtumU9Lt6I6Ab8U=
Received: from SA1P222CA0156.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:3c3::19)
 by SN7PR12MB8771.namprd12.prod.outlook.com (2603:10b6:806:32a::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.28; Tue, 22 Oct
 2024 02:27:53 +0000
Received: from SN1PEPF0002636E.namprd02.prod.outlook.com
 (2603:10b6:806:3c3:cafe::48) by SA1P222CA0156.outlook.office365.com
 (2603:10b6:806:3c3::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.29 via Frontend
 Transport; Tue, 22 Oct 2024 02:27:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF0002636E.mail.protection.outlook.com (10.167.241.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8093.14 via Frontend Transport; Tue, 22 Oct 2024 02:27:53 +0000
Received: from shaoyunl-dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 21 Oct
 2024 21:27:52 -0500
From: Shaoyun Liu <shaoyun.liu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Shaoyun Liu <shaoyun.liu@amd.com>
Subject: [PATCH] drm/amd : Update MES API header file for v11 & v12
Date: Mon, 21 Oct 2024 22:27:41 -0400
Message-ID: <20241022022741.761300-1-shaoyun.liu@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002636E:EE_|SN7PR12MB8771:EE_
X-MS-Office365-Filtering-Correlation-Id: 59890a08-d96f-4ee0-886b-08dcf24121f5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?npfHW2Ktc5UWiK0NWro+HmAXRwxJypMmk1gowvr0VH+aT6ukjBIwmxkK7ynJ?=
 =?us-ascii?Q?MPOHxgAtQl6IHTwQlH+Mb/OKZ55yxNrzwMQAYAKiwCdRMF6wdNiI6WHf4VzS?=
 =?us-ascii?Q?UDbPxKnwTahc+fuIF/Pm+BuRaKad/9uoOWoqoW85xXkRE+7d0wDBYpwBiSSK?=
 =?us-ascii?Q?UXHrXayD15tUgaSb+U62URCycdo/W5B9qxkIi4MOPFRc7Ob7DJqGByCzI951?=
 =?us-ascii?Q?TzTZuc2UqHyH5CwW4HvwyHbUjr+QFWbouAbhWmGJ4xQl8pRpgxxQxa6nO4IX?=
 =?us-ascii?Q?+9RNsgijJ3CvXiZKGIYY/fcpjV6U+B8mzEbRVjwrzOAKRmTvPEoYgyJ4c4S5?=
 =?us-ascii?Q?qu9aaSE0Djn9dDyPRitXywBIXHuSJ5hu7uZRjvZKDeHT86gwqmpcgACyEN/X?=
 =?us-ascii?Q?UkXiU3lbFnJNHjWSvs6y/jza98kIDejqlTlXDV4hKPypslSXZc9hRGkmPX7y?=
 =?us-ascii?Q?A7U64WsYfOPYWwYNzCtVLBMmcshdxUwVYuYo81a59WPlFFsqAKN2QAt4P3BY?=
 =?us-ascii?Q?s1HV0XiswOcyFGO4f7o7Q7NI5fq8gJ7mR16hRqi++S6t+znWLIKCV+ZdKE2S?=
 =?us-ascii?Q?qa8lU1j6HDl3tX/vdZjJ+I98/t1OS38qph/W57kpnVSbSQXhhOdi5KGf2u+C?=
 =?us-ascii?Q?WDUGBi1iMDA+Ck4LvNBBuAP2V1eLZo9ramZW8qfP/OQUdCefDz1HPe1woqlk?=
 =?us-ascii?Q?NnEH53aQiS+JBRSkz33y0v0bdFYnQ8upEk7uAILBlkGgY5vLsGMIhtoj8TzH?=
 =?us-ascii?Q?rIQDNhAjzAloYQVyGh4SfdLXmnC3PPDy/LMNcw/ZEnd4xGWwrk4ucRnD+n+W?=
 =?us-ascii?Q?OyiqrbSa4ndzlUq4FCz6/GNUFKI/95hKaCAPSVkh4S6A7bNUe6qOzw4z4S6v?=
 =?us-ascii?Q?3L4jy9R7GZKlmBlskG7ctziLXntO9k7Yic8nlY4PkKBrb7eNa+DAIUVKbG10?=
 =?us-ascii?Q?YSEY6jyStaEWIwf5XFGa5fCAp+an3vQSpspwgrGn60euJ6VaKdttO5iD5f1A?=
 =?us-ascii?Q?NPl4mbWgSEjSmcDaGsMNnQzEVRXCZChHTUgpC+Q4blwmeVJ4aIHZ+tZIC3JH?=
 =?us-ascii?Q?ZskvviYBHCNwyR2WUQNqlPctrTJGFltMVk30Dneq6qi4TLmKckRre6YB1w5D?=
 =?us-ascii?Q?Fy1XhfCSco8JNqwc+zCf/aQDza/f2xNFGvJU4kSYtirp8F9/JTDARi//Y+mT?=
 =?us-ascii?Q?FcFehQdk8qkcZTCD1AKVNUSgoX90Y9PgE5rS2xbU6mvEr+N5jySH9PgKEezx?=
 =?us-ascii?Q?7X/E9zMR2wGVc2MqBAOujJKVYWPtpUMg9/2II0nwDzLvHvCQq6WZLZl4YzEn?=
 =?us-ascii?Q?A17glpLllQ/oJ57VHs4ZBU2oA/pMvaTjAKfmZOtt8PKt7+srvlZoTig9qsfp?=
 =?us-ascii?Q?+z3lpEQ0CC2KkpcVnQz+WNLPH7KFc1Uq6BoH2jXCYebCnWo2KA=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2024 02:27:53.5521 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 59890a08-d96f-4ee0-886b-08dcf24121f5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002636E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8771
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
 drivers/gpu/drm/amd/include/mes_v11_api_def.h | 46 ++++++++++++++++++-
 drivers/gpu/drm/amd/include/mes_v12_api_def.h | 34 +++++++++++++-
 2 files changed, 78 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/include/mes_v11_api_def.h b/drivers/gpu/drm/amd/include/mes_v11_api_def.h
index 21ceafce1f9b..a9ff45334fdf 100644
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
 
@@ -617,6 +632,34 @@ struct SET_SHADER_DEBUGGER {
 	uint32_t trap_en;
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
+		struct {
+			uint32_t limit_single_process : 1;
+			uint32_t enable_hws_logging_buffer : 1;
+			uint32_t reserved : 31;
+		} bits;
+		uint32_t all;
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
@@ -631,6 +674,7 @@ union MESAPI__MISC {
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

