Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DAF8CFA466
	for <amd-gfx@archiver.kernel.org>; Mon, 24 Nov 2025 15:27:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 424D410E2F3;
	Mon, 24 Nov 2025 15:27:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="CiZ9bh81";
	dkim-atps=neutral
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011044.outbound.protection.outlook.com [40.107.208.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AD73E10E2F3
 for <amd-gfx@lists.freedesktop.org>; Mon, 24 Nov 2025 15:27:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IuxM9duLIallHiolAgq6TiEdTbydHA3XzldTUFMWatDorIhqWDeFBZ237tY0GGaGUF6WaAoJftIetst+74ff9Te6YSGctu3YsY3am5UuBEsg+BsdF5kEJMFM9Fn7ajsf4IcA4ch/UuG06UB1fl+JbqTv9Ms7dN4hu3Pu/5/eWV3iV93Ck7XtqO8zEK4CkKH6LbeRoNDyKEA6d53iRP6oeZSls2F1Ox7n5oLh+A6trBKyNltKySCZ5p9bIbvohIdTwsrl/zKVRlQQIs6kizt9Zscgy9cJl1ZFtevj0eRjcTUIOmBZIXdNdmkoHI9OEHut7OZ+tey2PrBgEVs04W8QhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xF9OZwAxp1sT30FtlXS1nBE46DLWcxwu5HEfQpAXJlA=;
 b=GKjxswW0CA+/PamMr97wv1n4nt/aP8fTX+xZkVFVgdfQKvQOCIReQFcNnRi10OxUs1COzqviAy+v71LdGwiLD9u4B70hYMBvG24O3bO5ccIhWJ6cTtvFp7sxFRMT/sY3IWDGsMdXWe5hnoS7mpPT7ykVQZ53udQwt/d4SHivjDkC0LjQf3hiOxu4NkIwn7FmRIXCbuCzIM3xFNGSfSFHlbEXO2m3UnKIyA49R8/s/BdmsS5ngqT1HFLtfeu9U4Yis7RpownnQra7E2+ZUPBU+721IG+vY49eD+NF82liKsSEQUMHxgMCYnIIpudcJiutChMrgBkC0HCDYVOmBlxrFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xF9OZwAxp1sT30FtlXS1nBE46DLWcxwu5HEfQpAXJlA=;
 b=CiZ9bh81tHmuFUokHLYKQmE3laEnNGnbvSK2NkGdRnuGrSKpqbOUSl+n2wu84DJW0soPTgwCKVfaAUSsdPYVs/pF8hSSMDPl0wjX0PQ8UhuLNZ8VQ/SX7+ZS+yADw510nxDkxxFXDbd2rXyyyRL4wx6BjKsZ2oCTfjEiz9wUoik=
Received: from BL1PR13CA0334.namprd13.prod.outlook.com (2603:10b6:208:2c6::9)
 by LV3PR12MB9355.namprd12.prod.outlook.com (2603:10b6:408:216::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.17; Mon, 24 Nov
 2025 15:27:33 +0000
Received: from BL02EPF00021F68.namprd02.prod.outlook.com
 (2603:10b6:208:2c6:cafe::23) by BL1PR13CA0334.outlook.office365.com
 (2603:10b6:208:2c6::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9366.7 via Frontend Transport; Mon,
 24 Nov 2025 15:27:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL02EPF00021F68.mail.protection.outlook.com (10.167.249.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9366.7 via Frontend Transport; Mon, 24 Nov 2025 15:27:33 +0000
Received: from tr4.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 24 Nov
 2025 09:27:32 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Shaoyun Liu <shaoyun.liu@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH] drm/amd/include : Update MES v12 API header
Date: Mon, 24 Nov 2025 10:27:20 -0500
Message-ID: <20251124152720.429266-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.51.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF00021F68:EE_|LV3PR12MB9355:EE_
X-MS-Office365-Filtering-Correlation-Id: b0a1ed39-906f-4fa5-43db-08de2b6dfd21
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?p2AsD1lqWXuHLirBNSkJ5Rr7qvht58gJw5U4T7f9VNnXEmpydWJk7KBSxISp?=
 =?us-ascii?Q?Qtnk4PItXhzqA3VYTIhadMN2d6uBSiOdVV6uOnnhvvY5KGE1NxBszDH75IiE?=
 =?us-ascii?Q?Wa0+ONMQU+dxdYv50vnL2GaKML0LQGlL3Lx9M/8C46RM5tn4ardlbgBXXyY3?=
 =?us-ascii?Q?ovnYptgJpJh7O8pie/g3W3T+P5jUlRTp5DcA8qrF7g/UCUS3DTTzPbRdqDnL?=
 =?us-ascii?Q?h9Ao4f3tpEvEi2n3oG24Plc0lRdZx8IrPxIeIK1b2XMHnN2JVutstT235Zuz?=
 =?us-ascii?Q?UDc5leCIPIIzGY37t36GHIrt5jtV2EEbnjIInNpFpFHD3me9zoTXRJWoeWgT?=
 =?us-ascii?Q?WGEq9t1e2WNwUUV76EMDgztyS3Mk7mmXzx1ZtAkkVEky/LRd2Kl3tCqwa7fx?=
 =?us-ascii?Q?eT3gXWTUaVY3gMVfBQbsOBYhRUdPRcTo76E35dnCUpZpHiRY5G1kbVG9ugQD?=
 =?us-ascii?Q?yPr4EGk/KerMeVHwdyjmKf/aRdwKOx7QULMKpDZgvVoPeRh2ne2QILYDz3Sc?=
 =?us-ascii?Q?126JNkeeeoIHLuMGZDvwuer1Ctlrw8n1YoDEnNYnvqsWbkItt+kx3Fx4oiqo?=
 =?us-ascii?Q?GCZlRIpLp9UGCnnI/L/pRgLzR4x+5p3fAYthuHaL6YRHmv0GtMCThs5JwRkg?=
 =?us-ascii?Q?Q5nkIPLLoHL86EBB6J9Ob4utNnGtxe0PTJB0ZxykvSeWSgoPZSctJHECJKl4?=
 =?us-ascii?Q?skpPtLrJaw0WqX9DuFcHSMpd5QH+12M0cfS7VoBrXgEq23mvWsKGXOir5Sc1?=
 =?us-ascii?Q?NMLgPu1mvHofqxw1BuJYeALiSJHPJ/nTYoj6PwSMiRtggM1FKs/St6XaK5Qu?=
 =?us-ascii?Q?Dm0nYrIn7Uw+oGn2Z0BZjWSvrXZkHJ9kYHF/w7aXe83xo5GdnBEh5hxIQakx?=
 =?us-ascii?Q?nZoroULCTAgpOxOP8/e18l9CBnzRQLhaa9WiYK8DUtHCP7lF/3yTH6O5cCHO?=
 =?us-ascii?Q?kjbXUgVqq7e2wF82yCVTpp6PcsQ5XJH66de2ScZK/fgZcoXddVKJR3vqrzQJ?=
 =?us-ascii?Q?BE3Aj3g0R4ttHDoOEa2AVWr8jt+GEw4WBxvxATZkwZyun4d9sgbGQMLTcset?=
 =?us-ascii?Q?kcteMSFB67Rv6Wm7efSGtrKwWBCXJje9dPYB9CCysaVOguIiuqROGBOgbw2X?=
 =?us-ascii?Q?kW/iMUM7/AZ2IuAfDYrSFtQAkVg+wZ56XVGpma/VWNjV2561tgHq1YdIgumr?=
 =?us-ascii?Q?XDvReZ7TV6cfSvx97mMc+Imzcnf1HFDMgxPPiloTJYX2UHIZMDw1/r08sT4d?=
 =?us-ascii?Q?hYB+49gTIQgJ7Sx2nhfxsnpcFO06t/38rIVwOhm8sM4HxNJnWaoFlGFBjCtP?=
 =?us-ascii?Q?O9YZJJ9e3DXCivoUibnc0YCYcGy79VNOyQBKMDTMVGcAHql0swseUT8GqIYO?=
 =?us-ascii?Q?5V+8sCA9wyYcrJYHOOVxOeM7N53mSVkiwBUN0MyeOI1ypVueVOYgrCZygcuM?=
 =?us-ascii?Q?qGsoFL3svfhe2uXi43nr1H2d1gubj++A8QyWYJ4RbFWX8Q7VKY9ZXd30iQAv?=
 =?us-ascii?Q?zk+l3kDo4JjxC0xYhm8TSgSCtGyivPVh82VnLbpD9WE4peC78NUQEovNYEx3?=
 =?us-ascii?Q?cORPQR4RR1q/7QP/xys=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2025 15:27:33.1005 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b0a1ed39-906f-4fa5-43db-08de2b6dfd21
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF00021F68.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9355
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

1. Add RRMT option support which will be used for remote die
   register access
2. Update set_hw_resource1 for cooperative mode support
3. Add full_sh_mem_config_data for xnack support

v2: squash in compilation fix

Signed-off-by: Shaoyun Liu <shaoyun.liu@amd.com>
Acked-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/include/mes_v12_api_def.h | 32 ++++++++++++++++---
 1 file changed, 28 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/include/mes_v12_api_def.h b/drivers/gpu/drm/amd/include/mes_v12_api_def.h
index 2f12cba4eb662..256eb7f702f66 100644
--- a/drivers/gpu/drm/amd/include/mes_v12_api_def.h
+++ b/drivers/gpu/drm/amd/include/mes_v12_api_def.h
@@ -310,7 +310,8 @@ union MESAPI_SET_HW_RESOURCES_1 {
 		union {
 			struct {
 				uint32_t enable_mes_debug_ctx : 1;
-				uint32_t reserved : 31;
+				uint32_t mes_coop_mode : 1; /* 0: non-coop; 1: coop */
+				uint32_t reserved : 30;
 			};
 			uint32_t uint32_all;
 		};
@@ -318,7 +319,8 @@ union MESAPI_SET_HW_RESOURCES_1 {
 		uint32_t                            mes_debug_ctx_size;
 		/* unit is 100ms */
 		uint32_t                            mes_kiq_unmap_timeout;
-		uint64_t                            reserved1;
+		/* shared buffer of master/slaves, valid if mes_coop_mode=1 */
+		uint64_t                            coop_sch_shared_mc_addr;
 		uint64_t                            cleaner_shader_fence_mc_addr;
 	};
 
@@ -383,6 +385,7 @@ union MESAPI__ADD_QUEUE {
 		uint32_t		pipe_id;	//used for mapping legacy kernel queue
 		uint32_t		queue_id;
 		uint32_t		alignment_mode_setting;
+		uint32_t		full_sh_mem_config_data;
 	};
 
 	uint32_t max_dwords_in_api[API_FRAME_SIZE_IN_DWORDS];
@@ -672,6 +675,7 @@ union MESAPI__SET_DEBUG_VMID {
 		uint32_t		process_context_array_index;
 
 		uint32_t		alignment_mode_setting;
+		uint32_t		full_sh_mem_config_data;
 	};
 
 	uint32_t max_dwords_in_api[API_FRAME_SIZE_IN_DWORDS];
@@ -696,9 +700,26 @@ enum MESAPI_MISC_OPCODE {
 
 enum {MISC_DATA_MAX_SIZE_IN_DWORDS = 20};
 
+/*
+ * RRMT(Register Remapping Table), allow the firmware to modify the upper
+ * address to correctly steer the register transaction to expected DIE
+ */
+struct RRMT_OPTION {
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
 struct WRITE_REG {
-	uint32_t	reg_offset;
-	uint32_t	reg_value;
+	uint32_t                  reg_offset;
+	uint32_t                  reg_value;
+	struct RRMT_OPTION        rrmt_opt;
 };
 
 struct READ_REG {
@@ -711,6 +732,7 @@ struct READ_REG {
 		} bits;
 		uint32_t all;
 	} option;
+	struct RRMT_OPTION        rrmt_opt;
 };
 
 struct INV_GART {
@@ -736,6 +758,8 @@ struct WAIT_REG_MEM {
 	uint32_t mask;
 	uint32_t reg_offset1;
 	uint32_t reg_offset2;
+	struct RRMT_OPTION rrmt_opt1; /* for reg1 */
+	struct RRMT_OPTION rrmt_opt2; /* for reg2 */
 };
 
 struct SET_SHADER_DEBUGGER {
-- 
2.51.1

