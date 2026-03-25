Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D90AAFEA806
	for <amd-gfx@archiver.kernel.org>; Wed, 25 Mar 2026 04:08:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7D5C610E753;
	Wed, 25 Mar 2026 04:08:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="u3n/mLFC";
	dkim-atps=neutral
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010044.outbound.protection.outlook.com [52.101.61.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D730610E752
 for <amd-gfx@lists.freedesktop.org>; Wed, 25 Mar 2026 04:08:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=E0AHqES0s/YYna/jVLTqJsNEJAJpJcWKTD9xJBPR0Wf6MdeoQ6f5y/c12LRd/ELrC3QQKO8OSP0UyB4dBcoF3hAc+72o3f4oop9Ef885EViI66VPe/bxRUxbohxN5PkgEU+SNgBOszDXIj59IcQObfIeMo1Ea5HtISjVwkVHAc67SGvGi4OpjuB445hT5AflAxxhUWuN0ouw+vWmkdI1xkJx7eUsEEYYv7F50wo/BUieoqQe/nVSsU0P6E/nqKgCJvuMwXoeERQNNID1H9tneRgZo9b9hR1xL3mlKOJAbyj/t2Uxs5xdDxnExwCemsaJ0WVa1iF285QDjnJUWdEfKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CwyrcGyysKdfFWtfj2IJa0uedTWX2mNngic3dTWwuX0=;
 b=kx2mqT+TR+XcqtgwF5tW2ymvzWJE5m7zjJ6R4LRMQC/afLW6w9Mif4XXL9TLtwLfSuzWmiP+8TpliO/v6v8xV9J1jy2skWgPYJ80SlJciowrpyoS30Ky5ab6ybZ2Xy0YmrajYvxx9I+DN5C0DlucJEWvnB3d1APGo+1kwd1eipljzJXr1HrSpIzHUz578pnPuz919itHfckN3MByEgmkQTPb6ByhjNLtwS0di5jNJRhGtvf2HY3fOqZjGRQvQYOVbMWCOmuiCNcuGhkb3qEOVX2DkBMXUnes31rGg71DriRAfiulMv4eedrxioCjsAxsxpYALgZcodQ7aAMTl2+zDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CwyrcGyysKdfFWtfj2IJa0uedTWX2mNngic3dTWwuX0=;
 b=u3n/mLFCmaLFEIuHupW8uCjbHWcBgtSaZO5AwNg0fo9c7RIuoS/8QV7OBMzdIm0Tb8+8advOS0u/lYDLpJfISNR13kNuxXNCm8I0PuHzUT8flQYDilLTaZr3gSHviGZb4RA0jZm375cqYpa2gB72h86YenVjuuaJ9+/cZsLe5UE=
Received: from BY3PR03CA0030.namprd03.prod.outlook.com (2603:10b6:a03:39a::35)
 by IA0PR12MB8694.namprd12.prod.outlook.com (2603:10b6:208:488::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.15; Wed, 25 Mar
 2026 04:08:08 +0000
Received: from CO1PEPF000075F3.namprd03.prod.outlook.com
 (2603:10b6:a03:39a:cafe::23) by BY3PR03CA0030.outlook.office365.com
 (2603:10b6:a03:39a::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9723.31 via Frontend Transport; Wed,
 25 Mar 2026 04:08:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CO1PEPF000075F3.mail.protection.outlook.com (10.167.249.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9723.19 via Frontend Transport; Wed, 25 Mar 2026 04:08:07 +0000
Received: from gangliang-mlse-vm.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Tue, 24 Mar 2026 23:07:45 -0500
From: Gangliang Xie <ganglxie@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <tao.zhou1@amd.com>, Gangliang Xie
 <ganglxie@amd.com>
Subject: [PATCH V3] drm/amdgpu: add support to query vram info from firmware
Date: Wed, 25 Mar 2026 12:07:27 +0800
Message-ID: <20260325040727.2016678-1-ganglxie@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000075F3:EE_|IA0PR12MB8694:EE_
X-MS-Office365-Filtering-Correlation-Id: 124af201-0582-4bd0-a526-08de8a241f1d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|376014|1800799024|82310400026|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: 6d9xqcV+8DOmTZKbiLGlgFIukCw7F0ZJILNWSD9G9XoWmBo5MPNQikshTOf8+gxGmqFDRJCIwrfWf5Ly3yh0MOOa6sjNlOPIziDvpxChye/DBLhZ+n3zBw65fuyV2qroI+lbm1D+gdkyNLiZ4Shg5V5TxOxzUPQY9alnVlnc7enSmDJePR6CW5olYoYI9Xuz4wnWrlc0Av1XTYlLJJc92zBHLm6MG34wW3WIK7jWkPa91Qm76FDeMS0ESC25eND0f2NdI9HTTXmh581vLG7EIrUbGLAwv9qVIsV4Jrs1P2YgrPIyyPzjpRWMf4qhl48e37Rzhx7A3XU9iTWgu9j4zPNsWF7Pj3pvsiWIwzTqCp2P/je4VDWlw3D8E/FZASOwLc6+Nb+8jYV2UZZU/TD713m801DM7oj8FnqlWEcCkSnwZA/6/DI3gw2m2m2RV8iPF0eYErpI/RPqQrp3ueaSNkh+a1LmsGyVvCTg2y7yxpy+vyLOxT1X2vc0AnggckXxILCEDOcP6PZbebVhpVxUpJbGdo7gbNkHgk1orgwIPGis5sJrml4e1U16HbUpfODkywFR3BBUrRgRjCwlasT3/0wTW5U3OIpMN81HijApb/k/Ti9o809WFEX+QmIinxvDwBhhN/a3hQozsEdLGk8J2oD5d2KRaZTio4gHHK4Y3kunCvAGDtLbVpjTv+pP6pnT2LhCGgLzSHvjzhsitLn0pJBIfxhr2KmS8Qr/XgBxmEy7ltAoqWotngLzu0bre/vFG0sFnH/6iZcUzkzYid7z6Q==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(376014)(1800799024)(82310400026)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: ZGCmmB5rcgolCqH3O0FfV3rDCU1PT2xf01PspJSbYC2skdax0PNOMTH8kgd6qHRuF+MAS6L+iVp2X+D5w0G4Nbo3rDNJxz02jswG6YNHd6ZjETCIrEIYi2VfJLE4kNsOOYSBGy5pvtYmGLBCs9w6A1pQ1d7NqjPtcwy4vdL2KuNMeLW3uZl31G2qv4FH44R2vg75QVY4aJ8MAuOIS+Y658wLLCtXOpOF2qXm9ASRIUsMmp8Fnr/rJueDTieU1p2zIpmHL2hzv+wYskBUTU3IWk1ZMcG13m84K7aLXcEvCkKXy33zXRzFLTHbljIVPP8XmOqGclep1r73Lr8rUoEzDyC5IOGpjxc2FWT+TB7tsRDIW0cUvNIh93yse1PFxjJ/X+nL7Gtrqqex40jl9u22ili4bmajoRHGEpCG4LXaXQ+2lTDKWMZKzccavabIG0kB
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2026 04:08:07.7068 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 124af201-0582-4bd0-a526-08de8a241f1d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000075F3.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8694
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

add support to query vram info from firmware

v2: change APU vram type, add multi-aid check
v3: seperate vram info query function into 3 parts and
    call them in a helper func when requirements
    are met.

Signed-off-by: Gangliang Xie <ganglxie@amd.com>
---
 .../gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c  | 459 ++++++++++--------
 .../gpu/drm/amd/amdgpu/amdgpu_atomfirmware.h  |   4 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c       |  22 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h       |   2 +
 drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c        |   2 +-
 drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c        |   2 +-
 drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c        |   2 +-
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c         |  58 ++-
 8 files changed, 308 insertions(+), 243 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c
index 7f4751e5caaf..cd9aa5b45e94 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c
@@ -373,249 +373,280 @@ int amdgpu_atomfirmware_get_uma_carveout_info(struct amdgpu_device *adev,
 	return -ENODEV;
 }
 
-int
-amdgpu_atomfirmware_get_vram_info(struct amdgpu_device *adev,
+int amdgpu_atomfirmware_get_integrated_system_info(struct amdgpu_device *adev,
 				  int *vram_width, int *vram_type,
 				  int *vram_vendor)
 {
 	struct amdgpu_mode_info *mode_info = &adev->mode_info;
-	int index, i = 0;
+	int index;
 	u16 data_offset, size;
 	union igp_info *igp_info;
-	union vram_info *vram_info;
-	union umc_info *umc_info;
-	union vram_module *vram_module;
 	u8 frev, crev;
 	u8 mem_type;
-	u8 mem_vendor;
 	u32 mem_channel_number;
 	u32 mem_channel_width;
-	u32 module_id;
 
-	if (adev->flags & AMD_IS_APU)
-		index = get_index_into_master_table(atom_master_list_of_data_tables_v2_1,
+	index = get_index_into_master_table(atom_master_list_of_data_tables_v2_1,
 						    integratedsysteminfo);
-	else {
-		switch (amdgpu_ip_version(adev, GC_HWIP, 0)) {
-		case IP_VERSION(12, 0, 0):
-		case IP_VERSION(12, 0, 1):
-			index = get_index_into_master_table(atom_master_list_of_data_tables_v2_1, umc_info);
+	if (amdgpu_atom_parse_data_header(mode_info->atom_context,
+					  index, &size,
+					  &frev, &crev, &data_offset)) {
+		igp_info = (union igp_info *)
+			(mode_info->atom_context->bios + data_offset);
+		switch (frev) {
+		case 1:
+			switch (crev) {
+			case 11:
+			case 12:
+				mem_channel_number = igp_info->v11.umachannelnumber;
+				if (!mem_channel_number)
+					mem_channel_number = 1;
+				mem_type = igp_info->v11.memorytype;
+				if (mem_type == LpDdr5MemType)
+					mem_channel_width = 32;
+				else
+					mem_channel_width = 64;
+				if (vram_width)
+					*vram_width = mem_channel_number * mem_channel_width;
+				if (vram_type)
+					*vram_type = convert_atom_mem_type_to_vram_type(adev, mem_type);
+				break;
+			default:
+				return -EINVAL;
+			}
+			break;
+		case 2:
+			switch (crev) {
+			case 1:
+			case 2:
+				mem_channel_number = igp_info->v21.umachannelnumber;
+				if (!mem_channel_number)
+					mem_channel_number = 1;
+				mem_type = igp_info->v21.memorytype;
+				if (mem_type == LpDdr5MemType)
+					mem_channel_width = 32;
+				else
+					mem_channel_width = 64;
+				if (vram_width)
+					*vram_width = mem_channel_number * mem_channel_width;
+				if (vram_type)
+					*vram_type = convert_atom_mem_type_to_vram_type(adev, mem_type);
+				break;
+			case 3:
+				mem_channel_number = igp_info->v23.umachannelnumber;
+				if (!mem_channel_number)
+					mem_channel_number = 1;
+				mem_type = igp_info->v23.memorytype;
+				if (mem_type == LpDdr5MemType)
+					mem_channel_width = 32;
+				else
+					mem_channel_width = 64;
+				if (vram_width)
+					*vram_width = mem_channel_number * mem_channel_width;
+				if (vram_type)
+					*vram_type = convert_atom_mem_type_to_vram_type(adev, mem_type);
+				break;
+			default:
+				return -EINVAL;
+			}
 			break;
 		default:
-			index = get_index_into_master_table(atom_master_list_of_data_tables_v2_1, vram_info);
+			return -EINVAL;
 		}
+	} else {
+		return -EINVAL;
 	}
+	return 0;
+}
+
+int amdgpu_atomfirmware_get_umc_info(struct amdgpu_device *adev,
+				  int *vram_width, int *vram_type,
+				  int *vram_vendor)
+{
+	struct amdgpu_mode_info *mode_info = &adev->mode_info;
+	int index;
+	u16 data_offset, size;
+	union umc_info *umc_info;
+	u8 frev, crev;
+	u8 mem_type;
+	u8 mem_vendor;
+	u32 mem_channel_number;
+	u32 mem_channel_width;
+
+	index = get_index_into_master_table(atom_master_list_of_data_tables_v2_1, umc_info);
+
 	if (amdgpu_atom_parse_data_header(mode_info->atom_context,
 					  index, &size,
 					  &frev, &crev, &data_offset)) {
-		if (adev->flags & AMD_IS_APU) {
-			igp_info = (union igp_info *)
-				(mode_info->atom_context->bios + data_offset);
-			switch (frev) {
-			case 1:
-				switch (crev) {
-				case 11:
-				case 12:
-					mem_channel_number = igp_info->v11.umachannelnumber;
-					if (!mem_channel_number)
-						mem_channel_number = 1;
-					mem_type = igp_info->v11.memorytype;
-					if (mem_type == LpDdr5MemType)
-						mem_channel_width = 32;
-					else
-						mem_channel_width = 64;
-					if (vram_width)
-						*vram_width = mem_channel_number * mem_channel_width;
-					if (vram_type)
-						*vram_type = convert_atom_mem_type_to_vram_type(adev, mem_type);
-					break;
-				default:
-					return -EINVAL;
-				}
-				break;
-			case 2:
-				switch (crev) {
-				case 1:
-				case 2:
-					mem_channel_number = igp_info->v21.umachannelnumber;
-					if (!mem_channel_number)
-						mem_channel_number = 1;
-					mem_type = igp_info->v21.memorytype;
-					if (mem_type == LpDdr5MemType)
-						mem_channel_width = 32;
-					else
-						mem_channel_width = 64;
-					if (vram_width)
-						*vram_width = mem_channel_number * mem_channel_width;
-					if (vram_type)
-						*vram_type = convert_atom_mem_type_to_vram_type(adev, mem_type);
-					break;
-				case 3:
-					mem_channel_number = igp_info->v23.umachannelnumber;
-					if (!mem_channel_number)
-						mem_channel_number = 1;
-					mem_type = igp_info->v23.memorytype;
-					if (mem_type == LpDdr5MemType)
-						mem_channel_width = 32;
-					else
-						mem_channel_width = 64;
-					if (vram_width)
-						*vram_width = mem_channel_number * mem_channel_width;
-					if (vram_type)
-						*vram_type = convert_atom_mem_type_to_vram_type(adev, mem_type);
-					break;
-				default:
-					return -EINVAL;
-				}
+		umc_info = (union umc_info *)(mode_info->atom_context->bios + data_offset);
+
+		if (frev == 4) {
+			switch (crev) {
+			case 0:
+				mem_channel_number = le32_to_cpu(umc_info->v40.channel_num);
+				mem_type = le32_to_cpu(umc_info->v40.vram_type);
+				mem_channel_width = le32_to_cpu(umc_info->v40.channel_width);
+				mem_vendor = RREG32(adev->bios_scratch_reg_offset + 4) & 0xF;
+				if (vram_vendor)
+					*vram_vendor = mem_vendor;
+				if (vram_type)
+					*vram_type = convert_atom_mem_type_to_vram_type(adev, mem_type);
+				if (vram_width)
+					*vram_width = mem_channel_number * (1 << mem_channel_width);
 				break;
 			default:
 				return -EINVAL;
 			}
 		} else {
-			switch (amdgpu_ip_version(adev, GC_HWIP, 0)) {
-			case IP_VERSION(12, 0, 0):
-			case IP_VERSION(12, 0, 1):
-				umc_info = (union umc_info *)(mode_info->atom_context->bios + data_offset);
-
-				if (frev == 4) {
-					switch (crev) {
-					case 0:
-						mem_channel_number = le32_to_cpu(umc_info->v40.channel_num);
-						mem_type = le32_to_cpu(umc_info->v40.vram_type);
-						mem_channel_width = le32_to_cpu(umc_info->v40.channel_width);
-						mem_vendor = RREG32(adev->bios_scratch_reg_offset + 4) & 0xF;
-						if (vram_vendor)
-							*vram_vendor = mem_vendor;
-						if (vram_type)
-							*vram_type = convert_atom_mem_type_to_vram_type(adev, mem_type);
-						if (vram_width)
-							*vram_width = mem_channel_number * (1 << mem_channel_width);
-						break;
-					default:
-						return -EINVAL;
-					}
-				} else
-					return -EINVAL;
+			return -EINVAL;
+		}
+	} else {
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+int amdgpu_atomfirmware_get_vram_info(struct amdgpu_device *adev,
+				  int *vram_width, int *vram_type,
+				  int *vram_vendor)
+{
+	struct amdgpu_mode_info *mode_info = &adev->mode_info;
+	int index, i = 0;
+	u16 data_offset, size;
+	union vram_info *vram_info;
+	union vram_module *vram_module;
+	u8 frev, crev;
+	u8 mem_type;
+	u8 mem_vendor;
+	u32 mem_channel_number;
+	u32 mem_channel_width;
+	u32 module_id;
+
+	index = get_index_into_master_table(atom_master_list_of_data_tables_v2_1, vram_info);
+
+	if (amdgpu_atom_parse_data_header(mode_info->atom_context,
+					  index, &size,
+					  &frev, &crev, &data_offset)) {
+		vram_info = (union vram_info *)
+			(mode_info->atom_context->bios + data_offset);
+
+		module_id = (RREG32(adev->bios_scratch_reg_offset + 4) & 0x00ff0000) >> 16;
+		if (frev == 3) {
+			switch (crev) {
+			/* v30 */
+			case 0:
+				vram_module = (union vram_module *)vram_info->v30.vram_module;
+				mem_vendor = (vram_module->v30.dram_vendor_id) & 0xF;
+				if (vram_vendor)
+					*vram_vendor = mem_vendor;
+				mem_type = vram_info->v30.memory_type;
+				if (vram_type)
+					*vram_type = convert_atom_mem_type_to_vram_type(adev, mem_type);
+				mem_channel_number = vram_info->v30.channel_num;
+				mem_channel_width = vram_info->v30.channel_width;
+				if (vram_width)
+					*vram_width = mem_channel_number * 16;
 				break;
 			default:
-				vram_info = (union vram_info *)
-					(mode_info->atom_context->bios + data_offset);
-
-				module_id = (RREG32(adev->bios_scratch_reg_offset + 4) & 0x00ff0000) >> 16;
-				if (frev == 3) {
-					switch (crev) {
-					/* v30 */
-					case 0:
-						vram_module = (union vram_module *)vram_info->v30.vram_module;
-						mem_vendor = (vram_module->v30.dram_vendor_id) & 0xF;
-						if (vram_vendor)
-							*vram_vendor = mem_vendor;
-						mem_type = vram_info->v30.memory_type;
-						if (vram_type)
-							*vram_type = convert_atom_mem_type_to_vram_type(adev, mem_type);
-						mem_channel_number = vram_info->v30.channel_num;
-						mem_channel_width = vram_info->v30.channel_width;
-						if (vram_width)
-							*vram_width = mem_channel_number * 16;
-						break;
-					default:
-						return -EINVAL;
-					}
-				} else if (frev == 2) {
-					switch (crev) {
-					/* v23 */
-					case 3:
-						if (module_id > vram_info->v23.vram_module_num)
-							module_id = 0;
-						vram_module = (union vram_module *)vram_info->v23.vram_module;
-						while (i < module_id) {
-							vram_module = (union vram_module *)
-								((u8 *)vram_module + vram_module->v9.vram_module_size);
-							i++;
-						}
-						mem_type = vram_module->v9.memory_type;
-						if (vram_type)
-							*vram_type = convert_atom_mem_type_to_vram_type(adev, mem_type);
-						mem_channel_number = vram_module->v9.channel_num;
-						mem_channel_width = vram_module->v9.channel_width;
-						if (vram_width)
-							*vram_width = mem_channel_number * (1 << mem_channel_width);
-						mem_vendor = (vram_module->v9.vender_rev_id) & 0xF;
-						if (vram_vendor)
-							*vram_vendor = mem_vendor;
-						break;
-					/* v24 */
-					case 4:
-						if (module_id > vram_info->v24.vram_module_num)
-							module_id = 0;
-						vram_module = (union vram_module *)vram_info->v24.vram_module;
-						while (i < module_id) {
-							vram_module = (union vram_module *)
-								((u8 *)vram_module + vram_module->v10.vram_module_size);
-							i++;
-						}
-						mem_type = vram_module->v10.memory_type;
-						if (vram_type)
-							*vram_type = convert_atom_mem_type_to_vram_type(adev, mem_type);
-						mem_channel_number = vram_module->v10.channel_num;
-						mem_channel_width = vram_module->v10.channel_width;
-						if (vram_width)
-							*vram_width = mem_channel_number * (1 << mem_channel_width);
-						mem_vendor = (vram_module->v10.vender_rev_id) & 0xF;
-						if (vram_vendor)
-							*vram_vendor = mem_vendor;
-						break;
-					/* v25 */
-					case 5:
-						if (module_id > vram_info->v25.vram_module_num)
-							module_id = 0;
-						vram_module = (union vram_module *)vram_info->v25.vram_module;
-						while (i < module_id) {
-							vram_module = (union vram_module *)
-								((u8 *)vram_module + vram_module->v11.vram_module_size);
-							i++;
-						}
-						mem_type = vram_module->v11.memory_type;
-						if (vram_type)
-							*vram_type = convert_atom_mem_type_to_vram_type(adev, mem_type);
-						mem_channel_number = vram_module->v11.channel_num;
-						mem_channel_width = vram_module->v11.channel_width;
-						if (vram_width)
-							*vram_width = mem_channel_number * (1 << mem_channel_width);
-						mem_vendor = (vram_module->v11.vender_rev_id) & 0xF;
-						if (vram_vendor)
-							*vram_vendor = mem_vendor;
-						break;
-					/* v26 */
-					case 6:
-						if (module_id > vram_info->v26.vram_module_num)
-							module_id = 0;
-						vram_module = (union vram_module *)vram_info->v26.vram_module;
-						while (i < module_id) {
-							vram_module = (union vram_module *)
-								((u8 *)vram_module + vram_module->v9.vram_module_size);
-							i++;
-						}
-						mem_type = vram_module->v9.memory_type;
-						if (vram_type)
-							*vram_type = convert_atom_mem_type_to_vram_type(adev, mem_type);
-						mem_channel_number = vram_module->v9.channel_num;
-						mem_channel_width = vram_module->v9.channel_width;
-						if (vram_width)
-							*vram_width = mem_channel_number * (1 << mem_channel_width);
-						mem_vendor = (vram_module->v9.vender_rev_id) & 0xF;
-						if (vram_vendor)
-							*vram_vendor = mem_vendor;
-						break;
-					default:
-						return -EINVAL;
-					}
-				} else {
-					/* invalid frev */
-					return -EINVAL;
+				return -EINVAL;
+			}
+		} else if (frev == 2) {
+			switch (crev) {
+			/* v23 */
+			case 3:
+				if (module_id > vram_info->v23.vram_module_num)
+					module_id = 0;
+				vram_module = (union vram_module *)vram_info->v23.vram_module;
+				while (i < module_id) {
+					vram_module = (union vram_module *)
+						((u8 *)vram_module + vram_module->v9.vram_module_size);
+					i++;
 				}
+				mem_type = vram_module->v9.memory_type;
+				if (vram_type)
+					*vram_type = convert_atom_mem_type_to_vram_type(adev, mem_type);
+				mem_channel_number = vram_module->v9.channel_num;
+				mem_channel_width = vram_module->v9.channel_width;
+				if (vram_width)
+					*vram_width = mem_channel_number * (1 << mem_channel_width);
+				mem_vendor = (vram_module->v9.vender_rev_id) & 0xF;
+				if (vram_vendor)
+					*vram_vendor = mem_vendor;
+				break;
+			/* v24 */
+			case 4:
+				if (module_id > vram_info->v24.vram_module_num)
+					module_id = 0;
+				vram_module = (union vram_module *)vram_info->v24.vram_module;
+				while (i < module_id) {
+					vram_module = (union vram_module *)
+						((u8 *)vram_module + vram_module->v10.vram_module_size);
+					i++;
+				}
+				mem_type = vram_module->v10.memory_type;
+				if (vram_type)
+					*vram_type = convert_atom_mem_type_to_vram_type(adev, mem_type);
+				mem_channel_number = vram_module->v10.channel_num;
+				mem_channel_width = vram_module->v10.channel_width;
+				if (vram_width)
+					*vram_width = mem_channel_number * (1 << mem_channel_width);
+				mem_vendor = (vram_module->v10.vender_rev_id) & 0xF;
+				if (vram_vendor)
+					*vram_vendor = mem_vendor;
+				break;
+			/* v25 */
+			case 5:
+				if (module_id > vram_info->v25.vram_module_num)
+					module_id = 0;
+				vram_module = (union vram_module *)vram_info->v25.vram_module;
+				while (i < module_id) {
+					vram_module = (union vram_module *)
+						((u8 *)vram_module + vram_module->v11.vram_module_size);
+					i++;
+				}
+				mem_type = vram_module->v11.memory_type;
+				if (vram_type)
+					*vram_type = convert_atom_mem_type_to_vram_type(adev, mem_type);
+				mem_channel_number = vram_module->v11.channel_num;
+				mem_channel_width = vram_module->v11.channel_width;
+				if (vram_width)
+					*vram_width = mem_channel_number * (1 << mem_channel_width);
+				mem_vendor = (vram_module->v11.vender_rev_id) & 0xF;
+				if (vram_vendor)
+					*vram_vendor = mem_vendor;
+				break;
+			/* v26 */
+			case 6:
+				if (module_id > vram_info->v26.vram_module_num)
+					module_id = 0;
+				vram_module = (union vram_module *)vram_info->v26.vram_module;
+				while (i < module_id) {
+					vram_module = (union vram_module *)
+						((u8 *)vram_module + vram_module->v9.vram_module_size);
+					i++;
+				}
+				mem_type = vram_module->v9.memory_type;
+				if (vram_type)
+					*vram_type = convert_atom_mem_type_to_vram_type(adev, mem_type);
+				mem_channel_number = vram_module->v9.channel_num;
+				mem_channel_width = vram_module->v9.channel_width;
+				if (vram_width)
+					*vram_width = mem_channel_number * (1 << mem_channel_width);
+				mem_vendor = (vram_module->v9.vender_rev_id) & 0xF;
+				if (vram_vendor)
+					*vram_vendor = mem_vendor;
+				break;
+			default:
+				return -EINVAL;
 			}
+		} else {
+			/* invalid frev */
+			return -EINVAL;
 		}
+
+	} else {
+		return -EINVAL;
 	}
 
 	return 0;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.h
index 67c8d105729b..0760e4510513 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.h
@@ -30,6 +30,10 @@ uint32_t amdgpu_atomfirmware_query_firmware_capability(struct amdgpu_device *ade
 bool amdgpu_atomfirmware_gpu_virtualization_supported(struct amdgpu_device *adev);
 void amdgpu_atomfirmware_scratch_regs_init(struct amdgpu_device *adev);
 int amdgpu_atomfirmware_allocate_fb_scratch(struct amdgpu_device *adev);
+int amdgpu_atomfirmware_get_integrated_system_info(struct amdgpu_device *adev,
+	int *vram_width, int *vram_type, int *vram_vendor);
+int amdgpu_atomfirmware_get_umc_info(struct amdgpu_device *adev,
+	int *vram_width, int *vram_type, int *vram_vendor);
 int amdgpu_atomfirmware_get_vram_info(struct amdgpu_device *adev,
 	int *vram_width, int *vram_type, int *vram_vendor);
 int amdgpu_atomfirmware_get_uma_carveout_info(struct amdgpu_device *adev,
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
index f165d4e401e8..ecb42b304ccc 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
@@ -34,6 +34,7 @@
 #include "amdgpu_ras.h"
 #include "amdgpu_reset.h"
 #include "amdgpu_xgmi.h"
+#include "amdgpu_atomfirmware.h"
 
 #include <drm/drm_drv.h>
 #include <drm/ttm/ttm_tt.h>
@@ -1748,3 +1749,24 @@ int amdgpu_gmc_init_mem_ranges(struct amdgpu_device *adev)
 
 	return 0;
 }
+
+int amdgpu_gmc_get_vram_info(struct amdgpu_device *adev,
+		int *vram_width, int *vram_type, int *vram_vendor)
+{
+	if (adev->flags & AMD_IS_APU)
+		return amdgpu_atomfirmware_get_integrated_system_info(adev,
+							vram_width, vram_type, vram_vendor);
+	switch (amdgpu_ip_version(adev, GC_HWIP, 0)) {
+	case IP_VERSION(12, 0, 0):
+	case IP_VERSION(12, 0, 1):
+	case IP_VERSION(9, 5, 0):
+	case IP_VERSION(9, 4, 4):
+	case IP_VERSION(9, 4, 3):
+		return amdgpu_atomfirmware_get_umc_info(adev,
+								vram_width, vram_type, vram_vendor);
+	default:
+		return amdgpu_atomfirmware_get_vram_info(adev,
+								vram_width, vram_type, vram_vendor);
+	}
+	return 0;
+}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
index b9fdc3276e81..32e73e8ba778 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
@@ -482,4 +482,6 @@ amdgpu_gmc_query_memory_partition(struct amdgpu_device *adev);
 int amdgpu_gmc_init_mem_ranges(struct amdgpu_device *adev);
 void amdgpu_gmc_init_sw_mem_ranges(struct amdgpu_device *adev,
 				   struct amdgpu_mem_partition_info *mem_ranges);
+int amdgpu_gmc_get_vram_info(struct amdgpu_device *adev,
+		int *vram_width, int *vram_type, int *vram_vendor);
 #endif
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
index 2568eeaae945..fd691b2a6e21 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
@@ -767,7 +767,7 @@ static int gmc_v10_0_sw_init(struct amdgpu_ip_block *ip_block)
 		adev->gmc.vram_type = AMDGPU_VRAM_TYPE_GDDR6;
 		adev->gmc.vram_width = 1 * 128; /* numchan * chansize */
 	} else {
-		r = amdgpu_atomfirmware_get_vram_info(adev,
+		r = amdgpu_gmc_get_vram_info(adev,
 				&vram_width, &vram_type, &vram_vendor);
 		adev->gmc.vram_width = vram_width;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
index 6349e239a367..e6db87b94eb1 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
@@ -751,7 +751,7 @@ static int gmc_v11_0_sw_init(struct amdgpu_ip_block *ip_block)
 
 	spin_lock_init(&adev->gmc.invalidate_lock);
 
-	r = amdgpu_atomfirmware_get_vram_info(adev,
+	r = amdgpu_gmc_get_vram_info(adev,
 					      &vram_width, &vram_type, &vram_vendor);
 	adev->gmc.vram_width = vram_width;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
index f1079bd8cf00..6e184ea069ef 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
@@ -825,7 +825,7 @@ static int gmc_v12_0_sw_init(struct amdgpu_ip_block *ip_block)
 	if (amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(12, 1, 0)) {
 		gmc_v12_1_init_vram_info(adev);
 	} else {
-		r = amdgpu_atomfirmware_get_vram_info(adev,
+		r = amdgpu_gmc_get_vram_info(adev,
 			      &vram_width, &vram_type, &vram_vendor);
 		adev->gmc.vram_width = vram_width;
 		adev->gmc.vram_type = vram_type;
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
index 1ca0202cfdea..d865059e884a 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
@@ -1823,24 +1823,37 @@ static void gmc_v9_0_save_registers(struct amdgpu_device *adev)
 		adev->gmc.sdpif_register = RREG32_SOC15(DCE, 0, mmDCHUBBUB_SDPIF_MMIO_CNTRL_0);
 }
 
-static void gmc_v9_4_3_init_vram_info(struct amdgpu_device *adev)
+static void gmc_v9_0_init_vram_info(struct amdgpu_device *adev)
 {
 	static const u32 regBIF_BIOS_SCRATCH_4 = 0x50;
+	int dev_var = adev->pdev->device & 0xF;
 	u32 vram_info;
 
-	adev->gmc.vram_type = AMDGPU_VRAM_TYPE_HBM;
-	adev->gmc.vram_width = 128 * 64;
-
-	if (amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(9, 5, 0))
-		adev->gmc.vram_type = AMDGPU_VRAM_TYPE_HBM3E;
-
-	if (amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(9, 4, 4) &&
-		adev->rev_id == 0x3)
-		adev->gmc.vram_type = AMDGPU_VRAM_TYPE_HBM3E;
-
-	if (!(adev->flags & AMD_IS_APU) && !amdgpu_sriov_vf(adev)) {
-		vram_info = RREG32(regBIF_BIOS_SCRATCH_4);
-		adev->gmc.vram_vendor = vram_info & 0xF;
+	if (adev->gmc.is_app_apu) {
+		adev->gmc.vram_type = AMDGPU_VRAM_TYPE_HBM;
+		adev->gmc.vram_width = 128 * 64;
+	} else if (adev->flags & AMD_IS_APU) {
+		adev->gmc.vram_type = AMDGPU_VRAM_TYPE_DDR4;
+		adev->gmc.vram_width = 64 * 64;
+	} else if (amdgpu_is_multi_aid(adev)) {
+		adev->gmc.vram_type = AMDGPU_VRAM_TYPE_HBM;
+		adev->gmc.vram_width = 128 * 64;
+
+		if (amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(9, 5, 0))
+			adev->gmc.vram_type = AMDGPU_VRAM_TYPE_HBM3E;
+
+		if (amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(9, 4, 4) &&
+		    adev->rev_id == 0x3)
+			adev->gmc.vram_type = AMDGPU_VRAM_TYPE_HBM3E;
+
+		if (amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(9, 4, 3) &&
+		    (dev_var == 0x5))
+			adev->gmc.vram_type = AMDGPU_VRAM_TYPE_HBM3E;
+
+		if (!(adev->flags & AMD_IS_APU) && !amdgpu_sriov_vf(adev)) {
+			vram_info = RREG32(regBIF_BIOS_SCRATCH_4);
+			adev->gmc.vram_vendor = vram_info & 0xF;
+		}
 	}
 }
 
@@ -1856,19 +1869,11 @@ static int gmc_v9_0_sw_init(struct amdgpu_ip_block *ip_block)
 
 	spin_lock_init(&adev->gmc.invalidate_lock);
 
-	if (amdgpu_is_multi_aid(adev)) {
-		gmc_v9_4_3_init_vram_info(adev);
-	} else if (!adev->bios) {
-		if (adev->flags & AMD_IS_APU) {
-			adev->gmc.vram_type = AMDGPU_VRAM_TYPE_DDR4;
-			adev->gmc.vram_width = 64 * 64;
-		} else {
-			adev->gmc.vram_type = AMDGPU_VRAM_TYPE_HBM;
-			adev->gmc.vram_width = 128 * 64;
-		}
+	if (!adev->bios) {
+		gmc_v9_0_init_vram_info(adev);
 	} else {
-		r = amdgpu_atomfirmware_get_vram_info(adev,
-			&vram_width, &vram_type, &vram_vendor);
+		r = amdgpu_gmc_get_vram_info(adev,
+				&vram_width, &vram_type, &vram_vendor);
 		if (amdgpu_sriov_vf(adev))
 			/* For Vega10 SR-IOV, vram_width can't be read from ATOM as RAVEN,
 			 * and DF related registers is not readable, seems hardcord is the
@@ -1896,6 +1901,7 @@ static int gmc_v9_0_sw_init(struct amdgpu_ip_block *ip_block)
 		adev->gmc.vram_type = vram_type;
 		adev->gmc.vram_vendor = vram_vendor;
 	}
+
 	switch (amdgpu_ip_version(adev, GC_HWIP, 0)) {
 	case IP_VERSION(9, 1, 0):
 	case IP_VERSION(9, 2, 2):
-- 
2.34.1

