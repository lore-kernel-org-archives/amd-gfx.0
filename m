Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4881C25B10
	for <amd-gfx@archiver.kernel.org>; Fri, 10 May 2024 08:51:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 835B510E58B;
	Fri, 10 May 2024 08:51:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="t5kCc1qc";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2076.outbound.protection.outlook.com [40.107.244.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E0DE110E408
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 May 2024 08:51:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eUop3SA7fkyZgK6VYO+V8EiQYk3rdIBNRQXMH2H1v8EVroIJ24tdfmUph/peA4rdfRAIoC0uWiny2nQtFGlNmjQcHcFZYHkTb4INjdKGtH+rLRXbHR9O5NkOA/MA4KzFvLWtRZabstW0Ac5FuuXWPf16EavhMDiQCtKgrIjd03om5BzubW1vNMy2d000X4S/YrIgUum/UF7B5u+xDJMpQVs8W1Y5EvJsaBpokygUgxEjEhDe0ChE/PC5sO7PGpuHLNxvvjH9j9xofCV3hrXI3AVGsBhm5CCmGW1Pa8MX8UlmH5gLIX60Okp2X3XNPvX2vkxEsCf5eH59KGoz8gnJ8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tup+vITgTOZPPB1XO/fVVsirYXApi/AsKz641aik2J0=;
 b=a1hPTM5b7Mvkn+W8AwQZnNe7N0OFpTeFMTyZ18+lLQd08o27T48XIXcLmFckbkdIQRFrrMxZyJqyOn/rqR2LFLHutnZptIflk1yIH+5jpvnLEGh7Cak1hju6MGQorl1l/+T+8/PGK6aZHD9vEo4rzCbXyLCYB5nWfLwG90sg3vUfITQOpfhB3g5Ir9J1yCZB3GQXh62YtEpF4w4U076Ojwvq9M2W9RGLnPppDjqQc/Y8SwhuYfPxSwjHvTF5dfO6xxhc4ejoAsV0y35u+JjkvlcmpLEFpygAd7xmKR6VBeUSfHJBgKGAicYvAoys+VHJQ0btfYGLA+2MCHnhY+k8AQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tup+vITgTOZPPB1XO/fVVsirYXApi/AsKz641aik2J0=;
 b=t5kCc1qc2QLnRpO+UEiVe7Gl3zNz7jqcbhhqaGRd+WmV9Lq2xXLKJasbmxrCy1Ksf+fTMxaDjlt6W0rGzlHkvOrfpMOBs/CyzaPQbL9WGQWMn574/E8v/o9UNYXANlKbh31cBxsT2tbZ8KjhNmvBVlJoaQQq+yvDaFKWne6a7zA=
Received: from CH2PR12CA0016.namprd12.prod.outlook.com (2603:10b6:610:57::26)
 by MN6PR12MB8515.namprd12.prod.outlook.com (2603:10b6:208:470::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.47; Fri, 10 May
 2024 08:51:19 +0000
Received: from CH1PEPF0000AD7D.namprd04.prod.outlook.com
 (2603:10b6:610:57:cafe::b8) by CH2PR12CA0016.outlook.office365.com
 (2603:10b6:610:57::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.48 via Frontend
 Transport; Fri, 10 May 2024 08:51:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH1PEPF0000AD7D.mail.protection.outlook.com (10.167.244.86) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7452.22 via Frontend Transport; Fri, 10 May 2024 08:51:19 +0000
Received: from amd-X570-AORUS-ELITE.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 10 May 2024 03:51:17 -0500
From: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <christian.koenig@amd.com>, <alexander.deucher@amd.com>, "Arunpravin
 Paneer Selvam" <Arunpravin.PaneerSelvam@amd.com>
Subject: [PATCH v10 2/6] drm/amdgpu: Add mqd support for the fence address
Date: Fri, 10 May 2024 14:20:42 +0530
Message-ID: <20240510085046.2718-2-Arunpravin.PaneerSelvam@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240510085046.2718-1-Arunpravin.PaneerSelvam@amd.com>
References: <20240510085046.2718-1-Arunpravin.PaneerSelvam@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD7D:EE_|MN6PR12MB8515:EE_
X-MS-Office365-Filtering-Correlation-Id: 506cc351-c6a0-4f7d-3fec-08dc70ce5c78
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|36860700004|376005|82310400017|1800799015; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Snd5T3BsbmNmNDE2L3pONVFrbWxGT3hzZElCY0VHSkREQldMazh2U2pqN2kw?=
 =?utf-8?B?WTJrQnZ5R21qUTdWd2k4b29TYUprSzE0NnNtMVFFdGloRmxldzNRUWt6QkNE?=
 =?utf-8?B?Y0FNcStNQ0tRdVFudVdZVXNJSURLVTFBUEdnR3Y3bUtFYWhoY2tVcmI2Yjgz?=
 =?utf-8?B?ajcxNTdDMTVHZG83ZjJIZTBFOXB6RDAvZzczSEVRNHpFODh2ZVMvOUhLbkVO?=
 =?utf-8?B?Ritqd0NwbGtaRk8xWFJuaFhHbjc4a21HQ3lLc3ptdlFRKzZaL3VBcW5YUnNV?=
 =?utf-8?B?QmQ1Vk5zWW15Sk03bi9KNVZQb3Ezbk1TVEFYUkZtTzVvdzNoc0FWcGd0WFdM?=
 =?utf-8?B?VEwrZS9KMmF3TTdkb1hqRFRCUXRLSk52L3c4ekNaTFNlUkdoZFdVbGZCaDR4?=
 =?utf-8?B?TkZKdUczT1NJdGcycTFiWjZHNmQzRWVHRVUrb0ZWVUZnOVU2Z09QdUlJSGZC?=
 =?utf-8?B?K2VvSHhrRkpIVGVJM1pObHBZYTJ3bFJIclRaR3BLeDN4TGJaMGszRVdKOENp?=
 =?utf-8?B?RE9DTHNrM2p4YVp0bGVDQU56aTlxTGhURncvNkZJVlkzK0ZpVEtSazZsM20z?=
 =?utf-8?B?OTJPdTlPTUxOWXFoMmZnSkoyR3Zvb1JSSTV1ZG85bXNuTFU5ak9YRXZLR2ZN?=
 =?utf-8?B?YXNPT1ZlcVhlUVFmNXBTcjFmbkFRT0taNzZnRWswdUIySEFHaW1pV2dZczhr?=
 =?utf-8?B?YXhNZnNqVnE0OUxRQWc5N3FQc2JUN1lYK2hEVDRwbUtMNE5xK1BqTFl4azJC?=
 =?utf-8?B?Vnl5UTBzTmRXVFgxQkxNbEQxTU1sSzJ5SXRtY09Bc09MRmx5SnBZWElPQnc0?=
 =?utf-8?B?OVFRTzRlQ1JlbFpoMzVuOW9WZkFiWlpyR2F5UFlDOW5wN0ZFcTZyNGpFaENQ?=
 =?utf-8?B?QXp4YjVzVHJVWlhNaGtmQ3l0YURnRzc2T21Dam1wcjFhNEJQNGlvOHorMjJ0?=
 =?utf-8?B?YUZSaUlFU0l4UzFnWTBNREx0S3diNXdyMUxOWi9UWjE0ZlplUFNPaFFOd2tz?=
 =?utf-8?B?REgwN2JJZm1qWnVHL1pTNHRxcmZadnRLYzk2RXFGelBqaVpQKzlYUmRTVlQ4?=
 =?utf-8?B?UUlMdldHbCswVXRTSkY5YjVxbHFvd2Jub0FVTHFqdmREc0NXQWM0czNJU1By?=
 =?utf-8?B?bVdNQzNxT2ZJbUpHcDJFWHByMUZxMFVzZmsxbmdYcElEOFYvVVpxdTd6djFw?=
 =?utf-8?B?Mkl2K3FBVzQ0ZCt2OW00VXEramJ1c3Z0U2FDK3kwYmF5UzJnZkxEOXh1Nm1y?=
 =?utf-8?B?RVpoNHlyNUM5azk0NmF6SHpBUm5iKzZWTzd5VFNVaUJieE9lbGFsZDBzenBX?=
 =?utf-8?B?eGZsVStjWGhIblQrMUZJWGRJazFLOUxZUWNuaEdpKzJvZzd6Vi8zbDBxeGcy?=
 =?utf-8?B?N3F0U2tmV0FXdmVuRUZrZEdtYzNkTVd4K0RxbERHclY0THBBVVZWNmlLZ1ND?=
 =?utf-8?B?bGZPM211NFFzaEREUGVTV0JUTUFPLzB5ZEpnOHdPWEptQm96QzFGNHh1SlRO?=
 =?utf-8?B?ZzF1K1M3N1ZYOXordTBJTE81U0VFcERRdWoyU3E5aDJDTE9SV2ZiTTBZZFJM?=
 =?utf-8?B?NUJKNFI5RkdmdzdyeTlUa1dia1VNcnZDMnBTMWdBY0RES1RIcGJjTVJHcW1o?=
 =?utf-8?B?dTgrejROVHBvbnA4R2lrZVZ5dzIybkJQQUh1eFBaQ2gxUU1CRHU5d015MUN3?=
 =?utf-8?B?VGZYTllWNGxRb2ZJbVdMRDZtV0xDVjVXbWV5bFQ1b3dxd09sT2JxTkxHbHh4?=
 =?utf-8?B?SzJZUXZRVXhSVWp2eGh1K1lJV3d2REp6NDVxVTlxc2k3WjY4SjI5YktXb3Js?=
 =?utf-8?B?b20xMVUzdnpDbXZHWlNTcGp4NTRFdTZPSDdhMWFPcFRyRm1nMDRQOS90VzUz?=
 =?utf-8?Q?rUZFp8HXOyPp4?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(36860700004)(376005)(82310400017)(1800799015); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2024 08:51:19.6101 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 506cc351-c6a0-4f7d-3fec-08dc70ce5c78
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000AD7D.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR12MB8515
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

