Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B6D2FEA800
	for <amd-gfx@archiver.kernel.org>; Thu, 26 Mar 2026 03:28:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3A8D510E8F6;
	Thu, 26 Mar 2026 03:28:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="m9vjLvNn";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012029.outbound.protection.outlook.com
 [40.93.195.29])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 83ECF10E24C
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Mar 2026 03:28:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Usa5S+h+C/jeBEDncIv1Hpujs72CG6URws87kIBXJaPwIZytIxwad0ShcxFtLEehtvWxF90lcuTcGLYelUmdn6yX3PjpbGtiUOM9JQEkb+co0ROIBItVI78RTg68RhttbaRQIJcxEuKiQjMh2PHXRyu9mkTvVQ2lOnWv5cSM3/fUPmjgtDPF6eVHZE5MZ99JQKdVSME5l7u2H81mgWafR2FHTojLqY3X89OVdAQoVAo0Plm+u24scCBBArjJWzaUuWBtl/DXRkzRIjCe9TB4chVf8qWy+XqqBtA45SJ4jAm1a/R7Ddw3dQQRejQmMP7gCWC84kjuuyGZ6FkXvZlKcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7dy+IIvnNr97qEMwnqeh8cLoyNX/AqsrEXRzNz5tQmE=;
 b=jXUQF0aEOZdUux0kg4o6hnnFkK4GOL7Qd+9qntAfxmDUCkX+Y0hu92uwY0J7ulgE2VxhiwspknEq2SVY4pDgriMWMR+rEMtLlRrSHxz8jDXSGxZYtMcH0KWn0JZXyGtvCzKX+Ri9claI1Sl7fJ7vBRtQo+tGffamdZoJVqxznE2yF4qYt0s+O44wc4mN1gfOGXZFcCJaNk99ZSEO/3tCKYThvL2rPJO6cFH8SNw/HQ5U7G9WkRO/xmZn/cevn0z1QX/Pc4oN0jwDBA20sek3OS4mnTKBx7/Wz/Y6K89sEd3DXvDSKS+pC1CsPPTKI8HCpDW0tYLLywiSB7wyP84Ftg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7dy+IIvnNr97qEMwnqeh8cLoyNX/AqsrEXRzNz5tQmE=;
 b=m9vjLvNnt2/QiVMO1BgOcds8+yHhzrGDl15KF/iKFCDg2lSC7sNve10m6YuscgCzz4tx0V1MUPmcR9LQzxpenCIzF2rANRdDKFuKRnYQd3yPb28Jl2xTpQgp4YHVMlfrZaXTibw6a//YSwgDlczSfU2QC5blHBQ60YVqqjel7X0=
