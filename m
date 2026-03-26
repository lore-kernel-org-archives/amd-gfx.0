Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E581F106F2E9
	for <amd-gfx@archiver.kernel.org>; Thu, 26 Mar 2026 07:55:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 79B0610E952;
	Thu, 26 Mar 2026 07:55:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="egtnbPIG";
	dkim-atps=neutral
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012023.outbound.protection.outlook.com [52.101.53.23])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1421E10E2EA
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Mar 2026 07:55:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Jnt1QDUlu2MGWSWyOoQiLaNlnh/0nQyenEvGc+n21c5Z45ESvrJ7IWkPky3CQoqEjfS4DgbsmMnkr6ccVOv9e9uLxTd4NBZVA/IWrpelEDdL5UCp71G29XjicYs+LQDyGDqtveTpRrbLQ6JDQYocDonfv4jc7KpGecWpLD7PUJhyINJeJw82J4smM5JXFUGeah/LfwNo1/RUOpYq8HMPdcIW9NhZC9G+R11aXMKtr23sz3Uuzhh+kA7ZK/AAb1Hk2hIX5yyBHV+Ekai67QB2G833z/of1SgqIIDa6Z9TnBP12cynlkw0RrmReBhr5FPqEhrKhEtfJFVrSgfszWmXzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JEETsKAzrDKjzTk8Je+8BKTJxLEJG05Tifb0WQd//DE=;
 b=lxoopX+jMe5bXaQDucNts82ufd98p0A11xrn9mGTnKfHAIb8gqBMtVfaat6jhctdjtwamWsAtA5u1/oRkyfFOJKn2f45/SX5KNZMe3EdzL2Y2ihoKf/6ZUQbFxc6ReIhOBnNG3G9JeRKqGrK1T7dubIa+oe0uUBL+21T8wFjUxtXzb0DPnqyhkeKk3Lit+S9NqcAnVnpDlxpcl0+HyWxz7v1Fq/rzOnS6bnA6OCim+Jz22v+pg9ZuBi6bSEEZ+TzP58fVBXtOXAlN15MZJjJEWR9t4FoDu9ZTkDfC+Vv2m+rPZy1mu+Fn/lFnDMf9PvpPzOAbuXmi3wczw+/075Deg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JEETsKAzrDKjzTk8Je+8BKTJxLEJG05Tifb0WQd//DE=;
 b=egtnbPIG4od8IFrSAOOSvJZzTcZ8KaVyfflyzxZMtER5CIYZYpxMR/LxpkmS9kyMW0khdo1/wpzLrasn9BD6huTzBwx4asPhchmup+v10KPp1oOqkxi6x65SDgsU4nKwGDLcYCoNZisTq445NbcCxLGpoM2btfjWuDad3AAPkZg=
Received: from CH5P223CA0013.NAMP223.PROD.OUTLOOK.COM (2603:10b6:610:1f3::8)
 by DS0PR12MB7995.namprd12.prod.outlook.com (2603:10b6:8:14e::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.7; Thu, 26 Mar
 2026 07:55:02 +0000
Received: from CH3PEPF00000012.namprd21.prod.outlook.com
 (2603:10b6:610:1f3:cafe::b6) by CH5P223CA0013.outlook.office365.com
 (2603:10b6:610:1f3::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9723.33 via Frontend Transport; Thu,
 26 Mar 2026 07:55:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH3PEPF00000012.mail.protection.outlook.com (10.167.244.117) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.0 via Frontend Transport; Thu, 26 Mar 2026 07:55:02 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 26 Mar
 2026 02:54:51 -0500
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Alexander.Deucher@amd.com>,
 <Asad.Kamal@amd.com>, <Feifei.Xu@amd.com>, Alex Deucher
 <alexander.deucher@amd.com>
Subject: [PATCH 05/14] drm/amdgpu: Add fw_reserved reserve-region
Date: Thu, 26 Mar 2026 13:15:26 +0530
Message-ID: <20260326075412.1378411-6-lijo.lazar@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH3PEPF00000012:EE_|DS0PR12MB7995:EE_
X-MS-Office365-Filtering-Correlation-Id: 4d17abfa-0b2a-4160-b772-08de8b0cfc7f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700016|82310400026|376014|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: lJzc2FwdCFwRp+LZa9b3Vf3GxGTSt2AXWwUrmYg8MlvPpTtwLRMyzqN1N6ca4RrQBxURvv/HrB0XevNfQmCBEMUzdWpG83iz0n5K1tDJ+TxIDN/7JGeSCSTxYJK2gLMtP/qHNSvDObcjPBjMi/f/wsJ819JKTAJrw88Jpo8OrQXVXqUqj8BAIvRl7XBeRMUTXyGKtGEnscgyxUmaiKbS1Dl9pHtHPaM/qbAxdyYM3J5nglgaIbHjCz+Nbe2wTg0NaN19qqX/y0sHM8D0hU7rdc39RFN9pjOTjLgICVqa/2orqQp0nwpGZ+QYlSdLSISf9dTAKQJhZUUFnbiRcrfO42ifHdkawPNFSOwIFfnlpPV+Tp+mllT5veFaqUt1+p3LarPW9s/8daKq4CwZoOee9EoCgiTnE7DkmartSEzcf9nhkGmbRVhowb/5q0X948Wxvt6896Z4esaQTb8njmz/lE5/yq4km4T3b4nEI8z/5qnk3YQni5Rk9EBT+AjZ82VIUkGYnBGzUAXeOUHk9aJeomCfhx837dCEzXZXw40cFTPRTKqn3m6TYuk3LwwseZc0dZRoGTZsf7y7QUDocKDgUfLMU8OwJRpuo2b84ZL7CUxBAfX7Wtdgxy5G3wh5HMY0MJx8yXoFpW3z+aWZM0jzjYCEDcnfU5+bRLoMalqIQpKJPfbcZYbrzm8t7kgmV5kF8fgPYFvxKoCa5t9MyGoJRA83a5/BKiVAlyBVNRNqCP5KdwjXOuG92zlxNeIVG0UGpWXLEPMhN2Idux8/vWD+lg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700016)(82310400026)(376014)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: rdstsEbtndIDHCrRPj7zxUbUYahGDcrF1D/2/oQT50XCPtOoqfIVfdF0iXSpsTAqNtFekXrApdHySYAY+MaAUN82RgT48qOpartiNoycNuRN8zn7yzD45+cRmw/1HbGPx2ZE6M6EOxRSjuLYN9A+95WEEQf2FJt3wDsMXdyTPjQmjFBxQaGHwE9f098xVOdB8/8I/drTJQXkDzD5kNA42V3L+jLgAhQicI8EWshMD7IZoTb5JXbw+skp1HXBLmfmGnsEMNNcLIvAJz9bIXcpr/zPEfDtFEHHRUsUH9jzFF7bd/tZs/PLy8iV6yPMXuah8ESRpyxjcuOXqPsqWerelpHJbkeDobpHbCg8lZJmlcVtOEWBYBd4C5EBKbgZGMoLk2U6kxB45jJsh5coid50nNWgZTwRevhhthlXt/doQ9d4RFCt4oF7G2Am8AeP19xI
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2026 07:55:02.4737 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d17abfa-0b2a-4160-b772-08de8b0cfc7f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF00000012.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7995
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

Use reserve region helpers for initializing/reserving fw_reserved region.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c |  7 ++++---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c | 12 +++++-------
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h |  1 -
 4 files changed, 10 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
index 0b35180ace35..2fa753a1fdfd 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -1076,14 +1076,15 @@ int psp_update_fw_reservation(struct psp_context *psp)
 		return 0;
 	}
 
