Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08869106F2E7
	for <amd-gfx@archiver.kernel.org>; Thu, 26 Mar 2026 07:55:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7FDC910E95B;
	Thu, 26 Mar 2026 07:55:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="SXSgPztI";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011046.outbound.protection.outlook.com [52.101.52.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ED94510E8F2
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Mar 2026 07:55:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FQFbCxbpjfxPk8ijrY3BdZs0cNas8CYnjhET7t6OHzSBiGp8jJEeDuOC0kC2A8AH4BhOwMJYcyuP931AgXy3Fy8ZWla6cC3QOt4/V5dh/PNTcdQi8OoNY/QZsCsnBtjp94jYZZlbn5xSJ/AmvNlveOtPR+0+RLA3SpBZzcCjhXgIxDCqpPSenGlmboOJ7HkVxlPMo6do7sPXogM6CA8g9bUMvtCpLQwToR2oPoKGjznPxfO4sjk30vO8QEDSKm0WRxVN12J4mDAnjXWN0kFGhy+ZXcL/gThADYZjlYwPGSPKCfit4kJ65pT2CgrI7POcCz/jwIoEn936LszxbgvphA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9bNhuKlNZ2HKVQL2pXABirTCF6GhIp8hWwc1iz7jm7k=;
 b=BYAVnM38cIkZChWo+WAmEGbo01YfgLETznW2v7bDRuI29qLCtq+4zwCAtfQ4gOXF9fIzbmBq7l69cxHGIDQRunKIelRDz48lormcyCwEGMClFYhSb/g/XqpOcmMLeItLSPGFOji0a6uNwajvmHDQv2in/iCXjLmCtMpioQoTUPB7W5/xpUBE2r8ZlnpQH9xOTQXOoGnU+6GgM1EAa/j75yNNoDl87ey6ad/6hfamFrawhhdCoMS9s2Jb9HH02k85inKSK0E21Lr1QG0+eeRoasYkXR6fFK+2SGgYq0jTCC6tPopr87VzpUYx5Jfb8pT3jdJfEdCL3utnu9NzATXIOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9bNhuKlNZ2HKVQL2pXABirTCF6GhIp8hWwc1iz7jm7k=;
 b=SXSgPztIhuiIr7MIXmniyU2OpVUHDFTpPfXe7SO3pV/wXi9pXXl4Imk1xJ3zRia34KVKtWo89f3Rb8oY1e0F1PLrBDf0I6UZDXWdwR9mz7o40WtY/u21yL0lINa3MdBpqRgp27S0xlPWuggL3mwkP/ZRjZh5FuixwrGr68cbFv0=
Received: from CH5P223CA0002.NAMP223.PROD.OUTLOOK.COM (2603:10b6:610:1f3::10)
 by SJ2PR12MB9192.namprd12.prod.outlook.com (2603:10b6:a03:55d::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.7; Thu, 26 Mar
 2026 07:55:01 +0000
Received: from CH3PEPF00000012.namprd21.prod.outlook.com
 (2603:10b6:610:1f3:cafe::e2) by CH5P223CA0002.outlook.office365.com
 (2603:10b6:610:1f3::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9745.22 via Frontend Transport; Thu,
 26 Mar 2026 07:55:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH3PEPF00000012.mail.protection.outlook.com (10.167.244.117) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.0 via Frontend Transport; Thu, 26 Mar 2026 07:55:01 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 26 Mar
 2026 02:54:49 -0500
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Alexander.Deucher@amd.com>,
 <Asad.Kamal@amd.com>, <Feifei.Xu@amd.com>, Alex Deucher
 <alexander.deucher@amd.com>
Subject: [PATCH 04/14] drm/amdgpu: Add stolen_reserved reserve-region
Date: Thu, 26 Mar 2026 13:15:25 +0530
Message-ID: <20260326075412.1378411-5-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260326075412.1378411-1-lijo.lazar@amd.com>
References: <20260326075412.1378411-1-lijo.lazar@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF00000012:EE_|SJ2PR12MB9192:EE_
X-MS-Office365-Filtering-Correlation-Id: b429c453-ed8e-4e43-6736-08de8b0cfbed
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700016|376014|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: ScPoT8ADj/OAl6PYhZUQzmP29xesm/YNu5RxK23wgz6Omqcgbr4YR2J0UI8Tt8yeUeXtbxXQPcVPTJNUAGc1d0kE+NzgyqvjIFiyrIj33KkXmm7XRNvwzl5KKXQmCFJL2/i7j2xGywGmeQ0KIdXnrf+o6WVDLaalSHDjBEWSLqEeiraNZWsS9GOtz3XeTcL86+QbGvliyl++OuQIZH+feIuU7EiwPxQfnq5zMMYWwhzmxgHOFsCfrDx/3wNSWFIZeHfWSr3eAQDUgDWfHXTHv0sDGnlY4R0grOAvCazNLKB1m8jnfsoL3ZQbIBTBsmEnPyAGI+cvBU3iA125cYHD1cPckInOzv+FylXmKqEaFOQUi8sPsRXQ/ZaEca1G6Hk+iQTIsI4CwnhXD084KWKBbsXgg8i1zHXjWNBYU4FAssdsKFa+2GTSmi9On4+WMtFq/HSb4HRV7pa/1SQg0zt1uo/Lh29N42uNIfIK590IOq7pfacRPZqz4HG52LUtYlemjKbwfh6hWM0AE7XRqfSfV+d/s/pREumFfmxJx2FMJdKwoySHRicrqTHeySQ7ygAWsUrUCBRAhBsyBNEkNewl/hMIHtYn/D4+jDYKmOHjzWIDCXnjs7fzHg683+YawYgzGPNg9ltErwHMg0+iRQCxcWjeDAZx9EVv1gE36atJRQ+T8gGEiDpNjvWXYETHr2Vub43OMHGqo+v6R4tc/uNWgPhsX0/0XeyA6FUtJ+OMzAcQ2lRiybjQdxGPte/Ntv0MLkxn0vYkxsStNxiIFw0TTw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700016)(376014)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 7edhq3Dh5SHwp0xdWzMysOaGzM6rPVbRyJ3wt2woE7sYHZKnbX71Poiz6GSQfGudEFjaa7iHkWZvARdoM3qmjP4zNCDOpxa0O3u7M/opAOWl9U3t3LJnrucHNbkZhHqUfXWgBtqBUf46uancSoVKzsGG/2hEAUptBWIv7c2s5StXzuCUwYC2u7RRqQxzaKysR4JcplsvgHrhQuZmbzOwNe+f9q3VPP4RSwxb/1lrB/jom7z/thtP4MIdD0qj/nRPPjeF7DKqWJjPTgqMPc7dysxafmH7oGbsaxYzaKpmDGpVAMwdg5j3JETPl+9Vg4mMGR9fN/ByCuV/wPSAalB7LLtTeRzHrpuJkxLHR34PQpSoamjVJRENIK/ZfUGKMK14DCr+07HdL+1krvopbemRxFmwB0EqI/L3LsYRVPpHUlpCgp0MtaQ8+i+589muajyi
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2026 07:55:01.5133 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b429c453-ed8e-4e43-6736-08de8b0cfbed
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF00000012.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9192
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

Use reserve region helpers for initializing/reserving stolen_reserved region.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c |  7 ++-----
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c | 10 ++--------
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h |  4 ----
 3 files changed, 4 insertions(+), 17 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
index 61e8d71dfed5..2bbed5fe5121 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
@@ -1040,9 +1040,6 @@ void amdgpu_gmc_get_vbios_allocations(struct amdgpu_device *adev)
 	 * Some ASICs need to reserve a region of video memory to avoid access
 	 * from driver
 	 */
-	adev->mman.stolen_reserved_offset = 0;
-	adev->mman.stolen_reserved_size = 0;
-
 	/*
 	 * TODO:
 	 * Currently there is a bug where some memory client outside
@@ -1059,8 +1056,8 @@ void amdgpu_gmc_get_vbios_allocations(struct amdgpu_device *adev)
 		 */
 #ifdef CONFIG_X86
 		if (amdgpu_sriov_vf(adev) && hypervisor_is_type(X86_HYPER_MS_HYPERV)) {
-			adev->mman.stolen_reserved_offset = 0x500000;
-			adev->mman.stolen_reserved_size = 0x200000;
+			amdgpu_ttm_init_vram_resv(adev, AMDGPU_RESV_STOLEN_RESERVED,
+						  0x500000, 0x200000, false);
 		}
 #endif
 		break;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
index 7c6d07c570a5..798d3faf48a7 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
@@ -2221,11 +2221,7 @@ int amdgpu_ttm_init(struct amdgpu_device *adev)
 		if (r)
 			return r;
 
-		r = amdgpu_bo_create_kernel_at(adev,
-					       adev->mman.stolen_reserved_offset,
-					       adev->mman.stolen_reserved_size,
-					       &adev->mman.stolen_reserved_memory,
-					       NULL);
+		r = amdgpu_ttm_mark_vram_reserved(adev, AMDGPU_RESV_STOLEN_RESERVED);
 		if (r)
 			return r;
 	} else {
@@ -2349,9 +2345,7 @@ void amdgpu_ttm_fini(struct amdgpu_device *adev)
 				      NULL);
 		amdgpu_bo_free_kernel(&adev->mman.fw_reserved_memory_extend, NULL,
 				      NULL);
-		if (adev->mman.stolen_reserved_size)
-			amdgpu_bo_free_kernel(&adev->mman.stolen_reserved_memory,
-					      NULL, NULL);
+		amdgpu_ttm_unmark_vram_reserved(adev, AMDGPU_RESV_STOLEN_RESERVED);
 	}
 	amdgpu_bo_free_kernel(&adev->mman.sdma_access_bo, NULL,
 					&adev->mman.sdma_access_ptr);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
index 587ca3fdab2d..dd35db20ba66 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
@@ -101,10 +101,6 @@ struct amdgpu_mman {
 
 	bool			keep_stolen_vga_memory;
 
-	struct amdgpu_bo	*stolen_reserved_memory;
-	uint64_t		stolen_reserved_offset;
-	uint64_t		stolen_reserved_size;
-
 	/* fw reserved memory */
 	struct amdgpu_bo		*fw_reserved_memory;
 	struct amdgpu_bo		*fw_reserved_memory_extend;
-- 
2.49.0

