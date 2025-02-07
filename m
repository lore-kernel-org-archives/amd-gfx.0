Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4AC1EC02196
	for <amd-gfx@archiver.kernel.org>; Fri,  7 Feb 2025 10:11:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BD0DA10EAA1;
	Fri,  7 Feb 2025 10:11:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ZlltHxG4";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2066.outbound.protection.outlook.com [40.107.244.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 24EB010EA92
 for <amd-gfx@lists.freedesktop.org>; Fri,  7 Feb 2025 10:09:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iRQrEd8p9qv08wQOQ+Urr/BqeaDazl7Vl5TKANOiFF/a4KBvYbcOJdDuaWMauU6uZ980wbjnqxAT8k0dlAhoI8vvBh8i6BH/oNuvO8x1rHcVxGeVWMbCOV9fURIjloArjxN9hn+eCpSZR9CpsJjy9vVWuXMG7bh7YFQ5UZLB6WjnIwV6MWc5TU2rvZZfj0UCXEzgn/mAvQq5gVdZs2/y58g6WEkNPI0noRep01+/gNoLdc4jx7hOoOJM94TSnRLIRDxZ9LSCH31FM1hep2+AcQd7AGnTDiJalX/eIwsDeSkrUT0BpSSi273Yy+kqYWoWMsFdPBh06SGnu5S9KOkDBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oGmilf8z8ifz2SwYMHQ5zZ7vMWXMp7ni9nstbokD1ps=;
 b=YlS3+PypGuUA18p+DVkPIhlqx07haK/9PxesYTt7TIr+b+ul8cKj/ouvKMXqRzHbjCEX+ebt+RRvy8vPOCBtUciLsJYN6JIMA6sGjBlKMhvWwRxkXV1lwFX7fjEOHtj6dN6irDxP1hQbLU6RQxYlC+ewbFe8J2cUPcwPoALwnYmG1jUesPdg8xToKAK9gO0IGl4P3jeSoEnD/yac0p8KSyJY3dc/jrHKgiJfkEI2H6dy2TyIoftu+puiiMUSdIdcKYpNC6oYE15lzHY87f2DM3cD0yYPehG/lXFL2izKdI4auhuM8Z5ovkISn8X6plkTNx7wvCdG2Z9CXYnpDm/t7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oGmilf8z8ifz2SwYMHQ5zZ7vMWXMp7ni9nstbokD1ps=;
 b=ZlltHxG4ncWHPmpTrURaMFMjH33yuoozEhXwy/ySfBAJ6DYB3mzwKTXitIdF/Uqci4pUrqoMUqKr405Drq1Tb0+c3bzvvmKRtNSCxwROpcg0gPmaIchm+j77inSUIwqGa8LlhoHN3a1pajReoJ8QUjcFKATHnP1eRfBEn1JAmyc=
