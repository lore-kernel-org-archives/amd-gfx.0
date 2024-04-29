Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 915AFC4345F
	for <amd-gfx@archiver.kernel.org>; Mon, 29 Apr 2024 06:44:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0321B10F286;
	Mon, 29 Apr 2024 06:44:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="roKLLcpi";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2073.outbound.protection.outlook.com [40.107.243.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 88B9C10F286
 for <amd-gfx@lists.freedesktop.org>; Mon, 29 Apr 2024 06:44:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JX4NFGErNZOdzxqsdCo/Nrp62SHcMCyIb/ArRG0Ut31if0tFskZ78J2X776FtxFbGRiyd6T4qXa65GlhZqvwwawb7/xYJPiCR8F+aGg5aPZWlRh5q/FB1R7z+frbI0i0gS907XTson2t+5n2JbvAtLmaPy6feXuM2V0OYDgWdv1bGLv+g9oD/lim8oNIVMbGi/lN3KgdED01O/JLXPmYa+lixyrJn9VlQ0yUk6xi+ATE+siLPxtR5xKbehbAbwzw3dTzpAjST/tdnklqtxl7OU4+/yqmGC3+PFpRB7n+5sl8fY/GpofMqkWQk+ZoBMlCuOmpi4K1p00dGMK1qS9mYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tup+vITgTOZPPB1XO/fVVsirYXApi/AsKz641aik2J0=;
 b=I1HRP+8yonRkaEwDytJFjk7o72ajzr/jdKev3wobP8gfWcxJ0s6FFs0g5TeA9pqZSjePxTa0/tY+bbxRJnfKIzq+3ybbzcwLzqMiibOgkJ2YhUZN7Ebiv8Q3BnzSy4bFbf4uZY7hFXALdxU7lER7974JtauCJpP5mZXipYFj5ZcjsPFjaO7POxTqnHbW4hOoO+qhs8dxMVDMyh+4nmbENrGIZEspy8BPCKx+BFjMJOVMsyOprkWbO/d95fHfDCeQeIEhYEfAEu7GUtYmaaa7veR2GdRKyVSwe7lva4bsq2rJwn00iRpqkvjd1SFjkBuqHyKSuQWj4lGXqzxpFJZSLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tup+vITgTOZPPB1XO/fVVsirYXApi/AsKz641aik2J0=;
 b=roKLLcpijno9p5+kR3oiqqCOQ1Mnyx8nkzU54J+5mlFvyIiOSALG1CYXDnCnGY4y8SHXaSd/FXk4jtK3Y++zongODD13056xD2HYqbTdEJ8b+Wlpp93BSfe/zXp1STfzNnEXsYqQgWLJcF50rWianKz6m1+9pp3zqt5OUMEMU70=
Received: from CH0PR07CA0027.namprd07.prod.outlook.com (2603:10b6:610:32::32)
 by SN7PR12MB7021.namprd12.prod.outlook.com (2603:10b6:806:262::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.34; Mon, 29 Apr
 2024 06:44:28 +0000
Received: from CH1PEPF0000AD81.namprd04.prod.outlook.com
 (2603:10b6:610:32:cafe::57) by CH0PR07CA0027.outlook.office365.com
 (2603:10b6:610:32::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.34 via Frontend
 Transport; Mon, 29 Apr 2024 06:44:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH1PEPF0000AD81.mail.protection.outlook.com (10.167.244.89) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7452.22 via Frontend Transport; Mon, 29 Apr 2024 06:44:27 +0000
Received: from amd-X570-AORUS-ELITE.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 29 Apr 2024 01:44:26 -0500
From: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <christian.koenig@amd.com>, <alexander.deucher@amd.com>, "Arunpravin
 Paneer Selvam" <Arunpravin.PaneerSelvam@amd.com>
Subject: [PATCH v9 2/5] drm/amdgpu: Add mqd support for the fence address
Date: Mon, 29 Apr 2024 12:13:48 +0530
Message-ID: <20240429064351.626929-2-Arunpravin.PaneerSelvam@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240429064351.626929-1-Arunpravin.PaneerSelvam@amd.com>
References: <20240429064351.626929-1-Arunpravin.PaneerSelvam@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD81:EE_|SN7PR12MB7021:EE_
X-MS-Office365-Filtering-Correlation-Id: 830bfd9b-3611-48f0-77f5-08dc6817d0f9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|376005|1800799015|82310400014|36860700004; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bkZObTdITEg5Wlkwa3FxaUpXL2liWGttOXhZTGNmYTdpRHdYTDd2K3ByK1JO?=
 =?utf-8?B?SDU0T0d3WFUrdkZISU5xdkUzQnZncmdqc21NQmpoZ0F1TjBuZklpQ0RVTGtn?=
 =?utf-8?B?TXMwTG8veHdTWXVPUFlNZnRlcThuN2tyMlJDRTRTWjNucSt0YU56Um9adzI5?=
 =?utf-8?B?Zy80VnZTUjR1NlkvM1NDME5kbWNjUzJzRGYrdS9idE5RczVPQS9RVEVQS25Z?=
 =?utf-8?B?Q3pPMlJPQmxERnJxaHpVaGREWTlEUERYZTE2YU9ZRW0yeG5IdXRoWlRGb21q?=
 =?utf-8?B?Y0pjU09BWVVkZWdRbjIxaDk3ajU2NGNhbjNSc2hIRWk2RmxiMXowc0JUNlJ1?=
 =?utf-8?B?NVVLRHd5dHJ1bWpGV0lVRFlNSHJsSDNmaFA2VkNERklRTGIreStNajE3Rnov?=
 =?utf-8?B?NTRaWkJWS1JxU0w5M2FWcnowdkhxNndCUmljV2xKK3hqc3VBUTk1WkNaWmdn?=
 =?utf-8?B?Sy9DM0ljYjdPYUNYVHJFUGNNakdrYlRNMEJ3YWh3Vm9tYVI2YWFSNklGb0Ex?=
 =?utf-8?B?ekhaaWhBQlkzZmFLV3FTRzQ1eXJGekdnV0VhN2hHbzFxR25RclJVVXBPOUEy?=
 =?utf-8?B?SGdUOEpsOFJMSDYwNkhYRzZieXJLL3BLMGFLUFQvMTQrUU1zVWpiUlBZY2lG?=
 =?utf-8?B?alZBdzB1WllsTFV6cmVGVWZweEswd093NnJsZytZYWdqN1RMN3RUdXFwU3R0?=
 =?utf-8?B?NlRVOTVrRm5YdnpWNXlFMlZBZ2VUdGdxUzhmbFhCOWtDcU1TeTlFZDdhSVBo?=
 =?utf-8?B?TVoydldwZ3RhWDZkWnhyYy9qa2JJMEtQV1JXekZXeGc2ai9Gc0EvUGo4N1NI?=
 =?utf-8?B?REhRbEZCTlZKZXBrNG8yeGI0MngxK0V6bkJGbmFvWnpXU3o3QnJGWCtnNy81?=
 =?utf-8?B?T1Vzd1ovSFJrS0tFeGRIZkNmNFFVY0hVb1htZUQ2dDdqd01oOFFnbW9sZ0hV?=
 =?utf-8?B?TU94WFVtVDdScG1RWWw3UGs3R1hjSS9qcHRrTUJ5OW5ibWpLdFpEN0VQWVVj?=
 =?utf-8?B?cFdDTjBzUFBwWmpsT21BUWVPWjIzcVZJUTVLeit3OHBDd3l1ZGVOTlFzMDhr?=
 =?utf-8?B?cWpvaHhmS1RJMUVnQng0Ukl5ZFF2enVndkR1enRYSGkyUkN3V0hRTDhhTEdx?=
 =?utf-8?B?RGdqc0hVc1N3SDJtbS84Qm9YSCs2THNEcDFYTHhvbllPeDNWbTJoamx0c082?=
 =?utf-8?B?N3lIQ2Y3bnQyZ21XOG00UThScjk0VU43RVczQWRwV3k0aUttRzB2dGI3U090?=
 =?utf-8?B?Q3p0OVp3dFJheWRyamRlTEM5ZXQ4cCtzYjI1MWwxSmdGbVdyeVBBL0RsN3RN?=
 =?utf-8?B?UkhDeGs0SlNPaDZLeExpK3d0QnVHRnRseUtRV0lLRjdBK3hsQkVRNi90T0hH?=
 =?utf-8?B?b1dnZzJZSERBUWdWenJCMHVjU3VyRWprU0I2dmVuTmxWMElndzdHMjVNRUJm?=
 =?utf-8?B?UzBLQjFBLzVJZlEwOUYzdUIrMXFJaXM1V3U0bDZ3MGd3OTdnWHRRYlBKM3NE?=
 =?utf-8?B?V3ZPVUpUTDlBaEoyK0hjY29oOHdDMXBYZ2IvQk5NbjJIK3RBVGVQWklvbXFZ?=
 =?utf-8?B?ekNIMXVEbE9uWjRrdE5TL21UR3JIdW0relhkZzdub3ZNaHdDcmttNWVYMGpQ?=
 =?utf-8?B?SWpGeXVVWjZaSERtcnlQTkphMzA5amQvQUZVdmVRV0F2cVgwSG5LMlprYzR5?=
 =?utf-8?B?ZE5KUUNvcHQxMGwxamttZ0gwcE8va1FreHJyRlUwc2NISkNYdTZObVNIM2VS?=
 =?utf-8?B?SCtnN0ZaNWNSRENub1h6SllGTE9aWHVIT0tpazN6WnJDYytXTFVKUVhZUWdo?=
 =?utf-8?B?cW1ySkJPdnNLaHZ4K1BQZXhuVlo2NWljMkJ3RGhEaUJ6TXVXSiswSXM3UjBv?=
 =?utf-8?Q?DBQ67WTgYTYc/?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(376005)(1800799015)(82310400014)(36860700004); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2024 06:44:27.8689 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 830bfd9b-3611-48f0-77f5-08dc6817d0f9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000AD81.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7021
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

- Add a field in struct v11_gfx_mqd for userqueue
  fence address.

- Assign fence gpu VA address to the userqueue mqd
  fence address fields.

v2: Remove the mask and replace with lower_32_bits (Christian)

Signed-off-by: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>
Reviewed-by: Christian König <christian.koenig@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/mes_v11_0_userqueue.c | 11 +++++++++++
 drivers/gpu/drm/amd/include/v11_structs.h        |  4 ++--
 2 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v11_0_userqueue.c b/drivers/gpu/drm/amd/amdgpu/mes_v11_0_userqueue.c
index 6369a26fb07e..d8592cfef534 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v11_0_userqueue.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v11_0_userqueue.c
@@ -25,6 +25,7 @@
 #include "v11_structs.h"
 #include "mes_v11_0.h"
 #include "amdgpu_userqueue.h"
+#include "amdgpu_userq_fence.h"
 
 #define AMDGPU_USERQ_PROC_CTX_SZ PAGE_SIZE
 #define AMDGPU_USERQ_GANG_CTX_SZ PAGE_SIZE
@@ -204,6 +205,14 @@ static int mes_v11_0_userq_create_ctx_space(struct amdgpu_userq_mgr *uq_mgr,
 	return 0;
 }
 
+static void mes_v11_0_userq_set_fence_space(struct amdgpu_usermode_queue *queue)
+{
+	struct v11_gfx_mqd *mqd = queue->mqd.cpu_ptr;
+
+	mqd->fenceaddress_lo = lower_32_bits(queue->fence_drv->gpu_addr);
+	mqd->fenceaddress_hi = upper_32_bits(queue->fence_drv->gpu_addr);
+}
+
 static int mes_v11_0_userq_mqd_create(struct amdgpu_userq_mgr *uq_mgr,
 				      struct drm_amdgpu_userq_in *args_in,
 				      struct amdgpu_usermode_queue *queue)
@@ -274,6 +283,8 @@ static int mes_v11_0_userq_mqd_create(struct amdgpu_userq_mgr *uq_mgr,
 		goto free_mqd;
 	}
 
+	mes_v11_0_userq_set_fence_space(queue);
+
 	/* FW expects WPTR BOs to be mapped into GART */
 	r = mes_v11_0_create_wptr_mapping(uq_mgr, queue, userq_props->wptr_gpu_addr);
 	if (r) {
diff --git a/drivers/gpu/drm/amd/include/v11_structs.h b/drivers/gpu/drm/amd/include/v11_structs.h
index f8008270f813..797ce6a1e56e 100644
--- a/drivers/gpu/drm/amd/include/v11_structs.h
+++ b/drivers/gpu/drm/amd/include/v11_structs.h
@@ -535,8 +535,8 @@ struct v11_gfx_mqd {
 	uint32_t reserved_507; // offset: 507  (0x1FB)
 	uint32_t reserved_508; // offset: 508  (0x1FC)
 	uint32_t reserved_509; // offset: 509  (0x1FD)
-	uint32_t reserved_510; // offset: 510  (0x1FE)
-	uint32_t reserved_511; // offset: 511  (0x1FF)
+	uint32_t fenceaddress_lo; // offset: 510  (0x1FE)
+	uint32_t fenceaddress_hi; // offset: 511  (0x1FF)
 };
 
 struct v11_sdma_mqd {
-- 
2.25.1

