Return-Path: <SRS0=Hz3R=5M=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 890CFC2D0E8
	for <amd-gfx@archiver.kernel.org>; Fri, 27 Mar 2020 19:38:23 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5FDEA20663
	for <amd-gfx@archiver.kernel.org>; Fri, 27 Mar 2020 19:38:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="m+YEVNor"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5FDEA20663
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A29226EA73;
	Fri, 27 Mar 2020 19:38:22 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2070.outbound.protection.outlook.com [40.107.223.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 51E7A6EA72
 for <amd-gfx@lists.freedesktop.org>; Fri, 27 Mar 2020 19:38:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Xf2D/y2+7V54WKyB3MRP2Nc8oqs3lhoVc0lUUqP+2oUemr4JoG4w9PDvlWRHxlVTxLYjj5PYI+j1NRfkuQOpGt8D1lCSKAhnRWvJOSAG6GfCVoVSoMIhi99zf1hWk5EcdMlz5gVMNcIlmvHKNzGQyFQrC+/DUBwdc+2rjfJAL6hqIHNpG6DKlNeM+R9fo4SC55UrYmcxrrN31gQkbnM4o//C8U/rqCdPVtzF68y1mH/eU6CZdTIyBFXNLz6Qf6T6ytkX/t2XFu2jsNqEsgVhYn/LbqoX7W+20ih0B8gBlz1omgiOz4YD7r/91F476u9bWwlKiiOVQGc/m0h09CJzDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=77Pzm0hYGTomdtQq51AZN9ezOHbWjg0eITrhOU55ELo=;
 b=H0nSvJ5WeFRqYBym/9J7X4gAkn9wS6wOgern+KOP7IOcT0a6rhSecz3yUVcBtdqt3WxoEsBQtyFbjyFB41rbIF5LdPJLsuj/R1EGwWSI/yM09WJ84bIP2/rbqVmbw+WSOxeOMjpqQUiiGAJk49rv7iUCDJtgixXApcxEUq4yQEuagyEOgDpwp6dQxgvymOCPEnP5I7PP90+c7UjgDw4Yrhlyf0CfAbDF8wbj0Npg8HcSs/FOcLY/H8QIvk+DDTrkH8BdzqHmBIQWsorqNYdeWFmhEJjR2f+0qpfVEwaogl5vsIh0buFhbVovbuPSo9KPKkwCFBRMsE6Fl1GOYVOzHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=77Pzm0hYGTomdtQq51AZN9ezOHbWjg0eITrhOU55ELo=;
 b=m+YEVNornuK0lPU0x9+3I9CNQeWBOk7iDAIQvbZxMZPglax+kz3kkywBL841IbxyZIUEOo2HazVbDhzv+A88tSSMShXwP6Ar666ls3btGYT/1lo8Fp59lFUF6axe8QdNQ4cQrkh6wGIaubgBnkwXLZZu3kxH3/PXgZVlj/Vxnho=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Alex.Sierra@amd.com; 
Received: from SA0PR12MB4576.namprd12.prod.outlook.com (2603:10b6:806:93::13)
 by SA0PR12MB4413.namprd12.prod.outlook.com (2603:10b6:806:9e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2835.20; Fri, 27 Mar
 2020 19:38:20 +0000
Received: from SA0PR12MB4576.namprd12.prod.outlook.com
 ([fe80::8d47:3ca5:5a7c:c047]) by SA0PR12MB4576.namprd12.prod.outlook.com
 ([fe80::8d47:3ca5:5a7c:c047%7]) with mapi id 15.20.2835.023; Fri, 27 Mar 2020
 19:38:20 +0000
From: Alex Sierra <alex.sierra@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 4/4] drm/amdgpu: replace ih ip block for vega20 and arcturus
Date: Fri, 27 Mar 2020 14:37:47 -0500
Message-Id: <20200327193747.8520-4-alex.sierra@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200327193747.8520-1-alex.sierra@amd.com>
References: <20200327193747.8520-1-alex.sierra@amd.com>
X-ClientProxiedBy: SN4PR0201CA0011.namprd02.prod.outlook.com
 (2603:10b6:803:2b::21) To SA0PR12MB4576.namprd12.prod.outlook.com
 (2603:10b6:806:93::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from alex-MS-7B09.amd.com (165.204.78.1) by
 SN4PR0201CA0011.namprd02.prod.outlook.com (2603:10b6:803:2b::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2856.18 via Frontend
 Transport; Fri, 27 Mar 2020 19:38:19 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [165.204.78.1]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 924e4abc-4f08-4262-3d73-08d7d286677c
X-MS-TrafficTypeDiagnostic: SA0PR12MB4413:|SA0PR12MB4413:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SA0PR12MB44132C1C7E59A7C4230F7F23FDCC0@SA0PR12MB4413.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:949;
X-Forefront-PRVS: 0355F3A3AE
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(39860400002)(396003)(366004)(346002)(376002)(136003)(4326008)(52116002)(316002)(7696005)(6486002)(2906002)(16526019)(8676002)(956004)(478600001)(44832011)(6916009)(186003)(66946007)(5660300002)(66476007)(81156014)(6666004)(8936002)(2616005)(26005)(36756003)(81166006)(66556008)(86362001)(1076003);
 DIR:OUT; SFP:1101; SCL:1; SRVR:SA0PR12MB4413;
 H:SA0PR12MB4576.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pvlGS9Ic6vVGBPKx7imTRXHmRRZHRPEtAW4VqEbEPaF79+nPR9em8vZfT6EUd+Q4zh14DKt1evzY49+/54PXlYhU7TaelUx1CFdOwIB2df9wqkySSMz9ZF3smYefFHNVxoGrYbHCZLn2haKhOxDP2xlKrZDrdJTKLj+4WO6x60Xbv3NV7JL0coj8n38JnwMvYIP6Q+bQYspd5USKhXR5dfEhImqsp3NpCuYOomUKPAto8KPRxHqRAAfZMTZw/AY7ZoxCxJ4JDbfcCCsfI86QZZurCijHJiMK0Uq9V1FI3c451SdtJ+25WsbPLMo9StnlFrWQrEnSRJ2BA63sn4xaBlcgkt75EFyogGsYCylOXQnCWFllOpOZL2eiSG2SssF4mBj20J96mYUM7XzaS2VOnT5HPP9279lmHnDmZF6ncc6Zp4Em0GMyStD4snVzorti
X-MS-Exchange-AntiSpam-MessageData: CP4BYqUUQyGW6ucsJ2to3OG2vlekZy41EGq2/+2INsubCg4EYrgFepLARaBJcHpJTAlCW0clIzDCIyw/REwazXugoiDvuQlrXkl/CqvUEQMjuobQCxJ3rjx1AnSFRmv1D8WLf6htKDE5ItUMfuA5jA==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 924e4abc-4f08-4262-3d73-08d7d286677c
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2020 19:38:20.0965 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2OoLaXVzBg9s1VvLbEQGvu9yEqE/iWti9+3grZ15rMPGMMPcS0qhV2NoziGhAHAmj2+DfAFggl/ZuORhFgKBLA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4413
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

[Why]
Vega20 and Arcturus asics use oss 5.0 version.

[How]
Replace ih ip block by navi10 for vega20 and arcturus.

Signed-off-by: Alex Sierra <alex.sierra@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/soc15.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/soc15.c b/drivers/gpu/drm/amd/amdgpu/soc15.c
index a8c90d83a9ee..9bd965e88bd9 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc15.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc15.c
@@ -62,6 +62,7 @@
 #include "nbio_v7_0.h"
 #include "nbio_v7_4.h"
 #include "vega10_ih.h"
+#include "navi10_ih.h"
 #include "sdma_v4_0.h"
 #include "uvd_v7_0.h"
 #include "vce_v4_0.h"
@@ -731,9 +732,15 @@ int soc15_set_ip_blocks(struct amdgpu_device *adev)
 				else
 					amdgpu_device_ip_block_add(adev, &psp_v3_1_ip_block);
 			}
-			amdgpu_device_ip_block_add(adev, &vega10_ih_ip_block);
+			if (adev->asic_type == CHIP_VEGA20)
+				amdgpu_device_ip_block_add(adev, &navi10_ih_ip_block);
+			else
+				amdgpu_device_ip_block_add(adev, &vega10_ih_ip_block);
 		} else {
-			amdgpu_device_ip_block_add(adev, &vega10_ih_ip_block);
+			if (adev->asic_type == CHIP_VEGA20)
+				amdgpu_device_ip_block_add(adev, &navi10_ih_ip_block);
+			else
+				amdgpu_device_ip_block_add(adev, &vega10_ih_ip_block);
 			if (likely(adev->firmware.load_type == AMDGPU_FW_LOAD_PSP)) {
 				if (adev->asic_type == CHIP_VEGA20)
 					amdgpu_device_ip_block_add(adev, &psp_v11_0_ip_block);
@@ -784,9 +791,9 @@ int soc15_set_ip_blocks(struct amdgpu_device *adev)
 		if (amdgpu_sriov_vf(adev)) {
 			if (likely(adev->firmware.load_type == AMDGPU_FW_LOAD_PSP))
 				amdgpu_device_ip_block_add(adev, &psp_v11_0_ip_block);
-			amdgpu_device_ip_block_add(adev, &vega10_ih_ip_block);
+			amdgpu_device_ip_block_add(adev, &navi10_ih_ip_block);
 		} else {
-			amdgpu_device_ip_block_add(adev, &vega10_ih_ip_block);
+			amdgpu_device_ip_block_add(adev, &navi10_ih_ip_block);
 			if (likely(adev->firmware.load_type == AMDGPU_FW_LOAD_PSP))
 				amdgpu_device_ip_block_add(adev, &psp_v11_0_ip_block);
 		}
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
