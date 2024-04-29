Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FFBBC19F53
	for <amd-gfx@archiver.kernel.org>; Mon, 29 Apr 2024 15:12:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B4F7E10E9FC;
	Mon, 29 Apr 2024 15:12:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="dJeUliuW";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2079.outbound.protection.outlook.com [40.107.236.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D88DE1123E8
 for <amd-gfx@lists.freedesktop.org>; Mon, 29 Apr 2024 15:12:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bXZGjFKUNNfDb9THykbhdWvcEFfz1xblF5uGhPjPBG1WIPr//gyudlhsWeEFtA2G5flUd9f3w6l40cytR6z25s82I/3jKwt2rhUVEh3Cjt9YeZbNqqqX3vXvKciEi0N0eGA/aGCjhUT6naoyoV2pPYcwLRg9Xm9/WxSjKiITv222PDeYAkGmq5xToKlvoF2SF3mE2jGTdzkRZ0lZX8i3vNhR3B3yfQouJyawR4RCbxD56HAiIM256PE6gR+Bm5YMDj0d5x8qvAkXrFsY99ZtLNNyF/rOLqp5T30b80qYuk4SPnC/gTJ5fe/kjP9QxhjqzGxLy6SfyUwuqMTtGI+2EQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MmNknPazSUyYqwhrQDp6To5LpCgUIlZLGvh8RgAvNqo=;
 b=lUU5mclhyM5zxrWkF1eg87c2Cq6vKRFd7dT30RCDcn/cptIHaW5+VoymSYuoBRI26IDuguzbDh1CAOvaTGpycvBxhNukUsQ7k7VQisSwUAQklUHyTNevEBWzlmv68O8KNWr/RbO5oeDAEjRnn15TpcC2ke0x8T8aHWckYZ2fe6N4YOfOK5wAA698RlzBD7JcJ+xYNlkolR81bTmENh56IWk/W8kpsLw6KLk/m89dRfZDeqOWtcFqZBJXJ3MIc7tmdkAoDugUXrxgi2VcZDjLvR4RNecPvXjnNh1vgIvV4MPhJ5dJ7vREpB9INsmuZrYCZiPP93ANg1lsRUmVGuNJog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MmNknPazSUyYqwhrQDp6To5LpCgUIlZLGvh8RgAvNqo=;
 b=dJeUliuWhYN9kHkw32ouK50wIBL3kKoVA9ufdItAs6ofZ+4zb1FOhbZwwLk3tm12YRL30A4pVz9bzUZiJWJG14sE/iJQd10yVOZZqkR33CalKOv0NBPuFf8MoqfbYJe3UJLTxgmXM4J48jklJqvveR92sJYFvZ718ck2bHWgJPU=
Received: from BL1PR13CA0197.namprd13.prod.outlook.com (2603:10b6:208:2be::22)
 by CH2PR12MB4264.namprd12.prod.outlook.com (2603:10b6:610:a4::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.34; Mon, 29 Apr
 2024 15:12:41 +0000
Received: from BN3PEPF0000B078.namprd04.prod.outlook.com
 (2603:10b6:208:2be:cafe::d9) by BL1PR13CA0197.outlook.office365.com
 (2603:10b6:208:2be::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.21 via Frontend
 Transport; Mon, 29 Apr 2024 15:12:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B078.mail.protection.outlook.com (10.167.243.123) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7544.18 via Frontend Transport; Mon, 29 Apr 2024 15:12:41 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 29 Apr
 2024 10:12:38 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Jack Xiao <Jack.Xiao@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>,
 "Alex Deucher" <alexander.deucher@amd.com>
Subject: [PATCH 07/11] drm/amdgpu/mes12: add legacy setting hw resource
 interface
Date: Mon, 29 Apr 2024 11:12:15 -0400
Message-ID: <20240429151219.3466531-7-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240429151219.3466531-1-alexander.deucher@amd.com>
References: <20240429151219.3466531-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B078:EE_|CH2PR12MB4264:EE_
X-MS-Office365-Filtering-Correlation-Id: 0abda885-5c7a-458e-3efd-08dc685ed0c9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|1800799015|376005|82310400014|36860700004; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?vNi0ZIeF7tMrZKLGXQyRvLtvZ+8AtUZDoWf1YlJsf7dGWa6FmYy7f/tJL3ep?=
 =?us-ascii?Q?YSfqEY4GsHZ2E2Nm/K68nqS5t/fFs7LKF86FsND1wvnuSpFBoATQqm+qXotQ?=
 =?us-ascii?Q?ToQCqdI2Ezd42OvW4G5QTRBdrePrzy0v1I7t5wALEPsv/NfRBXiLD+OSX4kZ?=
 =?us-ascii?Q?+yQ/VTUf6PauhmXRRwvYY74kxZ0167d3srhnIZVYnRkFEivCOgsalbYbc55b?=
 =?us-ascii?Q?YVn4iE/MESaA6aWQ7ii0tHLfZN7FKd8/xU5esdFvgy8bYkmP21X/57P20HU+?=
 =?us-ascii?Q?UNPC5HuTjZ45SZdaCHtYrREdOav7GegdYvDGnBHk0ZLFiM0RNOq3ZG12qWbW?=
 =?us-ascii?Q?/0xNadlO2SeF+m1drehVVvs7WAvYpmoGai52TlgA8Z1Drk3iI6tAseSlRebt?=
 =?us-ascii?Q?t8x8Wsq9nzzznDQM4VSuUNNXLkBEjPuyAe2ddDbqAlRpX3YdS94xqmE+POgr?=
 =?us-ascii?Q?B8HKfuAh5S9bCFdpmA8kXhp6sZsnB6pJMu4Mkr/FeXJjwIa4lTWBbiQkGPMm?=
 =?us-ascii?Q?/5aG/BHXTmggBQoS5/az0wgilGMKyff4dne6NkUHTcuI5SMqjw/BCKsHr1s4?=
 =?us-ascii?Q?nm93J1ru22zCbdo9YNBgJtB6gs3A8k4Z6fOuwh3mOLtHOLsIXbAjTLQpHyJx?=
 =?us-ascii?Q?nympSbrIrJuLgvMjsbr4Y2qTqt8j/5qSqjRc0Sh2Me6s2akrc6HZhwZzn44d?=
 =?us-ascii?Q?dTkj3lZtHIXgRP+MyWkwIPJ1WaiUrdISuoPIOm/jZcl9TMW+3CPuQ4j+ImxK?=
 =?us-ascii?Q?UJTOXsHJthcosaSOWlWuvMUcMTT82EeW/rbBpHWhlI2IFvEBUND1hCekKCDH?=
 =?us-ascii?Q?1OfT7nWLWP6y+lT8u5KxAVUcdnvpQiUdNUNMArqVOG386Vongie0CxdaCjY+?=
 =?us-ascii?Q?32Gbt2n/LSVwjVvTHxHl9oRlOZxAZmIrkrd+x1GQO1L+wwBXnHpEHJpDuRc8?=
 =?us-ascii?Q?4yvJzhiXdfS+qOJMeQxNIzw4BEd7Z5uMXfksvKHNiSaOYXd9a+O0V74msRAW?=
 =?us-ascii?Q?n4Y5nI6+RA92TVCPLToo3M55C/QNMES4O9uVT45UC235CGMHdk2auZaSyiju?=
 =?us-ascii?Q?mFF01gdcPdFOhOg2aG9gXKu2HXCqIRFjfcA8xPgfD7v2/MI3FMMLWcmQNdqM?=
 =?us-ascii?Q?omtcpQjvgT8Lf1NZpnfjEC2Ko726E+GY3O+PdMseO6z1H9w1k1e9vQh1WjRL?=
 =?us-ascii?Q?o7yMwf0vnMJdL4x1dnAs6V6bJLE6G4vNPgoQyHt6f1+NxlPQO4JQPB2Frv/W?=
 =?us-ascii?Q?Fsqb70jAa3pg8wkXtmAzJT2IqCqR+FTPufzfTSKDDCI/zK1MVQojXR4zv+oS?=
 =?us-ascii?Q?CTLZ7LMyd6CpDFygUQs20EzCmvP5W+RETVM9q+JNIllyGEGHKEmAbyhOq0d6?=
 =?us-ascii?Q?YSwtolQ=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(1800799015)(376005)(82310400014)(36860700004); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2024 15:12:41.7894 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0abda885-5c7a-458e-3efd-08dc685ed0c9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B078.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4264
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

From: Jack Xiao <Jack.Xiao@amd.com>

For unified mes fw, add the legacy interface to set hardware
resources.

v2: remove warning (Alex)

Signed-off-by: Jack Xiao <Jack.Xiao@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/mes_v12_0.c        | 22 +++++++++++++++++--
 drivers/gpu/drm/amd/include/mes_v12_api_def.h | 22 +++++++++++++++++++
 2 files changed, 42 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c b/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
index cf6dea13cc955..0b67ff9c04924 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
@@ -376,6 +376,22 @@ static int mes_v12_0_misc_op(struct amdgpu_mes *mes,
 			offsetof(union MESAPI__MISC, api_status));
 }
 
+static int mes_v12_0_set_hw_resources_1(struct amdgpu_mes *mes)
+{
+	union MESAPI_SET_HW_RESOURCES_1 mes_set_hw_res_1_pkt;
+
+	memset(&mes_set_hw_res_1_pkt, 0, sizeof(mes_set_hw_res_1_pkt));
+
+	mes_set_hw_res_1_pkt.header.type = MES_API_TYPE_SCHEDULER;
+	mes_set_hw_res_1_pkt.header.opcode = MES_SCH_API_SET_HW_RSRC_1;
+	mes_set_hw_res_1_pkt.header.dwsize = API_FRAME_SIZE_IN_DWORDS;
+	mes_set_hw_res_1_pkt.mes_kiq_unmap_timeout = 100;
+
+	return mes_v12_0_submit_pkt_and_poll_completion(mes,
+			&mes_set_hw_res_1_pkt, sizeof(mes_set_hw_res_1_pkt),
+			offsetof(union MESAPI_SET_HW_RESOURCES_1, api_status));
+}
+
 static int mes_v12_0_set_hw_resources(struct amdgpu_mes *mes)
 {
 	int i;
@@ -424,7 +440,6 @@ static int mes_v12_0_set_hw_resources(struct amdgpu_mes *mes)
 	mes_set_hw_res_pkt.enable_reg_active_poll = 1;
 	mes_set_hw_res_pkt.oversubscription_timer = 50;
 
-
 	mes_set_hw_res_pkt.enable_mes_event_int_logging = 1;
 	mes_set_hw_res_pkt.event_intr_history_gpu_mc_ptr = mes->event_log_gpu_addr;
 
@@ -1043,7 +1058,7 @@ static int mes_v12_0_kiq_ring_init(struct amdgpu_device *adev)
 	ring = &adev->gfx.kiq[0].ring;
 
 	ring->me = 3;
-	ring->pipe = 1;
+	ring->pipe = adev->enable_uni_mes ? 0 : 1;
 	ring->queue = 0;
 
 	ring->adev = NULL;
@@ -1309,6 +1324,9 @@ static int mes_v12_0_hw_init(void *handle)
 	if (r)
 		goto failure;
 
+	if (adev->enable_uni_mes)
+		mes_v12_0_set_hw_resources_1(&adev->mes);
+
 	mes_v12_0_init_aggregated_doorbell(&adev->mes);
 
 	/* Enable the MES to handle doorbell ring on unmapped queue */
diff --git a/drivers/gpu/drm/amd/include/mes_v12_api_def.h b/drivers/gpu/drm/amd/include/mes_v12_api_def.h
index 81cc0a5540492..e3211daa9c2e4 100644
--- a/drivers/gpu/drm/amd/include/mes_v12_api_def.h
+++ b/drivers/gpu/drm/amd/include/mes_v12_api_def.h
@@ -62,6 +62,7 @@ enum MES_SCH_API_OPCODE {
 	MES_SCH_API_AMD_LOG			= 16,
 	MES_SCH_API_SET_SE_MODE			= 17,
 	MES_SCH_API_SET_GANG_SUBMIT		= 18,
+	MES_SCH_API_SET_HW_RSRC_1               = 19,
 
 	MES_SCH_API_MAX = 0xFF
 };
@@ -252,6 +253,27 @@ union MESAPI_SET_HW_RESOURCES {
 	uint32_t max_dwords_in_api[API_FRAME_SIZE_IN_DWORDS];
 };
 
+union MESAPI_SET_HW_RESOURCES_1 {
+	struct {
+		union MES_API_HEADER                header;
+		struct MES_API_STATUS               api_status;
+		uint64_t                            timestamp;
+		union {
+			struct {
+				uint32_t enable_mes_debug_ctx : 1;
+				uint32_t reserved : 31;
+			};
+			uint32_t uint32_all;
+		};
+		uint64_t                            mes_debug_ctx_mc_addr;
+		uint32_t                            mes_debug_ctx_size;
+		/* unit is 100ms */
+		uint32_t                            mes_kiq_unmap_timeout;
+	};
+
+	uint32_t max_dwords_in_api[API_FRAME_SIZE_IN_DWORDS];
+};
+
 union MESAPI__ADD_QUEUE {
 	struct {
 		union MES_API_HEADER	header;
-- 
2.44.0

