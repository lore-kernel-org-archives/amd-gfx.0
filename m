Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 304DAC54E58
	for <amd-gfx@archiver.kernel.org>; Tue, 12 Mar 2024 17:51:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A350910E873;
	Tue, 12 Mar 2024 17:51:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="PrU4XCKt";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2045.outbound.protection.outlook.com [40.107.237.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D848F10E873
 for <amd-gfx@lists.freedesktop.org>; Tue, 12 Mar 2024 17:51:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=buTqsFA3qsnfpXfxUgasrXt/oq/oVQaSyFsZ3A6BlhGLc9qG16Q3tT5+hnFpOBS3c3jSA19E4lBW9MdqLFkL6T8uE40n18flq5rkqnxzyhJkJbzsp1AizNx9PO0bKfOZGYwvo4J+FTZUxJMkeqKS79rZWqDTyXTLmbgauktkJBOYUIa/niua5DnEflwCj/N3uMYtm2UMNTYd1TceykhssieXD+myl+OiSdU6vrImSQtJ+oZshYKx0wtvyH9VC336R7mRG+wB1q5ErSpx6UUE/wkqCYvJT8CESGDl88yYNbdUMYdof/A+sDHC1pnMhQfyUI1EDuS1xVxCkW0WenxyQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gx8mKHaO/zwfVKElcvQYGPypxT+WCI9ZSHO5fBgjKYM=;
 b=nqbDUz+ljYDGAdtFRfkX+WlC+YiP3toCVoe8PpX/NCZYCe8JzEQkL3diupNhy21UxipmES1a1hW3vlWgMwJyhiAXwCdmexO2+hasacUS9PzU43mTevHe2B3BWcwjCz8DWjA/fc1dH6//uReMviuexWpUK1iZaBhIXpcogv8bNNZP+4ZKaZ5rYM8gqvOV/ZW6uwYCCrBoID0AXn8753KwgikKxxANrlsUC37j0sLBLS7+ANzsd6MlrSK+0ZPu4/Um8lwy5kcNWqxFdX409FhVXVKiHxd6ktqFmS7aU4HyGdzO12p1+uMidleDl74hsbsaLnFiJuumxBSXz8XertJ9bA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gx8mKHaO/zwfVKElcvQYGPypxT+WCI9ZSHO5fBgjKYM=;
 b=PrU4XCKtHtUPGN4JkycI6UEgtNK+3hG09OKuO9OowGO+g4a0vC8kVr58QZUMhwAN+ny/s4t//KbKq9tLztCPa+iSF96SAMiYWwgI29Z5iqQNH7eRlh2a0aLWM8gqwy9i1qblEGgCsuIHRy/KcIFXklj3ZwY0T2GaB1bvZXqEzCE=
Received: from MN2PR12CA0029.namprd12.prod.outlook.com (2603:10b6:208:a8::42)
 by MW4PR12MB7214.namprd12.prod.outlook.com (2603:10b6:303:229::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.18; Tue, 12 Mar
 2024 17:51:22 +0000
Received: from BL6PEPF0001AB76.namprd02.prod.outlook.com
 (2603:10b6:208:a8:cafe::1e) by MN2PR12CA0029.outlook.office365.com
 (2603:10b6:208:a8::42) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.36 via Frontend
 Transport; Tue, 12 Mar 2024 17:51:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB76.mail.protection.outlook.com (10.167.242.169) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7386.12 via Frontend Transport; Tue, 12 Mar 2024 17:51:21 +0000
Received: from MKM-L1-VSKVORT2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 12 Mar
 2024 12:51:19 -0500
From: Victor Skvortsov <victor.skvortsov@amd.com>
To: <victor.skvortsov@amd.com>, <zhigang.luo@amd.com>,
 <amd-gfx@lists.freedesktop.org>
CC: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Subject: [PATCH] drm/amdgpu/: Remove bo_create_kernel_at path from virt page
Date: Tue, 12 Mar 2024 13:50:59 -0400
Message-ID: <20240312175059.141019-1-victor.skvortsov@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB76:EE_|MW4PR12MB7214:EE_
X-MS-Office365-Filtering-Correlation-Id: e9d253df-c126-4ee8-7b72-08dc42bd075f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nmdxMaYIdM7WbQkCKPKnud0SjsiQjUnqoePHG3SjWuYmnB/V7xxQ/se9GKQ/B82gMAKqcZHVbeeOeegiGTt7nnlb1G/W6h8JofADsoiYbY19zea91tM1a3G65F8nHKTU2eDTU1eBL3VAbsbYgOMmMTD6vyqPh9xdh3harIB2nir+UdYTtHpk2avZF+B2lKmQ85qGy3iEla/x05W/B+K5w1tNY0c7+OJB59a2nyq+oYynWdpqpMGigdX98Ooh5ARuUcCC/94I+RX0E9rQSN0vvWuiL5tBB+trXsRXQeg9yVrbffAbq+FGVQEoOjbbMsRaHh94XE9f0NvUzgEHDkBimJz75JspL+7bAqtJxLHAWRZoqNvKGdvrWyPbblrOFw1ohP4eqjGhFqFKseLOQyP28K0CgEORgKF2JNhArGPtMzuiA8FHoy2TtuHXSf5DQP3ojCKIvvzfeSY+RPoOjRdACzegQYkJNYTHRfnUWoLeC72VT8T6IdzrYn+L8k8WJYu8zjQXtW9BZyYkh8lJXnn44fL9qbLpIH9MHqGEdxNG5CvzPfDpEfS3SepRrb4nUuKNE9asGAU9/5Rlpke+ZCtfHF/VMxoKpGQZSlvwBkNWrw/xkw9kJt6byzElDP8D9ESf/PTM7nCtaNiHG1zy/aGxDMfwEXItsE1WFwmNv11YBRHePCKHTafG2a82mjOZiVm3r2mis2MQKlg4po0/EZbcKgYYpjvohaTsTJQmJw+C/rWWhJOMPKloHIJlTPTI72si
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(36860700004)(376005)(1800799015)(82310400014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2024 17:51:21.9249 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e9d253df-c126-4ee8-7b72-08dc42bd075f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB76.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7214
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

Use amdgpu_vram_mgr to reserve bad page ranges.
Reserved ranges will be freed by amdgpu_vram_mgr_fini()
Delete bo_create path as it is redundant.

Suggested-by: Christian König <christian.koenig@amd.com>
Signed-off-by: Victor Skvortsov <victor.skvortsov@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c | 55 ++----------------------
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h |  2 -
 2 files changed, 3 insertions(+), 54 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
index 7a4eae36778a..2a20714b9c16 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
@@ -244,7 +244,6 @@ static int amdgpu_virt_init_ras_err_handler_data(struct amdgpu_device *adev)
 	 */
 	unsigned int align_space = 512;
 	void *bps = NULL;
-	struct amdgpu_bo **bps_bo = NULL;
 
 	*data = kmalloc(sizeof(struct amdgpu_virt_ras_err_handler_data), GFP_KERNEL);
 	if (!*data)
@@ -254,12 +253,7 @@ static int amdgpu_virt_init_ras_err_handler_data(struct amdgpu_device *adev)
 	if (!bps)
 		goto bps_failure;
 
-	bps_bo = kmalloc_array(align_space, sizeof(*(*data)->bps_bo), GFP_KERNEL);
-	if (!bps_bo)
-		goto bps_bo_failure;
-
 	(*data)->bps = bps;
-	(*data)->bps_bo = bps_bo;
 	(*data)->count = 0;
 	(*data)->last_reserved = 0;
 
@@ -267,34 +261,12 @@ static int amdgpu_virt_init_ras_err_handler_data(struct amdgpu_device *adev)
 
 	return 0;
 
-bps_bo_failure:
-	kfree(bps);
 bps_failure:
 	kfree(*data);
 data_failure:
 	return -ENOMEM;
 }
 
-static void amdgpu_virt_ras_release_bp(struct amdgpu_device *adev)
-{
-	struct amdgpu_virt *virt = &adev->virt;
-	struct amdgpu_virt_ras_err_handler_data *data = virt->virt_eh_data;
-	struct amdgpu_bo *bo;
-	int i;
-
-	if (!data)
-		return;
-
-	for (i = data->last_reserved - 1; i >= 0; i--) {
-		bo = data->bps_bo[i];
-		if (bo) {
-			amdgpu_bo_free_kernel(&bo, NULL, NULL);
-			data->bps_bo[i] = bo;
-		}
-		data->last_reserved = i;
-	}
-}
-
 void amdgpu_virt_release_ras_err_handler_data(struct amdgpu_device *adev)
 {
 	struct amdgpu_virt *virt = &adev->virt;
@@ -305,10 +277,7 @@ void amdgpu_virt_release_ras_err_handler_data(struct amdgpu_device *adev)
 	if (!data)
 		return;
 
-	amdgpu_virt_ras_release_bp(adev);
-
 	kfree(data->bps);
-	kfree(data->bps_bo);
 	kfree(data);
 	virt->virt_eh_data = NULL;
 }
@@ -330,9 +299,6 @@ static void amdgpu_virt_ras_reserve_bps(struct amdgpu_device *adev)
 {
 	struct amdgpu_virt *virt = &adev->virt;
 	struct amdgpu_virt_ras_err_handler_data *data = virt->virt_eh_data;
-	struct amdgpu_vram_mgr *mgr = &adev->mman.vram_mgr;
-	struct ttm_resource_manager *man = &mgr->manager;
-	struct amdgpu_bo *bo = NULL;
 	uint64_t bp;
 	int i;
 
@@ -341,26 +307,11 @@ static void amdgpu_virt_ras_reserve_bps(struct amdgpu_device *adev)
 
 	for (i = data->last_reserved; i < data->count; i++) {
 		bp = data->bps[i].retired_page;
+		if (amdgpu_vram_mgr_reserve_range(&adev->mman.vram_mgr,
+			bp << AMDGPU_GPU_PAGE_SHIFT, AMDGPU_GPU_PAGE_SIZE))
+			DRM_DEBUG("RAS WARN: reserve vram for retired page %llx fail\n", bp);
 
-		/* There are two cases of reserve error should be ignored:
-		 * 1) a ras bad page has been allocated (used by someone);
-		 * 2) a ras bad page has been reserved (duplicate error injection
-		 *    for one page);
-		 */
-		if  (ttm_resource_manager_used(man)) {
-			amdgpu_vram_mgr_reserve_range(&adev->mman.vram_mgr,
-				bp << AMDGPU_GPU_PAGE_SHIFT,
-				AMDGPU_GPU_PAGE_SIZE);
-			data->bps_bo[i] = NULL;
-		} else {
-			if (amdgpu_bo_create_kernel_at(adev, bp << AMDGPU_GPU_PAGE_SHIFT,
-							AMDGPU_GPU_PAGE_SIZE,
-							&bo, NULL))
-				DRM_DEBUG("RAS WARN: reserve vram for retired page %llx fail\n", bp);
-			data->bps_bo[i] = bo;
-		}
 		data->last_reserved = i + 1;
-		bo = NULL;
 	}
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
index 3f59b7b5523f..15599951e7b8 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
@@ -224,8 +224,6 @@ struct amdgim_vf2pf_info_v2 {
 struct amdgpu_virt_ras_err_handler_data {
 	/* point to bad page records array */
 	struct eeprom_table_record *bps;
-	/* point to reserved bo array */
-	struct amdgpu_bo **bps_bo;
 	/* the count of entries */
 	int count;
 	/* last reserved entry's index + 1 */
-- 
2.25.1

