Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE5BEC0219C
	for <amd-gfx@archiver.kernel.org>; Fri,  7 Feb 2025 14:44:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 96FBA10EB27;
	Fri,  7 Feb 2025 14:44:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="BEBoUTPC";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2086.outbound.protection.outlook.com [40.107.223.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1AEBE10EB29
 for <amd-gfx@lists.freedesktop.org>; Fri,  7 Feb 2025 14:44:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NgbOgVdGvHYZ6PtvlVfZjBDbi7I8Xah5ZpKy20SU4zeRFXRvqiVza8SQDC5PlMvx/7Ng02GSzZt87zrGL3B1IcZfpNfrb1FJnMm5+k7UW2XJglpCy3QMa0xIze7enwDzFhGXYXtF2MVWHrhdJzSJFhqevhrc1Q7zQA9Ugrtj+QFl4f8MVaG1TwzoJYKR16SFwjrAF5BRVNZ7pZbsZOFdBuriRZmv1vSMExcML910TQrLI5c8dai+aiSeZoYDjLckzskSRDcbrf4M4IDM66sSbq+dTVgd1XFUw4C8gKkKpAnr3W0SlC8UJsFbyj0p76ChZGv3mKo5aj9e9KiRu+kxig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oyPqPsRcWCPEPlsVPFfyRLCXJqgDBZF81H2tQuqke9k=;
 b=jz4s0LVh1s5tQ9qj2zrYUD6Mj9lwFaZ0+pz35md3bnj1ztie5Cnd241J62FMI6bfprvt5ge3J9JGB40z7E+4WHJvyf9RwQX1DSREyazFlNgDSKF5mRBfBGx81a+qnqhvDQwS//Bi6frPUzV/GIBJksAzjLtJZgwP53CYLPew0Wuq+ix8s6dGe7fBrNcb1eMYifP0au+myhGZAWHmwbrJei/v7A2juSfioP1PVH5ZUqNXelGFbbS1AlyU92R1PhO64BCaMhKdt8fyyXJecG2n4qpVbCLtIKqMnLba/gJHRG5nYFsP4etzX9ZurqjW8Yp6Jk9mqRCGY3cShI0Zbi1Ktg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oyPqPsRcWCPEPlsVPFfyRLCXJqgDBZF81H2tQuqke9k=;
 b=BEBoUTPCVuRkntLtHdmPtJ5VNnzIfHb4bOIryqhRYsUlHxYenohOhaeZVQks/8v8O9ti8eekwaxz8+SkqysaV8pwTVlTbLuUYMMdJn11L11+l9P9VOBuvPp2hH9u44kEfZyFqV2ZlSGxwLkn3rUBi10YqeaC8aJ5qMT38a5CZ9Q=
Received: from PH0PR07CA0069.namprd07.prod.outlook.com (2603:10b6:510:f::14)
 by SA1PR12MB6846.namprd12.prod.outlook.com (2603:10b6:806:25d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.15; Fri, 7 Feb
 2025 14:44:09 +0000
Received: from SJ1PEPF000026C7.namprd04.prod.outlook.com
 (2603:10b6:510:f:cafe::8) by PH0PR07CA0069.outlook.office365.com
 (2603:10b6:510:f::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.24 via Frontend Transport; Fri,
 7 Feb 2025 14:44:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF000026C7.mail.protection.outlook.com (10.167.244.104) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8398.14 via Frontend Transport; Fri, 7 Feb 2025 14:44:09 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 7 Feb
 2025 08:44:07 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>, lin cao
 <lin.cao@amd.com>, Jingwen Chen <Jingwen.Chen2@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, Alex Deucher
 <alexander.deucher@amd.com>, Shaoyun Liu <shaoyun.liu@amd.com>
Subject: [PATCH V3 2/2] drm/amdgpu/mes: Add cleaner shader fence address
 handling in MES for GFX11
Date: Fri, 7 Feb 2025 09:43:52 -0500
Message-ID: <20250207144352.920100-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250207144352.920100-1-alexander.deucher@amd.com>
References: <20250207144352.920100-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000026C7:EE_|SA1PR12MB6846:EE_
X-MS-Office365-Filtering-Correlation-Id: 58292c44-152f-488b-2771-08dd4785e144
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TU45bUhOZFRXejJaTnBUZHZTZitQVW9QRUI4MTFVWEFqSm1aL0NLLzRqbmxq?=
 =?utf-8?B?ZnNPODEybW1QQU1reDJ5RUNRVlBrcGdvVnVCdUp2aXI3dWNLZHpSeFE2bjBu?=
 =?utf-8?B?cVRWbUJBVWx2N0ZJSXlkYkU4ZnhEYkI2cDFzUnRpMnhSMVJCaWN5czIwdnZp?=
 =?utf-8?B?SnVUVjRjL1V2cHhHVDBqWUo1dldrZkNJUlJhRlZ6dlZ2aHg4WjB5UjJ1NkQ5?=
 =?utf-8?B?bmh0V1BwZC9paEZIZCtlRDRhaVAvWXhvRnl1bmdEN25jNFUrZVA3di9Zd2ps?=
 =?utf-8?B?d01pVyswRG5nMUNxcGVtaFJBbGowWmJ4bnFTb1FidTB0VkFpRzZGM1dPbTJx?=
 =?utf-8?B?bmM0Q1VUYjBOVnVzT1B0QkFWSVNTQXZpWnlUanU3UEFWOCtiUVd1UGRTdDcr?=
 =?utf-8?B?b29nSjVGWmNQSjBKRlh1UDFiZ0VVL0diaHk1Um5CeUJDankvUnY3MUdoTERN?=
 =?utf-8?B?NGk3NDdOYlIxc0pnUUYzS1ZCWitUemI4bDE0MnJVUm84ZFVOMEVzWGw5VkZu?=
 =?utf-8?B?M09IbGFjWjAwenlVVlhJTEdFSGZQMXhiWjBNeGc5Q2NteFlPQktraUtXNmcz?=
 =?utf-8?B?OWpxWFBwWms4dTMvSEhFWFcwQW9PMFNHR21rWWhaK2llY3RNNTRaYzltTEVW?=
 =?utf-8?B?OVZ2TEVpZWZYRW5uSHZobUN6RmZWaU8yanpkUHVaVXhDRkVFUVVnVDVWMG5u?=
 =?utf-8?B?MnMvMGozclhUZEtxWXJ3L1VhMUxicGIzcndZc3NJR1Z3VnhhS0gxbkVZcWRX?=
 =?utf-8?B?MDZnNXFlQ3BISlFHcUg0alEzK0poQXh1azlxdkVyb01jVHVpNjNScGFEb0FS?=
 =?utf-8?B?akUzdWxjU01hSXpMMGJZWFpoSVF2NVhUUDlJMHlKTkpQSWVCczU5Y0F4VWxV?=
 =?utf-8?B?Q0Z5RUtpZUxiWDhKTUhXdXFDUk85WXM1U3ZPTHFQTGF0cHpaQjRJRC9WeTdH?=
 =?utf-8?B?TWU4Rm9Sc296OTltTDA1RE9SajhLNDc1a1RVS2RzblNxd3orSnlSZHlGR081?=
 =?utf-8?B?OE1jRlNHUUp1TkVJN0Mra3J3NTRITGtFQXh2WkZzaWE4TVh1eXUxU3NVd3o1?=
 =?utf-8?B?U2oxa1ZzajhYbDY0Y0FTczNQWnRQcjlZRjB6SEFSOWNrZmh3WDIvYVBvbjIv?=
 =?utf-8?B?WDV3QnJJeXQvb1pmVmZSUjFrZkRXN0t1djRXRXVNYk9BcU1kUW9WSFpPOUx0?=
 =?utf-8?B?RkFTek5zUUdRZHZUSjE4Z3FkNzhvamNvbUVqOStUY1pOdW81Ym1hTG11NytV?=
 =?utf-8?B?VUc0Y2VUclVNcFA4N0ZSVzZqZ2lKekxodE1xdnl0YkVQZHRlVktFalBUdDY0?=
 =?utf-8?B?emFSRmtqVkxRSHhQN29zSVlPU3daa3RyNVdJdjNQc1N3ZEZaZUdtSXZUNVRr?=
 =?utf-8?B?dWpvNCtUeUM3d1VKWk1MU0JaYyt4alV1RGhIclBvQlZzSndyRVRLY3dheld6?=
 =?utf-8?B?L2dFZGl6RkxrQnNFZnl2L1ZPNm8yQk5ETXc2em9ZU21DVlQrMThjYXlldXJI?=
 =?utf-8?B?ZjNYd2Q5ODEyUUpqM1lEVUFpU0tNUDdCYmxaVFlRaXpxSlVaU3ZWaWpJYlBm?=
 =?utf-8?B?Q2RzVGJhTXVhbFZKV0prbHQxVzc4SXBhbnZqYkROaTNsTXc1SlY2RnBjRTdD?=
 =?utf-8?B?SnpaVkFJaHdkenNBcHVpNEFFU3MwVlpvbzlOWFUwRjk4SUJuS2lVTXRaV3Az?=
 =?utf-8?B?VjY2anlvdUVFeHI3VGRBZHJ5ZUZRaWd0TjFMbGIvdXBITUxWc0VLNHp1VDB1?=
 =?utf-8?B?RjBFT1hhcjkzdkZqR3A5S01ZUXYvbk5xZkRkRlVXTytqd2c0dUFZaXc2QUxP?=
 =?utf-8?B?cUlLYllpUXpJNzNOKytMUEVQczhTbGpTTzNyNGNGcVhiaHNlZkZHTUxDeEIw?=
 =?utf-8?B?ZCtmcUk0MkRmOVcwVHRTUzcxZjUvY01PN0wyaCtoWE05MjAySFFNdUtBR2Ji?=
 =?utf-8?B?TXlCUVAyN2ZMYXRsUEtVdzFDQVE2eU42Yi9zbnhmR3Z3K25URVI5dUhjdmha?=
 =?utf-8?Q?CUSkOUcC0gSnHvc4J0xuhed20SHw4E=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2025 14:44:09.0321 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 58292c44-152f-488b-2771-08dd4785e144
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000026C7.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6846
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

From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>

This commit introduces enhancements to the handling of the cleaner
shader fence in the AMDGPU MES driver:

- The MES (Microcode Execution Scheduler) now sends a PM4 packet to the
  KIQ (Kernel Interface Queue) to request the cleaner shader, ensuring
  that requests are handled in a controlled manner and avoiding the
  race conditions.
- The CP (Compute Processor) firmware has been updated to use a private
  bus for accessing specific registers, avoiding unnecessary operations
  that could lead to issues in VF (Virtual Function) mode.
- The cleaner shader fence memory address is now set correctly in the
  `mes_set_hw_res_pkt` structure, allowing for proper synchronization of
  the cleaner shader execution. This is done by calculating the address
  using the write-back memory base address and the cleaner fence offset.

Cc: lin cao <lin.cao@amd.com>
Cc: Jingwen Chen <Jingwen.Chen2@amd.com>
Cc: Christian König <christian.koenig@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Suggested-by: Shaoyun Liu <shaoyun.liu@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/mes_v11_0.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
index e862a3febe2b2..e22d0ee6d8a3a 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
@@ -754,7 +754,7 @@ static int mes_v11_0_set_hw_resources_1(struct amdgpu_mes *mes)
 	mes_set_hw_res_pkt.header.dwsize = API_FRAME_SIZE_IN_DWORDS;
 	mes_set_hw_res_pkt.enable_mes_info_ctx = 1;
 
-	ret = amdgpu_bo_create_kernel(adev, size, PAGE_SIZE,
+	ret = amdgpu_bo_create_kernel(adev, size + AMDGPU_GPU_PAGE_SIZE, PAGE_SIZE,
 				AMDGPU_GEM_DOMAIN_VRAM,
 				&mes->resource_1,
 				&mes->resource_1_gpu_addr,
@@ -765,7 +765,10 @@ static int mes_v11_0_set_hw_resources_1(struct amdgpu_mes *mes)
 	}
 
 	mes_set_hw_res_pkt.mes_info_ctx_mc_addr = mes->resource_1_gpu_addr;
-	mes_set_hw_res_pkt.mes_info_ctx_size = mes->resource_1->tbo.base.size;
+	mes_set_hw_res_pkt.mes_info_ctx_size = size;
+	mes_set_hw_res_pkt.cleaner_shader_fence_mc_addr =
+		mes->resource_1_gpu_addr + size;
+
 	return mes_v11_0_submit_pkt_and_poll_completion(mes,
 			&mes_set_hw_res_pkt, sizeof(mes_set_hw_res_pkt),
 			offsetof(union MESAPI_SET_HW_RESOURCES_1, api_status));
@@ -1632,12 +1635,10 @@ static int mes_v11_0_hw_init(struct amdgpu_ip_block *ip_block)
 	if (r)
 		goto failure;
 
-	if (amdgpu_sriov_is_mes_info_enable(adev)) {
-		r = mes_v11_0_set_hw_resources_1(&adev->mes);
-		if (r) {
-			DRM_ERROR("failed mes_v11_0_set_hw_resources_1, r=%d\n", r);
-			goto failure;
-		}
+	r = mes_v11_0_set_hw_resources_1(&adev->mes);
+	if (r) {
+		DRM_ERROR("failed mes_v11_0_set_hw_resources_1, r=%d\n", r);
+		goto failure;
 	}
 
 	r = mes_v11_0_query_sched_status(&adev->mes);
@@ -1665,10 +1666,9 @@ static int mes_v11_0_hw_init(struct amdgpu_ip_block *ip_block)
 static int mes_v11_0_hw_fini(struct amdgpu_ip_block *ip_block)
 {
 	struct amdgpu_device *adev = ip_block->adev;
-	if (amdgpu_sriov_is_mes_info_enable(adev)) {
-		amdgpu_bo_free_kernel(&adev->mes.resource_1, &adev->mes.resource_1_gpu_addr,
-					&adev->mes.resource_1_addr);
-	}
+
+	amdgpu_bo_free_kernel(&adev->mes.resource_1, &adev->mes.resource_1_gpu_addr,
+			      &adev->mes.resource_1_addr);
 	return 0;
 }
 
-- 
2.48.1