-	amdgpu_bo_free_kernel(&adev->mman.fw_reserved_memory, NULL, NULL);
+	amdgpu_ttm_unmark_vram_reserved(adev, AMDGPU_RESV_FW);
 
 	reserv_size = roundup(reserv_size, SZ_1M);
 
-	ret = amdgpu_bo_create_kernel_at(adev, reserv_addr, reserv_size, &adev->mman.fw_reserved_memory, NULL);
+	amdgpu_ttm_init_vram_resv(adev, AMDGPU_RESV_FW,
+				  reserv_addr, reserv_size, false);
+	ret = amdgpu_ttm_mark_vram_reserved(adev, AMDGPU_RESV_FW);
 	if (ret) {
 		dev_err(adev->dev, "reserve fw region failed(%d)!\n", ret);
-		amdgpu_bo_free_kernel(&adev->mman.fw_reserved_memory, NULL, NULL);
 		return ret;
 	}
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index 666503534f17..c38af6d3599e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -5726,7 +5726,7 @@ int amdgpu_ras_add_critical_region(struct amdgpu_device *adev,
 
 static void amdgpu_ras_critical_region_init(struct amdgpu_device *adev)
 {
-	amdgpu_ras_add_critical_region(adev, adev->mman.fw_reserved_memory);
+	amdgpu_ras_add_critical_region(adev, adev->mman.resv_region[AMDGPU_RESV_FW].bo);
 }
 
 static void amdgpu_ras_critical_region_fini(struct amdgpu_device *adev)
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
index 798d3faf48a7..4d373904d071 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
@@ -1919,13 +1919,12 @@ static int amdgpu_ttm_reserve_tmr(struct amdgpu_device *adev)
 		ctx->init = PSP_MEM_TRAIN_RESERVE_SUCCESS;
 	}
 
-	ret = amdgpu_bo_create_kernel_at(
-		adev, adev->gmc.real_vram_size - reserve_size, reserve_size,
-		&adev->mman.fw_reserved_memory, NULL);
+	amdgpu_ttm_init_vram_resv(adev, AMDGPU_RESV_FW,
+				  adev->gmc.real_vram_size - reserve_size,
+				  reserve_size, false);
+	ret = amdgpu_ttm_mark_vram_reserved(adev, AMDGPU_RESV_FW);
 	if (ret) {
 		dev_err(adev->dev, "alloc tmr failed(%d)!\n", ret);
-		amdgpu_bo_free_kernel(&adev->mman.fw_reserved_memory, NULL,
-				      NULL);
 		return ret;
 	}
 
@@ -2341,8 +2340,7 @@ void amdgpu_ttm_fini(struct amdgpu_device *adev)
 		amdgpu_ttm_unmark_vram_reserved(adev, AMDGPU_RESV_STOLEN_VGA);
 		amdgpu_ttm_unmark_vram_reserved(adev, AMDGPU_RESV_STOLEN_EXTENDED);
 		/* return the FW reserved memory back to VRAM */
-		amdgpu_bo_free_kernel(&adev->mman.fw_reserved_memory, NULL,
-				      NULL);
+		amdgpu_ttm_unmark_vram_reserved(adev, AMDGPU_RESV_FW);
 		amdgpu_bo_free_kernel(&adev->mman.fw_reserved_memory_extend, NULL,
 				      NULL);
 		amdgpu_ttm_unmark_vram_reserved(adev, AMDGPU_RESV_STOLEN_RESERVED);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
index dd35db20ba66..70d4fdc54b8d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
@@ -102,7 +102,6 @@ struct amdgpu_mman {
 	bool			keep_stolen_vga_memory;
 
 	/* fw reserved memory */
-	struct amdgpu_bo		*fw_reserved_memory;
 	struct amdgpu_bo		*fw_reserved_memory_extend;
 
 	/* firmware VRAM reservation */
-- 
2.49.0

