Return-Path: <SRS0=IWiu=JT=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB014C433ED
	for <amd-gfx@archiver.kernel.org>; Thu, 22 Apr 2021 15:40:46 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 90F0C613F6
	for <amd-gfx@archiver.kernel.org>; Thu, 22 Apr 2021 15:40:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 90F0C613F6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 32C616E342;
	Thu, 22 Apr 2021 15:40:46 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2069.outbound.protection.outlook.com [40.107.93.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 10B696E2F2
 for <amd-gfx@lists.freedesktop.org>; Thu, 22 Apr 2021 15:40:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kfVGYHxrO3WrLXChOxCmjI/gxFLzBd4N1zgEIootbRMigfPoN8FWSUKLTL17V7fIkteP4TdQcFETtqjxlfoi+ghYyM6VD8yqgggnGJokSJ2oHLqO1hkya6qGd4SbYQuUCUORL9OkP/eKv1+C0dp7JnvwhBuMUMpqFPPjUTw+QgNPLjl6sn8dJ3sdZsW7uSVrqofcBUpqCm9bw5kJLCpjKXgIL/ZrGS1gRI663gbL37q9M7tsZJenbR8ULq+VXq8PfQ3HyDSFCDVf2n+VzPrfmpkimsdNvnu1ATP4jCKlP1eWC2t0oKf5Heda+Y/0//+Ecb3Xq5FLc+mNvSEbqBXgBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RuYFio0hvnQSi3Uwt+tGXVz5b1TrAzvGuNI3Nr44Vu4=;
 b=G3aojig2Wn7lzFsvYsJtRqoUmIs2onYDb1Dno4UzaDVFdAi4mLGuTIcfHh1geSaWNDX+JnQHkFqrqgG5oEO0/eOn/AQ3NtqvN0DoI07TVOTQDaB4yX8tGG6rcmqTDkuEL6kOM6OpwGlvbxP8j7HCnPoabeiJfH/IZZ7nZuqvnqsNcfjEBfBYaphQuf/BDtC97bpldIytBIDnFjkGVskKHWZc9L2Kk3NPqLgEdvg5cAFt2Vt4jdaVFo3h+E+My7vqhxOw2PCl7HlQ5WdkBe+WKyFS+epcShlD3aUJGVMpgL8uWHHuoLAUhUyWYpaBqPtvxx91eelc0Bao9sf9sF9+Kg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RuYFio0hvnQSi3Uwt+tGXVz5b1TrAzvGuNI3Nr44Vu4=;
 b=4RFitfzEclAK2czgNeeN8+KvCE9iV6Mrq2XFVSNUnt/2P5gD2vtWR2P8Jc5QDGj6MIMG0EjtHHQB3vcoXx8I7vufz7Y4nohziBLPAcBCYkfeJpMaX7pt7ftQKAMJ4wiGEZ+dj2c3BgoAy7AJzWmiT8fiIpyTO7jPrTniG+pKqSI=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from CY4PR12MB1463.namprd12.prod.outlook.com (2603:10b6:910:e::19)
 by CY4PR12MB1173.namprd12.prod.outlook.com (2603:10b6:903:41::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.20; Thu, 22 Apr
 2021 15:40:42 +0000
Received: from CY4PR12MB1463.namprd12.prod.outlook.com
 ([fe80::a457:1047:3886:4630]) by CY4PR12MB1463.namprd12.prod.outlook.com
 ([fe80::a457:1047:3886:4630%9]) with mapi id 15.20.4065.022; Thu, 22 Apr 2021
 15:40:42 +0000
From: Nirmoy Das <nirmoy.das@amd.com>
To: Christian.Koenig@amd.com
Subject: [PATCH 6/6] drm/amdgpu: remove AMDGPU_GEM_CREATE_SHADOW flag
Date: Thu, 22 Apr 2021 17:40:03 +0200
Message-Id: <20210422154003.4048-6-nirmoy.das@amd.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210422154003.4048-1-nirmoy.das@amd.com>
References: <20210422154003.4048-1-nirmoy.das@amd.com>
X-Originating-IP: [217.86.127.111]
X-ClientProxiedBy: PR3P189CA0083.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:102:b4::28) To CY4PR12MB1463.namprd12.prod.outlook.com
 (2603:10b6:910:e::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from linux.fritz.box (217.86.127.111) by
 PR3P189CA0083.EURP189.PROD.OUTLOOK.COM (2603:10a6:102:b4::28) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4065.22 via Frontend Transport; Thu, 22 Apr 2021 15:40:41 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5358d4a5-416b-4ec7-93f6-08d905a4fcd1
X-MS-TrafficTypeDiagnostic: CY4PR12MB1173:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CY4PR12MB117342D494C693B1899C17B18B469@CY4PR12MB1173.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: S0RNnId44Myo8tbbxgImHHJUJBA7F+ty3dItPXzssPdH4grZd9aHeh07dLjuQ9KMS7VEX699F+2ZIE1UqqOk+xpAKuoIGTPFNoK0hkOF+66UKgGExLoexrOeTewKrAZeKtriLvEg2bCnNO44igecbdPZ4tSsXuIq/qvTIV4x5/GV2mODkjlOauZN7LTTcD+h6zHk4U7qvgymoddC7Uz72CnQDfrklrM0NYZFLhWcshSNhpjzr/TGMAjsmJ+kPun4BTfptPwd45rF/MpZ4IUOLkA8cBlbGBlBFa2H9mT42rXSs1F1WFOY/5F1kCTXHK9cbN4HdsD7CJZVla42v8KyjI//9Nf4uTHNyVwdKw5H4Dnem8TjPNtV2khUk54FCn0SA22H1cYi+W20rkMUbboh4Eolvd2jWaODFJ0mCb4uAyzlLoj2yRAsrW8gUeS4Z4XrGDt0ZheBNkcTJKrPrmoZ9RvSw0ZZAtPADmbIQFHJfP3D8yfsT1BpIvoH0DmF2z1xoqz1A4T0siyGKCHa4NLTQ6N4Ebk1SHjLWNNUe+k2GXxUc18SZ+tYshYZ+o6nG4/xn9sNGsv6VTZP02CF2lDPMnOhwpeObDvRtK4AOxolqaZewSfNhxFargukpO9AMdfiUJnCQaydOPSg/k+u+JPYeRhwHILURSvyz8dMHib2GrY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY4PR12MB1463.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(376002)(366004)(346002)(136003)(39860400002)(83380400001)(38350700002)(2906002)(38100700002)(8936002)(34206002)(6636002)(66946007)(86362001)(66476007)(66556008)(6512007)(316002)(26005)(44832011)(4326008)(6486002)(1076003)(37006003)(186003)(478600001)(52116002)(6666004)(8676002)(956004)(16526019)(2616005)(36756003)(6506007)(5660300002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?7yIKEbnwp00dBlWPezTIDxWhU8D3ynwGFusnj019CyB0JLI1E++DU9rmsfTa?=
 =?us-ascii?Q?wSsSnxpzfVEjQVJEH0De/95m9o8zOBTEgUn9metTibfi8hsS/p/XMrsBO4PJ?=
 =?us-ascii?Q?skIx5+kV+0rFW2UJjX5EQC9MfmjWZA3V+fSvNvVdLQ9TE4ETU4OY14fdgWd6?=
 =?us-ascii?Q?Xdy/REbM3x73T/2cnurqUjtVT/9odO1elmmpOyPzVi0j8W61nGFhEmN+9fmP?=
 =?us-ascii?Q?b94wy/nXUjL/6Bn4hMh/Scav7RVmblxbAStkaXlKuZzfM+Lqvv6XiDlMIWFL?=
 =?us-ascii?Q?s6ghAgOxD4++EqiP30MVMPuNeTjj/kcQTfzhlniDAlmvlv82M4fbu9REvMuz?=
 =?us-ascii?Q?C2t1mt5JsbDFYQWMkKBwOdr3zYSvjClZlCPHjUePWgz7ZW+8IBd4L8IKUEQa?=
 =?us-ascii?Q?FMIU02Vxg9KPBbXlNYsiq9L5VciyeO3vvMnZtkegp5RDP2ukpRKCatvrJwpp?=
 =?us-ascii?Q?E0JYOK4hvqG9Q+Nx9TSxSwlw/7KnWRrvcpoC5NYCZyv5rMEprfIG6hXaKrdw?=
 =?us-ascii?Q?Z0JUncFofrLwnznUz8uBeUDROM/uciBDR+A4NRSgJbHn1+DkK2DOi/b8w52t?=
 =?us-ascii?Q?Wc5uHJre75Hl0SDeIwCIOwM33m5vbYiUwBv8Rp8ghgZsD+KubFuXzVyWTreH?=
 =?us-ascii?Q?LbfZrWHoNmaJZ6X3yTg2l6oHgzye4igdNslMKyMDZvi8jE4l9QW/TJvpN/+a?=
 =?us-ascii?Q?O1/HNbLSQeCBECAFkHctyXE3fzzF2+GNrQvosNCxjd7YXfCc/y5ucuLnuCAk?=
 =?us-ascii?Q?+TYXiw/XR5YWlaihl1NokgJHCvECXtWMQmmIsIELH2atKLB7UrtbspLoGPZE?=
 =?us-ascii?Q?8smse9TUD3hiG+wumcsSCv87mBDCUi15GJ2HCAEZOqqXW+ybAX7/cHafU0US?=
 =?us-ascii?Q?BmisVi9Mcet8s/yHZ+Vb9eeBvlm3RHTKRnMxQZJ9hKSYSnjh5mdtRmJv1mb9?=
 =?us-ascii?Q?mPDmuu4qTsvU3rLK/f7hfPSdMTJ2sXpbt3P8O7sLDrPuR4JLvBsWkXxZKMzn?=
 =?us-ascii?Q?ZYzjO2yAtpL1NpmkKJYxu/uLw9KKxaG+2yk6BCVOHrtFBwbHoXRycaivA2tQ?=
 =?us-ascii?Q?jIe6amIJcCvfwgY+L8ghbZ2XCRkQim8cK5oqxI0XUCc2eIDaj9P7FihAap+Y?=
 =?us-ascii?Q?GFLM/YizxqRGJRy9Tt+Oz/GiXdwzlUFu/5wCRNAqDP9jSqAczMspucBc22XD?=
 =?us-ascii?Q?8vXUQKwaa3+bbL2+nacycFELSkmhkpAWa7udNdYnNe7NMMlZxEHZ8L9HoZ+6?=
 =?us-ascii?Q?4zsp/GGL+5Vp53LndzZwd7lI6KLPYL5gb34KyxCnf06Q2j84rn4tuQ5G3Km6?=
 =?us-ascii?Q?YZJHqz/gGSkACTVzkkRJlrhf?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5358d4a5-416b-4ec7-93f6-08d905a4fcd1
X-MS-Exchange-CrossTenant-AuthSource: CY4PR12MB1463.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2021 15:40:42.5733 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FkywRHGdV8juX0JYVIURfafM6qlkMsFT1IAgnBRQPPKhlbYyvmYOX1iUPl7JgE6xgsDVpMxrI/B5yu0w6klhOw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1173
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
Cc: felix.kuehling@amd.com, Nirmoy Das <nirmoy.das@amd.com>,
 amd-gfx@lists.freedesktop.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Remove unused AMDGPU_GEM_CREATE_SHADOW flag.

Signed-off-by: Nirmoy Das <nirmoy.das@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.c | 5 +----
 include/uapi/drm/amdgpu_drm.h              | 2 --
 2 files changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
index 39f88e4a8eb5..da6d4ee0a132 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
@@ -649,8 +649,7 @@ int amdgpu_bo_create_shadow(struct amdgpu_device *adev,
 	memset(&bp, 0, sizeof(bp));
 	bp.size = size;
 	bp.domain = AMDGPU_GEM_DOMAIN_GTT;
-	bp.flags = AMDGPU_GEM_CREATE_CPU_GTT_USWC |
-		AMDGPU_GEM_CREATE_SHADOW;
+	bp.flags = AMDGPU_GEM_CREATE_CPU_GTT_USWC;
 	bp.type = ttm_bo_type_kernel;
 	bp.resv = bo->tbo.base.resv;
 	bp.bo_ptr_size = sizeof(struct amdgpu_bo);
@@ -685,7 +684,6 @@ int amdgpu_bo_create_user(struct amdgpu_device *adev,
 	struct amdgpu_bo *bo_ptr;
 	int r;
 
-	bp->flags = bp->flags & ~AMDGPU_GEM_CREATE_SHADOW;
 	bp->bo_ptr_size = sizeof(struct amdgpu_bo_user);
 	r = amdgpu_bo_create(adev, bp, &bo_ptr);
 	if (r)
@@ -1559,7 +1557,6 @@ u64 amdgpu_bo_print_info(int id, struct amdgpu_bo *bo, struct seq_file *m)
 	amdgpu_bo_print_flag(m, bo, NO_CPU_ACCESS);
 	amdgpu_bo_print_flag(m, bo, CPU_GTT_USWC);
 	amdgpu_bo_print_flag(m, bo, VRAM_CLEARED);
-	amdgpu_bo_print_flag(m, bo, SHADOW);
 	amdgpu_bo_print_flag(m, bo, VRAM_CONTIGUOUS);
 	amdgpu_bo_print_flag(m, bo, VM_ALWAYS_VALID);
 	amdgpu_bo_print_flag(m, bo, EXPLICIT_SYNC);
diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.h
index 8b832f7458f2..9169df7fadee 100644
--- a/include/uapi/drm/amdgpu_drm.h
+++ b/include/uapi/drm/amdgpu_drm.h
@@ -119,8 +119,6 @@ extern "C" {
 #define AMDGPU_GEM_CREATE_CPU_GTT_USWC		(1 << 2)
 /* Flag that the memory should be in VRAM and cleared */
 #define AMDGPU_GEM_CREATE_VRAM_CLEARED		(1 << 3)
-/* Flag that create shadow bo(GTT) while allocating vram bo */
-#define AMDGPU_GEM_CREATE_SHADOW		(1 << 4)
 /* Flag that allocating the BO should use linear VRAM */
 #define AMDGPU_GEM_CREATE_VRAM_CONTIGUOUS	(1 << 5)
 /* Flag that BO is always valid in this VM */
-- 
2.31.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
