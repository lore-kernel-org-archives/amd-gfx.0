Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4EF77C02192
	for <amd-gfx@archiver.kernel.org>; Fri,  7 Feb 2025 09:36:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CA12A10EA81;
	Fri,  7 Feb 2025 09:36:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="K7CfyjtN";
	dkim-atps=neutral
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2040.outbound.protection.outlook.com [40.107.100.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2C96910EA87
 for <amd-gfx@lists.freedesktop.org>; Fri,  7 Feb 2025 09:30:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=V5wIaXTQYJ7eNhFXRoerx5/Ktr3KG/IpNWm3MLpljMWuxbLa+DZH7cSV34WbpLbnlsl0V+6AkZNTnHV+jqAML3HqWFJVbPerfyrvnYZI6OTqx30xoUwP3IuiHl0SB6PNd5syMR2D1dXY51hSMCLXhayIlvvYU641Z04mNOVcCdDOQlcigl2VgXZ37iczhzOiZzAFiYQ9uTLkSCZvLEZtdXjAgJwqx+okLmktMUeSklP+/M76pF7Df79+3o2usfvJK+N/y8tIyPnxTnXZzWGCmJLv4KilrvbLGsHuyb44wI9nn2oiNKuyRe126P+nLVh54HbUwofyFWsXCCN4ANPe2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7s7MeZ1DUAIqQbZyjVeFBGnRce/OnHQ+pHCg7zipHjs=;
 b=Uowuv9WfESoONR8VNyEd9BuOdo2Je3H2s4+kFdGhf9Ebuj7Wip6KZG/t9iAhZ/E+ptZfT2DwUX+uYhL1Q89GUddXz7chs5OlZNcL07U+RNaPGQRg/wNm9JGstDVOXUirlVNOq2R3TSmO25/swEVxvaOQTU4f82XFVfeGfEw8FLQlGQ7qjOzho8p9N7OtkURA8csb0UFxCoVzhFdr5FC+V+fRV5/dWnms1fFdDmc+a60dP9VZ1pLZ9x6LeNXXZXdwH59KdLJZmLNHhQXRCcpbQt6tmr+7FB8FamoAueB+rUlq9O44PHGxxVF/bojbq/Y7i88IG+H+vUwy20Zvp4D5MA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7s7MeZ1DUAIqQbZyjVeFBGnRce/OnHQ+pHCg7zipHjs=;
 b=K7CfyjtNh8VEQjZntLIdI8AdPsRcsja2y6jP3egicD0kt4r6/WLcJXkuGGzmhkxr8jnSSBwt7Jw+6ukJ0Q35iDw0bJSIR+infCpWXnrUAMTNPZ9hO/BloyYfkfuAHAFRe8jLM8il/KC2kG09ShXq+C/D5/CgN9GGkczG0AcbIZc=
Received: from SJ0PR13CA0049.namprd13.prod.outlook.com (2603:10b6:a03:2c2::24)
 by CH3PR12MB7668.namprd12.prod.outlook.com (2603:10b6:610:14d::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.10; Fri, 7 Feb
 2025 09:30:22 +0000
Received: from MWH0EPF000971E3.namprd02.prod.outlook.com
 (2603:10b6:a03:2c2:cafe::ec) by SJ0PR13CA0049.outlook.office365.com
 (2603:10b6:a03:2c2::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.24 via Frontend Transport; Fri,
 7 Feb 2025 09:30:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000971E3.mail.protection.outlook.com (10.167.243.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8398.14 via Frontend Transport; Fri, 7 Feb 2025 09:30:20 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 7 Feb 2025 03:30:17 -0600
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>, lin cao <lin.cao@amd.com>, Jingwen Chen
 <Jingwen.Chen2@amd.com>, Shaoyun Liu <shaoyun.liu@amd.com>
Subject: [PATCH v2] drm/amdgpu/mes: Add cleaner shader fence address handling
 in MES for GFX11
Date: Fri, 7 Feb 2025 15:00:03 +0530
Message-ID: <20250207093003.1098454-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E3:EE_|CH3PR12MB7668:EE_
X-MS-Office365-Filtering-Correlation-Id: dcbae299-a706-42b1-2364-08dd475a0ab1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZTlTcVMxSmJ2QTJ6RGFXbGszWGFhTktsK2NLTlo3Yk1uTmhXZmNkemxEQ29l?=
 =?utf-8?B?RGdRTjd2UnZDY01VUjFZWVFncDRSUDRkZ2d6ckI0a2h1VWVoWWVXWjU3OS9D?=
 =?utf-8?B?cmRLMWVRYTVGUmxOemowTDBXdWhHM29mNWpDZTQwSkNIMFVqT0huUmV5Smxk?=
 =?utf-8?B?Yy9jb1Y3ckFsV2dndnhSRThmV3c5NjNLZGJWTFRXbFdQa0VaQUtZWDlldU1Z?=
 =?utf-8?B?R1VKVkdlVGJaSXBOVzFZY2c3a2xtellVSnBJTFJINmM1Z0RRQW1VTERQMVVH?=
 =?utf-8?B?K0tPcndjaHV6eUkzYStmdTU1MEpjT285eVg3UE0wZVZhNVFSbHZmRkF0Y1BF?=
 =?utf-8?B?UWpoaGMvbjJVZ0VMTUtGSDNSemNCd0hLeDJvRXplbFdiNktHVkpJbEVyOWtF?=
 =?utf-8?B?aHA4OFpEc0hlaHdkM1JiRWNKbzU3QjBPU1JxQ3F6ZVlDUHd4QkhMZHgraXBz?=
 =?utf-8?B?cUJVd0F4ZDBjN2hyN3VyTWhTLzBqZVY3Zms3SE5YWkhyRFAvSXhlQ0JxdTho?=
 =?utf-8?B?R2JVZ3lXbE5qT3ZQUHg3b3NkU080T3ZjWVQweVJOeVkwaFFKOTVPNXdFU0hX?=
 =?utf-8?B?T3ZrbW1ldjJ4RzNLWnpTTktHWlp2d1JyQlpYOGg3S21HVWt1c2diQXM2TFBv?=
 =?utf-8?B?b21TbHFPZ2FFVlBTRE5vVUoxSlF0M3NMMWEreUhlbExzS3NqQlhvRUZwSWx5?=
 =?utf-8?B?ZTlZL2Rrdk9yek83N1crRXZvRXdrNjdkUys5NHNkK0FyYUJpdzZ3Z1FGRC9V?=
 =?utf-8?B?b285dXFrQkU2TmxEMm5qbzJCalZIZmVSOTVicXdWQzF3blRrdWp0NVVFUENj?=
 =?utf-8?B?OHkxbFk5RDd6L1RJNEdRb2J6bnIyNUFyVGZTRHRveU9BVC9Naitrd3BEL0pG?=
 =?utf-8?B?YmZmT2o4c1o3bDJVR01vMkNJT29yL0Jib01hczFmZ29GcTM1V090RUdIbE1H?=
 =?utf-8?B?TkRuQ3MvNmlucTNlTUpRcUxUaGpnNkFFa0s4R2wyL1FGMVJldFhHZGZJQ0Va?=
 =?utf-8?B?ZzdldWVQaUoreE0vT2srQkJJaWg1WTN6YVlYMHNJcnVoS2EvS0lNM20xOTFF?=
 =?utf-8?B?VVE5U2FiQkx1NkJWazVPTXp1bHV6OWhXaGRLR1JseVNSd3I4N29tQ3JPOG16?=
 =?utf-8?B?dVJDdElEd0ZLeVFWNlJEOU8wZC9tcE5NZ1VKRzdoU0ZPeUhWVHVpRjRaSkd1?=
 =?utf-8?B?VEN3ZXdDbzExQ1dZcVA4bTBIeHJOYmUyZ25qV0p4M3hsTi9sOTN5TEdwVFJI?=
 =?utf-8?B?REtGT2UzUWlzaWFvcVphcy9UUENhNE9QOWNMUVJoYmRvaWgyZXEzV2lMKzYr?=
 =?utf-8?B?ZnRmYmFvY1BIMHJoUWNTR1d2b3NNek5JTU1lQ3I2OWtKK2lqU0FWbEpVZitx?=
 =?utf-8?B?WHI2eDc4aFFEdnVjTFdPdVVrV1gxUGptMjRwdVpTTXVmc1ljQnVpZlloU2FK?=
 =?utf-8?B?UE4rWWRCL0NSVEJ2RGtSeEFWQlhZb2JuUHVzU01iV0o3TjB0QnQwM1AxTWRq?=
 =?utf-8?B?Q3gwejRRZng3SjhjQzBBV1ltMldzMVlMVUFyN2xaWjJ0VXlob1RnWVlOK3dM?=
 =?utf-8?B?c1F2dHlsNTJaY2ZBSklzVTNKMmxqaTJKRVkxWlV6UmJVZnZzSXdhb0c1WmVG?=
 =?utf-8?B?b3E0WWFMem40b2lOVk5RaDRJblhJeTlTTmdxQmNRZHJRbHlmYlJsUTZQa1ZP?=
 =?utf-8?B?MFVrcWZpVUFJMkJSUjk5emRhWm5MVnhBOVdmd0V2QTdMUnhNZjgvWkp1RW9w?=
 =?utf-8?B?SGJUWTdqb0lESGpOMWU1ZW1Gb0RQcTFESDBtZGZWd1F0ZUludmNGZXhaU2d1?=
 =?utf-8?B?dEh6WmJ0MGtqWnVEakg4VnJ0T3hQZnhZVGF4bGtZbmVqUG1kNDVGSFdpb3N0?=
 =?utf-8?B?UmpPa29ubDNUeTF6a1RiNWNZaVQ5bzRyK1ZVY2Z0TVBJaWNNc1dnUEMzZ3JD?=
 =?utf-8?B?bUo0Q2JOemdER0liOVk5NEI1T0k4bkEyS0FBOVI0N1BwOVQwbXZYNEFvZ2Jz?=
 =?utf-8?Q?ojN/ZSqMOzhD2cew3bS9/n4qYPP1sw=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2025 09:30:20.6925 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dcbae299-a706-42b1-2364-08dd475a0ab1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000971E3.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7668
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

- **Memory Offset Retrieval**: The line `ret =
  amdgpu_device_wb_get(adev, &cleaner_fence_offset);` retrieves the
  offset for the cleaner shader fence from the write-back (WB) memory.
  This is important for ensuring that the cleaner shader can synchronize
  its execution properly, as the offset is necessary to calculate the
  exact memory address where the fence will be located.

- **Setting Cleaner Shader Fence Address**: The line
  `mes_set_hw_res_pkt.cleaner_shader_fence_mc_addr = adev->wb.gpu_addr +
  (cleaner_fence_offset * 4);` sets the memory address for the cleaner
  shader fence in the `mes_set_hw_res_pkt` structure. This address is
  calculated by adding the base GPU address of the write-back memory to
  the calculated offset. By setting this address, the MES (Microcode
  Execution Scheduler) knows where to check for synchronization related
  to the cleaner shader, ensuring that it operates correctly and that
  the GPU is in a stable state before executing new tasks.

Cc: lin cao <lin.cao@amd.com>
Cc: Jingwen Chen <Jingwen.Chen2@amd.com>
Cc: Christian König <christian.koenig@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Suggested-by: Shaoyun Liu <shaoyun.liu@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
v2: The checks for amdgpu_sriov_is_mes_info_enable were removed to
    simplify the resource management logic in the MES initialization and
    finalization functions, ensuring that the necessary resources are always
    set up and cleaned up regardless of the SRIOV mode, thereby enhancing
    consistency in cleaner shader operations.

 drivers/gpu/drm/amd/amdgpu/mes_v11_0.c | 23 +++++++++++++----------
 1 file changed, 13 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
index bf51f3dcc130..2462c9cd5f6c 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
@@ -745,14 +745,20 @@ static int mes_v11_0_set_hw_resources_1(struct amdgpu_mes *mes)
 {
 	int size = 128 * PAGE_SIZE;
 	int ret = 0;
+	u32 cleaner_fence_offset;
 	struct amdgpu_device *adev = mes->adev;
 	union MESAPI_SET_HW_RESOURCES_1 mes_set_hw_res_pkt;
 	memset(&mes_set_hw_res_pkt, 0, sizeof(mes_set_hw_res_pkt));
 
+	ret = amdgpu_device_wb_get(adev, &cleaner_fence_offset);
+	if (ret)
+		return ret;
 	mes_set_hw_res_pkt.header.type = MES_API_TYPE_SCHEDULER;
 	mes_set_hw_res_pkt.header.opcode = MES_SCH_API_SET_HW_RSRC_1;
 	mes_set_hw_res_pkt.header.dwsize = API_FRAME_SIZE_IN_DWORDS;
 	mes_set_hw_res_pkt.enable_mes_info_ctx = 1;
+	mes_set_hw_res_pkt.cleaner_shader_fence_mc_addr = adev->wb.gpu_addr +
+							  (cleaner_fence_offset * 4);
 
 	ret = amdgpu_bo_create_kernel(adev, size, PAGE_SIZE,
 				AMDGPU_GEM_DOMAIN_VRAM,
@@ -1632,12 +1638,10 @@ static int mes_v11_0_hw_init(struct amdgpu_ip_block *ip_block)
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
@@ -1665,10 +1669,9 @@ static int mes_v11_0_hw_init(struct amdgpu_ip_block *ip_block)
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
2.34.1