Received: from DM6PR03CA0067.namprd03.prod.outlook.com (2603:10b6:5:100::44)
 by SA1PR12MB7222.namprd12.prod.outlook.com (2603:10b6:806:2bf::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.7; Thu, 26 Mar
 2026 03:27:59 +0000
Received: from DS2PEPF00003447.namprd04.prod.outlook.com
 (2603:10b6:5:100:cafe::ca) by DM6PR03CA0067.outlook.office365.com
 (2603:10b6:5:100::44) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9723.32 via Frontend Transport; Thu,
 26 Mar 2026 03:27:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS2PEPF00003447.mail.protection.outlook.com (10.167.17.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9745.21 via Frontend Transport; Thu, 26 Mar 2026 03:27:58 +0000
Received: from gangliang-mlse-vm.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Wed, 25 Mar 2026 22:27:55 -0500
From: Gangliang Xie <ganglxie@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <tao.zhou1@amd.com>, Gangliang Xie
 <ganglxie@amd.com>
Subject: [PATCH V4] drm/amdgpu: add support to query vram info from firmware
Date: Thu, 26 Mar 2026 11:27:39 +0800
Message-ID: <20260326032739.2140299-1-ganglxie@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003447:EE_|SA1PR12MB7222:EE_
X-MS-Office365-Filtering-Correlation-Id: d45ed9b9-ab31-4b6c-7722-08de8ae7ad69
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700016|1800799024|82310400026|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: 1F7Zjxnb3hT+3aWKzN1g5KqUENrJrEgPc76V4LcoIFl5ZUizHMgAK46mf4AwNfid5xYSTIma9P6x5DLYfYdlnMkDwXrb8oLduAzzV4PaqMzL0fEls23ZsoRngHlM/kfh3qC2J02ptJQOOB2/YmOnhgNfeJP5/qeA7KQhDdhkFox3Zyq905brQDNu+9Y3eZd8nrJWm1Y8Eb1lCVKDT5UIguIa7BvpqrEsvdJkUxiUNSRSKRxvuqB8a1BtsZQfjIRJtt+UIgCfnpivvb8kKR1z6exs7FYwfUOR94pR8vsQEqMnPEzjzuVwLBraW/KOAQXZRg65cXo9bK4AaPYKPSNkr6oxOirmUWpEe4kY1qqyI8hFzsf33Arp++DAvNltUp1bq9d/EiRuRsvYcd1zR1d44JYCR1lmJzzFsyEgw84yNABahKsvOTMrWEHRO5gcJu2YLk5X4KWzh6yDmhNnyM0elYTdd2jdu5opdrHjXwgvtil9sGYyjYLsfFHCR0QXCEiSwUzzooiHNbP+731Lym5Ib8lYsoYApyejEzx/u/g1IoGn9kjpwLud+RW9hh6c1zP6X/ic4w07nTz2drK8IDZ+d3qo302nJSkhQZY3cmicGe1yty5e2BOk2ZSe+41N3DFeSZk2IZktxYgwQ3dHoltNS/stnxG/t4mCeHWCoSL8eTyTKjM89fCzQdQvApn2trZO+5GSlKVtCaPv1LNu6Hio26ro4hUpVTT+6ZQvogF+qrF8WTwg51tlAVmsLQ4CsweCLoe1A64CwSUNwGIpb6umzg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700016)(1800799024)(82310400026)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: j2oQTV2WcJv153Q6BSVl09LO6Aqn9HLqrIaLCJgvpvfwvncddhwbIFd8yMbSpQMPy00PF3ZDEj7/7sSl5zfVQl/UlUHtS3zs8j3JWZIC7n0AzoC+05PaBu4uB8l5Vhi1z6DuprJtis2Eba0+ZKZhxRGh6Pjy5KcOgZcGYyNpQM2fERfQBModNeuepl4hqrG9fRLJgXwafKHB7//i3LzCf2e+C0WD/EWMwCheKCyRBox/L/zph09Xt+6Gh+ftvXspAnKX+CWCzjt7ZG4uwxVqwfVV/wFWJi30yTNE4f6RZvl54kQdzmH9f90Sgxq1ZpseyqT8K387dyUoxRguOK6fMxRyx4abrkEhd8tnbIo4/li/2/Vg2WBcPqNu+jvbT6b/+ZrIYrXDy50ARTf4SRMEo8GlcfZM8mKntZklS6QQ+UwJDdlEF0QOwyGTPDXwiUpm
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2026 03:27:58.3875 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d45ed9b9-ab31-4b6c-7722-08de8ae7ad69
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF00003447.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7222
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
v4: calculate vram_width for v9.x

Signed-off-by: Gangliang Xie <ganglxie@amd.com>
---
 .../gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c  | 459 ++++++++++--------
 .../gpu/drm/amd/amdgpu/amdgpu_atomfirmware.h  |   4 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c       |  28 ++
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h       |   2 +
 drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c        |   2 +-
 drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c        |   2 +-
 drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c        |   2 +-
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c         |  58 ++-
 8 files changed, 314 insertions(+), 243 deletions(-)

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
index f165d4e401e8..10713be13579 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
@@ -34,6 +34,7 @@
 #include "amdgpu_ras.h"
 #include "amdgpu_reset.h"
 #include "amdgpu_xgmi.h"
+#include "amdgpu_atomfirmware.h"
 
 #include <drm/drm_drv.h>
 #include <drm/ttm/ttm_tt.h>
@@ -1748,3 +1749,30 @@ int amdgpu_gmc_init_mem_ranges(struct amdgpu_device *adev)
 
 	return 0;
 }
+
+int amdgpu_gmc_get_vram_info(struct amdgpu_device *adev,
+		int *vram_width, int *vram_type, int *vram_vendor)
+{
+	int ret = 0;
+
+	if (adev->flags & AMD_IS_APU)
+		return amdgpu_atomfirmware_get_integrated_system_info(adev,
+							vram_width, vram_type, vram_vendor);
+	switch (amdgpu_ip_version(adev, GC_HWIP, 0)) {
+	case IP_VERSION(12, 0, 0):
+	case IP_VERSION(12, 0, 1):
+		return amdgpu_atomfirmware_get_umc_info(adev,
+								vram_width, vram_type, vram_vendor);
+	case IP_VERSION(9, 5, 0):
+	case IP_VERSION(9, 4, 4):
+	case IP_VERSION(9, 4, 3):
+		ret = amdgpu_atomfirmware_get_umc_info(adev,
+								vram_width, vram_type, vram_vendor);
+		*vram_width *= hweight32(adev->aid_mask);
+		return ret;
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

