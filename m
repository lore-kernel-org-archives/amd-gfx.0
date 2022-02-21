Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49BA5C433F5
	for <amd-gfx@archiver.kernel.org>; Mon, 21 Feb 2022 22:29:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8E0B710E498;
	Mon, 21 Feb 2022 22:29:50 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2081.outbound.protection.outlook.com [40.107.94.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AE99F10E498
 for <amd-gfx@lists.freedesktop.org>; Mon, 21 Feb 2022 22:29:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bgoENLXOLmLNLULqjrKPbyikCv9T6QgTOQioQqCd5UZLTWaahGdFcrlURqT7TcQzZGlMVu9DM1kPnGlQ0IcJNHrJSb8oJTnj4AwfeD5UtbNgPjkgwjYK03uHhOM3kX3x6EkdFwWTV8n04XVe86qRMoMuaXReM0GBZfcHSFVnzbXdr3RkaSkxb5sujRKgeTLhLZa/dVdmAZVG2WhCqgmROPow4Iv/pBkHrDHd5fDZ1/O7WTz0K1R9JboE/iG1pGKrxSTrJP2RQFpyDoHFmEW8YOkwD29Gd/ypml2UszqKsbJJbeaSp6k9tHRfb2VJbTak/h2lReHGoDi1f/4lMD2xPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IVU/x10bXd+RUarY6vaaSq4RgqaW4NEylKOi8JtTH1Q=;
 b=cxQG7otfVPqKi1+A4dFONi+kfr8D1GqMdThdg5hOloWfmRHQnKu0le5N8/LlP0nqaafRF8Ua/Dnqntjj0rRa39YtuPlwO5OKiiJAXkHjpoWE6JXSJMV5RvQjBOnIOZ7TLy772mMoCCu007juwLykcD+VX05zX9iwDzyhp+zGqNEN1mSY3zYAITSdfSPy2XS5TzM3ms3gUqJyM2bGwoD4t3WCOKAcydkURNiM6rDVDwIw28yHXxM5ZZjBbLJEzEKv/i6yl7RzmZzdO5lYy3T5Snyz/mrNuiHm1f3F6aw6rZ5FM+k6wK56zbebTeTQRM3LyvS2aJhqNpQxmfjBmgsCiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IVU/x10bXd+RUarY6vaaSq4RgqaW4NEylKOi8JtTH1Q=;
 b=FnWn3zNbkio0FnO7N5HUInGN+K1IhkNTCGDm229+18OH2jDU7KnJmD+0Ah8V9vTvGrjnQqH3Q31HXt1aAfj8TuF+4rb3UT3G+jV0d59WazymvthrwLQhhyd+Yw/378xst1HrvjbQwYZ7wV1H8+hHhS2iQyzKX1q8Y+5Ao4wadkI=
Received: from MW4PR04CA0362.namprd04.prod.outlook.com (2603:10b6:303:81::7)
 by DM6PR12MB2985.namprd12.prod.outlook.com (2603:10b6:5:116::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.24; Mon, 21 Feb
 2022 22:29:43 +0000
Received: from CO1NAM11FT005.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:81:cafe::b0) by MW4PR04CA0362.outlook.office365.com
 (2603:10b6:303:81::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.19 via Frontend
 Transport; Mon, 21 Feb 2022 22:29:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT005.mail.protection.outlook.com (10.13.174.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4995.20 via Frontend Transport; Mon, 21 Feb 2022 22:29:42 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Mon, 21 Feb
 2022 16:29:41 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu/test: convert amdgpu_test.c to use dev_info
Date: Mon, 21 Feb 2022 17:29:22 -0500
Message-ID: <20220221222922.5655-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0f65364b-2a49-4299-ad2e-08d9f589a822
X-MS-TrafficTypeDiagnostic: DM6PR12MB2985:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB2985673BD1DB6A7C756C42EFF73A9@DM6PR12MB2985.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RkzBAsbupC8tZK3el+SSgEHKsTAoDACrLKdm1krylL1H9qY2ZZzovPNzux8vzk7ORlLrPmhPhtIdP7qiq5Kum3y5eIGd668g/+04SWGFlC3RDBoeUPusYiq2IORt2gvP8CVlNzU8Oqc2ybBicPIFrzNQDIr/t9yFfSRlFvJnknFma/Z6srutV9ilh9QsVyr6iXIS6M2+LScyFggEchjnLpdR0FUxxez87oFkH5P2YXuJHFJfdhaPafmZIVgHCMCheo261kOOjIGPElyyq+DpjT3T8cXpaMBpIiu11MRE5bk5551LaqOuSWHiFtB6dlG/+sYuc16Nde0syft0p9TNaKP/o06CyhhebFyZea+S3F04LGb+NyQXXXNT+fICjx+vP48L8B+6uH0Z4SzmKmOo138xi66gX4FMxM1/1CHMoc9/Nwj9OFlz58wm6UAjMCEBTWhtBixFSNnITVu43Pu6PDUpDWYlxWeh2x3qqFadDtXqeKCDpDK+gRvno/V0kuEcVvOtIa2u4TJoDXt+t80cF2p83PHbJYitcfjVbVswpz1weuMn6dq76+sknReSPxGdPyMpnertSGqpethb0GD8eHsWF24+HuBA6ojMPKJW29OCQyqBdnVOQWOuPkf7Bhjn7Lsgbrjc5g5l9I9UuLWmEfy8eJYU5+/FlkNP0Hj0fxegh4hJxc8g8kr0nd6RuLTOSgTNQpq/ZmOND2QfOE8pZw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(40470700004)(36840700001)(46966006)(4326008)(426003)(47076005)(336012)(83380400001)(36756003)(40460700003)(5660300002)(2906002)(8936002)(26005)(6916009)(2616005)(1076003)(36860700001)(186003)(70206006)(70586007)(16526019)(7696005)(81166007)(356005)(508600001)(316002)(6666004)(86362001)(8676002)(82310400004)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2022 22:29:42.7618 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f65364b-2a49-4299-ad2e-08d9f589a822
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT005.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2985
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
Cc: Alex Deucher <alexander.deucher@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Rather than the old DRM_INFO/ERROR macros.  This makes it
easier to differentiate the output when there are multiple
GPUs in a system.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_test.c | 69 ++++++++++++------------
 1 file changed, 35 insertions(+), 34 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_test.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_test.c
index 909d830b513e..2c212b740a17 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_test.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_test.c
@@ -51,7 +51,7 @@ static void amdgpu_do_test_moves(struct amdgpu_device *adev)
 
 	gtt_obj = kcalloc(n, sizeof(*gtt_obj), GFP_KERNEL);
 	if (!gtt_obj) {
-		DRM_ERROR("Failed to allocate %d pointers\n", n);
+		dev_info(adev->dev, "Failed to allocate %d pointers\n", n);
 		r = 1;
 		goto out_cleanup;
 	}
@@ -66,7 +66,7 @@ static void amdgpu_do_test_moves(struct amdgpu_device *adev)
 
 	r = amdgpu_bo_create(adev, &bp, &vram_obj);
 	if (r) {
-		DRM_ERROR("Failed to create VRAM object\n");
+		dev_info(adev->dev, "Failed to create VRAM object\n");
 		goto out_cleanup;
 	}
 	r = amdgpu_bo_reserve(vram_obj, false);
@@ -74,7 +74,7 @@ static void amdgpu_do_test_moves(struct amdgpu_device *adev)
 		goto out_unref;
 	r = amdgpu_bo_pin(vram_obj, AMDGPU_GEM_DOMAIN_VRAM);
 	if (r) {
-		DRM_ERROR("Failed to pin VRAM object\n");
+		dev_info(adev->dev, "Failed to pin VRAM object\n");
 		goto out_unres;
 	}
 	vram_addr = amdgpu_bo_gpu_offset(vram_obj);
@@ -87,7 +87,7 @@ static void amdgpu_do_test_moves(struct amdgpu_device *adev)
 		bp.domain = AMDGPU_GEM_DOMAIN_GTT;
 		r = amdgpu_bo_create(adev, &bp, gtt_obj + i);
 		if (r) {
-			DRM_ERROR("Failed to create GTT object %d\n", i);
+			dev_info(adev->dev, "Failed to create GTT object %d\n", i);
 			goto out_lclean;
 		}
 
@@ -96,19 +96,19 @@ static void amdgpu_do_test_moves(struct amdgpu_device *adev)
 			goto out_lclean_unref;
 		r = amdgpu_bo_pin(gtt_obj[i], AMDGPU_GEM_DOMAIN_GTT);
 		if (r) {
-			DRM_ERROR("Failed to pin GTT object %d\n", i);
+			dev_info(adev->dev, "Failed to pin GTT object %d\n", i);
 			goto out_lclean_unres;
 		}
 		r = amdgpu_ttm_alloc_gart(&gtt_obj[i]->tbo);
 		if (r) {
-			DRM_ERROR("%p bind failed\n", gtt_obj[i]);
+			dev_info(adev->dev, "%p bind failed\n", gtt_obj[i]);
 			goto out_lclean_unpin;
 		}
 		gart_addr = amdgpu_bo_gpu_offset(gtt_obj[i]);
 
 		r = amdgpu_bo_kmap(gtt_obj[i], &gtt_map);
 		if (r) {
-			DRM_ERROR("Failed to map GTT object %d\n", i);
+			dev_info(adev->dev, "Failed to map GTT object %d\n", i);
 			goto out_lclean_unpin;
 		}
 
@@ -123,13 +123,13 @@ static void amdgpu_do_test_moves(struct amdgpu_device *adev)
 				       size, NULL, &fence, false, false, false);
 
 		if (r) {
-			DRM_ERROR("Failed GTT->VRAM copy %d\n", i);
+			dev_info(adev->dev, "Failed GTT->VRAM copy %d\n", i);
 			goto out_lclean_unpin;
 		}
 
 		r = dma_fence_wait(fence, false);
 		if (r) {
-			DRM_ERROR("Failed to wait for GTT->VRAM fence %d\n", i);
+			dev_info(adev->dev, "Failed to wait for GTT->VRAM fence %d\n", i);
 			goto out_lclean_unpin;
 		}
 
@@ -138,7 +138,7 @@ static void amdgpu_do_test_moves(struct amdgpu_device *adev)
 
 		r = amdgpu_bo_kmap(vram_obj, &vram_map);
 		if (r) {
-			DRM_ERROR("Failed to map VRAM object after copy %d\n", i);
+			dev_info(adev->dev, "Failed to map VRAM object after copy %d\n", i);
 			goto out_lclean_unpin;
 		}
 
@@ -147,16 +147,16 @@ static void amdgpu_do_test_moves(struct amdgpu_device *adev)
 		     vram_start < vram_end;
 		     gart_start++, vram_start++) {
 			if (*vram_start != gart_start) {
-				DRM_ERROR("Incorrect GTT->VRAM copy %d: Got 0x%p, "
-					  "expected 0x%p (GTT/VRAM offset "
-					  "0x%16llx/0x%16llx)\n",
-					  i, *vram_start, gart_start,
-					  (unsigned long long)
-					  (gart_addr - adev->gmc.gart_start +
-					   (void *)gart_start - gtt_map),
-					  (unsigned long long)
-					  (vram_addr - adev->gmc.vram_start +
-					   (void *)gart_start - gtt_map));
+				dev_info(adev->dev, "Incorrect GTT->VRAM copy %d: Got 0x%p, "
+					 "expected 0x%p (GTT/VRAM offset "
+					 "0x%16llx/0x%16llx)\n",
+					 i, *vram_start, gart_start,
+					 (unsigned long long)
+					 (gart_addr - adev->gmc.gart_start +
+					  (void *)gart_start - gtt_map),
+					 (unsigned long long)
+					 (vram_addr - adev->gmc.vram_start +
+					  (void *)gart_start - gtt_map));
 				amdgpu_bo_kunmap(vram_obj);
 				goto out_lclean_unpin;
 			}
@@ -169,13 +169,13 @@ static void amdgpu_do_test_moves(struct amdgpu_device *adev)
 				       size, NULL, &fence, false, false, false);
 
 		if (r) {
-			DRM_ERROR("Failed VRAM->GTT copy %d\n", i);
+			dev_info(adev->dev, "Failed VRAM->GTT copy %d\n", i);
 			goto out_lclean_unpin;
 		}
 
 		r = dma_fence_wait(fence, false);
 		if (r) {
-			DRM_ERROR("Failed to wait for VRAM->GTT fence %d\n", i);
+			dev_info(adev->dev, "Failed to wait for VRAM->GTT fence %d\n", i);
 			goto out_lclean_unpin;
 		}
 
@@ -184,7 +184,7 @@ static void amdgpu_do_test_moves(struct amdgpu_device *adev)
 
 		r = amdgpu_bo_kmap(gtt_obj[i], &gtt_map);
 		if (r) {
-			DRM_ERROR("Failed to map GTT object after copy %d\n", i);
+			dev_info(adev->dev, "Failed to map GTT object after copy %d\n", i);
 			goto out_lclean_unpin;
 		}
 
@@ -193,16 +193,16 @@ static void amdgpu_do_test_moves(struct amdgpu_device *adev)
 		     gart_start < gart_end;
 		     gart_start++, vram_start++) {
 			if (*gart_start != vram_start) {
-				DRM_ERROR("Incorrect VRAM->GTT copy %d: Got 0x%p, "
-					  "expected 0x%p (VRAM/GTT offset "
-					  "0x%16llx/0x%16llx)\n",
-					  i, *gart_start, vram_start,
-					  (unsigned long long)
-					  (vram_addr - adev->gmc.vram_start +
-					   (void *)vram_start - vram_map),
-					  (unsigned long long)
-					  (gart_addr - adev->gmc.gart_start +
-					   (void *)vram_start - vram_map));
+				dev_info(adev->dev, "Incorrect VRAM->GTT copy %d: Got 0x%p, "
+					 "expected 0x%p (VRAM/GTT offset "
+					 "0x%16llx/0x%16llx)\n",
+					 i, *gart_start, vram_start,
+					 (unsigned long long)
+					 (vram_addr - adev->gmc.vram_start +
+					  (void *)vram_start - vram_map),
+					 (unsigned long long)
+					 (gart_addr - adev->gmc.gart_start +
+					  (void *)vram_start - vram_map));
 				amdgpu_bo_kunmap(gtt_obj[i]);
 				goto out_lclean_unpin;
 			}
@@ -210,7 +210,8 @@ static void amdgpu_do_test_moves(struct amdgpu_device *adev)
 
 		amdgpu_bo_kunmap(gtt_obj[i]);
 
-		DRM_INFO("Tested GTT->VRAM and VRAM->GTT copy for GTT offset 0x%llx\n",
+		dev_info(adev->dev,
+			 "Tested GTT->VRAM and VRAM->GTT copy for GTT offset 0x%llx\n",
 			 gart_addr - adev->gmc.gart_start);
 		continue;
 
-- 
2.35.1

