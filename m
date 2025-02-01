Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09D14C0218A
	for <amd-gfx@archiver.kernel.org>; Sat,  1 Feb 2025 03:38:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AC0C510E146;
	Sat,  1 Feb 2025 03:38:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="wFnkAHDo";
	dkim-atps=neutral
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2070.outbound.protection.outlook.com [40.107.96.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A81A510E146
 for <amd-gfx@lists.freedesktop.org>; Sat,  1 Feb 2025 03:38:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LPZYc/Dt/m+W4lR8CRsgMB1fDnDcye827ucxR/ZMOahT7P7UyuzIPJp1vXUJOIWGPufyaxsBI5r60T7YTPozeTBft8TouKkZwjFQdcRtuefNbJrYoYTrsfZivFEVsB46lAT9wja036ofKMiyoeKtzEtm2JLI8aS9OaFoy0YUJBl2Ktx42WwCJiV2SAQW2xlSi/1auXxWj999NgRdo1ZZsnQv5LUuBQhn/6jiPiysXYRCPiMe17RV0TGRBa4YpU6ow2C3cjXIQ630GqpTlyqVftHUDS5Vl2WYMi4ve++HfMJOkESKDxG+GUIlN94reFwxawnfS1v+TQaWBnpvZ3R+Gg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/EX9tKcr9c36Thy/6qdU0Ou8xHk4doP9WKNijgVy8Ew=;
 b=f4s/W+grNb7KzNBE7R1icf6+WMzx88OpGa0NPXBd67c8u8tI7iI6+t6WtJ/YEb0Q7BuvCcTK7pvOFjLqIwCZmKH02BzhcgCAvm3ckA+kGYb/2xKmq7svuTw5jepoQpzVS7vB1XsBJozUgjynQ6Q4ImvJ0AjxGFZyL9E7RBuFocYd+W/RFZxdjcIVjHPCKbufhG59DC4rhKrMf1NrH85yLE7EcZOWa8wAw7Wuvgn+j+93Rb5krwqdBx/Y6laGewcADY1fK9giwzRALiOjsKG53kCzvEfskrWBLHaRN5yL4L+gl0i7Spw03ox2NS3KbxbJHNaThMGnboHmkC8+DZTitA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/EX9tKcr9c36Thy/6qdU0Ou8xHk4doP9WKNijgVy8Ew=;
 b=wFnkAHDoL8PSSfd74Xumn+W/gM3qb+K33lFMkaG3vQF53HCBJOFeZ6kiGrk91Xgk5lAN93ZVvNiJh7eOj65OWEu/K3ZvsaKfZZx47f/0XywaqItOB84aNmoq2vn6eWApwyLyi0hnTn70HrlDk5KbgS/2yrVepjiAr2/SM/JTGy8=
Received: from BL1PR13CA0028.namprd13.prod.outlook.com (2603:10b6:208:256::33)
 by IA0PR12MB8422.namprd12.prod.outlook.com (2603:10b6:208:3de::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.20; Sat, 1 Feb
 2025 03:37:57 +0000
Received: from BL6PEPF00020E62.namprd04.prod.outlook.com
 (2603:10b6:208:256:cafe::2d) by BL1PR13CA0028.outlook.office365.com
 (2603:10b6:208:256::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.21 via Frontend Transport; Sat,
 1 Feb 2025 03:37:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF00020E62.mail.protection.outlook.com (10.167.249.23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8398.14 via Frontend Transport; Sat, 1 Feb 2025 03:37:56 +0000
Received: from shaoyunl-dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 31 Jan
 2025 21:37:56 -0600
From: Shaoyun Liu <shaoyun.liu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Shaoyun Liu <shaoyun.liu@amd.com>
Subject: [PATCH] drm/amd/include : Update MES v12 API header according to new
 MES features
Date: Fri, 31 Jan 2025 22:37:43 -0500
Message-ID: <20250201033743.3046-1-shaoyun.liu@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E62:EE_|IA0PR12MB8422:EE_
X-MS-Office365-Filtering-Correlation-Id: 40a53db5-ed32-4c01-2853-08dd4271d156
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?R+nDFZHjDs+UOt1t+VRE+CRV+PBkxUO2YaPqueXogUeSYHnWYfp4KhVimWUd?=
 =?us-ascii?Q?MAaqnmSfJTTlwXJODPfXsJOEQXCpGtFpGya0WH79Rvjzk86HZRA9atUY+Rln?=
 =?us-ascii?Q?ooJ1SaUsm9K9w08g/Eq61BGf377ysPNl3YXT7TJ2W1c+ku++zMuhlrl3nPu0?=
 =?us-ascii?Q?fuw+pB+LC8Ghi0FVS0mHvRWpjnPiTpkMGyw33LBK4RYrnLGqCLxkPbA2OuGC?=
 =?us-ascii?Q?+qfmrKUBhIfuXDzeJ6AEcRdknamX3buF1I2zPdG5XTYd55FuhWI4vA+JRKAj?=
 =?us-ascii?Q?7NlohM875229Bv6TTLGF9bT81AKj70Vds3xMY5/XhkWgIi9DmWd70wR7g/pa?=
 =?us-ascii?Q?7J2BqBSAdyM3H7Fk3UiFr3Gotxw+9m5DJpdTEpkIb3XtACDzss/Ezj1eXlm4?=
 =?us-ascii?Q?dVNJIMq87PNVDkJ/GVG+TzrgvUl3LsXh9WTgfrClukrvx5W9LXD1S8cIlrX0?=
 =?us-ascii?Q?cOBVbN7EU/X3YkOGCT3UoiK2LljoFgII1MsbKCZta/7cVWGe0TR1UgGRYQjN?=
 =?us-ascii?Q?ROCd8uhy1u3wS68hqk8zPjaL+iYms3k/bhDt3IIh6SPXWZWRi/ThDrGNDGuv?=
 =?us-ascii?Q?5R0RGpp7WTjD6XOiwKoijsWh9rvi9NXZxMXIYHT6VhPAlZi2K50r7jcqnywF?=
 =?us-ascii?Q?2+FEx2kHKQ3AJQ985/eUoQuk2fIsveiX6Vv7PVkgsMOgCsraXrMcmESkV7kD?=
 =?us-ascii?Q?5c7Im8ahhDIrdLh1v2xn6SUNyucjBpBNgxX6C/T0keQzghxjD8u2ML3dd3+A?=
 =?us-ascii?Q?HHj8DHCYrVIjVdohZOtUxuDsmkiVNRiaJpWffs+j6KmNTv91Rk1lHhP1QPA+?=
 =?us-ascii?Q?43UE6Z/wrvuRHeYFkUVVSye/j7N8XYvD6KzZyqs/wM4srIkXbYUSKdw1n188?=
 =?us-ascii?Q?HUfM1nMTTagZcYuYORlhteOaQAqcZgGT9sCa0CKOF/uwrDhv5qUCGhJ/qoUN?=
 =?us-ascii?Q?yv7hWRhLNR8SCcaSYBIuri+iI4mVtjjlnUojywTS5cYrIYTJoerDI0kMFHJm?=
 =?us-ascii?Q?bLsX1VTrlXH5AOSdfagEz547NEOHbf/T5LdGLJBK45vRsYGTvYrR90qrFXaW?=
 =?us-ascii?Q?xqsbZFcGYa+VkUDsO7ABuG1zGHK+cppZZcnzkSe1ZEpYUCdee4xZXmBU1u9m?=
 =?us-ascii?Q?ygpiz5Rq8Cno4noZiD4G87vJNdgo/M1VNSrEJxjT/pcXpKqbBzL+2Onm/jVg?=
 =?us-ascii?Q?tcT0uCGiCcfBaox6B6AFAABJ7pX9gH4vLBEBHp6tSs+k5tIhkCJBcqSAFPzS?=
 =?us-ascii?Q?5Dupfv8W+NT765Gq+l3woP0HobQ2HRVifZtKKnODfy6iV7CgjO+bm4MRrIUf?=
 =?us-ascii?Q?32wOORd3XDu+zqjnRooFWaRRdvUw3UHvfh7VYeHGZ8wu3VbnRnnBaxLZRrG+?=
 =?us-ascii?Q?7Bg2mM/omUTNhbZB+kcocXr76sPJEr+puGPPA3hY/hEwcjj51pNANp5UDFat?=
 =?us-ascii?Q?pupoTNfHASb35FMnzPF7Q0GoPzqRyHYEQiMTP3C9eyF4T+eB74Tc7tUhp1jU?=
 =?us-ascii?Q?PxX7SecL0v1DL8U=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Feb 2025 03:37:56.6363 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 40a53db5-ed32-4c01-2853-08dd4271d156
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF00020E62.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8422
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

1. MES fence_value will be updated in fence_addr if API success, otherwise
   upper 32 bit will be used to indicate error code. In any case, MES will
   trigger an EOP interrupt with 0xb1 as context id in the interrupt cookie
2. Add RRMT option support which will be used for remote die register access
3. Update set_hw_resource1 for cooperative mode support
4. Add full_sh_mem_config_data for xnack support

Signed-off-by: Shaoyun Liu <shaoyun.liu@amd.com>
---
 drivers/gpu/drm/amd/include/mes_v12_api_def.h | 98 ++++++++++++++++++-
 1 file changed, 93 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/include/mes_v12_api_def.h b/drivers/gpu/drm/amd/include/mes_v12_api_def.h
index c9b2ca5cf75f..05e74f1d7eb1 100644
--- a/drivers/gpu/drm/amd/include/mes_v12_api_def.h
+++ b/drivers/gpu/drm/amd/include/mes_v12_api_def.h
@@ -105,6 +105,43 @@ struct MES_API_STATUS {
 	uint64_t api_completion_fence_value;
 };
 
+/*
+ * MES will set api_completion_fence_value in api_completion_fence_addr when
+ * it can successflly process the API.  MES will also trigger following interrupt
+ * when it finish process the API no matter success or failed.
+ *     Interrupt source id 181 (EOP) with context ID (DW 6 in the int cookie)
+ *     set to 0xb1 and context type set to 8. Driver side need to enable
+ *     TIME_STAMP_INT_ENABLE in CPC_INT_CNTL for MES pipe to catch this interrupt.
+ *     Driver side also need to set enable_mes_fence_int = 1 in set_HW_resource
+ *     package to enable this fence interrupt
+ * when the API process failed.
+ *     lowre 32 bits set to 0.
+ *     higher 32 bits set as follows (bit shift within high 32)
+ *         bit 0  -  7    API specific error code.
+ *         bit 8  - 15    API OPCODE.
+ *         bit 16 - 23    MISC OPCODE if any
+ *         bit 24 - 30    ERROR category (API_ERROR_XXX)
+ *         bit 31         Set to 1 to indicate error status
+ *
+ */
+enum { MES_SCH_ERROR_CODE_HEADER_SHIFT_12 = 8 };
+enum { MES_SCH_ERROR_CODE_MISC_OP_SHIFT_12 = 16 };
+enum { MES_ERROR_CATEGORY_SHIFT_12 = 24 };
+enum { MES_API_STATUS_ERROR_SHIFT_12 = 31 };
+
+enum MES_ERROR_CATEGORY_CODE_12
+{
+	MES_ERROR_API                = 1,
+	MES_ERROR_SCHEDULING         = 2,
+	MES_ERROR_UNKNOWN            = 3,
+};
+
+#define MES_ERR_CODE(api_err, opcode, misc_op, category) \
+			((uint64) (api_err | opcode << MES_SCH_ERROR_CODE_HEADER_SHIFT_12 | \
+			misc_op << MES_SCH_ERROR_CODE_MISC_OP_SHIFT_12 | \
+			category << MES_ERROR_CATEGORY_SHIFT_12 | \
+			1 << MES_API_STATUS_ERROR_SHIFT_12) << 32);
+
 
 enum { MAX_COMPUTE_PIPES = 8 };
 enum { MAX_GFX_PIPES	 = 2 };
@@ -248,7 +285,8 @@ union MESAPI_SET_HW_RESOURCES {
 				uint32_t enable_mes_sch_stb_log : 1;
 				uint32_t limit_single_process : 1;
 				uint32_t unmapped_doorbell_handling: 2;
-				uint32_t reserved : 11;
+				uint32_t enable_mes_fence_int: 1;
+				uint32_t reserved : 10;
 			};
 			uint32_t uint32_all;
 		};
@@ -270,7 +308,8 @@ union MESAPI_SET_HW_RESOURCES_1 {
 		union {
 			struct {
 				uint32_t enable_mes_debug_ctx : 1;
-				uint32_t reserved : 31;
+				uint32_t mes_coop_mode : 1; /* 0: non-coop; 1: coop */
+				uint32_t reserved : 30
 			};
 			uint32_t uint32_all;
 		};
@@ -278,6 +317,8 @@ union MESAPI_SET_HW_RESOURCES_1 {
 		uint32_t                            mes_debug_ctx_size;
 		/* unit is 100ms */
 		uint32_t                            mes_kiq_unmap_timeout;
+		/* shared buffer of master/slaves, valid if mes_coop_mode=1 */
+		uint64_t                            coop_sch_shared_mc_addr;
 	};
 
 	uint32_t max_dwords_in_api[API_FRAME_SIZE_IN_DWORDS];
@@ -341,6 +382,7 @@ union MESAPI__ADD_QUEUE {
 		uint32_t		pipe_id;	//used for mapping legacy kernel queue
 		uint32_t		queue_id;
 		uint32_t		alignment_mode_setting;
+		uint32_t		full_sh_mem_config_data;
 	};
 
 	uint32_t max_dwords_in_api[API_FRAME_SIZE_IN_DWORDS];
@@ -629,6 +671,7 @@ union MESAPI__SET_DEBUG_VMID {
 		uint32_t		process_context_array_index;
 
 		uint32_t		alignment_mode_setting;
+		uint32_t		full_sh_mem_config_data;
 	};
 
 	uint32_t max_dwords_in_api[API_FRAME_SIZE_IN_DWORDS];
@@ -653,9 +696,51 @@ enum MESAPI_MISC_OPCODE {
 
 enum {MISC_DATA_MAX_SIZE_IN_DWORDS = 20};
 
-struct WRITE_REG {
-	uint32_t	reg_offset;
-	uint32_t	reg_value;
+/*
+ * RRMT(Register Remapping Table), allow the firmware to modify the upper address
+ * to correctly steer the register transaction to either the local AID/XCD or
+ * remote MID on SMN.
+ * mode : Mode of operation for RRMT
+ *	0=Local XCD
+ *	1=Remote/Local AID
+ *	2=Remote XCD
+ *	3=Remote MID
+ * mid_die_id : Physical ID number of the Multimedia IO Die (MID) to be accessed for RRMT.
+ *	0=MID0.
+ *	1=MID1
+ * xcd_die_id :	Virtual ID number of the Accelerated Compute Die (XCD)
+ *	to be accessed for RRMT. For MI400, there are 2 Active
+ *	Interposer Die (AID) each with 4 XCDs. The number of
+ *	available XCDs depends on the Partition Mode programmed
+ *	by the Secure Processor
+ *	0=XCD0.
+ *	1=XCD1.
+ *	2=XCD2.
+ *	3=XCD3.
+ *	4=XCD4.
+ *	5=XCD5.
+ *	6=XCD6.
+ *	7=XCD7.
+ *
+ */
+struct RRMT_OPTION
+{
+	union {
+		struct {
+			uint32_t mode : 4;
+			uint32_t mid_die_id : 4;
+			uint32_t xcd_die_id : 4;
+		};
+		uint32_t all;
+	};
+};
+
+
+struct WRITE_REG
+{
+	uint32_t                  reg_offset;
+	uint32_t                  reg_value;
+	struct RRMT_OPTION        rrmt_opt;
 };
 
 struct READ_REG {
@@ -668,6 +753,7 @@ struct READ_REG {
 		} bits;
 		uint32_t all;
 	} option;
+	struct RRMT_OPTION        rrmt_opt;
 };
 
 struct INV_GART {
@@ -693,6 +779,8 @@ struct WAIT_REG_MEM {
 	uint32_t mask;
 	uint32_t reg_offset1;
 	uint32_t reg_offset2;
+	struct RRMT_OPTION rrmt_opt1; /* for reg1 */
+	struct RRMT_OPTION rrmt_opt2; /* for reg2 */
 };
 
 struct SET_SHADER_DEBUGGER {
-- 
2.34.1

