Return-Path: <SRS0=NxiI=D5=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A560C388F7
	for <amd-gfx@archiver.kernel.org>; Thu, 22 Oct 2020 03:43:23 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 751F02225D
	for <amd-gfx@archiver.kernel.org>; Thu, 22 Oct 2020 03:43:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="SfWop40x"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 751F02225D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E60316E185;
	Thu, 22 Oct 2020 03:43:21 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2055.outbound.protection.outlook.com [40.107.220.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 969376E185
 for <amd-gfx@lists.freedesktop.org>; Thu, 22 Oct 2020 03:43:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OL8kRX/qhvQU0kDOnivVQlOt+B9lSOY6R1f0po664Nu4pprPoO+sAOVG557ythCX+uK4rLaYqvJRi60L9I0oQ46F3bgjyN3yBzXjfU9/f0m2SC9k949usWTUTMLk75eu/b1SGabvR90NlYDrj88ET6HVfSzBlR+FzHdcTk21bfZq9Ini0E7NmMbVsUybRKMTBrdvXVhErzSS7d685hryMYsuKqcn2nByWDBO2pcrI07fixKCK1kE6barXTlfvzu81tHGsZAmIq/6coR724QS4hLC/c7Z1g5t7tVkkKYpxV37Gn3vytcsD2bdW2d7LnxfSOyyF0bvU0nqESGLmryOgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LZfeSyRfTgT3n2gKvFHxTVHUbDhYjgTVuVueWKyEC7w=;
 b=BIZnjX90zDo/W5FZkzi/GOEGG6SwVc2Kxtqtc6unFTuXnwo18sjIoFJgtfQq9igwP/lFEzleCjsKQiuE51+EJgnY6a3eJ1m/JbkaekdWHIsMH+20s/ms5lWBV/c5JQ3UlwejzugJOwv/QS8Q+VZ1fOxtZ/KgiGm//5JjN6Zb69vt7PHTchnI2PvAr23GL9NmkUkTrDJ3um1Jy6FomAQ1f75fJPPxNg4TFWQoVTI12joiv6tDHN8BaoVG62UQrqkU3H8tpOnFpBOLlj4GPTUo7l52vLVWEUYsQoWKM1rkXUuOcpJQ7DBgWbvmgeFWRz5gsCwAUlZG6kja0f/iV4jfpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=none action=none header.from=amd.com; dkim=none (message not signed);
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LZfeSyRfTgT3n2gKvFHxTVHUbDhYjgTVuVueWKyEC7w=;
 b=SfWop40xmDiM7Ffy49v+oMBsdZHj/K68GSOdOE8uaKBkXRmbY5hY/7hQzAE+trZCsgoF7Y9uwVt1PB1CZpvK/zfJcGj8hnnxBL6YpBsel6MtSHUzqqNffQ5zvpySoXL2k6o1d+p+5BPVu3yjtTRKFA3q7ved83dUjBMbZHHj8mc=
Received: from DM5PR19CA0055.namprd19.prod.outlook.com (2603:10b6:3:116::17)
 by BYAPR12MB3287.namprd12.prod.outlook.com (2603:10b6:a03:131::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.24; Thu, 22 Oct
 2020 03:43:18 +0000
Received: from DM6NAM11FT022.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:116:cafe::ed) by DM5PR19CA0055.outlook.office365.com
 (2603:10b6:3:116::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.18 via Frontend
 Transport; Thu, 22 Oct 2020 03:43:17 +0000
X-MS-Exchange-Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=none action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 DM6NAM11FT022.mail.protection.outlook.com (10.13.172.210) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3499.18 via Frontend Transport; Thu, 22 Oct 2020 03:43:17 +0000
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Wed, 21 Oct
 2020 22:43:16 -0500
Received: from rico-code.amd.com (10.180.168.240) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server id 15.1.1979.3 via Frontend
 Transport; Wed, 21 Oct 2020 22:43:14 -0500
From: Tianci Yin <tianci.yin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 2/2] drm/amdgpu: disable DCN and VCN for navi10 blockchain
 SKU(v3)
Date: Thu, 22 Oct 2020 11:43:09 +0800
Message-ID: <20201022034309.7568-2-tianci.yin@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201022034309.7568-1-tianci.yin@amd.com>
References: <20201022034309.7568-1-tianci.yin@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bac77d9d-44a6-4b47-d35e-08d8763c9d0d
X-MS-TrafficTypeDiagnostic: BYAPR12MB3287:
X-Microsoft-Antispam-PRVS: <BYAPR12MB328731D9CE16420A72E5FE98951D0@BYAPR12MB3287.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:328;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yh3+R5lMXuSAbZj0KVSjSMR3ab/1S3Wd1+bSsbl/0h7jUzVQfr5gGEqcW5xtZ3aPyMCUgQJP8wMwkbq2TNJbqM/P+EKLy6xNYB8GFjtMOV4rcwQ56oE/qsmjvdwVrumDj7m1y2QZZRva3Z5aCfbEB07VdAdc/GTGaj6onlWyvtmwxlm+G9hMmjkA3GEHQhO2UOtjElmL1oXUMRgLbncxes6bEKdguMjsSPTOPA6r0bkA7puW44xrFYVZ+BLfPtAsuoBmHXnK6o9VLF6J/6VqzFY7Eh167uOQugX3M6FKr+zWCvRTn6vqD07SQzuDfHmVl2K/GwfW9KUI5I9I5FZlG6CggoF1g1JmOKkisoN+yBb+j6pMjqQZILFoCb22fCqzwssqG4SDAnxQXN0a7cnXyg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB02.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(39860400002)(396003)(346002)(136003)(376002)(46966005)(83380400001)(44832011)(81166007)(54906003)(47076004)(82740400003)(478600001)(4326008)(1076003)(82310400003)(2616005)(70206006)(7696005)(6666004)(2906002)(26005)(86362001)(8676002)(6916009)(186003)(36756003)(8936002)(336012)(316002)(5660300002)(70586007)(426003)(356005);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2020 03:43:17.7060 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bac77d9d-44a6-4b47-d35e-08d8763c9d0d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT022.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3287
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
Cc: Long Gang <Gang.Long@amd.com>, Guchun
 Chen <guchun.chen@amd.com>, Feifei Xu <Feifei.Xu@amd.com>,
 Tianci Yin <tianci.yin@amd.com>, Tuikov Luben <Luben.Tuikov@amd.com>,
 Deucher Alexander <Alexander.Deucher@amd.com>, Flora Cui <flora.cui@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: "Tianci.Yin" <tianci.yin@amd.com>

The blockchain SKU has no display and video support, remove them.

Change-Id: I419cfae8b00125f3bff18c0a8cd92f3266d5f04a
Signed-off-by: Tianci.Yin <tianci.yin@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/nv.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/nv.c b/drivers/gpu/drm/amd/amdgpu/nv.c
index ce787489aaeb..26702c85caf8 100644
--- a/drivers/gpu/drm/amd/amdgpu/nv.c
+++ b/drivers/gpu/drm/amd/amdgpu/nv.c
@@ -497,6 +497,14 @@ void nv_set_virt_ops(struct amdgpu_device *adev)
 	adev->virt.ops = &xgpu_nv_virt_ops;
 }
 
