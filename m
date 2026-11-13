Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2EE5606A323
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Nov 2026 14:59:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=IZhpQ11G
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 480B810EC25;
	Fri, 13 Nov 2026 14:59:05 +0000 (UTC)
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010067.outbound.protection.outlook.com [52.101.46.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1DA2010EC25
 for <amd-gfx@lists.freedesktop.org>; Fri, 13 Nov 2026 14:58:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LKgZYdIFmZpCEJR79toOpRvCzZ9vWB1i3wUrrsvdHjKThn8W+xo2t9ebBXfeTpMNFySpbpbJe2vsAeiFaykzUZ1oUMu+3P/Ly5u2eXnK0iC0nIZSWsYq02J1cB4+AiaD9KgYgPCyyGzQyotIWa1gQKW9NrqkX52r5EQsDw47szYFUPeEvpYMARqWQja5dnN2rHW8/nQ4oShvXsIcMm8X7cf9AhoREJorMjjnuguDTS/GJBVcnU4Uf7+jKOGy9f3XGwz1O+w1jzJ1Z9o34EeZMyTTXCogtWaH/bsR+OlrF/7ucE4vE7kVCDGeYXnn4WdLS3iHkxLM2uvhgDFPs9VBwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jJSXOXm9QdyK3bIBeSynBPHP8WOwcQDRjm8pxZRamjc=;
 b=jqMZEtkpNeKn+6X4j6NYeael0JTshyDQmBUChtvdF4ictLCZqJ4vdidXCeh9wOuKfPnKYB4mcqet79pKuLj61Lr+Gixc+K6qC/ksZjiG3rA+FZLDrmHronFB8Lzat2N6L4jea4oi1KYMdsaebZxbFMMYr1ADhD3Is8AYUHcXC/QGmpkyphON2O2ofn85qE5/+AkwAfR+pdKk4Is4Dz/twYbsxArY75EhQSI62LYzFwilg3LFhOLeheAdVQXCRc+2+HNIX2NcXWox7BbW0QR4UaodARxGhmVme5eULwH1rWlj5BCjlo2su+CrsgMzrHb7cNTfFJVsltonNikoI7lmRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jJSXOXm9QdyK3bIBeSynBPHP8WOwcQDRjm8pxZRamjc=;
 b=IZhpQ11Gs8wu6m9tpNqH3OSi+eUAFoDUnsLsS775OnNJpsts1dkrgEgmtvcOp1Rb5d1rkyDOuh8ZQcTgDb0ix3QtlGTSftA55aBwUhWlMjQi/lw7Ky+5AGa975KVZK+AV5iKC1pNfSyQam7RSwGI5iper3ghxFXKOHRTYNnSQeg=
Received: from CY8PR19CA0046.namprd19.prod.outlook.com (2603:10b6:930:6::10)
 by BL1PR12MB5801.namprd12.prod.outlook.com (2603:10b6:208:391::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.8; Fri, 13 Nov
 2026 14:57:29 +0000
Received: from CY7PEPF000000F3.namprd05.prod.outlook.com
 (2603:10b6:930:6:cafe::31) by CY8PR19CA0046.outlook.office365.com
 (2603:10b6:930:6::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.9 via Frontend Transport; Fri, 13
 Nov 2026 14:57:28 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY7PEPF000000F3.mail.protection.outlook.com (10.167.247.151) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Fri, 13 Nov 2026 14:57:28 +0000
Received: from MKMZHLUO01.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Fri, 13 Nov
 2026 08:57:19 -0600
From: Zhigang Luo <Zhigang.Luo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <alexander.deucher@amd.com>, <christian.koenig@amd.com>,
 <Hawking.Zhang@amd.com>, <Lijo.Lazar@amd.com>, Zhigang Luo
 <Zhigang.Luo@amd.com>, Zhigang Luo <zhigang.luo@amd.com>
Subject: [PATCH 3/7] Revert "drm/amdgpu: take the A+A VF GMC aperture from
 SRAT"
Date: Fri, 13 Nov 2026 09:56:58 -0500
Message-ID: <20261113145702.323968-3-Zhigang.Luo@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261113145702.323968-1-Zhigang.Luo@amd.com>
References: <20261113145702.323968-1-Zhigang.Luo@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY7PEPF000000F3:EE_|BL1PR12MB5801:EE_
X-MS-Office365-Filtering-Correlation-Id: 6c859ee4-8976-4349-1c07-08df41966fcb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|376014|1800799024|82310400026|23010399003|3023799007|261022075727099003|261021123027099003|261009223027099003|261021121427099003|261102123227099003|10067099003|11063799006|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 2sf7npMxEZ+9gBZWDvz+eIwRMUnstO4nY6SgnE+yQpr1ffo3NjRN7dtwkJLdfcJL5IjHc5Fp1tHVCh84WQQ5UUv9vtODA4m07cVQ4n6ad2UT3Mw/Q+IKQBOyRL5cP9t7x9UaF04JZdubwQtCZbxaU1W0By6UrwoGUnwCzGFlKawt9OowqL/w3Iuw9kOs4yUYRfIDKjXjj+Ce4rqhhJY3/H/cWxmqOzbH2D/XdstUZbLeTgJV+eEVDalvwm8eseHE2hMvALmgjYqtGWNrNR25kFXD2Udm/3LMaR7WeIU//UBYBuWvdUOsE3G7vf7VtNUBMw5/zO42vYf+ZM8z78vJWc7hrKcgUiNfwhOQL+LzhKNJuqLi6FPJLY0cD3yjN9p5NJmyN7h7bQHFHaTRZQc2rCffqA2XMV9gfvItC+6ECQ63UyMdH1LvgDNPKUUF5xe1dAlsbByoZ5STEAUacicl/AOj5hFpnvBAV4FtLS5TWgGPxF3K17qCpe1Hij9kJHZ7xSJoqItDzIr6JQjkEuTFGLnYvqV/hVqm91mxlihg+eG9mGEAUqGnHA4WNaAXgrc8uN1VFvqourgyOnVYdoapgLCXV+gYoBAywkfaeCXTUsFjTCDExuWyApYS53XcK3B+1fzFC7c6L+Zc7s5GVzkmSqJ68M0+9oj2iiCPYpt9gbDlP7rQjRlk1mhRJPw7kRGbQpK1pw8VJt4dXwfVDkjiVQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(376014)(1800799024)(82310400026)(23010399003)(3023799007)(261022075727099003)(261021123027099003)(261009223027099003)(261021121427099003)(261102123227099003)(10067099003)(11063799006)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: A1OgCWnabiocHh7D3YrhfId9C4jzGTjbRX7jngGP5rxe2BdDVxTBmWewZLHPwZgbEGi4EM/z2juTDhqmJrQFbkQqaMB48jtvTudmKK55Ui90ROOPujzEjJXwteo3M8xdPr7Mhzr7EXvKJa3/U1/SnSA7FJNqv/WSGikN3LrVcZfd3XlBSxohX/8KlH4z0q9kOGDC2IaebHkURVQC1mfEw65RlXMdCmjpLZvoFOQQThsCwA75gaItuNdjWZnUKRAkhIZx/ldmBtAiqE1OXtzLCcAXOKrMmqum5/nEoMkc4BMxQWGSvZJsWV2bh68o/O/ZUouqRdvcH2dwfE4FKdiUc1qMtyubn8eyUBEge4dHb2XfjPMZo85kuwTC7RDl8sxllm7WwsvqllpZJCanjlcgBoqRaJ4b0mX+vjAi7lnV4S22a0j9BQklv5TxVLpiCca5
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2026 14:57:28.5461 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c859ee4-8976-4349-1c07-08df41966fcb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY7PEPF000000F3.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5801
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

This reverts commit ea7147d613a0.

The aperture was copied into vram_base_offset and node_segment_size.
Those values are the sources, and the aperture is filled from them.
The last patch reads the SRAT address as the FB offset and the SRAT
length as the segment size. mc_init already copies that offset into
aper_base for a device connected to the CPU.

Signed-off-by: Zhigang Luo <zhigang.luo@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c    | 57 +++++------------------
 drivers/gpu/drm/amd/amdgpu/mmhub_v4_2_0.c |  5 +-
 2 files changed, 13 insertions(+), 49 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
index cd276a138e10..7e0b83b1015f 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
@@ -639,7 +639,6 @@ static void gmc_v12_0_set_gfxhub_funcs(struct amdgpu_device *adev)
 static int gmc_v12_0_early_init(struct amdgpu_ip_block *ip_block)
 {
 	struct amdgpu_device *adev = ip_block->adev;
-	int r;
 
 	if (adev->smuio.funcs &&
 	    adev->smuio.funcs->is_host_gpu_xgmi_supported)
@@ -662,18 +661,6 @@ static int gmc_v12_0_early_init(struct amdgpu_ip_block *ip_block)
 	gmc_v12_0_set_mmhub_funcs(adev);
 	gmc_v12_0_set_umc_funcs(adev);
 
-	if (amdgpu_virt_vram_is_spm(adev)) {
-		u64 aper_base, aper_size;
-
-		r = amdgpu_acpi_find_gpu_memory_in_srat(adev, &aper_base,
-							&aper_size);
-		if (r)
-			return r;
-
-		adev->gmc.aper_base = aper_base;
-		adev->gmc.aper_size = aper_size;
-	}
-
 	adev->gmc.shared_aperture_start = 0x2000000000000000ULL;
 	adev->gmc.shared_aperture_end =
 		adev->gmc.shared_aperture_start + (4ULL << 30) - 1;
@@ -720,19 +707,10 @@ static void gmc_v12_0_vram_gtt_location(struct amdgpu_device *adev,
 			amdgpu_gmc_agp_location(adev, mc);
 	}
 	/* base offset of vram pages */
-	if (amdgpu_virt_vram_is_spm(adev)) {
-		/*
-		 * For SPM-backed VRAM, PDB0 entries use PTE_SYSTEM, so the
-		 * address is a system physical address. vram_base_offset must
-		 * be aper_base so PDB0 maps GPU address 0 onto the HBM system
-		 * physical address.
-		 */
-		adev->vm_manager.vram_base_offset = adev->gmc.aper_base;
-	} else if (amdgpu_sriov_vf(adev)) {
+	if (amdgpu_sriov_vf(adev))
 		adev->vm_manager.vram_base_offset = 0;
-	} else {
+	else
 		adev->vm_manager.vram_base_offset = adev->mmhub.funcs->get_mc_fb_offset(adev);
-	}
 
 	adev->vm_manager.vram_base_offset +=
 		adev->gmc.xgmi.physical_node_id * adev->gmc.xgmi.node_segment_size;
@@ -769,28 +747,17 @@ static int gmc_v12_0_mc_init(struct amdgpu_device *adev)
 			return r;
 	}
 
+	adev->gmc.aper_base = pci_resource_start(adev->pdev, 0);
+	adev->gmc.aper_size = pci_resource_len(adev->pdev, 0);
+
 #ifdef CONFIG_X86_64
-	/*
-	 * SPM-backed devices resolve the aperture from SRAT during early_init.
-	 * For native A+A (non-VF) or APU, override aper_base using mmhub
-	 * offset. Otherwise derive the aperture from BAR 0.
-	 */
-	if (!amdgpu_virt_vram_is_spm(adev)) {
-		if (!amdgpu_sriov_vf(adev) &&
-		    (((adev->flags & AMD_IS_APU) &&
-		      !amdgpu_passthrough(adev)) ||
-		     adev->gmc.xgmi.connected_to_cpu)) {
-			adev->gmc.aper_base =
-				adev->mmhub.funcs->get_mc_fb_offset(adev) +
-				adev->gmc.xgmi.physical_node_id *
-				adev->gmc.xgmi.node_segment_size;
-			adev->gmc.aper_size = adev->gmc.real_vram_size;
-		} else {
-			adev->gmc.aper_base =
-				pci_resource_start(adev->pdev, 0);
-			adev->gmc.aper_size =
-				pci_resource_len(adev->pdev, 0);
-		}
+	if (((adev->flags & AMD_IS_APU) && !amdgpu_passthrough(adev)) ||
+	    (adev->gmc.xgmi.connected_to_cpu)) {
+		adev->gmc.aper_base =
+			adev->mmhub.funcs->get_mc_fb_offset(adev) +
+			adev->gmc.xgmi.physical_node_id *
+			adev->gmc.xgmi.node_segment_size;
+		adev->gmc.aper_size = adev->gmc.real_vram_size;
 	}
 #endif
 	/* In case the PCI BAR is larger than the actual amount of vram */
diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v4_2_0.c b/drivers/gpu/drm/amd/amdgpu/mmhub_v4_2_0.c
index 4c0a2d671cfc..4495d52b4b07 100644
--- a/drivers/gpu/drm/amd/amdgpu/mmhub_v4_2_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v4_2_0.c
@@ -154,10 +154,7 @@ static int mmhub_v4_2_0_get_xgmi_info(struct amdgpu_device *adev)
 	if (adev->gmc.xgmi.physical_node_id > max_physical_node_id)
 		return -EINVAL;
 
-	if (amdgpu_virt_vram_is_spm(adev) && adev->gmc.aper_size)
-		adev->gmc.xgmi.node_segment_size = adev->gmc.aper_size;
-	else
-		adev->gmc.xgmi.node_segment_size = seg_size;
+	adev->gmc.xgmi.node_segment_size = seg_size;
 
 	return 0;
 }
-- 
2.43.0

