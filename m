Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B64FC5DF70
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Aug 2026 21:03:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 113CF10F710;
	Fri, 14 Aug 2026 21:03:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="oyh4Cyp0";
	dkim-atps=neutral
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010001.outbound.protection.outlook.com
 [40.93.198.1])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8235D10F6F5
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 Aug 2026 21:03:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vzfUGJw7tRceCRgjwotNDBgfaWTCsooVdg6hR24AN5eSmw+leNz9NyebpSWMM+GCVtiDrhh1qnOfGF1EeNNjhCUtIXtE4ZHXtCX6t2UMY+2vibRO8IvTWijoeqhBW5MZvB/7URt2jeS7UY5HBTH8sdULvVvZIOgoAO1SCeZ17A3lYOs2dxfVLFWpDPQeBpGIdOccIHhL1LPCRruRNWlNkFpUbej2aDZ4ZryfS83c0AyfRbL09xefLI0bO3glWEXbrwFohdl9yDBHbYZux7rdeO4MSRvmrigXA/2rBzGVAsFE8kcD6f0N3mtM5+zc+BEkiGFUTHDSi2vPuzp4TouhVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nkgxdAXeG4r89mOk9yPqfH87X8Yv25HJls/pUc+tUx8=;
 b=O06An+3O2Y1WZwVL11+tLCH/RmRrm0QhDi0e2GofjuNQD61wr/HPCE1ceCm5ObwdbNK0e128lFXBknR1v9wRQ3D10U7OhtgJ7IdkTq5nQ2XgHfxk7rHXABqJjiD3CPggbo0E27tAAkmjR3PLAuFUyOb3K0i9yU32A4bpb7s40RSZDKQWnvfZW64ZseKi0X9aDO7mf3852G5LrtBpuzLmGRlIf8JcN4k0LrcYUR+qZInBbqTKyRZcA/CDb4XUeDf5Ejz/IppXjp12KrqLnanHgwkGB46QB9EtBHzolDtzG+KJJF+omxaPsdb6MI8R5D7D9XytlECJFGpbtDR6AikUng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nkgxdAXeG4r89mOk9yPqfH87X8Yv25HJls/pUc+tUx8=;
 b=oyh4Cyp006KF60fC5uA7dkpgDHTcRDAOw4v7+T4Y7CVHnNtAGodjijYE9Et4FKeDnXQhpKSqgicHeXLKEYr/4+yeZVZnWgQAzmXLuwr6zsOWnLUf5auRIAWWZKgaRBadzWkaMRXTHaZg+XGkQoqKwvY4fZ1FtMdyei9OkAax+Y4=