+bool nv_is_blockchain_sku(struct pci_dev *pdev)
+{
+	if (pdev->device == 0x731E &&
+	    (pdev->revision == 0xC6 || pdev->revision == 0xC7))
+		return true;
+	return false;
+}
+
 int nv_set_ip_blocks(struct amdgpu_device *adev)
 {
 	int r;
@@ -530,7 +538,8 @@ int nv_set_ip_blocks(struct amdgpu_device *adev)
 		if (adev->enable_virtual_display || amdgpu_sriov_vf(adev))
 			amdgpu_device_ip_block_add(adev, &dce_virtual_ip_block);
 #if defined(CONFIG_DRM_AMD_DC)
-		else if (amdgpu_device_has_dc_support(adev))
+		else if (amdgpu_device_has_dc_support(adev) &&
+			 !nv_is_blockchain_sku(adev->pdev))
 			amdgpu_device_ip_block_add(adev, &dm_ip_block);
 #endif
 		amdgpu_device_ip_block_add(adev, &gfx_v10_0_ip_block);
@@ -538,7 +547,8 @@ int nv_set_ip_blocks(struct amdgpu_device *adev)
 		if (adev->firmware.load_type == AMDGPU_FW_LOAD_DIRECT &&
 		    !amdgpu_sriov_vf(adev))
 			amdgpu_device_ip_block_add(adev, &smu_v11_0_ip_block);
-		amdgpu_device_ip_block_add(adev, &vcn_v2_0_ip_block);
+		if (!nv_is_blockchain_sku(adev->pdev))
+			amdgpu_device_ip_block_add(adev, &vcn_v2_0_ip_block);
 		amdgpu_device_ip_block_add(adev, &jpeg_v2_0_ip_block);
 		if (adev->enable_mes)
 			amdgpu_device_ip_block_add(adev, &mes_v10_1_ip_block);
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