Received: from BYAPR04CA0001.namprd04.prod.outlook.com (2603:10b6:a03:40::14)
 by CH3PR12MB8258.namprd12.prod.outlook.com (2603:10b6:610:128::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.11; Fri, 7 Feb
 2025 10:09:22 +0000
Received: from SJ5PEPF000001EF.namprd05.prod.outlook.com
 (2603:10b6:a03:40:cafe::b5) by BYAPR04CA0001.outlook.office365.com
 (2603:10b6:a03:40::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.29 via Frontend Transport; Fri,
 7 Feb 2025 10:09:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF000001EF.mail.protection.outlook.com (10.167.242.203) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8398.14 via Frontend Transport; Fri, 7 Feb 2025 10:09:21 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 7 Feb 2025 04:09:18 -0600
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>, lin cao <lin.cao@amd.com>, Jingwen Chen
 <Jingwen.Chen2@amd.com>, Shaoyun Liu <shaoyun.liu@amd.com>
Subject: [PATCH v3] drm/amdgpu/mes: Add cleaner shader fence address handling
 in MES for GFX11
Date: Fri, 7 Feb 2025 15:39:00 +0530
Message-ID: <20250207100900.1115660-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001EF:EE_|CH3PR12MB8258:EE_
X-MS-Office365-Filtering-Correlation-Id: f0cd68b3-81ab-46ff-4145-08dd475f7e27
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VWJyY2N4UEdqcHZCdG12VCtSVmN4SE1GTytCZm9sUmxWeDllanJ3YTZteUUv?=
 =?utf-8?B?TkJNK2xQbWpBSExQN3l1Njd6dUZRVmcwYlpRRHdER1FpaUdSTHZlcGpMeVRE?=
 =?utf-8?B?cVF5UysrWTlwaVU4dXJ6MHk3ZFp4N2l0Smd3SnVtZHdTVXBzZ2x5ZnZkSXl0?=
 =?utf-8?B?ODA2RDVQU0F0ck1Pa3Vsc05GZVBZKzg3OER4T1M1MlpLck5LbnJsTFMrY0VK?=
 =?utf-8?B?OGpNTXBKSW9WUDlnbU9iSkxYbDBGcEtRN0RoaEVYcElLaWtTZlV0VGN1R1dw?=
 =?utf-8?B?djhpVng4ajBFNjJNS1VOU29kWVRFR2JwRjkzOVdVcHVOaWhPSG1XTW44UzRk?=
 =?utf-8?B?blp4aFFaOHljNzJZdlhQME9Qd3UxUDlvcEM0akNJYllTR0xvRStBV2NqN3Bq?=
 =?utf-8?B?eUhZQnVOVUQvUXhLYmMzK3kwT01LT25DeHc2ZGdVUlBUck43YkJmZkVlR2F1?=
 =?utf-8?B?TUkya2wxYkhKK2NabmE3VUVoWjNiN1pOVW9Kalo1WFIzMDJGSFhjblVVQVk5?=
 =?utf-8?B?bk0xWitydm1vbnJEL29yNzdFTDk3eWVRN0d1UENSc0hXNUhEQlVrbDVDSU8x?=
 =?utf-8?B?cVpCRVdVVDRpaXplaVNlZjZwbEFubEN1RjRPWlU0ekpsTC9nQUR3NTE0eU9w?=
 =?utf-8?B?a3JLMlVoQktTRDRRU2Zjbjd6aDI0VnlKRy9lWHovVFQ1M20vdkhuVlpFeitN?=
 =?utf-8?B?VS9LUnlBS25TcnhuOGNNU1NZTDZQUmovQ0RlVCt2THpoSG1yZFZvNml5WWx3?=
 =?utf-8?B?R0VjTjR1YkRkVEIzLzFtc01ac3FOMlFIQXFsbkZuSHJMTlRNT2JPMU5ZQmF2?=
 =?utf-8?B?NGQxeitIZm1tQTlhNHFaU1FFeDREMTZMQ2hIckxKajY3cVFFcWowRVlkSzlO?=
 =?utf-8?B?b3NvWXZJb05IdHluRDBPb0FERGVKUjVWM2ZCdTFoY3RUYWZ1QlAxY00xc1JQ?=
 =?utf-8?B?TSsyVTNsaU9DdjlGS3NtWkhiTjhqYjVIVXVVdEplRUFxU1d4U3pSaFFVeTNo?=
 =?utf-8?B?dkJaV0ZKREZtNGdlbWNwOUQrME1wc2puWXhDSEtTeEVpUk5LbEFnUXh3YlRG?=
 =?utf-8?B?RU9BcW5ZUVhCTjlmc2l0dEM5aTdNVm9kNE02UzVKZ3BlSkFGckZiOVlieVUv?=
 =?utf-8?B?WTZ1bkRmM29iNG9pK0F5UFEydGhnNVpRWFROUEtSZG1oam1rMXdtQmtpU1pZ?=
 =?utf-8?B?YUlWcVV3OW5PNVlFVmtQQTZKMkl2ZkU0QmxVb2l0dCs4NDN4MWFKZi9GZ01z?=
 =?utf-8?B?d2M0SkhFMVJsNWdaTytCYnVyU1pNVXR4UHFmcy9iZEVGTTJwK3ExWGdtZExh?=
 =?utf-8?B?YUlCQ25zN1pKeFRDUlc0bHFJajZ4TFY5QkdpeEN0a1k2NVQwTEw1VWhKd05K?=
 =?utf-8?B?eDlBbEt0bU5kbU44am5CODZjbElhSzJPeUtwVzdFcy9ZRU5RWW9ScENNemVu?=
 =?utf-8?B?azNIWjFMNlJxU1ZpL1ZwcFJSMWVDSHIwZUxjWXEvUWtINURDb0JYVGlVRGlD?=
 =?utf-8?B?V3hHZE5DSnl6L1NXUDJZdElkWmp6STVCWWRDeWlxTVlmcjZQbStySHZkZGpX?=
 =?utf-8?B?MzNMUlJBTDN5YlFLNDJwMmlVNmFxR1Z5Uks1U1FxZDl5akdHbE02aFQ5SURa?=
 =?utf-8?B?eG43MlJRZTh6VklMN1BnUzNSRlFHSVU5QWxRNWprY1E3SWlSbG5PZkVzKytD?=
 =?utf-8?B?OFljeWxKUFJjblFvbkJWeTZoV0k4c1ZVczVpNS9UeUlqc0h6RFE0QWI3NEpC?=
 =?utf-8?B?alIyMWMxVjh4VlQwZ2VmTjF4S2ZnekVIWld5RXBoVGl3cHVRSEFGQXZxazls?=
 =?utf-8?B?UEoweDVXS2xLeERnT0VER0hWbXRGUU9ReElldFdIT3o1TVhDWlZleUZteWJp?=
 =?utf-8?B?MkVaZTJTaGtXbnRwN2MvVE9iUmZJK09EZE5ONXc2LytFMlJuNjRjczdhNGFh?=
 =?utf-8?B?VGpuclRMRVlqVDFlMTk1andJRXdYU2hrWU5iVmtLY3VwT3Bzc1VGbEJLbG44?=
 =?utf-8?B?U1dJd1dkY0ZBPT0=?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2025 10:09:21.8883 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f0cd68b3-81ab-46ff-4145-08dd475f7e27
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001EF.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8258
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

v3: amdgpu_device_wb_free(adev, cleaner_fence_offset); to release the WB
    entry and prevent memory leaks. (Kevin)

 drivers/gpu/drm/amd/amdgpu/mes_v11_0.c | 37 +++++++++++++++++---------
 1 file changed, 24 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
index bf51f3dcc130..ad849ff2fa7a 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
@@ -745,14 +745,21 @@ static int mes_v11_0_set_hw_resources_1(struct amdgpu_mes *mes)
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
+
 	mes_set_hw_res_pkt.header.type = MES_API_TYPE_SCHEDULER;
 	mes_set_hw_res_pkt.header.opcode = MES_SCH_API_SET_HW_RSRC_1;
 	mes_set_hw_res_pkt.header.dwsize = API_FRAME_SIZE_IN_DWORDS;
 	mes_set_hw_res_pkt.enable_mes_info_ctx = 1;
+	mes_set_hw_res_pkt.cleaner_shader_fence_mc_addr = adev->wb.gpu_addr +
+							  (cleaner_fence_offset * 4);
 
 	ret = amdgpu_bo_create_kernel(adev, size, PAGE_SIZE,
 				AMDGPU_GEM_DOMAIN_VRAM,
@@ -766,9 +773,16 @@ static int mes_v11_0_set_hw_resources_1(struct amdgpu_mes *mes)
 
 	mes_set_hw_res_pkt.mes_info_ctx_mc_addr = mes->resource_1_gpu_addr;
 	mes_set_hw_res_pkt.mes_info_ctx_size = mes->resource_1->tbo.base.size;
-	return mes_v11_0_submit_pkt_and_poll_completion(mes,
-			&mes_set_hw_res_pkt, sizeof(mes_set_hw_res_pkt),
-			offsetof(union MESAPI_SET_HW_RESOURCES_1, api_status));
+
+	ret = mes_v11_0_submit_pkt_and_poll_completion(mes,
+						       &mes_set_hw_res_pkt,
+						       sizeof(mes_set_hw_res_pkt),
+						       offsetof(union MESAPI_SET_HW_RESOURCES_1,
+								api_status));
+
+	amdgpu_device_wb_free(adev, cleaner_fence_offset);
+
+	return ret;
 }
 
 static int mes_v11_0_reset_legacy_queue(struct amdgpu_mes *mes,
@@ -1632,12 +1646,10 @@ static int mes_v11_0_hw_init(struct amdgpu_ip_block *ip_block)
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
@@ -1665,10 +1677,9 @@ static int mes_v11_0_hw_init(struct amdgpu_ip_block *ip_block)
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

