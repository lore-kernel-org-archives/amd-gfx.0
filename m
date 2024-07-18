Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF27DC3DA49
	for <amd-gfx@archiver.kernel.org>; Thu, 18 Jul 2024 13:59:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A6F9E10E899;
	Thu, 18 Jul 2024 13:59:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="JIQUBRw9";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2055.outbound.protection.outlook.com [40.107.92.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C857D10E899
 for <amd-gfx@lists.freedesktop.org>; Thu, 18 Jul 2024 13:59:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XlEcC7B3/dcCYDB30PYX+VhL4fXDhJDRaoVv6lklm0ojH/4GQt+jmMgRVMv8yW66dDyG5ARUjGLlTI2Cx3hG8FAtlH50u3ItYHHJKc8k56V5XYP1J/YWlSq8eb8wKi/QxHTIVqBs6YLSO6ozumxUg7E3H3czgiEppCUa7BuUljadZjuRy5impUTDMe7f37pXpPnbqVE1+WQps8ZdMB/QwR7ns0PJWX/Dj4WiYFYLMlXTNVQa3xeGB36R84CgbL9uwcHAdaG0olJbJdBnD/wfYIF0CbhYnvk4fnnC9trWmKUwf2InbqSgXnCUkYV6XRSf0x+t47ubsf3uxmqA71dAog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QDFReqgQtfR5MqeRTBhgl7Pkn6oL9YnpY1+Ro3e16OI=;
 b=Y0QWTVBUb0TMrpWUMrHl/gVGdYD0IUpevFYFVqcdaEqGdAZahrueKmWGjfOXTAl8a46ciqjkbO+RApPexqRtLplBaU8fjBPuZI5vxjJuR47fRRt8S9dO+PqEcgXcYqjGsOmgDuwTO8kSgPbxlnwJBT1FXtBtUNGxd1LBQyk4QEZODk4Gj/RTb6L6pgKzYiDTFS2unnkre7w7lm7V6ePCOGsgFf1TC5UIyfRKRCTCRl1TieHVERh1pTVkFWzuk/Q+VKcSYq0Buz5TR7UFDEV6K5kgRUj75VrKTBPJM/XoynC1G2wXg7ilVfNvd7MXnfAo/5PDdu/ndpCq/grNi0qQIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QDFReqgQtfR5MqeRTBhgl7Pkn6oL9YnpY1+Ro3e16OI=;
 b=JIQUBRw9KAB44WXAC6tlGY8mELOsF0fuAQnTSqOqN3Pnvk2q5HaVzEyCsMCwt8LB5aWdawb7W5lcZvWaC1m25hU1THhnJgu0lFmszh/mmMz4F6FVCmCCgJIGC9B5nbgvDDj+1wGcHYDaIBPmABXONTA4gXVZtOEKRKr5vNBx11U=
Received: from BY3PR10CA0028.namprd10.prod.outlook.com (2603:10b6:a03:255::33)
 by CH2PR12MB4184.namprd12.prod.outlook.com (2603:10b6:610:a7::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.29; Thu, 18 Jul
 2024 13:59:18 +0000
Received: from SJ1PEPF00001CDD.namprd05.prod.outlook.com
 (2603:10b6:a03:255:cafe::a9) by BY3PR10CA0028.outlook.office365.com
 (2603:10b6:a03:255::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.28 via Frontend
 Transport; Thu, 18 Jul 2024 13:59:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00001CDD.mail.protection.outlook.com (10.167.242.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7784.11 via Frontend Transport; Thu, 18 Jul 2024 13:59:17 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 18 Jul
 2024 08:59:15 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH] drm/amdgpu/gfx10: handle SDMA in KIQ map/unmap
Date: Thu, 18 Jul 2024 09:59:00 -0400
Message-ID: <20240718135900.1726955-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CDD:EE_|CH2PR12MB4184:EE_
X-MS-Office365-Filtering-Correlation-Id: f50fc6d3-e15f-4913-fe7e-08dca731d0cd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?21V95NEgDkLH9lkuEglap+jVG+9uG4Qarg8IPGfcaAVBSNSUX25Zg30QF00s?=
 =?us-ascii?Q?sSHDN2S5TClSwL0BNhGtBozkNPC9r2Fth+odm/s7KmsY+0HI4GlnQuZ4/XcY?=
 =?us-ascii?Q?+GdZ/nfpkEdZ9GCgFLyeH73qnavf+NL8QAcylYb2YaKUE8jaHQWYWuO+HjDH?=
 =?us-ascii?Q?RQcuL+7o0rOJyqe1dbx8kwsj0rgchWTplyyCSfEmERlbNF9JbdrX3HA3nE0M?=
 =?us-ascii?Q?z7vKrIdvrzPg9q6L2aDjBBoJWCx6MgRGdNGOdbGhWOG+/+hC8RM1KBQCwGNf?=
 =?us-ascii?Q?Cvq3o9nSs+XjGodenEqBwU9T0LHQuISNcfHYq0K2ziyBTHLrFz0CMIsSNzvq?=
 =?us-ascii?Q?wYGCXacN61WFZJwBK4C1Uyin9K+2xGhDzuqKpNQWuGzWkvrBEUH+DjBevnRu?=
 =?us-ascii?Q?eiYlHD4DsavDUQET95eC2nWjGe11mvtJtDpK6tOLu7TFyz7an2AH+3GKKb2k?=
 =?us-ascii?Q?paaapp6IaAyFreRPhPOMbJ6y1VOXbeGtVqsLP9MQKwL2FJpIdjYVsDLQrYep?=
 =?us-ascii?Q?5fA8ih0sv9WrZOAXzX2XPqUIF/R8zkZg9TmCRMyN/qa661d8u5rvNVila8F/?=
 =?us-ascii?Q?trmb7Ow9nnO6tGyCTFnaWhwSD7/Tb+52AHvsSxKa7C3yczBGXbn1TxhCAbbV?=
 =?us-ascii?Q?RxJYhE6PqV+bMuVj7n62z7HKcGenfB/AywQfhA4mLULq14M4N494e87DSTet?=
 =?us-ascii?Q?HAStMy94cWI3tgN4qRXQp7dhDnB1Yw/XtQYJqRfcL072ojazNZgYhqopBx68?=
 =?us-ascii?Q?sa4KiEK2LgHzExfgmQte79NYGuZEx3kvWJ4pY7a5y5zNtF+Y4kwUXXvZbfbt?=
 =?us-ascii?Q?Gw56f+/fOpCr2ZQWrs7B7CW/74llVwFewrxTJ4zWddl4d6YMJkx4MyzprIJl?=
 =?us-ascii?Q?y/7Gnt3Wubf9on9/RdfiPKE5l/Bqw4+Gwo4qkg/paSSQJ0kRHB9m8uwRmaS9?=
 =?us-ascii?Q?uDqjcpF6VodE/1ivPqHjG7RZNTNV/sDV4LpUdhCZPxp6LFlOuRlfVTNErn4q?=
 =?us-ascii?Q?Wf8vau+DKFB2hK94Y/QCDzFYRIqMccZT972HDmc2CyZoDqyshXVcoG657KMy?=
 =?us-ascii?Q?RbIEH1zo9I54gB+vBQDl3lLvzDfhqNZloOykSg6Y6DkY3LsqQQEkQxz7epG/?=
 =?us-ascii?Q?cRiPsLk/80A5DT1YGmYYFsu44I+kEwvL3cU3YTqM/rkQOphdmTfN37oQdZbK?=
 =?us-ascii?Q?rOTLKyZAaBFM9NiRI4bYyEz01S6HSN2S9eR3DRwI7GNi4vPWRcWbLyUDPj5g?=
 =?us-ascii?Q?damNhk3U0s5DFAR42xCgjm6bB1tR82gLLwmR2bSIygqdHVmYfC3k/Sbs4ZXy?=
 =?us-ascii?Q?5KXZT1yjK12vl995/wMUcxvkgq5dNmAVrt8VBS8UjLN4+hm9eUI+RKFTZTDk?=
 =?us-ascii?Q?cm4GembJEe/Y/h33PN/6CyQd77v3RPZm9vIA867EpF/6VQQE5UnZNONuzYBm?=
 =?us-ascii?Q?yWT8tDQAZxmn8IXIhdfbILlJBmf9X2CD?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2024 13:59:17.6133 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f50fc6d3-e15f-4913-fe7e-08dca731d0cd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00001CDD.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4184
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

Add support for SMDA to the KIQ map/unmap functions.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c | 85 +++++++++++++++++++++-----
 drivers/gpu/drm/amd/amdgpu/nvd.h       |  2 +
 2 files changed, 73 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
index 4ce13a4f7a20..32c0cc52861c 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -3693,25 +3693,58 @@ static void gfx10_kiq_map_queues(struct amdgpu_ring *kiq_ring,
 {
 	uint64_t mqd_addr = amdgpu_bo_gpu_offset(ring->mqd_obj);
 	uint64_t wptr_addr = ring->wptr_gpu_addr;
-	uint32_t eng_sel = 0;
+	uint32_t eng_sel, ext_eng_sel;
 
-	switch (ring->funcs->type) {
-	case AMDGPU_RING_TYPE_COMPUTE:
-		eng_sel = 0;
-		break;
-	case AMDGPU_RING_TYPE_GFX:
-		eng_sel = 4;
-		break;
-	case AMDGPU_RING_TYPE_MES:
-		eng_sel = 5;
-		break;
-	default:
-		WARN_ON(1);
+	if (amdgpu_ip_version(kiq_ring->adev, GC_HWIP, 0) < IP_VERSION(10, 3, 0)) {
+		ext_eng_sel = 0;
+		switch (ring->funcs->type) {
+		case AMDGPU_RING_TYPE_COMPUTE:
+			eng_sel = 0;
+			break;
+		case AMDGPU_RING_TYPE_GFX:
+			eng_sel = 4;
+			break;
+		case AMDGPU_RING_TYPE_MES:
+			eng_sel = 5;
+			break;
+		case AMDGPU_RING_TYPE_SDMA:
+			eng_sel = 2 + ring->me;
+			break;
+		default:
+			eng_sel = 0;
+			WARN_ON(1);
+			break;
+		}
+	} else {
+		switch (ring->funcs->type) {
+		case AMDGPU_RING_TYPE_COMPUTE:
+			ext_eng_sel = 0;
+			eng_sel = 0;
+			break;
+		case AMDGPU_RING_TYPE_GFX:
+			ext_eng_sel = 0;
+			eng_sel = 4;
+			break;
+		case AMDGPU_RING_TYPE_MES:
+			ext_eng_sel = 0;
+			eng_sel = 5;
+			break;
+		case AMDGPU_RING_TYPE_SDMA:
+			ext_eng_sel = 1;
+			eng_sel = ring->me;
+			break;
+		default:
+			eng_sel = 0;
+			ext_eng_sel = 0;
+			WARN_ON(1);
+			break;
+		}
 	}
 
 	amdgpu_ring_write(kiq_ring, PACKET3(PACKET3_MAP_QUEUES, 5));
 	/* Q_sel:0, vmid:0, vidmem: 1, engine:0, num_Q:1*/
 	amdgpu_ring_write(kiq_ring, /* Q_sel: 0, vmid: 0, engine: 0, num_Q: 1 */
+			  PACKET3_MAP_QUEUES_EXTENDED_ENGINE_SEL(ext_eng_sel) |
 			  PACKET3_MAP_QUEUES_QUEUE_SEL(0) | /* Queue_Sel */
 			  PACKET3_MAP_QUEUES_VMID(0) | /* VMID */
 			  PACKET3_MAP_QUEUES_QUEUE(ring->queue) |
@@ -3733,11 +3766,35 @@ static void gfx10_kiq_unmap_queues(struct amdgpu_ring *kiq_ring,
 				   enum amdgpu_unmap_queues_action action,
 				   u64 gpu_addr, u64 seq)
 {
-	uint32_t eng_sel = ring->funcs->type == AMDGPU_RING_TYPE_GFX ? 4 : 0;
+	uint32_t eng_sel, ext_eng_sel;
+
+	if (amdgpu_ip_version(kiq_ring->adev, GC_HWIP, 0) < IP_VERSION(10, 3, 0)) {
+		ext_eng_sel = 0;
+		if (ring->funcs->type == AMDGPU_RING_TYPE_GFX)
+			eng_sel = 4;
+		else if (ring->funcs->type == AMDGPU_RING_TYPE_COMPUTE)
+			eng_sel = 0;
+		else
+			/* SDMA */
+			eng_sel = 2 + ring->me;
+	} else {
+		if (ring->funcs->type == AMDGPU_RING_TYPE_GFX) {
+			ext_eng_sel = 0;
+			eng_sel = 4;
+		} else if (ring->funcs->type == AMDGPU_RING_TYPE_COMPUTE) {
+			ext_eng_sel = 0;
+			eng_sel = 0;
+		} else {
+			/* SDMA */
+			ext_eng_sel = 1;
+			eng_sel = ring->me;
+		}
+	}
 
 	amdgpu_ring_write(kiq_ring, PACKET3(PACKET3_UNMAP_QUEUES, 4));
 	amdgpu_ring_write(kiq_ring, /* Q_sel: 0, vmid: 0, engine: 0, num_Q: 1 */
 			  PACKET3_UNMAP_QUEUES_ACTION(action) |
+			  PACKET3_UNMAP_QUEUES_EXTENDED_ENGINE_SEL(ext_eng_sel) |
 			  PACKET3_UNMAP_QUEUES_QUEUE_SEL(0) |
 			  PACKET3_UNMAP_QUEUES_ENGINE_SEL(eng_sel) |
 			  PACKET3_UNMAP_QUEUES_NUM_QUEUES(1));
diff --git a/drivers/gpu/drm/amd/amdgpu/nvd.h b/drivers/gpu/drm/amd/amdgpu/nvd.h
index 631dafb92299..e0fd205cdd3b 100644
--- a/drivers/gpu/drm/amd/amdgpu/nvd.h
+++ b/drivers/gpu/drm/amd/amdgpu/nvd.h
@@ -400,6 +400,7 @@
  * 7. WPTR_ADDR_HI [31:0]
  */
 /* CONTROL */
+#              define PACKET3_MAP_QUEUES_EXTENDED_ENGINE_SEL(x) ((x) << 2)
 #              define PACKET3_MAP_QUEUES_QUEUE_SEL(x)       ((x) << 4)
 #              define PACKET3_MAP_QUEUES_VMID(x)            ((x) << 8)
 #              define PACKET3_MAP_QUEUES_QUEUE(x)           ((x) << 13)
@@ -427,6 +428,7 @@
 		 * 2 - DISABLE_PROCESS_QUEUES
 		 * 3 - PREEMPT_QUEUES_NO_UNMAP
 		 */
+#              define PACKET3_UNMAP_QUEUES_EXTENDED_ENGINE_SEL(x) ((x) << 2)
 #              define PACKET3_UNMAP_QUEUES_QUEUE_SEL(x)        ((x) << 4)
 #              define PACKET3_UNMAP_QUEUES_ENGINE_SEL(x)       ((x) << 26)
 #              define PACKET3_UNMAP_QUEUES_NUM_QUEUES(x)       ((x) << 29)
-- 
2.45.2

