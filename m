Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B9E5C0218A
	for <amd-gfx@archiver.kernel.org>; Sat,  1 Feb 2025 03:35:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 89C1810E048;
	Sat,  1 Feb 2025 03:35:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="KhcmTqdy";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2070.outbound.protection.outlook.com [40.107.93.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3B42010E048
 for <amd-gfx@lists.freedesktop.org>; Sat,  1 Feb 2025 03:35:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nY7f86vo+qCwWCDbABormqfGnE9wm1//BDj3Dmg03D0e6xlwoqNFpK/Fkms/EQF71Jh87ynVyM5ZPKstRyd+OsPdFf4EcjKq02Cpe4ULIjEkYLYHN+Bz5Lp7pgXawZd/Fe7FbcqUcVyIJZUQfHg7EbDgtAWiG8Wwc9Ex7y58T2S7eM+emzLpYIO7kAnRUkTd83yd1xh9FYrhuSZyUI+4/XgqM50+4OfmVEnCU35mnEazrB0QNHaPrYfnlU7q6OXeyxCsxUqmgUcDm53MxxK1pwSD8IwBpmiRgr3T2QTsujp4GyApIj3msYQC9RTqKRYplAlFn52hcbPF15f5oUfTYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m0OMTKKc+1D0Hv1G8xNcgtHTbGi+6YeTPO0s9Yl1gHI=;
 b=IjFnlw/it3wRIDB3B2fcB4CdjBXiDSms4izwra5o75c+cWDnqNaAaNyiCPo4vylY3Iel9wF2Dd1rPgOe/hszfPBJByfxRClkVhMea4QJCAvEJOStnDavQs1G6WcbtTMtUwnNYsFjpInUfAvZfPf1PIJlZ1eojUh2l1FoT/SK6+Sx7a6RJrMstWNB47AxD1T0RyNlSpry5aNyQvuDSkA3NkLEJpQjwFBY1K7wPKvTPpBdA9xFOVojI0qIXoG45lO0y/TZeZ7V3Dwf9HTMhDkS/4xHgMACGTLUloRqJ3lziCVvUslATsZJX2dnnAq0azNlCYg2siSe4Xf0yHS3AOS8FQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m0OMTKKc+1D0Hv1G8xNcgtHTbGi+6YeTPO0s9Yl1gHI=;
 b=KhcmTqdyAlZdnORnazuKkLcAV47fMTEXwjzMb15+eZVkOcOX1fcHoVhV3c9TlVfYC1Kv2inob8wezGyyjNeXFDmjaVLRD6FvPGoq/muT4bMrt2N2ZGN8pmRmGwY5g1GByeIkjqV8G0Y9ROVFc1uXx+CKtZZTR0loviV3/JyjQm8=
Received: from MN2PR04CA0013.namprd04.prod.outlook.com (2603:10b6:208:d4::26)
 by IA0PR12MB8646.namprd12.prod.outlook.com (2603:10b6:208:489::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.18; Sat, 1 Feb
 2025 03:35:47 +0000
Received: from BL6PEPF00020E64.namprd04.prod.outlook.com
 (2603:10b6:208:d4:cafe::21) by MN2PR04CA0013.outlook.office365.com
 (2603:10b6:208:d4::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.20 via Frontend Transport; Sat,
 1 Feb 2025 03:35:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF00020E64.mail.protection.outlook.com (10.167.249.25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8398.14 via Frontend Transport; Sat, 1 Feb 2025 03:35:47 +0000
Received: from shaoyunl-dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 31 Jan
 2025 21:35:27 -0600
From: Shaoyun Liu <shaoyun.liu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Shaoyun Liu <shaoyun.liu@amd.com>
Subject: [PATCH] drm/amd : Update MES API header file for v11 & v12
Date: Fri, 31 Jan 2025 22:35:05 -0500
Message-ID: <20250201033505.3020-1-shaoyun.liu@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E64:EE_|IA0PR12MB8646:EE_
X-MS-Office365-Filtering-Correlation-Id: ac3b7215-b1c9-4a6a-795a-08dd4271843f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?zsaLiJ/z0YbDF3XZVJT0sjbLgxjgx/Jtdcqv9AeLWuzRBTKPoUb1PtDJ5f5x?=
 =?us-ascii?Q?YMr6b5XpUc2b4q9ju/o4YkFE3ThI9LlvIkGv7MQMRZhAX6Lahpgp6kyEM52u?=
 =?us-ascii?Q?qzR1MoZMVtAijPVEdma4Kxa47qi+pAVdDxE5f6VSyf77tafVi+rao6ogdmsE?=
 =?us-ascii?Q?qMpC++kp029xB4ZM/kbWdOkXRZbUPQytMD5Y8eOMCgPi4EJRit5oc8HINIyn?=
 =?us-ascii?Q?es1am4xznRZChenUlUcWzbEOeKQuehL7xjeLs0pkCWN01xR+ZL3jXP1bxod7?=
 =?us-ascii?Q?49wtfDQpLBDmyKLtE6vxOkGZ8wsIVKA/0oVIjM+pmyz0KtzFgNyY+ZnEuLVL?=
 =?us-ascii?Q?HYZ4sNpvd774YWR6tsTh6YtmtOczwTHjRIRvlGV9UJU3l+pwMeOTZN/529WF?=
 =?us-ascii?Q?7CgE9uW3/sgHPrBUG17oOgOGtgC6rAtY/cKl+MsE6FAf86tqR9LycWdsI9Z1?=
 =?us-ascii?Q?1X+8nT6dIhdl35SS12wFFJ7UwoW/NWxi8JYwxDmQECsPHQpS9juVZuwYvUzY?=
 =?us-ascii?Q?/MjRHWvXl/1NSGd60jSlgwLGtBVjejvPOoUo6ujiNo1R8xm3CmXObaDKiDoK?=
 =?us-ascii?Q?dhWqhShgR8RnPzuf8qSpMflLX4u0Ym8v+6YVJmuuQAr4RPvkMp6JQrROM2sR?=
 =?us-ascii?Q?xE2t+3qdQ0crTWmg/cYNvTWXiZXIsndSABff1YF4lHHmQCSOB4LUe0qf4vk2?=
 =?us-ascii?Q?V/XMx1gGSWwljWtT6+6GySF2wJAyaz45ioo4unwcM2bfQ5A9KX+j4HkYjiiM?=
 =?us-ascii?Q?QGOtb3uQUHUBe2EQKieoI6gk8sF0zRZBxlZuziEncpT9x736VHzO6pJBoEvs?=
 =?us-ascii?Q?uE/N6qcv4okTCGETvENVQOsdY+sSt85o0W87pXmfbsShfrIHLwT+2OtnwLl1?=
 =?us-ascii?Q?K9agMdR3BxfFX7xu9WLvv4daIJeBb2FXwwMRpHCkTP9cdYsR0CGGe27vRlO0?=
 =?us-ascii?Q?aOap9dioaPtuMrfB2gve7tvL5BLNv30tSYJQZssup1drzkc/3qG3vdIeZS33?=
 =?us-ascii?Q?oxLqwkjz77QmKYfPNmVB4/F4fqdK5Fzv0ggbyKszAwPtn/E/0MP2he6ygydl?=
 =?us-ascii?Q?5IEMq7P4rtuE8RXmf8blMjT1m1JU9SmMUlZYDU7XebVfI69GeoI/eby79uUl?=
 =?us-ascii?Q?+IwPfkRWkkeo8zHVSafJ/h3onlo6QwDa0Q0LQFF1fTSpbmuEk99OkYHW1bGC?=
 =?us-ascii?Q?5P6/cUSy4dhriBrPYWjvPVf4Y/6a7UnxerssfeyXBw8yshrxJdNfpLeZ1P52?=
 =?us-ascii?Q?Yh8gHAwf8ld54SkcMv+uDJLFBCYW4hnrMtIMWnn7Ew5PqW81XPa+MyIHD9uq?=
 =?us-ascii?Q?LEMDmo5yMhCHjD5tjjxnv8HEZyuClNR0Dx8pa5Vu/htq8QaAitBUP9duGOIB?=
 =?us-ascii?Q?G+5DuyTdWotyWeNTIZGgQQWy+1Y69HrhBeOYIgIsqo4ld0qTXA5wUg9l3xdO?=
 =?us-ascii?Q?/uTtUSkSx75Sop7mvJK0nab+ZBw932CNEomQSJr9pYvdfNjRZ+Y1TcVMKgfr?=
 =?us-ascii?Q?AbpXRoRNvkzIPZM=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Feb 2025 03:35:47.3343 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ac3b7215-b1c9-4a6a-795a-08dd4271843f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF00020E64.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8646
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

