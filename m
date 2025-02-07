Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A44ABC02192
	for <amd-gfx@archiver.kernel.org>; Fri,  7 Feb 2025 09:16:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2B4F110EA83;
	Fri,  7 Feb 2025 09:16:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="VLmCwI6o";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2047.outbound.protection.outlook.com [40.107.236.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 916A510EA82
 for <amd-gfx@lists.freedesktop.org>; Fri,  7 Feb 2025 09:16:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=L3ziDZEt1V2O3hU92hJoKCtOyH8KsRNURHXWySRgLZAdVkZFeH95d6+xXyNWz5UOjroaMbfA/l2edBbFqMShS0Z5K1RJMjFIjTzycs9dpCrLKiEeXYhq1jTp9HUdbkUD0+R7I4Ih9gPsVq8wH1BA+HKeUswtRg1p4UTPLng5kSNEyyPDSrDWLkCFXTswsw0GZMveOniBb0XCPVQe9HWZxeoxmMitairCIT6k30pmbxuZ0hzJ6vrMQ3iLMysrYp2enyEOuoOp4HseZ/YEmaygIlXCuapG90NJHN14qZ9sxg7oyPZKvrE6HR8zaIEvhc1lrA05j4zJTNtkzpftvnFsXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+yJu+y0OCIKk5hD6TENmuyh1GByFcdEhci4BXD50PQA=;
 b=ift3jPlXDiNIwYLUUID49cg0BkLVeLZmbr7ET0vyzeIysvv8WXzitsNMtbpkY7a6/YYl+UGjs2AEZfG/YSlD03es1n65DUedXmM1a2AqNuUs5pismh1YcrdW20kHKcduThxqqafCL9YTmTQYmgGr1zhxiM8IMQ0Mqj72Gckt/y+LrE0Zm8zdHLV7UkwdbZdiCrQBfyUG5035W2Xs5VRUfgs9Ly+0GooWlS755jpmGbUQf6oWvF4IJpItixNFZxCnN4RjN2B1fzFiCaNpiMJwTHAiHrJSAU6pRSdnV5v72Czx0sX7xrORDNplvi3RFFUdw02nsf2TNrCCxwy1Lue96A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+yJu+y0OCIKk5hD6TENmuyh1GByFcdEhci4BXD50PQA=;
 b=VLmCwI6oYjdxP2Ku0pcV2NTll284KwkL6cZQ76OvPPHUIJcIJUDOCY85+I2gnThLdXCVfY6tx+T1xJ9wKG3GuTdF/bLqWDGDUI1gOB7gfdtWbNPCcQmC4tNObz1bX3jZvj8XnURM0oIS3g24NrjWXWwKze1PXszITBIJr9bTgLc=
Received: from CH2PR08CA0021.namprd08.prod.outlook.com (2603:10b6:610:5a::31)
 by IA0PR12MB7700.namprd12.prod.outlook.com (2603:10b6:208:430::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.12; Fri, 7 Feb
 2025 09:16:04 +0000
Received: from CH2PEPF0000009B.namprd02.prod.outlook.com
 (2603:10b6:610:5a:cafe::e2) by CH2PR08CA0021.outlook.office365.com
 (2603:10b6:610:5a::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.25 via Frontend Transport; Fri,
 7 Feb 2025 09:16:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH2PEPF0000009B.mail.protection.outlook.com (10.167.244.23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8398.14 via Frontend Transport; Fri, 7 Feb 2025 09:16:03 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 7 Feb 2025 03:16:00 -0600
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>, lin cao <lin.cao@amd.com>, Jingwen Chen
 <Jingwen.Chen2@amd.com>, Shaoyun Liu <shaoyun.liu@amd.com>
Subject: [PATCH] drm/amdgpu/mes: Add cleaner shader fence address handling in
 MES for GFX11
Date: Fri, 7 Feb 2025 14:45:48 +0530
Message-ID: <20250207091548.1096804-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000009B:EE_|IA0PR12MB7700:EE_
X-MS-Office365-Filtering-Correlation-Id: 07d98993-4079-4dc5-e38b-08dd47580be0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SG9MTys4ZndpeExUWUQ0VzhzMDFYSU85SWR6eXJsWlBKcUEvb1dxYngzVTJh?=
 =?utf-8?B?ODdOdEsybWFNRzM3VkVGWm9HUmozR2JJS0RYdFl5TTZSMGRsek5NZ3h4cUR4?=
 =?utf-8?B?bnlKRnlmVEk4ck9EemUxRkNuNEEzM0YvQlhPcEMveUVEdk9xc1lod0JMeC9N?=
 =?utf-8?B?bE02MDdjbHY2UEVzQVdYdnh0UVk4cHc0dk14ZG1SNmp5TUIxc2pkdzZvNDM1?=
 =?utf-8?B?VzlrODZmOStJLytZcnRtSk9sRzN2SnREOUpLdUxVSnVvMDJnVTVHNzcvWkpR?=
 =?utf-8?B?aEovZU55NnBjOFAwZjRqQThZampjVGhNT2ZTS1dOMW5XVDh2OVp5SFJNQlZj?=
 =?utf-8?B?bDBBWllYUXJwci83TjZPcHh5Z1BIaCtjMmhGMkNSb0tLOTJNdzhRQnFUS29a?=
 =?utf-8?B?SFlBZnRrMTF2WGVvcnhmVWlCVG1GZmt3UHVuRlJQSzRYWldkZkxtdFVKeFZM?=
 =?utf-8?B?SkhxdVRmR25ON2RNNFFNbFVzNG9FbmUyNUJCak5IZTlYd290WTZBS2xraFR5?=
 =?utf-8?B?b0VmaXk4SWltNUNYZDd1djVsL3dNcDRITUxFL1dxdlhaSjM4LzkxMVFzb3Bk?=
 =?utf-8?B?UCt6RThMbVZtWmw0QlBPL0c0QlJxTkw4YTAwOVAwbHFoL1dpUVNSai9EQ3hI?=
 =?utf-8?B?bmg4eGxuTjltakkzS05NMVdPTzVid0JzU3o2SVBPWUlaakU1QWt1NEwyRkMr?=
 =?utf-8?B?Z2owQjNlNDFoamRRbVFRMDFuR3dXVXg3N1U2Z210RzJEOUQyVzlYUDU5ZHlr?=
 =?utf-8?B?WW02V1RmamJ2TEtVcEVCY1p0QzVlQ2RIT2xVUzB1QVBEaUVvUXpEaTRuaUgr?=
 =?utf-8?B?MkRkRlZmV3lQSlo3ckhlaHEwUnRjY09HRkhjSEc2WjA0dTh2ZkpONmh1YnNr?=
 =?utf-8?B?R1EwSHNMQXlvcnlFOGVNbGdwQ2ZzSTJsZCtYa3pBcjZSMHFyK1RDajRQRnlE?=
 =?utf-8?B?eDZuOW9CWm9uUzZqeDFEYWZZaDRXWlpKV3hzYm9GcmlrVjJ4OXQ1bHRUWVFp?=
 =?utf-8?B?cUdMc3ZtQnpGOU9BWDRTekk3OE9ycFIvdDdwSjRDT3pjc0hKK1B3bng1SmJG?=
 =?utf-8?B?czJIdmVXZXIyclZldWZPazdYSDlqL21Pdk1SSmdOS0ZUWUhnY2EyczNCRS9q?=
 =?utf-8?B?elVqSUZidUEyQ25NQWNWQ2VnTnlJVGF5VFlpQW5Tc2pnQVZnV0xaRmZRcWEw?=
 =?utf-8?B?QlJmQ1AvWG5VNy9YbVZ3Z3VhM3NWUks1M09YTEk0eU5OWWlqQ0VITVNxd1Rn?=
 =?utf-8?B?WWp2c3JoeE1rTmVEVWJUTGE4TDJYNTlZeWRjTUVsemY5T1VSOVdPUzF1SmhZ?=
 =?utf-8?B?aGl5cE5SK3pKK00vMllMT0NsaEJhUkJpbDBNendaN3JJN3VlYnFHYU5WUHhT?=
 =?utf-8?B?OFdnY09OVW9VRzhYb1BrUEFvTm1BdUx4SjRxcFVqbnhIRmxqOEVZempYdUQz?=
 =?utf-8?B?Tmtwbzd2TnlaQ045MG01UGZHY3g5Qkx5LzVRUUtiTENKdkpjSjhWL3dYL3pJ?=
 =?utf-8?B?QmZUaFpQZjkxUVdzT1BHL0RJNkc2b3dvQXRzdzRFUWtpalk0Z2VsVEIrK0Mx?=
 =?utf-8?B?WjBJZGhuLzJkNTFQYTJDTmNFWjNGUEp5STVzS0tPVFhDRmVwTUp4bmg3Y3Np?=
 =?utf-8?B?SENqOFN4cFJPODNFVTdhQ3lTTTZLQ295eHFzN0VoQ0JPZDVRNmpnbnlKMXAv?=
 =?utf-8?B?dkNQeHA4WUoyZlJ2eHZNSW1NZ2Q4NnVzNTNYU1B5RFVaSmUrajR6TU85em50?=
 =?utf-8?B?b1MrTEhXM1FmUm9yZXJSekw0VE0yNnYzOUtlbHFlZkp4cmdCVHFPeTVrMVpL?=
 =?utf-8?B?QlZGNitqZkxURGtiRTJkeGVHZHRJeW1LSkR1NjNKbWZ5UFpFTzR6S2owOTJZ?=
 =?utf-8?B?MjZzMlBKR01GMlNFMVpCQmVxbEg3bHpsQ1d2VStyUDN2Zlc3em1PL1pNK1Jh?=
 =?utf-8?B?MlRaM24xUnBHM3o1dXJuQlRLNkZ0dlhjRnZ4V0EyczJkaSswQXEvVGNPZmgr?=
 =?utf-8?Q?zqeqiKGje2vi7DTTU40jAjjT9plTKw=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2025 09:16:03.7679 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 07d98993-4079-4dc5-e38b-08dd47580be0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF0000009B.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7700
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
 drivers/gpu/drm/amd/amdgpu/mes_v11_0.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
index bf51f3dcc130..d8e992c4adeb 100644
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
-- 
2.34.1