Received: from CH0P220CA0017.NAMP220.PROD.OUTLOOK.COM (2603:10b6:610:ef::34)
 by PH0PR12MB8125.namprd12.prod.outlook.com (2603:10b6:510:293::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.13; Fri, 14 Aug
 2026 21:03:23 +0000
Received: from CH3PEPF00000011.namprd21.prod.outlook.com
 (2603:10b6:610:ef:cafe::5c) by CH0P220CA0017.outlook.office365.com
 (2603:10b6:610:ef::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.315.15 via Frontend Transport; Fri,
 14 Aug 2026 21:03:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH3PEPF00000011.mail.protection.outlook.com (10.167.244.116) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.0 via Frontend Transport; Fri, 14 Aug 2026 21:03:23 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 14 Aug
 2026 16:03:17 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.45 via Frontend
 Transport; Fri, 14 Aug 2026 16:03:17 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Candice Li <candice.li@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 033/109] drm/amdgpu: add ext_umc_mask to RAS TA init
Date: Fri, 14 Aug 2026 17:01:30 -0400
Message-ID: <20260814210246.3067612-34-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260814210246.3067612-1-alexander.deucher@amd.com>
References: <20260814210246.3067612-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF00000011:EE_|PH0PR12MB8125:EE_
X-MS-Office365-Filtering-Correlation-Id: fda34766-ad93-437c-57d0-08defa477a59
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700016|82310400026|23010399003|10067099003|11063799006|22082099003|18002099003|56012099006;
X-Microsoft-Antispam-Message-Info: nWC6uhk5hjdomcoeMsBrQciKtu4/nAWhxOGSyF9xBst71br9e3hW1HVd3ZXeft64kwA6KEuDS/HXiAsxj+aTiP5Lxilw8itbFOIH2Oa/8acotwKtp2byHAq2wQZQgfmO6wez7oB5INHoUFb01f7hNXI6w3xvUL4ZIXdxDA5UdhZV1JU1VRzaQFnc9V+a6tQI9bc95dC5BkwaiidLoaJtb4oObKKTnSGffnFcVwaqpFYy/88E1jypp9lWtWU7RtfpXUCpkuBUbZ+5B5zZ/nAzQImqoh/sVP1sgind8kuoGH8d0/es17cI0fiMvR4kBbgaK0AcKh07H5eOkpFKnxQWTaMfdncjcCl2UncyHaytG+mgv/5kcMA5fXvONlUakdZRxHGvwlvDIb3WoCTs7WZaf5CUMNgk//dsZng6LpyU+1N9SGm+joBzuNYAqiIcX5hx6i5sV7FLDK3R7Si/t6t4sUfXTNXVxvRUWvPbj1hr0lBOb5JTAwUqFyhpvuYSVDxCo8cM/hmIpXj16uOX3mEwfiDUn3r5+otXKdcN92maSRc/b4s7sX+VPI4NYJSE3w24foTY3q5YlEQUoo7QpRZ2lTZm2BGTPW9m8dWy/cutJ+iEnKby+YXipA/yudeai/W4bETxwUtKBpaB3I7eXFmYE39cb7OWOB8waruDzt2TeX0=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700016)(82310400026)(23010399003)(10067099003)(11063799006)(22082099003)(18002099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: q42cLOQHLv8owZ4R0VVoLGBnSfi0cpS+Cs6T2EI16IM9lNKvugNSrfAfIFjlNDl4B6ALsVjOUqq5t1+QqpzoV3sreg4dqNsWWxuGRJcn7WBko11AkjBQ+HzDU/sb3yebFDElKJmTRHseB43YQpzPJJ+azeNI69R9Bb3VsfRSeBX5P+3fdBw+UrweXsszA+RUOyAV6EpqMkvvaD+kVyrTh2onfNZBvEyD6+YVSrEvxVF4f4zXJ1E7Hdo55ZvameMVMQ4Tlrlx1n18hqGjKMqVmUAvXoggEeST37wm47pj1hI3x8hunyBcBBgSwXMxO7vDHKvR+E9yqEKpi9JxnRfpvdYrtffJw13uS5JVE5oCRxEb4G1VdPDZtmd+a9qwGQSSYWTTWyooB9sMFKAhXfLKugTA9GxB7X9/p1+asjhqEU3K+dGEVMit8QaM1YRKVsPj
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2026 21:03:23.4919 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fda34766-ad93-437c-57d0-08defa477a59
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF00000011.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8125
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

From: Candice Li <candice.li@amd.com>

Add ext_umc_mask for the upper half of
adev->umc.active_mask and fill both fields
when building RAS TA init message.

Signed-off-by: Candice Li <candice.li@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 3 ++-
 drivers/gpu/drm/amd/amdgpu/ta_ras_if.h  | 1 +
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
index 2a0ab763f59ac..a77b87966fee9 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -2453,8 +2453,9 @@ int psp_ras_initialize(struct psp_context *psp)
 	if (adev->gmc.gmc_funcs->query_mem_partition_mode)
 		ras_cmd->ras_in_message.init_flags.nps_mode =
 			adev->gmc.gmc_funcs->query_mem_partition_mode(adev);
-	ras_cmd->ras_in_message.init_flags.active_umc_mask = adev->umc.active_mask;
+	ras_cmd->ras_in_message.init_flags.active_umc_mask = lower_32_bits(adev->umc.active_mask);
 	ras_cmd->ras_in_message.init_flags.vram_type = (uint8_t)adev->gmc.vram_type;
+	ras_cmd->ras_in_message.init_flags.ext_umc_mask = upper_32_bits(adev->umc.active_mask);
 
 	ret = psp_ta_load(psp, &psp->ras_context.context);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/ta_ras_if.h b/drivers/gpu/drm/amd/amdgpu/ta_ras_if.h
index f6178da910d35..3110140f739a9 100644
--- a/drivers/gpu/drm/amd/amdgpu/ta_ras_if.h
+++ b/drivers/gpu/drm/amd/amdgpu/ta_ras_if.h
@@ -156,6 +156,7 @@ struct ta_ras_init_flags {
 	uint8_t nps_mode;
 	uint32_t active_umc_mask;
 	uint8_t vram_type;
+	uint32_t ext_umc_mask;
 };
 
 struct ta_ras_mca_addr {
-- 
2.55.0

