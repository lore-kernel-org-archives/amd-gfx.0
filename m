Return-Path: <SRS0=xvO7=5P=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82F5AC43331
	for <amd-gfx@archiver.kernel.org>; Mon, 30 Mar 2020 15:25:01 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3A4B420732
	for <amd-gfx@archiver.kernel.org>; Mon, 30 Mar 2020 15:25:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="a5s/nMwF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A4B420732
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E0C556E423;
	Mon, 30 Mar 2020 15:25:00 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2075.outbound.protection.outlook.com [40.107.243.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1536D6E424
 for <amd-gfx@lists.freedesktop.org>; Mon, 30 Mar 2020 15:24:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QcR7ChiAHmKe7Ro/hArnuSYdn+B6CDTjG0l6gfQ8Vfuy1Hb88nyKxGFQ07spEOGuUEhvLf/FHlIQvOrdBGlK7TzIlIXOZPtHwJW8SdhkTu+AYY0oqJXXor9g6fA+2LO9KJxvAViQBWwamfBlXSOMUQAGwk4KqdW4M+WQ6A0piRK8Rn4xKlm/UfYl9KDN8s5XL0sAfZYhdd6CQDrX3UUZryLTRAoCeQPm3lQi5xtdI+5U6oIXWy9YfxDI/BrROHELp2QNUI+i+vU7mp3zSJbUXCeE2HgEIW6uZyKX7eyUF7Ht9mWqIG/43eSvwKUfQhEzT6XZlZCeLg1WN9dYGnovAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FzrqIAIiZsnIrhmKrWyjjf4RCCSji0IA/cP9am9IYY8=;
 b=kY/pxLaoZDfjWbckaaO+zL8NhRTPS7hulasyWvkX2JFESIH1Xfjn5uVB/71wQZxYZtjx7xJUY+9vL6bOMNXWZqyL1GpUr4M5uYtIhrIG+LQzl7tq5wB/DhXv0g4J8cfjJxkCUzwlSqQn1n3NzoXpV67N0uo6h4c5fjzDsOxfJPT7gAe+LUKMBGAJmbJTvGA4WqC2ZY6cIhvZgDW2CUbCZ4AGigauKXXJdXAQ109BvHZdowdeR5DFLnWlnSwKD7If8Xlv0PIP41dwGJasdahl1WhChOAUNr6EpbnOeasUr/Gm1+z6VstsU7PtPj8nxzWi7Xt/3AAAJTsMOOhxJe95yQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FzrqIAIiZsnIrhmKrWyjjf4RCCSji0IA/cP9am9IYY8=;
 b=a5s/nMwFISLDumkoNXwZ22LUY08hcCxKn/wfDAmrQgGVzzaObbmvYdW1Hbnara9LGWicjsXKvI6VFNEpPiAQnOS3byuJIc+sq0mrPtyjPyozjAH3Ggr0xUtL9POXR1TnC87xv1APVDUE295Yb68rXa5oqy9by3qI8JjVt7kk+eE=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Alex.Sierra@amd.com; 
Received: from SA0PR12MB4576.namprd12.prod.outlook.com (2603:10b6:806:93::13)
 by SA0PR12MB4477.namprd12.prod.outlook.com (2603:10b6:806:92::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2856.20; Mon, 30 Mar
 2020 15:24:58 +0000
Received: from SA0PR12MB4576.namprd12.prod.outlook.com
 ([fe80::8d47:3ca5:5a7c:c047]) by SA0PR12MB4576.namprd12.prod.outlook.com
 ([fe80::8d47:3ca5:5a7c:c047%7]) with mapi id 15.20.2856.019; Mon, 30 Mar 2020
 15:24:58 +0000
From: Alex Sierra <alex.sierra@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] Revert "drm/amdgpu: replace ih ip block for vega20 and
 arcturus"
Date: Mon, 30 Mar 2020 10:24:36 -0500
Message-Id: <20200330152436.19095-1-alex.sierra@amd.com>
X-Mailer: git-send-email 2.17.1
X-ClientProxiedBy: DM6PR07CA0067.namprd07.prod.outlook.com
 (2603:10b6:5:74::44) To SA0PR12MB4576.namprd12.prod.outlook.com
 (2603:10b6:806:93::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from alex-MS-7B09.amd.com (165.204.78.1) by
 DM6PR07CA0067.namprd07.prod.outlook.com (2603:10b6:5:74::44) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2856.20 via Frontend Transport; Mon, 30 Mar 2020 15:24:57 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [165.204.78.1]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 67871b47-52a7-4211-d1ba-08d7d4be8194
X-MS-TrafficTypeDiagnostic: SA0PR12MB4477:|SA0PR12MB4477:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SA0PR12MB447730DADCABFDB1B4743A2BFDCB0@SA0PR12MB4477.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:214;
X-Forefront-PRVS: 0358535363
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA0PR12MB4576.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10009020)(4636009)(376002)(366004)(396003)(39860400002)(136003)(346002)(36756003)(316002)(5660300002)(16526019)(186003)(6486002)(26005)(6916009)(6666004)(8936002)(7696005)(52116002)(66556008)(66476007)(86362001)(66946007)(478600001)(1076003)(4326008)(44832011)(81166006)(8676002)(2616005)(956004)(2906002)(81156014);
 DIR:OUT; SFP:1101; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UawGINTiru6hs6OibGTP9wEug/OYnTzFjFK/nHiILLUD34uMD6xVWo+njIKNTDIdh45Om/JzZ5RAEQctkJ7MnZu6FRH6Q6GmlqHRaAZkCm6m2lTe4ajjRzT+2nt8Oi3L6HdJGU5rfmkfToizXfknzO3DRTiXTP0sDEMS54uSy8XiV5lbzeExQ80Wi1e7ZgEKqdMM/pcTTEVAJts1flcwO7HalC2RzAHrhHMCGdJIghOi2TiomuADG70KHZMKEe4kOFcxhcu9J7+WoujOGT3OvdZv8VEcENpRb0NcySM7bpYwx7a3v054NEl8bv6uP0wIqku/kQjKKGKwXhyz/oNFraQPqyYCTKcU325SHwYepNhDiE2dKvnACe9ysaPL9kYvN77AeJYOC20lZ9ZBlQZynSKMLyLs8IaBNMmPSibYKEi/UZBcN+i59c3Q4XVqzQHE
X-MS-Exchange-AntiSpam-MessageData: bIte5BHBAOF7asLowM9AgL9OPbCVe2nlFaWTMmCGIkStgp8SZTBmIXspmn4cTNnUsAVzi6Qp/yTFUqqvX3C2+dy9qxvW1LGhpDfiHb+hQ6TNjb9iIRiMowqNz+CYjYL810VGvioSD1djLwreA+SIzw==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 67871b47-52a7-4211-d1ba-08d7d4be8194
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2020 15:24:58.0845 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hBvxB1SxrDnnQtT5wn7u/JewY7Onhq+GhLT3I2FXnvbojWaKdZJaxL/IV8H/cC8/4XdN1GoUrg8Smrq8kWhjTw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4477
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
Cc: Alex Sierra <alex.sierra@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This reverts commit 6237cb9febd7d61780d281e7141e12462c81cfb8.
Due to Loading driver failed at "*ERROR* ring sdma0 test failed" issue:
SWDEV-229211
---
 drivers/gpu/drm/amd/amdgpu/soc15.c | 15 ++++-----------
 1 file changed, 4 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/soc15.c b/drivers/gpu/drm/amd/amdgpu/soc15.c
index 9bd965e88bd9..a8c90d83a9ee 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc15.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc15.c
@@ -62,7 +62,6 @@
 #include "nbio_v7_0.h"
 #include "nbio_v7_4.h"
 #include "vega10_ih.h"
-#include "navi10_ih.h"
 #include "sdma_v4_0.h"
 #include "uvd_v7_0.h"
 #include "vce_v4_0.h"
@@ -732,15 +731,9 @@ int soc15_set_ip_blocks(struct amdgpu_device *adev)
 				else
 					amdgpu_device_ip_block_add(adev, &psp_v3_1_ip_block);
 			}
-			if (adev->asic_type == CHIP_VEGA20)
-				amdgpu_device_ip_block_add(adev, &navi10_ih_ip_block);
-			else
-				amdgpu_device_ip_block_add(adev, &vega10_ih_ip_block);
+			amdgpu_device_ip_block_add(adev, &vega10_ih_ip_block);
 		} else {
-			if (adev->asic_type == CHIP_VEGA20)
-				amdgpu_device_ip_block_add(adev, &navi10_ih_ip_block);
-			else
-				amdgpu_device_ip_block_add(adev, &vega10_ih_ip_block);
+			amdgpu_device_ip_block_add(adev, &vega10_ih_ip_block);
 			if (likely(adev->firmware.load_type == AMDGPU_FW_LOAD_PSP)) {
 				if (adev->asic_type == CHIP_VEGA20)
 					amdgpu_device_ip_block_add(adev, &psp_v11_0_ip_block);
@@ -791,9 +784,9 @@ int soc15_set_ip_blocks(struct amdgpu_device *adev)
 		if (amdgpu_sriov_vf(adev)) {
 			if (likely(adev->firmware.load_type == AMDGPU_FW_LOAD_PSP))
 				amdgpu_device_ip_block_add(adev, &psp_v11_0_ip_block);
-			amdgpu_device_ip_block_add(adev, &navi10_ih_ip_block);
+			amdgpu_device_ip_block_add(adev, &vega10_ih_ip_block);
 		} else {
-			amdgpu_device_ip_block_add(adev, &navi10_ih_ip_block);
+			amdgpu_device_ip_block_add(adev, &vega10_ih_ip_block);
 			if (likely(adev->firmware.load_type == AMDGPU_FW_LOAD_PSP))
 				amdgpu_device_ip_block_add(adev, &psp_v11_0_ip_block);
 		}
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
